; TODO: describe this file.

    .section Unsorted91A7BCSection

      .al
      .xl

      rlUnknown91A7BC ; 91/A7BC

        .al
        .autsiz
        .databank ?

        ; A = fill value

        php
        ldx #$07FE

          -
          sta aBG3TilemapBuffer,x
          dec x
          dec x
          bpl -

        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $B000

        nop
        nop
        nop
        nop
        jsl rlUnknown8780EC
        plp
        rtl

        .databank 0

    .endsection Unsorted91A7BCSection


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


    .section Unsorted91A9BBSection

      .al
      .xl

      rlUnknown91A9BB ; 91/A9BB

        .al
        .autsiz
        .databank ?

        jsl rlLoadMapMenuData

        lda #$2000
        sta aCurrentTilemapInfo.wBaseTile,b
        lda #$00FF
        sta wUnknown053E,b
        lda #$20FF
        sta wUnknown053C,b
        jsl rlUnknown8788E5

        lda #(`aUnknown91A9E4)<<8
        sta lR18+1
        lda #<>aUnknown91A9E4
        sta lR18
        jsl rlUnknown8788EE
        rtl

        .databank 0

      aUnknown91A9E4 ; 91/A9E4

        .word $6106
        .word $2107
        .word $2106
        .word $6108
        .word $2108
        .word $E106
        .word $A107

; 06 A1 85 06 A5 27 48 A5 28 48 A9 00 00 85 28 A9 08 00 85 27 A5 06 20 15 AA 20 6F AA 68 85 28 68 85 27 6B 08 DA 5A A0 00 00 85 1A A9 10 27

    .endsection Unsorted91A9BBSection
