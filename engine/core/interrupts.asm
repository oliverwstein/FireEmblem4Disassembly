; Turning the VBlank (NMI) interrupt on and off, waiting for VBlank, and turning
; forced blanking on and off.

    .section VBlankControlSection

      .al
      .xl

      rlEnableVBlank ; 80/8223

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda bBufferNMITIMEN
        ora #NMITIMEN_VBlank
        sta bBufferNMITIMEN
        sta NMITIMEN,b
        plp
        rtl

        .databank 0

      rlDisableVBlank ; 80/8231

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda bBufferNMITIMEN
        and #~(NMITIMEN_VBlank)
        sta bBufferNMITIMEN
        sta NMITIMEN,b
        plp
        rtl

        .databank 0

        ; 80/823F

    .endsection VBlankControlSection


    .section EnableForcedBlankSection

      .al
      .xl

      rlEnableForcedBlank ; 80/8248

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        .databank $80
        sep #$20
        lda bBufferINIDISP
        ora #$80
        sta bBufferINIDISP
        jsl rlHaltUntilVBlank
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/825B

    .endsection EnableForcedBlankSection


    .section Unsorted80823FSection

      .al
      .xl

      rlHaltUntilVBlank ; 80/823F

        .al
        .xl
        .autsiz
        .databank ?

        ; Waits until wVBlankEnabledFramecount changes. FE5: rlHaltUntilVBlank.

        php
        lda wVBlankEnabledFramecount

        _8242
        cmp wVBlankEnabledFramecount
        beq _8242
        plp
        rtl

        .databank 0

        ; 80/8248

    .endsection Unsorted80823FSection


    .section Unsorted80825BSection

      .al
      .xl

      rlDisableForcedBlank ; 80/825B

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the forced blank bit of bBufferINIDISP and waits for VBlank. FE5: rlDisableForcedBlank.

        php
        phb
        phk
        plb
        .databank $80
        sep #$20
        lda bBufferINIDISP
        and #$7F
        sta bBufferINIDISP
        jsl rlHaltUntilVBlank
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/826E

    .endsection Unsorted80825BSection


    .section IRQEngineCycleSection

      .al
      .xl

      rsIRQEngineCycle ; 80/AE63

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ callback wrapper invoking jsl rlRunIRQEngine

        jsl rlRunIRQEngine
        rts

        .databank 0

        ; 80/AE68

    .endsection IRQEngineCycleSection


    .section Unsorted8081B6Section

      .al
      .xl

      rlVBlank ; 80/81B6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Native VBlank/NMI interrupt handler ($FFE0/$FFEA), calls (wVBlankPointer) or handles lag frame

        cli
        rep #$30
        jml _81BD


        _81BD
        phb
        phd
        pha
        phx
        phy
        lda #$0000
        tcd
        phk
        plb
        .databank $80
        lda $4210,b
        lda wVBlankFlag
        bmi _81E9
        ora #$8000
        sta wVBlankFlag
        pea #<>(+)-1
        jmp (wVBlankPointer)

        +
        jsl rlTickGameTimer
        inc wVBlankEnabledFramecount
        ply
        plx
        pla
        pld
        stz wVBlankFlag,b
        plb
        .databank $80
        rti


        _81E9
        inc wVBlankDisabledFramecount
        jsl rlSendSoundQueuesToAPU
        jsl rlCopyINIDISPBuffer
        jsl rlTickGameTimer
        ply
        plx
        pla
        pld
        plb
        .databank $80
        rti

        .databank 0

        ; 80/81FD

    .endsection Unsorted8081B6Section


    .section Unsorted8081FDSection

      .al
      .xl

      rlIRQ ; 80/81FD

        ; Found through fe4.cdl.
        .as
        .xs
        .autsiz
        .databank ?

        ; Native IRQ interrupt handler ($FFEE/$FFFE), checks TIMEUP and calls (wIRQPointer)

        rep #$30
        jml _8203


        _8203
        phb
        phd
        pha
        phx
        phy
        phk
        plb
        .databank $80
        lda #$0000
        tcd
        lda $4211,b
        bit #$0080
        beq _821C
        pea #<>_821C - 1
        jmp (wIRQPointer)


        _821C
        ply
        plx
        pla
        pld
        plb
        .databank $80
        rti

        .databank 0

        ; 80/8222

      rsDefaultIRQRoutine ; 80/8222

        .al
        .xl
        .autsiz
        .databank ?

        ; Default no-op RTS stub installed into wIRQPointer on boot/reset

        rts

        .databank 0

        ; 80/8223

    .endsection Unsorted8081FDSection


    .section Unsorted809CA0Section

      .al
      .xl

      rsDefaultVBlankRoutine ; 80/9CA0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; The VBlank routine rlReset installs. FE5: rsDefaultVBlankRoutine.

        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlCopyPPURegisterBuffer
        jsl rlSendSoundQueuesToAPU
        jsl rlGetJoypadInput
        jsl rlIncreaseFrameCounters
        jsl rlClearSpriteExtBuffer
        jsl rlRunGameStateRoutines
        jsl rlRunVBlankHooks
        jsl rlHideSprites
        jsl rlUpdateSound
        rts

        .databank 0

        ; 80/9CD6

    .endsection Unsorted809CA0Section


    .section Unsorted82E000Section

      .al
      .xl

      aIRQEngineMainActionTable ; 82/E000
        .word <>rlResetIRQEngine, <>rlIRQEngineStub, <>rlIRQEngineRestoreDefaultIRQ

      rsIRQCodeSleep ; 82/E006

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script cmd: read inline word sleep timer into $170A,x and yield

        lda $0000,b,y
        sta $170A,b,x
        inc y
        inc y
        tya
        sta $16FA,b,x
        pla
        rts

        .databank 0

        ; 82/E014

      rsIRQCodeEnd ; 82/E014

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script cmd: clear slot $169A/$16DA, resort slots, decrement $1695, exit

        stz $169A,b,x
        stz $16DA,b,x
        jsr rsUnknown82E177
        dec $1695,b
        pla
        rts

        .databank 0

        ; 82/E022

      rsIRQCodeHaltSleep ; 82/E022
        .al
        .xl
        lda #$0001
        sta $170A,b,x
        ; falls into rsIRQCodeHalt

    .endsection Unsorted82E000Section


    .section Unsorted82E028Section

      .al
      .xl

      rsIRQCodeHalt ; 82/E028

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script cmd: rewind Y by 2, store script PC to $16FA,x, and yield

        dec y
        dec y
        tya
        sta $16FA,b,x
        pla
        rts

        .databank 0

        ; 82/E030

    .endsection Unsorted82E028Section


    .section Unreferenced82E030Section

      .al
      .xl

      rsUnknown82E030 ; 82/E030

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $0000,b,y
        sta $1697,b
        lda $0001,b,y
        sta $1698,b
        phy
        phx
        jsl $82E048
        plx
        ply
        inc y
        inc y
        inc y
        rts

        .databank 0

        ; 82/E048

    .endsection Unreferenced82E030Section
    .section Unsorted82E073Section

      .al
      .xl

      rlResetIRQEngine ; 82/E073

        .al
        .autsiz
        .databank ?

        ; Clears $168F-$1719 and calls rlDisableIRQEngine. FE5: rlIRQEngineReset (identical, same size cleared).

        php
        phb
        phk
        plb
        ldx #$008A
        sep #$20
        lda #0
        
          -
          sta $168F,b,x
          dec x
          bpl -

        rep #$20
        jsl rlDisableIRQEngine
        plb
        plp
        rtl

        .databank 0

        ; 82/E08D

    .endsection Unsorted82E073Section


    .section Unsorted82E0AFSection

      .al
      .xl

      rlDisableIRQEngine ; 82/E0AF

        .al
        .autsiz
        .databank ?

        ; Clear NMITIMEN H/V IRQ bits, set $8000 in $168F, reset wIRQPointer

        sei
        sep #$20
        lda bBufferNMITIMEN
        and #$CF
        sta bBufferNMITIMEN
        rep #$20

        lda #$8000
        tsb $168F,b
        lda #<>rsDefaultIRQRoutine
        sta wIRQPointer
        rtl

        .databank 0

        ; 82/E0C6

    .endsection Unsorted82E0AFSection


    .section Unsorted82E133Section

      .al
      .xl

      rlIRQEngineStub ; 82/E133

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; The IRQ engine's per-frame routine in aIRQEngineMainActionTable: does
        ; nothing. The engine's work runs from the IRQ itself (rsIRQEngineCycle).

        rtl

        .databank 0

      rlUnknown82E134 ; 82/E134

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing refers to it. Writes INIDISP with only the forced-blank bit of
        ; bBufferINIDISP (brightness 0).

        sep #$20
        lda bBufferINIDISP
        and #$80
        sta $2100,b
        rep #$20
        rtl

        .databank 0

      rlIRQEngineRestoreDefaultIRQ ; 82/E140

        .al
        .xl
        .autsiz
        .databank ?

        ; The third routine in aIRQEngineMainActionTable: puts rsDefaultIRQRoutine
        ; back in wIRQPointer and disables interrupts. rlRegisterVBlankHook reads
        ; only the first two words of an engine's table, and nothing else is
        ; known to read the third.

        lda #<>rsDefaultIRQRoutine
        sta wIRQPointer
        sei
        rtl

        .databank 0

        ; 82/E147

    .endsection Unsorted82E133Section


    .section Unsorted82E250Section

      .al
      .xl

      rlRunIRQEngine ; 82/E250

        .al
        .xl
        .autsiz
        .databank ?

        ; Run active IRQ slot callback, step slot script, advance/wrap to next IRQ slot

        phb
        php
        phk
        plb
        .databank $82
        lda $168F,b
        bit #$8000
        bne _E280
        lda $1697,b
        ora $1698,b
        beq _E280
        ldx $1691,b
        jsl rlIRQEngineRunSlotCallback
        jsr rsIRQEngineStepSlotCode
        ldx $1691,b
        bne _E278
        lda $1693,b
        asl a
        tax

        _E278
        dec x
        dec x
        stx $1691,b
        jsr rsUnknown82E283

        _E280
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E283

    .endsection Unsorted82E250Section


    .section Unsorted82E2ADSection

      .al
      .xl

      rsIRQEngineStepSlotCode ; 82/E2AD

        .al
        .xl
        .autsiz
        .databank ?

        ; Decrement IRQ slot sleep timer; step script commands or load (timer, VTIME)

        ldx $1691,b
        dec $170A,b,x
        bne _E2D9
        ldy $16FA,b,x

        _E2B8
        lda $0000,b,y
        bpl _E2C8
        sta $1697,b
        inc y
        inc y
        pea #<>_E2B8 - 1
        jmp ($1697)


        _E2C8
        sta $170A,b,x
        lda $0002,b,y
        sta $16DA,b,x
        tya
        clc
        adc #$0004
        sta $16FA,b,x

        _E2D9
        rts

        .databank 0

        ; 82/E2DA

      rlIRQEngineRunSlotCallback ; 82/E2DA

        .al
        .xl
        .autsiz
        .databank ?

        ; Set DB from $1699 and jml [$1697] for active IRQ slot handler

        sep #$20
        lda $1699,b
        pha
        rep #$20
        plb
        .databank ?
        jml [$1697]

        .databank 0

        ; 82/E2E6

    .endsection Unsorted82E2ADSection


