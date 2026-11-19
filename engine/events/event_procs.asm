; Procs that event scripts use: scrolling, fades, pauses and halts.

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
        jsl $819166
        bcc _End

          lda wUnknown000D79,b
          bit #$8000
          bne +

            phx
            jsl $88BF97
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
        jsl $88860B
        bra _End

        _ScrollLeftDown
        jsl $88861C
        bra _End

        _ScrollRight
        lda aProcSystem.aBody3,b,x
        beq _ScrollJustRight
        bpl _ScrollRightUp
        bra _ScrollRightDown

        _ScrollJustRight
        jsl $8885FD
        bra _End

        _ScrollRightUp
        jsl $88862D
        bra _End

        _ScrollRightDown
        jsl rlUnknown88863E
        bra _End

        _ScrollUp
        jsl $8885D3
        bra _End

        _ScrollDown
        jsl $8885E1
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

        lda #(`$828B2B)<<8
        sta lR44+1
        lda #<>$828B2B
        sta lR44
        jsl rlEventEngineCreateProc
        rtl

        .databank 0

        ; 82/9487

    .endsection EventHaltProcSection


    .section EventProcSection

      .al
      .xl

      rsUnknown91A40E ; 91/A40E

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        inc wUnknown00171C,b
        jsl rlUnknown91A7A8
        jsr rsGetEventLength
        jsl rlEventEngineFreeAllProcs
        jsl rlUnknown91C611
        jsl rlActiveSpriteEngineClearAllSprites

        lda $0302,b
        sta wUnknown001730,b

        stz wR26

        lda #0
        sta aMovingMapSprites.wState,b

        lda #8
        trb wUnknown00171A,b

        plp
        jml rlRunEventCommand

        .databank 0

      rsEventEngineClearProcs ; 91/A440

        .al
        .autsiz
        .databank ?

        php
        phx
        ldx #size(wEventProcBanks)-2
        
          -
          lda #$FFFF
          sta wEventProcBanks,b,x
          stz wEventProcOffsets,b,x
          dec x
          dec x
          bpl -

        plx
        plp
        rts

        .databank 0

      rlEventEngineCreateProc ; 91/A455

        .al
        .autsiz
        .databank ?

        php
        lda lR44
        pha
        lda lR44+1
        pha

        jsl rlProcEngineCreateProc
        tax

        pla
        sta lR44+1
        pla
        sta lR44

        lda lR44+1
        and #$FF00
        xba
        sta wEventProcBanks,b,x
        lda lR44
        sta wEventProcOffsets,b,x

        lda #$0004
        tsb wUnknown00171A,b

        plp
        rtl

        .databank 0

      rlEventEngineFreeProc ; 91/A47D

        .al
        .autsiz
        .databank ?

        php
        ldx aProcSystem.wOffset,b
        jsl rlProcEngineFreeProc
        plp
        rtl

        .databank 0

      rlEventEngineFreeAllProcs ; 91/A487

        .al
        .autsiz
        .databank ?

        php

        rep #$30
        ldx #size(wEventProcOffsets)-2

          -
          lda wEventProcBanks,b,x
          cmp #$FFFF
          beq +

            phx
            txa
            lsr a
            jsl rlProcEngineFreeProcByIndex
            plx

            lda #$FFFF
            sta wEventProcBanks,b,x
            stz wEventProcOffsets,b,x

          +
          dec x
          dec x
          bpl -

        plp
        rtl

        .databank 0

      rlUnknown91A4AC ; 91/A4AC

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        lda wEventProcBanks,b,x
        bit #$0200
        beq +

        bit #$0400
        beq ++

        plp
        sec
        rtl

        +
        ora #$0200
        sta wEventProcBanks,b,x

        +
        plp
        clc
        rtl

        .databank 0

      rsUnknown91A4C8 ; 91/A4C8

        .al
        .autsiz
        .databank ?

        lda #$0002
        tsb wUnknown00171A,b

        ldx #(16 - 1) *2
        
        _Loop
        lda wEventProcBanks,b,x
        cmp #$FFFF
        beq _Next

        lda wEventProcBanks,b,x
        bit #$0200
        bne _Next

        lda wEventProcOffsets,b,x
        cmp aProcSystem.aHeaderTypeOffset,b,x
        bne +

        lda wEventProcBanks,b,x
        and #$00FF
        cmp aProcSystem.aHeaderTypeBank,b,x
        beq ++

        +
        lda #$FFFF
        sta wEventProcBanks,b,x
        stz wEventProcOffsets,b,x

        _Next
        dec x
        dec x
        bpl _Loop

        rts

        +
        lda #$0002
        trb wUnknown00171A,b
        bra _Next

        .databank 0

      aEventCommandPointers ; 91/A50A

        .word <>rsEventCommand00
        .word <>rsEventCommand01
        .word <>rsEventCommand02
        .word <>rsEventCommand03
        .word <>rsEventCommand04
        .word <>rsEventCommand05
        .word <>rsEventCommand06
        .word <>rsEventCommand07
        .word <>rsEventCommand08
        .word <>rsEventCommand09
        .word <>rsEventCommand0A
        .word <>rsEventCommand0B
        .word <>rsEventCommand0C
        .word <>rsEventCommand0D
        .word <>rsEventCommand0E
        .word <>rsEventCommand0F
        .word <>rsEventCommand10
        .word <>rsEventCommand11
        .word <>rsEventCommand12
        .word <>rsEventCommand13
        .word <>rsEventCommand14
        .word <>rsEventCommand15
        .word <>rsEventCommand16
        .word <>rsEventCommand17
        .word $0000               ; $18
        .word <>rsEventCommand19
        .word <>rsEventCommand1A
        .word <>rsEventCommand1B
        .word <>rsEventCommand1C
        .word <>rsEventCommand1D
        .word $0000               ; $1E
        .word <>rsEventCommand1F
        .word <>rsEventCommand20
        .word <>rsEventCommand21
        .word <>rsEventCommand22
        .word <>rsEventCommand23
        .word <>rsEventCommand24
        .word <>rsEventCommand25
        .word <>rsEventCommand26
        .word <>rsEventCommand27
        .word <>rsEventCommand28
        .word <>rsEventCommand29
        .word <>rsEventCommand2A
        .word <>rsEventCommand2B
        .word <>rsEventCommand2C
        .word <>rsEventCommand2D
        .word <>rsEventCommand2E
        .word <>rsEventCommand2F
        .word <>rsEventCommand30
        .word <>rsEventCommand31
        .word <>rsEventCommand32
        .word <>rsEventCommand33
        .word <>rsEventCommand34
        .word <>rsEventCommand35
        .word <>rsEventCommand36
        .word <>rsEventCommand37
        .word <>rsEventCommand38
        .word <>rsEventCommand39
        .word <>rsEventCommand3A
        .word <>rsEventCommand3B
        .word <>rsEventCommand3C
        .word <>rsEventCommand3D
        .word <>rsEventCommand3E
        .word <>rsEventCommand3F
        .word <>rsEventCommand40
        .word <>rsEventCommand41
        .word <>rsEventCommand42
        .word <>rsEventCommand43
        .word <>rsEventCommand44
        .word <>rsEventCommand45
        .word <>rsEventCommand46
        .word <>rsEventCommand47
        .word <>rsEventCommand48
        .word <>rsEventCommand49
        .word <>rsEventCommand4A
        .word <>rsEventCommand4B
        .word <>rsEventCommand4C
        .word <>rsEventCommand4D
        .word <>rsEventCommand4E
        .word <>rsEventCommand4F
        .word <>rsEventCommand50
        .word <>rsEventCommand51
        .word <>rsEventCommand52
        .word <>rsEventCommand53
        .word <>rsEventCommand54
        .word <>rsEventCommand55
        .word <>rsEventCommand56
        .word <>rsEventCommand57
        .word <>rsEventCommand58
        .word <>rsEventCommand59
        .word <>rsEventCommand5A
        .word <>rsEventCommand5B
        .word <>rsEventCommand5C
        .word <>rsEventCommand5D
        .word <>rsEventCommand5E
        .word $0000               ; $5F

      rlRunEventCommand ; 91/A5CA

        .al
        .autsiz
        .databank `aEventCommandPointers

        phb
        php
        phk
        plb

        jsr rsUnknown91A629
        bcc _End

          lda lActiveEventPointer+1,b
          sta lR22+1
          lda lActiveEventPointer,b
          sta lR22

          ldy wActiveEventOffset,b
          bra _A5FC

            _Loop
            inc y
            sty wActiveEventOffset,b

            phy
            asl a
            tay

            lda aEventCommandPointers,y
            ply

            sta lR23
            pea #<>(+)-1
            jmp (lR23)

            +
            bcc _A5FC

              sty wActiveEventOffset,b
              bra _End

          _A5FC
          lda [lR22],y
          cmp #$FEFE
          bne +

            inc y
            inc y
            sty wActiveEventOffset,b
            lda [lR22],y

          +
          cmp #$FFFF
          bne +

            lda #2
            sta wUnknown00171C,b
            bra _End

          +
          and #$00FF
          cmp #$00FD
          bne _Loop

          inc y
          sty wActiveEventOffset,b

        _End
        stz wUnknown000921,b

        plp
        plb
        rtl

        .databank 0

      rsUnknown91A629 ; 91/A629

        .al
        .autsiz
        .databank ?

        lda wUnknown00171A,b
        bit #$0004
        beq _SEC

          jsr rsUnknown91A4C8

          lda #$0002
          bit wUnknown00171A,b
          beq _CLC

            ora #$0004
            trb wUnknown00171A,b

        _SEC
        sec
        bra +
        
        _CLC
        clc
        
        +
        rts

        .databank 0

      rsGetEventLength ; 91/A647

        .al
        .autsiz
        .databank ?

        php
        lda lActiveEventPointer,b
        sta lR22
        lda lActiveEventPointer+1,b
        sta lR22+1
        ldy #0

        -
        lda [lR22],y
        cmp #$FEFE
        beq ++

          cmp #$FFFF
          beq +

            inc y
            bra -

          +
          stz wActiveEventLength,b
          bra _End

        +
        inc y
        inc y
        sty wActiveEventLength,b

        _End
        plp
        rts

        .databank 0

    .endsection EventProcSection
