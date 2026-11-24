; The main map menu (no unit chosen): unit, item, data and skill windows, config,
; save, turn end; the save prompt.

    .section SavePromptDataSection

      .al
      .xl

      aSavePromptTilemapData ; 85/A46A

        .structMapMenuTilemapData 13, 6, aBG3TilemapBuffer, 0, $7FC54A

      aSavePromptData ; 85/A473

        .long 0, 0, aSavePromptTilemapData
        .byte 0, 9, 11

    .endsection SavePromptDataSection


    .section ProcScript85A47FSection

      .al
      .xl

      procSavePrompt ; 85/A47F

        .structProcInfo "PW", rlProcSavePromptInit, rlProcSavePromptWait, aProcSavePromptCode


        .long aSavePromptData
        .byte 1

    .endsection ProcScript85A47FSection


    .section Unsorted85A48BSection

      .al
      .xl

      rlProcSavePromptInit ; 85/A48B

        .al
        .xl
        .autsiz
        .databank ?

        ; "Save?" with yes and no; wInput0 = mode (aBody6): 0 opens the save menu, else saves at once (auto-save).

        jsl rlInitMapMenuProc
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody6,b,x
        lda #$0000
        sta aProcSystem.aBody7,b,x
        phx
        lda #(`aSavePromptText)<<8
        sta lR18+1
        lda #<>aSavePromptText
        sta lR18
        ldx #$0102
        jsl rlDrawMapMenuTextLine
        lda #(`aSavePromptYesText)<<8
        sta lR18+1
        lda #<>aSavePromptYesText
        sta lR18
        ldx #$0303
        jsl rlDrawMapMenuTextLine
        lda #(`aSavePromptNoText)<<8
        sta lR18+1
        lda #<>aSavePromptNoText
        sta lR18
        ldx #$0308
        jsl rlDrawMapMenuTextLine
        plx
        jsl rlDrawMapMenu
        jsl rlHideMapWindows
        lda #$0009
        jsl rlPlaySoundEffect
        rtl

        .databank 0

        ; 85/A4E6

    .endsection Unsorted85A48BSection


    .section Table85A4E6Section

      .al
      .xl

      aSavePromptText ; 85/A4E6

        .enc "SJIS"
        .text "セーブ　しますか？"
        .word $0000
        .enc "none"

      aSavePromptYesText ; 85/A4FA

        .enc "SJIS"
        .text "はい"
        .word $0000
        .enc "none"

      aSavePromptNoText ; 85/A500

        .enc "SJIS"
        .text "いいえ"
        .word $0000
        .enc "none"


    .endsection Table85A4E6Section


    .section Unsorted85A508Section

      .al
      .xl

      rlProcSavePromptWait ; 85/A508

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/A509

    .endsection Unsorted85A508Section


    .section Unsorted85A509Section

      .al
      .xl

      rlProcSavePromptCycle ; 85/A509

        .al
        .xl
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #$00FF
        cmp #$000F
        bne _A56C
        lda wJoy1New
        bit #$0300
        beq _A539
        lda #$0007
        jsl rlPlaySoundEffect
        lda aProcSystem.aBody7,b,x
        bit #$0001
        bne _A531
        ora #$0001
        sta aProcSystem.aBody7,b,x
        bra _A54C


        _A531
        eor #$0001
        sta aProcSystem.aBody7,b,x
        bra _A54C


        _A539
        jsr rsSavePromptHandleA
        bcc _A54C
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        jsl rlShowMapWindows
        bra _A56C


        _A54C
        lda aProcSystem.aBody7,b,x
        bit #$0001
        bne _A559
        lda #$0002
        bra _A55C


        _A559
        lda #$0007

        _A55C
        ora #$0400
        sta wR0
        lda #$0000
        sta wR1
        phx
        jsl rlDrawListCursorAtIndex
        plx

        _A56C
        rtl

        .databank 0

        ; 85/A56D

      rsSavePromptHandleA ; 85/A56D

        .al
        .xl
        .autsiz
        .databank ?

        ; Mode 0: yes opens the save menu, no runs rlAdvanceToNextChapter. Other modes: yes saves (rlGetAutoSaveFile, rlSaveToSaveSlot). Carry set when done.

        lda aProcSystem.aBody6,b,x
        bne _A595
        lda wJoy1New
        bit #$0080
        beq _A591
        lda #$000A
        jsl rlPlaySoundEffect
        lda aProcSystem.aBody7,b,x
        bne _A58B
        jsl rlMapMenuOpenSave
        bra _A593


        _A58B
        jsl rlAdvanceToNextChapter
        bra _A593


        _A591
        clc
        rts


        _A593
        sec
        rts


        _A595
        lda wJoy1New
        bit #$0080
        beq _A5B9
        lda #$000A
        jsl rlPlaySoundEffect
        lda aProcSystem.aBody7,b,x
        bne _A5BB
        lda #$000E
        jsl rlPlaySoundEffect
        jsl rlGetAutoSaveFile
        jsl rlSaveToSaveSlot
        bra _A5BB


        _A5B9
        clc
        rts


        _A5BB
        sec
        rts

        .databank 0

        ; 85/A5BD

    .endsection Unsorted85A509Section


    .section ProcScript85A5BDSection

      .al
      .xl

      aProcSavePromptCode ; 85/A5BD

        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcSavePromptCycle
        PROC_HALT


        ; 85/A5C5

    .endsection ProcScript85A5BDSection


    .section Unsorted85A5C5Section

      .al
      .xl

      rlOpenSavePrompt ; 85/A5C5

        .al
        .xl
        .autsiz
        .databank ?

        ; Mode 0.

        lda #$0000
        sta aProcSystem.wInput0,b
        lda #(`procSavePrompt)<<8
        sta lR44+1
        lda #<>procSavePrompt
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/A5DA

    .endsection Unsorted85A5C5Section


    .section Unsorted85DBDDSection

      .al
      .xl

      rlMapMenuOpenUnitWindow ; 85/DBDD

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Map menu option ユニット (Unit): installs rsUnitWindowOpen as the main loop routine, with $7F82C5 set to return through rsReturnToMapMainLoop.

        stz wGameStateRoutine1,b
        lda #<>rsReturnToMapMainLoop
        sta wUnitWindowCaller
        lda #<>rsUnitWindowOpen
        sta wMainLoopPointer
        rtl

        .databank 0

        ; 85/DBED

      rlMapMenuOpenItemWindow ; 85/DBED

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Map menu option アイテム (Item): installs rsItemWindowOpen as the main loop routine.

        stz wGameStateRoutine1,b
        lda #<>rsItemWindowOpen
        sta wMainLoopPointer
        rtl

        .databank 0

        ; 85/DBF6

      rlMapMenuOpenDataWindow ; 85/DBF6

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Map menu option データ (Data): fades into rsDataWindowOpen (procMainLoopChangeFade, the routine in aProcSystem.wInput0).

        stz wGameStateRoutine1,b
        lda #<>rsDataWindowOpen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DC0E

      rlMapMenuOpenSkillWindow ; 85/DC0E

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Map menu option スキル (Skill): fades into rsSkillWindowOpen (procMainLoopChangeFade, the routine in aProcSystem.wInput0).

        stz wGameStateRoutine1,b
        lda #<>rsSkillWindowOpen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DC26

    .endsection Unsorted85DBDDSection


    .section Unsorted85DC26Section

      .al
      .xl

      rlMapMenuTurnEnd ; 85/DC26

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bit 5 of wMapStateFlags and saves the cursor's tile; in the castle mode (bit 5 of wChapterFlags) fades to rsReturnToMapMainLoop.

        lda #$0020
        tsb wMapStateFlags,b
        jsl rlHideMapWindows
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sep #$20
        sta bSavedPlayerCursorXTile,b
        rep #$20
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sep #$20
        sta bSavedPlayerCursorYTile,b
        rep #$20
        lda wChapterFlags,b
        bit #$0020
        beq _DC79
        lda #$0000
        sta wMainGameMode,b
        stz wGameStateRoutine1,b
        lda #<>rsReturnToMapMainLoop
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc

        _DC79
        rtl

        .databank 0

        ; 85/DC7A

      rlMapMenuLoad ; 85/DC7A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Reloads the saved chapter: rlMapMenuLoadHook with 1, then fades to rsStartChapterMap.

        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda #$0001
        jsl rlMapMenuLoadHook
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
        rtl

        .databank 0

        ; 85/DCAB

    .endsection Unsorted85DC26Section


    .section Unsorted85DCABSection

      .al
      .xl

      rlMapMenuOpenSave ; 85/DCAB

        .al
        .xl
        .autsiz
        .databank ?

        lda #$00E0
        jsl rlSendSoundCommand
        stz wGameStateRoutine1,b
        lda #<>rsOpenMapSaveMenu
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DCCA

    .endsection Unsorted85DCABSection


    .section Unsorted85DCCASection

      .al
      .xl

      rlMapMenuOpenConfig ; 85/DCCA

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        stz wGameStateRoutine1,b
        lda #<>rsOpenOptionsMenu
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DCE2


      aMainMapMenuTilemapData ; 85/DCE2

        .structMapMenuTilemapData 9, 16, aBG3TilemapBuffer, 0, $7FCD4A

      aMainMapMenuData ; 85/DCEB

        .long 0, 0, aMainMapMenuTilemapData
        .byte 2, 4, 6

      aMainMapMenuNoSaveTilemapData ; 85/DCF7

        .structMapMenuTilemapData 9, 14, aBG3TilemapBuffer, 0, $7FCD4A

      aMainMapMenuNoSaveData ; 85/DD00

        .long 0, 0, aMainMapMenuNoSaveTilemapData
        .byte 2, 4, 6

      aMapMenuOptionUnit ; 85/DD0C

        .long rlMapMenuOpenUnitWindow
        .word $0101
        .enc "SJIS"
        .text "　ユニット\n"
        .enc "none"

      aMapMenuOptionItem ; 85/DD1D

        .long rlMapMenuOpenItemWindow
        .word $0101
        .enc "SJIS"
        .text "　アイテム\n"
        .enc "none"

      aMapMenuOptionData ; 85/DD2E

        .long rlMapMenuOpenDataWindow
        .word $0101
        .enc "SJIS"
        .text "　データ\n"
        .enc "none"

      aMapMenuOptionSkill ; 85/DD3D

        .long rlMapMenuOpenSkillWindow
        .word $0101
        .enc "SJIS"
        .text "　スキル\n"
        .enc "none"

      aMapMenuOptionConfig ; 85/DD4C

        .long rlMapMenuOpenConfig
        .word $0101
        .enc "SJIS"
        .text "　コンフィグ\n"
        .enc "none"

      aMapMenuOptionLoad ; 85/DD5F

        .long rlMapMenuLoad
        .word $0101
        .enc "SJIS"
        .text "　ロード\n"
        .enc "none"

      aMapMenuOptionSave ; 85/DD6E

        .long rlMapMenuOpenSave
        .word $0101
        .enc "SJIS"
        .text "　セーブ\n"
        .enc "none"

      aMapMenuOptionTurnEnd ; 85/DD7D

        .long rlMapMenuTurnEnd
        .word $0101
        .enc "SJIS"
        .text "　ターンエンド\n"
        .enc "none"

      aMapMenuOptionList ; 85/DD92

        .word 0
        .byte 7, 7
        .byte 1, 1
        .long aMapMenuOptionUnit
        .byte 1, 3
        .long aMapMenuOptionItem
        .byte 1, 5
        .long aMapMenuOptionData
        .byte 1, 7
        .long aMapMenuOptionSkill
        .byte 1, 9
        .long aMapMenuOptionConfig
        .byte 1, 11
        .long aMapMenuOptionSave
        .byte 1, 13
        .long aMapMenuOptionTurnEnd

      aMapMenuOptionListNoSave ; 85/DDB9

        .word 0
        .byte 6, 6
        .byte 1, 1
        .long aMapMenuOptionUnit
        .byte 1, 3
        .long aMapMenuOptionItem
        .byte 1, 5
        .long aMapMenuOptionData
        .byte 1, 7
        .long aMapMenuOptionSkill
        .byte 1, 9
        .long aMapMenuOptionConfig
        .byte 1, 11
        .long aMapMenuOptionTurnEnd

    .endsection Unsorted85DCCASection


    .section ProcScript85DDDBSection

      .al
      .xl

      procMainMapMenu ; 85/DDDB

        .structProcInfo "PM", rlProcMainMapMenuInit, rlProcMainMapMenuSetUp, aProcListMenuCode


        .long aMainMapMenuData
        .byte 1
        .long aMapMenuOptionList

      procMainMapMenuNoSave ; 85/DDEA

        .structProcInfo "PM", rlProcMainMapMenuInit, rlProcMainMapMenuSetUp, aProcListMenuCode
        .long aMainMapMenuNoSaveData
        .byte 1
        .long aMapMenuOptionListNoSave

    .endsection ProcScript85DDDBSection


    .section Unsorted85DDF9Section

      .al
      .xl

      rlProcMainMapMenuInit ; 85/DDF9

        .al
        .xl
        .autsiz
        .databank ?

        ; Switches to procMainMapMenuNoSave (no Save option) once a unit has acted this turn (bit 12 of wChapterFlags).

        lda wChapterFlags,b
        bit #$1000
        beq _DE07
        lda #<>procMainMapMenuNoSave
        sta aProcSystem.aHeaderTypeOffset,b,x

        _DE07
        jsl rlListMenuProcInit
        lda #$0000
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        rtl

        .databank 0

        ; 85/DE13

      rlProcMainMapMenuSetUp ; 85/DE13

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aBGPaletteBuffer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$20FF
        sta wMapMenuClearTile,b
        jsl rlListMenuProcSetUp
        jsl rlKeepUnitMenuAwayFromCursor
        lda #<>rlMainMapMenuProcCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/DE34

    .endsection Unsorted85DDF9Section


    .section Unsorted85DE34Section

      .al
      .xl

      rlMainMapMenuProcCycle ; 85/DE34

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs rlListMenuProcHandleInput only while the menu is on top, so the hand is not drawn under another menu.

        jsl rlCheckListMenuIdle
        beq _DE3E
        jml _DE42


        _DE3E
        jsl rlListMenuProcHandleInput

        _DE42
        rtl

        .databank 0

        ; 85/DE43

      rlUnitMenuWait ; 85/DE43

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #MAP_ACTION_BATTLE
        sta wMapActionTargetType,b
        jsl rlEndUnitAction
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown84CAA9
        plx
        rtl

        .databank 0

        ; 85/DE57

      rlUnitMenuAttack ; 85/DE57

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Opens the item list (procMapItemList) on the weapons that can attack ($7E2000).

        ldx wActiveUnitDeploymentOffset,b
        lda #MAP_ACTION_BATTLE
        sta wMapActionTargetType,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta aProcSystem.wInput0,b
        lda #$2000
        sta aProcSystem.wInput1,b
        lda #(`procMapItemList)<<8
        sta lR44+1
        lda #<>procMapItemList
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DE7C

    .endsection Unsorted85DE34Section


    .section Unsorted87CBC5Section

      .al
      .xl

      rlMapMenuLoadHook ; 87/CBC5

        .al
        .xl
        .autsiz
        .databank ?

        ; Does nothing (rtl); rlMapMenuLoad calls it with A = 1.

        rtl

        .databank 0

        ; 87/CBC6

    .endsection Unsorted87CBC5Section


