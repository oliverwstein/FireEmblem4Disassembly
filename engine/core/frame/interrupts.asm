; The interrupt handlers: VBlank (rlVBlank, through wVBlankPointer, with the
; lag-frame path) and IRQ (rlIRQ, through wIRQPointer), the default routines
; installed at boot, turning VBlank on and off, waiting for VBlank, and turning
; forced blanking on and off. The IRQ engine is in ../display/irq.asm.

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

