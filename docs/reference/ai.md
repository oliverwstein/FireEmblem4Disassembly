# AI

The AI moves every faction the player does not control, during that faction's phase. It works group by group: each faction's units are split into numbered AI groups (the *AI setting*, 1 to 8), each group has a script in the chapter's event data that sets its objective and mode, the engine plans a target, waypoint and formation for the group, and then each unit of the group moves and acts in turn. Guide: [Chapter 14](../guide/14-armies-with-a-mind.md). Per-routine details: [routines/ai.md](routines/ai.md).

## Files

| File | Responsible for |
|---|---|
| [engine.asm](../../engine/ai/engine.asm) | the per-frame cycle (`rlRunAIEngineCycle`), turning it on and off, the seize after a siege, the clever-mode flag |
| [scripts.asm](../../engine/ai/scripts.asm) | the AI script interpreter and its commands, which set a group's objective and mode; the engageability check |
| [lists.asm](../../engine/ai/lists.asm) | the list of the group's own units and the list of targets |
| [groups.asm](../../engine/ai/groups.asm) | group leaders, leadership power, formation patterns and destinations |
| [threat.asm](../../engine/ai/threat.asm) | threat ranges, the group's target and waypoint, one unit's turn, the move, the queued action and its 16 routines |
| [actions.asm](../../engine/ai/actions.asm) | who can act, weapons and staves, castle capture, the objective routines, sorties, the closest tile toward a destination |
| [attack.asm](../../engine/ai/attack.asm) | attack tiles, attack types, expected damage, the score and the choice between candidates, the nearest-target fill |
| [maps.asm](../../engine/ai/maps.asm) | the maps it reasons with: movement, cost, threat (`aRangeMap`), target distance, target, friendly and unfriendly units; the waypoint walk |

Data: [include/AI.h](../../include/AI.h) (list entries, script commands); RAM `$0E7B`-`$0EA5` (`bAIEngineFlags`, `wAIEngineCycleType`, `wAICurrentAISetting`, `wAIActiveFaction`, the queued action) and the AI's work area at `$7E2000` (`wAIGroupFlags`, `wAIGroupMode`, the group's waypoint and target, `aAIUnitList`), `$7E5025` (`aAITargetList`) and `$7F4402` (`aAIAction`, then the `$1000`-byte maps) in [include/WRAM.h](../../include/WRAM.h). The scripts are in [events/](../../events/), listed by each faction group's `GroupAIPointers`.

## Control flow

`rlRunAIEngineCycle` is called every frame from the map's main loop (`rsMapMainLoop`), not from the interrupt, so a step that outlasts a frame doesn't drop one. It does nothing unless the map step is running (`wGameStateRoutine1` is `GAMESTATE_MAP_STEP`, step not 3 or 5), no event is running, no AI unit event is queued (`wChapterFlags` `$0080`), and the cycle is enabled (`bAIEngineFlags` `$40`, set by `rlEnableAIEngineCycle` for a non-player phase). Each working step sets `bAIEngineFlags` `$10`, which makes the map's VBlank handler leave the sprite buffer alone (the AI's maps share RAM with `aMovingMapSpriteBuffers`). Then it runs one step of `wAIEngineCycleType`, from `aAIEngineCycleRoutines`:

| Cycle | Routine | Does |
|---|---|---|
| 0 | `rsAIEngineSetupCycle` | takes the active faction, starts at group 1 |
| 1 | `rsAIEngineTargetListCycle` | builds the target list (living units of factions at war with this one) |
| 2 | `rsAIEngineGroupScriptCycle` | fills the friendly and unfriendly unit maps; for each group from the current one to 8, builds its unit list, checks whether a foe is within a member's threat range, and runs its script. The first group whose script sets an objective (`wAIGroupObjective`) moves on to 3; when none is left, sets bit `$20` of `wMapStateFlags` and goes to 7 |
| 3 | `rsAIEngineGroupTargetCycle` | raises the mode from 1 to 2 if a foe is in threat range; picks the group's target (nearest target-map tile from the leader) and waypoint (as far along the path as the leader's planning movement reaches); turns the formation |
| 4 | `rsAIEngineGroupDestinationCycle` | waits for any map action; sets each member's destination: waypoint + rotated formation offset (with objective 6, a group already in formation is skipped) |
| 5 | `rsAIEngineUnitTurnCycle` | the selected unit, if it can act, decides and starts its move (`rlAIRunSelectedUnitTurn`) |
| 6 | `rsAIEngineNextUnitCycle` | waits for the action to finish; seizes a castle after a won siege; a unit with Canto goes again; otherwise the next unit (5) or the next group (2) |
| 7 | `rsAIEngineDoneCycle` | nothing: the faction is done |

Cycles 4 and 6 set `wChapterFlags` `$0080` before each unit; the map step then announces event action `$21` for it (`rsRunQueuedAIUnitEvent`).

### Scripts, objectives and modes

`rlRunAIScript` resets the group (mode 1, no formation, leader planning movement 0.7, no objective), skips the script and charges if the leader is dead and no member reaches 10, and otherwise runs commands until one sets an objective or `AI_END`. Commands and what each does are documented in [include/AI.h](../../include/AI.h).

Objectives (`aAIGroupObjectiveRoutines`): 0 none, 1 enemy castle, 2 villages, 3 units, 4 hold (mode 4), 5 stand (mode 5), 6 defend own castle, 7 leader to a tile / stand, 8 go beside a unit and act on it (`wAIInteractionActionID`: 0 wait, 1 attack, 12 talk), 9 leader home, 10 leader home to revive the group, 11 leader holds, 12 all home.

Modes (`wAIGroupMode`, the attack type in `aAIAttackTypeRoutines`): 0 advance (HP / 2 + turn / 2 covers the damage back; with a foe near, no tile farther from the group's target), 1 any reachable tile, 2 damage above 0, 3 never (no castles), 4 cautious (no threat map), 5 only from its own tile (no threat map; guarding units always), 6 never, 7 as 2 but not foes guarding castles (no castles), 8 as 2. The full rules are beside `wAIGroupMode` in WRAM.h.

### One unit's turn

`rlAIRunSelectedUnitTurn` builds the threat map (unless mode 4 or 5), fills the unit's movement map, sorties it from its castle if it is inside (or ends), then, unless berserk: takes an enemy castle within reach (`rsCheckIfCastlesCapturable`: seize, action 4, or attack the guard, 2 or 15), or runs the guard's gate attack or the group's objective routine. Otherwise (and when berserk, against friends) it evaluates its inventory (`rsAIEvaluateInventoryActions`): for each weapon or staff, each candidate tile around each target in threat range (`rlAIEvaluateAttackTilesForTarget`) is tested by the attack type and scored. Weapons: expected damage dealt + target HP bonus (21 − HP, +20 for a kill) − expected damage taken − own low-HP penalty − tile threat (≤ 7). Healing staves 500 + missing HP ratio − threat; status staves 300 + target might − threat. The best is kept (`rsAICheckIfNewBestTarget`); a random number at or above the leadership power (50 + 10 × leader's stars, 100 in clever mode, 0 when berserk) accepts (even) or rejects (odd) a candidate regardless of score. The choice is written to `aAIAction` (`rlAICommitAction`), the unit moves toward it or its formation spot (`rsAIMoveSelectedUnitTowardTarget`: closest stoppable tile by target distance, foes costing 24 more, ties by threat), and if it reached the action's tile, `rlAIExecuteQueuedAction` runs one of 16 actions: wait, battle (1, 8 status staff, 14 healing staff, 15), siege battle (2), enter the home castle (3), seize (4), raid (5), guard (6), leave the guarding spot and go inside (7), scripted battle (11), talk (12), revive and enter the castle (13); 9 and 10 do nothing.

## Depends on

The map's unit and terrain data (deployment table, the movement walk in [engine/map/](../../engine/map/)), unit and item getters ([engine/units/](../../engine/units/), [engine/items/](../../engine/items/)), the battle code for every action that fights or uses a staff, and the chapter event data for the group scripts and event action `$21` ([engine/events/](../../engine/events/)).

## Quirks

- Modes 4 and 5 skip the threat map and read whatever `aRangeMap` last held, usually the player-style range input built when the previous computer unit was picked up.
- `rsAICheckIfUnitCanEngageAnyTarget` tests the member's own deployment state instead of the target's; a failed damage estimate counts as engageable.
- Objective 8's try at the gate of a castle the target guards is always rejected (gate tiles fail the tile check).
- The mode-5 branch of `rlGetSelectedUnitAttackThreatRange` never runs.
- The target scoring at the end of `rlFillRangeMapOfAITargetsNearLeader` (`rsAIScoreTargetsNearLeader` and the class tables in attack.asm) is unreachable.
- Neither list checks its count (24 units, 48 targets; the target list is followed by `aPermanentEventFlags`).
