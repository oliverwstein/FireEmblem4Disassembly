# Chapter 8: The Turn

A turn in *Genealogy of the Holy War* gives every army on the map a **phase**, in faction-slot order: the player's army (slot 0) first, then each other loaded army. Each phase opens with the same sequence: the previous music fades, a banner names the army, the chapter's phase-start events run, the army's units heal or recover from status, and, on the player's turn, love points accrue and the game offers to save. Then the phase itself runs, with the player's cursor or the AI in control, until the player chooses End Turn or the AI runs out of units to move. After the last army, the chapter's end-of-turn events run and the next turn begins.

Two things make this hard to write as straight-line code. First, almost every stage takes many frames: a 32-frame music fade, a two-second banner, one healing window per unit, an event script, a battle scene that leaves the map entirely. Second, a single action spreads into several consequences. A battle can kill a unit, trigger a death quote, give the winner a Canto move, and end with the unit stopping on an event tile, and each of those needs the screen to itself.

The engine handles the first with a thirteen-step **state machine** that runs one step per frame and advances only when its stage is done, and the second with **notes**: one-slot variables that an action fills in and the map step resolves one per frame, before the step runs. This chapter describes the turn's rules first, then the state machine, the way the map is left and re-entered, and the notes.

## How a turn runs

### Which armies take a phase

Every loaded faction slot ([Chapter 4](04-armies-and-allegiance.md)) gets a turn in the cycle, but only some armies **take a phase**, meaning they get a banner and their own music. The player's army always does. Any other army needs three things:

1. a faction name (slots loaded with an unnamed group store `$FF`);
2. at least one living unit on the field;
3. if the chapter's phase-flag table lists the slot, that event flag set.

The phase-flag table gates only the banner and the music. An army without a phase still runs its phase-start events, its turn-start effects, and its AI. Chapter 1's table lists one army, slot 4 (Nordion), gated on `FlagChapter01_NordionSpawned`, and Nordion's own phase-start condition is what sets that flag: once Heirhein has appeared, the condition that fires during Nordion's bannerless phase runs the event that loads Nordion's units and makes Nordion an ally of the player.

### Turn-start effects

At the start of each army's phase, every living unit of that army is checked by its status:

| Status | At the start of its army's phase |
|---|---|
| Healthy, Silence, Sleep, Berserk | heals if below max HP (below) |
| Cured | its duration counts down; when it runs out, HP is restored to full |
| Freelancer | its duration counts down; when it runs out, the unit gains 3,000 gold |
| Captive | nothing |

Healing takes the first source that applies, in this order:

| Source | Condition | Amount | Window |
|---|---|---|---|
| Church | standing on a church tile | to full | yes |
| `Recover` | personal, class, or item skill | to full | yes |
| Castle | waiting inside a castle | 20% of max HP (full for computer armies) | no |
| Guarding | guarding a castle | 20% of max HP | yes |
| `Renewal` | personal, class, or item skill | 5 to 10 | yes |

Player units pay 5 gold per HP at a church, inside a castle, or guarding one. A unit that can't afford the full amount heals as much as its gold covers, and one with less than 5 gold skips that source and falls through to the next. Computer armies heal for free.

Separately, at the start of every turn, every unit in all seven faction slots has its status duration counted down and its armed `Miracle` cleared ([Chapter 6](06-resolving-a-battle.md)). Cured and Freelancer units therefore count down twice per turn: once for everyone at the start of the turn and once at their own army's phase. Only a countdown that reaches zero at the army's phase pays the reward. One that reaches zero at the start of the turn clears the status with no reward.

### The player's phase

On the player's phase, before turn 51, each woman in the army gains love points with each man in it, and more with each man standing next to her ([Chapter 17](OUTLINE.md)). On the frame after the last healing window opens, while the windows may still be up, the cursor moves to the army's first unit on turn 1 or with the Auto-Cursor option on; with Auto-Cursor off, it returns to the tile where the player chose End Turn. From turn 2, with the Auto-Save option on, the save prompt opens once every healing window has closed and the cursor has stopped.

A phase ends when the player chooses End Turn or, for a computer army, when no AI group has anything left to do ([Chapter 14](OUTLINE.md)). Each army's units are un-grayed as soon as its own phase ends.

### Music

A player phase plays the chapter's player-phase song, or the victory theme once every enemy is gone. A computer army plays its own song if it is an enemy of the player, the allied-phase song if allied, and the neutral-phase song if neutral. The chapter's first phase starts the chapter's first-phase song, which in every chapter but the last is its player-phase song. When the last enemy falls mid-phase, the music fades over to the victory theme.

## The map step: thirteen steps

The chapter map is three entries in the game-state table ([introduction](00-introduction.md)): an upkeep routine that animates map sprites and copies the camera to the scroll registers, a setup routine that runs once, and the step routine `rlMapStep`, which runs every frame after that. Inside it, `wGameStateStep` selects one of thirteen routines (`aMapStepRoutines`, constants `MAP_STEP_*` in [include/Map.h](../../include/Map.h)):

```
  new turn          one army's phase
  [0 start turn] ─▶ [1 fade music] ─▶ [2 banner] ─▶ [3 phase events] ─▶ [4 turn-start effects]
        ▲                      ▲                                                   │
        │                      │ next army                                         ▼
        │                [8 next army] ◀── [7 phase] ◀── [6 auto-save] ◀── [5 healing windows]
        │                      │
        │                      │ after the last army
        │                      ▼
        └───────────────────[9 end turn]

  off the cycle:  [10 status screen]   [11 back from another screen]   [12 game over]
```

| Step | Does | Advances when |
|---|---|---|
| 0 | counts the turn (to 999), makes slot 0 active, counts down every unit's status | at once (waits for a running event) |
| 1 | fades out the last phase's music if this army takes a phase and has a song | the 32-frame fade is over |
| 2 | starts the army's music and its banner, if it takes a phase | at once (waits for a running event); the banner pauses the step (below) |
| 3 | runs event action `$21` with the turn and the army | at once |
| 4 | love points, turn-start effects, the AI on (the AI's own check skips the player's army), the music again | at once (waits for a running event) |
| 5 | opens one healing window per frame, then the map windows; moves the cursor | the list is empty |
| 6 | the auto-save prompt | the prompt opens, or it doesn't apply |
| 7 | the phase: AI unit events, the cursor, the camera | End Turn or the AI sets the phase-over bit |
| 8 | un-grays the army; finds the next loaded slot | goes to step 1, or to 9 after the last |
| 9 | turns the AI off; runs event action `$20` with the turn | goes to step 0 |
| 10 | switches the main loop to the status screen | leaves step 7 for the return |
| 11 | rebuilds the windows, fades in, checks Canto | goes back to the saved step |
| 12 | stops the music and fades to the game-over screen | waits for a running event, so the game-over dialogue finishes first; then the map is left |

Step 4 starts the music a second time, after any event from step 3 has finished. It records the army's song as the phase song, which is what plays again after a battle or an event during the phase, and starts it unless that song is already playing. Nordion's spawn event in Chapter 1 makes Nordion an ally and ends by playing the allied-phase song itself. When step 4 runs, Nordion now takes a phase, so step 4 records the allied-phase song and leaves it playing. That phase still has no banner, because step 2 had already passed.

### Waiting without blocking

A step that is waiting returns without advancing, and the map step runs it again next frame. Step 1 counts its fade timer down one frame at a time. Step 5 opens one healing window and returns, so a phase that heals six units takes six frames to open six windows. Step 6 checks each frame whether any healing window is still open and whether the cursor has come to rest. Step 7 runs for the entire phase, returning every frame until the phase-over bit is set.

Steps 0, 2, 4, and 12 also return without advancing while an event is running, so the chapter's scripts finish before the turn moves on. Event action `$21` doubles as the AI's per-unit hook: during a computer phase, step 7 runs it again for each unit about to act, with that unit's AI group and character, so a chapter can script a reaction to a particular unit moving.

### Pausing the map step from a proc

The phase banner needs about two seconds on screen with the turn loop held still, and its proc does the holding itself. The proc ([engine/map/phase_banner.asm](../../engine/map/phase_banner.asm)) saves the current game-state routine in its own RAM and sets `wGameStateRoutine1` to zero, which selects `rlGameStateNone`. Procs run in the interrupt independently of the game state, so the banner slides in, holds for 120 frames, and slides out while `rlMapStep` doesn't run at all. Its last act restores the saved routine, and the map step resumes at step 3. Pressing A, B, X, Y, or Start cuts the hold by 100 frames and speeds up the slide.

The map battle uses the same trick: `procMapBattle` saves and zeroes the game-state routine when it starts and restores it when the fight's animation ends. The AI engine also stops during the pause, since it runs only while the game-state routine is the map step.

## Leaving the map and coming back

The status screen, the castle, and the battle scene all replace the map's main loop and game state. They return through a single routine, `rsReturnToMapMainLoop`, which reloads the map display, rebuilds the menus' RAM, and sets the step to 11 for one frame. Step 11 recreates the unit and terrain windows, fades the screen in, runs the active unit's Canto check, and then jumps to the step stored in `wSavedMapStep`.

The step to return to needs no special bookkeeping: at the end of every frame, `rlMapStep` copies the current step into `wSavedMapStep`. Whatever step was running when the map was left is the step it resumes. Step 10 is the one exception that sets the value on purpose: it hands over to the status screen and writes step 7 as the step to come back to.

Starting a chapter enters the map with the turn counter at 0 and the saved step at 0, so the first frame counts turn 1. Resuming from a map save (from the save menu, or the map menu's reload) sets chapter flag `$0100`, and the map is entered at step 7 with the phase music restarted.

## Notes for the next frame

A command or a battle doesn't carry out its own consequences. It writes a note into a variable reserved for that kind of consequence, and the map step acts on the note at the start of a later frame, before the step routine. This is the Event Queue pattern, with one slot per kind of consequence:

| Note | Left by | Resolved by | Ends the frame |
|---|---|---|---|
| a deployment state buffer and chapter flag `$0004` | staff effects and status changes during a battle | copying every row's buffered state over its state (not at step 11) | no |
| the defeated unit's row | a unit dying in battle | hiding it (unless it stays on the map) and running event action `$17`; a fallen lord starts the game-over event | yes |
| a relocation type and row | Warp, Rescue, escapes, captures, entering or leaving a castle, the seize popup, the chapter-end save prompt, Help, the item popup | one of ten relocation routines | yes |
| bit 15 of `wMapStateFlags` | commands that reopen the unit menu | opening the unit menu | yes, except at step 11 |
| a village's gold amount | visiting a village | the gold popup | yes |
| the row of a unit with a full inventory | receiving an item with no room | the inventory-full menu | yes |
| chapter flag `$2000` | the Canto check after a battle | picking the unit up again for its Canto move | yes |
| the row of the unit whose action ended | every command that finishes a unit's action | event action 3 with its tile ([Chapter 5](05-who-stands-where.md)) | no |

The checks run in that order on every frame:

```rust
fn map_step() {                                       // rlMapStep, game state $12
    // Every handler below does nothing while an event runs (wEventEngineFlags != 0).
    // At step 11, the buffer copy also waits, and the unit menu doesn't end the frame.
    apply_buffered_deployment_states();               // rlApplyBufferedDeploymentStates
    if handle_defeated_unit() {                       // rlHandleDefeatedUnit
        check_victory_theme();                        // rlCheckVictoryTheme
        return;
    }
    if wEventEngineFlags == 0 {
        if run_queued_unit_relocation() { return; }   // rlRunQueuedUnitRelocation
        if open_queued_unit_menu()      { return; }   // rsOpenQueuedUnitMenu
        if show_queued_gold_popup()     { return; }   // rsShowQueuedGoldPopUp
        if open_queued_inventory_full() { return; }   // rsOpenQueuedInventoryFullMenu
        if resume_canto_move()          { return; }   // rsResumeCantoMove
        run_action_ended_events();                    // rsRunActionEndedEvents
    }
    if wGameStateStep >= MAP_STEP_COUNT { loop {} }   // hang on an invalid step
    MAP_STEP_ROUTINES[wGameStateStep]();              // aMapStepRoutines
    wSavedMapStep = wGameStateStep;
    if wEventEngineFlags != 0 {
        map_cursor_step();                            // rlMapCursorStep
        continue_map_scroll();                        // rlContinueMapScroll
    }
}
```

A handler that opens something (a popup, a menu, an event, a Canto pickup) clears its note and ends the frame, so the next note waits for the next frame and the step routine waits with it. If that handler started an event, every later note waits until the event finishes, because each handler checks for a running event first. The buffered-state copy and the action-ended events don't end the frame: the copy only rewrites RAM, and event action 3 runs just before the step on the same frame.

While an event runs, `rlMapStep` also steps the cursor and the camera after the step routine.

### One attack, frame by frame

In Chapter 1, Sigurd attacks a Verdane axe fighter with battle animations off and kills him. Sigurd is a Knight Lord, a class with Canto.

1. **The battle is settled in memory** ([Chapter 6](06-resolving-a-battle.md)) during step 7. The killing blow marks the axe fighter defeated and writes his row into the defeated-unit note. Sigurd qualifies for Canto, so his action stays open. The map battle proc starts and pauses the map step.
2. **The map battle plays.** `rlMapStep` doesn't run.
3. **The map battle ends.** Its proc runs the Canto check, which builds Sigurd's range and sets chapter flags `$2000` and `$8000`, then restores the map step.
4. **Next frame:** the defeat handler hides the axe fighter and runs event action `$17` with his character and army; the victory theme starts if he was the last enemy. The frame ends there, and step 7 doesn't run.
5. **The frame after:** if action `$17` started an event (a death quote, say), everything waits for it. Otherwise the Canto handler picks Sigurd up again with his remaining range shown, and the frame ends.
6. **The player moves Sigurd and chooses Wait.** Finishing his action writes his row into the action-ended note. On the next frame, event action 3 runs with his tile, and step 7 runs on the same frame.

Without Canto, his action would have been finished as soon as the battle was settled, and the action-ended event would run on the frame after the defeat. With animations on, the battle scene leaves the map, and the return path handles the defeat before the map's first frame. Step 11 then runs the Canto check, and the Canto pickup follows on the next frame.

## Trade-offs and hard limits

Running one step per frame keeps every wait cooperative: music, procs, and the AI keep running while the turn waits on them, with no nested loops. The notes keep battle and command code free of popups and menus, and their fixed order resolves deaths before relocations, relocations before menus, and everything before the action-ended event. The cost is one slot per kind of note. A second note of the same kind would overwrite the first, so the code that leaves notes must produce at most one of each before the map step clears it. A battle ends at the first death, which keeps the defeated-unit note to one.

Pausing the map step from a proc keeps the step table short but depends on the proc: if one exited without restoring the game-state routine, the map would stay frozen.

The limits:

- **Turn 999.** The counter stops there.
- **Love points before turn 51.** They accrue only on the player's phase.
- **Seven faction slots.** Step 0 counts down status durations for slots 0 to 6.
- **51 healing windows per phase.** The healing list stops adding entries once its 5-byte entries reach offset `$FF`.
- **A phase flag gates only the banner and music.** The army's phase-start events and AI run every turn regardless.
- **Step 8's empty-slot test never fires.** It skips a slot whose faction name is `$80`, but no group uses `$80` and an empty slot reads `$FFFF`. Every loaded slot passes through steps 1 to 8, and those without a phase pass through without a banner.
- **Cured and Freelancer count down twice a turn.** Only a countdown that ends at the army's own phase pays its reward.

## Where it lives in the source

- [engine/map/map_step.asm](../../engine/map/map_step.asm): the map's setup, upkeep, and step routines, the thirteen steps, the notes and their handlers, the relocation routines, game over, and `rlCheckFactionTakesPhase`.
- [engine/units/turn_start.asm](../../engine/units/turn_start.asm): turn-start effects by status, healing sources and costs, status countdowns, and un-graying an army.
- [engine/map/phase_banner.asm](../../engine/map/phase_banner.asm): `procPhaseBanner` and its pause of the game state.
- [engine/sound/music.asm](../../engine/sound/music.asm): phase songs, the chapter's first-phase song, and the victory theme.
- [engine/events/event_scripts.asm](../../engine/events/event_scripts.asm): `rsReturnToMapMainLoop` and `rsResumeMapAfterMenu`, the return to the map.
- [engine/units/factions.asm](../../engine/units/factions.asm): `rlAddTurnStartLovePoints`.
- [include/Map.h](../../include/Map.h): `MAP_STEP_*` and `UNIT_RELOCATION_*`.
- [include/WRAM.h](../../include/WRAM.h): `wGameStateStep`, `wSavedMapStep`, `wCurrentTurn`, `wActiveFactionSlot`, `wChapterFlags`, `wMapStateFlags`, the note variables, and the turn-start healing list.
- [docs/reference/map.md](../reference/map.md): the reference page.
