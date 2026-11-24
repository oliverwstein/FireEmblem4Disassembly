# Chapter 5: Who Stands Where

A unit's record in `aUnitRAMArea` ([Chapter 1](01-a-unit-is-made-of-parts.md)) holds who the unit is, not where it stands. Board state—whether a unit is waiting inside a castle or standing on a map tile, its per-frame sprite and turn flags (alive, hidden, has acted, asleep, guarding), and the castles and villages that change owners or suffer raids—lives in separate structures.

This chapter covers the two tables that hold that state: the 72-row **deployment table**, which records where each unit is and how it is drawn, and the 16-entry **location table**, which records who owns each castle and what has happened to each village.

## The deployment table

`aDeploymentTable` ([include/WRAM.h](../../include/WRAM.h)) is a structure of arrays: ten columns of 72 words each, one row per unit that has a place on the map.

| Column | Holds |
|---|---|
| `_State` | flags (alive, hidden, defeated, has acted, Canto, asleep, guarding a castle), the relation to the player in the low two bits ([Chapter 4](04-armies-and-allegiance.md)), and an AI formation ID |
| `_XTilePosition`, `_YTilePosition` | the tile |
| `_XPixelPosition`, `_YPixelPosition` | the same position in pixels, tile × 16, which a moving sprite steps through |
| `_MapSpriteSlot` | the row of `_MapSpriteID` this unit is drawn with |
| `_UnitRAMPointer` | the unit's header ([Chapter 1](01-a-unit-is-made-of-parts.md)); 0 marks a free row |
| `_FactionSlot` | the unit's army |
| `_MapSpriteID` | not per unit: the pool of distinct map sprites in use |
| `_StateBuffer` | a second copy of `_State`, written during a battle or a staff and copied over at the next step of the turn (`rlApplyBufferedDeploymentStates`) |

A unit's row number, doubled, is its **deployment offset**. The unit stores it in the `DeploymentOffset` byte of its personal data (`$FF` if it has no row), and code puts it in the `X` register to read any column in one instruction: `lda aDeploymentTable._XTilePosition,x`, then `lda aDeploymentTable._State,x`. The [introduction](00-introduction.md) explains why the 65816 favors this layout: with the offset already doubled, no column needs a multiply.

The table splits the unit into *who* and *where*. The unit record answers questions about stats, items, and allegiance; the deployment row answers what the map needs every frame. `rlDrawDeployedUnitMapSprites` walks the rows in VBlank, skipping hidden ones, and draws each sprite at its pixel position in a palette chosen by the two allegiance bits, grayed if the unit has acted or is asleep. It reads only deployment columns, never a unit record.

### Finding a unit

There is no grid of units on the map. To learn who stands on a tile, `rlGetUnitByCoordinates` walks the rows from the last to the first and returns the first live unit at those coordinates:

```rust
fn unit_at(x: u8, y: u8) -> Option<UnitPtr> {        // rlGetUnitByCoordinates
    for row in (0..72).rev() {
        let state = aDeploymentTable.state[row];
        if state.contains(Alive)
            && aDeploymentTable.x_tile[row] == x
            && aDeploymentTable.y_tile[row] == y {
            return Some(aDeploymentTable.unit_ram_pointer[row]);
        }
    }
    None
}
```

That is 72 comparisons per lookup, fine for the cursor. Code that asks the question for many tiles at once, such as the range search, the AI's threat and movement maps, and target selection, first builds a grid from the table (`rlBuild32x32MapUnitGrid` fills a 32 × 32 window around a point with deployment offsets) and then reads the grid ([Chapter 9](OUTLINE.md), [Chapter 14](OUTLINE.md)).

### Shared sprites

Seventy-two units don't need seventy-two sets of sprite graphics: a dozen Verdane axe fighters all look alike. `_MapSpriteID` is therefore not a per-unit column but a pool. When a unit is deployed, `rlAddDeployedMapSprite` searches the pool for its sprite ID and, if no row holds it yet, claims a free one (`$FFFF`). The unit's `_MapSpriteSlot` stores the row it found. Short sprites use rows 0 to 47; tall sprites, marked by bit 15 of the ID, search from row 71 down. Each row has a fixed place in video RAM (`aShortMapSpriteSlotTiles`, `aTallMapSpriteSlotTiles`), so every unit that shares a row is drawn from the same tiles.

## In a castle and on the field

A unit waiting inside a castle still has a deployment row. `rlSetUnitResidingInCastle` clears the unit's `UnitStateFielded` flag, records the castle in its `ResidingCastle` byte, sets the row hidden and not alive, and moves it to the castle's tile, saving the old tile in `wSavedDeploymentXTile` and `wSavedDeploymentYTile`. The drawing loop skips it, and `rlGetUnitByCoordinates` doesn't find it.

Sending it out reverses the change. `rlDeploySelectedUnit` sets `UnitStateFielded` again, and since the unit already has a row, it marks the row alive and visible and moves it to the tile it is sent to. Only a unit with no row (`DeploymentOffset = $FF`) gets a new one, through `rlDeployUnit`. A unit therefore keeps the same row while it goes in and out of castles, and loses it only when it is deleted.

```
                        UnitStateFielded   _State              where
waiting in a castle     clear              hidden, not alive   castle tile
on the field            set                alive               its tile
defeated                (as it was)        defeated            hidden on the map
```

## Locations

A chapter's castles and villages are its **locations**. Each chapter lists up to 16 of them in ROM: a table of pointers in [data/chapter/](../../data/chapter/) to entries in the chapter's event file, here [events/Chapter01.asm](../../events/Chapter01.asm). Chapter 1's are Evans, Nordion, Genoa, Marpha, and Verdane castles and three villages:

```
.structChapterCastleLocationEntry  Ch01_Evans, EvansName, [46, 11], $FC, aChapter01ShopData
.structChapterVillageLocationEntry Ch01_Village1, [47, 31]
```

Each entry gives an ID (0 to 15), a type, and a tile; a castle adds its name and its shop list ([Chapter 3](03-every-sword-is-an-individual.md)). The type indexes a table of type data (`aEventLocationTypeOffsets`): starting gold, and offsets from the location's tile to where its graphics start, where a unit stands to enter it, and which tiles change when it is destroyed. Seven types exist in that table, but the chapters use only two: 59 castles (type 0) and 73 villages (type 2).

What changes during play is held in two arrays indexed by location ID. `aChapterLocationRAMData` has one byte per location:

| Bits | Meaning |
|---|---|
| `$07` | owning faction slot (`LocationFactionSlotOwnerMask`) |
| `$08` | destroyed (`LocationDestroyed`) |
| `$20` | village visited and closed (`VillageClosed`) |
| `$40` | set when an army seizes a castle (`LocationState40`); no routine reads it, and its check routine, `rlCheckLocationState40`, has no callers |
| `$80` | a unit is guarding the castle (`CastleGuarded`) |

`aChapterLocationMoneyRewards` holds a word per location: the gold it still has. `rlInitLocation` sets it from the type's starting gold (5,000 for a village, 0 for a castle), and for a castle, moves its shop's unobtained items into the shop.

The map actions ([engine/map/map_actions.asm](../../engine/map/map_actions.asm)) read and write these two arrays:

- **Visit** (`rlUnitVisitVillage`): closes the village, gives its remaining gold to the visitor, and runs the chapter's village events.
- **Raid** (`rlUnitRaidVillage`, computer units only): takes 500 gold. When the gold reaches 0, the village is marked destroyed and its tiles change. A village survives nine raids and falls to the tenth, and a player who arrives after a few raids receives what is left.
- **Seize** (`rlUnitSeizeCastle`): makes the seizing unit's army the castle's owner. When the player seizes a castle, captured characters are freed; when another army seizes one of the player's castles other than location 0, the castle is destroyed and its tiles change.
- **Guard** and **depart**: a unit standing on the castle's tile sets or clears `CastleGuarded`. While a castle is guarded, it can't be seized.

Ownership feeds back into the factions: an army's home castle is a location ID, castle income counts the castles held by the player and its allies ([Chapter 4](04-armies-and-allegiance.md)), and the save file stores all 16 location bytes.

## Arriving on a tile

Some events fire when a unit reaches a place. In Chapter 1, if Lex ends a move on one tile of a peninsula, (28, 37), a fairy trades his Iron Axe for a Brave Axe. The chapter's event list ([events/Chapter01.asm](../../events/Chapter01.asm)) states the condition as a rectangle one tile wide:

```
CHECK_UNIT_IN_AREA FlagChapter01_LexOnPeninsula, Lex, pack([28, 37]), pack([28, 37])
  EVENT FlagChapter01_LexBraveAxe, EventChapter01LexBraveAxe
```

Nothing searches the map for Lex. Every way a unit's action can end (waiting, attacking, visiting, seizing) goes through `rlFinishUnitAction`, which grays the unit and leaves its deployment offset in `wActionEndedDeploymentOffset`. On a later frame, once any battle, popup, or Canto move has finished, the turn loop ([Chapter 8](OUTLINE.md)) reads that note and announces the unit's arrival to the event system:

```rust
fn run_action_ended_events() {                       // rsRunActionEndedEvents
    let row = wActionEndedDeploymentOffset;
    if row == NONE { return; }
    bEventActionIdentifier = 3;                      // "a unit ended its action on a tile"
    wEventEngineArgument1 = character_id(row);
    wEventEngineArgument2 = aDeploymentTable.x_tile[row];
    wEventEngineArgument3 = aDeploymentTable.y_tile[row];
    wEventEngineArgument4 = aDeploymentTable.faction_slot[row];
    run_chapter_map_event_conditions();              // rlGetAndRunChapterMapEventConditions
    wActionEndedDeploymentOffset = NONE;
}
```

Each condition in the chapter's list first compares its own action number with the announced one, so only conditions about units ending their action look further. It then skips itself if its flag is already set, and `CHECK_UNIT_IN_AREA` compares the four arguments with its parameters: the character (or any), the army (or any), and whether the tile lies inside the rectangle. On a match it sets its flag and runs the event ([Chapter 11](OUTLINE.md)).

The test happens once, at the end of the action, on the unit's final tile, so walking across (28, 37) without stopping there does nothing. The flag keeps the event from running twice. Lex's event uses that: if he has no Iron Axe to trade, the script clears both of its flags (`UNSET_FLAG_IF_IN_CHAPTER`), and the condition can match again the next time he stops on the tile.

## Trade-offs and hard limits

Splitting *where* from *who* keeps the per-frame work small: drawing and cursor lookups read only the deployment table, with the column layout letting one index reach every field. The cost is a third copy of some facts (a unit's army is in its personal data, its faction slot's list, and its deployment row) and lookups by tile that scan all 72 rows unless a grid is built first.

The limits:

- **72 deployment rows.** A unit keeps its row for life, so units waiting in castles count against the 72 as well. `rsAddUnitToDeploymentTable` sets carry when no row is free. `rlDeployUnit` also compares the deployed count with `$058B` before trying, but `$058B` is the address of the count variable itself, so that check never fails.
- **72 distinct sprites, at most 48 of them short.** Short sprites must fit in rows 0 to 47; tall sprites search from row 71 down and can take any free row, including those. `rlAddDeployedMapSprite` halts with `brk` if no row is free.
- **16 locations per chapter.** Only castles and villages are used.
- **Village gold in steps of 500.** Raids take a fixed 500, so a village's fate depends only on how many raids reach it.

## Where it lives in the source

- [include/WRAM.h](../../include/WRAM.h): `aDeploymentTable`, `aChapterLocationRAMData`, and `aChapterLocationMoneyRewards`.
- [include/Deployment.h](../../include/Deployment.h): the `DeploymentState*` flags.
- [include/Chapters.h](../../include/Chapters.h): location entry structs, type data, and the location state bits.
- [engine/map/deployment.asm](../../engine/map/deployment.asm): adding units to the table, the shared sprite pool (`rlAddDeployedMapSprite`), moving units, hiding, and defeat.
- [engine/map/map_sprites.asm](../../engine/map/map_sprites.asm): drawing and animating the map sprites.
- [engine/map/locations.asm](../../engine/map/locations.asm): location data, owners, gold, and tile changes.
- [engine/map/map_actions.asm](../../engine/map/map_actions.asm): visit, raid, seize, guard, and depart.
- [engine/units/unit_state.asm](../../engine/units/unit_state.asm) and [level_up.asm](../../engine/units/level_up.asm): `rlSetUnitResidingInCastle` and `rlDeploySelectedUnit`.
- [docs/reference/map.md](../reference/map.md): the reference page.
