# Status

The current state of the project and what the next session should do. Read this first, then [PLAN.md](PLAN.md). **Rewrite this file at the end of every session.** Keep it short and about the present: past work goes in commit messages, and the older record is in [HISTORY.md](HISTORY.md).

The goal is source that is **readable and moddable** (shiftable, organized by game system, in the way pokecrystal is), **plus a written account of how the engine works** that a person can read without reading assembly (see "The engine guide" in PLAN.md).

## Current state (2026-11-23, after wave 7: the battle scene's HUD and slots)

Numbers come from `python3 tools/counts.py`; quote nothing else.

- `./build.sh` is byte-identical and the checksums verify (about 3 s; `./build.sh clean` first only when a converter changed). **The build is 100% source**; `./build.sh mod` makes the identical ROM without `fe4.sfc`. GAPS.md is empty.
- Routines: 6,505 in `engine/`, 4,741 named, 1,764 `Unknown`. 172 pinned blocks. 121 notes still say nothing reaches a routine.
- Pad tests pass for `$85`, `$87`, `$89`, `$91`, `$95`, `$9E` (16 bytes) and `$96` (8). `$8B` and `$A0` end where pinned graphics streams begin. `$87` and `$91` touch the code the game checksums (`--fix-checksums`).
- The battle scene ([docs/reference/battle_scene.md](docs/reference/battle_scene.md)): hud.asm has 10 `Unknown` left, combatants.asm 33, effects.asm 226 (visual effects, low priority), screen.asm 58 (IRQ/HDMA), loading.asm 25, results.asm 23, script.asm 12, rounds.asm 10, scene.asm 6. The script routine table (`aBattleSceneScriptRoutines`) is pointers now, so every script routine is reachable; most are effect steps still `Unknown`.
- Reference pages: `docs/reference/core.md`, `ai.md`, `battle_scene.md`, `castle.md`, `demo.md`, `epilogue.md`, `map_battle.md`, `menus.md`, `map_menu.md`, `map.md`, `save.md`, `title.md`, `worldmap.md`. `tools/reference.py` output is gitignored; run it locally.
- Engine guide: [docs/guide/00-introduction.md](docs/guide/00-introduction.md).
- `Unknown` by folder: `battle/` 697 (435 of them in `map_magic_effects.asm`, 151 in `map_battle.asm`), `battle_scene/` 404, `events/` 144, `title/` 140, `dialogue/` 97, `map/` 80; every other folder under 25.

## Who wrote what

Claude's commits carry a Co-Authored-By line. Gemini wrote `f56d5ee`..`ef5fff9` (unsigned, no commit bodies) and will return around 2026-11-29. Its mechanical work (carving, merging, checksums) passes the build. Its names were never checked by anything: the Wave 1 game-state names follow a template (`…Stub/Show/RunStep/Render`) and some don't match their code (`rlCastleScreenIdle` is a compare whose result is never used).

## Decisions the user has made

- **Phase 3 is done when everything in `engine/unsorted/` has been put in a proper place.** Low-level rendering, HDMA, OAM and spell *visual effect* helpers may stay `Unknown` if they are hard; they are low priority. Everything that implements game mechanics must be named and understood.
- **Sound is the lowest priority.** No SPC700 driver work unless the user asks.
- **Emulator time costs the user a lot**: the game is in Japanese, which the user doesn't read. Ask only for short, targeted checks (a breakpoint, one screen, one action), and collect them into one list rather than asking piecemeal. The existing .cdl covers the entire prologue chapter. **Before asking, try to answer the question from the code**; ask only what the code cannot settle (which path runs, what a value means on screen), and say in the list what the code already shows.
- **Phase 1 is closed statically** (done 2026-11-23): the build is 100% source; `fe4.sfc` is only read to compare against.

## Next session, in order

1. **Talk to the user before starting.** The candidates:
   - **Finish the battle scene's mechanics** (one session): combatants.asm's last 33 (the effect slots' spawn fields `$0C03`-`$0C30` set by sequence command `$EF`, `rsUnknown95DCA3`/`95DD4F`; the body records `aUnknown97EA9A` and `$7FE1BE`; `rsUnknown95DE0C`, `rlUnknown95E2EF`/`E304`/`E33B`; the routines at the top of the file, `95B5FD`-`95BA76`), then loading.asm (25), results.asm (23), rounds.asm (10: `rlUnknown95AAFF` picks an action when a combatant is airborne), script.asm (12). What bit 7 of `bBattleSceneStrikeFlags` means (a round entry with bit `$10`; the end steps play scripts `$34`/`$31` and sound `$89`-`$8B` by gender).
   - **The map battle** (`map_battle.asm` 151, `map_battle_magic.asm` 50, `map_battle_hud.asm` 16), skipping the spell visuals.
   - **The event engine** (`event_engine.asm` 40, `event_scripts.asm` 79, `cutscenes.asm` 20).
   - **The engine guide's outline**: draft `docs/guide/OUTLINE.md` and show it to the user (PLAN.md, "The engine guide").
2. **Before naming a bank, make it honest source.** Wave 7 found two more kinds: a table of long pointers written as `.byte` rows (`aBattleSceneScriptRoutines`; its targets all looked unreached), and tables whose `.word` rows straddle entries of 5 or 11 bytes (look at any table whose words look like `$7E4E`, `$4F7E`). Also `code_pointers.py`, `ram_lists.py`, raw `.word $XXXX`, `.byte` rows that are scripts or code, routines nothing references.
3. Open questions are at the end of each reference page. `tools/songs.py` stops at a stale label (`aUnknown8A9D79`); fix it before regenerating `audio/SONGS.md`. `tools/stream_catalog.py` deleted the catalog previews when run (reverted); find out why before rerunning it. New files from `move_sections.py` and `split_section.py` are included at the top of build.asm, and moved sections land at the end of their target file; move both by hand. Check that an `include/` file does not exist before creating one. `tools/rename.py` refuses a new name that appears anywhere, comments included: rename first, then write comments that use the new name (wave 7 tripped on this twice with comments written into include/ and data.asm). `rename.py` does not touch `docs/` or `tools/`: grep them for old names after a rename. `move_sections.py` stops at a section listed twice in its spec. A RAM name in `$7FE000`-`$7FFFFF` must use a `BattleScene` prefix to stay scoped (`name_ram.py`); `bBattleAnimation...` there would be written into map code.
4. Banks `$88`, `$9B` and `$9F` have not been pad-tested yet (`./build.sh pad SECTION N`). Leave `wip/` holding only `.gitkeep` at the end of a session.
5. The Jugdral history's texts (`engine/save/jugdral_history.asm`) are still `.byte` rows; the user asked where the text is. Find whether `tools/dialogue.py`'s encoding reads them (it read the lover conversation's text without trouble).

**Per-wave checklist.** One system (or one part of a big one) per session; hand over and clear context after each.

1. **Start:** read STATUS.md, PLAN.md, the system's existing reference page if any; report the plan to the user before changing anything.
2. **Name** each routine from its code and callers (trace table indices, check every "unused" claim with a grep). Unknown stays `Unknown` with a note of what is known. No question marks committed.
3. **Move** routines that sit in the wrong file into the system's folder (`move_sections.py`), with a header comment on each file.
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
6. The title screen's intro (let the game sit after the attract opening, about two minutes): what each of its eight scenes shows and what the captions say. The code shows the scenes' timing and setup (title.md); the captions are graphics, so only the screen shows their words.

## How to work on this project

- **The emulator log is tied to the original ROM.** `fe4.cdl` describes the original bytes at their original addresses. Renaming, relabelling and anything else that keeps the build identical leaves it valid: rerun `tools/cdl.py`, no new recording needed. Once the output changes (a mod, a shifted bank), record logs from the original ROM only.
- **The ROM decides.** A change is only correct if `./build.sh` still says the output matches. Where work-in-progress source disagrees with the ROM, the source is wrong.
- **Commit in small steps**, each with a matching build and a body giving the evidence and before/after numbers.
- **New code:** `tools/disasm.py`, `trace.py --write` or `sweep.py --write` into `wip/`, then `test_routines.py`, then `place_routines.py`. To redo misdecoded built code in place: `redisasm_chain.py FILE START END ENTRY... [s:SCRIPT...]` (refuses ranges that cross section lines; `--dry-run` writes to stdout, which also suits `wip/`); `promote_locals.py FILE ADDR...` makes a local label a routine; `sprite_scripts.py ADDR` prints an active sprite script. If `disasm.py --selftest` ever reports a difference after a change to the disassembler, fix the tool first.
- **Naming:** names come from what the code does, never from position or appearance; unknown stays `Unknown` with a note of what is known. `tools/rename.py` renames labels everywhere and can add a comment; `move_sections.py` moves sections between files. After naming RAM or adding constants, rerun `name_ram.py`, `apply_constants.py`, `name_struct_fields.py` and `stale_notes.py --fix`.
- **Check what automatic tools write.** They can take data for code or code for data at the edges of a block: look for proc headers (a 2-letter name such as "ON" decodes as `eor long`), pointer tables, and tables that end in `rts`.
- **64tass pitfalls** (more in `tools/README.md`): register widths follow source order; `,b` needs a 16-bit operand and does not subtract the data bank; a `.brept` list label used without `[0]` silently emits one instruction per entry; struct macros with `None` or missing arguments can emit nothing at all.
- **The user** did not write the original disassembly and wants to *understand* the engine, not only have it disassembled. Explain conventions instead of assuming familiarity, and leave things more readable than you found them.
