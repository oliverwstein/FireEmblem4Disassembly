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
        lda $0302,b
        cmp #$0012
        beq +

          cmp #$000F
          bne _End

        +
        jsl rlUnknown819166
        bcc _End

          lda wUnknown000D79,b
          bit #$8000
          bne +

            phx
            jsl rlUnknown88BF97
            plx
            bcc +

              lda #$0080
              sta $0768,b
              sta $076A,b

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
        jsl rlUnknown8885EF
        bra _End

        _ScrollLeftUp
        jsl rlUnknown88860B
        bra _End

        _ScrollLeftDown
        jsl rlUnknown88861C
        bra _End

        _ScrollRight
        lda aProcSystem.aBody3,b,x
        beq _ScrollJustRight
        bpl _ScrollRightUp
        bra _ScrollRightDown

        _ScrollJustRight
        jsl rlUnknown8885FD
        bra _End

        _ScrollRightUp
        jsl rlUnknown88862D
        bra _End

        _ScrollRightDown
        jsl rlUnknown88863E
        bra _End

        _ScrollUp
        jsl rlUnknown8885D3
        bra _End

        _ScrollDown
        jsl rlUnknown8885E1
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
