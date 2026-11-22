# Status

The current state of the project and what the next session should do. Read this first, then [PLAN.md](PLAN.md). **Rewrite this file at the end of every session.** Keep it short and about the present: past work goes in commit messages, and the older record is in [HISTORY.md](HISTORY.md).

The goal is source that is **readable and moddable** (shiftable, organized by game system, in the way pokecrystal is), **plus a written account of how the engine works** that a person can read without reading assembly (see "The engine guide" in PLAN.md).

## Current state (2026-11-22, after the castle wave)

Numbers come from `python3 tools/counts.py`; quote nothing else.

- `./build.sh` is byte-identical and the checksums verify. 97.53% of the ROM is built from source. GAPS.md: 216 `none` pieces (61,565 bytes), 56 padding runs (42,139 bytes).
- Routines: 5,958 in `engine/`, 2,771 named, 3,187 `Unknown`; 2,736 still in `engine/unsorted/`. 307 pinned blocks.
- **Phase 3 Wave 2a (castle) done**, commits `a26ee55`..`50648da`. Bank `$8A` is empty and gone; the castle lives in `engine/castle/` (10 files), with its rules from banks `$84`/`$87` and the old `menus/castle_menu.asm`. Constants in `include/Castle.h`, RAM block at `$7F757A` (scoped in `tools/name_ram.py`), reference page [docs/reference/castle.md](docs/reference/castle.md). Fixed on the way: `rlBuildDeadPlayerCharacterList` was the castle's unit list (now `rlBuildCastleUnitList`); the "unit menu" names were the town screen; the しゅび command is guard, not equip.
- Wave 1 (core, AI) reference pages: `docs/reference/core.md`, `ai.md`. `tools/reference.py` output is gitignored; run it locally.
- Engine guide: [docs/guide/00-introduction.md](docs/guide/00-introduction.md).

## Who wrote what

Claude's commits carry a Co-Authored-By line. Gemini wrote `f56d5ee`..`ef5fff9` (unsigned, no commit bodies) and will return around 2026-11-29. Its mechanical work (carving, merging, checksums) passes the build. Its names were never checked by anything: the Wave 1 game-state names follow a template (`…Stub/Show/RunStep/Render`) and some don't match their code (`rlCastleScreenIdle` is a compare whose result is never used).

## Decisions the user has made

- **Phase 3 is done when everything in `engine/unsorted/` has been put in a proper place.** Low-level rendering, HDMA, OAM and spell *visual effect* helpers may stay `Unknown` if they are hard; they are low priority. Everything that implements game mechanics must be named and understood.
- **Sound is the lowest priority.** No SPC700 driver work unless the user asks.
- **Emulator time costs the user a lot**: the game is in Japanese, which the user doesn't read. Ask only for short, targeted checks (a breakpoint, one screen, one action), and collect them into one list rather than asking piecemeal. The existing .cdl covers the entire prologue chapter.
- **Phase 1 is closed statically.** Leftover `none` pieces that don't decode as code with evidence become labelled data with an "unreferenced" note, so `.binary "fe4.sfc"` can go without new recordings.

## Next session, in order

1. **Talk to the user before starting the next wave.** The menu split agreed: castle (done), then **the full-screen menus in bank `$89`** (status screen, revive screen, options menu, plus the 18 `Unknown` in `engine/save/save.asm`), then **the map menu in banks `$85`/`$87`** (about 375 routines, likely two sessions). Then the map engine (two sessions) and battle (three).
2. **Run each wave by the checklist below.** Draft `docs/guide/OUTLINE.md` once the core systems have reference pages, and show it to the user.
3. Open questions are at the end of each reference page (`core.md`, `ai.md`, `castle.md`).
4. `tools/stream_catalog.py` deleted the catalog previews when run this session (reverted), so `gfx/compressed/CATALOG.md` still names pre-castle labels; find out why before rerunning it. New files from `move_sections.py` are included at the top of build.asm in reverse order; move the lines to a sensible place by hand.

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

From the castle wave; each is one screen in a castle's town or courtyard. (Answered: a sold item does appear in that castle's secondhand buy list.)

1. Augury with a generation 1 unit: are there two topics (love, record)? With a generation 2 child: three (love, record, parents)? Confirms that `$7F8183` is the last topic index.
2. In chapter 6, is the class change command grey in the courtyard?
3. Item shop, second option (もちもの): does the keeper say the "look at my goods" line (Shop36)?

## How to work on this project

- **The emulator log is tied to the original ROM.** `fe4.cdl` describes the original bytes at their original addresses. Renaming, relabelling and anything else that keeps the build identical leaves it valid: rerun `tools/cdl.py`, no new recording needed. Once the output changes (a mod, a shifted bank), record logs from the original ROM only.
- **The ROM decides.** A change is only correct if `./build.sh` still says the output matches. Where work-in-progress source disagrees with the ROM, the source is wrong.
- **Commit in small steps**, each with a matching build and a body giving the evidence and before/after numbers.
- **New code:** `tools/disasm.py`, `trace.py --write` or `sweep.py --write` into `wip/`, then `test_routines.py`, then `place_routines.py`. If `disasm.py --selftest` ever reports a difference after a change to the disassembler, fix the tool first.
- **Naming:** names come from what the code does, never from position or appearance; unknown stays `Unknown` with a note of what is known. `tools/rename.py` renames labels everywhere and can add a comment; `move_sections.py` moves sections between files. After naming RAM or adding constants, rerun `name_ram.py`, `apply_constants.py`, `name_struct_fields.py` and `stale_notes.py --fix`.
- **Check what automatic tools write.** They can take data for code or code for data at the edges of a block: look for proc headers (a 2-letter name such as "ON" decodes as `eor long`), pointer tables, and tables that end in `rts`.
- **64tass pitfalls** (more in `tools/README.md`): register widths follow source order; `,b` needs a 16-bit operand and does not subtract the data bank; a `.brept` list label used without `[0]` silently emits one instruction per entry; struct macros with `None` or missing arguments can emit nothing at all.
- **The user** did not write the original disassembly and wants to *understand* the engine, not only have it disassembled. Explain conventions instead of assuming familiarity, and leave things more readable than you found them.
