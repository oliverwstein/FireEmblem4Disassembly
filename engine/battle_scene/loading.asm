; Loading a battle scene: each combatant's animation (sheet, extra tiles,
; frames, palette), weapon and character piece graphics, the background and
; foreground for the two terrains, and the combatants' starting places.


    .section BattleSceneCopyExperienceSection

      .al
      .xl

      rlBattleSceneCopyExperience ; 95/82D8

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies aActionStructUnit1's experience before and gained, and its level plus levels gained, for the experience bar.

        lda aActionStructUnit1.StartingExperience
        sta wBattleSceneExperience,b
        lda aActionStructUnit1.GainedExperience
        sta wBattleSceneExperienceGained,b
        sep #$20
        lda aActionStructUnit1.Level
        clc
        adc aActionStructUnit1.GainedLevels
        sta bBattleSceneLevel,b
        rep #$20
        rtl

        .databank 0

        ; 95/82F7

    .endsection BattleSceneCopyExperienceSection


    .section BattleSceneGetGenderSection

      .al
      .xl

      rlBattleSceneGetGender ; 95/82F7

        .al
        .xl
        .autsiz
        .databank ?

        ; A = a unit's gender, wR0 = its class; returns the class's default gender (aClassDefaultGenders) when the gender is $FF.

        phx
        cmp #$00FF
        bne _8306
        ldx wR0
        lda aClassDefaultGenders,x
        and #$00FF

        _8306
        plx
        rtl

        .databank 0

        ; 95/8308

      rsBattleSceneLoadBackground ; 95/8308

        .al
        .xl
        .autsiz
        .databank ?

        ; Picks whose terrain the background shows and loads it (rsBattleSceneSetWaterFlags, rsBattleSceneLoadBackgroundLayer, rsBattleSceneLoadForeground).

        phx
        lda wBattleSceneFlags
        bit #BattleSceneFlagDance
        bne _8338
        jsl rlBattleSceneGetFirstStriker
        bcs _8320
        ldx #$0043
        lda aBattleSceneCombatant1.Weapon,b
        bra _8326


        _8320
        ldx #$0000
        lda aBattleSceneCombatant2.Weapon,b

        _8326
        jsl rlBattleSceneGetWeaponPlacement
        bcs _833D
        cmp #$0000
        beq _8338
        cmp #$0001
        beq _8338
        bra _833D


        _8338
        lda wBattleSceneAttackerTerrain,b
        bra _8340


        _833D
        lda wBattleSceneDefenderTerrain,b

        _8340
        jsr rsBattleSceneSetWaterFlags
        jsr rsBattleSceneLoadBackgroundLayer
        jsr rsBattleSceneLoadForeground
        plx
        rts

        .databank 0

        ; 95/834B

      rsBattleSceneLoadCombatantGraphics ; 95/834B

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsBattleSceneLoadCombatantSprites
        jsl rlBattleSceneLoadCharacterPieces
        rts

        .databank 0

        ; 95/8353

      rsBattleSceneLoadCombatantSprites ; 95/8353

        .al
        .xl
        .autsiz
        .databank ?

        ; For each combatant present: its weapon's tiles and colors, its extra tiles, its sheet and its palette (combatant 1 carry clear, combatant 2 carry set).

        lda aBattleSceneCombatant1.Character,b
        cmp #$0000
        beq _83A9
        lda aBattleSceneCombatant1.AnimStyle,b
        and #$00F0
        sta wR0
        lda aBattleSceneCombatant1.Class,b
        sta wR1
        lda aBattleSceneCombatant1.Weapon,b
        and #$00FF
        clc
        jsl rlBattleSceneLoadWeaponGraphics
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0400, $80, $8800

        lda $7FE1B8
        and #$00FF
        clc
        jsr rsBattleSceneLoadExtraTiles
        lda $7FE1B7
        and #$00FF
        clc
        jsr rsBattleSceneLoadSheet
        lda $7FE1B9
        and #$00FF
        clc
        jsr rsBattleSceneLoadPalette
        lda aBattleSceneCombatant1.Character,b
        clc
        jsl rlBattleSceneLoadCharacterColors

        _83A9
        lda aBattleSceneCombatant2.Character,b
        cmp #$0000
        beq _83FF
        lda aBattleSceneCombatant2.AnimStyle,b
        and #$00F0
        sta wR0
        lda aBattleSceneCombatant2.Class,b
        sta wR1
        lda aBattleSceneCombatant2.Weapon,b
        and #$00FF
        sec
        jsl rlBattleSceneLoadWeaponGraphics
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0400, $80, $A800

        lda $7FE1BC
        and #$00FF
        sec
        jsr rsBattleSceneLoadExtraTiles
        lda $7FE1BB
        and #$00FF
        sec
        jsr rsBattleSceneLoadSheet
        lda $7FE1BD
        and #$00FF
        sec
        jsr rsBattleSceneLoadPalette
        lda aBattleSceneCombatant2.Character,b
        sec
        jsl rlBattleSceneLoadCharacterColors

        _83FF
        rts

        .databank 0

        ; 95/8400

      rsBattleSceneLoadExtraTiles ; 95/8400

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the combatant's extra tiles ID (aBattleAnimationExtraIndices); carry set for combatant 2. Decompresses them, recolors them when the record names a palette, and copies them to VRAM.

        pha
        phx
        phy
        php
        inc a
        and #$00FF
        pha
        tax
        lda aBattleAnimationExtraIndices,x
        and #$00FF
        pha
        asl a
        asl a
        asl a
        sec
        sbc #1,s
        clc
        adc #aBattleAnimationExtras - aBattleAnimationExtraIndices ; X = 7 * entry, from aBattleAnimationExtraIndices
        tax
        pla
        pla
        cmp #$0000
        bne _8432
        lda #(`ANIM_NO_EXTRA_TILES_SOURCE)<<8
        sta lR18+1
        lda #<>ANIM_NO_EXTRA_TILES_SOURCE
        sta lR18
        jml _84A9


        _8432
        lda aBattleAnimationExtraIndices+3,x
        sta lR45+1
        lda aBattleAnimationExtraIndices+2,x
        sta lR45
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        phx
        jsl rlDecompressSingle
        plx
        lda aBattleAnimationExtraIndices+5,x
        cmp #$FFFF
        beq _849F
        and #$F800
        cmp #$F800
        beq _849F
        lda aBattleAnimationExtraIndices+5,x
        and #$07FF
        phx
        pha
        asl a
        adc #1,s
        tax
        pla
        lda aBattleAnimationPaletteIndices+1,x
        sta lR45+1
        lda aBattleAnimationPaletteIndices,x
        sta lR45
        plx
        lda #$7E00
        sta lR47+1
        lda #$AB88
        sta lR47
        jsl rlDecompressSingle
        lda #$7E00
        sta lR18+1
        lda #$AB88
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        sta lR19
        jsr rsBattleSceneCopyTileList

        _849F
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18

        _84A9
        lda aBattleAnimationExtraIndices,x
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        plp
        bcs _84BD
        clc
        adc #$4000
        bra _84C1


        _84BD
        clc
        adc #$5000

        _84C1
        sta wR0
        lda aBattleAnimationExtraIndices+1,x
        and #$00FF
        asl a
        asl a
        asl a
        asl a
        asl a
        jsl rlBattleSceneDMAToVRAM
        ply
        plx
        pla
        rts

        .databank 0

        ; 95/84D7

      rsBattleSceneLoadSheet ; 95/84D7

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the combatant's sheet ID (aBattleAnimationSheetIndices); carry set for combatant 2. Decompresses it to $7F0000 or $7F6000, recolored when the record names a palette.

        pha
        phx
        phy
        php
        inc a
        and #$00FF
        pha
        tax
        lda aBattleAnimationSheetIndices,x
        and #$00FF
        pha
        asl a
        asl a
        clc
        adc #1,s
        clc
        adc #$0068
        tax
        pla
        lda aBattleAnimationSheetIndices+1,x
        sta lR45+1
        lda aBattleAnimationSheetIndices,x
        sta lR45
        pla
        plp
        pha
        php
        bcs _8510
        lda #$7F00
        sta lR47+1
        lda #$0000
        bra _8518


        _8510
        lda #$7F00
        sta lR47+1
        lda #$6000

        _8518
        sta lR47
        pla
        cmp #$0000
        bne _8520

        _8520
        phx
        jsl rlDecompressSingle
        plx
        lda aBattleAnimationSheetIndices+3,x
        cmp #$FFFF
        beq _8588
        and #$F800
        cmp #$F800
        beq _8588
        lda aBattleAnimationSheetIndices+3,x
        and #$07FF
        phx
        pha
        asl a
        adc #1,s
        tax
        pla
        lda aBattleAnimationPaletteIndices+1,x
        sta lR45+1
        lda aBattleAnimationPaletteIndices,x
        sta lR45
        plx
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        plp
        bcs _8579
        lda #$7F00
        sta lR19+1
        lda #$0000
        sta lR19
        bra _8583


        _8579
        lda #$7F00
        sta lR19+1
        lda #$6000
        sta lR19

        _8583
        jsr rsBattleSceneCopyTileList
        bra _8589


        _8588
        plp

        _8589
        ply
        plx
        pla
        rts

        .databank 0

        ; 95/858D

      rsBattleSceneLoadPalette ; 95/858D

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the combatant's palette ID; carry set for combatant 2. aBattleAnimationPaletteOverrides can replace it for a character and class; copies it to sprite palette 0 or 4, the enemy colors (Y offset) only for an enemy unit not in an arena battle.

        pha
        phx
        php
        pha
        bcs _859F
        lda aBattleSceneCombatant1.Character,b
        sta wR0
        lda aBattleSceneCombatant1.Class,b
        sta wR1
        bra _85A9


        _859F
        lda aBattleSceneCombatant2.Character,b
        sta wR0
        lda aBattleSceneCombatant2.Class,b
        sta wR1

        _85A9
        ldx #$0000

        _85AC
        lda aBattleAnimationPaletteOverrides,x
        cmp #$FFFF
        beq _85DD
        cmp wR0
        bne _85C4
        lda aBattleAnimationPaletteOverrides+2,x
        and #$00FF
        cmp wR1
        beq _85CC

        _85C4
        txa
        clc
        adc #$0004
        tax
        bra _85AC


        _85CC
        lda aBattleAnimationPaletteOverrides+3,x
        and #$00FF
        sta #1,s
        lda #$0001
        sta wR2
        pla
        bra _85E3


        _85DD
        lda #$0000
        sta wR2
        pla

        _85E3
        inc a
        and #$00FF
        tax
        lda aBattleAnimationPaletteIndices,x
        and #$00FF
        asl a
        asl a
        clc
        adc #$006B
        tax
        lda aBattleAnimationPaletteIndices,x
        sta lR18
        lda aBattleAnimationPaletteIndices+1,x
        sta lR18+1
        lda aBattleAnimationPaletteIndices+3,x
        and #$00FF
        plp
        bcs _8614
        ldx #$0002
        ldy #$0000
        bra _8618


        _8614
        ldx #$0082
        tay

        _8618
        pha
        lda wR2
        bne _8647
        pla
        pha
        lda wBattleType
        and #$00FF
        cmp #$0002
        beq _8647
        pla
        pha
        lda @l $000D5E
        cmp #$0040
        bcc _8647
        pla
        pha
        jsl rlBattleSceneGetFirstStriker
        bcs _864A
        lda aBattleSceneCombatant1.Weapon,b
        jsl rlBattleSceneIsSupportStaff
        bcc _864A

        _8647
        ldy #$0000

        _864A
        pla

        _864B
        pha
        sep #$20
        lda [lR18],y
        sta aOAMPaletteBuffer,b,x
        rep #$20
        lda lR18
        inc a
        cmp #$0000
        bne _8664
        inc lR18+2
        lda #$8000
        bra _866E


        _8664
        cmp #$8000
        bne _866E
        inc lR18+2
        lda #$0000

        _866E
        sta lR18
        inc x
        pla
        dec a
        bne _864B
        plx
        pla
        rts

        .databank 0

        ; 95/8678

      rlBattleSceneIsSupportStaff ; 95/8678

        .al
        .xl
        .autsiz
        .databank ?

        ; A = item ID: carry set for a staff listed at aBattleSceneSupportStaves (Heal to Rescue, Restore, Valkyrie: not Charm or the status staves).

        phx
        pha
        sep #$20
        ldx #$0000

        _867F
        lda aBattleSceneSupportStaves,x
        cmp #$FF
        beq _8691
        cmp #1,s
        beq _868E
        inc x
        bra _867F


        _868E
        sec
        bra _8692


        _8691
        clc

        _8692
        rep #$20
        pla
        plx
        rtl

        .databank 0

        ; 95/8697

      rlBattleSceneLoadWeaponGraphics ; 95/8697

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the weapon, wR0 = the combatant's animation category << 4, wR1 its class; carry set for combatant 2. Decompresses the weapon's tiles (aBattleWeaponGraphics) and copies its 15 colors to BG palette 5 or 7; magic, no weapon, and classes listed at aBattleSceneBarehandedClasses get blank tiles.

        pha
        phx
        phy
        php
        pha
        lda wR0
        cmp #$0090
        beq _86AE
        cmp #$0070
        beq _86AE
        jsl rlBattleSceneCheckBarehandedClass
        bcc _86B5

        _86AE
        pla
        jsr rsBattleSceneClearWeaponGraphics
        plp
        bra _871D


        _86B5
        pla
        and #$00FF
        asl a
        tax
        lda aBattleWeaponGraphicsIndices,x
        pha
        and #$00FF
        pha
        asl a
        clc
        adc #1,s
        tax
        pla
        lda aBattleWeaponGraphics,x
        sta lR45
        lda aBattleWeaponGraphics+1,x
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        pla
        xba
        and #$00FF
        asl a
        pha
        asl a
        asl a
        asl a
        asl a
        sec
        sbc #1,s
        clc
        adc #$0F30
        sta lR18
        pla
        sep #$20
        lda #$E0
        sta lR18+2
        rep #$20
        plp
        bcs _8709
        ldx #$0142
        bra _870C


        _8709
        ldx #$01C2

        _870C
        ldy #$0000

        _870F
        lda [lR18],y
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        inc y
        inc y
        cpy #$001E
        bcc _870F

        _871D
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/8721

      rlBattleSceneCheckBarehandedClass ; 95/8721

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set when A is $80 (staff category) and wR1, the class, is listed at aBattleSceneBarehandedClasses.

        phx
        cmp #$0080
        bne _873E
        ldx #$0000

        _872A
        lda aBattleSceneBarehandedClasses,x
        cmp #$FFFF
        beq _873E
        cmp wR1
        beq _873B
        inc x
        inc x
        bra _872A


        _873B
        sec
        bra _873F


        _873E
        clc

        _873F
        plx
        rtl

        .databank 0

        ; 95/8741

      rsBattleSceneClearWeaponGraphics ; 95/8741

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        ldx #$0000
        lda #$0000

        _8749
        sta $7E8B88,x
        inc x
        inc x
        cpx #$0400
        bcc _8749
        plx
        pla
        rts

        .databank 0

        ; 95/8757

      rlBattleSceneDMAToVRAM ; 95/8757

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies A bytes from lR18 to VRAM word address wR0 on DMA channel 1, now.

        pha
        sep #$20
        stz $420B,b
        stz $420C,b
        sta $4315,b
        xba
        sta $4316,b
        lda lR18
        sta $4312,b
        lda lR18+1
        sta $4313,b
        lda lR18+2
        sta $4314,b
        lda #$80
        sta $2115,b
        lda wR0
        sta $2116,b
        lda wR0+1
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$18
        sta $4311,b
        lda #$02
        sta $420B,b
        rep #$20
        pla
        rtl

        .databank 0

        ; 95/8798

      rlBattleSceneLoadCharacterPieces ; 95/8798

        .al
        .xl
        .autsiz
        .databank ?

        ; For each combatant present: the tiles and 9 colors its character has for its class (aBattleCharacterPieceLookup), or blank tiles.

        lda aBattleSceneCombatant1.Character,b
        cmp #$0000
        beq _87DB
        lda aBattleSceneCombatant1.Character,b
        sta wR0
        lda aBattleSceneCombatant1.Class,b
        jsl rlBattleSceneGetCharacterPiece
        bcs _87C5
        pha
        lda aBattleSceneCombatant1.AnimStyle,b
        and #$00F0
        cmp #$0030
        bne _87BD
        pla
        bra _87C5


        _87BD
        pla
        clc
        jsl rlBattleSceneLoadCharacterPiece
        bra _87CE


        _87C5
        cmp #$0001
        beq _87DB
        jsl rlBattleSceneClearCharacterPiece

        _87CE
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0300, $80, $8C00


        _87DB
        lda aBattleSceneCombatant2.Character,b
        cmp #$0000
        beq _881E
        lda aBattleSceneCombatant2.Character,b
        sta wR0
        lda aBattleSceneCombatant2.Class,b
        jsl rlBattleSceneGetCharacterPiece
        bcs _8808
        pha
        lda aBattleSceneCombatant2.AnimStyle,b
        and #$00F0
        cmp #$0030
        bne _8800
        pla
        bra _8808


        _8800
        pla
        sec
        jsl rlBattleSceneLoadCharacterPiece
        bra _8811


        _8808
        cmp #$0001
        beq _881E
        jsl rlBattleSceneClearCharacterPiece

        _8811
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0300, $80, $AC00


        _881E
        rtl

        .databank 0

        ; 95/881F

      rlBattleSceneGetCharacterPiece ; 95/881F

        .al
        .xl
        .autsiz
        .databank ?

        ; A = class, wR0 = character. Finds the class's list in aBattleCharacterPieceLookup and the character's entry; carry clear and A = the piece. Carry set: A = 0 (class not listed) or 1 (character not listed).

        phx
        pha
        ldx #$0000

        _8824
        lda aBattleCharacterPieceLookup,x
        cmp #$FFFF
        beq _8861
        and #$00FF
        cmp #1,s
        beq _8839
        inc x
        inc x
        inc x
        bra _8824


        _8839
        pla
        inc x
        lda aBattleCharacterPieceLookup,x
        cmp #$FFFF
        beq _8868
        tax

        _8845
        lda aBattleCharacterPieceLookup,x
        cmp #$FFFF
        beq _8858
        cmp wR0
        beq _8858
        inc x
        inc x
        inc x
        inc x
        bra _8845


        _8858
        inc x
        inc x
        lda aBattleCharacterPieceLookup,x
        clc
        bra _886C


        _8861
        pla
        lda #$0000
        sec
        bra _886C


        _8868
        lda #$0001
        sec

        _886C
        plx
        rtl

        .databank 0

        ; 95/886E

      rlBattleSceneLoadCharacterPiece ; 95/886E

        .al
        .xl
        .autsiz
        .databank ?

        ; A = a piece from aBattleCharacterPieceLookup: low byte the tiles (aBattleCharacterPieces), high byte the colors in bank $E0; carry set for combatant 2.

        pha
        phx
        phy
        php
        pha
        and #$00FF
        pha
        asl a
        clc
        adc #1,s
        tax
        pla
        lda aBattleCharacterPieces,x
        sta lR45
        lda aBattleCharacterPieces+1,x
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        pla
        xba
        and #$00FF
        asl a
        pha
        asl a
        asl a
        asl a
        clc
        adc #1,s
        clc
        adc #$1368
        sta lR18
        pla
        sep #$20
        lda #$E0
        sta lR18+2
        rep #$20
        plp
        bcs _88BB
        ldx #$0162
        bra _88BE


        _88BB
        ldx #$01E2

        _88BE
        ldy #$0000

        _88C1
        lda [lR18],y
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0012
        bcc _88C1
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/88D3

      rlBattleSceneClearCharacterPiece ; 95/88D3

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        ldx #$0000
        lda #$0000

        _88DB
        sta $7E8B88,x
        inc x
        inc x
        cpx #$0300
        bcc _88DB
        plx
        pla
        rtl

        .databank 0

        ; 95/88E9

      rsBattleScenePlaceCombatants ; 95/88E9

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads each combatant's frames and places the two facing each other: at the center when they are close, otherwise the defender at its spacing from the attacker; sets the camera (wBattleSceneCameraX).

        phx
        lda aBattleSceneCombatant1.Character,b
        cmp #$0000
        bne _88FD
        sep #$20
        lda #$00
        sta bBattleAnimationStateFlags,b
        rep #$20
        bra _8919


        _88FD
        jsl rlBattleAnimationResetSpawnSlot
        lda $7FE1B6
        and #$00FF
        jsl rlBattleSceneSetFramePointers
        lda #$0180
        sta wBattleAnimationSpawnX,b
        lda #$0000
        jsl rlBattleAnimationCopySpawnSlot

        _8919
        lda aBattleSceneCombatant2.Character,b
        cmp #$0000
        bne _892C
        sep #$20
        lda #$00
        sta bBattleAnimation2StateFlags,b
        rep #$20
        bra _8969


        _892C
        jsl rlBattleAnimationResetSpawnSlot
        lda $7FE1BA
        and #$00FF
        jsl rlBattleSceneSetFramePointers
        lda #$0080
        sta wBattleAnimationSpawnX,b
        lda #$5000
        sta wBattleAnimationSpawnSecondaryOffset,b
        lda #$7F00
        sta lBattleAnimationSpawnSecondaryPointer1+1,b
        lda #$6000
        sta lBattleAnimationSpawnSecondaryPointer1,b
        lda #$8100
        sta wBattleAnimationSpawnBaseTile,b
        sep #$20
        lda #$08
        sta bBattleAnimationSpawnAttributes,b
        rep #$20
        lda #$0001
        jsl rlBattleAnimationCopySpawnSlot

        _8969
        lda wBattleSceneFlags
        bit #BattleSceneFlagDance
        beq _8999
        lda #$0100
        sta wBattleAnimationX,b
        lda #$0100
        sta wBattleAnimation2X,b
        lda #$0000
        sta bBattleSceneCameraXFraction
        lda #$0100
        sta wBattleSceneCameraX
        sep #$20
        lda #$00
        sta bBattleSceneAttackerSide,b
        rep #$20
        jml _8A6A


        _8999
        jsl rlBattleSceneGetFirstStriker
        bcs _8A0B
        clc
        ldx #$0000
        jsl rlBattleSceneGetStartGap
        sta wR0
        lda wBattleAnimationX,b
        sec
        sbc wR0
        bcs _89B9
        cmp #$0068
        bcs _89B9
        lda #$0068

        _89B9
        sta wBattleAnimation2X,b
        lda aBattleSceneCombatant1.AnimStyle,b
        and #$00F0
        cmp #$0080
        beq _89EE
        ldx #$0000
        jsl rlBattleSceneCheckSwordAtRange
        bcs _89EE
        bra _89EE

        ; Unreachable: both branches above go to _89EE.
        ldx #$0000
        jsl rlBattleAnimationGetBodyByte7
        xba
        sta wBattleAnimationYFixed,b,x
        bit #$FFFF
        beq _89EE
        sep #$20
        lda bBattleAnimationStateFlags,b
        ora #$20
        sta bBattleAnimationStateFlags,b
        rep #$20


        _89EE
        clc
        jsr rsBattleSceneSetRoles
        lda #$0000
        sta bBattleSceneCameraXFraction
        lda #$00C0
        sta wBattleSceneCameraX
        sep #$20
        lda #$00
        sta bBattleSceneAttackerSide,b
        rep #$20
        bra _8A6A


        _8A0B
        sec
        ldx #$0043
        jsl rlBattleSceneGetStartGap
        sta wR0
        lda wBattleAnimation2X,b
        clc
        adc wR0
        bcc _8A25
        cmp #$0198
        bcc _8A25
        lda #$0198

        _8A25
        sta wBattleAnimationX,b
        ldx #$0043
        jsl rlBattleSceneCheckSwordAtRange
        bcs _8A4F
        bra _8A4F

        ; Unreachable: both branches above go to _8A4F.
        ldx #$0043
        jsl rlBattleAnimationGetBodyByte7
        xba
        sta wBattleAnimationYFixed,b,x
        bit #$FFFF
        beq _8A4F
        sep #$20
        lda bBattleAnimation2StateFlags,b
        ora #$20
        sta bBattleAnimation2StateFlags,b
        rep #$20


        _8A4F
        sec
        jsr rsBattleSceneSetRoles
        lda #$0000
        sta bBattleSceneCameraXFraction
        lda #$0040
        sta wBattleSceneCameraX
        sep #$20
        lda #$80
        sta bBattleSceneAttackerSide,b
        rep #$20

        _8A6A
        jsl rlBattleSceneGetCombatantGap
        lda wR0
        cmp #$00C0
        bcs _8A93
        lda wR0
        lsr a
        pha
        lda #$0100
        clc
        adc #1,s
        sta wBattleAnimationX,b
        lda #$0100
        sec
        sbc #1,s
        sta wBattleAnimation2X,b
        pla
        lda #$0080
        sta wBattleSceneCameraX

        _8A93
        lda aBattleSceneCombatant1.Character,b
        cmp #$0000
        beq _8AA2
        ldx #$0000
        jsl rlBattleSceneQueueIdleAction

        _8AA2
        lda aBattleSceneCombatant2.Character,b
        cmp #$0000
        beq _8AB1
        ldx #$0043
        jsl rlBattleSceneQueueIdleAction

        _8AB1
        jsl rlBattleSceneApplyPlacement
        plx
        rts

        .databank 0

        ; 95/8AB7

      rlBattleSceneSetFramePointers ; 95/8AB7

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the combatant's frames ID (aBattleAnimationFrameIndices); sets the frame data pointers.

        pha
        phx
        inc a
        and #$00FF
        tax
        lda aBattleAnimationFrameIndices,x
        and #$00FF
        asl a
        pha
        asl a
        clc
        adc #1,s
        clc
        adc #$0060
        tax
        pla
        lda aBattleAnimationFrameIndices,x
        sta lBattleAnimationSpawnFrameDataPointer,b
        lda aBattleAnimationFrameIndices+1,x
        sta lBattleAnimationSpawnFrameDataPointer+1,b
        lda aBattleAnimationFrameIndices+3,x
        sta lBattleAnimationSpawnSecondaryPointer2,b
        lda aBattleAnimationFrameIndices+4,x
        sta lBattleAnimationSpawnSecondaryPointer2+1,b
        plx
        pla
        rtl

        .databank 0

        ; 95/8AF0

      rlBattleSceneClearCombatants ; 95/8AF0

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the state flags of all four battle animation slots.

        ldy #$0004
        ldx #$0000

        _8AF6
        sep #$20
        stz bBattleAnimationStateFlags,b,x
        rep #$20
        txa
        clc
        adc #$0043
        tax
        dec y
        bne _8AF6
        rtl

        .databank 0

        ; 95/8B07

    .endsection BattleSceneGetGenderSection


    .section BattleSceneSetWaterFlagsSection

      .al
      .xl

      rsBattleSceneSetWaterFlags ; 95/8CB9

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the terrain shown: sea sets bit $10 of wBattleSceneFlags, river (and the unused swamp) bit $20.

        pha
        cmp #$0005
        beq _8CCB
        cmp #$0006
        beq _8CD8
        cmp #$0010
        beq _8CD8
        bra _8CE3


        _8CCB
        lda wBattleSceneFlags
        ora #BattleSceneFlagSea
        sta wBattleSceneFlags
        bra _8CE3


        _8CD8
        lda wBattleSceneFlags
        ora #BattleSceneFlagRiver
        sta wBattleSceneFlags

        _8CE3
        pla
        rts

        .databank 0

        ; 95/8CE5

      rsBattleSceneLoadBackgroundLayer ; 95/8CE5

        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses the background's tiles and tilemap (rlGetBattleBackgroundPointers) to VRAM and copies its colors to BG palettes 1-2.

        phx
        phy
        sec
        jsl rlGetBattleBackgroundPointers
        lda lR18
        sta lR45
        lda lR18+1
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        jsl rlDecompressSingle
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $6000, $80, $0000

        lda lR19
        sta lR45
        lda lR19+1
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$8000
        sta lR47
        jsl rlDecompressSingle
        jsl rlDMAByStruct

          .structDMAToVRAM $7F8000, $1000, $80, $C000

        ldy #$0000

        _8D35
        lda [lR20],y
        sta $0162,b,y
        inc y
        inc y
        cpy #$005E
        bcc _8D35
        lda #$0000
        sta $027E,b
        sta $02FE,b
        ply
        plx
        rts

        .databank 0

        ; 95/8D4D

      rlGetBattleBackgroundPointers ; 95/8D4D

        .al
        .xl
        .autsiz
        .databank ?

        ; A = terrain type: lR18 graphics, lR19 tilemap and lR20 palette of its battle
        ; background, from the tables at $98/A9F0 and $98/A900.

        phx
        php
        pha
        lda wBattleType
        and #$00FF
        cmp #$0002
        bne _8D62
        ldx #$00E6
        pla
        bra _8D8B


        _8D62
        pla
        and #$00FF
        cmp #$001A
        bcc _8D6E
        lda #$0000

        _8D6E
        tax
        jsl rlBattleSceneCheckChapter4
        bcc _8D7B
        txa
        clc
        adc #$001A
        tax

        _8D7B
        lda aBattleBackgroundTerrainIndices,x
        and #$00FF
        asl a
        pha
        asl a
        asl a
        clc
        adc #1,s
        tax
        pla

        _8D8B
        lda aBattleBackgrounds,x
        sta lR18
        lda aBattleBackgrounds+1,x
        sta lR18+1
        lda aBattleBackgrounds+3,x
        sta lR19
        lda aBattleBackgrounds+4,x
        sta lR19+1
        lda aBattleBackgrounds+6,x
        sta lR20
        lda aBattleBackgrounds+7,x
        sta lR20+1
        plp
        bcc _8DD9
        lda aBattleBackgrounds+9,x
        bit #$0001
        beq _8DCB
        sep #$20
        lda bBattleSceneBackgroundFlags
        ora #$01
        sta bBattleSceneBackgroundFlags
        rep #$20
        bra _8DD9


        _8DCB
        sep #$20
        lda bBattleSceneBackgroundFlags
        and #$FE
        sta bBattleSceneBackgroundFlags
        rep #$20

        _8DD9
        plx
        rtl

        .databank 0

        ; 95/8DDB

      rsBattleSceneLoadForeground ; 95/8DDB

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads the foreground layers for the two terrains (rsBattleSceneGetForeground), or blank ones; switches BG1 on or off to match.

        phx
        phy
        jsr rsBattleSceneGetForeground
        bcc _8E0C
        sep #$20
        lda bBattleSceneBackgroundFlags
        and #$FD
        sta bBattleSceneBackgroundFlags
        rep #$20
        sep #$20
        lda bBufferTM
        and #$FE
        sta bBufferTM
        sta $212C,b
        rep #$20
        lda $7FE1F2
        and #$FEFE
        sta $7FE1F2
        jml _8FEE


        _8E0C
        pha
        and #$00FF
        dec a
        asl a
        asl a
        pha
        asl a
        clc
        adc #1,s
        tax
        pla
        lda #1,s
        and #$00FF
        cmp #$0000
        bne _8E4C
        jsr rsBattleSceneClearTileBuffer
        phx
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $1000, $80, $5000

        plx
        jsr rsBattleSceneFillTilemapBuffer
        phx
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $0800, $80, $7800

        plx
        jml _8F18


        _8E4C
        sep #$20
        lda bBattleSceneBackgroundFlags
        ora #$02
        sta bBattleSceneBackgroundFlags
        rep #$20
        sep #$20
        lda bBufferTM
        ora #$01
        sta bBufferTM
        sta $212C,b
        rep #$20
        lda $7FE1F2
        ora #$0101
        sta $7FE1F2
        lda #1,s
        and #$00FF
        cmp #$0003
        beq _8E81
        cmp #$0006
        bne _8EAB

        _8E81
        lda aBattleForegrounds,x
        sta lR45
        lda aBattleForegrounds+1,x
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        phx
        jsl rlDecompressSingle
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $2000, $80, $4000

        bra _8ED3


        _8EAB
        lda aBattleForegrounds,x
        sta lR45
        lda aBattleForegrounds+1,x
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        phx
        jsl rlDecompressSingle
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $1000, $80, $5000


        _8ED3
        plx
        lda aBattleForegrounds+6,x
        sta lR45
        lda aBattleForegrounds+7,x
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        phx
        jsl rlDecompressSingle
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $0800, $80, $7800

        plx
        lda aBattleForegrounds+9,x
        sta lR18
        lda aBattleForegrounds+10,x
        sta lR18+1
        ldy #$0000

        _8F0C
        lda [lR18],y
        sta aBGPaletteBuffer.aPalette2,b,y
        inc y
        inc y
        cpy #$0020
        bcc _8F0C

        _8F18
        pla
        xba
        and #$00FF
        pha
        dec a
        asl a
        asl a
        pha
        asl a
        clc
        adc #1,s
        tax
        pla
        pla
        cmp #$0000
        bne _8F51
        jsr rsBattleSceneClearTileBuffer
        phx
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $1000, $80, $4000

        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $0800, $80, $7000

        plx
        jml _8FEE


        _8F51
        cmp #$0003
        beq _8FAA
        cmp #$0006
        beq _8FAA
        sep #$20
        lda bBattleSceneBackgroundFlags
        ora #$02
        sta bBattleSceneBackgroundFlags
        rep #$20
        sep #$20
        lda bBufferTM
        ora #$01
        sta bBufferTM
        sta $212C,b
        rep #$20
        lda $7FE1F2
        ora #$0101
        sta $7FE1F2
        lda aBattleForegrounds,x
        sta lR45
        lda aBattleForegrounds+1,x
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        phx
        jsl rlDecompressSingle
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $1000, $80, $4000

        plx

        _8FAA
        lda aBattleForegrounds+3,x
        sta lR45
        lda aBattleForegrounds+4,x
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        phx
        jsl rlDecompressSingle
        jsl rlDMAByStruct

          .structDMAToVRAM $7F0000, $0800, $80, $7000

        plx
        lda aBattleForegrounds+9,x
        sta lR18
        lda aBattleForegrounds+10,x
        sta lR18+1
        ldy #$0000

        _8FE2
        lda [lR18],y
        sta aBGPaletteBuffer.aPalette1,b,y
        inc y
        inc y
        cpy #$0020
        bcc _8FE2

        _8FEE
        ply
        plx
        rts

        .databank 0

        ; 95/8FF1

      rsBattleSceneClearTileBuffer ; 95/8FF1

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        lda #$0000
        ldx #$0000

        _8FF9
        sta $7F0000,x
        inc x
        inc x
        cpx #$1000
        bcc _8FF9
        plx
        pla
        rts

        .databank 0

        ; 95/9007

      rsBattleSceneFillTilemapBuffer ; 95/9007

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        lda #$0080
        ldx #$0000

        _900F
        sta $7F0000,x
        inc x
        inc x
        cpx #$0800
        bcc _900F
        plx
        pla
        rts

        .databank 0

        ; 95/901D

      rsBattleSceneGetForeground ; 95/901D

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the foreground pair for the attacker's and defender's terrains from aBattleForegroundTerrainPairs ($FE matches any; chapter 4 uses the second set, terrain + $1A); carry set for none.

        phx
        jsr rsBattleSceneCheckNoForeground
        bcs _9081
        lda aActionStructUnit1.TerrainType
        and #$00FF
        sta wR0
        lda aActionStructUnit2.TerrainType
        and #$00FF
        sta wR1
        jsl rlBattleSceneCheckChapter4
        bcc _904B
        lda wR0
        clc
        adc #$001A
        sta wR0
        lda wR1
        clc
        adc #$001A
        sta wR1

        _904B
        ldx #$0000

        _904E
        lda aBattleForegroundTerrainPairs,x
        and #$00FF
        cmp #$00FF
        beq _9080
        cmp #$00FE
        beq _9063
        cmp wR0
        bne _9073

        _9063
        lda aBattleForegroundTerrainPairs+1,x
        and #$00FF
        cmp #$00FE
        beq _9079
        cmp wR1
        beq _9079

        _9073
        inc x
        inc x
        inc x
        inc x
        bra _904E


        _9079
        lda aBattleForegroundTerrainPairs+2,x
        clc
        bra _9081


        _9080
        sec

        _9081
        plx
        rts

        .databank 0

        ; 95/9083

      rsBattleSceneCheckNoForeground ; 95/9083

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set in battle type 2, or when either combatant's weapon is in aBattleSceneNoForegroundList (bows and the tomes and staves).

        phx
        lda wBattleSceneFlags
        bit #BattleSceneFlagBattleType2
        bne _90B4
        lda aBattleSceneCombatant1.Weapon,b
        sta wR0
        lda aBattleSceneCombatant2.Weapon,b
        sta wR1
        ldx #$0000

        _909A
        lda aBattleSceneNoForegroundList,x
        and #$00FF
        cmp #$00FF
        beq _90B1
        cmp wR0
        beq _90B4
        cmp wR1
        beq _90B4
        inc x
        bra _909A


        _90B1
        clc
        bra _90B5


        _90B4
        sec

        _90B5
        plx
        rts

        .databank 0

        ; 95/90B7

      rlBattleSceneCheckChapter4 ; 95/90B7

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set in chapter 4 (wCurrentChapter 4).

        pha
        lda wCurrentChapter,b
        cmp #$0004
        beq _90C3
        clc
        bra _90C4


        _90C3
        sec

        _90C4
        pla
        rtl

        .databank 0

        ; 95/90C6

      rsBattleSceneCopyTileList ; 95/90C6

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies a list of 32-byte tiles from lR18 into WRAM at lR19 plus each entry's offset: a count word, then per tile an offset word and the 32 bytes.

        lda lR19+1
        sta $2182,b
        ldy #$0000
        lda [lR18],y
        inc y
        inc y

        _90D2
        pha
        lda [lR18],y
        clc
        adc lR19
        sta $2181,b
        inc y
        inc y
        sep #$20
        ldx #$0020

        _90E2
        lda [lR18],y
        sta $2180,b
        inc y
        dec x
        bne _90E2
        rep #$20
        pla
        dec a
        bne _90D2
        rts

        .databank 0

        ; 95/90F2

    .endsection BattleSceneSetWaterFlagsSection


    .section BattleSceneLoadCharacterColorsSection

      .al
      .xl

      rlBattleSceneLoadCharacterColors ; 95/A167

        .al
        .xl
        .autsiz
        .databank ?

        ; A = character, carry set for combatant 2: a character listed in aBattleSceneCharacterColorIndices gets three colors of aBattleSceneCharacterColors written over colors 12-14 of its sprite palette (OAM palette 0, or 4 for combatant 2).

        phx
        phy
        php
        pha
        ldx #$0000

        _A16E
        lda aBattleSceneCharacterColorIndices,x
        cmp #$FFFF
        beq _A1C1
        cmp #1,s
        beq _A180
        inc x
        inc x
        inc x
        bra _A16E


        _A180
        pla
        lda aBattleSceneCharacterColorIndices+2,x
        and #$00FF
        asl a
        pha
        asl a
        clc
        adc #1,s
        tax
        pla
        plp
        bcs _A1AA
        lda aBattleSceneCharacterColors,x
        sta $0218,b
        lda aBattleSceneCharacterColors+2,x
        sta $021A,b
        lda aBattleSceneCharacterColors+4,x
        sta $021C,b
        bra _A1C3


        _A1AA
        lda aBattleSceneCharacterColors,x
        sta $0298,b
        lda aBattleSceneCharacterColors+2,x
        sta $029A,b
        lda aBattleSceneCharacterColors+4,x
        sta $029C,b
        bra _A1C3


        _A1C1
        pla
        plp

        _A1C3
        ply
        plx
        rtl

        .databank 0

        ; 95/A1C6

      rlBattleSceneSetAnimStyles ; 95/A1C6

        .al
        .xl
        .autsiz
        .databank ?

        ; Each combatant's AnimStyle from its weapon (rlBattleSceneGetWeaponAnimStyle); $90 (AnimCategoryAny, sword style) when it has none.

        lda aBattleSceneCombatant1.Weapon,b
        jsl rlBattleSceneGetWeaponAnimStyle
        bcc _A1D2
        lda #$0090

        _A1D2
        sep #$20
        sta aBattleSceneCombatant1.AnimStyle,b
        rep #$20
        lda aBattleSceneCombatant2.Weapon,b
        jsl rlBattleSceneGetWeaponAnimStyle
        bcc _A1E5
        lda #$0090

        _A1E5
        sep #$20
        sta aBattleSceneCombatant2.AnimStyle,b
        rep #$20
        rtl

        .databank 0

        ; 95/A1ED

      rlBattleSceneGetWeaponAnimStyle ; 95/A1ED

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        ; A = item ID: its byte of aItemAnimationCategories, carry clear (carry set for no item or an unlisted one). A javelin or hand axe (the ranged categories) at wBattleDistance 2 or more gets attack style AttackStyleRanged; closer, it becomes the plain lance or axe category.

        phx
        inc a
        cmp #$007F
        bcs _A244
        tax
        lda aItemAnimationCategories,x
        and #$00FF
        cmp #$00FF
        beq _A244
        pha
        and #$00F0
        cmp #$0040
        beq _A214
        cmp #$0050
        beq _A214
        cmp #$0060
        bne _A240

        _A214
        lda @l $000D48
        and #$00FF
        cmp #$0002
        bcc _A22C
        lda #1,s
        and #$00F0
        ora #$0004
        sta #1,s
        bra _A240


        _A22C
        lda #1,s
        and #$000F
        pha
        lda #3,s
        and #$00F0
        sec
        sbc #$0040
        ora #1,s
        sta #3,s
        pla

        _A240
        pla
        clc
        bra _A245


        _A244
        sec

        _A245
        plx
        rtl

        .databank 0

        ; 95/A247

      rlBattleSceneLookUpAnimations ; 95/A247

        .al
        .xl
        .autsiz
        .databank ?

        ; The four animation IDs of each combatant ($7FE1B6-$7FE1B9, then copied to $7FE1BA-$7FE1BD for combatant 2) from its class, category, character and gender (rlBattleAnimationLookUp). A combatant with no record of its weapon category gets AnimCategoryAny.

        sep #$20
        lda aBattleSceneCombatant2.Class,b
        sta $7FE1B6
        lda aBattleSceneCombatant2.AnimStyle,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $7FE1B7
        lda aBattleSceneCombatant2.Character,b
        sta $7FE1B8
        lda aBattleSceneCombatant2.Gender,b
        sta $7FE1B9
        rep #$20
        jsl rlBattleAnimationLookUp
        bcc _A27F
        sep #$20
        lda aBattleSceneCombatant2.AnimStyle,b
        and #$0F
        ora #$90
        sta aBattleSceneCombatant2.AnimStyle,b
        rep #$20

        _A27F
        lda $7FE1B6
        sta $7FE1BA
        lda $7FE1B8
        sta $7FE1BC
        sep #$20
        lda aBattleSceneCombatant1.Class,b
        sta $7FE1B6
        lda aBattleSceneCombatant1.AnimStyle,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $7FE1B7
        lda aBattleSceneCombatant1.Character,b
        sta $7FE1B8
        lda aBattleSceneCombatant1.Gender,b
        sta $7FE1B9
        rep #$20
        jsl rlBattleAnimationLookUp
        bcc _A2C7
        sep #$20
        lda aBattleSceneCombatant1.AnimStyle,b
        and #$0F
        ora #$90
        sta aBattleSceneCombatant1.AnimStyle,b
        rep #$20

        _A2C7
        rtl

        .databank 0

        ; 95/A2C8

      rlBattleAnimationLookUp ; 95/A2C8

        .al
        .xl
        .autsiz
        .databank ?

        ; $7FE1B6-$7FE1B9 = class, category, character, gender in; the four IDs out. Takes the first record of aBattleAnimationLookup that matches class, gender, character (AnimAnyCharacter matches any) and category (AnimCategoryAny matches any); carry clear on a full match. Carry set otherwise, with the last record of the class that matched furthest (or the first record when the class has none). The dance replaces it all (rlBattleAnimationCheckDance).

        phx
        phy
        jsl rlBattleAnimationCheckDance
        bcc _A2D5
        clc
        jml _A3BC


        _A2D5
        sep #$20
        ldx #$0000
        ldy #$0000

        _A2DD
        lda $7FE1B6
        cmp aBattleAnimationLookup+structBattleAnimationLookupEntry.Class,x
        beq _A2F2
        cpy #$0001
        bcc _A2F0
        jml _A378


        _A2F0
        bra _A344


        _A2F2
        cpy #$0001
        bcs _A2FA
        ldy #$0001

        _A2FA
        lda $7FE1B9
        cmp aBattleAnimationLookup+structBattleAnimationLookupEntry.Gender,x
        beq _A30B
        cpy #$0002
        bcs _A378
        bra _A344


        _A30B
        cpy #$0002
        bcs _A313
        ldy #$0002

        _A313
        lda aBattleAnimationLookup+structBattleAnimationLookupEntry.Character,x
        cmp #$00
        beq _A32C
        lda $7FE1B8
        cmp aBattleAnimationLookup+structBattleAnimationLookupEntry.Character,x
        beq _A32C
        cpy #$0003
        bcs _A378
        bra _A344


        _A32C
        cpy #$0003
        bcs _A334
        ldy #$0003

        _A334
        lda $7FE1B7
        cmp #$09
        beq _A355
        cmp aBattleAnimationLookup+structBattleAnimationLookupEntry.Category,x
        bne _A344
        bra _A355


        _A344
        rep #$20
        txa
        clc
        adc #$0008
        tax
        sep #$20
        cpx #$0670
        bcc _A2DD
        bra _A39B


        _A355
        lda aBattleAnimationLookup+structBattleAnimationLookupEntry.Frames,x
        sta $7FE1B6
        lda aBattleAnimationLookup+structBattleAnimationLookupEntry.Sheet,x
        sta $7FE1B7
        lda aBattleAnimationLookup+structBattleAnimationLookupEntry.Extras,x
        sta $7FE1B8
        lda aBattleAnimationLookup+structBattleAnimationLookupEntry.Palette,x
        sta $7FE1B9
        clc
        bra _A3BC


        _A378
        lda aBattleAnimationLookup-size(structBattleAnimationLookupEntry)+structBattleAnimationLookupEntry.Frames,x
        sta $7FE1B6
        lda aBattleAnimationLookup-size(structBattleAnimationLookupEntry)+structBattleAnimationLookupEntry.Sheet,x
        sta $7FE1B7
        lda aBattleAnimationLookup-size(structBattleAnimationLookupEntry)+structBattleAnimationLookupEntry.Extras,x
        sta $7FE1B8
        lda aBattleAnimationLookup-size(structBattleAnimationLookupEntry)+structBattleAnimationLookupEntry.Palette,x
        sta $7FE1B9
        sec
        bra _A3BC


        _A39B
        lda aBattleAnimationLookup+structBattleAnimationLookupEntry.Frames
        sta $7FE1B6
        lda aBattleAnimationLookup+structBattleAnimationLookupEntry.Sheet
        sta $7FE1B7
        lda aBattleAnimationLookup+structBattleAnimationLookupEntry.Extras
        sta $7FE1B8
        lda aBattleAnimationLookup+structBattleAnimationLookupEntry.Palette
        sta $7FE1B9
        sec

        _A3BC
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 95/A3C1

      rlBattleAnimationCheckDance ; 95/A3C1

        .al
        .xl
        .autsiz
        .databank ?

        ; A Dancer (class $32) in the dance scene (BattleSceneFlagDance): the dance's animation IDs ($5E, $66, $46, $2E) and carry set; carry clear otherwise.

        phx
        phy
        lda $7FE1B6
        and #$00FF
        cmp #$0032
        bne _A3D8
        lda wBattleSceneFlags
        bit #BattleSceneFlagDance
        bne _A3DB

        _A3D8
        clc
        bra _A3F8


        _A3DB
        sep #$20
        lda #$5E
        sta $7FE1B6
        lda #$66
        sta $7FE1B7
        lda #$46
        sta $7FE1B8
        lda #$2E
        sta $7FE1B9
        rep #$20
        sec

        _A3F8
        ply
        plx
        rtl

        .databank 0

        ; 95/A3FB

    .endsection BattleSceneLoadCharacterColorsSection


    .section BattleSceneApplyPlacementSection

      .al
      .xl

      rlBattleSceneApplyPlacement ; 96/9665

        .al
        .xl
        .autsiz
        .databank ?

        ; Places the combatants by the first striker's weapon (rlBattleSceneGetWeaponPlacement): runs the mode's routine of aBattleScenePlacements with Y = the other combatant. Battle type 2 always uses mode 3.

        phx
        phy
        lda wBattleSceneFlags
        bit #BattleSceneFlagBattleType2
        beq _9677
        lda #$0003
        sta wR0
        bra _9693


        _9677
        jsl rlBattleSceneGetFirstStriker
        bcs _9685
        ldx #$0043
        lda aBattleSceneCombatant1.Weapon,b
        bra _968B


        _9685
        ldx #$0000
        lda aBattleSceneCombatant2.Weapon,b

        _968B
        jsl rlBattleSceneGetWeaponPlacement
        bcs _969D
        sta wR0

        _9693
        txy
        phx
        lda wR0
        asl a
        tax
        jsr (aBattleScenePlacements,x)
        plx

        _969D
        ply
        plx
        rtl

        .databank 0

        ; 96/96A0

    .endsection BattleSceneApplyPlacementSection


    .section BattleScenePlacementsSection

      .al
      .xl

      aBattleScenePlacements ; 96/96A0

        ; Jump table of rlBattleSceneApplyPlacement.
        .word <>rsBattleScenePlaceStrikerAlone
        .word <>rsBattleScenePlaceTogether
        .word <>rsBattleSceneHideOther
        .word <>rsBattleScenePlaceTogetherOnGround
        .word <>rsBattleScenePlaceNone

    .endsection BattleScenePlacementsSection


    .section BattleSceneGetWeaponPlacementSection

      .al
      .xl

      rlBattleSceneGetWeaponPlacement ; 96/96AA

        .al
        .xl
        .autsiz
        .databank ?

        ; A = item ID: its placement mode from aBattleSceneWeaponPlacements (the second at wBattleDistance 3 or more), carry clear; carry set for a weapon not listed or mode $FF.

        phx
        pha
        ldx #$0000

        _96AF
        lda aBattleSceneWeaponPlacements,x
        inc x
        inc x
        inc x
        cmp #$FFFF
        beq _96E2
        and #$00FF
        cmp #1,s
        bne _96AF
        lda wBattleDistance
        cmp #$0003
        bcs _96D1
        lda aBattleSceneWeaponPlacements+1-3,x
        bra _96D5


        _96D1
        lda aBattleSceneWeaponPlacements+2-3,x

        _96D5
        and #$00FF
        cmp #$00FF
        beq _96E2
        sta #1,s
        clc
        bra _96E3


        _96E2
        sec

        _96E3
        pla
        plx
        rtl

        .databank 0

        ; 96/96E6

    .endsection BattleSceneGetWeaponPlacementSection


    .section BattleScenePlaceStrikerAloneSection

      .al
      .xl

      rsBattleScenePlaceStrikerAlone ; 96/96E6

        .al
        .xl
        .autsiz
        .databank ?

        ; Mode 0 (long range tomes, ballistae, staves from afar): hides the other combatant and puts both at the center ($100, $FF), the camera at $80.

        tyx
        sep #$20
        lda bBattleAnimationCombatantFlags,b,x
        ora #$40
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        lda #$0100
        sta wBattleAnimationX,b
        lda #$00FF
        sta wBattleAnimation2X,b
        lda #$0080
        sta wBattleSceneCameraX
        rts

        .databank 0

        ; 96/9707

    .endsection BattleScenePlaceStrikerAloneSection


    .section BattleScenePlaceTogetherSection

      .al
      .xl

      rsBattleScenePlaceTogether ; 96/9707

        .al
        .xl
        .autsiz
        .databank ?

        ; Mode 1 (Fortify): both at the center, the camera at $80, and BattleSceneFlagSolo2.

        tyx
        lda #$0100
        sta wBattleAnimationX,b
        lda #$00FF
        sta wBattleAnimation2X,b
        lda #$0080
        sta wBattleSceneCameraX
        lda wBattleSceneFlags
        ora #BattleSceneFlagSolo2
        sta wBattleSceneFlags
        rts

        .databank 0

        ; 96/9727

    .endsection BattleScenePlaceTogetherSection


    .section BattleSceneHideOtherSection

      .al
      .xl

      rsBattleSceneHideOther ; 96/9727

        .al
        .xl
        .autsiz
        .databank ?

        ; Mode 2 (Rescue, Valkyrie): hides the other combatant.

        tyx
        sep #$20
        lda bBattleAnimationCombatantFlags,b,x
        ora #$40
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        rts

        .databank 0

        ; 96/9735

    .endsection BattleSceneHideOtherSection


    .section BattleScenePlaceTogetherOnGroundSection

      .al
      .xl

      rsBattleScenePlaceTogetherOnGround ; 96/9735

        .al
        .xl
        .autsiz
        .databank ?

        ; Mode 3 (battle type 2): hides the other combatant and puts both at the center on the ground (Y anchor $7000), the camera at $80.

        tyx
        sep #$20
        lda bBattleAnimationCombatantFlags,b,x
        ora #$40
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        lda #$0100
        sta wBattleAnimationX,b
        sta wBattleAnimation2X,b
        lda #$0000
        sta bBattleAnimationY,b
        sta bBattleAnimation2Y,b
        lda #$7000
        sta wBattleAnimationYAnchor,b
        sta wBattleAnimation2YAnchor,b
        lda #$0080
        sta wBattleSceneCameraX
        rts

        .databank 0

        ; 96/9765

    .endsection BattleScenePlaceTogetherOnGroundSection


    .section BattleScenePlaceNoneSection

      .al
      .xl

      rsBattleScenePlaceNone ; 96/9765

        .al
        .xl
        .autsiz
        .databank ?

        ; Mode 4 (magic and status swords): nothing.

        rts

        .databank 0

        ; 96/9766

    .endsection BattleScenePlaceNoneSection


    .section Unreferenced969766Section

      .al
      .xl

      rlBattleSceneHideCombatant ; 96/9766

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Found by tools/sweep.py. Hides combatant X (bit 6 of bBattleAnimationCombatantFlags).

        sep #$20
        lda bBattleAnimationCombatantFlags,b,x
        ora #$40
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        rtl

        .databank 0

        ; 96/9773

      rlBattleSceneScriptHideAttacker ; 96/9773

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Found by tools/sweep.py. Script routine: hides the attacker.

        phx
        phy
        ldx wBattleAnimationAttackerOffset,b
        jsl rlBattleSceneHideCombatant
        jsl rlBattleSceneEndScriptRoutine
        ply
        plx
        rtl

        .databank 0

        ; 96/9783

      rlBattleSceneShowOtherCombatant ; 96/9783

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Found by tools/sweep.py. Shows the combatant other than X.

        phx
        cpx #$0000
        bne _978E
        ldx #$0043
        bra _9791


        _978E
        ldx #$0000

        _9791
        sep #$20
        lda bBattleAnimationCombatantFlags,b,x
        and #$BF
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/979F

      rlBattleSceneScriptShowDefender ; 96/979F

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Found by tools/sweep.py. Script routine: shows the defender.

        phx
        phy
        ldx wBattleAnimationAttackerOffset,b
        jsl rlBattleSceneShowOtherCombatant
        jsl rlBattleSceneEndScriptRoutine
        ply
        plx
        rtl

        .databank 0

        ; 96/97AF

      rlBattleSceneHideOtherCombatant ; 96/97AF

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Found by tools/sweep.py. Hides the combatant other than X.

        phx
        cpx #$0000
        bne _97BA
        ldx #$0043
        bra _97BD


        _97BA
        ldx #$0000

        _97BD
        sep #$20
        lda bBattleAnimationCombatantFlags,b,x
        ora #$40
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/97CB

      rlBattleSceneScriptHideDefender ; 96/97CB

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Found by tools/sweep.py. Script routine: hides the defender.

        phx
        phy
        ldx wBattleAnimationAttackerOffset,b
        jsl rlBattleSceneHideOtherCombatant
        jsl rlBattleSceneEndScriptRoutine
        ply
        plx
        rtl

        .databank 0

        ; 96/97DB

      rlBattleSceneShowCombatant ; 96/97DB

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Found by tools/sweep.py. Shows combatant X.

        phx
        sep #$20
        lda bBattleAnimationCombatantFlags,b,x
        and #$BF
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/97EA

      rlBattleSceneScriptShowAttacker ; 96/97EA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Found by tools/sweep.py. Script routine: shows the attacker.

        phx
        phy
        ldx wBattleAnimationAttackerOffset,b
        jsl rlBattleSceneShowCombatant
        jsl rlBattleSceneEndScriptRoutine
        ply
        plx
        rtl

        .databank 0

        ; 96/97FA

    .endsection Unreferenced969766Section
    .section BattleSceneGetFirstStrikerSection

      .al
      .xl

      rlBattleSceneGetFirstStriker ; 96/97FA

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry = bit 0 of the first strike in aBattleRoundsData (skipping skill entries): set when combatant 2 strikes first. Carry clear when there is none.

        phx
        ldx #$0000

        _97FE
        lda $7E4F85,x
        cmp #$FFFF
        beq _981A
        cmp #$FEFF
        beq _981A
        bit #$0080
        beq _9815
        inc x
        inc x
        bra _97FE


        _9815
        bit #$0001
        bne _981D

        _981A
        clc
        bra _981E


        _981D
        sec

        _981E
        plx
        rtl

        .databank 0

        ; 96/9820

      rlBattleSceneCheckSwordAtRange ; 96/9820

        .al
        .xl
        .autsiz
        .databank ?

        ; X = 0 or $43: carry set when the combatant's weapon has placement mode 4 (a magic or status sword) and wBattleDistance is 2 or more.

        phx
        phy
        cpx #$0000
        bne _982C
        lda aBattleSceneCombatant1.Weapon,b
        bra _982F


        _982C
        lda aBattleSceneCombatant2.Weapon,b

        _982F
        jsl rlBattleSceneGetWeaponPlacement
        bcs _9846
        cmp #$0004
        bne _9846
        lda wBattleDistance
        cmp #$0002
        bcc _9846
        sec
        bra _9847


        _9846
        clc

        _9847
        ply
        plx
        rtl

        .databank 0

        ; 96/984A

      rlBattleSceneResetArenaBreak ; 96/984A

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears bBattleSceneArenaBout and bBattleSceneArenaInput (the break between arena bouts) and BattleSceneRoundArenaNextBout.

        sep #$20
        lda #$00
        sta bBattleSceneArenaBout
        sta bBattleSceneArenaInput
        lda bBattleSceneRoundState,b
        and #$EF
        sta bBattleSceneRoundState,b
        rep #$20
        rtl

        .databank 0

        ; 96/9861

    .endsection BattleSceneGetFirstStrikerSection


