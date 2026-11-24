# Chapter 2: Classes, Stats, Skills, and Weapon Ranks

No number on a unit's status screen is stored in a single place. Every stat, skill, and weapon rank is assembled on demand from up to five sources—class, personal stats, holy blood, equipped weapon, and rings—each living in its own ROM table with its own encoding.

Because those terms stay separate, changing one updates the totals automatically: promoting a unit changes six class stats without rewriting personal stats, equipping a holy weapon adds live stat bonuses, and carrying a ring grants its bonus passively from inventory while weapon skills apply only while equipped. This chapter covers how the getters introduced in [Chapter 1](01-a-unit-is-made-of-parts.md) combine those sources into the numbers the rest of the game uses.

## A stat is a sum

A playable unit's strength has two layers. The *base* is its class's strength plus its own, capped at 30. The *bonus* is whatever its equipment adds, uncapped:

```rust
// rlGetSelectedUnitStrengthBaseAndBonus: returns the base, leaves the bonus in wR34
fn strength_parts() -> (u8, u8) {
    let mut bonus = holy_weapon_boost(STR);          // rlGetWeaponStatBoostForSpecifiedStat
    if rings().contains(POWER_RING) { bonus += 5; }  // rlGetActiveRingStatBonusBitfield
    let base = if unit.kind == Enemy {
        enemy_strength()                             // rlGetEnemyStrength (Chapter 1)
    } else {
        min(class.strength + extended.strength, 30)  // rlGetClassStrength
    };
    (base, bonus)
}

fn total_strength() -> u8 {                          // rlGetSelectedUnitTotalStrength
    let (base, bonus) = strength_parts();
    base + bonus
}
```

Sigurd, a Knight Lord with a personal strength of 4, has a base of 10 + 4 = 14. Magic, skill, speed, defense, and resistance follow the same shape, with two more equipment bonuses: the Safeguard adds 7 to defense and the Barrier Blade 7 to resistance. Each ring sets a bit in the unit's `RingStatBonusBitfield` when it enters the inventory, and the getters test those bits: `$80` Power, `$40` Magic, `$20` Skill, `$10` Speed, `$08` Shield, and `$04` Barrier each add 5, and `$02` Leg adds 3 movement.

Each of the six combat stats has two caps. When a level-up adds to a stat, `rlAddSelectedUnitStat` stops the *personal* value at 15. When the stat is read, class base plus personal stops at 30. A unit's real ceiling is therefore its class base plus 15, never above 30: a Cavalier, with a strength base of 7, tops out at 22 strength, and the same unit as a Paladin (base 9) can reach 24. Promotion raises the ceiling along with the stat.

**Max HP** and **luck** break the pattern. They have no class term: the class table has no luck column, and its HP column is used only for generic enemies. A player unit's max HP is simply its personal HP and its luck its personal luck, so their personal caps, 80 and 30, are their only ones.

`rlGetSelectedUnitStrengthBaseAndBonus` returns the base in the accumulator and passes the bonus back through the scratch variable `wR34`, a second return value in a language without tuples. The split exists for display. The status screen draws the base and then the bonus beside it (`rlDrawStatBonus`), and the level-up screen records the base before and after the gain.

## Promotion changes one byte

Because the class is a live term in every sum, a unit doesn't store its class-adjusted stats. Changing class changes them all at once:

| | Str | Mag | Skl | Spd | Def | Res |
|---|---:|---:|---:|---:|---:|---:|
| Cavalier bases | 7 | 0 | 6 | 6 | 6 | 0 |
| Paladin bases | 9 | 5 | 9 | 9 | 9 | 5 |
| Gain on promotion | +2 | +5 | +3 | +3 | +3 | +5 |

`rlSetSelectedUnitClass` writes a single byte, the class ID in the unit's extended part. No stat is rewritten. The class change screen ([engine/castle/class_change.asm](../../engine/castle/class_change.asm)) only learns what the unit gained by unpacking its totals into a buffer before the change and again after it, then showing the difference. One consequence follows directly: promotion never raises a player unit's max HP, since HP has no class term to change. When and how a unit promotes is [Chapter 7](07-growing-stronger.md)'s subject.

A class is a row of numbers ([data/class/ClassData.csv](../../data/class/ClassData.csv), 72 rows): a promotion level, seven stat bases, seven growth rates, ten weapon ranks, movement and terrain types, a skill word, and the gold a generic enemy of that class carries.

## Holy blood: one table, three jobs

FE4's holy blood is a single table of 13 entries ([data/item/HolyBloodData.csv](../../data/item/HolyBloodData.csv)). Each entry names a weapon type, a holy weapon, eight growth bonuses, and six stat boosts:

| Blood | Weapon type | Holy weapon | Growth bonuses | Weapon's stat boosts |
|---|---|---|---|---|
| Baldr | Sword | Tyrfing | HP 20, Str 10, Skl 10, Luk 10 | Skl 10, Spd 10, Res 20 |
| Od | Sword | Balmung | HP 20, Skl 30 | Skl 10, Spd 20 |
| Fjalar | Fire | Valflame | HP 20, Mag 30 | Mag 10, Def 10, Res 10 |

A unit's blood is stored as two bits per line in the `HolyBlood1` and `HolyBlood2` words of its constant data: `1` for Minor, `2` for Major. `rlCheckForSpecifiedHolyBlood` returns 0, 1, or 2 for any line. Three systems read the same table.

**Growth rates.** A unit's growth in a stat is its personal growth plus each of its bloods' bonuses, doubled for Major, never below zero:

```rust
fn total_strength_growth() -> u8 {                   // rlGetSelectedUnitTotalStrGrowth
    let mut growth = constant.strength_growth as i16;
    for blood in 0..13 {                             // rlGetCharacterHolyBloodGrowthBoost
        match holy_blood(blood) {                    // rlCheckForSpecifiedHolyBlood
            Minor => growth += HOLY_BLOOD[blood].str_growth,
            Major => growth += HOLY_BLOOD[blood].str_growth * 2,
            None  => {}
        }
    }
    max(growth, 0)                                   // rsFloorGrowthAtZero
}
```

Sigurd's own strength growth is 30%; Major Baldr adds 2 × 10, for 50%. His HP growth goes from 70% to 110%. The bonus is a signed byte, so the table could also take growth away, which is why the total is floored at zero. Level-ups roll against these totals ([Chapter 7](07-growing-stronger.md)).

**Holy weapon boosts.** Tyrfing's `+10` speed is not stored with Tyrfing. Its item entry carries only a stat-bonus ID, `TyrfingStatBoost = $01`, and equipping it copies that ID into the unit's personal `WeaponStatBonus`. `rlGetWeaponStatBoostForSpecifiedStat` treats IDs `$01`–`$0D` as an index into the holy blood table and reads the boost from the matching blood's row. The two non-holy weapons with bonuses, the Safeguard (`$0E`) and the Barrier Blade (`$0F`), fall outside that range and are special-cased in the defense and resistance getters. The design ties each holy weapon's power to its bloodline in data, not just in the story.

**Weapon ranks.** The third use takes the most code, so it gets its own section.

## Weapon ranks

A class has a rank for each of ten weapon types, coded `A = 0`, `B = 1`, `C = 2`, and `None = 3`; lower is better. A holy weapon requires rank `★`, which items mark with `WeaponRankHoly = $FF`. No class has `★`. Only blood grants it:

```rust
fn weapon_rank(kind: WeaponType) -> (Rank, bool) {  // rlGetSelectedUnitWeaponRank
    let mut rank = class.rank[kind];                 // rlGetClassWeaponRank
    if rank == None { return (None, false); }        // blood can't teach a new weapon
    for blood in (0..13).rev() {
        if holy_blood(blood) == None || HOLY_BLOOD[blood].weapon_type != kind { continue; }
        if holy_blood(blood) == Major { return (A, true); }   // ★: carry set
        rank -= 1;                                   // Minor: C → B → A
        if rank <= A { return (A, false); }
    }
    (rank, false)
}
```

The `★` doesn't fit in the rank byte, so it travels in the CPU's carry flag: the routine returns `A` with carry set. Sigurd's Knight Lord class has Sword A and Lance B, and his Major Baldr blood turns Sword A into `★`, which is what lets him wield Tyrfing. A Minor blood can raise a rank by one step, and two Minor bloods for the same weapon can raise C to A. Neither can grant a weapon the class can't use: a Major-blooded unit in a class with no swords still can't hold its family's sword.

The loop has one quirk. It returns as soon as a Minor blood brings the rank to A, so a unit holding a Minor and a Major blood for the same weapon type gets A instead of `★` if the Minor blood comes later in the table. Three bloods share swords (Baldr, Od, and Hothr), so the order matters.

## Skills: one ID, three encodings

FE4 has 30 skills, from Canto to Return ([include/Skills.h](../../include/Skills.h)). A unit can get a skill from three places: its character, its class, or an item. Each source stores its skills as a bitfield, and each uses a *different bit* for the same skill:

| Skill | Character (3 bytes) | Class (word) | Item (word) |
|---|---|---|---|
| Canto | — | `$0001` | `$1000` |
| Pursuit | `$000002` | `$0008` | `$0800` |
| Critical | `$000100` | `$1000` | `$0010` |
| Dance | — | `$0080` | — |
| Astra | `$000800` | — | — |
| Renewal | `$010000` | — | `$0020` |

General skill checks don't test these bits directly. They ask by skill ID (`SkillIDCritical = $10`), and three translation tables in [engine/units/skills.asm](../../engine/units/skills.asm) map each ID to its bit in each source: `aValidPersonalSkillTable`, `aValidClassSkillTable`, and `aValidItemSkillTable`. A zero entry means the source can't grant that skill. A few specialized routines still test a raw bit; the battle crit check, for one, looks for `ItemSkillCritical` on the weapon itself ([Chapter 3](03-every-sword-is-an-individual.md)). Dance comes only from a class, Astra only from a character, and Renewal from a character or a band, never a class.

```rust
fn has_personal_or_class_skill(id: SkillId) -> bool {   // rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
    constant.skills & PERSONAL_BITS[id] != 0             // aValidPersonalSkillTable
        || class.skills & CLASS_BITS[id] != 0            // aValidClassSkillTable
}

fn inventory_has_skill(id: SkillId) -> bool {           // rlCheckIfInventoryItemsHaveSpecifiedSkill
    inventory().any(|(slot, item)| {
        let counts = item.kind != Weapon || is_equipped(slot);   // rlCheckIfWeaponEquipped
        counts && item.skills & ITEM_BITS[id] != 0       // aValidItemSkillTable
    })
}
```

Callers ask both questions in turn. The turn-start Renewal check (`rsGetRenewalHealing`) tries character and class first, then the inventory. The item rule explains the bands and rings: a weapon's skill counts only while that weapon is equipped, but any other item counts just by being carried. A Renewal Band works from the bottom of the bag.

The separate encodings pack each table tightly. Each source stores only the skills it can grant: 13 in a class's word, 12 in an item's word, 22 in a character's three bytes. A shared 30-bit layout would need four bytes in every class, item, and character entry, about 500 bytes more of ROM in total. In exchange, a skill query goes through a translation table.

## Trade-offs and hard limits

Nothing on the status screen is cached. Every displayed stat, every hit-rate calculation, and every AI evaluation re-derives its numbers from the tables. For a player unit that is a handful of additions and a clamp, cheap even at 3.58 MHz. The payoff is that no stored value can go stale: promoting, equipping, or removing a ring changes the totals instantly, with no code to keep them in sync.

The limits:

- **A ceiling of class base + 15, at most 30.** Personal stats cap at 15 (HP 80, luck 30) and class plus personal at 30; holy weapons, rings, and the two special swords add on top of both.
- **Promotion never adds HP.** Max HP has no class term.
- **13 holy blood lines.** Each takes 2 bits in two words of constant data. Holy weapon stat boosts are bound to those 13 rows: a new holy weapon with its own boosts needs a new blood or must share one's row.
- **Two non-holy stat bonuses and seven rings.** The Safeguard and Barrier Blade are each special-cased in code; each ring takes one bit of `RingStatBonusBitfield`.
- **30 skill IDs.** A skill can only come from a source whose encoding has a bit for it. A new class skill needs one of the class word's three spare bits, and a new item skill one of the item word's four.
- **Rank order matters.** A Minor blood listed after a Major blood of the same weapon type can block `★`.

## Where it lives in the source

- [engine/units/stats.asm](../../engine/units/stats.asm): max HP and the base-plus-bonus stat getters, luck, movement, and the personal caps in `rlAddSelectedUnitStat`.
- [engine/units/classes.asm](../../engine/units/classes.asm): class table getters and `rlGetPromotedClassIfAvailable`.
- [engine/units/unit_info.asm](../../engine/units/unit_info.asm): holy blood checks, total growths, weapon ranks, and holy weapon boosts.
- [engine/units/skills.asm](../../engine/units/skills.asm): the three skill translation tables and the skill queries.
- [include/Classes.h](../../include/Classes.h), [include/Skills.h](../../include/Skills.h), [include/Items.h](../../include/Items.h): class, skill, and item constants and structs.
- [include/Characters.h](../../include/Characters.h): the personal skill bits (`UnitSkill1*`–`UnitSkill3*`) and the holy blood bits (`Minor*Blood`, `Major*Blood`).
- [data/class/ClassData.csv](../../data/class/ClassData.csv) and [data/item/HolyBloodData.csv](../../data/item/HolyBloodData.csv): the tables themselves.
- [docs/reference/units.md](../reference/units.md): the reference page.
