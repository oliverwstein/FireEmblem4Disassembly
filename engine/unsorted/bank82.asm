; Code from bank $82 not yet assigned to a game system.

    .section Unsorted828431Section

      .al
      .xl

      procUnknown828431 ; 82/8431

        .structProcInfo "UA", rlProcUnknown828431Init, rlProcUnknown828431Cycle, aProcUnknown828431Code

      rlProcUnknown828431Init ; 82/8439

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlProcUnknown828431Cycle ; 82/843A

        .al
        .autsiz
        .databank ?

        stz wR7
        ldx #6

          -
          lda aMovingMapSprites.wActiveSpriteOffset,b,x
          cmp #$FFFF
          beq +

            tay
            lda aActiveSpriteSystem.aUnknown0012E0,b,y
            tsb wR7

          +
          dec x
          dec x
          bpl -

        lda wR7
        bit #$8000
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown828431Code ; 82/845D

        PROC_HALT

    .endsection Unsorted828431Section


    .section Unsorted828A30Section

      .al
      .xl

      procUnknown828A30 ; 82/8A30

        .structProcInfo "TT", rlProcUnknown828A30Init, rlProcUnknown828A30Cycle1, $828A86

        .word 0

      rlProcUnknown828A30Init ; 82/8A3A

        .al
        .autsiz
        .databank ?

        ldy wActiveEventOffset,b
        lda lActiveEventPointer,b
        sta @l lR22
        lda lActiveEventPointer+1,b
        sta @l lR22+1
        lda [lR22],y
        sta aProcSystem.aBody0,b,x
        rtl

        .databank 0

      rlProcUnknown828A30Cycle1 ; 82/8A51

        .al
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #INIDISP_Brightness
        cmp #INIDISP_Setting(false, 0)
        bne _End

          lda aProcSystem.aBody0,b,x
          bit #$0080
          bne +

            lda #<>rlProcUnknown828A30Cycle2
            sta aProcSystem.aHeaderOnCycle,b,x
            bra _End

          +
          lda bBufferINIDISP
          bit #INIDISP_ForcedBlank
          bne _End

            jsl rlEventEngineFreeProc

        _End
        rtl

        .databank 0

      rlProcUnknown828A30Cycle2 ; 82/8A77

        .al
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #INIDISP_Brightness
        cmp #INIDISP_Setting(false, 15)
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown828A30Code ; 82/8A86

        PROC_HALT

      procUnknown828A88 ; 82/8A88

        .structProcInfo "LL", rlProcUnknown828A88Init, $82899F, $828A1A

        .word 0

      rlProcUnknown828A88Init ; 82/8A92

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      procUnknown828A93 ; 82/8A93

        .structProcInfo "TT", rlProcUnknown828A93Init, rlProcUnknown828A93Cycle1, aProcUnknown828A93Code

        .word 0

      rlProcUnknown828A93Init ; 82/8A9D

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlProcUnknown828A93Cycle1 ; 82/8A9E

        .al
        .autsiz
        .databank ?

        lda bUnknown000E7B,b
        bit #$0001
        bne +

          lda #4
          sta aProcSystem.aBody0,b,x
          lda #<>rlProcUnknown828A93Cycle2
          sta aProcSystem.aHeaderOnCycle,b,x

        +
        rtl

        .databank 0

      rlProcUnknown828A93Cycle2 ; 82/8AB3

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        dec a
        sta aProcSystem.aBody0,b,x
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown828A93Code ; 82/8AC1

        PROC_HALT

      procUnknown828AC3 ; 82/8AC3

        .structProcInfo "ME", rlProcUnknown828AC3Init, rlProcUnknown828AC3Cycle, aProcUnknown828AC3Code

        .word 0

      rlProcUnknown828AC3Init ; 82/8ACD

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlUnknown828ACE ; 82/8ACE

        .al
        .autsiz
        .databank ?

        lda #1
        sta aDialogue.wTextSound,b

        lda aDialogue.wStatus,b
        bit #DialogueStatusEnabled
        beq +

          lda #<>rlProcUnknown828AC3Cycle
          sta aProcSystem.aHeaderOnCycle,b,x

        +
        rtl

        .databank 0

      rlProcUnknown828AC3Cycle ; 82/8AE3

        .al
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        bit #DialogueStatusEnabled
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown828AC3Code ; 82/8AF0

        PROC_HALT

      procUnknown828AF2 ; 82/8AF2

        .structProcInfo "ME", rlProcUnknown828AF2Init, rlProcUnknown828AF2Cycle, aProcUnknown828AF2Code

        .word 0

      rlUnknown828AFC ; 82/8AFC

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlUnknown828AFD ; 82/8AFD

        .al
        .autsiz
        .databank ?

        lda $04BA,b
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcCodeUnknown828B07 ; 82/8B07

        PROC_HALT

      procUnknown828AD9 ; 82/8AD9

        .structProcInfo "ME", rlProcUnknown828AF2Init, rlProcUnknown828AF2Cycle, aProcUnknown828AF2Code

        .word 0

      rlProcUnknown828AF2Init ; 82/8B13

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlProcUnknown828AF2Cycle ; 82/8B14
      
        .al
        .autsiz
        .databank ?

        lda #(`procUnknown9EC70B)<<8
        sta lR44+1
        lda #<>procUnknown9EC70B
        sta lR44
        jsl rlProcEngineFindProc
        bcs +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown828AF2Code ; 82/8B29

        PROC_HALT

      ; 82/8B2B

    .endsection Unsorted828A30Section


    .section Unsorted828B2BSection

      .as
      .xl

      procUnknown828B2B .structProcInfo "ME", rlProcUnknown828B2BInit, rlProcUnknown828B2BCycle, aProcUnknown828B2BCode ; 82/8B2B

        .word 0

    .endsection Unsorted828B2BSection


    .section Unsorted828B35Section

      .al
      .xl

      rlProcUnknown828B2BInit ; 82/8B35

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlProcUnknown828B2BCycle ; 82/8B36

        .al
        .autsiz
        .databank ?

        lda $7F4C07
        bit #$0002
        beq +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown828B2BCode ; 82/8B44

        PROC_HALT

        ; 82/8B46

    .endsection Unsorted828B35Section


    .section Unsorted828BEASection

      .as
      .xl

      procUnknown828BEA  ; 82/8BEA

        .structProcInfo "CC", rlProcUnknown828BEAInit, rlProcUnknown828BEACycle, $828CA1
        .word 0

    .endsection Unsorted828BEASection


    .section Unsorted828BF4Section

      .al
      .xl

      rlProcUnknown828BEAInit ; 82/8BF4

        .al
        .autsiz
        .databank ?

        ldy wActiveEventOffset,b
        sep #$20
        lda [lR22],y
        sta aProcSystem.aBody0,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody0+1,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody2,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody1,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody1+1,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody2+1,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody3,b,x
        rep #$20
        inc y
        lda [lR22],y
        sta aProcSystem.aBody6,b,x
        inc y
        inc y
        lda [lR22],y
        sta aProcSystem.aBody7,b,x

        stz aProcSystem.aBody4,b,x
        stz aProcSystem.aBody5,b,x
        rtl

        .databank 0

      rlProcUnknown828BEACycle ; 82/8C38

        .al
        .autsiz
        .databank ?

        ldx aProcSystem.wOffset,b
        jsl rlUnknown91A4AC

        lda aProcSystem.aBody4,b,x
        cmp aProcSystem.aBody3,b,x
        bcs +

          inc a
          sta aProcSystem.aBody4,b,x
          rtl

        +
        lda aProcSystem.aBody5,b,x
        beq +

          sep #$20
          lda aProcSystem.aBody0,b,x
          sta lR18
          lda aProcSystem.aBody0+1,b,x
          sta lR18+1
          lda aProcSystem.aBody2,b,x
          sta lR18+2
          bra ++

          +
          sep #$20
          lda aProcSystem.aBody1,b,x
          sta lR18
          lda aProcSystem.aBody1+1,b,x
          sta lR18+1
          lda aProcSystem.aBody2+1,b,x
          sta lR18+2

        +
        rep #$20
        ldy aProcSystem.aBody6,b,x
        phy
        tya
        clc
        adc aProcSystem.aBody7,b,x
        sta wR0
        plx

          -
          lda [lR18],y
          sta aBGPaletteBuffer,x
          inc x
          inc x
          inc y
          inc y
          cpy wR0
          bcc -

        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody5,b,x
        eor #1
        sta aProcSystem.aBody5,b,x
        stz aProcSystem.aBody4,b,x
        rtl

        .databank 0

      aProcUnknown828BEACode ; 82/8CA1

        PROC_HALT

      procUnknown828CA3 ; 82/8CA3

        .structProcInfo "BM", rlProcUnknown828CA3Init, rlProcUnknown828CA3Cycle, aProcUnknown828CA3Code
        .word 0

      rlProcUnknown828CA3Init ; 82/8CAD

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #$01
        ora bBufferTM
        sta bBufferTM
        lda #$01
        ora bBufferTMW
        sta bBufferTMW
        rep #$20

        stz aProcSystem.aBody0,b,x

        lda wMapScrollXPixels,b
        sta wBufferBG1HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG1VOFS
        rtl

        .databank 0

      rlProcUnknown828CA3Cycle ; 82/8CCB

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        cmp #2
        beq _8D01

          cmp #1
          beq +

            lda bBufferINIDISP
            bit #$0080
            bne _8CF3

              ora #$0080
              sta bBufferINIDISP

              lda #1
              sta aProcSystem.aBody0,b,x
              bra _8D05

          +
          lda bBufferINIDISP
          eor #$0080
          sta bBufferINIDISP

          _8CF3
          phx
          jsl $888082
          plx
          lda #2
          sta aProcSystem.aBody0,b,x
          bra _8D05
        
        _8D01
        jsl rlUnknown888560

        _8D05
        ldx aProcSystem.wOffset,b
        jsl rlUnknown91A4AC
        bcc +

          jsr rsUnknown828D12

        +
        rtl

        .databank 0

      rsUnknown828D12 ; 82/8D12

        .al
        .autsiz
        .databank ?

        lda bBufferTM
        eor #$0001
        sta bBufferTM
        ldx aProcSystem.wOffset,b
        jsr rsProcCodeEnd

      aProcUnknown828CA3Code ; 82/8D1F

        PROC_HALT

        ; 82/8D21

    .endsection Unsorted828BF4Section


    .section Unsorted828D52Section

      .al
      .xl

      procUnknown828D52 ; 82/8D52

        .structProcInfo "MS", rlProcUnknown828D52Init, rlProcUnknown828D52Cycle, aProcUnknown828D52Code
        .word 0

      rlProcUnknown828D52Init ; 82/8D5C

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        lda #0
        sta aProcSystem.aBody2,b,x
        ldy wActiveEventOffset,b
        lda [lR22],y
        sta aProcSystem.aBody0,b,x
        inc y
        inc y
        lda [lR22],y
        and #$00FF
        sta aProcSystem.aBody1,b,x
        jsr rsUnknown828E61
        bcs +

          lda #0
          sta aProcSystem.aBody1,b,x

        +
        plp
        rtl

        .databank 0

      rlProcUnknown828D52Cycle ; 82/8D84

        .al
        .autsiz
        .databank ?

        php
        phb
        lda $0302,b
        cmp #$0012
        beq +

          cmp #$000F
          bne _End

        +
        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody6,b,x
        inc a
        sta aProcSystem.aBody6,b,x
        cmp aProcSystem.aBody3,b,x
        beq _8DE8

        sta wR12
        lda #0
        sta wR13
        lda $175F,b
        sta wR10
        lda $1761,b
        sta wR11
        jsl rlUnsignedMultiply32By32

        ldx aProcSystem.wOffset,b
        lda wR15
        sec
        sbc aProcSystem.aBody5,b,x
        sta wMapScrollSpeed,b
        lda wR15
        sta aProcSystem.aBody5,b,x

        lda aProcSystem.aBody7,b,x
        sta wR0

        lda wR0
        cmp #9
        bmi +

          -
          bra -

        +
        asl a
        tax
        jsr (aUnknown828E1F,x)

        lda wMapScrollXPixels,b
        sta wBufferBG1HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG1VOFS

        _End
        plb
        plp
        rtl

        _8DE8
        lda aProcSystem.aBody4,b,x
        sec
        sbc aProcSystem.aBody5,b,x
        sta wMapScrollSpeed,b

        lda aProcSystem.aBody7,b,x
        sta wR0

        lda wR0
        cmp #9
        bmi +

          -
          bra -

        +
        asl a
        tax
        jsr (aUnknown828E1F,x)
        jsr rsUnknown828E61
        bcs _End

        jsl $88BF97
        bcc +

          lda #$0080
          sta wCursorXOffset,b
          sta wCursorYOffset,b

        +
        jsl rlEventEngineFreeProc
        bra _End

        .databank 0

      aUnknown828E1F ; 82/8E1F

        .addr rsUnknown828E31
        .addr rsUnknown828E36
        .addr rsUnknown828E3B
        .addr rlUnknown828E40
        .addr rsUnknown828E45
        .addr rsUnknown828E4A
        .addr rsUnknown828E4F
        .addr rsUnknown828E54
        .addr rsUnknown828E59

      rsUnknown828E31 ; 82/8E31

        .al
        .autsiz
        .databank ?

        jsl $8885D3
        rts
 
        .databank 0

      rsUnknown828E36 ; 82/8E36

        .al
        .autsiz
        .databank ?

        jsl $8885E1
        rts

        .databank 0

      rsUnknown828E3B ; 82/8E3B

        .al
        .autsiz
        .databank ?

        jsl $8885EF
        rts

        .databank 0

      rlUnknown828E40 ; 82/8E40

        .al
        .autsiz
        .databank ?

        jsl $8885FD
        rts

        .databank 0

      rsUnknown828E45 ; 82/8E45

        .al
        .autsiz
        .databank ?

        jsl $88860B
        rts

        .databank 0

      rsUnknown828E4A ; 82/8E4A

        .al
        .autsiz
        .databank ?

        jsl $88861C
        rts

        .databank 0

      rsUnknown828E4F ; 82/8E4F

        .al
        .autsiz
        .databank ?

        jsl $88862D
        rts

        .databank 0

      rsUnknown828E54 ; 82/8E54

        .al
        .autsiz
        .databank ?

        jsl $88863E
        rts

        .databank 0

      rsUnknown828E59 ; 82/8E59

        .al
        .autsiz
        .databank ?

        jsl rlUnknown828E5E
        rts

        .databank 0

      rlUnknown828E5E ; 82/8E5E

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aProcUnknown828D52Code ; 82/8E5F

        PROC_HALT

    .endsection Unsorted828D52Section


    .section Unsorted828E61Section

      .as
      .xl

      rsUnknown828E61 ; 82/8E61

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody1,b,x
        xba
        sta lR18+1
        lda aProcSystem.aBody0,b,x
        sta lR18
        ldy aProcSystem.aBody2,b,x

        lda [lR18],y
        cmp #$00FF
        beq _CLC

          lda [lR18],y
          sta aProcSystem.aBody7,b,x
          inc y
          inc y
          lda [lR18],y
          sta aProcSystem.aBody4,b,x
          sta wR13
          inc y
          inc y
          lda [lR18],y
          sta aProcSystem.aBody3,b,x
          sta wR14

          lda aProcSystem.aBody7,b,x
          cmp #8
          bne +

            stz aProcSystem.aBody4,b,x

          +
          inc y
          inc y
          tya
          sta aProcSystem.aBody2,b,x
          lda #0
          sta wR12
          sta wR15
          jsl $80A1D8

          lda wR12
          sta $175F,b
          lda wR13
          sta $1761,b
          ldx aProcSystem.wOffset,b
          lda #0
          sta aProcSystem.aBody5,b,x
          sta aProcSystem.aBody6,b,x
          plp
          sec
          rts

        _CLC
        plp
        clc
        rts

        .databank 0

    .endsection Unsorted828E61Section


    .section Unsorted828ECBSection

      .al
      .xl

      procUnknown828ECB ; 82/8ECB

        .structProcInfo "CM", rlProcUnknown828ECBInit, rlProcUnknown828ECBCycle, aProcUnknown828ECBCode
        .word 0

      rlProcUnknown828ECBInit ; 82/8ED5

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #$01
        ora bBufferTM
        sta bBufferTM
        lda #$01
        ora bBufferTMW
        sta bBufferTMW
        rep #$20
        stz aProcSystem.aBody0,b,x
        rtl

        .databank 0

      rlProcUnknown828ECBCycle ; 82/8EE9

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        cmp #2
        beq _8F1F

          cmp #1
          beq +

            lda bBufferINIDISP
            bit #$0080
            bne _8F11

              ora #$0080
              sta bBufferINIDISP

              lda #1
              sta aProcSystem.aBody0,b,x
              bra _8F23

          +
          lda bBufferINIDISP
          eor #$0080
          sta bBufferINIDISP

          _8F11
          phx
          jsl $8883C7
          plx
          lda #2
          sta aProcSystem.aBody0,b,x
          bra _8F23

        _8F1F
        jsl $80B63F

        _8F23
        ldx aProcSystem.wOffset,b
        jsl rlUnknown91A4AC
        bcc +

          jsr rsUnknown828F30

        +
        rtl

        .databank 0

      rsUnknown828F30 ; 82/8F30

        .al
        .autsiz
        .databank ?

        lda bBufferTM
        eor #$0001
        sta bBufferTM
        ldx aProcSystem.wOffset,b
        jsr rsProcCodeEnd

        .databank 0

      aProcUnknown828ECBCode ; 82/8F3D

        PROC_HALT

        ; 82/8F3F

    .endsection Unsorted828ECBSection


    .section Unsorted829245Section

      .al
      .xl

      procUnknown829245 ; 82/9245

        .structProcInfo "e0", rlProcUnknown829245Init, rlProcUnknown829245Cycle, aProcUnknown829245Code
        .word 2

      rlProcUnknown829245Init ; 82/924F

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlProcUnknown829245Cycle ; 82/9250

        .al
        .autsiz
        .databank ?

        lda wJoy1New
        bit #JOY_ABXY
        beq +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown829245Code ; 82/925C

        PROC_HALT

      procUnknown82925E ; 82/925E

        .structProcInfo "e0", rlProcUnknown82925EInit, rlProcUnknown82925ECycle, aProcUnknown82925ECode
        .word 2

      rlProcUnknown82925EInit ; 82/9268

        .al
        .autsiz
        .databank ?

        ldy wActiveEventOffset,b
        lda [lR22],y
        sta aProcSystem.aBody0,b,x
        rtl

        .databank 0

      rlProcUnknown82925ECycle ; 82/9271

        .al
        .autsiz
        .databank ?

        dec aProcSystem.aBody0,b,x
        beq +

          lda wJoy1New
          bit #JOY_ABXY
          bne +

            rtl

        +
        jsl rlEventEngineFreeProc
        rtl

        .databank 0

      aProcUnknown82925ECode ; 82/9283

        PROC_HALT

    .endsection Unsorted829245Section


    .section Unsorted8292A9Section

      .al
      .xl

      procUnknown8292A9 ; 82/92A9

        .structProcInfo "NP", rlProcUnknown8292A9Init, rlProcUnknown8292A9Init, aProcUnknown8292A9Code
        .word 0

    .endsection Unsorted8292A9Section


    .section Unsorted8292B3Section

      .al
      .xl

      rlProcUnknown8292A9Init ; 82/92B3

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aProcUnknown8292A9Code ; 82/92B4

        PROC_END

      procUnknown8292B6 ; 82/92B6

        .structProcInfo "RS", rlProcUnknown8292B6Init, rlProcUnknown8292B6Cycle, aProcUnknown8292B6Code ; 82/92A9
        .word 0

      rlProcUnknown8292B6Init ; 82/92C0

        .al
        .autsiz
        .databank ?

        php
        ldy wActiveEventOffset,b
        lda [lR22],y
        sta aProcSystem.aBody0,b,x
        inc y
        lda [lR22],y
        sta aProcSystem.aBody1,b,x
        inc y
        inc y
        lda [lR22],y
        and #$00FF
        sta aProcSystem.aBody2,b,x
        cmp #$00FF
        bne +

          ldx aProcSystem.wOffset,b
          jsl rlUnknown91A4AC

        +
        lda #$FFFF
        sta aProcSystem.aBody5,b,x
        plp
        rtl

        .databank 0

      rlProcUnknown8292B6Cycle ; 82/92ED

        .al
        .autsiz
        .databank ?

        php
        jsr rsUnknown829306
        bcc +

          jsr rsUnknown82932C
          bcc +

            lda #0
            sta aProcSystem.aBody2,b,x
            jsl rlEventEngineFreeProc

        +
        plp
        rtl

        .databank 0

      aProcUnknown8292B6Code ; 82/9304

        PROC_HALT

      rsUnknown829306 ; 82/9306

        .al
        .autsiz
        .databank ?

        php
        phx
        lda aProcSystem.aBody5,b,x
        cmp #$FFFE
        beq _SEC

          cmp #$FFFF
          bne +

            dec a
            sta aProcSystem.aBody5,b,x
            bra _CLC

          +
          tax
          lda aProcSystem.aHeaderBitfield,b,x
          bit #$2000
          bne _SEC

          _CLC
          plx
          plp
          clc
          rts
        
        _SEC
        plx
        plp
        sec
        rts

        .databank 0

    .endsection Unsorted8292B3Section


    .section Unsorted82932CSection

      .al
      .xl

      rsUnknown82932C ; 82/932C

        .al
        .autsiz
        .databank ?

        php
        lda aProcSystem.aBody2,b,x
        beq _SEC

          cmp #$00FF
          beq +

            dec a
            sta aProcSystem.aBody2,b,x

          +
          lda lActiveEventPointer,b
          sta aProcSystem.aBody3,b,x
          lda wActiveEventOffset,b
          sta aProcSystem.aBody4,b,x
          jsr rsUnknown829391

          ldy #0
          sty wActiveEventOffset,b
          lda lActiveEventPointer+1,b
          sta @l lR22+1
          lda aProcSystem.aBody0,b,x
          sta lActiveEventPointer,b
          sta @l lR22
          phx

          lda [lR22],y
          sta lR23
          inc y
          inc y
          sty wActiveEventOffset,b
          jsl rlUnknown91C6D8

          txa
          plx
          lda aProcSystem.aBody3,b,x
          sta lActiveEventPointer,b
          lda aProcSystem.aBody4,b,x
          sta wActiveEventOffset,b
          lda lActiveEventPointer+1,b
          sta @l lR22+1
          lda lActiveEventPointer,b
          sta @l lR22
          plp
          clc
          rts

        _SEC
        plp
        sec
        rts

        .databank 0

    .endsection Unsorted82932CSection


    .section Unsorted829391Section

      .al
      .xl

      rsUnknown829391 ; 82/9391

        .al
        .autsiz
        .databank ?

        ; Store first free proc offset into aBody5

        phx
        ldx #$001E

        -
        lda aProcSystem.aHeaderTypeOffset,b,x
        beq _CLC

          dec x
          dec x
          bpl -

          lda #$FFFF
          plx
          sta aProcSystem.aBody5,b,x
          sec
          rts

        _CLC
        txa
        plx
        sta aProcSystem.aBody5,b,x
        clc
        rts

        .databank 0

      procUnknown8293AE

        .structProcInfo "CC", rlProcUnknown8293AEInit, rlProcUnknown8293AECycle, aProcUnknown8293AECode ; 82/93AE
        .word 0

      rlProcUnknown8293AEInit ; 82/93B8

        .al
        .autsiz
        .databank ?

        ldy wActiveEventOffset,b
        lda [lR22],y
        sta aProcSystem.aBody0,b,x
        inc y
        lda [lR22],y
        and #$FF00
        sta aProcSystem.aBody2,b,x

        inc y
        inc y
        lda [lR22],y
        sta lR19
        inc y
        inc y

        sep #$20
        lda [lR22],y
        sta aProcSystem.aBody2,b,x
        sta lR19+2
        rep #$20

        lda [lR19]
        and #$00FF
        asl a
        sta aProcSystem.aBody5,b,x

        inc lR19
        lda [lR19]
        and #$00FF
        asl a
        sta aProcSystem.aBody6,b,x

        lda lR19
        inc a
        sta aProcSystem.aBody1,b,x

        stz aProcSystem.aBody3,b,x
        lda #1
        sta aProcSystem.aBody4,b,x

        ldx aProcSystem.wOffset,b
        jsl rlUnknown91A4AC
        rtl

        .databank 0

      rlProcUnknown8293AECycle ; 82/9407

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody4,b,x
        dec a
        beq +

          sta aProcSystem.aBody4,b,x
          rtl

        +
        lda aProcSystem.aBody2,b,x
        sta lR18+1
        xba
        sta lR19+1

        lda aProcSystem.aBody0,b,x
        sta lR18
        lda aProcSystem.aBody1,b,x
        sta lR19

        lda aProcSystem.aBody3,b,x
        inc a
        inc a
        
          -
          sta aProcSystem.aBody3,b,x
          tay
          lda [lR19],y
          bit #$FF00
          bne +

            lda #0
            bra -

        +
        phx
        sep #$20
        xba
        sta aProcSystem.aBody4,b,x
        rep #$20
        xba
        and #$00FF
        asl a
        clc
        adc lR18
        sta lR18

        lda #0
        sta lR20+1

        lda #<>aBGPaletteBuffer
        clc
        adc aProcSystem.aBody5,b,x
        sta lR20

        lda aProcSystem.aBody6,b,x
        tay

          -
          lda [lR18],y
          sta [lR20],y
          dec y
          dec y
          bne -

        plx
        rtl

        .databank 0

      aProcUnknown8293AECode ; 82/9467

        PROC_HALT

        ; 82/9469

    .endsection Unsorted829391Section


    .section Unsorted82E073Section

      .al
      .xl

      rlUnknown82E073 ; 82/E073

        .al
        .autsiz
        .databank ?

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
        jsl rlUnknown82E0AF
        plb
        plp
        rtl

        .databank 0

        ; 82/E08D

    .endsection Unsorted82E073Section


    .section Unsorted82E0AFSection

      .al
      .xl

      rlUnknown82E0AF ; 82/E0AF

        .al
        .autsiz
        .databank ?

        sei
        sep #$20
        lda bBufferNMITIMEN
        and #$CF
        sta bBufferNMITIMEN
        rep #$20

        lda #$8000
        tsb $168F,b
        lda #$8222
        sta wIRQPointer
        rtl

        .databank 0

        ; 82/E0C6

    .endsection Unsorted82E0AFSection


    .section Unsorted82E400Section

      .al
      .xl

      rlUnknown82E400 ; 82/E400

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        ldx #$0021
        lda #0
        
          -
          sta lStructPointer1,b,x
          dec x
          dec x
          bpl -

        lda #$0010
        sta wUnknown00056B,b
        plp
        plb
        rtl

        .databank 0

        ; 82/E41A

    .endsection Unsorted82E400Section


    .section Unsorted82F211Section

      .al
      .xl

      rlUnknown82F211 ; 82/F211

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        sep #$20
        ldx #9
        lda #0
        
          -
          sta $0540,b,x
          dec x
          bpl -

        rep #$20
        plp
        plb
        rtl

        .databank 0

        ; 82/F227

    .endsection Unsorted82F211Section


    .section Unsorted82F3E5Section

      .al
      .xl

      rlUnknown82F3E5 ; 82/F3E5

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        ldy $0547,b
        sep #$20
        lda $0547+2,b
        pha
        rep #$20
        plb

        sep #$20
        lda $0000,b,y
        sta wR2
        lda $0001,b,y
        sta wR2+1
        rep #$20

        jsl $82F3BE
        ora #$0000
        beq _F463

        sta wR5
        ldx #1
        
        _Loop
        txa
        jsl $82F3C7
        phk
        plb

        ldy $0540,b
        sep #$20
        lda $0542,b
        pha
        rep #$20
        plb

        sep #$20
        lda $0003,b,y
        clc
        adc wR2
        sta wR3

        lda $0004,b,y
        clc
        adc wR2+1
        sta wR4

        lda $0005,b,y
        sta wR3+1
        lda $0006,b,y
        sta wR4+1

        lda wR0
        sec
        sbc wR3
        cmp wR3+1
        bcs +

        lda wR1
        sec
        sbc wR4
        cmp wR4+1
        bcs +

        rep #$20
        jsl rlUnknown82F46D
        bra _F468

        +
        rep #$20
        inc x
        dec wR5
        bne _Loop

        _F463
        ply
        plx
        plp
        plb
        rtl
        
        _F468
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown82F46D ; 82/F46D

        .al
        .autsiz
        .databank ?

        lda lR18
        pha
        lda lR18+1
        pha

        jsl rlUnknown82F488
        ldx #$0024
        lda #0
        jsl $80A861

        pla
        sta lR18+1
        pla
        sta lR18
        rtl

        .databank 0

      rlUnknown82F488 ; 82/F488

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        ldx $0540,b
        sep #$20
        lda $0540+2,b
        pha
        rep #$20
        plb

        lda $0000,b,x
        sta lR18
        lda $0001,b,x
        sta lR18+1

        plx
        plp
        plb
        rtl

        .databank 0

        ; 82/F4A7

    .endsection Unsorted82F3E5Section
