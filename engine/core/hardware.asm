; Resetting hardware registers to defaults: screen, scrolling, windows, color math,
; mode 7, HDMA, math registers, joypad reading and memory speed.

    .section HardwareResetSection

      .as
      .xl

      rsUnknown809D4F ; 80/9D4F

        .al
        .autsiz
        .databank ?

        ; Run every frame

        jsl rlButtonCombinationResetCheck
        jsl rlDecompressByList
        jsl $809903 ; ?
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
