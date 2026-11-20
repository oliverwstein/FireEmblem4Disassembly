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
