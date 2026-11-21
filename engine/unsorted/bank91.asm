; Code from bank $91 not yet assigned to a game system.


    .section Table8D9B65Section

      .al
      .xl

      aUnknown8D9B65 ; 8D/9B65

        ; Read by rsUnknown91DDF1.

        .byte $7B, $9B, $7B, $9B, $89, $9B, $95, $9B, $A2, $9B, $B0, $9B, $BD, $9B, $CA, $9B
        .byte $D1, $9B, $D8, $9B, $DE, $9B, $0A, $AC, $0B, $7E, $09, $15, $36, $0A, $BB, $09
        .byte $31, $38, $C5, $01, $09, $C5, $0B, $7F, $80, $09, $3C, $1C, $38, $C5, $C5, $01
        .byte $0B, $7F, $80, $09, $15, $36, $0A, $BB, $09, $31, $38, $C5, $01, $0A, $B5, $0B
        .byte $81, $09, $15, $36, $0A, $BB, $09, $31, $38, $C5, $01, $0B, $7F, $80, $09, $3C
        .byte $0B, $82, $09, $1C, $C5, $C5, $C5, $01, $0B, $7F, $80, $09, $3C, $0B, $83, $09
        .byte $1C, $C5, $C5, $C5, $01, $0C, $69, $37, $09, $C5, $C5, $01, $0B, $83, $09, $1C
        .byte $C5, $C5, $01, $09, $33, $31, $38, $C5, $01, $09, $C5, $C5, $C5, $C5, $C5, $0B
        .byte $7F, $80, $09, $3E, $10, $37, $2E, $1D, $3D, $C5, $C5, $C5, $C5, $C5, $C5, $C5
        .byte $01

        ; 8D/9BF6

    .endsection Table8D9B65Section


    .section Unsorted91A3ABSection

      .al
      .xl

      rlUnknown91A3AB ; 91/A3AB

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        php
        rep #$20
        jsl rlResetDialogueEngine
        jsl rlActiveSpriteEngineReset
        jsr rsEventEngineClearProcs
        stz wUnknown00171C,b
        stz wUnknown00171E,b
        stz wActiveEventOffset,b
        stz wUnknown001732,b
        stz wUnknown00171A,b
        stz aMovingMapSprites.wState,b
        stz $17BA,b
        stz $17BC,b
        sep #$20
        lda #$00
        sta bBufferTM
        plp
        rtl

        .databank 0

        ; 91/A3D9

    .endsection Unsorted91A3ABSection


    .section Unsorted91A3D9Section

      .al
      .xl

      rlUnknown91A3D9 ; 91/A3D9

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown91A3DE
        rtl

        .databank 0

        ; 91/A3DD

    .endsection Unsorted91A3D9Section


    .section Unsorted91A3DESection

      .al
      .xl

      rsUnknown91A3DE ; 91/A3DE

        .al
        .xl
        .autsiz
        .databank ?

        php
        lda wUnknown00171A,b
        bit #$0001
        beq _A400
        lda wUnknown00171C,b
        asl a
        clc
        adc wUnknown00171C,b
        tax
        lda aUnknown91A405,x
        sta lR19
        lda aUnknown91A405+1,x
        sta lR19+1
        jsl rlUnknown91A402

        _A400
        plp
        rts

        .databank 0

        ; 91/A402

      rlUnknown91A402 ; 91/A402

        .al
        .xl
        .autsiz
        .databank ?

        jml [lR19]

        .databank 0

        ; 91/A405

    .endsection Unsorted91A3DESection


    .section Data91A405Section

      .al
      .xl

      aUnknown91A405 ; 91/A405

        ; Read by rsUnknown91A3DE.

        .byte $0E, $A4, $91, $CA, $A5, $91, $C0, $A6, $91

        ; 91/A40E

    .endsection Data91A405Section


    .section Unsorted91A80DSection

      .al
      .xl

      rlUnknown91A80D ; 91/A80D

        .al
        .autsiz
        .databank ?

        php
        lda bDecompressionArrayFlag,b
        bne _End

          lda aMovingMapSprites.wState,b
          cmp #2
          beq _A85B

            cmp #1
            bne _End

              lda aMovingMapSprites.wCharacterID,b
              sta wRoutineVariable1,b
              lda aMovingMapSprites.wSpawnXCoordinate,b
              sta aEventMovement.wUnitXCoordinate
              lda aMovingMapSprites.wSpawnYCoordinate,b
              sta aEventMovement.wUnitYCoordinate
              lda aMovingMapSprites.wDestinationXCoordinate,b
              sta aEventMovement.wDestinationXCoordinate
              lda aMovingMapSprites.wDestinationYCoordinate,b
              sta aEventMovement.wDestinationYCoordinate
              lda aMovingMapSprites.wUnknown001830,b
              sta aEventMovement.wUnknown7EC494
              lda aMovingMapSprites.wEntryIndex,b
              jsl rlUnknown87B01D
              bcc +

                brk

              +
              lda #2
              sta aMovingMapSprites.wState,b
              bra _End
              
                _A85B
                lda #0
                sta aMovingMapSprites.wState,b

        _End
        plp
        rtl

        .databank 0

        ; 91/A863

    .endsection Unsorted91A80DSection


    .section Unsorted91A928Section

      .al
      .xl

      rlUnknown91A928 ; 91/A928

        .al
        .autsiz
        .databank ?

        jsl rlUnknown91A956
        jsl rlUnknown91A931
        rtl

        .databank 0

      rlUnknown91A931 ; 91/A931

        .al
        .autsiz
        .databank ?

        lda #0
        jsl rlDialogueUpdateSlotOffset

        lda #pack([28, 6])
        sta aDialogue._Slot[0].wDisplayArea,b,x
        lda #$8000 >> 1
        sta aDialogue._Slot[0].wVRAMAddress,b,x
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[0].lBGBufferPosition+1,b,x
        lda #$0086
        clc
        adc #<>aBG3TilemapBuffer
        sta aDialogue._Slot[0].lBGBufferPosition,b,x
        bra +

      rlUnknown91A956 ; 91/A956

        .al
        .autsiz
        .databank ?

        lda #1
        jsl rlDialogueUpdateSlotOffset

        lda #pack([28, 6])
        sta aDialogue._Slot[0].wDisplayArea,b,x
        lda #$9000 >> 1
        sta aDialogue._Slot[0].wVRAMAddress,b,x
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[0].lBGBufferPosition+1,b,x
        lda #$0506
        clc
        adc #<>aBG3TilemapBuffer
        sta aDialogue._Slot[0].lBGBufferPosition,b,x

        +
        jsl rlUnknown91A984
        lda #$2000
        tsb aDialogue.wStatus,b
        rtl

        .databank 0

        ; 91/A984

    .endsection Unsorted91A928Section


    .section Unsorted91AA15Section

      .as
      .xl

      rsUnknown91AA15 ; 91/AA15

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        php
        phx
        phy
        ldy #$0000
        sta wR13
        lda #$2710
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta [lR19],y
        inc x
        inc y
        lda wR10
        sta wR13
        lda #$03E8
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta [lR19],y
        inc x
        inc y
        lda wR10
        sta wR13
        lda #$0064
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta [lR19],y
        inc x
        inc y
        lda wR10
        sta wR13
        lda #$000A
        sta wR14
        jsl rlUnsignedDivide16By8
        lda wR13
        sta [lR19],y
        inc x
        inc y
        sep #$20
        lda wR10
        sta [lR19],y
        ply
        plx
        plp
        rts

        .databank 0

        ; 91/AA6F

    .endsection Unsorted91AA15Section


    .section Unsorted91AA6FSection

      .al
      .xl

      rsUnknown91AA6F ; 91/AA6F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldy #$0000
        sty wR0
        lda [lR19],y
        and #$00FF
        bne _AA86
        cmp wR0
        bne _AA86
        jsr rsUnknown91AAE2
        bra _AA8C


        _AA86
        jsl rlUnknown91AB0D
        inc wR0

        _AA8C
        inc x
        inc y
        lda [lR19],y
        and #$00FF
        bne _AA9E
        cmp wR0
        bne _AA9E
        jsr rsUnknown91AAE2
        bra _AAA4


        _AA9E
        jsl rlUnknown91AB0D
        inc wR0

        _AAA4
        inc x
        inc y
        lda [lR19],y
        and #$00FF
        bne _AAB6
        cmp wR0
        bne _AAB6
        jsr rsUnknown91AAE2
        bra _AABC


        _AAB6
        jsl rlUnknown91AB0D
        inc wR0

        _AABC
        inc x
        inc y
        lda [lR19],y
        and #$00FF
        bne _AACE
        cmp wR0
        bne _AACE
        jsr rsUnknown91AAE2
        bra _AAD4


        _AACE
        jsl rlUnknown91AB0D
        inc wR0

        _AAD4
        inc x
        inc y
        lda [lR19],y
        and #$00FF
        jsl rlUnknown91AB0D
        ply
        plx
        rts

        .databank 0

        ; 91/AAE2

    .endsection Unsorted91AA6FSection


    .section Unsorted91AAE2Section

      .as
      .xl

      rsUnknown91AAE2 ; 91/AAE2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aUnknown91AB0B)<<8
        sta lR18+1
        lda #<>aUnknown91AB0B
        sta lR18
        lda aCurrentTilemapInfo,b
        pha
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlUnknown8788F7
        txa
        clc
        adc #$0100
        tax
        jsl rlUnknown8788F7
        pla
        sta aCurrentTilemapInfo,b
        plx
        rts

        .databank 0

        ; 91/AB0B

      aUnknown91AB0B ; 91/AB0B

        .word $00FF

      rlUnknown91AB0D ; 91/AB0D

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $91
        phx
        phy
        ldy wR0
        phy
        and #$00FF
        cmp #$000A
        bcc _AB22
        jml _AB87


        _AB22
        pha
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR23
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR23+1
        stz wR0
        txa
        sep #$20
        sta wR0
        xba
        sta @l WRMPYA
        lda structMapMenuTilemapData.Width,b,y
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        clc
        adc wR0
        asl a
        clc
        adc lR23
        sta lR23
        lda structMapMenuTilemapData.Width,b,y
        and #$00FF
        asl a
        sta wR0
        pla
        clc
        adc @l aCurrentTilemapInfo
        clc
        adc #$0030
        ora #$2000
        sta [lR23]
        clc
        adc #$0010
        ldy wR0
        sta [lR23],y
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        clc

        _AB86
        rtl


        _AB87
        plx
        stx wR0
        ply
        plx
        plp
        plb
        .databank ?
        sec
        bra _AB86

        .databank 0

    .endsection Unsorted91AAE2Section


    .section Unsorted91AB91Section

      .al
      .xl

      rlUnknown91AB91 ; 91/AB91

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        php
        ldx #$0000
        sta $7E8B88
        cmp #$000C
        bcc _ABA2
        jml _ABEC


        _ABA2
        pha
        pha
        jsr rsUnknown91AC96
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        lda #$8D00
        sta lR19+1
        lda #$9CB4
        sta lR19
        jsl rlUnknown919912
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        lda #$8D00
        sta lR19+1
        lda #$9CB4
        sta lR19
        jsl rlUnknown919912
        pla
        jsr rsUnknown91ACF0
        pla
        beq _ABEC
        cmp #$000A
        bcs _ABEC
        clc
        adc $7E8B8B
        sta $7E8B8B

        _ABEC
        plp
        rtl

        .databank 0

        ; 91/ABEE

    .endsection Unsorted91AB91Section


    .section Unsorted91ABEESection

      .al
      .xl

      rlUnknown91ABEE ; 91/ABEE

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        php
        pha
        jsl rlUnknown91EA86
        tax
        pla
        phx
        jsl rlUnknown91EA7B
        plx
        cpx #$FFFF
        bne _AC05
        inc a
        ldx #$0000

        _AC05
        phx
        pha
        jsr rsUnknown91AC96
        pla
        beq _AC1B
        cmp #$000A
        bcs _AC1B
        clc
        adc $7E8B8B
        sta $7E8B8B

        _AC1B
        pla
        cmp #$0000
        beq _AC77
        pha
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        lda #$8D00
        sta lR19+1
        lda #$9CAC
        sta lR19
        jsl rlUnknown919912
        pla
        cmp #$03E8
        bcc _AC43
        lda #$03E7

        _AC43
        jsl rlSplitNumberIntoDigits
        ldx #$0000

        _AC4A
        lda $7E8B88,x
        cmp #$B1B1
        beq _AC56
        inc x
        bra _AC4A


        _AC56
        lda $7E8B88,x
        clc
        adc wR2
        sta $7E8B88,x
        lda $7E8B89,x
        clc
        adc wR1
        sta $7E8B89,x
        lda $7E8B8A,x
        clc
        adc wR0
        sta $7E8B8A,x

        _AC77
        plp
        rtl

        .databank 0

        ; 91/AC79

    .endsection Unsorted91ABEESection


    .section Unsorted91AC79Section

      .al
      .xl

      rlUnknown91AC79 ; 91/AC79

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        php
        pha
        jsl rlUnknown91EA86
        tax
        pla
        phx
        jsl rlUnknown91EA7B
        plx
        cpx #$FFFF
        bne _AC90
        inc a
        ldx #$0000

        _AC90
        jsl rlUnknown91ACE2
        plp
        rtl

        .databank 0

        ; 91/AC96

    .endsection Unsorted91AC79Section


    .section Unsorted91AC96Section

      .al
      .xl

      rsUnknown91AC96 ; 91/AC96

        .al
        .xl
        .autsiz
        .databank ?

        cmp #$000B
        bcs _ACC9
        cmp #$000A
        bcs _ACBD
        and #$FFFF
        bne _ACB1
        lda #$8D00
        sta lR18+1
        lda #$9C88
        sta lR18
        bra _ACD3


        _ACB1
        lda #$8D00
        sta lR18+1
        lda #$9C8F
        sta lR18
        bra _ACD3


        _ACBD
        lda #$8D00
        sta lR18+1
        lda #$9C96
        sta lR18
        bra _ACD3


        _ACC9
        lda #$8D00
        sta lR18+1
        lda #$9CA5
        sta lR18

        _ACD3
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlUnknown9198F5
        rts

        .databank 0

        ; 91/ACE2

    .endsection Unsorted91AC96Section


    .section Unsorted91ACE2Section

      .al
      .xl

      rlUnknown91ACE2 ; 91/ACE2

        .al
        .xl
        .autsiz
        .databank ?

        asl a
        tax
        lda #$8D00
        sta lR18+1
        lda aUnknown8D9BF6,x
        sta lR18
        rtl

        .databank 0

        ; 91/ACF0

      rsUnknown91ACF0 ; 91/ACF0

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown91ACE2
        lda lR18
        sta lR19
        lda lR18+1
        sta lR19+1
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        jsl rlUnknown919912
        rts

        .databank 0

        ; 91/AD0B

    .endsection Unsorted91ACE2Section


    .section Unsorted91B131Section

      .al
      .xl

      rlUnknown91B131 ; 91/B131

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procDialogue)<<8
        sta lR44+1
        lda #<>procDialogue
        sta lR44
        jsl rlProcEngineFindProc
        bcc _B147
        txa
        lsr a
        jsl rlProcEngineFreeProcByIndex

        _B147
        lda aDialogue.wStatus,b
        beq _B163
        jsl rlUnknown9181F6
        lda aDialogue.wStatus,b
        bne _B159
        jsl rlDialogueFreeHDMA

        _B159
        lda wActiveEventOffset,b
        sec
        sbc #$0004
        sta wActiveEventOffset,b

        _B163
        rtl

        .databank 0

        ; 91/B164

    .endsection Unsorted91B131Section


    .section Unsorted91B164Section

      .al
      .xl

      rlUnknown91B164 ; 91/B164

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$1000
        bne _B1BF
        lda wBufferBG1VOFS
        inc a
        sta wBufferBG1VOFS
        lda wVBlankEnabledFramecount
        and #$0001
        bne _B1C2
        jsl rlUnknown91B1C4
        lda $1864,b
        and #$000F
        cmp #$000F
        bne _B1AC
        lda $185A,b
        sta wR0
        asl a
        clc
        adc wR0
        asl a
        tax
        lda aUnknown91B34C,x
        cmp #$FFFF
        beq _B1BF
        lda $185A,b
        inc a
        sta $185A,b
        and #$001F
        bne _B1AC
        lda #$0080
        sta $18DF,b

        _B1AC
        lda wBufferBG3VOFS
        inc a
        sta wBufferBG3VOFS
        lda wBufferBG2VOFS
        inc a
        sta wBufferBG2VOFS
        lda $1864,b
        inc a
        sta $1864,b
        bra _B1C2


        _B1BF
        sec
        bra _B1C3


        _B1C2
        clc

        _B1C3
        rtl

        .databank 0

        ; 91/B1C4

      rlUnknown91B1C4 ; 91/B1C4

        .al
        .xl
        .autsiz
        .databank ?

        ldy $185A,b
        lda $1864,b
        and #$000F
        cmp #$000C
        bcs _B1E2
        sta wR4
        lda wR4
        cmp #$000C
        bmi _B1DD

        _B1DB
        bra _B1DB


        _B1DD
        asl a
        tax
        jsr (aUnknown91B1E3,x)

        _B1E2
        rtl

        .databank 0

        ; 91/B1E3

    .endsection Unsorted91B164Section


    .section Table91B1E3Section

      .al
      .xl

      aUnknown91B1E3 ; 91/B1E3

        ; Jump table of rlUnknown91B1C4.
        .word <>rsUnknown91B511
        .word <>rsUnknown91B4CD
        .word <>rsUnknown91B1FC
        .word <>rsUnknown91B33C
        .word <>rsUnknown91B33C
        .word <>rsUnknown91B33C
        .word <>rsUnknown91B33C
        .word <>rsUnknown91B33C
        .word <>rsUnknown91B33C
        .word <>rsUnknown91B33C
        .word <>rsUnknown91B4EF
        .word <>rsUnknown91B341

    .endsection Table91B1E3Section


    .section Unsorted91B1FCSection

      .al
      .xl

      rsUnknown91B1FC ; 91/B1FC

        .al
        .xl
        .autsiz
        .databank ?

        phy
        jsr rsUnknown91B496
        ply
        phy
        jsr rsUnknown91B20A
        ply
        jsr rsUnknown91B2E5
        rts

        .databank 0

        ; 91/B20A

      rsUnknown91B20A ; 91/B20A

        .al
        .xl
        .autsiz
        .databank ?

        tya
        pha
        jsr rsUnknown91B4B7
        pha
        lda #$7E00
        sta lR18+1
        pla
        clc
        adc #$9B88
        adc #$000A
        sta lR18
        pla
        sta wR0
        asl a
        clc
        adc wR0
        asl a
        inc a
        inc a
        tax
        lda aUnknown91B34C,x
        cmp #$00FF
        beq _B27B
        cmp #$0000
        beq _B27A
        cmp #$FFFF
        beq _B27A
        jsl rlSplitNumberIntoDigits
        lda wR2
        ora #$2000
        ldy #$0000
        sta [lR18],y
        clc
        adc #$0010
        ldy #$0040
        sta [lR18],y
        lda wR1
        ora #$2000
        ldy #$0002
        sta [lR18],y
        clc
        adc #$0010
        ldy #$0042
        sta [lR18],y
        lda wR0
        ora #$2000
        ldy #$0004
        sta [lR18],y
        clc
        adc #$0010
        ldy #$0044
        sta [lR18],y

        _B27A
        rts


        _B27B
        lda lR18
        clc
        adc #$0008
        sta lR18
        lda lR18+1
        adc #$0000
        sta lR18+1
        lda lR18
        clc
        adc #$0040
        sta lR19
        lda lR18+1
        adc #$0000
        sta lR19+1
        ldx #$0000

        _B29C
        lda aUnknown91B2D3,x
        and #$00FF
        cmp #$003F
        bne _B2AD
        lda #$03FF
        bra _B2BA


        _B2AD
        pha
        and #$000F
        sta wR0
        pla
        and #$00F0
        asl a
        ora wR0

        _B2BA
        ora #$2000
        sta [lR18],y
        cmp #$23FF
        beq _B2C8
        clc
        adc #$0010

        _B2C8
        sta [lR19],y
        inc x
        inc y
        inc y
        cpx #$0012
        bne _B29C
        rts

        .databank 0

        ; 91/B2D3

    .endsection Unsorted91B1FCSection


    .section Data91B2D3Section

      .al
      .xl

      aUnknown91B2D3 ; 91/B2D3

        ; Read by rsUnknown91B20A.

        .word $1E13, $0D10, $0A1B, $3F15, $110C, $181B, $1817, $1815
        .word $2210

        ; 91/B2E5

    .endsection Data91B2D3Section


    .section Unsorted91B2E5Section

      .al
      .xl

      rsUnknown91B2E5 ; 91/B2E5

        .al
        .xl
        .autsiz
        .databank ?

        phy
        ply
        lda #$8D00
        sta lR18+1
        tya
        sta wR0
        asl a
        clc
        adc wR0
        asl a
        inc a
        inc a
        inc a
        inc a
        tax
        lda aUnknown91B34C,x
        beq _B33B
        cmp #$FFFF
        beq _B33B
        sta lR18
        tya
        pha
        jsr rsUnknown91B4B7
        adc #$0014
        tay
        pla
        ldx $18DF,b
        jsl rlUnknown91DF32
        lda #$5000
        sta $18D7,b
        lda #$9B88
        sta $18D4,b
        lda #$401E
        sta $18DB,b
        lda #$0003
        sta aDialogue.wUnknown001892,b
        lda #$0200
        tsb aDialogue.wStatus,b
        lda #$03FF
        sta aDialogue.wClearTile,b

        _B33B
        rts

        .databank 0

        ; 91/B33C

      rsUnknown91B33C ; 91/B33C

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9181F6
        rts

        .databank 0

        ; 91/B341

      rsUnknown91B341 ; 91/B341

        .al
        .xl
        .autsiz
        .databank ?

        lda $18DF,b
        clc
        adc #$0008
        sta $18DF,b
        rts

        .databank 0

        ; 91/B34C

    .endsection Unsorted91B2E5Section


    .section Unsorted91B496Section

      .al
      .xl

      rsUnknown91B496 ; 91/B496

        .al
        .xl
        .autsiz
        .databank ?

        tya
        jsr rsUnknown91B4B7
        pha
        lda #$7E00
        sta lR18+1
        pla
        clc
        adc #$9B88
        sta lR18
        lda #$03FF
        ldy #$0000

        _B4AD
        sta [lR18],y
        inc y
        inc y
        cpy #$0080
        bne _B4AD
        rts

        .databank 0

        ; 91/B4B7

      rsUnknown91B4B7 ; 91/B4B7

        .al
        .xl
        .autsiz
        .databank ?

        tya
        pha
        xba
        lsr a
        and #$0800
        eor #$0800
        sta wR0
        pla
        and #$000F
        xba
        lsr a
        clc
        adc wR0
        rts

        .databank 0

        ; 91/B4CD

      rsUnknown91B4CD ; 91/B4CD

        .al
        .xl
        .autsiz
        .databank ?

        tya
        and #$0010
        beq _B4E1
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $8000

        rts


        _B4E1
        jsl rlDMAByStruct

          .structDMAToVRAM $7E9388, $0800, $80, $8800

        rts

        .databank 0

        ; 91/B4EF

      rsUnknown91B4EF ; 91/B4EF

        .al
        .xl
        .autsiz
        .databank ?

        tya
        and #$0010
        beq _B503
        jsl rlDMAByStruct

          .structDMAToVRAM $7E9B88, $0800, $80, $9000

        rts


        _B503
        jsl rlDMAByStruct

          .structDMAToVRAM $7EA388, $0800, $80, $9800

        rts

        .databank 0

        ; 91/B511

      rsUnknown91B511 ; 91/B511

        .al
        .xl
        .autsiz
        .databank ?

        tya
        pha
        jsr rsUnknown91B4B7
        pha
        lda #$7E00
        sta lR18+1
        pla
        clc
        adc #$8B88
        sta lR18
        pla
        sta wR0
        asl a
        clc
        adc wR0
        asl a
        tax
        lda aUnknown91B34C,x
        xba
        lsr a
        tax
        ldy #$0000

        _B536
        lda aUnknown91B546,x
        sta [lR18],y
        inc x
        inc x
        inc y
        inc y
        cpy #$0080
        bne _B536
        rts

        .databank 0

        ; 91/B546

    .endsection Unsorted91B496Section


    .section Unsorted91BA46Section

      .al
      .xl

      rlUnknown91BA46 ; 91/BA46

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000

        _BA49
        lda aUnknown91BA6C,x
        sta @l aBGPaletteBuffer,x
        inc x
        inc x
        cpx #$0008
        bne _BA49
        rtl

        .databank 0

        ; 91/BA59

      rlUnknown91BA59 ; 91/BA59

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000

        _BA5C
        lda aUnknown91BA7C,x
        sta @l $000180,x
        inc x
        inc x
        cpx #$0020
        bne _BA5C
        rtl

        .databank 0

        ; 91/BA6C

    .endsection Unsorted91BA46Section


    .section Data91BA6CSection

      .al
      .xl

      aUnknown91BA6C ; 91/BA6C

        ; Read by rlUnknown91BA46.

        .word $0000, $318C, $7674, $24E7, $0000, $0000, $0000, $0000

        ; 91/BA7C

      aUnknown91BA7C ; 91/BA7C

        ; Read by rlUnknown91BA59.

        .word $3000, $0800, $0C00, $1000, $1020, $1420, $1820, $1C20
        .word $1C20, $2040, $2440, $2840, $2C40, $2C40, $3060, $3460

        ; 91/BA9C

    .endsection Data91BA6CSection


    .section Unsorted91D616Section

      .al
      .xl

      rlUnknown91D616 ; 91/D616

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 91/D617

      rlUnknown91D617 ; 91/D617

        .al
        .xl
        .autsiz
        .databank ?

        inc wGameStateRoutine1,b
        rtl

        .databank 0

        ; 91/D61B

      rlUnknown91D61B ; 91/D61B

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $91
        lda wGameStateStep,b
        asl a
        tax
        jsr (aUnknown91D62A,x)
        plp
        plb
        .databank $91
        rtl

        .databank 0

        ; 91/D62A

    .endsection Unsorted91D616Section


    .section Table91D62ASection

      .al
      .xl

      aUnknown91D62A ; 91/D62A

        ; Jump table of rlUnknown91D61B.
        .word <>rsUnknown91D844
        .word $D853
        .word <>rsUnknown91D8A0
        .word $D8BE
        .word <>rsUnknown91D8EB
        .word <>rsUnknown91D90D
        .word <>rsUnknown91D945
        .word $D95F
        .word <>rsUnknown91D995
        .word <>rsUnknown91D9FA
        .word $DA09
        .word <>rsUnknown91DA25
        .word $DA34
        .word <>rsUnknown91DBEE
        .word $DC01
        .word <>rsUnknown91DC13
        .word <>rsUnknown91DC1A
        .word <>rsUnknown91DC37
        .word <>rsUnknown91DC50
        .word <>rsUnknown91DC6D
        .word <>rsUnknown91E583
        .word <>rsUnknown91E5B2
        .word <>rsUnknown91E5F4
        .word <>rsUnknown91E622
        .word <>rsUnknown91E650
        .word <>rsUnknown91E650._E667
        .word <>rsUnknown91E692
        .word <>rsUnknown91E6BA
        .word <>rsUnknown91E6D8
        .word <>rsUnknown91E710
        .word <>rsUnknown91E726
        .word <>rsUnknown91E732
        .word <>rsUnknown91E74E
        .word <>rsUnknown91E780
        .word <>rsUnknown91D683
        .word $D691
        .word <>rsUnknown91D6BC
        .word <>rsUnknown91D6C8
        .word <>rsUnknown91D6D1
        .word <>rsUnknown91D6DA
        .word <>rsUnknown91D6E3
        .word <>rsUnknown91D69B
        .word <>rsUnknown91D6BB
        .word <>rsUnknown91D682

    .endsection Table91D62ASection


    .section Unsorted91D682Section

      .al
      .xl

      rsUnknown91D682 ; 91/D682

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 91/D683

    .endsection Unsorted91D682Section


    .section Unsorted91D683Section

      .al
      .xl

      rsUnknown91D683 ; 91/D683

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown88800F
        jsl rlUnknown91E99B
        lda #$0000
        sta aSave,b
        stz wUnknown000D79,b
        lda #$0029
        sta wGameStateStep,b
        rts

        .databank 0

        ; 91/D69B

    .endsection Unsorted91D683Section


    .section Unsorted91D69BSection

      .al
      .xl

      rsUnknown91D69B ; 91/D69B

        .al
        .autsiz
        .databank ?

        lda #(`aWorldMapEvents)<<8
        sta lR18+1

        lda wCurrentChapter,b
        cmp #$0012
        bcc +

          lda #0

        +
        asl a
        tax
        lda aWorldMapEvents,x
        sta lR18
        jsl rlUnknown80C1FC
        inc wGameStateStep,b
        rts

        .databank 0

        ; 91/D6BB

    .endsection Unsorted91D69BSection


    .section Unsorted91D6BBSection

      .al
      .xl

      rsUnknown91D6BB ; 91/D6BB

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 91/D6BC

      rsUnknown91D6BC ; 91/D6BC

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        inc wGameStateStep,b
        rts

        .databank 0

        ; 91/D6C8

      rsUnknown91D6C8 ; 91/D6C8

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown91F748
        jsl rlUnknown91F935
        rts

        .databank 0

        ; 91/D6D1

      rsUnknown91D6D1 ; 91/D6D1

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown91F838
        jsl rlUnknown91F935
        rts

        .databank 0

        ; 91/D6DA

      rsUnknown91D6DA ; 91/D6DA

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown91F88A
        jsl rlUnknown91F935
        rts

        .databank 0

        ; 91/D6E3

    .endsection Unsorted91D6BBSection


    .section Unsorted91D6E3Section

      .al
      .xl

      rsUnknown91D6E3 ; 91/D6E3

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown91F907
        jsl rlUnknown91F935
        rts

        .databank 0

        ; 91/D6EC

    .endsection Unsorted91D6E3Section


    .section Unsorted91D6ECSection

      .al
      .xl

      rlUnknown91D6EC ; 91/D6EC

        .al
        .xl
        .autsiz
        .databank ?

        php
        jsr rsUnknown91DF6D
        lda #(`gcUnknown9CB90D)<<8
        sta lR18+1
        lda #<>gcUnknown9CB90D
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $6000

        jsl rlClearSpriteExtBuffer
        stz wNextFreeSpriteOffset,b
        jsl rlHideSprites
        lda #$03FF
        jsl rlFillBG3Page0TilemapBuffer
        jsl rlDMAByStruct

          .structDMAToVRAM g2bppBlankTile, $0010, $80, $DFF0

        lda #(`gcUnknown9C8000)<<8
        sta lR18+1
        lda #<>gcUnknown9C8000
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $4800, $80, $0000

        lda #(`gcUnknown9CBB20)<<8
        sta lR18+1
        lda #<>gcUnknown9CBB20
        sta lR18
        lda #(`aBG2TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG2TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aBG2TilemapBuffer, $0800, $80, $7800

        lda #(`gcUnknown9CBBB7)<<8
        sta lR18+1
        lda #<>gcUnknown9CBBB7
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$7B88
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $8000

        lda #(`gcUnknown9CBFA1)<<8
        sta lR18+1
        lda #<>gcUnknown9CBFA1
        sta lR18
        lda #(`aBGPaletteBuffer)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlResetDialogueEngine
        jsl rlDialogueFreeHDMA
        lda #$5000
        sta $18D7,b
        jsr rsUnknown91DD9B
        jsr rsUnknown91DCEA
        jsl rlResetHDMAEngine
        jsl rlUnknown91E07A
        lda #$0000
        sta $185A,b
        lda #$FFFF
        sta $1864,b
        stz $1866,b
        plp
        rtl

        .databank 0

        ; 91/D7E8

    .endsection Unsorted91D6ECSection


    .section Unsorted91D7F8Section

      .al
      .xl

      rsUnknown91D7F8 ; 91/D7F8

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 91/D7F9

    .endsection Unsorted91D7F8Section


    .section Unsorted91D7F9Section

      .al
      .xl

      rsUnknown91D7F9 ; 91/D7F9

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        stz $1858,b
        jsl rlUnknown91E940
        and #$FFFF
        beq _D80B
        lda #$0003
        jsr rsUnknown91D839

        _D80B
        lda #$0004
        jsr rsUnknown91D839
        jsl rlUnknown91E940
        and #$FFFF
        beq _D81D
        lda #$0005

        _D81D
        jsl rlUnknown91E940
        and #$FFFF
        beq _D82C
        lda #$0006
        jsr rsUnknown91D839

        _D82C
        lda $1858,b
        cmp $185A,b
        bcs _D838
        dec a
        sta $185A,b

        _D838
        rts

        .databank 0

        ; 91/D839

    .endsection Unsorted91D7F9Section


    .section Unsorted91D839Section

      .al
      .xl

      rsUnknown91D839 ; 91/D839

        .al
        .xl
        .autsiz
        .databank ?

        ldx $1858,b
        sta @l $00185C,x
        inc $1858,b
        rts

        .databank 0

        ; 91/D844

    .endsection Unsorted91D839Section


    .section Unsorted91D844Section

      .al
      .xl

      rsUnknown91D844 ; 91/D844

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown91D7F9
        jsr rsUnknown91DCB9
        lda #$0001
        jsr rlUnknown91DC92
        jsr rsUnknown91D7F8
        lda $185A,b
        jsl rlUnknown91E2E2
        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _D898
        lda wMusicID,b
        bne _D898
        jsr rsUnknown91E275
        jsr rsUnknown91DCDE
        lda wJoy1New
        bit #$0080
        beq _D898
        lda #$000A
        jsl rlPlaySoundEffect
        ldx $185A,b
        lda @l $00185C,x
        and #$00FF
        tax
        lda aUnknown91D899,x
        and #$00FF
        sta wGameStateStep,b
        lda #$0001
        sta $1864,b

        _D898
        rts

        .databank 0

        ; 91/D899

    .endsection Unsorted91D844Section


    .section Data91D899Section

      .al
      .xl

      aUnknown91D899 ; 91/D899

        ; Read by rsUnknown91D844.

        .byte $00, $02, $02, $06, $1C, $09, $0B

        ; 91/D8A0

    .endsection Data91D899Section


    .section Unsorted91D8A0Section

      .al
      .xl

      rsUnknown91D8A0 ; 91/D8A0

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        jsr rsUnknown91DB6D
        jsr rsUnknown91DCB9
        lda #$0003
        jsr rlUnknown91DC92
        lda aSave,b
        cmp #$0004
        bcc _D8BA
        lda #$0000

        _D8BA
        inc a
        sta $1864,b
        jsr rsUnknown91DA64
        cmp #$0002
        beq _D8DD
        cmp #$0001
        bne _D8EA
        lda #$000E
        jsl rlPlaySoundEffect
        lda $1864,b
        sta aSave.wMenuOperation,b
        inc wGameStateStep,b
        bra _D8EA


        _D8DD
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0005
        sta wGameStateStep,b

        _D8EA
        rts

        .databank 0

        ; 91/D8EB

      rsUnknown91D8EB ; 91/D8EB

        .al
        .xl
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #$000F
        beq _D904
        lda $1864,b
        jsl rlUnknown91E2E2
        lda wVBlankEnabledFramecount
        and #$0001
        bne _D90C
        dec bBufferINIDISP
        bra _D90C


        _D904
        lda aSave.wMenuOperation,b
        bne _D90C
        jsr rsUnknown91D921

        _D90C
        rts

        .databank 0

        ; 91/D90D

    .endsection Unsorted91D8A0Section


    .section Unsorted91D90DSection

      .al
      .xl

      rsUnknown91D90D ; 91/D90D

        .al
        .xl
        .autsiz
        .databank ?

        lda $1864,b
        jsl rlUnknown91E2E2
        dec bBufferINIDISP
        lda bBufferINIDISP
        and #$000F
        bne _D920
        jsr rsUnknown91D921

        _D920
        rts

        .databank 0

        ; 91/D921

    .endsection Unsorted91D90DSection


    .section Unsorted91D921Section

      .al
      .xl

      rsUnknown91D921 ; 91/D921

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown000D79,b
        bit #$0400
        beq _D92F
        jsl rlUnknown81B301
        bra _D944


        _D92F
        lda wUnknown000D79,b
        bit #$0020
        beq _D941
        jsl rlUnknown80BB7C
        jsl rlUnknown81AB26
        bra _D944


        _D941
        jsr rsUnknown91DBD0

        _D944
        rts

        .databank 0

        ; 91/D945

    .endsection Unsorted91D921Section


    .section Unsorted91D945Section

      .al
      .xl

      rsUnknown91D945 ; 91/D945

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        jsr rsUnknown91DB6D
        jsr rsUnknown91DCB9
        jsl rlUnknown91ECEF
        and #$0003
        inc a
        sta $1864,b
        lda #$0007
        jsr rlUnknown91DC92
        jsr rsUnknown91DA64
        cmp #$0002
        beq _D994
        cmp #$0001
        bne _D994
        jsl rlUnknown88800F
        lda $1864,b
        dec a
        jsl rlUnknown91E932
        bcs _D994
        lda #$000A
        jsl rlPlaySoundEffect
        lda #$00E0
        jsl rlSendSoundCommand
        lda $1864,b
        ora #$8000
        sta aSave.wMenuOperation,b
        inc wGameStateStep,b

        _D994
        rts

        .databank 0

        ; 91/D995

    .endsection Unsorted91D945Section


    .section Unsorted91D995Section

      .al
      .xl

      rsUnknown91D995 ; 91/D995

        .al
        .xl
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #$000F
        beq _D9AE
        lda $1864,b
        jsl rlUnknown91E2E2
        lda wVBlankEnabledFramecount
        and #$0001
        bne _D9C4
        dec bBufferINIDISP
        bra _D9C4


        _D9AE
        lda aSave.wMenuOperation,b
        bne _D9C4
        lda wCurrentTurn,b
        cmp #$FFFF
        beq _D9C0
        jsr rsUnknown91DBA8
        bra _D9C4


        _D9C0
        jsl rlUnknown81B301

        _D9C4
        rts

        .databank 0

        ; 91/D9C5

    .endsection Unsorted91D995Section


    .section Unsorted91D9FASection

      .al
      .xl

      rsUnknown91D9FA ; 91/D9FA

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0005
        jsr rsUnknown91DB6D
        jsr rsUnknown91DCB9
        lda #$000A
        jsr rlUnknown91DC92
        jsr rsUnknown91DA64
        cmp #$0002
        beq _DA24
        cmp #$0001
        bne _DA24
        lda wJoy1New
        bit #$0080
        beq _DA24
        lda #$000A
        jsl rlPlaySoundEffect

        _DA24
        rts

        .databank 0

        ; 91/DA25

    .endsection Unsorted91D9FASection


    .section Unsorted91DA25Section

      .al
      .xl

      rsUnknown91DA25 ; 91/DA25

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0006
        jsr rsUnknown91DB6D
        jsr rsUnknown91DCB9
        lda #$000C
        jsr rlUnknown91DC92
        jsr rsUnknown91DA64
        cmp #$0002
        beq _DA63
        cmp #$0001
        bne _DA63
        lda $1864,b
        dec a
        jsl rlUnknown91E932
        bcs _DA63
        lda #$000E
        jsl rlPlaySoundEffect
        lda $1864,b
        dec a
        jsl rlUnknown91E9BB
        jsr rsUnknown91DB6D
        lda #$000C
        jsr rsUnknown91DCAC

        _DA63
        rts

        .databank 0

        ; 91/DA64

    .endsection Unsorted91DA25Section


    .section Unsorted91DA64Section

      .al
      .xl

      rsUnknown91DA64 ; 91/DA64

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $1864,b
        jsl rlUnknown91E2E2
        jsr rsUnknown91DCDE
        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _DAD2
        lda wMusicID,b
        bne _DAD2
        lda $1866,b
        bne _DAD6
        jsr rsUnknown91E2AA
        lda wJoy1New
        bit #$0080
        beq _DAA6
        lda wGameStateStep,b
        cmp #$0007
        beq _DACD
        lda #$000A
        jsl rlPlaySoundEffect
        jsr rsUnknown91DB17
        lda #$0001
        sta $1866,b
        bra _DAD2


        _DAA6
        lda wJoy1New
        bit #$8000
        beq _DAD2
        lda wGameStateStep,b
        cmp #$0003
        beq _DAC8
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$FFFF
        sta $1864,b
        lda #$0000
        sta wGameStateStep,b

        _DAC8
        lda #$0002
        bra _DAD5


        _DACD
        lda #$0001
        bra _DAD5


        _DAD2
        lda #$0000

        _DAD5
        rts


        _DAD6
        lda wJoy1Repeated
        bit #$0C00
        beq _DAE8
        lda $1866,b
        dec a
        eor #$0001
        inc a
        sta $1866,b

        _DAE8
        lda wJoy1New
        bit #$8080
        beq _DB13
        jsr rsUnknown91DB4B
        lda wJoy1New
        bit #$8000
        bne _DB09
        lda $1866,b
        cmp #$0001
        bne _DB09
        stz $1866,b
        lda #$0001
        bra _DB16


        _DB09
        lda #$0021
        jsl rlPlaySoundEffect
        stz $1866,b

        _DB13
        lda #$0000

        _DB16
        rts

        .databank 0

        ; 91/DB17

    .endsection Unsorted91DA64Section


    .section Unsorted91DB17Section

      .al
      .xl

      rsUnknown91DB17 ; 91/DB17

        .al
        .xl
        .autsiz
        .databank ?

        lda #$20C0
        ldx wGameStateStep,b
        cpx #$0003
        beq _DB25
        lda #$20D0

        _DB25
        ldx #$0134
        jsr rsUnknown91DB38
        ldx #$01B4
        lda #$20E0
        jsr rsUnknown91DB38
        jsr rsUnknown91DCEA
        rts

        .databank 0

        ; 91/DB38

      rsUnknown91DB38 ; 91/DB38

        .al
        .xl
        .autsiz
        .databank ?

        ldy #$0004

        _DB3B
        sta aBG3TilemapBuffer,x
        inc a
        sta $7E83C8,x
        inc a
        inc x
        inc x
        dec y
        bne _DB3B
        rts

        .databank 0

        ; 91/DB4B

      rsUnknown91DB4B ; 91/DB4B

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0134
        ldy #$0004
        lda #$03FF

        _DB54
        sta aBG3TilemapBuffer,x
        sta $7E83C8,x
        sta $7E8408,x
        sta $7E8448,x
        inc x
        inc x
        dec y
        bne _DB54
        jsr rsUnknown91DCEA
        rts

        .databank 0

        ; 91/DB6D

    .endsection Unsorted91DB17Section


    .section Unsorted91DB6DSection

      .al
      .xl

      rsUnknown91DB6D ; 91/DB6D

        .al
        .xl
        .autsiz
        .databank ?

        stz $1858,b
        jsr rsUnknown91D839
        lda #$0000
        jsr rsUnknown91DB98
        jsr rsUnknown91D839
        lda #$0001
        jsr rsUnknown91DB98
        jsr rsUnknown91D839
        lda #$0002
        jsr rsUnknown91DB98
        jsr rsUnknown91D839
        lda #$0003
        jsr rsUnknown91DB98
        jsr rsUnknown91D839
        rts

        .databank 0

        ; 91/DB98

      rsUnknown91DB98 ; 91/DB98

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown91E932
        bcs _DBA4
        clc
        adc #$000B
        bra _DBA7


        _DBA4
        lda #$000A

        _DBA7
        rts

        .databank 0

        ; 91/DBA8

    .endsection Unsorted91DB6DSection


    .section Unsorted91DBA8Section

      .al
      .xl

      rsUnknown91DBA8 ; 91/DBA8

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferTM
        and #$13
        sta bBufferTM
        rep #$20
        lda #$0100
        tsb wUnknown000D79,b
        stz wGameStateRoutine1,b
        lda #$AEEA
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .databank 0

        ; 91/DBD0

    .endsection Unsorted91DBA8Section


    .section Unsorted91DBD0Section

      .al
      .xl

      rsUnknown91DBD0 ; 91/DBD0

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        sta $0D77,b
        stz wGameStateRoutine1,b
        lda #$B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .databank 0

        ; 91/DBEE

    .endsection Unsorted91DBD0Section


    .section Unsorted91DBEESection

      .al
      .xl

      rsUnknown91DBEE ; 91/DBEE

        .al
        .xl
        .autsiz
        .databank ?

        lda $1856,b
        inc $1856,b
        cmp $1858,b
        beq _DBFE
        jsr rsUnknown91DCF8
        bra rsUnknown91DBEE


        _DBFE
        inc wGameStateStep,b
        jsr rsUnknown91DCEA
        sep #$20
        lda #$16
        sta bBufferTM
        rep #$20
        lda $1854,b
        sta wGameStateStep,b
        rts

        .databank 0

        ; 91/DC13

    .endsection Unsorted91DBEESection


    .section Unsorted91DC13Section

      .al
      .xl

      rsUnknown91DC13 ; 91/DC13

        .al
        .xl
        .autsiz
        .databank ?

        lda #$000D
        sta wGameStateStep,b
        rts

        .databank 0

        ; 91/DC1A

    .endsection Unsorted91DC13Section


    .section Unsorted91DC1ASection

      .al
      .xl

      rsUnknown91DC1A ; 91/DC1A

        .al
        .xl
        .autsiz
        .databank ?

        lda $1864,b
        jsl rlUnknown91E2E2
        ldx $1864,b
        lda @l $00185C,x
        and #$00FF
        cmp #$000B
        bcc _DC33
        jsr rsUnknown91DDF1

        _DC33
        inc wGameStateStep,b
        rts

        .databank 0

        ; 91/DC37

    .endsection Unsorted91DC1ASection


    .section Unsorted91DC37Section

      .al
      .xl

      rsUnknown91DC37 ; 91/DC37

        .al
        .xl
        .autsiz
        .databank ?

        lda $1864,b
        jsl rlUnknown91E2E2
        jsl rlUnknown9181F6
        lda aDialogue.wStatus,b
        bne _DC4F
        lda aDialogue.wUnknown0018C9,b
        bne _DC4F
        inc wGameStateStep,b

        _DC4F
        rts

        .databank 0

        ; 91/DC50

    .endsection Unsorted91DC37Section


    .section Unsorted91DC50Section

      .al
      .xl

      rsUnknown91DC50 ; 91/DC50

        .al
        .xl
        .autsiz
        .databank ?

        lda $1864,b
        jsl rlUnknown91E2E2
        ldx $1864,b
        lda @l $00185C,x
        and #$00FF
        cmp #$000B
        bcc _DC69
        jsr rsUnknown91DE4D

        _DC69
        inc wGameStateStep,b
        rts

        .databank 0

        ; 91/DC6D

    .endsection Unsorted91DC50Section


    .section Unsorted91DC6DSection

      .al
      .xl

      rsUnknown91DC6D ; 91/DC6D

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $1864,b
        jsl rlUnknown91E2E2
        jsl rlUnknown9181F6
        lda aDialogue.wStatus,b
        bne _DC91
        lda aDialogue.wUnknown0018C9,b
        bne _DC91
        lda $1864,b
        jsr rsUnknown91DCF8
        jsr rsUnknown91DCEA
        lda $1854,b
        sta wGameStateStep,b

        _DC91
        rts

        .databank 0

        ; 91/DC92

    .endsection Unsorted91DC6DSection


    .section Unsorted91DC92Section

      .al
      .xl

      rlUnknown91DC92 ; 91/DC92

        .al
        .xl
        .autsiz
        .databank ?

        sta $1854,b
        lda #$000D
        sta wGameStateStep,b
        stz $1866,b
        stz $1856,b
        lda #$03FF
        jsl rlFillBG3Page0TilemapBuffer
        jml rsUnknown91DBEE

        .databank 0

        ; 91/DCAC

      rsUnknown91DCAC ; 91/DCAC

        .al
        .xl
        .autsiz
        .databank ?

        sta $1854,b
        lda #$0010
        sta wGameStateStep,b
        stz $1866,b
        rts

        .databank 0

        ; 91/DCB9

      rsUnknown91DCB9 ; 91/DCB9

        .al
        .xl
        .autsiz
        .databank ?

        lda #$060C
        ldx $1864,b
        cpx #$FFFF
        beq _DCC7
        lda #$0606

        _DCC7
        sta $1862,b
        lda #$0005
        sec
        sbc $1858,b
        asl a
        sta wR0
        lda $1863,b
        clc
        adc wR0
        sta $1863,b
        rts

        .databank 0

        ; 91/DCDE

    .endsection Unsorted91DC92Section


    .section Unsorted91DCDESection

      .al
      .xl

      rsUnknown91DCDE ; 91/DCDE

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0001
        bne _DCE9
        dec wBufferBG1HOFS
        inc wBufferBG1VOFS

        _DCE9
        rts

        .databank 0

        ; 91/DCEA

      rsUnknown91DCEA ; 91/DCEA

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $9000

        rts

        .databank 0

        ; 91/DCF8

    .endsection Unsorted91DCDESection


    .section Unsorted91DCF8Section

      .al
      .xl

      rsUnknown91DCF8 ; 91/DCF8

        .al
        .xl
        .autsiz
        .databank ?

        sta wR7
        tax
        lda #$7E00
        sta $18D5,b
        lda $1862,b
        and #$FF00
        lsr a
        lsr a
        lsr a
        sta wR0
        lda $1862,b
        and #$00FF
        clc
        adc wR0
        asl a
        clc
        adc #$8388
        sta $18D4,b
        lda $1864,b
        cmp #$FFFF
        beq _DD34
        cpx #$0000
        bne _DD34
        lda $18D4,b
        clc
        adc #$FF4C
        sta $18D4,b

        _DD34
        txa
        xba
        tay
        phx
        lda @l $00185C,x
        and #$00FF
        dec a
        asl a
        tax
        lda aUnknown91DDD5,x
        plx
        pha
        lda $18D5,b
        sta lR18+1
        sta lR19+1
        lda $18D4,b
        sta lR18
        clc
        adc #$0040
        sta lR19
        phx
        ldx #$2000
        jsl rlUnknown87BFB0
        and #$FFFF
        beq _DD73
        jsl rlUnknown87BFD9
        inc a
        cmp wR7
        bne _DD73
        ldx #$3000

        _DD73
        stx wR6
        plx
        lda $1864,b
        cmp #$FFFF
        beq _DD83
        cpx #$0000
        bne _DD88

        _DD83
        ldx #$000B
        bra _DD8B


        _DD88
        ldx #$0018

        _DD8B
        pla
        clc
        adc wR6

        _DD8F
        sta [lR18],y
        inc a
        sta [lR19],y
        inc a
        inc y
        inc y
        dec x
        bne _DD8F
        rts

        .databank 0

        ; 91/DD9B

    .endsection Unsorted91DCF8Section


    .section Unsorted91DD9BSection

      .al
      .xl

      rsUnknown91DD9B ; 91/DD9B

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        sta $1856,b

        _DDA1
        lda $1856,b
        jsr rsUnknown91DDF1

        _DDA7
        jsl rlUnknown9181F6
        lda aDialogue.wStatus,b
        bne _DDA7
        lda aDialogue.wUnknown0018C9,b
        bne _DDA7
        lda $1856,b
        jsr rsUnknown91DE4D

        _DDBB
        jsl rlUnknown9181F6
        lda aDialogue.wStatus,b
        bne _DDBB
        lda aDialogue.wUnknown0018C9,b
        bne _DDBB
        lda $1856,b
        inc $1856,b
        cmp #$000E
        bne _DDA1
        rts

        .databank 0

        ; 91/DDD5

    .endsection Unsorted91DD9BSection


    .section Table91DDD5Section

      .al
      .xl

      aUnknown91DDD5 ; 91/DDD5

        ; Read by rsUnknown91DCF8, rsUnknown91DDF1, rsUnknown91DE4D.

        .word $0000, $0020, $0040, $0060, $0080, $00A0, $00C0, $00D0
        .word $00E0, $0100, $0140, $0180, $01C0, $0200

        ; 91/DDF1

    .endsection Table91DDD5Section


    .section Unsorted91DDF1Section

      .al
      .xl

      rsUnknown91DDF1 ; 91/DDF1

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        pha
        jsr rsUnknown91DEA1
        jsl rlResetDialogueEngine
        jsl rlDialogueFreeHDMA
        lda #$5000
        sta $18D7,b
        pla
        pha
        ldx #$8D00
        stx lR18+1
        and #$00FF
        cmp #$000B
        bcc _DE2D
        sbc #$000B
        pha
        lda #(`aUnknown91DE4C)<<8
        sta lR18+1
        lda #<>aUnknown91DE4C
        sta lR18
        pla
        jsl rlUnknown91E932
        bcs _DE35
        jsl rlUnknown91ABEE
        bra _DE35


        _DE2D
        asl a
        tax
        lda aUnknown8D9B65,x
        sta lR18

        _DE35
        pla
        dec a
        asl a
        tax
        lda aUnknown91DDD5,x
        tax
        lda #$9B88
        sta $18D4,b
        ldy #$0000
        jsl rlUnknown91DF32
        rts

        .databank 0

        ; 91/DE4C

    .endsection Unsorted91DDF1Section


    .section Unsorted91DE4CSection

      .al
      .xl

      aUnknown91DE4C ; 91/DE4C

        .byte $01

      rsUnknown91DE4D ; 91/DE4D

        .al
        .xl
        .autsiz
        .databank ?

        pha
        jsl rlResetDialogueEngine
        jsl rlDialogueFreeHDMA
        lda #$5000
        sta $18D7,b
        pla
        ldx #$8D00
        stx lR18+1
        and #$00FF
        cmp #$000B
        bcc _DE9E
        pha
        sbc #$000B
        pha
        lda #$9100
        sta lR18+1
        lda #$DE9F
        sta lR18
        pla
        jsl rlUnknown91E932
        bcs _DE84
        jsl rlUnknown91AC79

        _DE84
        pla
        dec a
        asl a
        tax
        lda aUnknown91DDD5,x
        clc
        adc #$0014
        tax
        lda #$9B88
        sta $18D4,b
        ldy #$0000
        jsl rlUnknown91DF32

        _DE9E
        rts

        .databank 0

    .endsection Unsorted91DE4CSection


    .section Unsorted91DEA1Section

      .al
      .xl

      rsUnknown91DEA1 ; 91/DEA1

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        ldy #$0000
        lda #$0000

        _DEB2
        sta [lR18],y
        inc y
        cpy #$0400
        bne _DEB2
        pla
        cmp #$000E
        beq _DEFA
        cmp #$000D
        beq _DEEC
        cmp #$000C
        beq _DEDE
        cmp #$000B
        beq _DED0
        rts


        _DED0
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0400, $80, $B400

        rts


        _DEDE
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0400, $80, $B800

        rts


        _DEEC
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0400, $80, $BC00

        rts


        _DEFA
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0400, $80, $C000

        rts

        .databank 0

        ; 91/DF08

    .endsection Unsorted91DEA1Section


    .section Unsorted91DF32Section

      .al
      .xl

      rlUnknown91DF32 ; 91/DF32

        .al
        .xl
        .autsiz
        .databank ?

        stx $18DF,b
        sty $18DD,b
        lda #$0000
        jsl rlDialogueStartText
        lda #$2000
        trb aDialogue.wStatus,b
        lda #$2000
        sta aDialogue.wBaseTile,b
        lda #$1E1E
        sta $18DB,b
        lda #$FFFF
        sta aDialogue.wTextSpeed,b
        sta aDialogue.wPauseTimer,b
        lda #$000A
        sta aDialogue.wUnknown001892,b
        lda #$0200
        tsb aDialogue.wStatus,b
        lda #$0180
        tsb aDialogue.wStatus,b
        rtl

        .databank 0

        ; 91/DF6D

    .endsection Unsorted91DF32Section


    .section Unsorted91DF6DSection

      .al
      .xl

      rsUnknown91DF6D ; 91/DF6D

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$61
        sta bBufferOBSEL
        lda #$09
        sta bBufferBGMODE
        lda #$00
        sta bBufferMOSAIC
        lda #$3C
        sta bBufferBG1SC
        lda #$42
        sta bBufferBG2SC
        lda #$4A
        sta bBufferBG3SC
        lda #$4C
        sta bBufferBG4SC
        lda #$00
        sta bBufferBG12NBA
        lda #$55
        sta bBufferBG34NBA
        lda #$00
        sta wBufferBG1HOFS
        sta wBufferBG1HOFS+1
        lda #$00
        sta wBufferBG1VOFS
        sta wBufferBG1VOFS+1
        lda #$00
        sta wBufferBG2HOFS
        sta wBufferBG2HOFS+1
        lda #$20
        sta wBufferBG2VOFS
        lda #$00
        sta wBufferBG2VOFS+1
        lda #$06
        sta wBufferBG3HOFS
        lda #$00
        sta wBufferBG3HOFS+1
        lda #$00
        sta wBufferBG3VOFS
        sta wBufferBG3VOFS+1
        lda #$00
        sta wBufferBG4HOFS
        sta wBufferBG4HOFS+1
        lda #$00
        sta wBufferBG4VOFS
        sta wBufferBG4VOFS+1
        lda #$00
        sta bBufferW12SEL
        lda #$00
        sta bBufferW34SEL
        lda #$00
        sta bBufferWOBJSEL
        lda #$00
        sta bBufferWBGLOG
        lda #$00
        sta bBufferWOBJLOG
        lda #$16
        sta bBufferTM
        lda #$01
        sta bBufferTS
        lda #$07
        sta bBufferTMW
        lda #$04
        sta bBufferTSW
        lda #$02
        sta bBufferCGWSEL
        lda #$84
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        lda #$00
        sta bBufferSETINI
        plp
        rts

        .databank 0

        ; 91/E006

    .endsection Unsorted91DF6DSection


    .section Unsorted91E07ASection

      .al
      .xl

      rlUnknown91E07A ; 91/E07A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$9100
        sta lR44+1
        lda #$E089
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rtl

        .databank 0

        ; 91/E089

    .endsection Unsorted91E07ASection


    .section Unsorted91E095Section

      .al
      .xl

      rlUnknown91E095 ; 91/E095

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta wDialogueBoxHDMAYPixelPosition
        rtl

        .databank 0

        ; 91/E09D

      rlUnknown91E09D ; 91/E09D

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 91/E09E

    .endsection Unsorted91E095Section


    .section Unsorted91E275Section

      .al
      .xl

      rsUnknown91E275 ; 91/E275

        .al
        .xl
        .autsiz
        .databank ?

        lda $185A,b
        jsr rsUnknown91E27F
        sta $185A,b
        rts

        .databank 0

        ; 91/E27F

      rsUnknown91E27F ; 91/E27F

        .al
        .xl
        .autsiz
        .databank ?

        pha
        tax
        lda wJoy1Repeated
        bit #$0400
        bne _E293
        bit #$0800
        beq _E29A
        txa
        beq _E29A
        dec x
        bra _E29A


        _E293
        inc x
        cpx $1858,b
        bcc _E29A
        dec x

        _E29A
        stx wR0
        pla
        cmp wR0
        beq _E2A8
        lda #$0006
        jsl rlPlaySoundEffect

        _E2A8
        txa
        rts

        .databank 0

        ; 91/E2AA

    .endsection Unsorted91E275Section


    .section Unsorted91E2AASection

      .al
      .xl

      rsUnknown91E2AA ; 91/E2AA

        .al
        .xl
        .autsiz
        .databank ?

        lda $1864,b
        jsr rsUnknown91E2B4
        sta $1864,b
        rts

        .databank 0

        ; 91/E2B4

      rsUnknown91E2B4 ; 91/E2B4

        .al
        .xl
        .autsiz
        .databank ?

        pha
        tax
        lda wJoy1Repeated
        bit #$0400
        bne _E2CB
        bit #$0800
        beq _E2D2
        txa
        cpx #$0001
        beq _E2D2
        dec x
        bra _E2D2


        _E2CB
        inc x
        cpx $1858,b
        bcc _E2D2
        dec x

        _E2D2
        stx wR0
        pla
        cmp wR0
        beq _E2E0
        lda #$0006
        jsl rlPlaySoundEffect

        _E2E0
        txa
        rts

        .databank 0

        ; 91/E2E2

      rlUnknown91E2E2 ; 91/E2E2

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown91E448
        jsl rlUnknown91E405
        jsl rlUnknown91E2EF
        rtl

        .databank 0

        ; 91/E2EF

      rlUnknown91E2EF ; 91/E2EF

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        ldx #$0000

        _E2F5
        cpx $1856,b
        bcc _E2FE
        jml _E389


        _E2FE
        stx wR7
        phx
        lda $1864,b
        cmp #$FFFF
        beq _E31A
        cpx #$0000
        bne _E31A
        lda #$0068
        sta wR0
        lda #$0028
        sta wR1
        bra _E339


        _E31A
        txa
        asl a
        asl a
        pha
        lda $1862,b
        inc a
        and #$00FF
        asl a
        asl a
        asl a
        sta wR0
        pla
        clc
        adc $1863,b
        inc a
        inc a
        and #$00FF
        asl a
        asl a
        asl a
        sta wR1

        _E339
        lda #$0000
        cpx #$0000
        beq _E34A
        ldy $1864,b
        cpy #$FFFF
        beq _E34A
        inc a

        _E34A
        pha
        sep #$20
        lda #$91
        pha
        plb
        .databank $91
        rep #$20
        pla
        asl a
        tax
        lda @l aUnknown91E397,x
        tay
        lda #$0000
        sta wR4
        lda #$2200
        sta wR5
        lda aSave.wMenuOperation,b
        bit #$8000
        bne _E384
        jsl rlUnknown87BFB0
        and #$FFFF
        beq _E384
        jsl rlUnknown87BFD9
        inc a
        cmp wR7
        bne _E384
        lda #$2400
        sta wR5

        _E384
        jsl rlPushToOAMBuffer
        plx

        _E389
        inc x
        cpx $1858,b
        bcs _E393
        jml _E2F5


        _E393
        ply
        plx
        plb
        .databank $91
        rtl

        .databank 0

        ; 91/E397

    .endsection Unsorted91E2AASection


    .section Table91E397Section

      .al
      .xl

      aUnknown91E397 ; 91/E397

        ; Read by rlUnknown91E2EF.

        .word $E3C0, $E39B, $0007, $C3E8, $00E8, $0831, $E8C2, $3102
        .word $C228, $02E8, $4831, $E8C2, $3102, $C268, $02E8, $8831
        .word $E8C2, $3102, $C298, $04E8, $0431, $E000, $E8C3, $3100
        .word $C200, $02E8, $2031, $E8C2, $3102, $C230, $04E8, $0931
        .word $0800, $0000, $3100, $0008, $1010, $0831, $2000, $3120
        .word $0018, $0200, $1831, $1000, $3112, $0018, $2220, $2831
        .word $0000, $3106, $0028, $1610, $2831, $2000, $3126

        ; 91/E405

    .endsection Table91E397Section


    .section Unsorted91E405Section

      .al
      .xl

      rlUnknown91E405 ; 91/E405

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        lda $1866,b
        beq _E444
        dec a
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$0020
        sta wR1
        lda #$00D0
        sta wR0
        jsl rlUnknown91E472
        sep #$20
        lda #$91
        pha
        plb
        .databank $91
        rep #$20
        ldy #$E3D6
        lda #$00B9
        sta wR0
        lda #$0018
        sta wR1
        lda #$0000
        sta wR4
        lda #$2200
        sta wR5
        jsl rlPushToOAMBuffer

        _E444
        ply
        plx
        plb
        .databank $91
        rtl

        .databank 0

        ; 91/E448

      rlUnknown91E448 ; 91/E448

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        asl a
        asl a
        pha
        lda $1862,b
        and #$00FF
        asl a
        asl a
        asl a
        sta wR0
        pla
        clc
        adc $1863,b
        and #$00FF
        asl a
        asl a
        asl a
        sta wR1
        jsl rlUnknown85BCD4
        jsl rlUnknown91E472
        ply
        plx
        plb
        .databank ?
        rtl

        .databank 0

        ; 91/E472

      rlUnknown91E472 ; 91/E472

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        sep #$20
        lda #$91
        pha
        plb
        .databank $91
        rep #$20
        lda wVBlankEnabledFramecount
        and #$003F
        tax
        lda @l aUnknown91E4B3,x
        and #$00FF
        asl a
        tax
        lda @l aUnknown91E4F3,x
        tay
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        ply
        plx
        plb
        .databank $91
        rtl

        .databank 0

        ; 91/E4A3

    .endsection Unsorted91E405Section


    .section Table91E4B3Section

      .al
      .xl

      aUnknown91E4B3 ; 91/E4B3

        ; Read by rlUnknown91E472.

        .word $0000, $0000, $0000, $0101, $0101, $0101, $0202, $0202
        .word $0202, $0303, $0303, $0303, $0303, $0303, $0303, $0303
        .word $0303, $0303, $0303, $0303, $0303, $0303, $0303, $0303
        .word $0303, $0303, $0303, $0303, $0303, $0303, $0303, $0303

        ; 91/E4F3

    .endsection Table91E4B3Section


    .section Data91E4F3Section

      .al
      .xl

      aUnknown91E4F3 ; 91/E4F3

        ; Read by rlUnknown91E472.

        .word $E4FB, $E507, $E513, $E51F, $0002, $01E8, $2200, $D830
        .word $0001, $3020, $0002, $01E8, $2400, $D830, $0001, $3020
        .word $0002, $01E8, $2600, $D830, $0001, $3020, $0002, $01E8
        .word $2800, $D830, $0001, $3020

        ; 91/E52B

    .endsection Data91E4F3Section


    .section Unsorted91E52BSection

      .al
      .xl

      rlUnknown91E52B ; 91/E52B

        .al
        .xl
        .autsiz
        .databank ?

        php
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlEnableActiveSpriteEngine
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlUnknown91A6C0
        lda #$00FF
        sta wUnknown053E,b
        lda #$00C0
        jsl rlQueueSoundCommand
        stz wUnknown00171A,b
        plp
        rtl

        .databank 0

        ; 91/E55A

    .endsection Unsorted91E52BSection


    .section Unsorted91E55ASection

      .al
      .xl

      rlUnknown91E55A ; 91/E55A

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown91E565
        lda #$0014
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 91/E565

      rlUnknown91E565 ; 91/E565

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        sta wGameStateRoutine2,b
        lda #$0005
        sta wGameStateRoutine1,b
        lda #<>rsUnknown80F560
        sta wVBlankPointer
        lda #<>rsUnknown80F542
        sta wMainLoopPointer
        stz aSave.wMenuOperation,b
        jsl rlUnknown91E92E
        rtl

        .databank 0

        ; 91/E583

    .endsection Unsorted91E55ASection


    .section Unsorted91E583Section

      .al
      .xl

      rsUnknown91E583 ; 91/E583

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsr rsUnknown91DF6D
        sep #$20
        lda #$02
        sta bBufferTM
        rep #$20
        lda #(`gcUnknown9CB90D)<<8
        sta lR18+1
        lda #<>gcUnknown9CB90D
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        inc wGameStateStep,b
        rts

        .databank 0

        ; 91/E5B2

      rsUnknown91E5B2 ; 91/E5B2

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne _E5F3
        lda #$03FF
        jsl rlFillBG3Page0TilemapBuffer
        jsl rlDMAByStruct

          .structDMAToVRAM g2bppBlankTile, $0010, $80, $DFF0

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $6000

        lda #(`gcUnknown9CBB20)<<8
        sta lR18+1
        lda #<>gcUnknown9CBB20
        sta lR18
        lda #(`aBG2TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG2TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        inc wGameStateStep,b

        _E5F3
        rts

        .databank 0

        ; 91/E5F4

      rsUnknown91E5F4 ; 91/E5F4

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne _E621
        jsl rlDMAByStruct

          .structDMAToVRAM aBG2TilemapBuffer, $0800, $80, $7800

        lda #(`gcUnknown9CBBB7)<<8
        sta lR18+1
        lda #<>gcUnknown9CBBB7
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$7B88
        sta lR19
        jsl rlAppendDecompList
        inc wGameStateStep,b

        _E621
        rts

        .databank 0

        ; 91/E622

      rsUnknown91E622 ; 91/E622

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne _E64F
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $8000

        lda #(`gcUnknown9CBFA1)<<8
        sta lR18+1
        lda #<>gcUnknown9CBFA1
        sta lR18
        lda #(`aBGPaletteBuffer)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer
        sta lR19
        jsl rlAppendDecompList
        inc wGameStateStep,b

        _E64F
        rts

        .databank 0

        ; 91/E650

      rsUnknown91E650 ; 91/E650

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlResetDialogueEngine
        jsl rlDialogueFreeHDMA
        lda #$5000
        sta $18D7,b
        lda #$0001
        sta $1856,b
        inc wGameStateStep,b

        _E667
        jsl rlUnknown9181F6
        lda aDialogue.wStatus,b
        bne _E691
        lda aDialogue.wUnknown0018C9,b
        bne _E691
        lda $1856,b
        inc $1856,b
        cmp #$000E
        beq _E688
        lda $1856,b
        jsr rsUnknown91DDF1
        bra _E667


        _E688
        lda #$0001
        sta $1856,b
        inc wGameStateStep,b

        _E691
        rts

        .databank 0

        ; 91/E692

      rsUnknown91E692 ; 91/E692

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9181F6
        lda aDialogue.wStatus,b
        bne _E6B9
        lda aDialogue.wUnknown0018C9,b
        bne _E6B9
        lda $1856,b
        inc $1856,b
        cmp #$000E
        beq _E6B3
        lda $1856,b
        jsr rsUnknown91DE4D
        bra rsUnknown91E692


        _E6B3
        jsr rsUnknown91DCEA
        inc wGameStateStep,b

        _E6B9
        rts

        .databank 0

        ; 91/E6BA

      rsUnknown91E6BA ; 91/E6BA

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlResetHDMAEngine
        jsl rlUnknown91E07A
        lda #$0000
        sta $185A,b
        lda #$FFFF
        sta $1864,b
        stz $1866,b
        lda #$0000
        sta wGameStateStep,b
        rts

        .databank 0

        ; 91/E6D8

      rsUnknown91E6D8 ; 91/E6D8

        .al
        .xl
        .autsiz
        .databank ?

        stz $185A,b
        stz $1864,b
        inc wGameStateStep,b
        lda #$03FF
        jsl rlFillBG3Page0TilemapBuffer
        jsr rsUnknown91DCEA
        jsl rlResetDialogueEngine
        jsl rlDialogueFreeHDMA
        jsl rlResetHDMAEngine
        lda #$0080
        sta $18DF,b
        jsl rlUnknown80B0D3
        jsl rlUnknown91BA59
        jsl rlUnknown91BA46
        lda #$0004
        sta wMusicID,b
        rts

        .databank 0

        ; 91/E710

      rsUnknown91E710 ; 91/E710

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne _E725
        jsl rlDMAByStruct

          .structDMAToVRAM $7E9D88, $0600, $80, $A000

        inc wGameStateStep,b

        _E725
        rts

        .databank 0

        ; 91/E726

      rsUnknown91E726 ; 91/E726

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$16
        sta bBufferTM
        rep #$20
        inc wGameStateStep,b
        rts

        .databank 0

        ; 91/E732

      rsUnknown91E732 ; 91/E732

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown91B1C4
        lda $1864,b
        inc a
        sta $1864,b
        cmp #$0010
        bcc _E74D
        inc $185A,b
        lda #$0020
        sta wBufferBG3VOFS
        inc wGameStateStep,b

        _E74D
        rts

        .databank 0

        ; 91/E74E

      rsUnknown91E74E ; 91/E74E

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$1000
        beq _E764
        lda #$0022
        sta wGameStateStep,b
        lda #$00E0
        jsl rlSendSoundCommand
        bra _E77F


        _E764
        jsl rlUnknown91B164
        bcc _E77F
        jsl rlResetDialogueEngine
        jsl rlDialogueFreeHDMA
        jsl rlResetHDMAEngine
        lda #$0080
        sta $185A,b
        inc wGameStateStep,b

        _E77F
        rts

        .databank 0

        ; 91/E780

    .endsection Unsorted91E583Section


    .section Unsorted91E780Section

      .al
      .xl

      rsUnknown91E780 ; 91/E780

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$1000
        bne _E78C
        dec $185A,b
        bne _E792

        _E78C
        lda #$0022
        sta wGameStateStep,b

        _E792
        rts

        .databank 0

        ; 91/E793

    .endsection Unsorted91E780Section


    .section Unsorted91E793Section

      .as
      .xl

      rlUnknown91E793 ; 91/E793

        .al
        .xl
        .autsiz
        .databank ?

        php
        jsr rsUnknown91DF6D
        lda #(`gcUnknown9CB90D)<<8
        sta lR18+1
        lda #<>gcUnknown9CB90D
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $6000

        lda #(`gcUnknown9CC0B4)<<8
        sta lR18+1
        lda #<>gcUnknown9CC0B4
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $4800, $80, $A000

        lda #(`gcUnknown9CCB62)<<8
        sta lR18+1
        lda #<>gcUnknown9CCB62
        sta lR18
        lda #(`aBG3TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $9000

        lda #(`gcUnknown9CD916)<<8
        sta lR18+1
        lda #<>gcUnknown9CD916
        sta lR18
        lda #(`aBGPaletteBuffer)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer
        sta lR19
        jsl rlAppendDecompList
        sep #$20
        lda #$04
        sta bBufferTM
        lda #$00
        sta bBufferTS
        plp
        rtl

        .databank 0

        ; 91/E82A

      rlUnknown91E82A ; 91/E82A

        .al
        .xl
        .autsiz
        .databank ?

        php
        jsr rsUnknown91DF6D
        lda #(`gcUnknown9CB90D)<<8
        sta lR18+1
        lda #<>gcUnknown9CB90D
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $6000

        lda #(`gcUnknown9CCE12)<<8
        sta lR18+1
        lda #<>gcUnknown9CCE12
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $4800, $80, $A000

        lda #(`gcUnknown9CD719)<<8
        sta lR18+1
        lda #<>gcUnknown9CD719
        sta lR18
        lda #(`aBG3TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $9000

        lda #(`gcUnknown9CD916)<<8
        sta lR18+1
        lda #<>gcUnknown9CD916
        sta lR18
        lda #(`aBGPaletteBuffer)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer
        sta lR19
        jsl rlAppendDecompList
        sep #$20
        lda #$04
        sta bBufferTM
        lda #$00
        sta bBufferTS
        plp
        rtl

        .databank 0

        ; 91/E8C1

      rlUnknown91E8C1 ; 91/E8C1

        .al
        .xl
        .autsiz
        .databank ?

        php
        sei
        jsr rsUnknown91E915
        jsl rlUnknown91E793
        bra _E8D5

        .byte $08, $78, $20, $15, $E9, $22, $2A, $E8, $91


        _E8D5
        stz wGameStateRoutine1,b
        lda #<>rsUnknown80F5D0
        sta wVBlankPointer
        lda #<>rsUnknown80F553
        sta wMainLoopPointer
        lda #<>rsUnknown808222
        sta wIRQPointer
        sep #$20
        lda #$04
        sta $212C,b
        sta bBufferTM
        lda #$00
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlEnableVBlank

        _E8FD
        jsl rlHaltUntilVBlank
        inc bBufferINIDISP
        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _E8FD
        jsl rlDisableVBlank

        _E911
        bra _E911

        .databank 0

        ; 91/E913

    .endsection Unsorted91E793Section


    .section Unsorted91E915Section

      .al
      .xl

      rsUnknown91E915 ; 91/E915

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0FFE

        _E918
        stz $0000,b,x
        dec x
        dec x
        bpl _E918
        phk
        plb
        .databank $91
        jsl rlInitSound
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        rts

        .databank 0

        ; 91/E92E

    .endsection Unsorted91E915Section


    .section Unsorted91E92ESection

      .al
      .xl

      rlUnknown91E92E ; 91/E92E

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsFillSaveSlotDataBuffers
        rtl

        .databank 0

        ; 91/E932

    .endsection Unsorted91E92ESection


    .section Unsorted91E932Section

      .al
      .xl

      rlUnknown91E932 ; 91/E932

        .al
        .xl
        .autsiz
        .databank ?

        pha
        asl a
        tay
        lda $1B11,b,y
        beq _E93D
        clc
        bra _E93E


        _E93D
        sec

        _E93E
        pla
        rtl

        .databank 0

        ; 91/E940

    .endsection Unsorted91E932Section


    .section Unsorted91E940Section

      .al
      .xl

      rlUnknown91E940 ; 91/E940

        .al
        .xl
        .autsiz
        .databank ?

        phy
        ldy #$0000
        lda $1B11,b
        beq _E94A
        inc y

        _E94A
        lda $1B13,b
        beq _E950
        inc y

        _E950
        lda $1B15,b
        beq _E956
        inc y

        _E956
        lda $1B17,b
        beq _E95C
        inc y

        _E95C
        tya
        ply
        rtl

        .databank 0

        ; 91/E95F

    .endsection Unsorted91E940Section


    .section Unsorted91F748Section

      .al
      .xl

      rlUnknown91F748 ; 91/F748

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F818B
        cmp #$0003
        bmi _F753

        _F751
        bra _F751


        _F753
        asl a
        tax
        jsr (aUnknown91F759,x)
        rtl

        .databank 0

        ; 91/F759

    .endsection Unsorted91F748Section


    .section Unsorted91F759Section

      .al
      .xl

      aUnknown91F759 ; 91/F759

        .word <>rlUnknown91F75F, <>rlUnknown91F7CF, <>rlUnknown91F813

      rlUnknown91F75F ; 91/F75F

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0020

        _F762
        lda @l $00017E,x
        sta $7ECFFE,x
        dec x
        dec x
        bne _F762
        lda #$0000
        ldx #$0020

        _F774
        sta $017E,b,x
        dec x
        dec x
        bne _F774
        lda #$0001
        sta $7F818B
        lda #$0000
        sta $7F8185
        sta $7F818D
        sta $7F8187
        lda #$0002
        sta $7F8189
        lda #$0044
        sta aPaletteFading,b
        stz aPaletteFading.wCurrentStep,b
        lda #$00E2
        jsl rlQueueSoundCommand
        lda wCurrentChapter,b
        asl a
        tax
        lda aUnknown91F7B7,x
        beq _F7B6
        sta wMusicID,b

        _F7B6
        rts

        .databank 0

        ; 91/F7B7

      aUnknown91F7B7 ; 91/F7B7

        ; One word per chapter, read by rlUnknown91F75F: if it is not 0, it is stored in $04BA.

        .word $006B, $0055, $0055, $0063, $0056, $0066, $0026, $006B
        .word $0063, $0081, $007A, $0000

        ; 91/F7CF

      rlUnknown91F7CF ; 91/F7CF

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8185
        cmp #$0006
        bne _F7FE
        lda #$0000
        sta $7F8185
        sep #$20
        lda bBufferINIDISP
        inc a
        sta bBufferINIDISP
        rep #$20
        and #$000F
        cmp #$000F
        bne _F7FE
        lda #$0002
        sta $7F818B
        lda #$0000
        sta $7F8185

        _F7FE
        lda $7F8187
        cmp $7F8189
        bne _F812
        lda #$0000
        sta $7F8187
        jsr rsUnknown91FA9A

        _F812
        rts

        .databank 0

      rlUnknown91F813 ; 91/F813

        .al
        .xl
        .autsiz
        .databank ?


        .databank 0

    .endsection Unsorted91F759Section


    .section Unsorted91F813Section

      .al
      .xl

      rsUnknown91F813 ; 91/F813

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8187
        cmp $7F8189
        bne _F837
        lda #$0000
        sta $7F8187
        jsr rsUnknown91FA9A
        bcc _F837
        inc wGameStateStep,b
        lda #$0000
        sta $7F8185
        sta $7F818B

        _F837
        rts

        .databank 0

        ; 91/F838

      rlUnknown91F838 ; 91/F838

        .al
        .xl
        .autsiz
        .databank ?

        lda @l wCurrentChapter
        asl a
        tax
        lda $7F8185
        cmp aUnknown91F872,x
        bne _F871
        ldx #$0020
        lda #$0000

        _F84E
        sta $7ECFFE,x
        dec x
        dec x
        bne _F84E
        lda #$005F
        sta aPaletteFading,b
        stz aPaletteFading.wCurrentStep,b
        inc wGameStateStep,b
        lda #$0000
        sta $7F818B
        sta $7F8185
        sta $7F8187

        _F871
        rtl

        .databank 0

        ; 91/F872

    .endsection Unsorted91F813Section


    .section Data91F872Section

      .al
      .xl

      aUnknown91F872 ; 91/F872

        ; Read by rlUnknown91F838.

        .word $00C8, $00BE, $00B4, $00C8, $00B4, $00D2, $00B4, $00B4
        .word $00B4, $00B4, $00B4, $00D2

        ; 91/F88A

    .endsection Data91F872Section


    .section Unsorted91F88ASection

      .al
      .xl

      rlUnknown91F88A ; 91/F88A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F818B
        cmp #$0002
        bmi _F895

        _F893
        bra _F893


        _F895
        asl a
        tax
        jsr (aUnknown91F89B,x)
        rtl

        .databank 0

        ; 91/F89B

    .endsection Unsorted91F88ASection


    .section Table91F89BSection

      .al
      .xl

      aUnknown91F89B ; 91/F89B

        ; Jump table of rlUnknown91F88A.
        .word <>rsUnknown91F89F
        .word <>rsUnknown91F8D8

    .endsection Table91F89BSection


    .section Unsorted91F89FSection

      .al
      .xl

      rsUnknown91F89F ; 91/F89F

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8185
        cmp #$0007
        bne _F8C4
        lda #$0000
        sta $7F8185
        sep #$20
        lda bBufferINIDISP
        dec a
        sta bBufferINIDISP
        rep #$20
        and #$000F
        bne _F8C4
        lda #$0001
        sta $7F818B

        _F8C4
        lda $7F8187
        cmp #$0002
        bne _F8D7
        jsr rsUnknown91FA9A
        lda #$0000
        sta $7F8187

        _F8D7
        rts

        .databank 0

        ; 91/F8D8

      rsUnknown91F8D8 ; 91/F8D8

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0000
        sta wGameStateRoutine1,b
        lda #$AEEA
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        lda #$0029
        sta wGameStateStep,b
        stz aPaletteFading,b
        stz aPaletteFading.wCurrentStep,b
        rts

        .databank 0

        ; 91/F907

    .endsection Unsorted91F89FSection


    .section Unsorted91F907Section

      .al
      .xl

      rlUnknown91F907 ; 91/F907

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8185
        bne _F917
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        bra _F934


        _F917
        stz wGameStateRoutine1,b
        lda #$AEEA
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        stz aPaletteFading,b
        stz aPaletteFading.wCurrentStep,b

        _F934
        rtl

        .databank 0

        ; 91/F935

    .endsection Unsorted91F907Section


    .section Unsorted91F935Section

      .al
      .xl

      rlUnknown91F935 ; 91/F935

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown91FA57
        lda $7F8183
        inc a
        sta $7F8183
        lda $7F8187
        inc a
        sta $7F8187
        lda $7F8185
        inc a
        sta $7F8185
        lda wVBlankEnabledFramecount
        lsr a
        sta wBufferBG2VOFS
        rtl

        .databank 0

        ; 91/F959

    .endsection Unsorted91F935Section


    .section Unsorted91F959Section

      .al
      .xl

      rlUnknown91F959 ; 91/F959

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $91
        phk
        plb
        .databank $91
        ldx #$0000
        sep #$20
        lda #$5D
        sta $7F828F,x
        rep #$20
        lda #$0000
        sta $7F8290,x
        inc x
        inc x
        inc x
        ldy #$0000

        _F979
        sep #$20
        lda #$01
        sta $7F828F,x
        rep #$20
        lda $7F8290,x
        clc
        adc $F9AD,b,y
        sta $7F8290,x
        inc y
        inc y
        inc x
        inc x
        inc x
        cpy #$0030
        bne _F979
        sep #$20
        lda #$00
        sta $7F828F,x
        rep #$20
        lda #$0000
        sta $7F8290,x
        plp
        plb
        .databank $91
        rtl

        .databank 0

        ; 91/F9AD

    .endsection Unsorted91F959Section


    .section Table91F9ADSection

      .al
      .xl

      aUnknown91F9AD ; 91/F9AD

        ; Read by rlUnknown91F959.

        .word $0000, $0006, $000D, $0013, $0018, $001E, $0023, $0029
        .word $002E, $0033, $0039, $003E, $0042, $0045, $0046, $0046
        .word $0045, $0044, $0041, $003D, $0037, $0030, $0029, $0023

        ; 91/F9DD

    .endsection Table91F9ADSection


    .section Unsorted91F9DDSection

      .al
      .xl

      rlUnknown91F9DD ; 91/F9DD

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $91
        ldx #$0000
        sep #$20
        lda #$60
        sta $7F838F,x
        rep #$20
        inc x
        lda #$0000
        sta $7F838F,x
        inc x
        inc x
        ldy #$0000

        _F9F9
        sep #$20
        lda #$01
        sta $7F838F,x
        rep #$20
        inc x
        lda $FA27,b,y
        sta $7F838F,x
        inc x
        inc x
        inc y
        inc y
        cpx #$004B
        bne _F9F9
        sep #$20
        lda #$00
        sta $7F838F,x
        rep #$20
        inc x
        lda #$0000
        sta $7F838F,x
        rtl

        .databank 0

        ; 91/FA27

    .endsection Unsorted91F9DDSection


    .section Table91FA27Section

      .al
      .xl

      aUnknown91FA27 ; 91/FA27

        ; Read by rlUnknown91F9DD.
        ; Pairs of signed words; code follows at 91/FA57.

        .word $0027, $FFDC, $0030, $FFE4, $0036, $FFBA, $0025, $FFCD
        .word $003A, $FFC5, $002F, $FFBF, $0024, $FFD0, $0035, $FFCE
        .word $003E, $FFC2, $003A, $FFBC, $0032, $FFD3, $002E, $FFC5

        ; 91/FA57

    .endsection Table91FA27Section


    .section Unsorted91FA57Section

      .al
      .xl

      rsUnknown91FA57 ; 91/FA57

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F818D
        bne _FA99
        ldx #$0003

        _FA60
        inc x
        lda $7F838F,x
        beq _FA6C
        dec a
        sta $7F838F,x

        _FA6C
        inc x
        inc x
        inc x
        lda $7F838F,x
        beq _FA7A
        inc a
        sta $7F838F,x

        _FA7A
        inc x
        inc x
        cpx #$004B
        bne _FA60
        ldx #$0003

        _FA84
        inc x
        lda $7F838F,x
        bne _FA99
        inc x
        inc x
        cpx #$004B
        bne _FA84
        lda #$0001
        sta $7F818D

        _FA99
        rts

        .databank 0

        ; 91/FA9A

    .endsection Unsorted91FA57Section


    .section Unsorted91FA9ASection

      .al
      .xl

      rsUnknown91FA9A ; 91/FA9A

        .al
        .xl
        .autsiz
        .databank ?

        clc
        jsl rlFadePaletteToColors

          .byte $00, $D0, $20, $00, $80, $00

        rts

        .databank 0

        ; 91/FAA6

    .endsection Unsorted91FA9ASection
