; The battle scenes of the attract mode (bank $8D data): aDemoBattlesPointerTable
; and for each battle its combatants and quotes, read by bank $97's battle scene
; code (the opening's battle scenes, rlUnknown97FDC1 and rlUnknown97FDC6).


    .section DemoBattlesSection

      .al
      .xl

      aDemoBattlesPointerTable ; 8D/8000

        .long aDemoBattle00, aDemoBattle00_UnitList
        .long aDemoBattle01, aDemoBattle01_UnitList
        .long aDemoBattle02, aDemoBattle02_UnitList
        .long aDemoBattle03, aDemoBattle03_UnitList
        .long aDemoBattle04, aDemoBattle04_UnitList
        .long aDemoBattle05, aDemoBattle05_UnitList
        .long aDemoBattle06, aDemoBattle06_UnitList
        .long aDemoBattle07, aDemoBattle07_UnitList
        .long aDemoBattle08, aDemoBattle08_UnitList
        .long aDemoBattle09, aDemoBattle09_UnitList
        .long aDemoBattle10, aDemoBattle10_UnitList
        .long aDemoBattle11, aDemoBattle11_UnitList
        .long aDemoBattle12, aDemoBattle12_UnitList
        .long aDemoBattle13, aDemoBattle13_UnitList
        .long aDemoBattle14, aDemoBattle14_UnitList
        .long aDemoBattle15, aDemoBattle15_UnitList
        .long aDemoBattle16, aDemoBattle16_UnitList
        .long aDemoBattle17, aDemoBattle17_UnitList
        .long aDemoBattle18, aDemoBattle18_UnitList
        .long aDemoBattle19, aDemoBattle19_UnitList
        .long aDemoBattle20, aDemoBattle20_UnitList
        .long aDemoBattle21, aDemoBattle21_UnitList
        .long aDemoBattle22, aDemoBattle22_UnitList
        .long aDemoBattle23, aDemoBattle23_UnitList
        .long aDemoBattle24, aDemoBattle24_UnitList
        .long aDemoBattle25, aDemoBattle25_UnitList
        .long aDemoBattle26, aDemoBattle26_UnitList
        .long aDemoBattle27, aDemoBattle27_UnitList
        .long aDemoBattle28, aDemoBattle28_UnitList
        .long aDemoBattle29, aDemoBattle29_UnitList
        .long aDemoBattle30, aDemoBattle30_UnitList
        .long aDemoBattle31, aDemoBattle31_UnitList

      aDemoBattle00 ; 8D/80C0
        .byte $00, $60, $00, $0C, $01, $1A, $17, $21, $18, $04, $04, $2A, $26, $1E, $23, $06
        .byte $12, $38, $64, $12, $14, $0E, $07, $D4, $51, $01
        .word $0000
        .word $0000

      aDemoBattle00_UnitList ; 8D/80DE
        .word $0009, $0C14, $0600, $0C14, $FFFF

      aDemoBattle01 ; 8D/80E8
        .byte $00, $EC, $00, $A5, $00, $3B, $14, $3F, $05, $0E, $0E, $20, $30, $20, $30, $0D
        .byte $08, $48, $62, $12, $10, $08, $04, $78, $60, $05
        .word $0000
        .word $0000

      aDemoBattle01_UnitList ; 8D/8106
        .word $1049, $1049, $1004, $FFFF

      aDemoBattle02 ; 8D/810E
        .byte $00, $03, $00, $02, $00, $09, $09, $1C, $00, $19, $04, $2A, $2B, $2A, $2B, $19
        .byte $1D, $58, $5C, $1C, $1C, $10, $14, $36, $36, $01
        .long dialogueDemoBattleQuote96FD6F
        .long dialogueDemoBattleQuote96FD84

      aDemoBattle02_UnitList ; 8D/812E
        .word $0000, $0801, $0C04, $1005, $FFFF

      aDemoBattle03 ; 8D/8138
        .byte $00, $04, $00, $13, $00, $1A, $17, $1E, $05, $17, $17, $32, $26, $18, $14, $1C
        .byte $19, $63, $64, $1F, $19, $1B, $0C, $36, $36, $05
        .long dialogueDemoBattleQuote98FFC9
        .long dialogueDemoBattleQuote98FFEE

      aDemoBattle03_UnitList ; 8D/8158
        .word $0009, $13FE, $0814, $0400, $02FE, $0000, $0404, $0814
        .word $FFFF

      aDemoBattle04 ; 8D/816A
        .byte $00, $52, $00, $10, $00, $3D, $3C, $52, $63, $09, $04, $32, $1B, $32, $1B, $0A
        .byte $04, $FF, $FF, $FF, $FF, $FF, $FF, $D7, $36, $07
        .word $0000
        .long dialogueDemoBattleQuote96FF3E

      aDemoBattle04_UnitList ; 8D/8189
        .word $0002, $FFFF

      aDemoBattle05 ; 8D/818D
        .byte $00, $0A, $00, $17, $00, $0D, $38, $FF, $5F, $0E, $0E, $28, $20, $02, $20, $1D
        .byte $1E, $FF, $FF, $FF, $FF, $FF, $FF, $36, $36, $05
        .word $0000
        .long dialogueDemoBattleQuote96FF5D

      aDemoBattle05_UnitList ; 8D/81AC
        .word $0002, $FFFF

      aDemoBattle06 ; 8D/81B0
        .byte $00, $5A, $00, $01, $00, $09, $06, $14, $02, $04, $04, $41, $35, $41, $35, $19
        .byte $16, $64, $1F, $34, $24, $18, $0D, $44, $36, $01
        .word $0000
        .long dialogueDemoBattleQuote96FF7A

      aDemoBattle06_UnitList ; 8D/81CF
        .word $2701, $0008, $FFFF

      aDemoBattle07 ; 8D/81D5
        .byte $00, $5A, $00, $12, $00, $09, $2F, $14, $FF, $04, $04, $41, $1E, $41, $1E, $19
        .byte $08, $64, $FF, $34, $FF, $18, $FF, $44, $36, $05
        .word $0000
        .long dialogueDemoBattleQuote96FFA6

      aDemoBattle07_UnitList ; 8D/81F4
        .word $FFFF

      aDemoBattle08 ; 8D/81F6
        .byte $00, $14, $00, $16, $00, $11, $32, $FF, $19, $12, $04, $29, $23, $29, $23, $14
        .byte $12, $00, $00, $00, $04, $0C, $05, $36, $36, $0D
        .long dialogueDemoBattleQuote96FDA0
        .long dialogueDemoBattleQuote96FDCC

      aDemoBattle08_UnitList ; 8D/8216
        .word $0008, $0008, $FFFF

      aDemoBattle09 ; 8D/821C
        .byte $00, $16, $00, $08, $00, $32, $3A, $19, $FF, $12, $04, $23, $31, $23, $31, $12
        .byte $17, $00, $00, $04, $00, $05, $09, $36, $36, $09
        .long dialogueDemoBattleQuote96FDE2
        .long dialogueDemoBattleQuote96FE02

      aDemoBattle09_UnitList ; 8D/823C
        .word $0009, $0009, $FFFF

      aDemoBattle10 ; 8D/8242
        .byte $00, $EF, $00, $06, $00, $14, $07, $23, $24, $08, $08, $4B, $32, $4B, $05, $1E
        .byte $13, $64, $5A, $3D, $3C, $21, $1B, $60, $05, $01
        .word $0000
        .long dialogueDemoBattleQuote96FFE0

      aDemoBattle10_UnitList ; 8D/8261
        .word $1B00, $1B00, $0511, $FFFF

      aDemoBattle11 ; 8D/8269
        .byte $00, $61, $01, $1D, $00, $14, $08, $1E, $02, $03, $04, $41, $35, $41, $35, $1E
        .byte $17, $41, $64, $31, $28, $1A, $19, $60, $36, $01
        .word $0000
        .long dialogueDemoBattleQuote8D8468

      aDemoBattle11_UnitList ; 8D/8288
        .word $0E00, $0E00, $0009, $2514, $FFFF

      aDemoBattle12 ; 8D/8292
        .byte $00, $3A, $00, $32, $00, $16, $16, $00, $00, $17, $17, $1C, $1D, $1C, $1D, $FF
        .byte $FF, $3D, $2D, $0F, $0F, $07, $07, $36, $36, $09
        .long dialogueDemoBattleQuote96FE35
        .long dialogueDemoBattleQuote96FE68

      aDemoBattle12_UnitList ; 8D/82B2
        .word $13FE, $0008, $0800, $0008, $0800, $0008, $13FE, $0801
        .word $0801, $0009, $0801, $0801, $FFFF

      aDemoBattle13 ; 8D/82CC
        .byte $00, $1A, $00, $3A, $00, $17, $16, $00, $00, $17, $17, $26, $1C, $26, $1C, $0C
        .byte $FF, $42, $26, $18, $0F, $0C, $07, $36, $36, $05
        .long dialogueDemoBattleQuote96FE9C
        .long dialogueDemoBattleQuote96FEC1

      aDemoBattle13_UnitList ; 8D/82EC
        .word $13FE, $0300, $0300, $0008, $0008, $0008, $1101, $1101
        .word $FFFF

      aDemoBattle14 ; 8D/82FE
        .byte $00, $7D, $01, $3D, $00, $31, $34, $40, $43, $09, $09, $41, $25, $41, $25, $1B
        .byte $0C, $5C, $29, $32, $14, $1E, $10, $88, $36, $0E
        .word $0000
        .word $0000

      aDemoBattle14_UnitList ; 8D/831C
        .word $0A44, $2241, $FFFF

      aDemoBattle15 ; 8D/8322
        .byte $00, $3D, $00, $35, $00, $34, $3A, $FF, $5A, $09, $09, $25, $36, $03, $36, $0C
        .byte $19, $FF, $FF, $FF, $FF, $FF, $FF, $36, $36, $09
        .word $0000
        .long dialogueDemoBattleQuote8D8487

      aDemoBattle15_UnitList ; 8D/8341
        .word $2202, $FFFF

      aDemoBattle16 ; 8D/8345
        .byte $00, $1E, $00, $31, $00, $03, $27, $29, $29, $04, $03, $28, $2A, $28, $2A, $0C
        .byte $0C, $5A, $54, $20, $21, $0A, $0C, $11, $11, $01
        .word $0000
        .word $0000

      aDemoBattle16_UnitList ; 8D/8363
        .word $1401, $1401, $0009, $2B14, $FFFF

      aDemoBattle17 ; 8D/836D
        .byte $00, $1E, $00, $3B, $00, $03, $33, $29, $5A, $03, $04, $28, $22, $02, $22, $0C
        .byte $05, $FF, $FF, $FF, $FF, $FF, $FF, $36, $36, $05
        .long dialogueDemoBattleQuote96FEF4
        .long dialogueDemoBattleQuote96FF29

      aDemoBattle17_UnitList ; 8D/838D
        .word $2602, $FFFF

      aDemoBattle26 ; 8D/8391
        .byte $00, $04, $01, $01, $00, $3A, $06, $41, $15, $03, $03, $3C, $3C, $3C, $3C, $1E
        .byte $1E, $FF, $64, $FF, $3B, $FF, $0A, $78, $36, $01
        .long dialogueDemoBattleQuote8D85F4
        .word $0000

      aDemoBattle26_UnitList ; 8D/83B0
        .word $3041, $2D00, $FFFF

      aDemoBattle27 ; 8D/83B6
        .byte $00, $04, $01, $10, $00, $3A, $3C, $41, $5A, $09, $09, $3C, $1B, $0F, $1B, $1E
        .byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $78, $B8, $05
        .word $0000
        .long dialogueDemoBattleQuote8D860D

      aDemoBattle27_UnitList ; 8D/83D5
        .word $2D02, $FFFF

      aDemoBattle28 ; 8D/83D9
        .byte $00, $2B, $00, $10, $00, $3C, $3C, $FF, $5E, $09, $09, $12, $18, $12, $04, $FF
        .byte $01, $FF, $FF, $FF, $FF, $FF, $FF, $B8, $B8, $0D
        .word $0000
        .long dialogueDemoBattleQuote8D8556

      aDemoBattle28_UnitList ; 8D/83F8
        .word $0002, $FFFF

      aDemoBattle29 ; 8D/83FC
        .byte $00, $C6, $01, $10, $00, $47, $3C, $54, $FF, $09, $09, $50, $18, $50, $04, $1E
        .byte $01, $64, $FF, $37, $FF, $1E, $FF, $C8, $B8, $05
        .long dialogueDemoBattleQuote8D8575
        .word $0000

      aDemoBattle29_UnitList ; 8D/841B
        .word $0451, $FFFF

      aDemoBattle30 ; 8D/841F
        .byte $00, $C6, $01, $2B, $00, $47, $3A, $54, $50, $09, $09, $50, $2A, $28, $16, $1E
        .byte $1A, $49, $41, $37, $3C, $1E, $2E, $C8, $36, $05
        .long dialogueDemoBattleQuote8D8597
        .word $0000

      aDemoBattle30_UnitList ; 8D/843E
        .word $0941, $1E40, $FFFF

      aDemoBattle31 ; 8D/8444
        .byte $00, $C6, $01, $19, $00, $47, $06, $54, $15, $09, $09, $50, $42, $0A, $10, $1E
        .byte $1E, $3D, $47, $37, $1E, $19, $26, $C8, $36, $01
        .word $0000
        .word $0000

      aDemoBattle31_UnitList ; 8D/8462
        .word $0049, $0A14, $FFFF

      dialogueDemoBattleQuote8D8468 ; 8D/8468
        .byte $07, $00, $05, $01
        _8D8468_Body .include "../../text/dialogue/DemoBattles/Quote8D8468.dialogue.txt"

      dialogueDemoBattleQuote8D8487 ; 8D/8487
        .byte $07, $00, $05, $01
        _8D8487_Body .include "../../text/dialogue/DemoBattles/Quote8D8487.dialogue.txt"

      dialogueDemoBattleQuote8D84A0 ; 8D/84A0
        .byte $07, $00, $05, $01
        _8D84A0_Body .include "../../text/dialogue/DemoBattles/Quote8D84A0.dialogue.txt"

      dialogueDemoBattleQuote8D84C1 ; 8D/84C1
        .byte $07, $00, $05, $01
        _8D84C1_Body .include "../../text/dialogue/DemoBattles/Quote8D84C1.dialogue.txt"

      dialogueDemoBattleQuote8D84EC ; 8D/84EC
        .byte $07, $00, $05, $01
        _8D84EC_Body .include "../../text/dialogue/DemoBattles/Quote8D84EC.dialogue.txt"

      dialogueDemoBattleQuote8D8508 ; 8D/8508
        .byte $07, $00, $05, $01
        _8D8508_Body .include "../../text/dialogue/DemoBattles/Quote8D8508.dialogue.txt"

      dialogueDemoBattleQuote8D8524 ; 8D/8524
        .byte $07, $00, $05, $01
        _8D8524_Body .include "../../text/dialogue/DemoBattles/Quote8D8524.dialogue.txt"

      dialogueDemoBattleQuote8D853E ; 8D/853E
        .byte $07, $00, $05, $01
        _8D853E_Body .include "../../text/dialogue/DemoBattles/Quote8D853E.dialogue.txt"

      dialogueDemoBattleQuote8D8556 ; 8D/8556
        .byte $07, $00, $05, $01
        _8D8556_Body .include "../../text/dialogue/DemoBattles/Quote8D8556.dialogue.txt"

      dialogueDemoBattleQuote8D8575 ; 8D/8575
        .byte $07, $00, $05, $01
        _8D8575_Body .include "../../text/dialogue/DemoBattles/Quote8D8575.dialogue.txt"

      dialogueDemoBattleQuote8D8597 ; 8D/8597
        .byte $07, $00, $05, $01
        _8D8597_Body .include "../../text/dialogue/DemoBattles/Quote8D8597.dialogue.txt"

      dialogueDemoBattleQuote8D85B7 ; 8D/85B7
        .byte $07, $00, $05, $01
        _8D85B7_Body .include "../../text/dialogue/DemoBattles/Quote8D85B7.dialogue.txt"

      dialogueDemoBattleQuote8D85D1 ; 8D/85D1
        .byte $07, $00, $05, $01
        _8D85D1_Body .include "../../text/dialogue/DemoBattles/Quote8D85D1.dialogue.txt"

      dialogueDemoBattleQuote8D85F4 ; 8D/85F4
        .byte $07, $00, $05, $01
        _8D85F4_Body .include "../../text/dialogue/DemoBattles/Quote8D85F4.dialogue.txt"

      dialogueDemoBattleQuote8D860D ; 8D/860D
        .byte $07, $00, $05, $01
        _8D860D_Body .include "../../text/dialogue/DemoBattles/Quote8D860D.dialogue.txt"


    .endsection DemoBattlesSection


