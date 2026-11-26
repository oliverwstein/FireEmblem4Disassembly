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
| [map_step.asm](../../engine/map/map_step.asm) | the map's game state routines: the turn loop (each army's phase, the end of a turn) and what earlier actions queued for it (bank `$81`) |
| [map_sprites.asm](../../engine/map/map_sprites.asm) | drawing and animating the units' map sprites and the animated map tiles; event movers |
| [minimap.asm](../../engine/map/minimap.asm) | the minimap, and choosing a castle for the Warp staff |
| [range_maps.asm](../../engine/map/range_maps.asm) | where the selected unit can move (`aMovementMap`) and what it can reach |
| [deployment.asm](../../engine/map/deployment.asm), [locations.asm](../../engine/map/locations.asm) | the units on the map; the castles, villages and other locations |
| [unit_menu_slots.asm](../../engine/menus/unit_menu_slots.asm) | which inventory slots each unit command can use |

Two pieces of bank `$88` are not about the map and live elsewhere: the end of the first generation ([first_generation_ending.asm](../../engine/events/first_generation_ending.asm), below) and the attract mode's scripted battles ([demo_battles.asm](../../engine/demo/demo_battles.asm)).

Data: [include/Map.h](../../include/Map.h) (`MAP_CURSOR_*`, `MAP_AI_*`, `MAP_RETURN_*`, `MAP_ACTION_*`, `PATH_*`), [include/Terrain.h](../../include/Terrain.h), [include/Deployment.h](../../include/Deployment.h). RAM in [include/WRAM.h](../../include/WRAM.h): the camera and streaming block at `$00071C`-`$000747` (`wMovementMapWindow*`, `wMapScrollSpeed`, `wMapRowUploadFlag`..., `wMapMinXScroll`...), `wMapTileIDMask` and `wMapScrollXPixels`/`YPixels` at `$000596`, the cursor block at `$000750`-`$000770` (`wMapCursorResting`, `wMapWidthMode`, `wMapXOffset`/`YOffset`, `wCursorXOffset`/`YOffset`, `wUnitSelectedFlag`), the unit and target block at `$000772`-`$00078A` (`wActiveUnitDeploymentOffset`, `wMapCursorXTile`..., `wMapReturnFlags`, `wMapSystemFlags`), `aMovementPath` at `$000794`, `wMapCursorState` and the moving sprite at `$0007D4`-`$0007E2`, the map sprite animation block from `$0007E4`.

## Positions

Everything on the map is placed in **tiles** of 16x16 pixels. `aMapData` holds one word per tile (the map is 64 tiles wide, or 128 when `wMapWidthMode` is 8); the low bits (`wMapTileIDMask`) are a tile ID, and each tile ID is four 8x8 tilemap entries in a table at `$7F0000`. `aTerrainTileset` gives each tile ID its terrain. Each chapter's layout, tile entries (IDs 0-255; IDs 256-1023 are `aBaseMapTileEntries`, copied to `$7F0800`) and terrain are compressed streams written as CSV source in `gfx/compressed/C70C80/` and built by [tools/chapter_maps.py](../../tools/chapter_maps.py), whose docstring gives the formats.

The **camera** is `wMapScrollXPixels`/`YPixels`, the map pixel at the top left of the screen, kept between `wMapMinXScroll` and `wMapMaxXScroll` (and Y), which come from the chapter's map data. `wMapXOffset`/`YOffset` save it while the map is left. The **cursor** is `wCursorXOffset`/`YOffset`, a position on the screen, so the cursor's tile is (camera + cursor) / 16. It stays 48 pixels from each edge of the screen (its top left at X `$30`-`$C0`, Y `$30`-`$A0`, or 16 pixels when the camera is against the map's edge); a move past that scrolls the map instead (`rsMoveMapCursorLeft`...). Events test a looser box (`rlCheckPointInScreenMargins`: X `$30`-`$C7`, Y `$28`-`$A7`). [camera.asm](../../engine/map/camera.asm) has the conversions.

## A frame

The VBlank handler (`rsMapVBlank`, [map_loop.asm](../../engine/map/map_loop.asm)) runs the game state routines after the hardware updates ([frame.md](frame.md)): `rlMapStep` (below) runs the turn loop and, in the steps where the player can act, calls `rlMapCursorStep` and `rlContinueMapScroll`; `rlMapUpkeep` animates the map sprites (`rlAnimateMapSprites`), pulses the range overlay's colours and copies the camera to the BG1 scroll registers. The same handler uploads the animation frames (`rlUploadMapAnimations`), redraws the dialogue boxes' tilemaps when one moved (`rlRedrawDialogueBoxTilemaps`), and draws the moving unit's sprite and every other unit's (`rlDrawMovingUnitSprite`, `rlDrawDeployedUnitMapSprites`). The main loop (`rsMapMainLoop`) runs the soft reset check, the decompression queue, the AI (`rlRunAIEngineCycle`), deferred sound and the queued map sprite movement. New rows and columns of the map reach VRAM from the row-upload IRQ at line `$D7` (`aMapRowUploadIRQ`, `rlUploadMapRowAndColumn`), installed whenever the map starts or is returned to; it leaves the lines below it dark until VBlank ([scanlines.md](scanlines.md)).

`wMapSystemFlags` collects the map's state for other code: bit 0 Y held, bit 1 a unit is selected (or a return flag or action mode is set), bit 2 the cursor is busy, bit 3 a unit menu or map menu was opened, bit 4 an event is running, bit 5 the minimap is open, bit 7 the map windows are hidden. `rsUpdateMapSystemFlags` recomputes the low bits every frame.

## Turns and phases

`rlMapSetup` (game state `$11`) builds the map menus' RAM, turns the active sprites on, fades in and creates the unit and terrain windows, then hands over to `rlMapStep` (state `$12`) at the step saved in `wSavedMapStep`. Nothing in `rlMapStep` that starts something new runs while an event is running (`wEventEngineFlags` nonzero).

**The turn loop.** `wGameStateStep` picks one of thirteen steps (`aMapStepRoutines`, `MAP_STEP_*` in [include/Map.h](../../include/Map.h)):

| Step | Routine | What it does |
|---|---|---|
| 0 | `rsMapStepStartTurn` | counts the turn (up to 999), makes the player army active, counts down every army's status durations |
| 1 | `rsMapStepFadeOutMusic` | fades out the last phase's music (32 frames, `wPhaseMusicFadeTimer`) if this army takes a phase and has a song |
| 2 | `rsMapStepPhaseBanner` | if the army takes a phase (`rlCheckFactionTakesPhase`), starts its music (`rlStartPhaseMusic`) and shows the phase banner |
| 3 | `rsMapStepPhaseStartEvents` | event action `$21` (turn, army) |
| 4 | `rsMapStepStartPhase` | love points at the start of the player's turns (`rlAddTurnStartLovePoints`, below), the turn start effects of the army's units (healing, status), the AI on |
| 5 | `rsMapStepTurnStartHealing` | one window per unit healed at the turn's start, then the map windows; the cursor goes to the army's first unit on turn 1 or with the auto cursor option on, otherwise to the tile saved at End Turn |
| 6 | `rsMapStepAutoSavePrompt` | from turn 2, with the auto save option, the save prompt |
| 7 | `rsMapStepPhase` | the phase: the cursor and the camera move, the AI runs, until bit 5 of `wMapStateFlags` ends it |
| 8 | `rsMapStepNextFaction` | the next army that exists (step 1), or after the last the end of the turn (step 9) |
| 9 | `rsMapStepEndTurn` | event action `$20` (turn), then step 0 |
| 10 | `rsMapStepOpenStatusScreen` | opens the status screen; step 7 on return |
| 11 | `rsMapStepResume` | back from another screen: windows, fade in, a canto move if the active unit has one, then the saved step |
| 12 | `rsMapStepGameOver` | fades to the game over screen |

An army takes a phase (gets its banner and music) only if it is the player's, or has a name and units on the map and, if the chapter's `FactionPhaseFlagsPointer` table lists it, the event flag given there is set. The check gates only steps 1, 2 and 4's music and banner: every loaded army still runs steps 3-8, with its phase start events, turn start effects and AI. Step 8's skip of a slot whose name ID is `$80` never fires (an empty slot reads `$FFFF`).

The music: a chapter's first phase plays the chapter's own song (`aChapterFirstPhaseSongIDs`), later phases the army's phase song (`rsGetActiveFactionSongID`), and once every enemy is gone the victory theme (`rlCheckVictoryTheme`). `wPhaseSongID` holds it, and `rlResumePhaseMusic` plays it again after an event, a scene or the castle.

**What actions leave for the map step.** Commands and battles do not finish their consequences themselves; they leave a note, and `rlMapStep` acts on it at the start of the next frame, before the step, in this order (each may end the frame):

1. `rlApplyBufferedDeploymentStates`: units changed by a battle or a staff (bit 2 of `wChapterFlags`) get their new deployment states.
2. `rlHandleDefeatedUnit` (`wDefeatedUnitDeploymentOffset`): the unit is hidden and event action `$17` runs; a fallen lord of the player army starts the game over event (`rlStartGameOverEvent`, `aGameOverEventIDs`, which also runs when the player army is removed).
3. `rlRunQueuedUnitRelocation` (`wUnitRelocationType`, `UNIT_RELOCATION_*`): moving a unit to a tile (Warp, Rescue), an escaped or captured unit, a unit going into a castle (with event action 4) or an AI unit leaving one, the seize popup, the save prompt at a chapter's end, the helped unit leaving, the item popup, a rescued unit and its rescuer into a castle.
4. `rsOpenQueuedUnitMenu` (bit 15 of `wMapStateFlags`), `rsShowQueuedGoldPopUp` (a village's gold), `rsOpenQueuedInventoryFullMenu`.
5. `rsResumeCantoMove`: a unit with canto picks up again (`rlCheckActiveUnitCanto` set it up).
6. `rsRunActionEndedEvents` (`wActionEndedDeploymentOffset`): event action 3 with the unit's tile, so a chapter can react to a unit stopping somewhere.

`wChapterFlags` holds the flags of the chapter in progress; every bit is described in [include/WRAM.h](../../include/WRAM.h). `rlAdvanceToNextChapter` ends a chapter (to the chapter save screen), and `rlResetChapterProgress` clears the chapter state for a new game.

## The cursor

`rlMapCursorStepInner` does nothing while a fade runs. In a computer phase it hands over to `rlMapAIMoveStep`; with the minimap open, to `rlMinimapStep`. Otherwise `wMapCursorState` says what the cursor is doing:

| State | Meaning |
|---|---|
| `MAP_CURSOR_FREE` | the D-pad moves the cursor a tile at a time (while a unit is selected a held direction stops at the edge of its range; holding Y skips both that check and the repeat delay); the other buttons go to `rsMapInputHandler` |
| `MAP_CURSOR_BACK_TO_UNIT` | a destination was chosen: the cursor goes back to the unit's tile |
| `MAP_CURSOR_UNIT_WALKING` | the unit walks its path |
| `MAP_CURSOR_CHOOSE_TARGET` | the D-pad picks a target, the battle forecast shows, A acts, B goes back |
| `MAP_CURSOR_TO_UNIT` ... `_TO_UNIT_ACTION` | the cursor travels to a unit or tile, then (by state) does nothing, picks up the unit there, goes on choosing a target, or picks up the unit / opens its command menu |
| `MAP_CURSOR_LOCKED` | the cursor is only drawn (the map is about to be left for another screen) |

The travelling states take `wMapCursorXTile`/`YTile` as the distance still to go and move one tile per step, the map scrolling when the cursor reaches the margin (`rlMoveCursorToUnit` starts them). A step is 16 pixels at `wMapScrollSpeed` pixels a frame; `wMapCursorStepping` is set during it.

The free cursor's buttons (`rsMapInputHandler`, [input.asm](../../engine/map/input.asm)): A picks up the unit under the cursor (or, with none, enters the home castle or opens the main map menu) and, with a unit picked up, chooses where it goes; B puts it down; X opens the status screen; Start opens the minimap; R sends the cursor to the next unit of the army that can still act; L jumps from castle to castle (L and R together go back to the home castle).

## Moving a unit

1. **Picking up** (`rsSelectUnitAtCursor`): the unit's sprite becomes the moving sprite, its range maps are built (`rlBuildSelectedUnitRangeMaps`) and the range overlay appears (`rsShowRangeOverlay`). `wUnitSelectedFlag` is set. A unit of the active army that cannot move, or that can wield a weapon of range 10 (ballistae, Meteor, Bolting, Blizzard, Fenrir: `rlBuildFixedRangeMap`, no movement), opens its command menu at once.
2. **The range maps.** `aRangeMap` marks the units (1 own or allied, passable; `$FF` enemy or neutral, a wall) and the map's edge (`$FE`). `rsFloodFillMovementMap` fills `aMovementMap` from the unit's tile (32, 32) with movement x 10 + 1 (Leg Ring +3; the canto budget during canto), as a bucket queue: one list per amount left, most first. Terrain costs come from the class's movement type ([MovementCost.csv](../../data/terrain/MovementCost.csv)) through `aTileMovementCosts` (7, 10, 20 ... 70; roads and bridges cost 7). For player units, tiles in an area the chapter has closed (bits 10-15 of the map word, not in `wAreaRestrictionBitfield`; events `REMOVE_AREA_RESTRICTION` / `SET_AREA_RESTRICTION`) get bit 7: crossable, not a destination. Then, from every tile the unit can stop on, tiles at range 1 and 2 (by the weapons' range flags) are marked `$80`.
3. **The range overlay** is BG3: `aMovementMap` is a 64x64 window of the map around the unit (`wMovementMapWindowLeft`... `Bottom`), and each tile in it shows blue (palette 2) where the unit can move, red (palette 3) where it can only attack ($80), or palette 1 for other values with bit 7 set (a closed area; or `$FF`, within 10 of another army's unit with a Silence, Sleep, Berserk or Thief staff, `rlMarkMaxRangeDiamond`). It is built row by row and column by column like the map itself (below).
4. **Choosing a destination** (A, `rsSetMoveDestinationAtCursor`): the tile must be in the unit's movement, not attack-only, and free of other units. Then `rsBuildMovementPath` writes the path into `aMovementPath`, starting at the destination and stepping each time to the neighbour with the most movement left until it reaches the unit (ties go to vertical neighbours on even frames, horizontal on odd); the directions are `PATH_*`.
5. **Walking**: the cursor goes back to the unit (state 1), then the unit walks the path from its end (state 2, `rsWalkUnitAlongPath`), turning its sprite (`wMovingUnitSpriteFacing`) and playing its walking sound (`rlStartWalkingSound`: by map sprite, panned by the cursor, with a water flag on sea, river and swamp unless the class flies). A unit with speed 5 or more walks 3 pixels a frame, others 1.
6. **Arriving**: the unit is moved to the tile (`rlMoveDeploymentToTile`) and the unit menu opens ([map_menu.md](map_menu.md)). B in the unit menu puts it back (`rlUndoUnitMove`).

`wMapActionMode` (`MAP_ACTION_MODE_*`) records how a move began, for undoing it; `rlEndUnitAction` clears it. 0 is an ordinary move. The castle screen's sortie sets `$FFFF` and depart `$8002` (the unit is on the castle's gate); next frame `rlStartCursorToUnitAfterMove` makes them 1 and 2 and picks the unit up there. B with the unit picked up sends it back inside (1) or to guarding (2) (`rsMapPressBWithUnitSelected`); the unit menu hides guard in mode 2. The guard command (`rlUnitGuardCastle`) moves the unit onto the guarding spot at once: from the unit menu it sets `$8004` (becomes 4), or 5 / 9 after a sortie or from unit menu mode 1 (`rlStartCursorToActiveUnitForAction`); the castle screen sets 3. Cursor state 8 then ends an empty walk, which requests unit menu mode 2; guarding starts when the action finishes on the spot (`rlFinishUnitAction`). B in the unit menu (`rlUndoUnitMove`) undoes by mode: 0 back to the origin; 5 becomes 1; with unit menu mode 1 open or the unit able to move, back to the origin and picked up again; otherwise 1 and 3 go back inside, 2 guards again, 9 stays put. After the castle screen's guard, the move test reads an `aMovementMap` the castle screen used for its item lists.

### Targets

After a weapon, staff, talk, help or give-gold command, the targets are marked in `aTargetDistanceMap` and `rlStartChoosingTarget` sets state 3. The D-pad picks the next target (`rsSelectNextTarget`): for a weapon of range 3 or more all 1,024 tiles are searched in order, otherwise the 12 tiles of `aNearTargetOffsets` around the unit. A confirms and runs `rlRunMapAction` with `wR0` = the unit and `wR1` = the target, by `wMapActionTargetType`: a battle (`MAP_ACTION_BATTLE`, `_STAFF`), help, give gold or talk.

### The computer phase

`rlMapAIMoveStep` runs the AI's chosen move in the same way: the cursor goes to the acting unit (`MAP_AI_CURSOR_TO_UNIT`), picks it up and walks it to `wActiveActionDestinationX`/`Y` (`MAP_AI_UNIT_WALKING`, at the speed of the enemy speed option; `rsStartAIUnitWalk` checks the destination with `rsSetMoveDestinationAtCursor` and executes `brk` if it fails), goes to its target if it has one (`MAP_AI_CURSOR_TO_TARGET`), waits a moment (`MAP_AI_WAIT`) and then runs the queued AI action (`rlAIExecuteQueuedAction`).

## Unit commands

The command menu's handlers ([map_menu.md](map_menu.md)) call the effects in [map_actions.asm](../../engine/map/map_actions.asm). Most end the unit's action (`rlFinishUnitAction`) and then run the chapter's event conditions with an event action number, so a chapter can react:

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

The camera scrolls in steps of `wMapScrollSpeed` pixels in a direction given as joypad bits (`wMapScrollDirectionIdentifier`: `$0100` right, `$0200` left, `$0400` down, `$0800` up, and their sums for diagonals). Each step (`rlMapScrollStepLeft`...) moves the BG offsets and, when a new 8-pixel row or column comes into view, builds it: `rsBuildMapRowTiles` reads the visible tiles from `aMapData` and writes their 8x8 entries to a buffer (`$05DC` for a row, `$059C` for a column; the `HalfOffset` variants start halfway into a tile). `rlUploadMapRowAndColumn` copies the buffers to the tilemap at VRAM `$5000` from the line `$D7` IRQ, and, while a unit is selected, the range overlay's buffers (`$06DC`, `$069C`) to `$5800`. `rlRedrawVisibleMapTilemap` and `rlRedrawRangeOverlayTilemap` rebuild the whole screen when tiles change (a map change event, a castle taken).

## Map sprites

- **Every unit** is drawn each VBlank (`rlDrawDeployedUnitMapSprites`) at its position, coloured by allegiance (`aMapSpritePalettesByAllegiance`); asleep units and player units that have acted are grey. Units off screen are skipped and sprites are culled by scanline.
- **Standing animation**: the frame counter (`wMapSpriteFrameCounter`) runs in steps of 16; on steps 2-7 the short sprites' frames for eight units are queued, on 10-15 the tall ones (`rlQueueStandingMapSpriteFrames`), and `rlUploadMapAnimations` copies them. Steps 0 and 1 of each 8 upload a frame of the two animated tile sets (`g4bppMapTileAnimations1`/`2`). Bit 15 of `wMapSpriteAnimationPauseFlags` pauses the sprites, bit 0 the tiles.
- **The moving unit** (the one picked up) has its walking sprite decompressed to `$7EAB88` (`rlLoadMovingUnitSprite`) and is drawn by `rlDrawMovingUnitSprite`, its frames timed by `aMapSpriteWalkFrameDelays`.
- **Event movers** (`aMovingMapSprites`, up to four at a time) are animated by `rlAnimateMovingMapSprite` and drawn by `rlDrawMovingMapSprite`; each step (`rsStepMovingMapSprite`) can make the camera follow (`rsCameraFollowMovingMapSprite`, once the mover passes the screen's middle margins), and `rlStopMapSpriteSounds` stops their walking sounds when an event ends.

## The minimap

Start opens it (`procMinimap`, "MG"): the map is drawn as 2x2-pixel dots, `$200` tiles a frame, coloured by terrain (`aMinimapTerrainColors`, closed villages 9) and by army for the units, then uploaded and shown with a flashing box for the visible part. While it is open the D-pad scrolls the map under it, holding R, X, A or Y makes it see-through, and B or Start closes it (`procMinimapClose`, "MC").

The Warp staff uses the minimap to choose a destination: bit 11 of `wChapterFlags` is set, and the D-pad then steps through the player's castles that are empty or the home castle (`rsMinimapShowWarpCastle`), showing each one's name; A chooses and B cancels.

## Returning to the map

`wMapReturnFlags` tells the map what to do when it is set up again after the castle or a menu (`rsHandleMapReturnFlags`, `rlMapCursorStepInner`): `MAP_RETURN_CENTER_ON_UNIT` sends the cursor to the active unit (after the unit window or status screen); `MAP_RETURN_START_CASTLE_STAFF` starts the target selection of a staff chosen in the castle, with the unit placed north of the castle; `MAP_RETURN_CASTLE_STAFF_ACTIVE` marks that selection as running (B then puts the unit back in the castle); `MAP_RETURN_CASTLE_GRID_STAFF` marks a staff chosen from the castle grid.

## The end of the first generation

At the end of chapter 5, after Arvis attacks Sigurd, `procFirstGenerationEnding` ("MS") fades the map and scrolls a text over it ("かくして、ひとつの時代は終わった"). Its dialogue ASMCs build two lists of first-generation characters: those who fell in battle (their chapter 5 flag, `$14`-`$2C`, is clear) and those who were at Barhara and whose fate is unknown (flag set). The portraits are faded in and out by the world map portrait routines, which take a different path while `wGameStateRoutine1` is 0.

## Depends on

- **Core**: procs ([procs.md](procs.md)), the HDMA engine and the row-upload IRQ ([scanlines.md](scanlines.md)), the DMA queue ([frame.md](frame.md)), decompression ([graphics.md](graphics.md)), the game states ([game_states.md](game_states.md)); the map units' sprite quotas ([sprites.md](sprites.md)).
- **Units**, **items**, **locations**: what the range maps, commands and sprites read.
- **Map menus** ([map_menu.md](map_menu.md)): the unit menu after a move, the battle forecast, the popups.
- **AI** ([ai.md](ai.md)): the computer phase's moves and actions.
- **Events**: event conditions after commands, scroll scripts and event movers.

### Love points at the start of a turn

`rlAddTurnStartLovePoints` ([factions.asm](../../engine/units/factions.asm)) runs in step 4 when the player's phase starts, until turn 50. Love points are kept on the woman's side (generation ID 16 and up). Each woman of the player's faction gains her love growth with each man of it (`rsAddLoveGrowthWithEachMan`, the rates in `data/character/Gen*LoveGrowths.csv`). Then each living woman gains 5 more with each player man standing next to her (`rsAddAdjacentLovePoints`). At 500 points the two become lovers (`rlModifyUnitsLovePoints`).

## Open questions

- `wMapDisplayFlags`: bit 1 adds a second layer of map tiles from `$7F6400` into `$065C`, which nothing seems to upload.
- `wUnitSelectedFlag` takes the values 1 and 2 in an unused routine (`rlMoveFreeMapCursorUnused`, a different cursor frame for 2); only 1 is used.
- The help command's relocation (type 7 with `wR0` and `wR1`) and why the helper gets 100 experience.
- What the chapter 5 flags `$14`-`$2C` record (the ending only reads them).
- `rlDrawActiveUnitOverlaySpriteUnused` and its two sprite arrays: nothing reaches it.
- What `$70` means to `rsOpenQueuedInventoryFullMenu`.
- The `CharacterID` of `MOVE_TEMPORARY_TO_COORDS_CLASS` and the help command's relocation (type 7: the target leaves the map with a scene).
- Terrain values `$1A` and up in the chapter terrain tables (up to `$35`; 26 values have names in `include/Terrain.h` and columns in `MovementCost.csv`): what reads them.
