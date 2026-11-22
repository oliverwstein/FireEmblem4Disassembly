; Game Over screen graphics setup and main-loop transition.


    .section Unsorted80B1E1Section

      .as
      .xl

      rsSetupGameOverScreen ; 80/B1E1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses Game Over assets, spawns procUnknown87C5A2 ("GO"), switches to rsMapVBlank + rsMapMainLoop

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
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
        jsl rlClearSpriteExtBuffer
        jsl rlHideSprites
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlResetRAMStructAndAreaVariables
        jsl rlInitMapMenus
        sep #$20
        rep #$10
        ldx #<>gcUnknownC02B6B
        stx DecompressionVariables
        lda #`gcUnknownC02B6B
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0DC0, $80, $0000

        sep #$20
        rep #$10
        ldx #<>gcUnknownC03455
        stx DecompressionVariables
        lda #`gcUnknownC03455
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $A000

        sep #$20
        rep #$10
        ldx #<>gcUnknownC03558
        stx DecompressionVariables
        lda #`gcUnknownC03558
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $A800

        stz wBufferBG1HOFS
        stz wBufferBG1VOFS
        stz wBufferBG2HOFS
        stz wBufferBG2VOFS
        sep #$20
        lda #$03
        sta bBufferTM
        rep #$20
        lda #(`procUnknown87C5A2)<<8
        sta lR44+1
        lda #<>procUnknown87C5A2
        sta lR44
        jsl rlProcEngineCreateProc
        lda #<>rsMapVBlank
        sta wVBlankPointer
        lda #<>rsMapMainLoop
        sta wMainLoopPointer
        stz wGameStateRoutine2,b
        stz wGameStateRoutine1,b
        stz wGameStateStep,b
        sep #$20
        lda #$00
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlEnableVBlank
        plp
        cli
        rts

        .databank 0

        ; 80/B301

    .endsection Unsorted80B1E1Section


