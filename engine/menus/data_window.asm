; The data window: map menu option データ (Data). Shows the chapter, its goal and
; the turn, and lists the armies on the map with each one's leader, relation to the
; player and units alive; X shows an army's details: its home castle and its
; leader's portrait, map sprite, level, HP and attack. Opened by rsDataWindowOpen,
; then run by game state routines $2F (rlDataWindowRender), $30 (rlDataWindowShow)
; and $31 (rlDataWindowRunStep), with wGameStateStep as the step. Code and data in
; banks $80 ($80/D90C-DFD3) and $8B ($8B/CF0A-D794); its variables are at $7F8183
; (include/WRAM.h).

    .section Table80D8E8Section

      .al
      .xl

      aUnknown80D8E8 ; 80/D8E8
        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E

      aUnknown80D8F1 ; 80/D8F1
        .byte $10, $18, $00, $00, $00, $00, $8D, $87, $7F

      aUnknown80D8FA ; 80/D8FA
        .byte $28, $01, $00, $00, $00, $00, $8D, $8F, $7F

      aUnknown80D903 ; 80/D903
        .byte $17, $06, $00, $00, $00, $00, $8D, $90, $7F

    .endsection Table80D8E8Section


    .section DataWindowOpenSection

      .al
      .xl

      aDataWindowMenuTilemapEntry ; 80/D90C

        ; Put in lMapMenuTilemapRAMEntryPointer; read by the map menu code in bank $87.

        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E

      rsDataWindowOpen ; 80/D915

        .al
        .xl
        .autsiz
        .databank ?

        ; The main loop routine rlMapMenuOpenDataWindow fades into: sets up the screen,
        ; then hands over to game state routines $2F (rlDataWindowRender) and $30
        ; (rlDataWindowShow).

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
        lda #$0000
        sta wR3
        lda #$4000
        sta wR5
        lda #$1800
        sta wR6
        lda #$2000
        sta wR7
        lda #$2800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsr rsDataWindowInitializeVariables
        jsr rsDataWindowLoadGraphics
        jsr rsDataWindowSetBGSettings
        jsr rsDataWindowCreateHDMA
        jsr rsDataWindowDrawText
        phk
        plb
        .databank $80
        lda #GAMESTATE_DATA_WINDOW_SETUP
        sta wGameStateRoutine1,b
        lda #GAMESTATE_DATA_WINDOW_UPKEEP
        sta wGameStateRoutine2,b
        lda #<>rsRunFrameTasks
        sta wMainLoopPointer
        jsl rlEnableVBlank
        plp
        rts

        .databank 0

        ; 80/D992

      rsDataWindowInitializeVariables ; 80/D992

        .al
        .xl
        .autsiz
        .databank ?

        ; Starts on the list at the first army and gathers the armies
        ; (rsDataWindowGetArmies).

        lda #$0000
        sta wGameStateStep,b
        sta wDataWindowCurrentArmy
        sta wDataWindowCursorMoveDirection
        lda #$006A
        sta wDataWindowCursorYCoordinate
        lda #(`aDataWindowMenuTilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aDataWindowMenuTilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        jsr rsDataWindowGetArmies
        rts

        .databank 0

        ; 80/D9B7

      rsDataWindowLoadGraphics ; 80/D9B7

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads the window's tiles, palettes and BG2/BG3 tilemaps, the leaders' portraits
        ; and the armies' banners.

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppMenuCursorSprites, $0400, $80, $8000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWindowFrames, $0C00, $80, $6000

        lda #(`aDataWindowDecompressionList)<<8
        sta lR19+1
        lda #<>aDataWindowDecompressionList
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$0200

        _D9E2
        lda aWindowPalette-2,x
        sta aBGPaletteBuffer-2,x
        dec x
        dec x
        bne _D9E2
        lda #$0000
        sta aBGPaletteBuffer,b
        lda #$030F
        jsl rlUnitWindowFillBG3Buffer
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $1000, $80, $3000

        lda #(`gcUnknownDD373A)<<8
        sta lR18+1
        lda #<>gcUnknownDD373A
        sta lR18
        lda #(`aBG2TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG2TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        lda #(`gcUnknownDD3851)<<8
        sta lR18+1
        lda #<>gcUnknownDD3851
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$7B88
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aBG2TilemapBuffer, $0700, $80, $3000

        jsr rsDataWindowLoadPortraits
        jsr rsDataWindowLoadBanners
        rts

        .databank 0

      aDataWindowDecompressionList ; 80/DA4A

        ; For rlHandleMapMenuDecompressionDMA.

        .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $0000


      rsDataWindowSetBGSettings ; 80/DA52

        .al
        .xl
        .autsiz
        .databank ?

        ; BG1, BG3 and sprites on the main screen, no windows; color math subtracts the
        ; fixed color (the COLDATA HDMA's gradient) from BG1 and BG2.

        sep #$20
        lda #$15
        sta bBufferTM
        lda #$00
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
        lda #$00
        sta bBufferCGWSEL
        lda #$83
        sta bBufferCGADSUB
        rep #$20
        stz wBufferBG1HOFS
        stz wBufferBG2HOFS
        stz wBufferBG3HOFS
        stz wBufferBG1VOFS
        stz wBufferBG2VOFS
        stz wBufferBG3VOFS
        rts

        .databank 0

        ; 80/DA9B

      rsDataWindowCreateHDMA ; 80/DA9B

        .al
        .xl
        .autsiz
        .databank ?

        ; Creates the COLDATA and BG3VOFS HDMA entries (aDataWindowCOLDATAHDMA,
        ; aDataWindowBG3VOFSHDMA).

        lda #(`aDataWindowCOLDATAHDMA)<<8
        sta lR44+1
        lda #<>aDataWindowCOLDATAHDMA
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aDataWindowBG3VOFSHDMA)<<8
        sta lR44+1
        lda #<>aDataWindowBG3VOFSHDMA
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rts

        .databank 0

        ; 80/DAB8

      rsDataWindowDrawText ; 80/DAB8

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the chapter title, its goal (aDataWindowChapterGoals), the turn number,
        ; and the list of armies.

        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$010B
        jsl rlUnitWindowFillBG3Buffer
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda wCurrentChapter,b
        jsl rlBuildChapterTitleString
        jsl rlDialogueResetAndStartText
        jsl rlDialogueFreeHDMA
        lda #$0C00
        sta $18D7,b
        lda #$7E00
        sta $18D5,b
        lda #$840E
        sta $18D4,b
        lda #$2180
        sta aDialogue.wBaseTile,b

        _DAF2
        jsl rlRunDialogueCycle
        lda aDialogue.wStatus,b
        bne _DAF2
        lda #(`aDataWindowGoalText)<<8
        sta lR18+1
        lda #<>aDataWindowGoalText
        sta lR18
        ldx #pack([3, 5])
        jsl rlDrawMenuTextLine
        lda wCurrentChapter,b
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aDataWindowChapterGoals+1,x
        sta lR18+1
        lda aDataWindowChapterGoals,x
        sta lR18
        ldx #pack([10, 5])
        jsl rlDrawMenuTextLine
        lda #(`aDataWindowTurnText)<<8
        sta lR18+1
        lda #<>aDataWindowTurnText
        sta lR18
        ldx #pack([3, 7])
        jsl rlDrawMenuTextLine
        lda wCurrentTurn,b
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #(7 * 32 + 10) * 2
        jsl rlDrawMenuTextNumber
        sta wR0
        lda #(`aDataWindowTurnSuffixText)<<8
        sta lR18+1
        lda #<>aDataWindowTurnSuffixText
        sta lR18
        lda #$0007
        and #$00FF
        xba
        ora #$000A
        clc
        adc wR0
        tax
        jsl rlDrawMenuTextLine
        jsr rsDataWindowDrawArmyNames
        jsl rlDataWindowDrawListColumns
        rts

        .databank 0

      aDataWindowChapterGoals ; 80/DB74

        ; By wCurrentChapter (0 is the prologue).

        .long aDataWindowChapterPrologueGoalText
        .long aDataWindowChapter01GoalText
        .long aDataWindowChapter02GoalText
        .long aDataWindowChapter03GoalText
        .long aDataWindowChapter04GoalText
        .long aDataWindowChapter05GoalText
        .long aDataWindowChapter06GoalText
        .long aDataWindowChapter07GoalText
        .long aDataWindowChapter08GoalText
        .long aDataWindowChapter09GoalText
        .long aDataWindowChapter10GoalText
        .long aDataWindowChapterFinalGoalText

      aDataWindowChapterPrologueGoalText ; 80/DB98

        .enc "SJIS"
        .text "エバンス城のせいあつ\n"

      aDataWindowChapter01GoalText ; 80/DBAE

        .text "ヴェルダン城のせいあつ\n"

      aDataWindowChapter02GoalText ; 80/DBC6

        .text "アグスティ城のせいあつ\n"

      aDataWindowChapter03GoalText ; 80/DBDE

        .text "オーガヒル城のせいあつ\n"

      aDataWindowChapter04GoalText ; 80/DBF6

        .text "ザクソン城のせいあつ\n"

      aDataWindowChapter05GoalText ; 80/DC0C

        .text "バーハラ城のせいあつ\n"

      aDataWindowChapter06GoalText ; 80/DC22

        .text "リボー城のせいあつ\n"

      aDataWindowChapter07GoalText ; 80/DC36

        .text "アルスター城のせいあつ\n"

      aDataWindowChapter08GoalText ; 80/DC4E

        .text "ミーズ城のせいあつ\n"

      aDataWindowChapter09GoalText ; 80/DC62

        .text "トラキア城のせいあつ\n"

      aDataWindowChapter10GoalText ; 80/DC78

        .text "シアルフィ城のせいあつ\n"

      aDataWindowChapterFinalGoalText ; 80/DC90

        .text "バーハラ城のせいあつ\n"

      aDataWindowGoalText ; 80/DCA6

        .text "もくてき\n"

      aDataWindowTurnText ; 80/DCB0

        .text "ターンすう\n"

      aDataWindowTurnSuffixText ; 80/DCBC

        .text "ターンめ\n"


      rsDataWindowDrawArmyNames ; 80/DCC6

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the せいりょく (army) heading and each army's faction name, two rows apart.

        lda #$3C00
        sta aCurrentTilemapInfo,b
        lda #(`aDataWindowArmyText)<<8
        sta lR18+1
        lda #<>aDataWindowArmyText
        sta lR18
        ldx #pack([5, 10])
        jsl rlDrawMenuTextLine
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$0000

        _DCE6
        sta wDataWindowTemp1
        asl a
        pha
        tax
        lda aDataWindowFactionSlots,x
        jsl rlGetFactionSlotNamePointer
        pla
        clc
        adc #$000D
        and #$00FF
        xba
        ora #$0005
        tax
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlDrawMenuTextLine
        lda wDataWindowTemp1
        inc a
        cmp wDataWindowArmyCount
        bne _DCE6
        rts

        .databank 0

      aDataWindowArmyText ; 80/DD1C

        .enc "SJIS"
        .text "せいりょく\n"


      rsDataWindowGetArmies ; 80/DD28

        .al
        .xl
        .autsiz
        .databank ?

        ; Fills the list of armies: each faction slot (0-6) that has a name and either a
        ; castle or units alive. For each, finds its leader (the unit with the lowest
        ; generation ID) and keeps the leader's character, map sprite and the palette for
        ; the army's relation to the player.

        phb
        php
        phk
        plb
        .databank $80
        lda wEventLocationEntry,b
        pha
        stz wR0
        lda #$0000

        _DD35
        sta wR1
        jsl rlGetFactionSlotNameID
        cmp #$FFFF
        beq _DD67
        cmp #$00FF
        beq _DD67
        lda wR1
        jsl rlGetFactionSlotLocationID
        cmp #$00FF
        bne _DD5B
        lda wR1
        jsl rlCountUnitsInFactionSlotAlive
        cmp #$0000
        beq _DD67

        _DD5B
        lda wR0
        asl a
        tax
        lda wR1
        sta aDataWindowFactionSlots,x
        inc wR0

        _DD67
        lda wR1
        inc a
        cmp #$0007
        bne _DD35
        lda wR0
        sta wDataWindowArmyCount
        ldy #$0000

        _DD78
        tya
        asl a
        tax
        lda aDataWindowFactionSlots,x
        jsl rlFindFactionUnitWithLowestGenerationID
        lda wSelectedUnitDataRAMPointer,b
        sta aDataWindowLeaders,x
        bne _DD9D

        _DD8C
        lda #$0000
        sta aDataWindowLeaders,x
        sta aDataWindowLeaderCharacterIDs,x
        sta aDataWindowLeaderMapSprites,x
        bra _DDB6


        _DD9D
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        bne _DD8C
        jsl rlGetSelectedUnitCharacterID
        sta aDataWindowLeaderCharacterIDs,x
        jsl rlGetSelectedUnitMapSprite
        sta aDataWindowLeaderMapSprites,x

        _DDB6
        inc y
        tya
        cmp wDataWindowArmyCount
        bne _DD78
        ldy #$0000

        _DDC1
        tya
        asl a
        tax
        lda aDataWindowFactionSlots,x
        jsl rlCountUnitsInFactionSlotAlive
        sta aDataWindowUnitCounts,x
        inc y
        tya
        cmp wDataWindowArmyCount
        bne _DDC1
        lda #$0000
        sta wR15
        sep #$20
        lda #$7F
        pha
        plb
        .databank $7F
        rep #$20
        lda #$0000

        _DDE8
        sta @l wDataWindowTemp1
        asl a
        tax
        lda @l aDataWindowLeaders,x
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitFactionSlot
        ldx #$0000
        jsl rlGetFactionRelation
        asl a
        tax
        lda aDataWindowRelationPaletteOffsets,x
        tax
        lda wR15
        tay

        _DE0B
        lda aUnitRelationOAMPalettes,x
        sta <>aDataWindowRelationPalettes,b,y
        inc x
        inc x
        inc y
        inc y
        tya
        and #$001F
        bne _DE0B
        tya
        sta wR15
        lda @l wDataWindowTemp1
        inc a
        cmp @l wDataWindowArmyCount
        bne _DDE8
        pla
        sta @l wEventLocationEntry
        plp
        plb
        .databank $7F
        rts

        .databank 0

      aDataWindowRelationPaletteOffsets ; 80/DE32

        ; By what rlGetFactionRelation returns, into the palettes at $8C9400.

        .word $0120, $0140, $0160, $0180

      aDataWindowCOLDATAHDMA ; 80/DE3A

        .structHDMADirectEntryInfo rlDataWindowCOLDATAHDMAInit, rlDataWindowHDMACycle, aDataWindowHDMACode, aDataWindowCOLDATAHDMATable, COLDATA, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode0)


      rlDataWindowCOLDATAHDMAInit ; 80/DE45

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies aDataWindowCOLDATAHDMATableSource to aDataWindowCOLDATAHDMATable.

        ldx #$0000

        _DE48
        lda aDataWindowCOLDATAHDMATableSource,x
        sta aDataWindowCOLDATAHDMATable,x
        beq _DE56
        inc x
        inc x
        bra _DE48


        _DE56
        rtl

        .databank 0

      aDataWindowCOLDATAHDMATableSource ; 80/DE57

        ; Line counts and COLDATA values, ended by a 0 word.

        .byte $11, $E0, $06, $E1, $05, $E2, $04, $E3
        .byte $18, $E0, $18, $E1, $18, $E2, $18, $E3
        .byte $10, $E4, $10, $E5, $10, $E6, $10, $E7
        .byte $10, $E8, $10, $E9
        .word $0000


      rlDataWindowHDMACycle ; 80/DE75

        .al
        .xl
        .autsiz
        .databank ?

        ; Both HDMA entries' on-cycle routine: nothing to do.

        rtl

        .databank 0

      aDataWindowHDMACode ; 80/DE76

        HDMA_HALT

      aDataWindowBG3VOFSHDMA ; 80/DE78

        .structHDMADirectEntryInfo rlDataWindowBG3VOFSHDMAInit, rlDataWindowHDMACycle, aDataWindowHDMACode, aDataWindowBG3VOFSHDMATable, BG3VOFS, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode2)


      rlDataWindowBG3VOFSHDMAInit ; 80/DE83

        .al
        .xl
        .autsiz
        .databank ?

        ; Builds aDataWindowBG3VOFSHDMATable: BG3VOFS 5 for the top 32 lines, then 0.

        sep #$20
        lda #$20
        sta aDataWindowBG3VOFSHDMATable
        rep #$20
        lda #$0005
        sta aDataWindowBG3VOFSHDMATable+1
        sep #$20
        lda #$01
        sta aDataWindowBG3VOFSHDMATable+3
        rep #$20
        lda #$0000
        sta aDataWindowBG3VOFSHDMATable+4
        sep #$20
        lda #$00
        sta aDataWindowBG3VOFSHDMATable+6
        rep #$20
        lda #$0000
        sta aDataWindowBG3VOFSHDMATable+7
        rtl

        .databank 0

        ; 80/DEB7

      rsDataWindowLoadPortraits ; 80/DEB7

        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses each leader's portrait into VRAM ($4400 on, $400 words apart) and
        ; keeps its palette in aDataWindowPortraitPalettes.

        lda #$4400
        sta wDataWindowTemp1
        lda #$0000
        sta wDataWindowTemp2
        lda #$0000

        _DEC8
        sta wDataWindowTemp3
        asl a
        tax
        lda aDataWindowLeaderCharacterIDs,x
        beq _DEFE
        jsl rlDecompressDialoguePortrait
        lda #$0800
        sta wR0
        lda wDataWindowTemp1
        sta wR1
        jsl rlDMAByPointer
        lda wDataWindowTemp2
        tax
        ldy #$0000

        _DEEF
        lda [lR19],y
        sta aDataWindowPortraitPalettes,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0020
        bne _DEEF

        _DEFE
        lda wDataWindowTemp1
        clc
        adc #$0400
        sta wDataWindowTemp1
        lda wDataWindowTemp2
        clc
        adc #$0020
        sta wDataWindowTemp2
        lda wDataWindowTemp3
        inc a
        cmp wDataWindowArmyCount
        bne _DEC8
        rts

        .databank 0

        ; 80/DF22

      rsDataWindowLoadBanners ; 80/DF22

        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses the battle banner graphics and copies each army's banner to VRAM
        ; (rsDataWindowCopyBanner).

        lda #(`gcUnknownDD304B)<<8
        sta lR18+1
        lda #<>gcUnknownDD304B
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        lda #$0000

        _DF3D
        sta wDataWindowTemp1
        asl a
        tax
        lda aDataWindowFactionSlots,x
        tax
        jsl rlGetFactionBattleBannerID
        pha
        lda wDataWindowTemp1
        tax
        pla
        jsr rsDataWindowCopyBanner
        lda wDataWindowTemp1
        inc a
        cmp wDataWindowArmyCount
        bne _DF3D
        rts

        .databank 0

        ; 80/DF62

      rsDataWindowCopyBanner ; 80/DF62

        .al
        .xl
        .autsiz
        .databank ?

        ; A = battle banner ID, X = place in the list: copies the banner's two rows of
        ; tiles to aDataWindowBannerVRAMAddresses[X].

        tay
        txa
        asl a
        tax
        lda aDataWindowBannerVRAMAddresses,x
        pha
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        tya
        asl a
        tax
        lda aDataWindowBannerGraphicsOffsets,x
        clc
        adc lR18
        sta lR18
        lda #$0040
        sta wR0
        pla
        sta wR1
        pha
        jsl rlDMAByPointer
        lda lR18
        clc
        adc #$0200
        sta lR18
        lda #$0040
        sta wR0
        pla
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        rts

        .databank 0

      aDataWindowBannerGraphicsOffsets ; 80/DFA7

        ; By battle banner ID, into the banner graphics decompressed to aDecompressionBuffer.

        .word $0000, $0040, $0080, $00C0, $0100, $0140, $0180, $01C0
        .word $0400, $0440, $0480, $04C0, $0500, $0540

      aDataWindowBannerVRAMAddresses ; 80/DFC3

        ; By place in the list.

        .word $4200, $4220, $4240, $4260, $4280, $42A0, $42C0, $42E0

        ; 80/DFD3

    .endsection DataWindowOpenSection


    .section DataWindowShowSection

      .al
      .xl

      rlDataWindowShow ; 8B/CF0A

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $30, once: turns on active sprites, moves on to $31
        ; (rlDataWindowRunStep) and fades in.

        jsl rlEnableActiveSpriteEngine
        inc wGameStateRoutine1,b
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 8B/CF20

      rlDataWindowRunStep ; 8B/CF20

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $31, every frame: runs the routine for wGameStateStep from
        ; aDataWindowStepRoutines (0 list, 1 details, 2 nothing while fading out).

        phb
        php
        phk
        plb
        .databank $8B
        lda wGameStateStep,b
        asl a
        tax
        jsr (aDataWindowStepRoutines,x)
        plp
        plb
        .databank $8B
        rtl

        .databank 0

      aDataWindowStepRoutines ; 8B/CF2F

        ; By wGameStateStep; run by rlDataWindowRunStep.

        .word <>rsDataWindowListInput
        .word <>rsDataWindowDetailInput
        .word <>rsDataWindowWaitStep


      rsDataWindowListInput ; 8B/CF35

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 0, once the fade in is done. Finishes cursor moves (each takes two frames
        ; of 8 pixels); B closes (fading into rsReturnToMapMainLoop, or through rlFadeToCastleScreen
        ; when bit 5 of wChapterFlags is set); X shows the selected army's details (step
        ; 1); up and down move between armies.

        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _CF61
        lda wJoy1New
        bit #JOY_B
        bne _CF6E
        lda wDataWindowCursorMoveDirection
        bmi _CF62
        bne _CF66
        lda wJoy1New
        bit #JOY_X
        bne _CFA9
        lda wJoy1Repeated
        bit #JOY_Up
        bne _CFD1
        bit #JOY_Down
        bne _CF6A

        _CF61
        rts


        _CF62
        jml _D018


        _CF66
        jml _D035


        _CF6A
        jml _CFF2


        _CF6E
        lda #$0021
        jsl rlPlaySoundEffect
        lda wChapterFlags,b
        bit #$0020
        bne _CF9E
        lda #$0000
        sta wMainGameMode,b
        lda #<>rsReturnToMapMainLoop
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        lda #$0002
        sta wGameStateStep,b
        rts


        _CF9E
        jsl rlFadeToCastleScreen
        lda #$0002
        sta wGameStateStep,b
        rts


        _CFA9
        lda #$0001
        sta wGameStateStep,b
        lda #$0008
        jsl rlPlaySoundEffect
        jsr rsDataWindowCopyPalettes
        jsr rsDataWindowClearListColumns
        jsl rlDataWindowDrawDetails
        jsr rsDataWindowRenderDetailSprites
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $04C0, $80, $3240

        rts


        _CFD1
        lda wDataWindowCurrentArmy
        beq _CFF1
        lda #$0006
        jsl rlPlaySoundEffect
        lda #$FFFF
        sta wDataWindowCursorMoveDirection
        lda wDataWindowCursorYCoordinate
        sec
        sbc #$0008
        sta wDataWindowCursorYCoordinate

        _CFF1
        rts


        _CFF2
        lda wDataWindowCurrentArmy
        inc a
        cmp wDataWindowArmyCount
        beq _D017
        lda #$0006
        jsl rlPlaySoundEffect
        lda #$0001
        sta wDataWindowCursorMoveDirection
        lda wDataWindowCursorYCoordinate
        clc
        adc #$0008
        sta wDataWindowCursorYCoordinate

        _D017
        rts


        _D018
        lda wDataWindowCurrentArmy
        dec a
        sta wDataWindowCurrentArmy
        lda #$0000
        sta wDataWindowCursorMoveDirection
        lda wDataWindowCursorYCoordinate
        sec
        sbc #$0008
        sta wDataWindowCursorYCoordinate
        rts


        _D035
        lda wDataWindowCurrentArmy
        inc a
        sta wDataWindowCurrentArmy
        lda #$0000
        sta wDataWindowCursorMoveDirection
        lda wDataWindowCursorYCoordinate
        clc
        adc #$0008
        sta wDataWindowCursorYCoordinate
        rts

        .databank 0

        ; 8B/D052

      rsDataWindowDetailInput ; 8B/D052

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 1. B goes back to the list; up and down move between armies, redrawing the
        ; details once the move finishes. Draws the details' sprites every frame.

        lda wJoy1New
        bit #JOY_B
        bne _D079
        lda wDataWindowCursorMoveDirection
        bmi _D071
        bne _D075
        lda wJoy1Repeated
        bit #JOY_Up
        bne _D09B
        bit #JOY_Down
        bne _D0BF
        jsr rsDataWindowRenderDetailSprites
        rts


        _D071
        jml _D0E8


        _D075
        jml _D112


        _D079
        lda #$0021
        jsl rlPlaySoundEffect
        jsr rsDataWindowClearListColumns
        jsl rlDataWindowDrawListColumns
        jsl rlDMAByStruct

          .structDMAToVRAM aBG2TilemapBuffer, $0700, $80, $3000

        lda #$0000
        sta wGameStateStep,b
        rts


        _D09B
        lda wDataWindowCurrentArmy
        beq _D0BB
        lda #$0006
        jsl rlPlaySoundEffect
        lda #$FFFF
        sta wDataWindowCursorMoveDirection
        lda wDataWindowCursorYCoordinate
        sec
        sbc #$0008
        sta wDataWindowCursorYCoordinate

        _D0BB
        jsr rsDataWindowRenderDetailSprites
        rts


        _D0BF
        lda wDataWindowCurrentArmy
        inc a
        cmp wDataWindowArmyCount
        beq _D0E4
        lda #$0006
        jsl rlPlaySoundEffect
        lda #$0001
        sta wDataWindowCursorMoveDirection
        lda wDataWindowCursorYCoordinate
        clc
        adc #$0008
        sta wDataWindowCursorYCoordinate

        _D0E4
        jsr rsDataWindowRenderDetailSprites
        rts


        _D0E8
        lda wDataWindowCurrentArmy
        dec a
        sta wDataWindowCurrentArmy
        lda #$0000
        sta wDataWindowCursorMoveDirection
        lda wDataWindowCursorYCoordinate
        sec
        sbc #$0008
        sta wDataWindowCursorYCoordinate
        jsr rsDataWindowCopyPalettes
        jsr rsDataWindowClearListColumns
        jsl rlDataWindowDrawDetails
        jsr rsDataWindowRenderDetailSprites
        rts


        _D112
        lda wDataWindowCurrentArmy
        inc a
        sta wDataWindowCurrentArmy
        lda #$0000
        sta wDataWindowCursorMoveDirection
        lda wDataWindowCursorYCoordinate
        clc
        adc #$0008
        sta wDataWindowCursorYCoordinate
        jsr rsDataWindowCopyPalettes
        jsr rsDataWindowClearListColumns
        jsl rlDataWindowDrawDetails
        jsr rsDataWindowRenderDetailSprites
        rts

        .databank 0

      rsDataWindowWaitStep ; 8B/D13C

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 2: nothing, while the window fades out.

        rts

        .databank 0

        ; 8B/D13D


      rlDataWindowRender ; 8B/D13D

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $2F, every frame: the banners, the cursor, and the BG3
        ; tilemap.

        jsr rsDataWindowRenderListBanners
        jsr rsDataWindowRenderCursor
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0740, $80, $5000

        rtl

        .databank 0

        ; 8B/D151


      rlDataWindowDrawListColumns ; 8B/D151

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the list's columns: each army's leader, its relation to the player
        ; (aDataWindowRelationNames), and how many units it has alive. A row with no
        ; leader or no units gets dashes.

        lda #$3C00
        sta aCurrentTilemapInfo,b
        lda #(`aDataWindowLeaderText)<<8
        sta lR18+1
        lda #<>aDataWindowLeaderText
        sta lR18
        ldx #pack([14, 10])
        jsl rlDrawMenuTextLine
        lda #(`aDataWindowRelationText)<<8
        sta lR18+1
        lda #<>aDataWindowRelationText
        sta lR18
        ldx #pack([22, 10])
        jsl rlDrawMenuTextLine
        lda #(`aDataWindowUnitsText)<<8
        sta lR18+1
        lda #<>aDataWindowUnitsText
        sta lR18
        ldx #pack([27, 10])
        jsl rlDrawMenuTextLine
        lda #$2000
        sta aCurrentTilemapInfo,b
        ldy #$0000

        _D193
        tya
        asl a
        tax
        lda aDataWindowLeaders,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        tya
        asl a
        clc
        adc #$000D
        and #$00FF
        xba
        ora #$000E
        tax
        jsl rlDrawMenuTextLine
        inc y
        tya
        cmp wDataWindowArmyCount
        bne _D193
        ldy #$0000

        _D1C8
        tya
        asl a
        tax
        lda aDataWindowUnitCounts,x
        beq _D1D7
        lda aDataWindowLeaders,x
        bne _D1F3

        _D1D7
        lda #(`aDataWindowNoLeaderText)<<8
        sta lR18+1
        lda #<>aDataWindowNoLeaderText
        sta lR18
        tya
        asl a
        clc
        adc #$000D
        and #$00FF
        xba
        ora #$000E
        tax
        jsl rlDrawMenuTextLine

        _D1F3
        inc y
        tya
        cmp wDataWindowArmyCount
        bne _D1C8
        ldy #$0000

        _D1FE
        tya
        asl a
        tax
        lda aDataWindowFactionSlots,x
        tax
        lda #$0000
        jsl rlGetFactionRelation
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aDataWindowRelationNames+1,x
        sta lR18+1
        lda aDataWindowRelationNames,x
        sta lR18
        tya
        asl a
        clc
        adc #$000D
        and #$00FF
        xba
        ora #$0016
        tax
        jsl rlDrawMenuTextLine
        inc y
        tya
        cmp wDataWindowArmyCount
        bne _D1FE
        lda #$0000

        _D23D
        sta wDataWindowTemp1
        asl a
        tax
        lda aDataWindowUnitCounts,x
        pha
        lda wDataWindowTemp1
        asl a
        clc
        adc #$000D
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0038
        tax
        lda #$3920
        sta wR5
        lda #$0002
        sta wR6
        pla
        jsl rlDrawMenuTextNumber
        lda wDataWindowTemp1
        inc a
        cmp wDataWindowArmyCount
        bne _D23D
        rtl

        .databank 0

      aDataWindowLeaderText ; 8B/D277

        .enc "SJIS"
        .text "リーダー\n"

      aDataWindowRelationText ; 8B/D281

        .text "かんけい\n"

      aDataWindowUnitsText ; 8B/D28B

        .text "ユニット\n"

      aDataWindowNoLeaderText ; 8B/D295

        .text "ーーーーーー\n"

      aDataWindowRelationNames ; 8B/D2A3

        ; By what rlGetFactionRelation returns for the player's faction slot (0) and the army.

        .long aDataWindowOwnArmyText
        .long aDataWindowEnemyText
        .long aDataWindowAlliedText
        .long aDataWindowNeutralText

      aDataWindowOwnArmyText ; 8B/D2AF

        .text "じぐん\n"

      aDataWindowEnemyText ; 8B/D2B7

        .text "てきたい\n"

      aDataWindowAlliedText ; 8B/D2C1

        .text "どうめい\n"

      aDataWindowNeutralText ; 8B/D2CB

        .text "ちゅうりつ\n"


      rlDataWindowDrawDetails ; 8B/D2D7

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the selected army's details: name, home castle, and its leader's name,
        ; level, HP and attack (the might of their first weapon), or a line saying it has
        ; no units or no leader.

        lda #$2000
        sta aCurrentTilemapInfo,b
        lda wDataWindowCurrentArmy
        asl a
        tax
        lda aDataWindowFactionSlots,x
        jsl rlGetFactionSlotNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #pack([16, 10])
        jsl rlDrawMenuTextLine
        lda wEventLocationEntry,b
        pha
        lda #(`aDataWindowCastleText)<<8
        sta lR18+1
        lda #<>aDataWindowCastleText
        sta lR18
        ldx #pack([14, 13])
        jsl rlDrawMenuTextLine
        lda wDataWindowCurrentArmy
        asl a
        tax
        lda aDataWindowFactionSlots,x
        jsl rlGetFactionSlotLocationID
        cmp #$00FF
        bne _D332
        lda #(`aDataWindowNoCastleText)<<8
        sta lRoutineVariable+1,b
        lda #<>aDataWindowNoCastleText
        sta lRoutineVariable,b
        bra _D33A


        _D332
        jsl rlGetLocationEventDataEntry
        jsl rlGetEventLocationEntryCastleName

        _D33A
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #pack([18, 13])
        jsl rlDrawMenuTextLine
        pla
        sta wEventLocationEntry,b
        lda wDataWindowCurrentArmy
        asl a
        tax
        lda aDataWindowUnitCounts,x
        beq _D363
        lda aDataWindowLeaders,x
        beq _D378
        bra _D38D


        _D363
        lda #(`aDataWindowNoUnitsText)<<8
        sta lR18+1
        lda #<>aDataWindowNoUnitsText
        sta lR18
        ldx #pack([15, 19])
        jsl rlDrawMenuTextLine
        jml _D44D


        _D378
        lda #(`aDataWindowNoLeaderUnitText)<<8
        sta lR18+1
        lda #<>aDataWindowNoLeaderUnitText
        sta lR18
        ldx #pack([15, 19])
        jsl rlDrawMenuTextLine
        jml _D44D


        _D38D
        lda #(`aDataWindowLeaderUnitText)<<8
        sta lR18+1
        lda #<>aDataWindowLeaderUnitText
        sta lR18
        ldx #pack([14, 16])
        jsl rlDrawMenuTextLine
        lda wDataWindowCurrentArmy
        asl a
        tax
        lda aDataWindowLeaders,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #pack([16, 19])
        jsl rlDrawMenuTextLine
        lda #(`aDataWindowLevelText)<<8
        sta lR18+1
        lda #<>aDataWindowLevelText
        sta lR18
        ldx #pack([15, 21])
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitLevel
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #(21 * 32 + 21) * 2
        jsl rlDrawMenuTextNumber
        lda #(`aDataWindowHPText)<<8
        sta lR18+1
        lda #<>aDataWindowHPText
        sta lR18
        ldx #pack([15, 23])
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitCurrentHP
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #(23 * 32 + 18) * 2
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitMaxHP
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #(23 * 32 + 21) * 2
        jsl rlDrawMenuTextNumber
        lda #(`aDataWindowAttackText)<<8
        sta lR18+1
        lda #<>aDataWindowAttackText
        sta lR18
        ldx #pack([15, 25])
        jsl rlDrawMenuTextLine
        lda #$0000
        sta wRoutineVariable1,b
        jsl rlGetFirstWeaponBattleMight
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #(25 * 32 + 21) * 2
        jsl rlDrawMenuTextNumber

        _D44D
        rtl

        .databank 0

      aDataWindowCastleText ; 8B/D44E

        .enc "SJIS"
        .text "ほん城\n"

      aDataWindowLeaderUnitText ; 8B/D456

        .text "リーダーユニット\n"

      aDataWindowLevelText ; 8B/D468

        .text "ＬＶ\n"

      aDataWindowHPText ; 8B/D46E

        .text "ＨＰ　　　／\n"

      aDataWindowAttackText ; 8B/D47C

        .text "ＡＴＣ\n"

      aDataWindowNoUnitsText ; 8B/D484

        .text "この軍にはひとりもいません\n"

      aDataWindowNoLeaderUnitText ; 8B/D4A0

        .text "この軍にリーダーはいません\n"

      aDataWindowNoCastleText ; 8B/D4BC

        .text "ーーーー\n"


      rsDataWindowClearListColumns ; 8B/D4C6

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the right of the window (columns 14-30, rows 10-26), where the list's
        ; columns and the details go.

        ldx #$029C
        lda #$0011
        ldy #$0011
        jsl rlClearTilemapRect
        rts

        .databank 0

        ; 8B/D4D4


      rsDataWindowRenderListBanners ; 8B/D4D4

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws each army's banner in its row.

        phk
        plb
        .databank $8B
        lda #$0000
        sta wDataWindowTemp2
        lda #$0069
        sta wDataWindowTemp1

        _D4E4
        lda wDataWindowTemp1
        sta wR1
        lda wDataWindowTemp2
        asl a
        sta wR4
        stz wR0
        stz wR5
        ldy #<>aDataWindowListBannerSprite
        jsl rlPushToOAMBuffer
        lda wDataWindowTemp1
        clc
        adc #$0010
        sta wDataWindowTemp1
        lda wDataWindowTemp2
        inc a
        sta wDataWindowTemp2
        cmp wDataWindowArmyCount
        bne _D4E4
        rts

        .databank 0

      aDataWindowListBannerSprite ; 8B/D518

        ; One army's battle banner; wR4 (2 per row) picks its tiles.

        _Sprites := [[(  22,    0), $21, SpriteLarge, $0020, 3, 5, false, false]]

        .structSpriteArray aDataWindowListBannerSprite._Sprites


      rsDataWindowRenderDetailSprites ; 8B/D51F

        .al
        .xl
        .autsiz
        .databank ?

        ; If the selected army's leader is alive, draws their portrait and animated map
        ; sprite; draws the army's banner either way.

        phk
        plb
        .databank $8B
        lda wDataWindowCurrentArmy
        asl a
        tax
        lda aDataWindowUnitCounts,x
        beq _D57B
        lda aDataWindowLeaders,x
        beq _D57B
        lda #$00C3
        sta wR0
        lda #$0095
        sta wR1
        lda wDataWindowCurrentArmy
        asl a
        tax
        lda @l aDataWindowPortraitTileOffsets,x
        sta wR4
        stz wR5
        ldy #<>aDataWindowPortraitSprite
        jsl rlPushToOAMBuffer
        jsr rsDataWindowAnimateMapSprite
        lda #$006E
        sta wR0
        lda #$0098
        sta wR1
        stz wR4
        stz wR5
        lda wDataWindowCurrentArmy
        asl a
        tax
        lda aDataWindowLeaderMapSprites,x
        bmi _D574
        ldy #<>aDataWindowMapSprite
        bra _D577


        _D574
        ldy #<>aDataWindowTallMapSprite

        _D577
        jsl rlPushToOAMBuffer

        _D57B
        lda #$0051
        sta wR1
        lda wDataWindowCurrentArmy
        asl a
        sta wR4
        stz wR0
        stz wR5
        ldy #<>aDataWindowDetailBannerSprite
        jsl rlPushToOAMBuffer
        rts

        .databank 0

      aDataWindowDetailBannerSprite ; 8B/D593

        _Sprites := [[( 111,    0), $21, SpriteLarge, $0020, 3, 5, false, false]]

        .structSpriteArray aDataWindowDetailBannerSprite._Sprites

      aDataWindowMapSprite ; 8B/D59A

        ; The leader's map sprite, 16x16; rsDataWindowAnimateMapSprite loads its tiles.

        _Sprites := [[(   0,    0), $21, SpriteLarge, $0004, 3, 1, false, false]]

        .structSpriteArray aDataWindowMapSprite._Sprites

      aDataWindowTallMapSprite ; 8B/D5A1

        ; A 16x24 map sprite (bit 15 of the map sprite ID set).

        _Sprites := [[(   0,    1), $21, SpriteLarge, $0004, 3, 1, false, false]]
        _Sprites..= [[(   0,   -7), $00, SpriteSmall, $0016, 3, 1, false, false]]
        _Sprites..= [[(   8,   -7), $00, SpriteSmall, $0017, 3, 1, false, false]]

        .structSpriteArray aDataWindowTallMapSprite._Sprites

      aDataWindowPortraitSprite ; 8B/D5B2

        ; The leader's 48x64 portrait; wR4 (from aDataWindowPortraitTileOffsets) picks its tiles.

        _Sprites := [[(  32,   48), $21, SpriteLarge, $006A, 3, 2, false, false]]
        _Sprites..= [[(  16,   48), $21, SpriteLarge, $0068, 3, 2, false, false]]
        _Sprites..= [[(   0,   48), $21, SpriteLarge, $0066, 3, 2, false, false]]
        _Sprites..= [[(  32,   32), $21, SpriteLarge, $004A, 3, 2, false, false]]
        _Sprites..= [[(  16,   32), $21, SpriteLarge, $0048, 3, 2, false, false]]
        _Sprites..= [[(   0,   32), $21, SpriteLarge, $0046, 3, 2, false, false]]
        _Sprites..= [[(  32,   16), $21, SpriteLarge, $0064, 3, 2, false, false]]
        _Sprites..= [[(  16,   16), $21, SpriteLarge, $0062, 3, 2, false, false]]
        _Sprites..= [[(   0,   16), $21, SpriteLarge, $0060, 3, 2, false, false]]
        _Sprites..= [[(  32,    0), $21, SpriteLarge, $0044, 3, 2, false, false]]
        _Sprites..= [[(  16,    0), $21, SpriteLarge, $0042, 3, 2, false, false]]
        _Sprites..= [[(   0,    0), $21, SpriteLarge, $0040, 3, 2, false, false]]

        .structSpriteArray aDataWindowPortraitSprite._Sprites

      aDataWindowPortraitTileOffsets ; 8B/D5F0

        ; By place in the list: rsDataWindowLoadPortraits puts each portrait $400 words further into VRAM.

        .word $0000, $0040, $0080, $00C0, $0100, $0140, $0180, $01C0


      rsDataWindowRenderCursor ; 8B/D600

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the cursor at wDataWindowCursorYCoordinate (rlDrawHandCursor, as
        ; rsSkillWindowRenderCursor does).

        lda #$0004
        sta wR0
        lda wDataWindowCursorYCoordinate
        sta wR1
        lda #$0000
        jsl rlDrawHandCursor
        rts

        .databank 0

        ; 8B/D613


      rsDataWindowAnimateMapSprite ; 8B/D613

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads the leader's current map sprite frame into VRAM: bit 15 of the map sprite
        ; ID picks the tall version.

        lda wDataWindowCurrentArmy
        asl a
        tax
        lda aDataWindowLeaderMapSprites,x
        bmi _D623
        jsr rsDataWindowAnimateNormalMapSprite
        rts


        _D623
        jsr rsDataWindowAnimateTallMapSprite
        rts

        .databank 0

        ; 8B/D627

      rsDataWindowAnimateNormalMapSprite ; 8B/D627

        .al
        .xl
        .autsiz
        .databank ?

        ; Frames 0, 1, 2, 1, 16 frames each, from the map sprite graphics table at
        ; $88D526.

        lda wVBlankEnabledFramecount
        and #$0030
        cmp #$0000
        beq _D640
        cmp #$0010
        beq _D645
        cmp #$0020
        beq _D64A
        cmp #$0030
        beq _D64F

        _D640
        lda #$0000
        bra _D654


        _D645
        lda #$0080
        bra _D654


        _D64A
        lda #$0100
        bra _D654


        _D64F
        lda #$0080
        bra _D654


        _D654
        sta wMapSpriteFrameByteOffset,b
        lda wDataWindowCurrentArmy
        asl a
        tax
        lda aDataWindowLeaderMapSprites,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda aShortStandingMapSpritePointers+1,x
        sta lR18+1
        lda aShortStandingMapSpritePointers,x
        sta lMapSpriteGraphicsPointer,b
        lda lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$4040
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$0040
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$4140
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 8B/D6B1

      rsDataWindowAnimateTallMapSprite ; 8B/D6B1

        .al
        .xl
        .autsiz
        .databank ?

        ; As rsDataWindowAnimateNormalMapSprite for 16x24 map sprites, from the table at
        ; $88D5E3.

        lda wVBlankEnabledFramecount
        and #$0030
        cmp #$0000
        beq _D6CA
        cmp #$0010
        beq _D6CF
        cmp #$0020
        beq _D6D4
        cmp #$0030
        beq _D6D9

        _D6CA
        lda #$0000
        bra _D6DE


        _D6CF
        lda #$00C0
        bra _D6DE


        _D6D4
        lda #$0180
        bra _D6DE


        _D6D9
        lda #$00C0
        bra _D6DE


        _D6DE
        sta wMapSpriteFrameByteOffset,b
        lda wDataWindowCurrentArmy
        asl a
        tax
        lda aDataWindowLeaderMapSprites,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda aTallStandingMapSpritePointers+1,x
        sta lR18+1
        lda aTallStandingMapSpritePointers,x
        sta lMapSpriteGraphicsPointer,b
        lda lMapSpriteGraphicsPointer,b
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$4040
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda lMapSpriteGraphicsPointer,b
        clc
        adc #$0040
        clc
        adc wMapSpriteFrameByteOffset,b
        sta lR18
        lda #$0080
        sta wR0
        lda #$4140
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 8B/D73B

      rsDataWindowCopyPalettes ; 8B/D73B

        .al
        .xl
        .autsiz
        .databank ?

        ; Puts the selected army's relation palette and leader's portrait palette in
        ; sprite palettes 1 and 2.

        sep #$20
        lda #$00
        pha
        plb
        .databank $00
        rep #$20
        lda wDataWindowCurrentArmy
        asl a
        tax
        lda aDataWindowPaletteOffsets,x
        sta wDataWindowTemp1
        tax
        ldy #$0000

        _D755
        lda aDataWindowRelationPalettes,x
        sta aOAMPaletteBuffer.aPalette1,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0020
        bne _D755
        lda wDataWindowTemp1
        tax
        ldy #$0000

        _D76D
        lda aDataWindowPortraitPalettes,x
        sta aOAMPaletteBuffer.aPalette2,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0020
        bne _D76D
        lda #$35AD
        sta $025C,b
        phk
        plb
        .databank $8B
        rts

        .databank 0

      aDataWindowPaletteOffsets ; 8B/D786

        ; By place in the list, into aDataWindowPortraitPalettes and aDataWindowRelationPalettes.

        .word $0000, $0020, $0040, $0060, $0080, $00A0, $00C0

    .endsection DataWindowShowSection


