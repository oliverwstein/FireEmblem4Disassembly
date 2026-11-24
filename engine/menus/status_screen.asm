; The status screen: one unit's full record, opened from the unit window, the map,
; the castle courtyard and the revive screen. rsOpenStatusScreen (bank $80) builds
; the screen; game state routines $08 (rlStatusScreenSetup, once), $09
; (rlStatusScreenStep, the steps in aStatusScreenSteps) and $07
; (rlStatusScreenUpkeep, every frame) run it. The stat page is one tall BG3 page
; scrolled between its top half (summary, stats, inventory) and its bottom half
; (personal data, weapon ranks, skills); A shows the holy blood page, X puts a
; cursor on the inventory or the skills, R and L show the next or previous unit by
; fading out and reopening the screen. Closing it returns to whoever opened it
; (wStatusScreenCaller). Banks $80 and $89; also the condition names and skill
; descriptions, which the castle reads too. Variables at $7F8183 (include/WRAM.h),
; constants in include/Menus.h.


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
        jsl rlMapMenuVBlankUpload
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

        ; Fills the status screen variables: the unit, its holy bloods, commander or leadership, faction, skills, promotion, the item it drops, its states and condition; keeps the scroll when reopening on the holy blood page.

        lda wStatusScreenReopenMode
        cmp #STATUS_SCREEN_REOPEN_HOLY_BLOOD
        beq _BC66
        lda #$0000
        sta wStatusScreenScroll
        sta wStatusScreenSavedScroll

        _BC66
        lda #STATUS_SCREEN_STEP_TOP_PAGE
        sta wStatusScreenStepAfterFade
        sta wStatusScreenItemSlot
        lda #$0050
        sta wUnknown000885,b
        lda #$FFFF
        sta wTempVariable1,b
        lda #$0000
        tax

        _BC81
        sta aStatusScreenGlintFrameIDs,x
        sta aStatusScreenGlintTimers,x
        inc x
        inc x
        cpx #$0068
        bne _BC81
        jsl rlGetSelectedUnitCharacterID
        sta wStatusScreenCharacter
        jsl rlStatusScreenGetHolyBloodLevels
        jsl rlGetSelectedUnitCommanderCharacterID
        sta wStatusScreenCommander
        cmp #$0000
        bne _BCB1
        jsl rlGetSelectedUnitLeadershipStars
        sta wStatusScreenLeadership

        _BCB1
        lda #$000C
        jsl rlCheckForSpecifiedHolyBlood
        sta wStatusScreenLoptousBlood
        jsl rlGetSelectedUnitFactionSlot
        sta wStatusScreenFactionSlot
        jsl rlGetUnitType
        sta wStatusScreenUnitType
        jsl rlStatusScreenBuildSkillList
        lda #$0000
        sta wStatusScreenCanPromote
        lda wStatusScreenFactionSlot
        bne _BCE9
        jsl rlGetPromotedClassIfAvailable
        lda $7E2000
        sta wStatusScreenCanPromote

        _BCE9
        jsl rlCheckForValidUniqueItemOrDrops
        bcc _BCF2
        lda #$0000

        _BCF2
        sta wStatusScreenDropItemSlot
        jsl rlGetSelectedUnitStates
        sta wStatusScreenUnitStates
        jsl rlGetSelectedUnitStatus
        sta wStatusScreenCondition
        lda #$0000
        sta wStatusScreenGreyIndex
        lda wStatusScreenUnitStates
        bit #UnitStateDead
        bne _BD1F
        lda wStatusScreenCondition
        cmp #StatusCaptive
        bne _BD26

        _BD1F
        lda #$0008
        sta wStatusScreenGreyIndex

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
        sta wStatusScreenReopened
        lda wStatusScreenReopenMode
        beq _BD44
        jml _BE18


        _BD44
        lda #$0000
        sta wStatusScreenReopened
        lda #$0000
        sta wStatusScreenHolyBloodLoaded
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
        lda wStatusScreenLoptousBlood
        cmp #MajorHolyBlood
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
        jsl rlStatusScreenDrawSummaryLabels
        jsl rlStatusScreenDrawStatLabels
        jsl rlStatusScreenDrawPersonalDataLabels
        jsl rlStatusScreenDrawSummary
        jsl rlStatusScreenDrawStatsAndInventory
        jsl rlStatusScreenDrawPersonalData
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $1000, $80, $B000

        sep #$20
        lda #$00
        pha
        plb
        .databank $00
        rep #$20
        lda wStatusScreenCondition
        cmp #StatusSleep
        beq _BE92
        lda wStatusScreenGreyIndex
        beq _BE83
        tax
        bra _BEA4


        _BE83
        lda wStatusScreenFactionSlot
        bne _BE97
        lda wStatusScreenUnitStates
        bit #UnitStateMoved
        beq _BE97

        _BE92
        ldx #$0008
        bra _BEA4


        _BE97
        lda wStatusScreenFactionSlot
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
        jsl rlStatusScreenLoadPortrait
        jsl rlUnknown8990DA
        lda #(`aStatusScreenBG3SplitHDMA)<<8
        sta lR44+1
        lda #<>aStatusScreenBG3SplitHDMA
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aStatusScreenBG1SplitHDMA)<<8
        sta lR44+1
        lda #<>aStatusScreenBG1SplitHDMA
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #(`aStatusScreenGradientHDMA)<<8
        sta lR44+1
        lda #<>aStatusScreenGradientHDMA
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


    .section Unsorted898000Section

      .al
      .xl

      rlStatusScreenUpkeep ; 89/8000

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $07, every frame while the status screen is up: rsStatusScreenDrawScrollArrow.

        jsr rsStatusScreenDrawScrollArrow
        rtl

        .databank 0

        ; 89/8004

      rlStatusScreenSetup ; 89/8004

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $08, once: picks the first step and the fade speed: a reopened screen (wStatusScreenReopenMode) fades in at the page it left; a fresh one fades in at the top at a speed set by its opener (wStatusScreenCaller), or, opened from the map, starts fully bright. Draws the first frame's sprites and moves on to $09. Selected by rsOpenStatusScreen.

        jsl rlUploadSelectedUnitMapSpriteFrame
        lda wStatusScreenReopenMode
        cmp #STATUS_SCREEN_REOPEN_TOP_PAGE
        beq _803A
        cmp #STATUS_SCREEN_REOPEN_BOTTOM_PAGE
        beq _8046
        cmp #STATUS_SCREEN_REOPEN_HOLY_BLOOD
        beq _8064
        lda wStatusScreenCaller
        cmp #<>rsUnitWindowOpen
        beq _8092
        cmp #<>rsReviveScreenOpen
        beq _809E
        cmp #<>rsOpenCastleScreen
        beq _8086
        lda #$000F
        sta wStatusScreenFadeStep
        lda #STATUS_SCREEN_STEP_TOP_PAGE
        bra _80A8


        _803A
        lda #$0003
        sta wStatusScreenFadeStep
        lda #STATUS_SCREEN_STEP_FADE_IN
        bra _80A8


        _8046
        lda #$0003
        sta wStatusScreenFadeStep
        lda #STATUS_SCREEN_SCROLL_BOTTOM
        sta wStatusScreenScroll
        sta wBufferBG3VOFS
        sta wBufferBG2VOFS
        lda #STATUS_SCREEN_STEP_BOTTOM_PAGE
        sta wStatusScreenStepAfterFade
        lda #STATUS_SCREEN_STEP_FADE_IN
        bra _80A8


        _8064
        lda #$0003
        sta wStatusScreenFadeStep
        lda #$0110
        sta wBufferBG3VOFS
        lda #$00AC
        sta wBufferBG1VOFS
        lda #$0110
        sta wBufferBG2VOFS
        lda #STATUS_SCREEN_STEP_HOLY_BLOOD_PAGE
        sta wStatusScreenStepAfterFade
        lda #STATUS_SCREEN_STEP_FADE_IN
        bra _80A8


        _8086
        lda #$0001
        sta wStatusScreenFadeStep
        lda #STATUS_SCREEN_STEP_FADE_IN
        bra _80A8


        _8092
        lda #$0005
        sta wStatusScreenFadeStep
        lda #STATUS_SCREEN_STEP_FADE_IN
        bra _80A8


        _809E
        lda #$0001
        sta wStatusScreenFadeStep
        lda #STATUS_SCREEN_STEP_FADE_IN

        _80A8
        sta wGameStateStep,b
        lda wStatusScreenFadeStep
        sep #$20
        sta bBufferINIDISP
        rep #$20
        lda #$0000
        sta wStatusScreenReopenMode
        inc wGameStateRoutine1,b
        jsl rlStatusScreenSetGradient
        lda wStatusScreenStepAfterFade
        cmp #STATUS_SCREEN_STEP_HOLY_BLOOD_PAGE
        beq _80DC
        jsr rsStatusScreenDrawPortraitAndMapSprite
        jsr rsStatusScreenDrawEquippedWeaponIcon
        jsr rsStatusScreenDrawInventoryIcons
        jsr rsStatusScreenDrawRankIconsAndStars
        jsr rsStatusScreenDrawSkillIcons
        rtl


        _80DC
        jsr rsStatusScreenDrawHolyBloodPageSprites
        rtl

        .databank 0

        ; 89/80E0

      rlStatusScreenStep ; 89/80E0

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $09, every frame: runs the routine for wGameStateStep from aStatusScreenSteps.

        phb
        php
        phk
        plb
        .databank $89
        lda wGameStateStep,b
        asl a
        tax
        jsr (aStatusScreenSteps,x)
        plp
        plb
        .databank $89
        rtl

        .databank 0

        ; 89/80EF

    .endsection Unsorted898000Section


    .section Table8980EFSection

      .al
      .xl

      aStatusScreenSteps ; 89/80EF

        ; Jump table of rlStatusScreenStep.
        .word <>rsStatusScreenTopPage
        .word <>rsStatusScreenBottomPage
        .word <>rsStatusScreenHolyBloodPage
        .word <>rsStatusScreenItemDetails
        .word <>rsStatusScreenLeave
        .word <>rsStatusScreenLoadHolyBloodPage
        .word <>rsStatusScreenReturnToMap
        .word <>rsStatusScreenReturnToCastle
        .word <>rsStatusScreenSkillDetails
        .word <>rsStatusScreenFadeIn
        .word <>rsStatusScreenFadeOut

    .endsection Table8980EFSection


    .section Unsorted898105Section

      .al
      .xl

      rsStatusScreenTopPage ; 89/8105

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $00, the top half of the stat page. B closes the screen (back to whoever opened it: rsStatusScreenClose), X moves the cursor onto the inventory (step $03), Down scrolls to the bottom half (step $01, $07 lines a frame), A opens the holy blood page (step $05 the first time, to load its graphics, then $02), R and L show the next and previous unit.

        jsr rsStatusScreenDrawPortraitAndMapSprite
        jsr rsStatusScreenDrawEquippedWeaponIcon
        lda wStatusScreenScroll
        bne _813A
        lda wJoy1New
        bmi _8132
        bit #$0040
        bne _8136
        bit #$0400
        bne _813A
        bit #$0080
        bne _8146
        bit #$0010
        bne _813E
        bit #$0020
        bne _8142
        jsr rsStatusScreenDrawInventoryIcons
        rts


        _8132
        jml _814A


        _8136
        jml _8246


        _813A
        jml _82DC


        _813E
        jml _830C


        _8142
        jml _8311


        _8146
        jml _8271


        _814A
        lda #$0021
        jsl rlPlaySoundEffect
        jsr rsStatusScreenDrawInventoryIcons
        lda wStatusScreenCaller
        cmp #<>rsUnitWindowOpen
        beq _81A5
        cmp #<>rsReviveScreenOpen
        beq _81DC
        lda wStatusScreenReopened
        beq _816C
        jml _8217


        _816C
        lda wChapterFlags,b
        bit #$0020
        bne _8183

        _8174
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #STATUS_SCREEN_STEP_RETURN_TO_MAP
        sta wGameStateStep,b
        rts


        _8183
        lda #$0001
        sta wStatusScreenFadeStep
        sep #$20
        lda #$0F
        sec
        sbc wStatusScreenFadeStep
        sta bBufferINIDISP
        rep #$20
        lda #STATUS_SCREEN_STEP_FADE_OUT
        sta wGameStateStep,b
        lda #STATUS_SCREEN_STEP_RETURN_TO_CASTLE
        sta wStatusScreenStepAfterFade
        rts


        _81A5
        lda #<>rsOpenStatusScreen
        sta wUnitWindowCaller
        lda #$0000
        sta wStatusScreenCaller
        lda #<>rsUnitWindowOpen
        sta wStatusScreenExitRoutine
        lda #$0005
        sta wStatusScreenFadeStep
        sep #$20
        lda #$0F
        sec
        sbc wStatusScreenFadeStep
        sta bBufferINIDISP
        rep #$20
        lda #STATUS_SCREEN_STEP_FADE_OUT
        sta wGameStateStep,b
        lda #STATUS_SCREEN_STEP_LEAVE
        sta wStatusScreenStepAfterFade
        rts


        _81DC
        sep #$20
        lda bBufferNMITIMEN
        and #$FE
        sta bBufferNMITIMEN
        rep #$20
        lda wItemWindowCursorRow
        sta wUnitWindowCurrentHighlightLine
        lda #<>rsReviveScreenOpen
        sta wStatusScreenExitRoutine
        lda #$0001
        sta wStatusScreenFadeStep
        sep #$20
        lda #$0F
        sec
        sbc wStatusScreenFadeStep
        sta bBufferINIDISP
        rep #$20
        lda #STATUS_SCREEN_STEP_FADE_OUT
        sta wGameStateStep,b
        lda #STATUS_SCREEN_STEP_LEAVE
        sta wStatusScreenStepAfterFade
        rts


        _8217
        lda wStatusScreenGreyIndex
        beq _8221
        jml _816C


        _8221
        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        beq _823A
        jsl rlGetSelectedUnitDeploymentOffset
        sta @l wActiveUnitDeploymentOffset
        jsl rlSetMapReturnCenterOnUnit
        jml _8174


        _823A
        jsl rlGetSelectedUnitDeploymentOffset
        sta @l wActiveUnitDeploymentOffset
        jml _8183


        _8246
        lda #$0001
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _826D
        lda #STATUS_SCREEN_STEP_ITEM_DETAILS
        sta wGameStateStep,b
        lda #$0001
        sta wStatusScreenItemSlot
        jsl rlStatusScreenDrawItemDetails
        stz wUnknown000885,b
        lda #$000A
        jsl rlPlaySoundEffect

        _826D
        jsr rsStatusScreenDrawInventoryIcons
        rts


        _8271
        lda #$000A
        jsl rlPlaySoundEffect
        lda wStatusScreenHolyBloodLoaded
        bne _82AB
        sta wStatusScreenHolyBloodDMAStep
        lda #$0001
        sta wStatusScreenHolyBloodLoaded
        lda #STATUS_SCREEN_STEP_LOAD_HOLY_BLOOD
        sta wGameStateStep,b
        jsr rsStatusScreenDrawInventoryIcons
        lda #(`gcUnknownDD0000)<<8
        sta lR18+1
        lda #<>gcUnknownDD0000
        sta lR18
        lda #(`(aDecompressionBuffer+$1000))<<8
        sta lR19+1
        lda #<>(aDecompressionBuffer+$1000)
        sta lR19
        jsl rlAppendDecompList
        rts


        _82AB
        lda #STATUS_SCREEN_STEP_HOLY_BLOOD_PAGE
        sta wGameStateStep,b
        jsl rlStatusScreenSetGradient
        lda #$0110
        sta wBufferBG3VOFS
        lda #$00AC
        sta wBufferBG1VOFS
        lda wBufferBG2VOFS
        sta wStatusScreenSavedScroll
        lda #$0110
        sta wBufferBG2VOFS
        ldx #$0020

        _82CD
        lda aUnknownDE2CA0-2,x
        sta $02DE,b,x
        dec x
        dec x
        bne _82CD
        jsr rsStatusScreenDrawHolyBloodPageSprites
        rts


        _82DC
        lda wStatusScreenScroll
        clc
        adc #STATUS_SCREEN_SCROLL_SPEED
        cmp #STATUS_SCREEN_SCROLL_BOTTOM+1
        bmi _82F3
        lda #STATUS_SCREEN_STEP_BOTTOM_PAGE
        sta @l wGameStateStep
        lda #STATUS_SCREEN_SCROLL_BOTTOM

        _82F3
        sta wStatusScreenScroll
        sta wBufferBG3VOFS
        sta wBufferBG2VOFS
        lda #$0011
        jsl rlPlaySoundEffect
        jsr rsStatusScreenDrawInventoryIcons
        jsr rsStatusScreenDrawRankIconsAndStars
        jsr rsStatusScreenDrawSkillIcons
        rts


        _830C
        jsr rsStatusScreenNextUnit
        bra _8314


        _8311
        jsr rsStatusScreenPreviousUnit

        _8314
        jsr rsStatusScreenDrawInventoryIcons
        lda #STATUS_SCREEN_REOPEN_TOP_PAGE
        sta wStatusScreenReopenMode
        rts

        .databank 0

        ; 89/831F

      rsStatusScreenBottomPage ; 89/831F

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $01, the bottom half (personal data, weapon ranks, skills). As the top half, but Up scrolls back up and X, if the unit has skills, moves the cursor onto them (step $08).

        jsr rsStatusScreenDrawPortraitAndMapSprite
        jsr rsStatusScreenDrawEquippedWeaponIcon
        lda wStatusScreenScroll
        cmp #STATUS_SCREEN_SCROLL_BOTTOM
        bne _8356
        lda wJoy1New
        bmi _8366
        bit #$0080
        bne _8352
        bit #$0800
        bne _8356
        bit #$0040
        bne _835A
        bit #$0010
        bne _835E
        bit #$0020
        bne _8362
        jsr rsStatusScreenDrawRankIconsAndStars
        jsr rsStatusScreenDrawSkillIcons
        rts


        _8352
        jml _8465


        _8356
        jml _84D3


        _835A
        jml _84FC


        _835E
        jml _8520


        _8362
        jml _8525


        _8366
        lda #$0021
        jsl rlPlaySoundEffect
        jsr rsStatusScreenDrawRankIconsAndStars
        jsr rsStatusScreenDrawSkillIcons
        lda wStatusScreenCaller
        cmp #<>rsUnitWindowOpen
        beq _83C4
        cmp #<>rsReviveScreenOpen
        beq _83FB
        lda wStatusScreenReopened
        beq _838B
        jml _8436


        _838B
        lda wChapterFlags,b
        bit #$0020
        bne _83A2

        _8393
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #STATUS_SCREEN_STEP_RETURN_TO_MAP
        sta wGameStateStep,b
        rts


        _83A2
        lda #$0001
        sta wStatusScreenFadeStep
        sep #$20
        lda #$0F
        sec
        sbc wStatusScreenFadeStep
        sta bBufferINIDISP
        rep #$20
        lda #STATUS_SCREEN_STEP_FADE_OUT
        sta wGameStateStep,b
        lda #STATUS_SCREEN_STEP_RETURN_TO_CASTLE
        sta wStatusScreenStepAfterFade
        rts


        _83C4
        lda #<>rsOpenStatusScreen
        sta wUnitWindowCaller
        lda #$0000
        sta wStatusScreenCaller
        lda #<>rsUnitWindowOpen
        sta wStatusScreenExitRoutine
        lda #$0005
        sta wStatusScreenFadeStep
        sep #$20
        lda #$0F
        sec
        sbc wStatusScreenFadeStep
        sta bBufferINIDISP
        rep #$20
        lda #STATUS_SCREEN_STEP_FADE_OUT
        sta wGameStateStep,b
        lda #STATUS_SCREEN_STEP_LEAVE
        sta wStatusScreenStepAfterFade
        rts


        _83FB
        sep #$20
        lda bBufferNMITIMEN
        and #$FE
        sta bBufferNMITIMEN
        rep #$20
        lda wItemWindowCursorRow
        sta wUnitWindowCurrentHighlightLine
        lda #<>rsReviveScreenOpen
        sta wStatusScreenExitRoutine
        lda #$0001
        sta wStatusScreenFadeStep
        sep #$20
        lda #$0F
        sec
        sbc wStatusScreenFadeStep
        sta bBufferINIDISP
        rep #$20
        lda #STATUS_SCREEN_STEP_FADE_OUT
        sta wGameStateStep,b
        lda #STATUS_SCREEN_STEP_LEAVE
        sta wStatusScreenStepAfterFade
        rts


        _8436
        lda wStatusScreenGreyIndex
        beq _8440
        jml _838B


        _8440
        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        beq _8459
        jsl rlGetSelectedUnitDeploymentOffset
        sta @l wActiveUnitDeploymentOffset
        jsl rlSetMapReturnCenterOnUnit
        jml _8393


        _8459
        jsl rlGetSelectedUnitDeploymentOffset
        sta @l wActiveUnitDeploymentOffset
        jml _83A2


        _8465
        lda #$000A
        jsl rlPlaySoundEffect
        lda wStatusScreenHolyBloodLoaded
        bne _84A2
        sta wStatusScreenHolyBloodDMAStep
        lda #$0001
        sta wStatusScreenHolyBloodLoaded
        lda #STATUS_SCREEN_STEP_LOAD_HOLY_BLOOD
        sta wGameStateStep,b
        lda #(`gcUnknownDD0000)<<8
        sta lR18+1
        lda #<>gcUnknownDD0000
        sta lR18
        lda #(`(aDecompressionBuffer+$1000))<<8
        sta lR19+1
        lda #<>(aDecompressionBuffer+$1000)
        sta lR19
        jsl rlAppendDecompList
        jsr rsStatusScreenDrawRankIconsAndStars
        jsr rsStatusScreenDrawSkillIcons
        rts


        _84A2
        lda #STATUS_SCREEN_STEP_HOLY_BLOOD_PAGE
        sta wGameStateStep,b
        jsl rlStatusScreenSetGradient
        lda #$0110
        sta wBufferBG3VOFS
        lda #$00AC
        sta wBufferBG1VOFS
        lda wBufferBG2VOFS
        sta wStatusScreenSavedScroll
        lda #$0110
        sta wBufferBG2VOFS
        ldx #$0020

        _84C4
        lda aUnknownDE2CA0-2,x
        sta $02DE,b,x
        dec x
        dec x
        bne _84C4
        jsr rsStatusScreenDrawHolyBloodPageSprites
        rts


        _84D3
        lda wStatusScreenScroll
        sec
        sbc #STATUS_SCREEN_SCROLL_SPEED
        bpl _84E3
        dec wGameStateStep,b
        lda #$0000

        _84E3
        sta wStatusScreenScroll
        sta wBufferBG3VOFS
        sta wBufferBG2VOFS
        lda #$0012
        jsl rlPlaySoundEffect
        jsr rsStatusScreenDrawInventoryIcons
        jsr rsStatusScreenDrawRankIconsAndStars
        jsr rsStatusScreenDrawSkillIcons
        rts


        _84FC
        lda wStatusScreenSkillCount
        beq _8519
        lda #$0000
        sta wStatusScreenSkillCursor
        lda #$000A
        jsl rlPlaySoundEffect
        jsr rsStatusScreenDrawSkillDescription
        lda #STATUS_SCREEN_STEP_SKILL_DETAILS
        sta wGameStateStep,b

        _8519
        jsr rsStatusScreenDrawRankIconsAndStars
        jsr rsStatusScreenDrawSkillIcons
        rts


        _8520
        jsr rsStatusScreenNextUnit
        bra _8528


        _8525
        jsr rsStatusScreenPreviousUnit

        _8528
        jsr rsStatusScreenDrawRankIconsAndStars
        jsr rsStatusScreenDrawSkillIcons
        lda #STATUS_SCREEN_REOPEN_BOTTOM_PAGE
        sta wStatusScreenReopenMode
        rts

        .databank 0

        ; 89/8536

    .endsection Unsorted898105Section


    .section Unsorted898536Section

      .al
      .xl

      rsStatusScreenLoadHolyBloodPage ; 89/8536

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $05, once per screen: waits for the decompression of gcUnknownDD0000 that A started, sends it to VRAM in five pieces over five frames (wStatusScreenHolyBloodDMAStep), then shows the holy blood page (step $02).

        jsr rsStatusScreenDrawPortraitAndMapSprite
        jsr rsStatusScreenDrawEquippedWeaponIcon
        lda bDecompressionArrayFlag,b
        beq _854B
        jsr rsStatusScreenDrawInventoryIcons
        jsr rsStatusScreenDrawRankIconsAndStars
        jsr rsStatusScreenDrawSkillIcons
        rts


        _854B
        lda wStatusScreenHolyBloodDMAStep
        cmp #$0005
        beq _856A
        cmp #$0004
        beq _85C6
        cmp #$0003
        beq _85B0
        cmp #$0002
        beq _859A
        cmp #$0001
        beq _8584
        bra _856E


        _856A
        jml _85E4


        _856E
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer+$1000, $0800, $80, $0000

        lda #$0001
        sta wStatusScreenHolyBloodDMAStep
        bra _85DA


        _8584
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer+$1800, $0800, $80, $0800

        lda #$0002
        sta wStatusScreenHolyBloodDMAStep
        bra _85DA


        _859A
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer+$2000, $0800, $80, $1000

        lda #$0003
        sta wStatusScreenHolyBloodDMAStep
        bra _85DA


        _85B0
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer+$2800, $0800, $80, $1800

        lda #$0004
        sta wStatusScreenHolyBloodDMAStep
        bra _85DA


        _85C6
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer+$3000, $0600, $80, $2000

        lda #$0005
        sta wStatusScreenHolyBloodDMAStep

        _85DA
        jsr rsStatusScreenDrawInventoryIcons
        jsr rsStatusScreenDrawRankIconsAndStars
        jsr rsStatusScreenDrawSkillIcons
        rts


        _85E4
        ldx #$0020

        _85E7
        lda aUnknownDE2CA0-2,x
        sta $02DE,b,x
        dec x
        dec x
        bne _85E7
        jsr rsStatusScreenDrawHolyBloodPageSprites
        jsr rsStatusScreenDrawPortraitAndMapSprite
        jsr rsStatusScreenDrawEquippedWeaponIcon
        lda #STATUS_SCREEN_STEP_HOLY_BLOOD_PAGE
        sta wGameStateStep,b
        jsl rlStatusScreenSetGradient
        lda #$0110
        sta wBufferBG3VOFS
        lda #$00AC
        sta wBufferBG1VOFS
        lda wBufferBG2VOFS
        sta wStatusScreenSavedScroll
        lda #$0110
        sta wBufferBG2VOFS
        rts

        .databank 0

        ; 89/861B

    .endsection Unsorted898536Section


    .section Unsorted89861BSection

      .al
      .xl

      rsStatusScreenHolyBloodPage ; 89/861B

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $02, the holy blood page: B goes back to the stat page at the scroll position it left (step $00 or $01), R and L show the next and previous unit.

        jsr rsStatusScreenDrawPortraitAndMapSprite
        jsr rsStatusScreenDrawEquippedWeaponIcon
        lda wJoy1New
        bit #$8000
        bne _863E
        bit #$0010
        bne _8636
        bit #$0020
        bne _863A
        jsr rsStatusScreenDrawHolyBloodPageSprites
        rts


        _8636
        jml _867D


        _863A
        jml _8682


        _863E
        ldx #$0020

        _8641
        lda aWindowPalette+190,x
        sta $02DE,b,x
        dec x
        dec x
        bne _8641
        ldx #$0000
        lda wStatusScreenScroll
        beq _8656
        inc x

        _8656
        txa
        sta wGameStateStep,b
        stz wBufferBG1VOFS
        jsl rlStatusScreenSetGradient
        lda wStatusScreenSavedScroll
        sta wBufferBG2VOFS
        lda wStatusScreenScroll
        sta wBufferBG3VOFS
        jsr rsStatusScreenDrawInventoryIcons
        jsr rsStatusScreenDrawRankIconsAndStars
        jsr rsStatusScreenDrawSkillIcons
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _867D
        jsr rsStatusScreenNextUnit
        bra _8685


        _8682
        jsr rsStatusScreenPreviousUnit

        _8685
        jsr rsStatusScreenDrawHolyBloodPageSprites
        lda #STATUS_SCREEN_REOPEN_HOLY_BLOOD
        sta wStatusScreenReopenMode
        rts

        .databank 0

        ; 89/8690

      rsStatusScreenItemDetails ; 89/8690

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $03, the cursor on the inventory: Up and Down choose an item (wStatusScreenItemSlot) and redraw its details; B puts the stats back and returns to step $00.

        jsr rsStatusScreenDrawPortraitAndMapSprite
        jsr rsStatusScreenDrawEquippedWeaponIcon
        jsr rsStatusScreenDrawInventoryIcons
        jsr rsStatusScreenDrawItemDetailSprites
        lda wJoy1Repeated
        bmi _8704
        bit #$0800
        bne _86AE
        bit #$0400
        bne _86D9
        jsr rsStatusScreenDrawItemCursor
        rts


        _86AE
        lda wStatusScreenItemSlot
        cmp #$0001
        beq _86D5
        lda wUnknown000885,b
        sec
        sbc #$0010
        sta wUnknown000885,b
        lda wStatusScreenItemSlot
        dec a
        sta wStatusScreenItemSlot
        jsl rlStatusScreenDrawItemDetails
        lda #$0006
        jsl rlPlaySoundEffect

        _86D5
        jsr rsStatusScreenDrawItemCursor
        rts


        _86D9
        lda wStatusScreenItemSlot
        cmp wCastleListSubCount,b
        beq _8700
        lda wUnknown000885,b
        clc
        adc #$0010
        sta wUnknown000885,b
        lda wStatusScreenItemSlot
        inc a
        sta wStatusScreenItemSlot
        jsl rlStatusScreenDrawItemDetails
        lda #$0006
        jsl rlPlaySoundEffect

        _8700
        jsr rsStatusScreenDrawItemCursor
        rts


        _8704
        ldx #$02C0
        lda #$0010
        ldy #$0011
        jsl rlClearTilemapRect
        jsl rlStatusScreenDrawStatLabels
        jsl rlStatusScreenDrawStatsAndInventory
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer+$2C0, $0400, $80, $B2C0

        lda #STATUS_SCREEN_STEP_TOP_PAGE
        sta wGameStateStep,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 89/8734

    .endsection Unsorted89861BSection


    .section Unsorted898734Section

      .al
      .xl

      rsStatusScreenLeave ; 89/8734

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $04, after a fade-out: installs wStatusScreenExitRoutine as the main loop routine, which is the screen that opened the status screen or rsOpenStatusScreen again for another unit.

        lda wStatusScreenExitRoutine
        sta wMainLoopPointer
        jsr rsStatusScreenDrawPortraitAndMapSprite
        jsr rsStatusScreenDrawEquippedWeaponIcon
        lda wBufferBG2VOFS
        cmp #$0110
        beq _8751
        jsr rsStatusScreenDrawInventoryIcons
        jsr rsStatusScreenDrawRankIconsAndStars
        jsr rsStatusScreenDrawSkillIcons
        rts


        _8751
        jsr rsStatusScreenDrawHolyBloodPageSprites
        rts

        .databank 0

        ; 89/8755

    .endsection Unsorted898734Section


    .section Unsorted898755Section

      .al
      .xl

      rsStatusScreenReturnToMap ; 89/8755

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $06: back to the map (rsReturnToMapMainLoop) and its music.

        lda #$0001
        sta wMainGameMode,b
        lda #<>rsReturnToMapMainLoop
        sta wMainLoopPointer
        lda #$00E8
        jsl rlQueueSoundCommand
        rts

        .databank 0

        ; 89/8768

    .endsection Unsorted898755Section


    .section Unsorted898768Section

      .al
      .xl

      rsStatusScreenReturnToCastle ; 89/8768

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $07: back to the castle screen.

        jsl rlReturnToCastleScreen
        rts

        .databank 0

        ; 89/876D

    .endsection Unsorted898768Section


    .section Unsorted89876DSection

      .al
      .xl

      rlStatusScreenDrawItemDetails ; 89/876D

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the details of the item in wStatusScreenItemSlot over the stats: name, uses and rank for a staff, and for a weapon also hit, might, range, weight and kills (uses and kills only for a player unit). Ends with the description and a DMA of the area.

        ldx #$02C0
        lda #$0010
        ldy #$0010
        jsl rlClearTilemapRect
        lda wStatusScreenItemSlot
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _87B5
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetItemNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        ldx #$0B04
        jsl rlDrawMenuTextLine
        lda #$3400
        sta aCurrentTilemapInfo,b
        jsl rlGetItemEquipmentType
        cmp #$0000
        bne _87B6
        jml _8811


        _87B5
        rtl


        _87B6
        cmp #$0001
        beq _87CC
        jsr rsStatusScreenDrawItemDescription
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer+$2C0, $0400, $80, $B2C0

        rtl


        _87CC
        lda wStatusScreenFactionSlot
        bne _87EB
        lda wStatusScreenItemSlot
        jsl rlGetItemDurabilityOfInventorySlot
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$02D8
        jsl rlDrawMenuTextNumber

        _87EB
        jsl rlGetItemWeaponRank
        cmp #$FFFF
        bne _87F7
        lda #$0004

        _87F7
        ldx #$0005
        ldy #$000D
        jsr rsDrawWeaponRankLetter
        jsr rsStatusScreenDrawItemDescription
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer+$2C0, $0400, $80, $B2C0

        rtl


        _8811
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #(`aStatusScreenItemHitLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenItemHitLabel
        sta lR18
        ldx #$0F03
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenItemMightLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenItemMightLabel
        sta lR18
        ldx #$1104
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenItemRangeLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenItemRangeLabel
        sta lR18
        ldx #$1304
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenItemWeightLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenItemWeightLabel
        sta lR18
        ldx #$1505
        jsl rlDrawMenuTextLine
        jsl rlGetItemWeaponRank
        cmp #$FFFF
        bne _8867
        lda #$0004

        _8867
        ldx #$0005
        ldy #$000D
        jsr rsDrawWeaponRankLetter
        lda wStatusScreenFactionSlot
        bne _888F
        lda wStatusScreenItemSlot
        jsl rlGetItemDurabilityOfInventorySlot
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$02D8
        jsl rlDrawMenuTextNumber

        _888F
        jsl rlGetItemAccuracy
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$03D2
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMight
        cmp #$00FF
        beq _88C0
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0452
        jsl rlDrawMenuTextNumber
        bra _88DD


        _88C0
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda #(`aStatusScreenNoMightText)<<8
        sta lR18+1
        lda #<>aStatusScreenNoMightText
        sta lR18
        ldx #$1109
        jsl rlDrawMenuTextLine
        lda #$3400
        sta aCurrentTilemapInfo,b

        _88DD
        lda wSelectedInventorySlot,b
        sta wStatusScreenSavedInventorySlot
        lda wStatusScreenItemSlot
        sta wSelectedInventorySlot,b
        jsl rlGetSelectedItemRange
        lda wR11
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$04D6
        jsl rlDrawMenuTextNumber
        lda wStatusScreenSavedInventorySlot
        sta wSelectedInventorySlot,b
        lda wR10
        ldx #$3920
        stx wR5
        ldx #$0001
        stx wR6
        ldx #$04D2
        jsl rlDrawMenuTextNumber
        lda #$3800
        sta wR1
        lda #$02A0
        sta wR2
        lda #$0001
        sta wR0
        ldx #$04D4
        jsl rlDrawBG3TileRun
        jsl rlGetItemWeight
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0552
        jsl rlDrawMenuTextNumber
        lda wStatusScreenFactionSlot
        bne _8962
        jsl rlGetItemRAMKillCountAndCritAbility
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0352
        jsl rlDrawMenuTextNumber

        _8962
        jsr rsStatusScreenDrawWeaponDescription
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer+$2C0, $0400, $80, $B2C0

        rtl

        .databank 0

        ; 89/8973

    .endsection Unsorted89876DSection


    .section Table898973Section

      .al
      .xl

      aStatusScreenItemHitLabel ; 89/8973

        .enc "SJIS"
        .text "めいちゅう"
        .word $0000
        .enc "none"

      aStatusScreenItemMightLabel ; 89/897F

        .enc "SJIS"
        .text "いりょく"
        .word $0000
        .enc "none"

      aStatusScreenItemRangeLabel ; 89/8989

        .enc "SJIS"
        .text "しゃてい"
        .word $0000
        .enc "none"

      aStatusScreenItemWeightLabel ; 89/8993

        .enc "SJIS"
        .text "おもさ"
        .word $0000
        .enc "none"

      aStatusScreenItemUsesLabel ; 89/899B

        ; Nothing reads it.

        .enc "SJIS"
        .text "のこり"
        .word $0000
        .enc "none"

      aStatusScreenGoldSign ; 89/89A3

        ; Nothing reads it.

        .enc "SJIS"
        .text "Ｇ"
        .word $0000
        .enc "none"

      aStatusScreenNoMightText ; 89/89A7

        .enc "SJIS"
        .text "ーー"
        .word $0000
        .enc "none"


    .endsection Table898973Section


    .section Unsorted8989ADSection

      .al
      .xl

      rsStatusScreenDrawPortraitAndMapSprite ; 89/89AD

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: the portrait (twelve 16x16 sprites, aStatusScreenPortraitSprites) and the unit's map sprite (rsStatusScreenDrawMapSprite).

        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        lda #$0062
        sta wR0
        lda #$000C
        sta wR1
        stz wR4
        stz wR5
        ldy #<>aStatusScreenPortraitSprites
        jsl rlPushToOAMBuffer
        jsr rsStatusScreenDrawMapSprite
        rts

        .databank 0

        ; 89/89CE

    .endsection Unsorted8989ADSection


    .section Unsorted8989CESection

      .al
      .xl

      rsStatusScreenDrawItemCursor ; 89/89CE

        .al
        .xl
        .autsiz
        .databank ?

        ; The hand cursor beside the inventory row wUnknown000885.

        phb
        php
        phk
        plb
        .databank $89
        lda #$0076
        sta wR0
        lda wUnknown000885,b
        clc
        adc #$006A
        sta wR1
        lda #$0000
        jsl rlDrawHandCursor
        plp
        plb
        .databank $89
        rts

        .databank 0

        ; 89/89EA

    .endsection Unsorted8989CESection


    .section Unsorted8989EASection

      .al
      .xl

      rsStatusScreenDrawMapSprite ; 89/89EA

        .al
        .xl
        .autsiz
        .databank ?

        ; The promotion marker (rsStatusScreenDrawPromotionMarker), then the unit's map sprite, animated by rlUploadSelectedUnitMapSpriteFrame unless the unit is dead or captive; a large (mounted) map sprite uses the array with its top half.

        phb
        php
        phk
        plb
        .databank $89
        jsr rsStatusScreenDrawPromotionMarker
        lda wStatusScreenGreyIndex
        cmp #$0008
        beq _89FE
        jsl rlUploadSelectedUnitMapSpriteFrame

        _89FE
        phk
        plb
        .databank $89
        lda #$000B
        sta wR0
        lda #$0016
        sta wR1
        stz wR4
        stz wR5
        ldx wActiveUnitDeploymentOffset,b
        jsl rlGetSelectedUnitMapSprite
        and #$8000
        bne _8A1F
        ldy #<>aStatusScreenSmallMapSprite
        bra _8A22


        _8A1F
        ldy #<>aStatusScreenLargeMapSprite

        _8A22
        jsl rlPushToOAMBuffer
        plp
        plb
        .databank $89
        rts

        .databank 0

        ; 89/8A29


      aStatusScreenSmallMapSprite ; 89/8A29

        _Sprites := [[(   4,    4), $21, SpriteLarge, $0E0, 3, 1, false, false]]

        .structSpriteArray aStatusScreenSmallMapSprite._Sprites

      aStatusScreenLargeMapSprite ; 89/8A30

        _Sprites := [[(   4,    6), $21, SpriteLarge, $0E0, 3, 1, false, false]]
        _Sprites ..= [[(   4,   -2), $00, SpriteSmall, $0F2, 3, 1, false, false]]
        _Sprites ..= [[(  12,   -2), $00, SpriteSmall, $0F3, 3, 1, false, false]]

        .structSpriteArray aStatusScreenLargeMapSprite._Sprites

    .endsection Unsorted8989EASection


    .section Unsorted898A41Section

      .al
      .xl

      rsStatusScreenDrawPromotionMarker ; 89/8A41

        .al
        .xl
        .autsiz
        .databank ?

        ; Blinks aStatusScreenPromotionMarker beside the portrait when the unit is at its promotion level (wStatusScreenCanPromote).

        lda wStatusScreenCanPromote
        cmp #$0001
        bne _8A60
        lda wVBlankEnabledFramecount
        and #$0018
        beq _8A60
        stz wR0
        stz wR1
        stz wR4
        stz wR5
        ldy #<>aStatusScreenPromotionMarker
        jsl rlPushToOAMBuffer

        _8A60
        rts

        .databank 0

        ; 89/8A61

    .endsection Unsorted898A41Section


    .section Data898A61Section

      .al
      .xl

      aUnknown898A61 ; 89/8A61

        ; Nothing reads these twelve bytes.

        .byte $00, $01, $02, $01, $00, $01, $02, $03, $04, $03, $02, $01

      aStatusScreenPromotionMarker ; 89/8A6D

        _Sprites := [[(  13,   36), $00, SpriteSmall, $004, 3, 2, false, false]]
        _Sprites ..= [[(  21,   36), $00, SpriteSmall, $005, 3, 2, false, false]]
        _Sprites ..= [[(  29,   36), $00, SpriteSmall, $006, 3, 2, false, false]]

        .structSpriteArray aStatusScreenPromotionMarker._Sprites

        ; 89/8A7E

    .endsection Data898A61Section


    .section Unsorted898A7ESection

      .al
      .xl

      rsStatusScreenDrawRankIconsAndStars ; 89/8A7E

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame on the stat page: the leadership stars (none if the unit has a commander, or in step $08), and the ten weapon type icons beside the weapon ranks, which scroll with BG3.

        lda wGameStateStep,b
        cmp #STATUS_SCREEN_STEP_SKILL_DETAILS
        beq _8A9A
        lda wStatusScreenCommander
        bne _8A9A
        lda wStatusScreenLeadership
        ldx #$003F
        ldy #$00F3
        jsl rlStatusScreenDrawLeadershipStars

        _8A9A
        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        ldy #<>aStatusScreenWeaponRankIcons
        lda #$007E
        sta wR0
        lda #$00F1
        sec
        sbc wBufferBG3VOFS
        sta wR1
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/8AC1


      aStatusScreenWeaponRankIcons ; 89/8AC1

        _Sprites := [[(   1,    0), $21, SpriteLarge, $100, 2, 6, false, false]]
        _Sprites ..= [[(   1,   16), $21, SpriteLarge, $102, 2, 6, false, false]]
        _Sprites ..= [[(   1,   32), $21, SpriteLarge, $104, 2, 6, false, false]]
        _Sprites ..= [[(   1,   48), $21, SpriteLarge, $106, 2, 6, false, false]]
        _Sprites ..= [[(   1,   64), $21, SpriteLarge, $108, 2, 6, false, false]]
        _Sprites ..= [[(  57,    0), $21, SpriteLarge, $10A, 2, 6, false, false]]
        _Sprites ..= [[(  57,   16), $21, SpriteLarge, $10C, 2, 6, false, false]]
        _Sprites ..= [[(  57,   32), $21, SpriteLarge, $10E, 2, 6, false, false]]
        _Sprites ..= [[(  57,   48), $21, SpriteLarge, $120, 2, 6, false, false]]
        _Sprites ..= [[(  57,   64), $21, SpriteLarge, $122, 2, 6, false, false]]

        .structSpriteArray aStatusScreenWeaponRankIcons._Sprites

    .endsection Unsorted898A7ESection


    .section Unsorted898AF5Section

      .al
      .xl

      rsStatusScreenDrawEquippedWeaponIcon ; 89/8AF5

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; The weapon type icon of the first weapon the unit can use, beside the attack figures.

        jsl rlGetFirstEquippableWeaponInInventory
        lda wCurrentItemDataROMPointer,b
        beq _8B29
        jsl rlGetItemWeaponType
        tax
        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        lda #$00C8
        sta wR0
        lda #$0049
        sta wR1
        lda @l aStatusScreenWeaponTypeIconTiles,x
        and #$00FF
        sta wR4
        stz wR5
        phk
        plb
        .databank $89
        ldy #<>aStatusScreenWeaponTypeIcon
        jsl rlPushToOAMBuffer

        _8B29
        rts

        .databank 0

        ; 89/8B2A

    .endsection Unsorted898AF5Section


    .section Table898B2ASection

      .al
      .xl

      aStatusScreenWeaponTypeIconTiles ; 89/8B2A

        ; Read by rsStatusScreenDrawEquippedWeaponIcon: a byte per weapon type, added to the
        ; icon sprite's tile.

        .byte $00, $02, $04, $06, $08, $0A, $0C, $0E, $20, $22

      aStatusScreenWeaponTypeIcon ; 89/8B34

        _Sprites := [[(   0,  -64), $21, SpriteLarge, $100, 3, 6, false, false]]

        .structSpriteArray aStatusScreenWeaponTypeIcon._Sprites

        ; 89/8B3B

    .endsection Table898B2ASection
    .section Unsorted898B3BSection

      .al
      .xl

      rsStatusScreenDrawInventoryIcons ; 89/8B3B

        .al
        .xl
        .autsiz
        .databank ?

        ; The drop marker (rsStatusScreenDrawDropMarker), then an item icon for each of the wCastleListSubCount items, scrolling with BG3. rlUnknown8990DA loaded the icons into consecutive sprite tiles.

        jsr rsStatusScreenDrawDropMarker
        lda wCastleListSubCount,b
        sec
        sbc #$0001
        bmi _8B7F
        tax

        _8B48
        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        ldy #<>aStatusScreenInventoryIcon
        lda #$0086
        sta wR0
        lda @l aStatusScreenInventoryRowY,x
        and #$00FF
        clc
        adc #$00A9
        sec
        sbc wBufferBG3VOFS
        sta wR1
        lda @l aStatusScreenInventoryIconTiles,x
        and #$00FF
        sta wR4
        lda #$0000
        sta wR5
        phx
        jsl rlPushToOAMBuffer
        plx
        dec x
        bpl _8B48

        _8B7F
        rts

        .databank 0

        ; 89/8B80

    .endsection Unsorted898B3BSection


    .section Table898B80Section

      .al
      .xl

      aStatusScreenInventoryRowY ; 89/8B80

        ; A byte per inventory row: its Y on the page.

        .byte $00, $10, $20, $30, $40, $50, $60, $70

        ; 89/8B88

    .endsection Table898B80Section
    .section Data898B88Section

      .al
      .xl

      aStatusScreenInventoryIconTiles ; 89/8B88

        ; A byte per inventory row: the tile offset of its item icon (rlUnknown8990DA loaded
        ; the icons in that order).

        .byte $00, $02, $04, $06, $08, $0A, $0C, $0E

      aStatusScreenInventoryIcon ; 89/8B90

        _Sprites := [[(   0,  -64), $21, SpriteLarge, $060, 2, 3, false, false]]

        .structSpriteArray aStatusScreenInventoryIcon._Sprites

        ; 89/8B97

    .endsection Data898B88Section
    .section Unsorted898B97Section

      .al
      .xl

      rsStatusScreenDrawItemDetailSprites ; 89/8B97

        .al
        .xl
        .autsiz
        .databank ?

        ; In step $03: the selected item's icon beside the cursor, the uses marker for a player's weapon, its weapon type icon, and the weapon triangle for it (sword, lance, axe, or fire, thunder, wind), or the light and dark marker.

        phk
        plb
        .databank $89
        ldy #<>aStatusScreenItemDetailIcon
        lda wStatusScreenItemSlot
        tax
        dec x
        lda #$0010
        sta wR0
        lda #$0009
        sta wR1
        lda @l aStatusScreenItemIconTiles,x
        and #$00FF
        sta wR4
        lda #$2600
        sta wR5
        jsl rlPushToOAMBuffer
        lda wStatusScreenItemSlot
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemEquipmentType
        cmp #$0000
        beq _8BD8
        cmp #$0001
        beq _8BF9
        jml _8CBB


        _8BD8
        lda wStatusScreenFactionSlot
        bne _8BF9
        ldy #<>aStatusScreenItemDetailIcon
        lda #$003B
        sta wR0
        lda #$001B
        sta wR1
        lda #$000E
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer

        _8BF9
        jsl rlGetItemWeaponType
        sta wStatusScreenTemp1
        asl a
        tax
        lda @l aStatusScreenItemWeaponTypeTiles,x
        sta wR4
        lda #$0017
        sta wR0
        lda #$0019
        sta wR1
        lda #$3C00
        sta wR5
        ldy #<>aStatusScreenItemDetailIcon
        jsl rlPushToOAMBuffer
        lda wStatusScreenTemp1
        cmp #$0005
        bpl _8C65
        cmp #$0003
        bmi _8C31
        jml _8CBB


        _8C31
        lda #$0000
        sta wR0
        sta wR4
        sta wR5
        lda #$004A
        sta wR1
        ldy #<>aStatusScreenTriangleFrame
        jsl rlPushToOAMBuffer
        lda #$0000
        sta wR0
        sta wR4
        sta wR5
        lda #$004A
        sta wR1
        lda wStatusScreenTemp1
        asl a
        tax
        lda @l aStatusScreenPhysicalTriangleSprites,x
        tay
        jsl rlPushToOAMBuffer
        bra _8CBB


        _8C65
        lda wStatusScreenTemp1
        cmp #$0008
        bpl _8CA6
        lda #$0000
        sta wR0
        sta wR4
        sta wR5
        lda #$004A
        sta wR1
        ldy #<>aStatusScreenTriangleFrame
        jsl rlPushToOAMBuffer
        lda #$0000
        sta wR0
        sta wR4
        sta wR5
        lda #$004A
        sta wR1
        lda wStatusScreenTemp1
        sec
        sbc #$0005
        asl a
        tax
        lda @l aStatusScreenMagicTriangleSprites,x
        tay
        jsl rlPushToOAMBuffer
        bra _8CBB


        _8CA6
        lda #$0000
        sta wR0
        sta wR4
        sta wR5
        lda #$004A
        sta wR1
        ldy #<>aStatusScreenLightDarkSprites
        jsl rlPushToOAMBuffer

        _8CBB
        rts

        .databank 0

        ; 89/8CBC

    .endsection Unsorted898B97Section


    .section Data898CBCSection

      .al
      .xl

      aStatusScreenItemIconTiles ; 89/8CBC

        ; A byte per inventory slot (1-8): the tile offset of its item icon.

        .byte $60, $62, $64, $66, $68, $6A, $6C, $6E

      aStatusScreenItemDetailIcon ; 89/8CC4

        _Sprites := [[(   0,   80), $21, SpriteLarge, $000, 0, 0, false, false]]

        .structSpriteArray aStatusScreenItemDetailIcon._Sprites

      aStatusScreenTriangleFrame ; 89/8CCB

        ; Behind the weapon triangle.

        _Sprites := [[(  24,  112), $21, SpriteLarge, $000, 3, 0, false, false]]
        _Sprites ..= [[(  72,  112), $21, SpriteLarge, $000, 3, 0, false, true]]

        .structSpriteArray aStatusScreenTriangleFrame._Sprites

      aStatusScreenPhysicalTriangleSprites ; 89/8CD7

        ; By weapon type: sword, lance, axe.

        .word <>aStatusScreenSwordTriangle
        .word <>aStatusScreenLanceTriangle
        .word <>aStatusScreenAxeTriangle

      aStatusScreenSwordTriangle ; 89/8CDD

        _Sprites := [[(  40,  112), $21, SpriteLarge, $104, 3, 6, false, false]]
        _Sprites ..= [[(  88,  112), $21, SpriteLarge, $102, 3, 6, false, false]]

        .structSpriteArray aStatusScreenSwordTriangle._Sprites

      aStatusScreenLanceTriangle ; 89/8CE9

        _Sprites := [[(  40,  112), $21, SpriteLarge, $100, 3, 6, false, false]]
        _Sprites ..= [[(  88,  112), $21, SpriteLarge, $104, 3, 6, false, false]]

        .structSpriteArray aStatusScreenLanceTriangle._Sprites

      aStatusScreenAxeTriangle ; 89/8CF5

        _Sprites := [[(  40,  112), $21, SpriteLarge, $102, 3, 6, false, false]]
        _Sprites ..= [[(  88,  112), $21, SpriteLarge, $100, 3, 6, false, false]]

        .structSpriteArray aStatusScreenAxeTriangle._Sprites

      aStatusScreenMagicTriangleSprites ; 89/8D01

        ; By weapon type less 5: fire, thunder, wind.

        .word <>aStatusScreenFireTriangle
        .word <>aStatusScreenThunderTriangle
        .word <>aStatusScreenWindTriangle

      aStatusScreenFireTriangle ; 89/8D07

        _Sprites := [[(  40,  112), $21, SpriteLarge, $10E, 3, 6, false, false]]
        _Sprites ..= [[(  88,  112), $21, SpriteLarge, $10C, 3, 6, false, false]]

        .structSpriteArray aStatusScreenFireTriangle._Sprites

      aStatusScreenThunderTriangle ; 89/8D13

        _Sprites := [[(  40,  112), $21, SpriteLarge, $10A, 3, 6, false, false]]
        _Sprites ..= [[(  88,  112), $21, SpriteLarge, $10E, 3, 6, false, false]]

        .structSpriteArray aStatusScreenThunderTriangle._Sprites

      aStatusScreenWindTriangle ; 89/8D1F

        _Sprites := [[(  40,  112), $21, SpriteLarge, $10C, 3, 6, false, false]]
        _Sprites ..= [[(  88,  112), $21, SpriteLarge, $10A, 3, 6, false, false]]

        .structSpriteArray aStatusScreenWindTriangle._Sprites

      aStatusScreenLightDarkSprites ; 89/8D2B

        ; For light and dark magic, outside the triangles.

        _Sprites := [[(  28,  112), $21, SpriteLarge, $000, 3, 0, false, false]]
        _Sprites ..= [[(  46,  112), $21, SpriteLarge, $10A, 3, 6, false, false]]
        _Sprites ..= [[(  64,  112), $21, SpriteLarge, $10C, 3, 6, false, false]]
        _Sprites ..= [[(  82,  112), $21, SpriteLarge, $10E, 3, 6, false, false]]

        .structSpriteArray aStatusScreenLightDarkSprites._Sprites

      aStatusScreenItemWeaponTypeTiles ; 89/8D41

        ; A word per weapon type: the tile of its icon.

        .word $0100, $0102, $0104, $0106, $0108, $010A, $010C, $010E
        .word $0120, $0122

        ; 89/8D55

    .endsection Data898CBCSection
    .section Unsorted898D55Section

      .al
      .xl

      rsStatusScreenDrawHolyBloodPageSprites ; 89/8D55

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame on the holy blood page: the ring of twelve crests, the glints of each blood the unit has, and Loptous's crest.

        jsr rsStatusScreenDrawHolyBloodRing
        jsr rsStatusScreenDrawHolyBloodGlints
        jsr rsStatusScreenDrawLoptousCrest
        rts

        .databank 0

        ; 89/8D5F

      rsStatusScreenDrawLoptousCrest ; 89/8D5F

        .al
        .xl
        .autsiz
        .databank ?

        ; Major Loptous blood (wStatusScreenLoptousBlood 2): the crest and two glint animations; minor: one glint; none: nothing.

        lda wStatusScreenLoptousBlood
        cmp #MajorHolyBlood
        beq _8D6C
        jml _8E14


        _8D6C
        lda #$0078
        sta wR0
        lda #$00B0
        sta wR1
        stz wR4
        stz wR5
        phk
        plb
        .databank $89
        ldy #<>aStatusScreenLoptousCrest
        jsl rlPushToOAMBuffer
        lda wStatusScreenLoptousGlintTimer
        bne _8DA8
        lda #$0006
        sta wStatusScreenLoptousGlintTimer
        lda wStatusScreenLoptousGlintFrame
        inc a
        cmp #$0004
        bcc _8DA4
        lda #$000F
        sta wStatusScreenLoptousGlintTimer
        lda #$0000

        _8DA4
        sta wStatusScreenLoptousGlintFrame

        _8DA8
        lda wStatusScreenLoptousGlintTimer
        dec a
        sta wStatusScreenLoptousGlintTimer
        lda #$007C
        sta wR0
        lda #$00A0
        sta wR1
        stz wR4
        stz wR5
        lda wStatusScreenLoptousGlintFrame
        asl a
        tax
        lda @l aStatusScreenLoptousGlintFrames,x
        tay
        jsl rlPushToOAMBuffer
        lda wStatusScreenLoptousGlint2Timer
        bne _8DEC
        lda #$0003
        sta wStatusScreenLoptousGlint2Timer
        lda wStatusScreenLoptousGlint2Frame
        inc a
        cmp #$0004
        bcc _8DE8
        lda #$0000

        _8DE8
        sta wStatusScreenLoptousGlint2Frame

        _8DEC
        lda wStatusScreenLoptousGlint2Timer
        dec a
        sta wStatusScreenLoptousGlint2Timer
        lda #$0078
        sta wR0
        lda #$009C
        sta wR1
        stz wR4
        stz wR5
        lda wStatusScreenLoptousGlint2Frame
        asl a
        tax
        lda @l aStatusScreenLoptousGlint2Frames,x
        tay
        jsl rlPushToOAMBuffer
        bra _8E64


        _8E14
        cmp #$0000
        beq _8E64
        lda wStatusScreenLoptousGlintTimer
        bne _8E3E
        lda #$000B
        sta wStatusScreenLoptousGlintTimer
        lda wStatusScreenLoptousGlintFrame
        inc a
        cmp #$0004
        bcc _8E3A
        lda #$0019
        sta wStatusScreenLoptousGlintTimer
        lda #$0000

        _8E3A
        sta wStatusScreenLoptousGlintFrame

        _8E3E
        lda wStatusScreenLoptousGlintTimer
        dec a
        sta wStatusScreenLoptousGlintTimer
        lda #$007C
        sta wR0
        lda #$00A0
        sta wR1
        stz wR4
        stz wR5
        lda wStatusScreenLoptousGlintFrame
        asl a
        tax
        lda @l aStatusScreenLoptousGlintFrames,x
        tay
        jsl rlPushToOAMBuffer

        _8E64
        rts

        .databank 0

        ; 89/8E65

    .endsection Unsorted898D55Section


    .section SpriteArray898E65Section

      .al
      .xl

      aStatusScreenLoptousCrest ; 89/8E65

        _Sprites := [[(   0,    0), $21, SpriteLarge, $168, 3, 7, false, false]]

        .structSpriteArray aStatusScreenLoptousCrest._Sprites

        ; 89/8E6C

    .endsection SpriteArray898E65Section


    .section Table898E6CSection

      .al
      .xl

      aStatusScreenLoptousGlintFrames ; 89/8E6C

        ; Four frames of the first glint on Loptous's crest.

        .word <>aStatusScreenLoptousGlintA0
        .word <>aStatusScreenLoptousGlintA1
        .word <>aStatusScreenLoptousGlintA2
        .word <>aStatusScreenLoptousGlintA3

      aStatusScreenLoptousGlintA0 ; 89/8E74

        _Sprites := [[(   0,    0), $00, SpriteSmall, $199, 3, 5, false, false]]

        .structSpriteArray aStatusScreenLoptousGlintA0._Sprites

      aStatusScreenLoptousGlintA1 ; 89/8E7B

        _Sprites := [[(   0,    0), $00, SpriteSmall, $188, 3, 5, false, false]]

        .structSpriteArray aStatusScreenLoptousGlintA1._Sprites

      aStatusScreenLoptousGlintA2 ; 89/8E82

        _Sprites := [[(   0,    0), $00, SpriteSmall, $189, 3, 5, false, false]]

        .structSpriteArray aStatusScreenLoptousGlintA2._Sprites

      aStatusScreenLoptousGlintA3 ; 89/8E89

        _Sprites := [[(   0,    0), $00, SpriteSmall, $198, 3, 5, false, false]]

        .structSpriteArray aStatusScreenLoptousGlintA3._Sprites

        ; 89/8E90

    .endsection Table898E6CSection
    .section Table898E90Section

      .al
      .xl

      aStatusScreenLoptousGlint2Frames ; 89/8E90

        ; Four frames of the second glint (major blood only).

        .word <>aStatusScreenLoptousGlintB0
        .word <>aStatusScreenLoptousGlintB1
        .word <>aStatusScreenLoptousGlintB2
        .word <>aStatusScreenLoptousGlintB3

      aStatusScreenLoptousGlintB0 ; 89/8E98

        _Sprites := [[(   0,    0), $21, SpriteLarge, $18A, 3, 5, false, false]]

        .structSpriteArray aStatusScreenLoptousGlintB0._Sprites

      aStatusScreenLoptousGlintB1 ; 89/8E9F

        _Sprites := [[(   0,    0), $21, SpriteLarge, $18C, 3, 5, false, false]]

        .structSpriteArray aStatusScreenLoptousGlintB1._Sprites

      aStatusScreenLoptousGlintB2 ; 89/8EA6

        _Sprites := [[(   0,    0), $21, SpriteLarge, $18E, 3, 5, false, false]]

        .structSpriteArray aStatusScreenLoptousGlintB2._Sprites

      aStatusScreenLoptousGlintB3 ; 89/8EAD

        _Sprites := [[(   0,    0), $21, SpriteLarge, $18C, 3, 5, false, false]]

        .structSpriteArray aStatusScreenLoptousGlintB3._Sprites

        ; 89/8EB4

    .endsection Table898E90Section
    .section Unsorted898EB4Section

      .al
      .xl

      rsStatusScreenDrawHolyBloodRing ; 89/8EB4

        .al
        .xl
        .autsiz
        .databank ?

        ; The ring of twelve crests on the holy blood page.

        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        ldy #<>aStatusScreenHolyBloodRingSprites
        lda #$007E
        sta wR0
        lda #$00AC
        sta wR1
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/8ED8


      aStatusScreenHolyBloodRingSprites ; 89/8ED8

        _Sprites := [[(  32,   32), $21, SpriteLarge, $14E, 3, 7, false, false]]
        _Sprites ..= [[(  48,   16), $21, SpriteLarge, $160, 3, 7, false, false]]
        _Sprites ..= [[(  56,    0), $21, SpriteLarge, $164, 3, 7, false, false]]
        _Sprites ..= [[(  56,  -24), $21, SpriteLarge, $144, 3, 7, false, false]]
        _Sprites ..= [[(  48,  -48), $21, SpriteLarge, $14C, 3, 7, false, false]]
        _Sprites ..= [[(  32,  -64), $21, SpriteLarge, $14A, 3, 7, false, false]]
        _Sprites ..= [[( -40,   32), $21, SpriteLarge, $148, 3, 7, false, false]]
        _Sprites ..= [[( -56,   16), $21, SpriteLarge, $140, 3, 7, false, false]]
        _Sprites ..= [[( -64,    0), $21, SpriteLarge, $142, 3, 7, false, false]]
        _Sprites ..= [[( -64,  -24), $21, SpriteLarge, $166, 3, 7, false, false]]
        _Sprites ..= [[( -56,  -48), $21, SpriteLarge, $162, 3, 7, false, false]]
        _Sprites ..= [[( -40,  -64), $21, SpriteLarge, $146, 3, 7, false, false]]

        .structSpriteArray aStatusScreenHolyBloodRingSprites._Sprites

    .endsection Unsorted898EB4Section


    .section Unsorted898F16Section

      .al
      .xl

      rsStatusScreenDrawHolyBloodGlints ; 89/8F16

        .al
        .xl
        .autsiz
        .databank ?

        ; For each of the twelve bloods in the ring: a glint for minor or major blood, and a second one for major.

        lda #$0000

        _8F19
        sta wStatusScreenTemp1
        asl a
        tax
        lda aStatusScreenHolyBloodLevels,x
        beq _8F38
        jsr rsStatusScreenDrawHolyBloodGlint
        lda wStatusScreenTemp1
        asl a
        tax
        lda aStatusScreenHolyBloodLevels,x
        dec a
        beq _8F38
        jsr rsStatusScreenDrawMajorBloodGlint

        _8F38
        lda wStatusScreenTemp1
        inc a
        cmp #$000C
        bne _8F19
        rts

        .databank 0

        ; 89/8F43

    .endsection Unsorted898F16Section


    .section Table898F43Section

      .al
      .xl

      aStatusScreenHolyBloodRingX ; 89/8F43

        ; Read by rsStatusScreenDrawHolyBloodGlint, rsStatusScreenDrawMajorBloodGlint.

        .word $0071, $0054, $009B, $0060, $0088, $00A5, $0054, $0089
        .word $009A, $0060, $00A6, $0071

        ; 89/8F5B

    .endsection Table898F43Section


    .section Table898F5BSection

      .al
      .xl

      aStatusScreenHolyBloodRingY ; 89/8F5B

        ; Read by rsStatusScreenDrawHolyBloodGlint, rsStatusScreenDrawMajorBloodGlint.

        .word $0081, $00A1, $008E, $00CB, $0081, $00A0, $00B8, $00D6
        .word $00CB, $008D, $00B8, $00D6

        ; 89/8F73

    .endsection Table898F5BSection


    .section Unsorted898F73Section

      .al
      .xl

      rsStatusScreenDrawHolyBloodGlint ; 89/8F73

        .al
        .xl
        .autsiz
        .databank ?

        ; The first glint of the blood in wStatusScreenTemp1: four frames, each held for the blood's time in aStatusScreenGlintFrameTimes; after the last frame the pause in aStatusScreenGlintPauseTimes.

        lda wStatusScreenTemp1
        asl a
        tax
        lda aStatusScreenGlintTimers,x
        bne _8FA0
        lda aStatusScreenGlintFrameTimes,x
        sta aStatusScreenGlintTimers,x
        lda aStatusScreenGlintFrameIDs,x
        inc a
        cmp #$0004
        bne _8F9C
        lda aStatusScreenGlintPauseTimes,x
        sta aStatusScreenGlintTimers,x
        lda #$0000

        _8F9C
        sta aStatusScreenGlintFrameIDs,x

        _8FA0
        lda aStatusScreenGlintTimers,x
        dec a
        sta aStatusScreenGlintTimers,x
        lda aStatusScreenHolyBloodRingX,x
        sec
        sbc #$0001
        sta wR0
        lda aStatusScreenHolyBloodRingY,x
        sec
        sbc #$0004
        sta wR1
        lda #$0000
        sta wR4
        sta wR5
        lda aStatusScreenGlintFrameIDs,x
        asl a
        tax
        lda aStatusScreenGlintFrames,x
        tay
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/8FD4

    .endsection Unsorted898F73Section


    .section Table898FD4Section

      .al
      .xl

      aStatusScreenGlintFrameTimes ; 89/8FD4

        ; Read by rsStatusScreenDrawHolyBloodGlint.

        .word $000B, $0008, $000D, $0009, $000E, $000A, $0008, $000A
        .word $000C, $0009, $0008, $000B

        ; 89/8FEC

    .endsection Table898FD4Section


    .section Table898FECSection

      .al
      .xl

      aStatusScreenGlintPauseTimes ; 89/8FEC

        ; Read by rsStatusScreenDrawHolyBloodGlint.

        .word $0019, $0013, $001A, $0020, $0018, $0015, $001B, $0012
        .word $0025, $0019, $000F, $001B

        ; 89/9004

    .endsection Table898FECSection


    .section Table899004Section

      .al
      .xl

      aStatusScreenGlintFrames ; 89/9004

        ; Four frames of a blood's first glint.

        .word <>aStatusScreenGlint0
        .word <>aStatusScreenGlint1
        .word <>aStatusScreenGlint2
        .word <>aStatusScreenGlint3

      aStatusScreenGlint0 ; 89/900C

        _Sprites := [[(   0,   -8), $00, SpriteSmall, $191, 3, 5, false, false]]

        .structSpriteArray aStatusScreenGlint0._Sprites

      aStatusScreenGlint1 ; 89/9013

        _Sprites := [[(   0,   -8), $00, SpriteSmall, $180, 3, 5, false, false]]

        .structSpriteArray aStatusScreenGlint1._Sprites

      aStatusScreenGlint2 ; 89/901A

        _Sprites := [[(   0,   -8), $00, SpriteSmall, $181, 3, 5, false, false]]

        .structSpriteArray aStatusScreenGlint2._Sprites

      aStatusScreenGlint3 ; 89/9021

        _Sprites := [[(   0,   -8), $00, SpriteSmall, $190, 3, 5, false, false]]

        .structSpriteArray aStatusScreenGlint3._Sprites

        ; 89/9028

    .endsection Table899004Section
    .section Unsorted899028Section

      .al
      .xl

      rsStatusScreenDrawMajorBloodGlint ; 89/9028

        .al
        .xl
        .autsiz
        .databank ?

        ; The second glint of a major blood in wStatusScreenTemp1, on its own timer (aStatusScreenMajorGlintFrameTimes).

        lda wStatusScreenTemp1
        asl a
        tax
        lda aStatusScreenMajorGlintTimers,x
        bne _904D
        lda aStatusScreenMajorGlintFrameTimes,x
        sta aStatusScreenMajorGlintTimers,x
        lda aStatusScreenMajorGlintIDs,x
        inc a
        cmp #$0004
        bne _9049
        lda #$0000

        _9049
        sta aStatusScreenMajorGlintIDs,x

        _904D
        lda aStatusScreenMajorGlintTimers,x
        dec a
        sta aStatusScreenMajorGlintTimers,x
        lda aStatusScreenHolyBloodRingX,x
        sec
        sbc #$0001
        sta wR0
        lda aStatusScreenHolyBloodRingY,x
        sec
        sbc #$0004
        sta wR1
        lda #$0000
        sta wR4
        sta wR5
        lda aStatusScreenMajorGlintIDs,x
        asl a
        tax
        lda aStatusScreenMajorGlintFrames,x
        tay
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/9081

    .endsection Unsorted899028Section


    .section Table899081Section

      .al
      .xl

      aStatusScreenMajorGlintFrameTimes ; 89/9081

        ; Read by rsStatusScreenDrawMajorBloodGlint.

        .word $0007, $0008, $0007, $0009, $0007, $0009, $0008, $0007
        .word $0008, $0009, $0008, $0007

        ; 89/9099

    .endsection Table899081Section


    .section Data899099Section

      .al
      .xl

      aStatusScreenMajorGlintFrames ; 89/9099

        ; Four frames of a major blood's second glint.

        .word <>aStatusScreenMajorGlint0
        .word <>aStatusScreenMajorGlint1
        .word <>aStatusScreenMajorGlint2
        .word <>aStatusScreenMajorGlint3

      aStatusScreenMajorGlint0 ; 89/90A1

        _Sprites := [[(  -4,  -12), $21, SpriteLarge, $182, 3, 5, false, false]]

        .structSpriteArray aStatusScreenMajorGlint0._Sprites

      aStatusScreenMajorGlint1 ; 89/90A8

        _Sprites := [[(  -4,  -12), $21, SpriteLarge, $184, 3, 5, false, false]]

        .structSpriteArray aStatusScreenMajorGlint1._Sprites

      aStatusScreenMajorGlint2 ; 89/90AF

        _Sprites := [[(  -4,  -12), $21, SpriteLarge, $186, 3, 5, false, false]]

        .structSpriteArray aStatusScreenMajorGlint2._Sprites

      aStatusScreenMajorGlint3 ; 89/90B6

        _Sprites := [[(  -4,  -12), $21, SpriteLarge, $184, 3, 5, false, false]]

        .structSpriteArray aStatusScreenMajorGlint3._Sprites

        ; 89/90BD

    .endsection Data899099Section
    .section Unsorted8990BDSection

      .al
      .xl

      rlStatusScreenGetHolyBloodLevels ; 89/90BD

        .al
        .xl
        .autsiz
        .databank ?

        ; Fills aStatusScreenHolyBloodLevels with the unit's level (0 none, 1 minor, 2 major) of each of the 13 holy bloods.

        lda #$0000

        _90C0
        sta wR0
        jsl rlCheckForSpecifiedHolyBlood
        tay
        lda wR0
        asl a
        tax
        tya
        sta aStatusScreenHolyBloodLevels,x
        lda wR0
        inc a
        cmp #$000D
        bne _90C0
        rtl

        .databank 0

        ; 89/90D9

      aUnknown8990D9 ; 89/90D9

        ; A second rtl after the routine's own; nothing reaches it.

        .byte $6B

        ; 89/90DA

    .endsection Unsorted8990BDSection


    .section Table899140Section

      .al
      .xl

      aStatusScreenBG3SplitHDMA .dstruct structHDMADirectEntryInfo, rlStatusScreenBuildBG3SplitTable, rlStatusScreenBuildBG3SplitTable, aStatusScreenHDMAHalt, $0008C8, PPU_REG_BASE + $12, $02 ; 89/9140

    .endsection Table899140Section


    .section Unsorted89914BSection

      .al
      .xl

      rlStatusScreenBuildBG3SplitTable ; 89/914B

        .al
        .xl
        .autsiz
        .databank ?

        ; HDMA table for BG3's vertical scroll at $08C8: the top $57 lines stay put, the lines below scroll by wBufferBG3VOFS. The page header stays while the stats scroll.

        sep #$20
        lda #$57
        sta $08C8,b
        rep #$20
        lda #$FFFF
        sta $08C9,b
        sep #$20
        lda #$01
        sta $08CB,b
        rep #$20
        lda wBufferBG3VOFS
        sta $08CC,b
        sep #$20
        lda #$00
        sta $08CE,b
        rep #$20
        lda #$0000
        sta $08CF,b
        rtl

        .databank 0

        ; 89/9178

    .endsection Unsorted89914BSection


    .section Table899178Section

      .al
      .xl

      aStatusScreenHDMAHalt ; 89/9178
        HDMA_HALT

      aStatusScreenBG1SplitHDMA .dstruct structHDMADirectEntryInfo, rlStatusScreenBuildBG1SplitTable, rlStatusScreenBuildBG1SplitTable, aStatusScreenHDMAHalt, aStatusScreenBG1SplitTable, PPU_REG_BASE + $0E, $02 ; 89/917A

    .endsection Table899178Section


    .section Unsorted899185Section

      .al
      .xl

      rlStatusScreenBuildBG1SplitTable ; 89/9185

        .al
        .xl
        .autsiz
        .databank ?

        ; As rlStatusScreenBuildBG3SplitTable, for BG1 (table at $7FB160, scrolled by wBufferBG1VOFS-1).

        sep #$20
        lda #$57
        sta aStatusScreenBG1SplitTable
        rep #$20
        lda #$FFFF
        sta aStatusScreenBG1SplitTable+1
        sep #$20
        lda #$01
        sta aStatusScreenBG1SplitTable+3
        rep #$20
        lda wBufferBG1VOFS
        dec a
        sta aStatusScreenBG1SplitTable+4
        sep #$20
        lda #$00
        sta aStatusScreenBG1SplitTable+6
        rep #$20
        lda #$0000
        sta aStatusScreenBG1SplitTable+7
        rtl

        .databank 0

        ; 89/91B9

    .endsection Unsorted899185Section


    .section Table8991B9Section

      .al
      .xl

      aStatusScreenGradientHDMA .dstruct structHDMADirectEntryInfo, rlStatusScreenInitGradientHDMA, rlStatusScreenGradientHDMAIdle, aStatusScreenHDMAHalt, aStatusScreenGradientTable, PPU_REG_BASE + $32, $00 ; 89/91B9

    .endsection Table8991B9Section


    .section Unsorted8991C4Section

      .al
      .xl

      rlStatusScreenInitGradientHDMA ; 89/91C4

        .al
        .xl
        .autsiz
        .databank ?

        ; The gradient HDMA's start: writes the stat page's colour table (as if in step $01).

        lda #STATUS_SCREEN_STEP_BOTTOM_PAGE
        sta wGameStateStep,b
        jsl rlStatusScreenSetGradient
        stz wGameStateStep,b
        rtl

        .databank 0

        ; 89/91D2

      rlStatusScreenGradientHDMAIdle ; 89/91D2

        .al
        .xl
        .autsiz
        .databank ?

        ; The gradient HDMA's per-frame routine: nothing.

        rtl

        .databank 0

        ; 89/91D3

      rlUnknown8991D3 ; 89/91D3

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing calls it. Builds an HDMA table for BG2's scroll at $08BC, as rlStatusScreenBuildBG3SplitTable does for BG3: $57 lines at 0, then wBufferBG2VOFS.

        sep #$20
        lda #$57
        sta $08BC,b
        rep #$20
        lda #$0000
        sta $08BD,b
        sep #$20
        lda #$01
        sta $08BF,b
        rep #$20
        lda wBufferBG2VOFS
        sta $08C0,b
        sep #$20
        lda #$00
        sta $08C2,b
        rep #$20
        lda #$0000
        sta $08C3,b
        rtl

        .databank 0

        ; 89/9200

    .endsection Unsorted8991C4Section


    .section Unsorted899200Section

      .al
      .xl

      rlStatusScreenSetGradient ; 89/9200

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the background gradient for the current page into the COLDATA HDMA table at $7FB0B6: one for the stat page, one for the holy blood page, and another for the holy blood page of a unit with major Loptous blood.

        ldx #$0000
        lda wGameStateStep,b
        cmp #STATUS_SCREEN_STEP_HOLY_BLOOD_PAGE
        beq _9219

        _920B
        lda aStatusScreenStatPageGradient,x
        sta aStatusScreenGradientTable,x
        beq _923E
        inc x
        inc x
        bra _920B


        _9219
        lda wStatusScreenLoptousBlood
        cmp #MajorHolyBlood
        beq _9230

        _9222
        lda aStatusScreenHolyBloodPageGradient,x
        sta aStatusScreenGradientTable,x
        beq _923E
        inc x
        inc x
        bra _9222


        _9230
        lda aStatusScreenLoptousPageGradient,x
        sta aStatusScreenGradientTable,x
        beq _923E
        inc x
        inc x
        bra _9230


        _923E
        rtl

        .databank 0

        ; 89/923F

    .endsection Unsorted899200Section


    .section Data89923FSection

      .al
      .xl

      aStatusScreenStatPageGradient ; 89/923F

        ; Read by rlStatusScreenSetGradient.

        .word $E016, $E110, $E20D, $E30B, $E40A, $E508, $E508, $E801
        .word $E601, $E401, $E214, $E312, $E412, <>rsDebugMenuTab3Page6, $E610, $E70E
        .word $E80D, $E910, $0000

        ; 89/9265

      aStatusScreenHolyBloodPageGradient ; 89/9265

        ; Read by rlStatusScreenSetGradient.

        .word $E016, $E110, $E20D, $E30B, $E40A, $E508, $E508, $E801
        .word $E601, $E401, $E118, $E214, $E414, <>rsDebugMenuTab3Page6, $E612, $E711
        .word $E810, $0000

        ; 89/9289

      aStatusScreenLoptousPageGradient ; 89/9289

        ; Read by rlStatusScreenSetGradient.

        .word $E016, $E110, $E20D, $E30B, $E40A, $E508, $E508, $E801
        .word $E601, $E401, $E415, $E514, $E614, $E714, $E812, $E912
        .word $EA10, $0000

        ; 89/92AD

    .endsection Data89923FSection


    .section Unsorted8992ADSection

      .al
      .xl

      rsStatusScreenDrawSkillIcons ; 89/92AD

        .al
        .xl
        .autsiz
        .databank ?

        ; On the bottom half: the icons of the unit's skills in a row, scrolling with BG3.

        lda wStatusScreenSkillCount
        beq _92E6
        phk
        plb
        .databank $89
        lda #$0000

        _92B8
        sta wR15
        asl a
        tax
        lda aStatusScreenSkillIconTiles,x
        sta wR4
        lda wR15
        asl a
        tax
        lda @l aStatusScreenSkillIconX,x
        sta wR0
        lda #$0150
        sec
        sbc wBufferBG3VOFS
        sta wR1
        stz wR5
        ldy #<>aStatusScreenSkillIcon
        jsl rlPushToOAMBuffer
        lda wR15
        inc a
        cmp wStatusScreenSkillCount
        bne _92B8

        _92E6
        rts

        .databank 0

        ; 89/92E7

    .endsection Unsorted8992ADSection


    .section Table8992E7Section

      .al
      .xl

      aStatusScreenSkillIconX ; 89/92E7

        ; A word per skill icon in the row: its X.

        .word $0080, $0094, $00A8, $00BC, $00D0, $00E4, $00F8, $010C

      aStatusScreenSkillIcon ; 89/92F7

        _Sprites := [[(   0,    0), $21, SpriteLarge, $080, 3, 7, false, false]]

        .structSpriteArray aStatusScreenSkillIcon._Sprites

      aStatusScreenSkillIcons ; 89/92FE

        ; A word per skill, as rlCollectSelectedUnitIconSkills numbers them: the tile offset of its icon,
        ; or $FFFF for a skill the status screen does not show.

        .word $FFFF, $FFFF, $0006, $0000, $0002, $0004, $0044, $FFFF
        .word $0046, $FFFF, $FFFF, $FFFF, $0008, $FFFF, $000C, $000E
        .word $0020, $0022, $0024, $0026, $0028, $002A, $002C, $002E
        .word $0040, $0042, $FFFF, $FFFF, $0048, $FFFF, $FFFF

        ; 89/933C

    .endsection Table8992E7Section
    .section Unsorted89933CSection

      .al
      .xl

      rsStatusScreenDrawDropMarker ; 89/933C

        .al
        .xl
        .autsiz
        .databank ?

        ; A marker beside the inventory row of the item the unit drops when defeated or holds as unique (wStatusScreenDropItemSlot), if any.

        phk
        plb
        .databank $89
        lda wStatusScreenDropItemSlot
        beq _935E
        tax
        lda @l aStatusScreenDropMarkerY,x
        and #$00FF
        sec
        sbc wBufferBG3VOFS
        sta wR1
        stz wR0
        stz wR4
        stz wR5
        ldy #<>aStatusScreenDropMarker
        jsl rlPushToOAMBuffer

        _935E
        rts

        .databank 0

        ; 89/935F

    .endsection Unsorted89933CSection


    .section Data89935FSection

      .al
      .xl

      aStatusScreenDropMarkerY ; 89/935F

        ; A byte per inventory slot (0-7 from wStatusScreenDropItemSlot): the marker's Y.

        .byte $00, $00, $10, $20, $30, $40, $50, $60

      aStatusScreenDropMarker ; 89/9367

        _Sprites := [[( 214,  105), $21, SpriteLarge, $007, 2, 3, false, false]]

        .structSpriteArray aStatusScreenDropMarker._Sprites

        ; 89/936E

    .endsection Data89935FSection
    .section Unsorted89936ESection

      .al
      .xl

      rsStatusScreenDrawItemDescription ; 89/936E

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the selected item's description into the buffer at $7FAF4E and copies its six rows over the stats.

        lda #(`aUnknown89ACBC)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown89ACBC
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        ldx #$00C0

        _9380
        sta aStatusScreenTextBuffer-2,x
        dec x
        dec x
        bne _9380
        lda aCurrentTilemapInfo,b
        pha
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0000
        jsl rlDrawMenuTextLine
        pla
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown89ACB3)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown89ACB3
        sta lMapMenuTilemapRAMEntryPointer,b
        ldx #$0000

        _93BA
        lda aStatusScreenTextBuffer+$0,x
        sta aBG3TilemapBuffer+$3C8,x
        lda aStatusScreenTextBuffer+$60,x
        sta aBG3TilemapBuffer+$408,x
        inc x
        inc x
        cpx #$0010
        bne _93BA
        ldx #$0000

        _93D4
        lda aStatusScreenTextBuffer+$10,x
        sta aBG3TilemapBuffer+$448,x
        lda aStatusScreenTextBuffer+$70,x
        sta aBG3TilemapBuffer+$488,x
        inc x
        inc x
        cpx #$0010
        bne _93D4
        ldx #$0000

        _93EE
        lda aStatusScreenTextBuffer+$20,x
        sta aBG3TilemapBuffer+$4C8,x
        lda aStatusScreenTextBuffer+$80,x
        sta aBG3TilemapBuffer+$508,x
        inc x
        inc x
        cpx #$0010
        bne _93EE
        ldx #$0000

        _9408
        lda aStatusScreenTextBuffer+$30,x
        sta aBG3TilemapBuffer+$548,x
        lda aStatusScreenTextBuffer+$90,x
        sta aBG3TilemapBuffer+$588,x
        inc x
        inc x
        cpx #$0010
        bne _9408
        ldx #$0000

        _9422
        lda aStatusScreenTextBuffer+$40,x
        sta aBG3TilemapBuffer+$5C8,x
        lda aStatusScreenTextBuffer+$A0,x
        sta aBG3TilemapBuffer+$608,x
        inc x
        inc x
        cpx #$0010
        bne _9422
        ldx #$0000

        _943C
        lda aStatusScreenTextBuffer+$50,x
        sta aBG3TilemapBuffer+$648,x
        lda aStatusScreenTextBuffer+$B0,x
        sta aBG3TilemapBuffer+$688,x
        inc x
        inc x
        cpx #$0010
        bne _943C
        rts

        .databank 0

        ; 89/9454

      rsStatusScreenDrawWeaponDescription ; 89/9454

        .al
        .xl
        .autsiz
        .databank ?

        ; As rsStatusScreenDrawItemDescription, but copies only the first row, under a weapon's figures.

        lda #(`aUnknown89ACBC)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown89ACBC
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        ldx #$00C0

        _9466
        sta aStatusScreenTextBuffer-2,x
        dec x
        dec x
        bne _9466
        lda aCurrentTilemapInfo,b
        pha
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0000
        jsl rlDrawMenuTextLine
        pla
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown89ACB3)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown89ACB3
        sta lMapMenuTilemapRAMEntryPointer,b
        ldx #$0000

        _94A0
        lda aStatusScreenTextBuffer+$0,x
        sta aBG3TilemapBuffer+$648,x
        lda aStatusScreenTextBuffer+$60,x
        sta aBG3TilemapBuffer+$688,x
        inc x
        inc x
        cpx #$0010
        bne _94A0
        rts

        .databank 0

        ; 89/94B8

    .endsection Unsorted89936ESection


    .section Unsorted8994B8Section

      .al
      .xl

      rsStatusScreenDrawScrollArrow ; 89/94B8

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $07's work, every frame: a blinking arrow that points down at the top of the stat page and up at the bottom.

        phk
        plb
        .databank $89
        lda wVBlankEnabledFramecount
        and #$0018
        beq _9508
        lda wStatusScreenScroll
        beq _94EE
        cmp #STATUS_SCREEN_SCROLL_BOTTOM
        bne _9508
        lda wGameStateStep,b
        cmp #STATUS_SCREEN_STEP_BOTTOM_PAGE
        bne _9508
        lda #$0075
        sta wR0
        lda #$0055
        sta wR1
        stz wR4
        lda #$8000
        sta wR5
        ldy #<>aStatusScreenScrollArrow
        jsl rlPushToOAMBuffer
        bra _9508


        _94EE
        lda wGameStateStep,b
        bne _9508
        lda #$0075
        sta wR0
        lda #$00D3
        sta wR1
        stz wR4
        stz wR5
        ldy #<>aStatusScreenScrollArrow
        jsl rlPushToOAMBuffer

        _9508
        rts

        .databank 0

        ; 89/9509


      aStatusScreenScrollArrow ; 89/9509

        _Sprites := [[(   0,    0), $21, SpriteLarge, $00C, 2, 0, false, false]]

        .structSpriteArray aStatusScreenScrollArrow._Sprites

    .endsection Unsorted8994B8Section


    .section Unsorted899510Section

      .al
      .xl

      rlStatusScreenDrawSummary ; 89/9510

        .al
        .xl
        .autsiz
        .databank ?

        ; The top of the page: name, class, level, experience (player units), HP, and the attack, hit, range and avoid of the first weapon the unit can use ("--" without one, for unarmed avoid, and the experience of non-player units).

        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0102
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitClassNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0304
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitLevel
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$014A
        jsl rlDrawMenuTextNumber
        lda wStatusScreenFactionSlot
        bne _9570
        jsl rlGetSelectedUnitExperience
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$0150
        jsl rlDrawMenuTextNumber

        _9570
        jsl rlGetSelectedUnitCurrentHP
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$01CA
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitMaxHP
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$01D0
        jsl rlDrawMenuTextNumber
        jsl rlGetFirstEquippableWeaponInInventory
        lda wCurrentItemDataROMPointer,b
        bne _95A7
        jml _9660


        _95A7
        lda #$0000
        sta wRoutineVariable1,b
        jsl rlGetFirstWeaponBattleMight
        cmp #$00FF
        bcs _95C9
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$0076
        jsl rlDrawMenuTextNumber
        bra _95E0


        _95C9
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda #(`aStatusScreenDashes)<<8
        sta lR18+1
        lda #<>aStatusScreenDashes
        sta lR18
        ldx #$011B
        jsl rlDrawMenuTextLine

        _95E0
        jsl rlGetSelectedUnitFirstWeaponHit
        ldx #$3920
        stx wR5
        ldx #$0003
        stx wR6
        ldx #$00F4
        jsl rlDrawMenuTextNumber
        lda wSelectedInventorySlot,b
        sta wStatusScreenSavedInventorySlot
        jsl rlGetFirstEquippableWeaponInInventory
        sta wSelectedInventorySlot,b
        jsl rlGetSelectedItemRange
        lda wR11
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$0176
        jsl rlDrawMenuTextNumber
        sta wR11
        lda wStatusScreenSavedInventorySlot
        sta wSelectedInventorySlot,b
        lda #$001B
        sec
        sbc wR11
        asl a
        clc
        adc #$0140
        tax
        lda #$3920
        sta wR5
        lda #$0001
        sta wR6
        lda wR10
        jsl rlDrawMenuTextNumber
        lda #$001C
        sec
        sbc wR11
        asl a
        clc
        adc #$0140
        tax
        lda #$3800
        sta wR1
        lda #$02A0
        sta wR2
        lda #$0001
        sta wR0
        jsl rlDrawBG3TileRun
        bra _968B


        _9660
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda #(`aStatusScreenDashes)<<8
        sta lR18+1
        lda #<>aStatusScreenDashes
        sta lR18
        ldx #$011B
        jsl rlDrawMenuTextLine
        ldx #$031B
        jsl rlDrawMenuTextLine
        ldx #$051B
        jsl rlDrawMenuTextLine
        lda #$2000
        sta aCurrentTilemapInfo,b

        _968B
        lda #$FFFF
        jsl rlGetSelectedUnitFirstWeaponAvoid
        cmp #$0000
        bpl _96DA
        eor #$FFFF
        inc a
        ldx #$3920
        stx wR5
        ldx #$0003
        stx wR6
        ldx #$01F4
        jsl rlDrawMenuTextNumber
        sta $7F83F5
        lda #$001C
        sec
        sbc $7F83F5
        sta $7F83F5
        lda #(`aStatusScreenMinusSign)<<8
        sta lR18+1
        lda #<>aStatusScreenMinusSign
        sta lR18
        lda #$0700
        ora $7F83F5
        tax
        lda #$3800
        sta aCurrentTilemapInfo,b
        jsl rlDrawMenuTextLine
        bra _96EB


        _96DA
        ldx #$3920
        stx wR5
        ldx #$0003
        stx wR6
        ldx #$01F4
        jsl rlDrawMenuTextNumber

        _96EB
        lda wStatusScreenFactionSlot
        beq _9702
        lda #(`aStatusScreenDashes)<<8
        sta lR18+1
        lda #<>aStatusScreenDashes
        sta lR18
        ldx #$0508
        jsl rlDrawMenuTextLine

        _9702
        rtl

        .databank 0

        ; 89/9703

    .endsection Unsorted899510Section


    .section Table899703Section

      .al
      .xl

      aStatusScreenDashes ; 89/9703

        .enc "SJIS"
        .text "ーー"
        .word $0000
        .enc "none"

      aStatusScreenMinusSign ; 89/9709

        .enc "SJIS"
        .text "ー"
        .word $0000
        .enc "none"


    .endsection Table899703Section


    .section Unsorted89970DSection

      .al
      .xl

      rlStatusScreenDrawStatsAndInventory ; 89/970D

        .al
        .xl
        .autsiz
        .databank ?

        ; The seven stats with their bonuses from items and blood (rlDrawStatBonus), luck as 0 for enemy units, and the inventory: names (grey if the unit cannot use the item), uses for weapons and staves, and the equipped mark on the first usable weapon. Counts the items into wCastleListSubCount.

        jsl rlGetSelectedUnitTotalStrengthEffect
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$0354
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$000C
        ldy #$000E
        jsl rlDrawStatBonus
        jsl rlGetSelectedUnitTotalMagicEffect
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$03D4
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$000C
        ldy #$0010
        jsl rlDrawStatBonus
        jsl rlGetSelectedUnitTotalSkillEffect
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$0454
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$000C
        ldy #$0012
        jsl rlDrawStatBonus
        jsl rlGetSelectedUnitTotalSpeedEffect
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$04D4
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$000C
        ldy #$0014
        jsl rlDrawStatBonus
        lda wStatusScreenUnitType
        cmp #$0003
        bne _979F
        lda #$0000
        bra _97A3


        _979F
        jsl rlGetSelectedUnitLuck

        _97A3
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$0554
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitTotalDefenseEffect
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$05D4
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$000C
        ldy #$0018
        jsl rlDrawStatBonus
        jsl rlGetSelectedUnitTotalResistanceEffect
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$0654
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$000C
        ldy #$001A
        jsl rlDrawStatBonus
        phk
        plb
        .databank $89
        lda #$0000
        sta wCastleListSubCount,b
        jsl rlGetFirstEquippableWeaponInInventory
        sta wR15
        ldy #$0001

        _9807
        tya
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        bne _9815
        jml _98D3


        _9815
        tya
        sta @l $000889
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetItemEquipmentType
        cmp #$0000
        beq _9837
        cmp #$0001
        bne _9844
        tya
        jsl rlCheckInventorySlotStaffUsable
        bcs _9844
        bra _983E


        _9837
        tya
        jsl rlCheckWeaponInInventorySlotEquippable
        bcs _9844

        _983E
        lda #$3000
        sta aCurrentTilemapInfo,b

        _9844
        jsl rlGetItemNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        lda <>aStatusScreenInventoryRows,b,y
        and #$00FF
        xba
        clc
        adc #$0013
        tax
        jsl rlDrawMenuTextLine
        phy
        lda wStatusScreenFactionSlot
        bne _98A4
        jsl rlGetItemEquipmentType
        cmp #$0000
        beq _9877
        cmp #$0001
        bne _98A4

        _9877
        tya
        jsl rlGetItemRAMStructEntryByInventorySlot
        jsl rlGetItemCurrentDurability
        sta $7F83F5
        lda <>aStatusScreenInventoryRows,b,y
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0036
        tax
        lda #$3920
        sta wR5
        lda #$0002
        sta wR6
        lda $7F83F5
        jsl rlDrawMenuTextNumber

        _98A4
        ply
        cpy wR15
        bne _98C9
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #(`aStatusScreenEquippedMark)<<8
        sta lR18+1
        lda #<>aStatusScreenEquippedMark
        sta lR18
        lda <>aStatusScreenInventoryRows,b,y
        and #$00FF
        xba
        clc
        adc #$001D
        tax
        jsl rlDrawMenuTextLine

        _98C9
        inc y
        cpy #$0008
        bcs _98D3
        jml _9807


        _98D3
        rtl

        .databank 0

        ; 89/98D4

    .endsection Unsorted89970DSection


    .section Data8998D4Section

      .al
      .xl

      aStatusScreenInventoryRows ; 89/98D4

        ; A byte per inventory slot (1-8): its row in the BG3 tilemap.

        .byte $00, $0D, $0F, $11, $13, $15, $17, $19, $1B

      aStatusScreenEquippedMark ; 89/98DD

        .enc "SJIS"
        .text "Ｅ"
        .word $0000
        .enc "none"

        ; 89/98E1

    .endsection Data8998D4Section
    .section Unsorted8998E1Section

      .al
      .xl

      rlStatusScreenDrawPersonalData ; 89/98E1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; The bottom half: commander, lover (or army, for non-player units), movement, talk partner, gold, arena level, condition and its turns, and the ten weapon ranks.

        lda #$2000
        sta aCurrentTilemapInfo,b
        lda wStatusScreenCommander
        beq _9904
        jsl rlGetCharacterNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1E08
        jsl rlDrawMenuTextLine
        bra _991B


        _9904
        lda wStatusScreenLeadership
        bne _991B
        lda #(`aStatusScreenNoneText)<<8
        sta lR18+1
        lda #<>aStatusScreenNoneText
        sta lR18
        ldx #$1E08
        jsl rlDrawMenuTextLine

        _991B
        lda wStatusScreenFactionSlot
        beq _994F
        jsl rlGetFactionSlotNameID
        cmp #$00FF
        bne _9938
        lda #(`aStatusScreenNoneText)<<8
        sta lRoutineVariable+1,b
        lda #<>aStatusScreenNoneText
        sta lRoutineVariable,b
        bra _993C


        _9938
        jsl rlGetSelectedUnitFactionNamePointer

        _993C
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$2008
        jsl rlDrawMenuTextLine
        bra _9989


        _994F
        lda @l wSelectedUnitDataRAMPointer
        pha
        lda #(`aStatusScreenNoneText)<<8
        sta lRoutineVariable+1,b
        lda #<>aStatusScreenNoneText
        sta lRoutineVariable,b
        jsl rlGetSelectedUnitLoverGenerationID
        cmp #$0000
        beq _9973
        jsl rlFindCharacterByGenerationID
        bcs _9973
        jsl rlGetSelectedUnitNamePointer

        _9973
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$2008
        jsl rlDrawMenuTextLine
        pla
        sta @l wSelectedUnitDataRAMPointer

        _9989
        jsl rlGetSelectedUnitTotalMovementEffect
        ldx #$2120
        stx wR5
        ldx #$0001
        stx wR6
        ldx #$0910
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$0009
        ldy #$0025
        jsl rlDrawStatBonus
        lda wStatusScreenFactionSlot
        bne _9A27
        lda @l wSelectedUnitDataRAMPointer
        pha
        jsl rlGetSelectedUnitLivingTalkTarget
        cmp #$0000
        beq _99DA
        jsl rlGetUnitRAMDataPointerByID
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        bne _99DA
        jsl rlGetSelectedUnitStatus
        cmp #StatusCaptive
        beq _99DA
        jsl rlGetSelectedUnitNamePointer
        bra _99E6


        _99DA
        lda #(`aStatusScreenNoneText)<<8
        sta lRoutineVariable+1,b
        lda #<>aStatusScreenNoneText
        sta lRoutineVariable,b

        _99E6
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$2208
        jsl rlDrawMenuTextLine
        pla
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitArenaLevel
        cmp #$0007
        beq _9A19
        inc a
        ldx #$2120
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0A10
        jsl rlDrawMenuTextNumber
        bra _9A27


        _9A19
        lda #$39E4
        sta aBG3TilemapBuffer+$A10
        lda #$39F4
        sta aBG3TilemapBuffer+$A50

        _9A27
        jsl rlGetSelectedUnitMoney
        ldx #$2120
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0990
        jsl rlDrawMenuTextNumber
        lda wStatusScreenUnitStates
        bit #UnitStateDead
        beq _9A58
        lda #(`aStatusScreenDeadText)<<8
        sta lR18+1
        lda #<>aStatusScreenDeadText
        sta lR18
        ldx #$2A08
        jsl rlDrawMenuTextLine
        bra _9A94


        _9A58
        lda wStatusScreenCondition
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aConditionNamePointers+1,x
        sta lR18+1
        lda aConditionNamePointers,x
        sta lR18
        ldx #$2A08
        jsl rlDrawMenuTextLine
        lda wR0
        beq _9A94
        cmp #$0003
        beq _9A94
        jsl rlGetSelectedUnitStatusDuration
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0A98
        jsl rlDrawMenuTextNumber

        _9A94
        lda #$0000
        jsl rlGetSelectedUnitWeaponRank
        bcc _9AA0
        lda #$0004

        _9AA0
        ldx #$0015
        ldy #$001E
        jsr rsDrawWeaponRankLetter
        lda #$0001
        jsl rlGetSelectedUnitWeaponRank
        bcc _9AB5
        lda #$0004

        _9AB5
        ldx #$0015
        ldy #$0020
        jsr rsDrawWeaponRankLetter
        lda #$0002
        jsl rlGetSelectedUnitWeaponRank
        bcc _9ACA
        lda #$0004

        _9ACA
        ldx #$0015
        ldy #$0022
        jsr rsDrawWeaponRankLetter
        lda #$0003
        jsl rlGetSelectedUnitWeaponRank
        bcc _9ADF
        lda #$0004

        _9ADF
        ldx #$0015
        ldy #$0024
        jsr rsDrawWeaponRankLetter
        lda #$0004
        jsl rlGetSelectedUnitWeaponRank
        bcc _9AF4
        lda #$0004

        _9AF4
        ldx #$0015
        ldy #$0026
        jsr rsDrawWeaponRankLetter
        lda #$0005
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B09
        lda #$0004

        _9B09
        ldx #$001D
        ldy #$001E
        jsr rsDrawWeaponRankLetter
        lda #$0006
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B1E
        lda #$0004

        _9B1E
        ldx #$001D
        ldy #$0020
        jsr rsDrawWeaponRankLetter
        lda #$0007
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B33
        lda #$0004

        _9B33
        ldx #$001D
        ldy #$0022
        jsr rsDrawWeaponRankLetter
        lda #$0008
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B48
        lda #$0004

        _9B48
        ldx #$001D
        ldy #$0024
        jsr rsDrawWeaponRankLetter
        lda #$0009
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B5D
        lda #$0004

        _9B5D
        ldx #$001D
        ldy #$0026
        jsr rsDrawWeaponRankLetter
        lda wStatusScreenFactionSlot
        beq _9B8E
        lda #(`aStatusScreenNoneText)<<8
        sta lR18+1
        lda #<>aStatusScreenNoneText
        sta lR18
        ldx #$2208
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenNoneText)<<8
        sta lR18+1
        lda #<>aStatusScreenNoneText
        sta lR18
        ldx #$2808
        jsl rlDrawMenuTextLine

        _9B8E
        rtl

        .databank 0

        ; 89/9B8F

    .endsection Unsorted8998E1Section


    .section Table899B8FSection

      .al
      .xl

      aStatusScreenDash ; 89/9B8F

        ; Nothing reads it.

        .enc "SJIS"
        .text "ー"
        .word $0000
        .enc "none"

      aStatusScreenNoneText ; 89/9B93

        .enc "SJIS"
        .text "ーーーー"
        .word $0000
        .enc "none"

      aStatusScreenDeadText ; 89/9B9D

        .enc "SJIS"
        .text "しぼう"
        .word $0000
        .enc "none"


    .endsection Table899B8FSection


    .section Unsorted899BA5Section

      .al
      .xl

      rlStatusScreenDrawSummaryLabels ; 89/9BA5

        .al
        .xl
        .autsiz
        .databank ?

        ; Labels of the top of the page: the brackets and slash around HP, and attack, hit, range, avoid.

        lda #$2400
        sta aCurrentTilemapInfo,b
        lda #$2400
        sta wR1
        lda #$020C
        sta wR2
        lda #$0002
        sta wR0
        ldx #$0144
        jsl rlDrawBG3TileRun
        lda #(`aStatusScreenHPBrackets)<<8
        sta lR18+1
        lda #<>aStatusScreenHPBrackets
        sta lR18
        ldx #$0507
        jsl rlDrawMenuTextLine
        lda #$2400
        sta wR1
        lda #$0220
        sta wR2
        lda #$0002
        sta wR0
        ldx #$01C4
        jsl rlDrawBG3TileRun
        lda #(`aStatusScreenSlash)<<8
        sta lR18+1
        lda #<>aStatusScreenSlash
        sta lR18
        ldx #$0707
        jsl rlDrawMenuTextLine
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #(`aStatusScreenAttackLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenAttackLabel
        sta lR18
        ldx #$0114
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenHitLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenHitLabel
        sta lR18
        ldx #$0313
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenRangeLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenRangeLabel
        sta lR18
        ldx #$0514
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenAvoidLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenAvoidLabel
        sta lR18
        ldx #$0714
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

        ; 89/9C44

    .endsection Unsorted899BA5Section


    .section Table899C44Section

      .al
      .xl

      aStatusScreenHPBrackets ; 89/9C44

        .enc "SJIS"
        .text "（　　）"
        .word $0000
        .enc "none"

      aStatusScreenSlash ; 89/9C4E

        .enc "SJIS"
        .text "／"
        .word $0000
        .enc "none"

      aStatusScreenAttackLabel ; 89/9C52

        .enc "SJIS"
        .text "こうげき"
        .word $0000
        .enc "none"

      aStatusScreenHitLabel ; 89/9C5C

        .enc "SJIS"
        .text "めいちゅう"
        .word $0000
        .enc "none"

      aStatusScreenRangeLabel ; 89/9C68

        .enc "SJIS"
        .text "しゃてい"
        .word $0000
        .enc "none"

      aStatusScreenAvoidLabel ; 89/9C72

        .enc "SJIS"
        .text "かいひち"
        .word $0000
        .enc "none"


    .endsection Table899C44Section


    .section Unsorted899C7CSection

      .al
      .xl

      rlStatusScreenDrawStatLabels ; 89/9C7C

        .al
        .xl
        .autsiz
        .databank ?

        ; Labels of the seven stats, and their frame.

        lda #$2400
        sta wR1
        lda #$0226
        sta wR2
        lda #$000A
        sta wR0
        ldx #$02C6
        jsl rlDrawBG3TileRun
        lda #$2400
        sta wR1
        lda #$0240
        sta wR2
        lda #$000C
        sta wR0
        ldx #$02E2
        jsl rlDrawBG3TileRun
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #(`aStatusScreenStrengthLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenStrengthLabel
        sta lR18
        ldx #$0D06
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenMagicLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenMagicLabel
        sta lR18
        ldx #$0F05
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenSkillLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenSkillLabel
        sta lR18
        ldx #$1107
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenSpeedLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenSpeedLabel
        sta lR18
        ldx #$1305
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenLuckLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenLuckLabel
        sta lR18
        ldx #$1504
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenDefenseLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenDefenseLabel
        sta lR18
        ldx #$1703
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenResistanceLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenResistanceLabel
        sta lR18
        ldx #$1902
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

        ; 89/9D26

    .endsection Unsorted899C7CSection


    .section Table899D26Section

      .al
      .xl

      aStatusScreenStrengthLabel ; 89/9D26

        .enc "SJIS"
        .text "ちから"
        .word $0000
        .enc "none"

      aStatusScreenMagicLabel ; 89/9D2E

        .enc "SJIS"
        .text "まりょく"
        .word $0000
        .enc "none"

      aStatusScreenSkillLabel ; 89/9D38

        .enc "SJIS"
        .text "わざ"
        .word $0000
        .enc "none"

      aStatusScreenSpeedLabel ; 89/9D3E

        .enc "SJIS"
        .text "すばやさ"
        .word $0000
        .enc "none"

      aStatusScreenLuckLabel ; 89/9D48

        .enc "SJIS"
        .text "うんのよさ"
        .word $0000
        .enc "none"

      aStatusScreenDefenseLabel ; 89/9D54

        .enc "SJIS"
        .text "しゅびりょく"
        .word $0000
        .enc "none"

      aStatusScreenResistanceLabel ; 89/9D62

        .enc "SJIS"
        .text "まほうぼうぎょ"
        .word $0000
        .enc "none"


    .endsection Table899D26Section


    .section Unsorted899D72Section

      .al
      .xl

      rlStatusScreenDrawPersonalDataLabels ; 89/9D72

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Labels of the bottom half: commander, lover or army, talk, movement, gold, arena level, condition, and the ten weapon types.

        lda #$2400
        sta wR1
        lda #$0265
        sta wR2
        lda #$000A
        sta wR0
        ldx #$0706
        jsl rlDrawBG3TileRun
        lda #$2400
        sta wR1
        lda #$01E5
        sta wR2
        lda #$000B
        sta wR0
        ldx #$0724
        jsl rlDrawBG3TileRun
        lda #$2400
        sta wR1
        lda #$026F
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0A24
        jsl rlDrawBG3TileRun
        lda #$2400
        sta wR1
        lda #$0280
        sta wR2
        lda #$0009
        sta wR0
        ldx #$0A26
        jsl rlDrawBG3TileRun
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #(`aStatusScreenCommanderLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenCommanderLabel
        sta lR18
        ldx #$1E03
        jsl rlDrawMenuTextLine
        lda wStatusScreenFactionSlot
        beq _9DFA
        lda #(`aStatusScreenArmyLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenArmyLabel
        sta lR18
        ldx #$2003
        jsl rlDrawMenuTextLine
        bra _9E0B


        _9DFA
        lda #(`aStatusScreenLoverLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenLoverLabel
        sta lR18
        ldx #$2003
        jsl rlDrawMenuTextLine

        _9E0B
        lda #(`aStatusScreenTalkLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenTalkLabel
        sta lR18
        ldx #$2204
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenMoveLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenMoveLabel
        sta lR18
        ldx #$2404
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenGoldLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenGoldLabel
        sta lR18
        ldx #$2602
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenArenaLevelLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenArenaLevelLabel
        sta lR18
        ldx #$2802
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenConditionLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenConditionLabel
        sta lR18
        ldx #$2A02
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenSwordLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenSwordLabel
        sta lR18
        ldx #$1E12
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenLanceLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenLanceLabel
        sta lR18
        ldx #$2012
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenAxeLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenAxeLabel
        sta lR18
        ldx #$2212
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenBowLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenBowLabel
        sta lR18
        ldx #$2412
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenStaffLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenStaffLabel
        sta lR18
        ldx #$2612
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenFireLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenFireLabel
        sta lR18
        ldx #$1E19
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenThunderLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenThunderLabel
        sta lR18
        ldx #$2019
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenWindLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenWindLabel
        sta lR18
        ldx #$2219
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenLightLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenLightLabel
        sta lR18
        ldx #$2419
        jsl rlDrawMenuTextLine
        lda #(`aStatusScreenDarkLabel)<<8
        sta lR18+1
        lda #<>aStatusScreenDarkLabel
        sta lR18
        ldx #$2619
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

        ; 89/9F0B

    .endsection Unsorted899D72Section


    .section Table899F0BSection

      .al
      .xl

      aStatusScreenArmyLabel ; 89/9F0B

        .enc "SJIS"
        .text "しょぞく"
        .word $0000
        .enc "none"

      aStatusScreenCommanderLabel ; 89/9F15

        .enc "SJIS"
        .text "しきかん"
        .word $0000
        .enc "none"

      aStatusScreenTalkLabel ; 89/9F1F

        .enc "SJIS"
        .text "かいわ"
        .word $0000
        .enc "none"

      aStatusScreenMoveLabel ; 89/9F27

        .enc "SJIS"
        .text "いどう"
        .word $0000
        .enc "none"

      aStatusScreenGoldLabel ; 89/9F2F

        .enc "SJIS"
        .text "しょじきん"
        .word $0000
        .enc "none"

      aStatusScreenConditionLabel ; 89/9F3B

        .enc "SJIS"
        .text "じょうたい"
        .word $0000
        .enc "none"

      aStatusScreenLoverLabel ; 89/9F47

        .enc "SJIS"
        .text "こいびと"
        .word $0000
        .enc "none"

      aStatusScreenArenaLevelLabel ; 89/9F51

        .enc "SJIS"
        .text "とうぎＬＶ"
        .word $0000
        .enc "none"

      aStatusScreenSwordLabel ; 89/9F5D

        .enc "SJIS"
        .text "けん"
        .word $0000
        .enc "none"

      aStatusScreenLanceLabel ; 89/9F63

        .enc "SJIS"
        .text "やり"
        .word $0000
        .enc "none"

      aStatusScreenAxeLabel ; 89/9F69

        .enc "SJIS"
        .text "おの"
        .word $0000
        .enc "none"

      aStatusScreenBowLabel ; 89/9F6F

        .enc "SJIS"
        .text "ゆみ"
        .word $0000
        .enc "none"

      aStatusScreenStaffLabel ; 89/9F75

        .enc "SJIS"
        .text "つえ"
        .word $0000
        .enc "none"

      aStatusScreenFireLabel ; 89/9F7B

        .enc "SJIS"
        .text "ほのお"
        .word $0000
        .enc "none"

      aStatusScreenThunderLabel ; 89/9F83

        .enc "SJIS"
        .text "いかずち"
        .word $0000
        .enc "none"

      aStatusScreenWindLabel ; 89/9F8D

        .enc "SJIS"
        .text "かぜ"
        .word $0000
        .enc "none"

      aStatusScreenLightLabel ; 89/9F93

        .enc "SJIS"
        .text "ひかり"
        .word $0000
        .enc "none"

      aStatusScreenDarkLabel ; 89/9F9B

        .enc "SJIS"
        .text "やみ"
        .word $0000
        .enc "none"


    .endsection Table899F0BSection


    .section Unsorted899FA1Section

      .al
      .xl

      rlStatusScreenDrawLeadershipStars ; 89/9FA1

        .al
        .xl
        .autsiz
        .databank ?

        ; A star sprites in a row from X, Y (Y scrolls with BG3), 11 pixels apart.

        cmp #$0000
        beq _9FD4
        phk
        plb
        .databank $89
        sty wR12
        stx wR13
        sta wR14
        stz wR15
        stz wR4
        stz wR5

        _9FB4
        lda wR12
        sec
        sbc wBufferBG3VOFS
        sta wR1
        lda wR13
        sta wR0
        clc
        adc #$000B
        sta wR13
        ldy #<>aStatusScreenLeadershipStar
        jsl rlPushToOAMBuffer
        inc wR15
        lda wR15
        cmp wR14
        bne _9FB4

        _9FD4
        rtl

        .databank 0

        ; 89/9FD5


      aStatusScreenLeadershipStar ; 89/9FD5

        _Sprites := [[(   0,    0), $21, SpriteLarge, $00E, 3, 0, false, false]]

        .structSpriteArray aStatusScreenLeadershipStar._Sprites

    .endsection Unsorted899FA1Section


    .section Unsorted89A085Section

      .al
      .xl

      rlDrawStatBonus ; 89/A085

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Draws A as a signed bonus ("+3", "-2") at tile X, row Y of the BG3 tilemap buffer, or nothing for 0. The stat screens put the bonus a stat getter left in wR34 beside the stat.

        phk
        plb
        .databank $89
        cmp #$0000
        beq _A106
        sta wStatusScreenTemp1
        tya
        and #$00FF
        xba
        lsr a
        lsr a
        sta wR10
        txa
        and #$001F
        asl a
        ora wR10
        sta wStatusScreenTemp2
        ldx #$0000
        lda wStatusScreenTemp1
        bpl _A0B2
        dec a
        eor #$FFFF
        inc x

        _A0B2
        sta wStatusScreenTemp4
        txa
        sta wStatusScreenTemp3
        ldx #$0000

        _A0BE
        lda wStatusScreenTemp4
        cmp #$000A
        bmi _A0D2
        sec
        sbc #$000A
        sta wStatusScreenTemp4
        inc x
        bra _A0BE


        _A0D2
        sta wR10
        stx wR11
        lda wStatusScreenTemp2
        tax
        ldy #$391B
        lda wStatusScreenTemp3
        bne _A0E7
        ldy #$391A

        _A0E7
        tya
        sta aBG3TilemapBuffer,x
        inc x
        inc x
        lda wR11
        beq _A0FC
        clc
        adc #$3910
        sta aBG3TilemapBuffer,x
        inc x
        inc x

        _A0FC
        lda wR10
        clc
        adc #$3910
        sta aBG3TilemapBuffer,x

        _A106
        rtl

        .databank 0

        ; 89/A107

    .endsection Unsorted89A085Section


    .section Unsorted89A138Section

      .al
      .xl

      rlStatusScreenLoadPortrait ; 89/A138

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        ; Loads the unit's portrait into sprite VRAM; character $2B uses portrait $2B4 when shown as an enemy.

        lda wStatusScreenCharacter
        cmp #$002B
        bne _A14C
        lda wStatusScreenFactionSlot
        beq _A14C
        lda #$02B4
        bra rlLoadPortraitAsSprites


        _A14C
        lda wStatusScreenCharacter

        .databank 0

        ; 89/A150

    .endsection Unsorted89A138Section


    .section Unsorted89A150Section

      .al
      .xl

      rlLoadPortraitAsSprites ; 89/A150

        .al
        .autsiz
        .databank ?

        ; Decompresses portrait A, sends it to sprite VRAM at $6200 and its palette to sprite palette 4; the last colour becomes $35AD unless the portrait data ID is $F3.

        ; portrait stuff for research

        ; A = portrait ID

        jsl rlDecompressDialoguePortrait

        lda #$0800
        sta wR0

        txa
        asl a
        tay
        lda #$6200
        sta wR1
        phx
        jsl rlDMAByPointer

        plx
        ldx #$001E
        ldy #$001E
        
          -
          lda [$27],y
          sta aOAMPaletteBuffer.aPalette4,b,y
          dec x
          dec x
          dec y
          dec y
          bpl -

        lda wStatusScreenCharacter
        jsl rlGetCharacterPortraitDataID
        cmp #$00F3
        beq +

          lda #$35AD
          sta $029C,b
        
        +
        rtl

        .databank 0

        ; 89/A18C

    .endsection Unsorted89A150Section


    .section Unsorted89A25ASection

      .al
      .xl

      rsStatusScreenSkillDetails ; 89/A25A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Step $08, the cursor on the skill icons: Left and Right choose a skill and draw its name, description and kind (wStatusScreenSkillCursor); B puts the personal data back and returns to step $01.

        jsr rsStatusScreenDrawPortraitAndMapSprite
        jsr rsStatusScreenDrawEquippedWeaponIcon
        jsr rsStatusScreenDrawRankIconsAndStars
        lda wJoy1Repeated
        bit #$8000
        bne _A27B
        bit #$0100
        bne _A2AE
        bit #$0200
        bne _A2D1
        jsr rsStatusScreenDrawSkillCursor
        jsr rsStatusScreenDrawSkillIcons
        rts


        _A27B
        lda #$0021
        jsl rlPlaySoundEffect
        ldx #$0700
        lda #$0010
        ldy #$0010
        jsl rlClearTilemapRect
        jsl rlStatusScreenDrawPersonalDataLabels
        jsl rlStatusScreenDrawPersonalData
        lda #STATUS_SCREEN_STEP_BOTTOM_PAGE
        sta wGameStateStep,b
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer+$700, $0400, $80, $B700

        jsr rsStatusScreenDrawSkillIcons
        rts


        _A2AE
        lda wStatusScreenSkillCursor
        inc a
        cmp wStatusScreenSkillCount
        beq _A2CA
        sta wStatusScreenSkillCursor
        lda #$0007
        jsl rlPlaySoundEffect
        jsr rsStatusScreenDrawSkillDescription
        jsr rsStatusScreenDrawSkillIcons

        _A2CA
        jsr rsStatusScreenDrawSkillCursor
        jsr rsStatusScreenDrawSkillIcons
        rts


        _A2D1
        lda wStatusScreenSkillCursor
        dec a
        bmi _A2E6
        sta wStatusScreenSkillCursor
        lda #$0007
        jsl rlPlaySoundEffect
        jsr rsStatusScreenDrawSkillDescription

        _A2E6
        jsr rsStatusScreenDrawSkillCursor
        jsr rsStatusScreenDrawSkillIcons
        rts

        .databank 0

        ; 89/A2ED

    .endsection Unsorted89A25ASection


    .section Unsorted89A2EDSection

      .al
      .xl

      rsStatusScreenFadeIn ; 89/A2ED

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Step $09: brightens by wStatusScreenFadeStep a frame; at full brightness goes to step wStatusScreenStepAfterFade.

        sep #$20
        lda bBufferINIDISP
        clc
        adc wStatusScreenFadeStep
        sta bBufferINIDISP
        rep #$20
        and #$00FF
        cmp #$000F
        bcc _A311
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        lda wStatusScreenStepAfterFade
        sta wGameStateStep,b

        _A311
        jsr rsStatusScreenDrawPortraitAndMapSprite
        jsr rsStatusScreenDrawEquippedWeaponIcon
        lda wStatusScreenStepAfterFade
        cmp #STATUS_SCREEN_STEP_HOLY_BLOOD_PAGE
        beq _A32A
        jsr rsStatusScreenDrawInventoryIcons
        jsr rsStatusScreenDrawRankIconsAndStars
        jsr rsStatusScreenDrawSkillIcons
        rts


        _A32A
        jsr rsStatusScreenDrawHolyBloodPageSprites
        rts

        .databank 0

        ; 89/A32E

      rsStatusScreenFadeOut ; 89/A32E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Step $0A: darkens by wStatusScreenFadeStep a frame; at black goes to step wStatusScreenStepAfterFade, and if another unit is to be shown (wStatusScreenReopenMode set) selects it (wStatusScreenNextUnit).

        sep #$20
        lda bBufferINIDISP
        sec
        sbc wStatusScreenFadeStep
        sta bBufferINIDISP
        rep #$20
        bpl _A35B
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda wStatusScreenStepAfterFade
        sta wGameStateStep,b
        lda wStatusScreenReopenMode
        beq _A35B
        lda wStatusScreenNextUnit
        sta @l wSelectedUnitDataRAMPointer
        rts


        _A35B
        jsr rsStatusScreenDrawPortraitAndMapSprite
        jsr rsStatusScreenDrawEquippedWeaponIcon
        lda wBufferBG2VOFS
        cmp #$0110
        beq _A372
        jsr rsStatusScreenDrawInventoryIcons
        jsr rsStatusScreenDrawRankIconsAndStars
        jsr rsStatusScreenDrawSkillIcons
        rts


        _A372
        jsr rsStatusScreenDrawHolyBloodPageSprites
        rts

        .databank 0

        ; 89/A376

    .endsection Unsorted89A2EDSection


    .section Unsorted89A376Section

      .al
      .xl

      rlStatusScreenBuildSkillList ; 89/A376

        .al
        .xl
        .autsiz
        .databank ?

        ; Lists the unit's skills that have an icon (rlCollectSelectedUnitIconSkills, aStatusScreenSkillIcons): their IDs in aStatusScreenSkillIDs, icon tiles in aStatusScreenSkillIconTiles, the count in wStatusScreenSkillCount.

        stz wR13
        jsl rlCollectSelectedUnitIconSkills
        lda $7E2000
        beq _A3B9
        lda #$0000

        _A385
        sta wR15
        tax
        lda $7E2002,x
        and #$00FF
        sta wR14
        beq _A3B1
        lda wR15
        asl a
        tax
        lda aStatusScreenSkillIcons,x
        bmi _A3B1
        sta wR14
        lda wR13
        asl a
        tax
        lda wR15
        sta aStatusScreenSkillIDs,x
        lda wR14
        sta aStatusScreenSkillIconTiles,x
        inc wR13

        _A3B1
        lda wR15
        inc a
        cmp #$001F
        bne _A385

        _A3B9
        lda wR13
        sta wStatusScreenSkillCount
        rtl

        .databank 0

        ; 89/A3C0

    .endsection Unsorted89A376Section


    .section Unsorted89A3C0Section

      .al
      .xl

      rsStatusScreenDrawSkillDescription ; 89/A3C0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the skill under the cursor: its name, its description (aSkillDescriptionPointers) and whether it is a personal or a class skill.

        ldx #$0700
        lda #$0010
        ldy #$0010
        jsl rlClearTilemapRect
        lda #$0000
        ldx #$00C0

        _A3D3
        sta aStatusScreenTextBuffer-2,x
        dec x
        dec x
        bne _A3D3
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda wStatusScreenSkillCursor
        asl a
        tax
        lda aStatusScreenSkillIDs,x
        sta wStatusScreenTemp1
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89AC56+1,x
        sta lR18+1
        lda aUnknown89AC56,x
        sta lR18
        ldx #$1D05
        jsl rlDrawMenuTextLine
        lda #(`aUnknown89ACC5)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown89ACC5
        sta lMapMenuTilemapRAMEntryPointer,b
        lda wStatusScreenSkillCursor
        asl a
        tax
        lda aStatusScreenSkillIDs,x
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aSkillDescriptionPointers+1,x
        sta lR18+1
        lda aSkillDescriptionPointers,x
        sta lR18
        ldx #$0000
        jsl rlDrawMenuTextLine
        ldx #$0014

        _A43C
        lda aStatusScreenTextBuffer-2,x
        sta aBG3TilemapBuffer+$804,x
        lda aStatusScreenTextBuffer+$76,x
        sta aBG3TilemapBuffer+$844,x
        dec x
        dec x
        bne _A43C
        ldx #$0014

        _A453
        lda aStatusScreenTextBuffer+$12,x
        sta aBG3TilemapBuffer+$884,x
        lda aStatusScreenTextBuffer+$8A,x
        sta aBG3TilemapBuffer+$8C4,x
        dec x
        dec x
        bne _A453
        ldx #$0014

        _A46A
        lda aStatusScreenTextBuffer+$26,x
        sta aBG3TilemapBuffer+$904,x
        lda aStatusScreenTextBuffer+$9E,x
        sta aBG3TilemapBuffer+$944,x
        dec x
        dec x
        bne _A46A
        lda #(`aUnknown89ACB3)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown89ACB3
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda wStatusScreenTemp1
        jsl rlCheckIfUnitHasSpecifiedPersonalSkill
        bcs _A4A6
        lda #(`aStatusScreenClassSkillText)<<8
        sta lR18+1
        lda #<>aStatusScreenClassSkillText
        sta lR18
        bra _A4B0


        _A4A6
        lda #(`aStatusScreenPersonalSkillText)<<8
        sta lR18+1
        lda #<>aStatusScreenPersonalSkillText
        sta lR18

        _A4B0
        ldx #$2704
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer+$700, $0400, $80, $B700

        rts

        .databank 0

        ; 89/A4C5

    .endsection Unsorted89A3C0Section


    .section Table89A4C5Section

      .al
      .xl

      aStatusScreenPersonalSkillText ; 89/A4C5

        .enc "SJIS"
        .text "こじんスキル"
        .word $0000
        .enc "none"

      aStatusScreenClassSkillText ; 89/A4D3

        .enc "SJIS"
        .text "へいしゅスキル"
        .word $0000
        .enc "none"


    .endsection Table89A4C5Section


    .section Unsorted89A4E3Section

      .al
      .xl

      rsStatusScreenDrawSkillCursor ; 89/A4E3

        .al
        .xl
        .autsiz
        .databank ?

        ; The cursor above the chosen skill icon (four frames) and the icon of that skill.

        lda wStatusScreenSkillCursor
        asl a
        tax
        lda aStatusScreenSkillCursorX,x
        sta wR0
        lda #$00C9
        sta wR1
        stz wR4
        stz wR5
        lda wVBlankEnabledFramecount
        lsr a
        lsr a
        lsr a
        and #$0003
        asl a
        tax
        lda aStatusScreenSkillCursorFrames,x
        tay
        phk
        plb
        .databank $89
        jsl rlPushToOAMBuffer
        lda wStatusScreenSkillCursor
        asl a
        tax
        lda aStatusScreenSkillIDs,x
        asl a
        tax
        lda @l aStatusScreenSkillIconTilesBySkill,x
        sta wR4
        stz wR0
        stz wR1
        stz wR5
        ldy #<>aStatusScreenSkillDetailIcon
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/A52D

    .endsection Unsorted89A4E3Section


    .section Table89A52DSection

      .al
      .xl

      aStatusScreenSkillIconTilesBySkill ; 89/A52D

        ; A word per skill: the tile offset of its icon in the skill details.

        .word $0000, $0000, $0006, $0000, $0002, $0004, $0044, $0000
        .word $0046, $0000, $0000, $0000, $0008, $000A, $000C, $000E
        .word $0020, $0022, $0024, $0026, $0028, $002A, $002C, $002E
        .word $0040, $0042, $010E, $0000, $0048, $004A, $0000

      aStatusScreenSkillDetailIcon ; 89/A56B

        _Sprites := [[(  20,   98), $21, SpriteLarge, $080, 3, 7, false, false]]

        .structSpriteArray aStatusScreenSkillDetailIcon._Sprites

        ; 89/A572

    .endsection Table89A52DSection
    .section Table89A572Section

      .al
      .xl

      aStatusScreenSkillCursorFrames ; 89/A572

        ; Four frames of the cursor over the chosen skill.

        .word <>aStatusScreenSkillCursor0
        .word <>aStatusScreenSkillCursor1
        .word <>aStatusScreenSkillCursor2
        .word <>aStatusScreenSkillCursor1

      aStatusScreenSkillCursor0 ; 89/A57A

        _Sprites := [[(   3,    0), $21, SpriteLarge, $00A, 3, 0, true, false]]
        _Sprites ..= [[(  29,    0), $21, SpriteLarge, $00A, 3, 0, false, false]]

        .structSpriteArray aStatusScreenSkillCursor0._Sprites

      aStatusScreenSkillCursor1 ; 89/A586

        _Sprites := [[(   2,    0), $21, SpriteLarge, $00A, 3, 0, true, false]]
        _Sprites ..= [[(  30,    0), $21, SpriteLarge, $00A, 3, 0, false, false]]

        .structSpriteArray aStatusScreenSkillCursor1._Sprites

      aStatusScreenSkillCursor2 ; 89/A592

        _Sprites := [[(   1,    0), $21, SpriteLarge, $00A, 3, 0, true, false]]
        _Sprites ..= [[(  31,    0), $21, SpriteLarge, $00A, 3, 0, false, false]]

        .structSpriteArray aStatusScreenSkillCursor2._Sprites

        ; 89/A59E

    .endsection Table89A572Section
    .section Table89A59ESection

      .al
      .xl

      aStatusScreenSkillCursorX ; 89/A59E

        ; Read by rsStatusScreenDrawSkillCursor.

        .word $0070, $0084, $0098, $00AC, $00C0, $00D4

        ; 89/A5AA

    .endsection Table89A59ESection


    .section Unsorted89A5AASection

      .al
      .xl

      rsDrawWeaponRankLetter ; 89/A5AA

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws weapon rank A (WeaponRankA, B, C, WeaponRankNone as a dash, or 4 for the star rank that major holy blood gives) at tile X, row Y of the BG3 tilemap buffer: two tiles, one above the other, from aWeaponRankLetterTiles.

        pha
        tya
        xba
        lsr a
        lsr a
        sta wR0
        txa
        asl a
        clc
        adc wR0
        tay
        pla
        asl a
        asl a
        tax
        lda aWeaponRankLetterTiles,x
        phx
        tyx
        sta aBG3TilemapBuffer,x
        txy
        plx
        lda aWeaponRankLetterTiles+2,x
        tyx
        sta aBG3TilemapBuffer+$40,x
        rts

        .databank 0

        ; 89/A5D1

    .endsection Unsorted89A5AASection


    .section Unsorted89A5D1Section

      .al
      .xl

      aWeaponRankLetterTiles ; 89/A5D1

        ; Five entries of two BG3 tilemap words: rsDrawWeaponRankLetter writes entry A's first word
        ; at the tile it is given and the second word one row below it.

        .word $392A, $393A, $392B, $393B, $392C, $393C, $38FF, $3909
        .word $39E4, $39F4

        ; 89/A5E5

      rsStatusScreenNextUnit ; 89/A5E5

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; R: finds the player unit with the next generation ID (1-$18, wrapping) that is alive and not captive (any unit while Select is held, dead ones included: seen in the emulator), and fades out to reopen the screen for it. Sets carry and does nothing for a non-player unit or when the revive screen opened the status screen.

        lda wSelectedUnitDataRAMPointer,b
        sta wStatusScreenTemp3
        lda wStatusScreenCaller
        cmp #<>rsReviveScreenOpen
        beq _A5FB
        lda wStatusScreenFactionSlot
        beq _A604

        _A5FB
        lda wStatusScreenTemp3
        sta wSelectedUnitDataRAMPointer,b
        sec
        rts


        _A604
        jsl rlGetSelectedUnitGenerationID
        sta wStatusScreenTemp1
        sta wStatusScreenTemp2

        _A610
        lda wStatusScreenTemp1
        inc a
        cmp #$0019
        bne _A61D
        lda #$0001

        _A61D
        cmp wStatusScreenTemp2
        beq _A5FB
        sta wStatusScreenTemp1
        sta @l wRoutineVariable1
        lda #$0000
        jsl rlFindGenerationIDInFactionSlotData
        lda @l wSelectedUnitDataRAMPointer
        beq _A610
        lda wJoy1Input
        bit #$2000
        bne _A651
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        bne _A610
        jsl rlGetSelectedUnitStatus
        cmp #StatusCaptive
        beq _A610

        _A651
        lda #$0027
        jsl rlPlaySoundEffect2
        lda @l wSelectedUnitDataRAMPointer
        sta wStatusScreenNextUnit
        lda #$0003
        sta wStatusScreenFadeStep
        sep #$20
        lda #$0C
        sta bBufferINIDISP
        rep #$20
        lda #STATUS_SCREEN_STEP_FADE_OUT
        sta wGameStateStep,b
        lda #<>rsOpenStatusScreen
        sta wStatusScreenExitRoutine
        lda #STATUS_SCREEN_STEP_LEAVE
        sta wStatusScreenStepAfterFade
        lda wStatusScreenTemp3
        sta wSelectedUnitDataRAMPointer,b
        clc
        rts

        .databank 0

        ; 89/A68C

      rsStatusScreenPreviousUnit ; 89/A68C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; L: as rsStatusScreenNextUnit, going down.

        lda wSelectedUnitDataRAMPointer,b
        sta wStatusScreenTemp3
        lda wStatusScreenCaller
        cmp #<>rsReviveScreenOpen
        beq _A6A2
        lda wStatusScreenFactionSlot
        beq _A6AB

        _A6A2
        lda wStatusScreenTemp3
        sta wSelectedUnitDataRAMPointer,b
        sec
        rts


        _A6AB
        jsl rlGetSelectedUnitGenerationID
        sta wStatusScreenTemp1
        sta wStatusScreenTemp2

        _A6B7
        lda wStatusScreenTemp1
        dec a
        bne _A6C1
        lda #$0018

        _A6C1
        cmp wStatusScreenTemp2
        beq _A6A2
        sta wStatusScreenTemp1
        sta @l wRoutineVariable1
        lda #$0000
        jsl rlFindGenerationIDInFactionSlotData
        lda wSelectedUnitDataRAMPointer,b
        beq _A6B7
        lda wJoy1Input
        bit #$2000
        bne _A6F4
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        bne _A6B7
        jsl rlGetSelectedUnitStatus
        cmp #StatusCaptive
        beq _A6B7

        _A6F4
        lda #$0026
        jsl rlPlaySoundEffect2
        lda #$0003
        sta wStatusScreenFadeStep
        sep #$20
        lda #$0C
        sta bBufferINIDISP
        rep #$20
        lda #STATUS_SCREEN_STEP_FADE_OUT
        sta wGameStateStep,b
        lda #STATUS_SCREEN_STEP_LEAVE
        sta wStatusScreenStepAfterFade
        lda #<>rsOpenStatusScreen
        sta wStatusScreenExitRoutine
        lda wSelectedUnitDataRAMPointer,b
        sta wStatusScreenNextUnit
        lda wStatusScreenTemp3
        sta wSelectedUnitDataRAMPointer,b
        clc
        rts

        .databank 0

        ; 89/A72E

    .endsection Unsorted89A5D1Section


    .section SpriteArray89A72ESection

      .al
      .xl

      aStatusScreenPortraitSprites ; 89/A72E

        _Sprites := [[(  32,   48), $21, SpriteLarge, $004A, 3, 4, false, false]]
        _Sprites ..= [[(  16,   48), $21, SpriteLarge, $0048, 3, 4, false, false]]
        _Sprites ..= [[(   0,   48), $21, SpriteLarge, $0046, 3, 4, false, false]]
        _Sprites ..= [[(  32,   32), $21, SpriteLarge, $002A, 3, 4, false, false]]
        _Sprites ..= [[(  16,   32), $21, SpriteLarge, $0028, 3, 4, false, false]]
        _Sprites ..= [[(   0,   32), $21, SpriteLarge, $0026, 3, 4, false, false]]
        _Sprites ..= [[(  32,   16), $21, SpriteLarge, $0044, 3, 4, false, false]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $0042, 3, 4, false, false]]
        _Sprites ..= [[(   0,   16), $21, SpriteLarge, $0040, 3, 4, false, false]]
        _Sprites ..= [[(  32,    0), $21, SpriteLarge, $0024, 3, 4, false, false]]
        _Sprites ..= [[(  16,    0), $21, SpriteLarge, $0022, 3, 4, false, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $0020, 3, 4, false, false]]

        .structSpriteArray aStatusScreenPortraitSprites._Sprites

        ; 89/A76C

    .endsection SpriteArray89A72ESection


    .section Table89A76CSection

      .al
      .xl

      aConditionNamePointers ; 89/A76C

        ; Read by rlCastleDrawInfoLine (status names) followed by skill descriptions & names.

        .long aConditionHealthyText
        .long aConditionCuredText
        .long aConditionFreelancerText
        .long aConditionCaptiveText
        .long aConditionSilenceText
        .long aConditionSleepText
        .long aConditionBerserkText

      aConditionHealthyText ; 89/A781
        .enc "SJIS"
          .text "せいじょう\n"

      aConditionCuredText ; 89/A78D
        .enc "SJIS"
          .text "ちりょう\n"

      aConditionFreelancerText ; 89/A797
        .enc "SJIS"
          .text "アルバイト\n"

      aConditionCaptiveText ; 89/A7A3
        .enc "SJIS"
          .text "ほりょ\n"

      aConditionSilenceText ; 89/A7AB
        .enc "SJIS"
          .text "サイレス\n"

      aConditionSleepText ; 89/A7B5
        .enc "SJIS"
          .text "スリープ\n"

      aConditionBerserkText ; 89/A7BF
        .enc "SJIS"
          .text "バサーク\n"

      aSkillDescriptionGreatShield ; 89/A7C9
        .enc "SJIS"
          .text "あいてのこうげきを　うけとめダメージを　むこうにする\n"

      aSkillDescriptionWrath ; 89/A7FF
        .enc "SJIS"
          .text "ピンチになったとき　いかりのこうげき\n"

      aSkillDescriptionPursuit ; 89/A825
        .enc "SJIS"
          .text "あいてよりも　　　　みがるならば　　　　さいこうげき\n"

      aSkillDescriptionAdept ; 89/A85B
        .enc "SJIS"
          .text "すばやさのかくりつでれんぞくこうげき\n"

      aSkillDescriptionSteal ; 89/A881
        .enc "SJIS"
          .text "こうげきがあたると　あいてのゴールドを　うばう\n"

      aSkillDescriptionDance ; 89/A8B1
        .enc "SJIS"
          .text "りんせつした　　　　ユニットを　　　　　いどうかのうにする\n"

      aSkillDescriptionCharm ; 89/A8ED
        .enc "SJIS"
          .text "ちかくにいるみかたに１０％のしえんこうか\n"

      aSkillDescriptionNihil ; 89/A917
        .enc "SJIS"
          .text "ひっさつこうげきなどをふうじる\n"

      aSkillDescriptionMiracle ; 89/A937
        .enc "SJIS"
          .text "ピンチになると　　　かいひりつがあがる\n"

      aSkillDescriptionCritical ; 89/A95F
        .enc "SJIS"
          .text "ひっさつのいちげき　こうげきりょくが　　２ばいになる\n"

      aSkillDescriptionVantage ; 89/A995
        .enc "SJIS"
          .text "ピンチになったとき　せんせいこうげき　　をする\n"

      aSkillDescriptionAccost ; 89/A9C5
        .enc "SJIS"
          .text "みがるであれば　　　ときおり　せんとうがけいぞくする\n"

      aSkillDescriptionAstra ; 89/A9FB
        .enc "SJIS"
          .text "５かいれんぞくで　　こうげきする\n"

      aSkillDescriptionLuna ; 89/AA1D
        .enc "SJIS"
          .text "あいてのしゅびりょくをむこうにする\n"

      aSkillDescriptionSol ; 89/AA41
        .enc "SJIS"
          .text "あたえたダメージだけＨＰがかいふくする\n"

      aSkillDescriptionRenewal ; 89/AA69
        .enc "SJIS"
          .text "まいターン　　　　　ＨＰが５から１０　　かいふくする\n"

      aSkillDescriptionParagon ; 89/AA9F
        .enc "SJIS"
          .text "けいけんちを　　　　２ばいもらえる\n"

      aSkillDescriptionBargain ; 89/AAC3
        .enc "SJIS"
          .text "かいものや　　　　　しゅうりが　　　　　はんがくでできる\n"

      aSkillNameGreatShield ; 89/AAFD
        .enc "SJIS"
          .text "おおたて　　\n"

      aSkillNameWrath ; 89/AB0B
        .enc "SJIS"
          .text "いかり　　　\n"

      aSkillNamePursuit ; 89/AB19
        .enc "SJIS"
          .text "ついげき　　\n"

      aSkillNameAdept ; 89/AB27
        .enc "SJIS"
          .text "れんぞく　　\n"

      aSkillNameSteal ; 89/AB35
        .enc "SJIS"
          .text "ぬすむ　　　\n"

      aSkillNameDance ; 89/AB43
        .enc "SJIS"
          .text "おどる　　　\n"

      aSkillNameCharm ; 89/AB51
        .enc "SJIS"
          .text "カリスマ　　\n"

      aSkillNameNihil ; 89/AB5F
        .enc "SJIS"
          .text "みきり　　　\n"

      aSkillNameMiracle ; 89/AB6D
        .enc "SJIS"
          .text "いのり　　　\n"

      aSkillNameCritical ; 89/AB7B
        .enc "SJIS"
          .text "ひっさつ　　\n"

      aSkillNameVantage ; 89/AB89
        .enc "SJIS"
          .text "まちぶせ　　\n"

      aSkillNameAccost ; 89/AB97
        .enc "SJIS"
          .text "とつげき　　\n"

      aSkillNameAstra ; 89/ABA5
        .enc "SJIS"
          .text "りゅうせい剣\n"

      aSkillNameLuna ; 89/ABB3
        .enc "SJIS"
          .text "げっこう剣　\n"

      aSkillNameSol ; 89/ABC1
        .enc "SJIS"
          .text "たいよう剣　\n"

      aSkillNameRenewal ; 89/ABCF
        .enc "SJIS"
          .text "ライブ　　　\n"

      aSkillNameParagon ; 89/ABDD
        .enc "SJIS"
          .text "エリート　　\n"

      aSkillNameBargain ; 89/ABEB
        .enc "SJIS"
          .text "ねぎり　　　\n"

        ; 89/ABF9

    .endsection Table89A76CSection


    .section Table89ABF9Section

      .al
      .xl

      aSkillDescriptionPointers ; 89/ABF9

        ; A long pointer per skill, as rlCollectSelectedUnitIconSkills numbers them (0 for none). Read by
        ; rsStatusScreenDrawSkillDescription.

        .long 0
        .long 0
        .long aSkillDescriptionGreatShield
        .long aSkillDescriptionWrath
        .long aSkillDescriptionPursuit
        .long aSkillDescriptionAdept
        .long aSkillDescriptionSteal
        .long 0
        .long aSkillDescriptionDance
        .long 0
        .long 0
        .long 0
        .long aSkillDescriptionCharm
        .long 0
        .long aSkillDescriptionNihil
        .long aSkillDescriptionMiracle
        .long aSkillDescriptionCritical
        .long aSkillDescriptionVantage
        .long aSkillDescriptionAccost
        .long aSkillDescriptionAstra
        .long aSkillDescriptionLuna
        .long aSkillDescriptionSol
        .long 0
        .long 0
        .long aSkillDescriptionRenewal
        .long aSkillDescriptionParagon
        .long 0
        .long 0
        .long aSkillDescriptionBargain
        .long 0
        .long 0

        ; 89/AC56

    .endsection Table89ABF9Section