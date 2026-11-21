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
        jsl rlQueueSoundCommand
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
        jsl rlDialogueStartTextAndHDMA
        lda #(`rlUnknown8B9275)<<8
        sta aDialogue.lHDMARoutine+1,b
        lda #<>rlUnknown8B9275
        sta aDialogue.lHDMARoutine,b
        ldx #$0000
        jsl rlUnknown8B91F6
        rts


        _883D
        jsl rlDMAByStruct

          .structDMAToVRAM gUnknownD96C00, $0800, $80, $B000

        jsl rlResetHDMAEngine
        rts


        _884F
        lda #$0021
        jsl rlPlaySoundEffect
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
        lda #(`procUnknown8B8C3A)<<8
        sta lR44+1
        lda #<>procUnknown8B8C3A
        sta lR44
        jsl rlProcEngineCreateProc
        bra _8BD6

        .databank 0

        ; 8B/8BF2

    .endsection Unsorted8B8BB5Section


    .section Unsorted8B8C3ASection

      .al
      .xl

      procUnknown8B8C3A ; 8B/8C3A

        .structProcInfo "CF", rlUnknown8B8C42, rlUnknown8B8C4A, aProcUnknown8B8C3ACode

    .endsection Unsorted8B8C3ASection


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


    .section Unsorted8B8C81Section

      .al
      .xl

      aProcUnknown8B8C3ACode ; 8B/8C81

        PROC_HALT


        ; 8B/8C83

    .endsection Unsorted8B8C81Section

    .section Table8B911FSection

      .al
      .xl

      aUnknown8B911F .dstruct structHDMADirectEntryInfo, rlUnknown8B912A, rlUnknown8B912A, $9194, $0008BC, PPU_REG_BASE + $2C, $00 ; 8B/911F

    .endsection Table8B911FSection











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

    .section Table8B9449Section

      .al
      .xl

      aUnknown8B9449 ; 8B/9449
        .word $00A0, $0000, <>rlUnknown8B9451, $9456

    .endsection Table8B9449Section











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


      aUnknown8B9456 ; 8B/9456
        .word <>rsUnknown82E028

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


    .section Table8B9594Section

      .al
      .xl

      aUnknown8B9594 ; 8B/9594
        .word $0060, $00A0, <>rlUnknown8B959C, $95A1

    .endsection Table8B9594Section






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


      aUnknown8B95A1 ; 8B/95A1
        .word <>rsUnknown82E028

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
        jsr (aUnknown8B9726,x)
        plp
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/9726

    .endsection Unsorted8B96CFSection


    .section Table8B9726Section

      .al
      .xl

      aUnknown8B9726 ; 8B/9726

        ; Jump table of rlUnknown8B9717.
        .word <>rsUnknown8B9759
        .word <>rsUnknown8B972C
        .word <>rsUnknown8B973C

    .endsection Table8B9726Section


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


    .section Unsorted8B973CSection

      .al
      .xl

      rsUnknown8B973C ; 8B/973C

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0007
        bne _974D
        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _9750
        dec bBufferINIDISP

        _974D
        rep #$20
        rts


        _9750
        .as
        rep #$20
        lda $0594,b
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8B/9759

    .endsection Unsorted8B973CSection


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


      aUnknown8BA0B5 ; 8B/A0B5

        HDMA_HALT

      aUnknown8BA0B7 ; 8B/A0B7

        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $00F7, $00F7, $00F7, $00F7, $10F7, $00F7
        .word $00F7, $00F7, $00F7, $00F7, $00F7, $00F7, $00F7, $00F7
        .word $00F7, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0002, $0002, $0002, $0002, $0002
        .word $0002, $0002, $0002, $0002, $0002, $0002, $0005, $0005
        .word $0005, $0005, $0005, $0005, $0005, $0005, $0005, $0005
        .word $0005, $0005, $0005, $0000, $0000, $0000, $1000, $0000
        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $00F5, $00F5, $00F5
        .word $00F5, $00F5, $00F5, $00F5, $00F5, $00F5, $00F5, $00F5
        .word $00F5, $0000, $0000, $0003, $0003, $0003, $0003, $0003
        .word $0003, $0003, $0003, $0003, $0003, $0003, $0003, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aUnknown8BA27C ; 8B/A27C

        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00F0
        .word $00F0, $00F0, $00F0, $00F0, $00F0, $00F0, $00F0, $00F0
        .word $00F0, $00F0, $00F0, $00F0, $00FD, $00FD, $00FD, $00FD
        .word $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $0004
        .word $0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
        .byte $C0
        .word $0004, $0004, $0004, $0004, $0004, $00FD, $00FD, $00FD
        .word $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $00FD
        .word $00FD, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aUnknown8BA441 ; 8B/A441

        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $C0
        .word $0000, $0000, $0000, $0009, $0009, $0009, $0009, $0009
        .word $0009, $0009, $0009, $0009, $0009, $0006, $0006, $0006
        .word $0006, $0006, $0006, $0006, $0006, $0000, $0000, $0000
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $00FC, $00FC, $10FC, $00FC, $10FC, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF, $00FF
        .byte $C0
        .word $00FF, $00FF, $00FF, $0003, $0003, $0003, $0003, $0003
        .word $0003, $0003, $0003, $0003, $0003, $00FD, $00FD, $00FD
        .word $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $00FD, $0001
        .word $0001, $0001, $0001, $0001, $0001, $0001, $0001, $0001
        .word $0001, $0001, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

      aUnknown8BA606 ; 8B/A606

        .byte $C0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $C0
        .word $00FE, $00FE, $00FE, $00FE, $00FE, $00FE, $00FE, $00FE
        .word $00FE, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $00FC, $00FD, $00FD, $00FD, $00FD, $00FD, $00FD
        .word $00FD, $00FD, $00FD, $00FD, $00FC, $00FC, $00FC, $00FC
        .word $00FC, $00FC, $00FC, $00FC, $00FC, $00FC, $0004, $0004
        .word $0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
        .word $0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
        .byte $C0
        .word $0004, $0004, $0004, $0004, $0004, $0004, $0004, $0004
        .word $0004, $0004, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte $A0
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .byte 0

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


    .section Table8CDE00Section

      .al
      .xl

      aUnknown8CDE00 ; 8C/DE00

        ; Read by rsUnknown8B8114.

        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F

        ; 8C/DE20

    .endsection Table8CDE00Section


    .section Data8CDE20Section

      .al
      .xl

      aUnknown8CDE20 ; 8C/DE20

        ; Read by rsUnknown8B8114.

        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F
        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F
        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F
        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F
        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F
        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F
        .word $031F, $133F, $235F, $337F, $3F7F, $4F9F, $5FBF, $6FDF
        .word $6FDF, $5FBF, $4F9F, $3F7F, $337F, $235F, $133F, $031F

        ; 8C/DF00

    .endsection Data8CDE20Section


    .section TableDD7FB0Section

      .al
      .xl

      aItemIconPalette ; DD/7FB0

        ; The colours of g4bppItemIcons. Copied into a sprite palette by
        ; rlUnitWindowCopySpritePalette1.

        .word $3800, $7BFF, $56D7, $35EF, $0462, $02FB, $000B, $5C40
        .word $6D25, $7E0F, $0140, $1EC5, $10EA, $298F, $0487, $0134

      aUnknownDD7FD0 ; DD/7FD0

        ; Copied into a sprite palette by rlUnitWindowCopySpritePalette2; it
        ; does not colour the item icons properly, so it is for something else.

        .word $3800, $0012, $013A, $02FB, $7E6A, $7504, $0120, $0280
        .word $7FFF, $56D7, $35EF, $08A6, $190A, $256C, $4232, $0842

        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

        ; DD/8000

    .endsection TableDD7FB0Section
