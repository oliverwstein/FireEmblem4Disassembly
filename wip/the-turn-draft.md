> **Deprecated draft:** Originally drafted as `docs/guide/01-the-turn.md`; archived here when the guide outline moved structured game data to Part I. To be updated and renumbered as Chapter 6 once Part I is written.

# Chapter 1: The Turn

A turn in *Genealogy of the Holy War* is demanding even from the player's chair: the player orchestrates an entire army across a huge grid, reacting to and anticipating several rival armies at once. In the engine, the turn and the map are where almost every system in the game converges. Other screens—a battle scene, a castle shop, the status sheet—have narrow, self-contained jobs. The map turn has to tie all of them together.

A single turn has to fade out the previous army's music, display a phase banner, fire story events, heal units standing on churches or inside castles, award love points, offer an auto-save prompt, and hand control to either the player's cursor or the AI. Worse, a single battle can trigger a chain of consequences—a defeated unit, a seized castle, a village gold popup, a full-inventory prompt, a Canto move, and a tile-arrival event—while jumping away to the battle scene or a castle menu and coming back mid-turn. Running all of that inside one giant loop would tangle every system in the game together, and firing two popups or menus on the same frame would overwrite the screen.

The engine solves this with two mechanisms in [engine/map/map_step.asm](../../engine/map/map_step.asm): a **thirteen-step state machine** for the turn's lifecycle, and a **deferred consequence list** that processes fallout one piece at a time on subsequent frames.

## The thirteen-step state machine

When the chapter map is active, the game-state table installs three routines: `rlMapUpkeep` (`$10`, which animates sprites and copies camera scroll registers every frame), `rlMapSetup` (`$11`, which runs once to initialize menus, active sprites, and windows), and `rlMapStep` (`$12`, which runs the map logic on every frame thereafter).

Inside `rlMapStep`, the variable `wGameStateStep` indexes a 13-entry jump table called `aMapStepRoutines` (`MAP_STEP_*` in [include/Map.h](../../include/Map.h)). Ten of those steps form the main turn loop; the other three handle leaving the map and coming back.

```
  ┌─────────────────────────────────────────────────────────────────────┐
  ▼                                                                     │
[0 StartTurn] ─▶ [1 FadeOutMusic] ─▶ [2 PhaseBanner] ─▶ [3 PhaseStartEvents]
                       ▲                                                │
                       │ (next active faction)                          ▼
                 [8 NextFaction] ◀── [7 Phase] ◀── [6 AutoSave] ◀── [5 Healing] ◀── [4 StartPhase]
                       │
                       │ (after last faction)
                       ▼
                 [9 EndTurn] ──▶ (back to 0 StartTurn)

Off-cycle states:  [10 OpenStatusScreen]   [11 Resume]   [12 GameOver]
```

### Opening a turn and a phase (steps 0–3)

Every new turn begins at **step 0** (`rsMapStepStartTurn`). Once any running event finishes, the routine increments `wCurrentTurn` (clamped at 999), sets `wActiveFactionSlot` to `0` (the player's army), and counts down status-effect durations across faction slots `0` through `6`.

Steps **1 through 3** prepare whichever army is about to act:

1. **Step 1 (`rsMapStepFadeOutMusic`):** If the active faction takes a phase and has a theme song, the step fades out the previous phase's music over 32 frames (`wPhaseMusicFadeTimer`).
2. **Step 2 (`rsMapStepPhaseBanner`):** `rlCheckFactionTakesPhase` verifies that the faction has a name, has units on the map, and—if the chapter's `FactionPhaseFlagsPointer` table gates it—has its required event flag set. That flag gate lets a chapter keep an army dormant until the story wakes it up. If the faction qualifies, `rlStartPhaseMusic` begins the chapter's opening song, the faction's phase song, or the victory theme (`rlCheckVictoryTheme` when no enemies remain), and the step spawns `procPhaseBanner` ([engine/map/phase_banner.asm](../../engine/map/phase_banner.asm)).

   `procPhaseBanner` uses a neat shortcut to freeze the turn loop while the banner slides across the screen: `rlProcPhaseBannerInit` saves `wGameStateRoutine1` in its proc slot (`aProcSystem.aBody5`) and sets `wGameStateRoutine1` to `0` for 120 frames. Because procs run in `rlRunVBlankHooks` independently of the game-state routine, the banner animates smoothly while `rlMapStep` sits paused, without needing an extra "waiting for banner" step in `aMapStepRoutines`. When the banner finishes, it restores `wGameStateRoutine1`.
3. **Step 3 (`rsMapStepPhaseStartEvents`):** Fires event action `$21` so chapter scripts can react to the start of a specific turn and army.

### Turn-start effects, healing, and auto-save (steps 4–6)

At **step 4** (`rsMapStepStartPhase`), if the active army is the player's and the turn count has not passed 50, `rlAddTurnStartLovePoints` updates the 9 × 15 love grid. Next, `rlGetTurnStartEffectsByStatus` ([engine/units/turn_start.asm](../../engine/units/turn_start.asm)) evaluates every unit in the active faction.

For healthy, silenced, asleep, or berserked units below max HP, `rlGetTurnStartNormalEffect` checks five healing sources in strict priority order and stops at the first match:

```
Church ─▶ Recover skill ─▶ Inside castle ─▶ Guarding castle ─▶ Renewal skill
```

Whichever source matches heals the unit and appends an entry to a small buffer at `$7E2004`. For non-player armies, step 4 also enables the AI engine.

**Step 5** (`rsMapStepTurnStartHealing`) drains that healing buffer one unit at a time, spawning `procMapExperienceWindow` to display each HP recovery on the map. Once the buffer is empty, it restores the map's terrain and unit windows (`rlShowMapWindows`) and calls `rsMoveCursorToPhaseStart`. On turn 1 (or with Auto-Cursor turned off), the cursor jumps to faction 0's first unit; on later player turns with Auto-Cursor on, it returns to the player's saved cursor tile.

**Step 6** (`rsMapStepAutoSavePrompt`) runs only on player turns from turn 2 onward when Auto-Save is enabled. It waits until the last healing window closes and the cursor settles, then spawns `procSavePrompt`.

### Running the phase and advancing the cycle (steps 7–9)

**Step 7** (`rsMapStepPhase`) is where the game spends nearly all of its time. On each frame, it dispatches any queued AI unit event (`rsRunQueuedAIUnitEvent`) and—unless bit 5 of `wMapStateFlags` or bit 9 of `wChapterFlags` blocks input—steps the cursor (`rlMapCursorStep`) and camera (`rlContinueMapScroll`). The phase ends when the player selects End Turn or the AI finishes its army, which sets bit 5 of `wMapStateFlags`. Step 7 clears that bit and advances to step 8.

**Step 8** (`rsMapStepNextFaction`) clears the current faction's moved flags (`rlUnsetFactionUnitsMoved`), then scans forward through `wLoadedFactionCount` for the next faction slot whose name ID is not `$80`. If it finds one, it jumps back to **step 1** (`MAP_STEP_FADE_OUT_MUSIC`) for that army's phase. Once all factions have acted, it resets `wActiveFactionSlot` to `0` and advances to **step 9** (`rsMapStepEndTurn`), which fires event action `$20` and loops back to **step 0** for the next turn.

### Leaving the map and coming back (steps 10–12)

A player turn constantly leaves the map—for the status screen, a castle courtyard, or a full battle scene—and must return to the exact phase step it left. At the end of every frame in `rlMapStep`, the engine mirrors `wGameStateStep` into `wSavedMapStep`. When another screen finishes and runs `rlMapSetup`, `rlMapSetup` reads `wSavedMapStep` back into `wGameStateStep`.

Steps **10 through 12** handle those transitions:

- **Step 10 (`rsMapStepOpenStatusScreen`):** Opens the status screen and sets `wGameStateStep` back to `7` for the return.
- **Step 11 (`rsMapStepResume`):** Restores map windows, fades the screen back in, resumes a Canto move if the active unit earned one, and jumps to the saved step.
- **Step 12 (`rsMapStepGameOver`):** Fades out to the game-over screen.

## Deferred consequences: notes left for the next frame

A battle or unit command rarely finishes its work in one place. A duel might play out in the battle scene (a different game state entirely) and kill a unit, trigger a seize or village popup, fill an inventory, grant Canto movement, and land on an event trigger tile. Instead of trying to orchestrate all of that inside combat or menu code, those systems leave **notes** in dedicated RAM variables (`wDefeatedUnitDeploymentOffset`, `wUnitRelocationType`, `wMapStateFlags`, `wVillageGoldPopUpAmount`, `wActionEndedDeploymentOffset`).

At the top of every frame, before `aMapStepRoutines` runs, `rlMapStep` checks those notes in strict priority order. If any handler has work to do that needs the screen (a popup, a menu, an event), it claims the frame and returns immediately, leaving any remaining notes for the next frame:

```rust
fn rl_map_step() {                                      // rlMapStep ($81/A89D)
    apply_buffered_deployment_states();                 // rlApplyBufferedDeploymentStates
    if handle_defeated_unit() {                         // rlHandleDefeatedUnit
        check_victory_theme();                          // rlCheckVictoryTheme
        return;
    }

    if w_event_engine_flags == 0 {
        if run_queued_unit_relocation() { return; }     // rlRunQueuedUnitRelocation
        if open_queued_unit_menu()      { return; }     // rsOpenQueuedUnitMenu
        if show_queued_gold_popup()     { return; }     // rsShowQueuedGoldPopUp
        if open_queued_inventory_full() { return; }     // rsOpenQueuedInventoryFullMenu
        if resume_canto_move()          { return; }     // rsResumeCantoMove
        run_action_ended_events();                      // rsRunActionEndedEvents (action 3)
    }

    if w_game_state_step >= MAP_STEP_COUNT {
        loop {}                                         // bounds trap
    }
    A_MAP_STEP_ROUTINES[w_game_state_step]();
    w_saved_map_step = w_game_state_step;

    if w_event_engine_flags != 0 {
        map_cursor_step();                              // rlMapCursorStep
        continue_map_scroll();                          // rlContinueMapScroll
    }
}
```

Notice the split around `wEventEngineFlags`. Buffered deployment updates and unit defeats (`rlHandleDefeatedUnit`) run even while an event is active—if a fallen unit is a player lord, `rlHandleDefeatedUnit` launches the game-over event (`rlStartGameOverEvent`). Everything else waits until `wEventEngineFlags` is zero so menus, popups, and Canto moves never collide with a cutscene.

## Trade-offs and hard limits

- **Single-slot notes instead of a dynamic queue.** Keeping one variable per consequence type (`wDefeatedUnitDeploymentOffset`, `wUnitRelocationType`) avoids heap allocation and guarantees deterministic priority: defeats always resolve before relocations, which always resolve before menus and Canto. The cost is that only one pending defeat or relocation can exist at a time, so actions must settle one unit before starting the next.
- **Pausing `wGameStateRoutine1` from a proc.** Zeroing `wGameStateRoutine1` inside `procPhaseBanner` keeps `aMapStepRoutines` short, but it relies on discipline: any proc that pauses the game state must restore it on exit, or the map freezes.
- **Baked-in turn and faction bounds.** `rsMapStepStartTurn` caps `wCurrentTurn` at `999` and ticks status durations only for faction slots `0` through `6`. `rlAddTurnStartLovePoints` stops awarding love points after turn `50`.

## Where it lives in the source

| File | Role in the turn |
|---|---|
| [engine/map/map_step.asm](../../engine/map/map_step.asm) | `rlMapUpkeep`, `rlMapSetup`, `rlMapStep`, `aMapStepRoutines`, and the deferred consequence chain |
| [engine/units/turn_start.asm](../../engine/units/turn_start.asm) | Turn-start healing priority and status-effect resolution (`rlGetTurnStartEffectsByStatus`) |
| [engine/map/phase_banner.asm](../../engine/map/phase_banner.asm) | `procPhaseBanner` and the `wGameStateRoutine1` pause trick |
| [include/Map.h](../../include/Map.h) | `MAP_STEP_*` constants and `MAP_STEP_COUNT` |
| [include/WRAM.h](../../include/WRAM.h) | `wGameStateStep`, `wSavedMapStep`, `wCurrentTurn`, `wActiveFactionSlot`, `wMapStateFlags`, `wChapterFlags` |
| [docs/reference/map.md](../reference/map.md) | Full reference for the map system and its open questions |

The turn loop sets the pace of a chapter, but it does not track who stands on which tile or what castles belong to which army. That lives in the deployment table and location records—the subject of Chapter 2.
