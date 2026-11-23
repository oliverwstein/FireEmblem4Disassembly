# Status

The current state of the project and what the next session should do. Read this first, then [PLAN.md](PLAN.md). **Rewrite this file at the end of every session.** Keep it short and about the present: past work goes in commit messages, and the older record is in [HISTORY.md](HISTORY.md).

The goal is source that is **readable and moddable** (shiftable, organized by game system, in the way pokecrystal is), **plus a written account of how the engine works** that a person can read without reading assembly (see "The engine guide" in PLAN.md).

## Current state (2026-11-22, after wave 4 part 1: banks $81, $90, $8D)

Numbers come from `python3 tools/counts.py`; quote nothing else.

- `./build.sh` is byte-identical and the checksums verify. 97.57% of the ROM is built from source. GAPS.md: 174 `none` pieces (59,734 bytes), 56 padding runs (42,139 bytes).
- Routines: 6,015 in `engine/`, 4,016 named, 1,999 `Unknown`; 1,610 still in `engine/unsorted/` (banks `$84`, `$8B`, `$8C`, `$91`, `$95`-`$97`, `$9B`, `$9E`, `$9F`). 305 pinned blocks.
- **Wave 4 part 1 done in one session**, commits `10e99bd`..`7247c33`: bank `$81` (the map step, `engine/map/map_step.asm`), bank `$90` (the attract mode's opening, `engine/demo/opening.asm`, its event script decoded by the new `tools/event_script.py`, plus the staff credits that closed three unbuilt pieces), bank `$8D` (the epilogue, `engine/epilogue/`). What each file holds is in `docs/reference/map.md` ("Turns and phases"), `demo.md` and `epilogue.md`, and HISTORY.md. New `include/Epilogue.h`; `MAP_STEP_*` and `UNIT_RELOCATION_*` in `include/Map.h`; macros `DEMO_ALLOW_SKIP` and `OPEN_MAP_BATTLE` in `include/events/Main.h`.
- **Left from wave 4:** bank `$91` (save menu screens, event engine helpers, and bank `$8D` text data at `$8D/9B65`-`9ED4` that sits in `bank91.asm`) and bank `$9E` (the scripted `"ON"` scene procs, 274 routines). Bank `$84` still has routines of other systems in `engine/unsorted/bank84.asm` (class change, repair, arena, love points, castle targets).
- Reference pages so far: `docs/reference/core.md`, `ai.md`, `castle.md`, `demo.md`, `epilogue.md`, `menus.md`, `map_menu.md`, `map.md`, `save.md`. `tools/reference.py` output is gitignored; run it locally.
- Engine guide: [docs/guide/00-introduction.md](docs/guide/00-introduction.md).

## Who wrote what

Claude's commits carry a Co-Authored-By line. Gemini wrote `f56d5ee`..`ef5fff9` (unsigned, no commit bodies) and will return around 2026-11-29. Its mechanical work (carving, merging, checksums) passes the build. Its names were never checked by anything: the Wave 1 game-state names follow a template (`…Stub/Show/RunStep/Render`) and some don't match their code (`rlCastleScreenIdle` is a compare whose result is never used).

## Decisions the user has made

- **Phase 3 is done when everything in `engine/unsorted/` has been put in a proper place.** Low-level rendering, HDMA, OAM and spell *visual effect* helpers may stay `Unknown` if they are hard; they are low priority. Everything that implements game mechanics must be named and understood.
- **Sound is the lowest priority.** No SPC700 driver work unless the user asks.
- **Emulator time costs the user a lot**: the game is in Japanese, which the user doesn't read. Ask only for short, targeted checks (a breakpoint, one screen, one action), and collect them into one list rather than asking piecemeal. The existing .cdl covers the entire prologue chapter. **Before asking, try to answer the question from the code**; ask only what the code cannot settle (which path runs, what a value means on screen), and say in the list what the code already shows.
- **Phase 1 is closed statically.** Leftover `none` pieces that don't decode as code with evidence become labelled data with an "unreferenced" note, so `.binary "fe4.sfc"` can go without new recordings.

## Next session, in order

1. **Talk to the user before starting the next wave.** Wave 4 has two parts left: bank `$91` (the save menu screens and event engine helpers; 137 routines) and bank `$9E` (the scripted scenes; 274 routines, a session of its own). Propose which first; then battle (wave 5).
2. **Run each wave by the checklist below.** Draft `docs/guide/OUTLINE.md` once the core systems have reference pages (core, map, menus, castle and AI have them now), and show it to the user.
3. Open questions are at the end of each reference page (`core.md`, `ai.md`, `castle.md`, `demo.md`, `epilogue.md`, `menus.md`, `map_menu.md`, `map.md`, `save.md`). `tools/songs.py` stops at a stale label (`aUnknown8A9D79`); fix it before regenerating `audio/SONGS.md`. To decode more event scripts, use `tools/event_script.py` and prove each by building.
4. `tools/stream_catalog.py` deleted the catalog previews when run (reverted), so `gfx/compressed/CATALOG.md` still names pre-castle labels; find out why before rerunning it. New files from `move_sections.py` and `split_section.py` are included at the top of build.asm; move the lines to a sensible place by hand. Check that an `include/` file does not exist before creating one. `tools/rename.py` refuses a new name that appears anywhere, comments included: rename forward references in comments first.
5. Bank `$89` cannot be pad-tested until it is merged: its last block has no free space after it. Banks `$85`, `$87` and now `$88` are all source and could be merged (`tools/merge_bank.py`) and pad-tested.

**Per-wave checklist.** One system (or one part of a big one) per session; hand over and clear context after each.

1. **Start:** read STATUS.md, PLAN.md, the system's existing reference page if any; report the plan to the user before changing anything.
2. **Name** each routine from its code and callers (trace table indices, check every "unused" claim with a grep). Unknown stays `Unknown` with a note of what is known. No question marks committed.
3. **Move** the routines out of `engine/unsorted/` into the system's folder (`move_sections.py`), with a header comment on each file.
4. **Data:** name the RAM, constants and struct fields the system owns; rerun `name_ram.py`, `apply_constants.py`, `name_struct_fields.py`, `stale_notes.py --fix`.
5. **Write** `docs/reference/<system>.md` in plain words (files, data, entry points, control flow, dependencies, open questions); fix the guide if anything it says changed.
6. **Verify:** `./build.sh` matches after every step; run `tools/reference.py` and read the system's generated page for names that look wrong.
7. **Commit** in small steps, each with an evidence body and before/after numbers from `tools/counts.py`.
8. **End:** add emulator questions to the list in STATUS.md (asked in one batch, later); rewrite STATUS.md; report to the user.

**Subagents.** Sonnet subagents may do work that needs little context and carries little risk of a wrong conclusion: mechanical moves and merges, running tools and collecting their output, applying constants, blank-line and formatting cleanups, broad read-only searches ("every reader of `$7F4400`"), and first drafts of data tables whose meaning is already known. Naming game-mechanics routines, deciding what code does, and writing the reference pages stay in the main session. Check what a subagent did (the build, the diff) before committing it.

## Emulator questions (for one batched session)

Each is one screen. Answers so far are in HISTORY.md under the wave that asked them.

1. (When a save reaches chapter 6.) Augury with a generation 2 child: are there three topics (love, record, parents)? The code reads the topic count from `$7F8183`; only the screen shows which topics a child gets.
2. The unit command menu's mode 1: move a player unit onto its own home castle and choose たいき (wait). Does the command menu open again by itself, and which commands does it list? The code shows mode 1 follows a player unit ending its action at its home castle, hides attack, staff, items, dance, talk and give, and that B cannot close it; only the screen shows what the menu is for.
3. Where does まち (town) appear? The code shows it at a location of type 1 and that its handler opens the castle screen; one screenshot of a unit standing where it is offered settles what a type 1 location is.
4. The item window (from the map menu's item command) with a weapon selected: what is the sprite at the right edge, about (195, 76)? The code draws it only for weapons (`aUnknown89BE50`, tile `$0E`); the weapon type icon and the weapon triangle icons beside it are known.
5. (Needs a save that has finished the game.) The ranking screen: what are the 16 letters drawn from `aUnknown7FC70A`, and what row appears after the secret code (Select, Up, A, Down, B, Left, X, Right, Y, L, R, Start)? The code shows the code check (`rlCheckEpilogueSecretCode`) and where the row is uploaded; only the screen shows what it says.

## How to work on this project

- **The emulator log is tied to the original ROM.** `fe4.cdl` describes the original bytes at their original addresses. Renaming, relabelling and anything else that keeps the build identical leaves it valid: rerun `tools/cdl.py`, no new recording needed. Once the output changes (a mod, a shifted bank), record logs from the original ROM only.
- **The ROM decides.** A change is only correct if `./build.sh` still says the output matches. Where work-in-progress source disagrees with the ROM, the source is wrong.
- **Commit in small steps**, each with a matching build and a body giving the evidence and before/after numbers.
- **New code:** `tools/disasm.py`, `trace.py --write` or `sweep.py --write` into `wip/`, then `test_routines.py`, then `place_routines.py`. If `disasm.py --selftest` ever reports a difference after a change to the disassembler, fix the tool first.
- **Naming:** names come from what the code does, never from position or appearance; unknown stays `Unknown` with a note of what is known. `tools/rename.py` renames labels everywhere and can add a comment; `move_sections.py` moves sections between files. After naming RAM or adding constants, rerun `name_ram.py`, `apply_constants.py`, `name_struct_fields.py` and `stale_notes.py --fix`.
- **Check what automatic tools write.** They can take data for code or code for data at the edges of a block: look for proc headers (a 2-letter name such as "ON" decodes as `eor long`), pointer tables, and tables that end in `rts`.
- **64tass pitfalls** (more in `tools/README.md`): register widths follow source order; `,b` needs a 16-bit operand and does not subtract the data bank; a `.brept` list label used without `[0]` silently emits one instruction per entry; struct macros with `None` or missing arguments can emit nothing at all.
- **The user** did not write the original disassembly and wants to *understand* the engine, not only have it disassembled. Explain conventions instead of assuming familiarity, and leave things more readable than you found them.
