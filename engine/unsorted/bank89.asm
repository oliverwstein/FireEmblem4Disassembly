; Code from bank $89 not yet assigned to a game system.


    .section Unsorted8989ADSection

      .al
      .xl

      rsUnknown8989AD ; 89/89AD

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        lda #$0062
        sta wR0
        lda #$000C
        sta wR1
        stz wR4
        stz wR5
        ldy #$A72E
        jsl rlPushToOAMBuffer
        jsr $8989EA
        rts

        .databank 0

        ; 89/89CE

    .endsection Unsorted8989ADSection


    .section Unsorted8989EASection

      .al
      .xl

      rsUnknown8989EA ; 89/89EA

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $89
        jsr $898A41
        lda $7F81D1
        cmp #$0008
        beq _89FE
        jsl $88DBEE

        _89FE
        phk
        plb
        .databank $89
        lda #$000B
        sta wR0
        lda #$0016
        sta wR1
        stz wR4
        stz wR5
        ldx $0772,b
        jsl rlGetSelectedUnitMapSprite
        and #$8000
        bne _8A1F
        ldy #$8A29
        bra _8A22


        _8A1F
        ldy #$8A30

        _8A22
        jsl rlPushToOAMBuffer
        plp
        plb
        .databank $89
        rts

        .databank 0

        ; 89/8A29

    .endsection Unsorted8989EASection


    .section Unsorted898A41Section

      .al
      .xl

      rsUnknown898A41 ; 89/8A41

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F819B
        cmp #$0001
        bne _8A60
        lda wVBlankEnabledFramecount
        and #$0018
        beq _8A60
        stz wR0
        stz wR1
        stz wR4
        stz wR5
        ldy #$8A6D
        jsl rlPushToOAMBuffer

        _8A60
        rts

        .databank 0

        ; 89/8A61

    .endsection Unsorted898A41Section


    .section Unsorted898A7ESection

      .al
      .xl

      rsUnknown898A7E ; 89/8A7E

        .al
        .xl
        .autsiz
        .databank ?

        lda $0304,b
        cmp #$0008
        beq _8A9A
        lda $7F8199
        bne _8A9A
        lda $7F8197
        ldx #$003F
        ldy #$00F3
        jsl $899FA1

        _8A9A
        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        ldy #$8AC1
        lda #$007E
        sta wR0
        lda #$00F1
        sec
        sbc wBufferBG3VOFS
        sta wR1
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/8AC1

    .endsection Unsorted898A7ESection


    .section Unsorted898AF5Section

      .al
      .xl

      rsUnknown898AF5 ; 89/8AF5

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetFirstEquippableWeaponInInventory
        lda wCurrentItemDataROMPointer,b
        beq _8B29
        jsl rlGetItemWeaponType
        tax
        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        lda #$00C8
        sta wR0
        lda #$0049
        sta wR1
        lda @l $898B2A,x
        and #$00FF
        sta wR4
        stz wR5
        phk
        plb
        .databank $89
        ldy #$8B34
        jsl rlPushToOAMBuffer

        _8B29
        rts

        .databank 0

        ; 89/8B2A

    .endsection Unsorted898AF5Section


    .section Unsorted8992ADSection

      .al
      .xl

      rsUnknown8992AD ; 89/92AD

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F81B1
        beq _92E6
        phk
        plb
        .databank $89
        lda #$0000

        _92B8
        sta wR15
        asl a
        tax
        lda $7F81C1,x
        sta wR4
        lda wR15
        asl a
        tax
        lda @l $8992E7,x
        sta wR0
        lda #$0150
        sec
        sbc wBufferBG3VOFS
        sta wR1
        stz wR5
        ldy #$92F7
        jsl rlPushToOAMBuffer
        lda wR15
        inc a
        cmp $7F81B1
        bne _92B8

        _92E6
        rts

        .databank 0

        ; 89/92E7

    .endsection Unsorted8992ADSection


    .section Unsorted8998E1Section

      .al
      .xl

      rlUnknown8998E1 ; 89/98E1

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $7F8199
        beq _9904
        jsl rlGetCharacterNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1E08
        jsl rlDrawMenuTextLine
        bra _991B


        _9904
        lda $7F8197
        bne _991B
        lda #$8900
        sta lR18+1
        lda #$9B93
        sta lR18
        ldx #$1E08
        jsl rlDrawMenuTextLine

        _991B
        lda $7F8193
        beq _994F
        jsl rlGetFactionSlotNameID
        cmp #$00FF
        bne _9938
        lda #$8900
        sta lRoutineVariable+1,b
        lda #$9B93
        sta lRoutineVariable,b
        bra _993C


        _9938
        jsl rlGetSelectedUnitFactionNamePointer

        _993C
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$2008
        jsl rlDrawMenuTextLine
        bra _9989


        _994F
        lda @l wSelectedUnitDataRAMPointer
        pha
        lda #$8900
        sta lRoutineVariable+1,b
        lda #$9B93
        sta lRoutineVariable,b
        jsl rlGetSelectedUnitLoverGenerationID
        cmp #$0000
        beq _9973
        jsl rlFindCharacterByGenerationID
        bcs _9973
        jsl rlGetSelectedUnitNamePointer

        _9973
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$2008
        jsl rlDrawMenuTextLine
        pla
        sta @l wSelectedUnitDataRAMPointer

        _9989
        jsl rlGetSelectedUnitTotalMovementEffect
        ldx #$2120
        stx wR5
        ldx #$0001
        stx wR6
        ldx #$0910
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$0009
        ldy #$0025
        jsl rlUnknown89A085
        lda $7F8193
        bne _9A27
        lda @l wSelectedUnitDataRAMPointer
        pha
        jsl rlUnknown849EA3
        cmp #$0000
        beq _99DA
        jsl rlGetUnitRAMDataPointerByID
        jsl rlGetSelectedUnitStates
        bit #$0200
        bne _99DA
        jsl rlGetSelectedUnitStatus
        cmp #$0003
        beq _99DA
        jsl rlGetSelectedUnitNamePointer
        bra _99E6


        _99DA
        lda #$8900
        sta lRoutineVariable+1,b
        lda #$9B93
        sta lRoutineVariable,b

        _99E6
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$2208
        jsl rlDrawMenuTextLine
        pla
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitArenaLevel
        cmp #$0007
        beq _9A19
        inc a
        ldx #$2120
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0A10
        jsl rlDrawMenuTextNumber
        bra _9A27


        _9A19
        lda #$39E4
        sta $7E8D98
        lda #$39F4
        sta $7E8DD8

        _9A27
        jsl rlGetSelectedUnitMoney
        ldx #$2120
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0990
        jsl rlDrawMenuTextNumber
        lda $7F81A9
        bit #$0200
        beq _9A58
        lda #$8900
        sta lR18+1
        lda #$9B9D
        sta lR18
        ldx #$2A08
        jsl rlDrawMenuTextLine
        bra _9A94


        _9A58
        lda $7F81AB
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89A76D,x
        sta lR18+1
        lda $89A76C,x
        sta lR18
        ldx #$2A08
        jsl rlDrawMenuTextLine
        lda wR0
        beq _9A94
        cmp #$0003
        beq _9A94
        jsl rlGetSelectedUnitStatusDuration
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0A98
        jsl rlDrawMenuTextNumber

        _9A94
        lda #$0000
        jsl rlGetSelectedUnitWeaponRank
        bcc _9AA0
        lda #$0004

        _9AA0
        ldx #$0015
        ldy #$001E
        jsr $89A5AA
        lda #$0001
        jsl rlGetSelectedUnitWeaponRank
        bcc _9AB5
        lda #$0004

        _9AB5
        ldx #$0015
        ldy #$0020
        jsr $89A5AA
        lda #$0002
        jsl rlGetSelectedUnitWeaponRank
        bcc _9ACA
        lda #$0004

        _9ACA
        ldx #$0015
        ldy #$0022
        jsr $89A5AA
        lda #$0003
        jsl rlGetSelectedUnitWeaponRank
        bcc _9ADF
        lda #$0004

        _9ADF
        ldx #$0015
        ldy #$0024
        jsr $89A5AA
        lda #$0004
        jsl rlGetSelectedUnitWeaponRank
        bcc _9AF4
        lda #$0004

        _9AF4
        ldx #$0015
        ldy #$0026
        jsr $89A5AA
        lda #$0005
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B09
        lda #$0004

        _9B09
        ldx #$001D
        ldy #$001E
        jsr $89A5AA
        lda #$0006
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B1E
        lda #$0004

        _9B1E
        ldx #$001D
        ldy #$0020
        jsr $89A5AA
        lda #$0007
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B33
        lda #$0004

        _9B33
        ldx #$001D
        ldy #$0022
        jsr $89A5AA
        lda #$0008
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B48
        lda #$0004

        _9B48
        ldx #$001D
        ldy #$0024
        jsr $89A5AA
        lda #$0009
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B5D
        lda #$0004

        _9B5D
        ldx #$001D
        ldy #$0026
        jsr $89A5AA
        lda $7F8193
        beq _9B8E
        lda #$8900
        sta lR18+1
        lda #$9B93
        sta lR18
        ldx #$2208
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9B93
        sta lR18
        ldx #$2808
        jsl rlDrawMenuTextLine

        _9B8E
        rtl

        .databank 0

        ; 89/9B8F

    .endsection Unsorted8998E1Section


    .section Unsorted899D72Section

      .al
      .xl

      rlUnknown899D72 ; 89/9D72

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2400
        sta wR1
        lda #$0265
        sta wR2
        lda #$000A
        sta wR0
        ldx #$0706
        jsl $89BECC
        lda #$2400
        sta wR1
        lda #$01E5
        sta wR2
        lda #$000B
        sta wR0
        ldx #$0724
        jsl $89BECC
        lda #$2400
        sta wR1
        lda #$026F
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0A24
        jsl $89BECC
        lda #$2400
        sta wR1
        lda #$0280
        sta wR2
        lda #$0009
        sta wR0
        ldx #$0A26
        jsl $89BECC
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #$8900
        sta lR18+1
        lda #$9F15
        sta lR18
        ldx #$1E03
        jsl rlDrawMenuTextLine
        lda $7F8193
        beq _9DFA
        lda #$8900
        sta lR18+1
        lda #$9F0B
        sta lR18
        ldx #$2003
        jsl rlDrawMenuTextLine
        bra _9E0B


        _9DFA
        lda #$8900
        sta lR18+1
        lda #$9F47
        sta lR18
        ldx #$2003
        jsl rlDrawMenuTextLine

        _9E0B
        lda #$8900
        sta lR18+1
        lda #$9F1F
        sta lR18
        ldx #$2204
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F27
        sta lR18
        ldx #$2404
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F2F
        sta lR18
        ldx #$2602
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F51
        sta lR18
        ldx #$2802
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F3B
        sta lR18
        ldx #$2A02
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F5D
        sta lR18
        ldx #$1E12
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F63
        sta lR18
        ldx #$2012
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F69
        sta lR18
        ldx #$2212
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F6F
        sta lR18
        ldx #$2412
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F75
        sta lR18
        ldx #$2612
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F7B
        sta lR18
        ldx #$1E19
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F83
        sta lR18
        ldx #$2019
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F8D
        sta lR18
        ldx #$2219
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F93
        sta lR18
        ldx #$2419
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F9B
        sta lR18
        ldx #$2619
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

        ; 89/9F0B

    .endsection Unsorted899D72Section


    .section Unsorted899FA1Section

      .al
      .xl

      rlUnknown899FA1 ; 89/9FA1

        .al
        .xl
        .autsiz
        .databank ?

        cmp #$0000
        beq _9FD4
        phk
        plb
        .databank $89
        sty wR12
        stx wR13
        sta wR14
        stz wR15
        stz wR4
        stz wR5

        _9FB4
        lda wR12
        sec
        sbc wBufferBG3VOFS
        sta wR1
        lda wR13
        sta wR0
        clc
        adc #$000B
        sta wR13
        ldy #$9FD5
        jsl rlPushToOAMBuffer
        inc wR15
        lda wR15
        cmp wR14
        bne _9FB4

        _9FD4
        rtl

        .databank 0

        ; 89/9FD5

    .endsection Unsorted899FA1Section


    .section Unsorted899FDCSection

      .al
      .xl

      rlUnknown899FDC ; 89/9FDC

        .al
        .autsiz
        .databank ?

        ; DMA background and border tiles based on index $0756
        ; Also gets palette
        ; Different backgrounds were probably planned at some point
        ; but regardless of the index, the code is always the same 

        lda $0756,b
        asl a
        tax
        jsr (aUnknown899FEB,x)
        lda #0
        sta aBGPaletteBuffer,b
        rtl

        .databank 0

      aUnknown899FEB ; 89/9FEB

        .word <>rsUnknown899FF3
        .word <>rsUnknown89A00F
        .word <>rsUnknown89A02B
        .word <>rsUnknown89A047

      rsUnknown899FF3 ; 89/9FF3

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM $DD72B0, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aUnknownDE0000,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        rts

        .databank 0

      rsUnknown89A00F ; 89/A00F

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM $DD72B0, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aUnknownDE0000,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        rts

        .databank 0

      rsUnknown89A02B ; 89/A02B

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM $DD72B0, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aUnknownDE0000,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        rts

        .databank 0

      rsUnknown89A047 ; 89/A047

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM $DD72B0, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aUnknownDE0000,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        rts

        .databank 0

      rlGetDialogueBoxGraphicsAndPalette ; 89/A063

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM $DE2CC0, $0800, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aUnknownDE6200,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        lda #0
        sta aBGPaletteBuffer,b
        rtl

        .databank 0

        ; 89/A085

    .endsection Unsorted899FDCSection


    .section Unsorted89A085Section

      .al
      .xl

      rlUnknown89A085 ; 89/A085

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $89
        cmp #$0000
        beq _A106
        sta $7F82BD
        tya
        and #$00FF
        xba
        lsr a
        lsr a
        sta wR10
        txa
        and #$001F
        asl a
        ora wR10
        sta $7F82BF
        ldx #$0000
        lda $7F82BD
        bpl _A0B2
        dec a
        eor #$FFFF
        inc x

        _A0B2
        sta $7F82C3
        txa
        sta $7F82C1
        ldx #$0000

        _A0BE
        lda $7F82C3
        cmp #$000A
        bmi _A0D2
        sec
        sbc #$000A
        sta $7F82C3
        inc x
        bra _A0BE


        _A0D2
        sta wR10
        stx wR11
        lda $7F82BF
        tax
        ldy #$391B
        lda $7F82C1
        bne _A0E7
        ldy #$391A

        _A0E7
        tya
        sta aBG3TilemapBuffer,x
        inc x
        inc x
        lda wR11
        beq _A0FC
        clc
        adc #$3910
        sta aBG3TilemapBuffer,x
        inc x
        inc x

        _A0FC
        lda wR10
        clc
        adc #$3910
        sta aBG3TilemapBuffer,x

        _A106
        rtl

        .databank 0

        ; 89/A107

    .endsection Unsorted89A085Section


    .section Unsorted89A150Section

      .al
      .xl

      rlUnknown89A150 ; 89/A150

        .al
        .autsiz
        .databank ?

        ; portrait stuff for research

        ; A = portrait ID

        jsl rlDecompressDialoguePortrait

        lda #$0800
        sta wR0

        txa
        asl a
        tay
        lda #$6200
        sta wR1
        phx
        jsl rlDMAByPointer

        plx
        ldx #$001E
        ldy #$001E
        
          -
          lda [$27],y
          sta $0280,b,y
          dec x
          dec x
          dec y
          dec y
          bpl -

        lda $7F8195
        jsl rlGetCharacterPortraitDataID
        cmp #$00F3
        beq +

          lda #$35AD
          sta $029C,b
        
        +
        rtl

        .databank 0

        ; 89/A18C

    .endsection Unsorted89A150Section


    .section Unsorted89A25ASection

      .al
      .xl

      rsUnknown89A25A ; 89/A25A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsr $8989AD
        jsr rsUnknown898AF5
        jsr $898A7E
        lda wJoy1Repeated
        bit #$8000
        bne _A27B
        bit #$0100
        bne _A2AE
        bit #$0200
        bne _A2D1
        jsr $89A4E3
        jsr $8992AD
        rts


        _A27B
        lda #$0021
        jsl rlUnknown808FAD
        ldx #$0700
        lda #$0010
        ldy #$0010
        jsl rlClearTilemapRect
        jsl rlUnknown899D72
        jsl rlUnknown8998E1
        lda #$0001
        sta $0304,b
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8A88, $0400, $80, $B700

        jsr $8992AD
        rts


        _A2AE
        lda $7F81CF
        inc a
        cmp $7F81B1
        beq _A2CA
        sta $7F81CF
        lda #$0007
        jsl rlUnknown808FAD
        jsr rsUnknown89A3C0
        jsr $8992AD

        _A2CA
        jsr $89A4E3
        jsr $8992AD
        rts


        _A2D1
        lda $7F81CF
        dec a
        bmi _A2E6
        sta $7F81CF
        lda #$0007
        jsl rlUnknown808FAD
        jsr rsUnknown89A3C0

        _A2E6
        jsr $89A4E3
        jsr $8992AD
        rts

        .databank 0

        ; 89/A2ED

    .endsection Unsorted89A25ASection


    .section Unsorted89A2EDSection

      .al
      .xl

      rsUnknown89A2ED ; 89/A2ED

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferINIDISP
        clc
        adc $7F819F
        sta bBufferINIDISP
        rep #$20
        and #$00FF
        cmp #$000F
        bcc _A311
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        lda $7F81A1
        sta $0304,b

        _A311
        jsr rsUnknown8989AD
        jsr rsUnknown898AF5
        lda $7F81A1
        cmp #$0002
        beq _A32A
        jsr $898B3B
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rts


        _A32A
        jsr $898D55
        rts

        .databank 0

        ; 89/A32E

      rsUnknown89A32E ; 89/A32E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferINIDISP
        sec
        sbc $7F819F
        sta bBufferINIDISP
        rep #$20
        bpl _A35B
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda $7F81A1
        sta $0304,b
        lda $7F819D
        beq _A35B
        lda $7F81A5
        sta @l wSelectedUnitDataRAMPointer
        rts


        _A35B
        jsr rsUnknown8989AD
        jsr rsUnknown898AF5
        lda wBufferBG2VOFS
        cmp #$0110
        beq _A372
        jsr $898B3B
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rts


        _A372
        jsr $898D55
        rts

        .databank 0

        ; 89/A376

    .endsection Unsorted89A2EDSection


    .section Unsorted89A3C0Section

      .al
      .xl

      rsUnknown89A3C0 ; 89/A3C0

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0700
        lda #$0010
        ldy #$0010
        jsl rlClearTilemapRect
        lda #$0000
        ldx #$00C0

        _A3D3
        sta $7FAF4E,x
        dec x
        dec x
        bne _A3D3
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $7F81CF
        asl a
        tax
        lda $7F81B3,x
        sta $7F82BD
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89AC57,x
        sta lR18+1
        lda $89AC56,x
        sta lR18
        ldx #$1D05
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$ACC5
        sta lMapMenuTilemapRAMEntryPointer,b
        lda $7F81CF
        asl a
        tax
        lda $7F81B3,x
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89ABFA,x
        sta lR18+1
        lda $89ABF9,x
        sta lR18
        ldx #$0000
        jsl rlDrawMenuTextLine
        ldx #$0014

        _A43C
        lda $7FAF4E,x
        sta $7E8B8C,x
        lda $7FAFC6,x
        sta $7E8BCC,x
        dec x
        dec x
        bne _A43C
        ldx #$0014

        _A453
        lda $7FAF62,x
        sta $7E8C0C,x
        lda $7FAFDA,x
        sta $7E8C4C,x
        dec x
        dec x
        bne _A453
        ldx #$0014

        _A46A
        lda $7FAF76,x
        sta $7E8C8C,x
        lda $7FAFEE,x
        sta $7E8CCC,x
        dec x
        dec x
        bne _A46A
        lda #$8900
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$ACB3
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda $7F82BD
        jsl rlCheckIfUnitHasSpecifiedPersonalSkill
        bcs _A4A6
        lda #$8900
        sta lR18+1
        lda #$A4D3
        sta lR18
        bra _A4B0


        _A4A6
        lda #$8900
        sta lR18+1
        lda #$A4C5
        sta lR18

        _A4B0
        ldx #$2704
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8A88, $0400, $80, $B700

        rts

        .databank 0

        ; 89/A4C5

    .endsection Unsorted89A3C0Section


    .section Unsorted89A4E3Section

      .al
      .xl

      rsUnknown89A4E3 ; 89/A4E3

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F81CF
        asl a
        tax
        lda $89A59E,x
        sta wR0
        lda #$00C9
        sta wR1
        stz wR4
        stz wR5
        lda wVBlankEnabledFramecount
        lsr a
        lsr a
        lsr a
        and #$0003
        asl a
        tax
        lda $89A572,x
        tay
        phk
        plb
        .databank $89
        jsl rlPushToOAMBuffer
        lda $7F81CF
        asl a
        tax
        lda $7F81B3,x
        asl a
        tax
        lda @l $89A52D,x
        sta wR4
        stz wR0
        stz wR1
        stz wR5
        ldy #$A56B
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/A52D

    .endsection Unsorted89A4E3Section


    .section Unsorted89A5AASection

      .al
      .xl

      rsUnknown89A5AA ; 89/A5AA

        .al
        .xl
        .autsiz
        .databank ?

        pha
        tya
        xba
        lsr a
        lsr a
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
        lda $89A5D1,x
        phx
        tyx
        sta aBG3TilemapBuffer,x
        txy
        plx
        lda $89A5D3,x
        tyx
        sta $7E83C8,x
        rts

        .databank 0

        ; 89/A5D1

    .endsection Unsorted89A5AASection


    .section Unsorted89A5D1Section

      .al
      .xl

      rsUnknown89A5D1 ; 89/A5D1

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        rol a
        and $393A,b,y
        pld
        and $393B,b,y
        bit $3C39,b
        and $38FF,b,y
        ora #$E439
        and $39F4,b,y
        lda wSelectedUnitDataRAMPointer,b
        sta $7F82C1
        lda $7F8183
        cmp #$DFDC
        beq _A5FB
        lda $7F8193
        beq _A604

        _A5FB
        lda $7F82C1
        sta wSelectedUnitDataRAMPointer,b
        sec
        rts


        _A604
        jsl rlGetSelectedUnitGenerationID
        sta $7F82BD
        sta $7F82BF

        _A610
        lda $7F82BD
        inc a
        cmp #$0019
        bne _A61D
        lda #$0001

        _A61D
        cmp $7F82BF
        beq _A5FB
        sta $7F82BD
        sta @l wRoutineVariable1
        lda #$0000
        jsl rlFindGenerationIDInFactionSlotData
        lda @l wSelectedUnitDataRAMPointer
        beq _A610
        lda wJoy1Input
        bit #$2000
        bne _A651
        jsl rlGetSelectedUnitStates
        bit #$0200
        bne _A610
        jsl rlGetSelectedUnitStatus
        cmp #$0003
        beq _A610

        _A651
        lda #$0027
        jsl rlUnknown80900D
        lda @l wSelectedUnitDataRAMPointer
        sta $7F81A5
        lda #$0003
        sta $7F819F
        sep #$20
        lda #$0C
        sta bBufferINIDISP
        rep #$20
        lda #$000A
        sta $0304,b
        lda #$BBD9
        sta $7F81A3
        lda #$0004
        sta $7F81A1
        lda $7F82C1
        sta wSelectedUnitDataRAMPointer,b
        clc
        rts

        .databank 0

        ; 89/A68C

      rsUnknown89A68C ; 89/A68C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        sta $7F82C1
        lda $7F8183
        cmp #$DFDC
        beq _A6A2
        lda $7F8193
        beq _A6AB

        _A6A2
        lda $7F82C1
        sta wSelectedUnitDataRAMPointer,b
        sec
        rts


        _A6AB
        jsl rlGetSelectedUnitGenerationID
        sta $7F82BD
        sta $7F82BF

        _A6B7
        lda $7F82BD
        dec a
        bne _A6C1
        lda #$0018

        _A6C1
        cmp $7F82BF
        beq _A6A2
        sta $7F82BD
        sta @l wRoutineVariable1
        lda #$0000
        jsl rlFindGenerationIDInFactionSlotData
        lda wSelectedUnitDataRAMPointer,b
        beq _A6B7
        lda wJoy1Input
        bit #$2000
        bne _A6F4
        jsl rlGetSelectedUnitStates
        bit #$0200
        bne _A6B7
        jsl rlGetSelectedUnitStatus
        cmp #$0003
        beq _A6B7

        _A6F4
        lda #$0026
        jsl rlUnknown80900D
        lda #$0003
        sta $7F819F
        sep #$20
        lda #$0C
        sta bBufferINIDISP
        rep #$20
        lda #$000A
        sta $0304,b
        lda #$0004
        sta $7F81A1
        lda #$BBD9
        sta $7F81A3
        lda wSelectedUnitDataRAMPointer,b
        sta $7F81A5
        lda $7F82C1
        sta wSelectedUnitDataRAMPointer,b
        clc
        rts

        .databank 0

        ; 89/A72E

    .endsection Unsorted89A5D1Section


    .section Unsorted89B91FSection

      .al
      .xl

      rlUnknown89B91F ; 89/B91F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsr $89BAF3
        lda $7F8467
        dec a
        tax
        lda $7F8483,x
        and #$00FF
        asl a
        tax
        lda $7F851A,x
        sta wCurrentItemDataRAMPointer,b
        lda $7F8648,x
        sta wCurrentItemDataROMPointer,b
        lda $7F8776,x
        sta $7F847F
        jsl rlGetItemNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        ldx #$0715
        jsl rlDrawMenuTextLine
        jsl rlGetItemEquipmentType
        cmp #$0000
        bne _B969
        jml _B9A6


        _B969
        cmp #$0001
        beq _B975
        jsr $89C1A1
        jml _BAC0


        _B975
        jsl rlGetItemCurrentDurability
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$01F8
        jsl rlDrawMenuTextNumber
        jsl rlGetItemWeaponRank
        cmp #$FFFF
        bne _B996
        lda #$0004

        _B996
        ldx #$0016
        ldy #$0009
        jsr $89C5A2
        jsr $89C1A1
        jml _BAC0


        _B9A6
        lda #$2400
        sta aCurrentTilemapInfo,b
        lda #$8900
        sta lR18+1
        lda #$BAC1
        sta lR18
        ldx #$0B14
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$BACD
        sta lR18
        ldx #$0D15
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$BAD7
        sta lR18
        ldx #$0F15
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$BAE1
        sta lR18
        ldx #$1116
        jsl rlDrawMenuTextLine
        lda #$3800
        sta wR1
        lda #$02A0
        sta wR2
        lda #$0001
        sta wR0
        ldx #$03F6
        jsl rlUnknown89BECC
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetItemRAMStateAndOwner
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetItemCurrentDurability
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$01F8
        jsl rlDrawMenuTextNumber
        jsl rlGetItemWeaponRank
        cmp #$FFFF
        bne _BA36
        lda #$0004

        _BA36
        ldx #$0016
        ldy #$0009
        jsr $89C5A2
        jsl rlGetItemAccuracy
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$02F4
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMight
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0374
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMinimumRange
        ldx #$3920
        stx wR5
        ldx #$0001
        stx wR6
        ldx #$03F4
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMaximumRange
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$03F8
        jsl rlDrawMenuTextNumber
        jsl rlGetItemWeight
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0474
        jsl rlDrawMenuTextNumber
        jsl rlGetItemRAMKillCountAndCritAbility
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0274
        jsl rlDrawMenuTextNumber
        jsr $89C279

        _BAC0
        rtl

        .databank 0

        ; 89/BAC1

    .endsection Unsorted89B91FSection


    .section Unsorted89BECCSection

      .al
      .xl

      rlUnknown89BECC ; 89/BECC

        .al
        .xl
        .autsiz
        .databank ?

        lda wR2
        ora wR1
        sta wR2

        _BED2
        lda wR2
        sta aBG3TilemapBuffer,x
        lda wR2
        clc
        adc #$0010
        sta $7E83C8,x
        inc x
        inc x
        inc wR2
        dec wR0
        bne _BED2
        rtl

        .databank 0

        ; 89/BEEB

    .endsection Unsorted89BECCSection


    .section Unsorted89C021Section

      .al
      .xl

      rlUnknown89C021 ; 89/C021

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        ldx #$2580

        _C027
        sta $7F89CE,x
        dec x
        dec x
        bne _C027
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$CD1C
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        sta $7FB010

        _C042
        lda $7FB010
        tax
        lda $7F8483,x
        and #$00FF
        asl a
        tax
        lda $7F851A,x
        sta wCurrentItemDataRAMPointer,b
        lda $7F8648,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetItemRAMStateAndOwner
        lda wR0
        cmp #$0001
        beq _C08E
        cmp #$0002
        beq _C072
        jml _C0F9


        _C072
        lda $7FB010
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        ora #$001E
        tax
        lda #$3DE3
        sta $7F89D0,x
        lda #$3DF3
        sta $7F89F0,x

        _C08E
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        lda $7FB010
        asl a
        and #$00FF
        xba
        ora #$000A
        tax
        jsl rlDrawMenuTextLine
        jsl rlGetItemEquipmentType
        cmp #$0000
        beq _C0CE
        cmp #$0001
        bne _C0DA
        jsl rlCheckStaffEquippable
        bcs _C0DA
        bra _C0D4


        _C0CE
        jsl rlCheckWeaponEquippable
        bcs _C0DA

        _C0D4
        lda #$2400
        sta aCurrentTilemapInfo,b

        _C0DA
        jsl rlGetItemNamePointer
        lda $7FB010
        asl a
        and #$00FF
        xba
        ora #$0002
        tax
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlDrawMenuTextLine

        _C0F9
        lda $7FB010
        inc a
        sta $7FB010
        cmp $7F846B
        beq _C10C
        jml _C042


        _C10C
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$CD13
        sta lMapMenuTilemapRAMEntryPointer,b
        rtl

        .databank 0

        ; 89/C119

    .endsection Unsorted89C021Section
