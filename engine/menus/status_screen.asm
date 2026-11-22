; Unit status screen setup, shared menu VBlank, and BG/palette initialization.


    .section Unsorted80BB9BSection

      .al
      .xl

      rsRunMenuScreenVBlank ; 80/BB9B

        .al
        .xl
        .autsiz
        .databank ?

        ; Shared menu VBlank used by unit/item/skill/data windows, revive, status, debug, options screens

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
        jsl rlRunVBlankHooks
        jsl rlRunGameStateRoutines
        jsl rlHideSprites
        jsl rlUnknown878256
        jsl rlUpdateSound
        rts

        .databank 0

        ; 80/BBD9

      rsOpenStatusScreen ; 80/BBD9

        .al
        .xl
        .autsiz
        .databank ?

        ; Opens status screen (game state 8/7), initializes vars, loads display, sets BG settings

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #<>rsRunMenuScreenVBlank
        sta wVBlankPointer
        jsl rlHaltUntilVBlank
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #$0000
        sta wR1
        lda #$0000
        sta wR2
        lda #$4000
        sta wR3
        lda #$6000
        sta wR5
        lda #$2000
        sta wR6
        lda #$2800
        sta wR7
        lda #$5800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlResetIRQEngine
        jsl rlResetHDMAEngine
        jsr rsInitializeStatusScreenVariables
        jsl rlLoadStatusScreenDisplay
        jsr rsSetStatusScreenBGSettings
        lda #GAMESTATE_STATUS_SCREEN_SETUP
        sta wGameStateRoutine1,b
        lda #GAMESTATE_STATUS_SCREEN_UPKEEP
        sta wGameStateRoutine2,b
        stz wGameStateStep,b
        lda #<>rsRunFrameTasks
        sta wMainLoopPointer
        jsl rlEnableVBlank
        plp
        rts

        .databank 0

        ; 80/BC52

      rsInitializeStatusScreenVariables ; 80/BC52

        .al
        .xl
        .autsiz
        .databank ?

        ; Populates $7F8185..$7F81D1 unit, blood, leadership, skills, promotion, unique/drop item fields

        lda $7F819D
        cmp #$1111
        beq _BC66
        lda #$0000
        sta $7F8187
        sta $7F8189

        _BC66
        lda #$0000
        sta $7F81A1
        sta $7F8185
        lda #$0050
        sta wUnknown000885,b
        lda #$FFFF
        sta wTempVariable1,b
        lda #$0000
        tax

        _BC81
        sta $7F81ED,x
        sta $7F8255,x
        inc x
        inc x
        cpx #$0068
        bne _BC81
        jsl rlGetSelectedUnitCharacterID
        sta $7F8195
        jsl rlUnknown8990BD
        jsl rlUnknown849FC4
        sta $7F8199
        cmp #$0000
        bne _BCB1
        jsl rlGetSelectedUnitLeadershipStars
        sta $7F8197

        _BCB1
        lda #$000C
        jsl rlCheckForSpecifiedHolyBlood
        sta $7F818D
        jsl rlGetSelectedUnitFactionSlot
        sta $7F8193
        jsl rlGetUnitType
        sta $7F818B
        jsl rlUnknown89A376
        lda #$0000
        sta $7F819B
        lda $7F8193
        bne _BCE9
        jsl rlGetPromotedClassIfAvailable
        lda $7E2000
        sta $7F819B

        _BCE9
        jsl rlCheckForValidUniqueItemOrDrops
        bcc _BCF2
        lda #$0000

        _BCF2
        sta $7F81A7
        jsl rlGetSelectedUnitStates
        sta $7F81A9
        jsl rlGetSelectedUnitStatus
        sta $7F81AB
        lda #$0000
        sta $7F81D1
        lda $7F81A9
        bit #$0200
        bne _BD1F
        lda $7F81AB
        cmp #$0003
        bne _BD26

        _BD1F
        lda #$0008
        sta $7F81D1

        _BD26
        rts

        .databank 0

        ; 80/BD27

      rlLoadStatusScreenDisplay ; 80/BD27

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads status screen VRAM/palettes/tilemaps, draws bank $89 UI, relation palette, portrait, 3 HDMAs

        lda #(`aUnknown89ACB3)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown89ACB3
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0001
        sta $7F81AD
        lda $7F819D
        beq _BD44
        jml _BE18


        _BD44
        lda #$0000
        sta $7F81AD
        lda #$0000
        sta $7F818F
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppMenuCursorSprites, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWeaponTypeIcons, $0800, $80, $E000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppSkillIcons, $0C00, $80, $D000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppUnknownDE0A00, $0C00, $80, $E800

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWindowFrames, $0C00, $80, $6000

        jsl rlDMAByStruct

          .structDMAToVRAM g2bppMenuLabels, $1800, $80, $9800

        lda #(`aDecompressionDMAEntry80BEF9)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry80BEF9
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$030F
        jsl rlUnitWindowFillBG3Buffer
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $1000, $80, $4000

        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $1000, $80, $5000

        jsl rlDMAByStruct

          .structDMAToVRAM gUnknownDD6730, $02C0, $80, $4000

        jsl rlDMAByStruct

          .structDMAToVRAM gUnknownDD69F0, $08C0, $80, $5280

        jsl rlDMAByStruct

          .structDMAToVRAM gUnknownDE1A40, $0440, $80, $5B40

        ldx #$0200

        _BDF9
        lda aUnknownDE2AC0-2,x
        sta wJoy2RepeatTimer,x
        dec x
        dec x
        bne _BDF9
        lda #$0006
        jsl rlUnitWindowCopySpritePalette2
        ldx #$0020

        _BE0D
        lda aWindowPalette+190,x
        sta $02DE,b,x
        dec x
        dec x
        bne _BE0D

        _BE18
        lda $7F818D
        cmp #$0002
        beq _BE30
        jsl rlDMAByStruct

          .structDMAToVRAM gUnknownDE1600, $0440, $80, $4800

        bra _BE3D


        _BE30
        jsl rlDMAByStruct

          .structDMAToVRAM gUnknownDE1E80, $0440, $80, $4800


        _BE3D
        lda #$004E
        jsl rlUnitWindowFillBG3Buffer
        jsl rlUnknown899BA5
        jsl rlUnknown899C7C
        jsl rlUnknown899D72
        jsl rlUnknown899510
        jsl rlUnknown89970D
        jsl rlUnknown8998E1
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $1000, $80, $B000

        sep #$20
        lda #$00
        pha
        plb
        .databank $00
        rep #$20
        lda $7F81AB
        cmp #$0005
        beq _BE92
        lda $7F81D1
        beq _BE83
        tax
        bra _BEA4


        _BE83
        lda $7F8193
        bne _BE97
        lda $7F81A9
        bit #$4000
        beq _BE97

        _BE92
        ldx #$0008
        bra _BEA4


        _BE97
        lda $7F8193
        ldx #$0000
        jsl rlGetFactionRelation
        asl a
        tax

        _BEA4
        lda aStatusScreenSpritePaletteOffsets,x
        tax
        ldy #$0000

        _BEAC
        lda aUnitRelationOAMPalettes,x
        sta aOAMPaletteBuffer.aPalette1,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0020
        bne _BEAC
        jsl rlUnknown89A138
        jsl rlUnknown8990DA
        lda #(`aUnknown899140)<<8
        sta lR44+1
        lda #<>aUnknown899140
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aUnknown89917A)<<8
        sta lR44+1
        lda #<>aUnknown89917A
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aUnknown8991B9)<<8
        sta lR44+1
        lda #<>aUnknown8991B9
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rtl

        .databank 0

        ; 80/BEEF

    .endsection Unsorted80BB9BSection


    .section Data80BEEFSection

      .al
      .xl

      aStatusScreenSpritePaletteOffsets ; 80/BEEF

        ; Read by rlLoadStatusScreenDisplay.

        .word $0120, $0140, $0160, $0180, $01E0

        ; 80/BEF9

    .endsection Data80BEEFSection


    .section Unsorted80BF01Section

      .al
      .xl

      rsSetStatusScreenBGSettings ; 80/BF01

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets TM=$17, TS=0, BG1-3SC |= 2, CGADSUB=$83, clears BG1-3 H/V scrolls for status screen

        sep #$20
        stz bBufferW12SEL
        stz bBufferW34SEL
        stz bBufferWOBJSEL
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda bBufferBG1SC
        and #$FC
        ora #$02
        sta bBufferBG1SC
        lda bBufferBG2SC
        and #$FC
        ora #$02
        sta bBufferBG2SC
        lda bBufferBG3SC
        and #$FC
        ora #$02
        sta bBufferBG3SC
        lda #$00
        sta bBufferCGWSEL
        lda #$83
        sta bBufferCGADSUB
        rep #$20
        stz wBufferBG1VOFS
        stz wBufferBG2VOFS
        stz wBufferBG3VOFS
        stz wBufferBG1HOFS
        stz wBufferBG2HOFS
        stz wBufferBG3HOFS
        rts

        .databank 0

        ; 80/BF40

    .endsection Unsorted80BF01Section


