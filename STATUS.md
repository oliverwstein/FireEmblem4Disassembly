# Project status

Last updated 2026-11-19. This file records what has been done and what remains, so that work can pick up where it left off. For how to build and how the repository is laid out, see [README.md](README.md). For the tools, see [tools/README.md](tools/README.md).

The goal is source that reads like a clean reconstruction of the original, in the way pokecrystal and Polished Crystal do: every routine, variable and field named, constants instead of numbers, data in readable formats, organized by game system, and eventually nothing taken from the base ROM.

## Where things stand

- `./build.sh` builds a ROM that is byte-for-byte identical to the original (Japanese 1.0, SHA-1 `90f0bdeaf0151899f96281258fcb30899fbd0d44`).
- **19.74% of the ROM is built from source** (828,048 of 4,194,304 bytes; `./build.sh coverage`). The rest is copied from `fe4.sfc` at build time. Most of what remains is graphics, maps, music and text; the code left is estimated at 50-80 KB.
- `engine/` has 97 files with **3,713 routines** and 996 data labels. **1,916 routines** still have `Unknown` in their names, and **1,358** are in `engine/unsorted/` (filed by ROM bank, not yet by system).
- In built code, **3,509 operands** still use raw RAM addresses (825 distinct addresses), and about **8,800** use numbers that may stand for constants.
- `wip/` is empty. `include/Undisassembled.h` names 47 ROM tables that built code reads but whose length is not known yet. No built code calls code that is not built.
- `tools/trace.py` finds nothing left to follow, and `tools/disasm.py --selftest` reassembles all 3,548 routines it can start from to the same bytes.

| Stage | Bytes from source | Share |
|---|---|---|
| Starting point | 675,008 | 16.09% |
| AI code and the first pass over TempStuff | 714,327 | 17.03% |
| The rest of TempStuff | 729,236 | 17.39% |
| Tracing calls, definitions and jump tables | 761,454 | 18.15% |
| Proc scripts | 779,634 | 18.59% |
| ROM tables read by built code | 784,109 | 18.69% |
| Code sweep (now) | 828,048 | 19.74% |

Share of each bank's `$8000`-`$FFFF` half built from source:

| | | | |
|---|---|---|---|
| `$80`: 41% | `$81`: 59% | `$82`: 36% | `$83`: 99% |
| `$84`: 98% | `$85`: 52% | `$86`: 100% | `$87`: 80% |
| `$88`: 75% | `$89`: 49% | `$8A`: 33% | `$8B`: 25% |
| `$8C`: 2% | `$8D`: 60% | `$8E`-`$8F`: 100% | `$90`: 82% |
| `$91`: 80% | `$95`: 3% | `$9D`: 100% | `$9E`: 79% |

Not every uncovered byte is code: tables, text, graphics and zero-filled padding are mixed in, and banks `$92`-`$9C` are almost all data.

## What has been done

Every step kept the output identical to the original.

### Build and layout

- **macOS build.** `build.sh` converts the dialogue and CSV tables, checks include paths (`tools/check_paths.py`), assembles with 64tass and compares the SHA-1. `./build.sh coverage` builds twice more with the base ROM replaced by `$00` and `$FF`; bytes that come out the same come from source.
- **Organized by game system.** `engine/<system>/` files with descriptive section names; `build.asm` is the ROM map that places sections by name. Each section states its starting register widths, because 64tass tracks widths in source order. Folders: `include/`, `data/`, `text/`, `events/`, `gfx/`, `tools/`, `wip/`.

### Bringing code in

- **AI code and TempStuff.** All of the old `wip/AITemp.asm` and `wip/TempStuff.asm` is in the build, after about 100 corrections where the work-in-progress source disagreed with the ROM (list labels without `[0]`, `size()` of a list, wrong data banks, long addressing that 64tass shortened).
- **Disassembler** (`tools/disasm.py`). Turns ROM code into routines in the project's style: follows register widths and the data bank, uses existing names, writes long-pointer loads with labels, knows the inline arguments of `rlDMAByStruct` and the palette routines, and treats unreachable bytes inside a routine as data. Its output has matched the ROM without hand fixes every time.
- **Tracer** (`tools/trace.py`). Follows calls and jumps from every built routine, the init and on-cycle routines of proc, HDMA and active sprite definitions, proc scripts (`tools/procs.py` knows every proc command), and jump tables. About 700 routines came in this way, all reached from verified code.
- **Proc scripts** (`tools/proc_scripts.py`). Scripts and unlabelled proc headers are written with the `PROC_*` macros. Command `$82/8279` is `rsProcCodeCreateActiveSprite`.
- **ROM tables** (`tools/rom_tables.py`). Every table that built code reads by raw address got a label: 130 written out with their bytes, 47 named only.
- **Code sweep** (`tools/sweep.py`). Decodes gaps that nothing points to and accepts a candidate only with evidence: it ends cleanly, has no data-like opcodes, does not branch into itself, calls only known routines or other gaps, does not start like a proc header or pointer table, and scores at least 3 (calls to known routines plus named RAM variables). With the tracer, this added about 500 routines (44 KB). Each is marked "Found by tools/sweep.py". Ten early finds that began with data were repaired by hand.

### Findings worth knowing

- **Code checksums** (`include/Checksums.h`). The game sums `$80/8D56-8E2C` and `$87/8017-80A9` and compares the sums with `aCodeChecksums` (`$8F/8000`) and its copies at the start of banks `$87` and `$88`. The third word, "IS", switches the checks on. When `rlCheckCodeChecksums` finds a difference, the random number generator takes its numbers from `rsUnknown80A7F3` instead. Anyone changing that code has to update the sums.
- **Game states.** Every frame, `rlRunGameStateRoutines` runs the routines at `wGameStateRoutine1` and `wGameStateRoutine2` in `aGameStateRoutines`; `wGameStateStep` counts the steps of the current state. Routines such as `$80/C39A` set up a state (screen off, VBlank and main loop pointers, state indices).
- **Battle.** `rlActionStructBuildBattleRounds` fills `aBattleRoundsData` with strikes; `rsActionStructResolveStrike` resolves one. `rlFindTargetsInRange` picks targets with 14 filters (`aTargetFilterRoutines`).
- **Items.** Buying, selling and repair prices (`rlGetItemBuyPrice`, `rlGetItemSellPrice`, `rlGetItemRepairCost`); Bargain halves them; holy weapons cannot be sold or thrown away.
- **AI formations.** Four routines, one per `wAIFormationDirection`, each turning a formation pattern a quarter turn further.

### Naming

- **Structural names.** Event and event condition commands are named after the macros the chapter scripts use (`rsEventCommandJumpTrue`). Routines that a single proc uses as its init or on-cycle routine are `rlProc<Name>Init`/`Cycle…`. Unknown routines that return with `rts` are `rsUnknown…`.
- **Battle, units and items.** About 80 routines named from what their code does and how callers use it. Where only the computation is certain, the name says that and the comment says what it is most likely for (`rlGetInventorySlotStaffCostValue`, probably staff experience). Left: battle 16, units 13, items 6.
- **RAM.** `tools/name_ram.py` writes raw addresses with the names `include/` gives them (about 2,200 operands so far). The most-used unknown variables that could be named with confidence are named: the game state variables, `wActiveUnitDeploymentOffset`, the unit relocation record (`wUnitRelocationDeploymentOffset`, `...Type`, `...LocationID`) and several temporaries.
- **Constants and struct fields.** `tools/apply_constants.py` (rules in `tools/constant_rules.txt`) writes numbers compared with a known getter or field as constants (78 operands); `tools/name_struct_fields.py` writes small offsets from an index register as struct fields (64 offsets).
- **Sorting.** 95 sections left `unsorted/` because every routine using them is a named routine in one system. Callers with `Unknown` names do not count: many were filed by ROM neighbours, and trusting them spread wrong guesses.

## What remains

In rough order of value.

### 1. Naming and sorting (the bulk of the work)

1,916 unnamed routines, 1,358 of them in `unsorted/`, and 825 unnamed RAM addresses. Automatic naming and sorting have gone as far as the evidence allows; from here it is reading code, system by system. Names must state only what is known; uncertain routines stay `Unknown` or get a comment saying how sure it is.

- **Main-loop game states** in bank `$80`: the sweep found their setup routines, and naming them gives the rest of the code a structure to hang on.
- **Helpers of the named event commands** in `engine/events/event_scripts.asm`.
- **Map code** in bank `$88` (scrolling, map sprites) and the **"ON" scene procs** in bank `$9E` (scripted scenes; one is `procBelhallaMagesAttack`).
- **The rest of battle, units and items** (35 routines): the harder ones, such as the battle dispatcher `rlUnknown84DC1C` and `structActionStructEntry.Unknown`, whose value 8 makes `rsActionStructResolveStrike` run `rsUnknown84EA37` instead of a normal strike.
- **RAM.** `tools/name_ram.py --report 25` lists the most-used unnamed addresses. The top ones are flag words (`$0788`, `$0D87`, `$08AD`, `$04EA`) and map and map battle working values (`$0778`, `$07DA`, `$07E0`, `$07E6`, `$0792`, `$7F45xx`, `$7F4Cxx`) whose meaning is not clear from the code alone.
- **Constants.** About 8,800 numbers left. Each new getter or field with a known constant family is one line in `tools/constant_rules.txt`. `bBattleRoundFlags` bits `$02` and `$10` are still unknown.
- File descriptions were written from routine names and existing comments; correct them as understanding improves. In `units/`, `map/` and elsewhere, routines placed next to named neighbours are only probably related.

### 2. An emulator log (needs the user)

A code/data log from Mesen (which runs on macOS), recorded while playing, marks which bytes were executed and which were only read. It would settle what is code and what is data for everything played, give the exact extent of tables, and find code reached only by computed jumps. Mesen's debugger, which can load `labels.txt`, is also how uncertain names get confirmed. Rarely used code (the debug menu, late chapters' scripted events) still needs the static methods.

### 3. Code and data left to bring in

- **21 sweep candidates now pass the threshold** (757 bytes): naming RAM raised their scores. Run `tools/sweep.py --write wip/Sweep.asm`, test and place them, then trace again.
- **Below the threshold**: about 240 candidates (about 9 KB), a mix of real code (for example a palette routine at `$88/9EE9`), data that happens to decode, and gaps that start with a few table bytes. Read them one by one (`tools/sweep.py --min-score 0 --list`), or wait for the emulator log.
- **The 47 tables with names only**: their readers' loops give their lengths. Write the table out and remove its line from `include/Undisassembled.h`.
- **`$8A/CFBE`** (after the 89-pointer table at `$8A/CEB3`) is a ROM slice because it starts in the middle of a routine.
- **Check written tables against their readers' loops** as you name them: a short table followed by code that calls nothing known can have been taken as one block (`aUnknown88ACF1` and `aUnknown91FA27` were).
- **Active sprite and HDMA scripts**: mostly visual code; low priority.

### 4. Data and assets

- Readable formats for the remaining data: map layouts, menu definitions, portrait tables, and the tables written as `aUnknownXXXXXX`.
- 29 `ROM[start:end]` slices remain, most in `build.asm` (world map tilemaps, the dialogue font, battle banner graphics).
- Graphics, maps and music: the decompressor is disassembled (`engine/core/decompressor.asm`), so a compressor that reproduces its output byte for byte, a PNG converter and an extraction script are tooling work that can start any time. **A decision for the user:** commit extracted assets, as pokecrystal does, or extract them from each user's own ROM at build time, which keeps Nintendo's assets out of the repository.
- Once everything is source, `build.asm` becomes a pure layout and the `.binary "fe4.sfc"` overlay goes away.

### 5. Documentation

Short explanations of the engines that are understood (procs, the event interpreter, active sprites, AI, battle rounds, the checksums), like pokecrystal's `docs/`.

### 6. Loose ends

- The Windows `.bat` scripts have updated paths but have not been run since the folder rename.
- `engine/menus/map_menu.asm` adds the constant `$027E` in two places. The original author's guess, `size(aDialogueBoxTilemap)-2`, did not match the ROM, and the meaning is unknown.
- `labels.txt`, `log.txt`, the `.dialogue.txt` and `.csv.asm` files, `fe4.sfc` and `FE4Disassembly.sfc` are generated or local, and are ignored by git.

## How to work on this project

- **The ROM decides.** A change is only correct if `./build.sh` still says the output matches. Where work-in-progress source disagrees with the ROM, the source is wrong.
- **Commit in small steps**, each with a matching build.
- **New code:** `tools/disasm.py`, `trace.py --write` or `sweep.py --write` into `wip/`, then `test_routines.py`, then `place_routines.py`. If `disasm.py --selftest` ever reports a difference after a change to the disassembler, fix the tool first.
- **Naming:** `tools/rename.py` renames labels everywhere and can add a comment; `move_sections.py` moves sections between files. After naming RAM or adding constants, rerun `name_ram.py`, `apply_constants.py` and `name_struct_fields.py`, which only ever swap a number for a name of the same value.
- **Check what automatic tools write.** They can take data for code or code for data at the edges of a block: look for proc headers (a 2-letter name such as "ON" decodes as `eor long`), pointer tables, and tables that end in `rts`.
- **64tass pitfalls** (more in `tools/README.md`): register widths follow source order; `,b` needs a 16-bit operand and does not subtract the data bank; a `.brept` list label used without `[0]` silently emits one instruction per entry; struct macros with `None` or missing arguments can emit nothing at all.
- **The user** did not write the original disassembly, so explain its conventions instead of assuming familiarity. Do confident, verifiable work, and flag judgment calls.
