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

      ; 82/83B5

      procUnknown8283B5 ; 82/83B5

        ; Unreferenced: nothing creates this proc. Its init queues a
        ; decompression of the stream at lR44 into aDecompressionBuffer; its
        ; cycle ends the proc when the decompression list is done.

        .structProcInfo "De", rlProcUnknown8283B5Init, rlProcUnknown8283B5Cycle, aProcUnknown8283B5Code

      rlProcUnknown8283B5Init ; 82/83BD

        .al
        .xl
        .autsiz
        .databank ?

        lda lR44
        sta lR18
        lda lR44+1
        sta lR18+1
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        rtl

        .databank 0

        ; 82/83D4

      rlProcUnknown8283B5Cycle ; 82/83D4

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        and #$00FF
        bne _83E0
        jsl rlProcEngineFreeProc

        _83E0
        rtl

        .databank 0

        ; 82/83E1

      aProcUnknown8283B5Code ; 82/83E1

        PROC_HALT

    .endsection FadeProcsSection


    .section FadeProcClearSection

      .al
      .xl

      rsClearEventUIAndProcs ; 91/A670

        .al
        .autsiz
        .databank ?

        ; Clear fades, main-loop fade proc, unit/terrain/map windows, and dialogue HDMA

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
        jsl rlShowMapWindows
        jsl rlUnknown9180BC
        jsl rlDialogueFreeHDMA
        plp
        rts

        .databank 0

      rsCheckSkipActiveEvent ; 91/A69D

        .al
        .autsiz
        .databank ?

        ; Skip active event on Start press: clear UI/event procs, reset state, return sec

        lda wJoy1New
        bit #JOY_Start
        beq _CLC

          ldy wActiveEventOffset,b
          cpy wActiveEventLength,b
          bcs _CLC

            jsr rsClearEventUIAndProcs
            jsl rlEventEngineFreeAllProcs
            stz wGameStateRoutine1,b
            ldy wActiveEventLength,b
            sty wActiveEventOffset,b
            sec
            rts

        _CLC
        clc
        rts

        .databank 0

      rlResetEventAndSpriteState ; 91/A6C0

        .al
        .autsiz
        .databank ?

        ; Clear event flags $171A-$171E, offset, event procs, active sprites, and map sprite sound

        php
        rep #$30
        stz wEventEngineFlags,b
        stz wEventEngineState,b
        stz wUnknown00171E,b
        stz wActiveEventOffset,b
        jsl rlEventEngineFreeAllProcs
        jsl rlActiveSpriteEngineClearAllSprites
        jsl rlStopMapSpriteSounds
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

      rlClearEventMenuWindowList ; 91/A788

        .al
        .autsiz
        .databank ?

        ; Remove open map menus tracked in 9-entry table at $7E93AA

        phx
        ldx #$0018

        _Loop
        lda $7E93AA,x
        beq _Next

          sta lMapMenuRAMEntryPointer,b
          phx
          jsl rlRemoveMapMenu
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

      rlZeroEventMenuWindowList ; 91/A7A8

        .al
        .autsiz
        .databank ?

        ; Zero the 27-byte 9-entry event map-menu table at $7E93AA

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

      rlFadeBGPaletteColorsToDesired ; 9F/8E9E

        .al
        .autsiz
        .databank ?

        ; Fade A colors of aBGPaletteBuffer from X toward wDesiredColor by current step

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


    .section FadePaletteToColorsSection

      .al
      .xl

      rlFadePaletteToColors ; 9F/8EE1

        .al
        .autsiz
        .databank ?

        ; Call followed by:
        ; .addr palette source in bank $7E
        ; .word color count
        ; .word palette destination offset

        lda aPaletteFading.wMaxSteps,b
        bcc +

          lsr a

        +
        inc a
        cmp aPaletteFading.wCurrentStep,b
        bcs +

          lda #1,s
          adc #6
          sta #1,s
          stz aPaletteFading.wCurrentStep,b
          sec
          rtl

        +
        phx
        phy
        lda #5,s
        tay
        lda $0001,b,y
        sta wR3
        lda $0003,b,y
        sta wR5
        lda $0005,b,y
        tax
        tya
        clc
        adc #6
        sta #5,s

        phb
        pea #$7E7E
        plb
        plb

        ldy #0

          -
          stx aPaletteFading.wCurrentPaletteBufferOffset,b
          sty wR4,b
          lda (wR3),y
          cmp aBGPaletteBuffer,b,x
          beq +

            tay
            lda aBGPaletteBuffer,b,x
            tax
            lda aPaletteFading.wCurrentStep,b
            jsl rlFadeFromToColorByStep
            ldy wR4,b
            ldx aPaletteFading.wCurrentPaletteBufferOffset,b
            sta aBGPaletteBuffer,b,x

          +
          inc y
          inc y
          inc x
          inc x
          dec wR5,b
          bne -

        inc aPaletteFading.wCurrentStep,b
        plb
        ply
        plx
        clc
        rtl

        .databank 0

    .endsection FadePaletteToColorsSection


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
          jsl rlFadeBGPaletteColorsToDesired
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

      rlFadeBGPaletteColorRanges ; 9F/8F95

        .al
        .xl
        .autsiz
        .databank ?

        ; Fade inline (offset, count, targetColor) list terminated by $FFFF

        lda aPaletteFading.wMaxSteps,b
        bcc _8F9B
        lsr a

        _8F9B
        inc a
        cmp aPaletteFading.wCurrentStep,b
        bcs _8FAD
        lda #1,s
        adc #2
        sta #1,s
        stz aPaletteFading.wCurrentStep,b
        sec
        rtl

        _8FAD
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
        bra _8FD5

        _8FBF
        phy
        tax
        lda $0002,b,y
        pha
        lda $0004,b,y
        tay
        pla
        jsl rlDarkenBGPaletteRange
        ply
        inc y
        inc y
        inc y
        inc y
        inc y
        inc y

        _8FD5
        lda $0000,b,y
        cmp #$FFFF
        bne _8FBF
        inc aPaletteFading.wCurrentStep,b
        plx
        clc
        rtl

        .databank 0

        ; 9F/8FE3

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
        jsr rsInterpolateColorChannel
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
        jsr rsInterpolateColorChannel
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
        jsr rsInterpolateColorChannel
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

      rsInterpolateColorChannel ; 9F/903F

        .al
        .autsiz
        .databank ?

        ; Interpolate one 5-bit RGB channel from X to Y at step A of wMaxSteps

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


    .endsection FadeFromToColorByStepSection


    .section Unsorted80A29ASection

      .al
      .xs

      rlFadeOutCOLDATAByTimer ; 80/A29A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Decrements COLDATA brightness $1F->0 by timer in A; returns SEC when complete

        phb
        php
        phk
        plb
        .databank $80
        sep #$20
        sta wScreenFadingTimeIncrement,b
        lda wScreenFadingFlag,b
        bpl _A2B9
        lda wScreenFadingTimeIncrement,b
        sta wScreenFadingTimer,b
        lda #$FF
        sta bBufferCOLDATA_0
        stz bBufferCOLDATA_1
        stz bBufferCOLDATA_2
        stz wScreenFadingFlag,b

        _A2B9
        lda bBufferCOLDATA_0
        and #$1F
        beq _A2D7
        dec wScreenFadingTimer,b
        bne _A2D3
        lda wScreenFadingTimeIncrement,b
        sta wScreenFadingTimer,b
        lda bBufferCOLDATA_0
        and #$1F
        dec a
        ora #$E0
        sta bBufferCOLDATA_0

        _A2D3
        plp
        plb
        .databank $80
        clc
        rtl


        _A2D7
        lda #$FF
        sta wScreenFadingFlag,b
        plp
        plb
        .databank $80
        sec
        rtl

        .databank 0

        ; 80/A2E0

      rlFadeInCOLDATAByTimer ; 80/A2E0

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Increments COLDATA brightness 0->$1F by timer in A; returns SEC when complete

        phb
        php
        phk
        plb
        .databank $80
        sep #$20
        sta wScreenFadingTimeIncrement,b
        lda wScreenFadingFlag,b
        bpl _A2FF
        lda wScreenFadingTimeIncrement,b
        sta wScreenFadingTimer,b
        lda #$E0
        sta bBufferCOLDATA_0
        stz bBufferCOLDATA_1
        stz bBufferCOLDATA_2
        stz wScreenFadingFlag,b

        _A2FF
        lda bBufferCOLDATA_0
        and #$1F
        cmp #$1F
        beq _A31F
        dec wScreenFadingTimer,b
        bne _A31B
        lda wScreenFadingTimeIncrement,b
        sta wScreenFadingTimer,b
        lda bBufferCOLDATA_0
        and #$1F
        inc a
        ora #$E0
        sta bBufferCOLDATA_0

        _A31B
        plp
        plb
        .databank $80
        clc
        rtl


        _A31F
        lda #$FF
        sta wScreenFadingFlag,b
        plp
        plb
        .databank $80
        sec
        rtl

        .databank 0

        ; 80/A328

    .endsection Unsorted80A29ASection


