; Code from bank $82 not yet assigned to a game system.

    .section Unsorted8283EBSection

      .al
      .xl

      rlProcUnknown8283E3Init ; 82/83EB

        .al
        .xl
        .autsiz
        .databank ?

        lda $0ECF,b
        sta $0FD7,b,x
        lda $0ED1,b
        jsl rlUnknown808FA3
        rtl

        .databank 0

        ; 82/83F9

      rlProcUnknown8283E3Cycle1 ; 82/83F9

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 82/83FA

    .endsection Unsorted8283EBSection


    .section Unsorted8283FASection

      .al
      .xl

      rlProcUnknown8283E3Cycle2 ; 82/83FA

        .al
        .xl
        .autsiz
        .databank ?

        lda $04BA,b
        bne _841E
        lda $04F6,b
        bit #$0030
        bne _841E
        lda $0FD7,b,x
        cmp $0510,b
        beq _841A
        sta $04BA,b
        lda #$841F
        sta $0F57,b,x
        bra _841E


        _841A
        jsl rlProcEngineFreeProc

        _841E
        rtl

        .databank 0

        ; 82/841F

    .endsection Unsorted8283FASection


    .section ProcScript828429Section

      .al
      .xl

      aProcUnknown8283E3Code ; 82/8429

        PROC_YIELD 3
        PROC_SET_ONCYCLE rlProcUnknown8283E3Cycle2
        PROC_HALT


        ; 82/8431

    .endsection ProcScript828429Section


    .section Unsorted828648Section

      .al
      .xl

      rlUnknown828648 ; 82/8648

        .al
        .xl
        .autsiz
        .databank ?

        php
        jsl rlUnknown828653
        jsl rlGetDialogueBoxGraphicsAndPalette
        plp
        rtl

        .databank 0

        ; 82/8653

    .endsection Unsorted828648Section


    .section Unsorted82886FSection

      .al
      .xl

      rlProcUnknown828865Init ; 82/886F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0200
        sta wEventProcBanks,b,x
        rtl

        .databank 0

        ; 82/8876

      rlProcUnknown828865Cycle ; 82/8876

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0200
        sta wEventProcBanks,b,x
        lda wUnknown00171A,b
        beq _8888
        lda wJoy1New
        bit #$1000
        beq _88B1

        _8888
        stz $0302,b
        lda #$88B2
        sta $0F57,b,x
        lda $04EA,b
        pha
        and #$FFFA
        sta $04EA,b
        lda #$000A
        jsl rlUnknown808FAD
        pla
        sta $04EA,b
        jsl rlClearAllFadeInProcs
        lda #$00E1
        jsl rlUnknown808FA3

        _88B1
        rtl

        .databank 0

        ; 82/88B2

    .endsection Unsorted82886FSection


    .section ProcScript8288E7Section

      .al
      .xl

      aProcUnknown828865Code ; 82/88E7

        PROC_HALT


        ; 82/88E9

      procUnknown8288E9 ; 82/88E9

        .structProcInfo "TT", rlProcUnknown8288E9Init, rlProcDialogueWithBGCycle1, aProcDialogueWithBGCode

    .endsection ProcScript8288E7Section


    .section Unsorted8288F3Section

      .al
      .xl

      rlProcUnknown8288E9Init ; 82/88F3

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        ldy #$0000
        lda $0FD7,b
        sta @l lR22
        lda $0FF7,b
        sta @l lR22+1
        bra $828921

        .databank 0

        ; 82/8906

    .endsection Unsorted8288F3Section


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


    .section Unsorted82F227Section

      .al
      .xl

      rlUnknown82F227 ; 82/F227

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $82
        lda wR0
        pha
        lda wR1
        pha
        phx
        phy
        ldx lUnknown0540,b
        sep #$20
        lda lUnknown0540+2,b
        pha
        rep #$20
        plb
        .databank ?
        sep #$20
        lda $0002,b,x
        asl a
        clc
        adc $0002,b,x
        rep #$20
        and #$00FF
        clc
        adc #$0009
        jsl rlAllocateRAMArea
        sep #$20
        ldy #$0000
        lda $0000,b,x
        sta [lR25],y
        ldy #$0001
        lda $0001,b,x
        sta [lR25],y
        rep #$20
        ldy #$0002
        lda $0547,b
        sta [lR25],y
        ldy #$0003
        lda $0548,b
        sta [lR25],y
        lda lR25+1
        sta lR18+1
        lda lR25
        clc
        adc #$0005
        sta lR18
        lda $0002,b,x
        and #$00FF
        sta wR0
        lda #$0003
        sta wR1
        jsl rlBuildRAMStructHeader
        lda lR25
        sta @l $000547
        lda lR25+1
        sta @l $000548
        lda $0003,b,x
        and #$00FF
        beq _F2D8
        sta wR0

        _F2AD
        lda $0004,b,x
        and #$00FF
        sta $0543,b
        lda $0005,b,x
        and #$00FF
        sta $0545,b
        lda $0006,b,x
        sta lUnknown0540,b
        lda $0007,b,x
        sta lUnknown0540+1,b
        jsl rlUnknown82F343
        inc x
        inc x
        inc x
        inc x
        inc x
        dec wR0
        bne _F2AD

        _F2D8
        ply
        plx
        pla
        sta wR1
        pla
        sta wR0
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 82/F2E3

    .endsection Unsorted82F227Section


    .section Unsorted82F2E3Section

      .al
      .xl

      rlUnknown82F2E3 ; 82/F2E3

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $82
        lda wR0
        pha
        lda $0547,b
        ora $0548,b
        beq _F33D
        jsl rlUnknown82F3BE
        ora #$0000
        beq _F315
        sta wR0

        _F2FD
        lda wR0
        jsl rlUnknown82F3C7
        lda lUnknown0540,b
        sta lR25
        lda lUnknown0540+1,b
        sta lR25+1
        jsl rlRemoveRAMAreaEntry
        dec wR0
        bne _F2FD

        _F315
        lda $0547,b
        sta lR25
        lda $0548,b
        sta lR25+1
        jsl rlRemoveRAMAreaEntry
        ldy $0547,b
        sep #$20
        lda $0549,b
        pha
        rep #$20
        plb
        .databank ?
        lda $0002,b,y
        sta @l $000547
        lda $0003,b,y
        sta @l $000548

        _F33D
        pla
        sta wR0
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 82/F343

    .endsection Unsorted82F2E3Section


    .section Unsorted82F343Section

      .al
      .xl

      rlUnknown82F343 ; 82/F343

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $82
        phx
        phy
        lda #$0007
        jsl rlAllocateRAMArea
        ldx lUnknown0540,b
        sep #$20
        lda lUnknown0540+2,b
        pha
        rep #$20
        plb
        .databank ?
        ldy #$0000
        lda lUnknown0540,b
        sta [lR25],y
        ldy #$0001
        lda lUnknown0540+1,b
        sta [lR25],y
        sep #$20
        ldy #$0003
        lda $0543,b
        sta [lR25],y
        ldy #$0004
        lda $0545,b
        sta [lR25],y
        ldy #$0005
        lda $0003,b,x
        sta [lR25],y
        ldy #$0006
        lda $0004,b,x
        sta [lR25],y
        rep #$20
        jsl rlUnknown82F3A7
        lda lR25
        sta lStructPointer1,b
        lda lR25+1
        sta lStructPointer1+1,b
        jsl rlAppendNewStructEntry
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 82/F3A7

    .endsection Unsorted82F343Section


    .section Unsorted82F3A7Section

      .al
      .xl

      rlUnknown82F3A7 ; 82/F3A7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $82
        lda $0548,b
        sta lStructPointer2+1,b
        lda $0547,b
        clc
        adc #$0005
        sta lStructPointer2,b
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/F3BE

      rlUnknown82F3BE ; 82/F3BE

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown82F3A7
        jsl rlGetRAMStructCurrentStructCount
        rtl

        .databank 0

        ; 82/F3C7

      rlUnknown82F3C7 ; 82/F3C7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $82
        sta wStructIndex,b
        jsl rlUnknown82F3A7
        jsl rlLoadRAMStructDataByIndex
        lda lStructPointer1,b
        sta lUnknown0540,b
        lda lStructPointer1+1,b
        sta lUnknown0540+1,b
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/F3E5

    .endsection Unsorted82F3A7Section


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

        jsl rlUnknown82F3BE
        ora #$0000
        beq _F463

        sta wR5
        ldx #1
        
        _Loop
        txa
        jsl rlUnknown82F3C7
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
        jsl rlUnknown80A861

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


    .section Unsorted82F4A7Section

      .al
      .xl

      rlUnknown82F4A7 ; 82/F4A7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $82
        phx
        ldx lUnknown0540,b
        sep #$20
        lda lUnknown0540+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda $0003,b,x
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 82/F4BF

    .endsection Unsorted82F4A7Section
