; Battle animations: the graphics of the battle scenes, by class.
;
; rlUnknown95A247 picks four animation IDs for each combatant from the table at
; $97/88C9 (206 records of 8 bytes: class, weapon category from the table at
; $99/83B9, character (0 for any), a value from class and gender, then the four
; IDs) into $7FE1BA-$7FE1BD. The second ID selects the combatant's sheet here.

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
