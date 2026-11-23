; The map battle: a battle played on the map with the animations off (bank $9E).
; rlStartMapBattleAnimation creates procMapBattle, whose script (aProcMapBattleCode)
; runs the whole fight: move the camera, create both units' battle sprites
; (aBattleMapSpriteData, by rlGetMapBattleClassSprite), the battle quote, open the
; HP windows, then each round of aBattleRoundsData (rlMapBattleNextRound: sprite
; scripts, ballista bolts, map magic, HP changes), the death quote,
; experience, the level up banner and stat gains, the gold, item and broken weapon
; popups, and the clean-up (rlProcMapBattleEnd). Also the scripted critical's
; effect played before such a battle (procScriptedCritEffect). The sprite and
; palette helpers that are still Unknown are shared with
; engine/battle/map_action_animations.asm and engine/events/cutscenes.asm.


    .section Data9CFC00Section

      .al
      .xl

      aUnknown9CFC00 ; 9C/FC00

        ; 16 palettes (offset +$0100 read by rlUnknown9E93A4 and rlUnknown9E965E).

        .word $4D96, $318B, $7FFF, $1484, $7FFF, $4D96, $4D96, $4D96
        .word $7FFF, $5B00, $0C20, $77FF, $7FFF, $001F, $0003, $7FBF
        .word $3000, $0C62, $0486, $21EA, $1DC9, $1188, $11C5, $0901
        .word $0D45, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FBF
        .word $3000, $0884, $08C7, $1E69, $1E29, $19E8, $11C5, $0D84
        .word $0940, $1DAE, $194E, $152D, $110C, $04E9, $04C7, $00A4
        .word $3000, $0D45, $19C8, $6687, $5144, $50E3, $38E1, $3881
        .word $2882, $5AD6, $4ED8, $3A55, $21F2, $196F, $08E9, $0085
        .word $3000, $08A5, $1DC9, $1168, $4F9C, $2657, $0D2F, $0089
        .word $6BF4, $6289, $3945, $18A0, $7BFF, $4F78, $3210, $0904
        .word $4001, $0C62, $0486, $21EA, $1DC9, $1188, $11C5, $0901
        .word $0460, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF
        .word $0001, $03FF, $6B7B, $635A, $5AF7, $4ED7, $3E75, $08C8
        .word $0000, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF
        .word $4001, $039C, $5310, $4ACE, $46AD, $428C, $3A4A, $04A7
        .word $0000, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF, $7FFF
        .word $3800, $14A4, $7FFF, $0400, $57D3, $3EAA, $5BFF, $273F
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $3800, $7FFF, $0000, $2DD2, $4EB5, $296B, $7F56, $5D8A
        .word $34E5, $4B9F, $1A3C, $0178, $533D, $2DD2, $2908, $0000
        .word $3800, $7FFF, $0000, $2DD2, $36D7, $2DF0, $5AFF, $2554
        .word $1CCB, $5FD5, $46AC, $29C7, $533D, $2DD2, $0C88, $0000
        .word $3800, $7FFF, $0000, $2DD2, $5F76, $3A49, $5F95, $362B
        .word $1D46, $52BF, $2156, $0CAE, $533D, $2DD2, $0906, $0000
        .word $3800, $7FFF, $0000, $2DD2, $2E95, $19D0, $375F, $21F2
        .word $112C, $77B9, $626E, $5526, $533D, $2DD2, $054A, $0000
        .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $3800, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $3800, $56B5, $35AD, $2108, $35AD, $1CE7, $4631, $2D6B
        .word $1CE7, $56B5, $35AD, $1CE7, $3DEF, $2D6B, $1CE7, $0000

        ; 9C/FE00

      aUnknown9CFE00 ; 9C/FE00

        ; S-CG-CAD trailer data.

        .byte $4E, $41, $4B, $31, $39, $38, $39, $20, $53, $2D, $43, $47, $2D, $43, $41, $44
        .byte $56, $65, $72, $31, $2E, $31, $32, $20, $39, $33, $30, $35, $31, $31, $20, $46
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $01, $00, $00, $01, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $01, $01, $02, $02, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
        .byte $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
        .byte $20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
        .byte $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
        .byte $40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
        .byte $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
        .byte $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $6E, $6F
        .byte $70, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7A, $7B, $7C, $7D, $7E, $7F
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

        ; 9D/0000

    .endsection Data9CFC00Section


    .section Unsorted9E8000Section

      .al
      .xl

      rlASMCStartDemoMapBattle ; 9E/8000

        ; The opening's demo battles (aOpeningEvent): runs rlStartMapBattleAnimation with wMapBattleMode 1.

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0001
        sta wMapBattleMode
        jml rlStartMapBattleAnimation._8014

        .databank 0

        ; 9E/800C

    .endsection Unsorted9E8000Section


    .section Unsorted9E800CSection

      .al
      .xl

      rlStartMapBattleAnimation ; 9E/800C

        .al
        .xl
        .autsiz
        .databank ?

        ; Creates procMapBattle in the first free proc slot from 7 down. Entered here with wMapBattleMode = 0 (a real battle); rlASMCStartDemoMapBattle enters at _8014 with 1, rlStartSoloMapBattleAnimation and rlStartScriptedMapBattleAnimation with 2.

        ; Entered here with wMapBattleMode = 0, at rlASMCStartDemoMapBattle with 1, and by
        ; rlStartSoloMapBattleAnimation and rlStartScriptedMapBattleAnimation at _8014 with 2.

        phx
        lda #$0000
        sta wMapBattleMode
        _8014

        lda #(`procMapBattle)<<8
        sta lR44+1
        lda #<>procMapBattle
        sta lR44
        lda #$0008
        dec a

        _8022
        sta $7F57F0
        jsl rlProcEngineCreateProcByIndex
        bcc _8033
        lda $7F57F0
        dec a
        bpl _8022

        _8033
        plx
        rtl

        .databank 0

        ; 9E/8035

    .endsection Unsorted9E800CSection


    .section Unreferenced9E8035Section

      .al
      .xl

      rlUnknown9E8035 ; 9E/8035

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0001
        sta wMapBattleMode
        lda #(`procMapBattle)<<8
        sta lR44+1
        lda #<>procMapBattle
        sta lR44
        lda #$0008
        dec a

        _804B
        sta $7F57F0
        jsl rlProcEngineCreateProcByIndex
        bcc _805C
        lda $7F57F0
        dec a
        bpl _804B

        _805C
        plx
        rtl

        .databank 0

        ; 9E/805E

    .endsection Unreferenced9E8035Section
    .section Unsorted9E805ESection

      .al
      .xl

      rlGetMapBattleFacing ; 9E/805E

        .al
        .xl
        .autsiz
        .databank ?

        ; The direction (0-7) from one unit to the other when they are at most 2 tiles apart (aMapBattleFacingOffsets), else from their angle (rlGetMapBattleFacingByAngle).

        php
        phb
        phx
        phk
        plb
        .databank $9E
        lda aMapAction.wXTilePosition
        sec
        sbc aMapAction.wUnknown7F4556
        sta wR0
        lda aMapAction.wYTilePosition
        sec
        sbc aMapAction.wUnknown7F4558
        sta wR1
        lda wR0
        bpl _8081
        dec a
        eor #$FFFF

        _8081
        sta wR2
        lda wR1
        bpl _808B
        dec a
        eor #$FFFF

        _808B
        sta wR3
        lda wR2
        clc
        adc wR3
        cmp #$0003
        bcs _80C3
        lda wR1
        xba
        and #$FF00
        sta wR15
        lda wR0
        and #$00FF
        ora wR15
        ldx #$0000

        _80A9
        cmp @l aMapBattleFacingOffsets,x
        beq _80B4
        inc x
        inc x
        inc x
        bra _80A9


        _80B4
        inc x
        inc x
        lda @l aMapBattleFacingOffsets,x
        and #$00FF
        sta aMapAction.wUnknown7F455E
        bra _80C7


        _80C3
        jsl rlGetMapBattleFacingByAngle

        _80C7
        plx
        plb
        .databank $9E
        plp
        rtl

        .databank 0

        ; 9E/80CB

    .endsection Unsorted9E805ESection


    .section Table9E80CBSection

      .al
      .xl

      aMapBattleFacingOffsets ; 9E/80CB

        ; Read by rlGetMapBattleFacing.

        .byte $00, $FE, $06, $FF, $FF, $05, $00, $FF, $06, $01, $FF, $07, $FE, $00, $04, $FF
        .byte $00, $04, $00, $00, $00, $01, $00, $00, $02, $00, $00, $FF, $01, $03, $00, $01
        .byte $02, $01, $01, $01, $00, $02, $02

        ; 9E/80F2

    .endsection Table9E80CBSection


    .section Unsorted9E80F2Section

      .al
      .xl

      rlGetMapBattleFacingByAngle ; 9E/80F2

        .al
        .xl
        .autsiz
        .databank ?

        lda wR0
        asl a
        asl a
        asl a
        asl a
        sta wR0
        lda wR1
        asl a
        asl a
        asl a
        asl a
        sta wR1
        jsl rlUnknown9FF3ED
        sec
        sbc #$0010
        and #$00FF
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda #$0007
        sec
        sbc wR0
        sta aMapAction.wUnknown7F455E
        rtl

        .databank 0

        ; 9E/811F

    .endsection Unsorted9E80F2Section


    .section Unsorted9E811FSection

      .al
      .xl

      rlSetMapMagicFlags ; 9E/811F

        .al
        .xl
        .autsiz
        .databank ?

        ; wMapMagicFlags: 0 when neither side's weapon plays an effect (no staff or tome, a magic sword at distance 1); $8000 in demo and scripted battles (wMapBattleMode not 0) or with no target; 1 on the castle screen; otherwise 1 plus the screen edges the units are near (within aMapMagicEdgeMargins tiles): $0100 the left, $0200 the right, $0400 the top.

        phy
        phx
        lda #$0000
        sta wMapMagicFlags
        lda wMapBattleMode
        beq _8139
        lda #$8000
        sta wMapMagicFlags
        jml _8268


        _8139
        lda aActionStructUnit1.WeaponID
        cmp #$FFFF
        beq _817A
        jsl rlGetItemDataROMPointer
        sta $7F57EA
        jsl rlGetItemWeaponType
        cmp #$0004
        bcs _81C5
        lda $7F57EA
        jsl rlGetItemWeaponTraits
        cmp #$0001
        beq _8171
        cmp #$0002
        beq _8171
        cmp #$0003
        beq _8171
        cmp #$0006
        beq _81C5
        bra _817A


        _8171
        lda wBattleDistance
        cmp #$0002
        bcs _81C5

        _817A
        lda aActionStructUnit2.WeaponID
        cmp #$FFFF
        bne _8187
        jml _8261


        _8187
        jsl rlGetItemDataROMPointer
        sta $7F57EA
        jsl rlGetItemWeaponType
        cmp #$0004
        bcs _81C5
        lda $7F57EA
        jsl rlGetItemWeaponTraits
        cmp #$0001
        beq _81B8
        cmp #$0002
        beq _81B8
        cmp #$0003
        beq _81B8
        cmp #$0006
        beq _81C5
        jml _8261


        _81B8
        lda wBattleDistance
        cmp #$0002
        bcs _81C5
        jml _8261


        _81C5
        lda aActionStructUnit2
        cmp #$FFFF
        bne _81D9
        lda #$8000
        sta wMapMagicFlags
        jml _8268


        _81D9
        lda wBattleType
        and #$00FF
        cmp #$0003
        bne _81EE
        lda #$0001
        sta wMapMagicFlags
        bra _8268


        _81EE
        jsl rlGetVisibleMapTileBounds
        lda aActionStructUnit1.XPosition
        sta wR4
        lda aActionStructUnit1.YPosition
        sta wR5
        lda aActionStructUnit2.XPosition
        sta wR6
        lda aActionStructUnit2.YPosition
        sta wR7
        lda wR0
        clc
        adc aMapMagicEdgeMargins
        cmp wR4
        bcs _8219
        cmp wR6
        bcc _8222

        _8219
        lda #$0101
        sta wMapMagicFlags
        bra _8238


        _8222
        lda wR1
        sec
        sbc aMapMagicEdgeMargins+2
        cmp wR4
        bcc _8231
        cmp wR6
        bcs _8238

        _8231
        lda #$0201
        sta wMapMagicFlags

        _8238
        lda wR2
        clc
        adc aMapMagicEdgeMargins+4
        cmp wR5
        bcs _8247
        cmp wR7
        bcc _8254

        _8247
        lda wMapMagicFlags
        ora #$0401
        sta wMapMagicFlags
        bra _8268


        _8254
        lda wMapMagicFlags
        ora #$0001
        sta wMapMagicFlags
        bra _8268


        _8261
        lda #$0000
        sta wMapMagicFlags

        _8268
        plx
        ply
        rtl

        .databank 0

        ; 9E/826B

    .endsection Unsorted9E811FSection


    .section Table9E826BSection

      .al
      .xl

      aMapMagicEdgeMargins ; 9E/826B

        ; Read by rlSetMapMagicFlags.

        .word $0005, $0006, $0006

        ; 9E/8271

    .endsection Table9E826BSection


    .section Unsorted9E8271Section

      .al
      .xl

      rlGetVisibleMapTileBounds ; 9E/8271

        .al
        .xl
        .autsiz
        .databank ?

        ; wR0-wR3 = the leftmost, rightmost, top and bottom map tiles on screen.

        phb
        phk
        plb
        .databank $9E
        lda wMapMinXScroll,b
        clc
        adc #$0010
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wMapMaxXScroll,b
        clc
        adc #$00E0
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        lda wMapMinYScroll,b
        clc
        adc #$0010
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR2
        lda wMapMaxYScroll,b
        clc
        adc #$00C0
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR3
        plb
        .databank $9E
        rtl

        .databank 0

        ; 9E/82AA

    .endsection Unsorted9E8271Section


    .section Unsorted9E82AASection

      .al
      .xl

      rlMapBattleSetRoundSpriteScripts ; 9E/82AA

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        phy
        phx
        lda #$0001
        sta $4584,b
        lda $4599,b
        sta $458A,b
        sta $4587,b
        lda $4598,b
        sta lR18
        lda $4599,b
        sta lR18+1
        lda @l aMapAction.wUnknown7F455E
        sta wR0
        lda $459E,b
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        sta $4BEB,b
        and #$0001
        and #$00FF
        jsr rsGetMapBattleRoundScripts
        stx $4589,b
        sty $4586,b
        lda $459C,b
        sta $4590,b
        sta $458D,b
        lda $459B,b
        sta lR18
        lda $459C,b
        sta lR18+1
        lda @l aMapAction.wUnknown7F4560
        sta wR0
        lda $459E,b
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        and #$00FF
        eor #$0001
        jsr rsGetMapBattleRoundScripts
        stx $458F,b
        sty $458C,b
        inc $459E,b
        plx
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/832C

    .endsection Unsorted9E82AASection


    .section Unsorted9E832CSection

      .al
      .xl

      rsGetMapBattleRoundScripts ; 9E/832C

        .al
        .xl
        .autsiz
        .databank ?

        ; X and Y = the sprite scripts for a round: by whether this side attacks, and the round's hit, miss and critical bits.

        and #$0001
        bne _8353
        lda @l wR0
        and #$0001
        bne _8343
        lda aBattleRoundsData._Entry[0],x
        and #$0020
        bne _834B

        _8343
        ldx #$000E
        ldy #$0010
        bra _8378


        _834B
        ldx #$0012
        ldy #$0014
        bra _8378


        _8353
        lda aBattleRoundsData._Entry[0],x
        and #$0008
        beq _836B
        lda #$0000
        sta aMapAction.wMapBattleRoundCounter
        ldx #$000A
        ldy #$000C
        bra _8378


        _836B
        lda #$0000
        sta aMapAction.wMapBattleRoundCounter
        ldx #$0006
        ldy #$0008

        _8378
        lda [lR18],y
        clc
        adc @l lR18
        pha
        txy
        lda [lR18],y
        clc
        adc @l lR18
        tax
        ply
        rts

        .databank 0

        ; 9E/838B

    .endsection Unsorted9E832CSection


    .section Unsorted9E838BSection

      .al
      .xl

      rlInitMapBattleCombatants ; 9E/838B

        .al
        .xl
        .autsiz
        .databank ?

        ; Fills aMapAction from the two action structs: each side's battle class sprite (rlGetMapBattleClassSprite), weapon type, tile position and facing, and clears the battle's flags.

        phx
        phy
        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0000
        sta $4580,b
        sta $4582,b
        sta $4584,b
        sta $4BE7,b
        sta $5091,b
        sta $5093,b
        sta $4C1B,b
        sta $4C1D,b
        sta $4C0B,b
        sta $4C0D,b
        sta $4C11,b
        sta $4C13,b
        lda #$FFFF
        sta $508B,b
        sta $508D,b
        sta $5089,b
        lda aActionStructUnit1.ClassID
        sta @l wR0
        lda aActionStructUnit1.Gender
        sta @l wR1
        lda aActionStructUnit1.CharacterID
        sta @l wR2
        jsl rlGetMapBattleClassSprite
        sta $454E,b
        lda aActionStructUnit1.XPosition
        sta $4552,b
        lda aActionStructUnit1.YPosition
        sta $4554,b
        jsl rlMapBattleCheckDance
        bcc _83FD
        jml _8504


        _83FD
        lda #$0000
        sta @l wR15
        lda $454E,b
        jsl rlCheckMapBattleBallistician
        bcs _845B
        lda aActionStructUnit1.WeaponID
        jsl rlGetClassMapBattleWeaponType
        bcs _845B
        lda aActionStructUnit1.Unknown
        tay
        lda aActionStructUnit1.WeaponID
        jsl rlGetMagicSwordMapEffect
        sta $508B,b
        lda wMapBattleStatusSword
        sta $7F4BED
        lda wMapBattleEarthSwordMelee
        sta $7F4C0B
        lda #$0000
        bcs _845B
        lda aActionStructUnit1.WeaponID
        jsl rlGetItemDataROMPointer
        jsl rlGetItemWeaponType
        cmp #$0004
        bcc _845B
        lda aActionStructUnit1.WeaponID
        sec
        sbc #$003E
        sta $508B,b
        lda #$0004

        _845B
        sta $454A,b
        lda aActionStructUnit2.ClassID
        sta @l wR0
        lda aActionStructUnit2.Gender
        sta @l wR1
        lda aActionStructUnit2.CharacterID
        sta @l wR2
        jsl rlGetMapBattleClassSprite
        sta $4550,b
        lda aActionStructUnit2
        cmp #$FFFF
        bne _848E
        lda #$0006
        sta $455E,b
        bra _8504


        _848E
        lda aActionStructUnit2.XPosition
        sta $4556,b
        lda aActionStructUnit2.YPosition
        sta $4558,b
        lda #$0001
        sta @l wR15
        lda $4550,b
        jsl rlCheckMapBattleBallistician
        bcs _84FA
        lda aActionStructUnit2.WeaponID
        jsl rlGetClassMapBattleWeaponType
        bcs _84FA
        lda aActionStructUnit2.Unknown
        tay
        lda aActionStructUnit2.WeaponID
        jsl rlGetMagicSwordMapEffect
        sta $508D,b
        lda wMapBattleStatusSword
        sta $7F4BEF
        lda wMapBattleEarthSwordMelee
        sta $7F4C0D
        lda #$0000
        bcs _84FA
        lda aActionStructUnit2.WeaponID
        jsl rlGetItemDataROMPointer
        jsl rlGetItemWeaponType
        cmp #$0004
        bcc _84FA
        lda aActionStructUnit2.WeaponID
        sec
        sbc #$003E
        sta $508D,b
        lda #$0004

        _84FA
        sta $454C,b
        jsl rlGetMapBattleFacing
        lda $455E,b

        _8504
        eor #$0004
        sta $4560,b
        lda wBattleType
        and #$00FF
        cmp #$0003
        bne _8526
        lda #$0006
        sta $455E,b
        sta $4560,b
        lda #$0000
        sta @l $000891

        _8526
        plb
        .databank ?
        ply
        plx
        rtl

        .databank 0

        ; 9E/852A

      rlMapBattleCheckDance ; 9E/852A

        .al
        .xl
        .autsiz
        .databank ?

        ; wR0 = class: for a Dancer (class $32) dancing (aActionStructUnit1.Unknown 8) or with no target, sets aMapAction up for mode 4 (no magic effects) and returns carry set; carry clear otherwise.

        phb
        phy
        phx
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda wR0
        cmp #$0032
        bne _8578
        lda aActionStructUnit1.Unknown
        cmp #$0008
        beq _854B
        lda aActionStructUnit2
        cmp #$FFFF
        bne _8578

        _854B
        lda #$0004
        sta $454A,b
        lda #$FFFF
        sta $508B,b
        sta $508D,b
        sta $4550,b
        lda #$0000
        sta $4556,b
        sta $4558,b
        sta $454C,b
        lda #$0001
        sta $4BE7,b
        lda #$0006
        sta $455E,b
        sec
        bra _8579


        _8578
        clc

        _8579
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/857D

      rlCheckMapBattleBallistician ; 9E/857D

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set when the class in wR0 is a ballistician ($43-$46): marks side wR15 as firing a ballista bolt (procMapBattleBallistaBolt).

        phy
        phx
        lda @l wR0
        cmp #$0043
        bcc _85A0
        cmp #$0047
        bcs _85A0
        lda @l wR15
        asl a
        tax
        lda #$0001
        sta $7F4C11,x
        lda #$0003
        sec
        bra _85A1


        _85A0
        clc

        _85A1
        plx
        ply
        rtl

        .databank 0

        ; 9E/85A4

    .endsection Unsorted9E838BSection


    .section Unsorted9E85A4Section

      .al
      .xl

      rlGetMapBattleClassSprite ; 9E/85A4

        .al
        .autsiz
        .databank ?

        ; A = the class whose map battle sprite a unit uses (wR0 class, wR1 gender, wR2 character): Seliph as a Knight Lord has his own ($5D); classes with an entry in aMapBattleFemaleClassSprites use it for female units.

        ; Get gendered battle sprite?

        ; wR0 = ClassID
        ; wR1 = Gender
        ; wR2 = CharacterID

        phx
        phy
        lda wR0
        cmp #KnightLord
        bne +

          lda wR2
          cmp #Seliph
          bne +

            lda #$005D
            bra _End

        +
        asl a
        tax
        lda aMapBattleFemaleClassSprites,x
        cmp #$FFFF
        bne +

          lda wR0
          bra _End

        +
        lda wR1
        dec a
        beq +

          lda wR0
          bra _End

        +
        lda wR0
        asl a
        tax
        lda aMapBattleFemaleClassSprites+1,x
        and #$00FF

        _End
        ply
        plx
        rtl

        .databank 0

    .endsection Unsorted9E85A4Section


    .section Unsorted9E85DFSection

      .al
      .xl

      aMapBattleFemaleClassSprites ; 9E/85DF

        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte MasterKnight, $48
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte MageKnight, $49
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte Dragonrider, $4A
        .byte Dragonknight, $4B
        .byte Dragonmaster, $4C
        .byte Archer, $4D
        .byte Myrmidon, $4E
        .byte Swordmaster, $4F
        .byte Sniper, $50
        .byte Hero, $51
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte Priest, $52
        .byte Mage, $53
        .byte FireMage, $54
        .byte ThunderMage, $55
        .byte WindMage, $56
        .byte HighPriest, $57
        .byte $FF, $FF
        .byte Sage, $58
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte Thief, $59
        .byte Rogue, $5A
        .byte Civilian, $5B
        .byte Child, $5C
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF

      rlGetClassMapBattleWeaponType ; 9E/866F

        .al
        .autsiz
        .databank ?

        ; Get class' main battle weapon type
        ; 0 = sword
        ; 1 = lance
        ; 2 = axe
        ; 3 = bow
        ; 4 = magic

        phy
        phx
        cmp #$FFFF
        bne _CLC

          lda wR0
          tax
          lda aClassMapBattleWeaponTypes,x
          and #$00FF
          sec
          bra +

        _CLC
        clc

        +
        plx
        ply
        rtl

        .databank 0

      aClassMapBattleWeaponTypes ; 9E/8687

        .byte 1 ; Cavalier
        .byte 1 ; LanceKnight
        .byte 3 ; BowKnight
        .byte 2 ; AxeKnight
        .byte 0 ; FreeKnight
        .byte 0 ; Troubadour
        .byte 0 ; KnightLord
        .byte 1 ; DukeKnight
        .byte 0 ; MasterKnight
        .byte 1 ; Paladin
        .byte 1 ; PaladinF
        .byte 3 ; ArchKnight
        .byte 0 ; Ranger
        .byte 1 ; MageKnight
        .byte 2 ; GreatKnight
        .byte 0 ; PegasusRider
        .byte 0 ; PegasusKnight
        .byte 0 ; FalconKnight
        .byte 1 ; Dragonrider
        .byte 1 ; Dragonknight
        .byte 1 ; Dragonmaster
        .byte 3 ; Archer
        .byte 0 ; Myrmidon
        .byte 0 ; Swordmaster
        .byte 3 ; Sniper
        .byte 0 ; Hero
        .byte 1 ; General
        .byte 1 ; Emperor
        .byte 1 ; Baron
        .byte 1 ; Soldier
        .byte 1 ; SpearSoldier
        .byte 2 ; AxeSoldier
        .byte 3 ; BowSoldier
        .byte 0 ; SwordSoldier
        .byte 1 ; LanceArmor
        .byte 2 ; AxeArmor
        .byte 3 ; BowArmor
        .byte 0 ; SwordArmor
        .byte 2 ; Barbarian
        .byte 2 ; Fighter
        .byte 2 ; Brigand
        .byte 2 ; Warrior
        .byte 3 ; Hunter
        .byte 2 ; Pirate
        .byte 0 ; JuniorLord
        .byte 0 ; WarMage
        .byte 0 ; Prince
        .byte 0 ; Princess
        .byte 4 ; WarMageF
        .byte 4 ; Queen
        .byte 0 ; Dancer
        .byte 4 ; Priest
        .byte 4 ; Mage
        .byte 4 ; FireMage
        .byte 4 ; ThunderMage
        .byte 4 ; WindMage
        .byte 4 ; HighPriest
        .byte 4 ; Bishop
        .byte 4 ; Sage
        .byte 4 ; Bard
        .byte 4 ; Priestess
        .byte 4 ; DarkMage
        .byte 4 ; DarkBishop
        .byte 0 ; Thief
        .byte 0 ; Rogue
        .byte 0 ; Civilian
        .byte 0 ; Child
        .byte 3 ; Ballistician
        .byte 3 ; IronBallistician
        .byte 3 ; KillerBallistician
        .byte 3 ; GreatBallistician
        .byte 4 ; DarkPrince

      ; 9E/86CF

    .endsection Unsorted9E85DFSection


    .section Unsorted9E86CFSection

      .al
      .xl

      rlGetMagicSwordMapEffect ; 9E/86CF

        .al
        .xl
        .autsiz
        .databank ?

        ; A = weapon: carry set and wR0 = the map magic effect a sword plays (item minus Fire). The ranged magic swords and the Earth Sword at distance 2 or more play their tome's effect (aMagicSwordMapEffectItems); at distance 1 the Earth Sword sets wMapBattleEarthSwordMelee instead. The Berserk, Silence and Sleep Swords play their staff's (aStatusSwordMapEffectItems) and keep their index in wMapBattleStatusSword. $FFFF for others; carry clear for a weapon that is not a sword.

        phx
        phy
        sta $7F57EE
        tya
        sta $7F57F0
        lda #$FFFF
        sta wMapBattleStatusSword
        lda #$0000
        sta wMapBattleEarthSwordMelee
        lda $7F57EE
        jsl rlGetItemDataROMPointer
        sta $7F57EA
        jsl rlGetItemWeaponType
        sta $7F57EC
        cmp #WeaponTypeSword
        beq _8705
        jml _878B


        _8705
        lda $7F57EA
        jsl rlGetItemWeaponTraits
        cmp #$0001
        beq _8726
        cmp #$0002
        beq _8726
        cmp #$0003
        beq _8726
        cmp #$0006
        beq _875C

        _8721
        lda #$FFFF
        bra _8782


        _8726
        lda wBattleDistance
        dec a
        bne _873F
        lda $7F57EE
        cmp #$0010
        bne _8721
        lda #$0001
        sta wMapBattleEarthSwordMelee
        bra _8721


        _873F
        jsl rlSetMapMagicFlags
        lda $7F57EE
        sec
        sbc #$000F
        cmp #$0005
        bcs _8782
        asl a
        tax
        lda aMagicSwordMapEffectItems,x
        sec
        sbc #$003E
        bra _8782


        _875C
        jsl rlSetMapMagicFlags
        lda $7F57EE
        sec
        sbc #$0009
        cmp #$0004
        bcs _8782
        cmp #$0001
        beq _8782
        sta wMapBattleStatusSword
        asl a
        tax
        lda aStatusSwordMapEffectItems,x
        bmi _8782
        sec
        sbc #$003E

        _8782
        sta wR0
        lda wR0
        bmi _878F
        sec
        bra _878F


        _878B
        lda #$FFFF
        clc

        _878F
        ply
        plx
        rtl

        .databank 0

        ; 9E/8792

    .endsection Unsorted9E86CFSection


    .section Table9E8792Section

      .al
      .xl

      aMagicSwordMapEffectItems ; 9E/8792

        ; Read by rlGetMagicSwordMapEffect: the tome whose effect each magic sword
        ; plays, by item ID minus FireSword.

        .word $003F ; FireSword: Elfire
        .word $004E ; EarthSword: Nosferatu
        .word $0044 ; ThunderSword: Elthunder
        .word $0049 ; WindSword: Elwind
        .word $004D ; LightBrand: Light

        ; 9E/879C

    .endsection Table9E8792Section


    .section Table9E879CSection

      .al
      .xl

      aStatusSwordMapEffectItems ; 9E/879C

        ; Read by rlGetMagicSwordMapEffect: the staff whose effect each status
        ; sword plays, by item ID minus BerserkSword.

        .word $0065 ; BerserkSword: BerserkStaff
        .word $FFFF ; BraveSword: none
        .word $0063 ; SilenceSword: SilenceStaff
        .word $0064 ; SleepSword: SleepStaff

        ; 9E/87A4

    .endsection Table9E879CSection


    .section Unsorted9E87A4Section

      .al
      .xl

      rlSelectMapBattleAttackerSprite ; 9E/87A4

        .al
        .autsiz
        .databank ?

        phb
        pea #$7F00
        plb
        plb

        lda $454E,b
        sta $4568,b
        lda $454A,b
        sta $4566,b
        lda $454E,b
        sta $456E,b
        lda $455E,b
        sta $4570,b
        lda #0
        sta $4576,b
        plb
        rtl

        .databank 0

        ; 9E/87CA

    .endsection Unsorted9E87A4Section


    .section Unsorted9E87CASection

      .al
      .xl

      rlSelectMapBattleDefenderSprite ; 9E/87CA

        .al
        .xl
        .autsiz
        .databank ?

        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda $4550,b
        sta $4568,b
        lda $454C,b
        sta $4566,b
        lda $4550,b
        sta $456E,b
        lda $4560,b
        sta $4570,b
        lda #$0001
        sta $4576,b
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/87F0

      rlMapBattleSetSpriteScripts ; 9E/87F0

        .al
        .xl
        .autsiz
        .databank ?

        ; A = side (0 or 1): sets wMapBattleAttackVariant from byte $30 of the class's aBattleMapSpriteData entry, and points the attacker and aux sprite script pointers into the side's decompressed sprite data (aMapBattleSpriteBufferOffsets) by wMapBattleTerrainMode.

        phb
        phy
        phx
        sta wR0
        lda aMapAction.wMapBattleClassSpriteID
        sta wR10
        lda #$0031
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda #$9E00
        sta lR18+1
        lda #$B50D
        clc
        adc wR12
        sta lR18
        ldy #$0030
        lda [lR18],y
        and #$00FF
        sta aMapAction.wMapBattleAttackVariant
        lda wR0
        asl a
        tax
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc aMapBattleSpriteBufferOffsets,x
        sta lR18
        lda lR18+1
        sta aMapAction.lMapBattleAttackerSpriteScriptPointer+1
        sta aMapAction.lMapBattleAuxSpriteScriptPointer+1
        lda aMapAction.wMapBattleTerrainMode
        asl a
        tay
        lda [lR18],y
        clc
        adc lR18
        sta lR18
        ldy #$0006
        lda [lR18],y
        clc
        adc lR18
        sta aMapAction.lMapBattleAttackerSpriteScriptPointer
        ldy #$0008
        lda [lR18],y
        clc
        adc lR18
        sta aMapAction.lMapBattleAuxSpriteScriptPointer
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/8863

    .endsection Unsorted9E87CASection


    .section Table9E8863Section

      .al
      .xl

      aMapBattleSpriteBufferOffsets ; 9E/8863

        ; Read by rlMapBattleSetSpriteScripts.

        .word $6000, $6880

        ; 9E/8867

    .endsection Table9E8863Section


    .section Unsorted9E8867Section

      .al
      .xl

      rlMapBattleQueueSpriteData ; 9E/8867

        .al
        .autsiz
        .databank ?

        ; A = side: queues the decompression of the class's sprite data for its weapon (aBattleMapSpriteData) to aDecompressionBuffer + $6000, or + $6880 for side 1.

        phb
        phy
        phx
        sta $00
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda @l aMapAction.wMapBattleWeaponAnimIndex
        asl a
        clc
        adc @l aMapAction.wMapBattleWeaponAnimIndex
        asl a
        sta wR1
        lda @l aMapAction.wMapBattleClassSpriteID
        sta wR10
        lda #49
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        clc
        adc wR1
        tax
        lda aBattleMapSpriteData+1,x
        sta lR18+1
        lda aBattleMapSpriteData,x
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$6000
        sta lR19

        lda wR0
        beq +

          lda #(`aDecompressionBuffer)<<8
          sta lR19+1
          lda #<>aDecompressionBuffer
          clc
          adc #$6880
          sta lR19

        +
        plp
        plb
        jsl rlAppendDecompList
        plx
        ply
        plb
        rtl

        .databank 0

    .endsection Unsorted9E8867Section


    .section Unsorted9E88CESection

      .al
      .xl

      rlUnknown9E88CE ; 9E/88CE

        .al
        .autsiz
        .databank ?

        phx
        ldx #2

          -
          lda aUnknown9E88F4,x
          sta $7EFC88,x
          sta $7EFC8E,x
          sta $7EFC94,x
          sta $7EFC9A,x
          dec x
          dec x
          bpl -

        lda aUnknown9E88F4 + 4
        sta $7EFCA0
        plx
        rtl

        .databank 0

    .endsection Unsorted9E88CESection


    .section Unsorted9E88F4Section

      .al
      .xl

      aUnknown9E88F4 ; 9E/88F4

        .word $FCA0
        .word $FCA0
        .byte $6B

      rlUnknown9E88F9 ; 9E/88F9

        ; Pushes X and runs on into rlUnknown9E88FA.
        .al
        .xl
        .autsiz
        .databank ?

        phx

        .databank 0

    .endsection Unsorted9E88F4Section


    .section Unsorted9E88FASection

      .al
      .xl

      rlUnknown9E88FA ; 9E/88FA

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phy
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda @l $7F4BE7
        beq _8929
        lda #$213F
        sta @l $000224
        lda #$0002
        sta @l $000226
        lda #$AC00
        sta @l lR18+1
        lda #$C8C3
        sta @l lR18
        bra _895A


        _8929
        lda @l aMapAction.wUnknown7F455E
        asl a
        clc
        adc @l aMapAction.wUnknown7F455E
        asl a
        sta wR0
        lda @l aMapAction.wBattleClassID
        sta wR10
        lda #$0031
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        clc
        adc wR0
        adc #$0003
        tax
        lda aBattleMapSpriteData+1,x
        sta lR18+1
        lda aBattleMapSpriteData,x
        sta lR18

        _895A
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$0000
        sta lR19
        plp
        plb
        .databank $7F
        jsl rlAppendDecompList
        lda aActionStructUnit2
        cmp #$FFFF
        beq _89EE
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda @l aMapAction.wUnknown7F4560
        asl a
        clc
        adc @l aMapAction.wUnknown7F4560
        asl a
        sta wR0
        lda @l aMapAction.wUnknown7F4450
        sta wR10
        lda #$0031
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        clc
        adc wR0
        adc #$0003
        tax
        lda aBattleMapSpriteData+1,x
        sta lR18+1
        lda aBattleMapSpriteData,x
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$2000
        sta lR19
        plp
        plb
        .databank $7F
        jsl rlAppendDecompList
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda #(`gcUnknownACCC17)<<8
        sta lR18+1
        lda #<>gcUnknownACCC17
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$4000
        sta lR19
        plp
        plb
        .databank $7F
        jsl rlAppendDecompList

        _89EE
        ply
        plx
        rtl

        .databank 0

        ; 9E/89F1

    .endsection Unsorted9E88FASection


    .section Unsorted9E89F1Section

      .al
      .xl

      rlCreateMapBattleAttackerSprites ; 9E/89F1

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $9E
        phy
        phx
        jsl rlSelectMapBattleAttackerSprite
        lda #$0000
        jsl rlMapBattleSetSpriteScripts
        lda lR18
        sta aMapAction.lUnknown7F4598
        lda lR18+1
        sta aMapAction.lUnknown7F4598+1
        lda wBattleType
        and #$00FF
        cmp #$0003
        beq _8A2D
        lda wMapBattleMode
        and #$0001
        bne _8A35
        lda aActionStructUnit1
        tax
        jsl rlDeployedUnitSetHidden
        bra _8A35


        _8A2D
        lda aActionStructUnit1
        jsl rlUnknown9EAC0E

        _8A35
        lda wMapBattleMode
        bne _8A51
        lda aActionStructUnit1
        tax
        lda aDeploymentTable,x
        and #$0003
        sta aMapAction.wUnknown7F4562
        sta aMapAction.wUnknown7F4574
        bra _8A59


        _8A51
        lda aMapAction.wUnknown7F4562
        sta aMapAction.wUnknown7F4574

        _8A59
        jsl rlUnknown9E8D6C
        jsl rlUnknown9E8DBB
        lda aActionStructUnit1.WeaponID
        jsl rlUnknown9E8E01
        lda aMapAction.wXTilePosition
        tax
        lda aMapAction.wYTilePosition
        tay
        lda aActionStructUnit1.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda wR0
        and #$00FF
        sta aMapAction.wMapBattleAttackerXPixel
        lda wR1
        and #$00FF
        sta aMapAction.wMapBattleAttackerYPixel
        lda #$7E00
        sta lR44+1
        lda #$FC88
        sta lR44
        lda aMapAction.lMapBattleAttackerSpriteScriptPointer
        sta $7EFC8C
        lda #$FC88
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta aMapAction.wMapBattleAttackerSpriteSlot
        lda aMapAction.wUnknown7F4576
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda aMapAction.wMapBattleAttackVariant
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda aMapAction.wUnknown7F4562
        inc a
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda aMapAction.wUnknown7F4576
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda aMapAction.wMapBattleAttackVariant
        bne _8AE1
        lda $7F4C11
        bne _8AE1
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001280,b,x

        _8AE1
        lda aMapAction.wMapBattleAttackVariant
        beq _8B30
        lda $7F4C11
        bne _8B30
        lda aMapAction.wMapBattleTerrainMode
        cmp #$0004
        bcs _8B30
        lda #$7E00
        sta lR44+1
        lda #$FC8E
        sta lR44
        lda aMapAction.lMapBattleAuxSpriteScriptPointer
        sta $7EFC92
        lda #$FC8E
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta aMapAction.wMapBattleAttackerAuxSpriteSlot
        lda #$0020
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda aMapAction.wUnknown7F4562
        inc a
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda aMapAction.wUnknown7F4576
        sta aActiveSpriteSystem.aUnknown001320,b,x

        _8B30
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/8B34

      rlCreateMapBattleDefenderSprites ; 9E/8B34

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $9E
        phy
        phx
        jsl rlSelectMapBattleDefenderSprite
        lda aActionStructUnit2
        cmp #$FFFF
        bne _8B4A
        jml _8C7D


        _8B4A
        lda #$0001
        jsl rlMapBattleSetSpriteScripts
        lda lR18
        sta aMapAction.lUnknown7F459B
        lda lR18+1
        sta aMapAction.lUnknown7F459B+1
        lda wBattleType
        and #$00FF
        cmp #$0003
        beq _8B74
        lda aActionStructUnit2
        tax
        jsl rlDeployedUnitSetHidden
        bra _8B7C


        _8B74
        lda aActionStructUnit2
        jsl rlUnknown9EAC0E

        _8B7C
        lda wMapBattleMode
        bne _8B98
        lda aActionStructUnit2
        tax
        lda aDeploymentTable,x
        and #$0003
        sta aMapAction.wDefenderAllegiance
        sta aMapAction.wUnknown7F4574
        bra _8BA0


        _8B98
        lda aMapAction.wDefenderAllegiance
        sta aMapAction.wUnknown7F4574

        _8BA0
        jsl rlUnknown9E8D6C
        jsl rlUnknown9E8DBB
        lda aActionStructUnit2.WeaponID
        jsl rlUnknown9E8E01
        lda aMapAction.wUnknown7F4556
        tax
        lda aMapAction.wUnknown7F4558
        tay
        lda aActionStructUnit2.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda wR0
        and #$00FF
        sta aMapAction.wUnknown7F457C
        lda wR1
        and #$00FF
        sta aMapAction.wUnknown7F457E
        lda #$7E00
        sta lR44+1
        lda #$FC94
        sta lR44
        lda aMapAction.lMapBattleAttackerSpriteScriptPointer
        sta $7EFC98
        lda #$FC94
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta aMapAction.wMapBattleDefenderSpriteSlot
        lda #$0008
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda aMapAction.wUnknown7F4576
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda aMapAction.wMapBattleAttackVariant
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda aMapAction.wDefenderAllegiance
        inc a
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda aMapAction.wUnknown7F4576
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda $7F4C13
        bne _8C28
        lda aMapAction.wMapBattleAttackVariant
        bne _8C2E

        _8C28
        lda #$0020
        sta aActiveSpriteSystem.aUnknown001280,b,x

        _8C2E
        lda aMapAction.wMapBattleAttackVariant
        beq _8C7D
        lda $7F4C13
        bne _8C7D
        lda aMapAction.wMapBattleTerrainMode
        cmp #$0004
        bcs _8C7D
        lda #$7E00
        sta lR44+1
        lda #$FC9A
        sta lR44
        lda aMapAction.lMapBattleAuxSpriteScriptPointer
        sta $7EFC9E
        lda #$FC9A
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta aMapAction.wMapBattleDefenderAuxSpriteSlot
        lda #$0040
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda aMapAction.wDefenderAllegiance
        inc a
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda aMapAction.wUnknown7F4576
        sta aActiveSpriteSystem.aUnknown001320,b,x

        _8C7D
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/8C81

      rlUnknown9E8C81 ; 9E/8C81

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta wMapMagicStart
        jsr rsUnknown9E8CED
        lda aMapAction.wMapBattleAttackerYPixel
        xba
        ora aMapAction.wMapBattleAttackerXPixel
        sta wR0
        lda aMapAction.wUnknown7F457E
        xba
        ora aMapAction.wUnknown7F457C
        sta wR1
        lda #$0000
        sta $7F509F
        lda aActionStructUnit2
        cmp #$FFFF
        bne _8CBE
        lda wR0
        sta wMapMagicCasterPixel
        sta wMapMagicTargetPixel
        bra _8CEB


        _8CBE
        lda aMapAction.wMapBattleRoundIndex
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        sta $7F4BEB
        and #$0001
        bne _8CDF
        lda wR0
        sta wMapMagicCasterPixel
        lda wR1
        sta wMapMagicTargetPixel
        bra _8CEB


        _8CDF
        lda wR1
        sta wMapMagicCasterPixel
        lda wR0
        sta wMapMagicTargetPixel

        _8CEB
        plx
        rtl

        .databank 0

        ; 9E/8CED

      rsUnknown9E8CED ; 9E/8CED

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$FFFF
        sta $7F509D
        lda wMapMagicAttackerEffect
        cmp #$0021
        bne _8D23
        lda $7E4F77
        tax
        lda $7E4F79
        tay
        lda aActionStructUnit2.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        xba
        ora wR0
        sta $7F509D

        _8D23
        plx
        rts

        .databank 0

        ; 9E/8D25

    .endsection Unsorted9E89F1Section


    .section Unsorted9E8D25Section

      .al
      .xl

      rlUnknown9E8D25 ; 9E/8D25

        .al
        .autsiz
        .databank ?

        sta wR0
        lda wBattleType
        and #$00FF
        cmp #3
        beq +

          txa
          asl a
          asl a
          asl a
          asl a
          clc
          adc #8
          sec
          sbc wMapScrollXPixels,b
          sta wR0

          tya
          asl a
          asl a
          asl a
          asl a
          clc
          adc #8
          sec
          sbc wMapScrollYPixels,b
          sta wR1
          rtl

        +
        lda wR0
        sta wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitGenerationID
        dec a
        asl a
        tax
        lda $7F75DA,x
        sta wR0
        lda $7F760A,x
        sta wR1
        rtl

        .databank 0

        ; 9E/8D6C

    .endsection Unsorted9E8D25Section


    .section Unsorted9E8D6CSection

      .al
      .xl

      rlUnknown9E8D6C ; 9E/8D6C

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $9E
        phy
        phx
        lda aMapAction.wMapBattleTerrainMode
        asl a
        tay
        lda $B4CD,b,y
        sta wR2
        lda aMapAction.wUnknown7F4576
        asl a
        tay
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc wR2
        adc $B4C9,b,y
        sta lR18
        lda #$0400
        sta wR0
        lda aMapAction.wUnknown7F4576
        asl a
        tax
        lda @l aUnknown9EB4DB,x
        sta wR2
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc wR2
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/8DBB

      rlUnknown9E8DBB ; 9E/8DBB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        phk
        plb
        .databank $9E
        lda aMapAction.wUnknown7F4576
        asl a
        tax
        lda @l aUnknown9EB4C9,x
        sta wR2
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$1000
        adc wR2
        sta lR18
        lda @l aUnknown9EB4D7,x
        sta wR2
        lda aMapAction.wMapBattleAttackVariant
        and #$00FF
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc wR2
        sta wR1
        jsl rlUploadMapSpriteFrame
        plb
        .databank $9E
        plx
        rtl

        .databank 0

        ; 9E/8E01

      rlUnknown9E8E01 ; 9E/8E01

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        cmp #$FFFF
        bne _8E0C
        jml _8EC1


        _8E0C
        cmp #$007A
        bcs _8E23
        cmp #$007D
        bcc _8E1A
        jml _8EC1


        _8E1A
        cmp #$003A
        bcc _8E23
        jml _8EC1


        _8E23
        cmp #$007A
        bcc _8E30
        sec
        sbc #$007A
        clc
        adc #$003A

        _8E30
        sta $7F57EA
        asl a
        tax
        lda aUnknown9E8EC4,x
        and #$00FF
        xba
        sta wR2
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$4000
        adc wR2
        sta lR18
        lda #$0080
        sta wR0
        lda aMapAction.wUnknown7F4576
        asl a
        tax
        lda aUnknown9EB4DB,x
        sta wR2
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc wR2
        sta wR1
        jsl rlDMAByPointer
        lda lR18
        clc
        adc #$0080
        sta lR18
        lda wR1
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        lda $7F57EA
        asl a
        tax
        lda aUnknown9E8EC4,x
        and #$FF00
        xba
        asl a
        asl a
        tax
        lda aUnknown9E8F3E,x
        pha
        inc x
        inc x
        lda aUnknown9E8F3E,x
        pha
        lda aMapAction.wUnknown7F4574
        inc a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$0006
        tax
        pla
        sta @l aOAMPaletteBuffer,x
        dec x
        dec x
        pla
        sta @l aOAMPaletteBuffer,x

        _8EC1
        ply
        plx
        rtl

        .databank 0

        ; 9E/8EC4

    .endsection Unsorted9E8D6CSection


    .section Table9E8EC4Section

      .al
      .xl

      aUnknown9E8EC4 ; 9E/8EC4

        ; Read by rlUnknown9E8E01.

        .word $0200, $0000, $0900, $0205, $0005, $0905, $0607, $0608
        .word $0408, $0102, $0804, $0302, $0002, $0007, $0807, $0103
        .word $0203, $0403, $0003, $0603, $0706, $0806, $0509, $0104
        .word $0004, $0301, $0301, $0301, $020A, $000A, $090A, $020C
        .word $040C, $090F, $060C, $0A0D, $010E, $020B, $020B, $020B
        .word $0210, $0010, $0910, $0114, $0013, $0212, $0311, $0311
        .word $0311, $0216, $0016, $0916, $0019, $0118, $0417, $0315
        .word $0315, $0315, $0301, $020B, $0315

        ; 9E/8F3E

    .endsection Table9E8EC4Section


    .section Table9E8F3ESection

      .al
      .xl

      aUnknown9E8F3E ; 9E/8F3E

        ; Read by rlUnknown9E8E01.

        .word $6481, $1F19, $213F, $03A0, $2DD2, $6E10, $2D6B, $08B1
        .word $0B7F, $013E, $6481, $0197, $03E0, $0D23, $213F, $0197
        .word $0B7F, $0197, $7FFF, $6E10, $001B, $1E9C

        ; 9E/8F6A

    .endsection Table9E8F3ESection


    .section Unsorted9E8F6ASection

      .al
      .xl

      rlUnknown9E8F6A ; 9E/8F6A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aMapAction.wMapBattlePhaseFlag
        lda aUnknown9E8FB2
        sta $7EFCA1
        lda #$7E00
        sta aMapAction.lUnknown7F4586+1
        lda #$FCA1
        sta aMapAction.lUnknown7F4586
        lda #$7E00
        sta aMapAction.lUnknown7F4589+1
        lda #$FCA1
        sta aMapAction.lUnknown7F4589
        lda #$7E00
        sta aMapAction.lUnknown7F458C+1
        lda #$FCA1
        sta aMapAction.lUnknown7F458C
        lda #$7E00
        sta aMapAction.lUnknown7F458F+1
        lda #$FCA1
        sta aMapAction.lUnknown7F458F
        rtl

        .databank 0

        ; 9E/8FB2

    .endsection Unsorted9E8F6ASection


    .section Table9E8FB2Section

      .al
      .xl

      aUnknown9E8FB2 ; 9E/8FB2

        ; Read by rlUnknown9E8F6A.

        .byte $01

        ; 9E/8FB3

    .endsection Table9E8FB2Section


    .section Unsorted9E8FB3Section

      .al
      .xl

      rlEndMapBattleRestoreMap ; 9E/8FB3

        .al
        .xl
        .autsiz
        .databank ?

        ; Shows the hidden units again (unless dead), applies a queued relocation, resumes the map sprite and tile animations.

        phx
        lda #$0001
        sta aMapAction.wMapBattlePhaseFlag
        lda $7F4C31
        beq _8FD0
        lda aActionStructUnit1
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive
        lda $7F4C31
        bpl _8FEA

        _8FD0
        jsl rlCheckQueuedRelocationMovesUnit
        stz wR15
        rol wR15
        lda wR15
        bne _8FEA
        lda aActionStructUnit2
        cmp #$FFFF
        beq _8FEA
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive

        _8FEA
        plx
        jsl rlResumeMapSpriteAnimation
        lda wBattleType
        and #$00FF
        cmp #$0003
        beq _9007
        lda wMapBattleMode
        bne _900B
        jsl rlResumeMapTileAnimation
        bra _900B


        _9007
        jsl rlUnknown9EAC1D

        _900B
        lda #(`rlPushToOAMBuffer)<<8
        sta $15E5,b
        lda #<>rlPushToOAMBuffer
        sta $15E4,b
        lda $7F4BD9
        sta aActiveSpriteSystem,b
        jsl rlDisableOAMScanlineFlicker
        stz wBufferBG3VOFS
        rtl

        .databank 0

        ; 9E/9025

      rlMapBattleRoundStep ; 9E/9025

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        stx wR0
        lda $7F4BEB
        bit #$0008
        beq _9041
        lda aMapAction.wMapBattleRoundCounter
        cmp #$FFFF
        beq _9071
        jsl rlMapBattlePlayLordDodgeSound
        bra _9071


        _9041
        bit #$0002
        beq _904E
        xba
        and #$00FF
        beq _9071
        bra _906B


        _904E
        xba
        and #$00FF
        beq _905D
        lda $7F4BEB
        bit #$0004
        beq _906B

        _905D
        jsl rlMapBattleRunRecoil
        lda $7F4BEB
        xba
        and #$00FF
        beq _9071

        _906B
        ldx wR0
        jsl rlMapBattleRunHitFlash

        _9071
        plx
        ply
        rtl

        .databank 0

        ; 9E/9074

      rlMapBattleRunRecoil ; 9E/9074

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame of a struck round: moves the defender's sprites by aUnknown9E9123 (damage) or aUnknown9E914B (none, which ends with rlMapBattlePlayNoDamageSound), and applies the HP at step 5 (rlApplyMapBattleRoundHP).

        phy
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        phx
        lda @l aMapAction.wMapBattleActiveSpriteSyncFlag
        bne _908A
        jml _911E


        _908A
        lda @l $001057,x
        dec a
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        eor #$0001
        asl a
        asl a
        tay
        lda @l aMapAction.wMapBattleRoundCounter
        bmi _911E
        cmp #$0004
        bcc _9100
        asl a
        tax
        lda @l $7F4BEB
        xba
        and #$00FF
        beq _90C0
        lda aUnknown9E9123,x
        cmp #$8000
        bne _90DD
        bra _90D4


        _90C0
        lda aUnknown9E914B,x
        cmp #$8000
        bne _90DD
        lda #$0000
        sta @l aMapAction.wMapBattleActiveSpriteSyncFlag
        jsl rlMapBattlePlayNoDamageSound

        _90D4
        lda #$FFFF
        sta @l aMapAction.wMapBattleRoundCounter
        bra _911E


        _90DD
        sta wR1
        ldx $45A4,b,y
        clc
        adc @l $001200,x
        sta @l $001200,x
        inc y
        inc y
        ldx $45A4,b,y
        cpx #$FFFF
        beq _9100
        lda wR1
        clc
        adc @l $001200,x
        sta @l $001200,x

        _9100
        inc $45A2,b
        lda @l aMapAction.wMapBattleRoundCounter
        cmp #$0005
        bne _911E
        plx
        plp
        plb
        .databank ?
        jsl rlApplyMapBattleRoundHP
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        phx

        _911E
        plx
        plp
        plb
        .databank ?
        ply
        rtl

        .databank 0

        ; 9E/9123

    .endsection Unsorted9E8FB3Section


    .section Table9E9123Section

      .al
      .xl

      aUnknown9E9123 ; 9E/9123

        ; Read by rlMapBattleRunRecoil.

        .word $0000, $0000, $0000, $0000, $FFFF, $0003, $FFFD, $0003
        .word $FFFD, $0003, $FFFD, $0003, $FFFD, $0003, $FFFD, $0003
        .word $FFFD, $0003, $FFFE, $8000

        ; 9E/914B

    .endsection Table9E9123Section


    .section Table9E914BSection

      .al
      .xl

      aUnknown9E914B ; 9E/914B

        ; Read by rlMapBattleRunRecoil.

        .word $0000, $0000, $0000, $0000, $FFFF, $0002, $FFFF, $8000

        ; 9E/915B

    .endsection Table9E914BSection


    .section Unsorted9E915BSection

      .al
      .xl

      rlMapBattleWhitenStruckSide ; 9E/915B

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the struck side's sprites (round bit 0 picks the side) to palette 5, the white one.

        phx
        phy
        lda @l $001057,x
        dec a
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        eor #$0001
        asl a
        asl a
        tax
        phx
        lda aMapAction.wMapBattleAttackerSpriteSlot,x
        tax
        lda #$0005
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        plx
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot,x
        bmi _918F
        tax
        lda #$0005
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        clc
        bra _918F

        .byte $38


        _918F
        ply
        plx
        rtl

        .databank 0

        ; 9E/9192

      rlMapBattleRestoreSpritePalettes ; 9E/9192

        .al
        .xl
        .autsiz
        .databank ?

        ; Gives both sides' sprites their palettes back (allegiance + 1).

        phx
        phy
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda @l aMapAction.wUnknown7F4562
        inc a
        ldx $45A4,b
        sta @l $0012A0,x
        ldx $45A6,b
        bmi _91B3
        sta @l $0012A0,x

        _91B3
        lda @l aMapAction.wDefenderAllegiance
        inc a
        ldx $45A8,b
        bmi _91CA
        sta @l $0012A0,x
        ldx $45AA,b
        bmi _91CA
        sta @l $0012A0,x

        _91CA
        plp
        plb
        .databank $7F
        ply
        plx
        rtl

        .databank 0

        ; 9E/91CF

      rlMapBattleRunHitFlash ; 9E/91CF

        .al
        .xl
        .autsiz
        .databank ?

        ; The struck side's flash: saves its palette, whitens OAM palette 5 and turns the sprites to it (rlMapBattleWhitenStruckSide), plays the hit sound and applies the HP; then each frame steps the colors back toward the saved ones and, at the end, restores the palettes.

        phy
        phx
        lda aMapAction.wMapBattleActiveSpriteSyncFlag
        bne _91DB
        jml _9273


        _91DB
        lda aMapAction.wMapBattlePaletteRestoreFlag
        bne _924E
        jsl rlMapBattleWhitenStruckSide
        bcc _91EB
        jml _9273


        _91EB
        lda @l $001057,x
        dec a
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        eor #$0001
        asl a
        tax
        lda aMapAction.wUnknown7F4562,x
        clc
        adc #$0009
        xba
        lsr a
        lsr a
        lsr a
        tax
        ldy #$0000

        _920E
        lda aBGPaletteBuffer,b,x
        sta wR0
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda wR0
        sta $45AC,b,y
        plp
        plb
        .databank $7F
        inc x
        inc x
        inc y
        inc y
        cpy #$0020
        bne _920E
        ldx #$01A2

        _9230
        lda #$7FFF
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        cpx #$01C0
        bne _9230
        lda #$0001
        sta @l aMapAction.wMapBattlePaletteRestoreFlag
        plx
        jsl rlMapBattlePlayHitSound
        jsl rlApplyMapBattleRoundHP
        phx

        _924E
        lda #$7F00
        sta lR18+1
        lda #$45AC
        clc
        adc #$0002
        sta lR18
        ldy #$000F
        lda #$00D1
        jsl rlBattleSceneStepColorsToward
        bcc _9273
        jsl rlMapBattleRestoreSpritePalettes
        lda #$0000
        sta @l aMapAction.wMapBattleActiveSpriteSyncFlag

        _9273
        plx
        ply
        rtl

        .databank 0

        ; 9E/9276

      rlApplyMapBattleRoundHP ; 9E/9276

        .al
        .xl
        .autsiz
        .databank ?

        ; Applies the round's HP change to the left or right HP window (rlMapBattleDamageLeft, ...HealRight...).

        phy
        phx
        lda wMapBattleMode
        beq _9282
        jml _9316


        _9282
        lda #(`aBattleRoundsData)<<8
        sta lStructPointer2+1,b
        lda #<>aBattleRoundsData
        sta lStructPointer2,b
        lda @l $001057,x
        sta wStructIndex,b
        jsl rlLoadRAMStructDataByIndex
        lda lStructPointer1,b
        sta @l $001077,x
        lda lStructPointer1+1,b
        and #$00FF
        sta wR0
        lda lStructPointer1,b
        bit #$0001
        bne _92E3
        lda lStructPointer1,b
        bit #$0002
        beq _92C0
        lda wR0
        jsl rlMapBattleHealLeft
        bra _9316


        _92C0
        lda wR0
        jsl rlMapBattleDamageLeft
        lda wMapMagicAttackerEffect
        cmp #$0010
        beq _92DB
        lda $7F4BE9
        bne _92DB
        lda $7F4C0B
        beq _9316

        _92DB
        lda wR0
        jsl rlMapBattleHealRight
        bra _9316


        _92E3
        lda lStructPointer1,b
        bit #$0002
        beq _92F3
        lda wR0
        jsl rlMapBattleHealRight
        bra _9316


        _92F3
        lda wR0
        jsl rlMapBattleDamageRight
        lda wMapMagicDefenderEffect
        cmp #$0010
        beq _930E
        lda $7F4BE9
        bne _930E
        lda $7F4C0D
        beq _9316

        _930E
        lda wR0
        jsl rlMapBattleHealLeft
        bcc _9316

        _9316
        lda #$0000
        sta $7F4BE9
        plx
        ply
        rtl

        .databank 0

        ; 9E/9320

    .endsection Unsorted9E915BSection


    .section Unsorted9E9320Section

      .al
      .xl

      rlUnknown9E9320 ; 9E/9320

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda bUnknown000E7B,b
        bit #$0040
        bne _9340
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable,x
        bit #$0020
        bne _9340
        bit #$0010
        beq _9340
        jsl rlSelectUnitAtCursor
        bra _9340


        _9340
        plx
        rtl

        .databank 0

        ; 9E/9342

    .endsection Unsorted9E9320Section


    .section Unsorted9E9342Section

      .al
      .xl

      rlMapBattleStartLevelUpBanner ; 9E/9342

        .al
        .xl
        .autsiz
        .databank ?

        ; When the unit levelled up ($7E4ECB), sets the cycle to the level up banner.

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7E4ECB
        beq _936A
        lda #<>rlMapBattleLevelUpBanner
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0000
        sta aMapAction.wMapBattleLevelUpFrameCounter
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _936A
        rtl

        .databank 0

        ; 9E/936B

      rlMapBattleLevelUpBanner ; 9E/936B

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        phx
        lda aMapAction.wMapBattleLevelUpFrameCounter
        bne _937F
        jsl rlUnknown9E93A4
        lda #$0000
        sta aMapAction.wMapBattleLevelUpFrameCounter

        _937F
        jsl rlUnknown9E93E7
        lda aMapAction.wMapBattleLevelUpFrameCounter
        cmp #$0019
        bne _9397
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        bra _93A0


        _9397
        lda aMapAction.wMapBattleLevelUpFrameCounter
        inc a
        sta aMapAction.wMapBattleLevelUpFrameCounter

        _93A0
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/93A4

      rlUnknown9E93A4 ; 9E/93A4

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #(`aUnknown9CFC00)<<8
        sta lR18+1
        lda #<>aUnknown9CFC00
        clc
        adc #$0100
        sta lR18
        ldy #$001E

        _93B7
        lda [lR18],y
        sta aOAMPaletteBuffer,b,y
        dec y
        dec y
        bpl _93B7
        lda #(`g4bppUnknown9CF000)<<8
        sta lR18+1
        lda #<>g4bppUnknown9CF000
        clc
        adc #$0300
        sta lR18
        lda #$0060
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        rtl

        .databank 0

        ; 9E/93E7

      rlUnknown9E93E7 ; 9E/93E7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        phx
        lda aMapAction.wMapBattleLevelUpFrameCounter
        asl a
        tax
        lda aUnknown9E9480,x
        cmp #$8000
        bne _93FE
        sec
        jml _947C


        _93FE
        lda aMapAction.wMapBattleAttackerXPixel
        clc
        adc aUnknown9E9480,x
        sta wR0
        jsl rlUnknown9E950A
        lda aMapAction.wMapBattleAttackerYPixel
        clc
        adc wR1
        adc aUnknown9E94B6,x
        sta wR1
        lda aMapAction.wMapBattleLevelUpFrameCounter
        tax
        lda aUnknown9E94EA,x
        and #$00FF
        sta wR15
        stz wR4
        stz wR5
        stz wR6
        stz wR14
        stz wR13
        lda #$0003
        sta $7E52F0
        ldx #$0000

        _943C
        lda wR14
        sta $7E52F2,x
        clc
        adc wR15
        sta wR14
        sep #$20
        lda #$00
        sta $7E52F4,x
        rep #$20
        phx
        lda wR13
        asl a
        tax
        lda aUnknown9E9504,x
        ora #$2000
        plx
        sta $7E52F5,x
        inc wR13
        txa
        clc
        adc #$0005
        tax
        cpx #$000F
        bne _943C
        pea #$7E00
        plb
        .databank ?
        plb
        .databank ?
        ldy #$52F0
        jsl rlPushToOAMBuffer
        clc

        _947C
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/9480

    .endsection Unsorted9E9342Section


    .section Table9E9480Section

      .al
      .xl

      aUnknown9E9480 ; 9E/9480

        ; Read by rlUnknown9E93E7.

        .word $FFF4, $FFF4, $FFEF, $FFEF, $FFEC, $FFEC, $FFEF, $FFEF
        .word $FFF4, $FFF4, $FFF9, $FFF9, $FFFC, $FFFC, $FFF9, $FFF9
        .word $FFF4, $FFF4, $FFF4, $FFF4, $FFF4, $FFF4, $FFF4, $FFF4
        .word $FFF4, $FFF4, $8000

        ; 9E/94B6

    .endsection Table9E9480Section


    .section Table9E94B6Section

      .al
      .xl

      aUnknown9E94B6 ; 9E/94B6

        ; Read by rlUnknown9E93E7.

        .word $FFEC, $FFEC, $FFE9, $FFE9, $FFE4, $FFE4, $FFDF, $FFDF
        .word $FFDC, $FFDC, $FFDF, $FFDF, $FFE4, $FFE4, $FFE9, $FFE9
        .word $FFEC, $FFEC, $FFEB, $FFEC, $FFEB, $FFEC, $FFEB, $FFEC
        .word $FFEB, $FFEC

        ; 9E/94EA

    .endsection Table9E94B6Section


    .section Table9E94EASection

      .al
      .xl

      aUnknown9E94EA ; 9E/94EA

        ; Read by rlUnknown9E93E7.

        .word $0101, $0202, $0303, $0404, $0505, $0606, $0707, $0808
        .word $0808, $0808, $0808, $0808, $0808

        ; 9E/9504

    .endsection Table9E94EASection


    .section Table9E9504Section

      .al
      .xl

      aUnknown9E9504 ; 9E/9504

        ; Read by rlUnknown9E93E7.

        .word $0000, $0001, $0002

        ; 9E/950A

    .endsection Table9E9504Section


    .section Unsorted9E950ASection

      .al
      .xl

      rlUnknown9E950A ; 9E/950A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        stz wR1
        lda wBattleStatus
        and #$00FF
        bit #$0004
        beq _952B
        bit #$0002
        bne _952B
        ldx #$FFF0
        bit #$0008
        bne _9529
        ldx #$0010

        _9529
        stx wR1

        _952B
        plx
        rtl

        .databank 0

        ; 9E/952D

      rlMapBattleStartStatGains ; 9E/952D

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        stz wR0
        lda #$7E00
        sta lR18+1
        lda #$4EF5
        sta lR18
        phx
        phy
        ldx #$0000

        _954A
        lda aMapBattleStatGainOrder,x
        cmp #$FFFF
        beq _955E
        tay
        lda [lR18],y
        ora wR0
        sta wR0
        inc x
        inc x
        bra _954A


        _955E
        lda #(`aUnknown9CFC00)<<8
        sta lR18+1
        lda #<>aUnknown9CFC00
        clc
        adc #$0100
        sta lR18
        ldy #$001E

        _956F
        lda [lR18],y
        sta aOAMPaletteBuffer,b,y
        dec y
        dec y
        bpl _956F
        ply
        plx
        lda wR0
        beq _95AA
        lda #<>rlMapBattleStatGains
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$7E00
        sta aMapAction.lMapBattleLevelUpDataPointer+1
        lda #$4EA9
        clc
        adc #$004C
        sta aMapAction.lMapBattleLevelUpDataPointer
        lda #$0000
        sta aMapAction.wMapBattleLevelUpStatIndex
        sta aMapAction.wMapBattleLevelUpFrameCounter
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _95AA
        rtl

        .databank 0

        ; 9E/95AB

      rlMapBattleStatGains ; 9E/95AB

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda aMapAction.wMapBattleLevelUpFrameCounter
        bne _95F1
        lda aMapAction.lMapBattleLevelUpDataPointer+1
        sta lR18+1
        lda aMapAction.lMapBattleLevelUpDataPointer
        sta lR18
        lda aMapAction.wMapBattleLevelUpStatIndex
        asl a
        tax
        lda aMapBattleStatGainOrder,x
        tay
        lda [lR18],y
        beq _961D
        sta aMapAction.wMapBattleLevelUpStatGain
        jsl rlUnknown9E965E
        jsl rlPlayStatGainSound
        lda #$0008
        sta aMapAction.wMapBattleLevelUpFrameCounter
        lda #$0000
        sta aMapAction.wMapBattleLevelUpStatWaitTimer

        _95F1
        jsl rlUnknown9E96C0
        jsl rlUnknown9E978D
        jsl rlUnknown9E97F3
        lda aMapAction.wMapBattleLevelUpFrameCounter
        cmp #$0023
        beq _960D
        inc a
        sta aMapAction.wMapBattleLevelUpFrameCounter
        bra _9649


        _960D
        lda aMapAction.wMapBattleLevelUpStatWaitTimer
        cmp #$000C
        beq _961D
        inc a
        sta aMapAction.wMapBattleLevelUpStatWaitTimer
        bra _9649


        _961D
        lda #$0000
        sta aMapAction.wMapBattleLevelUpFrameCounter
        lda aMapAction.wMapBattleLevelUpStatIndex
        inc a
        sta aMapAction.wMapBattleLevelUpStatIndex
        asl a
        tax
        lda aMapBattleStatGainOrder,x
        cmp #$FFFF
        bne _9649
        plx
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        phx

        _9649
        plx
        ply
        rtl

        .databank 0

        ; 9E/964C

    .endsection Unsorted9E950ASection


    .section Table9E964CSection

      .al
      .xl

      aMapBattleStatGainOrder ; 9E/964C

        ; Read by rlMapBattleStartStatGains, rlMapBattleStatGains.

        .word $0010, $0012, $0014, $0016, $0018, $001E, $001A, $001C
        .word $FFFF

        ; 9E/965E

    .endsection Table9E964CSection


    .section Unsorted9E965ESection

      .al
      .xl

      rlUnknown9E965E ; 9E/965E

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aMapAction.wMapBattleLevelUpStatIndex
        xba
        lsr a
        lsr a
        sta wR2
        lsr a
        clc
        adc wR2
        sta wR2
        lda #(`g4bppUnknown9CF600)<<8
        sta lR18+1
        lda #<>g4bppUnknown9CF000
        lda #<>g4bppUnknown9CF600
        clc
        adc wR2
        sta lR18
        lda #$0060
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        sta wR1
        jsl rlDMAByPointer
        lda #(`g4bppUnknown9CF000)<<8
        sta lR18+1
        lda #<>g4bppUnknown9CF000
        clc
        adc #$0400
        sta lR18
        lda #$0160
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        rtl

        .databank 0

        ; 9E/96C0

      rlUnknown9E96C0 ; 9E/96C0

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        phx
        lda aMapAction.wMapBattleLevelUpFrameCounter
        asl a
        tax
        lda aMapAction.wMapBattleAttackerXPixel
        clc
        adc #$FFF0
        sta wR0
        jsl rlUnknown9E950A
        lda aMapAction.wMapBattleAttackerYPixel
        clc
        adc wR1
        adc aUnknown9E973D,x
        sta wR1
        stz wR4
        stz wR5
        stz wR6
        stz wR14
        stz wR13
        lda #$0003
        sta $7E52F0
        ldx #$0000

        _96F8
        lda wR14
        sta $7E52F2,x
        clc
        adc #$0008
        sta wR14
        sep #$20
        lda #$00
        sta $7E52F4,x
        rep #$20
        phx
        lda wR13
        asl a
        tax
        lda aUnknown9E9787,x
        ora #$2000
        plx
        sta $7E52F5,x
        inc wR13
        txa
        clc
        adc #$0005
        tax
        cpx #$000F
        bne _96F8
        pea #$7E00
        plb
        .databank ?
        plb
        .databank ?
        ldy #$52F0
        jsl rlPushToOAMBuffer
        clc
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/973D

    .endsection Unsorted9E965ESection


    .section Table9E973DSection

      .al
      .xl

      aUnknown9E973D ; 9E/973D

        ; Read by rlUnknown9E96C0, rlUnknown9E978D, rlUnknown9E97F3.

        .word $FFEC, $FFEC, $FFEC, $FFEC, $FFEC, $FFEC, $FFEC, $FFEC
        .word $FFEC, $FFEC, $FFEC, $FFEC, $FFE9, $FFE9, $FFE4, $FFE4
        .word $FFDF, $FFDF, $FFDC, $FFDC, $FFDF, $FFDF, $FFE4, $FFE4
        .word $FFE9, $FFE9, $FFEC, $FFEC, $FFEB, $FFEC, $FFEB, $FFEC
        .word $FFEB, $FFEC, $FFEB, $FFEC, $8000

        ; 9E/9787

    .endsection Table9E973DSection


    .section Table9E9787Section

      .al
      .xl

      aUnknown9E9787 ; 9E/9787

        ; Read by rlUnknown9E96C0.

        .word $0000, $0001, $0002

        ; 9E/978D

    .endsection Table9E9787Section


    .section Unsorted9E978DSection

      .al
      .xl

      rlUnknown9E978D ; 9E/978D

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        phx
        lda aMapAction.wMapBattleAttackerXPixel
        clc
        adc #$0004
        sta wR0
        lda aMapAction.wMapBattleLevelUpFrameCounter
        sec
        sbc #$0004
        cmp #$0008
        bcc _97EF
        asl a
        tax
        jsl rlUnknown9E950A
        lda aMapAction.wMapBattleAttackerYPixel
        clc
        adc wR1
        adc aUnknown9E973D,x
        sta wR1
        stz wR4
        stz wR5
        stz wR6
        lda #$0001
        sta $7E52F0
        lda #$0000
        sta $7E52F2
        sep #$20
        lda #$00
        sta $7E52F4
        rep #$20
        lda #$001A
        ora #$2000
        sta $7E52F5
        pea #$7E00
        plb
        .databank ?
        plb
        .databank ?
        ldy #$52F0
        jsl rlPushToOAMBuffer
        clc

        _97EF
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/97F3

      rlUnknown9E97F3 ; 9E/97F3

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        phx
        lda aMapAction.wMapBattleAttackerXPixel
        clc
        adc #$000C
        sta wR0
        lda aMapAction.wMapBattleLevelUpFrameCounter
        sec
        sbc #$0008
        cmp #$0008
        bcc _985A
        asl a
        tax
        jsl rlUnknown9E950A
        lda aMapAction.wMapBattleAttackerYPixel
        clc
        adc wR1
        adc aUnknown9E973D,x
        sta wR1
        stz wR4
        stz wR5
        stz wR6
        lda #$0001
        sta $7E52F0
        lda #$0000
        sta $7E52F2
        sep #$20
        lda #$00
        sta $7E52F4
        rep #$20
        lda #$0010
        clc
        adc aMapAction.wMapBattleLevelUpStatGain
        ora #$2000
        sta $7E52F5
        pea #$7E00
        plb
        .databank ?
        plb
        .databank ?
        ldy #$52F0
        jsl rlPushToOAMBuffer
        clc

        _985A
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/985E

      rlShowObtainedItemText ; 9E/985E

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7E4ED1
        cmp #$FFFF
        beq _98AD
        sep #$20
        stz wBufferBG3HOFS,b
        rep #$20
        phx
        jsl rlGetItemNamePointerByItemID
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        lda #(`aObtainedItemText)<<8
        sta lR19+1
        lda #<>aObtainedItemText
        sta lR19
        lda #$0D05
        ldx #$0416
        ldy #$0000
        jsl rlGetCenteredTextBoxPlacement
        jsl rlOpenMapBattleTextBox
        plx
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _98AD
        plx
        ply
        rtl

        .databank 0

        ; 9E/98B0

    .endsection Unsorted9E978DSection


    .section Table9E98B0Section

      .al
      .xl

      aObtainedItemText ; 9E/98B0

        .enc "SJIS"
        .text "　を　てにいれた！"
        .word $0000
        .enc "none"


    .endsection Table9E98B0Section


    .section Unsorted9E98C4Section

      .al
      .xl

      rlShowWeaponBrokeText ; 9E/98C4

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda aActionStructUnit1.WeaponInventorySlot
        bpl _990D
        phx
        lda aActionStructUnit1.WeaponID
        jsl rlGetItemNamePointerByItemID
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        lda #(`aWeaponBrokeText)<<8
        sta lR19+1
        lda #<>aWeaponBrokeText
        sta lR19
        lda #$0D05
        ldx #$0416
        ldy #$0000
        jsl rlGetCenteredTextBoxPlacement
        jsl rlOpenMapBattleTextBox
        plx
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _990D
        plx
        ply
        rtl

        .databank 0

        ; 9E/9910

    .endsection Unsorted9E98C4Section


    .section Table9E9910Section

      .al
      .xl

      aWeaponBrokeText ; 9E/9910

        .enc "SJIS"
        .text "　は　こわれてしまった"
        .word $0000
        .enc "none"


    .endsection Table9E9910Section


    .section Unsorted9E9928Section

      .al
      .xl

      rlShowObtainedGoldText ; 9E/9928

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda #(`aObtainedGoldText)<<8
        sta lR19+1
        lda #<>aObtainedGoldText
        sta lR19
        lda $7E4ED3
        beq _994E
        jsl rlShowGoldAmountText
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _994E
        rtl

        .databank 0

        ; 9E/994F

    .endsection Unsorted9E9928Section


    .section Table9E994FSection

      .al
      .xl

      aObtainedGoldText ; 9E/994F

        .enc "SJIS"
        .text "ゴールド　てにいれた！"
        .word $0000
        .enc "none"


    .endsection Table9E994FSection


    .section Unsorted9E9967Section

      .al
      .xl

      rlShowGoldStolenText ; 9E/9967

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda #(`aGoldStolenText)<<8
        sta lR19+1
        lda #<>aGoldStolenText
        sta lR19
        lda aActionStructUnit2.ObtainedStealMoney
        beq _998D
        jsl rlShowGoldAmountText
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _998D
        rtl

        .databank 0

        ; 9E/998E

    .endsection Unsorted9E9967Section


    .section Table9E998ESection

      .al
      .xl

      aGoldStolenText ; 9E/998E

        .enc "SJIS"
        .text "ゴールド　ぬすまれた"
        .word $0000
        .enc "none"


    .endsection Table9E998ESection


    .section Unsorted9E99A4Section

      .al
      .xl

      rlShowGoldAmountText ; 9E/99A4

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        jsl rlSplitNumberIntoDigits
        ldy #$0008

        _99AD
        lda $0000,b,y
        bne _99BA
        dec a
        sta $0000,b,y
        dec y
        dec y
        bpl _99AD

        _99BA
        ldx #$0000
        ldy #$0008

        _99C0
        lda $0000,b,y
        clc
        adc #$824F
        xba
        sta $7F4BDB,x
        inc x
        inc x
        dec y
        dec y
        bpl _99C0
        lda #$0000
        sta $7F4BDB,x
        lda #$7F00
        sta lR18+1
        lda #$4BDB
        sta lR18
        lda #$0D05
        ldx #$0416
        ldy #$0000
        jsl rlGetCenteredTextBoxPlacement
        jsl rlOpenMapBattleTextBox
        plx
        ply
        rtl

        .databank 0

        ; 9E/99F7

    .endsection Unsorted9E99A4Section


    .section Unsorted9E99F7Section

      .al
      .xl

      rlUnknown9E99F7 ; 9E/99F7

        .al
        .autsiz
        .databank ?

        ; dma shadows?

        phy
        phx
        lda #(`g4bppUnknownADFF80)<<8
        sta lR18+1
        lda #<>g4bppUnknownADFF80
        sta lR18
        lda #$0040 ; size
        sta wR0

        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc #$00E0
        sta wR1
        jsl rlDMAByPointer

        lda lR18
        clc
        adc #$0040
        sta lR18
        lda wR1
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        rtl

        .databank 0

        ; 9E/9A34

    .endsection Unsorted9E99F7Section


    .section Unsorted9E9F26Section

      .al
      .xl

      rlUnknown9E9F26 ; 9E/9F26

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        tax
        cpx #$FFFF
        beq _9F42
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x

        _9F42
        lda #$0001
        sta aMapAction.wMapBattlePhaseFlag
        lda aActionStructUnit1
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive
        plx
        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        lda #(`rlPushToOAMBuffer)<<8
        sta $15E5,b
        lda #<>rlPushToOAMBuffer
        sta $15E4,b
        rtl

        .databank 0

        ; 9E/9F66

      rlUnknown9E9F66 ; 9E/9F66

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlRedrawVisibleMapTilemap
        plx
        jsl rlMapBattlePlaySound48
        rtl

        .databank 0

        ; 9E/9F71

      rlUnknown9E9F71 ; 9E/9F71

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        stx wR0
        lda #$FFFF
        sta $7F4C31
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4C2F
        bit #$0010
        beq _9FD1
        and #$0001
        and #$0001
        eor #$0001
        sta $7F4C31
        asl a
        asl a
        tax
        lda aMapAction.wMapBattleAttackerSpriteSlot,x
        sta $7F4C37
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot,x
        sta $7F4C39
        ldx wR0
        lda #<>rlProcUnknown9EC70BCycle8
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$0000
        sta $7F4C33
        sta $7F4C35
        jsl rlMapBattlePlayDefeatCry

        _9FD1
        plx
        ply
        rtl

        .databank 0

        ; 9E/9FD4

      rlProcUnknown9EC70BCycle8 ; 9E/9FD4

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F4C35
        beq _9FE0
        jml _A079


        _9FE0
        lda $7F4C33
        tax
        lda aUnknown9EA085,x
        and #$00FF
        cmp #$00FF
        beq _A033
        sta $7F4C35
        lda $7F4C33
        inc a
        sta $7F4C33
        lda $7F4C37
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        eor #$1000
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda aActiveSpriteSystem.aUnknown001240,b,x
        eor #$1000
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda $7F4C39
        tax
        cpx #$FFFF
        beq _A082
        lda aActiveSpriteSystem.aUnknown001200,b,x
        eor #$1000
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda aActiveSpriteSystem.aUnknown001240,b,x
        eor #$1000
        sta aActiveSpriteSystem.aUnknown001240,b,x
        bra _A082


        _A033
        lda $7F4C37
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        ora #$1000
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda aActiveSpriteSystem.aUnknown001240,b,x
        ora #$1000
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda $7F4C39
        cmp #$FFFF
        beq _A066
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        ora #$1000
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda aActiveSpriteSystem.aUnknown001240,b,x
        ora #$1000
        sta aActiveSpriteSystem.aUnknown001240,b,x

        _A066
        plx
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        phx
        bra _A082


        _A079
        lda $7F4C35
        dec a
        sta $7F4C35

        _A082
        plx
        ply
        rtl

        .databank 0

        ; 9E/A085

    .endsection Unsorted9E9F26Section


    .section Table9EA085Section

      .al
      .xl

      aUnknown9EA085 ; 9E/A085

        ; Read by rlProcUnknown9EC70BCycle8.

        .byte $04, $04, $04, $04, $02, $02, $02, $02, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $FF

        ; 9E/A096

    .endsection Table9EA085Section


    .section Unsorted9EA096Section

      .al
      .xl

      rlMapBattleStartBattleQuote ; 9E/A096

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda wBattleQuotePointer
        beq _A0B6
        sta lR18
        lda wBattleQuotePointer+1
        sta lR18+1
        jsl rlMapBattleOpenQuote

        _A0B6
        plx
        ply
        rtl

        .databank 0

        ; 9E/A0B9

      rlMapBattleStartDeathQuote ; 9E/A0B9

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda aProcSystem.aBody5,b,x
        cmp #$FFFF
        bne _A0DD
        lda wDeathQuotePointer
        beq _A0DD
        jsl rlUnknown91AD7F
        jsl rlMapBattleOpenQuote

        _A0DD
        plx
        ply
        rtl

        .databank 0

        ; 9E/A0E0

      rlMapBattleStartUnusedQuote ; 9E/A0E0

        .al
        .xl
        .autsiz
        .databank ?

        ; Like the other quote starts, but its text pointer is the constant 0, so it never shows anything.

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda aProcSystem.aBody5,b,x
        cmp #$FFFF
        bne _A103
        lda #$0000
        beq _A103
        sta lR18
        sta lR18+1
        jsl rlMapBattleOpenQuote

        _A103
        plx
        ply
        rtl

        .databank 0

        ; 9E/A106

      rlMapBattleOpenQuote ; 9E/A106

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        jsl rlResetDialogueEngine
        jsl rlStartDialogueWithBoxGraphics
        lda #$0001
        sta aDialogue.wTextSound,b
        plx
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        ply
        rtl

        .databank 0

        ; 9E/A122

      rlMapBattleRunQuote ; 9E/A122

        .al
        .xl
        .autsiz
        .databank ?

        phb
        jsl rlUnknown8285E1
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/A129

      rlMapBattleCheckQuoteClosed ; 9E/A129

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aDialogue.wStatus,b
        bne _A13D
        jsl rlDialogueFreeHDMA
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _A13D
        plx
        ply
        rtl

        .databank 0

        ; 9E/A140

      rlUnknown9EA140 ; 9E/A140

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aProcSystem.wInput0,b
        lda $7E4ECD
        sta aProcSystem.wInput1,b
        lda $7E4ECF
        sta aProcSystem.wInput3,b
        rtl

        .databank 0

        ; 9E/A155

      rlDecompressMapBattleTilesAfterQuote ; 9E/A155

        .al
        .xl
        .autsiz
        .databank ?

        ; The quote's box overwrote sprite VRAM $4000-$4BFF: decompresses its tiles again.

        phx
        lda #(`gcUnknownC00A2B)<<8
        sta lR18+1
        lda #<>gcUnknownC00A2B
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$4000
        sta lR19
        jsl rlAppendDecompList
        plx
        rtl

        .databank 0

        ; 9E/A174

      rlUploadMapBattleTilesAfterQuote1 ; 9E/A174

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$4000
        sta lR18
        lda #$0800
        sta wR0
        lda #$4000
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        rtl

        .databank 0

        ; 9E/A195

      rlUploadMapBattleTilesAfterQuote2 ; 9E/A195

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$4800
        sta lR18
        lda #$0800
        sta wR0
        lda #$4400
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        rtl

        .databank 0

        ; 9E/A1B6

      rlUploadMapBattleTilesAfterQuote3 ; 9E/A1B6

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$5000
        sta lR18
        lda #$0800
        sta wR0
        lda #$4800
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        rtl

        .databank 0

        ; 9E/A1D7

    .endsection Unsorted9EA096Section


    .section Unsorted9EA1D7Section

      .al
      .xl

      rlUnknown9EA1D7 ; 9E/A1D7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C11
        ora $7F4C13
        beq _A1F5
        lda $7F4C1F
        tax
        lda aProcSystem.aHeaderTypeOffset,b,x
        cmp #$A334
        bne _A1F5
        lda #$0000
        sta aProcSystem.aHeaderTypeOffset,b,x

        _A1F5
        ldy #$0000
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        tya
        sta aActiveSpriteSystem.aTypeOffset,b,x
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        cmp #$FFFF
        beq _A20F
        tax
        tya
        sta aActiveSpriteSystem.aTypeOffset,b,x

        _A20F
        lda aMapAction.wMapBattleDefenderSpriteSlot
        tax
        tya
        sta aActiveSpriteSystem.aTypeOffset,b,x
        lda aMapAction.wMapBattleDefenderAuxSpriteSlot
        cmp #$FFFF
        beq _A226
        tax
        tya
        sta aActiveSpriteSystem.aTypeOffset,b,x

        _A226
        ldx #$001E

        _A229
        lda @l $001100,x
        bne _A235
        dec x
        dec x
        bpl _A229
        plx
        rtl


        _A235
        nop
        plx
        rtl

        .databank 0

        ; 9E/A238

    .endsection Unsorted9EA1D7Section


    .section Unsorted9EA238Section

      .al
      .xl

      rlMapBattleNextRound ; 9E/A238

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves to the next entry of aBattleRoundsData. $FFFF ends the rounds; an entry $xxFE is a skill activation to show first (high byte SkillIDPavise its shield, procMapBattlePavise; SkillIDAstra to SkillIDDarkness an effect).

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        lda wChapterFlags,b
        and #$7FFF
        sta wChapterFlags,b
        lda #$0000
        sta wMapBattlePavise
        lda #$FFFF
        sta $7F4BF3
        lda aMapAction.wMapBattleRoundIndex
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        cmp #$FFFF
        bne _A26E
        lda aMapAction.wMapBattleRoundIndex
        beq _A2C9

        _A26E
        cmp #$FEFF
        beq _A2A5
        cmp #$00FD
        beq _A2A5
        sta wR0
        and #$00FF
        cmp #$00FE
        bne _A2F6
        lda wR0
        and #$FF00
        xba
        cmp #SkillIDPavise
        bne _A296
        lda #$0001
        sta wMapBattlePavise
        bra _A2A5


        _A296
        sec
        sbc #$0013
        bmi _A2A5
        cmp #$0005
        bcs _A2A5
        sta $7F4BF3

        _A2A5
        lda aMapAction.wMapBattleRoundIndex
        inc a
        sta aMapAction.wMapBattleRoundIndex
        lda #1,s
        tax
        lda @l $001057,x
        inc a
        sta @l $001057,x
        lda aMapAction.wMapBattleRoundIndex
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        cmp #$FFFF
        bne _A2EC

        _A2C9
        pha
        lda #3,s
        tax
        pla
        sta aProcSystem.aBody5,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlUnknown9E8F6A
        lda wChapterFlags,b
        ora #$8000
        sta wChapterFlags,b
        bra _A2F6


        _A2EC
        cmp #$FEFF
        beq _A2A5
        cmp #$00FD
        beq _A2A5

        _A2F6
        plx
        rtl

        .databank 0

        ; 9E/A2F8

      rlStartMapBattleBallistaBolt ; 9E/A2F8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C11
        ora $7F4C13
        beq _A332
        lda $7F4C1F
        cmp #$FFFF
        beq _A315
        tax
        lda aProcSystem.aHeaderTypeOffset,b,x
        cmp #$A334
        beq _A332

        _A315
        lda wBattleStatus
        and #$0001
        sta $7F4C2D
        lda #(`procMapBattleBallistaBolt)<<8
        sta lR44+1
        lda #<>procMapBattleBallistaBolt
        sta lR44
        jsl rlProcEngineCreateProc
        sta $7F4C1F

        _A332
        plx
        rtl

        .databank 0

        ; 9E/A334

    .endsection Unsorted9EA238Section


    .section ProcScript9EA334Section

      .al
      .xl

      procMapBattleBallistaBolt ; 9E/A334

        .structProcInfo "ON", rlProcMapBattleBallistaBoltInit, rlProcMapBattleBallistaBoltCycle, aProcMapBattleBallistaBoltCode

    .endsection ProcScript9EA334Section


    .section Unsorted9EA33CSection

      .al
      .xl

      rlProcMapBattleBallistaBoltInit ; 9E/A33C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7F4C17
        sta $7F4C19
        sta aProcSystem.aHeaderBitfield,b,x
        lda wBattleDistance
        sta $7F4C21
        rtl

        .databank 0

        ; 9E/A353

      rlProcMapBattleBallistaBoltCycle ; 9E/A353

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C1B
        beq _A38A
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        phx
        lda $7F4C2D
        asl a
        asl a
        tax
        lda aMapAction.wMapBattleAttackerXPixel,x
        tax
        jsl rlGetSoundPanFromXPixel
        ora #$0046
        jsl rlPlaySoundEffect2
        plx
        jsl rlUnknown9EA417
        lda #<>rlUnknown9EA38C
        sta aProcSystem.aHeaderOnCycle,b,x
        jsl rlUnknown9EA67C

        _A38A
        plx
        rtl

        .databank 0

        ; 9E/A38C

      rlUnknown9EA38C ; 9E/A38C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C2D
        asl a
        asl a
        tax
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot,x
        tax
        jsl rlUnknown9EA523
        jsl rlUnknown9EA58A
        lda $7F4C2D
        asl a
        asl a
        tax
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot,x
        tax
        lda $7F4C23
        sta aActiveSpriteSystem.aUnknown0011E0,b,x
        lda $7F4C27
        sta aActiveSpriteSystem.aUnknown001220,b,x
        lda $7F4C25
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F4C29
        sec
        sbc $7F4C2B
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda $7F4C2D
        eor #$0001
        asl a
        asl a
        tax
        lda aMapAction.wMapBattleAttackerXPixel,x
        sta wR0
        lda aMapAction.wMapBattleAttackerYPixel,x
        sta wR1
        lda #$0004
        sta wR2
        lda $7F4C2D
        asl a
        asl a
        tax
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot,x
        tax
        jsl rlUnknown9EA566
        bcc _A401
        lda #<>rlUnknown9EA403
        sta aProcSystem.aHeaderOnCycle,b,x

        _A401
        plx
        rtl

        .databank 0

        ; 9E/A403

      rlUnknown9EA403 ; 9E/A403

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/A404

    .endsection Unsorted9EA33CSection


    .section ProcScript9EA404Section

      .al
      .xl

      aProcMapBattleBallistaBoltCode ; 9E/A404

        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET aProcMapBattleBallistaBoltCode, $0004
        PROC_YIELD 40
        PROC_CALL rlUnknown9EA712
        PROC_YIELD 3
        PROC_END


        ; 9E/A417

    .endsection ProcScript9EA404Section


    .section Unsorted9EA417Section

      .al
      .xl

      rlUnknown9EA417 ; 9E/A417

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F4C2D
        asl a
        clc
        adc $7F4C2D
        tax
        lda aMapAction.lUnknown7F4598,x
        sta lR18
        lda aMapAction.lUnknown7F4598+1,x
        sta lR18+1
        lda #$7E00
        sta aMapAction.lMapBattleAuxSpriteScriptPointer+1
        ldy #$0014
        lda $7F4C2D
        asl a
        tax
        lda aMapAction.wUnknown7F455E,x
        lsr a
        bcc _A44A
        ldy #$0010

        _A44A
        lda [lR18],y
        clc
        adc lR18
        sta aMapAction.lMapBattleAuxSpriteScriptPointer
        lda #$0000
        sta $7F4C23
        sta $7F4C27
        lda $7F4C2D
        asl a
        asl a
        sta $7F57EA
        eor #$0004
        sta $7F57EC
        lda $7F4C2D
        asl a
        tax
        lda aMapAction.wUnknown7F455E,x
        asl a
        tay
        lda $7F57EA
        tax
        lda aMapAction.wMapBattleAttackerXPixel,x
        tyx
        clc
        adc aUnknown9EA513,x
        sta $7F4C25
        sta wR0
        lda $7F57EA
        tax
        lda aMapAction.wMapBattleAttackerYPixel,x
        sec
        sbc #$000C
        sta $7F4C29
        sta wR1
        lda $7F4C2D
        bne _A4C0
        lda #$7E00
        sta lR44+1
        lda #$FC8E
        sta lR44
        lda aMapAction.lMapBattleAuxSpriteScriptPointer
        sta $7EFC92
        lda #$FC8E
        bra _A4D5


        _A4C0
        lda #$7E00
        sta lR44+1
        lda #$FC9A
        sta lR44
        lda aMapAction.lMapBattleAuxSpriteScriptPointer
        sta $7EFC9E
        lda #$FC9A

        _A4D5
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldy aActiveSpriteSystem.wOffset,b
        lda $7F57EA
        tax
        tya
        sta aMapAction.wMapBattleAttackerAuxSpriteSlot,x
        txa
        lsr a
        sta wR0,b
        tax
        lda aUnknown9EA50F,x
        tyx
        sta aActiveSpriteSystem.aUnknown001260,b,x
        phx
        ldx wR0,b
        lda aMapAction.wUnknown7F4562,x
        plx
        inc a
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda $7F4C2D
        sta aActiveSpriteSystem.aUnknown001320,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/A50F

    .endsection Unsorted9EA417Section


    .section Table9EA50FSection

      .al
      .xl

      aUnknown9EA50F ; 9E/A50F

        ; Read by rlUnknown9EA417.

        .word $0020, $0040

        ; 9E/A513

    .endsection Table9EA50FSection


    .section Table9EA513Section

      .al
      .xl

      aUnknown9EA513 ; 9E/A513

        ; Read by rlUnknown9EA417.

        .sint -$000C, -$0004, $0003, $0003, $000E, $000C, -$0001, -$000C

        ; 9E/A523

    .endsection Table9EA513Section


    .section Unsorted9EA523Section

      .al
      .xl

      rlUnknown9EA523 ; 9E/A523

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown0013C0,b,x
        sep #$20
        clc
        adc $7F4C23
        sta $7F4C23
        rep #$20
        and #$FF00
        xba
        bpl _A53C
        ora #$FF00

        _A53C
        adc $7F4C25
        sta $7F4C25
        lda aActiveSpriteSystem.aUnknown0013E0,b,x
        sep #$20
        clc
        adc $7F4C27
        sta $7F4C27
        rep #$20
        and #$FF00
        xba
        bpl _A55D
        ora #$FF00

        _A55D
        adc $7F4C29
        sta $7F4C29
        rtl

        .databank 0

        ; 9E/A566


      rlUnknown9EA566 ; 9E/A566

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001200,b,x
        sec
        sbc wR0
        bpl _A572
        eor #$FFFF
        inc a

        _A572
        cmp wR2
        bpl _A588
        lda aActiveSpriteSystem.aUnknown001240,b,x
        sec
        sbc wR1
        bpl _A582
        eor #$FFFF
        inc a

        _A582
        cmp wR2
        bpl _A588
        sec
        rtl


        _A588
        clc
        rtl

        .databank 0

        ; 9E/A58A


      rlUnknown9EA58A ; 9E/A58A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C21
        dec a
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown9EA5DE,x
        sta lR18
        lda aUnknown9EA5DE+1,x
        sta lR18+1
        lda $7F4C19
        tay
        lda [lR18],y
        and #$00FF
        sta $7F4C2B
        lda $7F4C19
        inc a
        sta $7F4C19
        ldx #$000A

        _A5BD
        cmp aUnknown9EA5D2,x
        bne _A5CC
        lda #$0001
        sta $7F4C17
        bra _A5D0


        _A5CC
        dec x
        dec x
        bpl _A5BD

        _A5D0
        plx
        rtl

        .databank 0

        ; 9E/A5D2


      aUnknown9EA5D2 ; 9E/A5D2

        .word $0004, $0006, $0008, $000A, $000D, $0011

      aUnknown9EA5DE ; 9E/A5DE

        .long aUnknown9EA5FC
        .long aUnknown9EA5FC
        .long aUnknown9EA5FC
        .long aUnknown9EA60C
        .long aUnknown9EA61C
        .long aUnknown9EA62C
        .long aUnknown9EA63C
        .long aUnknown9EA64C
        .long aUnknown9EA65C
        .long aUnknown9EA66C

      aUnknown9EA5FC ; 9E/A5FC
        .byte $04, $09, $0D, $10, $13, $16, $17, $18, $18, $17, $16, $13, $10, $0D, $09, $04

      aUnknown9EA60C ; 9E/A60C
        .byte $06, $0C, $11, $16, $1A, $1D, $1F, $20, $20, $1F, $1D, $1A, $16, $11, $0C, $06

      aUnknown9EA61C ; 9E/A61C
        .byte $07, $0F, $16, $1C, $21, $24, $27, $28, $28, $27, $24, $21, $1C, $16, $0F, $07

      aUnknown9EA62C ; 9E/A62C
        .byte $09, $12, $1A, $21, $27, $2C, $2F, $30, $30, $2F, $2C, $27, $21, $1A, $12, $09

      aUnknown9EA63C ; 9E/A63C
        .byte $0A, $15, $1F, $27, $2E, $33, $36, $38, $38, $36, $33, $2E, $27, $1F, $15, $0A

      aUnknown9EA64C ; 9E/A64C
        .byte $0C, $18, $23, $2D, $35, $3B, $3E, $40, $40, $3E, $3B, $35, $2D, $23, $18, $0C

      aUnknown9EA65C ; 9E/A65C
        .byte $0E, $1B, $28, $32, $3B, $42, $46, $48, $48, $46, $42, $3B, $32, $28, $1B, $0E

      aUnknown9EA66C ; 9E/A66C
        .byte $0F, $1E, $2C, $38, $42, $49, $4E, $50, $50, $4E, $49, $42, $38, $2C, $1E, $0F

        ; 9E/A67C

    .endsection Unsorted9EA523Section


    .section Unsorted9EA67CSection

      .al
      .xl

      rlUnknown9EA67C ; 9E/A67C

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta wR0
        lda $7F4C2D
        asl a
        asl a
        sta wR14,b
        eor #$0004
        sta wR15,b
        ldx wR15,b
        lda aMapAction.wMapBattleAttackerXPixel,x
        sec
        sbc $7F4C25
        bpl _A6A9
        dec a
        eor #$FFFF
        ldy #$0001
        sty wR0

        _A6A9
        xba
        sta wR13
        lda #$0010
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda $7F4C2D
        asl a
        asl a
        tax
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot,x
        tax
        lda wR13
        ldy wR0
        beq _A6CB
        eor #$FFFF
        inc a

        _A6CB
        sta aActiveSpriteSystem.aUnknown0013C0,b,x
        lda #$0000
        sta wR0
        ldx wR15,b
        lda aMapAction.wMapBattleAttackerYPixel,x
        sec
        sbc $7F4C29
        bpl _A6EA
        dec a
        eor #$FFFF
        ldy #$0001
        sty wR0

        _A6EA
        xba
        sta wR13
        lda #$0010
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda $7F4C2D
        asl a
        asl a
        tax
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot,x
        tax
        lda wR13
        ldy wR0
        beq _A70C
        eor #$FFFF
        inc a

        _A70C
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/A712

      rlUnknown9EA712 ; 9E/A712

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta $7F4C1D
        rtl

        .databank 0

        ; 9E/A71A

      rlUnknown9EA71A ; 9E/A71A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wR0
        clc
        adc wR2
        sec
        sbc #$0100
        bmi _A72C
        lsr a
        cmp wMapMinXScroll,b
        bcs _A731

        _A72C
        lda wMapMinXScroll,b
        bra _A739


        _A731
        cmp wMapMaxXScroll,b
        bcc _A739
        lda wMapMaxXScroll,b

        _A739
        sta wR4
        lda wR1
        clc
        adc wR3
        sec
        sbc #$00E0
        bmi _A74C
        lsr a
        cmp wMapMinYScroll,b
        bcs _A751

        _A74C
        lda wMapMinYScroll,b
        bra _A759


        _A751
        cmp wMapMaxYScroll,b
        bcc _A759
        lda wMapMaxYScroll,b

        _A759
        sta wR5
        plx
        rtl

        .databank 0

        ; 9E/A75D

      rlMapBattleSetCameraTarget ; 9E/A75D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wBattleType
        and #$00FF
        cmp #$0003
        bne _A76E
        jml _A804


        _A76E
        lda wMapScrollXPixels,b
        sta $7F4BF9
        lda wMapScrollYPixels,b
        sta $7F4BFB
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda wMapBattleMode
        bne _A804
        lda $7F4C11
        ora $7F4C13
        bne _A7A4
        lda wMapMagicFlags
        beq _A804
        jsl rlUnknown9EA850
        bcc _A804

        _A7A4
        lda aMapAction.wXTilePosition
        asl a
        asl a
        asl a
        asl a
        sta wR0
        lda aMapAction.wYTilePosition
        asl a
        asl a
        asl a
        asl a
        sta wR1
        lda aActionStructUnit2
        cmp #$FFFF
        bne _A7CB
        lda wR0
        sta wR2
        lda wR1
        sta wR3
        bra _A7DF


        _A7CB
        lda aMapAction.wUnknown7F4556
        asl a
        asl a
        asl a
        asl a
        sta wR2
        lda aMapAction.wUnknown7F4558
        asl a
        asl a
        asl a
        asl a
        sta wR3

        _A7DF
        jsl rlUnknown9EA71A
        lda wR4
        and #$FFF0
        sta $7F4BF5
        lda wR5
        and #$FFF0
        sta $7F4BF7
        jsl rlUnknown9EA806
        bcc _A804
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _A804
        plx
        rtl

        .databank 0

        ; 9E/A806

      rlUnknown9EA806 ; 9E/A806

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        sec
        sbc $7F4BF5
        bpl _A814
        eor #$FFFF
        inc a

        _A814
        cmp aUnknown9EA84A
        bcs _A848
        lda wMapScrollYPixels,b
        sec
        sbc $7F4BF7
        bpl _A828
        eor #$FFFF
        inc a

        _A828
        cmp aUnknown9EA84A+2
        bcs _A848
        lda wBattleDistance
        cmp aUnknown9EA84A+4
        bcs _A848
        lda wMapScrollXPixels,b
        sta $7F4BF5
        lda wMapScrollYPixels,b
        sta $7F4BF7
        clc
        rtl


        _A848
        sec
        rtl

        .databank 0

        ; 9E/A84A

    .endsection Unsorted9EA67CSection


    .section Table9EA84ASection

      .al
      .xl

      aUnknown9EA84A ; 9E/A84A

        ; Read by rlUnknown9EA806.

        .word $0030, $0030, $0008

        ; 9E/A850

    .endsection Table9EA84ASection


    .section Unsorted9EA850Section

      .al
      .xl

      rlUnknown9EA850 ; 9E/A850

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wMapMagicAttackerEffect
        tax
        lda aUnknown9EA873,x
        and #$00FF
        bne _A86D
        lda wMapMagicDefenderEffect
        tax
        lda aUnknown9EA873,x
        and #$00FF
        beq _A870

        _A86D
        sec
        plx
        rtl


        _A870
        clc
        plx
        rtl

        .databank 0

        ; 9E/A873

    .endsection Unsorted9EA850Section


    .section Table9EA873Section

      .al
      .xl

      aUnknown9EA873 ; 9E/A873

        ; Read by rlUnknown9EA850.

        .word $0101, $0101, $0101, $0101, $0101, $0101, $0101, $0101
        .word $0101, $0100, $0101, $0000, $0000, $0101, $0101, $0101
        .word $0101, $0100, $0100, $0101, $0000, $0000

        ; 9E/A89F

    .endsection Table9EA873Section


    .section Unsorted9EA89FSection

      .al
      .xl

      rlMapBattleMoveCamera ; 9E/A89F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlStepCameraTowardsTarget
        bcc _A8B8
        plx
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        bra _A8B9


        _A8B8
        plx

        _A8B9
        rtl

        .databank 0

        ; 9E/A8BA

      rlUnknown9EA8BA ; 9E/A8BA

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4BEB
        bit #$0001
        bne _A8D5
        lda $7F4BED
        bra _A8D9


        _A8D5
        lda $7F4BEF

        _A8D9
        cmp #$FFFF
        beq _A924
        cmp #$FFFE
        beq _A91D
        lda $7F4BEB
        and #$0001
        sta $7F57EA
        jsr rsUnknown9EA925
        bcc _A91D
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        ldx #$FFFE
        lda $7F4BEB
        bit #$0001
        bne _A90F
        txa
        sta $7F4BED
        bra _A914


        _A90F
        txa
        sta $7F4BEF

        _A914
        lda #$0001
        sta wMapMagicStart
        bra _A924


        _A91D
        lda #$FFFF
        sta wMapMagicStart

        _A924
        rtl

        .databank 0

        ; 9E/A925

      rsUnknown9EA925 ; 9E/A925

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aMapAction.wMapBattleRoundIndex
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        cmp #$FFFF
        beq _A962
        cmp #$FEFF
        beq _A962
        cmp #$7F00
        beq _A962
        and #$00FF
        cmp #$00FE
        beq _A962
        cmp #$00FD
        beq _A962
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        cmp $7F57EA
        bne _A962
        lda aBattleRoundsData._Entry[0],x
        and #$0040
        bne _A965

        _A962
        plx
        clc
        rts


        _A965
        lda $7E4F87,x
        cmp #$FFFF
        bne _A97F
        pha
        lda #3,s
        tax
        pla
        sta aProcSystem.aBody5,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _A97F
        lda aMapAction.wMapBattleRoundIndex
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        sta $7F4C2F
        lda aMapAction.wMapBattleRoundIndex
        inc a
        sta aMapAction.wMapBattleRoundIndex
        lda #1,s
        tax
        lda @l $001057,x
        inc a
        sta @l $001057,x
        plx
        sec
        rts

        .databank 0

        ; 9E/A9A5

      rlUnknown9EA9A5 ; 9E/A9A5

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapMagicDone
        beq _A9B4
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _A9B4
        rtl

        .databank 0

        ; 9E/A9B5

      rlUnknown9EA9B5 ; 9E/A9B5

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta $7F4BE9
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4BF3
        cmp #$FFFF
        bne _A9D7
        jml _AA59


        _A9D7
        cmp #$0002
        bne _A9E3
        lda #$0001
        sta $7F4BE9

        _A9E3
        lda aMapAction.wMapBattleRoundIndex
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        sta $7F57EA
        asl a
        asl a
        sta wR0
        tax
        lda aMapAction.wMapBattleAttackerSpriteSlot,x
        tax
        lda #$0005
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        ldx wR0
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot,x
        cmp #$FFFF
        beq _AA16
        tax
        lda #$0005
        sta aActiveSpriteSystem.aUnknown0012A0,b,x

        _AA16
        lda $7F4BF3
        and #$00FF
        xba
        lsr a
        lsr a
        lsr a
        tax
        ldy #$01A0

        _AA25
        lda aUnknown9EAA61,x
        sta aBGPaletteBuffer,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$01C0
        bne _AA25
        jsl rlUnknown96D659
        stz wR0
        lda #(`aUnknown9EAA5C)<<8
        sta lR18+1
        lda #<>aUnknown9EAA5C
        sta lR18
        jsl rlBattleSceneStartPaletteEffect
        jsl rlMapBattlePlaySound3D
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _AA59
        plx
        ply
        rtl

        .databank 0

        ; 9E/AA5C

    .endsection Unsorted9EA89FSection


    .section Table9EAA5CSection

      .al
      .xl

      aUnknown9EAA5C ; 9E/AA5C
        PALETTE_EFFECT_VALUE $00, $03, $D0, $10, $02

    .endsection Table9EAA5CSection


    .section Table9EAA61Section

      .al
      .xl

      aUnknown9EAA61 ; 9E/AA61

        ; Read by rlUnknown9EA9B5.

        .word $5BF6, $53F2, $33EC, $03E0, $0280, $0180, $1104, $0080
        .word $1104, $0180, $0280, $03E0, $33EC, $53F2, $5BF6, $6BF8
        .word $7F77, $7EB2, $7DC9, $7C00, $4800, $3000, $2082, $1000
        .word $2082, $3000, $4800, $7C00, $7DC9, $7EB2, $7F77, $7F7A
        .word $52FF, $4E7F, $29BF, $1D1F, $001F, $0015, $000D, $0006
        .word $0009, $000D, $0015, $001F, $1D1F, $29BF, $4E7F, $62FF
        .word $5F9F, $3B1F, $1E9F, $021F, $015B, $00F3, $00CD, $0088
        .word $00CD, $00F3, $015B, $021F, $1E9F, $3B1F, $5F9F, $73DF
        .word $7E9A, $7DB8, $7974, $78F1, $588B, $2844, $1C83, $1403
        .word $1C83, $2844, $588B, $78F1, $7974, $7DB8, $7E9A, $7F1F
        .word $57FF, $3FFF, $27FF, $03FF, $02B9, $01CE, $00C6, $0084
        .word $00C6, $01CE, $02B9, $03FF, $27FF, $3FFF, $57FF, $63FF

        ; 9E/AB21

    .endsection Table9EAA61Section


    .section Unsorted9EAB21Section

      .al
      .xl

      rlUnknown9EAB21 ; 9E/AB21

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlMapBattleRestoreSpritePalettes
        sep #$20
        lda $7FFD9A
        ora #$80
        sta $7FFD9A
        rep #$20
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda aMapAction.wMapBattleRoundIndex
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$00FF
        cmp #$00FE
        bne _AB5B
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _AB5B
        plx
        rtl

        .databank 0

        ; 9E/AB5D

      rlUnknown9EAB5D ; 9E/AB5D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F454A
        cmp #$0004
        bcs _AB71
        lda #$0000
        jsr rsUnknown9EABE9
        bcs _ABBA
        bra _AB87


        _AB71
        lda wMapMagicAttackerEffect
        tax
        lda aUnknown9EABBD,x
        and #$00FF
        bne _AB87
        lda #$0000
        jsr rsUnknown9EABE9
        bcs _ABBA

        _AB87
        lda aMapAction.wUnknown7F454C
        cmp #$0004
        bcs _AB9A
        lda #$0001
        jsr rsUnknown9EABE9
        bcs _ABBA
        bra _ABB0


        _AB9A
        lda wMapMagicDefenderEffect
        tax
        lda aUnknown9EABBD,x
        and #$00FF
        bne _ABB0
        lda #$0001
        jsr rsUnknown9EABE9
        bcs _ABBA

        _ABB0
        lda #$8000
        sta wMapMagicFlags
        sec
        plx
        rtl


        _ABBA
        clc
        plx
        rtl

        .databank 0

        ; 9E/ABBD

    .endsection Unsorted9EAB21Section


    .section Table9EABBDSection

      .al
      .xl

      aUnknown9EABBD ; 9E/ABBD

        ; Read by rlUnknown9EAB5D.

        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0101
        .word $0101, $0100, $0100, $0101, $0001, $0000

        ; 9E/ABE9

    .endsection Table9EABBDSection


    .section Unsorted9EABE9Section

      .al
      .xl

      rsUnknown9EABE9 ; 9E/ABE9

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR0
        ldx #$0000

        _ABEF
        lda aBattleRoundsData._Entry[0],x
        cmp #$FFFF
        beq _AC0B
        cpx #$0050
        beq _AC0B
        and #$0001
        cmp wR0
        beq _AC08
        inc x
        inc x
        bra _ABEF


        _AC08
        sec
        plx
        rts


        _AC0B
        clc
        plx
        rts

        .databank 0

        ; 9E/AC0E

      rlUnknown9EAC0E ; 9E/AC0E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tax
        lda aDeploymentTable,x
        ora #$8000
        sta aDeploymentTable,x
        plx
        rtl

        .databank 0

        ; 9E/AC1D

      rlUnknown9EAC1D ; 9E/AC1D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aActionStructUnit1
        tax
        lda aDeploymentTable,x
        and #$7FFF
        sta aDeploymentTable,x
        lda wR15
        bne _AC47
        lda aActionStructUnit2
        cmp #$FFFF
        beq _AC47
        tax
        lda aDeploymentTable,x
        and #$7FFF
        sta aDeploymentTable,x

        _AC47
        plx
        rtl

        .databank 0

        ; 9E/AC49

    .endsection Unsorted9EABE9Section


    .section Unsorted9EAC49Section

      .al
      .xl

      rlUnknown9EAC49 ; 9E/AC49

        .al
        .xl
        .autsiz
        .databank ?

        and #$0080
        eor #$0080
        asl a
        asl a
        asl a
        ora #$0101
        sta wMapMagicFlags
        rtl

        .databank 0

        ; 9E/AC5A

    .endsection Unsorted9EAC49Section


    .section Unsorted9EADD1Section

      .al
      .xl

      rlUnknown9EADD1 ; 9E/ADD1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR0
        lda wBattleStatus
        and #$00FF
        bit #$0004
        beq _AE20
        and #$0002
        lsr a
        cmp wR0
        bne _AE20
        asl a
        asl a
        sta wR1
        ldx #$0010
        lda wBattleStatus
        and #$00FF
        bit #$0008
        beq _ADFE
        ldx #$FFF0

        _ADFE
        stx wR0
        ldx wR1
        lda aMapAction.wMapBattleAttackerSpriteSlot,x
        tax
        lda aActiveSpriteSystem.aUnknown001240,b,x
        clc
        adc wR0
        sta aActiveSpriteSystem.aUnknown001240,b,x
        ldx wR1
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot,x
        tax
        lda aActiveSpriteSystem.aUnknown001240,b,x
        clc
        adc wR0
        sta aActiveSpriteSystem.aUnknown001240,b,x

        _AE20
        plx
        rtl

        .databank 0

        ; 9E/AE22

      rlMapBattleCheckShiftedUnit ; 9E/AE22

        .al
        .xl
        .autsiz
        .databank ?

        ; When a combatant was moved a tile off a shared tile for the battle (wBattleStatus bit 2), keeps its side (bit 1) and direction (bit 3: the guarding defender, moved down) and sets header bit $0002.

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda wBattleStatus
        and #$00FF
        bit #$0004
        beq _AE58
        and #$0002
        lsr a
        sta $7F57EA
        lda wBattleStatus
        and #$0008
        asl a
        sta $7F57EC
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _AE58
        plx
        rtl

        .databank 0

        ; 9E/AE5A

      rlMapBattleSlideShiftedUnitOut ; 9E/AE5A

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: moves the shifted combatant's sprites by the next step of aMapBattleShiftSlideOut (16 pixels in all, up or down); header bit $0004 at the end.

        phx
        lda $7F57EC
        tax
        lda aMapBattleShiftSlideOut,x
        sta wR0
        cmp #$8000
        beq _AEA1
        lda $7F57EA
        asl a
        asl a
        tax
        phx
        lda aMapAction.wMapBattleAttackerSpriteSlot,x
        tax
        lda aActiveSpriteSystem.aUnknown001240,b,x
        sec
        sbc wR0
        sta aActiveSpriteSystem.aUnknown001240,b,x
        plx
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot,x
        cmp #$FFFF
        beq _AE95
        tax
        lda aActiveSpriteSystem.aUnknown001240,b,x
        sec
        sbc wR0
        sta aActiveSpriteSystem.aUnknown001240,b,x

        _AE95
        lda $7F57EC
        inc a
        inc a
        sta $7F57EC
        bra _AEAD


        _AEA1
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _AEAD
        plx
        rtl

        .databank 0

        ; 9E/AEAF

    .endsection Unsorted9EADD1Section


    .section Table9EAEAFSection

      .al
      .xl

      aMapBattleShiftSlideOut ; 9E/AEAF

        ; Read by rlMapBattleSlideShiftedUnitOut.

        .word $0001, $0001, $0002, $0002, $0002, $0004, $0004, $8000
        .word $FFFF, $FFFF, $FFFE, $FFFE, $FFFE, $FFFC, $FFFC, $8000

        ; 9E/AECF

    .endsection Table9EAEAFSection


    .section Unsorted9EAECFSection

      .al
      .xl

      rlMapBattleSlideShiftedUnitBack ; 9E/AECF

        .al
        .xl
        .autsiz
        .databank ?

        ; The same with aMapBattleShiftSlideBack, after the battle.

        phx
        lda $7F57EC
        tax
        lda aMapBattleShiftSlideBack,x
        sta wR0
        cmp #$8000
        beq _AF16
        lda $7F57EA
        asl a
        asl a
        tax
        phx
        lda aMapAction.wMapBattleAttackerSpriteSlot,x
        tax
        lda aActiveSpriteSystem.aUnknown001240,b,x
        clc
        adc wR0
        sta aActiveSpriteSystem.aUnknown001240,b,x
        plx
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot,x
        cmp #$FFFF
        beq _AF0A
        tax
        lda aActiveSpriteSystem.aUnknown001240,b,x
        clc
        adc wR0
        sta aActiveSpriteSystem.aUnknown001240,b,x

        _AF0A
        lda $7F57EC
        inc a
        inc a
        sta $7F57EC
        bra _AF22


        _AF16
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _AF22
        plx
        rtl

        .databank 0

        ; 9E/AF24

    .endsection Unsorted9EAECFSection


    .section Table9EAF24Section

      .al
      .xl

      aMapBattleShiftSlideBack ; 9E/AF24

        ; Read by rlMapBattleSlideShiftedUnitBack.

        .word $0004, $0004, $0002, $0002, $0002, $0001, $0001, $8000
        .word $FFFC, $FFFC, $FFFE, $FFFE, $FFFE, $FFFF, $FFFF, $8000

        ; 9E/AF44

    .endsection Table9EAF24Section


    .section Unsorted9EAF44Section

      .al
      .xl

      rlMapBattleStartWarpArrival ; 9E/AF44

        .al
        .xl
        .autsiz
        .databank ?

        ; After the rounds: when the effect was Warp (wMapMagicEffect $20) and its destination can be shown (rlMapBattleCheckWarpDestinationShown), starts procMapBattleWarpArrival and sets header bit $0002.

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda wMapMagicEffect
        cmp #$0020
        bne _AF77
        jsl rlMapBattleCheckWarpDestinationShown
        bcs _AF77
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        lda #(`procMapBattleWarpArrival)<<8
        sta lR44+1
        lda #<>procMapBattleWarpArrival
        sta lR44
        jsl rlProcEngineCreateProc

        _AF77
        plx
        rtl

        .databank 0

        ; 9E/AF79

      rlMapBattleWaitWarpArrival ; 9E/AF79

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets header bit $0004 once procMapBattleWarpArrival has ended.

        phx
        lda #(`procMapBattleWarpArrival)<<8
        sta lR44+1
        lda #<>procMapBattleWarpArrival
        sta lR44
        jsl rlProcEngineFindProc
        bcs _AF96
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _AF96
        plx
        rtl

        .databank 0

        ; 9E/AF98

    .endsection Unsorted9EAF44Section


    .section ProcScript9EAF98Section

      .al
      .xl

      procMapBattleWarpArrival ; 9E/AF98

        .structProcInfo "ON", rlProcMapBattleWarpArrivalInit, rlProcMapBattleWarpArrivalCycle1, aProcMapBattleWarpArrivalCode

    .endsection ProcScript9EAF98Section


    .section Unsorted9EAFA0Section

      .al
      .xl

      rlProcMapBattleWarpArrivalInit ; 9E/AFA0

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets map magic effect $29 and points wMapMagicTargetPixel at the warp's destination ($7E4F77, $7E4F79).

        phy
        phx
        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0000
        sta $4580,b
        sta $4582,b
        sta $4584,b
        sta $5091,b
        sta $5093,b
        sta $4C11,b
        sta $4C13,b
        sta $7F4C07
        lda #$0029
        sta $5089,b
        plb
        .databank ?
        lda $7E4F77
        tax
        lda $7E4F79
        tay
        lda aActionStructUnit2.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1
        lda wR1
        xba
        ora wR0
        sta wMapMagicTargetPixel
        plx
        ply
        rtl

        .databank 0

        ; 9E/AFF7

      rlProcMapBattleWarpArrivalCycle1 ; 9E/AFF7

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/AFF8

    .endsection Unsorted9EAFA0Section


    .section ProcScript9EAFF8Section

      .al
      .xl

      aProcMapBattleWarpArrivalCode ; 9E/AFF8

        PROC_CALL rlMapBattleHideDefenderSprites
        PROC_YIELD 1
        PROC_CALL rlStartMapMagicEffect
        PROC_YIELD 1
        PROC_CALL rlMapBattleSetMagicStart
        PROC_SET_ONCYCLE rlProcWaitMapMagicStartCycle
        _B00F
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _B00F, $0002
        PROC_YIELD 1
        PROC_END


        ; 9E/B01B

    .endsection ProcScript9EAFF8Section


    .section Unsorted9EB01BSection

      .al
      .xl

      rlMapBattleCheckWarpDestinationShown ; 9E/B01B

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry clear when the warp's destination ($7E4F77, $7E4F79) is on the screen; on the castle screen (battle type 3), when the location there is the warped unit's home castle.

        phx
        lda $7E4F77
        sta wR0
        lda $7E4F79
        sta wR1
        lda wBattleType
        and #$00FF
        cmp #$0003
        beq _B03A
        jsl rlIsMapTileOnScreen
        bra _B044


        _B03A
        lda aActionStructUnit2.UnitRAMPointer
        sta wR2
        jsl rlIsHomeCastleAtTile

        _B044
        plx
        rtl

        .databank 0

        ; 9E/B046

      rlIsMapTileOnScreen ; 9E/B046

        .al
        .xl
        .autsiz
        .databank ?

        ; wR0, wR1 = tile X, Y: carry clear when it is inside the 256x224 screen at the current scroll.

        lda wR0
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        bmi _B06A
        cmp #$0100
        bcs _B06A
        lda wR1
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        bmi _B06A
        cmp #$00E0
        bcs _B06A
        clc
        rtl


        _B06A
        sec
        rtl

        .databank 0

        ; 9E/B06C

      rlIsHomeCastleAtTile ; 9E/B06C

        .al
        .xl
        .autsiz
        .databank ?

        ; wR0, wR1 = tile, wR2 = unit: carry clear when the location at the tile is the unit's home castle.

        phx
        jsl rlFindLocationAtTile
        jsl rlGetEventLocationEntryID
        sta $7F57EA
        lda wR2
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitHomeCastle
        cmp $7F57EA
        beq _B08B
        sec
        plx
        rtl


        _B08B
        clc
        plx
        rtl

        .databank 0

        ; 9E/B08E

      rlMapBattleHideDefenderSprites ; 9E/B08E

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bit 15 of the X of the defender's sprites, hiding them.

        phx
        lda aMapAction.wMapBattleDefenderSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        ora #$8000
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda aMapAction.wMapBattleDefenderAuxSpriteSlot
        cmp #$FFFF
        beq _B0B0
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        ora #$8000
        sta aActiveSpriteSystem.aUnknown001200,b,x

        _B0B0
        plx
        rtl

        .databank 0

        ; 9E/B0B2

      rlMapBattleSetMagicStart ; 9E/B0B2

        .al
        .xl
        .autsiz
        .databank ?

        ; wMapMagicStart = 1.

        lda #$0001
        sta wMapMagicStart
        rtl

        .databank 0

        ; 9E/B0BA

      rlMapBattlePlayDefeatCry ; 9E/B0BA

        .al
        .xl
        .autsiz
        .databank ?

        ; The map battle's defeat cry: sound $21, $22 or $23 by rlGetDefeatedUnitVoice, panned to the side's map sprite.

        phx
        lda $7F4C31
        asl a
        asl a
        tax
        lda aMapAction.wMapBattleAttackerSpriteSlot,x
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        pha
        lda $7F4C31
        jsl rlGetDefeatedUnitVoice
        asl a
        tax
        lda aMapBattleDefeatCrySounds,x
        sta wR0
        jsl rlMapBattleGetChildCry
        pla
        jsl rlGetSoundPanFromXPixel
        ora wR0
        jsl rlPlaySoundEffect2
        plx
        rtl

        .databank 0

        ; 9E/B0EC

    .endsection Unsorted9EB01BSection


    .section Table9EB0ECSection

      .al
      .xl

      aMapBattleDefeatCrySounds ; 9E/B0EC

        ; Read by rlMapBattlePlayDefeatCry.

        .word $0021, $0022, $0023

        ; 9E/B0F2

    .endsection Table9EB0ECSection


    .section Unsorted9EB0F2Section

      .al
      .xl

      rlGetDefeatedUnitVoice ; 9E/B0F2

        .al
        .xl
        .autsiz
        .databank ?

        ; A = 0 for combatant 1 defeated, 1 for combatant 2: 1 + its gender when it has a voice, else 0. Combatant 1 has none when its deployment faction is 1; combatant 2 has one only with wBattleSong $3E and a character ID up to $3F.

        bne _B10C
        lda aActionStructUnit1
        tax
        lda aDeploymentTable,x
        and #$0003
        cmp #$0001
        beq _B120
        lda aActionStructUnit1.Gender
        inc a
        bra _B12A


        _B10C
        lda wBattleSong
        cmp #$003E
        bne _B120
        lda aActionStructUnit2.CharacterID
        cmp #$003F
        beq _B125
        bcc _B125

        _B120
        lda #$0000
        bra _B12A


        _B125
        lda aActionStructUnit2.Gender
        inc a

        _B12A
        rtl

        .databank 0

        ; 9E/B12B

      rlMapBattleGetChildCry ; 9E/B12B

        .al
        .xl
        .autsiz
        .databank ?

        ; The defeat cry of a Child (class $42): wR0 = sound $24 or $25 by gender from aMapBattleChildCrySounds; other classes leave wR0 alone. $7F4C31 picks the side.

        phx
        lda $7F4C31
        bne _B141
        lda aActionStructUnit1.ClassID
        cmp #$0042
        bne _B158
        lda aActionStructUnit1.Gender
        bra _B14E


        _B141
        lda aActionStructUnit2.ClassID
        cmp #$0042
        bne _B158
        lda aActionStructUnit2.Gender

        _B14E
        inc a
        asl a
        tax
        lda aMapBattleChildCrySounds,x
        sta wR0,b

        _B158
        plx
        rtl

        .databank 0

        ; 9E/B15A

    .endsection Unsorted9EB0F2Section


    .section Table9EB15ASection

      .al
      .xl

      aMapBattleChildCrySounds ; 9E/B15A

        ; Read by rlMapBattleGetChildCry.

        .word $0024, $0024, $0025

        ; 9E/B160

    .endsection Table9EB15ASection


    .section Unsorted9EB160Section

      .al
      .xl

      rlMapBattlePlayHitSound ; 9E/B160

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the sprite: the round's hit sound, panned to the defender: $94 for a fatal strike (BattleRoundFlagFatal), $93 for a ranged one, else $91 or $93 by the striking side's bit 0 of aMapAction; none for a staff with a magic effect. A critical adds sound $4E.

        phy
        phx
        lda @l $001057,x
        dec a
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        sta wR1
        and #$0010
        beq _B17B
        lda #$0094
        sta wR0
        bra _B1C8


        _B17B
        lda wMapMagicEffect
        cmp #$FFFF
        beq _B19B
        lda #1,s
        tax
        lda @l $001057,x
        dec a
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        bit #$0002
        beq _B1BC
        jml _B211


        _B19B
        lda wR1
        and #$0020
        beq _B1A9
        lda #$0093
        sta wR0
        bra _B1C8


        _B1A9
        lda wR1
        and #$0001
        and #$0001
        asl a
        tax
        lda $7F454A,x
        and #$0001
        bne _B1C3

        _B1BC
        lda #$0091
        sta wR0
        bra _B1C8


        _B1C3
        lda #$0093
        sta wR0

        _B1C8
        lda aMapAction.wMapBattleDefenderSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay
        lda $7F57EA
        bne _B1E0
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay

        _B1E0
        tya
        sta $7F57EA
        jsl rlGetSoundPanFromXPixel
        ora wR0
        jsl rlPlaySoundEffect2
        lda #1,s
        tax
        lda @l $001057,x
        dec a
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        bit #$0004
        beq _B211
        lda $7F57EA
        jsl rlGetSoundPanFromXPixel
        ora #$004E
        jsl rlPlaySoundEffect2

        _B211
        plx
        ply
        rtl

        .databank 0

        ; 9E/B214

      rlMapBattlePlayNoDamageSound ; 9E/B214

        .al
        .xl
        .autsiz
        .databank ?

        ; Sound $95 panned to the defender, unless a magic effect plays.

        phy
        phx
        lda wMapMagicEffect
        cmp #$FFFF
        bne _B249
        lda #$0095
        sta wR0
        lda aMapAction.wMapBattleDefenderSpriteSlot
        tax
        lda @l $001200,x
        tay
        lda $7F57EA
        bne _B23E
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda @l $001200,x
        tay

        _B23E
        tya
        jsl rlGetSoundPanFromXPixel
        ora wR0
        jsl rlPlaySoundEffect2

        _B249
        plx
        ply
        rtl

        .databank 0

        ; 9E/B24C

      rlMapBattlePlayLordDodgeSound ; 9E/B24C

        .al
        .xl
        .autsiz
        .databank ?

        ; On a miss with no magic effect, at step $23 of the round counter: sound $97 when the side the round bit 0 picks is a Junior Lord or a Prince (classes $2C, $2E).

        phy
        phx
        lda aMapAction.wMapBattleRoundCounter
        cmp #$0023
        bne _B2AE
        lda #$FFFE
        sta aMapAction.wMapBattleRoundCounter
        lda wMapMagicEffect
        cmp #$FFFF
        bne _B2B7
        ldx #$0000
        lda $7F4BEB
        and #$0001
        bne _B276
        ldx #$0002

        _B276
        lda aMapAction.wBattleClassID,x
        cmp #$002C
        beq _B284
        cmp #$002E
        bne _B2B7

        _B284
        lda #$0097
        sta wR0
        bra _B28B


        _B28B
        lda aMapAction.wMapBattleDefenderSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay
        lda $7F57EA
        bne _B2A3
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay

        _B2A3
        tya
        jsl rlGetSoundPanFromXPixel
        ora wR0
        jsl rlPlaySoundEffect2

        _B2AE
        lda aMapAction.wMapBattleRoundCounter
        inc a
        sta aMapAction.wMapBattleRoundCounter

        _B2B7
        plx
        ply
        rtl

        .databank 0

        ; 9E/B2BA

    .endsection Unsorted9EB160Section


    .section Unsorted9EB345Section

      .al
      .xl

      rlMapBattlePlaySound48 ; 9E/B345

        .al
        .xl
        .autsiz
        .databank ?

        ; Sound $48 ($49 when aActionStructUnit1's X is 0) panned to the attacker's sprite.

        phy
        phx
        lda #$0048
        sta wR0
        lda aActionStructUnit1.XPosition
        bne _B357
        lda #$0049
        sta wR0

        _B357
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsl rlGetSoundPanFromXPixel
        ora wR0
        jsl rlPlaySoundEffect2
        plx
        ply
        rtl

        .databank 0

        ; 9E/B36C

      rlMapBattlePlaySound3D ; 9E/B36C

        .al
        .xl
        .autsiz
        .databank ?

        ; Sound $3D panned to the defender's sprite (the attacker's when the defender has none).

        phy
        phx
        lda aMapAction.wMapBattleDefenderSpriteSlot
        cmp #$FFFF
        beq _B382
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay
        lda $7F57EA
        bne _B390

        _B382
        lda aMapAction.wMapBattleAttackerSpriteSlot
        cmp #$FFFF
        beq _B39C
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay

        _B390
        tya
        jsl rlGetSoundPanFromXPixel
        ora #$003D
        jsl rlPlaySoundEffect2

        _B39C
        plx
        ply
        rtl

        .databank 0

        ; 9E/B39F

      rlMapBattlePlaySound2E ; 9E/B39F

        .al
        .xl
        .autsiz
        .databank ?

        ; Sound $2E panned to the defender's sprite (the attacker's when $7F57EA is set).

        phy
        phx
        lda aMapAction.wMapBattleDefenderSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay
        lda $7F57EA
        beq _B3B9
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay

        _B3B9
        tya
        jsl rlGetSoundPanFromXPixel
        ora #$002E
        jsl rlPlaySoundEffect2
        plx
        ply
        rtl

        .databank 0

        ; 9E/B3C8

    .endsection Unsorted9EB345Section


    .section Unreferenced9EB3C8Section

      .al
      .xl

      rlMapBattlePlaySound2F ; 9E/B3C8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Found by tools/sweep.py: nothing in the build reaches this. Sound $2F panned to the defender's sprite.

        phx
        lda aMapAction.wMapBattleDefenderSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsl rlGetSoundPanFromXPixel
        ora #$002F
        jsl rlPlaySoundEffect2
        plx
        rtl

        .databank 0

        ; 9E/B3DE

    .endsection Unreferenced9EB3C8Section
    .section Unsorted9EB3DESection

      .al
      .xl

      rlMapBattlePlaySound32 ; 9E/B3DE

        .al
        .xl
        .autsiz
        .databank ?

        ; Sound $32 panned to the caster (wMapMagicCasterPixel).

        phx
        lda wMapMagicCasterPixel
        and #$00FF
        jsl rlGetSoundPanFromXPixel
        ora #$0032
        jsl rlPlaySoundEffect2
        plx
        rtl

        .databank 0

        ; 9E/B3F3

      rlMapBattleLowerMusic ; 9E/B3F3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4C05
        bne _B41A
        lda #$0001
        sta $7F4C05
        lda #$00F7
        jsl rlSendSoundCommand
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _B41A
        plx
        rtl

        .databank 0

        ; 9E/B41C

      rlMapBattleRestoreMusic ; 9E/B41C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C05
        beq _B431
        lda #$0000
        sta $7F4C05
        lda #$00E8
        jsl rlSendSoundCommand

        _B431
        plx
        rtl

        .databank 0

        ; 9E/B433

      rlMapBattleSetMusicID ; 9E/B433

        .al
        .xl
        .autsiz
        .databank ?

        ; Stores A in wMusicID.

        ; Unreferenced: stores A in $04BA.

        sta wMusicID,b
        rtl

        .databank 0

        ; 9E/B437

      rlMapBattleSetMusicID2 ; 9E/B437

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: the same code as rlMapBattleSetMusicID.

        ; Unreferenced: the same as rlMapBattleSetMusicID.

        sta wMusicID,b
        rtl

        .databank 0

        ; 9E/B43B

      rlMapBattlePlaySoundAtAttacker ; 9E/B43B

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced. Sound A panned to the attacker's sprite.

        ; Unreferenced.

        phy
        phx
        sta wR0
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsl rlGetSoundPanFromXPixel
        ora wR0
        jsl rlPlaySoundEffect2
        plx
        ply
        rtl

        .databank 0

        ; 9E/B454

      rlMapBattlePlaySoundAtAttackerDebug ; 9E/B454

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced. As rlMapBattlePlaySoundAtAttacker; with exactly Start held on controller 2, plays the value $1000 instead.

        ; Unreferenced.

        phy
        phx
        sta wR0
        lda wJoy2Input
        cmp #$1000
        bne _B461
        sta wR0

        _B461
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsl rlGetSoundPanFromXPixel
        ora wR0
        jsl rlPlaySoundEffect2
        plx
        ply
        rtl

        .databank 0

        ; 9E/B476

      rlMapBattlePlaySoundAtSprite ; 9E/B476

        .al
        .xl
        .autsiz
        .databank ?

        ; Sound A panned to the map position of $7F57EE (rlUnknown9E8D25).

        ; Unreferenced.

        phx
        sta wR2
        lda $7F57EE
        tax
        tay
        jsl rlUnknown9E8D25
        lda wR0
        jsl rlGetSoundPanFromXPixel
        ora wR2
        jsl rlPlaySoundEffect2
        plx
        rtl

        .databank 0

        ; 9E/B491

    .endsection Unsorted9EB3DESection


    .section Unsorted9EB491Section

      .al
      .xl

      rlPlayGoldObtainedJingle ; 9E/B491

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0092
        bra rlPlayStatGainSound._B4B5

      rlPlayGoldStolenJingle ; 9E/B497

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0093
        bra rlPlayStatGainSound._B4B5

      rlPlayItemObtainedJingle ; 9E/B49D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0092
        bra rlPlayStatGainSound._B4B5

      rlPlayWeaponBrokeJingle ; 9E/B4A3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0093
        bra rlPlayStatGainSound._B4B5

      rlPlayLevelUpJingle ; 9E/B4A9

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0091
        bra rlPlayStatGainSound._B4B5

        .databank 0

        ; 9E/B4AF

      rlPlayStatGainSound ; 9E/B4AF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0023
        bra _B4B5


        _B4B5
        jsl rlPlaySoundEffect
        plx
        rtl

        .databank 0

        ; 9E/B4BB

    .endsection Unsorted9EB491Section


    .section Unsorted9EB4BBSection

      .al
      .xl

      rlGetSoundPanFromXPixel ; 9E/B4BB

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the stereo position for a sound at X pixel X (high byte), for rlPlaySoundEffect2.

        and #$00FF
        lsr a
        lsr a
        lsr a
        cmp #$0010
        bcs _B4C7
        inc a

        _B4C7
        xba
        rtl

        .databank 0

        ; 9E/B4C9

    .endsection Unsorted9EB4BBSection


    .section Table9EB4C9Section

      .al
      .xl

      aUnknown9EB4C9 ; 9E/B4C9

        ; Read by rlUnknown9E8D6C, rlUnknown9E8DBB, rsActiveSpriteCommand03.

        .word $0000, $2000

        ; 9E/B4CD

    .endsection Table9EB4C9Section


    .section Table9EB4CDSection

      .al
      .xl

      aUnknown9EB4CD ; 9E/B4CD

        ; Read by rlUnknown9E8D6C.

        .word $0000, $0000, $0000, $0400, $0600

        ; 9E/B4D7

    .endsection Table9EB4CDSection


    .section Table9EB4D7Section

      .al
      .xl

      aUnknown9EB4D7 ; 9E/B4D7

        ; Read by rlUnknown9E8DBB, rsActiveSpriteCommand03.

        .word $0200, $0280

        ; 9E/B4DB

    .endsection Table9EB4D7Section


    .section Table9EB4DBSection

      .al
      .xl

      aUnknown9EB4DB ; 9E/B4DB

        ; Read by rlUnknown9E8D6C, rlUnknown9E8E01.

        .word $0400, $0600

        ; 9E/B4DF

    .endsection Table9EB4DBSection


    .section BattleMapSpriteDataSection

      .al
      .xl

      aBattleMapSpriteData ; 9E/B50D

        ; Graphics for the units in map battles. Indexed by
        ; aMapAction.wBattleClassID * 49 + frame * 6. Each row has 8 frames,
        ; each a pair of long pointers to compressed graphics (the second is
        ; read at +3), then a byte whose meaning is unknown. The row names
        ; come from the original notes; some classes have more than one row.

        ; Cavalier
        .long aMapBattleCavalierLayout0, g4bppcMapBattleCavalier0, aMapBattleCavalierLayout1, g4bppcMapBattleCavalier1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleCavalier2, aMapBattleCavalierLayout3, g4bppcMapBattleCavalier3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleCavalier3, aMapBattleCavalierLayout5, g4bppcMapBattleCavalier5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleCavalier6, aMapBattleCavalierLayout7, g4bppcMapBattleCavalier0
        .byte 1
        ; LanceKnight
        .long aMapBattleLanceKnightLayout0, g4bppcMapBattleCavalier0, aMapBattleLanceKnightLayout1, g4bppcMapBattleCavalier1
        .long aMapBattleLanceKnightLayout2, g4bppcMapBattleCavalier2, aMapBattleLanceKnightLayout3, g4bppcMapBattleCavalier3
        .long aMapBattleLanceKnightLayout4, g4bppcMapBattleCavalier3, aMapBattleLanceKnightLayout5, g4bppcMapBattleCavalier5
        .long aMapBattleLanceKnightLayout6, g4bppcMapBattleCavalier6, aMapBattleLanceKnightLayout7, g4bppcMapBattleCavalier0
        .byte 1
        ; BowKnight
        .long aMapBattleCavalierLayout0, g4bppcMapBattleCavalier0, aMapBattleCavalierLayout1, g4bppcMapBattleCavalier1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleCavalier2, aMapBattleCavalierLayout3, g4bppcMapBattleCavalier3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleCavalier3, aMapBattleCavalierLayout5, g4bppcMapBattleCavalier5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleCavalier6, aMapBattleCavalierLayout7, g4bppcMapBattleCavalier0
        .byte 1
        ; AxeKnight
        .long aMapBattleLanceKnightLayout0, g4bppcMapBattleCavalier0, aMapBattleLanceKnightLayout1, g4bppcMapBattleCavalier1
        .long aMapBattleLanceKnightLayout2, g4bppcMapBattleCavalier2, aMapBattleLanceKnightLayout3, g4bppcMapBattleCavalier3
        .long aMapBattleLanceKnightLayout4, g4bppcMapBattleCavalier3, aMapBattleLanceKnightLayout5, g4bppcMapBattleCavalier5
        .long aMapBattleLanceKnightLayout6, g4bppcMapBattleCavalier6, aMapBattleLanceKnightLayout7, g4bppcMapBattleCavalier0
        .byte 1
        ; FreeKnight
        .long aMapBattleLanceKnightLayout0, g4bppcMapBattleCavalier0, aMapBattleLanceKnightLayout1, g4bppcMapBattleCavalier1
        .long aMapBattleLanceKnightLayout2, g4bppcMapBattleCavalier2, aMapBattleLanceKnightLayout3, g4bppcMapBattleCavalier3
        .long aMapBattleLanceKnightLayout4, g4bppcMapBattleCavalier3, aMapBattleLanceKnightLayout5, g4bppcMapBattleCavalier5
        .long aMapBattleLanceKnightLayout6, g4bppcMapBattleCavalier6, aMapBattleLanceKnightLayout7, g4bppcMapBattleCavalier0
        .byte 1
        ; Troubadour
        .long aMapBattleLanceKnightLayout0, g4bppcMapBattleTroubadour0, aMapBattleLanceKnightLayout1, g4bppcMapBattleTroubadour1
        .long aMapBattleLanceKnightLayout2, g4bppcMapBattleTroubadour2, aMapBattleLanceKnightLayout3, g4bppcMapBattleTroubadour3
        .long aMapBattleLanceKnightLayout4, g4bppcMapBattleTroubadour3, aMapBattleLanceKnightLayout5, g4bppcMapBattleTroubadour5
        .long aMapBattleLanceKnightLayout6, g4bppcMapBattleTroubadour6, aMapBattleLanceKnightLayout7, g4bppcMapBattleTroubadour0
        .byte 1
        ; KnightLord
        .long aMapBattleCavalierLayout0, g4bppcMapBattleKnightLord0, aMapBattleCavalierLayout1, g4bppcMapBattleKnightLord1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleKnightLord2, aMapBattleCavalierLayout3, g4bppcMapBattleKnightLord3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleKnightLord3, aMapBattleCavalierLayout5, g4bppcMapBattleKnightLord5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleKnightLord6, aMapBattleCavalierLayout7, g4bppcMapBattleKnightLord0
        .byte 1
        ; DukeKnight
        .long aMapBattleCavalierLayout0, g4bppcMapBattleDukeKnight0, aMapBattleCavalierLayout1, g4bppcMapBattleDukeKnight1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleDukeKnight2, aMapBattleCavalierLayout3, g4bppcMapBattleDukeKnight3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleDukeKnight3, aMapBattleCavalierLayout5, g4bppcMapBattleDukeKnight5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleDukeKnight6, aMapBattleCavalierLayout7, g4bppcMapBattleDukeKnight0
        .byte 1
        ; MasterKnight
        .long aMapBattleCavalierLayout0, g4bppcMapBattleMasterKnight0, aMapBattleCavalierLayout1, g4bppcMapBattleMasterKnight1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleMasterKnight2, aMapBattleCavalierLayout3, g4bppcMapBattleMasterKnight3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleMasterKnight3, aMapBattleCavalierLayout5, g4bppcMapBattleMasterKnight5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleMasterKnight6, aMapBattleCavalierLayout7, g4bppcMapBattleMasterKnight0
        .byte 1
        ; Paladin
        .long aMapBattleCavalierLayout0, g4bppcMapBattlePaladin0, aMapBattleCavalierLayout1, g4bppcMapBattlePaladin1
        .long aMapBattleCavalierLayout2, g4bppcMapBattlePaladin2, aMapBattleCavalierLayout3, g4bppcMapBattlePaladin3
        .long aMapBattleCavalierLayout4, g4bppcMapBattlePaladin3, aMapBattleCavalierLayout5, g4bppcMapBattlePaladin5
        .long aMapBattleCavalierLayout6, g4bppcMapBattlePaladin6, aMapBattleCavalierLayout7, g4bppcMapBattlePaladin0
        .byte 1
        ; PaladinF
        .long aMapBattleCavalierLayout0, g4bppcMapBattlePaladinF0, aMapBattleCavalierLayout1, g4bppcMapBattlePaladinF1
        .long aMapBattleCavalierLayout2, g4bppcMapBattlePaladinF2, aMapBattleCavalierLayout3, g4bppcMapBattlePaladinF3
        .long aMapBattleCavalierLayout4, g4bppcMapBattlePaladinF3, aMapBattleCavalierLayout5, g4bppcMapBattlePaladinF5
        .long aMapBattleCavalierLayout6, g4bppcMapBattlePaladinF6, aMapBattleCavalierLayout7, g4bppcMapBattlePaladinF0
        .byte 1
        ; ArchKnight
        .long aMapBattleCavalierLayout0, g4bppcMapBattleArchKnight0, aMapBattleCavalierLayout1, g4bppcMapBattleArchKnight1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleArchKnight2, aMapBattleCavalierLayout3, g4bppcMapBattleArchKnight3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleArchKnight3, aMapBattleCavalierLayout5, g4bppcMapBattleArchKnight5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleArchKnight6, aMapBattleCavalierLayout7, g4bppcMapBattleArchKnight0
        .byte 1
        ; Ranger
        .long aMapBattleCavalierLayout0, g4bppcMapBattleRanger0, aMapBattleCavalierLayout1, g4bppcMapBattleRanger1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleRanger2, aMapBattleCavalierLayout3, g4bppcMapBattleRanger3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleRanger3, aMapBattleCavalierLayout5, g4bppcMapBattleRanger5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleRanger6, aMapBattleCavalierLayout7, g4bppcMapBattleRanger0
        .byte 1
        ; MageKnight
        .long aMapBattleCavalierLayout0, g4bppcMapBattleMageKnight0, aMapBattleCavalierLayout1, g4bppcMapBattleMageKnight1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleMageKnight2, aMapBattleCavalierLayout3, g4bppcMapBattleMageKnight3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleMageKnight3, aMapBattleCavalierLayout5, g4bppcMapBattleMageKnight5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleMageKnight6, aMapBattleCavalierLayout7, g4bppcMapBattleMageKnight0
        .byte 1
        ; GreatKnight
        .long aMapBattleCavalierLayout0, g4bppcMapBattleGreatKnight0, aMapBattleCavalierLayout1, g4bppcMapBattleGreatKnight1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleGreatKnight2, aMapBattleCavalierLayout3, g4bppcMapBattleGreatKnight3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleGreatKnight3, aMapBattleCavalierLayout5, g4bppcMapBattleGreatKnight5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleGreatKnight6, aMapBattleCavalierLayout7, g4bppcMapBattleGreatKnight0
        .byte 1
        ; PegasusRider
        .long aMapBattlePegasusRiderLayout0, g4bppcMapBattlePegasusRider0, aMapBattlePegasusRiderLayout1, g4bppcMapBattlePegasusRider1
        .long aMapBattlePegasusRiderLayout2, g4bppcMapBattlePegasusRider2, aMapBattlePegasusRiderLayout3, g4bppcMapBattlePegasusRider3
        .long aMapBattlePegasusRiderLayout4, g4bppcMapBattlePegasusRider3, aMapBattlePegasusRiderLayout5, g4bppcMapBattlePegasusRider5
        .long aMapBattlePegasusRiderLayout6, g4bppcMapBattlePegasusRider6, aMapBattlePegasusRiderLayout7, g4bppcMapBattlePegasusRider0
        .byte 1
        ; PegasusKnight
        .long aMapBattlePegasusRiderLayout0, g4bppcMapBattlePegasusKnight0, aMapBattlePegasusRiderLayout1, g4bppcMapBattlePegasusKnight1
        .long aMapBattlePegasusRiderLayout2, g4bppcMapBattlePegasusKnight2, aMapBattlePegasusRiderLayout3, g4bppcMapBattlePegasusKnight3
        .long aMapBattlePegasusRiderLayout4, g4bppcMapBattlePegasusKnight3, aMapBattlePegasusRiderLayout5, g4bppcMapBattlePegasusKnight5
        .long aMapBattlePegasusRiderLayout6, g4bppcMapBattlePegasusKnight6, aMapBattlePegasusRiderLayout7, g4bppcMapBattlePegasusKnight0
        .byte 1
        ; FalconKnight
        .long aMapBattlePegasusRiderLayout0, g4bppcMapBattleFalconKnight0, aMapBattlePegasusRiderLayout1, g4bppcMapBattleFalconKnight1
        .long aMapBattlePegasusRiderLayout2, g4bppcMapBattleFalconKnight2, aMapBattlePegasusRiderLayout3, g4bppcMapBattleFalconKnight3
        .long aMapBattlePegasusRiderLayout4, g4bppcMapBattleFalconKnight3, aMapBattlePegasusRiderLayout5, g4bppcMapBattleFalconKnight5
        .long aMapBattlePegasusRiderLayout6, g4bppcMapBattleFalconKnight6, aMapBattlePegasusRiderLayout7, g4bppcMapBattleFalconKnight0
        .byte 1
        ; Dragonrider
        .long aMapBattleDragonriderLayout0, g4bppcMapBattleDragonrider0, aMapBattleDragonriderLayout1, g4bppcMapBattleDragonrider1
        .long aMapBattleDragonriderLayout2, g4bppcMapBattleDragonrider2, aMapBattleDragonriderLayout3, g4bppcMapBattleDragonrider3
        .long aMapBattleDragonriderLayout4, g4bppcMapBattleDragonrider3, aMapBattleDragonriderLayout5, g4bppcMapBattleDragonrider5
        .long aMapBattleDragonriderLayout6, g4bppcMapBattleDragonrider6, aMapBattleDragonriderLayout7, g4bppcMapBattleDragonrider0
        .byte 1
        ; Dragonknight
        .long aMapBattleDragonriderLayout0, g4bppcMapBattleDragonknight0, aMapBattleDragonriderLayout1, g4bppcMapBattleDragonknight1
        .long aMapBattleDragonriderLayout2, g4bppcMapBattleDragonknight2, aMapBattleDragonriderLayout3, g4bppcMapBattleDragonknight3
        .long aMapBattleDragonriderLayout4, g4bppcMapBattleDragonknight3, aMapBattleDragonriderLayout5, g4bppcMapBattleDragonknight5
        .long aMapBattleDragonriderLayout6, g4bppcMapBattleDragonknight6, aMapBattleDragonriderLayout7, g4bppcMapBattleDragonknight0
        .byte 1
        ; Dragonmaster
        .long aMapBattleDragonriderLayout0, g4bppcMapBattleDragonmaster0, aMapBattleDragonriderLayout1, g4bppcMapBattleDragonmaster1
        .long aMapBattleDragonriderLayout2, g4bppcMapBattleDragonmaster2, aMapBattleDragonriderLayout3, g4bppcMapBattleDragonmaster3
        .long aMapBattleDragonriderLayout4, g4bppcMapBattleDragonmaster3, aMapBattleDragonriderLayout5, g4bppcMapBattleDragonmaster5
        .long aMapBattleDragonriderLayout6, g4bppcMapBattleDragonmaster6, aMapBattleDragonriderLayout7, g4bppcMapBattleDragonmaster0
        .byte 1
        ; Archer
        .long aMapBattleArcherLayout0, g4bppcMapBattleArcher0, aMapBattleArcherLayout1, g4bppcMapBattleArcher1
        .long aMapBattleArcherLayout2, g4bppcMapBattleArcher2, aMapBattleArcherLayout3, g4bppcMapBattleArcher3
        .long aMapBattleArcherLayout4, g4bppcMapBattleArcher3, aMapBattleArcherLayout5, g4bppcMapBattleArcher5
        .long aMapBattleArcherLayout6, g4bppcMapBattleArcher6, aMapBattleArcherLayout7, g4bppcMapBattleArcher0
        .byte 0
        ; Myrmidon
        .long aMapBattleMyrmidonLayout0, g4bppcMapBattleMyrmidon0, aMapBattleMyrmidonLayout1, g4bppcMapBattleMyrmidon1
        .long aMapBattleMyrmidonLayout2, g4bppcMapBattleMyrmidon2, aMapBattleMyrmidonLayout3, g4bppcMapBattleMyrmidon3
        .long aMapBattleMyrmidonLayout4, g4bppcMapBattleMyrmidon3, aMapBattleMyrmidonLayout5, g4bppcMapBattleMyrmidon5
        .long aMapBattleMyrmidonLayout6, g4bppcMapBattleMyrmidon6, aMapBattleMyrmidonLayout7, g4bppcMapBattleMyrmidon0
        .byte 0
        ; Swordmaster
        .long aMapBattleMyrmidonLayout0, g4bppcMapBattleSwordmaster0, aMapBattleMyrmidonLayout1, g4bppcMapBattleSwordmaster1
        .long aMapBattleMyrmidonLayout2, g4bppcMapBattleSwordmaster2, aMapBattleMyrmidonLayout3, g4bppcMapBattleSwordmaster3
        .long aMapBattleMyrmidonLayout4, g4bppcMapBattleSwordmaster3, aMapBattleMyrmidonLayout5, g4bppcMapBattleSwordmaster5
        .long aMapBattleMyrmidonLayout6, g4bppcMapBattleSwordmaster6, aMapBattleMyrmidonLayout7, g4bppcMapBattleSwordmaster0
        .byte 0
        ; Sniper
        .long aMapBattleArcherLayout0, g4bppcMapBattleSniper0, aMapBattleArcherLayout1, g4bppcMapBattleSniper1
        .long aMapBattleArcherLayout2, g4bppcMapBattleSniper2, aMapBattleArcherLayout3, g4bppcMapBattleSniper3
        .long aMapBattleArcherLayout4, g4bppcMapBattleSniper3, aMapBattleArcherLayout5, g4bppcMapBattleSniper5
        .long aMapBattleArcherLayout6, g4bppcMapBattleSniper6, aMapBattleArcherLayout7, g4bppcMapBattleSniper0
        .byte 0
        ; Hero
        .long aMapBattleMyrmidonLayout0, g4bppcMapBattleHero0, aMapBattleMyrmidonLayout1, g4bppcMapBattleHero1
        .long aMapBattleMyrmidonLayout2, g4bppcMapBattleHero2, aMapBattleMyrmidonLayout3, g4bppcMapBattleHero3
        .long aMapBattleMyrmidonLayout4, g4bppcMapBattleHero3, aMapBattleMyrmidonLayout5, g4bppcMapBattleHero5
        .long aMapBattleMyrmidonLayout6, g4bppcMapBattleHero6, aMapBattleMyrmidonLayout7, g4bppcMapBattleHero0
        .byte 0
        ; General
        .long aMapBattleGeneralLayout0, g4bppcMapBattleGeneral0, aMapBattleGeneralLayout1, g4bppcMapBattleGeneral1
        .long aMapBattleGeneralLayout2, g4bppcMapBattleGeneral2, aMapBattleGeneralLayout3, g4bppcMapBattleGeneral3
        .long aMapBattleGeneralLayout4, g4bppcMapBattleGeneral3, aMapBattleGeneralLayout5, g4bppcMapBattleGeneral5
        .long aMapBattleGeneralLayout6, g4bppcMapBattleGeneral6, aMapBattleGeneralLayout7, g4bppcMapBattleGeneral0
        .byte 0
        ; Emperor
        .long aMapBattleGeneralLayout0, g4bppcMapBattleEmperor0, aMapBattleGeneralLayout1, g4bppcMapBattleEmperor1
        .long aMapBattleGeneralLayout2, g4bppcMapBattleEmperor2, aMapBattleGeneralLayout3, g4bppcMapBattleEmperor3
        .long aMapBattleGeneralLayout4, g4bppcMapBattleEmperor3, aMapBattleGeneralLayout5, g4bppcMapBattleEmperor5
        .long aMapBattleGeneralLayout6, g4bppcMapBattleEmperor6, aMapBattleGeneralLayout7, g4bppcMapBattleEmperor0
        .byte 0
        ; Baron
        .long aMapBattleGeneralLayout0, g4bppcMapBattleBaron0, aMapBattleGeneralLayout1, g4bppcMapBattleBaron1
        .long aMapBattleGeneralLayout2, g4bppcMapBattleBaron2, aMapBattleGeneralLayout3, g4bppcMapBattleBaron3
        .long aMapBattleGeneralLayout4, g4bppcMapBattleBaron3, aMapBattleGeneralLayout5, g4bppcMapBattleBaron5
        .long aMapBattleGeneralLayout6, g4bppcMapBattleBaron6, aMapBattleGeneralLayout7, g4bppcMapBattleBaron0
        .byte 0
        ; Soldier
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; SpearSoldier
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; AxeSoldier
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; BowSoldier
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; SwordSoldier
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; LanceArmor
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; AxeArmor
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; BowArmor
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; SwordArmor
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; Barbarian
        .long aMapBattleBarbarianLayout0, g4bppcMapBattleBarbarian0, aMapBattleBarbarianLayout1, g4bppcMapBattleBarbarian1
        .long aMapBattleBarbarianLayout2, g4bppcMapBattleBarbarian2, aMapBattleBarbarianLayout3, g4bppcMapBattleBarbarian3
        .long aMapBattleBarbarianLayout4, g4bppcMapBattleBarbarian3, aMapBattleBarbarianLayout5, g4bppcMapBattleBarbarian5
        .long aMapBattleBarbarianLayout6, g4bppcMapBattleBarbarian6, aMapBattleBarbarianLayout7, g4bppcMapBattleBarbarian0
        .byte 0
        ; Fighter
        .long aMapBattleBarbarianLayout0, g4bppcMapBattleFighter0, aMapBattleBarbarianLayout1, g4bppcMapBattleFighter1
        .long aMapBattleBarbarianLayout2, g4bppcMapBattleFighter2, aMapBattleBarbarianLayout3, g4bppcMapBattleFighter3
        .long aMapBattleBarbarianLayout4, g4bppcMapBattleFighter3, aMapBattleBarbarianLayout5, g4bppcMapBattleFighter5
        .long aMapBattleBarbarianLayout6, g4bppcMapBattleFighter6, aMapBattleBarbarianLayout7, g4bppcMapBattleFighter0
        .byte 0
        ; Brigand
        .long aMapBattleBarbarianLayout0, g4bppcMapBattleBrigand0, aMapBattleBarbarianLayout1, g4bppcMapBattleBrigand1
        .long aMapBattleBarbarianLayout2, g4bppcMapBattleBrigand2, aMapBattleBarbarianLayout3, g4bppcMapBattleBrigand3
        .long aMapBattleBarbarianLayout4, g4bppcMapBattleBrigand3, aMapBattleBarbarianLayout5, g4bppcMapBattleBrigand5
        .long aMapBattleBarbarianLayout6, g4bppcMapBattleBrigand6, aMapBattleBarbarianLayout7, g4bppcMapBattleBrigand0
        .byte 0
        ; Warrior
        .long aMapBattleWarriorLayout0, g4bppcMapBattleWarrior0, aMapBattleWarriorLayout1, g4bppcMapBattleWarrior1
        .long aMapBattleWarriorLayout2, g4bppcMapBattleWarrior2, aMapBattleWarriorLayout3, g4bppcMapBattleWarrior3
        .long aMapBattleWarriorLayout4, g4bppcMapBattleWarrior3, aMapBattleWarriorLayout5, g4bppcMapBattleWarrior5
        .long aMapBattleWarriorLayout6, g4bppcMapBattleWarrior6, aMapBattleWarriorLayout7, g4bppcMapBattleWarrior0
        .byte 0
        ; Hunter
        .long aMapBattleWarriorLayout0, g4bppcMapBattleHunter0, aMapBattleWarriorLayout1, g4bppcMapBattleHunter1
        .long aMapBattleWarriorLayout2, g4bppcMapBattleHunter2, aMapBattleWarriorLayout3, g4bppcMapBattleHunter3
        .long aMapBattleWarriorLayout4, g4bppcMapBattleHunter3, aMapBattleWarriorLayout5, g4bppcMapBattleHunter5
        .long aMapBattleWarriorLayout6, g4bppcMapBattleHunter6, aMapBattleWarriorLayout7, g4bppcMapBattleHunter0
        .byte 0
        ; Pirate
        .long aMapBattleBarbarianLayout0, g4bppcMapBattlePirate0, aMapBattleBarbarianLayout1, g4bppcMapBattlePirate1
        .long aMapBattleBarbarianLayout2, g4bppcMapBattlePirate2, aMapBattleBarbarianLayout3, g4bppcMapBattlePirate3
        .long aMapBattleBarbarianLayout4, g4bppcMapBattlePirate3, aMapBattleBarbarianLayout5, g4bppcMapBattlePirate5
        .long aMapBattleBarbarianLayout6, g4bppcMapBattlePirate6, aMapBattleBarbarianLayout7, g4bppcMapBattlePirate0
        .byte 0
        ; JuniorLord
        .long aMapBattleJuniorLordLayout0, g4bppcMapBattleJuniorLord0, aMapBattleJuniorLordLayout1, g4bppcMapBattleJuniorLord1
        .long aMapBattleJuniorLordLayout2, g4bppcMapBattleJuniorLord2, aMapBattleJuniorLordLayout3, g4bppcMapBattleJuniorLord3
        .long aMapBattleJuniorLordLayout4, g4bppcMapBattleJuniorLord3, aMapBattleJuniorLordLayout5, g4bppcMapBattleJuniorLord5
        .long aMapBattleJuniorLordLayout6, g4bppcMapBattleJuniorLord6, aMapBattleJuniorLordLayout7, g4bppcMapBattleJuniorLord0
        .byte 0
        ; WarMage
        .long aMapBattleWarMageLayout0, g4bppcMapBattleWarMage0, aMapBattleWarMageLayout1, g4bppcMapBattleWarMage1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleWarMage2, aMapBattleWarMageLayout3, g4bppcMapBattleWarMage3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleWarMage3, aMapBattleWarMageLayout5, g4bppcMapBattleWarMage5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleWarMage6, aMapBattleWarMageLayout7, g4bppcMapBattleWarMage0
        .byte 0
        ; Prince
        .long aMapBattleJuniorLordLayout0, g4bppcMapBattlePrince0, aMapBattleJuniorLordLayout1, g4bppcMapBattlePrince1
        .long aMapBattleJuniorLordLayout2, g4bppcMapBattlePrince2, aMapBattleJuniorLordLayout3, g4bppcMapBattlePrince3
        .long aMapBattleJuniorLordLayout4, g4bppcMapBattlePrince3, aMapBattleJuniorLordLayout5, g4bppcMapBattlePrince5
        .long aMapBattleJuniorLordLayout6, g4bppcMapBattlePrince6, aMapBattleJuniorLordLayout7, g4bppcMapBattlePrince0
        .byte 0
        ; Princess
        .long aMapBattleWarMageLayout0, g4bppcMapBattlePrincess0, aMapBattleWarMageLayout1, g4bppcMapBattlePrincess1
        .long aMapBattleWarMageLayout2, g4bppcMapBattlePrincess2, aMapBattleWarMageLayout3, g4bppcMapBattlePrincess3
        .long aMapBattleWarMageLayout4, g4bppcMapBattlePrincess3, aMapBattleWarMageLayout5, g4bppcMapBattlePrincess5
        .long aMapBattleWarMageLayout6, g4bppcMapBattlePrincess6, aMapBattleWarMageLayout7, g4bppcMapBattlePrincess0
        .byte 0
        ; WarMageF
        .long aMapBattleWarMageLayout0, g4bppcMapBattleWarMageF0, aMapBattleWarMageLayout1, g4bppcMapBattleWarMageF1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleWarMageF2, aMapBattleWarMageLayout3, g4bppcMapBattleWarMageF3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleWarMageF3, aMapBattleWarMageLayout5, g4bppcMapBattleWarMageF5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleWarMageF6, aMapBattleWarMageLayout7, g4bppcMapBattleWarMageF0
        .byte 0
        ; Queen
        .long aMapBattleWarMageLayout0, g4bppcMapBattleQueen0, aMapBattleWarMageLayout1, g4bppcMapBattleQueen1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleQueen2, aMapBattleWarMageLayout3, g4bppcMapBattleQueen3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleQueen3, aMapBattleWarMageLayout5, g4bppcMapBattleQueen5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleQueen6, aMapBattleWarMageLayout7, g4bppcMapBattleQueen0
        .byte 0
        ; Dancer
        .long aMapBattleDancerLayout0, g4bppcMapBattleDancer0, aMapBattleDancerLayout1, g4bppcMapBattleDancer1
        .long aMapBattleDancerLayout2, g4bppcMapBattleDancer2, aMapBattleDancerLayout3, g4bppcMapBattleDancer3
        .long aMapBattleDancerLayout4, g4bppcMapBattleDancer3, aMapBattleDancerLayout5, g4bppcMapBattleDancer5
        .long aMapBattleDancerLayout6, g4bppcMapBattleDancer6, aMapBattleDancerLayout7, g4bppcMapBattleDancer0
        .byte 0
        ; Priest
        .long aMapBattleWarMageLayout0, g4bppcMapBattlePriest0, aMapBattleWarMageLayout1, g4bppcMapBattlePriest1
        .long aMapBattleWarMageLayout2, g4bppcMapBattlePriest2, aMapBattleWarMageLayout3, g4bppcMapBattlePriest3
        .long aMapBattleWarMageLayout4, g4bppcMapBattlePriest3, aMapBattleWarMageLayout5, g4bppcMapBattlePriest5
        .long aMapBattleWarMageLayout6, g4bppcMapBattlePriest6, aMapBattleWarMageLayout7, g4bppcMapBattlePriest0
        .byte 0
        ; Mage
        .long aMapBattleWarMageLayout0, g4bppcMapBattleMage0, aMapBattleWarMageLayout1, g4bppcMapBattleMage1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleMage2, aMapBattleWarMageLayout3, g4bppcMapBattleMage3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleMage3, aMapBattleWarMageLayout5, g4bppcMapBattleMage5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleMage6, aMapBattleWarMageLayout7, g4bppcMapBattleMage0
        .byte 0
        ; FireMage
        .long aMapBattleWarMageLayout0, g4bppcMapBattleFireMage0, aMapBattleWarMageLayout1, g4bppcMapBattleFireMage1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleFireMage2, aMapBattleWarMageLayout3, g4bppcMapBattleFireMage3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleFireMage3, aMapBattleWarMageLayout5, g4bppcMapBattleFireMage5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleFireMage6, aMapBattleWarMageLayout7, g4bppcMapBattleFireMage0
        .byte 0
        ; ThunderMage
        .long aMapBattleWarMageLayout0, g4bppcMapBattleThunderMage0, aMapBattleWarMageLayout1, g4bppcMapBattleThunderMage1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleThunderMage2, aMapBattleWarMageLayout3, g4bppcMapBattleThunderMage3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleThunderMage3, aMapBattleWarMageLayout5, g4bppcMapBattleThunderMage5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleThunderMage6, aMapBattleWarMageLayout7, g4bppcMapBattleThunderMage0
        .byte 0
        ; WindMage
        .long aMapBattleWarMageLayout0, g4bppcMapBattleWindMage0, aMapBattleWarMageLayout1, g4bppcMapBattleWindMage1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleWindMage2, aMapBattleWarMageLayout3, g4bppcMapBattleWindMage3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleWindMage3, aMapBattleWarMageLayout5, g4bppcMapBattleWindMage5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleWindMage6, aMapBattleWarMageLayout7, g4bppcMapBattleWindMage0
        .byte 0
        ; HighPriest
        .long aMapBattleWarMageLayout0, g4bppcMapBattleHighPriest0, aMapBattleWarMageLayout1, g4bppcMapBattleHighPriest1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleHighPriest2, aMapBattleWarMageLayout3, g4bppcMapBattleHighPriest3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleHighPriest3, aMapBattleWarMageLayout5, g4bppcMapBattleHighPriest5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleHighPriest6, aMapBattleWarMageLayout7, g4bppcMapBattleHighPriest0
        .byte 0
        ; Bishop
        .long aMapBattleWarMageLayout0, g4bppcMapBattleBishop0, aMapBattleWarMageLayout1, g4bppcMapBattleBishop1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleBishop2, aMapBattleWarMageLayout3, g4bppcMapBattleBishop3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleBishop3, aMapBattleWarMageLayout5, g4bppcMapBattleBishop5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleBishop6, aMapBattleWarMageLayout7, g4bppcMapBattleBishop0
        .byte 0
        ; Sage
        .long aMapBattleWarMageLayout0, g4bppcMapBattleSage0, aMapBattleWarMageLayout1, g4bppcMapBattleSage1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleSage2, aMapBattleWarMageLayout3, g4bppcMapBattleSage3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleSage3, aMapBattleWarMageLayout5, g4bppcMapBattleSage5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleSage6, aMapBattleWarMageLayout7, g4bppcMapBattleSage0
        .byte 0
        ; Bard
        .long aMapBattleWarMageLayout0, g4bppcMapBattleBard0, aMapBattleWarMageLayout1, g4bppcMapBattleBard1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleBard2, aMapBattleWarMageLayout3, g4bppcMapBattleBard3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleBard3, aMapBattleWarMageLayout5, g4bppcMapBattleBard5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleBard6, aMapBattleWarMageLayout7, g4bppcMapBattleBard0
        .byte 0
        ; Priestess
        .long aMapBattleWarMageLayout0, g4bppcMapBattlePriestess0, aMapBattleWarMageLayout1, g4bppcMapBattlePriestess1
        .long aMapBattleWarMageLayout2, g4bppcMapBattlePriestess2, aMapBattleWarMageLayout3, g4bppcMapBattlePriestess3
        .long aMapBattleWarMageLayout4, g4bppcMapBattlePriestess3, aMapBattleWarMageLayout5, g4bppcMapBattlePriestess5
        .long aMapBattleWarMageLayout6, g4bppcMapBattlePriestess6, aMapBattleWarMageLayout7, g4bppcMapBattlePriestess0
        .byte 0
        ; DarkMage
        .long aMapBattleWarMageLayout0, g4bppcMapBattleDarkMage0, aMapBattleWarMageLayout1, g4bppcMapBattleDarkMage1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleDarkMage2, aMapBattleWarMageLayout3, g4bppcMapBattleDarkMage3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleDarkMage3, aMapBattleWarMageLayout5, g4bppcMapBattleDarkMage5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleDarkMage6, aMapBattleWarMageLayout7, g4bppcMapBattleDarkMage0
        .byte 0
        ; DarkBishop
        .long aMapBattleWarMageLayout0, g4bppcMapBattleDarkBishop0, aMapBattleWarMageLayout1, g4bppcMapBattleDarkBishop1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleDarkBishop2, aMapBattleWarMageLayout3, g4bppcMapBattleDarkBishop3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleDarkBishop3, aMapBattleWarMageLayout5, g4bppcMapBattleDarkBishop5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleDarkBishop6, aMapBattleWarMageLayout7, g4bppcMapBattleDarkBishop0
        .byte 0
        ; Thief
        .long aMapBattleThiefLayout0, g4bppcMapBattleThief0, aMapBattleThiefLayout1, g4bppcMapBattleThief1
        .long aMapBattleThiefLayout2, g4bppcMapBattleThief2, aMapBattleThiefLayout3, g4bppcMapBattleThief3
        .long aMapBattleThiefLayout4, g4bppcMapBattleThief3, aMapBattleThiefLayout5, g4bppcMapBattleThief5
        .long aMapBattleThiefLayout6, g4bppcMapBattleThief6, aMapBattleThiefLayout7, g4bppcMapBattleThief0
        .byte 0
        ; Rogue
        .long aMapBattleThiefLayout0, g4bppcMapBattleRogue0, aMapBattleThiefLayout1, g4bppcMapBattleRogue1
        .long aMapBattleThiefLayout2, g4bppcMapBattleRogue2, aMapBattleThiefLayout3, g4bppcMapBattleRogue3
        .long aMapBattleThiefLayout4, g4bppcMapBattleRogue3, aMapBattleThiefLayout5, g4bppcMapBattleRogue5
        .long aMapBattleThiefLayout6, g4bppcMapBattleRogue6, aMapBattleThiefLayout7, g4bppcMapBattleRogue0
        .byte 0
        ; Civilian
        .long aMapBattleDancerLayout0, g4bppcMapBattleCivilian0, aMapBattleDancerLayout1, g4bppcMapBattleCivilian1
        .long aMapBattleDancerLayout2, g4bppcMapBattleCivilian2, aMapBattleDancerLayout3, g4bppcMapBattleCivilian3
        .long aMapBattleDancerLayout4, g4bppcMapBattleCivilian3, aMapBattleDancerLayout5, g4bppcMapBattleCivilian5
        .long aMapBattleDancerLayout6, g4bppcMapBattleCivilian6, aMapBattleDancerLayout7, g4bppcMapBattleCivilian0
        .byte 0
        ; Child
        .long aMapBattleDancerLayout0, g4bppcMapBattleChild0, aMapBattleDancerLayout1, g4bppcMapBattleChild1
        .long aMapBattleDancerLayout2, g4bppcMapBattleChild2, aMapBattleDancerLayout3, g4bppcMapBattleChild3
        .long aMapBattleDancerLayout4, g4bppcMapBattleChild3, aMapBattleDancerLayout5, g4bppcMapBattleChild5
        .long aMapBattleDancerLayout6, g4bppcMapBattleChild6, aMapBattleDancerLayout7, g4bppcMapBattleChild0
        .byte 0
        ; Ballistician
        .long aMapBattleBallisticianLayout0, g4bppcMapBattleBallistician0, aMapBattleBallisticianLayout1, g4bppcMapBattleBallistician1
        .long aMapBattleBallisticianLayout2, g4bppcMapBattleBallistician2, aMapBattleBallisticianLayout3, g4bppcMapBattleBallistician3
        .long aMapBattleBallisticianLayout4, g4bppcMapBattleBallistician4, aMapBattleBallisticianLayout5, g4bppcMapBattleBallistician5
        .long aMapBattleBallisticianLayout6, g4bppcMapBattleBallistician6, aMapBattleBallisticianLayout7, g4bppcMapBattleBallistician7
        .byte 1
        ; IronBallistician
        .long aMapBattleBallisticianLayout0, g4bppcMapBattleIronBallistician0, aMapBattleBallisticianLayout1, g4bppcMapBattleIronBallistician1
        .long aMapBattleBallisticianLayout2, g4bppcMapBattleIronBallistician2, aMapBattleBallisticianLayout3, g4bppcMapBattleIronBallistician3
        .long aMapBattleBallisticianLayout4, g4bppcMapBattleIronBallistician4, aMapBattleBallisticianLayout5, g4bppcMapBattleIronBallistician5
        .long aMapBattleBallisticianLayout6, g4bppcMapBattleIronBallistician6, aMapBattleBallisticianLayout7, g4bppcMapBattleIronBallistician7
        .byte 1
        ; KillerBallistician
        .long aMapBattleBallisticianLayout0, g4bppcMapBattleKillerBallistician0, aMapBattleBallisticianLayout1, g4bppcMapBattleKillerBallistician1
        .long aMapBattleBallisticianLayout2, g4bppcMapBattleKillerBallistician2, aMapBattleBallisticianLayout3, g4bppcMapBattleKillerBallistician3
        .long aMapBattleBallisticianLayout4, g4bppcMapBattleKillerBallistician4, aMapBattleBallisticianLayout5, g4bppcMapBattleKillerBallistician5
        .long aMapBattleBallisticianLayout6, g4bppcMapBattleKillerBallistician6, aMapBattleBallisticianLayout7, g4bppcMapBattleKillerBallistician7
        .byte 1
        ; GreatBallistician
        .long aMapBattleBallisticianLayout0, g4bppcMapBattleGreatBallistician0, aMapBattleBallisticianLayout1, g4bppcMapBattleGreatBallistician1
        .long aMapBattleBallisticianLayout2, g4bppcMapBattleGreatBallistician2, aMapBattleBallisticianLayout3, g4bppcMapBattleGreatBallistician3
        .long aMapBattleBallisticianLayout4, g4bppcMapBattleGreatBallistician4, aMapBattleBallisticianLayout5, g4bppcMapBattleGreatBallistician5
        .long aMapBattleBallisticianLayout6, g4bppcMapBattleGreatBallistician6, aMapBattleBallisticianLayout7, g4bppcMapBattleGreatBallistician7
        .byte 1
        ; DarkPrince
        .long aMapBattleWarMageLayout0, g4bppcMapBattleDarkPrince0, aMapBattleWarMageLayout1, g4bppcMapBattleDarkPrince1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleDarkPrince2, aMapBattleWarMageLayout3, g4bppcMapBattleDarkPrince3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleDarkPrince3, aMapBattleWarMageLayout5, g4bppcMapBattleDarkPrince5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleDarkPrince6, aMapBattleWarMageLayout7, g4bppcMapBattleDarkPrince0
        .byte 0
        ; MasterKnightFemale
        .long aMapBattleCavalierLayout0, g4bppcMapBattleMasterKnightFemale0, aMapBattleCavalierLayout1, g4bppcMapBattleMasterKnightFemale1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleMasterKnightFemale2, aMapBattleCavalierLayout3, g4bppcMapBattleMasterKnightFemale3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleMasterKnightFemale3, aMapBattleCavalierLayout5, g4bppcMapBattleMasterKnightFemale5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleMasterKnightFemale6, aMapBattleCavalierLayout7, g4bppcMapBattleMasterKnightFemale0
        .byte 1
        ; MageKnightFemale
        .long aMapBattleCavalierLayout0, g4bppcMapBattleMageKnightFemale0, aMapBattleCavalierLayout1, g4bppcMapBattleMageKnightFemale1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleMageKnightFemale2, aMapBattleCavalierLayout3, g4bppcMapBattleMageKnightFemale3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleMageKnightFemale3, aMapBattleCavalierLayout5, g4bppcMapBattleMageKnightFemale5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleMageKnightFemale6, aMapBattleCavalierLayout7, g4bppcMapBattleMageKnightFemale0
        .byte 1
        ; DragonRiderFemale
        .long aMapBattleDragonriderLayout0, g4bppcMapBattleDragonRiderFemale0, aMapBattleDragonriderLayout1, g4bppcMapBattleDragonRiderFemale1
        .long aMapBattleDragonriderLayout2, g4bppcMapBattleDragonRiderFemale2, aMapBattleDragonriderLayout3, g4bppcMapBattleDragonRiderFemale3
        .long aMapBattleDragonriderLayout4, g4bppcMapBattleDragonRiderFemale3, aMapBattleDragonriderLayout5, g4bppcMapBattleDragonRiderFemale5
        .long aMapBattleDragonriderLayout6, g4bppcMapBattleDragonRiderFemale6, aMapBattleDragonriderLayout7, g4bppcMapBattleDragonRiderFemale0
        .byte 1
        ; DragonknightFemale
        .long aMapBattleDragonriderLayout0, g4bppcMapBattleDragonknightFemale0, aMapBattleDragonriderLayout1, g4bppcMapBattleDragonknightFemale1
        .long aMapBattleDragonriderLayout2, g4bppcMapBattleDragonknightFemale2, aMapBattleDragonriderLayout3, g4bppcMapBattleDragonknightFemale3
        .long aMapBattleDragonriderLayout4, g4bppcMapBattleDragonknightFemale3, aMapBattleDragonriderLayout5, g4bppcMapBattleDragonknightFemale5
        .long aMapBattleDragonriderLayout6, g4bppcMapBattleDragonknightFemale6, aMapBattleDragonriderLayout7, g4bppcMapBattleDragonknightFemale0
        .byte 1
        ; DragonmasterFemale
        .long aMapBattleDragonriderLayout0, g4bppcMapBattleDragonmasterFemale0, aMapBattleDragonriderLayout1, g4bppcMapBattleDragonmasterFemale1
        .long aMapBattleDragonriderLayout2, g4bppcMapBattleDragonmasterFemale2, aMapBattleDragonriderLayout3, g4bppcMapBattleDragonmasterFemale3
        .long aMapBattleDragonriderLayout4, g4bppcMapBattleDragonmasterFemale3, aMapBattleDragonriderLayout5, g4bppcMapBattleDragonmasterFemale5
        .long aMapBattleDragonriderLayout6, g4bppcMapBattleDragonmasterFemale6, aMapBattleDragonriderLayout7, g4bppcMapBattleDragonmasterFemale0
        .byte 1
        ; ArcherFemale
        .long aMapBattleArcherLayout0, g4bppcMapBattleArcherFemale0, aMapBattleArcherLayout1, g4bppcMapBattleArcherFemale1
        .long aMapBattleArcherLayout2, g4bppcMapBattleArcherFemale2, aMapBattleArcherLayout3, g4bppcMapBattleArcherFemale3
        .long aMapBattleArcherLayout4, g4bppcMapBattleArcherFemale3, aMapBattleArcherLayout5, g4bppcMapBattleArcherFemale5
        .long aMapBattleArcherLayout6, g4bppcMapBattleArcherFemale6, aMapBattleArcherLayout7, g4bppcMapBattleArcherFemale0
        .byte 0
        ; MyrmidonFemale
        .long aMapBattleMyrmidonLayout0, g4bppcMapBattleMyrmidonFemale0, aMapBattleMyrmidonLayout1, g4bppcMapBattleMyrmidonFemale1
        .long aMapBattleMyrmidonLayout2, g4bppcMapBattleMyrmidonFemale2, aMapBattleMyrmidonLayout3, g4bppcMapBattleMyrmidonFemale3
        .long aMapBattleMyrmidonLayout4, g4bppcMapBattleMyrmidonFemale3, aMapBattleMyrmidonLayout5, g4bppcMapBattleMyrmidonFemale5
        .long aMapBattleMyrmidonLayout6, g4bppcMapBattleMyrmidonFemale6, aMapBattleMyrmidonLayout7, g4bppcMapBattleMyrmidonFemale0
        .byte 0
        ; SwordmasterFemale
        .long aMapBattleMyrmidonLayout0, g4bppcMapBattleSwordmasterFemale0, aMapBattleMyrmidonLayout1, g4bppcMapBattleSwordmasterFemale1
        .long aMapBattleMyrmidonLayout2, g4bppcMapBattleSwordmasterFemale2, aMapBattleMyrmidonLayout3, g4bppcMapBattleSwordmasterFemale3
        .long aMapBattleMyrmidonLayout4, g4bppcMapBattleSwordmasterFemale3, aMapBattleMyrmidonLayout5, g4bppcMapBattleSwordmasterFemale5
        .long aMapBattleMyrmidonLayout6, g4bppcMapBattleSwordmasterFemale6, aMapBattleMyrmidonLayout7, g4bppcMapBattleSwordmasterFemale0
        .byte 0
        ; SniperFemale
        .long aMapBattleArcherLayout0, g4bppcMapBattleSniperFemale0, aMapBattleArcherLayout1, g4bppcMapBattleSniperFemale1
        .long aMapBattleArcherLayout2, g4bppcMapBattleSniperFemale2, aMapBattleArcherLayout3, g4bppcMapBattleSniperFemale3
        .long aMapBattleArcherLayout4, g4bppcMapBattleSniperFemale3, aMapBattleArcherLayout5, g4bppcMapBattleSniperFemale5
        .long aMapBattleArcherLayout6, g4bppcMapBattleSniperFemale6, aMapBattleArcherLayout7, g4bppcMapBattleSniperFemale0
        .byte 0
        ; HeroFemale
        .long aMapBattleMyrmidonLayout0, g4bppcMapBattleHeroFemale0, aMapBattleMyrmidonLayout1, g4bppcMapBattleHeroFemale1
        .long aMapBattleMyrmidonLayout2, g4bppcMapBattleHeroFemale2, aMapBattleMyrmidonLayout3, g4bppcMapBattleHeroFemale3
        .long aMapBattleMyrmidonLayout4, g4bppcMapBattleHeroFemale3, aMapBattleMyrmidonLayout5, g4bppcMapBattleHeroFemale5
        .long aMapBattleMyrmidonLayout6, g4bppcMapBattleHeroFemale6, aMapBattleMyrmidonLayout7, g4bppcMapBattleHeroFemale0
        .byte 0
        ; PriestFemale
        .long aMapBattleWarMageLayout0, g4bppcMapBattlePriestFemale0, aMapBattleWarMageLayout1, g4bppcMapBattlePriestFemale1
        .long aMapBattleWarMageLayout2, g4bppcMapBattlePriestFemale2, aMapBattleWarMageLayout3, g4bppcMapBattlePriestFemale3
        .long aMapBattleWarMageLayout4, g4bppcMapBattlePriestFemale3, aMapBattleWarMageLayout5, g4bppcMapBattlePriestFemale5
        .long aMapBattleWarMageLayout6, g4bppcMapBattlePriestFemale6, aMapBattleWarMageLayout7, g4bppcMapBattlePriestFemale0
        .byte 0
        ; MageFemale
        .long aMapBattleWarMageLayout0, g4bppcMapBattleMageFemale0, aMapBattleWarMageLayout1, g4bppcMapBattleMageFemale1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleMageFemale2, aMapBattleWarMageLayout3, g4bppcMapBattleMageFemale3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleMageFemale3, aMapBattleWarMageLayout5, g4bppcMapBattleMageFemale5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleMageFemale6, aMapBattleWarMageLayout7, g4bppcMapBattleMageFemale0
        .byte 0
        ; FireMageFemale
        .long aMapBattleWarMageLayout0, g4bppcMapBattleFireMageFemale0, aMapBattleWarMageLayout1, g4bppcMapBattleFireMageFemale1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleFireMageFemale2, aMapBattleWarMageLayout3, g4bppcMapBattleFireMageFemale3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleFireMageFemale3, aMapBattleWarMageLayout5, g4bppcMapBattleFireMageFemale5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleFireMageFemale6, aMapBattleWarMageLayout7, g4bppcMapBattleFireMageFemale0
        .byte 0
        ; ThunderMageFemale
        .long aMapBattleWarMageLayout0, g4bppcMapBattleThunderMageFemale0, aMapBattleWarMageLayout1, g4bppcMapBattleThunderMageFemale1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleThunderMageFemale2, aMapBattleWarMageLayout3, g4bppcMapBattleThunderMageFemale3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleThunderMageFemale3, aMapBattleWarMageLayout5, g4bppcMapBattleThunderMageFemale5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleThunderMageFemale6, aMapBattleWarMageLayout7, g4bppcMapBattleThunderMageFemale0
        .byte 0
        ; WindMageFemale
        .long aMapBattleWarMageLayout0, g4bppcMapBattleWindMageFemale0, aMapBattleWarMageLayout1, g4bppcMapBattleWindMageFemale1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleWindMageFemale2, aMapBattleWarMageLayout3, g4bppcMapBattleWindMageFemale3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleWindMageFemale3, aMapBattleWarMageLayout5, g4bppcMapBattleWindMageFemale5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleWindMageFemale6, aMapBattleWarMageLayout7, g4bppcMapBattleWindMageFemale0
        .byte 0
        ; HighPriestFemale
        .long aMapBattleWarMageLayout0, g4bppcMapBattleHighPriestFemale0, aMapBattleWarMageLayout1, g4bppcMapBattleHighPriestFemale1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleHighPriestFemale2, aMapBattleWarMageLayout3, g4bppcMapBattleHighPriestFemale3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleHighPriestFemale3, aMapBattleWarMageLayout5, g4bppcMapBattleHighPriestFemale5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleHighPriestFemale6, aMapBattleWarMageLayout7, g4bppcMapBattleHighPriestFemale0
        .byte 0
        ; SageFemale
        .long aMapBattleWarMageLayout0, g4bppcMapBattleSageFemale0, aMapBattleWarMageLayout1, g4bppcMapBattleSageFemale1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleSageFemale2, aMapBattleWarMageLayout3, g4bppcMapBattleSageFemale3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleSageFemale3, aMapBattleWarMageLayout5, g4bppcMapBattleSageFemale5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleSageFemale6, aMapBattleWarMageLayout7, g4bppcMapBattleSageFemale0
        .byte 0
        ; ThiefFemale
        .long aMapBattleThiefLayout0, g4bppcMapBattleThiefFemale0, aMapBattleThiefLayout1, g4bppcMapBattleThiefFemale1
        .long aMapBattleThiefLayout2, g4bppcMapBattleThiefFemale2, aMapBattleThiefLayout3, g4bppcMapBattleThiefFemale3
        .long aMapBattleThiefLayout4, g4bppcMapBattleThiefFemale3, aMapBattleThiefLayout5, g4bppcMapBattleThiefFemale5
        .long aMapBattleThiefLayout6, g4bppcMapBattleThiefFemale6, aMapBattleThiefLayout7, g4bppcMapBattleThiefFemale0
        .byte 0
        ; RogueFemale
        .long aMapBattleThiefLayout0, g4bppcMapBattleRogueFemale0, aMapBattleThiefLayout1, g4bppcMapBattleRogueFemale1
        .long aMapBattleThiefLayout2, g4bppcMapBattleRogueFemale2, aMapBattleThiefLayout3, g4bppcMapBattleRogueFemale3
        .long aMapBattleThiefLayout4, g4bppcMapBattleRogueFemale3, aMapBattleThiefLayout5, g4bppcMapBattleRogueFemale5
        .long aMapBattleThiefLayout6, g4bppcMapBattleRogueFemale6, aMapBattleThiefLayout7, g4bppcMapBattleRogueFemale0
        .byte 0
        ; CivilianFemale
        .long aMapBattleDancerLayout0, g4bppcMapBattleCivilianFemale0, aMapBattleDancerLayout1, g4bppcMapBattleCivilianFemale1
        .long aMapBattleDancerLayout2, g4bppcMapBattleCivilianFemale2, aMapBattleDancerLayout3, g4bppcMapBattleCivilianFemale3
        .long aMapBattleDancerLayout4, g4bppcMapBattleCivilianFemale3, aMapBattleDancerLayout5, g4bppcMapBattleCivilianFemale5
        .long aMapBattleDancerLayout6, g4bppcMapBattleCivilianFemale6, aMapBattleDancerLayout7, g4bppcMapBattleCivilianFemale0
        .byte 0
        ; ChildFemale
        .long aMapBattleDancerLayout0, g4bppcMapBattleChildFemale0, aMapBattleDancerLayout1, g4bppcMapBattleChildFemale1
        .long aMapBattleDancerLayout2, g4bppcMapBattleChildFemale2, aMapBattleDancerLayout3, g4bppcMapBattleChildFemale3
        .long aMapBattleDancerLayout4, g4bppcMapBattleChildFemale3, aMapBattleDancerLayout5, g4bppcMapBattleChildFemale5
        .long aMapBattleDancerLayout6, g4bppcMapBattleChildFemale6, aMapBattleDancerLayout7, g4bppcMapBattleChildFemale0
        .byte 0
        ; (no name in the original notes)
        .long aMapBattleCavalierLayout0, g4bppcMapBattleChildFemale8, aMapBattleCavalierLayout1, g4bppcMapBattleChildFemale9
        .long aMapBattleCavalierLayout2, g4bppcMapBattleChildFemale10, aMapBattleCavalierLayout3, g4bppcMapBattleChildFemale11
        .long aMapBattleCavalierLayout4, g4bppcMapBattleChildFemale11, aMapBattleCavalierLayout5, g4bppcMapBattleChildFemale13
        .long aMapBattleCavalierLayout6, g4bppcMapBattleChildFemale14, aMapBattleCavalierLayout7, g4bppcMapBattleChildFemale8
        .byte 1

        ; 9E/C70B

    .endsection BattleMapSpriteDataSection


    .section Unsorted9EC70BSection

      .al
      .xl

      procMapBattle ; 9E/C70B

        .structProcInfo "ON", rlProcMapBattleInit, rlProcMapBattleCycle, aProcMapBattleCode

      rlProcMapBattleInit ; 9E/C713
      
        .al
        .autsiz
        .databank ?

        lda wGameStateRoutine1,b
        sta aProcSystem.aBody7,b,x

        stz wGameStateRoutine1,b
        jsl rlPauseMapSpriteAnimation
        jsl rlPauseMapTileAnimation

        lda #1
        sta aProcSystem.aBody4,b,x
        sta $7F4C2D

        lda #0
        sta aMapAction.wMapBattleRoundIndex
        sta $7F4BE7
        sta $7F4BE9
        sta $7F4C05
        sta $7F4C07
        sta $7F50CB

        lda #$FFFF
        sta $7F4BED
        sta $7F4BEF
        sta wMapBattleStatusSword
        sta $7F4BF3
        sta $7F4C1F

        jsl rlSetMapMagicFlags

        lda aActiveSpriteSystem.wFlag,b
        sta $7F4BD9

        lda aActiveSpriteSystem.wFlag,b
        ora #$4000
        sta aActiveSpriteSystem.wFlag,b

        rtl

        .databank 0

      rlProcMapBattleCycle ; 9E/C775
      
        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/C776

    .endsection Unsorted9EC70BSection


    .section Unsorted9EC776Section

      .al
      .xl

      rlProcUnknown9EC70BCycle2 ; 9E/C776

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlInitMapBattleCombatants
        jsl rlUnknown9E88F9
        lda #(`rlPushToOAMBufferDualTileBase)<<8
        sta $15E5,b
        lda #<>rlPushToOAMBufferDualTileBase
        sta $15E4,b
        lda #<>rlUnknown9EC79B
        sta aProcSystem.aHeaderOnCycle,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/C79B

    .endsection Unsorted9EC776Section


    .section Unsorted9EC79BSection

      .al
      .xl

      rlUnknown9EC79B ; 9E/C79B

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        and #$00FF
        bne rlUnknown9EC7B2
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlUnknown9EC7B2
        sta aProcSystem.aHeaderOnCycle,b,x

        .databank 0

      rlUnknown9EC7B2 ; 9E/C7B2

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/C7B3

    .endsection Unsorted9EC79BSection


    .section Unsorted9EC7B3Section

      .al
      .xl

      rlProcUnknown9EC70BCycle3 ; 9E/C7B3

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$FFFF
        sta aMapAction.wMapBattleAttackerSpriteSlot
        sta aMapAction.wMapBattleAttackerAuxSpriteSlot
        sta aMapAction.wMapBattleDefenderSpriteSlot
        sta aMapAction.wMapBattleDefenderAuxSpriteSlot
        jsl rlUnknown9E88CE
        jsl rlSelectMapBattleAttackerSprite
        lda #$0000
        jsl rlMapBattleQueueSpriteData
        lda aActionStructUnit2
        cmp #$FFFF
        beq _C7F1
        jsl rlSelectMapBattleDefenderSprite
        lda #$0001
        jsl rlMapBattleQueueSpriteData

        _C7F1
        lda #<>rlUnknown9EC79B
        sta aProcSystem.aHeaderOnCycle,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/C7FA

      rlShowMapBattleAttacker ; 9E/C7FA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda aMapAction.wYTilePosition
        cmp aMapAction.wUnknown7F4558
        bne _C812
        lda aMapAction.wXTilePosition
        cmp aMapAction.wUnknown7F4556
        bcc _C814
        bra _C821


        _C812
        bcc _C821

        _C814
        jsl rlCreateMapBattleDefenderSprites
        lda #$0001
        jsl rlUnknown9EADD1
        bra _C82C


        _C821
        jsl rlCreateMapBattleAttackerSprites
        lda #$0000
        jsl rlUnknown9EADD1

        _C82C
        jsl rlEnableOAMScanlineFlicker
        plx
        ply
        rtl

        .databank 0

        ; 9E/C833

      rlShowMapBattleDefender ; 9E/C833

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda aMapAction.wYTilePosition
        cmp aMapAction.wUnknown7F4558
        bne _C84B
        lda aMapAction.wXTilePosition
        cmp aMapAction.wUnknown7F4556
        bcc _C84D
        bra _C85A


        _C84B
        bcc _C85A

        _C84D
        jsl rlCreateMapBattleAttackerSprites
        lda #$0000
        jsl rlUnknown9EADD1
        bra _C865


        _C85A
        jsl rlCreateMapBattleDefenderSprites
        lda #$0001
        jsl rlUnknown9EADD1

        _C865
        plx
        ply
        rtl

        .databank 0

        ; 9E/C868

      rlProcUnknown9EC70BCycle6 ; 9E/C868

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        sta aMapAction.wMapBattleActiveSpriteAckFlag
        sta aMapAction.wMapBattlePhaseFlag
        sta wMapMagicStart
        sta wMapMagicDone
        sta aMapAction.wMapBattleRoundCounter
        sta aMapAction.wMapBattlePaletteRestoreFlag
        sta aMapAction.wMapBattleLevelUpFrameCounter
        sta aProcSystem.aHeaderBitfield,b,x
        plx
        ply
        lda #<>rlUnknown9EC899
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/C899

    .endsection Unsorted9EC7B3Section


    .section Unsorted9EC899Section

      .al
      .xl

      rlUnknown9EC899 ; 9E/C899

        .al
        .xl
        .autsiz
        .databank ?

        lda aMapAction.wMapBattlePhaseFlag
        beq _C8A5
        lda #<>rlUnknown9EC8A6
        sta aProcSystem.aHeaderOnCycle,b,x

        _C8A5
        rtl

        .databank 0

        ; 9E/C8A6

      rlUnknown9EC8A6 ; 9E/C8A6

        .al
        .xl
        .autsiz
        .databank ?

        lda aMapAction.wMapBattlePhaseFlag
        bne _C8B2
        lda #<>rlUnknown9EC8B3
        sta aProcSystem.aHeaderOnCycle,b,x

        _C8B2
        rtl

        .databank 0

        ; 9E/C8B3

    .endsection Unsorted9EC899Section


    .section Unsorted9EC8B3Section

      .al
      .xl

      rlUnknown9EC8B3 ; 9E/C8B3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aBattleRoundsData)<<8
        sta lStructPointer2+1,b
        lda #<>aBattleRoundsData
        sta lStructPointer2,b
        lda aProcSystem.aBody4,b,x
        sta wStructIndex,b
        jsl rlLoadRAMStructDataByIndex
        lda lStructPointer1,b
        sta aProcSystem.aBody5,b,x
        sta $7F4C2F
        inc aProcSystem.aBody4,b,x
        lda aProcSystem.aBody4,b,x
        sta wStructIndex,b
        jsl rlLoadRAMStructDataByIndex
        lda lStructPointer1,b
        sta aProcSystem.aBody5,b,x
        cmp #$FFFF
        beq _C907
        cmp #$7F00
        bne _C8F7
        lda #$0001
        sta $7F4C07

        _C8F7
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl


        _C907
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        rtl

        .databank 0

        ; 9E/C91A

    .endsection Unsorted9EC8B3Section


    .section Unsorted9EC91ASection

      .al
      .xl

      rlMapBattleOpenExperienceWindow ; 9E/C91A

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7E4ECF
        beq _C943
        jsl rlUnknown9EA140
        jsl rlOpenMapBattleExperienceWindow
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _C943
        rtl

        .databank 0

        ; 9E/C944

      rlMapBattleWaitExperienceWindow ; 9E/C944

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlCheckMapBattleExperienceWindowOpen
        cmp #$FFFF
        beq _C956
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _C956
        rtl

        .databank 0

        ; 9E/C957

      rlProcMapBattleEnd ; 9E/C957

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$CE9E
        sta aProcSystem.aHeaderCodeOffset,b,x
        lda #$0001
        sta aProcSystem.aHeaderSleepTimer,b,x
        jsl rlEndMapBattleRestoreMap
        jsl rlLoadCursorSpriteGraphics
        phb
        jsl rlLoadMapSpriteOAMPalettes
        plb
        .databank ?
        lda wBattleType
        and #$00FF
        cmp #$0003
        bne _C982
        jsl rlCastleRestoreCourtyardPalettes

        _C982
        plx
        lda #<>rlUnknown9EC98A
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/C98A

    .endsection Unsorted9EC91ASection


    .section Unsorted9EC98ASection

      .al
      .xl

      rlUnknown9EC98A ; 9E/C98A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7E4EA9
        and #$00FF
        cmp #$0003
        beq _C9A4
        jsl rlSetCameraTargetForCursor
        bcc _C9A4
        lda #<>rlUnknown9EC9AB
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _C9AA


        _C9A4
        lda #<>rlUnknown9EC9BD
        sta aProcSystem.aHeaderOnCycle,b,x

        _C9AA
        rtl

        .databank 0

        ; 9E/C9AB

      rlUnknown9EC9AB ; 9E/C9AB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlStepCameraTowardsTarget
        bcc _C9BB
        plx
        lda #<>rlUnknown9EC9BD
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _C9BC


        _C9BB
        plx

        _C9BC
        rtl

        .databank 0

        ; 9E/C9BD

      rlUnknown9EC9BD ; 9E/C9BD

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlCloseMapBattleHPWindows
        lda #<>rlUnknown9EC9C8
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/C9C8

      rlUnknown9EC9C8 ; 9E/C9C8

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlRestoreMapBattlePalettes
        lda #<>rlUnknown9EC9D3
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/C9D3

      rlUnknown9EC9D3 ; 9E/C9D3

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlReloadMenuIconGraphics
        bcs _C9FC
        lda wMapBattleMode
        bne _C9E3
        jsl rlCheckActiveUnitCanto

        _C9E3
        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        jsl rlUnknown9EA1D7
        jsl rlProcEngineFreeProc
        lda $7F4C07
        ora #$0002
        sta $7F4C07

        _C9FC
        rtl

        .databank 0

        ; 9E/C9FD

    .endsection Unsorted9EC98ASection


    .section Unsorted9EC9FDSection

      .al
      .xl

      rlUnknown9EC9FD ; 9E/C9FD

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlQueueMapMagicBackgroundTiles
        jsl rlQueueMapMagicBackgroundTilemap
        jsl rlQueueMapMagicBackgroundPalette
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/CA10

      rlProcMapBattleOpenHPWindows ; 9E/CA10

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMapBattleHUDGraphics
        bcc _CA17
        rtl


        _CA17
        lda aActionStructUnit2
        cmp #$FFFF
        beq _CA34
        lda wMapBattleMode
        bne _CA34
        jsl rlUnknown9EAB5D
        bcs _CA34
        jsl rlSetMapBattlePalettes
        jsl rlOpenMapBattleHPWindows

        _CA34
        lda #<>rlUnknown9ECA3A
        sta aProcSystem.aHeaderOnCycle,b,x

      rlUnknown9ECA3A ; 9E/CA3A

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/CA3B

      rlUnknown9ECA3B ; 9E/CA3B

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        rtl

        .databank 0

        ; 9E/CA45

      rlMapBattleLoadHUD ; 9E/CA45

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMapBattleHUDGraphics
        bcc _CA4C
        rtl


        _CA4C
        jsl rlSetMapBattlePalettes
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlUnknown9ECA5F
        sta aProcSystem.aHeaderOnCycle,b,x

      rlUnknown9ECA5F ; 9E/CA5F

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/CA60

      rlUnknown9ECA60 ; 9E/CA60

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda aActionStructUnit2
        cmp #$FFFF
        beq _CA9A
        jsl rlUnknown9EAB5D
        bcs _CA9A
        lda aProcSystem.aBody5,b,x
        cmp #$FFFF
        bne _CA94
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _CA9A


        _CA94
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x

        _CA9A
        rtl

        .databank 0

        ; 9E/CA9B

      rlProcUnknown9EC70BCycle7 ; 9E/CA9B

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapBattleMode
        bne _CAB4
        jsl rlUnknown9EAB5D
        bcs _CAB4
        jsl rlCheckMapBattleHPWindowsBusy
        cmp #$FFFF
        beq _CABA
        jsl rlRestoreMapBattlePalettes

        _CAB4
        lda #<>rlUnknown9ECABB
        sta aProcSystem.aHeaderOnCycle,b,x

        _CABA
        rtl

        .databank 0

        ; 9E/CABB

    .endsection Unsorted9EC9FDSection


    .section Unsorted9ECABBSection

      .al
      .xl

      rlUnknown9ECABB ; 9E/CABB

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlReloadMenuIconGraphics
        bcs _CAD0
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _CAD0
        rtl

        .databank 0

        ; 9E/CAD1

      rlUnknown9ECAD1 ; 9E/CAD1

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/CAD2

    .endsection Unsorted9ECABBSection


    .section ProcScript9ECAD2Section

      .al
      .xl

      aProcMapBattleCode ; 9E/CAD2

        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown9EC70BCycle2
        _CAD8
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CAD8, $0001
        PROC_SET_ONCYCLE rlProcUnknown9EC70BCycle3
        _CAE4
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CAE4, $0001
        PROC_CALL rlMapBattleSetCameraTarget
        PROC_JUMP_IF_BITS_UNSET _CB04, $0002
        _CAF7
        PROC_YIELD 1
        PROC_CALL rlMapBattleMoveCamera
        PROC_JUMP_IF_BITS_UNSET _CAF7, $0004
        _CB04
        PROC_CALL rlUnknown9E99F7
        PROC_YIELD 4
        PROC_CALL rlShowMapBattleAttacker
        PROC_YIELD 12
        PROC_CALL rlShowMapBattleDefender
        PROC_YIELD 12
        PROC_CALL rlMapBattleStartBattleQuote
        PROC_JUMP_IF_BITS_UNSET _CB52, $0002
        _CB24
        PROC_YIELD 1
        PROC_CALL rlMapBattleRunQuote
        PROC_CALL rlMapBattleCheckQuoteClosed
        PROC_JUMP_IF_BITS_UNSET _CB24, $0004
        PROC_CALL rlDecompressMapBattleTilesAfterQuote
        PROC_YIELD 18
        PROC_CALL rlUploadMapBattleTilesAfterQuote1
        PROC_YIELD 4
        PROC_CALL rlUploadMapBattleTilesAfterQuote2
        PROC_YIELD 4
        PROC_CALL rlUploadMapBattleTilesAfterQuote3
        PROC_YIELD 4
        _CB52
        PROC_CALL rlMapBattleCheckShiftedUnit
        PROC_JUMP_IF_BITS_UNSET _CB6A, $0002
        _CB5D
        PROC_YIELD 1
        PROC_CALL rlMapBattleSlideShiftedUnitOut
        PROC_JUMP_IF_BITS_UNSET _CB5D, $0004
        _CB6A
        PROC_SET_ONCYCLE rlProcMapBattleOpenHPWindows
        PROC_YIELD 48
        _CB70
        PROC_CALL rlStartMapBattleBallistaBolt
        PROC_CALL rlMapBattleNextRound
        PROC_JUMP_IF_BITS_UNSET _CC6C, $0002
        PROC_CALL rlUnknown9EA9B5
        PROC_JUMP_IF_BITS_UNSET _CBA7, $0002
        PROC_SET_UNK_TIMER 96
        _CB8F
        PROC_YIELD 1
        PROC_CALL rlBattleSceneRunPaletteEffects
        PROC_JUMP_WHILE_UNK_TIMER _CB8F
        PROC_CALL rlUnknown9EAB21
        PROC_JUMP_IF_BITS_SET _CB70, $0002
        PROC_YIELD 16
        _CBA7
        PROC_CALL rlMapBattleStartPavise
        PROC_JUMP_IF_BITS_UNSET _CBBF, $0002
        _CBB2
        PROC_YIELD 1
        PROC_CALL rlMapBattleWaitPavise
        PROC_JUMP_IF_BITS_UNSET _CBB2, $0004
        _CBBF
        PROC_CALL rlUnknown9E8C81
        PROC_CALL rlSelectMapMagicEffectForRound
        PROC_JUMP_IF_BITS_UNSET _CC15, $0002
        PROC_SET_ONCYCLE rlUnknown9EC9FD
        PROC_YIELD 16
        PROC_CALL rlUploadMapMagicBackgroundTiles
        PROC_YIELD 2
        PROC_CALL rlUploadMapMagicBackgroundTilesRest
        PROC_YIELD 2
        PROC_CALL rlUploadMapMagicBackgroundTilemap
        PROC_YIELD 2
        PROC_CALL rlCopyMapMagicBackgroundColors
        PROC_YIELD 2
        PROC_CALL rlLoadMapMagicSprites
        PROC_JUMP_IF_BITS_UNSET _CC10, $0002
        _CBFC
        PROC_YIELD 1
        PROC_CALL rlCheckMapMagicDecompressionDone
        PROC_JUMP_IF_BITS_UNSET _CBFC, $0001
        PROC_CALL rlUploadMapMagicSpriteTiles
        PROC_YIELD 2
        _CC10
        PROC_CALL rlStartMapMagicEffect
        _CC15
        PROC_SET_ONCYCLE rlProcUnknown9EC70BCycle6
        PROC_YIELD 1
        PROC_CALL rlMapBattleSetRoundSpriteScripts
        _CC20
        PROC_YIELD 1
        PROC_CALL rlMapBattleRoundStep
        PROC_JUMP_IF_BITS_UNSET _CC20, $0002
        PROC_SET_UNK_TIMER 16
        _CC31
        PROC_YIELD 1
        PROC_CALL rlMapBattleRoundStep
        PROC_JUMP_WHILE_UNK_TIMER _CC31
        PROC_CALL rlMapBattleStartWarpArrival
        PROC_JUMP_IF_BITS_UNSET _CC54, $0002
        _CC47
        PROC_YIELD 1
        PROC_CALL rlMapBattleWaitWarpArrival
        PROC_JUMP_IF_BITS_UNSET _CC47, $0004
        _CC54
        PROC_CALL rlUnknown9EA8BA
        PROC_JUMP_IF_BITS_UNSET _CC6C, $0002
        _CC5F
        PROC_YIELD 1
        PROC_CALL rlUnknown9EA9A5
        PROC_JUMP_IF_BITS_UNSET _CC5F, $0004
        _CC6C
        PROC_CALL rlEndMapMagicEffect
        PROC_CALL rlRestoreMapMagicScreenRegisters
        PROC_CALL rlUnknown9ECA60
        PROC_JUMP_IF_BITS_UNSET _CC98, $0002
        PROC_YIELD 40
        PROC_CALL rlCloseMapBattleHPWindows
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown9EC70BCycle7
        _CC8E
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CC8E, $0004
        PROC_YIELD 1
        _CC98
        PROC_CALL rlMapBattleStartDeathQuote
        PROC_JUMP_IF_BITS_UNSET _CCE4, $0002
        PROC_YIELD 2
        PROC_CALL rlLoadCursorSpriteGraphics
        PROC_CALL rlUnknown9E99F7
        PROC_CALL rlLoadMapSpriteOAMPalettes
        PROC_YIELD 2
        _CCB6
        PROC_YIELD 1
        PROC_CALL rlMapBattleRunQuote
        PROC_CALL rlMapBattleCheckQuoteClosed
        PROC_JUMP_IF_BITS_UNSET _CCB6, $0004
        PROC_CALL rlDecompressMapBattleTilesAfterQuote
        PROC_YIELD 18
        PROC_CALL rlUploadMapBattleTilesAfterQuote1
        PROC_YIELD 4
        PROC_CALL rlUploadMapBattleTilesAfterQuote2
        PROC_YIELD 4
        PROC_CALL rlUploadMapBattleTilesAfterQuote3
        PROC_YIELD 4
        _CCE4
        PROC_CALL rlUnknown9E9F71
        PROC_JUMP_IF_BITS_UNSET _CCFD, $0002
        _CCEF
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown9EC70BCycle8
        PROC_JUMP_IF_BITS_UNSET _CCEF, $0004
        PROC_YIELD 1
        _CCFD
        PROC_CALL rlUnknown9EF1B5
        _CD02
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_SET _CD02, $0004
        PROC_CALL rlMapBattleStartUnusedQuote
        PROC_JUMP_IF_BITS_UNSET _CD4D, $0002
        PROC_CALL rlLoadCursorSpriteGraphics
        PROC_CALL rlLoadMapSpriteOAMPalettes
        _CD1F
        PROC_YIELD 1
        PROC_CALL rlMapBattleRunQuote
        PROC_CALL rlMapBattleCheckQuoteClosed
        PROC_JUMP_IF_BITS_UNSET _CD1F, $0004
        PROC_CALL rlDecompressMapBattleTilesAfterQuote
        PROC_YIELD 18
        PROC_CALL rlUploadMapBattleTilesAfterQuote1
        PROC_YIELD 4
        PROC_CALL rlUploadMapBattleTilesAfterQuote2
        PROC_YIELD 4
        PROC_CALL rlUploadMapBattleTilesAfterQuote3
        PROC_YIELD 4
        _CD4D
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CB70, $0001
        PROC_CALL rlMapBattleCheckShiftedUnit
        PROC_JUMP_IF_BITS_UNSET _CD6D, $0002
        _CD60
        PROC_YIELD 1
        PROC_CALL rlMapBattleSlideShiftedUnitBack
        PROC_JUMP_IF_BITS_UNSET _CD60, $0004
        _CD6D
        PROC_CALL rlUnknown9ECA3B
        PROC_SET_ONCYCLE rlMapBattleLoadHUD
        _CD76
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CD76, $0004
        PROC_YIELD 4
        PROC_CALL rlUnknown9ECEA0
        PROC_JUMP_IF_BITS_UNSET _CE88, $0004
        PROC_CALL rlMapBattleOpenExperienceWindow
        PROC_JUMP_IF_BITS_UNSET _CDA5, $0002
        _CD96
        PROC_YIELD 1
        PROC_CALL rlMapBattleWaitExperienceWindow
        PROC_JUMP_IF_BITS_UNSET _CD96, $0004
        PROC_YIELD 1
        _CDA5
        PROC_CALL rlMapBattleStartLevelUpBanner
        PROC_JUMP_IF_BITS_UNSET _CDD0, $0002
        PROC_CALL rlMapBattleLowerMusic
        PROC_JUMP_IF_BITS_UNSET _CDC2, $0004
        PROC_YIELD 16
        PROC_CALL rlPlayLevelUpJingle
        _CDC2
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlMapBattleLevelUpBanner
        PROC_JUMP_IF_BITS_UNSET _CDC2, $0004
        PROC_YIELD 105
        _CDD0
        PROC_CALL rlMapBattleStartStatGains
        PROC_JUMP_IF_BITS_UNSET _CDE9, $0002
        PROC_SET_ONCYCLE rlMapBattleStatGains
        _CDDF
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CDDF, $0004
        PROC_YIELD 8
        _CDE9
        PROC_CALL rlShowObtainedGoldText
        PROC_JUMP_IF_BITS_UNSET _CE0F, $0002
        PROC_CALL rlMapBattleLowerMusic
        PROC_JUMP_IF_BITS_UNSET _CE01, $0004
        PROC_YIELD 16
        _CE01
        PROC_CALL rlPlayGoldObtainedJingle
        PROC_YIELD 117
        PROC_CALL rlCloseMapBattleTextBox
        PROC_YIELD 8
        _CE0F
        PROC_CALL rlShowGoldStolenText
        PROC_JUMP_IF_BITS_UNSET _CE35, $0002
        PROC_CALL rlMapBattleLowerMusic
        PROC_JUMP_IF_BITS_UNSET _CE27, $0004
        PROC_YIELD 16
        _CE27
        PROC_CALL rlPlayGoldStolenJingle
        PROC_YIELD 133
        PROC_CALL rlCloseMapBattleTextBox
        PROC_YIELD 8
        _CE35
        PROC_CALL rlShowObtainedItemText
        PROC_JUMP_IF_BITS_UNSET _CE5B, $0002
        PROC_CALL rlMapBattleLowerMusic
        PROC_JUMP_IF_BITS_UNSET _CE4D, $0004
        PROC_YIELD 16
        _CE4D
        PROC_CALL rlPlayItemObtainedJingle
        PROC_YIELD 117
        PROC_CALL rlCloseMapBattleTextBox
        PROC_YIELD 8
        _CE5B
        PROC_CALL rlShowWeaponBrokeText
        PROC_JUMP_IF_BITS_UNSET _CE81, $0002
        PROC_CALL rlMapBattleLowerMusic
        PROC_JUMP_IF_BITS_UNSET _CE73, $0004
        PROC_YIELD 16
        _CE73
        PROC_CALL rlPlayWeaponBrokeJingle
        PROC_YIELD 133
        PROC_CALL rlCloseMapBattleTextBox
        PROC_YIELD 8
        _CE81
        PROC_CALL rlMapBattleRestoreMusic
        PROC_YIELD 16
        _CE88
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcMapBattleEnd
        PROC_YIELD 1
        _CE90
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_SET _CE90, $0001
        _CE98
        PROC_YIELD 1
        PROC_JUMP _CE98


        ; 9E/CE9E


        PROC_HALT

    .endsection ProcScript9ECAD2Section


    .section Unsorted9ECEA0Section

      .al
      .xl

      rlUnknown9ECEA0 ; 9E/CEA0

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda wMapBattleMode
        bne _CEB8
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _CEB8
        rtl

        .databank 0

        ; 9E/CEB9

      procUnknown9ECEB9 ; 9E/CEB9

        ; Unreferenced: nothing creates this proc.

        .structProcInfo "ON", rlProcUnknown9ECEB9Init, rlProcUnknown9ECEB9Cycle, aProcUnknown9ECEB9Code

      rlProcUnknown9ECEB9Init ; 9E/CEC1

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/CEC2

      rlProcUnknown9ECEB9Cycle ; 9E/CEC2

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85D347
        sta aProcSystem.aBody0,b,x
        jsl rlUnknown85D337
        sta aProcSystem.aBody1,b,x
        lda aProcSystem.aBody0,b,x
        ora aProcSystem.aBody1,b,x
        sta $7F45A0
        rtl

        .databank 0

        ; 9E/CEDB

      aProcUnknown9ECEB9Code ; 9E/CEDB

        PROC_HALT

    .endsection Unsorted9ECEA0Section


    .section Unsorted9ED742Section

      .al
      .xl

      rlMapBattleStartPavise ; 9E/D742

        .al
        .xl
        .autsiz
        .databank ?

        ; Before a round: when the round entry was a Pavise activation ($02FE, wMapBattlePavise), starts procMapBattlePavise and sets header bit $0002.

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda wMapBattlePavise
        beq _D773
        lda #(`procMapBattlePavise)<<8
        sta lR44+1
        lda #<>procMapBattlePavise
        sta lR44
        jsl rlProcEngineCreateProc
        sta $7F57F0
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _D773
        plx
        rtl

        .databank 0

        ; 9E/D775

      rlMapBattleWaitPavise ; 9E/D775

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets header bit $0004 once procMapBattlePavise has ended.

        phx
        lda $7F57F0
        jsl rlProcEngineCheckProcEnded
        bcc _D789
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _D789
        plx
        rtl

        .databank 0

        ; 9E/D78B

    .endsection Unsorted9ED742Section


    .section ProcScript9ED78BSection

      .al
      .xl

      procMapBattlePavise ; 9E/D78B

        .structProcInfo "ON", rlProcMapBattlePaviseInit, rlProcMapBattlePaviseCycle, aProcMapBattlePaviseCode

    .endsection ProcScript9ED78BSection


    .section Unsorted9ED793Section

      .al
      .xl

      rlProcMapBattlePaviseInit ; 9E/D793

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlMapBattleLoadPaviseGraphics
        rtl

        .databank 0

        ; 9E/D79E

      rlProcMapBattlePaviseCycle ; 9E/D79E

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/D79F

    .endsection Unsorted9ED793Section


    .section ProcScript9ED79FSection

      .al
      .xl

      aProcMapBattlePaviseCode ; 9E/D79F

        PROC_YIELD 16
        PROC_CALL rlMapBattleShowPavise
        _D7A6
        PROC_YIELD 1
        PROC_CALL rlMapBattleCheckPaviseDone
        PROC_JUMP_IF_BITS_UNSET _D7A6, $0004
        PROC_YIELD 14
        PROC_END


        ; 9E/D7B7

    .endsection ProcScript9ED79FSection


    .section Unsorted9ED7B7Section

      .al
      .xl

      rlMapBattleLoadPaviseGraphics ; 9E/D7B7

        .al
        .xl
        .autsiz
        .databank ?

        ; Uploads the shield's tiles (g4bppMapBattlePavise, $400 bytes to the sprite tiles) and its colors (aMapBattlePaviseColors).

        phx
        lda #(`g4bppMapBattlePavise)<<8
        sta lR18+1
        lda #<>g4bppMapBattlePavise
        sta lR18
        lda #$0400
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        sta wR1
        jsl rlDMAByPointer
        ldx #$001E

        _D7DB
        lda aMapBattlePaviseColors,x
        sta aOAMPaletteBuffer.aPalette6,b,x
        dec x
        dec x
        bpl _D7DB
        plx
        rtl

        .databank 0

        ; 9E/D7E8

    .endsection Unsorted9ED7B7Section


    .section Table9ED7E8Section

      .al
      .xl

      aMapBattlePaviseColors ; 9E/D7E8

        ; Read by rlMapBattleLoadPaviseGraphics.

        .word $3800, $7FFF, $035F, $01BF, $0037, $0C8A, $0425, $7FBA
        .word $7E6E, $7C84, $30C4, $1421, $0000, $0000, $0000, $0000

        ; 9E/D808

    .endsection Table9ED7E8Section


    .section Unsorted9ED808Section

      .al
      .xl

      rlMapBattleShowPavise ; 9E/D808

        .al
        .xl
        .autsiz
        .databank ?

        ; Gives the defending side's sprite the shield's script (aMapBattlePaviseSpriteScript, saving its own), creates the shield's sprite (aUnknown9EDAE0) on the defender's tile and plays sound $2E.

        phy
        phx
        lda aMapAction.wMapBattleRoundIndex
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        bit #$0001
        beq _D839
        lda aMapAction.lUnknown7F4598
        sta $7F57EA
        lda aMapAction.lUnknown7F4598+1
        sta $7F57EC
        lda #(`aMapBattlePaviseSpriteScript)<<8
        sta aMapAction.lUnknown7F4598+1
        lda #<>aMapBattlePaviseSpriteScript
        sta aMapAction.lUnknown7F4598
        bra _D857


        _D839
        lda aMapAction.lUnknown7F459B
        sta $7F57EA
        lda aMapAction.lUnknown7F459B+1
        sta $7F57EC
        lda #(`aMapBattlePaviseSpriteScript)<<8
        sta aMapAction.lUnknown7F459B+1
        lda #<>aMapBattlePaviseSpriteScript
        sta aMapAction.lUnknown7F459B

        _D857
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        eor #$0001
        sta aMapAction.wUnknown7F4576
        asl a
        asl a
        tax
        lda aMapAction.wYTilePosition,x
        tay
        lda aMapAction.wXTilePosition,x
        tax
        jsl rlUnknown9E8D25
        lda #(`aUnknown9EDAE0)<<8
        sta lR44+1
        lda #<>aUnknown9EDAE0
        sta lR44
        lda #$DAE0
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F57EE
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda aMapAction.wUnknown7F4576
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        jsl rlMapBattlePlaySound2E
        plx
        ply
        rtl

        .databank 0

        ; 9E/D8B6

      rlMapBattleCheckPaviseDone ; 9E/D8B6

        .al
        .xl
        .autsiz
        .databank ?

        ; When the shield's sprite has ended, gives the side its own script back and sets header bit $0004.

        phx
        lda $7F57EE
        tax
        lda aActiveSpriteSystem.aTypeOffset,b,x
        bne _D8FE
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda aMapAction.wMapBattleRoundIndex
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        bit #$0001
        beq _D8EE
        lda $7F57EA
        sta aMapAction.lUnknown7F4598
        lda $7F57EC
        sta aMapAction.lUnknown7F4598+1
        bra _D8FE


        _D8EE
        lda $7F57EA
        sta aMapAction.lUnknown7F459B
        lda $7F57EC
        sta aMapAction.lUnknown7F459B+1

        _D8FE
        plx
        rtl

        .databank 0

        ; 9E/D900

    .endsection Unsorted9ED808Section


    .section Data9ED900Section

      .al
      .xl

      aMapBattlePaviseSpriteScript ; 9E/D900

        .word _D900_Table - aMapBattlePaviseSpriteScript
        .word _D900_Script - aMapBattlePaviseSpriteScript

        _D900_Frame00
          .word 1 ; sprite count
          .structSpriteEntry (   2,  -19), $00, SpriteSmall, $000, 2, 0, false, false

        _D900_Frame01
          .word 2 ; sprite count
          .structSpriteEntry (   2,  -17), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (   5,  -14), $00, SpriteSmall, $000, 2, 0, false, false

        _D900_Frame02
          .word 3 ; sprite count
          .structSpriteEntry (   3,  -14), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (   4,  -11), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (   1,   -7), $00, SpriteSmall, $000, 2, 0, false, false

        _D900_Frame03
          .word 3 ; sprite count
          .structSpriteEntry (   4,  -11), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (   2,   -7), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (  -3,   -4), $00, SpriteSmall, $000, 2, 0, false, false

        _D900_Frame04
          .word 4 ; sprite count
          .structSpriteEntry ( -10,  -14), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (   3,   -5), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (  -2,   -2), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $000, 2, 0, false, false

        _D900_Frame05
          .word 5 ; sprite count
          .structSpriteEntry ( -15,   -9), $00, SpriteSmall, $000, 2, 0, false, false
          .structSpriteEntry ( -12,  -13), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (  -6,   -1), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry ( -11,    0), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry ( -15,   -2), $00, SpriteSmall, $000, 2, 0, false, false

        _D900_Frame06
          .word 5 ; sprite count
          .structSpriteEntry ( -12,    1), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry ( -13,  -12), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry ( -11,   -4), $00, SpriteSmall, $000, 2, 0, false, false
          .structSpriteEntry ( -15,   -7), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry ( -15,   -1), $00, SpriteSmall, $010, 2, 0, false, false

        _D900_Frame07
          .word 4 ; sprite count
          .structSpriteEntry ( -11,   -8), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (  -9,   -4), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (  -4,   -2), $00, SpriteSmall, $000, 2, 0, false, false
          .structSpriteEntry ( -13,   -2), $00, SpriteSmall, $011, 2, 0, false, false

        _D900_Frame08
          .word 3 ; sprite count
          .structSpriteEntry (  -8,   -3), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (  -3,   -1), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (   3,   -1), $00, SpriteSmall, $000, 2, 0, false, false

        _D900_Frame09
          .word 4 ; sprite count
          .structSpriteEntry (   0,    0), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (   7,    0), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (   8,   -3), $00, SpriteSmall, $000, 2, 0, false, false
          .structSpriteEntry (   5,   -1), $00, SpriteSmall, $010, 2, 0, false, false

        _D900_Frame10
          .word 5 ; sprite count
          .structSpriteEntry (   7,    0), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (   7,   -2), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (   6,   -1), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (   2,    0), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (  -2,   -3), $00, SpriteSmall, $000, 2, 0, false, false

        _D900_Frame11
          .word 4 ; sprite count
          .structSpriteEntry (   7,   -2), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (   2,    1), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (  -3,   -1), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (  -7,   -6), $00, SpriteSmall, $000, 2, 0, false, false

        _D900_Frame12
          .word 3 ; sprite count
          .structSpriteEntry (  -3,   -3), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (  -7,   -5), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry ( -11,  -12), $00, SpriteSmall, $000, 2, 0, false, false

        _D900_Frame13
          .word 4 ; sprite count
          .structSpriteEntry ( -14,   -2), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry ( -10,   -7), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry ( -12,  -11), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry ( -11,  -16), $00, SpriteSmall, $000, 2, 0, false, false

        _D900_Frame14
          .word 4 ; sprite count
          .structSpriteEntry ( -16,   -2), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry ( -10,   -5), $00, SpriteSmall, $000, 2, 0, false, false
          .structSpriteEntry ( -11,  -14), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (  -9,  -15), $00, SpriteSmall, $010, 2, 0, false, false

        _D900_Frame15
          .word 4 ; sprite count
          .structSpriteEntry ( -10,   -2), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (  -6,   -4), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (  -2,   -9), $00, SpriteSmall, $000, 2, 0, false, false
          .structSpriteEntry ( -10,  -14), $00, SpriteSmall, $011, 2, 0, false, false

        _D900_Frame16
          .word 3 ; sprite count
          .structSpriteEntry (   0,   -6), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (   4,  -11), $00, SpriteSmall, $000, 2, 0, false, false
          .structSpriteEntry (  -4,   -3), $00, SpriteSmall, $011, 2, 0, false, false

        _D900_Frame17
          .word 3 ; sprite count
          .structSpriteEntry (   1,   -4), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (   6,  -10), $00, SpriteSmall, $010, 2, 0, false, false
          .structSpriteEntry (   4,  -14), $00, SpriteSmall, $000, 2, 0, false, false

        _D900_Frame18
          .word 2 ; sprite count
          .structSpriteEntry (   6,  -12), $00, SpriteSmall, $011, 2, 0, false, false
          .structSpriteEntry (   1,  -14), $00, SpriteSmall, $010, 2, 0, false, false

        _D900_Frame19
          .word 1 ; sprite count
          .structSpriteEntry (   3,  -14), $00, SpriteSmall, $011, 2, 0, false, false

        _D900_Table
          .word _D900_Frame00 - aMapBattlePaviseSpriteScript
          .word _D900_Frame01 - aMapBattlePaviseSpriteScript
          .word _D900_Frame02 - aMapBattlePaviseSpriteScript
          .word _D900_Frame03 - aMapBattlePaviseSpriteScript
          .word _D900_Frame04 - aMapBattlePaviseSpriteScript
          .word _D900_Frame05 - aMapBattlePaviseSpriteScript
          .word _D900_Frame06 - aMapBattlePaviseSpriteScript
          .word _D900_Frame07 - aMapBattlePaviseSpriteScript
          .word _D900_Frame08 - aMapBattlePaviseSpriteScript
          .word _D900_Frame09 - aMapBattlePaviseSpriteScript
          .word _D900_Frame10 - aMapBattlePaviseSpriteScript
          .word _D900_Frame11 - aMapBattlePaviseSpriteScript
          .word _D900_Frame12 - aMapBattlePaviseSpriteScript
          .word _D900_Frame13 - aMapBattlePaviseSpriteScript
          .word _D900_Frame14 - aMapBattlePaviseSpriteScript
          .word _D900_Frame15 - aMapBattlePaviseSpriteScript
          .word _D900_Frame16 - aMapBattlePaviseSpriteScript
          .word _D900_Frame17 - aMapBattlePaviseSpriteScript
          .word _D900_Frame18 - aMapBattlePaviseSpriteScript
          .word _D900_Frame19 - aMapBattlePaviseSpriteScript

        _D900_Script
          ACTIVE_SPRITE_TABLE_FRAME 2, 0
          ACTIVE_SPRITE_TABLE_FRAME 2, 1
          ACTIVE_SPRITE_TABLE_FRAME 2, 2
          ACTIVE_SPRITE_TABLE_FRAME 2, 3
          ACTIVE_SPRITE_TABLE_FRAME 2, 4
          ACTIVE_SPRITE_TABLE_FRAME 2, 5
          ACTIVE_SPRITE_TABLE_FRAME 2, 6
          ACTIVE_SPRITE_TABLE_FRAME 2, 7
          ACTIVE_SPRITE_TABLE_FRAME 2, 8
          ACTIVE_SPRITE_TABLE_FRAME 2, 9
          ACTIVE_SPRITE_TABLE_FRAME 2, 10
          ACTIVE_SPRITE_TABLE_FRAME 2, 11
          ACTIVE_SPRITE_TABLE_FRAME 2, 12
          ACTIVE_SPRITE_TABLE_FRAME 2, 13
          ACTIVE_SPRITE_TABLE_FRAME 2, 14
          ACTIVE_SPRITE_TABLE_FRAME 2, 15
          ACTIVE_SPRITE_TABLE_FRAME 2, 16
          ACTIVE_SPRITE_TABLE_FRAME 2, 17
          ACTIVE_SPRITE_TABLE_FRAME 2, 18
          ACTIVE_SPRITE_TABLE_FRAME 2, 19
          ACTIVE_SPRITE_END

      aUnknown9EDAE0 ; 9E/DAE0
        .word <>rlUnknown9EDAE6, <>rlUnknown9EDAE6, <>aMapBattlePaviseSpriteScript._D900_Script

      rlUnknown9EDAE6 ; 9E/DAE6
        rtl

    .endsection Data9ED900Section


    .section Unsorted9EDF7FSection

      .al
      .xl

      rlStartScriptedCritEffect ; 9E/DF7F

        .al
        .xl
        .autsiz
        .databank ?

        ; Before a scripted critical (rlUnknown84DE36): ends the unit's action and plays the critical's effect (procScriptedCritEffect).

        lda #(`procScriptedCritStart)<<8
        sta lR44+1
        lda #<>procScriptedCritStart
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/DF8E

    .endsection Unsorted9EDF7FSection


    .section ProcScript9EDF8ESection

      .al
      .xl

      procScriptedCritStart ; 9E/DF8E

        .structProcInfo "ON", rlProcScriptedCritStartInit, rlProcUnknown9EDF8ECycle1, aProcScriptedCritStartCode

    .endsection ProcScript9EDF8ESection


    .section Unsorted9EDF96Section

      .al
      .xl

      rlProcScriptedCritStartInit ; 9E/DF96

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlEndUnitAction
        jsl rlCreateScriptedCritEffect
        sta aProcSystem.aBody6,b,x
        lda aActionStructUnit1.XPosition
        sta $7F57EE
        lda aActionStructUnit1.YPosition
        sta $7F57F0
        lda wBattleStatus
        and #$0001
        sta wR0
        lda wBattleStatus
        and #$00FF
        bit #$0004
        beq _DFDD
        and #$0002
        lsr a
        cmp wR0
        bne _DFDD
        lda $7F57F0
        inc a
        sta $7F57F0

        _DFDD
        lda wBattleStatus
        and #$0001
        beq _DFF6
        lda aActionStructUnit2.XPosition
        sta $7F57EE
        lda aActionStructUnit2.YPosition
        sta $7F57F0

        _DFF6
        rtl

        .databank 0

        ; 9E/DFF7

      rlProcUnknown9EDF8ECycle1 ; 9E/DFF7

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/DFF8

    .endsection Unsorted9EDF96Section


    .section Unsorted9EDFF8Section

      .al
      .xl

      rlProcUnknown9EDF8ECycle2 ; 9E/DFF8

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody6,b,x
        jsl rlProcEngineCheckProcEnded
        bcc rlUnknown9EE010
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlUnknown9EE010
        sta aProcSystem.aHeaderOnCycle,b,x

        .databank 0

      rlUnknown9EE010 ; 9E/E010

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/E011

    .endsection Unsorted9EDFF8Section


    .section ProcScript9EE011Section

      .al
      .xl

      aProcScriptedCritStartCode ; 9E/E011

        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown9EDF8ECycle2
        _E017
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _E017, $0001
        PROC_END


        ; 9E/E021

    .endsection ProcScript9EE011Section


    .section Unsorted9EE021Section

      .al
      .xl

      rlUnknown9EE021 ; 9E/E021

        .al
        .xl
        .autsiz
        .databank ?

        lda aActionStructUnit1.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlStartBattleSceneOrMapBattle
        rtl

        .databank 0

        ; 9E/E02D

    .endsection Unsorted9EE021Section


    .section Unsorted9EE02DSection

      .al
      .xl

      rlCreateScriptedCritEffect ; 9E/E02D

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procScriptedCritEffect)<<8
        sta lR44+1
        lda #<>procScriptedCritEffect
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/E03C

    .endsection Unsorted9EE02DSection


    .section ProcScript9EE03CSection

      .al
      .xl

      procScriptedCritEffect ; 9E/E03C

        .structProcInfo "ON", rlProcScriptedCritEffectInit, rlProcScriptedCritEffectCycle, aProcScriptedCritEffectCode

    .endsection ProcScript9EE03CSection


    .section Unsorted9EE044Section

      .al
      .xl

      rlProcScriptedCritEffectInit ; 9E/E044

        .al
        .xl
        .autsiz
        .databank ?

        lda wGameStateRoutine1,b
        sta aProcSystem.aBody7,b,x
        stz wGameStateRoutine1,b
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        lda #(`rlPushToOAMBufferDualTileBase)<<8
        sta $15E5,b
        lda #<>rlPushToOAMBufferDualTileBase
        sta $15E4,b
        rtl

        .databank 0

        ; 9E/E060

      rlProcScriptedCritEffectCycle ; 9E/E060

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda wBattleCriticalType
        dec a
        jsl rlDecompressScriptedCritSprites
        lda #<>rlUnknown9EE079
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/E079

      rlUnknown9EE079 ; 9E/E079

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        and #$00FF
        bne _E090
        lda #<>rlUnknown9EE091
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _E090
        rtl

        .databank 0

        ; 9E/E091

      rlUnknown9EE091 ; 9E/E091

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/E092

    .endsection Unsorted9EE044Section


    .section ProcScript9EE092Section

      .al
      .xl

      aProcScriptedCritEffectCode ; 9E/E092

        PROC_YIELD 1
        _E094
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _E094, $0002
        PROC_CALL rlUnknown9EE127
        PROC_YIELD 8
        PROC_CALL rlUnknown9EE228
        _E0A8
        PROC_CALL rlUnknown9EE23D
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _E0A8, $0004
        PROC_YIELD 1
        PROC_CALL rlUnknown9EE290
        _E0BC
        PROC_YIELD 1
        PROC_CALL rlUnknown9EE2BE
        PROC_JUMP_IF_BITS_UNSET _E0BC, $0001
        PROC_YIELD 30
        PROC_CALL rlUnknown9EE254
        PROC_JUMP_IF_BITS_UNSET _E0E3, $0002
        _E0D6
        PROC_CALL rlUnknown9EE279
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _E0D6, $0004
        _E0E3
        PROC_YIELD 1
        PROC_CALL rlUnknown9EE2D1
        PROC_CALL rlUnknown9EE021
        PROC_END


        ; 9E/E0F1

    .endsection ProcScript9EE092Section


    .section Unsorted9EE0F1Section

      .al
      .xl

      rlDecompressScriptedCritSprites ; 9E/E0F1

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aMapBattleScriptedCritSprites,x
        sta lR18
        lda aMapBattleScriptedCritSprites+1,x
        sta lR18+1
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$6000
        sta lR19
        jsl rlAppendDecompList
        plx
        ply
        rtl

        .databank 0

        ; 9E/E11B

    .endsection Unsorted9EE0F1Section


    .section Table9EE11BSection

      .al
      .xl

      aMapBattleScriptedCritSprites ; 9E/E11B

        ; Read by rlDecompressScriptedCritSprites, by wBattleCriticalType - 1: compressed 4bpp
        ; sprite tiles for the effect of a scripted critical (see
        ; rlActionStructGetScriptedCritPossibility), decompressed to
        ; aDecompressionBuffer+$6000. Nothing found sets type 4 yet.

        .long g4bppcMapBattleCritSibling ; 1: sibling
        .long g4bppcMapBattleCritLover ; 2: lover
        .long g4bppcMapBattleCritTriangleAttack ; 3: triangle attack
        .long g4bppcMapBattleCritUnknown4 ; 4

        ; 9E/E127

    .endsection Table9EE11BSection


    .section Unsorted9EE127Section

      .al
      .xl

      rlUnknown9EE127 ; 9E/E127

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$6000
        sta lR18
        lda #$0400
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc #$0400
        sta wR1
        jsl rlDMAByPointer
        jsl rlUnknown9EE156
        plx
        rtl

        .databank 0

        ; 9E/E156

      rlUnknown9EE156 ; 9E/E156

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda wBattleCriticalType
        and #$00FF
        xba
        lsr a
        lsr a
        lsr a
        tax
        ldy #$001E

        _E167
        lda aMapBattleCriticalTypePalettes - 2,x
        sta aOAMPaletteBuffer.aPalette6,b,y
        dec x
        dec x
        dec y
        dec y
        bpl _E167
        plx
        ply
        rtl

        .databank 0

        ; 9E/E177

      aMapBattleCriticalTypePalettes ; 9E/E177

        ; Sprite palette 6 for wBattleCriticalType 1-4, one palette each
        ; (rlUnknown9EE156 reads type * 32 bytes from aMapBattleCriticalTypePalettes - 2, backwards).

        .word $3800, $7FFF, $035F, $01BF, $0037, $0C8A, $0425, $7FBA
        .word $7E6E, $7C84, $30C4, $1421, $0000, $0000, $0000, $0000
        .word $3800, $7FFF, $5BDF, $1E9A, $0C87, $14AA, $18EC, $2952
        .word $35B7, $421C, $4A5F, $46FF, $161E, $0D77, $08ED, $0489
        .word $3800, $726F, $726F, $6E2C, $726F, $72B1, $76F4, $7716
        .word $7B59, $7B9B, $7FDE, $679C, $4F5A, $3338, $1AF6, $02B4
        .word $3800, $14AA, $0C87, $0444, $0C87, $14AA, $18EC, $2952
        .word $35B7, $421C, $4A5F, $46FF, $161E, $0D77, $08ED, $0489

      rlUnknown9EE1F7 ; 9E/E1F7

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: copies aUnknown9EE208 into sprite palette 6.

        phx
        ldx #$001E

        -
        lda aUnknown9EE208,x
        sta aOAMPaletteBuffer.aPalette6,b,x
        dec x
        dec x
        bpl -

        plx
        rtl

        .databank 0

      aUnknown9EE208 ; 9E/E208

        .word $3800, $7FFF, $5BDF, $1E9A, $1551, $0C8A, $0425, $7FBA
        .word $5EB3, $49EE, $28E6, $1421, $63FA, $2E2D, $1505, $0000

    .endsection Unsorted9EE127Section


    .section Unsorted9EE228Section

      .al
      .xl

      rlUnknown9EE228 ; 9E/E228

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        phb
        pea #$9F9F
        plb
        .databank ?
        plb
        .databank ?
        jsl rlUnknown9F90FA
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/E23D

      rlUnknown9EE23D ; 9E/E23D

        .al
        .xl
        .autsiz
        .databank ?

        phb
        pea #$9F9F
        plb
        .databank ?
        plb
        .databank ?
        jsl rlUnknown9F90F2
        bcc _E252
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _E252
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/E254

      rlUnknown9EE254 ; 9E/E254

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda aActionStructUnit1.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlCheckIfBattleAnimationOFF
        bcc _E277
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _E277
        plx
        rtl

        .databank 0

        ; 9E/E279

      rlUnknown9EE279 ; 9E/E279

        .al
        .xl
        .autsiz
        .databank ?

        phb
        pea #$9F9F
        plb
        .databank ?
        plb
        .databank ?
        jsl rlUnknown9F90F6
        bcc _E28E
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _E28E
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/E290

      rlUnknown9EE290 ; 9E/E290

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wBattleCriticalType
        dec a
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown9EE2B2+1,x
        sta lR44+1
        lda aUnknown9EE2B2,x
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        sta aProcSystem.aBody6,b,x
        rtl

        .databank 0

        ; 9E/E2B2

    .endsection Unsorted9EE228Section


    .section Table9EE2B2Section

      .al
      .xl

      aUnknown9EE2B2 ; 9E/E2B2

        ; Read by rlUnknown9EE290.

        .word $E2E4, $CA9E, $9EE3, $E5D7, $3B9E, $9EE8

        ; 9E/E2BE

    .endsection Table9EE2B2Section


    .section Unsorted9EE2BESection

      .al
      .xl

      rlUnknown9EE2BE ; 9E/E2BE

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody6,b,x
        jsl rlProcEngineCheckProcEnded
        bcc _E2D0
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _E2D0
        rtl

        .databank 0

        ; 9E/E2D1

      rlUnknown9EE2D1 ; 9E/E2D1

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        lda #(`rlPushToOAMBuffer)<<8
        sta $15E5,b
        lda #<>rlPushToOAMBuffer
        sta $15E4,b
        rtl

        .databank 0

        ; 9E/E2E4

      procUnknown9EE2E4 ; 9E/E2E4

        ; Unreferenced: nothing creates this proc.

        .structProcInfo "ON", rlProcUnknown9EE2E4Init, rlProcUnknown9EE2E4Cycle, aProcUnknown9EE2E4Code

      rlProcUnknown9EE2E4Init ; 9E/E2EC

        .al
        .xl
        .autsiz
        .databank ?

        lda #$002C
        jsl rlMapBattlePlaySoundAtSprite
        jsl rlUnknown9EE309
        jsl rlUnknown9EE35F
        rtl

        .databank 0

        ; 9E/E2FC

      rlProcUnknown9EE2E4Cycle ; 9E/E2FC

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/E2FD

        ; Unreachable: it follows a return.
        rtl

      aProcUnknown9EE2E4Code ; 9E/E2FE

        PROC_YIELD 32
        PROC_CALL rlUnknown9EE3A7
        PROC_YIELD 56
        PROC_END


        ; 9E/E309

      rlUnknown9EE309 ; 9E/E309

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #(`aUnknown9EEA05)<<8
        sta aMapAction.lUnknown7F4598+1
        lda #<>aUnknown9EEA05
        sta aMapAction.lUnknown7F4598
        lda $7F57EE
        tax
        lda $7F57F0
        tay
        jsl rlUnknown9E8D25
        lda #(`aUnknown9EEAC8)<<8
        sta lR44+1
        lda #<>aUnknown9EEAC8
        sta lR44
        lda #<>aUnknown9EEAC8
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F4BFF
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/E35F

      rlUnknown9EE35F ; 9E/E35F

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7E4F79
        tax
        lda $7E4F7B
        tay
        jsl rlUnknown9E8D25
        lda #(`aUnknown9EEAC8)<<8
        sta lR44+1
        lda #<>aUnknown9EEAC8
        sta lR44
        lda #<>aUnknown9EEAC8
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F4C01
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/E3A7

      rlUnknown9EE3A7 ; 9E/E3A7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C01
        tax
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda $7F4BFF
        tax
        lda #<>aUnknown9EEAA6
        sta aActiveSpriteSystem.aCodeOffset,b,x
        lda #$0001
        sta aActiveSpriteSystem.aFrameTimer,b,x
        lda #$002D
        jsl rlMapBattlePlaySoundAtSprite
        plx
        rtl

        .databank 0

        ; 9E/E3CA

      procUnknown9EE3CA ; 9E/E3CA

        ; Unreferenced: nothing creates this proc.

        .structProcInfo "ON", rlProcUnknown9EE3CAInit, rlProcUnknown9EE3CACycle, aProcUnknown9EE3CACode

      rlProcUnknown9EE3CAInit ; 9E/E3D2

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0029
        jsl rlMapBattlePlaySoundAtSprite
        jsl rlUnknown9EE417
        jsl rlUnknown9EE46D
        jsl rlUnknown9EE568
        rtl

        .databank 0

        ; 9E/E3E6

      rlProcUnknown9EE3CACycle ; 9E/E3E6

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/E3E7

        ; Unreachable: it follows a return.
        rtl

      aProcUnknown9EE3CACode ; 9E/E3E8

        PROC_SET_UNK_TIMER 30
        _E3EC
        PROC_YIELD 1
        PROC_CALL rlBattleSceneRunPaletteEffects
        PROC_JUMP_WHILE_UNK_TIMER _E3EC
        PROC_CALL rlUnknown9EE4B5
        _E3FC
        PROC_YIELD 1
        PROC_CALL rlUnknown9EE4C5
        PROC_CALL rlBattleSceneRunPaletteEffects
        PROC_JUMP_IF_BITS_UNSET _E3FC, $0004
        PROC_CALL rlUnknown9EE53D
        PROC_YIELD 16
        PROC_END


        ; 9E/E417

      rlUnknown9EE417 ; 9E/E417

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #(`aUnknown9EEAD5)<<8
        sta aMapAction.lUnknown7F4598+1
        lda #<>aUnknown9EEAD5
        sta aMapAction.lUnknown7F4598
        lda $7F57EE
        tax
        lda $7F57F0
        tay
        jsl rlUnknown9E8D25
        lda #(`aUnknown9EEB3D)<<8
        sta lR44+1
        lda #<>aUnknown9EEB3D
        sta lR44
        lda #<>aUnknown9EEB3D
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F4BFF
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/E46D

      rlUnknown9EE46D ; 9E/E46D

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7E4F79
        tax
        lda $7E4F7B
        tay
        jsl rlUnknown9E8D25
        lda #(`aUnknown9EEB3D)<<8
        sta lR44+1
        lda #<>aUnknown9EEB3D
        sta lR44
        lda #<>aUnknown9EEB3D
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F4C01
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/E4B5

      rlUnknown9EE4B5 ; 9E/E4B5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlUnknown9EE4FC
        plx
        rtl

        .databank 0

        ; 9E/E4C5

      rlUnknown9EE4C5 ; 9E/E4C5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C01
        tax
        jsl rlMoveActiveSpriteByVelocity
        lda $7F4BFF
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        sta wR0
        lda aActiveSpriteSystem.aUnknown001240,b,x
        sta wR1
        lda #$0001
        sta wR2
        lda $7F4C01
        tax
        jsl rlUnknown9EA566
        bcc _E4FA
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _E4FA
        plx
        rtl

        .databank 0

        ; 9E/E4FC

      rlUnknown9EE4FC ; 9E/E4FC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C01
        tax
        lda $7E4F79
        sta wR0
        lda $7E4F7B
        sta wR1
        jsl rlUnknown9EE514
        plx
        rtl

        .databank 0

        ; 9E/E514

      rlUnknown9EE514 ; 9E/E514

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F57EE
        sec
        sbc wR0
        and #$00FF
        xba
        sta wR0
        asl a
        lda wR0
        ror a
        sta aActiveSpriteSystem.aUnknown0013C0,b,x
        lda $7F57F0
        sec
        sbc wR1
        and #$00FF
        xba
        sta wR0
        asl a
        lda wR0
        ror a
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        rtl

        .databank 0

        ; 9E/E53D

      rlUnknown9EE53D ; 9E/E53D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown9EE5C8
        jsl rlUnknown9EE1F7
        lda $7F4C01
        tax
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda $7F4BFF
        tax
        lda #<>aUnknown9EEB2D
        sta aActiveSpriteSystem.aCodeOffset,b,x
        lda #$0001
        sta aActiveSpriteSystem.aFrameTimer,b,x
        lda #$002C
        jsl rlMapBattlePlaySoundAtSprite
        plx
        rtl

        .databank 0

        ; 9E/E568

      rlUnknown9EE568 ; 9E/E568

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        jsl rlUnknown96D659
        stz wR0
        lda #(`aUnknown9EE581)<<8
        sta lR18+1
        lda #<>aUnknown9EE581
        sta lR18
        jsl rlBattleSceneStartPaletteEffect
        plx
        ply
        rtl

        .databank 0

        ; 9E/E581

      aUnknown9EE581 ; 9E/E581

        PALETTE_EFFECT $02, $01, $E4, $0B, aUnknown9EE588

      aUnknown9EE588 ; 9E/E588

        .byte $81, $46, $FF, $16, $1E, $0D, $77, $08, $ED
        .byte $04, $89, $08, $ED, $0D, $77, $16, $1E, $26, $BF, $5F, $FF, $3B, $FF, $03, $FF
        .byte $02, $F7, $02, $52, $01, $4A, $01, $4A, $01, $AD, $02, $B5, $3B, $FF, $4A, $5F
        .byte $29, $52, $18, $EC, $14, $AA, $0C, $87, $04, $44, $14, $AA, $18, $EC, $29, $52
        .byte $35, $B7, $42, $1C, $4A, $5F, $FE

      rlUnknown9EE5C8 ; 9E/E5C8

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7FFD9A
        ora #$80
        sta $7FFD9A
        rep #$20
        rtl

        .databank 0

        ; 9E/E5D7

      procUnknown9EE5D7 ; 9E/E5D7

        ; Unreferenced: nothing creates this proc.

        .structProcInfo "ON", rlProcUnknown9EE5D7Init, rlProcUnknown9EE5D7Cycle, aProcUnknown9EE5D7Code

      rlProcUnknown9EE5D7Init ; 9E/E5DF

        .al
        .xl
        .autsiz
        .databank ?

        lda #$002A
        jsl rlMapBattlePlaySoundAtSprite
        jsl rlUnknown9EE628
        jsl rlUnknown9EE67E
        jsl rlUnknown9EE6C6
        jsl rlUnknown9EE7DB
        rtl

        .databank 0

        ; 9E/E5F7

      rlProcUnknown9EE5D7Cycle ; 9E/E5F7

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/E5F8

        ; Unreachable: it follows a return.
        rtl

      aProcUnknown9EE5D7Code ; 9E/E5F9

        PROC_SET_UNK_TIMER 30
        _E5FD
        PROC_YIELD 1
        PROC_CALL rlBattleSceneRunPaletteEffects
        PROC_JUMP_WHILE_UNK_TIMER _E5FD
        PROC_CALL rlUnknown9EE70E
        _E60D
        PROC_YIELD 1
        PROC_CALL rlUnknown9EE74B
        PROC_CALL rlBattleSceneRunPaletteEffects
        PROC_JUMP_IF_BITS_UNSET _E60D, $0004
        PROC_CALL rlUnknown9EE7A8
        PROC_YIELD 24
        PROC_END


        ; 9E/E628

      rlUnknown9EE628 ; 9E/E628

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #(`aUnknown9EEBB9)<<8
        sta aMapAction.lUnknown7F4598+1
        lda #<>aUnknown9EEBB9
        sta aMapAction.lUnknown7F4598
        lda $7F57EE
        tax
        lda $7F57F0
        tay
        jsl rlUnknown9E8D25
        lda #(`aUnknown9EEC22)<<8
        sta lR44+1
        lda #<>aUnknown9EEC22
        sta lR44
        lda #<>aUnknown9EEC22
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F4BFF
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/E67E

      rlUnknown9EE67E ; 9E/E67E

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7E4F79
        tax
        lda $7E4F7B
        tay
        jsl rlUnknown9E8D25
        lda #(`aUnknown9EEC22)<<8
        sta lR44+1
        lda #<>aUnknown9EEC22
        sta lR44
        lda #<>aUnknown9EEC22
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F4C01
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/E6C6

      rlUnknown9EE6C6 ; 9E/E6C6

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7E4F7D
        tax
        lda $7E4F7F
        tay
        jsl rlUnknown9E8D25
        lda #(`aUnknown9EEC22)<<8
        sta lR44+1
        lda #<>aUnknown9EEC22
        sta lR44
        lda #<>aUnknown9EEC22
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F4C03
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/E70E

      rlUnknown9EE70E ; 9E/E70E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlUnknown9EE71E
        plx
        rtl

        .databank 0

        ; 9E/E71E

      rlUnknown9EE71E ; 9E/E71E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C01
        tax
        lda $7E4F79
        sta wR0
        lda $7E4F7B
        sta wR1
        jsl rlUnknown9EE514
        lda $7F4C03
        tax
        lda $7E4F7D
        sta wR0
        lda $7E4F7F
        sta wR1
        jsl rlUnknown9EE514
        plx
        rtl

        .databank 0

        ; 9E/E74B

      rlUnknown9EE74B ; 9E/E74B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C01
        tax
        jsl rlMoveActiveSpriteByVelocity
        lda $7F4BFF
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        sta wR0
        lda aActiveSpriteSystem.aUnknown001240,b,x
        sta wR1
        lda #$0001
        sta wR2
        lda $7F4C01
        tax
        jsl rlUnknown9EA566
        lda $7F4C03
        tax
        jsl rlMoveActiveSpriteByVelocity
        lda $7F4BFF
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        sta wR0
        lda aActiveSpriteSystem.aUnknown001240,b,x
        sta wR1
        lda #$0001
        sta wR2
        lda $7F4C03
        tax
        jsl rlUnknown9EA566
        bcc _E7A6
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _E7A6
        plx
        rtl

        .databank 0

        ; 9E/E7A8

      rlUnknown9EE7A8 ; 9E/E7A8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown9EE5C8
        jsl rlUnknown9EE1F7
        lda $7F4C01
        tax
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda $7F4C03
        tax
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda $7F4BFF
        tax
        lda #<>aUnknown9EEC15
        sta aActiveSpriteSystem.aCodeOffset,b,x
        lda #$0001
        sta aActiveSpriteSystem.aFrameTimer,b,x
        lda #$002C
        jsl rlMapBattlePlaySoundAtSprite
        plx
        rtl

        .databank 0

        ; 9E/E7DB

      rlUnknown9EE7DB ; 9E/E7DB

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        jsl rlUnknown96D659
        stz wR0
        lda #(`aUnknown9EE7F4)<<8
        sta lR18+1
        lda #<>aUnknown9EE7F4
        sta lR18
        jsl rlBattleSceneStartPaletteEffect
        plx
        ply
        rtl

        .databank 0

        ; 9E/E7F4

      aUnknown9EE7F4 ; 9E/E7F4

        PALETTE_EFFECT $02, $01, $E1, $08, aUnknown9EE7FB

      aUnknown9EE7FB ; 9E/E7FB

        .byte $81, $7B, $59, $7B, $9B, $7F, $DE, $67, $9C
        .byte $4F, $5A, $33, $38, $1A, $F6, $02, $B4, $03, $7A, $1B, $9B, $33, $9C, $4B, $FF
        .byte $7B, $DF, $67, $7F, $53, $3F, $3A, $DF, $26, $9F, $12, $3F, $26, $9F, $3A, $DF
        .byte $53, $3F, $7F, $DE, $7B, $59, $72, $6F, $72, $B1, $72, $6F, $6E, $2C, $72, $6F
        .byte $72, $B1, $76, $F4, $77, $16, $FE

      procUnknown9EE83B ; 9E/E83B

        ; Unreferenced: nothing creates this proc.

        .structProcInfo "ON", rlProcUnknown9EE83BInit, rlProcUnknown9EE83BCycle, aProcUnknown9EE83BCode

      rlProcUnknown9EE83BInit ; 9E/E843

        .al
        .xl
        .autsiz
        .databank ?

        lda #$002B
        jsl rlMapBattlePlaySoundAtSprite
        jsl rlUnknown9EE88C
        jsl rlUnknown9EE8E2
        jsl rlUnknown9EE92A
        jsl rlUnknown9EE9A5
        rtl

        .databank 0

        ; 9E/E85B

      rlProcUnknown9EE83BCycle ; 9E/E85B

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/E85C

        ; Unreachable: it follows a return.
        rtl

      aProcUnknown9EE83BCode ; 9E/E85D

        PROC_SET_UNK_TIMER 30
        _E861
        PROC_YIELD 1
        PROC_CALL rlBattleSceneRunPaletteEffects
        PROC_JUMP_WHILE_UNK_TIMER _E861
        PROC_CALL rlUnknown9EE70E
        _E871
        PROC_YIELD 1
        PROC_CALL rlUnknown9EE74B
        PROC_CALL rlBattleSceneRunPaletteEffects
        PROC_JUMP_IF_BITS_UNSET _E871, $0004
        PROC_CALL rlUnknown9EE972
        PROC_YIELD 24
        PROC_END


        ; 9E/E88C

      rlUnknown9EE88C ; 9E/E88C

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #(`aUnknown9EEB4A)<<8
        sta aMapAction.lUnknown7F4598+1
        lda #<>aUnknown9EEB4A
        sta aMapAction.lUnknown7F4598
        lda $7F57EE
        tax
        lda $7F57F0
        tay
        jsl rlUnknown9E8D25
        lda #(`aUnknown9EEBB2)<<8
        sta lR44+1
        lda #<>aUnknown9EEBB2
        sta lR44
        lda #<>aUnknown9EEBB2
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F4BFF
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/E8E2

      rlUnknown9EE8E2 ; 9E/E8E2

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7E4F79
        tax
        lda $7E4F7B
        tay
        jsl rlUnknown9E8D25
        lda #(`aUnknown9EEBB2)<<8
        sta lR44+1
        lda #<>aUnknown9EEBB2
        sta lR44
        lda #<>aUnknown9EEBB2
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F4C01
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/E92A

      rlUnknown9EE92A ; 9E/E92A

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7E4F7D
        tax
        lda $7E4F7F
        tay
        jsl rlUnknown9E8D25
        lda #(`aUnknown9EEBB2)<<8
        sta lR44+1
        lda #<>aUnknown9EEBB2
        sta lR44
        lda #<>aUnknown9EEBB2
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F4C03
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/E972

      rlUnknown9EE972 ; 9E/E972

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown9EE5C8
        jsl rlUnknown9EE1F7
        lda $7F4C01
        tax
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda $7F4C03
        tax
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda $7F4BFF
        tax
        lda #<>aUnknown9EEBA5
        sta aActiveSpriteSystem.aCodeOffset,b,x
        lda #$0001
        sta aActiveSpriteSystem.aFrameTimer,b,x
        lda #$002C
        jsl rlMapBattlePlaySoundAtSprite
        plx
        rtl

        .databank 0

        ; 9E/E9A5

      rlUnknown9EE9A5 ; 9E/E9A5

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        jsl rlUnknown96D659
        stz wR0
        lda #(`aUnknown9EE9BE)<<8
        sta lR18+1
        lda #<>aUnknown9EE9BE
        sta lR18
        jsl rlBattleSceneStartPaletteEffect
        plx
        ply
        rtl

        .databank 0

        ; 9E/E9BE

      aUnknown9EE9BE ; 9E/E9BE

        PALETTE_EFFECT $02, $01, $E1, $08, aUnknown9EE9C5

      aUnknown9EE9C5 ; 9E/E9C5

        .byte $81, $35, $B7, $42, $1C, $4A, $5F, $46, $FF
        .byte $16, $1E, $0D, $77, $08, $ED, $04, $89, $08, $ED, $0D, $77, $16, $1E, $26, $BF
        .byte $5F, $FF, $3B, $FF, $03, $FF, $02, $F7, $02, $52, $01, $4A, $01, $4A, $01, $AD
        .byte $02, $B5, $3B, $FF, $4A, $5F, $29, $52, $18, $EC, $0C, $87, $04, $44, $0C, $87
        .byte $14, $AA, $18, $EC, $29, $52, $FE

      aUnknown9EEA05 ; 9E/EA05

        ; A frame table for script command $0E (ACTIVE_SPRITE_TABLE_FRAME):
        ; the offsets of the frame list and of the first script, then the frames.

        .word _Table - aUnknown9EEA05
        .word aUnknown9EEA8A - aUnknown9EEA05

        _Frame00
          .word 1 ; sprite count
          .structSpriteEntry (  -4,   -4), $00, SpriteSmall, $040, 2, 0, false, false

        _Frame01
          .word 1 ; sprite count
          .structSpriteEntry (  -4,   -4), $00, SpriteSmall, $050, 2, 0, false, false

        _Frame02
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $041, 2, 0, false, false

        _Frame03
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $043, 2, 0, false, false

        _Frame04
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $045, 2, 0, false, false

        _Frame05
          .word 2 ; sprite count
          .structSpriteEntry ( -14,    2), $00, SpriteSmall, $040, 2, 0, false, false
          .structSpriteEntry ( -15,   -5), $00, SpriteSmall, $057, 2, 0, false, false

        _Frame06
          .word 2 ; sprite count
          .structSpriteEntry ( -15,  -11), $00, SpriteSmall, $040, 2, 0, false, false
          .structSpriteEntry ( -11,  -16), $00, SpriteSmall, $047, 2, 0, false, false

        _Frame07
          .word 2 ; sprite count
          .structSpriteEntry (  -6,  -17), $00, SpriteSmall, $040, 2, 0, false, false
          .structSpriteEntry (   1,  -14), $00, SpriteSmall, $057, 2, 0, false, false

        _Frame08
          .word 2 ; sprite count
          .structSpriteEntry (   6,   -9), $00, SpriteSmall, $040, 2, 0, false, false
          .structSpriteEntry (   8,   -3), $00, SpriteSmall, $047, 2, 0, false, false

        _Frame09
          .word 2 ; sprite count
          .structSpriteEntry (   6,    5), $00, SpriteSmall, $040, 2, 0, false, false
          .structSpriteEntry (  -1,    8), $00, SpriteSmall, $057, 2, 0, false, false

        _Frame10
          .word 2 ; sprite count
          .structSpriteEntry ( 240,  -16), $00, SpriteSmall, $0FF, 2, 0, false, false
          .structSpriteEntry ( 240,  -16), $00, SpriteSmall, $0FF, 2, 0, false, false

        _Table
          .word _Frame00 - aUnknown9EEA05
          .word _Frame01 - aUnknown9EEA05
          .word _Frame02 - aUnknown9EEA05
          .word _Frame03 - aUnknown9EEA05
          .word _Frame04 - aUnknown9EEA05
          .word _Frame05 - aUnknown9EEA05
          .word _Frame06 - aUnknown9EEA05
          .word _Frame07 - aUnknown9EEA05
          .word _Frame08 - aUnknown9EEA05
          .word _Frame09 - aUnknown9EEA05
          .word _Frame10 - aUnknown9EEA05

      aUnknown9EEA8A ; 9E/EA8A

        ACTIVE_SPRITE_TABLE_FRAME 5, 0
        ACTIVE_SPRITE_TABLE_FRAME 5, 1
        ACTIVE_SPRITE_TABLE_FRAME 5, 2
        ACTIVE_SPRITE_TABLE_FRAME 5, 3
        ACTIVE_SPRITE_TABLE_FRAME 5, 4
        ACTIVE_SPRITE_TABLE_FRAME 255, 10
        ACTIVE_SPRITE_TABLE_FRAME 255, 10
        ACTIVE_SPRITE_TABLE_FRAME 255, 10
        ACTIVE_SPRITE_TABLE_FRAME 255, 10
        ACTIVE_SPRITE_END

      aUnknown9EEAA6 ; 9E/EAA6

        ACTIVE_SPRITE_TABLE_FRAME 4, 0
        ACTIVE_SPRITE_TABLE_FRAME 4, 5
        ACTIVE_SPRITE_TABLE_FRAME 4, 6
        ACTIVE_SPRITE_TABLE_FRAME 4, 7
        ACTIVE_SPRITE_TABLE_FRAME 4, 8
        ACTIVE_SPRITE_TABLE_FRAME 4, 9
        ACTIVE_SPRITE_TABLE_FRAME 4, 5
        ACTIVE_SPRITE_TABLE_FRAME 4, 6
        ACTIVE_SPRITE_TABLE_FRAME 4, 7
        ACTIVE_SPRITE_TABLE_FRAME 4, 8
        ACTIVE_SPRITE_TABLE_FRAME 4, 9
        ACTIVE_SPRITE_END

      aUnknown9EEAC8 .dstruct structActiveSpriteInfo, rlUnknown9EEAD4, rlUnknown9EEAD4, aUnknown9EEA8A ; 9E/EAC8

        ; Unreferenced.
      aUnknown9EEACE .dstruct structActiveSpriteInfo, rlUnknown9EEAD4, rlUnknown9EEAD4, aUnknown9EEAA6 ; 9E/EACE

      rlUnknown9EEAD4 ; 9E/EAD4

        ; The definitions' init and on-cycle routine: does nothing.

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

      aUnknown9EEAD5 ; 9E/EAD5

        ; A frame table for script command $0E (ACTIVE_SPRITE_TABLE_FRAME):
        ; the offsets of the frame list and of the first script, then the frames.

        .word _Table - aUnknown9EEAD5
        .word aUnknown9EEB21 - aUnknown9EEAD5

        _Frame00
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $040, 2, 0, false, false

        _Frame01
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $042, 2, 0, false, false

        _Frame02
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $044, 2, 0, false, false

        _Frame03
          .word 1 ; sprite count
          .structSpriteEntry (  -5,   -4), $00, SpriteSmall, $046, 2, 0, false, false

        _Frame04
          .word 1 ; sprite count
          .structSpriteEntry (  -5,   -4), $00, SpriteSmall, $056, 2, 0, false, false

        _Frame05
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $047, 2, 0, false, false

        _Frame06
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $049, 2, 0, false, false

        _Frame07
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $04B, 2, 0, false, false

        _Table
          .word _Frame00 - aUnknown9EEAD5
          .word _Frame01 - aUnknown9EEAD5
          .word _Frame02 - aUnknown9EEAD5
          .word _Frame03 - aUnknown9EEAD5
          .word _Frame04 - aUnknown9EEAD5
          .word _Frame05 - aUnknown9EEAD5
          .word _Frame06 - aUnknown9EEAD5
          .word _Frame07 - aUnknown9EEAD5

      aUnknown9EEB21 ; 9E/EB21

        ACTIVE_SPRITE_TABLE_FRAME 2, 0
        ACTIVE_SPRITE_TABLE_FRAME 2, 1
        ACTIVE_SPRITE_TABLE_FRAME 2, 2
        ACTIVE_SPRITE_JUMP aUnknown9EEB21

      aUnknown9EEB2D ; 9E/EB2D

        ACTIVE_SPRITE_TABLE_FRAME 5, 3
        ACTIVE_SPRITE_TABLE_FRAME 3, 4
        ACTIVE_SPRITE_TABLE_FRAME 3, 5
        ACTIVE_SPRITE_TABLE_FRAME 5, 6
        ACTIVE_SPRITE_TABLE_FRAME 5, 7
        ACTIVE_SPRITE_END

      aUnknown9EEB3D .dstruct structActiveSpriteInfo, rlUnknown9EEB49, rlUnknown9EEB49, aUnknown9EEB21 ; 9E/EB3D

        ; Unreferenced.
      aUnknown9EEB43 .dstruct structActiveSpriteInfo, rlUnknown9EEB49, rlUnknown9EEB49, aUnknown9EEB2D ; 9E/EB43

      rlUnknown9EEB49 ; 9E/EB49

        ; The definitions' init and on-cycle routine: does nothing.

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

      aUnknown9EEB4A ; 9E/EB4A

        ; A frame table for script command $0E (ACTIVE_SPRITE_TABLE_FRAME):
        ; the offsets of the frame list and of the first script, then the frames.

        .word _Table - aUnknown9EEB4A
        .word aUnknown9EEB96 - aUnknown9EEB4A

        _Frame00
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $040, 2, 0, false, false

        _Frame01
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $042, 2, 0, false, false

        _Frame02
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $044, 2, 0, false, false

        _Frame03
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $046, 2, 0, false, false

        _Frame04
          .word 1 ; sprite count
          .structSpriteEntry (  -4,   -3), $00, SpriteSmall, $048, 2, 0, false, false

        _Frame05
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $049, 2, 0, false, false

        _Frame06
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $04B, 2, 0, false, false

        _Frame07
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $04D, 2, 0, false, false

        _Table
          .word _Frame00 - aUnknown9EEB4A
          .word _Frame01 - aUnknown9EEB4A
          .word _Frame02 - aUnknown9EEB4A
          .word _Frame03 - aUnknown9EEB4A
          .word _Frame04 - aUnknown9EEB4A
          .word _Frame05 - aUnknown9EEB4A
          .word _Frame06 - aUnknown9EEB4A
          .word _Frame07 - aUnknown9EEB4A

      aUnknown9EEB96 ; 9E/EB96

        ACTIVE_SPRITE_TABLE_FRAME 1, 0
        ACTIVE_SPRITE_TABLE_FRAME 1, 1
        ACTIVE_SPRITE_TABLE_FRAME 1, 2
        ACTIVE_SPRITE_TABLE_FRAME 1, 3
        ACTIVE_SPRITE_JUMP aUnknown9EEB96

      aUnknown9EEBA5 ; 9E/EBA5

        ACTIVE_SPRITE_TABLE_FRAME 5, 4
        ACTIVE_SPRITE_TABLE_FRAME 5, 5
        ACTIVE_SPRITE_TABLE_FRAME 5, 6
        ACTIVE_SPRITE_TABLE_FRAME 5, 7
        ACTIVE_SPRITE_END

      aUnknown9EEBB2 .dstruct structActiveSpriteInfo, rlUnknown9EEBB8, rlUnknown9EEBB8, aUnknown9EEB96 ; 9E/EBB2

      rlUnknown9EEBB8 ; 9E/EBB8

        ; The definitions' init and on-cycle routine: does nothing.

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

      aUnknown9EEBB9 ; 9E/EBB9

        ; A frame table for script command $0E (ACTIVE_SPRITE_TABLE_FRAME):
        ; the offsets of the frame list and of the first script, then the frames.

        .word _Table - aUnknown9EEBB9
        .word aUnknown9EEBFC - aUnknown9EEBB9

        _Frame00
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $040, 2, 0, false, false

        _Frame01
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $042, 2, 0, false, false

        _Frame02
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $044, 2, 0, false, false

        _Frame03
          .word 1 ; sprite count
          .structSpriteEntry (  -4,   -3), $00, SpriteSmall, $046, 2, 0, false, false

        _Frame04
          .word 1 ; sprite count
          .structSpriteEntry (  -4,   -4), $00, SpriteSmall, $056, 2, 0, false, false

        _Frame05
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $047, 2, 0, false, false

        _Frame06
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $049, 2, 0, false, false

        _Table
          .word _Frame00 - aUnknown9EEBB9
          .word _Frame01 - aUnknown9EEBB9
          .word _Frame02 - aUnknown9EEBB9
          .word _Frame03 - aUnknown9EEBB9
          .word _Frame04 - aUnknown9EEBB9
          .word _Frame05 - aUnknown9EEBB9
          .word _Frame06 - aUnknown9EEBB9

      aUnknown9EEBFC ; 9E/EBFC

        ACTIVE_SPRITE_TABLE_FRAME 1, 0
        ACTIVE_SPRITE_TABLE_FRAME 1, 1
        ACTIVE_SPRITE_TABLE_FRAME 1, 2
        ACTIVE_SPRITE_JUMP aUnknown9EEBFC

      aUnknown9EEC08 ; 9E/EC08
        ; Unreferenced.

        ACTIVE_SPRITE_TABLE_FRAME 3, 3
        ACTIVE_SPRITE_TABLE_FRAME 3, 4
        ACTIVE_SPRITE_TABLE_FRAME 3, 5
        ACTIVE_SPRITE_TABLE_FRAME 3, 6
        ACTIVE_SPRITE_END

      aUnknown9EEC15 ; 9E/EC15

        ACTIVE_SPRITE_TABLE_FRAME 4, 3
        ACTIVE_SPRITE_TABLE_FRAME 5, 4
        ACTIVE_SPRITE_TABLE_FRAME 6, 5
        ACTIVE_SPRITE_TABLE_FRAME 3, 6
        ACTIVE_SPRITE_END

      aUnknown9EEC22 .dstruct structActiveSpriteInfo, rlUnknown9EEC28, rlUnknown9EEC28, aUnknown9EEBFC ; 9E/EC22

      rlUnknown9EEC28 ; 9E/EC28

        ; The definitions' init and on-cycle routine: does nothing.

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

      aUnknown9EEC29 ; 9E/EC29

        ; A frame table for script command $0E (ACTIVE_SPRITE_TABLE_FRAME):
        ; the offsets of the frame list and of the first script, then the frames.

        .word _Table - aUnknown9EEC29
        .word aUnknown9EEC6C - aUnknown9EEC29

        _Frame00
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $048, 2, 0, false, false

        _Frame01
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $044, 2, 0, false, false

        _Frame02
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $046, 2, 0, false, false

        _Frame03
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $040, 2, 0, false, false

        _Frame04
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $042, 2, 0, false, false

        _Frame05
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $04A, 2, 0, false, false

        _Frame06
          .word 1 ; sprite count
          .structSpriteEntry (  -8,   -8), $21, SpriteLarge, $04C, 2, 0, false, false

        _Table
          .word _Frame00 - aUnknown9EEC29
          .word _Frame01 - aUnknown9EEC29
          .word _Frame02 - aUnknown9EEC29
          .word _Frame03 - aUnknown9EEC29
          .word _Frame04 - aUnknown9EEC29
          .word _Frame05 - aUnknown9EEC29
          .word _Frame06 - aUnknown9EEC29

      aUnknown9EEC6C ; 9E/EC6C

        ACTIVE_SPRITE_TABLE_FRAME 4, 0
        ACTIVE_SPRITE_TABLE_FRAME 4, 1
        ACTIVE_SPRITE_TABLE_FRAME 4, 0
        ACTIVE_SPRITE_TABLE_FRAME 4, 2
        ACTIVE_SPRITE_JUMP aUnknown9EEC6C

      aUnknown9EEC7B ; 9E/EC7B
        ; Unreferenced.

        ACTIVE_SPRITE_TABLE_FRAME 4, 3
        ACTIVE_SPRITE_TABLE_FRAME 4, 4
        ACTIVE_SPRITE_TABLE_FRAME 4, 5
        ACTIVE_SPRITE_TABLE_FRAME 4, 6
        ACTIVE_SPRITE_END

      aUnknown9EEC88 .dstruct structActiveSpriteInfo, rlUnknown9EEC94, rlUnknown9EEC94, aUnknown9EEC6C ; 9E/EC88

        ; Unreferenced.
      aUnknown9EEC8E .dstruct structActiveSpriteInfo, rlUnknown9EEC94, rlUnknown9EEC94, aUnknown9EEC7B ; 9E/EC8E

      rlUnknown9EEC94 ; 9E/EC94

        ; The definitions' init and on-cycle routine: does nothing.

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

    .endsection Unsorted9EE2BESection


    .section Unsorted9EF1B5Section

      .al
      .xl

      rlUnknown9EF1B5 ; 9E/F1B5

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4C07
        beq _F1D8
        lda $7F4C07
        ora #$0002
        sta $7F4C07
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _F1D8
        rtl

        .databank 0

        ; 9E/F1D9

    .endsection Unsorted9EF1B5Section


