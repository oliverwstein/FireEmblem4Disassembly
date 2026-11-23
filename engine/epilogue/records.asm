; The end of the game's play record and ranking screen (bank $8D). The play
; record is scrolling dialogue text (dialogueEpilogueCredits8DC9FF) whose ASMCs
; here fill in each chapter's turn count and each recruited unit's wins and
; losses; then the ranking screen (rlShowEpilogueRankingScreen: the four
; rankings, the final score, the play time, the number of completions) and
; the secret button code (aEpilogueSecretCode) that reveals one more row of it.


    .section Unsorted8DAD73Section

      .al
      .xl

      rlScrollEpilogueRecordText ; 8D/AD73

        .al
        .xl
        .autsiz
        .databank ?

        ; While the play record's text is printing, scrolls BG1 and BG2 and uploads the text; then fades out to the ranking screen (step 15).

        lda aDialogue.wStatus,b
        beq _AD91
        dec wBufferBG1VOFS
        lda wVBlankEnabledFramecount
        and #$0007
        bne _AD83
        inc wBufferBG2VOFS

        _AD83
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $D000

        rtl


        _AD91
        lda #EPILOGUE_STEP_FADE_OUT
        sta wGameStateStep,b
        lda #EPILOGUE_STEP_SHOW_RANKING
        sta wNextMenuState,b
        rtl

        .databank 0

        ; 8D/AD9E

    .endsection Unsorted8DAD73Section


    .section Table8DADFASection

      .al
      .xl

      aUnknown8DADFA .dstruct structHDMADirectEntryInfo, rlUnknown8DAE05, rlUnknown8DAE05, aUnknown8DAE30, $7F56C9, PPU_REG_BASE + $00, $00 ; 8D/ADFA

      rlUnknown8DAE05 ; 8D/AE05

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8D
        rep #$20
        ldx #$0000
        ldy #$0000
        sep #$20

        _AE11
        lda aUnknown8DAE32,y
        sta $7F56C9,x
        beq _AE2D
        lda $AE33,b,y
        cmp bBufferINIDISP
        bcc _AE23
        lda bBufferINIDISP

        _AE23
        sta $7F56CA,x
        inc x
        inc x
        inc y
        inc y
        bra _AE11


        _AE2D
        rep #$20
        rtl

        .databank 0

        ; 8D/AE30

      aUnknown8DAE30 ; 8D/AE30
        HDMA_HALT

      aUnknown8DAE32 ; 8D/AE32
        .byte $24, $00, $01, $01, $02, $03, $03, $05, $04, $07, $05, $09, $06, $0B, $08, $0D
        .byte $28, $0F, $08, $0D, $08, $0B, $08, $09, $06, $07, $04, $05, $03, $03, $02, $01
        .byte $01, $00, $00, $00, $28, $00, $01, $01, $02, $03, $03, $05, $04, $07, $04, $09
        .byte $04, $0B, $04, $0D, $28, $0F, $08, $0D, $08, $0B, $08, $09, $04, $07, $04, $05
        .byte $04, $03, $04, $01, $01, $00, $00, $00

      aEpilogueRecordLayerHDMAInfo .dstruct structHDMADirectEntryInfo, rlEpilogueRecordLayerHDMACycle, rlEpilogueRecordLayerHDMACycle, aEpilogueRecordLayerHDMACode, $7F56C9, PPU_REG_BASE + $2C, $00 ; 8D/AE7A

    .endsection Table8DADFASection


    .section Unsorted8DAE85Section

      .al
      .xl

      rlEpilogueRecordLayerHDMACycle ; 8D/AE85

        .al
        .xl
        .autsiz
        .databank ?

        ; Builds the HDMA table at $7F56C9 that switches the main screen layers (TM) partway down the screen for the play record.

        phk
        plb
        .databank $8D
        sep #$20
        lda #$18
        sta $7F56C9
        lda #$00
        lda #$00
        sta $7F56CA
        lda #$64
        sta $7F56CB
        lda #$06
        sta $7F56CC
        lda #$24
        sta $7F56CD
        lda #$00
        lda #$00
        sta $7F56CE
        lda #$00
        sta $7F56CF
        lda #$00
        sta $7F56D0
        rep #$20
        rtl

        .databank 0

        ; 8D/AEC0

      aEpilogueRecordLayerHDMACode ; 8D/AEC0

        HDMA_HALT

    .endsection Unsorted8DAE85Section


    .section Unsorted8DAEC2Section

      .al
      .xl

      rlSetUpEpilogueRecordTextWindow ; 8D/AEC2

        .al
        .xl
        .autsiz
        .databank ?

        ; Like rlSetUpEpilogueTextWindow, for the play record's text.

        lda #$0500
        tsb aDialogue.wStatus,b
        lda #$03FF
        sta aDialogue.wClearTile,b
        lda #$0001
        sta aDialogue.wTextSpeed,b
        lda #$0004
        sta aDialogue.wUnknown00188C,b
        lda #$0080
        sta $18E1,b,x
        lda #$0026
        sta $18DD,b
        lda #$101C
        sta $18DB,b,x
        lda #$4000
        sta $18D7,b,x
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        sta $18D4,b,x
        lda #$2000
        sta aDialogue.wBaseTile,b,x
        lda #$0102
        sta wR1
        sep #$20
        lda #$00
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
        ldx aDialogue,b
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        clc
        adc wR0
        sta $18D4,b,x
        rtl

        .databank 0

        ; 8D/AF33

    .endsection Unsorted8DAEC2Section


    .section Unsorted8DAFA5Section

      .al
      .xl

      rlShowEpilogueRankingScreen ; 8D/AFA5

        .al
        .xl
        .autsiz
        .databank ?

        ; Builds the ranking screen: works out the four rankings and the final score, draws them, the play time, the number of times the game was finished and the 16 letters at aUnknown7FC70A.

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsl rlUnknown9180BC
        jsl rlDialogueFreeHDMA
        stz wBufferBG2VOFS
        stz wBufferBG3VOFS
        lda #(`aDecompressionDMAEntry8DB056)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8DB056
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aDecompressionDMAEntry8DB066)<<8
        sta lR19+1
        lda #<>aDecompressionDMAEntry8DB066
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        sep #$20
        rep #$10
        ldx #<>gcUnknownD428B8
        stx DecompressionVariables
        lda #`gcUnknownD428B8
        sta $CA
        ldx #$8388
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsr rsDrawRankingScreenRankings
        jsr rsDrawRankingScreenHours
        jsr rsDrawRankingScreenMinutes
        jsr rsDrawRankingScreenCompletions
        jsr rsDrawRankingScreenLetters
        ldx #$00BE

        _B00E
        lda $7E8888,x
        sta $7E8088,x
        dec x
        dec x
        bpl _B00E
        ldx #$00BE
        lda #$007F

        _B020
        sta $7E8888,x
        dec x
        dec x
        bpl _B020
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $D000

        sep #$20
        lda #$06
        sta bBufferTM
        lda #$01
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8D/B056

    .endsection Unsorted8DAFA5Section


    .section Unsorted8DB06ESection

      .al
      .xl

      rsDrawRankingScreenRankings ; 8D/B06E

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the tactics, experience, survival and combat rankings and the final score on the ranking screen.

        jsl rlCalculateTacticsRanking
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E8564
        lda wR0
        clc
        adc #$2821
        sta $7E8566
        lda wR0
        clc
        adc #$2830
        sta $7E85A4
        lda wR0
        clc
        adc #$2831
        sta $7E85A6
        jsl rlCalculateExperienceRanking
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E8578
        lda wR0
        clc
        adc #$2821
        sta $7E857A
        lda wR0
        clc
        adc #$2830
        sta $7E85B8
        lda wR0
        clc
        adc #$2831
        sta $7E85BA
        jsl rlCalculateSurvivalRanking
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E85E4
        lda wR0
        clc
        adc #$2821
        sta $7E85E6
        lda wR0
        clc
        adc #$2830
        sta $7E8624
        lda wR0
        clc
        adc #$2831
        sta $7E8626
        jsl rlCalculateCombatRanking
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E85F8
        lda wR0
        clc
        adc #$2821
        sta $7E85FA
        lda wR0
        clc
        adc #$2830
        sta $7E8638
        lda wR0
        clc
        adc #$2831
        sta $7E863A
        jsl rlCalculateFinalRankingScore
        asl a
        sta wR0
        clc
        adc #$2820
        sta $7E86F6
        lda wR0
        clc
        adc #$2821
        sta $7E86F8
        lda wR0
        clc
        adc #$2830
        sta $7E8736
        lda wR0
        clc
        adc #$2831
        sta $7E8738
        rts

        .databank 0

        ; 8D/B150

    .endsection Unsorted8DB06ESection


    .section Unsorted8DB150Section

      .al
      .xl

      rsDrawRankingScreenHours ; 8D/B150

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the hours of the play time as digits.

        jsl rlGetGameTimeHoursMinutes
        txa
        sta wR0
        stz wR2
        stz wR3
        stz wR4
        stz wR5

        _B15F
        lda wR0
        cmp #$03E8
        bcc _B176
        sec
        sbc #$03E8
        sta wR0
        lda wR2
        clc
        adc #$0001
        sta wR2
        bra _B15F


        _B176
        lda wR0
        cmp #$0064
        bcc _B18D
        sec
        sbc #$0064
        sta wR0
        lda wR3
        clc
        adc #$0001
        sta wR3
        bra _B176


        _B18D
        lda wR0
        cmp #$000A
        bcc _B1A4
        sec
        sbc #$000A
        sta wR0
        lda wR4
        clc
        adc #$0001
        sta wR4
        bra _B18D


        _B1A4
        lda wR0
        sta wR5
        lda wR2
        clc
        adc #$0075
        ora #$3400
        sta $7E889C
        lda wR3
        clc
        adc #$0075
        ora #$3400
        sta $7E889E
        lda wR4
        clc
        adc #$0075
        ora #$3400
        sta $7E88A0
        lda wR5
        clc
        adc #$0075
        ora #$3400
        sta $7E88A2
        rts

        .databank 0

        ; 8D/B1DD

    .endsection Unsorted8DB150Section


    .section Unsorted8DB1DDSection

      .al
      .xl

      rsDrawRankingScreenMinutes ; 8D/B1DD

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the minutes of the play time.

        jsl rlGetGameTimeHoursMinutes
        sta wR0
        stz wR4

        _B1E5
        lda wR0
        cmp #$000A
        bcc _B1FC
        sec
        sbc #$000A
        sta wR0
        lda wR4
        clc
        adc #$0001
        sta wR4
        bra _B1E5


        _B1FC
        lda wR4
        clc
        adc #$0075
        ora #$3400
        sta $7E88A6
        lda wR0
        clc
        adc #$0075
        ora #$3400
        sta $7E88A8
        rts

        .databank 0

        ; 8D/B217

    .endsection Unsorted8DB1DDSection


    .section Unsorted8DB217Section

      .al
      .xl

      rsDrawRankingScreenCompletions ; 8D/B217

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws how many times this save has finished the game, plus one.

        jsl rlGetCurrentSaveCompletionCount
        inc a
        sta wR0
        stz wR4

        _B220
        lda wR0
        cmp #$000A
        bcc _B237
        sec
        sbc #$000A
        sta wR0
        lda wR4
        clc
        adc #$0001
        sta wR4
        bra _B220


        _B237
        lda wR4
        clc
        adc #$0075
        ora #$3400
        sta $7E88BA
        lda wR0
        clc
        adc #$0075
        ora #$3400
        sta $7E88BC
        rts

        .databank 0

        ; 8D/B252

    .endsection Unsorted8DB217Section


    .section Unsorted8DB252Section

      .al
      .xl

      rsDrawRankingScreenLetters ; 8D/B252

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the 16 letters at aUnknown7FC70A ('A' is tile $80) into the ranking screen's tilemap.

        ldx #$001E

        _B255
        phx
        sep #$20
        txa
        lsr a
        tax
        lda aUnknown7FC70A,x
        sec
        sbc #$41
        rep #$20
        plx
        clc
        adc #$0080
        ora #$3800
        sta $7E8918,x
        dec x
        dec x
        txa
        bpl _B255
        rts

        .databank 0

        ; 8D/B276

    .endsection Unsorted8DB252Section


    .section Unsorted8DB276Section

      .al
      .xl

      rlCheckEpilogueSecretCode ; 8D/B276

        .al
        .xl
        .autsiz
        .databank ?

        ; On the ranking screen: each new button press must match the next of aEpilogueSecretCode; after all twelve, uploads a hidden row of the screen ($7E8108 to $D580) and goes to step 18. A wrong press starts again.

        phk
        plb
        .databank $8D
        lda wJoy1New
        beq _B29A
        sta wR0
        lda wEpilogueTimer
        asl a
        tax
        lda @l aEpilogueSecretCode,x
        cmp wR0
        bne _B2AF
        lda wEpilogueTimer
        cmp #$000B
        beq _B29B
        inc a
        sta wEpilogueTimer

        _B29A
        rtl


        _B29B
        lda #EPILOGUE_STEP_END
        sta wGameStateStep,b
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8108, $0040, $80, $D580

        rtl


        _B2AF
        lda #$0000
        sta wEpilogueTimer
        bra _B29A

        .databank 0

        ; 8D/B2B8

    .endsection Unsorted8DB276Section


    .section Unsorted8DB2B8Section

      .al
      .xl

      aEpilogueSecretCode ; 8D/B2B8

        ; A button sequence: rlCheckEpilogueSecretCode compares each new press with the next
        ; entry and goes to step $12 after the twelfth. Select, Up, A, Down, B, Left,
        ; X, Right, Y, L, R, Start.
        .word $2000, $0800, $0080, $0400, $8000, $0200, $0040, $0100, $4000, $0020, $0010, $1000


      rlASMCRecordTurnsPrologue ; 8D/B2D0

        .al
        .xl
        .autsiz
        .databank ?

        ; Play record ASMC: puts the prologue's turn count in DIALOGUE_NUMBER1, with spaces to right-align it.

        ; One of 13 alike: stores a chapter's turn count (aChapterTurncounts) in $18AD
        ; and runs rsAlignRecordNumber2. Word pointers to these sit at $8D/CA4A-CBF2, in
        ; data not built yet.

        ldx #$0000
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsAlignRecordNumber2
        rtl

        .databank 0

        ; 8D/B2DD

      rlASMCRecordTurnsChapter1 ; 8D/B2DD

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0002
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsAlignRecordNumber2
        rtl

        .databank 0

        ; 8D/B2EA

      rlASMCRecordTurnsChapter2 ; 8D/B2EA

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0004
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsAlignRecordNumber2
        rtl

        .databank 0

        ; 8D/B2F7

      rlASMCRecordTurnsChapter3 ; 8D/B2F7

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0006
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsAlignRecordNumber2
        rtl

        .databank 0

        ; 8D/B304

      rlASMCRecordTurnsChapter4 ; 8D/B304

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0008
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsAlignRecordNumber2
        rtl

        .databank 0

        ; 8D/B311

      rlASMCRecordTurnsChapter5 ; 8D/B311

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$000A
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsAlignRecordNumber2
        rtl

        .databank 0

        ; 8D/B31E

      rlASMCRecordTurnsChapter6 ; 8D/B31E

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$000C
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsAlignRecordNumber2
        rtl

        .databank 0

        ; 8D/B32B

      rlASMCRecordTurnsChapter7 ; 8D/B32B

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$000E
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsAlignRecordNumber2
        rtl

        .databank 0

        ; 8D/B338

      rlASMCRecordTurnsChapter8 ; 8D/B338

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0010
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsAlignRecordNumber2
        rtl

        .databank 0

        ; 8D/B345

      rlASMCRecordTurnsChapter9 ; 8D/B345

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0012
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsAlignRecordNumber2
        rtl

        .databank 0

        ; 8D/B352

      rlASMCRecordTurnsChapter10 ; 8D/B352

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0014
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsAlignRecordNumber2
        rtl

        .databank 0

        ; 8D/B35F

      rlASMCRecordTurnsFinal ; 8D/B35F

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0016
        lda aChapterTurncounts,b,x
        sta aDialogue.wNumber1,b
        jsr rsAlignRecordNumber2
        rtl

        .databank 0

        ; 8D/B36C

      rlASMCRecordTurnsTotal ; 8D/B36C

        .al
        .xl
        .autsiz
        .databank ?

        ; Play record ASMC: the total of all chapters' turn counts in DIALOGUE_NUMBER1, right-aligned to four digits.

        stz aDialogue.wNumber1,b
        phx
        ldx #$0016

        _B373
        lda aChapterTurncounts,b,x
        clc
        adc aDialogue.wNumber1,b
        sta aDialogue.wNumber1,b
        dec x
        dec x
        bpl _B373
        plx
        jsr rsAlignRecordNumber4
        rtl

        .databank 0

        ; 8D/B386

      rsAlignRecordNumber2 ; 8D/B386

        .al
        .xl
        .autsiz
        .databank ?

        ; Pushes the spaces that right-align DIALOGUE_NUMBER1 to two digits (dialogueEpilogueCredits8DCC3D below 10, 8DCC39 below 100).

        lda aDialogue.wNumber1,b
        cmp #$000A
        bcc _B395
        cmp #$0064
        bcs _B3B3
        bra _B3A4


        _B395
        lda #(`dialogueEpilogueCredits8DCC3D)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC3D
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3A4
        lda #(`dialogueEpilogueCredits8DCC39)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC39
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3B3
        rts

        .databank 0

        ; 8D/B3B4

      rsAlignRecordNumber4 ; 8D/B3B4

        .al
        .xl
        .autsiz
        .databank ?

        ; Pushes the spaces that right-align DIALOGUE_NUMBER1 to four digits.

        lda aDialogue.wNumber1,b
        cmp #$000A
        bcc _B3CD
        cmp #$0064
        bcc _B3DC
        cmp #$03E8
        bcc _B3EB
        cmp #$2710
        bcc _B3FA
        bra _B409


        _B3CD
        lda #(`dialogueEpilogueCredits8DCC54)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC54
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3DC
        lda #(`dialogueEpilogueCredits8DCC4C)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC4C
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3EB
        lda #(`dialogueEpilogueCredits8DCC46)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC46
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B3FA
        lda #(`dialogueEpilogueCredits8DCC42)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC42
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rts


        _B409
        rts

        .databank 0

        ; 8D/B40A

      rlASMCRecordStartGeneration1 ; 8D/B40A

        .al
        .xl
        .autsiz
        .databank ?

        ; Play record ASMC: starts the list of first generation units (wEpilogueRecordCharacter 0).

        stz wEpilogueRecordCharacter,b
        rtl

        .databank 0

        ; 8D/B40E

      rlASMCRecordNextGeneration1Unit ; 8D/B40E

        .al
        .xl
        .autsiz
        .databank ?

        ; Play record ASMC: the next first generation character (1-24) who was recruited: its name, wins and losses (dialogueEpilogueCredits8DCC24, grey if dead), and this command again; after the last, goes on.

        lda aDialogue.lActivePointer,b
        sec
        sbc #$0005
        sta aDialogue.lActivePointer,b

        _B418
        lda wEpilogueRecordCharacter,b
        clc
        adc #$0001
        cmp #$0019
        bcs _B471
        sta wEpilogueRecordCharacter,b
        lda wEpilogueRecordCharacter,b
        sta aDialogue.wUnit1,b
        lda wEpilogueRecordCharacter,b
        jsl rlGetCharacterWinCount
        sta aDialogue.wNumber1,b
        lda wEpilogueRecordCharacter,b
        jsl rlGetCharacterLossCount
        sta aDialogue.wNumber2,b
        lda wEpilogueRecordCharacter,b
        asl a
        tax
        lda aEpilogueUnitStates,x
        bit #$4000
        bne _B418
        bit #$8000
        bne _B45C
        lda #$2000
        sta aDialogue.wBaseTile,b
        bra _B462


        _B45C
        lda #$2400
        sta aDialogue.wBaseTile,b

        _B462
        lda #(`dialogueEpilogueCredits8DCC24)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC24
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rtl


        _B471
        lda aDialogue.lActivePointer,b
        clc
        adc #$0005
        sta aDialogue.lActivePointer,b
        rtl

        .databank 0

        ; 8D/B47C

      rlASMCRecordStartGeneration2 ; 8D/B47C

        .al
        .xl
        .autsiz
        .databank ?

        ; Play record ASMC: starts the list of second generation units (wEpilogueRecordCharacter 24).

        lda #$0018
        sta wEpilogueRecordCharacter,b
        rtl

        .databank 0

        ; 8D/B483

      rlASMCRecordNextGeneration2Unit ; 8D/B483

        .al
        .xl
        .autsiz
        .databank ?

        ; Like rlASMCRecordNextGeneration1Unit for characters 25-63.

        lda aDialogue.lActivePointer,b
        sec
        sbc #$0005
        sta aDialogue.lActivePointer,b

        _B48D
        lda wEpilogueRecordCharacter,b
        clc
        adc #$0001
        cmp #$0040
        bcs _B4E6
        sta wEpilogueRecordCharacter,b
        lda wEpilogueRecordCharacter,b
        sta aDialogue.wUnit1,b
        lda wEpilogueRecordCharacter,b
        jsl rlGetCharacterWinCount
        sta aDialogue.wNumber1,b
        lda wEpilogueRecordCharacter,b
        jsl rlGetCharacterLossCount
        sta aDialogue.wNumber2,b
        lda wEpilogueRecordCharacter,b
        asl a
        tax
        lda aEpilogueUnitStates,x
        bit #$4000
        bne _B48D
        bit #$8000
        bne _B4D1
        lda #$2000
        sta aDialogue.wBaseTile,b
        bra _B4D7


        _B4D1
        lda #$2400
        sta aDialogue.wBaseTile,b

        _B4D7
        lda #(`dialogueEpilogueCredits8DCC24)<<8
        sta lR18+1
        lda #<>dialogueEpilogueCredits8DCC24
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rtl


        _B4E6
        lda aDialogue.lActivePointer,b
        clc
        adc #$0005
        sta aDialogue.lActivePointer,b
        rtl

        .databank 0

        ; 8D/B4F1

    .endsection Unsorted8DB2B8Section


