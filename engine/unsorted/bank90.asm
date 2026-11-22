; Code and data at the end of bank $90 ($90/EBCA-F622), after the dialogue: the
; routines the event scripts at $90/E8CE-EBC9 run with RUN_ASM (those scripts are
; not built yet), with their tables of chapters, map positions and map sprites.
; They may belong to the attract-mode demo; not confirmed.

    .section Data90E8CESection

      .al
      .xl

      aUnknown90E8CE ; 90/E8CE

        ; Event script and helper tables read by rlUnknown9BDFAA (calls rlUnknown90EBCA, rlUnknown90EBD6).

        .byte $5D, $45, $84, $F1, $90, $45, $10, $A8, $8D, $3A, $00, $07, $3B, $80, $34, $05
        .byte $00, $FD, $45, $80, $A8, $8D, $27, $C7, $00, $02, $0C, $05, $06, $A2, $EB, $90
        .byte $29, $27, $C8, $00, $16, $0E, $04, $06, $AD, $EB, $90, $29, $27, $C8, $00, $16
        .byte $0D, $04, $06, $B3, $EB, $90, $29, $27, $C8, $00, $14, $10, $04, $06, $B0, $EB
        .byte $90, $29, $46, $05, $3F, $B8, $EB, $90, $02, $FD, $34, $32, $00, $FD, $47, $06
        .byte $FD, $2A, $FD, $34, $1E, $00, $FD, $45, $FD, $AA, $8D, $34, $B4, $00, $FD, $47
        .byte $04, $FD, $34, $0A, $00, $FD, $45, $C1, $FD, $97, $FD, $45, $C0, $94, $82, $FD
        .byte $34, $1E, $00, $FD, $45, $32, $AB, $8D, $34, $C8, $00, $FD, $47, $04, $FD, $34
        .byte $14, $00, $FD, $14, $D5, $9E, $8D, $04, $05, $03, $FD, $34, $19, $00, $FD, $45
        .byte $67, $AB, $8D, $34, $D2, $00, $FD, $47, $04, $FD, $45, $A6, $F1, $90, $45, $D6
        .byte $EB, $90, $3B, $80, $45, $84, $F1, $90, $45, $DF, $F1, $90, $34, $14, $00, $FD
        .byte $45, $B0, $F1, $90, $04, $B2, $E9, $27, $A5, $00, $3B, $2E, $04, $04, $C2, $EB
        .byte $90, $29, $34, $07, $00, $FD, $3F, $BF, $EB, $90, $01, $46, $05, $FD, $2A, $FD
        .byte $2B, $45, $D9, $EE, $88, $45, $00, $80, $9E, $34, $27, $00, $FD, $45, $D3, $F1
        .byte $90, $02, $C1, $E9, $45, $D9, $EE, $88, $45, $00, $80, $9E, $34, $20, $00, $FD
        .byte $46, $04, $FD, $45, $78, $94, $82, $FD, $47, $04, $FD, $45, $96, $94, $82, $34
        .byte $19, $00, $FD, $45, $AA, $AB, $8D, $34, $D2, $00, $FD, $47, $04, $FD, $34, $14
        .byte $00, $FD, $14, $25, $9F, $8D, $03, $05, $03, $FD, $34, $19, $00, $FD, $45, $ED
        .byte $AB, $8D, $34, $D2, $00, $FD, $47, $04, $FD, $45, $C6, $FD, $97, $FD, $45, $C0
        .byte $94, $82, $FD, $34, $1E, $00, $FD, $45, $30, $AC, $8D, $34, $C8, $00, $FD, $47
        .byte $04, $FD, $45, $D6, $EB, $90, $3B, $80, $45, $84, $F1, $90, $45, $DF, $F1, $90
        .byte $34, $14, $00, $FD, $45, $E2, $EE, $88, $45, $00, $80, $9E, $34, $20, $00, $FD
        .byte $46, $04, $FD, $45, $78, $94, $82, $FD, $47, $04, $FD, $45, $96, $94, $82, $34
        .byte $19, $00, $FD, $45, $73, $AC, $8D, $34, $C8, $00, $FD, $47, $04, $FD, $45, $64
        .byte $A8, $8D, $3A, $23, $11, $3B, $80, $45, $84, $F1, $90, $45, $55, $EC, $90, $34
        .byte $14, $00, $FD, $26, $0B, $00, $2A, $18, $2E, $18, $04, $06, $20, $1C, $80, $29
        .byte $26, $0B, $00, $2A, $18, $2E, $19, $04, $06, $26, $1D, $80, $29, $26, $0B, $00
        .byte $2A, $18, $2D, $19, $04, $06, $28, $1D, $80, $29, $46, $04, $2A, $FD, $26, $09
        .byte $00, $2A, $18, $25, $16, $04, $06, $44, $13, $80, $29, $34, $0C, $00, $FD, $26
        .byte $17, $00, $2A, $18, $26, $14, $04, $06, $30, $0F, $80, $29, $34, $0A, $00, $FD
        .byte $26, $04, $00, $2A, $18, $27, $14, $04, $06, $3A, $0B, $80, $29, $34, $0A, $00
        .byte $FD, $26, $17, $00, $2A, $18, $26, $15, $04, $06, $32, $0F, $80, $29, $34, $08
        .byte $00, $FD, $26, $04, $00, $2A, $18, $27, $15, $04, $06, $3C, $0B, $80, $29, $34
        .byte $08, $00, $FD, $26, $17, $00, $2A, $18, $26, $16, $04, $06, $34, $0F, $80, $29
        .byte $34, $06, $00, $FD, $26, $04, $00, $2A, $18, $27, $16, $04, $06, $3E, $0B, $80
        .byte $29, $34, $06, $00, $FD, $26, $17, $00, $2A, $18, $26, $17, $04, $06, $36, $0F
        .byte $80, $29, $34, $04, $00, $FD, $26, $04, $00, $2A, $18, $27, $17, $04, $06, $40
        .byte $0B, $80, $29, $26, $17, $00, $2A, $18, $26, $18, $04, $06, $38, $0F, $80, $29
        .byte $34, $06, $00, $FD, $26, $04, $00, $2A, $18, $27, $18, $04, $06, $42, $0B, $80
        .byte $29, $2A, $FD, $34, $0A, $00, $FD, $26, $04, $01, $2A, $18, $2A, $19, $03, $06
        .byte $04, $3C, $00, $29, $2A, $FD, $34, $0F, $00, $FD, $0C, $82, $9F, $8D, $45, $1C
        .byte $B1, $91, $34, $C0, $00, $FD, $47, $05, $FD, $45, $31, $B1, $91, $FD, $34, $19
        .byte $00, $FD, $45, $9A, $AC, $8D, $45, $CA, $EB, $90, $03, $89, $EB, $34, $B4, $00
        .byte $FD, $47, $03, $FD, $34, $28, $00, $FD, $02, $9B, $EB, $34, $B4, $00, $FD, $12
        .byte $E7, $00, $34, $50, $00, $FD, $47, $06, $FD, $34, $5A, $00, $FD, $45, $84, $F1
        .byte $90, $5E, $FF, $FF

      aUnknown90EBA2 ; 90/EBA2

        .byte $0B, $2D, $84, $03, $0B, $02, $84, $04, $0B, $0C, $80, $0B, $27, $80, $0B, $27
        .byte $80, $12, $19, $0B, $25, $80, $0B, $23, $84, $01, $0B, $0B, $80, $0D, $09, $80

      aUnknown90EBC2 ; 90/EBC2

        .byte $0D, $0B, $0A, $02, $81, $12, $1B, $80

        ; 90/EBCA

    .endsection Data90E8CESection


    .section Unsorted90EBCASection

      .al
      .xl

      rlUnknown90EBCA ; 90/EBCA

        .al
        .xl
        .autsiz
        .databank ?

        ; Run by RUN_ASM from the event scripts at $90/E8CE-EBC9 (not built yet).
        ; Copies $1832 to wEventEngineTruthFlag.

        phx
        phy
        lda $1832,b
        sta @l wEventEngineTruthFlag
        ply
        plx
        rtl

        .databank 0

        ; 90/EBD6

      rlUnknown90EBD6 ; 90/EBD6

        .al
        .xl
        .autsiz
        .databank ?

        ; Run by RUN_ASM from the event scripts at $90/E8CE-EBC9 (not built yet).
        ; Sets the chapter, the map position and the cursor for the entry $1B49 selects (aUnknown90EC19, aUnknown90EC25). Possibly the attract-mode demo, which shows chapter maps; not confirmed.

        phb
        php
        phk
        plb
        .databank $90
        phx
        phy
        lda $1B49,b
        tax
        lda @l aUnknown90EC19,x
        and #$00FF
        sta @l wCurrentChapter
        txa
        asl a
        asl a
        tax
        lda @l aUnknown90EC25,x
        sta @l wMapXOffset
        lda @l aUnknown90EC25+2,x
        sta @l wMapYOffset
        lda #$0002
        sta wMainGameMode,b
        lda #$FFFF
        sta wMapStateFlags,b
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 90/EC19

      aUnknown90EC19 ; 90/EC19

        ; A chapter number for each value of $1B49 (rlUnknown90EBD6).
        .byte $07, $02, $06, $00, $08, $01, $09, $04, $0B, $03, $0A, $05


      aUnknown90EC25 ; 90/EC25

        ; Map X and Y offsets for each value of $1B49 (rlUnknown90EBD6).
        .word $0300, $0310
        .word $02F0, $0280
        .word $0260, $0180
        .word $01A0, $0120
        .word $0060, $0050
        .word $02D0, $01F0
        .word $0270, $0280
        .word $01C0, $02E0
        .word $01D0, $00C0
        .word $0170, $0300
        .word $0080, $0000
        .word $0300, $0020


      rlUnknown90EC55 ; 90/EC55

        .al
        .xl
        .autsiz
        .databank ?

        ; Run by RUN_ASM from the event scripts at $90/E8CE-EBC9 (not built yet).
        ; Places a fixed set of map sprites (positions in pixels) with rlAddDeployedMapSprite.

        lda #$02A0
        sta $7E453F
        lda #$0190
        sta $7E45CF
        lda #$003C
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E465F
        lda #$00C2
        sta $7E438F
        lda #$02C0
        sta $7E4541
        lda #$0140
        sta $7E45D1
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4661
        lda #$0082
        sta $7E4391
        lda #$02D0
        sta $7E4543
        lda #$0130
        sta $7E45D3
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4663
        lda #$0082
        sta $7E4393
        lda #$02E0
        sta $7E4545
        lda #$0130
        sta $7E45D5
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4665
        lda #$0082
        sta $7E4395
        lda #$02F0
        sta $7E4547
        lda #$0130
        sta $7E45D7
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4667
        lda #$0082
        sta $7E4397
        lda #$0300
        sta $7E4549
        lda #$0140
        sta $7E45D9
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4669
        lda #$0082
        sta $7E4399
        lda #$02D0
        sta $7E454B
        lda #$0140
        sta $7E45DB
        lda #$0029
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E466B
        lda #$0082
        sta $7E439B
        lda #$02E0
        sta $7E454D
        lda #$0140
        sta $7E45DD
        lda #$0029
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E466D
        lda #$0082
        sta $7E439D
        lda #$02F0
        sta $7E454F
        lda #$0140
        sta $7E45DF
        lda #$0029
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E466F
        lda #$0082
        sta $7E439F
        lda #$02D0
        sta $7E4551
        lda #$0150
        sta $7E45E1
        lda #$0028
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4671
        lda #$0082
        sta $7E43A1
        lda #$02E0
        sta $7E4553
        lda #$0150
        sta $7E45E3
        lda #$0028
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4673
        lda #$0082
        sta $7E43A3
        lda #$02F0
        sta $7E4555
        lda #$0150
        sta $7E45E5
        lda #$0028
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4675
        lda #$0082
        sta $7E43A5
        lda #$02D0
        sta $7E4557
        lda #$0160
        sta $7E45E7
        lda #$0031
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4677
        lda #$0082
        sta $7E43A7
        lda #$02F0
        sta $7E4559
        lda #$0160
        sta $7E45E9
        lda #$002D
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4679
        lda #$0082
        sta $7E43A9
        lda #$02E0
        sta $7E455B
        lda #$0180
        sta $7E45EB
        lda #$801C
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E467B
        lda #$00C2
        sta $7E43AB
        lda #$02F0
        sta $7E455D
        lda #$0180
        sta $7E45ED
        lda #$801C
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E467D
        lda #$0082
        sta $7E43AD
        lda #$0300
        sta $7E455F
        lda #$0180
        sta $7E45EF
        lda #$801C
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E467F
        lda #$0082
        sta $7E43AF
        lda #$02D0
        sta $7E4561
        lda #$0190
        sta $7E45F1
        lda #$801D
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4681
        lda #$00C2
        sta $7E43B1
        lda #$02E0
        sta $7E4563
        lda #$0190
        sta $7E45F3
        lda #$801D
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4683
        lda #$00C2
        sta $7E43B3
        lda #$0300
        sta $7E4565
        lda #$0190
        sta $7E45F5
        lda #$801D
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4685
        lda #$0082
        sta $7E43B5
        lda #$0310
        sta $7E4567
        lda #$0190
        sta $7E45F7
        lda #$801D
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4687
        lda #$0082
        sta $7E43B7
        lda #$02F0
        sta $7E4569
        lda #$0190
        sta $7E45F9
        lda #$801E
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4689
        lda #$0082
        sta $7E43B9
        lda #$0260
        sta $7E456B
        lda #$0140
        sta $7E45FB
        lda #$800F
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E468B
        lda #$00C2
        sta $7E43BB
        lda #$0260
        sta $7E456D
        lda #$0150
        sta $7E45FD
        lda #$800F
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E468D
        lda #$00C2
        sta $7E43BD
        lda #$0260
        sta $7E456F
        lda #$0160
        sta $7E45FF
        lda #$800F
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E468F
        lda #$00C2
        sta $7E43BF
        lda #$0260
        sta $7E4571
        lda #$0170
        sta $7E4601
        lda #$800F
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4691
        lda #$00C2
        sta $7E43C1
        lda #$0260
        sta $7E4573
        lda #$0180
        sta $7E4603
        lda #$800F
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4693
        lda #$00C2
        sta $7E43C3
        lda #$0270
        sta $7E4575
        lda #$0140
        sta $7E4605
        lda #$800B
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4695
        lda #$00C2
        sta $7E43C5
        lda #$0270
        sta $7E4577
        lda #$0150
        sta $7E4607
        lda #$800B
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4697
        lda #$00C2
        sta $7E43C7
        lda #$0270
        sta $7E4579
        lda #$0160
        sta $7E4609
        lda #$800B
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E4699
        lda #$00C2
        sta $7E43C9
        lda #$0270
        sta $7E457B
        lda #$0170
        sta $7E460B
        lda #$800B
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E469B
        lda #$00C2
        sta $7E43CB
        lda #$0270
        sta $7E457D
        lda #$0180
        sta $7E460D
        lda #$800B
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E469D
        lda #$00C2
        sta $7E43CD
        lda #$0250
        sta $7E457F
        lda #$0160
        sta $7E460F
        lda #$8013
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E469F
        lda #$00C2
        sta $7E43CF
        lda #$0280
        sta $7E4581
        lda #$01B0
        sta $7E4611
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E46A1
        lda #$0082
        sta $7E43D1
        lda #$0290
        sta $7E4583
        lda #$01B0
        sta $7E4613
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E46A3
        lda #$0082
        sta $7E43D3
        lda #$02A0
        sta $7E4585
        lda #$01B0
        sta $7E4615
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E46A5
        lda #$0082
        sta $7E43D5
        lda #$02B0
        sta $7E4587
        lda #$01B0
        sta $7E4617
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E46A7
        lda #$0082
        sta $7E43D7
        lda #$02C0
        sta $7E4589
        lda #$01B0
        sta $7E4619
        lda #$0010
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E46A9
        lda #$0082
        sta $7E43D9
        lda #$02A0
        sta $7E458B
        lda #$01C0
        sta $7E461B
        lda #$001D
        sta wR1
        jsl rlAddDeployedMapSprite
        sta $7E46AB
        lda #$0082
        sta $7E43DB
        rtl

        .databank 0

        ; 90/F184

      rlUnknown90F184 ; 90/F184

        .al
        .xl
        .autsiz
        .databank ?

        ; Run by RUN_ASM from the event scripts at $90/E8CE-EBC9 (not built yet).
        ; Clears the deployment table (positions and map sprites).

        ldx #$008E

        _F187
        lda #$0000
        sta aDeploymentTable,x
        sta aDeploymentTable._XPixelPosition,x
        sta aDeploymentTable._YPixelPosition,x
        sta aDeploymentTable._DeploymentOffsets,x
        lda #$FFFF
        sta aDeploymentTable._MapSpriteID,x
        dec x
        dec x
        bpl _F187
        rtl

        .databank 0

        ; 90/F1A6

      rlUnknown90F1A6 ; 90/F1A6

        .al
        .xl
        .autsiz
        .databank ?

        ; Run by RUN_ASM from the event scripts at $90/E8CE-EBC9 (not built yet).
        ; Sets bit 0 of $1B49.

        lda $1B49,b
        ora #$0001
        sta $1B49,b
        rtl

        .databank 0

        ; 90/F1B0

      rlUnknown90F1B0 ; 90/F1B0

        .al
        .xl
        .autsiz
        .databank ?

        ; Run by RUN_ASM from the event scripts at $90/E8CE-EBC9 (not built yet).
        ; Sets wEventEngineTruthFlag when $1B49 is 1, clears it otherwise.

        phb
        php
        phk
        plb
        .databank $90
        phx
        phy
        lda $1B49,b
        cmp #$0001
        bne _F1C7
        lda #$0001
        sta @l wEventEngineTruthFlag
        bra _F1CE


        _F1C7
        lda #$0000
        sta @l wEventEngineTruthFlag

        _F1CE
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 90/F1D3

      rlUnknown90F1D3 ; 90/F1D3

        .al
        .xl
        .autsiz
        .databank ?

        ; Run by RUN_ASM from the event scripts at $90/E8CE-EBC9 (not built yet).
        ; Sets bit 6 of $7E43A5.

        lda $7E43A5
        ora #$0040
        sta $7E43A5
        rtl

        .databank 0

        ; 90/F1DF

      rlUnknown90F1DF ; 90/F1DF

        .al
        .xl
        .autsiz
        .databank ?

        ; Run by RUN_ASM from the event scripts at $90/E8CE-EBC9 (not built yet).
        ; Places the map sprites in the list aUnknown90F23E gives for $1B49.

        phb
        php
        phk
        plb
        .databank $90
        phx
        phy
        lda $1B49,b
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda @l aUnknown90F23E+1,x
        sta lR18+1
        lda @l aUnknown90F23E,x
        sta lR18
        ldy #$0000
        ldx #$0004

        _F201
        lda [lR18],y
        and #$00FF
        beq _F239
        asl a
        asl a
        asl a
        asl a
        sta aDeploymentTable._XPixelPosition,x
        inc y
        lda [lR18],y
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        sta aDeploymentTable._YPixelPosition,x
        inc y
        lda [lR18],y
        sta wR1
        jsl rlAddDeployedMapSprite
        sta aDeploymentTable._DeploymentOffsets,x
        inc y
        inc y
        lda [lR18],y
        sta aDeploymentTable,x
        inc x
        inc x
        inc y
        inc y
        bra _F201


        _F239
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 90/F23E

      aUnknown90F23E ; 90/F23E

        ; A map sprite list for each value of $1B49 (rlUnknown90F1DF).
        .long aUnknown90F5CD
        .long aUnknown90F584
        .long aUnknown90F529
        .long aUnknown90F4E0
        .long aUnknown90F48B
        .long aUnknown90F43C
        .long aUnknown90F3F9
        .long aUnknown90F392
        .long aUnknown90F337
        .long aUnknown90F2F4
        .long aUnknown90F2BD
        .long aUnknown90F262


      aUnknown90F262 ; 90/F262

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 51, 8
        .word $800B, $0080
        .byte 52, 9
        .word $800B, $0080
        .byte 51, 10
        .word $0010, $0080
        .byte 50, 3
        .word $003C, $0080
        .byte 58, 6
        .word $800E, $0080
        .byte 55, 12
        .word $001F, $0080
        .byte 58, 10
        .word $001E, $0080
        .byte 58, 9
        .word $800D, $0080
        .byte 59, 9
        .word $0020, $0080
        .byte 56, 8
        .word $0010, $0081
        .byte 61, 3
        .word $8016, $0081
        .byte 61, 4
        .word $8016, $0081
        .byte 61, 9
        .word $800D, $0081
        .byte 62, 8
        .word $8006, $0081
        .byte 62, 9
        .word $8006, $0081
        .byte 0


      aUnknown90F2BD ; 90/F2BD

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 17, 6
        .word $0017, $0080
        .byte 13, 6
        .word $8013, $0080
        .byte 13, 11
        .word $801A, $0080
        .byte 14, 9
        .word $001E, $0080
        .byte 18, 10
        .word $0015, $0080
        .byte 20, 5
        .word $003C, $0080
        .byte 10, 8
        .word $0038, $0080
        .byte 11, 10
        .word $8012, $0080
        .byte 13, 3
        .word $0018, $0080
        .byte 0


      aUnknown90F2F4 ; 90/F2F4

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 28, 51
        .word $8009, $0080
        .byte 34, 57
        .word $800A, $0080
        .byte 36, 59
        .word $0026, $0080
        .byte 34, 50
        .word $8007, $0080
        .byte 33, 55
        .word $000E, $0080
        .byte 31, 56
        .word $8001, $0080
        .byte 27, 50
        .word $8001, $0081
        .byte 29, 50
        .word $8001, $0081
        .byte 28, 49
        .word $8001, $0081
        .byte 26, 53
        .word $0005, $0081
        .byte 26, 54
        .word $0005, $0081
        .byte 0


      aUnknown90F337 ; 90/F337

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 40, 20
        .word $8008, $0080
        .byte 43, 16
        .word $003D, $0081
        .byte 40, 17
        .word $001E, $0080
        .byte 35, 22
        .word $0017, $0080
        .byte 35, 23
        .word $0018, $0080
        .byte 38, 22
        .word $8013, $0080
        .byte 33, 22
        .word $801A, $0080
        .byte 32, 23
        .word $800C, $0082
        .byte 42, 22
        .word $003E, $0081
        .byte 41, 24
        .word $002E, $0081
        .byte 40, 23
        .word $003B, $0081
        .byte 38, 24
        .word $0018, $0081
        .byte 44, 24
        .word $0031, $0081
        .byte 32, 19
        .word $8012, $0081
        .byte 33, 20
        .word $8012, $0081
        .byte 0


      aUnknown90F392 ; 90/F392

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 32, 52
        .word $8011, $0083
        .byte 33, 54
        .word $8011, $0083
        .byte 38, 48
        .word $8011, $0081
        .byte 39, 49
        .word $8011, $0081
        .byte 39, 51
        .word $8011, $0081
        .byte 40, 50
        .word $8011, $0081
        .byte 40, 47
        .word $8011, $0081
        .byte 41, 48
        .word $8011, $0081
        .byte 38, 52
        .word $8006, $0081
        .byte 38, 53
        .word $8006, $0081
        .byte 38, 54
        .word $8006, $0081
        .byte 39, 52
        .word $8006, $0081
        .byte 39, 53
        .word $8006, $0081
        .byte 39, 54
        .word $8006, $0081
        .byte 40, 52
        .word $8006, $0081
        .byte 40, 54
        .word $8006, $0081
        .byte 40, 53
        .word $800D, $0081
        .byte 0


      aUnknown90F3F9 ; 90/F3F9

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 45, 45
        .word $0030, $0080
        .byte 46, 44
        .word $8003, $0080
        .byte 47, 44
        .word $8009, $0080
        .byte 48, 49
        .word $0017, $0080
        .byte 45, 51
        .word $0003, $0080
        .byte 46, 52
        .word $0002, $0080
        .byte 53, 47
        .word $0039, $0080
        .byte 49, 50
        .word $8012, $0080
        .byte 42, 51
        .word $0018, $0080
        .byte 48, 47
        .word $8010, $0081
        .byte 51, 46
        .word $8010, $0081
        .byte 0


      aUnknown90F43C ; 90/F43C

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 47, 38
        .word $000F, $0080
        .byte 47, 37
        .word $0002, $0080
        .byte 54, 40
        .word $800A, $0080
        .byte 56, 38
        .word $8009, $0080
        .byte 55, 37
        .word $8003, $0080
        .byte 50, 34
        .word $8001, $0080
        .byte 50, 35
        .word $0001, $0080
        .byte 50, 36
        .word $8006, $0080
        .byte 57, 40
        .word $0012, $0081
        .byte 55, 42
        .word $0012, $0081
        .byte 46, 40
        .word $0006, $0081
        .byte 47, 42
        .word $0006, $0081
        .byte 50, 41
        .word $0006, $0081
        .byte 0


      aUnknown90F48B ; 90/F48B

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 8, 6
        .word $0030, $0080
        .byte 10, 10
        .word $8003, $0080
        .byte 9, 8
        .word $8009, $0080
        .byte 8, 15
        .word $0017, $0080
        .byte 11, 15
        .word $000D, $0080
        .byte 11, 17
        .word $000C, $0080
        .byte 14, 16
        .word $0038, $0080
        .byte 18, 12
        .word $0007, $0081
        .byte 20, 15
        .word $003D, $0081
        .byte 13, 12
        .word $002A, $0081
        .byte 15, 12
        .word $0014, $0081
        .byte 12, 9
        .word $8009, $0081
        .byte 11, 11
        .word $8007, $0081
        .byte 15, 8
        .word $800F, $0081
        .byte 0


      aUnknown90F4E0 ; 90/F4E0

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 34, 26
        .word $0012, $0081
        .byte 32, 25
        .word $0006, $0081
        .byte 34, 25
        .word $0006, $0081
        .byte 33, 26
        .word $0006, $0081
        .byte 28, 27
        .word $0016, $0081
        .byte 31, 28
        .word $0006, $0081
        .byte 36, 25
        .word $0016, $0081
        .byte 36, 26
        .word $0006, $0081
        .byte 38, 26
        .word $0006, $0081
        .byte 37, 17
        .word $0006, $0081
        .byte 36, 18
        .word $0006, $0081
        .byte 37, 19
        .word $0006, $0081
        .byte 0


      aUnknown90F529 ; 90/F529

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 51, 30
        .word $0003, $0080
        .byte 51, 29
        .word $0011, $0080
        .byte 48, 30
        .word $000D, $0080
        .byte 49, 26
        .word $0004, $0080
        .byte 49, 33
        .word $8004, $0082
        .byte 50, 33
        .word $8004, $0082
        .byte 51, 33
        .word $8004, $0082
        .byte 52, 33
        .word $8004, $0082
        .byte 53, 33
        .word $8004, $0082
        .byte 42, 25
        .word $0012, $0081
        .byte 42, 26
        .word $0012, $0081
        .byte 42, 27
        .word $0012, $0081
        .byte 42, 28
        .word $0012, $0081
        .byte 42, 29
        .word $0012, $0081
        .byte 42, 30
        .word $0012, $0081
        .byte 0


      aUnknown90F584 ; 90/F584

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 57, 59
        .word $0026, $0080
        .byte 54, 59
        .word $8001, $0080
        .byte 60, 60
        .word $000D, $0080
        .byte 59, 59
        .word $0001, $0080
        .byte 48, 60
        .word $800A, $0080
        .byte 55, 50
        .word $8000, $0081
        .byte 57, 49
        .word $8019, $0081
        .byte 57, 47
        .word $8010, $0081
        .byte 59, 48
        .word $801A, $0081
        .byte 60, 49
        .word $800C, $0081
        .byte 61, 51
        .word $801B, $0081
        .byte 56, 57
        .word $0018, $0080
        .byte 0


      aUnknown90F5CD ; 90/F5CD

        ; X and Y tile, map sprite, deployment state; ends with 0.
        .byte 50, 59
        .word $0003, $0080
        .byte 49, 59
        .word $0011, $0080
        .byte 55, 60
        .word $0017, $0080
        .byte 58, 52
        .word $0030, $0080
        .byte 60, 51
        .word $8009, $0080
        .byte 49, 53
        .word $8001, $0080
        .byte 50, 53
        .word $000C, $0080
        .byte 51, 55
        .word $001D, $0081
        .byte 50, 57
        .word $0010, $0081
        .byte 52, 57
        .word $0010, $0081
        .byte 55, 58
        .word $0028, $0081
        .byte 54, 59
        .word $002A, $0081
        .byte 56, 59
        .word $0014, $0081
        .byte 55, 55
        .word $0000, $0081
        .byte 0

    .endsection Unsorted90EBCASection
