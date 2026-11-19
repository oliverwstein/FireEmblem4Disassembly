# Project status

Last updated 2026-11-19. This file records what has been done and what remains, so that work can pick up where it left off. For how to build and how the repository is laid out, see [README.md](README.md). For the tools, see [tools/README.md](tools/README.md).

The goal is source that is **readable and moddable**, in the way Pokemon Polished Crystal is.

- **Readable:** every routine, variable and field named, constants instead of numbers, data in readable formats, organized by game system.
- **Moddable, which means shiftable:** you can add instructions to a routine, lengthen a table or add an entry, and the assembler moves everything after it and updates every reference. Matching the ROM byte for byte does not give this by itself. A byte-identical build can still pin code to fixed addresses, so that any change breaks something far away.

Byte-identical output remains the test for every change to the original layout. Shiftability is what makes it worth building from source.

## Where things stand

- `./build.sh` builds a ROM that is byte-for-byte identical to the original (Japanese 1.0, SHA-1 `90f0bdeaf0151899f96281258fcb30899fbd0d44`).
- **22.13% of the ROM is built from source** (928,031 of 4,194,304 bytes; `./build.sh coverage`). The rest is copied from `fe4.sfc` at build time. Most of what remains is graphics, maps, music and text.
- `engine/` has 102 files with **5,052 routines** and 1,003 data labels. **3,173 routines** still have `Unknown` in their names, and **2,618** are in `engine/unsorted/` (filed by ROM bank, not yet by system).
- In built code, **8,786 operands** still use raw RAM addresses (1,650 distinct addresses, as `tools/name_ram.py --report` counts them; the code brought in from the log added many), and about **8,800** use numbers that may stand for constants.
- `wip/` is empty. `include/Undisassembled.h` names 46 ROM tables that built code reads but whose length is not known yet. No built code calls code that is not built.
- `tools/trace.py` finds nothing left to follow, and `tools/disasm.py --selftest` reassembles all 4,805 routines it can start from to the same bytes, with and without the log's widths.
- **A Mesen code/data log of the prologue** (`fe4.cdl`, analysed by `tools/cdl.py` in [cdl_analysis_report.md](cdl_analysis_report.md)) is fully used: **every byte the prologue executed is built from source** (70,629 executed bytes were not, before the work driven by the log). No table the log shows read is built as code, and no built data is executed. 248 of the routines brought in have no caller in the build yet (marked "Found through fe4.cdl"); they are reached through hidden pointers, data tables or computed jumps.
- **Nothing can move yet.** `build.asm` lays the base ROM down and places 1,351 sections over it at fixed addresses, with ROM bytes in the gaps between them. On top of that, 47 tables are named only (`include/Undisassembled.h`), 31 `ROM[start:end]` slices remain, and 409 `.long` and 36 `jsl`/`jmp` operands in `engine/` are raw addresses. 29 immediates stored into code-pointer variables and 645 long pointers loaded in two halves are still numbers (`tools/code_pointers.py` lists them).

| Stage | Bytes from source | Share |
|---|---|---|
| Starting point | 675,008 | 16.09% |
| AI code and the first pass over TempStuff | 714,327 | 17.03% |
| The rest of TempStuff | 729,236 | 17.39% |
| Tracing calls, definitions and jump tables | 761,454 | 18.15% |
| Proc scripts | 779,634 | 18.59% |
| ROM tables read by built code | 784,109 | 18.69% |
| Code sweep | 828,048 | 19.74% |
| Game state routines, through the emulator log | 863,904 | 20.60% |
| Indexed jump tables and misread tables, through the log | 877,028 | 20.91% |
| Everything else the log shows executed (now) | 928,012 | 22.13% |
| `rlEnableForcedBlank`, found by matching FE5 | 928,031 | 22.13% |

Share of each bank's `$8000`-`$FFFF` half built from source:

| | | | |
|---|---|---|---|
| `$80`: 70% | `$81`: 59% | `$82`: 37% | `$83`: 99% |
| `$84`: 98% | `$85`: 67% | `$86`: 100% | `$87`: 81% |
| `$88`: 81% | `$89`: 73% | `$8A`: 63% | `$8B`: 50% |
| `$8C`: 2% | `$8D`: 61% | `$8E`-`$8F`: 100% | `$90`: 82% |
| `$91`: 86% | `$95`: 80% | `$96`: 67% | `$9B`: 15% |
| `$9D`: 100% | `$9E`: 81% | `$9F`: 16% | |

Not every uncovered byte is code: tables, text, graphics and zero-filled padding are mixed in. Banks `$92`-`$9C` are mostly data, except for the code in `$95` and `$96` (possibly the battle scenes) and some in `$9B`.

## What has been done

Every step kept the output identical to the original.

### Build and layout

- **macOS build.** `build.sh` converts the dialogue and CSV tables, checks include paths (`tools/check_paths.py`), assembles with 64tass and compares the SHA-1. `./build.sh coverage` builds twice more with the base ROM replaced by `$00` and `$FF`; bytes that come out the same come from source.
- **Organized by game system.** `engine/<system>/` files with descriptive section names; `build.asm` is the ROM map that places sections by name. Each section states its starting register widths, because 64tass tracks widths in source order. Folders: `include/`, `data/`, `text/`, `events/`, `gfx/`, `tools/`, `wip/`.

### Bringing code in

- **AI code and TempStuff.** All of the old `wip/AITemp.asm` and `wip/TempStuff.asm` is in the build, after about 100 corrections where the work-in-progress source disagreed with the ROM (list labels without `[0]`, `size()` of a list, wrong data banks, long addressing that 64tass shortened).
- **Disassembler** (`tools/disasm.py`). Turns ROM code into routines in the project's style: follows register widths (taking them from `fe4.cdl` wherever the log shows the code ran, which catches routines that return with other widths than they were called with) and the data bank, never writes bytes the log shows executed as data, gives the return point of `pea #X-1` a local label, uses existing names, writes long-pointer loads with labels, knows the inline arguments of `rlDMAByStruct`, the palette routines and three bank `$9F` routines called with `jsr` (`rsUnknown9F8253`, `rsUnknown9F82D7`, `rsUnknown9F830F`, measured from the log), and treats unreachable bytes inside a routine as data. Its output has matched the ROM without hand fixes every time.
- **Tracer** (`tools/trace.py`). Follows calls and jumps from every built routine, the init and on-cycle routines of proc, HDMA and active sprite definitions, proc scripts (`tools/procs.py` knows every proc command), and jump tables. About 700 routines came in this way, all reached from verified code. `--from-log` also starts from every entry point of executed code in `fe4.cdl`, since the log proves it is code; this brought in the last 50 KB the prologue runs (723 routines). Table entries that point at `$00` are taken as unused slots aimed at padding and are not followed. With the log it also follows `jsr (table,x)` and `jmp (table,x)`: the entries the log shows read whose targets it shows executed. Raw table entries can be `.long $XXXXXX` or `.word $XXXX` (in the table's bank), but a table needs at least one labelled entry, for the widths.
- **Proc scripts** (`tools/proc_scripts.py`). Scripts and unlabelled proc headers are written with the `PROC_*` macros. Command `$82/8279` is `rsProcCodeCreateActiveSprite`.
- **ROM tables** (`tools/rom_tables.py`). Every table that built code reads by raw address got a label: 130 written out with their bytes, 47 named only.
- **Emulator log** (`tools/cdl.py`). Compares a Mesen 2 code/data log with the build. It finds executed code that is not built and the raw pointers that lead to it, built code that is read as tables, built data that is executed, and bulk reads of code. It also gives the read extents of the tables in `Undisassembled.h`, and `--entries` lists every entry point of unbuilt code with the register widths it ran with. The flags are `$01` code, `$02` data, `$04` jump target, `$08` subroutine entry, `$10` 8-bit X and `$20` 8-bit A; the tool checks this against the build each run. The current log covers the prologue only. The hand-written summary at the top of `cdl_analysis_report.md` has the findings.
- **Code sweep** (`tools/sweep.py`). Decodes gaps that nothing points to and accepts a candidate only with evidence: it ends cleanly, has no data-like opcodes, does not branch into itself, calls only known routines or other gaps, does not start like a proc header or pointer table, and scores at least 3 (calls to known routines plus named RAM variables). With the tracer, this added about 500 routines (44 KB). Each is marked "Found by tools/sweep.py". Ten early finds that began with data were repaired by hand.

### Findings worth knowing

- **Code checksums** (`include/Checksums.h`). The game sums `$80/8D56-8E2C` and `$87/8017-80A9` and compares the sums with `aCodeChecksums` (`$8F/8000`) and its copies at the start of banks `$87` and `$88`. The third word, "IS", switches the checks on. When `rlCheckCodeChecksums` finds a difference, the random number generator takes its numbers from `rsUnknown80A7F3` instead. Anyone changing that code has to update the sums. Both ranges are now built from source: `$80/8D56` is `rlReset`, the reset handler (the reset vector points there; the NMI and IRQ vectors point at `rlUnknown8081B6` and `rlUnknown8081FD`). The header and vectors at `$00/FFB0`-`FFFF` still come from the base ROM. **A second check** is not in `Checksums.h` yet: `rlUnknown878017` copies `$88/8888`-`8907` to `$1E00`, and `rlUnknown87802A` compares the copy with the ROM, falling into an endless loop on a difference. The log also shows bulk reads of code at `$88/8888`-`8AC7` and `$82/8888`-`890D` whose reader is not known; they may be further checks.
- **Game states.** Every frame, `rlRunGameStateRoutines` runs the routines at `wGameStateRoutine1` and `wGameStateRoutine2` in `aGameStateRoutines`; `wGameStateStep` counts the steps of the current state. The table's 56 entries are now labels, except four unused ones that point at zero padding (`$9F/FACC`). Following them brought in 459 routines (35,856 bytes), most of them in banks `$95`, `$96`, `$8B` and `$9B`, of which 322 ran in the prologue log. Entries mostly come in threes, and the third often starts `phb / php / phk / plb`.
- **Tables found through the log.** Jump tables `aUnknown8A87F3` (map menu, indexed by `$0893`), `aUnknown89C326` (with the byte table `aUnknown89C32C` that picks its entry), and the two inside `rlUnknown9F8A34` (`_8A6E`, `_8A8F`: eight octant handlers that end in `rsUnknown9F8B24`, which reads the table at `$9F/8B3A`; it looks like an angle calculation). Data tables `aUnknown889BB5` (one byte per terrain type), `aUnknown89A5D1` (tilemap word pairs), `aUnknown899109` (one word per inventory slot), `aUnknown91F7B7` (one word per chapter), `aUnknown879D77`, `aUnknown8AE0C7` and `aUnknown8AE12F`. `rsUnknown808A35` stores X in a run of wR variables by jumping into an unrolled run of `stx`.
- **Code pointers stored by code** (`tools/code_pointers.py`). 159 of the 188 immediates stored into `wVBlankPointer`, `wIRQPointer`, `wMainLoopPointer` and the on-cycle pointers of procs, HDMA and active sprites are labels now, as are four long pointers loaded in two halves. The bank comes from the dispatching code: `$80` for the first three (the NMI and IRQ handlers `jml` into `$80` first), and the header's bank for the on-cycle pointers, settled by the proc or HDMA header that runs the storing routine (its init or on-cycle routine, or a `PROC_CALL` in its script) or else confirmed by `fe4.cdl`. This gave 106 routines a reference; 67 of them lost their "Found through fe4.cdl" comment.
- **Raw call targets.** 786 `jsr`/`jsl`/`jmp`/branch operands that were raw addresses of labelled routines now use the names; 26 are left, where no routine label exists.
- **Labels whose names gave the wrong address**: `rsUnknown84E06C` (at `$84/DC49`) and `procUnknown828AD9` (at `$82/8B09`) are renamed after their addresses.
- **A bug in the original.** `rsUnknown95BD76`, the handler for command `$F7` of `rsUnknown95BB41`, sets an 8-bit accumulator and never sets it back, so it runs into a `brk`. The prologue never runs it. Routines such as `$80/C39A` set up a state (screen off, VBlank and main loop pointers, state indices).
- **Battle.** `rlActionStructBuildBattleRounds` fills `aBattleRoundsData` with strikes; `rsActionStructResolveStrike` resolves one. `rlFindTargetsInRange` picks targets with 14 filters (`aTargetFilterRoutines`).
- **Items.** Buying, selling and repair prices (`rlGetItemBuyPrice`, `rlGetItemSellPrice`, `rlGetItemRepairCost`); Bargain halves them; holy weapons cannot be sold or thrown away.
- **AI formations.** Four routines, one per `wAIFormationDirection`, each turning a formation pattern a quarter turn further.

### Naming

- **Structural names.** Event and event condition commands are named after the macros the chapter scripts use (`rsEventCommandJumpTrue`). Routines that a single proc uses as its init or on-cycle routine are `rlProc<Name>Init`/`Cycle…`. Unknown routines that return with `rts` are `rsUnknown…`.
- **Battle, units and items.** About 80 routines named from what their code does and how callers use it. Where only the computation is certain, the name says that and the comment says what it is most likely for (`rlGetInventorySlotStaffCostValue`, probably staff experience). Left: battle 16, units 13, items 6.
- **From the FE5 disassembly** (`tools/fe5_match.py`, 2026-11-19). FE5 kept FE4's unit window, the sortable unit list, and names its code `UnitWindowFE4...`; the low-level frame and PPU routines are the same code in both games. Matching instruction sequences against FE5's source and an FE5 ROM, then reading each pair, gave 42 names; each routine's comment gives its FE5 name. The unit window is now `engine/menus/unit_window.asm` (banks `$80` and `$8B`, 52 sections); `rlGetJoypadInput`, `rlCopyPPURegisterBuffer`, `rlCopyINIDISPBuffer`, `rlHaltUntilVBlank`, the forced-blank pair and `rsInitPPURegisters` went to `engine/core/`. `rlEnableForcedBlank` (`$80/8248`) was not built before.
- **The unit window, complete.** Every routine and table in `engine/menus/unit_window.asm` is named, including its game state routines `$20`-`$22` (`rlUnitWindowHandleInput` and the rest, moved in from bank `$8B`) and `rlCopyItemIcon`, which shops and status screens also use. Its RAM (`$7F82C7`-`$7F8438`) is named from FE5's code for the same routines; other screens reuse that area, so `tools/name_ram.py` writes those names only in the unit window's file (`SCOPED`). The saved page and sort are `wUnitWindowPage`, `wUnitWindowSortDirection` and `wUnitWindowSortType`. `$7E531B` (`aUnitJoinOrder`) is the list's custom order: sort type 0 sorts by it and swapping two units renumbers it. One FE5 match was wrong: `rsUnknown80CD2E` resembles FE5's `rsUnitWindowMainLoopUpdater` but opens another screen (bank `$89`, game states `$23`-`$25`). Left unproven, in comments: which screens `rlUnitWindowCloseWithLocationReload` and `rlUnitWindowOpenSelectedUnitScreen` lead to, and what the two palettes `rlUnitWindowCopySpritePalette1`/`2` load are for.
- **RAM.** `tools/name_ram.py` writes raw addresses with the names `include/` gives them (about 2,200 operands so far). The most-used unknown variables that could be named with confidence are named: the game state variables, `wActiveUnitDeploymentOffset`, the unit relocation record (`wUnitRelocationDeploymentOffset`, `...Type`, `...LocationID`) and several temporaries.
- **Constants and struct fields.** `tools/apply_constants.py` (rules in `tools/constant_rules.txt`) writes numbers compared with a known getter or field as constants (78 operands); `tools/name_struct_fields.py` writes small offsets from an index register as struct fields (64 offsets).
- **Sorting.** 95 sections left `unsorted/` because every routine using them is a named routine in one system. Callers with `Unknown` names do not count: many were filed by ROM neighbours, and trusting them spread wrong guesses.

## What remains

In rough order of value. Sections 1 and 2 go together, and both serve shiftability; naming (section 3) can go on alongside them.

### 1. Code from the emulator log

The prologue log is used up: everything it shows executed is built, and `tools/cdl.py` reports no misread tables or executed data. What it leaves:

- **Callers for the 248 routines marked "Found through fe4.cdl".** They ran, but nothing in the build reaches them. The immediates stored into code-pointer variables are done (`tools/code_pointers.py`; 67 routines got their caller that way). It leaves 29 stores: 15 point into the middle of a routine (7 at a local label such as `rlUnknown85B9F2._BA09`, 8 at an unlabelled address that ran, such as `$85/943B` inside `rlUnknown859431`), where the routine should be split at the target; 11 point at addresses with no label that the log does not have; `$81/8008` (active sprite) and `$85/957B` have a routine but no header or log to confirm the bank; and `$82/88B2` (`rlUnknown8288B2`, the next on-cycle routine of `procUnknown828865` by its header) is only read as data in the log, which needs a look in Mesen. About 7 KB is reached through long pointers in data tables that are not built yet; bring those tables in. The rest is reached by computed jumps or return addresses pushed on the stack: use Mesen's trace logger with a breakpoint on the routine.
- **Record more of the game** and rerun `tools/cdl.py`, then `tools/trace.py --from-log`: battles with animations on, a chapter or two, shops, the arena, saving and loading, the debug menu. Mesen adds to the same log across sessions. Code no log reaches still needs the static methods.
- **`aDialogueCustomWidthAdjustTable`** ends with `$A3AB`, `$A3D9` and `$A3DD`, which the dialogue engine reads as width-table pointers but which also run as code (the original author's comment says "this isnt a table but a routine"); settle it in Mesen before changing it. `aCodeChecksumRanges` and `aHolyBloodBitfieldTable` hold values that only look like pointers.
- **When re-disassembling built code**, rerun `name_ram.py`, `apply_constants.py` and `name_struct_fields.py` afterwards and check the diff for names that were lost: a fresh disassembly only knows `labels.txt`. Re-disassembling also finds phantom table reads: `aUnknownDBB883` was only "read" by misdecoded inline arguments and is gone from `Undisassembled.h`; others there may be the same.
- **Sweep candidates.** 21 passed the threshold (757 bytes) before the log work; rerun `tools/sweep.py --list`, since much of what it found may now be built.
- **Active sprite and HDMA scripts**: mostly visual code; low priority.

### 2. Shiftability

A region of the ROM can move only when it is **all source**, its sections form **one block that is not pinned**, and **nothing refers to it by raw address**. In order:

1. **Remove raw addresses.**
   - Write the 47 tables in `include/Undisassembled.h` out with their bytes. `cdl_analysis_report.md` gives the read extent of each, as a lower bound; the reader's loop confirms the length. Several were read in full from their first byte (`aUnknown8C9800`, `aUnknown8CDCB0`, `aUnknown899099`, `aUnknown8AA241`).
   - Write the raw `.long`/`.word` pointers and raw `jsl`/`jmp` targets as labels.
   - Replace the 31 `ROM[start:end]` slices with source.
2. **Find the hidden addresses.** The log cannot show these, so they need reading or tooling:
   - Numbers that are really addresses or offsets: `$027E` in `engine/menus/map_menu.asm`, and pointers loaded in halves, such as `lda #$8A00` and `lda #$88E0` into `lRoutineVariable` at `$8A/87FF`. `tools/code_pointers.py` wrote the 4 that land on a label; of the other 645, 524 point at ROM addresses with no label (mostly into tables not written yet, or past the end of a routine: the report names the nearest label below each), 56 at RAM and 65 have no address half within six lines. Each becomes a label as the data it points at is written out.
   - Table lengths written as numbers in loops (`cpx #$0080`).
   - DMA sizes.
   - Return addresses pushed with `pea`.
3. **Handle the integrity checks.** Code in `$80/8D56`-`8E2C`, `$87/8017`-`80A9` and `$88/8888`-`8907` must not change without updating or switching off the checks. Make the build compute the sums from the assembled bytes, as pokecrystal does for its header checksum, and add the second check to `include/Checksums.h`.
4. **Merge sections bank by bank.** Once a bank is all source, its sections can become one block that flows freely. Only the bank start and addresses the hardware fixes (vectors, header) stay pinned. Banks `$86`, `$8E`-`$8F` and `$9D` are already 100% built.
5. **Test it.** For a merged bank: build with a few padding bytes inserted early in the block, run the game in Mesen, and check that it still works. This catches the hidden addresses that step 2 missed.

### 3. Naming and sorting (the bulk of the work)

3,173 unnamed routines, 2,618 of them in `unsorted/`, and 1,650 unnamed RAM addresses. Automatic naming and sorting have gone as far as the evidence allows; from here it is reading code, system by system. Names must state only what is known; uncertain routines stay `Unknown` or get a comment saying how sure it is. Mesen's debugger, which can load `labels.txt`, is the quickest way to confirm a name: break on a routine or watch a RAM address.

- **Main-loop game states** in bank `$80`: the sweep found their setup routines, and naming them gives the rest of the code a structure to hang on.
- **Helpers of the named event commands** in `engine/events/event_scripts.asm`.
- **Map code** in bank `$88` (scrolling, map sprites) and the **"ON" scene procs** in bank `$9E` (scripted scenes; one is `procBelhallaMagesAttack`).
- **The rest of battle, units and items** (35 routines): the harder ones, such as the battle dispatcher `rlUnknown84DC1C` and `structActionStructEntry.Unknown`, whose value 8 makes `rsActionStructResolveStrike` run `rsUnknown84EA37` instead of a normal strike.
- **RAM.** `tools/name_ram.py --report 25` lists the most-used unnamed addresses. The top ones are flag words (`$0788`, `$0D87`, `$08AD`, `$04EA`) and map and map battle working values (`$0778`, `$07DA`, `$07E0`, `$07E6`, `$0792`, `$7F45xx`, `$7F4Cxx`) whose meaning is not clear from the code alone.
- **Constants.** About 8,800 numbers left. Each new getter or field with a known constant family is one line in `tools/constant_rules.txt`. `bBattleRoundFlags` bits `$02` and `$10` are still unknown.
- File descriptions were written from routine names and existing comments; correct them as understanding improves. In `units/`, `map/` and elsewhere, routines placed next to named neighbours are only probably related.
- **Check written tables against their readers' loops** as you name them: a short table followed by code that calls nothing known can have been taken as one block (`aUnknown88ACF1` and `aUnknown91FA27` were).

### 4. Data and assets

- Readable formats for the remaining data: map layouts, menu definitions, portrait tables, and the tables written as `aUnknownXXXXXX`.
- 31 `ROM[start:end]` slices remain, 29 of them in `build.asm` (world map tilemaps, the dialogue font, battle banner graphics).
- Graphics, maps and music: the decompressor is disassembled (`engine/core/decompressor.asm`), so a compressor that reproduces its output byte for byte, a PNG converter and an extraction script are tooling work that can start any time. **A decision for the user:** commit extracted assets, as pokecrystal does, or extract them from each user's own ROM at build time, which keeps Nintendo's assets out of the repository.
- Once everything is source, `build.asm` becomes a pure layout and the `.binary "fe4.sfc"` overlay goes away.

### 5. Documentation

Short explanations of the engines that are understood (procs, the event interpreter, active sprites, AI, battle rounds, the checksums), like pokecrystal's `docs/`.

### 6. Outside resources to look at

- **Fire Emblem 5 disassembly** by Zane Avernathy (github.com/ZaneAvernathy/FireEmblem5, with the VoltEdge library; our `c2a.py` and `process_dialogue.py` come from there). **Looked at 2026-11-19; see "From the FE5 disassembly" above for what it gave.** What is known about using it:
  - It disassembles about 960 routines, mostly FE5's own windows, menus, AI and events. The engine both games share (procs, DMA, decompression, active sprites) is only declared there by address (285 names), so code matching reaches those only with an FE5 ROM. The ROM is LoROM (`$BB/AAAA` is at file offset `(BB & $7F) << 15 | (AAAA & $7FFF)`); the Nintendo Power dump has the code at the disassembly's addresses although its SHA-1 differs.
  - Many names are the same as ours (`rlProcEngineCreateProc`, `aProcSystem.wInput0`): this project's original author borrowed them. Where both name a routine, battle code differs a lot between the games; low-level code is identical.
  - Leads `tools/fe5_match.py` reports and that are not applied yet: `rlUnknown809C7A` = `rlRunTaskMainLoops` (identical; FE5's "task" is our game state, `rlRunGameStateRoutines` = `rlRunCurrentTask`), and `rlUnknown809BEE` = `rlProcEngineReset` (0.93). Two other screens share the unit window's layout and RAM and are the obvious next ones: `$8B/CF0A`-`D7BD` (game states `$2C`-`$31`) and the one `rsUnknown80CD2E` opens (bank `$89`).
  - RAM does not line up: our low page sits a few bytes off FE5's and the engine blocks moved (`aProcSystem` is `$0EC8` here, `$0526` there). Names do come over operand by operand from routines that are the same code: aligning the instructions of matched routines gave the unit window's RAM (a scratch script for now; worth folding into `tools/fe5_match.py`).
  - Its proc engine has 38 script commands; ours has the 12 `tools/procs.py` knows, so the rest are FE5 additions.
  - Neither repository has a licence file. Names are used here; FE5's comments are not copied (ours are written fresh), unless the author agrees.
- **Lil' Nordion**, the FE4 modding base that Project Naga's README points to for "documentation and modding files". Not looked at yet; may have notes on routines, RAM and data formats.
- **Project Naga build files** (github.com/Miacidae/Project-Naga-beta-v7, looked at 2026-11-19). No code or RAM names. The repository has no license file, but the user reports that Project Naga was turned over to the community to be used at will, so its files may be used. The English dialogue shows what each event and scene is; menu text is pre-rendered 2bpp tiles placed by tilemaps; about 84 addresses in the original ROM are labelled (intro, attract mode, genealogy wheel, world map, menu tilemaps, pointers such as `$0D/AD70`); and their macro shows `rlUnknown89BECC` draws a run of two-row tiles into the BG3 tilemap (size in `wR0`, base tile in `wR1`, tile in `wR2`), which matches the code.

### 7. Loose ends

- The Windows `.bat` scripts have updated paths but have not been run since the folder rename.
- `engine/menus/map_menu.asm` adds the constant `$027E` in two places. The original author's guess, `size(aDialogueBoxTilemap)-2`, did not match the ROM, and the meaning is unknown. It is probably an offset that will break when things move (see section 2).
- `labels.txt`, `log.txt`, the `.dialogue.txt` and `.csv.asm` files, `fe4.sfc` and `FE4Disassembly.sfc` are generated or local, and are ignored by git.

## How to work on this project

- **The emulator log is tied to the original ROM.** `fe4.cdl` describes the original bytes at their original addresses. Renaming, relabelling and anything else that keeps the build identical leaves it valid: rerun `tools/cdl.py`, no new recording needed. Once the output changes (a mod, a shifted bank), record logs from the original ROM only.
- **The ROM decides.** A change is only correct if `./build.sh` still says the output matches. Where work-in-progress source disagrees with the ROM, the source is wrong.
- **Commit in small steps**, each with a matching build.
- **New code:** `tools/disasm.py`, `trace.py --write` or `sweep.py --write` into `wip/`, then `test_routines.py`, then `place_routines.py`. If `disasm.py --selftest` ever reports a difference after a change to the disassembler, fix the tool first.
- **Naming:** `tools/rename.py` renames labels everywhere and can add a comment; `move_sections.py` moves sections between files. After naming RAM or adding constants, rerun `name_ram.py`, `apply_constants.py` and `name_struct_fields.py`, which only ever swap a number for a name of the same value.
- **Check what automatic tools write.** They can take data for code or code for data at the edges of a block: look for proc headers (a 2-letter name such as "ON" decodes as `eor long`), pointer tables, and tables that end in `rts`.
- **64tass pitfalls** (more in `tools/README.md`): register widths follow source order; `,b` needs a 16-bit operand and does not subtract the data bank; a `.brept` list label used without `[0]` silently emits one instruction per entry; struct macros with `None` or missing arguments can emit nothing at all.
- **The user** did not write the original disassembly, so explain its conventions instead of assuming familiarity. Do confident, verifiable work, and flag judgment calls.
