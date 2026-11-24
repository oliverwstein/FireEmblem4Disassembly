; Map battle magic: the machinery shared by all the map magic effects
; (bank $9F), and the background and sprite data each effect loads.
;
; The map battle (bank $9E) picks each side's effect from its weapon
; (wMapMagicAttackerEffect, wMapMagicDefenderEffect: WeaponID - $3E, Fire is
; $3E), and for each round with an effect:
;
;   rlSelectMapMagicEffectForRound   wMapMagicEffect = the acting side's
;   rlQueueMapMagicBackground*       decompress the background (tiles,
;                                    tilemap, colours: aMapBattleMagicBackgrounds)
;   rlUploadMapMagicBackground*, rlCopyMapMagicBackgroundColors
;   rlLoadMapMagicSprites, rlUploadMapMagicSpriteTiles   (aMapBattleMagicSprites)
;   rlStartMapMagicEffect            create procMapMagicEffect
;   ... the battler's sprite script sets wMapMagicStart; the proc runs the
;   effect's starter (map_magic_effects.asm), which sets wMapMagicDone at the
;   end ...
;   rlEndMapMagicEffect, rlRestoreMapMagicScreenRegisters
;
; Also here: the helpers the effects share (sound, creating and freeing their
; procs and HDMA entries, palette fades, sprite motion and angles).

    .section MapBattleMagicBackgroundsSection

      .al
      .xl

      aMapBattleMagicBackgrounds ; 9F/80D9

        ; One entry per item from Fire to BrokenStaffA, each three compressed
        ; streams: 4bpp tiles (to aDecompressionBuffer+$4000), a 32x32
        ; tilemap (to $7EDB88) and 256 colours (to $7EE388). Streams shared by
        ; several items are named after the first. Meteor and Valflame also
        ; have a second tilemap (acMapBattleMagicMeteorTilemap2,
        ; acMapBattleMagicValflameTilemap2), which rlQueueMapMagicBackgroundTilemap picks by
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

        ; Read by rlLoadMapMagicSprites with the same index as
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

        ; Unused: 10 $FF bytes.
        .fill 10, $FF

    .endsection MapBattleMagicSpritesSection


    .section Unsorted87C70ASection

      .al
      .xl

      procUnknown87C70A ; 87/C70A

        ; BG2 HDMA ripple visual effect created by rlUnknown9FF947 in map_magic_effects.asm.
        .structProcInfo "RP", rlProcMapMagicRippleInit, rlProcMapMagicRippleUploadTiles, aProcUnknown87C70ACode

    .endsection Unsorted87C70ASection


    .section Unsorted87C712Section

      .al
      .xl

      rlProcMapMagicRippleInit ; 87/C712

        .al
        .xl
        .autsiz
        .databank ?

        ; Initializes BG2 ripple palette, tile decompression, and tilemap upload.

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
        jsr rsDrawMapMagicRippleSmallTilemap
        bra _C764


        _C761
        jsr rsDrawMapMagicRippleLargeTilemap

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

      rlProcMapMagicRippleUploadTiles ; 87/C7B4

        .al
        .xl
        .autsiz
        .databank ?

        ; Waits for decompression and DMAs BG2 ripple tiles to VRAM $7000.

        lda bDecompressionArrayFlag,b
        bne _C7CE
        phx
        jsl rlDMAByStruct

          .structDMAToVRAM $7EEB88, $0E00, $80, $7000

        plx
        lda #<>rlProcMapMagicRippleStartHDMA
        sta aProcSystem.aHeaderOnCycle,b,x

        _C7CE
        rtl

        .databank 0

        ; 87/C7CF

      rlProcMapMagicRippleStartHDMA ; 87/C7CF

        .al
        .xl
        .autsiz
        .databank ?

        ; Starts the small or large BG2 ripple HDMA entry.

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
        lda #<>rlProcMapMagicRippleWaitDone
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 87/C7F3

    .endsection Unsorted87C7B4Section


    .section Unsorted87C7F3Section

      .al
      .xl

      rlProcMapMagicRippleWaitDone ; 87/C7F3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Waits for ripple HDMA completion, clears BG2 tilemap, and frees the proc.

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

      rsDrawMapMagicRippleSmallTilemap ; 87/C821

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the 4x4 small ripple tilemap.

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

      rsDrawMapMagicRippleLargeTilemap ; 87/C87A

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the 9x6 large ripple tilemap.

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

      aUnknown87C91D .dstruct structHDMAIndirectEntryInfo, rsHDMAMapMagicRippleSmallInit, rsHDMAMapMagicRippleCycle, aUnknown87C9C3, $7EEBEC, PPU_REG_BASE + $10, $42, $7E ; 87/C91D

      rsHDMAMapMagicRippleSmallInit ; 87/C929

        .al
        .xl
        .autsiz
        .databank ?

        ; Initializes small BG2 ripple HDMA state and script.

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

      rsHDMAMapMagicRippleCycle ; 87/C989

        .al
        .xl
        .autsiz
        .databank ?

        ; Double-buffers and updates the BG2 ripple HDMA table each frame.

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
        jsr rsStepMapMagicRippleScript
        jsr rsStepMapMagicRippleBounds

        _C9B7
        jsr rsBuildMapMagicRippleHDMA
        lda $7EF02C
        tax
        jsr rsBuildMapMagicRippleBG2VOFS
        rtl

        .databank 0

        ; 87/C9C3

      aUnknown87C9C3 ; 87/C9C3
        HDMA_SLEEP 1
        HDMA_JUMP_IF_BITS_UNSET aUnknown87C9C3, 1
        HDMA_END

      rsStepMapMagicRippleScript ; 87/C9CF

        .al
        .xl
        .autsiz
        .databank ?

        ; Steps the BG2 ripple HDMA script to expand or contract scanline bounds.

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

      rsStepMapMagicRippleBounds ; 87/CA4E

        .al
        .xl
        .autsiz
        .databank ?

        ; Interpolates the BG2 ripple scanline height table.

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

      rsBuildMapMagicRippleHDMA ; 87/CA92

        .al
        .xl
        .autsiz
        .databank ?

        ; Builds the direct HDMA table for the BG2 ripple effect.

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

      rsBuildMapMagicRippleBG2VOFS ; 87/CAF4

        .al
        .xl
        .autsiz
        .databank ?

        ; Computes per-scanline BG2VOFS offsets for the BG2 ripple effect.

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

      aUnknown87CB47 .dstruct structHDMAIndirectEntryInfo, rsHDMAMapMagicRippleLargeInit, rsHDMAMapMagicRippleCycle, aUnknown87C9C3, $7EEBEC, PPU_REG_BASE + $10, $42, $7E ; 87/CB47

      rsHDMAMapMagicRippleLargeInit ; 87/CB53

        .al
        .xl
        .autsiz
        .databank ?

        ; Initializes large BG2 ripple HDMA state and script.

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


    .section Bank9FBuildStampSection

      .al
      .xl

      aBank9FBuildStamp ; 9F/8000

        ; Unreferenced: an ASCII build stamp at the start of the bank.
        .text "1996/01/10 05:29 by manchan     "

    .endsection Bank9FBuildStampSection


    .section Unsorted9F8020Section

      .al
      .xl

      rlStartMapMagicEffect ; 9F/8020

        .al
        .xl
        .autsiz
        .databank ?

        ; Unless wMapMagicEffect is negative: saves the screen registers, records the caster's facing and the window lines, empties the effect's proc and HDMA lists, and creates procMapMagicEffect.

        lda wMapMagicEffect
        bpl _8027
        rtl


        _8027
        phb
        phk
        plb
        .databank $9F
        phx
        phy
        jsr rsSetMapMagicCasterFacing
        jsr rsSaveMapMagicScreenRegisters
        jsr rsSetMapMagicWindowLines
        lda #$0000
        sta wMapMagicProcListEnd
        sta wMapMagicHDMAListEnd
        lda #$FFFF
        sta aMapMagicProcList
        sta aMapMagicHDMAList
        lda #(`procMapMagicEffect)<<8
        sta lR44+1
        lda #<>procMapMagicEffect
        sta lR44
        jsl rlProcEngineCreateProc
        ply
        plx
        plb
        .databank ?
        rtl

        .databank 0

        ; 9F/805D

    .endsection Unsorted9F8020Section


    .section ProcScript9F805DSection

      .al
      .xl

      procMapMagicEffect ; 9F/805D

        .structProcInfo "ON", rlProcMapMagicEffectInit, rlProcMapMagicEffectCycle, aProcMapMagicHaltCode

    .endsection ProcScript9F805DSection


    .section Unsorted9F8065Section

      .al
      .xl

      rlProcMapMagicEffectCycle ; 9F/8065

        .al
        .xl
        .autsiz
        .databank ?

        ; Waits for wMapMagicStart (set by active sprite command $10 in the battler's script), runs the effect's starter from aMapMagicEffectStarters once, and ends. A negative wMapMagicStart ends it without one.

        lda wMapMagicStart
        beq _8084
        bmi _8081
        phx
        lda wMapMagicEffect
        asl a
        tax
        lda <>aMapMagicEffectStarters,b,x
        sta lR18
        phk
        pea #<>_8080 - 1
        jmp (lR18)


        _8080
        plx

        _8081
        stz aProcSystem.aHeaderTypeOffset,b,x

        _8084
        rtl

        .databank 0

        ; 9F/8085


      aMapMagicEffectStarters ; 9F/8085

        .word <>rlStartMapMagicFire
        .word <>rlStartMapMagicElfire
        .word <>rlStartMapMagicBolganone
        .word <>rlStartMapMagicValflame
        .word <>rlStartMapMagicMeteor
        .word <>rlStartMapMagicThunder
        .word <>rlStartMapMagicElthunder
        .word <>rlStartMapMagicThoron
        .word <>rlStartMapMagicMjolnir
        .word <>rlStartMapMagicElthunder
        .word <>rlStartMapMagicWind
        .word <>rlStartMapMagicWind
        .word <>rlStartMapMagicTornado
        .word <>rlStartMapMagicForseti
        .word <>rlStartMapMagicBlizzard
        .word <>rlStartMapMagicLight
        .word <>rlStartMapMagicNosferatu
        .word <>rlStartMapMagicAura
        .word <>rlStartMapMagicHeal
        .word <>rlStartMapMagicJormungandr
        .word <>rlStartMapMagicFenrir
        .word <>rlStartMapMagicHel
        .word <>rlStartMapMagicHeal
        .word <>rlStartMapMagicHeal
        .word <>rlStartMapMagicHeal
        .word <>rlStartMapMagicHeal
        .word <>rlStartMapMagicHeal
        .word <>rlStartMapMagicMend
        .word <>rlStartMapMagicRecover
        .word <>rlStartMapMagicPhysic
        .word <>rlStartMapMagicFortify
        .word <>rlStartMapMagicReturn
        .word <>rlStartMapMagicWarp
        .word <>rlStartMapMagicWarp
        .word <>rlStartMapMagicHeal
        .word <>rlStartMapMagicRestore
        .word <>rlStartMapMagicHeal
        .word <>rlStartMapMagicSilence
        .word <>rlStartMapMagicSleep
        .word <>rlStartMapMagicBerserk
        .word <>rlStartMapMagicThief
        .word <>rlStartMapMagicBrokenStaff

    .endsection Unsorted9F8065Section


    .section Unsorted9F8253Section

      .al
      .xl

      rsPlayMapMagicSound ; 9F/8253

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        ; Plays the sound effect in the byte after the call, panned by the X pixel in A (rlPlaySoundEffect2).

        phx
        tax
        lda #3,s
        tay
        lda $0001,b,y
        and #$00FF
        pha
        tya
        inc a
        sta #5,s
        txa
        and #$00FF
        lsr a
        lsr a
        lsr a
        cmp #$0010
        bcs _8270
        inc a

        _8270
        xba
        ora #1,s
        jsl rlPlaySoundEffect2
        pla
        plx
        rts

        .databank 0

      rsShakeMapMagicBackground ; 9F/827A

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Bolganone and Meteor effects.
        ; Applies a 4-frame screen-shake offset from aMapMagicShakeOffsets to BG2/BG3 scroll.

        phx
        lda aProcSystem.aBody7,b,x
        inc aProcSystem.aBody7,b,x
        and #$0003
        asl a
        tax
        sep #$20
        lda $7F57FD
        adc <>aMapMagicShakeOffsets,b,x
        sta $7F
        lda $7F57FE
        clc
        adc <>(aMapMagicShakeOffsets+1),b,x
        sta $81
        rep #$20
        plx
        rts

        .databank 0

      aMapMagicShakeOffsets ; 9F/829F

        ; Shared by the Bolganone and Meteor effects.
        .byte $02, $02, $00, $02, $00, $FE, $FE, $FE

        ; 9F/82A7

    .endsection Unsorted9F8253Section


    .section Unsorted9F82A7Section

      .al
      .xl

      rsSetMapMagicCasterFacing ; 9F/82A7

        .al
        .xl
        .autsiz
        .databank ?

        ; $7F50C9 = the acting side's facing (aMapAction.wDefenderFacing, or wAttackerFacing when the round's bit 0 says the defender acts).

        lda aMapAction.wDefenderFacing
        tay
        lda wMapBattleRoundEntry
        lsr a
        bcc _82B8
        lda aMapAction.wAttackerFacing
        tay

        _82B8
        tya
        sta $7F50C9
        rts

        .databank 0

      rsClearMapMagicProcBody ; 9F/82BE

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears aBody0-aBody7 of proc X.

        stz aProcSystem.aBody0,b,x
        stz aProcSystem.aBody1,b,x
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        stz aProcSystem.aBody4,b,x
        stz aProcSystem.aBody5,b,x
        stz aProcSystem.aBody6,b,x
        stz aProcSystem.aBody7,b,x
        rts

        .databank 0

        ; 9F/82D7

    .endsection Unsorted9F82A7Section


    .section Unsorted9F82D7Section

      .al
      .xl

      rsCreateMapMagicProc ; 9F/82D7

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        ; Creates the proc whose header (bank $9F) is the word after the call and adds its slot to aMapMagicProcList, so rlEndMapMagicEffect frees it. Returns the slot in A.

        phk
        phk
        pla
        sta lR44+1
        lda #1,s
        tay
        lda $0001,b,y
        sta lR44
        tya
        clc
        adc #$0002
        sta #1,s
        jsl rlProcEngineCreateProc
        bcs _830E
        phx
        pha
        lda wMapMagicProcListEnd
        tax
        lda #1,s
        sta aMapMagicProcList,x
        lda #$FFFF
        sta $7F50A7,x
        inc x
        inc x
        txa
        sta wMapMagicProcListEnd
        pla
        plx

        _830E
        rts

        .databank 0

        ; 9F/830F

      rsCreateMapMagicHDMA ; 9F/830F

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        ; Creates the HDMA entry whose header (bank $9F) is the word after the call and adds it to aMapMagicHDMAList. Returns its offset in A.

        phk
        phk
        pla
        sta lR44+1
        lda #1,s
        tay
        lda $0001,b,y
        sta lR44
        tya
        clc
        adc #$0002
        sta #1,s
        jsl rlHDMAEngineCreateEntry
        bcs _8348
        phx
        lda wMapMagicHDMAListEnd
        tax
        lda aHDMASystem.wOffset,b
        sta aMapMagicHDMAList,x
        lda #$FFFF
        sta $7F50B9,x
        inc x
        inc x
        txa
        sta wMapMagicHDMAListEnd
        plx
        lda aHDMASystem.wOffset,b

        _8348
        rts

        .databank 0

        ; 9F/8349

    .endsection Unsorted9F82D7Section


    .section Unsorted9F8349Section

      .al
      .xl

      rlEndMapMagicEffect ; 9F/8349

        .al
        .xl
        .autsiz
        .databank ?

        ; Unless wMapMagicEffect is negative: frees the effect's HDMA entries and procs and, when wMapMagicFlags is set, restores BG2SC.

        lda wMapMagicEffect
        bmi _8358
        jsr rsFreeMapMagicHDMA
        jsr rsFreeMapMagicProcs
        jsr rsRestoreMapMagicBG2SC

        _8358
        rtl

        .databank 0

        ; 9F/8359

      rsFreeMapMagicHDMA ; 9F/8359

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        bra _8366


        _835F
        lsr a
        jsl rlHDMAEngineFreeEntryByIndex
        inc x
        inc x

        _8366
        lda aMapMagicHDMAList,x
        cmp #$FFFF
        bne _835F
        plx
        rts

        .databank 0

        ; 9F/8371

      rsFreeMapMagicProcs ; 9F/8371

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        bra _837E


        _8377
        lsr a
        jsl rlProcEngineFreeProcByIndex
        inc x
        inc x

        _837E
        lda aMapMagicProcList,x
        cmp #$FFFF
        bne _8377
        plx
        rts

        .databank 0

        ; 9F/8389

      rsRestoreMapMagicBG2SC ; 9F/8389

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapMagicFlags
        beq _8397
        sep #$20
        lda #$54
        sta bBufferBG2SC
        rep #$20

        _8397
        rts

        .databank 0

        ; 9F/8398

    .endsection Unsorted9F8349Section


    .section Unsorted9F8398Section

      .al
      .xl

      rsCreateMapMagicActiveSpriteInline ; 9F/8398

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced. Writes an active sprite definition to $7ECC0E from the
        ; two words after the call (bank $9F) and creates the sprite from it.

        phx
        phk
        phk
        pla
        sta $7ECC12
        sta $7ECC0F
        lda #3,s
        tay
        lda $0001,b,y
        sta $7ECC11
        lda $0003,b,y
        sta $7ECC0E
        tya
        clc
        adc #$0004
        sta #3,s
        lda #$7E00
        sta lR44+1
        lda #$CC00
        sta lR44
        ldx #$0000
        txy
        jsl rlCreateActiveSpriteHighestSlotRelative
        plx
        rts

        .databank 0

        ; 9F/83D0

    .endsection Unsorted9F8398Section


    .section Unsorted9F83D0Section

      .al
      .xl

      rsSetMapMagicWindowLines ; 9F/83D0

        .al
        .xl
        .autsiz
        .databank ?

        ; $7F5095 and $7F5097 = four HDMA line counts from aUnknown9F83E9, picked by bit 2 of wMapMagicFlags' high byte (the units near the bottom of the screen).

        phx
        lda wMapMagicFlags+1
        and #$0004
        tax
        lda <>aMapMagicWindowLines,b,x
        sta $7F5095
        lda <>(aMapMagicWindowLines+2),b,x
        sta $7F5097
        plx
        rts

        .databank 0

        ; 9F/83E9


      aMapMagicWindowLines ; 9F/83E9

        .byte $08, $21, $7F, $37, $7F, $30, $22, $0E

    .endsection Unsorted9F83D0Section


    .section Unsorted9F83F1Section

      .al
      .xl

      rsSetMapMagicLayerBlending ; 9F/83F1

        .al
        .xl
        .autsiz
        .databank ?

        ; Puts BG2 on the main screen and sets the windows and colour math (add) used by the effects' backgrounds.

        php
        sep #$20
        lda bBufferTM
        ora #$02
        sta bBufferTM
        lda #$0F
        sta bBufferWBGLOG
        lda #$01
        sta bBufferWOBJLOG
        lda #$11
        sta bBufferTS
        lda #$17
        sta bBufferTMW
        lda #$11
        sta bBufferTSW
        lda #$82
        sta bBufferCGADSUB
        plp
        rts

        .databank 0

        ; 9F/8414

    .endsection Unsorted9F83F1Section


    .section Unsorted9F8414Section

      .al
      .xl

      rsSaveMapMagicScreenRegisters ; 9F/8414

        .al
        .xl
        .autsiz
        .databank ?

        ; Saves the window, layer, colour math and BG1/BG2 scroll buffers to $7F57F2-$7F5800.

        php
        sep #$20
        lda bBufferW12SEL
        sta $7F57F2
        lda bBufferW34SEL
        sta $7F57F3
        lda bBufferWOBJSEL
        sta $7F57F4
        lda bBufferWBGLOG
        sta $7F57F5
        lda bBufferWOBJLOG
        sta $7F57F6
        lda bBufferTM
        sta $7F57F7
        lda bBufferTS
        sta $7F57F8
        lda bBufferTMW
        sta $7F57F9
        lda bBufferTSW
        sta $7F57FA
        lda bBufferCGWSEL
        sta $7F57FB
        lda bBufferCGADSUB
        sta $7F57FC
        lda wBufferBG1HOFS
        sta $7F57FD
        lda wBufferBG1VOFS
        sta $7F57FE
        lda wBufferBG2HOFS
        sta $7F57FF
        lda wBufferBG2VOFS
        sta $7F5800
        plp
        rts

        .databank 0

        ; 9F/8473

      rlRestoreMapMagicScreenRegisters ; 9F/8473

        .al
        .xl
        .autsiz
        .databank ?

        ; Unless wMapMagicEffect is negative: restores what rsSaveMapMagicScreenRegisters saved and sets BG2SC to $54.

        lda wMapMagicEffect
        bpl _847A
        rtl


        _847A
        php
        sep #$20
        lda $7F57F2
        sta bBufferW12SEL
        lda $7F57F3
        sta bBufferW34SEL
        lda $7F57F4
        sta bBufferWOBJSEL
        lda $7F57F5
        sta bBufferWBGLOG
        lda $7F57F6
        sta bBufferWOBJLOG
        lda $7F57F7
        sta bBufferTM
        lda $7F57F8
        sta bBufferTS
        lda $7F57F9
        sta bBufferTMW
        lda $7F57FA
        sta bBufferTSW
        lda $7F57FB
        sta bBufferCGWSEL
        lda $7F57FC
        sta bBufferCGADSUB
        lda $7F57FD
        sta wBufferBG1HOFS
        lda $7F57FE
        sta wBufferBG1VOFS
        lda $7F57FF
        sta wBufferBG2HOFS
        lda $7F5800
        sta wBufferBG2VOFS
        lda #$54
        sta bBufferBG2SC
        plp
        rtl

        .databank 0

        ; 9F/84DD

      rlQueueMapMagicBackgroundTiles ; 9F/84DD

        .al
        .xl
        .autsiz
        .databank ?

        ; Queues the effect's background tiles (aMapBattleMagicBackgrounds) for decompression.

        lda wMapMagicEffect
        bmi _850A
        phx
        phy
        sta wR0
        asl a
        asl a
        asl a
        clc
        adc wR0
        tax
        lda aMapBattleMagicBackgrounds,x
        sta lR18
        lda aMapBattleMagicBackgrounds+1,x
        sta lR18+1
        lda #(`aWorldMapMarkerPalette)<<8
        sta lR19+1
        lda #<>aWorldMapMarkerPalette
        sta lR19
        jsl rlAppendDecompList
        ply
        plx

        _850A
        rtl

        .databank 0

        ; 9F/850B

      rlQueueMapMagicBackgroundTilemap ; 9F/850B

        .al
        .xl
        .autsiz
        .databank ?

        ; Queues the effect's background tilemap for decompression to $7EDB88. Meteor and Valflame take their second tilemap when the target is at the right of the screen (X >= $A0, $C0).

        lda wMapMagicEffect
        bmi _8574
        phx
        phy
        sta wR0
        cmp #$0004
        bne _8532
        lda wMapMagicTargetPixel
        and #$00FF
        cmp #$00A0
        bmi _8532
        lda #(`acMapBattleMagicMeteorTilemap2)<<8
        sta lR18+1
        lda #<>acMapBattleMagicMeteorTilemap2
        sta lR18
        bra _8564


        _8532
        cmp #$0003
        bne _854F
        lda wMapMagicTargetPixel
        and #$00FF
        cmp #$00C0
        bmi _854F
        lda #(`acMapBattleMagicValflameTilemap2)<<8
        sta lR18+1
        lda #<>acMapBattleMagicValflameTilemap2
        sta lR18
        bra _8564


        _854F
        lda wR0
        asl a
        asl a
        asl a
        clc
        adc wR0
        tax
        lda aMapBattleMagicBackgrounds+3,x
        sta lR18
        lda aMapBattleMagicBackgrounds+4,x
        sta lR18+1

        _8564
        lda #$7E00
        sta lR19+1
        lda #$DB88
        sta lR19
        jsl rlAppendDecompList
        ply
        plx

        _8574
        rtl

        .databank 0

        ; 9F/8575

      rlQueueMapMagicBackgroundPalette ; 9F/8575

        .al
        .xl
        .autsiz
        .databank ?

        ; Queues the effect's background colours for decompression to $7EE388.

        lda wMapMagicEffect
        bmi _85A2
        phx
        phy
        sta wR0
        asl a
        asl a
        asl a
        clc
        adc wR0
        tax
        lda aMapBattleMagicBackgrounds+6,x
        sta lR18
        lda aMapBattleMagicBackgrounds+7,x
        sta lR18+1
        lda #$7E00
        sta lR19+1
        lda #$E388
        sta lR19
        jsl rlAppendDecompList
        ply
        plx

        _85A2
        rtl

        .databank 0

        ; 9F/85A3

      rlUploadMapMagicBackgroundTiles ; 9F/85A3

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs the first $800 bytes of the decompressed background tiles to VRAM.

        lda wMapMagicEffect
        bmi _85CB
        phy
        phx
        lda #(`aWorldMapMarkerPalette)<<8
        sta lR18+1
        lda #<>aWorldMapMarkerPalette
        sta lR18
        lda #$0800
        sta wR0
        lda bBufferBG4SC
        and #$F000
        clc
        adc #$3800
        sta wR1
        jsl rlDMAByPointer
        plx
        ply

        _85CB
        rtl

        .databank 0

        ; 9F/85CC

      rlUploadMapMagicBackgroundTilesRest ; 9F/85CC

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs the next $800 bytes ($7ED388) of the background tiles to VRAM.

        lda wMapMagicEffect
        bmi _85F4
        phy
        phx
        lda #$7E00
        sta lR18+1
        lda #$D388
        sta lR18
        lda #$0800
        sta wR0
        lda bBufferBG4SC
        and #$F000
        clc
        adc #$3C00
        sta wR1
        jsl rlDMAByPointer
        plx
        ply

        _85F4
        rtl

        .databank 0

        ; 9F/85F5

      rlUploadMapMagicBackgroundTilemap ; 9F/85F5

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapMagicEffect
        bmi _861E
        phy
        phx
        lda #$7E00
        sta lR18+1
        lda #$DB88
        sta lR18
        lda #$0800
        sta wR0
        lda bBufferBG1SC
        and #$00FC
        xba
        clc
        adc #$0C00
        sta wR1
        jsl rlDMAByPointer
        plx
        ply

        _861E
        rtl

        .databank 0

        ; 9F/861F

      rlCopyMapMagicBackgroundColors ; 9F/861F

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies colours $69-$6F of the decompressed palette into palettes 6 and 7 of aBGPaletteBuffer (only palette 6 in battle type 3).

        lda wMapMagicEffect
        bmi _8676
        phy
        phx
        lda #$7E00
        sta lR18+1
        sta lR19+1
        lda #$E388
        sta lR18
        clc
        adc #$0020
        sta lR19
        lda wBattleType
        and #$00FF
        cmp #$0003
        beq _8660
        ldy #$00D2
        ldx #$00D2

        _864B
        lda [lR18],y
        sta aBGPaletteBuffer,b,x
        lda [lR19],y
        sta aBGPaletteBuffer.aPalette1,b,x
        inc y
        inc y
        inc x
        inc x
        cpx #$00E0
        bne _864B
        bra _8674


        _8660
        ldy #$00D2
        ldx #$00D2

        _8666
        lda [lR18],y
        sta aBGPaletteBuffer,b,x
        inc y
        inc y
        inc x
        inc x
        cpx #$00E0
        bne _8666

        _8674
        plx
        ply

        _8676
        rtl

        .databank 0

        ; 9F/8677

      rlUploadMapMagicSpriteTiles ; 9F/8677

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs the effect's sprite tiles ($7F45D9) to sprite VRAM.

        phb
        phy
        phx
        lda #$7F00
        sta lR18+1
        lda #$45D9
        sta lR18
        lda #$0400
        sta wR0
        lda aMapAction.wMapBattleRoundIndex
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        and #$0001
        asl a
        tax
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
        plb
        .databank ?
        rtl

        .databank 0

        ; 9F/86B0

    .endsection Unsorted9F8414Section


    .section Unsorted9F86B0Section

      .al
      .xl

      rlCheckMapMagicDecompressionDone ; 9F/86B0

        .al
        .autsiz
        .databank ?

        ; Sets proc header bit $0001 when the decompression queue is empty.

        lda bDecompressionArrayFlag,b
        bne +

          lda aProcSystem.aHeaderBitfield,b,x
          ora #1
          sta aProcSystem.aHeaderBitfield,b,x

        +
        rtl

        .databank 0

        ; 9F/86BF

    .endsection Unsorted9F86B0Section


    .section Unsorted9F86BFSection

      .al
      .xl

      rlLoadMapMagicSprites ; 9F/86BF

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads the effect's sprite palette and queues its sprite tiles (aMapBattleMagicSprites); sets proc header bit $0002 when there are any.

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda wMapMagicEffect
        bmi _8721
        asl a
        asl a
        adc wMapMagicEffect
        tax
        lda aMapBattleMagicSprites,x
        cmp #$FFFF
        beq _8721
        phk
        phk
        ply
        sty lR19+1
        sta lR19
        lda aMapBattleMagicSprites+2,x
        sta lR18
        lda aMapBattleMagicSprites+3,x
        sta lR18+1
        ldx #$01DE
        ldy #$001E

        _86F9
        lda [lR19],y
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        dec y
        dec y
        bpl _86F9
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFE
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$7F00
        sta lR19+1
        lda #$45D9
        sta lR19
        jsl rlAppendDecompList

        _8721
        plx
        ply
        rtl

        .databank 0

        ; 9F/8724

    .endsection Unsorted9F86BFSection


    .section Unsorted9F88C0Section

      .al
      .xl

      aUnknown9F88C0 ; 9F/88C0

        ; Unreferenced: 32 colours after the map magic sprite palettes.
        .word $2550, $39F3, $4E97, $5F3B, $73DF, $01D8, $0619, $063A
        .word $0A7B, $0EBC, $12FD, $131E, $175F, $00AC, $00EE, $052F
        .word $0571, $09B2, $0A35, $0E97, $131A, $17DF, $0C89, $190C
        .word $298F, $3612, $4276, $4EF9, $5F7C, $6BFF, $0008, $14AC

    .endsection Unsorted9F88C0Section


    .section Unsorted9F8900Section

      .al
      .xl

      rlSelectMapMagicEffectForRound ; 9F/8900

        .al
        .xl
        .autsiz
        .databank ?

        ; When wMapMagicFlags is set: wMapMagicEffect = the acting side's effect this round (the defender's when the round's bit 0 is set), and proc header bit $0002 when there is one.

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda wMapMagicFlags
        beq _8942
        phx
        lda wMapMagicAttackerEffect
        sta wMapMagicEffect
        lda aMapAction.wMapBattleRoundIndex
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        beq _892F
        lda wMapMagicDefenderEffect
        sta wMapMagicEffect

        _892F
        plx
        lda wMapMagicEffect
        cmp #$FFFF
        beq _8942
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _8942
        rtl

        .databank 0

        ; 9F/8943

    .endsection Unsorted9F8900Section


    .section Unsorted9F8943Section

      .al
      .xl

      rlQueueMapMagicDMAList ; 9F/8943

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.
        ; Queues a list of $FFFF-terminated 8-byte DMA entries starting at X.

        php

        _8944
        ldy wDMAArrayPosition,b
        sep #$20
        lda #$02
        sta aDMAArray,b,y
        lda #$00
        sta $034F,b,y
        lda $0000,b,x
        sta $034C,b,y
        rep #$21
        lda $0001,b,x
        sta $0347,b,y
        lda $0002,b,x
        sta $0348,b,y
        lda $0004,b,x
        sta $034A,b,y
        lda $0006,b,x
        sta $034D,b,y
        tya
        adc #$0009
        sta wDMAArrayPosition,b
        txa
        clc
        adc #$0008
        tax
        lda $0000,b,x
        cmp #$FFFF
        bne _8944
        sep #$20
        lda #$01
        sta bDMAArrayFlag,b
        lda bBufferINIDISP
        bpl _8997
        jsl rlProcessDMAStructArray

        _8997
        plp
        rtl

        .databank 0

        ; 9F/8999

    .endsection Unsorted9F8943Section


    .section Unsorted9F8999Section

      .al
      .xl

      rlMoveActiveSpriteByVelocity ; 9F/8999

        .al
        .xl
        .autsiz
        .databank ?

        ; Adds the 8.8 velocities in aUnknown0013C0 and aUnknown0013E0 to the sprite's X and Y (aUnknown001200, aUnknown001240), keeping the fractions in their high bytes' neighbours.

        lda aActiveSpriteSystem.aUnknown0013C0,b,x
        sep #$20
        clc
        adc $11E1,b,x
        sta $11E1,b,x
        rep #$20
        and #$FF00
        xba
        bpl _89B0
        ora #$FF00

        _89B0
        adc aActiveSpriteSystem.aUnknown001200,b,x
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda aActiveSpriteSystem.aUnknown0013E0,b,x
        sep #$20
        clc
        adc $1221,b,x
        sta $1221,b,x
        rep #$20
        and #$FF00
        xba
        bpl _89CD
        ora #$FF00

        _89CD
        adc aActiveSpriteSystem.aUnknown001240,b,x
        sta aActiveSpriteSystem.aUnknown001240,b,x
        rtl

        .databank 0

      rsCheckActiveSpriteNearPoint ; 9F/89D4

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set when the sprite is less than wR2 pixels from (wR0, wR1) on both axes.

        lda aActiveSpriteSystem.aUnknown001200,b,x
        sec
        sbc wR0
        bpl _89E0
        eor #$FFFF
        inc a

        _89E0
        cmp wR2
        bpl _89F6
        lda aActiveSpriteSystem.aUnknown001240,b,x
        sec
        sbc wR1
        bpl _89F0
        eor #$FFFF
        inc a

        _89F0
        cmp wR2
        bpl _89F6
        sec
        rts

        _89F6
        clc
        rts

        .databank 0

      rlGetVectorLength ; 9F/89F8

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 7 effects.
        ; Returns the approximate Euclidean length of (wR0, wR1) in A (|x|*cos + |y|*sin).

        phx
        lda wR0
        sta wR2
        jsl rlGetVectorAngle
        sta wR0
        lda wR2
        bpl _8A0B
        eor #$FFFF
        inc a

        _8A0B
        xba
        jsl rlMultiplyByNegSin._8B84
        bpl _8A16
        eor #$FFFF
        inc a

        _8A16
        sta wR2
        lda wR1
        bpl _8A20
        eor #$FFFF
        inc a

        _8A20
        xba
        jsl rlMultiplyByNegSin
        bpl _8A2B
        eor #$FFFF
        inc a

        _8A2B
        clc
        adc wR2
        xba
        plx
        and #$00FF
        rtl

        .databank 0

        ; 9F/8A34

    .endsection Unsorted9F8999Section


    .section Unsorted9F8A34Section

      .as
      .xl

      rlGetVectorAngle ; 9F/8A34

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; The angle (0-255) of the vector (wR0, wR1), from a hardware division of the smaller by the larger and the octant.

        phx
        ldx #$0000
        lda wR0
        bpl _8A43
        ldx #$0004
        eor #$FFFF
        inc a

        _8A43
        sta wR0
        lda wR1
        bpl _8A4F
        inc x
        inc x
        eor #$FFFF
        inc a

        _8A4F
        sta wR1
        cmp wR0
        bpl _8A76
        sep #$20
        stz $4204,b
        lda wR1
        sta $4205,b
        lda wR0
        sta $4206,b
        nop
        nop
        nop
        rep #$20
        jsr (_8A6E,x)
        plx
        rtl

        _8A6E
        .word <>rsVectorAngleOctant0
        .word <>rsVectorAngleOctant1
        .word <>rsVectorAngleOctant2
        .word <>rsVectorAngleOctant3

        _8A76
        sep #$20
        stz $4204,b
        lda wR0
        sta $4205,b
        lda wR1
        sta $4206,b
        nop
        nop
        nop
        rep #$20
        jsr (_8A8F,x)
        plx
        rtl

        _8A8F
        .word <>rsVectorAngleOctant4
        .word <>rsVectorAngleOctant5
        .word <>rsVectorAngleOctant6
        .word <>rsVectorAngleOctant7

        .databank 0

        ; 9F/8A97

    .endsection Unsorted9F8A34Section


    .section Unsorted9F8A97Section

      .al
      .xl

      rsVectorAngleOctant0 ; 9F/8A97

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 9 effects.

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        inc a
        and #$00FF
        jml rsApplyVectorAngleCorrection

        .databank 0

        ; 9F/8AA8

      rsVectorAngleOctant1 ; 9F/8AA8

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 9 effects.

        lda $4214,b
        lsr a
        lsr a
        lsr a
        and #$00FF
        jml rsApplyVectorAngleCorrection

        .databank 0

        ; 9F/8AB5

      rsVectorAngleOctant2 ; 9F/8AB5

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 9 effects.

        lda $4214,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0080
        and #$00FF
        jml rsApplyVectorAngleCorrection

        .databank 0

        ; 9F/8AC6

      rsVectorAngleOctant3 ; 9F/8AC6

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 9 effects.

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        sec
        adc #$0080
        and #$00FF
        jml rsApplyVectorAngleCorrection

        .databank 0

        ; 9F/8ADA

      rsVectorAngleOctant4 ; 9F/8ADA

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 9 effects.

        lda $4214,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$00C0
        and #$00FF
        jml rsApplyVectorAngleCorrection

        .databank 0

        ; 9F/8AEB

      rsVectorAngleOctant5 ; 9F/8AEB

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 9 effects.

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        sec
        adc #$0040
        and #$00FF
        jml rsApplyVectorAngleCorrection

        .databank 0

        ; 9F/8AFF

      rsVectorAngleOctant6 ; 9F/8AFF

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 9 effects.

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        sec
        adc #$00C0
        and #$00FF
        jml rsApplyVectorAngleCorrection

        .databank 0

        ; 9F/8B13

      rsVectorAngleOctant7 ; 9F/8B13

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 9 effects.

        lda $4214,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0040
        and #$00FF
        jml rsApplyVectorAngleCorrection

        .databank 0

        ; 9F/8B24

      rsApplyVectorAngleCorrection ; 9F/8B24

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 9 effects.

        pha
        and #$003F
        tax
        lda <>aVectorAngleCorrectionTable,b,x
        and #$00FF
        eor #$FFFF
        inc a
        clc
        adc #1,s
        sta #1,s
        pla
        rts

        .databank 0

        ; 9F/8B3A


      aVectorAngleCorrectionTable ; 9F/8B3A

        ; Shared by 9 effects.
        .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF, $FF, $FF
        .byte $00, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $00, $00, $00
        .byte $00, $00, $01, $02, $02, $02, $03, $03, $03, $03, $04, $03, $03, $04, $03, $04
        .byte $03, $03, $03, $03, $03, $03, $03, $02, $02, $02, $02, $01, $01, $00, $00, $00

    .endsection Unsorted9F8A97Section


    .section Unsorted9F8B7ASection

      .al
      .xl

      rlMultiplyByNegSin ; 9F/8B7A

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 9 effects.
        ; Returns A * -sin(wR0) (or A * cos(wR0) at ._8B84) using aMapMagicSineTable.

        sta wR10
        lda wR0
        clc
        adc #$0080
        bra _8B8C

        _8B84
        sta wR10
        lda wR0
        clc
        adc #$0040

        _8B8C
        asl a
        and #$01FE
        tax
        lda aMapMagicSineTable,x
        sta wR14
        bpl _8B9D
        eor #$FFFF
        inc a

        _8B9D
        sta wR11
        jsr rsMultiply16By16MapMagic
        lda wR12+1
        bit wR14
        bpl _8BAC
        eor #$FFFF
        inc a

        _8BAC
        rtl

        .databank 0

        ; 9F/8BAD

      rsMultiply16By16MapMagic ; 9F/8BAD

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 9 effects.

        rep #$20
        sep #$10
        ldx wR10
        stx $4202,b
        ldx wR11
        stx $4203,b
        xba
        nop
        lda $4216,b
        sta wR12
        ldx wR10+1
        stx $4202,b
        ldx wR11+1
        stx $4203,b
        xba
        nop
        ldx $4216,b
        stx wR13
        ldy $4217,b
        ldx wR10+1
        stx $4202,b
        ldx wR11
        stx $4203,b
        lda wR12+1
        clc
        adc $4216,b
        sta wR12+1
        bcc _8BEB
        inc y

        _8BEB
        ldx wR10
        stx $4202,b
        ldx wR11+1
        stx $4203,b
        lda wR12+1
        clc
        adc $4216,b
        sta wR12+1
        bcc _8C00
        inc y

        _8C00
        sty wR13+1
        rep #$10
        rts

        .databank 0

        ; 9F/8C05

      rlMultiplyByNegSinMode7 ; 9F/8C05

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.
        ; Returns A * -sin(wR0) (or A * cos(wR0) at the second entry) via the Mode 7 multiplier.

        sta wR1
        lda wR0
        clc
        adc #$0080
        bra _8C17

        sta wR1
        lda wR0
        clc
        adc #$0040


        _8C17
        phx
        asl a
        and #$01FE
        tax
        lda aMapMagicSineTable,x
        sep #$20
        sta @l M7A
        xba
        sta @l M7A
        lda wR1
        sta @l M7B
        rep #$20
        lda @l $002135
        plx
        rtl

        .databank 0

        ; 9F/8C3A

    .endsection Unsorted9F8B7ASection


    .section Table9F8C3ASection

      .al
      .xl

      aMapMagicSineTable ; 9F/8C3A

        ; Shared by 9 effects.
        ; Read by rlMultiplyByNegSin and rlMultiplyByNegSinMode7 (256-entry signed trig table).

        .sint $0000, $0006, $000C, $0012, $0019, $001F, $0025, $002B
        .sint $0031, $0038, $003E, $0044, $004A, $0050, $0056, $005C
        .sint $0061, $0067, $006D, $0073, $0078, $007E, $0083, $0088
        .sint $008E, $0093, $0098, $009D, $00A2, $00A7, $00AB, $00B0
        .sint $00B5, $00B9, $00BD, $00C1, $00C5, $00C9, $00CD, $00D1
        .sint $00D4, $00D8, $00DB, $00DE, $00E1, $00E4, $00E7, $00EA
        .sint $00EC, $00EE, $00F1, $00F3, $00F4, $00F6, $00F8, $00F9
        .sint $00FB, $00FC, $00FD, $00FE, $00FE, $00FF, $00FF, $00FF
        .sint $0100, $00FF, $00FF, $00FF, $00FE, $00FE, $00FD, $00FC
        .sint $00FB, $00F9, $00F8, $00F6, $00F4, $00F3, $00F1, $00EE
        .sint $00EC, $00EA, $00E7, $00E4, $00E1, $00DE, $00DB, $00D8
        .sint $00D4, $00D1, $00CD, $00C9, $00C5, $00C1, $00BD, $00B9
        .sint $00B5, $00B0, $00AB, $00A7, $00A2, $009D, $0098, $0093
        .sint $008E, $0088, $0083, $007E, $0078, $0073, $006D, $0067
        .sint $0061, $005C, $0056, $0050, $004A, $0044, $003E, $0038
        .sint $0031, $002B, $0025, $001F, $0019, $0012, $000C, $0006
        .sint $0000, -$0006, -$000C, -$0012, -$0019, -$001F, -$0025, -$002B
        .sint -$0031, -$0038, -$003E, -$0044, -$004A, -$0050, -$0056, -$005C
        .sint -$0061, -$0067, -$006D, -$0073, -$0078, -$007E, -$0083, -$0088
        .sint -$008E, -$0093, -$0098, -$009D, -$00A2, -$00A7, -$00AB, -$00B0
        .sint -$00B5, -$00B9, -$00BD, -$00C1, -$00C5, -$00C9, -$00CD, -$00D1
        .sint -$00D4, -$00D8, -$00DB, -$00DE, -$00E1, -$00E4, -$00E7, -$00EA
        .sint -$00EC, -$00EE, -$00F1, -$00F3, -$00F4, -$00F6, -$00F8, -$00F9
        .sint -$00FB, -$00FC, -$00FD, -$00FE, -$00FE, -$00FF, -$00FF, -$00FF
        .sint -$0100, -$00FF, -$00FF, -$00FF, -$00FE, -$00FE, -$00FD, -$00FC
        .sint -$00FB, -$00F9, -$00F8, -$00F6, -$00F4, -$00F3, -$00F1, -$00EE
        .sint -$00EC, -$00EA, -$00E7, -$00E4, -$00E1, -$00DE, -$00DB, -$00D8
        .sint -$00D4, -$00D1, -$00CD, -$00C9, -$00C5, -$00C1, -$00BD, -$00B9
        .sint -$00B5, -$00B0, -$00AB, -$00A7, -$00A2, -$009D, -$0098, -$0093
        .sint -$008E, -$0088, -$0083, -$007E, -$0078, -$0073, -$006D, -$0067
        .sint -$0061, -$005C, -$0056, -$0050, -$004A, -$0044, -$003E, -$0038
        .sint -$0031, -$002B, -$0025, -$001F, -$0019, -$0012, -$000C, -$0006

        ; 9F/8E3A

    .endsection Table9F8C3ASection


    .section Unsorted9F8E3ASection

      .al
      .xl

      rlCopyRAMColorsToPaletteBuffer ; 9F/8E3A

        .al
        .xl
        .autsiz
        .databank ?

        ; The reverse of rlSavePaletteBufferColorsToRAM: copies colours to aBGPaletteBuffer. Seven bytes after the call: the long source, the number of colours, the buffer offset.

        phx
        phy
        lda #5,s
        tay
        lda $0001,b,y
        sta lR18
        lda $0002,b,y
        sta lR18+1
        lda $0004,b,y
        sta wR0
        lda $0006,b,y
        tax
        tya
        clc
        adc #$0007
        sta #5,s
        ldy #$0000

        _8E5C
        lda [lR18],y
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        inc y
        inc y
        dec wR0
        bne _8E5C
        ply
        plx
        rtl

        .databank 0

        ; 9F/8E6C


    .endsection Unsorted9F8E3ASection


    .section Unsorted9F8EC0Section

      .al
      .xl

      rlDarkenBGPaletteRange ; 9F/8EC0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Darkens A colours in aBGPaletteBuffer starting at X toward aPaletteFading.wDesiredColor.

        sta wR2

        _8EC2
        lda aPaletteFading.wDesiredColor,b
        cmp aBGPaletteBuffer,b,x
        beq _8EDA
        phx
        lda aBGPaletteBuffer,b,x
        tax
        lda aPaletteFading.wCurrentStep,b
        jsl rlDarkenSNESColor
        plx
        sta aBGPaletteBuffer,b,x

        _8EDA
        inc x
        inc x
        dec wR2
        bne _8EC2
        rtl

        .databank 0

        ; 9F/8EE1

    .endsection Unsorted9F8EC0Section


    .section Unsorted9F9090Section

      .as
      .xl

      rlDarkenSNESColor ; 9F/9090

        ; TRACE: stack-args
        .al
        .xl
        .autsiz
        .databank ?

        ; Subtracts each RGB channel of Y from SNES colour X, clamping each channel at 0.

        pha
        pha
        phx
        phy
        lda #1,s
        and #$001F
        tay
        lda #3,s
        and #$001F
        tax
        jsr rsDarkenColorChannel
        sta #7,s
        lda #1,s
        asl a
        asl a
        asl a
        xba
        and #$001F
        tay
        lda #3,s
        asl a
        asl a
        asl a
        xba
        and #$001F
        tax
        jsr rsDarkenColorChannel
        asl a
        asl a
        asl a
        asl a
        asl a
        ora #7,s
        sta #7,s
        lda #1,s
        lsr a
        lsr a
        xba
        and #$001F
        tay
        lda #3,s
        lsr a
        lsr a
        xba
        and #$001F
        tax
        jsr rsDarkenColorChannel
        asl a
        asl a
        xba
        ora #7,s
        sta #7,s
        ply
        plx
        pla
        pla
        rtl

        .databank 0

        ; 9F/90E6

      rsDarkenColorChannel ; 9F/90E6

        .al
        .xl
        .autsiz
        .databank ?

        phy
        txa
        sec
        sbc #1,s
        bpl _90F0
        lda #$0000

        _90F0
        ply
        rts

        .databank 0

        ; 9F/90F2

    .endsection Unsorted9F9090Section


    .section Unsorted9F90F2Section

      .al
      .xl

      rlDarkenMapMagicColors ; 9F/90F2

        .al
        .xl
        .autsiz
        .databank ?

        ; Long wrapper for rsDarkenMapMagicColors.

        jsr rsDarkenMapMagicColors
        rtl

        .databank 0

        ; 9F/90F6

      rlFadeBackMapMagicColors ; 9F/90F6

        .al
        .xl
        .autsiz
        .databank ?

        ; Long wrapper for rsFadeBackMapMagicColors.

        jsr rsFadeBackMapMagicColors
        rtl

        .databank 0

        ; 9F/90FA

      rlSaveMapMagicColors ; 9F/90FA

        .al
        .xl
        .autsiz
        .databank ?

        ; Long wrapper for rsSaveMapMagicColors.

        jsr rsSaveMapMagicColors
        rtl

        .databank 0

        ; 9F/90FE

    .endsection Unsorted9F90F2Section


    .section Unsorted9F90FESection

      .al
      .xl

      rsRestoreMapMagicColors ; 9F/90FE

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced. Copies 80 colours from $7ED000 to aBGPaletteBuffer+$20.

        jsl rlCopyRAMColorsToPaletteBuffer

          .byte $00, $D0, $7E, $50, $00, $20, $00

        rts

        .databank 0

        ; 9F/910A

    .endsection Unsorted9F90FESection


    .section Unsorted9F910ASection

      .al
      .xl

      rsSaveMapMagicColors ; 9F/910A

        .al
        .xl
        .autsiz
        .databank ?

        ; Saves 80 colours from aBGPaletteBuffer+$20 to $7ED000.

        jsl rlSavePaletteBufferColorsToRAM

          .byte $00, $D0, $7E, $50, $00, $20, $00

        rts

        .databank 0

        ; 9F/9116

      rsDarkenMapMagicColors ; 9F/9116

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 12 effects.
        ; Fades aMapMagicBackgroundPaletteRanges to black over 16 steps.

        lda #$0000
        ldy #$0010
        bra rsFadeMapMagicColorsToColor

        .databank 0

      rsFadeMapMagicColorsAllChannels ; 9F/911E

        .al
        .xl
        .autsiz
        .databank ?

        sta aPaletteFading.wDesiredColor,b
        tya
        sta aPaletteFading,b
        clc
        jml rsFadeMapMagicColorRangesRGB

        .databank 0

      rsFadeMapMagicColorsToColor ; 9F/912A

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 12 effects.

        sta aPaletteFading.wDesiredColor,b
        tya
        sta aPaletteFading,b
        sec
        jml rsFadeMapMagicBackgroundPalettes

        .databank 0

      rsTintMapMagicColorsRed ; 9F/9136

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Bolganone and Valflame effects.

        lda #$0007
        ldy #$000E
        sta aPaletteFading.wDesiredColor,b
        tya
        sta aPaletteFading,b
        clc
        jml rsFadeMapMagicColorRangesGB

        .databank 0

      rsTintMapMagicColorsBlue ; 9F/9148

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0007
        ldy #$0014
        sta aPaletteFading.wDesiredColor,b
        tya
        sta aPaletteFading,b
        clc
        jml rsFadeMapMagicColorRangesRG

        .databank 0

      rsTintMapMagicColorsGreen ; 9F/915A

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        lda #$0007
        ldy #$000E
        sta aPaletteFading.wDesiredColor,b
        tya
        sta aPaletteFading,b
        clc
        jml rsFadeMapMagicColorRangesRB

        .databank 0

      rsFadeMapMagicColorsToWhite ; 9F/916C

        .al
        .xl
        .autsiz
        .databank ?

        ; Fades the colour ranges in aMapMagicBackgroundPaletteRanges to white over 16 steps; carry set when done.

        lda #$7FFF
        sta aPaletteFading.wDesiredColor,b
        lda #$0010
        sta aPaletteFading,b
        clc
        jml rsFadeMapMagicBackgroundPalettes

        .databank 0

      rsFadeMapMagicPalette14ToWhite ; 9F/917D

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7FFF
        sta aPaletteFading.wDesiredColor,b
        lda #$0010
        sta aPaletteFading,b
        clc
        jml rsFadeMapMagicPalette14

        .databank 0

      rsFadeMapMagicPalette14ToBlack ; 9F/918E

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aPaletteFading.wDesiredColor,b
        lda #$0010
        sta aPaletteFading,b
        clc
        jml rsFadeMapMagicPalette14

        .databank 0

      rsFadeBackMapMagicColors ; 9F/919F

        .al
        .xl
        .autsiz
        .databank ?

        ; Fades the colours back to what rsSaveMapMagicColors saved; carry set when done. The effects end with this.

        lda #$0008
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .byte $00, $D0, $50, $00, $20, $00

        rts

        .databank 0

      rsFadeMapMagicBackgroundPalettes ; 9F/91B1

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 13 effects.

        jsl rlFadePaletteToBlack

          .word <>aMapMagicBackgroundPaletteRanges

        rts

        .databank 0

      aMapMagicBackgroundPaletteRanges ; 9F/91B8

        ; Shared by 13 effects.
        .word $0022, $000F, $0042, $000F, $0062, $000F, $0082, $000F, $00A2, $000F, $FFFF

      rsFadeMapMagicColorRangesGB ; 9F/91CE

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Bolganone and Valflame effects.

        jsl rlFadeBGPaletteColorRanges
        .word <>aMapMagicColorRangeGB
        rts

        .databank 0

      aMapMagicColorRangeGB ; 9F/91D5

        ; Shared by the Bolganone and Valflame effects.
        .word $0022, $004F, $0420, $FFFF

      rsFadeMapMagicColorRangesRG ; 9F/91DD

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Tornado effect.

        jsl rlFadeBGPaletteColorRanges
        .word <>aMapMagicColorRangeRG
        rts

        .databank 0

      aMapMagicColorRangeRG ; 9F/91E4

        ; Part of the Tornado effect.
        .word $0022, $004F, $0021, $FFFF

      rsFadeMapMagicColorRangesRB ; 9F/91EC

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        jsl rlFadeBGPaletteColorRanges
        .word <>aMapMagicColorRangeRB
        rts

        .databank 0

      aMapMagicColorRangeRB ; 9F/91F3

        ; Part of the Aura effect.
        .word $0022, $004F, $0401, $FFFF

      rsFadeMapMagicColorRangesRGB ; 9F/91FB

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlFadeBGPaletteColorRanges
        .word <>aMapMagicColorRangeRGB
        rts

        .databank 0

      aMapMagicColorRangeRGB ; 9F/9202

        .word $0022, $004F, $0421, $FFFF

      rsFadeMapMagicPalette14 ; 9F/920A

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlFadePaletteToBlack
        .word <>aMapMagicPalette14Range
        rts

        .databank 0

      aMapMagicPalette14Range ; 9F/9211

        .word $01C2, $000F, $FFFF

        ; 9F/9217

    .endsection Unsorted9F910ASection


