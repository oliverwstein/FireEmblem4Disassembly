; The revive staff's screen. rsReviveScreenOpen (bank $80, installed as the main
; loop by a staff effect handler, rsCastleStaffValkyrie) lists the player's dead units,
; or says that no one has died, and hands over to game state routines $33
; (rlReviveScreenSetup, once), $34 (rlReviveScreenStep, the steps in
; aReviveScreenSteps) and $32 (rlReviveScreenUpkeep, every frame, which draws by
; the mode in the high byte of wDebugMenuScreenIndex). The dead units are a grid of
; map sprites, three to a row; X shows one's status screen, A and yes set up the
; staff action on it. It reuses the unit window's list variables. Banks $80 and $89.


    .section ReviveScreenSection

      .al
      .xl

      aReviveScreenMenuTilemapEntry ; 80/DFD3

        ; Put in lMapMenuTilemapRAMEntryPointer, as aDataWindowMenuTilemapEntry.
        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E

      rsReviveScreenOpen ; 80/DFDC

        ; Main loop routine that opens the revive staff's screen (rsCastleStaffValkyrie
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
        lda #<>rsRunMenuScreenVBlank
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
        jsr rsReviveScreenInitialize
        jsr rsReviveScreenLoadGraphics
        jsr rsReviveScreenSetBGSettings
        jsr rsReviveScreenCreateHDMA
        lda wUnitWindowMaxRows
        bne _E055
        lda #REVIVE_SCREEN_STEP_NOBODY_DEAD
        sta wGameStateStep,b
        lda #REVIVE_SCREEN_DRAW_NOTHING
        sta wReviveScreenDrawMode
        jsr rsReviveScreenDrawNobodyDead
        bra _E061


        _E055
        lda #REVIVE_SCREEN_STEP_CHOOSE_UNIT
        sta wGameStateStep,b
        jsr rsReviveScreenLoadMapSprites
        jsr rsReviveScreenDrawNames

        _E061
        phk
        plb
        .databank $80
        lda #GAMESTATE_REVIVE_SCREEN_SETUP
        sta wGameStateRoutine1,b
        lda #GAMESTATE_REVIVE_SCREEN_UPKEEP
        sta wGameStateRoutine2,b
        lda #<>rsRunFrameTasks
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

      rsReviveScreenInitialize ; 80/E07A

        .al
        .xl
        .autsiz
        .databank ?

        ; Unless coming back from the status screen (wStatusScreenCaller is rsReviveScreenOpen), saves the staff's user (wReviveScreenStaffUser), puts the cursor on the first entry and builds the list of dead units.

        lda wStatusScreenCaller
        cmp #<>rsReviveScreenOpen
        beq _E096
        lda wSelectedUnitDataRAMPointer,b
        sta wReviveScreenStaffUser
        lda #$0000
        sta wUnitWindowCurrentHighlightLine
        jsr rsReviveScreenBuildDeadUnitList
        bra _E096


        _E096
        lda #$0000
        sta $7FB014
        sta wReviveScreenDrawMode
        lda #(`aReviveScreenMenuTilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aReviveScreenMenuTilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        rts

        .databank 0

        ; 80/E0AE


      rsReviveScreenLoadGraphics ; 80/E0AE

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppMenuCursorSprites, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWindowFrames, $0C00, $80, $7200

        lda #(`aReviveScreenGraphics1)<<8
        sta lR19+1
        lda #<>aReviveScreenGraphics1
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aReviveScreenGraphics2)<<8
        sta lR19+1
        lda #<>aReviveScreenGraphics2
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        ldx #$0100

        _E0E7
        lda aChapterIntroAndUIBGPalettes-2,x
        sta wJoy2RepeatTimer,x
        dec x
        dec x
        bne _E0E7
        ldx #$001E

        _E0F4
        lda aWindowPalette+254,x
        sta $01FE,b,x
        dec x
        dec x
        bne _E0F4
        ldx #$0020

        _E102
        lda aPortraitAndMapUIOAMPalettes,x
        sta $021E,b,x
        dec x
        dec x
        bne _E102
        ldx #$0020

        _E110
        lda aMenuSpritePalette7Slice,x
        sta $027E,b,x
        dec x
        dec x
        bne _E110
        lda #$0000
        sta aBGPaletteBuffer,b
        lda #(`aReviveScreenGraphics3)<<8
        sta lR19+1
        lda #<>aReviveScreenGraphics3
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aReviveScreenGraphics4)<<8
        sta lR19+1
        lda #<>aReviveScreenGraphics4
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rts

        .databank 0

        ; 80/E13E


      aReviveScreenGraphics1 ; 80/E13E

        ; Entry for rlHandleMapMenuDecompressionDMA.
        .structDecompressionDMAEntry gcHiraganaFont, $1800, $0000

      aReviveScreenGraphics2 ; 80/E146

        ; Entry for rlHandleMapMenuDecompressionDMA.
        .structDecompressionDMAEntry g4bppcReviveScreenTiles, $1200, $3000

      aReviveScreenGraphics3 ; 80/E14E

        ; Entry for rlHandleMapMenuDecompressionDMA.
        .structDecompressionDMAEntry acReviveScreenBG1Tilemap, $0700, $1800

      aReviveScreenGraphics4 ; 80/E156

        ; Entry for rlHandleMapMenuDecompressionDMA.
        .structDecompressionDMAEntry acReviveScreenBG2Tilemap, $0800, $2000

      rsReviveScreenSetBGSettings ; 80/E15E

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


      rsReviveScreenCreateHDMA ; 80/E1AA

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown91E185)<<8
        sta lR44+1
        lda #<>aUnknown91E185
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rts

        .databank 0

        ; 80/E1B9


      rsReviveScreenDrawNames ; 80/E1B9

        .al
        .xl
        .autsiz
        .databank ?

        ; "Whom will you revive?" and the names of the dead units, at aReviveScreenNamePositions.

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
        lda aReviveScreenNamePositions,x
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


      aReviveScreenNamePositions ; 80/E20E

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

      rsReviveScreenDrawNobodyDead ; 80/E258

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

      rsReviveScreenBuildDeadUnitList ; 80/E298

        .al
        .xl
        .autsiz
        .databank ?

        ; Puts the unit pointers of the player's dead units in aUnitWindowDeploymentSlots (0 after the last) and their map sprite IDs in aUnitWindowEquippedWeaponPointers; the count in wUnitWindowMaxRows.

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
        bit #UnitStateDead
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


      rsReviveScreenLoadMapSprites ; 80/E2F9

        .al
        .xl
        .autsiz
        .databank ?

        ; Sends the first frame of each dead unit's map sprite to its place in VRAM.

        lda #$0000

        _E2FC
        sta wUnitWindowCurrentNameLine
        asl a
        tax
        lda aUnitWindowEquippedWeaponPointers,x
        bmi _E30D
        jsr rsReviveScreenLoadSmallMapSprite
        bra _E310


        _E30D
        jsr rsReviveScreenLoadLargeMapSprite

        _E310
        lda wUnitWindowCurrentNameLine
        inc a
        cmp wUnitWindowMaxRows
        bne _E2FC
        rts

        .databank 0

        ; 80/E31C


      rsReviveScreenLoadSmallMapSprite ; 80/E31C

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
        lda aShortStandingMapSpritePointers+1,x
        sta lR18+1
        lda aShortStandingMapSpritePointers,x
        sta lMapSpriteGraphicsPointer,b
        sta lR18
        lda #$0040
        sta wR0
        lda wUnitWindowCurrentNameLine
        asl a
        tax
        lda aReviveScreenSmallSpriteVRAM,x
        sta wR1
        jsl rlDMAByPointer
        lda lMapSpriteGraphicsPointer,b
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


      aReviveScreenSmallSpriteVRAM ; 80/E36F

        ; A VRAM address for each of the 24 list entries.
        .word $6200, $6220, $6240, $6260, $6280, $62A0, $62C0, $62E0
        .word $6400, $6420, $6440, $6460, $6480, $64A0, $64C0, $64E0
        .word $6600, $6620, $6640, $6660, $6680, $66A0, $66C0, $66E0

      rsReviveScreenLoadLargeMapSprite ; 80/E39F

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
        lda aTallStandingMapSpritePointers+1,x
        sta lR18+1
        lda aTallStandingMapSpritePointers,x
        sta lMapSpriteGraphicsPointer,b
        sta lR18
        lda #$0040
        sta wR0
        lda wUnitWindowCurrentNameLine
        asl a
        tax
        lda aReviveScreenLargeSpriteVRAM,x
        sta wR1
        jsl rlDMAByPointer
        lda lMapSpriteGraphicsPointer,b
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

      aReviveScreenLargeSpriteVRAM ; 80/E3F2

        ; A VRAM address for each of the 24 list entries.
        .word $6800, $6840, $6880, $68C0, $6A00, $6A40, $6A80, $6AC0
        .word $6C00, $6C40, $6C80, $6CC0, $6E00, $6E40, $6E80, $6EC0
        .word $7000, $7040, $7080, $70C0, $7200, $7240, $7280, $72C0

      aUnknown80E422 ; 80/E422

        ; A map menu tilemap entry, as aReviveScreenMenuTilemapEntry.
        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E

    .endsection ReviveScreenBuildSection


    .section Unsorted89ACCESection

      .al
      .xl

      rlReviveScreenSetup ; 89/ACCE

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $33, once: starts a fade-in, queues sound command $7FF7 and moves on to $34.

        inc wGameStateRoutine1,b
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        lda #$7FF7
        jsl rlQueueSoundCommand
        rtl

        .databank 0

        ; 89/ACE7

      rlReviveScreenStep ; 89/ACE7

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $34, every frame: runs the routine for wGameStateStep from aReviveScreenSteps.

        phb
        php
        phk
        plb
        .databank $89
        lda wGameStateStep,b
        asl a
        tax
        jsr (aReviveScreenSteps,x)
        plp
        plb
        .databank $89
        rtl

        .databank 0

        ; 89/ACF6

    .endsection Unsorted89ACCESection


    .section Table89ACF6Section

      .al
      .xl

      aReviveScreenSteps ; 89/ACF6

        ; Jump table of rlReviveScreenStep.
        .word <>rsReviveScreenChooseUnit
        .word <>rsReviveScreenConfirm
        .word <>rsReviveScreenNobodyDead
        .word <>rsReviveScreenWait
        .word <>rsReviveScreenWait

    .endsection Table89ACF6Section


    .section ReviveMenuSection

      .al
      .xl

      rsReviveScreenChooseUnit ; 89/AD00

        ; Entry 0 of aReviveScreenSteps. The revive staff's menu (the text asks whom to
        ; revive and confirms); the routines through $89/B058 belong to it.

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $00, choosing a dead unit in the grid of map sprites. The arrows move the cursor (three columns), A asks to confirm (step $01), X shows the unit's status screen, B leaves to the castle courtyard.

        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _AD31
        lda wJoy1New
        bit #$8000
        bne _AD4A
        bit #$0080
        bne _AD32
        bit #$0040
        bne _AD36
        lda wJoy1Repeated
        bit #$0100
        bne _AD3A
        bit #$0200
        bne _AD3E
        bit #$0800
        bne _AD42
        bit #$0400
        bne _AD46

        _AD31
        rts


        _AD32
        jml _AD9A


        _AD36
        jml rsReviveScreenShowStatus


        _AD3A
        jml rsReviveScreenCursorRight


        _AD3E
        jml rsReviveScreenCursorLeft


        _AD42
        jml rsReviveScreenCursorUp


        _AD46
        jml rsReviveScreenCursorDown


        _AD4A
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$00E8
        jsl rlQueueSoundCommand
        sep #$20
        lda bBufferNMITIMEN
        and #$FE
        sta bBufferNMITIMEN
        rep #$20
        lda #$FFFF
        sta wStatusScreenCaller
        sep #$20
        lda bBufferNMITIMEN
        and #$FE
        sta bBufferNMITIMEN
        rep #$20
        lda #CASTLE_CURSOR_GRID
        sta wCastleCursorState,b
        lda #CASTLE_SCREEN_COURTYARD
        sta wCastleScreenHandler,b
        lda #<>rsOpenCastleScreen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        lda #REVIVE_SCREEN_STEP_LEAVE_TO_STATUS
        sta wGameStateStep,b
        rts


        _AD9A
        lda #$000A
        jsl rlPlaySoundEffect
        lda #(`aReviveMenuBlankLine)<<8
        sta lR18+1
        lda #<>aReviveMenuBlankLine
        sta lR18
        ldx #$0203
        jsl rlDrawMenuTextLine
        lda wUnitWindowMaxRows
        dec a
        beq _AE01
        lda wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda aUnitWindowDeploymentSlots,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0203
        jsl rlDrawMenuTextLine
        jsl rlGetMenuTextStringLength
        lda wR10
        clc
        adc #$0003
        sta wR10
        lda #(`aReviveMenuReviveThemText)<<8
        sta lR18+1
        lda #<>aReviveMenuReviveThemText
        sta lR18
        lda #$0002
        and #$00FF
        xba
        ora wR10
        tax
        jsl rlDrawMenuTextLine
        bra _AE12


        _AE01
        lda #(`aReviveMenuConfirmText)<<8
        sta lR18+1
        lda #<>aReviveMenuConfirmText
        sta lR18
        ldx #$0203
        jsl rlDrawMenuTextLine

        _AE12
        lda #(`aReviveMenuYesNoText)<<8
        sta lR18+1
        lda #<>aReviveMenuYesNoText
        sta lR18
        ldx #$0215
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0200, $80, $5000

        lda #$0000
        sta wReviveScreenConfirmCursor
        lda #REVIVE_SCREEN_STEP_CONFIRM
        sta wGameStateStep,b
        lda #REVIVE_SCREEN_DRAW_CONFIRM
        sta wReviveScreenDrawMode
        rts

        .databank 0

        ; 89/AE45

      aReviveMenuReviveThemText ; 89/AE45

        ; をいきかえらせますか (revive them?)
        .enc "SJIS"
        .text "をいきかえらせますか\n"


      aReviveMenuYesNoText ; 89/AE5B

        ; はい (yes), いいえ (no).
        .text "はい　　　いいえ\n"


      aReviveMenuConfirmText ; 89/AE6D

        ; よろしいですか (is that OK?)
        .text "よろしいですか\n"


      aReviveMenuBlankLine ; 89/AE7D

        ; A blank line.
        .text "　　　　　　　　　　　　　　　　　　　　　　　　　　\n"


      rsReviveScreenShowStatus ; 89/AEB3

        .al
        .xl
        .autsiz
        .databank ?

        ; X: opens the status screen for the unit under the cursor, with the revive screen to return to (wStatusScreenCaller).

        lda #$0008
        jsl rlPlaySoundEffect
        lda wUnitWindowCurrentHighlightLine
        sta wItemWindowCursorRow
        asl a
        tax
        lda aUnitWindowDeploymentSlots,x
        sta wSelectedUnitDataRAMPointer,b
        lda #<>rsReviveScreenOpen
        sta wStatusScreenCaller
        lda #<>rsOpenStatusScreen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        sep #$20
        lda bBufferNMITIMEN
        and #$FE
        sta bBufferNMITIMEN
        rep #$20
        lda #REVIVE_SCREEN_STEP_LEAVE_TO_STATUS
        sta wGameStateStep,b
        lda #$0000
        sta wStatusScreenReopenMode
        rts

        .databank 0

        ; 89/AEFE

      rsReviveScreenCursorRight ; 89/AEFE

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitWindowCurrentHighlightLine
        inc a
        cmp wUnitWindowMaxRows
        beq _AF14
        sta wUnitWindowCurrentHighlightLine
        lda #$0007
        jsl rlPlaySoundEffect

        _AF14
        rts

        .databank 0

        ; 89/AF15

      rsReviveScreenCursorLeft ; 89/AF15

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitWindowCurrentHighlightLine
        beq _AF27
        dec a
        sta wUnitWindowCurrentHighlightLine
        lda #$0007
        jsl rlPlaySoundEffect

        _AF27
        rts

        .databank 0

        ; 89/AF28

      rsReviveScreenCursorUp ; 89/AF28

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitWindowCurrentHighlightLine
        sec
        sbc #$0003
        bmi _AF3D
        sta wUnitWindowCurrentHighlightLine
        lda #$0006
        jsl rlPlaySoundEffect

        _AF3D
        rts

        .databank 0

        ; 89/AF3E

      rsReviveScreenCursorDown ; 89/AF3E

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitWindowCurrentHighlightLine
        clc
        adc #$0003
        cmp wUnitWindowMaxRows
        bpl _AF57
        sta wUnitWindowCurrentHighlightLine
        lda #$0006
        jsl rlPlaySoundEffect

        _AF57
        rts

        .databank 0

        ; 89/AF58

      rsReviveScreenConfirm ; 89/AF58

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $01, the yes/no question. Left and Right move between yes and no (wReviveScreenConfirmCursor); A on yes sets up the staff action of the staff's user (wReviveScreenStaffUser) on the chosen unit (rlBuildCastleActionRounds); A on no, or B, goes back to step $00.

        lda wJoy1New
        bit #$0080
        bne _AF77
        bit #$8000
        bne _AF9D
        bit #$0100
        bne _AF6F
        bit #$0200
        bne _AF73
        rts


        _AF6F
        jml rsReviveScreenConfirmNo


        _AF73
        jml rsReviveScreenConfirmYes


        _AF77
        lda wReviveScreenConfirmCursor
        bne _AF9D
        lda #$000A
        jsl rlPlaySoundEffect
        lda wReviveScreenStaffUser
        sta wSelectedUnitDataRAMPointer,b
        lda wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda aUnitWindowDeploymentSlots,x
        sta wRoutineVariable1,b
        jsl rlBuildCastleActionRounds
        rts


        _AF9D
        lda #$0021
        jsl rlPlaySoundEffect
        lda #(`aReviveMenuBlankLine2)<<8
        sta lR18+1
        lda #<>aReviveMenuBlankLine2
        sta lR18
        ldx #$0203
        jsl rlDrawMenuTextLine
        lda #(`aReviveMenuWhomText)<<8
        sta lR18+1
        lda #<>aReviveMenuWhomText
        sta lR18
        ldx #$0203
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0200, $80, $5000

        lda #REVIVE_SCREEN_STEP_CHOOSE_UNIT
        sta wGameStateStep,b
        sta wReviveScreenDrawMode
        rts

        .databank 0

        ; 89/AFDE

      aReviveMenuWhomText ; 89/AFDE

        ; だれをいきかえらせますか (whom will you revive?)
        .enc "SJIS"
        .text "だれをいきかえらせますか\n"


      aReviveMenuBlankLine2 ; 89/AFF8

        ; A blank line.
        .text "　　　　　　　　　　　　　　　　　　　　　　　　　　\n"


      rsReviveScreenConfirmNo ; 89/B02E

        .al
        .xl
        .autsiz
        .databank ?

        lda wReviveScreenConfirmCursor
        bne _B042
        lda #$0001
        sta wReviveScreenConfirmCursor
        lda #$0007
        jsl rlPlaySoundEffect

        _B042
        rts

        .databank 0

        ; 89/B043

      rsReviveScreenConfirmYes ; 89/B043

        .al
        .xl
        .autsiz
        .databank ?

        lda wReviveScreenConfirmCursor
        beq _B057
        lda #$0000
        sta wReviveScreenConfirmCursor
        lda #$0007
        jsl rlPlaySoundEffect

        _B057
        rts

        .databank 0

        ; 89/B058

    .endsection ReviveMenuSection


    .section Unsorted89B058Section

      .al
      .xl

      rsReviveScreenNobodyDead ; 89/B058

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $02, "no one has died": B leaves to the castle courtyard.

        lda wJoy1New
        bit #$8000
        bne _B060
        rts


        _B060
        lda #$0021
        jsl rlPlaySoundEffect
        sep #$20
        lda bBufferNMITIMEN
        and #$FE
        sta bBufferNMITIMEN
        rep #$20
        lda #$FFFF
        sta wStatusScreenCaller
        sep #$20
        lda bBufferNMITIMEN
        and #$FE
        sta bBufferNMITIMEN
        rep #$20
        lda #CASTLE_CURSOR_GRID
        sta wCastleCursorState,b
        lda #CASTLE_SCREEN_COURTYARD
        sta wCastleScreenHandler,b
        lda #<>rsOpenCastleScreen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        lda #REVIVE_SCREEN_STEP_LEAVE_TO_CASTLE
        sta wGameStateStep,b
        rts

        .databank 0

        ; 89/B0A9

    .endsection Unsorted89B058Section


    .section Unsorted89B0A9Section

      .al
      .xl

      rsReviveScreenWait ; 89/B0A9

        .al
        .xl
        .autsiz
        .databank ?

        ; Steps $03 and $04: nothing, while the fade to the next screen runs.

        rts

        .databank 0

        ; 89/B0AA

    .endsection Unsorted89B0A9Section


    .section Unsorted89B0AASection

      .al
      .xl

      rlReviveScreenUpkeep ; 89/B0AA

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $32, every frame while the revive screen is up: a routine from aReviveScreenDrawModes chosen by the high byte of wDebugMenuScreenIndex, and BG2 scrolled down one line every two frames.

        lda wReviveScreenDrawMode
        asl a
        tax
        jsr (aReviveScreenDrawModes,x)
        lda wVBlankEnabledFramecount
        lsr a
        sta wBufferBG2VOFS
        rtl

        .databank 0

        ; 89/B0B9

    .endsection Unsorted89B0AASection


    .section Table89B0B9Section

      .al
      .xl

      aReviveScreenDrawModes ; 89/B0B9

        ; Jump table of rlReviveScreenUpkeep.
        .word <>rsReviveScreenDrawGrid
        .word <>rsReviveScreenDrawGridAndConfirm
        .word <>rsReviveScreenDrawNothing

    .endsection Table89B0B9Section


    .section Unsorted89B0BFSection

      .al
      .xl

      rsReviveScreenDrawGrid ; 89/B0BF

        .al
        .xl
        .autsiz
        .databank ?

        ; Draw mode 0: the map sprites and the cursor.

        jsr rsReviveScreenDrawMapSprites
        jsr rsReviveScreenDrawCursor
        rts

        .databank 0

        ; 89/B0C6

    .endsection Unsorted89B0BFSection


    .section Unsorted89B0C6Section

      .al
      .xl

      rsReviveScreenDrawGridAndConfirm ; 89/B0C6

        .al
        .xl
        .autsiz
        .databank ?

        ; Draw mode 1: as mode 0, and the cursor on yes or no.

        jsr rsReviveScreenDrawMapSprites
        jsr rsReviveScreenDrawCursor
        jsr rsReviveScreenDrawConfirmCursor
        rts

        .databank 0

        ; 89/B0D0

    .endsection Unsorted89B0C6Section


    .section Unsorted89B0D0Section

      .al
      .xl

      rsReviveScreenDrawNothing ; 89/B0D0

        .al
        .xl
        .autsiz
        .databank ?

        ; Draw mode 2, with no dead unit: nothing.

        rts

        .databank 0

        ; 89/B0D1

    .endsection Unsorted89B0D0Section


    .section Unsorted89B0D1Section

      .al
      .xl

      rsReviveScreenDrawMapSprites ; 89/B0D1

        .al
        .xl
        .autsiz
        .databank ?

        ; The map sprite of each dead unit in the grid, the one under the cursor in palette 1 and animated in step $00 (rsReviveScreenAnimateMapSprite), the others in palette 4.

        lda wGameStateStep,b
        bne _B0D9
        jsr rsReviveScreenAnimateMapSprite

        _B0D9
        phk
        plb
        .databank $89
        lda wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda #$0200
        sta wR5
        jsr rsReviveScreenDrawMapSprite
        lda #$0000

        _B0EC
        sta wUnitWindowCurrentNameLine
        cmp wUnitWindowCurrentHighlightLine
        beq _B100
        asl a
        tax
        lda #$0800
        sta wR5
        jsr rsReviveScreenDrawMapSprite

        _B100
        lda wUnitWindowCurrentNameLine
        inc a
        cmp wUnitWindowMaxRows
        bne _B0EC
        rts

        .databank 0

        ; 89/B10C

    .endsection Unsorted89B0D1Section


    .section Unsorted89B10CSection

      .al
      .xl

      rsReviveScreenDrawMapSprite ; 89/B10C

        .al
        .xl
        .autsiz
        .databank ?

        ; The map sprite of grid entry X/2 with attributes wR5, small or large by the map sprite ID's top bit.

        lda aUnitWindowEquippedWeaponPointers,x
        bmi _B11C
        lda <>aReviveScreenSmallSpriteTiles,b,x
        sta wR4
        ldy #<>aReviveScreenSmallSprite
        bra _B124


        _B11C
        lda <>aReviveScreenLargeSpriteTiles,b,x
        sta wR4
        ldy #<>aReviveScreenLargeSprite

        _B124
        lda <>aReviveScreenSpriteX,b,x
        sta wR0
        lda <>aReviveScreenSpriteY,b,x
        sta wR1
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/B133

      aReviveScreenSmallSpriteTiles ; 89/B133

        ; By grid entry: the first sprite tile of a small map sprite (rsReviveScreenLoadSmallMapSprite
        ; put its frames there), then the same for large ones.

        .word $0020, $0022, $0024, $0026, $0028, $002A, $002C, $002E
        .word $0040, $0042, $0044, $0046, $0048, $004A, $004C, $004E
        .word $0060, $0062, $0064, $0066, $0068, $006A, $006C, $006E

      aReviveScreenLargeSpriteTiles ; 89/B163

        .word $0080, $0084, $0088, $008C, $00A0, $00A4, $00A8, $00AC
        .word $00C0, $00C4, $00C8, $00CC, $00E0, $00E4, $00E8, $00EC
        .word $0100, $0104, $0108, $010C, $0120, $0124, $0128, $012C

      aReviveScreenSpriteX ; 89/B193

        ; By grid entry: X and Y of the map sprite.

        .word $0010, $0060, $00B0, $0010, $0060, $00B0, $0010, $0060
        .word $00B0, $0010, $0060, $00B0, $0010, $0060, $00B0, $0010
        .word $0060, $00B0, $0010, $0060, $00B0, $0010, $0060, $00B0

      aReviveScreenSpriteY ; 89/B1C3

        .word $004A, $004A, $004A, $005A, $005A, $005A, $006A, $006A
        .word $006A, $007A, $007A, $007A, $008A, $008A, $008A, $009A
        .word $009A, $009A, $00AA, $00AA, $00AA, $00BA, $00BA, $00BA

      aReviveScreenSmallSprite ; 89/B1F3

        _Sprites := [[(   0,    0), $21, SpriteLarge, $000, 3, 0, false, false]]

        .structSpriteArray aReviveScreenSmallSprite._Sprites

      aReviveScreenLargeSprite ; 89/B1FA

        _Sprites := [[(   0,    0), $21, SpriteLarge, $000, 3, 0, false, false]]
        _Sprites ..= [[(   0,   -8), $00, SpriteSmall, $012, 3, 0, false, false]]
        _Sprites ..= [[(   8,   -8), $00, SpriteSmall, $013, 3, 0, false, false]]

        .structSpriteArray aReviveScreenLargeSprite._Sprites

        ; 89/B20B

    .endsection Unsorted89B10CSection


    .section Unsorted89B20BSection

      .al
      .xl

      rsReviveScreenDrawCursor ; 89/B20B

        .al
        .xl
        .autsiz
        .databank ?

        ; The hand cursor on the grid entry wUnitWindowCurrentHighlightLine.

        lda wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda aReviveScreenCursorX,x
        sta wR0
        lda aReviveScreenCursorY,x
        sta wR1
        lda wGameStateStep,b
        jsl rlDrawHandCursor
        rts

        .databank 0

        ; 89/B225

    .endsection Unsorted89B20BSection


    .section Data89B225Section

      .al
      .xl

      aReviveScreenCursorX ; 89/B225

        ; Read by rsReviveScreenDrawCursor.

        .word $0000, $0050, $00A0, $0000, $0050, $00A0, $0000, $0050
        .word $00A0, $0000, $0050, $00A0, $0000, $0050, $00A0, $0000
        .word $0050, $00A0, $0000, $0050, $00A0, $0000, $0050, $00A0

        ; 89/B255

      aReviveScreenCursorY ; 89/B255

        ; Read by rsReviveScreenDrawCursor.

        .word $004B, $004B, $004B, $005B, $005B, $005B, $006B, $006B
        .word $006B, $007B, $007B, $007B, $008B, $008B, $008B, $009B
        .word $009B, $009B, $00AB, $00AB, $00AB, $00BB, $00BB, $00BB

        ; 89/B285

    .endsection Data89B225Section


    .section Unsorted89B285Section

      .al
      .xl

      rsReviveScreenDrawConfirmCursor ; 89/B285

        .al
        .xl
        .autsiz
        .databank ?

        ; The hand cursor on yes or no.

        lda wReviveScreenConfirmCursor
        asl a
        tax
        lda aReviveScreenConfirmCursorX,x
        sta wR0
        lda #$0013
        sta wR1
        lda #$0000
        jsl rlDrawHandCursor
        rts

        .databank 0

        ; 89/B29E

    .endsection Unsorted89B285Section


    .section Data89B29ESection

      .al
      .xl

      aReviveScreenConfirmCursorX ; 89/B29E

        ; Read by rsReviveScreenDrawConfirmCursor.

        .word $0095, $00BD

        ; 89/B2A2

    .endsection Data89B29ESection


    .section Unsorted89B2A2Section

      .al
      .xl

      rsReviveScreenAnimateMapSprite ; 89/B2A2

        .al
        .xl
        .autsiz
        .databank ?

        ; Sends the current frame of the map sprite under the cursor to its place in VRAM, small or large.

        lda wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda aUnitWindowEquippedWeaponPointers,x
        bmi _B2B2
        jsr rsReviveScreenAnimateSmallMapSprite
        rts


        _B2B2
        jsr rsReviveScreenAnimateLargeMapSprite
        rts

        .databank 0

        ; 89/B2B6

    .endsection Unsorted89B2A2Section


    .section Unsorted89B2B6Section

      .al
      .xl

      rsReviveScreenAnimateSmallMapSprite ; 89/B2B6

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda wVBlankEnabledFramecount
        lsr a
        lsr a
        lsr a
        and #$0006
        tax
        lda aReviveScreenSmallSpriteFrameOffsets,x
        sta wR15
        pla
        and #$7FFF
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aShortStandingMapSpritePointers+1,x
        sta lR18+1
        lda aShortStandingMapSpritePointers,x
        clc
        adc wR15
        sta lR18
        sta wR14
        lda #$0040
        sta wR0
        lda wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda aReviveScreenSmallSpriteVRAM2,x
        sta wR1
        jsl rlDMAByPointer
        lda wR14
        clc
        adc #$0040
        sta lR18
        lda wR1
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        rts

        .databank 0

        ; 89/B30C

    .endsection Unsorted89B2B6Section


    .section Data89B30CSection

      .al
      .xl

      aReviveScreenSmallSpriteFrameOffsets ; 89/B30C

        ; Read by rsReviveScreenAnimateSmallMapSprite.

        .word $0000, $0080, $0100, $0080

        ; 89/B314

      aReviveScreenSmallSpriteVRAM2 ; 89/B314

        ; Read by rsReviveScreenAnimateSmallMapSprite.

        .word $6200, $6220, $6240, $6260, $6280, $62A0, $62C0, $62E0
        .word $6400, $6420, $6440, $6460, $6480, $64A0, $64C0, $64E0
        .word $6600, $6620, $6640, $6660, $6680, $66A0, $66C0, $66E0

        ; 89/B344

    .endsection Data89B30CSection


    .section Unsorted89B344Section

      .al
      .xl

      rsReviveScreenAnimateLargeMapSprite ; 89/B344

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda wVBlankEnabledFramecount
        lsr a
        lsr a
        lsr a
        and #$0006
        tax
        lda aReviveScreenLargeSpriteFrameOffsets,x
        sta wR15
        pla
        and #$7FFF
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aTallStandingMapSpritePointers+1,x
        sta lR18+1
        lda aTallStandingMapSpritePointers,x
        clc
        adc wR15
        sta lR18
        sta wR14
        lda #$0040
        sta wR0
        lda wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda aReviveScreenLargeSpriteVRAM2,x
        sta wR1
        jsl rlDMAByPointer
        lda wR14
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

        ; 89/B39F

    .endsection Unsorted89B344Section


    .section Data89B39FSection

      .al
      .xl

      aReviveScreenLargeSpriteFrameOffsets ; 89/B39F

        ; Read by rsReviveScreenAnimateLargeMapSprite.

        .word $0000, $00C0, $0180, $00C0

        ; 89/B3A7

      aReviveScreenLargeSpriteVRAM2 ; 89/B3A7

        ; Read by rsReviveScreenAnimateLargeMapSprite.

        .word $6800, $6840, $6880, $68C0, $6A00, $6A40, $6A80, $6AC0
        .word $6C00, $6C40, $6C80, $6CC0, $6E00, $6E40, $6E80, $6EC0
        .word $7000, $7040, $7080, $70C0, $7200, $7240, $7280, $72C0

        ; 89/B3D7

    .endsection Data89B39FSection


