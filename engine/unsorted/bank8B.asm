; Code from bank $8B not yet assigned to a game system.

    .section Unsorted8B8000Section

      .al
      .xl

      rsUnknown8B8000 ; 8B/8000

        .al
        .autsiz
        .databank ?

        lda #(`procMainLoopChangeFadeByTimer)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFadeByTimer
        sta lR44
        jsl rlProcEngineFindProc
        bcs +

          lda wCurrentChapter,b
          cmp #$FFFF
          beq +

            lda wJoy1New
            cmp #JOY_Start
            bne +

              lda #2
              sta wScreenFadingProcInput,b

              lda #<>rsUnknown80F2BE
              sta aProcSystem.wInput0,b

              lda #(`procMainLoopChangeFadeByTimer)<<8
              sta lR44+1
              lda #<>procMainLoopChangeFadeByTimer
              sta lR44
              jsl rlProcEngineCreateProc

              lda #2
              sta wUnknown00171C,b
              jsl rlUnknown9180BC

        +
        jsr rsHandleWorldMapPortraits
        jsr rsHandleWorldMapMarkers

        lda aDialogue.wStatus,b
        beq +

          lda #$00E2
          sta wR0
          lda #$00C4
          sta wR1
          jsl rlDisplayDialogueAPressArrows

          jsl rlDMAByStruct

            .structDMAToVRAM $7E8908, $0140, $80, $BD80

        +
        jsr rsUnknown8B8114
        rtl

        .databank 0

        ; 8B/806D

    .endsection Unsorted8B8000Section


    .section Unsorted8B806DSection

      .al
      .xl

      rlUnknown8B806D ; 8B/806D

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        jsr rsUnknown8B87E5
        lda wJoy1Input
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        beq _8092
        lda #$0002
        sta wMapScrollSpeed,b
        lda wJoy1Input
        bit #$4000
        beq _808F
        lda #$0004
        sta wMapScrollSpeed,b

        _808F
        jsr rsUnknown8B8AAB

        _8092
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #$EE52
        lda $087D,b
        sta wR0
        lda $087F,b
        sta wR1
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        lda aDialogue.wStatus,b
        beq _80C3
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8908, $0140, $80, $BD80


        _80C3
        lda wVBlankEnabledFramecount
        and #$000F
        bne _80CA

        _80CA
        rtl

        .databank 0

        ; 8B/80CB

    .endsection Unsorted8B806DSection


    .section Unsorted8B80CBSection

      .al
      .xl

      rlUnknown8B80CB ; 8B/80CB

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta $08DA,b
        lda #$00E6
        jsl rlUnknown808F6F
        lda #$000C
        sta wScreenFadingProcInput,b
        lda #$ECC9
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFadeByTimer)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFadeByTimer
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 8B/80F3

      rlUnknown8B80F3 ; 8B/80F3

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta $08DA,b
        lda #$0006
        sta wScreenFadingProcInput,b
        lda #$ECC9
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFadeByTimer)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFadeByTimer
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 8B/8114

      rsUnknown8B8114 ; 8B/8114

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$003C
        lsr a
        tax
        lda aUnknown8CDE00,x
        sta $022A,b
        lda aUnknown8CDE20,x
        sta $024A,b
        rts

        .databank 0

        ; 8B/812A

    .endsection Unsorted8B80CBSection


    .section Unsorted8B818DSection

      .al
      .xl

      rsUnknown8B818D ; 8B/818D

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        lda #$0001
        jsl rlLoadWorldMapPortraitIntoSlot
        ldx #$0000
        lda #$0080
        sta wR0
        lda #$0080
        sta wR1
        jsl rlFadeInWorldMapPortraitSlot
        ldx #$0002
        lda #$0002
        jsl rlLoadWorldMapPortraitIntoSlot
        ldx #$0002
        lda #$00A0
        sta wR0
        lda #$00A0
        sta wR1
        jsl rlFadeInWorldMapPortraitSlot
        lda #$0040
        sta wR0
        lda #$0040
        sta wR1
        ldx #$0000
        ldy #$0002
        jsl rlLoadWorldMapMarkerData
        lda #$0080
        sta wR0
        lda #$0060
        sta wR1
        ldx #$0002
        ldy #$0004
        jsl rlLoadWorldMapMarkerData
        rts

        .databank 0

        ; 8B/81EC

    .endsection Unsorted8B818DSection


    .section Unsorted8B87E5Section

      .al
      .xl

      rsUnknown8B87E5 ; 8B/87E5

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        bit #$0080
        bne _8804
        bit #$8000
        bne _8808
        bit #$0040
        bne _8810
        bit #$0010
        bne _881A
        bit #$0020
        bne _883D
        bit #$2000
        bne _884F
        rts


        _8804
        jml _8871


        _8808
        lda #$0000
        sta $7F5410
        rts


        _8810
        lda wVBlankEnabledFramecount
        and #$0007
        jsl rlHighlightWorldMapPart
        rts


        _881A
        jsl rlUnknown8B87A0
        jsl rlResetDialogueEngine
        lda #$0002
        jsl rlUnknown91811C
        lda #(`rlUnknown8B9275)<<8
        sta aDialogue.lHDMARoutine+1,b
        lda #<>rlUnknown8B9275
        sta aDialogue.lHDMARoutine,b
        ldx #$0000
        jsl rlUnknown8B91F6
        rts


        _883D
        jsl rlDMAByStruct

          .structDMAToVRAM $D96C00, $0800, $80, $B000

        jsl rlResetHDMAEngine
        rts


        _884F
        lda #$0021
        jsl rlUnknown808FAD
        lda #$0000
        sta $0D77,b
        lda #$B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _8871
        lda $7F5440
        lda wVBlankEnabledFramecount
        and #$002F
        lda $7F5440
        ldx #$0000
        jsl rlLoadWorldMapPortraitIntoSlot
        lda wVBlankEnabledFramecount
        and #$002F
        lda $7F5440
        clc
        adc #$0001
        ldx #$0002
        jsl rlLoadWorldMapPortraitIntoSlot
        lda wVBlankEnabledFramecount
        and #$002F
        lda $7F5440
        clc
        adc #$0002
        ldx #$0004
        jsl rlLoadWorldMapPortraitIntoSlot
        lda wVBlankEnabledFramecount
        and #$002F
        lda $7F5440
        clc
        adc #$0003
        ldx #$0006
        jsl rlLoadWorldMapPortraitIntoSlot
        lda $7F5440
        clc
        adc #$0004
        sta $7F5440
        rts

        .databank 0

        ; 8B/88CE

    .endsection Unsorted8B87E5Section


    .section Unsorted8B8AABSection

      .al
      .xl

      rsUnknown8B8AAB ; 8B/8AAB

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _8AD7
        cmp #$0100
        beq _8ADB
        cmp #$0800
        beq _8ADF
        cmp #$0400
        beq _8AE3
        cmp #$0A00
        beq _8AE7
        cmp #$0600
        beq _8AEE
        cmp #$0900
        beq _8AF5
        cmp #$0500
        beq _8AFC
        rts


        _8AD7
        jml _8B03


        _8ADB
        jml _8B17


        _8ADF
        jml _8B2E


        _8AE3
        jml _8B42


        _8AE7
        jsr _8B03
        jml _8B2E


        _8AEE
        jsr _8B03
        jml _8B42


        _8AF5
        jsr _8B17
        jml _8B2E


        _8AFC
        jsr _8B17
        jml _8B42


        _8B03
        jsl rlUnknown8885EF
        lda $087D,b
        sec
        sbc wMapScrollSpeed,b
        bpl _8B13
        lda #$0000

        _8B13
        sta $087D,b
        rts


        _8B17
        jsl rlUnknown8885FD
        lda $087D,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00F1
        bcc _8B2A
        lda #$00F0

        _8B2A
        sta $087D,b
        rts


        _8B2E
        jsl rlUnknown8885D3
        lda $087F,b
        sec
        sbc wMapScrollSpeed,b
        bpl _8B3E
        lda #$0000

        _8B3E
        sta $087F,b
        rts


        _8B42
        jsl rlUnknown8885E1
        lda $087F,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00D1
        bcc _8B55
        lda #$00D0

        _8B55
        sta $087F,b
        rts

        .databank 0

        ; 8B/8B59

    .endsection Unsorted8B8AABSection


    .section Unsorted8B8BB5Section

      .al
      .xl

      rlUnknown8B8BB5 ; 8B/8BB5

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7F808B
        sta aPaletteFading.wCurrentStep,b
        lda wVBlankEnabledFramecount
        and #$0003
        bne _8BD6
        lda #$0010
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .byte $A8, $CB, $05, $00, $B0, $00

        bcs _8BDE

        _8BD6
        lda aPaletteFading.wCurrentStep,b
        sta $7F808B
        rtl


        _8BDE
        jsl rlProcEngineFreeProc
        lda #$8B00
        sta lR44+1
        lda #$8C3A
        sta lR44
        jsl rlProcEngineCreateProc
        bra _8BD6

        .databank 0

        ; 8B/8BF2

    .endsection Unsorted8B8BB5Section


    .section Unsorted8B8C42Section

      .al
      .xl

      rlUnknown8B8C42 ; 8B/8C42

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7F808F
        rtl

        .databank 0

        ; 8B/8C4A

      rlUnknown8B8C4A ; 8B/8C4A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F808F
        sta aPaletteFading.wCurrentStep,b
        lda wVBlankEnabledFramecount
        and #$0003
        bne _8C6D
        lda #$0000
        sta aPaletteFading.wDesiredColor,b
        lda #$0020
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToBlack

          .byte $7B, $8C

        bcs _8C75

        _8C6D
        lda aPaletteFading.wCurrentStep,b
        sta $7F808F
        rtl


        _8C75
        jsl rlProcEngineFreeProc
        bra _8C6D

        .databank 0

        ; 8B/8C7B

    .endsection Unsorted8B8C42Section


    .section Unsorted8B912ASection

      .al
      .xl

      rlUnknown8B912A ; 8B/912A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F548E
        bne _9134
        jml _9196


        _9134
        lda aDialogue.wStatus,b
        sta $7F548E
        sep #$20
        lda #$01
        sta @l $0008BC
        lda #$00
        sta @l $0008BD
        lda #$7F
        sta @l $0008BE
        lda bBufferTM
        sta @l $0008BF
        lda #$28
        sta @l $0008C0
        lda bBufferTM
        sta @l $0008C1
        lda #$08
        sta @l $0008C2
        lda #$02
        sta @l $0008C3
        lda #$20
        sta @l $0008C4
        lda #$16
        sta @l $0008C5
        lda #$08
        sta @l $0008C6
        lda #$12
        sta @l $0008C7
        lda #$00
        sta @l $0008C8
        lda #$00
        sta @l $0008C9
        rep #$20
        rtl

        .byte $FC, $C1


        _9196
        lda aDialogue.wStatus,b
        sta $7F548E
        sep #$20
        lda #$01
        sta @l $0008BC
        lda #$00
        sta @l $0008BD
        lda #$7F
        sta @l $0008BE
        lda bBufferTM
        sta @l $0008BF
        lda #$28
        sta @l $0008C0
        lda bBufferTM
        sta @l $0008C1
        lda #$08
        sta @l $0008C2
        lda #$02
        sta @l $0008C3
        lda #$20
        sta @l $0008C4
        lda #$12
        sta @l $0008C5
        lda #$08
        sta @l $0008C6
        lda #$12
        sta @l $0008C7
        lda #$00
        sta @l $0008C8
        lda #$00
        sta @l $0008C9
        rep #$20
        rtl

        .databank 0

        ; 8B/91F6

    .endsection Unsorted8B912ASection


    .section Unsorted8B96CFSection

      .al
      .xl

      rlUnknown8B96CF ; 8B/96CF

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        sta wBufferBG1HOFS
        and #$000F
        sec
        sbc #$0008
        sta wBufferBG3HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG1VOFS
        sta wBufferBG3VOFS
        rtl

        .databank 0

        ; 8B/96E5

      rlUnknown8B96E5 ; 8B/96E5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7F00
        sta lR18+1
        lda #$5709
        sta lR18
        lda #$A8F6
        jsl rlBuildRAMAreaHeaderAndGuidingEntry
        ldx #$1308
        lda #$0000

        _96FC
        sta $7F4400,x
        dec x
        bpl _96FC
        jsl rlEnableActiveSpriteEngine
        inc wGameStateRoutine1,b
        stz wGameStateStep,b
        stz $0AD3,b
        lda #$0001
        sta $0594,b
        rtl

        .databank 0

        ; 8B/9717

      rlUnknown8B9717 ; 8B/9717

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8B
        lda wGameStateStep,b
        asl a
        tax
        jsr ($8B9726,x)
        plp
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/9726

    .endsection Unsorted8B96CFSection


    .section Unsorted8BA7CBSection

      .al
      .xl

      rlUnknown8BA7CB ; 8B/A7CB

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 8B/A7CC

      rlUnknown8BA7CC ; 8B/A7CC

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 8B/A7CD

      rlUnknown8BA7CD ; 8B/A7CD

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 8B/A7CE

    .endsection Unsorted8BA7CBSection


    .section Unsorted8BA7F2Section

      .al
      .xl

      rlUnknown8BA7F2 ; 8B/A7F2

        .al
        .xl
        .autsiz
        .databank ?

        inc wGameStateRoutine1,b
        lda #$0001
        sta $7F82E5
        jsr $8BB8B6
        lda wGameStateStep,b
        cmp #$0004
        bne _A80C
        jsr $8BB871
        bra _A816


        _A80C
        cmp #$0005
        bne _A816
        lda #$0017
        sta bBufferTM

        _A816
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8B/A81F

      rlUnknown8BA81F ; 8B/A81F

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8B
        lda $7F82E5
        bne _A842
        lda $7F82E7
        ora $7F82ED
        bne _A842
        lda wGameStateStep,b
        cmp #$0006
        bmi _A83D

        _A83B
        bra _A83B


        _A83D
        asl a
        tax
        jsr ($8BA845,x)

        _A842
        plp
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/A845

    .endsection Unsorted8BA7F2Section


    .section Unsorted8BA851Section

      .al
      .xl

      rlUnknown8BA851 ; 8B/A851

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F82E3
        bne _A85A
        jsr $8BB8B6

        _A85A
        lda $7F82E7
        bne _A86B
        jsl $8BB54F
        jsl $8BB469
        jsr $8BBAE9

        _A86B
        lda $7F82E7
        bne _A886
        lda wGameStateStep,b
        cmp #$0004
        bne _A87E
        jsr $8BB871
        bra _A886


        _A87E
        cmp #$0001
        bne _A886
        jsr $8BB7D3

        _A886
        lda $7F82E5
        cmp #$0001
        beq _A8A0
        cmp #$0002
        beq _A8C1
        cmp #$0003
        beq _A8DA
        cmp #$0004
        beq _A8DE
        bra _A8F8


        _A8A0
        sep #$20
        lda bBufferINIDISP
        clc
        adc #$05
        sta bBufferINIDISP
        rep #$20
        cmp #$000F
        bcc _A8F7
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        lda #$0000
        sta $7F82E5
        bra _A8F7


        _A8C1
        sep #$20
        lda bBufferINIDISP
        sec
        sbc #$01
        sta bBufferINIDISP
        rep #$20
        bpl _A8F7
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        jml $8BAC53


        _A8DA
        jml $8BAC31


        _A8DE
        sep #$20
        lda bBufferINIDISP
        sec
        sbc #$05
        sta bBufferINIDISP
        rep #$20
        bpl _A8F7
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        jml $8BAC67


        _A8F7
        rtl


        _A8F8
        lda $7F82DD
        bmi _A963
        bne _A967
        lda $7F82E7
        beq _A90A
        jml _A97B


        _A90A
        lda $7F82ED
        beq _A914
        jml $8BAC20


        _A914
        lda #$0000
        sta $7F82E3
        lda wJoy1New
        bmi _A94F
        bit #$0080
        bne _A953
        bit #$0040
        bne _A957
        bit #$2000
        bne _A96B
        bit #$1000
        bne _A96F
        bit #$4000
        bne _A97F
        bit #$0020
        bne _A973
        bit #$0010
        bne _A977
        lda wJoy1Repeated
        bit #$0800
        bne _A95B
        bit #$0400
        bne _A95F
        rtl


        _A94F
        jml _A983


        _A953
        jml _A9BD


        _A957
        jml _AA10


        _A95B
        jml _AA31


        _A95F
        jml _AAA1


        _A963
        jml _AAF7


        _A967
        jml _AB6E


        _A96B
        jml $8BABE5


        _A96F
        jml $8BABED


        _A973
        jml $8BABE9


        _A977
        jml $8BABF1


        _A97B
        jml $8BABF5


        _A97F
        jml $8BABFC


        _A983
        lda #$0021
        jsl rlUnknown808FAD
        jsl rlUnknown8BCE29
        lda wGameStateStep,b
        sta wUnknown7E5315
        lda wUnknown000D79,b
        bit #$0020
        bne _A9AD
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0003
        sta $7F82E5
        rtl


        _A9AD
        sep #$20
        lda #$0E
        sta bBufferINIDISP
        rep #$20
        lda #$0002
        sta $7F82E5
        rtl


        _A9BD
        lda #$000A
        jsl rlUnknown808FAD
        jsl rlUnknown8BCE29
        lda wGameStateStep,b
        sta wUnknown7E5315
        jsl rlGetSelectedUnitStates
        bit #$8000
        beq _A9F9
        jsl rlGetSelectedUnitDeploymentOffset
        cmp #$0000
        bmi _A9E9
        sta @l wActiveUnitDeploymentOffset
        jsl $8881D7

        _A9E9
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0003
        sta $7F82E5
        rtl


        _A9F9
        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        sep #$20
        lda #$0E
        sta bBufferINIDISP
        rep #$20
        lda #$0002
        sta $7F82E5
        rtl


        _AA10
        lda #$0008
        jsl rlUnknown808FAD
        jsl rlUnknown8BCE29
        lda wGameStateStep,b
        sta wUnknown7E5315
        lda #$0000
        sta $7F819D
        lda #$0004
        sta $7F82E5
        rtl


        _AA31
        lda $7F82C7
        cmp #$0001
        beq _AA4B
        lda $7F82C9
        cmp #$0000
        beq _AA47
        jml _AA67


        _AA47
        jml _AA84


        _AA4B
        lda wJoy1New
        bit #$0800
        beq _AA66
        lda $7F82ED
        bne _AA66
        lda #$0001
        sta $7F82E7
        lda #$0006
        jsl rlUnknown808FAD

        _AA66
        rtl


        _AA67
        lda #$FFFF
        sta $7F82DD
        lda #$0000
        sta $7F82D5
        sta $7F82D9
        lda #$0006
        jsl rlUnknown808FAD
        jml _AAF7


        _AA84
        lda #$0001
        sta $7F82DD
        lda #$0000
        sta $7F82D7
        sta $7F82D9
        lda #$0006
        jsl rlUnknown808FAD
        jml _AB6E


        _AAA1
        lda $7F82C7
        cmp $7F82CD
        beq _AABC
        lda $7F82C9
        cmp #$0009
        beq _AAB8
        jml _AABD


        _AAB8
        jml _AADA


        _AABC
        rtl


        _AABD
        lda #$FFFF
        sta $7F82DD
        sta $7F82D5
        lda #$0000
        sta $7F82D9
        lda #$0006
        jsl rlUnknown808FAD
        jml _AAF7


        _AADA
        lda #$0001
        sta $7F82DD
        sta $7F82D7
        lda #$0000
        sta $7F82D9
        lda #$0006
        jsl rlUnknown808FAD
        jml _AB6E


        _AAF7
        lda $7F82D5
        bne _AB37
        lda $7F82DB
        sec
        sbc #$0008
        sta $7F82DB
        lda $7F82D9
        clc
        adc #$0001
        sta $7F82D9
        cmp #$0002
        bne _AB6D
        lda #$0000
        sta $7F82DD
        lda $7F82C9
        dec a
        sta $7F82C9
        lda $7F82C7
        dec a
        sta $7F82C7
        jml _AB6D


        _AB37
        lda $7F82DB
        clc
        adc #$0008
        sta $7F82DB
        lda $7F82D9
        clc
        adc #$0001
        sta $7F82D9
        cmp #$0002
        bne _AB6D
        lda #$0000
        sta $7F82DD
        lda $7F82C9
        inc a
        sta $7F82C9
        lda $7F82C7
        inc a
        sta $7F82C7

        _AB6D
        rtl


        _AB6E
        lda $7F82D7
        bne _ABAE
        lda $7F82DF
        sec
        sbc #$0008
        sta $7F82DF
        lda $7F82D9
        clc
        adc #$0001
        sta $7F82D9
        cmp #$0002
        bne _ABE4
        lda #$0000
        sta $7F82DD
        lda $7F82CB
        dec a
        sta $7F82CB
        lda $7F82C7
        dec a
        sta $7F82C7
        jml _ABE4


        _ABAE
        lda $7F82DF
        clc
        adc #$0008
        sta $7F82DF
        lda $7F82D9
        clc
        adc #$0001
        sta $7F82D9
        cmp #$0002
        bne _ABE4
        lda #$0000
        sta $7F82DD
        lda $7F82CB
        inc a
        sta $7F82CB
        lda $7F82C7
        inc a
        sta $7F82C7

        _ABE4
        rtl

        .databank 0

        ; 8B/ABE5

      rlUnknown8BABE5 ; 8B/ABE5

        .al
        .xl
        .autsiz
        .databank ?

        jsr $8BB71F
        rtl

        .databank 0

        ; 8B/ABE9

      rlUnknown8BABE9 ; 8B/ABE9

        .al
        .xl
        .autsiz
        .databank ?

        jsr $8BB751
        rtl

        .databank 0

        ; 8B/ABED

      rlUnknown8BABED ; 8B/ABED

        .al
        .xl
        .autsiz
        .databank ?

        jsr $8BB596
        rtl

        .databank 0

        ; 8B/ABF1

      rlUnknown8BABF1 ; 8B/ABF1

        .al
        .xl
        .autsiz
        .databank ?

        jsr $8BB63B
        rtl

        .databank 0

        ; 8B/ABF5

      rlUnknown8BABF5 ; 8B/ABF5

        .al
        .xl
        .autsiz
        .databank ?

        jsr $8BC21F
        jsr $8BBAE9
        rtl

        .databank 0

        ; 8B/ABFC

      rlUnknown8BABFC ; 8B/ABFC

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta $7F82ED
        lda $7F82DB
        clc
        adc $7F82DF
        sta $7F82F1
        lda $7F82C7
        sta $7F82EF
        lda #$000A
        jsl rlUnknown808FAD
        rtl

        .databank 0

        ; 8B/AC20

      rlUnknown8BAC20 ; 8B/AC20

        .al
        .xl
        .autsiz
        .databank ?

        jsr $8BC391
        lda $7F82ED
        cmp #$0001
        bne _AC30
        jml $8BA942


        _AC30
        rtl

        .databank 0

        ; 8B/AC31

      rlUnknown8BAC31 ; 8B/AC31

        .al
        .xl
        .autsiz
        .databank ?

        jsl $88DE0B
        lda #$0000
        sta $7F82C5
        sta $7F8183
        lda #$0001
        sta $0D77,b
        lda #$B122
        sta wMainLoopPointer
        lda #$00E8
        jsl rlUnknown808F6F
        rtl

        .databank 0

        ; 8B/AC53

      rlUnknown8BAC53 ; 8B/AC53

        .al
        .xl
        .autsiz
        .databank ?

        jsl $88DE0B
        lda #$0000
        sta $7F82C5
        sta $7F8183
        jsl $80BB5D
        rtl

        .databank 0

        ; 8B/AC67

      rlUnknown8BAC67 ; 8B/AC67

        .al
        .xl
        .autsiz
        .databank ?

        jsl $88DE0B
        lda #$0000
        sta $7F82C5
        lda #$C3E6
        sta $7F8183
        lda #$BBD9
        sta wMainLoopPointer
        rtl

        .databank 0

        ; 8B/AC7F

    .endsection Unsorted8BA851Section


    .section Unsorted8BADF1Section

      .al
      .xl

      rlUnknown8BADF1 ; 8B/ADF1

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$01D4
        lda #$0030
        ldy #$0016
        jsl rlClearTilemapRect
        lda wGameStateStep,b
        cmp #$0006
        bmi _AE08

        _AE06
        bra _AE06


        _AE08
        asl a
        tax
        jsr ($8BAE12,x)
        jsl rlUnknown8BC5C6
        rtl

        .databank 0

        ; 8B/AE12

    .endsection Unsorted8BADF1Section


    .section Unsorted8BB45DSection

      .al
      .xl

      rlUnknown8BB45D ; 8B/B45D

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$1000

        _B460
        sta $7E8386,x
        dec x
        dec x
        bne _B460
        rtl

        .databank 0

        ; 8B/B469

    .endsection Unsorted8BB45DSection


    .section Unsorted8BB469Section

      .al
      .xl

      rlUnknown8BB469 ; 8B/B469

        .al
        .xl
        .autsiz
        .databank ?

        jsr $8BB50D
        lda wVBlankEnabledFramecount
        and #$0018
        beq _B48B
        stz wR0
        stz wR1
        stz wR4
        stz wR5
        phk
        plb
        .databank $8B
        lda wGameStateStep,b
        asl a
        tax
        lda @l $8BB4C7,x
        tay
        jsl rlPushToOAMBuffer

        _B48B
        lda $7F82CD
        cmp #$000B
        bcc _B4C6
        lda wVBlankEnabledFramecount
        and #$0008
        beq _B4C6
        stz wR0
        stz wR4
        stz wR5
        lda #$0080
        sta wR1
        ldy #$0000
        lda $7F82CB
        cmp $7F82D1
        beq _B4BC
        inc y
        inc y
        cmp #$0000
        bne _B4BC
        inc y
        inc y

        _B4BC
        phk
        plb
        .databank $8B
        lda $B4ED,b,y
        tay
        jsl rlPushToOAMBuffer

        _B4C6
        rtl

        .databank 0

        ; 8B/B4C7

    .endsection Unsorted8BB469Section


    .section Unsorted8BB50DSection

      .al
      .xl

      rsUnknown8BB50D ; 8B/B50D

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown7E5319
        sec
        sbc #$0019
        bmi _B533
        cmp #$000A
        bpl _B533
        asl a
        tax
        lda $8BB53B,x
        sta wR4
        stz wR0
        stz wR1
        stz wR5
        phk
        plb
        .databank $8B
        ldy #$B534
        jsl rlPushToOAMBuffer

        _B533
        rts

        .databank 0

        ; 8B/B534

    .endsection Unsorted8BB50DSection


    .section Unsorted8BB54FSection

      .al
      .xl

      rlUnknown8BB54F ; 8B/B54F

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F82DB
        dec a
        sta wR1
        lda #$0000
        sta wR0
        lda $7F82E7
        jsl rlUnknown88A704
        lda $7F82ED
        beq _B58E
        lda wVBlankEnabledFramecount
        and #$0001
        bne _B58E
        lda $7F82F1
        dec a
        sec
        sbc $7F82DF
        sta wR1
        lda #$0000
        sta wR0
        stz wR4
        stz wR5
        phk
        plb
        .databank $8B
        ldy #$B58F
        jsl rlPushToOAMBuffer

        _B58E
        rtl

        .databank 0

        ; 8B/B58F

    .endsection Unsorted8BB54FSection


    .section Unsorted8BB596Section

      .al
      .xl

      rsUnknown8BB596 ; 8B/B596

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8B
        lda $7F82C7
        sta wR0
        lda $7F82CD
        sta $7F82C7
        cmp #$000A
        bpl _B5E3
        lda #$0000
        sta $7F82CB
        lda $7F82CD
        dec a
        sta $7F82C9
        asl a
        tax
        lda @l $8BB70B,x
        sta $7F82DB
        lda $7F82CB
        asl a
        tax
        lda @l $8BB61B,x
        sta $7F82DF
        lda wR0
        cmp $7F82CD
        beq _B5E2
        lda #$0006
        jsl rlUnknown808FAD

        _B5E2
        rts


        _B5E3
        lda $7F82CD
        sec
        sbc #$000A
        sta $7F82CB
        lda #$0009
        sta $7F82C9
        lda #$00CA
        sta $7F82DB
        lda $7F82CB
        asl a
        tax
        lda @l $8BB61B,x
        sta $7F82DF
        lda wR0
        cmp $7F82CD
        beq _B61A
        lda #$0006
        jsl rlUnknown808FAD

        _B61A
        rts

        .databank 0

        ; 8B/B61B

    .endsection Unsorted8BB596Section


    .section Unsorted8BB63BSection

      .al
      .xl

      rsUnknown8BB63B ; 8B/B63B

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F82C7
        sta wR0
        lda $7F82CB
        clc
        adc #$000A
        cmp $7F82D1
        beq _B655
        bcc _B655
        jml _B659


        _B655
        jml _B6E1


        _B659
        lda $7F82CB
        cmp $7F82D1
        beq _B68F
        lda $7F82D1
        sta $7F82CB
        lda $7F82CB
        clc
        adc $7F82C9
        inc a
        sta $7F82C7
        lda $7F82CB
        asl a
        tax
        lda $8BB61B,x
        sta $7F82DF
        lda #$0006
        jsl rlUnknown808FAD
        rts


        _B68F
        lda $7F82CD
        sta $7F82C7
        lda $7F82CD
        cmp #$000B
        bmi _B6BE
        lda #$0009
        sta $7F82C9
        lda #$00CA
        sta $7F82DB
        lda wR0
        cmp $7F82CD
        beq _B6BD
        lda #$0006
        jsl rlUnknown808FAD

        _B6BD
        rts


        _B6BE
        lda $7F82CD
        dec a
        sta $7F82C9
        asl a
        tax
        lda $8BB70B,x
        sta $7F82DB
        lda wR0
        cmp $7F82CD
        beq _B6E0
        lda #$0006
        jsl rlUnknown808FAD

        _B6E0
        rts


        _B6E1
        lda $7F82C7
        clc
        adc #$000A
        sta $7F82C7
        lda $7F82CB
        clc
        adc #$000A
        sta $7F82CB
        asl a
        tax
        lda $8BB61B,x
        sta $7F82DF
        lda #$0006
        jsl rlUnknown808FAD
        rts

        .databank 0

        ; 8B/B70B

    .endsection Unsorted8BB63BSection


    .section Unsorted8BB71FSection

      .al
      .xl

      rsUnknown8BB71F ; 8B/B71F

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F82C7
        sta wR0
        lda #$0000
        sta $7F82CB
        sta $7F82C9
        sta $7F82DF
        lda #$003A
        sta $7F82DB
        lda #$0001
        sta $7F82C7
        lda wR0
        cmp #$0001
        beq _B750
        lda #$0006
        jsl rlUnknown808FAD

        _B750
        rts

        .databank 0

        ; 8B/B751

      rsUnknown8BB751 ; 8B/B751

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F82CB
        sec
        sbc #$000A
        beq _B7A9
        bpl _B7A9
        lda $7F82CB
        beq _B77F
        lda #$0000
        sta $7F82CB
        sta $7F82DF
        lda $7F82C9
        inc a
        sta $7F82C7
        lda #$0006
        jsl rlUnknown808FAD
        rts


        _B77F
        lda $7F82C7
        sta wR0
        lda #$0001
        sta $7F82C7
        lda #$0000
        sta $7F82C9
        lda #$003A
        sta $7F82DB
        lda wR0
        cmp #$0001
        beq _B7A8
        lda #$0006
        jsl rlUnknown808FAD

        _B7A8
        rts


        _B7A9
        lda $7F82C7
        sec
        sbc #$000A
        sta $7F82C7
        lda $7F82CB
        sec
        sbc #$000A
        sta $7F82CB
        asl a
        tax
        lda $8BB61B,x
        sta $7F82DF
        lda #$0006
        jsl rlUnknown808FAD
        rts

        .databank 0

        ; 8B/B7D3

      rsUnknown8BB7D3 ; 8B/B7D3

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8B
        stz wR15
        stz wR5
        stz wR0

        _B7DB
        lda wR15
        cmp $7F82CD
        beq _B809
        lda wR15
        asl a
        tax
        lda @l $8BB841,x
        sec
        sbc $7F82DF
        sta wR1
        lda $7F8391,x
        asl a
        tax
        lda @l $8BB811,x
        sta wR4
        ldy #$B80A
        jsl rlPushToOAMBuffer
        inc wR15
        bra _B7DB


        _B809
        rts

        .databank 0

        ; 8B/B80A

    .endsection Unsorted8BB71FSection


    .section Unsorted8BB871Section

      .al
      .xl

      rsUnknown8BB871 ; 8B/B871

        .al
        .xl
        .autsiz
        .databank ?

        stz wR0
        stz wR1
        stz wR4
        stz wR5
        lda #$B882
        tay
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8B/B882

    .endsection Unsorted8BB871Section


    .section Unsorted8BB8B6Section

      .al
      .xl

      rsUnknown8BB8B6 ; 8B/B8B6

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F82E7
        ora $7F82ED
        beq _B8C4
        jml _B9C5


        _B8C4
        phk
        plb
        .databank $8B
        sep #$20
        ldx #$001A
        lda #$10

        _B8CD
        sta $7FB044,x
        dec x
        bpl _B8CD
        rep #$20
        lda $7F82C9
        and #$00FF
        tax
        sep #$20
        ldy #$0010
        lda #$01

        _B8E5
        sta $7FB044,x
        inc x
        dec y
        bne _B8E5
        rep #$20
        stz wR3
        stz wR4

        _B8F3
        lda $7F82C9
        cmp wR3
        beq _B926
        lda wR3
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $BA81,b,x
        phx
        pha
        lda wR4
        tax
        pla
        sta $7FB063,x
        txy
        plx
        lda @l $8BBA80,x
        tyx
        sta $7FB062,x
        lda wR4
        clc
        adc #$0003
        sta wR4
        bra _B95A


        _B926
        ldx #$0000

        _B929
        lda $7F82FE,x
        phx
        pha
        lda wR4
        tax
        pla
        sta $7FB063,x
        plx
        lda $7F82FD,x
        phx
        pha
        lda wR4
        tax
        pla
        sta $7FB062,x
        txa
        clc
        adc #$0003
        sta wR4
        plx
        inc x
        inc x
        inc x
        cpx #$0030
        beq _B95A
        jml _B929


        _B95A
        lda wR3
        inc a
        sta wR3
        cmp #$000B
        beq _B968
        jml _B8F3


        _B968
        lda $7F82FB
        bne _B9B3
        lda $7F82F9
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda #$0000
        sta wR0
        ldy #$0010

        _B981
        phx
        lda $B9FD,b,x
        ldx wR0
        sta $7F82FE,x
        plx
        lda $B9FC,b,x
        phx
        ldx wR0
        sta $7F82FD,x
        inc x
        inc x
        inc x
        stx wR0
        plx
        inc x
        inc x
        inc x
        dec y
        bne _B981
        lda $7F82F9
        inc a
        cmp #$0016
        bne _B9AF
        lda #$0000

        _B9AF
        sta $7F82F9

        _B9B3
        lda $7F82FB
        inc a
        cmp #$0006
        bne _B9C0
        lda #$0000

        _B9C0
        sta $7F82FB
        rts


        _B9C5
        sep #$20
        ldx #$001A
        lda #$10

        _B9CC
        sta $7FB044,x
        dec x
        bpl _B9CC
        rep #$20
        ldx #$0000

        _B9D8
        lda @l $8BBA81,x
        sta $7FB063,x
        lda @l $8BBA80,x
        sta $7FB062,x
        inc x
        inc x
        inc x
        cpx #$0024
        bne _B9D8
        lda #$0000
        sta $7FB063,x
        sta $7FB062,x
        rts

        .databank 0

        ; 8B/B9FC

    .endsection Unsorted8BB8B6Section


    .section Unsorted8BBAE9Section

      .al
      .xl

      rsUnknown8BBAE9 ; 8B/BAE9

        .al
        .xl
        .autsiz
        .databank ?

        stz wR0
        stz wR1
        stz wR4
        stz wR5
        lda wUnknown7E5317
        bne _BAFC
        ldy #$BD9B
        bra _BAFF


        _BAFC
        ldy #$BD8F

        _BAFF
        jsl rlPushToOAMBuffer
        lda wVBlankEnabledFramecount
        and #$0018
        beq _BB38
        lda #$0000

        _BB0D
        sta wR15
        asl a
        tax
        lda $7F83C3,x
        beq _BB2F
        lda $8BBD40,x
        sec
        sbc $7F82DF
        sta wR1
        stz wR0
        stz wR4
        stz wR5
        ldy #$BD83
        jsl rlPushToOAMBuffer

        _BB2F
        lda wR15
        inc a
        cmp $7F82CD
        bne _BB0D

        _BB38
        jsr $8BBDA7
        phk
        plb
        .databank $8B
        ldx #$002E
        lda $7F82C7
        dec a
        asl a
        sta wR0

        _BB48
        cpx wR0
        beq _BB50
        dec x
        dec x
        bra _BB48


        _BB50
        lda $7F82EF
        dec a
        asl a
        sta wR0
        cpx wR0
        bne _BB67
        lda wVBlankEnabledFramecount
        and #$0001
        beq _BB67
        jml _BBE1


        _BB67
        phx
        lda $7F8391,x
        asl a
        tax
        lda $7E486B,x
        cmp #$FFFF
        beq _BB83
        lda $88D2B5,x
        sta wR4
        lda #$BD77
        tay
        bra _BB8D


        _BB83
        lda $88D1C5,x
        sta wR4
        lda #$BD70
        tay

        _BB8D
        plx
        phx
        phy
        ldy #$2C00
        cpx #$0000
        bne _BBA1
        lda $7F82DF
        bne _BBA1
        ldy #$3C00

        _BBA1
        tya
        sta wR5
        lda $7F82C7
        dec a
        asl a
        tax
        lda $7F832D,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStates
        bit #$4000
        bne _BBC4
        jsl rlGetSelectedUnitStatus
        cmp #$0005
        bne _BBCE

        _BBC4
        lda wR5
        and #$F1FF
        ora #$0E00
        sta wR5

        _BBCE
        ply
        plx
        stz wR0
        lda @l $8BBD40,x
        sec
        sbc $7F82DF
        sta wR1
        jsl rlPushToOAMBuffer

        _BBE1
        lda $7F82CD
        dec a
        asl a
        tax

        _BBE8
        phx
        lda $7F82C7
        dec a
        asl a
        sta wR0
        cpx wR0
        bne _BBF9
        jml _BC7D


        _BBF9
        lda $7F82EF
        dec a
        asl a
        sta wR0
        cpx wR0
        bne _BC10
        lda wVBlankEnabledFramecount
        and #$0001
        beq _BC10
        jml _BC7D


        _BC10
        phx
        lda $7F8391,x
        asl a
        tax
        lda $7E486B,x
        plx
        cmp #$FFFF
        beq _BC7D
        ldy #$2C00
        cpx #$0000
        bne _BC32
        lda $7F82DF
        bne _BC32
        ldy #$3C00

        _BC32
        tya
        sta wR5
        lda $7F832D,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStates
        bit #$4000
        bne _BC4E
        jsl rlGetSelectedUnitStatus
        cmp #$0005
        bne _BC58

        _BC4E
        lda wR5
        and #$F1FF
        ora #$0E00
        sta wR5

        _BC58
        plx
        phx
        lda $7F8391,x
        asl a
        tax
        lda $88D2B5,x
        plx
        sta wR4
        lda #$BD77
        tay
        stz wR0
        lda @l $8BBD40,x
        sec
        sbc $7F82DF
        sta wR1
        phx
        jsl rlPushToOAMBuffer

        _BC7D
        plx
        dec x
        dec x
        bmi _BC86
        jml _BBE8


        _BC86
        lda $7F82CD
        dec a
        asl a
        tax

        _BC8D
        lda $7F82C7
        dec a
        asl a
        sta wR0
        cpx wR0
        bne _BC9D
        jml _BD29


        _BC9D
        lda $7F82EF
        dec a
        asl a
        sta wR0
        cpx wR0
        bne _BCB4
        lda wVBlankEnabledFramecount
        and #$0001
        beq _BCB4
        jml _BD29


        _BCB4
        phx
        lda $7F8391,x
        asl a
        tax
        lda $7E480B,x
        plx
        cmp #$FFFF
        beq _BD29
        phy
        phx
        ldy #$2C00
        cpx #$0000
        bne _BCD8
        lda $7F82DF
        bne _BCD8
        ldy #$3C00

        _BCD8
        tya
        sta wR5
        plx
        lda $7F832D,x
        sta wSelectedUnitDataRAMPointer,b
        phx
        jsl rlGetSelectedUnitStates
        bit #$4000
        bne _BCF6
        jsl rlGetSelectedUnitStatus
        cmp #$0005
        bne _BD00

        _BCF6
        lda wR5
        and #$F1FF
        ora #$0E00
        sta wR5

        _BD00
        plx
        ply
        phx
        lda $7F8391,x
        asl a
        tax
        lda $88D1C5,x
        plx
        sta wR4
        lda #$BD70
        tay
        stz wR0
        lda @l $8BBD40,x
        sec
        sbc $7F82DF
        sta wR1
        phy
        phx
        jsl rlPushToOAMBuffer
        plx
        ply

        _BD29
        dec x
        dec x
        bmi _BD31
        jml _BC8D


        _BD31
        lda $7F82C7
        dec a
        asl a
        tax
        lda $7F832D,x
        sta wSelectedUnitDataRAMPointer,b
        rts

        .databank 0

        ; 8B/BD40

    .endsection Unsorted8BBAE9Section


    .section Unsorted8BBDA7Section

      .al
      .xl

      rsUnknown8BBDA7 ; 8B/BDA7

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F82E3
        bne _BDEF
        lda $7F82E7
        bne _BDEF
        ora $7F82ED
        bne _BDEF
        lda $7F82C7
        dec a
        asl a
        sta $7F83FF
        tax
        lda $7F832D,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStates
        bit #$4000
        bne _BDEF
        jsl rlGetSelectedUnitStatus
        cmp #$0005
        beq _BDEF
        lda $7F83FF
        lda $7F8391,x
        asl a
        sta $7F83FF
        tax
        jsl $88DF8C

        _BDEF
        rts

        .databank 0

        ; 8B/BDF0

    .endsection Unsorted8BBDA7Section


    .section Unsorted8BBE68Section

      .al
      .xl

      rlUnknown8BBE68 ; 8B/BE68

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        php
        tay
        txa
        asl a
        asl a
        asl a
        asl a
        sta wR0
        lda bBufferOBSEL
        and #$001F
        asl a
        tax
        lda aUnknown8BBFED+3,x
        clc
        adc wR0
        pha
        tya
        cmp #$FFFF
        bne _BE96
        lda aUnknown8BBFED+1
        sta lR18+1
        lda aUnknown8BBFED
        sta lR18
        bra _BEAC


        _BE96
        lda #$D800
        sta lR18+1
        lda #$4000
        sta lR18
        tya
        asl a
        tax
        lda aUnknown8BBED5,x
        clc
        adc lR18
        sta lR18

        _BEAC
        lda #$0040
        sta wR0
        pla
        sta wR1
        pha
        jsl rlDMAByPointer
        lda lR18
        clc
        adc #$0200
        sta lR18
        lda #$0040
        sta wR0
        pla
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        plp
        ply
        plx
        rtl

        .databank 0

        ; 8B/BED5

    .endsection Unsorted8BBE68Section


    .section Table8BBFEDSection

      .al
      .xl

      aUnknown8BBFED ; 8B/BFED

        ; Read by rlUnknown8BBE68.

        .byte $80, $06, $DE, $00, $00, $00, $20, $00, $40, $00, $60, $00, $00, $00, $20, $00
        .byte $40, $00, $60, $00, $08, $00, $28, $00, $48, $00, $68, $00, $08, $00, $28, $00
        .byte $48, $00, $68, $00, $10, $00, $30, $00, $50, $00, $70, $00, $10, $00, $30, $00
        .byte $50, $00, $70, $00, $18, $00, $38, $00, $58, $00, $78, $00, $18, $00, $38, $00
        .byte $58, $00, $78

        ; 8B/C030

    .endsection Table8BBFEDSection


    .section Unsorted8BC030Section

      .al
      .xl

      rlUnknown8BC030 ; 8B/C030

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        php
        cmp #$FFFF
        bne _C03B
        lda #$000A

        _C03B
        tay
        txa
        asl a
        asl a
        asl a
        asl a
        sta wR0
        lda bBufferOBSEL
        and #$001F
        asl a
        tax
        lda aUnknown8BC0B0,x
        clc
        adc wR0
        pha
        tya
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown8BC08F+1,x
        sta lR18+1
        lda aUnknown8BC08F,x
        sta lR18
        lda #$0040
        sta wR0
        pla
        sta wR1
        pha
        jsl rlDMAByPointer
        lda lR18
        clc
        adc #$0200
        sta lR18
        lda #$0040
        sta wR0
        pla
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        plp
        ply
        plx
        rtl

        .databank 0

        ; 8B/C08F

    .endsection Unsorted8BC030Section


    .section Table8BC08FSection

      .al
      .xl

      aUnknown8BC08F ; 8B/C08F

        ; Read by rlUnknown8BC030.

        .byte $00, $02, $DE, $40, $02, $DE, $80, $02, $DE, $C0, $02, $DE, $00, $03, $DE, $40
        .byte $03, $DE, $80, $03, $DE, $C0, $03, $DE, $00, $06, $DE, $40, $06, $DE, $80, $06
        .byte $DE

        ; 8B/C0B0

    .endsection Table8BC08FSection


    .section Unsorted8BC0F0Section

      .al
      .xl

      rsUnknown8BC0F0 ; 8B/C0F0

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8B
        lda wGameStateStep,b
        xba
        lsr a
        lsr a
        lsr a
        sta wR0
        lda $7F82EB
        asl a
        clc
        adc wR0
        tax
        lda @l $8BC15F,x
        sta wR0
        lda #$0011
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
        lda @l $8BC127,x
        tay
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8B/C127

    .endsection Unsorted8BC0F0Section


    .section Unsorted8BC21FSection

      .al
      .xl

      rsUnknown8BC21F ; 8B/C21F

        .al
        .xl
        .autsiz
        .databank ?

        jsl $8BB469
        lda $7F82E7
        cmp #$0002
        beq _C238
        cmp #$0003
        beq _C23C
        cmp #$0004
        beq _C240
        bra _C250


        _C238
        jml _C34B


        _C23C
        jml _C36B


        _C240
        jml _C37A


        _C244
        jml _C317


        _C248
        jml _C32B


        _C24C
        jml _C33F


        _C250
        lda wJoy1New
        bit #$0400
        bne _C244
        bit #$8000
        bne _C248
        bit #$00C0
        bne _C24C
        lda wJoy1Repeated
        bit #$0100
        bne _C271
        bit #$0200
        bne _C2B6
        jml _C2EE


        _C271
        lda $7F82EB
        inc a
        sta $7F82EB
        lda wGameStateStep,b
        asl a
        tax
        lda $8BC385,x
        cmp $7F82EB
        bcs _C2E7
        sta $7F82EB
        lda wGameStateStep,b
        inc a
        cmp #$0006
        beq _C2EE
        sta wGameStateStep,b
        lda #$0000
        sta $7F82EB
        jsl $8BADF1
        lda wGameStateStep,b
        cmp #$0005
        bne _C2B4
        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20

        _C2B4
        bra _C2E7


        _C2B6
        lda $7F82EB
        dec a
        sta $7F82EB
        bpl _C2E7
        sep #$20
        lda #$15
        sta bBufferTM
        rep #$20
        lda #$0000
        sta $7F82EB
        lda wGameStateStep,b
        dec a
        bmi _C2EE
        sta wGameStateStep,b
        asl a
        tax
        lda $8BC385,x
        sta $7F82EB
        jsl $8BADF1

        _C2E7
        lda #$0007
        jsl rlUnknown808FAD

        _C2EE
        lda #$0001
        sta wR0
        lda #$000A
        sta wR1
        lda #$0000
        jsl rlUnknown88A704
        jsr $8BC0F0

        _C302
        lda wGameStateStep,b
        dec a
        bne _C30B
        jsr $8BB7D3

        _C30B
        lda wGameStateStep,b
        cmp #$0004
        bne _C316
        jsr $8BB871

        _C316
        rts


        _C317
        lda #$0006
        jsl rlUnknown808FAD
        lda #$0000
        sta $7F82E7
        sta $7F82EB
        bra _C302


        _C32B
        lda #$0021
        jsl rlUnknown808FAD
        lda #$0000
        sta $7F82E7
        sta $7F82EB
        bra _C302


        _C33F
        lda #$000A
        jsl rlUnknown808FAD
        jsr rsUnknown8BC49F
        bra _C2EE


        _C34B
        ldx #$01C8
        lda #$0030
        ldy #$0005
        jsl rlClearTilemapRect
        jsl $80CBA5
        jsl $8BADF1
        lda #$0003
        sta $7F82E7
        jml _C2EE


        _C36B
        jsl $80CC35
        lda #$0001
        sta $7F82E7
        jml _C2EE


        _C37A
        lda #$0001
        sta $7F82E7
        jml _C2EE

        .databank 0

        ; 8B/C385

    .endsection Unsorted8BC21FSection


    .section Unsorted8BC391Section

      .al
      .xl

      rsUnknown8BC391 ; 8B/C391

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F82ED
        cmp #$0002
        beq _C3A3
        cmp #$0003
        beq _C3A7
        jml _C3AB


        _C3A3
        jml _C40B


        _C3A7
        jml _C42B


        _C3AB
        lda wJoy1New
        bit #$8000
        bne _C3F1
        bit #$4080
        bne _C3B8

        _C3B7
        rts


        _C3B8
        lda $7F82C7
        cmp $7F82EF
        beq _C3F1
        lda #$000A
        jsl rlUnknown808FAD
        lda $7F82C7
        dec a
        tax
        lda $7F82EF
        dec a
        jsr $8BC9B6
        jsl rlUnknown8BCD89
        lda #$0000
        sta wUnknown7E5319
        sta wUnknown7E5317
        lda #$0002
        sta $7F82ED
        jml _C3B7


        _C3F1
        lda #$0021
        jsl rlUnknown808FAD

        _C3F8
        lda #$0000
        sta $7F82ED
        sta $7F82F1
        sta $7F82EF
        jml _C3B7


        _C40B
        ldx #$01C8
        lda #$0030
        ldy #$0005
        jsl rlClearTilemapRect
        jsl $80CBA5
        jsl $8BADF1
        lda #$0003
        sta $7F82ED
        jml _C3B7


        _C42B
        jsl $80CC35
        lda #$0000
        sta $7F82ED
        jml _C3F8

        .databank 0

        ; 8B/C43A

    .endsection Unsorted8BC391Section


    .section Unsorted8BC43ASection

      .al
      .xl

      rlUnknown8BC43A ; 8B/C43A

        .al
        .xl
        .autsiz
        .databank ?

        asl a
        tax
        lda aUnknown8BC457,x
        tay
        ldx #$001E

        _C444
        lda aUnknownDD7FB0,x
        dec x
        dec x
        phx
        tyx
        sta @l aBGPaletteBuffer,x
        dec x
        dec x
        txy
        plx
        bpl _C444
        rtl

        .databank 0

        ; 8B/C457

    .endsection Unsorted8BC43ASection


    .section Table8BC457Section

      .al
      .xl

      aUnknown8BC457 ; 8B/C457

        ; Read by rlUnknown8BC43A, rlUnknown8BC467.

        .word $011E, $013E, $015E, $017E, $019E, $01BE, $01DE, $01FE

        ; 8B/C467

    .endsection Table8BC457Section


    .section Unsorted8BC467Section

      .al
      .xl

      rlUnknown8BC467 ; 8B/C467

        .al
        .xl
        .autsiz
        .databank ?

        asl a
        tax
        lda aUnknown8BC457,x
        tay
        ldx #$001E

        _C471
        lda $DD7FD0,x
        dec x
        dec x
        phx
        tyx
        sta @l aBGPaletteBuffer,x
        dec x
        dec x
        txy
        plx
        bpl _C471
        rtl

        .databank 0

        ; 8B/C484

    .endsection Unsorted8BC467Section


    .section Unsorted8BC484Section

      .al
      .xl

      rlUnknown8BC484 ; 8B/C484

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlGetFirstEquippableWeaponInInventory
        tax
        lda wCurrentItemDataROMPointer,b
        beq _C499
        txa
        jsl rlGetItemIDByInventorySlot
        bcs _C499
        clc
        plx
        rtl


        _C499
        lda #$FFFF
        sec
        plx
        rtl

        .databank 0

        ; 8B/C49F

      rsUnknown8BC49F ; 8B/C49F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wGameStateStep,b
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown8BC518+1,x
        sta lR18+1
        lda aUnknown8BC518,x
        sta lR18
        lda $7F82EB
        tay
        lda [lR18],y
        and #$00FF
        sta wUnknown7E5319
        ldx #$0000
        lda wJoy1New
        bit #$0040
        beq _C4CE
        inc x

        _C4CE
        txa
        sta wUnknown7E5317
        jsl rlUnknown8BCA1A
        lda wUnknown7E5317
        bne _C4E3
        jsl rlUnknown8BC52A
        bra _C4E7


        _C4E3
        jsl rlUnknown8BC56F

        _C4E7
        jsl rlUnknown8BCD89
        lda #$0002
        sta $7F82E7
        rts

        .databank 0

        ; 8B/C4F3

    .endsection Unsorted8BC484Section


    .section Table8BC518Section

      .al
      .xl

      aUnknown8BC518 ; 8B/C518

        ; Read by rsUnknown8BC49F.

        .word $C4F3, $F98B, $8BC4, $C4FE, $068B, $8BC5, $C50B, $168B
        .word $8BC5

        ; 8B/C52A

    .endsection Table8BC518Section


    .section Unsorted8BC52ASection

      .al
      .xl

      rlUnknown8BC52A ; 8B/C52A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F82CD
        cmp #$0001
        beq _C56C
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
        ldy #$0000

        _C548
        tyx
        inc x
        inc x

        _C54B
        lda $8407,b,y
        cmp @l $7F8407,x
        bcs _C560
        phx
        phy
        txa
        lsr a
        tax
        tya
        lsr a
        jsr rsUnknown8BCD20
        ply
        plx

        _C560
        inc x
        inc x
        cpx wR15
        bne _C54B
        inc y
        inc y
        cpy wR14
        bne _C548

        _C56C
        phk
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/C56F

      rlUnknown8BC56F ; 8B/C56F

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F82CD
        cmp #$0001
        beq _C5C3
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
        ldy #$0000

        _C58D
        tyx
        inc x
        inc x

        _C590
        lda $8407,b,y
        inc a
        eor #$FFFF
        inc a
        sta wR12
        lda @l $7F8407,x
        inc a
        eor #$FFFF
        inc a
        sta wR11
        lda wR12
        cmp wR11
        bcs _C5B7
        phx
        phy
        txa
        lsr a
        tax
        tya
        lsr a
        jsr rsUnknown8BCD20
        ply
        plx

        _C5B7
        inc x
        inc x
        cpx wR15
        bne _C590
        inc y
        inc y
        cpy wR14
        bne _C58D

        _C5C3
        phk
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/C5C6

    .endsection Unsorted8BC52ASection


    .section Unsorted8BC5C6Section

      .al
      .xl

      rlUnknown8BC5C6 ; 8B/C5C6

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aBG3TilemapBuffer
        sta $7E838A
        sta $7E838C
        sta $7E838E
        sta $7E8390
        sta $7E83C8
        sta $7E83CA
        sta $7E83CC
        sta $7E83CE
        sta $7E83D0
        lda wUnknown7E5319
        cmp #$0026
        bmi _C5FC

        _C5FA
        bra _C5FA


        _C5FC
        asl a
        tax
        jsr ($8BC61C,x)
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $000A, $80, $B044

        jsl rlDMAByStruct

          .structDMAToVRAM $7E83C8, $000C, $80, $B084

        rtl

        .databank 0

        ; 8B/C61C

    .endsection Unsorted8BC5C6Section


    .section Unsorted8BC9B6Section

      .al
      .xl

      rsUnknown8BC9B6 ; 8B/C9B6

        .al
        .xl
        .autsiz
        .databank ?

        asl a
        tay
        txa
        asl a
        tax
        sta wR1
        lda $7F832D,x
        sta wR0
        tyx
        lda $7F832D,x
        ldx wR1
        sta $7F832D,x
        lda wR0
        tyx
        sta $7F832D,x
        ldx wR1
        lda $7F8391,x
        sta wR0
        tyx
        lda $7F8391,x
        ldx wR1
        sta $7F8391,x
        lda wR0
        tyx
        sta $7F8391,x
        lda #$0001
        sta wR0
        stz wR2

        _C9F6
        lda wR2
        asl a
        tax
        lda $7F832D,x
        beq _CA19
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitGenerationID
        dec a
        tax
        sep #$20
        lda wR0
        sta $7E531B,x
        rep #$20
        inc wR0
        inc wR2
        bra _C9F6


        _CA19
        rts

        .databank 0

        ; 8B/CA1A

    .endsection Unsorted8BC9B6Section


    .section Unsorted8BCA1ASection

      .al
      .xl

      rlUnknown8BCA1A ; 8B/CA1A

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown7E5319
        bmi _CA30
        lda wUnknown7E5319
        cmp #$0027
        bmi _CA2B

        _CA29
        bra _CA29


        _CA2B
        asl a
        tax
        jsr ($8BCA31,x)

        _CA30
        rtl

        .databank 0

        ; 8B/CA31

    .endsection Unsorted8BCA1ASection


    .section Unsorted8BCD20Section

      .al
      .xl

      rsUnknown8BCD20 ; 8B/CD20

        .al
        .xl
        .autsiz
        .databank ?

        sta wR0
        cpx wR0
        bpl _CD29
        tay
        txa
        tyx

        _CD29
        sta wR3
        stx wR4
        asl a
        sta wR1
        txa
        asl a
        sta wR2
        ldx wR2
        lda $7F832D,x
        sta wR0

        _CD3C
        lda $7F832B,x
        sta $7F832D,x
        dec x
        dec x
        cpx wR1
        bne _CD3C
        lda wR0
        sta $7F832D,x
        ldx wR2
        lda $7F8391,x
        sta wR0

        _CD58
        lda $7F838F,x
        sta $7F8391,x
        dec x
        dec x
        cpx wR1
        bne _CD58
        lda wR0
        sta $7F8391,x
        ldx wR2
        lda $7F8407,x
        sta wR0

        _CD74
        lda $7F8405,x
        sta $7F8407,x
        dec x
        dec x
        cpx wR1
        bne _CD74
        lda wR0
        sta $7F8407,x
        rts

        .databank 0

        ; 8B/CD89

    .endsection Unsorted8BCD20Section


    .section Unsorted8BCD89Section

      .al
      .xl

      rlUnknown8BCD89 ; 8B/CD89

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000

        _CD8C
        lda $7F832D,x
        beq _CDB4
        sta wSelectedUnitDataRAMPointer,b
        ldy #$0000
        jsl rlGetPromotedClassIfAvailable
        lda $7E2000
        cmp #$0001
        bne _CDA8
        ldy #$0001

        _CDA8
        tya
        sta $7F83C3,x
        inc x
        inc x
        cpx #$0030
        bne _CD8C

        _CDB4
        lda #$0000
        sta wR15

        _CDB9
        ldx wR15
        lda $7F832D,x
        beq _CDD7
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetFirstEquippableWeaponInInventory
        ldx wR15
        lda wCurrentItemDataROMPointer,b
        sta $7F835F,x
        inc wR15
        inc wR15
        bra _CDB9


        _CDD7
        rtl

        .databank 0

        ; 8B/CDD8

    .endsection Unsorted8BCD89Section


    .section Unsorted8BCE29Section

      .al
      .xl

      rlUnknown8BCE29 ; 8B/CE29

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        sta wR1
        sep #$20
        lda #$00
        ldx #$0017

        _CE35
        sta $7E5336,x
        dec x
        bne _CE35
        rep #$20
        lda #$0001

        _CE41
        sta wR0
        dec a
        asl a
        tax
        lda $7F832D,x
        beq _CE6B
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitGenerationID
        dec a
        tax
        lda wR0
        eor #$FFFF
        inc a
        sep #$20
        sta $7E5336,x
        rep #$20
        lda wR0
        inc a
        cmp #$0019
        bne _CE41

        _CE6B
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        rtl

        .databank 0

        ; 8B/CE71

    .endsection Unsorted8BCE29Section


    .section Unsorted8BCE71Section

      .al
      .xl

      rlUnknown8BCE71 ; 8B/CE71

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8B
        lda #$0000
        sta wUnknown7E5315
        sta wUnknown7E5319
        sta wUnknown7E5317
        sta $7E5333
        sep #$20
        lda #$00
        ldx #$0017

        _CE8F
        sta $7E531B,x
        dec x
        bpl _CE8F
        lda #$00
        ldx #$0017

        _CE9B
        sta $7E5336,x
        dec x
        bne _CE9B
        lda #$00
        sta $7E5335
        rep #$20
        plp
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/CEAD

      rlUnknown8BCEAD ; 8B/CEAD

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8B
        sep #$20
        lda #$00
        sta $7E5335
        lda #$00
        ldx #$0017

        _CEBE
        sta $7E5336,x
        dec x
        bne _CEBE
        rep #$20
        plp
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/CECA

    .endsection Unsorted8BCE71Section


    .section Unsorted8BCF0ASection

      .al
      .xl

      rlUnknown8BCF0A ; 8B/CF0A

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlEnableActiveSpriteEngine
        inc wGameStateRoutine1,b
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 8B/CF20

      rlUnknown8BCF20 ; 8B/CF20

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8B
        lda wGameStateStep,b
        asl a
        tax
        jsr ($8BCF2F,x)
        plp
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/CF2F

    .endsection Unsorted8BCF0ASection


    .section Unsorted8BD13DSection

      .al
      .xl

      rlUnknown8BD13D ; 8B/D13D

        .al
        .xl
        .autsiz
        .databank ?

        jsr $8BD4D4
        jsr $8BD600
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0740, $80, $5000

        rtl

        .databank 0

        ; 8B/D151

    .endsection Unsorted8BD13DSection


    .section Unsorted8BD4D4Section

      .al
      .xl

      rsUnknown8BD4D4 ; 8B/D4D4

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8B
        lda #$0000
        sta $7F83DF
        lda #$0069
        sta $7F83DD

        _D4E4
        lda $7F83DD
        sta wR1
        lda $7F83DF
        asl a
        sta wR4
        stz wR0
        stz wR5
        ldy #$D518
        jsl rlPushToOAMBuffer
        lda $7F83DD
        clc
        adc #$0010
        sta $7F83DD
        lda $7F83DF
        inc a
        sta $7F83DF
        cmp $7F83D9
        bne _D4E4
        rts

        .databank 0

        ; 8B/D518

    .endsection Unsorted8BD4D4Section


    .section Unsorted8BD600Section

      .al
      .xl

      rsUnknown8BD600 ; 8B/D600

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        sta wR0
        lda $7F8185
        sta wR1
        lda #$0000
        jsl rlUnknown88A704
        rts

        .databank 0

        ; 8B/D613

    .endsection Unsorted8BD600Section


    .section Unsorted8BD794Section

      .al
      .xl

      rlUnknown8BD794 ; 8B/D794

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlEnableActiveSpriteEngine
        inc wGameStateRoutine1,b
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 8B/D7AA

      rlUnknown8BD7AA ; 8B/D7AA

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8B
        lda wGameStateStep,b
        asl a
        tax
        jsr ($8BD7B9,x)
        plp
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/D7B9

    .endsection Unsorted8BD794Section


    .section Unsorted8BD8FESection

      .al
      .xl

      rlUnknown8BD8FE ; 8B/D8FE

        .al
        .xl
        .autsiz
        .databank ?

        jsr $8BDAB4
        jsr $8BDB54
        jsr $8BDBA2
        jsr $8BDBB2
        rtl

        .databank 0

        ; 8B/D90B

    .endsection Unsorted8BD8FESection


    .section Unsorted8BDAB4Section

      .al
      .xl

      rsUnknown8BDAB4 ; 8B/DAB4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0019
        sec
        sbc wBufferBG2VOFS
        sta wR1
        stz wR0
        stz wR4
        stz wR5
        ldy #$DAF4
        jsl rlPushToOAMBuffer
        lda #$0089
        sec
        sbc wBufferBG2VOFS
        sta wR1
        stz wR0
        stz wR4
        stz wR5
        ldy #$DB19
        jsl rlPushToOAMBuffer
        lda #$0109
        sec
        sbc wBufferBG2VOFS
        sta wR1
        stz wR0
        stz wR4
        stz wR5
        ldy #$DB43
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8B/DAF4

    .endsection Unsorted8BDAB4Section


    .section Unsorted8BDB54Section

      .al
      .xl

      rsUnknown8BDB54 ; 8B/DB54

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8185
        asl a
        tax
        lda $8BDB7E,x
        sta wR4
        stz wR0
        stz wR1
        stz wR5
        ldy #$DB77
        jsl rlPushToOAMBuffer
        sep #$20
        lda #$E0
        sta aBGPaletteBuffer,b
        rep #$20
        rts

        .databank 0

        ; 8B/DB77

    .endsection Unsorted8BDB54Section


    .section Unsorted8BDBA2Section

      .al
      .xl

      rsUnknown8BDBA2 ; 8B/DBA2

        .al
        .xl
        .autsiz
        .databank ?

        stz wR0
        lda $7F8189
        sta wR1
        lda #$0000
        jsl rlUnknown88A704
        rts

        .databank 0

        ; 8B/DBB2

      rsUnknown8BDBB2 ; 8B/DBB2

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0018
        beq _DBF0
        lda $7F8185
        asl a
        tax
        lda $7F8741,x
        cmp #$000D
        bcc _DBF0
        lda $7F873B
        bne _DBF0
        stz wR0
        stz wR4
        stz wR5
        lda #$0040
        sta wR1
        lda $7F873D
        bne _DBE9
        lda #$0066
        sta wR0
        lda #$4000
        sta wR5

        _DBE9
        ldy #$DC42
        jsl rlPushToOAMBuffer

        _DBF0
        lda wVBlankEnabledFramecount
        and #$0008
        beq _DC21
        stz wR0
        stz wR4
        stz wR5
        lda #$0080
        sta wR1
        ldy #$0000
        lda $7F818D
        cmp #$000C
        beq _DC17
        inc y
        inc y
        cmp #$0000
        bne _DC17
        inc y
        inc y

        _DC17
        phk
        plb
        .databank $8B
        lda $DC22,b,y
        tay
        jsl rlPushToOAMBuffer

        _DC21
        rts

        .databank 0

        ; 8B/DC22

    .endsection Unsorted8BDBA2Section


    .section Table8CDE00Section

      .al
      .xl

      aUnknown8CDE00 ; 8C/DE00

        ; Read by rsUnknown8B8114.

        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F

        ; 8C/DE20

    .endsection Table8CDE00Section


    .section TableDD7FB0Section

      .al
      .xl

      aUnknownDD7FB0 ; DD/7FB0

        ; Read by rlUnknown8BC43A.

        .word $3800, $7BFF, $56D7, $35EF, $0462, $02FB, $000B, $5C40
        .word $6D25, $7E0F, $0140, $1EC5, $10EA, $298F, $0487, $0134
        .word $3800, $0012, $013A, $02FB, $7E6A, $7504, $0120, $0280
        .word $7FFF, $56D7, $35EF, $08A6, $190A, $256C, $4232, $0842
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

        ; DD/8000

    .endsection TableDD7FB0Section
