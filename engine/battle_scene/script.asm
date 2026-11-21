; The battle scene's script interpreter. A script is a list of words that
; sequences a battle scene: loading graphics, portraits and backgrounds, palette,
; window, HDMA and scroll effects, shakes, sounds and waits. rlStartBattleSceneScript
; starts one (from the offset table at $97/8F7D) and rlRunBattleSceneScript runs it
; every frame. $FFF8-$FFFF are control commands ($FFFF ends, $FFFE stops for the
; frame); any other word is a command: bits 9-13 pick one of the 25 handlers in
; aBattleSceneCommandHandlers, bits 0-8 are its argument, and bit 14 makes the
; script wait until it has finished. The handlers' data is in bank $97, in tables
; not built yet.

    .section BattleSceneCommand96ABF6Section

      .al
      .xl

      rlBattleSceneCommandWindowEffect1 ; 96/ABF6

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 0: sets up window effect arg from the offset table at $97/A411
        ; (rlBattleSceneStartWindowEffect1).

        phx
        phy
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        asl a
        clc
        adc #$A411
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc #$A411
        sta lR18
        jsl rlBattleSceneStartWindowEffect1
        lda #1,s
        jsr rsBattleSceneScriptNextCommand
        ply
        plx
        rtl

        .databank 0

        ; 96/AC1F

    .endsection BattleSceneCommand96ABF6Section


    .section BattleSceneCommand96BA68Section

      .al
      .xl

      rlBattleSceneCommandLoadBackground ; 96/BA68

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 12: loads part of the battle background for the terrain in $0D44 (bit
        ; 2 of arg clear) or $0D46 (set). Bits 0-1: 0 decompress its graphics, 1
        ; decompress its tilemap, 2 copy its palette to $0162 and $7FFE62. Waits while
        ; other loading is under way.

        phx
        phy
        lda $7FECF4
        and #$00FF
        beq _BA77
        jml _BB09


        _BA77
        tya
        and #$0004
        bne _BA82
        lda $0D44,b
        bra _BA85


        _BA82
        lda $0D46,b

        _BA85
        pha
        tya
        and #$0003
        cmp #$0000
        beq _BA9C
        cmp #$0001
        beq _BABC
        cmp #$0002
        beq _BAE4
        pla
        bra _BB04


        _BA9C
        pla
        clc
        jsl rlGetBattleBackgroundPointers
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        sep #$20
        lda #$03
        sta $7FECF4
        rep #$20
        bra _BB04


        _BABC
        pla
        clc
        jsl rlGetBattleBackgroundPointers
        lda lR19
        sta lR18
        lda lR19+1
        sta lR18+1
        lda #(`aWorldMapMarkerPalette)<<8
        sta lR19+1
        lda #<>aWorldMapMarkerPalette
        sta lR19
        jsl rlAppendDecompList
        sep #$20
        lda #$03
        sta $7FECF4
        rep #$20
        bra _BB04


        _BAE4
        pla
        sec
        jsl rlGetBattleBackgroundPointers
        phx
        ldx #$0000
        ldy #$0000

        _BAF1
        lda [lR20],y
        sta $0162,b,x
        sta $7FFE62,x
        inc y
        inc y
        inc x
        inc x
        cpx #$005E
        bcc _BAF1
        plx

        _BB04
        lda #1,s
        jsr rsBattleSceneScriptNextCommand

        _BB09
        ply
        plx
        rtl

        .databank 0

        ; 96/BB0C

    .endsection BattleSceneCommand96BA68Section


    .section BattleSceneCommand96BB70Section

      .al
      .xl

      rlBattleSceneCommandLoadColors ; 96/BB70

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 14: copies colors into aBGPaletteBuffer from entry arg of the offset
        ; table at $97/AFE5 (first color, count, source).

        phx
        phy
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        asl a
        clc
        adc #$AFE5
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc #$AFE5
        sta lR18
        ldy #$0000
        lda [lR18],y
        and #$00FF
        asl a
        tax
        inc y
        lda [lR18],y
        and #$00FF
        pha
        inc y
        lda [lR18],y
        sta lR19
        inc y
        lda [lR18],y
        sta lR19+1
        pla
        ldy #$0000

        _BBAC
        pha
        lda [lR19],y
        sta aBGPaletteBuffer,b,x
        inc y
        inc y
        inc x
        inc x
        pla
        dec a
        bne _BBAC
        lda #1,s
        jsr rsBattleSceneScriptNextCommand
        ply
        plx
        rtl

        .databank 0

        ; 96/BBC2

    .endsection BattleSceneCommand96BB70Section


    .section BattleSceneCommand96BCAFSection

      .al
      .xl

      rlBattleSceneCommandPlaySoundAtOpponent ; 96/BCAF

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 23: as command 22 for the opponent's position.

        phx
        phy
        tya
        sta wR0
        and #$01FF
        asl a
        tax
        lda aUnknown98AD04,x
        pha
        ldx $0AEB,b
        lda wBattleAnimationX,b,x
        and #$01FF
        sec
        sbc $7FE198
        jsl rlUnknown9EB4BB
        ldx $0AE9,b
        cpx #$0000
        bne _BCDC
        clc
        adc #$2000

        _BCDC
        clc
        adc #1,s
        jsl rlPlaySoundEffect2
        pla
        lda #1,s
        jsr rsBattleSceneScriptNextCommand
        ply
        plx
        rtl

        .databank 0

        ; 96/BCEC

    .endsection BattleSceneCommand96BCAFSection


    .section BattleSceneCommand96CDB7Section

      .al
      .xl

      rlBattleSceneCommandWindowEffect2 ; 96/CDB7

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 18: sets up window effect arg from the offset table at $9A/8000 in one
        ; of two slots (bit 8 of arg).

        phx
        phy
        tya
        bit #$0100
        bne _CDC4
        ldx #$0000
        bra _CDC7


        _CDC4
        ldx #$001C

        _CDC7
        sep #$20
        lda $7FED6E,x
        ora #$01
        sta $7FED6E,x
        rep #$20
        tya
        bit #$0100
        bne _CDE0
        ldx #$0000
        bra _CDE3


        _CDE0
        ldx #$0008

        _CDE3
        lda $7FED5C,x
        bit #$0001
        beq _CDEC

        _CDEC
        lda #$9A00
        sta lR18+1
        tya
        and #$00FF
        asl a
        clc
        adc #$8000
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc #$8000
        sta lR18
        jsl rlBattleSceneStartWindowEffect2
        lda #1,s
        jsr rsBattleSceneScriptNextCommand
        ply
        plx
        rtl


        .databank 0

      rlBattleSceneStartWindowEffect2 ; 96/CE13

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldy #$0000
        sep #$20
        lda [lR18],y
        inc y
        bit #$80
        bne _CE65
        ora $7FED5C,x
        sta $7FED5C,x
        lda [lR18],y
        sta bBufferW12SEL
        sta $2123,b
        inc y
        lda [lR18],y
        sta bBufferW34SEL
        sta $2124,b
        inc y
        lda [lR18],y
        sta bBufferWOBJSEL
        sta $2125,b
        inc y
        lda #$00
        sta bBufferWH0
        lda #$FF
        sta bBufferWH1
        lda #$00
        sta bBufferWH2
        lda #$FF
        sta bBufferWH3
        lda [lR18],y
        sta bBufferWBGLOG
        inc y
        lda [lR18],y
        sta bBufferWBGLOG
        inc y
        lda [lR18],y
        sta bBufferTMW
        inc y
        lda [lR18],y
        sta bBufferTSW
        inc y

        _CE65
        lda lR18+2
        sta $7FED60,x
        rep #$20
        tya
        clc
        adc lR18
        sta $7FED5E,x
        sta $7FED61,x
        jsl rlBattleSceneCreateWindowEffect2HDMA
        ply
        plx
        rtl

        .byte $E2, $20, $A9, $00, $85, $7D, $8D, $23, $21, $85, $7E, $8D, $24, $21, $85, $8F
        .byte $8D, $25, $21, $85, $98, $85, $99, $C2, $20, $60, $C2, $20


        .databank 0

      rlBattleSceneCreateWindowEffect2HDMA ; 96/CE9C

        .al
        .xl
        .autsiz
        .databank ?

        ; X = slot: creates its HDMA entry ($95/E69E as entry 3, or $95/E70E as entry 6).

        phx
        cpx #$0000
        bne _CEB7
        lda #$9500
        sta lR44+1
        lda #$E69E
        sta lR44
        lda #$0003
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        bra _CECA


        _CEB7
        lda #$9500
        sta lR44+1
        lda #$E70E
        sta lR44
        lda #$0006
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex

        _CECA
        plx
        rtl

        .byte $C2, $20

        .databank 0

        ; 96/CECE

    .endsection BattleSceneCommand96CDB7Section


    .section Table96DF60Section

      .al
      .xl

      aUnknown96DF60 ; 96/DF60

        ; Jump table of rlBattleSceneStartBGScrollEffect.
        .word <>rsUnknown96DFC7
        .word <>rsUnknown96E01F
        .word <>rsUnknown96E077
        .word <>rsUnknown96E0CF
        .word <>rsUnknown96E127
        .word <>rsUnknown96E17B
        .word <>rsUnknown96E1D3
        .word <>rsUnknown96E20A
        .word <>rsUnknown96E245
        .word <>rsUnknown96E275
        .word <>rsUnknown96E2CE
        .word <>rsUnknown96E312
        .word <>rsUnknown96E3CA
        .word <>rsUnknown96E3E5
        .word <>rsUnknown96E42D
        .word <>rsUnknown96E356
        .word <>rsUnknown96E38D
        .word <>rsUnknown96E463
        .word <>rsUnknown96E49C
        .word <>rsUnknown96E49D
        .word <>rsUnknown96E50E
        .word <>rsUnknown96E50F
        .word <>rsUnknown96E558
        .word <>rsUnknown96E58E
        .word <>rsUnknown96E4D8
        .word <>rsUnknown96E5DA
        .word <>rsUnknown96E5F6
        .word <>rsUnknown96E612

    .endsection Table96DF60Section


    .section BattleSceneCommand96EC4ASection

      .al
      .xl

      rlBattleSceneCommandShakeBG2 ; 96/EC4A

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 16: arg 0 stops the BG2 shake; otherwise starts shake arg-1.

        tya
        and #$01FF
        cmp #$0000
        bne _EC59
        jsl rlBattleSceneStopBG2Shake
        bra _EC5E


        _EC59
        dec a
        jsl rlBattleSceneStartBG2Shake

        _EC5E
        lda #1,s
        jsr rsBattleSceneScriptNextCommand
        rtl


        .databank 0

      rlBattleSceneStartBG2Shake ; 96/EC64

        .al
        .xl
        .autsiz
        .databank ?

        ; A = shake: starts that sequence from the offset table at $97/C2D4, which
        ; rlUnknown96EBE3 plays (pairs of signed X and Y offsets added to BG2's scroll;
        ; $8080 loops, $8081 stops).

        phx
        asl a
        tax
        lda aUnknown97C2D4,x
        clc
        adc #$C2D4
        sta $7FF631
        sta $7FF634
        sep #$20
        lda #$97
        sta $7FF633
        rep #$20
        sep #$20
        lda $7FF630
        ora #$80
        sta $7FF630
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/EC91

    .endsection BattleSceneCommand96EC4ASection


    .section Table96ECCCSection

      .al
      .xl

      aUnknown96ECCC ; 96/ECCC

        ; Jump table of rlBattleSceneRunPaletteOperation.
        .word <>rsUnknown96ECDC
        .word <>rsUnknown96ED0B
        .word <>rsUnknown96ED23
        .word <>rsUnknown96EDA7
        .word <>rsUnknown96EE32
        .word <>rsUnknown96EE4A
        .word <>rsUnknown96EE5E
        .word <>rsUnknown96EE71

    .endsection Table96ECCCSection


    .section BattleSceneCommand96F1C2Section

      .al
      .xl

      rlBattleSceneCommandWindowEffect3 ; 96/F1C2

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 19: arg $FF stops window effect 3; otherwise sets up effect arg from
        ; the offset table at $97/C828.

        phx
        phy
        tya
        sta wR0
        and #$01FF
        cmp #$00FF
        bne _F1D5
        jsl rlBattleSceneStopWindowEffect3
        bra _F1EA


        _F1D5
        asl a
        tax
        lda #$9700
        sta lR18+1
        lda aUnknown97C828,x
        clc
        adc #$C828
        sta lR18
        jsl rlBattleSceneStartWindowEffect3

        _F1EA
        lda #1,s
        jsr rsBattleSceneScriptNextCommand
        ply
        plx
        rtl


        .databank 0

      rlBattleSceneStartWindowEffect3 ; 96/F1F2

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldy #$0000
        sep #$20
        lda [lR18],y
        inc y
        sta $7FEC67
        lda [lR18],y
        sta bBufferW12SEL
        sta $2123,b
        inc y
        lda [lR18],y
        sta bBufferW34SEL
        sta $2124,b
        inc y
        lda [lR18],y
        sta bBufferWOBJSEL
        sta $2125,b
        inc y
        lda #$00
        sta bBufferWH0
        lda #$FF
        sta bBufferWH1
        lda #$00
        sta bBufferWH2
        lda #$FF
        sta bBufferWH3
        lda [lR18],y
        sta bBufferWBGLOG
        inc y
        lda [lR18],y
        sta bBufferWBGLOG
        inc y
        lda [lR18],y
        sta bBufferTMW
        inc y
        lda [lR18],y
        sta bBufferTSW
        inc y
        lda [lR18],y
        sta $7FEC68
        inc y
        lda [lR18],y
        sta $7FEC69
        inc y
        lda [lR18],y
        sta $7FEC6A
        inc y
        lda [lR18],y
        sta $7FEC6B
        inc y
        rep #$20
        ply
        plx
        rtl


        .databank 0

      rlBattleSceneStopWindowEffect3 ; 96/F25D

        .al
        .xl
        .autsiz
        .databank ?

        ; Frees HDMA entry 6.

        sep #$20
        lda $7FEC67
        and #$7F
        sta $7FEC67
        rep #$20
        lda #$0006
        jsl rlHDMAEngineFreeEntryByIndex
        rtl

        .byte $C2, $20

        .databank 0

        ; 96/F275

    .endsection BattleSceneCommand96F1C2Section


    .section BattleSceneScriptSection

      .al
      .xl

      rlRunBattleSceneScript ; 96/A28B

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame while a script runs: counts down the wait timers ($7FE4BE, and
        ; $7FE4C0, which holding A clears), waits while commands it is waiting for are
        ; unfinished ($7FE4B8), then runs commands until one stops for the frame.
        ; $FFF8-$FFFF are control commands; any other word is a command for
        ; rsBattleSceneScriptRunCommand. Then runs rlBattleSceneScriptRunRoutine.

        phy
        lda $7FE4B7
        bit #$0080
        bne _A299
        jml _A32E


        _A299
        lda wJoy1Input
        cmp #$0080
        bne _A2A7
        lda #$0000
        sta $7FE4C0

        _A2A7
        lda $7FE4BE
        beq _A2B4
        dec a
        sta $7FE4BE
        bra _A32E


        _A2B4
        lda $7FE4C0
        beq _A2C1
        dec a
        sta $7FE4C0
        bra _A32E


        _A2C1
        lda $7FE4B8
        and #$00FF
        bne _A32E
        lda $7FE4BA
        sta lR18+1

        _A2D0
        lda $7FE4BC
        sta lR18
        ldy #$0000
        lda [lR18],y
        cmp #$FFFF
        bne _A2E5
        jsr rsBattleSceneScriptEnd
        bra _A32E


        _A2E5
        cmp #$FFFE
        bne _A2EF
        jsr rsBattleSceneScriptYield
        bra _A32E


        _A2EF
        cmp #$FFFD
        bne _A2F9
        jsr rsUnknown96A359
        bra _A2D0


        _A2F9
        cmp #$FFFC
        bne _A303
        jsr rsUnknown96A36F
        bra _A2D0


        _A303
        cmp #$FFFB
        bne _A30D
        jsr rsUnknown96A3C5
        bra _A2D0


        _A30D
        cmp #$FFF8
        bne _A317
        jsr rsUnknown96A3D8
        bra _A2D0


        _A317
        cmp #$FFFA
        bne _A321
        jsr rsUnknown96A385
        bra _A2D0


        _A321
        cmp #$FFF9
        bne _A32B
        jsr rsUnknown96A396
        bra _A2D0


        _A32B
        jsr rsBattleSceneScriptRunCommand

        _A32E
        jsl rlBattleSceneScriptRunRoutine
        ply
        rtl

        .databank 0

        ; 96/A334

      rsBattleSceneScriptEnd ; 96/A334

        .al
        .xl
        .autsiz
        .databank ?

        ; Control command $FFFF: ends the script.

        sep #$20
        lda $7FE4B7
        and #$7F
        sta $7FE4B7
        rep #$20
        rts

        .databank 0

        ; 96/A343

      rsBattleSceneScriptYield ; 96/A343

        .al
        .xl
        .autsiz
        .databank ?

        ; Control command $FFFE: stops for this frame.

        lda $7FE4B8
        and #$00FF
        bne _A358
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC

        _A358
        rts

        .databank 0

        ; 96/A359

      rsUnknown96A359 ; 96/A359

        .al
        .xl
        .autsiz
        .databank ?

        ; Control command $FFFD: rlUnknown95C057 for the acting combatant ($0AE9; adds 1 to $7FE184 or $7FE185).

        phx
        ldx $0AE9,b
        jsl rlUnknown95C057
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        plx
        rts

        .databank 0

        ; 96/A36F

      rsUnknown96A36F ; 96/A36F

        .al
        .xl
        .autsiz
        .databank ?

        ; Control command $FFFC: rlUnknown95C077, the same for the other counter.

        phx
        ldx $0AE9,b
        jsl rlUnknown95C077
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        plx
        rts

        .databank 0

        ; 96/A385

      rsUnknown96A385 ; 96/A385

        .al
        .xl
        .autsiz
        .databank ?

        ; Control command $FFFA: rlUnknown95AEA2.

        jsl rlUnknown95AEA2
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        rts

        .databank 0

        ; 96/A396

      rsUnknown96A396 ; 96/A396

        .al
        .xl
        .autsiz
        .databank ?

        ; Control command $FFF9: rlUnknown96F9BF, then rlUnknown95AB53 if bit 3 of $0AE4 is set.

        jsl rlUnknown96F9BF
        lda $0AE4,b
        bit #$0008
        beq _A3B8
        phx
        ldx $0AE9,b
        cpx #$0000
        beq _A3B0
        ldx #$0000
        bra _A3B3


        _A3B0
        ldx #$0043

        _A3B3
        jsl rlUnknown95AB53
        plx

        _A3B8
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        rts

        .databank 0

        ; 96/A3C5

      rsUnknown96A3C5 ; 96/A3C5

        .al
        .xl
        .autsiz
        .databank ?

        ; Control command $FFFB: rlUnknown95B006.

        phx
        jsl rlUnknown95B006
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        plx
        rts

        .databank 0

        ; 96/A3D8

      rsUnknown96A3D8 ; 96/A3D8

        .al
        .xl
        .autsiz
        .databank ?

        ; Control command $FFF8: rlUnknown95B02B, unless bit 6 of $0AE0 is set.

        phx
        lda $0AE0,b
        bit #$0040
        bne _A3E5
        jsl rlUnknown95B02B

        _A3E5
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        plx
        rts

        .databank 0

        ; 96/A3F3

      rsBattleSceneScriptRunCommand ; 96/A3F3

        .al
        .xl
        .autsiz
        .databank ?

        ; A = command word: bits 9-13 pick the handler from aBattleSceneCommandHandlers,
        ; bits 0-8 are its argument, and bit 14 makes the script wait until the command
        ; has finished.

        phx
        phy
        pha
        and #$3E00
        xba
        lsr a
        sta wR0
        pla
        tay
        phb
        jsl _A407
        plb
        .databank ?
        bra _A429


        _A407
        lda wR0
        cmp #$0019
        bmi _A410

        _A40E
        bra _A40E


        _A410
        asl a
        adc wR0
        tax
        lda aBattleSceneCommandHandlers,x
        sta lR23
        sep #$20
        lda aBattleSceneCommandHandlers+2,x
        sta lR23+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR23]


        _A429
        ply
        plx
        rts

        .databank 0

      aBattleSceneCommandHandlers ; 96/A42C

        ; By bits 9-13 of a command word: rsBattleSceneScriptRunCommand.

        .long rlBattleSceneCommandWindowEffect1 ; 0
        .long rlBattleSceneCommandDecompressToVRAM ; 1
        .long rlBattleSceneCommandWriteRAM ; 2
        .long rlBattleSceneCommandHDMAEffect ; 3
        .long rlBattleSceneCommandCallRoutine ; 4
        .long rlBattleSceneCommandCallRoutineUntilDone ; 5
        .long rlBattleSceneCommandDecompress ; 6
        .long rlBattleSceneCommandCopyToVRAM ; 7
        .long rlBattleSceneCommandSetRoutine ; 8
        .long rlBattleSceneCommandLoadPortrait ; 9
        .long rlBattleSceneCommandWait ; 10
        .long rlBattleSceneCommandPaletteEffect ; 11
        .long rlBattleSceneCommandLoadBackground ; 12
        .long rlBattleSceneCommandBGScrollEffect ; 13
        .long rlBattleSceneCommandLoadColors ; 14
        .long rlBattleSceneCommandScrollToCombatant ; 15
        .long rlBattleSceneCommandShakeBG2 ; 16
        .long rlBattleSceneCommandPaletteOperation ; 17
        .long rlBattleSceneCommandWindowEffect2 ; 18
        .long rlBattleSceneCommandWindowEffect3 ; 19
        .long rlBattleSceneCommandDecompressToVRAMAlt ; 20
        .long rlBattleSceneCommandPlaySound ; 21
        .long rlBattleSceneCommandPlaySoundAtCombatant ; 22
        .long rlBattleSceneCommandPlaySoundAtOpponent ; 23
        .long rlBattleSceneCommandSkippableWait ; 24


      rsBattleSceneScriptNextCommand ; 96/A477

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves on to the next word; if the command (A) has bit 14 set, the script waits
        ; for it ($7FE4B8 + 1). A handler that does not call this or
        ; rsBattleSceneScriptNextCommandNoWait runs again next frame.

        pha
        and #$C000
        cmp #$4000
        bne _A48D
        sep #$20
        lda $7FE4B8
        inc a
        sta $7FE4B8
        rep #$20

        _A48D
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        pla
        rts

        .databank 0

        ; 96/A49B

      rsBattleSceneScriptNextCommandNoWait ; 96/A49B

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves on to the next word without waiting.

        pha
        and #$C000
        cmp #$4000
        bne _A4A4

        _A4A4
        lda $7FE4BC
        clc
        adc #$0002
        sta $7FE4BC
        pla
        rts

        .databank 0

        ; 96/A4B2

    .endsection BattleSceneScriptSection


    .section Unsorted96A4B2Section

      .al
      .xl

      rlStartBattleSceneScript ; 96/A4B2

        .al
        .xl
        .autsiz
        .databank ?

        ; A = script ID: starts that script from the offset table at $97/8F7D, unless
        ; one is running (bit 7 of $7FE4B7). Text for it (quotes, item names) is passed
        ; in $7FE4D6 and aDialogue.

        phy
        pha
        lda $7FE4B7
        bit #$0080
        bne _A4F9
        sep #$20
        lda $7FE4B7
        ora #$80
        sta $7FE4B7
        lda #$00
        sta $7FE4B8
        rep #$20
        pla
        asl a
        pha
        lda #$9700
        sta $7FE4BA
        sta lR18+1
        lda #$8F7D
        clc
        adc #1,s
        sta lR18
        pla
        ldy #$0000
        lda [lR18],y
        clc
        adc #$8F7D
        sta $7FE4B9
        sta $7FE4BC
        bra _A4FA


        _A4F9
        pla

        _A4FA
        ply
        rtl

        .databank 0

        ; 96/A4FC

    .endsection Unsorted96A4B2Section


    .section Unsorted96AC1FSection

      .al
      .xl

      rlBattleSceneStartWindowEffect1 ; 96/AC1F

        .al
        .xl
        .autsiz
        .databank ?

        ; lR18 = data: sets the window registers and starts one of two window effects
        ; ($7FEC1D, picked by bit 6 of the first byte).

        phx
        phy
        ldy #$0000
        sep #$20
        lda [lR18],y
        inc y
        bit #$40
        bne _AC32
        ldx #$0000
        bra _AC35


        _AC32
        ldx #$0024

        _AC35
        bit #$80
        beq _AC45
        ora #$80
        ora $7FEC1D,x
        sta $7FEC1D,x
        bra _AC8D


        _AC45
        ora #$80
        sta $7FEC1D,x
        lda [lR18],y
        ora bBufferW12SEL
        sta bBufferW12SEL
        sta $2123,b
        inc y
        lda [lR18],y
        ora bBufferW34SEL
        sta bBufferW34SEL
        sta $2124,b
        inc y
        lda [lR18],y
        ora bBufferWOBJSEL
        sta bBufferWOBJSEL
        sta $2125,b
        inc y
        lda #$00
        sta bBufferWH0
        lda #$FF
        sta bBufferWH1
        lda #$00
        sta bBufferWH2
        lda #$FF
        sta bBufferWH3
        lda [lR18],y
        sta bBufferWBGLOG
        inc y
        lda [lR18],y
        sta bBufferWBGLOG
        inc y
        lda [lR18],y
        sta bBufferTMW
        inc y
        lda [lR18],y
        sta bBufferTSW
        inc y

        _AC8D
        lda lR18+2
        sta aUnit2DataBuffer._ROM.ResistanceGrowth,x
        rep #$20
        tya
        clc
        adc lR18
        sta aUnit2DataBuffer._ROM.DefenseGrowth,x
        sta $7FEC29,x
        jsl rlUnknown96AD39
        jsr rsUnknown96AD07
        ply
        plx
        rtl

        .databank 0

        ; 96/ACAB

    .endsection Unsorted96AC1FSection


    .section Unsorted96B945Section

      .al
      .xl

      rlBattleSceneCommandDecompressToVRAM ; 96/B945

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 1: decompresses entry arg of the 10-byte table at $97/B081, then
        ; copies it to VRAM (rlBattleSceneScriptUpdateLoading). Waits while other
        ; loading is under way.

        phx
        phy
        lda $7FECF4
        and #$00FF
        bne _B9A1
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        asl a
        pha
        asl a
        asl a
        clc
        adc #1,s
        clc
        adc #$B081
        sta lR18
        pla
        ldy #$0000
        ldx #$0000

        _B96D
        lda [lR18],y
        sta $7FECF5,x
        inc y
        inc y
        inc x
        inc x
        cpx #$000A
        bne _B96D
        lda $7FECF5
        sta lR18
        lda $7FECF7
        sta lR18+2
        lda $7FECF9
        sta lR19+1
        jsl rlAppendDecompList
        sep #$20
        lda #$01
        sta $7FECF4
        rep #$20
        pla
        pha
        jsr rsBattleSceneScriptNextCommand

        _B9A1
        ply
        plx
        rtl

        .databank 0

        ; 96/B9A4

      rlBattleSceneCommandDecompressToVRAMAlt ; 96/B9A4

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 20: command 1 with entry arg+1 instead when bit 15 of the acting
        ; combatant's $0B24 is set.

        phx
        ldx $0AE9,b
        lda $0B24,b,x
        bit #$8000
        beq _B9B1
        inc y

        _B9B1
        jsl rlBattleSceneCommandDecompressToVRAM
        plx
        rtl

        .databank 0

        ; 96/B9B7

      rlBattleSceneCommandDecompress ; 96/B9B7

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 6: decompresses entry arg of the 6-byte table at $97/B5D1. Waits while
        ; other loading is under way.

        phx
        phy
        lda $7FECF4
        and #$00FF
        bne _BA12
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        asl a
        pha
        asl a
        clc
        adc #1,s
        clc
        adc #$B5D1
        sta lR18
        pla
        ldy #$0000
        ldx #$0000

        _B9DE
        lda [lR18],y
        sta $7FECF5,x
        inc y
        inc y
        inc x
        inc x
        cpx #$0006
        bne _B9DE
        lda $7FECF5
        sta lR18
        lda $7FECF7
        sta lR18+2
        lda $7FECF9
        sta lR19+1
        jsl rlAppendDecompList
        sep #$20
        lda #$03
        sta $7FECF4
        rep #$20
        pla
        pha
        jsr rsBattleSceneScriptNextCommand

        _BA12
        ply
        plx
        rtl

        .databank 0

        ; 96/BA15

      rlBattleSceneCommandLoadPortrait ; 96/BA15

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 9: decompresses a portrait. Bit 1 of arg: the speaker of the text in
        ; $7FE4D6; otherwise bit 0 picks the character in $0D50 or $0D5E. Waits while
        ; other loading is under way.

        phx
        phy
        lda $7FECF4
        and #$00FF
        bne _BA65
        tya
        and #$0002
        beq _BA37
        lda $7FE4D6
        sta lR18
        lda $7FE4D7
        sta lR18+1
        jsr rsUnknown96F7A8
        bra _BA44


        _BA37
        and #$0001
        bne _BA41
        lda $0D50,b
        bra _BA44


        _BA41
        lda $0D5E,b

        _BA44
        jsl rlGetCharacterPortraitData
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        sep #$20
        lda #$03
        sta $7FECF4
        rep #$20
        pla
        pha
        jsr rsBattleSceneScriptNextCommand

        _BA65
        ply
        plx
        rtl

        .databank 0

        ; 96/BA68

    .endsection Unsorted96B945Section


    .section Unsorted96BB0CSection

      .al
      .xl

      rlBattleSceneCommandCopyToVRAM ; 96/BB0C

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 7: copies entry arg of the 7-byte table at $97/B60D to VRAM
        ; (rlUnknown95C4E3). Waits while other loading is under way.

        phx
        phy
        lda $7FECF4
        and #$00FF
        bne _BB6D
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        pha
        asl a
        asl a
        asl a
        sec
        sbc #1,s
        clc
        adc #$B60D
        sta lR18
        pla
        ldy #$0000
        ldx #$0000
        sep #$20

        _BB36
        lda [lR18],y
        sta $7FECF8,x
        inc y
        inc x
        cpx #$0007
        bne _BB36
        rep #$20
        lda $7FECF9
        sta lR18+1
        lda $7FECF8
        sta lR18
        lda $7FECFB
        tay
        lda $7FECFD
        jsl rlUnknown95C4E3
        sep #$20
        lda #$02
        sta $7FECF4
        rep #$20
        pla
        pha
        jsr rsBattleSceneScriptNextCommand

        _BB6D
        ply
        plx
        rtl

        .databank 0

        ; 96/BB70

    .endsection Unsorted96BB0CSection


    .section Unsorted96BBC2Section

      .al
      .xl

      rlBattleSceneCommandWait ; 96/BBC2

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 10: waits arg frames.

        phy
        tya
        and #$01FF
        sta $7FE4BE
        pla
        pha
        jsr rsBattleSceneScriptNextCommandNoWait
        ply
        rtl

        .databank 0

        ; 96/BBD2

      rlBattleSceneCommandSkippableWait ; 96/BBD2

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 24: waits arg frames; holding A ends the wait.

        phy
        tya
        and #$01FF
        sta $7FE4C0
        pla
        pha
        jsr rsBattleSceneScriptNextCommandNoWait
        ply
        rtl

        .databank 0

        ; 96/BBE2

    .endsection Unsorted96BBC2Section


    .section Unsorted96BBE2Section

      .al
      .xl

      rlBattleSceneScriptUpdateLoading ; 96/BBE2

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: moves the graphics loading started by commands 1, 6, 7, 9 and 12
        ; along ($7FECF4: 1 decompress then copy to VRAM, 2 copy to VRAM, 3 decompress).
        ; When it finishes, the script stops waiting for it.

        phx
        phy
        lda $7FECF4
        and #$00FF
        beq _BC49
        cmp #$0003
        bne _BBFC
        lda bDecompressionArrayFlag,b
        and #$00FF
        bne _BC49
        bra _BC34


        _BBFC
        cmp #$0001
        bne _BC2E
        lda bDecompressionArrayFlag,b
        and #$00FF
        bne _BC49
        lda $7FECF9
        sta lR18+1
        lda $7FECF8
        sta lR18
        lda $7FECFB
        tay
        lda $7FECFD
        jsl rlUnknown95C4E3
        sep #$20
        lda #$02
        sta $7FECF4
        rep #$20
        bra _BC49


        _BC2E
        lda $7FE18A
        bne _BC49

        _BC34
        sep #$20
        lda #$00
        sta $7FECF4
        lda $7FE4B8
        beq _BC47
        dec a
        sta $7FE4B8

        _BC47
        rep #$20

        _BC49
        ply
        plx
        rtl

        .databank 0

        ; 96/BC4C

    .endsection Unsorted96BBE2Section


    .section Unsorted96BC4CSection

      .al
      .xl

      rlBattleSceneCommandPlaySound ; 96/BC4C

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 21: plays sound effect arg from the table at $98/AD04
        ; (rlPlaySoundEffect2), adding $2000 when the acting combatant is the first
        ; ($0AE9 = 0).

        phx
        phy
        tya
        sta wR0
        and #$01FF
        asl a
        tax
        lda aUnknown98AD04,x
        ldx $0AE9,b
        cpx #$0000
        bne _BC66
        clc
        adc #$2000

        _BC66
        jsl rlPlaySoundEffect2
        lda #1,s
        jsr rsBattleSceneScriptNextCommand
        ply
        plx
        rtl

        .databank 0

        ; 96/BC72

      rlBattleSceneCommandPlaySoundAtCombatant ; 96/BC72

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 22: as command 21, adding a value worked out (rlUnknown9EB4BB) from
        ; the acting combatant's position on screen.

        phx
        phy
        tya
        sta wR0
        and #$01FF
        asl a
        tax
        lda aUnknown98AD04,x
        pha
        ldx $0AE9,b
        lda wBattleAnimationX,b,x
        and #$01FF
        sec
        sbc $7FE198
        jsl rlUnknown9EB4BB
        ldx $0AE9,b
        cpx #$0000
        bne _BC9F
        clc
        adc #$2000

        _BC9F
        clc
        adc #1,s
        jsl rlPlaySoundEffect2
        pla
        lda #1,s
        jsr rsBattleSceneScriptNextCommand
        ply
        plx
        rtl

        .databank 0

        ; 96/BCAF

    .endsection Unsorted96BC4CSection


    .section Unsorted96BCF1Section

      .al
      .xl

      rlBattleSceneCommandWriteRAM ; 96/BCF1

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 2: runs the RAM writes in entry arg of the offset table at $97/B67D
        ; (rlBattleSceneWriteRAM).

        phx
        phy
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        asl a
        clc
        adc #$B67D
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc #$B67D
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #1,s
        jsr rsBattleSceneScriptNextCommand
        ply
        plx
        rtl

        .databank 0

        ; 96/BD1A

    .endsection Unsorted96BCF1Section


    .section Unsorted96BD1ASection

      .al
      .xl

      rlBattleSceneWriteRAM ; 96/BD1A

        .al
        .xl
        .autsiz
        .databank ?

        ; lR18 = list: each entry is a word (bits 14-15 type, the rest an address below
        ; $4000) and a value. Types: $0000 write a byte, $4000 write a word, $8000 AND
        ; then OR a byte. $FFFF ends the list.

        phx
        phy
        ldy #$0000

        _BD1F
        lda [lR18],y
        cmp #$FFFF
        beq _BD71
        inc y
        inc y
        pha
        and #$3FFF
        tax
        pla
        and #$C000
        cmp #$0000
        bne _BD41
        sep #$20
        lda [lR18],y
        sta wR0,x
        rep #$20
        inc y
        bra _BD1F


        _BD41
        cmp #$4000
        bne _BD4E
        lda [lR18],y
        sta wR0,x
        inc y
        inc y
        bra _BD1F


        _BD4E
        cmp #$8000
        bne _BD63
        sep #$20
        lda wR0,x
        and [lR18],y
        inc y
        ora [lR18],y
        sta wR0,x
        rep #$20
        inc y
        bra _BD1F


        _BD63
        lda wR0,x
        and [lR18],y
        inc y
        inc y
        ora [lR18],y
        sta wR0,x
        inc y
        inc y
        bra _BD1F


        _BD71
        ply
        plx
        rtl

        .databank 0

        ; 96/BD74

    .endsection Unsorted96BD1ASection


    .section Unsorted96C9ADSection

      .al
      .xl

      rlBattleSceneScriptRunRoutine ; 96/C9AD

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: runs the routine command 8 set ($7FECFF), unless it is $FFFFFF.

        phx
        phy
        lda $7FECFF
        cmp #$FFFF
        bne _C9C1
        lda $7FED00
        cmp #$FFFF
        beq _C9D6

        _C9C1
        lda $7FECFF
        sta lR18
        lda $7FED00
        sta lR18+1
        jsl _C9D3
        bra _C9D6


        _C9D3
        jml [lR18]


        _C9D6
        ply
        plx
        rtl

        .databank 0

        ; 96/C9D9

    .endsection Unsorted96C9ADSection


    .section Unsorted96DB58Section

      .al
      .xl

      rlBattleSceneCommandPaletteEffect ; 96/DB58

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 11: starts palette effect arg from the offset table at $97/A9A8
        ; (rlBattleSceneStartPaletteEffect).

        phx
        phy
        tya
        and #$C000
        cmp #$4000
        bne _DB68
        lda #$0001
        bra _DB6B


        _DB68
        lda #$0000

        _DB6B
        sta wR0
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        asl a
        clc
        adc #$A9A8
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc #$A9A8
        sta lR18
        jsl rlBattleSceneStartPaletteEffect
        lda #1,s
        jsr rsBattleSceneScriptNextCommand
        ply
        plx
        rtl

        .databank 0

        ; 96/DB94

    .endsection Unsorted96DB58Section


    .section Unsorted96DB94Section

      .al
      .xl

      rlBattleSceneStartPaletteEffect ; 96/DB94

        .al
        .xl
        .autsiz
        .databank ?

        ; lR18 = data, wR0 = 1 to wait for it: fills one of ten palette effect slots
        ; ($7FFD9A, 10 bytes each; 13 types run by rlUnknown96D695, which change
        ; aBGPaletteBuffer).

        phx
        phy
        ldy #$0000
        lda [lR18],y
        inc y
        and #$00FF
        sta wR10
        lda #$000A
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        sep #$20
        lda [lR18],y
        and #$3F
        pha
        inc y
        sta $7FFD9A,x
        lda wR0
        beq _DBC6
        lda $7FFD9A,x
        ora #$40
        sta $7FFD9A,x

        _DBC6
        lda [lR18],y
        inc y
        sta $7FFDA0,x
        lda [lR18],y
        inc y
        sta $7FFDA1,x
        lda #$00
        sta $7FFDA3,x
        sta $7FFDA2,x
        pla
        cmp #$00
        beq _DC1B
        cmp #$01
        beq _DC1B
        cmp #$02
        beq _DC1B
        cmp #$03
        beq _DC3A
        cmp #$04
        beq _DC3A
        cmp #$05
        beq _DC3A
        cmp #$06
        beq _DC3A
        cmp #$07
        beq _DC42
        cmp #$08
        beq _DC60
        cmp #$09
        beq _DC60
        cmp #$0A
        beq _DC62
        cmp #$0B
        beq _DC60
        cmp #$0C
        beq _DC1B
        lda #$80
        sta $7FFD9A,x
        bra _DC77


        _DC1B
        lda [lR18],y
        inc y
        sta $7FFD9B,x
        sta $7FFD9E,x
        lda [lR18],y
        inc y
        sta $7FFD9C,x
        sta $7FFD9F,x
        lda [lR18],y
        inc y
        sta $7FFD9D,x
        bra _DC77


        _DC3A
        lda [lR18],y
        sta $7FFDA2,x
        bra _DC77


        _DC42
        lda [lR18],y
        inc y
        sta $7FFDA2,x
        lda [lR18],y
        inc y
        sta $7FFD9B,x
        lda [lR18],y
        inc y
        sta $7FFD9C,x
        lda [lR18],y
        inc y
        sta $7FFD9D,x
        bra _DC77


        _DC60
        bra _DC77


        _DC62
        lda [lR18],y
        inc y
        sta $7FFD9B,x
        lda [lR18],y
        inc y
        sta $7FFD9C,x
        lda [lR18],y
        inc y
        sta $7FFD9D,x

        _DC77
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 96/DC7C

    .endsection Unsorted96DB94Section


    .section Unsorted96DEC0Section

      .al
      .xl

      rlBattleSceneCommandBGScrollEffect ; 96/DEC0

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 13: starts background scroll effect arg from the offset table at
        ; $97/BEAC (rlBattleSceneStartBGScrollEffect).

        phx
        phy
        tya
        sta wR0
        and #$01FF
        asl a
        tax
        lda #$9700
        sta lR18+1
        lda aUnknown97BEAC,x
        clc
        adc #$BEAC
        sta lR18
        jsl rlBattleSceneStartBGScrollEffect
        lda #1,s
        jsr rsBattleSceneScriptNextCommand
        ply
        plx
        rtl

        .databank 0

        ; 96/DEE5

      rlBattleSceneStartBGScrollEffect ; 96/DEE5

        .al
        .xl
        .autsiz
        .databank ?

        ; lR18 = data: fills one of three slots ($7FE475, picked by the low two bits of
        ; the first byte); rlUnknown96DD6E applies them to the BG1-BG3 scroll registers.

        phx
        phy
        ldy #$0000
        lda [lR18],y
        inc y
        and #$0003
        cmp #$0003
        bcs _DF5C
        sta wR10
        lda #$0015
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        sep #$20
        lda $7FE475,x
        ora #$80
        sta $7FE475,x
        rep #$20
        lda wR0
        and #$C000
        cmp #$4000
        bne _DF24
        sep #$20
        lda $7FE475,x
        ora #$20
        bra _DF2C


        _DF24
        .al
        sep #$20
        lda $7FE475,x
        and #$DF

        _DF2C
        sta $7FE475,x
        rep #$20
        lda [lR18],y
        and #$00FF
        sta wR0
        sep #$20
        lda $7FE475,x
        and #$E0
        ora wR0
        sta $7FE475,x
        rep #$20
        txy
        phx
        phb
        php
        phk
        plb
        .databank $96
        lda wR0
        asl a
        tax
        jsr (aUnknown96DF60,x)
        plp
        plb
        .databank $96
        plx
        clc
        bra _DF5D


        _DF5C
        sec

        _DF5D
        ply
        plx
        rtl

        .databank 0

        ; 96/DF60

    .endsection Unsorted96DEC0Section


    .section Unsorted96EC91Section

      .al
      .xl

      rlBattleSceneStopBG2Shake ; 96/EC91

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FF630
        and #$7F
        sta $7FF630
        rep #$20
        lda #$0000
        sta $7FE19F
        sta $7FE1A1
        rtl

        .databank 0

        ; 96/ECAB

    .endsection Unsorted96EC91Section


    .section Unsorted96ECABSection

      .al
      .xl

      rlBattleSceneCommandPaletteOperation ; 96/ECAB

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 17: runs palette operation arg (rlBattleSceneRunPaletteOperation).

        phy
        tya
        and #$01FF
        jsl rlBattleSceneRunPaletteOperation
        lda #1,s
        jsr rsBattleSceneScriptNextCommand
        ply
        rtl

        .databank 0

        ; 96/ECBB

      rlBattleSceneRunPaletteOperation ; 96/ECBB

        .al
        .xl
        .autsiz
        .databank ?

        ; A = operation, from the table after this routine (8): each builds a changed
        ; copy of the background palette in $7FF636, such as halved or set to $7C00.

        phx
        phy
        and #$00FF
        sta wR0
        lda wR0
        asl a
        tax
        jsr (aUnknown96ECCC,x)
        ply
        plx
        rtl

        .databank 0

        ; 96/ECCC

    .endsection Unsorted96ECABSection


    .section Data97C828Section

      .al
      .xl

      aUnknown97C828 ; 97/C828

        ; Read by rlBattleSceneCommandWindowEffect3.

        .word $0008, $0014, $0020, $002C, $8083, $000C, $0000, $0006
        .word $1818, $1820, $0081, $000C, $0000, $0004, $3F40, $3F40
        .word $0082, $000C, $0000, $0004, $0F10, $0064, $0082, $000C
        .word $0000, $0004, $1314, $0864

        ; 97/C860

    .endsection Data97C828Section


    .section Data98AD04Section

      .al
      .xl

      aUnknown98AD04 ; 98/AD04

        ; Read by rlBattleSceneCommandPlaySound, rlBattleSceneCommandPlaySoundAtCombatant, rlBattleSceneCommandPlaySoundAtOpponent.

        .byte $35, $00, $61, $00, $35, $00, $62, $00, $37, $00, $66, $00, $60, $00, $59, $00
        .byte $5A, $00, $56, $00, $57, $00, $56, $00, $58, $00, $31, $00, $5B, $00, $32, $00
        .byte $33, $00, $5C, $00, $52, $00, $53, $00, $54, $00, $55, $00, $63, $00, $5E, $00
        .byte $64, $00, $51, $00, $34, $00, $5F, $00, $5D, $00, $67, $00, $65, $00, $68, $00
        .byte $69, $00, $03, $00, $71, $00, $73, $00, $75, $00, $77, $00, $79, $00, $7B, $00
        .byte $7C, $00, $7D, $00, $80, $00, $7F, $00, $81, $00, $82, $00, $7E, $00, $7A, $00
        .byte $02

        ; 98/AD65

    .endsection Data98AD04Section
