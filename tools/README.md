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

The files in `wip/` are routines files. Each tool assembles the file in a temporary copy of the repository, so your working tree is only changed where a tool says so.

| Tool | Purpose |
|---|---|
| `test_routines.py FILE` | Assembles each routine at its address and compares it byte for byte with the ROM. Reports assembly errors by line in FILE, which routines differ, and the contiguous runs the routines form. Use `--diagnose` to show the first line in each differing routine whose instruction differs from the ROM, and `--long-branch` to get past branch-range errors while diagnosing. |
| `fix_addressing.py FILE` | Fixes the systematic data bank problems, using the ROM as the reference: declares the data bank after explicit bank switches and where routines are entered with it set, drops `,b` from bank `$7E`/`$7F` operands, and adds `@l` where the original uses long addressing. Prints what is left to fix by hand. |
| `show_lines.py FILE FIRST [LAST]` | Shows source lines next to the bytes they build and the original bytes, marking lines that differ. |
| `place_routines.py FILE SPEC [--remove]` | Once routines match, moves them into engine files as sections, adds them to `build.asm`, and with `--remove` deletes them from FILE. SPEC says which routines go to which file and section. |
| `split_section.py FILE SECTION LABEL NEW_FILE NEW_SECTION` | Moves the end of a section, from LABEL on, into another file without changing the ROM. |
| `asmlib.py` | Shared helpers for the tools above. |

### Typical workflow

1. `tools/test_routines.py wip/File.asm` to see what fails.
2. Fix assembly errors. `tools/fix_addressing.py wip/File.asm` handles the data bank ones; the rest are usually names that do not exist or point at the wrong thing.
3. `tools/fix_addressing.py wip/File.asm` again once it assembles, then `tools/test_routines.py wip/File.asm --long-branch --diagnose` and `tools/show_lines.py` for what is left. The ROM decides: if the source says `trb` and the ROM has `tsb`, the source is wrong.
4. Write a SPEC grouping the matching routines by game system, then run `tools/place_routines.py wip/File.asm SPEC --remove`.
5. Describe any new files (they start with a TODO line), run `./build.sh`, and commit.

### 64tass details that matter here

- Register widths (`.al`/`.as`, `.xl`/`.xs`) carry over in the order 64tass reads the source, not in ROM order. That is why every section states its starting widths; the tools measure them for you.
- `addr,b` means "absolute addressing, with a 16-bit operand". It does not subtract the data bank, so `$7F4418,b` never assembles. Declare `.databank $7F` instead and write the address without `,b`.
- `@l addr` forces long addressing.
- In a `.brept` list of structs, use `.dstruct structName` so that `list[0].field` works. A bare `#<>list` then means one value per entry, and 64tass silently emits the instruction once per entry; write `#<>list[0]`.
