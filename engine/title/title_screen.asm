; TODO: describe this file.

    .section TitleScreenVBlankSection

      .al
      .xl

      rsRunTitleScreenVBlank ; 80/BFA9

        .al
        .xl
        .autsiz
        .databank ?

        ; Map battle VBlank calling 95C368/96D5DB/9BEAB1, DMA/OAM/HDMA/PPU, APU, sprites, sound

        php
        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlUnknown95C368
        jsl rlUnknown96D5DB
        jsl rlUnknown9BEAB1
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlSendSoundQueuesToAPU
        jsl rlGetJoypadInput
        jsl rlUnknown82E147
        jsl rlClearSpriteExtBuffer
        sep #$20
        lda #$00
        sta $7FE1CF
        rep #$20
        jsl rlRunGameStateRoutines
        jsl rlRunVBlankHooks
        jsl rlHideSprites
        jsl rlUpdateSound
        plp
        rts

        .databank 0

        ; 80/BFFB

    .endsection TitleScreenVBlankSection


    .section OpenTitleScreenSection

      .al
      .xl

      rsOpenTitleScreen ; 80/C0B6

        .al
        .xl
        .autsiz
        .databank ?

        ; Resets engines/map battle (game state $1A), installs rsRunTitleScreenVBlank and rsRunTitleScreenMainLoop

        php
        lda #$0000
        bra +

      rsOpenTitleScreenWithoutIntro ; 80/C0BC

        .al
        .xl
        .autsiz
        .databank ?

        ; The same with $7FD8B9 = 1, which bank $9B tests to skip parts of the setup. Entered from procDemoSkipFadeOut at the end of the attract mode's opening.

        php
        lda #$0001

        +
        sep #$20
        sta $7FD8B9
        rep #$20
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsl rlTitleScreenIsStartHeld
        bcc _C0E7
        sep #$20
        lda #$01
        sta $7FD8B9
        rep #$20

        _C0E7
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlUnknown95EE73
        jsl rlUnknown95F0E9
        lda #(`aUnknown9680A4)<<8
        sta lR44+1
        lda #<>aUnknown9680A4
        sta lR44
        jsl rlUnknown82E0C6
        lda #(`aUnknown9680B3)<<8
        sta lR44+1
        lda #<>aUnknown9680B3
        sta lR44
        jsl rlUnknown82E0C6
        jsl rlUnknown82E08D
        lda #GAMESTATE_TITLE_SCREEN_SETUP
        sta wGameStateRoutine1,b
        lda #<>rsRunTitleScreenVBlank
        sta wVBlankPointer
        lda #<>rsRunTitleScreenMainLoop
        sta wMainLoopPointer
        stz wGameStateRoutine2,b
        jsl rlEnableVBlank
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        plp
        cli
        rts

        .databank 0

        ; 80/C144

    .endsection OpenTitleScreenSection


    .section TitleScreenMainLoopSection

      .al
      .xl

      rsRunTitleScreenMainLoop ; 80/C155

        .al
        .xl
        .autsiz
        .databank ?

        ; Map battle main loop: reset check, decompression list, deferred sound upload

        jsl rlButtonCombinationResetCheck
        jsl rlDecompressByList
        jsl rlRunDeferredSoundUpload
        rts

        .databank 0

        ; 80/C162

    .endsection TitleScreenMainLoopSection


    .section TitleScreenIRQSection

      .al
      .xl

      aUnknown9680A4 ; 96/80A4
        .word $0060, $0006, <>rlUnknown9680AC, <>aUnknown9680B1

    .endsection TitleScreenIRQSection


    .section Unsorted95EE73Section

      .al
      .xl

      rlUnknown95EE73 ; 95/EE73

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>gcUnknownF55B0E
        stx DecompressionVariables
        lda #`gcUnknownF55B0E
        sta $CA
        ldx #$0000
        stx $CB
        lda #$7F
        sta $CD
        rep #$30
        jsl rlDecompressor
        sep #$20
        rep #$10
        ldx #<>gcUnknown94E9EE
        stx DecompressionVariables
        lda #`gcUnknown94E9EE
        sta $CA
        ldx #$4000
        stx $CB
        lda #$7F
        sta $CD
        rep #$30
        jsl rlDecompressor
        sep #$20
        rep #$10
        ldx #<>gcUnknownF57599
        stx DecompressionVariables
        lda #`gcUnknownF57599
        sta $CA
        ldx #$6000
        stx $CB
        lda #$7F
        sta $CD
        rep #$30
        jsl rlDecompressor
        sep #$20
        rep #$10
        ldx #<>gcUnknownF5597A
        stx DecompressionVariables
        lda #`gcUnknownF5597A
        sta $CA
        ldx #$6800
        stx $CB
        lda #$7F
        sta $CD
        rep #$30
        jsl rlDecompressor
        ldx #$0000

        _EEE6
        lda $7F6000,x
        sta $7F7800,x
        inc x
        inc x
        cpx #$0800
        bcc _EEE6
        lda $7F6000
        sta $7F7BFA
        sta $7F7BFC
        ldx #$0000

        _EF04
        sta $7F7D80,x
        inc x
        inc x
        cpx #$00C0
        bcc _EF04
        ldx #$0000

        _EF12
        sta $7F7EA0,x
        inc x
        inc x
        cpx #$001A
        bcc _EF12
        sep #$20
        rep #$10
        ldx #<>gcUnknown9CBFA1
        stx DecompressionVariables
        lda #`gcUnknown9CBFA1
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        ldx #$0000

        _EF3C
        lda $7E8C2A,x
        sta $7F6700,x
        lda $7E8C4A,x
        sta $7F6720,x
        inc x
        inc x
        cpx #$001E
        bcc _EF3C
        rtl

        .databank 0

        ; 95/EF54

    .endsection Unsorted95EE73Section


    .section Unsorted95EF54Section

      .al
      .xl

      rlUnknown95EF54 ; 95/EF54

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>gcUnknownF57765
        stx DecompressionVariables
        lda #`gcUnknownF57765
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0B00, $80, $A200

        sep #$20
        rep #$10
        ldx #<>gcUnknownF57B55
        stx DecompressionVariables
        lda #`gcUnknownF57B55
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $1000, $80, $B000

        sep #$20
        rep #$10
        ldx #<>gcUnknownF57C2D
        stx DecompressionVariables
        lda #`gcUnknownF57C2D
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $1800

        sep #$20
        rep #$10
        ldx #<>gcUnknown9C8000
        stx DecompressionVariables
        lda #`gcUnknown9C8000
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $4000, $80, $4000

        sep #$20
        rep #$10
        ldx #<>gcUnknown9CBBB7
        stx DecompressionVariables
        lda #`gcUnknown9CBBB7
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $0000

        sep #$20
        rep #$10
        ldx #<>gcUnknownF57E44
        stx DecompressionVariables
        lda #`gcUnknownF57E44
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $2C80, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $2200, $80, $8000

        jsl rlDMAByStruct

          .structDMAToVRAM $7F4000, $2000, $80, $2000

        jsl rlDMAByStruct

          .structDMAToVRAM $7F6000, $0800, $80, $F800

        jsl rlDMAByStruct

          .structDMAToVRAM $7F6800, $0800, $80, $1000

        ldx #$0000

        _F081
        lda aUnknownE026C3,x
        sta $0162,b,x
        lda aUnknownE026E1,x
        sta $0122,b,x
        lda aUnknownE026FF,x
        sta $0142,b,x
        lda aUnknownE0271D,x
        sta $0242,b,x
        lda aUnknownE02769,x
        sta $0282,b,x
        lda aUnknownE02667,x
        lsr a
        and #$3DEF
        sta $01E2,b,x
        inc x
        inc x
        cpx #$001E
        bcc _F081
        ldx #$0000

        _F0B9
        lda aUnknownE02759,x
        sta $0182,b,x
        inc x
        inc x
        cpx #$0012
        bcc _F0B9
        ldx #$0000

        _F0CA
        lda $7F6700,x
        sta $01A2,b,x
        lda $7F6720,x
        sta $01C2,b,x
        inc x
        inc x
        cpx #$001E
        bcc _F0CA
        stz aBGPaletteBuffer.aPalette2,b
        stz aBGPaletteBuffer.aPalette3,b
        stz aBGPaletteBuffer.aPalette4,b
        rtl

        .databank 0

        ; 95/F0E9

    .endsection Unsorted95EF54Section


    .section Unsorted95F0E9Section

      .al
      .xl

      rlUnknown95F0E9 ; 95/F0E9

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$11
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferTMW
        lda #$00
        sta bBufferTSW
        lda #$04
        sta bBufferBG12NBA
        lda #$03
        sta bBufferOBSEL
        lda #$09
        sta bBufferBGMODE
        lda #$00
        sta bBufferMOSAIC
        lda #$68
        sta bBufferBG1SC
        lda #$6C
        sta bBufferBG2SC
        rep #$20
        lda #$0000
        sta wBufferBG1HOFS
        lda #$0000
        sta wBufferBG1VOFS
        lda #$0000
        sta wBufferBG2HOFS
        lda #$0000
        sta wBufferBG2VOFS
        rtl

        .databank 0

        ; 95/F12A

    .endsection Unsorted95F0E9Section


    .section Unsorted95F12ASection

      .al
      .xl

      rlUnknown95F12A ; 95/F12A

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 95/F12B

      rlTitleScreenIsStartPressed ; 95/F12B

        .al
        .xl
        .autsiz
        .databank ?

        lda wMusicID,b
        bne _F13A
        lda wJoy1New
        bit #$1000
        beq _F13A
        sec
        bra _F13B


        _F13A
        clc

        _F13B
        rtl

        .databank 0

        ; 95/F13C

      rlTitleScreenIsStartHeld ; 95/F13C

        .al
        .xl
        .autsiz
        .databank ?

        lda wMusicID,b
        bne _F14B
        lda wJoy1Input
        bit #$1000
        beq _F14B
        sec
        bra _F14C


        _F14B
        clc

        _F14C
        rtl

        .databank 0

        ; 95/F14D

      rlUnknown95F14D ; 95/F14D

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phy
        lda $7FE18A
        beq _F1A6
        lda $7FE18F
        tay
        lda $7FE18C
        sta lR18
        lda $7FE18D
        sta lR18+1
        lda #$0800
        cmp $7FE18A
        bcc _F180
        lda $7FE18A
        jsl rlUnknown95C43E
        lda #$0000
        sta $7FE18A
        bra _F1A6


        _F180
        pha
        jsl rlUnknown95C43E
        lda $7FE18A
        sec
        sbc #1,s
        sta $7FE18A
        lda $7FE18C
        clc
        adc #1,s
        sta $7FE18C
        pla
        lsr a
        clc
        adc $7FE18F
        sta $7FE18F

        _F1A6
        ply
        pla
        rtl

        .databank 0

        ; 95/F1A9

      rlUnknown95F1A9 ; 95/F1A9

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD08B
        lda #$9700
        sta $7FD08D
        lda #$F19B
        sta $7FD08C
        rtl

        .databank 0

        ; 95/F1BF

      rlUnknown95F1BF ; 95/F1BF

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD08B
        lda #$9700
        sta $7FD08D
        lda #$F45A
        sta $7FD08C
        rtl

        .databank 0

        ; 95/F1D5

      rlUnknown95F1D5 ; 95/F1D5

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $7FD08B
        and #$00FF
        beq _F246
        lda $7FD08C
        sta lR18
        lda $7FD08D
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$0000
        beq _F204
        cmp #$0001
        beq _F225
        cmp #$0002
        beq _F227
        bra _F246


        _F204
        jsl rlUnknown95F256
        bcs _F246
        lda $7FD08C
        clc
        adc #$000B
        sta $7FD08C
        sep #$20
        lda $7FD08B
        dec a
        sta $7FD08B
        rep #$20
        bra _F246


        _F225
        bra _F246


        _F227
        jsl rlUnknown95F29B
        bcs _F246
        lda $7FD08C
        clc
        adc #$0008
        sta $7FD08C
        sep #$20
        lda $7FD08B
        dec a
        sta $7FD08B
        rep #$20

        _F246
        ply
        rtl

        .databank 0

        ; 95/F248

    .endsection Unsorted95F12ASection


    .section Unsorted95F248Section

      .al
      .xl

      rlUnknown95F248 ; 95/F248

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FD08B
        inc a
        sta $7FD08B
        rep #$20
        rtl

        .databank 0

        ; 95/F256

    .endsection Unsorted95F248Section


    .section Unsorted95F256Section

      .al
      .xl

      rlUnknown95F256 ; 95/F256

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FECF4
        and #$00FF
        sec
        bne _F298
        ldy #$0001
        ldx #$0000

        _F268
        lda [lR18],y
        sta $7FECF5,x
        inc y
        inc y
        inc x
        inc x
        cpx #$000A
        bne _F268
        lda $7FECF5
        sta lR18
        lda $7FECF7
        sta lR18+2
        lda $7FECF9
        sta lR19+1
        jsl rlAppendDecompList
        sep #$20
        lda #$01
        sta $7FECF4
        rep #$20
        clc

        _F298
        ply
        plx
        rtl

        .databank 0

        ; 95/F29B

      rlUnknown95F29B ; 95/F29B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FECF4
        and #$00FF
        sec
        bne _F2E2
        ldy #$0001
        ldx #$0000
        sep #$20

        _F2AF
        lda [lR18],y
        sta $7FECF8,x
        inc y
        inc x
        cpx #$0007
        bne _F2AF
        rep #$20
        lda $7FECF9
        sta lR18+1
        lda $7FECF8
        sta lR18
        lda $7FECFB
        tay
        lda $7FECFD
        jsl rlUnknown95C4E3
        sep #$20
        lda #$02
        sta $7FECF4
        rep #$20
        clc

        _F2E2
        ply
        plx
        rtl

        .databank 0

        ; 95/F2E5

    .endsection Unsorted95F256Section


    .section Unsorted95F741Section

      .al
      .xl

      rlUnknown95F741 ; 95/F741

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FEC1D
        sta $7FEC41
        sta aUnit2DataBuffer._ROM.Skills1
        sta $7FEC50
        lda #$08
        sta $7FEC65
        lda #$C0
        sta $7FEC66
        rep #$20
        lda #$0000
        sta aUnit2DataBuffer._Inventory.ItemCount
        sta aUnit2DataBuffer._Inventory.Items
        sta $7FEC5A
        sta $7FEC5C
        rtl

        .databank 0

        ; 95/F777

    .endsection Unsorted95F741Section


    .section Unsorted95F7F7Section

      .al
      .xl

      rlUnknown95F7F7 ; 95/F7F7

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FED5C
        sta $7FED64
        sta $7FED6E
        sta $7FED8A
        sta $7FED5D
        sta $7FED65
        sta $7FED63
        sta $7FED6B
        lda #$30
        sta $7FED6C
        lda #$7F
        sta $7FED6D
        rep #$20
        lda #$00FF
        sta $7FE51B
        rtl

        .databank 0

        ; 95/F831

    .endsection Unsorted95F7F7Section


    .section Unsorted95F87FSection

      .al
      .xl

      rlUnknown95F87F ; 95/F87F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F883
        sep #$20
        lda #$00
        sta $7FD08F,x
        rep #$20
        txa
        clc
        adc #$0062
        tax
        cpx #$04FA
        bcc _F883
        plx
        rtl

        .databank 0

        ; 95/F89A

      rlUnknown95F89A ; 95/F89A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F89E
        lda $7FD08F,x
        bit #$0080
        beq _F8AF
        jsl rlUnknown95F8BC
        jsl rlUnknown9BEAE8

        _F8AF
        txa
        clc
        adc #$0062
        tax
        cpx #$04FA
        bcc _F89E
        plx
        rtl

        .databank 0

        ; 95/F8BC

      rlUnknown95F8BC ; 95/F8BC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FD09A,x
        and #$00FF
        beq _F8D2
        sep #$20
        dec a
        sta $7FD09A,x
        rep #$20
        bra _F91D


        _F8D2
        lda $7FD094,x
        sta lR18
        lda $7FD095,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        cmp #$0080
        bne _F901
        lda [lR18],y
        xba
        and #$00FF
        asl a
        pha
        lda $7FD094,x
        sec
        sbc #1,s
        sta $7FD094,x
        pla
        bra _F8D2


        _F901
        sep #$20
        dec a
        sta $7FD099,x
        inc y
        lda [lR18],y
        sta $7FD09A,x
        rep #$20
        lda $7FD094,x
        clc
        adc #$0002
        sta $7FD094,x

        _F91D
        lda $7FD095,x
        sta lR18+1
        lda $7FD097,x
        sta lR18
        lda $7FD099,x
        and #$00FF
        asl a
        tay
        lda [lR18],y
        clc
        adc $7FD097,x
        tay
        lda $7FD090,x
        sta wR0
        lda $7FD092,x
        sta wR1
        lda $7FD09B,x
        sta wR5
        lda $7FD09D,x
        sta wR4
        sep #$20
        phb
        lda $7FD096,x
        pha
        plb
        .databank ?
        rep #$20
        phx
        jsl rlPushToOAMBuffer
        plx
        plb
        .databank ?
        ply
        plx
        rtl

        .databank 0

        ; 95/F967

      rlUnknown95F967 ; 95/F967

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldy #$0000
        lda [lR18],y
        sta $7FD094,x
        inc y
        inc y
        sep #$20
        lda [lR18],y
        sta $7FD096,x
        inc y
        lda #$80
        sta $7FD08F,x
        lda #$00
        sta $7FD09A,x
        rep #$20
        lda [lR18],y
        sta $7FD097,x
        inc y
        inc y
        lda [lR18],y
        sta $7FD090,x
        inc y
        inc y
        lda [lR18],y
        sta $7FD092,x
        inc y
        inc y
        lda [lR18],y
        sta $7FD09D,x
        inc y
        inc y
        lda [lR18],y
        sta $7FD09B,x
        ply
        plx
        rtl

        .databank 0

        ; 95/F9B4

    .endsection Unsorted95F87FSection


    .section Unsorted9680ACSection

      .al
      .xl

      rlUnknown9680AC ; 96/80AC

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9BEEB4
        rtl

        .databank 0

        ; 96/80B1

    .endsection Unsorted9680ACSection


    .section Table9680B1Section

      .al
      .xl

      aUnknown9680B1 ; 96/80B1
        .word <>rsIRQCodeHalt

      aUnknown9680B3 ; 96/80B3
        .word $0060, $00BD, <>rlUnknown9680BB, $80C0

    .endsection Table9680B1Section


    .section Unsorted9680BBSection

      .al
      .xl

      rlUnknown9680BB ; 96/80BB

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9BEF88
        rtl

        .databank 0

        ; 96/80C0


      aUnknown9680C0 ; 96/80C0
        .word <>rsIRQCodeHalt

    .endsection Unsorted9680BBSection


    .section Unsorted9BDC24Section

      .al
      .xl

      rlTitleScreenSetup ; 9B/DC24

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $1A, once: blanks the screen, resets procs and HDMA, sets up the map battle (bank $95/$9B helpers) and moves on to $1B. Selected by rsOpenTitleScreen.

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlProcEngineResetProcEngine
        jsl rlResetTitleTimeline
        jsl rlResetHDMAEngine
        jsl rlUnknown95F1A9
        jsl rlBattleSceneScriptClearLoading
        jsl rlUnknown95EA47
        jsl rlUnknown9BF3F3
        jsl rlUnknown96D659
        jsl rlUnknown95F741
        jsl rlUnknown95F7F7
        jsl rlUnknown95F87F
        jsl rlUnknown9BEAA5
        lda #$0000
        sta $7FE09E
        lda $7FD8B9
        and #$00FF
        bne _DCA7
        jsl rlUnknown9BFB7E
        jsl rlStepMusicScript
        lda #$0000
        sep #$20
        sta $7FD000
        lda #$00
        sta $7FD8B5
        sta $7FD075
        sta $7FD8B7
        lda $7FD8BA
        ora #$08
        sta $7FD8BA
        stz $0CC4,b
        rep #$20
        stz $0CC7,b

        _DCA0
        inc wGameStateRoutine1,b
        stz wGameStateStep,b
        rtl


        _DCA7
        jsl rlTitleScreenSkipIntro
        jsl rlTitleScreenShowTitle
        sep #$20
        stz $0CC4,b
        rep #$20
        stz $0CC7,b
        bra _DCA0

        .databank 0

        ; 9B/DCBB

      rlTitleScreenStep ; 9B/DCBB

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $1B, every frame: runs one of three map battle phases by $7FD000 (0, 1, other) and counts frames in $7FD001 and $7FE09E.

        sep #$20
        lda $7FD075
        beq _DCC7
        lda #$80
        bra _DCC9


        _DCC7
        lda bBufferINIDISP

        _DCC9
        sta $2100,b
        rep #$20
        lda $7FD000
        and #$00FF
        cmp #$0000
        beq _DCE5
        cmp #$0001
        beq _DCEB
        jsl rlTitleScreenRunFadeOut
        bra _DCEF


        _DCE5
        jsl rlTitleScreenRunIntro
        bra _DCEF


        _DCEB
        jsl rlTitleScreenRunTitle

        _DCEF
        lda $7FD001
        inc a
        sta $7FD001
        lda $7FE09E
        inc a
        sta $7FE09E
        rtl

        .databank 0

        ; 9B/DD02

      rlTitleScreenRunIntro ; 9B/DD02

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD8BA
        bit #$0004
        bne _DD4C
        lda $7FD8B9
        and #$00FF
        bne _DD46
        lda $7FD8BA
        bit #$0001
        beq _DD29
        sep #$20
        and #$FE
        sta $7FD8BA
        rep #$20
        bra _DD46


        _DD29
        jsl rlTitleScreenIsStartHeld
        bcc _DD62
        lda #$000A
        jsl rlPlaySoundEffect
        sep #$20
        lda $7FD8BA
        ora #$01
        sta $7FD8BA
        rep #$20
        bra _DD62


        _DD46
        jsl rlTitleScreenSkipIntro
        bra _DD99


        _DD4C
        lda bDecompressionArrayFlag,b
        and #$00FF
        bne _DD99
        lda bAPUUploading,b
        and #$00FF
        bne _DD99
        jsl rlTitleScreenShowTitle
        bra _DD99


        _DD62
        jsl rlUnknown9BE184
        jsr rsRunTitleTimeline
        jsr rsRunTitleTimelineSlots
        jsl rlUnknown95F1D5
        jsl rlBattleSceneScriptUpdateLoading
        jsl rlUnknown95F14D
        jsl rlUnknown96D695
        jsl rlUnknown96CB44
        jsl rlUnknown96A532
        jsl rlUnknown95F89A
        jsl rlUnknown9BF179
        lda $7FD8B5
        and #$00FF
        beq _DD99
        jsl rlStartOpeningEvent

        _DD99
        rtl

        .databank 0

        ; 9B/DD9A

      rlTitleScreenRunTitle ; 9B/DD9A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD8BA
        bit #$0002
        beq _DDAD
        jsl rlTitleScreenIsStartPressed
        bcc _DDAD
        jsl rlTitleScreenStartFadeOut

        _DDAD
        jsl rlUnknown9BE184
        jsr rsRunTitleTimeline
        jsr rsRunTitleTimelineSlots
        jsl rlUnknown95F1D5
        jsl rlBattleSceneScriptUpdateLoading
        jsl rlUnknown95F14D
        jsl rlUnknown96D695
        jsl rlUnknown96A532
        jsl rlUnknown96CB44
        jsl rlUnknown95F89A
        lda $7FD8B5
        and #$00FF
        beq _DDE2
        jsl rlStartOpeningEvent
        bra _DDE2


        _DDE2
        rtl

        .databank 0

        ; 9B/DDE3

      rlTitleScreenRunFadeOut ; 9B/DDE3

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9BE184
        jsr rsRunTitleTimeline
        jsr rsRunTitleTimelineSlots
        jsl rlUnknown95F1D5
        jsl rlBattleSceneScriptUpdateLoading
        jsl rlUnknown95F14D
        jsl rlUnknown96D695
        jsl rlUnknown95F89A
        lda $7FD8B5
        and #$00FF
        beq _DE11
        stz wGameStateRoutine1,b
        jsl rlReturnToFileMenu

        _DE11
        rtl

        .databank 0

        ; 9B/DE12

      rlTitleScreenSkipIntro ; 9B/DE12

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlResetHDMAEngine
        jsl rlUnknown95F87F
        jsl rlUnknown96D659
        jsl rlResetIRQEngine
        lda #$0000
        sta $7FE18A
        sep #$20
        sta $7FECF4
        sta $7FD08B
        sta $7FD075
        rep #$20
        jsl rlResetTitleTimeline
        lda #$9700
        sta $7FD004
        lda #$F12D
        sta $7FD003
        jsl rlUnknown95F1A9
        sep #$20
        lda $7FD8BA
        ora #$04
        sta $7FD8BA
        rep #$20
        rtl

        .databank 0

        ; 9B/DE69

      rlTitleScreenShowTitle ; 9B/DE69

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDisableVBlank
        sep #$20
        lda #$01
        sta $7FD000
        rep #$20
        jsl rlUnknown95EF54
        jsl rlUnknown95F12A
        ldx #$0000
        lda #(`aUnknown99FEAC)<<8
        sta lR18+1
        lda #<>aUnknown99FEAC
        sta lR18
        jsl rlUnknown95F967
        jsl rlUnknown9BFD71
        jsl rsUnknown9BFD8C
        jsl rsUnknown9BFD99
        jsl rsUnknown9BFDA6
        jsl rsUnknown9BFDB3
        jsl rlUnknown9BFDC0
        jsl rlUnknown9BFDD2
        jsl rlUnknown9BFDDF
        jsl rlUnknown9BFDEC
        jsl rlUnknown9BFDF9
        jsl rlUnknown9BFE06
        lda #(`aUnknown9BDF09)<<8
        sta lR18+1
        lda #<>aUnknown9BDF09
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #$0000
        sta wBufferBG1HOFS
        sta wBufferBG1VOFS
        sta wBufferBG2HOFS
        lda #$0020
        sta wBufferBG2VOFS
        sep #$20
        lda #$E0
        sta $2132,b
        lda #$00
        sta $7FD075
        rep #$20
        lda #$0000
        sta aBGPaletteBuffer,b
        jsl rlUnknown9BEAA5
        jsl rlUnknown9BFBA9
        jsl rlStepMusicScript
        jsl rlEnableVBlank
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 9B/DF09

    .endsection Unsorted9BDC24Section


    .section Table9BDF09Section

      .al
      .xl

      aUnknown9BDF09 ; 9B/DF09

        WRITE_RAM_BYTE bBufferBGMODE, $09
        WRITE_RAM_BYTE bBufferBG12NBA, $24
        WRITE_RAM_BYTE bBufferOBSEL, $03
        WRITE_RAM_BYTE bBufferBG1SC, $7C
        WRITE_RAM_BYTE bBufferBG2SC, $00
        WRITE_RAM_BYTE bBufferTM, $13
        WRITE_RAM_BYTE bBufferTS, $00
        WRITE_RAM_BYTE bBufferTMW, $00
        WRITE_RAM_BYTE bBufferTSW, $00
        WRITE_RAM_BYTE bBufferCOLDATA_0, $E0
        WRITE_RAM_BYTE bBufferCOLDATA_1, $00
        WRITE_RAM_BYTE bBufferCOLDATA_2, $00
        WRITE_RAM_BYTE bBufferCOLDATA_3, $00
        WRITE_RAM_BYTE bBufferCGADSUB, $00
        WRITE_RAM_END

      rlUnknown9BDF35 ; 9B/DF35

        .al
        .xl
        .autsiz
        .databank ?

        sei
        jsl rlDisableVBlank
        jsl rlUnknown9BF297
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlResetHDMAEngine
        sep #$20
        lda #$00
        sta $7FD000
        lda #$00
        sta $7FD8B5
        rep #$20
        jsl rlResetTitleTimeline
        lda #$9700
        sta $7FD004
        lda #$EC63
        sta $7FD003
        jsl rlUnknown95F1A9
        jsl rlBattleSceneScriptClearLoading
        jsl rlUnknown95EA47
        jsl rlUnknown96D659
        jsl rlUnknown95F87F
        jsl rlUnknown9BF2AA
        jsl rlEnableVBlank
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        sep #$20
        lda #$01
        sta $7FD075
        rep #$20
        cli
        rtl

        .databank 0

        ; 9B/DF9F

      rlEndTitleScreen ; 9B/DF9F

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$01
        sta $7FD8B5
        rep #$20
        rtl

        .databank 0

        ; 9B/DFAA

    .endsection Table9BDF09Section


    .section Unsorted9BDFAASection

      .al
      .xl

      rlStartOpeningEvent ; 9B/DFAA

        .al
        .xl
        .autsiz
        .databank ?

        ; Called from the map battle screen's loop when $7FD8B5 is set: blanks the screen, resets the battle screen's state and HDMA, and starts the attract mode's opening (aOpeningEvent).

        sei
        jsl rlDisableVBlank
        jsl rlUnknown9BF297
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlResetHDMAEngine
        sep #$20
        lda #$00
        sta $7FD000
        lda #$00
        sta $7FD8B5
        rep #$20
        jsl rlResetTitleTimeline
        lda #$9700
        sta $7FD004
        lda #$EC63
        sta $7FD003
        lda #(`aOpeningEvent)<<8
        sta lR18+1
        lda #<>aOpeningEvent
        sta lR18
        jsl rlStartEventScript
        rtl

        .databank 0

        ; 9B/DFF3

      rlTitleScreenStartFadeOut ; 9B/DFF3

        .al
        .xl
        .autsiz
        .databank ?

        lda #$001E
        jsl rlPlaySoundEffect
        jsl rlResetHDMAEngine
        jsl rlUnknown96D659
        jsl rlUnknown95F741
        jsl rlUnknown95F7F7
        lda #$0000
        sta $7FE18A
        sep #$20
        sta $7FECF4
        sta $7FD08B
        sta $7FD075
        lda #$02
        sta $7FD000
        lda #$00
        sta $7FD8B5
        rep #$20
        jsl rlResetTitleTimeline
        lda #$9700
        sta $7FD004
        lda #$F15D
        sta $7FD003
        jsl rlUnknown95F1BF
        ldx #$0000
        lda #(`aUnknown99FEAC)<<8
        sta lR18+1
        lda #<>aUnknown99FEAC
        sta lR18
        jsl rlUnknown95F967
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 9B/E05D

      rlResetTitleTimeline ; 9B/E05D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7FD001
        lda #$9700
        sta $7FD004
        lda #$EC63
        sta $7FD003
        ldx #$0000

        _E076
        lda #$0000
        sta $7FD006,x
        txa
        clc
        adc #$0004
        tax
        cpx #$0040
        bcc _E076
        plx
        rtl

        .databank 0

        ; 9B/E08A

      rsRunTitleTimeline ; 9B/E08A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FD003
        sta lR18
        lda $7FD004
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        cmp $7FD001
        beq _E0A5
        bcs _E0F3

        _E0A5
        inc y
        inc y

        _E0A7
        lda [lR18],y
        inc y
        and #$00FF
        cmp #$00FF
        beq _E0E9
        bit #$0080
        beq _E0BD
        jsl rlTitleTimelineCall
        bra _E0E7


        _E0BD
        sta wR10
        lda #$0004
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        sep #$20
        lda $7FD006,x
        ora #$01
        sta $7FD006,x
        lda [lR18],y
        inc y
        sta $7FD007,x
        rep #$20
        lda [lR18],y
        inc y
        inc y
        sta $7FD008,x

        _E0E7
        bra _E0A7


        _E0E9
        tya
        clc
        adc $7FD003
        sta $7FD003

        _E0F3
        ply
        plx
        rts

        .databank 0

        ; 9B/E0F6

      rlTitleTimelineCall ; 9B/E0F6

        .al
        .xl
        .autsiz
        .databank ?

        and #$007F
        sta wR0
        lda lR18
        pha
        lda lR18+1
        pha
        phb
        jsl _E109
        plb
        .databank ?
        bra _E121


        _E109
        lda [lR18],y
        inc y
        sta lR19
        lda [lR18],y
        inc y
        inc y
        sta lR19+1
        sep #$20
        lda lR19+2
        pha
        plb
        .databank ?
        rep #$20
        lda wR0
        jml [lR19]


        _E121
        pla
        sta lR18+1
        pla
        sta lR18
        rtl

        .databank 0

        ; 9B/E128

      rsRunTitleTimelineSlots ; 9B/E128

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _E12C
        lda $7FD006,x
        bit #$0001
        beq _E152
        phb
        jsl _E13D
        plb
        .databank ?
        bra _E152


        _E13D
        lda $7FD007,x
        sta lR18
        sep #$20
        lda $7FD009,x
        sta lR18+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR18]


        _E152
        txa
        clc
        adc #$0004
        tax
        cpx #$0040
        bcc _E12C
        plx
        rts

        .databank 0

        ; 9B/E15F

    .endsection Unsorted9BDFAASection


    .section Unsorted9BEAA5Section

      .al
      .xl

      rlUnknown9BEAA5 ; 9B/EAA5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD8A5
        sta $7FD8A8
        rtl

        .databank 0

        ; 9B/EAB1

    .endsection Unsorted9BEAA5Section


    .section Unsorted9BEAB1Section

      .al
      .xl

      rlUnknown9BEAB1 ; 9B/EAB1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _EAB5
        lda $7FD8A5,x
        cmp #$0000
        beq _EADB
        phb
        jsl _EAC6
        plb
        .databank ?
        bra _EADB


        _EAC6
        lda $7FD8A5,x
        sta lR18
        sep #$20
        lda $7FD8A7,x
        sta lR18+2
        pha
        plb
        .databank ?
        rep #$20
        jml [lR18]


        _EADB
        txa
        clc
        adc #$0003
        tax
        cpx #$0006
        bcc _EAB5
        plx
        rtl

        .databank 0

        ; 9B/EAE8

    .endsection Unsorted9BEAB1Section


    .section Unsorted9BEAE8Section

      .al
      .xl

      rlUnknown9BEAE8 ; 9B/EAE8

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FD08F,x
        bit #$0001
        bne _EAF6
        jml _EC6C


        _EAF6
        bit #$0002
        beq _EB03
        jsl rlUnknown9BEC6E
        jml _EC6C


        _EB03
        sep #$20
        lda $7FD0EF,x
        dec a
        and #$0F
        sta $7FD0EF,x
        rep #$20
        phx
        lda $7FD090,x
        pha
        lda $7FD092,x
        pha
        lda $7FD099,x
        pha
        lda $7FD0EF,x
        and #$00FF
        clc
        adc #7,s
        tax
        pla
        sep #$20
        sta $7FD0DF,x
        rep #$20
        lda #5,s
        tax
        lda $7FD0EF,x
        and #$00FF
        asl a
        clc
        adc #5,s
        tax
        pla
        sta $7FD0BF,x
        pla
        sta $7FD09F,x
        plx
        lda $7FD001
        bit #$0001
        beq _EB62
        bit #$0002
        bne _EBA3
        jml _EBE5


        _EB62
        phx
        lda $7FD0EF,x
        clc
        adc $7FD0F0,x
        dec a
        and #$000F
        clc
        adc #1,s
        tax
        lda $7FD0DF,x
        and #$00FF
        sta wR9
        lda #1,s
        tax
        lda $7FD0EF,x
        clc
        adc $7FD0F0,x
        dec a
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda $7FD09F,x
        sta wR0
        lda $7FD0BF,x
        sta wR1
        plx
        jml _EC33


        _EBA3
        phx
        lda $7FD0F0,x
        asl a
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        clc
        adc #1,s
        tax
        sep #$20
        lda $7FD0DF,x
        sta wR9
        rep #$20
        lda #1,s
        tax
        lda $7FD0F0,x
        asl a
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda $7FD09F,x
        sta wR0
        lda $7FD0BF,x
        sta wR1
        plx
        bra _EC33


        _EBE5
        phx
        lda $7FD0F0,x
        pha
        asl a
        clc
        adc #1,s
        sta #1,s
        pla
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        clc
        adc #1,s
        tax
        sep #$20
        lda $7FD0DF,x
        sta wR9
        rep #$20
        lda #1,s
        tax
        lda $7FD0F0,x
        pha
        asl a
        clc
        adc #1,s
        sta #1,s
        pla
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda $7FD09F,x
        sta wR0
        lda $7FD0BF,x
        sta wR1
        plx

        _EC33
        lda $7FD095,x
        sta lR18+1
        lda $7FD097,x
        sta lR18
        lda wR9
        and #$00FF
        asl a
        tay
        lda [lR18],y
        clc
        adc $7FD097,x
        tay
        lda $7FD09B,x
        sta wR5
        lda $7FD09D,x
        sta wR4
        sep #$20
        phb
        lda $7FD096,x
        pha
        plb
        .databank ?
        rep #$20
        phx
        jsl rlPushToOAMBuffer
        plx
        plb
        .databank ?

        _EC6C
        plx
        rtl

        .databank 0

        ; 9B/EC6E

      rlUnknown9BEC6E ; 9B/EC6E

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda $7FD0EF,x
        dec a
        and #$0F
        sta $7FD0EF,x
        rep #$20
        phx
        lda $7FD090,x
        pha
        lda $7FD092,x
        pha
        lda $7FD0FB,x
        pha
        lda $7FD0EF,x
        and #$00FF
        clc
        adc #7,s
        tax
        pla
        sep #$20
        sta $7FD0DF,x
        rep #$20
        lda #5,s
        tax
        lda $7FD0EF,x
        and #$00FF
        asl a
        clc
        adc #5,s
        tax
        pla
        sta $7FD0BF,x
        pla
        sta $7FD09F,x
        plx
        phx
        lda $7FD0EF,x
        clc
        adc $7FD0F0,x
        dec a
        and #$000F
        clc
        adc #1,s
        tax
        lda $7FD0DF,x
        and #$00FF
        sta wR9
        lda #1,s
        tax
        lda $7FD0EF,x
        clc
        adc $7FD0F0,x
        dec a
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda $7FD09F,x
        sta wR0
        lda $7FD0BF,x
        sta wR1
        plx
        jsr rsUnknown9BED9D
        lda $7FD001
        bit #$0001
        bne _ED4A
        phx
        lda $7FD0F0,x
        asl a
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        clc
        adc #1,s
        tax
        sep #$20
        lda $7FD0DF,x
        sta wR9
        rep #$20
        lda #1,s
        tax
        lda $7FD0F0,x
        asl a
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda $7FD09F,x
        sta wR0
        lda $7FD0BF,x
        sta wR1
        plx
        jsr rsUnknown9BED9D
        bra _ED9B


        _ED4A
        phx
        lda $7FD0F0,x
        pha
        asl a
        clc
        adc #1,s
        sta #1,s
        pla
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        clc
        adc #1,s
        tax
        sep #$20
        lda $7FD0DF,x
        sta wR9
        rep #$20
        lda #1,s
        tax
        lda $7FD0F0,x
        pha
        asl a
        clc
        adc #1,s
        sta #1,s
        pla
        dec a
        clc
        adc $7FD0EF,x
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda $7FD09F,x
        sta wR0
        lda $7FD0BF,x
        sta wR1
        plx
        jsr rsUnknown9BED9D

        _ED9B
        plx
        rtl

        .databank 0

        ; 9B/ED9D

      rsUnknown9BED9D ; 9B/ED9D

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD095,x
        sta lR18+1
        lda $7FD097,x
        sta lR18
        lda wR9
        and #$00FF
        asl a
        tay
        lda [lR18],y
        clc
        adc $7FD097,x
        tay
        lda $7FD0FD,x
        sta wR5
        lda $7FD0FF,x
        sta wR4
        sep #$20
        phb
        lda $7FD096,x
        pha
        plb
        .databank ?
        rep #$20
        phx
        jsl rlPushToOAMBuffer
        plx
        plb
        .databank ?
        rts

        .databank 0

        ; 9B/EDD7

    .endsection Unsorted9BEAE8Section


    .section Unsorted9BEDD7Section

      .al
      .xl

      rlUnknown9BEDD7 ; 9B/EDD7

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        sta $7FD0F0,x
        lda $7FD08F,x
        ora #$01
        sta $7FD08F,x
        rep #$20
        lda $7FD090,x
        sta $7FD09F,x
        sta $7FD0A1,x
        sta $7FD0A3,x
        sta $7FD0A5,x
        sta $7FD0A7,x
        sta $7FD0A9,x
        sta $7FD0AB,x
        sta $7FD0AD,x
        sta $7FD0AF,x
        sta $7FD0B1,x
        sta $7FD0B3,x
        sta $7FD0B5,x
        sta $7FD0B7,x
        sta $7FD0B9,x
        sta $7FD0BB,x
        sta $7FD0BD,x
        lda $7FD092,x
        sta $7FD0BF,x
        sta $7FD0C1,x
        sta $7FD0C3,x
        sta $7FD0C5,x
        sta $7FD0C7,x
        sta $7FD0C9,x
        sta $7FD0CB,x
        sta $7FD0CD,x
        sta $7FD0CF,x
        sta $7FD0D1,x
        sta $7FD0D3,x
        sta $7FD0D5,x
        sta $7FD0D7,x
        sta $7FD0D9,x
        sta $7FD0DB,x
        sta $7FD0DD,x
        sep #$20
        lda #$00
        sta $7FD0EF,x
        lda $7FD099,x
        xba
        lda $7FD099,x
        rep #$20
        sta $7FD0DF,x
        sta $7FD0E1,x
        sta $7FD0E3,x
        sta $7FD0E5,x
        sta $7FD0E7,x
        sta $7FD0E9,x
        sta $7FD0EB,x
        sta $7FD0ED,x
        rtl

        .databank 0

        ; 9B/EEA5

      rlUnknown9BEEA5 ; 9B/EEA5

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FD08F,x
        and #$FE
        sta $7FD08F,x
        rep #$20
        rtl

        .databank 0

        ; 9B/EEB4

    .endsection Unsorted9BEDD7Section


    .section Unsorted9BEEB4Section

      .al
      .xl

      rlUnknown9BEEB4 ; 9B/EEB4

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FD075
        bne _EEC0
        jml _EF85


        _EEC0
        lda $4212,b
        bit #$40
        beq _EEC0
        lda #$80
        sta $2100,b

        _EECC
        lda $4212,b
        bit #$40
        bne _EECC

        _EED3
        lda $4212,b
        bit #$40
        beq _EED3
        lda #$00
        sta $2100,b

        _EEDF
        lda $4212,b
        bit #$40
        bne _EEDF

        _EEE6
        lda $4212,b
        bit #$40
        beq _EEE6
        lda $7FD8B4
        sta $2100,b

        _EEF4
        lda $4212,b
        bit #$40
        bne _EEF4

        _EEFB
        lda $4212,b
        bit #$40
        beq _EEFB
        lda $7FD8B2
        sta $2100,b

        _EF09
        lda $4212,b
        bit #$40
        bne _EF09

        _EF10
        lda $4212,b
        bit #$40
        beq _EF10
        lda $7FD8B1
        sta $2100,b

        _EF1E
        lda $4212,b
        bit #$40
        bne _EF1E

        _EF25
        lda $4212,b
        bit #$40
        beq _EF25
        lda $7FD8B0
        sta $2100,b

        _EF33
        lda $4212,b
        bit #$40
        bne _EF33

        _EF3A
        lda $4212,b
        bit #$40
        beq _EF3A
        lda $7FD8AF
        sta $2100,b

        _EF48
        lda $4212,b
        bit #$40
        bne _EF48

        _EF4F
        lda $4212,b
        bit #$40
        beq _EF4F
        lda $7FD8AE
        sta $2100,b

        _EF5D
        lda $4212,b
        bit #$40
        bne _EF5D

        _EF64
        lda $4212,b
        bit #$40
        beq _EF64
        lda $7FD8AD
        sta $2100,b

        _EF72
        lda $4212,b
        bit #$40
        bne _EF72

        _EF79
        lda $4212,b
        bit #$40
        beq _EF79
        lda bBufferINIDISP
        sta $2100,b

        _EF85
        rep #$20
        rtl

        .databank 0

        ; 9B/EF88

      rlUnknown9BEF88 ; 9B/EF88

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FD075
        bne _EF94
        jml _F09C


        _EF94
        lda $4212,b
        bit #$40
        beq _EF94
        lda $7FD8AD
        sta $2100,b

        _EFA2
        lda $4212,b
        bit #$40
        bne _EFA2

        _EFA9
        lda $4212,b
        bit #$40
        beq _EFA9
        lda $7FD8AE
        sta $2100,b

        _EFB7
        lda $4212,b
        bit #$40
        bne _EFB7

        _EFBE
        lda $4212,b
        bit #$40
        beq _EFBE
        lda $7FD8AF
        sta $2100,b

        _EFCC
        lda $4212,b
        bit #$40
        bne _EFCC

        _EFD3
        lda $4212,b
        bit #$40
        beq _EFD3
        lda $7FD8B0
        sta $2100,b

        _EFE1
        lda $4212,b
        bit #$40
        bne _EFE1

        _EFE8
        lda $4212,b
        bit #$40
        beq _EFE8
        lda $7FD8B1
        sta $2100,b

        _EFF6
        lda $4212,b
        bit #$40
        bne _EFF6

        _EFFD
        lda $4212,b
        bit #$40
        beq _EFFD
        lda $7FD8B2
        sta $2100,b

        _F00B
        lda $4212,b
        bit #$40
        bne _F00B

        _F012
        lda $4212,b
        bit #$40
        beq _F012
        lda $7FD8B3
        sta $2100,b

        _F020
        lda $4212,b
        bit #$40
        bne _F020

        _F027
        lda $4212,b
        bit #$40
        beq _F027
        lda $7FD8B4
        sta $2100,b

        _F035
        lda $4212,b
        bit #$40
        bne _F035

        _F03C
        lda $4212,b
        bit #$40
        beq _F03C
        lda #$80
        sta $2100,b
        lda #$00
        sta $420C,b
        lda #$01
        sta $212C,b
        lda #$00
        sta $212D,b
        lda #$01
        sta $2105,b
        lda #$7C
        sta $2107,b
        lda #$07
        sta $210B,b
        stz $210E,b
        stz $210E,b
        lda $7FD8AC
        sta $210D,b
        stz $210D,b
        stz $2123,b
        stz $2121,b
        stz $2122,b
        stz $2122,b
        lda #$E0
        sta $2132,b

        _F087
        lda $4212,b
        bit #$40
        bne _F087

        _F08E
        lda $4212,b
        bit #$40
        beq _F08E
        lda $7FD073
        sta $2100,b

        _F09C
        rep #$20
        rtl

        .databank 0

        ; 9B/F09F

      rlUnknown9BF09F ; 9B/F09F

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD050
        sep #$20
        lda #$00
        sta $7FD073
        rep #$20
        jsl rlUnknown9BF0C3
        lda #$9B00
        sta $7FD008,x
        lda #$F0C3
        sta $7FD007,x
        rtl

        .databank 0

        ; 9B/F0C3

      rlUnknown9BF0C3 ; 9B/F0C3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FD050
        bne _F0EB
        sep #$20
        lda $7FD073
        cmp #$0F
        beq _F0DD
        inc a
        sta $7FD073
        rep #$20
        bra _F0EB


        _F0DD
        .as
        rep #$20
        sep #$20
        lda #$00
        sta $7FD006,x
        rep #$20
        bra _F0FC


        _F0EB
        lda $7FD050
        inc a
        cmp #$0003
        bcc _F0F8
        lda #$0000

        _F0F8
        sta $7FD050

        _F0FC
        plx
        rtl

        .databank 0

        ; 9B/F0FE

      rlUnknown9BF0FE ; 9B/F0FE

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD050
        jsl rlUnknown9BF118
        lda #$9B00
        sta $7FD008,x
        lda #$F118
        sta $7FD007,x
        rtl

        .databank 0

        ; 9B/F118

      rlUnknown9BF118 ; 9B/F118

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FD050
        bne _F146
        sep #$20
        lda $7FD073
        cmp #$00
        beq _F132
        dec a
        sta $7FD073
        rep #$20
        bra _F146


        _F132
        .as
        lda #$80
        sta $7FD073
        rep #$20
        sep #$20
        lda #$00
        sta $7FD006,x
        rep #$20
        bra _F157


        _F146
        lda $7FD050
        inc a
        cmp #$0003
        bcc _F153
        lda #$0000

        _F153
        sta $7FD050

        _F157
        plx
        rtl

        .databank 0

        ; 9B/F159

      rlUnknown9BF159 ; 9B/F159

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FD8AB
        and #$00FF
        tax
        sep #$20
        lda aUnknown99FFE7,x
        sta $7FD8AC
        lda $7FD8AB
        inc a
        sta $7FD8AB
        rep #$20
        plx
        rtl

        .databank 0

        ; 9B/F179

    .endsection Unsorted9BEEB4Section


    .section Unsorted9BF179Section

      .al
      .xl

      rlUnknown9BF179 ; 9B/F179

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferINIDISP
        bit #$80
        beq _F1A3
        sta $7FD8AD
        sta $7FD8AE
        sta $7FD8AF
        sta $7FD8B0
        sta $7FD8B1
        sta $7FD8B2
        sta $7FD8B3
        sta $7FD8B4
        bra _F1F1


        _F1A3
        dec a
        dec a
        bpl _F1A9
        lda #$00

        _F1A9
        sta $7FD8AD
        dec a
        dec a
        bpl _F1B3
        lda #$00

        _F1B3
        sta $7FD8AE
        dec a
        dec a
        bpl _F1BD
        lda #$00

        _F1BD
        sta $7FD8AF
        dec a
        dec a
        bpl _F1C7
        lda #$00

        _F1C7
        sta $7FD8B0
        dec a
        dec a
        bpl _F1D1
        lda #$00

        _F1D1
        sta $7FD8B1
        dec a
        dec a
        bpl _F1DB
        lda #$00

        _F1DB
        sta $7FD8B2
        dec a
        bpl _F1E4
        lda #$00

        _F1E4
        sta $7FD8B3
        dec a
        bpl _F1ED
        lda #$00

        _F1ED
        sta $7FD8B4

        _F1F1
        rep #$20
        rtl

        .databank 0

        ; 9B/F1F4

    .endsection Unsorted9BF179Section


    .section Unsorted9BF297Section

      .al
      .xl

      rlUnknown9BF297 ; 9B/F297

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _F299
        lda $4212,b
        bit #$80
        bne _F299

        _F2A0
        lda $4212,b
        bit #$80
        beq _F2A0
        rep #$20
        rtl

        .databank 0

        ; 9B/F2AA

    .endsection Unsorted9BF297Section


    .section Unsorted9BF2AASection

      .al
      .xl

      rlUnknown9BF2AA ; 9B/F2AA

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20

        _F2AC
        lda $4212,b
        bit #$80
        beq _F2AC

        _F2B3
        lda $4212,b
        bit #$80
        bne _F2B3
        rep #$20
        rtl

        .databank 0

        ; 9B/F2BD

      rlUnknown9BF2BD ; 9B/F2BD

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FD075
        rep #$20
        rtl

        .databank 0

        ; 9B/F2C8

      rlUnknown9BF2C8 ; 9B/F2C8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F2CC
        lda $01E2,b,x
        lsr a
        and #$3DEF
        sta $7FF636,x
        inc x
        inc x
        cpx #$001E
        bcc _F2CC
        lda #(`aUnknown99FDDD)<<8
        sta lR18+1
        lda #<>aUnknown99FDDD
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        plx
        rtl

        .databank 0

        ; 9B/F2F3

      rlUnknown9BF2F3 ; 9B/F2F3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aUnknown99FDE5)<<8
        sta lR18+1
        lda #<>aUnknown99FDE5
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        plx
        rtl

        .databank 0

        ; 9B/F309

      rlUnknown9BF309 ; 9B/F309

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aUnknown99FDEA)<<8
        sta lR18+1
        lda #<>aUnknown99FDEA
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        lda #(`aUnknown99FDF1)<<8
        sta lR18+1
        lda #<>aUnknown99FDF1
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        plx
        rtl

        .databank 0

        ; 9B/F332

      rlUnknown9BF332 ; 9B/F332

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #(`aUnknown99FE92)<<8
        sta lR18+1
        lda #<>aUnknown99FE92
        sta lR18
        jsl rlUnknown95F967
        ldx #$0062
        lda #(`aUnknown99FE9F)<<8
        sta lR18+1
        lda #<>aUnknown99FE9F
        sta lR18
        jsl rlUnknown95F967
        lda #$0000
        sta $7FD05D
        lda #1,s
        tax
        lda #$9B00
        sta $7FD008,x
        lda #<>rlUnknown9BF36F
        sta $7FD007,x
        plx
        rtl

        .databank 0

        ; 9B/F36F

      rlUnknown9BF36F ; 9B/F36F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$0004
        jsl rlUnknown9BEDD7
        sep #$20
        lda $7FD08F
        ora #$02
        sta $7FD08F
        lda #$00
        sta $7FD0F1
        rep #$20
        lda #1,s
        tax
        jsl rlUnknown9BF3A5
        lda #(`rlUnknown9BF3A5)<<8
        sta $7FD008,x
        lda #<>rlUnknown9BF3A5
        sta $7FD007,x
        plx
        rtl

        .databank 0

        ; 9B/F3A5

      rlUnknown9BF3A5 ; 9B/F3A5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FD05D
        tax
        lda aUnknown99FEAC+156,x
        and #$00FF
        cmp #$0080
        beq _F3E4
        pha
        lda aUnknown99FEAC+157,x
        and #$00FF
        pha
        lda $7FD090
        clc
        adc #3,s
        sta $7FD090
        lda $7FD092
        clc
        adc #1,s
        sta $7FD092
        pla
        pla
        lda $7FD05D
        inc a
        inc a
        sta $7FD05D
        bra _F3F1


        _F3E4
        lda #1,s
        tax
        sep #$20
        lda #$00
        sta $7FD006,x
        rep #$20

        _F3F1
        plx
        rtl

        .databank 0

        ; 9B/F3F3

    .endsection Unsorted9BF2AASection


    .section Unsorted9BFC8DSection

      .al
      .xl

      rlFlashToTitleScreen ; 9B/FC8D

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD000
        and #$00FF
        cmp #$0001
        beq _FCB9
        cmp #$0002
        beq _FCC4
        cmp #$0003
        beq _FCE4
        cmp #$0004
        beq _FD18
        cmp #$0005
        beq _FD28
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        jml _FD43


        _FCB9
        lda wMusicID,b
        beq _FCC2
        jml _FD50


        _FCC2
        bra _FD43


        _FCC4
        sep #$20
        lda #$10
        sta bBufferTS
        lda #$02
        sta bBufferCGWSEL
        lda #$01
        sta bBufferCGADSUB
        rep #$20
        lda #$0028
        sta $7FD046
        lda #$0084
        jsl rlPlaySoundEffect
        bra _FD43


        _FCE4
        lda $7FD001
        inc a
        sta $7FD001
        cmp #$0023
        bcc _FD01
        sep #$20
        stz bBufferTS
        rep #$20
        lda #$0000
        sta $7FD001
        bra _FD43


        _FD01
        lda $7FD046
        sta wR0
        jsr rsUnknown9BFD52
        lda $7FD046
        clc
        adc #$0005
        sta $7FD046
        bra _FD50


        _FD18
        lda $7FD001
        inc a
        sta $7FD001
        cmp #$0028
        bcs _FD43
        bra _FD50


        _FD28
        lda bBufferINIDISP
        and #$00FF
        beq _FD38
        sep #$20
        dec a
        sta bBufferINIDISP
        rep #$20
        bra _FD50


        _FD38
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        sec
        bra _FD51


        _FD43
        sep #$20
        lda $7FD000
        inc a
        sta $7FD000
        rep #$20

        _FD50
        clc

        _FD51
        rtl

        .databank 0

        ; 9B/FD52

      rsUnknown9BFD52 ; 9B/FD52

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        phb
        sep #$20
        lda #$99
        pha
        plb
        .databank $99
        rep #$20
        lda #$0070
        sta wR1
        stz wR4
        stz wR5
        ldy #$FF6D
        jsl rlPushToOAMBuffer
        plb
        .databank $99
        ply
        plx
        rts

        .databank 0

        ; 9B/FD71

    .endsection Unsorted9BFC8DSection


