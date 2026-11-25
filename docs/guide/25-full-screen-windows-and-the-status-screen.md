# Chapter 25: Full-Screen Windows and the Status Screen

Eight screens take over the whole display for a while and then hand it back. The **status screen** shows one unit's full record. Four overview windows from the map menu list the army: the **unit list**, the **item window**, the **skill window**, and the **data window**. The **options menu** changes the settings, the **revive screen** chooses a dead unit for the Valkyrie Staff, and the **game over** screen ends the game. Each can be opened from the map, and most from the castle screen too, and each returns to whatever opened it.

These screens follow the pattern of the castle screen ([Chapter 15](15-castles-and-towns.md)): an opener replaces the frame's routines, a few game state routines run the screen, and leaving installs the next screen's opener. They share one VBlank routine, and they keep their variables in the same block of work RAM, since only one of them is ever open. A screen that opens another and expects to come back records where to return to and saves whatever it needs to restore.

This chapter covers the shared pattern, the status screen, the four overview windows, the options, revive, and game over screens, and how the screens pass control between them.

## The pattern

### Opening

A screen opens by installing its opener as the main loop routine, directly or through a fade proc. The opener runs once:

```rust
fn open_full_screen(setup: GameStateRoutine, upkeep: GameStateRoutine) {
    force_blank();
    wVBlankPointer = rsRunMenuScreenVBlank;
    reset_engines();                         // active sprites, HDMA, IRQs; procs: see below
    load_graphics_and_tilemaps();
    set_layers_windows_and_hdma();
    wGameStateRoutine1 = setup;              // runs once, then hands over to a step routine
    wGameStateRoutine2 = upkeep;             // runs every frame: sprites, cursors
    wGameStateStep = 0;
    wMainLoopPointer = rsRunFrameTasks;      // soft reset, decompression queue, deferred sound
    unblank();
}
```

Every opener resets the active sprites, the HDMA engine and the IRQ engine. Procs differ. The options menu, the revive screen and game over reset the whole proc engine (`rlProcEngineResetProcEngine`). The status screen and the four overview windows only free the map's unit and terrain window procs (`rlClearUnitWindowAndTerrainWindowProcs`); any other proc running on the map keeps running while the screen is up, since the proc engine runs from VBlank whatever the screen ([procs.md](../reference/procs.md)).

`rsRunMenuScreenVBlank` ([engine/menus/status_screen.asm](../../engine/menus/status_screen.asm)) is the usual VBlank list: the queued copies to video RAM, palettes and sprites, HDMA, the buffered PPU registers, the sound queue, the joypad, the game state routines, and the menu tilemap uploads (`rlMapMenuVBlankUpload`). The main loop does only the background tasks, so the AI, which runs from the map's main loop ([Chapter 14](14-armies-with-a-mind.md)), stops while any of these screens is up.

The screens' game state routines and steps:

| Screen | Opener | Game state routines | Steps |
|---|---|---|---|
| Status screen | `rsOpenStatusScreen` | `$07`–`$09` | 11 |
| Unit list | `rsUnitWindowOpen` | `$20`–`$22` | 6 (one per page) |
| Item window | `rsItemWindowOpen` | `$23`–`$25` | 5 |
| Options menu | `rsOpenOptionsMenu` | `$29`–`$2B` | 4 |
| Skill window | `rsSkillWindowOpen` | `$2C`–`$2E` | 2 |
| Data window | `rsDataWindowOpen` | `$2F`–`$31` | 3 |
| Revive screen | `rsReviveScreenOpen` | `$32`–`$34` | |
| Game over | `rsSetupGameOverScreen` | (a proc) | |

### Sharing RAM

The screens' variables overlap in bank `$7F`:

| From | Screen |
|---|---|
| `$7F/8183` | Status screen; data window |
| `$7F/8185` | Skill window |
| `$7F/82C5`–`$7F/8438` | Unit list (its caller word at `$82C5`) |
| `$7F/8400` | Options menu |
| `$7F/8467` | Item window |

The revive screen keeps its list in the unit list's variables (`aUnitWindowDeploymentSlots`). Opening one of these screens overwrites the state of whichever screen opened it. The disassembly writes these names only inside the files that own them (`SCOPED` in [tools/name_ram.py](../../tools/name_ram.py)), because the same address means different things on different screens.

### Coming back

Closing a screen goes back to the map (`rsReturnToMapMainLoop`, which rebuilds the map's display), or to the castle screen when bit 5 of `wChapterFlags` says the castle is open. The status screen can be opened from four places, so it needs more: the caller stores the low word of its own opener in `wStatusScreenCaller` before opening it, and closing the status screen installs that opener again.

| Opened from | `wStatusScreenCaller` | Fade in | B returns to |
|---|---|---|---|
| The map (X on a unit) | `rsReturnToMapMainLoop` | None, at full brightness | The map, or the castle |
| The castle courtyard | `rsOpenCastleScreen` | Speed 1 | The castle screen |
| The unit list (A on a unit off the map) | `rsUnitWindowOpen` | Speed 5 | The unit list |
| The revive screen (X) | `rsReviveScreenOpen` | Speed 1 | The revive screen |

Reopening a screen runs its opener from the start, which would normally reset it. The unit list and the revive screen keep their place in two ways. The unit list saves its page, sort, and row order before leaving (`rlUnitWindowSaveListOrder`), and its opener restores them when `wUnitWindowCaller` names the status screen. The revive screen keeps its cursor in `wItemWindowCursorRow`, an item window variable.

## The status screen

### Pages

The status screen shows one unit across three views:

```
  line  0  +-----------------------------------------+  header: portrait, name, class,
           |                                         |  level, experience
  line 87  +-----------------------------------------+  BG3 scroll below this line
           | top half: HP, first weapon's attack,    |
           |   hit, range, avoid; seven stats with   |  Down/Up scrolls 7 lines a frame
           |   bonuses; inventory                    |  between the halves
           | bottom half: commander or leadership,   |
           |   lover or army, movement, talk partner,|
           |   gold, arena level, condition, ten     |
           |   weapon ranks, skills                  |
           +-----------------------------------------+
```

- **The stat page** is one BG3 tilemap taller than the screen. Down and Up scroll BG2 and BG3 together, `STATUS_SCREEN_SCROLL_SPEED` (7) lines a frame, between 0 and `STATUS_SCREEN_SCROLL_BOTTOM` (`$87`). An HDMA table (`rlStatusScreenBuildBG3SplitTable`) holds BG3's scroll at 0 for the first 87 lines, so the header stays put while the rest moves. A second HDMA table draws the background's gradient.
- **The holy blood page** (A) is a ring of twelve crests, one per holy blood, with Loptous, the thirteenth, in the middle with its own graphics and gradient. Each blood the unit carries glints: once for minor blood, twice on separate timers for major. The first visit decompresses the crest graphics and sends them to video RAM in five pieces over five frames.
- **Details** (X) puts a cursor on the inventory, showing an item's hit, might, range, weight, uses, kills, description, and weapon triangle, or on the bottom half's skills, showing a skill's name, description, and whether it is personal or from the class.

### What it shows, and for whom

Before drawing, `rsInitializeStatusScreenVariables` gathers the unit's facts into the screen's block: the 13 holy blood levels, the commander or leadership stars, the skills with icons, whether the unit is at its promotion level (a marker blinks beside the portrait), the item it drops or holds as unique (a marker beside it), and its condition (a dead, captive, moved, or sleeping unit gets the grey palette). For a unit outside the player's army the screen hides experience, item uses, kills, and the lover, and R and L do nothing. An enemy's luck shows as 0.

Weapon ranks show as A, B, C, or a dash, and a star for the rank a major blood gives. The same star marks arena level 7.

### Another unit

R and L step through the player's generation IDs 1 to 24 ([Chapter 1](01-a-unit-is-made-of-parts.md)), skipping units that are dead or captive unless Select is held:

```rust
fn next_status_unit(direction: i8) {           // rsStatusScreenNextUnit / PreviousUnit
    loop {
        gen_id = wrap_within_1_to_24(gen_id + direction);
        if let Some(unit) = player_unit(gen_id) {
            if !(unit.dead || unit.captive) || select_held() {
                select(unit);
                break;
            }
        }
    }
    wStatusScreenReopenMode = page_tag();      // $1234 top, $4321 bottom, $1111 holy blood
    fade_out_then_install(rsOpenStatusScreen);
}
```

The screen changes unit by reopening itself. The page tag is an arbitrary value that tells the setup routine which page to fade in on.

## The overview windows

The map menu's four overview commands ([Chapter 10](10-menus-over-the-map.md)) each open a full-screen window.

### The unit list

The unit list ([engine/menus/unit_window.asm](../../engine/menus/unit_window.asm)) is a table of the player's units with six pages of columns: class, level, experience, and HP; the equipped weapon with might, hit, and avoid; the seven stats; movement, gold, arena level, and talk target; the ten weapon ranks; and skills. Each row shows the unit's map sprite and a marker for a unit ready to promote.

Up from the first row moves the cursor onto the column headings. Left and right pick a column, A sorts descending, and X ascending. Sort types are numbered 0 to 37, with 32 in use: join order, class, level, experience, HP, maximum HP, weapon, might, hit, avoid, each stat, gold, movement, each weapon rank, number of skills, arena level, and talk target. A sort has two parts. A getter per sort type fills `aUnitWindowSortScores` with one number per row, and one routine orders the rows by those numbers:

```rust
fn sort_descending(rows: &mut [Row], score: &mut [i16]) { // rlUnitWindowSetSortDescending
    for i in 0..rows.len() {
        for j in i + 1..rows.len() {
            if score[j] > score[i] {
                move_entry(rows, score, j, i);   // to place i; rows i..j-1 shift down one
            }
        }
    }
}
```

Moving an entry instead of swapping two means rows with equal scores never pass each other: the sort is stable. The level sort relies on that. It sorts by experience first and then by level, leaving units of the same level in experience order. Getters that want "best first" under a descending sort negate their numbers. For example, the weapon rank getters negate the rank so A comes before B.

Y starts a swap. Moving one unit to another's row renumbers `aUnitJoinOrder` from the new order, so the swap changes the order the rest of the game uses for the player's units. The page, sort, and order are kept between visits, and cleared on a new game, on a chapter's unit reset, and on loading a save.

A on a unit that is on the map closes the window with the map cursor on that unit. A on a unit that isn't on the map, such as one inside a castle, opens its status screen and comes back to the same row.

### The item window

The item window ([engine/menus/item_window.asm](../../engine/menus/item_window.asm)) lists every item carried by a living, non-captive unit of the player's army, 12 rows at a time, with the selected item's stats, rank, description, and weapon triangle. Items in storage aren't listed.

Its sort panel offers three orders: by owner, by type (the game's item order, `aItemTypeSortRanks`), and by name (a table that looks like kana order). The panel's rows start from the current order. The sort moves each higher-scoring entry up and shifts the rest, as the unit list's does, so it is stable, and the previous order breaks ties: sorting by type after sorting by owner gives the items of each type in owner order. The chosen order is kept between visits. A on an item goes to the unit holding it.

### The skill window

The skill window ([engine/menus/skill_window.asm](../../engine/menus/skill_window.asm)) lists 18 skills with each one's icon, name, description, and the player's units that have it, the first 12 shown with an arrow for more. It counts personal and class skills. Holding Select as the window opens also counts skills that come from items, such as the Pursuit Ring.

### The data window

The data window ([engine/menus/data_window.asm](../../engine/menus/data_window.asm)) shows the chapter's title, its goal (`aDataWindowChapterGoals`), the turn, and a row for each army on the map: its banner, its leader, its relation to the player ([Chapter 4](04-armies-and-allegiance.md)), and its units alive. X opens an army's details: its home castle and its leader's name, level, HP, attack, portrait, and animated map sprite. Every leader's portrait is decompressed into video RAM when the window opens, `$400` words apart, so moving between armies changes only which tiles the portrait sprite uses and which palettes are loaded.

## Options, revive, and game over

### The options menu

The options menu ([engine/menus/options_menu.asm](../../engine/menus/options_menu.asm)) copies the current settings into `aOptionsMenuValues` and keeps a second copy of the values it opened with (`aOptionsMenuOpeningValues`):

| Option | Values |
|---|---|
| `OPTION_ANIMATION` | Real, map, each unit ([Chapter 23](23-two-ways-to-show-a-fight.md)) |
| `OPTION_TERRAIN_WINDOW`, `OPTION_UNIT_WINDOW`, `OPTION_AUTO_CURSOR` | On, off |
| `OPTION_MESSAGE_SPEED` | 1–5 |
| `OPTION_ENEMY_SPEED` | Real, fast |
| `OPTION_SOUND` | Stereo, mono, off |
| `OPTION_AUTO_SAVE` | Off, or a file 1–4 (stored as 0, or the file plus 1) |
| `OPTION_ENEMY_AI` | Normal, clever |

The ninth option, the enemy AI, appears only once the save file has finished the game, and the menu uses a second set of row positions and HDMA lines when it does. Up and Down move between options, Left/L and Right/R change the value, Y puts back the opening values, and A or B writes the values into the settings and leaves.

### The revive screen

The castle's Valkyrie Staff handler (`rsCastleStaffValkyrie`) installs the revive screen ([engine/menus/revive_screen.asm](../../engine/menus/revive_screen.asm)). It lists the player's dead units in a grid of three columns, with each one's map sprite over its name; the unit under the cursor animates. X opens that unit's status screen. A asks for confirmation and then builds the staff action from the user to the chosen unit (`rlBuildCastleActionRounds`), which plays as a battle scene. With nobody dead, the screen says so and B leaves.

### Game over

`rsSetupGameOverScreen` ([engine/menus/game_over.asm](../../engine/menus/game_over.asm)) loads the screen's graphics and creates `procGameOver`, which loads its palettes and starts music `$72`. From frame `$84` on, it shakes BG2 through the offsets in `aGameOverShakeOffsets`. Start, once the screen is fully bright, or 1,020 frames of waiting, soft-resets the game.

## Shared pieces

Every screen draws its text with the menu font routines in [engine/menus/menu_text.asm](../../engine/menus/menu_text.asm): `rlDrawMenuTextLine` writes a string as pairs of 8 × 8 tiles, top and bottom, into a tilemap buffer, and `rlDrawMenuTextNumber` writes numbers of up to five digits ([Chapter 13](13-dialogue-and-text.md)). Window frames come from `rlLoadWindowGraphics` ([engine/menus/window_graphics.asm](../../engine/menus/window_graphics.asm)), which takes a style number at `$0756` but loads the same frames and palette for all four styles.

## Trade-offs and hard limits

- **One screen's state at a time.** The shared block means a screen's state doesn't survive another screen opening, unless it is saved somewhere else first. The unit list saves its order and the revive screen parks its cursor in another screen's variable.
- **Returning by address.** `wStatusScreenCaller` holds only the low word of the caller's opener, so every screen that opens the status screen must have its opener in bank `$80`, as all four do.
- **24 player units.** The status screen's R and L step through generation IDs 1 to 24.
- **A fixed skill list.** The skill window shows the 18 skills in its own table (`$8B/DFBF`); a skill not in that table can't appear there.
- **Unused pieces.** `rlStatusScreenBuildBG2SplitTableUnused` and options step `$02` (`rsOptionsMenuReturnToMap`) have no callers.

## Where it lives in the source

- [engine/menus/status_screen.asm](../../engine/menus/status_screen.asm): `rsRunMenuScreenVBlank`, `rsOpenStatusScreen`, the status screen's steps, pages, and HDMA.
- [engine/menus/unit_window.asm](../../engine/menus/unit_window.asm): the unit list, its pages, sorting, and swapping.
- [engine/menus/item_window.asm](../../engine/menus/item_window.asm), [skill_window.asm](../../engine/menus/skill_window.asm), and [data_window.asm](../../engine/menus/data_window.asm): the other overview windows.
- [engine/menus/options_menu.asm](../../engine/menus/options_menu.asm), [revive_screen.asm](../../engine/menus/revive_screen.asm), and [game_over.asm](../../engine/menus/game_over.asm): options, revive, and game over.
- [engine/menus/menu_text.asm](../../engine/menus/menu_text.asm) and [window_graphics.asm](../../engine/menus/window_graphics.asm): text and window frames.
- [include/Menus.h](../../include/Menus.h): step constants and options; [include/WRAM.h](../../include/WRAM.h): the shared block.
- [docs/reference/menus.md](../reference/menus.md): the reference page.
