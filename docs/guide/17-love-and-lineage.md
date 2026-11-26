# Chapter 17: Love and Lineage

> *"One generation passes away, and another generation comes;
> But the earth abides forever."* — Ecclesiastes 1:4

*Genealogy of the Holy War* splits its campaign in half. Over the first five chapters, nine playable women can pair off with fifteen men; at the start of Chapter 6, the first generation is removed from RAM and replaced by up to seventeen second-generation children whose growths, base stats, skills, Holy Blood, gold, and inventories derive from whom their mothers married. Fourteen of those children have static substitutes waiting in the wings if a mother died or stayed unmarried. The engine solves this without keeping dead parents in memory: it tracks affection in a compact 9 × 15 grid during gameplay, computes every child's derived record once at the generation boundary, and frees the parents' pools.

This chapter covers the love system and its turn-start growth bug, the Chapter 5 memorial and Chapter 6 generation transfer, how each child's stats, blood, skills, and inventory are built, and the limits of that design.

## The love system

### Mechanics and the 9 × 15 grid

Every eligible player character carries a **generation ID** (`1..15` for men, `16..24` for women) and a **love data ID** indexing the love tables. Love points between any woman and any man run from `0` to `500`, with `$FFFF` marking an incompatible pair—siblings, Sigurd and Quan with any woman other than their canon wives, and fixed second-generation characters such as Altena, Hannibal, and Adult Finn.

Because only nine women are eligible in each generation, the engine stores all active love points on the women's side. Each female player unit allocates a 30-byte `structLoverDataRAM` block in `aLoverRAMArea` (`$7E/3BD7`): fifteen 16-bit words, one per male generation ID `1..15`. Men allocate no lover block (`LoverData = 0`).

```
aUnitRAMArea (female, GenID 16..24)        aLoverRAMArea (9 × 30 bytes)
┌───────────────────────────┐              ┌─────────────────────────────┐
│ Personal.LoverGenerationID│              │ [0]: GenID 1  (Sigurd/Seliph)│
│ Personal.LoveDataID       │              │ [1]: GenID 2  (Naoise/...)   │
│ LoverData ────────────────┼─────────────►│ ...                         │
└───────────────────────────┘              │ [14]: GenID 15 (Dew/Oifey)  │
                                           └─────────────────────────────┘
```

When a pair's points reach `500`, `rlModifyUnitsLovePoints` clamps the entry to `500` and calls `rlSetUnitsAsLoversByGenerationIDs`: it writes each partner's `GenerationID` into the other's `LoverGenerationID` field and fires event action `$11` (`Arg1 = female`, `Arg2 = male`; [Chapter 11](11-the-game-is-watching.md)) so chapter events can trigger lover conversations. Married women skip all further love-point updates.

### Base and growth tables

Four CSV-backed tables in bank `$83`—[Gen1LoveBases.csv](../../data/character/Gen1LoveBases.csv), [Gen1LoveGrowths.csv](../../data/character/Gen1LoveGrowths.csv), [Gen2LoveBases.csv](../../data/character/Gen2LoveBases.csv), and [Gen2LoveGrowths.csv](../../data/character/Gen2LoveGrowths.csv)—supply starting values and per-turn rates, indexed through `aMaleLoveDataIDs`, `aFemaleLoveDataIDs`, `aLoveBaseOffsets`, and `aLoveGrowthOffsets`:

| Raw byte | Decoded base (`rlGetUnitLoveBaseWithTarget`) | Meaning |
|---|---|---|
| `$FF` (`-1`) | `$FFFF` | Incompatible; `rlModifyUnitsLovePoints` ignores updates |
| `$FE` (`-2`) | `499` | Pre-paired (Deirdre–Sigurd and Ethlyn–Quan, paired with `+1` growth) |
| `0..49` | `byte * 10` | Starting love points |

`rlGetUnitLoveGrowthWithTarget` sign-extends the growth byte from `aLoveGrowthOffsets`, so negative growths are legal (`rlModifyUnitsLovePoints` clamps subtractions at `0`). In Generation 2, Julia and Seliph start at base `490` with growth `-5`, and siblings or incompatible pairs likewise carry `-5` growth so adjacency bonuses cannot push them toward marriage.

### Turn-start growth and the jealousy bug

At the start of every player phase before turn 51 (`wCurrentTurn < 51`), `rlAddTurnStartLovePoints` in [engine/units/factions.asm](../../engine/units/factions.asm) updates love points in two passes:

1. **Global per-turn growth (`rsAddLoveGrowthWithEachMan`):** `rlListFactionSlotUnitsByGenerationID` maps all `FS_Player` units into a 24-word table at `$7E/2000` indexed by `GenID - 1`. For each living woman in slots `16..24`, the routine adds her table growth against every man present in slots `1..15`.
2. **Adjacency bonus (`rsAddAdjacentLovePoints`):** Walks `aDeploymentTable` backwards for living deployed women (`GenID >= $10`), scanning every living `FS_Player` unit at Manhattan distance `< 2` and adding `6 - distance` (`+5` at distance 1).

A missing register restore in `rsAddAdjacentLovePoints` creates the well-known **jealousy bug**:

```rust
fn add_adjacent_love_points(woman_slot: usize) {            // rsAddAdjacentLovePoints
    for neighbor in (0..72).rev() {
        if !neighbor.alive() || neighbor.faction != FS_Player { continue; }
        let dist = units_distance(woman_slot, neighbor);
        if dist >= 2 { continue; }
        let bonus = 6 - dist;                               // +5 at distance 1
        let saved_woman = wSelectedUnitDataRAMPointer;      // saved in Y
        wSelectedUnitDataRAMPointer = neighbor.unit_ptr;
        let gen_id = selected_unit_generation_id();
        if gen_id >= 0x10 {
            // BUG: branches to next loop iteration WITHOUT restoring wSelectedUnitDataRAMPointer!
            // (When neighbor == woman_slot at dist == 0, it sets the pointer back to her.)
            continue;
        }
        wSelectedUnitDataRAMPointer = saved_woman;
        modify_love_points(gen_id, bonus);                  // rlModifyUnitsLovePoints
    }
}
```

When an adjacent neighbor is another woman (`GenID >= $10`), the branch jumps past `sty wSelectedUnitDataRAMPointer,b` straight to the next iteration. `wSelectedUnitDataRAMPointer` remains pointing at that neighboring woman for every subsequent man found in the backwards deployment-table scan, awarding the `+5` adjacency points to her instead. A smaller off-by-one bug also sits in `rsInitUnitLoverData` ([engine/units/unit_creation.asm](../../engine/units/unit_creation.asm)), which loops 16 times (`wR0 = $10`) across the 15 male entries.

## Crossing the generation gap

### The Chapter 5 memorial

After Arvis attacks Sigurd at the end of Chapter 5, `procFirstGenerationEnding` (`"MS"` in [engine/events/first_generation_ending.asm](../../engine/events/first_generation_ending.asm)) pauses map animations, clears `wGameStateRoutine1` to `0`—causing world map portrait helpers to divert to `rlLoadFirstGenerationEndingPortrait` and `rlFadeOutFirstGenerationEndingPortrait`—and scrolls `dialogueEpilogueMemorial88E9E5` over the map. Per-character ASMCs inspect each unit's Chapter 5 event flags to list those who fell in battle separately from those whose fate is unknown.

### Chapter 6 transition

When Chapter 6 begins, `rlResetUnitsForChapter` ([engine/units/generations.asm](../../engine/units/generations.asm)) executes three steps to cross the generation boundary:

1. **Snapshot parent fates (`rlSetParentsPermanentFlags`):** Before any parent is deleted, [engine/epilogue/endings.asm](../../engine/epilogue/endings.asm) records two permanent flags for every Generation 1 character (`Sigurd`..`Brigid`, IDs `1..24`, stopping before `Seliph`): flag `CharID + 40` if recruited, and flag `CharID + 64` if alive. The epilogue reads these flags later because the parent records themselves will no longer exist.
2. **Replace parents with children (`rlDeleteParentsAndModifyChildrenData`):** Walks `aModifyChildrenDataList` in strict order:
   - **Mothers first** (`Deirdre`, `Ethlyn`, `Brigid`, `Edain`, `Silvia`, `Tailtiu`, `Erinys`, `Ayra`, `Lachesis`): calls `rlLoadChildUnit` (Deirdre spawns only her son `Seliph`; the other eight spawn both son and daughter), then deletes the mother. Running mothers before fathers guarantees both parent records are still intact in RAM when each child is computed.
   - **Fathers next** (`Dew`..`Sigurd`): deleted by `rsDeleteParentUnitData`, with one exception—`Finn` runs `rsTransferUnitToGen2`, which halves his gold, repoints `ConstantData` to `AdultFinn`, clears `LoverGenerationID`, re-initializes lover data, and undeploys him. If Finn married, his child already inherited his inventory during the mother's pass; if unmarried, he keeps his items.
   - **Story overrides last:** `rsOverwriteSeliphUnitData` adds `UnitSkill1Dismount`, overwrites `HolyBlood1` to `MajorBaldrBlood | MinorNagaBlood` and `HolyBlood2` to `0` (stripping the Minor Loptous blood raw inheritance would give him from Deirdre), and sets 2 leadership stars; `rsOverwriteAltenaUnitData` sets 3 leadership stars.
3. **Reset shop stock:** Scans `aItemRAMData` and calls `rlRevertItemAcquirement` on every `ItemStateShop` and `ItemStatePawnbroker` item, returning unsold Generation 1 stock to `ItemStateUnobtained`.

Inside `rlLoadChildUnit`, `Ethlyn` and `Deirdre` bypass the `UnitStateDead` check so `Seliph`, `Leif`, and `Altena` are always born. For the other seven mothers, a dead mother produces no children. Otherwise, if `LoverGenerationID` is nonzero and `< GEN_ID_Ethlyn` and the father's record exists in `aUnitRAMPointers` (dead fathers who were married still sire children), `rlLoadUnit` builds the child and sets its flag in `aChildrenPermanentFlags` (`PermanentFlagDiarmuidExists`..`PermanentFlagPattyExists`).

### Substitutes

All born children live in `aDynamicUnitRAMArea` (17 slots) from the start of Chapter 6, undeployed until their recruitment events. Fourteen of them have static substitutes (`Dalvin` for `Scathach`, `Creidne` for `Larcei`, `Asaello` for `Febail`, and so on). When a chapter loads a unit group, `rsLoadUnitGroupTryReplaceCharacterIDWithChild` ([engine/units/units.asm](../../engine/units/units.asm)) or chapter event scripts check `PermanentFlag*Exists`: if the flag is set, the dynamic child deploys; if clear, the static substitute spawns in the child's place.

## Computing a child

When `rlLoadUnit` spawns a `UnitTypeDynamic` child, `rsCreateDynamicUnitRAMData` ([engine/units/unit_creation.asm](../../engine/units/unit_creation.asm)) stages the Mother into `aUnit1DataBuffer` (`wR1`) and the Father into `aUnit2DataBuffer` (`wR0`), allocates 52 bytes (`Personal` 15B + `Extended` 15B + `ConstantData` 22B) in `aDynamicUnitRAMArea`, records `FatherID`, and invokes [engine/units/inheritance.asm](../../engine/units/inheritance.asm).

### Major influence

Each child's `structDynamicCharacterROMEntry` carries a `MajorInfluence` byte (`0` = Mother, `1` = Father) that controls both holy blood weighting and which parent passes down items and gold-heavy gear. Most sons follow their father (`1`) and most daughters follow their mother (`0`), with four intentional swaps:

| Child | Gender | `MajorInfluence` | Inherits inventory from |
|---|---|---|---|
| `Seliph`, `Scathach`, `Coirpre`, `Ced`, `Diarmuid`, `Lester`, `Arthur` | Male | `1` (Father) | Father |
| `Leif`, `Febail` | Male | `0` (Mother) | `Ethlyn` / `Brigid` |
| `Larcei`, `Lana`, `Fee`, `Tine`, `Lene`, `Nanna` | Female | `0` (Mother) | Mother |
| `Altena`, `Patty` | Female | `1` (Father) | `Quan` / Father |

### Growths, skills, and holy blood

- **Growths (`rsGetChildGrowthRate`):** Male children use `Father + floor(Mother / 2)`; female children use `Mother + floor(Father / 2)`.
- **Skills (`rlFillChildsConstantData`):** Computes `(Mother.Skills | Father.Skills) & aValidInheritableSkills[CharID - Seliph]` across two overlapping 16-bit writes covering `Skills1..Skills3`. [ValidInheritableSkills.asm](../../data/character/ValidInheritableSkills.asm) strips `UnitSkill1Dismount`, `UnitSkill1PoW`, and `UnitSkill3Escape` from every child, and masks `Skills2` with `UnitSkill2NonSword` (`$07`) for every dynamic child except `Scathach`, `Larcei`, `Patty`, and `Lene`, keeping Astra, Luna, and Sol restricted to unmounted swordfighters, thieves, and dancers.
- **Holy blood (`rsGetChildHolyBlood`):** Eight bloods sit in `HolyBlood1` and five in `HolyBlood2` (13 total, at 2 bits per blood: `0` = None, `1` = Minor, `2` = Major). The minor-influence parent's blood is downgraded (`Major → Minor`, `Minor → Minor`, `None → None`) and summed per 2-bit slot with the major-influence parent's blood:

```rust
fn combine_holy_blood(minor_parent: u16, major_parent: u16) -> u16 { // rsGetChildHolyBlood
    // Downgrade each 2-bit field: 0 -> 0, 1 -> 1, 2 -> 1
    let halved = ((minor_parent.wrapping_add(0x5555)) >> 1) & 0x5555;
    let mut out = 0u16;
    for slot in 0..8 {
        let a = (halved >> (slot * 2)) & 0x3;
        let b = (major_parent >> (slot * 2)) & 0x3;
        let sum = if a + b >= 4 { 2 } else { a + b };     // 1+1 = 2 (Major); 1+2 = 3 (read as Major)
        out |= sum << (slot * 2);
    }
    out
}
```

### Gold, base stats, and auto-promotion

`rlFillChildExtendedPersonalData` computes starting gold as `2000 + floor((Mother.Money + Father.Money) / 10)`. Base stats combine the parents' personal stats (excluding class bases) with simulated level-ups from level 1 to the child's starting level:

```
Primary   = Father (if male) else Mother
Secondary = Mother (if male) else Father
BaseStat  = floor((2 * Primary + Secondary) / 10) + floor((Level - 1) * TotalGrowth / 100)
```

HP adds `+15`, and Luck adds a random `1..10` (`rlGetRandomNumber100(10) + 1`). Finally, `rlFillChildExtendedPersonalData` calls `rlGetPromotedClassIfAvailable`—if a child's starting level meets or exceeds its promotion threshold, the child auto-promotes on spawn.

### Inventory inheritance

`rlInheritInventoryToChild` transfers items from the `MajorInfluence` parent's inventory and Supply (`ItemStateSupply`):

1. **Strip uninheritable holy weapons (`rsInheritParentInventory`):** Any weapon with weapon rank `$FF` other than `Forseti`, `ValkyrieStaff`, or `Yewfelle` is removed from the parent and reverted to unobtained.
2. **Deduplicate starting gear:** Any item in the child's default ROM equipment whose item ID already appears in the parent's inventory is removed from the child and reverted.
3. **Filter and place (`rsTryInheritItemToChild`):** For each item in the parent's inventory and then each `ItemStateSupply` item owned by that parent:
   - `Forseti`, `ValkyrieStaff`, and `Yewfelle` bypass both weapon-rank checks and the 7-item inventory cap.
   - Rings always inherit; other weapons and staves must pass `rlCheckSelectedUnitCanUseItem`. Unusable items revert to `ItemStateUnobtained`.
   - Inheritable items past the 7-slot inventory limit go to the child's `ItemStateSupply`.
   - The highest-Might inherited item is inserted into slot 1 (`rlGivePlayerItemIDToSelectedUnitsFirstItemSlot`), and `rlEquipFirstWeaponInInventory` equips the first equippable weapon in the inventory (normally slot 1).

## Trade-offs and hard limits

Computing derived children once at Chapter 6 keeps Generation 2 free of parent pointers: once `aModifyChildrenDataList` finishes, the engine never consults Generation 1 records again, and `aStaticUnitRAMArea` is free for substitutes and Generation 2 recruits. The trade-off is that inheritance cannot be re-evaluated later, and any story exception (such as Seliph's blood and Dismount skill) must be patched immediately afterward.

The limits:

- **9 × 15 love matrix:** `aLoverRAMArea` holds 9 blocks of 15 words (`GenID 16..24` × `GenID 1..15`).
- **50-turn love cap:** `rlAddTurnStartLovePoints` stops running at turn 51 in every chapter.
- **17 dynamic children:** `aDynamicUnitRAMArea` has 17 slots (`Seliph`, `Leif`, `Altena`, plus 14 optional children).
- **14 substitute pairs:** fixed in `aChildrenPermanentFlags` and chapter event tables.

## Where it lives in the source

- [engine/units/lovers.asm](../../engine/units/lovers.asm): love base/growth decoding, `rlModifyUnitsLovePoints`, `rlSetUnitsAsLoversByGenerationIDs`, and `rlGetFatherUnitsChildrenRAMPointers`.
- [engine/units/factions.asm](../../engine/units/factions.asm): `rlAddTurnStartLovePoints`, `rsAddLoveGrowthWithEachMan`, and `rsAddAdjacentLovePoints` (the jealousy bug).
- [engine/units/generations.asm](../../engine/units/generations.asm): `rlResetUnitsForChapter`, `rlDeleteParentsAndModifyChildrenData`, `rlLoadChildUnit`, and `aChildrenPermanentFlags`.
- [engine/units/inheritance.asm](../../engine/units/inheritance.asm): `rlFillChildsConstantData`, `rlFillChildExtendedPersonalData`, `rsGetChildGrowthRate`, `rsGetChildHolyBlood`, and `rlInheritInventoryToChild`.
- [engine/units/unit_creation.asm](../../engine/units/unit_creation.asm): `rsCreateDynamicUnitRAMData` and `rsInitUnitLoverData`.
- [engine/units/units.asm](../../engine/units/units.asm): `rsLoadUnitGroupTryReplaceCharacterIDWithChild`.
- [engine/epilogue/endings.asm](../../engine/epilogue/endings.asm): `rlSetParentsPermanentFlags`.
- [engine/events/first_generation_ending.asm](../../engine/events/first_generation_ending.asm): `procFirstGenerationEnding` (Chapter 5 memorial).
- [data/character/](../../data/character/): `Gen1LoveBases.csv`, `Gen1LoveGrowths.csv`, `Gen2LoveBases.csv`, `Gen2LoveGrowths.csv`, `ChildrenData.csv`, and `ValidInheritableSkills.asm`.
- [docs/reference/units.md](../reference/units.md): the reference page.

---

← Previous: [Chapter 16: The Arena](16-the-arena.md) | [Contents](OUTLINE.md) | Next: [Chapter 18: Saving](18-saving.md) →
