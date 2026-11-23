; Procs that event scripts start: map and world map scrolling, timed fades, pauses
; and halts.

    .section EventScrollFadeProcSection

      .al
      .xl

      procMapScroll ; 82/8F3F

        .structProcInfo "M2", rlProcMapScrollInit, rlProcMapScrollCycle, aProcMapScrollCode
        .word 0

      rlProcMapScrollInit ; 82/8F49

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        stz wMapCurrentlyScrollingFlag,b
        stz wMapScrollScriptOffset,b
        plp
        rtl

        .databank 0

      rlProcMapScrollCycle ; 82/8F54

        .al
        .autsiz
        .databank ?

        php
        phb
        lda wGameStateRoutine1,b
        cmp #GAMESTATE_MAP_STEP
        beq +

          cmp #GAMESTATE_WORLD_MAP_STEP
          bne _End

        +
        jsl rlUnknown819166
        bcc _End

          lda wChapterFlags,b
          bit #$8000
          bne +

            phx
            jsl rlCheckPointInScreenMargins
            plx
            bcc +

              lda #$0080
              sta wCursorXOffset,b
              sta wCursorYOffset,b

          +
          jsl rlEventEngineFreeProc

        _End
        plb
        plp
        rtl

        .databank 0

      aProcMapScrollCode ; 82/8F89

        PROC_HALT

      procWorldMapScroll ; 82/8F8B

        .structProcInfo "MS", rlProcWorldMapScrollInit, rlProcWorldMapScrollCycle, aProcWorldMapScrollCode

      .word 0

      rlProcWorldMapScrollInit ; 82/8F95
      
        .al
        .autsiz
        .databank ?

        php
        rep #$30
        lda #0
        sta aProcSystem.aBody2,b,x

        ldy wActiveEventOffset,b
        lda [lR22],y
        sta aProcSystem.aBody0,b,x
        inc y
        inc y
        lda [lR22],y
        sta aProcSystem.aBody1,b,x

        plp
        rtl

        .databank 0

      rlProcWorldMapScrollCycle ; 82/8FAF
      
        .al
        .autsiz
        .databank ?

        php
        phb
        lda #0
        sta aProcSystem.aBody2,b,x
        sta aProcSystem.aBody3,b,x

        lda #1
        sta wMapScrollSpeed,b

        lda aProcSystem.aBody0,b,x
        cmp wMapScrollXPixels,b
        beq _CheckYMatch
        bcs _SetScrollRight

            lda #1
            sta aProcSystem.aBody2,b,x
            bra _CheckYMatch

          _SetScrollRight
          lda #-1
          sta aProcSystem.aBody2,b,x
          bra _CheckYMatch

        _CheckYMatch
        lda aProcSystem.aBody1,b,x
        cmp wMapScrollYPixels,b
        beq _CheckXScroll
        bcs _SetScrollDown

            lda #1
            sta aProcSystem.aBody3,b,x
            bra _CheckXScroll

          _SetScrollDown
          lda #-1
          sta aProcSystem.aBody3,b,x
          bra _CheckXScroll

        _CheckXScroll
        lda aProcSystem.aBody2,b,x
        bne _ScrollX

        ; No need to scroll X
        lda aProcSystem.aBody3,b,x
        beq _FinishedScrolling
        bra _ScrollY

        _ScrollX
        bpl _ScrollLeft
        bra _ScrollRight
        
        _ScrollY
        bpl _ScrollUp
        bra _ScrollDown

        _ScrollLeft
        lda aProcSystem.aBody3,b,x
        beq _ScrollJustLeft
        bpl _ScrollLeftUp
        bra _ScrollLeftDown

        _ScrollJustLeft
        jsl rlStartMapScrollLeft
        bra _End

        _ScrollLeftUp
        jsl rlStartMapScrollUpLeft
        bra _End

        _ScrollLeftDown
        jsl rlStartMapScrollDownLeft
        bra _End

        _ScrollRight
        lda aProcSystem.aBody3,b,x
        beq _ScrollJustRight
        bpl _ScrollRightUp
        bra _ScrollRightDown

        _ScrollJustRight
        jsl rlStartMapScrollRight
        bra _End

        _ScrollRightUp
        jsl rlStartMapScrollUpRight
        bra _End

        _ScrollRightDown
        jsl rlStartMapScrollDownRight
        bra _End

        _ScrollUp
        jsl rlStartMapScrollUp
        bra _End

        _ScrollDown
        jsl rlStartMapScrollDown
        bra _End

        _FinishedScrolling
        jsl rlEventEngineFreeProc
        
        _End
        plb
        plp
        rtl

        .databank 0

      aProcWorldMapScrollCode ; 82/9051

        PROC_HALT

      procEventFadeInByTimer ; 82/9053

        .structProcInfo "EI", rlProcEventFadeInByTimerInit, rlProcEventFadeInByTimerCycle, aProcEventFadeInByTimerCode

        .word 0

      rlProcEventFadeInByTimerInit ; 82/905D

        .al
        .autsiz
        .databank ?

        php
        rep #$20
        ldy wActiveEventOffset,b
        lda [lR22],y
        and #$00FF
        sta aProcSystem.aBody0,b,x
        plp
        rtl

        .databank 0

      rlProcEventFadeInByTimerCycle ; 82/906D

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        jsl rlFadeInByTimer
        bcc +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcEventFadeInByTimerCode ; 82/907B

        PROC_HALT

      procEventFadeOutByTimer ; 82/907D

        .structProcInfo "EO", rlProcEventFadeOutByTimerInit, rlProcEventFadeOutByTimerCycle, aProcEventFadeOutByTimerCode
        .word 0

      rlProcEventFadeOutByTimerInit ; 82/9087

        .al
        .autsiz
        .databank ?

        php
        rep #$20
        ldy wActiveEventOffset,b
        lda [lR22],y
        and #$00FF
        sta aProcSystem.aBody0,b,x
        plp
        rtl

        .databank 0

      rlProcEventFadeOutByTimerCycle ; 82/9097

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        jsl rlFadeOutByTimer
        bcc +

          sep #$20
          lda bBufferINIDISP
          sta INIDISP,b
          rep #$20

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcEventFadeOutByTimerCode ; 82/90AE

        PROC_HALT

        ; 82/90B0

      procUnknown8290B0 ; 82/90B0

        ; Unreferenced: nothing creates this event proc.

        .structProcInfo "B3", rlProcUnknown8290B0Init, rlProcUnknown8290B0Cycle, aProcUnknown8290B0Code

        .word $0010

      rlProcUnknown8290B0Init ; 82/90BA

        .al
        .xl
        .autsiz
        .databank ?

        lda lActiveEventPointer+1,b
        sta lR18+1
        lda lActiveEventPointer,b
        sta lR18
        ldx aProcSystem.wOffset,b
        ldy wActiveEventOffset,b
        lda [lR18],y
        sta aProcSystem.aBody0,b,x
        inc y
        inc y
        lda [lR18],y
        sta aProcSystem.aBody1,b,x
        inc y
        inc y
        lda [lR18],y
        sta aProcSystem.aBody4,b,x
        inc y
        inc y
        lda [lR18],y
        sta aProcSystem.aBody5,b,x
        lda wBufferBG3HOFS
        sta aProcSystem.aBody3,b,x
        stz aProcSystem.aBody2,b,x
        lda wBufferBG3VOFS
        sta aProcSystem.aBody7,b,x
        stz aProcSystem.aBody6,b,x
        rtl

        .databank 0

        ; 82/90F5

      rlProcUnknown8290B0Cycle ; 82/90F5

        .al
        .xl
        .autsiz
        .databank ?

        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody0,b,x
        clc
        adc aProcSystem.aBody4,b,x
        bne _9106
        jsl rlEventEngineFreeProc
        rtl


        _9106
        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody0,b,x
        beq _914D
        lda aProcSystem.aBody1,b,x
        bmi _914F
        lda $0FF6,b,x
        and #$FF00
        clc
        adc aProcSystem.aBody2,b,x
        sta aProcSystem.aBody2,b,x
        bcc _9128
        inc aProcSystem.aBody3,b,x
        dec aProcSystem.aBody0,b,x

        _9128
        lda $0FF8,b,x
        and #$007F
        clc
        adc aProcSystem.aBody3,b,x
        sta aProcSystem.aBody3,b,x
        sta wBufferBG3HOFS
        lda $0FF8,b,x
        and #$007F
        sta wR0,x
        lda aProcSystem.aBody0,b,x
        sec
        sbc wR0,x
        bcs _914A
        lda #$0000

        _914A
        sta aProcSystem.aBody0,b,x

        _914D
        bra _9191


        _914F
        lda $0FF6,b,x
        and #$FF00
        sta wR0,x
        lda aProcSystem.aBody2,b,x
        sec
        sbc wR0,x
        sta aProcSystem.aBody2,b,x
        bcs _9168
        dec aProcSystem.aBody3,b,x
        dec aProcSystem.aBody0,b,x

        _9168
        lda $0FF8,b,x
        and #$007F
        sta wR0,x
        lda aProcSystem.aBody3,b,x
        sec
        sbc wR0,x
        sta aProcSystem.aBody3,b,x
        sta wBufferBG3HOFS
        lda $0FF8,b,x
        and #$007F
        sta wR0,x
        lda aProcSystem.aBody0,b,x
        sec
        sbc wR0,x
        bcs _918E
        lda #$0000

        _918E
        sta aProcSystem.aBody0,b,x

        _9191
        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody4,b,x
        beq _91D8
        lda aProcSystem.aBody5,b,x
        bmi _91D9
        lda $1076,b,x
        and #$FF00
        clc
        adc aProcSystem.aBody6,b,x
        sta aProcSystem.aBody6,b,x
        bcc _91B3
        inc aProcSystem.aBody7,b,x
        dec aProcSystem.aBody4,b,x

        _91B3
        lda $1078,b,x
        and #$007F
        clc
        adc aProcSystem.aBody7,b,x
        sta aProcSystem.aBody7,b,x
        sta wBufferBG3VOFS
        lda $1078,b,x
        and #$007F
        sta wR0,x
        lda aProcSystem.aBody4,b,x
        sec
        sbc wR0,x
        bcs _91D5
        lda #$0000

        _91D5
        sta aProcSystem.aBody4,b,x

        _91D8
        rtl


        _91D9
        lda $1076,b,x
        and #$FF00
        sta wR0,x
        lda aProcSystem.aBody6,b,x
        sec
        sbc wR0,x
        sta aProcSystem.aBody6,b,x
        bcs _91F2
        dec aProcSystem.aBody7,b,x
        dec aProcSystem.aBody4,b,x

        _91F2
        lda $1078,b,x
        and #$007F
        sta wR0,x
        lda aProcSystem.aBody7,b,x
        sec
        sbc wR0,x
        sta aProcSystem.aBody7,b,x
        sta wBufferBG3VOFS
        lda $1078,b,x
        and #$007F
        sta wR0,x
        lda aProcSystem.aBody4,b,x
        sec
        sbc wR0,x
        bcs _9218
        lda #$0000

        _9218
        sta aProcSystem.aBody4,b,x
        rtl

        .databank 0

        ; 82/921C

      aProcUnknown8290B0Code ; 82/921C

        PROC_HALT

    .endsection EventScrollFadeProcSection


    .section EventPauseProcSection

      .al
      .xl

      procEventPause ; 82/921E

        .structProcInfo "e0", rlProcEventPauseInit, rlProcEventPauseCycle, aProcEventPauseCode
        .word 2

      rlProcEventPauseInit ; 82/9228

        .al
        .autsiz
        .databank ?

        ldy wActiveEventOffset,b
        lda [lR22],y
        cmp #2
        bcs +

          lda #2

        +
        sta aProcSystem.aBody0,b,x
        rtl

        .databank 0

      rlProcEventPauseCycle ; 82/9239

        .al
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcEventPauseCode ; 82/9243

        PROC_HALT

      ; 82/9245

    .endsection EventPauseProcSection


    .section EventHaltProcSection

      .al
      .xl

      rlCreateProcHaltEvent ; 82/9478

        .al
        .autsiz
        .databank ?

        ; Halt until $0002 of $7F4C07 is set

        lda #(`procUnknown828B2B)<<8
        sta lR44+1
        lda #<>procUnknown828B2B
        sta lR44
        jsl rlEventEngineCreateProc
        rtl

        .databank 0

        ; 82/9487

    .endsection EventHaltProcSection


    .section Unsorted819166Section

      .al
      .xl

      rlUnknown819166 ; 81/9166

        .al
        .autsiz
        .databank ?

        lda wMapCurrentlyScrollingFlag,b
        bne +

          stz wMapPixelScrollDistance,b
          jsr rsGetMapPixelScrollDistance
          bcs _End

            lda wEventMapScrollSpeed,b
            sta wMapScrollSpeed,b
            stz wMapScrollCurrentPixelDistance,b

            lda #1
            sta wMapCurrentlyScrollingFlag,b

            stz wMapScrollingFlag,b
            stz wMapEnableXScrollFlag,b
            stz wMapEnableYScrollFlag,b

        +
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp wMapPixelScrollDistance,b
        bcc +

          ; Scrolled up to the wanted pixel distance, clear scrolling flags.
          sec
          sbc wMapPixelScrollDistance,b
          sta wR0

          lda wMapScrollSpeed,b
          sec
          sbc wR0
          sta wMapScrollSpeed,b

          stz wMapCurrentlyScrollingFlag,b
          stz wMapScrollingFlag,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b

        +
        lda wMapScrollDirectionIdentifier,b
        jsl rlUnknown819305
        clc

        _End
        rtl

        .databank 0

    .endsection Unsorted819166Section


    .section Unsorted828B2BSection

      .as
      .xl

      procUnknown828B2B .structProcInfo "ME", rlProcHaltEventInit, rlProcHaltEventCycle, aProcHaltEventCode ; 82/8B2B

        .word 0

    .endsection Unsorted828B2BSection


    .section Unsorted82886FSection

      .al
      .xl

      rlProcDemoSkipFadeOutInit ; 82/886F

        .al
        .xl
        .autsiz
        .databank ?

        ; Mark procDemoSkipFadeOut non-blocking ($0200) in wEventProcBanks

        lda #$0200
        sta wEventProcBanks,b,x
        rtl

        .databank 0

        ; 82/8876

      rlProcDemoSkipFadeOutCycle1 ; 82/8876

        .al
        .xl
        .autsiz
        .databank ?

        ; Wait for wEventEngineFlags == 0 or Start press, play SFX $0A, fade music, switch on-cycle

        lda #$0200
        sta wEventProcBanks,b,x
        lda wEventEngineFlags,b
        beq _8888
        lda wJoy1New
        bit #$1000
        beq _88B1

        _8888
        stz wGameStateRoutine1,b
        lda #<>rlProcDemoSkipFadeOutCycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        lda bSoundFlags,b
        pha
        and #$FFFA
        sta bSoundFlags,b
        lda #$000A
        jsl rlPlaySoundEffect
        pla
        sta bSoundFlags,b
        jsl rlClearAllFadeInProcs
        lda #$00E1
        jsl rlSendSoundCommand

        _88B1
        rtl

        .databank 0

        ; 82/88B2

    .endsection Unsorted82886FSection


    .section Unsorted8288B2Section

      .al
      .xl

      rlProcDemoSkipFadeOutCycle2 ; 82/88B2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Fade bBufferINIDISP down to 0, clear event proc/flags, set main loop rsOpenTitleScreenWithoutIntro, disable IRQ

        lda bBufferINIDISP
        bit #$000F
        beq _88BE
        dec a
        sta bBufferINIDISP
        bra _88E6


        _88BE
        jsl rlEventEngineFreeProc
        lda #$0002
        sta wEventEngineState,b
        lda bSoundFlags,b
        and #$FFFA
        sta bSoundFlags,b
        lda #<>rsOpenTitleScreenWithoutIntro
        jsl rlSetMainLoopPointer
        sei
        sep #$20
        lda bBufferNMITIMEN
        and #$CF
        sta bBufferNMITIMEN
        sta $4200,b
        rep #$20

        _88E6
        rtl

        .databank 0

        ; 82/88E7

    .endsection Unsorted8288B2Section


    .section ProcScript8288E7Section

      .al
      .xl

      aProcDemoSkipFadeOutCode ; 82/88E7

        PROC_HALT


        ; 82/88E9

    .endsection ProcScript8288E7Section


    .section Unsorted828B35Section

      .al
      .xl

      rlProcHaltEventInit ; 82/8B35

        .al
        .autsiz
        .databank ?

        ; Empty rtl init for procUnknown828B2B (created by rlCreateProcHaltEvent)

        rtl

        .databank 0

      rlProcHaltEventCycle ; 82/8B36

        .al
        .autsiz
        .databank ?

        ; Wait until bit $0002 of $7F4C07 is set, then free event proc

        lda $7F4C07
        bit #$0002
        beq +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcHaltEventCode ; 82/8B44

        PROC_HALT

        ; 82/8B46

    .endsection Unsorted828B35Section


    .section Unsorted828B46Section

      .al
      .xl

      procEventWaitFlag7F4C07Bit10 ; 82/8B46

        .structProcInfo "ME", rlProcEventWaitFlag7F4C07Bit10Init, rlProcEventWaitFlag7F4C07Bit10Cycle, aProcEventWaitFlag7F4C07Bit10Code

        ; Unused: 2 zero bytes.
        .fill 2, $00

    .endsection Unsorted828B46Section


    .section Unsorted828B50Section

      .al
      .xl

      rlProcEventWaitFlag7F4C07Bit10Init ; 82/8B50

        .al
        .xl
        .autsiz
        .databank ?

        ; Empty rtl init for procEventWaitFlag7F4C07Bit10

        rtl

        .databank 0

        ; 82/8B51

      rlProcEventWaitFlag7F4C07Bit10Cycle ; 82/8B51

        .al
        .xl
        .autsiz
        .databank ?

        ; Wait until bit $0010 of $7F4C07 is set, then free event proc

        lda $7F4C07
        bit #$0010
        beq _8B5E
        jsl rlEventEngineFreeProc

        _8B5E
        rtl

        .databank 0

        ; 82/8B5F

    .endsection Unsorted828B50Section


    .section Unsorted828B5FSection

      .al
      .xl

      aProcEventWaitFlag7F4C07Bit10Code ; 82/8B5F

        PROC_HALT


        ; 82/8B61

    .endsection Unsorted828B5FSection


    .section Unsorted828BA9Section

      .al
      .xl

      procEventWaitBattleSceneEnd ; 82/8BA9

        .structProcInfo "ME", rlProcEventWaitBattleSceneEndInit, rlProcEventWaitBattleSceneEndCycle, aProcEventWaitBattleSceneEndCode

        ; Unused: 2 zero bytes.
        .fill 2, $00

    .endsection Unsorted828BA9Section


    .section Unsorted828BB3Section

      .al
      .xl

      rlProcEventWaitBattleSceneEndInit ; 82/8BB3

        .al
        .xl
        .autsiz
        .databank ?

        ; Empty rtl init for procEventWaitBattleSceneEnd

        rtl

        .databank 0

        ; 82/8BB4

      rlProcEventWaitBattleSceneEndCycle ; 82/8BB4

        .al
        .xl
        .autsiz
        .databank ?

        ; Frees the event proc once wGameStateRoutine1 is no longer one of the battle entries ($18-$1B: the battle scene or the map battle).

        lda wGameStateRoutine1,b
        cmp #GAMESTATE_BATTLE_SCENE_SETUP
        bcc _8BC1
        cmp #GAMESTATE_TITLE_SCREEN_STEP+1
        bcc _8BC5

        _8BC1
        jsl rlEventEngineFreeProc

        _8BC5
        rtl

        .databank 0

        ; 82/8BC6

    .endsection Unsorted828BB3Section


    .section Unsorted828BC6Section

      .al
      .xl

      aProcEventWaitBattleSceneEndCode ; 82/8BC6

        PROC_HALT


        ; 82/8BC8

    .endsection Unsorted828BC6Section


    .section Unsorted828BC8Section

      .al
      .xl

      procEventWaitProcUnknown88E02B ; 82/8BC8

        .structProcInfo "ME", rlProcEventWaitProcUnknown88E02BInit, rlProcEventWaitProcUnknown88E02BCycle, aProcEventWaitProcUnknown88E02BCode

        ; Unused: 2 zero bytes.
        .fill 2, $00

    .endsection Unsorted828BC8Section


    .section Unsorted828BD2Section

      .al
      .xl

      rlProcEventWaitProcUnknown88E02BInit ; 82/8BD2

        .al
        .xl
        .autsiz
        .databank ?

        ; Empty rtl init for procEventWaitProcUnknown88E02B

        rtl

        .databank 0

        ; 82/8BD3

      rlProcEventWaitProcUnknown88E02BCycle ; 82/8BD3

        .al
        .xl
        .autsiz
        .databank ?

        ; Poll rlProcEngineFindProc for procFirstGenerationEnding and free event proc when gone

        lda #(`procFirstGenerationEnding)<<8
        sta lR44+1
        lda #<>procFirstGenerationEnding
        sta lR44
        jsl rlProcEngineFindProc
        bcs _8BE7
        jsl rlEventEngineFreeProc

        _8BE7
        rtl

        .databank 0

        ; 82/8BE8

    .endsection Unsorted828BD2Section


    .section Unsorted828BE8Section

      .al
      .xl

      aProcEventWaitProcUnknown88E02BCode ; 82/8BE8

        PROC_HALT


        ; 82/8BEA

    .endsection Unsorted828BE8Section


    .section Unsorted829487Section

      .al
      .xl

      rlCreateProcEventWaitFlag7F4C07Bit10 ; 82/9487

        .al
        .xl
        .autsiz
        .databank ?

        ; Create blocking event proc procEventWaitFlag7F4C07Bit10

        lda #(`procEventWaitFlag7F4C07Bit10)<<8
        sta lR44+1
        lda #<>procEventWaitFlag7F4C07Bit10
        sta lR44
        jsl rlEventEngineCreateProc
        rtl

        .databank 0

        ; 82/9496

    .endsection Unsorted829487Section


    .section Unsorted829496Section

      .al
      .xl

      rlFreeMapBattleProcAndClearSprites ; 82/9496

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unused: find/free procMapBattle if active and clear all active sprites

        lda #(`procMapBattle)<<8
        sta lR44+1
        lda #<>procMapBattle
        sta lR44
        jsl rlProcEngineFindProc
        bcc _94B0
        txa
        lsr a
        jsl rlProcEngineFreeProcByIndex
        jsl rlActiveSpriteEngineClearAllSprites

        _94B0
        rtl

        .databank 0

        ; 82/94B1

    .endsection Unsorted829496Section


    .section Unreferenced8294B1Section

      .al
      .xl

      rlUnknown8294B1 ; 82/94B1

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown828B61)<<8
        sta lR44+1
        lda #<>procUnknown828B61
        sta lR44
        jsl rlEventEngineCreateProc
        rtl

        .databank 0

        ; 82/94C0

    .endsection Unreferenced8294B1Section
    .section Unsorted8294C0Section

      .al
      .xl

      rlCreateProcEventWaitBattleSceneEnd ; 82/94C0

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Create blocking event proc procEventWaitBattleSceneEnd

        lda #(`procEventWaitBattleSceneEnd)<<8
        sta lR44+1
        lda #<>procEventWaitBattleSceneEnd
        sta lR44
        jsl rlEventEngineCreateProc
        rtl

        .databank 0

        ; 82/94CF

    .endsection Unsorted8294C0Section


    .section Unsorted8294CFSection

      .al
      .xl

      rlCreateProcUnknown88E02BAndWait ; 82/94CF

        .al
        .xl
        .autsiz
        .databank ?

        ; Creates procFirstGenerationEnding and an event proc that waits until it ends. Only the chapter 5 ending event runs it, right after rlASMCArvisAttacksSigurd.

        lda #(`procFirstGenerationEnding)<<8
        sta lR44+1
        lda #<>procFirstGenerationEnding
        sta lR44
        jsl rlProcEngineCreateProc
        lda #(`procEventWaitProcUnknown88E02B)<<8
        sta lR44+1
        lda #<>procEventWaitProcUnknown88E02B
        sta lR44
        jsl rlEventEngineCreateProc
        rtl

        .databank 0

        ; 82/94EC

        ; Unused: 11028 zero bytes.
        .fill 11028, $00

    .endsection Unsorted8294CFSection

