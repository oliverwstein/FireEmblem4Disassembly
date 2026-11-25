# Full-screen menus

Full-screen menus take over the whole display from the map or the castle: the **status screen** (one unit's full record), the **revive screen** (the revive staff's list of dead units), the **options menu**, the map menu's four **overview windows** (unit, item, skill, data) and the **game over** screen. Each has a bank `$80` opener, which resets the screen and installs its game state routines, and its running code in bank `$89` or `$8B`. All of them share the menu VBlank routine (`rsRunMenuScreenVBlank`). The map's own menus are on [map_menu.md](map_menu.md). Per-routine details: [routines/menus.md](routines/menus.md).

## Files

| File | Responsible for |
|---|---|
| [status_screen.asm](../../engine/menus/status_screen.asm) | the opener `rsOpenStatusScreen`, its setup and graphics loading; game state routines `$07`-`$09`; the eleven steps; drawing the stat page, holy blood page, item and skill details; its HDMA effects; the condition names and skill descriptions (the castle reads these too) |
| [revive_screen.asm](../../engine/menus/revive_screen.asm) | the opener `rsReviveScreenOpen`, the list of dead units, game state routines `$32`-`$34`, the grid of map sprites and the yes/no question |
| [options_menu.asm](../../engine/menus/options_menu.asm) | the opener `rsOpenOptionsMenu`, game state routines `$29`-`$2B`, the nine options, their texts and HDMA |
| [window_graphics.asm](../../engine/menus/window_graphics.asm) | `rlLoadWindowGraphics` (window frames and palette, for the map, castle, dialogue and events) and the dialogue box graphics |
| [menu_text.asm](../../engine/menus/menu_text.asm) | menu text drawing, numbers, and `rlDrawBG3TileRun` (a run of two-row tiles), which all these screens use |
| [unit_window.asm](../../engine/menus/unit_window.asm) | the unit window (map menu ユニット): `rsUnitWindowOpen`, game state routines `$20`-`$22`, six pages, sorting, swapping units; banks `$80` and `$8B` |
| [item_window.asm](../../engine/menus/item_window.asm) | the item window (アイテム): `rsItemWindowOpen`, game state routines `$23`-`$25`, the item list and its three sort orders; banks `$80` and `$89` |
| [skill_window.asm](../../engine/menus/skill_window.asm) | the skill window (スキル): `rsSkillWindowOpen`, game state routines `$2C`-`$2E`, 18 skills and their holders; banks `$80` and `$8B` |
| [data_window.asm](../../engine/menus/data_window.asm) | the data window (データ): `rsDataWindowOpen`, game state routines `$2F`-`$31`, the chapter's goal and the armies; banks `$80` and `$8B` |
| [game_over.asm](../../engine/menus/game_over.asm) | the game over screen and `procGameOver` |

Data: constants in [include/Menus.h](../../include/Menus.h) (`STATUS_SCREEN_STEP_*`, `STATUS_SCREEN_REOPEN_*`, `REVIVE_SCREEN_*`, `OPTIONS_MENU_STEP_*`, `OPTION_*`); RAM in [include/WRAM.h](../../include/WRAM.h): the status screen's block at `$7F8183` (`wStatusScreen*`, `aStatusScreen*`) and its buffers at `$7FAF50`; `wUnitWindowCaller` at `$7F82C5`; the options block at `$7F8400` (`wOptionsMenuCursor`, `aOptionsMenuValues`, `aOptionsMenuOpeningValues`); the revive screen's `wReviveScreenDrawMode` (`$7F8403`), `wReviveScreenStaffUser` and `wReviveScreenConfirmCursor` (`$7FB016`). Other screens reuse all of this, so the names are only written in these files (`SCOPED` in [tools/name_ram.py](../../tools/name_ram.py)). The revive screen keeps its list in the unit window's variables (`aUnitWindowDeploymentSlots`, `wUnitWindowCurrentHighlightLine`).

## How a screen is opened and closed

A screen is opened by installing its opener as the main loop routine, either directly (`sta wMainLoopPointer`) or through `procMainLoopChangeFade` with the opener in `aProcSystem.wInput0`. The opener blanks the screen, sets the menu VBlank routine, resets the proc, sprite, HDMA and IRQ engines, builds the screen, sets `wGameStateRoutine1` and `wGameStateRoutine2` to the screen's setup and upkeep routines, and installs `rsRunFrameTasks`. The setup routine runs once and moves on to a step routine, which runs the step in `wGameStateStep` from a table. To leave, a step fades out and installs the next screen's opener.

The status screen is opened from several places, and closing it goes back to whichever opened it. The opener's caller stores its own address (low word) in `wStatusScreenCaller` before it opens the status screen:

| Opened from | `wStatusScreenCaller` | Fade in | B goes back to |
|---|---|---|---|
| the unit window (A on a unit not on the map) | `rsUnitWindowOpen` | speed 5 | the unit window, which keeps its place because `wUnitWindowCaller` is `rsOpenStatusScreen` |
| the revive screen (X) | `rsReviveScreenOpen` | speed 1 | the revive screen, with its cursor (saved in `wItemWindowCursorRow`) |
| the castle courtyard | `rsOpenCastleScreen` | speed 1 | the castle (bit 5 of `wChapterFlags` is set there) |
| the map (X on a unit) | `rsReturnToMapMainLoop` | none: starts at full brightness | the map, or the castle if bit 5 of `wChapterFlags` is set |

## The status screen

### Pages

The stat page is one BG3 page taller than the screen. Its top half (`STATUS_SCREEN_STEP_TOP_PAGE`) shows the summary (name, class, level, experience, HP, and the first usable weapon's attack, hit, range and avoid), the seven stats with their bonuses, and the inventory. Its bottom half (`STATUS_SCREEN_STEP_BOTTOM_PAGE`) shows the commander or leadership stars, the lover (or the army, for a non-player unit), movement, talk partner, gold, arena level, condition, the ten weapon ranks and the skill icons. Down and Up scroll between them, `STATUS_SCREEN_SCROLL_SPEED` lines a frame, by moving BG2 and BG3 together (`wStatusScreenScroll`, 0 to `STATUS_SCREEN_SCROLL_BOTTOM`). An HDMA table (`rlStatusScreenBuildBG3SplitTable`) keeps the header still while the rest scrolls, and another draws the background gradient (`rlStatusScreenSetGradient`).

A shows the **holy blood page** (`STATUS_SCREEN_STEP_HOLY_BLOOD_PAGE`): a ring of twelve crests, one per holy blood. The first time, its graphics are decompressed into `aDecompressionBuffer` and sent to VRAM in five pieces over five frames (`STATUS_SCREEN_STEP_LOAD_HOLY_BLOOD`). Each blood the unit has glints: once for minor blood, twice (on separate timers) for major. Loptous, the thirteenth blood, has its own crest in the middle, its own graphics and gradient, and two glints for major blood.

X moves a cursor onto the inventory (`STATUS_SCREEN_STEP_ITEM_DETAILS`: hit, might, range, weight, uses, kills, the description, and the weapon triangle) or, on the bottom half, onto the skills (`STATUS_SCREEN_STEP_SKILL_DETAILS`: name, description, personal or class skill).

### Facts it draws

`rsInitializeStatusScreenVariables` copies what the screen needs into its block before drawing:

- the holy blood levels (`aStatusScreenHolyBloodLevels`, from `rlCheckForSpecifiedHolyBlood` for each of 13 bloods);
- the commander (`rlGetSelectedUnitCommanderCharacterID`) or, without one, the leadership stars;
- the faction slot: for a non-player unit the screen hides experience, uses, kills and the lover, and R/L do nothing;
- the unit type: an enemy's luck shows as 0;
- whether the unit is at its promotion level (`rlGetPromotedClassIfAvailable`): a marker blinks beside the portrait;
- the slot of the item the unit drops or holds as unique (`rlCheckForValidUniqueItemOrDrops`): a marker beside it;
- its skills with icons (`rlStatusScreenBuildSkillList`);
- its states and condition: a dead, captive, moved or sleeping unit gets the grey sprite palette.

Weapon ranks are drawn by `rsDrawWeaponRankLetter`: A, B, C, a dash for none, and a star for the rank a major blood gives (the rank getter returns carry set for it; Sigurd's sword shows it in the prologue, checked in the emulator). The same star marks arena level 7.

### Another unit

R and L (`rsStatusScreenNextUnit`, `rsStatusScreenPreviousUnit`) walk the player's generation IDs 1-`$18`, skipping units that are dead or captive unless Select is held (checked in the emulator: with Select held, R shows a unit that died in the prologue). They fade out (`STATUS_SCREEN_STEP_FADE_OUT`), set `wStatusScreenReopenMode` to the page to come back to (`STATUS_SCREEN_REOPEN_TOP_PAGE`, `_BOTTOM_PAGE` or `_HOLY_BLOOD`, arbitrary values `$1234`, `$4321`, `$1111`) and install `rsOpenStatusScreen` again with the new unit selected. The setup routine sees the mode and fades in at that page.

### Steps

| Step | Routine | |
|---|---|---|
| `$00` | `rsStatusScreenTopPage` | top half; also while scrolling down |
| `$01` | `rsStatusScreenBottomPage` | bottom half; also while scrolling up |
| `$02` | `rsStatusScreenHolyBloodPage` | |
| `$03` | `rsStatusScreenItemDetails` | |
| `$04` | `rsStatusScreenLeave` | installs `wStatusScreenExitRoutine` |
| `$05` | `rsStatusScreenLoadHolyBloodPage` | |
| `$06` | `rsStatusScreenReturnToMap` | |
| `$07` | `rsStatusScreenReturnToCastle` | |
| `$08` | `rsStatusScreenSkillDetails` | |
| `$09` | `rsStatusScreenFadeIn` | then `wStatusScreenStepAfterFade` |
| `$0A` | `rsStatusScreenFadeOut` | then `wStatusScreenStepAfterFade` |

## The revive screen

A staff effect handler (`rsCastleStaffValkyrie`) installs `rsReviveScreenOpen`. It saves the staff's user (`wReviveScreenStaffUser`) and lists the player's dead units (`rsReviveScreenBuildDeadUnitList`), with their names in a grid of three columns and their map sprites over them. With no dead unit it only says so (`REVIVE_SCREEN_STEP_NOBODY_DEAD`, B leaves).

In `REVIVE_SCREEN_STEP_CHOOSE_UNIT` the arrows move the cursor, and the unit under it animates. X opens that unit's status screen, and closing it comes back here with the same cursor. A asks for confirmation (`REVIVE_SCREEN_STEP_CONFIRM`): on yes, `rlBuildCastleActionRounds` sets up the staff action from the user to the chosen unit. B leaves to the castle courtyard. The upkeep routine draws by `wReviveScreenDrawMode`: the grid, the grid and the yes/no cursor, or nothing.

## The options menu

`rsOpenOptionsMenu` copies the current settings into `aOptionsMenuValues` and keeps a copy in `aOptionsMenuOpeningValues`. The ninth option, the enemy AI, appears only once the save has finished the game (`wOptionsMenuShowEnemyAI`, from `rlGetCurrentSaveCompletionCount`).

| Option | Values |
|---|---|
| `OPTION_ANIMATION` | real, map, each unit |
| `OPTION_TERRAIN_WINDOW`, `OPTION_UNIT_WINDOW`, `OPTION_AUTO_CURSOR` | on, off |
| `OPTION_MESSAGE_SPEED` | 1-5 |
| `OPTION_ENEMY_SPEED` | real, fast |
| `OPTION_SOUND` | stereo, mono, off |
| `OPTION_AUTO_SAVE` | off, file 1-4 (stored as 0, or the file plus 1) |
| `OPTION_ENEMY_AI` | normal, clever |

In `OPTIONS_MENU_STEP_CHOOSE`, Up and Down move between options. The cursor is drawn 10 pixels on for one frame first (`wOptionsMenuCursorMove`). Left/L and Right/R change the value, within `aOptionsMenuValueCounts`, and Y puts back the opening values. The description box at the top (`rlOptionsMenuDrawDescription`) and the line of choices with the chosen one highlighted (`rlOptionsMenuDrawChoices`) follow the cursor. A or B writes the values into the settings (`rlOptionsMenuApplyValues`) and leaves (`OPTIONS_MENU_STEP_LEAVE`) to the map, or to the castle if the menu was opened there.

## The overview windows

The map menu's four overview commands ([map_menu.md](map_menu.md)) open full-screen windows built the same way as the screens above: a bank `$80` opener installed as the main loop routine, three game state routines (render every frame, show once, run a step every frame), `rsRunMenuScreenVBlank`, and RAM that overlaps the status screen's (`$7F8183` on). Each closes to the map (`rsReturnToMapMainLoop`), or to the castle screen when bit 5 of `wChapterFlags` is set.

**Unit window.** Lists the player's units (`rsUnitWindowGetUnits`, `aUnitWindowDeploymentSlots`) on six pages, `wGameStateStep` 0-5, drawn by `aUnitWindowPageDrawers`: 0 class, level, experience and HP; 1 the equipped weapon and its might, hit and avoid; 2 the seven stats; 3 movement, gold, arena level and talk target; 4 the ten weapon ranks (as sprites, `rsUnitWindowRenderWeaponRankIcons`); 5 the skill icons. Left and right turn pages (`aUnitWindowPageTurnInputHandlers`). Each row shows the unit's map sprite and a marker for a unit ready to promote. HDMA tables scroll BG1, BG2 and BG3 and change the colour math by line.

*Sorting.* Up on the first row enters sort selection (`wUnitWindowSortTypeFlag`, `rsUnitWindowHandleSortSelection`), where left and right pick a column; A sorts descending, X ascending (`rsUnitWindowUpdateSort`, the column's type from `aUnitWindowPageSortTypePointers`). `rlUnitWindowGetSortScores` fills `aUnitWindowSortScores` through `aUnitWindowSortScoreGetters` (one per `wUnitWindowSortType`, 0-37: join order, class, level, experience, HP, maximum HP, weapon, might, hit, avoid, the seven stats, gold, movement, the ten weapon ranks, skill count, arena level, talk target; `$26` is the saved order). `rlUnitWindowSetSortDescending`/`Ascending` sort the rows: for each place, every later row that scores higher (lower) is moved up into it and the rows between shift down (`rsUnitWindowSwapSortSlots`, a move despite its name). Equal scores never pass each other, so the sort is stable; the level sort uses that, sorting by experience first and then by level (`rsUnitWindowGetLevelSortScores`).

*Swapping.* Y starts a swap (`rlUnitWindowStartUnitSwap`); A or Y on a second row moves it (`rsUnitWindowSwapUnits`) and renumbers `aUnitJoinOrder` from the new order, so the swap changes the join order every other list uses. The page, sort and order are kept between visits (`rlUnitWindowSaveListOrder`) and cleared by `rlResetUnitWindowSettings` (a new game, units reset for a chapter) and `rlUnitWindowClearSavedListOrder` (a load).

*A on a row.* A unit on the map becomes the active unit and the window closes to the map with the cursor on it (`rlUnitWindowCloseToMap`). Any other unit opens its status screen (`rlUnitWindowOpenSelectedUnitScreen`), which returns to `rsUnitWindowOpen` and the same place.

**Item window.** `rsItemWindowBuildItemList` lists every item held by a living, non-captive unit of faction slot 0 (`aItemWindowList`; storage is not included), with the selected item's stats, weapon rank, description and, for a weapon or attack tome, its weapon triangle (`aItemWindowWeaponTriangleTypes`, `aItemWindowMagicTriangleTypes`). Y or right opens the sort panel (step 1). Its three rows are the three orders starting from the current one (`aItemWindowNextSortModes`); A sorts by the row's order (`rlItemWindowSort`: 0 owner, by character ID; 1 type, by `aItemTypeSortRanks`; 2 name, by `aItemWindowNameSortScores`, apparently kana order). `rlItemWindowSortList` moves each higher-scoring entry up and shifts the rest (`rsItemWindowMoveListEntry`), so it is stable and the previous order decides ties. `wItemWindowSortMode` is kept between visits. A makes the owner the active unit and closes to the map with the cursor on it, or, for a unit off the map, fades to its castle (step 4).

**Skill window.** Lists 18 skills (the IDs at `$8BDFBF`) with each one's icon, name, description and the player's living, non-captive units that have it (`rsSkillWindowGetSkillHolders`, 32 words per skill in `aSkillWindowSkillHolders`). It counts personal and class skills; with Select held as the window opens, skills from items as well. The first 12 holders show; arrows mark more, and the holder list scrolls.

**Data window.** The chapter title, its goal (`aDataWindowChapterGoals`, by chapter), the turn, and a list of the armies (`rsDataWindowGetArmies`, faction slots 0-6 with a name and units or a castle) with each one's banner, leader, relation to the player (`rlGetFactionRelation`, coloured by `aDataWindowRelationPaletteOffsets`) and units alive. X (step 1) shows the selected army's details: name, home castle, and its leader's name, level, HP, attack, 48x64 portrait and animated map sprite. The leaders' portraits are decompressed to VRAM `$4400` on, `$400` words apart, when the window opens.

**Game over.** `rsSetupGameOverScreen` loads the screen's tiles and two tilemaps and creates `procGameOver`, which loads its palettes and plays music `$72`. From frame `$84` it shakes BG2 (`rsGameOverShake`, `aGameOverShakeOffsets`); Start, once faded in, or 1,020 frames, soft-resets.

## Depends on

- **Units** ([units.md](routines/units.md)): every getter the status screen draws; holy blood, weapon ranks, promotion, the skill list (`rlCollectSelectedUnitIconSkills`), love and talk partners, generation IDs.
- **Items** ([items.md](routines/items.md)): item names, descriptions, stats, ranks, durability, equippability.
- **Battle** ([battle.md](routines/battle.md)): battle might, hit and avoid; drop items; the action struct for the revive staff.
- **Unit and item windows**: the revive screen's list variables; the unit window opens the status screen and comes back.
- **Castle** ([castle.md](castle.md)): opens the status and options screens and is returned to; reads the condition names.
- **Core** ([core.md](core.md)): game states, the menu VBlank routine, procs and fades, HDMA, DMA, decompression, sprites.

## Open questions

- `rlStatusScreenBuildBG2SplitTableUnused` and options step `$02` (`rsOptionsMenuReturnToMap`): nothing found reaches them.
- `$7F8426` (set to `$23` as the options menu opens) and the twelve bytes at `$89/8A61` and eight at `$89/F704`: nothing found reads them.
- What `rlGetSelectedUnitCommanderCharacterID` counts as a commander for non-player units (it calls `rlGetFactionGroupLeaderCharacterID`).
- Which rank order `rlCalculateFinalRankingScore` uses; see [save.md](save.md).
- The tilemap entries (`aReviveScreenMenuTilemapEntry`, `aUnknown89ACBC`...) hold long pointers to their RAM buffers as bytes; [include/Menus.h](../../include/Menus.h)'s `structMapMenuTilemapData` may describe them, but its field names do not fit these entries yet.
- 80 `ldy #$xxxx` immediates elsewhere in `engine/` may be raw pointers, as bank `$89`'s sprite arrays were (the item, unit and skill windows pass sprite arrays this way); `tools/sprite_arrays.py` decodes the arrays.
