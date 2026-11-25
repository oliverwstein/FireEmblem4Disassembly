; Code checksums and anti-tamper. The three copies of the checksums
; (include/Checksums.h) and the routines that add up the guarded code: at reset
; (rlCheckCodeChecksumsAtReset, from boot.asm), from the save menu screen
; (rlCheckCodeChecksumsCopy88), and each time the random numbers are
; reshuffled (rlCheckCodeChecksums, called by rlGetRandomNumber in
; ../lib/random.asm, which then rigs the table with rsRigRNArrayByPlaytime).
; The reset signature (rlWriteResetSignature, rlCheckResetSignature), and the two
; anti-tamper screens (bank $91) that a failed check shows before hanging:
; rlShowAntiTamperScreen the first time (the SRAM mark has just been written),
; rlShowAntiTamperScreenAgain when the mark was already there.

    .section CodeChecksums878000Section

      .al
      .xl

      aCodeChecksumRanges ; 87/8000

        ; The words that the checksums add up: $80/8D56-8E2C and $87/8017-80A9.
        ; Nothing in the built code reads this; the checks use these numbers as
        ; constants.

        .word <>rlReset, <>rlColdResetClearMemory
        .word <>rlWriteResetSignature, <>rlInitMapMenus

      aCodeChecksumsCopy87 .structCodeChecksums $AA24, $B66C, $5349 ; 87/8008

      rsCodeChecksumTrap87 ; 87/800E

        .al
        .xl
        .autsiz
        .databank ?

        ; A loop that never ends. Nothing in the built code jumps here.

        nop
        nop
        nop

        -
        bra -

        jml -

        .databank 0

        ; 87/8017

    .endsection CodeChecksums878000Section

    .section Unsorted878017Section

      .al
      .xl

      rlWriteResetSignature ; 87/8017

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies 128 bytes of code from $88/8888 into aSpriteExtBuffer, so a later rlCheckResetSignature can tell the RAM was not cleared.

        ldx #$0000

        _801A
        lda rlUploadMapRowAndColumn._8880+8,x
        sta @l aSpriteExtBuffer,x
        inc x
        inc x
        cpx #$0080
        bne _801A

        _8029
        rtl

        .databank 0

        ; 87/802A

      rlCheckResetSignature ; 87/802A

        .al
        .xl
        .autsiz
        .databank ?

        ; Compares $88/8888-$88/8907 with aSpriteExtBuffer. If any word differs (a cold start), writes the signature and returns. If all match, writes the SRAM anti-tamper mark and hangs (rlShowAntiTamperScreen); _8063 is the hang used when the mark is already there (rlShowAntiTamperScreenAgain).

        ldx #$0000

        _802D
        lda rlUploadMapRowAndColumn._8880+8,x
        cmp @l aSpriteExtBuffer,x
        bne rlWriteResetSignature._8029
        inc x
        inc x
        cpx #$0080
        bne _802D

        _803E
        jsl rlWriteResetSignature
        lda #$0000
        sta @l $001FFC
        sta @l $001FFE
        jsl rlGetAntiTamperMark
        cmp #SRAM_ANTI_TAMPER_MARK
        beq _8063
        lda #SRAM_ANTI_TAMPER_MARK
        jsl rlSetAntiTamperMark
        jsl rlShowAntiTamperScreen

        _8061
        bra _8061


        _8063
        lda #$0000
        sta @l $001FFC
        sta @l $001FFE
        jsl rlShowAntiTamperScreenAgain

        _8072
        bra _8072

        .databank 0

        ; 87/8074

      rlCheckCodeChecksumsAtReset ; 87/8074

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        ; Runs rlCheckResetSignature, then, if the checks are on, adds up $80/8D56-8E2C and compares the sum with aCodeChecksumsCopy87; a mismatch hangs, a match clears the anti-tamper mark.

        phb
        php
        phk
        plb
        .databank $87
        phx
        jsl rlCheckResetSignature
        lda @l aCodeChecksumsCopy87.ChecksEnabled
        beq _809B
        lda #$0000
        ldx #<>rlReset

        _8089
        clc
        adc $800000,x
        inc x
        inc x
        cpx #<>rlColdResetClearMemory
        bcc _8089
        cmp @l aCodeChecksumsCopy87.Bank80Sum
        bne _80A6

        _809B
        lda #$0000
        jsl rlSetAntiTamperMark
        plx
        plp
        plb
        .databank ?
        rtl


        _80A6
        jsl rlCheckResetSignature._8063

        .databank 0

        ; 87/80AA

    .endsection Unsorted878017Section

    .section Table888000Section

      .al
      .xl

      aCodeChecksumsCopy88 .structCodeChecksums $AA24, $B66C, $5349 ; 88/8000

      rsCodeChecksumTrap88 ; 88/8006

        .al
        .xl
        .autsiz
        .databank ?

        ; A loop that never ends. Nothing in the built code jumps here.

        nop
        nop
        nop

        -
        bra -

        jml -

        .databank 0

      rlCheckCodeChecksumsCopy88 ; 88/800F

        .al
        .xl
        .autsiz
        .databank ?

        ; Another copy of the code checksum check (include/Checksums.h), with its
        ; sums in aCodeChecksumsCopy88. The save menu screen calls it (bank $91,
        ; twice) and rsStartChapterMap calls into its middle (._806A). When a sum
        ; does not match, it calls $878063 and the routines below.

        pha
        lda aCodeChecksumsCopy88.ChecksEnabled
        bne _8018
        pla
        rtl


        _8018
        pla
        phb
        php
        phk
        plb
        .databank $88
        phx
        lda #$0000
        ldx #<>rlReset

        _8024
        clc
        adc $800000,x
        inc x
        inc x
        cpx #<>rlColdResetClearMemory
        bcc _8024
        cmp @l aCodeChecksumsCopy88.Bank80Sum
        bne _8066
        lda #$0000
        ldx #<>rlWriteResetSignature

        _803C
        clc
        adc $870000,x
        inc x
        inc x
        cpx #<>rlInitMapMenus
        bcc _803C
        cmp @l aCodeChecksumsCopy88.Bank87Sum
        bne _8066
        lda aCodeChecksumsCopy87.Bank80Sum
        cmp @l aCodeChecksumsCopy88.Bank80Sum
        bne _8066
        lda aCodeChecksumsCopy87.Bank87Sum
        cmp @l aCodeChecksumsCopy88.Bank87Sum
        bne _8066
        plx
        plp
        plb
        .databank ?
        rtl


        _8066
        jsl rlCheckResetSignature._8063

        _806A
        lda wCastleGridSlot,b
        bne _8075
        lda #$0001
        sta wCastleGridSlot,b

        _8075
        jsl rlLoadChapterMapLayout
        jsl rlResumeMapSpriteAnimation
        jsl rlResumeMapTileAnimation
        rtl

        .databank 0

        ; 88/8082

    .endsection Table888000Section

    .section Unsorted8F8000Section

      .al
      .xl

      aCodeChecksums .structCodeChecksums $AA24, $B66C, $5349 ; 8F/8000

      rlCheckCodeChecksums ; 8F/8006

        .al
        .autsiz
        .databank ?

        ; Adds up the words in $80/8D56-8E2C and $87/8017-80A9 and compares the
        ; sums with aCodeChecksums, and aCodeChecksums with its two copies.

        ; Output:
        ; Carry set if anything differs. Clear if they all match or the checks
        ; are turned off.

        phb
        php
        phk
        plb
        phx
        lda aCodeChecksums.ChecksEnabled
        beq _CLC

          lda #0
          ldx #<>rlReset

            -
            clc
            adc $800000,x
            inc x
            inc x
            cpx #<>rlColdResetClearMemory
            bcc -

          cmp aCodeChecksums.Bank80Sum
          bne _SEC

          lda #0
          ldx #<>rlWriteResetSignature

            -
            clc
            adc $870000,x
            inc x
            inc x
            cpx #<>rlInitMapMenus
            bcc -

          cmp aCodeChecksums.Bank87Sum
          bne _SEC

          lda aCodeChecksums.Bank80Sum
          cmp aCodeChecksumsCopy88.Bank80Sum
          bne _SEC

          cmp aCodeChecksumsCopy87.Bank80Sum
          bne _SEC

          lda aCodeChecksums.Bank87Sum
          cmp aCodeChecksumsCopy88.Bank87Sum
          bne _SEC

          cmp aCodeChecksumsCopy87.Bank87Sum
          bne _SEC

        _CLC
        plx
        plp
        plb
        clc
        rtl

        _SEC
        plx
        plp
        plb
        sec
        rtl

        .databank 0

    .endsection Unsorted8F8000Section


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
        lda #(`g4bppcSaveMenuWindowTiles)<<8
        sta lR18+1
        lda #<>g4bppcSaveMenuWindowTiles
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $0800, $80, $6000

        lda #(`gcAntiPiracyWarningTiles)<<8
        sta lR18+1
        lda #<>gcAntiPiracyWarningTiles
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
        lda #(`g4bppcSaveMenuWindowTiles)<<8
        sta lR18+1
        lda #<>g4bppcSaveMenuWindowTiles
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsl rlAppendDecompList
        jsl rlDMAByStruct

          .structDMAToVRAM aDecompressionBuffer, $0800, $80, $6000

        lda #(`gcAbnormalityWarningTiles)<<8
        sta lR18+1
        lda #<>gcAbnormalityWarningTiles
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


