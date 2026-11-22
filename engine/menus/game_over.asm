; The game over screen: its graphics setup and main-loop transition, and procGameOver
; (the palette, the shake, and Start or a long wait to soft-reset).


    .section Unsorted80B1E1Section

      .as
      .xl

      rsSetupGameOverScreen ; 80/B1E1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses Game Over assets, spawns procGameOver ("GO"), switches to rsMapVBlank + rsMapMainLoop

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
        lda #(`procGameOver)<<8
        sta lR44+1
        lda #<>procGameOver
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


    .section GameOverProcSection

      .al
      .xl

      procGameOver ; 87/C5A2

        .structProcInfo "GO", rlProcGameOverInit, rlProcGameOverCycle, aProcGameOverCode

        ; 87/C5AA

    .endsection GameOverProcSection


    .section Unsorted87C5AASection

      .al
      .xl

      rlProcGameOverInit ; 87/C5AA

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads the palettes (aGameOverPaletteData) and starts music $72.

        lda #(`aGameOverPaletteData)<<8
        sta lR19+1
        lda #<>aGameOverPaletteData
        sta lR19
        jsl rlApplyMapMenuPaletteData
        lda #$0072
        sta wMusicID,b
        rtl

        .databank 0

        ; 87/C5BF

    .endsection Unsorted87C5AASection


    .section Table87C5BFSection

      .al
      .xl

      aGameOverPaletteData .dstruct structMapMenuPaletteData, $0040, 0, 0, aGameOverPalettes ; 87/C5BF

      aGameOverPalettes ; 87/C5C6
        .word $0000, $1CE7, $1DFE, $02FD, $03BC, $3BBD, $63BD, $77FF
        .word $7FFF, $63FB, $0955, $01B1, $0272, $42B5, $0C63, $35AD
        .word $3000, $1042, $1463, $1463, $1463, $1463, $1463, $1463
        .word $1463, $1463, $1463, $1463, $1463, $1463, $0C63, $1463
        .word $3000, $1CE7, $0C63, $2E4F, $3229, $25A7, $63BD, $77FF
        .word $7FFF, $639B, $5F7A, $5337, $4715, $4AEF, $3A4C, $35AD
        .word $7FFF, $1042, $0C63, $1463, $1463, $1463, $1463, $1463
        .word $1463, $1463, $1463, $1463, $1463, $1463, $1463, $1463

    .endsection Table87C5BFSection


    .section Unsorted87C646Section

      .al
      .xl

      rlProcGameOverCycle ; 87/C646

        .al
        .xl
        .autsiz
        .databank ?

        ; Shakes BG2 (rsGameOverShake); once faded in, Start soft-resets the game. The script also resets after 1,020 frames.

        jsr rsGameOverShake
        lda bBufferINIDISP
        bit #$0080
        bne _C65F
        eor #$FFFF
        bit #$000F
        bne _C65F
        lda wJoy1New
        bit #$1000
        bne _C660

        _C65F
        rtl


        _C660
        jsl rlProcEngineFreeProc
        sep #$20
        lda #$80
        sta $2100,b
        lda #$01
        sta $4200,b
        sta bBufferNMITIMEN
        stz bDMAPendingChannels,b
        stz bHDMAPendingChannels,b
        stz bBufferHDMAEN
        stz bDMAArrayFlag,b
        rep #$20
        stz wDMAArrayPosition,b
        jml rlSoftReset

        .databank 0

      aProcGameOverCode ; 87/C686

        PROC_YIELD 32
        PROC_CALL rlGameOverFadeIn
        PROC_YIELD 1020
        PROC_SET_ONCYCLE rlProcGameOverCycle._C660
        PROC_HALT

        ; 87/C695

    .endsection Unsorted87C646Section


    .section Unsorted87C695Section

      .al
      .xl

      rlGameOverFadeIn ; 87/C695

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0006
        sta wScreenFadingProcInput,b
        lda #(`procFadeInByScreenFadingTimer)<<8
        sta lR44+1
        lda #<>procFadeInByScreenFadingTimer
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 87/C6AA

      rsGameOverShake ; 87/C6AA

        .al
        .xl
        .autsiz
        .databank ?

        ; aBody0 counts frames; from frame $84 on, sets BG2's scroll from the pairs in aGameOverShakeOffsets until a 0.

        phy
        txy
        lda aProcSystem.aBody0,b,x
        bmi _C6DA
        sec
        sbc #$0084
        bcc _C6D7
        phx
        asl a
        tax
        lda <>aGameOverShakeOffsets,b,x
        bne _C6C6
        dec a
        sta aProcSystem.aBody0,b,y
        plx
        bra _C6DA


        _C6C6
        lda <>aGameOverShakeOffsets,b,x
        ora #$FF80
        sta wBufferBG2HOFS
        lda <>aGameOverShakeOffsets+1,b,x
        ora #$FF80
        sta wBufferBG2VOFS
        plx

        _C6D7
        inc aProcSystem.aBody0,b,x

        _C6DA
        ply
        rts

        .databank 0

        ; 87/C6DC

      aGameOverShakeOffsets ; 87/C6DC

        ; BG2's horizontal and vertical scroll for each frame of the shake, as low
        ; bytes (rsGameOverShake sets the high bits); a 0 ends it.
        .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FE, $FF, $FE, $FF, $FE, $FE, $FD, $FE, $FD
        .byte $FE, $FD, $FE, $FC, $FE, $FC, $FE, $FC, $FD, $FB, $FD, $FB, $FD, $FB, $FD, $FA
        .byte $FD, $FA, $FD, $FA, $FC, $F9, $FC, $F9, $FC, $F9, $FC, $F8, $00, $00

    .endsection Unsorted87C695Section


