; Map battle magic: the background layer drawn behind a map battle for each
; tome and staff, and the sprites drawn over it. The map battle code (bank $9E) stores WeaponID - $3E (Fire
; is $3E) for each side, and rlUnknown9F84DD, rlUnknown9F850B and
; rlUnknown9F8575 (bank $9F) load the acting side's entry.

    .section MapBattleMagicBackgroundsSection

      .al
      .xl

      aMapBattleMagicBackgrounds ; 9F/80D9

        ; One entry per item from Fire to BrokenStaffA, each three compressed
        ; streams: 4bpp tiles (to aDecompressionBuffer+$4000), a 32x32
        ; tilemap (to $7EDB88) and 256 colours (to $7EE388). Streams shared by
        ; several items are named after the first. Meteor and Valflame also
        ; have a second tilemap (acMapBattleMagicMeteorTilemap2,
        ; acMapBattleMagicValflameTilemap2), which rlUnknown9F850B picks by
        ; $7F509B.

        .long g4bppcMapBattleMagicFire, acMapBattleMagicFireTilemap, acMapBattleMagicFirePalette ; Fire
        .long g4bppcMapBattleMagicFire, acMapBattleMagicFireTilemap, acMapBattleMagicFirePalette ; Elfire
        .long g4bppcMapBattleMagicBolganone, acMapBattleMagicBolganoneTilemap, acMapBattleMagicBolganonePalette ; Bolganone
        .long g4bppcMapBattleMagicValflame, acMapBattleMagicValflameTilemap, acMapBattleMagicValflamePalette ; Valflame
        .long g4bppcMapBattleMagicMeteor, acMapBattleMagicMeteorTilemap, acMapBattleMagicMeteorPalette ; Meteor
        .long g4bppcMapBattleMagicThunder, acMapBattleMagicThunderTilemap, acMapBattleMagicThunderPalette ; Thunder
        .long g4bppcMapBattleMagicThunder, acMapBattleMagicThunderTilemap, acMapBattleMagicThunderPalette ; Elthunder
        .long g4bppcMapBattleMagicThoron, acMapBattleMagicThoronTilemap, acMapBattleMagicThoronPalette ; Thoron
        .long g4bppcMapBattleMagicMjolnir, acMapBattleMagicMjolnirTilemap, acMapBattleMagicMjolnirPalette ; Mjolnir
        .long g4bppcMapBattleMagicThunder, acMapBattleMagicThunderTilemap, acMapBattleMagicThunderPalette ; Bolting
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; Wind
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; Elwind
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; Tornado
        .long g4bppcMapBattleMagicForseti, acMapBattleMagicForsetiTilemap, acMapBattleMagicForsetiPalette ; Forseti
        .long g4bppcMapBattleMagicBlizzard, acMapBattleMagicBlizzardTilemap, acMapBattleMagicBlizzardPalette ; Blizzard
        .long g4bppcMapBattleMagicLight, acMapBattleMagicLightTilemap, acMapBattleMagicLightPalette ; Light
        .long g4bppcMapBattleMagicNosferatu, acMapBattleMagicNosferatuTilemap, acMapBattleMagicNosferatuPalette ; Nosferatu
        .long g4bppcMapBattleMagicAura, acMapBattleMagicAuraTilemap, acMapBattleMagicAuraPalette ; Aura
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; Naga
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; Jormungandr
        .long g4bppcMapBattleMagicFenrir, acMapBattleMagicFenrirTilemap, acMapBattleMagicFenrirPalette ; Fenrir
        .long g4bppcMapBattleMagicHel, acMapBattleMagicHelTilemap, acMapBattleMagicHelPalette ; Hel
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; Loptous
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; BrokenFireTomeA
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; BrokenFireTomeB
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; BrokenFireTomeC
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; HealStaff
        .long g4bppcMapBattleMagicMendStaff, acMapBattleMagicMendStaffTilemap, acMapBattleMagicWindPalette ; MendStaff
        .long g4bppcMapBattleMagicRecoverStaff, acMapBattleMagicRecoverStaffTilemap, acMapBattleMagicWindPalette ; RecoverStaff
        .long g4bppcMapBattleMagicMendStaff, acMapBattleMagicMendStaffTilemap, acMapBattleMagicWindPalette ; PhysicStaff
        .long g4bppcMapBattleMagicFortify, acMapBattleMagicFortifyTilemap, acMapBattleMagicFortifyPalette ; Fortify
        .long g4bppcMapBattleMagicReturnStaff, acMapBattleMagicReturnStaffTilemap, acMapBattleMagicReturnStaffPalette ; ReturnStaff
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; WarpStaff
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; RescueStaff
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; CharmStaff
        .long g4bppcMapBattleMagicRestoreStaff, acMapBattleMagicRestoreStaffTilemap, acMapBattleMagicRestoreStaffPalette ; RestoreStaff
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; ValkyrieStaff
        .long g4bppcMapBattleMagicSilenceStaff, acMapBattleMagicSilenceStaffTilemap, acMapBattleMagicSilenceStaffPalette ; SilenceStaff
        .long g4bppcMapBattleMagicSleepStaff, acMapBattleMagicSleepStaffTilemap, acMapBattleMagicSleepStaffPalette ; SleepStaff
        .long g4bppcMapBattleMagicBerserkStaff, acMapBattleMagicBerserkStaffTilemap, acMapBattleMagicBerserkStaffPalette ; BerserkStaff
        .long g4bppcMapBattleMagicHel, acMapBattleMagicHelTilemap, acMapBattleMagicHelPalette ; ThiefStaff
        .long g4bppcMapBattleMagicWind, acMapBattleMagicWindTilemap, acMapBattleMagicWindPalette ; BrokenStaffA

    .endsection MapBattleMagicBackgroundsSection


    .section MapBattleMagicSpritesSection

      .al
      .xl

      aMapBattleMagicSprites ; 9F/8724

        ; Read by rlUnknown9F86BF with the same index as
        ; aMapBattleMagicBackgrounds. Entries of 5 bytes: the bank $9F address
        ; of 16 colours, copied into sprite palette 6, then compressed 4bpp
        ; sprite tiles, decompressed to $7F45D9. Five $FF bytes: no sprites.
        .word <>aMapBattleMagicSpritePaletteFire
        .long g4bppcMapBattleMagicFireSprites ; Fire
        .word <>aMapBattleMagicSpritePaletteFire
        .long g4bppcMapBattleMagicElfireSprites ; Elfire
        .word <>aMapBattleMagicSpritePaletteBolganone
        .long g4bppcMapBattleMagicBolganoneSprites ; Bolganone
        .word <>aMapBattleMagicSpritePaletteFire
        .long g4bppcMapBattleMagicValflameSprites ; Valflame
        .word <>aMapBattleMagicSpritePaletteMeteor
        .long g4bppcMapBattleMagicMeteorSprites ; Meteor
        .word <>aMapBattleMagicSpritePaletteFire
        .long g4bppcMapBattleMagicThunderSprites ; Thunder
        .word <>aMapBattleMagicSpritePaletteFire
        .long g4bppcMapBattleMagicThunderSprites ; Elthunder
        .word <>aMapBattleMagicSpritePaletteFire
        .long g4bppcMapBattleMagicThoronSprites ; Thoron
        .word <>aMapBattleMagicSpritePaletteBolganone
        .long g4bppcMapBattleMagicMjolnirSprites ; Mjolnir
        .word <>aMapBattleMagicSpritePaletteFire
        .long g4bppcMapBattleMagicThunderSprites ; Bolting
        .word <>aMapBattleMagicSpritePaletteFire
        .long g4bppcMapBattleMagicWindSprites ; Wind
        .word <>aMapBattleMagicSpritePaletteFire
        .long g4bppcMapBattleMagicElwindSprites ; Elwind
        .word <>aMapBattleMagicSpritePaletteFire
        .long g4bppcMapBattleMagicTornadoSprites ; Tornado
        .byte $FF, $FF, $FF, $FF, $FF ; Forseti
        .byte $FF, $FF, $FF, $FF, $FF ; Blizzard
        .word <>aMapBattleMagicSpritePaletteLight
        .long g4bppcMapBattleMagicLightSprites ; Light
        .word <>aMapBattleMagicSpritePaletteNosferatu
        .long g4bppcMapBattleMagicNosferatuSprites ; Nosferatu
        .byte $FF, $FF, $FF, $FF, $FF ; Aura
        .byte $FF, $FF, $FF, $FF, $FF ; Naga
        .word <>aMapBattleMagicSpritePaletteBolganone
        .long g4bppcMapBattleMagicJormungandrSprites ; Jormungandr
        .word <>aMapBattleMagicSpritePaletteBolganone
        .long g4bppcMapBattleMagicFenrirSprites ; Fenrir
        .byte $FF, $FF, $FF, $FF, $FF ; Hel
        .byte $FF, $FF, $FF, $FF, $FF ; Loptous
        .byte $FF, $FF, $FF, $FF, $FF ; BrokenFireTomeA
        .byte $FF, $FF, $FF, $FF, $FF ; BrokenFireTomeB
        .byte $FF, $FF, $FF, $FF, $FF ; BrokenFireTomeC
        .byte $FF, $FF, $FF, $FF, $FF ; HealStaff
        .byte $FF, $FF, $FF, $FF, $FF ; MendStaff
        .byte $FF, $FF, $FF, $FF, $FF ; RecoverStaff
        .byte $FF, $FF, $FF, $FF, $FF ; PhysicStaff
        .byte $FF, $FF, $FF, $FF, $FF ; Fortify
        .word <>aMapBattleMagicSpritePaletteReturnStaff
        .long g4bppcMapBattleMagicReturnStaffSprites ; ReturnStaff
        .word <>aMapBattleMagicSpritePaletteFire
        .long g4bppcMapBattleMagicWarpStaffSprites ; WarpStaff
        .word <>aMapBattleMagicSpritePaletteFire
        .long g4bppcMapBattleMagicRescueStaffSprites ; RescueStaff
        .byte $FF, $FF, $FF, $FF, $FF ; CharmStaff
        .word <>aMapBattleMagicSpritePaletteReturnStaff
        .long g4bppcMapBattleMagicReturnStaffSprites ; RestoreStaff
        .byte $FF, $FF, $FF, $FF, $FF ; ValkyrieStaff
        .byte $FF, $FF, $FF, $FF, $FF ; SilenceStaff
        .word <>aMapBattleMagicSpritePaletteReturnStaff
        .long g4bppcMapBattleMagicReturnStaffSprites ; SleepStaff
        .byte $FF, $FF, $FF, $FF, $FF ; BerserkStaff
        .word <>aMapBattleMagicSpritePaletteLight
        .long g4bppcMapBattleMagicThiefStaffSprites ; ThiefStaff
        .word <>aMapBattleMagicSpritePaletteFire
        .long g4bppcMapBattleMagicWarpStaffSprites ; BrokenStaffA

    .endsection MapBattleMagicSpritesSection


    .section Unsorted87C70ASection

      .al
      .xl

      procUnknown87C70A ; 87/C70A

        .structProcInfo "RP", rlUnknown87C712, rlUnknown87C7B4, aProcUnknown87C70ACode

    .endsection Unsorted87C70ASection


    .section Unsorted87C712Section

      .al
      .xl

      rlUnknown87C712 ; 87/C712

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        lda #(`aUnknown87C784)<<8
        sta lR19+1
        lda #<>aUnknown87C784
        sta lR19
        jsl rlApplyMapMenuPaletteData
        lda #(`gcUnknownC0365A)<<8
        sta lR18+1
        lda #<>gcUnknownC0365A
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$EB88
        sta lR19
        jsl rlAppendDecompList
        stz wMapMenuClearTile,b
        lda #$2370
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown87C7AB)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown87C7AB
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlClearTilemapEntryTiles
        lda aProcSystem.aBody0,b,x
        bne _C761
        jsr rsUnknown87C821
        bra _C764


        _C761
        jsr rsUnknown87C87A

        _C764
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        lda #$0000
        sta wBufferBG2HOFS
        lda #$0000
        sta wBufferBG2VOFS
        sep #$20
        lda #$15
        sta bBufferTM
        rep #$20
        rtl

        .databank 0

        ; 87/C784

    .endsection Unsorted87C712Section


    .section Table87C784Section

      .al
      .xl

      aUnknown87C784 .dstruct structMapMenuPaletteData, $0010, 0, 0, aUnknown87C78B ; 87/C784

      aUnknown87C78B ; 87/C78B
        .word $0000, $7FFF, $6739, $41F0, $292A, $1485, $0C43, $1919
        .word $10B2, $0C49, $375F, $0000, $0000, $0000, $0000, $0000

      aUnknown87C7AB ; 87/C7AB
        .byte $20, $20, $88, $7B, $7E, $00, $88, $7B, $7E

    .endsection Table87C784Section


    .section Unsorted87C7B4Section

      .al
      .xl

      rlUnknown87C7B4 ; 87/C7B4

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne _C7CE
        phx
        jsl rlDMAByStruct

          .structDMAToVRAM $7EEB88, $0E00, $80, $7000

        plx
        lda #<>rlUnknown87C7CF
        sta aProcSystem.aHeaderOnCycle,b,x

        _C7CE
        rtl

        .databank 0

        ; 87/C7CF

      rlUnknown87C7CF ; 87/C7CF

        .al
        .xl
        .autsiz
        .databank ?

        lda #aUnknown87C91D >> 8
        sta lR44+1
        lda aProcSystem.aBody0,b,x
        bne _C7DE
        lda #<>aUnknown87C91D
        bra _C7E1


        _C7DE
        lda #<>aUnknown87CB47

        _C7E1
        sta lR44
        lda #$0001
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #<>rlUnknown87C7F3
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 87/C7F3

    .endsection Unsorted87C7B4Section


    .section Unsorted87C7F3Section

      .al
      .xl

      rlUnknown87C7F3 ; 87/C7F3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda $1611,b
        bit #$0001
        beq _C81E
        phx
        lda #(`aUnknown87C7AB)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown87C7AB
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlClearTilemapEntryTiles
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        plx
        jsl rlProcEngineFreeProc

        _C81E
        rtl

        .databank 0

        ; 87/C81F

    .endsection Unsorted87C7F3Section


    .section Unsorted87C81FSection

      .al
      .xl

      aProcUnknown87C70ACode ; 87/C81F

        PROC_HALT


        ; 87/C821

    .endsection Unsorted87C81FSection


    .section Unsorted87C821Section

      .al
      .xl

      rsUnknown87C821 ; 87/C821

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown87C866)<<8
        sta lR18+1
        lda #<>aUnknown87C866
        sta lR18
        ldx #$000F
        jsl rlDrawTileStringToTilemapEntry
        lda #(`aUnknown87C86B)<<8
        sta lR18+1
        lda #<>aUnknown87C86B
        sta lR18
        ldx #$010F
        jsl rlDrawTileStringToTilemapEntry
        lda #(`aUnknown87C870)<<8
        sta lR18+1
        lda #<>aUnknown87C870
        sta lR18
        ldx #$020F
        jsl rlDrawTileStringToTilemapEntry
        lda #(`aUnknown87C875)<<8
        sta lR18+1
        lda #<>aUnknown87C875
        sta lR18
        ldx #$030F
        jsl rlDrawTileStringToTilemapEntry
        rts

        .databank 0

        ; 87/C866

    .endsection Unsorted87C821Section


    .section Table87C866Section

      .al
      .xl

      aUnknown87C866 ; 87/C866
        .byte $10, $11, $12, $13, $00

      aUnknown87C86B ; 87/C86B
        .byte $20, $21, $22, $23, $00

      aUnknown87C870 ; 87/C870
        .byte $30, $31, $32, $33, $00

      aUnknown87C875 ; 87/C875
        .byte $40, $41, $42, $43, $00

    .endsection Table87C866Section


    .section Unsorted87C87ASection

      .al
      .xl

      rsUnknown87C87A ; 87/C87A

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown87C8E1)<<8
        sta lR18+1
        lda #<>aUnknown87C8E1
        sta lR18
        ldx #$000C
        jsl rlDrawTileStringToTilemapEntry
        lda #(`aUnknown87C8EB)<<8
        sta lR18+1
        lda #<>aUnknown87C8EB
        sta lR18
        ldx #$010C
        jsl rlDrawTileStringToTilemapEntry
        lda #(`aUnknown87C8F5)<<8
        sta lR18+1
        lda #<>aUnknown87C8F5
        sta lR18
        ldx #$020C
        jsl rlDrawTileStringToTilemapEntry
        lda #(`aUnknown87C8FF)<<8
        sta lR18+1
        lda #<>aUnknown87C8FF
        sta lR18
        ldx #$030C
        jsl rlDrawTileStringToTilemapEntry
        lda #(`aUnknown87C909)<<8
        sta lR18+1
        lda #<>aUnknown87C909
        sta lR18
        ldx #$040C
        jsl rlDrawTileStringToTilemapEntry
        lda #(`aUnknown87C913)<<8
        sta lR18+1
        lda #<>aUnknown87C913
        sta lR18
        ldx #$050C
        jsl rlDrawTileStringToTilemapEntry
        rts

        .databank 0

        ; 87/C8E1

    .endsection Unsorted87C87ASection


    .section Table87C8E1Section

      .al
      .xl

      aUnknown87C8E1 ; 87/C8E1
        .byte $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $00

      aUnknown87C8EB ; 87/C8EB
        .byte $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $00

      aUnknown87C8F5 ; 87/C8F5
        .byte $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $00

      aUnknown87C8FF ; 87/C8FF
        .byte $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $00

      aUnknown87C909 ; 87/C909
        .byte $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $00

      aUnknown87C913 ; 87/C913
        .byte $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $00

      aUnknown87C91D .dstruct structHDMAIndirectEntryInfo, rsUnknown87C929, rsUnknown87C989, aUnknown87C9C3, $7EEBEC, PPU_REG_BASE + $10, $42, $7E ; 87/C91D

      rsUnknown87C929 ; 87/C929

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0062
        lda #$008D

        _C92F
        sta $7EEB88,x
        dec x
        dec x
        bpl _C92F
        lda #$0000
        sta $7EF02C
        sta $7EF02E
        sta $7EF032
        lda #$0003
        sta $7EF030
        lda #$0001
        sta $7EF034
        lda #$8700
        sta $7EF037
        lda #$C96B
        sta $7EF036
        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20
        rtl

        .databank 0

        ; 87/C96B

      aUnknown87C96B ; 87/C96B
        .byte $00, $0C, $00, $01, $00, $0A, $00, $01, $00, $08, $00, $01, $00, $06, $00, $01
        .byte $00, $04, $00, $01, $00, $02, $00, $01, $00, $01, $00, $20, $FF, $FF

      rsUnknown87C989 ; 87/C989

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        bit #$0001
        bne _C99C
        lda #$0000
        sta $7EF02C
        lda #$EBEC
        bra _C9A6


        _C99C
        lda #$0200
        sta $7EF02C
        lda #$EC0C

        _C9A6
        sta aHDMASystem.aOffset,b,x
        lda wVBlankEnabledFramecount
        and $7EF034
        bne _C9B7
        jsr rsUnknown87C9CF
        jsr rsUnknown87CA4E

        _C9B7
        jsr rsUnknown87CA92
        lda $7EF02C
        tax
        jsr rsUnknown87CAF4
        rtl

        .databank 0

        ; 87/C9C3

      aUnknown87C9C3 ; 87/C9C3
        HDMA_SLEEP 1
        HDMA_JUMP_IF_BITS_UNSET aUnknown87C9C3, 1
        HDMA_END

      rsUnknown87C9CF ; 87/C9CF

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        lda $7EF030
        dec a
        sta $7EF030
        bne _CA38
        sep #$20
        lda $7EF038
        pha
        rep #$20
        plb
        .databank ?
        lda $7EF02E
        asl a
        asl a
        clc
        adc $7EF036
        tay
        lda $0000,b,y
        cmp #$FFFF
        beq _CA3B
        lda $0000,b,y
        and #$00FF
        sta $7EF032
        bne _CA19
        lda $7EEB88
        sec
        sbc $0001,b,y
        bpl _CA13
        lda #$0000

        _CA13
        sta $7EEB88
        bra _CA25


        _CA19
        lda $7EEBEA
        clc
        adc $0001,b,y
        sta $7EEBEA

        _CA25
        lda $0003,b,y
        and #$00FF
        sta $7EF030
        lda $7EF02E
        inc a
        sta $7EF02E

        _CA38
        ply
        plb
        .databank ?
        rts


        _CA3B
        sep #$20
        lda #$15
        sta bBufferTM
        rep #$20
        lda aHDMASystem.aBitfield,b,x
        ora #$0001
        sta aHDMASystem.aBitfield,b,x
        bra _CA38

        .databank 0

        ; 87/CA4E

      rsUnknown87CA4E ; 87/CA4E

        .al
        .xl
        .autsiz
        .databank ?

        lda $7EF032
        bne _CA73
        ldx #$0062

        _CA57
        lda $7EEB86,x
        inc a
        cmp $7EEB88,x
        beq _CA6D
        lda $7EEB86,x
        beq _CA69
        inc a

        _CA69
        sta $7EEB88,x

        _CA6D
        dec x
        dec x
        bne _CA57
        bra _CA91


        _CA73
        ldx #$0000

        _CA76
        lda $7EEB8A,x
        dec a
        cmp $7EEB88,x
        beq _CA8A
        lda $7EEB8A,x
        dec a
        sta $7EEB88,x

        _CA8A
        inc x
        inc x
        cpx #$0062
        bcc _CA76

        _CA91
        rts

        .databank 0

        ; 87/CA92

      rsUnknown87CA92 ; 87/CA92

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7EEB
        sta lR18+1
        lda $7EF02C
        bne _CAA2
        lda #$EBEC
        bra _CAA5


        _CAA2
        lda #$EC0C

        _CAA5
        sta lR18
        lda $7EEB88
        dec a
        beq _CACA
        bmi _CACA
        sta wR10
        lda #$EC2C
        clc
        adc $7EF02C
        sta wR11
        lda #$0000
        sta wR12
        lda #$0000
        sta wR13
        jsl rlBuildHDMADirectTableEntries

        _CACA
        lda $7EEBEA
        sec
        sbc $7EEB88
        inc a
        sta wR10
        lda #$EC2E
        clc
        adc $7EF02C
        sta wR11
        lda #$0080
        sta wR12
        lda #$00F0
        sta wR13
        jsl rlBuildHDMADirectTableEntries
        lda #$0000
        sta [lR18]
        rts

        .databank 0

        ; 87/CAF4

      rsUnknown87CAF4 ; 87/CAF4

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        phx
        lda #$0030
        sta @l $7EEC2C,x
        inc x
        inc x
        ldy #$0000

        _CB0B
        tya
        lsr a
        sec
        sbc $EB88,b,y
        sta wR2
        lda $EB88,b,y
        sta wR0
        lda $EB8A,b,y
        sta wR1
        lda wR0
        cmp wR1
        bcs _CB35

        _CB23
        lda wR2
        sta @l $7EEC2C,x
        inc x
        inc x
        dec wR2
        inc wR0
        lda wR0
        cmp wR1
        bcc _CB23

        _CB35
        inc y
        inc y
        cpy #$0062
        bcc _CB0B
        lda #$0000
        sta @l $7EEC2C,x
        plx
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 87/CB47

      aUnknown87CB47 .dstruct structHDMAIndirectEntryInfo, rsUnknown87CB53, rsUnknown87C989, aUnknown87C9C3, $7EEBEC, PPU_REG_BASE + $10, $42, $7E ; 87/CB47

      rsUnknown87CB53 ; 87/CB53

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0062
        lda #$0071

        _CB59
        sta $7EEB88,x
        dec a
        dec x
        dec x
        bpl _CB59
        lda #$0000
        sta $7EF02C
        sta $7EF02E
        sta $7EF032
        lda #$0001
        sta $7EF034
        lda #$0001
        sta $7EF030
        lda #$8700
        sta $7EF037
        lda #$CB9B
        sta $7EF036
        lda #$FFFD
        sta wBufferBG2HOFS
        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20
        rtl

        .databank 0

        ; 87/CB9B

      aUnknown87CB9B ; 87/CB9B
        .byte $00, $01, $00, $01, $00, $02, $00, $01, $00, $04, $00, $01, $00, $06, $00, $01
        .byte $00, $08, $00, $01, $00, $0A, $00, $01, $00, $0C, $00, $01, $00, $0E, $00, $01
        .byte $00, $10, $00, $01, $00, $00, $00, $27, $FF, $FF

    .endsection Table87C8E1Section


