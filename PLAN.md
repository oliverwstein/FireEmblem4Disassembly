# Plan to Finish the FE4 Disassembly

This document records the roadmap from the current baseline (2026-11-21) to a 100% source-built, fully shiftable, well-named, and documented disassembly of *Fire Emblem: Genealogy of the Holy War* (JP 1.0). The current state is in [STATUS.md](STATUS.md), the past in [HISTORY.md](HISTORY.md), the unbuilt bytes in [GAPS.md](GAPS.md).

**Milestone beyond the disassembly: the engine guide** (`docs/`, section below), a readable account of how the game's systems work and fit together. Its reference set is built alongside Phase 3; the guide itself, a designed narrative in the style of Nystrom's *Game Programming Patterns*, is written on top of it.

## Current Baseline (2026-11-22, from `tools/counts.py`)

Quote numbers only from `tools/counts.py` (and GAPS.md from `tools/gaps.py`); rerun them rather than editing figures by hand.

- **Coverage:** **97.53% built from source** (4,090,898 of 4,194,304 bytes), byte-identical to `fe4.sfc`.
- **Gaps remaining ([GAPS.md](GAPS.md)):** every class except `none` is closed: `none` **211 pieces (61,267 bytes)**, plus **56 padding runs (42,139 bytes)**.
- **Routines:** **5,959** top-level `rl`/`rs` routines in `engine/`: **2,927** named, **3,032** `Unknown`; **2,610** still in `engine/unsorted/` (138,995 lines).
- **Pinned blocks** in `build.asm`: **307**.

Phase 2 is ordered ahead of Phase 3 because shiftability is what makes the disassembly genuinely moddable, its checklist is bounded and objectively testable (`./build.sh pad`), and resolving raw pointers/inline-`.byte` code exposes full call graphs before system-wide naming. Phases 3–5 can overlap with Phases 1–2 bank by bank.

---

## Remaining Phase 1: Close the Final 2.75% (97.25% → 100% Built from Source)

Everything reachable via static pointers or the existing Prologue CDL is now built. Removing `.binary "fe4.sfc"` from [build.asm](build.asm) requires covering the unlogged `none` islands:

*Decision (2026-11-22): close this statically. The user plays in Japanese, so emulator sessions are expensive; ask only for short targeted checks, batched into one list.*

0. **Close the `none` pieces without new recordings.** Run `sweep.py` over each piece; disassemble what decodes as code with evidence; write the rest as labelled data (`aUnknownXXXXXX`) noted "unreferenced". Then do item 2 below. This reaches 100% honestly.
1. **(Optional, later) Expand CDL Coverage in Mesen 2**
   - Record one comprehensive emulator session into [fe4.cdl](fe4.cdl) covering areas missing from the Prologue log:
     - Full combat with animations on (physical, bow, magic, staff, special crits, arena, level-ups)
     - Castle & map facilities (shops, repair, pawn, augury, storage, castle menus, unit promotion)
     - Chapter transitions, World Map, Generation 1 → 2 transfer, Epilogue/Rankings, Save/Load, Attract Mode, and Debug Menu
   - Run [tools/cdl.py](tools/cdl.py) and `tools/trace.py --from-log` to disassemble any unreached code across the remaining `none` pieces and uncover callers for the **132** built routines still marked `"Found through fe4.cdl"`.
2. **Audit Remaining Dead Code / Data & Padding Runs**
   - Review any remaining `none` pieces not hit by the expanded CDL (dead code or unused data islands between routines).
   - Convert all padding runs to explicit `.fill` directives and delete the `.binary "fe4.sfc"` overlay and empty [include/Undisassembled.h](include/Undisassembled.h) from [build.asm](build.asm).

---

## Phase 2: Full Shiftability (Moddability)

Once a bank is 100% source with zero raw references into it, unpin its blocks and verify relocation with `./build.sh pad`. *(Status 2026-11-21: all non-Mesen Phase 2 work below is complete; only interactive Mesen smoke-testing of padded ROMs and final post-Phase-1 merges of partial banks remain.)*

1. **Eliminate Remaining Raw Pointers & Inline-Byte Code — DONE (2026-11-21)**
   - *Correction (2026-11-22):* the tools below only find code-pointer stores and six-digit numbers. Bank `$89` also had sprite arrays passed as `ldy #$xxxx`, sprite arrays inside word tables, long pointers written as bytes, and 44 main-loop addresses written as numbers engine-wide; those are fixed. 80 `ldy #$xxxx` immediates elsewhere still need checking (`tools/sprite_arrays.py`).
   - Resolved all **33 raw code-pointer stores** (`30` `aProcSystem.aHeaderOnCycle`, `3` `aActiveSpriteSystem.aOnCycle`) -> `0` left in `tools/code_pointers.py`.
   - Resolved all **9 raw 6-digit numbers** -> `0` left in `tools/raw_addresses.py`, fixed `Event000Pointer` (`$8FEF55` -> `aEventDebug8FEF78`), and labelled/converted all **36 unlabelled ROM two-halves long pointers** (`0` unlabelled left).
   - Disassembled all inline-`.byte` code blocks & `label+N` targets (leaving only the 2 intentional `bank87.asm` anti-tamper reads `rlUnknown8887EC._8880+8,x`).
2. **Automate Integrity & Checksum Handling — DONE (2026-11-21)**
   - Documented the second integrity check (`$88/8888`–`8907` copied and tested by `rlWriteResetSignature` / `rlCheckResetSignature`, including `rlReset` copier hook scan) and bulk code reads (`$88/8888`–`8AC7`, `$82/8888`–`890D`) in [include/Checksums.h](include/Checksums.h).
   - Created [tools/checksums.py](tools/checksums.py) (`--verify` and `--update [--disable-checks]`) and wired verification into [build.sh](build.sh) alongside `./build.sh mod [--disable-checks]` and `--fix-checksums`/`--disable-checks` forwarding in `./build.sh pad` / [tools/pad_test.py](tools/pad_test.py).
3. **Merge & Pad-Test All 64 Banks in Waves — DONE for current source / Mesen pending**
   - **Merged single-block or lower/upper split banks:** `$83`, `$84`, `$86`, `$8E`, `$8F`, `$92`–`$94`, `$98` (split at `$D8`/`$98`), `$9C`, `$9D` (`$DD` lower half), `$E0` (`$A0`), and the `$AD`–`$B7` data banks.
   - Updated [tools/merge_bank.py](tools/merge_bank.py) to preserve `.logical` bank splits (`$Dx`/`$9x`) and merged partial banks across `$80`–`$AF` (`2,308` -> `308` pinned blocks in `build.asm`; redundant pins after closing 5 small gaps in `$88`, `$96`, `$9F` removed too). Final merging of remaining multi-block partial banks will run once their Phase 1 `none` gaps close.
   - Verified all **21 `.fill`-ending blocks** pass `pad_test.py` (`Unsorted91E915Section` with `--fix-checksums`, mid-block `.fill` splits at `$80FFB0`/`$81C000`/`$E00F30`, and 25 confirmed chance false positives recorded in `NOT_POINTERS`). *Remaining:* interactive Mesen smoke-testing of padded ROMs (e.g. `./build.sh pad GenerationTransferSection 4`).
4. **Audit Hardcoded Offsets, Sizes & Stack Return Tricks — DONE (2026-11-21)**
   - Replaced raw `pea` return addresses in [engine/unsorted/bank80.asm](engine/unsorted/bank80.asm) and [engine/unsorted/bank84.asm](engine/unsorted/bank84.asm) with label expressions (`#<>(+)-1`, `#<>_8C27 - 1`), and replaced hardcoded sizes and checksum bounds with `size(...)` / `<>label` expressions (`aDialogueBoxTilemap`, `structLoverDataRAM`, `g4bppCursorSprites`, `g4bppMapTiles`, `aUnknownD95000`, and `rlReset`/`rlUnknown808E2D`/`rlWriteResetSignature`/`rlInitMapMenus` in [engine/core/random.asm](engine/core/random.asm), [engine/unsorted/bank80.asm](engine/unsorted/bank80.asm), [engine/unsorted/bank87.asm](engine/unsorted/bank87.asm)).

---

## Phase 3: Readability — Naming, Sorting, RAM & Constants

**Done means `engine/unsorted/` is empty** (user decision, 2026-11-22). **Reached 2026-11-23 (wave 6):** `engine/unsorted/` is gone. What is left is the second pass: the `Unknown` routines inside the systems (by value; see STATUS.md), the RAM and constants below. Every routine that implements game mechanics is named from its code. Low-level rendering, HDMA, OAM and spell *visual effect* helpers may stay `Unknown`, filed in the right system folder with a one-line comment. Each wave also completes the reference set for its system (routine, struct, file and system docs; see the engine guide below) and commits with an evidence body.

**Per-wave checklist** (also in STATUS.md). One system (or one part of a big one) per session; hand over and clear context after each.

1. **Start:** read STATUS.md, PLAN.md, the system's existing reference page if any; report the plan to the user before changing anything.
2. **Name** each routine from its code and callers (trace table indices, check every "unused" claim with a grep). Unknown stays `Unknown` with a note of what is known. No question marks committed.
3. **Move** routines that sit in the wrong file into the system's folder (`move_sections.py`), with a header comment on each file.
4. **Data:** name the RAM, constants and struct fields the system owns; rerun `name_ram.py`, `apply_constants.py`, `name_struct_fields.py`, `stale_notes.py --fix`.
5. **Write** `docs/reference/<system>.md` in plain words (files, data, entry points, control flow, dependencies, open questions); fix the guide if anything it says changed.
6. **Verify:** `./build.sh` matches after every step; run `tools/reference.py` and read the system's generated page for names that look wrong.
7. **Commit** in small steps, each with an evidence body and before/after numbers from `tools/counts.py`.
8. **End:** add emulator questions to the list in STATUS.md (asked in one batch, later); rewrite STATUS.md; report to the user.

**Subagents.** Sonnet subagents may do work that needs little context and carries little risk of a wrong conclusion: mechanical moves and merges, running tools and collecting their output, applying constants, blank-line and formatting cleanups, broad read-only searches ("every reader of `$7F4400`"), and first drafts of data tables whose meaning is already known. Naming game-mechanics routines, deciding what code does, and writing the reference pages stay in the main session. Check what a subagent did (the build, the diff) before committing it.

Work hub-outward through the `Unknown` and unsorted routines (counts from `tools/counts.py`) in `engine/unsorted/` (can run in parallel with Phases 1–2):

1. **System-by-System Routine Naming & Sorting**
   1. **Main Loop & Game States (`$80/9B01` `aGameStateRoutines`):** Name all 52 game state entries/steps/cleanups and `GAMESTATE_*` constants to map out call trees across banks `$80`, `$85`, `$89`, `$8A`, `$8B`, `$8D`, `$91`, `$95`, `$96`, and `$9B`.
   2. **Menus, Windows & Facilities**, in three parts: (a) **the castle, bank `$8A` — DONE** (`engine/castle/`, [docs/reference/castle.md](docs/reference/castle.md)); (b) the full-screen menus in bank `$89` (status screen, revive screen, options) and the rest of `engine/save/` — DONE ([docs/reference/menus.md](docs/reference/menus.md), [save.md](docs/reference/save.md)); (c) the map menu in banks `$85`/`$87` — DONE in one session ([docs/reference/map_menu.md](docs/reference/map_menu.md)); its leftovers (the unit window's sort routines, the `ldy #$xxxx` sprite pointers) were done with wave 3. File into `engine/menus/` and `engine/save/`. The world map in `$8B` belongs to wave 4.
   3. **Map Engine (Bank `$88`) — DONE in one session** ([docs/reference/map.md](docs/reference/map.md)): bank `$88` is out of `engine/unsorted/`, with bank `$84`'s map actions and unit menu slot lists. Left in bank `$84`: class change, repair, arena, love points and other routines of other systems (see STATUS.md).
   4. **Events, Attract Mode, Epilogue & Scripted Scenes (Banks `$81`, `$82`, `$8D`, `$90`, `$91`, `$9E`):** part 1 **DONE** in one session: banks `$81` (the map step, [docs/reference/map.md](docs/reference/map.md)), `$90` (the attract mode's opening, [demo.md](docs/reference/demo.md)) and `$8D` (the epilogue, [epilogue.md](docs/reference/epilogue.md)); bank `$82` had nothing left in `engine/unsorted/`. Part 2 **DONE** in one session: bank `$91` (the save menu screen, the Jugdral history, the chapter intro, the event engine's hooks; [save.md](docs/reference/save.md)) and bank `$9E`, which turned out to be the map battle and the procs that share its sprites ([map_battle.md](docs/reference/map_battle.md)); its sprite internals stay `Unknown`. The world map in `$8B` (25 routines) is still in `engine/unsorted/`.
   5. **Battle Engine, Map Battles & Battle Scene (Banks `$84`, `$95`, `$96`, `$97`, `$9B`, `$9F`):** part 1 **DONE**: bank `$9F`, the map battle's magic effects ([map_battle.md](docs/reference/map_battle.md), "Magic effects"), and bank `$97`'s demo battle loader. Part 2 **DONE**: bank `$9B` and the end of `$95` are the title screen, game states `$1A`/`$1B` ([title.md](docs/reference/title.md), `engine/title/`). Left: the battle scene, one wave: game states `$18`/`$19` (`rlBattleSceneSetup`/`Step`, `$95/E5C9`) as the outline, then `$95`, `$96` and the rest of `$97`. Finish the remaining unnamed routines in `battle/`, `units/`, and `items/` (`rlRunMapAction`, was `rlUnknown84DC1C`, is named; it stays in `battle.asm`), the 6 battle scene control commands (`$FFF8`–`$FFFD`), the 72 effect routines at `$97/BDD4`, and the map-battle / spell animation engine in `$9B` and `$9F`.
   - Use [tools/fe5_match.py](tools/fe5_match.py) (including operand-aligned RAM matching) and cross-reference Project Naga / Lil' Nordion notes where helpful. Goal: **empty `engine/unsorted/` completely**.
2. **RAM Variables ([include/WRAM.h](include/WRAM.h))**
   - Iterate with `tools/name_ram.py --report 50`: name top global state/flag words (`$0788`, `$0D87`, `$08AD`, `$04EA`), map/camera working variables (`$0778`–`$07E6`), and screen-scoped buffers (`$7F45xx`, `$7F4Cxx`, `$7F8xxx` via `SCOPED` rules).
3. **Constants & Struct Fields**
   - Expand [tools/constant_rules.txt](tools/constant_rules.txt) and struct definitions as getters/fields are named, then re-run [tools/apply_constants.py](tools/apply_constants.py) and [tools/name_struct_fields.py](tools/name_struct_fields.py).

---

## Phase 4: Editable Assets & Data Formats

Convert remaining raw binary/compressed chunks into editable formats that round-trip cleanly through [build.sh](build.sh):

1. **UI Tilemaps & Coloured UI PNGs:** Read palette bits from the extracted DMA tilemaps ([gfx/ui/README.md](gfx/ui/README.md)) and colour the greyscale UI sheets in `gfx/ui/`.
2. **Unidentified Compressed Streams ([gfx/compressed/CATALOG.md](gfx/compressed/CATALOG.md)):** As their loaders are named in Phase 3, rename each `gcUnknownADDR` via [tools/name_streams.py](tools/name_streams.py) and unpack tile sheets to `.4bpp.png`/`.2bpp.png` and tilemaps to `.bin` via [tools/unpack_streams.py](tools/unpack_streams.py).
3. **Chapter Maps & Map-Battle Layouts:** Decode the chapter map layout/tile-config format (`aChapterMapPointers` in [engine/map/chapter_maps.asm](engine/map/chapter_maps.asm)) and the 120 `aMapBattleCLASSLayoutN.comp` files into editable formats with preview renderers (similar to [tools/backgrounds.py](tools/backgrounds.py)).
4. **Audio & SPC700 Driver (lowest priority; only on request):** Disassemble the 5 SPC700 driver blocks in `audio/driver/` into build-time SPC700 source (documenting sequence commands `$C0`–`$FF` and instrument fields), identify the 118 `other` sound chunks, and finish naming `SONG_*` constants from [audio/SONGS.md](audio/SONGS.md).

---

## The engine guide — runs alongside Phase 3

Two different things, and the second depends on the first.

### 1. The reference set (nested, built bottom-up)

Documentation of every component, at every level, so that any piece can be understood by reading rather than investigating:

- **Routine:** a comment on what it does, its inputs and outputs (registers, RAM), side effects, and who calls it and why.
- **Data structure:** every struct, table and RAM block in `include/` described field by field: meaning, units, range, who writes it, who reads it.
- **File:** a header saying what the file is responsible for, its main entry points, the data it owns, and how it fits into its system.
- **System:** `docs/reference/SYSTEM.md`, an overview of one system (its files, its data, its entry points, how control flows through it, what it depends on), linking down to the files.
- **Generated index** (`docs/reference/`, by a tool): every named routine with its comment, callers and callees; every struct and RAM name. Regenerated, so it never goes stale.

Each Phase 3 wave completes the reference for its system. This is the "documenting components" part: thorough, systematic, not meant to be read front to back.

### 2. The guide (the aggregate, written top-down)

A book that explains how FE4 works *as a whole*: how the systems interlock and behave, and why they were built the way they were in 1996. **Style and level: Robert Nystrom's *Game Programming Patterns*.**
- Each chapter starts from a problem the developers faced ("60 frames a second, 128 KB of RAM, no operating system: how do forty things animate at once?"). The solution follows, then its trade-offs, then where it lives in the source.
- The voice is conversational and concrete. Ideas are explained at the level of design and data flow, not instruction by instruction.
- Code appears as short Rust-like pseudocode translated from the real routines, using their real names and linking to the source. Readers never need to read 65816.
- Chapters are short sections with cross-links ("see also"), and draw out the patterns the game uses (game loop, state machine, update method, bytecode interpreters for events and battle scripts, data-driven tables, object pools).

**The order is a design task, not the system list.** The narrative should build understanding step by step: each chapter should make the next one possible, and the connections between systems (a chapter on combat needs the unit record, the map and the proc system) decide the order. Draft a table of contents as `docs/guide/OUTLINE.md` once the reference covers the core systems. Revise it as understanding grows, and show it to the user before writing chapters to it.

Topics it must cover (not an order): the machine and the source's conventions; the program's shape (boot, frame, game states, procs, active sprites, HDMA); memory and the data model; a chapter's life (loading, deployment, turns and phases, castles and seizing); the map (terrain, movement, range, fog); combat (targeting, rounds, hit/crit/damage, triangle, skills, experience, durability); units across a playthrough (growth, promotion, love, inheritance, the generation change); the AI; events and dialogue; castles, shops, money, the arena; presentation (battle scene, animations, menus, graphics, compression); sound, briefly; modding recipes. Walkthroughs that follow one action across systems ("one attack, cursor press to HP loss") belong in the guide too.

**Order of work:** the reference grows with each Phase 3 wave. An early, short guide chapter on the machine and the program's shape can be written now (it depends only on Wave 1 systems) to give the user something to read. The rest of the guide is written once its systems' reference exists, from the outline.

## Phase 5: Final Polish

1. **Finish the engine guide**: reading order, cross-links, the remaining walkthroughs and recipes.
2. **Build & Repo Polish:** Update [README.md](README.md), test/update the Windows `.bat` build scripts, and add a full shiftability test target to [build.sh](build.sh).
