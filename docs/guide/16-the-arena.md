# Chapter 16: The arena

The arena is a town facility where a unit fights a ladder of seven opponents for money. Each unit has an **arena level** from 0 to 7, the number of arena fights it has won, kept in three bits of its unit states. Each chapter has two **opponent lists**, one for a unit fighting with a melee weapon and one for a bow, each indexed by arena level. The **arena menu** is a keeper screen on the castle screen ([Chapter 15](15-castles-and-towns.md)). A **fight** is an ordinary battle scene run with battle type 1, which changes a handful of rules in the battle engine: the rounds are built one exchange at a time until someone falls or the player yields, a fallen player unit keeps 1 HP instead of dying, and a win pays a prize and raises the arena level.

This chapter covers the ladder and how an opponent is chosen, the menu, a fight from its setup to its last exchange, the three outcomes, and the costs.

## The ladder

### Arena level

The arena level is the low three bits of a unit's states (`UnitStateArenaLevelMask`, read by `rlGetSelectedUnitArenaLevel`). It starts at 0 for every unit, rises by one with each win, and stops at 7. A unit at level 7 is turned away at the door with a line saying no opponents are left. The level belongs to the unit, so each unit climbs its own ladder, and it is saved with the rest of the unit's states ([Chapter 18](OUTLINE.md)). The unit window can sort by it.

The level picks an opponent from the current chapter's lists. A unit at level 3 in Chapter 1 meets Chapter 1's fourth opponent; the same unit, still at level 3 in Chapter 4, meets Chapter 4's.

### Opponent lists

A chapter's event data has a pointer to its arena table (`structChapterEventData.ArenaOpponentsPointer`): two pointers, then two lists of character IDs ended by `$FFFF` (`aChapterNNArenaOpponents` in [events/](../../events/)). Chapter 1's:

| Level | For a melee weapon | For a bow |
|---|---|---|
| 0 | Gazack, Fighter, level 1 | Gazack |
| 1 | Crotor, Mage, level 4 | Crotor |
| 2 | Wiseman, Lance Knight, level 7 | Wiseman |
| 3 | Shark, Myrmidon, level 10 | Hood, Hunter, level 10 |
| 4 | Bacchus, Axe Armor, level 13 | Bacchus |
| 5 | Emir, Wind Mage, level 16 | Emir |
| 6 | Dice, General, level 19 | Dice |

The opponents are characters in the character table like any enemy, with a class, a level, and two or three items. Every opponent on a bow list carries something that reaches two tiles: a hand axe, a javelin, a magic sword, a tome, or a bow. Chapter 2 starts at level 5 and ends at 23, Chapter 4 runs from 13 to 30, and the Final Chapter's ladder is made of second copies of earlier chapters' top opponents (Dice, Keimos, Xenon, Thornton, Canaan, Atlas), with Zeus, an Emperor at level 30, at the top. The Prologue and Chapter 6 have no table, and no castle in either has the arena's facility bit.

### Choosing the opponent

The list is chosen by the minimum range of the weapon the unit has picked for the fight: 1 for the melee list, 2 or more for the bow list. A javelin or a tome, which reach 1 to 2, uses the melee list.

```rust
fn arena_opponent(unit: &Unit) -> Option<CharacterId> {     // rlGetArenaOpponentCharacterID
    let level = unit.arena_level();
    if level >= 7 { return None; }
    let table = chapter_arena_table();                       // rlGetChapterArenaOpponentsPointer
    let list = if selected_weapon().min_range >= 2 { table.ranged } else { table.melee };
    let id = list[level];
    if unit_exists(id) {                                     // rlGetUnitRAMDataPointerByID
        return Some(list[level + 1]);
    }
    Some(id)
}
```

The skip at the end lets a list hold a character who may join the army. Chapter 2's melee list has eight entries: Chulainn at level 6, and after him Keimos, a Hero at level 23. Until Chulainn joins, he is the seventh opponent; beating him there sets a chapter flag, and the next town any unit enters in five of the chapter's castles starts his recruitment ([Chapter 15](15-castles-and-towns.md)). Once he is in the army, a unit with that ID exists, and the lookup takes the next entry instead.

The lookup ignores the opponent of a fight in progress. That unit is built at a fixed header address, `$2100`, that is in no army's list, so `rlGetUnitRAMDataPointerByID` doesn't find it.

## The menu

The town's arena button saves the unit (`wCastleSavedUnitRAMPointer`), clears `wArenaFightsWithOpponent`, and moves to castle step `$03`. `rlArenaScreenSetup` starts the arena's song, loads the arena's graphics, the keeper's portrait, and the unit's money, and builds the weapon list with `rlBuildEquippableWeaponList`: every weapon the unit can equip, the equipped one first ([Chapter 15](15-castles-and-towns.md)). Step `$04` then runs `rlArenaMenuRunStep` every frame, which dispatches on `wMenuState` through `aArenaMenuStepHandlers`:

| Step | Does |
|---|---|
| 0 | at level 7, "no opponents left" and out; otherwise the greeting |
| 1 | wait for the keeper's line, then go to the step it named |
| 2 | after a fight: read the result |
| 3 | after a yield: ask what next |
| 4 | fight or quit |
| 5, 6 | announce the prize, then count the money up |
| 7 | after a win: fight the next opponent? |
| 8 | after a yield: leave, continue, or change weapon |
| 9, 10 | show the opponent; start, quit, or change weapon |
| 11 | fade out and start the fight |
| 12, 13 | the weapon list |
| 14, 15 | leave for the town |

A first visit runs 0, 4, 12, 13, 9, 10, 11: greet, choose to fight, pick a weapon (choosing one equips it), see the opponent's window, and start. A unit with no weapon it can equip is told so and stays at step 4. The opponent's window (`rsDrawArenaOpponent`) shows the opponent's name, class, and level, the weapon it will fight with (the first of its first two items that reaches the fight's distance), a ring if it carries one, and a reminder that B leaves the fight.

## A fight

### Setup

Step 11 fades out, records the unit's money in `wArenaMoneyCounter`, counts the fight in `wArenaFightsWithOpponent`, and calls `rlStartArenaBattle`:

```rust
fn start_arena_battle(unit: &Unit) {                        // rlStartArenaBattle
    if wChapterFlags & 0x0010 == 0 {                        // no fight in progress
        let Some(id) = arena_opponent(unit) else { return };
        create_unit(id, 0x2100);                            // rlCreateUnit
    }
    setup_arena_battle_stats(unit, 0x2100);                 // rlSetupArenaBattleStats
    wBattleType = 1;
    build_battle_rounds();                                  // rlActionStructBuildBattleRounds
    wBattleSong = 0x3B;
    start_battle_scene();                                   // rlStartBattleScene
}
```

`rlCreateUnit` fills a full unit record at `$2100` from the character's data, as for any unit loaded by an event, but adds it to no army. The stats setup (`rlSetupArenaBattleStats`) is a shorter form of the map's forecast ([Chapter 6](06-resolving-a-battle.md)): it fills both action structs, sets the battle distance to the minimum range of the player's weapon, gives the opponent the first of its weapons that can strike at that distance (or its first weapon, if none can), then applies the weapon triangle, the final adjustments, the triggerable skills, and effectiveness. Both units stand on terrain `$17`, a type no map uses, and there is no aura scan.

Battle type 1 always plays the full battle scene, whatever the unit's animation setting.

### One exchange at a time

The round builder treats the arena differently in three places ([Chapter 6](06-resolving-a-battle.md)):

- **Who strikes first** is decided every exchange by attack speed: the faster side, or the player on a tie (`rsActionStructGetBattleInitiatorIfArena`).
- **Setup runs once per fight.** The builder skips the triggerable skills, Vantage, and the dance and silence checks when bit `$0010` of `wChapterFlags` is already set, and in the arena that bit stays set from the first exchange until the fight ends.
- **An exchange ends the list.** After the two strikes and any pursuit strike, the builder appends `$FEFF` instead of testing Accost, and returns. Only a fatal strike ends the list with `$FFFF` and clears the bit.

The battle scene plays the rounds it was given. When it reads `$FEFF`, it asks for another exchange unless the player has pressed B (`rlBattleSceneReadArenaRetreat` sets `BattleSceneRoundArenaRetreat` and plays a sound). The request starts a short break between exchanges, and the battle scene's main loop, which runs outside the frame like the map's ([Chapter 14](14-armies-with-a-mind.md)), builds the next exchange's rounds into the same buffer (`rlBattleSceneBuildArenaBout`). When the build is done, the scene points its round reader back at the start of the buffer and plays on:

```
battle scene (in the frame)              main loop (outside it)
──────────────────────────────           ───────────────────────────────
play exchange 1 ... read $FEFF
  B not pressed: request a bout  ──────► build exchange 2's rounds
  break between exchanges                   (rlActionStructBuildBattleRounds)
  ◄──────────────────────────────────────── done
restart the round reader
play exchange 2 ... read $FEFF
  B pressed: no request
end of the scene → castle screen, arena step 2
```

The round builder writes each strike's damage into the unit records as it builds the rounds, so the exchanges add up. The fight lasts until a fatal strike or until the player retreats; nothing caps the number of exchanges.

### Rules the arena changes

Other parts of the battle engine test the battle type too:

| Rule | On the map | In the arena |
|---|---|---|
| Fatal strike | a defender an event keeps on the map, or Julius in the Final Chapter, survives | always fatal (`BattleRoundFlagFatal`) |
| Player unit at 0 HP | dies, says its death quote, counts as a loss | keeps 1 HP and is marked defeated (`rlActionStructHandleArenaDefeat`) |
| A kill | counts toward the unit's wins and the weapon's kills | pays the prize and raises the arena level instead |
| Experience | the last connecting hit sets it | only a fatal strike sets it |
| Steal | takes the defender's money | never |
| A weapon that breaks | its side swings no more | keeps swinging for the rest of the fight |
| The unit's action | ends after the battle | doesn't end |

The broken-weapon row follows from how weapon slots are checked. A strike that breaks a weapon sets bit 15 of the action struct's weapon slot, and outside the arena `rsCheckForWeaponInventorySlot` refuses a negative slot. In the arena it refuses only an empty one, and the action struct still holds the weapon's might from the setup.

Because the unit's action doesn't end, a unit can fight in the arena and still sortie or guard afterwards. The arena's wins and losses also stay out of the record the augury reads.

## Outcomes

The battle scene returns to the castle screen through `CASTLE_SCREEN_ARENA`, which reloads the arena at step 2. `rlGetArenaBattleResult` reads the result from two places:

| Result | Test |
|---|---|
| 1, lost | the unit's deployment row is marked defeated |
| 0, won | the unit's action struct has a prize (`ObtainedArenaMoney`) |
| 2, yielded | neither |

### Winning

The fatal strike pays the prize on the spot. `rlActionStructArenaWinResults` adds the prize for the unit's level to its money and raises its level by one:

| Arena level | 0 | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|---|---|
| Prize | 1,000 | 1,500 | 2,000 | 2,500 | 3,000 | 3,500 | 4,000 |

The prize is 1,000 plus 500 per level, and a unit that wins all seven fights earns 17,500. There is no entry fee. Money is capped at 50,000, and a prize that would pass the cap is cut to fit.

Back in the menu, step 2 calls `rlHandleArenaExitEvent`, which ends the fight on the castle's side. It clears bit `$0010` of `wChapterFlags`, frees the opponent's record at `$2100`, clears the unit's Miracle state, heals the unit to its maximum HP, and announces event action `$1C` with the unit's character, the castle, and the opponent's character ([Chapter 11](11-the-game-is-watching.md)). The keeper announces the prize while the money on screen counts up from the old amount, 100 a frame. Below level 7 the keeper offers the next opponent; at level 7 the champion's line plays and the unit leaves.

Only Chapter 2 listens for action `$1C`, with one condition: `CHECK_WON_IN_ARENA` for any character beating Chulainn.

### Losing

A unit that falls is left with 1 HP and its deployment row marked defeated. Step 2 calls `rlHandleArenaExitEvent`, which frees the opponent and clears the defeat, and the keeper's line names the unit before it is sent back to the town. The unit keeps its arena level and its 1 HP.

### Yielding

After a yield, nothing is settled. The opponent's record stays at `$2100`, bit `$0010` stays set, both units keep the HP the fight left them, and `wArenaFightsWithOpponent` is nonzero. Step 8 offers three choices:

- **Leave** returns to the town. Step 14 sees a yield with a fight counted and calls `rlHandleArenaExitEvent`, which frees the opponent and pays nothing.
- **Continue** goes back to step 11. `rlStartArenaBattle` finds the bit set, skips building an opponent, and fights the same wounded one, starting from a fresh stats setup.
- **Change weapon** reopens the weapon list and returns to step 8.

A weapon changed after a yield changes the next fight's distance, which is the new weapon's minimum range, but not the opponent, which is already built. The opponent's window, which looks the opponent up again, shows whoever the new weapon's list names at that level. In Chapter 1 at level 3, a unit that yields to Shark and switches to a bow sees Hood in the window and fights Shark at two tiles, where Shark's sword can't reach.

## Trade-offs and limits

The arena is built on the battle engine. A fight is an ordinary pair of action structs and an ordinary round buffer; the arena's rules are a few tests of the battle type in the round builder, the strike code, and the death handler, plus the `$FEFF` marker that lets the battle scene ask for more. Building each exchange in the battle scene's main loop keeps the scene drawing while the next one is computed. The cost is state that has to be cleaned up by hand: the opponent's record, the in-progress bit, and the fight counter all stay live across a yield, and every way out of the arena has to call `rlHandleArenaExitEvent` to release them.

The opponent is built from the character table, so a chapter's ladder is plain data: change the IDs in the chapter's lists to change who fights. The lookup's one rule, skipping an opponent who already exists, lets a recruitable character sit on a ladder.

The limits:

- **Seven wins per unit**, three bits; level 7 ends the unit's arena career, across all chapters.
- **Two lists per chapter**, chosen only by the weapon's minimum range.
- **One opponent at a time**, at the fixed address `$2100`.
- **Prizes from 1,000 to 4,000**, under the 50,000 money cap.
- **No exchange limit**: a fight between two units that can't hurt each other lasts until the player presses B.

## Where it lives in the source

- [engine/arena/arena.asm](../../engine/arena/arena.asm): the arena screen, the 16 menu steps, the opponent lookup and window, `rlStartArenaBattle`, `rlGetArenaBattleResult`, and the win and loss counts the augury reads.
- [engine/castle/unit_commands.asm](../../engine/castle/unit_commands.asm): `rlSetupArenaBattleStats` and `rlPopulateArenaActionStruct`.
- [engine/battle/battle.asm](../../engine/battle/battle.asm): the arena's initiator, the `$FEFF` exchange marker, the fatal strike and prize, and the weapon slot check.
- [engine/battle_scene/scene.asm](../../engine/battle_scene/scene.asm): retreating with B, the break between exchanges, building the next exchange, and the return to the castle; [engine/battle_scene/rounds.asm](../../engine/battle_scene/rounds.asm): reading `$FEFF`.
- [engine/units/unit_state.asm](../../engine/units/unit_state.asm): `rlActionStructArenaWinResults`, `aArenaMoneyRewards`, and `rlActionStructHandleArenaDefeat`; [engine/events/event_engine.asm](../../engine/events/event_engine.asm): `rlHandleArenaExitEvent`.
- [events/](../../events/): each chapter's `aChapterNNArenaOpponents`; the arena RAM and the battle type are in [include/WRAM.h](../../include/WRAM.h).
- [docs/reference/arena.md](../reference/arena.md): the reference page.
