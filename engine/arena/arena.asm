; The arena menu: rlArenaMenuRunStep runs the step in $0592 from
; aArenaMenuStepHandlers (fight or quit, the wager, continuing or leaving between
; rounds, changing weapons), with the menu text and the decompression DMA entries
; used when the arena screen is set up (by rlUnknown8AE2F8 in bank $8A). Bank $8A
; ($8A/E4B9-ECEF). The arena dialogue it shows ($8A/D088-D60D) is not built yet.

    .section ArenaMenuSection

      .al
      .xl

      aUnknown8AE4B9 ; 8A/E4B9

        .byte $00


      aUnknown8AE4BA ; 8A/E4BA

        ; Read as a zero word (with the next byte) by a fixed-source DMA that clears VRAM.
        .byte $00


      aUnknown8AE4BB ; 8A/E4BB

        ; Entry for rlHandleMapMenuDecompressionDMA, as aUnknown80E53D.
        .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $4000


      aUnknown8AE4C3 ; 8A/E4C3

        ; Entry for rlHandleMapMenuDecompressionDMA, as aUnknown80E53D.
        .structDecompressionDMAEntry gcUnknownD306D6, $1000, $0000


      aUnknown8AE4CB ; 8A/E4CB

        ; Entry for rlHandleMapMenuDecompressionDMA, as aUnknown80E53D.
        .structDecompressionDMAEntry gcUnknownD46691, $0800, $2800


      aUnknown8AE4D3 ; 8A/E4D3

        ; Entry for rlHandleMapMenuDecompressionDMA, as aUnknown80E53D.
        .structDecompressionDMAEntry gcUnknownD467EF, $0800, $2C00


      rlArenaMenuRunStep ; 8A/E4DB

        ; Nothing in the build reaches this. Copies the BG3 tilemap to VRAM, runs
        ; the arena menu step in $0592 from aArenaMenuStepHandlers, then redraws.

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8A
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        lda $0592,b
        asl a
        tax
        jsr (aArenaMenuStepHandlers,x)
        lda #$0008
        sta wR0
        lda #$0008
        sta wR1
        ldx #$0000
        jsr rsUnknown8A950E
        lda $7F7670
        beq _E50D
        jsr rsUnknown8AAF0A

        _E50D
        plp
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/E510

      aArenaMenuStepHandlers ; 8A/E510

        .word <>rsUnknown8AE530, <>rsUnknown8AE673, <>rsUnknown8AE593, <>rsUnknown8AE647, <>rsUnknown8AE68E, <>rsUnknown8AE7B7, <>rsUnknown8AE7DF, <>rsUnknown8AE832, <>rsUnknown8AE917, <>rsUnknown8AEA64, <>rsUnknown8AEA7F, <>rsUnknown8AEB92, <>rsUnknown8AEBB7, <>rsUnknown8AEBD1, <>rsUnknown8AECBF, <>rsUnknown8AECE0


      rsUnknown8AE530 ; 8A/E530

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 0 (aArenaMenuStepHandlers).

        stz $0AD7,b
        jsl rlGetSelectedUnitArenaLevel
        cmp #$0007
        bcs _E56E
        lda #$000F
        tax
        lda aShopDialoguePointers+1,x
        sta lR18+1
        lda aShopDialoguePointers,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0004
        sta $0594,b

        _E565
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rts


        _E56E
        lda #$8A00
        sta lR18+1
        lda #$D53C
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$000E
        sta $0594,b
        bra _E565

        .databank 0

        ; 8A/E593

      rsUnknown8AE593 ; 8A/E593

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 2 (aArenaMenuStepHandlers).

        jsl rlUnknown84B550
        cmp #$0001
        beq _E5E7
        cmp #$0002
        beq _E5E3
        jsl rlUnknown84B57A
        stz $0AD7,b
        sta aDialogue.wNumber1,b
        jsr _E63C
        jsl rlGetSelectedUnitArenaLevel
        cmp #$0007
        bcs _E617
        lda #$8A00
        sta lR18+1
        lda #$D574
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0005
        sta $0592,b
        lda #$0007
        sta $0594,b

        _E5DA
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rts


        _E5E3
        jml $8AE647


        _E5E7
        jsl rlUnknown84B57A
        jsl rlGetSelectedUnitCharacterID
        sta aDialogue.wUnit1,b
        lda #$8A00
        sta lR18+1
        lda #$D553
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$000F
        sta $0594,b
        bra _E5DA


        _E617
        lda #$8A00
        sta lR18+1
        lda #$D5C5
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0005
        sta $0592,b
        lda #$000E
        sta $0594,b
        bra _E5DA


        _E63C
        lda $0AD9,b
        ldx #$0646
        jsl rlUnknown8AB111
        rts

        .databank 0

        ; 8A/E647

      rsUnknown8AE647 ; 8A/E647

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 3 (aArenaMenuStepHandlers).

        lda #$8A00
        sta lR18+1
        lda #$D5A5
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0008
        sta $0594,b
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

        ; 8A/E673

      rsUnknown8AE673 ; 8A/E673

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 1 (aArenaMenuStepHandlers).

        lda aDialogue.wStatus,b
        beq _E687
        lda #$00E8
        sta wR0
        lda #$0036
        sta wR1
        jsl rlDisplayDialogueAPressArrows
        rts


        _E687
        lda $0594,b
        sta $0592,b
        rts

        .databank 0

        ; 8A/E68E

      rsUnknown8AE68E ; 8A/E68E

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 4 (aArenaMenuStepHandlers).

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aArenaFightQuitText)<<8
        sta lR18+1
        lda #<>aArenaFightQuitText
        sta lR18
        lda $18DD,b
        cmp #$0100
        beq _E6B8
        clc
        adc #$0120
        bra _E6BC


        _E6B8
        sec
        sbc #$0040

        _E6BC
        clc
        adc #$000B
        tax
        jsl rlDrawMenuTextLine
        stz $08A5,b
        stz $08A7,b
        lda #$8A00
        sta lR19+1
        lda #$D088
        sta lR19
        lda #$8A00
        sta lR20+1
        lda #$D08A
        sta lR20
        lda #$0002
        jsr rsUnknown8ACFBE
        lda #$0000
        jsl rlUnknown8AB043
        lda #$0000
        sta $7F7670
        lda wJoy1New
        cmp #$8000
        beq _E70D
        cmp #$0080
        bne _E70C
        lda $08A1,b
        cmp #$0000
        beq _E73E
        cmp #$0001
        beq _E70D

        _E70C
        rts


        _E70D
        lda #$000F
        tax
        lda aShopDialoguePointers+55,x
        sta lR18+1
        lda aShopDialoguePointers+54,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$000E
        sta $0594,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _E73E
        lda $08AB,b
        beq _E77B
        jsl rlGetSelectedUnitArenaLevel
        clc
        adc #$0001
        sta aDialogue.wNumber1,b
        lda #$8A00
        sta lR18+1
        lda #$D4D7
        sta lR18
        lda #$000C
        bra _E75D


        _E75D
        sta $0594,b
        lda #$0001
        sta $0592,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$000A
        jsl rlPlaySoundEffect
        rts


        _E77B
        lda #$8A00
        sta lR18+1
        lda #$D4E9
        sta lR18
        jml rsUnknown8AC1BC._C312

        .databank 0

        ; 8A/E789

      aArenaFightQuitText ; 8A/E789

        ; たたかう (fight), やめる (quit). The two bytes after it are unknown.

        .enc "SJIS"
        .text "たたかう　　　やめる　　　　　　　　　　　\n"
        .byte $58, $88


      rsUnknown8AE7B7 ; 8A/E7B7

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 5 (aArenaMenuStepHandlers).

        lda aDialogue.wStatus,b
        beq _E7D5
        bit #$4000
        bne _E7C7
        bit #$8000
        bne _E7C7
        rts


        _E7C7
        lda #$0006
        sta $0592,b
        lda #$000B
        jsl rlPlaySoundEffect
        rts


        _E7D5
        jsr rsUnknown8AA2ED
        lda $0594,b
        sta $0592,b
        rts

        .databank 0

        ; 8A/E7DF

      rsUnknown8AE7DF ; 8A/E7DF

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 6 (aArenaMenuStepHandlers).

        lda aDialogue.wStatus,b
        beq _E821
        lda #$00E8
        sta wR0
        lda #$0036
        sta wR1
        jsl rlDisplayDialogueAPressArrows
        lda $0AD9,b
        clc
        adc #$0064
        sta $0AD9,b
        jsl rlGetSelectedUnitMoney
        cmp $0AD9,b
        bcc _E810
        lda $0AD9,b
        ldx #$0646
        jsl rlUnknown8AB111
        rts


        _E810
        jsr rsUnknown8AA2ED
        lda #$0001
        sta $0592,b
        lda #$000C
        jsl rlPlaySoundEffect
        rts


        _E821
        jsr rsUnknown8AA2ED
        lda $0594,b
        sta $0592,b
        lda #$000C
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/E832

      rsUnknown8AE832 ; 8A/E832

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 7 (aArenaMenuStepHandlers).

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlDialogueFreeHDMA
        jsr $8AD092
        jsr $8AA46E
        lda #$0000
        jsl rlUnknown8AB043
        lda wJoy1New
        cmp #$8000
        beq _E8B3
        cmp #$0080
        bne _E86E
        lda $08A3,b
        cmp #$0000
        beq _E86F
        cmp #$0001
        beq _E8B3

        _E86E
        rts


        _E86F
        jsl rlGetSelectedUnitArenaLevel
        clc
        adc #$0001
        sta aDialogue.wNumber1,b
        lda $08AB,b
        beq _E8DE
        jsl rlGetSelectedUnitEquippedWeaponBitfield
        cmp #$0000
        beq _E8EC
        lda #$8A00
        sta lR18+1
        lda #$D4BC
        sta lR18
        lda #$0009
        sta $0594,b
        lda #$0001
        sta $0592,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$000A
        jsl rlPlaySoundEffect
        rts


        _E8B3
        lda #$8A00
        sta lR18+1
        lda #$D5B7
        sta lR18
        lda #$000E
        sta $0594,b
        lda #$0001
        sta $0592,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _E8DE
        lda #$8A00
        sta lR18+1
        lda #$D4E9
        sta lR18
        jml rsUnknown8AC1BC._C312


        _E8EC
        lda #$8A00
        sta lR18+1
        lda #$D4D7
        sta lR18
        lda #$000C
        sta $0594,b
        lda #$0001
        sta $0592,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$000A
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/E917

      rsUnknown8AE917 ; 8A/E917

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 8 (aArenaMenuStepHandlers).

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr $8AADF4
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aArenaLeaveContinueChangeWeaponText)<<8
        sta lR18+1
        lda #<>aArenaLeaveContinueChangeWeaponText
        sta lR18
        lda $18DD,b
        cmp #$0100
        beq _E956
        clc
        adc #$0120
        bra _E95A


        _E956
        sec
        sbc #$0040

        _E95A
        clc
        adc #$000B
        tax
        jsl rlDrawMenuTextLine
        lda #$8A00
        sta lR19+1
        lda #$D08C
        sta lR19
        lda #$8A00
        sta lR20+1
        lda #$D08F
        sta lR20
        lda #$0003
        jsr rsUnknown8ACFBE
        lda #$0000
        jsl rlUnknown8AB043
        lda #$0000
        sta $7F7670
        lda wJoy1New
        cmp #$8000
        beq _E9DB
        cmp #$0080
        bne _E9A9
        lda $08A1,b
        cmp #$0000
        beq _E9DB
        cmp #$0001
        beq _E9AA
        cmp #$0002
        beq _EA06

        _E9A9
        rts


        _E9AA
        lda $08AB,b
        beq _E9CD
        jsl rlGetSelectedUnitEquippedWeaponBitfield
        cmp #$0000
        beq _EA06
        lda #$0000
        sta $7F7670
        lda #$0081
        jsl rlPlaySoundEffect
        lda #$000B
        sta $0592,b
        rts


        _E9CD
        lda #$8A00
        sta lR18+1
        lda #$D4E9
        sta lR18
        jml rsUnknown8AC1BC._C312


        _E9DB
        lda #$8A00
        sta lR18+1
        lda #$D5B7
        sta lR18
        lda #$000E
        sta $0594,b
        lda #$0001
        sta $0592,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _EA06
        lda $08AB,b
        beq _E9CD
        lda #$0002
        sta $08A1,b
        lda #$8A00
        sta lR18+1
        lda #$D4D7
        sta lR18
        lda #$000C
        sta $0594,b
        lda #$0001
        sta $0592,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$000A
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/EA3C

      aArenaLeaveContinueChangeWeaponText ; 8A/EA3C

        ; りだつ (leave), けいぞく (continue), ぶきもちかえ (change weapon).

        .enc "SJIS"
        .text "りだつ　　　けいぞく　　　ぶきもちかえ\n"


      rsUnknown8AEA64 ; 8A/EA64

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 9 (aArenaMenuStepHandlers).

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr $8AADF4
        lda #$000A
        sta $0592,b

        .databank 0

        ; 8A/EA7F

      rsUnknown8AEA7F ; 8A/EA7F

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 10 (aArenaMenuStepHandlers).

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$B6AD
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aArenaStartQuitChangeWeaponText)<<8
        sta lR18+1
        lda #<>aArenaStartQuitChangeWeaponText
        sta lR18
        jsr $8AD0B8
        lda #$8A00
        sta lR19+1
        lda #$D08C
        sta lR19
        lda #$8A00
        sta lR20+1
        lda #$D08F
        sta lR20
        lda #$0003
        jsr rsUnknown8ACFBE
        lda #$0000
        jsl rlUnknown8AB043
        lda #$0000
        sta $7F7670
        lda wJoy1New
        cmp #$8000
        beq _EAE5
        cmp #$0080
        bne _EAE4
        lda $08A1,b
        cmp #$0000
        beq _EB16
        cmp #$0001
        beq _EAE5
        cmp #$0002
        beq _EB2B

        _EAE4
        rts


        _EAE5
        lda #$000F
        tax
        lda aShopDialoguePointers+55,x
        sta lR18+1
        lda aShopDialoguePointers+54,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$000E
        sta $0594,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _EB16
        lda #$0000
        sta $7F7670
        lda #$0081
        jsl rlPlaySoundEffect
        lda #$000B
        sta $0592,b
        rts


        _EB2B
        lda #$8A00
        sta lR18+1
        lda #$D4D7
        sta lR18
        lda #$000C
        sta $0594,b
        lda #$0001
        sta $0592,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$000A
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/EB56

      aArenaStartQuitChangeWeaponText ; 8A/EB56

        ; かいし (start), やめる (quit), ぶきもちかえ (change weapon).

        .enc "SJIS"
        .text "かいし　　　やめる　　　　ぶきもちかえ\n"

      aArenaStartQuitText ; 8A/EB7E

        .text "かいし　　　やめる\n"


      rsUnknown8AEB92 ; 8A/EB92

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 11 (aArenaMenuStepHandlers).

        lda wVBlankEnabledFramecount
        and #$0003
        bne _EBA3
        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _EBA6
        dec bBufferINIDISP

        _EBA3
        rep #$20
        rts


        _EBA6
        .as
        rep #$20
        jsl rlGetSelectedUnitMoney
        sta $0AD9,b
        inc $0AD7,b
        jsl rlUnknown84B508
        rts

        .databank 0

        ; 8A/EBB7

      rsUnknown8AEBB7 ; 8A/EBB7

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 12 (aArenaMenuStepHandlers).

        lda #$FFFF
        sta $7F7670
        jsr $8AA63D
        jsr rsUnknown8AA8C9
        jsr rsUnknown8AAD44
        jsr rsUnknown8AA9CE
        lda #$000D
        sta $0592,b
        rts

        .databank 0

        ; 8A/EBD1

      rsUnknown8AEBD1 ; 8A/EBD1

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 13 (aArenaMenuStepHandlers).

        jsr rsUnknown8AA8C9
        lda $08A5,b
        tax
        lda #$004C
        sta wR0
        lda $8A9DD5,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0000
        jsl rlUnknown8AB043
        jsr $8AA400
        lda wJoy1New
        cmp #$0080
        beq _EC01
        cmp #$8000
        beq _EC69
        rts


        _EC01
        lda $08A7,b
        asl a
        tax
        lda $7F8072,x
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _EC68
        lda wRoutineVariable1,b
        sta wSelectedInventorySlot,b
        jsl rlUnknown84B321
        jsr rsUnknown8AA830
        jsr rsUnknown8AAD44
        lda #$0000
        sta $7F7670
        lda #$000A
        jsl rlPlaySoundEffect
        lda #$8A00
        sta lR18+1
        lda #$D4BC
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        stz $08A1,b
        lda #$0009
        sta $0594,b
        lda $0AD7,b
        beq _EC68
        jsl rlUnknown84B550
        cmp #$0002
        beq _ECB2

        _EC68
        rts


        _EC69
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$8A00
        sta lR18+1
        lda #$D60D
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsUnknown8ACE54
        lda #$0001
        sta $0592,b
        lda #$0004
        sta $0594,b
        jsr rsUnknown8AA830
        jsr rsUnknown8AAD44
        lda #$0000
        sta $7F7670
        stz $08A1,b
        lda $0AD7,b
        beq _EC68
        jsl rlUnknown84B550
        cmp #$0002
        beq _ECB2
        rts


        _ECB2
        lda #$0001
        sta $08A1,b
        lda #$0008
        sta $0594,b
        rts

        .databank 0

        ; 8A/ECBF

      rsUnknown8AECBF ; 8A/ECBF

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 14 (aArenaMenuStepHandlers).

        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0015
        sta wGameStateStep,b
        jsl rlUnknown84B550
        cmp #$0002
        bne _ECDF
        lda $0AD7,b
        beq _ECDF
        jsl rlUnknown84B57A

        _ECDF
        rts

        .databank 0

        ; 8A/ECE0

      rsUnknown8AECE0 ; 8A/ECE0

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 15 (aArenaMenuStepHandlers).

        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0015
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/ECEF

    .endsection ArenaMenuSection
