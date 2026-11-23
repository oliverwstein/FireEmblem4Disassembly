; The title screen's data in bank $99: the logo sprites' still scripts, frames,
; definitions and motion, its palette effect entries (PALETTE_EFFECT_*,
; include/BattleScene.h) and the caption scrolls.

    .section TitleData99Section

      .al
      .xl

      aTitleSpriteStill00 ; 99/FA8D

        .byte $01, $10, $80, $01

      aTitleSpriteStill01 ; 99/FA91

        .byte $02, $01, $80, $01

      aTitleSpriteStill02 ; 99/FA95

        .byte $03, $02
        .byte $80, $01

      aTitleSpriteStill03 ; 99/FA99

        .byte $04, $02, $80, $01

      aTitleSpriteStill04 ; 99/FA9D

        .byte $05, $02, $80, $01

      aTitleSpriteStill05 ; 99/FAA1

        .byte $06, $02, $80, $01

      aTitleSpriteStill06 ; 99/FAA5

        .byte $07, $01
        .byte $80, $01

      aTitleSpriteStill07 ; 99/FAA9

        .byte $08, $02, $80, $01

      aTitleSpriteStill08 ; 99/FAAD

        .byte $09, $01, $80, $01

      aTitleSpriteStill09 ; 99/FAB1

        .byte $0A, $01, $80, $01

      aTitleSpriteStill10 ; 99/FAB5

        .byte $0B, $01
        .byte $80, $01

      aTitleSpriteStill11 ; 99/FAB9

        .byte $0C, $01, $80, $01

      aTitleSpriteStill12 ; 99/FABD

        .byte $0D, $01, $80, $01

        ; 99/FAC1

      aTitleSpriteFrames ; 99/FAC1

        .word _FAC1_FADB - aTitleSpriteFrames
        .word _FAC1_FBA0 - aTitleSpriteFrames
        .word _FAC1_FBF2 - aTitleSpriteFrames
        .word _FAC1_FC1C - aTitleSpriteFrames
        .word _FAC1_FC46 - aTitleSpriteFrames
        .word _FAC1_FC70 - aTitleSpriteFrames
        .word _FAC1_FC9F - aTitleSpriteFrames
        .word _FAC1_FCD3 - aTitleSpriteFrames
        .word _FAC1_FCF8 - aTitleSpriteFrames
        .word _FAC1_FD22 - aTitleSpriteFrames
        .word _FAC1_FD51 - aTitleSpriteFrames
        .word _FAC1_FD7B - aTitleSpriteFrames
        .word _FAC1_FD9B - aTitleSpriteFrames

      _FAC1_FADB ; 99/FADB
        .byte $27, $00, $60, $C2, $07, $42, $24, $58, $00, $0F, $45, $24, $50, $00, $0F, $44
        .byte $24, $50, $C2, $FF, $40, $24, $48, $00, $F7, $33, $24, $40, $00, $F7, $32, $24
        .byte $40, $C2, $FF, $2D, $24, $30, $00, $EF, $0F, $24, $30, $C2, $F7, $20, $24, $E0
        .byte $01, $DF, $55, $24, $D8, $01, $DF, $54, $24, $2C, $00, $FF, $2A, $24, $1D, $00
        .byte $F9, $2A, $24, $0E, $00, $F3, $2A, $24, $FF, $01, $ED, $2A, $24, $24, $C2, $EF
        .byte $2B, $24, $15, $C2, $E9, $2B, $24, $06, $C2, $E3, $2B, $24, $F7, $C3, $DD, $2B
        .byte $24, $E8, $C3, $D7, $2B, $24, $F0, $01, $E7, $2A, $24, $C5, $C3, $E7, $0D, $24
        .byte $B5, $C3, $E7, $0B, $24, $B5, $C3, $D7, $09, $24, $D0, $01, $BF, $03, $24, $C8
        .byte $C3, $AF, $07, $24, $B8, $C3, $AF, $05, $24, $A0, $01, $B7, $14, $24, $90, $01
        .byte $AF, $02, $24, $90, $C3, $B7, $12, $24, $88, $01, $BF, $04, $24, $80, $C3, $AF
        .byte $00, $24, $E0, $C3, $CF, $4C, $24, $D0, $C3, $CF, $4A, $24, $C0, $C3, $CF, $48
        .byte $24, $B0, $C3, $CF, $46, $24, $C0, $C3, $BF, $28, $24, $B0, $C3, $BF, $26, $24
        .byte $A0, $C3, $BF, $24, $24

      _FAC1_FBA0 ; 99/FBA0
        .byte $10, $00, $C5, $C3, $E7, $0D, $24, $B5, $C3, $E7, $0B, $24, $B5, $C3, $D7, $09
        .byte $24, $D0, $01, $BF, $03, $24, $C8, $C3, $AF, $07, $24, $B8, $C3, $AF, $05, $24
        .byte $A0, $01, $B7, $14, $24, $90, $01, $AF, $02, $24, $90, $C3, $B7, $12, $24, $88
        .byte $01, $BF, $04, $24, $80, $C3, $AF, $00, $24, $C0, $C3, $CF, $48, $24, $B0, $C3
        .byte $CF, $46, $24, $C0, $C3, $BF, $28, $24, $B0, $C3, $BF, $26, $24, $A0, $C3, $BF
        .byte $24, $24

      _FAC1_FBF2 ; 99/FBF2
        .byte $08, $00, $8C, $01, $20, $21, $29, $84, $01, $20, $20, $29, $85, $C3, $10, $00
        .byte $29, $8D, $C3, $00, $E0, $28, $96, $C3, $F0, $C0, $28, $96, $C3, $E0, $A0, $28
        .byte $9E, $C3, $D0, $80, $28, $A6, $01, $B8, $1F, $28

      _FAC1_FC1C ; 99/FC1C
        .byte $08, $00, $9C, $01, $20, $23, $29, $94, $01, $20, $22, $29, $95, $C3, $10, $02
        .byte $29, $9D, $C3, $00, $E2, $28, $A6, $C3, $F0, $C2, $28, $A6, $C3, $E0, $A2, $28
        .byte $AE, $C3, $D0, $82, $28, $B0, $C3, $C0, $62, $28

      _FAC1_FC46 ; 99/FC46
        .byte $08, $00, $AC, $01, $20, $25, $29, $A4, $01, $20, $24, $29, $A5, $C3, $10, $04
        .byte $29, $AD, $C3, $00, $E4, $28, $B6, $C3, $F0, $C4, $28, $B6, $C3, $E0, $A4, $28
        .byte $BE, $C3, $D0, $84, $28, $C0, $C3, $C0, $64, $28

      _FAC1_FC70 ; 99/FC70
        .byte $09, $00, $C5, $01, $10, $08, $29, $B5, $C3, $10, $06, $29, $BD, $C3, $00, $E6
        .byte $28, $C6, $C3, $F0, $C6, $28, $C6, $C3, $E0, $A6, $28, $CE, $C3, $D0, $86, $28
        .byte $DC, $01, $B8, $3F, $28, $D4, $01, $B8, $2F, $28, $D0, $C3, $C0, $66, $28

      _FAC1_FC9F ; 99/FC9F
        .byte $0A, $00, $D5, $01, $10, $0A, $29, $CD, $01, $10, $09, $29, $C5, $01, $10, $08
        .byte $29, $CD, $C3, $00, $E8, $28, $D6, $C3, $F0, $C8, $28, $D6, $C3, $E0, $A8, $28
        .byte $DE, $C3, $D0, $88, $28, $E4, $01, $B8, $4F, $28, $DC, $01, $B8, $3F, $28, $E0
        .byte $C3, $C0, $68, $28

      _FAC1_FCD3 ; 99/FCD3
        .byte $07, $00, $DD, $C3, $00, $EA, $28, $D5, $01, $10, $0A, $29, $E6, $C3, $F0, $CA
        .byte $28, $E6, $C3, $E0, $AA, $28, $EE, $C3, $D0, $8A, $28, $F0, $01, $C8, $7A, $28
        .byte $F0, $01, $C0, $6A, $28

      _FAC1_FCF8 ; 99/FCF8
        .byte $08, $00, $FE, $C3, $D0, $8C, $28, $F6, $C3, $E0, $AC, $28, $F6, $C3, $F0, $CC
        .byte $28, $EE, $01, $20, $2D, $29, $E6, $01, $20, $2C, $29, $E6, $C3, $10, $0C, $29
        .byte $D5, $01, $10, $0A, $29, $ED, $C3, $00, $EC, $28

      _FAC1_FD22 ; 99/FD22
        .byte $09, $00, $06, $C2, $F0, $CE, $28, $06, $C2, $E0, $AE, $28, $17, $00, $C8, $6B
        .byte $28, $0E, $C2, $D0, $8E, $28, $FD, $C3, $00, $EE, $28, $FE, $01, $20, $2F, $29
        .byte $F6, $01, $20, $2E, $29, $F6, $C3, $10, $0E, $29, $D5, $01, $10, $0A, $29

      _FAC1_FD51 ; 99/FD51
        .byte $08, $00, $06, $C2, $10, $3E, $29, $0D, $C2, $00, $50, $29, $16, $C2, $F0, $37
        .byte $29, $16, $C2, $E0, $18, $29, $27, $00, $C8, $6D, $28, $1F, $00, $C8, $6C, $28
        .byte $17, $00, $C8, $6B, $28, $1E, $C2, $D0, $30, $29

      _FAC1_FD7B ; 99/FD7B
        .byte $06, $00, $1D, $C2, $00, $52, $29, $26, $C2, $F0, $39, $29, $26, $C2, $E0, $1A
        .byte $29, $37, $00, $C8, $6F, $28, $2F, $00, $C8, $6E, $28, $2E, $C2, $D0, $32, $29

      _FAC1_FD9B ; 99/FD9B
        .byte $05, $00, $4E, $00, $C8, $7D, $28, $46, $00, $C8, $7C, $28, $36, $C2, $F0, $3B
        .byte $29, $3F, $00, $C8, $7B, $28, $3E, $C2, $D0, $34, $29

      aUnknown99FDB6 ; 99/FDB6

        PALETTE_EFFECT_VALUE $00, $05, $10, $61, $04
      aUnknown99FDBB ; 99/FDBB

        PALETTE_EFFECT_VALUE $01, $05, $80, $61, $04

      aUnknown99FDC0 ; 99/FDC0

        PALETTE_EFFECT_VALUE $02, $05, $F0, $01, $04

      aUnknown99FDC5 ; 99/FDC5

        PALETTE_EFFECT_VALUE_DATA $00, $07, $31, $0F, $02, aUnknownE026C3

      aUnknown99FDCD ; 99/FDCD

        PALETTE_EFFECT_VALUE_DATA $00, $07, $31, $0F, $01, aUnknownE026C3

      aUnknown99FDD5 ; 99/FDD5

        PALETTE_EFFECT_VALUE_DATA $02, $07, $21, $0F, $03, aUnknownE026FF

      aUnknown99FDDD ; 99/FDDD
        PALETTE_EFFECT_VALUE_DATA $03, $07, $71, $0F, $10, $7FF636

      aUnknown99FDE5 ; 99/FDE5
        PALETTE_EFFECT_VALUE $00, $05, $15, $0B, $1E

      aUnknown99FDEA ; 99/FDEA
        PALETTE_EFFECT $00, $01, $F3, $03, aUnknown99FDF8

      aUnknown99FDF1 ; 99/FDF1
        PALETTE_EFFECT $01, $01, $E3, $03, aUnknown99FE05

      aUnknown99FDF8 ; 99/FDF8

        .byte $84, $7F, $FF, $86, $7F, $BA, $80, $7F, $FF
        .byte $84, $7F, $BA, $FE

      aUnknown99FE05 ; 99/FE05

        .byte $85, $7F, $15, $83, $7F, $FF, $85, $7F, $BA, $82, $7F, $15
        .byte $89, $7F, $FF, $83, $7F, $BA, $FE

      aUnknown99FE18 ; 99/FE18
        PALETTE_EFFECT_VALUE_DATA $03, $07, $0D, $01, $00, aUnknownE02753

      aUnknown99FE20 ; 99/FE20
        PALETTE_EFFECT_VALUE $00, $05, $11, $38, $00

      aUnknown99FE25 ; 99/FE25
        PALETTE_EFFECT_VALUE $01, $05, $A1, $0F, $01

      aUnknown99FE2A ; 99/FE2A
        PALETTE_EFFECT_VALUE $02, $05, $C1, $0F, $01
        ; The rest is not read as part of the entry; nothing in the build reads it.
        .byte $80, $80, $80, $80, $80, $80, $80, $01, $02, $03, $05, $07, $09, $0B, $0D, $0F
        .byte $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
        .byte $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
        .byte $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
        .byte $0F, $0D, $0B, $09, $07, $05, $03, $02, $01, $80, $80, $80, $80, $80, $80, $80
        .byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
        .byte $80, $80, $80

      aTitleSprite0Definition2 ; 99/FE92

        TITLE_SPRITE aTitleSpriteStill00, aTitleSpriteFrames, $0198, $003E, $0000, $0000

      aTitleSprite1Definition2 ; 99/FE9F

        TITLE_SPRITE aTitleSpriteStill01, aTitleSpriteFrames, $0198, $003E, $0000, $0000

      aTitleSpriteDefinitions ; 99/FEAC

        TITLE_SPRITE aTitleSpriteStill00, aTitleSpriteFrames, $0088, $009E, $0000, $0000
        TITLE_SPRITE aTitleSpriteStill02, aTitleSpriteFrames, $009C, $009D, $0000, $0800
        TITLE_SPRITE aTitleSpriteStill03, aTitleSpriteFrames, $009C, $009D, $0000, $0800
        TITLE_SPRITE aTitleSpriteStill04, aTitleSpriteFrames, $009C, $009D, $0000, $0800
        TITLE_SPRITE aTitleSpriteStill05, aTitleSpriteFrames, $009C, $009D, $0000, $0800
        TITLE_SPRITE aTitleSpriteStill06, aTitleSpriteFrames, $009C, $009D, $0000, $0800
        TITLE_SPRITE aTitleSpriteStill07, aTitleSpriteFrames, $009C, $009D, $0000, $0800
        TITLE_SPRITE aTitleSpriteStill08, aTitleSpriteFrames, $009C, $009D, $0000, $0800
        TITLE_SPRITE aTitleSpriteStill09, aTitleSpriteFrames, $009C, $009D, $0000, $0800
        TITLE_SPRITE aTitleSpriteStill10, aTitleSpriteFrames, $009C, $009D, $0000, $0800
        TITLE_SPRITE aTitleSpriteStill11, aTitleSpriteFrames, $009C, $009D, $0000, $0800
        TITLE_SPRITE aTitleSpriteStill12, aTitleSpriteFrames, $009C, $009D, $0000, $0800

      aTitleSprite0Motion ; 99/FF48

        ; X and Y steps for sprite 0 (rlUnknown9BF3A5), ended by $80.

        .byte $0F, $06, $0F, $06, $0F, $06, $0F, $06, $0F, $06, $0F, $06, $0F, $06, $0F, $06
        .byte $0F, $06, $0F, $06, $0F, $06, $0F, $06, $0F, $06, $0F, $06, $0A, $04, $0A, $04
        .byte $05, $02, $05, $02
        .byte $80

      aTitleFlashSprite ; 99/FF6D

        _Sprites := [[(   0,    8), $00, SpriteSmall, $002, 3, 1, true, false]]
        _Sprites ..= [[(   8,    8), $00, SpriteSmall, $001, 3, 1, true, false]]
        _Sprites ..= [[(  16,    8), $00, SpriteSmall, $000, 3, 1, true, false]]
        _Sprites ..= [[(   0,    0), $00, SpriteSmall, $002, 3, 1, true, false]]
        _Sprites ..= [[(   8,    0), $00, SpriteSmall, $001, 3, 1, true, false]]
        _Sprites ..= [[(  16,    0), $00, SpriteSmall, $000, 3, 1, true, false]]
        _Sprites ..= [[(   0,   -8), $00, SpriteSmall, $002, 3, 1, true, false]]
        _Sprites ..= [[(   8,   -8), $00, SpriteSmall, $001, 3, 1, true, false]]
        _Sprites ..= [[(  16,   -8), $00, SpriteSmall, $000, 3, 1, true, false]]
        _Sprites ..= [[(   0,  -16), $00, SpriteSmall, $002, 3, 1, true, false]]
        _Sprites ..= [[(   8,  -16), $00, SpriteSmall, $001, 3, 1, true, false]]
        _Sprites ..= [[(  16,  -16), $00, SpriteSmall, $000, 3, 1, true, false]]
        _Sprites ..= [[(  -8,    8), $00, SpriteSmall, $002, 3, 1, false, false]]
        _Sprites ..= [[( -16,    8), $00, SpriteSmall, $001, 3, 1, false, false]]
        _Sprites ..= [[( -24,    8), $00, SpriteSmall, $000, 3, 1, false, false]]
        _Sprites ..= [[(  -8,    0), $00, SpriteSmall, $002, 3, 1, false, false]]
        _Sprites ..= [[( -16,    0), $00, SpriteSmall, $001, 3, 1, false, false]]
        _Sprites ..= [[( -24,    0), $00, SpriteSmall, $000, 3, 1, false, false]]
        _Sprites ..= [[(  -8,   -8), $00, SpriteSmall, $002, 3, 1, false, false]]
        _Sprites ..= [[( -16,   -8), $00, SpriteSmall, $001, 3, 1, false, false]]
        _Sprites ..= [[( -24,   -8), $00, SpriteSmall, $000, 3, 1, false, false]]
        _Sprites ..= [[(  -8,  -16), $00, SpriteSmall, $002, 3, 1, false, false]]
        _Sprites ..= [[( -16,  -16), $00, SpriteSmall, $001, 3, 1, false, false]]
        _Sprites ..= [[( -24,  -16), $00, SpriteSmall, $000, 3, 1, false, false]]

        .structSpriteArray aTitleFlashSprite._Sprites

        ; 99/FFE7

        ; 99/FFE7

    .endsection TitleData99Section


    .section Data99FFE7Section

      .al
      .xl

      aTitleCaptionScrolls ; 99/FFE7

        ; Read by rlShowNextTitleCaption.

        .byte $BC, $CA, $D1, $C9, $D8, $CD, $CA, $D8, $B4, $D8, $9F, $C9, $BC, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00

        ; 9A/0000

    .endsection Data99FFE7Section


