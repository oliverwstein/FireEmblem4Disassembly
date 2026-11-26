# Chapter 9: Moving a Unit

Picking up a unit computes, in one pass, every tile it can reach this turn and every tile its weapons can hit from those tiles. The inputs are the unit's movement stat, its class's movement type, the terrain under each tile, the units standing in the way, and any parts of the map the chapter has closed. The result is a 64 × 64 grid of bytes centered on the unit, the **movement map**. The blue and red overlay is a picture of that grid, choosing a destination is a lookup in it, and the path the unit walks is read back out of it by climbing from the destination to the unit.

The engine builds the grid with a **flood fill over a cost grid**. Tiles are visited in order of how much movement is left when they are reached, using one list per amount, so the first time the fill reaches a tile is by the cheapest route. This chapter gives the rules first, then the grids and the fill, the overlay, the path, and the walk. The computer armies use the same grids and the same path code.

## The rules of movement

### Movement points

The engine counts movement in tenths of a tile. A unit's budget is its class's movement plus 3 with the Leg Ring, times 10, plus 1:

| Class movement | Budget |
|---|---|
| 5 (mages, armor) | 51 |
| 6 (most infantry) | 61 |
| 8 (cavaliers, pegasus riders) | 81 |
| 9 (promoted knights, dragon riders) | 91 |

The budget comes from a 13-entry table (0 to 12), enough for the highest class movement, 9, plus the ring's 3. Entering a tile subtracts its cost, and the move is allowed only if at least 1 is left, so a unit can spend exactly its movement times 10. During Canto the budget is whatever was left over from the unit's first move (below).

### Terrain cost

Each class has a movement type, and each movement type has a row in a table of costs by terrain ([data/terrain/MovementCost.csv](../../data/terrain/MovementCost.csv)). A row entry is either `$80`, impassable, or an index into an eight-entry list of costs: 7, 10, 20, 30, 40, 50, 60, 70. Index 1, cost 10, is one full tile. Index 0, cost 7, is what roads and bridges cost every movement type except fliers, so a unit on a road goes farther than on plains: a cavalier with a budget of 81 covers 8 tiles of plains or 11 of road.

| Movement type (classes) | Plains | Forest | Mountain | Desert | Sea, river | Thicket | Road, bridge |
|---|---|---|---|---|---|---|---|
| Mounted, tier 1 (Cavalier, Troubadour, ...) | 10 | 30 | — | 40 | — | — | 7 |
| Mounted, tier 2 (Knight Lord, Paladin, ...) | 10 | 30 | 30 | 40 | — | — | 7 |
| Flying (pegasus and dragon classes) | 10 | 10 | 10 | 10 | 10 | 10 | 10 |
| Most foot classes (swordfighters, archers, soldiers, mages, thieves, ...) | 10 | 20 | 20 | 20 | — | — | 7 |
| Heavy infantry (Fighter, Warrior) | 10 | 20 | 20 | 30 | — | — | 7 |
| Armor | 10 | 20 | — | 30 | — | — | 7 |
| Barbarian, Hunter | 10 | 20 | 20 | 20 | — | 50 | 7 |
| Pirate | 10 | 20 | 20 | 20 | 50 | — | 7 |
| Ballistician | — | — | — | — | — | — | — |

The foot classes in the fourth row belong to several movement types that differ only in their cost for swamp. Peaks, cliffs, and Bragi's Tower are open only to fliers, and the guarding spot inside a castle and ramparts are closed to every movement type, fliers included. Units reach the guarding spot only through the guard command ([below](#moves-that-begin-at-a-castle)).

### Who stands in the way

Before the fill, every living, visible unit on the map is marked by its army's relation to the moving unit's army ([Chapter 4](04-armies-and-allegiance.md)):

- Its own army and allied armies: the unit can pass through the tile but not stop on it.
- Enemy and neutral armies: the tile is a wall.

Neutral units block movement even though they can't be attacked. The map's first and last columns and rows (rows 0 and 31 on the prologue's shorter map) are also marked as walls, which keeps the fill inside the map.

### Closed areas

A chapter can close parts of its map to the player. Bits 10 to 15 of each tile's word in the map data tag the tile with up to six areas, and `wAreaRestrictionBitfield` holds the areas currently open. For a player unit, a tile tagged with any closed area can be crossed but not stopped on. The chapters open areas as the story moves on, usually in the event that brings in the next army: Chapter 2 opens area 1 when Agusti's army appears, and Chapter 5 opens areas 1, 2, and 3 at three points in the chapter. Computer units ignore areas.

### Long-range weapons

A weapon's range becomes flags: range 1 sets bit 0, range 2 sets bit 1, and range 10 sets bit 2. Each weapon the unit can wield adds the flags for its minimum and its maximum range. Ranges 3 to 9 set nothing, which suits the weapons in the game: every range is 1, 2, 1–2, 1–10, or 3–10.

A unit that can wield a weapon reaching 10 tiles (a ballista, or the Meteor, Bolting, Blizzard, or Fenrir tome) doesn't move. Its movement map is replaced with a diamond of radius 10 around it, red at distances 3 to 10 and at 1 or 2 only if another of its weapons covers that distance. When the player picks up a player unit with such a weapon, its command menu opens at once, the same as for a unit with nowhere to go. Carrying such a weapon without being able to wield it (lacking the weapon rank, or silenced, for a tome) changes nothing. Ballisticians also have movement 0 and a movement type that can enter nothing.

### What the overlay shows

From every tile the unit can stop on, the fill marks the tiles at distance 1 and 2 that its weapons can hit and that it can't move to; these show red. Staves don't add red tiles. When the player picks up a unit of another army, the engine also checks for a Silence, Sleep, Berserk, or Thief staff that unit could use, and if it finds one, colors every tile within 10 of the unit that isn't already marked in a third color.

## The range maps

The fill uses two 64 × 64 byte grids in bank `$7F`. They sit in a block of such grids that the AI also uses for its own maps ([Chapter 14](14-armies-with-a-mind.md)):

```
  $7F/654A  aRangeMap           what stands on each tile (input to the fill)
  $7F/754A  aMovementMap        movement left on each tile (the result)
  $7F/854A  aTargetDistanceMap
  $7F/894A    ├ 128 list heads  one per amount of movement left
  $7F/8A4A    └ list entries    4 bytes each: next entry, tile index
```

The grids are centered on the unit's tile, at column 32, row 32, so the unit's tile is index 32 × 64 + 32, and the four neighbors of index `i` are `i − 64`, `i − 1`, `i + 1`, and `i + 64`. Code that turns a map tile into a grid index subtracts the unit's position, adds 32, and keeps the low six bits of each coordinate. (The overlay code gets the same result by subtracting the unit's position plus 32, the right edge of its window: modulo 64, subtracting 32 and adding 32 are the same.) The grid therefore wraps around, and a window of tiles around the unit (`wMovementMapWindowLeft` to `Bottom`) decides which tiles count as inside it.

The two grids use these values:

| Grid | Value | Meaning |
|---|---|---|
| `aRangeMap` | 0 | empty |
| | 1 | a unit of the mover's army or an ally |
| | `$FE` | the map's edge |
| | `$FF` | an enemy or neutral unit |
| `aMovementMap` | 0 | out of reach |
| | 1–`$7F` | can stop here, with this much movement left |
| | `$80` | can only attack here |
| | `$80` + n | in a closed area: can pass with n left, can't stop |
| | `$FF` | within 10 of another army's unit with a long-range staff |

### A flood fill with one list per amount left

Costs vary from 7 to 50, so the route with the fewest tiles isn't always the cheapest. The engine finds the cheapest with a **bucket queue**, a form of Dijkstra's algorithm suited to small whole-number costs. There are 128 lists, one for each amount of movement left (the largest budget is 121). The fill takes the lists from the highest amount down, and every tile it reaches goes into a lower list. A tile is written into the movement map the first time it is reached, and nothing reached later can have more movement left, so the first visit is final and needs no correction.

```rust
fn fill_movement_map(budget: u8) {                    // rsFloodFillMovementMap
    let start = 32 * 64 + 32;                         // the unit's tile
    aMovementMap[start] = budget;
    lists[budget].push(start);                        // list heads at $7F/894A
    for left in (7..=budget).rev() {                  // most movement left first
        for tile in lists[left] {
            for next in [tile - 64, tile - 1, tile + 1, tile + 64] {  // rsSpreadMovementToNeighbours
                if aMovementMap[next] != 0 { continue; }   // reached already, with at least as much left
                if aRangeMap[next] >= 0x80 { continue; }   // enemy, neutral, or edge
                let cost = tile_cost(next);                // rsGetTileMovementCost
                if cost == IMPASSABLE || cost >= left { continue; }
                let mut rest = left - cost;
                lists[rest].push(next);
                if area_closed(next) { rest |= 0x80; }     // rsCheckTileAreaRestriction (player units)
                aMovementMap[next] = rest;
            }
        }
    }
}

fn tile_cost(tile) -> u8 {                            // rsGetTileMovementCost
    let word = aMapData[map_index(tile)];
    let terrain = aTerrainTileset[word & 0x3FF];      // 26 terrains; higher values count as 0
    let entry = movement_type_row[terrain];           // from the class's movement type
    if entry & 0x80 != 0 { return IMPASSABLE; }
    aTileMovementCosts[entry]                         // 7, 10, 20, 30, 40, 50, 60, 70
}
```

A tile in a closed area goes into its list with the flag stripped, so the fill continues through it; only the stored value carries the flag. Each tile enters a list at most once, and the entries have room for 704 tiles. The farthest any unit can reach is 17 tiles (a budget of 121 spent at 7 a tile on road), and a diamond of radius 17 holds 613 tiles.

### Attack tiles

After the fill, if the unit has any range flags, the engine walks the list entries in the order they were made, which is every tile the fill reached. From each tile the unit can stop on (flag clear, nobody standing there), it marks `$80` on each tile at distance 1 (with bit 0) and distance 2 (with bit 1) that has a movement value of 0 and isn't the map's edge. Tiles holding enemy units qualify, so enemies in reach show red. The moving unit's own tile counts as empty: the unit is hidden as soon as it is picked up, so it isn't marked in `aRangeMap`.

On the player's phase, with a unit of another army picked up and a long-range staff found, the engine then marks `$FF` on every tile still at 0 within distance 10 of the unit's tile, using a table of row widths 1, 2, ..., 11, ..., 2, 1.

### The fixed range for long-range weapons

A unit with range bit 2 skips the normal fill. The same fill routine runs with a fixed cost of 10 per tile, a budget of 101, and no units marked, which reaches every tile within 10 regardless of terrain. A second pass then sets each tile by its list: the unit's tile to 1, distance 1 and 2 to `$80` or 0 depending on bits 0 and 1, and distances 3 to 10 to `$80`.

### Can it move at all

The last check reads the four tiles next to the unit in the movement map. If none holds a value from 1 to `$7F`, the unit has nowhere to go, and the build returns that result; the fixed-range build always returns it. For a unit of the army whose phase it is, the pick-up code then puts the unit down on its own tile and opens its command menu at once.

## Drawing the overlay

The overlay is background layer 3, blended over the map with color math. Each square of the grid becomes a tile in one of three palettes:

| Movement map value | Palette | Color |
|---|---|---|
| 1–`$7F` | 2 | blue |
| `$80` | 3 | red |
| `$80` + n, `$FF` | 1 | a third color, different for player units and units of other armies |
| 0 | — | blank |

While a unit is picked up, the map's upkeep routine cycles all three palettes' colors by the frame counter, which makes the overlay pulse. The overlay is built and streamed a row or column at a time as the camera moves, alongside the map's own tiles ([Chapter 22](22-a-map-bigger-than-the-screen.md)).

## From destination to path

### Choosing a destination

With a unit of the active army picked up, A on a tile accepts it as a destination if the tile is inside the window, its movement value has bit 7 clear and isn't 0, and no other unit stands on it. That rules out tiles out of reach, attack tiles, closed areas, and tiles with allies on them. A rejected tile plays an error sound. With a unit of another army picked up, A puts it down: the player can pick up any unit that hasn't acted and isn't asleep to look at its range, but only move units of the active army.

While a unit is picked up, a held direction moves the cursor only from a tile in the unit's movement (blue, or a closed area) to another such tile, so holding a direction stops the cursor at the edge of the unit's movement. A new press moves it anywhere, and so does a held direction with Y held, which skips the check along with the repeat delay.

### Building the path

The path is read out of the movement map by climbing. From the destination, each step looks at the four neighbors and moves to the one with the most movement left, ignoring the closed-area flag. Every step climbs, and only the unit's own tile has nothing higher around it, so the climb ends there. Its directions are written to `aMovementPath` from the destination backwards, as the direction the unit will travel on that step.

```rust
fn build_path(dest) {                                 // rsBuildMovementPath
    let mut tile = dest;
    let mut best = aMovementMap[dest] & 0x7F;
    let order = if frame_count & 1 == 0 {             // ties go to the first in the order
        [ABOVE, BELOW, LEFT, RIGHT]
    } else {
        [LEFT, RIGHT, ABOVE, BELOW]
    };
    let mut steps = 0;
    loop {
        let mut found = None;
        for side in order {
            let left = aMovementMap[tile + side] & 0x7F;
            if left > best { best = left; found = Some(side); }
        }
        let Some(side) = found else { break };        // at the unit's tile
        aMovementPath[steps] = opposite(side);        // PATH_DOWN if the higher tile was above
        tile += side;
        steps += 1;
    }
}
```

Among equally cheap routes, the frame on which A was pressed picks one: on even frames the climb prefers vertical neighbors, on odd frames horizontal ones. The path has room for 32 steps, almost twice the longest reach.

## Walking and arriving

Once the path is built, the overlay is hidden and the cursor travels back to the unit at 8 pixels a frame, one tile per step (cursor state 1). The walk (state 2) then reuses the cursor's stepping code: it reads the path from its last entry, which is the first step out from the unit, merges each run of steps in the same direction into one distance, turns the moving sprite to face that way, and moves the cursor along the run with the sprite drawn at the cursor. The map scrolls at the screen's margins as it does for the cursor. A unit whose speed stat is 5 or more walks at 3 pixels a frame, any other at 1. A walking sound chosen by the unit's map sprite plays throughout, panned to the cursor's side of the screen, with a water flag set on sea, river, and swamp for units that don't fly.

At the end of the path, the unit's deployment row is moved to the cursor's tile ([Chapter 5](05-who-stands-where.md)) and its command menu opens ([Chapter 10](10-menus-over-the-map.md)). The move isn't final until a command ends the unit's action. Until then, B in the command menu puts the unit back on the tile it started from, and the player can pick it up again.

B before a destination is chosen puts the unit down where it stands. The tile the unit returns to is the one it was picked up from, which the cursor code keeps as the move's origin.

### Moves that begin at a castle

A castle has two tiles that matter to movement: the location's own tile, the **guarding spot**, which no movement type can enter, and the **gate**, two tiles below it, where units stand to enter or seize the castle ([Chapter 5](05-who-stands-where.md)). Four commands put a unit on one of them without walking: sortie from the castle screen, depart, and guard from the command menu or from the castle screen. Each records how the move began in `wMapActionMode` (`MAP_ACTION_MODE_*` in [include/Map.h](../../include/Map.h)), and undoing the move reads it to put the unit back where it came from. The mode is cleared when the unit's action ends.

**Sortie and depart.** Sortie places a unit from inside the castle on the gate (mode 1). Depart takes a guarding unit off the guarding spot and onto the gate (mode 2); the command is offered only when the gate is empty. On the next frame the cursor travels to the gate and picks the unit up there. From that point:

- B with the unit picked up sends it back: inside the castle after a sortie, guarding again after depart.
- After a move, B in the command menu returns the unit to the gate and picks it up again, so a second B sends it back.
- If the unit has nowhere to go from the gate, its command menu opens at once, and B in it sends the unit back directly.

The guard command isn't offered to a unit that has just departed.

**Guard.** The guard command moves the unit onto the guarding spot at once, but the unit isn't guarding yet. Guarding starts when its action finishes on that tile, which is how the engine recognizes it: any unit whose action ends on a guarding spot starts guarding there. After the command, the cursor travels to the unit, a walk with no steps ends on its tile, and the command menu opens again in a second mode for the guard ([Chapter 10](10-menus-over-the-map.md)). B in that menu undoes the guard according to how the move began:

| Guard chosen | Mode | B in the guard menu |
|---|---|---|
| in the command menu after an ordinary move | 4, cleared when the walk ends | back to the tile the unit was picked up from, put down |
| after a sortie | 5, which B turns back into 1 | back to the gate and picked up; another B sends it inside |
| on the castle screen | 3 | back inside the castle, normally (next paragraph) |
| in the home-castle menu (see The home castle) | 5 or 9 | back to the gate, and the home-castle menu opens again |

The castle-screen row has a catch. Before going back inside, the undo checks whether the unit could move, using the four tiles next to the center of the movement map. Nothing has rebuilt that map since the castle screen, which keeps its item lists in the same memory and clears it each time it opens. Those four bytes stay 0 unless a list of at least 93 items was shown, so the unit normally goes back inside. With a value from 1 to `$7F` left in one of them, the undo instead puts the unit on the gate and picks it up, still in mode 3.

**The home castle.** A player unit whose action ends on the gate of its own army's home castle doesn't finish its action. Its command menu opens again in a mode that B can't close, from which it can still enter or guard. The same mode opens for a Canto unit with nowhere to go. A computer unit that ends its action on its home castle's gate goes inside.

### Canto

After an attack or a staff use that it started on the map, a unit with the `Canto` skill (personal, class, or from an item) that is still alive, awake, and not already in a Canto move gets a second move. Its budget is the movement map's value on the tile it acted from, which is the movement left after its first move, and it is stored in the unit's personal data. A cavalier with a budget of 81 that crossed 3 plains tiles to attack has 51 left, enough for 5 more tiles.

The battle code stores the budget, and the map step picks the unit up again on a later frame ([Chapter 8](08-the-turn.md)). Its range maps are built from the stored budget with no range flags, so a Canto move shows only blue. If the Canto budget leaves it nowhere to go, its command menu opens instead. B can't cancel a Canto move: it sends the cursor to the unit and opens its command menu. After a Canto move, B in the command menu returns the unit to where the Canto move began and picks it up again.

## Computer units

A computer unit's move goes through the same code. The AI's move step sends the cursor to the unit, picks it up (building the same range maps, without drawing the overlay), and then runs the player's destination check on the destination the AI chose, with the camera moved there for the call. If the check passes, the path is built and the unit walks it at the speed of the enemy speed option. If the check fails, the next byte is a `brk` instruction, and the game stops. The AI's own planning therefore has to agree with the movement map: a destination within reach, on a tile that isn't an attack tile and has no unit on it.

The castle commands have computer versions among the AI's actions. Action 6 runs the same guard routine with a nonzero argument, which finishes the unit's action on the guarding spot at once, so it starts guarding. Action 7 takes a guarding unit off its spot and inside.

## Trade-offs and hard limits

One fill answers every question the player can ask while a unit is picked up: whether a tile is reachable, how much movement is left there, what can be attacked, and which way to walk. The path costs nothing extra to find, because the movement map already holds the remaining movement on every tile, and climbing it retraces a cheapest route. Canto reuses the same number as its budget.

The bucket queue depends on small whole-number costs. With 128 lists it can't represent a budget above 127, and the smallest cost of 7 bounds how many tiles a budget can reach. The grid is 64 × 64 around the unit, so a reach of up to 31 tiles in each direction would fit; the largest is 17.

Building the attack tiles from every reachable tile looks only at distances 1 and 2. Ranges 3 to 10 have no place in that pass; a unit with such a weapon gets the fixed diamond instead and can't move.

The limits:

- **Movement 0 to 12 after the Leg Ring.** The budget table has 13 entries; the highest class movement is 9.
- **Budget at most 127.** 128 list heads, one per amount left; the largest budget used is 121.
- **704 list entries.** Each reached tile takes one; a reach of 17 tiles fills at most 613.
- **32 path steps.** `aMovementPath` is 64 bytes, two per step.
- **Six closed areas.** Bits 10 to 15 of the map word; they apply only to player units.
- **Range flags for 1, 2, and 10 only.** Other ranges set no flag.
- **A computer unit's destination must pass the player's check.** Otherwise the game executes `brk`.

## Where it lives in the source

- [engine/map/range_maps.asm](../../engine/map/range_maps.asm): building the range maps, the flood fill and its lists, terrain costs (`aTileMovementCosts`), closed areas, attack tiles, the fixed range for long-range weapons, and the staff diamond.
- [engine/map/unit_movement.asm](../../engine/map/unit_movement.asm): picking up a unit, the overlay's window and color math, the destination check, building the path, the walk and its speed, undoing a move, walking sounds, and the computer phase's moves.
- [engine/map/map_cursor.asm](../../engine/map/map_cursor.asm): the cursor's states and stepping, the stop at the edge of the range, and the overlay's pulsing colors.
- [engine/map/map_tilemap.asm](../../engine/map/map_tilemap.asm): building the overlay's rows and columns from the movement map.
- [engine/map/input.asm](../../engine/map/input.asm): A and B with a unit picked up, including sending a unit back into its castle or to guarding.
- [engine/map/map_actions.asm](../../engine/map/map_actions.asm): the guard, depart, and return commands.
- [engine/map/deployment.asm](../../engine/map/deployment.asm): `rlTryStartUnitCanto` and the Canto budget; `rlFinishUnitAction`, which starts guarding and reopens the menu at the home castle.
- [engine/units/stats.asm](../../engine/units/stats.asm): the movement budget and the Leg Ring; [engine/units/unit_info.asm](../../engine/units/unit_info.asm): the class's movement cost row.
- [engine/items/inventory.asm](../../engine/items/inventory.asm): range flags from the inventory's weapons and staves.
- [engine/events/event_engine.asm](../../engine/events/event_engine.asm): `REMOVE_AREA_RESTRICTION` and `SET_AREA_RESTRICTION`.
- [data/terrain/MovementCost.csv](../../data/terrain/MovementCost.csv): costs by movement type and terrain; [include/Terrain.h](../../include/Terrain.h): the terrain IDs.
- [include/Map.h](../../include/Map.h): `MAP_ACTION_MODE_*` and the cursor states; [include/WRAM.h](../../include/WRAM.h): `aRangeMap`, `aMovementMap`, `aMovementPath`, `wMovementMapWindow*`, `wAreaRestrictionBitfield`, `wMapActionMode`.
- [docs/reference/map.md](../reference/map.md): the reference page.

---

← Previous: [Chapter 8: The Turn](08-the-turn.md) | [Contents](OUTLINE.md) | Next: [Chapter 10: Menus over the Map](10-menus-over-the-map.md) →
