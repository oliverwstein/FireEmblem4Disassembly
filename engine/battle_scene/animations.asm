; Battle animations: the graphics of the battle scenes, by class.
;
; rlUnknown95A247 picks four animation IDs for each combatant from
; aBattleAnimationLookup (206 records: class, weapon category, character,
; gender, then the four IDs) into $7FE1B6-$7FE1B9 and $7FE1BA-$7FE1BD. The second ID selects the combatant's sheet here.

    .section BattleAnimationSheetsSection

      .al
      .xl

      aBattleAnimationSheetIndices ; 97/8039

        ; For each animation ID plus 1, its aBattleAnimationSheets entry
        ; (rsUnknown9584D7).

        .byte $00, $03, $1F, $04, $1F, $05, $05, $06
        .byte $07, $08, $09, $0A, $0B, $0C, $0D, $0E
        .byte $0F, $15, $10, $11, $12, $13, $14, $16
        .byte $17, $18, $19, $1A, $1B, $1C, $1D, $1E
        .byte $1F, $20, $21, $22, $23, $24, $25, $26
        .byte $27, $28, $29, $2A, $2B, $2C, $2D, $03
        .byte $03, $03, $2E, $2F, $30, $31, $32, $33
        .byte $34, $35, $36, $37, $38, $39, $3A, $3D
        .byte $3E, $3F, $3B, $3C, $40, $41, $42, $43
        .byte $44, $45, $46, $47, $48, $49, $4A, $4B
        .byte $4C, $4D, $4E, $4F, $50, $51, $52, $53
        .byte $54, $55, $56, $57, $58, $59, $5A, $5B
        .byte $1F, $1F, $5C, $5D, $5E, $5F, $60, $61

      aBattleAnimationSheets ; 97/80A1

        ; Entries of 5 bytes: compressed 4bpp tiles (the pieces the frames are
        ; built from, decompressed to $7F0000 or $7F6000, one per combatant),
        ; then a patch: an index into the stream table at $97/84B6 whose
        ; stream rsUnknown9590C6 applies over the first, or $FFFF for none
        ; (every entry has $FFFF). Comments: the animation IDs that select the
        ; entry and the classes whose lookup records give those IDs. Sheets
        ; shared by entries are named after the first; entry 0 is a
        ; placeholder pointing into bank $86.

        ; 00: no ID (placeholder)
        .long $868000
        .word $FFFF
        ; 01: no ID
        .long g4bppcBattleAnimationSheet01
        .word $FFFF
        ; 02: no ID
        .long g4bppcBattleAnimationSheet02
        .word $FFFF
        ; 03: IDs $00, $2E, $2F, $30 (Cavalier, LanceKnight, AxeKnight)
        .long g4bppcBattleAnimationSheetCavalier
        .word $FFFF
        ; 04: IDs $02 (BowKnight)
        .long g4bppcBattleAnimationSheetBowKnight
        .word $FFFF
        ; 05: IDs $04, $05 (FreeKnight)
        .long g4bppcBattleAnimationSheetCavalier
        .word $FFFF
        ; 06: IDs $06 (Troubadour)
        .long g4bppcBattleAnimationSheetCavalier
        .word $FFFF
        ; 07: IDs $07 (KnightLord)
        .long g4bppcBattleAnimationSheetKnightLord
        .word $FFFF
        ; 08: IDs $08
        .long g4bppcBattleAnimationSheetKnightLord
        .word $FFFF
        ; 09: IDs $09 (DukeKnight)
        .long g4bppcBattleAnimationSheetDukeKnight
        .word $FFFF
        ; 0A: IDs $0A
        .long g4bppcBattleAnimationSheetDukeKnight
        .word $FFFF
        ; 0B: IDs $0B (MasterKnight)
        .long g4bppcBattleAnimationSheetMasterKnight
        .word $FFFF
        ; 0C: IDs $0C
        .long g4bppcBattleAnimationSheetMasterKnight
        .word $FFFF
        ; 0D: IDs $0D (MasterKnight)
        .long g4bppcBattleAnimationSheetMasterKnight2
        .word $FFFF
        ; 0E: IDs $0E
        .long g4bppcBattleAnimationSheetMasterKnight
        .word $FFFF
        ; 0F: IDs $0F
        .long g4bppcBattleAnimationSheetMasterKnight
        .word $FFFF
        ; 10: IDs $11 (ArchKnight)
        .long g4bppcBattleAnimationSheetArchKnight
        .word $FFFF
        ; 11: IDs $12 (Ranger)
        .long g4bppcBattleAnimationSheetRanger
        .word $FFFF
        ; 12: IDs $13
        .long g4bppcBattleAnimationSheetRanger
        .word $FFFF
        ; 13: IDs $14 (MageKnight)
        .long g4bppcBattleAnimationSheetMageKnight
        .word $FFFF
        ; 14: IDs $15 (GreatKnight)
        .long g4bppcBattleAnimationSheetGreatKnight
        .word $FFFF
        ; 15: IDs $10 (Paladin, PaladinF)
        .long g4bppcBattleAnimationSheetPaladin
        .word $FFFF
        ; 16: IDs $16 (PegasusKnight)
        .long g4bppcBattleAnimationSheetPegasusKnight
        .word $FFFF
        ; 17: IDs $17 (FalconKnight)
        .long g4bppcBattleAnimationSheetFalconKnight
        .word $FFFF
        ; 18: IDs $18 (Dragonrider)
        .long g4bppcBattleAnimationSheetDragonrider
        .word $FFFF
        ; 19: IDs $19 (Dragonknight)
        .long g4bppcBattleAnimationSheetDragonknight
        .word $FFFF
        ; 1A: IDs $1A (Dragonmaster)
        .long g4bppcBattleAnimationSheetDragonmaster
        .word $FFFF
        ; 1B: IDs $1B (Archer)
        .long g4bppcBattleAnimationSheetArcher
        .word $FFFF
        ; 1C: IDs $1C (Archer)
        .long g4bppcBattleAnimationSheetArcher2
        .word $FFFF
        ; 1D: IDs $1D (Myrmidon)
        .long g4bppcBattleAnimationSheetMyrmidon
        .word $FFFF
        ; 1E: IDs $1E (Myrmidon)
        .long g4bppcBattleAnimationSheetMyrmidon2
        .word $FFFF
        ; 1F: IDs $01, $03, $1F, $5F, $60 (Swordmaster)
        .long g4bppcBattleAnimationSheetSwordmaster
        .word $FFFF
        ; 20: IDs $20 (Swordmaster)
        .long g4bppcBattleAnimationSheetSwordmaster2
        .word $FFFF
        ; 21: IDs $21 (Sniper)
        .long g4bppcBattleAnimationSheetSniper
        .word $FFFF
        ; 22: IDs $22 (Sniper)
        .long g4bppcBattleAnimationSheetSniper2
        .word $FFFF
        ; 23: IDs $23 (Hero)
        .long g4bppcBattleAnimationSheetHero
        .word $FFFF
        ; 24: IDs $24 (Hero)
        .long g4bppcBattleAnimationSheetHero2
        .word $FFFF
        ; 25: IDs $25 (General)
        .long g4bppcBattleAnimationSheetGeneral
        .word $FFFF
        ; 26: IDs $26 (General)
        .long g4bppcBattleAnimationSheetGeneral2
        .word $FFFF
        ; 27: IDs $27 (General)
        .long g4bppcBattleAnimationSheetGeneral3
        .word $FFFF
        ; 28: IDs $28 (Emperor)
        .long g4bppcBattleAnimationSheetEmperor
        .word $FFFF
        ; 29: IDs $29 (Emperor)
        .long g4bppcBattleAnimationSheetEmperor2
        .word $FFFF
        ; 2A: IDs $2A (Emperor)
        .long g4bppcBattleAnimationSheetEmperor3
        .word $FFFF
        ; 2B: IDs $2B (Baron)
        .long g4bppcBattleAnimationSheetBaron
        .word $FFFF
        ; 2C: IDs $2C (Baron)
        .long g4bppcBattleAnimationSheetBaron2
        .word $FFFF
        ; 2D: IDs $2D (Baron)
        .long g4bppcBattleAnimationSheetBaron3
        .word $FFFF
        ; 2E: IDs $31 (AxeArmor, SwordArmor)
        .long g4bppcBattleAnimationSheetAxeArmor
        .word $FFFF
        ; 2F: IDs $32 (LanceArmor)
        .long g4bppcBattleAnimationSheetLanceArmor
        .word $FFFF
        ; 30: IDs $33 (BowArmor)
        .long g4bppcBattleAnimationSheetBowArmor
        .word $FFFF
        ; 31: IDs $34 (Barbarian)
        .long g4bppcBattleAnimationSheetBarbarian
        .word $FFFF
        ; 32: IDs $35 (Fighter)
        .long g4bppcBattleAnimationSheetFighter
        .word $FFFF
        ; 33: IDs $36 (Brigand)
        .long g4bppcBattleAnimationSheetBrigand
        .word $FFFF
        ; 34: IDs $37 (Warrior)
        .long g4bppcBattleAnimationSheetWarrior
        .word $FFFF
        ; 35: IDs $38 (Warrior)
        .long g4bppcBattleAnimationSheetWarrior2
        .word $FFFF
        ; 36: IDs $39 (Hunter)
        .long g4bppcBattleAnimationSheetHunter
        .word $FFFF
        ; 37: IDs $3A (Pirate)
        .long g4bppcBattleAnimationSheetPirate
        .word $FFFF
        ; 38: IDs $3B (JuniorLord)
        .long g4bppcBattleAnimationSheetJuniorLord
        .word $FFFF
        ; 39: IDs $3C (WarMage)
        .long g4bppcBattleAnimationSheetWarMage
        .word $FFFF
        ; 3A: IDs $3D (WarMage)
        .long g4bppcBattleAnimationSheet01
        .word $FFFF
        ; 3B: IDs $41 (WarMageF)
        .long g4bppcBattleAnimationSheetWarMageF
        .word $FFFF
        ; 3C: IDs $42 (WarMageF, Sage)
        .long g4bppcBattleAnimationSheet02
        .word $FFFF
        ; 3D: IDs $3E (Prince)
        .long g4bppcBattleAnimationSheetPrince
        .word $FFFF
        ; 3E: IDs $3F (Princess)
        .long g4bppcBattleAnimationSheetPrincess
        .word $FFFF
        ; 3F: IDs $40 (Princess)
        .long g4bppcBattleAnimationSheetPrincess2
        .word $FFFF
        ; 40: IDs $43 (Queen)
        .long g4bppcBattleAnimationSheetQueen
        .word $FFFF
        ; 41: IDs $44 (Dancer)
        .long g4bppcBattleAnimationSheetDancer
        .word $FFFF
        ; 42: IDs $45 (Priest)
        .long g4bppcBattleAnimationSheetPriest
        .word $FFFF
        ; 43: IDs $46 (Priest)
        .long g4bppcBattleAnimationSheetPriest2
        .word $FFFF
        ; 44: IDs $47 (Mage)
        .long g4bppcBattleAnimationSheetMage
        .word $FFFF
        ; 45: IDs $48 (Mage)
        .long g4bppcBattleAnimationSheetMage2
        .word $FFFF
        ; 46: IDs $49 (FireMage)
        .long g4bppcBattleAnimationSheetFireMage
        .word $FFFF
        ; 47: IDs $4A (FireMage)
        .long g4bppcBattleAnimationSheetFireMage2
        .word $FFFF
        ; 48: IDs $4B (ThunderMage)
        .long g4bppcBattleAnimationSheetThunderMage
        .word $FFFF
        ; 49: IDs $4C (ThunderMage)
        .long g4bppcBattleAnimationSheetThunderMage2
        .word $FFFF
        ; 4A: IDs $4D (WindMage)
        .long g4bppcBattleAnimationSheetWindMage
        .word $FFFF
        ; 4B: IDs $4E (WindMage)
        .long g4bppcBattleAnimationSheetWindMage2
        .word $FFFF
        ; 4C: IDs $4F (HighPriest)
        .long g4bppcBattleAnimationSheetHighPriest
        .word $FFFF
        ; 4D: IDs $50 (HighPriest)
        .long g4bppcBattleAnimationSheetHighPriest2
        .word $FFFF
        ; 4E: IDs $51 (Bishop)
        .long g4bppcBattleAnimationSheetBishop
        .word $FFFF
        ; 4F: IDs $52 (Sage)
        .long g4bppcBattleAnimationSheetSage
        .word $FFFF
        ; 50: IDs $53
        .long g4bppcBattleAnimationSheet50
        .word $FFFF
        ; 51: IDs $54 (Sage)
        .long g4bppcBattleAnimationSheetSage2
        .word $FFFF
        ; 52: IDs $55
        .long g4bppcBattleAnimationSheet52
        .word $FFFF
        ; 53: IDs $56 (Bard)
        .long g4bppcBattleAnimationSheetBard
        .word $FFFF
        ; 54: IDs $57 (Priestess)
        .long g4bppcBattleAnimationSheetPriestess
        .word $FFFF
        ; 55: IDs $58 (DarkMage)
        .long g4bppcBattleAnimationSheetDarkMage
        .word $FFFF
        ; 56: IDs $59 (DarkBishop)
        .long g4bppcBattleAnimationSheetDarkBishop
        .word $FFFF
        ; 57: IDs $5A
        .long g4bppcBattleAnimationSheetDarkBishop
        .word $FFFF
        ; 58: IDs $5B (Thief)
        .long g4bppcBattleAnimationSheetThief
        .word $FFFF
        ; 59: IDs $5C (Thief)
        .long g4bppcBattleAnimationSheetThief2
        .word $FFFF
        ; 5A: IDs $5D (Rogue)
        .long g4bppcBattleAnimationSheetRogue
        .word $FFFF
        ; 5B: IDs $5E (Rogue)
        .long g4bppcBattleAnimationSheetRogue2
        .word $FFFF
        ; 5C: IDs $61 (Ballistician)
        .long g4bppcBattleAnimationSheetBallistician
        .word $FFFF
        ; 5D: IDs $62 (IronBallistician)
        .long g4bppcBattleAnimationSheetIronBallistician
        .word $FFFF
        ; 5E: IDs $63 (KillerBallistician)
        .long g4bppcBattleAnimationSheetKillerBallistician
        .word $FFFF
        ; 5F: IDs $64 (GreatBallistician)
        .long g4bppcBattleAnimationSheetGreatBallistician
        .word $FFFF
        ; 60: IDs $65 (DarkPrince)
        .long g4bppcBattleAnimationSheetDarkPrince
        .word $FFFF
        ; 61: IDs $66
        .long g4bppcBattleAnimationSheet61
        .word $FFFF

    .endsection BattleAnimationSheetsSection


    .section BattleAnimationExtrasSection

      .al
      .xl

      aBattleAnimationExtraIndices ; 97/828B

        ; For each third animation ID plus 1, its aBattleAnimationExtras entry
        ; (rsUnknown958400).

        .byte $00, $05, $02, $06, $02, $07, $08, $09
        .byte $0A, $0B, $0C, $0D, $0E, $13, $14, $0F
        .byte $10, $11, $12, $15, $16, $17, $18, $19
        .byte $1A, $1B, $1C, $01, $02, $1D, $1E, $1F
        .byte $20, $05, $21, $22, $23, $24, $25, $26
        .byte $27, $28, $29, $2A, $2B, $2C, $2D, $2E
        .byte $2F, $30, $31, $32, $33, $34, $35, $36
        .byte $37, $38, $39, $3A, $3B, $3C, $3D, $3E
        .byte $02, $02, $3F, $40, $41, $42, $43, $44

      aBattleAnimationExtras ; 97/82D3

        ; Entries of 7 bytes: the VRAM offset (in units of 16 words, added to
        ; $4000 or $5000 by combatant), the number of tiles to copy, the
        ; compressed 4bpp tiles (4 KB: dust, impacts and weapon swings among
        ; them), then a patch index as in aBattleAnimationSheets ($FFFF). Named
        ; after the first class whose third ID selects them; entry 0 is a
        ; placeholder.

        .byte $40, $C0
        .long aChapter07MapEvents+156
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraMyrmidon
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraSwordmaster
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtra03
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtra04
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraCavalier
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraBowKnight
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraFreeKnight
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraTroubadour
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraKnightLord
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraDukeKnight
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraMasterKnight
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraMasterKnight2
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraMasterKnight3
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraMasterKnight4
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraArchKnight
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraRanger
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraMageKnight
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraGreatKnight
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraPaladin
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraPaladinF
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraPegasusKnight
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraFalconKnight
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraDragonrider
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraDragonknight
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraDragonknight2
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraDragonmaster
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraDragonmaster2
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraArcher
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraSniper
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraGeneral
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraEmperor
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraBaron
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraLanceArmor
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraBowArmor
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraBarbarian
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraFighter
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraBrigand
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraWarrior
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraWarrior2
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraHunter
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraPirate
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraJuniorLord
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraWarMage
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraWarMage2
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraPrince
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraPrince
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraQueen
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraDancer
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraPriest
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraMage
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraFireMage
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraThunderMage
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraWindMage
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraHighPriest
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraBishop
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraSage
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraBard
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraPriestess
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraDarkMage
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraDarkBishop
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraThief
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraRogue
        .word $FFFF
        .byte $60, $A0
        .long g4bppcBattleAnimationExtraBallistician
        .word $FFFF
        .byte $60, $A0
        .long g4bppcBattleAnimationExtraIronBallistician
        .word $FFFF
        .byte $60, $A0
        .long g4bppcBattleAnimationExtraKillerBallistician
        .word $FFFF
        .byte $60, $A0
        .long g4bppcBattleAnimationExtraGreatBallistician
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtraDarkPrince
        .word $FFFF
        .byte $80, $80
        .long g4bppcBattleAnimationExtra44
        .word $FFFF

      aBattleAnimationPaletteIndices ; 97/84B6

        ; For each fourth animation ID plus 1, its aBattleAnimationPalettes
        ; entry (rsUnknown95858D).

        .byte $00, $01, $01, $01, $01, $02, $03, $04
        .byte $05, $06, $07, $08, $09, $08, $0A, $0B
        .byte $0C, $0D, $0E, $0F, $10, $11, $12, $14
        .byte $13, $14, $15, $16, $17, $18, $19, $1A
        .byte $1B, $1C, $1D, $01, $1E, $1F, $20, $21
        .byte $22, $23, $24, $2A, $2B, $25, $26, $27
        .byte $28, $29, $2C, $2D, $2E, $2F, $30, $31
        .byte $32, $33, $34, $35, $36, $37, $38, $39
        .byte $3A, $3B, $3C, $3D, $3E, $15, $15, $3F
        .byte $40, $41, $42, $43, $44, $45, $46, $47
        .byte $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
        .byte $50, $51, $52, $53, $54, $55, $56, $57
        .byte $58, $59, $5A, $5B, $5C, $5D, $5E, $5F
        .byte $60, $61, $62

      aBattleAnimationPalettes ; 97/8521

        ; Entries of 4 bytes: the combatant's sprite colours (uncompressed) and
        ; how many bytes to copy, from sprite palette colour 1 ($82 later for
        ; the second combatant): 30 (one palette) or 62 (two).

        .long aChapter09MapEvents+727
        .byte 62
        .long aBattleAnimationPaletteCavalier
        .byte 62
        .long aBattleAnimationPaletteFreeKnight
        .byte 62
        .long aBattleAnimationPaletteTroubadour
        .byte 62
        .long aBattleAnimationPaletteKnightLord
        .byte 62
        .long aBattleAnimationPaletteDukeKnight
        .byte 62
        .long aBattleAnimationPaletteMasterKnight
        .byte 62
        .long aBattleAnimationPaletteMasterKnight2
        .byte 62
        .long aBattleAnimationPalettePaladin
        .byte 62
        .long aBattleAnimationPalettePaladinF
        .byte 62
        .long aBattleAnimationPaletteRanger
        .byte 62
        .long aBattleAnimationPaletteMageKnight
        .byte 62
        .long aBattleAnimationPaletteGreatKnight
        .byte 62
        .long aBattleAnimationPalettePegasusKnight
        .byte 62
        .long aBattleAnimationPalette0E
        .byte 62
        .long aBattleAnimationPaletteDragonrider
        .byte 62
        .long aBattleAnimationPaletteDragonknight
        .byte 62
        .long aBattleAnimationPaletteDragonmaster
        .byte 62
        .long aBattleAnimationPaletteArcher
        .byte 30
        .long aBattleAnimationPaletteMyrmidon
        .byte 30
        .long aBattleAnimationPaletteArcher2
        .byte 30
        .long aBattleAnimationPaletteSwordmaster
        .byte 30
        .long aBattleAnimationPaletteSwordmaster2
        .byte 30
        .long aBattleAnimationPaletteSniper
        .byte 30
        .long aBattleAnimationPaletteSniper2
        .byte 30
        .long aBattleAnimationPaletteHero
        .byte 30
        .long aBattleAnimationPaletteHero2
        .byte 30
        .long aBattleAnimationPaletteGeneral
        .byte 30
        .long aBattleAnimationPaletteEmperor
        .byte 30
        .long aBattleAnimationPaletteBaron
        .byte 30
        .long aBattleAnimationPaletteLanceArmor
        .byte 30
        .long aBattleAnimationPaletteBarbarian
        .byte 30
        .long aBattleAnimationPaletteBrigand
        .byte 30
        .long aBattleAnimationPaletteFighter
        .byte 30
        .long aBattleAnimationPalettePirate
        .byte 30
        .long aBattleAnimationPaletteJuniorLord
        .byte 30
        .long aBattleAnimationPaletteWarMage
        .byte 30
        .long aBattleAnimationPaletteWarMageF
        .byte 30
        .long aBattleAnimationPaletteQueen
        .byte 30
        .long aBattleAnimationPaletteDancer
        .byte 30
        .long aBattleAnimationPalette28
        .byte 30
        .long aBattleAnimationPalettePriest
        .byte 30
        .long aBattleAnimationPalettePrince
        .byte 30
        .long aBattleAnimationPalettePrincess
        .byte 30
        .long aBattleAnimationPaletteMage
        .byte 30
        .long aBattleAnimationPaletteMage2
        .byte 30
        .long aBattleAnimationPaletteFireMage
        .byte 30
        .long aBattleAnimationPaletteThunderMage
        .byte 30
        .long aBattleAnimationPaletteWindMage
        .byte 30
        .long aBattleAnimationPaletteHighPriest
        .byte 30
        .long aBattleAnimationPaletteHighPriest2
        .byte 30
        .long aBattleAnimationPaletteBishop
        .byte 30
        .long aBattleAnimationPaletteSage
        .byte 30
        .long aBattleAnimationPaletteSage2
        .byte 30
        .long aBattleAnimationPaletteSage3
        .byte 30
        .long aBattleAnimationPaletteBard
        .byte 30
        .long aBattleAnimationPalettePriestess
        .byte 30
        .long aBattleAnimationPaletteDarkMage
        .byte 30
        .long aBattleAnimationPaletteDarkBishop
        .byte 30
        .long aBattleAnimationPaletteThief
        .byte 30
        .long aBattleAnimationPaletteThief2
        .byte 30
        .long aBattleAnimationPaletteRogue
        .byte 30
        .long aBattleAnimationPaletteRogue2
        .byte 30
        .long aBattleAnimationPaletteBallistician
        .byte 62
        .long aBattleAnimationPaletteIronBallistician
        .byte 62
        .long aBattleAnimationPaletteKillerBallistician
        .byte 62
        .long aBattleAnimationPaletteGreatBallistician
        .byte 62
        .long aBattleAnimationPaletteDarkPrince
        .byte 30
        .long aBattleAnimationPalette44
        .byte 62
        .long aBattleAnimationPalette45
        .byte 62
        .long aBattleAnimationPalette46
        .byte 62
        .long aBattleAnimationPalette47
        .byte 62
        .long aBattleAnimationPalette48
        .byte 62
        .long aBattleAnimationPalette49
        .byte 30
        .long aBattleAnimationPalette4A
        .byte 62
        .long aBattleAnimationPaletteNaoise
        .byte 62
        .long aBattleAnimationPaletteNaoise2
        .byte 62
        .long aBattleAnimationPaletteAlec
        .byte 62
        .long aBattleAnimationPaletteBeowulf
        .byte 30
        .long aBattleAnimationPaletteBeowulf2
        .byte 30
        .long aBattleAnimationPaletteLeif
        .byte 30
        .long aBattleAnimationPaletteDeimne
        .byte 62
        .long aBattleAnimationPaletteAres
        .byte 30
        .long aBattleAnimationPaletteAres2
        .byte 30
        .long aBattleAnimationPaletteTravantCh05
        .byte 30
        .long aBattleAnimationPaletteFebail
        .byte 30
        .long aBattleAnimationPaletteFebail2
        .byte 30
        .long aBattleAnimationPaletteArthur
        .byte 30
        .long aBattleAnimationPaletteArthur2
        .byte 30
        .long aBattleAnimationPaletteAmid
        .byte 30
        .long aBattleAnimationPaletteAmid2
        .byte 30
        .long aBattleAnimationPaletteDaisy
        .byte 62
        .long aBattleAnimationPaletteDaisy2
        .byte 62
        .long aBattleAnimationPaletteAzelle
        .byte 62
        .long aBattleAnimationPaletteLewyn
        .byte 62
        .long aBattleAnimationPaletteLewyn2
        .byte 62
        .long aBattleAnimationPaletteChulainn
        .byte 62
        .long aBattleAnimationPaletteDew
        .byte 30
        .long aBattleAnimationPaletteFinn
        .byte 30

      aBattleAnimationPaletteOverrides ; 97/86AD

        ; Character, class, then the aBattleAnimationPalettes entry that
        ; character uses in that class instead; $FFFF ends the list.

        .word Lene
        .byte Dancer, $2F
        .word Naoise
        .byte Cavalier, $4B
        .word Naoise
        .byte Paladin, $4C
        .word Alec
        .byte Paladin, $4D
        .word Beowulf
        .byte FreeKnight, $4E
        .word Beowulf
        .byte Ranger, $4F
        .word Leif
        .byte Prince, $50
        .word Deimne
        .byte ArchKnight, $51
        .word Ares
        .byte Cavalier, $52
        .word Ares
        .byte Paladin, $53
        .word Febail
        .byte Archer, $55
        .word Febail
        .byte Sniper, $56
        .word Arthur
        .byte Mage, $57
        .word Arthur
        .byte MageKnight, $58
        .word Amid
        .byte WindMage, $59
        .word Amid
        .byte WarMage, $5A
        .word Daisy
        .byte Thief, $5B
        .word Daisy
        .byte Rogue, $5C
        .word Azelle
        .byte Mage, $5D
        .word Lewyn
        .byte Bard, $5E
        .word Lewyn
        .byte Sage, $5F
        .word Chulainn
        .byte Hero, $60
        .word Dew
        .byte Rogue, $61
        .word Finn
        .byte LanceKnight, $62
        .word AdultFinn
        .byte LanceKnight, $62
        .word Finn
        .byte DukeKnight, $63
        .word AdultFinn
        .byte DukeKnight, $63
        .word Lex
        .byte AxeKnight, $64
        .word Iuchar
        .byte AxeKnight, $64
        .word Lester
        .byte BowKnight, $64
        .word Diarmuid
        .byte Ranger, $65
        .word Jeanne
        .byte Troubadour, $66
        .word Ethlyn
        .byte PaladinF, $67
        .word TravantCh05
        .byte Dragonmaster, $54
        .word TravantCh09
        .byte Dragonmaster, $54
        .word ArionCh09
        .byte Dragonmaster, $54
        .word ArionChFinal
        .byte Dragonmaster, $54
        .word Julia
        .byte Sage, $3B
        .word Ced
        .byte Sage, $68
        .word Hawk
        .byte Sage, $69
        .word $FFFF

    .endsection BattleAnimationExtrasSection


    .section BattleAnimationFramesSection

      .al
      .xl

      aBattleAnimationFrameIndices ; 97/874F

        ; For each first animation ID plus 1, its aBattleAnimationFrameTables
        ; entry (rlUnknown958AB7).

        .byte $00, $0C, $0D, $0E, $0F, $10, $11, $02
        .byte $03, $02, $02, $02, $02, $02, $02, $12
        .byte $13, $14, $15, $16, $17, $03, $02, $02
        .byte $02, $18, $19, $1A, $1B, $1C, $1D, $1E
        .byte $03, $01, $02, $03, $02, $1F, $20, $21
        .byte $22, $23, $24, $25, $02, $02, $06, $07
        .byte $08, $09, $0A, $02, $02, $26, $02, $27
        .byte $28, $29, $2E, $2A, $04, $05, $2E, $2E
        .byte $04, $2A, $04, $05, $04, $05, $01, $04
        .byte $05, $05, $05, $05, $04, $05, $04, $05
        .byte $04, $05, $2A, $05, $04, $05, $04, $05
        .byte $04, $05, $0B, $02, $02, $2B, $2C, $2D

      aBattleAnimationFrameTables ; 97/87AF

        ; Two pointers per entry, to $0C25 and $0C36: the sequence data block
        ; (sequences and frame records) and the frame table (which slices of
        ; the class sheet each frame loads). Both are in data/battle_animation/,
        ; formats in include/BattleAnimation.h. Entry 0 is a placeholder
        ; (its pointers land in dialogue text).

        .long dialogueChapterPrologueWorldMap3+228, dialogueChapterPrologueWorldMap1
        .long aBattleAnimationSequencesMyrmidonSword, aBattleAnimationFramesMyrmidonSword
        .long aBattleAnimationSequencesSwordmasterSword, aBattleAnimationFramesSwordmasterSword
        .long aBattleAnimationSequencesArcherBow, aBattleAnimationFramesArcherBow
        .long aBattleAnimationSequencesPrincessStaff, aBattleAnimationFramesPrincessStaff
        .long aBattleAnimationSequencesWarMageMagic, aBattleAnimationFramesPrincessStaff
        .long aBattleAnimationSequencesUnknown06, aBattleAnimationFramesUnknown06
        .long aBattleAnimationSequencesUnknown07, aBattleAnimationFramesUnknown07
        .long aBattleAnimationSequencesUnknown08, aBattleAnimationFramesUnknown07
        .long aBattleAnimationSequencesUnknown09, aBattleAnimationFramesUnknown06
        .long aBattleAnimationSequencesUnknown10, aBattleAnimationFramesUnknown10
        .long aBattleAnimationSequencesDancerSword, aBattleAnimationFramesDancerSword
        .long aBattleAnimationSequencesCavalierSword, aBattleAnimationFramesCavalierSword
        .long aBattleAnimationSequencesCavalierLance, aBattleAnimationFramesCavalierLance
        .long aBattleAnimationSequencesCavalierRangedLance, aBattleAnimationFramesCavalierLance
        .long aBattleAnimationSequencesAxeKnightRangedAxe, aBattleAnimationFramesCavalierSword
        .long aBattleAnimationSequencesBowKnightBow, aBattleAnimationFramesBowKnightBow
        .long aBattleAnimationSequencesTroubadourStaff, aBattleAnimationFramesCavalierSword
        .long aBattleAnimationSequencesKnightLordSword, aBattleAnimationFramesKnightLordSword
        .long aBattleAnimationSequencesKnightLordLance, aBattleAnimationFramesKnightLordSword
        .long aBattleAnimationSequencesKnightLordRangedLance, aBattleAnimationFramesKnightLordSword
        .long aBattleAnimationSequencesMasterKnightRangedAxe, aBattleAnimationFramesKnightLordSword
        .long aBattleAnimationSequencesMasterKnightStaff, aBattleAnimationFramesKnightLordSword
        .long aBattleAnimationSequencesMasterKnightMagic, aBattleAnimationFramesKnightLordSword
        .long aBattleAnimationSequencesPegasusKnightSword, aBattleAnimationFramesPegasusKnightSword
        .long aBattleAnimationSequencesPegasusKnightLance, aBattleAnimationFramesPegasusKnightLance
        .long aBattleAnimationSequencesPegasusKnightRangedLance, aBattleAnimationFramesPegasusKnightRangedLance
        .long aBattleAnimationSequencesFalconKnightStaff, aBattleAnimationFramesFalconKnightStaff
        .long aBattleAnimationSequencesDragonriderSword, aBattleAnimationFramesDragonriderSword
        .long aBattleAnimationSequencesDragonriderLance, aBattleAnimationFramesDragonriderLance
        .long aBattleAnimationSequencesDragonriderRangedLance, aBattleAnimationFramesDragonriderRangedLance
        .long aBattleAnimationSequencesGeneralSword, aBattleAnimationFramesGeneralSword
        .long aBattleAnimationSequencesGeneralLance, aBattleAnimationFramesGeneralLance
        .long aBattleAnimationSequencesGeneralRangedLance, aBattleAnimationFramesGeneralRangedLance
        .long aBattleAnimationSequencesGeneralRangedAxe, aBattleAnimationFramesGeneralSword
        .long aBattleAnimationSequencesGeneralBow, aBattleAnimationFramesGeneralBow
        .long aBattleAnimationSequencesEmperorStaff, aBattleAnimationFramesEmperorStaff
        .long aBattleAnimationSequencesEmperorMagic, aBattleAnimationFramesEmperorMagic
        .long aBattleAnimationSequencesBowArmorBow, aBattleAnimationFramesBowArmorBow
        .long aBattleAnimationSequencesBarbarianAxe, aBattleAnimationFramesBarbarianAxe
        .long aBattleAnimationSequencesBarbarianRangedAxe, aBattleAnimationFramesBarbarianAxe
        .long aBattleAnimationSequencesWarriorBow, aBattleAnimationFramesWarriorBow
        .long aBattleAnimationSequencesWarMageSword, aBattleAnimationFramesWarMageSword
        .long aBattleAnimationSequencesBallisticianBow, aBattleAnimationFramesBallisticianBow
        .long aBattleAnimationSequencesDarkPrinceMagic, aBattleAnimationFramesDarkPrinceMagic
        .long aBattleAnimationSequencesDancerDance, aBattleAnimationFramesDancerDance
        .long aBattleAnimationSequencesJuniorLordSword, aBattleAnimationFramesJuniorLordSword

      aBattleAnimationLookup ; 97/88C9

        ; The four animation IDs of each combatant (rlUnknown95A2C8, for both
        ; through rlUnknown95A247). The search takes the first record of the
        ; combatant's class whose gender, character (unless AnimAnyCharacter)
        ; and category (unless the combatant's is AnimCategoryAny) match. When a
        ; class has records but none matches, it keeps the previous record
        ; (_A378, which reads this table less 4); a class with no records gets
        ; the first record's IDs. rlUnknown95A3C1 replaces the search for a
        ; dancing Dancer.

        .structBattleAnimationLookupEntry Cavalier, AnimCategorySword, AnimAnyCharacter, GenderMale, $00, $00, $00, $00
        .structBattleAnimationLookupEntry Cavalier, AnimCategoryLance, AnimAnyCharacter, GenderMale, $01, $00, $00, $00
        .structBattleAnimationLookupEntry Cavalier, AnimCategoryRangedLance, AnimAnyCharacter, GenderMale, $02, $00, $00, $00
        .structBattleAnimationLookupEntry Cavalier, AnimCategorySword, AnimAnyCharacter, GenderFemale, $00, $00, $00, $00
        .structBattleAnimationLookupEntry Cavalier, AnimCategoryLance, AnimAnyCharacter, GenderFemale, $01, $00, $00, $00
        .structBattleAnimationLookupEntry Cavalier, AnimCategoryRangedLance, AnimAnyCharacter, GenderFemale, $02, $00, $00, $00
        .structBattleAnimationLookupEntry LanceKnight, AnimCategoryLance, AnimAnyCharacter, GenderMale, $01, $00, $00, $00
        .structBattleAnimationLookupEntry LanceKnight, AnimCategoryRangedLance, AnimAnyCharacter, GenderMale, $02, $00, $00, $00
        .structBattleAnimationLookupEntry LanceKnight, AnimCategoryLance, AnimAnyCharacter, GenderFemale, $01, $00, $00, $00
        .structBattleAnimationLookupEntry LanceKnight, AnimCategoryRangedLance, AnimAnyCharacter, GenderFemale, $02, $00, $00, $00
        .structBattleAnimationLookupEntry BowKnight, AnimCategoryBow, AnimAnyCharacter, GenderMale, $04, $02, $02, $00
        .structBattleAnimationLookupEntry BowKnight, AnimCategoryBow, AnimAnyCharacter, GenderFemale, $04, $02, $02, $00
        .structBattleAnimationLookupEntry AxeKnight, AnimCategoryAxe, AnimAnyCharacter, GenderMale, $00, $00, $00, $00
        .structBattleAnimationLookupEntry AxeKnight, AnimCategoryRangedAxe, AnimAnyCharacter, GenderMale, $03, $00, $00, $00
        .structBattleAnimationLookupEntry AxeKnight, AnimCategoryAxe, AnimAnyCharacter, GenderFemale, $00, $00, $00, $00
        .structBattleAnimationLookupEntry AxeKnight, AnimCategoryRangedAxe, AnimAnyCharacter, GenderFemale, $03, $00, $00, $00
        .structBattleAnimationLookupEntry FreeKnight, AnimCategorySword, AnimAnyCharacter, GenderMale, $00, $05, $04, $04
        .structBattleAnimationLookupEntry Troubadour, AnimCategorySword, AnimAnyCharacter, GenderFemale, $00, $06, $05, $05
        .structBattleAnimationLookupEntry Troubadour, AnimCategoryStaff, AnimAnyCharacter, GenderFemale, $05, $06, $05, $05
        .structBattleAnimationLookupEntry KnightLord, AnimCategorySword, AnimAnyCharacter, GenderMale, $0E, $07, $06, $06
        .structBattleAnimationLookupEntry KnightLord, AnimCategoryLance, AnimAnyCharacter, GenderMale, $0F, $07, $06, $06
        .structBattleAnimationLookupEntry KnightLord, AnimCategoryRangedLance, AnimAnyCharacter, GenderMale, $10, $07, $06, $06
        .structBattleAnimationLookupEntry DukeKnight, AnimCategoryLance, AnimAnyCharacter, GenderMale, $0F, $09, $07, $07
        .structBattleAnimationLookupEntry DukeKnight, AnimCategoryRangedLance, AnimAnyCharacter, GenderMale, $10, $09, $07, $07
        .structBattleAnimationLookupEntry DukeKnight, AnimCategoryLance, AnimAnyCharacter, GenderFemale, $0F, $09, $07, $07
        .structBattleAnimationLookupEntry DukeKnight, AnimCategoryRangedLance, AnimAnyCharacter, GenderFemale, $10, $09, $07, $07
        .structBattleAnimationLookupEntry MasterKnight, AnimCategorySword, AnimAnyCharacter, GenderMale, $0E, $0B, $08, $08
        .structBattleAnimationLookupEntry MasterKnight, AnimCategoryLance, AnimAnyCharacter, GenderMale, $0F, $0B, $08, $08
        .structBattleAnimationLookupEntry MasterKnight, AnimCategoryAxe, AnimAnyCharacter, GenderMale, $0E, $0B, $08, $08
        .structBattleAnimationLookupEntry MasterKnight, AnimCategoryBow, AnimAnyCharacter, GenderMale, $04, $0D, $09, $08
        .structBattleAnimationLookupEntry MasterKnight, AnimCategoryRangedLance, AnimAnyCharacter, GenderMale, $10, $0B, $08, $08
        .structBattleAnimationLookupEntry MasterKnight, AnimCategoryRangedAxe, AnimAnyCharacter, GenderMale, $11, $0B, $08, $08
        .structBattleAnimationLookupEntry MasterKnight, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $13, $0B, $08, $08
        .structBattleAnimationLookupEntry MasterKnight, AnimCategoryStaff, AnimAnyCharacter, GenderMale, $12, $0B, $08, $08
        .structBattleAnimationLookupEntry MasterKnight, AnimCategorySword, AnimAnyCharacter, GenderFemale, $0E, $0B, $0A, $09
        .structBattleAnimationLookupEntry MasterKnight, AnimCategoryLance, AnimAnyCharacter, GenderFemale, $0F, $0B, $0A, $09
        .structBattleAnimationLookupEntry MasterKnight, AnimCategoryAxe, AnimAnyCharacter, GenderFemale, $0E, $0B, $0A, $09
        .structBattleAnimationLookupEntry MasterKnight, AnimCategoryBow, AnimAnyCharacter, GenderFemale, $04, $0D, $0B, $09
        .structBattleAnimationLookupEntry MasterKnight, AnimCategoryRangedLance, AnimAnyCharacter, GenderFemale, $10, $0B, $0A, $09
        .structBattleAnimationLookupEntry MasterKnight, AnimCategoryRangedAxe, AnimAnyCharacter, GenderFemale, $11, $0B, $0A, $09
        .structBattleAnimationLookupEntry MasterKnight, AnimCategoryMagic, AnimAnyCharacter, GenderFemale, $13, $0B, $0A, $09
        .structBattleAnimationLookupEntry MasterKnight, AnimCategoryStaff, AnimAnyCharacter, GenderFemale, $12, $0B, $0A, $09
        .structBattleAnimationLookupEntry Paladin, AnimCategorySword, AnimAnyCharacter, GenderMale, $0E, $10, $0C, $0A
        .structBattleAnimationLookupEntry Paladin, AnimCategoryLance, AnimAnyCharacter, GenderMale, $0F, $10, $0C, $0A
        .structBattleAnimationLookupEntry Paladin, AnimCategoryRangedLance, AnimAnyCharacter, GenderMale, $10, $10, $0C, $0A
        .structBattleAnimationLookupEntry PaladinF, AnimCategorySword, AnimAnyCharacter, GenderFemale, $0E, $10, $0D, $0B
        .structBattleAnimationLookupEntry PaladinF, AnimCategoryLance, AnimAnyCharacter, GenderFemale, $0F, $10, $0D, $0B
        .structBattleAnimationLookupEntry PaladinF, AnimCategoryRangedLance, AnimAnyCharacter, GenderFemale, $10, $10, $0D, $0B
        .structBattleAnimationLookupEntry PaladinF, AnimCategoryStaff, AnimAnyCharacter, GenderFemale, $12, $10, $0D, $0B
        .structBattleAnimationLookupEntry ArchKnight, AnimCategoryBow, AnimAnyCharacter, GenderMale, $04, $11, $0E, $0A
        .structBattleAnimationLookupEntry ArchKnight, AnimCategoryBow, AnimAnyCharacter, GenderFemale, $04, $11, $0E, $0A
        .structBattleAnimationLookupEntry Ranger, AnimCategorySword, AnimAnyCharacter, GenderMale, $0E, $12, $0F, $0D
        .structBattleAnimationLookupEntry MageKnight, AnimCategorySword, AnimAnyCharacter, GenderMale, $0E, $14, $10, $0E
        .structBattleAnimationLookupEntry MageKnight, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $13, $14, $10, $0E
        .structBattleAnimationLookupEntry MageKnight, AnimCategorySword, AnimAnyCharacter, GenderFemale, $0E, $14, $10, $0E
        .structBattleAnimationLookupEntry MageKnight, AnimCategoryMagic, AnimAnyCharacter, GenderFemale, $13, $14, $10, $0E
        .structBattleAnimationLookupEntry GreatKnight, AnimCategoryAxe, AnimAnyCharacter, GenderMale, $0E, $15, $11, $0F
        .structBattleAnimationLookupEntry GreatKnight, AnimCategoryRangedAxe, AnimAnyCharacter, GenderMale, $11, $15, $11, $0F
        .structBattleAnimationLookupEntry GreatKnight, AnimCategoryAxe, AnimAnyCharacter, GenderFemale, $0E, $15, $11, $0F
        .structBattleAnimationLookupEntry GreatKnight, AnimCategoryRangedAxe, AnimAnyCharacter, GenderFemale, $11, $15, $11, $0F
        .structBattleAnimationLookupEntry PegasusKnight, AnimCategorySword, AnimAnyCharacter, GenderFemale, $18, $16, $12, $10
        .structBattleAnimationLookupEntry PegasusKnight, AnimCategoryLance, AnimAnyCharacter, GenderFemale, $19, $16, $12, $10
        .structBattleAnimationLookupEntry PegasusKnight, AnimCategoryRangedLance, AnimAnyCharacter, GenderFemale, $1A, $16, $12, $10
        .structBattleAnimationLookupEntry FalconKnight, AnimCategorySword, AnimAnyCharacter, GenderFemale, $18, $17, $13, $10
        .structBattleAnimationLookupEntry FalconKnight, AnimCategoryLance, AnimAnyCharacter, GenderFemale, $19, $17, $13, $10
        .structBattleAnimationLookupEntry FalconKnight, AnimCategoryRangedLance, AnimAnyCharacter, GenderFemale, $1A, $17, $13, $10
        .structBattleAnimationLookupEntry FalconKnight, AnimCategoryStaff, AnimAnyCharacter, GenderFemale, $1B, $17, $13, $10
        .structBattleAnimationLookupEntry Dragonrider, AnimCategorySword, AnimAnyCharacter, GenderMale, $1C, $18, $14, $12
        .structBattleAnimationLookupEntry Dragonrider, AnimCategoryLance, AnimAnyCharacter, GenderMale, $1D, $18, $14, $12
        .structBattleAnimationLookupEntry Dragonrider, AnimCategoryRangedLance, AnimAnyCharacter, GenderMale, $1E, $18, $14, $12
        .structBattleAnimationLookupEntry Dragonknight, AnimCategorySword, AnimAnyCharacter, GenderMale, $1C, $19, $15, $12
        .structBattleAnimationLookupEntry Dragonknight, AnimCategoryLance, AnimAnyCharacter, GenderMale, $1D, $19, $15, $12
        .structBattleAnimationLookupEntry Dragonknight, AnimCategoryRangedLance, AnimAnyCharacter, GenderMale, $1E, $19, $15, $12
        .structBattleAnimationLookupEntry Dragonknight, AnimCategorySword, AnimAnyCharacter, GenderFemale, $1C, $19, $16, $13
        .structBattleAnimationLookupEntry Dragonknight, AnimCategoryLance, AnimAnyCharacter, GenderFemale, $1D, $19, $16, $13
        .structBattleAnimationLookupEntry Dragonknight, AnimCategoryRangedLance, AnimAnyCharacter, GenderFemale, $1E, $19, $16, $13
        .structBattleAnimationLookupEntry Dragonmaster, AnimCategorySword, AnimAnyCharacter, GenderMale, $1C, $1A, $17, $12
        .structBattleAnimationLookupEntry Dragonmaster, AnimCategoryLance, AnimAnyCharacter, GenderMale, $1D, $1A, $17, $12
        .structBattleAnimationLookupEntry Dragonmaster, AnimCategoryRangedLance, AnimAnyCharacter, GenderMale, $1E, $1A, $17, $12
        .structBattleAnimationLookupEntry Dragonmaster, AnimCategorySword, AnimAnyCharacter, GenderFemale, $1C, $1A, $18, $14
        .structBattleAnimationLookupEntry Dragonmaster, AnimCategoryLance, AnimAnyCharacter, GenderFemale, $1D, $1A, $18, $14
        .structBattleAnimationLookupEntry Dragonmaster, AnimCategoryRangedLance, AnimAnyCharacter, GenderFemale, $1E, $1A, $18, $14
        .structBattleAnimationLookupEntry Archer, AnimCategoryBow, AnimAnyCharacter, GenderMale, $22, $1B, $19, $15
        .structBattleAnimationLookupEntry Archer, AnimCategoryBow, AnimAnyCharacter, GenderFemale, $22, $1C, $19, $16
        .structBattleAnimationLookupEntry Myrmidon, AnimCategorySword, AnimAnyCharacter, GenderMale, $20, $1D, $1A, $17
        .structBattleAnimationLookupEntry Myrmidon, AnimCategorySword, AnimAnyCharacter, GenderFemale, $20, $1E, $1A, $18
        .structBattleAnimationLookupEntry Swordmaster, AnimCategorySword, AnimAnyCharacter, GenderMale, $21, $1F, $1B, $19
        .structBattleAnimationLookupEntry Swordmaster, AnimCategorySword, AnimAnyCharacter, GenderFemale, $21, $20, $1B, $1A
        .structBattleAnimationLookupEntry Sniper, AnimCategoryBow, AnimAnyCharacter, GenderMale, $22, $21, $1C, $1B
        .structBattleAnimationLookupEntry Sniper, AnimCategoryBow, AnimAnyCharacter, GenderFemale, $22, $22, $1C, $1C
        .structBattleAnimationLookupEntry Hero, AnimCategorySword, AnimAnyCharacter, GenderMale, $21, $23, $1B, $1D
        .structBattleAnimationLookupEntry Hero, AnimCategorySword, AnimAnyCharacter, GenderFemale, $21, $24, $1B, $1E
        .structBattleAnimationLookupEntry General, AnimCategorySword, AnimAnyCharacter, GenderMale, $24, $25, $1D, $1F
        .structBattleAnimationLookupEntry General, AnimCategoryLance, AnimAnyCharacter, GenderMale, $25, $26, $1D, $1F
        .structBattleAnimationLookupEntry General, AnimCategoryAxe, AnimAnyCharacter, GenderMale, $24, $25, $1D, $1F
        .structBattleAnimationLookupEntry General, AnimCategoryBow, AnimAnyCharacter, GenderMale, $28, $27, $1D, $1F
        .structBattleAnimationLookupEntry General, AnimCategoryRangedLance, AnimAnyCharacter, GenderMale, $26, $26, $1D, $1F
        .structBattleAnimationLookupEntry General, AnimCategoryRangedAxe, AnimAnyCharacter, GenderMale, $27, $25, $1D, $1F
        .structBattleAnimationLookupEntry General, AnimCategorySword, AnimAnyCharacter, GenderFemale, $24, $25, $1D, $1F
        .structBattleAnimationLookupEntry General, AnimCategoryLance, AnimAnyCharacter, GenderFemale, $25, $26, $1D, $1F
        .structBattleAnimationLookupEntry General, AnimCategoryAxe, AnimAnyCharacter, GenderFemale, $24, $25, $1D, $1F
        .structBattleAnimationLookupEntry General, AnimCategoryBow, AnimAnyCharacter, GenderFemale, $28, $27, $1D, $1F
        .structBattleAnimationLookupEntry General, AnimCategoryRangedLance, AnimAnyCharacter, GenderFemale, $26, $26, $1D, $1F
        .structBattleAnimationLookupEntry General, AnimCategoryRangedAxe, AnimAnyCharacter, GenderFemale, $27, $25, $1D, $1F
        .structBattleAnimationLookupEntry Emperor, AnimCategorySword, AnimAnyCharacter, GenderMale, $24, $28, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategoryLance, AnimAnyCharacter, GenderMale, $25, $29, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategoryAxe, AnimAnyCharacter, GenderMale, $24, $28, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategoryBow, AnimAnyCharacter, GenderMale, $28, $2A, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategoryRangedLance, AnimAnyCharacter, GenderMale, $26, $29, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategoryRangedAxe, AnimAnyCharacter, GenderMale, $27, $28, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategoryStaff, AnimAnyCharacter, GenderMale, $29, $28, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $2A, $28, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategorySword, AnimAnyCharacter, GenderFemale, $24, $28, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategoryLance, AnimAnyCharacter, GenderFemale, $25, $29, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategoryAxe, AnimAnyCharacter, GenderFemale, $24, $28, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategoryBow, AnimAnyCharacter, GenderFemale, $28, $2A, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategoryRangedLance, AnimAnyCharacter, GenderFemale, $26, $29, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategoryRangedAxe, AnimAnyCharacter, GenderFemale, $27, $28, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategoryStaff, AnimAnyCharacter, GenderMale, $29, $28, $1E, $20
        .structBattleAnimationLookupEntry Emperor, AnimCategoryMagic, AnimAnyCharacter, GenderFemale, $2A, $28, $1E, $20
        .structBattleAnimationLookupEntry Baron, AnimCategorySword, AnimAnyCharacter, GenderMale, $24, $2B, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategoryLance, AnimAnyCharacter, GenderMale, $25, $2C, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategoryAxe, AnimAnyCharacter, GenderMale, $24, $2B, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategoryBow, AnimAnyCharacter, GenderMale, $28, $2D, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategoryRangedLance, AnimAnyCharacter, GenderMale, $26, $2C, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategoryRangedAxe, AnimAnyCharacter, GenderMale, $27, $2B, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategoryStaff, AnimAnyCharacter, GenderMale, $29, $2B, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $2A, $2B, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategorySword, AnimAnyCharacter, GenderFemale, $24, $2B, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategoryLance, AnimAnyCharacter, GenderFemale, $25, $2C, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategoryAxe, AnimAnyCharacter, GenderFemale, $24, $2B, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategoryBow, AnimAnyCharacter, GenderFemale, $28, $2D, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategoryRangedLance, AnimAnyCharacter, GenderFemale, $26, $2C, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategoryRangedAxe, AnimAnyCharacter, GenderFemale, $27, $2B, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategoryStaff, AnimAnyCharacter, GenderFemale, $29, $2B, $1F, $21
        .structBattleAnimationLookupEntry Baron, AnimCategoryMagic, AnimAnyCharacter, GenderFemale, $2A, $2B, $1F, $21
        .structBattleAnimationLookupEntry LanceArmor, AnimCategoryLance, AnimAnyCharacter, GenderMale, $25, $32, $21, $23
        .structBattleAnimationLookupEntry LanceArmor, AnimCategoryRangedLance, AnimAnyCharacter, GenderMale, $26, $32, $21, $23
        .structBattleAnimationLookupEntry AxeArmor, AnimCategoryAxe, AnimAnyCharacter, GenderMale, $24, $31, $21, $23
        .structBattleAnimationLookupEntry AxeArmor, AnimCategoryRangedAxe, AnimAnyCharacter, GenderMale, $27, $31, $21, $23
        .structBattleAnimationLookupEntry BowArmor, AnimCategoryBow, AnimAnyCharacter, GenderMale, $34, $33, $22, $23
        .structBattleAnimationLookupEntry SwordArmor, AnimCategorySword, AnimAnyCharacter, GenderMale, $24, $31, $21, $23
        .structBattleAnimationLookupEntry Barbarian, AnimCategoryAxe, AnimAnyCharacter, GenderMale, $36, $34, $23, $24
        .structBattleAnimationLookupEntry Barbarian, AnimCategoryRangedAxe, AnimAnyCharacter, GenderMale, $37, $34, $23, $24
        .structBattleAnimationLookupEntry Fighter, AnimCategoryAxe, AnimAnyCharacter, GenderMale, $36, $35, $24, $26
        .structBattleAnimationLookupEntry Fighter, AnimCategoryRangedAxe, AnimAnyCharacter, GenderMale, $37, $35, $24, $26
        .structBattleAnimationLookupEntry Brigand, AnimCategoryAxe, AnimAnyCharacter, GenderMale, $36, $36, $25, $25
        .structBattleAnimationLookupEntry Brigand, AnimCategoryRangedAxe, AnimAnyCharacter, GenderMale, $37, $36, $25, $25
        .structBattleAnimationLookupEntry Warrior, AnimCategoryAxe, AnimAnyCharacter, GenderMale, $36, $37, $26, $26
        .structBattleAnimationLookupEntry Warrior, AnimCategoryBow, AnimAnyCharacter, GenderMale, $38, $38, $27, $26
        .structBattleAnimationLookupEntry Warrior, AnimCategoryRangedAxe, AnimAnyCharacter, GenderMale, $37, $37, $26, $26
        .structBattleAnimationLookupEntry Hunter, AnimCategoryBow, AnimAnyCharacter, GenderMale, $38, $39, $28, $24
        .structBattleAnimationLookupEntry Pirate, AnimCategoryAxe, AnimAnyCharacter, GenderMale, $36, $3A, $29, $27
        .structBattleAnimationLookupEntry Pirate, AnimCategoryRangedAxe, AnimAnyCharacter, GenderMale, $37, $3A, $29, $27
        .structBattleAnimationLookupEntry JuniorLord, AnimCategorySword, AnimAnyCharacter, GenderMale, $39, $3B, $2A, $28
        .structBattleAnimationLookupEntry WarMage, AnimCategorySword, AnimAnyCharacter, GenderMale, $3A, $3C, $2B, $29
        .structBattleAnimationLookupEntry WarMage, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $3C, $3D, $2C, $29
        .structBattleAnimationLookupEntry Prince, AnimCategorySword, AnimAnyCharacter, GenderMale, $3D, $3E, $2D, $2A
        .structBattleAnimationLookupEntry Princess, AnimCategorySword, AnimAnyCharacter, GenderFemale, $3E, $3F, $2D, $2B
        .structBattleAnimationLookupEntry Princess, AnimCategoryStaff, AnimAnyCharacter, GenderFemale, $3F, $40, $2E, $2B
        .structBattleAnimationLookupEntry WarMageF, AnimCategorySword, AnimAnyCharacter, GenderFemale, $40, $41, $2B, $2C
        .structBattleAnimationLookupEntry WarMageF, AnimCategoryStaff, AnimAnyCharacter, GenderFemale, $41, $42, $2C, $2C
        .structBattleAnimationLookupEntry WarMageF, AnimCategoryMagic, AnimAnyCharacter, GenderFemale, $42, $42, $2C, $2C
        .structBattleAnimationLookupEntry Queen, AnimCategoryStaff, AnimAnyCharacter, GenderFemale, $43, $43, $2F, $2D
        .structBattleAnimationLookupEntry Queen, AnimCategoryMagic, AnimAnyCharacter, GenderFemale, $44, $43, $2F, $2D
        .structBattleAnimationLookupEntry Dancer, AnimCategorySword, AnimAnyCharacter, GenderFemale, $59, $44, $30, $2E
        .structBattleAnimationLookupEntry Priest, AnimCategoryStaff, AnimAnyCharacter, GenderMale, $46, $45, $31, $30
        .structBattleAnimationLookupEntry Priest, AnimCategoryStaff, AnimAnyCharacter, GenderFemale, $46, $46, $31, $30
        .structBattleAnimationLookupEntry Mage, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $47, $47, $32, $31
        .structBattleAnimationLookupEntry Mage, AnimCategoryMagic, AnimAnyCharacter, GenderFemale, $47, $48, $32, $32
        .structBattleAnimationLookupEntry FireMage, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $48, $49, $33, $33
        .structBattleAnimationLookupEntry FireMage, AnimCategoryMagic, AnimAnyCharacter, GenderFemale, $48, $4A, $33, $33
        .structBattleAnimationLookupEntry ThunderMage, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $49, $4B, $34, $34
        .structBattleAnimationLookupEntry ThunderMage, AnimCategoryMagic, AnimAnyCharacter, GenderFemale, $49, $4C, $34, $34
        .structBattleAnimationLookupEntry WindMage, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $4A, $4D, $35, $35
        .structBattleAnimationLookupEntry WindMage, AnimCategoryMagic, AnimAnyCharacter, GenderFemale, $4A, $4E, $35, $35
        .structBattleAnimationLookupEntry HighPriest, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $4C, $4F, $36, $36
        .structBattleAnimationLookupEntry HighPriest, AnimCategoryStaff, AnimAnyCharacter, GenderMale, $4B, $4F, $36, $36
        .structBattleAnimationLookupEntry HighPriest, AnimCategoryMagic, AnimAnyCharacter, GenderFemale, $4C, $50, $36, $37
        .structBattleAnimationLookupEntry HighPriest, AnimCategoryStaff, AnimAnyCharacter, GenderFemale, $4B, $50, $36, $37
        .structBattleAnimationLookupEntry Bishop, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $4E, $51, $37, $38
        .structBattleAnimationLookupEntry Bishop, AnimCategoryStaff, AnimAnyCharacter, GenderMale, $4D, $51, $37, $38
        .structBattleAnimationLookupEntry Sage, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $42, $52, $38, $39
        .structBattleAnimationLookupEntry Sage, AnimCategoryStaff, AnimAnyCharacter, GenderMale, $41, $52, $38, $39
        .structBattleAnimationLookupEntry Sage, AnimCategoryMagic, Julia, GenderFemale, $42, $54, $2C, $3B
        .structBattleAnimationLookupEntry Sage, AnimCategoryStaff, Julia, GenderFemale, $41, $54, $2C, $3B
        .structBattleAnimationLookupEntry Sage, AnimCategoryMagic, AnimAnyCharacter, GenderFemale, $42, $42, $2C, $3A
        .structBattleAnimationLookupEntry Sage, AnimCategoryStaff, AnimAnyCharacter, GenderFemale, $41, $42, $2C, $3A
        .structBattleAnimationLookupEntry Bard, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $52, $56, $39, $3C
        .structBattleAnimationLookupEntry Priestess, AnimCategoryMagic, AnimAnyCharacter, GenderFemale, $54, $57, $3A, $3D
        .structBattleAnimationLookupEntry Priestess, AnimCategoryStaff, AnimAnyCharacter, GenderFemale, $53, $57, $3A, $3D
        .structBattleAnimationLookupEntry DarkMage, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $56, $58, $3B, $3E
        .structBattleAnimationLookupEntry DarkMage, AnimCategoryStaff, AnimAnyCharacter, GenderMale, $55, $58, $3B, $3E
        .structBattleAnimationLookupEntry DarkBishop, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $58, $59, $3C, $3F
        .structBattleAnimationLookupEntry DarkBishop, AnimCategoryStaff, AnimAnyCharacter, GenderMale, $57, $59, $3C, $3F
        .structBattleAnimationLookupEntry DarkBishop, AnimCategoryMagic, AnimAnyCharacter, GenderFemale, $58, $59, $3C, $3F
        .structBattleAnimationLookupEntry DarkBishop, AnimCategoryStaff, AnimAnyCharacter, GenderFemale, $57, $59, $3C, $3F
        .structBattleAnimationLookupEntry Thief, AnimCategorySword, AnimAnyCharacter, GenderMale, $59, $5B, $3D, $40
        .structBattleAnimationLookupEntry Thief, AnimCategorySword, AnimAnyCharacter, GenderFemale, $59, $5C, $3D, $41
        .structBattleAnimationLookupEntry Rogue, AnimCategorySword, AnimAnyCharacter, GenderMale, $59, $5D, $3E, $42
        .structBattleAnimationLookupEntry Rogue, AnimCategorySword, AnimAnyCharacter, GenderFemale, $59, $5E, $3E, $43
        .structBattleAnimationLookupEntry Ballistician, AnimCategoryBow, AnimAnyCharacter, GenderMale, $5C, $61, $41, $46
        .structBattleAnimationLookupEntry IronBallistician, AnimCategoryBow, AnimAnyCharacter, GenderMale, $5C, $62, $42, $47
        .structBattleAnimationLookupEntry KillerBallistician, AnimCategoryBow, AnimAnyCharacter, GenderMale, $5C, $63, $43, $48
        .structBattleAnimationLookupEntry GreatBallistician, AnimCategoryBow, AnimAnyCharacter, GenderMale, $5C, $64, $44, $49
        .structBattleAnimationLookupEntry DarkPrince, AnimCategoryMagic, AnimAnyCharacter, GenderMale, $5D, $65, $45, $4A

    .endsection BattleAnimationFramesSection


    .section BattleAnimationProgramsSection

      .al
      .xl

      aBattleAnimationMoveRoutines ; 97/C860

        ; Moves below $80 in a combatant's queue run these (rlUnknown95B1AB,
        ; with jsr: the routines are in bank $95).

        .word <>rsUnknown95B250
        .word <>rsUnknown95B28F
        .word <>rsUnknown95B2B2
        .word <>rsUnknown95B2DF
        .word <>rsUnknown95B2E9
        .word <>rsUnknown95B314
        .word <>rsUnknown95B332
        .word <>rsUnknown95B352
        .word <>rsUnknown95B362
        .word <>rsUnknown95B36A
        .word <>rsUnknown95B372
        .word <>rsUnknown95B3AF
        .word <>rsUnknown95B3ED
        .word <>rsUnknown95B431
        .word <>rsUnknown95B475
        .word <>rsUnknown95B48D
        .word <>rsUnknown95B4E0
        .word <>rsUnknown95B519

      aBattleAnimationProgramIndices ; 97/C884

        ; For each first animation ID plus 1, its aBattleAnimationPrograms
        ; entry (rlUnknown95E3FE).

        .byte $00, $0B, $0C, $0D, $0E, $0F, $10, $02
        .byte $0F, $02, $02, $02, $02, $02, $02, $11
        .byte $12, $13, $14, $15, $16, $0F, $02, $02
        .byte $02, $17, $18, $19, $1A, $1B, $1C, $1D
        .byte $1F, $01, $02, $1F, $02, $20, $21, $22
        .byte $23, $24, $25, $26, $02, $02, $05, $06
        .byte $07, $08, $09, $21, $20, $1E, $20, $27
        .byte $28, $29, $2E, $2A, $03, $04, $2E, $2E
        .byte $03, $2A, $03, $04, $03, $04, $0A, $03
        .byte $04, $04, $04, $04, $03, $04, $03, $04
        .byte $03, $04, $2A, $04, $03, $04, $03, $04
        .byte $03, $04, $0A, $0A, $0A, $2B, $2C, $2D

      aBattleAnimationPrograms ; 97/C8E4

        ; Three pointers per entry: the move list table, the action table and
        ; the movement script table (rlUnknown95E3FE), in
        ; data/battle_animation/moves.asm; formats in include/BattleAnimation.h.

        .long dialogueEpilogue_Piece_Leif_End+127, dialogueEpilogue_Piece_Leif_End+63, dialogueEpilogue_Piece_DaisyPatty_LoverDead+256
        .long aBattleAnimationMoveListsMyrmidonSword, aBattleAnimationActionsMyrmidonSword, aBattleAnimationMoveScriptsMyrmidonSword
        .long aBattleAnimationMoveListsSwordmasterSword, aBattleAnimationActionsSwordmasterSword, aBattleAnimationMoveScriptsSwordmasterSword
        .long aBattleAnimationMoveListsPrincessStaff, aBattleAnimationActionsPrincessStaff, aBattleAnimationMoveScriptsPrincessStaff
        .long aBattleAnimationMoveListsWarMageMagic, aBattleAnimationActionsWarMageMagic, aBattleAnimationMoveScriptsWarMageMagic
        .long aBattleAnimationMoveListsUnknown05, aBattleAnimationActionsUnknown05, aBattleAnimationMoveScriptsUnknown05
        .long aBattleAnimationMoveListsUnknown06, aBattleAnimationActionsUnknown06, aBattleAnimationMoveScriptsUnknown06
        .long aBattleAnimationMoveListsUnknown07, aBattleAnimationActionsUnknown07, aBattleAnimationMoveScriptsUnknown07
        .long aBattleAnimationMoveListsUnknown08, aBattleAnimationActionsUnknown08, aBattleAnimationMoveScriptsUnknown08
        .long aBattleAnimationMoveListsUnknown09, aBattleAnimationActionsUnknown09, aBattleAnimationMoveScriptsUnknown09
        .long aBattleAnimationMoveListsDancerSword, aBattleAnimationActionsDancerSword, aBattleAnimationMoveScriptsDancerSword
        .long aBattleAnimationMoveListsCavalierSword, aBattleAnimationActionsCavalierSword, aBattleAnimationMoveScriptsCavalierSword
        .long aBattleAnimationMoveListsCavalierLance, aBattleAnimationActionsCavalierLance, aBattleAnimationMoveScriptsCavalierLance
        .long aBattleAnimationMoveListsCavalierRangedLance, aBattleAnimationActionsCavalierRangedLance, aBattleAnimationMoveScriptsCavalierRangedLance
        .long aBattleAnimationMoveListsAxeKnightRangedAxe, aBattleAnimationActionsAxeKnightRangedAxe, aBattleAnimationMoveScriptsAxeKnightRangedAxe
        .long aBattleAnimationMoveListsBowKnightBow, aBattleAnimationActionsBowKnightBow, aBattleAnimationMoveScriptsBowKnightBow
        .long aBattleAnimationMoveListsTroubadourStaff, aBattleAnimationActionsTroubadourStaff, aBattleAnimationMoveScriptsTroubadourStaff
        .long aBattleAnimationMoveListsKnightLordSword, aBattleAnimationActionsKnightLordSword, aBattleAnimationMoveScriptsKnightLordSword
        .long aBattleAnimationMoveListsKnightLordLance, aBattleAnimationActionsKnightLordLance, aBattleAnimationMoveScriptsKnightLordLance
        .long aBattleAnimationMoveListsKnightLordRangedLance, aBattleAnimationActionsKnightLordRangedLance, aBattleAnimationMoveScriptsKnightLordRangedLance
        .long aBattleAnimationMoveListsMasterKnightRangedAxe, aBattleAnimationActionsMasterKnightRangedAxe, aBattleAnimationMoveScriptsMasterKnightRangedAxe
        .long aBattleAnimationMoveListsMasterKnightStaff, aBattleAnimationActionsMasterKnightStaff, aBattleAnimationMoveScriptsMasterKnightStaff
        .long aBattleAnimationMoveListsMasterKnightMagic, aBattleAnimationActionsMasterKnightMagic, aBattleAnimationMoveScriptsMasterKnightMagic
        .long aBattleAnimationMoveListsPegasusKnightSword, aBattleAnimationActionsPegasusKnightSword, aBattleAnimationMoveScriptsPegasusKnightSword
        .long aBattleAnimationMoveListsPegasusKnightLance, aBattleAnimationActionsPegasusKnightLance, aBattleAnimationMoveScriptsPegasusKnightLance
        .long aBattleAnimationMoveListsPegasusKnightRangedLance, aBattleAnimationActionsPegasusKnightRangedLance, aBattleAnimationMoveScriptsPegasusKnightRangedLance
        .long aBattleAnimationMoveListsFalconKnightStaff, aBattleAnimationActionsFalconKnightStaff, aBattleAnimationMoveScriptsFalconKnightStaff
        .long aBattleAnimationMoveListsDragonriderSword, aBattleAnimationActionsDragonriderSword, aBattleAnimationMoveScriptsDragonriderSword
        .long aBattleAnimationMoveListsDragonriderLance, aBattleAnimationActionsDragonriderLance, aBattleAnimationMoveScriptsDragonriderLance
        .long aBattleAnimationMoveListsDragonriderRangedLance, aBattleAnimationActionsDragonriderRangedLance, aBattleAnimationMoveScriptsDragonriderRangedLance
        .long aBattleAnimationMoveListsBowArmorBow, aBattleAnimationActionsBowArmorBow, aBattleAnimationMoveScriptsBowArmorBow
        .long aBattleAnimationMoveListsArcherBow, aBattleAnimationActionsArcherBow, aBattleAnimationMoveScriptsArcherBow
        .long aBattleAnimationMoveListsGeneralSword, aBattleAnimationActionsGeneralSword, aBattleAnimationMoveScriptsGeneralSword
        .long aBattleAnimationMoveListsGeneralLance, aBattleAnimationActionsGeneralLance, aBattleAnimationMoveScriptsGeneralLance
        .long aBattleAnimationMoveListsGeneralRangedLance, aBattleAnimationActionsGeneralRangedLance, aBattleAnimationMoveScriptsGeneralRangedLance
        .long aBattleAnimationMoveListsGeneralRangedAxe, aBattleAnimationActionsGeneralRangedAxe, aBattleAnimationMoveScriptsGeneralRangedAxe
        .long aBattleAnimationMoveListsGeneralBow, aBattleAnimationActionsGeneralBow, aBattleAnimationMoveScriptsGeneralBow
        .long aBattleAnimationMoveListsEmperorStaff, aBattleAnimationActionsEmperorStaff, aBattleAnimationMoveScriptsEmperorStaff
        .long aBattleAnimationMoveListsEmperorMagic, aBattleAnimationActionsEmperorMagic, aBattleAnimationMoveScriptsEmperorMagic
        .long aBattleAnimationMoveListsBarbarianAxe, aBattleAnimationActionsBarbarianAxe, aBattleAnimationMoveScriptsBarbarianAxe
        .long aBattleAnimationMoveListsBarbarianRangedAxe, aBattleAnimationActionsBarbarianRangedAxe, aBattleAnimationMoveScriptsBarbarianRangedAxe
        .long aBattleAnimationMoveListsWarriorBow, aBattleAnimationActionsWarriorBow, aBattleAnimationMoveScriptsWarriorBow
        .long aBattleAnimationMoveListsWarMageSword, aBattleAnimationActionsWarMageSword, aBattleAnimationMoveScriptsWarMageSword
        .long aBattleAnimationActionsDarkPrinceMagic, aBattleAnimationActionsBallisticianBow, aBattleAnimationActionsDarkPrinceMagic
        .long aBattleAnimationMoveListsDarkPrinceMagic, aBattleAnimationActionsDarkPrinceMagic, aBattleAnimationMoveScriptsDarkPrinceMagic
        .long aBattleAnimationMoveListsDancerDance, aBattleAnimationActionsDancerDance, aBattleAnimationMoveScriptsDancerDance
        .long aBattleAnimationMoveListsJuniorLordSword, aBattleAnimationActionsJuniorLordSword, aBattleAnimationMoveScriptsJuniorLordSword

    .endsection BattleAnimationProgramsSection


    .section BattleCharacterPiecesSection

      .al
      .xl

      aBattleCharacterPieceLookup ; 99/8194

        ; Read by rlUnknown95881F for rlUnknown958798: for each class with
        ; character-specific pieces, the offset of its list ($FFFF for none).
        ; A list gives character and value, then $FFFF and the value for any
        ; other character. A value is (palette << 8) | piece: the piece is an
        ; aBattleCharacterPieces stream ($300 bytes copied to VRAM), the
        ; palette 9 colours at aBattleCharacterPiecePalette (from $E0/1368,
        ; 18 bytes apart) copied to sprite palette colour 1; values 0 and 1
        ; mean none.

        .byte Cavalier
        .word aBattleCharacterPieceListCavalier - aBattleCharacterPieceLookup
        .byte LanceKnight
        .word aBattleCharacterPieceListLanceKnight - aBattleCharacterPieceLookup
        .byte AxeKnight
        .word aBattleCharacterPieceListAxeKnight - aBattleCharacterPieceLookup
        .byte FreeKnight
        .word aBattleCharacterPieceListFreeKnight - aBattleCharacterPieceLookup
        .byte Troubadour
        .word aBattleCharacterPieceListTroubadour - aBattleCharacterPieceLookup
        .byte KnightLord
        .word aBattleCharacterPieceListKnightLord - aBattleCharacterPieceLookup
        .byte DukeKnight
        .word aBattleCharacterPieceListDukeKnight - aBattleCharacterPieceLookup
        .byte MasterKnight
        .word aBattleCharacterPieceListMasterKnight - aBattleCharacterPieceLookup
        .byte Paladin
        .word aBattleCharacterPieceListPaladin - aBattleCharacterPieceLookup
        .byte PaladinF
        .word aBattleCharacterPieceListPaladin - aBattleCharacterPieceLookup
        .byte Ranger
        .word aBattleCharacterPieceListRanger - aBattleCharacterPieceLookup
        .byte MageKnight
        .word aBattleCharacterPieceListMageKnight - aBattleCharacterPieceLookup
        .byte GreatKnight
        .word aBattleCharacterPieceListGreatKnight - aBattleCharacterPieceLookup
        .byte General
        .word aBattleCharacterPieceListGeneral - aBattleCharacterPieceLookup
        .byte Emperor
        .word aBattleCharacterPieceListEmperor - aBattleCharacterPieceLookup
        .byte Baron
        .word aBattleCharacterPieceListBaron - aBattleCharacterPieceLookup
        .byte LanceArmor
        .word aBattleCharacterPieceListLanceArmor - aBattleCharacterPieceLookup
        .byte AxeArmor
        .word aBattleCharacterPieceListAxeArmor - aBattleCharacterPieceLookup
        .byte SwordArmor
        .word aBattleCharacterPieceListSwordArmor - aBattleCharacterPieceLookup
        .byte PegasusRider
        .word $FFFF
        .byte PegasusKnight
        .word $FFFF
        .byte FalconKnight
        .word $FFFF
        .byte Dragonrider
        .word $FFFF
        .byte Dragonknight
        .word $FFFF
        .byte Dragonmaster
        .word $FFFF
        .byte Ballistician
        .word $FFFF
        .byte IronBallistician
        .word $FFFF
        .byte KillerBallistician
        .word $FFFF
        .byte GreatBallistician
        .word $FFFF
        .word $FFFF

      aBattleCharacterPieceListCavalier ; 99/81ED

        .word Alec, $0206 ; piece 6, palette 2
        .word Naoise, $0306 ; piece 6, palette 3
        .word Ares, $0506 ; piece 6, palette 5
        .word $FFFF
        .word $0406 ; any other character: piece 6, palette 4

      aBattleCharacterPieceListLanceKnight ; 99/81FD

        .word Finn, $1108 ; piece 8, palette 17
        .word AdultFinn, $1108 ; piece 8, palette 17
        .word $FFFF
        .word $1208 ; any other character: piece 8, palette 18

      aBattleCharacterPieceListAxeKnight ; 99/8209

        .word Lex, $190A ; piece 10, palette 25
        .word Iuchar, $190A ; piece 10, palette 25
        .word $FFFF
        .word $040A ; any other character: piece 10, palette 4

      aBattleCharacterPieceListFreeKnight ; 99/8215

        .word Diarmuid, $0607 ; piece 7, palette 6
        .word Tristan, $0607 ; piece 7, palette 6
        .word Beowulf, $0607 ; piece 7, palette 6
        .word $FFFF
        .word $0707 ; any other character: piece 7, palette 7

      aBattleCharacterPieceListTroubadour ; 99/8225

        .word Jeanne, $0309 ; piece 9, palette 3
        .word Nanna, $0309 ; piece 9, palette 3
        .word Ethlyn, $0209 ; piece 9, palette 2
        .word $FFFF
        .word $0409 ; any other character: piece 9, palette 4

      aBattleCharacterPieceListKnightLord ; 99/8235

        .word $FFFF
        .word $0800 ; any other character: piece 0, palette 8

      aBattleCharacterPieceListDukeKnight ; 99/8239

        .word Quan, $0B02 ; piece 2, palette 11
        .word Finn, $0902 ; piece 2, palette 9
        .word AdultFinn, $0902 ; piece 2, palette 9
        .word $FFFF
        .word $0C02 ; any other character: piece 2, palette 12

      aBattleCharacterPieceListMasterKnight ; 99/8249

        .word Lachesis, $0901 ; piece 1, palette 9
        .word Leif, $0901 ; piece 1, palette 9
        .word $FFFF
        .word $0A01 ; any other character: piece 1, palette 10

      aBattleCharacterPieceListPaladin ; 99/8255

        .word EldiganCh01, $1011 ; piece 17, palette 16
        .word EldiganCh03, $1011 ; piece 17, palette 16
        .word Ares, $130B ; piece 11, palette 19
        .word $FFFF
        .word $0F04 ; any other character: piece 4, palette 15

      aBattleCharacterPieceListRanger ; 99/8265

        .word Diarmuid, $0607 ; piece 7, palette 6
        .word Tristan, $0607 ; piece 7, palette 6
        .word Beowulf, $0607 ; piece 7, palette 6
        .word $FFFF
        .word $0707 ; any other character: piece 7, palette 7

      aBattleCharacterPieceListMageKnight ; 99/8275

        .word Azelle, $0005 ; piece 5, palette 0
        .word $FFFF
        .word $0105 ; any other character: piece 5, palette 1

      aBattleCharacterPieceListGreatKnight ; 99/827D

        .word Lex, $0D03 ; piece 3, palette 13
        .word Iuchar, $0D03 ; piece 3, palette 13
        .word $FFFF
        .word $0E03 ; any other character: piece 3, palette 14

      aBattleCharacterPieceListGeneral ; 99/8289

        .word Arden, $1810 ; piece 16, palette 24
        .word Hannibal, $1810 ; piece 16, palette 24
        .word $FFFF
        .word $160D ; any other character: piece 13, palette 22

      aBattleCharacterPieceListEmperor ; 99/8295

        .word $FFFF
        .word $170F ; any other character: piece 15, palette 23

      aBattleCharacterPieceListBaron ; 99/8299

        .word $FFFF
        .word $150E ; any other character: piece 14, palette 21

      aBattleCharacterPieceListLanceArmor ; 99/829D

        .word $FFFF
        .word $140C ; any other character: piece 12, palette 20

      aBattleCharacterPieceListAxeArmor ; 99/82A1

        .word $FFFF
        .word $140C ; any other character: piece 12, palette 20

      aBattleCharacterPieceListSwordArmor ; 99/82A5

        .word Arden, $150C ; piece 12, palette 21
        .word $FFFF
        .word $140C ; any other character: piece 12, palette 20

      aBattleCharacterPieces ; 99/82AD

        ; Compressed 4bpp tiles, 1 KB each, named after the first character
        ; (or class default) that uses them.

        .long g4bppcBattleCharacterPieceKnightLord
        .long g4bppcBattleCharacterPieceLachesis
        .long g4bppcBattleCharacterPieceQuan
        .long g4bppcBattleCharacterPieceLex2
        .long g4bppcBattleCharacterPiecePaladin
        .long g4bppcBattleCharacterPieceAzelle
        .long g4bppcBattleCharacterPieceAlec
        .long g4bppcBattleCharacterPieceDiarmuid
        .long g4bppcBattleCharacterPieceFinn
        .long g4bppcBattleCharacterPieceJeanne
        .long g4bppcBattleCharacterPieceLex
        .long g4bppcBattleCharacterPieceAres
        .long g4bppcBattleCharacterPieceLanceArmor
        .long g4bppcBattleCharacterPieceGeneral
        .long g4bppcBattleCharacterPieceBaron
        .long g4bppcBattleCharacterPieceEmperor
        .long g4bppcBattleCharacterPieceArden
        .long g4bppcBattleCharacterPieceEldiganCh01

    .endsection BattleCharacterPiecesSection


    .section BattleWeaponGraphicsSection

      .al
      .xl

      aBattleWeaponGraphicsIndices ; 99/8725

        ; For each item ID, read by rlUnknown958697: the aBattleWeaponGraphics
        ; stream (1 KB, copied to VRAM) and the palette: 15 colours from
        ; $E0/0F30, 30 bytes apart, copied to sprite palette colour 1. $FF,
        ; $FF: no weapon graphics.

        .byte $00, $00 ; IronSword
        .byte $01, $00 ; SteelSword
        .byte $02, $01 ; SilverSword
        .byte $00, $00 ; IronBlade
        .byte $01, $00 ; SteelBlade
        .byte $02, $01 ; SilverBlade
        .byte $04, $03 ; MiracleSword
        .byte $03, $02 ; ThiefSword
        .byte $05, $03 ; BarrierBlade
        .byte $06, $02 ; BerserkSword
        .byte $07, $03 ; BraveSword
        .byte $08, $05 ; SilenceSword
        .byte $09, $01 ; SleepSword
        .byte $0A, $00 ; SlimSword
        .byte $0B, $04 ; Safeguard
        .byte $0C, $06 ; FireSword
        .byte $0D, $02 ; EarthSword
        .byte $0E, $04 ; ThunderSword
        .byte $0F, $01 ; WindSword
        .byte $11, $03 ; LightBrand
        .byte $13, $02 ; Mystletainn
        .byte $14, $04 ; Tyrfing
        .byte $10, $04 ; Balmung
        .byte $15, $02 ; Armorslayer
        .byte $16, $05 ; Wingclipper
        .byte $17, $00 ; BrokenSwordA
        .byte $17, $00 ; BrokenSwordB
        .byte $17, $00 ; BrokenSwordC
        .byte $18, $07 ; IronLance
        .byte $19, $07 ; SteelLance
        .byte $1A, $08 ; SilverLance
        .byte $1B, $09 ; Javelin
        .byte $1C, $0A ; Ridersbane
        .byte $1D, $0B ; BraveLance
        .byte $1B, $09 ; SlimLance
        .byte $1E, $0C ; Gungnir
        .byte $1F, $0D ; GaeBolg
        .byte $20, $0E ; BrokenLanceA
        .byte $20, $0E ; BrokenLanceB
        .byte $20, $0E ; BrokenLanceC
        .byte $21, $0F ; IronAxe
        .byte $22, $10 ; SteelAxe
        .byte $23, $11 ; SilverAxe
        .byte $25, $13 ; BraveAxe
        .byte $26, $14 ; Helswath
        .byte $24, $12 ; HandAxe
        .byte $27, $0F ; BrokenAxeA
        .byte $27, $0F ; BrokenAxeB
        .byte $27, $0F ; BrokenAxeC
        .byte $28, $16 ; IronBow
        .byte $29, $17 ; SteelBow
        .byte $2A, $17 ; SilverBow
        .byte $2B, $18 ; BraveBow
        .byte $2C, $16 ; KillerBow
        .byte $2D, $18 ; Yewfelle
        .byte $2E, $15 ; BrokenBowA
        .byte $2E, $15 ; BrokenBowB
        .byte $2E, $15 ; BrokenBowC
        .byte $3D, $19 ; Ballista
        .byte $3E, $1A ; IronBallista
        .byte $3F, $1B ; KillerBallista
        .byte $40, $1C ; GreatBallista
        .byte $FF, $FF ; Fire
        .byte $FF, $FF ; Elfire
        .byte $FF, $FF ; Bolganone
        .byte $FF, $FF ; Valflame
        .byte $FF, $FF ; Meteor
        .byte $FF, $FF ; Thunder
        .byte $FF, $FF ; Elthunder
        .byte $FF, $FF ; Thoron
        .byte $FF, $FF ; Mjolnir
        .byte $FF, $FF ; Bolting
        .byte $FF, $FF ; Wind
        .byte $FF, $FF ; Elwind
        .byte $FF, $FF ; Tornado
        .byte $FF, $FF ; Forseti
        .byte $FF, $FF ; Blizzard
        .byte $FF, $FF ; Light
        .byte $FF, $FF ; Nosferatu
        .byte $FF, $FF ; Aura
        .byte $FF, $FF ; Naga
        .byte $FF, $FF ; Jormungandr
        .byte $FF, $FF ; Fenrir
        .byte $FF, $FF ; Hel
        .byte $FF, $FF ; Loptous
        .byte $FF, $FF ; BrokenFireTomeA
        .byte $FF, $FF ; BrokenFireTomeB
        .byte $FF, $FF ; BrokenFireTomeC
        .byte $2F, $1D ; HealStaff
        .byte $2F, $22 ; MendStaff
        .byte $2F, $23 ; RecoverStaff
        .byte $30, $1D ; PhysicStaff
        .byte $31, $1D ; Fortify
        .byte $33, $1E ; ReturnStaff
        .byte $32, $1E ; WarpStaff
        .byte $34, $1E ; RescueStaff
        .byte $35, $1F ; CharmStaff
        .byte $36, $1F ; RestoreStaff
        .byte $3B, $1D ; ValkyrieStaff
        .byte $39, $20 ; SilenceStaff
        .byte $37, $1F ; SleepStaff
        .byte $38, $1F ; BerserkStaff
        .byte $3A, $21 ; ThiefStaff
        .byte $3C, $1D ; BrokenStaffA
        .byte $3C, $1D ; BrokenStaffB
        .byte $3C, $1D ; BrokenStaffC
        .byte $FF, $FF ; RenewalBand
        .byte $FF, $FF ; ParagonBand
        .byte $FF, $FF ; ThiefBand
        .byte $FF, $FF ; MiracleBand
        .byte $FF, $FF ; PursuitRing
        .byte $FF, $FF ; RecoverRing
        .byte $FF, $FF ; BargainBand
        .byte $FF, $FF ; KnightRing
        .byte $FF, $FF ; ReturnBand
        .byte $FF, $FF ; SpeedRing
        .byte $FF, $FF ; MagicRing
        .byte $FF, $FF ; PowerRing
        .byte $FF, $FF ; ShieldRing
        .byte $FF, $FF ; BarrierRing
        .byte $FF, $FF ; LegRing
        .byte $FF, $FF ; SkillRing
        .byte $17, $00 ; BrokenHolySword
        .byte $20, $0E ; BrokenHolyLance
        .byte $2E, $15 ; BrokenHolyBow

      aBattleWeaponGraphics ; 99/881F

        ; Compressed 4bpp tiles, named after the first item that uses them.

        .long g4bppcBattleWeaponIronSword
        .long g4bppcBattleWeaponSteelSword
        .long g4bppcBattleWeaponSilverSword
        .long g4bppcBattleWeaponThiefSword
        .long g4bppcBattleWeaponMiracleSword
        .long g4bppcBattleWeaponBarrierBlade
        .long g4bppcBattleWeaponBerserkSword
        .long g4bppcBattleWeaponBraveSword
        .long g4bppcBattleWeaponSilenceSword
        .long g4bppcBattleWeaponSleepSword
        .long g4bppcBattleWeaponSlimSword
        .long g4bppcBattleWeaponSafeguard
        .long g4bppcBattleWeaponFireSword
        .long g4bppcBattleWeaponEarthSword
        .long g4bppcBattleWeaponThunderSword
        .long g4bppcBattleWeaponWindSword
        .long g4bppcBattleWeaponBalmung
        .long g4bppcBattleWeaponLightBrand
        .long g4bppcBattleWeapon12
        .long g4bppcBattleWeaponMystletainn
        .long g4bppcBattleWeaponTyrfing
        .long g4bppcBattleWeaponArmorslayer
        .long g4bppcBattleWeaponWingclipper
        .long g4bppcBattleWeaponBrokenSwordA
        .long g4bppcBattleWeaponIronLance
        .long g4bppcBattleWeaponSteelLance
        .long g4bppcBattleWeaponSilverLance
        .long g4bppcBattleWeaponJavelin
        .long g4bppcBattleWeaponRidersbane
        .long g4bppcBattleWeaponBraveLance
        .long g4bppcBattleWeaponGungnir
        .long g4bppcBattleWeaponGaeBolg
        .long g4bppcBattleWeaponBrokenLanceA
        .long g4bppcBattleWeaponIronAxe
        .long g4bppcBattleWeaponSteelAxe
        .long g4bppcBattleWeaponSilverAxe
        .long g4bppcBattleWeaponHandAxe
        .long g4bppcBattleWeaponBraveAxe
        .long g4bppcBattleWeaponHelswath
        .long g4bppcBattleWeaponBrokenAxeA
        .long g4bppcBattleWeaponIronBow
        .long g4bppcBattleWeaponSteelBow
        .long g4bppcBattleWeaponSilverBow
        .long g4bppcBattleWeaponBraveBow
        .long g4bppcBattleWeaponKillerBow
        .long g4bppcBattleWeaponYewfelle
        .long g4bppcBattleWeaponBrokenBowA
        .long g4bppcBattleWeaponHealStaff
        .long g4bppcBattleWeaponPhysicStaff
        .long g4bppcBattleWeaponFortify
        .long g4bppcBattleWeaponWarpStaff
        .long g4bppcBattleWeaponReturnStaff
        .long g4bppcBattleWeaponRescueStaff
        .long g4bppcBattleWeaponCharmStaff
        .long g4bppcBattleWeaponRestoreStaff
        .long g4bppcBattleWeaponSleepStaff
        .long g4bppcBattleWeaponBerserkStaff
        .long g4bppcBattleWeaponSilenceStaff
        .long g4bppcBattleWeaponThiefStaff
        .long g4bppcBattleWeaponValkyrieStaff
        .long g4bppcBattleWeaponBrokenStaffA
        .long g4bppcBattleWeaponBallista
        .long g4bppcBattleWeaponIronBallista
        .long g4bppcBattleWeaponKillerBallista
        .long g4bppcBattleWeaponGreatBallista

    .endsection BattleWeaponGraphicsSection

    .section BattleAnimationSoundEffectsSection

      .al
      .xl

      aBattleAnimationSoundEffects ; 98/ACC0

        ; The sound effect of each ANIM_SOUND index (rsUnknown95BD10), played
        ; with rlPlaySoundEffect2 at the combatant's position. 34 entries: the
        ; sequences use indices up to 33, and the battle scene script's own
        ; table follows at $98/AD04.

        .word $008C, $008E, $008C, $008C, $006D, $0047, $008C, $008C
        .word $004A, $004B, $0070, $0049, $006C, $0004, $004D, $008C
        .word $0011, $0012, $0013, $0017, $001D, $001E, $001F, $0015
        .word $0016, $0018, $0019, $000A, $0014, $008C, $008C, $008C
        .word $0001, $004F

    .endsection BattleAnimationSoundEffectsSection
