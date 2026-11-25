; Screen brightness fades: fading in and out by a timer, the fade procs (including
; procMainLoopChangeFade, which installs the next screen's opener as the main loop
; routine when the fade ends), and clearing them. Palette fading is in
; palette_fade.asm.

    .section FadeInByTimerSection

      .as
      .xl

      rlFadeInByTimer ; 80/A21C
      
        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = Timer

        ; Output:
        ; SEC if screen bright, else CLC

        phb
        php
        phk
        plb
        sep #$20
        sta wScreenFadingTimeIncrement,b

        lda wScreenFadingFlag,b
        bpl +

          lda wScreenFadingTimeIncrement,b
          sta wScreenFadingTimer,b
          stz wScreenFadingFlag,b

        +
        lda bBufferINIDISP
        and #INIDISP_Brightness
        cmp #INIDISP_Setting(false, 15)
        beq _SEC

          dec wScreenFadingTimer,b
          bne +

            lda wScreenFadingTimeIncrement,b
            sta wScreenFadingTimer,b

            lda bBufferINIDISP
            inc a
            and #INIDISP_Brightness
            sta bBufferINIDISP

          +
          plp
          plb
          clc
          rtl

        _SEC
        lda #$FF
        sta wScreenFadingFlag,b
        plp
        plb
        sec
        rtl

        .databank 0

      rlFadeOutByTimer ; 80/A25A
      
        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = Timer

        ; Output:
        ; SEC if screen dark, else CLC

        phb
        php
        phk
        plb
        sep #$20
        sta wScreenFadingTimeIncrement,b

        lda wScreenFadingFlag,b
        bpl +

          lda wScreenFadingTimeIncrement,b
          sta wScreenFadingTimer,b
          stz wScreenFadingFlag,b

        +
        lda bBufferINIDISP
        and #INIDISP_Brightness
        beq _SEC

        dec wScreenFadingTimer,b
        bne +

          lda wScreenFadingTimeIncrement,b
          sta wScreenFadingTimer,b

          lda bBufferINIDISP
          dec a
          and #INIDISP_Brightness
          sta bBufferINIDISP

        +
        plp
        plb
        clc
        rtl

        _SEC
        lda #$FF
        sta wScreenFadingFlag,b
        lda #INIDISP_Setting(true, 0)
        sta bBufferINIDISP
        plp
        plb
        sec
        rtl

        .databank 0

        ; 80/A29A

    .endsection FadeInByTimerSection


    .section FadeProcsSection

      .al
      .xl

      procFadeIn ; 82/8299

        .structProcInfo "FI", rlProcFadeInInit, rlProcFadeInCycle, aProcFadeInCode

      rlProcFadeInInit ; 82/82A1

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$FF
        sta wScreenFadingFlag,b
        plp
        rtl

        .databank 0

      rlProcFadeInCycle ; 82/82AB

        .al
        .autsiz
        .databank ?

        lda #1
        jsl rlFadeInByTimer
        bcc +

          jsl rlProcEngineFreeProc

        +
        rtl

        .databank 0

      aProcFadeInCode ; 82/82B9

        PROC_HALT

      procFadeOut ; 82/82BB

        .structProcInfo "FO", rlProcFadeInInit, rlProcFadeOutCycle, aProcFadeOutCode

      rlProcFadeOutCycle ; 82/82C3
      
        .al
        .autsiz
        .databank ?

        lda #1
        jsl rlFadeOutByTimer
        bcc +

          jsl rlProcEngineFreeProc

        +
        rtl

        .databank 0

      aProcFadeOutCode ; 82/82D1

        PROC_HALT

      procMainLoopChangeFade ; 82/82D3

        .structProcInfo "Bt", rlProcMainLoopChangeFadeInit, rlProcMainLoopChangeFadeCycle, aProcMainLoopChangeFadeCode

      rlProcMainLoopChangeFadeInit ; 82/82DB
      
        .al
        .autsiz
        .databank ?

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x

        lda bBufferINIDISP
        bit #INIDISP_ForcedBlank
        bne +

          bit #INIDISP_Setting(false, 15)
          beq +

            lda #(`procFadeOut)<<8
            sta lR44+1
            lda #<>procFadeOut
            sta lR44
            jsl rlProcEngineCreateProc

        +
        rtl

        .databank 0

      rlProcMainLoopChangeFadeCycle ; 82/82FC

        .al
        .autsiz
        .databank ?

        lda bBufferINIDISP
        bit #INIDISP_ForcedBlank
        bne +

          bit #INIDISP_Setting(false, 15)
          bne _End

        +
        lda aProcSystem.aBody0,b,x
        jsl rlSetMainLoopPointer

        sei

        sep #$20
        lda bBufferNMITIMEN
        and #~(NMITIMEN_VCountIRQ | NMITIMEN_HCountIRQ)
        sta bBufferNMITIMEN
        sta NMITIMEN,b
        rep #$20

        jsl rlProcEngineFreeProc

        _End
        rtl

        .databank 0

      aProcMainLoopChangeFadeCode ; 82/8322

        PROC_HALT

      procFadeInByScreenFadingTimer ; 82/8324

        .structProcInfo "FI", rlProcFadeInByScreenFadingTimerInit, rlProcFadeInByScreenFadingTimerCycle, aProcFadeInByScreenFadingTimerCode

      rlProcFadeInByScreenFadingTimerInit ; 82/832C

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$FF
        sta wScreenFadingFlag,b
        lda wScreenFadingProcInput,b
        sta aProcSystem.aBody0,b,x
        plp
        rtl

        .databank 0

      rlProcFadeInByScreenFadingTimerCycle ; 82/833C

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        jsl rlFadeInByTimer
        bcc +

          jsl rlProcEngineFreeProc

        +
        rtl

        .databank 0

      aProcFadeInByScreenFadingTimerCode ; 82/834A

        PROC_HALT

      procFadeOutByScreenFadingTimer ; 82/834C

        .structProcInfo "FO", rlProcFadeInByScreenFadingTimerInit, rlProcFadeOutByScreenFadingTimerCycle, aProcFadeOutByScreenFadingTimerCode

      rlProcFadeOutByScreenFadingTimerCycle ; 82/8354

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        jsl rlFadeOutByTimer
        bcc +

          jsl rlProcEngineFreeProc

        +
        rtl

        .databank 0

      aProcFadeOutByScreenFadingTimerCode ; 82/8362

        PROC_HALT

      procMainLoopChangeFadeByTimer ; 82/8364

        .structProcInfo "Bt", rlProcMainLoopChangeFadeByTimerInit, rlProcMainLoopChangeFadeByTimerCycle, aProcMainLoopChangeFadeByTimerCode

      rlProcMainLoopChangeFadeByTimerInit ; 82/836C

        .al
        .autsiz
        .databank ?

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x

        lda bBufferINIDISP
        bit #INIDISP_ForcedBlank
        bne +

          bit #INIDISP_Setting(false, 15)
          beq +

            lda #(`procFadeOutByScreenFadingTimer)<<8
            sta lR44+1
            lda #<>procFadeOutByScreenFadingTimer
            sta lR44
            jsl rlProcEngineCreateProc
        
        +
        rtl

        .databank 0

      rlProcMainLoopChangeFadeByTimerCycle ; 82/838D

        .al
        .autsiz
        .databank ?

        lda bBufferINIDISP
        bit #INIDISP_ForcedBlank
        bne +

          bit #INIDISP_Setting(false, 15)
          bne _End

        +
        lda aProcSystem.aBody0,b,x
        jsl rlSetMainLoopPointer

        sei

        sep #$20
        lda bBufferNMITIMEN
        and #~(NMITIMEN_VCountIRQ | NMITIMEN_HCountIRQ)
        sta bBufferNMITIMEN
        sta NMITIMEN,b
        rep #$20

        jsl rlProcEngineFreeProc

        _End
        rtl

        .databank 0

      aProcMainLoopChangeFadeByTimerCode ; 82/83B3

        PROC_HALT

    .endsection FadeProcsSection


    .section FadeProcClearSection

      .al
      .xl


      rlClearAllFadeProcs ; 91/A6DD

        .al
        .autsiz
        .databank ?

        jsl rlClearAllFadeInProcs
        jsl rlClearAllFadeOutProcs
        rtl

        .databank 0

      rlClearAllFadeInProcs ; 91/A6E6

        .al
        .autsiz
        .databank ?

        php
        
        _Proc1
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineFindProc
        bcc _Proc2

          txa
          lsr a
          jsl rlProcEngineFreeProcByIndex
          bra _Proc1
        
        _Proc2
        lda #(`procFadeInByScreenFadingTimer)<<8
        sta lR44+1
        lda #<>procFadeInByScreenFadingTimer
        sta lR44
        jsl rlProcEngineFindProc
        bcc _Proc3

          txa
          lsr a
          jsl rlProcEngineFreeProcByIndex
          bra _Proc2
        
        _Proc3
        lda #(`procEventFadeInByTimer)<<8
        sta lR44+1
        lda #<>procEventFadeInByTimer
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          txa
          lsr a
          jsl rlProcEngineFreeProcByIndex
          bra _Proc3

        +
        lda #$FFFF
        sta wScreenFadingFlag,b
        plp
        rtl

        .databank 0

      rlClearAllFadeOutProcs ; 91/A737

        .al
        .autsiz
        .databank ?

        php
        
        _Proc1
        lda #(`procFadeOut)<<8
        sta lR44+1
        lda #<>procFadeOut
        sta lR44
        jsl rlProcEngineFindProc
        bcc _Proc2

          txa
          lsr a
          jsl rlProcEngineFreeProcByIndex
          bra _Proc1

        _Proc2
        lda #(`procFadeOutByScreenFadingTimer)<<8
        sta lR44+1
        lda #<>procFadeOutByScreenFadingTimer
        sta lR44
        jsl rlProcEngineFindProc
        bcc _Proc3

          txa
          lsr a
          jsl rlProcEngineFreeProcByIndex
          bra _Proc2

        _Proc3
        lda #(`procEventFadeOutByTimer)<<8
        sta lR44+1
        lda #<>procEventFadeOutByTimer
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          txa
          lsr a
          jsl rlProcEngineFreeProcByIndex
          bra _Proc3

        +
        lda #$FFFF
        sta wScreenFadingFlag,b
        plp
        rtl

        .databank 0

    .endsection FadeProcClearSection

