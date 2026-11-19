# Tools

Run all of these from the repository root, next to `build.asm` and `fe4.sfc`.

## Build helpers

| Tool | Purpose |
|---|---|
| `c2a.py`, `process_dialogue.py` | Convert CSV tables and dialogue text to assembly (download them; see the main README). |
| `FE4c2a.py` | Converts the character and item data tables. |
| `check_paths.py` | Checks that every included file exists with exactly the spelling used. `build.sh` runs it. |

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
| `disasm.py START [END]` | Disassembles code from the ROM into a routine in the project's style, following register widths and the data bank and using existing names. Without END it stops where the routine ends. `--selftest` checks it against every routine already in the build. |
| `trace.py` | Follows calls, jumps, engine definitions, proc scripts and jump tables from every built routine into code that is not built yet, and disassembles what it finds. `--list` shows each routine with a caller and warnings; `--write FILE` writes them as a routines file. |
| `proc_scripts.py FILE` | Writes proc scripts and unlabelled proc headers that are not built yet as a routines file, using the `PROC_*` macros. `procs.py` holds the script format it and `trace.py` use. |
| `move_sections.py SPEC` | Moves whole sections between engine files (SPEC lines: section name, target file). Cannot change the ROM. |
| `test_routines.py FILE` | Assembles each routine at its address and compares it byte for byte with the ROM. Reports assembly errors by line in FILE, which routines differ, and the contiguous runs the routines form. Use `--diagnose` to show the first line in each differing routine whose instruction differs from the ROM, and `--long-branch` to get past branch-range errors while diagnosing. |
| `fix_addressing.py FILE` | Fixes the systematic data bank problems, using the ROM as the reference: declares the data bank after explicit bank switches and where routines are entered with it set, drops `,b` from bank `$7E`/`$7F` operands, and adds `@l` where the original uses long addressing. Prints what is left to fix by hand. |
| `show_lines.py FILE FIRST [LAST]` | Shows source lines next to the bytes they build and the original bytes, marking lines that differ. |
| `place_routines.py FILE SPEC [--remove]` | Once routines match, moves them into engine files as sections, adds them to `build.asm`, and with `--remove` deletes them from FILE. SPEC says which routines go to which file and section. |
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
