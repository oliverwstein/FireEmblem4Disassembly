; Screen fade-in and fade-out procs, and clearing them.

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
        jsl rlUnknown80A9D4

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

        .structProcInfo "FO", rlProcFadeInByScreenFadingTimerInit, rlProcFadeOutByScreenFadingTimerCycle, $828362

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
        jsl rlUnknown80A9D4

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

      ; 82/83B5

    .endsection FadeProcsSection


    .section FadeProcClearSection

      .al
      .xl

      rsUnknown91A670 ; 91/A670

        .al
        .autsiz
        .databank ?

        php
        jsl rlClearAllFadeProcs
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          txa
          lsr a
          jsl rlProcEngineFreeProcByIndex

        +
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl $85C0D5
        jsl rlUnknown9180BC
        jsl rlDialogueFreeHDMA
        plp
        rts

        .databank 0

      rsUnknown91A69D ; 91/A69D

        .al
        .autsiz
        .databank ?

        lda wJoy1New
        bit #JOY_Start
        beq _CLC

          ldy wActiveEventOffset,b
          cpy wActiveEventLength,b
          bcs _CLC

            jsr rsUnknown91A670
            jsl rlEventEngineFreeAllProcs
            stz $0302,b
            ldy wActiveEventLength,b
            sty wActiveEventOffset,b
            sec
            rts

        _CLC
        clc
        rts

        .databank 0

      rlUnknown91A6C0 ; 91/A6C0

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        stz wUnknown00171A,b
        stz wUnknown00171C,b
        stz wUnknown00171E,b
        stz wActiveEventOffset,b
        jsl rlEventEngineFreeAllProcs
        jsl rlActiveSpriteEngineClearAllSprites
        jsl $818D7B
        plp
        rtl

        .databank 0

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

      rlUnknown91A788 ; 91/A788

        .al
        .autsiz
        .databank ?

        phx
        ldx #$0018

        _Loop
        lda $7E93AA,x
        beq _Next

          sta lMapMenuRAMEntryPointer,b
          phx
          jsl $8785A4
          plx
          lda #0
          sta lMapMenuRAMEntryPointer,b,x

        _Next
        dec x
        dec x
        dec x
        bpl _Loop

        plx
        rtl

        .databank 0

      rlUnknown91A7A8 ; 91/A7A8

        .al
        .autsiz
        .databank ?

        phb
        phx

        ldx #24
        lda #0

          -
          sta $7E93AA,x
          dec x
          dec x
          dec x
          bpl -

        plx
        plb
        rtl

        .databank 0

        ; 91/A7BC

    .endsection FadeProcClearSection


    .section SavePaletteBufferColorsToRAMSection

      .al
      .xl

      rlSavePaletteBufferColorsToRAM ; 9F/8E6C

        .al
        .autsiz
        .databank ?

        ; Takes 7 bytes of arguments after call.
        ; - a long pointer to a RAM address
        ; - a word color count
        ; - a word palette offset

        phx
        phy
        lda #5,s
        tay
        lda $0001,b,y
        sta lR18
        lda $0002,b,y
        sta lR18+1
        lda $0004,b,y
        sta wR0
        lda $0006,b,y
        tax
        tya
        clc
        adc #7
        sta #5,s

        ldy #0

          -
          lda aBGPaletteBuffer,b,x
          sta [lR18],y
          inc x
          inc x
          inc y
          inc y
          dec wR0
          bne -

        ply
        plx
        rtl

        .databank 0

      rlUnknown9F8E9E ; 9F/8E9E

        .al
        .autsiz
        .databank ?

        ; A = color count

        sta wR2

        -
        lda aPaletteFading.wDesiredColor,b
        cmp aBGPaletteBuffer,b,x
        beq +

          phx
          tay
          lda aBGPaletteBuffer,b,x
          tax
          lda aPaletteFading.wCurrentStep,b
          jsl rlFadeFromToColorByStep
          plx
          sta aBGPaletteBuffer,b,x

        +
        inc x
        inc x
        dec wR2
        bne -

        rtl

        .databank 0

        ; 9F/8EC0

    .endsection SavePaletteBufferColorsToRAMSection


    .section FadePaletteToBlackSection

      .al
      .xl

      rlFadePaletteToBlack ; 9F/8F4F

        .al
        .autsiz
        .databank ?

        ; Call followed by:
        ; .addr fade data

        ; Fade data contains:
        ; .word palette destination offset
        ; .word color count
        ; $FFFF terminator

        lda aPaletteFading.wMaxSteps,b
        bcc +

          lsr a

        +
        inc a
        cmp aPaletteFading.wCurrentStep,b
        bcs +

          lda #1,s
          adc #2
          sta #1,s
          stz aPaletteFading.wCurrentStep,b
          sec
          rtl

        +
        phx
        lda #3,s
        tay
        lda $0001,b,y
        tax
        tya
        clc
        adc #2
        sta #3,s

        txy
        bra +
        
          -
          phy
          tax
          lda $0002,b,y
          jsl rlUnknown9F8E9E
          ply
          inc y
          inc y
          inc y
          inc y

        +
        lda $0000,b,y
        cmp #$FFFF
        bne -

        inc aPaletteFading.wCurrentStep,b
        plx
        clc
        rtl

        .databank 0

        ; 9F/8F95

    .endsection FadePaletteToBlackSection


    .section FadeFromToColorByStepSection

      .al
      .xl

      rlFadeFromToColorByStep ; 9F/8FE3

        .al
        .autsiz
        .databank ?

        ; Adjusts the input colors to the destination color

        ; Input:
        ; A = step index
        ; X = current color word
        ; Y = desired color word

        ; Output:
        ; A = adjusted color

        pha
        pha
        phx
        phy
        lda #1,s
        and #$001F
        tay

        ; Desired red value in Y

        lda #3,s
        and #$001F
        tax

        ; Current red value in X

        lda #5,s
        jsr rsUnknown9F903F
        sta #7,s

        lda #1,s
        asl a
        asl a
        asl a
        xba
        and #$001F
        tay

        ; Desired green value in Y

        lda #3,s
        asl a
        asl a
        asl a
        xba
        and #$001F
        tax

        ; Current green value in X

        lda #5,s
        jsr rsUnknown9F903F
        asl a
        asl a
        asl a
        asl a
        asl a
        ora #7,s
        sta #7,s

        lda #1,s
        lsr a
        lsr a
        xba
        and #$001F
        tay

        ; Desired blue value in Y

        lda #3,s
        lsr a
        lsr a
        xba
        and #$001F
        tax

        ; Current blue value in X

        lda #5,s
        jsr rsUnknown9F903F
        asl a
        asl a
        xba
        ora #7,s
        sta #7,s

        ply
        plx
        pla
        pla
        rtl

        .databank 0

      rsUnknown9F903F ; 9F/903F

        .al
        .autsiz
        .databank ?

        cmp #0
        bne +

          txa
          rts

        +
        dec a
        cmp aPaletteFading.wMaxSteps,b
        bne +

          tya
          rts

        +
        phx
        inc a
        sta wR1
        tya
        sec
        sbc #1,s
        sta wR0
        bpl +

          eor #$FFFF
          inc a

        +
        xba
        and #$FF00
        sta WRDIVA
        sep #$21
        lda aPaletteFading.wMaxSteps,b
        sbc wR1
        inc a
        sta WRDIVB
        rep #$20
        xba
        xba
        nop
        nop
        lda RDDIV
        bit wR0
        bpl +

          eor #$FFFF
          inc a

        +
        sta wR0
        pla
        xba
        clc
        adc wR0
        xba
        and #$00FF
        rts

        .databank 0

        ; 9F/9090










; ============================================================================
; Duplicates of code that is already in the build (kept for comparison).
; ============================================================================

;       rsUnknown91BF17 ; 91/BF17

;         .al
;         .autsiz
;         .databank ?

;         phy

;         lda [$30],y
;         and #$00FF
;         sta $04BA,b
;         lda #(`$828AF2)<<8
;         sta $62+1
;         lda #<>$828AF2
;         sta $62
;         jsl rlEventEngineCreateProc

;         ply
;         inc y
;         sty wActiveEventOffset,b

;         sec
;         rts

;         .databank 0

;         ; 91/BF35







































;       aEpilogueLoverGroups ; B3/EDD9

;         .long aEpilogueLoverPointersPeppy
;         .long aEpilogueLoverPointersCreidneLarcei
;         .long aEpilogueLoverPointersMuirneLana
;         .long aEpilogueLoverPointersPeppy
;         .long aEpilogueLoverPointersLindaTine
;         .long aEpilogueLoverPointersPeppy
;         .long aEpilogueLoverPointersJeanneNanna

;       aEpilogueLoverPointersPeppy ; B3/EDEE

;         ; daisy, patty, hermina, fee, laylea, lene

;         .long dialogueEpilogueLover_Seliph_JuliaDead_Peppy
;         .long dialogueEpilogueLover_Seliph_JuliaAlive_All
;         .long dialogueEpilogueLover_Shannan_Peppy
;         .long dialogueEpilogueLover_DalvinScathach_ShannanDead_Peppy
;         .long dialogueEpilogueLover_DalvinScathach_ShannanAlive_All
;         .long dialogueEpilogueLover_Deimne_MuirneDead_Peppy
;         .long dialogueEpilogueLover_Deimne_MuirneAlive_All
;         .long dialogueEpilogueLover_Leif_Peppy
;         .long dialogueEpilogueLover_Leif_Peppy
;         .long dialogueEpilogueLover_CharlotCoirpre_HannibalDead_Peppy
;         .long dialogueEpilogueLover_CharlotCoirpre_HannibalAlive_Peppy
;         .long dialogueEpilogueLover_Asaello_DaisyDead_Peppy
;         .long dialogueEpilogueLover_Asaello_DaisyAlive_Peppy
;         .long dialogueEpilogueLover_Ares_Peppy
;         .long dialogueEpilogueLover_Diarmuid_Peppy
;         .long dialogueEpilogueLover_Diarmuid_Peppy
;         .long dialogueEpilogueLover_Tristan_Peppy
;         .long dialogueEpilogueLover_Tristan_Peppy
;         .long dialogueEpilogueLover_JamkesSon_Peppy
;         .long dialogueEpilogueLover_Febail_Peppy
;         .long dialogueEpilogueLover_Lester_BrigidsChildrenDead_Peppy
;         .long dialogueEpilogueLover_Lester_BrigidsChildrenAlive_Peppy
;         .long dialogueEpilogueLover_AmidArthur_Peppy
;         .long dialogueEpilogueLover_LexSon_Peppy
;         .long dialogueEpilogueLover_Iuchar_Peppy
;         .long dialogueEpilogueLover_Iucharba_Peppy
;         .long dialogueEpilogueLover_ClaudsSon_Peppy
;         .long dialogueEpilogueLover_AzellesSon_Peppy
;         .long dialogueEpilogueLover_Oifey_Peppy
;         .long dialogueEpilogueLover_Ced_Peppy
;         .long dialogueEpilogueLover_LewynsSon_Peppy

;       aEpilogueLoverPointersCreidneLarcei ; B3/EE4B

;         ; creidne, larcei

;         .long dialogueEpilogueLover_Seliph_JuliaDead_Noble
;         .long dialogueEpilogueLover_Seliph_JuliaAlive_All
;         .long dialogueEpilogueLover_Shannan_Noble
;         .long dialogueEpilogueLover_DalvinScathach_ShannanDead_Peppy
;         .long dialogueEpilogueLover_DalvinScathach_ShannanAlive_All
;         .long dialogueEpilogueLover_Deimne_MuirneDead_CreidneLarcei
;         .long dialogueEpilogueLover_Deimne_MuirneAlive_CreidneLarcei
;         .long dialogueEpilogueLover_Leif_AltenaDead_CreidneLarcei
;         .long dialogueEpilogueLover_Leif_AltenaAlive_CreidneLarcei
;         .long dialogueEpilogueLover_CharlotCoirpre_HannibalDead_CreidneLarcei
;         .long dialogueEpilogueLover_CharlotCoirpre_HannibalAlive_CreidneLarcei
;         .long dialogueEpilogueLover_Asaello_DaisyDead_CreidneLarcei
;         .long dialogueEpilogueLover_Asaello_DaisyAlive_CreidneLarcei
;         .long dialogueEpilogueLover_Ares_CreidneLarcei
;         .long dialogueEpilogueLover_Diarmuid_Noble
;         .long dialogueEpilogueLover_Diarmuid_Noble
;         .long dialogueEpilogueLover_Tristan_Noble
;         .long dialogueEpilogueLover_Tristan_Noble
;         .long dialogueEpilogueLover_JamkesSon_CreidneLarcei
;         .long dialogueEpilogueLover_Febail_CreidneLarcei
;         .long dialogueEpilogueLover_Lester_BrigidsChildrenDead_Noble
;         .long dialogueEpilogueLover_Lester_BrigidsChildrenAlive_Noble
;         .long dialogueEpilogueLover_AmidArthur_NobleA
;         .long dialogueEpilogueLover_LexSon_CreidneLarcei
;         .long dialogueEpilogueLover_Iuchar_CreidneLarcei
;         .long dialogueEpilogueLover_Iucharba_Noble
;         .long dialogueEpilogueLover_ClaudsSon_CreidneLarcei
;         .long dialogueEpilogueLover_AzellesSon_CreidneLarcei
;         .long dialogueEpilogueLover_Oifey_Noble
;         .long dialogueEpilogueLover_Ced_Noble
;         .long dialogueEpilogueLover_LewynsSon_Noble

;       aEpilogueLoverPointersMuirneLana ; B3/EEA8

;         ; murine, lana

;         .long dialogueEpilogueLover_Seliph_JuliaDead_Noble
;         .long dialogueEpilogueLover_Seliph_JuliaAlive_All
;         .long dialogueEpilogueLover_Shannan_Noble
;         .long dialogueEpilogueLover_DalvinScathach_ShannanDead_Noble
;         .long dialogueEpilogueLover_DalvinScathach_ShannanAlive_MuirneLana
;         .long dialogueEpilogueLover_Deimne_MuirneDead_Peppy
;         .long dialogueEpilogueLover_Deimne_MuirneAlive_All
;         .long dialogueEpilogueLover_Leif_Noble
;         .long dialogueEpilogueLover_Leif_Noble
;         .long dialogueEpilogueLover_CharlotCoirpre_HannibalDead_Noble
;         .long dialogueEpilogueLover_CharlotCoirpre_HannibalAlive_MuirneLana
;         .long dialogueEpilogueLover_Asaello_DaisyDead_Noble
;         .long dialogueEpilogueLover_Asaello_DaisyAlive_MuirneLana
;         .long dialogueEpilogueLover_Ares_Noble
;         .long dialogueEpilogueLover_Diarmuid_Noble
;         .long dialogueEpilogueLover_Diarmuid_Noble
;         .long dialogueEpilogueLover_Tristan_Noble
;         .long dialogueEpilogueLover_Tristan_Noble
;         .long dialogueEpilogueLover_JamkesSon_Noble
;         .long dialogueEpilogueLover_Febail_MuirneLana
;         .long dialogueEpilogueLover_Lester_BrigidsChildrenDead_Noble
;         .long dialogueEpilogueLover_Lester_BrigidsChildrenAlive_Noble
;         .long dialogueEpilogueLover_AmidArthur_NobleA
;         .long dialogueEpilogueLover_LexSon_Noble
;         .long dialogueEpilogueLover_Iuchar_Noble
;         .long dialogueEpilogueLover_Iucharba_Noble
;         .long dialogueEpilogueLover_ClaudsSon_MuirneLana
;         .long dialogueEpilogueLover_AzellesSon_MuirneLana
;         .long dialogueEpilogueLover_Oifey_Noble
;         .long dialogueEpilogueLover_Ced_Noble
;         .long dialogueEpilogueLover_LewynsSon_Noble

;       aEpilogueLoverPointersLindaTine ; B3/EF05

;         ; linda, tine

;         .long dialogueEpilogueLover_Seliph_JuliaDead_Noble
;         .long dialogueEpilogueLover_Seliph_JuliaAlive_All
;         .long dialogueEpilogueLover_Shannan_Noble
;         .long dialogueEpilogueLover_DalvinScathach_ShannanDead_Noble
;         .long dialogueEpilogueLover_DalvinScathach_ShannanAlive_All
;         .long dialogueEpilogueLover_Deimne_MuirneDead_Noble
;         .long dialogueEpilogueLover_Deimne_MuirneAlive_LindaTine
;         .long dialogueEpilogueLover_Leif_Noble
;         .long dialogueEpilogueLover_Leif_Noble
;         .long dialogueEpilogueLover_CharlotCoirpre_HannibalDead_Noble
;         .long dialogueEpilogueLover_CharlotCoirpre_HannibalAlive_LindaTine
;         .long dialogueEpilogueLover_Asaello_DaisyDead_Noble
;         .long dialogueEpilogueLover_Asaello_DaisyAlive_LindaTine
;         .long dialogueEpilogueLover_Ares_Noble
;         .long dialogueEpilogueLover_Diarmuid_Noble
;         .long dialogueEpilogueLover_Diarmuid_Noble
;         .long dialogueEpilogueLover_Tristan_Noble
;         .long dialogueEpilogueLover_Tristan_Noble
;         .long dialogueEpilogueLover_JamkesSon_Noble
;         .long dialogueEpilogueLover_Febail_Noble
;         .long dialogueEpilogueLover_Lester_BrigidsChildrenDead_Noble
;         .long dialogueEpilogueLover_Lester_BrigidsChildrenAlive_Noble
;         .long dialogueEpilogueLover_AmidArthur_NobleB
;         .long dialogueEpilogueLover_LexSon_Noble
;         .long dialogueEpilogueLover_Iuchar_Noble
;         .long dialogueEpilogueLover_Iucharba_Noble
;         .long dialogueEpilogueLover_ClaudsSon_LindaTine
;         .long dialogueEpilogueLover_AzellesSon_LindaTine
;         .long dialogueEpilogueLover_Oifey_Noble
;         .long dialogueEpilogueLover_Ced_Noble
;         .long dialogueEpilogueLover_LewynsSon_Noble

;       aEpilogueLoverPointersJeanneNanna ; B3/EF62

;         ; jeanne, nanna

;         .long dialogueEpilogueLover_Seliph_JuliaDead_Noble
;         .long dialogueEpilogueLover_Seliph_JuliaAlive_All
;         .long dialogueEpilogueLover_Shannan_Noble
;         .long dialogueEpilogueLover_DalvinScathach_ShannanDead_JeanneNanna
;         .long dialogueEpilogueLover_DalvinScathach_ShannanAlive_All
;         .long dialogueEpilogueLover_Deimne_MuirneDead_Noble
;         .long dialogueEpilogueLover_Deimne_MuirneAlive_All
;         .long dialogueEpilogueLover_Leif_Noble
;         .long dialogueEpilogueLover_Leif_Noble
;         .long dialogueEpilogueLover_CharlotCoirpre_HannibalDead_Noble
;         .long dialogueEpilogueLover_CharlotCoirpre_HannibalAlive_JeanneNanna
;         .long dialogueEpilogueLover_Asaello_DaisyDead_Noble
;         .long dialogueEpilogueLover_Asaello_DaisyAlive_JeanneNanna
;         .long dialogueEpilogueLover_Ares_Noble
;         .long dialogueEpilogueLover_Diarmuid_Noble
;         .long dialogueEpilogueLover_Diarmuid_Noble
;         .long dialogueEpilogueLover_Tristan_Noble
;         .long dialogueEpilogueLover_Tristan_Noble
;         .long dialogueEpilogueLover_JamkesSon_Noble
;         .long dialogueEpilogueLover_Febail_Noble
;         .long dialogueEpilogueLover_Lester_BrigidsChildrenDead_Noble
;         .long dialogueEpilogueLover_Lester_BrigidsChildrenAlive_Noble
;         .long dialogueEpilogueLover_AmidArthur_NobleB
;         .long dialogueEpilogueLover_LexSon_Noble
;         .long dialogueEpilogueLover_Iuchar_Noble
;         .long dialogueEpilogueLover_Iucharba_Noble
;         .long dialogueEpilogueLover_ClaudsSon_JeanneNanna
;         .long dialogueEpilogueLover_AzellesSon_JeanneNanna
;         .long dialogueEpilogueLover_Oifey_Noble
;         .long dialogueEpilogueLover_Ced_Noble
;         .long dialogueEpilogueLover_LewynsSon_Noble

; B3EFBF
;  -fill 0

    .endsection FadeFromToColorByStepSection
