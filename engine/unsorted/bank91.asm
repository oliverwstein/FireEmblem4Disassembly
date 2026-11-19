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
        stz $181E,b
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
        jsl rlUnknown80A1AB
        lda wR13
        sta [lR19],y
        inc x
        inc y
        lda wR10
        sta wR13
        lda #$03E8
        sta wR14
        jsl rlUnknown80A1AB
        lda wR13
        sta [lR19],y
        inc x
        inc y
        lda wR10
        sta wR13
        lda #$0064
        sta wR14
        jsl rlUnknown80A1AB
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
        lda #$9100
        sta lR18+1
        lda #$AB0B
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
        lda $0006,b,y
        sta lR23
        lda $0007,b,y
        sta lR23+1
        stz wR0
        txa
        sep #$20
        sta wR0
        xba
        sta @l WRMPYA
        lda $0000,b,y
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
        lda $0000,b,y
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
        lda $1882,b
        beq _B163
        jsl rlUnknown9181F6
        lda $1882,b
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
        inc $0304,b
        rts

        .databank 0

        ; 91/D6BB

    .endsection Unsorted91D69BSection


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
        lda $04BA,b
        bne _D898
        jsr rsUnknown91E275
        jsr rsUnknown91DCDE
        lda wJoy1New
        bit #$0080
        beq _D898
        lda #$000A
        jsl rlUnknown808FAD
        ldx $185A,b
        lda @l $00185C,x
        and #$00FF
        tax
        lda aUnknown91D899,x
        and #$00FF
        sta $0304,b
        lda #$0001
        sta $1864,b

        _D898
        rts

        .databank 0

        ; 91/D899

    .endsection Unsorted91D844Section


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
        jsl rlUnknown808FAD

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
        jsl rlUnknown808FAD
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
        lda $04BA,b
        bne _DAD2
        lda $1866,b
        bne _DAD6
        jsr rsUnknown91E2AA
        lda wJoy1New
        bit #$0080
        beq _DAA6
        lda $0304,b
        cmp #$0007
        beq _DACD
        lda #$000A
        jsl rlUnknown808FAD
        jsr rsUnknown91DB17
        lda #$0001
        sta $1866,b
        bra _DAD2


        _DAA6
        lda wJoy1New
        bit #$8000
        beq _DAD2
        lda $0304,b
        cmp #$0003
        beq _DAC8
        lda #$0021
        jsl rlUnknown808FAD
        lda #$FFFF
        sta $1864,b
        lda #$0000
        sta $0304,b

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
        jsl rlUnknown808FAD
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
        ldx $0304,b
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
        bra $91DBEE


        _DBFE
        inc $0304,b
        jsr rsUnknown91DCEA
        sep #$20
        lda #$16
        sta bBufferTM
        rep #$20
        lda $1854,b
        sta $0304,b
        rts

        .databank 0

        ; 91/DC13

    .endsection Unsorted91DBEESection


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
        lda $1882,b
        bne _DC91
        lda $18C9,b
        bne _DC91
        lda $1864,b
        jsr rsUnknown91DCF8
        jsr rsUnknown91DCEA
        lda $1854,b
        sta $0304,b

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
        sta $0304,b
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
        sta $0304,b
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
        lda $1882,b
        bne _DDA7
        lda $18C9,b
        bne _DDA7
        lda $1856,b
        jsr rsUnknown91DE4D

        _DDBB
        jsl rlUnknown9181F6
        lda $1882,b
        bne _DDBB
        lda $18C9,b
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
        lda #$9100
        sta lR18+1
        lda #$DE4C
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
        jsl rlUnknown918127
        lda #$2000
        trb $1882,b
        lda #$2000
        sta $189F,b
        lda #$1E1E
        sta $18DB,b
        lda #$FFFF
        sta $1888,b
        sta $188A,b
        lda #$000A
        sta $1892,b
        lda #$0200
        tsb $1882,b
        lda #$0180
        tsb $1882,b
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
        jsl rlUnknown808FAD

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
        jsl rlUnknown808FAD

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
        lda $1B0B,b
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
        lda #$9C00
        sta lR18+1
        lda #$B90D
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $6000

        lda #$9C00
        sta lR18+1
        lda #$C0B4
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $4800, $80, $A000

        lda #$9C00
        sta lR18+1
        lda #$CB62
        sta lR18
        lda #(`aBG3TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $9000

        lda #$9C00
        sta lR18+1
        lda #$D916
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
        lda #$9C00
        sta lR18+1
        lda #$B90D
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $6000

        lda #$9C00
        sta lR18+1
        lda #$CE12
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $4800, $80, $A000

        lda #$9C00
        sta lR18+1
        lda #$D719
        sta lR18
        lda #(`aBG3TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $9000

        lda #$9C00
        sta lR18+1
        lda #$D916
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
        stz $0302,b
        lda #$F5D0
        sta wVBlankPointer
        lda #$F553
        sta wMainLoopPointer
        lda #$8222
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
        jsl rlUnknown80823F
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
        jsl rlUnknown808EF6
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        rts

        .databank 0

        ; 91/E92E

    .endsection Unsorted91E915Section


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
        stz $1B45,b
        lda #$00E2
        jsl rlUnknown808F6F
        lda wCurrentChapter,b
        asl a
        tax
        lda $91F7B7,x
        beq _F7B6
        sta $04BA,b

        _F7B6
        rts

        rtl

        .byte $00 ; brk
        eor wR0,x
        eor wR0,x
        adc #0,s
        lsr wR0,x
        ror wR0
        rol wR0
        rtl

        .byte $00 ; brk
        adc #0,s
        sta (wR0,x)
        ply
        .byte $00 ; brk
        .byte $00 ; brk
        .byte $00 ; brk

        .databank 0

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
