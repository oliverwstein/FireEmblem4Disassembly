# Status

The current state of the project and what the next session should do. Read this first, then [PLAN.md](PLAN.md). **Rewrite this file at the end of every session.** Keep it short and about the present: past work goes in commit messages, and the older record is in [HISTORY.md](HISTORY.md).

The goal is source that is **readable and moddable** (shiftable, organized by game system, in the way pokecrystal is), **plus a written account of how the engine works** that a person can read without reading assembly (see "The engine guide" in PLAN.md).

## Current state (2026-11-23, after wave 5 part 1: bank $9F)

Numbers come from `python3 tools/counts.py`; quote nothing else.

- `./build.sh` is byte-identical and the checksums verify. 97.60% of the ROM is built from source. GAPS.md: 160 `none` pieces (58,472 bytes), 57 padding runs.
- Routines: 6,147 in `engine/`, 4,319 named, 1,828 `Unknown`; 791 still in `engine/unsorted/` (banks `$84`, `$8B`, `$8C`, `$95`-`$97`, `$9B`). 292 pinned blocks.
- **Wave 5 part 1 done** (commits `24ef9ce`..`3ade4ba`): bank `$9F` is the map battle's magic effects, now `engine/battle/map_battle_magic.asm` (the machinery) and `map_magic_effects.asm` (one starter per spell, `rlStartMapMagicFire` ...; the effects' steps stay `Unknown` with a note naming their effect). Before naming, the bank was rebuilt as honest source: misdecoded step chains and scripts redone, every raw pointer a label, every unbuilt piece closed, 28 blocks merged to 3. Bank `$97`'s opening demo battle loader is in `engine/demo/demo_battle_scenes.asm`. HISTORY.md has the details.
- New: active sprite script macros `ACTIVE_SPRITE_*` and `structActiveSpriteInfo` (`include/ActiveSpriteEngine.h`), the command routines named in `active_sprites.asm`; RAM `wMapMagic*` at `$7F5089`, `wDemoBattlePair` (`$0CC2`).
- New tools: `promote_locals.py`, `redisasm_chain.py`, `sprite_scripts.py` (see "How to work").
- Reference pages: `docs/reference/core.md`, `ai.md`, `castle.md`, `demo.md`, `epilogue.md`, `map_battle.md` (now with "Magic effects"), `menus.md`, `map_menu.md`, `map.md`, `save.md`. `tools/reference.py` output is gitignored; run it locally.
- Engine guide: [docs/guide/00-introduction.md](docs/guide/00-introduction.md).

## Who wrote what

Claude's commits carry a Co-Authored-By line. Gemini wrote `f56d5ee`..`ef5fff9` (unsigned, no commit bodies) and will return around 2026-11-29. Its mechanical work (carving, merging, checksums) passes the build. Its names were never checked by anything: the Wave 1 game-state names follow a template (`…Stub/Show/RunStep/Render`) and some don't match their code (`rlCastleScreenIdle` is a compare whose result is never used).

## Decisions the user has made

- **Phase 3 is done when everything in `engine/unsorted/` has been put in a proper place.** Low-level rendering, HDMA, OAM and spell *visual effect* helpers may stay `Unknown` if they are hard; they are low priority. Everything that implements game mechanics must be named and understood.
- **Sound is the lowest priority.** No SPC700 driver work unless the user asks.
- **Emulator time costs the user a lot**: the game is in Japanese, which the user doesn't read. Ask only for short, targeted checks (a breakpoint, one screen, one action), and collect them into one list rather than asking piecemeal. The existing .cdl covers the entire prologue chapter. **Before asking, try to answer the question from the code**; ask only what the code cannot settle (which path runs, what a value means on screen), and say in the list what the code already shows.
- **Phase 1 is closed statically.** Leftover `none` pieces that don't decode as code with evidence become labelled data with an "unreferenced" note, so `.binary "fe4.sfc"` can go without new recordings.

## Next session, in order

1. **Talk to the user before starting.** Wave 5 part 2 is the battle scene (agreed with the user): one wave covering banks `$9B`, `$95`, `$96` and the rest of `$97`. Order:
   1. **Start with bank `$9B` as the outline** (78 routines). It is the top of the battle scene: game state `$1A` (`rlMapBattleSetup`, the setup) and `$1B` (`rlMapBattleStep`, every frame, running one of three phases by `$7FD000`). Read it top-down to get the order of calls into `$95`/`$96` (`rlBattleSceneScriptClearLoading`/`UpdateLoading`, `rlUnknown95F1A9`, `95EA47`, `95F741`/`F7F7`/`F87F`, `95F1D5`, `95F14D`, `96D659`, `96D695`, `96CB44`, `96A532` ...). That tells what each of them is for. The Gemini names `rlMapBattleSetup`/`rlMapBattleStep` are wrong: this is the battle scene (animations on), not the map battle. Check `rsOpenMapBattle`, which selects these states, too.
   2. Not everything in `$9B` is battle scene: `rlStartOpeningEvent` (called from the opening), `rlUnknown9BFBC0` (from boot), `rlUnknown9BFC8D` (from the event engine), and the bank `$99` data in the same file. File those with their own systems.
   3. Then banks `$95` and `$96` (about 670 routines; `engine/battle_scene/` exists), with the rest of `$97` alongside: `rlUnknown978000` plays sound `$90` panned by `wBattleAnimationX`, and its tables are read by `rsBattleAnimationGetBodyIndex`.
2. **Before naming a bank, check that it is honest source** (this took most of wave 5 part 1): `tools/code_pointers.py` (raw on-cycle stores), raw `.word $XXXX` in tables and inline arguments, `.byte` rows that are scripts or code, and routines nothing references (a routine that starts inside an instruction builds fine). Fix with `promote_locals.py`, `redisasm_chain.py` and `sprite_scripts.py`. Bank `$9E`'s map battle sprite scripts are still `.byte` rows and may have the same problems.
3. **Run each wave by the checklist below.** Draft `docs/guide/OUTLINE.md` once the core systems have reference pages, and show it to the user.
4. Open questions are at the end of each reference page. `tools/songs.py` stops at a stale label (`aUnknown8A9D79`); fix it before regenerating `audio/SONGS.md`. `tools/stream_catalog.py` deleted the catalog previews when run (reverted); find out why before rerunning it. New files from `move_sections.py` and `split_section.py` are included at the top of build.asm; move the lines by hand. Check that an `include/` file does not exist before creating one. `tools/rename.py` refuses a new name that appears anywhere, comments included: rename first, then write comments that use the new name.
5. Bank `$89` cannot be pad-tested until it is merged. Banks `$85`, `$87`, `$88` and now `$9F` could be pad-tested (`./build.sh pad`).
6. Two unbuilt pieces in bank `$91` decode as unreferenced code: `$91/DF08` and `$91/E006`. Close them as labelled data or code with an "unreferenced" note.

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
- **New code:** `tools/disasm.py`, `trace.py --write` or `sweep.py --write` into `wip/`, then `test_routines.py`, then `place_routines.py`. To redo misdecoded built code in place: `redisasm_chain.py FILE START END ENTRY... [s:SCRIPT...]` (refuses ranges that cross section lines; `--dry-run` writes to stdout, which also suits `wip/`); `promote_locals.py FILE ADDR...` makes a local label a routine; `sprite_scripts.py ADDR` prints an active sprite script. If `disasm.py --selftest` ever reports a difference after a change to the disassembler, fix the tool first.
- **Naming:** names come from what the code does, never from position or appearance; unknown stays `Unknown` with a note of what is known. `tools/rename.py` renames labels everywhere and can add a comment; `move_sections.py` moves sections between files. After naming RAM or adding constants, rerun `name_ram.py`, `apply_constants.py`, `name_struct_fields.py` and `stale_notes.py --fix`.
- **Check what automatic tools write.** They can take data for code or code for data at the edges of a block: look for proc headers (a 2-letter name such as "ON" decodes as `eor long`), pointer tables, and tables that end in `rts`.
- **64tass pitfalls** (more in `tools/README.md`): register widths follow source order; `,b` needs a 16-bit operand and does not subtract the data bank; a `.brept` list label used without `[0]` silently emits one instruction per entry; struct macros with `None` or missing arguments can emit nothing at all.
- **The user** did not write the original disassembly and wants to *understand* the engine, not only have it disassembled. Explain conventions instead of assuming familiarity, and leave things more readable than you found them.
