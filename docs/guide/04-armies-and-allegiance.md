# Chapter 4: Armies and Allegiance

Chapter 1 opens with Sigurd's army marching on Verdane. Genoa, Marpha, and Verdane are his enemies and allies of one another. Nordion's army sits to the east, neutral: Sigurd can't attack it, and it can't attack him, but its units still block his path. Partway through, Heirhein's army appears, at war with Sigurd and allied with Nordion. A scene later, Heirhein and Nordion are at war, and Nordion has become Sigurd's ally.

Each army is a *faction*, and each pair of factions has its own relation: enemy, allied, or neutral. A unit's allegiance comes from its faction's relations, so two computer-controlled armies can fight each other, an army can be neutral to the player and at war with its neighbor, and a script can change any pair mid-chapter. This chapter covers the faction slots that hold the armies, the two bitmasks that store their relations, and the copy of the player's relation that each unit keeps.

## Groups and slots

An army comes in two halves. The **faction group** is its ROM template (`structFactionGroupData`, [include/Deployment.h](../../include/Deployment.h)): a name, a battle HUD color, a battle banner, a list of units, a list of castles, and the AI scripts for its groups of units ([Chapter 14](OUTLINE.md)). The **faction slot** is a running instance of a group in the current chapter. There are seven slots, numbered 0 to 6; slot 0, `FS_Player`, is always Sigurd's or Seliph's army, and the value 7, `Factionless`, marks a unit that belongs to none.

Slot numbers mean different things in different chapters, so each chapter's script gives them its own names:

```
FS_Ch01Genoa    := 1        ; events/Chapter01.asm
FS_Ch01Marpha   := 2
FS_Ch01Verdane  := 3
FS_Ch01Nordion  := 4
FS_Ch01Heirhein := 5
```

All seven slots live in `aFactionArea`, 195 bytes of work RAM: an offset table locating each slot, then for each slot a five-byte header followed by its units:

```rust
struct FactionHeader {          // structFactionHeader
    group_id: u8,               // which ROM group; $80 = empty slot
    location_id: u8,            // home castle
    hostile_factions: u8,       // one bit per slot
    allied_factions: u8,        // one bit per slot
    unit_count: u8,             // followed by unit_count unit header pointers
}
```

Sixteen bytes of offsets, seven five-byte headers, and 72 two-byte unit pointers add up to exactly 195. The 72 pointers are shared: one army can hold most of them, as long as the total across all seven stays within the 72 units the engine can hold ([Chapter 1](01-a-unit-is-made-of-parts.md)).

The event command `LOAD_FACTION_GROUP FS_Ch01Verdane, FG_Ch01Verdane` puts a group into a slot. `rlLoadFactionGroup` records the group, gives the slot each castle in the group's list (the first becomes its home), creates any of the group's units that don't exist yet, assigns them to the slot, and places them inside the home castle. It also clears the slot's two relation masks, so a newly loaded army is neutral to everyone until the script says otherwise.

## Relations as two bitmasks

Each header carries two bytes with one bit per slot: `hostile_factions` and `allied_factions`. A bit in neither means neutral. Asking how one army regards another is two bit tests:

```rust
fn faction_relation(own: Slot, target: Slot) -> Allegiance {   // rlGetFactionRelation
    if own == target { return Own; }
    let header = faction_header(own)?;              // an invalid slot counts as Enemy
    let bit = 1 << target;                          // aFactionBitLookupTable
    if header.hostile_factions & bit != 0 { return Enemy; }
    if header.allied_factions & bit != 0 { return Allied; }
    Neutral
}
```

The four results (`AllegianceOwn`, `AllegianceEnemy`, `AllegianceAllied`, and `AllegianceNeutral`; the data window calls them じぐん, てきたい, どうめい, and ちゅうりつ) decide what units can do to each other:

| Relation | Fight? | Pass through? |
|---|---|---|
| Own | no | yes |
| Allied | no | yes |
| Neutral | no | no |
| Enemy | yes | no |

Only enemies fight: `rlCheckIfDeployedUnitIsEnemy` accepts nothing else. Own and allied units count as *friendly* and can be walked past; enemy and neutral units are *unfriendly* and block movement, which is how Nordion's neutral army stands in Sigurd's way without ever fighting him.

Scripts set relations a pair at a time with `SET_FACTION_HOSTILITY`, written through three macros. Here is Chapter 1's opening ([events/Chapter01.asm](../../events/Chapter01.asm)):

```
macroSetFactionsEnemies [FS_Player,      FS_Ch01Genoa]
macroSetFactionsEnemies [FS_Player,      FS_Ch01Marpha]
macroSetFactionsEnemies [FS_Player,      FS_Ch01Verdane]
macroSetFactionsNeutral [FS_Player,      FS_Ch01Nordion]
macroSetFactionsAllies  [FS_Ch01Genoa,   FS_Ch01Marpha]
macroSetFactionsAllies  [FS_Ch01Genoa,   FS_Ch01Verdane]
macroSetFactionsNeutral [FS_Ch01Genoa,   FS_Ch01Nordion]
...
```

`rlSetFactionHostility` dispatches through a table of three routines (`aSetFactionHostilitySettings`), one per relation. Each sets one bit and clears the other in the first army's masks, and `rlSetFactionHostility` calls it twice with the slots swapped, so relations are always written symmetrically. The result is a small matrix:

|  | Player | Genoa | Marpha | Verdane | Nordion |
|---|---|---|---|---|---|
| **Player** | own | enemy | enemy | enemy | neutral |
| **Genoa** | enemy | own | allied | allied | neutral |
| **Marpha** | enemy | allied | own | allied | neutral |
| **Verdane** | enemy | allied | allied | own | neutral |
| **Nordion** | neutral | neutral | neutral | neutral | own |

When Heirhein arrives, the script loads it into slot 5 and writes five more pairs: enemy to the player, neutral to the three Verdane-side armies, allied with Nordion. Nordion's scene later rewrites two cells, Nordion–Heirhein to enemy and Player–Nordion to allied. The event scripts make nearly two hundred of these calls across the game.

## A cache for the player's view

One relation is asked far more often than the others: how each unit's army regards the player. The map draws every unit in a color that says so, map battles pick palettes by it, and the victory theme waits for the last enemy of the player to fall (`rlGetVictoryThemeIfAllEnemiesDead`). So each unit's entry in the deployment table ([Chapter 5](OUTLINE.md)) keeps that one relation in its two low bits (`DeploymentAllegianceMask`).

Whenever a script changes a relation involving slot 0, the setter also rewrites those bits for every unit of the other army (`rsSetFactionSlotAllegiance`). When Nordion turns allied, every Nordion unit's two bits change at once, and the map recolors them on the next frame.

Everything else asks the pair. `rlCheckIfDeployedUnitIsEnemy`, which the battle code and the target filters (the searches that find who a unit can attack) use, reads the other unit's slot from the deployment table and calls `rlGetFactionRelation` with the selected unit's slot:

```rust
fn is_enemy(deployment: usize) -> bool {             // rlCheckIfDeployedUnitIsEnemy
    let target = aDeploymentTable.faction_slot[deployment];
    faction_relation(selected_unit_faction(), target) == Enemy
}
```

Heirhein's units attack Nordion's because the Heirhein–Nordion pair is marked hostile; the deployment bits, which record only each army's relation to the player, play no part in it.

## Membership, three times over

A unit's army is recorded in three places: the `FactionSlot` byte of its personal data, its pointer in the slot's list in `aFactionArea`, and the `_FactionSlot` column of the deployment table. `rlAssignUnitToFactionSlot` writes the first two (and, for the player's army, the join order the unit window sorts by); the deployment column is written when the unit is placed on the map. Each copy serves a different reader: the unit's own byte answers "which army am I in" through the getters, the slot's list lets code walk an army's units, and the deployment column lets map code find a unit's army from its tile without touching the unit record.

When a script unloads an army (`rlUnloadFactionSlot`), its units are deleted, except `Dynamic` units, the second-generation children, who are set to `Factionless` so they survive to join later. Unloading slot 0 starts the game over sequence.

## Castles

Each location records the faction slot that owns it (`rlSetLocationFactionSlotOwner`), and an army's home is the castle in its header's `location_id`, where `rlSetUnitResidingInCastle` keeps units that haven't been sent out. Seizing a castle changes its owner slot ([Chapter 5](OUTLINE.md)).

Castle income is paid at the end of a chapter, by the ending event's `ADD_CASTLE_MONEY` command. `rlAddCastleMoneyToAllUnitsInFaction` counts the castles held by the player or an ally (not neutral, not enemy), subtracts two, and gives each living unit of the army that many thousand gold.

## Trade-offs and hard limits

A relation costs a header lookup and two bit tests, and the player's relation is stored twice: in the masks and in every unit's deployment bits, which the setter rewrites by hand. Changing a relation never touches the units of either army, except for those deployment bits.

The limits:

- **Seven armies at once.** The relation masks are bytes with one bit per slot, and the value 7 is spent on `Factionless`.
- **72 unit pointers, shared.** All armies together fit in the same 72 slots as the unit headers.
- **Only scripts change relations.** Nothing in play (no battle, no seized castle) alters a mask; every shift in alliance is written in an event.
- **Symmetry is a convention.** The setter always writes both directions, but loading a group into a slot clears only that slot's own masks. The other armies' bits about the slot keep their old values until the script sets each pair, which every chapter's setup does.
- **An unchecked slot.** The enemy setter, `rsSetFactionSlotsHostilityEnemies`, compares the slot against 7 but has no branch after the comparison, unlike its two siblings. Every caller passes a valid slot, so the missing check never matters.

## Where it lives in the source

- [include/Deployment.h](../../include/Deployment.h): `structFactionHeader`, `structFactionGroupData`, `Factionless`, and `DeploymentAllegianceMask`.
- [include/Characters.h](../../include/Characters.h): `FS_Player` and the four `Allegiance*` values, with a comment on what each permits.
- [engine/units/factions.asm](../../engine/units/factions.asm): loading and unloading slots, membership, relations, the hostility setters, and castle income.
- [engine/battle/battle.asm](../../engine/battle/battle.asm): `rlCheckIfDeployedUnitIsEnemy` and the friendly checks.
- [engine/events/event_engine.asm](../../engine/events/event_engine.asm): the `LOAD_FACTION_GROUP`, `SET_FACTION_HOSTILITY`, and `ADD_CASTLE_MONEY` commands.
- [events/Chapter01.asm](../../events/Chapter01.asm): a chapter's faction setup, start to finish.
- [docs/reference/units.md](../reference/units.md): the reference page.
