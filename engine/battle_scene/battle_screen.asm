; Battle scene and map-battle VBlank handlers, main loops, and screen setup; the
; window wipe into a battle (aBattleTransitionHDMAInfo).

    .section BattleSceneVBlankSection

      .al
      .xl

      rsRunBattleSceneVBlank ; 80/BF40

        .al
        .xl
        .autsiz
        .databank ?

        ; Battle scene VBlank running battle procs, DMA/OAM/HDMA/PPU, APU, $7FFC77 check, sprites, sound

        php
        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlBattleSceneRunUploads
        jsl rlBattleSceneToggleOAMExtBuffer
        jsl rlBattleSceneBuildGradientWindowHDMA
        jsl rlBattleSceneRunQueuedCopies
        jsl rlUnknown96EB1E
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlSendSoundQueuesToAPU
        jsl rlGetJoypadInput
        jsl rlIRQEngineSyncAndSort
        lda $7FFC77
        bit #$0001
        beq _BF89
        jsl rlBattleSceneVBlankCopyOAMExt
        bra _BF8D


        _BF89
        jsl rlClearSpriteExtBuffer

        _BF8D
        sep #$20
        lda #$00
        sta $7FE1CF
        rep #$20
        jsl rlRunGameStateRoutines
        jsl rlRunVBlankHooks
        jsl rlHideSprites
        jsl rlUpdateSound
        plp
        rts

        .databank 0

        ; 80/BFA9

    .endsection BattleSceneVBlankSection


    .section OpenBattleSceneSection

      .al
      .xl

      rsOpenBattleScene ; 80/BFFB

        .al
        .xl
        .autsiz
        .databank ?

        ; Resets engines/battle scene (game state $18), installs rsRunBattleSceneVBlank and rsRunBattleSceneMainLoop

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlBattleAnimationResetSlots
        jsl rlBattleSceneClearCombatants
        jsl rlBattleSceneClearQueuedCopies
        lda #$0000
        sta wBattleAnimationAttackerOffset,b
        lda #$0043
        sta wBattleAnimationDefenderOffset,b
        sep #$20
        lda #$18
        sta $0B06,b
        sta $0B49,b
        rep #$20
        jsl rlBattleSceneInit
        lda #(`aUnknown968095)<<8
        sta lR44+1
        lda #<>aUnknown968095
        sta lR44
        jsl rlIRQEngineCreateEntry
        lda #(`aUnknown968000)<<8
        sta lR44+1
        lda #<>aUnknown968000
        sta lR44
        jsl rlIRQEngineCreateEntry
        lda #(`aUnknown96800F)<<8
        sta lR44+1
        lda #<>aUnknown96800F
        sta lR44
        jsl rlIRQEngineCreateEntry
        lda #(`aUnknown968050)<<8
        sta lR44+1
        lda #<>aUnknown968050
        sta lR44
        jsl rlIRQEngineCreateEntry
        lda #(`aUnknown968078)<<8
        sta lR44+1
        lda #<>aUnknown968078
        sta lR44
        jsl rlIRQEngineCreateEntry
        jsl rlEnableIRQEngine
        lda #GAMESTATE_BATTLE_SCENE_SETUP
        sta wGameStateRoutine1,b
        lda #<>rsRunBattleSceneVBlank
        sta wVBlankPointer
        lda #<>rsRunBattleSceneMainLoop
        sta wMainLoopPointer
        stz wGameStateRoutine2,b
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        plp
        jsl rlBattleSceneVBlankNoOp
        cli
        rts

        .databank 0

        ; 80/C0B6

    .endsection OpenBattleSceneSection


    .section BattleSceneMainLoopSection

      .al
      .xl

      rsRunBattleSceneMainLoop ; 80/C144

        .al
        .xl
        .autsiz
        .databank ?

        ; Battle scene main loop: reset check, decompression list, deferred sound upload, rlBattleSceneBuildArenaBout

        jsl rlButtonCombinationResetCheck
        jsl rlDecompressByList
        jsl rlRunDeferredSoundUpload
        jsl rlBattleSceneBuildArenaBout
        rts

        .databank 0

        ; 80/C155

    .endsection BattleSceneMainLoopSection


    .section Unsorted87C38CSection

      aBattleTransitionHDMAInfo ; 87/C38C

        ; Created by rlStartBattleScene. Writes WH0 indirectly from the buffer at
        ; $7E8B92, which rsBuildBattleTransitionWindow fills from aBattleTransitionShape.
        .structHDMAIndirectEntryInfo rlBattleTransitionHDMAInit, rlBattleTransitionHDMACycle, aBattleTransitionHDMACode, aBattleTransitionHDMATableEven, WH0, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode0), $7E

      .al
      .xl

      rlBattleTransitionHDMAInit ; 87/C398

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFE0
        sta $7E8B88
        lda #$0000
        sta $7E8B8A
        lda #$0010
        sta $7E8B8C
        lda #$0000
        sta $7E8B90
        jsr rsPlayBattleTransitionSound
        lda #$0000
        jsr rsBuildBattleTransitionWindow
        lda #$0064
        jsr rsBuildBattleTransitionWindow
        rtl

        .databank 0

        ; 87/C3C4

      rlBattleTransitionHDMACycle ; 87/C3C4

        .al
        .xl
        .autsiz
        .databank ?

        ; Closes the window a step each frame (two buffers, alternating) until it is shut.

        lda wVBlankEnabledFramecount
        bit #$0001
        bne _C3D7
        lda #$0000
        sta $7E8B8E
        lda #<>aBattleTransitionHDMATableEven
        bra _C3E1


        _C3D7
        lda #$0100
        sta $7E8B8E
        lda #<>aBattleTransitionHDMATableOdd

        _C3E1
        sta aHDMASystem.aOffset,b,x
        lda $7E8B8E
        jsr rsBuildBattleTransitionWindow
        lda $7E8B8A
        clc
        adc #$4000
        sta $7E8B8A
        lda $7E8B8C
        adc #$0000
        sta $7E8B8C
        lda $7E8B88
        clc
        adc $7E8B8C
        sta $7E8B88
        cmp #$0100
        bmi _C41A
        lda #<>rlBattleTransitionOpenBattle
        sta aHDMASystem.aOnCycle,b,x

        _C41A
        rtl

        .databank 0

        ; 87/C41B

    .endsection Unsorted87C38CSection


    .section Unsorted87C41BSection

      .al
      .xl

      rlBattleTransitionOpenBattle ; 87/C41B

        .al
        .xl
        .autsiz
        .databank ?

        ; Once the music is ready: installs rsOpenBattleScene and frees the HDMA entry.

        lda wMusicID,b
        bne _C43F
        lda bAPUStatus,b
        bit #$0030
        bne _C43F
        lda #<>rsOpenBattleScene
        sta wMainLoopPointer
        sei
        sep #$20
        lda bBufferNMITIMEN
        and #$CF
        sta bBufferNMITIMEN
        sta $4200,b
        rep #$20
        jsl rlHDMAEngineFreeEntryByOffset

        _C43F
        rtl

        .databank 0

      aBattleTransitionHDMACode ; 87/C440

        HDMA_HALT

        ; 87/C442

    .endsection Unsorted87C41BSection


    .section Unsorted87C442Section

      .al
      .xl

      rsBuildBattleTransitionWindow ; 87/C442

        .al
        .xl
        .autsiz
        .databank ?

        ; A = step: fills the WH0 buffer at $7E8B92 from aBattleTransitionShape.

        phx
        clc
        adc #$00EF
        tax
        ldy #$00EF

        _C44B
        lda <>aBattleTransitionShape,b,y
        and #$00FF
        clc
        adc $7E8B88
        cmp #$0008
        bmi _C465
        cmp #$00F8
        bcc _C468
        lda #$00F8
        bra _C468


        _C465
        lda #$0008

        _C468
        sep #$20
        eor $7E8B90
        sta $7E8B92,x
        rep #$20
        dec x
        dec y
        bpl _C44B
        plx
        rts

        .databank 0

        ; 87/C47A

      rsPlayBattleTransitionSound ; 87/C47A

        .al
        .xl
        .autsiz
        .databank ?

        lda wBattleStatus
        bit #$0001
        bne _C49C
        lda #$006D
        jsl rlPlaySoundEffect2
        lda #$00FF
        sta $7E8B90
        sep #$20
        lda #$27
        sta $1670,b,x
        rep #$20
        bra _C4A3


        _C49C
        lda #$006C
        jsl rlPlaySoundEffect2

        _C4A3
        rts

        .databank 0

      aBattleTransitionHDMATableEven ; 87/C4A4

        ; Indirect HDMA tables: 120 lines from each address in bank $7E.
        ; rlBattleTransitionHDMACycle switches between them every frame.
        .byte $F8
        .word $8B92
        .byte $F8
        .word $8C0A
        .byte $00

      aBattleTransitionHDMATableOdd ; 87/C4AB

        .byte $F8
        .word $8C92
        .byte $F8
        .word $8D0A
        .byte $00

      aBattleTransitionShape ; 87/C4B2

        ; 240 offsets, one per line, that rsBuildBattleTransitionWindow adds to $7E8B88.
        .byte $02, $03, $05, $07, $05, $03, $04, $05, $08, $06, $0A, $0C, $0A, $08, $04, $05
        .byte $06, $09, $0B, $0D, $0F, $12, $10, $0C, $0E, $0F, $0E, $0A, $0A, $0E, $10, $12
        .byte $0E, $0C, $08, $04, $03, $01, $00, $00, $04, $07, $0A, $0D, $0A, $08, $06, $06
        .byte $0A, $0E, $0F, $0C, $0A, $09, $0D, $10, $13, $11, $0D, $0A, $09, $08, $0C, $10
        .byte $14, $18, $13, $0E, $09, $06, $07, $09, $0A, $08, $0C, $0E, $12, $0E, $10, $14
        .byte $18, $12, $14, $16, $18, $1C, $19, $17, $15, $12, $17, $1B, $16, $12, $0E, $0A
        .byte $08, $06, $04, $08, $0A, $07, $03, $00, $02, $04, $08, $0C, $0A, $08, $0A, $0E
        .byte $0C, $0E, $10, $0C, $0A, $08, $0C, $10, $0E, $0C, $0A, $06, $04, $08, $06, $02
        .byte $04, $08, $0A, $06, $02, $00, $02, $04, $01, $03, $05, $04, $01, $00, $02, $06
        .byte $0A, $0E, $0C, $0D, $10, $0C, $08, $04, $02, $00, $03, $05, $07, $05, $03, $06
        .byte $09, $0C, $10, $14, $12, $0E, $0A, $06, $0A, $06, $0C, $10, $0C, $08, $04, $08
        .byte $06, $0A, $0C, $0A, $0E, $0C, $12, $10, $11, $0F, $0B, $07, $0A, $07, $0C, $11
        .byte $0E, $0B, $08, $03, $00, $02, $03, $05, $04, $07, $0A, $0E, $10, $0C, $10, $0C
        .byte $12, $0E, $10, $0C, $0A, $06, $02, $06, $0A, $08, $06, $0A, $0E, $0B, $0D, $0B
        .byte $07, $03, $02, $01, $00, $02, $03, $05, $07, $05, $03, $04, $05, $08, $0A, $04

    .endsection Unsorted87C442Section


