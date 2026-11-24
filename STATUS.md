# Status

Current state and next steps for the **writing**: the engine guide (`docs/guide/`) and the reference pages (`docs/reference/`). Read this first. The code phase (naming, carving, shiftability) is recorded in [HISTORY.md](HISTORY.md), whose first section says where it stopped; the roadmap is [PLAN.md](PLAN.md); tool usage is in [tools/README.md](tools/README.md). **Rewrite this file at the end of every session.**

## Current state (2026-11-24)

The build is byte-identical and checksums verify. Code changes made while writing must keep it so, and are committed separately from prose.

**Engine guide** ([OUTLINE.md](docs/guide/OUTLINE.md): 31 chapters in 7 parts; [STYLE.md](docs/guide/STYLE.md)):

| Part | Chapter | State |
|---|---|---|
| — | [Introduction](docs/guide/00-introduction.md) | revised; its data model is now a preview of Part I |
| I | [Part I opener](docs/guide/part-1-the-pieces-on-the-board.md) | written |
| I | 1–5 (units, classes, items, armies, the board) | draft, reviewed |
| II | 6 [Resolving a battle](docs/guide/06-resolving-a-battle.md), 7 [Growing stronger](docs/guide/07-growing-stronger.md) | draft |
| III | 8 [The turn](docs/guide/08-the-turn.md) | draft, reviewed |
| III | 9 [Moving a unit](docs/guide/09-moving-a-unit.md) | draft, not yet reviewed |
| III | 10 [Menus over the map](docs/guide/10-menus-over-the-map.md) | draft, not yet reviewed |
| IV | 11 [The game is watching](docs/guide/11-the-game-is-watching.md) | draft, reviewed |
| IV–VII | 12–31 | not started; OUTLINE.md marks which have a reference page |

**Reference pages** (`docs/reference/`): core, ai, arena, battle_scene, castle, demo, dialogue, epilogue, events, items, map_battle, map_menu, map, menus, save, title, units, worldmap. Missing: **battle** (Chapters 6–7 were written from the source; the battle interlude needs it) and **rankings**. `tools/reference.py` output (routines/, INDEX.md, ram.md, constants.md) is generated and gitignored. It takes a routine's comment from the block right after its label, a RAM name's from its line and the comment lines indented under it, and a constant's from its line, the lines under it, and the comment block directly above its group.

## How chapters are written

- Start from the reference page, then check every claim the chapter makes against the code. Outlines and reviews have been wrong too: the outline promised "gates", and a review proposed a 24-sprite cap the code doesn't have.
- A complete code path is the answer; don't contradict it from memory of how the game plays. Raise an emulator question only when the code leaves the outcome open.
- Plain prose: no strawman contrasts with "most games", no "not X but Y" reframes, no closing flourishes. Open each chapter and section on the system (its elements, rules, and how the engine organizes them), not an in-game vignette; ground it in concrete rules and data after that, and end sections on a fact (STYLE.md). Check each chapter for these before handing it over.
- Fix wrong names, comments and doc claims found while writing (source changes byte-identical, separate commit), and log each in "Mistakes found in earlier work". Retail-ROM bugs go in their own table.

## Mistakes found in earlier work

Places where the earlier disassembly or documentation was wrong, found while writing. Fix each one when found (source changes byte-identical, in their own commit) and add a row here. Earlier wrong-name finds from the code phase are in HISTORY.md.

**In the source** (names, comments, declarations):

| What was wrong | Where | Fixed in |
|---|---|---|
| `aUnitJoinOrder` declared as 24 words; the code uses 24 bytes, and the other 24 bytes held three variables read by raw address (item window sort mode, unit window saved order and its flag); `save.asm` saved the sort mode as `aUnitJoinOrder[12]` | include/WRAM.h | `496621f` |
| `rlGetSelectedUnitTotal*Effect` (7 routines) return the capped base and the bonus, not a total or an effect | engine/units/stats.asm | `0a237e0` |
| `aDeploymentTable._DeploymentOffsets` holds each unit's row in the map sprite pool, not a deployment offset | include/WRAM.h and 59 uses | `ac1f7e4` |
| `wActionEndedDeploymentOffset` commented "faction/castle deployment helper"; it is the unit whose action just ended, for event action 3 | include/WRAM.h | `b3937a8` |
| Raw `$2000` for the Select button; comment said dead units were "seen in the emulator" without saying why the code finds them | engine/menus/status_screen.asm | `f16dd1b` |
| Round flags `$02` and `$10` called unknown; `$10` is `BattleRoundFlagFatal`, and `$02` is set by staff effects and Dance | include/Battle.h | `126e33b` |
| The turn start healing list was written through raw `$7E2000`-`$7E2008` and two fields of `aDebugMenuSkillFlags` (`bWrath`, `bAdept`); now `aTurnStartHealingList` | include/WRAM.h, turn_start.asm, map_step.asm | `2da731d` |
| `wMapStateFlags` `$0020` called an "AI/busy action lock"; it is the phase-over bit set by End Turn and the AI | include/WRAM.h | `2da731d` |
| `range_maps.asm` header, `rlBuildSelectedUnitRangeMaps` and `aRangeMap`'s comment said `aRangeMap` holds what the picked-up unit can reach; for a pick-up it is the fill's input (units and the map's edge), and attack tiles are `$80` in `aMovementMap` | engine/map/range_maps.asm, include/WRAM.h | `389d791` |
| `rlCheckAdjacentTilesEmptyInRangeMap` reads `aMovementMap`; renamed `rlCheckSelectedUnitCannotMove`. `aUnknown87BAD1` is `aMaxRangeDiamondRows` | engine/map/range_maps.asm, unit_movement.asm | `389d791` |
| `wMapActionMode` compared with `PATH_LEFT` where it meant mode 4, its values undocumented; now `MAP_ACTION_MODE_*` | engine/map/unit_movement.asm and five other files, include/Map.h | `2e80d68` |
| `wMapStateFlags` bits 3 and 4 called "unit/action map menu open" and "secondary sub-menu"; they are unit menu modes 1 and 2 | include/WRAM.h | `2e80d68` |
| `rlUnitMenuGuard`, `Dismount`, `Mount` and `ReturnSkill` said to be unreached; each is in its option table | engine/menus/unit_menu.asm | `2e80d68` |
| AI actions 6 and 7 had swapped names: 6 (`rsAIActionGuardCastle`) guards, 7 (`rsAIActionEnterGuardedCastle`) leaves the guarding spot and goes inside | engine/ai/threat.asm | `2e80d68` |
| `rsGetMapCursorMove` said Y only skips the repeat delay; it also skips the range-edge stop (map.md and Ch. 9 draft copied it) | engine/map/map_cursor.asm | `5fb4143` |
| `rsUnitMenuCheckEnter` comment gave the enemy relation as 2 (it is 1, `AllegianceEnemy`); several checks called the mode-1 bit "after acting"; seize, dismount and items had no word on who qualifies (raw `$0006`/`$002C`, `$0008`, `$0400`) | engine/menus/unit_menu.asm, unit_menu_slots.asm | `f624192` |
| `bEventActionIdentifier` documented as ten guesses ("$18 = ?", "$20 = start player phase?"); `bEventStatus` bits marked "?"; `wEventEngineFlags` `$0008` described only as cleared; now every announced action with its arguments and announcer | include/WRAM.h | `c59719b` |
| `EC_73` ("something to do with battle animations") starts the combat animation: now `START_COMBAT_ANIMATION`. Opcode `$2F`'s handler is the state-break scan every failed state check uses: now `rsEventFindStateCheckBreak`. Condition comments said nobody knew who announces `$05`/`$07` (nothing does), called `CHECK_VILLAGE_DESTROYED` unused without saying `rlUnitRaidVillage` announces `$02`, and had `CHECK_TURN_PHASE_AI_ACTOR` doing "a cycle with AI and CharacterID ignored" (phase start announces 0 and 0) | include/events/Conditions.h, engine/events/event_engine.asm, engine/dialogue/death_quotes.asm | `c59719b` |
| Eight condition commands said a character of -1 targets `EventUnitSlot1` (the script's unit slot); they act on `wEventUnit1Pointer`, the unit the matching condition recorded | include/events/Conditions.h | `4aa5583` |
| `wChapterFlags` `$0100` called unknown; it marks a chapter resumed from a map save (enter at map step 7) | include/WRAM.h | `2da731d` |
| `rsMoveCursorToPhaseStart` comment had the auto cursor option backwards (on goes to the first unit, off to the saved tile); Ch. 8 draft copied it | engine/map/map_step.asm | `2da731d` |
| `rlPhaseBannerCheckSkip` comment listed Select; the mask `$D0C0` is A, B, X, Y and Start; Ch. 8 draft copied it | engine/map/phase_banner.asm | `2da731d` |

**In the documentation** (reference pages, guide drafts):

| What was wrong | Where | Fixed in |
|---|---|---|
| Love data said to belong only to generation 1 women; generation 2 daughters have it too | introduction, Part I opener | `9da974d` |
| Inventories said to have 7 slots; there are 8, the eighth holding a new item until one is given up | introduction | `9da974d` |
| Stale name `rsFillChildExtendedPersonalData`; Thief staff's 0 durability omitted | units.md, items.md | `9da974d` |
| Map units and the cursor said to be active sprites; they are drawn directly by `rlDrawDeployedUnitMapSprites` | introduction | `d829d5c` |
| About 160 procs (175), about 1,700 dialogue texts (1,987), low work RAM "visible in every bank" (only `$00`-`$3F` and `$80`-`$BF`) | introduction, OUTLINE.md | `d829d5c` |
| A soldier "under forty bytes" (65 with its inventory and block headers) | introduction | `fba2948` |
| Locations listed as "castles, villages, and gates"; chapters have no gates. "All 256 individual items" (140 are used); "every mutable piece" of a chapter in one RAM block | Part I opener, OUTLINE.md | `8760225` |
| The phase-flag table said to hold an army's phases back; it gates only the banner and music, and the army's events and AI still run | map.md, wip/the-turn-draft.md | `f111508` |
| Only units that can't move were said to open the command menu at once; a unit that can wield a range-10 weapon (ballistae, Meteor, Bolting, Blizzard, Fenrir) gets a fixed range map and can't move either. Closed areas and road costs were missing | map.md | with Ch. 9 |
| `wMapActionMode` 1 called an ordinary move (0 is; 1 is a sortie); AI actions 6 and 7 listed in the wrong order | map.md, ai.md | `5fe5568` |
| Seize gated on "class 6 or `$2C`" and dismount on "the skill bits" without naming them; mode 1 and 2 contents left as an open question | map_menu.md | with Ch. 10 |
| Ch. 11 draft (review): child/substitute mapping reversed (the table maps each child to its substitute); state-check opcode range included `EC_JUMP` and the counter mutators; `CHECK_TURN_PHASE_AI_ACTOR` given four signed bytes (three); Iucharba and Creidne called siblings; Chapter 1's list counted without the expanded `macroSetFactions*` (141, not 136); event-unit recording and the songless pre-combat dialogue omitted | docs/guide/11 | with review |
| Old turn draft: defeats said to be handled while an event runs; every handler checks for a running event | wip/the-turn-draft.md | superseded by Ch. 8 |

## Retail bugs and quirks found

Retail-ROM behavior, left as it is in the source and documented. Fix nothing here; the build must stay identical.

| What | Where | Effect | Written up in |
|---|---|---|---|
| Adjacent love points go to the wrong woman | `rsAddAdjacentLovePoints` (factions.asm) | After checking a neighboring woman it doesn't point the selected unit back, so a man found later in the scan gives his +5 to her | units.md; Ch. 1 (mention); Ch. 17 to come |
| Weapon rank stops early | `rlGetSelectedUnitWeaponRank` (unit_info.asm) | A Minor blood that brings a rank to A returns before a Major blood of the same weapon later in the table is seen: A instead of ★ | Ch. 2, units.md |
| Unit count check never fails | `rlDeployUnit` (deployment.asm) | `cpx #$058B` compares the count with its own address; the free-row search is the real limit | Ch. 5, source comment |
| Empty-slot guard never fires | `rlUnloadFactionSlot` (factions.asm) | Compares the slot's name ID with `$0080`, but an empty slot returns `$FFFF` | units.md |
| Missing range branch | `rsSetFactionSlotsHostilityEnemies` (factions.asm) | `cmp #7` with no branch after it; callers always pass a valid slot | Ch. 4, units.md |
| Count decremented when unit not found | `rlRemoveSelectedUnitFromFactionSlot` (factions.asm) | `UnitCount` drops even if the unit wasn't in the slot | units.md |
| 16-bit write into `LocationID` | `rlLoadFactionGroup` (factions.asm) | Writes before checking `$FFFF`, spilling into `HostileFactions` | units.md |
| Lover init loops once too often | `rsInitUnitLoverData` (unit_creation.asm) | 16 iterations over 15 male entries | units.md |
| Wrong register | `rsDebugGetItemSkills` (skills.asm) | `tya` instead of `txa` before `rlCheckIfWeaponEquipped` | units.md |
| Byte fields written as words | skills.asm, classes.asm, inheritance.asm, join_order.asm | One byte past `aDebugMenuSkillFlags`; `$7E2002`; child luck; `aUnitJoinOrder` entries | units.md |
| Buffer save/load asymmetric | `rlSave*ToBuffer` / `rlLoad*FromBuffer` (unit_data.asm) | Three fields are loaded back but never saved | units.md |
| Globals clobbered | `rlCountFactionFieldedLivingUnits` (factions.asm) | Leaves `wSelectedUnitDataRAMPointer` and `wRoutineVariable1` changed | units.md |
| Self-recursive routine | `rlGetWeaponEffectivenessTextUnused` (items.asm) | Calls itself instead of `rlGetItemEffectiveness`; unreached | items.md |
| Animation command crashes | `rsBattleAnimationCmdBroken` (combatants.asm) | No `rep #$20`, so `adc #$0002` assembles short and the CPU hits `brk`; sequence byte `$F8` unusable | source comment, BattleAnimation.h |
| Branch to the wrong unit | `rlStartScriptedMapBattleAnimation` (cutscenes.asm) | With no usable weapon for the second unit, branches back to the first unit's code; unreached | source comment |
| Adept can loop forever | `rsActionStructGetNumberOfStrikes` (battle.asm) | With Adept, `AttackSpeed + 20 < 0` takes `bmi -` back to the Astra check, which falls through to the same test; probably unreachable (needs weight over speed + 20) | not yet |
| Empty-slot test never matches | `rsMapStepNextFaction` (map_step.asm) | Skips a slot whose name ID is `$80`; no group uses `$80` and an empty slot reads `$FFFF`, so every loaded slot runs steps 1-8 | Ch. 8, map.md |
| Status counted down twice | `rsMapStepStartTurn` and `rsGetTurnStartCuredEffect` / `rsGetTurnStartFreelancerEffect` | Cured and Freelancer units count down at the turn's start and again at their army's phase; a countdown that ends at the turn's start clears the status without its reward (full HP, 3,000 gold) | Ch. 8 |
| Stale movement map | `rlUndoUnitMove` (unit_movement.asm), mode 3 | B after the castle screen's guard command tests whether the unit can move with an `aMovementMap` nobody rebuilt; the castle screen cleared it and keeps its item lists there, so it is 0 (back inside) unless a list of 93+ items left a byte of 1-`$7F` next to the center, which puts the unit on the gate instead | Ch. 9 |

Quirks that aren't bugs, recorded so they aren't rediscovered:

- Battle experience comes from the last connecting hit: each hit overwrites `GainedExperience` instead of adding to it; non-lethal arena hits earn none (Ch. 6, 7).
- Promotion level is read from the target class; Myrmidon, Archer, Pegasus Rider and Dragonrider store `PromotionLevel = 1`, which nothing reads (Ch. 7).
- Tyrfing starts broken: `rlInitiateItemRAMData` sets `PI_Tyrfing`'s durability to 0, and Byron hands it over that way (Ch. 3).
- Only 140 of the item table's 256 slots are ever used; nothing creates item records after a new game (`rlAppendItemsFromList` has no callers) (Ch. 3).
- Promotion never raises a player unit's max HP: HP has no class term (Ch. 2).
- Castle income is (allied castles − 2) × 1,000 per living unit, counted against the player whatever army is paid (Ch. 4).
- Location bit `$40` is set on a seize and never read; `rlCheckLocationState40` has no callers (Ch. 5).
- `aInventoryRAMArea` has 73 slots (declared 72 + 1); nothing in the code explains the extra one (Ch. 1).
- Location types 1 and 3–6 exist in the type table, but no chapter uses them (Ch. 5).
- The unit menu's もちもの (items) never appears: it needs an item whose staff effect has a target, and every non-staff item has `StaffEffect None`; the use/discard menu behind it is unreachable (Ch. 10).
- Only Seliph can dismount: `UnitSkill1Dismount` is set only by `rsOverwriteSeliphUnitData` at the generation change, and only `KnightLord` has `ClassSkillDismount` (Ch. 10).
- Only Sigurd and Seliph can seize: the check compares the class with `KnightLord` and `JuniorLord` (Ch. 10).
- An action condition's flag is set before its body runs, so a once-only condition whose `EVENT` can't start (another script running) never matches again; `EVENT`'s own flag stays clear on failure and retries (Ch. 11).
- The chapter event pool has room for three chapters and the flag lookups take a chapter number, but only the current chapter's entry can be read; other chapters' flags read as clear (Ch. 11).
- No condition list uses a flag byte with bit 7 ("must be set, cleared on match"), opcodes `$22`-`$24`, or any `CHILD` condition other than `CHECK_CHILD_TALK` (Ch. 11).

## Next session

1. **Review Chapters 9 and 10.** Chapter 10's unit-menu rules come from the 24 checks; mode 1's contents at the home gate (enter, guard, equip, animation) were settled from the code, so that emulator question is closed.
2. Before the battle interlude and Part II revision: write `docs/reference/battle.md`.
3. Then Chapter 12 (scripts), from `events.md` and `event_scripts.asm`; Chapter 11 links ahead to it in three places.

## Who wrote what

Claude's commits carry a `Co-Authored-By: Claude ...` line; Gemini's are listed in HISTORY.md ("Who wrote what (to 2026-11-24)"). Since then all commits are Claude's.

## Emulator questions (for one batched session)

Each is one screen. Answers to earlier ones are in HISTORY.md under the wave that asked them. Ask only what the code can't settle: a complete code path is an answer.

1. (When a save reaches chapter 6.) Augury with a generation 2 child: are there three topics (love, record, parents)? The code reads the topic count from `$7F8183`; only the screen shows which topics a child gets.
2. Does まち (town) ever appear? The code offers it at a location of type 1 and its handler opens the castle screen, but no chapter's location data uses type 1 (59 castles, 73 villages; Chapter 5 of the guide). If it never shows up in play, the question is closed: the command is unreachable.
3. The item window (from the map menu's item command) with a weapon selected: what is the sprite at the right edge, about (195, 76)? The code draws it only for weapons (`aUnknown89BE50`, tile `$0E`); the weapon type icon and the weapon triangle icons beside it are known.
4. (Needs a save that has finished the game.) The ranking screen: what are the 16 letters drawn from `aUnknown7FC70A`, and what row appears after the secret code (Select, Up, A, Down, B, Left, X, Right, Y, L, R, Start)? The code shows the code check (`rlCheckEpilogueSecretCode`) and where the row is uploaded; only the screen shows what it says.
5. The title screen's intro (let the game sit after the attract opening, about two minutes): what each of its eight scenes shows and what the captions say. The code shows the scenes' timing and setup (title.md); the captions are graphics, so only the screen shows their words.
6. A battle scene with Fortify or a dance (both combatants at the center, `BattleSceneFlagSolo2`): what does the screen show besides the two combatants? The code shows that the flag turns on HDMA entries 3 and 6; only the screen shows what they draw.
