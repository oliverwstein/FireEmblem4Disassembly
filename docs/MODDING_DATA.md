# Modding ROM Data: Layout, Formats & Headroom

This guide summarizes where editable ROM data lives, how build-time generators work, and where bank-size limits apply when expanding content.

## 1. Where Data Lives

| Domain | Location | Format |
|---|---|---|
| Characters, classes, items, terrain, love | [data/](../data/) | CSVs (`c2a.py` / `FE4c2a.py`) and `.asm` tables |
| Portraits (pointers & palettes) | [data/portraits/](../data/portraits/) | CSV pointer tables + `bgr555()` palette `.asm` |
| Palettes (UI, backgrounds, battle) | [data/palettes/](../data/palettes/) | `.asm` using `bgr555(r, g, b)` from [include/Palettes.h](../include/Palettes.h) |
| Chapter unit groups (`UNIT`) | [data/eventunit/](../data/eventunit/) | CSVs using `include/Deployment.h` constants (`UNITEntryEnd`, `UNITFormationNone`) |
| Chapter events & castle/arena tables | [events/](../events/) | Macro-driven `.asm` per chapter |
| Dialogue & menu text | [text/dialogue/](../text/dialogue/), [text/menutext/](../text/menutext/) | `.txt` (`process_dialogue.py`) and Shift-JIS `.asm` |
| Graphics & tilemaps | [gfx/](../gfx/) | Indexed `.4bpp.png` / `.2bpp.png`, `.bin`, and compressed streams in `gfx/build/` (authored sources by system in `gfx/`; see [AUTHORING_GRAPHICS_PLAN.md](AUTHORING_GRAPHICS_PLAN.md)) |
| Audio | [audio/](../audio/) | Sequence `.bin`, BRR `.brr`, directory/instrument `.bin`, and [audio/sound_data.asm](../audio/sound_data.asm) |
| Battle scene & map-battle scripts/data | [engine/battle_scene/](../engine/battle_scene/), [engine/battle/](../engine/battle/) | Macro/table `.asm` (`script.asm`, `data.asm`, `animations.asm`, `map_battle.asm`, `map_magic_effects.asm`) |

## 2. Build-Time Generators

- **1-to-1 offset tables (`13` tables in `data/offset/`):** Generated automatically by [tools/gen_offsets.py](../tools/gen_offsets.py) (run by `./build.sh` and `tablebuilder.bat`) from their source CSVs, `data/class/ClassMapSpriteAssignment.asm`, and `text/menutext/*.asm`. You can add or reorder rows in those source files without manually editing offset CSVs.
- **Many-to-one offset tables (`4` CSVs in `data/offset/`):** `CharacterNameOffsets.csv`, `ClassNameOffsets.csv`, `ItemNameOffsets.csv`, and `ItemDescriptionOffsets.csv` are kept as explicit mapping CSVs because multiple entries share strings (e.g., `Paladin` / `PaladinF`, or `aItemDescriptions.None`).
- **Compressed graphics & tilemaps:** Editing a `.4bpp.png` / `.2bpp.png` or `.bin` file in `gfx/` triggers `tools/gfx.py lz` to recompress it to `.lz`, and `tools/stream_layout.py` repacks the region's `.streams` manifest across SNES bank halves automatically.
- **Palettes:** Use `bgr555(r, g, b)` (5-bit channels `0..31`) in `data/palettes/*.asm` and `data/portraits/PortraitPalettes.asm`.

## 3. Bank Headroom & Relocation Notes

- **Bank `$83` (core tables + menu text):** [build.asm](../build.asm) places `aMainDataOffsets`, all core gameplay CSVs (`CharacterData`, `ClassData`, `ItemData`, `HolyBloodData`, `MovementCost`, love tables), and all `text/menutext/` strings in Bank `$83` (`$83/8000–$83/FFFF`), ending at `$83/F7C1` (~2.1 KB free). Adding many new items, characters, or long English menu descriptions will overflow Bank `$83` unless `aMainDataOffsets` consumers are updated to read 24-bit pointers or text/tables are split to another bank.
- **Compressed stream regions (`gfx/build/*/*.streams`):** Each `.streams` file specifies `start $XXXXXX` and `end $YYYYYY`. If edited graphics compress larger than the region's `end`, `tools/stream_layout.py` will abort; move overflow streams to a free bank/region and update their long pointers.
- **Audio sample directories (`audio/directories/*.bin`):** As noted in [audio/README.md](../audio/README.md), ROM placement in `audio/sound_data.asm` uses labels and `len(binary(...))`, but DSP sample directory entries store fixed SPC RAM `(start, loop)` addresses—resizing a `.brr` sample requires updating subsequent directory entries in that upload group.
- **Mod builds without the original ROM:** Run `./build.sh mod` (or `./build.sh mod --disable-checks` if modifying protected code regions) to update SNES/internal checksums automatically.
