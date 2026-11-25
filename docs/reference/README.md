# The reference set

Documentation of every part of the engine, at every level, so that any piece can be understood by reading instead of investigating. It is not meant to be read front to back; the [guide](../guide/) is.

## What is here

| Level | Where | Written by |
|---|---|---|
| System | `docs/reference/<system>.md`: one page per system, its files, data, entry points, how control flows through it and what it depends on | hand |
| File | the comment at the top of each source file: what it is responsible for | hand |
| Routine | the comment under each routine's label: what it does, its inputs and outputs, side effects | hand |
| Data | the comments in `include/` (structs, `WRAM.h`, constants) | hand |
| Index | [routines/](routines/), [ram.md](ram.md), [constants.md](constants.md), [INDEX.md](INDEX.md): every named routine and table with its comment, callers and callees; every RAM name with its comment; every constant in `include/` with its group and comment | `tools/reference.py` |

The generated pages are not committed (they are in `.gitignore`): run `python3 tools/reference.py` to build them locally. `--check` reports whether they are out of date. A page under `routines/` covers one folder of `engine/`; `Unknown` routines are counted there but not listed.

## Systems written so far

- [core.md](core.md): an overview of the core (`engine/core/`) and its two loops, with links to:
  - [frame.md](frame.md): reset and boot, the main loop and VBlank, the DMA queue, the PPU register buffers, the joypads, the code checksums and the anti-tamper screens.
  - [game_states.md](game_states.md): the game state table, the opener/setup/upkeep/step pattern, changing screens, the per-frame engine table.
  - [procs.md](procs.md): the proc engine, its script commands and event procs.
  - [sprites.md](sprites.md): the sprite buffer, the map units' band quotas and flicker, the active sprite engine.
  - [scanlines.md](scanlines.md): the HDMA engine and the IRQ engine.
  - [graphics.md](graphics.md): the decompressor and its queue, brightness and palette fades, shared palettes, tilemap helpers.
  - [allocation.md](allocation.md): struct arrays, the RAM-area heap, offset tables, block copies, math, random numbers.
- [items.md](items.md): global item instances (`aItemRAMData`), ROM item templates, per-unit inventories, equip/range checks, pricing, broken weapons, and staff targeting/healing.
- [battle.md](battle.md): combat setup, stat calculation, skills, weapon traits, staff effects, scripted criticals, and round resolution.
- [units.md](units.md): unit pools, four-type ROM/RAM dispatch, classes, stats, skills, weapon ranks, Holy Blood, factions, turn-start effects, level-ups, lovers, generation transfer, and inheritance.
- [ai.md](ai.md): the enemy (and allied) AI.
- [castle.md](castle.md): the castle screen: courtyard, unit commands, town, shops, depot, augury, class change, conversation scenes, the lovers' home castle conversation.
- [menus.md](menus.md): the full-screen menus: the status screen, the revive screen, the options menu.
- [map_menu.md](map_menu.md): the menus and windows over the chapter map.
- [map.md](map.md): the chapter map: turns and phases (the map step), the cursor, moving units, the camera and tile streaming, map sprites, the minimap, the unit commands' effects.
- [epilogue.md](epilogue.md): the epilogue: its parts and steps, the credits, the play record, the ranking screen and its secret code, the character endings.
- [rankings.md](rankings.md): end-of-game playthrough grading (Tactics, Survival, Combat, Experience, and the final combined rank).
- [demo.md](demo.md): the attract mode's opening: its event script, the staff credits, the demo map scenes and their battles.
- [save.md](save.md): save slots in SRAM, saving and loading, what is written as it happens (losses, timer, ranking), and the save menu screen (title file menu, map save, the Jugdral history, the chapter intro).
- [title.md](title.md): the title screen (game states `$1A`/`$1B`): its intro, timelines, sprites, captions and the way to the file menu or back to the opening.
- [battle_scene.md](battle_scene.md): the battle scene with the animations on (game states `$18`/`$19`): its frame, the rounds and strikes, HP, the end steps (experience, level up, messages), the animation slots.
- [map_battle.md](map_battle.md): battles played on the map with the animations off, and the map actions and scripted scenes that use the same sprites.
- [worldmap.md](worldmap.md): the world map between chapters and in the epilogue (game states `$0D`-`$0F`): its steps, frame, edge IRQs and layer HDMA, and the leftovers.

The other systems get their page as Phase 3 names and sorts them (see [PLAN.md](../../PLAN.md)).
