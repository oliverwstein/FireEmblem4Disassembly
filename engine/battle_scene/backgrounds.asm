; Battle backgrounds: the scenery behind a battle scene, by terrain, and the
; foreground layers drawn over it for some pairs of terrains.
; rlGetBattleBackgroundPointers and rsBattleSceneLoadForeground (bank $95) load them.

    .section BattleBackgroundsSection

      .al
      .xl

      aBattleBackgrounds ; 98/A900

        ; Entries of 10 bytes: compressed 4bpp tiles, a compressed 64x32
        ; tilemap, a palette of 48 colours (the game copies 47 of them, from
        ; palette 3 colour 1), and a flag whose bit 0 is copied to bit 0 of
        ; $7FE1B3. Odd entries are the snowy versions used in chapter 4.
        ; Entry $16 is not chosen by any terrain; entry $17 is the class change
        ; background, used instead of the terrain's when wBattleType is 2.
        ; $00: Plains
        ; $01: PlainsSnow
        ; $02: Road
        ; $03: RoadSnow
        ; $04: Sand
        ; $05: SandSnow
        ; $06: Desert
        ; $07: Thicket
        ; $08: Mountain
        ; $09: MountainSnow
        ; $0A: Sea
        ; $0B: SeaSnow
        ; $0C: Forest
        ; $0D: ForestSnow
        ; $0E: River
        ; $0F: RiverSnow
        ; $10: Castle
        ; $11: CastleSnow
        ; $12: Village
        ; $13: VillageSnow
        ; $14: Bridge
        ; $15: Shrine
        ; $16: Unused16
        ; $17: Unused17

        .long g4bppcBattleBackgroundPlains, acBattleBackgroundPlainsTilemap, aBattleBackgroundPlainsPalette
        .byte 1
        .long g4bppcBattleBackgroundPlains, acBattleBackgroundPlainsTilemap, aBattleBackgroundPlainsSnowPalette
        .byte 1
        .long g4bppcBattleBackgroundRoad, acBattleBackgroundRoadTilemap, aBattleBackgroundRoadPalette
        .byte 1
        .long g4bppcBattleBackgroundRoad, acBattleBackgroundRoadTilemap, aBattleBackgroundRoadSnowPalette
        .byte 1
        .long g4bppcBattleBackgroundSand, acBattleBackgroundSandTilemap, aBattleBackgroundSandPalette
        .byte 1
        .long g4bppcBattleBackgroundSand, acBattleBackgroundSandTilemap, aBattleBackgroundSandSnowPalette
        .byte 1
        .long g4bppcBattleBackgroundSand, acBattleBackgroundSandTilemap, aBattleBackgroundDesertPalette
        .byte 1
        .long g4bppcBattleBackgroundThicket, acBattleBackgroundThicketTilemap, aBattleBackgroundThicketPalette
        .byte 0
        .long g4bppcBattleBackgroundMountain, acBattleBackgroundMountainTilemap, aBattleBackgroundMountainPalette
        .byte 1
        .long g4bppcBattleBackgroundMountain, acBattleBackgroundMountainTilemap, aBattleBackgroundMountainSnowPalette
        .byte 1
        .long g4bppcBattleBackgroundSea, acBattleBackgroundSeaTilemap, aBattleBackgroundSeaPalette
        .byte 0
        .long g4bppcBattleBackgroundSea, acBattleBackgroundSeaTilemap, aBattleBackgroundSeaSnowPalette
        .byte 0
        .long g4bppcBattleBackgroundForest, acBattleBackgroundForestTilemap, aBattleBackgroundForestPalette
        .byte 0
        .long g4bppcBattleBackgroundForest, acBattleBackgroundForestTilemap, aBattleBackgroundForestSnowPalette
        .byte 0
        .long g4bppcBattleBackgroundRiver, acBattleBackgroundRiverTilemap, aBattleBackgroundRiverPalette
        .byte 0
        .long g4bppcBattleBackgroundRiver, acBattleBackgroundRiverTilemap, aBattleBackgroundRiverSnowPalette
        .byte 0
        .long g4bppcBattleBackgroundCastle, acBattleBackgroundCastleTilemap, aBattleBackgroundCastlePalette
        .byte 0
        .long g4bppcBattleBackgroundCastle, acBattleBackgroundCastleTilemap, aBattleBackgroundCastleSnowPalette
        .byte 0
        .long g4bppcBattleBackgroundVillage, acBattleBackgroundVillageTilemap, aBattleBackgroundVillagePalette
        .byte 1
        .long g4bppcBattleBackgroundVillage, acBattleBackgroundVillageTilemap, aBattleBackgroundVillageSnowPalette
        .byte 1
        .long g4bppcBattleBackgroundBridge, acBattleBackgroundBridgeTilemap, aBattleBackgroundBridgePalette
        .byte 1
        .long g4bppcBattleBackgroundShrine, acBattleBackgroundShrineTilemap, aBattleBackgroundShrinePalette
        .byte 0
        .long g4bppcBattleBackgroundUnused16, acBattleBackgroundUnused16Tilemap, aBattleBackgroundUnused16Palette
        .byte 0
        .long g4bppcBattleBackgroundUnused17, acBattleBackgroundUnused17Tilemap, aBattleBackgroundUnused17Palette
        .byte 0

      aBattleBackgroundTerrainIndices ; 98/A9F0

        ; The aBattleBackgrounds entry for each terrain type, then the same
        ; for chapter 4 (rlBattleSceneCheckChapter4), which uses the snowy versions.

        .byte $08 ; Peak
        .byte $07 ; Thicket
        .byte $00 ; Cliff
        .byte $00 ; Plains
        .byte $0C ; Forest
        .byte $0A ; Sea
        .byte $0E ; River
        .byte $08 ; Mountain
        .byte $06 ; Desert
        .byte $10 ; Castle
        .byte $10 ; Fort
        .byte $12 ; House
        .byte $10 ; CastleGate
        .byte $10 ; Rampart
        .byte $04 ; Sand
        .byte $14 ; Bridge
        .byte $0E ; Swamp
        .byte $04 ; CastleGate2
        .byte $12 ; Village
        .byte $04 ; VillageRuins
        .byte $04 ; Store
        .byte $04 ; Ruins2
        .byte $04 ; Church
        .byte $15 ; Shrine
        .byte $00 ; BragiTower
        .byte $02 ; Road
        .byte $09 ; Peak (chapter 4)
        .byte $07 ; Thicket (chapter 4)
        .byte $01 ; Cliff (chapter 4)
        .byte $01 ; Plains (chapter 4)
        .byte $0D ; Forest (chapter 4)
        .byte $0B ; Sea (chapter 4)
        .byte $0F ; River (chapter 4)
        .byte $09 ; Mountain (chapter 4)
        .byte $06 ; Desert (chapter 4)
        .byte $11 ; Castle (chapter 4)
        .byte $11 ; Fort (chapter 4)
        .byte $13 ; House (chapter 4)
        .byte $11 ; CastleGate (chapter 4)
        .byte $11 ; Rampart (chapter 4)
        .byte $05 ; Sand (chapter 4)
        .byte $14 ; Bridge (chapter 4)
        .byte $0F ; Swamp (chapter 4)
        .byte $05 ; CastleGate2 (chapter 4)
        .byte $13 ; Village (chapter 4)
        .byte $05 ; VillageRuins (chapter 4)
        .byte $05 ; Store (chapter 4)
        .byte $05 ; Ruins2 (chapter 4)
        .byte $05 ; Church (chapter 4)
        .byte $15 ; Shrine (chapter 4)
        .byte $01 ; BragiTower (chapter 4)
        .byte $03 ; Road (chapter 4)

      aBattleForegrounds ; 98/AA24

        ; Entries of 12 bytes: compressed 4bpp tiles (to VRAM $4000 or $5000,
        ; by the mode in aBattleForegroundTerrainPairs), two compressed 32x32
        ; tilemaps and 16 colours. rsBattleSceneLoadForeground draws Tilemap2 (to VRAM
        ; $7800) in palette 2; the code at 95/8F51 draws Tilemap1 (to $7000)
        ; in palette 1.

        .long g4bppcBattleForeground1, acBattleForeground1Tilemap1, acBattleForeground1Tilemap2, aBattleForeground1Palette
        .long g4bppcBattleForeground2, acBattleForeground2Tilemap1, acBattleForeground2Tilemap2, aBattleForeground2Palette
        .long g4bppcDialogueBackgroundFountainForeground, acBattleForeground3Tilemap1, acBattleForeground3Tilemap2, aBattleForeground3Palette
        .long g4bppcBattleForeground4, acBattleForeground4Tilemap1, acBattleForeground4Tilemap2, aBattleForeground4Palette
        .long g4bppcBattleForeground5, acBattleForeground5Tilemap1, acBattleForeground5Tilemap2, aBattleForeground5Palette
        .long g4bppcDialogueBackgroundFountainForeground, acBattleForeground3Tilemap1, acBattleForeground3Tilemap2, aBattleForeground6Palette

      aBattleForegroundTerrainPairs ; 98/AA6C

        ; Read by rsBattleSceneGetForeground: the attacker's terrain, the defender's
        ; terrain ($FE matches any; chapter 4 adds 26, as above), then a word:
        ; the low byte is the aBattleForegrounds entry plus 1 (0 for none) and
        ; the high byte a mode. $FF ends the list.

        .byte $04, $04, $03, $03
        .byte $01, $01, $03, $03
        .byte $04, $12, $03, $03
        .byte $01, $12, $03, $03
        .byte $FE, $12, $05, $05
        .byte $08, $04, $00, $01
        .byte $04, $08, $01, $00
        .byte $04, $03, $03, $03
        .byte $04, $0E, $01, $01
        .byte $04, $19, $01, $01
        .byte $1E, $1E, $06, $06
        .byte $2C, $1E, $06, $06
        .byte $1E, $1D, $06, $06
        .byte $FF

    .endsection BattleBackgroundsSection
