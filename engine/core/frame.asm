; Once-per-frame bookkeeping: frame counters and the soft-reset button check.

    .section FrameSection

      .al
      .xl

      rlButtonCombinationResetCheck ; 80/A6C3

        .al
        .autsiz
        .databank ?

        ; Quick reset

        php
        lda wJoy1Input
        and #~JOY_Start
        eor #(JOY_Select | JOY_L | JOY_R)
        bne +

          lda wJoy1New
          bit #JOY_Start
          beq +

            sep #$20
            lda #INIDISP_Setting(true, 0)
            sta INIDISP,b
            lda #NMITIMEN_Setting(true, false, false, false)
            sta NMITIMEN,b
            sta bBufferNMITIMEN
            stz bDMAPendingChannels,b
            stz bHDMAPendingChannels,b
            stz bBufferHDMAEN
            stz bDMAArrayFlag,b
            rep #$20

            stz wDMAArrayPosition,b
            jml rlUnknown808ECC

        +
        plp
        rtl

        .databank 0

      rlIncreaseFrameCounters ; 80/A6F9

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        sep #$20
        inc bFrameCounterByOnes,b

        lda bFrameCounterByThrees,b
        clc
        adc #3
        sta bFrameCounterByThrees,b

        plp
        plb
        rtl

        .databank 0

    .endsection FrameSection
