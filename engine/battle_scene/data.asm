; Data read by the battle scene's code (banks $97-$99 and $E0): weapon and
; terrain lists, HUD tables, effect palettes and scripts. Named where the reader
; is known; see the comment on each.


    .section Data95937CSection

      .al
      .xl

      aUnknown95937C ; 95/937C

        ; Read by rsBattleSceneUpdateHP1, rsBattleSceneUpdateHP2.

        .word $0100, $0100, $0000, $0000, $0000, $0000, $0000, $0000

        ; 95/938C

    .endsection Data95937CSection


    .section Data959894Section

      .al
      .xl

      aUnknown959894 ; 95/9894

        ; Read by rlBattleSceneDrawHPBar.

        .byte $00

        ; 95/9895

    .endsection Data959894Section


    .section Data95AC3BSection

      .al
      .xl

      aUnknown95AC3B ; 95/AC3B

        ; Read by rlBattleSceneQueueAttack.

        .word $0B0B, $0B0B, $0707

        ; 95/AC41

    .endsection Data95AC3BSection


    .section Data95ACA8Section

      .al
      .xl

      aUnknown95ACA8 ; 95/ACA8

        ; Read by rlBattleSceneQueueCriticalAttack.

        .word $1111, $1111, $0A0A

        ; 95/ACAE

    .endsection Data95ACA8Section


    .section Data95ACF0Section

      .al
      .xl

      aUnknown95ACF0 ; 95/ACF0

        ; Read by rlBattleSceneQueueSpecialCriticalAttack.

        .word $1717, $1717, $0D0D

        ; 95/ACF6

    .endsection Data95ACF0Section


    .section Data95AD64Section

      .al
      .xl

      aUnknown95AD64 ; 95/AD64

        ; Read by rlUnknown95ACF6.

        .word $2121, $2525, $2413, $2824, $1428, $2727, $2B2B, $2A15
        .word $2E2A, $162E, $2D2D, $3131, $3017, $3430, $1834, $3333
        .word $3737, $3619, $3A36, $1A3A

        ; 95/AD8C

    .endsection Data95AD64Section


    .section Data969BE3Section

      .al
      .xl

      aUnknown969BE3 ; 96/9BE3

        ; Read by rlUnknown969B9C, rlUnknown969C63.

        .word $0000, $0020, $0040, $0060, $0080, $00A0, $00C0, $00E0
        .word $0100, $0120, $0140, $0160, $0180, $01A0, $01C0, $01E0
        .word $0200, $0220, $0240, $0260, $0280, $02A0, $02C0, $02E0
        .word $0300, $0320, $0340, $0360, $0380, $03A0, $03C0, $03E0

        ; 96/9C23

      aUnknown969C23 ; 96/9C23

        ; Read by rlUnknown969B9C, rlUnknown969C63.

        .word $0000, $0400, $0800, $0C00, $1000, $1400, $1800, $1C00
        .word $2000, $2400, $2800, $2C00, $3000, $3400, $3800, $3C00
        .word $4000, $4400, $4800, $4C00, $5000, $5400, $5800, $5C00
        .word $6000, $6400, $6800, $6C00, $7000, $7400, $7800, $7C00

        ; 96/9C63

    .endsection Data969BE3Section


    .section Data96ED67Section

      .al
      .xl

      aUnknown96ED67 ; 96/ED67

        ; Read by rsUnknown96ED23.

        .word $0000, $0401, $0802, $0C03, $1004, $1405, $1806, $1C07
        .word $2008, $2409, $280A, $2C0B, $300C, $340D, $380E, $3C0F
        .word $4010, $4411, $4812, $4C13, $5014, $5415, $5816, $5C17
        .word $6018, $6419, $681A, $6C1B, $701C, $741D, $781E, $7C1F

        ; 96/EDA7

    .endsection Data96ED67Section


    .section Data96EDF2Section

      .al
      .xl

      aUnknown96EDF2 ; 96/EDF2

        ; Read by rlUnknown96EDC0.

        .word $0000, $0421, $0842, $0C63, $1084, $14A5, $18C6, $1CE7
        .word $2108, $2529, $294A, $2D6B, $318C, $35AD, $39CE, $3DEF
        .word $4210, $4631, $4A52, $4E73, $5294, $56B5, $5AD6, $5EF7
        .word $6318, $6739, $6B5A, $6F7B, $739C, $77BD, $7BDE, $7FFF

        ; 96/EE32

    .endsection Data96EDF2Section


    .section Data97BDD4Section

      .al
      .xl

      aUnknown97BDD4 ; 97/BDD4

        ; Read by rlBattleSceneCommandCallRoutine, rlBattleSceneCommandCallRoutineUntilDone, rlBattleSceneCommandSetRoutine.

        .byte $D9, $85, $96, $60, $83, $96, $FC, $86, $96, $C8, $8D, $96, $22, $8E, $96, $A7
        .byte $CA, $96, $00, $8E, $96, $4C, $8E, $96, $E1, $8D, $96, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $0D, $83, $96, $50, $8F, $96, $C8, $DC, $96
        .byte $63, $91, $96, $73, $97, $96, $9F, $97, $96, $8F, $8E, $96, $E9, $8E, $96, $C7
        .byte $8E, $96, $13, $8F, $96, $A8, $8E, $96, $8C, $E0, $95, $BA, $88, $96, $E4, $88
        .byte $96, $0E, $89, $96, $0D, $E8, $95, $88, $E8, $95, $C9, $E8, $95, $B3, $E7, $95
        .byte $CB, $E7, $95, $EC, $E7, $95, $AD, $CA, $96, $77, $E8, $95, $56, $F3, $96, $1A
        .byte $F4, $96, $CB, $97, $96, $31, $F4, $96, $48, $F4, $96, $5F, $F4, $96, $12, $F5
        .byte $96, $2C, $F5, $96, $45, $8F, $96, $43, $F5, $96, $4F, $F5, $96, $A3, $F4, $96
        .byte $80, $F5, $96, $D7, $F5, $96, $1F, $F6, $96, $35, $F6, $96, $9B, $F8, $96, $DA
        .byte $FA, $96, $F9, $FB, $96, $EA, $97, $96, $DB, $FC, $96, $39, $FB, $96, $54, $FD
        .byte $96, $2C, $80, $97, $24, $80, $97, $8D, $87, $96, $49, $FC, $96, $99, $FB, $96
        .byte $C8, $9F, $96, $5C, $A0, $96, $03, $96, $96, $17, $96, $96, $8D, $B0, $96, $13
        .byte $FD, $96, $60, $A1, $96, $81, $FC, $96

        ; 97/BEAC

    .endsection Data97BDD4Section


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


    .section Data988000Section

      .al
      .xl

      aUnknown988000 ; 98/8000

        ; 256 x 41-byte records. Read by rsUnknown959197.

        .byte $5B, $59, $56, $54, $52, $50, $4D, $4B, $49, $46, $44, $42, $40, $3D, $3B, $39, $36, $34, $32, $30, $2D ; $00
        .byte $2B, $29, $26, $24, $22, $20, $1D, $1B, $19, $16, $14, $12, $10, $0D, $0B, $09, $06, $04, $02, $00
        .byte $5B, $59, $56, $54, $52, $50, $4D, $4B, $49, $46, $44, $42, $40, $3D, $3B, $39, $36, $34, $32, $30, $2D ; $01
        .byte $2B, $29, $26, $24, $22, $20, $1D, $1B, $19, $16, $14, $12, $10, $0D, $0B, $09, $06, $04, $02, $01
        .byte $5B, $59, $56, $54, $52, $50, $4D, $4B, $49, $46, $44, $42, $41, $3E, $3C, $3A, $37, $35, $33, $31, $2E ; $02
        .byte $2C, $2A, $27, $25, $23, $21, $1E, $1C, $1A, $17, $15, $13, $11, $0E, $0C, $0A, $07, $05, $03, $02
        .byte $5B, $59, $56, $55, $53, $51, $4E, $4C, $4A, $47, $45, $43, $41, $3E, $3C, $3A, $37, $35, $33, $31, $2E ; $03
        .byte $2C, $2B, $28, $26, $24, $22, $1F, $1D, $1B, $18, $16, $14, $12, $0F, $0D, $0B, $08, $06, $04, $03
        .byte $5C, $5A, $57, $55, $53, $51, $4E, $4C, $4A, $47, $45, $43, $42, $3F, $3D, $3B, $38, $36, $34, $32, $2F ; $04
        .byte $2D, $2B, $28, $26, $24, $23, $20, $1E, $1C, $19, $17, $15, $13, $10, $0E, $0C, $09, $07, $05, $04
        .byte $5C, $5A, $57, $55, $53, $51, $4E, $4D, $4B, $48, $46, $44, $42, $3F, $3D, $3B, $38, $36, $35, $33, $30 ; $05
        .byte $2E, $2C, $29, $27, $25, $23, $20, $1E, $1D, $1A, $18, $16, $14, $11, $0F, $0D, $0A, $08, $06, $05
        .byte $5C, $5A, $57, $56, $54, $52, $4F, $4D, $4B, $48, $46, $44, $43, $40, $3E, $3C, $39, $37, $35, $33, $30 ; $06
        .byte $2E, $2D, $2A, $28, $26, $24, $21, $1F, $1D, $1A, $19, $17, $15, $12, $10, $0E, $0B, $09, $07, $06
        .byte $5D, $5B, $58, $56, $54, $52, $4F, $4D, $4C, $49, $47, $45, $43, $40, $3E, $3C, $3A, $38, $36, $34, $31 ; $07
        .byte $2F, $2D, $2A, $29, $27, $25, $22, $20, $1E, $1B, $19, $18, $16, $13, $11, $0F, $0C, $0A, $08, $07
        .byte $5D, $5B, $58, $56, $54, $53, $50, $4E, $4C, $49, $47, $45, $44, $41, $3F, $3D, $3A, $38, $36, $35, $32 ; $08
        .byte $30, $2E, $2B, $29, $27, $26, $23, $21, $1F, $1C, $1A, $18, $17, $14, $12, $10, $0D, $0B, $09, $08
        .byte $5D, $5B, $58, $57, $55, $53, $50, $4E, $4C, $4A, $48, $46, $44, $41, $3F, $3D, $3B, $39, $37, $35, $32 ; $09
        .byte $30, $2F, $2C, $2A, $28, $26, $23, $22, $20, $1D, $1B, $19, $17, $15, $13, $11, $0E, $0C, $0A, $09
        .byte $5D, $5C, $59, $57, $55, $53, $50, $4F, $4D, $4A, $48, $46, $45, $42, $40, $3E, $3B, $39, $38, $36, $33 ; $0A
        .byte $31, $2F, $2D, $2B, $29, $27, $24, $22, $21, $1E, $1C, $1A, $18, $15, $14, $12, $0F, $0D, $0B, $0A
        .byte $5E, $5C, $59, $57, $55, $54, $51, $4F, $4D, $4A, $49, $47, $45, $42, $40, $3F, $3C, $3A, $38, $36, $34 ; $0B
        .byte $32, $30, $2D, $2B, $2A, $28, $25, $23, $21, $1F, $1D, $1B, $19, $16, $15, $13, $10, $0E, $0C, $0B
        .byte $5E, $5C, $59, $58, $56, $54, $51, $4F, $4E, $4B, $49, $47, $46, $43, $41, $3F, $3C, $3B, $39, $37, $34 ; $0C
        .byte $32, $31, $2E, $2C, $2A, $29, $26, $24, $22, $1F, $1E, $1C, $1A, $17, $15, $14, $11, $0F, $0D, $0C
        .byte $5E, $5C, $5A, $58, $56, $54, $52, $50, $4E, $4B, $4A, $48, $46, $43, $42, $40, $3D, $3B, $39, $38, $35 ; $0D
        .byte $33, $31, $2F, $2D, $2B, $29, $27, $25, $23, $20, $1E, $1D, $1B, $18, $16, $15, $12, $10, $0E, $0D
        .byte $5F, $5D, $5A, $58, $57, $55, $52, $50, $4F, $4C, $4A, $48, $47, $44, $42, $40, $3E, $3C, $3A, $38, $36 ; $0E
        .byte $34, $32, $2F, $2E, $2C, $2A, $27, $26, $24, $21, $1F, $1E, $1C, $19, $17, $16, $13, $11, $0F, $0E
        .byte $5F, $5D, $5A, $59, $57, $55, $52, $51, $4F, $4C, $4B, $49, $47, $44, $43, $41, $3E, $3C, $3B, $39, $36 ; $0F
        .byte $34, $33, $30, $2E, $2D, $2B, $28, $26, $25, $22, $20, $1E, $1D, $1A, $18, $16, $14, $12, $10, $0F
        .byte $5F, $5D, $5B, $59, $57, $56, $53, $51, $4F, $4D, $4B, $49, $48, $45, $43, $41, $3F, $3D, $3B, $3A, $37 ; $10
        .byte $35, $33, $31, $2F, $2D, $2C, $29, $27, $25, $23, $21, $1F, $1E, $1B, $19, $17, $15, $13, $11, $10
        .byte $5F, $5E, $5B, $59, $58, $56, $53, $52, $50, $4D, $4B, $4A, $48, $45, $44, $42, $3F, $3E, $3C, $3A, $38 ; $11
        .byte $36, $34, $31, $30, $2E, $2C, $2A, $28, $26, $24, $22, $20, $1E, $1C, $1A, $18, $16, $14, $12, $11
        .byte $60, $5E, $5B, $5A, $58, $56, $54, $52, $50, $4E, $4C, $4A, $49, $46, $44, $42, $40, $3E, $3C, $3B, $38 ; $12
        .byte $36, $35, $32, $30, $2F, $2D, $2A, $29, $27, $24, $23, $21, $1F, $1D, $1B, $19, $17, $15, $13, $12
        .byte $60, $5E, $5C, $5A, $58, $57, $54, $52, $51, $4E, $4C, $4B, $49, $46, $45, $43, $40, $3F, $3D, $3B, $39 ; $13
        .byte $37, $35, $33, $31, $2F, $2E, $2B, $29, $28, $25, $24, $22, $20, $1E, $1C, $1A, $18, $16, $14, $13
        .byte $60, $5F, $5C, $5A, $59, $57, $54, $53, $51, $4F, $4D, $4B, $4A, $47, $45, $44, $41, $3F, $3E, $3C, $39 ; $14
        .byte $38, $36, $34, $32, $30, $2F, $2C, $2A, $29, $26, $24, $23, $21, $1E, $1D, $1B, $19, $17, $15, $14
        .byte $61, $5F, $5C, $5B, $59, $57, $55, $53, $52, $4F, $4D, $4C, $4A, $47, $46, $44, $42, $40, $3E, $3D, $3A ; $15
        .byte $38, $37, $34, $33, $31, $2F, $2D, $2B, $29, $27, $25, $24, $22, $1F, $1E, $1C, $1A, $18, $16, $15
        .byte $61, $5F, $5D, $5B, $59, $58, $55, $54, $52, $4F, $4E, $4C, $4B, $48, $46, $45, $42, $41, $3F, $3D, $3B ; $16
        .byte $39, $37, $35, $33, $32, $30, $2E, $2C, $2A, $28, $26, $24, $23, $20, $1F, $1D, $1A, $19, $17, $16
        .byte $61, $60, $5D, $5B, $5A, $58, $56, $54, $52, $50, $4E, $4D, $4B, $49, $47, $45, $43, $41, $40, $3E, $3B ; $17
        .byte $3A, $38, $36, $34, $32, $31, $2E, $2D, $2B, $29, $27, $25, $24, $21, $20, $1E, $1B, $1A, $18, $17
        .byte $61, $60, $5D, $5C, $5A, $59, $56, $54, $53, $50, $4F, $4D, $4C, $49, $47, $46, $43, $42, $40, $3F, $3C ; $18
        .byte $3A, $39, $36, $35, $33, $32, $2F, $2D, $2C, $29, $28, $26, $25, $22, $20, $1F, $1C, $1B, $19, $18
        .byte $62, $60, $5E, $5C, $5A, $59, $56, $55, $53, $51, $4F, $4E, $4C, $4A, $48, $46, $44, $42, $41, $3F, $3D ; $19
        .byte $3B, $39, $37, $35, $34, $32, $30, $2E, $2D, $2A, $29, $27, $25, $23, $21, $20, $1D, $1C, $1A, $19
        .byte $62, $60, $5E, $5C, $5B, $59, $57, $55, $54, $51, $50, $4E, $4D, $4A, $49, $47, $45, $43, $41, $40, $3D ; $1A
        .byte $3C, $3A, $38, $36, $35, $33, $31, $2F, $2D, $2B, $29, $28, $26, $24, $22, $21, $1E, $1D, $1B, $1A
        .byte $62, $61, $5E, $5D, $5B, $5A, $57, $56, $54, $52, $50, $4F, $4D, $4B, $49, $47, $45, $44, $42, $40, $3E ; $1B
        .byte $3C, $3B, $38, $37, $35, $34, $31, $30, $2E, $2C, $2A, $29, $27, $25, $23, $22, $1F, $1E, $1C, $1B
        .byte $63, $61, $5F, $5D, $5C, $5A, $58, $56, $55, $52, $51, $4F, $4E, $4B, $4A, $48, $46, $44, $43, $41, $3F ; $1C
        .byte $3D, $3C, $39, $38, $36, $35, $32, $31, $2F, $2D, $2B, $2A, $28, $26, $24, $23, $20, $1F, $1D, $1C
        .byte $63, $61, $5F, $5D, $5C, $5A, $58, $57, $55, $53, $51, $50, $4E, $4C, $4A, $49, $46, $45, $43, $42, $3F ; $1D
        .byte $3E, $3C, $3A, $38, $37, $35, $33, $31, $30, $2E, $2C, $2A, $29, $27, $25, $23, $21, $20, $1E, $1D
        .byte $63, $62, $5F, $5E, $5C, $5B, $58, $57, $55, $53, $52, $50, $4F, $4C, $4B, $49, $47, $45, $44, $42, $40 ; $1E
        .byte $3E, $3D, $3B, $39, $38, $36, $34, $32, $31, $2E, $2D, $2B, $2A, $27, $26, $24, $22, $21, $1F, $1E
        .byte $63, $62, $60, $5E, $5D, $5B, $59, $57, $56, $54, $52, $51, $4F, $4D, $4B, $4A, $47, $46, $44, $43, $41 ; $1F
        .byte $3F, $3E, $3B, $3A, $38, $37, $34, $33, $31, $2F, $2E, $2C, $2B, $28, $27, $25, $23, $22, $20, $1F
        .byte $64, $62, $60, $5F, $5D, $5C, $59, $58, $56, $54, $53, $51, $50, $4D, $4C, $4A, $48, $47, $45, $44, $41 ; $20
        .byte $40, $3E, $3C, $3B, $39, $38, $35, $34, $32, $30, $2F, $2D, $2C, $29, $28, $26, $24, $23, $21, $20
        .byte $64, $63, $60, $5F, $5D, $5C, $5A, $58, $57, $54, $53, $51, $50, $4E, $4C, $4B, $49, $47, $46, $44, $42 ; $21
        .byte $40, $3F, $3D, $3B, $3A, $38, $36, $35, $33, $31, $2F, $2E, $2C, $2A, $29, $27, $25, $23, $22, $21
        .byte $64, $63, $61, $5F, $5E, $5C, $5A, $59, $57, $55, $53, $52, $51, $4E, $4D, $4B, $49, $48, $46, $45, $43 ; $22
        .byte $41, $40, $3D, $3C, $3A, $39, $37, $35, $34, $32, $30, $2F, $2D, $2B, $2A, $28, $26, $24, $23, $22
        .byte $65, $63, $61, $60, $5E, $5D, $5A, $59, $58, $55, $54, $52, $51, $4F, $4D, $4C, $4A, $48, $47, $45, $43 ; $23
        .byte $42, $40, $3E, $3D, $3B, $3A, $38, $36, $35, $32, $31, $30, $2E, $2C, $2A, $29, $27, $25, $24, $23
        .byte $65, $63, $61, $60, $5E, $5D, $5B, $59, $58, $56, $54, $53, $52, $4F, $4E, $4C, $4A, $49, $47, $46, $44 ; $24
        .byte $42, $41, $3F, $3D, $3C, $3B, $38, $37, $35, $33, $32, $30, $2F, $2D, $2B, $2A, $28, $26, $25, $24
        .byte $65, $64, $62, $60, $5F, $5D, $5B, $5A, $58, $56, $55, $53, $52, $50, $4E, $4D, $4B, $49, $48, $47, $44 ; $25
        .byte $43, $42, $40, $3E, $3D, $3B, $39, $38, $36, $34, $33, $31, $30, $2E, $2C, $2B, $29, $27, $26, $25
        .byte $65, $64, $62, $61, $5F, $5E, $5C, $5A, $59, $57, $55, $54, $53, $50, $4F, $4E, $4B, $4A, $49, $47, $45 ; $26
        .byte $44, $42, $40, $3F, $3D, $3C, $3A, $38, $37, $35, $34, $32, $31, $2F, $2D, $2C, $2A, $28, $27, $26
        .byte $66, $64, $62, $61, $60, $5E, $5C, $5B, $59, $57, $56, $54, $53, $51, $50, $4E, $4C, $4B, $49, $48, $46 ; $27
        .byte $44, $43, $41, $40, $3E, $3D, $3B, $39, $38, $36, $34, $33, $32, $30, $2E, $2D, $2B, $29, $28, $27
        .byte $66, $65, $63, $61, $60, $5F, $5C, $5B, $5A, $58, $56, $55, $54, $51, $50, $4F, $4D, $4B, $4A, $49, $46 ; $28
        .byte $45, $44, $42, $40, $3F, $3E, $3B, $3A, $39, $37, $35, $34, $33, $30, $2F, $2E, $2C, $2A, $29, $28
        .byte $66, $65, $63, $62, $60, $5F, $5D, $5B, $5A, $58, $57, $55, $54, $52, $51, $4F, $4D, $4C, $4A, $49, $47 ; $29
        .byte $46, $44, $42, $41, $40, $3E, $3C, $3B, $39, $37, $36, $35, $33, $31, $30, $2F, $2D, $2B, $2A, $29
        .byte $67, $65, $63, $62, $61, $5F, $5D, $5C, $5B, $59, $57, $56, $55, $52, $51, $50, $4E, $4C, $4B, $4A, $48 ; $2A
        .byte $46, $45, $43, $42, $40, $3F, $3D, $3C, $3A, $38, $37, $36, $34, $32, $31, $30, $2E, $2C, $2B, $2A
        .byte $67, $66, $64, $62, $61, $60, $5E, $5C, $5B, $59, $58, $56, $55, $53, $52, $50, $4E, $4D, $4C, $4A, $48 ; $2B
        .byte $47, $46, $44, $42, $41, $40, $3E, $3C, $3B, $39, $38, $36, $35, $33, $32, $30, $2E, $2D, $2C, $2B
        .byte $67, $66, $64, $63, $61, $60, $5E, $5D, $5B, $59, $58, $57, $56, $54, $52, $51, $4F, $4E, $4C, $4B, $49 ; $2C
        .byte $48, $46, $44, $43, $42, $41, $3F, $3D, $3C, $3A, $39, $37, $36, $34, $33, $31, $2F, $2E, $2D, $2C
        .byte $68, $66, $64, $63, $62, $60, $5E, $5D, $5C, $5A, $59, $57, $56, $54, $53, $51, $50, $4E, $4D, $4C, $4A ; $2D
        .byte $48, $47, $45, $44, $43, $41, $3F, $3E, $3D, $3B, $39, $38, $37, $35, $34, $32, $30, $2F, $2E, $2D
        .byte $68, $67, $65, $63, $62, $61, $5F, $5E, $5C, $5A, $59, $58, $57, $55, $53, $52, $50, $4F, $4E, $4C, $4A ; $2E
        .byte $49, $48, $46, $45, $43, $42, $40, $3F, $3E, $3C, $3A, $39, $38, $36, $35, $33, $31, $30, $2F, $2E
        .byte $68, $67, $65, $64, $62, $61, $5F, $5E, $5D, $5B, $5A, $58, $57, $55, $54, $53, $51, $4F, $4E, $4D, $4B ; $2F
        .byte $4A, $48, $47, $45, $44, $43, $41, $40, $3E, $3C, $3B, $3A, $39, $37, $35, $34, $32, $31, $30, $2F
        .byte $68, $67, $65, $64, $63, $62, $60, $5E, $5D, $5B, $5A, $59, $58, $56, $54, $53, $51, $50, $4F, $4E, $4C ; $30
        .byte $4A, $49, $47, $46, $45, $44, $42, $40, $3F, $3D, $3C, $3B, $3A, $38, $36, $35, $33, $32, $31, $30
        .byte $69, $67, $66, $64, $63, $62, $60, $5F, $5E, $5C, $5A, $59, $58, $56, $55, $54, $52, $51, $4F, $4E, $4C ; $31
        .byte $4B, $4A, $48, $47, $45, $44, $42, $41, $40, $3E, $3D, $3C, $3A, $39, $37, $36, $34, $33, $32, $31
        .byte $69, $68, $66, $65, $63, $62, $60, $5F, $5E, $5C, $5B, $5A, $59, $57, $55, $54, $52, $51, $50, $4F, $4D ; $32
        .byte $4C, $4A, $49, $47, $46, $45, $43, $42, $41, $3F, $3E, $3C, $3B, $39, $38, $37, $35, $34, $33, $32
        .byte $69, $68, $66, $65, $64, $63, $61, $60, $5E, $5D, $5B, $5A, $59, $57, $56, $55, $53, $52, $51, $4F, $4E ; $33
        .byte $4C, $4B, $49, $48, $47, $46, $44, $43, $42, $40, $3F, $3D, $3C, $3A, $39, $38, $36, $35, $34, $33
        .byte $6A, $68, $67, $65, $64, $63, $61, $60, $5F, $5D, $5C, $5B, $5A, $58, $57, $55, $54, $52, $51, $50, $4E ; $34
        .byte $4D, $4C, $4A, $49, $48, $47, $45, $44, $42, $41, $3F, $3E, $3D, $3B, $3A, $39, $37, $36, $35, $34
        .byte $6A, $69, $67, $66, $65, $63, $62, $60, $5F, $5E, $5C, $5B, $5A, $58, $57, $56, $54, $53, $52, $51, $4F ; $35
        .byte $4E, $4D, $4B, $4A, $48, $47, $45, $44, $43, $41, $40, $3F, $3E, $3C, $3B, $3A, $38, $37, $36, $35
        .byte $6A, $69, $67, $66, $65, $64, $62, $61, $60, $5E, $5D, $5C, $5B, $59, $58, $56, $55, $54, $52, $51, $50 ; $36
        .byte $4E, $4D, $4B, $4A, $49, $48, $46, $45, $44, $42, $41, $40, $3F, $3D, $3C, $3B, $39, $38, $37, $36
        .byte $6A, $69, $68, $66, $65, $64, $62, $61, $60, $5E, $5D, $5C, $5B, $59, $58, $57, $55, $54, $53, $52, $50 ; $37
        .byte $4F, $4E, $4C, $4B, $4A, $49, $47, $46, $45, $43, $42, $41, $40, $3E, $3D, $3C, $3A, $39, $38, $37
        .byte $6B, $6A, $68, $67, $66, $65, $63, $62, $61, $5F, $5E, $5D, $5C, $5A, $59, $58, $56, $55, $54, $53, $51 ; $38
        .byte $50, $4F, $4D, $4C, $4B, $4A, $48, $47, $46, $44, $43, $42, $41, $3F, $3E, $3D, $3B, $3A, $39, $38
        .byte $6B, $6A, $68, $67, $66, $65, $63, $62, $61, $5F, $5E, $5D, $5C, $5A, $59, $58, $56, $55, $54, $53, $51 ; $39
        .byte $50, $4F, $4E, $4C, $4B, $4A, $49, $47, $46, $45, $44, $42, $41, $40, $3F, $3D, $3C, $3B, $3A, $39
        .byte $6B, $6A, $69, $67, $66, $65, $64, $63, $61, $60, $5F, $5E, $5D, $5B, $5A, $59, $57, $56, $55, $54, $52 ; $3A
        .byte $51, $50, $4E, $4D, $4C, $4B, $49, $48, $47, $46, $44, $43, $42, $41, $40, $3E, $3D, $3C, $3B, $3A
        .byte $6C, $6A, $69, $68, $67, $66, $64, $63, $62, $60, $5F, $5E, $5D, $5B, $5A, $59, $58, $57, $55, $54, $53 ; $3B
        .byte $52, $51, $4F, $4E, $4D, $4C, $4A, $49, $48, $46, $45, $44, $43, $42, $40, $3F, $3E, $3D, $3C, $3B
        .byte $6C, $6B, $69, $68, $67, $66, $64, $63, $62, $61, $60, $5F, $5E, $5C, $5B, $5A, $58, $57, $56, $55, $53 ; $3C
        .byte $52, $51, $50, $4F, $4E, $4D, $4B, $4A, $49, $47, $46, $45, $44, $42, $41, $40, $3F, $3E, $3D, $3C
        .byte $6C, $6B, $6A, $68, $67, $66, $65, $64, $63, $61, $60, $5F, $5E, $5C, $5B, $5A, $59, $58, $57, $56, $54 ; $3D
        .byte $53, $52, $50, $4F, $4E, $4D, $4C, $4B, $4A, $48, $47, $46, $45, $43, $42, $41, $40, $3F, $3E, $3D
        .byte $6C, $6B, $6A, $69, $68, $67, $65, $64, $63, $62, $61, $60, $5F, $5D, $5C, $5B, $59, $58, $57, $56, $55 ; $3E
        .byte $54, $53, $51, $50, $4F, $4E, $4C, $4B, $4A, $49, $48, $47, $46, $44, $43, $42, $41, $40, $3F, $3E
        .byte $6D, $6C, $6A, $69, $68, $67, $66, $65, $64, $62, $61, $60, $5F, $5D, $5C, $5B, $5A, $59, $58, $57, $55 ; $3F
        .byte $54, $53, $52, $51, $50, $4F, $4D, $4C, $4B, $4A, $49, $48, $47, $45, $44, $43, $42, $41, $40, $3F
        .byte $6D, $6C, $6B, $6A, $69, $68, $66, $65, $64, $63, $62, $61, $60, $5E, $5D, $5C, $5B, $5A, $59, $58, $56 ; $40
        .byte $55, $54, $53, $52, $51, $50, $4E, $4D, $4C, $4B, $4A, $49, $48, $46, $45, $44, $43, $42, $41, $40
        .byte $6D, $6C, $6B, $6A, $69, $68, $66, $65, $64, $63, $62, $61, $60, $5F, $5E, $5D, $5B, $5A, $59, $58, $57 ; $41
        .byte $56, $55, $53, $52, $51, $50, $4F, $4E, $4D, $4B, $4A, $49, $48, $47, $46, $45, $43, $42, $41, $41
        .byte $6E, $6D, $6B, $6A, $69, $68, $67, $66, $65, $63, $62, $61, $61, $5F, $5E, $5D, $5C, $5B, $5A, $59, $57 ; $42
        .byte $56, $55, $54, $53, $52, $51, $50, $4F, $4E, $4C, $4B, $4A, $49, $48, $47, $46, $44, $43, $42, $42
        .byte $6E, $6D, $6B, $6B, $6A, $69, $67, $66, $65, $64, $63, $62, $61, $60, $5F, $5E, $5C, $5B, $5A, $59, $58 ; $43
        .byte $57, $56, $55, $54, $53, $52, $50, $4F, $4E, $4D, $4C, $4B, $4A, $49, $48, $47, $45, $44, $43, $43
        .byte $6E, $6D, $6C, $6B, $6A, $69, $68, $67, $66, $64, $63, $62, $62, $60, $5F, $5E, $5D, $5C, $5B, $5A, $59 ; $44
        .byte $58, $57, $55, $54, $53, $53, $51, $50, $4F, $4E, $4D, $4C, $4B, $4A, $49, $48, $46, $45, $44, $44
        .byte $6E, $6E, $6C, $6B, $6A, $69, $68, $67, $66, $65, $64, $63, $62, $61, $60, $5F, $5D, $5C, $5C, $5B, $59 ; $45
        .byte $58, $57, $56, $55, $54, $53, $52, $51, $50, $4F, $4E, $4D, $4C, $4A, $4A, $49, $47, $46, $45, $45
        .byte $6F, $6E, $6C, $6C, $6B, $6A, $68, $67, $67, $65, $64, $63, $63, $61, $60, $5F, $5E, $5D, $5C, $5B, $5A ; $46
        .byte $59, $58, $57, $56, $55, $54, $53, $52, $51, $4F, $4F, $4E, $4D, $4B, $4A, $4A, $48, $47, $46, $46
        .byte $6F, $6E, $6D, $6C, $6B, $6A, $69, $68, $67, $66, $65, $64, $63, $62, $61, $60, $5F, $5E, $5D, $5C, $5B ; $47
        .byte $5A, $59, $57, $57, $56, $55, $53, $53, $52, $50, $4F, $4F, $4E, $4C, $4B, $4B, $49, $48, $47, $47
        .byte $6F, $6E, $6D, $6C, $6B, $6B, $69, $68, $67, $66, $65, $64, $64, $62, $61, $60, $5F, $5E, $5D, $5D, $5B ; $48
        .byte $5A, $59, $58, $57, $56, $56, $54, $53, $52, $51, $50, $4F, $4F, $4D, $4C, $4B, $4A, $49, $48, $48
        .byte $70, $6F, $6D, $6D, $6C, $6B, $6A, $69, $68, $67, $66, $65, $64, $63, $62, $61, $60, $5F, $5E, $5D, $5C ; $49
        .byte $5B, $5A, $59, $58, $57, $56, $55, $54, $53, $52, $51, $50, $4F, $4E, $4D, $4C, $4B, $4A, $49, $49
        .byte $70, $6F, $6E, $6D, $6C, $6B, $6A, $69, $68, $67, $66, $65, $65, $63, $62, $62, $60, $5F, $5F, $5E, $5C ; $4A
        .byte $5C, $5B, $5A, $59, $58, $57, $56, $55, $54, $53, $52, $51, $50, $4F, $4E, $4D, $4C, $4B, $4A, $4A
        .byte $70, $6F, $6E, $6D, $6C, $6C, $6A, $6A, $69, $67, $67, $66, $65, $64, $63, $62, $61, $60, $5F, $5E, $5D ; $4B
        .byte $5C, $5B, $5A, $59, $59, $58, $57, $56, $55, $54, $53, $52, $51, $50, $4F, $4E, $4D, $4C, $4B, $4B
        .byte $70, $70, $6E, $6E, $6D, $6C, $6B, $6A, $69, $68, $67, $66, $66, $64, $63, $63, $61, $61, $60, $5F, $5E ; $4C
        .byte $5D, $5C, $5B, $5A, $59, $59, $57, $56, $56, $54, $54, $53, $52, $51, $50, $4F, $4E, $4D, $4C, $4C
        .byte $71, $70, $6F, $6E, $6D, $6C, $6B, $6A, $6A, $68, $68, $67, $66, $65, $64, $63, $62, $61, $60, $60, $5E ; $4D
        .byte $5E, $5D, $5C, $5B, $5A, $59, $58, $57, $56, $55, $54, $54, $53, $52, $51, $50, $4F, $4E, $4D, $4D
        .byte $71, $70, $6F, $6E, $6E, $6D, $6C, $6B, $6A, $69, $68, $67, $67, $65, $65, $64, $63, $62, $61, $60, $5F ; $4E
        .byte $5E, $5E, $5C, $5C, $5B, $5A, $59, $58, $57, $56, $55, $55, $54, $53, $52, $51, $50, $4F, $4E, $4E
        .byte $71, $71, $6F, $6F, $6E, $6D, $6C, $6B, $6A, $69, $69, $68, $67, $66, $65, $64, $63, $62, $62, $61, $60 ; $4F
        .byte $5F, $5E, $5D, $5C, $5C, $5B, $5A, $59, $58, $57, $56, $55, $55, $53, $53, $52, $51, $50, $4F, $4F
        .byte $72, $71, $70, $6F, $6E, $6E, $6C, $6C, $6B, $6A, $69, $68, $68, $66, $66, $65, $64, $63, $62, $62, $60 ; $50
        .byte $60, $5F, $5E, $5D, $5C, $5C, $5A, $5A, $59, $58, $57, $56, $56, $54, $54, $53, $52, $51, $50, $50
        .byte $72, $71, $70, $6F, $6F, $6E, $6D, $6C, $6B, $6A, $69, $69, $68, $67, $66, $65, $64, $64, $63, $62, $61 ; $51
        .byte $60, $60, $5E, $5E, $5D, $5C, $5B, $5A, $5A, $59, $58, $57, $56, $55, $55, $54, $53, $52, $51, $51
        .byte $72, $71, $70, $70, $6F, $6E, $6D, $6C, $6C, $6B, $6A, $69, $69, $67, $67, $66, $65, $64, $63, $63, $62 ; $52
        .byte $61, $60, $5F, $5E, $5E, $5D, $5C, $5B, $5A, $59, $59, $58, $57, $56, $55, $55, $54, $53, $52, $52
        .byte $72, $72, $71, $70, $6F, $6F, $6E, $6D, $6C, $6B, $6A, $6A, $69, $68, $67, $67, $65, $65, $64, $63, $62 ; $53
        .byte $62, $61, $60, $5F, $5E, $5E, $5D, $5C, $5B, $5A, $5A, $59, $58, $57, $56, $56, $55, $54, $53, $53
        .byte $73, $72, $71, $70, $70, $6F, $6E, $6D, $6D, $6C, $6B, $6A, $6A, $68, $68, $67, $66, $65, $65, $64, $63 ; $54
        .byte $62, $62, $61, $60, $5F, $5F, $5D, $5D, $5C, $5B, $5A, $5A, $59, $58, $57, $57, $56, $55, $54, $54
        .byte $73, $72, $71, $71, $70, $6F, $6E, $6E, $6D, $6C, $6B, $6B, $6A, $69, $68, $68, $67, $66, $65, $65, $64 ; $55
        .byte $63, $62, $61, $61, $60, $5F, $5E, $5E, $5D, $5C, $5B, $5B, $5A, $59, $58, $58, $57, $56, $55, $55
        .byte $73, $73, $72, $71, $70, $70, $6F, $6E, $6D, $6C, $6C, $6B, $6B, $6A, $69, $68, $67, $67, $66, $65, $64 ; $56
        .byte $64, $63, $62, $61, $61, $60, $5F, $5E, $5E, $5D, $5C, $5B, $5B, $5A, $59, $58, $57, $57, $56, $56
        .byte $74, $73, $72, $71, $71, $70, $6F, $6F, $6E, $6D, $6C, $6C, $6B, $6A, $69, $69, $68, $67, $67, $66, $65 ; $57
        .byte $64, $64, $63, $62, $61, $61, $60, $5F, $5F, $5E, $5D, $5C, $5C, $5B, $5A, $59, $58, $58, $57, $57
        .byte $74, $73, $72, $72, $71, $71, $70, $6F, $6E, $6D, $6D, $6C, $6C, $6B, $6A, $69, $68, $68, $67, $67, $66 ; $58
        .byte $65, $64, $63, $63, $62, $62, $61, $60, $5F, $5E, $5E, $5D, $5D, $5C, $5B, $5A, $59, $59, $58, $58
        .byte $74, $74, $73, $72, $71, $71, $70, $6F, $6F, $6E, $6D, $6D, $6C, $6B, $6A, $6A, $69, $68, $68, $67, $66 ; $59
        .byte $66, $65, $64, $63, $63, $62, $61, $61, $60, $5F, $5F, $5E, $5D, $5C, $5C, $5B, $5A, $5A, $59, $59
        .byte $75, $74, $73, $72, $72, $71, $70, $70, $6F, $6E, $6E, $6D, $6D, $6C, $6B, $6A, $6A, $69, $68, $68, $67 ; $5A
        .byte $66, $66, $65, $64, $64, $63, $62, $62, $61, $60, $5F, $5F, $5E, $5D, $5D, $5C, $5B, $5B, $5A, $5A
        .byte $75, $74, $73, $73, $72, $72, $71, $70, $70, $6F, $6E, $6E, $6D, $6C, $6C, $6B, $6A, $6A, $69, $68, $68 ; $5B
        .byte $67, $66, $65, $65, $64, $64, $63, $62, $62, $61, $60, $60, $5F, $5E, $5E, $5D, $5C, $5C, $5B, $5B
        .byte $75, $75, $74, $73, $73, $72, $71, $71, $70, $6F, $6F, $6E, $6E, $6D, $6C, $6C, $6B, $6A, $6A, $69, $68 ; $5C
        .byte $68, $67, $66, $66, $65, $65, $64, $63, $63, $62, $61, $61, $60, $5F, $5F, $5E, $5D, $5D, $5C, $5C
        .byte $75, $75, $74, $73, $73, $72, $72, $71, $70, $70, $6F, $6F, $6E, $6D, $6D, $6C, $6B, $6B, $6A, $6A, $69 ; $5D
        .byte $68, $68, $67, $66, $66, $65, $64, $64, $63, $63, $62, $61, $61, $60, $60, $5F, $5E, $5E, $5D, $5D
        .byte $76, $75, $74, $74, $73, $73, $72, $71, $71, $70, $70, $6F, $6F, $6E, $6D, $6D, $6C, $6B, $6B, $6A, $69 ; $5E
        .byte $69, $68, $68, $67, $67, $66, $65, $65, $64, $63, $63, $62, $62, $61, $60, $60, $5F, $5F, $5E, $5E
        .byte $76, $75, $75, $74, $74, $73, $72, $72, $71, $71, $70, $70, $6F, $6E, $6E, $6D, $6C, $6C, $6B, $6B, $6A ; $5F
        .byte $6A, $69, $68, $68, $67, $67, $66, $65, $65, $64, $64, $63, $63, $62, $61, $61, $60, $60, $5F, $5F
        .byte $76, $76, $75, $75, $74, $74, $73, $72, $72, $71, $71, $70, $70, $6F, $6E, $6E, $6D, $6D, $6C, $6C, $6B ; $60
        .byte $6A, $6A, $69, $69, $68, $68, $67, $66, $66, $65, $65, $64, $64, $63, $62, $62, $61, $61, $60, $60
        .byte $77, $76, $75, $75, $74, $74, $73, $73, $72, $71, $71, $70, $70, $6F, $6F, $6E, $6E, $6D, $6D, $6C, $6B ; $61
        .byte $6B, $6A, $6A, $69, $69, $68, $68, $67, $67, $66, $65, $65, $64, $64, $63, $63, $62, $61, $61, $61
        .byte $77, $76, $76, $75, $75, $74, $74, $73, $73, $72, $71, $71, $71, $70, $6F, $6F, $6E, $6E, $6D, $6D, $6C ; $62
        .byte $6C, $6B, $6A, $6A, $69, $69, $68, $68, $67, $67, $66, $66, $65, $65, $64, $64, $63, $62, $62, $62
        .byte $77, $77, $76, $76, $75, $75, $74, $73, $73, $72, $72, $71, $71, $70, $70, $6F, $6F, $6E, $6E, $6D, $6D ; $63
        .byte $6C, $6C, $6B, $6B, $6A, $6A, $69, $69, $68, $67, $67, $67, $66, $65, $65, $65, $64, $63, $63, $63
        .byte $77, $77, $76, $76, $75, $75, $74, $74, $73, $73, $72, $72, $72, $71, $70, $70, $6F, $6F, $6E, $6E, $6D ; $64
        .byte $6D, $6C, $6C, $6B, $6B, $6B, $6A, $69, $69, $68, $68, $67, $67, $66, $66, $65, $65, $64, $64, $64
        .byte $78, $77, $77, $76, $76, $75, $75, $74, $74, $73, $73, $72, $72, $71, $71, $71, $70, $6F, $6F, $6F, $6E ; $65
        .byte $6E, $6D, $6D, $6C, $6C, $6B, $6B, $6A, $6A, $69, $69, $68, $68, $67, $67, $66, $66, $65, $65, $65
        .byte $78, $78, $77, $77, $76, $76, $75, $75, $74, $74, $73, $73, $73, $72, $71, $71, $70, $70, $70, $6F, $6F ; $66
        .byte $6E, $6E, $6D, $6D, $6C, $6C, $6B, $6B, $6B, $6A, $6A, $69, $69, $68, $68, $67, $67, $66, $66, $66
        .byte $78, $78, $77, $77, $77, $76, $76, $75, $75, $74, $74, $73, $73, $72, $72, $72, $71, $71, $70, $70, $6F ; $67
        .byte $6F, $6F, $6E, $6E, $6D, $6D, $6C, $6C, $6B, $6B, $6A, $6A, $6A, $69, $69, $68, $68, $67, $67, $67
        .byte $79, $78, $78, $77, $77, $77, $76, $76, $75, $75, $74, $74, $74, $73, $73, $72, $72, $71, $71, $71, $70 ; $68
        .byte $70, $6F, $6F, $6E, $6E, $6E, $6D, $6D, $6C, $6C, $6B, $6B, $6B, $6A, $6A, $69, $69, $68, $68, $68
        .byte $79, $78, $78, $78, $77, $77, $76, $76, $76, $75, $75, $74, $74, $73, $73, $73, $72, $72, $71, $71, $71 ; $69
        .byte $70, $70, $6F, $6F, $6F, $6E, $6E, $6D, $6D, $6C, $6C, $6C, $6B, $6B, $6A, $6A, $6A, $69, $69, $69
        .byte $79, $79, $78, $78, $78, $77, $77, $76, $76, $76, $75, $75, $75, $74, $74, $73, $73, $72, $72, $72, $71 ; $6A
        .byte $71, $71, $70, $70, $6F, $6F, $6E, $6E, $6E, $6D, $6D, $6D, $6C, $6C, $6B, $6B, $6B, $6A, $6A, $6A
        .byte $79, $79, $79, $78, $78, $78, $77, $77, $76, $76, $76, $75, $75, $75, $74, $74, $73, $73, $73, $72, $72 ; $6B
        .byte $72, $71, $71, $70, $70, $70, $6F, $6F, $6F, $6E, $6E, $6D, $6D, $6D, $6C, $6C, $6B, $6B, $6B, $6B
        .byte $7A, $79, $79, $79, $78, $78, $78, $77, $77, $76, $76, $76, $76, $75, $75, $74, $74, $74, $73, $73, $73 ; $6C
        .byte $72, $72, $71, $71, $71, $71, $70, $70, $6F, $6F, $6F, $6E, $6E, $6E, $6D, $6D, $6C, $6C, $6C, $6C
        .byte $7A, $7A, $79, $79, $79, $78, $78, $78, $77, $77, $77, $76, $76, $76, $75, $75, $75, $74, $74, $74, $73 ; $6D
        .byte $73, $73, $72, $72, $72, $71, $71, $71, $70, $70, $6F, $6F, $6F, $6E, $6E, $6E, $6D, $6D, $6D, $6D
        .byte $7A, $7A, $7A, $79, $79, $79, $78, $78, $78, $77, $77, $77, $77, $76, $76, $76, $75, $75, $75, $74, $74 ; $6E
        .byte $74, $73, $73, $73, $72, $72, $72, $71, $71, $71, $70, $70, $70, $6F, $6F, $6F, $6E, $6E, $6E, $6E
        .byte $7B, $7A, $7A, $7A, $79, $79, $79, $78, $78, $78, $78, $77, $77, $77, $76, $76, $76, $75, $75, $75, $74 ; $6F
        .byte $74, $74, $74, $73, $73, $73, $72, $72, $72, $71, $71, $71, $71, $70, $70, $70, $6F, $6F, $6F, $6F
        .byte $7B, $7B, $7A, $7A, $7A, $7A, $79, $79, $79, $78, $78, $78, $78, $77, $77, $77, $76, $76, $76, $76, $75 ; $70
        .byte $75, $75, $74, $74, $74, $74, $73, $73, $73, $72, $72, $72, $72, $71, $71, $71, $70, $70, $70, $70
        .byte $7B, $7B, $7B, $7A, $7A, $7A, $7A, $79, $79, $79, $78, $78, $78, $78, $77, $77, $77, $77, $76, $76, $76 ; $71
        .byte $76, $75, $75, $75, $74, $74, $74, $74, $73, $73, $73, $73, $72, $72, $72, $72, $71, $71, $71, $71
        .byte $7B, $7B, $7B, $7B, $7A, $7A, $7A, $7A, $79, $79, $79, $79, $79, $78, $78, $78, $77, $77, $77, $77, $76 ; $72
        .byte $76, $76, $76, $75, $75, $75, $75, $74, $74, $74, $74, $73, $73, $73, $73, $72, $72, $72, $72, $72
        .byte $7C, $7C, $7B, $7B, $7B, $7B, $7A, $7A, $7A, $7A, $79, $79, $79, $79, $78, $78, $78, $78, $78, $77, $77 ; $73
        .byte $77, $77, $76, $76, $76, $76, $75, $75, $75, $75, $75, $74, $74, $74, $74, $73, $73, $73, $73, $73
        .byte $7C, $7C, $7C, $7B, $7B, $7B, $7B, $7B, $7A, $7A, $7A, $7A, $7A, $79, $79, $79, $79, $78, $78, $78, $78 ; $74
        .byte $78, $77, $77, $77, $77, $77, $76, $76, $76, $76, $75, $75, $75, $75, $75, $74, $74, $74, $74, $74
        .byte $7C, $7C, $7C, $7C, $7C, $7B, $7B, $7B, $7B, $7B, $7A, $7A, $7A, $7A, $7A, $79, $79, $79, $79, $79, $78 ; $75
        .byte $78, $78, $78, $78, $77, $77, $77, $77, $77, $76, $76, $76, $76, $76, $75, $75, $75, $75, $75, $75
        .byte $7D, $7C, $7C, $7C, $7C, $7C, $7C, $7B, $7B, $7B, $7B, $7B, $7B, $7A, $7A, $7A, $7A, $7A, $79, $79, $79 ; $76
        .byte $79, $79, $78, $78, $78, $78, $78, $78, $77, $77, $77, $77, $77, $77, $76, $76, $76, $76, $76, $76
        .byte $7D, $7D, $7D, $7C, $7C, $7C, $7C, $7C, $7C, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7A, $7A, $7A, $7A, $7A ; $77
        .byte $7A, $79, $79, $79, $79, $79, $79, $78, $78, $78, $78, $78, $78, $77, $77, $77, $77, $77, $77, $77
        .byte $7D, $7D, $7D, $7D, $7D, $7D, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7A ; $78
        .byte $7A, $7A, $7A, $7A, $7A, $7A, $79, $79, $79, $79, $79, $79, $79, $78, $78, $78, $78, $78, $78, $78
        .byte $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7B, $7B, $7B, $7B, $7B ; $79
        .byte $7B, $7B, $7B, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $79, $79, $79, $79, $79, $79, $79, $79, $79
        .byte $7E, $7E, $7E, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C ; $7A
        .byte $7C, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A, $7A
        .byte $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7C, $7C, $7C ; $7B
        .byte $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7B, $7B
        .byte $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D ; $7C
        .byte $7D, $7D, $7D, $7D, $7D, $7D, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C, $7C
        .byte $7F, $7F, $7F, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E ; $7D
        .byte $7E, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D, $7D
        .byte $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E ; $7E
        .byte $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E, $7E
        .byte $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F ; $7F
        .byte $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F, $7F
        .byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80 ; $80
        .byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
        .byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80 ; $81
        .byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $81
        .byte $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $81, $81, $81, $81, $81, $81, $81, $81, $81 ; $82
        .byte $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $82
        .byte $80, $80, $80, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81 ; $83
        .byte $81, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $83
        .byte $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $82, $82, $82, $82, $82, $82, $82, $82, $82 ; $84
        .byte $82, $82, $82, $82, $82, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $84
        .byte $81, $81, $81, $81, $81, $81, $81, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $83, $83, $83 ; $85
        .byte $83, $83, $83, $83, $83, $83, $83, $83, $84, $84, $84, $84, $84, $84, $84, $84, $84, $84, $84, $85
        .byte $81, $81, $81, $82, $82, $82, $82, $82, $82, $82, $82, $82, $83, $83, $83, $83, $83, $83, $83, $83, $83 ; $86
        .byte $83, $84, $84, $84, $84, $84, $84, $84, $84, $84, $85, $85, $85, $85, $85, $85, $85, $85, $85, $86
        .byte $82, $82, $82, $82, $82, $82, $82, $82, $83, $83, $83, $83, $83, $83, $83, $83, $84, $84, $84, $84, $84 ; $87
        .byte $84, $84, $84, $85, $85, $85, $85, $85, $85, $85, $85, $86, $86, $86, $86, $86, $86, $86, $86, $87
        .byte $82, $82, $82, $82, $82, $83, $83, $83, $83, $83, $83, $83, $84, $84, $84, $84, $84, $84, $84, $85, $85 ; $88
        .byte $85, $85, $85, $85, $85, $86, $86, $86, $86, $86, $86, $86, $87, $87, $87, $87, $87, $87, $87, $88
        .byte $82, $82, $82, $83, $83, $83, $83, $83, $83, $84, $84, $84, $84, $84, $84, $84, $85, $85, $85, $85, $85 ; $89
        .byte $85, $86, $86, $86, $86, $86, $86, $87, $87, $87, $87, $87, $87, $88, $88, $88, $88, $88, $88, $89
        .byte $82, $83, $83, $83, $83, $83, $83, $84, $84, $84, $84, $84, $85, $85, $85, $85, $85, $85, $86, $86, $86 ; $8A
        .byte $86, $86, $87, $87, $87, $87, $87, $87, $88, $88, $88, $88, $88, $88, $89, $89, $89, $89, $89, $8A
        .byte $83, $83, $83, $83, $83, $84, $84, $84, $84, $84, $85, $85, $85, $85, $85, $86, $86, $86, $86, $86, $87 ; $8B
        .byte $87, $87, $87, $87, $88, $88, $88, $88, $88, $89, $89, $89, $89, $89, $8A, $8A, $8A, $8A, $8A, $8B
        .byte $83, $83, $83, $84, $84, $84, $84, $84, $85, $85, $85, $85, $86, $86, $86, $86, $86, $87, $87, $87, $87 ; $8C
        .byte $87, $88, $88, $88, $88, $89, $89, $89, $89, $89, $8A, $8A, $8A, $8A, $8A, $8B, $8B, $8B, $8B, $8C
        .byte $83, $83, $84, $84, $84, $84, $85, $85, $85, $85, $86, $86, $86, $86, $87, $87, $87, $87, $87, $88, $88 ; $8D
        .byte $88, $88, $89, $89, $89, $89, $8A, $8A, $8A, $8A, $8A, $8B, $8B, $8B, $8B, $8C, $8C, $8C, $8C, $8D
        .byte $84, $84, $84, $84, $85, $85, $85, $85, $86, $86, $86, $86, $87, $87, $87, $87, $88, $88, $88, $88, $89 ; $8E
        .byte $89, $89, $89, $8A, $8A, $8A, $8A, $8B, $8B, $8B, $8B, $8C, $8C, $8C, $8C, $8D, $8D, $8D, $8D, $8E
        .byte $84, $84, $84, $85, $85, $85, $85, $86, $86, $86, $87, $87, $87, $87, $88, $88, $88, $88, $89, $89, $89 ; $8F
        .byte $89, $8A, $8A, $8A, $8B, $8B, $8B, $8B, $8C, $8C, $8C, $8C, $8D, $8D, $8D, $8D, $8E, $8E, $8E, $8F
        .byte $84, $84, $85, $85, $85, $86, $86, $86, $86, $87, $87, $87, $88, $88, $88, $88, $89, $89, $89, $8A, $8A ; $90
        .byte $8A, $8A, $8B, $8B, $8B, $8C, $8C, $8C, $8C, $8D, $8D, $8D, $8E, $8E, $8E, $8E, $8F, $8F, $8F, $90
        .byte $84, $85, $85, $85, $86, $86, $86, $87, $87, $87, $87, $88, $88, $88, $89, $89, $89, $8A, $8A, $8A, $8B ; $91
        .byte $8B, $8B, $8B, $8C, $8C, $8C, $8D, $8D, $8D, $8E, $8E, $8E, $8E, $8F, $8F, $8F, $90, $90, $90, $91
        .byte $85, $85, $85, $86, $86, $86, $87, $87, $87, $88, $88, $88, $89, $89, $89, $89, $8A, $8A, $8A, $8B, $8B ; $92
        .byte $8B, $8C, $8C, $8C, $8D, $8D, $8D, $8E, $8E, $8E, $8F, $8F, $8F, $90, $90, $90, $91, $91, $91, $92
        .byte $85, $85, $86, $86, $86, $87, $87, $87, $88, $88, $88, $89, $89, $89, $8A, $8A, $8A, $8B, $8B, $8B, $8C ; $93
        .byte $8C, $8C, $8D, $8D, $8D, $8E, $8E, $8E, $8F, $8F, $90, $90, $90, $91, $91, $91, $92, $92, $92, $93
        .byte $85, $86, $86, $86, $87, $87, $87, $88, $88, $89, $89, $89, $8A, $8A, $8A, $8B, $8B, $8B, $8C, $8C, $8C ; $94
        .byte $8D, $8D, $8E, $8E, $8E, $8F, $8F, $8F, $90, $90, $90, $91, $91, $91, $92, $92, $93, $93, $93, $94
        .byte $86, $86, $86, $87, $87, $87, $88, $88, $89, $89, $89, $8A, $8A, $8A, $8B, $8B, $8C, $8C, $8C, $8D, $8D ; $95
        .byte $8D, $8E, $8E, $8F, $8F, $8F, $90, $90, $90, $91, $91, $92, $92, $92, $93, $93, $94, $94, $94, $95
        .byte $86, $86, $87, $87, $87, $88, $88, $89, $89, $89, $8A, $8A, $8B, $8B, $8B, $8C, $8C, $8D, $8D, $8D, $8E ; $96
        .byte $8E, $8E, $8F, $8F, $90, $90, $91, $91, $91, $92, $92, $92, $93, $93, $94, $94, $94, $95, $95, $96
        .byte $86, $87, $87, $87, $88, $88, $89, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8C, $8D, $8D, $8E, $8E, $8E ; $97
        .byte $8F, $8F, $90, $90, $90, $91, $91, $92, $92, $93, $93, $93, $94, $94, $95, $95, $95, $96, $96, $97
        .byte $86, $87, $87, $88, $88, $89, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8C, $8D, $8D, $8E, $8E, $8F, $8F ; $98
        .byte $8F, $90, $90, $91, $91, $92, $92, $92, $93, $93, $94, $94, $95, $95, $95, $96, $96, $97, $97, $98
        .byte $87, $87, $88, $88, $88, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8D, $8D, $8D, $8E, $8E, $8F, $8F, $90 ; $99
        .byte $90, $90, $91, $91, $92, $92, $93, $93, $94, $94, $95, $95, $95, $96, $96, $97, $97, $98, $98, $99
        .byte $87, $87, $88, $88, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8D, $8D, $8E, $8E, $8F, $8F, $8F, $90, $90 ; $9A
        .byte $91, $91, $92, $92, $93, $93, $94, $94, $94, $95, $95, $96, $96, $97, $97, $98, $98, $99, $99, $9A
        .byte $87, $88, $88, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8D, $8D, $8E, $8E, $8E, $8F, $90, $90, $90, $91 ; $9B
        .byte $91, $92, $92, $93, $93, $94, $94, $95, $95, $96, $96, $97, $97, $98, $98, $99, $99, $9A, $9A, $9B
        .byte $88, $88, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8D, $8D, $8E, $8E, $8F, $8F, $90, $90, $91, $91, $92 ; $9C
        .byte $92, $93, $93, $94, $94, $95, $95, $96, $96, $97, $97, $98, $98, $99, $99, $9A, $9A, $9B, $9B, $9C
        .byte $88, $88, $89, $89, $8A, $8A, $8B, $8C, $8C, $8D, $8D, $8E, $8E, $8F, $8F, $90, $90, $91, $91, $92, $92 ; $9D
        .byte $93, $93, $94, $94, $95, $95, $96, $96, $97, $98, $98, $98, $99, $9A, $9A, $9A, $9B, $9C, $9C, $9D
        .byte $88, $89, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8D, $8E, $8E, $8F, $8F, $90, $90, $91, $91, $92, $92, $93 ; $9E
        .byte $93, $94, $95, $95, $96, $96, $97, $97, $98, $98, $99, $99, $9A, $9A, $9B, $9B, $9C, $9D, $9D, $9E
        .byte $88, $89, $8A, $8A, $8B, $8B, $8C, $8C, $8D, $8E, $8E, $8F, $8F, $90, $90, $91, $91, $92, $92, $93, $94 ; $9F
        .byte $94, $95, $95, $96, $96, $97, $97, $98, $98, $99, $9A, $9A, $9B, $9B, $9C, $9C, $9D, $9E, $9E, $9F
        .byte $89, $89, $8A, $8B, $8B, $8C, $8C, $8D, $8D, $8E, $8F, $8F, $90, $90, $91, $91, $92, $93, $93, $94, $94 ; $A0
        .byte $95, $95, $96, $97, $97, $98, $98, $99, $99, $9A, $9B, $9B, $9C, $9C, $9D, $9D, $9E, $9F, $9F, $A0
        .byte $89, $8A, $8A, $8B, $8B, $8C, $8D, $8D, $8E, $8E, $8F, $8F, $90, $91, $91, $92, $93, $93, $94, $94, $95 ; $A1
        .byte $95, $96, $97, $97, $98, $98, $99, $9A, $9A, $9B, $9B, $9C, $9C, $9D, $9E, $9E, $9F, $9F, $A0, $A1
        .byte $89, $8A, $8B, $8B, $8C, $8C, $8D, $8E, $8E, $8F, $8F, $90, $91, $91, $92, $92, $93, $94, $94, $95, $96 ; $A2
        .byte $96, $97, $97, $98, $98, $99, $9A, $9A, $9B, $9C, $9C, $9D, $9D, $9E, $9F, $9F, $A0, $A0, $A1, $A2
        .byte $8A, $8A, $8B, $8C, $8C, $8D, $8D, $8E, $8F, $8F, $90, $90, $91, $92, $92, $93, $94, $94, $95, $95, $96 ; $A3
        .byte $97, $97, $98, $99, $99, $9A, $9B, $9B, $9C, $9C, $9D, $9E, $9E, $9F, $9F, $A0, $A1, $A1, $A2, $A3
        .byte $8A, $8A, $8B, $8C, $8C, $8D, $8E, $8E, $8F, $90, $90, $91, $92, $92, $93, $93, $94, $95, $95, $96, $97 ; $A4
        .byte $97, $98, $99, $99, $9A, $9B, $9B, $9C, $9C, $9D, $9E, $9E, $9F, $A0, $A0, $A1, $A2, $A2, $A3, $A4
        .byte $8A, $8B, $8C, $8C, $8D, $8D, $8E, $8F, $8F, $90, $91, $91, $92, $93, $93, $94, $95, $95, $96, $97, $97 ; $A5
        .byte $98, $99, $9A, $9A, $9B, $9B, $9C, $9D, $9D, $9E, $9F, $9F, $A0, $A1, $A1, $A2, $A3, $A3, $A4, $A5
        .byte $8A, $8B, $8C, $8D, $8D, $8E, $8F, $8F, $90, $91, $91, $92, $93, $93, $94, $95, $95, $96, $97, $97, $98 ; $A6
        .byte $99, $99, $9A, $9B, $9B, $9C, $9D, $9D, $9E, $9F, $A0, $A0, $A1, $A2, $A2, $A3, $A4, $A4, $A5, $A6
        .byte $8B, $8B, $8C, $8D, $8E, $8E, $8F, $90, $90, $91, $92, $92, $93, $94, $95, $95, $96, $97, $97, $98, $99 ; $A7
        .byte $99, $9A, $9B, $9C, $9C, $9D, $9E, $9E, $9F, $A0, $A0, $A1, $A2, $A3, $A3, $A4, $A5, $A5, $A6, $A7
        .byte $8B, $8C, $8D, $8D, $8E, $8F, $8F, $90, $91, $92, $92, $93, $94, $94, $95, $96, $97, $97, $98, $99, $99 ; $A8
        .byte $9A, $9B, $9C, $9C, $9D, $9E, $9E, $9F, $A0, $A1, $A1, $A2, $A3, $A3, $A4, $A5, $A6, $A6, $A7, $A8
        .byte $8B, $8C, $8D, $8E, $8E, $8F, $90, $90, $91, $92, $93, $93, $94, $95, $96, $96, $97, $98, $98, $99, $9A ; $A9
        .byte $9B, $9B, $9C, $9D, $9E, $9E, $9F, $A0, $A0, $A1, $A2, $A3, $A3, $A4, $A5, $A6, $A7, $A7, $A8, $A9
        .byte $8C, $8C, $8D, $8E, $8F, $8F, $90, $91, $92, $93, $93, $94, $95, $95, $96, $97, $98, $98, $99, $9A, $9B ; $AA
        .byte $9B, $9C, $9D, $9E, $9E, $9F, $A0, $A1, $A1, $A2, $A3, $A4, $A4, $A5, $A6, $A7, $A8, $A8, $A9, $AA
        .byte $8C, $8D, $8E, $8E, $8F, $90, $91, $91, $92, $93, $94, $94, $95, $96, $97, $97, $98, $99, $9A, $9A, $9B ; $AB
        .byte $9C, $9D, $9E, $9E, $9F, $A0, $A1, $A1, $A2, $A3, $A4, $A4, $A5, $A6, $A7, $A7, $A8, $A9, $AA, $AB
        .byte $8C, $8D, $8E, $8F, $8F, $90, $91, $92, $92, $93, $94, $95, $96, $97, $97, $98, $99, $9A, $9A, $9B, $9C ; $AC
        .byte $9D, $9D, $9E, $9F, $A0, $A1, $A2, $A2, $A3, $A4, $A5, $A5, $A6, $A7, $A8, $A8, $A9, $AA, $AB, $AC
        .byte $8D, $8D, $8E, $8F, $90, $90, $91, $92, $93, $94, $95, $95, $96, $97, $98, $98, $9A, $9A, $9B, $9C, $9D ; $AD
        .byte $9D, $9E, $9F, $A0, $A1, $A1, $A2, $A3, $A4, $A5, $A5, $A6, $A7, $A8, $A9, $A9, $AA, $AB, $AC, $AD
        .byte $8D, $8E, $8F, $8F, $90, $91, $92, $93, $93, $94, $95, $96, $97, $98, $98, $99, $9A, $9B, $9C, $9C, $9D ; $AE
        .byte $9E, $9F, $A0, $A1, $A1, $A2, $A3, $A4, $A5, $A6, $A6, $A7, $A8, $A9, $AA, $AA, $AB, $AC, $AD, $AE
        .byte $8D, $8E, $8F, $90, $90, $91, $92, $93, $94, $95, $96, $96, $97, $98, $99, $9A, $9B, $9B, $9C, $9D, $9E ; $AF
        .byte $9F, $9F, $A1, $A1, $A2, $A3, $A4, $A5, $A5, $A6, $A7, $A8, $A9, $AA, $AA, $AB, $AC, $AD, $AE, $AF
        .byte $8D, $8E, $8F, $90, $91, $92, $93, $93, $94, $95, $96, $97, $98, $99, $99, $9A, $9B, $9C, $9D, $9E, $9F ; $B0
        .byte $9F, $A0, $A1, $A2, $A3, $A4, $A5, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AB, $AC, $AD, $AE, $AF, $B0
        .byte $8E, $8E, $90, $90, $91, $92, $93, $94, $95, $96, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9D, $9E, $9F ; $B1
        .byte $A0, $A1, $A2, $A3, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AA, $AC, $AC, $AD, $AE, $AF, $B0, $B1
        .byte $8E, $8F, $90, $91, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9A, $9B, $9C, $9D, $9E, $9F, $A0 ; $B2
        .byte $A1, $A1, $A3, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2
        .byte $8E, $8F, $90, $91, $92, $93, $94, $95, $95, $97, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $9F, $A1 ; $B3
        .byte $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3
        .byte $8F, $8F, $91, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9C, $9E, $9E, $9F, $A0, $A1 ; $B4
        .byte $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $A9, $AB, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4
        .byte $8F, $90, $91, $92, $93, $93, $95, $95, $96, $98, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2 ; $B5
        .byte $A3, $A4, $A5, $A6, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4, $B5
        .byte $8F, $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9D, $9F, $A0, $A0, $A1, $A3 ; $B6
        .byte $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B6
        .byte $8F, $90, $92, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3 ; $B7
        .byte $A4, $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7
        .byte $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $A4 ; $B8
        .byte $A5, $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8
        .byte $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $A4 ; $B9
        .byte $A5, $A6, $A8, $A8, $A9, $AA, $AC, $AC, $AD, $AF, $B0, $B0, $B1, $B3, $B4, $B4, $B6, $B7, $B8, $B9
        .byte $90, $91, $93, $93, $94, $95, $97, $98, $98, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $A4, $A5 ; $BA
        .byte $A6, $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $B0, $B0, $B1, $B2, $B4, $B5, $B5, $B7, $B8, $B9, $BA
        .byte $91, $91, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A2, $A3, $A3, $A4, $A6 ; $BB
        .byte $A7, $A8, $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B5, $B5, $B6, $B8, $B9, $BA, $BB
        .byte $91, $92, $93, $94, $95, $96, $97, $98, $99, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $A4, $A5, $A6 ; $BC
        .byte $A7, $A8, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B9, $BA, $BB, $BC
        .byte $91, $92, $94, $94, $95, $96, $98, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A3, $A4, $A5, $A6, $A7 ; $BD
        .byte $A8, $A9, $AA, $AB, $AC, $AD, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $BA, $BB, $BC, $BD
        .byte $91, $92, $94, $95, $96, $97, $98, $99, $9A, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A8 ; $BE
        .byte $A9, $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BB, $BC, $BD, $BE
        .byte $92, $93, $94, $95, $96, $97, $99, $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A4, $A5, $A6, $A7, $A8 ; $BF
        .byte $A9, $AA, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B4, $B5, $B6, $B7, $B8, $B9, $BA, $BC, $BD, $BE, $BF
        .byte $92, $93, $95, $96, $97, $98, $99, $9A, $9B, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $A5, $A6, $A7, $A8, $A9 ; $C0
        .byte $AA, $AB, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B5, $B6, $B7, $B8, $B9, $BA, $BB, $BD, $BE, $BF, $C0
        .byte $92, $93, $95, $96, $97, $98, $99, $9A, $9B, $9D, $9E, $9F, $A0, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $AA ; $C1
        .byte $AB, $AC, $AD, $AE, $AF, $B0, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $BA, $BB, $BC, $BD, $BE, $BF, $C1
        .byte $93, $94, $95, $96, $97, $98, $9A, $9B, $9C, $9D, $9E, $9F, $A1, $A2, $A3, $A4, $A6, $A7, $A8, $A9, $AA ; $C2
        .byte $AB, $AC, $AE, $AF, $B0, $B1, $B3, $B4, $B5, $B6, $B7, $B8, $B9, $BB, $BC, $BD, $BE, $BF, $C0, $C2
        .byte $93, $94, $95, $97, $98, $99, $9A, $9B, $9C, $9E, $9F, $A0, $A1, $A3, $A4, $A5, $A6, $A7, $A8, $A9, $AB ; $C3
        .byte $AC, $AD, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B7, $B8, $B9, $BA, $BC, $BD, $BE, $BF, $C0, $C1, $C3
        .byte $93, $94, $96, $97, $98, $99, $9B, $9C, $9D, $9E, $9F, $A0, $A2, $A3, $A4, $A5, $A7, $A8, $A9, $AA, $AC ; $C4
        .byte $AD, $AE, $AF, $B0, $B1, $B3, $B4, $B5, $B6, $B8, $B9, $BA, $BB, $BD, $BE, $BF, $C0, $C1, $C2, $C4
        .byte $93, $95, $96, $97, $98, $99, $9B, $9C, $9D, $9F, $A0, $A1, $A2, $A4, $A5, $A6, $A7, $A8, $AA, $AB, $AC ; $C5
        .byte $AD, $AE, $B0, $B1, $B2, $B3, $B5, $B6, $B7, $B9, $BA, $BB, $BC, $BD, $BF, $C0, $C1, $C2, $C3, $C5
        .byte $94, $95, $96, $98, $99, $9A, $9B, $9C, $9E, $9F, $A0, $A1, $A3, $A4, $A5, $A6, $A8, $A9, $AA, $AB, $AD ; $C6
        .byte $AE, $AF, $B1, $B2, $B3, $B4, $B6, $B7, $B8, $B9, $BB, $BC, $BD, $BE, $BF, $C1, $C2, $C3, $C4, $C6
        .byte $94, $95, $97, $98, $99, $9A, $9C, $9D, $9E, $A0, $A1, $A2, $A3, $A5, $A6, $A7, $A9, $AA, $AB, $AC, $AE ; $C7
        .byte $AF, $B0, $B1, $B3, $B4, $B5, $B6, $B8, $B9, $BA, $BB, $BD, $BE, $BF, $C0, $C2, $C3, $C4, $C5, $C7
        .byte $94, $95, $97, $98, $99, $9B, $9C, $9D, $9E, $A0, $A1, $A2, $A4, $A5, $A6, $A7, $A9, $AA, $AB, $AD, $AE ; $C8
        .byte $AF, $B0, $B2, $B3, $B4, $B6, $B7, $B8, $B9, $BB, $BC, $BD, $BF, $C0, $C1, $C2, $C4, $C5, $C6, $C8
        .byte $95, $96, $97, $99, $9A, $9B, $9D, $9E, $9F, $A1, $A2, $A3, $A4, $A6, $A7, $A8, $AA, $AB, $AC, $AD, $AF ; $C9
        .byte $B0, $B1, $B3, $B4, $B5, $B6, $B8, $B9, $BA, $BC, $BD, $BE, $BF, $C1, $C2, $C3, $C5, $C6, $C7, $C9
        .byte $95, $96, $98, $99, $9A, $9B, $9D, $9E, $9F, $A1, $A2, $A3, $A5, $A6, $A7, $A9, $AA, $AB, $AD, $AE, $AF ; $CA
        .byte $B1, $B2, $B4, $B5, $B6, $B7, $B9, $BA, $BB, $BD, $BE, $BF, $C0, $C2, $C3, $C4, $C6, $C7, $C8, $CA
        .byte $95, $96, $98, $99, $9A, $9C, $9D, $9F, $A0, $A1, $A3, $A4, $A5, $A7, $A8, $A9, $AB, $AC, $AD, $AE, $B0 ; $CB
        .byte $B1, $B2, $B4, $B5, $B7, $B8, $BA, $BB, $BC, $BE, $BF, $C0, $C1, $C3, $C4, $C5, $C7, $C8, $C9, $CB
        .byte $95, $97, $98, $9A, $9B, $9C, $9E, $9F, $A0, $A2, $A3, $A4, $A6, $A7, $A8, $AA, $AB, $AD, $AE, $AF, $B1 ; $CC
        .byte $B2, $B3, $B5, $B6, $B7, $B9, $BA, $BB, $BD, $BE, $C0, $C1, $C2, $C4, $C5, $C6, $C8, $C9, $CA, $CC
        .byte $96, $97, $99, $9A, $9B, $9C, $9E, $9F, $A1, $A2, $A4, $A5, $A6, $A8, $A9, $AA, $AC, $AD, $AE, $B0, $B1 ; $CD
        .byte $B3, $B4, $B6, $B7, $B8, $B9, $BB, $BC, $BD, $BF, $C0, $C2, $C3, $C5, $C6, $C7, $C9, $CA, $CB, $CD
        .byte $96, $97, $99, $9A, $9C, $9D, $9F, $A0, $A1, $A3, $A4, $A5, $A7, $A8, $AA, $AB, $AD, $AE, $AF, $B0, $B2 ; $CE
        .byte $B3, $B5, $B6, $B8, $B9, $BA, $BC, $BD, $BE, $C0, $C1, $C3, $C4, $C6, $C7, $C8, $CA, $CB, $CC, $CE
        .byte $96, $98, $99, $9B, $9C, $9D, $9F, $A0, $A1, $A3, $A5, $A6, $A7, $A9, $AA, $AB, $AD, $AE, $B0, $B1, $B3 ; $CF
        .byte $B4, $B5, $B7, $B8, $BA, $BB, $BD, $BE, $BF, $C1, $C2, $C3, $C5, $C6, $C8, $C9, $CB, $CC, $CD, $CF
        .byte $97, $98, $9A, $9B, $9C, $9E, $9F, $A1, $A2, $A4, $A5, $A6, $A8, $A9, $AB, $AC, $AE, $AF, $B0, $B2, $B3 ; $D0
        .byte $B5, $B6, $B8, $B9, $BA, $BC, $BD, $BF, $C0, $C2, $C3, $C4, $C6, $C7, $C9, $CA, $CC, $CD, $CE, $D0
        .byte $97, $98, $9A, $9B, $9D, $9E, $A0, $A1, $A2, $A4, $A5, $A7, $A8, $AA, $AB, $AC, $AE, $B0, $B1, $B2, $B4 ; $D1
        .byte $B5, $B7, $B8, $BA, $BB, $BC, $BE, $BF, $C1, $C3, $C4, $C5, $C6, $C8, $CA, $CB, $CD, $CE, $CF, $D1
        .byte $97, $98, $9A, $9C, $9D, $9E, $A0, $A1, $A3, $A5, $A6, $A7, $A9, $AA, $AC, $AD, $AF, $B0, $B1, $B3, $B5 ; $D2
        .byte $B6, $B7, $B9, $BA, $BC, $BD, $BF, $C0, $C1, $C3, $C5, $C6, $C7, $C9, $CA, $CC, $CE, $CF, $D0, $D2
        .byte $97, $99, $9B, $9C, $9D, $9F, $A1, $A2, $A3, $A5, $A6, $A8, $A9, $AB, $AC, $AE, $AF, $B1, $B2, $B3, $B5 ; $D3
        .byte $B7, $B8, $BA, $BB, $BC, $BE, $C0, $C1, $C2, $C4, $C6, $C7, $C8, $CA, $CB, $CD, $CF, $D0, $D1, $D3
        .byte $98, $99, $9B, $9C, $9E, $9F, $A1, $A2, $A4, $A6, $A7, $A8, $AA, $AB, $AD, $AE, $B0, $B1, $B3, $B4, $B6 ; $D4
        .byte $B7, $B9, $BB, $BC, $BD, $BF, $C0, $C2, $C3, $C5, $C6, $C8, $C9, $CB, $CC, $CE, $D0, $D1, $D2, $D4
        .byte $98, $99, $9B, $9D, $9E, $9F, $A1, $A3, $A4, $A6, $A7, $A9, $AA, $AC, $AD, $AF, $B1, $B2, $B3, $B5, $B7 ; $D5
        .byte $B8, $B9, $BB, $BD, $BE, $BF, $C1, $C3, $C4, $C6, $C7, $C9, $CA, $CC, $CD, $CF, $D1, $D2, $D3, $D5
        .byte $98, $9A, $9C, $9D, $9E, $A0, $A2, $A3, $A4, $A6, $A8, $A9, $AB, $AD, $AE, $AF, $B1, $B3, $B4, $B5, $B7 ; $D6
        .byte $B9, $BA, $BC, $BD, $BF, $C0, $C2, $C3, $C5, $C7, $C8, $C9, $CB, $CD, $CE, $CF, $D1, $D3, $D4, $D6
        .byte $99, $9A, $9C, $9D, $9F, $A0, $A2, $A4, $A5, $A7, $A8, $AA, $AB, $AD, $AE, $B0, $B2, $B3, $B5, $B6, $B8 ; $D7
        .byte $B9, $BB, $BD, $BE, $BF, $C1, $C3, $C4, $C6, $C8, $C9, $CA, $CC, $CE, $CF, $D0, $D2, $D4, $D5, $D7
        .byte $99, $9A, $9C, $9E, $9F, $A1, $A3, $A4, $A5, $A7, $A9, $AA, $AC, $AE, $AF, $B0, $B2, $B4, $B5, $B7, $B9 ; $D8
        .byte $BA, $BB, $BD, $BF, $C0, $C2, $C4, $C5, $C6, $C8, $CA, $CB, $CD, $CF, $D0, $D1, $D3, $D5, $D6, $D8
        .byte $99, $9B, $9D, $9E, $9F, $A1, $A3, $A4, $A6, $A8, $A9, $AB, $AC, $AE, $AF, $B1, $B3, $B4, $B6, $B7, $B9 ; $D9
        .byte $BB, $BC, $BE, $BF, $C1, $C2, $C4, $C6, $C7, $C9, $CB, $CC, $CD, $CF, $D1, $D2, $D4, $D6, $D7, $D9
        .byte $9A, $9B, $9D, $9E, $A0, $A1, $A3, $A5, $A6, $A8, $AA, $AB, $AD, $AF, $B0, $B1, $B4, $B5, $B6, $B8, $BA ; $DA
        .byte $BB, $BD, $BF, $C0, $C2, $C3, $C5, $C7, $C8, $CA, $CB, $CD, $CE, $D0, $D2, $D3, $D5, $D7, $D8, $DA
        .byte $9A, $9B, $9D, $9F, $A0, $A2, $A4, $A5, $A7, $A9, $AA, $AC, $AD, $AF, $B1, $B2, $B4, $B6, $B7, $B8, $BB ; $DB
        .byte $BC, $BD, $BF, $C1, $C2, $C4, $C6, $C7, $C9, $CB, $CC, $CE, $CF, $D1, $D3, $D4, $D6, $D8, $D9, $DB
        .byte $9A, $9C, $9E, $9F, $A1, $A2, $A4, $A6, $A7, $A9, $AB, $AC, $AE, $B0, $B1, $B3, $B5, $B6, $B8, $B9, $BB ; $DC
        .byte $BD, $BE, $C0, $C2, $C3, $C5, $C7, $C8, $CA, $CC, $CD, $CF, $D0, $D2, $D4, $D5, $D7, $D9, $DA, $DC
        .byte $9A, $9C, $9E, $9F, $A1, $A2, $A5, $A6, $A7, $AA, $AB, $AD, $AE, $B0, $B2, $B3, $B5, $B7, $B8, $BA, $BC ; $DD
        .byte $BD, $BF, $C1, $C2, $C4, $C5, $C7, $C9, $CA, $CD, $CE, $CF, $D1, $D3, $D5, $D6, $D8, $DA, $DB, $DD
        .byte $9B, $9C, $9E, $A0, $A1, $A3, $A5, $A6, $A8, $AA, $AC, $AD, $AF, $B1, $B2, $B4, $B6, $B7, $B9, $BA, $BC ; $DE
        .byte $BE, $BF, $C2, $C3, $C5, $C6, $C8, $CA, $CB, $CD, $CF, $D0, $D2, $D4, $D5, $D7, $D9, $DB, $DC, $DE
        .byte $9B, $9C, $9F, $A0, $A2, $A3, $A5, $A7, $A8, $AB, $AC, $AE, $AF, $B1, $B3, $B4, $B6, $B8, $B9, $BB, $BD ; $DF
        .byte $BF, $C0, $C2, $C4, $C5, $C7, $C9, $CA, $CC, $CE, $D0, $D1, $D3, $D5, $D6, $D8, $DA, $DC, $DD, $DF
        .byte $9B, $9D, $9F, $A1, $A2, $A4, $A6, $A7, $A9, $AB, $AD, $AE, $B0, $B2, $B3, $B5, $B7, $B9, $BA, $BC, $BE ; $E0
        .byte $BF, $C1, $C3, $C5, $C6, $C8, $CA, $CB, $CD, $CF, $D1, $D2, $D4, $D6, $D7, $D9, $DB, $DD, $DE, $E0
        .byte $9C, $9D, $9F, $A1, $A2, $A4, $A6, $A8, $A9, $AB, $AD, $AE, $B0, $B2, $B4, $B5, $B8, $B9, $BB, $BC, $BE ; $E1
        .byte $C0, $C1, $C4, $C5, $C7, $C8, $CB, $CC, $CE, $D0, $D1, $D3, $D4, $D7, $D8, $DA, $DC, $DD, $DF, $E1
        .byte $9C, $9D, $A0, $A1, $A3, $A4, $A7, $A8, $AA, $AC, $AD, $AF, $B1, $B3, $B4, $B6, $B8, $BA, $BB, $BD, $BF ; $E2
        .byte $C1, $C2, $C4, $C6, $C7, $C9, $CB, $CD, $CE, $D1, $D2, $D4, $D5, $D8, $D9, $DB, $DD, $DE, $E0, $E2
        .byte $9C, $9E, $A0, $A2, $A3, $A5, $A7, $A8, $AA, $AC, $AE, $AF, $B1, $B3, $B5, $B6, $B9, $BA, $BC, $BD, $C0 ; $E3
        .byte $C1, $C3, $C5, $C7, $C8, $CA, $CC, $CE, $CF, $D1, $D3, $D5, $D6, $D8, $DA, $DC, $DE, $DF, $E1, $E3
        .byte $9C, $9E, $A0, $A2, $A3, $A5, $A7, $A9, $AA, $AD, $AE, $B0, $B2, $B4, $B5, $B7, $B9, $BB, $BC, $BE, $C0 ; $E4
        .byte $C2, $C3, $C6, $C7, $C9, $CB, $CD, $CE, $D0, $D2, $D4, $D5, $D7, $D9, $DB, $DC, $DF, $E0, $E2, $E4
        .byte $9D, $9E, $A1, $A2, $A4, $A5, $A8, $A9, $AB, $AD, $AF, $B0, $B2, $B4, $B6, $B8, $BA, $BB, $BD, $BF, $C1 ; $E5
        .byte $C3, $C4, $C7, $C8, $CA, $CB, $CE, $CF, $D1, $D3, $D5, $D6, $D8, $DA, $DC, $DD, $E0, $E1, $E3, $E5
        .byte $9D, $9F, $A1, $A3, $A4, $A6, $A8, $AA, $AB, $AE, $AF, $B1, $B3, $B5, $B6, $B8, $BA, $BC, $BE, $BF, $C2 ; $E6
        .byte $C3, $C5, $C7, $C9, $CA, $CC, $CE, $D0, $D2, $D4, $D6, $D7, $D9, $DB, $DD, $DE, $E1, $E2, $E4, $E6
        .byte $9D, $9F, $A1, $A3, $A5, $A6, $A9, $AA, $AC, $AE, $B0, $B1, $B3, $B5, $B7, $B9, $BB, $BD, $BE, $C0, $C2 ; $E7
        .byte $C4, $C6, $C8, $CA, $CB, $CD, $CF, $D1, $D2, $D5, $D6, $D8, $DA, $DC, $DE, $DF, $E2, $E3, $E5, $E7
        .byte $9E, $9F, $A2, $A3, $A5, $A7, $A9, $AB, $AC, $AF, $B0, $B2, $B4, $B6, $B8, $B9, $BC, $BD, $BF, $C1, $C3 ; $E8
        .byte $C5, $C6, $C9, $CA, $CC, $CE, $D0, $D2, $D3, $D6, $D7, $D9, $DB, $DD, $DF, $E0, $E3, $E4, $E6, $E8
        .byte $9E, $9F, $A2, $A4, $A5, $A7, $A9, $AB, $AD, $AF, $B1, $B2, $B4, $B6, $B8, $BA, $BC, $BE, $BF, $C1, $C4 ; $E9
        .byte $C5, $C7, $C9, $CB, $CD, $CE, $D1, $D2, $D4, $D6, $D8, $DA, $DB, $DE, $DF, $E1, $E4, $E5, $E7, $E9
        .byte $9E, $A0, $A2, $A4, $A6, $A7, $AA, $AB, $AD, $B0, $B1, $B3, $B5, $B7, $B9, $BA, $BD, $BE, $C0, $C2, $C4 ; $EA
        .byte $C6, $C8, $CA, $CC, $CD, $CF, $D1, $D3, $D5, $D7, $D9, $DB, $DC, $DF, $E0, $E2, $E5, $E6, $E8, $EA
        .byte $9E, $A0, $A3, $A4, $A6, $A8, $AA, $AC, $AD, $B0, $B2, $B3, $B5, $B8, $B9, $BB, $BD, $BF, $C1, $C2, $C5 ; $EB
        .byte $C7, $C8, $CB, $CC, $CE, $D0, $D2, $D4, $D6, $D8, $DA, $DB, $DD, $E0, $E1, $E3, $E5, $E7, $E9, $EB
        .byte $9F, $A0, $A3, $A5, $A6, $A8, $AB, $AC, $AE, $B0, $B2, $B4, $B6, $B8, $BA, $BB, $BE, $C0, $C1, $C3, $C6 ; $EC
        .byte $C7, $C9, $CB, $CD, $CF, $D1, $D3, $D5, $D6, $D9, $DB, $DC, $DE, $E1, $E2, $E4, $E6, $E8, $EA, $EC
        .byte $9F, $A1, $A3, $A5, $A7, $A8, $AB, $AD, $AE, $B1, $B3, $B4, $B6, $B9, $BA, $BC, $BF, $C0, $C2, $C4, $C6 ; $ED
        .byte $C8, $CA, $CC, $CE, $D0, $D1, $D4, $D6, $D7, $DA, $DB, $DD, $DF, $E1, $E3, $E5, $E7, $E9, $EB, $ED
        .byte $9F, $A1, $A4, $A5, $A7, $A9, $AB, $AD, $AF, $B1, $B3, $B5, $B7, $B9, $BB, $BD, $BF, $C1, $C3, $C4, $C7 ; $EE
        .byte $C9, $CA, $CD, $CF, $D0, $D2, $D5, $D6, $D8, $DB, $DC, $DE, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE
        .byte $A0, $A1, $A4, $A6, $A7, $A9, $AC, $AD, $AF, $B2, $B4, $B5, $B7, $BA, $BB, $BD, $C0, $C1, $C3, $C5, $C7 ; $EF
        .byte $C9, $CB, $CE, $CF, $D1, $D3, $D5, $D7, $D9, $DB, $DD, $DF, $E1, $E3, $E5, $E7, $E9, $EB, $ED, $EF
        .byte $A0, $A2, $A4, $A6, $A8, $AA, $AC, $AE, $B0, $B2, $B4, $B6, $B8, $BA, $BC, $BE, $C0, $C2, $C4, $C6, $C8 ; $F0
        .byte $CA, $CC, $CE, $D0, $D2, $D4, $D6, $D8, $DA, $DC, $DE, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0
        .byte $A0, $A2, $A5, $A6, $A8, $AA, $AD, $AE, $B0, $B3, $B4, $B6, $B8, $BB, $BC, $BE, $C1, $C3, $C4, $C6, $C9 ; $F1
        .byte $CB, $CC, $CF, $D1, $D2, $D4, $D7, $D9, $DA, $DD, $DF, $E1, $E2, $E5, $E7, $E9, $EB, $ED, $EF, $F1
        .byte $A0, $A2, $A5, $A7, $A8, $AA, $AD, $AF, $B0, $B3, $B5, $B7, $B9, $BB, $BD, $BF, $C1, $C3, $C5, $C7, $C9 ; $F2
        .byte $CB, $CD, $D0, $D1, $D3, $D5, $D8, $D9, $DB, $DE, $E0, $E1, $E3, $E6, $E8, $E9, $EC, $EE, $F0, $F2
        .byte $A1, $A3, $A5, $A7, $A9, $AB, $AD, $AF, $B1, $B4, $B5, $B7, $B9, $BC, $BD, $BF, $C2, $C4, $C6, $C7, $CA ; $F3
        .byte $CC, $CE, $D0, $D2, $D4, $D6, $D8, $DA, $DC, $DF, $E1, $E2, $E4, $E7, $E9, $EA, $ED, $EF, $F1, $F3
        .byte $A1, $A3, $A6, $A7, $A9, $AB, $AE, $B0, $B1, $B4, $B6, $B8, $BA, $BC, $BE, $C0, $C3, $C4, $C6, $C8, $CB ; $F4
        .byte $CD, $CE, $D1, $D3, $D5, $D7, $D9, $DB, $DD, $E0, $E1, $E3, $E5, $E8, $EA, $EB, $EE, $F0, $F2, $F4
        .byte $A1, $A3, $A6, $A8, $AA, $AB, $AE, $B0, $B2, $B5, $B6, $B8, $BA, $BD, $BF, $C0, $C3, $C5, $C7, $C9, $CB ; $F5
        .byte $CD, $CF, $D2, $D4, $D5, $D7, $DA, $DC, $DE, $E0, $E2, $E4, $E6, $E9, $EA, $EC, $EF, $F1, $F3, $F5
        .byte $A2, $A3, $A6, $A8, $AA, $AC, $AF, $B0, $B2, $B5, $B7, $B9, $BB, $BD, $BF, $C1, $C4, $C6, $C7, $C9, $CC ; $F6
        .byte $CE, $D0, $D2, $D4, $D6, $D8, $DB, $DD, $DE, $E1, $E3, $E5, $E7, $EA, $EB, $ED, $F0, $F2, $F4, $F6
        .byte $A2, $A4, $A7, $A8, $AA, $AC, $AF, $B1, $B3, $B5, $B7, $B9, $BB, $BE, $C0, $C2, $C4, $C6, $C8, $CA, $CD ; $F7
        .byte $CF, $D0, $D3, $D5, $D7, $D9, $DC, $DD, $DF, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F1, $F3, $F5, $F7
        .byte $A2, $A4, $A7, $A9, $AB, $AD, $AF, $B1, $B3, $B6, $B8, $BA, $BC, $BE, $C0, $C2, $C5, $C7, $C9, $CB, $CD ; $F8
        .byte $CF, $D1, $D4, $D6, $D8, $DA, $DC, $DE, $E0, $E3, $E5, $E7, $E9, $EB, $ED, $EF, $F2, $F4, $F6, $F8
        .byte $A2, $A4, $A7, $A9, $AB, $AD, $B0, $B2, $B3, $B6, $B8, $BA, $BC, $BF, $C1, $C3, $C5, $C7, $C9, $CB, $CE ; $F9
        .byte $D0, $D2, $D5, $D6, $D8, $DA, $DD, $DF, $E1, $E4, $E6, $E7, $E9, $EC, $EE, $F0, $F3, $F5, $F7, $F9
        .byte $A3, $A5, $A8, $A9, $AB, $AD, $B0, $B2, $B4, $B7, $B9, $BB, $BD, $BF, $C1, $C3, $C6, $C8, $CA, $CC, $CF ; $FA
        .byte $D1, $D2, $D5, $D7, $D9, $DB, $DE, $E0, $E2, $E5, $E6, $E8, $EA, $ED, $EF, $F1, $F4, $F6, $F8, $FA
        .byte $A3, $A5, $A8, $AA, $AC, $AE, $B1, $B2, $B4, $B7, $B9, $BB, $BD, $C0, $C2, $C4, $C7, $C9, $CA, $CC, $CF ; $FB
        .byte $D1, $D3, $D6, $D8, $DA, $DC, $DF, $E1, $E2, $E5, $E7, $E9, $EB, $EE, $F0, $F2, $F5, $F7, $F9, $FB
        .byte $A3, $A5, $A8, $AA, $AC, $AE, $B1, $B3, $B5, $B8, $BA, $BC, $BE, $C0, $C2, $C4, $C7, $C9, $CB, $CD, $D0 ; $FC
        .byte $D2, $D4, $D7, $D9, $DB, $DD, $DF, $E1, $E3, $E6, $E8, $EA, $EC, $EF, $F1, $F3, $F6, $F8, $FA, $FC
        .byte $A4, $A6, $A9, $AA, $AC, $AE, $B1, $B3, $B5, $B8, $BA, $BC, $BE, $C1, $C3, $C5, $C8, $CA, $CC, $CE, $D1 ; $FD
        .byte $D3, $D4, $D7, $D9, $DB, $DD, $E0, $E2, $E4, $E7, $E9, $EB, $ED, $F0, $F2, $F4, $F7, $F9, $FB, $FD
        .byte $A4, $A6, $A9, $AB, $AD, $AF, $B2, $B4, $B6, $B9, $BB, $BD, $BF, $C1, $C3, $C5, $C8, $CA, $CC, $CE, $D1 ; $FE
        .byte $D3, $D5, $D8, $DA, $DC, $DE, $E1, $E3, $E5, $E8, $EA, $EC, $EE, $F1, $F3, $F5, $F8, $FA, $FC, $FE
        .byte $A4, $A6, $A9, $AB, $AD, $AF, $B2, $B4, $B6, $B9, $BB, $BD, $BF, $C2, $C4, $C6, $C9, $CB, $CD, $CF, $D2 ; $FF
        .byte $D4, $D6, $D9, $DB, $DD, $DF, $E2, $E4, $E6, $E9, $EB, $ED, $EF, $F2, $F4, $F6, $F9, $FB, $FD, $FF

        ; 98/A900

    .endsection Data988000Section


    .section Data98AAA1Section

      .al
      .xl

      aUnknown98AAA1 ; 98/AAA1

        ; Read by rsBattleSceneCheckNoForeground.

        .byte $09, $0B, $0C, $0F, $10, $11, $12, $13, $3A, $3B, $3C, $3D, $3E, $3F, $40, $41
        .byte $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F, $50, $51
        .byte $52, $53, $54, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $60, $61, $62, $63, $64
        .byte $65, $66, $FF

        ; 98/AAD4

      aUnknown98AAD4 ; 98/AAD4

        ; Read by rsUnknown95DED5.

        .word $03F8, $02F8, $01F8, $01F8, $02F8, $00F8, $00F8, $01F8
        .word $01F8, $00F8, $FFF8, $00F8, $00F8, $FFF8, $FFF8, $FEF8
        .word $FEF9, $FDF9, $FCFA, $FCFB, $FDFC, $FCFD, $FDFE, $FEFF
        .word $FEFF, $FEFF, $FE00, $FEFF, $FE00, $FE00, $FE00, $FE01
        .word $FE00, $FE01, $FE01, $FE01, $FE02, $FE02, $FF03, $FF03
        .word $FF04, $0004, $0005, $0105, $0105, $0105, $0106, $0106
        .word $0106, $0206, $0206, $0206, $0206, $0206, $0206, $0206
        .word $0306, $0206, $0306, $0306, $0306, $0306, $0306, $0306
        .word $0306, $0306, $0306, $8080

        ; 98/AB5C

      aUnknown98AB5C ; 98/AB5C

        ; Read by rsUnknown95DF76.

        .word $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8
        .word $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8
        .word $8082, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8
        .word $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8, $FCF8
        .word $FCF8, $8081, $8084, $04F8, $04F8, $04F8, $04F8, $04F8
        .word $04F8, $04F8, $04F8, $04F8, $04F8, $04F8, $04F8, $04F8
        .word $04F8, $04F8, $04F8, $8083, $04F8, $04F8, $04F8, $04F8
        .word $04F8, $04F8, $04F8, $04F8, $04F8, $04F8, $04F8, $04F8
        .word $04F8, $04F8, $04F8, $04F8, $04F8, $04F8, $04F8, $04F8
        .word $8085, $04F8, $04F8, $04F8, $04F8, $8080, $F1D0, $00E3

        ; 98/ABFC

      aUnknown98ABFC ; 98/ABFC

        ; Read by rlUnknown96957D.

        .word $E0E0, $E0E0, $E0E0, $E1E1, $E1E1, $E1E1, $E2E2, $E2E2
        .word $E2E2, $E3E3, $E3E3, $E3E3, $E4E4, $E4E4, $E4E4, $E5E5
        .word $E5E5, $E5E5, $E6E6, $E6E6, $E6E6, $E7E7, $E7E7, $E7E7
        .word $E8E8, $E8E8, $E8E8, $E9E9, $E9E9, $E9E9, $EAEA, $EAEA
        .word $EAEA, $EBEB, $EBEB, $EBEB, $EBEB, $ECEC, $ECEC, $ECEC

        ; 98/AC4C

      aUnknown98AC4C ; 98/AC4C

        ; Read by rlUnknown9695AE.

        .byte $E0, $E0, $E0, $E0, $E1, $E1, $E1, $E2, $E2, $E2, $E2, $E3, $E3, $E3, $E4, $E4
        .byte $E4, $E4, $E5, $E5, $E5, $E6, $E6, $E6, $E6, $E7, $E7, $E7, $E8, $E8, $E8, $E8
        .byte $E9, $E9, $E9, $EA, $EA, $EA, $EA, $EB, $FF, $FF, $00, $80, $00, $40, $00, $20
        .byte $00, $10, $00, $08, $00, $04, $00, $02, $00, $01

        ; 98/AC86

      aUnknown98AC86 ; 98/AC86

        ; Read by rsUnknown959895.

        .word $0A62, $4EC5, $F67E, $C90A, $7E4E, $0AAA, $4EE7, $EA7E
        .word $EF0A, $7E4E, $0AB6, $4EF1, $447E, $250A, $7E4F, $0AD8
        .word $4F29, $8C7E, $470A, $7E4F, $0ACC, $4F4F, $987E, $510A
        .word $7E4F

        ; 98/ACB8

      aUnknown98ACB8 ; 98/ACB8

        ; Read by rlUnknown959742.

        .word $2123, $1A1E, $0F15, $0008

        ; 98/ACC0

    .endsection Data98AAA1Section


    .section Data98AFFDSection

      .al
      .xl

      aUnknown98AFFD ; 98/AFFD

        ; Read by rlUnknown95B8B0.

        .word $0002, $1AE8, $0008, $1AE8, $000B, $1AE8, $0015, $14E8
        .word $0018, $14E8, $001A, $17E8, $001B, $17E8, $001C, $17E8
        .word $0024, $17E8, $0029, $12E8, $002A, $12E8, $0043, $29F3
        .word $0044, $29F3, $0045, $29F3, $0046, $29F3, $FFFF, $0003
        .word $1AE8, $0008, $1AE8, $000E, $1AE8, $001A, $04E2, $001B
        .word $04E2, $001C, $04E2, $0023, $02E2, $0026, $06E0, $0027
        .word $06E0, $0028, $06E0, $0029, $06E0, $002B, $06E0, $FFFF
        .word $0000, $30E8, $0001, $30E8, $0006, $30E8, $0007, $30E8
        .word $0008, $30E8, $0009, $30E8, $000A, $30E8, $000F, $32E8
        .word $0010, $32E8, $0011, $32E8, $0012, $35E8, $0013, $35E8
        .word $0014, $35E8, $001A, $1AE8, $001B, $1AE8, $001C, $1AE8
        .word $0022, $1FE8, $FFFF

        ; 98/B0B3

      aUnknown98B0B3 ; 98/B0B3

        ; Read by rsUnknown96DACB.

        .word $0000, $0400, $0800, $0C00, $1000, $1400, $1800, $1C00
        .word $2000, $2400, $2800, $2C00, $3000, $3400, $3800, $3C00
        .word $4000, $4400, $4800, $4C00, $5000, $5400, $5800, $5C00
        .word $6000, $6400, $6800, $6C00, $7000, $7400, $7800, $7C00

        ; 98/B0F3

      aUnknown98B0F3 ; 98/B0F3

        ; Read by rsUnknown96DACB.

        .word $0000, $0020, $0040, $0060, $0080, $00A0, $00C0, $00E0
        .word $0100, $0120, $0140, $0160, $0180, $01A0, $01C0, $01E0
        .word $0200, $0220, $0240, $0260, $0280, $02A0, $02C0, $02E0
        .word $0300, $0320, $0340, $0360, $0380, $03A0, $03C0, $03E0

        ; 98/B133

      aUnknown98B133 ; 98/B133

        ; Read by rsUnknown96DACB.

        .word $0000, $0001, $0002, $0003, $0004, $0005, $0006, $0007
        .word $0008, $0009, $000A, $000B, $000C, $000D, $000E, $000F
        .word $0010, $0011, $0012, $0013, $0014, $0015, $0016, $0017
        .word $0018, $0019, $001A, $001B, $001C, $001D, $001E, $001F

        ; 98/B173

      aUnknown98B173 ; 98/B173

        ; Read by rsUnknown96F915.

        .word $0010, $FFE0, $0010, $0010, $000C, $FFF4, $000C, $000C
        .word $0008, $FFF8, $0008, $0008, $0005, $FFFB, $0005, $0005
        .word $0003, $FFFD, $0003, $0003, $0000, $0080, $0001, $FFFF
        .word $0001, $0001, $0000, $0080, $0000, $0000, $0000, $0080
        .word $0000, $0000, $0000, $0080, $0000, $0000, $0000, $0080
        .word $0000, $0000, $0000, $0080, $0000, $0000, $0000, $0080
        .word $0000, $0000, $0000, $0080, $0000, $0000, $0000, $0080
        .word $0000, $0000, $0000, $0080, $0000, $0000, $0000, $0080
        .word $0000, $0000, $0000, $0080, $0000, $0000, $0000, $0080
        .word $0000, $0000, $0000, $0080, $0000, $0080, $0000, $0000
        .word $8080, $0201, $0202, $0203, $0204, $0205, $0206, $0207
        .word $0208, $0209, $020A, $040B, $040C, $040D, $FFFF

        ; 98/B231

    .endsection Data98AFFDSection


    .section Table98B231Section

      .al
      .xl

      aUnknown98B231 ; 98/B231

        ; Read by rsUnknown96F7EB.

        .word _B231_B24B - aUnknown98B231
        .word _B231_B257 - aUnknown98B231
        .word _B231_B263 - aUnknown98B231
        .word _B231_B26F - aUnknown98B231
        .word _B231_B27B - aUnknown98B231
        .word _B231_B28C - aUnknown98B231
        .word _B231_B298 - aUnknown98B231
        .word _B231_B2A9 - aUnknown98B231
        .word _B231_B2B5 - aUnknown98B231
        .word _B231_B2C6 - aUnknown98B231
        .word _B231_B2D7 - aUnknown98B231
        .word _B231_B2E8 - aUnknown98B231
        .word _B231_B2F4 - aUnknown98B231

      _B231_B24B ; 98/B24B
        .byte $02, $00, $00, $00, $F0, $7C, $36, $F8, $01, $F8, $7C, $36

      _B231_B257 ; 98/B257
        .byte $02, $00, $00, $00, $F0, $7B, $36, $F8, $01, $F8, $7B, $36

      _B231_B263 ; 98/B263
        .byte $02, $00, $F8, $01, $F8, $7C, $36, $00, $00, $F0, $7B, $36

      _B231_B26F ; 98/B26F
        .byte $02, $00, $00, $00, $F0, $7C, $36, $F8, $01, $E8, $7C, $36

      _B231_B27B ; 98/B27B
        .byte $03, $00, $00, $00, $F8, $7C, $36, $00, $00, $E0, $7C, $36, $F8, $01, $E8, $7C
        .byte $36

      _B231_B28C ; 98/B28C
        .byte $02, $00, $00, $00, $F8, $7B, $36, $00, $00, $E0, $7B, $36

      _B231_B298 ; 98/B298
        .byte $03, $00, $00, $00, $F8, $7C, $36, $F8, $01, $E0, $7C, $36, $00, $00, $E0, $7C
        .byte $36

      _B231_B2A9 ; 98/B2A9
        .byte $02, $00, $F8, $01, $F0, $7C, $36, $F8, $01, $E0, $7B, $36

      _B231_B2B5 ; 98/B2B5
        .byte $03, $00, $F8, $01, $F0, $7B, $36, $00, $00, $D8, $7C, $36, $F8, $01, $E0, $7C
        .byte $36

      _B231_B2C6 ; 98/B2C6
        .byte $03, $00, $F8, $01, $F0, $7C, $36, $F8, $01, $D0, $7C, $36, $00, $00, $D8, $7B
        .byte $36

      _B231_B2D7 ; 98/B2D7
        .byte $03, $00, $00, $00, $E8, $7C, $36, $00, $00, $D8, $7C, $36, $F8, $01, $D0, $7B
        .byte $36

      _B231_B2E8 ; 98/B2E8
        .byte $02, $00, $08, $00, $E8, $7B, $36, $00, $00, $D0, $7C, $36

      _B231_B2F4 ; 98/B2F4
        .byte $01, $00, $08, $00, $E8, $7C, $36, $0A, $00, $00, $00, $10, $7F, $BE, $00, $00
        .byte $08, $7C, $BE, $F8, $01, $08, $7B, $BE, $00, $00, $00, $7E, $BE, $F8, $01, $00
        .byte $7D, $BE, $00, $00, $E8, $7F, $3E, $00, $00, $F0, $7C, $3E, $F8, $01, $F0, $7B
        .byte $3E, $00, $00, $F8, $7E, $3E, $F8, $01, $F8, $7D, $3E, $0A, $00, $00, $00, $08
        .byte $7E, $BE, $F8, $01, $08, $7D, $BE, $00, $00, $00, $7C, $BE, $F8, $01, $00, $7B
        .byte $BE, $00, $00, $10, $7F, $BE, $00, $00, $F0, $7E, $3E, $F8, $01, $F0, $7D, $3E
        .byte $00, $00, $F8, $7C, $3E, $F8, $01, $F8, $7B, $3E, $00, $00, $E8, $7F, $3E, $07
        .byte $00, $FC, $01, $F4, $7C, $3E, $FC, $01, $EC, $7C, $3E, $FC, $01, $E4, $7B, $3E
        .byte $FC, $01, $FC, $7C, $3E, $FC, $01, $14, $7D, $3E, $FC, $01, $0C, $7C, $3E, $FC
        .byte $01, $04, $7C, $3E

        ; 98/B388

    .endsection Table98B231Section


    .section Data98B388Section

      .al
      .xl

      aUnknown98B388 ; 98/B388

        ; Read by rlUnknown969D01.

        .word $0000, $000A, $0015, $0020, $002A, $0035, $0040, $004A
        .word $0055, $0060, $006A, $0075, $0080, $008A, $0095, $00A0
        .word $00AA, $00B5, $00C0, $00CA, $00D5, $00E0, $00EA, $00F5
        .word $0100

        ; 98/B3BA

      aUnknown98B3BA ; 98/B3BA

        ; Read by rsUnknown959CF8.

        .word $5574, $55E0, $564C, $56B8, $5724, $5790, $57FC, $5868
        .word $58D4, $5940, $59AC, $5A18, $5A84, $5AF0, $5B5C, $5BC8
        .word $5C34, $5CA0, $5D0C, $5D78, $5DE4, $5E50, $5EBC, $5F28
        .word $5F94

        ; 98/B3EC

      aUnknown98B3EC ; 98/B3EC

        ; Read by rsUnknown959CF8.

        .word $B574, $B5E0, $B64C, $B6B8, $B724, $B790, $B7FC, $B868
        .word $B8D4, $B940, $B9AC, $BA18, <>aBattleAnimationSequencesWarMageSword, $BAF0, $BB5C, $BBC8
        .word $BC34, $BCA0, $BD0C, $BD78, $BDE4, $BE50, $BEBC, $BF28
        .word $BF94

        ; 98/B41E

    .endsection Data98B388Section


    .section Data998000Section

      .al
      .xl

      aUnknown998000 ; 99/8000

        ; 101 percentage-scaling pairs (0..100). Read by rlUnknown96C8A1.

        .word $0000, $FFFF
        .word $0002, $7F00
        .word $0005, $3233
        .word $0007, $2392
        .word $000A, $1899
        .word $000C, $1455
        .word $000F, $1011
        .word $0011, $0E0F
        .word $0014, $0BCC
        .word $0017, $0A21
        .word $0019, $093D
        .word $001C, $0824
        .word $001E, $0788
        .word $0021, $06C1
        .word $0023, $0650
        .word $0026, $05BC
        .word $0028, $0566
        .word $002B, $04F4
        .word $002E, $0490
        .word $0030, $0455
        .word $0033, $0405
        .word $0035, $03D4
        .word $0038, $0392
        .word $003A, $0369
        .word $003D, $0332
        .word $0040, $0300
        .word $0042, $02E0
        .word $0045, $02B5
        .word $0047, $029B
        .word $004A, $0275
        .word $004C, $025E
        .word $004F, $023D
        .word $0051, $0229
        .word $0054, $020C
        .word $0057, $01F1
        .word $0059, $01E0
        .word $005C, $01C8
        .word $005E, $01B9
        .word $0061, $01A3
        .word $0063, $0195
        .word $0066, $0182
        .word $0068, $0176
        .word $006B, $0164
        .word $006E, $0153
        .word $0070, $0149
        .word $0073, $0139
        .word $0075, $0130
        .word $0078, $0122
        .word $007A, $0119
        .word $007D, $010C
        .word $0080, $0100
        .word $0082, $00F8
        .word $0085, $00EC
        .word $0087, $00E5
        .word $008A, $00DA
        .word $008C, $00D4
        .word $008F, $00CA
        .word $0091, $00C3
        .word $0094, $00BA
        .word $0097, $00B2
        .word $0099, $00AC
        .word $009C, $00A4
        .word $009E, $009E
        .word $00A1, $0097
        .word $00A3, $0092
        .word $00A6, $008A
        .word $00A8, $0086
        .word $00AB, $007F
        .word $00AE, $0078
        .word $00B0, $0074
        .word $00B3, $006E
        .word $00B5, $006A
        .word $00B8, $0064
        .word $00BA, $0060
        .word $00BD, $005A
        .word $00C0, $0055
        .word $00C2, $0051
        .word $00C5, $004C
        .word $00C7, $0049
        .word $00CA, $0044
        .word $00CC, $0041
        .word $00CF, $003C
        .word $00D1, $0039
        .word $00D4, $0035
        .word $00D7, $0030
        .word $00D9, $002E
        .word $00DC, $0029
        .word $00DE, $0027
        .word $00E1, $0023
        .word $00E3, $0020
        .word $00E6, $001C
        .word $00E8, $001A
        .word $00EB, $0016
        .word $00EE, $0013
        .word $00F0, $0011
        .word $00F3, $000D
        .word $00F5, $000B
        .word $00F8, $0008
        .word $00FA, $0006
        .word $00FD, $0003
        .word $0100, $0000

        ; 99/8194

    .endsection Data998000Section


    .section Data9982E3Section

      .al
      .xl

      aUnknown9982E3 ; 99/82E3

        ; Read by rlUnknown9696AA.

        .word $0409, $0B04, $0404, $040C, $0F04, $0404, $0410, $1104
        .word $0404, $0412, $1304, $0404, $003A, $3B00, $0000, $003C
        .word $3D00, $0000, $0042, $4700, $0000, $004C, $5200, $0000
        .word $FF5B, $5C00, $0101, $025F, $6102, $00FF, $0262, $6302
        .word $00FF, $FF64, $6500, $00FF, $FFFF

        ; 99/832D

      aUnknown99832D ; 99/832D

        ; Read by rlUnknown96DC7C.

        .word $4109, $0B41, $3C3C, $420C, $0F42, $0202, $1210, $1112
        .word $0707, $0C12, $130C, $1111, $023E, $3F02, $0303, $0440
        .word $4104, $0505, $0642, $4306, $0707, $0844, $4508, $0909
        .word $0A46, $470A, $0B0B, $0C48, $490C, $0D0D, $0E4A, $4B0E
        .word $0F0F, $104C, $4D10, $1111, $124E, $4F12, $1313, $1450
        .word $5114, $1515, $1652, $5316, $1717, $1854, $5818, $1919
        .word $1A59, $5A1A, $1B1B, $455B, $5C1C, $1D1D, $1E5D, $5E1E
        .word $1F1F, $205F, $6020, $2121, $2261, $6246, $2323, $4763
        .word $6424, $4825, $2665, $6649, $2727, $FFFF

        ; 99/83B9

      aItemAnimationCategories ; 99/83B9

        ; Read by rlUnknown95A1ED. One byte per item ID plus 1 (entry 0 is for no
        ; item): the high nibble is the weapon category of the battle animation
        ; lookup (AnimCategory...), the low nibble is not read yet.

        .byte (AnimCategoryAny << 4) | 0  ; no item
        .byte (AnimCategorySword << 4) | 0  ; IronSword
        .byte (AnimCategorySword << 4) | 0  ; SteelSword
        .byte (AnimCategorySword << 4) | 0  ; SilverSword
        .byte (AnimCategorySword << 4) | 0  ; IronBlade
        .byte (AnimCategorySword << 4) | 0  ; SteelBlade
        .byte (AnimCategorySword << 4) | 0  ; SilverBlade
        .byte (AnimCategorySword << 4) | 0  ; MiracleSword
        .byte (AnimCategorySword << 4) | 0  ; ThiefSword
        .byte (AnimCategorySword << 4) | 0  ; BarrierBlade
        .byte (AnimCategorySword << 4) | 0  ; BerserkSword
        .byte (AnimCategorySword << 4) | 0  ; BraveSword
        .byte (AnimCategorySword << 4) | 0  ; SilenceSword
        .byte (AnimCategorySword << 4) | 0  ; SleepSword
        .byte (AnimCategorySword << 4) | 0  ; SlimSword
        .byte (AnimCategorySword << 4) | 0  ; Safeguard
        .byte (AnimCategorySword << 4) | 0  ; FireSword
        .byte (AnimCategorySword << 4) | 0  ; EarthSword
        .byte (AnimCategorySword << 4) | 0  ; ThunderSword
        .byte (AnimCategorySword << 4) | 0  ; WindSword
        .byte (AnimCategorySword << 4) | 0  ; LightBrand
        .byte (AnimCategorySword << 4) | 0  ; Mystletainn
        .byte (AnimCategorySword << 4) | 0  ; Tyrfing
        .byte (AnimCategorySword << 4) | 0  ; Balmung
        .byte (AnimCategorySword << 4) | 0  ; Armorslayer
        .byte (AnimCategorySword << 4) | 0  ; Wingclipper
        .byte (AnimCategorySword << 4) | 0  ; BrokenSwordA
        .byte (AnimCategorySword << 4) | 0  ; BrokenSwordB
        .byte (AnimCategorySword << 4) | 0  ; BrokenSwordC
        .byte (AnimCategoryLance << 4) | 2  ; IronLance
        .byte (AnimCategoryLance << 4) | 2  ; SteelLance
        .byte (AnimCategoryLance << 4) | 2  ; SilverLance
        .byte (AnimCategoryRangedLance << 4) | 2  ; Javelin
        .byte (AnimCategoryLance << 4) | 2  ; Ridersbane
        .byte (AnimCategoryLance << 4) | 2  ; BraveLance
        .byte (AnimCategoryLance << 4) | 2  ; SlimLance
        .byte (AnimCategoryLance << 4) | 2  ; Gungnir
        .byte (AnimCategoryLance << 4) | 2  ; GaeBolg
        .byte (AnimCategoryLance << 4) | 2  ; BrokenLanceA
        .byte (AnimCategoryLance << 4) | 2  ; BrokenLanceB
        .byte (AnimCategoryLance << 4) | 2  ; BrokenLanceC
        .byte (AnimCategoryAxe << 4) | 3  ; IronAxe
        .byte (AnimCategoryAxe << 4) | 3  ; SteelAxe
        .byte (AnimCategoryAxe << 4) | 3  ; SilverAxe
        .byte (AnimCategoryAxe << 4) | 3  ; BraveAxe
        .byte (AnimCategoryRangedAxe << 4) | 3  ; Helswath
        .byte (AnimCategoryRangedAxe << 4) | 3  ; HandAxe
        .byte (AnimCategoryAxe << 4) | 3  ; BrokenAxeA
        .byte (AnimCategoryAxe << 4) | 3  ; BrokenAxeB
        .byte (AnimCategoryAxe << 4) | 3  ; BrokenAxeC
        .byte (AnimCategoryBow << 4) | 4  ; IronBow
        .byte (AnimCategoryBow << 4) | 4  ; SteelBow
        .byte (AnimCategoryBow << 4) | 4  ; SilverBow
        .byte (AnimCategoryBow << 4) | 4  ; BraveBow
        .byte (AnimCategoryBow << 4) | 4  ; KillerBow
        .byte (AnimCategoryBow << 4) | 4  ; Yewfelle
        .byte (AnimCategoryBow << 4) | 4  ; BrokenBowA
        .byte (AnimCategoryBow << 4) | 4  ; BrokenBowB
        .byte (AnimCategoryBow << 4) | 4  ; BrokenBowC
        .byte (AnimCategoryBow << 4) | 4  ; Ballista
        .byte (AnimCategoryBow << 4) | 4  ; IronBallista
        .byte (AnimCategoryBow << 4) | 4  ; KillerBallista
        .byte (AnimCategoryBow << 4) | 4  ; GreatBallista
        .byte (AnimCategoryMagic << 4) | 5  ; Fire
        .byte (AnimCategoryMagic << 4) | 5  ; Elfire
        .byte (AnimCategoryMagic << 4) | 5  ; Bolganone
        .byte (AnimCategoryMagic << 4) | 5  ; Valflame
        .byte (AnimCategoryMagic << 4) | 5  ; Meteor
        .byte (AnimCategoryMagic << 4) | 5  ; Thunder
        .byte (AnimCategoryMagic << 4) | 5  ; Elthunder
        .byte (AnimCategoryMagic << 4) | 5  ; Thoron
        .byte (AnimCategoryMagic << 4) | 5  ; Mjolnir
        .byte (AnimCategoryMagic << 4) | 5  ; Bolting
        .byte (AnimCategoryMagic << 4) | 5  ; Wind
        .byte (AnimCategoryMagic << 4) | 5  ; Elwind
        .byte (AnimCategoryMagic << 4) | 5  ; Tornado
        .byte (AnimCategoryMagic << 4) | 5  ; Forseti
        .byte (AnimCategoryMagic << 4) | 5  ; Blizzard
        .byte (AnimCategoryMagic << 4) | 5  ; Light
        .byte (AnimCategoryMagic << 4) | 5  ; Nosferatu
        .byte (AnimCategoryMagic << 4) | 5  ; Aura
        .byte (AnimCategoryMagic << 4) | 5  ; Naga
        .byte (AnimCategoryMagic << 4) | 5  ; Jormungandr
        .byte (AnimCategoryMagic << 4) | 5  ; Fenrir
        .byte (AnimCategoryMagic << 4) | 5  ; Hel
        .byte (AnimCategoryMagic << 4) | 5  ; Loptous
        .byte (AnimCategoryMagic << 4) | 5  ; BrokenFireTomeA
        .byte (AnimCategoryMagic << 4) | 5  ; BrokenFireTomeB
        .byte (AnimCategoryMagic << 4) | 5  ; BrokenFireTomeC
        .byte (AnimCategoryStaff << 4) | 6  ; HealStaff
        .byte (AnimCategoryStaff << 4) | 6  ; MendStaff
        .byte (AnimCategoryStaff << 4) | 6  ; RecoverStaff
        .byte (AnimCategoryStaff << 4) | 6  ; PhysicStaff
        .byte (AnimCategoryStaff << 4) | 6  ; Fortify
        .byte (AnimCategoryStaff << 4) | 6  ; ReturnStaff
        .byte (AnimCategoryStaff << 4) | 6  ; WarpStaff
        .byte (AnimCategoryStaff << 4) | 6  ; RescueStaff
        .byte (AnimCategoryStaff << 4) | 6  ; CharmStaff
        .byte (AnimCategoryStaff << 4) | 6  ; RestoreStaff
        .byte (AnimCategoryStaff << 4) | 6  ; ValkyrieStaff
        .byte (AnimCategoryStaff << 4) | 6  ; SilenceStaff
        .byte (AnimCategoryStaff << 4) | 6  ; SleepStaff
        .byte (AnimCategoryStaff << 4) | 6  ; BerserkStaff
        .byte (AnimCategoryStaff << 4) | 6  ; ThiefStaff
        .byte (AnimCategoryStaff << 4) | 6  ; BrokenStaffA
        .byte (AnimCategoryStaff << 4) | 6  ; BrokenStaffB
        .byte (AnimCategoryStaff << 4) | 6  ; BrokenStaffC
        .byte (AnimCategoryAny << 4) | 0  ; RenewalBand
        .byte (AnimCategoryAny << 4) | 0  ; ParagonBand
        .byte (AnimCategoryAny << 4) | 0  ; ThiefBand
        .byte (AnimCategoryAny << 4) | 0  ; MiracleBand
        .byte (AnimCategoryAny << 4) | 0  ; PursuitRing
        .byte (AnimCategoryAny << 4) | 0  ; RecoverRing
        .byte (AnimCategoryAny << 4) | 0  ; BargainBand
        .byte (AnimCategoryAny << 4) | 0  ; KnightRing
        .byte (AnimCategoryAny << 4) | 0  ; ReturnBand
        .byte (AnimCategoryAny << 4) | 0  ; SpeedRing
        .byte (AnimCategoryAny << 4) | 0  ; MagicRing
        .byte (AnimCategoryAny << 4) | 0  ; PowerRing
        .byte (AnimCategoryAny << 4) | 0  ; ShieldRing
        .byte (AnimCategoryAny << 4) | 0  ; BarrierRing
        .byte (AnimCategoryAny << 4) | 0  ; LegRing
        .byte (AnimCategoryAny << 4) | 0  ; SkillRing
        .byte (AnimCategorySword << 4) | 0  ; BrokenHolySword
        .byte (AnimCategoryLance << 4) | 2  ; BrokenHolyLance
        .byte (AnimCategoryBow << 4) | 4  ; BrokenHolyBow

        ; 99/8437

      aBattleSceneIntroSteps ; 99/8437

        ; Read by rlBattleSceneRunIntroStep: routines it calls.

        .long rlBattleSceneWaitForIntro
        .long rlUnknown96881F
        .long rlBattleSceneStartFadeIn

        ; 99/8440

      aBattleSceneEndSteps ; 99/8440

        ; Read by rlBattleSceneRunEndStep: routines it calls.

        .long rlBattleSceneStartFadeOut
        .long rlBattleSceneShowJuliusQuote
        .long rlBattleSceneEndStepJulius
        .long rlBattleSceneEndStepJulius2
        .long rlBattleSceneShowWaitForPress
        .long rlBattleSceneShowWeaponBroke
        .long rlBattleSceneShowItemObtained
        .long rlBattleSceneShowGoldStolen
        .long rlBattleSceneShowGoldObtained
        .long rlBattleSceneOpenMessageWindow
        .long rlBattleSceneEndStepType2Script2
        .long rlBattleSceneShowLevelUp
        .long rlBattleScenePrepareLevelUp
        .long rlBattleSceneShowLevelUpBanner
        .long rlBattleSceneShowExperience
        .long rlBattleSceneEndStepWaitScript2
        .long rlUnknown969CA1
        .long rlBattleSceneShowDeathQuote
        .long rlBattleSceneEndStepWaitScript
        .long rlBattleSceneEndStepType2Script
        .long rlBattleSceneShowBG3

        ; 99/847F

      aClassDefaultGenders ; 99/847F

        ; Read by rlBattleSceneGetGender: the gender a unit of this class gets in battle
        ; animations when its own is Genderless.

        .byte GenderMale   ; Cavalier
        .byte GenderMale   ; LanceKnight
        .byte GenderMale   ; BowKnight
        .byte GenderMale   ; AxeKnight
        .byte GenderMale   ; FreeKnight
        .byte GenderFemale ; Troubadour
        .byte GenderMale   ; KnightLord
        .byte GenderMale   ; DukeKnight
        .byte GenderMale   ; MasterKnight
        .byte GenderMale   ; Paladin
        .byte GenderFemale ; PaladinF
        .byte GenderMale   ; ArchKnight
        .byte GenderMale   ; Ranger
        .byte GenderMale   ; MageKnight
        .byte GenderMale   ; GreatKnight
        .byte GenderFemale ; PegasusRider
        .byte GenderFemale ; PegasusKnight
        .byte GenderFemale ; FalconKnight
        .byte GenderMale   ; Dragonrider
        .byte GenderMale   ; Dragonknight
        .byte GenderMale   ; Dragonmaster
        .byte GenderMale   ; Archer
        .byte GenderMale   ; Myrmidon
        .byte GenderMale   ; Swordmaster
        .byte GenderMale   ; Sniper
        .byte GenderMale   ; Hero
        .byte GenderMale   ; General
        .byte GenderMale   ; Emperor
        .byte GenderMale   ; Baron
        .byte GenderMale   ; Soldier
        .byte GenderMale   ; SpearSoldier
        .byte GenderMale   ; AxeSoldier
        .byte GenderMale   ; BowSoldier
        .byte GenderMale   ; SwordSoldier
        .byte GenderMale   ; LanceArmor
        .byte GenderMale   ; AxeArmor
        .byte GenderMale   ; BowArmor
        .byte GenderMale   ; SwordArmor
        .byte GenderMale   ; Barbarian
        .byte GenderMale   ; Fighter
        .byte GenderMale   ; Brigand
        .byte GenderMale   ; Warrior
        .byte GenderMale   ; Hunter
        .byte GenderMale   ; Pirate
        .byte GenderMale   ; JuniorLord
        .byte GenderMale   ; WarMage
        .byte GenderMale   ; Prince
        .byte GenderFemale ; Princess
        .byte GenderMale   ; WarMageF
        .byte GenderFemale ; Queen
        .byte GenderMale   ; Dancer
        .byte GenderFemale ; Priest
        .byte GenderMale   ; Mage
        .byte GenderMale   ; FireMage
        .byte GenderMale   ; ThunderMage
        .byte GenderMale   ; WindMage
        .byte GenderMale   ; HighPriest
        .byte GenderMale   ; Bishop
        .byte GenderMale   ; Sage
        .byte GenderMale   ; Bard
        .byte GenderMale   ; Priestess
        .byte GenderMale   ; DarkMage
        .byte GenderMale   ; DarkBishop
        .byte GenderMale   ; Thief
        .byte GenderMale   ; Rogue
        .byte GenderMale   ; Civilian
        .byte GenderMale   ; Child
        .byte GenderMale   ; Ballistician
        .byte GenderMale   ; IronBallistician
        .byte GenderMale   ; KillerBallistician
        .byte GenderMale   ; GreatBallistician

        ; 99/84C6

      aUnknown9984C6 ; 99/84C6

        ; Read by rlUnknown9686FC.

        .byte $4D, $0D, $00, $FF, $FF, $E4, $0C, $32, $02, $04, $00, $28, $F5, $4E, $7E, $5C
        .byte $00, $D8, $0D, $50, $02, $0C, $00, $28, $F7, $4E, $7E, $F7, $00, $18, $0E, $1E
        .byte $02, $0C, $00, $28, $F9, $4E, $7E, $F7, $00, $58, $0E, $1E, $02, $0C, $00, $28
        .byte $FF, $4E, $7E, $F7, $00, $98, $0E, $1E, $02, $0C, $00, $28, $FB, $4E, $7E, $F7
        .byte $00, $EE, $0D, $1E, $02, $0C, $00, $28, $FD, $4E, $7E, $F7, $00, $2E, $0E, $1E
        .byte $02, $0C, $00, $28, $03, $4F, $7E, $F7, $00, $6E, $0E, $1E, $02, $0C, $00, $28
        .byte $01, $4F, $7E, $F7, $00, $AE, $0E, $1E, $02, $0C, $00, $28

        ; 99/8532

      aUnknown998532 ; 99/8532

        ; Read by rlUnknown969037.

        .byte $01, $F8, $02, $F4, $03, $F2, $04, $F1, $05, $F0, $07, $EF, $09, $EF, $0B, $F0
        .byte $0C, $F1, $0D, $F3, $0E, $F5, $0E, $F7, $0E, $F9, $0E, $FB, $0D, $FD, $0C, $FE
        .byte $0A, $FF, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $82, $08
        .byte $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $08
        .byte $00, $08, $00, $08, $00, $08, $00, $08, $00, $08, $00, $81, $00, $08, $00, $81
        .byte $00, $08, $00, $80

        ; 99/8586

      aUnknown998586 ; 99/8586

        ; Read by rlUnknown9691C8.

        .byte $FC, $FC, $00, $F8, $F9, $01, $F5, $F7, $02, $F2, $F5, $03, $F1, $F3, $04, $F1
        .byte $F1, $05, $F1, $F0, $06, $F1, $F0, $07, $F1, $F1, $08, $F0, $F2, $09, $EE, $F3
        .byte $0A, $EF, $F4, $09, $F0, $F4, $08, $F1, $F3, $07, $ED, $F2, $09, $F0, $F1, $08
        .byte $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0
        .byte $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1
        .byte $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08
        .byte $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0
        .byte $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1
        .byte $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F1, $08, $F0, $F0, $08, $F0, $F0, $08
        .byte $F0, $EF, $08, $F0, $EF, $08, $F0, $EE, $08, $F0, $EE, $08, $81, $00, $08, $F0
        .byte $ED, $08, $81, $00, $08, $F0, $EC, $08, $80

        ; 99/862F

      aUnknown99862F ; 99/862F

        ; Read by rlUnknown9691C8.

        .word $0000, $0000, $0201, $0403, $0402, $0806, $0603, $0C09
        .word $0804, $100C, $0A05, $140F, $0C06, $1812, $0E07, $1C15
        .word $1008, $2018, $1209, $241B, $140A, $281E, $160B, $2C21
        .word $180C, $3024, $1A0D, $3427, $1C0E, $382A, $1E0F, $3C2D
        .word $2010, $4030, $2211, $4433, $2412, $4836, $2613, $4C39
        .word $2814, $503C

        ; 99/8683

      aUnknown998683 ; 99/8683

        ; Read by rlUnknown968F71.

        .word $4F05, $F57E, $7E4E, $A890, $0B00, $7E4F, $4EFB, $E87E
        .word $01A8, $4F07, $F77E, $7E4E, $B090, $0D02, $7E4F, $4EFD
        .word $E87E, $03B0, $4F09, $F97E, $7E4E, $B890, $1304, $7E4F
        .word $4F03, $E87E, $05B8, $4F0F, $FF7E, $7E4E, $C090, $1106
        .word $7E4F, $4F01, $E87E, $07C0, $0080

        ; 99/86CD

      aUnknown9986CD ; 99/86CD

        ; Read by rlUnknown969398.

        .byte $F5, $4E, $7E, $05, $4F, $7E, $5C, $00, $D8, $0D, $50, $FB, $4E, $7E, $0B, $4F
        .byte $7E, $F7, $00, $EE, $0D, $1E, $F7, $4E, $7E, $07, $4F, $7E, $F7, $00, $18, $0E
        .byte $1E, $FD, $4E, $7E, $0D, $4F, $7E, $F7, $00, $2E, $0E, $1E, $F9, $4E, $7E, $09
        .byte $4F, $7E, $F7, $00, $58, $0E, $1E, $03, $4F, $7E, $13, $4F, $7E, $F7, $00, $6E
        .byte $0E, $1E, $FF, $4E, $7E, $0F, $4F, $7E, $F7, $00, $98, $0E, $1E, $01, $4F, $7E
        .byte $11, $4F, $7E, $F7, $00, $AE, $0E, $1E

        ; 99/8725

    .endsection Data9982E3Section


    .section Data99892ASection

      .al
      .xl

      aUnknown99892A ; 99/892A

        ; Read by rlUnknown96F38F.

        .word $0380, $0380, $0280, $0280, $0180, $0180, $0080, $0080
        .word $0081, $0081, $0082, $0082, $FF85

        ; 99/8944

    .endsection Data99892ASection


    .section Data998944Section

      .al
      .xl

      aUnknown998944 ; 99/8944

        ; Read by rsUnknown959B84 and rsUnknown959BC1 (22 bytes per entry).

        .word $039C, $39D2, $3190, $2D6F, $294E, $252D, $1CC9, $0000, $18A8, $0003, $39D2
        .word $039C, $420F, $3DEE, $39CD, $35AC, $318B, $0C42, $0000, $1CE6, $0000, $420F
        .word $039C, $5310, $4ACE, $46AD, $428C, $3A4A, $04A7, $0000, $1D64, $0880, $4ACE
        .word $039C, $4DAF, $498E, $456D, $414C, $3D2B, $0866, $0000, $2CA7, $0401, $498E
        .word $03FF, $6B7B, $635A, $5AF7, $4ED7, $3E75, $08C8, $0000, $318B, $10E7, $5F7B
        .word $03FF, $21AF, $1D8E, $196D, $154C, $152B, $04A7, $0000, $04A7, $0021, $21AF
        .word $039C, $76D3, $72B2, $6E91, $6A70, $664F, $04A7, $0000, $2106, $0C42, $5A71
        .word $03FF, $19D4, $15B3, $1192, $0D71, $0950, $04A7, $0000, $0068, $0021, $1DF5
        .word $039C, $658C, $616B, $5D4A, $5929, $5909, $0445, $0000, $3863, $0400, $61AD
        .word $0400, $0400, $0800, $0800, $0C00, $0C00, $1000, $1000, $1400, $1400, $1800
        .word $1800, $1C00, $1C00, $2000, $2000, $2000, $2400, $2400, $2400, $2800, $2800
        .word $2800, $2C00, $2C00, $2C00, $3000, $3000, $3000, $3400, $3400, $3400, $3400
        .word $3800, $3800, $3800, $3800, $3C00, $3C00, $3C00, $3C00, $3C00, $3C00, $3800
        .word $3800, $3800, $3800, $3400, $3400, $3400, $3400, $3000, $3000, $3000, $2C00
        .word $2C00, $2C00, $2800, $2800, $2800, $2400, $2400, $2400, $2000, $2000, $2000
        .word $1C00, $1C00, $1800, $1800, $1400, $1400, $1000, $1000, $0C00, $0C00, $0800
        .word $0800, $0400, $0400, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0A10
        .word $708A, $8A0A, $0AD0, $008A, $AA10, $708A, $8AAA, $AAD0, $008A

      aUnknown998B0E ; 99/8B0E

        ; Read by rsUnknown95C0F3.

        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $01, $01
        .byte $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $01, $01, $01, $01, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $0F, $1D, $E5, $04, $1D, $E5, $04, $1E, $E5, $04, $1F, $E5, $04, $20, $E5, $04
        .byte $21, $E5, $04, $22, $E5, $04, $23, $E5, $04, $24, $E5, $04, $25, $E5, $04, $26
        .byte $E5, $04, $27, $E5, $04, $28, $E5, $04, $29, $E5, $04, $2A, $E5, $08, $2B, $E5
        .byte $04, $2A, $E5, $04, $29, $E5, $04, $28, $E5, $04, $27, $E5, $04, $26, $E5, $04
        .byte $25, $E5, $04, $24, $E5, $04, $23, $E5, $04, $22, $E5, $04, $21, $E5, $04, $20
        .byte $E5, $04, $1F, $E5, $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        .byte $FF, $FF, $FF, $FD, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        .byte $FF, $FF, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        .byte $FF, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $FF, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $FF, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $FF, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $FF, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $FF, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $FF, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $FE, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $FD, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $FC, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $FA, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $F8
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $F6, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $F4, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $F2, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $F0, $E0, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $EE, $E0, $E0, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $EC, $E0, $E0, $E0, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $EA, $E0, $E0, $E0, $E0, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E8, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E6, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $E4, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0, $E0
        .byte $E0, $E0, $E0, $E0, $E2, $00

        ; 99/8D84

    .endsection Data998944Section


    .section Data998DD8Section

      .al
      .xl

      aUnknown998DD8 ; 99/8DD8

        .byte $02, $02, $02, $02, $02, $03, $03, $03, $03, $05, $05, $05, $07, $07, $09, $09
        .byte $09, $09, $07, $07, $05, $05, $05, $03, $03, $03, $03, $02, $02, $02, $02, $02

      aUnknown998DF8 ; 99/8DF8

        ; Read by rlUnknown95A167 (2-byte ID + 1-byte index, $FFFF terminated).

        .word $0001
        .byte $01
        .word $0002
        .byte $02
        .word $0003
        .byte $03
        .word $0005
        .byte $01
        .word $0006
        .byte $00
        .word $0007
        .byte $03
        .word $0008
        .byte $03
        .word $0009
        .byte $02
        .word $000A
        .byte $04
        .word $000B
        .byte $00
        .word $000C
        .byte $02
        .word $000D
        .byte $02
        .word $000E
        .byte $01
        .word $000F
        .byte $02
        .word $0010
        .byte $05
        .word $0011
        .byte $06
        .word $0012
        .byte $02
        .word $0013
        .byte $07
        .word $0014
        .byte $03
        .word $0015
        .byte $05
        .word $0016
        .byte $03
        .word $0017
        .byte $02
        .word $0018
        .byte $02
        .word $0019
        .byte $01
        .word $001A
        .byte $07
        .word $001B
        .byte $07
        .word $001C
        .byte $07
        .word $001D
        .byte $00
        .word $001E
        .byte $00
        .word $001F
        .byte $01
        .word $0020
        .byte $00
        .word $0021
        .byte $00
        .word $0022
        .byte $01
        .word $0023
        .byte $00
        .word $0025
        .byte $02
        .word $0026
        .byte $03
        .word $027F
        .byte $03
        .word $0028
        .byte $00
        .word $0029
        .byte $07
        .word $002A
        .byte $07
        .word $002B
        .byte $05
        .word $002C
        .byte $00
        .word $002D
        .byte $03
        .word $002E
        .byte $00
        .word $002F
        .byte $07
        .word $0030
        .byte $00
        .word $0031
        .byte $00
        .word $0032
        .byte $07
        .word $0033
        .byte $02
        .word $0034
        .byte $02
        .word $0035
        .byte $03
        .word $0036
        .byte $02
        .word $0037
        .byte $01
        .word $0038
        .byte $05
        .word $0039
        .byte $09
        .word $003A
        .byte $07
        .word $003B
        .byte $08
        .word $003C
        .byte $03
        .word $003D
        .byte $05
        .word $003E
        .byte $03
        .word $003F
        .byte $02
        .word $0073
        .byte $09
        .word $008A
        .byte $09
        .word $00C2
        .byte $03
        .word $00C9
        .byte $03
        .word $00D5
        .byte $07
        .word $00EB
        .byte $05
        .word $0120
        .byte $05
        .word $0122
        .byte $04
        .word $0131
        .byte $05
        .word $0132
        .byte $05
        .word $0133
        .byte $05
        .word $0142
        .byte $05
        .word $0152
        .byte $05
        .word $0153
        .byte $05
        .word $0154
        .byte $05
        .word $017D
        .byte $07
        .word $018E
        .byte $04
        .word $018F
        .byte $05
        .word $01AA
        .byte $09
        .word $01B8
        .byte $00
        .word $01BC
        .byte $09
        .word $01BF
        .byte $07
        .word $01C6
        .byte $04
        .word $01D5
        .byte $05
        .word $01D6
        .byte $07
        .word $01D7
        .byte $00
        .word $01D8
        .byte $00
        .word $FFFF

        ; 99/8F02

    .endsection Data998DD8Section


    .section Data998F02Section

      .al
      .xl

      aUnknown998F02 ; 99/8F02

        ; Read by rsBattleSceneCheckListedWeapon.

        .byte $02, $04, $05, $14, $15, $16, $1E, $23, $24, $2A, $2C, $FF, $FF

        ; 99/8F0F

      aUnknown998F0F ; 99/8F0F

        ; Read by rlUnknown969F1C.

        .byte $02, $FF, $02, $FF, $FE, $00, $FE, $00, $00, $01, $00, $01, $00, $FF, $00, $FF
        .byte $02, $01, $FE, $FF, $FE, $FF, $02, $00, $FE, $01, $FE, $01, $01, $FF, $FF, $00
        .byte $00, $01, $00, $FF, $01, $01, $FF, $FF, $01, $00, $FF, $01, $01, $FF, $FF, $00
        .byte $00, $01, $00, $FF, $80, $80, $0F, $D4, $F8, $08, $D4, $F8, $08, $D6, $F8, $08
        .byte $D8, $F8, $08, $DA, $F8, $08, $DC, $F8, $08, $DE, $F8, $04, $E0, $F8, $08, $E2
        .byte $F8, $04, $E0, $F8, $08, $DE, $F8, $08, $DC, $F8, $08, $DA, $F8, $08, $D8, $F8
        .byte $08, $D6, $F8, $08, $D4, $F8, $00, $00, $04, $00, $03, $00, $02, $80, $01, $00
        .byte $01, $C0, $00, $80, $00, $60, $00

        ; 99/8F86

      aUnknown998F86 ; 99/8F86

        ; Read by rlUnknown958678.

        .byte $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $61, $62, $FF

        ; 99/8F91

      aUnknown998F91 ; 99/8F91

        ; Read by rlBattleSceneCheckBarehandedClass.

        .word $0005, $0008, $0009, $000A, $0011, $001B, $001C, $FFFF

        ; 99/8FA1

    .endsection Data998F02Section


    .section DataE00060Section

      .al
      .xl

      aUnknownE00060 ; E0/0060

        ; Read by rlUnknown9599E7.

        .word $4631, $318B, $7FFF, $1484, $4ACE, $1D64, $0CA0, $4ACE
        .word $0000, $3F80, $1CA2, $73FF, $0000, $35AC, $1508, $5F7B
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

        ; E0/00B0

      aUnknownE000B0 ; E0/00B0

        ; Read by rlUnknown9686FC, rlUnknown968982, rlUnknown968A57, rlBattleSceneShowLevelUpBanner.

        .byte $C4, $09, $85, $00, $F6, $7F, $1F, $00, $03, $00, $BF, $7F, $CE, $4A, $A4, $14
        .byte $FF, $7F, $00, $04, $D3, $57, $AA, $3E

        ; E0/00C8

      aUnknownE000C8 ; E0/00C8

        ; Read by rlUnknown95E9EF, rlUnknown968BC2.

        .byte $00, $00, $5F, $4B, $78, $32, $F3, $25, $00, $00, $27, $00, $9F, $57, $5F, $13
        .byte $8B, $2D

        ; E0/00DA

      aUnknownE000DA ; E0/00DA

        ; Read by rlUnknown9688BA.

        .word $2D8C, $7FFF, $0C41, $7FFF, $4651, $7FFF, $2129, $4E69
        .word $28C4, $1042, $10E4, $14E6, $2504, $1CE4, $14C4, $03FF
        .word $6B7B, $635A, $5AF7, $4ED7, $3E75, $08C8, $0000, $318B
        .word $10E7, $5F7B, $039C, $5310, $4ACE, $46AD, $428C, $3A4A
        .word $04A7, $0000, $1D64, $0880, $4ACE, $039C, $4DAF, $498E
        .word $456D, $414C, $3D2B, $0866, $0000, $2CA7, $0401, $498E
        .word $03FF, $21AF, $1D8E, $196D, $154C, $152B, $04A7, $0000
        .word $04A7, $0021, $21AF, $039C, $39D2, $3190, $2D6F, $294E
        .word $252D, $1CC9, $0000, $18A8, $0003, $39D2, $039C, $420F
        .word $3DEE, $39CD, $35AC, $318B, $0C42, $0000, $1CE6, $0000
        .word $420F

        ; E0/017C

      aUnknownE0017C ; E0/017C

        ; Read by rlUnknown95A167.

        .word $0CC7, $1D2E, $2170, $3CC1, $758A, $7B93, $00C6, $0231
        .word $03DE, $00E3, $01C3, $43D3, $0009, $0092, $015C, $1CE7
        .word $4210, $6F7B, $100A, $3938, $5E3F, $14A5, $2529, $39CE
        .word $00AA, $0157, $021F, $0108, $0231, $0336

        ; E0/01B8

    .endsection DataE00060Section


    .section DataE02667Section

      .al
      .xl

      aUnknownE02667 ; E0/2667

        ; Read by rlLoadTitleGraphics.

        .word $5000, $3C00, $3400, $2800, $2800, $2C00, $2000, $1800
        .word $1800, $1C00, $1400, $1000, $0400, $0800, $0800, $021F
        .word $1FFF, $7FFF, $7F15, $7E51, $7D71, $7F80, $7E4A, $7D47
        .word $7CE7, $7CA4, $7C20, $6C00, $5800, $4400, $4210, $021F
        .word $1FFF, $7FFF, $7F15, $7E51, $7D71, $7F80, $7E4A, $7D47
        .word $7CE7, $7CA4, $7C20, $6C00, $5800, $4400

        ; E0/26C3

      aUnknownE026C3 ; E0/26C3

        ; Read by rlLoadTitleGraphics.

        .word $42DC, $0C66, $7FDF, $479F, $371C, $2EDA, $1E99, $1E77
        .word $01B8, $0175, $0153, $00F0, $00EE, $110B, $0823

        ; E0/26E1

      aUnknownE026E1 ; E0/26E1

        ; Read by rlLoadTitleGraphics.

        .word $3678, $7FFF, $6316, $4E74, $4211, $3E10, $3DF0, $39EF
        .word $6271, $5E6F, $4DEA, $452C, $612A, $4927, $48A6

        ; E0/26FF

      aUnknownE026FF ; E0/26FF

        ; Read by rlLoadTitleGraphics.

        .word $0000, $1D2B, $2DCF, $3A54, $3A32, $6E00, $256C, $46B6
        .word $475C, $6F6F, $6EE0, $14C6, $6DC0, $54C0, $0C84

        ; E0/271D

      aUnknownE0271D ; E0/271D

        ; Read by rlLoadTitleGraphics.

        .word $0014, $2550, $0442, $7FFF, $373D, $0257, $01F8, $0173
        .word $00EE, $0069, $6316, $422C, $3A8A, $3942, $01C8

        ; E0/273B

      aUnknownE0273B ; E0/273B

        ; Read by rlUnknown9BF65C.

        .word $1084, $2108, $318C, $4265, $318C, $4210, $18C6, $4265
        .word $296B, $1084, $18C6, $4265, $18C6, $2108, $18C6

        ; E0/2759

      aUnknownE02759 ; E0/2759

        ; Read by rlLoadTitleGraphics.

        .word $14C7, $32FB, $0000, $1E99, $1A56, $11B8, $0D54, $0D32

        ; E0/2769

      aUnknownE02769 ; E0/2769

        ; Read by rlLoadTitleGraphics.

        .word $2E36, $7FFF, $56B3, $4A53, $4211, $31CF, $2D8D, $256C
        .word $5E50, $520C, $49C9, $5949, $4908, $34E7, $18A6

        ; E0/2787

      aUnknownE02787 ; E0/2787

        ; Read by rlLoadTitleIntroGraphics.

        .word $0000, $0421, $0842, $14A5, $18C6, $1CE7, $2108, $2529
        .word $294A, $2D6B, $35AD, $3DEF, $4A52, $56B5, $6739, $7E60
        .word $7E82, $7A84, $7AA5, $76C7, $76C9, $76EB, $730C, $730E
        .word $6F30, $6F52, $6F53, $73B7, $53BF, $7FFF

        ; E0/27C3

      aUnknownE027C3 ; E0/27C3

        ; Read by rlBattleSceneShowAstra.

        .word $7FFF, $43E0, $0360, $0240, $0120

        ; E0/27CD

      aUnknownE027CD ; E0/27CD

        ; Read by rlBattleSceneShowLuna.

        .word $7FFF, $7F57, $7E90, $7DE8, $7D20

        ; E0/27D7

      aUnknownE027D7 ; E0/27D7

        ; Read by rlBattleSceneShowSol.

        .word $03FF, $035F, $029F, $01DF, $013F

        ; E0/27E1

      aUnknownE027E1 ; E0/27E1

        ; Read by rlBattleSceneShowHoly.

        .word $7FFF, $5F7F, $42FF, $227F, $01FF

        ; E0/27EB

      aUnknownE027EB ; E0/27EB

        ; Read by rlBattleSceneShowDarkness.

        .word $7C1C, $7C19, $7C15, $7C12, $7C0F

        ; E0/27F5

      aUnknownE027F5 ; E0/27F5

        ; Read by rlBattleSceneShowPavise.

        .word $7FE0, $7F20, $7E80, $7E20, $7DA0

        ; E0/27FF

    .endsection DataE02667Section

