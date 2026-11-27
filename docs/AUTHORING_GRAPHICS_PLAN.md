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

### Target layout of `gfx/`

Authored sources live in one folder per game system. The ROM-address folders hold only build plumbing.

```
gfx/
  portraits/          NAME.png (80x64)
  scenes/             dialogue/ battle/ screens/ title/ worldmap/   NAME.png + NAME.scene.json
  maps/               chapter map CSVs (Layout, TileEntries, Terrain)
  ui/                 shared sheets + layout manifests (Phase 4)
  fonts/  icons/      (Phase 4)
  map_sprites/        frame-grid PNGs (Phase 5)
  map_battle/         sprite data .asm, sheets (Phase 5)
  effects/            battle scene effects, map-battle magic (Phase 7)
  battle_animation/   (Phase 6)
  build/              one folder per ROM region: REGION.streams, the committed NAME.comp
                      originals, and the generated .4bpp/.2bpp/.bin/.lz files
```

- An authored file names where its output goes (a manifest field, or a fixed rule in its tool), as `.scene.json` tilemap paths do. No author has to open `gfx/build/` for an authored asset.
- `gfx/build/` holds, per ROM region, `REGION.streams`, the committed `NAME.comp` originals and the generated files; `gfx/build/portraits/` and `gfx/build/MapMovementSprites/` hold those two classes' streams; `gfx/build/ui/tilemaps/` holds the uncompressed UI tilemaps (the committed originals as `NAME.bin.seed`, the generated `NAME.bin`, and the raw tilemaps not yet converted).
- Nothing in `gfx/build/` is edited by hand except `.streams` order, which decides placement, and the tile sheets still in VRAM order (`sheet` in the inventory): about 1,000 `.4bpp.png`/`.2bpp.png` files stay beside their streams until their phase gives them an authored form.
- `build.sh` writes `NAME.4bpp`/`NAME.2bpp` beside every `NAME.4bpp.png`/`NAME.2bpp.png` (gitignored), including the shared UI sheets in `gfx/ui/`.

The migration of Phases 1–3 was done with Phase 4 (2026-11-27): the chapter map CSVs are in `gfx/maps/`, the map-battle sprite data in `gfx/map_battle/`, the portrait streams in `gfx/build/portraits/`; the 48 Phase 3 seed sheets were dropped (manifests name them as `"comp"` and `scene_pack.py` reads the `.comp` directly); the map movement sprites and the uncompressed UI tilemaps moved into `gfx/build/`.

### Adding assets and ROM space

Every phase so far edits assets in place. Adding one (a portrait, a background, a chapter map, a scene) still means editing pointer tables, a `.streams` list and a manifest by hand, and nothing documents the steps. Each class needs:

- **A declared add path.** Name the table the code indexes (`PortraitGraphicPointers.csv` and `PortraitPalettePointers.csv`, `aDialogueBackgroundPointers`, `aBattleBackgrounds`, the chapter map tables), the ID constants, and the limits on the count (an ID width, a table the code bounds-checks, a fixed array). Then a tool command, or failing that a documented checklist, that adds the entry, the source file and the `.streams` line together. Backlog: Phases 1–3 have no add path yet.
- **Room in the ROM.** Every graphics region is packed with no slack: each `.streams` region ends exactly where its last original stream ends, so an edit that compresses larger than the original fails (so far our compressor has usually beaten the game's). The ROM is already 4 MB, the largest standard HiROM size. The whole ROM is built from source, and the original has only about 99 KB in runs of 1 KB or more of `$00` or `$FF`, some of which may be data. Options, to decide before the first add path ships:
  1. move streams between regions, and reclaim padding that is shown to be unused (each run needs a reader check first);
  2. expand to ExHiROM (up to 8 MB). This means a header and mapping change, and new regions in the added banks for new and grown streams. It would leave every original region byte-identical on an unmodified build.
- **Budgets per asset as well as per region:** VRAM tile budgets (as in Phase 3), palette slots, and any fixed decompression buffer the loader uses.

## Phased Rollout Plan (Ordered by Cost and Readiness)

### Phase 1 — Wire the map decoders into the build (`12` chapter maps, `120` map-battle sprite data streams) — **done (2026-11-26)**

- **Chapter maps:** each of the 32 streams in [gfx/build/C70C80/](../gfx/build/C70C80/) has one CSV source in [gfx/maps/](../gfx/maps/), and `tools/chapter_maps.py build` (run by build.sh) writes the `.bin` that `gfx.py lz` compresses. `acChapterMap*Layout.csv` is the 64×64 grid of map words in hex (bits 0–9 tile ID, bits 10–15 the area a chapter can close). `*TileEntries.csv` is one row per tile ID 0–255, with four entries written `TILE:PALETTE` plus `p`/`h`/`v`; IDs 256–1023 are `aBaseMapTileEntries`. `*Terrain.csv` is one row per tile ID, named from `include/Terrain.h`. Values `$1A`–`$35` have no name and stay hex (open question in [map.md](reference/map.md)).
- **Map-battle sprite data:** the earlier JSON format guessed structure from byte ranges and could not change size. It was replaced by assembly source (`gfx/map_battle/aMapBattle*Layout*.asm`) in the style of `aGiveGoldCoinSpriteData`, decoded along what the code reads. That means five block offsets by weapon type; blocks of a frame table, two unread words and (main, aux) script pairs; frames as `.structSpriteEntry` arrays; scripts as `ACTIVE_SPRITE_*` commands; and every offset a label difference. `tools/map_battle_layouts.py build` assembles each with 64tass. `MAP_BATTLE_SPRITE_DATA_END` pads to the original size and fails past `$880` bytes, the distance between the two sides' buffers. The format is in the tool's docstring and [map_battle.md](reference/map_battle.md).
- **Proved:** both self-tests round-trip every stream from its `.comp` and check the committed sources. The sprite data test adds a sprite to a frame and checks that the rest moves while every frame and script parses the same. A clean build is byte-identical. An edited sprite frame and terrain entry built with `./build.sh mod` reached the ROM, and the following streams moved and still decompress correctly. The generated `.bin` files are gitignored and removed by `./build.sh clean`.
- **Left for later:** the Tiled export (Step 2 below) and a sprite data preview (Phase 5).
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
- **Inventory:** [docs/reference/gfx_inventory.md](reference/gfx_inventory.md) from `tools/gfx_inventory.py --write` (rules in its docstring; `unused` means no reader in the sources, checked, not taken from the label). Counts are in *Inventory* above. One label named `Unused` has a reader: `g4bppcMapBattleCritUnused4` (Phase 5 should check it).
- **Left as-is in `gfx/build/ui/tilemaps/`:** `6` `Unused*.bin`, `WorldMapDataD97940.bin`, `WorldMapTilemap.bin` (metatiles), `FirstGenerationEndingBG2Tilemap.bin`.
- **Proved:** `tools/scene_pack.py --self-test` (all layers byte-identical; grid edits on an uncompressed and a compressed tilemap change only the edited entries, with LZ round-trip; an edit to `WindowFrames` leaves `UnitWindowList`'s tilemap unchanged and changes its preview; grid layers refuse `append_sheet` and out-of-range tiles), `tools/item_icons.py --self-test`, `tools/font_preview.py --self-test`, `tools/gfx_inventory.py --self-test` (which also fails when the inventory page is out of date), the Phase 1–3 self-tests from their new locations, `tools/backgrounds.py --self-test`, a clean build, and a build of only the files a commit contains (byte-identical).

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

### Phase 7 — Battle Effects & Map-Battle Magic (`69` battle scene effect streams, `~47` map-battle magic tilemaps and palettes, `6` decompression tilemaps)

- **Current state:** raw `.bin` with no source: `acBattleSceneEffect*` data and tilemaps, `acBattleSceneDecomp*` tilemaps, and per-spell `acMapBattleMagic*Tilemap`/`*Palette` pairs. `tools/backgrounds.py` already renders the map-battle magic layers from the ROM (tiles from tile 896).
- **Needs first:** how the effect data streams are read (a format, as Phase 1 did for sprite data). Then the map-battle magic layers can become scene manifests with their own palettes, and the effect data becomes assembly source.
- **Unused:** `acMapBattleMagicPaletteUnused*` (24), `acMapBattleMagicTilemapUnused`, `acBattleSceneUnused*` (3): listed in the inventory as `unused`, not converted.

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
| **5** | Map sprites & map-battle animations | 99 sheets + 557 battle sheets | **Medium–Hard** (OAM packing, Level B only) | Phase 1 layouts |
| **6** | Battle scene animations | 337 sheets + scripts | **Hard** (multi-piece OAM + DMA budgets) | `data/battle_animation/` |
| **7** | Battle effects & map-battle magic | ~120 streams | **Medium** (effect data format unknown) | `tools/backgrounds.py` magic renderer |
