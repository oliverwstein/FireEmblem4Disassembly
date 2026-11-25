# Author-Facing Graphics Pipeline Plan

A phased plan for moving FE4's graphical artifacts from **VRAM/binary blobs** up to **author-facing objects** with full bidirectional round-tripping (`authored source` ↔ `SNES tiles / tilemaps / OAM / LZ blobs`), while keeping `./build.sh` byte-identical on unmodified assets.

---

## Core Architecture (How Byte-Identical + Moddable Coexist)

The existing build pipeline is:

```
.4bpp.png ──(gfx.py png2bpp)──► .4bpp ──(gfx.py lz)──► .4bpp.lz ──(stream_layout.py)──► Layout.asm ──► 64tass
```

Adding an **authoring layer** puts one stage in front of it:

```
Author-facing object (assembled PNG / Tiled map / sprite sheet / scene PNG)
        │
        ▼  asset compiler (slice, dedup, palette-map, build tilemap/OAM)
VRAM blobs (.4bpp / .bin / palette .asm)
        │
        ▼  existing pipeline (gfx.py lz + stream_layout.py + 64tass)
ROM (byte-identical when unmodified; repacked & recompressed when edited)
```

**Key design rules:**

1. **Dual-mode compilation (exact vs. repacked):**
   - For **fixed-layout** assets (portraits, icons, fonts, map movement sprites), the mapping between the assembled image and VRAM tiles is 1-to-1 and deterministic—slicing the authored PNG always reproduces the exact ROM bytes.
   - For **deduplicated tilemap** assets (backgrounds, title/opening screens, UI screens), a naïve tile deduplicator won't always assign tile IDs in the original ROM's order. To keep unmodified assets byte-identical while letting edited ones repack freely, each authored asset keeps a lightweight `.meta.json` (or falls back to the committed `.bin.comp`/`.4bpp.comp` when the authored PNG hash matches the original), and runs full tile-slicing + deduplication + palette/flip matching whenever the authored PNG changes.
2. **Hard SNES budget checks at build time:** Every compiler validates VRAM tile count, palette count (16 colors per 4bpp sub-palette, 4 per 2bpp), OAM entry budget, and `.streams` region size, failing with a clear error instead of silent corruption.
3. **Generated blobs become gitignored:** Once an asset class is promoted, its `.4bpp` / `.bin` intermediate files are generated in `build.sh` and deleted by `./build.sh clean` (keeping `.comp` streams for byte-identical LZ fallback).

---

## Phased Rollout Plan (Ordered by Impact & Complexity)

### Phase 1 — Portraits (`152` portraits + palettes)
*Highest visual payoff; 100% deterministic 1-to-1 packing.*

- **Current state:** `gfx/portraits/*.4bpp.png` are 16×4 VRAM tile strips (columns 0–5 = top half, 6–11 = bottom half, 12–15 = mouth/eye frames), separated from [data/portraits/PortraitPalettes.asm](../data/portraits/PortraitPalettes.asm).
- **Author-facing object:** One assembled indexed PNG per portrait (e.g. `assets/portraits/AdultFinn.png`):
  - Left `48×64` region: the assembled face (as rendered in-game).
  - Right `32×32` (or `32×64`) region: the 16 mouth/eye animation tiles laid out as coherent 16×16 / 32×16 animation frames rather than raw columns 12–15.
  - Palette embedded directly in the PNG's 16-color index table (with a manifest noting portraits that intentionally share graphics with different palettes, like the horseman/class cards).
- **Round-trip tool (`tools/portrait_pack.py`):**
  - `unpack`: assembles the `152` portraits from `gfx/portraits/*.4bpp` + `PortraitPalettes.asm`.
  - `pack`: slices the `48×64` face + animation frames back into the exact 64-tile (`$800`-byte) VRAM strip and optionally exports the BGR555 palette.
- **Risk:** Very low. No tile deduplication needed; byte-identical round-trip is exact.

---

### Phase 2 — Chapter Maps (`12` maps: `10` tilesets, `10` metatile tables, `12` layouts, `10` terrain tables)
*Tools already exist and pass 12/12 byte-identical round-trip tests.*

- **Current state:** [tools/chapter_maps.py](../tools/chapter_maps.py) already decodes/encodes `layout.csv`, `metatiles.json`, and `terrain.json` and renders previews using [gfx/map/BaseMapTileEntries.bin](../gfx/map/BaseMapTileEntries.bin).
- **Author-facing object:** **Tiled `.tmx` / `.tmj` maps** (plus a shared `BaseMapTileset.tsx` and per-chapter `ChapterXXTileset.tsx`):
  - Layer 1: **Visual map** (`64×32` for Prologue, `64×64` for Ch. 1–Final) painting directly with 16×16 metatiles (rendered with the chapter's actual palette).
  - Layer 2 (or tile property): **Terrain ID** per metatile.
  - Metatile definitions (`metatiles.json` / `.tsx`) stay editable if someone wants to build new 16×16 tiles from 8×8 graphics.
- **Round-trip tool (extend [tools/chapter_maps.py](../tools/chapter_maps.py)):**
  - `decode`: emits Tiled-compatible `.tmj` + tileset preview PNGs (or `layout.csv` + `metatiles.json` + `terrain.json`) into `data/maps/<Chapter>/`.
  - `encode`: compiles back to `*Layout.bin`, `*TileEntries.bin`, `*Terrain.bin` (wired into `build.sh` before `gfx.py lz`).
- **Risk:** Low. Exact round-trip is already proven.

---

### Phase 3 — Static Full-Screen Scenes & Backgrounds (`24` dialogue/battle backgrounds, `~40` title/opening/credits/world-map scenes, `14` battle banners)
*Big readability win; introduces the reusable tilemap + deduplication engine.*

- **Current state:** Split across `.4bpp.png` tile sheets + raw `.bin` tilemaps (`25` background tilemaps, `39` title/opening/credits `.bin`, `9` world-map/epilogue `.bin`) + separate palettes in `data/palettes/`.
- **Author-facing object:** One **assembled scene PNG** per background/screen (e.g. `256×224` or `256×160` full-color or multi-palette PNG) + a small `.scene.json` recording SNES constraints (BG mode, tilemap dimensions, VRAM base tile index, which BG sub-palettes `0–7` are available, and any priority-bit mask PNG if needed).
- **Round-trip tool (`tools/scene_pack.py`):**
  - `unpack`: renders each tileset + tilemap + palette into a single editable scene PNG (+ optional priority overlay PNG).
  - `pack`:
    1. Splits the image into 8×8 tiles.
    2. Quantizes/assigns each 8×8 tile to one of the allowed 16-color BG sub-palettes (or reads palette indices directly if authored with a palette-hinted format).
    3. Deduplicates tiles modulo horizontal/vertical flips (`H-flip`, `V-flip`).
    4. Checks the unique tile count against the scene's VRAM tile budget and emits `.4bpp` + `.bin` tilemap + palette `.asm`.
- **Tricky edge cases:**
  - **Shared tilesets across multiple screens** (e.g., two dialogue backgrounds sharing one tileset, or parallax foreground/background layers like `CloisterForegroundTilemap`). Handle by grouping coupled scenes in one `.scene.json` so they pack into a single shared tileset.
  - **Priority bits** (tiles that draw in front of sprites): preserve via a separate 1-bit `*_priority.png` mask when non-empty.

---

### Phase 4 — UI Screens, Menus, Icons & Fonts (`18` UI sheets, `59` UI/menu tilemaps, `1` item-icon sheet, `3` fonts)

- **Item icons ([gfx/ItemIcons.4bpp.png](../gfx/ItemIcons.4bpp.png)):** Already near author-facing; optionally split into named `16×16` PNGs (`IronSword.png`, …) or keep as a labeled grid with a manifest so adding an icon auto-updates [data/item/ItemIconOffsets.asm](../data/item/ItemIconOffsets.asm).
- **Fonts (`gfx/font/DialogueFont*.2bpp.png`):** Already editable 2bpp sheets; pair with a glyph-grid visualizer that overlays character codes and widths from [data/dialogue/DialogueFontWidth.asm](../data/dialogue/DialogueFontWidth.asm).
- **UI windows & tilemaps (`28` in `gfx/ui/tilemaps/` + `31` in `gfx/compressed/`):**
  - Status screen (`StatusScreenTilemap1–3`), unit window pages (`UnitWindowPage0–5`), castle courtyard/town, shop screen, genealogy wheel, dialogue boxes, save menu.
  - Use `tools/scene_pack.py` from Phase 3 in **fixed-tileset mode** (since UI screens share common tile sheets like `WindowFrames`, `MenuLabels`, `SkillIcons`): artists can edit either the shared tile sheet or the assembled UI layout PNG, and the packer matches tiles against the shared sheet to emit the `.bin` tilemap.

---

### Phase 5 — Map Sprites & Map-Battle Animations (`97` movement sprites, `2` standing sheets, `625` map-battle sheets, `120` OAM layouts)

- **Current state:**
  - `gfx/MapMovementSprites/*.4bpp.png` and `StandingMapSprites1–2.4bpp.png` are already editable sprite sheets (just in compact VRAM tile order).
  - Map-battle animations have `625` tile sheets + `120` `aMapBattle*Layout*.bin` OAM frame tables; [tools/map_battle_layouts.py](../tools/map_battle_layouts.py) already decodes/encodes all 120 layouts to JSON and renders assembled frame strips.
- **Author-facing object:**
  - **Map sprites:** Standard frame-grid PNGs (e.g., 4 directions × N frames at `16×16` / `16×24` per cell) that slice deterministically back to VRAM order.
  - **Map-battle animations:**
    - **Level A (immediate):** Wire [tools/map_battle_layouts.py](../tools/map_battle_layouts.py)'s `.json` OAM layouts directly into `build.sh` alongside the `.4bpp.png` sheets, with rendered preview strips for verification.
    - **Level B (full artist workflow):** Per-animation **assembled frame strip PNG** (`frame_0.png`, `frame_1.png`, …) + an OAM packer that greedily covers non-transparent regions with 8×8 and 16×16 SNES OAM sprites, deduplicates tiles, and emits both the `.4bpp` sheet and `aMapBattle*Layout*.bin`.

---

### Phase 6 — Full Battle Scene Animations (`337` `.4bpp.png`, `49` `.bin`, `frames_98–9B.asm`, `moves.asm`)
*Hardest / most complex system — best tackled last.*

- **Current state:** Battle scene combatants are composite sprites (body + weapon + cape/mount pieces assembled from `data/battle_animation/frames_98–9B.asm`, driven by [data/battle_animation/moves.asm](../data/battle_animation/moves.asm), colored by [data/palettes/BattleAnimationPalettes.asm](../data/palettes/BattleAnimationPalettes.asm)).
- **Author-facing object:**
  - **Level A:** Keep the tile sheets editable as indexed PNGs, add a **preview/timeline renderer** (combining `moves.asm` + `frames_98–9B.asm` + `BattleAnimationPalettes.asm` into animated GIFs / sprite sheets so artists can immediately see edits in motion).
  - **Level B:** An OAM-covering frame compiler (same core greedy 8×8 / 16×16 sprite packer as Phase 5 Level B) that takes assembled animation frame PNGs + anchor points and generates the tile sheet + `frames_*.asm` OAM lists, validating against FE4's per-frame OAM and VRAM transfer budgets.

---

## Summary Roadmap

| Phase | Asset Class | Count | Round-Trip Complexity | Existing Foundation |
|---|---|---:|---|---|
| **1** | Portraits | 152 | **Easy** (1-to-1 deterministic) | [tools/portraits.py](../tools/portraits.py) (export only) |
| **2** | Chapter maps | 12 maps (42 files) | **Easy** (already round-trips) | [tools/chapter_maps.py](../tools/chapter_maps.py) (12/12 pass) |
| **3** | Backgrounds & full-screen scenes | ~78 scenes | **Medium** (tile dedup + sub-palette) | [tools/gfx.py](../tools/gfx.py), `data/palettes/` |
| **4** | UI tilemaps, icons, fonts | ~80 assets | **Medium** (shared-sheet tilemap match) | `tools/scene_pack.py` from Phase 3 |
| **5** | Map sprites & map-battle layouts | 99 + 120 layouts | **Medium–Hard** (OAM layout / packing) | [tools/map_battle_layouts.py](../tools/map_battle_layouts.py) (120/120 pass) |
| **6** | Battle scene animations | 337 sheets + scripts | **Hard** (multi-piece OAM + DMA budgets) | `data/battle_animation/` |
