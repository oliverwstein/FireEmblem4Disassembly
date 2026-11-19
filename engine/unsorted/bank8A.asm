; Code from bank $8A not yet assigned to a game system.

    .section Unsorted8A8000Section

      .al
      .xl

      rlUnknown8A8000 ; 8A/8000

        .al
        .xl
        .autsiz
        .databank ?

        lda $0891,b
        cmp #$0002
        beq _800D
        cmp #$0003
        beq _800D

        _800D
        rtl

        .databank 0

        ; 8A/800E

    .endsection Unsorted8A8000Section


    .section Unsorted8A800ESection

      .al
      .xl

      rlUnknown8A800E ; 8A/800E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$7F00
        sta lR18+1
        lda #$B16C
        sta lR18
        lda #$0001
        sta wStructIndex,b
        lda #$4E93
        jsl rlBuildRAMAreaHeaderAndGuidingEntry
        lda $088B,b
        cmp #$0002
        beq _8041
        jsl rlEnableActiveSpriteEngine
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        bra _8049


        _8041
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20

        _8049
        lda $08B8,b
        cmp #$0004
        beq _805D
        stz wBufferBG1VOFS
        stz wBufferBG2VOFS
        stz wBufferBG3VOFS
        stz wBufferBG1HOFS
        stz wBufferBG2HOFS
        stz wBufferBG3HOFS

        _805D
        inc wGameStateRoutine1,b
        rtl

        .databank 0

        ; 8A/8061

    .endsection Unsorted8A800ESection


    .section Unsorted8A8061Section

      .al
      .xl

      rlUnknown8A8061 ; 8A/8061

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8A
        jsl rlUnknown81B15A
        jsl rlUnknown81ADD8
        lda wGameStateStep,b
        asl a
        tax
        jsr ($8A8078,x)
        plp
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/8078

    .endsection Unsorted8A8061Section


    .section Unsorted8A8496Section

      .al
      .xl

      rlUnknown8A8496 ; 8A/8496

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$3000
        sta aCurrentTilemapInfo,b
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0200, $80, $B000

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$85EF
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0104
        jsl rlDrawMenuTextLine
        sep #$20
        lda #$15
        sta bBufferTM
        rep #$20
        lda $0891,b
        beq _84EF
        cmp #$0004
        beq _84EF
        cmp #$0005
        beq _84EF
        jml _857E


        _84EF
        lda $0897,b
        asl a
        tax
        lda $7F757A,x
        asl a
        tax
        lda $7F75AA,x
        beq _857E
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0108
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitStatus
        cmp #StatusHealthy
        bne _8594
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$8621
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0110
        jsl rlDrawMenuTextLine
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$8627
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0115
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitCurrentHP
        ldx #$30F0
        stx aCurrentTilemapInfo,b
        ldx #$0113
        jsl rlUnknown87913E
        jsl rlGetSelectedUnitMaxHP
        ldx #$30F0
        stx aCurrentTilemapInfo,b
        ldx #$0116
        jsl rlUnknown87913E
        rtl


        _857E
        jsl rlGetEventLocationEntryCastleName
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$010C
        jsl rlDrawMenuTextLine
        rtl


        _8594
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89A76C+1,x
        sta lRoutineVariable+1,b
        lda aUnknown89A76C,x
        sta lRoutineVariable,b
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$010E
        jsl rlDrawMenuTextLine
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$863B
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0114
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitStatusDuration
        ldx #$34F0
        stx aCurrentTilemapInfo,b
        ldx #$0117
        jsl rlUnknown87913E
        rtl

        .databank 0

        ; 8A/85EF

    .endsection Unsorted8A8496Section


    .section Unsorted8A870DSection

      .al
      .xl

      rsUnknown8A870D ; 8A/870D

        .al
        .xl
        .autsiz
        .databank ?

        lda $0897,b
        sta wTempVariable1,b
        sta wTempVariable2,b

        _8716
        lda $7F763A
        beq _8781
        lda wTempVariable1,b
        cmp #$0017
        bcs _875C
        clc
        adc #$0001
        sta wTempVariable1,b

        _872B
        asl a
        tax
        lda $7F757A,x
        asl a
        tax
        lda $7F75AA,x
        beq _8716
        sta wRoutineVariable1,b
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wRoutineVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta wRoutineVariable1,b
        jsl rlUnknown87A01A
        pla
        sta wSelectedUnitDataRAMPointer,b
        bcc _8716
        lda wTempVariable1,b
        bra _8764


        _875C
        lda #$0000
        sta wTempVariable1,b
        bra _872B


        _8764
        sta $0897,b
        asl a
        tax
        lda aUnknown8A99DB,x
        sta $088D,b
        lda aUnknown8A9A0B,x
        sta $088F,b
        lda wTempVariable1,b
        cmp wTempVariable2,b
        beq _8781
        sec
        rts


        _8781
        clc
        rts

        .databank 0

        ; 8A/8783

    .endsection Unsorted8A870DSection


    .section Unsorted8A87B8Section

      .al
      .xl

      rsUnknown8A87B8 ; 8A/87B8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda $0893,b
        asl a
        tax
        jsr ($8A87F3,x)
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8988, $0100, $80, $B600

        stz wBufferBG2VOFS
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1903
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 8A/87F3

      rsUnknown8A87F3 ; 8A/87F3

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        dec a
        dec y
        sbc $881287,x
        and wBufferBG3HOFS+1
        txs
        dec y
        ror wBufferBG3HOFS+1,x
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$88E0
        sta lRoutineVariable,b
        jsl rlUnknown879F12
        bcc _886F
        rts

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$88F4
        sta lRoutineVariable,b
        jsl rlUnknown879F67
        bcc _886F
        rts

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$8908
        sta lRoutineVariable,b
        lda wCurrentChapter,b
        cmp #$0006
        beq _8863
        rts

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$891C
        sta lRoutineVariable,b
        rts

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$896C
        sta lRoutineVariable,b
        bra _886F

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$8958
        sta lRoutineVariable,b
        bra _886F


        _8863
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$8944
        sta lRoutineVariable,b

        _886F
        lda #$3800
        sta aCurrentTilemapInfo,b
        rts

        .databank 0

        ; 8A/8876

      rsUnknown8A8876 ; 8A/8876

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #SkillIDSteal
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _8887
        jsl rlUnknown879F9C
        bcs _8887
        bra $8A8863


        _8887
        jsl rlUnknown879F9C
        bcc $8A8847
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$896C
        sta lRoutineVariable,b
        rts

        .databank 0

        ; 8A/889A

      rsUnknown8A889A ; 8A/889A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #SkillIDDance
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _88CD
        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        jsl rlUnknown84F8D9
        lda wAIGroupLeaderFieldMovement
        and #$00FF
        bne _88C0
        lda $7E2028
        and #$00FF
        beq $8A8863

        _88C0
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$8930
        sta lRoutineVariable,b
        rts


        _88CD
        jsl rlUnknown87A006
        bcc $8A8855
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$8958
        sta lRoutineVariable,b
        rts

        .databank 0

        ; 8A/88E0

    .endsection Unsorted8A87B8Section


    .section Unsorted8A8F68Section

      .al
      .xl

      rlUnknown8A8F68 ; 8A/8F68

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $8A
        ldx #$00FE

        _8F6E
        lda aUnknown8C9800,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _8F6E
        jsl rlResetHDMAEngine
        sep #$20
        lda #$00
        sta bBufferCGWSEL
        lda #$81
        sta bBufferCGADSUB
        rep #$20
        jsl rlUnknown8A8496
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/8F8F

    .endsection Unsorted8A8F68Section


    .section Unsorted8A8F8FSection

      .al
      .xl

      rsUnknown8A8F8F ; 8A/8F8F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $0893,b
        beq _8FE4
        cmp #$0001
        beq _8FB6
        cmp #$0002
        beq _8FDC
        cmp #$0003
        beq _8FE0
        cmp #$0004
        beq _9002
        cmp #$0005
        beq _9021
        rts


        _8FAE
        lda #$0022
        jsl rlUnknown808FAD
        rts


        _8FB6
        jsl rlUnknown879F12
        bcc _8FAE
        jsl rlUnknown84AF17
        bcs _8FAE
        lda #$000A
        jsl rlUnknown808FAD
        lda wRoutineVariable1,b
        sta wActiveUnitDeploymentOffset,b
        lda #$FFFF
        sta $07E0,b
        lda #$0016
        sta wGameStateStep,b
        rts


        _8FDC
        jsr rsUnknown8A9069
        rts


        _8FE0
        jsr rsUnknown8A9038
        rts


        _8FE4
        jsr rsUnknown8A9D22
        lda #$000F
        sta wGameStateStep,b
        lda #$0015
        sta $0594,b
        lda #$0003
        sta $7F766A
        lda #$000A
        jsl rlUnknown808FAD
        rts


        _9002
        lda $0897,b
        sta $0899,b
        lda #SkillIDDance
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcc _9019
        jsl rlUnknown87A006
        bcs _901D
        bra _8FAE


        _9019
        jsr rsUnknown8A90C7
        rts


        _901D
        jsr rsUnknown8A918A
        rts


        _9021
        lda $0897,b
        sta $0899,b
        jsl rlUnknown879F9C
        bcc _8FAE
        jsr rsUnknown8A9209
        lda #$000A
        jsl rlUnknown808FAD
        rts

        .databank 0

        ; 8A/9038

      rsUnknown8A9038 ; 8A/9038

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wCurrentChapter,b
        cmp #$0006
        beq _9061
        lda #$0003
        sta $0891,b
        lda #$0009
        sta wGameStateStep,b
        lda #$0003
        sta $08A9,b
        lda #$0005
        sta $7F8082
        lda #$000A
        jsl rlUnknown808FAD
        rts


        _9061
        lda #$0022
        jsl rlUnknown808FAD
        rts

        .databank 0

        ; 8A/9069

      rsUnknown8A9069 ; 8A/9069

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown879F67
        bcc _90BF
        jsl rlUnknown84AF17
        lda #$000A
        jsl rlUnknown808FAD
        jsl rlUnknown88C25D
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $0778,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $077A,b
        lda wCursorYOffset,b
        sec
        sbc #$0020
        sta wCursorYOffset,b
        lda #$0003
        sta $07E0,b
        lda wRoutineVariable1,b
        sta wActiveUnitDeploymentOffset,b
        tax
        lda #$0001
        jsl rlUnknown84D03E
        lda #$0016
        sta wGameStateStep,b
        rts


        _90BF
        lda #$0022
        jsl rlUnknown808FAD
        rts

        .databank 0

        ; 8A/90C7

      rsUnknown8A90C7 ; 8A/90C7

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        jsl rlUnknown84F8D9
        lda wAIGroupLeaderFieldMovement
        and #$00FF
        bne _90E4
        lda $7E2028
        and #$00FF
        beq _9150

        _90E4
        stz wBufferBG2VOFS
        stz $0891,b
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$9158
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1903
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8988, $0100, $80, $B600

        ldx #$01FE
        lda #$00FF

        _9119
        sta $7E8088,x
        dec x
        dec x
        bpl _9119
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8088, $0200, $80, $AD00

        lda #$0000
        sta wUnknown00052A,b
        lda #$0001
        sta wUnknown00052C,b
        jsl rlUnknown87829A
        jsr rsUnknown8A929B
        lda #$8500
        sta lR44+1
        lda #$E9C7
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _9150
        lda #$0022
        jsl rlUnknown808FAD
        rts

        .databank 0

        ; 8A/9158

    .endsection Unsorted8A8F8FSection


    .section Unsorted8A918ASection

      .al
      .xl

      rsUnknown8A918A ; 8A/918A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$91D7
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1903
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8988, $0100, $80, $B600

        ldx #$01FE
        lda #$00FF

        _91BA
        sta $7E8088,x
        dec x
        dec x
        bpl _91BA
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8088, $0200, $80, $AD00

        jsr rsUnknown8A929B
        jsl rlUnknown84B6E2
        rts

        .databank 0

        ; 8A/91D7

    .endsection Unsorted8A918ASection


    .section Unsorted8A9209Section

      .al
      .xl

      rsUnknown8A9209 ; 8A/9209

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0005
        sta $0891,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        stz $0897,b
        jsr rsUnknown8A870D
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$9269
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1903
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8988, $0100, $80, $B600

        ldx #$01FE
        lda #$00FF

        _924C
        sta $7E8088,x
        dec x
        dec x
        bpl _924C
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8088, $0200, $80, $AD00

        jsr rsUnknown8A929B
        jsl rlUnknown8A8496
        rts

        .databank 0

        ; 8A/9269

    .endsection Unsorted8A9209Section


    .section Unsorted8A929BSection

      .al
      .xl

      rsUnknown8A929B ; 8A/929B

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$001E

        _929E
        lda aUnknownDE0000,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _929E
        rts

        .databank 0

        ; 8A/92AA

    .endsection Unsorted8A929BSection


    .section Unsorted8A92BBSection

      .al
      .xl

      rlUnknown8A92BB ; 8A/92BB

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown88C25D
        jsl rlUnknown84AF57
        bcs _92D5
        lda wRoutineVariable1,b
        sta wActiveUnitDeploymentOffset,b
        jsl rlUnknown8881DE
        lda #$0016
        sta wGameStateStep,b

        _92D5
        rtl

        .databank 0

        ; 8A/92D6

    .endsection Unsorted8A92BBSection


    .section Unsorted8A92D6Section

      .al
      .xl

      rlUnknown8A92D6 ; 8A/92D6

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown88C25D
        jsl rlUnknown84AF57
        bcs _92FE
        lda wRoutineVariable1,b
        sta wActiveUnitDeploymentOffset,b
        jsl rlUnknown8881DE
        jsl rlUnknown8881E5
        lda wCursorYOffset,b
        sec
        sbc #$0010
        sta wCursorYOffset,b
        lda #$0016
        sta wGameStateStep,b

        _92FE
        rtl

        .databank 0

        ; 8A/92FF

      rlUnknown8A92FF ; 8A/92FF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        jsl rlUnknown8A8496
        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20
        jsr rsUnknown8A87B8
        lda #$0001
        sta $0891,b
        jsl rlGetSelectedUnitCharacterID
        jsl rlUnknown8A979C
        jsl rlDMAByStruct

          .structDMAToVRAM $DA6500, $0200, $80, $AD00

        lda $0899,b
        sta $0897,b
        asl a
        tax
        lda @l aUnknown8A99DB,x
        sta $088D,b
        lda @l aUnknown8A9A0B,x
        sta $088F,b
        rtl

        .databank 0

        ; 8A/9342

    .endsection Unsorted8A92D6Section


    .section Unsorted8A9342Section

      .al
      .xl

      rlUnknown8A9342 ; 8A/9342

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp $089F,b
        bne _9364
        lda #$0000
        jsl rlGetLocationEventDataEntry
        jsl rlBuildDeadPlayerCharacterList
        jsl rlUnknown80B9AD
        jsl rlUnknown8A9A56

        _9364
        lda $0899,b
        sta $0897,b
        asl a
        tax
        lda aUnknown8A99DB,x
        sta $088D,b
        lda aUnknown8A9A0B,x
        sta $088F,b
        ply
        plx
        plb
        .databank ?
        rtl

        .databank 0

        ; 8A/937E

    .endsection Unsorted8A9342Section


    .section Unsorted8A9389Section

      .al
      .xl

      rsUnknown8A9389 ; 8A/9389

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown87EF46
        sta wR0
        lda $0895,b
        asl a
        tax
        lda aUnknown8A945E,x
        sta wR1
        lda wR0
        bit wR1
        beq _93BE
        lda $0895,b
        beq _93EB
        cmp #$0001
        beq _93D5
        cmp #$0002
        beq _9423
        cmp #$0003
        beq _940A
        cmp #$0004
        beq _9401
        cmp #$0005
        beq _93BF

        _93BE
        rts


        _93BF
        lda #$000D
        sta wGameStateStep,b
        lda #$0004
        sta $08A9,b
        lda #$0000
        sta $7F8082
        bra _944E

        rts


        _93D5
        lda #$000D
        sta wGameStateStep,b
        lda #$0005
        sta $08A9,b
        lda #$0001
        sta $7F8082
        bra _944E

        rts


        _93EB
        lda #$000D
        sta wGameStateStep,b
        lda #$0004
        sta $08A9,b
        lda #$0002
        sta $7F8082
        bra _944E

        rts


        _9401
        lda #$0005
        sta wGameStateStep,b
        bra _944E

        rts


        _940A
        lda wSelectedUnitDataRAMPointer,b
        sta $089B,b
        lda #$0003
        sta wGameStateStep,b
        lda #$0007
        sta $7F8082
        stz $0AD7,b
        bra _944E

        rts


        _9423
        lda #$0007
        sta wGameStateStep,b
        lda #$0002
        sta $08A9,b
        lda #$0003
        sta $7F8082
        bra _944E

        rts

        lda #$C39A
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _944E
        lda #$000A
        jsl rlUnknown808FAD
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

        ; 8A/945E

    .endsection Unsorted8A9389Section


    .section Unsorted8A94B6Section

      .al
      .xl

      rlUnknown8A94B6 ; 8A/94B6

        .al
        .xl
        .autsiz
        .databank ?

        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8A00
        sta $4303,b
        lda #$94E1
        sta $4302,b
        lda #$0800
        sta $4305,b
        lda #$2000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        rtl

        .databank 0

        ; 8A/94E0

    .endsection Unsorted8A94B6Section


    .section Unsorted8A94E2Section

      .al
      .xl

      rlUnknown8A94E2 ; 8A/94E2

        .al
        .xl
        .autsiz
        .databank ?

        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8A00
        sta $4303,b
        lda #$950D
        sta $4302,b
        lda #$0800
        sta $4305,b
        lda #$2400
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        rtl

        .databank 0

        ; 8A/950C

    .endsection Unsorted8A94E2Section


    .section Unsorted8A950ESection

      .al
      .xl

      rsUnknown8A950E ; 8A/950E

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$964C
        lda #$0000
        sta wR5
        sta wR4
        lda aDialogue.wUnknown0018A3,b,x
        beq _9534
        cmp #$0001
        beq _952F
        ldy #$96C8
        bra _9534


        _952F
        ldy #$968A
        bra _9534


        _9534
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8A/9539

      rsUnknown8A9539 ; 8A/9539

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$9586
        lda #$0000
        sta wR5
        lda #$0040
        sta wR4
        lda wCurrentChapter,b
        cmp #$FFFF
        beq _956A
        lda aDialogue.wUnknown0018A3,b,x
        beq _956A
        cmp #$0001
        beq _9565
        ldy #$9602
        bra _956A


        _9565
        ldy #$95C4
        bra _956A


        _956A
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8A/956F

    .endsection Unsorted8A950ESection


    .section Unsorted8A9750Section

      .al
      .xl

      rlUnknown8A9750 ; 8A/9750

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = PortraitID

        jsl rlGetDecompressedPortraitDataPointers

        ldx #size(Palette)-2
        ldy #size(Palette)-2

          -
          lda [lR19],y
          sta aOAMPaletteBuffer.aPalette5,b,y
          dec x
          dec x
          dec y
          dec y
          bpl -

        lda #16 * 4 * size(Tile4bpp)
        sta wR0
        lda #$CE00 >> 1
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

        ; 8A/9776

    .endsection Unsorted8A9750Section


    .section Unsorted8A9776Section

      .al
      .xl

      rlUnknown8A9776 ; 8A/9776

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8AB3FE
        ldx #$001E
        ldy #$001E

        _9780
        lda [lR19],y
        sta aOAMPaletteBuffer.aPalette4,b,y
        dec x
        dec x
        dec y
        dec y
        bpl _9780
        lda #$0800
        sta wR0
        lda #$6B00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

        ; 8A/979C

    .endsection Unsorted8A9776Section


    .section Unsorted8A979CSection

      .al
      .xl

      rlUnknown8A979C ; 8A/979C

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetDecompressedPortraitDataPointers
        ldx #$001E
        ldy #$001E

        _97A6
        lda [lR19],y
        sta aOAMPaletteBuffer.aPalette6,b,y
        dec x
        dec x
        dec y
        dec y
        bpl _97A6
        lda #$0800
        sta wR0
        lda #$6400
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

        ; 8A/97C2

    .endsection Unsorted8A979CSection


    .section Unsorted8A97C2Section

      .al
      .xl

      rlUnknown8A97C2 ; 8A/97C2

        .al
        .autsiz
        .databank ?

        phk
        plb
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20

        lda #$0006
        sta bEventActionIdentifier,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument1,b

        ; Holds the LocationID
        lda $089F,b
        sta wEventEngineArgument2,b
        jsl rlGetAndRunChapterMapEventConditions
        bcc +

          lda wSelectedUnitDataRAMPointer,b
          sta $08BA,b
          lda #2
          sta wGameStateStep,b
          rtl

        +
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine

        lda #0
        sta wR1
        lda #0
        sta wR2
        lda #$8000 >> 1
        sta wR3
        sta wR4
        lda #$C000 >> 1
        sta wR5
        lda #$A000 >> 1
        sta wR6
        lda #$A800 >> 1
        sta wR7
        lda #$B000 >> 1
        sta wR8
        jsl rlSetLayerPositionsAndSizes

        jsl rlUnknown80BA52
        jsl rlGetSelectedUnitCharacterID
        jsl rlUnknown8A9776
        jsl rlUnknown8A94E2
        lda #1
        sta $7F766A
        lda #$0010
        sta wGameStateStep,b
        lda #1
        sta $0594,b
        rep #$20
        jsl rlEnableVBlank

        sep #$20
        lda #0
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/9858

    .endsection Unsorted8A97C2Section


    .section Unsorted8A9858Section

      .al
      .xl

      rlUnknown8A9858 ; 8A/9858

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        lda #$2400
        sta aCurrentTilemapInfo,b
        jsl rlUnknown87EF46
        sta wTempVariable1,b
        ldx #$000A

        _986A
        lda @l aUnknown8A98AC,x
        sta wR1
        lda wTempVariable1,b
        bit wR1
        bne _9897
        lda #$8A00
        sta lR18+1
        lda #$989A
        sta lR18
        phx
        lda @l aUnknown8A98C4,x
        xba
        clc
        adc @l aUnknown8A98B8,x
        tax
        jsl rlDrawMenuTextLine
        plx

        _9892
        dec x
        dec x
        bpl _986A
        rtl


        _9897
        bra _9892

        .databank 0

        ; 8A/9899

    .endsection Unsorted8A9858Section


    .section Table8A98ACSection

      .al
      .xl

      aUnknown8A98AC ; 8A/98AC

        ; Read by rlUnknown8A9858.

        .word $0020, $0040, $0010, $0004, $0008, $0080

        ; 8A/98B8

    .endsection Table8A98ACSection


    .section Table8A98B8Section

      .al
      .xl

      aUnknown8A98B8 ; 8A/98B8

        ; Read by rlUnknown8A9858.

        .word $0002, $000B, $0014, $0001, $000B, $0014

        ; 8A/98C4

    .endsection Table8A98B8Section


    .section Table8A99DBSection

      .al
      .xl

      aUnknown8A99DB ; 8A/99DB

        ; Read by rlUnknown8A9342.

        .word $0048, $0080, $0091, $00B8, $003F, $0058, $00A8, $00C1
        .word $003D, $0056, $00AA, $00C3, $003B, $0054, $00AC, $00C5
        .word $0039, $0052, $00AE, $00C7, $0037, $0050, $00B0, $00C9

        ; 8A/9A0B

    .endsection Table8A99DBSection


    .section Table8A9A0BSection

      .al
      .xl

      aUnknown8A9A0B ; 8A/9A0B

        ; Read by rlUnknown8A9342.

        .byte $5C, $00, $58, $00, $52, $00, $5C, $00, $74, $00, $74, $00, $74, $00, $74, $00
        .byte $88, $00, $88, $00, $88, $00, $88, $00, $9C, $00, $9C, $00, $9C, $00, $9C, $00
        .byte $B0, $00, $B0, $00, $B0, $00, $B0, $00, $C4, $00, $C4, $00, $C4, $00, $C4, $00
        .byte $00, $02, $00, $04, $00, $06, $00, $08, $01, $00, $00, $C2, $00, $80, $20, $02
        .byte $00, $00, $C2, $00, $40, $21, $00, $C2, $F0, $42, $21

        ; 8A/9A56

    .endsection Table8A9A0BSection


    .section Unsorted8A9A56Section

      .al
      .xl

      rlUnknown8A9A56 ; 8A/9A56

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        lda #$0000
        sta $7F763A
        lda #$0017
        sta wRoutineVariable1,b
        ldx #$002E

        _9A68
        lda wCurrentChapter,b
        cmp #$0006
        bcs _9A7E
        lda @l aUnknown8A9B94,x
        sta $7F757A,x
        lda @l aUnknown8A9BF4,x
        bra _9A8A


        _9A7E
        lda @l aUnknown8A9BC4,x
        sta $7F757A,x
        lda @l aUnknown8A9C24,x

        _9A8A
        asl a
        tay
        lda $9AD4,b,y
        sta $7F75DA,x
        lda $9B04,b,y
        sta $7F760A,x
        lda aDeadPlayerCharacterList,x
        bmi _9ACF
        phx
        tax
        lda aDeploymentTable._UnitRAMPointer,x
        plx
        sta wSelectedUnitDataRAMPointer,b
        lda wSelectedUnitDataRAMPointer,b
        beq _9ACF
        jsl rlGetSelectedUnitGenerationID
        dec a
        asl a
        sta aMovementMap,x
        phx
        tax
        lda wSelectedUnitDataRAMPointer,b
        sta $7F75AA,x
        plx
        lda $7F763A
        clc
        adc #$0001
        sta $7F763A

        _9ACF
        dec x
        dec x
        bpl _9A68
        rtl

        .databank 0

        ; 8A/9AD4

    .endsection Unsorted8A9A56Section


    .section Table8A9AD4Section

      .al
      .xl

      aUnknown8A9AD4 ; 8A/9AD4

        ; Read by rlUnknown8A9A56.

        .word $0048, $0080, $0091, $00B8, $003F, $0058, $00A8, $00C1
        .word $003D, $0056, $00AA, $00C3, $003B, $0054, $00AC, $00C5
        .word $0039, $0052, $00AE, $00C7, $0037, $0050, $00B0, $00C9

        ; 8A/9B04

    .endsection Table8A9AD4Section


    .section Table8A9B04Section

      .al
      .xl

      aUnknown8A9B04 ; 8A/9B04

        ; Read by rlUnknown8A9A56.

        .word $005C, $0058, $0052, $005C, $0074, $0074, $0074, $0074
        .word $0088, $0088, $0088, $0088, $009C, $009C, $009C, $009C
        .word $00B0, $00B0, $00B0, $00B0, $00C4, $00C4, $00C4, $00C4
        .word $002E, $006C, $0094, $00D4, $0034, $0064, $0096, $00C8
        .word $0034, $0064, $0096, $00C8, $0034, $0064, $0096, $00C8
        .word $0034, $0064, $0096, $00C8, $0034, $0064, $0096, $00C8
        .word $0030, $0030, $0030, $0030, $0050, $0050, $0050, $0050
        .word $0070, $0070, $0070, $0070, $0090, $0090, $0090, $0090
        .word $00B0, $00B0, $00B0, $00B0, $00D0, $00D0, $00D0, $00D0

        ; 8A/9B94

    .endsection Table8A9B04Section


    .section Table8A9B94Section

      .al
      .xl

      aUnknown8A9B94 ; 8A/9B94

        ; Read by rlUnknown8A9A56.

        .word $0005, $0000, $000F, $0010, $0003, $0001, $0002, $0004
        .word $000D, $0009, $0016, $0006, $0008, $0012, $000A, $000E
        .word $0007, $0015, $0011, $000C, $0013, $0017, $0014, $000B

        ; 8A/9BC4

    .endsection Table8A9B94Section


    .section Table8A9BC4Section

      .al
      .xl

      aUnknown8A9BC4 ; 8A/9BC4

        ; Read by rlUnknown8A9A56.

        .word $0001, $0000, $0012, $000E, $0002, $0010, $0011, $000A
        .word $0008, $0017, $0014, $0007, $000D, $0015, $000F, $0003
        .word $0004, $0013, $0016, $0006, $0005, $0009, $000C, $000B

        ; 8A/9BF4

    .endsection Table8A9BC4Section


    .section Table8A9BF4Section

      .al
      .xl

      aUnknown8A9BF4 ; 8A/9BF4

        ; Read by rlUnknown8A9A56.

        .word $0001, $0005, $0006, $0004, $0007, $0000, $000B, $0010
        .word $000C, $0009, $000E, $0017, $0013, $0008, $000F, $0002
        .word $0003, $0012, $000D, $0014, $0016, $0011, $000A, $0015

        ; 8A/9C24

    .endsection Table8A9BF4Section


    .section Table8A9C24Section

      .al
      .xl

      aUnknown8A9C24 ; 8A/9C24

        ; Read by rlUnknown8A9A56.

        .byte $01, $00, $00, $00, $04, $00, $0F, $00, $10, $00, $14, $00, $13, $00, $0B, $00
        .byte $08, $00, $15, $00, $07, $00, $17, $00, $16, $00, $0C, $00, $03, $00, $0E, $00
        .byte $05, $00, $06, $00, $02, $00, $11, $00, $0A, $00, $0D, $00, $12, $00, $09, $00
        .byte $6B, $6B, $61, $9C, $61, $9C, $A8, $9C, $A3, $80, $7F, $32, $00

        ; 8A/9C61

    .endsection Table8A9C24Section


    .section Unsorted8A9C61Section

      .al
      .xl

      rlUnknown8A9C61 ; 8A/9C61

        .al
        .xl
        .autsiz
        .databank ?

        lda $0891,b
        cmp #$0003
        beq _9C87
        jsl rlHDMAEngineFreeEntryByOffset
        bra _9CA5

        .byte $E2, $20, $B9, $AA, $9C, $9F, $A3, $80, $7F, $F0, $2B, $B9, $AB, $9C, $9F, $A4
        .byte $80, $7F, $E8, $E8, $C8, $C8, $80, $EA


        _9C87
        ldx #$0000
        ldy #$0000
        sep #$20

        _9C8F
        lda $9CFE,b,y
        sta $7F80A3,x
        beq _9CA5
        lda $9CFF,b,y
        sta $7F80A4,x
        inc x
        inc x
        inc y
        inc y
        bra _9C8F


        _9CA5
        .al
        rep #$20
        rtl

        .databank 0

        ; 8A/9CA8

    .endsection Unsorted8A9C61Section


    .section Unsorted8A9D22Section

      .al
      .xl

      rsUnknown8A9D22 ; 8A/9D22

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetEventLocationEntryNameID
        asl a
        tax
        lda aUnknown8A9D79,x
        cmp $0510,b
        beq _9D38
        lda #$00E0
        jsl rlUnknown808F6F

        _9D38
        rts

        .databank 0

        ; 8A/9D39

    .endsection Unsorted8A9D22Section


    .section Unsorted8A9D39Section

      .al
      .xl

      rlUnknown8A9D39 ; 8A/9D39

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        jsl rlGetEventLocationEntryNameID
        asl a
        tax
        lda @l aUnknown8A9D79,x
        cmp $0510,b
        beq _9D6C
        lda #$00C0
        jsl rlUnknown808F6F
        jsl rlGetEventLocationEntryNameID
        asl a
        cmp #$005C
        bcs _9D74

        _9D5B
        tax
        lda @l aUnknown8A9D79,x
        cmp $0510,b
        beq _9D6C
        sta $04BA,b
        jsl rlUnknown809654

        _9D6C
        lda #$00E8
        jsl rlUnknown808F6F
        rtl


        _9D74
        lda #$0000
        bra _9D5B

        .databank 0

        ; 8A/9D79

    .endsection Unsorted8A9D39Section


    .section Unsorted8A9EB7Section

      .al
      .xl

      rlUnknown8A9EB7 ; 8A/9EB7

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        stz $08AB,b
        jsl rlGetFirstEquippableWeaponInInventory
        sta $7F8072,x
        sta wTempVariable1,b
        lda wCurrentItemDataROMPointer,b
        beq _9EEC
        sta $7F7C72,x
        lda #$0000
        sta $7F7E72,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta $7F7A72,x
        lda wCurrentItemDataRAMPointer,b
        sta $7F7872,x
        inc $08AB,b
        inc x
        inc x

        _9EEC
        ldy #$0007

        _9EEF
        tya
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _9F2E
        jsl rlCheckWeaponEquippable
        bcc _9F2E
        lda #$0000
        sta $7F7E72,x
        lda wCurrentItemDataROMPointer,b
        sta $7F7C72,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta $7F7A72,x
        lda wCurrentItemDataRAMPointer,b
        sta $7F7872,x
        tya
        cmp wTempVariable1,b
        beq _9F2E
        sta $7F8072,x
        inc $08AB,b
        inc x
        inc x

        _9F2E
        dec y
        bne _9EEF
        rtl

        .databank 0

        ; 8A/9F32

      rlUnknown8A9F32 ; 8A/9F32

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        stz $08AB,b
        jsl rlGetFirstEquippableWeaponInInventory
        sta $7F8072,x
        sta wTempVariable1,b
        jsl rlGetItemMinimumRange
        sta wTempVariable2,b
        jsl rlGetSelectedUnitEquippedWeaponBitfield
        cmp #$0000
        bne _9F59
        lda #$0001
        sta wTempVariable2,b

        _9F59
        lda wCurrentItemDataROMPointer,b
        beq _9F7D
        sta $7F7C72,x
        lda #$0000
        sta $7F7E72,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta $7F7A72,x
        lda wCurrentItemDataRAMPointer,b
        sta $7F7872,x
        inc $08AB,b
        inc x
        inc x

        _9F7D
        ldy #$0007

        _9F80
        tya
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _9FC8
        jsl rlGetItemMinimumRange
        cmp wTempVariable2,b
        bne _9FC8
        jsl rlCheckWeaponEquippable
        bcc _9FC8
        lda #$0000
        sta $7F7E72,x
        lda wCurrentItemDataROMPointer,b
        sta $7F7C72,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta $7F7A72,x
        lda wCurrentItemDataRAMPointer,b
        sta $7F7872,x
        tya
        cmp wTempVariable1,b
        beq _9FC8
        sta $7F8072,x
        inc $08AB,b
        inc x
        inc x

        _9FC8
        dec y
        bne _9F80
        rtl

        .databank 0

        ; 8A/9FCC

    .endsection Unsorted8A9EB7Section


    .section Unsorted8A9FCCSection

      .al
      .xl

      rlUnknown8A9FCC ; 8A/9FCC

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        stz $08AB,b
        jsl rlGetItemRAMDataCount
        tay
        ldx #$0000

        _9FD7
        tya
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        bcs _A00F
        jsl rlGetItemRAMStateAndOwner
        lda wR0
        cmp $08A9,b
        bne _A00F
        bne _A00F
        tya
        sta $7F7672,x
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        sta $7F7A72,x
        jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry
        lda #$0000
        sta $7F7E72,x
        lda wCurrentItemDataROMPointer,b
        sta $7F7C72,x
        inc $08AB,b
        inc x
        inc x

        _A00F
        dec y
        bne _9FD7
        rtl

        .databank 0

        ; 8A/A013

    .endsection Unsorted8A9FCCSection


    .section Unsorted8AA02BSection

      .al
      .xl

      rsUnknown8AA02B ; 8A/A02B

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$A022
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        ldx #$00C0

        _A03D
        sta $7F80C1,x
        dec x
        dec x
        bne _A03D
        lda aCurrentTilemapInfo,b
        pha
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0000
        jsl rlDrawMenuTextLine
        pla
        sta aCurrentTilemapInfo,b
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        ldx #$0000

        _A077
        lda $7F80C3,x
        sta $7E868A,x
        lda $7F8123,x
        sta $7E86CA,x
        inc x
        inc x
        cpx #$0010
        bne _A077
        ldx #$0000

        _A091
        lda $7F80D3,x
        sta $7E870A,x
        lda $7F8133,x
        sta $7E874A,x
        inc x
        inc x
        cpx #$0010
        bne _A091
        ldx #$0000

        _A0AB
        lda $7F80E3,x
        sta $7E878A,x
        lda $7F8143,x
        sta $7E87CA,x
        inc x
        inc x
        cpx #$0010
        bne _A0AB
        ldx #$0000

        _A0C5
        lda $7F80F3,x
        sta $7E880A,x
        lda $7F8153,x
        sta $7E884A,x
        inc x
        inc x
        cpx #$0010
        bne _A0C5
        ldx #$0000

        _A0DF
        lda $7F8103,x
        sta $7E888A,x
        lda $7F8163,x
        sta $7E88CA,x
        inc x
        inc x
        cpx #$0010
        bne _A0DF
        ldx #$0000

        _A0F9
        lda $7F8113,x
        sta $7E890A,x
        lda $7F8173,x
        sta $7E894A,x
        inc x
        inc x
        cpx #$0010
        bne _A0F9
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$A12E
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1600
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 8A/A12E

    .endsection Unsorted8AA02BSection


    .section Unsorted8AA142Section

      .al
      .xl

      rsUnknown8AA142 ; 8A/A142

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8087
        sta lR20+1
        lda $7F8086
        sta lR20
        lda $08A1,b
        tay
        lda [lR20],y
        and #$00FF
        beq _A177
        cmp #$0001
        beq _A17B
        cmp #$0002
        beq _A17B
        cmp #$0003
        beq _A17F
        cmp #$0004
        beq _A17F
        cmp #$0005
        beq _A17F
        cmp #$00FF
        beq _A177

        _A177
        jml _A180


        _A17B
        jml _A222


        _A17F
        rts


        _A180
        ldy #$000E
        lda $08A7,b
        sec
        sbc $08A5,b
        clc
        adc #$0007
        asl a
        tax

        _A190
        phx
        phy
        lda $7F7A72,x
        sta wR0
        txa
        and #$000E
        tay
        lda $A1B0,b,y
        tax
        lda wR0
        jsl rlUnknown8BBE68
        ply
        plx
        dec x
        dec x
        dec y
        dec y
        bpl _A190
        rts

        bvc _A1B2

        _A1B2
        eor (wR0)
        .byte $54, $00, $56 ; mvn from bank $56 to bank $00
        .byte $00 ; brk
        cli
        .byte $00 ; brk
        phy
        .byte $00 ; brk
        jml $005E00

        lda $08A7,b
        sec
        sbc $08A5,b
        asl a
        tax
        lda $7F7A72,x
        sta wR0
        txa
        and #$000E
        tay
        lda $A1DF,b,y
        tax
        lda wR0
        jsl rlUnknown8BBE68
        rts

        bvc _A1E1

        _A1E1
        eor (wR0)
        .byte $54, $00, $56 ; mvn from bank $56 to bank $00
        .byte $00 ; brk
        cli
        .byte $00 ; brk
        phy
        .byte $00 ; brk
        jml $005E00

        lda $08A7,b
        sec
        sbc $08A5,b
        clc
        adc #$0007
        asl a
        tax
        lda $7F7A72,x
        sta wR0
        txa
        and #$000E
        tay
        lda $A212,b,y
        tax
        lda wR0
        jsl rlUnknown8BBE68
        rts

        bvc _A214

        _A214
        eor (wR0)
        .byte $54, $00, $56 ; mvn from bank $56 to bank $00
        .byte $00 ; brk
        cli
        .byte $00 ; brk
        phy
        .byte $00 ; brk
        jml $005E00


        _A222
        ldx #$000E
        ldy #$0007

        _A228
        phx
        phy
        lda aUnknown8AA241,x
        tax
        tya
        inc a
        jsl rlGetItemIDByInventorySlot
        jsl rlUnknown8BBE68
        ply
        plx
        dec x
        dec x
        dec y
        bpl _A228
        rts

        .databank 0

        ; 8A/A241

    .endsection Unsorted8AA142Section


    .section Unsorted8AA2EDSection

      .al
      .xl

      rsUnknown8AA2ED ; 8A/A2ED

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2800
        sta aCurrentTilemapInfo,b
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$A31C
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1902
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitMoney
        ldx #$0646
        jsl rlUnknown8AB111
        rts

        .databank 0

        ; 8A/A31C

    .endsection Unsorted8AA2EDSection


    .section Unsorted8AA5FFSection

      .al
      .xl

      rlUnknown8AA5FF ; 8A/A5FF

        .al
        .xl
        .autsiz
        .databank ?

        pha
        tya
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR0
        txa
        asl a
        clc
        adc wR0
        tay
        pla
        asl a
        asl a
        tax
        phx
        lda aUnknown8AA629,x
        tyx
        sta aBG3TilemapBuffer,x
        txy
        plx
        lda aUnknown8AA629+2,x
        tyx
        sta $7E83C8,x
        rtl

        .databank 0

        ; 8A/A629

    .endsection Unsorted8AA5FFSection


    .section Unsorted8AA6CASection

      .al
      .xl

      rsUnknown8AA6CA ; 8A/A6CA

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0282
        lda #$000A
        ldy #$0008
        jsr rsUnknown8AA9A6
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlGetItemWeaponRank
        ldx #$0008
        ldy #$000A
        inc a
        jsl rlUnknown8AA5FF
        jsl rlGetItemAccuracy
        ldx #$2520
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$030C
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMight
        ldx #$24F0
        stx aCurrentTilemapInfo,b
        ldx #$0E06
        jsl rlUnknown87913E
        jsl rlGetItemMinimumRange
        ldx #$2520
        stx wR5
        ldx #$0001
        stx wR6
        ldx #$040C
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMaximumRange
        ldx #$2520
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0410
        jsl rlDrawMenuTextNumber
        jsl rlGetItemWeight
        ldx #$24F0
        stx aCurrentTilemapInfo,b
        ldx #$1206
        jsl rlUnknown87913E
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$A7DD
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1400
        jsl rlDrawMenuTextLine
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$A7DD
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1600
        jsl rlDrawMenuTextLine
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1501
        jsl rlDrawMenuTextLine
        lda #$2400
        sta aCurrentTilemapInfo,b
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$A7F1
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1007
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 8A/A7DD

    .endsection Unsorted8AA6CASection


    .section Unsorted8AA830Section

      .al
      .xl

      rsUnknown8AA830 ; 8A/A830

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0282
        lda #$000E
        ldy #$0008
        jsr rsUnknown8AA97F
        rts

        .databank 0

        ; 8A/A83D

    .endsection Unsorted8AA830Section


    .section Unsorted8AA83DSection

      .al
      .xl

      rlUnknown8AA83D ; 8A/A83D

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $08A7,b
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _A8AD
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlGetItemEquipmentType
        cmp #$0001
        beq _A88E
        cmp #$0000
        beq _A8B1
        lda #$8A00
        sta lRoutineVariable+1,b
        lda #$A8B5
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0A00
        jsl rlDrawMenuTextLine
        jml rsUnknown8AA02B


        _A88E
        ldx #$0282
        lda #$0002
        ldy #$0008
        jsr rsUnknown8AA9A6
        jsl rlGetItemWeaponRank
        ldx #$0008
        ldy #$000A
        inc a
        jsl rlUnknown8AA5FF
        jml rsUnknown8AA02B


        _A8AD
        jml rsUnknown8AA830


        _A8B1
        jml rsUnknown8AA6CA

        .databank 0

        ; 8A/A8B5

    .endsection Unsorted8AA83DSection


    .section Unsorted8AA97FSection

      .al
      .xl

      rsUnknown8AA97F ; 8A/A97F

        .al
        .xl
        .autsiz
        .databank ?

        stx wR0
        sty wR1
        sty wR3
        sta wR2

        _A987
        lda #$00FF
        sta aBG3TilemapBuffer,x
        inc x
        inc x
        dec wR1
        bne _A987
        lda wR0
        clc
        adc #$0040
        sta wR0
        tax
        lda wR3
        sta wR1
        dec wR2
        bne _A987
        rts

        .databank 0

        ; 8A/A9A6

    .endsection Unsorted8AA97FSection


    .section Unsorted8AA9A6Section

      .al
      .xl

      rsUnknown8AA9A6 ; 8A/A9A6

        .al
        .xl
        .autsiz
        .databank ?

        stx wR0
        sty wR1
        sty wR3
        sta wR2

        _A9AE
        lda aUnknownDA7000,x
        sta aBG3TilemapBuffer,x
        inc x
        inc x
        dec wR1
        bne _A9AE
        lda wR0
        clc
        adc #$0040
        sta wR0
        tax
        lda wR3
        sta wR1
        dec wR2
        bne _A9AE
        rts

        .databank 0

        ; 8A/A9CE

    .endsection Unsorted8AA9A6Section


    .section Unsorted8AA9CESection

      .al
      .xl

      rsUnknown8AA9CE ; 8A/A9CE

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        ldy #$000E
        lda $08A7,b
        sec
        sbc $08A5,b
        clc
        adc #$0007
        asl a
        tax

        _A9E4
        txa
        lsr a
        cmp $08AB,b
        bcs _AA0F
        lda $7F7E72,x
        bmi _A9F9
        lda #$2000
        sta aCurrentTilemapInfo,b
        bra _A9FF


        _A9F9
        lda #$2C00
        sta aCurrentTilemapInfo,b

        _A9FF
        jsr rsUnknown8AAA8A
        jsr rsUnknown8AAAE7
        jsr rsUnknown8AAA3A

        _AA08
        dec x
        dec x
        dec y
        dec y
        bpl _A9E4
        rts


        _AA0F
        lda #$8A00
        sta lR18+1
        lda #$A320
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        bra _AA08

        .databank 0

        ; 8A/AA2A

    .endsection Unsorted8AA9CESection


    .section Unsorted8AAA3ASection

      .al
      .xl

      rsUnknown8AAA3A ; 8A/AA3A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lR18+1
        lda #$AA78
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        lda $7F7C72,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetItemNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/AA78

    .endsection Unsorted8AAA3ASection


    .section Unsorted8AAA8ASection

      .al
      .xl

      rsUnknown8AAA8A ; 8A/AA8A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8082
        cmp #$0003
        beq _AAE6
        cmp #$0004
        beq _AAE6
        cmp #$0007
        beq _AAE6
        phy
        phx
        lda $7F7872,x
        sta wCurrentItemDataRAMPointer,b
        jsl rlGetItemBuyPrice
        sta wTempVariable1,b
        plx
        ply
        jsl rlUnknown87A18C
        bcc _AABC
        lda wTempVariable1,b
        lsr a
        sta wTempVariable1,b

        _AABC
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0032
        tax
        lda wTempVariable1,b
        jsl rlUnknown8AB111
        plx
        rts

        .byte $DA, $B9, $2A, $AA, $EB, $4A, $4A, $18, $69, $32, $00, $AA, $AD, $8C, $07, $4A
        .byte $22, $11, $B1, $8A, $FA


        _AAE6
        rts

        .databank 0

        ; 8A/AAE7

      rsUnknown8AAAE7 ; 8A/AAE7

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F7872,x
        sta wCurrentItemDataRAMPointer,b
        jsl rlGetItemCurrentDurability
        sta wR0
        plx
        ply
        lda $7F7C72,x
        sta wCurrentItemDataROMPointer,b
        phy
        phx
        jsl rlGetItemEquipmentType
        plx
        ply
        cmp #$0002
        beq _AB20
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0026
        tax
        lda wR0
        jsl rlUnknown8AB111
        plx
        rts


        _AB20
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8A00
        sta lR18+1
        lda #$AB40
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$0015
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/AB40

    .endsection Unsorted8AAA8ASection


    .section Unsorted8AAB48Section

      .al
      .xl

      rsUnknown8AAB48 ; 8A/AB48

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        stz $0889,b
        ldx #$0007
        ldy #$000E

        _AB57
        txa
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _AB90
        inc $0889,b
        jsl rlCheckItemObtainable
        bcc _AB76
        lda #$2000
        sta aCurrentTilemapInfo,b
        bra _AB7C


        _AB76
        lda #$2C00
        sta aCurrentTilemapInfo,b

        _AB7C
        txa
        inc a
        sta wRoutineVariable1,b
        jsr rsUnknown8AABFC
        jsr rsUnknown8AAC51
        jsr rsUnknown8AABAB

        _AB8A
        dec x
        dec y
        dec y
        bpl _AB57
        rts


        _AB90
        lda #$8A00
        sta lR18+1
        lda #$A320
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        bra _AB8A

        .databank 0

        ; 8A/ABAB

    .endsection Unsorted8AAB48Section


    .section Unsorted8AABABSection

      .al
      .xl

      rsUnknown8AABAB ; 8A/ABAB

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8A00
        sta lR18+1
        lda #$ABEA
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        phx
        phy
        jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry
        ply
        plx
        jsl rlGetItemNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/ABEA

    .endsection Unsorted8AABABSection


    .section Unsorted8AABFCSection

      .al
      .xl

      rsUnknown8AABFC ; 8A/ABFC

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8082
        cmp #$0003
        beq _AC36
        cmp #$0007
        beq _AC36
        txa
        inc a
        phx
        phy
        jsl rlGetItemROMDataByInventorySlot
        ply
        plx
        jsl rlGetItemWeaponRank
        ora #$0000
        bmi _AC37
        jsl rlGetInventorySlotItemSellPrice
        sta wR0
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0032
        tax
        lda wR0
        jsl rlUnknown8AB111
        plx

        _AC36
        rts


        _AC37
        lda #$8A00
        sta lR18+1
        lda #$A320
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/AC51

      rsUnknown8AAC51 ; 8A/AC51

        .al
        .xl
        .autsiz
        .databank ?

        txa
        inc a
        jsl rlGetItemDurabilityOfInventorySlot
        sta wR0
        txa
        inc a
        phy
        phx
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemEquipmentType
        plx
        ply
        cmp #$0002
        beq _AC80
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0026
        tax
        lda wR0
        jsl rlUnknown8AB111
        plx
        rts


        _AC80
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8A00
        sta lR18+1
        lda #$ACA0
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$0015
        tax
        jsl rlDrawMenuTextLine
        plx
        rts

        .databank 0

        ; 8A/ACA0

    .endsection Unsorted8AABFCSection


    .section Unsorted8AACA8Section

      .al
      .xl

      rsUnknown8AACA8 ; 8A/ACA8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        stz $0889,b
        ldx #$0007
        ldy #$000E

        _ACB7
        txa
        inc a
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _ACEA
        inc $0889,b
        jsr rsUnknown8AAD05
        jsr rsUnknown8AAC51
        lda wTempVariable1,b
        beq _ACDB
        lda #$2000
        sta aCurrentTilemapInfo,b
        bra _ACE1


        _ACDB
        lda #$2C00
        sta aCurrentTilemapInfo,b

        _ACE1
        jsr rsUnknown8AABAB

        _ACE4
        dec x
        dec y
        dec y
        bpl _ACB7
        rts


        _ACEA
        lda #$8A00
        sta lR18+1
        lda #$A320
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        bra _ACE4

        .databank 0

        ; 8A/AD05

    .endsection Unsorted8AACA8Section


    .section Unsorted8AAD05Section

      .al
      .xl

      rsUnknown8AAD05 ; 8A/AD05

        .al
        .xl
        .autsiz
        .databank ?

        lda wRoutineVariable1,b
        jsl rlGetInventorySlotItemRepairCost
        sta wTempVariable1,b
        txa
        inc a
        phy
        phx
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemEquipmentType
        plx
        ply
        cmp #$0002
        beq _AD43
        jsl rlUnknown87A18C
        bcc _AD2F
        lda wTempVariable1,b
        lsr a
        sta wTempVariable1,b

        _AD2F
        phx
        lda $AA2A,b,y
        xba
        lsr a
        lsr a
        clc
        adc #$0032
        tax
        lda wTempVariable1,b
        jsl rlUnknown8AB111
        plx

        _AD43
        rts

        .databank 0

        ; 8A/AD44

      rsUnknown8AAD44 ; 8A/AD44

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        ldx #$0007
        ldy #$000E

        _AD50
        lda #$8A00
        sta lR18+1
        lda #$A320
        sta lR18
        phx
        lda $AA2A,b,y
        xba
        clc
        adc #$000D
        tax
        jsl rlDrawMenuTextLine
        plx
        dec x
        dec y
        dec y
        bpl _AD50
        rts

        .databank 0

        ; 8A/AD6F

    .endsection Unsorted8AAD05Section


    .section Unsorted8AAD6FSection

      .al
      .xl

      rsUnknown8AAD6F ; 8A/AD6F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $7F8183
        and #$00FF
        tax

        _AD7D
        lda $7F8184,x
        and #$00FF
        asl a
        phx
        tax
        jsr ($8AADA7,x)
        plx
        lda #$2000
        sta aCurrentTilemapInfo,b
        phx
        txa
        asl a
        tay
        lda $AA2A,b,y
        xba
        clc
        adc #$0003
        tax
        jsl rlDrawMenuTextLine
        plx
        dec x
        bpl _AD7D
        rts

        .databank 0

        ; 8A/ADA7

    .endsection Unsorted8AAD6FSection


    .section Unsorted8AB111Section

      .al
      .xl

      rlUnknown8AB111 ; 8A/B111

        .al
        .xl
        .autsiz
        .databank ?

        sta wR0
        stz wR1
        stz wR2
        stz wR3
        stz wR4
        stz wR5
        lda wR0
        cmp #$2710
        bcs _B129
        lda #$00CF
        sta wR1

        _B129
        lda wR0
        cmp #$03E8
        bcs _B135
        lda #$00CF
        sta wR2

        _B135
        lda wR0
        cmp #$0064
        bcs _B141
        lda #$00CF
        sta wR3

        _B141
        lda wR0
        cmp #$000A
        bcs _B14D
        lda #$00CF
        sta wR4

        _B14D
        lda wR0
        cmp #$2710
        bcc _B164
        sec
        sbc #$2710
        sta wR0
        lda wR1
        clc
        adc #$0001
        sta wR1
        bra _B14D


        _B164
        lda wR0
        cmp #$03E8
        bcc _B17B
        sec
        sbc #$03E8
        sta wR0
        lda wR2
        clc
        adc #$0001
        sta wR2
        bra _B164


        _B17B
        lda wR0
        cmp #$0064
        bcc _B192
        sec
        sbc #$0064
        sta wR0
        lda wR3
        clc
        adc #$0001
        sta wR3
        bra _B17B


        _B192
        lda wR0
        cmp #$000A
        bcc _B1A9
        sec
        sbc #$000A
        sta wR0
        lda wR4
        clc
        adc #$0001
        sta wR4
        bra _B192


        _B1A9
        lda wR0
        sta wR5
        lda wR1
        clc
        adc #$0120
        ora #$2400
        sta aBG3TilemapBuffer,x
        lda wR1
        clc
        adc #$0130
        ora #$2400
        sta $7E83C8,x
        lda wR2
        clc
        adc #$0120
        ora #$2400
        sta $7E838A,x
        lda wR2
        clc
        adc #$0130
        ora #$2400
        sta $7E83CA,x
        lda wR3
        clc
        adc #$0120
        ora #$2400
        sta $7E838C,x
        lda wR3
        clc
        adc #$0130
        ora #$2400
        sta $7E83CC,x
        lda wR4
        clc
        adc #$0120
        ora #$2400
        sta $7E838E,x
        lda wR4
        clc
        adc #$0130
        ora #$2400
        sta $7E83CE,x
        lda wR5
        clc
        adc #$0120
        ora #$2400
        sta $7E8390,x
        lda wR5
        clc
        adc #$0130
        ora #$2400
        sta $7E83D0,x
        rtl

        .databank 0

        ; 8A/B230

    .endsection Unsorted8AB111Section


    .section Unsorted8AB23BSection

      .al
      .xl

      rlUnknown8AB23B ; 8A/B23B

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$48
        sta $08C8,b
        lda #$00
        sta $08C9,b
        lda #$80
        sec
        sbc #$48
        sta $08CA,b
        lda #$82
        sta $08CB,b
        lda #$00
        sta $08CC,b
        lda #$00
        sta $08CD,b
        rep #$20
        rtl

        .databank 0

        ; 8A/B261

    .endsection Unsorted8AB23BSection


    .section Unsorted8AB3FESection

      .al
      .xl

      rlUnknown8AB3FE ; 8A/B3FE

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        sta wTempVariable1,b
        jsl rlGetCharacterPortraitDataID
        jsr rlTryGetClassPortraitDataID
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda @l PortraitGraphic00PortraitGraphicPointersEntry,x
        sta lR45
        lda @l $8AB4FA,x
        sta lR45+1
        lda #$7E00
        sta lR47+1
        lda #$8B88
        clc
        adc #$0800
        sta lR47
        phx
        jsl rlDecompressSingle
        plx
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        lda lR18
        clc
        adc #$0800
        sta lR18
        lda @l $8AB7E2,x
        sta lR19+1
        lda @l aPortraitPalettePointers,x
        sta lR19
        rtl

        .databank 0

        ; 8A/B452

    .endsection Unsorted8AB3FESection


    .section Unsorted8ABF27Section

      .al
      .xl

      rsUnknown8ABF27 ; 8A/BF27

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8082
        beq _BF50
        cmp #$0001
        beq _BF60
        cmp #$0002
        beq _BF70
        cmp #$0003
        beq _BF80
        cmp #$0004
        beq _BF90
        cmp #$0005
        beq _BFA0
        cmp #$0006
        beq _BFB0
        cmp #$0007
        beq _BFC0

        _BF50
        lda #$8A00
        sta $7F8087
        lda #$D074
        sta $7F8086
        bra _BFD0


        _BF60
        lda #$8A00
        sta $7F8087
        lda #$D07A
        sta $7F8086
        bra _BFD0


        _BF70
        lda #$8A00
        sta $7F8087
        lda #$D07F
        sta $7F8086
        bra _BFD0


        _BF80
        lda #$8A00
        sta $7F8087
        lda #$D083
        sta $7F8086
        bra _BFD0


        _BF90
        lda #$8A00
        sta $7F8087
        lda #$D085
        sta $7F8086
        bra _BFD0


        _BFA0
        lda #$8A00
        sta $7F8087
        lda #$D086
        sta $7F8086
        bra _BFD0


        _BFB0
        lda #$8A00
        sta $7F8087
        lda #$D087
        sta $7F8086
        bra _BFD0


        _BFC0
        lda #$8A00
        sta $7F8087
        lda #$D08A
        sta $7F8086
        bra _BFD0


        _BFD0
        rts

        .databank 0

        ; 8A/BFD1

      rsUnknown8ABFD1 ; 8A/BFD1

        .al
        .xl
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        pha
        lda #$FFFF
        sta $7F8084
        lda $7F8082
        asl a
        tax
        lda aUnknown8ABFF3,x
        jsl rlUnknown8AFC52
        jsl rlUnknown8A94B6
        pla
        sta wSelectedUnitDataRAMPointer,b
        rts

        .databank 0

        ; 8A/BFF3

    .endsection Unsorted8ABF27Section


    .section Unsorted8ACEB3Section

      .al
      .xl

      aUnknown8ACEB3 ; 8A/CEB3

        ; 89 long pointers into bank $8A.

        .long $8AD0D4, $8AD195, $8AD2D9, $8AD3D3
        .long $8AD727, $8AD4B0, $8AD60D, $8AD60D
        .long $8AD60D, $8AD60D, $8AD60D, $8AD60D
        .long $8AD17B, $8AD2B8, $8AD38F, $8AD48F
        .long $8AD81A, $8AD17B, $8AD18B, $8AD2C8
        .long $8AD39F, $8AD4A0, $8AD81A, $8AD5F9
        .long $8AD0E3, $8AD1D2, $8AD0E3, $8AD44E
        .long $8AD81A, $8AD0F1, $8AD1E0, $8AD0F1
        .long $8AD401, $8AD81A, $8AD101, $8AD1F2
        .long $8AD81A, $8AD45D, $8AD81A, $8AD110
        .long $8AD27B, $8AD363, $8AD110, $8AD110
        .long $8AD121, $8AD28A, $8AD121, $8AD43E
        .long $8AD121, $8AD29F, $8AD29F, $8AD373
        .long $8AD29F, $8AD29F, $8AD154, $8AD205
        .long $8AD81A, $8AD3EF, $8AD81A, $8AD81A
        .long $8AD217, $8AD81A, $8AD401, $8AD81A
        .long $8AD81A, $8AD224, $8AD81A, $8AD40B
        .long $8AD81A, $8AD30A, $8AD30A, $8AD2F8
        .long $8AD30A, $8AD81A, $8AD31C, $8AD31C
        .long $8AD31C, $8AD31C, $8AD728, $8AD351
        .long $8AD351, $8AD351, $8AD351, $8AD351
        .long $8AD32E, $8AD32E, $8AD32E, $8AD32E
        .long $8AD728

        ; Not understood yet: this starts in the middle of a routine.

        .text ROM[$0ACFBE:$0AD071]

    .endsection Unsorted8ACEB3Section


    .section Unsorted8ACFBESection

      .al
      .xl

      rsUnknown8ACFBE ; 8A/CFBE

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sec
        sbc #$0001
        sta wR0
        lda wJoy1New
        bit #$0200
        bne _CFD2
        bit #$0100
        bne _CFEE
        bra _D00C


        _CFD2
        lda $08A1,b
        beq _D00C
        sec
        sbc #$0001
        sta $08A1,b
        lda #$0007
        jsl rlUnknown808FAD
        lda #$FFFF
        sta $7F7670
        bra _D02D


        _CFEE
        lda $08A1,b
        cmp wR0
        bcs _D00C
        clc
        adc #$0001
        sta $08A1,b
        lda #$0007
        jsl rlUnknown808FAD
        lda #$FFFF
        sta $7F7670
        bra _D02D


        _D00C
        lda $08A1,b
        tay
        lda [lR19],y
        and #$00FF
        sec
        sbc #$000D
        sta wR0
        lda #$0020
        clc
        adc #$0004
        clc
        adc #$0008
        clc
        adc #$0008
        sta wR1
        rts


        _D02D
        lda $08A1,b
        tay
        lda [lR20],y
        and #$00FF
        cmp #$00FF
        beq _D00C
        cmp #$0000
        beq _D059
        cmp #$0001
        beq _D05E
        cmp #$0002
        beq _D063
        cmp #$0003
        beq _D068
        cmp #$0004
        beq _D06D
        cmp #$0005
        beq _D06F

        _D059
        jsr rsUnknown8AA9CE
        bra _D00C


        _D05E
        jsr rsUnknown8AAB48
        bra _D00C


        _D063
        jsr rsUnknown8AACA8
        bra _D00C


        _D068
        jsr rsUnknown8AAD44
        bra _D00C


        _D06D
        bra _D00C


        _D06F
        bra _D00C

        .databank 0

        ; 8A/D071

    .endsection Unsorted8ACFBESection


    .section Unsorted8AD975Section

      .al
      .xl

      rlUnknown8AD975 ; 8A/D975

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        jsr rsUnknown8AE05E

        lda $7F7670
        bne +

          jsl rlDMAByStruct
            .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $F000

          bra ++

        +
        lda #0
        sta $7F7670
        jsr rsUnknown8ADA83
        jsr rsUnknown8ADA24

        sep #$20
        lda bBufferINIDISP
        rep #$20
        and #$000F
        bne +

          lda #(`procFadeInByScreenFadingTimer)<<8
          sta lR44+1
          lda #<>procFadeInByScreenFadingTimer
          sta lR44
          jsl rlProcEngineFindProc
          bcs +

            jsl rlProcEngineCreateProc

        +
        lda $0592,b
        asl a
        tax
        jsr (aUnknown8AD9FE,x)

        lda $08AD,b
        bit #$0001
        beq +

          lda #$0020
          sta wR0
          lda #$0060
          sta wR1
          ldx #0
          jsr rsUnknown8A950E
          jsr rsUnknown8ADB04

        +
        lda $08AD,b
        bit #$0002
        beq +

          lda #$00A0
          sta wR0
          lda #$0060
          sta wR1
          ldx #2
          jsr rsUnknown8A9539
          jsr rsUnknown8ADB37

        +
        plp
        plb
        rtl

        .databank 0

    .endsection Unsorted8AD975Section


    .section Unsorted8AD9FESection

      .al
      .xl

      aUnknown8AD9FE ; 8A/D9FE

        .word <>rsUnknown8ADBBD
        .word <>rsUnknown8ADBFF
        .word $DC25
        .word $DCDD
        .word $DCDE

      rlUnknown8ADA08 ; 8A/DA08

        .al
        .autsiz
        .databank ?

        lda #$0044
        tsb $08AD,b
        lda #1
        sta $7F7670
        rtl

        .databank 0

        ; 8A/DA16

    .endsection Unsorted8AD9FESection


    .section Unsorted8ADA16Section

      .al
      .xl

      rlUnknown8ADA16 ; 8A/DA16

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0088
        tsb $08AD,b
        lda #$0001
        sta $7F7670
        rtl

        .databank 0

        ; 8A/DA24

      rsUnknown8ADA24 ; 8A/DA24

        .al
        .xl
        .autsiz
        .databank ?

        lda $08AD,b
        bit #$0040
        beq _DA3F
        jsl rlDMAByStruct

          .structDMAToVRAM $DA6800, $0240, $80, $E800

        lda #$0040
        trb $08AD,b

        _DA3F
        lda $08AD,b
        bit #$0080
        beq _DA5A
        jsl rlDMAByStruct

          .structDMAToVRAM $DA6D00, $0240, $80, $ED00

        lda #$0080
        trb $08AD,b

        _DA5A
        rts

        .databank 0

        ; 8A/DA5B

      rlUnknown8ADA5B ; 8A/DA5B

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        trb $08AD,b
        jsl rlDMAByStruct

          .structDMAToVRAM $DA6A40, $0240, $80, $E800

        rtl

        .databank 0

        ; 8A/DA6F

      rlUnknown8ADA6F ; 8A/DA6F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        trb $08AD,b
        jsl rlDMAByStruct

          .structDMAToVRAM $DA6A40, $0240, $80, $ED00

        rtl

        .databank 0

        ; 8A/DA83

    .endsection Unsorted8ADA16Section


    .section Unsorted8ADA83Section

      .al
      .xl

      rsUnknown8ADA83 ; 8A/DA83

        .al
        .autsiz
        .databank ?

        lda $08AD,b
        bit #$0010
        beq +

          lda $08B2,b
          jsl rlUnknown8A9750
          lda #$0010
          trb $08AD,b
          lda #(`procUnknown8AE147)<<8
          sta lR44+1
          lda #<>procUnknown8AE147
          sta lR44
          jsl rlProcEngineCreateProc

        +
        lda $08AD,b
        bit #$0020
        beq +

          lda $08B4,b
          jsl rlUnknown8A9776
          lda #$0020
          trb $08AD,b
          lda #(`procUnknown8AE199)<<8
          sta lR44+1
          lda #<>procUnknown8AE199
          sta lR44
          jsl rlProcEngineCreateProc

        +
        rts

        .databank 0

      rlUnknown8ADACA ; 8A/DACA

        .al
        .autsiz
        .databank ?

        lda #$0011
        tsb $08AD,b
        lda #1
        sta $7F7670
        rtl

        .databank 0

      rlUnknown8ADAD8 ; 8A/DAD8

        .al
        .autsiz
        .databank ?

        lda #$0022
        tsb $08AD,b
        lda #1
        sta $7F7670
        rtl

        .databank 0

      rlUnknown8ADAE6 ; 8A/DAE6

        .al
        .autsiz
        .databank ?

        lda #(`procUnknown8AE1EB)<<8
        sta lR44+1
        lda #<>procUnknown8AE1EB
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlUnknown8ADAF5 ; 8A/DAF5

        .al
        .autsiz
        .databank ?

        lda #(`procUnknown8AE245)<<8
        sta lR44+1
        lda #<>procUnknown8AE245
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 8A/DB04

    .endsection Unsorted8ADA83Section


    .section Unsorted8ADB04Section

      .al
      .xl

      rsUnknown8ADB04 ; 8A/DB04

        .al
        .xl
        .autsiz
        .databank ?

        lda $08AD,b
        bit #$0004
        beq _DB2F
        lda #$0050
        sta wR0
        lda #$0040
        sta wR1
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$DB30
        lda #$0000
        sta wR4
        lda #$C000
        sta wR5
        jsl rlPushToOAMBuffer

        _DB2F
        rts

        .databank 0

        ; 8A/DB30

    .endsection Unsorted8ADB04Section


    .section Unsorted8ADB37Section

      .al
      .xl

      rsUnknown8ADB37 ; 8A/DB37

        .al
        .xl
        .autsiz
        .databank ?

        lda $08AD,b
        bit #$0008
        beq _DB62
        lda #$0090
        sta wR0
        lda #$0098
        sta wR1
        sep #$20
        lda #$8A
        pha
        plb
        .databank $8A
        rep #$20
        ldy #$DB30
        lda #$0000
        sta wR4
        lda #$0000
        sta wR5
        jsl rlPushToOAMBuffer

        _DB62
        rts

        .databank 0

        ; 8A/DB63

    .endsection Unsorted8ADB37Section


    .section Unsorted8ADBBDSection

      .al
      .xl

      rsUnknown8ADBBD ; 8A/DBBD

        .al
        .autsiz
        .databank ?

        jsl rlResetDialogueEngine

        lda $08AF+1,b
        sta $24+1
        lda $08AF,b
        sta $24
        lda #2
        jsl rlUnknown91811C

        lda #0
        sta aBGPaletteBuffer,b
        lda #2
        sta aDialogue.wUnknown0018D0,b
        ldx #0
        jsr rsUnknown8ADCF9

        lda $08B8,b
        cmp #4
        bne +

          lda #$081E
          sta aDialogue._Slot[1].wDisplayArea,b

        +
        lda #1
        sta $0592,b
        lda #2
        sta $0594,b
        rts

        .databank 0

    .endsection Unsorted8ADBBDSection


    .section Unsorted8ADBFFSection

      .al
      .xl

      rsUnknown8ADBFF ; 8A/DBFF

        .al
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        beq ++

          ldx #$00E0
          ldy #$0038
          lda aDialogue.wSlotOffset,b
          beq +

            ldx #$00E0
            ldy #$00D0

          +
          stx wR0
          sty wR1
          jsl rlDisplayDialogueAPressArrows
          rts

        +
        lda $0594,b
        sta $0592,b
        rts

        .databank 0

        ; 8A/DC25

    .endsection Unsorted8ADBFFSection


    .section Unsorted8ADC25Section

      .al
      .xl

      rsUnknown8ADC25 ; 8A/DC25

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $08B8,b
        cmp #$0000
        beq _DC41
        cmp #$0001
        beq _DC7A
        cmp #$0004
        beq _DC73
        cmp #$0005
        beq _DC5E
        cmp #$0003
        beq _DCB6

        _DC41
        lda #$0000
        sta $0891,b
        jsl rlBuildDeadPlayerCharacterList
        jsl rlUnknown8A9A56
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0011
        sta wGameStateStep,b
        rts


        _DC5E
        lda #$0003
        sta $0592,b
        lda #(`procFadeOutByScreenFadingTimer)<<8
        sta lR44+1
        lda #<>procFadeOutByScreenFadingTimer
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _DC73
        lda #$0004
        sta $0592,b
        rts


        _DC7A
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0012
        sta wGameStateStep,b
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp $089F,b
        bne _DCA9
        lda #$0000
        sta $088B,b
        jsl rlBuildDeadPlayerCharacterList
        jsl rlUnknown8A9A56
        lda $08BA,b
        sta wSelectedUnitDataRAMPointer,b
        rts


        _DCA9
        lda #$0001
        sta $088B,b
        lda $08BA,b
        sta wSelectedUnitDataRAMPointer,b
        rts


        _DCB6
        lda #$0003
        sta $0592,b
        lda #$0000
        sta $0D77,b
        lda #$B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFadeByTimer)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFadeByTimer
        sta lR44
        jsl rlProcEngineFindProc
        bcs _DCDC
        jsl rlProcEngineCreateProc

        _DCDC
        rts

        .databank 0

        ; 8A/DCDD

    .endsection Unsorted8ADC25Section


    .section Unsorted8ADCF9Section

      .al
      .xl

      rsUnknown8ADCF9 ; 8A/DCF9

        .al
        .autsiz
        .databank ?

        ; Only ever enter this routine with aDialogue.wSlotOffset = 0

        lda #$2200
        sta aDialogue.wBaseTile,b,x
        stz aDialogue._Slot[0].wUnknown0018D9,b
        stz aDialogue._Slot[1].wUnknown0018D9,b
        lda #1
        sta aDialogue.wTextSound,b
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[0].lBGBufferPosition+1,b
        sta aDialogue._Slot[1].lBGBufferPosition+1,b
        lda #<>aBG3TilemapBuffer
        sta aDialogue._Slot[0].lBGBufferPosition,b
        sta aDialogue._Slot[1].lBGBufferPosition,b
        lda #$A000 >> 1
        sta aDialogue._Slot[0].wVRAMAddress,b
        lda #$B000 >> 1
        sta aDialogue._Slot[1].wVRAMAddress,b
        lda #pack([30, 6])
        sta aDialogue._Slot[0].wDisplayArea,b
        lda #pack([30, 6])
        sta aDialogue._Slot[1].wDisplayArea,b
        stz aDialogue._Slot[0].wUnknown0018E1,b
        stz aDialogue._Slot[1].wUnknown0018E1,b

        lda #pack([4, 2])
        sta wR1

        sep #$20
        lda #0
        sta wR0+1
        xba
        lda wR1
        sta wR0
        lda wR1+1
        xba
        rep #$20

        lsr a
        lsr a
        clc
        adc wR0
        sta wR0

        ldx aDialogue.wSlotOffset,b
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[0].lBGBufferPosition+1,b,x
        lda #<>aBG3TilemapBuffer
        clc
        adc wR0
        sta aDialogue._Slot[0].lBGBufferPosition,b,x

        lda #pack([4, 21])
        sta wR1

        sep #$20
        lda #0
        sta wR0+1
        xba
        lda wR1
        sta wR0
        lda wR1+1
        xba
        rep #$20

        lsr a
        lsr a
        clc
        adc wR0
        sta wR0

        ldx aDialogue.wSlotOffset,b
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[1].lBGBufferPosition+1,b,x
        lda #<>aBG3TilemapBuffer
        clc
        adc wR0
        sta aDialogue._Slot[1].lBGBufferPosition,b,x
        rts

        .databank 0

        ; 8A/DD98

    .endsection Unsorted8ADCF9Section


    .section Unsorted8AE05ESection

      .al
      .xl

      rsUnknown8AE05E ; 8A/E05E

        .al
        .autsiz
        .databank ?

        lda $08B6,b
        asl a
        tax
        jsr (aUnknown8AE067,x)
        rts

        .databank 0

      aUnknown8AE067 ; 8A/E067

        .word <>rsUnknown8AE076
        .word <>rsUnknown8AE075
        .word <>rsUnknown8AE075
        .word <>rsUnknown8AE075
        .word $E0D7
        .word <>rsUnknown8AE075
        .word <>rsUnknown8AE075

      rsUnknown8AE075 ; 8A/E075

        .al
        .autsiz
        .databank ?

        rts

        .databank 0

      rsUnknown8AE076 ; 8A/E076

        .al
        .autsiz
        .databank ?

        lda $7F80A3
        sec
        sbc #1
        bpl _E0A7

          lda $7F80A5
          clc
          adc #4
          sta $7F80A5
          tax
          lda aUnknown8AE0C7+2,x
          bpl +

            lda #0
            sta $7F80A5
            tax
            lda aUnknown8AE0C7+2,x

          +
          sta $7F80A7
          lda aUnknown8AE0C7,x
        
        _E0A7
        sta $7F80A3

        lda $7F80A7
        asl a
        tax
        lda aUnknown8CA000,x
        sta $0170,b
        lda aUnknown8CA000+2,x
        sta $0172,b
        lda aUnknown8CA000+4,x
        sta $0174,b
        rts

        .databank 0

        ; 8A/E0C7

    .endsection Unsorted8AE05ESection


    .section Table8AE0C7Section

      .al
      .xl

      aUnknown8AE0C7 ; 8A/E0C7

        ; Read by rsUnknown8AE076.

        .word $0004, $0000, $0004, $0001, $0004, $0002, $FFFF, $FFFF
        .word $A3AF, $7F80, $E938, $0001, $2710, $A5AF, $7F80, $6918
        .word $0004, $A58F, $7F80, $BFAA, $E131, $108A, $A90C, $0000
        .word $A58F, $7F80, $BFAA, $E131, $8F8A, $80A7, $BF7F, $E12F
        .word $8F8A, $80A3, $AF7F, $80A7, $0A7F, $BFAA, $CB00, $8D8C
        .word $0186, $40BF, $8CCB, $888D, $BF01, $CB80, $8D8C, $018A
        .word $C0BF, $8CCB, $8C8D, $6001, $0004, $0000, $0004, $0001
        .word $0004, $0002, $0004, $0003, $0004, $0004, $FFFF, $FFFF

        ; 8A/E147

    .endsection Table8AE0C7Section


    .section ProcScript8AE147Section

      .al
      .xl

      procUnknown8AE147 ; 8A/E147

        .structProcInfo "FN", rlProcUnknown8AE147Init, rlProcUnknown8AE147Cycle, aProcUnknown8AE147Code

    .endsection ProcScript8AE147Section


    .section Unsorted8AE14FSection

      .al
      .xl

      rlProcUnknown8AE147Init ; 8A/E14F

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlSavePaletteBufferColorsToRAM

          .byte $88, $9B, $7E, $10, $00, $A0, $01

        ldx #$001E
        lda #$0000

        _E160
        sta aOAMPaletteBuffer.aPalette5,b,x
        dec x
        dec x
        bpl _E160
        lda #$0000
        sta $7F8089
        rtl

        .databank 0

        ; 8A/E16F

      rlProcUnknown8AE147Cycle ; 8A/E16F

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8089
        sta aPaletteFading.wCurrentStep,b
        lda #$0010
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .byte $88, $9B, $10, $00, $A0, $01

        bcs _E191

        _E189
        lda aPaletteFading.wCurrentStep,b
        sta $7F8089
        rtl


        _E191
        jsl rlProcEngineFreeProc
        bra _E189

        .databank 0

        ; 8A/E197

    .endsection Unsorted8AE14FSection


    .section ProcScript8AE197Section

      .al
      .xl

      aProcUnknown8AE147Code ; 8A/E197

        PROC_HALT


        ; 8A/E199

    .endsection ProcScript8AE197Section


    .section Unsorted8AE199Section

      .al
      .xl

      procUnknown8AE199 ; 8A/E199

        .structProcInfo "F2", rlProcUnknown8AE199Init, rlProcUnknown8AE199Cycle, $8AE1E9

    .endsection Unsorted8AE199Section


    .section ProcUnknown8AE199InitSection

      .al
      .xl

      rlProcUnknown8AE199Init ; 8A/E1A1

        .al
        .autsiz
        .databank ?

        jsl rlSavePaletteBufferColorsToRAM

          .long $7E9BA8
          .word len(Palette.Colors)
          .word aOAMPaletteBuffer.aPalette4 - aBGPaletteBuffer

        ldx #size(Palette)-2
        lda #0

          -
          sta aOAMPaletteBuffer.aPalette4,b,x
          dec x
          dec x
          bpl -

        lda #0
        sta $7F808B
        rtl

        .databank 0

    .endsection ProcUnknown8AE199InitSection


    .section Unsorted8AE1C1Section

      .al
      .xl

      rlProcUnknown8AE199Cycle ; 8A/E1C1

        .al
        .autsiz
        .databank ?

        lda $7F808B

        sta aPaletteFading.wCurrentStep,b
        lda #16
        sta aPaletteFading.wMaxSteps,b
        clc
        jsl rlFadePaletteToColors

          .word <>$7E9BA8
          .word $0010
          .word $0180

        bcs +

          -
          lda aPaletteFading.wCurrentStep,b
          sta $7F808B
          rtl

        +
        jsl rlProcEngineFreeProc
        bra -

        .databank 0

      aProcUnknown8AE199Code ; 8A/E1E9

        PROC_HALT

    .endsection Unsorted8AE1C1Section


    .section Unsorted8AE1EBSection

      .al
      .xl

      procUnknown8AE1EB ; 8A/E1EB

        .structProcInfo "FF", rlProcUnknown8AE1EBInit, rlProcUnknown8AE1EBCycle, $8AE243

    .endsection Unsorted8AE1EBSection


    .section Unsorted8AE1F3Section

      .al
      .xl

      rlProcUnknown8AE1EBInit ; 8A/E1F3

        .al
        .autsiz
        .databank ?

        lda #0
        sta $7F808D
        rtl

        .databank 0

      rlProcUnknown8AE1EBCycle ; 8A/E1FB

        .al
        .autsiz
        .databank ?

        lda $7F808D
        sta aPaletteFading.wCurrentStep,b
        lda #0
        sta aPaletteFading.wDesiredColor,b
        lda #8
        sta aPaletteFading.wMaxSteps,b
        clc
        jsl rlFadePaletteToBlack

          .word $E23D

        bcs +

        -
        lda aPaletteFading.wCurrentStep,b
        sta $7F808D
        rtl

        +
        lda #(`procUnknown8AE147)<<8
        sta lR44+1
        lda #<>procUnknown8AE147
        sta lR44
        phx
        jsl rlProcEngineFindProc
        plx
        bcs +

          lda #$0001
          trb $08AD,b

        +
        jsl rlProcEngineFreeProc
        bra -

        .databank 0

        ; 8A/E23D

    .endsection Unsorted8AE1F3Section


    .section ProcScript8AE243Section

      .al
      .xl

      aProcUnknown8AE1EBCode ; 8A/E243

        PROC_HALT


        ; 8A/E245

    .endsection ProcScript8AE243Section


    .section Unsorted8AE245Section

      .al
      .xl

      procUnknown8AE245 ; 8A/E245

        .structProcInfo "FF", rlProcUnknown8AE245Init, rlProcUnknown8AE245Cycle, $8AE29D

      rlProcUnknown8AE245Init ; 8A/E24D

        .al
        .autsiz
        .databank ?

        lda #0
        sta $7F808F
        rtl

        .databank 0

      rlProcUnknown8AE245Cycle ; 8A/E255

        .al
        .autsiz
        .databank ?

        lda $7F808F
        sta aPaletteFading.wCurrentStep,b
        lda #0
        sta aPaletteFading.wDesiredColor,b
        lda #8
        sta aPaletteFading.wMaxSteps,b
        clc
        jsl rlFadePaletteToBlack
          .word <>aUnknown8AE297

        bcs +

          -
          lda aPaletteFading.wCurrentStep,b
          sta $7F808F
          rtl

        +
        lda #(`procUnknown8AE199)<<8
        sta lR44+1
        lda #<>procUnknown8AE199
        sta lR44
        phx
        jsl rlProcEngineFindProc
        plx
        bcs +

          lda #$0002
          trb $08AD,b

        +
        jsl rlProcEngineFreeProc
        bra -

        .databank 0

      aUnknown8AE297 ; 8A/E297

        .word $0182
        .word $000F
        .word $FFFF

      aProcUnknown8AE245Code ; 8A/E29D

        PROC_HALT

        ; 8A/E29F

    .endsection Unsorted8AE245Section


    .section Unsorted8AE2F8Section

      .al
      .xl

      rlUnknown8AE2F8 ; 8A/E2F8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8A
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        lda #$004B
        sta $04BA,b
        jsl rlUnknown809654
        phk
        plb
        .databank $8A
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8A00
        sta $4303,b
        lda #$E4BA
        sta $4302,b
        lda #$2000
        sta $4305,b
        lda #$2000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        jsl rlResetDialogueEngine
        jsr rsUnknown8ABF27
        jsl rlUnknown889268
        lda wEventLocationEntry,b
        pha
        jsl rlUpdateAllLocationEvents
        jsl rlUnknown86C629
        pla
        sta wEventLocationEntry,b
        lda #$0000
        sta wR1
        lda #$0000
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$2800
        sta wR6
        lda #$2C00
        sta wR7
        lda #$3800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        lda #$8A00
        sta lR19+1
        lda #$E4C3
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $DE40C0, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM $DE0200, $0800, $80, $D600

        lda #$8A00
        sta lR19+1
        lda #$E4CB
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$8A00
        sta lR19+1
        lda #$E4D3
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $D76000, $0800, $80, $9800

        lda #$8A00
        sta lR19+1
        lda #$E4BB
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlGetDialogueBoxGraphicsAndPalette
        ldx #$0800
        lda #$00FF

        _E3EF
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bne _E3EF
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        ldx #$01FE

        _E407
        lda aUnknown8CD600,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _E407
        lda #$0001
        jsl rlUnknown8BC43A
        lda #$0002
        jsl rlUnknown8BC467
        jsr rsUnknown8ABFD1
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        lda #$04
        ora #$20
        sta bBufferCOLDATA_1
        lda #$04
        ora #$40
        sta bBufferCOLDATA_2
        lda #$04
        ora #$80
        sta bBufferCOLDATA_3
        rep #$20
        lda $0AD7,b
        beq _E457
        jsl rlUnknown84B550
        cmp #$0002
        beq _E45D

        _E457
        jsl rlUnknown8A9EB7
        bra _E461


        _E45D
        jsl rlUnknown8A9F32

        _E461
        stz $08A1,b
        jsr rsUnknown8AA142
        stz $0592,b
        stz $08A1,b
        stz $08A3,b
        stz $08A5,b
        stz $08A7,b
        lda #$0000
        sta $7F7670
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsUnknown8AA830
        jsr rsUnknown8AA2ED
        jsr rsUnknown8AAD44
        lda #$8A00
        sta lR44+1
        lda #$B230
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #$0004
        sta wGameStateStep,b
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/E4B9

    .endsection Unsorted8AE2F8Section


    .section Unsorted8AFC52Section

      .al
      .xl

      rlUnknown8AFC52 ; 8A/FC52

        .al
        .xl
        .autsiz
        .databank ?

        jsl $8AB45E
        ldx #$001E
        ldy #$001E

        _FC5C
        lda [lR19],y
        sta aOAMPaletteBuffer.aPalette5,b,y
        dec x
        dec x
        dec y
        dec y
        bpl _FC5C
        lda #$0800
        sta wR0
        lda #$6700
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

        ; 8A/FC78

    .endsection Unsorted8AFC52Section


    .section Unsorted8AFC78Section

      .al
      .xl

      rsUnknown8AFC78 ; 8A/FC78

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        pha
        lda $089F,b
        jsl rlUnknown87AE88
        sta wTempVariable1,b
        lda wTempVariable1,b
        ora #$0000
        beq _FCCD
        jsl rlFindCharacterByGenerationID
        jsl rlGetSelectedUnitCharacterID
        sta aDialogue.wUnit1,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitGenerationID
        cmp #$0010
        bcs _FCC5
        sta wTempVariable2,b
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wTempVariable1,b
        jsl rlFindCharacterByGenerationID
        lda wTempVariable2,b
        jsl rlGetLoverPointsWithTarget
        sta wR0
        pla
        sta wSelectedUnitDataRAMPointer,b
        lda wR0
        bra _FCCC


        _FCC5
        lda wTempVariable1,b
        jsl rlGetLoverPointsWithTarget

        _FCCC
        rts


        _FCCD
        pla
        sta wSelectedUnitDataRAMPointer,b
        lda #$0000
        rts

        .databank 0

        ; 8A/FCD5

    .endsection Unsorted8AFC78Section
