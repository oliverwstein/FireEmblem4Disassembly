; Code from bank $97 not yet assigned to a game system.

    .section Unsorted978000Section

      .al
      .xl

      rlBattleScenePlayHolyWeaponSound ; 97/8000

        .al
        .xl
        .autsiz
        .databank ?

        ; X = 0 or $43: plays sound $90 panned to the combatant's place on screen (combatant 1 adds $2000).

        lda wBattleAnimationX,b,x
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        jsl rlGetSoundPanFromXPixel
        cpx #$0000
        bne _8018
        clc
        adc #$2000

        _8018
        pha
        lda #$0090
        ora #1,s
        jsl rlPlaySoundEffect2
        pla
        rtl

        .databank 0

        ; 97/8024

    .endsection Unsorted978000Section


    .section Unsorted97802CSection

      .al
      .xl

      rlUnknown97802C ; 97/802C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta bBufferW12SEL
        sta bBufferW34SEL
        sta bBufferWOBJSEL
        rep #$20
        rtl

        .databank 0

        ; 97/8039

    .endsection Unsorted97802CSection


    .section Table97E8FBSection

      .al
      .xl

      aUnknown97E8FB ; 97/E8FB

        ; Read by rsBattleAnimationGetBodyIndex (class, weapon category, body record; $FF ends).

        .byte $00, $00, $00
        .byte $00, $01, $01
        .byte $00, $05, $02
        .byte $01, $01, $01
        .byte $01, $05, $02
        .byte $02, $03, $04
        .byte $03, $02, $00
        .byte $03, $06, $03
        .byte $04, $00, $00
        .byte $05, $00, $00
        .byte $05, $08, $05
        .byte $06, $00, $06
        .byte $06, $01, $07
        .byte $06, $05, $08
        .byte $07, $01, $07
        .byte $07, $05, $08
        .byte $08, $00, $06
        .byte $08, $01, $07
        .byte $08, $02, $06
        .byte $08, $03, $04
        .byte $08, $05, $08
        .byte $08, $06, $09
        .byte $08, $08, $0A
        .byte $09, $00, $06
        .byte $09, $01, $07
        .byte $09, $05, $08
        .byte $0A, $00, $06
        .byte $0A, $01, $07
        .byte $0A, $05, $08
        .byte $0A, $08, $0A
        .byte $0B, $03, $04
        .byte $0C, $00, $06
        .byte $0D, $00, $06
        .byte $0D, $08, $0A
        .byte $0E, $02, $06
        .byte $0E, $06, $09
        .byte $0F, $00, $0C
        .byte $0F, $01, $0D
        .byte $0F, $05, $0E
        .byte $10, $00, $0C
        .byte $10, $01, $0D
        .byte $10, $05, $0E
        .byte $11, $00, $0C
        .byte $11, $01, $0D
        .byte $11, $05, $0E
        .byte $11, $08, $0F
        .byte $12, $00, $10
        .byte $12, $01, $11
        .byte $12, $05, $12
        .byte $13, $00, $10
        .byte $13, $01, $11
        .byte $13, $05, $12
        .byte $14, $00, $10
        .byte $14, $01, $11
        .byte $14, $05, $12
        .byte $15, $03, $13
        .byte $16, $00, $26
        .byte $17, $00, $27
        .byte $18, $03, $13
        .byte $19, $00, $27
        .byte $1A, $00, $14
        .byte $1A, $01, $15
        .byte $1A, $02, $14
        .byte $1A, $03, $18
        .byte $1A, $05, $16
        .byte $1A, $06, $17
        .byte $1B, $00, $14
        .byte $1B, $01, $15
        .byte $1B, $02, $14
        .byte $1B, $03, $18
        .byte $1B, $05, $16
        .byte $1B, $06, $17
        .byte $1B, $08, $19
        .byte $1B, $07, $1A
        .byte $1C, $00, $14
        .byte $1C, $01, $15
        .byte $1C, $02, $14
        .byte $1C, $03, $18
        .byte $1C, $05, $16
        .byte $1C, $06, $17
        .byte $1C, $08, $19
        .byte $1C, $07, $1A
        .byte $22, $01, $15
        .byte $22, $05, $16
        .byte $23, $02, $14
        .byte $23, $06, $17
        .byte $24, $03, $20
        .byte $25, $00, $14
        .byte $26, $02, $21
        .byte $26, $06, $22
        .byte $27, $02, $21
        .byte $27, $06, $22
        .byte $28, $02, $21
        .byte $28, $06, $22
        .byte $29, $02, $21
        .byte $29, $03, $23
        .byte $29, $06, $22
        .byte $2A, $03, $23
        .byte $2B, $02, $21
        .byte $2B, $06, $22
        .byte $2C, $00, $28
        .byte $2D, $00, $28
        .byte $2D, $08, $24
        .byte $2D, $07, $25
        .byte $2E, $00, $2F
        .byte $2F, $00, $28
        .byte $2F, $08, $24
        .byte $30, $00, $28
        .byte $30, $08, $24
        .byte $30, $07, $25
        .byte $31, $08, $24
        .byte $31, $07, $25
        .byte $32, $00, $2B
        .byte $33, $08, $24
        .byte $34, $07, $25
        .byte $35, $07, $25
        .byte $36, $07, $25
        .byte $37, $07, $25
        .byte $38, $07, $25
        .byte $38, $08, $24
        .byte $39, $07, $25
        .byte $39, $08, $24
        .byte $3A, $07, $25
        .byte $3A, $08, $24
        .byte $3B, $07, $25
        .byte $3C, $07, $25
        .byte $3C, $08, $24
        .byte $3D, $07, $25
        .byte $3D, $08, $24
        .byte $3E, $07, $25
        .byte $3E, $08, $24
        .byte $3F, $00, $2B
        .byte $40, $00, $2B
        .byte $43, $03, $2C
        .byte $44, $03, $2C
        .byte $45, $03, $2C
        .byte $46, $03, $2C
        .byte $47, $07, $2D
        .byte $FF

      aUnknown97EA9A ; 97/EA9A

        ; 48 combatant body records (8 bytes each), read by bank $95 & bank $96.

        .byte $14, $28, $20, $14, $0E, $20, $75, $00
        .byte $14, $28, $2C, $14, $0E, $20, $75, $00
        .byte $14, $28, $20, $20, $10, $20, $70, $00
        .byte $14, $28, $20, $20, $10, $20, $50, $00
        .byte $14, $28, $30, $20, $10, $20, $70, $00
        .byte $14, $28, $30, $20, $10, $20, $40, $00
        .byte $14, $28, $20, $20, $10, $20, $5C, $00
        .byte $14, $28, $24, $20, $10, $20, $5C, $00
        .byte $14, $28, $28, $20, $10, $20, $70, $00
        .byte $14, $28, $20, $20, $10, $20, $50, $00
        .byte $14, $28, $20, $20, $10, $20, $40, $00
        .byte $14, $28, $20, $20, $10, $20, $50, $00
        .byte $1D, $28, $2D, $20, $2D, $20, $70, $30
        .byte $1D, $28, $38, $10, $2D, $20, $70, $30
        .byte $1D, $28, $2B, $20, $10, $20, $70, $00
        .byte $1D, $28, $30, $20, $10, $20, $40, $00
        .byte $1A, $30, $2E, $20, $1F, $20, $70, $30
        .byte $10, $20, $30, $20, $1C, $20, $70, $30
        .byte $18, $30, $39, $20, $10, $20, $70, $00
        .byte $08, $1C, $30, $20, $10, $20, $70, $00
        .byte $0C, $20, $1A, $20, $10, $20, $28, $00
        .byte $0C, $20, $24, $20, $10, $20, $28, $00
        .byte $0C, $20, $30, $20, $10, $20, $70, $00
        .byte $0C, $20, $30, $20, $10, $20, $50, $00
        .byte $0C, $20, $30, $30, $10, $20, $70, $00
        .byte $0C, $20, $30, $20, $10, $20, $40, $00
        .byte $0C, $20, $30, $20, $10, $20, $50, $00
        .byte $08, $1D, $1A, $20, $10, $20, $2D, $00
        .byte $08, $1D, $2A, $20, $10, $20, $2E, $00
        .byte $08, $1D, $30, $20, $10, $20, $70, $00
        .byte $08, $1D, $30, $20, $10, $20, $50, $00
        .byte $0E, $1D, $30, $20, $10, $20, $70, $00
        .byte $0C, $20, $30, $30, $10, $20, $70, $00
        .byte $0E, $20, $1D, $10, $12, $20, $40, $00
        .byte $0E, $20, $30, $20, $10, $20, $50, $00
        .byte $0E, $20, $30, $20, $10, $20, $70, $00
        .byte $08, $1B, $30, $20, $10, $20, $40, $00
        .byte $08, $1D, $30, $30, $20, $20, $50, $00
        .byte $08, $1C, $18, $20, $10, $20, $40, $00
        .byte $08, $20, $18, $14, $20, $20, $5B, $00
        .byte $08, $1D, $18, $14, $20, $20, $5B, $00
        .byte $08, $1B, $30, $20, $10, $20, $40, $00
        .byte $08, $1D, $30, $30, $20, $20, $50, $00
        .byte $08, $1D, $18, $16, $15, $20, $40, $00
        .byte $25, $30, $30, $20, $10, $20, $60, $00
        .byte $08, $1D, $30, $20, $10, $60, $50, $00
        .byte $06, $1C, $30, $20, $10, $20, $40, $00
        .byte $08, $1D, $18, $14, $30, $20, $5B, $00

      aUnknown97EC1A ; 97/EC1A

        ; Read by rlUnknown95B80C.

        .byte $78, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $B4, $C8, $C8, $BE, $C8, $C8, $C8, $DC
        .byte $C8, $C8, $DC, $F0, $FF, $FF, $64, $50, $5A, $5A, $5A, $D7, $EB, $FF, $8C, $8C
        .byte $8C, $8C, $8C, $C8, $C8, $C8, $C8, $78, $78, $78, $78, $78, $78, $50, $50, $50
        .byte $3C, $50, $50, $3C, $3C, $50, $50, $50, $50, $50, $64, $50, $50, $3C, $64, $64
        .byte $3C, $46, $64, $64, $FF, $FF, $FF, $FF, $50

    .endsection Table97E8FBSection


    .section Data97F19BSection

      .al
      .xl

      aTitleLoadList ; 97/F19B

        ; Read by rlRunTitleLoadList via rlStartTitleLoadList.

        .byte $00
        .long gcUnknownDF005F, aDecompressionBuffer
        .word $7800, $0400
        .byte $00
        .long gcUnknownF63A2C, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long gcUnknownF676FE, aDecompressionBuffer
        .word $4000, $4000
        .byte $00
        .long gcUnknownF524B7, aDecompressionBuffer
        .word $3800, $1000
        .byte $00
        .long gcUnknownDF03A5, aDecompressionBuffer
        .word $7800, $04E0
        .byte $00
        .long gcUnknownF63A58, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long gcUnknownDF075B, aDecompressionBuffer
        .word $7800, $0560
        .byte $00
        .long gcUnknownF63A8D, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long g4bppcBattleBackgroundUnknown16, aDecompressionBuffer
        .word $0000, $4000
        .byte $00
        .long gcUnknownF5222D, aDecompressionBuffer
        .word $3000, $1000
        .byte $00
        .long gcUnknownF47E55, aDecompressionBuffer
        .word $2000, $1000
        .byte $00
        .long gcUnknownF527E5, aDecompressionBuffer
        .word $7000, $1000
        .byte $00
        .long gcUnknownF50A88, aDecompressionBuffer
        .word $6000, $2000
        .byte $00
        .long gcUnknownDF0B25, aDecompressionBuffer
        .word $7800, $04C0
        .byte $00
        .long gcUnknownF63AC8, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long gcUnknownF03141, aDecompressionBuffer
        .word $2800, $0800
        .byte $00
        .long gcUnknownF5299B, aDecompressionBuffer
        .word $2C00, $0800
        .byte $00
        .long gcUnknownDF0E44, aDecompressionBuffer
        .word $7800, $05C0
        .byte $00
        .long gcUnknownF63AFB, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long gcUnknownDF123A, aDecompressionBuffer
        .word $7800, $0500
        .byte $00
        .long gcUnknownF63B39, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long gcUnknownF02266, aDecompressionBuffer
        .word $4000, $2000
        .byte $00
        .long gcUnknownF019F4, aDecompressionBuffer
        .word $5000, $2000
        .byte $00
        .long gcUnknownDF1542, aDecompressionBuffer
        .word $7800, $04E0
        .byte $00
        .long gcUnknownB6FFCA, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long gcUnknownF02FC1, aDecompressionBuffer
        .word $2000, $0800
        .byte $00
        .long gcUnknownF039A2, aDecompressionBuffer
        .word $2400, $0800
        .byte $00
        .long gcUnknownF41F38, aDecompressionBuffer
        .word $0000, $3800
        .byte $00
        .long gcUnknownF43803, aDecompressionBuffer
        .word $7000, $1000
        .byte $00
        .long gcUnknownF03A1C, aDecompressionBuffer
        .word $3000, $2000
        .byte $00
        .long gcUnknownF06B78, aDecompressionBuffer
        .word $1C00, $0800
        .byte $00
        .long gcUnknownDF18EA, aDecompressionBuffer
        .word $7800, $05C0
        .byte $00
        .long gcUnknownF63B70, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long gcUnknownF30E6F, aDecompressionBuffer
        .word $4000, $4000
        .byte $00
        .long gcUnknownF339EB, aDecompressionBuffer
        .word $2800, $1000
        .byte $00
        .long gcUnknownF27E72, aDecompressionBuffer
        .word $6000, $1800
        .byte $00
        .long gcUnknownF33663, aDecompressionBuffer
        .word $6C00, $0800
        .byte $00
        .long gcUnknownF3365D, aDecompressionBuffer
        .word $0000, $0800
        .byte $00
        .long gcUnknown94FF6D, aDecompressionBuffer
        .word $0400, $0800
        .byte $00
        .long gcUnknownDF1CA2, aDecompressionBuffer
        .word $7800, $03C0
        .byte $00
        .long gcUnknown94FFD1, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long gcUnknown94E9EE, aDecompressionBuffer
        .word $1000, $2000
        .byte $00
        .long gcUnknownF5597A, aDecompressionBuffer
        .word $0800, $0800
        .byte $00
        .long gcUnknownDF1F36, aDecompressionBuffer
        .word $7800, $05C0
        .byte $00
        .long gcUnknownF63BAE, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long gcUnknownF52B03, aDecompressionBuffer
        .word $3000, $2000
        .byte $00
        .long gcUnknownF5580C, aDecompressionBuffer
        .word $0C00, $0800
        .byte $00
        .long gcUnknownF547D4, aDecompressionBuffer
        .word $2000, $1800
        .byte $00
        .long gcUnknownDF232B, aDecompressionBuffer
        .word $7800, $0340
        .byte $00
        .long gcUnknownF63BEC, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long gcUnknownF55B0E, aDecompressionBuffer
        .word $4000, $2200
        .byte $00
        .long gcUnknownF57E44, aDecompressionBuffer
        .word $6000, $2C80
        .byte $00
        .long gcUnknownF57B55, aDecompressionBuffer
        .word $5800, $1000
        .byte $00
        .long gcUnknownDF2480, aDecompressionBuffer
        .word $7800, $04E0
        .byte $00
        .long gcUnknownDF0000, aDecompressionBuffer
        .word $7F20, $0080
        .byte $00
        .long gcUnknownDF2850, aDecompressionBuffer
        .word $7800, $0400
        .byte $00
        .long gcUnknownDF0033, aDecompressionBuffer
        .word $7F20, $0080
        .byte $02
        .long $7F7800
        .word $7C00, $0800
        .byte $00
        .long gcUnknownF57C2D, aDecompressionBuffer
        .word $0C00, $0800
        .byte $00
        .long gcUnknownF57765, aDecompressionBuffer
        .word $5100, $0B00
        .byte $00
        .long gcUnknown9C8000, aDecompressionBuffer
        .word $2000, $4000
        .byte $00
        .long gcUnknown9CBBB7, $7E9B88
        .word $0000, $0010
        .byte $02
        .long $7F6580
        .word $7EC0, $00C0
        .byte $02
        .long $7F66A0
        .word $7F50, $001A
        .byte $02
        .long $7F63FA
        .word $7DFD, $0004

        ; 97/F45A

      aTitleFadeOutLoadList ; 97/F45A

        ; Read by rlRunTitleLoadList via rlStartTitleFadeOutLoadList.

        .byte $00
        .long gcUnknown9CBBB7, $7F0000
        .word $7800, $0800
        .byte $00
        .long gcUnknown9C8000, $7F1000
        .word $0000, $4000
        .byte $00
        .long gcUnknown9CBB20, aDecompressionBuffer
        .word $3C00, $0800
        .byte $02
        .long $7F5000
        .word $2000, $0800
        .byte $02
        .long $7F0000
        .word $4000, $1000

        ; 97/F48B

    .endsection Data97F19BSection


    .section Data97F48BSection

      .al
      .xl

      aTitleSceneFadeInBrightness ; 97/F48B

        .byte $00, $00, $00, $00, $00, $00, $00, $00, $01, $00, $01, $00, $01, $00, $01, $00
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $02, $01, $02, $01, $02, $01, $02, $01
        .byte $02, $02, $02, $02, $02, $02, $02, $02, $03, $02, $03, $02, $03, $02, $03, $02
        .byte $03, $03, $03, $03, $03, $03, $03, $03, $04, $03, $04, $03, $04, $03, $04, $03
        .byte $04, $04, $04, $04, $04, $04, $04, $04, $05, $04, $05, $04, $05, $04, $05, $04
        .byte $05, $05, $05, $05, $05, $05, $05, $05, $06, $05, $06, $05, $06, $05, $06, $05
        .byte $06, $06, $06, $06, $06, $06, $06, $06, $07, $06, $07, $06, $07, $06, $07, $06
        .byte $07, $07, $07, $07, $07, $07, $07, $07, $08, $07, $08, $07, $08, $07, $08, $07
        .byte $08, $08, $08, $08, $08, $08, $08, $08, $09, $08, $09, $08, $09, $08, $09, $08
        .byte $09, $09, $09, $09, $09, $09, $09, $09, $0A, $09, $0A, $09, $0A, $09, $0A, $09
        .byte $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0B, $0A, $0B, $0A, $0B, $0A, $0B, $0A
        .byte $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0C, $0B, $0C, $0B, $0C, $0B, $0C, $0B
        .byte $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0D, $0C, $0D, $0C, $0D, $0C, $0D, $0C
        .byte $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0E, $0D, $0E, $0D, $0E, $0D, $0D, $0D
        .byte $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0F, $0E, $0F, $0E, $0F, $0E, $0F, $0E
        .byte $0F, $FF

      aTitleFadeInBrightness ; 97/F57D

        .byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $00, $00
        .byte $00, $00, $01, $01, $01, $01, $02, $02, $02, $02, $03, $03, $03, $03, $04, $04
        .byte $04, $04, $05, $05, $05, $05, $06, $06, $06, $06, $07, $07, $07, $07, $08, $08
        .byte $08, $08, $09, $09, $09, $09, $0A, $0A, $0A, $0A, $0B, $0B, $0B, $0B, $0C, $0C
        .byte $0C, $0C, $0D, $0D, $0D, $0D, $0E, $0E, $0E, $0E, $0F, $FF

      aTitleSceneFadeOutBrightness ; 97/F5C7

        .byte $0E, $0F, $0E, $0F
        .byte $0E, $0E, $0E, $0E, $0D, $0E, $0D, $0E, $0D, $0D, $0D, $0D, $0C, $0D, $0C, $0D
        .byte $0C, $0C, $0C, $0C, $0B, $0C, $0B, $0C, $0B, $0B, $0B, $0B, $0A, $0B, $0A, $0B
        .byte $0A, $0A, $0A, $0A, $09, $0A, $09, $0A, $09, $09, $09, $09, $08, $09, $08, $09
        .byte $08, $08, $08, $08, $07, $08, $07, $08, $07, $07, $07, $07, $06, $07, $06, $07
        .byte $06, $06, $06, $06, $05, $06, $05, $06, $05, $05, $05, $05, $04, $05, $04, $05
        .byte $04, $04, $04, $04, $03, $04, $03, $04, $03, $03, $03, $03, $02, $03, $02, $03
        .byte $02, $02, $02, $02, $01, $02, $01, $02, $01, $01, $01, $01, $00, $01, $00, $01
        .byte $80, $FF

      aTitleQuickFadeOutBrightness ; 97/F63D

        .byte $0E, $0D, $0C, $0B, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $01
        .byte $00, $80, $FF

      aUnknown97F64E ; 97/F64E

        ; Read by rlUnknown95F7B7.

        .byte $17, $00, $03, $00, $00, $00, $00, $04, $01, $01, $00, $FD

      aUnknown97F65A ; 97/F65A

        .byte $16, $00, $03, $00
        .byte $00, $00, $00, $04, $01, $01, $00, $FD

      aUnknown97F666 ; 97/F666

        .byte $03, $00, $03, $00, $00, $00, $00, $04
        .byte $02, $38, $00, $01, $80, $00, $00, $81, $80, $00, $00, $00, $80, $00, $00, $00
        .byte $FD

      aUnknown97F67F ; 97/F67F

        .byte $83, $02, $37, $02, $02, $7F, $00, $00, $82, $80, $00, $00, $00, $80, $80
        .byte $FF, $02, $36, $03, $03, $7F, $00, $00, $83, $7F, $00, $01, $82, $81, $00, $FE
        .byte $02, $34, $06, $06, $7F, $AB, $FF, $85, $7F, $C0, $00, $83, $82, $80, $FD, $02
        .byte $33, $07, $08, $80, $6E, $FF, $87, $80, $6D, $00, $01, $7C, $00, $00, $02, $32
        .byte $09, $08, $81, $25, $FF, $89, $81, $38, $00, $03, $7B, $00, $04, $02, $32, $0B
        .byte $07, $82, $AB, $FE, $8B, $82, $00, $00, $06, $7A, $99, $01, $02, $32, $0D, $04
        .byte $84, $56, $FC, $8D, $84, $C5, $FF, $0B, $79, $CC, $00, $02, $33, $0D, $0D, $79
        .byte $76, $00, $8D, $86, $8A, $FF, $00, $86, $77, $FF, $02, $30, $11, $11, $79, $3C
        .byte $00, $86, $79, $00, $03, $8D, $88, $16, $FF, $02, $2E, $13, $13, $7B, $00, $00
        .byte $8B, $7B, $66, $01, $8A, $89, $72, $FE, $02, $2C, $14, $14, $7D, $C0, $FF, $90
        .byte $7D, $DD, $00, $86, $8A, $67, $FC, $02, $2A, $14, $15, $80, $80, $FF, $94, $80
        .byte $73, $00, $01, $76, $00, $00, $02, $2A, $18, $12, $83, $1F, $FF, $98, $83, $35
        .byte $00, $08, $74, $DB, $02, $02, $2A, $1B, $0F, $86, $93, $FE, $9B, $86, $00, $00
        .byte $0E, $72, $89, $01, $02, $2C, $1C, $08, $8A, $93, $FC, $9C, $8A, $C0, $FF, $16
        .byte $72, $CF, $00, $02, $2F, $1A, $1A, $72, $80, $00, $9A, $8D, $80, $FF, $00, $8D
        .byte $77, $FF, $02, $2A, $20, $20, $74, $38, $00, $8A, $74, $00, $03, $98, $8F, $22
        .byte $FF, $02, $26, $23, $23, $77, $00, $00, $93, $77, $71, $01, $92, $91, $79, $FE
        .byte $02, $23, $23, $23, $7B, $C6, $FF, $9B, $7B, $D8, $00, $8A, $91, $AB, $FC, $02
        .byte $21, $22, $23, $80, $80, $FF, $A2, $80, $78, $00, $01, $6F, $00, $00, $02, $21
        .byte $27, $1E, $85, $24, $FF, $A7, $85, $3B, $00, $0B, $6C, $66, $03, $02, $22, $2B
        .byte $17, $8A, $98, $FE, $AB, $8A, $00, $00, $16, $6B, $79, $01, $02, $25, $2B, $0D
        .byte $8F, $EB, $FC, $AB, $8F, $C5, $FF, $20, $6A, $DE, $00, $02, $2A, $28, $28, $6C
        .byte $79, $00, $A8, $93, $87, $FF, $00, $93, $80, $FF, $02, $24, $2E, $2E, $6F, $37
        .byte $00, $8D, $6F, $40, $03, $A3, $96, $26, $FF, $02, $1F, $31, $31, $73, $00, $00
        .byte $9A, $73, $7A, $01, $99, $98, $76, $FE, $02, $1B, $32, $32, $79, $C3, $FF, $A5
        .byte $79, $DC, $00, $8F, $98, $EE, $FC, $02, $18, $2F, $30, $80, $7E, $FF, $AF, $80
        .byte $7D, $00, $01, $68, $00, $00, $02, $18, $36, $29, $87, $27, $FF, $B6, $87, $38
        .byte $00, $0F, $65, $49, $03, $02, $1B, $39, $1E, $8E, $85, $FE, $B9, $8E, $00, $00
        .byte $1D, $63, $89, $01, $02, $1F, $3A, $11, $94, $F0, $FC, $BA, $94, $C7, $FF, $2B
        .byte $63, $DB, $00, $02, $26, $35, $35, $65, $7D, $00, $B5, $9A, $83, $FF, $00, $9A
        .byte $7E, $FF, $02, $1E, $3D, $3D, $69, $3A, $00, $91, $69, $50, $03, $AE, $9E, $23
        .byte $FF, $02, $17, $41, $41, $6F, $00, $00, $A2, $6F, $7C, $01, $A1, $A0, $78, $FE
        .byte $02, $12, $41, $41, $77, $C5, $FF, $B1, $77, $DA, $00, $92, $A0, $B5, $FC, $02
        .byte $10, $3B, $3C, $80, $7E, $FF, $BB, $80, $7D, $00, $01, $62, $00, $00, $02, $10
        .byte $45, $33, $89, $24, $FF, $C5, $89, $37, $00, $14, $5E, $0D, $03, $02, $13, $49
        .byte $26, $92, $84, $FE, $C9, $92, $00, $00, $25, $5B, $87, $01, $02, $19, $48, $14
        .byte $9A, $BD, $FC, $C8, $9A, $C4, $FF, $36, $5C, $D9, $00, $00, $FD

      aUnknown97F8CB ; 97/F8CB

        .byte $83, $02, $21
        .byte $43, $43, $5F, $7A, $00, $C3, $A0, $86, $FF, $00, $A0, $82, $FF, $02, $17, $4C
        .byte $4C, $64, $39, $00, $96, $64, $18, $03, $B8, $A5, $21, $FF, $02, $0F, $51, $51
        .byte $6C, $00, $00, $AA, $6C, $70, $01, $A9, $A7, $87, $FE, $02, $09, $50, $50, $75
        .byte $C7, $FF, $BC, $75, $D8, $00, $96, $A7, $C4, $FC, $02, $07, $49, $4A, $80, $7F
        .byte $FF, $C9, $80, $7E, $00, $01, $5B, $00, $00, $02, $07, $54, $3E, $8B, $22, $FF
        .byte $D4, $8B, $39, $00, $18, $56, $21, $03, $00, $FF

        ; Palette / battle sprite effect entries ($97/F928-$97/F9C4)
      aUnknown97F928 ; 97/F928

        .long aUnknown99F6C1
        .byte $15, $F7, $6E, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97F935 ; 97/F935

        .long aUnknown99F6C1
        .byte $15, $F7, $92, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97F942 ; 97/F942

        .long aUnknown99F6C1
        .byte $15, $F7, $4D, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97F94F ; 97/F94F

        .long aUnknown99F6C1
        .byte $15, $F7, $B3, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97F95C ; 97/F95C

        .long aUnknown99F6D5
        .byte $15, $F7, $3A, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97F969 ; 97/F969

        .long aUnknown99F6D5
        .byte $15, $F7, $C6, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97F976 ; 97/F976

        .long aUnknown99F6CB
        .byte $15, $F7, $3B, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97F983 ; 97/F983

        .long aUnknown99F6CB
        .byte $15, $F7, $C5, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97F990 ; 97/F990

        .long aUnknown99F6CB
        .byte $15, $F7, $4F, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97F99D ; 97/F99D

        .long aUnknown99F6CB
        .byte $15, $F7, $B1, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97F9AA ; 97/F9AA

        .long aUnknown99F6CB
        .byte $15, $F7, $71, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97F9B7 ; 97/F9B7

        .long aUnknown99F6CB
        .byte $15, $F7, $8F, $00, $F0, $00, $00, $00, $00, $00

      aUnknown97F9C4 ; 97/F9C4

        .byte $13, $FE, $9B, $37, $FE, $80, $00, $F0, $00, $00, $00, $00, $00

      aUnknown97F9D1 ; 97/F9D1

        .byte $00, $00, $62
        .byte $00, $C4, $00, $26, $01, $88, $01, $EA, $01, $AE, $02, $10, $03, $72, $03, $D4
        .byte $03, $36, $04, $98, $04, $4C, $02, $72, $01, $3F, $01, $23, $01, $4C, $01, $58
        .byte $01, $70, $01, $36, $01, $14, $01, $6C, $01, $31, $01, $04, $01, $63, $01, $56
        .byte $04

      aUnknown97FA05 ; 97/FA05

        .byte $18, $00, $18, $00, $11, $00, $11, $00, $06, $00, $06, $00, $FA, $FF, $FA
        .byte $FF, $EF, $FF, $EF, $FF, $E8, $FF, $E8, $FF, $80, $FF
      aUnknown97FA1F ; 97/FA1F

        .long aUnknown99F6DF
        .long aUnknown99F6DF
        .long aUnknown99F6DF
        .long aUnknown99F6DF
        .long aUnknown99F703
        .long aUnknown99F703
        .long aUnknown99F6F1
        .long aUnknown99F6F1
        .long aUnknown99F6F1
        .long aUnknown99F6F1
        .long aUnknown99F6F1
        .long aUnknown99F6F1
        .byte $1D, $FE, $9B
        .long aUnknown97FA6A
        .long aUnknown97FA77
        .long aUnknown97FA84
        .long aUnknown97FA91
        .long aUnknown97FA9E
        .long aUnknown97FAAB
        .long aUnknown97FAB8
        .long aUnknown97FAC5
        .long aUnknown97FAD2
        .long aUnknown97FADF
        .long aUnknown97FAEC
        .long aUnknown97FAF9
      aUnknown97FA6A ; 97/FA6A
        .long aUnknown99F945
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97FA77 ; 97/FA77
        .long aUnknown99F955
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97FA84 ; 97/FA84
        .long aUnknown99F951
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97FA91 ; 97/FA91
        .long aUnknown99F949
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97FA9E ; 97/FA9E
        .long aUnknown99F961
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97FAAB ; 97/FAAB
        .long aUnknown99F969
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97FAB8 ; 97/FAB8
        .long aUnknown99F941
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97FAC5 ; 97/FAC5
        .long aUnknown99F93D
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97FAD2 ; 97/FAD2
        .long aUnknown99F94D
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97FADF ; 97/FADF
        .long aUnknown99F959
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97FAEC ; 97/FAEC
        .long aUnknown99F95D
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
      aUnknown97FAF9 ; 97/FAF9
        .long aUnknown99F965
        .byte $6D, $F9, $00, $00, $F0, $00, $00, $00, $00, $00
        .byte $0B, $20, $35, $4B, $60, $75, $8B, $A0, $B5, $CB, $E0, $F5

      aUnknown97FB12 ; 97/FB12

        ; Read by rlUnknown9BE5E4.

        .word $0000, $0000, $0001, $0001, $0001, $0002, $0002, $0002
        .word $0002, $0002, $0002, $0001, $0001, $0001, $0000, $0000
        .word $0000, $0000, -$0001, -$0001, -$0001, -$0002, -$0002, -$0002
        .word -$0002, -$0002, -$0002, -$0001, -$0001, -$0001, $0000, $0000
      aUnknown97FB52 ; 97/FB52

        .word $0000, $0001, $0002, $0003, $0004, $0004, $0005, $0005
        .word $0005, $0005, $0004, $0004, $0003, $0002, $0001, $0000
        .word $0000, -$0001, -$0002, -$0003, -$0004, -$0004, -$0005, -$0005
        .word -$0005, -$0005, -$0004, -$0004, -$0003, -$0002, -$0001, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0001, $0001, $0002, $0002, $0002, $0002
        .word $0001, $0001, $0000, $0000, $0000, $0000, -$0001, -$0001
        .word -$0002, -$0002, -$0002, -$0002, -$0001, -$0001, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0001, $0001
        .word $0002, $0002, $0002, $0002, $0001, $0001, $0000, $0000
        .word $0000, $0000, -$0001, -$0001, -$0002, -$0002, -$0002, -$0002
        .word -$0001, -$0001, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0001
        .word $0001, $0002, $0002, $0002, $0002, $0001, $0001, $0000
        .word $0000, $0000, $0000, -$0001, -$0001, -$0002, -$0002, -$0002
        .word -$0002, -$0001, -$0001, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0001, $0001, $0002
        .word $0002, $0003, $0003, $0003, $0003, $0002, $0002, $0001
        .word $0001, $0000, $0000, $0000, $0000, -$0001, -$0001, -$0002
        .word -$0002, -$0003, -$0003, -$0003, -$0003, -$0002, -$0002, -$0001
        .word -$0001, $0000, $0000, $0000, $0000, $0001, $0001, $0002
        .word $0002, $0003, $0003, $0003, $0003, $0002, $0002, $0001
        .word $0001, $0000, $0000, $0000, $0000, -$0001, -$0001, -$0002
        .word -$0002, -$0003, -$0003, -$0003, -$0003, -$0002, -$0002, -$0001
        .word -$0001, $0000, $0000, $0000, $0000, $0001, $0001, $0002
        .word $0002, $0003, $0003, $0003, $0003, $0002, $0002, $0001
        .word $0001, $0000, $0000, $0000, $0000, -$0001, -$0001, -$0002
        .word -$0002, -$0003, -$0003, -$0003, -$0003, -$0002, -$0002, -$0001
        .word -$0001, $0000
        .byte $00, $00, $FE, $FE, $FD, $FB, $EF, $BD, $EE, $ED, $AA, $48, $88, $42, $08, $20
        .byte $40, $80, $80, $80, $40, $20, $10, $08, $04, $02, $01

        ; 97/FDC1

    .endsection Data97F48BSection


