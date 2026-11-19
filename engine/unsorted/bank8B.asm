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
