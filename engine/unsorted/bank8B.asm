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
        jsr rlUnknown8B8114
        rtl

        .databank 0

        ; 8B/806D

    .endsection Unsorted8B8000Section


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
        sta $0ECF,b
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
        sta $0ECF,b
        lda #(`procMainLoopChangeFadeByTimer)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFadeByTimer
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 8B/8114

      rlUnknown8B8114 ; 8B/8114

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$003C
        lsr a
        tax
        lda $8CDE00,x
        sta $022A,b
        lda $8CDE20,x
        sta $024A,b
        rts

        .databank 0

        ; 8B/812A

    .endsection Unsorted8B80CBSection


    .section Unsorted8B91F6Section

      .al
      .xl

      rlUnknown8B91F6 ; 8B/91F6

        .al
        .autsiz
        .databank ?

        lda #DialogueStatusPreventASpeedUp
        tsb aDialogue.wStatus,b

        lda #3
        sta aDialogue.wTextSpeed,b
        lda #2
        sta aDialogue.wTextSound,b

        lda wCurrentChapter,b
        cmp #-1
        bne +

          lda #4
          sta aDialogue.wUnknown00188C,b
          lda #6
          sta aDialogue.wTextSpeed,b
          lda #0
          sta aDialogue.wTextSound,b

        +
        lda #2
        sta aDialogue.wUnknown0018D0,b
        lda #(4 << 8 | 30)
        sta aDialogue._Slot[0].wDisplayArea,b,x
        lda #$9000 >> 1
        sta aDialogue._Slot[0].wVRAMAddress,b,x
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[0].lBGBufferPosition+1,b,x
        lda #<>aBG3TilemapBuffer
        sta aDialogue._Slot[0].lBGBufferPosition,b,x

        ; Is this supposed to be X indexed?
        lda #TilemapEntry($100, 0, true, false, false)
        sta aDialogue.wBaseTile,b,x
        lda #$1604
        sta wR1

        sep #$20
        lda #0
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

        ldx aDialogue.wSlotOffset,b
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[0].lBGBufferPosition+1,b,x
        lda #<>aBG3TilemapBuffer
        clc
        adc wR0
        sta aDialogue._Slot[0].lBGBufferPosition,b,x
        rtl

        .databank 0

      rlUnknown8B9275 ; 8B/9275

        .al
        .autsiz
        .databank ?

        php
        lda #$7E00
        sta $24+1
        ldy #$FF00

        lda $18A1,b
        and #$0001
        bne +

        ldy #$FF80
        
        +
        sty $24

        ldy #0
        lda $18D4,b
        sec
        sbc #$8388
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        pha

        asl a
        asl a
        asl a
        cmp #$007F
        bcc +
        beq +

        pha
        lda $87
        sta $00
        lda $89
        sta $02
        lda #$007F
        jsl rlDialogueWriteHDMADataEntry
        pla
        sec
        sbc #$007F
        
        +
        pha
        lda $87
        sta $00
        lda $89
        sta $02
        pla
        jsl rlDialogueWriteHDMADataEntry
        jsl rlDialogueGetSlot1BoxPixelHeight
        sta $27
        sec
        sbc #$0010
        cmp $18E1,b
        bcs _9352

        sta $2D
        lda #$0100
        clc
        adc #0
        sta $00

        lda $27
        tax
        lda $18E1,b
        sec
        sbc $2D
        jsl rlUnknown91969C
        txa
        beq _9352

        sta $2A
        clc
        adc #0
        sta $02
        lda $27
        sec
        sbc $2A
        jsl rlDialogueWriteHDMADataEntry
        lda $2A
        cmp #$0010
        bcc +

        lda #$0100
        clc
        adc #0
        sta $00
        lda $2A
        sec
        sbc $27
        clc
        adc #0
        sta $02

        lda $2A
        and #$FFF0
        jsl rlDialogueWriteHDMADataEntry

        +
        lda $2A
        and #$000F
        sta $2A
        beq _9366
        
        -
        lda #$0100
        clc
        adc #0
        sta $00
        lda $2A
        sec
        sbc $27
        clc
        adc #0
        sta $02
        lda #1
        jsl rlDialogueWriteHDMADataEntry
        dec $2A
        bne -
        bra _9366
        
        _9352
        lda #$0100
        clc
        adc #0
        sta $00
        lda #0
        sta $02
        lda $27
        jsl rlDialogueWriteHDMADataEntry
        
        _9366
        pla
        clc
        adc $18DC,b
        sta $00

        lda $1882,b
        bit #$1000
        bne +

        jml $8B942F
        
        +
        lda $18ED,b
        sec
        sbc #$8388
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sec
        sbc $00
        asl a
        asl a
        asl a
        pha
        lda $87
        sta $00
        lda $89
        sta $02
        pla
        jsl rlDialogueWriteHDMADataEntry
        jsl rlDialogueGetSlot2BoxPixelHeight
        sta $27
        sec
        sbc #$0010
        cmp $18FA,b
        bcs _941D

        sta $2D
        lda $87
        clc
        adc #0
        sta $00
        lda $27
        tax
        lda $18FA,b
        sec
        sbc $2D
        jsl rlUnknown91969C
        txa
        beq _941D

        sta $2A
        clc
        adc $89
        sta $02
        lda $27
        sec
        sbc $2A
        jsl rlDialogueWriteHDMADataEntry

        lda $2A
        cmp #$0010
        bcc +

        lda $87
        clc
        adc #0
        sta $00
        lda $2A
        sec
        sbc $27
        clc
        adc $89
        sta $02
        lda $2A
        and #$FFF0
        jsl rlDialogueWriteHDMADataEntry
        
        +
        lda $2A
        and #$000F
        sta $2A
        beq _942F
        
        -
        lda $87
        clc
        adc #0
        sta $00
        lda $2A
        sec
        sbc $27
        clc
        adc $89
        sta $02
        lda #1
        jsl rlDialogueWriteHDMADataEntry
        dec $2A
        bne -
        bra _942F
        
        _941D
        lda $87
        clc
        adc #0
        sta $00
        lda $89
        sta $02
        lda $27
        jsl rlDialogueWriteHDMADataEntry
        
        _942F
        lda #1
        pha
        lda #$0100
        sta $00
        lda #0
        sta $02
        pla
        jsl rlDialogueWriteHDMADataEntry
        lda #0
        sta [$24],y
        plp
        rtl

        .databank 0

        ; 8B/9449

    .endsection Unsorted8B91F6Section


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
        lda $8BBFF0,x
        clc
        adc wR0
        pha
        tya
        cmp #$FFFF
        bne _BE96
        lda $8BBFEE
        sta lR18+1
        lda $8BBFED
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
        lda $8BBED5,x
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
        lda $8BC457,x
        tay
        ldx #$001E

        _C444
        lda $DD7FB0,x
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
