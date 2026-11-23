; The battle scene's screen: IRQ splits installed by rsOpenBattleScene, the
; INIDISP and window HDMA tables (the letterbox, the camera), and VBlank work.
; Mostly Unknown: low-level rendering.


    .section Unsorted9590F2Section

      .al
      .xl

      rsUnknown9590F2 ; 95/90F2

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE1B3
        bit #$0004
        beq _90FF
        jml _9196


        _90FF
        ldx #$0000
        lda #$000F
        sta $7FE1F6,x
        inc x
        lda #$E1C2
        sta $7FE1F6,x
        inc x
        inc x
        lda $7FE1CA
        and #$00FF
        beq _912A
        sta $7FE1F6,x
        inc x
        lda #$E1C2
        sta $7FE1F6,x
        inc x
        inc x

        _912A
        lda $7FE1B3
        bit #$0001
        bne _9146
        lda #$0070
        sta $7FE1F6,x
        inc x
        lda #$E19B
        sta $7FE1F6,x
        inc x
        inc x
        bra _918C


        _9146
        lda $7FE19A
        and #$00FF
        clc
        adc #$0048
        cmp #$0071
        bcc _9159
        lda #$0070

        _9159
        sta $7FE1F6,x
        inc x
        lda #$E236
        sta $7FE1F6,x
        inc x
        inc x
        lda $7FE19A
        and #$00FF
        cmp #$0029
        bcs _918C
        pha
        lda #$0029
        sec
        sbc #1,s
        ora #$0080
        sta $7FE1F6,x
        pla
        inc x
        lda #$E23A
        sta $7FE1F6,x
        inc x
        inc x

        _918C
        sep #$20
        lda #$00
        sta $7FE1F6,x
        rep #$20

        _9196
        rts

        .databank 0

        ; 95/9197

      rsUnknown959197 ; 95/9197

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FE1B3
        bit #$0001
        beq _920D
        lda wBattleSceneCameraX
        cmp #$00C0
        bcc _91AE
        lda #$00BF

        _91AE
        sec
        sbc #$0040
        phx
        phy
        pha
        lda $7FE1B3
        bit #$0001
        bne _91C1
        pla
        bra _91CF


        _91C1
        pla
        sta wR10
        lda #$0192
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1

        _91CF
        ply
        plx
        sta wR10
        lda #$0029
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda #(`aUnknown988000)<<8
        sta lR18+1
        lda wR12
        clc
        adc #<>aUnknown988000
        sta lR18
        ldx #$0000
        ldy #$0000

        _91EF
        lda [lR18],y
        and #$00FF
        sta $7FE236,x
        inc x
        inc x
        inc y
        lda @l wBufferBG2VOFS
        and #$00FF
        sta $7FE236,x
        inc x
        inc x
        cpx #$00A4
        bcc _91EF

        _920D
        ply
        plx
        rts

        .databank 0

        ; 95/9210

      rsUnknown959210 ; 95/9210

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        lda #$000F
        sta $7FE1D0,x
        inc x
        lda #$0000
        sta $7FE1D0,x
        inc x
        inc x
        lda $7FE1CA
        and #$00FF
        beq _923B
        sta $7FE1D0,x
        inc x
        lda #$E1F0
        sta $7FE1D0,x
        inc x
        inc x

        _923B
        lda $7FE1CB
        and #$00FF
        beq _9276
        cmp #$0080
        bcs _9253
        sta $7FE1D0,x
        inc x
        lda #$E1F2
        bra _9270


        _9253
        sec
        sbc #$007F
        sta $7FE1D0,x
        inc x
        lda #$E1F2
        sta $7FE1D0,x
        inc x
        inc x
        lda #$007F
        sta $7FE1D0,x
        inc x
        lda #$E1F2

        _9270
        sta $7FE1D0,x
        inc x
        inc x

        _9276
        sep #$20
        lda #$00
        sta $7FE1D0,x
        rep #$20
        lda #$E1D0
        sta wR1
        lda #$E1E0
        sta wR0
        lda #$0010
        jsl rlBattleSceneQueueCopy
        rts

        .databank 0

        ; 95/9292

      rsBattleSceneUpdateHP1 ; 95/9292

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves aBattleSceneCombatant1's HP by its speed toward its target, a sound $0D for each point, and redraws its HP.

        lda aBattleSceneCombatant1.HPSpeed,b
        bne _929B
        jml _9352


        _929B
        lda aBattleSceneCombatant1.HPSpeed,b
        bmi _9300
        lda #$2940
        pha
        lda aBattleSceneCombatant1.HP,b
        clc
        adc aBattleSceneCombatant1.HPSpeed,b
        and #$FF00
        pha
        lda aBattleSceneCombatant1.HP,b
        and #$FF00
        cmp #1,s
        beq _92C0
        lda #$000D
        jsl rlPlaySoundEffect

        _92C0
        pla
        lda aBattleSceneCombatant1.HP,b
        clc
        adc aBattleSceneCombatant1.HPSpeed,b
        bcc _92D3
        lda aBattleSceneCombatant1.MaxHP,b
        and #$00FF
        xba
        bra _92F6


        _92D3
        sta aBattleSceneCombatant1.HP,b
        xba
        sep #$20
        cmp aBattleSceneCombatant1.MaxHP,b
        bcc _92E6
        lda aBattleSceneCombatant1.MaxHP,b
        xba
        lda #$00
        bra _92F6


        _92E6
        cmp aBattleSceneCombatant1.HPTarget,b
        bcc _92F3
        lda aBattleSceneCombatant1.HPTarget,b
        xba
        lda #$00
        bra _92F6


        _92F3
        xba
        bra _9347


        _92F6
        .al
        rep #$20
        sta aBattleSceneCombatant1.HP,b
        stz aBattleSceneCombatant1.HPSpeed,b
        bra _934C


        _9300
        lda #$3540
        pha
        lda aBattleSceneCombatant1.HPSpeed,b
        eor #$FFFF
        inc a
        sta wR0
        lda aBattleSceneCombatant1.HP,b
        sec
        sbc wR0
        bcs _931B
        lda #$0000
        xba
        bra _9333


        _931B
        sta aBattleSceneCombatant1.HP,b
        xba
        sep #$20
        cmp aBattleSceneCombatant1.HPTarget,b
        beq _9328
        bcs _9330

        _9328
        lda aBattleSceneCombatant1.HPTarget,b
        xba
        lda #$00
        bra _9333


        _9330
        xba
        bra _9347


        _9333
        rep #$20
        sta aBattleSceneCombatant1.HP,b
        stz aBattleSceneCombatant1.HPSpeed,b
        sep #$20
        lda #$10
        sta $7FE1C0
        rep #$20
        bra _934C


        _9347
        .as
        rep #$20
        sta aBattleSceneCombatant1.HP,b

        _934C
        pla
        jsr rsBattleSceneDrawHP1
        bra _937B


        _9352
        lda $7FE1C0
        and #$00FF
        beq _937B
        dec a
        sep #$20
        sta $7FE1C0
        rep #$20
        beq _9375
        tax
        lda aUnknown95937C,x
        and #$00FF
        bne _9375
        lda #$3540
        bra _9378


        _9375
        lda #$2940

        _9378
        jsr rsBattleSceneDrawHP1

        _937B
        rts

        .databank 0

        ; 95/937C

    .endsection Unsorted9590F2Section


    .section Unsorted95A114Section

      .al
      .xl

      rsBattleSceneBuildBrightnessTable ; 95/A114

        .al
        .xl
        .autsiz
        .databank ?

        ; Writes the INIDISP HDMA table: 15 lines of $0ADD (blank), then $70 lines at the fade's brightness; queued for copy into the live table.

        pha
        phx
        phy
        sep #$20
        ldx #$0000
        lda #$0F
        sta aBattleSceneBrightnessTableBuffer,x
        inc x
        lda bBattleSceneLetterboxINIDISP,b
        sta aBattleSceneBrightnessTableBuffer,x
        inc x
        lda #$70
        sta aBattleSceneBrightnessTableBuffer,x
        inc x
        lda $7FE4DD
        bit #$80
        beq _A13E
        lda bBufferINIDISP
        bra _A142


        _A13E
        lda $7FE4DD

        _A142
        sta aBattleSceneBrightnessTableBuffer,x
        inc x
        lda #$00
        sta aBattleSceneBrightnessTableBuffer,x
        rep #$20
        lda #$E33A
        sta wR1
        lda #$E36A
        sta wR0
        lda #$0030
        jsl rlBattleSceneQueueCopy
        ply
        plx
        pla
        rts

        .databank 0

        ; 95/A164

      rlUnknown95A164 ; 95/A164

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 95/A165

      rlUnknown95A165 ; 95/A165

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 95/A166

        ; Unreachable: it follows a return.
        rtl

    .endsection Unsorted95A114Section


    .section Unsorted95A414Section

      .al
      .xl

      rlUnknown95A414 ; 95/A414

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown95E6EA)<<8
        sta lR44+1
        lda #<>aUnknown95E6EA
        sta lR44
        lda #$0004
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        rtl

        .databank 0

        ; 95/A428

      rlUnknown95A428 ; 95/A428

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown95E6D2)<<8
        sta lR44+1
        lda #<>aUnknown95E6D2
        sta lR44
        lda #$0007
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        rtl

        .databank 0

        ; 95/A43C

      rlUnknown95A43C ; 95/A43C

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta bBattleSceneFade
        sta bBattleSceneFadeDelay
        sta bBattleSceneFadeTimer
        rep #$20
        rtl

        .databank 0

        ; 95/A44F

      rlBattleSceneStartFadeIn ; 95/A44F

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta bBattleSceneFade
        rep #$20
        rtl

        .databank 0

        ; 95/A45A

      rlBattleSceneStartFadeOut ; 95/A45A

        .al
        .xl
        .autsiz
        .databank ?

        ; Fades the scene out (bBattleSceneFade $CF); also fades the music (sound $E0) when $7FFC9D is set, except in battle type $FF.

        sep #$20
        lda #$CF
        sta bBattleSceneFade
        rep #$20
        lda wBattleType
        and #$00FF
        cmp #$00FF
        beq _A480
        lda $7FFC9D
        and #$00FF
        beq _A480
        lda #$00E0
        jsl rlSendSoundCommand

        _A480
        rtl

        .databank 0

        ; 95/A481

    .endsection Unsorted95A414Section


    .section Table968000Section

      .al
      .xl

      aUnknown968000 ; 96/8000
        .word $0060, $00CF, <>rlUnknown968008, <>aUnknown96800D

    .endsection Table968000Section


    .section Unsorted968008Section

      .al
      .xl

      rlUnknown968008 ; 96/8008

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown96892D
        rtl

        .databank 0

        ; 96/800D

    .endsection Unsorted968008Section


    .section Table96800DSection

      .al
      .xl

      aUnknown96800D ; 96/800D
        .word <>rsIRQCodeHalt

      aUnknown96800F ; 96/800F
        .word $0060, $007E, <>rlUnknown968017, <>aUnknown96804E

    .endsection Table96800DSection


    .section Unsorted968017Section

      .al
      .xl

      rlUnknown968017 ; 96/8017

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4C2
        and #$00FF
        cmp #$0004
        bcs _803F
        cmp #$0003
        bcs _8039
        cmp #$0002
        bcs _8033
        jsl rlUnknown968982
        bra _8043


        _8033
        jsl rlUnknown968BC2
        bra _8043


        _8039
        jsl rlUnknown968C97
        bra _8043


        _803F
        jsl rlUnknown968D22

        _8043
        sep #$20
        lda #$01
        sta $7FE1CF
        rep #$20
        rtl

        .databank 0

        ; 96/804E

    .endsection Unsorted968017Section


    .section Table96804ESection

      .al
      .xl

      aUnknown96804E ; 96/804E
        .word <>rsIRQCodeHalt

      aUnknown968050 ; 96/8050
        .word $0060, $009C, <>rlUnknown968058, <>aUnknown968076

    .endsection Table96804ESection


    .section Unsorted968058Section

      .al
      .xl

      rlUnknown968058 ; 96/8058

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4C2
        and #$00FF
        cmp #$0003
        beq _806F
        cmp #$0001
        bne _8075
        jsl rlUnknown968A57
        bra _8075


        _806F
        jsl rlUnknown968DAA
        bra _8075


        _8075
        rtl

        .databank 0

        ; 96/8076

    .endsection Unsorted968058Section


    .section Table968076Section

      .al
      .xl

      aUnknown968076 ; 96/8076
        .word <>rsIRQCodeHalt

      aUnknown968078 ; 96/8078
        .word $0060, $00A1, <>rlUnknown968080, <>aUnknown968093

    .endsection Table968076Section


    .section Unsorted968080Section

      .al
      .xl

      rlUnknown968080 ; 96/8080

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4C2
        and #$00FF
        cmp #$0001
        bne _8092
        jsl rlUnknown968B16
        bra _8092


        _8092
        rtl

        .databank 0

        ; 96/8093

    .endsection Unsorted968080Section


    .section Table968093Section

      .al
      .xl

      aUnknown968093 ; 96/8093
        .word <>rsIRQCodeHalt

      aUnknown968095 ; 96/8095
        .word $0060, $000E, <>rlUnknown96809D, <>aUnknown9680A2

    .endsection Table968093Section


    .section Unsorted96809DSection

      .al
      .xl

      rlUnknown96809D ; 96/809D

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown968943
        rtl

        .databank 0

        ; 96/80A2

    .endsection Unsorted96809DSection


    .section Table9680A2Section

      .al
      .xl

      aUnknown9680A2 ; 96/80A2
        .word <>rsIRQCodeHalt

    .endsection Table9680A2Section


    .section Unsorted96890ESection

      .al
      .xl

      rlUnknown96890E ; 96/890E

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FE4C2
        rep #$20
        stz aBGPaletteBuffer,b
        jsl rlBattleSceneSetHUDColors
        jsl rlUnknown95A414
        jsl rlUnknown96957D
        jsl rlUnknown969EBB
        rtl

        .databank 0

        ; 96/892C

      rlUnknown96892C ; 96/892C

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 96/892D

      rlUnknown96892D ; 96/892D

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        stz $420C,b

        _8932
        lda $4212,b
        bit #$40
        beq _8932
        lda #$80
        sta $2100,b
        rep #$20
        rep #$20
        rtl

        .databank 0

        ; 96/8943

      rlUnknown968943 ; 96/8943

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8945
        lda $4212,b
        bit #$40
        beq _8945
        lda #$80
        lda $7FE4DD
        bit #$80
        bne _896A

        _8956
        lda $4212,b
        bit #$40
        bne _8956

        _895D
        lda $4212,b
        bit #$40
        beq _895D
        lda $7FE4DD
        bra _897C


        _896A
        lda $4212,b
        bit #$40
        bne _896A

        _8971
        lda $4212,b
        bit #$40
        beq _8971
        lda $7FE4DD

        _897C
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 96/8982

      rlUnknown968982 ; 96/8982

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8984
        lda $4212,b
        bit #$40
        beq _8984
        lda #$80
        sta $2100,b
        lda #$06
        sta $212C,b
        lda #$09
        sta $2105,b
        lda #$6A
        sta $2107,b
        sta $2108,b
        sta $2109,b
        lda #$77
        sta $210B,b
        lda #$77
        sta $210C,b
        lda bBattleSceneHUDBG2Y
        sta $2110,b
        lda #$01
        sta $2110,b
        lda bBattleSceneHUDBG2X
        sta $210F,b
        stz $210F,b
        lda bBattleSceneHUDBG3Y
        sta $2112,b
        stz $2112,b
        lda bBattleSceneHUDBG3X
        sta $2111,b
        stz $2111,b
        stz $2123,b
        stz $2124,b
        stz $420C,b
        rep #$20
        jsl rlUnknown9695D5
        sep #$20
        lda #$00
        sta $2121,b
        sta $2122,b
        sta $2122,b
        lda #$15
        sta $2121,b
        lda aUnknownE000B0+6
        sta $2122,b
        lda aUnknownE000B0+7
        sta $2122,b
        lda aUnknownE000B0+8
        sta $2122,b
        lda aUnknownE000B0+9
        sta $2122,b
        lda aUnknownE000B0+10
        sta $2122,b
        lda aUnknownE000B0+11
        sta $2122,b
        lda $7FFC6F
        sta $420C,b

        _8A2B
        lda $4212,b
        bit #$40
        bne _8A2B

        _8A32
        lda $4212,b
        bit #$40
        beq _8A32
        lda $7FE4D5
        bra _8A51

        .byte $AD, $12, $42, $89, $40, $D0, $F9, $AD, $12, $42, $89, $40, $F0, $F9, $AF, $DC
        .byte $E4, $7F


        _8A51
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 96/8A57

      rlUnknown968A57 ; 96/8A57

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8A59
        lda $4212,b
        bit #$40
        beq _8A59
        lda #$80
        sta $2100,b
        lda #$06
        sta $212C,b
        lda #$6A
        sta $2107,b
        sta $2108,b
        sta $2109,b
        lda #$77
        sta $210B,b
        lda #$77
        sta $210C,b
        lda $7FE4C6
        sta $2110,b
        lda $7FE4C7
        sta $2110,b
        lda #$04
        sta $210F,b
        stz $210F,b
        lda $7FE4C8
        clc
        adc #$04
        sta $2112,b
        lda $7FE4C9
        sta $2112,b
        stz $2111,b
        stz $2111,b
        lda $7FE4C5
        and #$FF
        sta $16DA,b,x
        lda #$11
        sta $2121,b
        lda aUnknownE000B0
        sta $2122,b
        lda aUnknownE000B0+1
        sta $2122,b
        lda aUnknownE000B0+2
        sta $2122,b
        lda aUnknownE000B0+3
        sta $2122,b
        lda aUnknownE000B0+4
        sta $2122,b
        lda aUnknownE000B0+5
        sta $2122,b
        lda $7FE4D5
        bit #$80

        _8AEA
        lda $4212,b
        bit #$40
        bne _8AEA

        _8AF1
        lda $4212,b
        bit #$40
        beq _8AF1
        lda $7FE4D5
        bra _8B10

        .byte $AD, $12, $42, $89, $40, $D0, $F9, $AD, $12, $42, $89, $40, $F0, $F9, $AF, $DC
        .byte $E4, $7F


        _8B10
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 96/8B16

      rlUnknown968B16 ; 96/8B16

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8B18
        lda $4212,b
        bit #$40
        beq _8B18
        lda #$80
        sta $2100,b
        lda #$06
        sta $212C,b
        lda #$6A
        sta $2107,b
        sta $2108,b
        sta $2109,b
        lda #$77
        sta $210B,b
        lda #$77
        sta $210C,b
        lda #$7F
        sta $2110,b
        lda #$01
        sta $2110,b
        stz $210F,b
        stz $210F,b
        lda #$97
        sta $2112,b
        stz $2112,b
        lda #$FC
        sta $2111,b
        stz $2111,b
        lda $7FE4CB
        and #$FF
        sta $16DA,b,x
        lda #$11
        sta $2121,b
        lda $0122,b
        sta $2122,b
        lda $0123,b
        sta $2122,b
        lda $0124,b
        sta $2122,b
        lda $0125,b
        sta $2122,b
        lda $0126,b
        sta $2122,b
        lda $0127,b
        sta $2122,b
        lda $7FE4D5
        bit #$80

        _8B96
        lda $4212,b
        bit #$40
        bne _8B96

        _8B9D
        lda $4212,b
        bit #$40
        beq _8B9D
        lda $7FE4D5
        bra _8BBC

        .byte $AD, $12, $42, $89, $40, $D0, $F9, $AD, $12, $42, $89, $40, $F0, $F9, $AF, $DC
        .byte $E4, $7F


        _8BBC
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 96/8BC2

      rlUnknown968BC2 ; 96/8BC2

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8BC4
        lda $4212,b
        bit #$40
        beq _8BC4
        lda #$80
        sta $2100,b
        lda #$17
        sta $212C,b
        lda #$03
        sta $2101,b
        lda #$6A
        sta $2107,b
        sta $2108,b
        sta $2109,b
        lda #$77
        sta $210B,b
        lda #$77
        sta $210C,b
        lda #$47
        sta $210E,b
        lda #$00
        sta $210E,b
        lda #$00
        sta $210D,b
        stz $210D,b
        lda #$F7
        sta $2110,b
        lda #$01
        sta $2110,b
        lda #$00
        sta $210F,b
        stz $210F,b
        lda #$0F
        sta $2112,b
        lda #$01
        sta $2112,b
        stz $2111,b
        stz $2111,b
        lda #$10
        sta $420C,b
        lda #$81
        sta $2121,b
        lda aUnknownE000C8
        sta $2122,b
        lda aUnknownE000C8+1
        sta $2122,b
        lda aUnknownE000C8+2
        sta $2122,b
        lda aUnknownE000C8+3
        sta $2122,b
        lda aUnknownE000C8+4
        sta $2122,b
        lda aUnknownE000C8+5
        sta $2122,b
        stz $2123,b
        stz $2124,b
        rep #$20
        jsl rlUnknown9695D5
        sep #$20
        lda $7FE4D5
        bit #$80

        _8C6B
        lda $4212,b
        bit #$40
        bne _8C6B

        _8C72
        lda $4212,b
        bit #$40
        beq _8C72
        lda $7FE4D5
        bra _8C91

        .byte $AD, $12, $42, $89, $40, $D0, $F9, $AD, $12, $42, $89, $40, $F0, $F9, $AF, $DC
        .byte $E4, $7F


        _8C91
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 96/8C97

      rlUnknown968C97 ; 96/8C97

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8C99
        lda $4212,b
        bit #$40
        beq _8C99
        lda #$80
        sta $2100,b
        lda #$06
        sta $212C,b
        lda #$03
        sta $2101,b
        lda #$6A
        sta $2107,b
        sta $2108,b
        lda #$74
        sta $2109,b
        lda #$77
        sta $210B,b
        sta $210C,b
        lda #$F7
        sta $2110,b
        lda #$01
        sta $2110,b
        lda #$00
        sta $210F,b
        stz $210F,b
        lda #$FF
        sta $2112,b
        sta $2112,b
        stz $2111,b
        stz $2111,b
        stz $2123,b
        stz $2124,b
        stz $2131,b
        stz $2125,b
        lda $7FE4D5
        bit #$80

        _8CF6
        lda $4212,b
        bit #$40
        bne _8CF6

        _8CFD
        lda $4212,b
        bit #$40
        beq _8CFD
        lda $7FE4D5
        bra _8D1C

        .byte $AD, $12, $42, $89, $40, $D0, $F9, $AD, $12, $42, $89, $40, $F0, $F9, $AF, $DC
        .byte $E4, $7F


        _8D1C
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 96/8D22

      rlUnknown968D22 ; 96/8D22

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8D24
        lda $4212,b
        bit #$40
        beq _8D24
        lda #$80
        sta $2100,b
        lda #$16
        sta $212C,b
        lda #$03
        sta $2101,b
        lda #$6A
        sta $2108,b
        lda #$74
        sta $2109,b
        lda #$77
        sta $210B,b
        sta $210C,b
        lda #$F7
        sta $2110,b
        lda #$01
        sta $2110,b
        lda #$00
        sta $210F,b
        stz $210F,b
        lda #$FF
        sta $2112,b
        sta $2112,b
        stz $2111,b
        stz $2111,b
        stz $2123,b
        stz $2124,b
        stz $2131,b
        stz $2125,b
        lda $7FE4D5
        bit #$80

        _8D7E
        lda $4212,b
        bit #$40
        bne _8D7E

        _8D85
        lda $4212,b
        bit #$40
        beq _8D85
        lda $7FE4D5
        bra _8DA4

        .byte $AD, $12, $42, $89, $40, $D0, $F9, $AD, $12, $42, $89, $40, $F0, $F9, $AF, $DC
        .byte $E4, $7F


        _8DA4
        sta $2100,b
        rep #$20
        rtl

        .databank 0

        ; 96/8DAA

      rlUnknown968DAA ; 96/8DAA

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _8DAC
        lda $4212,b
        bit #$40
        beq _8DAC
        lda #$16
        sta $212C,b
        rep #$20
        rtl

        .databank 0

        ; 96/8DBB

        ; Unreachable: it follows a return.
        rtl
        rtl

    .endsection Unsorted96890ESection


    .section Unsorted968DBDSection

      .al
      .xl

      rlUnknown968DBD ; 96/8DBD

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$8F
        sta $7FE4D5
        rep #$20
        rtl

        .databank 0

        ; 96/8DC8

      rlUnknown968DC8 ; 96/8DC8

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4D5
        and #$000F
        bne _8DD7
        jsl rlBattleSceneEndScriptRoutine
        bra _8DE0


        _8DD7
        sep #$20
        dec a
        sta $7FE4D5
        rep #$20

        _8DE0
        rtl

        .databank 0

        ; 96/8DE1

    .endsection Unsorted968DBDSection


    .section Unreferenced968DE1Section

      .al
      .xl

      rlUnknown968DE1 ; 96/8DE1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4D5
        and #$000F
        bne _8DF0
        jsl rlBattleSceneEndScriptRoutine
        bra _8DFF


        _8DF0
        sep #$20
        sec
        sbc #$03
        bcs _8DF9
        lda #$00

        _8DF9
        sta $7FE4D5
        rep #$20

        _8DFF
        rtl

        .databank 0

        ; 96/8E00

      rlUnknown968E00 ; 96/8E00

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wBattleSceneFrame
        bit #$0001
        beq _8E21
        lda $7FE4D5
        and #$000F
        bne _8E18
        jsl rlBattleSceneEndScriptRoutine
        bra _8E21


        _8E18
        sep #$20
        dec a
        sta $7FE4D5
        rep #$20

        _8E21
        rtl

        .databank 0

        ; 96/8E22

      rlUnknown968E22 ; 96/8E22

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4D5
        and #$000F
        cmp #$000F
        bne _8E42
        sep #$20
        sta $7FE4D5
        lda $7FE4B7
        and #$FE
        sta $7FE4B7
        rep #$20
        bra _8E4B


        _8E42
        sep #$20
        inc a
        sta $7FE4D5
        rep #$20

        _8E4B
        rtl

        .databank 0

        ; 96/8E4C

    .endsection Unreferenced968DE1Section
    .section Unsorted968E4CSection

      .al
      .xl

      rlUnknown968E4C ; 96/8E4C

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4D5
        and #$000F
        cmp #$000F
        bne _8E6C
        sep #$20
        sta $7FE4D5
        lda $7FE4B7
        and #$FE
        sta $7FE4B7
        rep #$20
        bra _8E7D


        _8E6C
        sep #$20
        clc
        adc #$03
        cmp #$0F
        bcc _8E77
        lda #$0F

        _8E77
        sta $7FE4D5
        rep #$20

        _8E7D
        rtl

        .databank 0

        ; 96/8E7E

      rlUnknown968E7E ; 96/8E7E

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$8F
        sta $7FE4DD
        lda #$0F
        sta $7FE4DC
        rep #$20
        rtl

        .databank 0

        ; 96/8E8F

    .endsection Unsorted968E4CSection


    .section Unreferenced968E8FSection

      .al
      .xl

      rlUnknown968E8F ; 96/8E8F

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4DD
        and #$000F
        bne _8E9E
        jsl rlBattleSceneEndScriptRoutine
        bra _8EA7


        _8E9E
        sep #$20
        dec a
        sta $7FE4DD
        rep #$20

        _8EA7
        rtl

        .databank 0

        ; 96/8EA8

      rlUnknown968EA8 ; 96/8EA8

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4DD
        and #$000F
        bne _8EB7
        jsl rlBattleSceneEndScriptRoutine
        bra _8EC6


        _8EB7
        sep #$20
        sec
        sbc #$03
        bcs _8EC0
        lda #$00

        _8EC0
        sta $7FE4DD
        rep #$20

        _8EC6
        rtl

        .databank 0

        ; 96/8EC7

      rlUnknown968EC7 ; 96/8EC7

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wBattleSceneFrame
        bit #$0001
        beq _8EE8
        lda $7FE4DD
        and #$000F
        bne _8EDF
        jsl rlBattleSceneEndScriptRoutine
        bra _8EE8


        _8EDF
        sep #$20
        dec a
        sta $7FE4DD
        rep #$20

        _8EE8
        rtl

        .databank 0

        ; 96/8EE9

      rlUnknown968EE9 ; 96/8EE9

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4DD
        and #$000F
        cmp #$000F
        bne _8F09
        sep #$20
        sta $7FE4DD
        lda $7FE4B7
        and #$FE
        sta $7FE4B7
        rep #$20
        bra _8F12


        _8F09
        sep #$20
        inc a
        sta $7FE4DD
        rep #$20

        _8F12
        rtl

        .databank 0

        ; 96/8F13

      rlUnknown968F13 ; 96/8F13

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7FE4DD
        and #$000F
        cmp #$000F
        bne _8F33
        sep #$20
        sta $7FE4DD
        lda $7FE4B7
        and #$FE
        sta $7FE4B7
        rep #$20
        bra _8F44


        _8F33
        sep #$20
        clc
        adc #$03
        cmp #$0F
        bcc _8F3E
        lda #$0F

        _8F3E
        sta $7FE4DD
        rep #$20

        _8F44
        rtl

        .databank 0

        ; 96/8F45

      rlUnknown968F45 ; 96/8F45

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$0F
        sta $7FE4DD
        rep #$20
        rtl

        .databank 0

        ; 96/8F50

    .endsection Unreferenced968E8FSection
    .section Unsorted968F50Section

      .al
      .xl

      rlUnknown968F50 ; 96/8F50

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #$0004
        sta $7E52F0
        lda #$0000
        sta $7E5313
        lda #(`rlUnknown968F71)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlUnknown968F71
        sta lBattleSceneScriptRoutine
        ply
        plx
        rtl

        .databank 0

        ; 96/8F71

      rlUnknown968F71 ; 96/8F71

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy

        _8F73
        lda $7E5313
        tax
        lda aUnknown998683,x
        cmp #$0080
        bne _8F89
        jsl rlBattleSceneEndScriptRoutine
        jml _9034


        _8F89
        lda aUnknown998683,x
        sta lR18
        lda aUnknown998683+1,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        bne _8FAD
        lda $7E5313
        clc
        adc #$0009
        sta $7E5313
        bra _8F73


        _8FAD
        pha
        pha
        bit #$0080
        bne _8FBE
        lda #$015E
        sta $7E530D
        pla
        bra _8FCD


        _8FBE
        lda #$015F
        sta $7E530D
        pla
        eor #$FFFF
        inc a
        and #$00FF

        _8FCD
        jsr rsUnknown969137
        sta $7E530F
        lda aUnknown998683+3,x
        sta lR18
        lda aUnknown998683+4,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        clc
        adc #1,s
        jsr rsUnknown969137
        sta $7E5304
        lda lR18
        sta $7E52FF
        pla
        lda aUnknown998683+6,x
        sta $7E530B
        lda aUnknown998683+8,x
        and #$00FF
        jsl rlBattleSceneStartStatGauge
        lda $7E5313
        clc
        adc #$0009
        sta $7E5313
        lda #$0000
        sta $7E5311
        lda #$0023
        jsl rlPlaySoundEffect
        lda #(`rlUnknown969037)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlUnknown969037
        sta lBattleSceneScriptRoutine

        _9034
        ply
        plx
        rtl

        .databank 0

        ; 96/9037

      rlUnknown969037 ; 96/9037

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy

        _9039
        lda $7E5311
        tax
        lda aUnknown998532,x
        and #$00FF
        cmp #$0082
        bne _9072
        lda wBattleType
        and #$00FF
        cmp #$0002
        beq _9064
        lda $7E5311
        clc
        adc #$0019
        sta $7E5311
        bra _9039


        _9064
        lda $7E5311
        clc
        adc #$0001
        sta $7E5311
        bra _9039


        _9072
        lda aUnknown998532,x
        and #$00FF
        cmp #$0080
        bne _9090
        lda #(`rlUnknown968F71)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlUnknown968F71
        sta lBattleSceneScriptRoutine
        jml _9130


        _9090
        cmp #$0081
        bne _90A2
        lda #$01FF
        sta $7E52F5
        sta $7E52FA
        bra _90B4


        _90A2
        pha
        lda $7E530D
        sta $7E52F5
        lda $7E530F
        sta $7E52FA
        pla

        _90B4
        sta $7E52F7
        sec
        sbc #$0008
        and #$01FF
        sta $7E52F2
        lda #$0000
        sec
        sbc #$0008
        and #$01FF
        sta $7E5301
        sec
        sbc #$0008
        and #$01FF
        sta $7E52FC
        sep #$20
        lda aUnknown998532+1,x
        sta $7E52F4
        sta $7E52F9
        lda #$00
        sta $7E52FE
        sta $7E5303
        rep #$20
        phb
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        ldy #$52F0
        lda @l $7E530B
        and #$00FF
        sta wR0
        lda @l $7E530C
        and #$00FF
        sta wR1
        lda #$3000
        sta wR4
        lda #$0000
        sta wR5
        clc
        jsl rlBattleScenePushSprites
        plb
        .databank $7E
        lda @l $7E5311
        clc
        adc #$0002
        sta @l $7E5311

        _9130
        jsl rlBattleSceneRunStatGauge
        ply
        plx
        rtl

        .databank 0

        ; 96/9137

      rsUnknown969137 ; 96/9137

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        cmp #$000A
        bcs _9147
        pha
        lda #$01FF
        sta lR18
        pla
        bra _915C


        _9147
        sta wR13
        lda #$000A
        sta wR14
        jsl rlBattleSceneDivide
        lda wR13
        clc
        adc #$0154
        sta lR18
        lda wR10

        _915C
        clc
        adc #$0154
        ply
        plx
        rts

        .databank 0

        ; 96/9163

      rlUnknown969163 ; 96/9163

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #$0005
        sta $7E52F0
        lda #$015E
        sta $7E530D
        ldx #$0000
        jsl rlUnknown95B5FD
        pha
        lda bBattleAnimationY,b,x
        and #$00FF
        clc
        adc #1,s
        pha
        lda #$0064
        sec
        sbc #1,s
        sep #$20
        sta $7E530C
        rep #$20
        pla
        pla
        lda wBattleAnimationX,b,x
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        jsl rlUnknown95A164
        sec
        sbc #$0004
        sep #$20
        sta $7E530B
        rep #$20
        lda #$0000
        sta $7E5311
        lda #(`rlUnknown9691C8)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlUnknown9691C8
        sta lBattleSceneScriptRoutine
        ply
        plx
        rtl

        .databank 0

        ; 96/91C8

      rlUnknown9691C8 ; 96/91C8

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7E5311
        tax
        lda aUnknown998586,x
        and #$00FF
        cmp #$0080
        bne _91E3
        jsl rlBattleSceneEndScriptRoutine
        jml _92F5


        _91E3
        cmp #$0081
        bne _9223
        lda #$01FF
        sta $7E52F5
        sta $7E52FA
        sta $7E52FF
        sta $7E5304
        sta $7E5309
        sep #$20
        lda aUnknown998586+1,x
        clc
        adc #$80
        sta $7E52F4
        sta $7E52F9
        sta $7E52FE
        sta $7E5303
        sta $7E5308
        rep #$20
        lda #$0000
        bra _9266


        _9223
        lda #$067B
        sta $7E52F5
        lda #$067C
        sta $7E52FA
        lda #$067D
        sta $7E52FF
        lda #$067E
        sta $7E5304
        lda #$067F
        sta $7E5309
        sep #$20
        lda aUnknown998586+1,x
        sta $7E52F4
        sta $7E52F9
        sta $7E52FE
        sta $7E5303
        sta $7E5308
        rep #$20
        lda aUnknown998586,x

        _9266
        and #$00FF
        bit #$0080
        beq _9271
        ora #$0100

        _9271
        sta $7E52F2
        phx
        pha
        lda aUnknown998586+2,x
        and #$00FF
        asl a
        asl a
        tax
        lda aUnknown99862F,x
        and #$00FF
        clc
        adc #1,s
        sta $7E52F7
        lda aUnknown99862F+1,x
        and #$00FF
        clc
        adc #1,s
        sta $7E52FC
        lda aUnknown99862F+2,x
        and #$00FF
        clc
        adc #1,s
        sta $7E5301
        lda aUnknown99862F+3,x
        and #$00FF
        clc
        adc #1,s
        sta $7E5306
        pla
        plx
        phb
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        ldy #$52F0
        lda @l $7E530B
        and #$00FF
        sta wR0
        lda @l $7E530C
        and #$00FF
        sta wR1
        lda #$3000
        sta wR4
        lda #$0000
        sta wR5
        clc
        jsl rlBattleScenePushSprites
        plb
        .databank $7E
        lda @l $7E5311
        clc
        adc #$0003
        sta @l $7E5311

        _92F5
        ply
        plx
        rtl

        .databank 0

        ; 96/92F8

    .endsection Unsorted968F50Section


    .section Unreferenced9692F8Section

      .al
      .xl

      rlUnknown9692F8 ; 96/92F8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy

        _92FA
        lda $7E5313
        tax
        lda aUnknown998683,x
        cmp #$0080
        bne _9310
        jsl rlBattleSceneEndScriptRoutine
        jml _9395


        _9310
        lda aUnknown998683,x
        sta lR18
        lda aUnknown998683+1,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        bne _9334
        lda $7E5313
        clc
        adc #$0009
        sta $7E5313
        bra _92FA


        _9334
        pha
        jsr rsUnknown969137
        sta $7E530F
        lda aUnknown998683+3,x
        sta lR18
        lda aUnknown998683+4,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        clc
        adc #1,s
        jsr rsUnknown969137
        sta $7E5304
        lda lR18
        sta $7E52FF
        pla
        lda aUnknown998683+6,x
        sta $7E530B
        lda aUnknown998683+8,x
        and #$00FF
        jsl rlBattleSceneStartStatGauge
        lda $7E5313
        clc
        adc #$0009
        sta $7E5313
        lda #$0000
        sta $7E5311
        lda #(`rlUnknown969037)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlUnknown969037
        sta lBattleSceneScriptRoutine

        _9395
        ply
        plx
        rtl

        .databank 0

        ; 96/9398

    .endsection Unreferenced9692F8Section
    .section Unsorted96957DSection

      .al
      .xl

      rlUnknown96957D ; 96/957D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _9581
        lda aUnknown98ABFC,x
        sta $7FE3F1,x
        lda aUnknown98ABFC+2,x
        sta $7FE3F3,x
        lda aUnknown98ABFC+4,x
        sta $7FE3F5,x
        lda aUnknown98ABFC+6,x
        sta $7FE3F7,x
        txa
        clc
        adc #$0008
        tax
        cpx #$0050
        bcc _9581
        plx
        rtl

        .databank 0

        ; 96/95AE

      rlUnknown9695AE ; 96/95AE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sec
        sbc #$8A8A
        sep #$20
        xba
        inc a
        sta wR0
        stz wR0+1
        rep #$20
        xba
        and #$00FF
        tax
        sep #$20

        _95C4
        lda aUnknown98AC4C,x
        sta $7FE3FD,x
        inc x
        cpx wR0
        bcc _95C4
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/95D5

      rlUnknown9695D5 ; 96/95D5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8200
        sta $2130,b
        sep #$20
        stz $2125,b
        rep #$20
        rtl

        .databank 0

        ; 96/95E3

      rlUnknown9695E3 ; 96/95E3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FE3EA
        tax
        sep #$20
        lda #$00
        sta aMapWindowTextBuffer,x
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/95F5

      rlUnknown9695F5 ; 96/95F5

        .al
        .xl
        .autsiz
        .databank ?

        lda wBattleSong
        beq _9602
        sta wMusicID,b
        jsl rlStepMusicScript

        _9602
        rtl

        .databank 0

        ; 96/9603

    .endsection Unsorted96957DSection


    .section Unsorted969603Section

      .al
      .xl

      rlBattleSceneFadeMusicForJulius ; 96/9603

        .al
        .xl
        .autsiz
        .databank ?

        ; Sound command $C0, except in battle type $FF.

        lda wBattleType
        and #$00FF
        cmp #$00FF
        beq _9616
        lda #$00C0
        jsl rlQueueSoundCommand

        _9616
        rtl

        .databank 0

        ; 96/9617

    .endsection Unsorted969603Section


    .section Unsorted969617Section

      .al
      .xl

      rlUnknown969617 ; 96/9617

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$00E0
        jsl rlSendSoundCommand
        rtl

        .databank 0

        ; 96/961F

    .endsection Unsorted969617Section


    .section Unsorted969F7DSection

      .al
      .xl

      rlUnknown969F7D ; 96/9F7D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda wBattleDistance
        cmp #$0002
        bcs _9FC1
        ldx #$0000
        ldy #$0000

        _9F8E
        lda $7E4F85,x
        cmp #$FFFF
        beq _9FC1
        cmp #$FEFF
        beq _9FC1
        bit #$0080
        bne _9FBD
        bit #$0002
        bne _9FC1
        bit #$0001
        bne _9FB5
        cpy #$0002
        beq _9FC4
        ldy #$0001
        bra _9FBD


        _9FB5
        cpy #$0001
        beq _9FC4
        ldy #$0002

        _9FBD
        inc x
        inc x
        bra _9F8E


        _9FC1
        clc
        bra _9FC5


        _9FC4
        sec

        _9FC5
        ply
        plx
        rtl

        .databank 0

        ; 96/9FC8

      rlUnknown969FC8 ; 96/9FC8

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FFC77
        ora #$02
        sta $7FFC77
        rep #$20
        rtl

        .databank 0

        ; 96/9FD7

      rlUnknown969FD7 ; 96/9FD7

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC77
        bit #$0002
        beq _9FEA
        sep #$20
        eor #$03
        sta $7FFC77
        rep #$20

        _9FEA
        rtl

        .databank 0

        ; 96/9FEB

      rlUnknown969FEB ; 96/9FEB

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC7C
        sta aSpriteExtBuffer,b
        lda $7FFC7E
        sta $1E02,b
        lda $7FFC80
        sta $1E04,b
        lda $7FFC82
        sta $1E06,b
        lda $7FFC84
        sta $1E08,b
        lda $7FFC86
        sta $1E0A,b
        lda $7FFC88
        sta $1E0C,b
        lda $7FFC8A
        sta $1E0E,b
        lda $7FFC8C
        sta $1E10,b
        lda $7FFC8E
        sta $1E12,b
        lda $7FFC90
        sta $1E14,b
        lda $7FFC92
        sta $1E16,b
        lda $7FFC94
        sta $1E18,b
        lda $7FFC96
        sta $1E1A,b
        lda $7FFC98
        sta $1E1C,b
        lda $7FFC9A
        sta $1E1E,b
        rtl

        .databank 0

        ; 96/A05C

    .endsection Unsorted969F7DSection


    .section Unsorted96A05CSection

      .al
      .xl

      rlUnknown96A05C ; 96/A05C

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC77
        bit #$0002
        beq _A0E1
        bit #$0001
        bne _A0E1
        lda wNextFreeSpriteOffset,b
        sta $7FFC78
        lda aSpriteExtBuffer,b
        sta $7FFC7C
        lda $1E02,b
        sta $7FFC7E
        lda $1E04,b
        sta $7FFC80
        lda $1E06,b
        sta $7FFC82
        lda $1E08,b
        sta $7FFC84
        lda $1E0A,b
        sta $7FFC86
        lda $1E0C,b
        sta $7FFC88
        lda $1E0E,b
        sta $7FFC8A
        lda $1E10,b
        sta $7FFC8C
        lda $1E12,b
        sta $7FFC8E
        lda $1E14,b
        sta $7FFC90
        lda $1E16,b
        sta $7FFC92
        lda $1E18,b
        sta $7FFC94
        lda $1E1A,b
        sta $7FFC96
        lda $1E1C,b
        sta $7FFC98
        lda $1E1E,b
        sta $7FFC9A

        _A0E1
        rtl

        .databank 0

        ; 96/A0E2

      rlUnknown96A0E2 ; 96/A0E2

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC78
        sta $7FFC7A
        rtl

        .databank 0

        ; 96/A0EB

    .endsection Unsorted96A05CSection


    .section Unreferenced96A0EBSection

      .al
      .xl

      rlUnknown96A0EB ; 96/A0EB

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        php
        bcs _A134
        sep #$10
        rep #$20
        lda #$0400
        sta $4300,b
        lda #$1C00
        sta $4302,b
        ldx #$00
        stx $4304,b
        lda #$0220
        sta $4305,b
        stz $2102,b
        lda #$2200
        sta $4310,b
        lda #$0100
        sta $4312,b
        ldx #$00
        stx $4314,b
        lda #$0200
        sta $4315,b
        ldx #$00
        stx $2121,b
        ldx #$03
        stx $420B,b
        lda wBufferOAMADD
        sta $2102,b
        bra _A15C


        _A134
        .xl
        sep #$10
        rep #$20
        lda #$0400
        sta $4300,b
        lda #$1C00
        sta $4302,b
        ldx #$00
        stx $4304,b
        lda #$0220
        sta $4305,b
        stz $2102,b
        ldx #$01
        stx $420B,b
        lda wBufferOAMADD
        sta $2102,b

        _A15C
        rep #$30
        plp
        rtl

        .databank 0

        ; 96/A160

      rlUnknown96A160 ; 96/A160

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda #$01
        sta bBufferTS
        lda #$02
        sta bBufferCGWSEL
        lda #$02
        sta bBufferCGADSUB
        lda #$3C
        sta bBufferBG1SC
        lda bBufferBG12NBA
        and #$F0
        ora #$02
        sta bBufferBG12NBA
        rep #$20
        lda #$0000
        sta $7FE486
        sta $7FE488
        sep #$20
        lda $7FE475
        and #$7F
        ora #$40
        sta $7FE475
        rep #$20
        lda #$0000
        sta $7FE476
        lda wBattleAnimation2X,b
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        and #$00FF
        clc
        adc #$0080
        cmp #$0080
        bcc _A1C0
        cmp #$00C0
        bcs _A1C8
        lda #$00C0
        bra _A1C8


        _A1C0
        cmp #$0040
        bcc _A1C8
        lda #$0040

        _A1C8
        sta $7FE477
        lda #$0000
        sta $7FE479
        lda #$00F0
        sta $7FE47A
        ldx #$0000
        lda #$0000

        _A1E0
        sta $0122,b,x
        inc x
        inc x
        cpx #$003E
        bcc _A1E0
        ldx #$0000

        _A1ED
        lda aUnknownE02315,x
        lsr a
        and #$3DEF
        sta $7FE6DD,x
        lda aUnknownE02315+64,x
        lsr a
        and #$3DEF
        sta $7FE6FD,x
        inc x
        inc x
        cpx #$001E
        bcc _A1ED
        plx
        rtl

        .databank 0

        ; 96/A20E

    .endsection Unreferenced96A0EBSection
