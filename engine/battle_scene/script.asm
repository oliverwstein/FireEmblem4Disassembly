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
        lda wBattleSceneAttackerTerrain,b
        bra _BA85


        _BA82
        lda wBattleSceneDefenderTerrain,b

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
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        jsl rlGetSoundPanFromXPixel
        ldx wBattleAnimationAttackerOffset,b
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
        lda #(`aUnknown95E69E)<<8
        sta lR44+1
        lda #<>aUnknown95E69E
        sta lR44
        lda #$0003
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        bra _CECA


        _CEB7
        lda #(`aUnknown95E70E)<<8
        sta lR44+1
        lda #<>aUnknown95E70E
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
        ldx wBattleAnimationAttackerOffset,b
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
        ldx wBattleAnimationAttackerOffset,b
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

        ; Control command $FFFA: rlBattleSceneApplyStrike.

        jsl rlBattleSceneApplyStrike
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
        lda bBattleSceneStrikeFlags,b
        bit #$0008
        beq _A3B8
        phx
        ldx wBattleAnimationAttackerOffset,b
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

        ; Control command $FFFB: rlBattleSceneStartHeal.

        phx
        jsl rlBattleSceneStartHeal
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

        ; Control command $FFF8: rlBattleSceneStartDrain, unless bit 6 of $0AE0 is set.

        phx
        lda bBattleSceneRoundState,b
        bit #BattleSceneRoundMissed
        bne _A3E5
        jsl rlBattleSceneStartDrain

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
        lda #(`aBattleSceneDecompressToVRAMTable)<<8
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
        adc #<>aBattleSceneDecompressToVRAMTable
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
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationBaseTile,b,x
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
        lda #(`aBattleSceneDecompressTable)<<8
        sta lR18+1
        tya
        and #$01FF
        asl a
        pha
        asl a
        clc
        adc #1,s
        clc
        adc #<>aBattleSceneDecompressTable
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
        lda lBattleSceneDialoguePointer
        sta lR18
        lda lBattleSceneDialoguePointer+1
        sta lR18+1
        jsr rsUnknown96F7A8
        bra _BA44


        _BA37
        and #$0001
        bne _BA41
        lda aBattleSceneCombatant1.Character,b
        bra _BA44


        _BA41
        lda aBattleSceneCombatant2.Character,b

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
        lda #(`aBattleSceneCopyToVRAMTable)<<8
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
        adc #<>aBattleSceneCopyToVRAMTable
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
        ldx wBattleAnimationAttackerOffset,b
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

        ; Command 22: as command 21, adding a value worked out (rlGetSoundPanFromXPixel) from
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
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationX,b,x
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        jsl rlGetSoundPanFromXPixel
        ldx wBattleAnimationAttackerOffset,b
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

        ; Command 11: starts palette effect arg from the offset table aBattleScenePaletteEffects
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
        lda #(`aBattleScenePaletteEffects)<<8
        sta lR18+1
        tya
        and #$01FF
        asl a
        clc
        adc #<>aBattleScenePaletteEffects
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc #<>aBattleScenePaletteEffects
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


    .section Data978F3ASection

      .al
      .xl

      aUnknown978F3A ; 97/8F3A

        ; Read by rlUnknown95B993 (67 bytes).

        .byte $80, $00, $00, $00, $00, $00, $00, $00, $00, $64, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $7F, $00, $00, $00, $00, $40, $00, $00, $00, $00
        .byte $00, $00, $00

      aUnknown978F7D ; 97/8F7D

        ; Offset table starting at $97/8F7D (77 entries).

        .word _8F7D_904F - aUnknown978F7D
        .word _8F7D_9061 - aUnknown978F7D
        .word _8F7D_909D - aUnknown978F7D
        .word _8F7D_9631 - aUnknown978F7D
        .word _8F7D_92AD - aUnknown978F7D
        .word _8F7D_967F - aUnknown978F7D
        .word _8F7D_931B - aUnknown978F7D
        .word _8F7D_9715 - aUnknown978F7D
        .word _8F7D_977B - aUnknown978F7D
        .word _8F7D_97DF - aUnknown978F7D
        .word _8F7D_986B - aUnknown978F7D
        .word _8F7D_98DB - aUnknown978F7D
        .word _8F7D_995F - aUnknown978F7D
        .word _8F7D_9999 - aUnknown978F7D
        .word _8F7D_99CF - aUnknown978F7D
        .word _8F7D_9A13 - aUnknown978F7D
        .word _8F7D_9A7B - aUnknown978F7D
        .word _8F7D_9AEF - aUnknown978F7D
        .word _8F7D_9B4B - aUnknown978F7D
        .word _8F7D_9107 - aUnknown978F7D
        .word _8F7D_9BD3 - aUnknown978F7D
        .word _8F7D_9C69 - aUnknown978F7D
        .word _8F7D_9CC3 - aUnknown978F7D
        .word _8F7D_9D65 - aUnknown978F7D
        .word _8F7D_9DFD - aUnknown978F7D
        .word _8F7D_9017 - aUnknown978F7D
        .word _8F7D_91CF - aUnknown978F7D
        .word _8F7D_9207 - aUnknown978F7D
        .word _8F7D_9173 - aUnknown978F7D
        .word _8F7D_926F - aUnknown978F7D
        .word _8F7D_93AD - aUnknown978F7D
        .word _8F7D_93E3 - aUnknown978F7D
        .word _8F7D_9421 - aUnknown978F7D
        .word _8F7D_9465 - aUnknown978F7D
        .word _8F7D_94A7 - aUnknown978F7D
        .word _8F7D_94EB - aUnknown978F7D
        .word _8F7D_9567 - aUnknown978F7D
        .word _8F7D_95CF - aUnknown978F7D
        .word _8F7D_923F - aUnknown978F7D
        .word _8F7D_9611 - aUnknown978F7D
        .word _8F7D_9E97 - aUnknown978F7D
        .word _8F7D_9EBD - aUnknown978F7D
        .word _8F7D_9EDF - aUnknown978F7D
        .word _8F7D_9F0D - aUnknown978F7D
        .word _8F7D_9F37 - aUnknown978F7D
        .word _8F7D_9F3F - aUnknown978F7D
        .word _8F7D_9F93 - aUnknown978F7D
        .word _8F7D_9FE7 - aUnknown978F7D
        .word _8F7D_9FEF - aUnknown978F7D
        .word _8F7D_9FF7 - aUnknown978F7D
        .word _8F7D_A00B - aUnknown978F7D
        .word _8F7D_A011 - aUnknown978F7D
        .word _8F7D_A0AF - aUnknown978F7D
        .word _8F7D_A0B3 - aUnknown978F7D
        .word _8F7D_A0E1 - aUnknown978F7D
        .word _8F7D_A0E9 - aUnknown978F7D
        .word _8F7D_A0F1 - aUnknown978F7D
        .word _8F7D_A0F9 - aUnknown978F7D
        .word _8F7D_A0FF - aUnknown978F7D
        .word _8F7D_A105 - aUnknown978F7D
        .word _8F7D_A10B - aUnknown978F7D
        .word _8F7D_A153 - aUnknown978F7D
        .word _8F7D_A159 - aUnknown978F7D
        .word _8F7D_A17F - aUnknown978F7D
        .word _8F7D_A185 - aUnknown978F7D
        .word _8F7D_A199 - aUnknown978F7D
        .word _8F7D_A1BD - aUnknown978F7D
        .word _8F7D_A1EF - aUnknown978F7D
        .word _8F7D_A1FD - aUnknown978F7D
        .word _8F7D_A205 - aUnknown978F7D
        .word _8F7D_A243 - aUnknown978F7D
        .word _8F7D_A2A9 - aUnknown978F7D
        .word _8F7D_A2F5 - aUnknown978F7D
        .word _8F7D_A359 - aUnknown978F7D
        .word _8F7D_A3AB - aUnknown978F7D
        .word _8F7D_A3DB - aUnknown978F7D
        .word _8F7D_A3F1 - aUnknown978F7D

      _8F7D_9017 ; 97/9017
        .byte $3B, $08, $01, $42, $FE, $FF, $02, $42, $FE, $FF, $00, $1A, $06, $56, $FE, $FF
        .byte $22, $2A, $00, $04, $02, $56, $FE, $FF, $03, $56, $FD, $FF, $FE, $FF, $01, $04
        .byte $01, $54, $FE, $FF, $01, $1A, $04, $56, $FE, $FF, $FB, $FF, $05, $56, $FE, $FF
        .byte $FD, $FF, $02, $04, $36, $08, $FF, $FF

      _8F7D_904F ; 97/904F
        .byte $00, $42, $FE, $FF, $0D, $08, $00, $50, $FE, $FF, $01, $50, $FE, $FF, $50, $70
        .byte $FF, $FF

      _8F7D_9061 ; 97/9061
        .byte $43, $08, $1E, $54, $FE, $FF, $3D, $08, $14, $54, $FE, $FF, $10, $50, $FE, $FF
        .byte $1E, $54, $FE, $FF, $03, $10, $00, $12, $00, $0C, $01, $0C, $02, $0C, $03, $4C
        .byte $FE, $FF, $02, $08, $05, $08, $01, $0E, $02, $0E, $00, $0E, $03, $0E, $04, $4E
        .byte $FE, $FF, $07, $4A, $0E, $50, $FE, $FF, $78, $70, $FF, $FF

      _8F7D_909D ; 97/909D
        .byte $3B, $08, $24, $42, $FE, $FF, $26, $68, $FE, $FF, $17, $1A, $0A, $46, $FE, $FF
        .byte $00, $2C, $1E, $04, $A1, $16, $0B, $46, $FE, $FF, $FD, $FF, $F9, $FF, $01, $2A
        .byte $03, $1E, $12, $5A, $FE, $FF, $FA, $FF, $48, $5A, $FE, $FF, $FD, $FF, $FC, $FF
        .byte $1F, $04, $36, $08, $FF, $FF, $3B, $08, $01, $42, $FE, $FF, $02, $42, $FE, $FF
        .byte $06, $56, $FE, $FF, $00, $04, $FE, $FF, $FE, $FF, $02, $56, $FE, $FF, $03, $56
        .byte $FE, $FF, $FD, $FF, $01, $04, $FE, $FF, $04, $56, $FE, $FF, $FB, $FF, $05, $56
        .byte $FE, $FF, $FD, $FF, $02, $04, $36, $08, $FF, $FF

      _8F7D_9107 ; 97/9107
        .byte $3B, $08, $0A, $42, $FE, $FF, $09, $42, $FE, $FF, $09, $5E, $FE, $FF, $07, $56
        .byte $FE, $FF, $05, $04, $10, $00, $2A, $08, $0B, $42, $FE, $FF, $07, $1C, $11, $1A
        .byte $0F, $08, $01, $54, $FE, $FF, $5B, $04, $49, $56, $FE, $FF, $1C, $2E, $08, $06
        .byte $4A, $16, $36, $1A, $50, $54, $FE, $FF, $FD, $FF, $F9, $FF, $10, $54, $FE, $FF
        .byte $FA, $FF, $40, $54, $FE, $FF, $4B, $56, $FE, $FF, $29, $04, $01, $54, $FE, $FF
        .byte $FD, $FF, $FC, $FF, $00, $06, $11, $00, $2B, $08, $06, $18, $60, $16, $01, $54
        .byte $FE, $FF, $5A, $04, $12, $56, $FE, $FF, $36, $08, $FF, $FF

      _8F7D_9173 ; 97/9173
        .byte $3B, $08, $03, $42, $FE, $FF, $04, $42, $FE, $FF, $00, $1A, $06, $56, $FE, $FF
        .byte $25, $2A, $00, $04, $04, $58, $FE, $FF, $05, $58, $FE, $FF, $A3, $56, $FE, $FF
        .byte $A4, $16, $28, $54, $FE, $FF, $17, $10, $08, $54, $FE, $FF, $05, $0E, $06, $4E
        .byte $06, $18, $FE, $FF, $FD, $FF, $11, $08, $12, $08, $01, $04, $A5, $16, $01, $1A
        .byte $01, $54, $FE, $FF, $16, $10, $08, $54, $FE, $FF, $26, $54, $FE, $FF, $FB, $FF
        .byte $A6, $56, $FE, $FF, $FD, $FF, $02, $04, $36, $08, $FF, $FF

      _8F7D_91CF ; 97/91CF
        .byte $3B, $08, $03, $42, $FE, $FF, $04, $42, $FE, $FF, $00, $1A, $06, $56, $FE, $FF
        .byte $23, $2A, $00, $04, $A3, $56, $FE, $FF, $FD, $FF, $A4, $56, $FE, $FF, $01, $04
        .byte $01, $54, $FE, $FF, $01, $1A, $A5, $56, $FE, $FF, $FB, $FF, $A6, $56, $FE, $FF
        .byte $FD, $FF, $02, $04, $36, $08, $FF, $FF

      _8F7D_9207 ; 97/9207
        .byte $3B, $08, $05, $42, $FE, $FF, $06, $42, $FE, $FF, $00, $1A, $06, $56, $FE, $FF
        .byte $24, $2A, $00, $04, $A7, $56, $FE, $FF, $FD, $FF, $A8, $56, $FE, $FF, $01, $04
        .byte $01, $54, $FE, $FF, $01, $1A, $A9, $56, $FE, $FF, $FB, $FF, $AA, $56, $FE, $FF
        .byte $FD, $FF, $02, $04, $36, $08, $FF, $FF

      _8F7D_923F ; 97/923F
        .byte $3B, $08, $07, $42, $FE, $FF, $08, $42, $FE, $FF, $09, $16, $0C, $5E, $FE, $FF
        .byte $FD, $FF, $2F, $2A, $01, $1A, $04, $04, $07, $00, $08, $56, $FE, $FF, $F9, $FF
        .byte $08, $00, $0A, $56, $FE, $FF, $FD, $FF, $FC, $FF, $02, $04, $36, $08, $FF, $FF

      _8F7D_926F ; 97/926F
        .byte $3B, $08, $0C, $42, $FE, $FF, $0D, $42, $FE, $FF, $0B, $16, $0A, $54, $FE, $FF
        .byte $FD, $FF, $0A, $54, $FE, $FF, $26, $2A, $02, $1A, $06, $04, $AD, $16, $AB, $56
        .byte $FE, $FF, $0C, $56, $FE, $FF, $0C, $56, $FE, $FF, $0C, $56, $FE, $FF, $AE, $16
        .byte $AC, $16, $3C, $54, $FE, $FF, $FD, $FF, $02, $04, $3E, $08, $FF, $FF

      _8F7D_92AD ; 97/92AD
        .byte $3B, $08, $0E, $42, $FE, $FF, $0F, $42, $FE, $FF, $00, $22, $11, $16, $00, $1C
        .byte $0A, $54, $FE, $FF, $04, $2A, $01, $20, $00, $5E, $FE, $FF, $03, $1A, $07, $04
        .byte $10, $42, $FE, $FF, $09, $00, $0B, $40, $FE, $FF, $11, $42, $FE, $FF, $FD, $FF
        .byte $05, $2A, $04, $1A, $08, $04, $0E, $56, $FE, $FF, $0F, $56, $FE, $FF, $0F, $56
        .byte $FE, $FF, $0F, $56, $FE, $FF, $F9, $FF, $0F, $56, $FE, $FF, $FA, $FF, $0F, $56
        .byte $FE, $FF, $10, $56, $FE, $FF, $FD, $FF, $FC, $FF, $09, $04, $0A, $40, $FE, $FF
        .byte $12, $56, $FE, $FF, $00, $20, $01, $54, $FE, $FF, $36, $08, $FF, $FF

      _8F7D_931B ; 97/931B
        .byte $3B, $08, $2F, $42, $FE, $FF, $31, $42, $FE, $FF, $17, $10, $08, $54, $FE, $FF
        .byte $11, $08, $12, $08, $30, $42, $FE, $FF, $32, $42, $FE, $FF, $5E, $16, $01, $54
        .byte $FE, $FF, $2A, $08, $38, $04, $02, $1A, $29, $1A, $2C, $08, $01, $54, $FE, $FF
        .byte $07, $2A, $58, $16, $59, $16, $24, $54, $FE, $FF, $56, $16, $57, $16, $5A, $54
        .byte $FE, $FF, $5A, $16, $5B, $16, $8D, $54, $FE, $FF, $39, $04, $29, $1A, $5F, $16
        .byte $33, $42, $FE, $FF, $08, $2A, $FD, $FF, $F9, $FF, $5C, $16, $5D, $16, $2E, $54
        .byte $FE, $FF, $FA, $FF, $10, $54, $FE, $FF, $3A, $04, $2B, $08, $55, $16, $FD, $FF
        .byte $FC, $FF, $04, $58, $FE, $FF, $05, $58, $FE, $FF, $05, $0E, $06, $4E, $06, $18
        .byte $FE, $FF, $60, $16, $01, $54, $FE, $FF, $51, $04, $12, $56, $FE, $FF, $36, $08
        .byte $FF, $FF

      _8F7D_93AD ; 97/93AD
        .byte $3B, $08, $14, $42, $FE, $FF, $15, $42, $FE, $FF, $27, $2A, $40, $16, $0C, $40
        .byte $FE, $FF, $01, $1A, $12, $04, $0D, $40, $FE, $FF, $FD, $FF, $25, $50, $FE, $FF
        .byte $26, $08, $0E, $40, $FE, $FF, $13, $04, $FD, $FF, $0F, $40, $FE, $FF, $41, $56
        .byte $FE, $FF, $36, $08, $FF, $FF

      _8F7D_93E3 ; 97/93E3
        .byte $3B, $08, $12, $42, $FE, $FF, $14, $1C, $13, $42, $FE, $FF, $22, $1A, $0C, $46
        .byte $FE, $FF, $28, $2A, $45, $16, $46, $16, $19, $40, $FE, $FF, $32, $04, $1A, $40
        .byte $FE, $FF, $30, $04, $0D, $46, $FE, $FF, $FD, $FF, $25, $50, $FE, $FF, $26, $08
        .byte $1C, $40, $FE, $FF, $FD, $FF, $31, $04, $1D, $00, $36, $08, $FF, $FF

      _8F7D_9421 ; 97/9421
        .byte $3B, $08, $12, $42, $FE, $FF, $14, $1C, $13, $42, $FE, $FF, $29, $2A, $22, $1A
        .byte $10, $46, $1E, $40, $FE, $FF, $32, $04, $45, $16, $46, $16, $1A, $40, $FE, $FF
        .byte $FD, $FF, $0E, $46, $FE, $FF, $28, $50, $FE, $FF, $12, $08, $27, $50, $FE, $FF
        .byte $1F, $00, $1C, $40, $FE, $FF, $FD, $FF, $33, $04, $0F, $46, $FE, $FF, $1D, $00
        .byte $36, $08, $FF, $FF

      _8F7D_9465 ; 97/9465
        .byte $3B, $08, $20, $42, $FE, $FF, $21, $42, $FE, $FF, $22, $42, $FE, $FF, $03, $1C
        .byte $14, $16, $23, $42, $FE, $FF, $FD, $FF, $0F, $04, $08, $06, $08, $1A, $01, $22
        .byte $13, $16, $15, $56, $FE, $FF, $16, $16, $0A, $1A, $10, $04, $09, $5A, $FE, $FF
        .byte $11, $04, $12, $16, $17, $56, $FE, $FF, $17, $04, $00, $06, $FD, $FF, $36, $08
        .byte $FF, $FF

      _8F7D_94A7 ; 97/94A7
        .byte $3B, $08, $16, $42, $FE, $FF, $17, $42, $13, $1C, $FE, $FF, $0C, $5E, $FE, $FF
        .byte $10, $00, $10, $54, $FE, $FF, $22, $16, $10, $54, $FE, $FF, $FD, $FF, $2B, $2A
        .byte $11, $1A, $1C, $04, $08, $06, $10, $1A, $4C, $54, $FE, $FF, $20, $54, $FE, $FF
        .byte $B7, $16, $20, $54, $FE, $FF, $30, $2E, $1D, $04, $00, $06, $11, $00, $FD, $FF
        .byte $36, $08, $FF, $FF

      _8F7D_94EB ; 97/94EB
        .byte $3B, $08, $20, $42, $FE, $FF, $21, $42, $FE, $FF, $14, $16, $27, $56, $FE, $FF
        .byte $4D, $1A, $19, $06, $01, $54, $FE, $FF, $29, $00, $01, $54, $FE, $FF, $6D, $04
        .byte $01, $54, $FE, $FF, $2A, $2A, $2A, $40, $FE, $FF, $01, $22, $28, $54, $FE, $FF
        .byte $6E, $04, $3F, $08, $28, $54, $FE, $FF, $B8, $16, $46, $54, $FE, $FF, $6F, $04
        .byte $00, $06, $0A, $54, $FE, $FF, $FD, $FF, $0F, $04, $08, $06, $08, $1A, $12, $08
        .byte $15, $56, $FE, $FF, $16, $16, $28, $54, $FE, $FF, $47, $56, $FE, $FF, $17, $56
        .byte $FE, $FF, $30, $2E, $00, $06, $01, $54, $FE, $FF, $FB, $FF, $12, $16, $2B, $40
        .byte $FE, $FF, $17, $04, $FD, $FF, $1D, $00, $36, $08, $FF, $FF

      _8F7D_9567 ; 97/9567
        .byte $3B, $08, $7B, $42, $FE, $FF, $7C, $42, $1D, $16, $FE, $FF, $04, $18, $FE, $FF
        .byte $FD, $FF, $05, $18, $17, $10, $08, $54, $FE, $FF, $05, $0E, $06, $4E, $06, $18
        .byte $FE, $FF, $11, $08, $12, $08, $FE, $FF, $16, $10, $08, $54, $FE, $FF, $2C, $2A
        .byte $03, $64, $FE, $FF, $0F, $1A, $01, $54, $FE, $FF, $1A, $04, $1E, $16, $04, $24
        .byte $53, $54, $FE, $FF, $02, $22, $01, $54, $FE, $FF, $1F, $16, $20, $54, $FE, $FF
        .byte $F9, $FF, $2D, $2A, $42, $08, $1B, $04, $21, $16, $03, $22, $20, $56, $FE, $FF
        .byte $FD, $FF, $FC, $FF, $36, $08, $FF, $FF

      _8F7D_95CF ; 97/95CF
        .byte $3B, $08, $18, $42, $FE, $FF, $B9, $16, $19, $42, $FE, $FF, $0C, $5E, $FE, $FF
        .byte $FD, $FF, $2E, $2A, $2A, $04, $08, $06, $20, $1A, $3C, $16, $3D, $56, $FE, $FF
        .byte $3A, $16, $3B, $16, $B0, $54, $FE, $FF, $F9, $FF, $10, $54, $FE, $FF, $3E, $16
        .byte $3F, $56, $FE, $FF, $2B, $04, $00, $06, $FE, $FF, $FD, $FF, $FC, $FF, $36, $08
        .byte $FF, $FF

      _8F7D_9611 ; 97/9611
        .byte $3B, $08, $1B, $42, $FE, $FF, $1D, $68, $FE, $FF, $1C, $42, $FE, $FF, $1F, $68
        .byte $17, $1A, $FE, $FF, $4E, $04, $FE, $FF, $FD, $FF, $FD, $FF, $36, $08, $FF, $FF

      _8F7D_9631 ; 97/9631
        .byte $3B, $08, $24, $42, $FE, $FF, $06, $1C, $25, $42, $FE, $FF, $09, $5E, $FE, $FF
        .byte $FD, $FF, $11, $1A, $14, $00, $02, $40, $FE, $FF, $03, $2E, $20, $04, $14, $1A
        .byte $16, $06, $18, $5A, $FE, $FF, $F9, $FF, $4A, $5A, $FE, $FF, $FA, $FF, $4B, $1A
        .byte $20, $54, $FE, $FF, $FE, $FF, $A2, $16, $20, $54, $FE, $FF, $FD, $FF, $FC, $FF
        .byte $00, $06, $21, $04, $15, $00, $03, $40, $FE, $FF, $36, $08, $FF, $FF

      _8F7D_967F ; 97/967F
        .byte $3B, $08, $29, $42, $FE, $FF, $2A, $42, $FE, $FF, $2B, $42, $FE, $FF, $15, $1C
        .byte $2E, $42, $FE, $FF, $09, $5E, $FE, $FF, $68, $16, $07, $56, $FE, $FF, $69, $16
        .byte $34, $04, $02, $1A, $2A, $08, $2F, $1A, $28, $42, $FE, $FF, $2C, $68, $FE, $FF
        .byte $06, $2A, $35, $04, $4F, $16, $65, $56, $FE, $FF, $50, $16, $66, $16, $30, $1A
        .byte $0D, $64, $FE, $FF, $36, $04, $FD, $FF, $0B, $24, $73, $54, $F9, $FF, $FE, $FF
        .byte $67, $16, $51, $16, $14, $54, $FE, $FF, $6A, $16, $10, $54, $FE, $FF, $FA, $FF
        .byte $12, $54, $FE, $FF, $57, $04, $01, $54, $FE, $FF, $37, $04, $B2, $56, $04, $58
        .byte $FE, $FF, $FD, $FF, $FC, $FF, $05, $58, $FE, $FF, $2B, $08, $05, $4E, $FE, $FF
        .byte $06, $4E, $06, $18, $FE, $FF, $60, $16, $01, $54, $FE, $FF, $56, $04, $12, $56
        .byte $FE, $FF, $36, $08, $FF, $FF

      _8F7D_9715 ; 97/9715
        .byte $3B, $08, $56, $42, $FE, $FF, $57, $42, $FE, $FF, $58, $42, $FE, $FF, $0A, $1C
        .byte $23, $16, $59, $42, $FE, $FF, $09, $2A, $01, $22, $13, $56, $FE, $FF, $09, $5E
        .byte $FE, $FF, $01, $1A, $1A, $1A, $02, $26, $F9, $FF, $06, $54, $FE, $FF, $FD, $FF
        .byte $22, $04, $01, $22, $21, $16, $01, $54, $FE, $FF, $0A, $2E, $25, $16, $26, $16
        .byte $19, $1A, $06, $54, $FE, $FF, $FA, $FF, $03, $54, $FE, $FF, $24, $56, $FE, $FF
        .byte $23, $04, $01, $54, $FE, $FF, $FF, $26, $FD, $FF, $FC, $FF, $24, $04, $12, $56
        .byte $FE, $FF, $36, $08, $FF, $FF

      _8F7D_977B ; 97/977B
        .byte $3B, $08, $0B, $1C, $23, $16, $5D, $42, $FE, $FF, $0B, $2A, $01, $22, $13, $56
        .byte $5A, $42, $FE, $FF, $5C, $42, $FE, $FF, $5B, $42, $FE, $FF, $09, $5E, $FE, $FF
        .byte $01, $1A, $1A, $1A, $03, $26, $F9, $FF, $06, $54, $FE, $FF, $FD, $FF, $22, $04
        .byte $01, $22, $21, $16, $01, $54, $FE, $FF, $0C, $2E, $25, $16, $26, $16, $1B, $1A
        .byte $06, $54, $FE, $FF, $FA, $FF, $03, $54, $FE, $FF, $24, $56, $FE, $FF, $23, $04
        .byte $01, $54, $FE, $FF, $FF, $26, $FD, $FF, $FC, $FF, $24, $04, $12, $56, $FE, $FF
        .byte $36, $08, $FF, $FF

      _8F7D_97DF ; 97/97DF
        .byte $3B, $08, $4F, $42, $FE, $FF, $50, $42, $FE, $FF, $01, $22, $13, $16, $53, $42
        .byte $FE, $FF, $51, $68, $FE, $FF, $54, $42, $FE, $FF, $16, $1C, $8B, $16, $1C, $1A
        .byte $40, $1A, $55, $42, $FE, $FF, $0D, $2A, $43, $1A, $15, $06, $66, $04, $01, $54
        .byte $FE, $FF, $48, $04, $86, $16, $01, $54, $FE, $FF, $FD, $FF, $88, $16, $06, $1E
        .byte $3F, $5A, $FE, $FF, $4A, $04, $67, $04, $00, $06, $42, $1A, $14, $1A, $45, $1A
        .byte $01, $54, $FE, $FF, $0E, $2E, $44, $1A, $01, $26, $01, $54, $FE, $FF, $49, $04
        .byte $89, $16, $20, $54, $FE, $FF, $F9, $FF, $10, $54, $FE, $FF, $FA, $FF, $20, $54
        .byte $FE, $FF, $64, $04, $8A, $16, $FF, $26, $1F, $1A, $20, $54, $FE, $FF, $FD, $FF
        .byte $FC, $FF, $65, $04, $12, $56, $FE, $FF, $36, $08, $FF, $FF

      _8F7D_986B ; 97/986B
        .byte $3B, $08, $4E, $42, $FE, $FF, $4D, $42, $FE, $FF, $4B, $42, $FE, $FF, $09, $1C
        .byte $4C, $42, $FE, $FF, $09, $5E, $FE, $FF, $82, $16, $01, $22, $02, $1A, $14, $06
        .byte $13, $56, $FE, $FF, $0F, $2A, $3E, $1A, $16, $40, $FE, $FF, $4B, $04, $83, $56
        .byte $FE, $FF, $11, $2A, $FD, $FF, $F9, $FF, $84, $16, $4C, $04, $3D, $1A, $10, $54
        .byte $FE, $FF, $FA, $FF, $78, $54, $FE, $FF, $10, $2A, $4D, $04, $85, $16, $17, $00
        .byte $20, $54, $FE, $FF, $62, $04, $18, $00, $01, $06, $82, $16, $01, $54, $FE, $FF
        .byte $FD, $FF, $FC, $FF, $00, $06, $1F, $1A, $12, $56, $FE, $FF, $36, $08, $FF, $FF

      _8F7D_98DB ; 97/98DB
        .byte $3B, $08, $0B, $1C, $23, $16, $5D, $42, $FE, $FF, $5A, $42, $FE, $FF, $5C, $42
        .byte $FE, $FF, $5B, $42, $FE, $FF, $04, $18, $FE, $FF, $05, $18, $17, $10, $08, $54
        .byte $FE, $FF, $0B, $2A, $01, $22, $13, $56, $FE, $FF, $05, $0E, $06, $4E, $06, $18
        .byte $11, $08, $12, $08, $FE, $FF, $01, $22, $29, $16, $16, $10, $08, $54, $FE, $FF
        .byte $01, $1A, $1A, $1A, $03, $26, $F9, $FF, $06, $54, $FE, $FF, $FD, $FF, $22, $04
        .byte $01, $22, $21, $16, $01, $54, $FE, $FF, $0A, $2A, $25, $16, $26, $16, $1B, $1A
        .byte $06, $54, $FE, $FF, $FA, $FF, $03, $54, $FE, $FF, $24, $56, $FE, $FF, $23, $04
        .byte $01, $54, $FE, $FF, $FF, $26, $FD, $FF, $FC, $FF, $24, $04, $12, $56, $FE, $FF
        .byte $36, $08, $FF, $FF

      _8F7D_995F ; 97/995F
        .byte $3B, $08, $3A, $42, $FE, $FF, $3B, $68, $1C, $1A, $FE, $FF, $42, $16, $0A, $46
        .byte $FE, $FF, $12, $2A, $27, $04, $0B, $46, $FE, $FF, $13, $2A, $FD, $FF, $F9, $FF
        .byte $04, $1E, $1D, $5A, $FE, $FF, $FA, $FF, $1E, $5A, $FE, $FF, $FD, $FF, $FC, $FF
        .byte $28, $04, $61, $56, $FE, $FF, $36, $08, $FF, $FF

      _8F7D_9999 ; 97/9999
        .byte $3B, $08, $3D, $42, $FE, $FF, $3E, $68, $1C, $1A, $FE, $FF, $14, $2A, $28, $16
        .byte $0A, $46, $FE, $FF, $25, $04, $0B, $46, $FE, $FF, $15, $2A, $FD, $FF, $F9, $FF
        .byte $04, $1E, $1D, $5A, $FE, $FF, $FA, $FF, $1E, $5A, $FE, $FF, $FD, $FF, $FC, $FF
        .byte $26, $04, $36, $08, $FF, $FF

      _8F7D_99CF ; 97/99CF
        .byte $3B, $08, $40, $42, $FE, $FF, $43, $42, $FE, $FF, $41, $68, $FE, $FF, $B3, $16
        .byte $44, $42, $FE, $FF, $16, $2A, $09, $06, $0B, $1A, $18, $04, $B4, $16, $4C, $1A
        .byte $B5, $56, $FE, $FF, $FD, $FF, $F9, $FF, $02, $1E, $0C, $5A, $FE, $FF, $FA, $FF
        .byte $0D, $5A, $FE, $FF, $B6, $56, $FE, $FF, $FD, $FF, $FC, $FF, $00, $06, $19, $04
        .byte $36, $08, $FF, $FF

      _8F7D_9A13 ; 97/9A13
        .byte $3B, $08, $37, $42, $FE, $FF, $38, $42, $FE, $FF, $1C, $1A, $39, $42, $FE, $FF
        .byte $05, $1E, $FE, $FF, $07, $56, $FE, $FF, $64, $16, $27, $40, $FE, $FF, $17, $2A
        .byte $52, $04, $2A, $08, $2E, $1A, $43, $16, $18, $06, $2B, $1A, $62, $56, $FE, $FF
        .byte $53, $04, $28, $40, $FE, $FF, $FD, $FF, $1E, $54, $FE, $FF, $F9, $FF, $10, $54
        .byte $FE, $FF, $FA, $FF, $1E, $54, $FE, $FF, $63, $16, $44, $56, $FE, $FF, $FD, $FF
        .byte $FC, $FF, $54, $04, $2B, $08, $60, $16, $00, $06, $01, $54, $FE, $FF, $55, $04
        .byte $12, $56, $FE, $FF, $36, $08, $FF, $FF

      _8F7D_9A7B ; 97/9A7B
        .byte $3B, $08, $45, $42, $FE, $FF, $47, $68, $FE, $FF, $46, $42, $FE, $FF, $BA, $16
        .byte $49, $68, $FE, $FF, $04, $18, $FE, $FF, $FD, $FF, $05, $18, $17, $10, $08, $54
        .byte $FE, $FF, $05, $0E, $06, $4E, $06, $18, $11, $08, $12, $08, $FE, $FF, $16, $10
        .byte $08, $54, $FE, $FF, $07, $22, $13, $56, $FE, $FF, $0A, $04, $05, $1A, $01, $54
        .byte $FE, $FF, $06, $1A, $01, $54, $FE, $FF, $18, $2A, $00, $16, $5C, $54, $FE, $FF
        .byte $F9, $FF, $10, $54, $FE, $FF, $FA, $FF, $1E, $54, $FE, $FF, $01, $16, $20, $54
        .byte $FE, $FF, $FD, $FF, $FC, $FF, $0C, $04, $0A, $54, $FE, $FF, $12, $56, $FE, $FF
        .byte $36, $08, $FF, $FF

      _8F7D_9AEF ; 97/9AEF
        .byte $3B, $08, $63, $42, $FE, $FF, $64, $42, $FE, $FF, $7D, $42, $FE, $FF, $12, $1C
        .byte $14, $16, $7E, $42, $FE, $FF, $01, $5E, $FE, $FF, $02, $1A, $14, $04, $18, $56
        .byte $FE, $FF, $19, $16, $0E, $1A, $0A, $64, $FE, $FF, $FD, $FF, $19, $2A, $15, $04
        .byte $0B, $24, $73, $54, $FE, $FF, $1A, $16, $1B, $16, $1C, $16, $10, $54, $FE, $FF
        .byte $F9, $FF, $1E, $54, $FE, $FF, $09, $24, $01, $54, $FE, $FF, $FA, $FF, $16, $04
        .byte $12, $56, $FE, $FF, $FD, $FF, $FC, $FF, $36, $08, $FF, $FF

      _8F7D_9B4B ; 97/9B4B
        .byte $3B, $08, $34, $42, $FE, $FF, $35, $42, $FE, $FF, $09, $5E, $FE, $FF, $07, $56
        .byte $FE, $FF, $2C, $04, $01, $1A, $3B, $1A, $32, $16, $79, $16, $2A, $08, $36, $42
        .byte $FE, $FF, $1A, $2E, $5F, $04, $32, $16, $33, $16, $34, $16, $35, $56, $FE, $FF
        .byte $FD, $FF, $F9, $FF, $2A, $16, $2B, $16, $2C, $16, $2D, $16, $78, $54, $FE, $FF
        .byte $0A, $5E, $FE, $FF, $21, $5A, $FE, $FF, $1B, $2C, $FA, $FF, $F8, $FF, $2E, $16
        .byte $2F, $16, $30, $16, $31, $16, $78, $54, $FE, $FF, $FC, $FF, $FD, $FF, $36, $16
        .byte $37, $16, $38, $16, $39, $16, $3C, $54, $FE, $FF, $2D, $04, $05, $58, $FE, $FF
        .byte $2B, $08, $06, $4E, $06, $18, $FE, $FF, $55, $16, $01, $54, $FE, $FF, $5E, $04
        .byte $12, $56, $FE, $FF, $36, $08, $FF, $FF

      _8F7D_9BD3 ; 97/9BD3
        .byte $3B, $08, $65, $42, $FE, $FF, $67, $42, $FE, $FF, $68, $42, $FE, $FF, $6A, $42
        .byte $FE, $FF, $09, $5E, $FE, $FF, $4D, $16, $07, $56, $FE, $FF, $2E, $04, $66, $42
        .byte $FE, $FF, $0D, $1C, $2A, $08, $69, $42, $FE, $FF, $49, $1A, $34, $1A, $44, $04
        .byte $39, $08, $01, $54, $FE, $FF, $1D, $2A, $35, $1A, $70, $56, $FE, $FF, $23, $00
        .byte $4B, $54, $FE, $FF, $74, $16, $01, $54, $FE, $FF, $45, $04, $25, $00, $3C, $54
        .byte $FE, $FF, $35, $08, $14, $54, $FE, $FF, $F9, $FF, $10, $54, $FE, $FF, $FA, $FF
        .byte $FD, $FF, $20, $54, $FE, $FF, $FD, $FF, $FC, $FF, $20, $54, $FE, $FF, $72, $16
        .byte $FE, $FF, $2F, $04, $2B, $08, $04, $58, $FE, $FF, $05, $58, $FE, $FF, $05, $0E
        .byte $06, $4E, $06, $18, $FE, $FF, $73, $16, $01, $54, $FE, $FF, $46, $04, $12, $56
        .byte $FE, $FF, $36, $08, $FF, $FF

      _8F7D_9C69 ; 97/9C69
        .byte $3B, $08, $6F, $42, $FE, $FF, $02, $1C, $70, $68, $FE, $FF, $01, $5E, $FE, $FF
        .byte $AF, $16, $01, $54, $FE, $FF, $01, $22, $13, $56, $FE, $FF, $0D, $04, $14, $54
        .byte $FE, $FF, $FD, $FF, $1E, $2A, $08, $06, $07, $1A, $01, $54, $FE, $FF, $B0, $16
        .byte $77, $54, $FE, $FF, $F9, $FF, $10, $54, $FE, $FF, $FA, $FF, $3C, $54, $FE, $FF
        .byte $B1, $16, $50, $54, $FE, $FF, $FD, $FF, $FC, $FF, $28, $54, $FE, $FF, $0E, $04
        .byte $00, $06, $12, $56, $FE, $FF, $36, $08, $FF, $FF

      _8F7D_9CC3 ; 97/9CC3
        .byte $3B, $08, $77, $42, $FE, $FF, $79, $42, $FE, $FF, $17, $10, $08, $54, $FE, $FF
        .byte $11, $08, $12, $08, $60, $04, $01, $54, $FE, $FF, $2A, $08, $3C, $1A, $7A, $16
        .byte $78, $42, $FE, $FF, $7A, $42, $FE, $FF, $FD, $FF, $02, $1A, $3B, $04, $05, $24
        .byte $23, $1A, $01, $54, $FE, $FF, $16, $10, $7B, $56, $FE, $FF, $05, $22, $01, $54
        .byte $FE, $FF, $1F, $2A, $3C, $04, $06, $24, $7C, $16, $96, $54, $FE, $FF, $7D, $16
        .byte $7E, $16, $7F, $16, $1A, $54, $FE, $FF, $F9, $FF, $10, $54, $FE, $FF, $FA, $FF
        .byte $01, $54, $FE, $FF, $80, $16, $08, $24, $01, $54, $FE, $FF, $3D, $04, $2B, $08
        .byte $1F, $1A, $01, $54, $FE, $FF, $04, $58, $FE, $FF, $05, $58, $FE, $FF, $05, $4E
        .byte $FE, $FF, $06, $4E, $06, $18, $FE, $FF, $FD, $FF, $FC, $FF, $06, $22, $01, $54
        .byte $FE, $FF, $61, $04, $12, $56, $FE, $FF, $81, $16, $01, $54, $FE, $FF, $36, $08
        .byte $FF, $FF

      _8F7D_9D65 ; 97/9D65
        .byte $3B, $08, $09, $4C, $FE, $FF, $09, $5E, $FE, $FF, $07, $56, $FE, $FF, $41, $04
        .byte $0F, $4E, $FE, $FF, $6B, $42, $FE, $FF, $6D, $42, $FE, $FF, $0E, $1C, $6E, $42
        .byte $FE, $FF, $6C, $16, $2A, $08, $31, $1A, $12, $06, $01, $54, $FE, $FF, $44, $08
        .byte $01, $54, $FE, $FF, $20, $2A, $42, $04, $32, $1A, $6D, $56, $FE, $FF, $3C, $54
        .byte $FE, $FF, $FD, $FF, $02, $1A, $20, $00, $01, $54, $FE, $FF, $11, $06, $01, $54
        .byte $FE, $FF, $59, $04, $33, $1A, $21, $00, $35, $54, $FE, $FF, $F9, $FF, $10, $54
        .byte $FE, $FF, $FA, $FF, $08, $54, $FE, $FF, $6E, $56, $FE, $FF, $00, $06, $01, $06
        .byte $43, $04, $FD, $FF, $FC, $FF, $04, $58, $FE, $FF, $05, $58, $FE, $FF, $05, $0E
        .byte $06, $4E, $06, $18, $FE, $FF, $2B, $08, $60, $16, $01, $54, $FE, $FF, $58, $04
        .byte $12, $56, $FE, $FF, $36, $08, $FF, $FF

      _8F7D_9DFD ; 97/9DFD
        .byte $3B, $08, $2F, $42, $FE, $FF, $31, $42, $FE, $FF, $2A, $42, $FE, $FF, $2E, $42
        .byte $FE, $FF, $09, $5E, $FE, $FF, $07, $56, $FE, $FF, $3E, $04, $2A, $08, $0F, $1C
        .byte $01, $54, $FE, $FF, $75, $16, $02, $1A, $37, $1A, $72, $42, $FE, $FF, $74, $42
        .byte $FE, $FF, $21, $2A, $3F, $04, $38, $1A, $76, $16, $3C, $54, $FE, $FF, $0A, $54
        .byte $FE, $FF, $02, $1A, $24, $00, $FE, $FF, $FD, $FF, $5C, $04, $3A, $1A, $26, $00
        .byte $39, $1A, $52, $56, $FE, $FF, $53, $16, $1E, $54, $FE, $FF, $F9, $FF, $1A, $54
        .byte $FE, $FF, $FA, $FF, $06, $54, $FE, $FF, $54, $16, $77, $16, $78, $16, $5C, $54
        .byte $FE, $FF, $FD, $FF, $FC, $FF, $40, $04, $04, $58, $FE, $FF, $05, $58, $FE, $FF
        .byte $05, $0E, $06, $4E, $06, $18, $FE, $FF, $2B, $08, $60, $16, $01, $54, $FE, $FF
        .byte $5D, $04, $12, $56, $FE, $FF, $36, $08, $FF, $FF

      _8F7D_9E97 ; 97/9E97
        .byte $04, $18, $FE, $FF, $05, $18, $17, $10, $08, $54, $FE, $FF, $05, $0E, $06, $4E
        .byte $06, $18, $FE, $FF, $11, $08, $12, $08, $FE, $FF, $16, $10, $08, $54, $FE, $FF
        .byte $18, $08, $FE, $FF, $FF, $FF

      _8F7D_9EBD ; 97/9EBD
        .byte $03, $10, $02, $12, $04, $0C, $05, $4C, $FE, $FF, $19, $08, $05, $08, $08, $0E
        .byte $09, $0E, $07, $4E, $FE, $FF, $1F, $08, $0E, $4E, $FE, $FF, $07, $4A, $FE, $FF
        .byte $FF, $FF

      _8F7D_9EDF ; 97/9EDF
        .byte $40, $08, $03, $50, $FE, $FF, $03, $50, $FE, $FF, $04, $4C, $FE, $FF, $06, $4C
        .byte $FE, $FF, $1A, $08, $08, $4E, $FE, $FF, $09, $4E, $FE, $FF, $1F, $08, $0E, $4E
        .byte $FE, $FF, $1C, $08, $07, $4A, $FE, $FF, $1D, $50, $FE, $FF, $FF, $FF

      _8F7D_9F0D ; 97/9F0D
        .byte $07, $4C, $FE, $FF, $08, $4C, $FE, $FF, $03, $50, $FE, $FF, $1B, $08, $0A, $4E
        .byte $FE, $FF, $0D, $4E, $FE, $FF, $0C, $4E, $FE, $FF, $0B, $4E, $FE, $FF, $3A, $08
        .byte $08, $54, $FE, $FF, $07, $4A, $FE, $FF, $FF, $FF

      _8F7D_9F37 ; 97/9F37
        .byte $23, $08, $1D, $50, $FE, $FF, $FF, $FF

      _8F7D_9F3F ; 97/9F3F
        .byte $40, $08, $03, $50, $FE, $FF, $02, $12, $04, $0C, $05, $4C, $FE, $FF, $19, $08
        .byte $22, $08, $08, $0E, $09, $0E, $07, $4E, $FE, $FF, $1F, $08, $0E, $4E, $FE, $FF
        .byte $20, $08, $07, $4A, $FE, $FF, $1D, $50, $FE, $FF, $03, $50, $FE, $FF, $1E, $08
        .byte $07, $4C, $FE, $FF, $08, $4C, $FE, $FF, $1B, $08, $0A, $4E, $FE, $FF, $0D, $4E
        .byte $FE, $FF, $0C, $4E, $FE, $FF, $3A, $08, $0B, $4E, $FE, $FF, $07, $4A, $FE, $FF
        .byte $40, $48, $FF, $FF

      _8F7D_9F93 ; 97/9F93
        .byte $40, $08, $03, $50, $FE, $FF, $02, $12, $04, $0C, $05, $4C, $FE, $FF, $19, $08
        .byte $22, $08, $08, $0E, $09, $0E, $07, $4E, $FE, $FF, $1F, $08, $0E, $4E, $FE, $FF
        .byte $21, $08, $07, $4A, $FE, $FF, $1D, $50, $FE, $FF, $03, $50, $FE, $FF, $1E, $08
        .byte $07, $4C, $FE, $FF, $08, $4C, $FE, $FF, $1B, $08, $0A, $4E, $FE, $FF, $0D, $4E
        .byte $FE, $FF, $0C, $4E, $FE, $FF, $3A, $08, $0B, $4E, $FE, $FF, $07, $4A, $FE, $FF
        .byte $40, $48, $FF, $FF

      _8F7D_9FE7 ; 97/9FE7
        .byte $23, $08, $1D, $50, $FE, $FF, $FF, $FF

      _8F7D_9FEF ; 97/9FEF
        .byte $23, $08, $1D, $50, $FE, $FF, $FF, $FF

      _8F7D_9FF7 ; 97/9FF7
        .byte $07, $5E, $FE, $FF, $04, $22, $01, $54, $FE, $FF, $24, $50, $FE, $FF, $27, $56
        .byte $FE, $FF, $FF, $FF

      _8F7D_A00B ; 97/A00B
        .byte $08, $5E, $FE, $FF, $FF, $FF

      _8F7D_A011 ; 97/A011
        .byte $3B, $08, $7F, $42, $FE, $FF, $80, $42, $FE, $FF, $12, $42, $FE, $FF, $14, $1C
        .byte $13, $42, $FE, $FF, $46, $1A, $10, $46, $1E, $40, $FE, $FF, $32, $04, $8C, $16
        .byte $8D, $16, $1A, $40, $FE, $FF, $0E, $46, $FE, $FF, $3C, $08, $8E, $16, $90, $16
        .byte $97, $16, $9D, $16, $30, $50, $FE, $FF, $91, $16, $01, $54, $FE, $FF, $98, $16
        .byte $01, $54, $FE, $FF, $0F, $06, $94, $16, $32, $08, $47, $1A, $01, $54, $FE, $FF
        .byte $68, $04, $95, $56, $FE, $FF, $99, $16, $9A, $16, $9B, $16, $9C, $16, $12, $08
        .byte $2F, $50, $FE, $FF, $11, $08, $9E, $16, $96, $56, $FE, $FF, $92, $16, $8C, $16
        .byte $8D, $16, $10, $54, $FE, $FF, $69, $04, $46, $1A, $01, $54, $FE, $FF, $0C, $46
        .byte $FE, $FF, $8F, $16, $93, $16, $9F, $16, $31, $50, $FE, $FF, $1F, $00, $1C, $40
        .byte $FE, $FF, $6A, $04, $0F, $46, $FE, $FF, $1D, $00, $36, $08, $FF, $FF

      _8F7D_A0AF ; 97/A0AF
        .byte $07, $5E, $FF, $FF

      _8F7D_A0B3 ; 97/A0B3
        .byte $03, $10, $00, $12, $00, $0C, $01, $0C, $02, $0C, $03, $4C, $FE, $FF, $02, $08
        .byte $05, $08, $33, $08, $01, $0E, $02, $0E, $00, $0E, $03, $0E, $04, $4E, $FE, $FF
        .byte $00, $42, $FE, $FF, $07, $4A, $0E, $50, $FE, $FF, $78, $70, $FF, $FF

      _8F7D_A0E1 ; 97/A0E1
        .byte $81, $42, $FE, $FF, $34, $08, $FF, $FF

      _8F7D_A0E9 ; 97/A0E9
        .byte $81, $42, $FE, $FF, $34, $08, $FF, $FF

      _8F7D_A0F1 ; 97/A0F1
        .byte $81, $42, $FE, $FF, $34, $08, $FF, $FF

      _8F7D_A0F9 ; 97/A0F9
        .byte $82, $42, $FE, $FF, $FF, $FF

      _8F7D_A0FF ; 97/A0FF
        .byte $83, $42, $FE, $FF, $FF, $FF

      _8F7D_A105 ; 97/A105
        .byte $84, $42, $FE, $FF, $FF, $FF

      _8F7D_A10B ; 97/A10B
        .byte $3B, $08, $7B, $42, $FE, $FF, $7C, $42, $1D, $16, $FE, $FF, $2C, $2A, $03, $64
        .byte $FE, $FF, $0F, $1A, $01, $54, $FE, $FF, $1A, $04, $1E, $16, $04, $24, $53, $54
        .byte $FE, $FF, $02, $22, $01, $54, $FE, $FF, $1F, $16, $20, $54, $FE, $FF, $2D, $2A
        .byte $42, $08, $1B, $04, $21, $16, $01, $54, $FE, $FF, $03, $22, $01, $54, $FE, $FF
        .byte $20, $56, $FE, $FF, $36, $08, $FF, $FF

      _8F7D_A153 ; 97/A153
        .byte $0B, $5E, $FE, $FF, $FF, $FF

      _8F7D_A159 ; 97/A159
        .byte $00, $58, $FE, $FF, $01, $58, $FE, $FF, $17, $10, $08, $54, $FE, $FF, $05, $4E
        .byte $FE, $FF, $06, $4E, $02, $18, $FE, $FF, $37, $08, $26, $08, $FE, $FF, $16, $10
        .byte $08, $54, $FE, $FF, $FF, $FF

      _8F7D_A17F ; 97/A17F
        .byte $85, $42, $FE, $FF, $FF, $FF

      _8F7D_A185 ; 97/A185
        .byte $17, $10, $08, $54, $FE, $FF, $38, $08, $08, $54, $FE, $FF, $16, $10, $08, $54
        .byte $FE, $FF, $FF, $FF

      _8F7D_A199 ; 97/A199
        .byte $3B, $08, $07, $42, $FE, $FF, $09, $16, $08, $42, $FE, $FF, $2F, $2A, $01, $1A
        .byte $04, $04, $07, $00, $08, $56, $FE, $FF, $08, $00, $0A, $56, $FE, $FF, $02, $04
        .byte $36, $08, $FF, $FF

      _8F7D_A1BD ; 97/A1BD
        .byte $3B, $08, $18, $42, $FE, $FF, $19, $42, $FE, $FF, $2E, $2A, $2A, $04, $08, $06
        .byte $20, $1A, $3C, $16, $3D, $56, $FE, $FF, $3A, $16, $3B, $16, $C0, $54, $FE, $FF
        .byte $3E, $16, $3F, $56, $FE, $FF, $2B, $04, $00, $06, $01, $54, $FE, $FF, $36, $08
        .byte $FF, $FF

      _8F7D_A1EF ; 97/A1EF
        .byte $3B, $08, $6B, $04, $17, $46, $FE, $FF, $6C, $04, $01, $54, $FF, $FF

      _8F7D_A1FD ; 97/A1FD
        .byte $23, $08, $1D, $50, $FE, $FF, $FF, $FF

      _8F7D_A205 ; 97/A205
        .byte $3B, $08, $03, $42, $FE, $FF, $04, $42, $FE, $FF, $00, $1A, $06, $56, $FE, $FF
        .byte $25, $2A, $00, $04, $A3, $56, $FE, $FF, $A4, $16, $0C, $1E, $28, $54, $FE, $FF
        .byte $FD, $FF, $01, $04, $A5, $16, $01, $1A, $01, $54, $FE, $FF, $26, $54, $FE, $FF
        .byte $FB, $FF, $A6, $56, $FE, $FF, $FD, $FF, $02, $04, $36, $08, $FF, $FF

      _8F7D_A243 ; 97/A243
        .byte $3B, $08, $16, $42, $FE, $FF, $17, $42, $FE, $FF, $04, $58, $FE, $FF, $FD, $FF
        .byte $05, $58, $FE, $FF, $17, $10, $08, $54, $FE, $FF, $05, $0E, $06, $4E, $06, $18
        .byte $FE, $FF, $FD, $FF, $11, $08, $12, $08, $01, $54, $FE, $FF, $16, $10, $08, $54
        .byte $FE, $FF, $13, $1C, $10, $00, $01, $54, $FE, $FF, $22, $16, $10, $54, $FE, $FF
        .byte $2B, $2A, $11, $1A, $1C, $04, $08, $06, $10, $1A, $4C, $54, $FE, $FF, $20, $54
        .byte $FE, $FF, $B7, $16, $20, $54, $FE, $FF, $30, $2E, $1D, $04, $00, $06, $11, $00
        .byte $FD, $FF, $36, $08, $FF, $FF

      _8F7D_A2A9 ; 97/A2A9
        .byte $3B, $08, $7B, $42, $FE, $FF, $7C, $42, $1D, $16, $FE, $FF, $0C, $5E, $FE, $FF
        .byte $2C, $2A, $03, $64, $FE, $FF, $0F, $1A, $01, $54, $FE, $FF, $1A, $04, $1E, $16
        .byte $04, $24, $53, $54, $FE, $FF, $FD, $FF, $02, $22, $01, $54, $FE, $FF, $1F, $16
        .byte $20, $54, $FE, $FF, $F9, $FF, $2D, $2A, $42, $08, $1B, $04, $21, $16, $03, $22
        .byte $20, $56, $FE, $FF, $FD, $FF, $FC, $FF, $36, $08, $FF, $FF

      _8F7D_A2F5 ; 97/A2F5
        .byte $3B, $08, $18, $42, $FE, $FF, $B9, $16, $19, $42, $FE, $FF, $04, $58, $FE, $FF
        .byte $FD, $FF, $05, $58, $FE, $FF, $17, $10, $08, $54, $FE, $FF, $05, $0E, $06, $4E
        .byte $06, $18, $FE, $FF, $FD, $FF, $11, $08, $12, $08, $01, $54, $FE, $FF, $16, $10
        .byte $08, $54, $FE, $FF, $2E, $2A, $2A, $04, $08, $06, $20, $1A, $3C, $16, $3D, $56
        .byte $FE, $FF, $3A, $16, $3B, $16, $B0, $54, $FE, $FF, $F9, $FF, $10, $54, $FE, $FF
        .byte $3E, $16, $3F, $56, $FE, $FF, $2B, $04, $00, $06, $FE, $FF, $FD, $FF, $FC, $FF
        .byte $36, $08, $FF, $FF

      _8F7D_A359 ; 97/A359
        .byte $3B, $08, $07, $42, $FE, $FF, $08, $42, $FE, $FF, $04, $58, $FE, $FF, $FD, $FF
        .byte $05, $58, $FE, $FF, $17, $10, $08, $54, $FE, $FF, $05, $0E, $06, $4E, $06, $18
        .byte $FE, $FF, $11, $08, $12, $08, $01, $54, $FE, $FF, $09, $16, $16, $10, $08, $54
        .byte $FE, $FF, $FD, $FF, $2F, $2A, $01, $1A, $04, $04, $07, $00, $08, $56, $FE, $FF
        .byte $F9, $FF, $08, $00, $0A, $56, $FE, $FF, $FD, $FF, $FC, $FF, $02, $04, $36, $08
        .byte $FF, $FF

      _8F7D_A3AB ; 97/A3AB
        .byte $40, $08, $03, $50, $FE, $FF, $02, $12, $04, $0C, $05, $4C, $FE, $FF, $19, $08
        .byte $22, $08, $08, $0E, $09, $0E, $07, $4E, $FE, $FF, $1F, $08, $0E, $4E, $FE, $FF
        .byte $21, $08, $07, $4A, $FE, $FF, $1D, $50, $FE, $FF, $1E, $08, $40, $48, $FF, $FF

      _8F7D_A3DB ; 97/A3DB
        .byte $17, $10, $08, $54, $FE, $FF, $11, $08, $45, $08, $08, $54, $FE, $FF, $16, $10
        .byte $08, $54, $FE, $FF, $FF, $FF

      _8F7D_A3F1 ; 97/A3F1
        .byte $3B, $08, $86, $42, $FE, $FF, $87, $42, $FE, $FF, $07, $22, $BE, $16, $3C, $54
        .byte $FE, $FF, $46, $08, $01, $54, $FE, $FF, $BD, $56, $FE, $FF, $47, $08, $FF, $FF

        ; 97/A411

      aUnknown97A411 ; 97/A411

        ; Window effect 1 offset table (44 entries).

        .word _A411_A469 - aUnknown97A411
        .word _A411_A477 - aUnknown97A411
        .word _A411_A494 - aUnknown97A411
        .word _A411_A4A2 - aUnknown97A411
        .word _A411_A4A5 - aUnknown97A411
        .word _A411_A4AA - aUnknown97A411
        .word _A411_A4B3 - aUnknown97A411
        .word _A411_A4B8 - aUnknown97A411
        .word _A411_A4F2 - aUnknown97A411
        .word _A411_A511 - aUnknown97A411
        .word _A411_A53D - aUnknown97A411
        .word _A411_A552 - aUnknown97A411
        .word _A411_A57E - aUnknown97A411
        .word _A411_A58C - aUnknown97A411
        .word _A411_A5CC - aUnknown97A411
        .word _A411_A5E7 - aUnknown97A411
        .word _A411_A5EA - aUnknown97A411
        .word _A411_A5F8 - aUnknown97A411
        .word _A411_A5FB - aUnknown97A411
        .word _A411_A616 - aUnknown97A411
        .word _A411_A61B - aUnknown97A411
        .word _A411_A629 - aUnknown97A411
        .word _A411_A62E - aUnknown97A411
        .word _A411_A666 - aUnknown97A411
        .word _A411_A689 - aUnknown97A411
        .word _A411_A68C - aUnknown97A411
        .word _A411_A69A - aUnknown97A411
        .word _A411_A6C5 - aUnknown97A411
        .word _A411_A6D1 - aUnknown97A411
        .word _A411_A6FA - aUnknown97A411
        .word _A411_A6FF - aUnknown97A411
        .word _A411_A70D - aUnknown97A411
        .word _A411_A719 - aUnknown97A411
        .word _A411_A727 - aUnknown97A411
        .word _A411_A7A6 - aUnknown97A411
        .word _A411_A7AB - aUnknown97A411
        .word _A411_A7B9 - aUnknown97A411
        .word aUnknown97A7C7 - aUnknown97A411
        .word aUnknown97A7C7._A411_A844 - aUnknown97A411
        .word aUnknown97A7C7._A411_A8CF - aUnknown97A411
        .word aUnknown97A7C7._A411_A8DD - aUnknown97A411
        .word aUnknown97A7C7._A411_A934 - aUnknown97A411
        .word aUnknown97A7C7._A411_A942 - aUnknown97A411
        .word aUnknown97A7C7._A411_A985 - aUnknown97A411

      _A411_A469 ; 97/A469
        .byte $01, $03, $00, $00, $00, $00, $01, $00, $00, $F4, $02, $02, $00, $FD

      _A411_A477 ; 97/A477
        .byte $80, $17, $01, $16, $01, $15, $01, $14, $01, $13, $01, $12, $01, $11, $01, $10
        .byte $01, $0E, $01, $0C, $01, $0A, $01, $07, $01, $04, $01, $00, $FD

      _A411_A494 ; 97/A494
        .byte $02, $03, $00, $30, $00, $00, $00, $01, $00, $F7, $36, $01, $00, $FD

      _A411_A4A2 ; 97/A4A2
        .byte $80, $00, $FF

      _A411_A4A5 ; 97/A4A5
        .byte $80, $00, $F7, $00, $FD

      _A411_A4AA ; 97/A4AA
        .byte $80, $20, $00, $1E, $00, $03, $FE, $00, $FD

      _A411_A4B3 ; 97/A4B3
        .byte $80, $00, $FA, $20, $F9

      _A411_A4B8 ; 97/A4B8
        .byte $00, $03, $00, $00, $00, $00, $00, $01, $00, $F6, $02, $00, $04, $00, $06, $00
        .byte $08, $00, $0A, $00, $0C, $00, $0E, $00, $10, $00, $14, $00, $18, $00, $1C, $00
        .byte $20, $00, $24, $00, $28, $00, $2C, $00, $30, $00, $38, $00, $40, $00, $48, $00
        .byte $50, $00, $58, $00, $60, $00, $68, $00, $00, $FD

      _A411_A4F2 ; 97/A4F2
        .byte $80, $68, $36, $60, $00, $58, $00, $50, $00, $48, $00, $40, $00, $38, $00, $30
        .byte $00, $28, $00, $20, $00, $18, $00, $10, $00, $08, $00, $01, $00, $00, $FF

      _A411_A511 ; 97/A511
        .byte $03, $20, $00, $00, $00, $00, $02, $00, $00, $F5, $20, $00, $21, $00, $19, $00
        .byte $20, $10, $40, $00, $42, $00, $38, $00, $40, $10, $60, $00, $64, $00, $58, $00
        .byte $60, $10, $80, $00, $84, $00, $76, $00, $80, $40, $00, $FD

      _A411_A53D ; 97/A53D
        .byte $80, $80, $00, $70, $00, $60, $00, $50, $00, $40, $00, $30, $00, $20, $00, $10
        .byte $00, $01, $00, $00, $FF

      _A411_A552 ; 97/A552
        .byte $44, $2C, $00, $00, $00, $00, $02, $01, $00, $F5, $20, $00, $21, $00, $19, $00
        .byte $20, $10, $40, $00, $42, $00, $38, $00, $40, $10, $60, $00, $64, $00, $58, $00
        .byte $60, $10, $80, $00, $84, $00, $76, $00, $80, $40, $00, $FD

      _A411_A57E ; 97/A57E
        .byte $02, $03, $00, $30, $00, $00, $00, $01, $00, $F7, $02, $10, $00, $FD

      _A411_A58C ; 97/A58C
        .byte $02, $03, $00, $30, $00, $00, $00, $01, $02, $10, $04, $08, $06, $02, $08, $01
        .byte $0A, $01, $0C, $01, $0E, $01, $10, $01, $12, $01, $14, $01, $16, $01, $18, $01
        .byte $1A, $01, $1C, $01, $1E, $01, $20, $01, $22, $01, $24, $01, $26, $01, $28, $01
        .byte $2A, $01, $2C, $01, $2E, $01, $30, $01, $32, $01, $34, $01, $36, $20, $00, $FD

      _A411_A5CC ; 97/A5CC
        .byte $80, $36, $01, $32, $01, $2E, $01, $2A, $01, $26, $01, $22, $01, $1E, $01, $1A
        .byte $01, $16, $01, $12, $01, $0A, $01, $02, $01, $00, $FD

      _A411_A5E7 ; 97/A5E7
        .byte $80, $00, $FF

      _A411_A5EA ; 97/A5EA
        .byte $02, $03, $00, $30, $00, $00, $00, $01, $00, $F7, $36, $01, $00, $FD

      _A411_A5F8 ; 97/A5F8
        .byte $80, $00, $FF

      _A411_A5FB ; 97/A5FB
        .byte $80, $02, $04, $04, $03, $06, $02, $08, $02, $0A, $01, $0C, $01, $0E, $01, $10
        .byte $01, $12, $01, $14, $01, $16, $01, $18, $01, $00, $FD

      _A411_A616 ; 97/A616
        .byte $80, $02, $01, $00, $FF

      _A411_A61B ; 97/A61B
        .byte $45, $08, $00, $80, $00, $00, $00, $01, $00, $F7, $36, $01, $00, $FD

      _A411_A629 ; 97/A629
        .byte $C0, $36, $01, $00, $FF

      _A411_A62E ; 97/A62E
        .byte $00, $22, $02, $00, $00, $00, $06, $01, $00, $F2, $02, $01, $04, $01, $06, $01
        .byte $08, $01, $0A, $01, $0C, $01, $0E, $01, $10, $01, $12, $01, $14, $01, $16, $01
        .byte $18, $01, $1A, $01, $1C, $01, $1E, $01, $20, $01, $22, $01, $24, $01, $26, $01
        .byte $28, $01, $2A, $01, $2C, $01, $00, $FD

      _A411_A666 ; 97/A666
        .byte $80, $2C, $01, $28, $01, $24, $01, $20, $01, $1C, $01, $18, $01, $14, $01, $10
        .byte $01, $0C, $01, $08, $01, $06, $01, $04, $01, $03, $01, $02, $02, $01, $02, $00
        .byte $03, $00, $FD

      _A411_A689 ; 97/A689
        .byte $80, $00, $FF

      _A411_A68C ; 97/A68C
        .byte $02, $03, $00, $00, $00, $00, $00, $01, $00, $F3, $02, $01, $00, $FD

      _A411_A69A ; 97/A69A
        .byte $80, $02, $08, $04, $04, $08, $02, $0C, $02, $10, $02, $14, $01, $18, $01, $1C
        .byte $01, $20, $00, $24, $00, $28, $00, $2C, $00, $30, $00, $34, $00, $38, $00, $3C
        .byte $00, $40, $00, $44, $00, $48, $01, $4C, $01, $00, $FD

      _A411_A6C5 ; 97/A6C5
        .byte $02, $03, $00, $02, $00, $00, $10, $01, $4C, $01, $00, $FD

      _A411_A6D1 ; 97/A6D1
        .byte $80, $4C, $01, $44, $01, $40, $00, $3C, $00, $38, $00, $34, $00, $30, $00, $2C
        .byte $00, $28, $00, $24, $00, $20, $00, $1C, $00, $18, $00, $14, $00, $10, $00, $0C
        .byte $01, $08, $01, $04, $02, $02, $02, $00, $FD

      _A411_A6FA ; 97/A6FA
        .byte $80, $01, $01, $00, $FF

      _A411_A6FF ; 97/A6FF
        .byte $02, $03, $00, $00, $00, $00, $00, $01, $00, $F3, $01, $01, $00, $FD

      _A411_A70D ; 97/A70D
        .byte $02, $03, $00, $00, $00, $00, $00, $01, $4C, $01, $00, $FD

      _A411_A719 ; 97/A719
        .byte $09, $03, $00, $00, $00, $00, $00, $01, $00, $F5, $01, $01, $00, $FD

      _A411_A727 ; 97/A727
        .byte $80, $02, $01, $03, $01, $04, $01, $05, $01, $06, $00, $07, $00, $08, $00, $09
        .byte $00, $0A, $00, $0B, $00, $0C, $00, $0D, $00, $0E, $00, $0F, $00, $10, $00, $11
        .byte $00, $12, $00, $13, $00, $14, $00, $15, $00, $16, $00, $17, $00, $18, $00, $19
        .byte $00, $1A, $00, $1B, $00, $1C, $00, $1D, $00, $1E, $00, $1F, $00, $20, $01, $22
        .byte $01, $24, $01, $26, $01, $28, $01, $2A, $01, $2C, $01, $2E, $01, $30, $01, $32
        .byte $01, $34, $01, $36, $01, $38, $01, $3A, $01, $3C, $01, $3E, $01, $40, $02, $44
        .byte $02, $48, $02, $4C, $02, $50, $02, $54, $02, $58, $02, $5C, $02, $60, $04, $64
        .byte $04, $68, $04, $6C, $04, $70, $04, $74, $04, $78, $04, $7C, $04, $00, $FF

      _A411_A7A6 ; 97/A7A6
        .byte $80, $01, $01, $00, $FF

      _A411_A7AB ; 97/A7AB
        .byte $01, $00, $03, $00, $00, $00, $00, $04, $00, $F5, $01, $01, $00, $FD

      _A411_A7B9 ; 97/A7B9
        .byte $00, $00, $03, $00, $00, $00, $00, $04, $00, $F2, $01, $01, $00, $FD

      aUnknown97A7C7 ; 97/A7C7
        .byte $80, $02, $01, $03, $01, $04, $01, $05, $01, $06, $00, $07, $00, $08, $00, $09
        .byte $00, $0A, $00, $0B, $00, $0C, $00, $0D, $00, $0E, $00, $0F, $00, $10, $00, $11
        .byte $00, $12, $00, $13, $00, $14, $00, $15, $00, $16, $00, $17, $00, $18, $00, $19
        .byte $00, $1A, $00, $1B, $00, $1C, $00, $1D, $00, $1E, $00, $1F, $00, $20, $01, $22
        .byte $01, $24, $01, $26, $01, $28, $01, $2A, $01, $2C, $01, $2E, $01, $30, $01, $32
        .byte $01, $34, $01, $36, $01, $38, $01, $3A, $01, $3C, $01, $3E, $01, $40, $02, $44
        .byte $02, $48, $02, $4C, $02, $50, $02, $54, $02, $58, $02, $5C, $02, $60, $04, $64
        .byte $04, $68, $04, $6C, $04, $70, $04, $74, $04, $78, $04, $00, $FF

      _A411_A844 ; 97/A844
        .byte $80, $02, $01, $03, $01, $04, $01, $05, $01, $06, $00, $07, $00, $08, $00, $09
        .byte $00, $0A, $00, $0B, $00, $0C, $00, $0D, $00, $0E, $00, $0F, $00, $10, $00, $11
        .byte $00, $12, $00, $13, $00, $14, $00, $15, $00, $16, $00, $17, $00, $18, $00, $19
        .byte $00, $1A, $00, $1B, $00, $1C, $00, $1D, $00, $1E, $00, $1F, $00, $20, $01, $22
        .byte $01, $24, $01, $26, $01, $28, $01, $2A, $01, $2C, $01, $2E, $01, $30, $01, $32
        .byte $01, $34, $01, $36, $01, $38, $01, $3A, $01, $3C, $01, $3E, $01, $40, $02, $44
        .byte $02, $48, $02, $4C, $02, $50, $02, $54, $02, $58, $02, $5C, $02, $60, $03, $64
        .byte $03, $68, $03, $6C, $03, $70, $03, $74, $03, $78, $03, $7C, $03, $80, $05, $88
        .byte $05, $90, $05, $98, $05, $A0, $05, $A8, $05, $00, $FF

      _A411_A8CF ; 97/A8CF
        .byte $0A, $33, $00, $00, $00, $00, $02, $01, $00, $F0, $01, $00, $00, $FD

      _A411_A8DD ; 97/A8DD
        .byte $80, $02, $00, $04, $00, $08, $00, $0C, $00, $10, $00, $14, $00, $18, $00, $1C
        .byte $00, $20, $00, $24, $00, $28, $00, $2C, $00, $30, $00, $34, $00, $38, $00, $3C
        .byte $00, $40, $00, $44, $00, $48, $00, $4C, $00, $50, $00, $54, $00, $58, $00, $5C
        .byte $00, $60, $00, $64, $00, $68, $00, $6C, $00, $70, $00, $74, $00, $78, $00, $7C
        .byte $00, $80, $00, $88, $00, $90, $00, $98, $00, $A0, $00, $A8, $00, $B0, $00, $B8
        .byte $00, $C0, $00, $C8, $00, $00, $FF

      _A411_A934 ; 97/A934
        .byte $02, $00, $00, $30, $00, $00, $03, $00, $00, $F7, $02, $01, $00, $FD

      _A411_A942 ; 97/A942
        .byte $80, $02, $08, $04, $08, $06, $06, $08, $04, $0A, $04, $0C, $04, $0E, $04, $10
        .byte $04, $12, $04, $14, $04, $16, $04, $18, $04, $1A, $04, $1C, $04, $1E, $04, $20
        .byte $04, $22, $04, $24, $04, $26, $04, $28, $04, $2A, $04, $2C, $04, $2E, $04, $30
        .byte $04, $32, $04, $34, $04, $36, $04, $38, $04, $3A, $04, $3C, $04, $3E, $04, $40
        .byte $04, $00, $FD

      _A411_A985 ; 97/A985
        .byte $80, $3C, $02, $38, $02, $34, $01, $30, $01, $2C, $00, $28, $00, $24, $00, $20
        .byte $00, $1C, $00, $18, $00, $14, $00, $10, $00, $0C, $01, $08, $01, $04, $02, $02
        .byte $02, $00, $FD

        ; 97/A9A8

      aBattleScenePaletteEffects ; 97/A9A8

        ; Palette effect offset table (191 entries).

        .word aUnknown97AF21._A9A8_AFC8 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AFD0 - aBattleScenePaletteEffects
        .word _A9A8_AB26 - aBattleScenePaletteEffects
        .word _A9A8_AB2D - aBattleScenePaletteEffects
        .word _A9A8_AB34 - aBattleScenePaletteEffects
        .word _A9A8_AB3B - aBattleScenePaletteEffects
        .word _A9A8_AB42 - aBattleScenePaletteEffects
        .word _A9A8_AB46 - aBattleScenePaletteEffects
        .word _A9A8_AB4B - aBattleScenePaletteEffects
        .word _A9A8_AB52 - aBattleScenePaletteEffects
        .word _A9A8_AB56 - aBattleScenePaletteEffects
        .word _A9A8_AB5D - aBattleScenePaletteEffects
        .word _A9A8_AB61 - aBattleScenePaletteEffects
        .word _A9A8_AB68 - aBattleScenePaletteEffects
        .word _A9A8_AB6C - aBattleScenePaletteEffects
        .word _A9A8_AB73 - aBattleScenePaletteEffects
        .word _A9A8_AB7A - aBattleScenePaletteEffects
        .word _A9A8_AB81 - aBattleScenePaletteEffects
        .word _A9A8_AB89 - aBattleScenePaletteEffects
        .word _A9A8_AB91 - aBattleScenePaletteEffects
        .word _A9A8_AB99 - aBattleScenePaletteEffects
        .word _A9A8_AB9D - aBattleScenePaletteEffects
        .word _A9A8_ABA4 - aBattleScenePaletteEffects
        .word _A9A8_ABAB - aBattleScenePaletteEffects
        .word _A9A8_ABB2 - aBattleScenePaletteEffects
        .word _A9A8_ABB9 - aBattleScenePaletteEffects
        .word _A9A8_ABC0 - aBattleScenePaletteEffects
        .word _A9A8_ABC5 - aBattleScenePaletteEffects
        .word _A9A8_ABCA - aBattleScenePaletteEffects
        .word _A9A8_ABCF - aBattleScenePaletteEffects
        .word _A9A8_ABD3 - aBattleScenePaletteEffects
        .word _A9A8_ABDB - aBattleScenePaletteEffects
        .word _A9A8_ABE3 - aBattleScenePaletteEffects
        .word _A9A8_ABEB - aBattleScenePaletteEffects
        .word _A9A8_ABEF - aBattleScenePaletteEffects
        .word _A9A8_ABF6 - aBattleScenePaletteEffects
        .word _A9A8_ABFA - aBattleScenePaletteEffects
        .word _A9A8_AC01 - aBattleScenePaletteEffects
        .word _A9A8_AC08 - aBattleScenePaletteEffects
        .word _A9A8_AC10 - aBattleScenePaletteEffects
        .word _A9A8_AC15 - aBattleScenePaletteEffects
        .word _A9A8_AC1C - aBattleScenePaletteEffects
        .word _A9A8_AC23 - aBattleScenePaletteEffects
        .word _A9A8_AC2A - aBattleScenePaletteEffects
        .word _A9A8_AC31 - aBattleScenePaletteEffects
        .word _A9A8_AC38 - aBattleScenePaletteEffects
        .word _A9A8_AC3F - aBattleScenePaletteEffects
        .word _A9A8_AC46 - aBattleScenePaletteEffects
        .word _A9A8_AC4D - aBattleScenePaletteEffects
        .word _A9A8_AC54 - aBattleScenePaletteEffects
        .word _A9A8_AC5B - aBattleScenePaletteEffects
        .word _A9A8_AC62 - aBattleScenePaletteEffects
        .word _A9A8_AC69 - aBattleScenePaletteEffects
        .word _A9A8_AC70 - aBattleScenePaletteEffects
        .word _A9A8_AC77 - aBattleScenePaletteEffects
        .word _A9A8_AC7E - aBattleScenePaletteEffects
        .word _A9A8_AC85 - aBattleScenePaletteEffects
        .word _A9A8_AC8C - aBattleScenePaletteEffects
        .word _A9A8_AC93 - aBattleScenePaletteEffects
        .word _A9A8_AC9A - aBattleScenePaletteEffects
        .word _A9A8_ACA1 - aBattleScenePaletteEffects
        .word _A9A8_ACA8 - aBattleScenePaletteEffects
        .word _A9A8_ACAF - aBattleScenePaletteEffects
        .word _A9A8_ACB6 - aBattleScenePaletteEffects
        .word _A9A8_ACBD - aBattleScenePaletteEffects
        .word _A9A8_ACC4 - aBattleScenePaletteEffects
        .word _A9A8_ACCB - aBattleScenePaletteEffects
        .word _A9A8_ACD2 - aBattleScenePaletteEffects
        .word _A9A8_ACD9 - aBattleScenePaletteEffects
        .word _A9A8_ACE0 - aBattleScenePaletteEffects
        .word _A9A8_ACE7 - aBattleScenePaletteEffects
        .word _A9A8_ACEE - aBattleScenePaletteEffects
        .word _A9A8_ACF6 - aBattleScenePaletteEffects
        .word _A9A8_ACFA - aBattleScenePaletteEffects
        .word _A9A8_AD01 - aBattleScenePaletteEffects
        .word _A9A8_AD08 - aBattleScenePaletteEffects
        .word _A9A8_AD0F - aBattleScenePaletteEffects
        .word _A9A8_AD16 - aBattleScenePaletteEffects
        .word _A9A8_AD1D - aBattleScenePaletteEffects
        .word _A9A8_AD24 - aBattleScenePaletteEffects
        .word _A9A8_AD2B - aBattleScenePaletteEffects
        .word _A9A8_AD32 - aBattleScenePaletteEffects
        .word _A9A8_AD39 - aBattleScenePaletteEffects
        .word _A9A8_AD40 - aBattleScenePaletteEffects
        .word _A9A8_AD47 - aBattleScenePaletteEffects
        .word _A9A8_AD4E - aBattleScenePaletteEffects
        .word _A9A8_AD53 - aBattleScenePaletteEffects
        .word _A9A8_AD5A - aBattleScenePaletteEffects
        .word _A9A8_AD61 - aBattleScenePaletteEffects
        .word _A9A8_AD68 - aBattleScenePaletteEffects
        .word _A9A8_AD6F - aBattleScenePaletteEffects
        .word _A9A8_AD76 - aBattleScenePaletteEffects
        .word _A9A8_AD7D - aBattleScenePaletteEffects
        .word _A9A8_AD84 - aBattleScenePaletteEffects
        .word _A9A8_AD8B - aBattleScenePaletteEffects
        .word _A9A8_AD8F - aBattleScenePaletteEffects
        .word _A9A8_AD93 - aBattleScenePaletteEffects
        .word _A9A8_AD97 - aBattleScenePaletteEffects
        .word _A9A8_AD9E - aBattleScenePaletteEffects
        .word _A9A8_ADA6 - aBattleScenePaletteEffects
        .word _A9A8_ADAB - aBattleScenePaletteEffects
        .word _A9A8_ADAF - aBattleScenePaletteEffects
        .word _A9A8_ADB6 - aBattleScenePaletteEffects
        .word _A9A8_ADBD - aBattleScenePaletteEffects
        .word _A9A8_ADC4 - aBattleScenePaletteEffects
        .word _A9A8_ADC8 - aBattleScenePaletteEffects
        .word _A9A8_ADCC - aBattleScenePaletteEffects
        .word _A9A8_ADD3 - aBattleScenePaletteEffects
        .word _A9A8_ADDA - aBattleScenePaletteEffects
        .word _A9A8_ADDE - aBattleScenePaletteEffects
        .word _A9A8_ADE6 - aBattleScenePaletteEffects
        .word _A9A8_ADEB - aBattleScenePaletteEffects
        .word _A9A8_ADEF - aBattleScenePaletteEffects
        .word _A9A8_ADF7 - aBattleScenePaletteEffects
        .word _A9A8_ADFC - aBattleScenePaletteEffects
        .word _A9A8_AE03 - aBattleScenePaletteEffects
        .word aUnknown97AE0A - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE11 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE15 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE1D - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE22 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE27 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE2B - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE2F - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE37 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE3E - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE45 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE4C - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE54 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE5B - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE5F - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE63 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE6A - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE71 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE78 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE7F - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE86 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE8D - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE94 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE9B - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AE9F - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AEA6 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AEAD - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AEB2 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AEBA - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AEBF - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AEC3 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AEC7 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AECF - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AED3 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AEDB - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AEE0 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AEE5 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AEE9 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AEF1 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AEF9 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AF01 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AF09 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AF11 - aBattleScenePaletteEffects
        .word aUnknown97AE0A._A9A8_AF19 - aBattleScenePaletteEffects
        .word aUnknown97AF21 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF26 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF2D - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF32 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF39 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF40 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF47 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF4E - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF55 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF5C - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF63 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF6A - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF71 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF78 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF80 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF85 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF89 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF91 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF96 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF9B - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AF9F - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AFA6 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AFAE - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AFB3 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AFB8 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AFC0 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AFC4 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AFC8 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AFD0 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AFD5 - aBattleScenePaletteEffects
        .word aUnknown97AF21._A9A8_AFDD - aBattleScenePaletteEffects

      _A9A8_AB26 ; 97/AB26
        PALETTE_EFFECT $02, $01, $21, $07, aUnknown9BC16F

      _A9A8_AB2D ; 97/AB2D
        PALETTE_EFFECT $02, $01, $21, $07, aUnknown9BC1BB

      _A9A8_AB34 ; 97/AB34
        PALETTE_EFFECT $02, $02, $21, $07, aUnknown9BC1DD

      _A9A8_AB3B ; 97/AB3B
        PALETTE_EFFECT $02, $02, $21, $07, aUnknown9BC1FF

      _A9A8_AB42 ; 97/AB42
        PALETTE_EFFECT_NO_DATA $02, $08, $21, $07

      _A9A8_AB46 ; 97/AB46
        PALETTE_EFFECT_VALUE $02, $05, $31, $2F, $01

      _A9A8_AB4B ; 97/AB4B
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BC241

      _A9A8_AB52 ; 97/AB52
        PALETTE_EFFECT_NO_DATA $02, $08, $21, $0F

      _A9A8_AB56 ; 97/AB56
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BC265

      _A9A8_AB5D ; 97/AB5D
        PALETTE_EFFECT_NO_DATA $02, $08, $21, $0F

      _A9A8_AB61 ; 97/AB61
        PALETTE_EFFECT $02, $02, $24, $0C, aUnknown9BC2E7

      _A9A8_AB68 ; 97/AB68
        PALETTE_EFFECT_NO_DATA $02, $08, $21, $0F

      _A9A8_AB6C ; 97/AB6C
        PALETTE_EFFECT $02, $00, $21, $0F, aUnknown9BC31B

      _A9A8_AB73 ; 97/AB73
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BC42E

      _A9A8_AB7A ; 97/AB7A
        PALETTE_EFFECT $02, $00, $21, $0F, aUnknown9BC450

      _A9A8_AB81 ; 97/AB81
        PALETTE_EFFECT_VALUE_DATA $03, $07, $31, $2F, $04, $7FF636

      _A9A8_AB89 ; 97/AB89
        PALETTE_EFFECT_VALUE_DATA $03, $07, $31, $2F, $00, $7FFE62

      _A9A8_AB91 ; 97/AB91
        PALETTE_EFFECT_VALUE_DATA $03, $07, $31, $2F, $01, $7FF636

      _A9A8_AB99 ; 97/AB99
        PALETTE_EFFECT_NO_DATA $02, $08, $21, $0F

      _A9A8_AB9D ; 97/AB9D
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BC59F

      _A9A8_ABA4 ; 97/ABA4
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BC601

      _A9A8_ABAB ; 97/ABAB
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BC643

      _A9A8_ABB2 ; 97/ABB2
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BC6A5

      _A9A8_ABB9 ; 97/ABB9
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BC6E8

      _A9A8_ABC0 ; 97/ABC0
        PALETTE_EFFECT_VALUE $03, $06, $31, $2F, $00

      _A9A8_ABC5 ; 97/ABC5
        PALETTE_EFFECT_VALUE $04, $06, $11, $03, $00

      _A9A8_ABCA ; 97/ABCA
        PALETTE_EFFECT_VALUE $05, $06, $00, $01, $00

      _A9A8_ABCF ; 97/ABCF
        PALETTE_EFFECT_NO_DATA $02, $08, $21, $0F

      _A9A8_ABD3 ; 97/ABD3
        PALETTE_EFFECT_VALUE_DATA $02, $07, $21, $08, $01, aUnknownE02090

      _A9A8_ABDB ; 97/ABDB
        PALETTE_EFFECT_VALUE_DATA $02, $07, $31, $2F, $01, $7FF636

      _A9A8_ABE3 ; 97/ABE3
        PALETTE_EFFECT_VALUE_DATA $02, $07, $31, $2F, $00, $7FF636

      _A9A8_ABEB ; 97/ABEB
        PALETTE_EFFECT_NO_DATA $02, $09, $31, $2F

      _A9A8_ABEF ; 97/ABEF
        PALETTE_EFFECT $02, $01, $21, $08, aUnknown9BC82A

      _A9A8_ABF6 ; 97/ABF6
        PALETTE_EFFECT_NO_DATA $02, $08, $21, $0F

      _A9A8_ABFA ; 97/ABFA
        PALETTE_EFFECT $02, $00, $21, $0F, aUnknown9BC92C

      _A9A8_AC01 ; 97/AC01
        PALETTE_EFFECT $02, $0A, $31, $2F, $7FFE62

      _A9A8_AC08 ; 97/AC08
        PALETTE_EFFECT_VALUE_DATA $03, $07, $31, $2F, $00, $7FF636

      _A9A8_AC10 ; 97/AC10
        PALETTE_EFFECT_VALUE $02, $05, $C1, $3F, $03

      _A9A8_AC15 ; 97/AC15
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BCB6B

      _A9A8_AC1C ; 97/AC1C
        PALETTE_EFFECT $02, $0A, $31, $2F, $7FF636

      _A9A8_AC23 ; 97/AC23
        PALETTE_EFFECT $02, $02, $21, $0A, aUnknown9BCBAD

      _A9A8_AC2A ; 97/AC2A
        PALETTE_EFFECT $03, $02, $2B, $05, aUnknown9BCBC3

      _A9A8_AC31 ; 97/AC31
        PALETTE_EFFECT $04, $02, $1B, $05, aUnknown9BCBD7

      _A9A8_AC38 ; 97/AC38
        PALETTE_EFFECT $05, $02, $11, $0A, aUnknown9BCBED

      _A9A8_AC3F ; 97/AC3F
        PALETTE_EFFECT $02, $01, $21, $0A, aUnknown9BCC03

      _A9A8_AC46 ; 97/AC46
        PALETTE_EFFECT $03, $01, $2B, $05, aUnknown9BCC19

      _A9A8_AC4D ; 97/AC4D
        PALETTE_EFFECT $04, $01, $1B, $05, aUnknown9BCC45

      _A9A8_AC54 ; 97/AC54
        PALETTE_EFFECT $05, $01, $11, $0A, aUnknown9BCC73

      _A9A8_AC5B ; 97/AC5B
        PALETTE_EFFECT $02, $02, $21, $0A, aUnknown9BCC89

      _A9A8_AC62 ; 97/AC62
        PALETTE_EFFECT $03, $02, $2B, $05, aUnknown9BCC9F

      _A9A8_AC69 ; 97/AC69
        PALETTE_EFFECT $04, $02, $1B, $05, aUnknown9BCCB3

      _A9A8_AC70 ; 97/AC70
        PALETTE_EFFECT $05, $02, $11, $0A, aUnknown9BCCCF

      _A9A8_AC77 ; 97/AC77
        PALETTE_EFFECT $02, $01, $21, $0A, aUnknown9BCCE5

      _A9A8_AC7E ; 97/AC7E
        PALETTE_EFFECT $03, $01, $2B, $05, aUnknown9BCD0F

      _A9A8_AC85 ; 97/AC85
        PALETTE_EFFECT $04, $01, $1B, $05, aUnknown9BCD2D

      _A9A8_AC8C ; 97/AC8C
        PALETTE_EFFECT $05, $01, $11, $0A, aUnknown9BCD4B

      _A9A8_AC93 ; 97/AC93
        PALETTE_EFFECT $02, $01, $21, $0E, aUnknown9BCD75

      _A9A8_AC9A ; 97/AC9A
        PALETTE_EFFECT $03, $01, $2F, $01, aUnknown9BCDB7

      _A9A8_ACA1 ; 97/ACA1
        PALETTE_EFFECT $02, $01, $21, $0E, aUnknown9BCDF9

      _A9A8_ACA8 ; 97/ACA8
        PALETTE_EFFECT $03, $01, $2F, $01, aUnknown9BCE3B

      _A9A8_ACAF ; 97/ACAF
        PALETTE_EFFECT $02, $01, $21, $0E, aUnknown9BCE7D

      _A9A8_ACB6 ; 97/ACB6
        PALETTE_EFFECT $03, $01, $2F, $01, aUnknown9BCEBF

      _A9A8_ACBD ; 97/ACBD
        PALETTE_EFFECT $02, $01, $21, $08, aUnknown9BCF01

      _A9A8_ACC4 ; 97/ACC4
        PALETTE_EFFECT $02, $01, $21, $08, aUnknown9BCF25

      _A9A8_ACCB ; 97/ACCB
        PALETTE_EFFECT $02, $01, $21, $0E, aUnknown9BCF26

      _A9A8_ACD2 ; 97/ACD2
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BCF68

      _A9A8_ACD9 ; 97/ACD9
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BCFAA

      _A9A8_ACE0 ; 97/ACE0
        PALETTE_EFFECT $02, $01, $21, $07, aUnknown9BCFEC

      _A9A8_ACE7 ; 97/ACE7
        PALETTE_EFFECT $03, $01, $2A, $06, aUnknown9BD02E

      _A9A8_ACEE ; 97/ACEE
        PALETTE_EFFECT_VALUE_DATA $03, $07, $C1, $3E, $04, $7FFF82

      _A9A8_ACF6 ; 97/ACF6
        PALETTE_EFFECT_NO_DATA $03, $09, $C1, $3E

      _A9A8_ACFA ; 97/ACFA
        PALETTE_EFFECT $02, $02, $31, $0F, aUnknown9BD72E

      _A9A8_AD01 ; 97/AD01
        PALETTE_EFFECT $02, $02, $31, $0F, aUnknown9BD6EC

      _A9A8_AD08 ; 97/AD08
        PALETTE_EFFECT $02, $02, $31, $0F, aUnknown9BD790

      _A9A8_AD0F ; 97/AD0F
        PALETTE_EFFECT $03, $01, $21, $0F, aUnknown9BD51D

      _A9A8_AD16 ; 97/AD16
        PALETTE_EFFECT $03, $01, $21, $0F, aUnknown9BD4BC

      _A9A8_AD1D ; 97/AD1D
        PALETTE_EFFECT $03, $01, $21, $0F, aUnknown9BD5E4

      _A9A8_AD24 ; 97/AD24
        PALETTE_EFFECT $02, $02, $21, $0F, aUnknown9BD3C5

      _A9A8_AD2B ; 97/AD2B
        PALETTE_EFFECT $02, $02, $21, $0F, aUnknown9BD385

      _A9A8_AD32 ; 97/AD32
        PALETTE_EFFECT $02, $02, $21, $0F, aUnknown9BD3A5

      _A9A8_AD39 ; 97/AD39
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BD80C

      _A9A8_AD40 ; 97/AD40
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BD7F2

      _A9A8_AD47 ; 97/AD47
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BD826

      _A9A8_AD4E ; 97/AD4E
        PALETTE_EFFECT_NO_DATA $04, $08, $31, $2F
        .byte $01 ; type 8 reads nothing more: this byte is not part of the entry

      _A9A8_AD53 ; 97/AD53
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BD03C

      _A9A8_AD5A ; 97/AD5A
        PALETTE_EFFECT $03, $01, $31, $0F, aUnknown9BD056

      _A9A8_AD61 ; 97/AD61
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BD078

      _A9A8_AD68 ; 97/AD68
        PALETTE_EFFECT $03, $01, $31, $0F, aUnknown9BD092

      _A9A8_AD6F ; 97/AD6F
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BD0B4

      _A9A8_AD76 ; 97/AD76
        PALETTE_EFFECT $03, $01, $31, $0F, aUnknown9BD0F8

      _A9A8_AD7D ; 97/AD7D
        PALETTE_EFFECT $02, $00, $41, $0F, aUnknown9BD158

      _A9A8_AD84 ; 97/AD84
        PALETTE_EFFECT $03, $02, $21, $0F, aUnknown9BD324

      _A9A8_AD8B ; 97/AD8B
        PALETTE_EFFECT_NO_DATA $02, $08, $21, $1F

      _A9A8_AD8F ; 97/AD8F
        PALETTE_EFFECT_NO_DATA $02, $08, $31, $1F

      _A9A8_AD93 ; 97/AD93
        PALETTE_EFFECT_NO_DATA $02, $08, $31, $2F

      _A9A8_AD97 ; 97/AD97
        PALETTE_EFFECT $02, $01, $21, $0E, aUnknown9BD364

      _A9A8_AD9E ; 97/AD9E
        PALETTE_EFFECT_VALUE_DATA $03, $07, $11, $0F, $00, aUnknownE02138

      _A9A8_ADA6 ; 97/ADA6
        PALETTE_EFFECT_VALUE $03, $05, $11, $0F, $00

      _A9A8_ADAB ; 97/ADAB
        PALETTE_EFFECT_NO_DATA $03, $08, $11, $0F

      _A9A8_ADAF ; 97/ADAF
        PALETTE_EFFECT $03, $02, $41, $0F, aUnknown9BD3F9

      _A9A8_ADB6 ; 97/ADB6
        PALETTE_EFFECT $03, $02, $41, $0F, aUnknown9BD365

      _A9A8_ADBD ; 97/ADBD
        PALETTE_EFFECT $03, $02, $41, $0F, aUnknown9BD41B

      _A9A8_ADC4 ; 97/ADC4
        PALETTE_EFFECT_NO_DATA $02, $08, $21, $0F

      _A9A8_ADC8 ; 97/ADC8
        PALETTE_EFFECT_NO_DATA $02, $08, $41, $0F

      _A9A8_ADCC ; 97/ADCC
        PALETTE_EFFECT $04, $01, $00, $01, aUnknown9BD43B

      _A9A8_ADD3 ; 97/ADD3
        PALETTE_EFFECT $03, $00, $31, $2F, aUnknown9BD45D

      _A9A8_ADDA ; 97/ADDA
        PALETTE_EFFECT_NO_DATA $02, $08, $31, $0F

      _A9A8_ADDE ; 97/ADDE
        PALETTE_EFFECT_VALUE_DATA $02, $07, $31, $0F, $03, aUnknownE02299

      _A9A8_ADE6 ; 97/ADE6
        PALETTE_EFFECT_VALUE $02, $05, $21, $1F, $03

      _A9A8_ADEB ; 97/ADEB
        PALETTE_EFFECT_NO_DATA $02, $08, $21, $2F

      _A9A8_ADEF ; 97/ADEF
        PALETTE_EFFECT_VALUE_DATA $02, $07, $31, $1F, $02, aUnknownE0221D

      _A9A8_ADF7 ; 97/ADF7
        PALETTE_EFFECT_VALUE $02, $06, $31, $1F, $01

      _A9A8_ADFC ; 97/ADFC
        PALETTE_EFFECT $02, $01, $00, $01, aUnknown9BD646

      _A9A8_AE03 ; 97/AE03
        PALETTE_EFFECT $02, $00, $31, $2F, aUnknown9BD64A

      aUnknown97AE0A ; 97/AE0A
        PALETTE_EFFECT $04, $01, $11, $01, aUnknown9BD6AA

      _A9A8_AE11 ; 97/AE11
        PALETTE_EFFECT_NO_DATA $03, $08, $21, $3F

      _A9A8_AE15 ; 97/AE15
        PALETTE_EFFECT_VALUE_DATA $03, $07, $31, $2F, $03, aUnknownE02315

      _A9A8_AE1D ; 97/AE1D
        PALETTE_EFFECT_VALUE $03, $05, $31, $2F, $03

      _A9A8_AE22 ; 97/AE22
        PALETTE_EFFECT_VALUE $04, $05, $11, $0F, $03

      _A9A8_AE27 ; 97/AE27
        PALETTE_EFFECT_NO_DATA $02, $08, $11, $1F

      _A9A8_AE2B ; 97/AE2B
        PALETTE_EFFECT_NO_DATA $02, $08, $21, $2F

      _A9A8_AE2F ; 97/AE2F
        PALETTE_EFFECT_VALUE_DATA $03, $07, $31, $1F, $04, aUnknownE02373

      _A9A8_AE37 ; 97/AE37
        PALETTE_EFFECT $02, $01, $21, $0E, aUnknown9BD85C

      _A9A8_AE3E ; 97/AE3E
        PALETTE_EFFECT $02, $01, $21, $0E, aUnknown9BD876

      _A9A8_AE45 ; 97/AE45
        PALETTE_EFFECT $03, $01, $2F, $01, aUnknown9BD8AC

      _A9A8_AE4C ; 97/AE4C
        PALETTE_EFFECT_VALUE_DATA $04, $07, $31, $1F, $01, $7FF636

      _A9A8_AE54 ; 97/AE54
        PALETTE_EFFECT $03, $01, $00, $01, aUnknown9BD8C4

      _A9A8_AE5B ; 97/AE5B
        PALETTE_EFFECT_NO_DATA $02, $08, $00, $01

      _A9A8_AE5F ; 97/AE5F
        PALETTE_EFFECT_NO_DATA $02, $08, $21, $0F

      _A9A8_AE63 ; 97/AE63
        PALETTE_EFFECT $02, $02, $21, $0F, aUnknown9BD8C8

      _A9A8_AE6A ; 97/AE6A
        PALETTE_EFFECT $02, $02, $21, $0F, aUnknown9BD8E2

      _A9A8_AE71 ; 97/AE71
        PALETTE_EFFECT $02, $02, $21, $0F, aUnknown9BD914

      _A9A8_AE78 ; 97/AE78
        PALETTE_EFFECT $02, $01, $1C, $04, aUnknown9BD962

      _A9A8_AE7F ; 97/AE7F
        PALETTE_EFFECT $02, $01, $1C, $04, aUnknown9BD978

      _A9A8_AE86 ; 97/AE86
        PALETTE_EFFECT $02, $01, $1C, $04, aUnknown9BD98E

      _A9A8_AE8D ; 97/AE8D
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BD99A

      _A9A8_AE94 ; 97/AE94
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BD9B4

      _A9A8_AE9B ; 97/AE9B
        PALETTE_EFFECT_NO_DATA $02, $08, $1C, $14

      _A9A8_AE9F ; 97/AE9F
        PALETTE_EFFECT $02, $0C, $21, $07, aUnknown9BCFEC

      _A9A8_AEA6 ; 97/AEA6
        PALETTE_EFFECT $03, $0C, $2A, $06, aUnknown9BD02E

      _A9A8_AEAD ; 97/AEAD
        PALETTE_EFFECT_VALUE $04, $06, $28, $02, $04

      _A9A8_AEB2 ; 97/AEB2
        PALETTE_EFFECT_VALUE_DATA $04, $07, $28, $02, $04, aUnknownE02080

      _A9A8_AEBA ; 97/AEBA
        PALETTE_EFFECT_VALUE $05, $05, $81, $3E, $04

      _A9A8_AEBF ; 97/AEBF
        PALETTE_EFFECT_NO_DATA $05, $08, $C1, $3F

      _A9A8_AEC3 ; 97/AEC3
        PALETTE_EFFECT_NO_DATA $05, $09, $C1, $3F

      _A9A8_AEC7 ; 97/AEC7
        PALETTE_EFFECT_VALUE_DATA $05, $07, $C1, $3F, $04, $7FFF82

      _A9A8_AECF ; 97/AECF
        PALETTE_EFFECT_NO_DATA $06, $08, $51, $0F

      _A9A8_AED3 ; 97/AED3
        PALETTE_EFFECT_VALUE_DATA $06, $07, $51, $0F, $04, aUnknownE027A5

      _A9A8_AEDB ; 97/AEDB
        PALETTE_EFFECT_VALUE $06, $06, $51, $0F, $04

      _A9A8_AEE0 ; 97/AEE0
        PALETTE_EFFECT_VALUE $07, $06, $BF, $01, $03

      _A9A8_AEE5 ; 97/AEE5
        PALETTE_EFFECT_NO_DATA $07, $09, $FF, $01

      _A9A8_AEE9 ; 97/AEE9
        PALETTE_EFFECT_VALUE_DATA $00, $07, $01, $0F, $08, $7FFE02

      _A9A8_AEF1 ; 97/AEF1
        PALETTE_EFFECT_VALUE_DATA $01, $07, $71, $0F, $08, $7FFEE2

      _A9A8_AEF9 ; 97/AEF9
        PALETTE_EFFECT_VALUE_DATA $02, $07, $11, $0F, $08, $7FFE22

      _A9A8_AF01 ; 97/AF01
        PALETTE_EFFECT_VALUE_DATA $03, $07, $61, $0F, $08, $7FFEC2

      _A9A8_AF09 ; 97/AF09
        PALETTE_EFFECT_VALUE_DATA $08, $07, $31, $1F, $08, aWorldMapMarkerPalette

      _A9A8_AF11 ; 97/AF11
        PALETTE_EFFECT_VALUE_DATA $08, $07, $31, $1F, $0A, $7ECBC8

      _A9A8_AF19 ; 97/AF19
        PALETTE_EFFECT_VALUE_DATA $08, $07, $31, $1F, $06, $7FFE62

      aUnknown97AF21 ; 97/AF21
        PALETTE_EFFECT_VALUE $09, $03, $FA, $05, $02

      _A9A8_AF26 ; 97/AF26
        PALETTE_EFFECT $03, $02, $19, $07, aUnknown9BD9F2

      _A9A8_AF2D ; 97/AF2D
        PALETTE_EFFECT_VALUE $03, $05, $21, $0F, $00

      _A9A8_AF32 ; 97/AF32
        PALETTE_EFFECT $02, $01, $21, $07, aUnknown9BDA02

      _A9A8_AF39 ; 97/AF39
        PALETTE_EFFECT $02, $01, $21, $07, aUnknown9BDA52

      _A9A8_AF40 ; 97/AF40
        PALETTE_EFFECT $02, $01, $21, $07, aUnknown9BDA74

      _A9A8_AF47 ; 97/AF47
        PALETTE_EFFECT $02, $01, $21, $07, aUnknown9BDA96

      _A9A8_AF4E ; 97/AF4E
        PALETTE_EFFECT $02, $01, $21, $07, aUnknown9BDAD8

      _A9A8_AF55 ; 97/AF55
        PALETTE_EFFECT $02, $01, $21, $07, aUnknown9BDB08

      _A9A8_AF5C ; 97/AF5C
        PALETTE_EFFECT $02, $01, $21, $07, aUnknown9BDB2A

      _A9A8_AF63 ; 97/AF63
        PALETTE_EFFECT $02, $01, $21, $07, aUnknown9BDB4C

      _A9A8_AF6A ; 97/AF6A
        PALETTE_EFFECT $02, $02, $24, $0C, aUnknown9BDB8C

      _A9A8_AF71 ; 97/AF71
        PALETTE_EFFECT $02, $02, $24, $0C, aUnknown9BDBB0

      _A9A8_AF78 ; 97/AF78
        PALETTE_EFFECT_VALUE_DATA $03, $07, $21, $03, $04, aUnknownE0207A

      _A9A8_AF80 ; 97/AF80
        PALETTE_EFFECT_VALUE $03, $05, $21, $03, $01

      _A9A8_AF85 ; 97/AF85
        PALETTE_EFFECT_NO_DATA $03, $08, $21, $0F

      _A9A8_AF89 ; 97/AF89
        PALETTE_EFFECT_VALUE_DATA $03, $07, $21, $0F, $02, aUnknownE022B7

      _A9A8_AF91 ; 97/AF91
        PALETTE_EFFECT_VALUE $03, $05, $21, $0F, $02

      _A9A8_AF96 ; 97/AF96
        PALETTE_EFFECT_VALUE $02, $05, $00, $01, $01

      _A9A8_AF9B ; 97/AF9B
        PALETTE_EFFECT_NO_DATA $02, $08, $11, $1F

      _A9A8_AF9F ; 97/AF9F
        PALETTE_EFFECT $02, $01, $21, $0F, aUnknown9BDBE2

      _A9A8_AFA6 ; 97/AFA6
        PALETTE_EFFECT_VALUE_DATA $03, $07, $11, $03, $02, aUnknownE02156

      _A9A8_AFAE ; 97/AFAE
        PALETTE_EFFECT_VALUE $03, $05, $11, $03, $02

      _A9A8_AFB3 ; 97/AFB3
        PALETTE_EFFECT_VALUE $02, $05, $21, $0F, $00

      _A9A8_AFB8 ; 97/AFB8
        PALETTE_EFFECT_VALUE_DATA $03, $07, $31, $2F, $04, $7FF636

      _A9A8_AFC0 ; 97/AFC0
        PALETTE_EFFECT_NO_DATA $02, $08, $21, $0F

      _A9A8_AFC4 ; 97/AFC4
        PALETTE_EFFECT_NO_DATA $02, $08, $11, $1F

      _A9A8_AFC8 ; 97/AFC8
        PALETTE_EFFECT_VALUE_DATA $02, $07, $11, $1F, $00, aUnknownE0215C

      _A9A8_AFD0 ; 97/AFD0
        PALETTE_EFFECT_VALUE $02, $05, $11, $1F, $00

      _A9A8_AFD5 ; 97/AFD5
        PALETTE_EFFECT_VALUE_DATA $02, $07, $11, $1F, $0C, $7FE6DD

      _A9A8_AFDD ; 97/AFDD
        PALETTE_EFFECT_VALUE_DATA $03, $07, $31, $2F, $08, $7FF636

        ; 97/AFE5

      aUnknown97AFE5 ; 97/AFE5

        ; Command 14 palette copy table (23 entries).

        .word _AFE5_B013 - aUnknown97AFE5
        .word _AFE5_B018 - aUnknown97AFE5
        .word _AFE5_B01D - aUnknown97AFE5
        .word _AFE5_B022 - aUnknown97AFE5
        .word _AFE5_B027 - aUnknown97AFE5
        .word _AFE5_B02C - aUnknown97AFE5
        .word _AFE5_B02C - aUnknown97AFE5
        .word _AFE5_B031 - aUnknown97AFE5
        .word _AFE5_B036 - aUnknown97AFE5
        .word _AFE5_B03B - aUnknown97AFE5
        .word _AFE5_B040 - aUnknown97AFE5
        .word _AFE5_B045 - aUnknown97AFE5
        .word _AFE5_B04A - aUnknown97AFE5
        .word _AFE5_B04F - aUnknown97AFE5
        .word _AFE5_B054 - aUnknown97AFE5
        .word _AFE5_B059 - aUnknown97AFE5
        .word _AFE5_B05E - aUnknown97AFE5
        .word _AFE5_B063 - aUnknown97AFE5
        .word _AFE5_B068 - aUnknown97AFE5
        .word _AFE5_B06D - aUnknown97AFE5
        .word _AFE5_B072 - aUnknown97AFE5
        .word _AFE5_B077 - aUnknown97AFE5
        .word _AFE5_B07C - aUnknown97AFE5

      _AFE5_B013 ; 97/B013
        .byte $11, $0F, $DE, $20, $E0

      _AFE5_B018 ; 97/B018
        .byte $11, $1F, $5C, $21, $E0

      _AFE5_B01D ; 97/B01D
        .byte $21, $0F, $B7, $22, $E0

      _AFE5_B022 ; 97/B022
        .byte $11, $03, $8A, $20, $E0

      _AFE5_B027 ; 97/B027
        .byte $11, $03, $56, $21, $E0

      _AFE5_B02C ; 97/B02C
        .byte $11, $1F, $A0, $20, $E0

      _AFE5_B031 ; 97/B031
        .byte $21, $0F, $1A, $21, $E0

      _AFE5_B036 ; 97/B036
        .byte $20, $0F, $38, $21, $E0

      _AFE5_B03B ; 97/B03B
        .byte $11, $0F, $9A, $21, $E0

      _AFE5_B040 ; 97/B040
        .byte $11, $0F, $D6, $21, $E0

      _AFE5_B045 ; 97/B045
        .byte $11, $0C, $F4, $21, $E0

      _AFE5_B04A ; 97/B04A
        .byte $11, $0F, $09, $22, $E0

      _AFE5_B04F ; 97/B04F
        .byte $31, $0F, $1D, $22, $E0

      _AFE5_B054 ; 97/B054
        .byte $21, $1F, $79, $22, $E0

      _AFE5_B059 ; 97/B059
        .byte $11, $0F, $D5, $22, $E0

      _AFE5_B05E ; 97/B05E
        .byte $31, $1F, $73, $23, $E0

      _AFE5_B063 ; 97/B063
        .byte $21, $08, $90, $20, $E0

      _AFE5_B068 ; 97/B068
        .byte $11, $03, $17, $22, $E0

      _AFE5_B06D ; 97/B06D
        .byte $29, $03, $84, $20, $E0

      _AFE5_B072 ; 97/B072
        .byte $28, $02, $80, $20, $E0

      _AFE5_B077 ; 97/B077
        .byte $11, $0F, $FC, $20, $E0

      _AFE5_B07C ; 97/B07C
        .byte $11, $0F, $B8, $21, $E0

        ; 97/B081

    .endsection Data978F3ASection


    .section BattleSceneDecompressionTablesSection

      .al
      .xl

      aBattleSceneDecompressToVRAMTable ; 97/B081

        ; Read by rlBattleSceneCommandDecompressToVRAM (10 bytes: Source, Dest, VRAMWordAddress, Count).

        .long gcUnknownE03749, aDecompressionBuffer
        .word $7000, $0400
        .long gcUnknownEF0815, aDecompressionBuffer
        .word $3000, $0600
        .long gcUnknownEF0A82, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownEF0C10, aDecompressionBuffer
        .word $3000, $0800
        .long gcUnknownEF0F33, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownEF1175, aDecompressionBuffer
        .word $3000, $1000
        .long gcUnknownEF1680, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownEF5739, aDecompressionBuffer
        .word $2000, $2000
        .long gcUnknownEF6513, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF11286, aDecompressionBuffer
        .word $2000, $1C00
        .long gcUnknownF124AF, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF12801, aDecompressionBuffer
        .word $7400, $0800
        .long gcUnknownEF19AE, aDecompressionBuffer
        .word $2000, $2000
        .long gcUnknownEF29FC, aDecompressionBuffer
        .word $3800, $0800
        .long gcUnknownF01360, aDecompressionBuffer
        .word $3000, $0500
        .long gcUnknownF018FC, aDecompressionBuffer
        .word $7000, $0800
        .long gcUnknownF0013D, aDecompressionBuffer
        .word $2000, $1C00
        .long gcUnknownF016E8, aDecompressionBuffer
        .word $3800, $0800
        .long gcUnknownEF2EB2, aDecompressionBuffer
        .word $2000, $2000
        .long gcUnknownEF3FF1, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownEF421A, aDecompressionBuffer
        .word $3000, $0120
        .long gcUnknownEF4246, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownEF4324, aDecompressionBuffer
        .word $2000, $1800
        .long gcUnknownEF49D5, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownEF4C33, aDecompressionBuffer
        .word $2000, $1000
        .long gcUnknownEF5460, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownEF55C9, aDecompressionBuffer
        .word $3800, $1000
        .long $000000, $000000
        .word $0000, $0000
        .long $000000, $000000
        .word $0000, $0000
        .long $000000, $000000
        .word $0000, $0000
        .long $000000, $000000
        .word $0000, $0000
        .long $000000, $000000
        .word $0000, $0000
        .long gcUnknownEF6771, aDecompressionBuffer
        .word $2000, $0400
        .long gcUnknownEF68C3, aDecompressionBuffer
        .word $3800, $0800
        .long $000000, $000000
        .word $0000, $0000
        .long $000000, $000000
        .word $0000, $0000
        .long gcUnknownEF6F42, aDecompressionBuffer
        .word $2000, $1400
        .long gcUnknownEF7972, aDecompressionBuffer
        .word $3000, $2000
        .long gcUnknownEF7EBA, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownEF7FFC, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF019F4, aDecompressionBuffer
        .word $0000, $2000
        .long gcUnknownF02266, aDecompressionBuffer
        .word $2000, $2000
        .long gcUnknownF02FC1, aDecompressionBuffer
        .word $3000, $0200
        .long gcUnknownF03141, aDecompressionBuffer
        .word $3800, $0800
        .long gcUnknownF0358F, aDecompressionBuffer
        .word $6000, $0800
        .long gcUnknownF03771, aDecompressionBuffer
        .word $6000, $0800
        .long gcUnknownF039A2, aDecompressionBuffer
        .word $7000, $0800
        .long gcUnknownF03A1C, aDecompressionBuffer
        .word $2000, $2000
        .long gcUnknownF046BF, aDecompressionBuffer
        .word $0000, $4000
        .long gcUnknownF06B78, aDecompressionBuffer
        .word $3800, $0800
        .long gcUnknownF07009, aDecompressionBuffer
        .word $6000, $0800
        .long gcUnknownF07458, aDecompressionBuffer
        .word $6000, $0800
        .long gcUnknownF078E5, aDecompressionBuffer
        .word $2000, $4000
        .long gcUnknownF10762, aDecompressionBuffer
        .word $7000, $1000
        .long gcUnknownF10DF5, aDecompressionBuffer
        .word $6000, $0800
        .long gcUnknownF12972, aDecompressionBuffer
        .word $2000, $2000
        .long gcUnknownF14061, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF14534, aDecompressionBuffer
        .word $7000, $0800
        .long gcUnknownF149C5, aDecompressionBuffer
        .word $2000, $0A00
        .long gcUnknownF14E0F, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF14F90, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF15110, aDecompressionBuffer
        .word $2000, $1E00
        .long gcUnknownF15927, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF15C82, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF15FDD, aDecompressionBuffer
        .word $2000, $1000
        .long gcUnknownF16912, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF16A9C, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF16C14, aDecompressionBuffer
        .word $3000, $0200
        .long gcUnknownF16D80, aDecompressionBuffer
        .word $7000, $0800
        .long gcUnknownF17076, aDecompressionBuffer
        .word $2000, $0400
        .long gcUnknownF1718D, aDecompressionBuffer
        .word $3000, $0200
        .long gcUnknownF17245, aDecompressionBuffer
        .word $3800, $0800
        .long gcUnknownF173D5, aDecompressionBuffer
        .word $3800, $0800
        .long gcUnknownF1756A, aDecompressionBuffer
        .word $7000, $0800
        .long gcUnknownF17647, aDecompressionBuffer
        .word $7000, $0800
        .long gcUnknownF1771D, aDecompressionBuffer
        .word $2000, $1200
        .long gcUnknownF20083, aDecompressionBuffer
        .word $7000, $0D00
        .long gcUnknownF206F9, aDecompressionBuffer
        .word $3C00, $0800
        .long gcUnknownF209BE, aDecompressionBuffer
        .word $3000, $1800
        .long gcUnknownF21081, aDecompressionBuffer
        .word $2200, $1200
        .long gcUnknownF21830, aDecompressionBuffer
        .word $3000, $0E00
        .long gcUnknownF2200D, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF22128, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF22240, aDecompressionBuffer
        .word $7000, $1000
        .long gcUnknownF22579, aDecompressionBuffer
        .word $2C00, $0800
        .long gcUnknownF22851, aDecompressionBuffer
        .word $2000, $0400
        .long gcUnknownF2292F, aDecompressionBuffer
        .word $2000, $0A00
        .long gcUnknownF22E80, aDecompressionBuffer
        .word $3000, $0200
        .long gcUnknownF22FD8, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF2316A, aDecompressionBuffer
        .word $7000, $0800
        .long gcUnknownF232C0, aDecompressionBuffer
        .word $2000, $1600
        .long gcUnknownF23B79, aDecompressionBuffer
        .word $3000, $0F00
        .long gcUnknownF2447D, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF246DA, aDecompressionBuffer
        .word $7000, $0800
        .long gcUnknownF2487B, aDecompressionBuffer
        .word $2000, $1200
        .long gcUnknownF25289, aDecompressionBuffer
        .word $3000, $1000
        .long gcUnknownF25C57, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF25DD4, aDecompressionBuffer
        .word $3800, $1000
        .long gcUnknownF25F67, aDecompressionBuffer
        .word $7000, $1800
        .long gcUnknownF262AC, aDecompressionBuffer
        .word $2000, $1800
        .long gcUnknownF2736D, aDecompressionBuffer
        .word $3800, $0800
        .long gcUnknownF27E72, aDecompressionBuffer
        .word $2000, $1800
        .long gcUnknownF30E6F, aDecompressionBuffer
        .word $0000, $4000
        .long gcUnknownF3365D, aDecompressionBuffer
        .word $3000, $0010
        .long gcUnknownF33663, aDecompressionBuffer
        .word $3800, $0800
        .long gcUnknownF339EB, aDecompressionBuffer
        .word $6000, $1000
        .long gcUnknown94FF6D, aDecompressionBuffer
        .word $7000, $0800
        .long gcUnknownF33DD0, aDecompressionBuffer
        .word $3000, $1400
        .long gcUnknownF3426A, aDecompressionBuffer
        .word $0000, $6000
        .long gcUnknownF40D9D, aDecompressionBuffer
        .word $7000, $0800
        .long gcUnknownF40F1E, aDecompressionBuffer
        .word $6000, $1000
        .long gcUnknownF41469, aDecompressionBuffer
        .word $2000, $1000
        .long gcUnknownF41C5A, aDecompressionBuffer
        .word $3800, $0800
        .long gcUnknownF41DCD, aDecompressionBuffer
        .word $3800, $0800
        .long gcUnknownF41F38, aDecompressionBuffer
        .word $0000, $3400
        .long $000000, $000000
        .word $0000, $0000
        .long gcUnknownF43803, aDecompressionBuffer
        .word $6000, $1000
        .long $000000, $000000
        .word $0000, $0000
        .long $000000, $000000
        .word $0000, $0000
        .long gcUnknownF43D26, aDecompressionBuffer
        .word $2000, $1E00
        .long gcUnknownF4493C, aDecompressionBuffer
        .word $0000, $2A00
        .long gcUnknownF460FF, aDecompressionBuffer
        .word $7000, $0800
        .long gcUnknownF46551, aDecompressionBuffer
        .word $3000, $2000
        .long gcUnknownEF698D, aDecompressionBuffer
        .word $2000, $0520
        .long gcUnknownEF6D77, aDecompressionBuffer
        .word $3800, $0800
        .long gcUnknownF276E0, aDecompressionBuffer
        .word $3000, $0800
        .long gcUnknownF27D79, aDecompressionBuffer
        .word $7000, $0800
        .long gcUnknownF61BB4, aDecompressionBuffer
        .word $1000, $0C00
        .long gcUnknownF621E6, aDecompressionBuffer
        .word $1800, $0800
        .long gcUnknownF62298, aDecompressionBuffer
        .word $47B0, $0040
        .long gcUnknownF622C0, aDecompressionBuffer
        .word $57B0, $00A0
        .long gcUnknownF6232E, aDecompressionBuffer
        .word $57B0, $00A0
        .long gcUnknownE03982, aDecompressionBuffer
        .word $47B0, $00A0
        .long gcUnknownF6239C, aDecompressionBuffer
        .word $57B0, $0060
        .long gcUnknownF41F38, aDecompressionBuffer
        .word $2000, $3400
        .long gcUnknownF43AD9, aDecompressionBuffer
        .word $3C00, $0800

        ; 97/B5D1

      aBattleSceneDecompressTable ; 97/B5D1

        ; Read by rlBattleSceneCommandDecompress (6 bytes: Source, Dest).

        .long gcUnknownE03105, $7E9388
        .long gcUnknownE033A5, $7E9B88
        .long gcUnknownE03B09, $7FCBC0
        .long gcUnknownE03D3B, $7FD480
        .long gcUnknownE03D7F, $7E9388
        .long gcUnknownE04000, $7E9588
        .long gcUnknownE040D3, $7E9588
        .long gcUnknownE02EBD, aDecompressionBuffer
        .long gcUnknownE03539, $7E8F88
        .long gcUnknownF3426A, aDecompressionBuffer

        ; 97/B60D

      aBattleSceneCopyToVRAMTable ; 97/B60D

        ; Read by rlBattleSceneCommandCopyToVRAM (7 bytes: Source, VRAMWordAddress, Count).

        .long aDecompressionBuffer
        .word $7600, $0800
        .long $7E9388
        .word $7200, $0800
        .long $7E9B88
        .word $7C00, $0300
        .long $7FCBC0
        .word $69E0, $0500
        .long $7FD480
        .word $6E40, $0280
        .long aDecompressionBuffer
        .word $0000, $4000
        .long aWorldMapMarkerPalette
        .word $6000, $1000
        .long aDecompressionBuffer
        .word $7800, $0800
        .long $7E9388
        .word $7E00, $0200
        .long $7E9588
        .word $69E0, $0280
        .long aDecompressionBuffer
        .word $7E00, $0400
        .long $7FC800
        .word $6800, $03C0
        .long $7FC000
        .word $7800, $0400
        .long $7E8F88
        .word $7A00, $0400
        .long $7E9F88
        .word $7600, $0280
        .long aDecompressionBuffer
        .word $0000, $6000

        ; 97/B67D


      aBattleSceneWriteRAMTable ; 97/B67D

        .word _B67D_B75D - aBattleSceneWriteRAMTable
        .word _B67D_B774 - aBattleSceneWriteRAMTable
        .word _B67D_B782 - aBattleSceneWriteRAMTable
        .word _B67D_B78E - aBattleSceneWriteRAMTable
        .word _B67D_B78E - aBattleSceneWriteRAMTable
        .word _B67D_B7A5 - aBattleSceneWriteRAMTable
        .word _B67D_B7AB - aBattleSceneWriteRAMTable
        .word _B67D_B7C2 - aBattleSceneWriteRAMTable
        .word _B67D_B7CE - aBattleSceneWriteRAMTable
        .word _B67D_B7E1 - aBattleSceneWriteRAMTable
        .word _B67D_B7EE - aBattleSceneWriteRAMTable
        .word _B67D_B80C - aBattleSceneWriteRAMTable
        .word _B67D_B80C - aBattleSceneWriteRAMTable
        .word _B67D_B819 - aBattleSceneWriteRAMTable
        .word _B67D_B82C - aBattleSceneWriteRAMTable
        .word _B67D_B835 - aBattleSceneWriteRAMTable
        .word _B67D_B84E - aBattleSceneWriteRAMTable
        .word _B67D_B850 - aBattleSceneWriteRAMTable
        .word _B67D_B856 - aBattleSceneWriteRAMTable
        .word _B67D_B869 - aBattleSceneWriteRAMTable
        .word _B67D_B876 - aBattleSceneWriteRAMTable
        .word _B67D_B889 - aBattleSceneWriteRAMTable
        .word _B67D_B896 - aBattleSceneWriteRAMTable
        .word _B67D_B8A3 - aBattleSceneWriteRAMTable
        .word _B67D_B8AF - aBattleSceneWriteRAMTable
        .word _B67D_B8C9 - aBattleSceneWriteRAMTable
        .word _B67D_B8D2 - aBattleSceneWriteRAMTable
        .word _B67D_B8E5 - aBattleSceneWriteRAMTable
        .word _B67D_B8EE - aBattleSceneWriteRAMTable
        .word _B67D_B901 - aBattleSceneWriteRAMTable
        .word _B67D_B90A - aBattleSceneWriteRAMTable
        .word _B67D_B91D - aBattleSceneWriteRAMTable
        .word _B67D_B926 - aBattleSceneWriteRAMTable
        .word _B67D_B939 - aBattleSceneWriteRAMTable
        .word _B67D_B942 - aBattleSceneWriteRAMTable
        .word _B67D_B960 - aBattleSceneWriteRAMTable
        .word _B67D_B96D - aBattleSceneWriteRAMTable
        .word _B67D_B976 - aBattleSceneWriteRAMTable
        .word _B67D_B989 - aBattleSceneWriteRAMTable
        .word _B67D_B992 - aBattleSceneWriteRAMTable
        .word _B67D_B9A5 - aBattleSceneWriteRAMTable
        .word _B67D_B9AE - aBattleSceneWriteRAMTable
        .word _B67D_B9C6 - aBattleSceneWriteRAMTable
        .word _B67D_B9D9 - aBattleSceneWriteRAMTable
        .word _B67D_B9E2 - aBattleSceneWriteRAMTable
        .word _B67D_B9E8 - aBattleSceneWriteRAMTable
        .word _B67D_B9FD - aBattleSceneWriteRAMTable
        .word _B67D_BA03 - aBattleSceneWriteRAMTable
        .word _B67D_BA14 - aBattleSceneWriteRAMTable
        .word _B67D_BA27 - aBattleSceneWriteRAMTable
        .word _B67D_BA30 - aBattleSceneWriteRAMTable
        .word _B67D_BA43 - aBattleSceneWriteRAMTable
        .word _B67D_BA4C - aBattleSceneWriteRAMTable
        .word _B67D_BA52 - aBattleSceneWriteRAMTable
        .word _B67D_BA67 - aBattleSceneWriteRAMTable
        .word _B67D_BA7A - aBattleSceneWriteRAMTable
        .word _B67D_BA84 - aBattleSceneWriteRAMTable
        .word _B67D_BA9B - aBattleSceneWriteRAMTable
        .word _B67D_BAA8 - aBattleSceneWriteRAMTable
        .word _B67D_BAB5 - aBattleSceneWriteRAMTable
        .word _B67D_BABE - aBattleSceneWriteRAMTable
        .word _B67D_BAD1 - aBattleSceneWriteRAMTable
        .word _B67D_BAE1 - aBattleSceneWriteRAMTable
        .word _B67D_BAE7 - aBattleSceneWriteRAMTable
        .word _B67D_BAF8 - aBattleSceneWriteRAMTable
        .word _B67D_BB09 - aBattleSceneWriteRAMTable
        .word _B67D_BB0F - aBattleSceneWriteRAMTable
        .word _B67D_BB19 - aBattleSceneWriteRAMTable
        .word _B67D_BB27 - aBattleSceneWriteRAMTable
        .word _B67D_BB3C - aBattleSceneWriteRAMTable
        .word _B67D_BB4F - aBattleSceneWriteRAMTable
        .word _B67D_BB58 - aBattleSceneWriteRAMTable
        .word _B67D_BB5A - aBattleSceneWriteRAMTable
        .word _B67D_BB78 - aBattleSceneWriteRAMTable
        .word _B67D_BB88 - aBattleSceneWriteRAMTable
        .word _B67D_BB8E - aBattleSceneWriteRAMTable
        .word _B67D_BBA1 - aBattleSceneWriteRAMTable
        .word _B67D_BBAE - aBattleSceneWriteRAMTable
        .word _B67D_BBB4 - aBattleSceneWriteRAMTable
        .word _B67D_BBB6 - aBattleSceneWriteRAMTable
        .word _B67D_BBB8 - aBattleSceneWriteRAMTable
        .word _B67D_BBBA - aBattleSceneWriteRAMTable
        .word _B67D_BBC0 - aBattleSceneWriteRAMTable
        .word _B67D_BBC5 - aBattleSceneWriteRAMTable
        .word _B67D_BBD8 - aBattleSceneWriteRAMTable
        .word _B67D_BBE5 - aBattleSceneWriteRAMTable
        .word _B67D_BBEE - aBattleSceneWriteRAMTable
        .word _B67D_BBF8 - aBattleSceneWriteRAMTable
        .word _B67D_BC01 - aBattleSceneWriteRAMTable
        .word _B67D_BC0A - aBattleSceneWriteRAMTable
        .word _B67D_BC1D - aBattleSceneWriteRAMTable
        .word _B67D_BC23 - aBattleSceneWriteRAMTable
        .word _B67D_BC67 - aBattleSceneWriteRAMTable
        .word _B67D_BC79 - aBattleSceneWriteRAMTable
        .word _B67D_BC7F - aBattleSceneWriteRAMTable
        .word _B67D_BC85 - aBattleSceneWriteRAMTable
        .word _B67D_BC9F - aBattleSceneWriteRAMTable
        .word _B67D_BCA5 - aBattleSceneWriteRAMTable
        .word _B67D_BCAB - aBattleSceneWriteRAMTable
        .word _B67D_BCB4 - aBattleSceneWriteRAMTable
        .word _B67D_BCBA - aBattleSceneWriteRAMTable
        .word _B67D_BCC0 - aBattleSceneWriteRAMTable
        .word _B67D_BCC9 - aBattleSceneWriteRAMTable
        .word _B67D_BCE0 - aBattleSceneWriteRAMTable
        .word _B67D_BCE5 - aBattleSceneWriteRAMTable
        .word _B67D_BCF9 - aBattleSceneWriteRAMTable
        .word _B67D_BD09 - aBattleSceneWriteRAMTable
        .word _B67D_BD12 - aBattleSceneWriteRAMTable
        .word _B67D_BD1A - aBattleSceneWriteRAMTable
        .word _B67D_BD1F - aBattleSceneWriteRAMTable
        .word _B67D_BD30 - aBattleSceneWriteRAMTable
        .word _B67D_BD38 - aBattleSceneWriteRAMTable

      _B67D_B75D ; 97/B75D
        .byte $76, $00, $39, $7A, $80, $F0, $00, $96, $80, $FE, $00, $97, $80, $FE, $01, $9A
        .byte $00, $02, $9B, $00, $33
        .word $FFFF

      _B67D_B774 ; 97/B774
        .byte $7F, $00, $00, $80, $00, $00, $81, $00, $5F, $82, $00, $00
        .word $FFFF

      _B67D_B782 ; 97/B782
        .byte $97, $80, $FE, $00, $9A, $00, $02, $9B, $00, $00
        .word $FFFF

      _B67D_B78E ; 97/B78E
        .byte $76, $00, $39, $7A, $80, $F0, $00, $96, $80, $FE, $00, $97, $80, $FE, $01, $9A
        .byte $00, $02, $9B, $00, $33
        .word $FFFF

      _B67D_B7A5 ; 97/B7A5
        .byte $96, $80, $FD, $00
        .word $FFFF

      _B67D_B7AB ; 97/B7AB
        .byte $76, $00, $38, $7A, $80, $F0, $00, $96, $80, $FE, $00, $97, $80, $FE, $01, $9A
        .byte $00, $02, $9B, $00, $33
        .word $FFFF

      _B67D_B7C2 ; 97/B7C2
        .byte $78, $00, $70, $7B, $00, $03, $96, $80, $FB, $04
        .word $FFFF

      _B67D_B7CE ; 97/B7CE
        .byte $76, $00, $38, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $77
        .word $FFFF

      _B67D_B7E1 ; 97/B7E1
        .byte $96, $80, $FA, $00, $97, $80, $FA, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B7EE ; 97/B7EE
        .byte $76, $00, $38, $7A, $80, $F0, $00, $97, $80, $FE, $01, $78, $00, $70, $7B, $80
        .byte $F0, $03, $97, $80, $FB, $04, $9A, $00, $02, $9B, $00, $37
        .word $FFFF

      _B67D_B80C ; 97/B80C
        .byte $96, $80, $FA, $00, $97, $80, $FA, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B819 ; 97/B819
        .byte $76, $00, $38, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $77
        .word $FFFF

      _B67D_B82C ; 97/B82C
        .byte $97, $80, $FE, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B835 ; 97/B835
        .byte $76, $00, $38, $7A, $80, $F0, $00, $97, $80, $FE, $01, $98, $00, $02, $99, $00
        .byte $01, $9A, $00, $02, $9B, $00, $10
        .word $FFFF

      _B67D_B84E ; 97/B84E
        .word $FFFF

      _B67D_B850 ; 97/B850
        .byte $96, $80, $FA, $00
        .word $FFFF

      _B67D_B856 ; 97/B856
        .byte $76, $00, $39, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $33
        .word $FFFF

      _B67D_B869 ; 97/B869
        .byte $96, $80, $FA, $00, $97, $80, $FA, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B876 ; 97/B876
        .byte $76, $00, $38, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $13
        .word $FFFF

      _B67D_B889 ; 97/B889
        .byte $78, $00, $70, $7B, $80, $F0, $03, $96, $80, $FB, $04
        .word $FFFF

      _B67D_B896 ; 97/B896
        .byte $96, $80, $FA, $00, $97, $80, $FA, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B8A3 ; 97/B8A3
        .byte $97, $80, $FA, $00, $9B, $00, $00, $7D, $00, $00
        .word $FFFF

      _B67D_B8AF ; 97/B8AF
        .byte $76, $00, $39, $7A, $80, $F0, $00, $78, $00, $70, $7B, $80, $F0, $03, $97, $80
        .byte $FE, $05, $9A, $00, $02, $9B, $00, $37
        .word $FFFF

      _B67D_B8C9 ; 97/B8C9
        .byte $97, $80, $FA, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B8D2 ; 97/B8D2
        .byte $76, $00, $38, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $33
        .word $FFFF

      _B67D_B8E5 ; 97/B8E5
        .byte $97, $80, $FE, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B8EE ; 97/B8EE
        .byte $76, $00, $3A, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $33
        .word $FFFF

      _B67D_B901 ; 97/B901
        .byte $97, $80, $FE, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B90A ; 97/B90A
        .byte $76, $00, $39, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $32
        .word $FFFF

      _B67D_B91D ; 97/B91D
        .byte $97, $80, $FE, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B926 ; 97/B926
        .byte $76, $00, $32, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $22
        .word $FFFF

      _B67D_B939 ; 97/B939
        .byte $97, $80, $FE, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B942 ; 97/B942
        .byte $76, $00, $39, $7A, $80, $F0, $00, $97, $80, $FE, $01, $78, $00, $70, $7B, $80
        .byte $F0, $03, $96, $80, $FB, $04, $9A, $00, $02, $9B, $00, $33
        .word $FFFF

      _B67D_B960 ; 97/B960
        .byte $96, $80, $FB, $00, $9B, $00, $00, $98, $80, $F9, $00
        .word $FFFF

      _B67D_B96D ; 97/B96D
        .byte $97, $80, $FE, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B976 ; 97/B976
        .byte $76, $00, $39, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $33
        .word $FFFF

      _B67D_B989 ; 97/B989
        .byte $97, $80, $FE, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B992 ; 97/B992
        .byte $76, $00, $39, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $33
        .word $FFFF

      _B67D_B9A5 ; 97/B9A5
        .byte $97, $80, $FE, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B9AE ; 97/B9AE
        .byte $74, $80, $F8, $01, $7A, $80, $00, $00, $77, $00, $61, $97, $80, $FE, $00, $96
        .byte $80, $FD, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B9C6 ; 97/B9C6
        .byte $76, $00, $38, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $33
        .word $FFFF

      _B67D_B9D9 ; 97/B9D9
        .byte $97, $80, $FE, $00, $9B, $00, $00
        .word $FFFF

      _B67D_B9E2 ; 97/B9E2
        .byte $96, $80, $FD, $00
        .word $FFFF

      _B67D_B9E8 ; 97/B9E8
        .byte $77, $80, $FC, $01, $7A, $80, $0F, $00, $97, $80, $FE, $00, $96, $80, $FD, $00
        .byte $9B, $00, $00
        .word $FFFF

      _B67D_B9FD ; 97/B9FD
        .byte $96, $80, $FC, $00
        .word $FFFF

      _B67D_BA03 ; 97/BA03
        .byte $77, $80, $FC, $01, $96, $80, $FC, $00, $97, $80, $FB, $00, $9B, $00, $00
        .word $FFFF

      _B67D_BA14 ; 97/BA14
        .byte $76, $00, $39, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $33
        .word $FFFF

      _B67D_BA27 ; 97/BA27
        .byte $97, $80, $FE, $00, $9B, $00, $00
        .word $FFFF

      _B67D_BA30 ; 97/BA30
        .byte $76, $00, $39, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $23
        .word $FFFF

      _B67D_BA43 ; 97/BA43
        .byte $97, $80, $FE, $00, $9B, $00, $00
        .word $FFFF

      _B67D_BA4C ; 97/BA4C
        .byte $96, $80, $FD, $00
        .word $FFFF

      _B67D_BA52 ; 97/BA52
        .byte $76, $00, $39, $77, $80, $FC, $00, $7A, $80, $F0, $00, $96, $80, $FE, $01, $96
        .byte $80, $FD, $02
        .word $FFFF

      _B67D_BA67 ; 97/BA67
        .byte $78, $00, $70, $7B, $80, $F0, $03, $97, $80, $FB, $04, $9A, $00, $02, $9B, $00
        .byte $33
        .word $FFFF

      _B67D_BA7A ; 97/BA7A
        .byte $96, $80, $FE, $00, $96, $80, $FD, $00
        .word $FFFF

      _B67D_BA84 ; 97/BA84
        .byte $76, $00, $39, $7A, $80, $F0, $00, $96, $80, $FC, $01, $97, $80, $FD, $02, $9A
        .byte $00, $02, $9B, $00, $E3
        .word $FFFF

      _B67D_BA9B ; 97/BA9B
        .byte $96, $80, $FC, $02, $97, $80, $FC, $01, $9B, $00, $22
        .word $FFFF

      _B67D_BAA8 ; 97/BAA8
        .byte $97, $80, $FE, $00, $96, $80, $FD, $00, $9B, $00, $00
        .word $FFFF

      _B67D_BAB5 ; 97/BAB5
        .byte $77, $00, $33, $96, $80, $FD, $02
        .word $FFFF

      _B67D_BABE ; 97/BABE
        .byte $76, $00, $70, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $23
        .word $FFFF

      _B67D_BAD1 ; 97/BAD1
        .byte $77, $00, $61, $97, $80, $FE, $00, $96, $80, $FD, $00, $9B, $00, $00
        .word $FFFF

      _B67D_BAE1 ; 97/BAE1
        .byte $96, $80, $FD, $00
        .word $FFFF

      _B67D_BAE7 ; 97/BAE7
        .byte $76, $00, $38, $77, $80, $FC, $02, $7A, $80, $F0, $00, $96, $80, $FE, $02
        .word $FFFF

      _B67D_BAF8 ; 97/BAF8
        .byte $77, $80, $FC, $01, $96, $80, $FD, $00, $97, $80, $FA, $00, $9B, $00, $00
        .word $FFFF

      _B67D_BB09 ; 97/BB09
        .byte $96, $80, $FD, $00
        .word $FFFF

      _B67D_BB0F ; 97/BB0F
        .byte $96, $80, $FD, $02, $77, $80, $F0, $02
        .word $FFFF

      _B67D_BB19 ; 97/BB19
        .byte $96, $80, $FD, $00, $97, $80, $FE, $00, $77, $80, $F0, $01
        .word $FFFF

      _B67D_BB27 ; 97/BB27
        .byte $76, $00, $62, $77, $00, $38, $7A, $00, $00, $96, $80, $FC, $03, $9A, $00, $02
        .byte $9B, $00, $82
        .word $FFFF

      _B67D_BB3C ; 97/BB3C
        .byte $78, $00, $70, $97, $80, $FB, $04, $7B, $80, $F0, $03, $9A, $00, $02, $9B, $00
        .byte $27
        .word $FFFF

      _B67D_BB4F ; 97/BB4F
        .byte $96, $80, $FD, $02, $77, $00, $61
        .word $FFFF

      _B67D_BB58 ; 97/BB58
        .word $FFFF

      _B67D_BB5A ; 97/BB5A
        .byte $76, $00, $39, $78, $00, $20, $7A, $80, $F0, $00, $7B, $80, $F0, $03, $96, $80
        .byte $FB, $04, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00, $23
        .word $FFFF

      _B67D_BB78 ; 97/BB78
        .byte $76, $00, $71, $78, $00, $2C, $96, $80, $FB, $04, $97, $80, $FE, $01
        .word $FFFF

      _B67D_BB88 ; 97/BB88
        .byte $96, $80, $FB, $00
        .word $FFFF

      _B67D_BB8E ; 97/BB8E
        .byte $76, $00, $3C, $97, $80, $FE, $01, $7A, $80, $F0, $00, $9A, $00, $02, $9B, $00
        .byte $23
        .word $FFFF

      _B67D_BBA1 ; 97/BBA1
        .byte $78, $00, $33, $96, $80, $FB, $04, $7B, $80, $F0, $07
        .word $FFFF

      _B67D_BBAE ; 97/BBAE
        .byte $96, $80, $FB, $00
        .word $FFFF

      _B67D_BBB4 ; 97/BBB4
        .word $FFFF

      _B67D_BBB6 ; 97/BBB6
        .word $FFFF

      _B67D_BBB8 ; 97/BBB8
        .word $FFFF

      _B67D_BBBA ; 97/BBBA
        .byte $96, $80, $FD, $02
        .word $FFFF

      _B67D_BBC0 ; 97/BBC0
        .byte $77, $00, $70
        .word $FFFF

      _B67D_BBC5 ; 97/BBC5
        .byte $76, $00, $39, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $33
        .word $FFFF

      _B67D_BBD8 ; 97/BBD8
        .byte $97, $80, $FE, $00, $96, $80, $FD, $00, $9B, $00, $00
        .word $FFFF

      _B67D_BBE5 ; 97/BBE5
        .byte $77, $00, $61, $96, $80, $FD, $02
        .word $FFFF

      _B67D_BBEE ; 97/BBEE
        .byte $96, $80, $FD, $02, $77, $80, $FC, $01
        .word $FFFF

      _B67D_BBF8 ; 97/BBF8
        .byte $97, $80, $FB, $00, $9B, $00, $00
        .word $FFFF

      _B67D_BC01 ; 97/BC01
        .byte $96, $80, $FD, $02, $9B, $00, $00
        .word $FFFF

      _B67D_BC0A ; 97/BC0A
        .byte $76, $00, $70, $7A, $80, $F0, $00, $97, $80, $FE, $01, $9A, $00, $02, $9B, $00
        .byte $33
        .word $FFFF

      _B67D_BC1D ; 97/BC1D
        .byte $96, $80, $FD, $02
        .word $FFFF

      _B67D_BC23 ; 97/BC23
        .byte $7F, $00, $00, $80, $00, $00, $81, $00, $00, $82, $00, $00, $83, $00, $00, $84
        .byte $00, $00, $85, $00, $00, $86, $00, $00, $87, $00, $00, $88, $00, $00, $89, $00
        .byte $01, $8A, $00, $00, $7A, $00, $20, $76, $00, $3A, $77, $00, $74, $78, $00, $70
        .byte $74, $80, $F8, $02, $97, $80, $FE, $01, $96, $80, $FD, $02, $9A, $00, $02, $9B
        .byte $00, $33
        .word $FFFF

      _B67D_BC67 ; 97/BC67
        .byte $78, $00, $70, $7B, $00, $03, $97, $80, $FA, $05, $9A, $00, $02, $9B, $00, $33
        .word $FFFF

      _B67D_BC79 ; 97/BC79
        .byte $96, $80, $FD, $02
        .word $FFFF

      _B67D_BC7F ; 97/BC7F
        .byte $96, $80, $FD, $02
        .word $FFFF

      _B67D_BC85 ; 97/BC85
        .byte $76, $00, $71, $77, $80, $FC, $00, $7A, $00, $21, $97, $80, $FE, $01, $96, $80
        .byte $FD, $02, $9A, $00, $02, $9B, $00, $73
        .word $FFFF

      _B67D_BC9F ; 97/BC9F
        .byte $96, $80, $FD, $00
        .word $FFFF

      _B67D_BCA5 ; 97/BCA5
        .byte $96, $80, $FD, $02
        .word $FFFF

      _B67D_BCAB ; 97/BCAB
        .byte $97, $80, $FE, $00, $9B, $00, $00
        .word $FFFF

      _B67D_BCB4 ; 97/BCB4
        .byte $97, $80, $FE, $00
        .word $FFFF

      _B67D_BCBA ; 97/BCBA
        .byte $96, $80, $FB, $00
        .word $FFFF

      _B67D_BCC0 ; 97/BCC0
        .byte $97, $80, $FE, $00, $9B, $00, $00
        .word $FFFF

      _B67D_BCC9 ; 97/BCC9
        .byte $7D, $00, $00, $7E, $00, $02, $8F, $00, $00, $94, $00, $00, $95, $00, $00, $98
        .byte $00, $04, $99, $00, $00
        .word $FFFF

      _B67D_BCE0 ; 97/BCE0
        .byte $98, $00, $00
        .word $FFFF

      _B67D_BCE5 ; 97/BCE5
        .byte $76, $00, $18, $7A, $80, $F0, $00, $9B, $00, $33, $98, $80, $FD, $02, $7D, $80
        .byte $0F, $20
        .word $FFFF

      _B67D_BCF9 ; 97/BCF9
        .byte $76, $00, $39, $7A, $80, $F0, $00, $9B, $00, $23, $98, $80, $FD, $00
        .word $FFFF

      _B67D_BD09 ; 97/BD09
        .byte $9B, $00, $00, $96, $80, $FE, $00
        .word $FFFF

      _B67D_BD12 ; 97/BD12
        .byte $9A, $00, $00, $9B, $00, $37
        .word $FFFF

      _B67D_BD1A ; 97/BD1A
        .byte $9B, $00, $00
        .word $FFFF

      _B67D_BD1F ; 97/BD1F
        .byte $96, $80, $FE, $01, $76, $00, $61, $7A, $80, $F0, $00, $7D, $80, $0F, $23
        .word $FFFF

      _B67D_BD30 ; 97/BD30
        .byte $9A, $00, $00, $9B, $00, $81
        .word $FFFF

      _B67D_BD38 ; 97/BD38
        .byte $96, $80, $FE, $00
        .word $FFFF

      aUnknown97BD3E ; 97/BD3E

        .word _BD3E_BD62 - aUnknown97BD3E
        .word _BD3E_BD65 - aUnknown97BD3E
        .word _BD3E_BD6D - aUnknown97BD3E
        .word _BD3E_BD75 - aUnknown97BD3E
        .word _BD3E_BD7D - aUnknown97BD3E
        .word _BD3E_BD85 - aUnknown97BD3E
        .word _BD3E_BD8D - aUnknown97BD3E
        .word _BD3E_BD95 - aUnknown97BD3E
        .word _BD3E_BD9D - aUnknown97BD3E
        .word _BD3E_BDA5 - aUnknown97BD3E
        .word _BD3E_BDA8 - aUnknown97BD3E
        .word _BD3E_BDAB - aUnknown97BD3E
        .word _BD3E_BDAE - aUnknown97BD3E
        .word _BD3E_BDB6 - aUnknown97BD3E
        .word _BD3E_BDB9 - aUnknown97BD3E
        .word _BD3E_BDC1 - aUnknown97BD3E
        .word _BD3E_BDC9 - aUnknown97BD3E
        .word _BD3E_BDCC - aUnknown97BD3E

      _BD3E_BD62 ; 97/BD62
        .byte $69, $BE, $96

      _BD3E_BD65 ; 97/BD65
        .byte $02, $BF, $96, $00, $00, $00, $00, $00

      _BD3E_BD6D ; 97/BD6D
        .long rlUnknown96BFE5
        .byte $00, $00, $00, $00, $00

      _BD3E_BD75 ; 97/BD75
        .long rlUnknown96BFE5
        .byte $00, $00, $00, $04, $00

      _BD3E_BD7D ; 97/BD7D
        .long rlUnknown96BFE5
        .byte $00, $00, $00, $32, $00

      _BD3E_BD85 ; 97/BD85
        .long rlUnknown96BFE5
        .byte $00, $00, $00, $36, $00

      _BD3E_BD8D ; 97/BD8D
        .long rlUnknown96BFE5
        .byte $00, $00, $00, $78, $00

      _BD3E_BD95 ; 97/BD95
        .long rlUnknown96BFE5
        .byte $00, $00, $00, $BA, $00

      _BD3E_BD9D ; 97/BD9D
        .long rlUnknown96BFE5
        .byte $00, $00, $00, $BE, $00

      _BD3E_BDA5 ; 97/BDA5
        .byte $7F, $C0, $96

      _BD3E_BDA8 ; 97/BDA8
        .byte $61, $C1, $96

      _BD3E_BDAB ; 97/BDAB
        .byte $3A, $C2, $96

      _BD3E_BDAE ; 97/BDAE
        .byte $CF, $C2, $96, $00, $00, $00, $00, $00

      _BD3E_BDB6 ; 97/BDB6
        .byte $4F, $C3, $96

      _BD3E_BDB9 ; 97/BDB9
        .byte $11, $C4, $96, $00, $00, $00, $00, $00

      _BD3E_BDC1 ; 97/BDC1
        .byte $F4, $C4, $96, $00, $00, $00, $00, $00

      _BD3E_BDC9 ; 97/BDC9
        .byte $80, $C5, $96

      _BD3E_BDCC ; 97/BDCC
        .byte $02, $C7, $96, $00, $00, $00, $00, $00

    .endsection BattleSceneDecompressionTablesSection


    .section Data97BEACSection

      .al
      .xl

      aUnknown97BEAC ; 97/BEAC

        ; Read by rlBattleSceneCommandBGScrollEffect.

        .word _BEAC_BF48 - aUnknown97BEAC
        .word _BEAC_BF4A - aUnknown97BEAC
        .word _BEAC_BF4C - aUnknown97BEAC
        .word _BEAC_BF4E - aUnknown97BEAC
        .word _BEAC_BF50 - aUnknown97BEAC
        .word _BEAC_BF52 - aUnknown97BEAC
        .word _BEAC_BF58 - aUnknown97BEAC
        .word _BEAC_BF5E - aUnknown97BEAC
        .word _BEAC_BF64 - aUnknown97BEAC
        .word _BEAC_BF6A - aUnknown97BEAC
        .word _BEAC_BF70 - aUnknown97BEAC
        .word _BEAC_BF72 - aUnknown97BEAC
        .word _BEAC_BF74 - aUnknown97BEAC
        .word _BEAC_BF77 - aUnknown97BEAC
        .word _BEAC_BF79 - aUnknown97BEAC
        .word _BEAC_BF7F - aUnknown97BEAC
        .word _BEAC_BF85 - aUnknown97BEAC
        .word _BEAC_BF8B - aUnknown97BEAC
        .word _BEAC_BF8D - aUnknown97BEAC
        .word _BEAC_BF90 - aUnknown97BEAC
        .word _BEAC_BF92 - aUnknown97BEAC
        .word _BEAC_BF94 - aUnknown97BEAC
        .word _BEAC_BF9A - aUnknown97BEAC
        .word _BEAC_BF9F - aUnknown97BEAC
        .word _BEAC_BFA1 - aUnknown97BEAC
        .word _BEAC_BFA7 - aUnknown97BEAC
        .word _BEAC_BFAC - aUnknown97BEAC
        .word _BEAC_BFAE - aUnknown97BEAC
        .word _BEAC_BFB3 - aUnknown97BEAC
        .word _BEAC_BFB5 - aUnknown97BEAC
        .word _BEAC_BFB8 - aUnknown97BEAC
        .word _BEAC_BFBA - aUnknown97BEAC
        .word _BEAC_BFBC - aUnknown97BEAC
        .word _BEAC_BFC2 - aUnknown97BEAC
        .word _BEAC_BFC5 - aUnknown97BEAC
        .word _BEAC_BFC7 - aUnknown97BEAC
        .word _BEAC_BFCC - aUnknown97BEAC
        .word _BEAC_BFD2 - aUnknown97BEAC
        .word _BEAC_BFD8 - aUnknown97BEAC
        .word _BEAC_BFDE - aUnknown97BEAC
        .word _BEAC_BFE4 - aUnknown97BEAC
        .word _BEAC_BFEA - aUnknown97BEAC
        .word _BEAC_BFF0 - aUnknown97BEAC
        .word _BEAC_BFF6 - aUnknown97BEAC
        .word _BEAC_BFFC - aUnknown97BEAC
        .word _BEAC_C002 - aUnknown97BEAC
        .word _BEAC_C002 - aUnknown97BEAC
        .word _BEAC_C008 - aUnknown97BEAC
        .word _BEAC_C00E - aUnknown97BEAC
        .word _BEAC_C014 - aUnknown97BEAC
        .word _BEAC_C01A - aUnknown97BEAC
        .word _BEAC_C020 - aUnknown97BEAC
        .word _BEAC_C026 - aUnknown97BEAC
        .word _BEAC_C02C - aUnknown97BEAC
        .word _BEAC_C032 - aUnknown97BEAC
        .word _BEAC_C038 - aUnknown97BEAC
        .word _BEAC_C03E - aUnknown97BEAC
        .word _BEAC_C044 - aUnknown97BEAC
        .word _BEAC_C04A - aUnknown97BEAC
        .word _BEAC_C050 - aUnknown97BEAC
        .word _BEAC_C056 - aUnknown97BEAC
        .word _BEAC_C05C - aUnknown97BEAC
        .word _BEAC_C061 - aUnknown97BEAC
        .word _BEAC_C063 - aUnknown97BEAC
        .word _BEAC_C066 - aUnknown97BEAC
        .word _BEAC_C068 - aUnknown97BEAC
        .word _BEAC_C06E - aUnknown97BEAC
        .word _BEAC_C074 - aUnknown97BEAC
        .word _BEAC_C079 - aUnknown97BEAC
        .word _BEAC_C07E - aUnknown97BEAC
        .word _BEAC_C080 - aUnknown97BEAC
        .word _BEAC_C086 - aUnknown97BEAC
        .word _BEAC_C08C - aUnknown97BEAC
        .word _BEAC_C08E - aUnknown97BEAC
        .word _BEAC_C090 - aUnknown97BEAC
        .word _BEAC_C096 - aUnknown97BEAC
        .word _BEAC_C09C - aUnknown97BEAC
        .word _BEAC_C0A2 - aUnknown97BEAC

      _BEAC_BF48 ; 97/BF48
        .byte $00, $03

      _BEAC_BF4A ; 97/BF4A
        .byte $00, $05

      _BEAC_BF4C ; 97/BF4C
        .byte $00, $06

      _BEAC_BF4E ; 97/BF4E
        .byte $02, $08

      _BEAC_BF50 ; 97/BF50
        .byte $00, $08

      _BEAC_BF52 ; 97/BF52
        .byte $00, $17, $FC, $04, $B4, $00

      _BEAC_BF58 ; 97/BF58
        .byte $02, $17, $06, $FA, $B4, $00

      _BEAC_BF5E ; 97/BF5E
        .byte $00, $17, $FE, $02, $3C, $01

      _BEAC_BF64 ; 97/BF64
        .byte $00, $17, $01, $FF, $68, $01

      _BEAC_BF6A ; 97/BF6A
        .byte $02, $15, $02, $A4, $C0, $97

      _BEAC_BF70 ; 97/BF70
        .byte $02, $03

      _BEAC_BF72 ; 97/BF72
        .byte $00, $0B

      _BEAC_BF74 ; 97/BF74
        .byte $00, $1B, $04

      _BEAC_BF77 ; 97/BF77
        .byte $00, $14

      _BEAC_BF79 ; 97/BF79
        .byte $02, $17, $FE, $04, $D4, $00

      _BEAC_BF7F ; 97/BF7F
        .byte $00, $17, $00, $F8, $D4, $00

      _BEAC_BF85 ; 97/BF85
        .byte $00, $17, $01, $FD, $8C, $00

      _BEAC_BF8B ; 97/BF8B
        .byte $00, $09

      _BEAC_BF8D ; 97/BF8D
        .byte $00, $1B, $0C

      _BEAC_BF90 ; 97/BF90
        .byte $00, $09

      _BEAC_BF92 ; 97/BF92
        .byte $02, $05

      _BEAC_BF94 ; 97/BF94
        .byte $00, $19, $02, $FC, $80, $00

      _BEAC_BF9A ; 97/BF9A
        .byte $00, $16, $09, $C1, $97

      _BEAC_BF9F ; 97/BF9F
        .byte $00, $01

      _BEAC_BFA1 ; 97/BFA1
        .byte $00, $1A, $10, $FF, $31, $00

      _BEAC_BFA7 ; 97/BFA7
        .byte $02, $16, $21, $C1, $97

      _BEAC_BFAC ; 97/BFAC
        .byte $02, $0A

      _BEAC_BFAE ; 97/BFAE
        .byte $02, $16, $B3, $C1, $97

      _BEAC_BFB3 ; 97/BFB3
        .byte $00, $01

      _BEAC_BFB5 ; 97/BFB5
        .byte $00, $1B, $10

      _BEAC_BFB8 ; 97/BFB8
        .byte $00, $14

      _BEAC_BFBA ; 97/BFBA
        .byte $00, $0C

      _BEAC_BFBC ; 97/BFBC
        .byte $00, $17, $FF, $01, $3E, $01

      _BEAC_BFC2 ; 97/BFC2
        .byte $00, $11, $08

      _BEAC_BFC5 ; 97/BFC5
        .byte $00, $0D

      _BEAC_BFC7 ; 97/BFC7
        .byte $01, $16, $3B, $C2, $97

      _BEAC_BFCC ; 97/BFCC
        .byte $00, $17, $FA, $01, $14, $00

      _BEAC_BFD2 ; 97/BFD2
        .byte $00, $17, $FA, $00, $14, $00

      _BEAC_BFD8 ; 97/BFD8
        .byte $00, $17, $FA, $FF, $14, $00

      _BEAC_BFDE ; 97/BFDE
        .byte $00, $17, $FA, $FE, $14, $00

      _BEAC_BFE4 ; 97/BFE4
        .byte $02, $17, $00, $01, $DC, $00

      _BEAC_BFEA ; 97/BFEA
        .byte $01, $0E, $00, $00, $38, $00

      _BEAC_BFF0 ; 97/BFF0
        .byte $00, $17, $F8, $00, $10, $00

      _BEAC_BFF6 ; 97/BFF6
        .byte $00, $17, $F8, $00, $28, $01

      _BEAC_BFFC ; 97/BFFC
        .byte $01, $17, $04, $00, $28, $01

      _BEAC_C002 ; 97/C002
        .byte $01, $0E, $00, $00, $38, $00

      _BEAC_C008 ; 97/C008
        .byte $01, $0E, $00, $00, $F1, $00

      _BEAC_C00E ; 97/C00E
        .byte $02, $17, $00, $01, $28, $01

      _BEAC_C014 ; 97/C014
        .byte $01, $0E, $00, $00, $20, $01

      _BEAC_C01A ; 97/C01A
        .byte $01, $17, $00, $FF, $90, $01

      _BEAC_C020 ; 97/C020
        .byte $00, $17, $00, $FF, $2C, $01

      _BEAC_C026 ; 97/C026
        .byte $00, $0E, $00, $00, $80, $00

      _BEAC_C02C ; 97/C02C
        .byte $00, $17, $00, $FF, $28, $01

      _BEAC_C032 ; 97/C032
        .byte $00, $17, $01, $FC, $98, $00

      _BEAC_C038 ; 97/C038
        .byte $01, $0E, $00, $00, $88, $00

      _BEAC_C03E ; 97/C03E
        .byte $01, $17, $00, $FF, $90, $00

      _BEAC_C044 ; 97/C044
        .byte $01, $17, $00, $80, $88, $00

      _BEAC_C04A ; 97/C04A
        .byte $02, $17, $00, $FF, $D2, $00

      _BEAC_C050 ; 97/C050
        .byte $01, $0E, $80, $00, $38, $00

      _BEAC_C056 ; 97/C056
        .byte $01, $0E, $08, $00, $38, $00

      _BEAC_C05C ; 97/C05C
        .byte $02, $16, $53, $C2, $97

      _BEAC_C061 ; 97/C061
        .byte $02, $06

      _BEAC_C063 ; 97/C063
        .byte $00, $1B, $08

      _BEAC_C066 ; 97/C066
        .byte $02, $00

      _BEAC_C068 ; 97/C068
        .byte $02, $17, $08, $00, $78, $00

      _BEAC_C06E ; 97/C06E
        .byte $02, $17, $08, $00, $01, $00

      _BEAC_C074 ; 97/C074
        .byte $02, $16, $75, $C2, $97

      _BEAC_C079 ; 97/C079
        .byte $02, $16, $88, $C2, $97

      _BEAC_C07E ; 97/C07E
        .byte $02, $04

      _BEAC_C080 ; 97/C080
        .byte $00, $0E, $80, $00, $FC, $00

      _BEAC_C086 ; 97/C086
        .byte $00, $17, $00, $FC, $C0, $01

      _BEAC_C08C ; 97/C08C
        .byte $00, $14

      _BEAC_C08E ; 97/C08E
        .byte $01, $0F

      _BEAC_C090 ; 97/C090
        .byte $00, $1A, $08, $FD, $21, $00

      _BEAC_C096 ; 97/C096
        .byte $00, $1A, $06, $FE, $41, $00

      _BEAC_C09C ; 97/C09C
        .byte $02, $17, $00, $04, $28, $01

      _BEAC_C0A2 ; 97/C0A2
        .byte $00, $10, $08, $0E, $12, $14, $15, $15, $15, $14, $12, $0E, $08, $F8, $F2, $EE
        .byte $EC, $EB, $EB, $EB, $EC, $EE, $F2, $F8, $07, $0C, $0F, $11, $12, $12, $12, $11
        .byte $0F, $0C, $07, $06, $0C, $10, $12, $13, $13, $13, $12, $10, $0C, $06, $05, $0A
        .byte $0D, $0F, $10, $10, $10, $0F, $0D, $0A, $05, $04, $08, $0B, $0D, $0E, $0E, $0E
        .byte $0D, $0B, $08, $04, $03, $06, $08, $09, $09, $09, $09, $09, $08, $06, $03, $02
        .byte $04, $05, $06, $06, $06, $06, $06, $05, $04, $02, $01, $02, $03, $03, $03, $03
        .byte $03, $03, $03, $02, $01, $00, $80, $04, $F0, $00, $70, $00, $04, $B0, $00, $70
        .byte $00, $04, $70, $00, $70, $00, $04, $30, $00, $70, $00, $FE, $10, $04, $FF, $00
        .byte $F0, $00, $10, $00, $01, $D0, $00, $10, $00, $01, $F0, $00, $10, $00, $01, $D0
        .byte $00, $10, $00, $02, $B0, $00, $10, $00, $02, $90, $00, $10, $00, $02, $70, $00
        .byte $10, $00, $01, $50, $00, $10, $00, $01, $90, $00, $10, $00, $01, $70, $00, $10
        .byte $00, $01, $90, $00, $10, $00, $02, $70, $00, $10, $00, $02, $50, $00, $10, $00
        .byte $01, $70, $00, $10, $00, $01, $90, $00, $10, $00, $02, $70, $00, $10, $00, $01
        .byte $50, $00, $10, $00, $01, $90, $00, $10, $00, $02, $70, $00, $10, $00, $01, $50
        .byte $00, $10, $00, $01, $90, $00, $10, $00, $02, $70, $00, $10, $00, $01, $50, $00
        .byte $10, $00, $01, $90, $00, $10, $00, $02, $70, $00, $10, $00, $02, $50, $00, $10
        .byte $00, $00, $30, $00, $10, $00, $00, $50, $00, $10, $00, $00, $30, $00, $10, $00
        .byte $FF, $00, $EC, $00, $10, $00, $01, $EC, $00, $10, $00, $01, $C4, $00, $10, $00
        .byte $01, $9C, $00, $10, $00, $01, $74, $00, $10, $00, $01, $4C, $00, $10, $00, $01
        .byte $9C, $00, $10, $00, $01, $74, $00, $10, $00, $01, $4C, $00, $10, $00, $01, $9C
        .byte $00, $10, $00, $01, $74, $00, $10, $00, $01, $4C, $00, $10, $00, $01, $9C, $00
        .byte $10, $00, $01, $74, $00, $10, $00, $01, $4C, $00, $10, $00, $01, $9C, $00, $10
        .byte $00, $01, $74, $00, $10, $00, $01, $4C, $00, $10, $00, $01, $9C, $00, $10, $00
        .byte $01, $74, $00, $10, $00, $01, $4C, $00, $10, $00, $01, $9C, $00, $10, $00, $01
        .byte $74, $00, $10, $00, $01, $4C, $00, $10, $00, $00, $24, $00, $10, $00, $00, $4C
        .byte $00, $10, $00, $00, $24, $00, $10, $00, $FF, $03, $00, $00, $40, $00, $03, $00
        .byte $01, $40, $00, $03, $00, $00, $40, $01, $03, $00, $01, $40, $01, $FE, $28, $04
        .byte $FF, $00, $00, $01, $D0, $00, $00, $00, $01, $50, $00, $00, $00, $00, $D0, $00
        .byte $00, $00, $00, $50, $00, $00, $00, $01, $D0, $01, $00, $00, $01, $50, $01, $FE
        .byte $50, $04, $FF, $00, $00, $00, $74, $00, $01, $00, $00, $5C, $00, $01, $00, $00
        .byte $44, $00, $FE, $C8, $03, $FF, $01, $C0, $00, $C0, $00, $01, $40, $00, $C0, $00
        .byte $01, $C0, $00, $40, $00, $01, $40, $00, $40, $00, $FE, $C8, $04, $FF, $1A, $00
        .byte $1C, $00, $1E, $00, $20, $00, $22, $00, $24, $00, $26, $00, $28, $00, $2A, $00
        .byte $2C, $00, $2E, $00, $30, $00, $32, $00, $01, $01, $01, $02, $01, $04, $01, $08
        .byte $01, $10, $01, $02, $01, $03, $01, $03, $00, $03, $01, $04, $00, $08, $01, $03
        .byte $01, $03

        ; 97/C2D4

      aUnknown97C2D4 ; 97/C2D4

        ; Read by rlBattleSceneStartBG2Shake.

        .byte $02, $00, $01, $01, $FF, $FF, $00, $01, $01, $00, $80, $80, $00, $00, $00, $00
        .byte $01, $00, $FF, $FF, $02, $00, $FF, $FF, $03, $00, $FE, $FF, $04, $00, $FE, $FF
        .byte $04, $00, $FE, $FF, $05, $00, $FE, $FF, $05, $00, $FE, $FF, $05, $00, $FE, $FF
        .byte $06, $00, $FE, $FF, $06, $00, $FE, $FF, $06, $00, $FE, $FF, $06, $00, $FF, $FF
        .byte $07, $00, $00, $00, $07, $00, $01, $00, $07, $00, $02, $00, $07, $00, $03, $00
        .byte $07, $00, $04, $00, $07, $00, $05, $00, $07, $00, $06, $00, $06, $00, $06, $00
        .byte $06, $00, $06, $00, $06, $00, $06, $00, $06, $00, $06, $00, $05, $00, $06, $00
        .byte $05, $00, $06, $00, $05, $00, $06, $00, $04, $00, $06, $00, $04, $00, $05, $00
        .byte $03, $00, $05, $00, $02, $00, $04, $00, $01, $00, $04, $00, $00, $00, $04, $00
        .byte $FF, $FF, $04, $00, $FE, $FF, $04, $00, $FD, $FF, $04, $00, $FC, $FF, $04, $00
        .byte $FC, $FF, $04, $00, $FB, $FF, $04, $00, $FB, $FF, $04, $00, $FB, $FF, $04, $00
        .byte $FA, $FF, $04, $00, $FA, $FF, $04, $00, $FA, $FF, $04, $00, $FA, $FF, $04, $00
        .byte $F9, $FF, $04, $00, $F9, $FF, $04, $00, $F9, $FF, $04, $00, $F9, $FF, $04, $00
        .byte $F9, $FF, $04, $00, $F9, $FF, $04, $00, $F9, $FF, $04, $00, $FA, $FF, $04, $00
        .byte $FA, $FF, $04, $00, $FA, $FF, $04, $00, $FA, $FF, $04, $00, $FB, $FF, $04, $00
        .byte $FB, $FF, $03, $00, $FB, $FF, $03, $00, $FC, $FF, $02, $00, $FC, $FF, $02, $00
        .byte $FD, $FF, $01, $00, $FE, $FF, $01, $00, $FF, $FF, $00, $00, $00, $00, $00, $00
        .byte $01, $00, $FF, $FF, $02, $00, $FF, $FF, $02, $00, $FE, $FF, $03, $00, $FE, $FF
        .byte $03, $00, $FD, $FF, $04, $00, $FD, $FF, $04, $00, $FE, $FF, $04, $00, $FE, $FF
        .byte $04, $00, $FF, $FF, $04, $00, $FF, $FF, $03, $00, $00, $00, $03, $00, $00, $00
        .byte $02, $00, $00, $00, $02, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00
        .byte $FF, $FF, $01, $00, $FE, $FF, $02, $00, $FE, $FF, $03, $00, $FD, $FF, $04, $00
        .byte $FD, $FF, $05, $00, $FC, $FF, $05, $00, $FC, $FF, $05, $00, $FC, $FF, $05, $00
        .byte $FC, $FF, $05, $00, $FC, $FF, $04, $00, $FD, $FF, $03, $00, $FD, $FF, $02, $00
        .byte $FE, $FF, $01, $00, $FE, $FF, $00, $00, $FE, $FF, $00, $00, $00, $80

      aUnknown97C462 ; 97/C462

        ; Read by rlUnknown96C008.

        .byte $01, $00, $01, $80, $04, $00, $00, $01, $00, $02, $00, $03, $00, $04, $00, $06
        .byte $00, $08, $00, $0A, $00, $0C, $00, $0E, $00, $11, $00, $15, $00, $19, $00, $1E
        .byte $00, $24, $00, $2B, $00, $33, $00, $3C, $00, $46, $00, $50, $00, $5A, $00, $64
        .byte $00, $80, $01, $10, $01, $80, $00, $10, $00, $12, $00, $14, $00, $16, $00, $18
        .byte $00, $1A, $00, $1D, $00, $20, $00, $23, $00, $26, $00, $2A, $00, $2E, $00, $32
        .byte $00, $36, $00, $3A, $00, $3E, $00, $42, $00, $45, $00, $48, $00, $4B, $00, $4E
        .byte $00, $50, $00, $52, $00, $54, $00, $56, $00, $58, $00, $5A, $00, $5C, $00, $5E
        .byte $00, $60, $00, $62, $00, $64, $00, $80, $00, $64, $00, $62, $00, $60, $00, $5E
        .byte $00, $5C, $00, $5A, $00, $58, $00, $56, $00, $54, $00, $52, $00, $50, $00, $4E
        .byte $00, $4B, $00, $48, $00, $45, $00, $42, $00, $3E, $00, $3A, $00, $36, $00, $32
        .byte $00, $2E, $00, $2A, $00, $26, $00, $23, $00, $20, $00, $1D, $00, $1A, $00, $18
        .byte $00, $16, $00, $14, $00, $12, $00, $10, $01, $80, $01, $10, $00, $80, $01, $64
        .byte $01, $80, $00, $00, $00, $00, $00, $00, $FF, $FF, $00, $00, $FF, $FF, $01, $00
        .byte $FE, $FF, $01, $00, $FE, $FF, $01, $00, $FE, $FF, $01, $00, $FE, $FF, $01, $00
        .byte $FE, $FF, $01, $00, $FE, $FF, $02, $00, $FE, $FF, $02, $00, $FE, $FF, $02, $00
        .byte $FE, $FF, $02, $00, $FF, $FF, $02, $00, $00, $00, $02, $00, $01, $00, $02, $00
        .byte $02, $00, $02, $00, $03, $00, $02, $00, $04, $00, $02, $00, $05, $00, $02, $00
        .byte $06, $00, $02, $00, $06, $00, $02, $00, $06, $00, $02, $00, $06, $00, $01, $00
        .byte $06, $00, $01, $00, $06, $00, $01, $00, $06, $00, $01, $00, $06, $00, $01, $00
        .byte $06, $00, $01, $00, $05, $00, $00, $00, $05, $00, $00, $00, $04, $00, $00, $00
        .byte $04, $00, $00, $00, $04, $00, $00, $00, $04, $00, $00, $00, $04, $00, $FF, $FF
        .byte $04, $00, $FF, $FF, $04, $00, $FF, $FF, $04, $00, $FF, $FF, $04, $00, $FF, $FF
        .byte $04, $00, $FF, $FF, $04, $00, $FE, $FF, $04, $00, $FE, $FF, $04, $00, $FE, $FF
        .byte $04, $00, $FE, $FF, $04, $00, $FE, $FF, $04, $00, $FE, $FF, $04, $00, $FE, $FF
        .byte $04, $00, $FE, $FF, $04, $00, $FE, $FF, $04, $00, $FE, $FF, $04, $00, $FE, $FF
        .byte $04, $00, $FE, $FF, $04, $00, $FE, $FF, $04, $00, $FE, $FF, $04, $00, $FF, $FF
        .byte $04, $00, $FF, $FF, $04, $00, $FF, $FF, $03, $00, $FF, $FF, $03, $00, $FF, $FF
        .byte $02, $00, $FF, $FF, $02, $00, $00, $00, $01, $00, $00, $00, $01, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $00, $00, $FF, $FF
        .byte $00, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        .byte $FF, $FF, $FF, $FF, $FE, $FF, $FF, $FF, $FE, $FF, $FE, $FF, $FE, $FF, $FE, $FF
        .byte $FE, $FF, $FE, $FF, $FE, $FF, $FE, $FF, $FE, $FF, $FE, $FF, $FE, $FF, $FE, $FF
        .byte $FE, $FF, $FE, $FF, $FF, $FF, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        .byte $FF, $FF, $FF, $FF, $00, $00, $FF, $FF, $00, $00, $FF, $FF, $00, $00, $FF, $FF
        .byte $00, $00, $FF, $FF, $00, $00, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $01, $00, $00, $00, $01, $00, $01, $00, $01, $00, $01, $00
        .byte $01, $00, $01, $00, $02, $00, $01, $00, $02, $00, $01, $00, $02, $00, $01, $00
        .byte $02, $00, $01, $00, $02, $00, $01, $00, $02, $00, $02, $00, $02, $00, $02, $00
        .byte $02, $00, $02, $00, $01, $00, $02, $00, $01, $00, $02, $00, $01, $00, $02, $00
        .byte $01, $00, $02, $00, $00, $00, $02, $00, $00, $00, $01, $00, $00, $00, $01, $00
        .byte $00, $00, $01, $00, $00, $00, $01, $00, $00, $00, $01, $00, $00, $00, $01, $00
        .byte $00, $00, $01, $00, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $01, $00, $00, $00, $01, $00, $00, $00, $01, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF
        .byte $00, $00, $FF, $FF, $00, $00, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $01, $00, $00, $00, $01, $00, $00, $00, $02, $00, $00, $00, $02, $00
        .byte $00, $00, $02, $00, $00, $00, $02, $00, $00, $00, $01, $00, $00, $00, $01, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $00, $00, $FF, $FF
        .byte $00, $00, $FE, $FF, $00, $00, $FE, $FF, $00, $00, $FE, $FF, $00, $00, $FE, $FF
        .byte $00, $00, $FF, $FF, $00, $00, $FF, $FF, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $80, $00, $00, $00, $00, $01, $00, $FF, $FF, $02, $00, $FF, $FF
        .byte $02, $00, $FE, $FF, $03, $00, $FE, $FF, $03, $00, $FD, $FF, $04, $00, $FD, $FF
        .byte $04, $00, $FE, $FF, $04, $00, $FE, $FF, $04, $00, $FF, $FF, $04, $00, $FF, $FF
        .byte $03, $00, $00, $00, $03, $00, $00, $00, $02, $00, $00, $00, $02, $00, $00, $00
        .byte $01, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $01, $00, $FE, $FF, $01, $00
        .byte $FE, $FF, $02, $00, $FD, $FF, $02, $00, $FD, $FF, $03, $00, $FC, $FF, $03, $00
        .byte $FC, $FF, $02, $00, $FC, $FF, $02, $00, $FC, $FF, $01, $00, $FC, $FF, $01, $00
        .byte $FD, $FF, $00, $00, $FD, $FF, $00, $00, $FE, $FF, $00, $00, $FE, $FF, $00, $00
        .byte $FF, $FF, $00, $00, $00, $80

        ; 97/C828

    .endsection Data97BEACSection


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


    .section Data98AD65Section

      .al
      .xl

      aUnknown98AD65 ; 98/AD65

        ; Read by rlUnknown95CAD5.

        .byte $00, $00, $00, $01, $00, $FF, $00, $01, $FF, $01, $FF, $01, $01, $FF, $FF, $02
        .byte $02, $FE, $FE, $03, $03, $03, $FD, $FD, $FD, $98, $9D, $97, $9E, $96, $9F, $95
        .byte $A0, $94, $A1, $93, $A2, $92, $A3, $91, $A4, $90, $A5, $8F, $A6, $8E, $A7, $8D
        .byte $A8, $8C, $A9, $8C, $A9, $8B, $AA, $8B, $AA, $FF, $FF, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $FF, $00, $86, $00, $FF, $00, $86, $00
        .byte $FE, $00, $FF, $00, $FE, $00, $86, $00, $FC, $00, $FF, $00, $FC, $00, $86, $00
        .byte $F8, $00, $FE, $00, $F8, $00, $FF, $00, $F0, $00, $FC, $00, $F0, $00, $FF, $00
        .byte $E0, $00, $F8, $00, $E0, $00, $FE, $00, $D0, $00, $F0, $00, $D0, $00, $FC, $00
        .byte $C0, $00, $E0, $00, $C0, $00, $F8, $00, $B0, $00, $D0, $00, $B0, $00, $F0, $00
        .byte $A0, $00, $C0, $00, $A0, $00, $E0, $00, $8A, $00, $B0, $00, $8A, $00, $D0, $00
        .byte $7C, $00, $A0, $00, $7C, $00, $C0, $00, $7C, $00, $8A, $00, $7C, $00, $B0, $00
        .byte $7C, $00, $7C, $00, $7C, $00, $A0, $00, $7C, $00, $7C, $00, $7C, $00, $8A, $00
        .byte $7C, $00, $7C, $00, $7C, $00, $7C, $80, $80, $00, $7C, $00, $7C, $00, $7C, $00
        .byte $7C, $00, $8A, $00, $7C, $00, $8A, $00, $7C, $00, $A0, $00, $7C, $00, $A0, $00
        .byte $7C, $00, $B0, $00, $8A, $00, $B0, $00, $7C, $00, $C0, $00, $A0, $00, $C0, $00
        .byte $7C, $00, $D0, $00, $B0, $00, $D0, $00, $8A, $00, $E0, $00, $C0, $00, $E0, $00
        .byte $A0, $00, $F0, $00, $D0, $00, $F0, $00, $B0, $00, $F8, $00, $E0, $00, $F8, $00
        .byte $C0, $00, $FC, $00, $F0, $00, $FC, $00, $D0, $00, $FE, $00, $F8, $00, $FE, $00
        .byte $E0, $00, $FF, $00, $FC, $00, $FF, $00, $F0, $00, $00, $00, $FE, $00, $00, $00
        .byte $F8, $00, $00, $00, $FF, $00, $00, $00, $FC, $00, $00, $00, $00, $00, $00, $00
        .byte $FE, $00, $00, $00, $00, $00, $00, $00, $FF, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $80, $80, $00, $7C, $00, $7C, $00, $7C, $00, $7C, $80, $80, $00, $00, $00
        .byte $7C, $00, $00, $00, $7C, $00, $00, $00, $7C, $00, $00, $00, $7C, $00, $00, $00
        .byte $7C, $00, $00, $00, $7C, $00, $00, $00, $7C, $00, $00, $00, $7C, $00, $00, $00
        .byte $7C, $00, $00, $00, $7C, $00, $00, $00, $7C, $00, $00, $00, $7C, $00, $00, $80
        .byte $80, $FE, $FE, $FD, $FB, $EF, $BD, $EE, $ED, $AA, $AA, $48, $88, $42, $08, $20
        .byte $40, $80, $80, $FF, $FF, $80, $40, $20, $10, $08, $04, $02, $01, $0F, $00, $ED
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $04, $00, $04, $00, $04, $00, $08, $00, $08, $00, $0C, $00, $10, $00, $14
        .byte $00, $18, $00, $1C, $00, $20, $00, $24, $00, $28, $00, $2C, $00, $30, $00, $34
        .byte $00, $38, $00, $3C, $00, $40, $00, $44, $00, $48, $00, $4C, $00, $50, $00, $54
        .byte $00, $58, $00, $7C, $00, $58, $00, $54, $00, $50, $00, $4C, $00, $48, $00, $44
        .byte $00, $40, $00, $3C, $00, $38, $00, $34, $00, $30, $00, $2C, $00, $28, $00, $24
        .byte $00, $20, $00, $1C, $00, $18, $00, $14, $00, $10, $00, $0C, $00, $08, $00, $08
        .byte $00, $04, $00, $04, $00, $04, $00, $00, $2F, $33, $3B, $27, $3F, $33, $23, $37
        .byte $2B, $1F, $23, $37, $2B, $33, $27, $3B

        ; 98/AFFD

    .endsection Data98AD65Section


    .section Data9A8000Section

      .al
      .xl

      aUnknown9A8000 ; 9A/8000

        ; Read by rlBattleSceneCommandWindowEffect2.

        .word _8000_801C - aUnknown9A8000
        .word _8000_801C - aUnknown9A8000
        .word _8000_801C - aUnknown9A8000
        .word _8000_801C - aUnknown9A8000
        .word _8000_8035 - aUnknown9A8000
        .word _8000_9A87 - aUnknown9A8000
        .word _8000_9AA0 - aUnknown9A8000
        .word _8000_9F08 - aUnknown9A8000
        .word _8000_9F1B - aUnknown9A8000
        .word _8000_9F1E - aUnknown9A8000
        .word _8000_9F21 - aUnknown9A8000
        .word _8000_9F3A - aUnknown9A8000
        .word _8000_A2EE - aUnknown9A8000
        .word _8000_A2F1 - aUnknown9A8000

      _8000_801C ; 9A/801C
        .byte $03, $03, $00, $00, $00, $00, $00, $01, $00, $00, $45, $45, $80, $5A, $FF, $00
        .byte $53, $00, $00, $C5, $80, $A3, $00, $40, $FD

      _8000_8035 ; 9A/8035
        .byte $83, $00, $00, $50, $50, $80, $FD, $FF, $C5, $80, $A3, $00, $8B, $AC, $E9, $FB
        .byte $00, $00, $50, $45, $80, $5A, $FF, $0B, $53, $00, $04, $D0, $80, $FD, $FF, $00
        .byte $00, $46, $44, $80, $66, $FF, $02, $57, $00, $2C, $C6, $80, $AB, $00, $00, $00
        .byte $50, $50, $80, $E7, $FF, $C6, $80, $AB, $00, $8A, $AF, $80, $FA, $00, $00, $50
        .byte $44, $80, $66, $FF, $0C, $57, $C0, $02, $D0, $80, $E7, $FF, $00, $00, $47, $43
        .byte $80, $77, $FF, $04, $5C, $40, $15, $C7, $80, $B0, $00, $00, $00, $50, $50, $80
        .byte $D0, $FF, $C7, $80, $B0, $00, $89, $B1, $E4, $F8, $00, $00, $50, $43, $80, $77
        .byte $FF, $0D, $5C, $9D, $01, $D0, $80, $D0, $FF, $00, $00, $48, $42, $80, $88, $FF
        .byte $06, $61, $AA, $0D, $C8, $80, $B5, $00, $00, $00, $4F, $4F, $80, $BC, $FF, $C8
        .byte $80, $B5, $00, $87, $B3, $B7, $F5, $00, $00, $4F, $42, $80, $88, $FF, $0D, $61
        .byte $C4, $00, $CF, $80, $BC, $FF, $00, $00, $49, $42, $80, $A0, $FF, $07, $67, $DB
        .byte $0A, $C9, $80, $B2, $00, $00, $00, $4F, $4F, $80, $A6, $FF, $C9, $80, $B2, $00
        .byte $86, $B3, $D6, $F2, $00, $00, $4F, $4F, $80, $A6, $FF, $C2, $80, $A0, $FF, $8D
        .byte $67, $C5, $FF, $00, $00, $4A, $41, $80, $BA, $FF, $09, $6E, $8E, $07, $CA, $80
        .byte $AC, $00, $00, $00, $4E, $4E, $80, $91, $FF, $CA, $80, $AC, $00, $84, $B2, $00
        .byte $EB, $00, $00, $4E, $4E, $80, $91, $FF, $C1, $80, $BA, $FF, $8D, $6E, $C5, $FE
        .byte $00, $00, $4B, $41, $80, $D5, $FF, $0A, $75, $E6, $05, $CB, $80, $A3, $00, $00
        .byte $00, $4E, $4E, $80, $80, $FF, $CB, $80, $A3, $00, $83, $B0, $00, $E3, $00, $00
        .byte $4E, $4E, $80, $80, $FF, $C1, $80, $D5, $FF, $8D, $75, $D9, $FD, $00, $00, $4C
        .byte $41, $80, $F1, $FF, $0B, $7C, $8B, $04, $CC, $80, $9A, $00, $00, $00, $4D, $4D
        .byte $80, $72, $FF, $CC, $80, $9A, $00, $81, $AE, $00, $A7, $00, $00, $4D, $4D, $80
        .byte $72, $FF, $C1, $80, $F1, $FF, $8C, $7C, $C0, $FC, $00, $00, $4D, $41, $80, $0B
        .byte $00, $0C, $83, $40, $03, $CD, $80, $8B, $00, $00, $00, $4D, $4C, $80, $62, $FF
        .byte $CD, $80, $8B, $00, $01, $51, $00, $59, $00, $00, $4C, $4C, $80, $62, $FF, $C1
        .byte $80, $0B, $00, $8B, $83, $75, $FB, $00, $00, $4E, $41, $80, $27, $00, $0D, $8A
        .byte $27, $02, $CE, $80, $7C, $00, $00, $00, $4E, $4B, $80, $59, $FF, $CE, $80, $7C
        .byte $00, $03, $4F, $00, $1D, $00, $00, $4B, $4B, $80, $59, $FF, $C1, $80, $27, $00
        .byte $8A, $8A, $1A, $FA, $00, $00, $4E, $41, $80, $42, $00, $0D, $91, $3B, $01, $CE
        .byte $80, $6C, $00, $00, $00, $4E, $4A, $80, $50, $FF, $CE, $80, $6C, $00, $04, $4D
        .byte $00, $15, $00, $00, $4A, $4A, $80, $50, $FF, $C1, $80, $42, $00, $89, $91, $72
        .byte $F8, $00, $00, $4F, $42, $80, $5D, $00, $0D, $98, $3B, $00, $CF, $80, $57, $00
        .byte $00, $00, $4F, $49, $80, $4A, $FF, $CF, $80, $57, $00, $06, $4C, $2A, $0D, $00
        .byte $00, $49, $49, $80, $4A, $FF, $C2, $80, $5D, $00, $87, $98, $25, $F5, $00, $00
        .byte $4F, $4F, $80, $40, $00, $C2, $80, $74, $00, $8D, $9E, $3C, $FF, $00, $00, $4F
        .byte $48, $80, $48, $FF, $CF, $80, $40, $00, $07, $4C, $49, $0A, $00, $00, $48, $48
        .byte $80, $48, $FF, $C2, $80, $74, $00, $86, $9E, $56, $F2, $00, $00, $50, $50, $80
        .byte $2C, $00, $C3, $80, $85, $00, $8D, $A3, $63, $FE, $00, $00, $50, $47, $80, $4C
        .byte $FF, $D0, $80, $2C, $00, $09, $4E, $1C, $07, $00, $00, $47, $47, $80, $4C, $FF
        .byte $C3, $80, $85, $00, $84, $A3, $C0, $EA, $00, $00, $50, $50, $80, $16, $00, $C4
        .byte $80, $96, $00, $8C, $A8, $40, $FD, $00, $00, $50, $46, $80, $51, $FF, $D0, $80
        .byte $16, $00, $0A, $50, $80, $05, $00, $00, $46, $46, $80, $51, $FF, $C4, $80, $96
        .byte $00, $82, $A8, $00, $D4, $00, $00, $45, $45, $80, $5A, $FF, $00, $53, $00, $00
        .byte $C5, $80, $A3, $00, $00, $00, $50, $50, $80, $FD, $FF, $C5, $80, $A3, $00, $8B
        .byte $AC, $E9, $FB, $00, $00, $50, $45, $80, $5A, $FF, $0B, $53, $00, $04, $D0, $80
        .byte $FD, $FF, $00, $00, $46, $44, $80, $66, $FF, $02, $57, $00, $2C, $C6, $80, $AB
        .byte $00, $00, $00, $50, $50, $80, $E7, $FF, $C6, $80, $AB, $00, $8A, $AF, $80, $FA
        .byte $00, $00, $50, $44, $80, $66, $FF, $0C, $57, $C0, $02, $D0, $80, $E7, $FF, $00
        .byte $00, $47, $43, $80, $77, $FF, $04, $5C, $40, $15, $C7, $80, $B0, $00, $00, $00
        .byte $50, $50, $80, $D0, $FF, $C7, $80, $B0, $00, $89, $B1, $E4, $F8, $00, $00, $50
        .byte $43, $80, $77, $FF, $0D, $5C, $9D, $01, $D0, $80, $D0, $FF, $00, $00, $48, $42
        .byte $80, $88, $FF, $06, $61, $AA, $0D, $C8, $80, $B5, $00, $00, $00, $4F, $4F, $80
        .byte $BC, $FF, $C8, $80, $B5, $00, $87, $B3, $B7, $F5, $00, $00, $4F, $42, $80, $88
        .byte $FF, $0D, $61, $C4, $00, $CF, $80, $BC, $FF, $00, $00, $49, $42, $80, $A0, $FF
        .byte $07, $67, $DB, $0A, $C9, $80, $B2, $00, $00, $00, $4F, $4F, $80, $A6, $FF, $C9
        .byte $80, $B2, $00, $86, $B3, $D6, $F2, $00, $00, $4F, $4F, $80, $A6, $FF, $C2, $80
        .byte $A0, $FF, $8D, $67, $C5, $FF, $00, $00, $4A, $41, $80, $BA, $FF, $09, $6E, $8E
        .byte $07, $CA, $80, $AC, $00, $00, $00, $4E, $4E, $80, $91, $FF, $CA, $80, $AC, $00
        .byte $84, $B2, $00, $EB, $00, $00, $4E, $4E, $80, $91, $FF, $C1, $80, $BA, $FF, $8D
        .byte $6E, $C5, $FE, $00, $00, $4B, $41, $80, $D5, $FF, $0A, $75, $E6, $05, $CB, $80
        .byte $A3, $00, $00, $00, $4E, $4E, $80, $80, $FF, $CB, $80, $A3, $00, $83, $B0, $00
        .byte $E3, $00, $00, $4E, $4E, $80, $80, $FF, $C1, $80, $D5, $FF, $8D, $75, $D9, $FD
        .byte $00, $00, $4C, $41, $80, $F1, $FF, $0B, $7C, $8B, $04, $CC, $80, $9A, $00, $00
        .byte $00, $4D, $4D, $80, $72, $FF, $CC, $80, $9A, $00, $81, $AE, $00, $A7, $00, $00
        .byte $4D, $4D, $80, $72, $FF, $C1, $80, $F1, $FF, $8C, $7C, $C0, $FC, $00, $00, $4D
        .byte $41, $80, $0B, $00, $0C, $83, $40, $03, $CD, $80, $8B, $00, $00, $00, $4D, $4C
        .byte $80, $62, $FF, $CD, $80, $8B, $00, $01, $51, $00, $59, $00, $00, $4C, $4C, $80
        .byte $62, $FF, $C1, $80, $0B, $00, $8B, $83, $75, $FB, $00, $00, $4E, $41, $80, $27
        .byte $00, $0D, $8A, $27, $02, $CE, $80, $7C, $00, $00, $00, $4E, $4B, $80, $59, $FF
        .byte $CE, $80, $7C, $00, $03, $4F, $00, $1D, $00, $00, $4B, $4B, $80, $59, $FF, $C1
        .byte $80, $27, $00, $8A, $8A, $1A, $FA, $00, $00, $4E, $41, $80, $42, $00, $0D, $91
        .byte $3B, $01, $CE, $80, $6C, $00, $00, $00, $4E, $4A, $80, $50, $FF, $CE, $80, $6C
        .byte $00, $04, $4D, $00, $15, $00, $00, $4A, $4A, $80, $50, $FF, $C1, $80, $42, $00
        .byte $89, $91, $72, $F8, $00, $00, $4F, $42, $80, $5D, $00, $0D, $98, $3B, $00, $CF
        .byte $80, $57, $00, $00, $00, $4F, $49, $80, $4A, $FF, $CF, $80, $57, $00, $06, $4C
        .byte $2A, $0D, $00, $00, $49, $49, $80, $4A, $FF, $C2, $80, $5D, $00, $87, $98, $25
        .byte $F5, $00, $00, $4F, $4F, $80, $40, $00, $C2, $80, $74, $00, $8D, $9E, $3C, $FF
        .byte $00, $00, $4F, $48, $80, $48, $FF, $CF, $80, $40, $00, $07, $4C, $49, $0A, $00
        .byte $00, $48, $48, $80, $48, $FF, $C2, $80, $74, $00, $86, $9E, $56, $F2, $00, $00
        .byte $50, $50, $80, $2C, $00, $C3, $80, $85, $00, $8D, $A3, $63, $FE, $00, $00, $50
        .byte $47, $80, $4C, $FF, $D0, $80, $2C, $00, $09, $4E, $1C, $07, $00, $00, $47, $47
        .byte $80, $4C, $FF, $C3, $80, $85, $00, $84, $A3, $C0, $EA, $00, $00, $50, $50, $80
        .byte $16, $00, $C4, $80, $96, $00, $8C, $A8, $40, $FD, $00, $00, $50, $46, $80, $51
        .byte $FF, $D0, $80, $16, $00, $0A, $50, $80, $05, $00, $00, $46, $46, $80, $51, $FF
        .byte $C4, $80, $96, $00, $82, $A8, $00, $D4, $00, $00, $45, $45, $80, $5A, $FF, $00
        .byte $53, $00, $00, $C5, $80, $A3, $00, $00, $00, $50, $50, $80, $FD, $FF, $C5, $80
        .byte $A3, $00, $8B, $AC, $E9, $FB, $00, $00, $50, $45, $80, $5A, $FF, $0B, $53, $00
        .byte $04, $D0, $80, $FD, $FF, $00, $00, $46, $44, $80, $66, $FF, $02, $57, $00, $2C
        .byte $C6, $80, $AB, $00, $00, $00, $50, $50, $80, $E7, $FF, $C6, $80, $AB, $00, $8A
        .byte $AF, $80, $FA, $00, $00, $50, $44, $80, $66, $FF, $0C, $57, $C0, $02, $D0, $80
        .byte $E7, $FF, $00, $00, $47, $43, $80, $77, $FF, $04, $5C, $40, $15, $C7, $80, $B0
        .byte $00, $00, $00, $50, $50, $80, $D0, $FF, $C7, $80, $B0, $00, $89, $B1, $E4, $F8
        .byte $00, $00, $50, $43, $80, $77, $FF, $0D, $5C, $9D, $01, $D0, $80, $D0, $FF, $00
        .byte $00, $48, $42, $80, $88, $FF, $06, $61, $AA, $0D, $C8, $80, $B5, $00, $00, $00
        .byte $4F, $4F, $80, $BC, $FF, $C8, $80, $B5, $00, $87, $B3, $B7, $F5, $00, $00, $4F
        .byte $42, $80, $88, $FF, $0D, $61, $C4, $00, $CF, $80, $BC, $FF, $00, $00, $49, $42
        .byte $80, $A0, $FF, $07, $67, $DB, $0A, $C9, $80, $B2, $00, $00, $00, $4F, $4F, $80
        .byte $A6, $FF, $C9, $80, $B2, $00, $86, $B3, $D6, $F2, $00, $00, $4F, $4F, $80, $A6
        .byte $FF, $C2, $80, $A0, $FF, $8D, $67, $C5, $FF, $00, $00, $4A, $41, $80, $BA, $FF
        .byte $09, $6E, $8E, $07, $CA, $80, $AC, $00, $00, $00, $4E, $4E, $80, $91, $FF, $CA
        .byte $80, $AC, $00, $84, $B2, $00, $EB, $00, $00, $4E, $4E, $80, $91, $FF, $C1, $80
        .byte $BA, $FF, $8D, $6E, $C5, $FE, $00, $00, $4B, $41, $80, $D5, $FF, $0A, $75, $E6
        .byte $05, $CB, $80, $A3, $00, $00, $00, $4E, $4E, $80, $80, $FF, $CB, $80, $A3, $00
        .byte $83, $B0, $00, $E3, $00, $00, $4E, $4E, $80, $80, $FF, $C1, $80, $D5, $FF, $8D
        .byte $75, $D9, $FD, $00, $00, $4C, $41, $80, $F1, $FF, $0B, $7C, $8B, $04, $CC, $80
        .byte $9A, $00, $00, $00, $4D, $4D, $80, $72, $FF, $CC, $80, $9A, $00, $81, $AE, $00
        .byte $A7, $00, $00, $4D, $4D, $80, $72, $FF, $C1, $80, $F1, $FF, $8C, $7C, $C0, $FC
        .byte $00, $00, $4D, $41, $80, $0B, $00, $0C, $83, $40, $03, $CD, $80, $8B, $00, $00
        .byte $00, $4D, $4C, $80, $62, $FF, $CD, $80, $8B, $00, $01, $51, $00, $59, $00, $00
        .byte $4C, $4C, $80, $62, $FF, $C1, $80, $0B, $00, $8B, $83, $75, $FB, $00, $00, $4E
        .byte $41, $80, $27, $00, $0D, $8A, $27, $02, $CE, $80, $7C, $00, $00, $00, $4E, $4B
        .byte $80, $59, $FF, $CE, $80, $7C, $00, $03, $4F, $00, $1D, $00, $00, $4B, $4B, $80
        .byte $59, $FF, $C1, $80, $27, $00, $8A, $8A, $1A, $FA, $00, $00, $4E, $41, $80, $42
        .byte $00, $0D, $91, $3B, $01, $CE, $80, $6C, $00, $00, $00, $4E, $4A, $80, $50, $FF
        .byte $CE, $80, $6C, $00, $04, $4D, $00, $15, $00, $00, $4A, $4A, $80, $50, $FF, $C1
        .byte $80, $42, $00, $89, $91, $72, $F8, $00, $00, $4F, $42, $80, $5D, $00, $0D, $98
        .byte $3B, $00, $CF, $80, $57, $00, $00, $00, $4F, $49, $80, $4A, $FF, $CF, $80, $57
        .byte $00, $06, $4C, $2A, $0D, $00, $00, $49, $49, $80, $4A, $FF, $C2, $80, $5D, $00
        .byte $87, $98, $25, $F5, $00, $00, $4F, $4F, $80, $40, $00, $C2, $80, $74, $00, $8D
        .byte $9E, $3C, $FF, $00, $00, $4F, $48, $80, $48, $FF, $CF, $80, $40, $00, $07, $4C
        .byte $49, $0A, $00, $00, $48, $48, $80, $48, $FF, $C2, $80, $74, $00, $86, $9E, $56
        .byte $F2, $00, $00, $50, $50, $80, $2C, $00, $C3, $80, $85, $00, $8D, $A3, $63, $FE
        .byte $00, $00, $50, $47, $80, $4C, $FF, $D0, $80, $2C, $00, $09, $4E, $1C, $07, $00
        .byte $00, $47, $47, $80, $4C, $FF, $C3, $80, $85, $00, $84, $A3, $C0, $EA, $00, $00
        .byte $50, $50, $80, $16, $00, $C4, $80, $96, $00, $8C, $A8, $40, $FD, $00, $00, $50
        .byte $46, $80, $51, $FF, $D0, $80, $16, $00, $0A, $50, $80, $05, $00, $00, $46, $46
        .byte $80, $51, $FF, $C4, $80, $96, $00, $82, $A8, $00, $D4, $00, $00, $45, $45, $80
        .byte $5A, $FF, $00, $53, $00, $00, $C5, $80, $A3, $00, $00, $00, $50, $50, $80, $FD
        .byte $FF, $C5, $80, $A3, $00, $8B, $AC, $E9, $FB, $00, $00, $50, $45, $80, $5A, $FF
        .byte $0B, $53, $00, $04, $D0, $80, $FD, $FF, $00, $00, $46, $44, $80, $66, $FF, $02
        .byte $57, $00, $2C, $C6, $80, $AB, $00, $00, $00, $50, $50, $80, $E7, $FF, $C6, $80
        .byte $AB, $00, $8A, $AF, $80, $FA, $00, $00, $50, $44, $80, $66, $FF, $0C, $57, $C0
        .byte $02, $D0, $80, $E7, $FF, $00, $00, $47, $43, $80, $77, $FF, $04, $5C, $40, $15
        .byte $C7, $80, $B0, $00, $00, $00, $50, $50, $80, $D0, $FF, $C7, $80, $B0, $00, $89
        .byte $B1, $E4, $F8, $00, $00, $50, $43, $80, $77, $FF, $0D, $5C, $9D, $01, $D0, $80
        .byte $D0, $FF, $00, $00, $48, $42, $80, $88, $FF, $06, $61, $AA, $0D, $C8, $80, $B5
        .byte $00, $00, $00, $4F, $4F, $80, $BC, $FF, $C8, $80, $B5, $00, $87, $B3, $B7, $F5
        .byte $00, $00, $4F, $42, $80, $88, $FF, $0D, $61, $C4, $00, $CF, $80, $BC, $FF, $00
        .byte $00, $49, $42, $80, $A0, $FF, $07, $67, $DB, $0A, $C9, $80, $B2, $00, $00, $00
        .byte $4F, $4F, $80, $A6, $FF, $C9, $80, $B2, $00, $86, $B3, $D6, $F2, $00, $00, $4F
        .byte $4F, $80, $A6, $FF, $C2, $80, $A0, $FF, $8D, $67, $C5, $FF, $00, $00, $4A, $41
        .byte $80, $BA, $FF, $09, $6E, $8E, $07, $CA, $80, $AC, $00, $00, $00, $4E, $4E, $80
        .byte $91, $FF, $CA, $80, $AC, $00, $84, $B2, $00, $EB, $00, $00, $4E, $4E, $80, $91
        .byte $FF, $C1, $80, $BA, $FF, $8D, $6E, $C5, $FE, $00, $00, $4B, $41, $80, $D5, $FF
        .byte $0A, $75, $E6, $05, $CB, $80, $A3, $00, $00, $00, $4E, $4E, $80, $80, $FF, $CB
        .byte $80, $A3, $00, $83, $B0, $00, $E3, $00, $00, $4E, $4E, $80, $80, $FF, $C1, $80
        .byte $D5, $FF, $8D, $75, $D9, $FD, $00, $00, $4C, $41, $80, $F1, $FF, $0B, $7C, $8B
        .byte $04, $CC, $80, $9A, $00, $00, $00, $4D, $4D, $80, $72, $FF, $CC, $80, $9A, $00
        .byte $81, $AE, $00, $A7, $00, $00, $4D, $4D, $80, $72, $FF, $C1, $80, $F1, $FF, $8C
        .byte $7C, $C0, $FC, $00, $00, $4D, $41, $80, $0B, $00, $0C, $83, $40, $03, $CD, $80
        .byte $8B, $00, $00, $00, $4D, $4C, $80, $62, $FF, $CD, $80, $8B, $00, $01, $51, $00
        .byte $59, $00, $00, $4C, $4C, $80, $62, $FF, $C1, $80, $0B, $00, $8B, $83, $75, $FB
        .byte $00, $00, $4E, $41, $80, $27, $00, $0D, $8A, $27, $02, $CE, $80, $7C, $00, $00
        .byte $00, $4E, $4B, $80, $59, $FF, $CE, $80, $7C, $00, $03, $4F, $00, $1D, $00, $00
        .byte $4B, $4B, $80, $59, $FF, $C1, $80, $27, $00, $8A, $8A, $1A, $FA, $00, $00, $4E
        .byte $41, $80, $42, $00, $0D, $91, $3B, $01, $CE, $80, $6C, $00, $00, $00, $4E, $4A
        .byte $80, $50, $FF, $CE, $80, $6C, $00, $04, $4D, $00, $15, $00, $00, $4A, $4A, $80
        .byte $50, $FF, $C1, $80, $42, $00, $89, $91, $72, $F8, $00, $00, $4F, $42, $80, $5D
        .byte $00, $0D, $98, $3B, $00, $CF, $80, $57, $00, $00, $00, $4F, $49, $80, $4A, $FF
        .byte $CF, $80, $57, $00, $06, $4C, $2A, $0D, $00, $00, $49, $49, $80, $4A, $FF, $C2
        .byte $80, $5D, $00, $87, $98, $25, $F5, $00, $00, $4F, $4F, $80, $40, $00, $C2, $80
        .byte $74, $00, $8D, $9E, $3C, $FF, $00, $00, $4F, $48, $80, $48, $FF, $CF, $80, $40
        .byte $00, $07, $4C, $49, $0A, $00, $00, $48, $48, $80, $48, $FF, $C2, $80, $74, $00
        .byte $86, $9E, $56, $F2, $00, $00, $50, $50, $80, $2C, $00, $C3, $80, $85, $00, $8D
        .byte $A3, $63, $FE, $00, $00, $50, $47, $80, $4C, $FF, $D0, $80, $2C, $00, $09, $4E
        .byte $1C, $07, $00, $00, $47, $47, $80, $4C, $FF, $C3, $80, $85, $00, $84, $A3, $C0
        .byte $EA, $00, $00, $50, $50, $80, $16, $00, $C4, $80, $96, $00, $8C, $A8, $40, $FD
        .byte $00, $00, $50, $46, $80, $51, $FF, $D0, $80, $16, $00, $0A, $50, $80, $05, $00
        .byte $00, $46, $46, $80, $51, $FF, $C4, $80, $96, $00, $82, $A8, $00, $D4, $00, $00
        .byte $45, $45, $80, $5A, $FF, $00, $53, $00, $00, $C5, $80, $A3, $00, $00, $00, $50
        .byte $50, $80, $FD, $FF, $C5, $80, $A3, $00, $8B, $AC, $E9, $FB, $00, $00, $50, $45
        .byte $80, $5A, $FF, $0B, $53, $00, $04, $D0, $80, $FD, $FF, $00, $00, $46, $44, $80
        .byte $66, $FF, $02, $57, $00, $2C, $C6, $80, $AB, $00, $00, $00, $50, $50, $80, $E7
        .byte $FF, $C6, $80, $AB, $00, $8A, $AF, $80, $FA, $00, $00, $50, $44, $80, $66, $FF
        .byte $0C, $57, $C0, $02, $D0, $80, $E7, $FF, $00, $00, $47, $43, $80, $77, $FF, $04
        .byte $5C, $40, $15, $C7, $80, $B0, $00, $00, $00, $50, $50, $80, $D0, $FF, $C7, $80
        .byte $B0, $00, $89, $B1, $E4, $F8, $00, $00, $50, $43, $80, $77, $FF, $0D, $5C, $9D
        .byte $01, $D0, $80, $D0, $FF, $00, $00, $48, $42, $80, $88, $FF, $06, $61, $AA, $0D
        .byte $C8, $80, $B5, $00, $00, $00, $4F, $4F, $80, $BC, $FF, $C8, $80, $B5, $00, $87
        .byte $B3, $B7, $F5, $00, $00, $4F, $42, $80, $88, $FF, $0D, $61, $C4, $00, $CF, $80
        .byte $BC, $FF, $00, $00, $49, $42, $80, $A0, $FF, $07, $67, $DB, $0A, $C9, $80, $B2
        .byte $00, $00, $00, $4F, $4F, $80, $A6, $FF, $C9, $80, $B2, $00, $86, $B3, $D6, $F2
        .byte $00, $00, $4F, $4F, $80, $A6, $FF, $C2, $80, $A0, $FF, $8D, $67, $C5, $FF, $00
        .byte $00, $4A, $41, $80, $BA, $FF, $09, $6E, $8E, $07, $CA, $80, $AC, $00, $00, $00
        .byte $4E, $4E, $80, $91, $FF, $CA, $80, $AC, $00, $84, $B2, $00, $EB, $00, $00, $4E
        .byte $4E, $80, $91, $FF, $C1, $80, $BA, $FF, $8D, $6E, $C5, $FE, $00, $00, $4B, $41
        .byte $80, $D5, $FF, $0A, $75, $E6, $05, $CB, $80, $A3, $00, $00, $00, $4E, $4E, $80
        .byte $80, $FF, $CB, $80, $A3, $00, $83, $B0, $00, $E3, $00, $00, $4E, $4E, $80, $80
        .byte $FF, $C1, $80, $D5, $FF, $8D, $75, $D9, $FD, $00, $00, $4C, $41, $80, $F1, $FF
        .byte $0B, $7C, $8B, $04, $CC, $80, $9A, $00, $00, $00, $4D, $4D, $80, $72, $FF, $CC
        .byte $80, $9A, $00, $81, $AE, $00, $A7, $00, $00, $4D, $4D, $80, $72, $FF, $C1, $80
        .byte $F1, $FF, $8C, $7C, $C0, $FC, $00, $00, $4D, $41, $80, $0B, $00, $0C, $83, $40
        .byte $03, $CD, $80, $8B, $00, $00, $00, $4D, $4C, $80, $62, $FF, $CD, $80, $8B, $00
        .byte $01, $51, $00, $59, $00, $00, $4C, $4C, $80, $62, $FF, $C1, $80, $0B, $00, $8B
        .byte $83, $75, $FB, $00, $00, $4E, $41, $80, $27, $00, $0D, $8A, $27, $02, $CE, $80
        .byte $7C, $00, $00, $00, $4E, $4B, $80, $59, $FF, $CE, $80, $7C, $00, $03, $4F, $00
        .byte $1D, $00, $00, $4B, $4B, $80, $59, $FF, $C1, $80, $27, $00, $8A, $8A, $1A, $FA
        .byte $00, $00, $4E, $41, $80, $42, $00, $0D, $91, $3B, $01, $CE, $80, $6C, $00, $00
        .byte $00, $4E, $4A, $80, $50, $FF, $CE, $80, $6C, $00, $04, $4D, $00, $15, $00, $00
        .byte $4A, $4A, $80, $50, $FF, $C1, $80, $42, $00, $89, $91, $72, $F8, $00, $00, $4F
        .byte $42, $80, $5D, $00, $0D, $98, $3B, $00, $CF, $80, $57, $00, $00, $00, $4F, $49
        .byte $80, $4A, $FF, $CF, $80, $57, $00, $06, $4C, $2A, $0D, $00, $00, $49, $49, $80
        .byte $4A, $FF, $C2, $80, $5D, $00, $87, $98, $25, $F5, $00, $00, $4F, $4F, $80, $40
        .byte $00, $C2, $80, $74, $00, $8D, $9E, $3C, $FF, $00, $00, $4F, $48, $80, $48, $FF
        .byte $CF, $80, $40, $00, $07, $4C, $49, $0A, $00, $00, $48, $48, $80, $48, $FF, $C2
        .byte $80, $74, $00, $86, $9E, $56, $F2, $00, $00, $50, $50, $80, $2C, $00, $C3, $80
        .byte $85, $00, $8D, $A3, $63, $FE, $00, $00, $50, $47, $80, $4C, $FF, $D0, $80, $2C
        .byte $00, $09, $4E, $1C, $07, $00, $00, $47, $47, $80, $4C, $FF, $C3, $80, $85, $00
        .byte $84, $A3, $C0, $EA, $00, $00, $50, $50, $80, $16, $00, $C4, $80, $96, $00, $8C
        .byte $A8, $40, $FD, $00, $00, $50, $46, $80, $51, $FF, $D0, $80, $16, $00, $0A, $50
        .byte $80, $05, $00, $00, $46, $46, $80, $51, $FF, $C4, $80, $96, $00, $82, $A8, $00
        .byte $D4, $00, $00, $45, $45, $80, $5A, $FF, $00, $53, $00, $00, $C5, $80, $A3, $00
        .byte $00, $00, $50, $50, $80, $FD, $FF, $C5, $80, $A3, $00, $8B, $AC, $E9, $FB, $00
        .byte $00, $50, $45, $80, $5A, $FF, $0B, $53, $00, $04, $D0, $80, $FD, $FF, $00, $00
        .byte $46, $44, $80, $66, $FF, $02, $57, $00, $2C, $C6, $80, $AB, $00, $00, $00, $50
        .byte $50, $80, $E7, $FF, $C6, $80, $AB, $00, $8A, $AF, $80, $FA, $00, $00, $50, $44
        .byte $80, $66, $FF, $0C, $57, $C0, $02, $D0, $80, $E7, $FF, $00, $00, $47, $43, $80
        .byte $77, $FF, $04, $5C, $40, $15, $C7, $80, $B0, $00, $00, $00, $50, $50, $80, $D0
        .byte $FF, $C7, $80, $B0, $00, $89, $B1, $E4, $F8, $00, $00, $50, $43, $80, $77, $FF
        .byte $0D, $5C, $9D, $01, $D0, $80, $D0, $FF, $00, $00, $48, $42, $80, $88, $FF, $06
        .byte $61, $AA, $0D, $C8, $80, $B5, $00, $00, $00, $4F, $4F, $80, $BC, $FF, $C8, $80
        .byte $B5, $00, $87, $B3, $B7, $F5, $00, $00, $4F, $42, $80, $88, $FF, $0D, $61, $C4
        .byte $00, $CF, $80, $BC, $FF, $00, $00, $49, $42, $80, $A0, $FF, $07, $67, $DB, $0A
        .byte $C9, $80, $B2, $00, $00, $00, $4F, $4F, $80, $A6, $FF, $C9, $80, $B2, $00, $86
        .byte $B3, $D6, $F2, $00, $00, $4F, $4F, $80, $A6, $FF, $C2, $80, $A0, $FF, $8D, $67
        .byte $C5, $FF, $00, $00, $4A, $41, $80, $BA, $FF, $09, $6E, $8E, $07, $CA, $80, $AC
        .byte $00, $00, $00, $4E, $4E, $80, $91, $FF, $CA, $80, $AC, $00, $84, $B2, $00, $EB
        .byte $00, $00, $4E, $4E, $80, $91, $FF, $C1, $80, $BA, $FF, $8D, $6E, $C5, $FE, $00
        .byte $00, $4B, $41, $80, $D5, $FF, $0A, $75, $E6, $05, $CB, $80, $A3, $00, $00, $00
        .byte $4E, $4E, $80, $80, $FF, $CB, $80, $A3, $00, $83, $B0, $00, $E3, $00, $00, $4E
        .byte $4E, $80, $80, $FF, $C1, $80, $D5, $FF, $8D, $75, $D9, $FD, $00, $00, $4C, $41
        .byte $80, $F1, $FF, $0B, $7C, $8B, $04, $CC, $80, $9A, $00, $00, $00, $4D, $4D, $80
        .byte $72, $FF, $CC, $80, $9A, $00, $81, $AE, $00, $A7, $00, $00, $4D, $4D, $80, $72
        .byte $FF, $C1, $80, $F1, $FF, $8C, $7C, $C0, $FC, $00, $00, $4D, $41, $80, $0B, $00
        .byte $0C, $83, $40, $03, $CD, $80, $8B, $00, $00, $00, $4D, $4C, $80, $62, $FF, $CD
        .byte $80, $8B, $00, $01, $51, $00, $59, $00, $00, $4C, $4C, $80, $62, $FF, $C1, $80
        .byte $0B, $00, $8B, $83, $75, $FB, $00, $00, $4E, $41, $80, $27, $00, $0D, $8A, $27
        .byte $02, $CE, $80, $7C, $00, $00, $00, $4E, $4B, $80, $59, $FF, $CE, $80, $7C, $00
        .byte $03, $4F, $00, $1D, $00, $00, $4B, $4B, $80, $59, $FF, $C1, $80, $27, $00, $8A
        .byte $8A, $1A, $FA, $00, $00, $4E, $41, $80, $42, $00, $0D, $91, $3B, $01, $CE, $80
        .byte $6C, $00, $00, $00, $4E, $4A, $80, $50, $FF, $CE, $80, $6C, $00, $04, $4D, $00
        .byte $15, $00, $00, $4A, $4A, $80, $50, $FF, $C1, $80, $42, $00, $89, $91, $72, $F8
        .byte $00, $00, $4F, $42, $80, $5D, $00, $0D, $98, $3B, $00, $CF, $80, $57, $00, $00
        .byte $00, $4F, $49, $80, $4A, $FF, $CF, $80, $57, $00, $06, $4C, $2A, $0D, $00, $00
        .byte $49, $49, $80, $4A, $FF, $C2, $80, $5D, $00, $87, $98, $25, $F5, $00, $00, $4F
        .byte $4F, $80, $40, $00, $C2, $80, $74, $00, $8D, $9E, $3C, $FF, $00, $00, $4F, $48
        .byte $80, $48, $FF, $CF, $80, $40, $00, $07, $4C, $49, $0A, $00, $00, $48, $48, $80
        .byte $48, $FF, $C2, $80, $74, $00, $86, $9E, $56, $F2, $00, $00, $50, $50, $80, $2C
        .byte $00, $C3, $80, $85, $00, $8D, $A3, $63, $FE, $00, $00, $50, $47, $80, $4C, $FF
        .byte $D0, $80, $2C, $00, $09, $4E, $1C, $07, $00, $00, $47, $47, $80, $4C, $FF, $C3
        .byte $80, $85, $00, $84, $A3, $C0, $EA, $00, $00, $50, $50, $80, $16, $00, $C4, $80
        .byte $96, $00, $8C, $A8, $40, $FD, $00, $00, $50, $46, $80, $51, $FF, $D0, $80, $16
        .byte $00, $0A, $50, $80, $05, $00, $00, $46, $46, $80, $51, $FF, $C4, $80, $96, $00
        .byte $82, $A8, $00, $D4, $00, $00, $45, $45, $80, $5A, $FF, $00, $53, $00, $00, $C5
        .byte $80, $A3, $00, $00, $00, $50, $50, $80, $FD, $FF, $C5, $80, $A3, $00, $8B, $AC
        .byte $E9, $FB, $00, $00, $50, $45, $80, $5A, $FF, $0B, $53, $00, $04, $D0, $80, $FD
        .byte $FF, $00, $00, $46, $44, $80, $66, $FF, $02, $57, $00, $2C, $C6, $80, $AB, $00
        .byte $00, $00, $50, $50, $80, $E7, $FF, $C6, $80, $AB, $00, $8A, $AF, $80, $FA, $00
        .byte $00, $50, $44, $80, $66, $FF, $0C, $57, $C0, $02, $D0, $80, $E7, $FF, $00, $00
        .byte $47, $43, $80, $77, $FF, $04, $5C, $40, $15, $C7, $80, $B0, $00, $00, $00, $50
        .byte $50, $80, $D0, $FF, $C7, $80, $B0, $00, $89, $B1, $E4, $F8, $00, $00, $50, $43
        .byte $80, $77, $FF, $0D, $5C, $9D, $01, $D0, $80, $D0, $FF, $00, $00, $48, $42, $80
        .byte $88, $FF, $06, $61, $AA, $0D, $C8, $80, $B5, $00, $00, $00, $4F, $4F, $80, $BC
        .byte $FF, $C8, $80, $B5, $00, $87, $B3, $B7, $F5, $00, $00, $4F, $42, $80, $88, $FF
        .byte $0D, $61, $C4, $00, $CF, $80, $BC, $FF, $00, $00, $49, $42, $80, $A0, $FF, $07
        .byte $67, $DB, $0A, $C9, $80, $B2, $00, $00, $00, $4F, $4F, $80, $A6, $FF, $C9, $80
        .byte $B2, $00, $86, $B3, $D6, $F2, $00, $00, $4F, $4F, $80, $A6, $FF, $C2, $80, $A0
        .byte $FF, $8D, $67, $C5, $FF, $00, $00, $4A, $41, $80, $BA, $FF, $09, $6E, $8E, $07
        .byte $CA, $80, $AC, $00, $00, $00, $4E, $4E, $80, $91, $FF, $CA, $80, $AC, $00, $84
        .byte $B2, $00, $EB, $00, $00, $4E, $4E, $80, $91, $FF, $C1, $80, $BA, $FF, $8D, $6E
        .byte $C5, $FE, $00, $00, $4B, $41, $80, $D5, $FF, $0A, $75, $E6, $05, $CB, $80, $A3
        .byte $00, $00, $00, $4E, $4E, $80, $80, $FF, $CB, $80, $A3, $00, $83, $B0, $00, $E3
        .byte $00, $00, $4E, $4E, $80, $80, $FF, $C1, $80, $D5, $FF, $8D, $75, $D9, $FD, $00
        .byte $00, $4C, $41, $80, $F1, $FF, $0B, $7C, $8B, $04, $CC, $80, $9A, $00, $00, $00
        .byte $4D, $4D, $80, $72, $FF, $CC, $80, $9A, $00, $81, $AE, $00, $A7, $00, $00, $4D
        .byte $4D, $80, $72, $FF, $C1, $80, $F1, $FF, $8C, $7C, $C0, $FC, $00, $00, $4D, $41
        .byte $80, $0B, $00, $0C, $83, $40, $03, $CD, $80, $8B, $00, $00, $00, $4D, $4C, $80
        .byte $62, $FF, $CD, $80, $8B, $00, $01, $51, $00, $59, $00, $00, $4C, $4C, $80, $62
        .byte $FF, $C1, $80, $0B, $00, $8B, $83, $75, $FB, $00, $00, $4E, $41, $80, $27, $00
        .byte $0D, $8A, $27, $02, $CE, $80, $7C, $00, $00, $00, $4E, $4B, $80, $59, $FF, $CE
        .byte $80, $7C, $00, $03, $4F, $00, $1D, $00, $00, $4B, $4B, $80, $59, $FF, $C1, $80
        .byte $27, $00, $8A, $8A, $1A, $FA, $00, $00, $4E, $41, $80, $42, $00, $0D, $91, $3B
        .byte $01, $CE, $80, $6C, $00, $00, $00, $4E, $4A, $80, $50, $FF, $CE, $80, $6C, $00
        .byte $04, $4D, $00, $15, $00, $00, $4A, $4A, $80, $50, $FF, $C1, $80, $42, $00, $89
        .byte $91, $72, $F8, $00, $00, $4F, $42, $80, $5D, $00, $0D, $98, $3B, $00, $CF, $80
        .byte $57, $00, $00, $00, $4F, $49, $80, $4A, $FF, $CF, $80, $57, $00, $06, $4C, $2A
        .byte $0D, $00, $00, $49, $49, $80, $4A, $FF, $C2, $80, $5D, $00, $87, $98, $25, $F5
        .byte $00, $00, $4F, $4F, $80, $40, $00, $C2, $80, $74, $00, $8D, $9E, $3C, $FF, $00
        .byte $00, $4F, $48, $80, $48, $FF, $CF, $80, $40, $00, $07, $4C, $49, $0A, $00, $00
        .byte $48, $48, $80, $48, $FF, $C2, $80, $74, $00, $86, $9E, $56, $F2, $00, $00, $50
        .byte $50, $80, $2C, $00, $C3, $80, $85, $00, $8D, $A3, $63, $FE, $00, $00, $50, $47
        .byte $80, $4C, $FF, $D0, $80, $2C, $00, $09, $4E, $1C, $07, $00, $00, $47, $47, $80
        .byte $4C, $FF, $C3, $80, $85, $00, $84, $A3, $C0, $EA, $00, $00, $50, $50, $80, $16
        .byte $00, $C4, $80, $96, $00, $8C, $A8, $40, $FD, $00, $00, $50, $46, $80, $51, $FF
        .byte $D0, $80, $16, $00, $0A, $50, $80, $05, $00, $00, $46, $46, $80, $51, $FF, $C4
        .byte $80, $96, $00, $82, $A8, $00, $D4, $00, $00, $45, $45, $80, $5A, $FF, $00, $53
        .byte $00, $00, $C5, $80, $A3, $00, $00, $00, $50, $50, $80, $FD, $FF, $C5, $80, $A3
        .byte $00, $8B, $AC, $E9, $FB, $00, $00, $50, $45, $80, $5A, $FF, $0B, $53, $00, $04
        .byte $D0, $80, $FD, $FF, $00, $00, $46, $44, $80, $66, $FF, $02, $57, $00, $2C, $C6
        .byte $80, $AB, $00, $00, $00, $50, $50, $80, $E7, $FF, $C6, $80, $AB, $00, $8A, $AF
        .byte $80, $FA, $00, $00, $50, $44, $80, $66, $FF, $0C, $57, $C0, $02, $D0, $80, $E7
        .byte $FF, $00, $00, $47, $43, $80, $77, $FF, $04, $5C, $40, $15, $C7, $80, $B0, $00
        .byte $00, $00, $50, $50, $80, $D0, $FF, $C7, $80, $B0, $00, $89, $B1, $E4, $F8, $00
        .byte $00, $50, $43, $80, $77, $FF, $0D, $5C, $9D, $01, $D0, $80, $D0, $FF, $00, $00
        .byte $48, $42, $80, $88, $FF, $06, $61, $AA, $0D, $C8, $80, $B5, $00, $00, $00, $4F
        .byte $4F, $80, $BC, $FF, $C8, $80, $B5, $00, $87, $B3, $B7, $F5, $00, $00, $4F, $42
        .byte $80, $88, $FF, $0D, $61, $C4, $00, $CF, $80, $BC, $FF, $00, $00, $49, $42, $80
        .byte $A0, $FF, $07, $67, $DB, $0A, $C9, $80, $B2, $00, $00, $00, $4F, $4F, $80, $A6
        .byte $FF, $C9, $80, $B2, $00, $86, $B3, $D6, $F2, $00, $00, $4F, $4F, $80, $A6, $FF
        .byte $C2, $80, $A0, $FF, $8D, $67, $C5, $FF, $00, $00, $4A, $41, $80, $BA, $FF, $09
        .byte $6E, $8E, $07, $CA, $80, $AC, $00, $00, $00, $4E, $4E, $80, $91, $FF, $CA, $80
        .byte $AC, $00, $84, $B2, $00, $EB, $00, $00, $4E, $4E, $80, $91, $FF, $C1, $80, $BA
        .byte $FF, $8D, $6E, $C5, $FE, $00, $00, $4B, $41, $80, $D5, $FF, $0A, $75, $E6, $05
        .byte $CB, $80, $A3, $00, $00, $00, $4E, $4E, $80, $80, $FF, $CB, $80, $A3, $00, $83
        .byte $B0, $00, $E3, $00, $00, $4E, $4E, $80, $80, $FF, $C1, $80, $D5, $FF, $8D, $75
        .byte $D9, $FD, $00, $00, $4C, $41, $80, $F1, $FF, $0B, $7C, $8B, $04, $CC, $80, $9A
        .byte $00, $00, $00, $4D, $4D, $80, $72, $FF, $CC, $80, $9A, $00, $81, $AE, $00, $A7
        .byte $00, $00, $4D, $4D, $80, $72, $FF, $C1, $80, $F1, $FF, $8C, $7C, $C0, $FC, $00
        .byte $00, $4D, $41, $80, $0B, $00, $0C, $83, $40, $03, $CD, $80, $8B, $00, $00, $00
        .byte $4D, $4C, $80, $62, $FF, $CD, $80, $8B, $00, $01, $51, $00, $59, $00, $00, $4C
        .byte $4C, $80, $62, $FF, $C1, $80, $0B, $00, $8B, $83, $75, $FB, $00, $00, $4E, $41
        .byte $80, $27, $00, $0D, $8A, $27, $02, $CE, $80, $7C, $00, $00, $00, $4E, $4B, $80
        .byte $59, $FF, $CE, $80, $7C, $00, $03, $4F, $00, $1D, $00, $00, $4B, $4B, $80, $59
        .byte $FF, $C1, $80, $27, $00, $8A, $8A, $1A, $FA, $00, $00, $4E, $41, $80, $42, $00
        .byte $0D, $91, $3B, $01, $CE, $80, $6C, $00, $00, $00, $4E, $4A, $80, $50, $FF, $CE
        .byte $80, $6C, $00, $04, $4D, $00, $15, $00, $00, $4A, $4A, $80, $50, $FF, $C1, $80
        .byte $42, $00, $89, $91, $72, $F8, $00, $00, $4F, $42, $80, $5D, $00, $0D, $98, $3B
        .byte $00, $CF, $80, $57, $00, $00, $00, $4F, $49, $80, $4A, $FF, $CF, $80, $57, $00
        .byte $06, $4C, $2A, $0D, $00, $00, $49, $49, $80, $4A, $FF, $C2, $80, $5D, $00, $87
        .byte $98, $25, $F5, $00, $00, $4F, $4F, $80, $40, $00, $C2, $80, $74, $00, $8D, $9E
        .byte $3C, $FF, $00, $00, $4F, $48, $80, $48, $FF, $CF, $80, $40, $00, $07, $4C, $49
        .byte $0A, $00, $00, $48, $48, $80, $48, $FF, $C2, $80, $74, $00, $86, $9E, $56, $F2
        .byte $00, $00, $50, $50, $80, $2C, $00, $C3, $80, $85, $00, $8D, $A3, $63, $FE, $00
        .byte $00, $50, $47, $80, $4C, $FF, $D0, $80, $2C, $00, $09, $4E, $1C, $07, $00, $00
        .byte $47, $47, $80, $4C, $FF, $C3, $80, $85, $00, $84, $A3, $C0, $EA, $00, $00, $50
        .byte $50, $80, $16, $00, $C4, $80, $96, $00, $8C, $A8, $40, $FD, $00, $00, $50, $46
        .byte $80, $51, $FF, $D0, $80, $16, $00, $0A, $50, $80, $05, $00, $00, $46, $46, $80
        .byte $51, $FF, $C4, $80, $96, $00, $82, $A8, $00, $D4, $00, $00, $45, $45, $80, $5A
        .byte $FF, $00, $53, $00, $00, $C5, $80, $A3, $00, $00, $00, $50, $50, $80, $FD, $FF
        .byte $C5, $80, $A3, $00, $8B, $AC, $E9, $FB, $00, $00, $50, $45, $80, $5A, $FF, $0B
        .byte $53, $00, $04, $D0, $80, $FD, $FF, $00, $00, $46, $44, $80, $66, $FF, $02, $57
        .byte $00, $2C, $C6, $80, $AB, $00, $00, $00, $50, $50, $80, $E7, $FF, $C6, $80, $AB
        .byte $00, $8A, $AF, $80, $FA, $00, $00, $50, $44, $80, $66, $FF, $0C, $57, $C0, $02
        .byte $D0, $80, $E7, $FF, $00, $00, $47, $43, $80, $77, $FF, $04, $5C, $40, $15, $C7
        .byte $80, $B0, $00, $00, $00, $50, $50, $80, $D0, $FF, $C7, $80, $B0, $00, $89, $B1
        .byte $E4, $F8, $00, $00, $50, $43, $80, $77, $FF, $0D, $5C, $9D, $01, $D0, $80, $D0
        .byte $FF, $00, $00, $48, $42, $80, $88, $FF, $06, $61, $AA, $0D, $C8, $80, $B5, $00
        .byte $00, $00, $4F, $4F, $80, $BC, $FF, $C8, $80, $B5, $00, $87, $B3, $B7, $F5, $00
        .byte $00, $4F, $42, $80, $88, $FF, $0D, $61, $C4, $00, $CF, $80, $BC, $FF, $00, $00
        .byte $49, $42, $80, $A0, $FF, $07, $67, $DB, $0A, $C9, $80, $B2, $00, $00, $00, $4F
        .byte $4F, $80, $A6, $FF, $C9, $80, $B2, $00, $86, $B3, $D6, $F2, $00, $00, $4F, $4F
        .byte $80, $A6, $FF, $C2, $80, $A0, $FF, $8D, $67, $C5, $FF, $00, $00, $4A, $41, $80
        .byte $BA, $FF, $09, $6E, $8E, $07, $CA, $80, $AC, $00, $00, $00, $4E, $4E, $80, $91
        .byte $FF, $CA, $80, $AC, $00, $84, $B2, $00, $EB, $00, $00, $4E, $4E, $80, $91, $FF
        .byte $C1, $80, $BA, $FF, $8D, $6E, $C5, $FE, $00, $00, $4B, $41, $80, $D5, $FF, $0A
        .byte $75, $E6, $05, $CB, $80, $A3, $00, $00, $00, $4E, $4E, $80, $80, $FF, $CB, $80
        .byte $A3, $00, $83, $B0, $00, $E3, $00, $00, $4E, $4E, $80, $80, $FF, $C1, $80, $D5
        .byte $FF, $8D, $75, $D9, $FD, $00, $00, $4C, $41, $80, $F1, $FF, $0B, $7C, $8B, $04
        .byte $CC, $80, $9A, $00, $00, $00, $4D, $4D, $80, $72, $FF, $CC, $80, $9A, $00, $81
        .byte $AE, $00, $A7, $00, $00, $4D, $4D, $80, $72, $FF, $C1, $80, $F1, $FF, $8C, $7C
        .byte $C0, $FC, $00, $00, $4D, $41, $80, $0B, $00, $0C, $83, $40, $03, $CD, $80, $8B
        .byte $00, $00, $00, $4D, $4C, $80, $62, $FF, $CD, $80, $8B, $00, $01, $51, $00, $59
        .byte $00, $00, $4C, $4C, $80, $62, $FF, $C1, $80, $0B, $00, $8B, $83, $75, $FB, $00
        .byte $00, $4E, $41, $80, $27, $00, $0D, $8A, $27, $02, $CE, $80, $7C, $00, $00, $00
        .byte $4E, $4B, $80, $59, $FF, $CE, $80, $7C, $00, $03, $4F, $00, $1D, $00, $00, $4B
        .byte $4B, $80, $59, $FF, $C1, $80, $27, $00, $8A, $8A, $1A, $FA, $00, $00, $4E, $41
        .byte $80, $42, $00, $0D, $91, $3B, $01, $CE, $80, $6C, $00, $00, $00, $4E, $4A, $80
        .byte $50, $FF, $CE, $80, $6C, $00, $04, $4D, $00, $15, $00, $00, $4A, $4A, $80, $50
        .byte $FF, $C1, $80, $42, $00, $89, $91, $72, $F8, $00, $00, $4F, $42, $80, $5D, $00
        .byte $0D, $98, $3B, $00, $CF, $80, $57, $00, $00, $00, $4F, $49, $80, $4A, $FF, $CF
        .byte $80, $57, $00, $06, $4C, $2A, $0D, $00, $00, $49, $49, $80, $4A, $FF, $C2, $80
        .byte $5D, $00, $87, $98, $25, $F5, $00, $00, $4F, $4F, $80, $40, $00, $C2, $80, $74
        .byte $00, $8D, $9E, $3C, $FF, $00, $00, $4F, $48, $80, $48, $FF, $CF, $80, $40, $00
        .byte $07, $4C, $49, $0A, $00, $00, $48, $48, $80, $48, $FF, $C2, $80, $74, $00, $86
        .byte $9E, $56, $F2, $00, $00, $50, $50, $80, $2C, $00, $C3, $80, $85, $00, $8D, $A3
        .byte $63, $FE, $00, $00, $50, $47, $80, $4C, $FF, $D0, $80, $2C, $00, $09, $4E, $1C
        .byte $07, $00, $00, $47, $47, $80, $4C, $FF, $C3, $80, $85, $00, $84, $A3, $C0, $EA
        .byte $00, $00, $50, $50, $80, $16, $00, $C4, $80, $96, $00, $8C, $A8, $40, $FD, $00
        .byte $00, $50, $46, $80, $51, $FF, $D0, $80, $16, $00, $0A, $50, $80, $05, $00, $00
        .byte $46, $46, $80, $51, $FF, $C4, $80, $96, $00, $82, $A8, $00, $D4, $00, $00, $45
        .byte $45, $80, $5A, $FF, $00, $53, $00, $00, $C5, $80, $A3, $00, $00, $00, $50, $50
        .byte $80, $FD, $FF, $C5, $80, $A3, $00, $8B, $AC, $E9, $FB, $00, $00, $50, $45, $80
        .byte $5A, $FF, $0B, $53, $00, $04, $D0, $80, $FD, $FF, $00, $00, $46, $44, $80, $66
        .byte $FF, $02, $57, $00, $2C, $C6, $80, $AB, $00, $00, $00, $50, $50, $80, $E7, $FF
        .byte $C6, $80, $AB, $00, $8A, $AF, $80, $FA, $00, $00, $50, $44, $80, $66, $FF, $0C
        .byte $57, $C0, $02, $D0, $80, $E7, $FF, $00, $00, $47, $43, $80, $77, $FF, $04, $5C
        .byte $40, $15, $C7, $80, $B0, $00, $00, $00, $50, $50, $80, $D0, $FF, $C7, $80, $B0
        .byte $00, $89, $B1, $E4, $F8, $00, $00, $50, $43, $80, $77, $FF, $0D, $5C, $9D, $01
        .byte $D0, $80, $D0, $FF, $00, $00, $48, $42, $80, $88, $FF, $06, $61, $AA, $0D, $C8
        .byte $80, $B5, $00, $00, $00, $4F, $4F, $80, $BC, $FF, $C8, $80, $B5, $00, $87, $B3
        .byte $B7, $F5, $00, $00, $4F, $42, $80, $88, $FF, $0D, $61, $C4, $00, $CF, $80, $BC
        .byte $FF, $00, $00, $49, $42, $80, $A0, $FF, $07, $67, $DB, $0A, $C9, $80, $B2, $00
        .byte $00, $00, $4F, $4F, $80, $A6, $FF, $C9, $80, $B2, $00, $86, $B3, $D6, $F2, $00
        .byte $00, $4F, $4F, $80, $A6, $FF, $C2, $80, $A0, $FF, $8D, $67, $C5, $FF, $00, $00
        .byte $4A, $41, $80, $BA, $FF, $09, $6E, $8E, $07, $CA, $80, $AC, $00, $00, $00, $4E
        .byte $4E, $80, $91, $FF, $CA, $80, $AC, $00, $84, $B2, $00, $EB, $00, $00, $4E, $4E
        .byte $80, $91, $FF, $C1, $80, $BA, $FF, $8D, $6E, $C5, $FE, $00, $00, $4B, $41, $80
        .byte $D5, $FF, $0A, $75, $E6, $05, $CB, $80, $A3, $00, $00, $00, $4E, $4E, $80, $80
        .byte $FF, $CB, $80, $A3, $00, $83, $B0, $00, $E3, $00, $00, $4E, $4E, $80, $80, $FF
        .byte $C1, $80, $D5, $FF, $8D, $75, $D9, $FD, $00, $00, $4C, $41, $80, $F1, $FF, $0B
        .byte $7C, $8B, $04, $CC, $80, $9A, $00, $00, $00, $4D, $4D, $80, $72, $FF, $CC, $80
        .byte $9A, $00, $81, $AE, $00, $A7, $00, $00, $4D, $4D, $80, $72, $FF, $C1, $80, $F1
        .byte $FF, $8C, $7C, $C0, $FC, $00, $00, $4D, $41, $80, $0B, $00, $0C, $83, $40, $03
        .byte $CD, $80, $8B, $00, $00, $00, $4D, $4C, $80, $62, $FF, $CD, $80, $8B, $00, $01
        .byte $51, $00, $59, $00, $00, $4C, $4C, $80, $62, $FF, $C1, $80, $0B, $00, $8B, $83
        .byte $75, $FB, $00, $00, $4E, $41, $80, $27, $00, $0D, $8A, $27, $02, $CE, $80, $7C
        .byte $00, $00, $00, $4E, $4B, $80, $59, $FF, $CE, $80, $7C, $00, $03, $4F, $00, $1D
        .byte $00, $00, $4B, $4B, $80, $59, $FF, $C1, $80, $27, $00, $8A, $8A, $1A, $FA, $00
        .byte $00, $4E, $41, $80, $42, $00, $0D, $91, $3B, $01, $CE, $80, $6C, $00, $00, $00
        .byte $4E, $4A, $80, $50, $FF, $CE, $80, $6C, $00, $04, $4D, $00, $15, $00, $00, $4A
        .byte $4A, $80, $50, $FF, $C1, $80, $42, $00, $89, $91, $72, $F8, $00, $00, $4F, $42
        .byte $80, $5D, $00, $0D, $98, $3B, $00, $CF, $80, $57, $00, $00, $00, $4F, $49, $80
        .byte $4A, $FF, $CF, $80, $57, $00, $06, $4C, $2A, $0D, $00, $00, $49, $49, $80, $4A
        .byte $FF, $C2, $80, $5D, $00, $87, $98, $25, $F5, $00, $00, $4F, $4F, $80, $40, $00
        .byte $C2, $80, $74, $00, $8D, $9E, $3C, $FF, $00, $00, $4F, $48, $80, $48, $FF, $CF
        .byte $80, $40, $00, $07, $4C, $49, $0A, $00, $00, $48, $48, $80, $48, $FF, $C2, $80
        .byte $74, $00, $86, $9E, $56, $F2, $00, $00, $50, $50, $80, $2C, $00, $C3, $80, $85
        .byte $00, $8D, $A3, $63, $FE, $00, $00, $50, $47, $80, $4C, $FF, $D0, $80, $2C, $00
        .byte $09, $4E, $1C, $07, $00, $00, $47, $47, $80, $4C, $FF, $C3, $80, $85, $00, $84
        .byte $A3, $C0, $EA, $00, $00, $50, $50, $80, $16, $00, $C4, $80, $96, $00, $8C, $A8
        .byte $40, $FD, $00, $00, $50, $46, $80, $51, $FF, $D0, $80, $16, $00, $0A, $50, $80
        .byte $05, $00, $00, $46, $46, $80, $51, $FF, $C4, $80, $96, $00, $82, $A8, $00, $D4
        .byte $00, $FF

      _8000_9A87 ; 9A/9A87
        .byte $03, $03, $00, $00, $00, $00, $00, $01, $00, $36, $02, $02, $7F, $00, $00, $82
        .byte $80, $AB, $FF, $00, $80, $00, $01, $00, $FD

      _8000_9AA0 ; 9A/9AA0
        .byte $83, $01, $35, $04, $04, $7E, $33, $00, $84, $81, $9A, $FF, $00, $81, $00, $03
        .byte $01, $35, $05, $05, $7D, $55, $00, $85, $82, $80, $FF, $00, $82, $00, $05, $01
        .byte $34, $07, $07, $7C, $60, $00, $87, $83, $80, $FF, $00, $83, $00, $07, $01, $34
        .byte $08, $08, $7B, $71, $00, $88, $84, $72, $FF, $00, $84, $00, $09, $01, $33, $0A
        .byte $0A, $7B, $5D, $00, $8A, $84, $8C, $FF, $00, $84, $00, $09, $01, $33, $0B, $0B
        .byte $7A, $6A, $00, $8B, $85, $80, $FF, $00, $85, $00, $0B, $01, $32, $0D, $0D, $79
        .byte $6D, $00, $8D, $86, $80, $FF, $00, $86, $00, $0D, $01, $32, $0E, $0E, $78, $77
        .byte $00, $8E, $87, $78, $FF, $00, $87, $00, $0F, $01, $31, $11, $11, $77, $71, $00
        .byte $91, $88, $80, $FF, $00, $88, $00, $11, $01, $30, $13, $13, $76, $73, $00, $93
        .byte $89, $80, $FF, $00, $89, $00, $13, $01, $30, $14, $14, $76, $6D, $00, $94, $89
        .byte $87, $FF, $00, $89, $00, $13, $01, $2F, $16, $16, $75, $6F, $00, $96, $8A, $86
        .byte $FF, $00, $8A, $00, $15, $01, $2F, $17, $17, $74, $75, $00, $97, $8B, $80, $FF
        .byte $00, $8B, $00, $17, $01, $2E, $19, $19, $73, $76, $00, $99, $8C, $80, $FF, $00
        .byte $8C, $00, $19, $01, $2E, $1A, $1A, $72, $7B, $00, $9A, $8D, $7C, $FF, $00, $8D
        .byte $00, $1B, $01, $2D, $1C, $1C, $71, $7B, $00, $9C, $8E, $7C, $FF, $00, $8E, $00
        .byte $1D, $01, $2D, $1D, $1D, $71, $77, $00, $9D, $8E, $80, $FF, $00, $8E, $00, $1D
        .byte $01, $2C, $20, $20, $70, $74, $00, $A0, $8F, $84, $FF, $00, $8F, $00, $1F, $01
        .byte $2B, $22, $22, $6F, $75, $00, $A2, $90, $84, $FF, $00, $90, $00, $21, $01, $2B
        .byte $23, $23, $6E, $78, $00, $A3, $91, $80, $FF, $00, $91, $00, $23, $01, $2A, $25
        .byte $25, $6D, $79, $00, $A5, $92, $80, $FF, $00, $92, $00, $25, $01, $2A, $26, $26
        .byte $6D, $76, $00, $A6, $92, $84, $FF, $00, $92, $00, $25, $01, $29, $28, $28, $6C
        .byte $76, $00, $A8, $93, $84, $FF, $00, $93, $00, $27, $01, $29, $29, $29, $6B, $79
        .byte $00, $A9, $94, $80, $FF, $00, $94, $00, $29, $01, $28, $2B, $2B, $6A, $7A, $00
        .byte $AB, $95, $80, $FF, $00, $95, $00, $2B, $01, $28, $2C, $2C, $69, $7D, $00, $AC
        .byte $96, $7E, $FF, $00, $96, $00, $2D, $01, $27, $2F, $2F, $68, $7A, $00, $AF, $97
        .byte $80, $FF, $00, $97, $00, $2F, $01, $26, $31, $31, $68, $75, $00, $B1, $97, $86
        .byte $FF, $00, $97, $00, $2F, $01, $26, $32, $32, $67, $78, $00, $B2, $98, $83, $FF
        .byte $00, $98, $00, $31, $01, $25, $34, $34, $66, $78, $00, $B4, $99, $83, $FF, $00
        .byte $99, $00, $33, $01, $25, $35, $35, $65, $7B, $00, $B5, $9A, $80, $FF, $00, $9A
        .byte $00, $35, $01, $24, $37, $37, $64, $7B, $00, $B7, $9B, $80, $FF, $00, $9B, $00
        .byte $37, $01, $24, $38, $38, $63, $7D, $00, $B8, $9C, $7E, $FF, $00, $9C, $00, $39
        .byte $01, $23, $3A, $3A, $63, $79, $00, $BA, $9C, $83, $FF, $00, $9C, $00, $39, $01
        .byte $23, $3B, $3B, $62, $7B, $00, $BB, $9D, $80, $FF, $00, $9D, $00, $3B, $01, $22
        .byte $3E, $3E, $61, $79, $00, $BE, $9E, $83, $FF, $00, $9E, $00, $3D, $01, $21, $40
        .byte $40, $60, $7A, $00, $C0, $9F, $82, $FF, $00, $9F, $00, $3F, $01, $21, $41, $41
        .byte $5F, $7C, $00, $C1, $A0, $80, $FF, $00, $A0, $00, $41, $01, $20, $43, $43, $5F
        .byte $78, $00, $C3, $A0, $84, $FF, $00, $A0, $00, $41, $01, $20, $44, $44, $5E, $7A
        .byte $00, $C4, $A1, $82, $FF, $00, $A1, $00, $43, $01, $1F, $46, $46, $5D, $7A, $00
        .byte $C6, $A2, $82, $FF, $00, $A2, $00, $45, $01, $1F, $47, $47, $5C, $7C, $00, $C7
        .byte $A3, $80, $FF, $00, $A3, $00, $47, $01, $1E, $49, $49, $5B, $7C, $00, $C9, $A4
        .byte $80, $FF, $00, $A4, $00, $49, $01, $1E, $4A, $4A, $5A, $7E, $00, $CA, $A5, $7F
        .byte $FF, $00, $A5, $00, $4B, $01, $1D, $4D, $4D, $5A, $79, $00, $CD, $A5, $84, $FF
        .byte $00, $A5, $00, $4B, $01, $1C, $4F, $4F, $59, $79, $00, $CF, $A6, $84, $FF, $00
        .byte $A6, $00, $4D, $01, $1C, $50, $50, $58, $7B, $00, $D0, $A7, $82, $FF, $00, $A7
        .byte $00, $4F, $01, $1B, $52, $52, $57, $7B, $00, $D2, $A8, $82, $FF, $00, $A8, $00
        .byte $51, $01, $1B, $53, $53, $56, $7C, $00, $D3, $A9, $80, $FF, $00, $A9, $00, $53
        .byte $01, $1A, $55, $55, $55, $7D, $00, $D5, $AA, $80, $FF, $00, $AA, $00, $55, $01
        .byte $1A, $56, $56, $55, $7B, $00, $D6, $AA, $82, $FF, $00, $AA, $00, $55, $01, $19
        .byte $58, $58, $54, $7B, $00, $D8, $AB, $82, $FF, $00, $AB, $00, $57, $01, $19, $59
        .byte $59, $53, $7D, $00, $D9, $AC, $80, $FF, $00, $AC, $00, $59, $01, $18, $5C, $5C
        .byte $52, $7B, $00, $DC, $AD, $82, $FF, $00, $AD, $00, $5B, $01, $17, $5E, $5E, $51
        .byte $7B, $00, $DE, $AE, $82, $FF, $00, $AE, $00, $5D, $01, $17, $5F, $5F, $51, $7A
        .byte $00, $DF, $AE, $83, $FF, $00, $AE, $00, $5D, $01, $16, $61, $61, $50, $7A, $00
        .byte $E1, $AF, $83, $FF, $00, $AF, $00, $5F, $01, $16, $62, $62, $4F, $7C, $00, $E2
        .byte $B0, $82, $FF, $00, $B0, $00, $61, $01, $15, $64, $64, $4E, $7C, $00, $E4, $B1
        .byte $82, $FF, $00, $B1, $00, $63, $01, $15, $65, $65, $4D, $7D, $00, $E5, $B2, $80
        .byte $FF, $00, $B2, $00, $65, $01, $14, $67, $67, $4C, $7D, $00, $E7, $B3, $80, $FF
        .byte $00, $B3, $00, $67, $01, $14, $68, $68, $4C, $7C, $00, $E8, $B3, $82, $FF, $00
        .byte $B3, $00, $67, $01, $13, $6B, $6B, $4B, $7B, $00, $EB, $B4, $83, $FF, $00, $B4
        .byte $00, $69, $01, $12, $6D, $6D, $4A, $7B, $00, $ED, $B5, $83, $FF, $00, $B5, $00
        .byte $6B, $01, $12, $6E, $6E, $49, $7C, $00, $EE, $B6, $82, $FF, $00, $B6, $00, $6D
        .byte $01, $11, $70, $70, $48, $7C, $00, $F0, $B7, $82, $FF, $00, $B7, $00, $6F, $01
        .byte $11, $71, $71, $47, $7D, $00, $F1, $B8, $80, $FF, $00, $B8, $00, $71, $01, $10
        .byte $73, $73, $47, $7B, $00, $F3, $B8, $83, $FF, $00, $B8, $00, $71, $01, $10, $74
        .byte $74, $46, $7C, $00, $F4, $B9, $82, $FF, $00, $B9, $00, $73, $01, $0F, $76, $76
        .byte $45, $7C, $00, $F6, $BA, $82, $FF, $00, $BA, $00, $75, $01, $0F, $77, $77, $44
        .byte $7D, $00, $F7, $BB, $80, $FF, $00, $BB, $00, $77, $01, $0E, $7A, $7A, $43, $7C
        .byte $00, $FA, $BC, $82, $FF, $00, $BC, $00, $79, $01, $0D, $7C, $7C, $43, $7A, $00
        .byte $FC, $BC, $84, $FF, $00, $BC, $00, $79, $01, $0D, $7D, $7D, $42, $7B, $00, $FD
        .byte $BD, $83, $FF, $00, $BD, $00, $7B, $01, $0C, $7F, $7F, $41, $7C, $00, $FF, $BE
        .byte $82, $FF, $00, $BE, $00, $7D, $00, $FD

      _8000_9F08 ; 9A/9F08
        .byte $01, $00, $03, $00, $00, $00, $00, $04, $00, $F9, $01, $7F, $7F, $7F, $81, $80
        .byte $7F, $00, $FD

      _8000_9F1B ; 9A/9F1B
        .byte $83, $00, $FF

      _8000_9F1E ; 9A/9F1E
        .byte $81, $00, $FF

      _8000_9F21 ; 9A/9F21
        .byte $03, $22, $03, $00, $00, $00, $06, $01, $02, $38, $00, $01, $80, $00, $00, $81
        .byte $80, $00, $00, $00, $80, $00, $00, $00, $FD

      _8000_9F3A ; 9A/9F3A
        .byte $83, $02, $37, $02, $02, $7F, $00, $00, $82, $80, $00, $00, $00, $80, $80, $FF
        .byte $02, $36, $03, $03, $7F, $00, $00, $83, $7F, $00, $01, $82, $81, $00, $FE, $02
        .byte $34, $06, $06, $7F, $AB, $FF, $85, $7F, $C0, $00, $83, $82, $80, $FD, $02, $33
        .byte $07, $08, $80, $6E, $FF, $87, $80, $6D, $00, $01, $7C, $00, $00, $02, $32, $09
        .byte $08, $81, $25, $FF, $89, $81, $38, $00, $03, $7B, $00, $04, $02, $32, $0B, $07
        .byte $82, $AB, $FE, $8B, $82, $00, $00, $06, $7A, $99, $01, $02, $32, $0D, $04, $84
        .byte $56, $FC, $8D, $84, $C5, $FF, $0B, $79, $CC, $00, $02, $33, $0D, $0D, $79, $76
        .byte $00, $8D, $86, $8A, $FF, $00, $86, $77, $FF, $02, $30, $11, $11, $79, $3C, $00
        .byte $86, $79, $00, $03, $8D, $88, $16, $FF, $02, $2E, $13, $13, $7B, $00, $00, $8B
        .byte $7B, $66, $01, $8A, $89, $72, $FE, $02, $2C, $14, $14, $7D, $C0, $FF, $90, $7D
        .byte $DD, $00, $86, $8A, $67, $FC, $02, $2A, $14, $15, $80, $80, $FF, $94, $80, $73
        .byte $00, $01, $76, $00, $00, $02, $2A, $18, $12, $83, $1F, $FF, $98, $83, $35, $00
        .byte $08, $74, $DB, $02, $02, $2A, $1B, $0F, $86, $93, $FE, $9B, $86, $00, $00, $0E
        .byte $72, $89, $01, $02, $2C, $1C, $08, $8A, $93, $FC, $9C, $8A, $C0, $FF, $16, $72
        .byte $CF, $00, $02, $2F, $1A, $1A, $72, $80, $00, $9A, $8D, $80, $FF, $00, $8D, $77
        .byte $FF, $02, $2A, $20, $20, $74, $38, $00, $8A, $74, $00, $03, $98, $8F, $22, $FF
        .byte $02, $26, $23, $23, $77, $00, $00, $93, $77, $71, $01, $92, $91, $79, $FE, $02
        .byte $23, $23, $23, $7B, $C6, $FF, $9B, $7B, $D8, $00, $8A, $91, $AB, $FC, $02, $21
        .byte $22, $23, $80, $80, $FF, $A2, $80, $78, $00, $01, $6F, $00, $00, $02, $21, $27
        .byte $1E, $85, $24, $FF, $A7, $85, $3B, $00, $0B, $6C, $66, $03, $02, $22, $2B, $17
        .byte $8A, $98, $FE, $AB, $8A, $00, $00, $16, $6B, $79, $01, $02, $25, $2B, $0D, $8F
        .byte $EB, $FC, $AB, $8F, $C5, $FF, $20, $6A, $DE, $00, $02, $2A, $28, $28, $6C, $79
        .byte $00, $A8, $93, $87, $FF, $00, $93, $80, $FF, $02, $24, $2E, $2E, $6F, $37, $00
        .byte $8D, $6F, $40, $03, $A3, $96, $26, $FF, $02, $1F, $31, $31, $73, $00, $00, $9A
        .byte $73, $7A, $01, $99, $98, $76, $FE, $02, $1B, $32, $32, $79, $C3, $FF, $A5, $79
        .byte $DC, $00, $8F, $98, $EE, $FC, $02, $18, $2F, $30, $80, $7E, $FF, $AF, $80, $7D
        .byte $00, $01, $68, $00, $00, $02, $18, $36, $29, $87, $27, $FF, $B6, $87, $38, $00
        .byte $0F, $65, $49, $03, $02, $1B, $39, $1E, $8E, $85, $FE, $B9, $8E, $00, $00, $1D
        .byte $63, $89, $01, $02, $1F, $3A, $11, $94, $F0, $FC, $BA, $94, $C7, $FF, $2B, $63
        .byte $DB, $00, $02, $26, $35, $35, $65, $7D, $00, $B5, $9A, $83, $FF, $00, $9A, $7E
        .byte $FF, $02, $1E, $3D, $3D, $69, $3A, $00, $91, $69, $50, $03, $AE, $9E, $23, $FF
        .byte $02, $17, $41, $41, $6F, $00, $00, $A2, $6F, $7C, $01, $A1, $A0, $78, $FE, $02
        .byte $12, $41, $41, $77, $C5, $FF, $B1, $77, $DA, $00, $92, $A0, $B5, $FC, $02, $10
        .byte $3B, $3C, $80, $7E, $FF, $BB, $80, $7D, $00, $01, $62, $00, $00, $02, $10, $45
        .byte $33, $89, $24, $FF, $C5, $89, $37, $00, $14, $5E, $0D, $03, $02, $13, $49, $26
        .byte $92, $84, $FE, $C9, $92, $00, $00, $25, $5B, $87, $01, $02, $19, $48, $14, $9A
        .byte $BD, $FC, $C8, $9A, $C4, $FF, $36, $5C, $D9, $00, $02, $21, $43, $43, $5F, $7A
        .byte $00, $C3, $A0, $86, $FF, $00, $A0, $82, $FF, $02, $17, $4C, $4C, $64, $39, $00
        .byte $96, $64, $18, $03, $B8, $A5, $21, $FF, $02, $0F, $51, $51, $6C, $00, $00, $AA
        .byte $6C, $70, $01, $A9, $A7, $87, $FE, $02, $09, $50, $50, $75, $C7, $FF, $BC, $75
        .byte $D8, $00, $96, $A7, $C4, $FC, $02, $07, $49, $4A, $80, $7F, $FF, $C9, $80, $7E
        .byte $00, $01, $5B, $00, $00, $02, $07, $54, $3E, $8B, $22, $FF, $D4, $8B, $39, $00
        .byte $18, $56, $21, $03, $02, $0B, $59, $2E, $95, $8F, $FE, $D9, $95, $00, $00, $2D
        .byte $54, $7A, $01, $02, $13, $57, $18, $9F, $BE, $FC, $D7, $9F, $C6, $FF, $41, $54
        .byte $DC, $00, $02, $1D, $50, $50, $58, $7C, $00, $D0, $A7, $84, $FF, $00, $A7, $80
        .byte $FF, $02, $11, $5B, $5B, $5F, $38, $00, $99, $5F, $40, $03, $C4, $AD, $23, $FF
        .byte $02, $07, $61, $61, $68, $00, $00, $B2, $68, $72, $01, $B1, $AF, $86, $FE, $02
        .byte $01, $5F, $5F, $73, $C5, $FF, $C6, $73, $DA, $00, $9B, $AE, $E3, $FC, $02, $00
        .byte $56, $57, $80, $80, $FF, $D6, $80, $7D, $00, $01, $55, $00, $00, $02, $00, $62
        .byte $49, $8D, $24, $FF, $E2, $8D, $39, $00, $1B, $4F, $3B, $03, $02, $04, $67, $35
        .byte $99, $85, $FE, $E7, $99, $00, $00, $34, $4C, $82, $01, $02, $0C, $64, $1D, $A4
        .byte $E5, $FC, $E6, $A4, $C7, $FF, $4B, $4D, $DD, $00, $02, $18, $58, $5E, $51, $7D
        .byte $00, $DE, $AE, $83, $FF, $00, $AE, $80, $FF, $02, $0B, $65, $6A, $59, $39, $00
        .byte $9D, $59, $40, $03, $CF, $B4, $25, $FF, $02, $00, $6F, $6F, $64, $00, $00, $B9
        .byte $64, $7B, $01, $B8, $B7, $7E, $FE, $02, $00, $6E, $6E, $71, $C6, $FF, $D1, $71
        .byte $DC, $00, $9F, $B6, $DE, $FC, $02, $00, $64, $65, $80, $80, $FF, $E4, $80, $7D
        .byte $00, $01, $4E, $00, $00, $02, $00, $70, $54, $8F, $22, $FF, $F1, $8F, $3A, $00
        .byte $1F, $47, $44, $03, $02, $00, $70, $3D, $9D, $89, $FE, $F7, $9D, $00, $00, $3C
        .byte $45, $7D, $01, $02, $06, $6A, $20, $AA, $C7, $FC, $F5, $AA, $C5, $FF, $57, $46
        .byte $D9, $00, $00, $FF

      _8000_A2EE ; 9A/A2EE
        .byte $83, $00, $FF

      _8000_A2F1 ; 9A/A2F1
        .byte $03, $00, $03, $00, $00, $00, $00, $04, $02, $38, $00, $01, $80, $00, $00, $81
        .byte $80, $00, $00, $00, $80, $00, $00, $00, $FD

        ; 9A/A30A

      aUnknown9AA30A ; 9A/A30A

        ; Read by rlUnknown96B517, rsUnknown96B56F, rsUnknown9FEB4F, rsUnknown9FF376.

        .word _A30A_A3AA - aUnknown9AA30A
        .word _A30A_A3AA - aUnknown9AA30A
        .word _A30A_A3AB - aUnknown9AA30A
        .word _A30A_A3AD - aUnknown9AA30A
        .word _A30A_A3B0 - aUnknown9AA30A
        .word _A30A_A3B4 - aUnknown9AA30A
        .word _A30A_A3B9 - aUnknown9AA30A
        .word _A30A_A3BF - aUnknown9AA30A
        .word _A30A_A3C6 - aUnknown9AA30A
        .word _A30A_A3CE - aUnknown9AA30A
        .word _A30A_A3D7 - aUnknown9AA30A
        .word _A30A_A3E1 - aUnknown9AA30A
        .word _A30A_A3EC - aUnknown9AA30A
        .word _A30A_A3F8 - aUnknown9AA30A
        .word _A30A_A405 - aUnknown9AA30A
        .word _A30A_A413 - aUnknown9AA30A
        .word _A30A_A422 - aUnknown9AA30A
        .word _A30A_A432 - aUnknown9AA30A
        .word _A30A_A443 - aUnknown9AA30A
        .word _A30A_A455 - aUnknown9AA30A
        .word _A30A_A468 - aUnknown9AA30A
        .word _A30A_A47C - aUnknown9AA30A
        .word _A30A_A491 - aUnknown9AA30A
        .word _A30A_A4A7 - aUnknown9AA30A
        .word _A30A_A4BE - aUnknown9AA30A
        .word _A30A_A4D6 - aUnknown9AA30A
        .word _A30A_A4EF - aUnknown9AA30A
        .word _A30A_A509 - aUnknown9AA30A
        .word _A30A_A524 - aUnknown9AA30A
        .word _A30A_A540 - aUnknown9AA30A
        .word _A30A_A55D - aUnknown9AA30A
        .word _A30A_A57B - aUnknown9AA30A
        .word _A30A_A59A - aUnknown9AA30A
        .word _A30A_A5BA - aUnknown9AA30A
        .word _A30A_A5DC - aUnknown9AA30A
        .word _A30A_A600 - aUnknown9AA30A
        .word _A30A_A626 - aUnknown9AA30A
        .word _A30A_A64E - aUnknown9AA30A
        .word _A30A_A678 - aUnknown9AA30A
        .word _A30A_A6A4 - aUnknown9AA30A
        .word _A30A_A6D2 - aUnknown9AA30A
        .word _A30A_A702 - aUnknown9AA30A
        .word _A30A_A734 - aUnknown9AA30A
        .word _A30A_A768 - aUnknown9AA30A
        .word _A30A_A79E - aUnknown9AA30A
        .word _A30A_A7D6 - aUnknown9AA30A
        .word _A30A_A810 - aUnknown9AA30A
        .word _A30A_A84C - aUnknown9AA30A
        .word _A30A_A88A - aUnknown9AA30A
        .word _A30A_A8CA - aUnknown9AA30A
        .word _A30A_A90E - aUnknown9AA30A
        .word _A30A_A956 - aUnknown9AA30A
        .word _A30A_A9A2 - aUnknown9AA30A
        .word _A30A_A9F2 - aUnknown9AA30A
        .word _A30A_AA46 - aUnknown9AA30A
        .word _A30A_AA9E - aUnknown9AA30A
        .word _A30A_AAFA - aUnknown9AA30A
        .word _A30A_AB5A - aUnknown9AA30A
        .word _A30A_ABBE - aUnknown9AA30A
        .word _A30A_AC26 - aUnknown9AA30A
        .word _A30A_AC92 - aUnknown9AA30A
        .word _A30A_AD02 - aUnknown9AA30A
        .word _A30A_AD76 - aUnknown9AA30A
        .word _A30A_ADEE - aUnknown9AA30A
        .word _A30A_AE6A - aUnknown9AA30A
        .word _A30A_AEEA - aUnknown9AA30A
        .word _A30A_AF72 - aUnknown9AA30A
        .word _A30A_B002 - aUnknown9AA30A
        .word _A30A_B09A - aUnknown9AA30A
        .word _A30A_B13A - aUnknown9AA30A
        .word _A30A_B1E2 - aUnknown9AA30A
        .word _A30A_B292 - aUnknown9AA30A
        .word _A30A_B34A - aUnknown9AA30A
        .word _A30A_B40A - aUnknown9AA30A
        .word _A30A_B4D2 - aUnknown9AA30A
        .word _A30A_B5A2 - aUnknown9AA30A
        .word _A30A_B67A - aUnknown9AA30A
        .word _A30A_B75A - aUnknown9AA30A
        .word _A30A_B842 - aUnknown9AA30A
        .word _A30A_B932 - aUnknown9AA30A

      _A30A_A3AA ; 9A/A3AA
        .byte $00

      _A30A_A3AB ; 9A/A3AB
        .byte $01, $01

      _A30A_A3AD ; 9A/A3AD
        .byte $01, $02, $02

      _A30A_A3B0 ; 9A/A3B0
        .byte $02, $02, $03, $03

      _A30A_A3B4 ; 9A/A3B4
        .byte $02, $03, $03, $04, $04

      _A30A_A3B9 ; 9A/A3B9
        .byte $02, $03, $04, $04, $05, $05

      _A30A_A3BF ; 9A/A3BF
        .byte $03, $04, $04, $05, $05, $05, $05

      _A30A_A3C6 ; 9A/A3C6
        .byte $03, $04, $05, $05, $06, $06, $06, $06

      _A30A_A3CE ; 9A/A3CE
        .byte $03, $04, $05, $06, $06, $07, $07, $07, $07

      _A30A_A3D7 ; 9A/A3D7
        .byte $03, $05, $06, $06, $07, $07, $08, $08, $08, $08

      _A30A_A3E1 ; 9A/A3E1
        .byte $03, $05, $06, $07, $07, $08, $08, $08, $09, $09, $09

      _A30A_A3EC ; 9A/A3EC
        .byte $04, $05, $06, $07, $08, $08, $09, $09, $09, $0A, $0A, $0A

      _A30A_A3F8 ; 9A/A3F8
        .byte $04, $05, $07, $07, $08, $09, $09, $0A, $0A, $0A, $0A, $0A, $0B

      _A30A_A405 ; 9A/A405
        .byte $04, $06, $07, $08, $09, $09, $0A, $0A, $0B, $0B, $0B, $0B, $0B, $0B

      _A30A_A413 ; 9A/A413
        .byte $04, $06, $07, $08, $09, $0A, $0A, $0B, $0B, $0B, $0C, $0C, $0C, $0C, $0C

      _A30A_A422 ; 9A/A422
        .byte $04, $06, $07, $08, $09, $0A, $0B, $0B, $0C, $0C, $0C, $0D, $0D, $0D, $0D, $0D

      _A30A_A432 ; 9A/A432
        .byte $04, $06, $08, $09, $0A, $0A, $0B, $0C, $0C, $0D, $0D, $0D, $0E, $0E, $0E, $0E
        .byte $0E

      _A30A_A443 ; 9A/A443
        .byte $05, $06, $08, $09, $0A, $0B, $0C, $0C, $0D, $0D, $0E, $0E, $0E, $0E, $0F, $0F
        .byte $0F, $0F

      _A30A_A455 ; 9A/A455
        .byte $05, $07, $08, $09, $0A, $0B, $0C, $0D, $0D, $0E, $0E, $0E, $0F, $0F, $0F, $0F
        .byte $10, $10, $10

      _A30A_A468 ; 9A/A468
        .byte $05, $07, $08, $0A, $0B, $0C, $0C, $0D, $0E, $0E, $0F, $0F, $0F, $10, $10, $10
        .byte $10, $10, $10, $10

      _A30A_A47C ; 9A/A47C
        .byte $05, $07, $09, $0A, $0B, $0C, $0D, $0D, $0E, $0F, $0F, $10, $10, $10, $11, $11
        .byte $11, $11, $11, $11, $11

      _A30A_A491 ; 9A/A491
        .byte $05, $07, $09, $0A, $0B, $0C, $0D, $0E, $0F, $0F, $10, $10, $11, $11, $11, $11
        .byte $12, $12, $12, $12, $12, $12

      _A30A_A4A7 ; 9A/A4A7
        .byte $05, $07, $09, $0A, $0C, $0D, $0E, $0E, $0F, $10, $10, $11, $11, $11, $12, $12
        .byte $12, $13, $13, $13, $13, $13, $13

      _A30A_A4BE ; 9A/A4BE
        .byte $05, $08, $09, $0B, $0C, $0D, $0E, $0F, $0F, $10, $11, $11, $12, $12, $12, $13
        .byte $13, $13, $13, $14, $14, $14, $14, $14

      _A30A_A4D6 ; 9A/A4D6
        .byte $05, $08, $0A, $0B, $0C, $0D, $0E, $0F, $10, $10, $11, $12, $12, $13, $13, $13
        .byte $14, $14, $14, $14, $14, $15, $15, $15, $15

      _A30A_A4EF ; 9A/A4EF
        .byte $06, $08, $0A, $0B, $0C, $0E, $0F, $0F, $10, $11, $11, $12, $13, $13, $13, $14
        .byte $14, $14, $15, $15, $15, $15, $15, $15, $16, $16

      _A30A_A509 ; 9A/A509
        .byte $06, $08, $0A, $0B, $0D, $0E, $0F, $10, $11, $11, $12, $13, $13, $14, $14, $14
        .byte $15, $15, $15, $16, $16, $16, $16, $16, $16, $16, $16

      _A30A_A524 ; 9A/A524
        .byte $06, $08, $0A, $0C, $0D, $0E, $0F, $10, $11, $12, $12, $13, $14, $14, $15, $15
        .byte $15, $16, $16, $16, $16, $17, $17, $17, $17, $17, $17, $17

      _A30A_A540 ; 9A/A540
        .byte $06, $08, $0A, $0C, $0D, $0E, $10, $10, $11, $12, $13, $13, $14, $15, $15, $15
        .byte $16, $16, $17, $17, $17, $17, $18, $18, $18, $18, $18, $18, $18

      _A30A_A55D ; 9A/A55D
        .byte $06, $09, $0B, $0C, $0E, $0F, $10, $11, $12, $12, $13, $14, $14, $15, $16, $16
        .byte $16, $17, $17, $17, $18, $18, $18, $18, $19, $19, $19, $19, $19, $19

      _A30A_A57B ; 9A/A57B
        .byte $06, $09, $0B, $0C, $0E, $0F, $10, $11, $12, $13, $14, $14, $15, $15, $16, $16
        .byte $17, $17, $18, $18, $18, $19, $19, $19, $19, $19, $1A, $1A, $1A, $1A, $1A

      _A30A_A59A ; 9A/A59A
        .byte $06, $09, $0B, $0D, $0E, $0F, $10, $11, $12, $13, $14, $15, $15, $16, $16, $17
        .byte $17, $18, $18, $19, $19, $19, $1A, $1A, $1A, $1A, $1A, $1A, $1A, $1B, $1B, $1B

      _A30A_A5BA ; 9A/A5BA
        .byte $06, $09, $0B, $0D, $0F, $10, $11, $12, $13, $14, $15, $15, $16, $17, $17, $18
        .byte $18, $19, $19, $1A, $1A, $1A, $1B, $1B, $1B, $1C, $1C, $1C, $1C, $1C, $1C, $1C
        .byte $1C, $1C

      _A30A_A5DC ; 9A/A5DC
        .byte $07, $0A, $0C, $0D, $0F, $10, $12, $13, $14, $15, $15, $16, $17, $18, $18, $19
        .byte $19, $1A, $1A, $1B, $1B, $1C, $1C, $1C, $1D, $1D, $1D, $1D, $1D, $1E, $1E, $1E
        .byte $1E, $1E, $1E, $1E

      _A30A_A600 ; 9A/A600
        .byte $07, $0A, $0C, $0E, $0F, $11, $12, $13, $14, $15, $16, $17, $18, $18, $19, $1A
        .byte $1A, $1B, $1B, $1C, $1C, $1D, $1D, $1D, $1E, $1E, $1E, $1F, $1F, $1F, $1F, $1F
        .byte $1F, $20, $20, $20, $20, $20

      _A30A_A626 ; 9A/A626
        .byte $07, $0A, $0C, $0E, $10, $11, $13, $14, $15, $16, $17, $18, $19, $19, $1A, $1B
        .byte $1B, $1C, $1C, $1D, $1D, $1E, $1E, $1F, $1F, $1F, $20, $20, $20, $20, $21, $21
        .byte $21, $21, $21, $21, $21, $21, $21, $21

      _A30A_A64E ; 9A/A64E
        .byte $07, $0A, $0D, $0F, $10, $12, $13, $14, $16, $17, $18, $18, $19, $1A, $1B, $1B
        .byte $1C, $1D, $1D, $1E, $1E, $1F, $1F, $20, $20, $20, $21, $21, $21, $22, $22, $22
        .byte $22, $22, $23, $23, $23, $23, $23, $23, $23, $23

      _A30A_A678 ; 9A/A678
        .byte $07, $0B, $0D, $0F, $11, $12, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1C
        .byte $1D, $1E, $1E, $1F, $1F, $20, $20, $21, $21, $22, $22, $22, $23, $23, $23, $23
        .byte $24, $24, $24, $24, $24, $24, $25, $25, $25, $25, $25, $25

      _A30A_A6A4 ; 9A/A6A4
        .byte $08, $0B, $0D, $0F, $11, $13, $14, $15, $17, $18, $19, $1A, $1B, $1C, $1C, $1D
        .byte $1E, $1E, $1F, $20, $20, $21, $21, $22, $22, $23, $23, $23, $24, $24, $24, $25
        .byte $25, $25, $25, $26, $26, $26, $26, $26, $26, $26, $26, $26, $26, $26

      _A30A_A6D2 ; 9A/A6D2
        .byte $08, $0B, $0E, $10, $12, $13, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E
        .byte $1F, $1F, $20, $21, $21, $22, $22, $23, $23, $24, $24, $24, $25, $25, $26, $26
        .byte $26, $26, $27, $27, $27, $27, $27, $28, $28, $28, $28, $28, $28, $28, $28, $28

      _A30A_A702 ; 9A/A702
        .byte $08, $0B, $0E, $10, $12, $14, $15, $16, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
        .byte $1F, $20, $21, $21, $22, $23, $23, $24, $24, $25, $25, $26, $26, $26, $27, $27
        .byte $27, $28, $28, $28, $28, $29, $29, $29, $29, $29, $29, $2A, $2A, $2A, $2A, $2A
        .byte $2A, $2A

      _A30A_A734 ; 9A/A734
        .byte $08, $0C, $0E, $10, $12, $14, $16, $17, $18, $19, $1B, $1C, $1D, $1E, $1E, $1F
        .byte $20, $21, $22, $22, $23, $23, $24, $25, $25, $26, $26, $27, $27, $27, $28, $28
        .byte $29, $29, $29, $29, $2A, $2A, $2A, $2A, $2B, $2B, $2B, $2B, $2B, $2B, $2B, $2B
        .byte $2B, $2C, $2C, $2C

      _A30A_A768 ; 9A/A768
        .byte $08, $0C, $0F, $11, $13, $14, $16, $17, $19, $1A, $1B, $1C, $1D, $1E, $1F, $20
        .byte $21, $22, $22, $23, $24, $24, $25, $26, $26, $27, $27, $28, $28, $28, $29, $29
        .byte $2A, $2A, $2A, $2B, $2B, $2B, $2B, $2C, $2C, $2C, $2C, $2C, $2D, $2D, $2D, $2D
        .byte $2D, $2D, $2D, $2D, $2D, $2D

      _A30A_A79E ; 9A/A79E
        .byte $08, $0C, $0F, $11, $13, $15, $16, $18, $19, $1B, $1C, $1D, $1E, $1F, $20, $21
        .byte $22, $22, $23, $24, $25, $25, $26, $26, $27, $28, $28, $29, $29, $2A, $2A, $2A
        .byte $2B, $2B, $2B, $2C, $2C, $2C, $2D, $2D, $2D, $2D, $2E, $2E, $2E, $2E, $2E, $2E
        .byte $2F, $2F, $2F, $2F, $2F, $2F, $2F, $2F

      _A30A_A7D6 ; 9A/A7D6
        .byte $09, $0C, $0F, $11, $13, $15, $17, $18, $1A, $1B, $1C, $1D, $1F, $20, $20, $21
        .byte $22, $23, $24, $25, $25, $26, $27, $27, $28, $28, $29, $2A, $2A, $2B, $2B, $2B
        .byte $2C, $2C, $2D, $2D, $2D, $2E, $2E, $2E, $2E, $2F, $2F, $2F, $2F, $30, $30, $30
        .byte $30, $30, $30, $30, $30, $31, $31, $31, $31, $31

      _A30A_A810 ; 9A/A810
        .byte $09, $0D, $0F, $12, $14, $16, $17, $19, $1A, $1C, $1D, $1E, $1F, $20, $21, $22
        .byte $23, $24, $25, $25, $26, $27, $28, $28, $29, $29, $2A, $2B, $2B, $2C, $2C, $2C
        .byte $2D, $2D, $2E, $2E, $2E, $2F, $2F, $2F, $30, $30, $30, $31, $31, $31, $31, $31
        .byte $31, $32, $32, $32, $32, $32, $32, $32, $32, $32, $32, $32

      _A30A_A84C ; 9A/A84C
        .byte $09, $0D, $10, $12, $14, $16, $18, $19, $1B, $1C, $1D, $1F, $20, $21, $22, $23
        .byte $24, $25, $25, $26, $27, $28, $28, $29, $2A, $2A, $2B, $2B, $2C, $2D, $2D, $2D
        .byte $2E, $2E, $2F, $2F, $30, $30, $30, $31, $31, $31, $32, $32, $32, $32, $32, $33
        .byte $33, $33, $33, $33, $33, $34, $34, $34, $34, $34, $34, $34, $34, $34

      _A30A_A88A ; 9A/A88A
        .byte $09, $0D, $10, $12, $15, $16, $18, $1A, $1B, $1D, $1E, $1F, $20, $21, $22, $23
        .byte $24, $25, $26, $27, $28, $28, $29, $2A, $2B, $2B, $2C, $2C, $2D, $2D, $2E, $2E
        .byte $2F, $2F, $30, $30, $31, $31, $31, $32, $32, $32, $33, $33, $33, $34, $34, $34
        .byte $34, $34, $35, $35, $35, $35, $35, $35, $35, $35, $36, $36, $36, $36, $36, $36

      _A30A_A8CA ; 9A/A8CA
        .byte $09, $0D, $10, $13, $15, $17, $19, $1B, $1C, $1E, $1F, $20, $21, $23, $24, $25
        .byte $26, $27, $27, $28, $29, $2A, $2B, $2B, $2C, $2D, $2D, $2E, $2F, $2F, $30, $30
        .byte $31, $31, $32, $32, $33, $33, $34, $34, $34, $35, $35, $35, $36, $36, $36, $37
        .byte $37, $37, $37, $38, $38, $38, $38, $38, $38, $39, $39, $39, $39, $39, $39, $39
        .byte $39, $39, $39, $39

      _A30A_A90E ; 9A/A90E
        .byte $0A, $0E, $11, $14, $16, $18, $1A, $1B, $1D, $1F, $20, $21, $22, $24, $25, $26
        .byte $27, $28, $29, $2A, $2B, $2B, $2C, $2D, $2E, $2E, $2F, $30, $30, $31, $32, $32
        .byte $33, $33, $34, $34, $35, $35, $36, $36, $37, $37, $37, $38, $38, $38, $39, $39
        .byte $39, $3A, $3A, $3A, $3A, $3B, $3B, $3B, $3B, $3B, $3C, $3C, $3C, $3C, $3C, $3C
        .byte $3C, $3C, $3C, $3C, $3C, $3C, $3D, $3D

      _A30A_A956 ; 9A/A956
        .byte $0A, $0E, $11, $14, $16, $19, $1A, $1C, $1E, $1F, $21, $22, $24, $25, $26, $27
        .byte $28, $29, $2A, $2B, $2C, $2D, $2E, $2E, $2F, $30, $31, $31, $32, $33, $33, $34
        .byte $35, $35, $36, $36, $37, $37, $38, $38, $39, $39, $3A, $3A, $3A, $3B, $3B, $3B
        .byte $3C, $3C, $3C, $3D, $3D, $3D, $3D, $3E, $3E, $3E, $3E, $3E, $3F, $3F, $3F, $3F
        .byte $3F, $3F, $3F, $40, $40, $40, $40, $40, $40, $40, $40, $40

      _A30A_A9A2 ; 9A/A9A2
        .byte $0A, $0F, $12, $15, $17, $19, $1B, $1D, $1F, $20, $22, $23, $25, $26, $27, $28
        .byte $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $32, $32, $33, $34, $34, $35, $36
        .byte $36, $37, $38, $38, $39, $39, $3A, $3A, $3B, $3B, $3C, $3C, $3C, $3D, $3D, $3E
        .byte $3E, $3E, $3F, $3F, $3F, $40, $40, $40, $40, $41, $41, $41, $41, $42, $42, $42
        .byte $42, $42, $42, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43, $43

      _A30A_A9F2 ; 9A/A9F2
        .byte $0A, $0F, $12, $15, $18, $1A, $1C, $1E, $20, $21, $23, $24, $26, $27, $28, $29
        .byte $2A, $2C, $2D, $2E, $2F, $30, $30, $31, $32, $33, $34, $35, $35, $36, $37, $37
        .byte $38, $39, $39, $3A, $3B, $3B, $3C, $3C, $3D, $3D, $3E, $3E, $3F, $3F, $3F, $40
        .byte $40, $41, $41, $41, $42, $42, $42, $43, $43, $43, $43, $44, $44, $44, $44, $45
        .byte $45, $45, $45, $45, $46, $46, $46, $46, $46, $46, $46, $46, $46, $47, $47, $47
        .byte $47, $47, $47, $47

      _A30A_AA46 ; 9A/AA46
        .byte $0B, $0F, $13, $16, $18, $1B, $1D, $1F, $20, $22, $24, $25, $27, $28, $29, $2A
        .byte $2C, $2D, $2E, $2F, $30, $31, $32, $33, $34, $34, $35, $36, $37, $38, $38, $39
        .byte $3A, $3A, $3B, $3C, $3C, $3D, $3D, $3E, $3F, $3F, $40, $40, $41, $41, $41, $42
        .byte $42, $43, $43, $44, $44, $44, $45, $45, $45, $46, $46, $46, $46, $47, $47, $47
        .byte $47, $48, $48, $48, $48, $48, $49, $49, $49, $49, $49, $49, $49, $4A, $4A, $4A
        .byte $4A, $4A, $4A, $4A, $4A, $4A, $4A, $4A

      _A30A_AA9E ; 9A/AA9E
        .byte $0B, $10, $13, $16, $19, $1B, $1D, $1F, $21, $23, $24, $26, $27, $29, $2A, $2B
        .byte $2D, $2E, $2F, $30, $31, $32, $33, $34, $35, $36, $37, $38, $38, $39, $3A, $3B
        .byte $3B, $3C, $3D, $3D, $3E, $3F, $3F, $40, $40, $41, $41, $42, $43, $43, $44, $44
        .byte $44, $45, $45, $46, $46, $47, $47, $47, $48, $48, $48, $49, $49, $49, $49, $4A
        .byte $4A, $4A, $4B, $4B, $4B, $4B, $4B, $4C, $4C, $4C, $4C, $4C, $4C, $4D, $4D, $4D
        .byte $4D, $4D, $4D, $4D, $4D, $4D, $4D, $4D, $4D, $4D, $4D, $4D

      _A30A_AAFA ; 9A/AAFA
        .byte $0B, $10, $14, $17, $19, $1C, $1E, $20, $22, $24, $25, $27, $28, $2A, $2B, $2C
        .byte $2E, $2F, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3B, $3C
        .byte $3D, $3E, $3E, $3F, $40, $40, $41, $42, $42, $43, $43, $44, $44, $45, $45, $46
        .byte $46, $47, $47, $48, $48, $49, $49, $49, $4A, $4A, $4B, $4B, $4B, $4C, $4C, $4C
        .byte $4C, $4D, $4D, $4D, $4E, $4E, $4E, $4E, $4E, $4F, $4F, $4F, $4F, $4F, $50, $50
        .byte $50, $50, $50, $50, $50, $50, $50, $51, $51, $51, $51, $51, $51, $51, $51, $51

      _A30A_AB5A ; 9A/AB5A
        .byte $0B, $10, $14, $17, $1A, $1C, $1F, $21, $23, $24, $26, $28, $29, $2B, $2C, $2D
        .byte $2F, $30, $31, $32, $33, $35, $36, $37, $38, $39, $39, $3A, $3B, $3C, $3D, $3E
        .byte $3E, $3F, $40, $41, $41, $42, $43, $43, $44, $45, $45, $46, $46, $47, $47, $48
        .byte $48, $49, $49, $4A, $4A, $4B, $4B, $4C, $4C, $4C, $4D, $4D, $4E, $4E, $4E, $4F
        .byte $4F, $4F, $4F, $50, $50, $50, $51, $51, $51, $51, $52, $52, $52, $52, $52, $53
        .byte $53, $53, $53, $53, $53, $53, $54, $54, $54, $54, $54, $54, $54, $54, $54, $54
        .byte $54, $54, $54, $54

      _A30A_ABBE ; 9A/ABBE
        .byte $0C, $11, $15, $18, $1A, $1D, $1F, $21, $23, $25, $27, $29, $2A, $2C, $2D, $2E
        .byte $30, $31, $32, $33, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3D, $3E, $3F
        .byte $40, $41, $41, $42, $43, $44, $44, $45, $46, $46, $47, $47, $48, $49, $49, $4A
        .byte $4A, $4B, $4B, $4C, $4C, $4D, $4D, $4E, $4E, $4F, $4F, $4F, $50, $50, $50, $51
        .byte $51, $52, $52, $52, $52, $53, $53, $53, $54, $54, $54, $54, $55, $55, $55, $55
        .byte $55, $56, $56, $56, $56, $56, $56, $57, $57, $57, $57, $57, $57, $57, $57, $57
        .byte $57, $57, $58, $58, $58, $58, $58, $58

      _A30A_AC26 ; 9A/AC26
        .byte $0C, $11, $15, $18, $1B, $1E, $20, $22, $24, $26, $28, $29, $2B, $2D, $2E, $2F
        .byte $31, $32, $33, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41
        .byte $41, $42, $43, $44, $44, $45, $46, $47, $47, $48, $49, $49, $4A, $4A, $4B, $4C
        .byte $4C, $4D, $4D, $4E, $4E, $4F, $4F, $50, $50, $51, $51, $51, $52, $52, $53, $53
        .byte $53, $54, $54, $55, $55, $55, $55, $56, $56, $56, $57, $57, $57, $57, $58, $58
        .byte $58, $58, $59, $59, $59, $59, $59, $59, $5A, $5A, $5A, $5A, $5A, $5A, $5A, $5A
        .byte $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B, $5B

      _A30A_AC92 ; 9A/AC92
        .byte $0C, $11, $15, $19, $1C, $1E, $21, $23, $25, $27, $29, $2A, $2C, $2D, $2F, $30
        .byte $32, $33, $34, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41, $42
        .byte $43, $44, $44, $45, $46, $47, $47, $48, $49, $4A, $4A, $4B, $4C, $4C, $4D, $4D
        .byte $4E, $4F, $4F, $50, $50, $51, $51, $52, $52, $53, $53, $54, $54, $54, $55, $55
        .byte $56, $56, $56, $57, $57, $57, $58, $58, $58, $59, $59, $59, $5A, $5A, $5A, $5A
        .byte $5B, $5B, $5B, $5B, $5C, $5C, $5C, $5C, $5C, $5D, $5D, $5D, $5D, $5D, $5D, $5D
        .byte $5E, $5E, $5E, $5E, $5E, $5E, $5E, $5E, $5E, $5E, $5E, $5E, $5E, $5E, $5E, $5E

      _A30A_AD02 ; 9A/AD02
        .byte $0C, $12, $16, $19, $1C, $1F, $21, $23, $25, $27, $29, $2B, $2D, $2E, $30, $31
        .byte $33, $34, $35, $37, $38, $39, $3A, $3B, $3C, $3E, $3F, $40, $41, $41, $42, $43
        .byte $44, $45, $46, $47, $47, $48, $49, $4A, $4A, $4B, $4C, $4D, $4D, $4E, $4F, $4F
        .byte $50, $50, $51, $51, $52, $53, $53, $54, $54, $55, $55, $56, $56, $57, $57, $57
        .byte $58, $58, $59, $59, $59, $5A, $5A, $5A, $5B, $5B, $5B, $5C, $5C, $5C, $5D, $5D
        .byte $5D, $5D, $5E, $5E, $5E, $5E, $5F, $5F, $5F, $5F, $5F, $60, $60, $60, $60, $60
        .byte $60, $61, $61, $61, $61, $61, $61, $61, $61, $61, $62, $62, $62, $62, $62, $62
        .byte $62, $62, $62, $62

      _A30A_AD76 ; 9A/AD76
        .byte $0D, $12, $16, $1A, $1D, $1F, $22, $24, $26, $28, $2A, $2C, $2E, $2F, $31, $32
        .byte $34, $35, $36, $38, $39, $3A, $3B, $3D, $3E, $3F, $40, $41, $42, $43, $44, $45
        .byte $46, $46, $47, $48, $49, $4A, $4B, $4B, $4C, $4D, $4D, $4E, $4F, $50, $50, $51
        .byte $51, $52, $53, $53, $54, $54, $55, $56, $56, $57, $57, $58, $58, $59, $59, $59
        .byte $5A, $5A, $5B, $5B, $5C, $5C, $5C, $5D, $5D, $5D, $5E, $5E, $5E, $5F, $5F, $5F
        .byte $60, $60, $60, $61, $61, $61, $61, $62, $62, $62, $62, $62, $63, $63, $63, $63
        .byte $63, $63, $64, $64, $64, $64, $64, $64, $64, $65, $65, $65, $65, $65, $65, $65
        .byte $65, $65, $65, $65, $65, $65, $65, $65

      _A30A_ADEE ; 9A/ADEE
        .byte $0D, $12, $16, $1A, $1D, $20, $22, $25, $27, $29, $2B, $2D, $2E, $30, $32, $33
        .byte $35, $36, $37, $39, $3A, $3B, $3C, $3E, $3F, $40, $41, $42, $43, $44, $45, $46
        .byte $47, $48, $49, $4A, $4A, $4B, $4C, $4D, $4E, $4E, $4F, $50, $50, $51, $52, $53
        .byte $53, $54, $54, $55, $56, $56, $57, $57, $58, $58, $59, $5A, $5A, $5B, $5B, $5B
        .byte $5C, $5C, $5D, $5D, $5E, $5E, $5F, $5F, $5F, $60, $60, $60, $61, $61, $61, $62
        .byte $62, $62, $63, $63, $63, $64, $64, $64, $64, $65, $65, $65, $65, $65, $66, $66
        .byte $66, $66, $66, $67, $67, $67, $67, $67, $67, $67, $68, $68, $68, $68, $68, $68
        .byte $68, $68, $68, $68, $68, $68, $68, $69, $69, $69, $69, $69

      _A30A_AE6A ; 9A/AE6A
        .byte $0D, $13, $17, $1A, $1E, $20, $23, $25, $27, $2A, $2B, $2D, $2F, $31, $32, $34
        .byte $36, $37, $38, $3A, $3B, $3C, $3E, $3F, $40, $41, $42, $43, $44, $45, $46, $47
        .byte $48, $49, $4A, $4B, $4C, $4D, $4D, $4E, $4F, $50, $51, $51, $52, $53, $53, $54
        .byte $55, $56, $56, $57, $57, $58, $59, $59, $5A, $5A, $5B, $5B, $5C, $5C, $5D, $5D
        .byte $5E, $5E, $5F, $5F, $60, $60, $61, $61, $61, $62, $62, $63, $63, $63, $64, $64
        .byte $64, $65, $65, $65, $66, $66, $66, $67, $67, $67, $67, $68, $68, $68, $68, $69
        .byte $69, $69, $69, $69, $6A, $6A, $6A, $6A, $6A, $6A, $6B, $6B, $6B, $6B, $6B, $6B
        .byte $6B, $6B, $6B, $6B, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C, $6C

      _A30A_AEEA ; 9A/AEEA
        .byte $0D, $13, $18, $1B, $1E, $21, $24, $26, $29, $2B, $2D, $2F, $31, $32, $34, $36
        .byte $37, $39, $3A, $3C, $3D, $3E, $40, $41, $42, $43, $44, $46, $47, $48, $49, $4A
        .byte $4B, $4C, $4D, $4E, $4F, $4F, $50, $51, $52, $53, $54, $54, $55, $56, $57, $57
        .byte $58, $59, $59, $5A, $5B, $5B, $5C, $5D, $5D, $5E, $5F, $5F, $60, $60, $61, $61
        .byte $62, $62, $63, $63, $64, $64, $65, $65, $66, $66, $67, $67, $67, $68, $68, $69
        .byte $69, $69, $6A, $6A, $6A, $6B, $6B, $6B, $6C, $6C, $6C, $6D, $6D, $6D, $6D, $6E
        .byte $6E, $6E, $6E, $6F, $6F, $6F, $6F, $70, $70, $70, $70, $70, $70, $71, $71, $71
        .byte $71, $71, $71, $72, $72, $72, $72, $72, $72, $72, $72, $72, $72, $72, $73, $73
        .byte $73, $73, $73, $73, $73, $73, $73, $73

      _A30A_AF72 ; 9A/AF72
        .byte $0E, $14, $18, $1C, $1F, $22, $25, $28, $2A, $2C, $2E, $30, $32, $34, $36, $37
        .byte $39, $3B, $3C, $3E, $3F, $40, $42, $43, $44, $45, $47, $48, $49, $4A, $4B, $4C
        .byte $4D, $4E, $4F, $50, $51, $52, $53, $54, $55, $56, $56, $57, $58, $59, $5A, $5A
        .byte $5B, $5C, $5D, $5D, $5E, $5F, $5F, $60, $61, $61, $62, $63, $63, $64, $64, $65
        .byte $66, $66, $67, $67, $68, $68, $69, $69, $6A, $6A, $6B, $6B, $6C, $6C, $6C, $6D
        .byte $6D, $6E, $6E, $6E, $6F, $6F, $70, $70, $70, $71, $71, $71, $72, $72, $72, $73
        .byte $73, $73, $73, $74, $74, $74, $74, $75, $75, $75, $75, $76, $76, $76, $76, $76
        .byte $77, $77, $77, $77, $77, $78, $78, $78, $78, $78, $78, $78, $78, $79, $79, $79
        .byte $79, $79, $79, $79, $79, $79, $79, $79, $79, $79, $79, $79, $7A, $7A, $7A, $7A

      _A30A_B002 ; 9A/B002
        .byte $0E, $14, $19, $1D, $20, $23, $26, $29, $2B, $2D, $30, $32, $34, $35, $37, $39
        .byte $3B, $3C, $3E, $3F, $41, $42, $44, $45, $46, $48, $49, $4A, $4B, $4C, $4D, $4F
        .byte $50, $51, $52, $53, $54, $55, $56, $57, $58, $58, $59, $5A, $5B, $5C, $5D, $5D
        .byte $5E, $5F, $60, $61, $61, $62, $63, $63, $64, $65, $65, $66, $67, $67, $68, $69
        .byte $69, $6A, $6A, $6B, $6B, $6C, $6C, $6D, $6E, $6E, $6F, $6F, $70, $70, $70, $71
        .byte $71, $72, $72, $73, $73, $74, $74, $74, $75, $75, $75, $76, $76, $77, $77, $77
        .byte $78, $78, $78, $79, $79, $79, $79, $7A, $7A, $7A, $7B, $7B, $7B, $7B, $7C, $7C
        .byte $7C, $7C, $7C, $7D, $7D, $7D, $7D, $7D, $7E, $7E, $7E, $7E, $7E, $7E, $7F, $7F
        .byte $7F, $7F, $7F, $7F, $7F, $7F, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
        .byte $80, $80, $80, $80, $80, $80, $80, $80

      _A30A_B09A ; 9A/B09A
        .byte $0F, $15, $1A, $1E, $21, $24, $27, $2A, $2C, $2F, $31, $33, $35, $37, $39, $3B
        .byte $3C, $3E, $40, $41, $43, $44, $46, $47, $48, $4A, $4B, $4C, $4D, $4F, $50, $51
        .byte $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $5F, $60
        .byte $61, $62, $63, $64, $64, $65, $66, $67, $67, $68, $69, $69, $6A, $6B, $6B, $6C
        .byte $6D, $6D, $6E, $6E, $6F, $70, $70, $71, $71, $72, $72, $73, $73, $74, $74, $75
        .byte $75, $76, $76, $77, $77, $78, $78, $79, $79, $79, $7A, $7A, $7B, $7B, $7B, $7C
        .byte $7C, $7C, $7D, $7D, $7E, $7E, $7E, $7F, $7F, $7F, $7F, $80, $80, $80, $81, $81
        .byte $81, $81, $82, $82, $82, $82, $83, $83, $83, $83, $83, $84, $84, $84, $84, $84
        .byte $85, $85, $85, $85, $85, $85, $85, $86, $86, $86, $86, $86, $86, $86, $86, $86
        .byte $86, $87, $87, $87, $87, $87, $87, $87, $87, $87, $87, $87, $87, $87, $87, $87

      _A30A_B13A ; 9A/B13A
        .byte $0F, $15, $1A, $1E, $22, $25, $28, $2B, $2D, $30, $32, $34, $36, $38, $3A, $3C
        .byte $3E, $40, $41, $43, $44, $46, $47, $49, $4A, $4C, $4D, $4E, $4F, $51, $52, $53
        .byte $54, $55, $56, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $60, $60, $61, $62, $63
        .byte $64, $65, $66, $66, $67, $68, $69, $6A, $6A, $6B, $6C, $6D, $6D, $6E, $6F, $6F
        .byte $70, $71, $71, $72, $73, $73, $74, $74, $75, $76, $76, $77, $77, $78, $78, $79
        .byte $79, $7A, $7A, $7B, $7B, $7C, $7C, $7D, $7D, $7E, $7E, $7E, $7F, $7F, $80, $80
        .byte $81, $81, $81, $82, $82, $82, $83, $83, $83, $84, $84, $84, $85, $85, $85, $86
        .byte $86, $86, $87, $87, $87, $87, $88, $88, $88, $88, $89, $89, $89, $89, $8A, $8A
        .byte $8A, $8A, $8A, $8B, $8B, $8B, $8B, $8B, $8B, $8C, $8C, $8C, $8C, $8C, $8C, $8C
        .byte $8D, $8D, $8D, $8D, $8D, $8D, $8D, $8D, $8D, $8D, $8D, $8E, $8E, $8E, $8E, $8E
        .byte $8E, $8E, $8E, $8E, $8E, $8E, $8E, $8E

      _A30A_B1E2 ; 9A/B1E2
        .byte $0F, $16, $1B, $1F, $23, $26, $29, $2C, $2F, $31, $33, $36, $38, $3A, $3C, $3E
        .byte $3F, $41, $43, $45, $46, $48, $49, $4B, $4C, $4E, $4F, $50, $52, $53, $54, $55
        .byte $56, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64, $65, $66
        .byte $67, $68, $68, $69, $6A, $6B, $6C, $6D, $6D, $6E, $6F, $70, $70, $71, $72, $73
        .byte $73, $74, $75, $75, $76, $77, $77, $78, $78, $79, $7A, $7A, $7B, $7B, $7C, $7D
        .byte $7D, $7E, $7E, $7F, $7F, $80, $80, $81, $81, $82, $82, $83, $83, $83, $84, $84
        .byte $85, $85, $86, $86, $86, $87, $87, $88, $88, $88, $89, $89, $89, $8A, $8A, $8A
        .byte $8B, $8B, $8B, $8C, $8C, $8C, $8D, $8D, $8D, $8D, $8E, $8E, $8E, $8F, $8F, $8F
        .byte $8F, $8F, $90, $90, $90, $90, $91, $91, $91, $91, $91, $91, $92, $92, $92, $92
        .byte $92, $92, $93, $93, $93, $93, $93, $93, $93, $93, $94, $94, $94, $94, $94, $94
        .byte $94, $94, $94, $94, $94, $94, $94, $94, $95, $95, $95, $95, $95, $95, $95, $95

      _A30A_B292 ; 9A/B292
        .byte $10, $16, $1C, $20, $24, $27, $2A, $2D, $30, $32, $35, $37, $39, $3B, $3D, $3F
        .byte $41, $43, $45, $46, $48, $49, $4B, $4D, $4E, $4F, $51, $52, $54, $55, $56, $57
        .byte $59, $5A, $5B, $5C, $5D, $5E, $5F, $61, $62, $63, $64, $65, $66, $67, $68, $69
        .byte $69, $6A, $6B, $6C, $6D, $6E, $6F, $70, $70, $71, $72, $73, $73, $74, $75, $76
        .byte $76, $77, $78, $79, $79, $7A, $7B, $7B, $7C, $7C, $7D, $7E, $7E, $7F, $80, $80
        .byte $81, $81, $82, $82, $83, $83, $84, $85, $85, $86, $86, $87, $87, $88, $88, $88
        .byte $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8C, $8D, $8D, $8E, $8E, $8E, $8F, $8F
        .byte $8F, $90, $90, $90, $91, $91, $91, $92, $92, $92, $93, $93, $93, $93, $94, $94
        .byte $94, $95, $95, $95, $95, $96, $96, $96, $96, $96, $97, $97, $97, $97, $98, $98
        .byte $98, $98, $98, $98, $99, $99, $99, $99, $99, $99, $99, $9A, $9A, $9A, $9A, $9A
        .byte $9A, $9A, $9A, $9B, $9B, $9B, $9B, $9B, $9B, $9B, $9B, $9B, $9B, $9B, $9B, $9B
        .byte $9B, $9B, $9B, $9B, $9B, $9B, $9B, $9B

      _A30A_B34A ; 9A/B34A
        .byte $10, $17, $1C, $21, $24, $28, $2B, $2E, $31, $33, $36, $38, $3A, $3C, $3F, $41
        .byte $42, $44, $46, $48, $49, $4B, $4D, $4E, $50, $51, $53, $54, $55, $57, $58, $59
        .byte $5B, $5C, $5D, $5E, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B
        .byte $6C, $6D, $6E, $6F, $70, $71, $71, $72, $73, $74, $75, $76, $76, $77, $78, $79
        .byte $7A, $7A, $7B, $7C, $7C, $7D, $7E, $7F, $7F, $80, $81, $81, $82, $82, $83, $84
        .byte $84, $85, $85, $86, $87, $87, $88, $88, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C
        .byte $8D, $8D, $8E, $8E, $8F, $8F, $90, $90, $91, $91, $91, $92, $92, $93, $93, $93
        .byte $94, $94, $95, $95, $95, $96, $96, $96, $97, $97, $97, $98, $98, $98, $99, $99
        .byte $99, $99, $9A, $9A, $9A, $9B, $9B, $9B, $9B, $9C, $9C, $9C, $9C, $9D, $9D, $9D
        .byte $9D, $9D, $9E, $9E, $9E, $9E, $9E, $9F, $9F, $9F, $9F, $9F, $9F, $A0, $A0, $A0
        .byte $A0, $A0, $A0, $A0, $A1, $A1, $A1, $A1, $A1, $A1, $A1, $A1, $A1, $A1, $A2, $A2
        .byte $A2, $A2, $A2, $A2, $A2, $A2, $A2, $A2, $A2, $A2, $A2, $A2, $A2, $A2, $A2, $A2

      _A30A_B40A ; 9A/B40A
        .byte $10, $17, $1D, $21, $25, $29, $2C, $2F, $32, $34, $37, $39, $3C, $3E, $40, $42
        .byte $44, $46, $48, $49, $4B, $4D, $4E, $50, $52, $53, $55, $56, $57, $59, $5A, $5B
        .byte $5D, $5E, $5F, $61, $62, $63, $64, $65, $66, $67, $68, $6A, $6B, $6C, $6D, $6E
        .byte $6F, $70, $71, $72, $72, $73, $74, $75, $76, $77, $78, $79, $79, $7A, $7B, $7C
        .byte $7D, $7D, $7E, $7F, $80, $80, $81, $82, $82, $83, $84, $84, $85, $86, $86, $87
        .byte $88, $88, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8D, $8E, $8E, $8F, $8F, $90, $90
        .byte $91, $91, $92, $92, $93, $93, $94, $94, $95, $95, $96, $96, $96, $97, $97, $98
        .byte $98, $99, $99, $99, $9A, $9A, $9A, $9B, $9B, $9C, $9C, $9C, $9D, $9D, $9D, $9E
        .byte $9E, $9E, $9F, $9F, $9F, $9F, $A0, $A0, $A0, $A1, $A1, $A1, $A1, $A2, $A2, $A2
        .byte $A2, $A3, $A3, $A3, $A3, $A4, $A4, $A4, $A4, $A4, $A5, $A5, $A5, $A5, $A5, $A6
        .byte $A6, $A6, $A6, $A6, $A6, $A7, $A7, $A7, $A7, $A7, $A7, $A7, $A7, $A8, $A8, $A8
        .byte $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A8, $A9, $A9, $A9, $A9, $A9, $A9, $A9, $A9
        .byte $A9, $A9, $A9, $A9, $A9, $A9, $A9, $A9

      _A30A_B4D2 ; 9A/B4D2
        .byte $11, $18, $1D, $22, $26, $2A, $2D, $30, $33, $35, $38, $3B, $3D, $3F, $41, $43
        .byte $45, $47, $49, $4B, $4D, $4E, $50, $52, $53, $55, $56, $58, $59, $5B, $5C, $5D
        .byte $5F, $60, $61, $63, $64, $65, $66, $67, $69, $6A, $6B, $6C, $6D, $6E, $6F, $70
        .byte $71, $72, $73, $74, $75, $76, $77, $78, $79, $7A, $7A, $7B, $7C, $7D, $7E, $7F
        .byte $80, $80, $81, $82, $83, $83, $84, $85, $86, $86, $87, $88, $88, $89, $8A, $8A
        .byte $8B, $8C, $8C, $8D, $8E, $8E, $8F, $8F, $90, $91, $91, $92, $92, $93, $93, $94
        .byte $95, $95, $96, $96, $97, $97, $98, $98, $99, $99, $9A, $9A, $9B, $9B, $9B, $9C
        .byte $9C, $9D, $9D, $9E, $9E, $9E, $9F, $9F, $A0, $A0, $A0, $A1, $A1, $A1, $A2, $A2
        .byte $A3, $A3, $A3, $A4, $A4, $A4, $A5, $A5, $A5, $A5, $A6, $A6, $A6, $A7, $A7, $A7
        .byte $A7, $A8, $A8, $A8, $A9, $A9, $A9, $A9, $A9, $AA, $AA, $AA, $AA, $AB, $AB, $AB
        .byte $AB, $AB, $AC, $AC, $AC, $AC, $AC, $AC, $AD, $AD, $AD, $AD, $AD, $AD, $AE, $AE
        .byte $AE, $AE, $AE, $AE, $AE, $AE, $AE, $AF, $AF, $AF, $AF, $AF, $AF, $AF, $AF, $AF
        .byte $AF, $AF, $AF, $AF, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0, $B0

      _A30A_B5A2 ; 9A/B5A2
        .byte $11, $18, $1E, $23, $27, $2A, $2E, $31, $34, $37, $39, $3C, $3E, $40, $43, $45
        .byte $47, $49, $4B, $4C, $4E, $50, $52, $53, $55, $57, $58, $5A, $5B, $5D, $5E, $5F
        .byte $61, $62, $63, $65, $66, $67, $68, $6A, $6B, $6C, $6D, $6E, $6F, $70, $71, $73
        .byte $74, $75, $76, $77, $78, $79, $7A, $7A, $7B, $7C, $7D, $7E, $7F, $80, $81, $82
        .byte $82, $83, $84, $85, $86, $86, $87, $88, $89, $89, $8A, $8B, $8C, $8C, $8D, $8E
        .byte $8E, $8F, $90, $90, $91, $92, $92, $93, $94, $94, $95, $95, $96, $97, $97, $98
        .byte $98, $99, $99, $9A, $9A, $9B, $9C, $9C, $9D, $9D, $9E, $9E, $9F, $9F, $9F, $A0
        .byte $A0, $A1, $A1, $A2, $A2, $A3, $A3, $A3, $A4, $A4, $A5, $A5, $A6, $A6, $A6, $A7
        .byte $A7, $A7, $A8, $A8, $A8, $A9, $A9, $AA, $AA, $AA, $AB, $AB, $AB, $AB, $AC, $AC
        .byte $AC, $AD, $AD, $AD, $AE, $AE, $AE, $AE, $AF, $AF, $AF, $AF, $B0, $B0, $B0, $B0
        .byte $B1, $B1, $B1, $B1, $B1, $B2, $B2, $B2, $B2, $B2, $B3, $B3, $B3, $B3, $B3, $B3
        .byte $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B5, $B5, $B5, $B5, $B5, $B5, $B5, $B5, $B5
        .byte $B6, $B6, $B6, $B6, $B6, $B6, $B6, $B6, $B6, $B6, $B6, $B6, $B6, $B6, $B6, $B6
        .byte $B6, $B6, $B7, $B7, $B7, $B7, $B7, $B7

      _A30A_B67A ; 9A/B67A
        .byte $11, $19, $1E, $23, $27, $2B, $2F, $32, $35, $38, $3A, $3D, $3F, $42, $44, $46
        .byte $48, $4A, $4C, $4E, $50, $52, $53, $55, $57, $58, $5A, $5B, $5D, $5E, $60, $61
        .byte $63, $64, $65, $67, $68, $69, $6B, $6C, $6D, $6E, $6F, $70, $72, $73, $74, $75
        .byte $76, $77, $78, $79, $7A, $7B, $7C, $7D, $7E, $7F, $80, $81, $82, $83, $83, $84
        .byte $85, $86, $87, $88, $89, $89, $8A, $8B, $8C, $8C, $8D, $8E, $8F, $8F, $90, $91
        .byte $92, $92, $93, $94, $94, $95, $96, $96, $97, $98, $98, $99, $99, $9A, $9B, $9B
        .byte $9C, $9C, $9D, $9E, $9E, $9F, $9F, $A0, $A0, $A1, $A1, $A2, $A2, $A3, $A3, $A4
        .byte $A4, $A5, $A5, $A6, $A6, $A7, $A7, $A8, $A8, $A9, $A9, $A9, $AA, $AA, $AB, $AB
        .byte $AB, $AC, $AC, $AD, $AD, $AD, $AE, $AE, $AE, $AF, $AF, $AF, $B0, $B0, $B0, $B1
        .byte $B1, $B1, $B2, $B2, $B2, $B3, $B3, $B3, $B4, $B4, $B4, $B4, $B5, $B5, $B5, $B5
        .byte $B6, $B6, $B6, $B6, $B7, $B7, $B7, $B7, $B8, $B8, $B8, $B8, $B8, $B9, $B9, $B9
        .byte $B9, $B9, $B9, $BA, $BA, $BA, $BA, $BA, $BA, $BB, $BB, $BB, $BB, $BB, $BB, $BB
        .byte $BC, $BC, $BC, $BC, $BC, $BC, $BC, $BC, $BC, $BC, $BC, $BD, $BD, $BD, $BD, $BD
        .byte $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD, $BD

      _A30A_B75A ; 9A/B75A
        .byte $12, $19, $1F, $24, $28, $2C, $2F, $33, $36, $39, $3B, $3E, $40, $43, $45, $47
        .byte $49, $4B, $4D, $4F, $51, $53, $55, $57, $58, $5A, $5C, $5D, $5F, $60, $62, $63
        .byte $65, $66, $67, $69, $6A, $6B, $6D, $6E, $6F, $70, $72, $73, $74, $75, $76, $77
        .byte $78, $79, $7A, $7C, $7D, $7E, $7F, $80, $81, $82, $83, $83, $84, $85, $86, $87
        .byte $88, $89, $8A, $8B, $8B, $8C, $8D, $8E, $8F, $8F, $90, $91, $92, $93, $93, $94
        .byte $95, $95, $96, $97, $98, $98, $99, $9A, $9A, $9B, $9C, $9C, $9D, $9E, $9E, $9F
        .byte $9F, $A0, $A1, $A1, $A2, $A2, $A3, $A3, $A4, $A5, $A5, $A6, $A6, $A7, $A7, $A8
        .byte $A8, $A9, $A9, $AA, $AA, $AB, $AB, $AC, $AC, $AD, $AD, $AE, $AE, $AE, $AF, $AF
        .byte $B0, $B0, $B1, $B1, $B1, $B2, $B2, $B2, $B3, $B3, $B4, $B4, $B4, $B5, $B5, $B5
        .byte $B6, $B6, $B6, $B7, $B7, $B7, $B8, $B8, $B8, $B9, $B9, $B9, $BA, $BA, $BA, $BA
        .byte $BB, $BB, $BB, $BB, $BC, $BC, $BC, $BC, $BD, $BD, $BD, $BD, $BE, $BE, $BE, $BE
        .byte $BF, $BF, $BF, $BF, $BF, $BF, $C0, $C0, $C0, $C0, $C0, $C1, $C1, $C1, $C1, $C1
        .byte $C1, $C1, $C2, $C2, $C2, $C2, $C2, $C2, $C2, $C2, $C3, $C3, $C3, $C3, $C3, $C3
        .byte $C3, $C3, $C3, $C3, $C3, $C4, $C4, $C4, $C4, $C4, $C4, $C4, $C4, $C4, $C4, $C4
        .byte $C4, $C4, $C4, $C4, $C4, $C4, $C4, $C4

      _A30A_B842 ; 9A/B842
        .byte $12, $1A, $20, $24, $29, $2D, $30, $34, $37, $3A, $3C, $3F, $42, $44, $46, $49
        .byte $4B, $4D, $4F, $51, $53, $55, $56, $58, $5A, $5C, $5D, $5F, $60, $62, $63, $65
        .byte $66, $68, $69, $6B, $6C, $6D, $6F, $70, $71, $72, $74, $75, $76, $77, $78, $7A
        .byte $7B, $7C, $7D, $7E, $7F, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8A
        .byte $8B, $8C, $8C, $8D, $8E, $8F, $90, $91, $92, $92, $93, $94, $95, $96, $96, $97
        .byte $98, $99, $99, $9A, $9B, $9B, $9C, $9D, $9E, $9E, $9F, $A0, $A0, $A1, $A2, $A2
        .byte $A3, $A3, $A4, $A5, $A5, $A6, $A6, $A7, $A8, $A8, $A9, $A9, $AA, $AA, $AB, $AC
        .byte $AC, $AD, $AD, $AE, $AE, $AF, $AF, $B0, $B0, $B1, $B1, $B2, $B2, $B2, $B3, $B3
        .byte $B4, $B4, $B5, $B5, $B6, $B6, $B6, $B7, $B7, $B8, $B8, $B8, $B9, $B9, $BA, $BA
        .byte $BA, $BB, $BB, $BB, $BC, $BC, $BC, $BD, $BD, $BD, $BE, $BE, $BE, $BF, $BF, $BF
        .byte $C0, $C0, $C0, $C0, $C1, $C1, $C1, $C2, $C2, $C2, $C2, $C3, $C3, $C3, $C3, $C4
        .byte $C4, $C4, $C4, $C4, $C5, $C5, $C5, $C5, $C5, $C6, $C6, $C6, $C6, $C6, $C7, $C7
        .byte $C7, $C7, $C7, $C7, $C8, $C8, $C8, $C8, $C8, $C8, $C8, $C9, $C9, $C9, $C9, $C9
        .byte $C9, $C9, $C9, $CA, $CA, $CA, $CA, $CA, $CA, $CA, $CA, $CA, $CA, $CA, $CA, $CA
        .byte $CA, $CB, $CB, $CB, $CB, $CB, $CB, $CB, $CB, $CB, $CB, $CB, $CB, $CB, $CB, $CB

      _A30A_B932 ; 9A/B932
        .byte $12, $1A, $20, $25, $29, $2D, $31, $34, $38, $3B, $3D, $40, $43, $45, $47, $4A
        .byte $4C, $4E, $50, $52, $54, $56, $58, $5A, $5B, $5D, $5F, $61, $62, $64, $65, $67
        .byte $68, $6A, $6B, $6D, $6E, $6F, $71, $72, $73, $75, $76, $77, $78, $79, $7B, $7C
        .byte $7D, $7E, $7F, $80, $81, $82, $83, $85, $86, $87, $88, $89, $8A, $8B, $8B, $8C
        .byte $8D, $8E, $8F, $90, $91, $92, $93, $94, $94, $95, $96, $97, $98, $99, $99, $9A
        .byte $9B, $9C, $9C, $9D, $9E, $9F, $9F, $A0, $A1, $A1, $A2, $A3, $A4, $A4, $A5, $A6
        .byte $A6, $A7, $A8, $A8, $A9, $A9, $AA, $AB, $AB, $AC, $AC, $AD, $AE, $AE, $AF, $AF
        .byte $B0, $B0, $B1, $B1, $B2, $B2, $B3, $B4, $B4, $B5, $B5, $B6, $B6, $B6, $B7, $B7
        .byte $B8, $B8, $B9, $B9, $BA, $BA, $BB, $BB, $BB, $BC, $BC, $BD, $BD, $BE, $BE, $BE
        .byte $BF, $BF, $BF, $C0, $C0, $C1, $C1, $C1, $C2, $C2, $C2, $C3, $C3, $C3, $C4, $C4
        .byte $C4, $C5, $C5, $C5, $C6, $C6, $C6, $C6, $C7, $C7, $C7, $C8, $C8, $C8, $C8, $C9
        .byte $C9, $C9, $C9, $CA, $CA, $CA, $CA, $CB, $CB, $CB, $CB, $CB, $CC, $CC, $CC, $CC
        .byte $CC, $CD, $CD, $CD, $CD, $CD, $CE, $CE, $CE, $CE, $CE, $CE, $CE, $CF, $CF, $CF
        .byte $CF, $CF, $CF, $CF, $D0, $D0, $D0, $D0, $D0, $D0, $D0, $D0, $D0, $D1, $D1, $D1
        .byte $D1, $D1, $D1, $D1, $D1, $D1, $D1, $D1, $D1, $D1, $D1, $D1, $D1, $D1, $D2, $D2
        .byte $D2, $D2, $D2, $D2, $D2, $D2, $D2, $D2

        ; 9A/BA2A

    .endsection Data9A8000Section


    .section Unsorted96A4FCSection

      .al
      .xl

      rlUnknown96A4FC ; 96/A4FC

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FEC1D
        sta $7FEC41
        sta aUnit2DataBuffer._ROM.Skills1
        sta $7FEC50
        lda #$10
        sta $7FEC65
        lda #$70
        sta $7FEC66
        rep #$20
        lda #$0000
        sta aUnit2DataBuffer._Inventory.ItemCount
        sta aUnit2DataBuffer._Inventory.Items
        sta $7FEC5A
        sta $7FEC5C
        rtl

        .databank 0

        ; 96/A532

    .endsection Unsorted96A4FCSection


    .section Unsorted96B852Section

      .al
      .xl

      rsUnknown96B852 ; 96/B852

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        ldx wBattleAnimationDefenderOffset,b
        lda bBattleAnimationY,b,x
        and #$00FF
        sta wR1
        lda aUnit2DataBuffer._ROM.SpeedGrowth
        and #$00FF
        sta wR2
        lda wR1
        sec
        sbc wR2
        bpl _B878
        eor #$FFFF
        inc a
        sta wR2
        pla
        bra _B87E


        _B878
        sta wR2
        pla
        eor #$8000

        _B87E
        sta wR3
        lda wR2
        jsl rlBattleAnimationGetSpeed
        ora wR3
        sta $7FEC3F
        lda wR1
        sta aUnit2DataBuffer._ROM.HolyBlood2
        plx
        rts

        .databank 0

        ; 96/B894

      rsUnknown96B894 ; 96/B894

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda bBattleSceneAttackerSide,b
        bit #$80
        bne _B8A3
        ldx #$0000
        bra _B8A6


        _B8A3
        ldx #$000E

        _B8A6
        lda aBattleSceneCombatant1.Class,b,x
        sta wR9+1
        rep #$20
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda aUnknown97EA9A+2,x
        and #$00FF
        sta wR8
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        sta wR1
        lda $7FEC1F
        sta wR0
        lda wR0
        cmp wR1
        bcc _B8DF
        sec
        sbc wR8
        bra _B8E2


        _B8DF
        clc
        adc wR8

        _B8E2
        sta wR0
        lda wR1
        sec
        sbc wR0
        bpl _B8F6
        eor #$FFFF
        inc a
        sta wR2
        lda #$8000
        bra _B8FB


        _B8F6
        sta wR2
        lda #$0000

        _B8FB
        sta wR3
        lda wR2
        sta wR4
        sec
        jsl rlBattleAnimationGetTravelFrames
        sta wR0
        lda wR2
        jsl rlBattleAnimationGetSpeed
        ora wR3
        sta aUnit2DataBuffer._Inventory.ItemCount
        lda wR3
        bmi _B921
        lda $7FEC1F
        clc
        adc wR2
        bra _B928


        _B921
        lda $7FEC1F
        sec
        sbc wR2

        _B928
        pha
        lda aUnit2DataBuffer._ROM.StrengthGrowth
        sta aUnit2DataBuffer._ROM.Skills2
        pla
        sta aUnit2DataBuffer._ROM.Skills3
        lda wR4
        plx
        rts

        .databank 0

        ; 96/B93A

      rlBattleSceneScriptClearLoading ; 96/B93A

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FECF4
        rep #$20
        rtl

        .databank 0

        ; 96/B945

    .endsection Unsorted96B852Section


    .section Unsorted96BCECSection

      .al
      .xl

      rlUnknown96BCEC ; 96/BCEC

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlStartBattleSceneScript
        rtl

        .databank 0

        ; 96/BCF1

    .endsection Unsorted96BCECSection


    .section Unsorted96BD74Section

      .al
      .xl

      rlUnknown96BD74 ; 96/BD74

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7FED02
        ldx #$0000

        _BD7F
        lda #$0000
        sta $7FED03,x
        txa
        clc
        adc #$0009
        tax
        cpx #$0048
        bcc _BD7F
        plx
        rtl

        .databank 0

        ; 96/BD93

      rlBattleSceneCommandHDMAEffect ; 96/BD93

        .al
        .xl
        .autsiz
        .databank ?

        ; Command 3: arg 0-7 stops HDMA effect slot arg; arg 8 and up starts effect
        ; arg-8 from the offset table at $97/BD3E in a free slot of eight ($7FED03),
        ; waiting while none is free.

        phx
        phy
        tya
        and #$01FF
        cmp #$0008
        bcs _BDA4
        jsl rlBattleSceneStopHDMAEffect
        bra _BE20


        _BDA4
        lda $7FED02
        and #$00FF
        cmp #$0008
        bcs _BE1D
        ldx #$0000

        _BDB3
        lda $7FED03,x
        bit #$0001
        bne _BE12
        sep #$20
        lda #$01
        sta $7FED03,x
        lda $7FED02
        inc a
        sta $7FED02
        rep #$20
        lda #$9700
        sta lR18+1
        tya
        and #$01FF
        sec
        sbc #$0008
        asl a
        clc
        adc #$BD3E
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc #$BD3E
        sta lR18
        ldy #$0000
        lda [lR18],y
        sta $7FED04,x
        inc y
        inc y
        lda [lR18],y
        sta $7FED06,x
        inc y
        inc y
        lda [lR18],y
        sta $7FED08,x
        inc y
        inc y
        lda [lR18],y
        sta $7FED0A,x
        clc
        bra _BE20


        _BE12
        txa
        clc
        adc #$0009
        tax
        cpx #$0048
        bcc _BDB3

        _BE1D
        sec
        bra _BE25


        _BE20
        pla
        pha
        jsr rsBattleSceneScriptNextCommand

        _BE25
        ply
        plx
        rtl

        .databank 0

        ; 96/BE28

    .endsection Unsorted96BD74Section


