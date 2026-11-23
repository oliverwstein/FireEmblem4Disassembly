; The anti-tamper screens (bank $91). When the code checksum check at reset
; fails (rlCheckResetSignature in boot.asm), the game clears RAM, loads one of two
; screens, fades it in and hangs: rlShowAntiTamperScreen the first time (the SRAM
; mark has just been written), rlShowAntiTamperScreenAgain when the mark was
; already there.


    .section Unsorted91E793Section

      .as
      .xl

      rlLoadAntiTamperScreenAgain ; 91/E793

        .al
        .xl
        .autsiz
        .databank ?

        php
        jsr rsSetSaveMenuScreenRegisters
        lda #(`gcUnknown9CB90D)<<8
        sta lR18+1
        lda #<>gcUnknown9CB90D
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $0800, $80, $6000

        lda #(`gcUnknown9CC0B4)<<8
        sta lR18+1
        lda #<>gcUnknown9CC0B4
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $4800, $80, $A000

        lda #(`gcUnknown9CCB62)<<8
        sta lR18+1
        lda #<>gcUnknown9CCB62
        sta lR18
        lda #(`aBG3TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $9000

        lda #(`gcUnknown9CD916)<<8
        sta lR18+1
        lda #<>gcUnknown9CD916
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

      rlLoadAntiTamperScreen ; 91/E82A

        .al
        .xl
        .autsiz
        .databank ?

        php
        jsr rsSetSaveMenuScreenRegisters
        lda #(`gcUnknown9CB90D)<<8
        sta lR18+1
        lda #<>gcUnknown9CB90D
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $0800, $80, $6000

        lda #(`gcUnknown9CCE12)<<8
        sta lR18+1
        lda #<>gcUnknown9CCE12
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $4800, $80, $A000

        lda #(`gcUnknown9CD719)<<8
        sta lR18+1
        lda #<>gcUnknown9CD719
        sta lR18
        lda #(`aBG3TilemapBuffer)<<8
        sta lR19+1
        lda #<>aBG3TilemapBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $9000

        lda #(`gcUnknown9CD916)<<8
        sta lR18+1
        lda #<>gcUnknown9CD916
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

      rlShowAntiTamperScreenAgain ; 91/E8C1

        .al
        .xl
        .autsiz
        .databank ?

        ; The code checksum failed again with the anti-tamper mark already in SRAM: shows the second screen and hangs.

        php
        sei
        jsr rsClearRAMAndResetHardware
        jsl rlLoadAntiTamperScreenAgain
        bra rlFadeInAndHang

        .databank 0

      rlShowAntiTamperScreen ; 91/E8CC

        .al
        .xl
        .autsiz
        .databank ?

        ; The code checksum failed (the mark has just been written): shows the first screen and hangs.

        php
        sei
        jsr rsClearRAMAndResetHardware
        jsl rlLoadAntiTamperScreen

      rlFadeInAndHang ; 91/E8D5

        .al
        .xl
        .autsiz
        .databank ?

        stz wGameStateRoutine1,b
        lda #<>rsRunAntiTamperVBlank
        sta wVBlankPointer
        lda #<>rsRunAntiTamperMainLoop
        sta wMainLoopPointer
        lda #<>rsDefaultIRQRoutine
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
        jsl rlHaltUntilVBlank
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

        ; Unreachable: it follows the endless loop above.
        plp
        rtl

    .endsection Unsorted91E793Section


    .section Unsorted91E915Section

      .al
      .xl

      rsClearRAMAndResetHardware ; 91/E915

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
        jsl rlInitSound
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        rts

        .databank 0

        ; 91/E92E

    .endsection Unsorted91E915Section


