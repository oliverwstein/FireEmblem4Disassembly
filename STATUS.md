# Project status

Last updated 2026-11-19 (second session that day). This file records what has been done and what remains, so that work can pick up where it left off. For how to build and how the repository is laid out, see [README.md](README.md). For the tools used to bring new code into the build, see [tools/README.md](tools/README.md).

## Where things stand

- `./build.sh` builds a ROM that is byte-for-byte identical to the original (Japanese 1.0, SHA-1 `90f0bdeaf0151899f96281258fcb30899fbd0d44`).
- **19.74% of the ROM is built from source** (828,048 of 4,194,304 bytes; `./build.sh coverage`). The rest is copied from `fe4.sfc` at build time.
- Engine code is organized by game system under `engine/` (3,713 routines and 996 data labels). 1,917 routines still have `Unknown` in their names, and 1,358 routines are in `engine/unsorted/` (filed by bank, not yet by system).
- `wip/` is empty. `include/Undisassembled.h` names 47 ROM tables that built code reads but whose length is not known yet; no built code calls code that is not built.
- Every call, jump, engine definition (proc, HDMA, active sprite), proc script and jump table reachable from built code is built, and so is every proc script. `tools/trace.py` reports nothing left to follow.

| Stage | Bytes from source | Share |
|---|---|---|
| Starting point (before this work) | 675,008 | 16.09% |
| After adding the AI code | 687,588 | 16.39% |
| After the first pass over TempStuff | 714,327 | 17.03% |
| After the rest of TempStuff | 729,236 | 17.39% |
| After tracing calls from built code | 755,758 | 18.02% |
| After definitions and jump tables | 761,454 | 18.15% |
| After proc scripts | 779,634 | 18.59% |
| After the ROM tables | 784,109 | 18.69% |
| Now (after the code sweep) | 828,048 | 19.74% |

## What has been done

In order:

1. **macOS build.** Added `build.sh`, which converts the dialogue and CSV tables, checks include paths, assembles with 64tass, and compares the SHA-1 with the original. `./build.sh coverage` measures how much comes from source by building twice with the base ROM replaced by `$00` and `$FF`.
2. **Reorganized by game system.** The old `SRC/BankXX.asm` and mixed files became `engine/<system>/` files. Address-based section names became descriptive ones. Each section now states its starting register widths, because 64tass tracks widths in source order and reordering the source changed what routines inherited.
3. **Consistent folder layout:** `include/`, `data/`, `text/`, `events/`, `gfx/`, `tools/`, `wip/`, with `build.asm` as the ROM map. Added `tools/check_paths.py` (exact-case include paths, run by `build.sh`).
4. **Checked every file description against its routines**, moved code that was misfiled (for example, inventory code that was in `battle/effects.asm`), and corrected descriptions that overstated or left things out.
5. **AI code.** All 186 routines of the old `wip/AITemp.asm` went into the build as `engine/ai/` after about 25 corrections where the work-in-progress source disagreed with the ROM.
6. **Tools.** `tools/test_routines.py`, `fix_addressing.py`, `show_lines.py`, `place_routines.py`, `split_section.py` and `asmlib.py`. Together they test work-in-progress code against the ROM, fix the systematic problems, show differences line by line, and move matching routines into the build. `place_routines.py` trial-builds every placement and leaves out routines that only match together with code that stays behind.
7. **TempStuff.** Every routine of the old `wip/TempStuff.asm` was handled: 719 are in the build, 7 were duplicates of built code and were removed, and 16 routines plus one unlabelled data block are in `wip/TempStuffNeedsWork.asm`. Along the way:
   - about 80 instructions and operands that disagreed with the ROM were corrected;
   - names already given elsewhere in the project were used where they existed (for example, `rlUnknown81B223` is `rlASMCShowItemPopUpBox`);
   - two RAM variables defined inside code (`bRNGUnknown1/2`) were moved to `include/WRAM.h`;
   - the author's loose notes became comments next to what they describe.

8. **The rest of TempStuff** (2026-11-19). All 16 needs-work items and the unlabelled block are in the build. The fixes were mostly the pitfalls listed below: list labels without `[0]`, `size()` of a list, the wrong data bank (`rlFillEventMovementMoveCostMap` sets `$7E`, not `$7F`), and long addressing where 64tass chose absolute. Movement script commands got numeric names (`MAP_CMD_*` in `include/events/Helpers.h`) that the `MAP_*` macros now use. `wSon/DaughterCharacterROMPointer` hold unit RAM pointers and were renamed `wSon/DaughterUnitRAMPointer`. The battle banner graphics in bank `$9C` are labelled ROM slices in `build.asm`, and their table is `engine/battle/banners.asm`.
9. **Disassembler.** `tools/disasm.py` turns ROM code into routines in the project's style. It follows register widths through `rep`/`sep` and branches, follows the data bank through `phk/plb` and `lda #bank/pha/plb`, uses existing names, writes long-pointer loads as `` #(`label)<<8 ``/`#<>label`, knows the inline arguments of `rlDMAByStruct` and the palette routines, and treats unreachable bytes inside a routine as data. `--selftest` disassembles every built routine (2,789 now) and checks that the output reassembles to the same bytes; it does, for all of them.
10. **Tracer.** `tools/trace.py` starts from every built routine and follows `jsr`/`jsl`/`jmp`/`jml`, the init and on-cycle routines of proc, HDMA and active sprite definitions loaded into `lR44` before a create call, and raw entries in jump tables whose other entries are routines. It disassembles what it finds, follows that too, and can write the result as a routines file. Three rounds found 440 routines (about 32 KB); all matched the ROM as written and are in the build, mostly in `engine/unsorted/`. Built code now calls them by label (about 850 raw addresses replaced).
11. **Never-disassembled callees.** `rlFreeDialogueBoxes` (was `rlUnknown85AB3F`), `rlDrawMenuTextLine` and `rlDrawMenuTextNumber` (with its two tables) are in the build.
12. **Naming convention.** Unknown routines that return with `rts` and never `rtl` are now `rsUnknown…` (145 renamed); `trace.py` picks the prefix itself.
13. **Proc scripts.** `tools/procs.py` describes the proc script format (every command in bank `$82` and its argument size). `trace.py` walks every known proc's script and follows the routines it calls and the sprites it creates: 257 more routines. `tools/proc_scripts.py` writes scripts and unlabelled proc headers with the `PROC_*` macros; 61 pieces went in. Command `$82/8279` is `rsProcCodeCreateActiveSprite` (macro `PROC_CREATE_ACTIVE_SPRITE`).
14. **Structural names.** 79 routines used by a single proc as its init or on-cycle routine are `rlProc<Name>Init`/`Cycle…`. The 165 event and event condition command routines are named after the macros the chapter scripts use for them (`rsEventCommandJumpTrue`, `rsChapterEventConditionCommandSaveChapterTurncount`); placeholders such as `EVENT_0A` keep numbers.
15. **Sorting by caller.** 95 sections left `engine/unsorted/` because every routine using them is a *named* routine in one system (repeated until nothing changed). Callers with `Unknown` names did not count, since many were filed by ROM neighbours. `tools/move_sections.py` moves sections between files.

16. **ROM tables.** `tools/rom_tables.py` finds every read of unbuilt ROM data in built code. 130 tables with a certain extent are now source as `aUnknownXXXXXX` (each says which routines read it); 47 more have names only, in `include/Undisassembled.h`. Two blocks turned out to hold code, and decoding them found:
    - **Code checksums.** The game sums `$80/8D56–8E2C` and `$87/8017–80A9` and compares the sums with `aCodeChecksums` (`$8F/8000`) and its copies at the start of banks `$87` and `$88` (`include/Checksums.h`). The third word, "IS", switches the checks on. When `rlCheckCodeChecksums` (in the random number generator) finds a difference, the random numbers come from `rsUnknown80A7F3` instead. There is also a lock-up loop and another copy of the check in bank `$88`. Anyone changing that code has to update the sums.
    - **AI formation offsets.** `$87/DC71` picks one of four routines by `wAIFormationDirection`; each adds a formation pattern offset to a position, turned a quarter turn further (`engine/ai/groups.asm`).
17. **Code sweep.** `tools/sweep.py` decodes gaps that nothing points to and accepts a candidate only if it ends cleanly, has no data-like opcodes, does not branch into itself, calls only known routines or other gaps, does not start like a proc header or pointer table, and scores at least 3 (calls to known routines plus named RAM variables). Alternating with the tracer until nothing new turned up added about 500 routines (about 44 KB), among them the joypad reader (`$80/8002`) and game state setups such as `$80/C39A`. Ten early finds began with data and were repaired by hand. Each swept routine is marked "Found by tools/sweep.py".

18. **Constants, RAM names and struct fields.** Three tools, all of which only swap a number for a name of the same value:
    - `tools/apply_constants.py` with `tools/constant_rules.txt`: a getter's or field's value compared or masked with a number gets the constant family it belongs to (unit states, statuses, character, class and generation IDs, genders, weapon types and ranks, location types, deployment and item states, skill IDs, allegiances). 78 operands.
    - `tools/name_ram.py`: raw RAM addresses get the name `include/` gives that address, nested fields included (from `--dump-labels`). 1,552 operands at first, about 640 more after naming the most-used unknown variables (game state, the acting unit, unit relocation, temporaries). 3,509 raw RAM operands at 825 addresses still have no name; `--report N` lists the most used, and most of the top ones are flag words or map and map battle working values whose meaning needs the debugger.
    - `tools/name_struct_fields.py`: small offsets from an index register become struct fields, using the struct that the register's source points to elsewhere in the code. 64 offsets.
19. **Names in battle, units and items.** About 80 routines, each named from what its code does and how its callers use it: item prices, repair and selling (`rlGetItemBuyPrice`, `rlGetItemRepairCost`, `rlSellInventorySlotItem`, ...), battle rounds and strikes (`rlActionStructBuildBattleRounds`, `rsActionStructResolveStrike`), the 14 target filters behind `rlFindTargetsInRange`, faction-wide unit routines, two divides in `core/math.asm`. Where only the computation is certain, the name says that and the comment says what it is most likely for (`rlGetInventorySlotStaffCostValue`, probably staff experience). Unnamed: battle 16, units 14, items 6. `tools/rename.py` renames labels everywhere and can add a comment.

Every step kept the output identical to the original.

## What remains

### 1. Code and data that remain

- **Below the sweep's threshold**: 264 candidates (about 9.6 KB) score under 3. They are a mix of real code (for example a palette routine at `$88/9EE9`), data that happens to decode, and gaps that start with a few bytes of table. They need reading one by one: `tools/sweep.py --min-score 0 --list`.
- **The 47 tables with names only**: their readers' loops give their lengths. Once a length is known, write the table out and remove its line from `include/Undisassembled.h`.
- **`$8A/CFBE`** (after the 89-pointer table at `$8A/CEB3`) is kept as a ROM slice because it starts in the middle of a routine; find that routine's start.
- **Active sprite and HDMA scripts** lead mostly to visual code; lower priority.
- Check the tables written by `rom_tables.py` against their readers' loops as you name them: a short table followed by code that calls nothing known can still have been taken as one block.

Share of each bank's `$8000`–`$FFFF` half built from source now:

| | | | |
|---|---|---|---|
| `$80`: 28% | `$81`: 58% | `$82`: 34% | `$83`: 99% |
| `$84`: 90% | `$85`: 21% | `$86`: 98% | `$87`: 70% |
| `$88`: 52% | `$89`: 30% | `$8A`: 12% | `$8B`: 19% |
| `$8C`: 1% | `$8D`: 60% | `$8E`–`$8F`: 100% | `$90`: 82% |
| `$91`: 70% | `$95`: 3% | `$9D`: 100% | `$9E`: 31% |

Not every uncovered byte is code; tables, text and graphics are mixed in, and banks `$92`–`$9C` are almost all data.

### 2. Workflow for new code

`tools/disasm.py START > wip/File.asm` (or `tools/trace.py --write wip/File.asm`), then `test_routines.py`, then `place_routines.py`. The disassembler's output has matched the ROM without hand fixes every time so far; what it needs is names and comments. If `--selftest` ever reports a difference after a change to `disasm.py`, fix the tool before using it.

### 3. Data that could become structured source

- The 94-row `aBattleMapSpriteData` (bank `$9E`) and the battle banner table point at compressed graphics that are still ROM slices.
- `aUnknown88CBE8` has one byte per short map sprite (9) and per tall one (14); what the values mean is unknown.

### 4. Naming and understanding

1,981 routines are still unnamed and 1,360 are in `engine/unsorted/`. Automatic sorting by caller has gone as far as named callers allow; the rest are called mostly by other unsorted or unnamed code, so the next step is reading code. Good places to start: the helpers of the now-named event commands (in `engine/events/event_scripts.asm`), the procs named "ON" in bank `$9E` (scripted scenes, one of them `procBelhallaMagesAttack`), and bank `$88` (map scrolling and map sprites). Proc names in headers (two letters, such as "ME" for the proc that PLAY_SONG creates) are small hints. Many routines were filed by their name or their neighbours in the ROM, not by understanding the code. The plan agreed with the user is to name system by system: gather the clues (callees, callers, RAM addresses, hardware registers, data tables, known game mechanics), and confirm uncertain cases by running the game in a debugger (Mesen or bsnes-plus can load `labels.txt`). Names must state only what is known; uncertain routines stay `Unknown` or get a comment saying how sure it is.

Specific things that deserve a look:

- File descriptions were written from routine names and existing comments, not from reading the code. Correct them as understanding improves.
- `engine/menus/map_menu.asm` adds the constant `$027E` in two places. The original author's guess, `size(aDialogueBoxTilemap)-2`, did not match the ROM, and the meaning is unknown.
- In `units/`, `map/` and others, routines placed next to named neighbours are only *probably* related.

### 5. Data and assets

- 14 places still take data directly from the ROM with `ROM[start:end]` (13 in `build.asm`, mostly world map tilemaps and the dialogue font, plus `aDialogueBoxTilemap` in `engine/unsorted/bank85.asm`).
- Banks `$92`–`$9C`, `$9F`–`$AD` and `$B4`–`$BF`, and the lower halves of most banks, are almost entirely compressed graphics, maps, music and similar. The user considers the assets Nintendo's business and wants engine code prioritized. Building the ROM entirely from source would eventually need extractors that read these from the user's own ROM, as the Pokémon disassemblies do.

### 6. Other loose ends

- The Windows `.bat` scripts have updated paths but have not been run since the folder rename.
- `labels.txt`, `log.txt`, the `.dialogue.txt` and `.csv.asm` files, `fe4.sfc` and `FE4Disassembly.sfc` are generated or local, and are ignored by git.

## How to work on this project

- **The ROM decides.** A change is only correct if `./build.sh` still says the output matches. Where work-in-progress source disagrees with the ROM, the source is wrong.
- **Commit in small steps**, each with a matching build.
- **Use the tools.** For new code: `disasm.py` or `trace.py --write` → `test_routines.py` → `place_routines.py`. For hand-written or older work-in-progress code: `test_routines.py` → `fix_addressing.py` → fix the rest by hand with `--diagnose` and `show_lines.py` → `place_routines.py`. The 64tass pitfalls that caused most problems are listed in `tools/README.md`. The ones that came up most:
  - register widths follow source order;
  - `,b` needs a 16-bit operand and does not subtract the data bank;
  - a list label (`.brept`) used without `[0]` silently emits one instruction per entry;
  - struct macros with `None` or missing arguments can emit nothing at all without an error.
- **The user** wants the source to read like a clean reconstruction of the original, organized by game system. They did not write the original disassembly, so explain its conventions instead of assuming familiarity. Do confident, verifiable work; flag judgment calls.
