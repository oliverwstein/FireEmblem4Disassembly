# FE4 Multi-Language Localization Plan (`jpn` / `eng`)

A plan for supporting both the vanilla Japanese ROM (`jpn`, default, byte-identical to `fe4.sfc`) and an English (or other localized) 8 MB ExHiROM build (`eng`) from this single source-built repository, inspired by [Lil' Nordion](https://github.com/Miacidae/Lil-Nordion-Public) while taking advantage of our 100%-source-built disassembly and authored graphics pipeline.

---

## 1. Overview & Locked Design Decisions

| Decision | Choice | Rationale |
|---|---|---|
| **Build switch** | `python3 build.py [--lang jpn\|eng]` (`jpn` default) | Keeps `jpn` 100% byte-identical to `fe4.sfc` (`SHA-1` verified); `eng` builds an 8 MB ExHiROM without requiring `fe4.sfc` or any pre-patched base ROM. |
| **Overlay layout** | `locales/<lang>/` mirroring `text/`, `gfx/`, `data/`, `engine/` | Vanilla `jpn` files stay in place untouched; missing files in `locales/eng/` fall back to `jpn`, so incremental translation builds a bootable ROM from Day 1 and additional languages (`es`, `fr`, etc.) can be added cleanly. |
| **ROM mapping (`eng`)** | **8 MB ExHiROM** (`$35` ExHiROM FastROM, ROM size `$0D`, country `$01`) | Standard power-of-two ExHiROM size; gives ample headroom for English dialogue, pre-rendered menu strips, localized graphics, and future mods without manual bank juggling. |
| **Dialogue font & script** | Clean-room script framework (`{DIALOGUE_*}` UTF-8 `.txt`); **no** Lil' Nordion script importer | Reuses Lil' Nordion's proportional English 2bpp dialogue font (`Dialogue_Font.2bpp` + `Slim_Font.2bpp` + `Font_Width_Table.asm`) converted into `locales/eng/gfx/fonts/*.2bpp.png` + `locales/eng/data/DialogueFontWidth.asm` (with attribution). |
| **Menu text (Hybrid — Option C)** | Static chrome via `gfx/ui/layouts/*.scene.json`; dynamic strings via build-time `tools/menu_vwf.py` | Authors edit plain UTF-8 text in `locales/eng/text/menutext/*.asm` (never YY-CHR bitmaps). `tools/menu_vwf.py` pre-renders strings to proportional `.2bpp` tile strips + `(tile_count, long_ptr)` tables in ExHiROM, with small `.if LANG != "jpn"` ASM hooks to DMA them into BG3 VRAM. |
| **Hand-translated visual graphics** | Selective adaptation into authored `gfx/` sources under `locales/eng/gfx/` | Adapts Lil' Nordion's hand-translated English visuals (with attribution) into our existing Phase 3/4 `.png` and `.scene.json` / CSV formats (`OpeningCredits`, `TitleIntroCaption`, `GenealogyWheel`, `ChapterIntroBanners`, `EpilogueRanking`, `BattleStats`/`LevelUp`, `WorldMap`). |

---

## 2. Comparison with Lil' Nordion (What We Keep vs. Improve)

| Area | How Lil' Nordion Does It | How Our Disassembly Does It |
|---|---|---|
| **Base ROM** | Requires a pre-patched 6 MB **Project Naga** `FE4.sfc` binary overlay; engine hacks live inside that binary patch. | **100% built from source** for both `jpn` (4 MB HiROM) and `eng` (8 MB ExHiROM). Zero binary base-ROM overlay. |
| **ROM placement & pointers** | Hardcodes `* = $550A60` dialogue blocks, `* = $440000+` menu bitmaps, and hundreds of manual repoints (`Chapter N Pointers.asm`, `$00B623`, `$098293`). | **Fully symbolic:** `64tass` resolves every `.long` pointer automatically; ExHiROM banks are packed by build tools (`DialogueLayout.asm`, `stream_layout.py`). |
| **Dialogue text** | Single-byte Latin encoding (`$10–$E1`) + 2bpp VWF font (`Dialogue_Font.2bpp` + `Slim_Font.2bpp`) + `Font_Width_Table.asm`. | **Keep this VWF model**—it fits FE4's `rlRunDialogueCycle` natively—and add build-time pixel-width overflow checking. |
| **Menu text** | ~860 KB of manually drawn `.2bpp` bitmaps edited in YY-CHR / Bitmap Font Writer + manual tilemap `.asm` files in banks `$44–$5B`. | **Plain-text editable source** (`locales/eng/text/menutext/*.asm`) compiled at build time by `tools/menu_vwf.py` into `.2bpp` strips + descriptor tables, plus authored UI layouts. |
| **Localized graphics** | Replaces ~10 graphic groups manually with raw `.2bpp`/`.4bpp`/`.tilemap` binaries. | **Authored `gfx/` pipeline:** localized PNGs and `.scene.json` / CSV layouts under `locales/eng/gfx/` repack automatically via `scene_pack.py` and `stream_layout.py`. |
| **Language switch** | English-only build. | Single flag (`--lang jpn` vs `--lang eng`) sharing one codebase and isolated build caches. |

---

## 3. Directory & Build Architecture

### 3.1 Overlay Structure

```text
locales/
  eng/
    config.json               # ROM mapping (exhirom_8mb), encoding & box-width budgets
    text/
      Dialogue.h              # 1-byte Latin .enc tables (Page 0 normal, Page 1 slim)
      dialogue/               # UTF-8 dialogue overrides (falls back to text/dialogue/ if absent)
      menutext/               # Plain UTF-8 strings: Characters, Classes, Items, Descriptions,
                              #   Castles, Factions, Terrains, Skills, Statuses, Commands, Chronology
    gfx/
      eng.streams             # ExHiROM compressed stream region for oversized localized streams
      fonts/                  # English VWF DialogueFont.2bpp.png + SlimFont.2bpp.png + MenuFont.2bpp.png
      scenes/                 # Localized OpeningCreditsPage1–8, TitleIntroCaption01–13,
                              #   EpilogueRankingBG1–2, Warning screens, WorldMap
      ui/                     # Localized GenealogyWheel, ChapterIntroBanners, BattleStats,
                              #   LevelUp, MapBattleLevelUpText, etc.
    data/
      DialogueFontWidth.asm   # Pixel widths for normal + slim VWF dialogue glyphs
      ItemSortOrder.asm       # Auto-generated English alphabetical sort table
    engine/                   # Localized ASM overrides/hooks included when LANG != "jpn"
```

### 3.2 Isolated Build Cache & 64tass Integration

- Generated artifacts for non-`jpn` builds live under **`.build/<lang>/`** (gitignored) — e.g. `.build/eng/dialogue/`, `.build/eng/gfx/`, `.build/eng/menutext/`, `.build/eng/Layout.asm`, and `FE4Disassembly_eng.sfc` — so switching between `--lang jpn` and `--lang eng` never invalidates or dirties the `jpn` incremental cache.
- `build.py` passes `-D LANG="jpn"` or `-D LANG="eng"` to `64tass`, plus `-I .build/<lang>` (or generates a tiny `.build/<lang>/lang_paths.asm` / include wrapper) so `build.asm` and `engine/` resolve localized includes cleanly without duplicating `build.asm`.

### 3.3 8 MB ExHiROM Memory Map (`eng` only)

In SNES ExHiROM (mode `$35`), file offsets `$000000–$3FFFFF` map to `$C00000–$FFFFFF` (mirrored at `$808000–$BFFFFF`), and the expanded 4 MB (`$400000–$7FFFFF`) maps to `$400000–$7DFFFF` (and `$008000–$3FFFFF` / `$FE0000–$FFFFFF` depending on bank).

| File Offset Range | CPU Banks | Contents (`LANG == "eng"`) |
|---|---|---|
| `$000000–$3FFFFF` | `$80–$BF` / `$C0–$FF` | Vanilla 4 MB layout (code, tables, original streams); unused JPN dialogue/Bank `$83` slots reclaimed or bypassed as needed. |
| `$400000–$40FFFF` | `$40` | Mirrored ExHiROM SNES header & vectors at `$40FFB0–$40FFFF`, plus localized `engine/` hooks and Bank `$83` overflow tables. |
| `$410000–$4FFFFF` | `$41–$4F` | Localized graphics streams (`locales/eng/gfx/eng.streams`) and `tools/menu_vwf.py` pre-rendered `.2bpp` menu strips & descriptor tables. |
| `$500000–$6FFFFF` | `$50–$6F` | Auto-packed English dialogue (`DialogueLayout.asm`), split cleanly at 64 KB bank boundaries with zero mid-string splits. |
| `$700000–$7DFFFF` | `$70–$7D` | Reserved free space for future expansions, mods, or additional languages. |

---

## 4. Phased Rollout Plan

### Phase 1 — Build Plumbing & 8 MB ExHiROM Support
- **Deliverables:**
  - `build.py` & `build.sh`: add `--lang {jpn,eng}` (default `jpn`) to `build`, `mod`, `clean`, and `test`. Pass `-D LANG="..."` to `64tass`, isolate non-`jpn` outputs in `.build/<lang>/`, output `FE4Disassembly_<lang>.sfc`, and run `tools/checksums.py --update` automatically for `eng` (no `fe4.sfc` required).
  - [engine/core/frame/header.asm](engine/core/frame/header.asm): under `.if LANG != "jpn"`, set map mode `$35` (ExHiROM FastROM), ROM size `$0D` (8 MB), country `$01` (North America), and mirror `aSNESExtendedHeader` / `aSNESHeader` / vectors at file offset `$40FFB0`.
  - [tools/checksums.py](tools/checksums.py): support 8 MB ExHiROM header checksum calculation (`$00FFB0` + `$40FFB0` mirror, summing full 8 MB power-of-two ROM) alongside existing internal code checksums (`$80`/`$87`/`$88`/`$8F`).
  - [engine/core/frame/boot.asm](engine/core/frame/boot.asm) & `engine/core/graphics/decompressor.asm`: audit `rlDecompressor` (`rlDecompressLinear`) and long-pointer arithmetic for reading from ExHiROM banks `$40–$7D` (ensuring bank increments don't wrap or mis-handle `< $80` banks).
  - [build.asm](build.asm): add `.if LANG != "jpn"` ExHiROM placement block at `$400000–$7DFFFF`.
- **Proved when:**
  - `python3 build.py` (`jpn`) remains 100% byte-identical to `fe4.sfc`.
  - `python3 build.py --lang eng` produces an 8 MB `FE4Disassembly_eng.sfc` with valid ExHiROM header/checksums that boots to the title screen in Mesen/bsnes.

### Phase 2 — English Dialogue Engine, Font & Auto-Packing Pipeline
- **Deliverables:**
  - **Encoding & Font:** Add `locales/eng/text/Dialogue.h` (1-byte Latin `.enc` tables: `$10–$E1` on Page 0 normal, Page 1 slim). Convert Lil' Nordion's `Dialogue_Font.2bpp`, `Slim_Font.2bpp`, and `Font_Width_Table.asm` into `locales/eng/gfx/fonts/DialogueFont.2bpp.png`, `SlimFont.2bpp.png`, and `locales/eng/data/DialogueFontWidth.asm` (with attribution).
  - **Engine hooks ([engine/dialogue/dialogue.asm](engine/dialogue/dialogue.asm)):** Under `.if LANG != "jpn"`, point `aDialogue.lFontGraphics` / `lFontWidthTable` to the English font/widths, support `$09`/`$0A` (or `DIALOGUE_FONT_0`/`_1`) switching between normal and slim pages, and disable Japanese kana pair-kerning in `aDialogueAdjustPriorCharacterWidth` (or supply English kerning pairs).
  - **Dialogue compiler (`tools/dialogue_build.py`):** Compile UTF-8 `{DIALOGUE_*}` `.txt` files using `locales/eng/text/Dialogue.h` without inserting unnecessary page-switch bytes, validate line pixel widths against dialogue box limits at build time, and pack all compiled `.dialogue.txt` blobs across ExHiROM banks `$50–$6F` into `.build/eng/DialogueLayout.asm`.
- **Proved when:**
  - Sample English Prologue dialogues render cleanly in-game with proportional spacing, slim font, and zero line-overflow warnings.

### Phase 3 — Hybrid English Menu Text System (Option C)
- **Deliverables:**
  - **Plain-text menu sources (`locales/eng/text/menutext/*.asm`):** Characters, Classes, Items, Item Descriptions, Castles, Factions, Terrains, Skills, Statuses, Menu Commands, and Chronology authored in UTF-8.
  - **Build-time VWF compiler (`tools/menu_vwf.py`):** Renders each string using a proportional 2bpp menu font (`locales/eng/gfx/fonts/MenuFont.2bpp.png`) into tight `.2bpp` tile strips and `(tile_count, long_ptr)` descriptor tables in ExHiROM (`$410000+`), enforcing per-field max tile/pixel budgets at build time.
  - **Bank `$83` relief & ASM hooks:** Under `.if LANG != "jpn"`, redirect `aMainDataOffsets` consumers (and menu text drawers in `engine/menus/menu_text.asm`, `engine/castle/`, etc.) from fixed-width Shift-JIS tile lookups to DMA-ing the pre-rendered `.2bpp` strips into BG3 VRAM.
  - **Static UI chrome:** Author static menu labels (Status screen headers, Options, Battle Forecast, Castle facility buttons) as `locales/eng/gfx/ui/layouts/*.scene.json` + PNG sheets using the existing Phase 4 `scene_pack.py` pipeline.
- **Proved when:**
  - Unit/Item/Skill/Data windows, Status screen, Battle Forecast, and Castle shops/arena display crisp proportional English strings with zero truncated fields or Bank `$83` overflow.

### Phase 4 — Localized Graphics Overrides
- **Deliverables:**
  - Extend `build.py`, `tools/scene_pack.py`, and `tools/stream_layout.py` to check `locales/<lang>/gfx/` before `gfx/`, and route any localized compressed stream that outgrows its original `.streams` region into `locales/eng/gfx/eng.streams` in ExHiROM (`$410000+`).
  - Selectively adapt hand-translated English visuals (referencing Lil' Nordion where appropriate, with attribution) into authored PNGs / `.scene.json` / CSV layouts under `locales/eng/gfx/`:
    1. `OpeningCreditsPage1–8` (`gfx/scenes/screens/`)
    2. `TitleIntroCaption01–13` (`gfx/scenes/screens/`)
    3. `GenealogyWheel` (`gfx/ui/layouts/`)
    4. `ChapterIntroBanners` (`gfx/ui/layouts/`)
    5. `EpilogueRankingBG1–2` (`gfx/scenes/screens/`)
    6. `BattleStats`, `BattleLevelUp`, `MapBattleLevelUpText` (`gfx/ui/`, `gfx/effects/battle_scene/`)
    7. `AntiPiracyWarning` / `AbnormalityWarning` (`gfx/scenes/screens/`)
    8. `WorldMap` (`gcWorldMapTiles`, `gcWorldMapTilemap`, `gcWorldMapTileset` — add 16×16 metatile support in `scene_pack.py` or provide localized override).
- **Proved when:**
  - `scene_pack.py` and `stream_layout.py` build all localized scenes/UI sheets cleanly into ExHiROM without modifying vanilla `gfx/` files.

### Phase 5 — English Sorting, Formatting & UI Polish
- **Deliverables:**
  - **Alphabetical sorting:** Auto-generate `locales/eng/data/ItemSortOrder.asm` directly from `locales/eng/text/menutext/ItemNames.asm` at build time (replacing the kana sort table in [engine/menus/item_window.asm](engine/menus/item_window.asm) under `.if LANG != "jpn"`), plus any character/unit sort tables.
  - **Authored layout fixes:** Handle English label alignment (such as Battle Level-Up stat columns) directly in our authored tilemap grids (`gfx/effects/battle_scene/` / `locales/eng/gfx/`) rather than runtime RAM patches.
  - **Grammar & window sizing hooks:** Any `.if LANG != "jpn"` word-order adjustments (e.g. dynamic item/unit name insertion templates in shops, popups, and battle messages) and widened dialogue/menu boxes where needed.
- **Proved when:**
  - Item sorting in the Item Window / Convoy orders items A–Z, and Level-Up / shop / popup screens align cleanly.

### Phase 6 — Automated Testing & Emulator Verification
- **Deliverables:**
  - Extend `python3 build.py test` to validate:
    1. `--lang jpn`: 100% byte-identical to `fe4.sfc` + all 21 existing self-tests.
    2. `--lang eng`: clean 8 MB ExHiROM assembly, `checksums.py --verify`, dialogue pixel-width budgets, and `menu_vwf.py` tile-width budgets.
  - **Emulator smoke-test checklist** (Mesen / bsnes): boot, title/intro captions, Prologue opening + map dialogue, map menus + alphabetical item sort, Status/Unit/Item/Skill/Data windows, Battle Forecast, Battle Scene + Level-Up, Castle shops/arena/augury, World Map, and Epilogue/Rankings.

---

## 5. Key Technical Pitfalls to Watch

1. **ExHiROM header mirroring:** Accurate SNES emulators and flash carts inspect `$00FFB0–$00FFFF` *and* `$40FFB0–$40FFFF` (for map mode `$35`). Both must carry identical headers/vectors and valid 8 MB checksums.
2. **`rlDecompressor` across ExHiROM banks:** Verify whether `rlDecompressor` (`engine/core/graphics/decompressor.asm`) assumes `$80`-mirrored banks (`$80–$FF`) when incrementing banks at `$FFFF -> $0000` (e.g. `$C0 -> $C1` vs `$40 -> $41`, or `$7D` boundary).
3. **Bank `$83` 16-bit offsets:** `aMainDataOffsets` stores 16-bit offsets relative to `$83/8000`. Under `LANG != "jpn"`, consumers of `aCharacterNames`, `aClassNames`, `aItemNames`, `aItemDescriptions`, `aCastleNames`, `aFactionNames`, and `aTerrainNames` must use 24-bit pointers (or indirect into ExHiROM descriptor tables) rather than truncating to Bank `$83`.
4. **Menu BG3 VRAM tile budgets:** Each menu screen allocates a fixed number of BG3 tiles for dynamic text; `tools/menu_vwf.py` must enforce per-context max tile counts at build time so strings never overwrite adjacent window borders or icons.
5. **Attribution:** Document attribution in `README.md` / `locales/eng/README.md` for the reused Lil' Nordion English dialogue font and any adapted hand-translated visual graphics.
