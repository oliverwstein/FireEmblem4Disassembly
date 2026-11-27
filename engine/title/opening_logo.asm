; The opening logo screen (game states $01-$03): its setup from boot, its VBlank,
; loading its graphics, and its two steps (the flash, then the fade to the title).

    .section SetupOpeningLogoScreenSection

      .as
      .xl

      rsSetupOpeningLogoScreen ; 80/AD24

        .al
        .xl
        .autsiz
        .databank ?

        ; Initializes hardware/options/units/events/RNG/opening logo, sets GameStates (2, 1) and rsOpeningLogoVBlank

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #$000A
        sta wJoyRepeatDelay
        lda #$0006
        sta wJoyRepeatInterval
        lda #$0000
        jsl rlFillBG2Page0TilemapBuffer
        lda #$030F
        jsl rlFillBG2Page1TilemapBuffer
        lda #$00FF
        jsl rlFillBG3Page0TilemapBuffer
        lda #$0000
        sta wR1
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$5000
        sta wR6
        lda #$5400
        sta wR7
        lda #$5800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlEnableActiveSpriteEngine
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlResetRAMStructAndAreaVariables
        jsl rlInitMapMenus
        jsl rlResetMenuOptionStack
        lda #$00FF
        sta wMapMenuTransparentTile,b
        jsl rlInitializeUnitRAM
        jsl rlInitiateChapterEventRAMData
        jsl rlClearAIEngineRAM
        jsl rlInitRNArray
        jsl rlLoadLastUsedOptions
        jsl rlGetSoundOption
        cmp #$0001
        bne _ADD0
        sep #$20
        lda bSoundFlags,b
        ora #$40
        sta bSoundFlags,b
        rep #$20

        _ADD0
        lda #$00C0
        jsl rlQueueSoundCommand
        jsl rlLoadOpeningLogoScreen
        jsl rlResetChapterProgress
        lda #GAMESTATE_OPENING_LOGO_UPKEEP
        sta wGameStateRoutine2,b
        lda #GAMESTATE_OPENING_LOGO_SETUP
        sta wGameStateRoutine1,b
        stz wGameStateStep,b
        lda #<>rsOpeningLogoVBlank
        sta wVBlankPointer
        lda #<>rsRunFrameTasks
        sta wMainLoopPointer
        jsl rlEnableVBlank
        plp
        cli
        rts

        .databank 0

        ; 80/ADFF

        ; Unreachable: it follows a return.
        plp
        rtl

      rlQueueDecompDMA80AE10Unused ; 80/AE01

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: queues decompression DMA entry aOpeningLogoDecompDMAUnused

        ; Unreferenced: queues the decompression DMA entry aOpeningLogoDecompDMAUnused.

        lda #(`aOpeningLogoDecompDMAUnused)<<8
        sta lR19+1
        lda #<>aOpeningLogoDecompDMAUnused
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rtl

        .databank 0

        ; 80/AE10

      aOpeningLogoDecompDMAUnused ; 80/AE10

        ; Read only by the unreferenced rlQueueDecompDMA80AE10Unused.

        .byte $00, $18, $00, $40, $01, $2B, $0A, $C0

      rlSetTMAndBGModeUnused80AE18 ; 80/AE18

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: sets bBufferTM=$16 and bBufferBGMODE=$09

        ; Unreferenced.

        sep #$20
        lda #$16
        sta bBufferTM
        lda #$09
        sta bBufferBGMODE
        rep #$20
        rtl

        .databank 0

        ; 80/AE25

    .endsection SetupOpeningLogoScreenSection

    .section OpeningLogoVBlankSection

      .al
      .xl

      rsOpeningLogoVBlank ; 80/AE25

        .al
        .xl
        .autsiz
        .databank ?

        ; VBlank routine during opening logo screen

        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlSendSoundQueuesToAPU
        jsl rlGetJoypadInput
        jsl rlIncreaseFrameCounters
        jsl rlClearSpriteExtBuffer
        jsl rlRunGameStateRoutines
        jsl rlRunVBlankHooks
        jsl rlHideSprites
        jsl rlRunMapMenuUploadIfEnabled
        jsl rlUpdateSound
        rts

        .databank 0

        ; 80/AE63

    .endsection OpeningLogoVBlankSection

    .section OpeningLogoStatesSection

      .al
      .xl


      rlOpeningLogoUpkeep ; 86/8010

        .al
        .autsiz
        .databank ?

        ; Game state routine $01, every frame during the opening: does nothing.

        rtl

        .databank 0

      rlOpeningLogoSetup ; 86/8011

        .al
        .autsiz
        .databank ?

        ; Game state routine $02, once: if Start is held, resets procs and fades to rsSetupSaveSelectMenu (game state 0 meanwhile); otherwise moves on to $03 at step 0.

        stz $1753,b

        lda wJoy1Input
        bit #JOY_Start
        bne +

          inc wGameStateRoutine1,b
          stz wGameStateStep,b
          rtl
    
        +
        jsl rlProcEngineResetProcEngine
        stz wGameStateRoutine1,b

        lda #<>rsSetupSaveSelectMenu
        sta aProcSystem.wInput0,b

        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlOpeningLogoStep ; 86/803E

        .al
        .autsiz
        .databank ?

        ; Game state routine $03, every frame: runs step 0 or 1 from aOpeningLogoSteps (a higher step hangs).

        lda wGameStateStep,b
        cmp #2
        bmi +
        
          -
          bra -

        +
        asl a
        tax
        jsr (aOpeningLogoSteps,x)
        rtl

        .databank 0

      aOpeningLogoSteps ; 86/804E

        .addr rsOpeningLogoRunFlash
        .addr rsOpeningLogoFadeToTitle

      rsOpeningLogoRunFlash ; 86/8052

        .al
        .autsiz
        .databank ?

        ; Runs rlFlashToTitleScreen and advances wGameStateStep on carry set

        jsl rlFlashToTitleScreen
        bcs +

          rts

        +
        inc wGameStateStep,b
        rts

        .databank 0

      rsOpeningLogoFadeToTitle ; 86/805D

        .al
        .autsiz
        .databank ?

        ; Resets proc engine and fades to rsOpenTitleScreen

        jsl rlProcEngineResetProcEngine
        stz wGameStateRoutine1,b

        lda #<>rsOpenTitleScreen
        sta aProcSystem.wInput0,b

        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .databank 0

    .endsection OpeningLogoStatesSection

    .section LoadOpeningLogoScreenSection

      .al
      .xl

      rlLoadOpeningLogoScreen ; 9B/FBC0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda #$00
        sta $7FD000
        lda #$01
        sta bBufferTM
        sta bBufferBGMODE
        sta bBufferOBSEL
        lda #$10
        sta bBufferBG1SC
        rep #$20
        jsl rlSetDemoIndexFromRanking
        jsl rlGetHighestCompletionCount
        cmp #$0010
        bcc _FBE7
        lda #$000F

        _FBE7
        sta wDemoBattlePair,b
        stz aBGPaletteBuffer,b
        lda #$0000
        sta $7FD001
        stz wBufferBG1HOFS
        stz wBufferBG1VOFS
        sep #$20
        rep #$10
        ldx #<>g4bppcOpeningLogoTiles
        stx DecompressionVariables
        lda #`g4bppcOpeningLogoTiles
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0820, $80, $0000

        sep #$20
        rep #$10
        ldx #<>acOpeningLogoSubTiles
        stx DecompressionVariables
        lda #`acOpeningLogoSubTiles
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0060, $80, $4000

        sep #$20
        rep #$10
        ldx #<>acOpeningLogoTilemap
        stx DecompressionVariables
        lda #`acOpeningLogoTilemap
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0700, $80, $2000

        ldx #$0000

        _FC76
        lda aOpeningLogoPalette1,x
        sta $0122,b,x
        lda aOpeningLogoPalette2,x
        sta $0222,b,x
        inc x
        inc x
        cpx #$001E
        bcc _FC76
        plx
        rtl

        .databank 0

        ; 9B/FC8D

    .endsection LoadOpeningLogoScreenSection

    .section OpeningLogoPalette1Section

      .al
      .xl

      aOpeningLogoPalette1 ; E0/283F

        ; Read by rlLoadOpeningLogoScreen.

        .word $7FFF, $637C, $6739, $435E, $2F1D, $42B8, $4631, $2A33
        .word $15D2, $096F, $00EA, $00A7, $0443, $0421, $0400

        ; E0/285D

    .endsection OpeningLogoPalette1Section

    .section DataE0285DSection

      .al
      .xl

      aOpeningLogoPalette2 ; E0/285D

        ; Read by rlLoadOpeningLogoScreen.

        .word $7FFF, $77BD, $6F7B, $6739, $5AD6, $5294, $4A52, $4210
        .word $39CE, $318C, $294A, $1CE7, $14A5, $0C63, $0421

        ; E0/287B

    .endsection DataE0285DSection
