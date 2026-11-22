# Status

The current state of the project and what the next session should do. Read this first, then [PLAN.md](PLAN.md). **Rewrite this file at the end of every session.** Keep it short and about the present: past work goes in commit messages, and the older record is in [HISTORY.md](HISTORY.md).

The goal is source that is **readable and moddable** (shiftable, organized by game system, in the way pokecrystal is), **plus a written account of how the engine works** that a person can read without reading assembly (see "The engine guide" in PLAN.md).

## Current state (2026-11-22, after `0c07436`)

Numbers come from `python3 tools/counts.py`; quote nothing else.

- `./build.sh` is byte-identical and the checksums verify. 97.53% of the ROM is built from source. GAPS.md: 216 `none` pieces (61,565 bytes), 56 padding runs (42,139 bytes).
- Routines: 5,956 in `engine/`, 2,516 named, 3,440 `Unknown`; 3,005 still in `engine/unsorted/`. 307 pinned blocks.
- Phase 3 Wave 1 audit done: the game-state routines are named by role (`rl<Screen>Upkeep/Setup/Step`, constants in `include/GameStates.h`); wrong claims fixed (see commits `2e4e0d0`, `96e3557`). The other ~380 names `ef5fff9` gave were triaged: Gemini's comments are mostly specific and code-derived; the "unused" claims, interpretive names and table names were checked one by one. A full line-by-line read of every AI/RAM-struct/OAM routine was not done.
- Reference set started: `tools/reference.py` generates `docs/reference/routines/`, `ram.md`, `INDEX.md`; hand-written `docs/reference/README.md`, `core.md`, `ai.md`. Its output is gitignored; run it locally to read the index.
- Engine guide: [docs/guide/00-introduction.md](docs/guide/00-introduction.md), updated for the game-state names and the menu option stack.

## Who wrote what

Claude's commits carry a Co-Authored-By line. Gemini wrote `f56d5ee`..`ef5fff9` (unsigned, no commit bodies) and will return around 2026-11-29. Its mechanical work (carving, merging, checksums) passes the build. Its names were never checked by anything: the Wave 1 game-state names follow a template (`…Stub/Show/RunStep/Render`) and some don't match their code (`rlCastleScreenIdle` is a compare whose result is never used).

## Decisions the user has made

- **Phase 3 is done when everything in `engine/unsorted/` has been put in a proper place.** Low-level rendering, HDMA, OAM and spell *visual effect* helpers may stay `Unknown` if they are hard; they are low priority. Everything that implements game mechanics must be named and understood.
- **Sound is the lowest priority.** No SPC700 driver work unless the user asks.
- **Emulator time costs the user a lot**: the game is in Japanese, which the user doesn't read. Ask only for short, targeted checks (a breakpoint, one screen, one action), and collect them into one list rather than asking piecemeal. The existing .cdl covers the entire prologue chapter.
- **Phase 1 is closed statically.** Leftover `none` pieces that don't decode as code with evidence become labelled data with an "unreferenced" note, so `.binary "fe4.sfc"` can go without new recordings.

## Next session, in order

1. **Talk to the user before starting a Phase 3 wave** (they asked for a report between the setup steps and the waves).
2. **Continue Phase 3 one system at a time.** Each wave: name the routines, move them out of `unsorted/`, write or extend that system's `docs/reference/<system>.md`, commit with an evidence body. Plain-words docs are part of the wave; they catch wrong names. Draft `docs/guide/OUTLINE.md` once the core systems have reference pages, and show it to the user.
3. Open questions left by Wave 1 are listed at the end of `docs/reference/core.md` and `ai.md`.

## How to work on this project

- **The emulator log is tied to the original ROM.** `fe4.cdl` describes the original bytes at their original addresses. Renaming, relabelling and anything else that keeps the build identical leaves it valid: rerun `tools/cdl.py`, no new recording needed. Once the output changes (a mod, a shifted bank), record logs from the original ROM only.
- **The ROM decides.** A change is only correct if `./build.sh` still says the output matches. Where work-in-progress source disagrees with the ROM, the source is wrong.
- **Commit in small steps**, each with a matching build and a body giving the evidence and before/after numbers.
- **New code:** `tools/disasm.py`, `trace.py --write` or `sweep.py --write` into `wip/`, then `test_routines.py`, then `place_routines.py`. If `disasm.py --selftest` ever reports a difference after a change to the disassembler, fix the tool first.
- **Naming:** names come from what the code does, never from position or appearance; unknown stays `Unknown` with a note of what is known. `tools/rename.py` renames labels everywhere and can add a comment; `move_sections.py` moves sections between files. After naming RAM or adding constants, rerun `name_ram.py`, `apply_constants.py`, `name_struct_fields.py` and `stale_notes.py --fix`.
- **Check what automatic tools write.** They can take data for code or code for data at the edges of a block: look for proc headers (a 2-letter name such as "ON" decodes as `eor long`), pointer tables, and tables that end in `rts`.
- **64tass pitfalls** (more in `tools/README.md`): register widths follow source order; `,b` needs a 16-bit operand and does not subtract the data bank; a `.brept` list label used without `[0]` silently emits one instruction per entry; struct macros with `None` or missing arguments can emit nothing at all.
- **The user** did not write the original disassembly and wants to *understand* the engine, not only have it disassembled. Explain conventions instead of assuming familiarity, and leave things more readable than you found them.
