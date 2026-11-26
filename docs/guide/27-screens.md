# Chapter 27: Screens

The game is a set of **screens**: the title screen, the save menu, the chapter map, the castle, the battle scene, the world map, the status screen, and a dozen more. Each one is a different program sharing the same frame. A screen is four things installed together:

| Piece | Where | Runs |
|---|---|---|
| a VBlank routine | `wVBlankPointer` | once a frame, in the interrupt ([Chapter 26](26-the-frame.md)) |
| a main loop routine | `wMainLoopPointer` | in the time the interrupt leaves |
| one or two game state routines | `wGameStateRoutine1`, `wGameStateRoutine2` | once a frame, called by the VBlank routine |
| a step number | `wGameStateStep` | read by the screen's own step routine |

The first two shape the frame: what goes to the hardware, which engines run, what the main loop does with the spare time. The game state routines hold the screen's logic. The step number is the screen's own state machine, inside its game state.

Changing screens means replacing all four. The old screen installs a one-time main loop routine, an **opener**, which blanks the display, loads the new screen, and installs its pieces. This chapter covers the game state table, the steps inside a screen, how a screen pauses itself, openers and the ways screens hand over, the return to the chapter map, and the table of per-frame engines that every screen shares.

## The game state table

`aGameStateRoutines` ([engine/core/frame/game_states.asm](../../engine/core/frame/game_states.asm)) is a table of 56 long pointers. Every frame, the VBlank routine calls `rlRunGameStateRoutines`, which runs the entry numbered `wGameStateRoutine1` and then the one numbered `wGameStateRoutine2`:

```rust
fn run_game_state_routines() {                   // rlRunGameStateRoutines
    dispatch(wGameStateRoutine1);
    dispatch(wGameStateRoutine2);
}

fn dispatch(n: u16) {                            // rsDispatchGameStateRoutine
    let entry = aGameStateRoutines[n];           // a 24-bit address
    if entry.bank == 0x7D {                      // no entry has this bank
        wGameStateRoutine1 = entry.offset;
        return;
    }
    set_data_bank(entry.bank);
    entry();
}
```

The dispatcher sets the CPU's **data bank** register to the routine's own bank before calling it. Instructions with a 16-bit address read and write in the data bank, so a routine can reach the tables beside it in ROM with short instructions. Entry 0, `rlGameStateNone`, returns at once, so either slot can sit idle. The bank `$7D` rule would let an entry redirect slot 1 to another entry; no entry uses it.

Most screens own three consecutive entries, named after the screen:

| Entry | Kind | Runs |
|---|---|---|
| 3k + 1 | **upkeep** (`rl<Screen>Upkeep`), in slot 2 | every frame for as long as the screen is up: sprites, scroll registers, blinking arrows, sometimes input |
| 3k + 2 | **setup** (`rl<Screen>Setup`), in slot 1 | once: turns on the sprite engine, starts a fade-in, creates the screen's procs, picks the first step, and adds 1 to `wGameStateRoutine1` |
| 3k + 3 | **step** (`rl<Screen>Step`), in slot 1 after the setup | every frame from then on: runs the routine for `wGameStateStep` |

The opener writes the setup's number into slot 1 and the upkeep's into slot 2. On the first frame both run; the setup ends by incrementing slot 1 (18 setups do this), so from the second frame on, slot 1 runs the step. The game state numbers have constants in [include/GameStates.h](../../include/GameStates.h): the chapter map's are `GAMESTATE_MAP_UPKEEP` (`$10`), `GAMESTATE_MAP_SETUP` (`$11`), and `GAMESTATE_MAP_STEP` (`$12`).

| Entries | Screen | Chapter |
|---|---|---|
| `$01`-`$03` | the opening logo | [20](20-the-opening.md) |
| `$04`-`$06` | the save menu screen, which also runs the Jugdral history, the chapter intro card, and the step between chapters that starts the world map events | [18](18-saving.md), [19](19-between-chapters.md) |
| `$07`-`$09` | the status screen | [25](25-full-screen-windows-and-the-status-screen.md) |
| `$0A`-`$0C` | the castle | [15](15-castles-and-towns.md) |
| `$0D`-`$0F` | the world map | [19](19-between-chapters.md) |
| `$10`-`$12` | the chapter map | [8](08-the-turn.md) |
| `$13`-`$15` | three routines that return at once; nothing selects them | |
| `$16`, `$17` | setup and step of a screen nothing opens | |
| `$18`, `$19` | the battle scene: setup and step | [24](24-the-battle-scene.md) |
| `$1A`, `$1B` | the title screen: setup and step | [20](20-the-opening.md) |
| `$1C`-`$1F` | pointers into zero padding | |
| `$20`-`$22` | the unit window | [25](25-full-screen-windows-and-the-status-screen.md) |
| `$23`-`$25` | the item window | [25](25-full-screen-windows-and-the-status-screen.md) |
| `$26`-`$28` | the debug menu, which nothing opens | |
| `$29`-`$2B` | the options menu | [25](25-full-screen-windows-and-the-status-screen.md) |
| `$2C`-`$2E` | the skill window | [25](25-full-screen-windows-and-the-status-screen.md) |
| `$2F`-`$31` | the data window | [25](25-full-screen-windows-and-the-status-screen.md) |
| `$32`-`$34` | the revive screen | [25](25-full-screen-windows-and-the-status-screen.md) |
| `$35`-`$37` | the epilogue | [21](21-endings-and-scores.md) |

The battle scene and the title screen have no upkeep, and their openers leave slot 2 at 0. The game over screen has no entries at all. Its opener sets both slots to 0, keeps the chapter map's VBlank and main loop routines, and runs the whole screen as one proc (`procGameOver`).

This is the **State** pattern without objects: the current state is a number, and the "methods" of each state are three routines found by arithmetic on that number. The two slots let a screen's background work (the upkeep) keep running while its foreground logic (slot 1) is swapped or stopped.

## Steps inside a screen

Most step routines are a second dispatcher. `wGameStateStep` indexes a table of routines belonging to the screen: the chapter map has 13 (`aMapStepRoutines`, [Chapter 8](08-the-turn.md)), the status screen 11 (`aStatusScreenSteps`). Each step routine does its work for this frame and sets `wGameStateStep` to move on. Openers clear it to 0; the setup can choose a different first step.

```rust
fn map_step() {                                  // rlMapStep, game state $12
    // a chain of checks for queued consequences, each of which may end the frame
    if handle_defeated_unit() { return; }
    /* ... relocations, queued menus, gold pop-ups, canto, action-ended events ... */
    if wGameStateStep >= MAP_STEP_COUNT { loop {} }
    aMapStepRoutines[wGameStateStep]();
    wSavedMapStep = wGameStateStep;
}
```

The map also copies its step into `wSavedMapStep` every frame. Leaving the map for another screen loses `wGameStateStep`, which the next screen's opener clears; the saved copy is how the map finds its place again on the way back.

## Pausing a screen

A screen's logic can be suspended without leaving the screen by setting slot 1 to 0. The upkeep in slot 2 keeps running, so sprites stay animated and the scroll stays in place, and the per-frame engines keep running, so a proc can take over the frame's work. About a dozen procs do this when they start: each map menu, the map battle, the map action animations and their rewards, and the phase banner. The proc keeps the old slot-1 value in its own body and writes it back when it ends:

```rust
fn map_menu_save_map_state(proc: Slot) {         // rlMapMenuSaveMapState
    proc.body3 = wGameStateRoutine1;
    wGameStateRoutine1 = 0;                      // the map step stops
}

fn map_menu_close(proc: Slot) {                  // rlMapMenuCloseAndRestoreMapState
    close_map_menu();
    if proc.body3 != 0 {
        wGameStateRoutine1 = proc.body3;         // the map step resumes
    }
}
```

Parking slot 1 also stops whatever checks it. The AI's cycle, which runs in the main loop, does nothing unless `wGameStateRoutine1` is `GAMESTATE_MAP_STEP` and the map step isn't 3 or 5, so an open menu, a map battle, or a phase banner holds the enemy's thinking too ([Chapter 14](14-armies-with-a-mind.md)). Other code reads the game state the same way: the event engine's smooth scroll checks for the map step or the world map step, and an event waiting for a battle scene to end waits until slot 1 leaves `$18`-`$1B`. That range also covers the title screen's two entries.

## Changing screens

### Openers

An opener is a main loop routine that runs once. It runs in the main loop for two reasons. It can take as long as it needs, and with the NMI turned off, no VBlank routine runs the old screen's logic against a half-built new one. `rsOpenStatusScreen` is typical:

```rust
fn open_status_screen() {                        // rsOpenStatusScreen
    bBufferINIDISP = FORCED_BLANK;
    wVBlankPointer = rsRunMenuScreenVBlank;
    halt_until_vblank();
    disable_vblank();                            // no NMI while loading
    hardware_reset_screen_pos_math_hdma();       // registers to known values
    hardware_reset_screen_registers();
    set_layer_positions_and_sizes(/* VRAM addresses */);
    clear_unit_window_and_terrain_window_procs();
    active_sprite_engine_reset();
    reset_irq_engine();
    reset_hdma_engine();
    init_status_screen_variables();
    load_status_screen_display();                // graphics go straight to VRAM: the screen is off
    set_status_screen_bg_settings();
    wGameStateRoutine1 = GAMESTATE_STATUS_SCREEN_SETUP;
    wGameStateRoutine2 = GAMESTATE_STATUS_SCREEN_UPKEEP;
    wGameStateStep = 0;
    wMainLoopPointer = rsRunFrameTasks;          // the screen's own main loop routine
    enable_vblank();
}
```

When it returns, the main loop waits for the next VBlank, and the new screen's setup runs in it. The setup usually starts a fade-in proc, so the screen comes up from black.

An opener resets the engines it won't share with the screen before it. The status screen frees the map's unit and terrain window procs but leaves the rest of the procs alone; the chapter map's return resets the active sprites, HDMA, and IRQ engines and rebuilds its menus. Which engines carry over between two screens is decided opener by opener.

### Handing over

A screen leaves by installing the next screen's opener in `wMainLoopPointer`. There are three ways to do it:

- **After a fade.** `procMainLoopChangeFade` (41 places in the code) takes the opener's address as its input. Its init starts a fade-out proc unless the screen is already blank or dark. Its on-cycle routine waits for brightness 0, installs the opener with `rlSetMainLoopPointer`, turns off the scanline timer interrupts, and ends. `procMainLoopChangeFadeByTimer` (9 places) does the same with a fade speed given by the caller. While the fade runs, the old screen is still up and its game states still run.
- **At once.** A store to `wMainLoopPointer` (44 places), for screens that blank the display themselves, such as the battle scene's exit, or for an opener installing its own screen's main loop routine.
- **Through `rlSetMainLoopPointer`** directly (3 places). It has a second path that would park the routine in a scratch register for the event engine, behind an event flag that nothing sets.

The map of who opens whom:

```
 boot --> opening logo --> title screen --> save menu --load-----------------------+
                                                 |                                 |
                                         new game: history                         |
                                                 |                                 v
   save menu (step $23) --> world map events --> world map --> chapter intro --> chapter map
          ^                                                                        |
          +------------------------- end of chapter -------------------------------+

   chapter map <--> castle screen, battle scene, status screen, unit / item / skill /
                    data windows, options, map save
   chapter map ---> game over (ends in a soft reset)
   castle screen <--> status screen, conversations, revive screen, the arena's battle scene
   final chapter --> epilogue --> title screen
```

Every screen reached from the map returns to it the same way, through `rsReturnToMapMainLoop`. The castle screen opens further screens of its own (the status screen, conversations, the Valkyrie Staff's revive screen, the arena's battle scene), which return to it ([Chapter 15](15-castles-and-towns.md), [Chapter 25](25-full-screen-windows-and-the-status-screen.md)).

## Returning to the map

The chapter map has two openers. `rsStartChapterMap` starts a chapter or resumes a saved one: it loads the chapter's layout and events, resets the units for a new chapter (or restores the music and map changes for a resumed one), and selects `GAMESTATE_MAP_SETUP`, whose setup starts the map step at `wSavedMapStep`. A resumed chapter sets that to 7, the phase itself; a new chapter sets 0, the start of the first turn.

`rsReturnToMapMainLoop` comes back from another screen. Both share most of their work: reset the screen registers, the BG2 and BG3 tilemaps, the sprites, and the active sprite, HDMA, and IRQ engines; set up the map display; load the window and font graphics; set the window registers; install the row-upload IRQ ([Chapter 22](22-a-map-bigger-than-the-screen.md)); install `rsMapVBlank`, `rsMapMainLoop`, and `GAMESTATE_MAP_UPKEEP`. The return then selects `GAMESTATE_MAP_STEP` directly, skipping the setup, and sets the step to 11, which handles the return and then restores `wSavedMapStep`.

How much it rebuilds depends on `wMainGameMode`, which the screen being left sets before it hands over:

| Mode | Set by | The map display | Step 11 shows it |
|---|---|---|---|
| 0 | the castle screen and its conversations, the map menu, the options, the skill and data windows | redrawn from `aMapData` | with a fade-in |
| 1 | the status screen, the unit and item windows | redrawn, with all 16 frames of the standing map sprites uploaded at once | at full brightness at once |
| 2 | the battle scene, the save menu, the opening demo, the epilogue | the layout reloaded from ROM and the active map changes written in again | with a fade-in; then a defeated unit is handled and the phase music resumes |
| 3 | a battle scene that asks for it, the event command `RELOAD_MAP_SCREEN` with bit 7 | as 2 | left dark, for the caller to fade in |

Step 11 (`rsMapStepResume`) creates the unit and terrain window procs again, fades in by the mode, gives the active unit its canto move if it has one, and sets `wGameStateStep` back to `wSavedMapStep`. The map carries on from the step it was in when it left. A second variable, `wMapReturnFlags`, carries what the map should do next, such as centering the cursor on the active unit after the status screen, or starting the target selection for a staff chosen in the castle ([Chapter 15](15-castles-and-towns.md)).

## The per-frame engines

After the game state routines, every VBlank routine calls `rlRunVBlankHooks`. It runs each routine in `aTaskTable`, a table of 16 long pointers. Boot fills five slots, and nothing changes them afterwards ([Chapter 26](26-the-frame.md)):

| Order | Engine | Per frame | Chapter |
|---|---|---|---|
| 1 | procs | `rlProcEngineMainProcLoop` | [28](28-procs.md) |
| 2 | active sprites | `rlActiveSpriteEngineMainLoop` | [29](29-sprites-and-scanlines.md) |
| 3 | HDMA | `rlHDMAEngineMainLoop` | [29](29-sprites-and-scanlines.md) |
| 4 | IRQ | `rlIRQEngineStub`, which does nothing; the engine runs from the IRQ | [29](29-sprites-and-scanlines.md) |
| 5 | events | `rlEventEngineMainLoop` | [12](12-screenplays.md) |

`rlRegisterVBlankHook` takes a pointer to an engine's **action table**, three words in one bank: an init routine, which it calls at once; the per-frame routine, which it stores in the highest free slot; and a third routine that only an unused lookup reads. Slots fill from 15 down and run from 15 down, so the engines run in the order they were registered. That order matters inside a frame: a proc that creates an active sprite, an HDMA effect, or an event proc sees it stepped later in the same frame.

The table is not how screens control the engines. Screens call an engine's reset routine directly (`rlResetHDMAEngine`, `rlActiveSpriteEngineReset`, `rlProcEngineResetProcEngine`), and the engine's per-frame routine keeps running with nothing to do. Every screen gets the same five engines in the same order.

## Trade-offs and hard limits

- **56 game state entries, 17 screens.** Two of the screens (the unused one and the debug menu) are never opened, and seven entries point at do-nothing routines or padding.
- **Two slots.** A screen has one foreground routine and one background routine. Anything more runs as procs.
- **One screen at a time.** The table keeps no history. A screen that expects to come back to its caller records where it came from itself (`wStatusScreenCaller`, [Chapter 25](25-full-screen-windows-and-the-status-screen.md)), and the map keeps its own step in `wSavedMapStep`.
- **Openers decide what carries over.** Each opener resets its own list of engines and RAM, so a proc or HDMA effect from the old screen survives into the new one unless that opener clears it.
- **Fixed engines.** The five per-frame engines are registered once at boot, run on every screen, and can't be reordered without changing boot.

## Where it lives in the source

- [engine/core/frame/game_states.asm](../../engine/core/frame/game_states.asm): `aGameStateRoutines`, `rlRunGameStateRoutines`, `aTaskTable` with `rlRegisterVBlankHook` and `rlRunVBlankHooks`, `rlSetMainLoopPointer`.
- [include/GameStates.h](../../include/GameStates.h): the `GAMESTATE_*` constants.
- [engine/core/graphics/fade.asm](../../engine/core/graphics/fade.asm): `procMainLoopChangeFade` and `procMainLoopChangeFadeByTimer`.
- [engine/map/map_loop.asm](../../engine/map/map_loop.asm): `rsStartChapterMap`, `rsReturnToMapMainLoop`, `rsResumeMapAfterMenu`.
- [engine/map/map_step.asm](../../engine/map/map_step.asm): `rlMapSetup`, `rlMapStep`, `rsMapStepResume` (step 11).
- [engine/menus/map_menu.asm](../../engine/menus/map_menu.asm): `rlMapMenuSaveMapState` and `rlMapMenuCloseAndRestoreMapState`.
- [engine/core/frame/unused_game_state.asm](../../engine/core/frame/unused_game_state.asm): the screen nothing opens.
- [include/WRAM.h](../../include/WRAM.h): `wGameStateRoutine1`, `wGameStateRoutine2`, `wGameStateStep`, `aTaskTable`, `wMainGameMode`, `wSavedMapStep`.
- [docs/reference/game_states.md](../reference/game_states.md): the reference page.
