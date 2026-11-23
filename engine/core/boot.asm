; Boot, cold/soft reset, engine initialization, main loop entry, and opening logo setup;
; the reset signature and the code checksum at reset (see include/Checksums.h).

    .section InitEngineSection

      .al
      .xl

      rlInitEngineAndStartLogo ; 80/9CD6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Resets sprites/decomp/blockcopy/VBlank hooks, registers all 5 core engines, clears GameStates, jumps to rsSetupOpeningLogoScreen

        sep #$30
        stz $4200,b
        stz bBufferNMITIMEN
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        stz wNextFreeSpriteOffset,b
        stz $1E22,b
        jsl rlClearSpriteExtBuffer
        jsl rlHideSprites
        rep #$30
        jsl rlResetDecompList
        jsr rsInitBlockCopyRAMStubs
        jsl rlResetVBlankHookTable
        lda #(`aProcEngineMainProcActionTable)<<8
        sta lR44+1
        lda #<>aProcEngineMainProcActionTable
        sta lR44
        jsl rlRegisterVBlankHook
        lda #(`aActiveSpriteEngineMainActionTable)<<8
        sta lR44+1
        lda #<>aActiveSpriteEngineMainActionTable
        sta lR44
        jsl rlRegisterVBlankHook
        lda #(`aHDMAEngineMainActionTable)<<8
        sta lR44+1
        lda #<>aHDMAEngineMainActionTable
        sta lR44
        jsl rlRegisterVBlankHook
        lda #(`aIRQEngineMainActionTable)<<8
        sta lR44+1
        lda #<>aIRQEngineMainActionTable
        sta lR44
        jsl rlRegisterVBlankHook
        lda #(`aEventEngineMainActionTable)<<8
        sta lR44+1
        lda #<>aEventEngineMainActionTable
        sta lR44
        jsl rlRegisterVBlankHook
        stz wGameStateRoutine2,b
        stz wGameStateRoutine1,b
        jml rsSetupOpeningLogoScreen

        .databank 0

        ; 80/9D4F

    .endsection InitEngineSection


    .section Unsorted808D56Section

      .al
      .xl

      rlReset ; 80/8D56

        ; The reset vector ($00/FFFC) points here. Switches the CPU to native mode
        ; and jumps on into rlBootInitAndCheckHardware in bank $80, checking on the way that
        ; the reset vector still points at this routine. Part of the code that the
        ; checksums in include/Checksums.h cover.
        .as
        .xs
        .autsiz
        .databank ?

        sei
        clc
        xce
        bcc rlBootInitAndCheckHardware
        rep #$30
        tdc
        bne rlBootInitAndCheckHardware
        ldx #<>rlReset
        cpx $FFFC,b
        bne rlBootInitAndCheckHardware
        jml rlBootInitAndCheckHardware

        .databank 0

        ; 80/8D6C

    .endsection Unsorted808D56Section


    .section Unsorted808D6CSection

      .al
      .xl

      rlBootInitAndCheckHardware ; 80/8D6C

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        ; Cold boot: inits SP/FastROM, scans WRAM for copier hooks, runs checksum (rlCheckCodeChecksumsAtReset), stamps "ELM0"; falls through into rlColdResetClearMemory

        rep #$30
        tsx
        txy
        ldx #$1FF7
        txs
        sep #$20
        lda #$01
        sta $420D,b
        lda #$80
        sta $2100,b
        stz $4200,b
        stz $420B,b
        stz $420C,b
        rep #$30
        lda $1FFC,b
        cmp #$4C45
        bne _8D9B
        lda $1FFE,b
        cmp #$304D
        beq _8DC3

        _8D9B
        dec y
        lda $0000,b,y
        inc a
        cmp $FFFC,b
        beq _8DCA
        ldx #$0000

        _8DA8
        lda $0000,b,x
        and #$00FF
        cmp #$006C
        beq _8DD2
        cmp #$004C
        beq _8DE9
        cmp #$0060
        beq _8DF3

        _8DBD
        inc x
        cpx #$1FFE
        bne _8DA8

        _8DC3
        phk
        phk
        pla
        beq _8DCA
        bra _8E13


        _8DCA
        lda #$0000
        tcd
        jsl rlCheckResetSignature._803E

        _8DD2
        ldy $0001,b,x
        cpy #$FFFC
        beq _8DCA
        cpy #$1FFF
        bcs _8DBD
        lda $0000,b,y
        cmp #<>rlReset
        beq _8DCA
        bra _8DBD


        _8DE9
        ldy $0001,b,x
        cpy #<>rlReset
        beq _8DCA
        bra _8DBD


        _8DF3
        txa
        tcd
        ldy #$0000
        lda #$6160

        _8DFB
        cmp $0000,b,x
        bne _8E0F
        clc
        adc #$0202
        inc x
        inc x
        inc y
        inc y
        cpy #$0020
        bne _8DFB
        bra _8DCA


        _8E0F
        tdc
        tax
        bra _8DBD


        _8E13
        lda #$0000
        tcd
        jsl rlCheckCodeChecksumsAtReset
        sta $1FF8,b
        sta $1FFA,b
        lda #$4C45
        sta $1FFC,b
        lda #$304D
        sta $1FFE,b

        .databank 0

        ; 80/8E2D

    .endsection Unsorted808D6CSection


    .section Unsorted808E2DSection

      .as
      .xl

      rlColdResetClearMemory ; 80/8E2D

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears banks $7E/$7F and VRAM, inits PPU/sound/joypad repeat/vectors, jumps to rlMainLoop

        pea #$7E00
        plb
        .databank ?
        plb
        .databank ?
        ldx #$1FF6

        _8E35
        stz $0000,b,x
        dec x
        dec x
        bpl _8E35
        ldx #$1FFE

        _8E3F
        stz $2000,b,x
        stz $4000,b,x
        stz $6000,b,x
        stz $8000,b,x
        stz $A000,b,x
        stz $C000,b,x
        stz $E000,b,x
        dec x
        dec x
        bpl _8E3F
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        ldx #$1FFE

        _8E60
        stz $0000,b,x
        stz $2000,b,x
        stz $4000,b,x
        stz $6000,b,x
        stz $8000,b,x
        stz $A000,b,x
        stz $C000,b,x
        stz $E000,b,x
        dec x
        dec x
        bpl _8E60
        phk
        plb
        .databank $80
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8000
        sta $4303,b
        lda #$8E93
        sta $4302,b
        lda #$0000
        sta $4305,b
        stz $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        jsr rsInitPPURegisters
        jsl rlInitSound
        jsl rlCheckCodeChecksumsAtReset
        lda #$0028
        sta wJoyRepeatDelay
        lda #$000A
        sta wJoyRepeatInterval
        lda #<>rsDefaultVBlankRoutine
        sta wVBlankPointer
        lda #<>rsDefaultIRQRoutine
        sta wIRQPointer
        lda #<>rlInitEngineAndStartLogo
        sta wMainLoopPointer
        jml rlMainLoop

        .databank 0

        ; 80/8ECC

      rlSoftReset ; 80/8ECC

        .al
        .xl
        .autsiz
        .databank ?

        ; Resets SP/display/NMI/DMA/HDMA and jumps to rlColdResetClearMemory

        rep #$30
        ldx #$1FF7
        txs
        sep #$20
        lda #$80
        sta $2100,b
        stz $4200,b
        stz $420B,b
        stz $420C,b
        rep #$30
        jml rlColdResetClearMemory

        .databank 0

        ; 80/8EE8

      rlMainLoopWaitForVBlank ; 80/8EE8

        .al
        .xl
        .autsiz
        .databank ?

        ; Halts until VBlank via rlHaltUntilVBlank then falls through into rlMainLoop

        rep #$30
        jsl rlHaltUntilVBlank

      rlMainLoop ; 80/8EEE

        .al
        .xl
        .autsiz
        .databank ?

        ; Pushes return-to-rlMainLoopWaitForVBlank and jumps indirect via wMainLoopPointer

        rep #$30
        pea #<>rlMainLoopWaitForVBlank - 1
        jmp (wMainLoopPointer)

        .databank 0

        ; 80/8EF6

    .endsection Unsorted808E2DSection


    .section Unsorted80AD24Section

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
        jsl rlUnknown9BFBC0
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

    .endsection Unsorted80AD24Section


    .section Unsorted80AE25Section

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
        jsl rlUnknown858728
        jsl rlUpdateSound
        rts

        .databank 0

        ; 80/AE63

    .endsection Unsorted80AE25Section


    .section Unsorted878017Section

      .al
      .xl

      rlWriteResetSignature ; 87/8017

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies 128 bytes of code from $88/8888 into aSpriteExtBuffer, so a later rlCheckResetSignature can tell the RAM was not cleared.

        ldx #$0000

        _801A
        lda rlUploadMapRowAndColumn._8880+8,x
        sta @l aSpriteExtBuffer,x
        inc x
        inc x
        cpx #$0080
        bne _801A

        _8029
        rtl

        .databank 0

        ; 87/802A

      rlCheckResetSignature ; 87/802A

        .al
        .xl
        .autsiz
        .databank ?

        ; Compares $88/8888-$88/8907 with aSpriteExtBuffer. If any word differs (a cold start), writes the signature and returns. If all match, writes the SRAM anti-tamper mark and hangs (rlShowAntiTamperScreen); _8063 is the hang used when the mark is already there (rlShowAntiTamperScreenAgain).

        ldx #$0000

        _802D
        lda rlUploadMapRowAndColumn._8880+8,x
        cmp @l aSpriteExtBuffer,x
        bne rlWriteResetSignature._8029
        inc x
        inc x
        cpx #$0080
        bne _802D

        _803E
        jsl rlWriteResetSignature
        lda #$0000
        sta @l $001FFC
        sta @l $001FFE
        jsl rlGetAntiTamperMark
        cmp #SRAM_ANTI_TAMPER_MARK
        beq _8063
        lda #SRAM_ANTI_TAMPER_MARK
        jsl rlSetAntiTamperMark
        jsl rlShowAntiTamperScreen

        _8061
        bra _8061


        _8063
        lda #$0000
        sta @l $001FFC
        sta @l $001FFE
        jsl rlShowAntiTamperScreenAgain

        _8072
        bra _8072

        .databank 0

        ; 87/8074

      rlCheckCodeChecksumsAtReset ; 87/8074

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        ; Runs rlCheckResetSignature, then, if the checks are on, adds up $80/8D56-8E2C and compares the sum with aCodeChecksumsCopy87; a mismatch hangs, a match clears the anti-tamper mark.

        phb
        php
        phk
        plb
        .databank $87
        phx
        jsl rlCheckResetSignature
        lda @l aCodeChecksumsCopy87.ChecksEnabled
        beq _809B
        lda #$0000
        ldx #<>rlReset

        _8089
        clc
        adc $800000,x
        inc x
        inc x
        cpx #<>rlColdResetClearMemory
        bcc _8089
        cmp @l aCodeChecksumsCopy87.Bank80Sum
        bne _80A6

        _809B
        lda #$0000
        jsl rlSetAntiTamperMark
        plx
        plp
        plb
        .databank ?
        rtl


        _80A6
        jsl rlCheckResetSignature._8063

        .databank 0

        ; 87/80AA

    .endsection Unsorted878017Section


