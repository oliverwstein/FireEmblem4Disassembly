; Battle scene and map-battle VBlank handlers, main loops, and screen setup.

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
        jsl rlUnknown95C368
        jsl rlUnknown969FD7
        jsl rlUnknown96D5DB
        jsl rlUnknown95A086
        jsl rlUnknown96EB1E
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlSendSoundQueuesToAPU
        jsl rlGetJoypadInput
        jsl rlUnknown82E147
        lda $7FFC77
        bit #$0001
        beq _BF89
        jsl rlUnknown969FEB
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

      rsRunMapBattleVBlank ; 80/BFA9

        .al
        .xl
        .autsiz
        .databank ?

        ; Map battle VBlank calling 95C368/96D5DB/9BEAB1, DMA/OAM/HDMA/PPU, APU, sprites, sound

        php
        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlUnknown95C368
        jsl rlUnknown96D5DB
        jsl rlUnknown9BEAB1
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlSendSoundQueuesToAPU
        jsl rlGetJoypadInput
        jsl rlUnknown82E147
        jsl rlClearSpriteExtBuffer
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

        ; 80/BFFB

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
        jsl rlUnknown95B96F
        jsl rlUnknown958AF0
        jsl rlUnknown95A0F7
        lda #$0000
        sta wBattleAnimationAttackerOffset,b
        lda #$0043
        sta wBattleAnimationDefenderOffset,b
        sep #$20
        lda #$18
        sta $0B06,b
        sta $0B49,b
        rep #$20
        jsl rlUnknown958000
        lda #(`aUnknown968095)<<8
        sta lR44+1
        lda #<>aUnknown968095
        sta lR44
        jsl rlUnknown82E0C6
        lda #(`aUnknown968000)<<8
        sta lR44+1
        lda #<>aUnknown968000
        sta lR44
        jsl rlUnknown82E0C6
        lda #(`aUnknown96800F)<<8
        sta lR44+1
        lda #<>aUnknown96800F
        sta lR44
        jsl rlUnknown82E0C6
        lda #(`aUnknown968050)<<8
        sta lR44+1
        lda #<>aUnknown968050
        sta lR44
        jsl rlUnknown82E0C6
        lda #(`aUnknown968078)<<8
        sta lR44+1
        lda #<>aUnknown968078
        sta lR44
        jsl rlUnknown82E0C6
        jsl rlUnknown82E08D
        lda #$0018
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
        jsl rlUnknown96892C
        cli
        rts

        .databank 0

        ; 80/C0B6

      rsOpenMapBattle ; 80/C0B6

        .al
        .xl
        .autsiz
        .databank ?

        ; Resets engines/map battle (game state $1A), installs rsRunMapBattleVBlank and rsRunMapBattleMainLoop

        php
        lda #$0000
        bra _C0C0

        .byte $08, $A9, $01, $00


        _C0C0
        sep #$20
        sta $7FD8B9
        rep #$20
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsl rlUnknown95F13C
        bcc _C0E7
        sep #$20
        lda #$01
        sta $7FD8B9
        rep #$20

        _C0E7
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlUnknown95EE73
        jsl rlUnknown95F0E9
        lda #(`aUnknown9680A4)<<8
        sta lR44+1
        lda #<>aUnknown9680A4
        sta lR44
        jsl rlUnknown82E0C6
        lda #(`aUnknown9680B3)<<8
        sta lR44+1
        lda #<>aUnknown9680B3
        sta lR44
        jsl rlUnknown82E0C6
        jsl rlUnknown82E08D
        lda #$001A
        sta wGameStateRoutine1,b
        lda #<>rsRunMapBattleVBlank
        sta wVBlankPointer
        lda #<>rsRunMapBattleMainLoop
        sta wMainLoopPointer
        stz wGameStateRoutine2,b
        jsl rlEnableVBlank
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        plp
        cli
        rts

        .databank 0

        ; 80/C144

      rsRunBattleSceneMainLoop ; 80/C144

        .al
        .xl
        .autsiz
        .databank ?

        ; Battle scene main loop: reset check, decompression list, deferred sound upload, rlUnknown969872

        jsl rlButtonCombinationResetCheck
        jsl rlDecompressByList
        jsl rlRunDeferredSoundUpload
        jsl rlUnknown969872
        rts

        .databank 0

        ; 80/C155

      rsRunMapBattleMainLoop ; 80/C155

        .al
        .xl
        .autsiz
        .databank ?

        ; Map battle main loop: reset check, decompression list, deferred sound upload

        jsl rlButtonCombinationResetCheck
        jsl rlDecompressByList
        jsl rlRunDeferredSoundUpload
        rts

        .databank 0

        ; 80/C162

    .endsection BattleSceneVBlankSection
