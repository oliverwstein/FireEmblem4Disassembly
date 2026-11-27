; Writing the PPU register buffers in RAM (bBufferINIDISP and the rest) to the
; PPU registers.


    .section CopyPPURegisterBufferSection

      .al
      .xl

      rlCopyPPURegisterBuffer ; 80/80C3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Writes the PPU register buffers (bBufferINIDISP and the rest) to the registers. FE5: rlCopyPPURegisterBuffer.

        php
        phb
        phk
        plb
        .databank $80
        sep #$20
        lda bBufferINIDISP
        sta $2100,b
        lda bBufferOBSEL
        sta $2101,b
        lda bBufferBGMODE
        sta $2105,b
        lda bBufferMOSAIC
        sta $2106,b
        lda bBufferBG1SC
        sta $2107,b
        lda bBufferBG2SC
        sta $2108,b
        lda bBufferBG3SC
        sta $2109,b
        lda bBufferBG4SC
        sta $210A,b
        lda bBufferBG12NBA
        sta $210B,b
        lda bBufferBG34NBA
        sta $210C,b
        lda bBufferW12SEL
        sta $2123,b
        lda bBufferW34SEL
        sta $2124,b
        lda bBufferWOBJSEL
        sta $2125,b
        lda bBufferWH0
        sta $2126,b
        lda bBufferWH1
        sta $2127,b
        lda bBufferWH2
        sta $2128,b
        lda bBufferWH3
        sta $2129,b
        lda bBufferWBGLOG
        sta $212A,b
        lda bBufferWOBJLOG
        sta $212B,b
        lda bBufferTM
        sta $212C,b
        lda bBufferTMW
        sta $212E,b
        lda bBufferTS
        sta $212D,b
        lda bBufferTSW
        sta $212F,b
        lda bBufferCGWSEL
        sta $2130,b
        lda bBufferCGADSUB
        sta $2131,b
        lda bBufferCOLDATA_1
        sta $2132,b
        lda bBufferCOLDATA_2
        sta $2132,b
        lda bBufferCOLDATA_3
        sta $2132,b
        lda bBufferSETINI
        sta $2133,b
        lda wBufferBG1HOFS
        sta $210D,b
        lda wBufferBG1HOFS+1
        sta $210D,b
        lda wBufferBG1VOFS
        sec
        sbc #$01
        sta $210E,b
        lda wBufferBG1VOFS+1
        sbc #$00
        sta $210E,b
        lda wBufferBG2HOFS
        sta $210F,b
        lda wBufferBG2HOFS+1
        sta $210F,b
        lda wBufferBG2VOFS
        sec
        sbc #$01
        sta $2110,b
        lda wBufferBG2VOFS+1
        sbc #$00
        sta $2110,b
        lda wBufferBG3HOFS
        sta $2111,b
        lda wBufferBG3HOFS+1
        sta $2111,b
        lda wBufferBG3VOFS
        sec
        sbc #$01
        sta $2112,b
        lda wBufferBG3VOFS+1
        sbc #$00
        sta $2112,b
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/81A8

    .endsection CopyPPURegisterBufferSection


    .section CopyINIDISPBufferSection

      .al
      .xl

      rlCopyINIDISPBuffer ; 80/81A8

        .al
        .xl
        .autsiz
        .databank ?

        ; Writes bBufferINIDISP to INIDISP. FE5: rlCopyINIDISPBuffer.

        php
        phb
        phk
        plb
        .databank $80
        sep #$20
        lda bBufferINIDISP
        sta $2100,b
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/81B6

    .endsection CopyINIDISPBufferSection


