; Code from bank $97 not yet assigned to a game system.

    .section Unsorted978000Section

      .al
      .xl

      rlUnknown978000 ; 97/8000

        .al
        .xl
        .autsiz
        .databank ?

        lda $0AF9,b,x
        and #$01FF
        sec
        sbc $7FE198
        jsl rlUnknown9EB4BB
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
        .byte $3C, $46, $64, $64, $FF, $FF, $FF, $FF, $50, $00, $00, $80, $51, $F6, $9B, $FF
        .byte $01, $00, $00, $A4, $FC, $95, $01, $86, $FD, $95, $04, $B2, $E5, $9B, $82, $48
        .byte $F2, $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $FF, $DC
        .byte $00, $07, $9F, $F0, $9B, $80, $59, $F1, $9B, $FF, $EA, $01, $07, $FE, $F0, $9B
        .byte $FF, $17, $02, $82, $48, $F2, $95, $82, $48, $F2, $95, $FF, $80, $02, $07, $9F
        .byte $F0, $9B, $80, $59, $F1, $9B, $FF, $8E, $03, $07, $FE, $F0, $9B, $FF, $BB, $03
        .byte $82, $48, $F2, $95, $82, $48, $F2, $95, $FF, $24, $04, $07, $9F, $F0, $9B, $80
        .byte $59, $F1, $9B, $FF, $28, $05, $80, $A8, $EA, $95, $00, $F4, $FC, $95, $FF, $32
        .byte $05, $07, $FE, $F0, $9B, $FF, $9D, $05, $80, $A9, $EA, $95, $80, $97, $E6, $9B
        .byte $82, $48, $F2, $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $82, $48, $F2, $95
        .byte $82, $48, $F2, $95, $FF, $FA, $05, $00, $A4, $FC, $95, $01, $22, $FE, $95, $80
        .byte $B4, $EA, $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $82
        .byte $48, $F2, $95, $FF, $04, $06, $07, $9F, $F0, $9B, $80, $59, $F1, $9B, $FF, $D6
        .byte $06, $07, $FE, $F0, $9B, $FF, $03, $07, $82, $48, $F2, $95, $82, $48, $F2, $95
        .byte $FF, $80, $07, $07, $9F, $F0, $9B, $80, $59, $F1, $9B, $FF, $2A, $08, $02, $BC
        .byte $FA, $95, $03, $8E, $F4, $95, $80, $CE, $F9, $95, $FF, $48, $08, $03, $8E, $F4
        .byte $95, $80, $FB, $F9, $95, $FF, $52, $08, $07, $FE, $F0, $9B, $FF, $66, $08, $03
        .byte $8E, $F4, $95, $80, $1E, $FA, $95, $FF, $7F, $08, $82, $48, $F2, $95, $82, $48
        .byte $F2, $95, $FF, $84, $08, $03, $F0, $F4, $95, $80, $41, $FA, $95, $FF, $A2, $08
        .byte $03, $F0, $F4, $95, $80, $64, $FA, $95, $FF, $C0, $08, $03, $F0, $F4, $95, $80
        .byte $87, $FA, $95, $FF, $F2, $08, $03, $52, $F5, $95, $80, $AA, $FA, $95, $FF, $FC
        .byte $08, $07, $9F, $F0, $9B, $80, $59, $F1, $9B, $FF, $0A, $0A, $07, $FE, $F0, $9B
        .byte $FF, $2A, $0B, $80, $3B, $EB, $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $FF
        .byte $3A, $0B, $80, $F3, $F2, $9B, $FF, $EE, $0B, $80, $4C, $EB, $95, $82, $48, $F2
        .byte $95, $82, $48, $F2, $95, $FF, $26, $0C, $01, $A0, $FE, $95, $04, $30, $F6, $95
        .byte $80, $5D, $EB, $95, $80, $E5, $F2, $95, $07, $9F, $F0, $9B, $80, $59, $F1, $9B
        .byte $FF, $46, $0C, $80, $B3, $EB, $95, $FF, $62, $0C, $80, $0E, $EC, $95, $82, $48
        .byte $F2, $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $82, $48
        .byte $F2, $95, $82, $48, $F2, $95, $FF, $71, $0C, $80, $F9, $F2, $95, $FF, $A6, $0C
        .byte $80, $4D, $EC, $95, $80, $0D, $F3, $95, $FF, $D6, $0C, $80, $21, $F3, $95, $FF
        .byte $D9, $0C, $80, $31, $F8, $95, $FF, $DA, $0C, $80, $58, $EC, $95, $80, $5B, $F8
        .byte $95, $FF, $34, $0D, $07, $FE, $F0, $9B, $FF, $4E, $0D, $80, $6D, $F8, $95, $05
        .byte $1C, $FD, $95, $FF, $5E, $0D, $80, $63, $EC, $95, $FF, $6E, $0D, $00, $A4, $FC
        .byte $95, $01, $D9, $FE, $95, $80, $6E, $EC, $95, $80, $59, $D6, $96, $80, $35, $F3
        .byte $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $82, $48, $F2
        .byte $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $FF, $8C, $0D, $07, $9F, $F0, $9B
        .byte $80, $59, $F1, $9B, $FF, $67, $0E, $80, $77, $F7, $95, $FF, $68, $0E, $80, $D6
        .byte $EC, $95, $80, $A5, $F7, $95, $FF, $9A, $0E, $07, $FE, $F0, $9B, $FF, $DE, $0E
        .byte $05, $1C, $FD, $95, $FF, $EE, $0E, $80, $E1, $EC, $95, $82, $48, $F2, $95, $82
        .byte $48, $F2, $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $FF, $FE, $0E, $00, $A4
        .byte $FC, $95, $01, $35, $FF, $95, $80, $EC, $EC, $95, $80, $59, $D6, $96, $80, $49
        .byte $F3, $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $FF, $1C, $0F, $07, $9F, $F0
        .byte $9B, $80, $59, $F1, $9B, $FF, $F7, $0F, $80, $B7, $F7, $95, $FF, $F8, $0F, $80
        .byte $4E, $ED, $95, $80, $E5, $F7, $95, $80, $7A, $F4, $95, $FF, $2A, $10, $07, $FE
        .byte $F0, $9B, $FF, $39, $10, $06, $3C, $F2, $9B, $FF, $57, $10, $82, $48, $F2, $95
        .byte $82, $48, $F2, $95, $FF, $84, $10, $07, $9F, $F0, $9B, $80, $59, $F1, $9B, $FF
        .byte $98, $10, $80, $59, $ED, $95, $00, $F4, $FC, $95, $82, $48, $F2, $95, $82, $48
        .byte $F2, $95, $82, $48, $F2, $95, $FF, $0D, $11, $80, $6A, $ED, $95, $FF, $F2, $10
        .byte $80, $9F, $FB, $9B, $FF, $92, $11, $07, $FE, $F0, $9B, $FF, $FB, $11, $00, $A4
        .byte $FC, $95, $01, $6E, $FF, $95, $04, $AD, $E6, $9B, $80, $7B, $ED, $95, $80, $59
        .byte $D6, $96, $82, $48, $F2, $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $82, $48
        .byte $F2, $95, $82, $48, $F2, $95, $FF, $05, $12, $07, $9F, $F0, $9B, $80, $59, $F1
        .byte $9B, $FF, $36, $12, $80, $09, $F3, $9B, $FF, $37, $12, $80, $A4, $E2, $9B, $02
        .byte $35, $E4, $9B, $03, $72, $E3, $9B, $FF, $D7, $12, $07, $FE, $F0, $9B, $FF, $04
        .byte $13, $82, $48, $F2, $95, $82, $48, $F2, $95, $FF, $01, $13, $80, $EA, $ED, $95
        .byte $05, $A7, $E7, $9B, $FF, $02, $13, $06, $9E, $F4, $9B, $FF, $6D, $13, $07, $9F
        .byte $F0, $9B, $80, $59, $F1, $9B, $FF, $83, $13, $03, $96, $E3, $9B, $FF, $3F, $14
        .byte $07, $FE, $F0, $9B, $FF, $6C, $14, $82, $48, $F2, $95, $82, $48, $F2, $95, $FF
        .byte $B4, $14, $80, $59, $D6, $96, $FF, $B5, $14, $80, $17, $E3, $9B, $FF, $B6, $14
        .byte $80, $FD, $E2, $9B, $FF, $B7, $14, $80, $48, $F5, $9B, $FF, $B9, $14, $06, $7A
        .byte $F5, $9B, $FF, $BA, $14, $80, $B0, $FB, $9B, $03, $0B, $E4, $9B, $FF, $CD, $14
        .byte $07, $9F, $F0, $9B, $80, $59, $F1, $9B, $FF, $DB, $15, $07, $FE, $F0, $9B, $FF
        .byte $37, $16, $80, $F5, $ED, $95, $FF, $38, $16, $82, $48, $F2, $95, $82, $48, $F2
        .byte $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $FF, $6F, $16
        .byte $08, $AE, $E9, $9B, $FF, $71, $16, $80, $BD, $F2, $9B, $80, $C8, $F2, $9B, $FF
        .byte $19, $17, $80, $00, $EE, $95, $80, $59, $D6, $96, $80, $D3, $F3, $95, $FF, $45
        .byte $17, $80, $B8, $FB, $9B, $80, $E7, $F3, $95, $FF, $91, $17, $07, $11, $FA, $9B
        .byte $FF, $09, $18, $82, $48, $F2, $95, $80, $18, $F2, $9B, $FF, $59, $18, $06, $32
        .byte $F3, $9B, $FF, $60, $18, $80, $91, $E7, $9B, $01, $7A, $F7, $9B, $FF, $6D, $18
        .byte $80, $73, $FB, $9B, $FF, $73, $18, $82, $48, $F2, $95, $82, $48, $F2, $95, $07
        .byte $5C, $F6, $9B, $FF, $74, $18, $80, $71, $FD, $9B, $FF, $76, $18, $80, $8C, $FD
        .byte $9B, $FF, $78, $18, $80, $99, $FD, $9B, $FF, $7A, $18, $80, $A6, $FD, $9B, $FF
        .byte $7C, $18, $80, $B3, $FD, $9B, $FF, $7D, $18, $80, $C0, $FD, $9B, $FF, $80, $18
        .byte $80, $D2, $FD, $9B, $FF, $83, $18, $80, $DF, $FD, $9B, $FF, $84, $18, $80, $B7
        .byte $FA, $9B, $FF, $85, $18, $80, $EC, $FD, $9B, $FF, $87, $18, $80, $F9, $FD, $9B
        .byte $FF, $89, $18, $80, $06, $FE, $9B, $FF, $93, $18, $07, $D6, $F6, $9B, $80, $26
        .byte $F4, $95, $FF, $F9, $1B, $00, $F4, $FC, $95, $FF, $9F, $1C, $80, $9F, $DF, $9B
        .byte $FF, $FF, $FF, $00, $00, $00, $CC, $FC, $95, $FF, $01, $00, $80, $B7, $FA, $9B
        .byte $FF, $3A, $00, $07, $5C, $F6, $9B, $FF, $5A, $00, $07, $D6, $F6, $9B, $80, $26
        .byte $F4, $95, $FF, $8C, $03, $00, $F4, $FC, $95, $FF, $1E, $04, $80, $9F, $DF, $9B
        .byte $FF, $FF, $FF, $00, $00, $04, $C6, $FA, $9B, $80, $40, $F4, $95, $82, $48, $F2
        .byte $95, $FF, $04, $00, $80, $58, $FA, $9B, $82, $48, $F2, $95, $FF, $28, $00, $80
        .byte $6E, $FA, $9B, $82, $48, $F2, $95, $82, $48, $F2, $95, $82, $48, $F2, $95, $80
        .byte $85, $FA, $9B, $FF, $31, $00, $80, $A1, $FA, $9B, $80, $68, $FB, $9B, $FF, $FF
        .byte $FF

        ; 97/F19B

    .endsection Table97E8FBSection


    .section Data97F19BSection

      .al
      .xl

      aUnknown97F19B ; 97/F19B

        ; Read by rlUnknown95F1D5 via rlUnknown95F1A9.

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

      aUnknown97F45A ; 97/F45A

        ; Read by rlUnknown95F1D5 via rlUnknown95F1BF.

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

      aUnknown97F48B ; 97/F48B

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
        .byte $0F, $FF, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $00, $00
        .byte $00, $00, $01, $01, $01, $01, $02, $02, $02, $02, $03, $03, $03, $03, $04, $04
        .byte $04, $04, $05, $05, $05, $05, $06, $06, $06, $06, $07, $07, $07, $07, $08, $08
        .byte $08, $08, $09, $09, $09, $09, $0A, $0A, $0A, $0A, $0B, $0B, $0B, $0B, $0C, $0C
        .byte $0C, $0C, $0D, $0D, $0D, $0D, $0E, $0E, $0E, $0E, $0F, $FF, $0E, $0F, $0E, $0F
        .byte $0E, $0E, $0E, $0E, $0D, $0E, $0D, $0E, $0D, $0D, $0D, $0D, $0C, $0D, $0C, $0D
        .byte $0C, $0C, $0C, $0C, $0B, $0C, $0B, $0C, $0B, $0B, $0B, $0B, $0A, $0B, $0A, $0B
        .byte $0A, $0A, $0A, $0A, $09, $0A, $09, $0A, $09, $09, $09, $09, $08, $09, $08, $09
        .byte $08, $08, $08, $08, $07, $08, $07, $08, $07, $07, $07, $07, $06, $07, $06, $07
        .byte $06, $06, $06, $06, $05, $06, $05, $06, $05, $05, $05, $05, $04, $05, $04, $05
        .byte $04, $04, $04, $04, $03, $04, $03, $04, $03, $03, $03, $03, $02, $03, $02, $03
        .byte $02, $02, $02, $02, $01, $02, $01, $02, $01, $01, $01, $01, $00, $01, $00, $01
        .byte $80, $FF, $0E, $0D, $0C, $0B, $0A, $09, $08, $07, $06, $05, $04, $03, $02, $01
        .byte $00, $80, $FF

      aUnknown97F64E ; 97/F64E

        ; Read by rlUnknown95F7B7.

        .byte $17, $00, $03, $00, $00, $00, $00, $04, $01, $01, $00, $FD, $16, $00, $03, $00
        .byte $00, $00, $00, $04, $01, $01, $00, $FD, $03, $00, $03, $00, $00, $00, $00, $04
        .byte $02, $38, $00, $01, $80, $00, $00, $81, $80, $00, $00, $00, $80, $00, $00, $00
        .byte $FD, $83, $02, $37, $02, $02, $7F, $00, $00, $82, $80, $00, $00, $00, $80, $80
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
        .byte $9A, $BD, $FC, $C8, $9A, $C4, $FF, $36, $5C, $D9, $00, $00, $FD, $83, $02, $21
        .byte $43, $43, $5F, $7A, $00, $C3, $A0, $86, $FF, $00, $A0, $82, $FF, $02, $17, $4C
        .byte $4C, $64, $39, $00, $96, $64, $18, $03, $B8, $A5, $21, $FF, $02, $0F, $51, $51
        .byte $6C, $00, $00, $AA, $6C, $70, $01, $A9, $A7, $87, $FE, $02, $09, $50, $50, $75
        .byte $C7, $FF, $BC, $75, $D8, $00, $96, $A7, $C4, $FC, $02, $07, $49, $4A, $80, $7F
        .byte $FF, $C9, $80, $7E, $00, $01, $5B, $00, $00, $02, $07, $54, $3E, $8B, $22, $FF
        .byte $D4, $8B, $39, $00, $18, $56, $21, $03, $00, $FF

        ; Palette / battle sprite effect entries ($97/F928-$97/F9C4)
        .long aUnknown99F6C1
        .byte $15, $F7, $6E, $00, $F0, $00, $00, $00, $00, $00
        .long aUnknown99F6C1
        .byte $15, $F7, $92, $00, $F0, $00, $00, $00, $00, $00
        .long aUnknown99F6C1
        .byte $15, $F7, $4D, $00, $F0, $00, $00, $00, $00, $00
        .long aUnknown99F6C1
        .byte $15, $F7, $B3, $00, $F0, $00, $00, $00, $00, $00
        .long aUnknown99F6D5
        .byte $15, $F7, $3A, $00, $F0, $00, $00, $00, $00, $00
        .long aUnknown99F6D5
        .byte $15, $F7, $C6, $00, $F0, $00, $00, $00, $00, $00
        .long aUnknown99F6CB
        .byte $15, $F7, $3B, $00, $F0, $00, $00, $00, $00, $00
        .long aUnknown99F6CB
        .byte $15, $F7, $C5, $00, $F0, $00, $00, $00, $00, $00
        .long aUnknown99F6CB
        .byte $15, $F7, $4F, $00, $F0, $00, $00, $00, $00, $00
        .long aUnknown99F6CB
        .byte $15, $F7, $B1, $00, $F0, $00, $00, $00, $00, $00
        .long aUnknown99F6CB
        .byte $15, $F7, $71, $00, $F0, $00, $00, $00, $00, $00
        .long aUnknown99F6CB
        .byte $15, $F7, $8F, $00, $F0, $00, $00, $00, $00, $00

        .byte $13, $FE, $9B, $37, $FE, $80, $00, $F0, $00, $00, $00, $00, $00, $00, $00, $62
        .byte $00, $C4, $00, $26, $01, $88, $01, $EA, $01, $AE, $02, $10, $03, $72, $03, $D4
        .byte $03, $36, $04, $98, $04, $4C, $02, $72, $01, $3F, $01, $23, $01, $4C, $01, $58
        .byte $01, $70, $01, $36, $01, $14, $01, $6C, $01, $31, $01, $04, $01, $63, $01, $56
        .byte $04, $18, $00, $18, $00, $11, $00, $11, $00, $06, $00, $06, $00, $FA, $FF, $FA
        .byte $FF, $EF, $FF, $EF, $FF, $E8, $FF, $E8, $FF, $80, $FF
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


    .section Unsorted97FDC1Section

      .al
      .xl

      rlUnknown97FDC1 ; 97/FDC1

        .al
        .xl
        .autsiz
        .databank ?

        clc
        jsr rsUnknown97FDE2
        rtl

        .databank 0

        ; 97/FDC6

      rlUnknown97FDC6 ; 97/FDC6

        .al
        .xl
        .autsiz
        .databank ?

        sec
        jsr rsUnknown97FDE2
        lda $0CC2,b
        beq _FDD2
        dec a
        bra _FDDE


        _FDD2
        jsl rlGetHighestCompletionCount
        cmp #$0010
        bcc _FDDE
        lda #$000F

        _FDDE
        sta $0CC2,b
        rtl

        .databank 0

        ; 97/FDE2


      rsUnknown97FDE2 ; 97/FDE2

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        php
        lda $0CC2,b
        asl a
        asl a
        pha
        asl a
        clc
        adc #1,s
        tax
        pla
        plp
        bcc _FDFA
        txa
        clc
        adc #$0006
        tax

        _FDFA
        lda aDemoBattlesPointerTable,x
        sta lR18
        lda aDemoBattlesPointerTable+1,x
        sta lR18+1
        lda aDemoBattlesPointerTable+3,x
        sta lR19
        lda aDemoBattlesPointerTable+4,x
        sta lR19+1
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #$0000
        sta $7E4ECB
        sta $7E4ED7
        sta $7E4ED3
        sta $7E4ECF
        lda #$FFFF
        sta $7E4ED1
        lda #$0000
        sta wBattleQuotePointer
        sta wDeathQuotePointer
        ldy #$0000
        lda [lR18],y
        and #$00FF
        sta wBattleSong
        inc y
        sep #$20
        sta $7FFC9D
        rep #$20
        lda [lR18],y
        sta $7E4F1D
        inc y
        inc y
        lda [lR18],y
        sta $7E4EBD
        inc y
        inc y
        lda [lR18],y
        and #$00FF
        sta $7E4F1F
        inc y
        lda [lR18],y
        and #$00FF
        sta $7E4EBF
        inc y
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        bne _FE87
        lda #$FFFF

        _FE87
        sta $7E4F3D
        inc y
        lda [lR18],y
        and #$00FF
        cmp #$00FF
        bne _FE99
        lda #$FFFF

        _FE99
        sta $7E4EDD
        inc y
        lda [lR18],y
        bit #$0080
        bne _FEAA
        lda #$0000
        bra _FEAD


        _FEAA
        lda #$0004

        _FEAD
        sta wCurrentChapter,b
        lda [lR18],y
        and #$007F
        sta $7E4F23
        inc y
        lda [lR18],y
        bit #$0080
        beq _FEC8
        lda #$0008
        sta $7E4ED7

        _FEC8
        lda [lR18],y
        and #$007F
        sta $7E4EC3
        inc y
        lda [lR18],y
        bit #$0080
        beq _FEE3
        sep #$20
        lda #$02
        sta $7E4EA9
        rep #$20

        _FEE3
        lda [lR18],y
        and #$007F
        sta $7E4F27
        inc y
        lda [lR18],y
        and #$00FF
        sta $7E4EC7
        inc y
        lda [lR18],y
        and #$00FF
        sta $7E4F25
        inc y
        lda [lR18],y
        and #$00FF
        sta aChildAverageLevelStats
        inc y
        lda [lR18],y
        and #$007F
        sta $7E4F29
        inc y
        lda [lR18],y
        and #$00FF
        sta $7E4EC9
        inc y
        lda [lR18],y
        and #$00FF
        sta $7E4F47
        inc y
        lda [lR18],y
        and #$00FF
        sta $7E4EE7
        inc y
        lda [lR18],y
        and #$00FF
        sta $7E4F4F
        inc y
        lda [lR18],y
        and #$00FF
        sta $7E4EEF
        inc y
        lda [lR18],y
        and #$00FF
        sta $7E4F51
        inc y
        lda [lR18],y
        and #$00FF
        sta $7E4EF1
        inc y
        lda [lR18],y
        pha
        and #$000F
        sta $7E4F1B
        pla
        lsr a
        lsr a
        lsr a
        lsr a
        and #$000F
        sta $7E4F17
        inc y
        lda [lR18],y
        pha
        and #$000F
        sta $7E4EBB
        pla
        lsr a
        lsr a
        lsr a
        lsr a
        and #$000F
        sta $7E4EB7
        inc y
        lda [lR18],y
        pha
        and #$0003
        sta wBattleDistance
        pla
        lsr a
        lsr a
        pha
        and #$0001
        sta $7E4EC1
        pla
        lsr a
        and #$0001
        sta $7E4F21
        inc y
        lda [lR18],y
        cmp #$0000
        beq _FFBA
        sta wBattleQuotePointer
        inc y
        lda [lR18],y
        sta wBattleQuotePointer+1

        _FFBA
        inc y
        inc y
        lda [lR18],y
        cmp #$0000
        beq _FFCE
        sta wDeathQuotePointer
        inc y
        lda [lR18],y
        sta wDeathQuotePointer+1

        _FFCE
        ldx #$0000
        ldy #$0000

        _FFD4
        lda [lR19],y
        cmp #$FFFF
        beq _FFE5
        sta $7E4F85,x
        inc x
        inc x
        inc y
        inc y
        bra _FFD4


        _FFE5
        sta $7E4F85,x
        lda #$00FF
        sta $7E4EA9
        lda #<>rsUnknown80BFFB
        sta wMainLoopPointer
        lda #$0000
        sta wGameStateStep,b
        ply
        plx
        rts

        .databank 0

        ; 97/FFFE


        .word $0000

        ; 98/0000

    .endsection Unsorted97FDC1Section
