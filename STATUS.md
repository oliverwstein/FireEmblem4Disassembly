# Status

The current state of the project and what the next session should do. Read this first, then [PLAN.md](PLAN.md). **Rewrite this file at the end of every session.** Keep it short and about the present: past work goes in commit messages, and the older record is in [HISTORY.md](HISTORY.md).

The goal is source that is **readable and moddable** (shiftable, organized by game system, in the way pokecrystal is), **plus a written account of how the engine works** that a person can read without reading assembly (see "The engine guide" in PLAN.md).

## Current state (2026-11-22, after `9f9338a`)

- `./build.sh` is byte-identical and the checksums verify. 97.25% of the ROM is built from source.
- Routines: 5,959 top-level `rl`/`rs` labels under `engine/`, 3,441 of them `Unknown`; `engine/unsorted/` has about 130k lines. These are rough grep counts; `tools/counts.py` (not written yet) will replace them.
- Phase 1: every gap class except `none` (234 pieces, 62,476 bytes) and padding is closed.
- Phase 2: done, apart from running padded ROMs in an emulator (deferred on purpose; see Decisions).
- Phase 3: Wave 1 (game states, core, AI, global WRAM) is in `ef5fff9`. Stale "nothing reaches this" notes were cleared in `9f9338a` (`tools/stale_notes.py`); the 55 left are true by name.
- Engine guide: [docs/guide/00-introduction.md](docs/guide/00-introduction.md) written (overview of the program's shape, the three engines, the unit data model, the content formats, the game's life cycle). The reference set has not been started. The game-state routine names it mentions are still unaudited.

## Who wrote what

Claude's commits carry a Co-Authored-By line. Gemini wrote `f56d5ee`..`ef5fff9` (unsigned, no commit bodies) and will return around 2026-11-29. Its mechanical work (carving, merging, checksums) passes the build. Its names were never checked by anything: the Wave 1 game-state names follow a template (`…Stub/Show/RunStep/Render`) and some don't match their code (`rlCastleScreenIdle` is a compare whose result is never used).

## Decisions the user has made

- **Phase 3 is done when `engine/unsorted/` is empty.** Low-level rendering, HDMA, OAM and spell *visual effect* helpers may stay `Unknown` if they are hard; they are low priority. Everything that implements game mechanics must be named and understood.
- **Sound is the lowest priority.** No SPC700 driver work unless the user asks.
- **Emulator time costs the user a lot**: the game is in Japanese, which the user doesn't read. Ask only for short, targeted checks (a breakpoint, one screen, one action), and collect them into one list rather than asking piecemeal. Full play-through recordings only if nothing else will do.
- **Phase 1 is closed statically.** Leftover `none` pieces that don't decode as code with evidence become labelled data with an "unreferenced" note, so `.binary "fe4.sfc"` can go without new recordings.

## Next session, in order

1. **Write `tools/counts.py`.** It prints coverage, routines (total / `Unknown` / in `unsorted/`), gap classes, pinned blocks in `build.asm` and remaining notes, and every doc quotes only its output. Fix the numbers in PLAN.md and README.md (README still says 18%).
2. **Audit the Wave 1 names.** Read each routine `ef5fff9` named. Keep a name only if its routine's code supports it. Otherwise rename it back to `Unknown` with a comment on what is known. Remove committed question marks (`; event main loop routine?`). Collapse the runs of blank lines in the carved `engine/unsorted/bank*.asm` files.
3. **Set up the reference set** (PLAN.md, "The engine guide" part 1): the generator for `docs/reference/` and the reference for the Wave 1 systems (core, game states, procs, AI). The introduction already exists; revise it if the audit changes anything it says.
4. **Continue Phase 3 one system at a time.** Each wave: name the routines, move them out of `unsorted/`, complete that system's reference (routine, struct, file, system docs), then commit with an evidence body. Writing the docs in plain words is part of the wave, because that is how a wrong name gets caught. The guide's outline is drafted once the core systems have reference docs, and shown to the user.

## How to work on this project

- **The emulator log is tied to the original ROM.** `fe4.cdl` describes the original bytes at their original addresses. Renaming, relabelling and anything else that keeps the build identical leaves it valid: rerun `tools/cdl.py`, no new recording needed. Once the output changes (a mod, a shifted bank), record logs from the original ROM only.
- **The ROM decides.** A change is only correct if `./build.sh` still says the output matches. Where work-in-progress source disagrees with the ROM, the source is wrong.
- **Commit in small steps**, each with a matching build and a body giving the evidence and before/after numbers.
- **New code:** `tools/disasm.py`, `trace.py --write` or `sweep.py --write` into `wip/`, then `test_routines.py`, then `place_routines.py`. If `disasm.py --selftest` ever reports a difference after a change to the disassembler, fix the tool first.
- **Naming:** names come from what the code does, never from position or appearance; unknown stays `Unknown` with a note of what is known. `tools/rename.py` renames labels everywhere and can add a comment; `move_sections.py` moves sections between files. After naming RAM or adding constants, rerun `name_ram.py`, `apply_constants.py`, `name_struct_fields.py` and `stale_notes.py --fix`.
- **Check what automatic tools write.** They can take data for code or code for data at the edges of a block: look for proc headers (a 2-letter name such as "ON" decodes as `eor long`), pointer tables, and tables that end in `rts`.
- **64tass pitfalls** (more in `tools/README.md`): register widths follow source order; `,b` needs a 16-bit operand and does not subtract the data bank; a `.brept` list label used without `[0]` silently emits one instruction per entry; struct macros with `None` or missing arguments can emit nothing at all.
- **The user** did not write the original disassembly and wants to *understand* the engine, not only have it disassembled. Explain conventions instead of assuming familiarity, and leave things more readable than you found them.
