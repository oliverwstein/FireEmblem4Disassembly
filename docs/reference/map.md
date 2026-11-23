# The chapter map

The chapter map is the screen where the battle is fought: the map itself, the cursor, the units standing and walking on it, the camera, the minimap, and what happens when a unit is moved and given a command. The menus drawn over it are on their own page ([map_menu.md](map_menu.md)), and so is the AI that decides what the other armies do ([ai.md](ai.md)). Per-routine details: [routines/map.md](routines/map.md).

## Files

| File | Responsible for |
|---|---|
| [map_loop.asm](../../engine/map/map_loop.asm) | the map's VBlank handler, its main loop, starting a chapter |
| [map_display.asm](../../engine/map/map_display.asm) | setting up the map's display (graphics, palettes, windows, camera, the visible map, the sprites); the return flags; clearing the map RAM for a new game |
| [chapter_maps.asm](../../engine/map/chapter_maps.asm) | each chapter's map data (`aChapterMapPointers`) and loading it |
| [map_tilemap.asm](../../engine/map/map_tilemap.asm) | building rows and columns of the map and of the range overlay as the camera moves, and uploading them |
| [scroll.asm](../../engine/map/scroll.asm) | the camera's scroll steps; scroll scripts for events |
| [camera.asm](../../engine/map/camera.asm) | converting between tiles, map pixels and the screen; centring the camera; L between castles |
| [input.asm](../../engine/map/input.asm) | the buttons while the cursor is free; entering the castle from the map |
| [map_cursor.asm](../../engine/map/map_cursor.asm) | the cursor and its states, choosing a target, travelling to a unit, the hand cursor used by menus |
| [unit_movement.asm](../../engine/map/unit_movement.asm) | picking up a unit, its path, walking it, undoing a move; the computer phase's moves; walking sounds |
| [map_actions.asm](../../engine/map/map_actions.asm) | the effects of the unit commands (bank `$84`) |
| [map_sprites.asm](../../engine/map/map_sprites.asm) | drawing and animating the units' map sprites and the animated map tiles; event movers |
| [minimap.asm](../../engine/map/minimap.asm) | the minimap, and choosing a castle for the Warp staff |
| [range_maps.asm](../../engine/map/range_maps.asm) | where the selected unit can move (`aMovementMap`) and what it can reach |
| [deployment.asm](../../engine/map/deployment.asm), [locations.asm](../../engine/map/locations.asm) | the units on the map; the castles, villages and other locations |
| [unit_menu_slots.asm](../../engine/menus/unit_menu_slots.asm) | which inventory slots each unit command can use |

Two pieces of bank `$88` are not about the map and live elsewhere: the end of the first generation ([first_generation_ending.asm](../../engine/events/first_generation_ending.asm), below) and the attract mode's scripted battles ([demo_battles.asm](../../engine/demo/demo_battles.asm)).

Data: [include/Map.h](../../include/Map.h) (`MAP_CURSOR_*`, `MAP_AI_*`, `MAP_RETURN_*`, `MAP_ACTION_*`, `PATH_*`), [include/Terrain.h](../../include/Terrain.h), [include/Deployment.h](../../include/Deployment.h). RAM in [include/WRAM.h](../../include/WRAM.h): the camera and streaming block at `$00071C`-`$000747` (`wMovementMapWindow*`, `wMapScrollSpeed`, `wMapRowUploadFlag`..., `wMapMinXScroll`...), `wMapTileIDMask` and `wMapScrollXPixels`/`YPixels` at `$000596`, the cursor block at `$000750`-`$000770` (`wMapCursorResting`, `wMapWidthMode`, `wMapXOffset`/`YOffset`, `wCursorXOffset`/`YOffset`, `wUnitSelectedFlag`), the unit and target block at `$000772`-`$00078A` (`wActiveUnitDeploymentOffset`, `wMapCursorXTile`..., `wMapReturnFlags`, `wMapSystemFlags`), `aMovementPath` at `$000794`, `wMapCursorState` and the moving sprite at `$0007D4`-`$0007E2`, the map sprite animation block from `$0007E4`.

## Positions

Everything on the map is placed in **tiles** of 16x16 pixels. `aMapData` holds one word per tile (the map is 64 tiles wide, or 128 when `wMapWidthMode` is 8); the low bits (`wMapTileIDMask`) are a tile ID, and each tile ID is four 8x8 tilemap entries in a table at `$7F0000`. `aTerrainTileset` gives each tile ID its terrain.

The **camera** is `wMapScrollXPixels`/`YPixels`, the map pixel at the top left of the screen, kept between `wMapMinXScroll` and `wMapMaxXScroll` (and Y), which come from the chapter's map data. `wMapXOffset`/`YOffset` save it while the map is left. The **cursor** is `wCursorXOffset`/`YOffset`, a position on the screen, so the cursor's tile is (camera + cursor) / 16. It may move within 48 pixels of the screen's edge (X `$30`-`$C7`, Y `$28`-`$A7`); beyond that the map scrolls instead. [camera.asm](../../engine/map/camera.asm) has the conversions.

## A frame

The map's main loop runs the game state routines; the map step (`rlMapStep`, bank `$81`, not filed yet) calls `rlMapCursorStep` and `rlContinueMapScroll` each frame, and `rlMapUpkeep` animates the map sprites (`rlAnimateMapSprites`) and pulses the range overlay's colours. The VBlank handler (`rsMapVBlank`) uploads the animation frames (`rlUploadMapAnimations`), and draws the moving unit's sprite and every other unit's (`rlDrawMovingUnitSprite`, `rlDrawDeployedUnitMapSprites`). New rows and columns of the map reach VRAM through `rlUploadMapRowAndColumn`.

`wMapSystemFlags` collects the map's state for other code: bit 0 Y held, bit 1 a unit is selected (or a return flag or action mode is set), bit 2 the cursor is busy, bit 3 a unit menu or map menu was opened, bit 4 an event is running, bit 5 the minimap is open, bit 7 the map windows are hidden. `rsUpdateMapSystemFlags` recomputes the low bits every frame.

## The cursor

`rlMapCursorStepInner` does nothing while a fade runs. In a computer phase it hands over to `rlMapAIMoveStep`; with the minimap open, to `rlMinimapStep`. Otherwise `wMapCursorState` says what the cursor is doing:

| State | Meaning |
|---|---|
| `MAP_CURSOR_FREE` | the D-pad moves the cursor a tile at a time (Y skips the repeat delay, and while a unit is selected a held direction stops at the edge of its range); the other buttons go to `rsMapInputHandler` |
| `MAP_CURSOR_BACK_TO_UNIT` | a destination was chosen: the cursor goes back to the unit's tile |
| `MAP_CURSOR_UNIT_WALKING` | the unit walks its path |
| `MAP_CURSOR_CHOOSE_TARGET` | the D-pad picks a target, the battle forecast shows, A acts, B goes back |
| `MAP_CURSOR_TO_UNIT` ... `_TO_UNIT_ACTION` | the cursor travels to a unit or tile, then (by state) does nothing, picks up the unit there, goes on choosing a target, or picks up the unit / opens its command menu |
| `MAP_CURSOR_LOCKED` | the cursor is only drawn (the map is about to be left for another screen) |

The travelling states take `wMapCursorXTile`/`YTile` as the distance still to go and move one tile per step, the map scrolling when the cursor reaches the margin (`rlMoveCursorToUnit` starts them). A step is 16 pixels at `wMapScrollSpeed` pixels a frame; `wMapCursorStepping` is set during it.

The free cursor's buttons (`rsMapInputHandler`, [input.asm](../../engine/map/input.asm)): A picks up the unit under the cursor (or, with none, enters the home castle or opens the main map menu) and, with a unit picked up, chooses where it goes; B puts it down; X opens the status screen; Start opens the minimap; R sends the cursor to the next unit of the army that can still act; L jumps from castle to castle (L and R together go back to the home castle).

## Moving a unit

1. **Picking up** (`rsSelectUnitAtCursor`): the unit's sprite becomes the moving sprite, its range maps are built (`rlBuildSelectedUnitRangeMaps`) and the range overlay appears (`rsShowRangeOverlay`). `wUnitSelectedFlag` is set. A player unit that cannot move opens its command menu at once.
2. **The range overlay** is BG3: `aMovementMap` is a 64x64 window of the map around the unit (`wMovementMapWindowLeft`... `Bottom`), and each tile in it shows blue (palette 2) where the unit can move, red (palette 3) where it can only attack ($80), or palette 1 for other values with bit 7 set. It is built row by row and column by column like the map itself (below).
3. **Choosing a destination** (A, `rsSetMoveDestinationAtCursor`): the tile must be in the unit's movement, not attack-only, and free of other units. Then `rsBuildMovementPath` writes the path into `aMovementPath`, starting at the destination and stepping each time to the neighbour with the most movement left until it reaches the unit; the directions are `PATH_*`.
4. **Walking**: the cursor goes back to the unit (state 1), then the unit walks the path from its end (state 2, `rsWalkUnitAlongPath`), turning its sprite (`wMovingUnitSpriteFacing`) and playing its walking sound (`rlStartWalkingSound`: by map sprite, panned by the cursor, with a water flag on sea, river and swamp unless the class flies). A unit with speed 5 or more walks 3 pixels a frame, others 1.
5. **Arriving**: the unit is moved to the tile (`rlMoveDeploymentToTile`) and the unit menu opens ([map_menu.md](map_menu.md)). B in the unit menu puts it back (`rlUndoUnitMove`).

`wMapActionMode` changes what the end of a move does: values `$8002`-`$8004` are set by the depart and guard commands before the move, and `rlStartCursorToUnitAfterMove` turns them into 2-4; 1 is an ordinary move.

### Targets

After a weapon, staff, talk, help or give-gold command, the targets are marked in `aTargetDistanceMap` and `rlStartChoosingTarget` sets state 3. The D-pad picks the next target (`rsSelectNextTarget`): for a weapon of range 3 or more all 1,024 tiles are searched in order, otherwise the 12 tiles of `aNearTargetOffsets` around the unit. A confirms and runs `rlRunMapAction` with `wR0` = the unit and `wR1` = the target, by `wMapActionTargetType`: a battle (`MAP_ACTION_BATTLE`, `_STAFF`), help, give gold or talk.

### The computer phase

`rlMapAIMoveStep` runs the AI's chosen move in the same way: the cursor goes to the acting unit (`MAP_AI_CURSOR_TO_UNIT`), picks it up and walks it to `wActiveActionDestinationX`/`Y` (`MAP_AI_UNIT_WALKING`, at the speed of the enemy speed option), goes to its target if it has one (`MAP_AI_CURSOR_TO_TARGET`), waits a moment (`MAP_AI_WAIT`) and then runs the queued AI action (`rlAIExecuteQueuedAction`).

## Unit commands

The command menu's handlers ([map_menu.md](map_menu.md)) call the effects in [map_actions.asm](../../engine/map/map_actions.asm). Most end the unit's action (`rlUnknown84CAA9`) and then run the chapter's event conditions with an event action number, so a chapter can react:

| Command | Routine | Effect |
|---|---|---|
| town | `rlUnitVisitTown` | event action 8 |
| village | `rlUnitVisitVillage` | closes the village, gives its gold, event action 9 |
| seize | `rlUnitSeizeCastle` | the castle changes owner (`procCastleTakenOver`); the player army frees its captured characters; another army taking a player castle destroys it |
| raid (AI) | `rlUnitRaidVillage` | takes 500 of the village's gold; destroyed when empty (event action 2) |
| guard / return / depart | `rlUnitGuardCastle`, `rlUnitReturnIntoCastle`, `rlUnitDepartCastle` | guarding a castle, going inside, stepping out |
| talk | `rlUnitTalk` | event action `$0A`; the talk target is cleared once used |
| help | `rlUnitHelp` | relocation type 7, 100 experience, event action `$1A` |
| give gold | `rlUnitGiveGold` | all the unit's gold to the target, the rest back |
| mount / dismount | `rlUnitMount`, `rlUnitDismount` | `KnightLord` and `JuniorLord`, with `UnitStateDismounted` |
| Return | `rlUnitReturnToHomeCastle` | to the army's castle, with the warp scene |

## Scrolling and the map's tiles

The camera scrolls in steps of `wMapScrollSpeed` pixels in a direction given as joypad bits (`wMapScrollDirectionIdentifier`: `$0100` right, `$0200` left, `$0400` down, `$0800` up, and their sums for diagonals). Each step (`rlMapScrollStepLeft`...) moves the BG offsets and, when a new 8-pixel row or column comes into view, builds it: `rsBuildMapRowTiles` reads the visible tiles from `aMapData` and writes their 8x8 entries to a buffer (`$05DC` for a row, `$059C` for a column; the `HalfOffset` variants start halfway into a tile). `rlUploadMapRowAndColumn` copies the buffers to the tilemap at VRAM `$5000` in VBlank, and, while a unit is selected, the range overlay's buffers (`$06DC`, `$069C`) to `$5800`. `rlRedrawVisibleMapTilemap` and `rlRedrawRangeOverlayTilemap` rebuild the whole screen when tiles change (a map change event, a castle taken).

## Map sprites

- **Every unit** is drawn each VBlank (`rlDrawDeployedUnitMapSprites`) at its position, coloured by allegiance (`aMapSpritePalettesByAllegiance`); asleep units and player units that have acted are grey. Units off screen are skipped and sprites are culled by scanline.
- **Standing animation**: the frame counter (`wMapSpriteFrameCounter`) runs in steps of 16; on steps 2-7 the short sprites' frames for eight units are queued, on 10-15 the tall ones (`rlQueueStandingMapSpriteFrames`), and `rlUploadMapAnimations` copies them. Steps 0 and 1 of each 8 upload a frame of the two animated tile sets (`g4bppMapTileAnimations1`/`2`). Bit 15 of `wMapSpriteAnimationPauseFlags` pauses the sprites, bit 0 the tiles.
- **The moving unit** (the one picked up) has its walking sprite decompressed to `$7EAB88` (`rlLoadMovingUnitSprite`) and is drawn by `rlDrawMovingUnitSprite`, its frames timed by `aMapSpriteWalkFrameDelays`.
- **Event movers** (`aMovingMapSprites`, up to four at a time) are animated by `rlAnimateMovingMapSprite`.

## The minimap

Start opens it (`procMinimap`, "MG"): the map is drawn as 2x2-pixel dots, `$200` tiles a frame, coloured by terrain (`aMinimapTerrainColors`, closed villages 9) and by army for the units, then uploaded and shown with a flashing box for the visible part. While it is open the D-pad scrolls the map under it, holding R, X, A or Y makes it see-through, and B or Start closes it (`procMinimapClose`, "MC").

The Warp staff uses the minimap to choose a destination: bit 11 of `wUnknown000D79` is set, and the D-pad then steps through the player's castles that are empty or the home castle (`rsMinimapShowWarpCastle`), showing each one's name; A chooses and B cancels.

## Returning to the map

`wMapReturnFlags` tells the map what to do when it is set up again after the castle or a menu (`rsHandleMapReturnFlags`, `rlMapCursorStepInner`): `MAP_RETURN_CENTER_ON_UNIT` sends the cursor to the active unit (after the unit window or status screen); `MAP_RETURN_START_CASTLE_STAFF` starts the target selection of a staff chosen in the castle, with the unit placed north of the castle; `MAP_RETURN_CASTLE_STAFF_ACTIVE` marks that selection as running (B then puts the unit back in the castle); `MAP_RETURN_CASTLE_GRID_STAFF` marks a staff chosen from the castle grid.

## The end of the first generation

At the end of chapter 5, after Arvis attacks Sigurd, `procFirstGenerationEnding` ("MS") fades the map and scrolls a text over it ("かくして、ひとつの時代は終わった"). Its dialogue ASMCs build two lists of first-generation characters: those who fell in battle (their chapter 5 flag, `$14`-`$2C`, is clear) and those who were at Barhara and whose fate is unknown (flag set). The portraits are faded in and out by the world map portrait routines, which take a different path while `wGameStateRoutine1` is 0.

## Depends on

- **Core** ([core.md](core.md)): procs, the HDMA and DMA engines, decompression, the game states.
- **Units**, **items**, **locations**: what the range maps, commands and sprites read.
- **Map menus** ([map_menu.md](map_menu.md)): the unit menu after a move, the battle forecast, the popups.
- **AI** ([ai.md](ai.md)): the computer phase's moves and actions.
- **Events**: event conditions after commands, scroll scripts and event movers.

## Open questions

- `wMapActionMode`: the meaning of each value. 1 is an ordinary move, `$8002`-`$8004` are set by depart and guard, and 4, 5 and 9 change what happens at the end of a walk; the castle sets 3 and `$FFFF`.
- `wUnknown00075A`: bit 1 adds a second layer of map tiles from `$7F6400` into `$065C`, which nothing seems to upload.
- `wUnitSelectedFlag` takes the values 1 and 2 in an unused routine (`rlMoveFreeMapCursorUnused`, a different cursor frame for 2); only 1 is used.
- The help command's relocation (type 7 with `wR0` and `wR1`) and why the helper gets 100 experience.
- What the chapter 5 flags `$14`-`$2C` record (the ending only reads them).
- The attract demo: `rlRunDemoBattleSetup` only reaches the odd entries of `aDemoBattleSetups`; what the even ones (and the map scenes in bank `$90`) are for.
- `rlUnknown88DD0F` and its two sprite arrays: nothing reaches it.
- `rlMapStep` and `rlMapUpkeep` are in bank `$81`, which is not filed yet.
