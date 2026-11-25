# Chapter 7: Growing Stronger

A unit in *Genealogy of the Holy War* grows in two ways: level-ups, earned from combat and staves up to level 30, and class promotion in a castle from level 20. Effective stats are assembled on demand from layers ([Chapter 2](02-classes-stats-skills-and-weapon-ranks.md)), and the two paths touch different layers: a level-up adds to the personal stats in RAM, while a promotion changes only the class ID. Both still need a screen that shows eight stats before and after.

The engine records both in the same 32-byte result structure and shows both in the same battle-scene window. This chapter covers the progression rules first, then the shared record, level-up rolling, and castle promotion.

## How progression works

### Experience and the level cap

Only living player units (`Static` and `Dynamic`, in faction slot 0) below level 30 can earn experience. Enemies, `Holy` bosses, and dead units exit the experience check with zero gain.

Experience comes from three sources:

- **Combat hits:** `10 + (DefenderLevel - AttackerLevel)`.
- **Combat kills:** `30 + 2 * (DefenderLevel - AttackerLevel)`.
- **Staves:** `item_cost / max_durability / 20 + 10`, clamped to `100` (or `10` for an empty slot).

In combat, each connecting hit replaces the value left by the one before, so the last connecting hit decides the battle's experience ([Chapter 6](06-resolving-a-battle.md)). Two hits earn one hit's worth; a hit followed by a killing blow earns the kill's.

If the unit has `Paragon`—from personal skills, class skills, or an inventory item—the gained experience is doubled before being clamped to `0..100`. That cap guarantees a unit can gain at most one level per action. Reaching `100` total EXP increments the unit's level and carries the remainder forward; if the level-up reaches level 30, remaining EXP is cleared and the overflow is trimmed from the action's gained EXP so the bar stops cleanly at `0`.

### Growth rolls and stat caps

Every level-up rolls all eight stats against the unit's total growth rate (personal growth plus Holy Blood bonuses, [Chapter 2](02-classes-stats-skills-and-weapon-ranks.md)). When a growth rate is `100%` or higher, the roll grants a guaranteed `+1`, subtracts `100` once, and rolls the remaining percentage for a second point. A stat can therefore gain `+0`, `+1`, or `+2` on a level-up, never `+3`.

Gains are added to the unit's personal stats in RAM, each bounded by its own cap:

| Stat | Personal RAM cap | Effective cap |
|---|---|---|
| `HP` | `80` | `80` (no class base added) |
| `Strength`, `Magic`, `Skill`, `Speed`, `Defense`, `Resistance` | `15` | `30` (`min(ClassBase + Personal, 30)` + weapon/ring bonuses) |
| `Luck` | `30` | `30` (no class base added) |

### Class promotion

A player unit can promote inside a castle when it has a promotion target, is not dismounted, and has reached the target class's promotion level. Every class that is a promotion target stores `20`.

Promotion leaves the unit's level and its personal stats in RAM unchanged. Effective stats are computed on demand as `min(ClassBase + PersonalStat, 30)`, so writing the new class ID raises Strength through Resistance by the difference between the two classes' base values, up to the cap of 30. HP and Luck have no class base, so promotion never changes them. Weapon ranks, movement, and class skills also come from the class, and change with the same write.

Promotion targets are stored per character. Ayra, Larcei, Scathach, Dalvin, and Creidne all start as Myrmidons, yet Ayra and Larcei promote to Swordmaster while the other three promote to Hero. Characters who cannot promote store `$FF`.

## Data models and execution

### The shared level-up record

Both level-ups and class promotion write into `structLevelUpStats` ([include/Characters.h](../../include/Characters.h)), a 32-byte block embedded inside `structActionStructEntry.LevelUpData` ([include/Battle.h](../../include/Battle.h)):

```
structLevelUpStats (32 bytes, 16-bit words)
┌──────────────────────────────────────────────────────────────────────┐
│ $00–$0E  Before: HP, Strength, Magic, Skill, Speed, Def, Res, Luck   │
├──────────────────────────────────────────────────────────────────────┤
│ $10–$1E  Gains:  HPGain, StrGain, MagGain, SklGain, SpdGain,         │
│                  DefGain, ResGain, LuckGain                          │
└──────────────────────────────────────────────────────────────────────┘
```

In combat, `rsActionstructGetLevelUpAndDroppedItemData` ([engine/battle/effects.asm](../../engine/battle/effects.asm)) applies `Paragon`, clamps gained EXP to `0..100`, and passes `LevelUpData` into `rlActionStructLevelUp` ([engine/units/level_up.asm](../../engine/units/level_up.asm)).

### Rolling a level-up

When accumulated EXP reaches `100`, `rlActionStructLevelUp` keeps the remainder and calls `rlGetLevelUpStats`, which increments the level, snapshots the pre-level-up totals, and rolls each stat:

```rust
fn apply_level_up(unit: &mut Unit, gained_exp: &mut u8, out: &mut LevelUpStats) -> u8 { // rlActionStructLevelUp
    if unit.kind >= UnitTypeHoly || unit.faction != 0 || unit.hp == 0 || unit.level >= 30 {
        *gained_exp = 0;
        return 0;
    }
    let total = unit.exp + *gained_exp;
    if total < 100 {
        unit.exp = total;
        return 0;
    }
    unit.exp = total - 100;
    if unit.level + 1 >= 30 {
        *gained_exp -= unit.exp;                      // trim overflow at level 30
        unit.exp = 0;
    }
    roll_level_up_stats(unit, out);                  // rlGetLevelUpStats
    1
}

fn roll_stat_growth(growth: u8) -> u8 {              // rsRollForStatGrowth
    let mut gain = 0;
    let rem = if growth >= 100 {
        gain += 1;
        growth - 100                                 // subtracts 100 at most once
    } else {
        growth
    };
    if roll_chance(rem) { gain += 1; }               // rlRollForChance
    gain
}
```

Each `rlGetLevelUpStats` call also increments `wTotalLevelUpCount`, which the rankings system reads at the end of the game ([Chapter 21](21-endings-and-scores.md)). One small quirk appears when a `+2` roll crosses a personal cap: if a stat is already at its cap (`80`, `15`, or `30`), the gain helper returns `0`; if a stat is one point below cap (such as `14` Strength) and rolls `+2`, RAM clamps the stored stat to `15` while `LevelUpData` still records the rolled `+2`.

### Promotion as a zero-round battle scene

The castle menu checks eligibility with `rlGetPromotedClassIfAvailable` ([engine/units/classes.asm](../../engine/units/classes.asm)), which rejects dismounted units (`UnitStateDismounted`), looks up `aPromotionTable[CharacterID - 1]` ([data/character/PromotionTable.asm](../../data/character/PromotionTable.asm)), rejects `$FF` or a target equal to the current class, and checks `Level >= PromotionLevel`. It reads `PromotionLevel` from the target class's entry, not the current one. Four base classes (Myrmidon, Archer, Pegasus Rider, and Dragonrider) store `1` in that field, which the check never reads. When eligible, it writes `1` to `$7E/2000` and the target class ID to `$7E/2002`.

When the player confirms promotion, `rlStartCastleClassChange` ([engine/castle/class_change.asm](../../engine/castle/class_change.asm)) stages a zero-round battle scene:

```
  1. Snapshot "before" totals ──▶ aUnit1DataBuffer & aActionStructUnit1 (old class)
  2. Write new class byte     ──▶ rlSetSelectedUnitClass + update map sprite
  3. Snapshot "after" totals  ──▶ aUnit2DataBuffer & aActionStructUnit2 (new class)
  4. Compute (after - before) ──▶ aActionStructUnit1.LevelUpData (HP/Luck gains = 0)
  5. Write $FFFF end marker   ──▶ aBattleRoundsData, wBattleType = 2, rlStartBattleScene
```

Because `aActionStructUnit1` holds the old class, `aActionStructUnit2` holds the new class, and `aBattleRoundsData` ends immediately with `$FFFF`, the battle scene plays the class-change animation and then opens the standard stat-gain window reading `LevelUpData`.

### Displaying results

In [engine/battle_scene/results.asm](../../engine/battle_scene/results.asm) ([battle_scene.md](../reference/battle_scene.md)), the battle scene animates the EXP gauge from `wBattleSceneExperience` to `wBattleSceneExperience + wBattleSceneExperienceGained`, wrapping past `100` on a level-up. When a level-up or promotion occurred, it draws nine gauges—`Level` plus the eight stats in `structLevelUpStats` (using an 80-point bar for HP and 30-point bars for the rest)—and animates each stat rising by its recorded gain.

## Trade-offs and hard limits

Routing both level-ups and promotions through `structLevelUpStats` and the battle scene avoids duplicating gauge-drawing code and guarantees that promotion stat gains always match the live stat getters. Defining promotions per character rather than per class supports split promotions within a class, at the cost of a fixed table tied to playable character IDs.

The hard limits built into progression:

- **Level cap of 30.** Units cannot earn EXP at level 30, and promotion does not reset level.
- **100 EXP and 1 level per action.** Gained EXP is clamped to `0..100` after `Paragon` doubles it.
- **Maximum `+2` per stat per level.** Growths above `100%` subtract `100` once; a `200%+` growth still caps at `+2`.
- **Personal stat caps of 80 / 15 / 30.** Enforced individually for `HP`, `Strength`–`Resistance`, and `Luck`.
- **63 entries in `aPromotionTable`.** Covers playable character IDs 1 through 63 in ROM.

## Where it lives in the source

- [engine/units/level_up.asm](../../engine/units/level_up.asm): `rlActionStructLevelUp`, `rlGetLevelUpStats`, `rsRollForStatGrowth`, and `rsApplyLevelUp*Gain`.
- [engine/units/classes.asm](../../engine/units/classes.asm): `rlGetPromotedClassIfAvailable` and class ROM getters.
- [data/character/PromotionTable.asm](../../data/character/PromotionTable.asm): 63-entry per-character promotion table (`aPromotionTable`).
- [engine/castle/class_change.asm](../../engine/castle/class_change.asm): `rlStartCastleClassChange` and `rsClassChangeStoreStatGains`.
- [engine/battle/effects.asm](../../engine/battle/effects.asm) and [engine/battle/battle_stats.asm](../../engine/battle/battle_stats.asm): `rsActionstructGetLevelUpAndDroppedItemData` and `rlGetInventorySlotStaffCostValue` (staff EXP).
- [engine/battle_scene/results.asm](../../engine/battle_scene/results.asm): EXP bar and level-up/promotion stat-gain display.
- [include/Characters.h](../../include/Characters.h) and [include/Battle.h](../../include/Battle.h): `structLevelUpStats` and `structActionStructEntry`.
- [docs/reference/units.md](../reference/units.md) and [docs/reference/battle_scene.md](../reference/battle_scene.md): reference pages for level-ups, promotion, and battle-scene results.
