# Fire Emblem 4 Disassembly

A disassembly of *Fire Emblem: Seisen no Keifu* (Japan, version 1.0). It builds a ROM that is byte-for-byte identical to the original.

The project is a work in progress; [STATUS.md](STATUS.md) gives the current state and [PLAN.md](PLAN.md) the roadmap. Every byte of the ROM is built from source; see [Base ROM](#base-rom).

## Building

You need:

* Python 3 with [Pillow](https://pypi.org/project/pillow/) (`pip3 install pillow`), which converts the graphics in `gfx/`.
* [**64tass**](https://sourceforge.net/projects/tass64/). On macOS: `brew install tass64`. On Windows, put `64tass.exe` in `tools/`.
* Zane Avernathy's [**c2a.py**](https://github.com/ZaneAvernathy/FE5Tools/blob/main/c2a.py) and [**process_dialogue.py**](https://github.com/ZaneAvernathy/FireEmblem5/blob/master/TOOLS/process_dialogue.py), in `tools/`.
* A headerless copy of the original ROM named `fe4.sfc` in this directory. It must be 4,194,304 bytes. A copy with a 512-byte copier header (4,194,816 bytes, often named `.smc`) can be fixed with `tail -c +513 original.smc > fe4.sfc`.

### Building (macOS, Linux, and Windows)

```sh
python3 build.py            # build FE4Disassembly.sfc and check it matches fe4.sfc
python3 build.py mod        # build without fe4.sfc and update checksums
python3 build.py coverage   # also report how much of the ROM is built from source
python3 build.py test       # run static checks and tool self-tests (--full for all)
python3 build.py clean      # remove generated files
```

On macOS and Linux, `./build.sh` is a thin wrapper around `python3 build.py`.

`build.py` incrementally converts the dialogue text, CSV tables, palettes, and authored graphics in `gfx/` (`*.png`, `*.scene.json`, `*.csv`, `*.asm`) to assembly/tile data, checks that every included file exists with exactly the spelling used, assembles the ROM and compares its SHA-1 with the original. If they differ, it lists the first differing addresses.

## Layout

| Folder | Contents |
|---|---|
| `build.asm` | The ROM map: which section of code or data goes at which address, plus top-level table/binary placements. |
| `engine/` | Game code, one folder per system (below). |
| `events/` | Event scripts for each chapter. |
| `data/` | Data tables as CSV and `.asm`: characters, classes, items, chapters, palettes, unit groups and more. |
| `text/` | Dialogue and menu text. |
| `gfx/` | Authored graphics sources by system (`portraits/`, `scenes/`, `maps/`, `ui/`, `icons/`, `fonts/`, `map_sprites/`, `map_battle/`, `effects/`, `battle_animation/`) and build plumbing in `gfx/build/`. |
| `audio/` | Extracted SPC700 driver, sequences, BRR samples, sample directories, instruments, and `sound_data.asm`. |
| `include/` | Constants, RAM layout, hardware registers and macros. `include/fe4.h` includes them all. |
| `docs/` | Modding guide (`MODDING_DATA.md`), graphics pipeline plan, subsystem references (`docs/reference/`), and the engine guide (`docs/guide/`). |
| `tools/` | Build helpers, asset compilers, and analysis/disassembly tools. See `tools/README.md`. |
| `wip/` | Disassembled code that is not part of the build yet (empty when nothing is in progress). |

`engine/` is split by game system:

| Folder | Contents |
|---|---|
| `core/` | The proc, DMA, HDMA and active sprite engines; decompression, math, random numbers, fades, RAM structures, the OAM buffer, tilemap buffers and game options. |
| `map/` | Map scrolling, map sprites, input, deployment, the unit and terrain windows, pop-ups, and map locations such as castles and villages. |
| `units/` | Units and their data, classes, stats, level-ups, skills, factions, lovers, turn-start effects, and the move to generation 2 with inheritance. |
| `items/` | Item data and unit inventories. |
| `ai/` | The enemy AI: its main cycle, AI scripts, groups and formations, and choosing targets, attacks and movement. |
| `arena/` | The castle arena ladder and combat loop. |
| `battle/` | Battle calculations, weapon traits, staff effects, battle stats, map battles, map magic effects, and scripted special attacks. |
| `battle_scene/` | The full-screen battle scene engine, scripts, animations, HUD, and results. |
| `castle/` | Castle town facilities: shops, pawn shop, repair, storage, augury, class change, and conversations. |
| `menus/` | Map menus, full-screen status/overview windows, options, revive screen, and menu text. |
| `dialogue/` | The dialogue engine, dialogue boxes, portraits and death quotes. |
| `events/` | The chapter event engine and conditions, the event script interpreter and commands, procs used by events, talk events, event movement and scripted scenes. |
| `worldmap/` | The world map. |
| `title/` | The title screen, opening logo, and title intro scenes. |
| `demo/` | The attract-mode demo battles. |
| `epilogue/` | Choosing and showing each character's epilogue. |
| `save/` | Saving, loading, and the Jugdral history screens. |
| `debug/` | The leftover debug menu. |
| `rankings/` | The end-of-game rankings. |
| `sound/` | Choosing music and communicating with the SPC700 driver. |

### How files relate to ROM addresses

Each file in `engine/` defines one or more named sections, for example `.section LevelUpSection`. `build.asm` places each section at its address with `.dsection`. A file can therefore hold code from several banks, and code can be moved between files without changing the ROM.

Each section starts by stating its register widths (`.al`/`.as`, `.xl`/`.xs`). 64tass tracks register widths in the order it reads the source, so a section must not rely on whatever was assembled before it.

Every routine keeps its original address as a trailing comment, for example `rlGetRandomNumber100 ; 80/A70E`, so it can be found in a debugger. Running a build writes `labels.txt`, a symbol file that debuggers such as Mesen and bsnes-plus can load.

### Built entirely from source

Every byte of the output comes from the source: code, data, the extracted graphics, text and sound in the repository, and explicit `.fill` lines for unused space. The original ROM is only read to compare the result against (`./build.sh`); `./build.sh mod` builds without it. `./build.sh coverage` proves this by building with the original replaced by all-`$00` and all-`$FF` files and checking the output does not change.

## Contributing

Every change must keep the output identical to the original. Run `./build.sh` before each commit. To bring code from `wip/` into the build, see `tools/README.md`.
