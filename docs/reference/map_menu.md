# Map menus

Everything drawn in a window over the chapter map is a **map menu**: the main menu (no unit chosen), the unit command menu, the item list, the battle forecast, the popups, the full-inventory menu, the HP windows of a map battle. The terrain window and the unit window work differently ("map windows", below), and the phase banner is drawn on its own. Per-routine details: [routines/menus.md](routines/menus.md), [routines/map.md](routines/map.md), [routines/battle.md](routines/battle.md).

## Files

| File | Responsible for |
|---|---|
| [map_menu.asm](../../engine/menus/map_menu.asm) | the framework: loading a menu, the list of open menus, drawing, moving, hiding, resizing and redrawing, the frame types, the option list menu procs, numbers, gauges, the window gradient and opening animation, text boxes, the item description box |
| [main_map_menu.asm](../../engine/menus/main_map_menu.asm) | the main map menu and its options (unit, item, data, skill, config, save, turn end); the save prompt |
| [unit_menu.asm](../../engine/menus/unit_menu.asm) | the unit command menu: its 24 checks and handlers; the item submenu (use, discard); the castle staff menu; the animation setting |
| [item_list.asm](../../engine/menus/item_list.asm) | the item list the commands open, the weapon stats window, the portrait beside them |
| [battle_forecast.asm](../../engine/menus/battle_forecast.asm) | the battle forecast's two windows |
| [inventory_full.asm](../../engine/menus/inventory_full.asm) | choosing an item to send to the supply when the inventory is full |
| [popups.asm](../../engine/map/popups.asm) | the castle name, gold, seize and item popups; window colours by army |
| [windows.asm](../../engine/map/windows.asm) | the terrain and unit windows |
| [phase_banner.asm](../../engine/map/phase_banner.asm) | "<army> PHASE" |
| [map_battle_hud.asm](../../engine/battle/map_battle_hud.asm) | the map battle HP windows, the experience windows, the map battle text box |
| [staves.asm](../../engine/items/staves.asm) | whether a staff has targets and starting to choose one |
| [range_maps.asm](../../engine/map/range_maps.asm) | where the selected unit can move and what it can reach |

Data: [include/Menus.h](../../include/Menus.h) (`structMapMenu`, `structMapMenuTilemapData`, `structMapMenuPaletteData`, `structMapMenuGraphicsData`, `UNIT_MENU_MODE_*`, `MAP_BATTLE_HP_REQUEST_*`); RAM in [include/WRAM.h](../../include/WRAM.h): the block at `$000516` (`lMapMenuBGBuffer`, `bMapMenuFlags`, `lMapMenuListHead`, `wMapMenuDirtyTop`/`Bottom`, `lMapMenuRAMEntryPointer`, `lMapMenuTilemapRAMEntryPointer`, `wMapMenuNewPosition`, `aCurrentTilemapInfo`, `wMapMenuClearTile`, `wMapMenuTransparentTile`) and the option list variables at `$000540` (`lMenuOptionPointer`, `wMenuOptionX`/`Y`, `lMenuOptionListTop`); `aUnitMenuWeaponSlots`... at `$7E2000` (scoped: the AI uses the area too); `aMapWindowFrameBuffer`/`aMapWindowTextBuffer`; `wMapBattleHPWindowLeftRequest`/`RightRequest`.

## A map menu

A map menu is described in ROM by a `structMapMenu`: pointers to palette data, graphics data and tilemap data, a **type** (its frame style) and a position in tiles. The tilemap data (`structMapMenuTilemapData`) gives the size, the BG buffer to draw into (`aBG3TilemapBuffer`) and a RAM buffer for the menu's own tiles (`$7FC54A`, `$7FCD4A`... each menu picks one). `rlLoadMapMenuData` copies both into RAM areas (so they can be changed) and points `lMapMenuRAMEntryPointer` at the copy; every other routine works on that "current" menu.

The open menus form a list: `lMapMenuListHead` points at the first, and each points at the next (`structMapMenu.Next`). The list is drawn back to front, so the last menu is in front; `rlBringMapMenuToFront` moves one to the end.

A menu is drawn on two layers:

- its **tiles** (text, numbers) are copied to BG3 (`rlDrawMapMenuBG3`, `rlCopyTilemapEntryToBG`), skipping `wMapMenuTransparentTile`;
- its **frame** is drawn on BG2 (page 1 of `aBG2TilemapBuffer`) by the routine for its type (`aMapMenuTypePointers`: types 0-6, plus 7 for dialogue boxes).

Moving, hiding (bit 15 of the position), showing or resizing a menu (`rlMoveMapMenu` with `wMapMenuNewPosition`, `rlHideMapMenu`, `rlShowMapMenu`, `rlResizeMapMenu`) clears the rows the menu covered and redraws every open menu that overlaps them (`rlRedrawMapMenuRows`, `rlRedrawMapMenuFrameRows`). The changed rows are kept in `wMapMenuDirtyTop`/`wMapMenuDirtyBottom` and uploaded to VRAM in VBlank (`rlMapMenuVBlankUpload`) while bit 7 of `bMapMenuFlags` is set. `rlCloseMapMenu` hides a menu and frees it (`rlRemoveMapMenu`).

Drawing into a menu: `rlDrawMapMenuTextLine` (text), `rlDrawMapMenuTileString` (a string of tile numbers), `rlDrawMapMenuSmallNumber` (two digits), `rlDrawMapMenuNumber` (two-row digits, signed), `rlDrawMapMenuGauge` (a bar), all with X = row and column inside the menu. `aCurrentTilemapInfo` is added to every tile (palette and tile base).

### Menu procs

Each menu on screen belongs to a proc. Its definition (`structProcInfo`) is followed by a long pointer to the `structMapMenu`, a byte (nonzero: hold the game state while the menu is up, `rlMapMenuSaveMapState`) and, for list menus, a long pointer to an option list. The init routine calls `rlStallProcUntilMapMenuDataLoaded` (or `rlInitMapMenuProc`), which loads the menu and swaps in an on-cycle routine that waits for its palette and graphics before the proc goes on. Most procs then draw, and on later frames act on their bitfield (bit 1 close, bit 0 or 2 redraw) or on input.

### Option list menus

A list menu (`rlListMenuProcSetUp`, `rlListMenuProcHandleInput`) pushes an option list (`rlPushMenuOptionList`; a stack of blocks allocated in a RAM area, each holding a struct array of options, see [allocation.md](allocation.md)): each option is a long pointer to a handler, a width and height, and its text. Up and Down move the hand (`aBody6`); A closes the menu and runs the option's handler; B closes it. While another list is on top (or the screen is dark) the menu ignores input (`rlCheckListMenuIdle`).

## The main map menu

Opened on the map with no unit chosen, `procMainMapMenu` offers ユニット (the unit window), アイテム (item window), データ (data window), スキル (skill window), コンフィグ (options), セーブ (save), ターンエンド (end the turn). Once a unit has acted this turn (bit 12 of `wChapterFlags`) the menu is `procMainMapMenuNoSave`, without Save. Turn end sets bit 5 of `wMapStateFlags`. A ロード (load) option exists (`aMapMenuOptionLoad`) but is in neither list.

## The unit command menu

After a unit moves, `rlOpenUnitMenu` opens `procUnitMenu` with a mode from `wMapStateFlags` (`UNIT_MENU_MODE_*`). `rlProcUnitMenuSetUp` first builds the lists of usable inventory slots at the unit's tile (`rlBuildUnitMenuSlotLists`: `aUnitMenuWeaponSlots`, `...StaffSlots`, `...AssaultSlots`, `...ItemSlots`, `...EquipSlots`, `...CastleStaffSlots`, each a count and up to seven slots), then runs 24 checks (`aUnitMenuCommandChecks`) from the last to the first and adds the option (`aUnitMenuCommandOptions`) for each that returns carry set. The commands, top to bottom:

| Command | Shown when (check) | Does (handler) |
|---|---|---|
| はなす talk | a talk event in range 1, or between a guarding unit and a unit on its gate (`rlCheckCanTalk`, filter 6) | `rlUnitMenuTalk` |
| たすける help | a civilian or child adjacent | target filter 5 |
| とつげき assault | at an enemy castle that is guarded, or guarding a castle; a weapon in `aUnitMenuAssaultSlots` | item list on those weapons |
| こうげき attack | not mode 2, a weapon in `aUnitMenuWeaponSlots` | item list on those weapons |
| つえ staff | a support staff (effect below `$0C`) usable | item list on `aUnitMenuStaffSlots` |
| おどる dance | the unit has Dance and an adjacent unit has moved | choose a unit |
| はいる enter | at a castle of its own army or an ally | `rlUnitMenuEnter` |
| せいあつ seize | at an enemy castle, not destroyed or guarded, and the unit is a `KnightLord` or `JuniorLord` (Sigurd, Seliph) | `rlUnitMenuSeize` |
| まち town | at a location of type 1 | fades to the castle screen |
| むら village | at a village that is neither destroyed nor closed | `rlUnitMenuVillage` |
| しゅび guard | at an unguarded castle of the unit's army or an ally | `rlUnitMenuGuard` |
| しゅつげき depart | guarding a castle, and the gate (two tiles below) is empty | `rlUnitMenuDepart` |
| はなす talk | no talk event, but a unit in range 1 that is the unit's `TalkTarget` (filter 3) | `rlUnitMenuTalk` |
| たいき wait | unless standing on its own army's castle | ends the action |
| つえ staff | only offensive staves usable | as above |
| もちもの items | an item in `aUnitMenuItemSlots`; never, since no non-staff item has a staff effect | item list on those items |
| あげる give gold | with Steal: gold, and an army member adjacent (filter `$0A`) | choose a target |
| あげる give gold | without Steal: gold, and the lover adjacent (filter `$0B`) | choose a target |
| のる mount | dismounted (`UnitStateDismounted`) | `rlUnitMenuMount` |
| おりる dismount | mounted, with `UnitSkill1Dismount` (only Seliph, set at the generation change) and `ClassSkillDismount` (only `KnightLord`) | `rlUnitMenuDismount` |
| そうび equip | two or more weapons in `aUnitMenuEquipSlots` | item list to equip |
| アニメ animation | always | `procUnitAnimationMenu` |
| 城にもどる return | Return (skill or item), not at its own castle | `rlUnitMenuReturnSkill` |
| 城にもどる return | guarding its home castle | `rlUnitMenuReturnToCastle` |

Most checks also leave a command out while bit 3 of `wMapStateFlags` is set (mode 1). B closes the menu and undoes the move (`rlUndoUnitMove`), except in mode 1.

Mode 1 at the home castle's gate lists enter, guard (if unguarded), equip, animation and Seliph's mount or dismount: wait is hidden at the army's own castle, and the other commands test bit 3. Equip and animation reopen the menu in mode 1, so the unit must enter or guard. Mode 2 (on the guarding spot, which is no location's gate) lists wait (terrain 9), equip, animation, and any range-1 command with a neighbor.

### The item list and what follows

Attack, assault, staff, items and equip open `procMapItemList` on one slot list. It shows each item's name and uses, the unit's portrait, and beside the list either the weapon's stats (`procMapItemWeaponStats`: might, hit, avoid, with arrows against the first usable weapon) or the item's description (`procItemDescriptionBox`). A on an item (`rsMapItemListChoose`):

- a weapon for attack or assault: becomes `wSelectedInventorySlot` and target selection starts; while a target is chosen the battle forecast shows (`rlShowBattleForecast`: `procBattleForecastTarget` with name, class, weapon, level, HP, might, defense and hit; `procBattleForecastAttacker` with the attacker's numbers; a staff shows HP over max HP only);
- an item: opens `procItemUseMenu` (つかう use, すてる discard);
- a staff: `rlUseItemFromMap`, which picks targets by the staff's effect (`rlStartStaffTargetSelection`, [staves.asm](../../engine/items/staves.asm));
- equip: equips it and reopens the unit menu.

## Map windows

The terrain window and the unit window (`procTerrainWindow`, `procUnitWindow`, "Ba" procs) are not map menus. Each draws into a 32x32 tilemap of its own (`aMapWindowFrameBuffer` for the frame, `aMapWindowTextBuffer` for the text, uploaded to VRAM `$5400`/`$5800`), with its position in `aBody0`, size in `aBody1`, a draw routine in `aBody2` and flags in `aBody3`. They stay on the side of the screen away from the cursor; the unit window is redrawn once the cursor rests on a tile. They hide while anything sets the low byte of `wMapSystemFlags` (`rlHideMapWindows` sets bit 7, `rlShowMapWindows` clears it).

## Others

- **Popups**: gold (`procGoldPopUp`), a seized castle (`procSeizePopUp`), an item (`procItemPopUp`), each waiting for the music, then a sound, and staying for a time a button shortens.
- **The phase banner** (`procPhaseBanner`): "<army> PHASE" in the army's colours, slid in and out with a window HDMA; a button speeds it up.
- **A full inventory** (`rlOpenInventoryFullMenu`): the eighth item and the seven others; the one chosen goes to the supply after "このアイテムをあずけますか？".
- **Map battles**: the HP windows (`procMapBattleHPWindowRight`/`Left`) take requests from the map battle code through `wMapBattleHPWindowRightRequest`/`LeftRequest` (`MAP_BATTLE_HP_REQUEST_*`); the experience windows count up with a tick sound (`procMapExperienceWindow` after a map action, `procMapBattleExperienceWindow` in a map battle).

## Depends on

- **Core**: procs ([procs.md](procs.md)), RAM areas and struct arrays ([allocation.md](allocation.md)), HDMA ([scanlines.md](scanlines.md)), the DMA queue ([frame.md](frame.md)), decompression ([graphics.md](graphics.md)).
- **Units** and **items**: everything the checks and windows read; `rlFindTargetsInRange` and its target filters.
- **Map** ([map.md](map.md)): the cursor, locations, the slot lists (`rlBuildUnitMenuSlotLists`, [unit_menu_slots.asm](../../engine/menus/unit_menu_slots.asm)) and the command effects the handlers start ([map_actions.asm](../../engine/map/map_actions.asm)).

## Open questions

- `UnitStateAssault` (was `UnitState0400`; the debug menu labels bit $0400 とつげ(き)): set while assaulting. `rlFindTargetsForSelectedWeapon` uses target filter 4 when it is set, and `rlBuildUnitMenuSlotLists` clears it. Assault targets are found at range 2 only, for weapons with minimum range 1 (`rlFindTargetsForItemRange`).
- The まち (town) command: location type 1, and its handler opens the castle screen.
- The "RP" proc in [map_battle_magic.asm](../../engine/battle/map_battle_magic.asm), `procUnitMenuUnused` (an empty list menu nothing creates), and the gradient table helpers (`rsWriteMapMenuGradientTop`...).
