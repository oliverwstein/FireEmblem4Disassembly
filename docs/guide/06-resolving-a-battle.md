# Chapter 6: Resolving a Battle

Combat in *Genealogy of the Holy War* draws on nearly every data structure in Part I at once: each unit's stats, its equipped weapon's traits, terrain, the weapon triangle, leadership and Charm auras from nearby allies, effectiveness, and more than a dozen combat skills that change turn order, strike count, accuracy, critical hits, defense, and extra rounds. The same rules have to drive five presentations: the battle forecast ([Chapter 10](10-menus-over-the-map.md)), quick map battles ([Chapter 23](OUTLINE.md)), full battle scenes ([Chapter 24](OUTLINE.md)), the arena ([Chapter 16](16-the-arena.md)), and scripted cutscene fights.

The engine settles every fight in memory before drawing a frame, and each presentation plays back the recorded result. This chapter explains the combat rules first, then the data model, the execution pipeline, and the random number generator underneath.

## How combat works

### Base stats and modifiers

Every combatant enters a fight with five derived numbers built from its unit stats ([Chapter 2](02-classes-stats-skills-and-weapon-ranks.md)), its equipped item ([Chapter 3](03-every-sword-is-an-individual.md)), and its tile ([Chapter 5](05-who-stands-where.md)):

- **Attack speed** is `Speed - WeaponWeight` (signed, so heavy weapons can drop it below zero).
- **Might** is `WeaponMight + Strength` for physical weapons, or `WeaponMight + Magic` for tomes (`WeaponTypeFire` and above). At distance 2 or greater, ranged magic swords switch to their secondary spell, using Magic and targeting Resistance.
- **Hit** is `WeaponAccuracy + Skill * 2`.
- **Avoid** is `AttackSpeed * 2 + Luck + TerrainAvoid`.
- **Crit** starts at `0`. A player weapon with 50 or more kills unlocks `kills - 50` crit, while the `Critical` skill or a killer weapon's item skill unlocks `0` base crit; once unlocked, `Skill` is added on top.

Four battlefield modifiers adjust those numbers before any dice roll:

- **Weapon triangle:** Sword beats Axe, Axe beats Lance, Lance beats Sword; Fire beats Wind, Wind beats Thunder, Thunder beats Fire; Light and Dark beat all three anima elements; Bows and Staves sit outside the triangle. Advantage grants `+20` Hit and `+20` Avoid, with no might bonus.
- **Auras within 3 tiles:** Every alive, non-enemy unit within 1 to 3 tiles grants `+10` Hit and `+10` Avoid if it has `Charm`, `+10` if it is the combatant's lover, and a leadership bonus if it is the unit's commander (`0, 0, 10, 20, 30, 40` for 0 to 5 stars—one star grants nothing). Sigurd, Seliph, and group leaders also receive their own star bonus regardless of distance.
- **Effectiveness and halving:** When a weapon's effectiveness matches the target's class weakness, the attacker's Crit is set to `100%`; Might is unchanged. When the defender's equipped weapon halves attack (the Loptous tome), the attacker's Might is halved unless the attacker's own weapon names that tome as the one it negates (Naga).
- **Scripted criticals:** If the initiator has an adjacent lover or an adjacent partner from one of 17 sibling pairs, it gains `+20%` Crit. If one of three enemy triangle-attack trios surrounds a target at range 1, the initiator gains `+100%` Crit. Both apply even without the `Critical` skill.

The chance to hit is `Hit - OpponentAvoid`, clamped to `0..100`; the forecast shows this number. `Miracle` (below) can lower it further when the roll is made. The chance to crit is `Crit` itself.

### Combat skills

These skills intervene at specific points in the fight (`Brave` is a weapon trait, and `Paragon` affects experience, [Chapter 7](07-growing-stronger.md)). Fourteen of them, plus `Dance`, have a bit in each combatant's `TriggerableSkills` mask; `Charm` and `Critical` are read directly by the stat code. `Dance` is in the mask because a dance runs through the same strike code as an attack.

| Skill | Stage | Trigger | Effect |
|---|---|---|---|
| `Charm` | Forecast | Alive ally within 1–3 tiles | `+10` Hit and `+10` Avoid |
| `Vantage` | Turn order | `CurrentHP <= MaxHP / 2` | Defender strikes first |
| `Astra` | Strike count | Sword in range; `Skill`% roll | Turns 1 swing into 5 (10 with Brave) |
| `Luna` | Strike count / hit | Sword in range; `Skill`% roll | Guarantees hit; ignores target defense |
| `Sol` | Strike count / hit | Sword in range; `Skill`% roll | Guarantees hit; heals attacker by damage dealt |
| `Holy` / `Darkness` | Strike count | Sword in range; `Skill`% roll | Adds `+20` to attack and defense until the next set of swings |
| `Adept` | Strike count | `(AttackSpeed + 20)`% roll | Doubles 1 swing to 2 (does not stack with Brave) |
| `Pursuit` | Follow-up | `AttackSpeed > OpponentAS` | Grants a follow-up attack after both sides swing |
| `Accost` | End of round | `HP >= 25`; `(HP / 2 + AS - OppAS)`% | Repeats the entire round (non-arena) |
| `Miracle` | Hit check | `CurrentHP < 11` (armed after a hit) | Reduces enemy Hit by `(11 - HP) * 10` |
| `Pavise` | Defense | `DefenderLevel`% roll | Negates the hit completely; costs no durability |
| `Critical` | Crit check | Personal, class, or item skill | Unlocks `Skill`% base critical rate |
| `Wrath` | Crit check | `CurrentHP <= MaxHP / 2 + 1` | Forces `100%` Crit |
| `Nihil` | Crit / sword skills | Personal, class, or item skill | Blocks enemy criticals (including effectiveness); blocks enemy sword skills only as a personal or class skill |
| `Steal` | On hit | Non-staff contact | Steals the defender's gold |

### Rounds, damage, and outcomes

A normal round runs in three beats: the initiator swings, the defender counters (unless out of range, asleep, silenced with magic equipped, or facing an uncounterable weapon), and whichever unit has `Pursuit` and strictly higher Attack Speed swings again. After that, `Accost` can trigger another full round. Arena fights differ in two ways: the unit with higher Attack Speed strikes first (ties go to the player's side), and combat pauses after each exchange rather than chaining Accost rounds.

All percentage rolls draw a single random number from `0` to `99` and succeed when `RN < chance`. When a hit connects and is not blocked by `Pavise`, damage is `Might + Bonus - Defense - DefenderBonus`, where `Bonus` is the `+20` from `Holy` or `Darkness`. A critical hit doubles `(Might + Bonus)` before `Defense` is subtracted. Connecting hits always deal at least `1` damage and are clamped to `80`.

Misses and `Pavise` blocks spend no weapon durability. If a strike reduces a weapon's durability to `0`, any remaining swings for that side in the current battle are canceled (outside the arena).

Each connecting hit sets the striker's experience for the battle: `10 + (DefenderLevel - AttackerLevel)`, or `30 + 2 * (DefenderLevel - AttackerLevel)` on a kill, clamped to `0..100`. Each hit replaces the value left by the one before, so the last connecting hit decides it: a unit that hits twice earns one hit's experience, and a miss after a hit leaves the hit's value in place. In the arena, only a kill earns experience.

## Engine architecture and data model

The engine organizes those rules into a strict **compute first, show later** pipeline:

```
  Stage 1: Deterministic stats (rlActionStructGetBattleStats)
    Base stats + weapon traits + triangle + auras + scripted crits
        │
        ├──▶ Battle forecast stops here and displays the preview
        ▼
  Stage 2: Round & strike resolution (rlActionStructBuildBattleRounds)
    Turn order + skill rolls + hit/crit/damage + durability/drops/EXP
        │
        ▼  writes aBattleRoundsData transcript + commits RAM changes
  Stage 3: Presentation (Battle Scene or Map Battle)
    Reads the finished transcript and animates it; touches no combat math
```

Stage 1 computes only deterministic numbers, so the battle forecast calls Stage 1 and stops. Stage 2 runs every random roll, mutates HP, durability, kill counts, drops, and experience in RAM, and records a compact transcript. Stage 3—either the full battle scene or a quick map battle—simply plays back that transcript.

All of this state lives in a 380-byte block of bank `$7E` (`$7E/4EA9` to `$7E/5024`, [include/WRAM.h](../../include/WRAM.h)):

```
Battle RAM ($7E/4EA9–$7E/5024)
┌──────────────────────────────────────────────────────────────────────┐
│ wBattleType, wBattleStatus, wBattleDistance, wBattleSong,            │
│ wBattleCriticalType, quote pointers                                  │
├──────────────────────────────────┬───────────────────────────────────┤
│ aActionStructUnit1 ($7E/4EB5)    │ aActionStructUnit2 ($7E/4F15)     │
│   96-byte structActionStructEntry│   96-byte structActionStructEntry │
│   player / allied side           │   enemy / neutral side            │
├──────────────────────────────────┴───────────────────────────────────┤
│ aBattleRoundsData ($7E/4F81)                                         │
│   4-byte header + up to 80 two-byte entries (flags byte + damage/HP) │
└──────────────────────────────────────────────────────────────────────┘
```

Player and allied units always go into `aActionStructUnit1`, while enemy and neutral units go into `aActionStructUnit2`. Bit 0 of `wBattleStatus` records which side actually initiated (`0` for `Unit1`, `1` for `Unit2`); other bits track swapped sides (`$02`), defeat (`$10`, plus `$20` for `Unit2`), and disabled animations (`$40`). Each 96-byte `structActionStructEntry` ([include/Battle.h](../../include/Battle.h)) holds the unit's deployment offset, coordinates, RAM pointer, HP, level, experience, equipped weapon, computed battle stats, a 16-bit `TriggerableSkills` mask, and a `LevelUpData` block for [Chapter 7](07-growing-stronger.md).

Each two-byte entry in `aBattleRoundsData` pairs a flags byte (`bBattleRoundFlags`, `$7ECCDE`) with a high byte carrying the damage dealt (or the target's max HP for Valkyrie):

| Bit / sentinel | Meaning |
|---|---|
| `$01` | Striker side (`0` = `Unit1`, `1` = `Unit2`) |
| `$02` | Non-attack staff or special action |
| `$04` | `BattleRoundFlagCrit` — critical hit |
| `$08` | `BattleRoundFlagMiss` — attack missed |
| `$10` | `BattleRoundFlagFatal` — target defeated; presentation stops reading |
| `$20` | `BattleRoundFlagRanged` — battle distance is 2 or more |
| `$40` | `BattleRoundFlagMagic` — weapon is a tome or staff |
| `(skill << 8) \| $FE` | Sword skill activation cue |
| `$02FE` | Pavise activation cue |
| `$FEFF` / `$FFFF` | End of an arena exchange / end of battle |

## Execution: forecast, rounds, and strikes

### Forecast stage

`rlActionStructGetBattleStats` ([engine/battle/battle.asm](../../engine/battle/battle.asm)) fills both structs in four passes:

1. **Base stats:** the getters in [engine/battle/battle_stats.asm](../../engine/battle/battle_stats.asm) compute Might, Hit, Avoid, Crit, and Attack Speed. Each getter swaps the unit's active weapon stat bonus to the weapon being evaluated, computes the total, and restores the original, so a forecast includes a holy weapon's stat boost without changing what the unit has equipped.
2. **Skills and effectiveness:** the 15 mask skills are gathered from personal, class, and inventory sources into `TriggerableSkills`, and `BattleCrit` is set to `100` where the weapon's effectiveness overlaps the target's class weakness. The mask's sixteenth bit, stay-on-map, is not a skill: an event sets it during the battle (see below).
3. **Triangle and auras:** the `+20` triangle bonus, then a scan of all 72 deployment rows for Charm, lover, and leadership bonuses within 3 tiles.
4. **Final adjustments:** the defender's weapon slot is cleared if the initiator's weapon can't be countered, Might is halved against the Loptous tome, Defense or Resistance is chosen by the opponent's weapon type, and the forecast hit chance (`BattleAdjustedHit`) is computed and clamped. For the initiator only, a 32 × 32 grid of nearby units is built to check for lover, sibling, and triangle-attack crits.

### Round loop

Once combat begins, `rlActionStructBuildBattleRounds` turns the two structs into `aBattleRoundsData` entries:

```rust
fn build_battle_rounds() {                           // rlActionStructBuildBattleRounds
    let mut attacker = wBattleStatus & 1;            // 0 = Unit1, 1 = Unit2
    if wBattleType == ARENA {                        // rsActionStructGetBattleInitiatorIfArena
        attacker = if unit1.as >= unit2.as { 0 } else { 1 };
    }
    if !in_arena_continuation() {                    // wChapterFlags & $0010
        get_triggerable_skills();                    // rsActionStructGetBattleTriggerableSkillFlags
        attacker = adjust_vantage(attacker);         // rsActionStructAdjustVantageRoundOrder
        check_for_dance();                           // rsActionStructCheckForDance
        clear_magic_if_silenced();                   // rsActionStructClearMagicEquipmentIfSilenced
    }
    'done: loop {
        for _ in 0..2 {
            if add_strikes(attacker) { break 'done; } // rsActionStructAddStrikes (true = fatal)
            attacker ^= 1;
        }
        if let Some(doubler) = check_pursuit() {     // rsActionStructCheckIfCombatantsCanDouble
            if add_strikes(doubler) { break 'done; }
        }
        if wBattleType == ARENA {
            append_round(0xFEFF);
            return;
        }
        if !check_accost() { break; }                // rsActionStructCheckForAccostBattleRound
    }
    append_round(0xFFFF);
}
```

Details of the round builder:

- **Vantage tie-breaking:** `Unit1` is checked before `Unit2`, so if both sides qualify for `Vantage`, `Unit1` always strikes first.
- **Sword skills are rolled per set of swings, for both sides.** Every call to `rsActionStructAddStrikes` rerolls sword skills for both combatants. `Astra`, `Luna`, and `Sol` take effect only for the side about to swing; `Holy` and `Darkness` apply to whichever side rolls them, raising its attack and its defense until the next reroll.
- **Sword skills vs. Adept vs. Brave:** Sword skills are tested in priority order (`Astra → Luna → Sol → Holy → Darkness`), stopping at the first proc. If `Astra` triggers, strike count becomes `5` and execution falls through to the `WeaponTraitBrave` check—so a Brave Sword Astra produces **10** swings. `Adept` doubles `1` to `2` and returns immediately, skipping the Brave check, so the two never stack.
- **Broken weapons:** When `rlUseInventorySlotItem` reduces durability to `0`, the battle engine sets bit 15 (`$8000`) on `WeaponInventorySlot`. Outside the arena, `rsCheckForWeaponInventorySlot` rejects negative slots, halting any further swings for that side.

### Single strike and wrap-up

Each swing enters `rsActionStructResolveStrike`, which verifies range, sleep status, and weapon slot, then dispatches through `aActionStructWeaponTraitEffects` (11 entries) or `aActionStructStaffEffects` (16 entries). A normal strike follows this sequence:

```rust
fn resolve_normal_strike(atk: &mut ActionStruct, def: &mut ActionStruct) { // rsActionStructWeaponTraitNormal
    set_ranged_and_magic_flags();
    if !check_if_hit(atk, def) {                     // rsActionStructRoundCheckIfHit (Luna/Sol bypass)
        flags |= BattleRoundFlagMiss;                // damage = 0; skips durability
        return;
    }
    if try_proc_pavise(def) {                        // rsActionStructRoundTryProcPavise
        append_round(0x02FE);                        // damage = 0; skips durability
        return;
    }
    use_weapon_and_steal(atk, def);                  // rsActionStructUseWeaponAndSteal
    try_proc_wrath(atk);                             // rsActionStructRoundTryProcWrath
    try_proc_crit(atk, def);                         // rsActionStructRoundTryProcCrit (Nihil blocks)
    let dmg = compute_damage(atk, def);              // rsActionStructRoundGetDamage
    check_sol_healing(atk, dmg);                     // rsActionStructCheckForSolHealing
    inflict_damage_and_exp(atk, def, dmg);           // rsActionStructInflictDamageAndExp
}
```

Damage and healing are both clamped to `80` ([engine/units/unit_state.asm](../../engine/units/unit_state.asm)). A hit that leaves the defender with `1..10` HP arms its `Miracle` for later swings. A hit that brings it to `0` sets the fatal flag, unless the defender carries the stay-on-map bit; the bit is ignored in the arena and against the final Julius. Event scripts set it with `COMBATANTS_STAY_ON_MAP` for bosses who retreat instead of dying, such as Elliot in Chapter 1 ([events/Chapter01.asm](../../events/Chapter01.asm)). A kill also adds a win to the unit and to its weapon, records any item drop, and sends a defender with captive status to a castle.

Scripted cutscene battles build a fixed strike list whose flags force a hit or a crit (`SB_GuaranteedHit`, `SB_GuaranteedCrit`) and run it through the same strike resolver. After the rounds, the round builder rolls level-ups and item drops ([Chapter 7](07-growing-stronger.md)), starts Canto or ends the unit's action, runs battle events, and starts either a map battle or a battle scene. Valkyrie, Naga, Loptous, and the special crits always get a battle scene.

## The RNG and the checksum trap

Every percentage roll passes through `rlRollForChance` ([engine/battle/effects.asm](../../engine/battle/effects.asm)) and `rlGetRandomNumber` ([engine/core/random.asm](../../engine/core/random.asm)). The generator is a 55-byte subtractive lagged Fibonacci table (`aRNArray` in bank `$7E`), seeded at boot from `bFrameCounterByOnes & $3F` and shuffled three times. Every 55 calls, `rsShuffleRNTable` updates each slot in place:

```rust
fn shuffle_rn_table() {                              // rsShuffleRNTable
    for i in 0..55 {
        let j = (i + 31) % 55;
        let diff = aRNArray[i] as i16 - aRNArray[j] as i16;
        aRNArray[i] = if diff < 0 { (diff + 100) as u8 } else { diff as u8 };
    }
}
```

Each call returns the next table entry minus `1`, with `0` wrapping to `99`, and leaves the table unchanged. The result is a linear `0..99` roll.

Right after shuffling, `rlGetRandomNumber` calls `rlCheckCodeChecksums` (`$8F/8006`), which sums 16-bit words across two protected ranges (`rlReset`–`rlColdResetClearMemory` in bank `$80` and `rlWriteResetSignature`–`rlInitMapMenus` in bank `$87`) and compares them against three copies of `structCodeChecksums` ([include/Checksums.h](../../include/Checksums.h), enabled when `ChecksEnabled != 0`; the original ROM stores `$5349`, `"IS"`). On mismatch, `rsRigRNArrayByPlaytime` zeroes every table entry below a playtime-scaled threshold:

```rust
fn rig_rn_array_by_playtime() {                      // rsRigRNArrayByPlaytime
    let (hours, minutes) = get_game_time_hours_minutes(); // rlGetGameTimeHoursMinutes
    let threshold = clamp(hours * 16 + minutes / 4 - 80, 0, 100);
    for entry in aRNArray.iter_mut() {
        if *entry < threshold {
            *entry = 0;                              // rlGetRandomNumber wraps 0 -> 99
        }
    }
}
```

Because `0` wraps to `99`, every zeroed entry becomes a roll of `99`—failing nearly every hit, crit, skill, and level-up check. Under five hours of playtime (`5 * 16 - 80 = 0`) the threshold is zero and the game plays normally; from 11 hours 16 minutes (`176 + 4 - 80 = 100`) every roll returns `99`.

The original ROM's sums match, so the trap fires only when bytes inside the two ranges change: `$80/8D56–$80/8E2C` and `$87/8017–$87/80A9`. Those ranges hold absolute addresses, so shifting other code can change them without anyone editing them. `./build.sh mod` recomputes all three checksum tables after a build, and `./build.sh mod --disable-checks` sets `ChecksEnabled` to `0`, which makes the check pass without summing.

## Trade-offs and hard limits

Computing the full fight up front keeps presentation layers simple and ensures forecasts, map battles, battle scenes, and scripted fights obey one set of rules. The trade-off is that all state mutations—HP, durability, kills, drops, and deaths—are committed before the first animation frame appears.

The hard limits built into this layout:

- **80 entries in `aBattleRoundsData`.** The transcript holds 80 two-byte entries, and Accost stops adding rounds once the count reaches `40`.
- **Damage and healing cap of 80.** Both `rlActionStructInflictDamage` and `rlHealSelectedUnitsHP` clamp values to `80`; any non-Pavise hit deals at least `1` damage.
- **EXP cap of 100 per battle.** The last connecting hit's experience, doubled by Paragon, then clamped to `100`.
- **16-bit `TriggerableSkills` mask.** All 16 bits of `CombatSkillFlag*` are assigned.
- **55-entry RNG table.** `aRNArray` holds 55 bytes and reshuffles every 55 rolls using single-RN linear percentages (`0..99`).
- **17 sibling crit pairs and 3 triangle-attack trios.** Fixed in ROM tables in [engine/battle/scripted_crits.asm](../../engine/battle/scripted_crits.asm).

## Where it lives in the source

- [include/Battle.h](../../include/Battle.h): `structActionStructEntry`, `CombatSkillFlag*`, `BattleRoundFlag*`, and scripted-battle flags.
- [include/WRAM.h](../../include/WRAM.h): `wBattleType`, `wBattleStatus`, `aActionStructUnit1`, `aActionStructUnit2`, and `aBattleRoundsData`.
- [include/Checksums.h](../../include/Checksums.h): `structCodeChecksums` and anti-tamper ranges.
- [engine/battle/battle.asm](../../engine/battle/battle.asm): `rlActionStructGetBattleStats`, `rlActionStructBuildBattleRounds`, strike resolution, and weapon/staff dispatch tables.
- [engine/battle/battle_stats.asm](../../engine/battle/battle_stats.asm): Attack Speed, Might, Hit, Avoid, Crit, and weapon triangle lookups.
- [engine/battle/effects.asm](../../engine/battle/effects.asm): `rlRollForChance`, `rsActionstructGetLevelUpAndDroppedItemData`, weapon traits, and staff effects.
- [engine/battle/scripted_crits.asm](../../engine/battle/scripted_crits.asm): `rlActionStructGetScriptedCritPossibility`, sibling pairs, and triangle-attack trios.
- [engine/core/random.asm](../../engine/core/random.asm): `rlGetRandomNumber`, `rsShuffleRNTable`, `rsRigRNArrayByPlaytime`, and `rlCheckCodeChecksums`.
- [engine/units/unit_state.asm](../../engine/units/unit_state.asm): `rlActionStructInflictDamage` and `rlHealSelectedUnitsHP`.
- [docs/reference/core.md](../reference/core.md) and [docs/reference/units.md](../reference/units.md): reference pages for RNG, checksums, and damage/healing routines.
