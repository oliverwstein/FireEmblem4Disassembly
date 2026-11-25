; The save menu screen (bank $91; its openers are in engine/save/save.asm). One
; game state (rlSaveMenuStep, steps in aSaveMenuSteps) hosts the title file menu
; (step 0: load, new game, erase), the map save (step 2), the slot lists that
; follow them, and the hand-off to a new game, to the next chapter's world map
; events and to the chapter intro (engine/worldmap/chapter_intro.asm). The menu
; is a list of rows (aSaveMenuRowTypes): each row's text is rendered once into
; tiles by the dialogue engine (rlStartTextToTiles), and the rows point at them.
; Choosing a slot only sets aSave.wMenuOperation; rlHandleSaveFile does the
; saving or loading. Also here: the texts of the rows, the chapter number and
; title strings (aChapterTitleTexts, rlBuildChapterTitleString, also used by the
; data window), and the slot checks (rlCheckSaveSlotEmpty, rlCountUsedSaveSlots).


    .section Table8D9B65Section

      .al
      .xl

      aSaveMenuRowTexts ; 8D/9B65

        ; Read by rsSaveMenuRenderRowText.

        .byte $7B, $9B, $7B, $9B, $89, $9B, $95, $9B, $A2, $9B, $B0, $9B, $BD, $9B, $CA, $9B
        .byte $D1, $9B, $D8, $9B, $DE, $9B, $0A, $AC, $0B, $7E, $09, $15, $36, $0A, $BB, $09
        .byte $31, $38, $C5, $01, $09, $C5, $0B, $7F, $80, $09, $3C, $1C, $38, $C5, $C5, $01
        .byte $0B, $7F, $80, $09, $15, $36, $0A, $BB, $09, $31, $38, $C5, $01, $0A, $B5, $0B
        .byte $81, $09, $15, $36, $0A, $BB, $09, $31, $38, $C5, $01, $0B, $7F, $80, $09, $3C
        .byte $0B, $82, $09, $1C, $C5, $C5, $C5, $01, $0B, $7F, $80, $09, $3C, $0B, $83, $09
        .byte $1C, $C5, $C5, $C5, $01, $0C, $69, $37, $09, $C5, $C5, $01, $0B, $83, $09, $1C
        .byte $C5, $C5, $01, $09, $33, $31, $38, $C5, $01, $09, $C5, $C5, $C5, $C5, $C5, $0B
        .byte $7F, $80, $09, $3E, $10, $37, $2E, $1D, $3D, $C5, $C5, $C5, $C5, $C5, $C5, $C5
        .byte $01

        ; 8D/9BF6

    .endsection Table8D9B65Section


    .section Table8D9BF6Section

      .al
      .xl

      aChapterTitleTexts ; 8D/9BF6

        ; Read by rlGetChapterTitleText and bank $91 ending/epilogue screens.

        .word <>aPrologueTitleText
        .word <>aChapter1TitleText
        .word <>aChapter2TitleText
        .word <>aChapter3TitleText
        .word <>aChapter4TitleText
        .word <>aChapter5TitleText
        .word <>aChapter6TitleText
        .word <>aChapter7TitleText
        .word <>aChapter8TitleText
        .word <>aChapter9TitleText
        .word <>aChapter10TitleText
        .word <>aFinalChapterTitleText

      aPrologueTitleText ; 8D/9C0E
        .byte $0A, $2D, $5C, $4B, $0D, $21, $0B, $48, $01

      aChapter1TitleText ; 8D/9C17
        .byte $0B, $D5, $0D, $6D, $09, $28, $0C, $27, $09, $28, $0B, $E7, $0A, $60, $01

      aChapter2TitleText ; 8D/9C26
        .byte $09, $60, $8F, $6C, $73, $87, $60, $28, $0B, $33, $57, $01

      aChapter3TitleText ; 8D/9C32
        .byte $0D, $6B, $0A, $5F, $5E, $09, $63, $88, $73, $6B, $AD, $8C, $01

      aChapter4TitleText ; 8D/9C3F
        .byte $0B, $88, $09, $25, $0D, $69, $09, $12, $01

      aChapter5TitleText ; 8D/9C48
        .byte $0A, $4E, $0B, $41, $09, $28, $0C, $EE, $01

      aChapter6TitleText ; 8D/9C51
        .byte $0B, $18, $09, $3C, $21, $40, $32, $28, $01

      aChapter7TitleText ; 8D/9C5A
        .byte $0B, $DE, $DF, $09, $3C, $19, $13, $22, $01

      aChapter8TitleText ; 8D/9C63
        .byte $09, $73, $86, $66, $60, $28, $0A, $3B, $5C, $4B, $01

      aChapter9TitleText ; 8D/9C6E
        .byte $0D, $6A, $09, $3E, $1F, $31, $25, $01

      aChapter10TitleText ; 8D/9C76
        .byte $0B, $18, $09, $23, $0C, $F5, $09, $23, $01

      aFinalChapterTitleText ; 8D/9C7F
        .byte $0A, $B5, $BC, $09, $28, $0A, $2D, $64, $01

      aPrologueNumberText ; 8D/9C88
        .byte $0D, $68, $09, $C5, $0B, $77, $01

      aChapterNumberText ; 8D/9C8F
        .byte $0B, $84, $09, $E0, $0B, $77, $01

      aChapter10NumberText ; 8D/9C96
        .byte $0B, $84, $09, $EA, $0B, $77, $01, $0B, $84, $09, $EA, $E1, $0B, $77, $01

      aFinalChapterNumberText ; 8D/9CA5
        .byte $0B, $9D, $09, $C5, $0B, $77, $01

      aTurnNumberText ; 8D/9CAC
        .byte $09, $09, $C2, $B1, $B1, $B1, $C3, $01

      aChapterTitleSpaceText ; 8D/9CB4
        .byte $09, $0A, $17, $01

    .endsection Table8D9BF6Section


    .section Unsorted91AB91Section

      .al
      .xl

      rlBuildChapterTitleString ; 91/AB91

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Builds "<chapter number>  <chapter title>" for chapter A (0 prologue, 11 final) as text in aDecompressionBuffer.

        php
        ldx #$0000
        sta aDecompressionBuffer
        cmp #$000C
        bcc _ABA2
        jml _ABEC


        _ABA2
        pha
        pha
        jsr rsCopyChapterNumberText
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        lda #(`aChapterTitleSpaceText)<<8
        sta lR19+1
        lda #<>aChapterTitleSpaceText
        sta lR19
        jsl rlAppendText
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        lda #(`aChapterTitleSpaceText)<<8
        sta lR19+1
        lda #<>aChapterTitleSpaceText
        sta lR19
        jsl rlAppendText
        pla
        jsr rsAppendChapterTitleText
        pla
        beq _ABEC
        cmp #$000A
        bcs _ABEC
        clc
        adc aDecompressionBuffer+3
        sta aDecompressionBuffer+3

        _ABEC
        plp
        rtl

        .databank 0

        ; 91/ABEE

    .endsection Unsorted91AB91Section


    .section Unsorted91ABEESection

      .al
      .xl

      rlBuildSaveSlotChapterString ; 91/ABEE

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Builds the chapter number of save slot A and its turn in parentheses, as text in aDecompressionBuffer. A slot saved between chapters (turn $FFFF) shows the next chapter and no turn.

        php
        pha
        jsl rlGetSaveSlotTurn
        tax
        pla
        phx
        jsl rlGetSaveSlotChapter
        plx
        cpx #$FFFF
        bne _AC05
        inc a
        ldx #$0000

        _AC05
        phx
        pha
        jsr rsCopyChapterNumberText
        pla
        beq _AC1B
        cmp #$000A
        bcs _AC1B
        clc
        adc aDecompressionBuffer+3
        sta aDecompressionBuffer+3

        _AC1B
        pla
        cmp #$0000
        beq _AC77
        pha
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        lda #(`aTurnNumberText)<<8
        sta lR19+1
        lda #<>aTurnNumberText
        sta lR19
        jsl rlAppendText
        pla
        cmp #$03E8
        bcc _AC43
        lda #$03E7

        _AC43
        jsl rlSplitNumberIntoDigits
        ldx #$0000

        _AC4A
        lda aDecompressionBuffer,x
        cmp #$B1B1
        beq _AC56
        inc x
        bra _AC4A


        _AC56
        lda aDecompressionBuffer,x
        clc
        adc wR2
        sta aDecompressionBuffer,x
        lda aDecompressionBuffer+1,x
        clc
        adc wR1
        sta aDecompressionBuffer+1,x
        lda aDecompressionBuffer+2,x
        clc
        adc wR0
        sta aDecompressionBuffer+2,x

        _AC77
        plp
        rtl

        .databank 0

        ; 91/AC79

    .endsection Unsorted91ABEESection


    .section Unsorted91AC79Section

      .al
      .xl

      rlGetSaveSlotChapterTitle ; 91/AC79

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; lR18 = the title text of save slot A's chapter (the next chapter for a slot saved between chapters).

        php
        pha
        jsl rlGetSaveSlotTurn
        tax
        pla
        phx
        jsl rlGetSaveSlotChapter
        plx
        cpx #$FFFF
        bne _AC90
        inc a
        ldx #$0000

        _AC90
        jsl rlGetChapterTitleText
        plp
        rtl

        .databank 0

        ; 91/AC96

    .endsection Unsorted91AC79Section


    .section Unsorted91AC96Section

      .al
      .xl

      rsCopyChapterNumberText ; 91/AC96

        .al
        .xl
        .autsiz
        .databank ?

        cmp #$000B
        bcs _ACC9
        cmp #$000A
        bcs _ACBD
        and #$FFFF
        bne _ACB1
        lda #(`aPrologueNumberText)<<8
        sta lR18+1
        lda #<>aPrologueNumberText
        sta lR18
        bra _ACD3


        _ACB1
        lda #(`aChapterNumberText)<<8
        sta lR18+1
        lda #<>aChapterNumberText
        sta lR18
        bra _ACD3


        _ACBD
        lda #(`aChapter10NumberText)<<8
        sta lR18+1
        lda #<>aChapter10NumberText
        sta lR18
        bra _ACD3


        _ACC9
        lda #(`aFinalChapterNumberText)<<8
        sta lR18+1
        lda #<>aFinalChapterNumberText
        sta lR18

        _ACD3
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlCopyText
        rts

        .databank 0

        ; 91/ACE2

    .endsection Unsorted91AC96Section


    .section Unsorted91ACE2Section

      .al
      .xl

      rlGetChapterTitleText ; 91/ACE2

        .al
        .xl
        .autsiz
        .databank ?

        asl a
        tax
        lda #$8D00
        sta lR18+1
        lda aChapterTitleTexts,x
        sta lR18
        rtl

        .databank 0

        ; 91/ACF0

      rsAppendChapterTitleText ; 91/ACF0

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetChapterTitleText
        lda lR18
        sta lR19
        lda lR18+1
        sta lR19+1
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        jsl rlAppendText
        rts

        .databank 0

        ; 91/AD0B

    .endsection Unsorted91ACE2Section


    .section Unsorted91D616Section

      .al
      .xl

      rlSaveMenuUpkeep ; 91/D616

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $04, every frame while the save menu screen is up: does nothing.

        rtl

        .databank 0

        ; 91/D617

      rlSaveMenuSetup ; 91/D617

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $05, once: moves on to $06. The callers set wGameStateStep themselves.

        inc wGameStateRoutine1,b
        rtl

        .databank 0

        ; 91/D61B

      rlSaveMenuStep ; 91/D61B

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $06, every frame: runs the routine for wGameStateStep from aSaveMenuSteps: the title file menu (step 0), the map save (step 2), the next chapter's world map events (step $23) and the chapter intro title card (step $24).

        phb
        php
        phk
        plb
        .databank $91
        lda wGameStateStep,b
        asl a
        tax
        jsr (aSaveMenuSteps,x)
        plp
        plb
        .databank $91
        rtl

        .databank 0

        ; 91/D62A

    .endsection Unsorted91D616Section


    .section Table91D62ASection

      .al
      .xl

      aSaveMenuSteps ; 91/D62A

        ; Jump table of rlSaveMenuStep, by wGameStateStep. Most screens take two
        ; steps: the first sets up the rows and has them drawn (step $0D), which
        ; returns to the second, the input loop inside the same routine.
        .word <>rsSaveMenuFileCommands ; $00: title file menu: the commands
        .word <>rsSaveMenuFileCommands._Input ; $01
        .word <>rsSaveMenuSaveSlots ; $02: map save: the slots
        .word <>rsSaveMenuSaveSlots._Input ; $03
        .word <>rsSaveMenuSavedFadeOut ; $04: saved: fade out, back to the game
        .word <>rsSaveMenuSaveCancelledFadeOut ; $05: save cancelled: fade out
        .word <>rsSaveMenuLoadSlots ; $06: load: the slots
        .word <>rsSaveMenuLoadSlots._Input ; $07
        .word <>rsSaveMenuLoadedFadeOut ; $08: loaded: fade out, start the map
        .word <>rsSaveMenuCopySlots ; $09: copy: the slots (never offered)
        .word <>rsSaveMenuCopySlots._Input ; $0A
        .word <>rsSaveMenuEraseSlots ; $0B: erase: the slots
        .word <>rsSaveMenuEraseSlots._Input ; $0C
        .word <>rsSaveMenuDrawRows ; $0D: draw the rows, then wSaveMenuNextStep
        .word <>rsSaveMenuDrawRows._Done ; $0E
        .word <>rsSaveMenuRedrawRows ; $0F: unused here: back to $0D
        .word <>rsSaveMenuRedrawSlotText ; $10: redraw an erased slot's row
        .word <>rsSaveMenuWaitSlotText ; $11
        .word <>rsSaveMenuRedrawSlotDetails ; $12
        .word <>rsSaveMenuWaitSlotDetails ; $13
        .word <>rsFileMenuReloadRegisters ; $14: back to the file menu: reload the screen
        .word <>rsFileMenuReloadTiles ; $15
        .word <>rsFileMenuReloadBG2Tilemap ; $16
        .word <>rsFileMenuReloadBG3Tiles ; $17
        .word <>rsFileMenuRenderRowTexts ; $18: render the row texts
        .word <>rsFileMenuRenderRowTexts._E667 ; $19
        .word <>rsFileMenuRenderSlotTitles ; $1A: render the slot titles
        .word <>rsFileMenuReloadDone ; $1B: then step 0
        .word <>rsJugdralHistorySetup ; $1C: new game: the Jugdral history
        .word <>rsJugdralHistoryUploadFont ; $1D
        .word <>rsJugdralHistoryShow ; $1E
        .word <>rsJugdralHistoryFirstLine ; $1F
        .word <>rsJugdralHistoryScroll ; $20
        .word <>rsJugdralHistoryHold ; $21
        .word <>rsSaveMenuStartNewGame ; $22: start a new game
        .word <>rsSaveMenuStartNewGame._NextChapter ; $23: the next chapter's world map events (rsOpenChapterSaveTransition)
        .word <>rsChapterIntroStart ; $24: the chapter intro (rsOpenChapterIntroScreen)
        .word <>rsChapterIntroFadeIn ; $25
        .word <>rsChapterIntroHold ; $26
        .word <>rsChapterIntroFadeOut ; $27
        .word <>rsChapterIntroSkip ; $28
        .word <>rsStartChapterWorldMapEvents ; $29: start the chapter's world map events
        .word <>rsSaveMenuIdle ; $2A: wait
        .word <>rsSaveMenuUnusedStep ; $2B

    .endsection Table91D62ASection


    .section Unsorted91D682Section

      .al
      .xl

      rsSaveMenuUnusedStep ; 91/D682

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 91/D683

    .endsection Unsorted91D682Section


    .section Unsorted91D683Section

      .al
      .xl

      rsSaveMenuStartNewGame ; 91/D683

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $22, after the history: takes a new save ID, clears the chapter flags and starts the prologue's world map events (step $29). Step $23 enters at _NextChapter (chapter flags cleared, no new save), for the next chapter's world map events.

        jsl rlCheckCodeChecksumsCopy88
        jsl rlStartNewGameSave
        lda #$0000
        sta aSave,b

        _NextChapter
        stz wChapterFlags,b
        lda #$0029
        sta wGameStateStep,b
        rts

        .databank 0

        ; 91/D69B

    .endsection Unsorted91D683Section


    .section Unsorted91D69BSection

      .al
      .xl

      rsStartChapterWorldMapEvents ; 91/D69B

        .al
        .autsiz
        .databank ?

        lda #(`aWorldMapEvents)<<8
        sta lR18+1

        lda wCurrentChapter,b
        cmp #$0012
        bcc +

          lda #0

        +
        asl a
        tax
        lda aWorldMapEvents,x
        sta lR18
        jsl rlStartEventScript
        inc wGameStateStep,b
        rts

        .databank 0

        ; 91/D6BB

    .endsection Unsorted91D69BSection


    .section Unsorted91D6BBSection

      .al
      .xl

      rsSaveMenuIdle ; 91/D6BB

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 91/D6BC

    .endsection Unsorted91D6BBSection


    .section Unsorted91D6ECSection

      .al
      .xl

      rlLoadSaveMenuScreen ; 91/D6EC

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the screen registers, loads the save menu's graphics, tilemaps and palettes, renders every row's text into tiles, and creates the menu's HDMA. The command menu starts with no slot chosen.

        php
        jsr rsSetSaveMenuScreenRegisters
        lda #(`g4bppcSaveMenuWindowTiles)<<8
        sta lR18+1
        lda #<>g4bppcSaveMenuWindowTiles
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $0800, $80, $6000

        jsl rlClearSpriteExtBuffer
        stz wNextFreeSpriteOffset,b
        jsl rlHideSprites
        lda #$03FF
        jsl rlFillBG3Page0TilemapBuffer
        jsl rlDMAByStruct

          .structDMAToVRAM g2bppBlankTile, $0010, $80, $DFF0

        lda #(`g4bppcSaveMenuMainTiles)<<8
        sta lR18+1
        lda #<>g4bppcSaveMenuMainTiles
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $4800, $80, $0000

        lda #(`acSaveMenuBG2Tilemap)<<8
        sta lR18+1
        lda #<>acSaveMenuBG2Tilemap
        sta lR18
        lda #(`aBG2TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG2TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aBG2TilemapBuffer, $0800, $80, $7800

        lda #(`acSaveMenuBG1Tilemap)<<8
        sta lR18+1
        lda #<>acSaveMenuBG1Tilemap
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$7B88
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $8000

        lda #(`acSaveMenuPalettes)<<8
        sta lR18+1
        lda #<>acSaveMenuPalettes
        sta lR18
        lda #(`aBGPaletteBuffer)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlResetDialogueEngine
        jsl rlDialogueFreeHDMA
        lda #$5000
        sta aDialogue._Slot[0].wVRAMAddress,b
        jsr rsSaveMenuRenderAllRowTexts
        jsr rsSaveMenuUploadBG3Tilemap
        jsl rlResetHDMAEngine
        jsl rlCreateSaveMenuHDMA
        lda #$0000
        sta wSaveMenuCommandRow,b
        lda #$FFFF
        sta wSaveMenuSlotRow,b
        stz wSaveMenuConfirm,b
        plp
        rtl

        .databank 0

        ; 91/D7E8

    .endsection Unsorted91D6ECSection


    .section Unsorted91D7F8Section

      .al
      .xl

      rsSaveMenuCommandsStub ; 91/D7F8

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 91/D7F9

    .endsection Unsorted91D7F8Section


    .section Unsorted91D7F9Section

      .al
      .xl

      rsSaveMenuBuildCommandRows ; 91/D7F9

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Rows of the file menu: "load" if a slot is used, "new game", then "erase" if a slot is used. The "copy" row is loaded but never added (the jsr after lda #5 is missing), so copying cannot be reached.

        stz wSaveMenuRowCount,b
        jsl rlCountUsedSaveSlots
        and #$FFFF
        beq _D80B
        lda #$0003
        jsr rsSaveMenuAddRow

        _D80B
        lda #$0004
        jsr rsSaveMenuAddRow
        jsl rlCountUsedSaveSlots
        and #$FFFF
        beq _D81D
        lda #$0005

        _D81D
        jsl rlCountUsedSaveSlots
        and #$FFFF
        beq _D82C
        lda #$0006
        jsr rsSaveMenuAddRow

        _D82C
        lda wSaveMenuRowCount,b
        cmp wSaveMenuCommandRow,b
        bcs _D838
        dec a
        sta wSaveMenuCommandRow,b

        _D838
        rts

        .databank 0

        ; 91/D839

    .endsection Unsorted91D7F9Section


    .section Unsorted91D839Section

      .al
      .xl

      rsSaveMenuAddRow ; 91/D839

        .al
        .xl
        .autsiz
        .databank ?

        ldx wSaveMenuRowCount,b
        sta @l aSaveMenuRowTypes,x
        inc wSaveMenuRowCount,b
        rts

        .databank 0

        ; 91/D844

    .endsection Unsorted91D839Section


    .section Unsorted91D844Section

      .al
      .xl

      rsSaveMenuFileCommands ; 91/D844

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Step 0 (title file menu): draws the command rows, then (step 1) moves the cursor and on A goes to the command's step from aSaveMenuCommandSteps.

        jsr rsSaveMenuBuildCommandRows
        jsr rsSaveMenuSetWindowPosition
        lda #$0001
        jsr rsSaveMenuStartDrawingRows
        jsr rsSaveMenuCommandsStub

        _Input
        lda wSaveMenuCommandRow,b
        jsl rlSaveMenuDrawSprites
        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _D898
        lda wMusicID,b
        bne _D898
        jsr rsSaveMenuMoveCommandCursor
        jsr rsSaveMenuScrollBackground
        lda wJoy1New
        bit #$0080
        beq _D898
        lda #$000A
        jsl rlPlaySoundEffect
        ldx wSaveMenuCommandRow,b
        lda @l aSaveMenuRowTypes,x
        and #$00FF
        tax
        lda aSaveMenuCommandSteps,x
        and #$00FF
        sta wGameStateStep,b
        lda #$0001
        sta wSaveMenuSlotRow,b

        _D898
        rts

        .databank 0

        ; 91/D899

    .endsection Unsorted91D844Section


    .section Data91D899Section

      .al
      .xl

      aSaveMenuCommandSteps ; 91/D899

        ; Read by rsSaveMenuFileCommands.

        .byte $00, $02, $02, $06, $1C, $09, $0B

        ; 91/D8A0

    .endsection Data91D899Section


    .section Unsorted91D8A0Section

      .al
      .xl

      rsSaveMenuSaveSlots ; 91/D8A0

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 2 (map save): the four slots, the cursor on the active one; on a confirmed slot sets aSave.wMenuOperation to it (the save is written by rlHandleSaveFile) and fades out (step 4); B fades out without saving (step 5).

        lda #$0002
        jsr rsSaveMenuBuildSlotRows
        jsr rsSaveMenuSetWindowPosition
        lda #$0003
        jsr rsSaveMenuStartDrawingRows
        lda aSave,b
        cmp #$0004
        bcc _D8BA
        lda #$0000

        _D8BA
        inc a
        sta wSaveMenuSlotRow,b

        _Input
        jsr rsSaveMenuSlotInput
        cmp #$0002
        beq _D8DD
        cmp #$0001
        bne _D8EA
        lda #$000E
        jsl rlPlaySoundEffect
        lda wSaveMenuSlotRow,b
        sta aSave.wMenuOperation,b
        inc wGameStateStep,b
        bra _D8EA


        _D8DD
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0005
        sta wGameStateStep,b

        _D8EA
        rts

        .databank 0

        ; 91/D8EB

      rsSaveMenuSavedFadeOut ; 91/D8EB

        .al
        .xl
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #$000F
        beq _D904
        lda wSaveMenuSlotRow,b
        jsl rlSaveMenuDrawSprites
        lda wVBlankEnabledFramecount
        and #$0001
        bne _D90C
        dec bBufferINIDISP
        bra _D90C


        _D904
        lda aSave.wMenuOperation,b
        bne _D90C
        jsr rsSaveMenuLeaveMapSave

        _D90C
        rts

        .databank 0

        ; 91/D90D

    .endsection Unsorted91D8A0Section


    .section Unsorted91D90DSection

      .al
      .xl

      rsSaveMenuSaveCancelledFadeOut ; 91/D90D

        .al
        .xl
        .autsiz
        .databank ?

        lda wSaveMenuSlotRow,b
        jsl rlSaveMenuDrawSprites
        dec bBufferINIDISP
        lda bBufferINIDISP
        and #$000F
        bne _D920
        jsr rsSaveMenuLeaveMapSave

        _D920
        rts

        .databank 0

        ; 91/D921

    .endsection Unsorted91D90DSection


    .section Unsorted91D921Section

      .al
      .xl

      rsSaveMenuLeaveMapSave ; 91/D921

        .al
        .xl
        .autsiz
        .databank ?

        ; After the map save: to the next chapter if chapter flag $0400 is set, else to the castle screen if flag $0020 is set, else back to the map.

        lda wChapterFlags,b
        bit #$0400
        beq _D92F
        jsl rlAdvanceToNextChapter
        bra _D944


        _D92F
        lda wChapterFlags,b
        bit #$0020
        beq _D941
        jsl rlFadeToCastleScreen
        jsl rlResumePhaseMusic
        bra _D944


        _D941
        jsr rsSaveMenuReturnToMap

        _D944
        rts

        .databank 0

        ; 91/D945

    .endsection Unsorted91D921Section


    .section Unsorted91D945Section

      .al
      .xl

      rsSaveMenuLoadSlots ; 91/D945

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 6: the four slots, the cursor on the last saved one; on a confirmed used slot sets aSave.wMenuOperation to it with bit 15 (load) and fades out (step 8).

        lda #$0003
        jsr rsSaveMenuBuildSlotRows
        jsr rsSaveMenuSetWindowPosition
        jsl rlGetLastSavedSlot
        and #$0003
        inc a
        sta wSaveMenuSlotRow,b
        lda #$0007
        jsr rsSaveMenuStartDrawingRows

        _Input
        jsr rsSaveMenuSlotInput
        cmp #$0002
        beq _D994
        cmp #$0001
        bne _D994
        jsl rlCheckCodeChecksumsCopy88
        lda wSaveMenuSlotRow,b
        dec a
        jsl rlCheckSaveSlotEmpty
        bcs _D994
        lda #$000A
        jsl rlPlaySoundEffect
        lda #$00E0
        jsl rlSendSoundCommand
        lda wSaveMenuSlotRow,b
        ora #$8000
        sta aSave.wMenuOperation,b
        inc wGameStateStep,b

        _D994
        rts

        .databank 0

        ; 91/D995

    .endsection Unsorted91D945Section


    .section Unsorted91D995Section

      .al
      .xl

      rsSaveMenuLoadedFadeOut ; 91/D995

        .al
        .xl
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #$000F
        beq _D9AE
        lda wSaveMenuSlotRow,b
        jsl rlSaveMenuDrawSprites
        lda wVBlankEnabledFramecount
        and #$0001
        bne _D9C4
        dec bBufferINIDISP
        bra _D9C4


        _D9AE
        lda aSave.wMenuOperation,b
        bne _D9C4
        lda wCurrentTurn,b
        cmp #$FFFF
        beq _D9C0
        jsr rsSaveMenuStartLoadedMap
        bra _D9C4


        _D9C0
        jsl rlAdvanceToNextChapter

        _D9C4
        rts

        .databank 0

        ; 91/D9C5

    .endsection Unsorted91D995Section


    .section Unsorted91D9FASection

      .al
      .xl

      rsSaveMenuCopySlots ; 91/D9FA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Step 9: the slot list for copying, which does nothing when a slot is confirmed. The command menu never offers it (rsSaveMenuBuildCommandRows).

        lda #$0005
        jsr rsSaveMenuBuildSlotRows
        jsr rsSaveMenuSetWindowPosition
        lda #$000A
        jsr rsSaveMenuStartDrawingRows

        _Input
        jsr rsSaveMenuSlotInput
        cmp #$0002
        beq _DA24
        cmp #$0001
        bne _DA24
        lda wJoy1New
        bit #$0080
        beq _DA24
        lda #$000A
        jsl rlPlaySoundEffect

        _DA24
        rts

        .databank 0

        ; 91/DA25

    .endsection Unsorted91D9FASection


    .section Unsorted91DA25Section

      .al
      .xl

      rsSaveMenuEraseSlots ; 91/DA25

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Step $0B: on a confirmed used slot erases it (rlEraseSaveSlot) and redraws that row.

        lda #$0006
        jsr rsSaveMenuBuildSlotRows
        jsr rsSaveMenuSetWindowPosition
        lda #$000C
        jsr rsSaveMenuStartDrawingRows

        _Input
        jsr rsSaveMenuSlotInput
        cmp #$0002
        beq _DA63
        cmp #$0001
        bne _DA63
        lda wSaveMenuSlotRow,b
        dec a
        jsl rlCheckSaveSlotEmpty
        bcs _DA63
        lda #$000E
        jsl rlPlaySoundEffect
        lda wSaveMenuSlotRow,b
        dec a
        jsl rlEraseSaveSlot
        jsr rsSaveMenuBuildSlotRows
        lda #$000C
        jsr rsSaveMenuStartRedrawingSlot

        _DA63
        rts

        .databank 0

        ; 91/DA64

    .endsection Unsorted91DA25Section


    .section Unsorted91DA64Section

      .al
      .xl

      rsSaveMenuSlotInput ; 91/DA64

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Input on a slot list. Returns 0 while choosing, 1 when a slot is confirmed (A, then yes; on the load list A alone), 2 on B (which goes back to the file menu, except on the map save).

        lda wSaveMenuSlotRow,b
        jsl rlSaveMenuDrawSprites
        jsr rsSaveMenuScrollBackground
        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _DAD2
        lda wMusicID,b
        bne _DAD2
        lda wSaveMenuConfirm,b
        bne _DAD6
        jsr rsSaveMenuMoveSlotCursor
        lda wJoy1New
        bit #$0080
        beq _DAA6
        lda wGameStateStep,b
        cmp #$0007
        beq _DACD
        lda #$000A
        jsl rlPlaySoundEffect
        jsr rsSaveMenuDrawConfirmWindow
        lda #$0001
        sta wSaveMenuConfirm,b
        bra _DAD2


        _DAA6
        lda wJoy1New
        bit #$8000
        beq _DAD2
        lda wGameStateStep,b
        cmp #$0003
        beq _DAC8
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$FFFF
        sta wSaveMenuSlotRow,b
        lda #$0000
        sta wGameStateStep,b

        _DAC8
        lda #$0002
        bra _DAD5


        _DACD
        lda #$0001
        bra _DAD5


        _DAD2
        lda #$0000

        _DAD5
        rts


        _DAD6
        lda wJoy1Repeated
        bit #$0C00
        beq _DAE8
        lda wSaveMenuConfirm,b
        dec a
        eor #$0001
        inc a
        sta wSaveMenuConfirm,b

        _DAE8
        lda wJoy1New
        bit #$8080
        beq _DB13
        jsr rsSaveMenuClearConfirmWindow
        lda wJoy1New
        bit #$8000
        bne _DB09
        lda wSaveMenuConfirm,b
        cmp #$0001
        bne _DB09
        stz wSaveMenuConfirm,b
        lda #$0001
        bra _DB16


        _DB09
        lda #$0021
        jsl rlPlaySoundEffect
        stz wSaveMenuConfirm,b

        _DB13
        lda #$0000

        _DB16
        rts

        .databank 0

        ; 91/DB17

    .endsection Unsorted91DA64Section


    .section Unsorted91DB17Section

      .al
      .xl

      rsSaveMenuDrawConfirmWindow ; 91/DB17

        .al
        .xl
        .autsiz
        .databank ?

        lda #$20C0
        ldx wGameStateStep,b
        cpx #$0003
        beq _DB25
        lda #$20D0

        _DB25
        ldx #$0134
        jsr rsSaveMenuDrawFourTiles
        ldx #$01B4
        lda #$20E0
        jsr rsSaveMenuDrawFourTiles
        jsr rsSaveMenuUploadBG3Tilemap
        rts

        .databank 0

        ; 91/DB38

      rsSaveMenuDrawFourTiles ; 91/DB38

        .al
        .xl
        .autsiz
        .databank ?

        ldy #$0004

        _DB3B
        sta aBG3TilemapBuffer,x
        inc a
        sta $7E83C8,x
        inc a
        inc x
        inc x
        dec y
        bne _DB3B
        rts

        .databank 0

        ; 91/DB4B

      rsSaveMenuClearConfirmWindow ; 91/DB4B

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0134
        ldy #$0004
        lda #$03FF

        _DB54
        sta aBG3TilemapBuffer,x
        sta $7E83C8,x
        sta $7E8408,x
        sta $7E8448,x
        inc x
        inc x
        dec y
        bne _DB54
        jsr rsSaveMenuUploadBG3Tilemap
        rts

        .databank 0

        ; 91/DB6D

    .endsection Unsorted91DB17Section


    .section Unsorted91DB6DSection

      .al
      .xl

      rsSaveMenuBuildSlotRows ; 91/DB6D

        .al
        .xl
        .autsiz
        .databank ?

        ; Rows: the heading row of type A, then the four slots.

        stz wSaveMenuRowCount,b
        jsr rsSaveMenuAddRow
        lda #$0000
        jsr rsGetSaveSlotRowType
        jsr rsSaveMenuAddRow
        lda #$0001
        jsr rsGetSaveSlotRowType
        jsr rsSaveMenuAddRow
        lda #$0002
        jsr rsGetSaveSlotRowType
        jsr rsSaveMenuAddRow
        lda #$0003
        jsr rsGetSaveSlotRowType
        jsr rsSaveMenuAddRow
        rts

        .databank 0

        ; 91/DB98

      rsGetSaveSlotRowType ; 91/DB98

        .al
        .xl
        .autsiz
        .databank ?

        ; Row type for slot A: 11 + A for a used slot, 10 ("no record") for an empty one.

        jsl rlCheckSaveSlotEmpty
        bcs _DBA4
        clc
        adc #$000B
        bra _DBA7


        _DBA4
        lda #$000A

        _DBA7
        rts

        .databank 0

        ; 91/DBA8

    .endsection Unsorted91DB6DSection


    .section Unsorted91DBA8Section

      .al
      .xl

      rsSaveMenuStartLoadedMap ; 91/DBA8

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferTM
        and #$13
        sta bBufferTM
        rep #$20
        lda #$0100
        tsb wChapterFlags,b
        stz wGameStateRoutine1,b
        lda #<>rsStartChapterMap
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .databank 0

        ; 91/DBD0

    .endsection Unsorted91DBA8Section


    .section Unsorted91DBD0Section

      .al
      .xl

      rsSaveMenuReturnToMap ; 91/DBD0

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        sta wMainGameMode,b
        stz wGameStateRoutine1,b
        lda #<>rsReturnToMapMainLoop
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .databank 0

        ; 91/DBEE

    .endsection Unsorted91DBD0Section


    .section Unsorted91DBEESection

      .al
      .xl

      rsSaveMenuDrawRows ; 91/DBEE

        .al
        .xl
        .autsiz
        .databank ?

        ; Step $0D: draws the rows not yet drawn into the BG3 tilemap, then goes to the step in wSaveMenuNextStep.

        lda wSaveMenuRowsDrawn,b
        inc wSaveMenuRowsDrawn,b
        cmp wSaveMenuRowCount,b
        beq _DBFE
        jsr rsSaveMenuDrawRowTiles
        bra rsSaveMenuDrawRows


        _DBFE
        inc wGameStateStep,b

        _Done
        jsr rsSaveMenuUploadBG3Tilemap
        sep #$20
        lda #$16
        sta bBufferTM
        rep #$20
        lda wSaveMenuNextStep,b
        sta wGameStateStep,b
        rts

        .databank 0

        ; 91/DC13

    .endsection Unsorted91DBEESection


    .section Unsorted91DC13Section

      .al
      .xl

      rsSaveMenuRedrawRows ; 91/DC13

        .al
        .xl
        .autsiz
        .databank ?

        lda #$000D
        sta wGameStateStep,b
        rts

        .databank 0

        ; 91/DC1A

    .endsection Unsorted91DC13Section


    .section Unsorted91DC1ASection

      .al
      .xl

      rsSaveMenuRedrawSlotText ; 91/DC1A

        .al
        .xl
        .autsiz
        .databank ?

        lda wSaveMenuSlotRow,b
        jsl rlSaveMenuDrawSprites
        ldx wSaveMenuSlotRow,b
        lda @l aSaveMenuRowTypes,x
        and #$00FF
        cmp #$000B
        bcc _DC33
        jsr rsSaveMenuRenderRowText

        _DC33
        inc wGameStateStep,b
        rts

        .databank 0

        ; 91/DC37

    .endsection Unsorted91DC1ASection


    .section Unsorted91DC37Section

      .al
      .xl

      rsSaveMenuWaitSlotText ; 91/DC37

        .al
        .xl
        .autsiz
        .databank ?

        lda wSaveMenuSlotRow,b
        jsl rlSaveMenuDrawSprites
        jsl rlRunDialogueCycle
        lda aDialogue.wStatus,b
        bne _DC4F
        lda aDialogue.wPendingTileBytes,b
        bne _DC4F
        inc wGameStateStep,b

        _DC4F
        rts

        .databank 0

        ; 91/DC50

    .endsection Unsorted91DC37Section


    .section Unsorted91DC50Section

      .al
      .xl

      rsSaveMenuRedrawSlotDetails ; 91/DC50

        .al
        .xl
        .autsiz
        .databank ?

        lda wSaveMenuSlotRow,b
        jsl rlSaveMenuDrawSprites
        ldx wSaveMenuSlotRow,b
        lda @l aSaveMenuRowTypes,x
        and #$00FF
        cmp #$000B
        bcc _DC69
        jsr rsSaveMenuRenderSlotTitle

        _DC69
        inc wGameStateStep,b
        rts

        .databank 0

        ; 91/DC6D

    .endsection Unsorted91DC50Section


    .section Unsorted91DC6DSection

      .al
      .xl

      rsSaveMenuWaitSlotDetails ; 91/DC6D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wSaveMenuSlotRow,b
        jsl rlSaveMenuDrawSprites
        jsl rlRunDialogueCycle
        lda aDialogue.wStatus,b
        bne _DC91
        lda aDialogue.wPendingTileBytes,b
        bne _DC91
        lda wSaveMenuSlotRow,b
        jsr rsSaveMenuDrawRowTiles
        jsr rsSaveMenuUploadBG3Tilemap
        lda wSaveMenuNextStep,b
        sta wGameStateStep,b

        _DC91
        rts

        .databank 0

        ; 91/DC92

    .endsection Unsorted91DC6DSection


    .section Unsorted91DC92Section

      .al
      .xl

      rsSaveMenuStartDrawingRows ; 91/DC92

        .al
        .xl
        .autsiz
        .databank ?

        sta wSaveMenuNextStep,b
        lda #$000D
        sta wGameStateStep,b
        stz wSaveMenuConfirm,b
        stz wSaveMenuRowsDrawn,b
        lda #$03FF
        jsl rlFillBG3Page0TilemapBuffer
        jml rsSaveMenuDrawRows

        .databank 0

        ; 91/DCAC

      rsSaveMenuStartRedrawingSlot ; 91/DCAC

        .al
        .xl
        .autsiz
        .databank ?

        sta wSaveMenuNextStep,b
        lda #$0010
        sta wGameStateStep,b
        stz wSaveMenuConfirm,b
        rts

        .databank 0

        ; 91/DCB9

      rsSaveMenuSetWindowPosition ; 91/DCB9

        .al
        .xl
        .autsiz
        .databank ?

        lda #$060C
        ldx wSaveMenuSlotRow,b
        cpx #$FFFF
        beq _DCC7
        lda #$0606

        _DCC7
        sta wSaveMenuWindowPosition,b
        lda #$0005
        sec
        sbc wSaveMenuRowCount,b
        asl a
        sta wR0
        lda wSaveMenuWindowPosition+1,b
        clc
        adc wR0
        sta wSaveMenuWindowPosition+1,b
        rts

        .databank 0

        ; 91/DCDE

    .endsection Unsorted91DC92Section


    .section Unsorted91DCDESection

      .al
      .xl

      rsSaveMenuScrollBackground ; 91/DCDE

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0001
        bne _DCE9
        dec wBufferBG1HOFS
        inc wBufferBG1VOFS

        _DCE9
        rts

        .databank 0

        ; 91/DCEA

      rsSaveMenuUploadBG3Tilemap ; 91/DCEA

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $9000

        rts

        .databank 0

        ; 91/DCF8

    .endsection Unsorted91DCDESection


    .section Unsorted91DCF8Section

      .al
      .xl

      rsSaveMenuDrawRowTiles ; 91/DCF8

        .al
        .xl
        .autsiz
        .databank ?

        ; Writes row A's tiles (two rows high, pointing at its rendered text) into the BG3 tilemap buffer; the auto save's slot uses palette 3.

        sta wR7
        tax
        lda #$7E00
        sta aDialogue._Slot[0].lBGBufferPosition+1,b
        lda wSaveMenuWindowPosition,b
        and #$FF00
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wSaveMenuWindowPosition,b
        and #$00FF
        clc
        adc wR0
        asl a
        clc
        adc #$8388
        sta aDialogue._Slot[0].lBGBufferPosition,b
        lda wSaveMenuSlotRow,b
        cmp #$FFFF
        beq _DD34
        cpx #$0000
        bne _DD34
        lda aDialogue._Slot[0].lBGBufferPosition,b
        clc
        adc #$FF4C
        sta aDialogue._Slot[0].lBGBufferPosition,b

        _DD34
        txa
        xba
        tay
        phx
        lda @l aSaveMenuRowTypes,x
        and #$00FF
        dec a
        asl a
        tax
        lda aSaveMenuRowTextTiles,x
        plx
        pha
        lda aDialogue._Slot[0].lBGBufferPosition+1,b
        sta lR18+1
        sta lR19+1
        lda aDialogue._Slot[0].lBGBufferPosition,b
        sta lR18
        clc
        adc #$0040
        sta lR19
        phx
        ldx #$2000
        jsl rlGetAutoSaveOption
        and #$FFFF
        beq _DD73
        jsl rlGetAutoSaveFile
        inc a
        cmp wR7
        bne _DD73
        ldx #$3000

        _DD73
        stx wR6
        plx
        lda wSaveMenuSlotRow,b
        cmp #$FFFF
        beq _DD83
        cpx #$0000
        bne _DD88

        _DD83
        ldx #$000B
        bra _DD8B


        _DD88
        ldx #$0018

        _DD8B
        pla
        clc
        adc wR6

        _DD8F
        sta [lR18],y
        inc a
        sta [lR19],y
        inc a
        inc y
        inc y
        dec x
        bne _DD8F
        rts

        .databank 0

        ; 91/DD9B

    .endsection Unsorted91DCF8Section


    .section Unsorted91DD9BSection

      .al
      .xl

      rsSaveMenuRenderAllRowTexts ; 91/DD9B

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        sta wSaveMenuRowsDrawn,b

        _DDA1
        lda wSaveMenuRowsDrawn,b
        jsr rsSaveMenuRenderRowText

        _DDA7
        jsl rlRunDialogueCycle
        lda aDialogue.wStatus,b
        bne _DDA7
        lda aDialogue.wPendingTileBytes,b
        bne _DDA7
        lda wSaveMenuRowsDrawn,b
        jsr rsSaveMenuRenderSlotTitle

        _DDBB
        jsl rlRunDialogueCycle
        lda aDialogue.wStatus,b
        bne _DDBB
        lda aDialogue.wPendingTileBytes,b
        bne _DDBB
        lda wSaveMenuRowsDrawn,b
        inc wSaveMenuRowsDrawn,b
        cmp #$000E
        bne _DDA1
        rts

        .databank 0

        ; 91/DDD5

    .endsection Unsorted91DD9BSection


    .section Table91DDD5Section

      .al
      .xl

      aSaveMenuRowTextTiles ; 91/DDD5

        ; Read by rsSaveMenuDrawRowTiles, rsSaveMenuRenderRowText, rsSaveMenuRenderSlotTitle.

        .word $0000, $0020, $0040, $0060, $0080, $00A0, $00C0, $00D0
        .word $00E0, $0100, $0140, $0180, $01C0, $0200

        ; 91/DDF1

    .endsection Table91DDD5Section


    .section Unsorted91DDF1Section

      .al
      .xl

      rsSaveMenuRenderRowText ; 91/DDF1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Renders the text of row type A into tiles: the command and heading texts (aSaveMenuRowTexts) or a slot's chapter and turn.

        pha
        jsr rsSaveMenuClearSlotTextTiles
        jsl rlResetDialogueEngine
        jsl rlDialogueFreeHDMA
        lda #$5000
        sta aDialogue._Slot[0].wVRAMAddress,b
        pla
        pha
        ldx #(`aSaveMenuRowTexts)<<8
        stx lR18+1
        and #$00FF
        cmp #$000B
        bcc _DE2D
        sbc #$000B
        pha
        lda #(`aSaveMenuEmptyText)<<8
        sta lR18+1
        lda #<>aSaveMenuEmptyText
        sta lR18
        pla
        jsl rlCheckSaveSlotEmpty
        bcs _DE35
        jsl rlBuildSaveSlotChapterString
        bra _DE35


        _DE2D
        asl a
        tax
        lda aSaveMenuRowTexts,x
        sta lR18

        _DE35
        pla
        dec a
        asl a
        tax
        lda aSaveMenuRowTextTiles,x
        tax
        lda #$9B88
        sta aDialogue._Slot[0].lBGBufferPosition,b
        ldy #$0000
        jsl rlStartTextToTiles
        rts

        .databank 0

        ; 91/DE4C

    .endsection Unsorted91DDF1Section


    .section Unsorted91DE4CSection

      .al
      .xl

      aSaveMenuEmptyText ; 91/DE4C

        .byte $01

      rsSaveMenuRenderSlotTitle ; 91/DE4D

        .al
        .xl
        .autsiz
        .databank ?

        ; Renders the chapter title of a slot row type (11-14) into tiles beside its chapter number.

        pha
        jsl rlResetDialogueEngine
        jsl rlDialogueFreeHDMA
        lda #$5000
        sta aDialogue._Slot[0].wVRAMAddress,b
        pla
        ldx #(`aSaveMenuRowTexts)<<8
        stx lR18+1
        and #$00FF
        cmp #$000B
        bcc _DE9E
        pha
        sbc #$000B
        pha
        lda #(`aSaveMenuEmptyTitleText)<<8
        sta lR18+1
        lda #<>aSaveMenuEmptyTitleText
        sta lR18
        pla
        jsl rlCheckSaveSlotEmpty
        bcs _DE84
        jsl rlGetSaveSlotChapterTitle

        _DE84
        pla
        dec a
        asl a
        tax
        lda aSaveMenuRowTextTiles,x
        clc
        adc #$0014
        tax
        lda #$9B88
        sta aDialogue._Slot[0].lBGBufferPosition,b
        ldy #$0000
        jsl rlStartTextToTiles

        _DE9E
        rts

        .databank 0

    .endsection Unsorted91DE4CSection


    .section Table91DE9FSection

      .al
      .xl

      aSaveMenuEmptyTitleText ; 91/DE9F
        .word $0100

    .endsection Table91DE9FSection


    .section Unsorted91DEA1Section

      .al
      .xl

      rsSaveMenuClearSlotTextTiles ; 91/DEA1

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        ldy #$0000
        lda #$0000

        _DEB2
        sta [lR18],y
        inc y
        cpy #$0400
        bne _DEB2
        pla
        cmp #$000E
        beq _DEFA
        cmp #$000D
        beq _DEEC
        cmp #$000C
        beq _DEDE
        cmp #$000B
        beq _DED0
        rts


        _DED0
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $0400, $80, $B400

        rts


        _DEDE
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $0400, $80, $B800

        rts


        _DEEC
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $0400, $80, $BC00

        rts


        _DEFA
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $0400, $80, $C000

        rts

        .databank 0

        ; 91/DF08

    .endsection Unsorted91DEA1Section


    .section Unreferenced91DF08Section

      .al
      .xl

      rsDrawSaveMenuRowTextUnused ; 91/DF08

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #(`aSaveMenuRowTexts)<<8
        stx lR18+1
        asl a
        tax
        lda aSaveMenuRowTexts,x
        sta lR18
        lda #$00D8
        clc
        adc #$8388
        sta $18D4,b
        ldx #$0004
        txa
        xba
        tay
        txa
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        tax
        jsl rlStartTextToTiles
        rts

        .databank 0

        ; 91/DF32

    .endsection Unreferenced91DF08Section
    .section Unsorted91DF32Section

      .al
      .xl

      rlStartTextToTiles ; 91/DF32

        .al
        .xl
        .autsiz
        .databank ?

        ; Starts the dialogue engine on the text at lR18 with no wait and no sound, rendering into tiles from tile X.

        stx aDialogue._Slot[0].wVRAMTileOffset,b
        sty aDialogue._Slot[0].wBGBufferOffset,b
        lda #$0000
        jsl rlDialogueStartText
        lda #$2000
        trb aDialogue.wStatus,b
        lda #$2000
        sta aDialogue.wBaseTile,b
        lda #$1E1E
        sta aDialogue._Slot[0].wDisplayArea,b
        lda #$FFFF
        sta aDialogue.wTextSpeed,b
        sta aDialogue.wPauseTimer,b
        lda #$000A
        sta aDialogue.wUnknown001892,b
        lda #$0200
        tsb aDialogue.wStatus,b
        lda #$0180
        tsb aDialogue.wStatus,b
        rtl

        .databank 0

        ; 91/DF6D

    .endsection Unsorted91DF32Section


    .section Unsorted91DF6DSection

      .al
      .xl

      rsSetSaveMenuScreenRegisters ; 91/DF6D

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$61
        sta bBufferOBSEL
        lda #$09
        sta bBufferBGMODE
        lda #$00
        sta bBufferMOSAIC
        lda #$3C
        sta bBufferBG1SC
        lda #$42
        sta bBufferBG2SC
        lda #$4A
        sta bBufferBG3SC
        lda #$4C
        sta bBufferBG4SC
        lda #$00
        sta bBufferBG12NBA
        lda #$55
        sta bBufferBG34NBA
        lda #$00
        sta wBufferBG1HOFS
        sta wBufferBG1HOFS+1
        lda #$00
        sta wBufferBG1VOFS
        sta wBufferBG1VOFS+1
        lda #$00
        sta wBufferBG2HOFS
        sta wBufferBG2HOFS+1
        lda #$20
        sta wBufferBG2VOFS
        lda #$00
        sta wBufferBG2VOFS+1
        lda #$06
        sta wBufferBG3HOFS
        lda #$00
        sta wBufferBG3HOFS+1
        lda #$00
        sta wBufferBG3VOFS
        sta wBufferBG3VOFS+1
        lda #$00
        sta wBufferBG4HOFS
        sta wBufferBG4HOFS+1
        lda #$00
        sta wBufferBG4VOFS
        sta wBufferBG4VOFS+1
        lda #$00
        sta bBufferW12SEL
        lda #$00
        sta bBufferW34SEL
        lda #$00
        sta bBufferWOBJSEL
        lda #$00
        sta bBufferWBGLOG
        lda #$00
        sta bBufferWOBJLOG
        lda #$16
        sta bBufferTM
        lda #$01
        sta bBufferTS
        lda #$07
        sta bBufferTMW
        lda #$04
        sta bBufferTSW
        lda #$02
        sta bBufferCGWSEL
        lda #$84
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        lda #$00
        sta bBufferSETINI
        plp
        rts

        .databank 0

        ; 91/E006

      rsFadeSaveBGPalette1ToWhiteUnused ; 91/E006

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: fades to white over 16 steps (rsStepFadeSaveBGPalette1Unused).

        lda #$7FFF
        sta aPaletteFading.wDesiredColor,b
        lda #$0010
        sta aPaletteFading.wMaxSteps,b
        clc
        jml rsStepFadeSaveBGPalette1Unused

        .databank 0

      rsFadeSaveBGPalette1ToBlackUnused ; 91/E017

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: fades to black over 16 steps (rsStepFadeSaveBGPalette1Unused).

        lda #$0000
        sta aPaletteFading.wDesiredColor,b
        lda #$0010
        sta aPaletteFading.wMaxSteps,b
        clc
        jml rsStepFadeSaveBGPalette1Unused

        .databank 0

      rsFadeSaveObjPalettesToWhiteUnused ; 91/E028

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: fades to white over 16 steps (rsStepFadeSaveObjPalettesUnused).

        lda #$7FFF
        sta aPaletteFading.wDesiredColor,b
        lda #$0010
        sta aPaletteFading.wMaxSteps,b
        clc
        jml rsStepFadeSaveObjPalettesUnused

        .databank 0

      rsFadeSaveObjPalettesToBlackUnused ; 91/E039

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: fades to black over 16 steps (rsStepFadeSaveObjPalettesUnused).

        lda #$0000
        sta aPaletteFading.wDesiredColor,b
        lda #$0010
        sta aPaletteFading.wMaxSteps,b
        clc
        jml rsStepFadeSaveObjPalettesUnused

        .databank 0

      rsFadeAllPalettesFromCopyUnused ; 91/E04A

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: fades 512 colours in from the copy at $7EAB88 over 22 steps.

        lda #$0016
        sta aPaletteFading.wMaxSteps,b
        clc
        jsl rlFadePaletteToColors

          .word $AB88
          .word $0200
          .word $0000

        rts

        .databank 0

      rsStepFadeSaveBGPalette1Unused ; 91/E05C

        .al
        .xl
        .autsiz
        .databank ?

        ; One fade step of BG palette 1's colours 1-15 (aUnknown91E063).

        jsl rlFadePaletteToBlack

          .word <>aUnknown91E063

        rts

        .databank 0

      aUnknown91E063 ; 91/E063

        .word $0022, 15
        .word $FFFF

      rsStepFadeSaveObjPalettesUnused ; 91/E069

        .al
        .xl
        .autsiz
        .databank ?

        ; One fade step of sprite palettes 0 and 1's colours 1-15 (aUnknown91E070).

        jsl rlFadePaletteToBlack

          .word <>aUnknown91E070

        rts

        .databank 0

      aUnknown91E070 ; 91/E070

        .word $0102, 15
        .word $0122, 15
        .word $FFFF

    .endsection Unsorted91DF6DSection


    .section Unsorted91E07ASection

      .al
      .xl

      rlCreateSaveMenuHDMA ; 91/E07A

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aSaveMenuHDMAInfo)<<8
        sta lR44+1
        lda #<>aSaveMenuHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rtl

        .databank 0

        ; 91/E089

    .endsection Unsorted91E07ASection


    .section Table91E089Section

      .al
      .xl

      aSaveMenuHDMAInfo .dstruct structHDMAIndirectEntryInfo, rlInitSaveMenuHDMA, rlSaveMenuHDMAStub, aUnknown91E09E, wDialogueBoxHDMAYPixelPosition, PPU_REG_BASE + $2D, $40, $85 ; 91/E089

    .endsection Table91E089Section


    .section Unsorted91E095Section

      .al
      .xl

      rlInitSaveMenuHDMA ; 91/E095

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta wDialogueBoxHDMAYPixelPosition
        rtl

        .databank 0

        ; 91/E09D

      rlSaveMenuHDMAStub ; 91/E09D

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 91/E09E

    .endsection Unsorted91E095Section


    .section Table91E09ESection

      .al
      .xl

      aUnknown91E09E ; 91/E09E
        HDMA_HALT

      aUnknown91E0A0 ; 91/E0A0
        .byte $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $C0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $C0, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $A0, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00

      aUnknown91E185 .dstruct structHDMADirectEntryInfo, rlInitSaveMenuHDMA, rlSaveMenuHDMAStub, aUnknown91E09E, aUnknown91E190, PPU_REG_BASE + $0F, $00 ; 91/E185

      aUnknown91E190 ; 91/E190
        .byte $C0, $06, $06, $06, $06, $05, $05, $05, $05, $04, $04, $04, $04, $04, $04, $03
        .byte $03, $03, $03, $03, $03, $02, $02, $02, $02, $02, $01, $01, $01, $01, $00, $00
        .byte $00, $00, $01, $01, $01, $01, $01, $01, $01, $01, $02, $02, $02, $02, $02, $03
        .byte $03, $03, $03, $04, $04, $04, $04, $05, $05, $05, $05, $05, $04, $04, $04, $03
        .byte $03, $C0, $03, $03, $02, $02, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00
        .byte $00, $01, $01, $01, $01, $01, $02, $02, $02, $02, $02, $02, $03, $03, $03, $03
        .byte $03, $04, $04, $04, $04, $05, $05, $05, $05, $05, $05, $06, $06, $06, $06, $06
        .byte $06, $07, $07, $07, $07, $07, $08, $08, $08, $08, $08, $07, $07, $07, $07, $07
        .byte $07, $06, $C0, $06, $06, $05, $05, $05, $05, $04, $04, $04, $04, $04, $03, $03
        .byte $03, $03, $02, $02, $02, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $01
        .byte $01, $01, $01, $02, $02, $02, $02, $02, $03, $03, $03, $03, $03, $04, $04, $04
        .byte $04, $04, $04, $04, $05, $05, $05, $05, $06, $06, $06, $06, $06, $07, $07, $07
        .byte $07, $07, $07, $A0, $08, $08, $08, $08, $08, $09, $09, $09, $09, $09, $08, $08
        .byte $08, $08, $08, $07, $07, $07, $06, $06, $06, $06, $05, $05, $05, $05, $04, $04
        .byte $04, $04, $03, $03, $00

    .endsection Table91E09ESection


    .section Unsorted91E275Section

      .al
      .xl

      rsSaveMenuMoveCommandCursor ; 91/E275

        .al
        .xl
        .autsiz
        .databank ?

        lda wSaveMenuCommandRow,b
        jsr rsMoveCursorUpDown
        sta wSaveMenuCommandRow,b
        rts

        .databank 0

        ; 91/E27F

      rsMoveCursorUpDown ; 91/E27F

        .al
        .xl
        .autsiz
        .databank ?

        pha
        tax
        lda wJoy1Repeated
        bit #$0400
        bne _E293
        bit #$0800
        beq _E29A
        txa
        beq _E29A
        dec x
        bra _E29A


        _E293
        inc x
        cpx wSaveMenuRowCount,b
        bcc _E29A
        dec x

        _E29A
        stx wR0
        pla
        cmp wR0
        beq _E2A8
        lda #$0006
        jsl rlPlaySoundEffect

        _E2A8
        txa
        rts

        .databank 0

        ; 91/E2AA

    .endsection Unsorted91E275Section


    .section Unsorted91E2AASection

      .al
      .xl

      rsSaveMenuMoveSlotCursor ; 91/E2AA

        .al
        .xl
        .autsiz
        .databank ?

        lda wSaveMenuSlotRow,b
        jsr rsMoveSlotCursorUpDown
        sta wSaveMenuSlotRow,b
        rts

        .databank 0

        ; 91/E2B4

      rsMoveSlotCursorUpDown ; 91/E2B4

        .al
        .xl
        .autsiz
        .databank ?

        pha
        tax
        lda wJoy1Repeated
        bit #$0400
        bne _E2CB
        bit #$0800
        beq _E2D2
        txa
        cpx #$0001
        beq _E2D2
        dec x
        bra _E2D2


        _E2CB
        inc x
        cpx wSaveMenuRowCount,b
        bcc _E2D2
        dec x

        _E2D2
        stx wR0
        pla
        cmp wR0
        beq _E2E0
        lda #$0006
        jsl rlPlaySoundEffect

        _E2E0
        txa
        rts

        .databank 0

        ; 91/E2E2

      rlSaveMenuDrawSprites ; 91/E2E2

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlSaveMenuDrawCursor
        jsl rlSaveMenuDrawConfirmSprites
        jsl rlSaveMenuDrawRowSprites
        rtl

        .databank 0

        ; 91/E2EF

      rlSaveMenuDrawRowSprites ; 91/E2EF

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        ldx #$0000

        _E2F5
        cpx wSaveMenuRowsDrawn,b
        bcc _E2FE
        jml _E389


        _E2FE
        stx wR7
        phx
        lda wSaveMenuSlotRow,b
        cmp #$FFFF
        beq _E31A
        cpx #$0000
        bne _E31A
        lda #$0068
        sta wR0
        lda #$0028
        sta wR1
        bra _E339


        _E31A
        txa
        asl a
        asl a
        pha
        lda wSaveMenuWindowPosition,b
        inc a
        and #$00FF
        asl a
        asl a
        asl a
        sta wR0
        pla
        clc
        adc wSaveMenuWindowPosition+1,b
        inc a
        inc a
        and #$00FF
        asl a
        asl a
        asl a
        sta wR1

        _E339
        lda #$0000
        cpx #$0000
        beq _E34A
        ldy wSaveMenuSlotRow,b
        cpy #$FFFF
        beq _E34A
        inc a

        _E34A
        pha
        sep #$20
        lda #$91
        pha
        plb
        .databank $91
        rep #$20
        pla
        asl a
        tax
        lda @l aSaveMenuRowSprites,x
        tay
        lda #$0000
        sta wR4
        lda #$2200
        sta wR5
        lda aSave.wMenuOperation,b
        bit #$8000
        bne _E384
        jsl rlGetAutoSaveOption
        and #$FFFF
        beq _E384
        jsl rlGetAutoSaveFile
        inc a
        cmp wR7
        bne _E384
        lda #$2400
        sta wR5

        _E384
        jsl rlPushToOAMBuffer
        plx

        _E389
        inc x
        cpx wSaveMenuRowCount,b
        bcs _E393
        jml _E2F5


        _E393
        ply
        plx
        plb
        .databank $91
        rtl

        .databank 0

        ; 91/E397

    .endsection Unsorted91E2AASection


    .section Table91E397Section

      .al
      .xl

      aSaveMenuRowSprites ; 91/E397

        ; Read by rlSaveMenuDrawRowSprites.

        .word $E3C0, $E39B, $0007, $C3E8, $00E8, $0831, $E8C2, $3102
        .word $C228, $02E8, $4831, $E8C2, $3102, $C268, $02E8, $8831
        .word $E8C2, $3102, $C298, $04E8, $0431, $E000, $E8C3, $3100
        .word $C200, $02E8, $2031, $E8C2, $3102, $C230, $04E8, $0931
        .word $0800, $0000, $3100, $0008, $1010, $0831, $2000, $3120
        .word $0018, $0200, $1831, $1000, $3112, $0018, $2220, $2831
        .word $0000, $3106, $0028, $1610, $2831, $2000, $3126

        ; 91/E405

    .endsection Table91E397Section


    .section Unsorted91E405Section

      .al
      .xl

      rlSaveMenuDrawConfirmSprites ; 91/E405

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        lda wSaveMenuConfirm,b
        beq _E444
        dec a
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$0020
        sta wR1
        lda #$00D0
        sta wR0
        jsl rlDrawSaveMenuHand
        sep #$20
        lda #$91
        pha
        plb
        .databank $91
        rep #$20
        ldy #$E3D6
        lda #$00B9
        sta wR0
        lda #$0018
        sta wR1
        lda #$0000
        sta wR4
        lda #$2200
        sta wR5
        jsl rlPushToOAMBuffer

        _E444
        ply
        plx
        plb
        .databank $91
        rtl

        .databank 0

        ; 91/E448

      rlSaveMenuDrawCursor ; 91/E448

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        asl a
        asl a
        pha
        lda wSaveMenuWindowPosition,b
        and #$00FF
        asl a
        asl a
        asl a
        sta wR0
        pla
        clc
        adc wSaveMenuWindowPosition+1,b
        and #$00FF
        asl a
        asl a
        asl a
        sta wR1
        jsl rlInitDialogueBoxHDMA
        jsl rlDrawSaveMenuHand
        ply
        plx
        plb
        .databank ?
        rtl

        .databank 0

        ; 91/E472

      rlDrawSaveMenuHand ; 91/E472

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        sep #$20
        lda #$91
        pha
        plb
        .databank $91
        rep #$20
        lda wVBlankEnabledFramecount
        and #$003F
        tax
        lda @l aSaveMenuHandFrames,x
        and #$00FF
        asl a
        tax
        lda @l aSaveMenuHandSprites,x
        tay
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        ply
        plx
        plb
        .databank $91
        rtl

        .databank 0

        ; 91/E4A3

      aUnknown91E4A3 ; 91/E4A3

        ; Unreferenced.

        .byte $00, $00, $00, $00, $01, $00, $01, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF

    .endsection Unsorted91E405Section


    .section Table91E4B3Section

      .al
      .xl

      aSaveMenuHandFrames ; 91/E4B3

        ; Read by rlDrawSaveMenuHand.

        .word $0000, $0000, $0000, $0101, $0101, $0101, $0202, $0202
        .word $0202, $0303, $0303, $0303, $0303, $0303, $0303, $0303
        .word $0303, $0303, $0303, $0303, $0303, $0303, $0303, $0303
        .word $0303, $0303, $0303, $0303, $0303, $0303, $0303, $0303

        ; 91/E4F3

    .endsection Table91E4B3Section


    .section Data91E4F3Section

      .al
      .xl

      aSaveMenuHandSprites ; 91/E4F3

        ; Read by rlDrawSaveMenuHand.

        .word $E4FB, $E507, $E513, $E51F, $0002, $01E8, $2200, $D830
        .word $0001, $3020, $0002, $01E8, $2400, $D830, $0001, $3020
        .word $0002, $01E8, $2600, $D830, $0001, $3020, $0002, $01E8
        .word $2800, $D830, $0001, $3020

        ; 91/E52B

    .endsection Data91E4F3Section


    .section Unsorted91E52BSection

      .al
      .xl

      rlResetEnginesForSaveMenu ; 91/E52B

        .al
        .xl
        .autsiz
        .databank ?

        php
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlEnableActiveSpriteEngine
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlResetEventAndSpriteState
        lda #$00FF
        sta wMapMenuTransparentTile,b
        lda #$00C0
        jsl rlQueueSoundCommand
        stz wEventEngineFlags,b
        plp
        rtl

        .databank 0

        ; 91/E55A

    .endsection Unsorted91E52BSection


    .section Unsorted91E55ASection

      .al
      .xl

      rlReturnToFileMenu ; 91/E55A

        .al
        .xl
        .autsiz
        .databank ?

        ; Opens the title file menu again (from step $14, which reloads the screen).

        jsl rlSetSaveMenuGameState
        lda #$0014
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 91/E565

      rlSetSaveMenuGameState ; 91/E565

        .al
        .xl
        .autsiz
        .databank ?

        lda #GAMESTATE_SAVE_MENU_UPKEEP
        sta wGameStateRoutine2,b
        lda #GAMESTATE_SAVE_MENU_SETUP
        sta wGameStateRoutine1,b
        lda #<>rsRunSaveMenuVBlank
        sta wVBlankPointer
        lda #<>rsRunSaveMenuMainLoop
        sta wMainLoopPointer
        stz aSave.wMenuOperation,b
        jsl rlFillSaveSlotDataBuffers
        rtl

        .databank 0

        ; 91/E583

    .endsection Unsorted91E55ASection


    .section Unsorted91E583Section

      .al
      .xl

      rsFileMenuReloadRegisters ; 91/E583

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsr rsSetSaveMenuScreenRegisters
        sep #$20
        lda #$02
        sta bBufferTM
        rep #$20
        lda #(`g4bppcSaveMenuWindowTiles)<<8
        sta lR18+1
        lda #<>g4bppcSaveMenuWindowTiles
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        inc wGameStateStep,b
        rts

        .databank 0

        ; 91/E5B2

      rsFileMenuReloadTiles ; 91/E5B2

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne _E5F3
        lda #$03FF
        jsl rlFillBG3Page0TilemapBuffer
        jsl rlDMAByStruct

          .structDMAToVRAM g2bppBlankTile, $0010, $80, $DFF0

        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $0800, $80, $6000

        lda #(`acSaveMenuBG2Tilemap)<<8
        sta lR18+1
        lda #<>acSaveMenuBG2Tilemap
        sta lR18
        lda #(`aBG2TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG2TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        inc wGameStateStep,b

        _E5F3
        rts

        .databank 0

        ; 91/E5F4

      rsFileMenuReloadBG2Tilemap ; 91/E5F4

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne _E621
        jsl rlDMAByStruct

          .structDMAToVRAM aBG2TilemapBuffer, $0800, $80, $7800

        lda #(`acSaveMenuBG1Tilemap)<<8
        sta lR18+1
        lda #<>acSaveMenuBG1Tilemap
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$7B88
        sta lR19
        jsl rlAppendDecompList
        inc wGameStateStep,b

        _E621
        rts

        .databank 0

        ; 91/E622

      rsFileMenuReloadBG3Tiles ; 91/E622

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne _E64F
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $8000

        lda #(`acSaveMenuPalettes)<<8
        sta lR18+1
        lda #<>acSaveMenuPalettes
        sta lR18
        lda #(`aBGPaletteBuffer)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer
        sta lR19
        jsl rlAppendDecompList
        inc wGameStateStep,b

        _E64F
        rts

        .databank 0

        ; 91/E650

      rsFileMenuRenderRowTexts ; 91/E650

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlResetDialogueEngine
        jsl rlDialogueFreeHDMA
        lda #$5000
        sta aDialogue._Slot[0].wVRAMAddress,b
        lda #$0001
        sta wSaveMenuRowsDrawn,b
        inc wGameStateStep,b

        _E667
        jsl rlRunDialogueCycle
        lda aDialogue.wStatus,b
        bne _E691
        lda aDialogue.wPendingTileBytes,b
        bne _E691
        lda wSaveMenuRowsDrawn,b
        inc wSaveMenuRowsDrawn,b
        cmp #$000E
        beq _E688
        lda wSaveMenuRowsDrawn,b
        jsr rsSaveMenuRenderRowText
        bra _E667


        _E688
        lda #$0001
        sta wSaveMenuRowsDrawn,b
        inc wGameStateStep,b

        _E691
        rts

        .databank 0

        ; 91/E692

      rsFileMenuRenderSlotTitles ; 91/E692

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlRunDialogueCycle
        lda aDialogue.wStatus,b
        bne _E6B9
        lda aDialogue.wPendingTileBytes,b
        bne _E6B9
        lda wSaveMenuRowsDrawn,b
        inc wSaveMenuRowsDrawn,b
        cmp #$000E
        beq _E6B3
        lda wSaveMenuRowsDrawn,b
        jsr rsSaveMenuRenderSlotTitle
        bra rsFileMenuRenderSlotTitles


        _E6B3
        jsr rsSaveMenuUploadBG3Tilemap
        inc wGameStateStep,b

        _E6B9
        rts

        .databank 0

        ; 91/E6BA

      rsFileMenuReloadDone ; 91/E6BA

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlResetHDMAEngine
        jsl rlCreateSaveMenuHDMA
        lda #$0000
        sta wSaveMenuCommandRow,b
        lda #$FFFF
        sta wSaveMenuSlotRow,b
        stz wSaveMenuConfirm,b
        lda #$0000
        sta wGameStateStep,b
        rts

        .databank 0

        ; 91/E6D8

    .endsection Unsorted91E583Section


    .section Unsorted91E92ESection

      .al
      .xl

      rlFillSaveSlotDataBuffers ; 91/E92E

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsFillSaveSlotDataBuffers
        rtl

        .databank 0

        ; 91/E932

    .endsection Unsorted91E92ESection


    .section Unsorted91E932Section

      .al
      .xl

      rlCheckSaveSlotEmpty ; 91/E932

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if save slot A (0-3) holds no valid save (its data word in aSave.aSlotDataBuffer is 0).

        pha
        asl a
        tay
        lda $1B11,b,y
        beq _E93D
        clc
        bra _E93E


        _E93D
        sec

        _E93E
        pla
        rtl

        .databank 0

        ; 91/E940

    .endsection Unsorted91E932Section


    .section Unsorted91E940Section

      .al
      .xl

      rlCountUsedSaveSlots ; 91/E940

        .al
        .xl
        .autsiz
        .databank ?

        phy
        ldy #$0000
        lda $1B11,b
        beq _E94A
        inc y

        _E94A
        lda $1B13,b
        beq _E950
        inc y

        _E950
        lda $1B15,b
        beq _E956
        inc y

        _E956
        lda $1B17,b
        beq _E95C
        inc y

        _E95C
        tya
        ply
        rtl

        .databank 0

        ; 91/E95F

    .endsection Unsorted91E940Section


