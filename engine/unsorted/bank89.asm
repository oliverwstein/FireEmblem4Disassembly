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
        jsr rsUnknown8989EA
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
        jsr rsUnknown898A41
        lda $7F81D1
        cmp #$0008
        beq _89FE
        jsl rlUnknown88DBEE

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
        jsl rlUnknown899FA1

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
        lda @l aUnknown898B2A,x
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


    .section Table898B2ASection

      .al
      .xl

      aUnknown898B2A ; 89/8B2A

        ; Read by rsUnknown898AF5.

        .byte $00, $02, $04, $06, $08, $0A, $0C, $0E, $20, $22, $01, $00, $00, $C2, $C0, $00
        .byte $3D

        ; 89/8B3B

    .endsection Table898B2ASection


    .section Unsorted898B3BSection

      .al
      .xl

      rsUnknown898B3B ; 89/8B3B

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown89933C
        lda $0889,b
        sec
        sbc #$0001
        bmi _8B7F
        tax

        _8B48
        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        ldy #$8B90
        lda #$0086
        sta wR0
        lda @l aUnknown898B80,x
        and #$00FF
        clc
        adc #$00A9
        sec
        sbc wBufferBG3VOFS
        sta wR1
        lda @l aUnknown898B88,x
        and #$00FF
        sta wR4
        lda #$0000
        sta wR5
        phx
        jsl rlPushToOAMBuffer
        plx
        dec x
        bpl _8B48

        _8B7F
        rts

        .databank 0

        ; 89/8B80

    .endsection Unsorted898B3BSection


    .section Table898B80Section

      .al
      .xl

      aUnknown898B80 ; 89/8B80

        ; Read by rsUnknown898B3B.

        .word $1000, $3020, $5040, $7060

        ; 89/8B88

    .endsection Table898B80Section


    .section Unsorted898D55Section

      .al
      .xl

      rsUnknown898D55 ; 89/8D55

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown898EB4
        jsr rsUnknown898F16
        jsr rsUnknown898D5F
        rts

        .databank 0

        ; 89/8D5F

      rsUnknown898D5F ; 89/8D5F

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F818D
        cmp #$0002
        beq _8D6C
        jml _8E14


        _8D6C
        lda #$0078
        sta wR0
        lda #$00B0
        sta wR1
        stz wR4
        stz wR5
        phk
        plb
        .databank $89
        ldy #$8E65
        jsl rlPushToOAMBuffer
        lda $7F82B9
        bne _8DA8
        lda #$0006
        sta $7F82B9
        lda $7F8251
        inc a
        cmp #$0004
        bcc _8DA4
        lda #$000F
        sta $7F82B9
        lda #$0000

        _8DA4
        sta $7F8251

        _8DA8
        lda $7F82B9
        dec a
        sta $7F82B9
        lda #$007C
        sta wR0
        lda #$00A0
        sta wR1
        stz wR4
        stz wR5
        lda $7F8251
        asl a
        tax
        lda @l aUnknown898E6C,x
        tay
        jsl rlPushToOAMBuffer
        lda $7F82BB
        bne _8DEC
        lda #$0003
        sta $7F82BB
        lda $7F8253
        inc a
        cmp #$0004
        bcc _8DE8
        lda #$0000

        _8DE8
        sta $7F8253

        _8DEC
        lda $7F82BB
        dec a
        sta $7F82BB
        lda #$0078
        sta wR0
        lda #$009C
        sta wR1
        stz wR4
        stz wR5
        lda $7F8253
        asl a
        tax
        lda @l aUnknown898E90,x
        tay
        jsl rlPushToOAMBuffer
        bra _8E64


        _8E14
        cmp #$0000
        beq _8E64
        lda $7F82B9
        bne _8E3E
        lda #$000B
        sta $7F82B9
        lda $7F8251
        inc a
        cmp #$0004
        bcc _8E3A
        lda #$0019
        sta $7F82B9
        lda #$0000

        _8E3A
        sta $7F8251

        _8E3E
        lda $7F82B9
        dec a
        sta $7F82B9
        lda #$007C
        sta wR0
        lda #$00A0
        sta wR1
        stz wR4
        stz wR5
        lda $7F8251
        asl a
        tax
        lda @l aUnknown898E6C,x
        tay
        jsl rlPushToOAMBuffer

        _8E64
        rts

        .databank 0

        ; 89/8E65

    .endsection Unsorted898D55Section


    .section Table898E6CSection

      .al
      .xl

      aUnknown898E6C ; 89/8E6C

        ; Read by rsUnknown898D5F.

        .word $8E74, $8E7B, $8E82, $8E89, $0001, $0000, $9900, $013B
        .word $0000, $0000, $3B88, $0001, $0000, $8900, $013B, $0000
        .word $0000, $3B98

        ; 89/8E90

    .endsection Table898E6CSection


    .section Table898E90Section

      .al
      .xl

      aUnknown898E90 ; 89/8E90

        ; Read by rsUnknown898D5F.

        .word $8E98, $8E9F, $8EA6, $8EAD, $0001, $C200, $8A00, $013B
        .word $0000, $00C2, $3B8C, $0001, $C200, $8E00, $013B, $0000
        .word $00C2, $3B8C

        ; 89/8EB4

    .endsection Table898E90Section


    .section Unsorted898EB4Section

      .al
      .xl

      rsUnknown898EB4 ; 89/8EB4

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
        ldy #$8ED8
        lda #$007E
        sta wR0
        lda #$00AC
        sta wR1
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/8ED8

    .endsection Unsorted898EB4Section


    .section Unsorted898F16Section

      .al
      .xl

      rsUnknown898F16 ; 89/8F16

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000

        _8F19
        sta $7F82BD
        asl a
        tax
        lda $7F81D3,x
        beq _8F38
        jsr rsUnknown898F73
        lda $7F82BD
        asl a
        tax
        lda $7F81D3,x
        dec a
        beq _8F38
        jsr rsUnknown899028

        _8F38
        lda $7F82BD
        inc a
        cmp #$000C
        bne _8F19
        rts

        .databank 0

        ; 89/8F43

    .endsection Unsorted898F16Section


    .section Table898F43Section

      .al
      .xl

      aUnknown898F43 ; 89/8F43

        ; Read by rsUnknown898F73, rsUnknown899028.

        .word $0071, $0054, $009B, $0060, $0088, $00A5, $0054, $0089
        .word $009A, $0060, $00A6, $0071

        ; 89/8F5B

    .endsection Table898F43Section


    .section Table898F5BSection

      .al
      .xl

      aUnknown898F5B ; 89/8F5B

        ; Read by rsUnknown898F73, rsUnknown899028.

        .word $0081, $00A1, $008E, $00CB, $0081, $00A0, $00B8, $00D6
        .word $00CB, $008D, $00B8, $00D6

        ; 89/8F73

    .endsection Table898F5BSection


    .section Unsorted898F73Section

      .al
      .xl

      rsUnknown898F73 ; 89/8F73

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F82BD
        asl a
        tax
        lda $7F8255,x
        bne _8FA0
        lda aUnknown898FD4,x
        sta $7F8255,x
        lda $7F81ED,x
        inc a
        cmp #$0004
        bne _8F9C
        lda aUnknown898FEC,x
        sta $7F8255,x
        lda #$0000

        _8F9C
        sta $7F81ED,x

        _8FA0
        lda $7F8255,x
        dec a
        sta $7F8255,x
        lda aUnknown898F43,x
        sec
        sbc #$0001
        sta wR0
        lda aUnknown898F5B,x
        sec
        sbc #$0004
        sta wR1
        lda #$0000
        sta wR4
        sta wR5
        lda $7F81ED,x
        asl a
        tax
        lda aUnknown899004,x
        tay
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/8FD4

    .endsection Unsorted898F73Section


    .section Table898FD4Section

      .al
      .xl

      aUnknown898FD4 ; 89/8FD4

        ; Read by rsUnknown898F73.

        .word $000B, $0008, $000D, $0009, $000E, $000A, $0008, $000A
        .word $000C, $0009, $0008, $000B

        ; 89/8FEC

    .endsection Table898FD4Section


    .section Table898FECSection

      .al
      .xl

      aUnknown898FEC ; 89/8FEC

        ; Read by rsUnknown898F73.

        .word $0019, $0013, $001A, $0020, $0018, $0015, $001B, $0012
        .word $0025, $0019, $000F, $001B

        ; 89/9004

    .endsection Table898FECSection


    .section Table899004Section

      .al
      .xl

      aUnknown899004 ; 89/9004

        ; Read by rsUnknown898F73.

        .word $900C, $9013, $901A, $9021, $0001, $0000, $91F8, $013B
        .word $0000, $F800, $3B80, $0001, $0000, $81F8, $013B, $0000
        .word $F800, $3B90

        ; 89/9028

    .endsection Table899004Section


    .section Unsorted899028Section

      .al
      .xl

      rsUnknown899028 ; 89/9028

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F82BD
        asl a
        tax
        lda $7F826D,x
        bne _904D
        lda aUnknown899081,x
        sta $7F826D,x
        lda $7F8205,x
        inc a
        cmp #$0004
        bne _9049
        lda #$0000

        _9049
        sta $7F8205,x

        _904D
        lda $7F826D,x
        dec a
        sta $7F826D,x
        lda aUnknown898F43,x
        sec
        sbc #$0001
        sta wR0
        lda aUnknown898F5B,x
        sec
        sbc #$0004
        sta wR1
        lda #$0000
        sta wR4
        sta wR5
        lda $7F8205,x
        asl a
        tax
        lda aUnknown899099,x
        tay
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/9081

    .endsection Unsorted899028Section


    .section Table899081Section

      .al
      .xl

      aUnknown899081 ; 89/9081

        ; Read by rsUnknown899028.

        .word $0007, $0008, $0007, $0009, $0007, $0009, $0008, $0007
        .word $0008, $0009, $0008, $0007

        ; 89/9099

    .endsection Table899081Section


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
        lda @l aUnknown8992E7,x
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


    .section Table8992E7Section

      .al
      .xl

      aUnknown8992E7 ; 89/92E7

        ; Read by rsUnknown8992AD.

        .byte $80, $00, $94, $00, $A8, $00, $BC, $00, $D0, $00, $E4, $00, $F8, $00, $0C, $01
        .byte $01, $00, $00, $C2, $00, $80, $3E, $FF, $FF, $FF, $FF, $06, $00, $00, $00, $02
        .byte $00, $04, $00, $44, $00, $FF, $FF, $46, $00, $FF, $FF, $FF, $FF, $FF, $FF, $08
        .byte $00, $FF, $FF, $0C, $00, $0E, $00, $20, $00, $22, $00, $24, $00, $26, $00, $28
        .byte $00, $2A, $00, $2C, $00, $2E, $00, $40, $00, $42, $00, $FF, $FF, $FF, $FF, $48
        .byte $00, $FF, $FF, $FF, $FF

        ; 89/933C

    .endsection Table8992E7Section


    .section Unsorted89933CSection

      .al
      .xl

      rsUnknown89933C ; 89/933C

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $89
        lda $7F81A7
        beq _935E
        tax
        lda @l aUnknown89935F,x
        and #$00FF
        sec
        sbc wBufferBG3VOFS
        sta wR1
        stz wR0
        stz wR4
        stz wR5
        ldy #$9367
        jsl rlPushToOAMBuffer

        _935E
        rts

        .databank 0

        ; 89/935F

    .endsection Unsorted89933CSection


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
        jsl rlGetSelectedUnitLivingTalkTarget
        cmp #$0000
        beq _99DA
        jsl rlGetUnitRAMDataPointerByID
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        bne _99DA
        jsl rlGetSelectedUnitStatus
        cmp #StatusCaptive
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
        lda aUnknown89A76C+1,x
        sta lR18+1
        lda aUnknown89A76C,x
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
        jsr rsUnknown89A5AA
        lda #$0001
        jsl rlGetSelectedUnitWeaponRank
        bcc _9AB5
        lda #$0004

        _9AB5
        ldx #$0015
        ldy #$0020
        jsr rsUnknown89A5AA
        lda #$0002
        jsl rlGetSelectedUnitWeaponRank
        bcc _9ACA
        lda #$0004

        _9ACA
        ldx #$0015
        ldy #$0022
        jsr rsUnknown89A5AA
        lda #$0003
        jsl rlGetSelectedUnitWeaponRank
        bcc _9ADF
        lda #$0004

        _9ADF
        ldx #$0015
        ldy #$0024
        jsr rsUnknown89A5AA
        lda #$0004
        jsl rlGetSelectedUnitWeaponRank
        bcc _9AF4
        lda #$0004

        _9AF4
        ldx #$0015
        ldy #$0026
        jsr rsUnknown89A5AA
        lda #$0005
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B09
        lda #$0004

        _9B09
        ldx #$001D
        ldy #$001E
        jsr rsUnknown89A5AA
        lda #$0006
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B1E
        lda #$0004

        _9B1E
        ldx #$001D
        ldy #$0020
        jsr rsUnknown89A5AA
        lda #$0007
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B33
        lda #$0004

        _9B33
        ldx #$001D
        ldy #$0022
        jsr rsUnknown89A5AA
        lda #$0008
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B48
        lda #$0004

        _9B48
        ldx #$001D
        ldy #$0024
        jsr rsUnknown89A5AA
        lda #$0009
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B5D
        lda #$0004

        _9B5D
        ldx #$001D
        ldy #$0026
        jsr rsUnknown89A5AA
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
        jsl rlUnknown89BECC
        lda #$2400
        sta wR1
        lda #$01E5
        sta wR2
        lda #$000B
        sta wR0
        ldx #$0724
        jsl rlUnknown89BECC
        lda #$2400
        sta wR1
        lda #$026F
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0A24
        jsl rlUnknown89BECC
        lda #$2400
        sta wR1
        lda #$0280
        sta wR2
        lda #$0009
        sta wR0
        ldx #$0A26
        jsl rlUnknown89BECC
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
          sta aOAMPaletteBuffer.aPalette4,b,y
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

        jsr rsUnknown8989AD
        jsr rsUnknown898AF5
        jsr rsUnknown898A7E
        lda wJoy1Repeated
        bit #$8000
        bne _A27B
        bit #$0100
        bne _A2AE
        bit #$0200
        bne _A2D1
        jsr rsUnknown89A4E3
        jsr rsUnknown8992AD
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

        jsr rsUnknown8992AD
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
        jsr rsUnknown8992AD

        _A2CA
        jsr rsUnknown89A4E3
        jsr rsUnknown8992AD
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
        jsr rsUnknown89A4E3
        jsr rsUnknown8992AD
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
        jsr rsUnknown898B3B
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rts


        _A32A
        jsr rsUnknown898D55
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
        jsr rsUnknown898B3B
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rts


        _A372
        jsr rsUnknown898D55
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
        lda aUnknown89AC56+1,x
        sta lR18+1
        lda aUnknown89AC56,x
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
        lda aUnknown89ABF9+1,x
        sta lR18+1
        lda aUnknown89ABF9,x
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
        lda aUnknown89A59E,x
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
        lda aUnknown89A572,x
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
        lda @l aUnknown89A52D,x
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


    .section Table89A52DSection

      .al
      .xl

      aUnknown89A52D ; 89/A52D

        ; Read by rsUnknown89A4E3.

        .byte $00, $00, $00, $00, $06, $00, $00, $00, $02, $00, $04, $00, $44, $00, $00, $00
        .byte $46, $00, $00, $00, $00, $00, $00, $00, $08, $00, $0A, $00, $0C, $00, $0E, $00
        .byte $20, $00, $22, $00, $24, $00, $26, $00, $28, $00, $2A, $00, $2C, $00, $2E, $00
        .byte $40, $00, $42, $00, $0E, $01, $00, $00, $48, $00, $4A, $00, $00, $00, $01, $00
        .byte $14, $C2, $62, $80, $3E

        ; 89/A572

    .endsection Table89A52DSection


    .section Table89A572Section

      .al
      .xl

      aUnknown89A572 ; 89/A572

        ; Read by rsUnknown89A4E3.

        .word $A57A, $A586, $A592, $A586, $0002, $C203, $0A00, $1D70
        .word $00C2, $300A, $0002, $C202, $0A00, $1E70, $00C2, $300A
        .word $0002, $C201, $0A00, $1F70, $00C2, $300A

        ; 89/A59E

    .endsection Table89A572Section


    .section Table89A59ESection

      .al
      .xl

      aUnknown89A59E ; 89/A59E

        ; Read by rsUnknown89A4E3.

        .word $0070, $0084, $0098, $00AC, $00C0, $00D4

        ; 89/A5AA

    .endsection Table89A59ESection


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
        bit #UnitStateDead
        bne _A610
        jsl rlGetSelectedUnitStatus
        cmp #StatusCaptive
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
        bit #UnitStateDead
        bne _A6B7
        jsl rlGetSelectedUnitStatus
        cmp #StatusCaptive
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


    .section Table89ABF9Section

      .al
      .xl

      aUnknown89ABF9 ; 89/ABF9

        ; Read by rsUnknown89A3C0.

        .byte $00, $00, $00, $00, $00, $00, $C9, $A7, $89, $FF, $A7, $89, $25, $A8, $89, $5B
        .byte $A8, $89, $81, $A8, $89, $00, $00, $00, $B1, $A8, $89, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $ED, $A8, $89, $00, $00, $00, $17, $A9, $89, $37, $A9, $89
        .byte $5F, $A9, $89, $95, $A9, $89, $C5, $A9, $89, $FB, $A9, $89, $1D, $AA, $89, $41
        .byte $AA, $89, $00, $00, $00, $00, $00, $00, $69, $AA, $89, $9F, $AA, $89, $00, $00
        .byte $00, $00, $00, $00, $C3, $AA, $89, $00, $00, $00, $00, $00, $00

        ; 89/AC56

    .endsection Table89ABF9Section


    .section Unsorted89B8BDSection

      .al
      .xl

      rlUnknown89B8BD ; 89/B8BD

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F846D
        sta wR0
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR1
        lda #$00C4
        sta wR0
        stz wR4

        _B8D1
        lda #$000F
        sta wR15
        sta wR14
        ldx wR1
        ldy wR0
        lda #$007E
        sep #$20
        pha
        rep #$20
        plb
        .databank $7E

        _B8E5
        lda $7F89D0,x
        sta aBG3TilemapBuffer,y
        inc x
        inc x
        inc y
        inc y
        dec wR15
        bpl _B8E5
        ldx wR1
        ldy wR0

        _B8F8
        lda $7F89F0,x
        sta $83C8,b,y
        inc x
        inc x
        inc y
        inc y
        dec wR14
        bpl _B8F8
        txa
        clc
        adc #$0020
        sta wR1
        tya
        clc
        adc #$0060
        sta wR0
        inc wR4
        lda wR4
        cmp #$000C
        bne _B8D1
        rtl

        .databank 0

        ; 89/B91F

    .endsection Unsorted89B8BDSection


    .section Unsorted89B91FSection

      .al
      .xl

      rlUnknown89B91F ; 89/B91F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown89BAF3
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
        jsr rsUnknown89C1A1
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
        jsr rsUnknown89C5A2
        jsr rsUnknown89C1A1
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
        jsr rsUnknown89C5A2
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
        jsr rsUnknown89C279

        _BAC0
        rtl

        .databank 0

        ; 89/BAC1

    .endsection Unsorted89B91FSection


    .section Unsorted89BAF3Section

      .al
      .xl

      rsUnknown89BAF3 ; 89/BAF3

        .al
        .xl
        .autsiz
        .databank ?

        lda #$00CE
        ldx #$0016

        _BAF9
        sta $7E856E,x
        dec x
        dec x
        bne _BAF9
        ldx #$0016

        _BB04
        sta $7E85AE,x
        dec x
        dec x
        bne _BB04
        ldx #$0016

        _BB0F
        sta $7E85EE,x
        dec x
        dec x
        bne _BB0F
        ldx #$0016

        _BB1A
        sta $7E862E,x
        dec x
        dec x
        bne _BB1A
        ldx #$0016

        _BB25
        sta $7E866E,x
        dec x
        dec x
        bne _BB25
        ldx #$0016

        _BB30
        sta $7E86AE,x
        dec x
        dec x
        bne _BB30
        ldx #$0016

        _BB3B
        sta $7E86EE,x
        dec x
        dec x
        bne _BB3B
        ldx #$0016

        _BB46
        sta $7E872E,x
        dec x
        dec x
        bne _BB46
        ldx #$0016

        _BB51
        sta $7E876E,x
        dec x
        dec x
        bne _BB51
        ldx #$0016

        _BB5C
        sta $7E87AE,x
        dec x
        dec x
        bne _BB5C
        ldx #$0016

        _BB67
        sta $7E87EE,x
        dec x
        dec x
        bne _BB67
        ldx #$0016

        _BB72
        sta $7E882E,x
        dec x
        dec x
        bne _BB72
        ldx #$0016

        _BB7D
        sta $7E886E,x
        dec x
        dec x
        bne _BB7D
        ldx #$0016

        _BB88
        sta $7E88AE,x
        dec x
        dec x
        bne _BB88
        ldx #$0016

        _BB93
        sta $7E88EE,x
        dec x
        dec x
        bne _BB93
        ldx #$0016

        _BB9E
        sta $7E892E,x
        dec x
        dec x
        bne _BB9E
        ldx #$0016

        _BBA9
        sta $7E896E,x
        dec x
        dec x
        bne _BBA9
        rts

        .databank 0

        ; 89/BBB2

    .endsection Unsorted89BAF3Section


    .section Unsorted89BBB2Section

      .al
      .xl

      rsUnknown89BBB2 ; 89/BBB2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7F846B
        cmp #$000D
        bpl _BC07
        lda #$0000
        sta $7FB010

        _BBC2
        lda $7FB010
        tax
        lda $7F8483,x
        and #$00FF
        beq _BC06
        asl a
        tax
        lda $7F8776,x
        sta wR4
        lda #$0000
        sta wR5
        lda #$000F
        sta wR0
        lda $7FB010
        asl a
        tax
        lda aUnknown89BCCE,x
        clc
        adc #$0002
        sta wR1
        phk
        plb
        .databank $89
        ldy #$C5DD
        jsl rlPushToOAMBuffer
        lda $7FB010
        inc a
        sta $7FB010
        bra _BBC2


        _BC06
        rts


        _BC07
        lda $7F846D
        and #$0001
        bne _BC6F
        lda $7F846D
        lsr a
        sta $7FB010
        lda #$0000
        sta $7FB012

        _BC20
        lda $7FB010
        tax
        lda $7F8483,x
        and #$00FF
        asl a
        tax
        lda $7F8776,x
        sta wR4
        lda #$0000
        sta wR5
        lda #$000F
        sta wR0
        lda $7FB012
        asl a
        tax
        lda @l aUnknown89BCCE,x
        clc
        adc #$0002
        sta wR1
        phk
        plb
        .databank $89
        ldy #$C5DD
        jsl rlPushToOAMBuffer
        lda $7FB010
        inc a
        sta $7FB010
        lda $7FB012
        inc a
        sta $7FB012
        cmp #$000C
        bne _BC20
        rts


        _BC6F
        lda $7F846D
        lsr a
        sta $7FB010
        lda #$0000
        sta $7FB012

        _BC7F
        lda $7FB010
        tax
        lda $7F8483,x
        and #$00FF
        asl a
        tax
        lda $7F8776,x
        sta wR4
        lda #$0000
        sta wR5
        lda #$000F
        sta wR0
        lda $7FB012
        asl a
        tax
        lda @l aUnknown89BCE6,x
        sec
        sbc #$0006
        sta wR1
        phk
        plb
        .databank $89
        ldy #$C5DD
        jsl rlPushToOAMBuffer
        lda $7FB010
        inc a
        sta $7FB010
        lda $7FB012
        inc a
        sta $7FB012
        cmp #$000D
        bne _BC7F
        rts

        .databank 0

        ; 89/BCCE

    .endsection Unsorted89BBB2Section


    .section Table89BCCESection

      .al
      .xl

      aUnknown89BCCE ; 89/BCCE

        ; Read by rsUnknown89BBB2.

        .word $0018, $0028, $0038, $0048, $0058, $0068, $0078, $0088
        .word $0098, $00A8, $00B8, $00C8

        ; 89/BCE6

    .endsection Table89BCCESection


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


    .section Unsorted89BEEBSection

      .al
      .xl

      rsUnknown89BEEB ; 89/BEEB

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7F846D
        clc
        adc #$0018
        lsr a
        cmp $7F846F
        beq _BEFC
        bcs _BF25

        _BEFC
        lda $7F846D
        clc
        adc #$0018
        sta $7F846D
        lda $7F8467
        clc
        adc #$000C
        sta $7F8467
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        rts


        _BF25
        lda $7F846D
        lsr a
        cmp $7F846F
        beq _BF5C
        lda $7F846F
        asl a
        sta $7F846D
        lda $7F846D
        lsr a
        clc
        adc $7F8471
        clc
        adc #$0001
        sta $7F8467
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        rts


        _BF5C
        lda $7F846B
        sta $7F8467
        lda $7F846B
        cmp #$000D
        bcs _BF8B
        lda $7F846B
        dec a
        sta $7F8471
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$001C
        sta $7F8473
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        rts


        _BF8B
        lda #$000B
        sta $7F8471
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$001C
        sta $7F8473
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        rts

        .databank 0

        ; 89/BFA7

      rsUnknown89BFA7 ; 89/BFA7

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7F846D
        sec
        sbc #$0018
        beq _BFF8
        bpl _BFF8
        lda $7F846D
        beq _BFDA
        lda #$0000
        sta $7F846D
        lda $7F8471
        inc a
        sta $7F8467
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        rts


        _BFDA
        lda #$0001
        sta $7F8467
        lda #$0000
        sta $7F8471
        lda #$001C
        sta $7F8473
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        rts


        _BFF8
        lda $7F846D
        sec
        sbc #$0018
        sta $7F846D
        lda $7F8467
        sec
        sbc #$000C
        sta $7F8467
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        rts

        .databank 0

        ; 89/C021

    .endsection Unsorted89BEEBSection


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


    .section Unsorted89C1A1Section

      .al
      .xl

      rsUnknown89C1A1 ; 89/C1A1

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$CD25
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        ldx #$00C0

        _C1B3
        sta $7FAF4E,x
        dec x
        dec x
        bne _C1B3
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0000
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$CD13
        sta lMapMenuTilemapRAMEntryPointer,b
        ldx #$0000

        _C1DF
        lda $7FAF50,x
        sta $7E8672,x
        lda $7FAFB0,x
        sta $7E86B2,x
        inc x
        inc x
        cpx #$0010
        bne _C1DF
        ldx #$0000

        _C1F9
        lda $7FAF60,x
        sta $7E86F2,x
        lda $7FAFC0,x
        sta $7E8732,x
        inc x
        inc x
        cpx #$0010
        bne _C1F9
        ldx #$0000

        _C213
        lda $7FAF70,x
        sta $7E8772,x
        lda $7FAFD0,x
        sta $7E87B2,x
        inc x
        inc x
        cpx #$0010
        bne _C213
        ldx #$0000

        _C22D
        lda $7FAF80,x
        sta $7E87F2,x
        lda $7FAFE0,x
        sta $7E8832,x
        inc x
        inc x
        cpx #$0010
        bne _C22D
        ldx #$0000

        _C247
        lda $7FAF90,x
        sta $7E8872,x
        lda $7FAFF0,x
        sta $7E88B2,x
        inc x
        inc x
        cpx #$0010
        bne _C247
        ldx #$0000

        _C261
        lda $7FAFA0,x
        sta $7E88F2,x
        lda $7FB000,x
        sta $7E8932,x
        inc x
        inc x
        cpx #$0010
        bne _C261
        rts

        .databank 0

        ; 89/C279

      rsUnknown89C279 ; 89/C279

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$CD25
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        ldx #$00C0

        _C28B
        sta $7FAF4E,x
        dec x
        dec x
        bne _C28B
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0000
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$CD13
        sta lMapMenuTilemapRAMEntryPointer,b
        ldx #$0000

        _C2B7
        lda $7FAF50,x
        sta $7E88F2,x
        lda $7FAFB0,x
        sta $7E8932,x
        inc x
        inc x
        cpx #$0010
        bne _C2B7
        rts

        .databank 0

        ; 89/C2CF

    .endsection Unsorted89C1A1Section


    .section Unsorted89C2CFSection

      .al
      .xl

      rlUnknown89C2CF ; 89/C2CF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7E5333
        asl a
        asl a
        ora $7F847D
        tax
        lda $89C32C,x
        and #$00FF
        sta $7E5333
        lda $7E5333
        cmp #$0003
        bmi _C2F0

        _C2EE
        bra _C2EE


        _C2F0
        asl a
        tax
        jsr ($89C326,x)
        jsl rlUnknown89C3F3
        jsl rlUnknown80D143
        jsl rlUnknown89C021
        lda $0304,b
        beq _C325
        lda #$0000
        sta $7F847D
        jsl rlUnknown89B91F
        ldx #$01EA
        lda #$0004
        ldy #$0009
        jsl rlClearTilemapRect
        jsl rlUnknown89B8BD
        jsr rsUnknown89C488

        _C325
        rtl

        .databank 0

        ; 89/C326

      rsUnknown89C326 ; 89/C326

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sec
        cmp #138,s
        cmp #189,s
        cmp #0,s
        ora (wR1,x)
        sbc @l $000201,x
        sbc $010002,x
        sbc @l bBufferSETINI,x

        _C33B
        tyx
        lda $7F8483,x
        and #$00FF
        asl a
        tax
        lda $7F851A,x
        sta wCurrentItemDataRAMPointer,b
        jsl rlGetItemRAMStateAndOwner
        lda wR0
        cmp #$0001
        beq _C368
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        asl a
        ora #$0001
        sta wR0
        bra _C374


        _C368
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        asl a
        sta wR0

        _C374
        tya
        asl a
        tax
        lda wR0
        eor #$FFFF
        inc a
        sta $7F88A4,x
        inc y
        tya
        cmp $7F846B
        bne _C33B
        rts

        .databank 0

        ; 89/C38A

    .endsection Unsorted89C2CFSection


    .section Unsorted89C3F3Section

      .al
      .xl

      rlUnknown89C3F3 ; 89/C3F3

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F846B
        cmp #$0001
        beq _C435
        asl a
        sta wR15
        sec
        sbc #$0002
        sta wR14
        lda #$007F
        sep #$20
        pha
        rep #$20
        plb
        .databank $7F
        ldx #$0000

        _C411
        txy
        inc y
        inc y

        _C414
        lda @l $7F88A4,x
        cmp $88A4,b,y
        bcs _C429
        phx
        phy
        txa
        lsr a
        tax
        tya
        lsr a
        jsr rsUnknown89C438
        ply
        plx

        _C429
        inc y
        inc y
        cpy wR15
        bne _C414
        inc x
        inc x
        cpx wR14
        bne _C411

        _C435
        phk
        plb
        .databank $89
        rtl

        .databank 0

        ; 89/C438

      rsUnknown89C438 ; 89/C438

        .al
        .xl
        .autsiz
        .databank ?

        sta wR0
        cpx wR0
        bpl _C441
        tay
        txa
        tyx

        _C441
        sta wR1
        asl a
        sta wR3
        txa
        sta wR2
        asl a
        sta wR4
        sep #$20
        ldx wR2
        lda $7F8483,x
        sta wR0

        _C456
        lda $7F8482,x
        sta $7F8483,x
        dec x
        cpx wR1
        bne _C456
        lda wR0
        sta $7F8483,x
        rep #$20
        ldx wR4
        lda $7F88A4,x
        sta wR0

        _C473
        lda $7F88A2,x
        sta $7F88A4,x
        dec x
        dec x
        cpx wR3
        bne _C473
        lda wR0
        sta $7F88A4,x
        rts

        .databank 0

        ; 89/C488

    .endsection Unsorted89C3F3Section


    .section Unsorted89C488Section

      .al
      .xl

      rsUnknown89C488 ; 89/C488

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7E5333
        beq _C493
        dec a
        beq _C4F0
        bra _C497


        _C493
        jml _C549


        _C497
        lda #$2000
        sta wR1
        lda #$01E0
        sta wR2
        lda #$0003
        sta wR0
        ldx #$012E
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01CF
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0134
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01C8
        sta wR2
        lda #$0004
        sta wR0
        ldx #$01AE
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01CC
        sta wR2
        lda #$0004
        sta wR0
        ldx #$022E
        jsl rlUnknown89BECC
        rts


        _C4F0
        lda #$2000
        sta wR1
        lda #$01CC
        sta wR2
        lda #$0004
        sta wR0
        ldx #$012E
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01E0
        sta wR2
        lda #$0003
        sta wR0
        ldx #$01AE
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01CF
        sta wR2
        lda #$0001
        sta wR0
        ldx #$01B4
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01C8
        sta wR2
        lda #$0004
        sta wR0
        ldx #$022E
        jsl rlUnknown89BECC
        rts


        _C549
        lda #$2000
        sta wR1
        lda #$01C8
        sta wR2
        lda #$0004
        sta wR0
        ldx #$012E
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01CC
        sta wR2
        lda #$0004
        sta wR0
        ldx #$01AE
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01E0
        sta wR2
        lda #$0003
        sta wR0
        ldx #$022E
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01CF
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0234
        jsl rlUnknown89BECC
        rts

        .databank 0

        ; 89/C5A2

    .endsection Unsorted89C488Section


    .section Unsorted89C5A2Section

      .al
      .xl

      rsUnknown89C5A2 ; 89/C5A2

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
        lda aUnknown89C5C9,x
        phx
        tyx
        sta aBG3TilemapBuffer,x
        txy
        plx
        lda aUnknown89C5C9+2,x
        tyx
        sta $7E83C8,x
        rts

        .databank 0

        ; 89/C5C9

    .endsection Unsorted89C5A2Section
