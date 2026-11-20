# Tools

Run all of these from the repository root, next to `build.asm` and `fe4.sfc`.

## Build helpers

| Tool | Purpose |
|---|---|
| `c2a.py`, `process_dialogue.py` | Convert CSV tables and dialogue text to assembly (download them; see the main README). |
| `FE4c2a.py` | Converts the character and item data tables. |
| `check_paths.py` | Checks that every included file exists with exactly the spelling used. `build.sh` runs it. |
| `merge_bank.py BANK` | Removes the pins (`* =` and `.logical`) of every block in a bank of `build.asm` that starts exactly where the block before it ends, so the bank's code flows as one block. Lists the pins that stay and why (a gap not built from source, or other code between them). A free run of `$00`/`$FF` from the merged block to the bank end becomes `.fill <bank end> - *`, so the block can grow into it, and old `; 84/XXXX` end comments in the block are dropped. `--dry-run` only lists. The output does not change; run `./build.sh`. |
| `pad_test.py` | The padding test, run as `./build.sh pad SECTION N`: builds `FE4Padded.sfc` with N bytes of `$EA` (NOP) inserted at the start of SECTION in a temporary copy, and checks that the block (the sections between that `* =` and its `.here` in `build.asm`) moved cleanly: room to grow after it (or a `.fill` to the bank end that absorbs the bytes), every label in it moved by N and none outside it, which bytes elsewhere changed (references the assembler updated), calls into the block (`jsl`/`jml`, and `jsr`/`jmp` from the same bank) from bytes not built from source, which cannot move with it (a problem if `fe4.cdl` shows they ran; matches in the lower half of a bank or past bank `$9F`, where the game keeps only data, are listed apart), long pointers into the block (low, high, bank) in unbuilt bytes in the code banks' upper halves (a problem unless listed in `NOT_POINTERS`, the matches checked by hand and found to be chance), six-digit numbers in the source that are addresses in the block (`jml $84F889`: built, but they do not move), and nothing changed in the code the game checksums. It fixes the header checksum. Hidden addresses (numbers that are really addresses) only show when you run the ROM: `open -a Mesen FE4Padded.sfc`. |

## Bringing new code into the build

These tools work on a *routines file*: disassembled routines in the usual style, each starting with a top-level label and its address:

```
      rsAIEngineSetupCycle ; 86/9D75

        .al
        .autsiz
        .databank ?

        lda wActiveFactionSlot,b
        ...
```

A label with a directive on the same line counts too (`      aTable .word 1, 2 ; 85/8000`). Everything from one routine's label up to the next label belongs to that routine and moves with it, so keep unrelated notes out of the space after the last routine in a file.

The files in `wip/` are routines files. Each tool assembles the file in a temporary copy of the repository, so your working tree is only changed where a tool says so.

| Tool | Purpose |
|---|---|
| `disasm.py START [END]` | Disassembles code from the ROM into a routine in the project's style, following register widths and the data bank and using existing names. Where `fe4.cdl` shows an instruction ran, it takes the widths from the log, never writes those bytes as data, and labels the return point of `pea #X-1` (`--no-log` to turn this off). Without END it stops where the routine ends. `--selftest` checks it against every routine already in the build. |
| `trace.py` | Follows calls, jumps, engine definitions, proc scripts and pointer tables from every built routine into code that is not built yet, and disassembles what it finds. With `fe4.cdl` it also follows `jsr (table,x)`/`jmp (table,x)` through the entries the log shows used. `--from-log` also starts from every entry point of executed code in the log. A routine found inside another (a second table entry into the same code) is written as a local label of the outer one (`outer._XXXX`). Tables that built code jumps through are followed even when none of their entries is built yet; words below `$8000` and `$FFFF` in a table are unused slots. `--list` shows each routine with a caller and warnings; `--write FILE` writes them as a routines file. |
| `proc_scripts.py FILE` | Writes proc scripts and unlabelled proc headers that are not built yet as a routines file, using the `PROC_*` macros. `procs.py` holds the script format it and `trace.py` use. |
| `move_sections.py SPEC` | Moves whole sections between engine files (SPEC lines: section name, target file). Cannot change the ROM. |
| `rom_tables.py FILE` | Labels the unbuilt ROM tables that built code reads: writes those with a certain extent to FILE and names the rest weakly in `include/Undisassembled.h`. |
| `sweep.py` | Decodes gaps in the code banks that nothing points to and writes the candidates with enough evidence (`--min-score`, default 3) to a routines file. |
| `cdl.py [CDL]` | Compares a Mesen code/data log (`fe4.cdl`) with the build: executed code that is not built and the raw pointers that lead to it, built code read as tables, built data that is executed, bulk reads of code, and the read extents of the tables in `include/Undisassembled.h`. `--report FILE` writes Markdown (keeping hand-written text above its marker line); `--entries FILE` lists the entry points of unbuilt code with their register widths. |
| `code_pointers.py` | Writes raw code pointers stored into the variables the engines jump through (`wVBlankPointer`, `wIRQPointer`, `wMainLoopPointer` and the on-cycle routines of procs, HDMA and active sprites) as `<>label`. The target bank comes from the dispatching code: `$80` for the first three, the header's bank for the rest, settled by the header that runs the storing routine or else confirmed by `fe4.cdl`. It also writes long pointers loaded in two halves (`lda #$8A00 / sta lR18+1` with `lda #$88E0 / sta lR18`) as `` #(`label)<<8 `` and `#<>label` where exactly one label is at the full address. Reports every store it leaves and why; `--write` applies it and clears the "nothing reaches this" comments of the routines that now have a reference. |
| `decompress.py` | The game's decompressor (`rlDecompressor`) in Python: `tools/decompress.py ADDR ...` prints each stream's compressed and decompressed length and where it ends (`--hex`, `--out FILE` for the output); as a module, `decompress(rom, addr)` returns `(data, end)`. Use it to measure compressed blocks when carving them into labelled slices. `--self-test` checks it against the streams in `gfx/` and the portraits. |
| `carve.py` | Carves what a pointer table points at into labelled source: `tools/carve.py TABLE --type TYPE --name NAME [--dir DIR] [--end ADDR] [--write]`. TABLE is a label followed by `.long` lines, or a pointer CSV. TYPE says how long each target is: `dialogue` (to its EOF, written as text files under `text/dialogue/DIR`), `compressed` (measured by `decompress.py`), `fixed:N`, or `next` (to the next target); the last three are written as `.text ROM[...]` slices, split where they cross a bank half. Gaps between targets are decoded as more of the same where they fit exactly (named `NAMEUnknownADDR`), else become `aUnknownADDR` slices. Without `--write` it reports the runs and any problems (a target that runs into the next, overlaps with source); with it, it writes the blocks into `build.asm`, rewrites the table with the labels, replaces raw six-digit numbers in the source that point into the blocks or the table (as `label+N`), and builds. |
| `dialogue.py` | Decodes dialogue in the ROM into the text format `process_dialogue.py` reads, so that it converts back to the same bytes: `tools/dialogue.py ADDR ...`; as a module, `Decoder().decode(rom, addr[, end])`. It leaves out the font page switches the encoder puts back by itself and writes the others as `{DIALOGUE_FONT_n}`, and writes arguments as the existing files do (portraits, characters, labels for pointers). `--self-test` decodes all the dialogue in the build from the ROM and rebuilds with it. |
| `portraits.py` | Exports the portraits as PNG: `tools/portraits.py OUT_DIR [--ids 00,B9-F2] [--scale N] [--tiles]` writes `PortraitXX.png` (the 48x64 face, assembled the way `rsDialogueLoadPortraitWriteTilemap` does it, coloured with the entry's palette), `sheet.png` with them grouped from the game's tables (playable, named units, dialogue only, class cards, not used) and labelled with their users, and `portraits.txt` listing each entry's group, users and the entries that share its graphics; `--tiles` also writes the 64 tiles as stored. A visual check of the decompressor and the palettes, and the start of a PNG round trip (which still needs a compressor). Needs Pillow. |
| `fe5_match.py FE5_DIR [--rom FE5_ROM]` | Matches our routines with the ones the FE5 disassembly names, by their instruction sequences (mnemonic and addressing mode, so relocation and names do not matter), from both sources and, with an FE5 ROM, from both ROMs. `--range` aligns runs of code FE5 kept in the same order. Leads only: read both routines before renaming. Neither the FE5 checkout nor its ROM belongs in the repository. |
| `apply_constants.py` | Writes numbers as constants by the rules in `constant_rules.txt`. |
| `name_ram.py` | Writes raw RAM addresses with the names `include/` gives them. |
| `name_struct_fields.py` | Writes small offsets from an index register as struct fields. |
| `rename.py FILE` | Renames labels everywhere, optionally adding a comment to the routine. |
| `test_routines.py FILE` | Assembles each routine at its address and compares it byte for byte with the ROM. Reports assembly errors by line in FILE, which routines differ, and the contiguous runs the routines form. Use `--diagnose` to show the first line in each differing routine whose instruction differs from the ROM, and `--long-branch` to get past branch-range errors while diagnosing. |
| `fix_addressing.py FILE` | Fixes the systematic data bank problems, using the ROM as the reference: declares the data bank after explicit bank switches and where routines are entered with it set, drops `,b` from bank `$7E`/`$7F` operands, and adds `@l` where the original uses long addressing. Prints what is left to fix by hand. |
| `show_lines.py FILE FIRST [LAST]` | Shows source lines next to the bytes they build and the original bytes, marking lines that differ. |
| `place_routines.py FILE SPEC [--remove]` | Once routines match, moves them into engine files as sections, adds them to `build.asm`, and with `--remove` deletes them from FILE. SPEC says which routines go to which file and section. |
| `jump_tables.py` | Lists every `jsr`/`jmp (addr,x)` in the build whose table is still base-ROM bytes, with each table's entries (`*` marks targets not built); the length comes from a `cmp #N` bound or from where the table runs into its first target. `--write FILE` writes the tables as a routines file plus a `.spec` that files each beside its jump: labelled targets by name, the rest as raw words, which `trace.py` follows. After placing them, `--fix` points the jumps at the new labels and replaces raw entries whose targets now have labels. Check the entry counts before writing; `--count ADDR=N` overrides a wrong guess (a parallel table right after the jump table, for example) and `--skip ADDR` leaves one out. |
| `split_section.py FILE SECTION LABEL NEW_FILE NEW_SECTION` | Moves the end of a section, from LABEL on, into another file without changing the ROM. |
| `asmlib.py` | Shared helpers for the tools above. |

### Typical workflow

0. For code that has never been disassembled, `tools/disasm.py START > wip/File.asm` (add `--m8`/`--x8` if the routine starts with 8-bit registers). Its output normally matches the ROM straight away; what it needs is names and comments.
1. `tools/test_routines.py wip/File.asm` to see what fails.
2. Fix assembly errors. `tools/fix_addressing.py wip/File.asm` handles the data bank ones; the rest are usually names that do not exist or point at the wrong thing.
3. `tools/fix_addressing.py wip/File.asm` again once it assembles, then `tools/test_routines.py wip/File.asm --long-branch --diagnose` and `tools/show_lines.py` for what is left. The ROM decides: if the source says `trb` and the ROM has `tsb`, the source is wrong.
4. Write a SPEC grouping the matching routines by game system, then run `tools/place_routines.py wip/File.asm SPEC --remove`.
5. Describe any new files (they start with a TODO line), run `./build.sh`, and commit.

### 64tass details that matter here

- Register widths (`.al`/`.as`, `.xl`/`.xs`) carry over in the order 64tass reads the source, not in ROM order. That is why every section states its starting widths; the tools measure them for you.
- `addr,b` means "absolute addressing, with a 16-bit operand". It does not subtract the data bank, so `$7F4418,b` never assembles. Declare `.databank $7F` instead and write the address without `,b`.
- `@l addr` forces long addressing.
- A label declared as a list (`.brept`) stands for every entry: `lda #<>list` silently emits one instruction per entry. Write `list[0]` for the base address. This caused several mismatches in the wip code (`aAIUnitList`, `aMovingMapSpriteData`, `aSave.aFactionEntryOffsets`).
- In a `.brept` list of structs, use `.dstruct structName` (not the `.structName` shorthand) so that `list[0].field` works.
- A struct macro given `None` for a field emits nothing for it, and `.structX` calls with missing arguments can emit nothing at all without an error. If a routines file reports "no bytes emitted" for data, check those first.
