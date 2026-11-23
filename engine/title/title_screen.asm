; The title screen (game states $1A/$1B): how it is opened (rsOpenTitleScreen,
; rsOpenTitleScreenWithoutIntro, from the end of the attract mode's opening),
; its VBlank, main loop and IRQs, the three phases its step runs (the intro,
; the title, the fade out), and the engines the phases share: the timeline
; interpreter (rsRunTitleTimeline, include/TitleScreen.h), the load list, the
; title sprites with their afterimages, the VBlank routines, the edge fade and
; the caption strip. What the timelines call is in title_scenes.asm, the
; timelines themselves in title_timelines.asm. See docs/reference/title.md.

    .section TitleScreenVBlankSection

      .al
      .xl

      rsRunTitleScreenVBlank ; 80/BFA9

        .al
        .xl
        .autsiz
        .databank ?

        ; The title screen's VBlank: the battle scene's VBlank helpers (rlBattleSceneRunUploads, rlUnknown96D5DB),
        ; rlRunTitleVBlankRoutines, then DMA, OAM, HDMA, PPU registers, sound, input and the game state.

        php
        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlBattleSceneRunUploads
        jsl rlUnknown96D5DB
        jsl rlRunTitleVBlankRoutines
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

        ; Opens the title screen with its intro: resets the engines, decompresses the title's graphics,
        ; sets its IRQs (aTitleScreenTopIRQ, aTitleScreenBottomIRQ) and game state $1A, and installs
        ; rsRunTitleScreenVBlank and rsRunTitleScreenMainLoop. Holding Start skips the intro too.

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
        sta bTitleScreenSkipIntro
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
        sta bTitleScreenSkipIntro
        rep #$20

        _C0E7
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlDecompressTitleGraphics
        jsl rlSetTitleScreenRegisters
        lda #(`aTitleScreenTopIRQ)<<8
        sta lR44+1
        lda #<>aTitleScreenTopIRQ
        sta lR44
        jsl rlUnknown82E0C6
        lda #(`aTitleScreenBottomIRQ)<<8
        sta lR44+1
        lda #<>aTitleScreenBottomIRQ
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

        ; The title screen's main loop: reset check, decompression list, deferred sound upload.

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

      aTitleScreenTopIRQ ; 96/80A4
        .word $0060, $0006, <>rlTitleScreenTopIRQ, <>aUnknown9680B1

    .endsection TitleScreenIRQSection


    .section Unsorted95EE73Section

      .al
      .xl

      rlDecompressTitleGraphics ; 95/EE73

        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses the title's graphics into $7F0000-$7F7FFF and its palettes into $7F6700 (rsOpenTitleScreen).

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

      rlLoadTitleGraphics ; 95/EF54

        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses more title graphics, uploads them and those rlDecompressTitleGraphics left in $7F0000 to VRAM, and sets the title's palettes (rlTitleScreenShowTitle).

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

      rlSetTitleScreenRegisters ; 95/F0E9

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
        lda wBattleSceneLargeUploadSize
        beq _F1A6
        lda wBattleSceneLargeUploadVRAM
        tay
        lda lBattleSceneLargeUploadSource
        sta lR18
        lda lBattleSceneLargeUploadSource+1
        sta lR18+1
        lda #$0800
        cmp wBattleSceneLargeUploadSize
        bcc _F180
        lda wBattleSceneLargeUploadSize
        jsl rlBattleSceneQueueUpload
        lda #$0000
        sta wBattleSceneLargeUploadSize
        bra _F1A6


        _F180
        pha
        jsl rlBattleSceneQueueUpload
        lda wBattleSceneLargeUploadSize
        sec
        sbc #1,s
        sta wBattleSceneLargeUploadSize
        lda lBattleSceneLargeUploadSource
        clc
        adc #1,s
        sta lBattleSceneLargeUploadSource
        pla
        lsr a
        clc
        adc wBattleSceneLargeUploadVRAM
        sta wBattleSceneLargeUploadVRAM

        _F1A6
        ply
        pla
        rtl

        .databank 0

        ; 95/F1A9

      rlStartTitleLoadList ; 95/F1A9

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta bTitleLoadRequests
        lda #(`aTitleLoadList)<<8
        sta lTitleLoadListPosition+1
        lda #<>aTitleLoadList
        sta lTitleLoadListPosition
        rtl

        .databank 0

        ; 95/F1BF

      rlStartTitleFadeOutLoadList ; 95/F1BF

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta bTitleLoadRequests
        lda #(`aTitleFadeOutLoadList)<<8
        sta lTitleLoadListPosition+1
        lda #<>aTitleFadeOutLoadList
        sta lTitleLoadListPosition
        rtl

        .databank 0

        ; 95/F1D5

      rlRunTitleLoadList ; 95/F1D5

        .al
        .xl
        .autsiz
        .databank ?

        ; Each frame: while bTitleLoadRequests is not 0, starts the next entry of the load list (type 0 a decompression, rlStartTitleLoadDecompression; type 2 a copy, rlStartTitleLoadCopy) once the one before has finished.

        phy
        lda bTitleLoadRequests
        and #$00FF
        beq _F246
        lda lTitleLoadListPosition
        sta lR18
        lda lTitleLoadListPosition+1
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
        jsl rlStartTitleLoadDecompression
        bcs _F246
        lda lTitleLoadListPosition
        clc
        adc #$000B
        sta lTitleLoadListPosition
        sep #$20
        lda bTitleLoadRequests
        dec a
        sta bTitleLoadRequests
        rep #$20
        bra _F246


        _F225
        bra _F246


        _F227
        jsl rlStartTitleLoadCopy
        bcs _F246
        lda lTitleLoadListPosition
        clc
        adc #$0008
        sta lTitleLoadListPosition
        sep #$20
        lda bTitleLoadRequests
        dec a
        sta bTitleLoadRequests
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

      rlAllowTitleLoad ; 95/F248

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Lets rlRunTitleLoadList start one more entry (the timelines call it, CALL 2).

        sep #$20
        lda bTitleLoadRequests
        inc a
        sta bTitleLoadRequests
        rep #$20
        rtl

        .databank 0

        ; 95/F256

    .endsection Unsorted95F248Section


    .section Unsorted95F256Section

      .al
      .xl

      rlStartTitleLoadDecompression ; 95/F256

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

      rlStartTitleLoadCopy ; 95/F29B

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
        jsl rlBattleSceneStartLargeUpload
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

      rlClearTitleSprites ; 95/F87F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F883
        sep #$20
        lda #$00
        sta aTitleSprites.Flags,x
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

      rlUpdateTitleSprites ; 95/F89A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F89E
        lda aTitleSprites.Flags,x
        bit #$0080
        beq _F8AF
        jsl rlAnimateAndDrawTitleSprite
        jsl rlDrawTitleSpriteAfterimage

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

      rlAnimateAndDrawTitleSprite ; 95/F8BC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda aTitleSprites.Timer,x
        and #$00FF
        beq _F8D2
        sep #$20
        dec a
        sta aTitleSprites.Timer,x
        rep #$20
        bra _F91D


        _F8D2
        lda aTitleSprites.Script,x
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
        lda aTitleSprites.Script,x
        sec
        sbc #1,s
        sta aTitleSprites.Script,x
        pla
        bra _F8D2


        _F901
        sep #$20
        dec a
        sta aTitleSprites.Frame,x
        inc y
        lda [lR18],y
        sta aTitleSprites.Timer,x
        rep #$20
        lda aTitleSprites.Script,x
        clc
        adc #$0002
        sta aTitleSprites.Script,x

        _F91D
        lda $7FD095,x
        sta lR18+1
        lda aTitleSprites.Frames,x
        sta lR18
        lda aTitleSprites.Frame,x
        and #$00FF
        asl a
        tay
        lda [lR18],y
        clc
        adc aTitleSprites.Frames,x
        tay
        lda aTitleSprites.X,x
        sta wR0
        lda aTitleSprites.Y,x
        sta wR1
        lda aTitleSprites.Attributes,x
        sta wR5
        lda aTitleSprites.TileBase,x
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

      rlStartTitleSprite ; 95/F967

        .al
        .xl
        .autsiz
        .databank ?

        ; lR18 = a TITLE_SPRITE definition, X = the sprite's offset in aTitleSprites (n * size(structTitleSprite)).

        phx
        phy
        ldy #$0000
        lda [lR18],y
        sta aTitleSprites.Script,x
        inc y
        inc y
        sep #$20
        lda [lR18],y
        sta $7FD096,x
        inc y
        lda #$80
        sta aTitleSprites.Flags,x
        lda #$00
        sta aTitleSprites.Timer,x
        rep #$20
        lda [lR18],y
        sta aTitleSprites.Frames,x
        inc y
        inc y
        lda [lR18],y
        sta aTitleSprites.X,x
        inc y
        inc y
        lda [lR18],y
        sta aTitleSprites.Y,x
        inc y
        inc y
        lda [lR18],y
        sta aTitleSprites.TileBase,x
        inc y
        inc y
        lda [lR18],y
        sta aTitleSprites.Attributes,x
        ply
        plx
        rtl

        .databank 0

        ; 95/F9B4

    .endsection Unsorted95F87FSection


    .section Unsorted9680ACSection

      .al
      .xl

      rlTitleScreenTopIRQ ; 96/80AC

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ at line 6 (aUnknown9680A4): rlFadeTitleScreenTopEdge.

        jsl rlFadeTitleScreenTopEdge
        rtl

        .databank 0

        ; 96/80B1

    .endsection Unsorted9680ACSection


    .section Table9680B1Section

      .al
      .xl

      aUnknown9680B1 ; 96/80B1
        .word <>rsIRQCodeHalt

      aTitleScreenBottomIRQ ; 96/80B3
        .word $0060, $00BD, <>rlTitleScreenBottomIRQ, <>aUnknown9680C0

    .endsection Table9680B1Section


    .section Unsorted9680BBSection

      .al
      .xl

      rlTitleScreenBottomIRQ ; 96/80BB

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ at line 189 (aUnknown9680B3): rlDrawTitleCaptionStrip.

        jsl rlDrawTitleCaptionStrip
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

        ; Game state routine $1A, once: blanks the screen, resets procs and HDMA, sets up the intro (phase 0: timeline aTitleIntroTimeline, song 1), or with bTitleScreenSkipIntro the title (rlTitleScreenSkipIntro, rlTitleScreenShowTitle), and moves on to $1B. Selected by rsOpenTitleScreen.

        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlProcEngineResetProcEngine
        jsl rlResetTitleTimeline
        jsl rlResetHDMAEngine
        jsl rlStartTitleLoadList
        jsl rlBattleSceneScriptClearLoading
        jsl rlSetUpTitleIntro
        jsl rlUnknown9BF3F3
        jsl rlUnknown96D659
        jsl rlUnknown95F741
        jsl rlUnknown95F7F7
        jsl rlClearTitleSprites
        jsl rlClearTitleVBlankRoutines
        lda #$0000
        sta wBattleSceneFrame
        lda bTitleScreenSkipIntro
        and #$00FF
        bne _DCA7
        jsl rlPlayTitleIntroSong
        jsl rlStepMusicScript
        lda #$0000
        sep #$20
        sta bTitleScreenPhase
        lda #$00
        sta bTitleScreenDone
        sta bTitleScreenEdgeFade
        sta $7FD8B7
        lda bTitleScreenFlags
        ora #$08
        sta bTitleScreenFlags
        stz bBattleSceneUploadCount,b
        rep #$20
        stz wBattleSceneUploadTotal,b

        _DCA0
        inc wGameStateRoutine1,b
        stz wGameStateStep,b
        rtl


        _DCA7
        jsl rlTitleScreenSkipIntro
        jsl rlTitleScreenShowTitle
        sep #$20
        stz bBattleSceneUploadCount,b
        rep #$20
        stz wBattleSceneUploadTotal,b
        bra _DCA0

        .databank 0

        ; 9B/DCBB

      rlTitleScreenStep ; 9B/DCBB

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $1B, every frame: runs the phase in bTitleScreenPhase (0 the intro, 1 the title, other the fade out) and counts frames in wTitleScreenFrame and $7FE09E.

        sep #$20
        lda bTitleScreenEdgeFade
        beq _DCC7
        lda #$80
        bra _DCC9


        _DCC7
        lda bBufferINIDISP

        _DCC9
        sta $2100,b
        rep #$20
        lda bTitleScreenPhase
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
        lda wTitleScreenFrame
        inc a
        sta wTitleScreenFrame
        lda wBattleSceneFrame
        inc a
        sta wBattleSceneFrame
        rtl

        .databank 0

        ; 9B/DD02

      rlTitleScreenRunIntro ; 9B/DD02

        .al
        .xl
        .autsiz
        .databank ?

        lda bTitleScreenFlags
        bit #$0004
        bne _DD4C
        lda bTitleScreenSkipIntro
        and #$00FF
        bne _DD46
        lda bTitleScreenFlags
        bit #$0001
        beq _DD29
        sep #$20
        and #$FE
        sta bTitleScreenFlags
        rep #$20
        bra _DD46


        _DD29
        jsl rlTitleScreenIsStartHeld
        bcc _DD62
        lda #$000A
        jsl rlPlaySoundEffect
        sep #$20
        lda bTitleScreenFlags
        ora #$01
        sta bTitleScreenFlags
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
        jsl rlRunTitleLoadList
        jsl rlBattleSceneScriptUpdateLoading
        jsl rlUnknown95F14D
        jsl rlUnknown96D695
        jsl rlUnknown96CB44
        jsl rlUnknown96A532
        jsl rlUpdateTitleSprites
        jsl rlSetTitleEdgeBrightness
        lda bTitleScreenDone
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

        lda bTitleScreenFlags
        bit #$0002
        beq _DDAD
        jsl rlTitleScreenIsStartPressed
        bcc _DDAD
        jsl rlTitleScreenStartFadeOut

        _DDAD
        jsl rlUnknown9BE184
        jsr rsRunTitleTimeline
        jsr rsRunTitleTimelineSlots
        jsl rlRunTitleLoadList
        jsl rlBattleSceneScriptUpdateLoading
        jsl rlUnknown95F14D
        jsl rlUnknown96D695
        jsl rlUnknown96A532
        jsl rlUnknown96CB44
        jsl rlUpdateTitleSprites
        lda bTitleScreenDone
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
        jsl rlRunTitleLoadList
        jsl rlBattleSceneScriptUpdateLoading
        jsl rlUnknown95F14D
        jsl rlUnknown96D695
        jsl rlUpdateTitleSprites
        lda bTitleScreenDone
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
        jsl rlClearTitleSprites
        jsl rlUnknown96D659
        jsl rlResetIRQEngine
        lda #$0000
        sta wBattleSceneLargeUploadSize
        sep #$20
        sta $7FECF4
        sta bTitleLoadRequests
        sta bTitleScreenEdgeFade
        rep #$20
        jsl rlResetTitleTimeline
        lda #(`aTitleTimeline)<<8
        sta lTitleTimelinePosition+1
        lda #<>aTitleTimeline
        sta lTitleTimelinePosition
        jsl rlStartTitleLoadList
        sep #$20
        lda bTitleScreenFlags
        ora #$04
        sta bTitleScreenFlags
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
        sta bTitleScreenPhase
        rep #$20
        jsl rlLoadTitleGraphics
        jsl rlUnknown95F12A
        ldx #$0000
        lda #(`aTitleSpriteDefinitions)<<8
        sta lR18+1
        lda #<>aTitleSpriteDefinitions
        sta lR18
        jsl rlStartTitleSprite
        jsl rlStartTitleLogoSprite1
        jsl rlStartTitleLogoSprite2
        jsl rlStartTitleLogoSprite3
        jsl rlStartTitleLogoSprite4
        jsl rlStartTitleLogoSprite5
        jsl rlStartTitleLogoSprite6
        jsl rlStartTitleLogoSprite7
        jsl rlStartTitleLogoSprite8
        jsl rlStartTitleLogoSprite9
        jsl rlStartTitleLogoSprite10
        jsl rlStartTitleLogoSprite11
        lda #(`aTitleScreenRegisters)<<8
        sta lR18+1
        lda #<>aTitleScreenRegisters
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
        sta bTitleScreenEdgeFade
        rep #$20
        lda #$0000
        sta aBGPaletteBuffer,b
        jsl rlClearTitleVBlankRoutines
        jsl rlPlayTitleSong
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

      aTitleScreenRegisters ; 9B/DF09

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

      rlRestartTitleIntro ; 9B/DF35

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this: the intro's setup again, with the edge fade on.

        sei
        jsl rlDisableVBlank
        jsl rlWaitForVBlankStart
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlResetHDMAEngine
        sep #$20
        lda #$00
        sta bTitleScreenPhase
        lda #$00
        sta bTitleScreenDone
        rep #$20
        jsl rlResetTitleTimeline
        lda #(`aTitleIntroTimeline)<<8
        sta lTitleTimelinePosition+1
        lda #<>aTitleIntroTimeline
        sta lTitleTimelinePosition
        jsl rlStartTitleLoadList
        jsl rlBattleSceneScriptClearLoading
        jsl rlSetUpTitleIntro
        jsl rlUnknown96D659
        jsl rlClearTitleSprites
        jsl rlWaitForVBlankEnd
        jsl rlEnableVBlank
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        sep #$20
        lda #$01
        sta bTitleScreenEdgeFade
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
        sta bTitleScreenDone
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

        ; Called from the title screen's step when bTitleScreenDone is set: blanks the screen, resets the battle screen's state and HDMA, and starts the attract mode's opening (aOpeningEvent).

        sei
        jsl rlDisableVBlank
        jsl rlWaitForVBlankStart
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlResetHDMAEngine
        sep #$20
        lda #$00
        sta bTitleScreenPhase
        lda #$00
        sta bTitleScreenDone
        rep #$20
        jsl rlResetTitleTimeline
        lda #(`aTitleIntroTimeline)<<8
        sta lTitleTimelinePosition+1
        lda #<>aTitleIntroTimeline
        sta lTitleTimelinePosition
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
        sta wBattleSceneLargeUploadSize
        sep #$20
        sta $7FECF4
        sta bTitleLoadRequests
        sta bTitleScreenEdgeFade
        lda #$02
        sta bTitleScreenPhase
        lda #$00
        sta bTitleScreenDone
        rep #$20
        jsl rlResetTitleTimeline
        lda #(`aTitleFadeOutTimeline)<<8
        sta lTitleTimelinePosition+1
        lda #<>aTitleFadeOutTimeline
        sta lTitleTimelinePosition
        jsl rlStartTitleFadeOutLoadList
        ldx #$0000
        lda #(`aTitleSpriteDefinitions)<<8
        sta lR18+1
        lda #<>aTitleSpriteDefinitions
        sta lR18
        jsl rlStartTitleSprite
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
        sta wTitleScreenFrame
        lda #(`aTitleIntroTimeline)<<8
        sta lTitleTimelinePosition+1
        lda #<>aTitleIntroTimeline
        sta lTitleTimelinePosition
        ldx #$0000

        _E076
        lda #$0000
        sta aTitleTimelineSlots.bActive,x
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
        lda lTitleTimelinePosition
        sta lR18
        lda lTitleTimelinePosition+1
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        cmp wTitleScreenFrame
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
        lda aTitleTimelineSlots.bActive,x
        ora #$01
        sta aTitleTimelineSlots.bActive,x
        lda [lR18],y
        inc y
        sta aTitleTimelineSlots.lRoutine,x
        rep #$20
        lda [lR18],y
        inc y
        inc y
        sta aTitleTimelineSlots.lRoutine+1,x

        _E0E7
        bra _E0A7


        _E0E9
        tya
        clc
        adc lTitleTimelinePosition
        sta lTitleTimelinePosition

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
        lda aTitleTimelineSlots.bActive,x
        bit #$0001
        beq _E152
        phb
        jsl _E13D
        plb
        .databank ?
        bra _E152


        _E13D
        lda aTitleTimelineSlots.lRoutine,x
        sta lR18
        sep #$20
        lda aTitleTimelineSlots.lRoutine+2,x
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

      rlClearTitleVBlankRoutines ; 9B/EAA5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta lTitleVBlankRoutine1
        sta lTitleVBlankRoutine2
        rtl

        .databank 0

        ; 9B/EAB1

    .endsection Unsorted9BEAA5Section


    .section Unsorted9BEAB1Section

      .al
      .xl

      rlRunTitleVBlankRoutines ; 9B/EAB1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _EAB5
        lda lTitleVBlankRoutine1,x
        cmp #$0000
        beq _EADB
        phb
        jsl _EAC6
        plb
        .databank ?
        bra _EADB


        _EAC6
        lda lTitleVBlankRoutine1,x
        sta lR18
        sep #$20
        lda lTitleVBlankRoutine1+2,x
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

      rlDrawTitleSpriteAfterimage ; 9B/EAE8

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aTitleSprites.Flags,x
        bit #$0001
        bne _EAF6
        jml _EC6C


        _EAF6
        bit #$0002
        beq _EB03
        jsl rlDrawTitleSpriteAfterimages
        jml _EC6C


        _EB03
        sep #$20
        lda aTitleSprites.TrailPosition,x
        dec a
        and #$0F
        sta aTitleSprites.TrailPosition,x
        rep #$20
        phx
        lda aTitleSprites.X,x
        pha
        lda aTitleSprites.Y,x
        pha
        lda aTitleSprites.Frame,x
        pha
        lda aTitleSprites.TrailPosition,x
        and #$00FF
        clc
        adc #7,s
        tax
        pla
        sep #$20
        sta aTitleSprites.TrailFrame,x
        rep #$20
        lda #5,s
        tax
        lda aTitleSprites.TrailPosition,x
        and #$00FF
        asl a
        clc
        adc #5,s
        tax
        pla
        sta aTitleSprites.TrailY,x
        pla
        sta aTitleSprites.TrailX,x
        plx
        lda wTitleScreenFrame
        bit #$0001
        beq _EB62
        bit #$0002
        bne _EBA3
        jml _EBE5


        _EB62
        phx
        lda aTitleSprites.TrailPosition,x
        clc
        adc aTitleSprites.TrailDelay,x
        dec a
        and #$000F
        clc
        adc #1,s
        tax
        lda aTitleSprites.TrailFrame,x
        and #$00FF
        sta wR9
        lda #1,s
        tax
        lda aTitleSprites.TrailPosition,x
        clc
        adc aTitleSprites.TrailDelay,x
        dec a
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda aTitleSprites.TrailX,x
        sta wR0
        lda aTitleSprites.TrailY,x
        sta wR1
        plx
        jml _EC33


        _EBA3
        phx
        lda aTitleSprites.TrailDelay,x
        asl a
        dec a
        clc
        adc aTitleSprites.TrailPosition,x
        and #$000F
        clc
        adc #1,s
        tax
        sep #$20
        lda aTitleSprites.TrailFrame,x
        sta wR9
        rep #$20
        lda #1,s
        tax
        lda aTitleSprites.TrailDelay,x
        asl a
        dec a
        clc
        adc aTitleSprites.TrailPosition,x
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda aTitleSprites.TrailX,x
        sta wR0
        lda aTitleSprites.TrailY,x
        sta wR1
        plx
        bra _EC33


        _EBE5
        phx
        lda aTitleSprites.TrailDelay,x
        pha
        asl a
        clc
        adc #1,s
        sta #1,s
        pla
        dec a
        clc
        adc aTitleSprites.TrailPosition,x
        and #$000F
        clc
        adc #1,s
        tax
        sep #$20
        lda aTitleSprites.TrailFrame,x
        sta wR9
        rep #$20
        lda #1,s
        tax
        lda aTitleSprites.TrailDelay,x
        pha
        asl a
        clc
        adc #1,s
        sta #1,s
        pla
        dec a
        clc
        adc aTitleSprites.TrailPosition,x
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda aTitleSprites.TrailX,x
        sta wR0
        lda aTitleSprites.TrailY,x
        sta wR1
        plx

        _EC33
        lda $7FD095,x
        sta lR18+1
        lda aTitleSprites.Frames,x
        sta lR18
        lda wR9
        and #$00FF
        asl a
        tay
        lda [lR18],y
        clc
        adc aTitleSprites.Frames,x
        tay
        lda aTitleSprites.Attributes,x
        sta wR5
        lda aTitleSprites.TileBase,x
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

      rlDrawTitleSpriteAfterimages ; 9B/EC6E

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda aTitleSprites.TrailPosition,x
        dec a
        and #$0F
        sta aTitleSprites.TrailPosition,x
        rep #$20
        phx
        lda aTitleSprites.X,x
        pha
        lda aTitleSprites.Y,x
        pha
        lda $7FD0FB,x
        pha
        lda aTitleSprites.TrailPosition,x
        and #$00FF
        clc
        adc #7,s
        tax
        pla
        sep #$20
        sta aTitleSprites.TrailFrame,x
        rep #$20
        lda #5,s
        tax
        lda aTitleSprites.TrailPosition,x
        and #$00FF
        asl a
        clc
        adc #5,s
        tax
        pla
        sta aTitleSprites.TrailY,x
        pla
        sta aTitleSprites.TrailX,x
        plx
        phx
        lda aTitleSprites.TrailPosition,x
        clc
        adc aTitleSprites.TrailDelay,x
        dec a
        and #$000F
        clc
        adc #1,s
        tax
        lda aTitleSprites.TrailFrame,x
        and #$00FF
        sta wR9
        lda #1,s
        tax
        lda aTitleSprites.TrailPosition,x
        clc
        adc aTitleSprites.TrailDelay,x
        dec a
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda aTitleSprites.TrailX,x
        sta wR0
        lda aTitleSprites.TrailY,x
        sta wR1
        plx
        jsr rsDrawTitleSpriteAfterimageFrame
        lda wTitleScreenFrame
        bit #$0001
        bne _ED4A
        phx
        lda aTitleSprites.TrailDelay,x
        asl a
        dec a
        clc
        adc aTitleSprites.TrailPosition,x
        and #$000F
        clc
        adc #1,s
        tax
        sep #$20
        lda aTitleSprites.TrailFrame,x
        sta wR9
        rep #$20
        lda #1,s
        tax
        lda aTitleSprites.TrailDelay,x
        asl a
        dec a
        clc
        adc aTitleSprites.TrailPosition,x
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda aTitleSprites.TrailX,x
        sta wR0
        lda aTitleSprites.TrailY,x
        sta wR1
        plx
        jsr rsDrawTitleSpriteAfterimageFrame
        bra _ED9B


        _ED4A
        phx
        lda aTitleSprites.TrailDelay,x
        pha
        asl a
        clc
        adc #1,s
        sta #1,s
        pla
        dec a
        clc
        adc aTitleSprites.TrailPosition,x
        and #$000F
        clc
        adc #1,s
        tax
        sep #$20
        lda aTitleSprites.TrailFrame,x
        sta wR9
        rep #$20
        lda #1,s
        tax
        lda aTitleSprites.TrailDelay,x
        pha
        asl a
        clc
        adc #1,s
        sta #1,s
        pla
        dec a
        clc
        adc aTitleSprites.TrailPosition,x
        and #$000F
        asl a
        clc
        adc #1,s
        tax
        lda aTitleSprites.TrailX,x
        sta wR0
        lda aTitleSprites.TrailY,x
        sta wR1
        plx
        jsr rsDrawTitleSpriteAfterimageFrame

        _ED9B
        plx
        rtl

        .databank 0

        ; 9B/ED9D

      rsDrawTitleSpriteAfterimageFrame ; 9B/ED9D

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD095,x
        sta lR18+1
        lda aTitleSprites.Frames,x
        sta lR18
        lda wR9
        and #$00FF
        asl a
        tay
        lda [lR18],y
        clc
        adc aTitleSprites.Frames,x
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

      rlStartTitleSpriteAfterimage ; 9B/EDD7

        .al
        .xl
        .autsiz
        .databank ?

        ; A = how many frames behind the afterimage is (structTitleSprite.TrailDelay); fills the trail with the sprite's position.

        sep #$20
        sta aTitleSprites.TrailDelay,x
        lda aTitleSprites.Flags,x
        ora #$01
        sta aTitleSprites.Flags,x
        rep #$20
        lda aTitleSprites.X,x
        sta aTitleSprites.TrailX,x
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
        lda aTitleSprites.Y,x
        sta aTitleSprites.TrailY,x
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
        sta aTitleSprites.TrailPosition,x
        lda aTitleSprites.Frame,x
        xba
        lda aTitleSprites.Frame,x
        rep #$20
        sta aTitleSprites.TrailFrame,x
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

      rlStopTitleSpriteAfterimage ; 9B/EEA5

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda aTitleSprites.Flags,x
        and #$FE
        sta aTitleSprites.Flags,x
        rep #$20
        rtl

        .databank 0

        ; 9B/EEB4

    .endsection Unsorted9BEDD7Section


    .section Unsorted9BEEB4Section

      .al
      .xl

      rlFadeTitleScreenTopEdge ; 9B/EEB4

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bTitleScreenEdgeFade
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
        lda aTitleScreenEdgeBrightness
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

      rlDrawTitleCaptionStrip ; 9B/EF88

        .al
        .xl
        .autsiz
        .databank ?

        ; Below line 189: fades the lines near the bottom edge, then switches the PPU to BG1 alone (mode 1, tilemap $7C00) scrolled to bTitleCaptionScroll for the caption, at bTitleCaptionBrightness.

        sep #$20
        lda bTitleScreenEdgeFade
        bne _EF94
        jml _F09C


        _EF94
        lda $4212,b
        bit #$40
        beq _EF94
        lda aTitleScreenEdgeBrightness
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
        lda bTitleCaptionScroll
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
        lda bTitleCaptionBrightness
        sta $2100,b

        _F09C
        rep #$20
        rtl

        .databank 0

        ; 9B/F09F

      rlStartFadingInTitleCaption ; 9B/F09F

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD050
        sep #$20
        lda #$00
        sta bTitleCaptionBrightness
        rep #$20
        jsl rlFadeInTitleCaption
        lda #(`rlFadeInTitleCaption)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlFadeInTitleCaption
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 9B/F0C3

      rlFadeInTitleCaption ; 9B/F0C3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FD050
        bne _F0EB
        sep #$20
        lda bTitleCaptionBrightness
        cmp #$0F
        beq _F0DD
        inc a
        sta bTitleCaptionBrightness
        rep #$20
        bra _F0EB


        _F0DD
        .as
        rep #$20
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
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

      rlStartFadingOutTitleCaption ; 9B/F0FE

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD050
        jsl rlFadeOutTitleCaption
        lda #(`rlFadeOutTitleCaption)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlFadeOutTitleCaption
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 9B/F118

      rlFadeOutTitleCaption ; 9B/F118

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FD050
        bne _F146
        sep #$20
        lda bTitleCaptionBrightness
        cmp #$00
        beq _F132
        dec a
        sta bTitleCaptionBrightness
        rep #$20
        bra _F146


        _F132
        .as
        lda #$80
        sta bTitleCaptionBrightness
        rep #$20
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
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

      rlShowNextTitleCaption ; 9B/F159

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda bTitleCaption
        and #$00FF
        tax
        sep #$20
        lda aTitleCaptionScrolls,x
        sta bTitleCaptionScroll
        lda bTitleCaption
        inc a
        sta bTitleCaption
        rep #$20
        plx
        rtl

        .databank 0

        ; 9B/F179

    .endsection Unsorted9BEEB4Section


    .section Unsorted9BF179Section

      .al
      .xl

      rlSetTitleEdgeBrightness ; 9B/F179

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferINIDISP
        bit #$80
        beq _F1A3
        sta aTitleScreenEdgeBrightness
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
        sta aTitleScreenEdgeBrightness
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

      rlWaitForVBlankStart ; 9B/F297

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

      rlWaitForVBlankEnd ; 9B/F2AA

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

      rlEndTitleEdgeFade ; 9B/F2BD

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta bTitleScreenEdgeFade
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
        lda #(`aTitleSprite0Definition2)<<8
        sta lR18+1
        lda #<>aTitleSprite0Definition2
        sta lR18
        jsl rlStartTitleSprite
        ldx #$0062
        lda #(`aTitleSprite1Definition2)<<8
        sta lR18+1
        lda #<>aTitleSprite1Definition2
        sta lR18
        jsl rlStartTitleSprite
        lda #$0000
        sta $7FD05D
        lda #1,s
        tax
        lda #(`rlUnknown9BF36F)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF36F
        sta aTitleTimelineSlots.lRoutine,x
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
        jsl rlStartTitleSpriteAfterimage
        sep #$20
        lda aTitleSprites.Flags
        ora #$02
        sta aTitleSprites.Flags
        lda #$00
        sta $7FD0F1
        rep #$20
        lda #1,s
        tax
        jsl rlUnknown9BF3A5
        lda #(`rlUnknown9BF3A5)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF3A5
        sta aTitleTimelineSlots.lRoutine,x
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
        lda aTitleSprite0Motion,x
        and #$00FF
        cmp #$0080
        beq _F3E4
        pha
        lda aTitleSprite0Motion+1,x
        and #$00FF
        pha
        lda aTitleSprites.X
        clc
        adc #3,s
        sta aTitleSprites.X
        lda aTitleSprites.Y
        clc
        adc #1,s
        sta aTitleSprites.Y
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
        sta aTitleTimelineSlots.bActive,x
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

        lda bTitleScreenPhase
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
        lda wTitleScreenFrame
        inc a
        sta wTitleScreenFrame
        cmp #$0023
        bcc _FD01
        sep #$20
        stz bBufferTS
        rep #$20
        lda #$0000
        sta wTitleScreenFrame
        bra _FD43


        _FD01
        lda $7FD046
        sta wR0
        jsr rsDrawTitleFlashSprite
        lda $7FD046
        clc
        adc #$0005
        sta $7FD046
        bra _FD50


        _FD18
        lda wTitleScreenFrame
        inc a
        sta wTitleScreenFrame
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
        lda bTitleScreenPhase
        inc a
        sta bTitleScreenPhase
        rep #$20

        _FD50
        clc

        _FD51
        rtl

        .databank 0

        ; 9B/FD52

      rsDrawTitleFlashSprite ; 9B/FD52

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
        ldy #<>aTitleFlashSprite
        jsl rlPushToOAMBuffer
        plb
        .databank $99
        ply
        plx
        rts

        .databank 0

        ; 9B/FD71

    .endsection Unsorted9BFC8DSection


