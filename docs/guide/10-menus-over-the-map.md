# Chapter 10: Menus over the Map

Every command the player gives on the map goes through a **map menu**, a window drawn over the map on two background layers and owned by a proc. A unit's turn is a chain of them: the command menu after the move, the item list behind attack or staff, target selection with the battle forecast, and the action itself. Each link in the chain is created when the previous one hands off and freed when it finishes, and B moves back along the chain by reopening the link before it.

The **unit command menu** sits at the center of the chain. It has 24 possible commands, and nothing stores which ones a unit has: each time the menu opens, 24 check routines decide from the unit, its tile, its inventory, and its neighbors which commands to list. This chapter gives those rules first, then the framework every map menu is built on, how the command menu is assembled, how the player goes back, target selection and the forecast, the item list, the main map menu, and the side windows and popups.

## The commands

The command menu lists, top to bottom, every command whose check passes:

| Command | Listed when | Chosen |
|---|---|---|
| はなす talk | a talk event with a unit in range 1, or between a guarding unit and a unit on its gate | choose a target |
| たすける help | a civilian or child is adjacent | choose a target; 100 experience and an event |
| とつげき assault | the unit guards a castle, or stands on the gate of a guarded enemy castle, and has a weapon with a minimum range of 1 (range 1 or 1–2) to strike the enemy two tiles away | item list, then a target |
| こうげき attack | a weapon with a target in range | item list, then a target |
| つえ staff | a usable staff with a target, at least one of them a support staff | item list, then a target |
| おどる dance | the unit has Dance, and an adjacent unit of its army has moved | acts at once |
| はいる enter | on the gate of a castle of its own army or an ally | the unit goes inside |
| せいあつ seize | on the gate of an enemy castle that is neither destroyed nor guarded, and the unit is a Knight Lord or a Junior Lord | the castle changes owner |
| まち town | at a location of type 1 | the castle screen |
| むら village | at a village that is neither destroyed nor closed | the village's gold and event |
| しゅび guard | on the gate of an unguarded castle of its own army or an ally, unless the unit has just departed | the unit moves to the guarding spot |
| しゅつげき depart | guarding a castle, with the gate empty | the unit moves to the gate |
| はなす talk | no talk event, but an adjacent unit is the unit's own talk target | choose a target |
| たいき wait | unless on the gate of its army's home castle; always on a guarding spot | ends the action |
| つえ staff | usable staves with targets, all of them offensive (Silence, Sleep, Berserk, Thief) | item list, then a target |
| もちもの items | a usable item (none exists) | item list |
| あげる give | a unit with Steal and gold, next to a unit of its army with less than 50,000 | choose a target; all the gold moves |
| あげる give | a unit without Steal and with gold, next to its lover with less than 50,000 | as above |
| のる mount | the unit is dismounted | changes class, menu reopens |
| おりる dismount | the unit can dismount and is mounted | changes class, menu reopens |
| そうび equip | two or more weapons it can wield | item list; menu reopens |
| アニメ animation | always | the animation setting |
| 城にもどる return | the unit or one of its items has Return, and it isn't guarding or at its own castle | warps to its army's castle |
| 城にもどる return | guarding its army's own castle | goes inside |

The staff command appears in one of two places, decided by whether any usable staff has a support effect (healing, Restore, Warp, Return, Fortify, and the rest). The two give commands share a label and differ in who can receive: a unit with Steal gives to anyone in its army, any other unit only to its lover. The receiver keeps what fits under 50,000 and the rest goes back to the giver.

Several of these rules are narrower than the labels suggest:

- **Seize** checks the class: Knight Lord or Junior Lord. Sigurd and Seliph are the only characters whose data uses those classes.
- **Dismount** needs a personal skill bit (`UnitSkill1Dismount`) and a class skill (`ClassSkillDismount`). The only class with the class skill is Knight Lord, and no character's data sets the personal bit; the generation change sets it in Seliph's data alone. Dismounting turns a Knight Lord Seliph into a Junior Lord, and mounting turns him back.
- **Items** never appears. An item counts as usable when its staff effect has a target, and every non-staff item in the item data has no staff effect. The use-or-discard menu behind the command is unreachable as a result.
- **Talk** appears in two places. The upper one is for talk events written into the chapter's data; the lower one is for a unit's own talk target, the character ID stored in its personal data ([Chapter 1](01-a-unit-is-made-of-parts.md)) and cleared once used. A talk event also reaches across a castle: a guarding unit and a unit on that castle's gate are two tiles apart and can still talk.
- **Town** needs location type 1, which no chapter uses ([Chapter 5](05-who-stands-where.md)).

During a Canto move, every slot list except equip is left empty, so attack, assault, staff, and items drop out. Dance also checks for Canto, and both talk commands are allowed in Canto even in mode 1.

### Three modes

The menu opens in one of three modes, read from bits 3 and 4 of `wMapStateFlags`:

| Mode | Opened | Changes |
|---|---|---|
| 0 | after a move, or after B from a submenu | none |
| 1 | when a player unit's action ends on the gate of its army's home castle, or a Canto unit has nowhere to go | B can't close the menu; attack, both staff commands, items, dance, help, give, and the Return skill's command are left out, and talk unless in Canto |
| 2 | after the guard command, with the unit on the guarding spot | attack, both staff commands, and the Return skill's command are left out; B undoes the guard |

Mode 1 enforces a rule: a player unit can't end its turn standing on its own home castle's gate. Wait is already missing there in mode 0, and when another command (an attack, say) ends the action on that gate, the action-ending code reopens the menu in mode 1 instead of finishing ([Chapter 9](09-moving-a-unit.md)). On the gate, the mode-1 menu lists enter, guard if nobody guards the castle, equip, animation, and Seliph's mount or dismount. Equip and animation both reopen the menu in mode 1, so the turn ends only when the unit enters or guards.

In mode 2 the unit stands on the guarding spot, which is no location's gate, so every location command fails; wait is listed because the guarding spot is terrain 9, and choosing it finishes the action there, which starts guarding. Mode 2 lists wait, equip, animation, and whichever range-1 commands find a neighbor.

## A map menu

A map menu is described in ROM by a `structMapMenu`: long pointers to palette, graphics, and tilemap data, a frame type, and a position in tiles. The tilemap data gives the menu's size in tiles, the background buffer it draws into, and a RAM buffer in bank `$7F` that holds the menu's own tiles. Loading a menu copies the description into RAM, so a menu can be moved and resized, and points `lMapMenuRAMEntryPointer` at the copy. Every drawing routine works on that current menu.

Each menu is drawn on two layers:

- Its **contents** (text, numbers, gauges) go to background 3 as tiles, copied from the menu's RAM buffer, skipping one transparent tile so menus underneath show through.
- Its **frame** goes to background 2, drawn by a routine chosen by the frame type: seven types of window, plus one for dialogue boxes.

The open menus form a linked list (`lMapMenuListHead`, then each menu's `Next`), drawn from the head, so the last menu is in front. Moving, hiding, showing, or resizing a menu clears the rows it covered and redraws, back to front, every open menu that overlaps those rows. The changed rows are kept as a range (`wMapMenuDirtyTop` to `wMapMenuDirtyBottom`), and the VBlank routine uploads only that range of the background buffer to video memory.

```
  BG2   ┌────────┐            frames, one routine per type
        │        │ ┌──────┐
        └────────┘ │      │
  BG3     こうげき   └──────┘   text and numbers, transparent tile skipped
          たいき
                  list: main menu → forecast → item list   (last is in front)
```

The RAM buffers are fixed by each menu's definition, with no allocator to hand them out. Menus that can't be open at once share one: the main map menu, the command menu, the item-use menu, and the item description box all keep their tiles at `$7FCD4A`, and the item list closes its description box when it opens the item-use menu.

### Menus as procs

Every map menu belongs to a proc. The proc's definition is followed by a long pointer to the menu description, a byte, and, for list menus, a long pointer to an option list. The init routine loads the menu and swaps in an on-cycle routine that waits until the menu's palette and graphics have been loaded and decompressed, then puts the proc's own routine back. Later frames handle input, redraw on a bit in the proc's bitfield, or close.

A nonzero byte makes the menu hold the map while it is open. The proc saves `wGameStateRoutine1` in its body and sets it to 0, which stops the map step ([Chapter 8](08-the-turn.md)) the same way the phase banner does; closing the menu puts the routine back. List menus hold the map unconditionally. While the command menu is up, the map step, its notes, and the cursor all wait.

### Option lists

A list menu's options live on a stack in allocated RAM. Pushing a list reads a template: a capacity, a count of initial options, and for each, a position and a long pointer to the option's definition. An option definition is a long pointer to a handler, a size in tiles, and its text. Each option added takes a 7-byte RAM entry (handler, position, size), and the list block keeps a pointer to the list below it, so popping one restores the previous top.

The hand cursor holds a row (`aBody6`), moved two rows at a time because options are drawn two rows apart. Up and Down wrap from one end to the other only on a fresh press, so a held direction stops at the end of the list. A doesn't look the option up by index: it passes the hand's position to `rlHandleMenuOptionInput`, which runs the handler of the option whose rectangle contains that point.

```rust
fn list_menu_input(proc) {                            // rlListMenuProcHandleInput
    if list_menu_idle(proc) { return; }               // rlCheckListMenuIdle: screen dark, or another list on top
    if pressed(A) {
        close_menu_and_restore_map_state(proc);       // rlMapMenuCloseAndRestoreMapState
        run_option_at(1, proc.aBody6);                // rlHandleMenuOptionInput: hit-test the rectangles
        pop_option_list(); free_proc(proc);           // rsListMenuProcEnd
    } else if pressed(B) {
        close_menu_and_restore_map_state(proc);
        pop_option_list(); free_proc(proc);
    } else if repeated(UP) || repeated(DOWN) {
        proc.aBody6 = step(proc.aBody6, 2, option_count() * 2);  // wraps only on a new press
    }
}
```

A menu ignores input while its list isn't the top of the stack, so a list opened over another takes the buttons until it closes. The menu's handler runs after the menu has closed: a handler that opens the next menu does so on its own, and the menu it came from no longer exists.

## Building the command menu

The main map menu's template lists its seven options with their positions. The command menu's template is empty, with room for 24, and its setup adds options one at a time:

```rust
fn unit_menu_setup(proc) {                            // rlProcUnitMenuSetUp
    load_menu(); push_option_list(aUnitMenuOptionListTemplate);   // capacity 24, no options
    let unit = active_unit();
    build_slot_lists(unit);                           // rlBuildUnitMenuSlotLists
    find_location_at(unit.tile);                      // wEventLocationEntry, wTargetEventLocationEntry
    let (mut x, mut y) = (1, 1);
    for i in (0..24).rev() {                          // last check first
        if aUnitMenuCommandChecks[i]() {              // carry set: list it
            add_option(aUnitMenuCommandOptions[i], x, y);
            y += 2;
        }
    }
    set_menu_area(9, (option_count() + 1) * 2);       // 9 tiles wide, two rows per option
    draw_options();
    keep_unit_menu_away_from_cursor();                // rlKeepUnitMenuAwayFromCursor
}
```

The two tables run in the reverse of display order, so the loop's last-to-first walk lists talk at the top and return at the bottom. A check is a short routine that returns with carry set or clear; most read the mode, the unit's state, the location under it, and one of the slot lists.

### Slot lists

Before the checks run, `rlBuildUnitMenuSlotLists` sorts the unit's seven inventory slots into five lists at `$7E2000`, each a count byte and up to seven slots:

| List | Holds |
|---|---|
| `aUnitMenuWeaponSlots` | weapons the unit can wield with a target in range (attack) |
| `aUnitMenuStaffSlots` | staves it can use that have a target |
| `aUnitMenuAssaultSlots` | weapons with a minimum range of 1 and an enemy at a castle 2 tiles away |
| `aUnitMenuItemSlots` | items with a target for their staff effect |
| `aUnitMenuEquipSlots` | weapons it can wield |

The equipped weapon goes first in every list it belongs to. Finding targets needs to know who stands near the unit, so the builder first fills a 32 × 32 grid of deployment rows centered on the unit, in the memory that held `aRangeMap` while the unit was picked up ([Chapter 9](09-moving-a-unit.md)). The movement map beside it is left alone, which is why undoing a move can still read it.

The checks and the commands share one target search, `rlFindTargetsInRange`. It walks the rings of a diamond between a minimum and a maximum range around the unit, passes each unit it finds to one of 14 target filters (enemy, same army, talk event, civilian or child, not at full HP, lover under the gold cap, and so on), and returns how many passed. Its `wR12` argument decides whether it also records them: a check passes 0 and only counts, and the command's handler passes 1, which clears `aTargetDistanceMap` and writes each target's deployment row into it.

### Placement

The menu opens at column 4. If the cursor is on the left side of the screen, it moves to column 19 so it doesn't cover the unit. Between 112 and 144 pixels from the left, the menu stays on the side it last used (bit 2 of `wMapStateFlags`), which keeps it from jumping across the screen when the cursor sits near the middle. The battle forecast's windows switch sides at a single point instead: the target's window goes to column 18 while the cursor is in the left half of the screen (under 128 pixels) and to column 2 otherwise, each proc remembering its own side, and the attacker's window sits 8 tiles to the right of it.

## Going back

No stack of menus records the chain. A menu is freed when it hands off, and each later step knows which step to reopen on B:

| B pressed in | Result |
|---|---|
| the command menu, mode 0 | the menu closes and the move is undone ([Chapter 9](09-moving-a-unit.md)) |
| the command menu, mode 1 | the hand returns to the first option; the menu stays |
| the command menu, mode 2 | the guard is undone according to how the move began ([Chapter 9](09-moving-a-unit.md)) |
| the item list | the list, its portrait, and its side window close; the command menu reopens |
| target selection | the forecast closes; the command menu reopens (a staff used from inside a castle puts the unit back in the castle instead) |
| the animation setting | the command menu reopens |
| the main map menu | the menu closes |

Reopening the command menu runs the whole setup again: new slot lists, 24 checks, a new size. Equip, mount, and dismount use the same path after they change the unit, so the reopened menu reflects the new weapon order or the new class. B from target selection returns to the command menu rather than the item list, so changing weapons means choosing attack again.

## Choosing a target

Commands with a target (attack, assault, staff, talk, help, give) record their targets in `aTargetDistanceMap`, a 32 × 32 grid of deployment rows centered on the unit (`$FF` for none), and start target selection. Cursor state 3 then takes over the D-pad: the cursor no longer moves freely but jumps from target to target, Right or Down to the next and Left or Up to the previous.

The order depends on the selected item's range. With a maximum range of 2 or less, or no item, the cursor steps through 12 fixed grid offsets, every tile within 2 of the unit, in an order that goes around clockwise from the tile two above. With a maximum range of 3 or more (a ballista, a long-range tome, or a long-range staff), it scans all 1,024 cells in grid order, row by row.

```rust
fn select_next_target(back: bool) {                   // rsSelectNextTarget
    let (_, max) = selected_item_range();
    if max >= 3 {
        // step wMapTargetSearchIndex through 0..1024, wrapping, to the next non-$FF cell
    } else {
        // step through aNearTargetOffsets[0..12], wrapping, to the next non-$FF cell
    }
    wMapTargetDeploymentOffset = aTargetDistanceMap[found];
}
```

Each new target refreshes the forecast and moves the cursor onto it, scrolling the map if the target is off screen (cursor state 6). A runs the action through `rlRunMapAction`, which dispatches on `wMapActionTargetType`:

| Type | Action | Forecast |
|---|---|---|
| 0 | battle: attack, assault, dance | both windows |
| 1 | staff (also run as a battle) | the target's HP only |
| 2 | help | none |
| 3 | give gold | none |
| 4 | talk | none |

Dance skips target selection: its handler marks every adjacent unit of the dancer's army and runs the action at once with no target. Warp is the one staff whose A doesn't act: it sets a chapter flag, and A on the target opens the minimap to choose where to send the unit.

## The battle forecast

The forecast is two map menus, each owned by its own proc. The target's window shows its name, class, weapon, level, HP, might, defense, and hit chance; the attacker's window, smaller and beside it, shows the attacker's HP, might, defense, and hit. Both read the two action structs that the battle's first stage fills ([Chapter 6](06-resolving-a-battle.md)), which computes every number that doesn't depend on a random roll. A side whose might is `$FF` (marked unable to strike) shows two dashes for it, and a hit chance of exactly 100 uses a special three-digit glyph.

```rust
fn show_battle_forecast() {                           // rlShowBattleForecast
    if matches!(wMapActionTargetType, HELP | GIVE_GOLD | TALK) { return; }
    action_struct_get_battle_stats();                 // stage 1 of the battle
    open_or_refresh(procBattleForecastTarget);        // bit 0 of its bitfield: redraw
    if wMapActionTargetType != STAFF {
        open_or_refresh(procBattleForecastAttacker);
    }
}
```

Moving to another target sets a redraw bit in each proc instead of creating new ones. For a staff, the target's window is shorter and shows HP over max HP, with no attacker's window.

## The item list

Attack, assault, staff, items, and equip all open the same proc, `procMapItemList`, handing it the unit and one of the slot lists. It sizes itself to the list, draws each item's name, uses, and icon, and shows the unit's portrait beside it. Beside the list it shows one of two panels, chosen by which slot list it was given:

- For the three weapon lists, the weapon's might, hit, and avoid in the unit's hands, each with an arrow up or down against the first weapon in the list, which is the equipped one. The weapon rank icon is drawn as a sprite.
- For staves and items, the item's description box.

A on an entry acts by list. Attack and assault make it the selected slot, record the targets for its range, and start target selection. A staff closes the list and starts the staff's own target selection, which picks its filter by staff effect. Equip equips it and reopens the command menu. An item would open the use-or-discard menu, which the retail data never reaches.

## The main map menu

With no unit picked up, Select opens the main map menu, and so does A on an empty tile other than the player's home castle (A there enters the castle screen). It has seven options: ユニット (unit list), アイテム (item list), データ (data), スキル (skills), コンフィグ (options), セーブ (save), and ターンエンド (end turn). Once any unit has finished an action this turn (bit 12 of `wChapterFlags`), the menu opens as a second proc with the same options minus Save, so the map can be saved only before the first action of a turn.

Every option but end turn leaves the map: each installs a full-screen window as the main loop's routine, directly or through a fade ([Chapter 25](OUTLINE.md)), and that window returns through the map's common return path ([Chapter 8](08-the-turn.md)). End turn sets the phase-over bit in `wMapStateFlags` and saves the cursor's tile. A ロード (load) option is defined with a handler that reloads the chapter from its save, but neither template lists it.

## Side windows and popups

Two windows work outside the map menu framework. The **terrain window** shows the terrain under the cursor (or the castle's name in its owner's colors), its avoid bonus, and a recovery mark on castles and churches. The **unit window** shows the unit under the cursor once the cursor comes to rest. Each draws into its own 32 × 32 tilemap buffers, uploaded to fixed video memory addresses, and keeps to the side of the screen away from the cursor. Both hide while anything sets a bit in the low byte of `wMapSystemFlags`: Y held, a unit picked up, the cursor busy, an event running, the minimap open, or a menu up.

**Popups** report a result: a village's gold, a seized castle, an item received. They are opened by the map step from its notes ([Chapter 8](08-the-turn.md)), wait for any music change to finish loading, play a sound, and stay for a set time that a button press shortens.

The **full-inventory menu** opens the same way when a unit receives an item with all seven slots full ([Chapter 3](03-every-sword-is-an-individual.md)). It lists the new item and the seven others, the equipped one marked Ｅ, and asks whether to send the chosen one to the supply. It has no B on the list: the player must choose something, and choosing the new item sends that one.

## Trade-offs and hard limits

Deciding commands by running checks keeps no command state on the unit. Whatever changes a unit's options (a move, a death next door, a new weapon, a castle changing hands, a dismount) shows up the next time the menu opens, because the menu asks again. The cost is that the rules live in 24 routines rather than in data: adding a command means writing a check and a handler, adding entries to both tables in step, and growing the template's capacity.

Reopening instead of keeping a stack of menus means no menu has to stay consistent with changes made under it. The command menu that B returns to is always built from the current state. The cost is the rebuild itself, slot lists and target searches included, every time the player backs out.

Holding the map while a menu is open means nothing on the map changes under the menu. The forecast's two procs are the exception among the windows of a turn: they don't hold the map, because target selection runs in the map step's cursor code.

The limits:

- **24 commands.** The command menu's option list has room for 24, the number of checks.
- **Seven slots per list.** The slot lists cover inventory slots 1 to 7; the eighth holds a new item until one is sent away.
- **12 near targets.** Within range 2, target selection visits only the 12 tiles of the radius-2 diamond.
- **A 32 × 32 target grid** around the unit, enough for range 10.
- **50,000 gold.** Give only finds receivers below it.
- **Fixed tile buffers.** Menus that share a buffer can't be open together.

## Where it lives in the source

- [engine/menus/map_menu.asm](../../engine/menus/map_menu.asm): loading, drawing, moving, and redrawing map menus; frame types; the option list stack and list menu procs; numbers, gauges, text boxes, the item description box, and the opening and gradient effects.
- [engine/menus/unit_menu.asm](../../engine/menus/unit_menu.asm): the command menu, its 24 checks and handlers, the three modes, the animation setting, the item-use menu, and the castle staff menu.
- [engine/menus/unit_menu_slots.asm](../../engine/menus/unit_menu_slots.asm): the slot lists and `rlFindTargetsForItemRange`.
- [engine/menus/item_list.asm](../../engine/menus/item_list.asm): the item list, the weapon stats panel, and the portrait.
- [engine/menus/battle_forecast.asm](../../engine/menus/battle_forecast.asm): the forecast's two windows.
- [engine/menus/main_map_menu.asm](../../engine/menus/main_map_menu.asm): the main map menu and the attack and wait handlers.
- [engine/menus/inventory_full.asm](../../engine/menus/inventory_full.asm): the full-inventory menu.
- [engine/map/map_cursor.asm](../../engine/map/map_cursor.asm): target selection (`rlStartChoosingTarget`, `rlMapChooseTargetStep`, `rsSelectNextTarget`, `aNearTargetOffsets`).
- [engine/map/input.asm](../../engine/map/input.asm): opening the main map menu, and B with a unit picked up.
- [engine/map/map_actions.asm](../../engine/map/map_actions.asm): what the location, talk, help, give, mount, and guard commands do; `rlCheckCanTalk`.
- [engine/battle/battle.asm](../../engine/battle/battle.asm): `rlRunMapAction` and its action table.
- [engine/units/units.asm](../../engine/units/units.asm): `rlFindTargetsInRange` and the 14 target filters.
- [engine/items/staves.asm](../../engine/items/staves.asm) and [engine/items/items.asm](../../engine/items/items.asm): staff targets by effect.
- [engine/map/windows.asm](../../engine/map/windows.asm) and [engine/map/popups.asm](../../engine/map/popups.asm): the terrain and unit windows, the popups, and window colors by army.
- [include/Menus.h](../../include/Menus.h): `structMapMenu`, `structMapMenuTilemapData`, `UNIT_MENU_MODE_*`; [include/Map.h](../../include/Map.h): `MAP_ACTION_*` and the cursor states; [include/WRAM.h](../../include/WRAM.h): the map menu block, the option list variables, the slot lists, `wMapStateFlags`.
- [docs/reference/map_menu.md](../reference/map_menu.md): the reference page.
