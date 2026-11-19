; Code from bank $91 not yet assigned to a game system.


    .section Unsorted91A80DSection

      .al
      .xl

      rlUnknown91A80D ; 91/A80D

        .al
        .autsiz
        .databank ?

        php
        lda bDecompressionArrayFlag,b
        bne _End

          lda aMovingMapSprites.wState,b
          cmp #2
          beq _A85B

            cmp #1
            bne _End

              lda aMovingMapSprites.wCharacterID,b
              sta wRoutineVariable1,b
              lda aMovingMapSprites.wSpawnXCoordinate,b
              sta aEventMovement.wUnitXCoordinate
              lda aMovingMapSprites.wSpawnYCoordinate,b
              sta aEventMovement.wUnitYCoordinate
              lda aMovingMapSprites.wDestinationXCoordinate,b
              sta aEventMovement.wDestinationXCoordinate
              lda aMovingMapSprites.wDestinationYCoordinate,b
              sta aEventMovement.wDestinationYCoordinate
              lda aMovingMapSprites.wUnknown001830,b
              sta aEventMovement.wUnknown7EC494
              lda aMovingMapSprites.wEntryIndex,b
              jsl rlUnknown87B01D
              bcc +

                brk

              +
              lda #2
              sta aMovingMapSprites.wState,b
              bra _End
              
                _A85B
                lda #0
                sta aMovingMapSprites.wState,b

        _End
        plp
        rtl

        .databank 0

        ; 91/A863

    .endsection Unsorted91A80DSection


    .section Unsorted91A928Section

      .al
      .xl

      rlUnknown91A928 ; 91/A928

        .al
        .autsiz
        .databank ?

        jsl rlUnknown91A956
        jsl rlUnknown91A931
        rtl

        .databank 0

      rlUnknown91A931 ; 91/A931

        .al
        .autsiz
        .databank ?

        lda #0
        jsl rlDialogueUpdateSlotOffset

        lda #pack([28, 6])
        sta aDialogue._Slot[0].wDisplayArea,b,x
        lda #$8000 >> 1
        sta aDialogue._Slot[0].wVRAMAddress,b,x
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[0].lBGBufferPosition+1,b,x
        lda #$0086
        clc
        adc #<>aBG3TilemapBuffer
        sta aDialogue._Slot[0].lBGBufferPosition,b,x
        bra +

      rlUnknown91A956 ; 91/A956

        .al
        .autsiz
        .databank ?

        lda #1
        jsl rlDialogueUpdateSlotOffset

        lda #pack([28, 6])
        sta aDialogue._Slot[0].wDisplayArea,b,x
        lda #$9000 >> 1
        sta aDialogue._Slot[0].wVRAMAddress,b,x
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[0].lBGBufferPosition+1,b,x
        lda #$0506
        clc
        adc #<>aBG3TilemapBuffer
        sta aDialogue._Slot[0].lBGBufferPosition,b,x

        +
        jsl rlUnknown91A984
        lda #$2000
        tsb aDialogue.wStatus,b
        rtl

        .databank 0

        ; 91/A984

    .endsection Unsorted91A928Section


    .section Unsorted91D69BSection

      .al
      .xl

      rsUnknown91D69B ; 91/D69B

        .al
        .autsiz
        .databank ?

        lda #(`aWorldMapEvents)<<8
        sta lR18+1

        lda wCurrentChapter,b
        cmp #$0012
        bcc +

          lda #0

        +
        asl a
        tax
        lda aWorldMapEvents,x
        sta lR18
        jsl rlUnknown80C1FC
        inc $0304,b
        rts

        .databank 0

        ; 91/D6BB

    .endsection Unsorted91D69BSection


    .section Unsorted91DF6DSection

      .al
      .xl

      rsUnknown91DF6D ; 91/DF6D

        .al
        .xl
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$61
        sta bBufferOBSEL
        lda #$09
        sta bBufferBGMODE
        lda #$00
        sta bBufferMOSAIC
        lda #$3C
        sta bBufferBG1SC
        lda #$42
        sta bBufferBG2SC
        lda #$4A
        sta bBufferBG3SC
        lda #$4C
        sta bBufferBG4SC
        lda #$00
        sta bBufferBG12NBA
        lda #$55
        sta bBufferBG34NBA
        lda #$00
        sta wBufferBG1HOFS
        sta wBufferBG1HOFS+1
        lda #$00
        sta wBufferBG1VOFS
        sta wBufferBG1VOFS+1
        lda #$00
        sta wBufferBG2HOFS
        sta wBufferBG2HOFS+1
        lda #$20
        sta wBufferBG2VOFS
        lda #$00
        sta wBufferBG2VOFS+1
        lda #$06
        sta wBufferBG3HOFS
        lda #$00
        sta wBufferBG3HOFS+1
        lda #$00
        sta wBufferBG3VOFS
        sta wBufferBG3VOFS+1
        lda #$00
        sta wBufferBG4HOFS
        sta wBufferBG4HOFS+1
        lda #$00
        sta wBufferBG4VOFS
        sta wBufferBG4VOFS+1
        lda #$00
        sta bBufferW12SEL
        lda #$00
        sta bBufferW34SEL
        lda #$00
        sta bBufferWOBJSEL
        lda #$00
        sta bBufferWBGLOG
        lda #$00
        sta bBufferWOBJLOG
        lda #$16
        sta bBufferTM
        lda #$01
        sta bBufferTS
        lda #$07
        sta bBufferTMW
        lda #$04
        sta bBufferTSW
        lda #$02
        sta bBufferCGWSEL
        lda #$84
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        lda #$00
        sta bBufferSETINI
        plp
        rts

        .databank 0

        ; 91/E006

    .endsection Unsorted91DF6DSection


    .section Unsorted91E793Section

      .as
      .xl

      rlUnknown91E793 ; 91/E793

        .al
        .xl
        .autsiz
        .databank ?

        php
        jsr rsUnknown91DF6D
        lda #$9C00
        sta lR18+1
        lda #$B90D
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $6000

        lda #$9C00
        sta lR18+1
        lda #$C0B4
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $4800, $80, $A000

        lda #$9C00
        sta lR18+1
        lda #$CB62
        sta lR18
        lda #(`aBG3TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $9000

        lda #$9C00
        sta lR18+1
        lda #$D916
        sta lR18
        lda #(`aBGPaletteBuffer)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer
        sta lR19
        jsl rlAppendDecompList
        sep #$20
        lda #$04
        sta bBufferTM
        lda #$00
        sta bBufferTS
        plp
        rtl

        .databank 0

        ; 91/E82A

      rlUnknown91E82A ; 91/E82A

        .al
        .xl
        .autsiz
        .databank ?

        php
        jsr rsUnknown91DF6D
        lda #$9C00
        sta lR18+1
        lda #$B90D
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $6000

        lda #$9C00
        sta lR18+1
        lda #$CE12
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $4800, $80, $A000

        lda #$9C00
        sta lR18+1
        lda #$D719
        sta lR18
        lda #(`aBG3TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $9000

        lda #$9C00
        sta lR18+1
        lda #$D916
        sta lR18
        lda #(`aBGPaletteBuffer)<<8
        sta lR19+1
        lda #<>aBGPaletteBuffer
        sta lR19
        jsl rlAppendDecompList
        sep #$20
        lda #$04
        sta bBufferTM
        lda #$00
        sta bBufferTS
        plp
        rtl

        .databank 0

        ; 91/E8C1

      rlUnknown91E8C1 ; 91/E8C1

        .al
        .xl
        .autsiz
        .databank ?

        php
        sei
        jsr rsUnknown91E915
        jsl rlUnknown91E793
        bra _E8D5

        .byte $08, $78, $20, $15, $E9, $22, $2A, $E8, $91


        _E8D5
        stz $0302,b
        lda #$F5D0
        sta wVBlankPointer
        lda #$F553
        sta wMainLoopPointer
        lda #$8222
        sta wIRQPointer
        sep #$20
        lda #$04
        sta $212C,b
        sta bBufferTM
        lda #$00
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlEnableVBlank

        _E8FD
        jsl rlUnknown80823F
        inc bBufferINIDISP
        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _E8FD
        jsl rlDisableVBlank

        _E911
        bra _E911

        .databank 0

        ; 91/E913

    .endsection Unsorted91E793Section


    .section Unsorted91E915Section

      .al
      .xl

      rsUnknown91E915 ; 91/E915

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0FFE

        _E918
        stz $0000,b,x
        dec x
        dec x
        bpl _E918
        phk
        plb
        .databank $91
        jsl rlUnknown808EF6
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        rts

        .databank 0

        ; 91/E92E

    .endsection Unsorted91E915Section


    .section Unsorted91F959Section

      .al
      .xl

      rlUnknown91F959 ; 91/F959

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $91
        phk
        plb
        .databank $91
        ldx #$0000
        sep #$20
        lda #$5D
        sta $7F828F,x
        rep #$20
        lda #$0000
        sta $7F8290,x
        inc x
        inc x
        inc x
        ldy #$0000

        _F979
        sep #$20
        lda #$01
        sta $7F828F,x
        rep #$20
        lda $7F8290,x
        clc
        adc $F9AD,b,y
        sta $7F8290,x
        inc y
        inc y
        inc x
        inc x
        inc x
        cpy #$0030
        bne _F979
        sep #$20
        lda #$00
        sta $7F828F,x
        rep #$20
        lda #$0000
        sta $7F8290,x
        plp
        plb
        .databank $91
        rtl

        .databank 0

        ; 91/F9AD

    .endsection Unsorted91F959Section


    .section Unsorted91F9DDSection

      .al
      .xl

      rlUnknown91F9DD ; 91/F9DD

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $91
        ldx #$0000
        sep #$20
        lda #$60
        sta $7F838F,x
        rep #$20
        inc x
        lda #$0000
        sta $7F838F,x
        inc x
        inc x
        ldy #$0000

        _F9F9
        sep #$20
        lda #$01
        sta $7F838F,x
        rep #$20
        inc x
        lda $FA27,b,y
        sta $7F838F,x
        inc x
        inc x
        inc y
        inc y
        cpx #$004B
        bne _F9F9
        sep #$20
        lda #$00
        sta $7F838F,x
        rep #$20
        inc x
        lda #$0000
        sta $7F838F,x
        rtl

        .databank 0

        ; 91/FA27

    .endsection Unsorted91F9DDSection
