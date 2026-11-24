# Part I: The Pieces on the Board

Every mutable piece of a *Genealogy of the Holy War* chapter fits into a single 10,155-byte stretch of bank `$7E` in work RAM, from `$7E/2180` to `$7E/492A`, with the sixteen chapter locations (`aChapterLocationRAMData`) sitting nearby at `$7E/4E45` ([include/WRAM.h](../../include/WRAM.h)). Inside that ~10 KB region live the armies, the 72 unit records, their inventories, love scores, all 256 individual items in the world, and every unit's position on the map.

```
Work RAM (bank $7E)                                     Cartridge ROM (4 MB)
┌─────────────────────────────────────────────────┐     ┌─────────────────────────────┐
│ $7E/2180  aFactionArea          (7 factions)    │     │ data/character/             │
│ $7E/2243  aUnitRAMPointers      (72 pointers)   │     │   Static, Dynamic, & Enemy  │
│ $7E/22D7  aUnitRAMArea          (72 headers)    │────▶│   character templates       │
│ $7E/29E7  aStaticUnitRAMArea    (24 playable)   │     ├─────────────────────────────┤
│ $7E/2D4F  aDynamicUnitRAMArea   (17 gen-2 kids) │     │ data/class/                 │
│ $7E/3131  aHolyAndEnemyRAMArea  (63 bosses/foes)│────▶│   Class stats, growths,     │
│ $7E/3664  aInventoryRAMArea     (73 inventories)│     │   ranks, skills, movement   │
│ $7E/3BD7  aLoverRAMArea         (9 × 15 grid)   │     ├─────────────────────────────┤
│ $7E/3D87  aItemRAMData          (256 items)     │────▶│ data/item/                  │
│ $7E/438B  aDeploymentTable      (72 map slots)  │     │   Weapon, staff, ring, &    │
│           ...to $7E/492A                        │     │   Holy Blood definitions    │
├─────────────────────────────────────────────────┤     └─────────────────────────────┘
│ $7E/4E45  aChapterLocationRAMData (16 locations)│
└─────────────────────────────────────────────────┘
```

The [introduction](00-introduction.md) sketched the hardware and the main loop. Part I examines the nouns of the game—its structured data—before Part II sets them in motion on the map. Three design choices govern the entire region:

1. **ROM templates, RAM pools.** Static rules never leave the cartridge. Character bases, enemy growths, class tables, item stats, and Holy Blood bonuses stay in `data/character/` ([../../data/character/](../../data/character/)), `data/class/` ([../../data/class/](../../data/class/)), and `data/item/` ([../../data/item/](../../data/item/)). Work RAM holds only what changes during play, allocated from fixed-size pools sized to the game's exact cast and chapter budgets rather than a shared heap.
2. **Composition over duplication.** Almost no gameplay number is stored in a single place. A unit's effective strength combines personal stats, class bases, equipped weapon bonuses, and ring flags; skills come from character, class, and item bitfields; weapon ranks blend class defaults with Holy Blood tiers. Shared getters assemble these layers on demand behind a uniform interface.
3. **Separation of identity, gear, allegiance, and space.** Who a unit is lives in `aUnitRAMArea` ([include/Characters.h](../../include/Characters.h)); every weapon and staff lives in the global `aItemRAMData` table ([include/Items.h](../../include/Items.h)); army relations live per faction pair in `aFactionArea` ([include/Deployment.h](../../include/Deployment.h)); and where anyone stands on the map lives in `aDeploymentTable`.

## Chapters in Part I

1. **[A unit is made of parts](01-a-unit-is-made-of-parts.md)** — The four unit types (`Static`, `Dynamic`, `Holy`, `Enemy`), how each pairs a ROM template with a subset of the RAM pools, and the getters that let gameplay code ask any unit the same questions without knowing where its fields live.
2. **[Classes, stats, skills, and weapon ranks](02-classes-stats-skills-and-weapon-ranks.md)** — How class templates, rings, weapons, and Holy Blood compose behind shared queries, and why the same skill occupies different bit positions across character, class, and item tables.
3. **[Every sword is an individual](03-every-sword-is-an-individual.md)** — The 256-slot `aItemRAMData` table, how `ItemState` partitions one array into inventories, storage, shops, and the pawn shop, and how broken weapons keep their kill counts intact.
4. **[Armies and allegiance](04-armies-and-allegiance.md)** — The seven faction slots, pairwise hostility and alliance bitmasks, and how an army can be neutral to the player while fighting another faction.
5. **Who stands where** — The 72-entry `aDeploymentTable` structure of arrays, the handoff between residing in a castle and standing on the field, and the sixteen chapter locations (castles, villages, and gates).

Each chapter closes with the hard limits its layout imposes—and where in the source those limits are enforced.
