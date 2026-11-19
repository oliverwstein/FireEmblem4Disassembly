# Project status

Last updated 2026-11-18. This file records what has been done and what remains, so that work can pick up where it left off. For how to build and how the repository is laid out, see [README.md](README.md). For the tools used to bring new code into the build, see [tools/README.md](tools/README.md).

## Where things stand

- `./build.sh` builds a ROM that is byte-for-byte identical to the original (Japanese 1.0, SHA-1 `90f0bdeaf0151899f96281258fcb30899fbd0d44`).
- **17.22% of the ROM is built from source** (722,072 of 4,194,304 bytes; `./build.sh coverage`). The rest is copied from `fe4.sfc` at build time.
- Engine code is organized by game system under `engine/` (95 files, about 3,200 routines). About 960 routines are still named `rlUnknown…`/`rsUnknown…`, including nearly all 423 in `engine/unsorted/`.
- `wip/` holds one file, `TempStuffNeedsWork.asm`, with 16 routines and one unlabelled data block that are disassembled but not yet in the build (see below).

| Stage | Bytes from source | Share |
|---|---|---|
| Starting point (before this work) | 675,008 | 16.09% |
| After adding the AI code | 687,588 | 16.39% |
| After the first pass over TempStuff | 714,327 | 17.03% |
| Now | 722,072 | 17.22% |

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

Every step kept the output identical to the original.

## What remains

### 1. What is left in `wip/TempStuffNeedsWork.asm`

Each starts with a `; NEEDS WORK` comment giving the error it produced. Run `tools/test_routines.py wip/TempStuffNeedsWork.asm` to see the current errors.

| Item | Problem | Likely approach |
|---|---|---|
| `rsUnknown81AD8E` | Branches out of range | Probably a list used as a base address (see the pitfalls below), making an instruction repeat. Check with `show_lines.py --long-branch`. |
| `rlGetFatherUnitsChildrenRAMPointers` | Branch out of range | As above. |
| `rlFillItemsOwnerAndSlotData` | `aItems` is not a field; branch out of range | Find the right field of `structInventoryDataBuffer`; the branch problem probably follows from it. |
| `rsUnknown81B270` | `aProcSystem.wSelectedUnitDataRAMPointer` does not exist | Probably plain `wSelectedUnitDataRAMPointer`; check against the ROM. |
| `rlUnknown8780F9` | `structMapMenu.Unknown4` does not exist | Find the field at that offset in `include/Menus.h`. |
| `rlEventMovementBuildTargetDistanceMap` | `wUnknown7EC4A4` is not defined | Add it to `include/WRAM.h` (it sits next to `aEventMovement`'s buffers). |
| `rlFillEventMovementMoveCostMap` | Data bank errors on `aEventMovement.aMovementCostMap,y` | The nearest `.databank` is set to something other than `?`, so the fixer skips it; set it by hand. |
| `rlEventMovementCreateMovementScriptFromTargetDistanceMap`, `aEventMovementDirectionLookupTable` | `MAP_UP` etc. are macros (segments), used here as numbers | Define numeric constants for the map-script command codes, or emit the bytes. |
| `aItemObtainedText` | Japanese text with a full-width space | Needs the game's text encoding for `.text`; see how `text/` dialogue is encoded. |
| `rlProcUnknown8AE199Init` | `len(Palette)` on a struct | Use `size(Palette)` or the actual byte count. |
| `aBelhallaAttackingMagePositions` | `pack([4, 50])` gives values too large for `.byte` | Work out the real packing from the ROM bytes. |
| `aASMapSpriteCode`, `rlUnknown88C4D9`, `aUnknown88CBE8`, `aBattleMapSpriteData` | Content is still raw bytes or half-converted code in comments | Disassemble them properly; `show_lines.py` and the ROM bytes are the reference. |
| Battle banner graphics and pointer table (no label) | Bank `$9C` data written after `rsUnknown959A4D` with no address label | Give each piece a label with its address; the graphics are `ROM[...]` slices. |

Once an item matches, write a short spec and run `tools/place_routines.py wip/TempStuffNeedsWork.asm SPEC --remove`.

### 2. Calls into code that is not disassembled

`include/Undisassembled.h` lists the 19 routines that built code calls but that are not in the build yet. 16 are the needs-work items above. The other three are not disassembled anywhere: `rlUnknown85AB3F`, `rlDrawMenuTextLine` (`$879354`) and `rlDrawMenuTextNumber` (`$89A18C`). These are natural starting points for new disassembly.

### 3. Code that has never been disassembled

Share of each bank's `$8000`–`$FFFF` half built from source, which is where code lives in this HiROM layout:

| | | | |
|---|---|---|---|
| `$80`: 19% | `$81`: 56% | `$82`: 30% | `$83`: 99% |
| `$84`: 83% | `$85`: 7% | `$86`: 95% | `$87`: 53% |
| `$88`: 14% | `$89`: 29% | `$8A`: 9% | `$8B`: 18% |
| `$8C`: 0% | `$8D`: 59% | `$8E`–`$8F`: 100% | `$90`: 81% |
| `$91`: 67% | `$95`: 1% | `$9E`: 10% | `$9F`: 1% |

Banks `$80`, `$82`, `$85` and `$88`–`$8C` contain known code, so their low coverage is mostly undisassembled engine code: menus, map handling, battle animations and more. Bank `$80` holds the core loop and interrupt handlers. Not every uncovered byte is code; tables and data are mixed in.

A useful next tool would be a **code tracer**. It would start from the reset/NMI/IRQ vectors, every known routine and the jump tables, follow branches, and separate code from data. That would give an exact list of undisassembled routines per bank. Then: disassemble into a `wip/` file, and use the same test, fix and place workflow.

### 4. Naming and understanding

About 960 routines are still unnamed. Many routines were filed by their name or their neighbours in the ROM, not by understanding the code. The plan agreed with the user is to name system by system: gather the clues (callees, callers, RAM addresses, hardware registers, data tables, known game mechanics), and confirm uncertain cases by running the game in a debugger (Mesen or bsnes-plus can load `labels.txt`). Names must state only what is known; uncertain routines stay `Unknown` or get a comment saying how sure it is.

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
- **Use the tools.** For new code: `test_routines.py` → `fix_addressing.py` → fix the rest by hand with `--diagnose` and `show_lines.py` → `place_routines.py`. The 64tass pitfalls that caused most problems are listed in `tools/README.md`. The ones that came up most:
  - register widths follow source order;
  - `,b` needs a 16-bit operand and does not subtract the data bank;
  - a list label (`.brept`) used without `[0]` silently emits one instruction per entry;
  - struct macros with `None` or missing arguments can emit nothing at all without an error.
- **The user** wants the source to read like a clean reconstruction of the original, organized by game system. They did not write the original disassembly, so explain its conventions instead of assuming familiarity. Do confident, verifiable work; flag judgment calls.
