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

1. **Compilers must reproduce the existing blobs from unedited sources.** For fixed-layout assets (portraits, icons, fonts, map movement sprites) slicing is 1-to-1, so this is automatic. For tilemap assets (backgrounds, title/opening screens, UI screens) the packer starts from the existing tile order and only adds new tiles, in free blank slots or at the end (see Phase 3), so an unedited scene packs to the same `.4bpp` and `.bin`, and the `.comp` fallback above does the rest.
2. **No information may live only in a generated file.** Anything the PNG cannot hold (per-tile palette choice, flip and priority bits, which entries share graphics) stays in a committed source file next to it, in a documented format.
3. **Hard SNES budget checks at build time:** every compiler validates VRAM tile count, palette count (16 colors per 4bpp sub-palette, 4 per 2bpp), and OAM entry budget, failing with a clear error. Region size is already checked by `stream_layout.py`; a full region is fixed by moving a stream to another `.streams` list with free space, not by the compiler.
4. **Generated files stay gitignored.** `.4bpp`, `.2bpp` and all `.lz` files already are. When an asset class is promoted, the files its compiler writes (for example `.bin` tilemaps built from a scene) join them, and `./build.sh clean` deletes them. The `.comp` streams stay committed.
5. **Every asset class gets an add path, not only an edit path.** From Phase 4 on, a phase is done when an author can both change an existing asset and add a new one of the same kind (see *Adding assets and ROM space*), and its sources sit in the layout below.

---

## Goal and how progress is measured

The goal is one part of the repository, `gfx/`, holding an authorable version of every piece of graphical content, organised by game system, that builds into the ROM and can be expanded: assets edited, and new ones added. Byte-identity on unedited sources is the check that the authored versions are complete.

### Inventory (`tools/gfx_inventory.py`, to write before Phase 4 closes)

Nothing measures how much of the graphics is authorable. The tool lists every graphics stream from every `gfx/**/*.streams` file, and every uncompressed `.4bpp`/`.2bpp`/`.bin` the source includes, and gives each one a form, a system and a phase. It writes `docs/reference/gfx_inventory.md` (generated-file header, do not edit). Forms:

- `authored`: built from an author-facing source (assembled PNG, CSV, assembly, manifest);
- `sheet`: an indexed tile sheet in VRAM order, editable but not as a picture;
- `raw`: a committed `.comp` or `.bin` with no source;
- `unused`: no reader in the code, listed but not converted.

Counts on 2026-11-27, compressed streams only (1,647):

| Form | Streams |
|---|---:|
| Portraits (assembled PNG) | 152 |
| Map-battle sprite data (assembly) | 120 |
| Scene tilemaps (assembled PNG) | 65 |
| Chapter maps (CSV) | 32 |
| Scene seed sheets (seed only; see the layout below) | 48 |
| Tile sheets in VRAM order | 1,011 |
| Raw `.bin`, no source | 219 |

After Phase 4 (from `tools/gfx_inventory.py`, which also counts the 57 uncompressed `.binary` graphics):

| Form | Compressed | Uncompressed | Total |
|---|---:|---:|---:|
| `authored` | 451 | 22 | 473 |
| `sheet` | 995 | 23 | 1,018 |
| `raw` | 152 | 4 | 156 |
| `unused` | 49 | 8 | 57 |
| **Total** | **1,647** | **57** | **1,704** |

The rise in authored compressed streams (369 plus 48 seeds, to 451) is Phase 4's 34 compressed UI and world-map tilemaps. The 48 seed sheets now count as authored, since they are built from their scenes. Every phase reports its before-and-after inventory counts in its *Proved* bullet.

After Phase 5:

| Form | Compressed | Uncompressed | Total |
|---|---:|---:|---:|
| `authored` | 1,048 | 24 | 1,072 |
| `sheet` | 397 | 21 | 418 |
| `raw` | 152 | 4 | 156 |
| `unused` | 50 | 8 | 58 |
| **Total** | **1,647** | **57** | **1,704** |

Phase 5 added 597 compressed streams (97 walking sprites, 500 map battle sheets) and the 2 standing sheets. `g4bppcMapBattleCritUnused4` moved from `sheet` to `unused` (its only reader cannot select it; see Phase 5).

After Phase 6:

| Form | Compressed | Uncompressed | Total |
|---|---:|---:|---:|
| `authored` | 1,048 | 24 | 1,072 |
| `sheet` | 392 | 21 | 413 |
| `raw` | 152 | 4 | 156 |
| `unused` | 55 | 8 | 63 |
| **Total** | **1,647** | **57** | **1,704** |

Phase 6 moved the 231 reachable battle animation streams (`84` class sheets, `65` extra sheets, `64` weapon sheets, `18` character pieces) into `gfx/battle_animation/`, recoloured and built by a tool, with a preview that draws their frames. They stay `sheet`: the PNGs hold tiles in the rows the game uploads them, not pictures of frames (first counted as `authored`, corrected in review). The 5 unreachable streams (`g4bppcBattleAnimationSheet50`, `52`, `Extra03`, `04`, `Weapon12`) moved from `sheet` to `unused`.

After Phase 7:

| Form | Compressed | Uncompressed | Total |
|---|---:|---:|---:|
| `authored` | 1,178 | 24 | 1,202 |
| `sheet` | 377 | 21 | 398 |
| `raw` | 31 | 4 | 35 |
| `unused` | 61 | 8 | 69 |
| **Total** | **1,647** | **57** | **1,704** |

Phase 7 moved all `battle_effects` assets out of `raw` (`121` → `0`): `130` authored (`21` map-battle magic palettes, `25` map-battle magic tilemaps and their `23` seed sheets, `57` battle scene effect tilemaps, `4` battle scene decomp window tilemaps), `71` sheets (`24` map-battle sprite/action/cutscene/ripple sheets, `47` battle scene effect/window/skill sheets, including `10` promoted from `.bin.comp`), and `53` unused (`47` previously unused + `6` unreachable entries in `aBattleSceneDecompressToVRAMTable`).

### Target layout of `gfx/`

Authored sources live in one folder per game system. The ROM-address folders hold only build plumbing.

```
gfx/
  portraits/          NAME.png (80x64)
  scenes/             dialogue/ battle/ screens/ title/ worldmap/   NAME.png + NAME.scene.json
  maps/               chapter map CSVs (Layout, TileEntries, Terrain)
  ui/                 shared sheets + layout manifests (Phase 4)
  fonts/  icons/      (Phase 4)
  map_sprites/        short/ tall/   NAME.png frame grids, standing + walking (Phase 5)
  map_battle/         sprite data .asm (Phase 1), sheets/NAME.png frame grids (Phase 5)
  effects/            battle scene effects, map-battle magic (Phase 7)
  battle_animation/   sheets/ extras/ weapons/ pieces/   NAME.png (Phase 6)
  build/              one folder per ROM region: REGION.streams, the committed NAME.comp
                      originals, and the generated .4bpp/.2bpp/.bin/.lz files
```

- An authored file names where its output goes (a manifest field, or a fixed rule in its tool), as `.scene.json` tilemap paths do. No author has to open `gfx/build/` for an authored asset.
- `gfx/build/` holds, per ROM region, `REGION.streams`, the committed `NAME.comp` originals and the generated files; `gfx/build/portraits/` and `gfx/build/MapMovementSprites/` hold those two classes' streams; `gfx/build/map_sprites/` the generated standing sheets; `gfx/build/ui/tilemaps/` holds the uncompressed UI tilemaps (the committed originals as `NAME.bin.seed`, the generated `NAME.bin`, and the raw tilemaps not yet converted).
- Nothing in `gfx/build/` is edited by hand except `.streams` order, which decides placement, and the tile sheets still in VRAM order (`sheet` in the inventory): about 1,000 `.4bpp.png`/`.2bpp.png` files stay beside their streams until their phase gives them an authored form.
- `build.sh` writes `NAME.4bpp`/`NAME.2bpp` beside every `NAME.4bpp.png`/`NAME.2bpp.png` (gitignored), including the shared UI sheets in `gfx/ui/`.

The migration of Phases 1–3 was done with Phase 4 (2026-11-27): the chapter map CSVs are in `gfx/maps/`, the map-battle sprite data in `gfx/map_battle/`, the portrait streams in `gfx/build/portraits/`; the 48 Phase 3 seed sheets were dropped (manifests name them as `"comp"` and `scene_pack.py` reads the `.comp` directly); the map movement sprites and the uncompressed UI tilemaps moved into `gfx/build/`.

### Adding assets and ROM space

Every phase so far edits assets in place. Adding one (a portrait, a background, a chapter map, a scene) still means editing pointer tables, a `.streams` list and a manifest by hand, and nothing documents the steps. Each class needs:

- **A declared add path.** Name the table the code indexes (`PortraitGraphicPointers.csv` and `PortraitPalettePointers.csv`, `aDialogueBackgroundPointers`, `aBattleBackgrounds`, the chapter map tables), the ID constants, and the limits on the count (an ID width, a table the code bounds-checks, a fixed array). Then a tool command, or failing that a documented checklist, that adds the entry, the source file and the `.streams` line together. Backlog: Phases 1–3 have no add path yet.
- **Room in the ROM: decided 2026-11-27, deferred.** Nothing needs the room until a mod adds content: unmodified builds never do, and an edit that compresses to the same size or smaller already fits. When a mod needs it, the route is ExHiROM (option 2 below). It plays in bsnes, Mesen, snes9x and flash carts. Until then each add path is written down as a checklist (as Phase 5's is) rather than a tool command. Measured in Phase 5: an edit that put new art in a blank map battle frame compressed 12 bytes larger and overflowed `A08000`; recompressing all 97 walking sprites with `tools/compress.py` would free 5,270 of 199,808 bytes (2.6%) and takes about six minutes.
- **Room in the ROM (the options).** Every graphics region is packed with no slack: each `.streams` region ends exactly where its last original stream ends, so an edit that compresses larger than the original fails (so far our compressor has usually beaten the game's). The ROM is already 4 MB, the largest standard HiROM size. The whole ROM is built from source, and the original has only about 99 KB in runs of 1 KB or more of `$00` or `$FF`, some of which may be data. Options, to decide before the first add path ships:
  1. move streams between regions, and reclaim padding that is shown to be unused (each run needs a reader check first);
  2. expand to ExHiROM (up to 8 MB). This means a header and mapping change, and new regions in the added banks for new and grown streams. It would leave every original region byte-identical on an unmodified build.
- **Budgets per asset as well as per region:** VRAM tile budgets (as in Phase 3), palette slots, and any fixed decompression buffer the loader uses.

## Phased Rollout Plan (Ordered by Cost and Readiness)

### Phase 1 — Wire the map decoders into the build (`12` chapter maps, `120` map-battle sprite data streams) — **done (2026-11-26)**

- **Chapter maps:** each of the 32 streams in [gfx/build/C70C80/](../gfx/build/C70C80/) has one CSV source in [gfx/maps/](../gfx/maps/), and `tools/chapter_maps.py build` (run by build.sh) writes the `.bin` that `gfx.py lz` compresses. `acChapterMap*Layout.csv` is the 64×64 grid of map words in hex (bits 0–9 tile ID, bits 10–15 the area a chapter can close). `*TileEntries.csv` is one row per tile ID 0–255, with four entries written `TILE:PALETTE` plus `p`/`h`/`v`; IDs 256–1023 are `aBaseMapTileEntries`. `*Terrain.csv` is one row per tile ID, named from `include/Terrain.h`. Values `$1A`–`$35` have no name and stay hex (open question in [map.md](reference/map.md)).
- **Map-battle sprite data:** the earlier JSON format guessed structure from byte ranges and could not change size. It was replaced by assembly source (`gfx/map_battle/aMapBattle*Layout*.asm`) in the style of `aGiveGoldCoinSpriteData`, decoded along what the code reads. That means five block offsets by weapon type; blocks of a frame table, two unread words and (main, aux) script pairs; frames as `.structSpriteEntry` arrays; scripts as `ACTIVE_SPRITE_*` commands; and every offset a label difference. `tools/map_battle_layouts.py build` assembles each with 64tass. `MAP_BATTLE_SPRITE_DATA_END` pads to the original size and fails past `$880` bytes, the distance between the two sides' buffers. The format is in the tool's docstring and [map_battle.md](reference/map_battle.md).
- **Proved:** both self-tests round-trip every stream from its `.comp` and check the committed sources. The sprite data test adds a sprite to a frame and checks that the rest moves while every frame and script parses the same. A clean build is byte-identical. An edited sprite frame and terrain entry built with `./build.sh mod` reached the ROM, and the following streams moved and still decompress correctly. The generated `.bin` files are gitignored and removed by `./build.sh clean`.
- **Left for later:** the Tiled export (Step 2 below). The sprite data preview came with Phase 5 (`tools/map_battle_sprites.py preview`).
- **Step 2 (optional editor format):** export **Tiled `.tmj` maps** (a shared `BaseMapTileset.tsx` plus one tileset per chapter) with a visual layer of 16×16 tiles (`64×32` for the Prologue, `64×64` for Chapters 1–Final), a terrain layer and an area layer (bits 10–15), and import them back to the same CSVs.

---

### Phase 2 — Portraits (`152` graphics, `248` pointer entries) — **done (2026-11-27)**
*Large visual payoff; the face and mouth frames are a 1-to-1 slice.*

- **Format resolved:** each portrait decompresses to `$800` bytes (64 4bpp tiles, 4 rows of 16). `rsDialogueLoadPortraitWriteTilemap` (`$91/9739`) and `aUnitPortraitSpritesFrame0` (`$8A/9586`) assemble the `48×64` (`6×8`-tile) face from columns 0–5 (top half) and 6–11 (bottom half). `rlUpdateDialoguePortraitOverlayTiles` (`$85/BD12`, using `aDialoguePortraitOverlayTileOffsets`: `.word $0009, $000F, $002F`) and `aUnitPortraitSpritesFrame1`/`2` + `aKeeperPortraitSpritesFrame1`/`2` (`engine/castle/keepers.asm`) read columns 12–15 as **two `32×16` (`4×2`-tile) mouth animation frames** (rows 0–1 and rows 2–3), both replacing `(0, 32)..(31, 47)` on the face. The dialogue overlay has three states: offset `$0009` points at face columns 6–9, rows 0–1 (the face's own closed mouth, put back between frames), and `$000F`/`$002F` at the two frames. Storage has no spare tiles: 48 face tiles plus 16 mouth tiles fill all 64. There are no eye blink frames.
- **Graphics and palettes are not 1-to-1.** `PortraitGraphicPointers.csv` and `PortraitPalettePointers.csv` have 248 entries across 152 graphics (`$B9–$F2` are class cards; `$73, $74, $9C, $F3, $F4` share `ClassCardKnightLord`). Palettes stay in [data/portraits/PortraitPalettes.asm](../data/portraits/PortraitPalettes.asm) (`bgr555()`) and pointer CSVs stay as they are.
- **Author-facing object (`gfx/portraits/NAME.png`):** one `80×64` indexed PNG per graphic (replacing `gfx/portraits/*.4bpp.png`; the streams are in `gfx/build/portraits/`), with the `48×64` face on the left (`x = 0..47`), Mouth Frame 1 at `(48, 32)..(79, 47)` and Mouth Frame 2 at `(48, 48)..(79, 63)`. The `32×32` top-right `(48, 0)..(79, 31)` is padding in the PNG only (no stored tiles map to it) and must be colour index `0` (enforced at pack time). The face is drawn in stored orientation; the game mirrors it for dialogue slot 0 and for keepers. The PNG's palette is for viewing only (the palette of the first entry using the graphic); pixel indices `0–15` are what get packed.
- **Round-trip & build wiring ([tools/portrait_pack.py](../tools/portrait_pack.py)):** `unpack`, `pack`, `build` (run by `build.sh` and `build.bat` before `gfx.py lz`; fails if a `.4bpp.comp` has no `NAME.png`, and deletes a `NAME.4bpp` left behind by a removed PNG), and `--self-test`.
- **Proved:** `tools/portrait_pack.py --self-test` round-trips all 152 `.4bpp.comp` streams and checks all 152 committed `gfx/portraits/*.png` files, verifies a 4-region pixel edit updates only tiles `{$00, $06, $0C, $2C}` and recompresses cleanly via `gfx.lz`, and checks negative validation (mode, dimensions, pixel index range, non-zero unused pixels). Clean build is byte-identical. Stream relocation for an edited portrait was proved in the 2026-11-20 pilot ([HISTORY.md](../HISTORY.md): an edited Sigurd recompressed 13 bytes smaller and all 248 entries still decompressed to their graphics).

---

### Phase 3 — Static Full-Screen Scenes & Backgrounds (`65` tilemap layers in `45` manifests) — **done (2026-11-27)**
*Big readability win; introduces the reusable tilemap packer that Phase 4 also uses.*

- **Author-facing objects (`gfx/scenes/`):** `45` manifests (`*.scene.json`) covering `65` static tilemap layers:
  - `gfx/scenes/dialogue/` (`9` layers): `Fountain`, `Gate`, `Alley`, `Throne` + `ThroneForeground`, `Hallway` + `HallwayForeground`, `Cloister` + `CloisterForeground`, plus `FountainForegroundGroup`, which shares `g4bppcDialogueBackgroundFountainForeground` across `FountainForeground`, `GateForeground` and `BattleForeground3Tilemap1–2`.
  - `gfx/scenes/battle/`: `14` battle backgrounds and `4` two-layer battle foregrounds.
  - `gfx/scenes/screens/`: `GameOver` BG1/BG2, `AntiPiracyWarning`, `AbnormalityWarning`, `OpeningLogo`, `OpeningCreditsPage1–8`, `EpilogueEndScreen` + `EpilogueRankingsBG2`, `EpilogueCreditsBG1–2`, and `TitleIntroCaption01–13`.
- **The scene PNG is the source.** Each layer is an assembled `RGB` or `RGBA` PNG (`256×88`, `256×224`, `256×256`, `512×256`, `256×16`), plus a 1-bit `*_priority.png` mask where any tilemap entry sets bit `$2000`. A sheet a manifest marks `writable` is only the seed tile order, read straight from its `.comp` (`"comp"` in the manifest), so there is no second copy of the art to edit by mistake. A writable sheet given as a `.png` instead must still decode to its `.comp`, or `pack` refuses to run. Colours must already be in one of the layer's allowed sub-palettes; palettes are edited in their `.asm` files, not through the PNG.
- **Manifest (`.scene.json`):** depth (`4` or `2`), palette sources (`.asm` `bgr555()` labels, `.bin.comp`, or `grey`), seed sheets with `max_tiles` VRAM budgets, `writable`, and `external` (a note naming a tilemap outside `gfx/scenes/` that also reads the sheet), and per layer the allowed sub-palettes, sheet bases and `append_sheet`. `pack` checks every index and value before packing.
- **Round-trip tool & build wiring ([tools/scene_pack.py](../tools/scene_pack.py)):**
  - `pack`: matches each 8×8 cell against existing tiles in committed order, trying all four flips and preferring the original tilemap entry when its pixels still match. A cell nothing matches gets a new tile in the layer's `append_sheet`: first in a blank slot that no committed scene tilemap references, then appended up to `max_tiles`. This matters because `25` of the `48` writable sheets are already full, their streams padded with blank tiles up to the budget (all `14` battle backgrounds, five of the seven dialogue pictures, the Throne and Hallway foregrounds, both warning screens, `EpilogueCreditsBG2Tiles` and the opening credits font). A sheet with `external` never gives up blank slots. Fixed-sheet layers set `append_sheet` to `null`.
  - `pack --compact`: drops, from each writable sheet only this manifest uses, the unreferenced blank tiles and the tiles the edit left unreferenced, and renumbers the rest. Tiles no committed scene tilemap ever referenced are kept, since code or another screen may read them. It refuses a sheet that another manifest or an `external` tilemap reads.
  - `unpack [--force]`: renders scene PNGs and priority masks from the committed sheets and `.bin.comp` tilemaps, refuses to overwrite existing PNGs without `--force`, records new masks in the manifest, checks that packing reproduces every `.comp` stream, and reports unreferenced tiles per sheet.
  - `build` / `clean`: wired into `build.sh` and `build.bat` before `gfx.py lz`; all `65` generated `.bin` tilemaps are gitignored and deleted by `./build.sh clean`.
- **VRAM budgets (`max_tiles`) and where they come from.** `structDMAToVRAM` takes byte addresses ([include/DMA.h](../include/DMA.h)).
  - Dialogue pictures `512`, dialogue foregrounds `256`: `$4000` and `$2000`-byte uploads of the decompressed stream, whatever its size ([engine/castle/conversation.asm](../engine/castle/conversation.asm)).
  - Battle backgrounds `512`: `rsBattleSceneLoadBackgroundLayer` uploads `$6000` bytes (768 tiles) from tile 0, but `rsBattleSceneLoadForeground` then writes bytes `$4000`–`$5FFF` and `$7800`, over tiles 512 and up ([engine/battle_scene/loading.asm](../engine/battle_scene/loading.asm)). `ClassChange` is `256`; no code reason has been found, and its stream holds exactly 256 tiles, all referenced.
  - Battle foregrounds `128`: the `$1000`-byte upload to byte `$5000`.
  - The rest (title captions `64`, `OpeningLogo` and `GameOver` `256`, warnings `512`, epilogue `768`/`256`, credits font `768`) are not yet traced to their loaders.
- **Unreferenced tiles (the earlier open question).** Almost all are blank padding up to the budget. Four sheets hold real art no scene tilemap uses: `g4bppcBattleBackgroundTitleIntro` (236 tiles, read by the title scene through `acTitleSceneTilemapF5222D` in `engine/battle_scene/data.asm`, so it is marked `external`), `g4bppcEpilogueEndScreenTiles` (161), `gcOpeningCreditsFont` (138) and `g4bppcDialogueBackgroundGate` (41). `--compact` keeps them.
- **Proved:** `tools/scene_pack.py --self-test` packs all `65` layers byte-identically against their `.bin.comp` and `.4bpp.comp`/`.2bpp.comp` streams. It also checks:
  - appending a tile, and its `gfx.lz` recompression (`OpeningLogo`);
  - a new tile going into the first free blank slot of a full sheet, with no other entry changed (`Plains`, `ThroneForeground`);
  - an `external` sheet refusing its blank slots (`Unused16`);
  - toggling a priority bit with no other entry changed (`ThroneForeground`);
  - `--compact` on `Gate` keeping exactly the referenced and never-referenced art and rendering the same picture, and refusing shared (`Thicket`) and external sheets;
  - the edited-seed-sheet guard, and `unpack` refusing to overwrite before reproducing the PNG with `--force`;
  - errors for off-palette colours, the VRAM budget, disabled append, mixed priority cells and a bad `append_sheet` index.

  A clean build is byte-identical. `tools/backgrounds.py --self-test` edits `Plains.png` in a copy (a copied cell, and a pixel that needs a new tile in the full sheet), builds it with `./build.sh mod`, fails unless the build succeeds and Plains' tiles and tilemap changed, and checks that both reach the ROM while every other battle background entry decompresses unchanged after the streams move.
- **Left as-is / outside static scenes:** the `14` battle banners are already `128×8` indexed tile strips with no tilemap; `gcWorldMapTilemap` uses 16×16 metatiles; dynamic palette-effect title scenes (`acTitleSceneTilemap*`, `acOpeningSkySceneTilemap*`) can be added as `.scene.json` manifests once their palette setups are pinned down.

---

### Phase 4 — UI Screens, Menus, Icons & Fonts (`53` UI/menu/HUD/overlay tilemaps, `1` item-icon sheet, `3` fonts, target layout & inventory) — **done (2026-11-27)**

- **Target layout migration (Phases 1–4):** see *Target layout of `gfx/`* above. Phase 4's sources are in `gfx/ui/` (the shared sheets, as before) and `gfx/ui/layouts/` (`21` manifests, `38` layers), `gfx/scenes/screens/` (`EpilogueRankingBG1–2`), `gfx/scenes/worldmap/` (`WorldMapHighlights`, `13` layers), `gfx/fonts/` and `gfx/icons/`.
- **UI layouts are grids (`53` layers in `24` manifests).** In a fixed-sheet layout all the art lives in the shared sheet (`WindowFrames`, `MenuLabels`, `SkillIcons`, …), so the layout's source is its arrangement: a CSV of tilemap entries, `TILE:PALETTE` plus `p`/`h`/`v`, in the chapter map notation. Editing a sheet changes every layout that uses its tiles; editing a grid rearranges tiles. `tools/scene_pack.py render MANIFEST OUT_DIR` draws previews. (A first version stored each layout as a rendered PNG; a sheet edit then left the PNGs holding the old art, and the packer silently redirected cells to lookalike tiles or failed.)
  - Layouts covered: `StatusScreenTilemap1–3`, `GenealogyWheel*`, `UnitWindowList`, `UnitWindowPage0–5`, `CastleCourtyard`, `CastleTownButton`, `CastleListBG3Template`, `Conversation*Window`, `DialogueBox`, `SaveMenuBG1–2`, `ItemWindowBG1–2`, `SkillWindowBG1`, `DataWindowBG1–2`, `OptionsMenuBG1`, `MenuWindowBackground`, `ReviveScreenBG1–2`, `ChapterIntroBanners`, `CastleTownBG`, `CastleShopAndArenaBG1`, `CastleFacilityBG2`, `AuguryBG`, `ClassChangeBG`, `EpilogueRankingBG1–2`, `BattleSceneHUDWindow`, `BattleSceneHUD`, and `WorldMapHighlights` (`11` region highlights, `WorldMapMarkerShadow`, `WorldMapHighlightUnused`).
  - The `19` uncompressed tilemaps among them build from their grids to `gfx/build/ui/tilemaps/NAME.bin`, checked against the committed original `NAME.bin.seed`.
- **Tile sheets corrected:** `gcRankingScreenTiles` is 2bpp (uploaded for Mode 1 BG3 and read as 2bpp by `acEpilogueRankingBG2Tilemap`), not 4bpp. Three streams left as raw `.bin` are tile sheets, now `.4bpp.png` and renamed: `g4bppcDataWindowBannerTiles` (was `acDataWindowBannerTilemap`; `rsDataWindowLoadBanners` copies each army's banner from it), `g4bppcOptionsMenuTiles`, `g4bppcMapBattleHUDTiles`.
- **Item icons ([gfx/icons/ItemIcons.4bpp.png](../gfx/icons/ItemIcons.4bpp.png), [gfx/icons/ItemIcons.json](../gfx/icons/ItemIcons.json)):** `tools/item_icons.py build` generates [data/item/ItemIconOffsets.asm](../data/item/ItemIconOffsets.asm) (gitignored, wired into `build.sh` and `build.bat`). The JSON's `items` rows are indexed by item ID and must follow `data/item/ItemData.csv` (the build checks the names; the two rows past the last item are `(no item)`). `unpack-icons`/`pack-icons` convert named `16×16` PNGs, `preview` draws labelled sheets.
- **Fonts (`gfx/fonts/DialogueFont*.2bpp.png`):** `tools/font_preview.py` draws glyph grids with dialogue codes (`page:byte`, `1,280` glyphs in 3 sheets) and advance-width guides from [data/dialogue/DialogueFontWidth.asm](../data/dialogue/DialogueFontWidth.asm) (one glyph draws past its width).
- **Add paths:**
  - **Item icons:** `tools/item_icons.py add NAME [PNG] [--item ITEM]` fills the next of the sheet's `128` slots (`111` used; slots `111–127` are blank) and can point an item at it. The sheet is a fixed-size uncompressed block, so this needs no ROM space.
  - **UI layouts:** no data-driven add path. Each layout is loaded by its own screen routine at a fixed VRAM address, so a new layout is a code change. What authors can do is rearrange existing layouts (grids) and redraw or add tiles in the shared sheets within their sizes.
  - **Fonts:** glyphs are edited in place; adding glyphs means a new character code in the dialogue encoding, outside this phase.
- **Inventory:** [docs/reference/gfx_inventory.md](reference/gfx_inventory.md) from `tools/gfx_inventory.py --write` (rules in its docstring; `unused` means no reader in the sources, checked, not taken from the label). Counts are in *Inventory* above. One label named `Unused` had a reader: `g4bppcMapBattleCritUnused4`; Phase 5 showed that reader can never select it.
- **Left as-is in `gfx/build/ui/tilemaps/`:** `6` `Unused*.bin`, `WorldMapDataD97940.bin`, `WorldMapTilemap.bin` (metatiles), `FirstGenerationEndingBG2Tilemap.bin`.
- **Proved:** `tools/scene_pack.py --self-test` (all layers byte-identical; grid edits on an uncompressed and a compressed tilemap change only the edited entries, with LZ round-trip; an edit to `WindowFrames` leaves `UnitWindowList`'s tilemap unchanged and changes its preview; grid layers refuse `append_sheet` and out-of-range tiles), `tools/item_icons.py --self-test`, `tools/font_preview.py --self-test`, `tools/gfx_inventory.py --self-test` (which also fails when the inventory page is out of date), the Phase 1–3 self-tests from their new locations, `tools/backgrounds.py --self-test`, a clean build, and a build of only the files a commit contains (byte-identical).

---

### Phase 5 — Map Sprites & Map-Battle Animations (`97` map sprites, `2` standing sheets, `500` map battle sheets, `120` sprite data streams) — **done (2026-11-27)**

- **Map sprites ([tools/map_sprites.py](../tools/map_sprites.py), `gfx/map_sprites/short/` and `tall/`):** one indexed PNG per map sprite ID, named as in `data/class/MapMovementShortSpritePointers.csv` (65, IDs 0–64) and `MapMovementTallSpritePointers.csv` (32, IDs 0–31, flag `$8000`). Row 0 holds the 3 standing frames, played 0, 1, 2, 1. Rows 1–4 hold the walking frames for each facing in storage order: left, right, up, down (`wMovingUnitSpriteFacing` `$00`, `$08`, `$10`, `$18`), 4 frames each. Cells are `24×24` (short, `96×120`) or `32×32` (tall, `128×160`).
  - **Cell to tiles, from the drawing code.** A short walking frame is `aMovingUnitSprite24x24`: tiles `$20 $21 $24 / $30 $22 $23 / $34 $32 $33`. Its `$22` and `$31` overlap at the centre, and all 1,040 frames store the same pixels in both, so the centre cell writes both. A tall walking frame is `aMovingUnitSprite32x32`: `$20–$23 / $30–$33 / $24–$27 / $34–$37`, nudged at run time by `aMapSpriteWalkOffsets`. A short standing frame is one `16×16` (`aMapSpriteSlotTiles`) at `(4, 8)` in its cell. A tall standing frame is `16×24` at `(8, 8)`. `rlDrawDeployedUnitMapSprites` draws two `16×16` sprites 16 pixels apart, but only six tiles are uploaded (`rsQueueTallStandingMapSpriteFrames`): the upper sprite's top row is never written. Pixels outside the pictures must be colour 0.
  - **Build:** the walking frames go to `gfx/build/MapMovementSprites/NAME.4bpp` (then `gfx.py lz` against the `.comp`). The standing frames of short IDs 0–62 and tall IDs 0–30 go to `gfx/build/map_sprites/StandingMapSprites1–2.4bpp` (uncompressed, `$D70000` and `$DA0000`). Short IDs 63–64 (`SmallOifey`, `ShortEmpty`) and tall ID 31 (`TallEmpty`) have no standing frames, and their row 0 must be blank. The 97 VRAM-order sheets and `gfx/map/StandingMapSprites1–2.4bpp.png` are gone.
  - **Found on the way:** every reader of `aMapSpriteWalkFrameDelays` strips the tall flag, so tall sprites read the short entries (all 9), and the 32 bytes of 14 after them are never read.
- **Map battle sheets ([tools/map_battle_sprites.py](../tools/map_battle_sprites.py), `gfx/map_battle/sheets/NAME.png`):** the 500 graphics streams that `aBattleMapSpriteData` names. Each row (94; `rows` lists them) pairs, for each of 8 facings, a sprite data stream with a graphics stream, plus the tall flag. Facings run clockwise from left: 0 left, 1 up-left, 2 up, 3 up-right, 4 right, 5 down-right, 6 down, 7 down-left (`aMapBattleFacingOffsets`). Each stream is `$2000` bytes:
  - `$0000–$09FF`, the tile blocks: `rlUploadMapBattleSideTiles` uploads `$400` bytes to tiles `$40–$5F` from `$000` (sword, lance, axe), `$400` (bow) or `$600` (staff, tome) (`aMapBattleWeaponTypeTileOffsets`). The PNG shows them as five 16-tile rows, as uploaded, so `16×16` pieces read whole.
  - `$0A00–$0FFF` is zero in every stream; nothing reads it.
  - `$1000` on: 8 frames (`aMapBattleSpriteDMATable`) in the walking-frame format, shown as cells in row 0. A short stream's last `$600` bytes (zero or a repeated filler tile) are kept as three more tile rows.
  - No graphics stream is shared between a short and a tall row. The other two `$2000` streams, `g4bppcMapBattleWeaponIcons` and `...SoloIcons`, stay sheets.
- **Preview (Level A):** `tools/map_battle_sprites.py preview ROW OUT_DIR [--facing F] [--weapon W] [--item ITEM]` steps each block's wait, dodge, strike and ranged scripts (main and aux), read from the `.asm` sources, for side 0, and writes a GIF and a frame strip for each. What it models, all from the code:
  - timing by `$0E` and `$12`, graphics frames by `$03`, moves by `$19`; the strike (`$04`) is marked;
  - tile bases as `rlPushToOAMBufferDualTileBase` applies them: tiles below `$20` as they are, `$20–$3F` plus the base, `$40` and up plus the high base; side 0's main sprite uses 0 and 0, a tall row's aux sprite base `$20`;
  - the weapon in hand: `rlUploadMapBattleWeaponIcon` writes the item's icon over tiles `$40–$43` and `$50–$53`, with its two colours as colours 2 and 3.
  - It leaves out side 1's bases, tiles below `$20`, and the waits on the other side, which go on at once. Level B (an OAM packer from assembled frames) is not started.
- **`g4bppcMapBattleCritUnused4`:** entry 4 of `aMapBattleScriptedCritSprites`, read by `wBattleCriticalType - 1`. `rlActionStructGetScriptedCritPossibility` returns only types 0–3, and the other writers only set or clear bit `$8000`, so it is never read. `gfx_inventory.py` counts it as `unused` through a checked `UNREACHABLE` list.
- **Add path: a checklist, not yet a command (see *Room in the ROM*).** A new map sprite needs:
  - a row in the pointer CSV (its ID is the row) and its PNG;
  - a line in `gfx/build/MapMovementSprites/sprites.streams`, with ROM space for the stream. `build.sh` only compresses streams with a `.comp`, so a new stream also needs that loop changed;
  - standing frames, which means raising the counts in `aShortStandingMapSpritePointers`/`aTallStandingMapSpritePointers` (`.for range(63)`/`range(31)`, `engine/map/map_sprites.asm`) and `stand_count` in the tool. `StandingMapSprites1` has room for one more short sprite before `$D76000`. `StandingMapSprites2` has none before the unreferenced `UnusedDA45C0`;
  - a byte in `aShortMapSpriteMovementSounds` or `aTallMapSpriteMovementSounds`; for tall sprites, an `aMapSpriteWalkOffsetPointers` entry; and `aMapSpriteWalkFrameDelays` (`.fill 65, 9`) when a short ID passes 64;
  - a class assignment in `data/class/ClassMapSpriteAssignment.asm`.

  A map battle row needs a new `aBattleMapSpriteData` row (49 bytes: 8 pairs of long pointers and the tall byte), its 8 sprite data streams and graphics (existing ones can be shared), and the class or sprite index that selects it (`rlGetMapBattleClassSprite`).
- **Proved:** `tools/map_sprites.py --self-test` round-trips all 97 sprites against their `.comp` streams and both standing sheets against `fe4.sfc`, and checks the committed PNGs. It also checks that an edit to a short frame's centre cell changes exactly tiles `$22` and `$31`, that a standing edit changes one tile, that a tall edit changes the tile the array draws there, LZ recompression, and refusals. `tools/map_battle_sprites.py --self-test` round-trips all 500 sheets, checks that a centre-cell edit changes that frame's `$22`/`$31` and a tile-row edit the bow block, LZ recompression, refusals, and previews of a short and a tall row. A clean build is byte-identical. With `./build.sh mod`:
  - a Soldier map sprite edit (walking and standing) reached the ROM, and all 97 moved streams still decompressed to their PNGs;
  - a recoloured `Soldier0` map battle frame reached the ROM, and all 500 still matched;
  - new art in a blank map battle frame overflowed `A08000` by 12 bytes, and `stream_layout.py` refused it.

---

### Phase 6 — Full Battle Scene Animations (`231` sheets with a preview, `5` unreachable, `frames_98–9B.asm`, `moves.asm`) — **done (2026-11-27)**
*Hardest / most complex system — best tackled last.*

- **Author-facing objects ([tools/battle_animations.py](../tools/battle_animations.py), `gfx/battle_animation/`):** all `231` reachable battle-scene sprite streams move out of `gfx/build/` into indexed PNGs (`P` mode, colours `0–15`), replacing the old VRAM-order `.4bpp.png` files (65 of which were greyscale):
  - These are still tile sheets, in the order the game uploads them; the frames exist only as sprite arrays over them, and `preview` draws those. Level B, which would make frames the source, is not started.
  - **`sheets/NAME.png` (`84` class sheets):** laid out in frame-row order from the `ANIM_TILE_ROW` slices of every `aBattleAnimationFrameTables` entry that uses the sheet (all 84 reachable sheets partition `[0, len)` with no gaps or overlaps). Each unique slice `(offset, size)` takes `ceil(tiles / 16)` consecutive 16-tile rows (128 pixels wide); trailing slots on a slice's last row must be colour `0` (enforced on pack). `rsBattleAnimationQueueFrameRows` sends each entry to the next VRAM row (`$100` words on), whatever its size. Frames 8 and 10 of the Pegasus Knight and Falcon Knight tables have a 43- or 47-tile slice (`$560` at `$2E00`, `$5E0` at `$3920`) that fills VRAM rows 0–2, then a 2-tile entry that lands on row 1, over tiles 16–17 of the long slice, so those two tiles of the slice never show in that frame. Laying slices out one after another keeps the sheet lossless. The layout is not stored with the PNG: it comes from the slices in `frames_*.asm`, which must cover the sheet from 0 exactly once, and changing them means rearranging the PNG (`build` stops with a message naming the sheet and its frame tables). Decompressed size is checked against the `$6000`-byte spacing between combatant 1's `$7F0000` and combatant 2's `$7F6000` buffers in `rsBattleSceneLoadSheet`.
  - **`extras/NAME.png` (`65` extra tile sheets):** `128×64` (`$1000` bytes) or `128×80` (`$1400` bytes for the four Ballisticians) in 16-tile VRAM rows, coloured with the first user's player palette.
  - **`weapons/NAME.png` (`64` weapon sheets):** `128×16` (`$400` bytes, 32 tiles for VRAM `$40–$5F`), coloured with the first item's weapon palette.
  - **`pieces/NAME.png` (`18` character pieces):** `128×16` (`$400` bytes). `rlBattleSceneLoadCharacterPieces` DMAs `$300` bytes (tiles `0–23`) to VRAM `$60–$77`; the remaining 8 tiles (`$300–$3FF`, bottom-right `64×8`) are zero in all 18 streams and must be colour `0` (enforced on pack).
- **Budget validation & live preview (`validate`, `list`, `preview`):** `tools/battle_animations.py` reads the live sources (`gfx/battle_animation/`, `data/battle_animation/frames_98–9B.asm`, `moves.asm`, `data/palettes/BattleAnimationPalettes.asm`, `engine/battle_scene/animations.asm`, `data.asm`, `rounds.asm`) without requiring a built ROM:
  - `validate` checks all 231 PNGs, the `$6000`-byte class sheet buffer, and per frame the upload queue: `rlBattleSceneQueueUpload` holds 16 entries and `rsBattleAnimationQueueFrameRows` ignores its full flag, so rows past 16 are dropped (an error; over 8 is a warning, since both combatants share the queue). `$0C00` bytes is what `rlBattleSceneRunUploads` sends a VBlank, leaving the rest for the next, so a frame over it is a warning, not an error. Also the 128-sprite OAM limit per record, across all 46 frame/sequence entries and 46 move programs. The original frames queue at most 2 rows and `$800` bytes.
  - `preview OUT_DIR [--class NAME | --record N | --dance] [--item ITEM] [--character NAME] [--enemy] [--facing left|right] [--action NAME|N] [--sequence N] [--frames] [--scale N] [--ids A,B,C,D] [--entry N] [--sheet LABEL]` renders full 4-palette sprites (OAM palettes 0–1 combatant/enemy + 3-colour character overrides, palette 2 weapon, palette 3 character piece colours 1–9 + colour 15 ground shadow), mirroring, movement scripts, and `ANIM_MOVE_JUMP` parabolic arcs into animated GIFs and frame strips with strike/spell/projectile markers (`ANIM_CMD_F1`/`F0`/`EF`), or `--frames` contact sheets. It leaves out spell scripts, hit sparks, afterimage trails, and opponent knockback. `--ids`, `--entry` and `--sheet` show data no record uses (they replace the ROM-reading `tools/battle_animation.py`, now removed). Level B (an OAM packer from assembled frames) is not started.
- **5 unreachable streams:** `g4bppcBattleAnimationSheet50` and `52` (only sheet IDs `$53`/`$55` map to them, and no lookup record or dance selects them), `g4bppcBattleAnimationExtra03` and `04` (no `aBattleAnimationExtraIndices` entry maps to them), and `g4bppcBattleWeapon12` (no `aBattleWeaponGraphicsIndices` entry maps to it). Documented in [animations.asm](../engine/battle_scene/animations.asm) and counted as `unused` in `gfx_inventory.py`.
- **Add path (a checklist, not yet a command; see *Room in the ROM*):**
  - A new class/variant animation needs entries in `aBattleAnimationLookup` and `aBattleAnimationSheetIndices`/`Sheets`, `ExtraIndices`/`Extras`, `FrameIndices`/`FrameTables` (with blocks in `data/battle_animation/frames_*.asm`), `ProgramIndices`/`Programs` (in `moves.asm`), and `PaletteIndices`/`Palettes` (in `BattleAnimationPalettes.asm`), plus `.streams` entries in `gfx/build/E02EBD/E02EBD.streams` (or another region with free space).
  - A new weapon graphic needs an `aBattleWeaponGraphics` entry, an `aBattleWeaponGraphicsIndices` slot (`weapon_id`), its 15-colour palette after `aBattleWeaponPaletteIronSword`, `weapons/NAME.png`, and a `.streams` line.
  - A new character piece needs an `aBattleCharacterPieces` entry, a `aBattleCharacterPieceLookup` list entry, its 9-colour palette after `aBattleCharacterPiecePaletteAzelle`, `pieces/NAME.png`, and a `.streams` line.
- **Proved:** `tools/battle_animations.py --self-test` round-trips all `231` streams byte-identically against their `.4bpp.comp` files, checks all `231` committed PNGs, verifies all 46 frame tables/records and 104 palette entries against `fe4.sfc`, validates all budgets and tests the row checks and the changed-slice error, tests single-tile pixel edits + `gfx.lz` recompression across all four asset kinds, tests negative refusals (non-indexed mode, wrong dimensions, non-zero slice-row or piece padding), and runs `preview` on `Myrmidon`, `Cavalier` (`Alec`, `--enemy`), `FalconKnight`, `Ballistician`, and `--dance`. `./build.sh clean && ./build.sh` is byte-identical, `tools/gfx.py --self-test` (`212` PNGs) and `tools/gfx_inventory.py --self-test` pass, and an edited `gfx/battle_animation/sheets/Myrmidon.png` built with `./build.sh mod` reached the ROM with subsequent streams in `E02EBD` decompressing unchanged. Not tried: an edit that compresses larger in a full region (see Phase 5).

---

### Phase 7 — Battle Effects & Map-Battle Magic (`130` authored, `71` sheets, `6` unreachable) — **done (2026-11-27)**

- **Format resolved:** none of the `acBattleSceneEffectData*` streams is a custom script format — every reachable stream is either a SNES tilemap (`57` battle scene effect tilemaps + `4` `acBattleSceneDecompTilemap*` UI window tilemaps) or a SNES tile sheet. 14 streams had names of the wrong kind and were renamed in review (`tools/name_streams.py`, files moved to their real depth): four 2bpp BG3 sheets labelled 4bpp (`F01360` Bolganone, `F20083` Mjolnir, `F21830` Thoron, `F23B79` Elthunder) are now `g2bppcBattleSceneEffectTiles…`, four 2bpp BG3 sheets labelled as data (`F22E80`, `F16C14`, `F1718D`, `F276E0`) likewise, four 4bpp sprite strips labelled as data (`F62298`, `F622C0`, `F6232E`, `F6239C`) are `g4bppcBattleSceneEffectTiles…`, and two window tile sheets are `g4bppcBattleSceneDecompE03105`/`E03D7F`. `g4bppcMapMagicCutsceneGfx1`/`2` and `g4bppcMapMagicRippleTiles` are reachable from Julius's death cutscene (`rlASMCChapterFinalJuliusDeathCutscene` runs `rlStartMapMagicCutsceneSeq`, which was named `...Unused`).
- **Map-battle magic (`gfx/effects/map_magic/`):**
  - `21` `palettes/NAME.asm` (`256` `bgr555()` colors each, compiled by `tools/battle_effects.py build` to `gfx/build/D50000/acMapBattleMagic*Palette.bin`; `MendStaff` and `RecoverStaff` share `Wind`).
  - `23` `MapMagicNAME.scene.json` manifests (`25` `256×256` assembled PNGs + `*_priority.png` masks, including `ValflameRight` and `MeteorRight`; `12` place `gfx/effects/OutsideTile.4bpp.png`, a blank stand-in, at `$340`, `$36F` or `$37F`: those entries name tiles outside the effect's sheet, whatever VRAM holds there at the time, which the scene does not model and draws blank), packed by `tools/scene_pack.py` against their committed `g4bppcMapBattleMagic*` `.4bpp.comp` seeds (`max_tiles: 128`).
  - `24` `sprites/NAME.4bpp.png`: `19` `g4bppcMapBattleMagic*Sprites` (recolored from `data/palettes/MapBattleMagicPalettes.asm`; `ReturnStaffSprites` stays greyscale because its static palette is all zero), `2` `MapActionEffect1–2` (`aMapActionEffectOAMPalette`), `2` `MapMagicCutscene1–2` (`aMapMagicCutsceneGfxData`), and `1` `MapMagicRipple` (`aMapMagicRipplePalette`).
- **Battle scene effects & decomp windows (`gfx/effects/battle_scene/`):**
  - `47` `tiles/NAME.{4bpp,2bpp}.png` sheets (`31` 4bpp spell/staff/class-change sheets, `8` 2bpp BG3 sheets, `4` 4bpp sprite strips, `4` window sheets), budget-checked on `build`. A sheet a layout uses is colored with the sub-palette its layouts use most, from the traced colors below; the others keep colors from the named color labels (`aBattleSceneHUD*`, `aBattleScene*Colors`).
  - `43` `.scene.json` manifests (`61` `grid` CSV layers: `32×32`, `64×32`, `32×64`, `64×64`, `32×96`, `32×16`, `32×20`, `32×10`) matching `BGxSC` screen layouts (`$3A` → `32×64`, `$39`/`$71` → `64×32`, `$38` `SleepStaff` → `32×64`, `EF7972`/`F46551` → `64×64`) and `scene_pack.py render` previews. `Valflame` and `JuliusEnd` reference existing `g4bppcTitleSceneTilesF019F4`/`F41F38` sheets as `writable: false`. Where a layout names tiles outside its sheets, `gfx/effects/OutsideTile.4bpp.png`/`.2bpp.png` stand in (blank).
  - **Colors, traced from the scripts ([tools/battle_scene_palettes.py](../tools/battle_scene_palettes.py); corrected in review).** A layout's colors are what the first script that loads it (command 1 or 20, or 6) writes: command 14 copies from `aBattleScenePaletteCopyTable`, and command 11 starts palette effects. Palette effect streams (types 0, 1, 2, 12) store colors big-endian (`lda` then `xba`), which is how a `$80 | delay` byte is told apart; the first manifests read them little-endian from byte 1, and read effects that fade in from black at their first, black, frame, so 16 of 61 previews were black. The trace takes a type 0 effect's brightest frame and a scroll's brightest `Count` colors (reversed for type 2), and specs name the source label and byte offset (`stream`, `reverse`, `span_labels` keys in `scene_pack.py`). Copy table sources at odd offsets into a palette label are the game's own (entry 18 reads `aBattleScenePaletteE0215C + $BB`). Now 58 of 61 previews show their effect; the three window layers (`MessageWindow`, `MessageWindowNoPortrait`, `LevelUpBG3`) stay blank: their entries use tiles outside the sheet placement the manifest gives (the message window's tiles go to VRAM `$7E00` by `aBattleSceneCopyToVRAMTable` entry 8, its tilemap to `$69E0`, under a screen layout not traced). `tools/battle_effects.py palettes` rewrites the specs.
- **6 unreachable streams:** `acBattleSceneEffectTilemapEF55C9` (entry 26) and `g4bppcBattleSceneEffectTilesF2487B`, `F25289`, `acBattleSceneEffectTilemapF25C57`, `F25DD4`, `F25F67` (entries 94–98) of `aBattleSceneDecompressToVRAMTable`. Checked in review by decoding all 77 scripts (1,601 commands, one word each: every write of the script offset adds 2): no command 1 or 20 selects them, and nothing else reads that table; none of them is in `aBattleSceneDecompressTable` either. Scripts `$25`, `$42` and `$48` load entries 24 and 25 with command 1; command 20 with 25 would load 26, so 26 looks like an unused alternate of 25. Documented in [script.asm](../engine/battle_scene/script.asm), marked `unused` in `tools/gfx_inventory.py`.
- **Raw addresses replaced (review):** `rlBattleSceneStartScript` reached the scripts through `lda #$8F7D`, and command 14 through `#$AFE5`, with the 22 copy table entries holding their sources as raw bytes; they now use `aBattleSceneEffectOffsetTable`, `aBattleScenePaletteCopyTable` and `.long Label + offset`, so the data can move.
- **Add path (checklist; see *Room in the ROM*):**
  - **Map-battle magic:** add a `palettes/NAME.asm`, `MapMagicNAME.scene.json` + PNG, and `sprites/NAME.4bpp.png`; add `.streams` lines in `gfx/build/D50000/D50000.streams` and entries in `aMapBattleMagicBackgrounds` / `aMapBattleMagicSprites` ([map_battle_magic.asm](../engine/battle/map_battle_magic.asm)) and `aMapMagicEffectStarters`.
  - **Both:** the asset lists in `tools/battle_effects.py` are written by hand, so a new asset also needs a row there; `--self-test` checks them against `aMapBattleMagicBackgrounds`, `aMapBattleMagicSprites`, `aBattleSceneDecompressToVRAMTable` and `aBattleSceneDecompressTable` both ways and fails on a mismatch.
  - **Battle scene effect:** add tiles/layouts in `gfx/effects/battle_scene/`, `.streams` lines in `gfx/build/E02EBD/E02EBD.streams`, entries in `aBattleSceneDecompressToVRAMTable` and a script in `aBattleSceneEffectOffsetTable` ([script.asm](../engine/battle_scene/script.asm)), wired to `aBattleSceneWeaponScripts` ([data.asm](../engine/battle_scene/data.asm)).
- **Proved:** `tools/battle_effects.py --self-test` round-trips all `21` palettes, `24` map-magic sheets, and `47` battle-scene sheets, tests palette, 4bpp and 2bpp edits + `gfx.lz` recompression, previews, validation refusals, and the asset lists against the engine tables (including a dropped row). `tools/battle_scene_palettes.py --self-test` decodes the 77 scripts and traces 164 color writes. `tools/scene_pack.py --self-test` packs all `204` layers (`135` manifests) byte-identically. `./build.sh clean && ./build.sh` is byte-identical; `tools/gfx.py --self-test`, `tools/gfx_inventory.py --self-test`, and `tools/backgrounds.py --self-test` pass (Gemini's run; after the review's changes the clean build and the `scene_pack`, `battle_effects` and `gfx_inventory` self-tests were rerun). End-to-end `./build.sh mod` edits to a map-magic PNG, map-magic palette, and battle-scene effect sheet reached the built ROM cleanly with subsequent streams decompressing unchanged. Inventory after Phase 7: `1,202` authored, `398` sheets, `35` raw (`0` in `battle_effects`), `69` unused.

---

## Not yet assigned to a phase

- **Title, opening and world map scenes (Phase 3 follow-up, `gfx/scenes/title/` and `worldmap/`):** `acTitleScene*` (19), `acTitleScreen*`, `acOpeningSkySceneTilemap*` (3), `acOpeningLogoSubTiles`; world map tileset, tilemap, `acWorldMapBG3Tilemap` and `acWorldMapData` (the highlight and marker-shadow tilemaps were done in Phase 4). The title scenes need their palette setups pinned down; `gcWorldMapTilemap` uses 16×16 metatiles, which the packer does not handle yet. The TitleIntro sheet (Phase 3, `external`) belongs to these scenes.
- **Compressed palettes (`acBattleBannerPalettes`, `acSaveMenuPalettes`, `acWarningScreenPalettes`):** should become `bgr555()` source like `data/palettes/`.
- **Palettes as authored objects.** `data/palettes/*.asm` and `PortraitPalettes.asm` are already editable `bgr555()` text; a swatch preview per file would help, but no compiler is needed.
- **Animated map tiles** (`gfx/map/MapTileAnimations1–2.4bpp.png`): need the frame order and timing from the map tile animation code before a frame-strip format makes sense.
- **Unused data** (`acDataC00000Unused`, `acDataC02786Unused`): inventory only.

---

## Summary Roadmap

Cross-cutting work not tied to one phase: the inventory tool, the `gfx/` layout migration, and an add path plus ROM-space plan for each class (see *Goal and how progress is measured*).

| Phase | Asset Class | Count | Round-Trip Complexity | Existing Foundation |
|---|---|---:|---|---|
| **1** ✓ | Chapter maps, map-battle sprite data (source + build wiring) | 32 map streams, 120 sprite data | Done | [tools/chapter_maps.py](../tools/chapter_maps.py) (CSV), [tools/map_battle_layouts.py](../tools/map_battle_layouts.py) (assembly) |
| **2** ✓ | Portraits | 152 graphics, 248 entries | Done | [tools/portrait_pack.py](../tools/portrait_pack.py) (`80×64` PNG) |
| **3** ✓ | Backgrounds & full-screen scenes | 65 scene layers (45 manifests) | Done | [tools/scene_pack.py](../tools/scene_pack.py) (`gfx/scenes/`) |
| **4** ✓ | UI tilemaps, icons, fonts, target layout & inventory | 53 UI/overlay layers (24 manifests), 111 icons, 3 fonts | Done | [tools/scene_pack.py](../tools/scene_pack.py), [tools/item_icons.py](../tools/item_icons.py), [tools/font_preview.py](../tools/font_preview.py), [tools/gfx_inventory.py](../tools/gfx_inventory.py) |
| **5** ✓ | Map sprites & map-battle animations | 99 map sprites + 500 battle sheets | Done (Level B deferred) | [tools/map_sprites.py](../tools/map_sprites.py), [tools/map_battle_sprites.py](../tools/map_battle_sprites.py) |
| **6** ✓ | Battle scene animations | 231 sheets + frames/moves | Done: sheets + preview (Level B deferred) | [tools/battle_animations.py](../tools/battle_animations.py), `data/battle_animation/` |
| **7** ✓ | Battle effects & map-battle magic | 130 authored + 71 sheets (6 unreachable) | Done | [tools/battle_effects.py](../tools/battle_effects.py), [tools/scene_pack.py](../tools/scene_pack.py), `gfx/effects/` |
