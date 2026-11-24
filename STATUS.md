# Status

Current state and next steps for the **writing**: the engine guide (`docs/guide/`) and the reference pages (`docs/reference/`). Read this first. The code phase (naming, carving, shiftability) is recorded in [HISTORY.md](HISTORY.md), whose first section says where it stopped; the roadmap is [PLAN.md](PLAN.md); tool usage is in [tools/README.md](tools/README.md). **Rewrite this file at the end of every session.**

## Current state (2026-11-24)

The build is byte-identical and checksums verify. Code changes made while writing must keep it so, and are committed separately from prose.

**Engine guide** ([OUTLINE.md](docs/guide/OUTLINE.md): 31 chapters in 7 parts; [STYLE.md](docs/guide/STYLE.md)):

| Part | Chapter | State |
|---|---|---|
| — | [Introduction](docs/guide/00-introduction.md) | revised; its data model is now a preview of Part I |
| I | [Part I opener](docs/guide/part-1-the-pieces-on-the-board.md) | written |
| I | 1 [A unit is made of parts](docs/guide/01-a-unit-is-made-of-parts.md) | draft, reviewed |
| I | 2 [Classes, stats, skills, and weapon ranks](docs/guide/02-classes-stats-skills-and-weapon-ranks.md) | draft, reviewed |
| I | 3 [Every sword is an individual](docs/guide/03-every-sword-is-an-individual.md) | draft, reviewed |
| I | 4 [Armies and allegiance](docs/guide/04-armies-and-allegiance.md) | draft, reviewed |
| I | 5 [Who stands where](docs/guide/05-who-stands-where.md) | draft, reviewed |
| II | 6 The turn | old draft in `wip/the-turn-draft.md`, written before the style rules: rewrite, don't patch |
| II–VII | 7–31 | not started; OUTLINE.md marks which have a reference page |

**Reference pages** (`docs/reference/`): core, ai, arena, battle_scene, castle, demo, dialogue, epilogue, events, items, map_battle, map_menu, map, menus, save, title, units, worldmap. Missing: **battle** (needed before Part III) and **rankings**. `tools/reference.py` output (routines/, INDEX.md, ram.md) is generated and gitignored.

## How chapters are written

- Start from the reference page, then check every claim the chapter makes against the code. Outlines and reviews have been wrong too: the outline promised "gates", and a review proposed a 24-sprite cap the code doesn't have.
- A complete code path is the answer; don't contradict it from memory of how the game plays. Raise an emulator question only when the code leaves the outcome open.
- Plain prose: no strawman contrasts with "most games", no "not X but Y" reframes, no closing flourishes. Open on a game moment, say what the system is and what it enables, end sections on a fact. Check each chapter for these before handing it over.
- Fix wrong names and comments found while writing (byte-identical, separate commit), and log bugs below.

## Bugs and quirks found

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

Quirks that aren't bugs, recorded so they aren't rediscovered:

- Tyrfing starts broken: `rlInitiateItemRAMData` sets `PI_Tyrfing`'s durability to 0, and Byron hands it over that way (Ch. 3).
- Only 140 of the item table's 256 slots are ever used; nothing creates item records after a new game (`rlAppendItemsFromList` has no callers) (Ch. 3).
- Promotion never raises a player unit's max HP: HP has no class term (Ch. 2).
- Castle income is (allied castles − 2) × 1,000 per living unit, counted against the player whatever army is paid (Ch. 4).
- Location bit `$40` is set on a seize and never read; `rlCheckLocationState40` has no callers (Ch. 5).
- `aInventoryRAMArea` has 73 slots (declared 72 + 1); nothing in the code explains the extra one (Ch. 1).
- Location types 1 and 3–6 exist in the type table, but no chapter uses them (Ch. 5).

## Cleanups made while writing

All byte-identical. `aUnitJoinOrder` split into the four variables its 48 bytes covered (`496621f`); `rlGetSelectedUnitTotal*Effect` renamed `rlGetSelectedUnit*BaseAndBonus` (`0a237e0`); `JOY_Select` in the status screen's unit cycling (`f16dd1b`); `aDeploymentTable._DeploymentOffsets` renamed `_MapSpriteSlot` (`ac1f7e4`); comments on `rlDeployUnit` and `wActionEndedDeploymentOffset` (`ac1f7e4`, `b3937a8`).

## Next session

1. **Chapter 6, The turn**, from `map.md` (the map step, its thirteen steps, the chain of queued consequences). Rewrite from scratch; the `wip/` draft is only a source of facts to recheck. Chapter 5's "Arriving on a tile" already shows one link in the chain (`rsRunActionEndedEvents`); Chapter 6 should cover the whole chain.
2. Then Chapters 7–8 (moving a unit, menus over the map), which complete Part II.
3. Before Part III: write `docs/reference/battle.md`.

## Who wrote what

Claude's commits carry a `Co-Authored-By: Claude ...` line; Gemini's are listed in HISTORY.md ("Who wrote what (to 2026-11-24)"). Since then all commits are Claude's.

## Emulator questions (for one batched session)

Each is one screen. Answers to earlier ones are in HISTORY.md under the wave that asked them. Ask only what the code can't settle: a complete code path is an answer.

1. (When a save reaches chapter 6.) Augury with a generation 2 child: are there three topics (love, record, parents)? The code reads the topic count from `$7F8183`; only the screen shows which topics a child gets.
2. The unit command menu's mode 1: move a player unit onto its own home castle and choose たいき (wait). Does the command menu open again by itself, and which commands does it list? The code shows mode 1 follows a player unit ending its action at its home castle, hides attack, staff, items, dance, talk and give, and that B cannot close it; only the screen shows what the menu is for.
3. Does まち (town) ever appear? The code offers it at a location of type 1 and its handler opens the castle screen, but no chapter's location data uses type 1 (59 castles, 73 villages; Chapter 5 of the guide). If it never shows up in play, the question is closed: the command is unreachable.
4. The item window (from the map menu's item command) with a weapon selected: what is the sprite at the right edge, about (195, 76)? The code draws it only for weapons (`aUnknown89BE50`, tile `$0E`); the weapon type icon and the weapon triangle icons beside it are known.
5. (Needs a save that has finished the game.) The ranking screen: what are the 16 letters drawn from `aUnknown7FC70A`, and what row appears after the secret code (Select, Up, A, Down, B, Left, X, Right, Y, L, R, Start)? The code shows the code check (`rlCheckEpilogueSecretCode`) and where the row is uploaded; only the screen shows what it says.
6. The title screen's intro (let the game sit after the attract opening, about two minutes): what each of its eight scenes shows and what the captions say. The code shows the scenes' timing and setup (title.md); the captions are graphics, so only the screen shows their words.
7. A battle scene with Fortify or a dance (both combatants at the center, `BattleSceneFlagSolo2`): what does the screen show besides the two combatants? The code shows that the flag turns on HDMA entries 3 and 6; only the screen shows what they draw.
