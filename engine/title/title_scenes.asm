; What the title screen's timelines call (title_timelines.asm): the intro's
; eight scenes (their registers, graphics, scrolling, palette effects, HDMA
; effects and sprites), the brightness fades, the title logo's sprites, the
; music, and the fade out's steps. Most visual effect routines are Unknown,
; with the scene that uses them visible in the timeline. Routines noted
; "nothing in the build reaches this" are steps no timeline names.


    .section Unsorted95EA47Section

      .al
      .xl

      rlSetUpTitleIntro ; 95/EA47

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta bTitleCaption
        sta bTitleScreenFlags
        lda #$E0
        sta bBufferCOLDATA_3
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        rep #$20
        jsl rlSetUpTitleIntroScene1
        jsl rlLoadTitleIntroGraphics
        jsl rlUnknown9BE179
        rtl

        .databank 0

        ; 95/EA6A

      rlSetUpTitleIntroScene1 ; 95/EA6A

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown95EA91)<<8
        sta lR18+1
        lda #<>aUnknown95EA91
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #$0000
        sta wBufferBG2HOFS
        sta wBufferBG2VOFS
        sta wBufferBG1HOFS
        lda #$00F0
        sta wBufferBG1VOFS
        sep #$20
        lda #$80
        sta bTitleCaptionBrightness
        rep #$20
        rtl

        .databank 0

        ; 95/EA91

    .endsection Unsorted95EA47Section


    .section Table95EA91Section

      .al
      .xl

      aUnknown95EA91 ; 95/EA91

        WRITE_RAM_BYTE bBufferBG12NBA, $60
        WRITE_RAM_BYTE bBufferBG1SC, $32
        WRITE_RAM_BYTE bBufferBG2SC, $70
        WRITE_RAM_BYTE bBufferTM, $01
        WRITE_RAM_BYTE bBufferTS, $02
        WRITE_RAM_BYTE bBufferCGWSEL, $02
        WRITE_RAM_BYTE bBufferCGADSUB, $33
        WRITE_RAM_END

      rlUnknown95EAA8 ; 95/EAA8

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 95/EAA9

      rlUnknown95EAA9 ; 95/EAA9

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta bBufferTM
        sta bBufferTS
        rep #$20
        rtl

        .databank 0

        ; 95/EAB4

      rlSetUpTitleIntroScene2 ; 95/EAB4

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown95EB1B)<<8
        sta lR18+1
        lda #<>aUnknown95EB1B
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #$0000
        sta wBufferBG1HOFS
        sta wBufferBG2HOFS
        sta wBufferBG3HOFS
        lda #$0156
        sta wBufferBG1VOFS
        lda #$0156
        sta wBufferBG2VOFS
        lda #$00B2
        sta wBufferBG3VOFS
        ldx #$0000

        _EADD
        lda aUnknownE023CF+30,x
        sta $0162,b,x
        lda aUnknownE023CF+92,x
        sta $01C2,b,x
        lda aUnknownE023CF+154,x
        sta $0242,b,x
        sta $02C2,b,x
        sta $7EEB88,x
        lda #$0000
        sta $0202,b,x
        sta $0282,b,x
        inc x
        inc x
        cpx #$003E
        bcc _EADD
        ldx #$0000

        _EB0C
        lda aUnknownE023CF,x
        sta $0122,b,x
        inc x
        inc x
        cpx #$001E
        bcc _EB0C
        rtl

        .databank 0

        ; 95/EB1B

      aUnknown95EB1B ; 95/EB1B

        WRITE_RAM_BYTE bBufferBG12NBA, $40
        WRITE_RAM_BYTE bBufferBG34NBA, $02
        WRITE_RAM_BYTE bBufferOBSEL, $03
        WRITE_RAM_BYTE bBufferBG1SC, $32
        WRITE_RAM_BYTE bBufferBG2SC, $3A
        WRITE_RAM_BYTE bBufferBG3SC, $72
        WRITE_RAM_BYTE bBufferTM, $17
        WRITE_RAM_BYTE bBufferTS, $07
        WRITE_RAM_BYTE bBufferCGWSEL, $02
        WRITE_RAM_BYTE bBufferCGADSUB, $30
        WRITE_RAM_END

      rlUnknown95EB3B ; 95/EB3B

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferTM
        and #$FD
        sta bBufferTM
        lda bBufferTS
        and #$FD
        sta bBufferTS
        rep #$20
        rtl

        .databank 0

        ; 95/EB4C

      rlUnknown95EB4C ; 95/EB4C

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferTM
        and #$FB
        sta bBufferTM
        lda bBufferTS
        and #$FB
        sta bBufferTS
        rep #$20
        rtl

        .databank 0

        ; 95/EB5D

      rlSetUpTitleIntroScene3 ; 95/EB5D

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown95EB9B)<<8
        sta lR18+1
        lda #<>aUnknown95EB9B
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #$0000
        sta wBufferBG2HOFS
        sta wBufferBG3HOFS
        sta wBufferBG3VOFS
        lda #$0018
        sta wBufferBG2VOFS
        ldx #$0000

        _EB7C
        lda aUnknownE0207A+130,x
        sta $0122,b,x
        lda #$0000
        sta $0142,b,x
        inc x
        inc x
        cpx #$001E
        bcc _EB7C
        sep #$20
        lda #$01
        sta $7FD8B6
        rep #$20
        rtl

        .databank 0

        ; 95/EB9B

      aUnknown95EB9B ; 95/EB9B

        WRITE_RAM_BYTE bBufferBG2SC, $28
        WRITE_RAM_MASK_BYTE bBufferBG12NBA, $0F, $20
        WRITE_RAM_BYTE bBufferBG34NBA, $02
        WRITE_RAM_BYTE bBufferTM, $03
        WRITE_RAM_BYTE bBufferTS, $10
        WRITE_RAM_BYTE bBufferCGWSEL, $02
        WRITE_RAM_BYTE bBufferCGADSUB, $27
        WRITE_RAM_END

      rlSetUpTitleIntroScene3b ; 95/EBB3

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown95EBF1)<<8
        sta lR18+1
        lda #<>aUnknown95EBF1
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #$0000
        sta wBufferBG2HOFS
        sta wBufferBG1HOFS
        sta wBufferBG3HOFS
        sta wBufferBG3VOFS
        lda wBufferBG1VOFS
        sta wBufferBG2VOFS
        lda #$0018
        sta wBufferBG1VOFS
        ldx #$0000

        _EBD8
        lda aUnknownE0207A+130,x
        sta $0122,b,x
        inc x
        inc x
        cpx #$001E
        bcc _EBD8
        sep #$20
        lda #$01
        sta $7FD8B6
        rep #$20
        rtl

        .databank 0

        ; 95/EBF1

      aUnknown95EBF1 ; 95/EBF1

        WRITE_RAM_BYTE bBufferBG12NBA, $02
        WRITE_RAM_BYTE bBufferBG34NBA, $02
        WRITE_RAM_BYTE bBufferBG1SC, $28
        WRITE_RAM_BYTE bBufferBG2SC, $32
        WRITE_RAM_BYTE bBufferBG3SC, $24
        WRITE_RAM_BYTE bBufferTM, $03
        WRITE_RAM_BYTE bBufferTS, $10
        WRITE_RAM_BYTE bBufferCGWSEL, $02
        WRITE_RAM_BYTE bBufferCGADSUB, $27
        WRITE_RAM_END

      rlSetUpTitleIntroScene4 ; 95/EC0E

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown95EC3E)<<8
        sta lR18+1
        lda #<>aUnknown95EC3E
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #$0000
        sta wBufferBG1HOFS
        sta wBufferBG1VOFS
        lda #$0000
        sta wBufferBG2HOFS
        lda #$0018
        sta wBufferBG2VOFS
        ldx #$0000

        _EC30
        lda #$0000
        sta $0162,b,x
        inc x
        inc x
        cpx #$001E
        bcc _EC30
        rtl

        .databank 0

        ; 95/EC3E

      aUnknown95EC3E ; 95/EC3E

        WRITE_RAM_BYTE bBufferBG1SC, $2C
        WRITE_RAM_BYTE bBufferBG2SC, $28
        WRITE_RAM_MASK_BYTE bBufferTM, $FE, $00
        WRITE_RAM_BYTE bBufferBG12NBA, $25
        WRITE_RAM_END

      rlUnknown95EC4D ; 95/EC4D

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferTM
        ora #$01
        sta bBufferTM
        rep #$20
        rtl

        .databank 0

        ; 95/EC58

      rlUnknown95EC58 ; 95/EC58

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferTS
        ora #$04
        sta bBufferTS
        rep #$20
        rtl

        .databank 0

        ; 95/EC63

      rlUnknown95EC63 ; 95/EC63

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda wR0
        sta bBufferTM
        sta bBufferTS
        rep #$20
        rtl

        .databank 0

        ; 95/EC6E

      rlSetUpTitleIntroScene5 ; 95/EC6E

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown95ECB9)<<8
        sta lR18+1
        lda #<>aUnknown95ECB9
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #$0000
        sta wBufferBG1HOFS
        lda #$0040
        sta wBufferBG1VOFS
        lda #$0000
        sta wBufferBG2HOFS
        lda #$0018
        sta wBufferBG2VOFS
        ldx #$0000

        _EC93
        lda aUnknownE022B7+94,x
        sta $0162,b,x
        inc x
        inc x
        cpx #$005E
        bcc _EC93
        ldx #$0000

        _ECA4
        lda aUnknownE022B7+30,x
        sta $0122,b,x
        lda #$0000
        sta $0142,b,x
        inc x
        inc x
        cpx #$001E
        bcc _ECA4
        rtl

        .databank 0

        ; 95/ECB9

      aUnknown95ECB9 ; 95/ECB9

        WRITE_RAM_BYTE bBufferBG12NBA, $10
        WRITE_RAM_BYTE bBufferBG34NBA, $02
        WRITE_RAM_BYTE bBufferBG1SC, $72
        WRITE_RAM_BYTE bBufferBG2SC, $1C
        WRITE_RAM_BYTE bBufferBG3SC, $24
        WRITE_RAM_BYTE bBufferTM, $03
        WRITE_RAM_BYTE bBufferTS, $00
        WRITE_RAM_BYTE bBufferCGWSEL, $02
        WRITE_RAM_BYTE bBufferCGADSUB, $33
        WRITE_RAM_END

      rlUnknown95ECD6 ; 95/ECD6

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferTS
        ora #$04
        sta bBufferTS
        rep #$20
        rtl

        .databank 0

        ; 95/ECE1

      rlUnknown95ECE1 ; 95/ECE1

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda wR0
        sta bBufferTM
        sta bBufferTS
        rep #$20
        rtl

        .databank 0

        ; 95/ECEC

      rlSetUpTitleIntroScene6 ; 95/ECEC

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown95ED31)<<8
        sta lR18+1
        lda #<>aUnknown95ED31
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #$0000
        sta wBufferBG1HOFS
        lda #$0148
        sta wBufferBG1VOFS
        lda #$0000
        sta wBufferBG2HOFS
        lda #$0019
        sta wBufferBG2VOFS
        ldx #$0000

        _ED11
        lda aUnknownE0207A+419,x
        sta $0162,b,x
        inc x
        inc x
        cpx #$003E
        bcc _ED11
        ldx #$0000

        _ED22
        lda aUnknownE0207A+481,x
        sta $0142,b,x
        inc x
        inc x
        cpx #$001E
        bcc _ED22
        rtl

        .databank 0

        ; 95/ED31

      aUnknown95ED31 ; 95/ED31

        WRITE_RAM_BYTE bBufferBG12NBA, $44
        WRITE_RAM_BYTE bBufferBG34NBA, $00
        WRITE_RAM_BYTE bBufferBG1SC, $2A
        WRITE_RAM_BYTE bBufferBG2SC, $6C
        WRITE_RAM_BYTE bBufferBG3SC, $04
        WRITE_RAM_BYTE bBufferTM, $03
        WRITE_RAM_BYTE bBufferTS, $00
        WRITE_RAM_BYTE bBufferCGWSEL, $02
        WRITE_RAM_BYTE bBufferCGADSUB, $37
        WRITE_RAM_END


    .endsection Table95EA91Section


    .section Unsorted95ED4ESection

      .al
      .xl

      rlUnknown95ED4E ; 95/ED4E

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferTS
        ora #$04
        sta bBufferTS
        rep #$20
        rtl

        .databank 0

        ; 95/ED59

      rlUnknown95ED59 ; 95/ED59

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda wR0
        sta bBufferTM
        sta bBufferTS
        rep #$20
        lda #$7FFF
        sta aBGPaletteBuffer,b
        rtl

        .databank 0

        ; 95/ED6A

      rlUnknown95ED6A ; 95/ED6A

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda wR0
        sta bBufferTM
        sta bBufferTS
        rep #$20
        lda #$0000
        sta aBGPaletteBuffer,b
        rtl

        .databank 0

        ; 95/ED7B

    .endsection Unsorted95ED4ESection


    .section Unsorted95ED7BSection

      .al
      .xl

      rlSetUpTitleIntroScene7 ; 95/ED7B

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown95EDD0)<<8
        sta lR18+1
        lda #<>aUnknown95EDD0
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #$0000
        sta wBufferBG1HOFS
        lda #$0010
        sta wBufferBG1VOFS
        lda #$0000
        sta wBufferBG2HOFS
        sta wBufferBG2VOFS
        ldx #$0000

        _ED9D
        lda aUnknownE02667,x
        sta $01E2,b,x
        inc x
        inc x
        cpx #$001E
        bcc _ED9D
        ldx #$0000

        _EDAE
        lda aUnknownE02667+30,x
        sta $02C2,b,x
        inc x
        inc x
        cpx #$003E
        bcc _EDAE
        ldx #$0000
        lda #$0000

        _EDC2
        sta aBGPaletteBuffer.aPalette1,b,x
        sta aOAMPaletteBuffer,b,x
        inc x
        inc x
        cpx #$00C2
        bcc _EDC2
        rtl

        .databank 0

        ; 95/EDD0

    .endsection Unsorted95ED7BSection


    .section Data95EDD0Section

      .al
      .xl

      aUnknown95EDD0 ; 95/EDD0

        WRITE_RAM_BYTE bBufferBGMODE, $0B
        WRITE_RAM_BYTE bBufferBG12NBA, $13
        WRITE_RAM_BYTE bBufferOBSEL, $01
        WRITE_RAM_BYTE bBufferBG1SC, $0C
        WRITE_RAM_BYTE bBufferBG2SC, $08
        WRITE_RAM_BYTE bBufferTM, $12
        WRITE_RAM_BYTE bBufferTS, $00
        WRITE_RAM_BYTE bBufferCGADSUB, $00
        WRITE_RAM_END

    .endsection Data95EDD0Section


    .section Unsorted95EDEASection

      .al
      .xl

      rlUnknown95EDEA ; 95/EDEA

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferTM
        ora #$01
        sta bBufferTM
        rep #$20
        rtl

        .databank 0

        ; 95/EDF5

      rlUnknown95EDF5 ; 95/EDF5

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferTS
        and #$FE
        sta bBufferTS
        rep #$20
        rtl

        .databank 0

        ; 95/EE00

      rlSetUpTitleIntroScene8 ; 95/EE00

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aUnknown95EE58)<<8
        sta lR18+1
        lda #<>aUnknown95EE58
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #$0000
        sta wBufferBG1HOFS
        lda #$0020
        sta wBufferBG1VOFS
        ldx #$0000

        _EE1C
        lda #$0000
        sta $0162,b,x
        lda aUnknownE026E1,x
        sta $0122,b,x
        lda aUnknownE026FF,x
        sta $0142,b,x
        lda aUnknownE0271D,x
        sta $0242,b,x
        lda aUnknownE02769,x
        sta $0282,b,x
        inc x
        inc x
        cpx #$001E
        bcc _EE1C
        ldx #$0000

        _EE48
        lda aUnknownE02759,x
        sta $0182,b,x
        inc x
        inc x
        cpx #$0012
        bcc _EE48
        plx
        rtl

        .databank 0

        ; 95/EE58

    .endsection Unsorted95EDEASection


    .section Data95EE58Section

      .al
      .xl

      aUnknown95EE58 ; 95/EE58

        WRITE_RAM_BYTE bBufferBGMODE, $09
        WRITE_RAM_MASK_BYTE bBufferBG12NBA, $FC, $04
        WRITE_RAM_BYTE bBufferBG1SC, $7C
        WRITE_RAM_BYTE bBufferOBSEL, $03
        WRITE_RAM_BYTE bBufferTM, $12
        WRITE_RAM_BYTE bBufferTS, $01
        WRITE_RAM_BYTE bBufferCGWSEL, $02
        WRITE_RAM_BYTE bBufferCGADSUB, $32
        WRITE_RAM_END

    .endsection Data95EE58Section


    .section Unsorted95F2E5Section

      .al
      .xl

      rlUnknown95F2E5 ; 95/F2E5

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aBattleScenePaletteEffects._A9A8_AD24)<<8
        sta lR18+1
        lda #<>aBattleScenePaletteEffects._A9A8_AD24
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        rtl

        .databank 0

        ; 95/F2F9

      rlUnknown95F2F9 ; 95/F2F9

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aBattleScenePaletteEffects._A9A8_AD2B)<<8
        sta lR18+1
        lda #<>aBattleScenePaletteEffects._A9A8_AD2B
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        rtl

        .databank 0

        ; 95/F30D

      rlUnknown95F30D ; 95/F30D

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aBattleScenePaletteEffects._A9A8_ADAF)<<8
        sta lR18+1
        lda #<>aBattleScenePaletteEffects._A9A8_ADAF
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        rtl

        .databank 0

        ; 95/F321

      rlUnknown95F321 ; 95/F321

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aBattleScenePaletteEffects._A9A8_ADB6)<<8
        sta lR18+1
        lda #<>aBattleScenePaletteEffects._A9A8_ADB6
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        rtl

        .databank 0

        ; 95/F335

      rlUnknown95F335 ; 95/F335

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aBattleScenePaletteEffects._A9A8_AD40)<<8
        sta lR18+1
        lda #<>aBattleScenePaletteEffects._A9A8_AD40
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        rtl

        .databank 0

        ; 95/F349

      rlUnknown95F349 ; 95/F349

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aBattleScenePaletteEffects._A9A8_AD16)<<8
        sta lR18+1
        lda #<>aBattleScenePaletteEffects._A9A8_AD16
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        rtl

        .databank 0

        ; 95/F35D

    .endsection Unsorted95F2E5Section


    .section TitleScenes95F35DSection

      .al
      .xl

      rlUnknown95F35D ; 95/F35D

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this: no title timeline names it.

        phx
        ldx #$0000
        lda #$7FFF

        _F364
        sta $0122,b,x
        inc x
        inc x
        cpx #$00AE
        bcc _F364
        ldx #$0000

        _F371
        sta $0202,b,x
        inc x
        inc x
        cpx #$00AE
        bcc _F371
        plx
        rtl

        .databank 0

        ; 95/F37D

      rlUnknown95F37D ; 95/F37D

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this: no title timeline names it.

        lda #(`aUnknown99FDB6)<<8
        sta lR18+1
        lda #<>aUnknown99FDB6
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        lda #(`aUnknown99FDBB)<<8
        sta lR18+1
        lda #<>aUnknown99FDBB
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        lda #(`aUnknown99FDC0)<<8
        sta lR18+1
        lda #<>aUnknown99FDC0
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        lda #(`aUnknown95F3C5)<<8
        sta lR18+1
        lda #<>aUnknown95F3C5
        sta lR18
        jsl rlBattleSceneWriteRAM
        rtl

        .databank 0

        ; 95/F3C5

      aUnknown95F3C5 ; 95/F3C5

        ; Nothing in the build reaches this: rlUnknown95F37D writes it.

        WRITE_RAM_BYTE bBufferTM, $12
        WRITE_RAM_BYTE bBufferTS, $01
        WRITE_RAM_BYTE bBufferCGWSEL, $02
        WRITE_RAM_BYTE bBufferCGADSUB, $02
        WRITE_RAM_END

    .endsection TitleScenes95F35DSection


    .section Unsorted95F3D3Section

      .al
      .xl

      rlUnknown95F3D3 ; 95/F3D3

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown99FDC5)<<8
        sta lR18+1
        lda #<>aUnknown99FDC5
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        rtl

        .databank 0

        ; 95/F3E7

      rlUnknown95F3E7 ; 95/F3E7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$7FFF

        _F3EE
        sta $0162,b,x
        inc x
        inc x
        cpx #$001E
        bcc _F3EE
        plx
        lda #(`aUnknown99FDCD)<<8
        sta lR18+1
        lda #<>aUnknown99FDCD
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        lda #(`aUnknown95F41B)<<8
        sta lR18+1
        lda #<>aUnknown95F41B
        sta lR18
        jsl rlBattleSceneWriteRAM
        rtl

        .databank 0

        ; 95/F41B

    .endsection Unsorted95F3D3Section


    .section Data95F41BSection

      .al
      .xl

      aUnknown95F41B ; 95/F41B

        WRITE_RAM_BYTE bBufferTM, $13
        WRITE_RAM_BYTE bBufferTS, $00
        WRITE_RAM_BYTE bBufferCGADSUB, $00
        WRITE_RAM_END

    .endsection Data95F41BSection


    .section Unsorted95F426Section

      .al
      .xl

      rlUnknown95F426 ; 95/F426

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$5AD6
        sta $011A,b
        lda #(`aUnknown99FE18)<<8
        sta lR18+1
        lda #<>aUnknown99FE18
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        rtl

        .databank 0

        ; 95/F440

      rlUnknown95F440 ; 95/F440

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown99FE20)<<8
        sta lR18+1
        lda #<>aUnknown99FE20
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        lda #(`aUnknown99FE25)<<8
        sta lR18+1
        lda #<>aUnknown99FE25
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        lda #(`aUnknown99FE2A)<<8
        sta lR18+1
        lda #<>aUnknown99FE2A
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        rtl

        .databank 0

        ; 95/F47A

      rlUnknown95F47A ; 95/F47A

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown97AE0A)<<8
        sta lR18+1
        lda #<>aUnknown97AE0A
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        rtl

        .databank 0

        ; 95/F48E

    .endsection Unsorted95F426Section


    .section Unsorted95F48ESection

      .al
      .xl

      rlUnknown95F48E ; 95/F48E

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD055
        phx
        ldx #$0000

        _F499
        stz $0202,b,x
        inc x
        inc x
        cpx #$001E
        bcc _F499
        plx
        jsl rlUnknown95F4B7
        lda #(`rlUnknown95F4B7)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown95F4B7
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 95/F4B7

    .endsection Unsorted95F48ESection


    .section Unsorted95F4B7Section

      .al
      .xl

      rlUnknown95F4B7 ; 95/F4B7

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD055
        bne _F4DE
        lda #$0014
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .word $EB88, $000F, $0102 ; 15 colours from $7EEB88 (filled by rlSetUpTitleIntroScene2) to palette offset $0102

        bcc _F4DE
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20
        jsl rlUnknown95F5B4

        _F4DE
        lda $7FD055
        inc a
        cmp #$0001
        bcc _F4EB
        lda #$0000

        _F4EB
        sta $7FD055
        rtl

        .databank 0

        ; 95/F4F0

    .endsection Unsorted95F4B7Section


    .section Unsorted95F4F0Section

      .al
      .xl

      rlUnknown95F4F0 ; 95/F4F0

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD055
        phx
        ldx #$0000

        _F4FB
        stz $0282,b,x
        inc x
        inc x
        cpx #$001E
        bcc _F4FB
        plx
        jsl rlUnknown95F519
        lda #(`rlUnknown95F519)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown95F519
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 95/F519

    .endsection Unsorted95F4F0Section


    .section Unsorted95F519Section

      .al
      .xl

      rlUnknown95F519 ; 95/F519

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD055
        bne _F540
        lda #$0014
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .word $EB88, $000F, $0182 ; 15 colours from $7EEB88 (filled by rlSetUpTitleIntroScene2) to palette offset $0182

        bcc _F540
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20
        jsl rlUnknown95F5B4

        _F540
        lda $7FD055
        inc a
        cmp #$0001
        bcc _F54D
        lda #$0000

        _F54D
        sta $7FD055
        rtl

        .databank 0

        ; 95/F552

    .endsection Unsorted95F519Section


    .section Unsorted95F552Section

      .al
      .xl

      rlUnknown95F552 ; 95/F552

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD055
        phx
        ldx #$0000

        _F55D
        stz $02A2,b,x
        inc x
        inc x
        cpx #$001E
        bcc _F55D
        plx
        jsl rlUnknown95F57B
        lda #(`rlUnknown95F57B)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown95F57B
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 95/F57B

    .endsection Unsorted95F552Section


    .section Unsorted95F57BSection

      .al
      .xl

      rlUnknown95F57B ; 95/F57B

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD055
        bne _F5A2
        lda #$0014
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .word $EB88, $000F, $01A2 ; 15 colours from $7EEB88 (filled by rlSetUpTitleIntroScene2) to palette offset $01A2

        bcc _F5A2
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20
        jsl rlUnknown95F5B4

        _F5A2
        lda $7FD055
        inc a
        cmp #$0001
        bcc _F5AF
        lda #$0000

        _F5AF
        sta $7FD055
        rtl

        .databank 0

        ; 95/F5B4

      rlUnknown95F5B4 ; 95/F5B4

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F5B8
        lda aTitleSprites.Flags,x
        bit #$0080
        beq _F5CC
        lda aTitleSprites.Attributes,x
        ora #$0400
        sta aTitleSprites.Attributes,x

        _F5CC
        txa
        clc
        adc #$0062
        tax
        cpx #$04FA
        bcc _F5B8
        plx
        rtl

        .databank 0

        ; 95/F5D9

    .endsection Unsorted95F57BSection


    .section TitleScenes95F5D9Section

      .al
      .xl

      rlUnknown95F5D9 ; 95/F5D9

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this: no title timeline names it.

        lda #$0000
        sta $7FD055
        jsl rlUnknown95F5F3
        lda #(`rlUnknown95F5F3)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown95F5F3
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 95/F5F3

      rlUnknown95F5F3 ; 95/F5F3

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD055
        bne _F618
        lda #$0000
        sta aPaletteFading.wDesiredColor,b
        lda #$0020
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToBlack

          .addr aUnknown95F62A

        bcc _F618
        sep #$20
        lda #$00
        sta aTitleTimelineSlots,x
        rep #$20

        _F618
        lda $7FD055
        inc a
        cmp #$0004
        bcc _F625
        lda #$0000

        _F625
        sta $7FD055
        rtl

        .databank 0

        ; 95/F62A

      aUnknown95F62A ; 95/F62A

        ; Palette fade list for rlFadePaletteToBlack (rlUnknown95F5F3).

        .word $0022, $000F
        .word $FFFF

    .endsection TitleScenes95F5D9Section


    .section Unsorted95F630Section

      .al
      .xl

      rlUnknown95F630 ; 95/F630

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD055
        jsl rlUnknown95F64A
        lda #(`rlUnknown95F64A)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown95F64A
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 95/F64A

    .endsection Unsorted95F630Section


    .section Unsorted95F64ASection

      .al
      .xl

      rlUnknown95F64A ; 95/F64A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD055
        bne _F66F
        lda #$0000
        sta aPaletteFading.wDesiredColor,b
        lda #$0020
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToBlack

          .addr aUnknown95F681

        bcc _F66F
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20

        _F66F
        lda $7FD055
        inc a
        cmp #$0004
        bcc _F67C
        lda #$0000

        _F67C
        sta $7FD055
        rtl

        .databank 0

        ; 95/F681

    .endsection Unsorted95F64ASection


    .section TitleScenes95F681Section

      .al
      .xl

      aUnknown95F681 ; 95/F681

        ; Palette fade list for rlFadePaletteToBlack (rlUnknown95F64A): palette offset and colour count, $FFFF ends it.

        .word $0062, $000F
        .word $0082, $000F
        .word $FFFF

      rlUnknown95F68B ; 95/F68B

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this: no title timeline names it.

        lda #$0000
        sta $7FD055
        phx
        ldx #$0000
        lda #$7FFF

        _F699
        sta $0122,b,x
        inc x
        inc x
        cpx #$009E
        bcc _F699
        ldx #$0000

        _F6A6
        sta $0202,b,x
        inc x
        inc x
        cpx #$00AE
        bcc _F6A6
        plx
        lda #(`rlUnknown95F6DC)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown95F6DC
        sta aTitleTimelineSlots.lRoutine,x
        lda #(`aUnknown95F3C5)<<8
        sta lR18+1
        lda #<>aUnknown95F3C5
        sta lR18
        jsl rlBattleSceneWriteRAM
        rtl

        .databank 0

        ; 95/F6CE

      aUnknown95F6CE ; 95/F6CE

        ; Nothing in the build reaches this.

        WRITE_RAM_BYTE bBufferTM, $11
        WRITE_RAM_BYTE bBufferTS, $02
        WRITE_RAM_BYTE bBufferCGWSEL, $02
        WRITE_RAM_BYTE bBufferCGADSUB, $01
        WRITE_RAM_END

      rlUnknown95F6DC ; 95/F6DC

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD055
        bne _F701
        lda #$0000
        sta aPaletteFading.wDesiredColor,b
        lda #$0020
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToBlack

          .addr aUnknown95F713

        bcc _F701
        sep #$20
        lda #$00
        sta aTitleTimelineSlots,x
        rep #$20

        _F701
        lda $7FD055
        inc a
        cmp #$0002
        bcc _F70E
        lda #$0000

        _F70E
        sta $7FD055
        rtl

        .databank 0

        ; 95/F713

      aUnknown95F713 ; 95/F713

        ; Palette fade list for rlFadePaletteToBlack (rlUnknown95F6DC).

        .word $0022, $000F
        .word $0042, $000F
        .word $0062, $000F
        .word $0082, $000F
        .word $00A2, $000F
        .word $0102, $000F
        .word $0122, $000F
        .word $0142, $000F
        .word $0162, $000F
        .word $0182, $000F
        .word $01A2, $000F
        .word $FFFF

    .endsection TitleScenes95F681Section


    .section Unsorted95F777Section

      .al
      .xl

      rlUnknown95F777 ; 95/F777

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown97F65A)<<8
        sta lR18+1
        lda #<>aUnknown97F65A
        sta lR18
        ldx #$0000
        jsl rlBattleSceneStartWindowEffect1
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth
        lda #$0080
        sta $7FEC1F
        lda #$7000
        sta $7FEC21
        lda #$0000
        sta $7FEC23
        rtl

        .databank 0

        ; 95/F7A5

      rlUnknown95F7A5 ; 95/F7A5

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown97A7C7._A411_A844)<<8
        sta lR18+1
        lda #<>aUnknown97A7C7._A411_A844
        sta lR18
        ldx #$0000
        jsl rlBattleSceneStartWindowEffect1
        rtl

        .databank 0

        ; 95/F7B7

    .endsection Unsorted95F777Section


    .section Unsorted95F7B7Section

      .al
      .xl

      rlUnknown95F7B7 ; 95/F7B7

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown97F64E)<<8
        sta lR18+1
        lda #<>aUnknown97F64E
        sta lR18
        ldx #$0000
        jsl rlBattleSceneStartWindowEffect1
        lda #$0000
        sta aUnit2DataBuffer._ROM.StrengthGrowth
        lda #$0080
        sta $7FEC1F
        lda #$9800
        sta $7FEC21
        lda #$0000
        sta $7FEC23
        rtl

        .databank 0

        ; 95/F7E5

      rlUnknown95F7E5 ; 95/F7E5

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown97A7C7)<<8
        sta lR18+1
        lda #<>aUnknown97A7C7
        sta lR18
        ldx #$0000
        jsl rlBattleSceneStartWindowEffect1
        rtl

        .databank 0

        ; 95/F7F7

    .endsection Unsorted95F7B7Section


    .section Unsorted95F831Section

      .al
      .xl

      rlUnknown95F831 ; 95/F831

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown97F666)<<8
        sta lR18+1
        lda #<>aUnknown97F666
        sta lR18
        ldx #$0000
        jsl rlBattleSceneStartWindowEffect2
        sep #$20
        lda #$01
        sta $7FED6E
        rep #$20
        lda #$0100
        sta $7FED6F
        lda #$00E8
        sta $7FED71
        rtl

        .databank 0

        ; 95/F85B

      rlUnknown95F85B ; 95/F85B

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown97F67F)<<8
        sta lR18+1
        lda #<>aUnknown97F67F
        sta lR18
        ldx #$0000
        jsl rlBattleSceneStartWindowEffect2
        rtl

        .databank 0

        ; 95/F86D

      rlUnknown95F86D ; 95/F86D

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown97F8CB)<<8
        sta lR18+1
        lda #<>aUnknown97F8CB
        sta lR18
        ldx #$0000
        jsl rlBattleSceneStartWindowEffect2
        rtl

        .databank 0

        ; 95/F87F

    .endsection Unsorted95F831Section


    .section TitleScenes95F9B4Section

      .al
      .xl

      rlStopTitleSprite ; 95/F9B4

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this: no title timeline names it.

        phx
        sta wR10
        lda #$0062
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        sep #$20
        lda #$00
        sta aTitleSprites
        rep #$20
        plx
        rtl

        .databank 0

        ; 95/F9CE

    .endsection TitleScenes95F9B4Section


    .section Unsorted95F9CESection

      .al
      .xl

      rlUnknown95F9CE ; 95/F9CE

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0436
        lda #(`aUnknown97F9AA)<<8
        sta lR18+1
        lda #<>aUnknown97F9AA
        sta lR18
        jsl rlStartTitleSprite
        ldx #$0498
        lda #(`aUnknown97F9B7)<<8
        sta lR18+1
        lda #<>aUnknown97F9B7
        sta lR18
        jsl rlStartTitleSprite
        sep #$20
        lda #$00
        sta $7FD8B6
        rep #$20
        rtl

        .databank 0

        ; 95/F9FB

      rlUnknown95F9FB ; 95/F9FB

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0372
        lda #(`aUnknown97F990)<<8
        sta lR18+1
        lda #<>aUnknown97F990
        sta lR18
        jsl rlStartTitleSprite
        ldx #$03D4
        lda #(`aUnknown97F99D)<<8
        sta lR18+1
        lda #<>aUnknown97F99D
        sta lR18
        jsl rlStartTitleSprite
        rtl

        .databank 0

        ; 95/FA1E

      rlUnknown95FA1E ; 95/FA1E

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$02AE
        lda #(`aUnknown97F976)<<8
        sta lR18+1
        lda #<>aUnknown97F976
        sta lR18
        jsl rlStartTitleSprite
        ldx #$0310
        lda #(`aUnknown97F983)<<8
        sta lR18+1
        lda #<>aUnknown97F983
        sta lR18
        jsl rlStartTitleSprite
        rtl

        .databank 0

        ; 95/FA41

      rlUnknown95FA41 ; 95/FA41

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0188
        lda #(`aUnknown97F95C)<<8
        sta lR18+1
        lda #<>aUnknown97F95C
        sta lR18
        jsl rlStartTitleSprite
        ldx #$01EA
        lda #(`aUnknown97F969)<<8
        sta lR18+1
        lda #<>aUnknown97F969
        sta lR18
        jsl rlStartTitleSprite
        rtl

        .databank 0

        ; 95/FA64

      rlUnknown95FA64 ; 95/FA64

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$00C4
        lda #(`aUnknown97F942)<<8
        sta lR18+1
        lda #<>aUnknown97F942
        sta lR18
        jsl rlStartTitleSprite
        ldx #$0126
        lda #(`aUnknown97F94F)<<8
        sta lR18+1
        lda #<>aUnknown97F94F
        sta lR18
        jsl rlStartTitleSprite
        rtl

        .databank 0

        ; 95/FA87

      rlUnknown95FA87 ; 95/FA87

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        lda #(`aUnknown97F928)<<8
        sta lR18+1
        lda #<>aUnknown97F928
        sta lR18
        jsl rlStartTitleSprite
        ldx #$0062
        lda #(`aUnknown97F935)<<8
        sta lR18+1
        lda #<>aUnknown97F935
        sta lR18
        jsl rlStartTitleSprite
        rtl

        .databank 0

        ; 95/FAAA

      rlUnknown95FAAA ; 95/FAAA

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$024C
        lda #(`aUnknown97F9C4)<<8
        sta lR18+1
        lda #<>aUnknown97F9C4
        sta lR18
        jsl rlStartTitleSprite
        rtl

        .databank 0

        ; 95/FABC

      rlUnknown95FABC ; 95/FABC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        ldx #$0000
        lda #$00

        _FAC4
        sta $7FD5EB,x
        inc x
        cpx #$000D
        bcc _FAC4
        rep #$20
        ldx #$0000
        lda #$0000

        _FAD6
        sta $7FD5F8,x
        inc x
        inc x
        cpx #$001A
        bcc _FAD6
        ldx #$0000

        _FAE4
        lda aUnknown97F64E+925,x
        sta $7FD612,x
        inc x
        inc x
        cpx #$001A
        bcc _FAE4
        lda #1,s
        tax
        jsl rlUnknown95FB0A
        lda #(`rlUnknown95FB0A)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown95FB0A
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 95/FB0A

    .endsection Unsorted95F9CESection


    .section Unsorted95FB0ASection

      .al
      .xl

      rlUnknown95FB0A ; 95/FB0A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta wR9
        ldx #$0000

        _FB13
        lda $7FD5EB,x
        and #$00FF
        cmp #$0003
        bne _FB23
        inc wR9
        bra _FB2F


        _FB23
        sta wR0
        txy
        phx
        lda wR0
        asl a
        tax
        jsr (aUnknown95FB4B,x)
        plx

        _FB2F
        inc x
        cpx #$000D
        bcc _FB13
        lda wR9
        cmp #$000D
        bcc _FB49
        lda #1,s
        tax
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20

        _FB49
        plx
        rtl

        .databank 0

        ; 95/FB4B

    .endsection Unsorted95FB0ASection


    .section Table95FB4BSection

      .al
      .xl

      aUnknown95FB4B ; 95/FB4B

        ; Jump table of rlUnknown95FB0A.
        .word <>rsUnknown95FB51
        .word <>rsUnknown95FB7C
        .word <>rsUnknown95FBD1
      rsUnknown95FB51 ; 95/FB51

        .al
        .xl
        .autsiz
        .databank ?

        tya
        asl a
        tax
        lda $7FD612,x
        bne _FB6E
        lda #$0018
        sta $7FD612,x
        tyx
        sep #$20
        lda #$01
        sta $7FD5EB,x
        rep #$20
        bra _FB77


        _FB6E
        lda $7FD612,x
        dec a
        sta $7FD612,x

        _FB77
        tyx
        jsr rsUnknown95FC23
        rts

        .databank 0

        ; 95/FB7C

      rsUnknown95FB7C ; 95/FB7C

        .al
        .xl
        .autsiz
        .databank ?

        tya
        asl a
        tax
        lda $7FD612,x
        bne _FBC3
        tyx
        sep #$20
        lda #$02
        sta $7FD5EB,x
        rep #$20
        tya
        pha
        asl a
        clc
        adc #1,s
        sta #1,s
        pla
        tax
        lda aUnknown97FA1F,x
        sta lR18
        lda aUnknown97FA1F+1,x
        sta lR18+1
        tya
        asl a
        tax
        lda aUnknown97F9D1,x
        tax
        lda lR18
        sta aTitleSprites.Script,x
        lda lR18+1
        sta $7FD095,x
        lda #$0004
        jsl rlStartTitleSpriteAfterimage
        bra _FBCC


        _FBC3
        lda $7FD612,x
        dec a
        sta $7FD612,x

        _FBCC
        tyx
        jsr rsUnknown95FC23
        rts

        .databank 0

        ; 95/FBD1

      rsUnknown95FBD1 ; 95/FBD1

        .al
        .xl
        .autsiz
        .databank ?

        tya
        asl a
        tax
        lda $7FD5F8,x
        xba
        and #$00FF
        sta wR0
        phx
        lda aUnknown97F9D1,x
        tax
        lda aTitleSprites.Y,x
        sec
        sbc wR0
        and #$00FF
        sta aTitleSprites.Y,x
        cmp #$00E0
        bcc _FC10
        cmp #$00F0
        bcs _FC10
        sep #$20
        lda #$00
        sta aTitleSprites.Flags,x
        plx
        tyx
        lda #$03
        sta $7FD5EB,x
        rep #$20
        bra _FC22


        _FC10
        plx
        lda $7FD5F8,x
        cmp #$0800
        bcs _FC22
        clc
        adc #$0010
        sta $7FD5F8,x

        _FC22
        rts

        .databank 0

        ; 95/FC23

      rsUnknown95FC23 ; 95/FC23

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FD8B6
        and #$00FF
        bne _FC4F
        txa
        asl a
        tax
        lda aUnknown97FA05,x
        sta wR0
        lda aUnknown97F9D1,x
        tax
        lda wBufferBG1VOFS
        eor #$FFFF
        inc a
        clc
        adc #$0130
        clc
        adc wR0
        and #$00FF
        sta aTitleSprites.Y,x

        _FC4F
        plx
        rts

        .databank 0

        ; 95/FC51

      rlUnknown95FC51 ; 95/FC51

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this: no title timeline names it. It installs
        ; rlUnknown95FC6B as a title timeline slot routine, like rlUnknown95F630.

        lda #$0000
        sta wTitleBrightnessStep
        jsl rlUnknown95FC6B
        lda #(`rlUnknown95FC6B)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown95FC6B
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 95/FC6B

      rlUnknown95FC6B ; 95/FC6B

        .al
        .xl
        .autsiz
        .databank ?

        lda wTitleBrightnessStep
        bne _FC92
        sep #$20
        lda $7FD072
        cmp #$0F
        beq _FC84
        inc a
        sta $7FD072
        rep #$20
        bra _FC92


        _FC84
        .as
        rep #$20
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20
        bra _FCA3


        _FC92
        lda wTitleBrightnessStep
        inc a
        cmp #$000A
        bcc _FC9F
        lda #$0000

        _FC9F
        sta wTitleBrightnessStep

        _FCA3
        rtl

        .databank 0

        ; 95/FCA4

    .endsection Table95FB4BSection


    .section Unsorted95FCA4Section

      .al
      .xl

      rlStartTitleSceneFadeIn ; 95/FCA4

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta wTitleBrightnessStep
        lda #(`aTitleSceneFadeInBrightness)<<8
        sta lTitleBrightnessList+1
        lda #<>aTitleSceneFadeInBrightness
        sta lTitleBrightnessList
        jsl rlRunTitleBrightnessList
        lda #(`rlRunTitleBrightnessList)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlRunTitleBrightnessList
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 95/FCCC

      rlStartTitleFadeIn ; 95/FCCC

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta wTitleBrightnessStep
        lda #(`aTitleFadeInBrightness)<<8
        sta lTitleBrightnessList+1
        lda #<>aTitleFadeInBrightness
        sta lTitleBrightnessList
        jsl rlRunTitleBrightnessList
        lda #(`rlRunTitleBrightnessList)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlRunTitleBrightnessList
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 95/FCF4

      rlStartTitleSceneFadeOut ; 95/FCF4

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta wTitleBrightnessStep
        lda #(`aTitleSceneFadeOutBrightness)<<8
        sta lTitleBrightnessList+1
        lda #<>aTitleSceneFadeOutBrightness
        sta lTitleBrightnessList
        jsl rlRunTitleBrightnessList
        lda #(`rlRunTitleBrightnessList)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlRunTitleBrightnessList
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 95/FD1C

    .endsection Unsorted95FCA4Section


    .section Unsorted95FD1CSection

      .al
      .xl

      rlStartTitleQuickFadeOut ; 95/FD1C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta wTitleBrightnessStep
        lda #(`aTitleQuickFadeOutBrightness)<<8
        sta lTitleBrightnessList+1
        lda #<>aTitleQuickFadeOutBrightness
        sta lTitleBrightnessList
        jsl rlRunTitleBrightnessList
        lda #(`rlRunTitleBrightnessList)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlRunTitleBrightnessList
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 95/FD44

    .endsection Unsorted95FD1CSection


    .section Unsorted95FD44Section

      .al
      .xl

      rlRunTitleBrightnessList ; 95/FD44

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $7FD8B7
        and #$00FF
        bne _FD84
        lda lTitleBrightnessList
        sta lR18
        lda lTitleBrightnessList+1
        sta lR18+1
        lda wTitleBrightnessStep
        tay
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        beq _FD7A
        sep #$20
        sta bBufferINIDISP
        rep #$20
        lda wTitleBrightnessStep
        inc a
        sta wTitleBrightnessStep
        bra _FD84


        _FD7A
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20

        _FD84
        ply
        rtl

        .databank 0

        ; 95/FD86

      rlStartTitleIntroScene1Scroll ; 95/FD86

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7FD046
        sta $7FD048
        jsl rlTitleIntroScene1Scroll
        lda #(`rlTitleIntroScene1Scroll)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlTitleIntroScene1Scroll
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 95/FDA6

      rlTitleIntroScene1Scroll ; 95/FDA6

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD046
        bne _FDB1
        lda wBufferBG1VOFS
        dec a
        sta wBufferBG1VOFS

        _FDB1
        lda $7FD046
        inc a
        cmp #$0006
        bcc _FDBE
        lda #$0000

        _FDBE
        sta $7FD046
        lda $7FD048
        bne _FDD2
        lda wBufferBG2HOFS
        dec a
        sta wBufferBG2HOFS
        lda wBufferBG2VOFS
        inc a
        sta wBufferBG2VOFS

        _FDD2
        lda $7FD048
        inc a
        cmp #$0003
        bcc _FDDF
        lda #$0000

        _FDDF
        sta $7FD048
        rtl

        .databank 0

        ; 95/FDE4

    .endsection Unsorted95FD44Section


    .section TitleScenes95FDE4Section

      .al
      .xl

      rlUnknown95FDE4 ; 95/FDE4

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this: no title timeline names it.

        phx
        lda #$0000
        sta $7FD046
        jsl rlUnknown95FE00
        lda #(`rlUnknown95FE00)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown95FE00
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 95/FE00

      rlUnknown95FE00 ; 95/FE00

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD046
        bne _FE10
        lda wBufferBG2HOFS
        dec a
        sta wBufferBG2HOFS
        lda wBufferBG2VOFS
        inc a
        sta wBufferBG2VOFS

        _FE10
        lda $7FD046
        inc a
        cmp #$0003
        bcc _FE1D
        lda #$0000

        _FE1D
        sta $7FD046
        rtl

        .databank 0

        ; 95/FE22

    .endsection TitleScenes95FDE4Section


    .section Unsorted95FE22Section

      .al
      .xl

      rlStartTitleIntroScene2Scroll ; 95/FE22

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7FD046
        sta $7FD048
        sta $7FD04A
        jsl rlTitleIntroScene2Scroll
        lda #(`rlTitleIntroScene2Scroll)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlTitleIntroScene2Scroll
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 95/FE46

    .endsection Unsorted95FE22Section


    .section Unsorted95FE46Section

      .al
      .xl

      rlTitleIntroScene2Scroll ; 95/FE46

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD046
        bne _FE56
        lda wBufferBG1VOFS
        dec a
        sta wBufferBG1VOFS
        lda wBufferBG2VOFS
        dec a
        sta wBufferBG2VOFS

        _FE56
        lda $7FD046
        inc a
        cmp #$0006
        bcc _FE63
        lda #$0000

        _FE63
        sta $7FD046
        lda $7FD048
        bne _FE72
        lda wBufferBG3HOFS
        inc a
        sta wBufferBG3HOFS

        _FE72
        lda $7FD048
        inc a
        cmp #$0004
        bcc _FE7F
        lda #$0000

        _FE7F
        sta $7FD048
        lda $7FD04A
        bne _FE8E
        lda wBufferBG3VOFS
        dec a
        sta wBufferBG3VOFS

        _FE8E
        lda $7FD04A
        inc a
        cmp #$0008
        bcc _FE9B
        lda #$0000

        _FE9B
        sta $7FD04A
        rtl

        .databank 0

        ; 95/FEA0

    .endsection Unsorted95FE46Section


    .section Unsorted95FEA0Section

      .al
      .xl

      rlStartTitleIntroScene3Scroll ; 95/FEA0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7FD046
        jsl rlTitleIntroScene3Scroll
        lda #(`rlTitleIntroScene3Scroll)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlTitleIntroScene3Scroll
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 95/FEBC

    .endsection Unsorted95FEA0Section


    .section Unsorted95FEBCSection

      .al
      .xl

      rlTitleIntroScene3Scroll ; 95/FEBC

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD046
        bne _FEC7
        lda wBufferBG3VOFS
        inc a
        sta wBufferBG3VOFS

        _FEC7
        lda $7FD046
        inc a
        cmp #$0001
        bcc _FED4
        lda #$0000

        _FED4
        sta $7FD046
        rtl

        .databank 0

        ; 95/FED9

    .endsection Unsorted95FEBCSection


    .section Unsorted95FED9Section

      .al
      .xl

      rlStartTitleIntroScene5Scroll ; 95/FED9

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7FD046
        sta $7FD048
        jsl rlTitleIntroScene5Scroll
        lda #(`rlTitleIntroScene5Scroll)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlTitleIntroScene5Scroll
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 95/FEF9

    .endsection Unsorted95FED9Section


    .section Unsorted95FEF9Section

      .al
      .xl

      rlTitleIntroScene5Scroll ; 95/FEF9

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD046
        bne _FF04
        lda wBufferBG1VOFS
        dec a
        sta wBufferBG1VOFS

        _FF04
        lda $7FD046
        inc a
        cmp #$0005
        bcc _FF11
        lda #$0000

        _FF11
        sta $7FD046
        lda $7FD048
        bne _FF23
        lda wBufferBG3VOFS
        sec
        sbc #$0002
        sta wBufferBG3VOFS

        _FF23
        lda $7FD048
        inc a
        cmp #$0001
        bcc _FF30
        lda #$0000

        _FF30
        sta $7FD048
        rtl

        .databank 0

        ; 95/FF35

    .endsection Unsorted95FEF9Section


    .section Unsorted95FF35Section

      .al
      .xl

      rlStartTitleIntroScene6Scroll ; 95/FF35

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7FD046
        jsl rlTitleIntroScene6Scroll
        lda #(`rlTitleIntroScene6Scroll)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlTitleIntroScene6Scroll
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 95/FF51

    .endsection Unsorted95FF35Section


    .section Unsorted95FF51Section

      .al
      .xl

      rlTitleIntroScene6Scroll ; 95/FF51

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD046
        bne _FF5C
        lda wBufferBG1VOFS
        inc a
        sta wBufferBG1VOFS

        _FF5C
        lda $7FD046
        inc a
        cmp #$0002
        bcc _FF69
        lda #$0000

        _FF69
        sta $7FD046
        rtl

        .databank 0

        ; 95/FF6E

    .endsection Unsorted95FF51Section


    .section Unsorted95FF6ESection

      .al
      .xl

      rlStartTitleIntroScene7Scroll ; 95/FF6E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7FD048
        jsl rlTitleIntroScene7Scroll
        lda #(`rlTitleIntroScene7Scroll)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlTitleIntroScene7Scroll
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 95/FF8A

    .endsection Unsorted95FF6ESection


    .section Unsorted95FF8ASection

      .al
      .xl

      rlTitleIntroScene7Scroll ; 95/FF8A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD048
        bne _FF9A
        lda wBufferBG2HOFS
        dec a
        sta wBufferBG2HOFS
        lda wBufferBG2VOFS
        inc a
        sta wBufferBG2VOFS

        _FF9A
        lda $7FD048
        inc a
        cmp #$0003
        bcc _FFA7
        lda #$0000

        _FFA7
        sta $7FD048
        rtl

        .databank 0

        ; 95/FFAC
; Routines found by tools/trace.py. Each was reached from code in the build.

    .endsection Unsorted95FF8ASection


    .section TitleScenes95FFACSection

      .al
      .xl

      rlUnknown95FFAC ; 95/FFAC

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this: no title timeline names it. Plays sound 2.

        lda #$0002
        jsl rlPlaySoundEffect2
        rtl

        .databank 0

        ; 95/FFB4

    .endsection TitleScenes95FFACSection


    .section Unsorted9BE15FSection

      .al
      .xl

      rlStopTitleTimelineSlot ; 9B/E15F

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the slot.

        phx
        sta wR10
        lda #$0004
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20
        plx
        rtl

        .databank 0

        ; 9B/E179

    .endsection Unsorted9BE15FSection


    .section Unsorted9BE179Section

      .al
      .xl

      rlUnknown9BE179 ; 9B/E179

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$08
        sta $7FD074
        rep #$20
        rtl

        .databank 0

        ; 9B/E184

      rlUnknown9BE184 ; 9B/E184

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        sep #$20
        lda $7FD074
        cmp #$02
        bcc _E1A4
        dec a
        sta $7FD06B,x
        lda #$00
        sta $7FD06C,x
        sta $7FD06D,x
        inc x
        inc x
        inc x

        _E1A4
        lda #$01
        sta $7FD06B,x
        lda bBufferTM
        sta $7FD06C,x
        lda bBufferTS
        sta $7FD06D,x
        lda #$00
        sta $7FD06E,x
        rep #$20
        plx
        rtl

        .databank 0

        ; 9B/E1C0

      rlLoadTitleIntroGraphics ; 9B/E1C0

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the BG tilemap, decompresses and uploads the intro's graphics and sets its first palettes (rlSetUpTitleIntro).

        phx
        ldx #$0000
        lda #$0080

        _E1C7
        sta $7E8B88,x
        inc x
        inc x
        cpx #$0140
        bcc _E1C7
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0140, $80, $FE00

        sep #$20
        rep #$10
        ldx #<>gcUnknownF3426A
        stx DecompressionVariables
        lda #`gcUnknownF3426A
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $6000, $80, $0000

        sep #$20
        rep #$10
        ldx #<>gcUnknownF40F1E
        stx DecompressionVariables
        lda #`gcUnknownF40F1E
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $1000, $80, $6000

        sep #$20
        rep #$10
        ldx #<>gcUnknownF468D3
        stx DecompressionVariables
        lda #`gcUnknownF468D3
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $2000, $80, $C000

        sep #$20
        rep #$10
        ldx #<>gcUnknownF47CBD
        stx DecompressionVariables
        lda #`gcUnknownF47CBD
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0800, $80, $E000

        ldx #$0000

        _E286
        lda aUnknownE02299,x
        sta $0162,b,x
        lda aUnknownE023B1,x
        sta $0142,b,x
        lda aUnknownE02787,x
        sta $0102,b,x
        inc x
        inc x
        cpx #$001E
        bcc _E286
        plx
        rtl

        .databank 0

        ; 9B/E2A4

    .endsection Unsorted9BE179Section


    .section Unsorted9BE2A4Section

      .al
      .xl

      rlUnknown9BE2A4 ; 9B/E2A4

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldy #$0000
        ldx #$0000

        _E2AC
        lda aUnknown97F64E+1016,x
        sta lR18
        lda aUnknown97F64E+1017,x
        sta lR18+1
        phx
        tyx
        jsl rlStartTitleSprite
        pla
        clc
        adc #$0003
        tax
        tya
        clc
        adc #$0062
        tay
        cpx #$0024
        bcc _E2AC
        lda #$5C00
        sta $7FD62D
        sep #$20
        lda #$6F
        sta $7FD62C
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 9B/E2E3

    .endsection Unsorted9BE2A4Section


    .section TitleScenes9BE2E3Section

      .al
      .xl

      rlUnknown9BE2E3 ; 9B/E2E3

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this: no title timeline names it.

        phx
        phy
        ldx #$0000

        _E2E8
        lda #$0005
        jsl rlStartTitleSpriteAfterimage
        txa
        clc
        adc #$0062
        tax
        cpx #$0498
        bcc _E2E8
        ply
        plx
        rtl

        .databank 0

        ; 9B/E2FD

    .endsection TitleScenes9BE2E3Section


    .section Unsorted9BE2FDSection

      .al
      .xl

      rlUnknown9BE2FD ; 9B/E2FD

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _E302
        lda #$0003
        jsl rlStartTitleSpriteAfterimage
        txa
        clc
        adc #$0062
        tax
        cpx #$024C
        bcc _E302
        ply
        plx
        rtl

        .databank 0

        ; 9B/E317

      rlUnknown9BE317 ; 9B/E317

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$024C

        _E31C
        lda #$0003
        jsl rlStartTitleSpriteAfterimage
        txa
        clc
        adc #$0062
        tax
        cpx #$0498
        bcc _E31C
        ply
        plx
        rtl

        .databank 0

        ; 9B/E331

    .endsection Unsorted9BE2FDSection


    .section TitleScenes9BE331Section

      .al
      .xl

      rlUnknown9BE331 ; 9B/E331

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this: no title timeline names it.

        phx
        phy
        ldx #$0000

        _E336
        sep #$20
        lda aTitleSprites.TrailDelay,x
        bne _E34A
        lda aTitleSprites,x
        and #$FE
        sta aTitleSprites,x
        bra _E34F


        _E34A
        dec a
        sta aTitleSprites.TrailDelay,x

        _E34F
        rep #$20
        txa
        clc
        adc #$0062
        tax
        cpx #$0498
        bcc _E336
        lda aTitleSprites.TrailDelay,x
        and #$00FF
        bne _E36F
        sep #$20
        lda #$00
        sta aTitleTimelineSlots,x
        rep #$20

        _E36F
        ply
        plx
        rtl

        .databank 0

        ; 9B/E372

    .endsection TitleScenes9BE331Section


    .section Unsorted9BE372Section

      .al
      .xl

      rlUnknown9BE372 ; 9B/E372

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FD62C
        clc
        adc #$01
        sta $7FD62C
        rep #$20
        lda $7FD62D
        sec
        sbc #$0080
        cmp #$2C00
        bcs _E391
        lda #$2C00

        _E391
        sta $7FD62D
        rtl

        .databank 0

        ; 9B/E396

      rlUnknown9BE396 ; 9B/E396

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD631
        jsl rlUnknown9BE3B0
        lda #(`rlUnknown9BE3B0)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BE3B0
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 9B/E3B0

    .endsection Unsorted9BE372Section


    .section Unsorted9BE3B0Section

      .al
      .xl

      rlUnknown9BE3B0 ; 9B/E3B0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FD631
        lsr a
        lsr a
        lsr a
        tax
        lda aUnknown97FB12+662,x
        and #$00FF
        sta wR0
        lda $7FD631
        and #$0007
        tax
        lda aUnknown97FB12+679,x
        and #$00FF
        and wR0
        beq _E3DA
        lda #$0001
        bra _E3DD


        _E3DA
        lda #$0000

        _E3DD
        sep #$20
        pha
        lda $7FD62C
        clc
        adc #1,s
        sta $7FD62C
        pla
        rep #$20
        lda $7FD631
        inc a
        sta $7FD631
        cmp #$0088
        bcc _E409
        lda #1,s
        tax
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20

        _E409
        plx
        rtl

        .databank 0

        ; 9B/E40B

    .endsection Unsorted9BE3B0Section


    .section Unsorted9BE40BSection

      .al
      .xl

      rlUnknown9BE40B ; 9B/E40B

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD62D
        clc
        adc #$0400
        cmp #$7000
        bcc _E430
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20
        lda #$0002
        jsl rlStopTitleTimelineSlot
        jsl rlClearTitleSprites
        lda #$5C00

        _E430
        sta $7FD62D
        rtl

        .databank 0

        ; 9B/E435

      rlUnknown9BE435 ; 9B/E435

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _E43A
        phx
        lda aUnknown97FAF9+13,x
        clc
        adc $7FD62C
        and #$00FF
        sta wR0
        pha
        lda $7FD62D
        xba
        and #$00FF
        sta wR10
        lda #$00DB
        sta wR11
        phx
        jsl rlUnsignedMultiply16By16
        plx
        lda wR12
        jsl rlMultiplyByNegSin._8B84
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        and #$01FF
        bit #$0100
        beq _E477
        ora #$FE00

        _E477
        sta wR8
        pla
        sta wR0
        lda $7FD62D
        jsl rlMultiplyByNegSin
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        and #$01FF
        bit #$0100
        beq _E496
        ora #$FE00

        _E496
        sta wR9
        plx
        phx
        stx wR10
        lda #$0062
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda #$0080
        clc
        adc wR8
        and #$01FF
        sta aTitleSprites.X,x
        lda #$0068
        clc
        adc wR9
        and #$01FF
        bit #$0100
        beq _E4C5
        lda #$00F0

        _E4C5
        sta aTitleSprites.Y,x
        plx
        inc x
        cpx #$0006
        bcs _E4D4
        jml _E43A


        _E4D4
        jsl rlUnknown9BE4DB
        ply
        plx
        rtl

        .databank 0

        ; 9B/E4DB

    .endsection Unsorted9BE40BSection


    .section Unsorted9BE4DBSection

      .al
      .xl

      rlUnknown9BE4DB ; 9B/E4DB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #$0080
        sec
        sbc aTitleSprites.X
        clc
        adc #$0080
        and #$01FF
        sta $7FD2DC
        lda #$0068
        sec
        sbc aTitleSprites.Y
        clc
        adc #$0068
        sta $7FD2DE
        lda #$0080
        sec
        sbc $7FD0F2
        clc
        adc #$0080
        and #$01FF
        sta $7FD33E
        lda #$0068
        sec
        sbc $7FD0F4
        clc
        adc #$0068
        sta $7FD340
        lda #$0080
        sec
        sbc $7FD154
        clc
        adc #$0080
        and #$01FF
        sta $7FD3A0
        lda #$0068
        sec
        sbc $7FD156
        clc
        adc #$0068
        sta $7FD3A2
        lda #$0080
        sec
        sbc $7FD1B6
        clc
        adc #$0080
        and #$01FF
        sta $7FD402
        lda #$0068
        sec
        sbc $7FD1B8
        clc
        adc #$0068
        sta $7FD404
        lda #$0080
        sec
        sbc $7FD218
        clc
        adc #$0080
        and #$01FF
        sta $7FD464
        lda #$0068
        sec
        sbc $7FD21A
        clc
        adc #$0068
        sta $7FD466
        lda #$0080
        sec
        sbc $7FD27A
        clc
        adc #$0080
        and #$01FF
        sta $7FD4C6
        lda #$0068
        sec
        sbc $7FD27C
        clc
        adc #$0068
        sta $7FD4C8
        ply
        plx
        rtl

        .databank 0

        ; 9B/E5B2

    .endsection Unsorted9BE4DBSection


    .section Unsorted9BE5B2Section

      .al
      .xl

      rlUnknown9BE5B2 ; 9B/E5B2

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`rlUnknown9BE619)<<8
        sta lTitleVBlankRoutine1+1
        lda #<>rlUnknown9BE619
        sta lTitleVBlankRoutine1
        lda #(`aUnknown95E78F)<<8
        sta lR44+1
        lda #<>aUnknown95E78F
        sta lR44
        lda #$0004
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #(`rlUnknown9BE5E4)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BE5E4
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 9B/E5E4

      rlUnknown9BE5E4 ; 9B/E5E4

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #$7F00
        sta lR18+1
        lda wTitleScreenFrame
        bit #$0001
        beq _E5F9
        lda #$D665
        bra _E5FC


        _E5F9
        lda #$D6F5

        _E5FC
        sta lR18
        ldx #$0000
        ldy #$0000

        _E604
        lda wBufferBG2HOFS
        clc
        adc aUnknown97FB12,x
        sta [lR18],y
        inc y
        inc y
        inc x
        inc x
        cpx #$0040
        bcc _E604
        ply
        plx
        rtl

        .databank 0

        ; 9B/E619

      rlUnknown9BE619 ; 9B/E619

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda wTitleScreenFrame
        bit #$0001
        bne _E629
        lda #$D665
        bra _E62C


        _E629
        lda #$D6F5

        _E62C
        pha
        lda #$00A0
        sta $7FD636
        lda #1,s
        sta $7FD637
        lda #$00A0
        sta $7FD639
        lda #1,s
        sta $7FD63A
        lda #$00A0
        sta $7FD63C
        lda #1,s
        sta $7FD63D
        lda #$00A0
        sta $7FD63F
        lda #1,s
        sta $7FD640
        lda #$00A0
        sta $7FD642
        lda #1,s
        sta $7FD643
        lda #$009D
        sta $7FD645
        lda #1,s
        sta $7FD646
        pla
        lda #$0007
        sta $7FD633
        lda #$0000
        sta $7FD634
        sep #$20
        lda #$00
        sta $7FD648
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 9B/E697

    .endsection Unsorted9BE5B2Section


    .section Unsorted9BE697Section

      .al
      .xl

      rlUnknown9BE697 ; 9B/E697

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0004
        jsl rlStopTitleTimelineSlot
        lda #$0000
        sta lTitleVBlankRoutine1
        rtl

        .databank 0

        ; 9B/E6AD

      rlUnknown9BE6AD ; 9B/E6AD

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`rlUnknown9BE714)<<8
        sta lTitleVBlankRoutine1+1
        lda #<>rlUnknown9BE714
        sta lTitleVBlankRoutine1
        lda #(`aUnknown95E78F)<<8
        sta lR44+1
        lda #<>aUnknown95E78F
        sta lR44
        lda #$0004
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #(`rlUnknown9BE6DF)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BE6DF
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 9B/E6DF

    .endsection Unsorted9BE697Section


    .section TitleScenes9BE6DFSection

      .al
      .xl

      rlUnknown9BE6DF ; 9B/E6DF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #$7F00
        sta lR18+1
        lda wTitleScreenFrame
        bit #$0001
        beq _E6F4
        lda #$D665
        bra _E6F7


        _E6F4
        lda #$D785

        _E6F7
        sta lR18
        ldx #$0000
        ldy #$0000

        _E6FF
        lda wBufferBG2HOFS
        clc
        adc aUnknown97FB52,x
        sta [lR18],y
        inc y
        inc y
        inc x
        inc x
        cpx #$0040
        bcc _E6FF
        ply
        plx
        rtl

        .databank 0

        ; 9B/E714

      rlUnknown9BE714 ; 9B/E714

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda wTitleScreenFrame
        bit #$0001
        bne _E724
        lda #$D665
        bra _E727


        _E724
        lda #$D785

        _E727
        pha
        lda #$00A0
        sta $7FD633
        lda #1,s
        sta $7FD634
        lda #$00A0
        sta $7FD636
        lda #1,s
        sta $7FD637
        lda #$00A0
        sta $7FD639
        lda #1,s
        sta $7FD63A
        lda #$00A0
        sta $7FD63C
        lda #1,s
        sta $7FD63D
        lda #$00A0
        sta $7FD63F
        lda #1,s
        sta $7FD640
        lda #$00A0
        sta $7FD642
        lda #1,s
        sta $7FD643
        lda #$009F
        sta $7FD645
        lda #1,s
        sta $7FD646
        pla
        sep #$20
        lda #$00
        sta $7FD648
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 9B/E791

    .endsection TitleScenes9BE6DFSection


    .section Unsorted9BE791Section

      .al
      .xl

      rlUnknown9BE791 ; 9B/E791

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0004
        jsl rlStopTitleTimelineSlot
        lda #$0000
        sta lTitleVBlankRoutine1
        rtl

        .databank 0

        ; 9B/E7A7

      rlUnknown9BE7A7 ; 9B/E7A7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7FD057
        lda #$0040
        sta $7FD059
        lda #$0000
        sta $7FD05B
        lda #(`rlUnknown9BE88E)<<8
        sta lTitleVBlankRoutine2+1
        lda #<>rlUnknown9BE88E
        sta lTitleVBlankRoutine2
        lda #(`aUnknown95E79B)<<8
        sta lR44+1
        lda #<>aUnknown95E79B
        sta lR44
        lda #$0005
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        jsl rlUnknown9BE7F2
        lda #(`rlUnknown9BE7F2)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BE7F2
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 9B/E7F2

    .endsection Unsorted9BE791Section


    .section Unsorted9BE7F2Section

      .al
      .xl

      rlUnknown9BE7F2 ; 9B/E7F2

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #$7F00
        sta lR18+1
        sta lR19+1
        lda wTitleScreenFrame
        bit #$0001
        beq _E809
        lda #$D6F5
        bra _E80C


        _E809
        lda #$D815

        _E80C
        sta lR18
        clc
        adc #$0040
        sta lR19
        lda $7FD057
        sta wR1
        ldy #$0000

        _E81D
        lda wR1
        and #$00FF
        sta wR0
        lda $7FD059
        phy
        jsl rlMultiplyByNegSin
        ply
        sta [lR18],y
        eor #$FFFF
        sta [lR19],y
        lda wR1
        clc
        adc #$0004
        sta wR1
        inc y
        inc y
        cpy #$0040
        bcc _E81D
        lda $7FD05B
        and #$0003
        bne _E876
        lda $7FD059
        sec
        sbc #$0001
        sta $7FD059
        bcs _E876
        lda #3,s
        tax
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20
        lda #$0005
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0000
        sta lTitleVBlankRoutine2

        _E876
        lda $7FD057
        clc
        adc #$0008
        sta $7FD057
        lda $7FD05B
        inc a
        sta $7FD05B
        ply
        plx
        rtl

        .databank 0

        ; 9B/E88E

    .endsection Unsorted9BE7F2Section


    .section TitleScenes9BE88ESection

      .al
      .xl

      rlUnknown9BE88E ; 9B/E88E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda wTitleScreenFrame
        bit #$0001
        bne _E89E
        lda #$D6F5
        bra _E8A1


        _E89E
        lda #$D815

        _E8A1
        pha
        lda #$00C0
        sta $7FD64C
        lda #1,s
        sta $7FD64D
        lda #$00C0
        sta $7FD64F
        lda #1,s
        sta $7FD650
        lda #$00BF
        sta $7FD652
        lda #1,s
        sta $7FD653
        pla
        sep #$20
        lda #$00
        sta $7FD655
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 9B/E8D7

    .endsection TitleScenes9BE88ESection


    .section TitleScenes9BE8D7Section

      .al
      .xl

      rlUnknown9BE8D7 ; 9B/E8D7

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this: no title timeline names it.

        phx
        lda #$00C3
        sta $7FD057
        lda #(`rlUnknown9BE971)<<8
        sta lTitleVBlankRoutine2+1
        lda #<>rlUnknown9BE971
        sta lTitleVBlankRoutine2
        lda #(`aUnknown95E79B)<<8
        sta lR44+1
        lda #<>aUnknown95E79B
        sta lR44
        lda #$0005
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        jsl rlUnknown9BE914
        lda #(`rlUnknown9BE914)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BE914
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 9B/E914

      rlUnknown9BE914 ; 9B/E914

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #$7F00
        sta lR18+1
        lda wTitleScreenFrame
        bit #$0001
        beq _E929
        lda #$D6F5
        bra _E92C


        _E929
        lda #$D815

        _E92C
        sta lR18
        ldy #$0000
        lda $7FD057
        asl a
        tax

        _E937
        lda aUnknown97FB52+64,x
        sta [lR18],y
        inc x
        inc x
        inc y
        inc y
        cpy #$0090
        bcc _E937
        lda $7FD057
        bne _E969
        lda #3,s
        tax
        sep #$20
        lda #$00
        sta aTitleTimelineSlots,x
        rep #$20
        lda #$0005
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0000
        sta lTitleVBlankRoutine2
        bra _E96E


        _E969
        dec a
        sta $7FD057

        _E96E
        ply
        plx
        rtl

        .databank 0

        ; 9B/E971

      rlUnknown9BE971 ; 9B/E971

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda wTitleScreenFrame
        bit #$0001
        bne _E981
        lda #$D6F5
        bra _E984


        _E981
        lda #$D815

        _E984
        pha
        lda #$00B7
        sta $7FD64C
        lda #$0000
        sta $7FD64D
        lda #$00C8
        sta $7FD64F
        lda #1,s
        sta $7FD650
        pla
        sep #$20
        lda #$00
        sta $7FD652
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 9B/E9AE

    .endsection TitleScenes9BE8D7Section


    .section Unsorted9BE9AESection

      .al
      .xl

      rlUnknown9BE9AE ; 9B/E9AE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7FD087
        sta $7FD089
        lda #$FE2F
        sta $7FD083
        lda #$FE72
        sta $7FD085
        lda #(`rlUnknown9BEA5C)<<8
        sta lTitleVBlankRoutine2+1
        lda #<>rlUnknown9BEA5C
        sta lTitleVBlankRoutine2
        lda #(`aUnknown95E7A7)<<8
        sta lR44+1
        lda #<>aUnknown95E7A7
        sta lR44
        lda #$0002
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        jsl rlUnknown9BE9FD
        lda #(`rlUnknown9BE9FD)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BE9FD
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 9B/E9FD

    .endsection Unsorted9BE9AESection


    .section Unsorted9BE9FDSection

      .al
      .xl

      rlUnknown9BE9FD ; 9B/E9FD

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FD089
        and #$0003
        bne _EA50
        lda $7FD087
        bit #$0001
        bne _EA1A
        lda $7FD083
        inc a
        sta $7FD083

        _EA1A
        lda $7FD085
        cmp #$FE4E
        beq _EA2A
        dec a
        sta $7FD085
        bra _EA47


        _EA2A
        lda #3,s
        tax
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20
        lda #$0002
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0000
        sta lTitleVBlankRoutine2
        bra _EA59


        _EA47
        lda $7FD087
        inc a
        sta $7FD087

        _EA50
        lda $7FD089
        inc a
        sta $7FD089

        _EA59
        ply
        plx
        rtl

        .databank 0

        ; 9B/EA5C

    .endsection Unsorted9BE9FDSection


    .section TitleScenes9BEA5CSection

      .al
      .xl

      rlUnknown9BEA5C ; 9B/EA5C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda #$008F
        sta $7FD076
        lda $7FD083
        sta $7FD077
        lda #$0070
        sta $7FD079
        lda #$FE4E
        sta $7FD07A
        lda #$0045
        sta $7FD07C
        lda #$FE4E
        sta $7FD07D
        lda #$009B
        sta $7FD07F
        lda $7FD085
        sta $7FD080
        sep #$20
        lda #$00
        sta $7FD082
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 9B/EAA5

    .endsection TitleScenes9BEA5CSection


    .section TitleScenes9BF1F4Section

      .al
      .xl

      rlUnknown9BF1F4 ; 9B/F1F4

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this: no title timeline names it.

        lda #(`aUnknown99FDD5)<<8
        sta lR18+1
        lda #<>aUnknown99FDD5
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        lda $01E2,b
        ldx #$0000

        _F20D
        sta $0122,b,x
        inc x
        inc x
        cpx #$001E
        bcc _F20D
        rtl

        .databank 0

        ; 9B/F218

    .endsection TitleScenes9BF1F4Section


    .section Unsorted9BF218Section

      .al
      .xl

      rlUnknown9BF218 ; 9B/F218

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown99FDD5)<<8
        sta lR18+1
        lda #<>aUnknown99FDD5
        sta lR18
        lda #$0000
        sta wR0
        jsl rlBattleSceneStartPaletteEffect
        lda $01E2,b
        ldx #$0000

        _F231
        sta $0142,b,x
        inc x
        inc x
        cpx #$001E
        bcc _F231
        rtl

        .databank 0

        ; 9B/F23C

    .endsection Unsorted9BF218Section


    .section Unsorted9BF23CSection

      .al
      .xl

      rlUnknown9BF23C ; 9B/F23C

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD04E
        sep #$20
        lda #$E0
        sta bBufferCOLDATA_3
        lda #$00
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        rep #$20
        jsl rlUnknown9BF264
        lda #(`rlUnknown9BF264)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF264
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 9B/F264

      rlUnknown9BF264 ; 9B/F264

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD04E
        sep #$20
        pha
        lsr a
        ora #$E0
        sta bBufferCOLDATA_3
        pla
        cmp #$3E
        bne _F28B
        lda #$E0
        sta bBufferCOLDATA_3
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        rep #$20
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20
        bra _F296


        _F28B
        .as
        rep #$20
        lda $7FD04E
        inc a
        sta $7FD04E

        _F296
        rtl

        .databank 0

        ; 9B/F297

    .endsection Unsorted9BF23CSection


    .section Unsorted9BF3F3Section

      .al
      .xl

      rlUnknown9BF3F3 ; 9B/F3F3

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        txa

        _F3F7
        sta $7E9188,x
        inc x
        inc x
        cpx #$0600
        bcc _F3F7
        ldx #$0000

        _F405
        lda aUnknownE024E3,x
        and #$001F
        sta $7E8B88,x
        lda aUnknownE024E3,x
        and #$03E0
        sta $7E8D88,x
        lda aUnknownE024E3,x
        and #$7C00
        xba
        sta $7E8F88,x
        inc x
        inc x
        cpx #$0184
        bcc _F405
        lda #$8000
        sta $2181,b
        sep #$20
        lda #$01
        sta $2183,b
        rep #$20
        ldy #$0021

        _F440
        ldx #$0000

        _F443
        lda $7E8B88,x
        clc
        adc $7E9188,x
        sta $7E9188,x
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        pha
        lda $7E8D88,x
        clc
        adc aEventMovement.aMovementCostMap,x
        sta aEventMovement.aMovementCostMap,x
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        and #$03E0
        ora #1,s
        sta #1,s
        lda $7E8F88,x
        clc
        adc $7E9588,x
        sta $7E9588,x
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        xba
        and #$7C00
        ora #1,s
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        pla
        inc x
        inc x
        cpx #$0184
        bcc _F443
        dec y
        bne _F440
        rtl

        .databank 0

        ; 9B/F49E

    .endsection Unsorted9BF3F3Section


    .section Unsorted9BF49ESection

      .al
      .xl

      rlUnknown9BF49E ; 9B/F49E

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD05F
        sta $7FD063
        lda #$0020
        sta $7FD061
        lda #(`rlUnknown9BF4BF)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF4BF
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 9B/F4BF

    .endsection Unsorted9BF49ESection


    .section TitleScenes9BF4BFSection

      .al
      .xl

      rlUnknown9BF4BF ; 9B/F4BF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FD05F
        cmp #$0001
        beq _F4ED
        bcs _F534
        ldy #$0000
        lda $7FD063
        tax

        _F4D4
        lda $7F8000,x
        sta aBGPaletteBuffer.aPalette1,b,y
        lda $7F80C2,x
        sta aOAMPaletteBuffer,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0062
        bcc _F4D4
        bra _F534


        _F4ED
        ldy #$0000
        lda $7FD063
        tax

        _F4F5
        lda $7F8062,x
        sta $0182,b,y
        lda $7F8124,x
        sta $0262,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0060
        bcc _F4F5
        lda $7FD063
        clc
        adc #$0184
        sta $7FD063
        lda $7FD061
        dec a
        sta $7FD061
        bne _F534
        rep #$20
        lda #3,s
        tax
        sep #$20
        lda #$00
        sta aTitleTimelineSlots,x
        rep #$20
        bra _F545


        _F534
        lda $7FD05F
        inc a
        cmp #$0008
        bcc _F541
        lda #$0000

        _F541
        sta $7FD05F

        _F545
        ply
        plx
        rtl

        .databank 0

        ; 9B/F548

    .endsection TitleScenes9BF4BFSection


    .section Unsorted9BF548Section

      .al
      .xl

      rlUnknown9BF548 ; 9B/F548

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$7FFF

        _F54F
        sta aBGPaletteBuffer.aPalette1,b,x
        sta aOAMPaletteBuffer,b,x
        inc x
        inc x
        cpx #$00C2
        bcc _F54F
        lda #(`aUnknown9BF56C)<<8
        sta lR18+1
        lda #<>aUnknown9BF56C
        sta lR18
        jsl rlBattleSceneWriteRAM
        plx
        rtl

        .databank 0

        ; 9B/F56C

    .endsection Unsorted9BF548Section


    .section Data9BF56CSection

      .al
      .xl

      aUnknown9BF56C ; 9B/F56C

        WRITE_RAM_BYTE bBufferTM, $12
        WRITE_RAM_BYTE bBufferTS, $01
        WRITE_RAM_BYTE bBufferCGWSEL, $02
        WRITE_RAM_BYTE bBufferCGADSUB, $02
        WRITE_RAM_END

    .endsection Data9BF56CSection


    .section Unsorted9BF57ASection

      .al
      .xl

      rlUnknown9BF57A ; 9B/F57A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FD05F
        lda #$2EFC
        sta $7FD063
        lda #$0020
        sta $7FD061
        lda #(`rlUnknown9BF59E)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF59E
        sta aTitleTimelineSlots.lRoutine,x
        rtl

        .databank 0

        ; 9B/F59E

    .endsection Unsorted9BF57ASection


    .section TitleScenes9BF59ESection

      .al
      .xl

      rlUnknown9BF59E ; 9B/F59E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FD05F
        cmp #$0002
        beq _F5F6
        cmp #$0001
        beq _F5D5
        bcc _F5B4
        jml _F63D


        _F5B4
        ldy #$0000
        lda $7FD063
        tax

        _F5BC
        lda $7F8000,x
        sta aBGPaletteBuffer.aPalette1,b,y
        lda $7F80C2,x
        sta aOAMPaletteBuffer,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0042
        bcc _F5BC
        bra _F63D


        _F5D5
        ldy #$0000
        lda $7FD063
        tax

        _F5DD
        lda $7F8042,x
        sta $0162,b,y
        lda $7F8104,x
        sta $0242,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0042
        bcc _F5DD
        bra _F63D


        _F5F6
        ldy #$0000
        lda $7FD063
        tax

        _F5FE
        lda $7F8084,x
        sta $01A4,b,y
        lda $7F8146,x
        sta $0284,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$003E
        bcc _F5FE
        lda $7FD063
        sec
        sbc #$0184
        sta $7FD063
        lda $7FD061
        dec a
        sta $7FD061
        bne _F63D
        rep #$20
        lda #3,s
        tax
        sep #$20
        lda #$00
        sta aTitleTimelineSlots,x
        rep #$20
        bra _F64E


        _F63D
        lda $7FD05F
        inc a
        cmp #$0008
        bcc _F64A
        lda #$0000

        _F64A
        sta $7FD05F

        _F64E
        ply
        plx
        rtl

        .databank 0

        ; 9B/F651

    .endsection TitleScenes9BF59ESection


    .section Unsorted9BF651Section

      .al
      .xl

      rlStartTitleEdgeFade ; 9B/F651

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$01
        sta bTitleScreenEdgeFade
        rep #$20
        rtl

        .databank 0

        ; 9B/F65C

      rlUnknown9BF65C ; 9B/F65C

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aUnknown9BF69D)<<8
        sta lR18+1
        lda #<>aUnknown9BF69D
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #$00F8
        sta wBufferBG3HOFS
        lda #$0000
        sta wBufferBG3VOFS
        ldx #$0000

        _F678
        lda aUnknownE0273B,x
        sta $0102,b,x
        inc x
        inc x
        cpx #$001E
        bcc _F678
        lda #1,s
        tax
        jsl rlUnknown9BF6B1
        lda #(`rlUnknown9BF6B1)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF6B1
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 9B/F69D

    .endsection Unsorted9BF651Section


    .section Table9BF69DSection

      .al
      .xl

      aUnknown9BF69D ; 9B/F69D

        WRITE_RAM_BYTE bBufferBG34NBA, $05
        WRITE_RAM_BYTE bBufferBG3SC, $59
        WRITE_RAM_BYTE bBufferTM, $13
        WRITE_RAM_BYTE bBufferTS, $04
        WRITE_RAM_BYTE bBufferCGWSEL, $02
        WRITE_RAM_BYTE bBufferCGADSUB, $01
        WRITE_RAM_END

    .endsection Table9BF69DSection


    .section Unsorted9BF6B1Section

      .al
      .xl

      rlUnknown9BF6B1 ; 9B/F6B1

        .al
        .xl
        .autsiz
        .databank ?

        lda wBufferBG3HOFS
        sec
        sbc #$000C
        and #$01FF
        sta wBufferBG3HOFS
        cmp #$0100
        bne _F6D5
        sep #$20
        lda #$00
        sta bBufferTS
        sta bBufferCGADSUB
        rep #$20
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20

        _F6D5
        rtl

        .databank 0

        ; 9B/F6D6

      rlUnknown9BF6D6 ; 9B/F6D6

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aUnknown9BF715)<<8
        sta lR18+1
        lda #<>aUnknown9BF715
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #$0000
        sta wBufferBG3HOFS
        sta wBufferBG3VOFS
        lda #$0010
        sta $7FD065
        lda #$0000
        sta $7FD067
        sta $7FD069
        lda #1,s
        tax
        jsl rlUnknown9BF726
        lda #(`rlUnknown9BF726)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF726
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 9B/F715

    .endsection Unsorted9BF6B1Section


    .section Table9BF715Section

      .al
      .xl

      aUnknown9BF715 ; 9B/F715

        WRITE_RAM_BYTE bBufferBG3SC, $0C
        WRITE_RAM_BYTE bBufferTM, $13
        WRITE_RAM_BYTE bBufferTS, $04
        WRITE_RAM_BYTE bBufferCGWSEL, $02
        WRITE_RAM_BYTE bBufferCGADSUB, $92
        WRITE_RAM_END

    .endsection Table9BF715Section


    .section Unsorted9BF726Section

      .al
      .xl

      rlUnknown9BF726 ; 9B/F726

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD067
        inc a
        cmp #$0004
        bcs _F736
        sta $7FD067
        bra _F745


        _F736
        lda #$0000
        sta $7FD067
        lda wBufferBG3VOFS
        dec a
        and #$00FF
        sta wBufferBG3VOFS

        _F745
        lda $7FD069
        inc a
        cmp #$0004
        bcs _F755
        sta $7FD069
        bra _F764


        _F755
        lda #$0000
        sta $7FD069
        lda wBufferBG3HOFS
        dec a
        and #$00FF
        sta wBufferBG3HOFS

        _F764
        lda $7FD065
        dec a
        sta $7FD065
        bne _F779
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20

        _F779
        rtl

        .databank 0

        ; 9B/F77A

    .endsection Unsorted9BF726Section


    .section Unsorted9BF77ASection

      .al
      .xl

      rlUnknown9BF77A ; 9B/F77A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda $7E9B88

        _F782
        sta $7E8B88,x
        inc x
        inc x
        cpx #$0700
        bcc _F782
        jsr rsUnknown9BF9E3
        lda #1,s
        tax
        lda #(`rlUnknown9BF7A3)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF7A3
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 9B/F7A3

    .endsection Unsorted9BF77ASection


    .section TitleScenes9BF7A3Section

      .al
      .xl

      rlUnknown9BF7A3 ; 9B/F7A3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aUnknown9BF7E7)<<8
        sta lR18+1
        lda #<>aUnknown9BF7E7
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #$0000
        sta wBufferBG2HOFS
        lda #$0020
        sta wBufferBG2VOFS
        ldx #$0000

        _F7BF
        lda $7F6700,x
        sta $01A2,b,x
        lda $7F6720,x
        sta $01C2,b,x
        inc x
        inc x
        cpx #$001E
        bcc _F7BF
        lda #1,s
        tax
        lda #(`rlUnknown9BF7F0)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF7F0
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 9B/F7E7

    .endsection TitleScenes9BF7A3Section


    .section TitleData9BF7E7Section

      .al
      .xl

      aUnknown9BF7E7 ; 9B/F7E7

        WRITE_RAM_BYTE bBufferBG2SC, $00
        WRITE_RAM_MASK_BYTE bBufferBG12NBA, $0F, $20
        WRITE_RAM_END

    .endsection TitleData9BF7E7Section


    .section TitleScenes9BF7F0Section

      .al
      .xl

      rlUnknown9BF7F0 ; 9B/F7F0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F7F4
        lda $7E9CA4,x
        sta $7E8B88,x
        lda $7E9CA6,x
        sta $7E8B8A,x
        lda $7E9CA8,x
        sta $7E8BC4,x
        lda $7E9CAA,x
        sta $7E8BC6,x
        txa
        clc
        adc #$0040
        tax
        cpx #$0700
        bcc _F7F4
        jsr rsUnknown9BF9E3
        lda #1,s
        tax
        lda #(`rlUnknown9BF835)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF835
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 9B/F835

    .endsection TitleScenes9BF7F0Section


    .section TitleScenes9BF835Section

      .al
      .xl

      rlUnknown9BF835 ; 9B/F835

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _F839
        lda $7E9CA0,x
        sta $7E8B88,x
        lda $7E9CA2,x
        sta $7E8B8A,x
        lda $7E9CA4,x
        sta $7E8B8C,x
        lda $7E9CA6,x
        sta $7E8B8E,x
        lda $7E9CA8,x
        sta $7E8BC0,x
        lda $7E9CAA,x
        sta $7E8BC2,x
        lda $7E9CAC,x
        sta $7E8BC4,x
        lda $7E9CAE,x
        sta $7E8BC6,x
        txa
        clc
        adc #$0040
        tax
        cpx #$0700
        bcc _F839
        jsr rsUnknown9BF9E3
        lda #1,s
        tax
        lda #(`rlUnknown9BF89A)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF89A
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 9B/F89A

    .endsection TitleScenes9BF835Section


    .section TitleScenes9BF89ASection

      .al
      .xl

      rlUnknown9BF89A ; 9B/F89A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _F89F
        ldy #$0006

        _F8A2
        lda $7E9C9C,x
        sta $7E8B88,x
        lda $7E9CA8,x
        sta $7E8BBC,x
        inc x
        inc x
        dec y
        bne _F8A2
        txa
        clc
        adc #$0034
        tax
        cpx #$0700
        bcc _F89F
        jsr rsUnknown9BF9E3
        lda #3,s
        tax
        lda #(`rlUnknown9BF8D9)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF8D9
        sta aTitleTimelineSlots.lRoutine,x
        ply
        plx
        rtl

        .databank 0

        ; 9B/F8D9

    .endsection TitleScenes9BF89ASection


    .section TitleScenes9BF8D9Section

      .al
      .xl

      rlUnknown9BF8D9 ; 9B/F8D9

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _F8DE
        ldy #$0008

        _F8E1
        lda $7E9C98,x
        sta $7E8B88,x
        lda $7E9CA8,x
        sta $7E8BB8,x
        inc x
        inc x
        dec y
        bne _F8E1
        txa
        clc
        adc #$0030
        tax
        cpx #$0700
        bcc _F8DE
        jsr rsUnknown9BF9E3
        lda #3,s
        tax
        lda #(`rlUnknown9BF918)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF918
        sta aTitleTimelineSlots.lRoutine,x
        ply
        plx
        rtl

        .databank 0

        ; 9B/F918

    .endsection TitleScenes9BF8D9Section


    .section TitleScenes9BF918Section

      .al
      .xl

      rlUnknown9BF918 ; 9B/F918

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _F91D
        ldy #$000A

        _F920
        lda $7E9C94,x
        sta $7E8B88,x
        lda $7E9CA8,x
        sta $7E8BB4,x
        inc x
        inc x
        dec y
        bne _F920
        txa
        clc
        adc #$002C
        tax
        cpx #$0700
        bcc _F91D
        jsr rsUnknown9BF9E3
        lda #3,s
        tax
        lda #(`rlUnknown9BF957)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF957
        sta aTitleTimelineSlots.lRoutine,x
        ply
        plx
        rtl

        .databank 0

        ; 9B/F957

    .endsection TitleScenes9BF918Section


    .section TitleScenes9BF957Section

      .al
      .xl

      rlUnknown9BF957 ; 9B/F957

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _F95C
        ldy #$000C

        _F95F
        lda $7E9C90,x
        sta $7E8B88,x
        lda $7E9CA8,x
        sta $7E8BB0,x
        inc x
        inc x
        dec y
        bne _F95F
        txa
        clc
        adc #$0028
        tax
        cpx #$0700
        bcc _F95C
        jsr rsUnknown9BF9E3
        lda #3,s
        tax
        lda #(`rlUnknown9BF996)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF996
        sta aTitleTimelineSlots.lRoutine,x
        ply
        plx
        rtl

        .databank 0

        ; 9B/F996

    .endsection TitleScenes9BF957Section


    .section TitleScenes9BF996Section

      .al
      .xl

      rlUnknown9BF996 ; 9B/F996

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _F99B
        ldy #$000E

        _F99E
        lda $7E9C8C,x
        sta $7E8B88,x
        lda $7E9CA8,x
        sta $7E8BAC,x
        inc x
        inc x
        dec y
        bne _F99E
        txa
        clc
        adc #$0024
        tax
        cpx #$0700
        bcc _F99B
        jsr rsUnknown9BF9E3
        lda #3,s
        tax
        lda #(`rlUnknown9BF9D5)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BF9D5
        sta aTitleTimelineSlots.lRoutine,x
        ply
        plx
        rtl

        .databank 0

        ; 9B/F9D5

    .endsection TitleScenes9BF996Section


    .section TitleScenes9BF9D5Section

      .al
      .xl

      rlUnknown9BF9D5 ; 9B/F9D5

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9BF9FA
        sep #$20
        lda #$00
        sta aTitleTimelineSlots,x
        rep #$20
        rtl

        .databank 0

        ; 9B/F9E3

    .endsection TitleScenes9BF9D5Section


    .section Unsorted9BF9E3Section

      .al
      .xl

      rsUnknown9BF9E3 ; 9B/F9E3

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        ldy #$0080
        lda #$0700
        jsl rlBattleSceneStartLargeUpload
        ply
        rts

        .databank 0

        ; 9B/F9FA

    .endsection Unsorted9BF9E3Section


    .section TitleScenes9BF9FASection

      .al
      .xl

      rsUnknown9BF9FA ; 9B/F9FA

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda #$7E00
        sta lR18+1
        lda #$9C88
        sta lR18
        ldy #$0080
        lda #$0700
        jsl rlBattleSceneStartLargeUpload
        ply
        rts

        .databank 0

        ; 9B/FA11

    .endsection TitleScenes9BF9FASection


    .section Unsorted9BFA11Section

      .al
      .xl

      rlUnknown9BFA11 ; 9B/FA11

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7FD04A
        jsl rlUnknown9BFA2D
        lda #(`rlUnknown9BFA2D)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BFA2D
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 9B/FA2D

    .endsection Unsorted9BFA11Section


    .section Unsorted9BFA2DSection

      .al
      .xl

      rlUnknown9BFA2D ; 9B/FA2D

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FD04A
        bne _FA46
        lda wBufferBG1VOFS
        dec a
        sta wBufferBG1VOFS
        bne _FA46
        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20
        bra _FA57


        _FA46
        lda $7FD04A
        inc a
        cmp #$0004
        bcc _FA53
        lda #$0000

        _FA53
        sta $7FD04A

        _FA57
        rtl

        .databank 0

        ; 9B/FA58

    .endsection Unsorted9BFA2DSection


    .section Unsorted9BFA58Section

      .al
      .xl

      rlUnknown9BFA58 ; 9B/FA58

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aUnknown9BFA69)<<8
        sta lR18+1
        lda #<>aUnknown9BFA69
        sta lR18
        jsl rlBattleSceneWriteRAM
        plx
        rtl

        .databank 0

        ; 9B/FA69

    .endsection Unsorted9BFA58Section


    .section Table9BFA69Section

      .al
      .xl

      aUnknown9BFA69 ; 9B/FA69

        WRITE_RAM_BYTE bBufferBG2SC, $78
        WRITE_RAM_END

    .endsection Table9BFA69Section


    .section Unsorted9BFA6ESection

      .al
      .xl

      rlUnknown9BFA6E ; 9B/FA6E

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aUnknown9BFA7F)<<8
        sta lR18+1
        lda #<>aUnknown9BFA7F
        sta lR18
        jsl rlBattleSceneWriteRAM
        plx
        rtl

        .databank 0

        ; 9B/FA7F

    .endsection Unsorted9BFA6ESection


    .section Table9BFA7FSection

      .al
      .xl

      aUnknown9BFA7F ; 9B/FA7F

        WRITE_RAM_MASK_BYTE bBufferBG12NBA, $0F, $00
        WRITE_RAM_END

    .endsection Table9BFA7FSection


    .section Unsorted9BFA85Section

      .al
      .xl

      rlUnknown9BFA85 ; 9B/FA85

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aUnknown9BFA96)<<8
        sta lR18+1
        lda #<>aUnknown9BFA96
        sta lR18
        jsl rlBattleSceneWriteRAM
        plx
        rtl

        .databank 0

        ; 9B/FA96

    .endsection Unsorted9BFA85Section


    .section Table9BFA96Section

      .al
      .xl

      aUnknown9BFA96 ; 9B/FA96

        WRITE_RAM_BYTE bBufferTM, $02
        WRITE_RAM_BYTE bBufferTS, $00
        WRITE_RAM_BYTE bBufferCGADSUB, $00
        WRITE_RAM_END

    .endsection Table9BFA96Section


    .section Unsorted9BFAA1Section

      .al
      .xl

      rlUnknown9BFAA1 ; 9B/FAA1

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aUnknown9BFAB2)<<8
        sta lR18+1
        lda #<>aUnknown9BFAB2
        sta lR18
        jsl rlBattleSceneWriteRAM
        plx
        rtl

        .databank 0

        ; 9B/FAB2

    .endsection Unsorted9BFAA1Section


    .section Table9BFAB2Section

      .al
      .xl

      aUnknown9BFAB2 ; 9B/FAB2

        WRITE_RAM_BYTE bBufferBG2SC, $40
        WRITE_RAM_END

    .endsection Table9BFAB2Section


    .section Unsorted9BFAB7Section

      .al
      .xl

      rlAllowStartOnTitle ; 9B/FAB7

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bTitleScreenFlags
        ora #$02
        sta bTitleScreenFlags
        rep #$20
        rtl

        .databank 0

        ; 9B/FAC6

      rlStartDimmingTitle ; 9B/FAC6

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; The fade out's first step: dims the palettes to half and sets its registers.

        phx
        sep #$20
        lda bBufferINIDISP
        ora #$0F
        sta bBufferINIDISP
        rep #$20
        lda #(`aUnknown9BFB46)<<8
        sta lR18+1
        lda #<>aUnknown9BFB46
        sta lR18
        jsl rlBattleSceneWriteRAM
        lda #$0000
        sta wBufferBG1HOFS
        sta wBufferBG1VOFS
        sta wBufferBG2HOFS
        lda #$0020
        sta wBufferBG2VOFS
        ldx #$0000

        _FAF0
        lda $0122,b,x
        lsr a
        and #$3DEF
        sta $0122,b,x
        lda $0142,b,x
        lsr a
        and #$3DEF
        sta $0142,b,x
        lda $0162,b,x
        lsr a
        and #$3DEF
        sta $0162,b,x
        lda $0182,b,x
        lsr a
        and #$3DEF
        sta $0182,b,x
        lda $0242,b,x
        lsr a
        and #$3DEF
        sta $0242,b,x
        lda $0282,b,x
        lsr a
        and #$3DEF
        sta $0282,b,x
        inc x
        inc x
        cpx #$001E
        bcc _FAF0
        lda #1,s
        tax
        lda #(`rlUnknown9BFB5D)<<8
        sta aTitleTimelineSlots.lRoutine+1,x
        lda #<>rlUnknown9BFB5D
        sta aTitleTimelineSlots.lRoutine,x
        plx
        rtl

        .databank 0

        ; 9B/FB46

    .endsection Unsorted9BFAB7Section


    .section Table9BFB46Section

      .al
      .xl

      aUnknown9BFB46 ; 9B/FB46

        WRITE_RAM_BYTE bBufferTM, $02
        WRITE_RAM_BYTE bBufferTS, $11
        WRITE_RAM_BYTE bBufferOBSEL, $03
        WRITE_RAM_BYTE bBufferBG1SC, $7C
        WRITE_RAM_BYTE bBufferBG12NBA, $24
        WRITE_RAM_BYTE bBufferCGWSEL, $02
        WRITE_RAM_BYTE bBufferCGADSUB, $22
        WRITE_RAM_END

    .endsection Table9BFB46Section


    .section Unsorted9BFB5DSection

      .al
      .xl

      rlUnknown9BFB5D ; 9B/FB5D

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta aTitleTimelineSlots.bActive,x
        rep #$20
        rtl

        .databank 0

        ; 9B/FB68

      rlEndTitleScreenFadeOut ; 9B/FB68

        ; Found through fe4.cdl.
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

        ; 9B/FB73

    .endsection Unsorted9BFB5DSection


    .section Unsorted9BFB73Section

      .al
      .xl

      rlEnterTitlePhase ; 9B/FB73

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bTitleScreenPhase to 1 at the end of the intro's timeline, without reloading: the intro has built the title itself.

        sep #$20
        lda #$01
        sta bTitleScreenPhase
        rep #$20
        rtl

        .databank 0

        ; 9B/FB7E

    .endsection Unsorted9BFB73Section


    .section Unsorted9BFB7ESection

      .al
      .xl

      rlPlayTitleIntroSong ; 9B/FB7E

        .al
        .xl
        .autsiz
        .databank ?

        ; Song 1; clears bit 3 of bTitleScreenFlags.

        sep #$20
        lda bSoundFlags,b
        and #$EF
        sta bSoundFlags,b
        rep #$20
        lda #$0001
        sta wMusicID,b
        sep #$20
        lda bTitleScreenFlags
        and #$F7
        sta bTitleScreenFlags
        rep #$20
        rtl

        .databank 0

        ; 9B/FB9F

    .endsection Unsorted9BFB7ESection


    .section Unsorted9BFB9FSection

      .al
      .xl

      rlPlayTitleIntroSong2 ; 9B/FB9F

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Song 2, at frame $10F2 of the intro.

        lda #$0002
        sta wMusicID,b
        sta wSoundIndirectPending,b
        rtl

        .databank 0

        ; 9B/FBA9

    .endsection Unsorted9BFB9FSection


    .section Unsorted9BFBA9Section

      .al
      .xl

      rlPlayTitleSong ; 9B/FBA9

        .al
        .xl
        .autsiz
        .databank ?

        ; Song 3 (rlTitleScreenShowTitle).

        lda #$0003
        sta wMusicID,b
        rtl

        .databank 0

        ; 9B/FBB0

    .endsection Unsorted9BFBA9Section


    .section Unsorted9BFBB0Section

      .al
      .xl

      rlUnknown9BFBB0 ; 9B/FBB0

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0005
        jsl rlPlaySoundEffect2
        rtl

        .databank 0

        ; 9B/FBB8

      rlUnknown9BFBB8 ; 9B/FBB8

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0013
        jsl rlPlaySoundEffect2
        rtl

        .databank 0

        ; 9B/FBC0

    .endsection Unsorted9BFBB0Section


    .section Unsorted9BFD71Section

      .al
      .xl

      rlStartTitleLogoSprite1 ; 9B/FD71

        .al
        .xl
        .autsiz
        .databank ?

        ; Also clears sprite 0's afterimage flags.

        sep #$20
        lda aTitleSprites.Flags
        and #$FC
        sta aTitleSprites.Flags
        rep #$20
        ldx #$0062
        lda #(`aTitleSpriteDefinitions)<<8
        sta lR18+1
        lda #<>aTitleSpriteDefinitions + 1 * TITLE_SPRITE_SIZE
        bra rlStartTitleLogoSprite6._FDCB

        .databank 0

        ; 9B/FD8C

      rlStartTitleLogoSprite2 ; 9B/FD8C

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$00C4
        lda #(`aTitleSpriteDefinitions)<<8
        sta lR18+1
        lda #<>aTitleSpriteDefinitions + 2 * TITLE_SPRITE_SIZE
        bra rlStartTitleLogoSprite6._FDCB

        .databank 0

        ; 9B/FD99

      rlStartTitleLogoSprite3 ; 9B/FD99

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0126
        lda #(`aTitleSpriteDefinitions)<<8
        sta lR18+1
        lda #<>aTitleSpriteDefinitions + 3 * TITLE_SPRITE_SIZE
        bra rlStartTitleLogoSprite6._FDCB

        .databank 0

        ; 9B/FDA6

      rlStartTitleLogoSprite4 ; 9B/FDA6

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0188
        lda #(`aTitleSpriteDefinitions)<<8
        sta lR18+1
        lda #<>aTitleSpriteDefinitions + 4 * TITLE_SPRITE_SIZE
        bra rlStartTitleLogoSprite6._FDCB

        .databank 0

        ; 9B/FDB3

      rlStartTitleLogoSprite5 ; 9B/FDB3

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$01EA
        lda #(`aTitleSpriteDefinitions)<<8
        sta lR18+1
        lda #<>aTitleSpriteDefinitions + 5 * TITLE_SPRITE_SIZE
        bra rlStartTitleLogoSprite6._FDCB

        .databank 0

        ; 9B/FDC0

      rlStartTitleLogoSprite6 ; 9B/FDC0

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$024C
        lda #(`aTitleSpriteDefinitions)<<8
        sta lR18+1
        lda #<>aTitleSpriteDefinitions + 6 * TITLE_SPRITE_SIZE

        _FDCB
        sta lR18
        jsl rlStartTitleSprite
        rtl

        .databank 0

        ; 9B/FDD2

      rlStartTitleLogoSprite7 ; 9B/FDD2

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$02AE
        lda #(`aTitleSpriteDefinitions)<<8
        sta lR18+1
        lda #<>aTitleSpriteDefinitions + 7 * TITLE_SPRITE_SIZE
        bra rlStartTitleLogoSprite6._FDCB

        .databank 0

        ; 9B/FDDF

      rlStartTitleLogoSprite8 ; 9B/FDDF

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0310
        lda #(`aTitleSpriteDefinitions)<<8
        sta lR18+1
        lda #<>aTitleSpriteDefinitions + 8 * TITLE_SPRITE_SIZE
        bra rlStartTitleLogoSprite6._FDCB

        .databank 0

        ; 9B/FDEC

      rlStartTitleLogoSprite9 ; 9B/FDEC

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0372
        lda #(`aTitleSpriteDefinitions)<<8
        sta lR18+1
        lda #<>aTitleSpriteDefinitions + 9 * TITLE_SPRITE_SIZE
        bra rlStartTitleLogoSprite6._FDCB

        .databank 0

        ; 9B/FDF9

      rlStartTitleLogoSprite10 ; 9B/FDF9

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$03D4
        lda #(`aTitleSpriteDefinitions)<<8
        sta lR18+1
        lda #<>aTitleSpriteDefinitions + 10 * TITLE_SPRITE_SIZE
        bra rlStartTitleLogoSprite6._FDCB

        .databank 0

        ; 9B/FE06

      rlStartTitleLogoSprite11 ; 9B/FE06

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0436
        lda #(`aTitleSpriteDefinitions)<<8
        sta lR18+1
        lda #<>aTitleSpriteDefinitions + 11 * TITLE_SPRITE_SIZE
        bra rlStartTitleLogoSprite6._FDCB

        .databank 0

        ; 9B/FE13

    .endsection Unsorted9BFD71Section


    .section TitleData9BFE13Section

      .al
      .xl

      aUnknown9BFE13 ; 9B/FE13

        ; Unreferenced: title sprite scripts and frames like aTitleSpriteStill00 and
        ; aTitleSpriteFrames, which nothing in the build points at.

        .byte $01, $03, $02, $03, $03, $03, $04, $03, $80, $04, $01, $03, $02, $03, $03, $03
        .byte $04, $03, $05, $01, $06, $01, $07, $01, $08, $01, $09, $03, $0A, $03, $0B, $03
        .byte $0C, $03, $80, $04, $18, $00, $2E, $00, $44, $00, $5A, $00, $70, $00, $86, $00
        .byte $9C, $00, $B2, $00, $C8, $00, $06, $01, $44, $01, $82, $01, $04, $00, $00, $C2
        .byte $00, $52, $3A, $F0, $C3, $00, $50, $3A, $00, $C2, $F0, $32, $3A, $F0, $C3, $F0
        .byte $30, $3A, $04, $00, $00, $C2, $00, $56, $3A, $F0, $C3, $00, $54, $3A, $00, $C2
        .byte $F0, $36, $3A, $F0, $C3, $F0, $34, $3A, $04, $00, $00, $C2, $00, $5A, $3A, $F0
        .byte $C3, $00, $58, $3A, $00, $C2, $F0, $3A, $3A, $F0, $C3, $F0, $38, $3A, $04, $00
        .byte $00, $C2, $00, $5E, $3A, $F0, $C3, $00, $5C, $3A, $00, $C2, $F0, $3E, $3A, $F0
        .byte $C3, $F0, $3C, $3A, $04, $00, $00, $C2, $00, $CE, $3A, $F0, $C3, $00, $CC, $3A
        .byte $00, $C2, $F0, $AE, $3A, $F0, $C3, $F0, $AC, $3A, $04, $00, $00, $C2, $00, $E6
        .byte $3A, $F0, $C3, $00, $E4, $3A, $00, $C2, $F0, $E2, $3A, $F0, $C3, $F0, $E0, $3A
        .byte $04, $00, $00, $C2, $00, $CE, $3A, $F0, $C3, $00, $CC, $3A, $00, $C2, $F0, $AE
        .byte $3A, $F0, $C3, $F0, $AC, $3A, $04, $00, $00, $C2, $00, $E6, $3A, $F0, $C3, $00
        .byte $E4, $3A, $00, $C2, $F0, $E2, $3A, $F0, $C3, $F0, $E0, $3A, $0C, $00, $04, $00
        .byte $08, $D2, $3A, $FC, $01, $08, $D1, $3A, $F4, $01, $08, $D0, $3A, $04, $00, $00
        .byte $C2, $3A, $FC, $01, $00, $C1, $3A, $F4, $01, $00, $C0, $3A, $04, $00, $F8, $B2
        .byte $3A, $FC, $01, $F8, $B1, $3A, $F4, $01, $F8, $B0, $3A, $04, $00, $F0, $A2, $3A
        .byte $FC, $01, $F0, $A1, $3A, $F4, $01, $F0, $A0, $3A, $0C, $00, $04, $00, $08, $D5
        .byte $3A, $FC, $01, $08, $D4, $3A, $F4, $01, $08, $D3, $3A, $04, $00, $00, $C5, $3A
        .byte $FC, $01, $00, $C4, $3A, $F4, $01, $00, $C3, $3A, $04, $00, $F8, $B5, $3A, $FC
        .byte $01, $F8, $B4, $3A, $F4, $01, $F8, $B3, $3A, $04, $00, $F0, $A5, $3A, $FC, $01
        .byte $F0, $A4, $3A, $F4, $01, $F0, $A3, $3A, $0C, $00, $04, $00, $08, $D8, $3A, $FC
        .byte $01, $08, $D7, $3A, $F4, $01, $08, $D6, $3A, $04, $00, $00, $C8, $3A, $FC, $01
        .byte $00, $C7, $3A, $F4, $01, $00, $C6, $3A, $04, $00, $F8, $B8, $3A, $FC, $01, $F8
        .byte $B7, $3A, $F4, $01, $F8, $B6, $3A, $04, $00, $F0, $A8, $3A, $FC, $01, $F0, $A7
        .byte $3A, $F4, $01, $F0, $A6, $3A, $0C, $00, $04, $00, $08, $DB, $3A, $FC, $01, $08
        .byte $DA, $3A, $F4, $01, $08, $D9, $3A, $04, $00, $00, $CB, $3A, $FC, $01, $00, $CA
        .byte $3A, $F4, $01, $00, $C9, $3A, $04, $00, $F8, $BB, $3A, $FC, $01, $F8, $BA, $3A
        .byte $F4, $01, $F8, $B9, $3A, $04, $00, $F0, $AB, $3A, $FC, $01, $F0, $AA, $3A, $F4
        .byte $01, $F0, $A9, $3A, $00, $00, $00, $00, $00, $00, $00, $00, $00

        ; Unused: 858 zero bytes.
        .fill 858, $00

    .endsection TitleData9BFE13Section
