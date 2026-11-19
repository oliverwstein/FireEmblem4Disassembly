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


