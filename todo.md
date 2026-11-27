# FE4 Disassembly — Remaining Gaps & Cleanup Tracker

Baseline: **2026-11-25** (100.00% ROM coverage, 6,505/6,505 routines named).  
Rule: Every change to source, data, or assets must keep `./build.sh` byte-identical to `fe4.sfc`.

## Summary Scorecard

| Metric | Baseline (2026-11-25) | Current | Refresh Command |
|---|---:|---:|---|
| Unnamed RAM addresses | 1,296 (`4,727` operands) | 1,224 (`3,552` operands) | `python3 tools/name_ram.py --report 50` |
| Distinct `*Unknown*` identifiers | 864 | 0 | `grep -rIoh '\b[A-Za-z_]*Unknown[A-Za-z0-9_]*\b' engine include data events audio text --exclude='*.csv.asm' --exclude='*.dialogue.txt' \| sort -u \| wc -l` |
| Compressed-only `.comp` streams | 510 (`273` `Unknown`) | 0 | `find gfx audio -name '*.comp'` (check for missing `.png` / unpacked file) |
| Greyscale UI PNG sheets | 18 | 0 | `ls gfx/ui/*.png` (see [gfx/ui/README.md](gfx/ui/README.md)) |
| Undecoded chapter maps / battle layouts | `aChapterMapPointers` + 120 battle layouts | 0 (`tools/chapter_maps.py`, `tools/map_battle_layouts.py`) | `find gfx/compressed -name '*MapBattle*Layout*.comp' \| wc -l` |
| Raw SPC700 driver / `other` sound chunks | 5 driver blocks / 118 `other` chunks | 5 driver blocks / 118 `other` chunks | `ls audio/driver audio/chunks` |
| Manual offset tables (`data/offset/`) | 17 | 4 (13 auto-generated) | `ls data/offset/*.csv \| wc -l` |
| Tracked `Unknown*` files (excl. `catalog/`) | 11 | 0 | `git ls-files '*Unknown*' \| grep -v '^gfx/compressed/catalog/' \| wc -l` |
| Stale `gfx/compressed/catalog/` previews | 233 | 0 | `git ls-files 'gfx/compressed/catalog/*.png' \| wc -l` |

**Review (2026-11-25, Claude).** The work through `e902eb3` was reviewed and fixed in `e46cc7a` and `c12ee3e`: three tools read the deleted offset CSVs, two RAM layouts ignored access widths, `aBattleSceneHPBarDigitOffsets` was misnamed, and the active sprite fields were named after one user. The Phase U1-U7 names were sampled, not verified, and carry almost no comments; [STATUS.md](STATUS.md) ("Next session") plans an audit by system. When naming RAM, check each access's width (`sep`/`rep`) before choosing `b`/`w` and field boundaries, and run every tool that reads a file before deleting or moving it.

---

## 1. Unnamed RAM & Data Tables

### 1.1 Raw RAM Addresses (`1,296` addresses / `4,727` operands)

Workflow: identify usage from callers, declare in [include/WRAM.h](include/WRAM.h) (use `SCOPED` rules for screen-local `$7F` buffers), and apply with `tools/name_ram.py`, `tools/apply_constants.py`, and `tools/name_struct_fields.py`.

- [ ] **Bank `$7F` (`$7FE000–$7FEFFF`)** — 271 addrs, 1,457 refs
  - Top hotspots: `$7FE475` (83), `$7FEC29` (37), `$7FE477` (36), `$7FE47A` (30), `$7FE1B3` (29), `$7FEC1F` (28), `$7FE4D5` (27), `$7FEC1D` (25), `$7FE476` (25), `$7FE479` (24), `$7FEC23` (23), `$7FE4B7` (23)
- [ ] **Low WRAM (`$0000–$1FFF`)** — 268 addrs, 920 refs
  - Top hotspots: `$0792` (41), `$06DC` (24), `$069C` (23)
- [ ] **Bank `$7F` (`$7F5000–$7F5FFF`)** — 71 addrs, 400 refs
  - Top hotspots: `$7F57EA` (41), `$7F57EC` (24), `$7F57F0` (23), `$7F509F` (22)
- [ ] **Bank `$7F` (`$7FF000–$7FFFFF`)** — 110 addrs, 379 refs
- [ ] **Bank `$7F` (`$7FD000–$7FDFFF`)** — 141 addrs, 370 refs
  - Top hotspots: `$7FD046` (28), `$7FD055` (24)
- [ ] **Bank `$7F` (`$7F8000–$7F8FFF`)** — 79 addrs, 201 refs
- [ ] **Bank `$7E` (`$7E8000–$7E8FFF`)** — 124 addrs, 186 refs
- [ ] **Remaining Bank `$7E` clusters** (`$7EC000`, `$7E4000–$7E5FFF`, `$7E0000`, `$7E2000`, `$7E7000`, `$7E9000–$7EA000`, `$7EE000–$7EFFFF`) — 115 addrs, 456 refs
  - Top hotspots: `$7E4EA9` (34), `$7ECC06` (31), `$7ECC08` (25)
- [ ] **Remaining Bank `$7F` clusters** (`$7FB000` [29 addrs / 99 refs, hotspot `$7FB010`], `$7FC000`, `$7F6000–$7FA000`, `$7F0000`, `$7F4000`) — 117 addrs, 358 refs

### 1.2 `*Unknown*` Identifiers (`846` distinct symbols — Step-by-Step Plan)

Workflow: inspect callers, data format, and (for unpacked streams) `.4bpp.png`/`.bin` contents; rename ROM symbols with `tools/rename.py` and compressed streams with `tools/name_streams.py`; mark genuinely unreferenced/dead blocks explicitly as unused rather than guessing; verify `./build.sh` is byte-identical and commit after each phase.

- **Phase U1 — Quick-win small ROM buckets (`58` symbols)**
  - [x] Small `aUnknown*` folders (`29`): `events/` (7), `engine/save/` (6), `engine/arena/` (5), `engine/debug/` (3), `engine/worldmap/` (3), `include/` (2), `data/` (2), `engine/events/` (1)
  - [x] `aPortraitPaletteUnknown*` / `PortraitPaletteUnknown*` (`18`): match against portrait indices/palettes in `data/PortraitPalettes.asm` and `data/PortraitPalettePointers.csv` (mark unused palettes explicitly)
  - [x] `aSoundUnknown*` (`11`): identify `aSoundUnknownF7AD9C` (`Unknown12` in `audio/sound_data.asm`) and mark/document the 10 unreferenced sound blocks
- **Phase U2 — Small & mid-size `aUnknown*` subsystems (`106` symbols)**
  - [x] `engine/map/` (`24`)
  - [x] `engine/epilogue/` (`36`)
  - [x] `engine/title/` (`46`)
- **Phase U3 — UI & castle `aUnknown*` subsystems (`109` symbols)**
  - [x] `engine/menus/` (`51`)
  - [x] `engine/castle/` (`58`)
- **Phase U4 — Small/medium `gcUnknown*` unpacked streams (`85` files across 7 folders)**
  - [x] Rename unpacked streams via `tools/name_streams.py` by caller + visual `.4bpp.png` inspection: `AFC8C0/` (1), `DF0000/` (1), `94C140/` (2), `C00A2B/` (6), `DD0000/` (9), `D05673/` (32), `D50000/` (34)
- **Phase U5 — Map battle `aUnknown*` (`62` symbols)**
  - [x] `engine/battle/` (`62`): map battle tables, magic effect scripts/palettes, and action animation data
- **Phase U6 — Battle scene `aUnknown*` (`202`) & `E02EBD/` `gcUnknown*` (`171` files)**
  - [x] Tackle `engine/battle_scene/` (`202` `aUnknown*`) together with `gfx/compressed/E02EBD/` (`171` `gcUnknown*` unpacked `.4bpp.png`/`.bin` streams), since battle-scene effect/spell scripts and `E02EBD/` graphics reference each other directly
- **Phase U7 — Struct fields, constants & remaining WRAM `*Unknown*` (`135` symbols)**
  - [x] Remaining `wUnknown*` / `bUnknown*` / `lUnknown*` WRAM variables (`41`) — coordinate with Section 1.1 scoping rules in `tools/name_ram.py`
  - [x] Other `*Unknown*` struct fields, constants, and misc labels (`94`) across `include/`, `engine/`, `data/`, and `audio/`

---

## 2. Un-unpacked Assets & Opaque Formats

### 2.1 Compressed-Only `.comp` Streams (`510` files, `273` `Unknown`)

Workflow: identify via loader routines and [gfx/compressed/CATALOG.md](gfx/compressed/CATALOG.md), rename with `tools/name_streams.py`, and unpack to `.png`/`.bin` via `tools/unpack_streams.py` so `./build.sh` round-trips them through `tools/gfx.py lz`.

- [x] `gfx/compressed/E02EBD/` — 180 total (all unpacked)
- [x] `gfx/compressed/A08000/` — 81 total (all unpacked; 0 `Unknown`)
- [x] `gfx/compressed/D50000/` — 78 total (all unpacked)
- [x] `gfx/compressed/D05673/` — 56 total (all unpacked)
- [x] `gfx/compressed/C70C80/` — 42 total (0 `Unknown`, all unpacked)
- [x] `gfx/compressed/9C8000/` — 25 total (all unpacked)
- [x] `gfx/compressed/DF0000/` — 18 total (all unpacked)
- [x] `gfx/compressed/DD0000/` — 15 total (all unpacked)
- [x] `gfx/compressed/C00A2B/` — 10 total (all unpacked)
- [x] `gfx/compressed/94C140/` — 3 total (all unpacked)
- [x] `gfx/compressed/AFC8C0/` — 1 total (unpacked)
- [x] `gfx/compressed/B48720/` — 1 total (0 `Unknown`, unpacked)

### 2.2 Greyscale UI Sheets (`gfx/ui/`)

- [x] Color the `18` greyscale `.4bpp.png` / `.2bpp.png` UI sheets in `gfx/ui/` using palette bits from the `28` extracted DMA tilemaps (see [gfx/ui/README.md](gfx/ui/README.md)).
- [x] Verify lossless round-trip through `./build.sh`.

### 2.3 Undecoded Chapter Maps & Map-Battle Layouts

- [x] Decode chapter map layouts and tile configurations (`aChapterMapPointers` in [engine/map/chapter_maps.asm](engine/map/chapter_maps.asm)) into editable formats with a preview renderer (`tools/chapter_maps.py`).
- [x] Decode the `120` `aMapBattle*Layout*.comp` files into editable formats with a preview renderer (`tools/map_battle_layouts.py`).

### 2.4 Audio: SPC700 Driver & Unidentified Sound Chunks *(lowest priority, per [PLAN.md](PLAN.md))*

- [ ] Disassemble the `5` SPC700 driver IPL upload blocks in `audio/driver/` (`0200.bin`, `0660.bin`, `1BC0.bin`, `C502.bin`, `FF80.bin`) into build-time SPC700 source, documenting sequence commands (`$C0–$FF`) and instrument fields.
- [ ] Identify and categorize the `118` unidentified `other` sound chunks in `audio/chunks/` (121 files total in directory).
- [x] Fix `tools/songs.py` and regenerate [audio/SONGS.md](audio/SONGS.md).
- [ ] Finish naming `SONG_*` constants in [include/Sound.h](include/Sound.h).

---

### 2.5 Streams Unpacked as the Wrong Kind (checked 2026-11-25)

All 145 stream PNGs renamed in `1961416`..`e902eb3` were checked against their loaders and pictures.

- [x] 39 tilemaps named or unpacked as 4bpp tiles are now `ac...Tilemap` `.bin` streams (`df418b5`): 34 battle scene and title loads through `aBattleSceneDecompressToVRAMTable` to a BG map (VRAM `$3000`/`$3800` BG1, `$6000` BG2, `$7000` BG3; nine other `$3000` loads are tiles, BG1's tiles running on from `$2000`), the epilogue's three BG maps, `acBattleSceneHUDTilemap` and `acMapBattleMagicTilemapUnusedD629B1`.
- [x] `g4bppcEpilogueCreditsBG1Tiles` is BG2's tiles (VRAM `$2000`; BG1's start at `$3000`): now `g4bppcEpilogueCreditsBG2Tiles`.
- [x] Four previously unsure streams settled (`230ab78`, `09f4ed7`): `acTitleSceneTilemapF57B55` and `acChapterIntroBannerTilemaps` are BG3 tilemaps (`.bin`), and `gcAbnormalityWarningTiles` and `gcAntiPiracyWarningTiles` are 2bpp BG3 tiles (`.2bpp.png`).
- [x] 15 additional tilemaps unpacked as `.bin` (`230ab78`): `acChapterIntroBannerTilemaps`, `acMenuWindowBackgroundTilemap` (was `g4bppcDebugMenuWindowTiles`, shared by item/skill/debug menus), `acBattleSceneHUDWindowTilemap`, `acBattleSceneDecompTilemapE03B09`/`E03D3B`/`E04000`/`E040D3`, `acBattleSceneUnusedTilemapE03F2B`/`E0414C`/`E041B7`, `acBattleSceneEffectTilemapF22851`, and `acTitleSceneTilemapF5222D`/`F524B7`/`F527E5`/`F57B55`.
- [x] 7 Mode 1 BG3 2bpp sheets re-unpacked as `.2bpp.png` after adding `.2bpp` support to `unpack_streams.py`, `stream_layout.py`, and `build.sh` (`09f4ed7`): `gcAntiPiracyWarningTiles`, `gcAbnormalityWarningTiles`, `g2bppcTitleSceneTilesF57765`, `gcBattleSceneStatLabels`, `gcHiraganaFont`, `gcMenuLabelsAndIcons`, and `gcOpeningCreditsFont`.

## 3. ROM Data Organization (Moddability & Readability)

### 3.1 Moddability & Build Automation

- [x] **Auto-generate `data/offset/` tables (`13` of `17` CSVs):** [tools/gen_offsets.py](tools/gen_offsets.py) generates the 13 1-to-1 `.csv.asm` offset tables from their source CSVs, `ClassMapSpriteAssignment.asm`, and `text/menutext/*.asm` (wired into `build.sh` and `tablebuilder.bat`); the 4 many-to-one mapping CSVs (`CharacterNameOffsets.csv`, `ClassNameOffsets.csv`, `ItemNameOffsets.csv`, `ItemDescriptionOffsets.csv`) remain explicit.
- [x] **Replace remaining magic numbers in CSVs with named constants:**
  - `WeaponRank*`, `MovementType*`, and `TerrainAvoid*` in [data/class/ClassData.csv](data/class/ClassData.csv) and [include/Classes.h](include/Classes.h).
  - Magic-sword / Naga spell IDs (`Elfire`, `Elthunder`, `Elwind`, `Light`, `Nosferatu`, `Loptous`) in [data/item/ItemData.csv](data/item/ItemData.csv).
  - `UNITEntryEnd` (`$FFFF`) and `UNITFormationNone` (`$FF`) in `data/eventunit/*.csv` and [include/Deployment.h](include/Deployment.h).
- [x] **Add a readable palette macro:** Added `bgr555(r, g, b)` in [include/Palettes.h](include/Palettes.h) and converted [data/palettes/](data/palettes/) and [data/portraits/PortraitPalettes.asm](data/portraits/PortraitPalettes.asm).
- [x] **Wire decoded map/layout tools into `build.sh`:** Invoke [tools/chapter_maps.py](tools/chapter_maps.py) and [tools/map_battle_layouts.py](tools/map_battle_layouts.py) from [build.sh](build.sh) (matching the `.png` → `.4bpp` → `.lz` pattern) so decoded chapter maps and map-battle layouts rebuild automatically on edit.
- [x] **Document bank headroom & relocation strategies:** Added [docs/MODDING_DATA.md](docs/MODDING_DATA.md) covering Bank `$83` (~2.1 KB free), hard `end` caps in `gfx/**/*.streams`, and fixed SPC RAM sample directory addresses in `audio/directories/`.

### 3.2 Cleanup & Consistency

- [x] **Remove stale stream catalog & orphaned build files:** Removed [gfx/compressed/CATALOG.md](gfx/compressed/CATALOG.md), the `233` tracked PNGs in `gfx/compressed/catalog/`, and orphaned `gcUnknown*` build outputs.
- [x] **Identify or mark the `11` remaining tracked `Unknown*` data/asset files:** Renamed [data/Unused838961.asm](data/Unused838961.asm), [gfx/map/BaseMapTileEntries.bin](gfx/map/BaseMapTileEntries.bin), [gfx/build/ui/tilemaps/WorldMapDataD97940.bin](gfx/build/ui/tilemaps/WorldMapDataD97940.bin), and the `8` unreferenced `UnusedD9*` / `UnusedDA*` files in [gfx/map/](gfx/map/) and [gfx/build/ui/tilemaps/](gfx/build/ui/tilemaps/).
- [x] **Group loose top-level `data/` portrait files:** Moved `PortraitGraphicPointers.csv`, `PortraitPalettePointers.csv`, and `PortraitPalettes.asm` into [data/portraits/](data/portraits/).
- [x] **Harmonize minor name label inconsistencies:** Aligned `ShannanName`, `DeimneName`, `CreidneName`, and `HerminaName` in [data/character/CharacterData.csv](data/character/CharacterData.csv), [data/offset/CharacterNameOffsets.csv](data/offset/CharacterNameOffsets.csv), and [text/menutext/CharacterNames.asm](text/menutext/CharacterNames.asm).

### 3.3 Readability & Discoverability

- [ ] **Organize `gfx/` by domain instead of ROM address:** Now tracked by [docs/AUTHORING_GRAPHICS_PLAN.md](docs/AUTHORING_GRAPHICS_PLAN.md) (*Target layout of `gfx/`*). Phase 4 renamed `gfx/compressed/` to `gfx/build/` and moved authored sources into system folders (`gfx/maps/`, `gfx/map_battle/`, `gfx/portraits/`, `gfx/scenes/`, `gfx/ui/layouts/`, `gfx/icons/`, `gfx/fonts/`). The ROM-address folders in `gfx/build/` stay as build plumbing (`*.streams`, committed `.comp` originals, generated files). Open: the `418` tile sheets and `156` raw assets still live there until Phases 6–7 give them sources ([gfx_inventory.md](docs/reference/gfx_inventory.md)).
- [ ] **Clean up inline data & stale section names in `build.asm`:** Only a few inline definitions (`aDecompressionDMAEntry80F42B`–`80F43B`, `aMainDataEntry12Unused`, `rlSwapToMainDataBank`) have moved out of [build.asm](build.asm) so far; ~133 inline definitions (`aDecompressionDMAEntry*`, etc.) and stale `Unsorted*Section` / `Table*Section` labels remain.
- [ ] **Audit data-heavy files in `engine/`:** Evaluate splitting large data tables out of `engine/` (notably [engine/battle_scene/script.asm](engine/battle_scene/script.asm), [data.asm](engine/battle_scene/data.asm), [animations.asm](engine/battle_scene/animations.asm), [engine/battle/map_battle.asm](engine/battle/map_battle.asm), [map_magic_effects.asm](engine/battle/map_magic_effects.asm), and [engine/dialogue/dialogue.asm](engine/dialogue/dialogue.asm)) or documenting where each subsystem's data lives.
- [ ] **Improve `audio/` file discoverability:** Give `audio/` sequence, sample, and instrument files descriptive names (or a clear index) alongside finishing `SONG_*` naming in [include/Sound.h](include/Sound.h).
