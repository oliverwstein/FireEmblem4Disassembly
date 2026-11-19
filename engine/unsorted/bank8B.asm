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


    .section Unsorted8B9451Section

      .al
      .xl

      rlUnknown8B9451 ; 8B/9451

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8B9458
        rtl

        .databank 0

        ; 8B/9456

    .endsection Unsorted8B9451Section


    .section Unsorted8B9458Section

      .al
      .xl

      rlUnknown8B9458 ; 8B/9458

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferINIDISP
        bpl _9462
        jml _9591


        _9462
        lda $4212,b
        bit #$40
        beq _9462
        lda #$00
        sta $2100,b
        lda #$80
        sta $2100,b
        lda #$54
        sta $2108,b
        lda wBufferBG2HOFS
        sta $210F,b
        lda wBufferBG2HOFS+1
        sta $210F,b
        lda wBufferBG2VOFS
        sec
        sbc #$01
        sta $2110,b
        lda wBufferBG2VOFS+1
        sbc #$00
        sta $2110,b

        _9491
        lda $4212,b
        bit #$40
        bne _9491

        _9498
        lda $4212,b
        bit #$40
        beq _9498
        lda #$02
        cmp @l bBufferINIDISP
        bcc _94AB
        lda @l bBufferINIDISP

        _94AB
        sta $2100,b

        _94AE
        lda $4212,b
        bit #$40
        bne _94AE

        _94B5
        lda $4212,b
        bit #$40
        beq _94B5
        lda #$04
        cmp @l bBufferINIDISP
        bcc _94C8
        lda @l bBufferINIDISP

        _94C8
        sta $2100,b

        _94CB
        lda $4212,b
        bit #$40
        bne _94CB

        _94D2
        lda $4212,b
        bit #$40
        beq _94D2
        lda #$06
        cmp @l bBufferINIDISP
        bcc _94E5
        lda @l bBufferINIDISP

        _94E5
        sta $2100,b

        _94E8
        lda $4212,b
        bit #$40
        bne _94E8

        _94EF
        lda $4212,b
        bit #$40
        beq _94EF
        lda #$08
        cmp @l bBufferINIDISP
        bcc _9502
        lda @l bBufferINIDISP

        _9502
        sta $2100,b

        _9505
        lda $4212,b
        bit #$40
        bne _9505

        _950C
        lda $4212,b
        bit #$40
        beq _950C
        lda #$0A
        cmp @l bBufferINIDISP
        bcc _951F
        lda @l bBufferINIDISP

        _951F
        sta $2100,b

        _9522
        lda $4212,b
        bit #$40
        bne _9522

        _9529
        lda $4212,b
        bit #$40
        beq _9529
        lda #$0C
        cmp @l bBufferINIDISP
        bcc _953C
        lda @l bBufferINIDISP

        _953C
        sta $2100,b

        _953F
        lda $4212,b
        bit #$40
        bne _953F

        _9546
        lda $4212,b
        bit #$40
        beq _9546
        lda #$0E
        cmp @l bBufferINIDISP
        bcc _9559
        lda @l bBufferINIDISP

        _9559
        sta $2100,b

        _955C
        lda $4212,b
        bit #$40
        bne _955C

        _9563
        lda $4212,b
        bit #$40
        beq _9563
        lda #$0F
        cmp @l bBufferINIDISP
        bcc _9576
        lda @l bBufferINIDISP

        _9576
        sta $2100,b

        _9579
        lda $4212,b
        bit #$40
        beq _9579
        lda bBufferINIDISP
        lda #$0F
        cmp @l bBufferINIDISP
        bcc _958E
        lda @l bBufferINIDISP

        _958E
        sta $2100,b

        _9591
        rep #$20
        rtl

        .databank 0

        ; 8B/9594

    .endsection Unsorted8B9458Section


    .section Unsorted8B959CSection

      .al
      .xl

      rlUnknown8B959C ; 8B/959C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8B95A3
        rtl

        .databank 0

        ; 8B/95A1

    .endsection Unsorted8B959CSection


    .section Unsorted8B95A3Section

      .al
      .xl

      rlUnknown8B95A3 ; 8B/95A3

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferINIDISP
        bpl _95AD
        jml _96CC


        _95AD
        lda $4212,b
        bit #$40
        beq _95AD
        lda #$0F
        lda @l bBufferINIDISP
        sta $2100,b

        _95BD
        lda $4212,b
        bit #$40
        bne _95BD

        _95C4
        lda $4212,b
        bit #$40
        beq _95C4
        lda #$0E
        cmp @l bBufferINIDISP
        bcc _95D7
        lda @l bBufferINIDISP

        _95D7
        sta $2100,b

        _95DA
        lda $4212,b
        bit #$40
        bne _95DA

        _95E1
        lda $4212,b
        bit #$40
        beq _95E1
        lda #$0C
        cmp @l bBufferINIDISP
        bcc _95F4
        lda @l bBufferINIDISP

        _95F4
        sta $2100,b

        _95F7
        lda $4212,b
        bit #$40
        bne _95F7

        _95FE
        lda $4212,b
        bit #$40
        beq _95FE
        lda #$0A
        cmp @l bBufferINIDISP
        bcc _9611
        lda @l bBufferINIDISP

        _9611
        sta $2100,b

        _9614
        lda $4212,b
        bit #$40
        bne _9614

        _961B
        lda $4212,b
        bit #$40
        beq _961B
        lda #$08
        cmp @l bBufferINIDISP
        bcc _962E
        lda @l bBufferINIDISP

        _962E
        sta $2100,b

        _9631
        lda $4212,b
        bit #$40
        bne _9631

        _9638
        lda $4212,b
        bit #$40
        beq _9638
        lda #$06
        cmp @l bBufferINIDISP
        bcc _964B
        lda @l bBufferINIDISP

        _964B
        sta $2100,b

        _964E
        lda $4212,b
        bit #$40
        bne _964E

        _9655
        lda $4212,b
        bit #$40
        beq _9655
        lda #$04
        cmp @l bBufferINIDISP
        bcc _9668
        lda @l bBufferINIDISP

        _9668
        sta $2100,b

        _966B
        lda $4212,b
        bit #$40
        bne _966B

        _9672
        lda $4212,b
        bit #$40
        beq _9672
        lda #$02
        cmp @l bBufferINIDISP
        bcc _9685
        lda @l bBufferINIDISP

        _9685
        sta $2100,b

        _9688
        lda $4212,b
        bit #$40
        bne _9688

        _968F
        lda $4212,b
        bit #$40
        beq _968F
        lda #$80
        sta $2100,b
        lda #$4C
        sta $2108,b
        lda #$00
        sta $210F,b
        lda #$00
        sta $210F,b
        lda #$FF
        sta $2110,b
        lda #$FF
        sta $2110,b

        _96B4
        lda $4212,b
        bit #$40
        beq _96B4
        lda bBufferINIDISP
        lda #$0F
        cmp @l bBufferINIDISP
        bcc _96C9
        lda @l bBufferINIDISP

        _96C9
        sta $2100,b

        _96CC
        rep #$20
        rtl

        .databank 0

        ; 8B/96CF

    .endsection Unsorted8B95A3Section


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


    .section Unsorted8B972CSection

      .al
      .xl

      rsUnknown8B972C ; 8B/972C

        .al
        .xl
        .autsiz
        .databank ?

        jsl rsUnknown8B8000
        lda wCurrentChapter,b
        cmp #$FFFF
        bne _973B
        inc $0AD3,b

        _973B
        rts

        .databank 0

        ; 8B/973C

    .endsection Unsorted8B972CSection


    .section Unsorted8B9759Section

      .al
      .xl

      rsUnknown8B9759 ; 8B/9759

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0007
        bne _976C
        sep #$20
        lda bBufferINIDISP
        and #$0F
        cmp #$0F
        beq _9773
        inc bBufferINIDISP

        _976C
        rep #$20
        jsl rsUnknown8B8000
        rts


        _9773
        .as
        rep #$20
        lda $0594,b
        sta wGameStateStep,b
        bra _976C

        .databank 0

        ; 8B/977D

    .endsection Unsorted8B9759Section


    .section Unsorted8BA0B4Section

      .al
      .xl

      rlUnknown8BA0B4 ; 8B/A0B4

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 8B/A0B5

    .endsection Unsorted8BA0B4Section


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
        jsr rsUnitWindowCopyLineHighlightColors
        lda wGameStateStep,b
        cmp #$0004
        bne _A80C
        jsr rsUnitWindowRenderWeaponRankIcons
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
        jsr rsUnitWindowCopyLineHighlightColors

        _A85A
        lda $7F82E7
        bne _A86B
        jsl rlUnitWindowRenderUnitSwapCursors
        jsl rlUnitWindowRenderPageSprites
        jsr rsUnitWindowRenderSprites

        _A86B
        lda $7F82E7
        bne _A886
        lda wGameStateStep,b
        cmp #$0004
        bne _A87E
        jsr rsUnitWindowRenderWeaponRankIcons
        bra _A886


        _A87E
        cmp #$0001
        bne _A886
        jsr rsUnitWindowRenderItemIcons

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
        jml rlUnknown8BAC53


        _A8DA
        jml rlUnknown8BAC31


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
        jml rlUnknown8BAC67


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
        jml rlUnknown8BAC20


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
        jml rlUnknown8BABE5


        _A96F
        jml rlUnknown8BABED


        _A973
        jml rlUnknown8BABE9


        _A977
        jml rlUnknown8BABF1


        _A97B
        jml rlUnknown8BABF5


        _A97F
        jml rlUnknown8BABFC


        _A983
        lda #$0021
        jsl rlUnknown808FAD
        jsl rlUnitWindowSaveListOrder
        lda wGameStateStep,b
        sta wUnitWindowPage
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
        jsl rlUnitWindowSaveListOrder
        lda wGameStateStep,b
        sta wUnitWindowPage
        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        beq _A9F9
        jsl rlGetSelectedUnitDeploymentOffset
        cmp #$0000
        bmi _A9E9
        sta @l wActiveUnitDeploymentOffset
        jsl rlUnknown8881D7

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
        jsl rlUnitWindowSaveListOrder
        lda wGameStateStep,b
        sta wUnitWindowPage
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

        jsr rsUnitWindowMoveToFirstUnit
        rtl

        .databank 0

        ; 8B/ABE9

      rlUnknown8BABE9 ; 8B/ABE9

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnitWindowMoveToPreviousPage
        rtl

        .databank 0

        ; 8B/ABED

      rlUnknown8BABED ; 8B/ABED

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnitWindowMoveToLastUnit
        rtl

        .databank 0

        ; 8B/ABF1

      rlUnknown8BABF1 ; 8B/ABF1

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnitWindowMoveToNextPage
        rtl

        .databank 0

        ; 8B/ABF5

      rlUnknown8BABF5 ; 8B/ABF5

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnitWindowHandleSortSelection
        jsr rsUnitWindowRenderSprites
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

        jsr rsUnitWindowHandleUnitSwap
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

        jsl rlUnknown88DE0B
        lda #$0000
        sta $7F82C5
        sta $7F8183
        lda #$0001
        sta $0D77,b
        lda #<>rsUnknown80B122
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

        jsl rlUnknown88DE0B
        lda #$0000
        sta $7F82C5
        sta $7F8183
        jsl rlUnknown80BB5D
        rtl

        .databank 0

        ; 8B/AC67

      rlUnknown8BAC67 ; 8B/AC67

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown88DE0B
        lda #$0000
        sta $7F82C5
        lda #$C3E6
        sta $7F8183
        lda #<>rsUnknown80BBD9
        sta wMainLoopPointer
        rtl

        .databank 0

        ; 8B/AC7F

    .endsection Unsorted8BA851Section


    .section Unsorted8BAC7FSection

      .al
      .xl

      rsUnknown8BAC7F ; 8B/AC7F

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        bit #$0C00
        bne _AC92
        lda wJoy1Repeated
        bit #$0100
        bne _AC93
        bit #$0200
        bne _ACAC

        _AC92
        rts


        _AC93
        inc wGameStateStep,b
        jsl rlUnknown8BADF1
        lda #$FFFF
        sta $7F82E3
        jsr rsUnitWindowRenderItemIcons
        lda #$0007
        jsl rlUnknown808FAD
        rts


        _ACAC
        rts

        .databank 0

        ; 8B/ACAD

    .endsection Unsorted8BAC7FSection


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
        jsl rlUnitWindowDrawSortLabel
        rtl

        .databank 0

        ; 8B/AE12

    .endsection Unsorted8BADF1Section


    .section Unsorted8BAE1ESection

      .al
      .xl

      rsUnknown8BAE1E ; 8B/AE1E

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0007
        sta wR14
        stz wR15

        _AE25
        lda wR15
        asl a
        tax
        lda $7F832D,x
        bne _AE33
        jml _AF20


        _AE33
        sta wSelectedUnitDataRAMPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetSelectedUnitClassNamePointer
        lda wR14
        and #$00FF
        xba
        ora #$000A
        tax
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitLevel
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0026
        tax
        lda #$3920
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitExperience
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$002C
        tax
        lda #$3520
        sta wR5
        lda #$0002
        sta wR6
        tya
        pha
        jsl rlDrawMenuTextNumber
        pla
        cmp #$005A
        bmi _AEB6
        lda wR14
        xba
        lsr a
        lsr a
        sta wR0
        lda #$0030
        clc
        adc wR0
        tax
        lda #$3508
        sta $7E83C8,x

        _AEB6
        jsl rlGetSelectedUnitCurrentHP
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0032
        tax
        lda #$3920
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #$8B00
        sta lR18+1
        lda #$AF3B
        sta lR18
        lda wR14
        and #$00FF
        xba
        ora #$001B
        tax
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitMaxHP
        tay
        lda wR14
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0038
        tax
        lda #$3520
        sta wR5
        lda #$0002
        sta wR6
        tya
        jsl rlDrawMenuTextNumber
        inc wR14
        inc wR14
        inc wR15
        jml _AE25


        _AF20
        jsl rlDMAByStruct

          .structDMAToVRAM $DE60C0, $0140, $80, $B040

        jsl rlDMAByStruct

          .structDMAToVRAM $7E8548, $0C00, $80, $B1C0

        rts

        .databank 0

        ; 8B/AF3B

    .endsection Unsorted8BAE1ESection


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


    .section Unsorted8BCF35Section

      .al
      .xl

      rsUnknown8BCF35 ; 8B/CF35

        .al
        .xl
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _CF61
        lda wJoy1New
        bit #$8000
        bne _CF6E
        lda $7F8187
        bmi _CF62
        bne _CF66
        lda wJoy1New
        bit #$0040
        bne _CFA9
        lda wJoy1Repeated
        bit #$0800
        bne _CFD1
        bit #$0400
        bne _CF6A

        _CF61
        rts


        _CF62
        jml _D018


        _CF66
        jml _D035


        _CF6A
        jml _CFF2


        _CF6E
        lda #$0021
        jsl rlUnknown808FAD
        lda wUnknown000D79,b
        bit #$0020
        bne _CF9E
        lda #$0000
        sta $0D77,b
        lda #$B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        lda #$0002
        sta wGameStateStep,b
        rts


        _CF9E
        jsl rlUnknown80BB7C
        lda #$0002
        sta wGameStateStep,b
        rts


        _CFA9
        lda #$0001
        sta wGameStateStep,b
        lda #$0008
        jsl rlUnknown808FAD
        jsr rsUnknown8BD73B
        jsr rsUnknown8BD4C6
        jsl rlUnknown8BD2D7
        jsr rsUnknown8BD51F
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $04C0, $80, $3240

        rts


        _CFD1
        lda $7F8183
        beq _CFF1
        lda #$0006
        jsl rlUnknown808FAD
        lda #$FFFF
        sta $7F8187
        lda $7F8185
        sec
        sbc #$0008
        sta $7F8185

        _CFF1
        rts


        _CFF2
        lda $7F8183
        inc a
        cmp $7F83D9
        beq _D017
        lda #$0006
        jsl rlUnknown808FAD
        lda #$0001
        sta $7F8187
        lda $7F8185
        clc
        adc #$0008
        sta $7F8185

        _D017
        rts


        _D018
        lda $7F8183
        dec a
        sta $7F8183
        lda #$0000
        sta $7F8187
        lda $7F8185
        sec
        sbc #$0008
        sta $7F8185
        rts


        _D035
        lda $7F8183
        inc a
        sta $7F8183
        lda #$0000
        sta $7F8187
        lda $7F8185
        clc
        adc #$0008
        sta $7F8185
        rts

        .databank 0

        ; 8B/D052

    .endsection Unsorted8BCF35Section


    .section Unsorted8BD13CSection

      .al
      .xl

      rsUnknown8BD13C ; 8B/D13C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 8B/D13D

    .endsection Unsorted8BD13CSection


    .section Unsorted8BD13DSection

      .al
      .xl

      rlUnknown8BD13D ; 8B/D13D

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8BD4D4
        jsr rsUnknown8BD600
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0740, $80, $5000

        rtl

        .databank 0

        ; 8B/D151

    .endsection Unsorted8BD13DSection


    .section Unsorted8BD151Section

      .al
      .xl

      rlUnknown8BD151 ; 8B/D151

        .al
        .xl
        .autsiz
        .databank ?

        lda #$3C00
        sta aCurrentTilemapInfo,b
        lda #$8B00
        sta lR18+1
        lda #$D277
        sta lR18
        ldx #$0A0E
        jsl rlDrawMenuTextLine
        lda #$8B00
        sta lR18+1
        lda #$D281
        sta lR18
        ldx #$0A16
        jsl rlDrawMenuTextLine
        lda #$8B00
        sta lR18+1
        lda #$D28B
        sta lR18
        ldx #$0A1B
        jsl rlDrawMenuTextLine
        lda #$2000
        sta aCurrentTilemapInfo,b
        ldy #$0000

        _D193
        tya
        asl a
        tax
        lda $7F8189,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        tya
        asl a
        clc
        adc #$000D
        and #$00FF
        xba
        ora #$000E
        tax
        jsl rlDrawMenuTextLine
        inc y
        tya
        cmp $7F83D9
        bne _D193
        ldy #$0000

        _D1C8
        tya
        asl a
        tax
        lda $7F83C9,x
        beq _D1D7
        lda $7F8189,x
        bne _D1F3

        _D1D7
        lda #$8B00
        sta lR18+1
        lda #$D295
        sta lR18
        tya
        asl a
        clc
        adc #$000D
        and #$00FF
        xba
        ora #$000E
        tax
        jsl rlDrawMenuTextLine

        _D1F3
        inc y
        tya
        cmp $7F83D9
        bne _D1C8
        ldy #$0000

        _D1FE
        tya
        asl a
        tax
        lda $7F83B9,x
        tax
        lda #$0000
        jsl rlGetFactionRelation
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $8BD2A4,x
        sta lR18+1
        lda $8BD2A3,x
        sta lR18
        tya
        asl a
        clc
        adc #$000D
        and #$00FF
        xba
        ora #$0016
        tax
        jsl rlDrawMenuTextLine
        inc y
        tya
        cmp $7F83D9
        bne _D1FE
        lda #$0000

        _D23D
        sta $7F83DD
        asl a
        tax
        lda $7F83C9,x
        pha
        lda $7F83DD
        asl a
        clc
        adc #$000D
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0038
        tax
        lda #$3920
        sta wR5
        lda #$0002
        sta wR6
        pla
        jsl rlDrawMenuTextNumber
        lda $7F83DD
        inc a
        cmp $7F83D9
        bne _D23D
        rtl

        .databank 0

        ; 8B/D277

    .endsection Unsorted8BD151Section


    .section Unsorted8BD2D7Section

      .al
      .xl

      rlUnknown8BD2D7 ; 8B/D2D7

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $7F8183
        asl a
        tax
        lda $7F83B9,x
        jsl rlGetFactionSlotNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0A10
        jsl rlDrawMenuTextLine
        lda wEventLocationEntry,b
        pha
        lda #$8B00
        sta lR18+1
        lda #$D44E
        sta lR18
        ldx #$0D0E
        jsl rlDrawMenuTextLine
        lda $7F8183
        asl a
        tax
        lda $7F83B9,x
        jsl rlGetFactionSlotLocationID
        cmp #$00FF
        bne _D332
        lda #$8B00
        sta lRoutineVariable+1,b
        lda #$D4BC
        sta lRoutineVariable,b
        bra _D33A


        _D332
        jsl rlGetLocationEventDataEntry
        jsl rlGetEventLocationEntryCastleName

        _D33A
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0D12
        jsl rlDrawMenuTextLine
        pla
        sta wEventLocationEntry,b
        lda $7F8183
        asl a
        tax
        lda $7F83C9,x
        beq _D363
        lda $7F8189,x
        beq _D378
        bra _D38D


        _D363
        lda #$8B00
        sta lR18+1
        lda #$D484
        sta lR18
        ldx #$130F
        jsl rlDrawMenuTextLine
        jml _D44D


        _D378
        lda #$8B00
        sta lR18+1
        lda #$D4A0
        sta lR18
        ldx #$130F
        jsl rlDrawMenuTextLine
        jml _D44D


        _D38D
        lda #$8B00
        sta lR18+1
        lda #$D456
        sta lR18
        ldx #$100E
        jsl rlDrawMenuTextLine
        lda $7F8183
        asl a
        tax
        lda $7F8189,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1310
        jsl rlDrawMenuTextLine
        lda #$8B00
        sta lR18+1
        lda #$D468
        sta lR18
        ldx #$150F
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitLevel
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$056A
        jsl rlDrawMenuTextNumber
        lda #$8B00
        sta lR18+1
        lda #$D46E
        sta lR18
        ldx #$170F
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitCurrentHP
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$05E4
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitMaxHP
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$05EA
        jsl rlDrawMenuTextNumber
        lda #$8B00
        sta lR18+1
        lda #$D47C
        sta lR18
        ldx #$190F
        jsl rlDrawMenuTextLine
        lda #$0000
        sta wRoutineVariable1,b
        jsl rlGetFirstWeaponBattleMight
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$066A
        jsl rlDrawMenuTextNumber

        _D44D
        rtl

        .databank 0

        ; 8B/D44E

    .endsection Unsorted8BD2D7Section


    .section Unsorted8BD4C6Section

      .al
      .xl

      rsUnknown8BD4C6 ; 8B/D4C6

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$029C
        lda #$0011
        ldy #$0011
        jsl rlClearTilemapRect
        rts

        .databank 0

        ; 8B/D4D4

    .endsection Unsorted8BD4C6Section


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


    .section Unsorted8BD51FSection

      .al
      .xl

      rsUnknown8BD51F ; 8B/D51F

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $8B
        lda $7F8183
        asl a
        tax
        lda $7F83C9,x
        beq _D57B
        lda $7F8189,x
        beq _D57B
        lda #$00C3
        sta wR0
        lda #$0095
        sta wR1
        lda $7F8183
        asl a
        tax
        lda @l $8BD5F0,x
        sta wR4
        stz wR5
        ldy #$D5B2
        jsl rlPushToOAMBuffer
        jsr rsUnknown8BD613
        lda #$006E
        sta wR0
        lda #$0098
        sta wR1
        stz wR4
        stz wR5
        lda $7F8183
        asl a
        tax
        lda $7F81A9,x
        bmi _D574
        ldy #$D59A
        bra _D577


        _D574
        ldy #$D5A1

        _D577
        jsl rlPushToOAMBuffer

        _D57B
        lda #$0051
        sta wR1
        lda $7F8183
        asl a
        sta wR4
        stz wR0
        stz wR5
        ldy #$D593
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8B/D593

    .endsection Unsorted8BD51FSection


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


    .section Unsorted8BD613Section

      .al
      .xl

      rsUnknown8BD613 ; 8B/D613

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8183
        asl a
        tax
        lda $7F81A9,x
        bmi _D623
        jsr rsUnknown8BD627
        rts


        _D623
        jsr rsUnknown8BD6B1
        rts

        .databank 0

        ; 8B/D627

      rsUnknown8BD627 ; 8B/D627

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0030
        cmp #$0000
        beq _D640
        cmp #$0010
        beq _D645
        cmp #$0020
        beq _D64A
        cmp #$0030
        beq _D64F

        _D640
        lda #$0000
        bra _D654


        _D645
        lda #$0080
        bra _D654


        _D64A
        lda #$0100
        bra _D654


        _D64F
        lda #$0080
        bra _D654


        _D654
        sta $07E6,b
        lda $7F8183
        asl a
        tax
        lda $7F81A9,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda $88D527,x
        sta lR18+1
        lda aUnknown88D526,x
        sta $07EA,b
        lda $07EA,b
        clc
        adc $07E6,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$4040
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda $07EA,b
        clc
        adc #$0040
        clc
        adc $07E6,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$4140
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 8B/D6B1

      rsUnknown8BD6B1 ; 8B/D6B1

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0030
        cmp #$0000
        beq _D6CA
        cmp #$0010
        beq _D6CF
        cmp #$0020
        beq _D6D4
        cmp #$0030
        beq _D6D9

        _D6CA
        lda #$0000
        bra _D6DE


        _D6CF
        lda #$00C0
        bra _D6DE


        _D6D4
        lda #$0180
        bra _D6DE


        _D6D9
        lda #$00C0
        bra _D6DE


        _D6DE
        sta $07E6,b
        lda $7F8183
        asl a
        tax
        lda $7F81A9,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda $88D5E4,x
        sta lR18+1
        lda aUnknown88D5E3,x
        sta $07EA,b
        lda $07EA,b
        clc
        adc $07E6,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$4040
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda $07EA,b
        clc
        adc #$0040
        clc
        adc $07E6,b
        sta lR18
        lda #$0080
        sta wR0
        lda #$4140
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 8B/D73B

      rsUnknown8BD73B ; 8B/D73B

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        pha
        plb
        .databank $00
        rep #$20
        lda $7F8183
        asl a
        tax
        lda $8BD786,x
        sta $7F83DD
        tax
        ldy #$0000

        _D755
        lda $7F82B9,x
        sta aOAMPaletteBuffer.aPalette1,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0020
        bne _D755
        lda $7F83DD
        tax
        ldy #$0000

        _D76D
        lda $7F81B9,x
        sta aOAMPaletteBuffer.aPalette2,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0020
        bne _D76D
        lda #$35AD
        sta $025C,b
        phk
        plb
        .databank $8B
        rts

        .databank 0

        ; 8B/D786

    .endsection Unsorted8BD613Section


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


    .section Unsorted8BD7BDSection

      .al
      .xl

      rsUnknown8BD7BD ; 8B/D7BD

        .al
        .xl
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _D7FC
        lda $7F818B
        bmi _D7FD
        bne _D801
        lda $7F818F
        bmi _D805
        bne _D809
        lda $7F873B
        bmi _D811
        bne _D80D
        lda wJoy1New
        bit #$8000
        bne _D821
        bit #$0100
        bne _D856
        bit #$0200
        bne _D81D
        lda wJoy1Repeated
        bit #$0800
        bne _D819
        bit #$0400
        bne _D815

        _D7FC
        rts


        _D7FD
        jml rsUnknown8BDD48


        _D801
        jml rsUnknown8BDD87


        _D805
        jml rsUnknown8BDDC6


        _D809
        jml rsUnknown8BDE05


        _D80D
        jml _D8A8


        _D811
        jml _D8DF


        _D815
        jml rsUnknown8BDCEA


        _D819
        jml rsUnknown8BDC92


        _D81D
        jml _D887


        _D821
        lda #$0021
        jsl rlUnknown808FAD
        lda #$0001
        sta wGameStateStep,b
        lda wUnknown000D79,b
        bit #$0020
        bne _D851
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


        _D851
        jsl rlUnknown80BB7C
        rts


        _D856
        lda $7F8185
        asl a
        tax
        lda $7F8741,x
        cmp #$000D
        bcc _D886
        lda $7F873D
        bne _D886
        lda #$0007
        jsl rlUnknown808FAD
        lda #$0001
        sta $7F873D
        lda #$0001
        sta $7F873B
        jsr rsUnknown8BDE44
        jsr rsUnknown8BDECD

        _D886
        rts


        _D887
        lda $7F873D
        beq _D8A7
        lda #$0007
        jsl rlUnknown808FAD
        lda #$FFFF
        sta $7F873B
        lda $7F873D
        dec a
        sta $7F873D
        jsr rsUnknown8BDECD

        _D8A7
        rts


        _D8A8
        lda $7F873D
        inc a
        sta $7F873D
        jsr rsUnknown8BDECD
        lda $7F8185
        asl a
        tax
        lda $7F8741,x
        cmp #$0013
        bcc _D8CE
        lda $7F873D
        cmp #$000C
        bne _D8DE
        bra _D8D7


        _D8CE
        lda $7F873D
        cmp #$0006
        bne _D8DE

        _D8D7
        lda #$0000
        sta $7F873B

        _D8DE
        rts


        _D8DF
        lda $7F873D
        dec a
        sta $7F873D
        jsr rsUnknown8BDECD
        lda $7F873D
        bne _D8FC
        lda #$0000
        sta $7F873B
        sta $7F873D

        _D8FC
        rts

        .databank 0

        ; 8B/D8FD

      rsUnknown8BD8FD ; 8B/D8FD

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 8B/D8FE

    .endsection Unsorted8BD7BDSection


    .section Unsorted8BD8FESection

      .al
      .xl

      rlUnknown8BD8FE ; 8B/D8FE

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8BDAB4
        jsr rsUnknown8BDB54
        jsr rsUnknown8BDBA2
        jsr rsUnknown8BDBB2
        rtl

        .databank 0

        ; 8B/D90B

    .endsection Unsorted8BD8FESection


    .section Unsorted8BD90BSection

      .al
      .xl

      rlUnknown8BD90B ; 8B/D90B

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F818D
        xba
        lsr a
        lsr a
        lsr a
        sta wR1
        lda #$00C8
        sta wR0
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        lda #$000C
        sta wR4

        _D927
        lda #$000C
        sta wR15
        sta wR14
        ldx wR1
        ldy wR0

        _D932
        lda $7F878D,x
        sta aBG3TilemapBuffer,y
        inc x
        inc x
        inc y
        inc y
        dec wR15
        bpl _D932
        ldx wR1
        ldy wR0

        _D945
        lda $7F87AD,x
        sta $83C8,b,y
        inc x
        inc x
        inc y
        inc y
        dec wR14
        bpl _D945
        lda wR1
        clc
        adc #$0040
        sta wR1
        lda wR0
        adc #$0080
        sta wR0
        dec wR4
        bne _D927
        rtl

        .databank 0

        ; 8B/D968

      rlUnknown8BD968 ; 8B/D968

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0126
        lda #$0017
        ldy #$000B
        jsl rlClearTilemapRect
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$D8E8
        sta lMapMenuTilemapRAMEntryPointer,b
        lda $7F8185
        asl a
        tax
        lda $8BDFBF,x
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89AC57,x
        sta lR18+1
        lda $89AC56,x
        sta lR18
        ldx #$0415
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

        ; 8B/D9A6

      rlUnknown8BD9A6 ; 8B/D9A6

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        ldx #$0100

        _D9AC
        sta $7F8F8B,x
        dec x
        dec x
        bne _D9AC
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$D8FA
        sta lMapMenuTilemapRAMEntryPointer,b
        lda $7F8185
        asl a
        tax
        lda $8BDFBF,x
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89ABFA,x
        sta lR18+1
        lda aUnknown89ABF9,x
        sta lR18
        ldx #$0000
        jsl rlDrawMenuTextLine
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        ldx #$0014

        _D9EF
        lda $7F8F8B,x
        sta $856C,b,x
        lda $7F8FDB,x
        sta $85AC,b,x
        dec x
        dec x
        bne _D9EF
        ldx #$0014

        _DA04
        lda $7F8F9F,x
        sta $85EC,b,x
        lda $7F8FEF,x
        sta $862C,b,x
        dec x
        dec x
        bne _DA04
        ldx #$0014

        _DA19
        lda $7F8FB3,x
        sta $866C,b,x
        lda $7F9003,x
        sta $86AC,b,x
        dec x
        dec x
        bne _DA19
        rtl

        .databank 0

        ; 8B/DA2C

      rlUnknown8BDA2C ; 8B/DA2C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7F873D
        lda #$8000
        sta @l lMapMenuTilemapRAMEntryPointer+1
        lda #$D8E8
        sta @l lMapMenuTilemapRAMEntryPointer
        lda $7F8185
        xba
        lsr a
        lsr a
        sta wR1
        stz wR0

        _DA4C
        ldx wR1
        lda $7F81F9,x
        beq _DA82
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitNamePointer
        lda wR0
        asl a
        tax
        lda $8BDA9C,x
        tax
        lda @l lRoutineVariable
        sta lR18
        lda @l lRoutineVariable+1
        sta lR18+1
        jsl rlDrawMenuTextLine
        inc wR1
        inc wR1
        inc wR0
        lda wR0
        cmp #$000C
        bne _DA4C

        _DA82
        lda wR0
        bne _DA9B
        lda #$8B00
        sta @l lR18+1
        lda #$DFA9
        sta @l lR18
        ldx #$1313
        jsl rlDrawMenuTextLine

        _DA9B
        rtl

        .databank 0

        ; 8B/DA9C

    .endsection Unsorted8BD90BSection


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


    .section Unsorted8BDC92Section

      .al
      .xl

      rsUnknown8BDC92 ; 8B/DC92

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8185
        beq _DCB8
        lda $7F8187
        beq _DCB9
        lda #$0006
        jsl rlUnknown808FAD
        lda #$FFFF
        sta $7F818B
        lda $7F8189
        sec
        sbc #$0008
        sta $7F8189

        _DCB8
        rts


        _DCB9
        lda #$0006
        jsl rlUnknown808FAD
        lda #$FFFF
        sta $7F818F
        lda $7F818D
        dec a
        sta $7F818D
        lda wBufferBG2VOFS
        sec
        sbc #$0008
        sta wBufferBG2VOFS
        jsl rlUnknown8BD90B
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 8B/DCEA

      rsUnknown8BDCEA ; 8B/DCEA

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8185
        cmp #$0011
        beq _DD16
        lda $7F8187
        cmp #$000B
        beq _DD17
        lda #$0006
        jsl rlUnknown808FAD
        lda #$0001
        sta $7F818B
        lda $7F8189
        clc
        adc #$0008
        sta $7F8189

        _DD16
        rts


        _DD17
        lda #$0006
        jsl rlUnknown808FAD
        lda #$0001
        sta $7F818F
        lda $7F818D
        inc a
        sta $7F818D
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        jsl rlUnknown8BD90B
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 8B/DD48

      rsUnknown8BDD48 ; 8B/DD48

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8189
        sec
        sbc #$0008
        sta $7F8189
        lda $7F8187
        dec a
        sta $7F8187
        lda $7F8185
        dec a
        sta $7F8185
        lda #$0000
        sta $7F818B
        jsl rlUnknown8BD968
        jsl rlUnknown8BD9A6
        jsl rlUnknown8BDA2C
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 8B/DD87

      rsUnknown8BDD87 ; 8B/DD87

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8189
        clc
        adc #$0008
        sta $7F8189
        lda $7F8187
        inc a
        sta $7F8187
        lda $7F8185
        inc a
        sta $7F8185
        lda #$0000
        sta $7F818B
        jsl rlUnknown8BD968
        jsl rlUnknown8BD9A6
        jsl rlUnknown8BDA2C
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 8B/DDC6

      rsUnknown8BDDC6 ; 8B/DDC6

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F818D
        dec a
        sta $7F818D
        lda $7F8185
        dec a
        sta $7F8185
        lda #$0000
        sta $7F818F
        lda wBufferBG2VOFS
        sec
        sbc #$0008
        sta wBufferBG2VOFS
        jsl rlUnknown8BD90B
        jsl rlUnknown8BD968
        jsl rlUnknown8BD9A6
        jsl rlUnknown8BDA2C
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 8B/DE05

      rsUnknown8BDE05 ; 8B/DE05

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F818D
        inc a
        sta $7F818D
        lda $7F8185
        inc a
        sta $7F8185
        lda #$0000
        sta $7F818F
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        jsl rlUnknown8BD90B
        jsl rlUnknown8BD968
        jsl rlUnknown8BD9A6
        jsl rlUnknown8BDA2C
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 8B/DE44

      rsUnknown8BDE44 ; 8B/DE44

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        ldx #$0228

        _DE4A
        sta $7F908B,x
        dec x
        dec x
        bne _DE4A
        lda #$8000
        sta @l lMapMenuTilemapRAMEntryPointer+1
        lda #$D903
        sta @l lMapMenuTilemapRAMEntryPointer
        lda $7F8185
        xba
        lsr a
        lsr a
        sta wR1
        stz wR15

        _DE6B
        ldx wR1
        lda $7F81F9,x
        beq _DE9C
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitNamePointer
        lda wR15
        asl a
        tax
        lda $8BDE9D,x
        tax
        lda @l lRoutineVariable
        sta lR18
        lda @l lRoutineVariable+1
        sta lR18+1
        jsl rlDrawMenuTextLine
        inc wR1
        inc wR1
        inc wR15
        bra _DE6B


        _DE9C
        rts

        .databank 0

        ; 8B/DE9D

    .endsection Unsorted8BDC92Section


    .section Unsorted8BDECDSection

      .al
      .xl

      rsUnknown8BDECD ; 8B/DECD

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        lda $7F873D
        clc
        adc #$000B
        asl a
        tax
        ldy #$0016

        _DEE2
        lda $7F908B,x
        sta $876C,b,y
        lda $7F90B9,x
        sta $87AC,b,y
        dec x
        dec x
        dec y
        dec y
        bne _DEE2
        lda $7F873D
        clc
        adc #$000B
        asl a
        tax
        ldy #$0016

        _DF03
        lda $7F90E7,x
        sta $87EC,b,y
        lda $7F9115,x
        sta $882C,b,y
        dec x
        dec x
        dec y
        dec y
        bne _DF03
        lda $7F873D
        clc
        adc #$000B
        asl a
        tax
        ldy #$0016

        _DF24
        lda $7F9143,x
        sta $886C,b,y
        lda $7F9171,x
        sta $88AC,b,y
        dec x
        dec x
        dec y
        dec y
        bne _DF24
        lda $7F873D
        clc
        adc #$000B
        asl a
        tax
        ldy #$0016

        _DF45
        lda $7F919F,x
        sta $88EC,b,y
        lda $7F91CD,x
        sta $892C,b,y
        dec x
        dec x
        dec y
        dec y
        bne _DF45
        lda $7F873D
        clc
        adc #$000B
        asl a
        tax
        ldy #$0016

        _DF66
        lda $7F91FB,x
        sta $896C,b,y
        lda $7F9229,x
        sta $89AC,b,y
        dec x
        dec x
        dec y
        dec y
        bne _DF66
        lda $7F873D
        clc
        adc #$000B
        asl a
        tax
        ldy #$0016

        _DF87
        lda $7F9257,x
        sta $89EC,b,y
        lda $7F9285,x
        sta $8A2C,b,y
        dec x
        dec x
        dec y
        dec y
        bne _DF87
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 8B/DFA9

    .endsection Unsorted8BDECDSection


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

        ; Read by rlUnitWindowCopySpritePalette1.

        .word $3800, $7BFF, $56D7, $35EF, $0462, $02FB, $000B, $5C40
        .word $6D25, $7E0F, $0140, $1EC5, $10EA, $298F, $0487, $0134
        .word $3800, $0012, $013A, $02FB, $7E6A, $7504, $0120, $0280
        .word $7FFF, $56D7, $35EF, $08A6, $190A, $256C, $4232, $0842
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

        ; DD/8000

    .endsection TableDD7FB0Section
