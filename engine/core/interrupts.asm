; Turning the VBlank (NMI) interrupt on and off.

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
