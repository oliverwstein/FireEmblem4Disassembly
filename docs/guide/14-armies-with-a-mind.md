# Chapter 14: Armies with a Mind

The AI moves every army the player doesn't control, during that army's phase. It works in three layers. An army's units are split into numbered **groups**, and each group has a **script** in the chapter's event data that runs at the start of the group's turn and gives it an objective: take a castle, defend one, raid villages, attack, hold, retreat. The engine then plans for the group as a whole: it finds the nearest target, picks a waypoint toward it, and lays the group's formation around that waypoint. Last, each unit decides for itself. It checks whether it can seize a castle, scores every weapon and staff it carries against every target it could reach, and moves, either to the best attack tile or to its place in the formation.

All of this runs in the main loop, outside the interrupt that drives the frame, as a small state machine that takes one step per call. A step that takes longer than a frame doesn't hold the screen up, and a step that has to wait for a unit to walk or a battle to play returns at once and checks again next frame.

This chapter covers where the AI runs, the groups and the lists it works from, the scripts with their objectives and modes, the group's plan, one unit's turn and how its choice is scored, moving and acting, and the costs.

## Running beside the frame

### The main loop and the interrupt

Almost all of the game's per-frame work runs inside the vertical-blank interrupt: hardware uploads, the game state's step, procs, map sprites, sound ([Chapter 26](OUTLINE.md)). The main loop gets the time left over. Each screen installs its own main loop routine; the map's is `rsMapMainLoop`, and it calls `rlRunAIEngineCycle` once per pass, then waits for the next frame.

That placement is the AI's time-slicing. A step of the AI that runs past the end of the frame is interrupted, the interrupt does the frame's work, and the step resumes where it was. The screen keeps scrolling, procs keep running, and music keeps playing. The cost is that the AI's work can collide with the interrupt's, and the engine guards the collisions with bits of `bAIEngineFlags`:

| Bit | Set | Meaning |
|---|---|---|
| `$10` | at the start of every cycle step that does work | The map's interrupt handler skips clearing and redrawing the sprite buffer. The AI's unit maps share RAM with the buffers the moving unit's sprite is drawn from (`aMovingMapSpriteBuffers`), so the map sprites keep the previous frame's picture while the AI thinks. |
| `$20` | on entry to `rlRunAIEngineCycle` | The map step's per-unit event hook (below) waits until it clears. |
| `$40` | at the start of a computer phase | The cycle runs at all. |
| `$01` | when the AI starts a unit's move | A map action the AI started is still running; the action clears it when it ends. |

`$10` and `$20` are cleared when `rlRunAIEngineCycle` returns.

The AI can also block on purpose. A unit sortieing from a castle queues the relocation and then loops until the interrupt's map step has carried it out (`rsAITryDeployUnitFromCastle`), which is safe only because the loop runs outside the interrupt.

### The cycle

`rlRunAIEngineCycle` does nothing unless the map step is running (and isn't in step 3, the phase-start events, or step 5, the healing windows), no event is running, the cycle is enabled, and no per-unit event is waiting. Then it runs one step of `wAIEngineCycleType`:

| Cycle | Routine | Does |
|---|---|---|
| 0 | `rsAIEngineSetupCycle` | takes the active army; starts at group 1 |
| 1 | `rsAIEngineTargetListCycle` | builds the target list |
| 2 | `rsAIEngineGroupScriptCycle` | maps where friendly and unfriendly units stand; for each group from the current one to 8, builds its unit list and runs its script. The first group given an objective goes on to 3. When no group is left, sets the phase-over bit and goes to 7 |
| 3 | `rsAIEngineGroupTargetCycle` | raises the group's mode from 1 to 2 if a foe is in range; picks the group's target and waypoint |
| 4 | `rsAIEngineGroupDestinationCycle` | waits for any map action; gives each member a destination in the formation |
| 5 | `rsAIEngineUnitTurnCycle` | the selected unit decides, and starts its move |
| 6 | `rsAIEngineNextUnitCycle` | waits for the move and action to end; then the same unit again (canto), the next unit (5), or the next group (2) |
| 7 | `rsAIEngineDoneCycle` | nothing: the army is done |

`rlEnableAIEngineCycle` sets the cycle to 0 at map step 4 of every phase but the player's ([Chapter 8](08-the-turn.md)). The phase itself, map step 7, ends when cycle 2 runs out of groups and sets bit `$20` of `wMapStateFlags`.

Cycles 4 and 6 also set bit `$0080` of `wChapterFlags` before each unit acts. The map step sees it on its next frame and announces event action `$21` with the turn, the army, the unit's group, and its character ([Chapter 11](11-the-game-is-watching.md)). The AI doesn't run while that bit is set or while an event runs, so a scene the announcement starts plays out before the unit moves.

A computer phase on the timeline:

```
frame  1  cycle 0          setup
frame  2  cycle 1          target list
frame  3  cycle 2          scripts of groups 1, 2, ...  → group 2 has an objective
frame  4  cycle 3          group 2's target and waypoint
frame  5  cycle 4          formation destinations
frame  6  cycle 5          (the map step first announces event action $21)
                           the unit decides; its move starts
frames 7+ cycle 6          returns at once while the unit walks and fights
          cycle 6          next unit → cycle 5 again
          ...
          cycle 2          scripts from group 3 on ...
          cycle 2          no group left → phase over → cycle 7
```

Each line is at least one frame. A step that outlasts its frame stretches over several, with the interrupt still drawing every one.

## Groups and their lists

### Groups

Every unit has an **AI setting**, a number from 1 to 8 given in the chapter's unit data (`structUNITEntry.AI`), along with a **group leader** flag and a **formation slot** (0–17). A group is the units of one army with the same setting. Its script comes from the army's faction group ([Chapter 4](04-armies-and-allegiance.md)): `structFactionGroupData.GroupAIPointers` points to a list of script pointers, the first for setting 1, the second for setting 2, and so on. The chapters hold 190 scripts. Chapter 1's Verdane army has four groups; Nordion has one.

The cycle visits groups 1 to 8 in order, and finishes one group's units before running the next group's script. A group only acts on its turn, so a later group's script sees the board as the earlier groups left it.

### The unit list and the target list

The AI caches what it needs about units in two lists in bank `$7E`. Cycle 1 builds the **target list** (`aAITargetList`, 48 entries of `structAITargetEntry`) from every living unit whose army is at war with the active army. Neutral armies aren't targets. Cycle 2 builds the **unit list** (`aAIUnitList`, 24 entries of `structAIUnitEntry`) for each group as its turn comes, from the living members; a dead leader sets a flag instead. Both entries hold:

| Field | Value |
|---|---|
| unit pointer, deployment offset, tile | which unit, and where it stands |
| item pointer, weapon type, might | the unit's first weapon (the unit list's are updated per weapon during scoring) |
| defense, resistance | for the damage estimates |
| threat range | the farthest tile it could attack this turn, as a distance in tiles |

The target entry adds the target's terrain; the unit entry adds the destination the group plan gives the unit.

The threat range is a quick upper bound. A unit's reach in tiles is greatest on roads, which cost 7 tenths of a movement point, so the engine takes movement × 10/7, rounded up, from a table, and adds the weapon's maximum range. A target uses its movement; the AI's own units use movement + 1 and their longest-reaching weapon. The range is compared with the Manhattan distance (the sum of the differences in X and Y), with no terrain at all. In cycle 2, before the script runs, `rlAICheckIfAnyFoeInAlliesThreatRange` compares every target with every member, and any pair within range sets bit `$0004` of `wAIGroupFlags`: a foe is near.

### The unit maps

Several steps start by writing every unit into 64 × 64 byte maps of the whole chapter, one byte per tile, holding the unit's deployment offset or `$FF` for none ([Chapter 5](05-who-stands-where.md)):

| Map | Holds |
|---|---|
| `aAllyUnitMap` | units of the active army and its allies |
| `aUnfriendlyUnitMap` | units of armies at war with it or neutral to it |
| `aUnitMap` | every unit |

These sit in the same block of `$1000`-byte grids in bank `$7F` that the player's range search uses ([Chapter 9](09-moving-a-unit.md)), along with the AI's movement, threat, distance, cost, and target maps. Unlike the player's range maps, which are centered on one unit, the AI's maps are indexed by the tile's own position, `y × 64 + x`.

## Scripts

### The format

An AI script is a byte string in the chapter's event bank, read by `rlRunAIScript` from the top at the start of every turn of its group. A command byte indexes `aAIScriptCommands`; its arguments follow. Commands do one of two things. Most set an option or test the board and go on to the next command. The rest give the group an **objective** (`wAIGroupObjective`) and end the script. A command whose test fails (the castle isn't held by a foe, no village is left) goes on, so a script is a list of goals in order of preference. If a script reaches `AI_END` without an objective, the group sits out the phase.

Before the script runs, the engine resets the group's options: mode 1, no formation, a leader who plans with 70% of its movement, no objective, no target. If the leader is dead and no member has a weapon reaching 10, the script is skipped and the group charges every foe (`AI_TARGET_ALL_FOES`).

The macros are in [include/AI.h](../../include/AI.h). By use in the chapters:

| Family | Commands (uses) |
|---|---|
| Targets | `AI_TARGET_ALL_FOES` (95), `AI_ATTACK_CASTLE` (50), `AI_DEFEND_CASTLE` (44), `AI_TARGET_REMAINING_VILLAGES` (15), `AI_INTERACT_WITH_UNIT` (7), `AI_TARGET_SPECIFIED_UNIT` (5), `AI_FLAG_IF_LEADER_ON_COORDS` (5), `AI_TARGET_FOES_NOT_GUARDING` (4), `AI_SURROUND_TARGETS` (3), `AI_RETURN_HOME_IF_NO_TARGETS` (1) |
| Holding and retreating | `AI_STAND_IF_FOE_IN_RANGE` (32), `AI_CHARGE_IF_ENGAGEABLE_ELSE_HOLD` (32), `AI_LEADER_RETREAT_IF_GROUP_BELOW` (27), `AI_LEADER_RETREAT_IF_HP_BELOW` (26), `AI_LEADER_HOLD` (2), `AI_STAND` (1), `AI_NO_OBJECTIVE` (1) |
| Options | `AI_SET_FORMATION` (64), `MODIFY_GROUP_LEADER_FIELD_MOVEMENT` (21), `AI_SET_IGNORED_GENERATION_ID` (9), `AI_SET_MODE` (8), `AI_REINFORCE_EVERY_N_TURNS` (4), `AI_HALVE_MOVEMENT` (1) |
| Branches and flags | `AI_JUMP_IF_CHAPTER_EVENT_FLAG_SET` (29), `AI_JUMP_IF_TURN_REACHED` (11), `AI_JUMP_IF_ENGAGEABLE` (4), `AI_SET_CHAPTER_EVENT_FLAG` (3), `AI_JUMP_IF_CHAPTER_EVENT_FLAG_UNSET` (1), `AI_ASMC_CHECK` (1) |

Seven commands appear in no script: the plain jump, a single village, the leader's return home on its own (`AI_LEADER_RETREAT_IF_HP_BELOW` uses it), clearing a flag, and three copies of the surround command (`$1A`–`$1C`, identical to `$1D`).

"Engageable" (`rlAICheckIfAnyGroupUnitCanEngageFoe`) needs a foe near, and then a member whose longest-reaching weapon covers a foe's tile from somewhere it can move this turn. For such a pair the engine estimates the member's damage to the foe (below). If the estimate fails, because the member can't hurt the foe at all, the check counts the pair as engageable; if the member can hurt it, the pair counts only when the member's HP plus its defense (resistance against magic) is at least the foe's might. The first member found acts first. Two slips make the check generous: a member that can do no damage passes it, and the test meant to skip defeated and hidden foes looks at the member's own deployment state instead.

Chapter 1's scripts show how the commands combine. Genoa's group 2 defends its castle; Verdane's group 4 waits:

```
aFactionGroup05AI2                      ; Genoa, group 2
    AI_JUMP_IF_ENGAGEABLE +
      AI_DEFEND_CASTLE Ch01_Genoa, $04
      AI_END
+   AI_SET_CHAPTER_EVENT_FLAG Chapter01, FlagChapter01_FoesNearGenoa
    AI_DEFEND_CASTLE Ch01_Genoa, $04
    AI_END

aFactionGroup07AI4                      ; Verdane, group 4
    AI_SET_IGNORED_GENERATION_ID GEN_ID_Sigurd
    AI_JUMP_IF_CHAPTER_EVENT_FLAG_SET Chapter01, FlagChapter01_FoesNearGenoa, +
      AI_CHARGE_IF_ENGAGEABLE_ELSE_HOLD
      AI_END
+   AI_ATTACK_CASTLE Ch01_Genoa, $00
    AI_TARGET_ALL_FOES
    AI_END
```

Genoa's guard defends its castle. On the first turn one of its units can engage a foe, its script sets `FlagChapter01_FoesNearGenoa`. Verdane's group 4 holds where it is until something comes within reach. Once the flag is set, it marches on Genoa castle, or on every foe once Genoa has fallen, and its leader won't attack Sigurd. The chapter's event list watches the same flag: before a unit of that group acts with the flag set, event action `$21` runs the scene in which Ayra starts moving. The script and the event list share state only through the flag.

### Objectives

The objective decides what each unit tries before its weapons, or instead of them. Each has a routine in `aAIGroupObjectiveRoutines`, run for every unit of the group:

| Objective | Set by | Each unit |
|---|---|---|
| 0 | `AI_NO_OBJECTIVE`, or none | the group sits out |
| 1 | `AI_ATTACK_CASTLE` | scores its weapons; otherwise heads for the castle |
| 2 | `AI_TARGET_VILLAGE`, `AI_TARGET_REMAINING_VILLAGES` | heads for the group's village, or the nearest open one it can reach, and raids it; it doesn't fight on the way |
| 3 | `AI_TARGET_ALL_FOES`, `AI_TARGET_SPECIFIED_UNIT` | with a foe near, scores its weapons; otherwise only moves |
| 4 | `AI_CHARGE_IF_ENGAGEABLE_ELSE_HOLD` | the same as 3, in mode 4 |
| 5 | `AI_STAND_IF_FOE_IN_RANGE` | the same as 3, in mode 5 |
| 6 | `AI_DEFEND_CASTLE` | a unit guarding the castle attacks a foe on its gate; the others take their places around it without attacking |
| 7 | `AI_FLAG_IF_LEADER_ON_COORDS`, `AI_STAND` | scores its weapons; otherwise heads for the tile |
| 8 | `AI_INTERACT_WITH_UNIT`, `AI_SURROUND_TARGETS` | goes to the first reachable, empty tile beside the unit (above, left, right, below) and waits, attacks, or talks |
| 9 | `AI_LEADER_RETREAT_IF_HP_BELOW` | the leader goes into the army's home castle; the others charge |
| 10 | `AI_LEADER_RETREAT_IF_GROUP_BELOW` | the leader goes home and revives the group's dead there; the others charge |
| 11 | `AI_LEADER_HOLD` | the leader stays; the others charge |
| 12 | `AI_RETURN_HOME_IF_NO_TARGETS` | everyone goes home |

For a unit guarding a castle, objective 8 would also try the castle's gate, but the tile check rejects gate tiles, so that try never succeeds.

Objective 9 is how a boss withdraws to heal. Chapter 1's Genoa script sends its leader home at 30% of its HP or less and keeps it inside until it is back to full: a leader in its castle doesn't come out while the objective is 9, 11, or 12. Objective 10 revives the dead members into the home castle, and they come out through the gate in a later phase. `AI_REINFORCE_EVERY_N_TURNS` does the same without the trip: while the leader lives, on every turn divisible by its argument, it revives the group's dead and rebuilds the unit list, so they come out in the same phase.

Only a leader talks. The Prologue, Chapter 5, and Chapter 9 each send a leader to talk to Sigurd or Seliph with action 12; the AI announces the talk as event action `$0A`, and the chapter's talk events take it from there.

### Modes

The **mode** (`wAIGroupMode`) is the group's attack policy, and it changes a few other rules with it. The script sets it (`AI_SET_MODE`, or the second argument of the castle commands); otherwise it is 1, and cycle 3 raises 1 to 2 once a foe is near.

| Mode | Attacks when | Other rules |
|---|---|---|
| 0 | the expected damage dealt is above 0 and HP / 2 + turn / 2 is at least the damage expected back. With a foe near, only from a tile no farther from the group's target than the unit stands | |
| 1 | the attack tile is reachable | the default |
| 2 | the attack tile is reachable and the expected damage is above 0 | |
| 3 | never | takes no castles |
| 4 | as 2, and HP − 5 + turn / 2 and damage dealt / 2 + turn / 2 are both at least the damage expected back, and 3 × HP is at least the tile's threat | no threat map |
| 5 | only from the tile the unit stands on, with damage above 0 | no threat map; every unit guarding a castle uses 5 |
| 6 | never | |
| 7 | as 2, but leaves foes guarding a castle alone | takes no castles |
| 8 | as 2 | no script sets it |

The turn term makes armies bolder as a chapter drags on: by turn 20, a mode-0 unit accepts 10 more points of expected damage than it would on turn 1.

Modes 3 and 6 let a group move and talk without fighting; the talkers in Chapters 5 and 9 use mode 3. A later command can still change the mode: `AI_FLAG_IF_LEADER_ON_COORDS`, for one, sets mode 0 when it gives the group its tile.

## Planning for the group

### The target and the waypoint

The target commands write into `aTargetMap`, a byte per tile, `$FF` where there is nothing to go for: a castle's location ID, a unit's deployment offset halved, or a marker for a tile. Cycle 3 then plans from the group's leader (or its first member, if it has none):

1. Fill a distance map outward from the leader until the fill reaches a target tile. The fill uses a cost map in which castles and ramparts are passable at a cost of 16, so a path can be planned through a castle. The first target reached is the group's **target** (`wAIGroupTargetXPosition`, `…YPosition`).
2. Fill the leader's movement map with its planning movement: 70% of its movement by default, or the fraction `MODIFY_GROUP_LEADER_FIELD_MOVEMENT` gives.
3. Walk back from the target down the distance map until reaching a tile in the leader's movement map. That tile is the **waypoint**. The walk tries the four neighbors in a different order on alternate steps, so a path across open ground zigzags instead of running straight along one axis and then the other.

The waypoint is where the group's formation is centered this turn. By default it lies within 70% of the leader's movement, so the group advances more slowly than its leader could alone.

Some groups skip the walk. The waypoint is the target itself when the leader goes straight there (objectives 9 to 11), when the leader is guarding a castle, when a castle-defending group is in mode 4, and when the group has no leader at all. A leaderless group in mode 4 or 5, and a castle-defending group in mode 5, get no waypoint, and their members stay where they are.

### Formations

A formation is a list of 18 offsets from the waypoint, one per formation slot. There are 15 patterns (`aFormationPatternOffsets`): none (every slot at the waypoint), blocks, lines one to three wide, a checkerboard, arrows, walls, a U, a zipper, a circle, the castle defense, and one for Julius. Formation 3 (`aFormationPatternArrowShaft`) puts the leader at the bottom and the group ahead of it, "ahead" meaning north:

```
 .  .  . 17  .  .  .        slot numbers; L is slot 0, at the waypoint
 .  .  . 16  .  .  .
 .  . 14  9 15  .  .
 . 12  7  4  8 13  .
10  5  2  1  3  6 11
 .  .  .  L  .  .  .
```

The pattern is turned toward the waypoint before it is used. `rlAIUpdateFormationDirectionTowardTarget` compares the waypoint with the leader's position and picks up, right, down, or left along the axis with the larger difference; the four routines in `aFormationDirectionRoutines` rotate each offset by a quarter turn per step. Formation 0 and the castle defense (13) don't turn.

Cycle 4 gives every member its destination: the waypoint plus its rotated offset (`rlSetTargetPositionForAIGroupMembers`). A member guarding a castle stays. A group with no waypoint gets its current positions as destinations. A castle-defending group whose members already stand in formation is skipped for the turn: the cycle moves straight to the next group.

The destination is only a goal. Whether the unit reaches it, or does something else, is decided in its own turn.

## One unit's turn

### The order of decisions

Cycle 5 checks that the unit can act at all: it isn't dead, hasn't moved, and isn't asleep, captive, cured, or a freelancer (`rlCheckIfAIUnitCanAct`). Then `rlAIRunSelectedUnitTurn`:

```rust
fn ai_run_selected_unit_turn(unit) {                  // rlAIRunSelectedUnitTurn
    if mode != 4 && mode != 5 {
        build_threat_map();                           // rlFillRangeMapOfAITargetsNearLeader
    }
    target_tile = unit.formation_destination;
    fill_movement_map(unit);                          // rlFillSelectedUnitMovementMap
    if !unit.fielded {                                // waiting inside a castle
        if !sortie_from_castle(unit) { return; }      // rsAITryDeployUnitFromCastle
    }
    if unit.status != Berserk {
        if try_take_castle(unit) { return move_toward(target_tile); }  // rsCheckIfCastlesCapturable
        if unit.guarding_castle {
            attack_foe_on_gate(unit);                 // rsAICastleGuardAttackUnitOnGate
        } else if objective_routine(unit) {           // aAIGroupObjectiveRoutines; true: only move
            return move_toward(target_tile);
        }
        if action_chosen() { return move_toward(target_tile); }
    }
    if !unit.canto_move {
        evaluate_inventory(unit);                     // rsAIEvaluateInventoryActions
    }
    move_toward(target_tile);                         // rsAIMoveSelectedUnitTowardTarget
}
```

Any step that chooses an action writes it into `aAIAction` and commits it (`rlAICommitAction`): the destination tile replaces the formation spot, and the action and its other unit are queued for after the move.

A unit inside a castle comes out onto the gate if the gate is free of unfriendly units and the objective isn't one that sends it home, then carries on with the turn from the gate. Berserk units skip castles and objectives and attack their own side.

### Taking castles

Before its objective, every unit outside modes 3, 6, and 7 looks for an enemy castle to take (`rsCheckIfCastlesCapturable`). Berserk units, groups with objective 7, and leaders under objectives 10 and 11 don't look. For each castle held by an army at war with the unit's, the gate must be in the unit's movement map and free of its allies. If no one guards the castle, the unit moves onto the gate to seize it (action 4). If someone does, and the unit has a weapon that reaches 1 and could hurt the guard, it attacks the guard (action 2, a siege, or 15). After a siege, cycle 6 checks the castle again, and if the guard has fallen, it starts a seize at once (`rsAICheckCastleCaptureAfterSiege`).

### Weapons and staves

`rsAIEvaluateInventoryActions` tries every item in the unit's inventory that it can use. A weapon is tested against the targets, a healing staff against friendly units, and a status staff against the targets. For each target within the unit's threat range, `rlAIEvaluateAttackTilesForTarget` walks the tiles at each distance from the weapon's minimum range to its maximum around the target, a diamond ring per distance, starting below the target. Each tile inside the map that the unit's class can enter, not a castle gate, and empty or holding the unit itself, is a candidate, and the candidate goes to the routine for the item:

| Item | Candidate tile must | Score | Action |
|---|---|---|---|
| Weapon | pass the mode's test (above) | see below | 1 |
| Heal, Mend, Recover, Physic, Fortify | be reachable; the friend must be hurt | 500 + missing HP / max HP × 256 − threat | 14 |
| Silence, Sleep, Berserk, Thief | be the tile the unit stands on; the user's magic must exceed the target's resistance, and the target must not already be silenced, asleep, or berserk | 300 + target's might − threat | 8 |

A Silence staff is used only on a unit with a staff or tome rank. Fortify's action names no target, since it reaches everyone. The utility staves (Return, Warp, Rescue, Charm, Restore, Valkyrie) are never used. Staff scores start at 300 and 500, far above any weapon's, so a unit that can heal a hurt ally heals instead of attacking.

### The score

The weapon score rests on an expected damage estimate (`rsAIGetExpectedDamage`):

```
damage   = might (× 2 if effective against the defender) − defense (resistance against magic)
hit      = attacker's hit + triangle bonus − (defender's avoid on its terrain + its triangle bonus)
expected = damage × min(hit, 100) / 100        (if damage or hit is 0 or less, the estimate fails)
```

The estimate runs once each way. The unit against the target must succeed, or the tile is rejected. The target's first weapon against the unit, from the attack tile, counts as 0 if it fails or the target can't strike back at that distance. Doubling, critical hits, and skills are left out. Then (`rsAICalculateAttackChance`):

```
score = expected damage dealt
      + (21 − target's HP, if below 21) + (20 if one hit's damage would kill)
      − expected damage taken
      − (21 − own HP, if below 21)
      − threat on the attack tile (foes that could attack it, at most 7)
```

The **threat map** behind the last term is `aRangeMap`. For every target within 16 tiles of the group's leader, the engine fills that foe's movement and marks every tile its first weapon could hit from anywhere it could move, adding 1 to each (`rlFillRangeMapOfAITargetsNearLeader`). Foes whose weapons start at range 3 (ballistae and the long-range tomes) are left out. Modes 4 and 5 skip this step, and their units read whatever `aRangeMap` holds: by then that is usually the input grid of the player-style range search ([Chapter 9](09-moving-a-unit.md)), built when the previous computer unit was picked up to walk. Its values (1 for friends, `$FE` and `$FF` for walls and foes) aren't threat counts, and they sit on a grid centered on that unit.

A wounded target scores higher, a killing blow higher still, and a unit below 21 HP scores every attack lower. The threat term favors tiles fewer foes can reach, by at most 7 points.

### Choosing, with chance

`rsAICheckIfNewBestTarget` keeps the best candidate across every item, target, and tile. A higher score replaces the best; an equal score replaces it if the attack tile is nearer the unit. Chance can override this. Once a best exists, each new candidate draws a random number from 0 to 99. If the number is at or above the group's **leadership power**, an even number accepts the candidate whatever its score and an odd one rejects it without a comparison:

```
leadership power = 50 + 10 × the leader's leadership stars    (50 with no leader)
                 = 100 in clever mode
                 = 0 for a berserk unit
```

A group with no leader, or with a leader who has no leadership stars, lets chance accept a quarter of its candidates and reject another quarter. A leader with five leadership stars, or the clever enemy option, which appears in the options menu after the game has been finished, makes every choice the highest score. A berserk unit's choices are random.

## Moving and acting

### Toward the destination

With no action chosen, the destination is the formation spot. `rsAIMoveSelectedUnitTowardTarget` moves the unit there or as close as it can get:

1. Fill a distance map from the destination back toward the unit, over a cost map in which each tile with an enemy or neutral unit costs 24 more, so the path bends around them without treating them as walls.
2. Look at every tile in a square around the unit, (movement + 1) × 10/7 tiles in each direction. Of the tiles the unit can stop on (in its movement map, not held by another friendly unit, and not a castle gate unless the action is a siege, a seize, or entering a castle), take the one with the lowest distance, breaking ties by the lowest threat.

If the destination can't be reached from the unit at all, the unit tries the group's target instead, and stays where it is if that fails too.

The move goes through the map's own code ([Chapter 9](09-moving-a-unit.md)). The AI sets the active action's unit and destination and sets `wMapActionActiveFlag` to `$FFFF`. The cursor goes to the unit, picks it up, and walks it at the enemy speed setting. When it arrives, the queued action runs, but only if the unit reached the action's tile; a unit that fell short just waits.

### The actions

`rlAIExecuteQueuedAction` runs one of 16 actions after the walk:

| Action | Does |
|---|---|
| 0 | wait |
| 1, 8, 14, 15 | a battle through `rlRunMapAction` (weapon, status staff, healing staff, attack on a castle's guard) |
| 2 | a siege: marks the attacker with the assault state, then a battle |
| 3 | enter the home castle |
| 4 | seize a castle |
| 5 | raid a village |
| 6 | start guarding a castle |
| 7 | stop guarding and go inside |
| 9, 10 | nothing |
| 11 | a scripted battle |
| 12 | announce a talk (event action `$0A`) |
| 13 | revive the group's dead, then enter the home castle |

Staff use goes through the battle code like an attack. Once the action ends, cycle 6 moves on. A unit with Canto gets a second turn in cycle 5 with its leftover movement. It skips weapons and staves, so the second move takes it toward its destination or onto a castle it can seize.

## Trade-offs and hard limits

Running in the main loop lets a slow step stretch over frames instead of dropping them, and the wait cycles let movement and battles play through the map's ordinary code. The costs are a few flags guarding shared RAM and the map sprites standing still while the AI thinks.

Most of what makes one army behave differently from another is data. A script picks an objective and a mode from a fixed menu, a formation from a table, and a planning speed; event flags let scripts and the chapter's event list react to each other. The tactics are the same code for every unit. A script can't add a new kind of behavior without `AI_ASMC_CHECK`, the one hook for assembly, used once, in Chapter 1.

The estimates are cheap and rough. The threat range is a Manhattan distance with no terrain, the damage estimate ignores doubling, critical hits, and skills, and a foe's danger is judged by its first weapon alone. The score adds damage, HP, and threat as plain numbers.

The limits:

- **Eight groups per army**, one script each.
- **24 units per group list and 48 targets.** Neither list checks its count; a 49th target would be written over the permanent event flags that follow the list.
- **18 formation slots** per pattern; Julius's pattern gives its last five slots the same tile.
- **Threat map**: foes within 16 tiles of the leader, with weapons starting below range 3.
- **Score**: tile threat counts at most 7; staff scores are fixed bases.
- **Modes 4 and 5** read a stale `aRangeMap`.
- **The pickup check**: the AI's chosen tile must pass the player's destination check, or the game stops on a `brk` ([Chapter 9](09-moving-a-unit.md)).

## Where it lives in the source

- [engine/ai/engine.asm](../../engine/ai/engine.asm): `rlRunAIEngineCycle` and the eight cycle routines, the seize after a siege (`rsAICheckCastleCaptureAfterSiege`), the cycle switches (`rlEnableAIEngineCycle`, `rlDisableAIEngineCycle`), and the clever-mode flag (`rlGetCleverModeFlag`).
- [engine/ai/scripts.asm](../../engine/ai/scripts.asm): `rlRunAIScript`, `aAIScriptCommands` and every command, the engageability check (`rlAICheckIfAnyGroupUnitCanEngageFoe`), and the group's alive ratio.
- [engine/ai/lists.asm](../../engine/ai/lists.asm): `rlBuildAITargetList` and `rlBuildAIUnitList`.
- [engine/ai/groups.asm](../../engine/ai/groups.asm): leaders, the script lookup (`rlGetFactionGroupDataGroupAIScript`), leadership power, formation destinations and directions, and `aFormationPatternOffsets` with its 15 patterns.
- [engine/ai/threat.asm](../../engine/ai/threat.asm): threat ranges, the group's target and waypoint (`rlAIUpdateGroupTargetAndWaypoint`), one unit's turn (`rlAIRunSelectedUnitTurn`, `aAIGroupObjectiveRoutines`), the move (`rsAIMoveSelectedUnitTowardTarget`), and the 16 actions.
- [engine/ai/actions.asm](../../engine/ai/actions.asm): who can act, inventory evaluation, staves, castle capture, the objective routines, sorties, and the closest-tile search (`rlAIFindBestMoveTowardTarget`).
- [engine/ai/attack.asm](../../engine/ai/attack.asm): attack tiles (`rlAIEvaluateAttackTilesForTarget`), the attack types, the score (`rsAICalculateAttackChance`, `rsAICheckIfNewBestTarget`), expected damage, and the nearest-target fill (`rlGetNearestPossibleTarget`).
- [engine/ai/maps.asm](../../engine/ai/maps.asm): the AI's movement fill, cost maps, unit maps, the threat map, the target map, and the waypoint walk (`rlTraceTargetPathToReachableTile`).
- [engine/map/map_loop.asm](../../engine/map/map_loop.asm): the main loop that calls the AI and the interrupt handler that checks `bAIEngineFlags`; [engine/map/map_step.asm](../../engine/map/map_step.asm): the per-unit event (`rsRunQueuedAIUnitEvent`); [engine/map/unit_movement.asm](../../engine/map/unit_movement.asm): the computer phase's walk.
- [include/AI.h](../../include/AI.h): the list entries and the script commands; the AI's RAM, its flags and modes are in [include/WRAM.h](../../include/WRAM.h); the scripts are in [events/](../../events/), after each chapter's faction groups.
- [docs/reference/ai.md](../reference/ai.md): the reference page.
