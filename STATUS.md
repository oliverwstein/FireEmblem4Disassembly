# Status

The current state of the project and what the next session should do. Read this first, then [PLAN.md](PLAN.md). **Rewrite this file at the end of every session.** Keep it short and about the present: past work goes in commit messages, and the older record is in [HISTORY.md](HISTORY.md).

The goal is source that is **readable and moddable** (shiftable, organized by game system, in the way pokecrystal is), **plus a written account of how the engine works** that a person can read without reading assembly (see "The engine guide" in PLAN.md).

## Current state (2026-11-22, after the map menu wave)

Numbers come from `python3 tools/counts.py`; quote nothing else.

- `./build.sh` is byte-identical and the checksums verify. 97.55% of the ROM is built from source. GAPS.md: 181 `none` pieces (60,487 bytes), 56 padding runs (42,139 bytes). Banks `$85` and `$87` have no gaps left.
- Routines: 6,003 in `engine/`, 3,472 named, 2,531 `Unknown`; 2,064 still in `engine/unsorted/` (banks `$81`, `$84`, `$88`, `$8B`, `$8C`, `$8D`, `$90`, `$91`, `$95`-`$97`, `$9B`, `$9E`, `$9F`). 307 pinned blocks.
- **Phase 3 Wave 2c (the map menus) done in one session**, commits `3165f4d`..`4dbff3f`. Banks `$85` and `$87` are out of `engine/unsorted/`; what each file holds is in [docs/reference/map_menu.md](docs/reference/map_menu.md) and HISTORY.md. New RAM names: the map menu block at `$000516`, `aUnitMenu...Slots` at `$7E2000` (scoped in `tools/name_ram.py`: the AI uses the area), the HP window requests at `$000DAF`; constants `UNIT_MENU_MODE_*` and `MAP_BATTLE_HP_REQUEST_*` in `include/Menus.h`.
- **Left from this wave:** 35 `Unknown` in `engine/menus/unit_window.asm` (the full-screen unit list, bank `$8B`/`$80`); the `ldy #$xxxx` sprite pointer check in the unit, item and skill windows (as bank `$89`'s were, `tools/sprite_arrays.py`); a dozen low-level helpers left `Unknown` on purpose (the gradient table builder, the map battle HUD palette helpers, the "RP" proc in `map_battle_magic.asm`). Bank `$84`'s `rlUnknown84F786` (builds the unit menu's slot lists) and the command handlers' targets in banks `$84`/`$88` belong to the map engine wave.
- Reference pages so far: `docs/reference/core.md`, `ai.md`, `castle.md`, `menus.md`, `map_menu.md`, `save.md`. `tools/reference.py` output is gitignored; run it locally. What each wave did is in HISTORY.md under "Phase 3 waves".
- Engine guide: [docs/guide/00-introduction.md](docs/guide/00-introduction.md).

## Who wrote what

Claude's commits carry a Co-Authored-By line. Gemini wrote `f56d5ee`..`ef5fff9` (unsigned, no commit bodies) and will return around 2026-11-29. Its mechanical work (carving, merging, checksums) passes the build. Its names were never checked by anything: the Wave 1 game-state names follow a template (`…Stub/Show/RunStep/Render`) and some don't match their code (`rlCastleScreenIdle` is a compare whose result is never used).

## Decisions the user has made

- **Phase 3 is done when everything in `engine/unsorted/` has been put in a proper place.** Low-level rendering, HDMA, OAM and spell *visual effect* helpers may stay `Unknown` if they are hard; they are low priority. Everything that implements game mechanics must be named and understood.
- **Sound is the lowest priority.** No SPC700 driver work unless the user asks.
- **Emulator time costs the user a lot**: the game is in Japanese, which the user doesn't read. Ask only for short, targeted checks (a breakpoint, one screen, one action), and collect them into one list rather than asking piecemeal. The existing .cdl covers the entire prologue chapter. **Before asking, try to answer the question from the code**; ask only what the code cannot settle (which path runs, what a value means on screen), and say in the list what the code already shows.
- **Phase 1 is closed statically.** Leftover `none` pieces that don't decode as code with evidence become labelled data with an "unreferenced" note, so `.binary "fe4.sfc"` can go without new recordings.

## Next session, in order

1. **Talk to the user before starting the next wave.** Next in the agreed order: **the map engine, bank `$88`** (cursor, camera, the action flow after a menu choice, map sprites; with bank `$84`'s map-side routines such as `rlUnknown84F786` and the unit command handlers' targets). Before it, a short clean-up could finish the menus: the 35 `Unknown` in `unit_window.asm` and the `ldy #$xxxx` sprite pointers. Then battle. The file and save menu screens in bank `$91` are not named yet; they could join the events wave.
2. **Run each wave by the checklist below.** Draft `docs/guide/OUTLINE.md` once the core systems have reference pages, and show it to the user.
3. Open questions are at the end of each reference page (`core.md`, `ai.md`, `castle.md`, `menus.md`, `map_menu.md`, `save.md`).
4. `tools/stream_catalog.py` deleted the catalog previews when run (reverted), so `gfx/compressed/CATALOG.md` still names pre-castle labels; find out why before rerunning it. New files from `move_sections.py` and `split_section.py` are included at the top of build.asm; move the lines to a sensible place by hand. Check that an `include/` file does not exist before creating one.
5. Bank `$89` cannot be pad-tested until it is merged: its last block has no free space after it. Banks `$85` and `$87` are all source now and could be merged (`tools/merge_bank.py`) and pad-tested.

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

## How to work on this project

- **The emulator log is tied to the original ROM.** `fe4.cdl` describes the original bytes at their original addresses. Renaming, relabelling and anything else that keeps the build identical leaves it valid: rerun `tools/cdl.py`, no new recording needed. Once the output changes (a mod, a shifted bank), record logs from the original ROM only.
- **The ROM decides.** A change is only correct if `./build.sh` still says the output matches. Where work-in-progress source disagrees with the ROM, the source is wrong.
- **Commit in small steps**, each with a matching build and a body giving the evidence and before/after numbers.
- **New code:** `tools/disasm.py`, `trace.py --write` or `sweep.py --write` into `wip/`, then `test_routines.py`, then `place_routines.py`. If `disasm.py --selftest` ever reports a difference after a change to the disassembler, fix the tool first.
- **Naming:** names come from what the code does, never from position or appearance; unknown stays `Unknown` with a note of what is known. `tools/rename.py` renames labels everywhere and can add a comment; `move_sections.py` moves sections between files. After naming RAM or adding constants, rerun `name_ram.py`, `apply_constants.py`, `name_struct_fields.py` and `stale_notes.py --fix`.
- **Check what automatic tools write.** They can take data for code or code for data at the edges of a block: look for proc headers (a 2-letter name such as "ON" decodes as `eor long`), pointer tables, and tables that end in `rts`.
- **64tass pitfalls** (more in `tools/README.md`): register widths follow source order; `,b` needs a 16-bit operand and does not subtract the data bank; a `.brept` list label used without `[0]` silently emits one instruction per entry; struct macros with `None` or missing arguments can emit nothing at all.
- **The user** did not write the original disassembly and wants to *understand* the engine, not only have it disassembled. Explain conventions instead of assuming familiarity, and leave things more readable than you found them.
