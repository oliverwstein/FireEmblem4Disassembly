# FE4 Disassembly — Remaining Gaps & Cleanup Tracker

Baseline: **2026-11-25** (100.00% ROM coverage, 6,505/6,505 routines named).  
Rule: Every change to source, data, or assets must keep `./build.sh` byte-identical to `fe4.sfc`.

## Summary Scorecard

| Metric | Baseline (2026-11-25) | Current | Refresh Command |
|---|---:|---:|---|
| Unnamed RAM addresses | 1,296 (`4,727` operands) | 1,224 (`3,552` operands) | `python3 tools/name_ram.py --report 50` |
| Distinct `*Unknown*` identifiers | 864 | 863 | `grep -rIoh '\b[A-Za-z_]*Unknown[A-Za-z0-9_]*\b' engine include data events audio text --exclude='*.csv.asm' --exclude='*.dialogue.txt' \| sort -u \| wc -l` |
| Compressed-only `.comp` streams | 510 (`273` `Unknown`) | 233 (`233` `Unknown`) | `find gfx audio -name '*.comp'` (check for missing `.png` / unpacked file) |
| Greyscale UI PNG sheets | 18 | 0 | `ls gfx/ui/*.png` (see [gfx/ui/README.md](gfx/ui/README.md)) |
| Undecoded chapter maps / battle layouts | `aChapterMapPointers` + 120 battle layouts | 0 (`tools/chapter_maps.py`, `tools/map_battle_layouts.py`) | `find gfx/compressed -name '*MapBattle*Layout*.comp' \| wc -l` |
| Raw SPC700 driver / `other` sound chunks | 5 driver blocks / 118 `other` chunks | 5 driver blocks / 118 `other` chunks | `ls audio/driver audio/chunks` |

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

### 1.2 `*Unknown*` Identifiers (`864` distinct symbols)

- **`aUnknown*` data tables, scripts, and structs (`503` distinct)**
  - [ ] `engine/battle_scene/` (203)
  - [ ] `engine/title/` (74)
  - [ ] `engine/castle/` (63)
  - [ ] `engine/battle/` (60)
  - [ ] `engine/menus/` (51)
  - [ ] `engine/epilogue/` (36)
  - [ ] `engine/map/` (31)
  - [ ] Remaining folders (`include/` 13, `engine/core/` 12, `engine/save/` 7, `events/` 7, `engine/arena/` 5, `engine/dialogue/` 3, `engine/debug/` 3, `data/palettes/` 3)
- **Other `*Unknown*` categories**
  - [ ] `gcUnknown*` compressed stream labels (`195` distinct — coordinate with Section 2.1 via `tools/name_streams.py`)
  - [ ] `wUnknown*` / `bUnknown*` / `lUnknown*` WRAM variables (`48` distinct: 36 `w`, 10 `b`, 2 `l`)
  - [ ] `aPortraitPaletteUnknown*` (`18` distinct)
  - [ ] `aSoundUnknown*` (`11` distinct)
  - [ ] Other `*Unknown*` struct fields, constants, and misc labels (`89` distinct)

---

## 2. Un-unpacked Assets & Opaque Formats

### 2.1 Compressed-Only `.comp` Streams (`510` files, `273` `Unknown`)

Workflow: identify via loader routines and [gfx/compressed/CATALOG.md](gfx/compressed/CATALOG.md), rename with `tools/name_streams.py`, and unpack to `.png`/`.bin` via `tools/unpack_streams.py` so `./build.sh` round-trips them through `tools/gfx.py lz`.

- [ ] `gfx/compressed/E02EBD/` — 169 remaining (169 `Unknown`; 11 unpacked)
- [x] `gfx/compressed/A08000/` — 81 total (all unpacked; 0 `Unknown`)
- [ ] `gfx/compressed/D50000/` — 33 remaining (33 `Unknown`; 45 unpacked)
- [ ] `gfx/compressed/D05673/` — 31 remaining (31 `Unknown`; 25 unpacked)
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
- [ ] Fix `tools/songs.py` (blocked on stale `aUnknown8A9D79`), regenerate [audio/SONGS.md](audio/SONGS.md), and finish naming `SONG_*` constants in [include/Sound.h](include/Sound.h). *(Note: `tools/songs.py` now runs cleanly and regenerated [audio/SONGS.md](audio/SONGS.md); only `SONG_*` naming remains.)*
