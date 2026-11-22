; Resetting hardware registers to defaults: screen, scrolling, windows, color math,
; mode 7, HDMA, math registers, joypad reading and memory speed.

    .section HardwareResetSection

      .as
      .xl

      rsRunFrameTasks ; 80/9D4F

        .al
        .autsiz
        .databank ?

        ; Per-frame main loop helper: reset check, decompression queue, deferred sound upload

        ; Run every frame

        jsl rlButtonCombinationResetCheck
        jsl rlDecompressByList
        jsl rlRunDeferredSoundUpload ; ?
        rts

        .databank 0

      rlHardwareResetScreenPosMathHDMA ; 80/9D5C

        .al
        .autsiz
        .databank ?

        ; - set auto joypad read
        ; - disables writable controller IO port
        ; - clear math regs
        ; - clear screen scanline counters
        ; - set fast memory access

        phb
        php

        phk
        plb

        sep #$30
        lda #NMITIMEN_Joypad
        sta NMITIMEN,b
        sta bBufferNMITIMEN

        lda #$80
        sta WRIO,b

        stz WRMPYA,b
        stz WRMPYB,b
        stz WRDIVA,b
        stz WRDIVA+1,b
        stz WRDIVB,b
        stz WRDIVB+1,b

        stz bBufferHTIMEL
        stz HTIME+1,b
        stz bBufferHTIMEH
        
        stz VTIME,b
        stz bBufferVTIMEL
        stz VTIME+1,b
        stz bBufferVTIMEH

        stz MDMAEN,b
        stz HDMAEN,b
        stz bBufferHDMAEN

        lda #MEMSEL_Setting(true)
        sta MEMSEL,b
        sta bBufferMEMSEL

        plp
        plb
        rtl

        .databank 0

      rlHardwareResetScreenRegisters ; 80/9DA3

        .al
        .autsiz
        .databank ?

        ; - reset obsel/oamadd/oamdata
        ; - set BGMode1 with BG3 prio
        ; - clear mosaic/BG VRAM addresses/BG offsets
        ; - clear mode7 regs, windows
        ; - enable BG1 and OBJ layer
        ; - reset color math

        phb
        php

        phk
        plb

        sep #$30
        lda #INIDISP_ForcedBlank
        sta INIDISP,b
        sta bBufferINIDISP

        lda #0
        sta OBSEL,b
        sta bBufferOBSEL

        lda #OAMADD_Setting($010)
        sta OAMADD,b
        sta wBufferOAMADD

        lda #OAMADD_Priority_Setting(false, 0)
        sta OAMADD+1,b
        sta wBufferOAMADD+1

        stz OAMDATA,b
        stz OAMDATA,b

        lda #BGMODE_Setting(BG_Mode1, false, false, false, false, true)
        sta BGMODE,b
        sta bBufferBGMODE

        stz MOSAIC,b
        stz bBufferMOSAIC

        stz BG1SC,b
        stz bBufferBG1SC
        stz BG2SC,b
        stz bBufferBG2SC
        stz BG3SC,b
        stz bBufferBG3SC
        stz BG4SC,b
        stz bBufferBG4SC

        stz BG12NBA,b
        stz bBufferBG12NBA
        stz BG34NBA,b
        stz bBufferBG34NBA

        stz BG1HOFS,b
        stz wBufferBG1HOFS
        stz BG1HOFS,b
        stz wBufferBG1HOFS+1
        stz BG1VOFS,b
        stz wBufferBG1VOFS
        stz BG1VOFS,b
        stz wBufferBG1VOFS+1
        stz BG2HOFS,b
        stz wBufferBG2HOFS
        stz BG2HOFS,b
        stz wBufferBG2HOFS+1
        stz BG2VOFS,b
        stz wBufferBG2VOFS
        stz BG2VOFS,b
        stz wBufferBG2VOFS+1
        stz BG3HOFS,b
        stz wBufferBG3HOFS
        stz BG3HOFS,b
        stz wBufferBG3HOFS+1
        stz BG3VOFS,b
        stz wBufferBG3VOFS
        stz BG3VOFS,b
        stz wBufferBG3VOFS+1
        stz BG4HOFS,b
        stz wBufferBG4HOFS
        stz BG4HOFS,b
        stz wBufferBG4HOFS+1
        stz BG4VOFS,b
        stz wBufferBG4VOFS
        stz BG4VOFS,b
        stz wBufferBG4VOFS+1

        stz VMAIN,b
        stz M7SEL,b
        stz bBufferM7SEL
        stz M7A,b
        stz M7B,b
        stz M7C,b
        stz M7D,b
        stz M7X,b
        stz M7Y,b

        lda #W12SEL_Setting(false, false, false, false, false, false, false, false)
        sta W12SEL,b
        sta bBufferW12SEL

        lda #W34SEL_Setting(false, false, false, false, false, false, false, false)
        sta W34SEL,b
        sta bBufferW34SEL

        stz WOBJSEL,b
        stz bBufferWOBJSEL

        lda #0
        sta WH0,b
        sta bBufferWH0
        lda #-8
        sta WH1,b
        sta bBufferWH1
        stz WH2,b

        stz bBufferWH2
        stz WH3,b
        stz bBufferWH3
        stz WBGLOG,b
        stz bBufferWBGLOG
        stz WOBJLOG,b
        stz bBufferWOBJLOG

        lda #T_Setting(true, false, false, false, true)
        sta TM,b
        sta bBufferTM
        sta TMW,b
        sta bBufferTMW

        lda #T_Setting(false, false, false, false, false)
        sta TS,b
        sta bBufferTS
        sta TSW,b
        sta bBufferTSW

        lda #CGWSEL_Setting(false, true, CGWSEL_MathAlways, CGWSEL_BlackNever)
        sta CGWSEL,b
        sta bBufferCGWSEL

        lda #CGADSUB_Setting(CGADSUB_Subtract, false, true, false, false, false, false, true)
        sta CGADSUB,b
        sta bBufferCGADSUB

        lda #COLDATA_Setting(0, true, false, false)
        sta COLDATA,b
        sta bBufferCOLDATA_1

        lda #COLDATA_Setting(0, false, true, false)
        sta COLDATA,b
        sta bBufferCOLDATA_2

        lda #COLDATA_Setting(0, false, false, true)
        sta COLDATA,b
        sta bBufferCOLDATA_3

        lda #SETINI_Setting(false, false, false, false, false, false)
        sta SETINI,b
        sta bBufferSETINI

        plp
        plb
        rtl

        .databank 0

        ; 80/9DD9

    .endsection HardwareResetSection


    .section Unsorted808C50Section

      .al
      .xl

      rsInitPPURegisters ; 80/8C50

        .al
        .xl
        .autsiz
        .databank ?

        ; FE5: rsInitPPURegisters.

        php
        sep #$20
        lda #$01
        sta $4200,b
        sta bBufferNMITIMEN
        stz $4201,b
        stz $4202,b
        stz $4203,b
        stz $4204,b
        stz $4205,b
        stz $4206,b
        stz $4207,b
        stz $4208,b
        stz $4209,b
        stz $420A,b
        stz $420B,b
        stz $420C,b
        stz $2140,b
        stz $2141,b
        stz $2142,b
        stz $2143,b
        lda #$01
        sta $420D,b
        sta bBufferMEMSEL
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        stz $2101,b
        stz $2102,b
        stz wBufferOAMADD
        lda #$80
        sta $2103,b
        sta wBufferOAMADD+1
        stz $2104,b
        stz $2104,b
        stz $2105,b
        stz $2106,b
        stz bBufferMOSAIC
        stz $2107,b
        stz $2108,b
        stz $2109,b
        stz $210A,b
        stz $210B,b
        stz $210C,b
        stz $210D,b
        stz $210D,b
        stz $210E,b
        stz $210E,b
        stz $210F,b
        stz $210F,b
        stz $2110,b
        stz $2110,b
        stz $2111,b
        stz $2111,b
        stz $2112,b
        stz $2112,b
        stz $2113,b
        stz $2113,b
        stz $2114,b
        stz $2114,b
        stz $2115,b
        stz $211A,b
        stz $211B,b
        stz $211C,b
        stz $211D,b
        stz $211E,b
        stz $211F,b
        stz $2120,b
        stz $2123,b
        stz $2124,b
        stz $2125,b
        stz $2126,b
        stz $2127,b
        stz $2128,b
        stz $2129,b
        stz $212A,b
        stz $212B,b
        stz $212C,b
        stz $212E,b
        stz $212D,b
        stz $212F,b
        stz $2130,b
        stz $2131,b
        lda #$80
        sta $2132,b
        sta bBufferCOLDATA_1
        lda #$40
        sta $2132,b
        sta bBufferCOLDATA_2
        lda #$20
        sta $2132,b
        sta bBufferCOLDATA_3
        stz $2133,b
        plp
        rts

        .databank 0

        ; 80/8D56

    .endsection Unsorted808C50Section


    .section Unsorted80C212Section

      .al
      .xl

      rsResetPPUAndBuffersMode09 ; 80/C212

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Writes direct PPU and buffer defaults (BGMODE=$09, OAMADD=$0010, WH1=$F8, CGWSEL=2, CGADSUB=$A1)

        phb
        php
        phk
        plb
        .databank $80
        sep #$30
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        lda #$00
        sta $2101,b
        sta bBufferOBSEL
        lda #$10
        sta $2102,b
        sta wBufferOAMADD
        lda #$00
        sta $2103,b
        sta wBufferOAMADD+1
        stz $2104,b
        stz $2104,b
        lda #$09
        sta $2105,b
        sta bBufferBGMODE
        stz $2106,b
        stz bBufferMOSAIC
        lda #$00
        sta $2107,b
        sta bBufferBG1SC
        sta $2108,b
        sta bBufferBG2SC
        lda #$00
        sta $2109,b
        sta bBufferBG3SC
        stz $210A,b
        stz bBufferBG4SC
        stz $210B,b
        stz bBufferBG12NBA
        stz $210C,b
        stz bBufferBG34NBA
        stz $210D,b
        stz $210D,b
        stz $210E,b
        stz $210E,b
        stz $210F,b
        stz $210F,b
        stz $2110,b
        stz $2110,b
        stz $2111,b
        stz $2111,b
        stz $2112,b
        stz $2112,b
        stz $2113,b
        stz $2113,b
        stz $2114,b
        stz $2114,b
        stz $2115,b
        stz $211A,b
        stz bBufferM7SEL
        stz $211B,b
        stz $211C,b
        stz $211D,b
        stz $211E,b
        stz $211F,b
        stz $2120,b
        lda #$00
        sta $2123,b
        sta bBufferW12SEL
        lda #$00
        sta $2124,b
        sta bBufferW34SEL
        stz $2125,b
        stz bBufferWOBJSEL
        lda #$00
        sta $2126,b
        sta bBufferWH0
        lda #$F8
        sta $2127,b
        sta bBufferWH1
        stz $2128,b
        stz bBufferWH2
        stz $2129,b
        stz bBufferWH3
        stz $212A,b
        stz bBufferWBGLOG
        stz $212B,b
        stz bBufferWOBJLOG
        lda #$00
        sta $212C,b
        sta bBufferTM
        sta $212E,b
        sta bBufferTMW
        lda #$00
        sta $212D,b
        sta bBufferTS
        sta $212F,b
        sta bBufferTSW
        lda #$02
        sta $2130,b
        sta bBufferCGWSEL
        lda #$A1
        sta $2131,b
        sta bBufferCGADSUB
        lda #$20
        sta $2132,b
        sta bBufferCOLDATA_1
        lda #$40
        sta $2132,b
        sta bBufferCOLDATA_2
        lda #$80
        sta $2132,b
        sta bBufferCOLDATA_3
        lda #$00
        sta $2133,b
        sta bBufferSETINI
        plp
        plb
        .databank $80
        rts

        .databank 0

        ; 80/C32C

    .endsection Unsorted80C212Section


