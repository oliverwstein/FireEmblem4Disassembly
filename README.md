# Fire Emblem 4 Disassembly

A disassembly of *Fire Emblem: Seisen no Keifu* (Japan, version 1.0). It builds a ROM that is byte-for-byte identical to the original.

The project is a work in progress; [STATUS.md](STATUS.md) gives the current state and [PLAN.md](PLAN.md) the roadmap. Every byte of the ROM is built from source; see [Base ROM](#base-rom).

## Building

You need:

* Python 3 with [Pillow](https://pypi.org/project/pillow/) (`pip3 install pillow`), which converts the graphics in `gfx/`.
* [**64tass**](https://sourceforge.net/projects/tass64/). On macOS: `brew install tass64`. On Windows, put `64tass.exe` in `tools/`.
* Zane Avernathy's [**c2a.py**](https://github.com/ZaneAvernathy/FE5Tools/blob/main/c2a.py) and [**process_dialogue.py**](https://github.com/ZaneAvernathy/FireEmblem5/blob/master/TOOLS/process_dialogue.py), in `tools/`.
* A headerless copy of the original ROM named `fe4.sfc` in this directory. It must be 4,194,304 bytes. A copy with a 512-byte copier header (4,194,816 bytes, often named `.smc`) can be fixed with `tail -c +513 original.smc > fe4.sfc`.

### macOS and Linux

```sh
./build.sh            # build FE4Disassembly.sfc and check it matches fe4.sfc
./build.sh coverage   # also report how much of the ROM is built from source
./build.sh clean      # remove generated files
```

`build.sh` converts the dialogue text and CSV tables to assembly and the indexed PNGs in `gfx/` (`NAME.4bpp.png`) to tile data, checks that every included file exists with exactly the spelling used, assembles the ROM and compares its SHA-1 with the original. If they differ, it lists the first differing addresses.

### Windows

1. Optionally run `cleardialogueAll.bat` to remove old `.dialogue.txt` files.
2. Run `dialoguebuilderAll.bat` to convert the dialogue text files in `text/` to `.dialogue.txt` files.
3. Run `tablebuilder.bat` to convert the `.csv` files in `data/` to `.csv.asm` files.
4. Run `build.bat` to build `FE4Disassembly.sfc`; it converts the PNGs in `gfx/` first. If no ROM is produced, see `log.txt`.

## Layout

| Folder | Contents |
|---|---|
| `build.asm` | The ROM map: which section of code or data goes at which address. It contains no code itself. |
| `engine/` | Game code, one folder per system (below). |
| `events/` | Event scripts for each chapter. |
| `data/` | Data tables as CSV: characters, classes, items, chapters, unit groups and more. |
| `text/` | Dialogue and menu text. |
| `gfx/` | Extracted graphics. |
| `include/` | Constants, RAM layout, hardware registers and macros. `include/fe4.h` includes them all. |
| `tools/` | Build helpers, and tools for testing new code against the ROM and moving it into the build. See `tools/README.md`. |
| `wip/` | Disassembled code that is not part of the build yet (empty when nothing is in progress). |

`engine/` is split by game system:

| Folder | Contents |
|---|---|
| `core/` | The proc, DMA, HDMA and active sprite engines; decompression, math, random numbers, fades, RAM structures, the OAM buffer, tilemap buffers and game options. |
| `map/` | Map scrolling, map sprites, input, deployment, the unit and terrain windows, pop-ups, and map locations such as castles and villages. |
| `units/` | Units and their data, classes, stats, level-ups, skills, factions, lovers, turn-start effects, and the move to generation 2 with inheritance. |
| `items/` | Item data and unit inventories. |
| `ai/` | The enemy AI: its main cycle, AI scripts, groups and formations, and choosing targets, attacks and movement. |
| `battle/` | Battle calculations, weapon traits and staff effects, battle stats and scripted special attacks. |
| `menus/` | Map menus and menu text. |
| `dialogue/` | The dialogue engine, dialogue boxes, portraits and death quotes. |
| `events/` | The chapter event engine and conditions, the event script interpreter and commands, procs used by events, talk events, event movement and scripted scenes. |
| `worldmap/` | The world map. |
| `epilogue/` | Choosing and showing each character's epilogue. |
| `save/` | Saving and loading. |
| `debug/` | The leftover debug menu. |
| `rankings/` | The end-of-game rankings. |
| `sound/` | Choosing music. |

### How files relate to ROM addresses

Each file in `engine/` defines one or more named sections, for example `.section LevelUpSection`. `build.asm` places each section at its address with `.dsection`. A file can therefore hold code from several banks, and code can be moved between files without changing the ROM.

Each section starts by stating its register widths (`.al`/`.as`, `.xl`/`.xs`). 64tass tracks register widths in the order it reads the source, so a section must not rely on whatever was assembled before it.

Every routine keeps its original address as a trailing comment, for example `rlGetRandomNumber100 ; 80/A70E`, so it can be found in a debugger. Running a build writes `labels.txt`, a symbol file that debuggers such as Mesen and bsnes-plus can load.

### Built entirely from source

Every byte of the output comes from the source: code, data, the extracted graphics, text and sound in the repository, and explicit `.fill` lines for unused space. The original ROM is only read to compare the result against (`./build.sh`); `./build.sh mod` builds without it. `./build.sh coverage` proves this by building with the original replaced by all-`$00` and all-`$FF` files and checking the output does not change.

## Contributing

Every change must keep the output identical to the original. Run `./build.sh` before each commit. To bring code from `wip/` into the build, see `tools/README.md`.
