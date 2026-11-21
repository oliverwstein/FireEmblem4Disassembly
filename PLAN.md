# Plan to Finish the FE4 Disassembly

This document records the roadmap from the current baseline (2026-11-21) to a 100% source-built, fully shiftable, well-named, and documented disassembly of *Fire Emblem: Genealogy of the Holy War* (JP 1.0). For detailed metrics and history, see [STATUS.md](STATUS.md) and [GAPS.md](GAPS.md).

## Current Baseline (2026-11-21)

- **Coverage:** **97.25% built from source** (4,078,909 of 4,194,304 bytes), byte-identical to `fe4.sfc`.
- **Gaps remaining ([GAPS.md](GAPS.md)):**
  - `code`: **0 pieces** (0 bytes)
  - `table`: **0 pieces** (0 bytes)
  - `inside`: **0 pieces** (0 bytes)
  - `log`: **0 pieces** (0 bytes)
  - `none`: **234 pieces** (62,476 bytes)
  - `padding`: **63 runs** (52,919 bytes)
- **Raw artifacts closed:** `0` entries in [include/Undisassembled.h](include/Undisassembled.h) and `0` `.text ROM[...]` slices remaining.
- **Routines:** **5,864** top-level routines in `engine/` — **2,154** named, **3,710** `Unknown`, and **3,173** still filed in `engine/unsorted/`.

Phase 2 is ordered ahead of Phase 3 because shiftability is what makes the disassembly genuinely moddable, its checklist is bounded and objectively testable (`./build.sh pad`), and resolving raw pointers/inline-`.byte` code exposes full call graphs before system-wide naming. Phases 3–5 can overlap with Phases 1–2 bank by bank.

---

## Remaining Phase 1: Close the Final 2.75% (97.25% → 100% Built from Source)

Everything reachable via static pointers or the existing Prologue CDL is now built. Removing `.binary "fe4.sfc"` from [build.asm](build.asm) requires covering the unlogged `none` islands:

1. **Expand CDL Coverage in Mesen 2**
   - Record one comprehensive emulator session into [fe4.cdl](fe4.cdl) covering areas missing from the Prologue log:
     - Full combat with animations on (physical, bow, magic, staff, special crits, arena, level-ups)
     - Castle & map facilities (shops, repair, pawn, augury, storage, castle menus, unit promotion)
     - Chapter transitions, World Map, Generation 1 → 2 transfer, Epilogue/Rankings, Save/Load, Attract Mode, and Debug Menu
   - Run [tools/cdl.py](tools/cdl.py) and `tools/trace.py --from-log` to disassemble any unreached code across the remaining **234 `none` pieces (62,476 bytes)** and uncover callers for the **132** built routines still marked `"Found through fe4.cdl"`.
2. **Audit Remaining Dead Code / Data & Padding Runs**
   - Review any remaining `none` pieces not hit by the expanded CDL (dead code or unused data islands between routines).
   - Convert all **63 padding runs (52,919 bytes)** to explicit `.fill` directives and delete the `.binary "fe4.sfc"` overlay and empty [include/Undisassembled.h](include/Undisassembled.h) from [build.asm](build.asm).

---

## Phase 2: Full Shiftability (Moddability)

Once a bank is 100% source with zero raw references into it, unpin its blocks and verify relocation with `./build.sh pad`.

1. **Eliminate Remaining Raw Pointers & Inline-Byte Code**
   - Resolve the remaining **33 raw code-pointer stores** (`30` `aProcSystem.aHeaderOnCycle`, `3` `aActiveSpriteSystem.aOnCycle` — splitting routines where a store targets a mid-routine address and promoting needed local labels).
   - Resolve the remaining **9 raw 6-digit numbers** (`5` with no label near them, `4` into unbuilt bytes) and **36 unlabelled ROM two-halves long pointers** reported by `tools/code_pointers.py` / `tools/raw_addresses.py`.
   - Disassemble the remaining inline-`.byte` code blocks (~20 `label+N` targets, such as staff handlers at `$87/E6D7`–`E6FB`, `$80/8ECC`, and `rlUnknown9EB491` sub-entries).
2. **Automate Integrity & Checksum Handling**
   - Document the second integrity check (`$88/8888`–`8907` copied and compared by `rlUnknown878017` / `rlUnknown87802A`) and investigate the bulk code reads at `$88/8888`–`8AC7` and `$82/8888`–`890D` in [include/Checksums.h](include/Checksums.h).
   - Add a post-assembly checksum update step in [build.sh](build.sh) (plus an optional build flag to bypass or disable anti-tamper checks in modified/padded ROMs).
3. **Merge & Pad-Test All 64 Banks in Waves**
   - **Already merged:** `$83`, `$84`, `$86`, `$8E`, `$8F`, `$92`–`$94`, `$98` (split at `$D8`/`$98`), `$9C`, `$9D` (lower half `$DD`), `$E0` (`$A0`), and the `$AD`–`$B7` data banks.
   - Run `tools/merge_bank.py <BANK>` to strip redundant consecutive `* =` placements (2,308 placements currently remain across 25 partial banks, including contiguous blocks inside `$80`–`$8D`, `$95`–`$9B`, `$9E`, and `$9F`) and merge each remaining bank once its `none` gaps close.
   - Run `./build.sh pad <SECTION> <N>` on merged banks and smoke-test padded ROMs in Mesen (starting with Bank `$84` `GenerationTransferSection`).
4. **Audit Hardcoded Offsets, Sizes & Stack Return Tricks**
   - Replace hardcoded size/offset constants (e.g., `$027E` in [engine/menus/map_menu.asm](engine/menus/map_menu.asm), hardcoded loop bounds, DMA sizes, and `pea` return offsets) with `size(...)` or label expressions.

---

## Phase 3: Readability — Naming, Sorting, RAM & Constants

Work hub-outward through the **3,710 `Unknown` routines** and **3,173 unsorted routines** in `engine/unsorted/` (can run in parallel with Phases 1–2):

1. **System-by-System Routine Naming & Sorting**
   1. **Main Loop & Game States (`$80/9B01` `aGameStateRoutines`):** Name all 52 game state entries/steps/cleanups and `GAMESTATE_*` constants to map out call trees across banks `$80`, `$85`, `$89`, `$8A`, `$8B`, `$8D`, `$91`, `$95`, `$96`, and `$9B`.
   2. **Menus, Windows & Facilities (Banks `$80`, `$85`, `$87`, `$89`, `$8A`, `$8B`, `$91`):** Name shop, pawn, repair, storage, augury, castle menu, status screen, options, and save/load UI routines; file into `engine/menus/` and `engine/save/`.
   3. **Map Engine (Bank `$88`):** Name map rendering, tile/palette animations, cursor/camera movement, movement-range calculation, and map sprite management; file into `engine/map/`.
   4. **Events, Attract Mode, Epilogue & Scripted Scenes (Banks `$81`, `$82`, `$8D`, `$90`, `$91`, `$9E`):** Name event command helpers, attract-mode demo (`$90/E8CE`), ending/epilogue/ranking screens (`$8D`, `$91`), and scripted `"ON"` scene procs (`$9E`); file into `engine/events/`, `engine/epilogue/`, and `engine/rankings/`.
   5. **Battle Engine, Map Battles & Battle Scene (Banks `$84`, `$95`, `$96`, `$97`, `$9B`, `$9F`):** Finish the remaining unnamed routines in `battle/`, `units/`, and `items/` (including `rlUnknown84DC1C`), the 6 battle scene control commands (`$FFF8`–`$FFFD`), the 72 effect routines at `$97/BDD4`, and the map-battle / spell animation engine in `$9B` and `$9F`.
   - Use [tools/fe5_match.py](tools/fe5_match.py) (including operand-aligned RAM matching) and cross-reference Project Naga / Lil' Nordion notes where helpful. Goal: **empty `engine/unsorted/` completely**.
2. **RAM Variables ([include/WRAM.h](include/WRAM.h))**
   - Iterate with `tools/name_ram.py --report 50`: name top global state/flag words (`$0788`, `$0D87`, `$08AD`, `$04EA`), map/camera working variables (`$0778`–`$07E6`), and screen-scoped buffers (`$7F45xx`, `$7F4Cxx`, `$7F8xxx` via `SCOPED` rules).
3. **Constants & Struct Fields**
   - Expand [tools/constant_rules.txt](tools/constant_rules.txt) and struct definitions as getters/fields are named, then re-run [tools/apply_constants.py](tools/apply_constants.py) and [tools/name_struct_fields.py](tools/name_struct_fields.py).

---

## Phase 4: Editable Assets & Data Formats

Convert remaining raw binary/compressed chunks into editable formats that round-trip cleanly through [build.sh](build.sh):

1. **UI Tilemaps & Coloured UI PNGs:** Read palette bits from the extracted DMA tilemaps ([gfx/ui/README.md](gfx/ui/README.md)) and colour the greyscale UI sheets in `gfx/ui/`.
2. **Unidentified Compressed Streams ([gfx/compressed/CATALOG.md](gfx/compressed/CATALOG.md)):** As their loaders are named in Phase 3, rename each `gcUnknownADDR` via [tools/name_streams.py](tools/name_streams.py) and unpack tile sheets to `.4bpp.png`/`.2bpp.png` and tilemaps to `.bin` via [tools/unpack_streams.py](tools/unpack_streams.py).
3. **Chapter Maps & Map-Battle Layouts:** Decode the chapter map layout/tile-config format (`aChapterMapPointers` in [engine/map/chapter_maps.asm](engine/map/chapter_maps.asm)) and the 120 `aMapBattleCLASSLayoutN.comp` files into editable formats with preview renderers (similar to [tools/backgrounds.py](tools/backgrounds.py)).
4. **Audio & SPC700 Driver:** Disassemble the 5 SPC700 driver blocks in `audio/driver/` into build-time SPC700 source (documenting sequence commands `$C0`–`$FF` and instrument fields), identify the 118 `other` sound chunks, and finish naming `SONG_*` constants from [audio/SONGS.md](audio/SONGS.md).

---

## Phase 5: Documentation & Final Polish

1. **Architecture Documentation (`docs/`):** Write concise system explainers modeled on pokecrystal (`docs/procs.md`, `docs/events.md`, `docs/battle.md`, `docs/battle_animations.md`, `docs/map.md`, `docs/sound.md`, `docs/compression.md`, `docs/memory_map.md`).
2. **Build & Repo Polish:** Update [README.md](README.md) (which still states ~18% built), test/update the Windows `.bat` build scripts, and add a full shiftability test target to [build.sh](build.sh).
