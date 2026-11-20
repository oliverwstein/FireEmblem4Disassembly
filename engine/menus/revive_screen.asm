; The revive staff's screen: rsReviveScreenOpen (installed as the main loop by a
; staff effect handler, rsUnknown87E855) builds the list of units that can be
; revived, or the message that no one has died, and hands over to game state
; routines $32 and $33, whose menu is in bank $89 (rsUnknown89AD00 and on). Bank
; $80 ($80/DFD3-E42B).

    .section ReviveScreenSection

      .al
      .xl

      aReviveScreenMenuTilemapEntry ; 80/DFD3

        ; Put in lMapMenuTilemapRAMEntryPointer, as aDataWindowMenuTilemapEntry.
        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E

      rsReviveScreenOpen ; 80/DFDC

        ; Main loop routine that opens the revive staff's screen (rsUnknown87E855
        ; installs it through procMainLoopChangeFade): resets the screen and the
        ; engines, builds the screen, then runs game state routines $32 and $33
        ; (the revive menu in bank $89). With no unit listed (wUnitWindowMaxRows),
        ; it starts at step 2 instead.

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$BB9B
        sta wVBlankPointer
        jsl rlHaltUntilVBlank
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #$3000
        sta wR1
        lda #$3000
        sta wR2
        lda #$0000
        sta wR3
        lda #$6000
        sta wR5
        lda #$1800
        sta wR6
        lda #$2000
        sta wR7
        lda #$2800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsr rsUnknown80E07A
        jsr rsUnknown80E0AE
        jsr rsUnknown80E15E
        jsr rsUnknown80E1AA
        lda wUnitWindowMaxRows
        bne _E055
        lda #$0002
        sta wGameStateStep,b
        lda #$0002
        sta wDebugMenuScreenIndex+1
        jsr rsUnknown80E258
        bra _E061


        _E055
        lda #$0000
        sta wGameStateStep,b
        jsr rsUnknown80E2F9
        jsr rsUnknown80E1B9

        _E061
        phk
        plb
        .databank $80
        lda #$0033
        sta wGameStateRoutine1,b
        lda #$0032
        sta wGameStateRoutine2,b
        lda #$9D4F
        sta wMainLoopPointer
        jsl rlEnableVBlank
        plp
        rts

        .databank 0

        ; 80/E07A

    .endsection ReviveScreenSection


    .section ReviveScreenBuildSection

      .al
      .xl

      rsUnknown80E07A ; 80/E07A

        .al
        .xl
        .autsiz
        .databank ?

        lda wDataWindowCurrentArmy
        cmp #$DFDC
        beq _E096
        lda wSelectedUnitDataRAMPointer,b
        sta $7FB016
        lda #$0000
        sta wUnitWindowCurrentHighlightLine
        jsr rsUnknown80E298
        bra _E096


        _E096
        lda #$0000
        sta $7FB014
        sta wDebugMenuScreenIndex+1
        lda #(`aReviveScreenMenuTilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aReviveScreenMenuTilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        rts

        .databank 0

        ; 80/E0AE


      rsUnknown80E0AE ; 80/E0AE

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM $DE44C0, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM $DD72B0, $0C00, $80, $7200

        lda #(`aUnknown80E13E)<<8
        sta lR19+1
        lda #<>aUnknown80E13E
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aUnknown80E146)<<8
        sta lR19+1
        lda #<>aUnknown80E146
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$0100

        _E0E7
        lda aUnknownDD7EAE,x
        sta wJoy2RepeatTimer,x
        dec x
        dec x
        bne _E0E7
        ldx #$001E

        _E0F4
        lda $DE00FE,x
        sta $01FE,b,x
        dec x
        dec x
        bne _E0F4
        ldx #$0020

        _E102
        lda $8C951E,x
        sta $021E,b,x
        dec x
        dec x
        bne _E102
        ldx #$0020

        _E110
        lda $8C95DE,x
        sta $027E,b,x
        dec x
        dec x
        bne _E110
        lda #$0000
        sta aBGPaletteBuffer,b
        lda #(`aUnknown80E14E)<<8
        sta lR19+1
        lda #<>aUnknown80E14E
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aUnknown80E156)<<8
        sta lR19+1
        lda #<>aUnknown80E156
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rts

        .databank 0

        ; 80/E13E


      aUnknown80E13E ; 80/E13E

        ; Entry for rlHandleMapMenuDecompressionDMA.
        .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $0000

      aUnknown80E146 ; 80/E146

        ; Entry for rlHandleMapMenuDecompressionDMA.
        .structDecompressionDMAEntry gcUnknownDD20A0, $1200, $3000

      aUnknown80E14E ; 80/E14E

        ; Entry for rlHandleMapMenuDecompressionDMA.
        .structDecompressionDMAEntry gcUnknownDD2CEE, $0700, $1800

      aUnknown80E156 ; 80/E156

        ; Entry for rlHandleMapMenuDecompressionDMA.
        .structDecompressionDMAEntry gcUnknownDD2D90, $0800, $2000

      rsUnknown80E15E ; 80/E15E

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$17
        sta bBufferTM
        lda #$02
        sta bBufferTS
        lda #$00
        sta bBufferTMW
        lda #$00
        sta bBufferTSW
        lda #$00
        sta bBufferW12SEL
        lda #$00
        sta bBufferW34SEL
        lda #$00
        sta bBufferWOBJSEL
        lda #$00
        sta bBufferWH0
        lda #$FF
        sta bBufferWH1
        lda #$00
        sta bBufferWH2
        sta bBufferWH3
        lda #$00
        sta bBufferWBGLOG
        sta bBufferWOBJLOG
        lda #$02
        sta bBufferCGWSEL
        lda #$51
        sta bBufferCGADSUB
        rep #$20
        stz wBufferBG1HOFS
        stz wBufferBG2HOFS
        stz wBufferBG3HOFS
        stz wBufferBG1VOFS
        stz wBufferBG2VOFS
        lda #$0001
        sta wBufferBG3VOFS
        rts

        .databank 0

        ; 80/E1AA


      rsUnknown80E1AA ; 80/E1AA

        .al
        .xl
        .autsiz
        .databank ?

        lda #$9100
        sta lR44+1
        lda #$E185
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rts

        .databank 0

        ; 80/E1B9


      rsUnknown80E1B9 ; 80/E1B9

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$010B
        jsl rlUnitWindowFillBG3Buffer
        lda #(`aReviveScreenWhomText)<<8
        sta lR18+1
        lda #<>aReviveScreenWhomText
        sta lR18
        ldx #$0203
        jsl rlDrawMenuTextLine
        ldx #$0000

        _E1DA
        lda aUnitWindowDeploymentSlots,x
        beq _E200
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitNamePointer
        phx
        lda aUnknown80E20E,x
        tax
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlDrawMenuTextLine
        plx
        inc x
        inc x
        bra _E1DA


        _E200
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $5000

        rts

        .databank 0

        ; 80/E20E


      aUnknown80E20E ; 80/E20E

        ; X and Y tile of each of the 24 list entries.
        .byte 4, 9
        .byte 14, 9
        .byte 24, 9
        .byte 4, 11
        .byte 14, 11
        .byte 24, 11
        .byte 4, 13
        .byte 14, 13
        .byte 24, 13
        .byte 4, 15
        .byte 14, 15
        .byte 24, 15
        .byte 4, 17
        .byte 14, 17
        .byte 24, 17
        .byte 4, 19
        .byte 14, 19
        .byte 24, 19
        .byte 4, 21
        .byte 14, 21
        .byte 24, 21
        .byte 4, 23
        .byte 14, 23
        .byte 24, 23

      aReviveScreenWhomText ; 80/E23E

        ; だれをいきかえらせますか (whom will you revive?)
        .enc "SJIS"
        .text "だれをいきかえらせますか\n"

      rsUnknown80E258 ; 80/E258

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$010B
        jsl rlUnitWindowFillBG3Buffer
        lda #(`aReviveScreenNobodyText)<<8
        sta lR18+1
        lda #<>aReviveScreenNobodyText
        sta lR18
        ldx #$0203
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $5000

        rts

        .databank 0

        ; 80/E284


      aReviveScreenNobodyText ; 80/E284

        ; だれもしんでません (no one has died)
        .enc "SJIS"
        .text "だれもしんでません\n"

      rsUnknown80E298 ; 80/E298

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        jsl rlGetFactionSlotUnitCount
        sta wUnitWindowMaxRows
        lda #$0000
        sta wRoutineVariable1,b
        sta wUnitWindowCurrentNameLine

        _E2AD
        lda wRoutineVariable1,b
        inc a
        sta wRoutineVariable1,b
        lda #$0000
        jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
        lda wSelectedUnitDataRAMPointer,b
        beq _E2E7
        jsl rlGetSelectedUnitStates
        bit #$0200
        beq _E2E5
        lda wUnitWindowCurrentNameLine
        tay
        asl a
        tax
        lda wSelectedUnitDataRAMPointer,b
        sta aUnitWindowDeploymentSlots,x
        jsl rlGetSelectedUnitMapSprite
        sta aUnitWindowEquippedWeaponPointers,x
        tya
        inc a
        sta wUnitWindowCurrentNameLine

        _E2E5
        bra _E2AD


        _E2E7
        lda wUnitWindowCurrentNameLine
        sta wUnitWindowMaxRows
        asl a
        tax
        lda #$0000
        sta aUnitWindowDeploymentSlots,x
        rts

        .databank 0

        ; 80/E2F9


      rsUnknown80E2F9 ; 80/E2F9

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000

        _E2FC
        sta wUnitWindowCurrentNameLine
        asl a
        tax
        lda aUnitWindowEquippedWeaponPointers,x
        bmi _E30D
        jsr rsUnknown80E31C
        bra _E310


        _E30D
        jsr rsUnknown80E39F

        _E310
        lda wUnitWindowCurrentNameLine
        inc a
        cmp wUnitWindowMaxRows
        bne _E2FC
        rts

        .databank 0

        ; 80/E31C


      rsUnknown80E31C ; 80/E31C

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitWindowCurrentNameLine
        asl a
        tax
        lda aUnitWindowEquippedWeaponPointers,x
        and #$7FFF
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $88D527,x
        sta lR18+1
        lda aUnknown88D526,x
        sta $07EA,b
        sta lR18
        lda #$0040
        sta wR0
        lda wUnitWindowCurrentNameLine
        asl a
        tax
        lda aUnknown80E36F,x
        sta wR1
        jsl rlDMAByPointer
        lda $07EA,b
        clc
        adc #$0040
        sta lR18
        lda #$0040
        sta wR0
        lda wR1
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        rts

        .databank 0

        ; 80/E36F


      aUnknown80E36F ; 80/E36F

        ; A VRAM address for each of the 24 list entries.
        .word $6200, $6220, $6240, $6260, $6280, $62A0, $62C0, $62E0
        .word $6400, $6420, $6440, $6460, $6480, $64A0, $64C0, $64E0
        .word $6600, $6620, $6640, $6660, $6680, $66A0, $66C0, $66E0

      rsUnknown80E39F ; 80/E39F

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitWindowCurrentNameLine
        asl a
        tax
        lda aUnitWindowEquippedWeaponPointers,x
        and #$7FFF
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $88D5E4,x
        sta lR18+1
        lda aUnknown88D5E3,x
        sta $07EA,b
        sta lR18
        lda #$0040
        sta wR0
        lda wUnitWindowCurrentNameLine
        asl a
        tax
        lda aUnknown80E3F2,x
        sta wR1
        jsl rlDMAByPointer
        lda $07EA,b
        clc
        adc #$0040
        sta lR18
        lda #$0080
        sta wR0
        lda wR1
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        rts

        .databank 0

        ; 80/E3F2

      aUnknown80E3F2 ; 80/E3F2

        ; A VRAM address for each of the 24 list entries.
        .word $6800, $6840, $6880, $68C0, $6A00, $6A40, $6A80, $6AC0
        .word $6C00, $6C40, $6C80, $6CC0, $6E00, $6E40, $6E80, $6EC0
        .word $7000, $7040, $7080, $70C0, $7200, $7240, $7280, $72C0

      aUnknown80E422 ; 80/E422

        ; A map menu tilemap entry, as aReviveScreenMenuTilemapEntry.
        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E

    .endsection ReviveScreenBuildSection
