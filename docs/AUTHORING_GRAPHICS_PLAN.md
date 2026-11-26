# Author-Facing Graphics Pipeline Plan

A phased plan for moving FE4's graphical artifacts from **VRAM/binary blobs** up to **author-facing objects** with full bidirectional round-tripping (`authored source` ↔ `SNES tiles / tilemaps / OAM / LZ blobs`), while keeping `./build.sh` byte-identical on unmodified assets.

---

## Core Architecture (How Byte-Identical + Moddable Coexist)

The existing build pipeline is:

```
.4bpp.png ──(gfx.py png2bpp)──► .4bpp ──(gfx.py lz)──► .4bpp.lz ──(stream_layout.py)──► Layout.asm ──► 64tass
.bin ─────────────────────────────────(gfx.py lz)──► .bin.lz  ──┘
```

Two parts of it already do most of what an authoring layer needs:

- **Recompression fallback.** `gfx.py lz` keeps the committed original stream `NAME.comp` as long as it still decompresses to the current `.4bpp`/`.bin`, and only recompresses an edited file. Unedited assets stay byte-identical without any hash bookkeeping.
- **Stream relocation.** [tools/stream_layout.py](../tools/stream_layout.py) places every stream in a `.streams` list one after another, splits streams across bank halves, and fails if a region overflows. A graphic that compresses to a different size moves everything after it, and the pointer tables move with it ([tools/backgrounds.py](../tools/backgrounds.py) `--self-test` proves this end to end).

Adding an **authoring layer** puts one stage in front of it:

```
Author-facing object (assembled PNG / Tiled map / sprite sheet / scene PNG)
        │
        ▼  asset compiler (slice, match tiles, palette-map, build tilemap/OAM)
VRAM blobs (.4bpp / .bin / palette .asm)
        │
        ▼  existing pipeline (gfx.py lz + stream_layout.py + 64tass)
ROM (byte-identical when unmodified; repacked & recompressed when edited)
```

**Key design rules:**

1. **Compilers must reproduce the existing blobs from unedited sources.** For fixed-layout assets (portraits, icons, fonts, map movement sprites) slicing is 1-to-1, so this is automatic. For tilemap assets (backgrounds, title/opening screens, UI screens) the packer starts from the existing tile order and only appends new tiles (see Phase 3), so an unedited scene packs to the same `.4bpp` and `.bin`, and the `.comp` fallback above does the rest.
2. **No information may live only in a generated file.** Anything the PNG cannot hold (per-tile palette choice, flip and priority bits, which entries share graphics) stays in a committed source file next to it, in a documented format.
3. **Hard SNES budget checks at build time:** every compiler validates VRAM tile count, palette count (16 colors per 4bpp sub-palette, 4 per 2bpp), and OAM entry budget, failing with a clear error. Region size is already checked by `stream_layout.py`; a full region is fixed by moving a stream to another `.streams` list with free space, not by the compiler.
4. **Generated files stay gitignored.** `.4bpp`, `.2bpp` and all `.lz` files already are. When an asset class is promoted, the files its compiler writes (for example `.bin` tilemaps built from a scene) join them, and `./build.sh clean` deletes them. The `.comp` streams stay committed.

---

## Phased Rollout Plan (Ordered by Cost and Readiness)

### Phase 1 — Wire the map decoders into the build (`12` chapter maps, `120` map-battle sprite data streams) — **done (2026-11-26)**

- **Chapter maps:** each of the 32 streams in [gfx/compressed/C70C80/](../gfx/compressed/C70C80/) now has one CSV source beside it, and `tools/chapter_maps.py build` (run by build.sh) writes the `.bin` that `gfx.py lz` compresses. `acChapterMap*Layout.csv` is the 64×64 grid of map words in hex (bits 0–9 tile ID, bits 10–15 the area a chapter can close). `*TileEntries.csv` is one row per tile ID 0–255, with four entries written `TILE:PALETTE` plus `p`/`h`/`v`; IDs 256–1023 are `aBaseMapTileEntries`. `*Terrain.csv` is one row per tile ID, named from `include/Terrain.h`. Values `$1A`–`$35` have no name and stay hex (open question in [map.md](reference/map.md)).
- **Map-battle sprite data:** the earlier JSON format guessed structure from byte ranges and could not change size. It was replaced by assembly source (`gfx/compressed/*/aMapBattle*Layout*.asm`) in the style of `aGiveGoldCoinSpriteData`, decoded along what the code reads. That means five block offsets by weapon type; blocks of a frame table, two unread words and (main, aux) script pairs; frames as `.structSpriteEntry` arrays; scripts as `ACTIVE_SPRITE_*` commands; and every offset a label difference. `tools/map_battle_layouts.py build` assembles each with 64tass. `MAP_BATTLE_SPRITE_DATA_END` pads to the original size and fails past `$880` bytes, the distance between the two sides' buffers. The format is in the tool's docstring and [map_battle.md](reference/map_battle.md).
- **Proved:** both self-tests round-trip every stream from its `.comp` and check the committed sources. The sprite data test adds a sprite to a frame and checks that the rest moves while every frame and script parses the same. A clean build is byte-identical. An edited sprite frame and terrain entry built with `./build.sh mod` reached the ROM, and the following streams moved and still decompress correctly. The generated `.bin` files are gitignored and removed by `./build.sh clean`.
- **Left for later:** the Tiled export (Step 2 below) and a sprite data preview (Phase 5).
- **Step 2 (optional editor format):** export **Tiled `.tmj` maps** (a shared `BaseMapTileset.tsx` plus one tileset per chapter) with a visual layer of 16×16 tiles (`64×32` for the Prologue, `64×64` for Chapters 1–Final), a terrain layer and an area layer (bits 10–15), and import them back to the same CSVs.

---

### Phase 2 — Portraits (`152` graphics, `248` pointer entries)
*Large visual payoff; the face is a 1-to-1 slice.*

- **Current state:** `gfx/portraits/*.4bpp.png` are the 64 tiles in storage order, four rows of 16 ([tools/portraits.py](../tools/portraits.py) describes the layout). `rsDialogueLoadPortraitWriteTilemap` ($91/9739) builds the 6×8 tile face from columns 0–5 (top half) and 6–11 (bottom half). Columns 12–15 are not part of the face. They are *probably* the mouth and eye frames, but no routine that reads them has been identified yet. Palettes are in [data/portraits/PortraitPalettes.asm](../data/portraits/PortraitPalettes.asm), selected per entry by `PortraitPalettePointers.csv`.
- **Graphics and palettes are not 1-to-1.** `PortraitGraphicPointers.csv` and `PortraitPalettePointers.csv` have 248 entries but there are 152 graphics. Entries $B9–$F2 are generic class cards (portrait ID $F3 in character data means "use the class's card", via `rlTryGetClassPortraitDataID` and `aClassPortraitDataIDs`), and $73, $74, $9C, $F3 and $F4 share one horseman card with different palettes. The authoring format must keep graphics and palettes separate.
- **Author-facing object:**
  - One indexed PNG per **graphic** (`gfx/portraits/AdultFinn.png`): the assembled `48×64` face, with columns 12–15 kept beside it as a `32×32` block of tiles in storage order. The PNG's palette is the palette of the first entry that uses the graphic, for viewing only; the pixel indices are what get packed.
  - Palettes stay in `PortraitPalettes.asm` (one `bgr555()` palette per label, already editable), and the pointer CSVs stay as they are. A generated `portraits.txt` (already written by portraits.py) lists which entries use each graphic with which palette.
- **Round-trip tool (`tools/portrait_pack.py`):**
  - `unpack`: assembles the face from the `.4bpp.png` tile strip and writes the authored PNG.
  - `pack`: slices the face and the 32×32 block back into the exact 64-tile (`$800`-byte) strip.
  - `--self-test`: unpack and pack all 152 graphics and compare bytes.
- **Before the animation frames can be laid out as frames:** find and read the routine that copies columns 12–15 during dialogue (search the dialogue code around `rsDialogueLoadPortraitWriteTilemap` for reads of tile offsets 12–15 or of the portrait's VRAM base plus `$180`). Once its frame size and which face tiles each frame replaces are known, the 32×32 block can be redrawn as positioned mouth and eye frames. Until then it stays raw.
- **Risk:** Very low for the face. The frame layout is blocked on the routine above.

---

### Phase 3 — Static Full-Screen Scenes & Backgrounds (`24` dialogue/battle backgrounds, `~40` title/opening/credits/world-map scenes, `14` battle banners)
*Big readability win; introduces the reusable tilemap packer that Phase 4 also uses.*

- **Current state:** split across `.4bpp.png`/`.2bpp.png` tile sheets, raw `.bin` tilemaps (`25` background tilemaps, `39` title/opening/credits, `9` world-map/epilogue) and palettes in `data/palettes/`. [tools/backgrounds.py](../tools/backgrounds.py) already renders the dialogue, battle and map-battle magic backgrounds as the game composes them, from the built ROM, and its `--self-test` checks that an edited tile and tilemap entry reach the ROM and that later streams move correctly.
- **Author-facing object:** one **assembled scene PNG** per screen (`256×224`, `256×160`, or the tilemap's own size), plus a committed `NAME.scene.json` holding everything the PNG cannot:
  - BG mode and bit depth, tilemap size, VRAM base tile index, and which sub-palettes (`0–7`) the scene may use;
  - the tile sheet(s) it draws from, in order (the existing `.4bpp.png` stays committed as the seed tile order);
  - the priority bit per tilemap entry, stored as a 1-bit `NAME_priority.png` mask when any bit is set;
  - for scenes that share a tile sheet or are layered (two dialogue backgrounds on one sheet, `CloisterForegroundTilemap` over its background), the list of scenes packed together.
- **Round-trip tool (`tools/scene_pack.py`):**
  - `unpack`: renders tiles + tilemap + palettes into the scene PNG and writes the `.scene.json` and priority mask. The palette for each 8×8 cell comes from its tilemap entry, so the PNG is a direct-color render; `unpack` also checks that re-packing it reproduces the `.bin` exactly.
  - `pack`:
    1. Split the image into 8×8 cells.
    2. For each cell, find the sub-palette whose colors cover it exactly (fail if none does, naming the cell and the colors that are missing; quantizing is the artist's job, not the packer's).
    3. Match the cell, converted to that palette's indices, against the **existing tiles in their committed order**, trying all four flip combinations. When several tiles or palettes match, prefer the choice the original tilemap entry made (read from the previous `.bin` when present), so unedited cells keep their exact entry.
    4. Append a new tile only for a cell nothing matches.
    5. Check the tile count against the VRAM budget and write `.4bpp` + `.bin` (and the palette `.asm` if palettes are edited in the PNG).
  - `--self-test`: unpack and pack every scene and compare `.4bpp` and `.bin` bytes.
- **Why seed from the existing order instead of deduplicating from scratch:** a fresh deduplicator assigns tile IDs in scan order, which differs from the ROM's, so every unedited scene would need a fallback and every one-pixel edit would renumber the whole tilemap. Seeding keeps unedited scenes byte-identical and keeps the diff of an edit to the tiles and entries that actually changed. Tiles that an edit leaves unused are kept, not compacted, unless `pack --compact` is passed.
- **Open question:** whether any of these sheets hold tiles that no tilemap here references (used by code or by another screen). `unpack` should report unreferenced tiles per sheet so they are not mistaken for garbage.

---

### Phase 4 — UI Screens, Menus, Icons & Fonts (`18` UI sheets, `59` UI/menu tilemaps, `1` item-icon sheet, `3` fonts)

- **Item icons ([gfx/ItemIcons.4bpp.png](../gfx/ItemIcons.4bpp.png)):** Already near author-facing; optionally split into named `16×16` PNGs (`IronSword.png`, …) or keep as a labeled grid with a manifest so adding an icon auto-updates [data/item/ItemIconOffsets.asm](../data/item/ItemIconOffsets.asm).
- **Fonts (`gfx/font/DialogueFont*.2bpp.png`):** Already editable 2bpp sheets; pair with a glyph-grid visualizer that overlays character codes and widths from [data/dialogue/DialogueFontWidth.asm](../data/dialogue/DialogueFontWidth.asm).
- **UI windows & tilemaps (`28` in `gfx/ui/tilemaps/` + `31` in `gfx/compressed/`):**
  - Status screen (`StatusScreenTilemap1–3`), unit window pages (`UnitWindowPage0–5`), castle courtyard/town, shop screen, genealogy wheel, dialogue boxes, save menu.
  - Use `tools/scene_pack.py` from Phase 3 with the shared sheets (`WindowFrames`, `MenuLabels`, `SkillIcons`, …) as the seed and appending **disabled**: a UI layout may only use tiles that already exist in its sheets, and new art goes into the sheet itself. Artists edit either the shared sheet or the assembled layout PNG.

---

### Phase 5 — Map Sprites & Map-Battle Animations (`97` movement sprites, `2` standing sheets, `557` map-battle sheets, `120` OAM layouts)

- **Current state:**
  - `gfx/MapMovementSprites/*.4bpp.png` and `StandingMapSprites1–2.4bpp.png` are already editable sprite sheets (just in compact VRAM tile order).
  - Map-battle animations have `557` tile sheets and `120` sprite data streams, assembly source since Phase 1 ([tools/map_battle_layouts.py](../tools/map_battle_layouts.py)). There is no preview yet. A frame does not hold its own picture: its tiles from `$20` (`$28` for side 1) are the graphics frame the script last uploaded with command `$03`, from the paired `g4bppcMapBattle*` stream through `aMapBattleSpriteDMATable`, and the rest depend on each sprite's tile base. A preview therefore has to step a script, as `tools/battle_animation.py` does for battle scenes.
- **Author-facing object:**
  - **Map sprites:** Standard frame-grid PNGs (e.g., 4 directions × N frames at `16×16` / `16×24` per cell) that slice deterministically back to VRAM order.
  - **Map-battle animations:**
    - **Level A:** the sprite data sources from Phase 1 plus the `.4bpp.png` sheets, with a preview that steps each script (frame uploads by `$03`, frames by `$0E`) into strips or GIFs.
    - **Level B (optional, full artist workflow):** Per-animation **assembled frame strip PNG** (`frame_0.png`, `frame_1.png`, …) + an OAM packer that greedily covers non-transparent regions with 8×8 and 16×16 SNES OAM sprites, deduplicates tiles, and emits both the `.4bpp` sheet and `aMapBattle*Layout*.bin`.

---

### Phase 6 — Full Battle Scene Animations (`337` `.4bpp.png`, `49` `.bin`, `frames_98–9B.asm`, `moves.asm`)
*Hardest / most complex system — best tackled last.*

- **Current state:** Battle scene combatants are composite sprites (body + weapon + cape/mount pieces assembled from `data/battle_animation/frames_98–9B.asm`, driven by [data/battle_animation/moves.asm](../data/battle_animation/moves.asm), colored by [data/palettes/BattleAnimationPalettes.asm](../data/palettes/BattleAnimationPalettes.asm)).
- **Author-facing object:**
  - **Level A:** Keep the tile sheets editable as indexed PNGs, add a **preview/timeline renderer** (combining `moves.asm` + `frames_98–9B.asm` + `BattleAnimationPalettes.asm` into animated GIFs / sprite sheets so artists can immediately see edits in motion).
  - **Level B (optional):** An OAM-covering frame compiler (same core greedy 8×8 / 16×16 sprite packer as Phase 5 Level B) that takes assembled animation frame PNGs + anchor points and generates the tile sheet + `frames_*.asm` OAM lists, validating against FE4's per-frame OAM and VRAM transfer budgets.

---

## Not yet covered

- **Palettes as authored objects.** `data/palettes/*.asm` and `PortraitPalettes.asm` are already editable `bgr555()` text; a swatch preview per file would help, but no compiler is needed.
- **Animated map tiles** (`gfx/map/MapTileAnimations1–2.4bpp.png`): need the frame order and timing from the map tile animation code before a frame-strip format makes sense.

---

## Summary Roadmap

| Phase | Asset Class | Count | Round-Trip Complexity | Existing Foundation |
|---|---|---:|---|---|
| **1** ✓ | Chapter maps, map-battle sprite data (source + build wiring) | 32 map streams, 120 sprite data | Done | [tools/chapter_maps.py](../tools/chapter_maps.py) (CSV), [tools/map_battle_layouts.py](../tools/map_battle_layouts.py) (assembly) |
| **2** | Portraits | 152 graphics, 248 entries | **Easy** for the face; frames blocked on code | [tools/portraits.py](../tools/portraits.py) (export only) |
| **3** | Backgrounds & full-screen scenes | ~78 scenes | **Medium** (seeded tile matching + sub-palette) | [tools/gfx.py](../tools/gfx.py), [tools/backgrounds.py](../tools/backgrounds.py), `data/palettes/` |
| **4** | UI tilemaps, icons, fonts | ~80 assets | **Medium** (fixed-sheet tilemap match) | `tools/scene_pack.py` from Phase 3 |
| **5** | Map sprites & map-battle animations | 99 sheets + 557 battle sheets | **Medium–Hard** (OAM packing, Level B only) | Phase 1 layouts |
| **6** | Battle scene animations | 337 sheets + scripts | **Hard** (multi-piece OAM + DMA budgets) | `data/battle_animation/` |
