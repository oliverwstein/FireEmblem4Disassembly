# AI

The AI moves every faction the player does not control, during that faction's phase. It works group by group: each faction's units are split into numbered AI groups (the *AI setting*), each group has a script in the chapter's event data that sets its goal, and then each unit of the group moves and acts in turn. Per-routine details: [routines/ai.md](routines/ai.md).

## Files

| File | Responsible for |
|---|---|
| [engine.asm](../../engine/ai/engine.asm) | the per-frame cycle (`rlRunAIEngineCycle`), turning it on and off, the clever-mode flag |
| [scripts.asm](../../engine/ai/scripts.asm) | the AI script interpreter and its commands, which set a group's goal |
| [lists.asm](../../engine/ai/lists.asm) | the list of the group's own units and the list of targets |
| [groups.asm](../../engine/ai/groups.asm) | group leaders, formation, moving members around their target |
| [threat.asm](../../engine/ai/threat.asm) | threat ranges, the group's target and waypoint, one unit's turn, the queued action and its routines |
| [actions.asm](../../engine/ai/actions.asm) | choosing what a unit does: weapons and staves, objectives (villages, castles, talking, retreating), deploying from a castle |
| [attack.asm](../../engine/ai/attack.asm) | choosing whom to attack and from where: attack tiles, attack types, expected damage |
| [maps.asm](../../engine/ai/maps.asm) | the maps it reasons with: movement, range, target distance, friendly and unfriendly units |

Data: [include/AI.h](../../include/AI.h); RAM `$0E7B`-`$0EA5` (`bAIEngineFlags`, `wAIEngineCycleType`, `wAICurrentAISetting`, `wAIActiveFaction`, …) and the AI's work area at `$7E2000`/`$7F4400` (`aAIAction`, the unit list, `aMovementMap`, `aTargetDistanceMap`, `aRangeMap`) in [include/WRAM.h](../../include/WRAM.h).

## Control flow

`rlRunAIEngineCycle` is called every frame from the map's main loop (`rsMapMainLoop`), not from the interrupt. It does nothing unless the chapter map is up (`wGameStateRoutine1` is `GAMESTATE_MAP_STEP`, step not 3 or 5), no event is running (`wEventEngineFlags` is 0), and the cycle is enabled (bit `$40` of `bAIEngineFlags`, set by `rlEnableAIEngineCycle` for a non-player phase). Then it runs one step of a small state machine, `wAIEngineCycleType`, from `aAIEngineCycleRoutines`:

| Cycle | Routine | Does |
|---|---|---|
| 0 | `rsAIEngineSetupCycle` | takes the active faction, starts at group 1 |
| 1 | `rsAIEngineTargetListCycle` | builds the target list |
| 2 | `rsAIEngineGroupScriptCycle` | fills the friendly and unfriendly unit maps; for each group from the current one to 8, builds its unit list and runs its script. The first group whose script sets an objective (`wAIGroupObjective`) moves on to 3; when none is left, sets bit `$20` of `wMapStateFlags` and goes to 7 |
| 3 | `rsAIEngineGroupTargetCycle` | raises the group's mode from 1 to 2 if a foe is in its threat range; picks the group's target and the leader's waypoint |
| 4 | `rsAIEngineGroupDestinationCycle` | waits for any map action; sets each member's destination (with objective 6, a group already in formation is skipped) |
| 5 | `rsAIEngineUnitTurnCycle` | the selected unit, if it can act, moves and queues its action (`rlAIRunSelectedUnitTurn`) |
| 6 | `rsAIEngineNextUnitCycle` | waits for the action to finish; seizes a castle after a won siege; a unit with Canto goes again; otherwise the next unit (5) or the next group (2) |
| 7 | `rsAIEngineDoneCycle` | nothing: the faction is done |

Because each cycle is one call per frame and cycles 4 and 6 wait for `wMapActionActiveFlag`, the AI never blocks the frame: movement and battles play out through the normal map code while the AI waits.

### One unit's turn

`rlAIRunSelectedUnitTurn` fills the unit's movement map, runs the group's **objective** routine (`aAIGroupObjectiveRoutines`, indexed by `wAIGroupObjective`: raid a village, guard a castle gate, interact with a unit, go home, retreat and revive, hold position, …) and otherwise evaluates its inventory (`rsAIEvaluateInventoryActions`): for each weapon or staff, each candidate tile around each target (`rlAIEvaluateAttackTilesForTarget`) is tested by the unit's **attack type** (`aAIAttackTypeRoutines`: intimidate, reachable, regular, cautious, defending a castle, or never), and the best is kept. The choice is written to `aAIAction` (`rlAICommitAction`), the unit moves toward it (`rsAIMoveSelectedUnitTowardTarget`), and after the move `rlAIExecuteQueuedAction` runs one of 16 actions: wait, battle, siege battle, enter the home castle, seize a castle, raid a village, guard a castle (onto its guarding spot), leave the guarding spot and go inside, scripted battle, talk, revive and enter a castle (9 and 10 only finish the turn).

## Depends on

The map's unit and terrain data (deployment table, `aMovementMap` filling in [engine/map/](../../engine/map/)), unit and item getters ([engine/units/](../../engine/units/), [engine/items/](../../engine/items/)), the battle calculations for expected damage, and the chapter event data for the group scripts ([engine/events/](../../engine/events/)).

## Open questions

- The meaning of the group modes in `wAIGroupMode`, and the full list of objectives (`wAIGroupObjective`: 2 village, 6 castle gate, 8 interact, 9-12 leader and castle objectives; 3-5 test whether a foe is in range).
- Which flags `bAIEngineFlags` holds besides `$01` (an AI action is running) and `$40` (the cycle is enabled).
- Whether actions 3, 12 and 13 (enter home castle, talk, revive) are ever chosen; `tools/sweep.py` found their routines unreferenced before the table was decoded.
