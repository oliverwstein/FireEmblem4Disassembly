; Code from bank $82 not yet assigned to a game system.

    .section Unsorted8283EBSection

      .al
      .xl

      rlProcUnknown8283E3Init ; 82/83EB

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        lda aProcSystem.wInput1,b
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
        lda aProcSystem.aBody0,b,x
        cmp $0510,b
        beq _841A
        sta $04BA,b
        lda #<>rlUnknown82841F
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _841E


        _841A
        jsl rlProcEngineFreeProc

        _841E
        rtl

        .databank 0

        ; 82/841F

    .endsection Unsorted8283FASection


    .section Unsorted82841FSection

      .al
      .xl

      rlUnknown82841F ; 82/841F

        .al
        .xl
        .autsiz
        .databank ?

        lda $04BA,b
        bne _8428
        jsl rlProcEngineFreeProc

        _8428
        rtl

        .databank 0

        ; 82/8429

    .endsection Unsorted82841FSection


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
        stz wGameStateRoutine1,b
        lda #$88B2
        sta aProcSystem.aHeaderOnCycle,b,x
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


    .section Unsorted8288B2Section

      .al
      .xl

      rlUnknown8288B2 ; 82/88B2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda bBufferINIDISP
        bit #$000F
        beq _88BE
        dec a
        sta bBufferINIDISP
        bra _88E6


        _88BE
        jsl rlEventEngineFreeProc
        lda #$0002
        sta wUnknown00171C,b
        lda $04EA,b
        and #$FFFA
        sta $04EA,b
        lda #$C0BC
        jsl rlUnknown80A9D4
        sei
        sep #$20
        lda bBufferNMITIMEN
        and #$CF
        sta bBufferNMITIMEN
        sta $4200,b
        rep #$20

        _88E6
        rtl

        .databank 0

        ; 82/88E7

    .endsection Unsorted8288B2Section


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
        lda aProcSystem.aBody0,b
        sta @l lR22
        lda aProcSystem.aBody1,b
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


    .section Unsorted828BB3Section

      .al
      .xl

      rlUnknown828BB3 ; 82/8BB3

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 82/8BB4

      rlUnknown828BB4 ; 82/8BB4

        .al
        .xl
        .autsiz
        .databank ?

        lda wGameStateRoutine1,b
        cmp #$0018
        bcc _8BC1
        cmp #$001C
        bcc _8BC5

        _8BC1
        jsl rlEventEngineFreeProc

        _8BC5
        rtl

        .databank 0

        ; 82/8BC6

    .endsection Unsorted828BB3Section


    .section Unsorted829496Section

      .al
      .xl

      rlUnknown829496 ; 82/9496

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown9EC70B)<<8
        sta lR44+1
        lda #<>procUnknown9EC70B
        sta lR44
        jsl rlProcEngineFindProc
        bcc _94B0
        txa
        lsr a
        jsl rlProcEngineFreeProcByIndex
        jsl rlActiveSpriteEngineClearAllSprites

        _94B0
        rtl

        .databank 0

        ; 82/94B1

    .endsection Unsorted829496Section


    .section Unsorted8294C0Section

      .al
      .xl

      rlUnknown8294C0 ; 82/94C0

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$8200
        sta lR44+1
        lda #$8BA9
        sta lR44
        jsl rlEventEngineCreateProc
        rtl

        .databank 0

        ; 82/94CF

    .endsection Unsorted8294C0Section


    .section Unsorted82E028Section

      .al
      .xl

      rsUnknown82E028 ; 82/E028

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        dec y
        dec y
        tya
        sta $16FA,b,x
        pla
        rts

        .databank 0

        ; 82/E030

    .endsection Unsorted82E028Section


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
        lda #<>rsUnknown808222
        sta wIRQPointer
        rtl

        .databank 0

        ; 82/E0C6

    .endsection Unsorted82E0AFSection


    .section Unsorted82E133Section

      .al
      .xl

      rlUnknown82E133 ; 82/E133

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 82/E134

    .endsection Unsorted82E133Section


    .section Unsorted82E250Section

      .al
      .xl

      rlUnknown82E250 ; 82/E250

        .al
        .xl
        .autsiz
        .databank ?

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
        jsl rlUnknown82E2DA
        jsr rsUnknown82E2AD
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

      rsUnknown82E2AD ; 82/E2AD

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown82E2DA ; 82/E2DA

        .al
        .xl
        .autsiz
        .databank ?

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


    .section Unsorted82E5FFSection

      .al
      .xl

      rlUnknown82E5FF ; 82/E5FF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $82
        jsl rlFindRAMStructEntry
        sta wStructIndex,b
        lda #$0001
        sta $0552,b
        jsl rlUnknown82E664
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E615

    .endsection Unsorted82E5FFSection


    .section Unsorted82E615Section

      .al
      .xl

      rlUnknown82E615 ; 82/E615

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $82
        jsl rlFindRAMStructEntry
        sta wStructIndex,b
        jsl rlGetRAMStructCurrentStructCount
        sta $0552,b
        jsl rlUnknown82E664
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E62C

    .endsection Unsorted82E615Section


    .section Unsorted82E62CSection

      .al
      .xl

      rlUnknown82E62C ; 82/E62C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $82
        jsl rlFindRAMStructEntry
        sta wStructIndex,b
        dec a
        sta $0552,b
        jsl rlUnknown82E664
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E640

      rlUnknown82E640 ; 82/E640

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $82
        jsl rlFindRAMStructEntry
        sta wStructIndex,b
        inc a
        sta $0552,b
        jsl rlUnknown82E664
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E654

      rlUnknown82E654 ; 82/E654

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $82
        jsl rlFindRAMStructEntry
        sta wStructIndex,b
        jsl rlUnknown82E664
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E664

    .endsection Unsorted82E62CSection


    .section Unsorted82E664Section

      .al
      .xl

      rlUnknown82E664 ; 82/E664

        ; Found by tools/sweep.py: nothing in the build reaches this.
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
        lda wStructIndex,b
        ora $0552,b
        bne _E676
        jml _E741


        _E676
        lda wStructIndex,b
        beq _E6B8
        lda $0552,b
        beq _E6B8
        ldy lStructPointer2,b
        sep #$20
        lda lStructPointer2+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda $0000,b,y
        cmp @l wStructIndex
        bcc _E6B8
        cmp @l $000552
        bcc _E6B8
        lda $0002,b,y
        and #$00FF
        sta @l wStructSize
        lda @l wStructIndex
        jsr rsUnknown82EADE
        lda @l wStructIndex
        cmp @l $000552
        bcc _E700
        bra _E6BE


        _E6B8
        ply
        plx
        plp
        plb
        .databank ?
        sec
        rtl


        _E6BE
        sec
        sbc @l $000552
        inc a
        jsr rsGetRAMStructOffset
        sta @l wStructIndexAlternate
        lda @l wStructIndex
        and #$00FF
        dec a
        jsr rsGetRAMStructOffset
        clc
        adc @l lStructPointer2
        clc
        adc @l wStructSize
        tay
        clc
        adc @l wStructSize
        tax
        sep #$20

        _E6E9
        lda $0003,b,y
        sta $0003,b,x
        dec y
        dec x
        lda @l wStructIndexAlternate
        dec a
        sta @l wStructIndexAlternate
        bne _E6E9
        rep #$20
        bra _E73A


        _E700
        lda @l $000552
        sec
        sbc @l wStructIndex
        inc a
        jsr rsGetRAMStructOffset
        sta wStructIndexAlternate,b
        lda @l wStructIndex
        jsr rsGetRAMStructOffset
        clc
        adc @l lStructPointer2
        tax
        clc
        adc @l wStructSize
        tay
        sep #$20

        _E725
        lda $0004,b,y
        sta $0004,b,x
        inc y
        inc x
        lda @l wStructIndexAlternate
        dec a
        sta @l wStructIndexAlternate
        bne _E725
        rep #$20

        _E73A
        lda @l $000552
        jsr rsUnknown82EB15

        _E741
        ply
        plx
        plp
        plb
        .databank ?
        clc
        rtl

        .databank 0

        ; 82/E747

    .endsection Unsorted82E664Section


    .section Unsorted82EADESection

      .al
      .xl

      rsUnknown82EADE ; 82/EADE

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phy
        pha
        lda @l lStructPointer2
        tay
        lda $0002,b,y
        and #$00FF
        cmp #$0004
        bcc _EB0F
        lda $0001,b,y
        and #$00FF
        inc a
        jsr rsGetRAMStructOffset
        clc
        adc @l lStructPointer2
        sta @l lStructPointer1
        sep #$20
        lda @l lStructPointer2+1
        sta @l lStructPointer1+1
        rep #$20

        _EB0F
        pla
        jsr rsLoadDataFromRAMStruct
        ply
        rts

        .databank 0

        ; 82/EB15

      rsUnknown82EB15 ; 82/EB15

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phy
        pha
        lda @l lStructPointer2
        tay
        lda $0002,b,y
        and #$00FF
        cmp #$0004
        bcc _EB46
        lda $0001,b,y
        and #$00FF
        inc a
        jsr rsGetRAMStructOffset
        clc
        adc @l lStructPointer2
        sta @l lStructPointer1
        sep #$20
        lda @l lStructPointer2+1
        sta @l lStructPointer1+1
        rep #$20

        _EB46
        pla
        jsr rsSaveDataToRAMStruct
        ply
        rts

        .databank 0

        ; 82/EB4C

    .endsection Unsorted82EADESection


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
          sta lUnknown0540,b,x
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

        ldy lUnknown0540,b
        sep #$20
        lda lUnknown0540+2,b
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

        ldx lUnknown0540,b
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


    .section Unsorted82F517Section

      .al
      .xl

      rlUnknown82F517 ; 82/F517

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phy
        phb
        dec a
        asl a
        clc
        adc lR18
        tay
        sep #$20
        lda lR18+2
        pha
        sta lBlockCopySource+2,b
        rep #$20
        plb
        .databank ?
        lda $0002,b,y
        sec
        sbc $0000,b,y
        sta @l wBlockCopySize
        lda $0000,b,y
        plb
        .databank ?
        clc
        adc lR18
        sta lBlockCopySource,b
        lda lR19+1
        sta lBlockCopyDestination+1,b
        lda lR19
        sta lBlockCopyDestination,b
        jsl rlBlockCopyMVNByRAM
        ply
        rtl

        .databank 0

        ; 82/F54F

    .endsection Unsorted82F517Section
