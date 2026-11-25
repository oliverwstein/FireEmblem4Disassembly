# Chapter 22: A map bigger than the screen

A chapter map in *Genealogy of the Holy War* is 64 × 64 tiles of 16 × 16 pixels—1,024 × 1,024 pixels of terrain, castles, roads, and mountain passes—while a single SNES background layer's tilemap is only 32 × 32 tiles of 8 × 8 pixels, or 256 × 256 pixels. Unpacking an entire chapter into 8 × 8 tilemaps in video RAM would consume 32 KB, half of the console's 64 KB VRAM, before a single unit sprite or menu window could be loaded. Instead, the engine keeps only the 32 × 32-tile viewport in VRAM and streams newly exposed rows and columns through a rolling buffer as the camera moves, deriving every terrain rule from the same tile IDs that draw the picture.

This chapter covers how chapter maps are packed and loaded, how the camera and cursor share screen space, how tile streaming updates both the map and the range overlay during VBlank, how animated tiles cycle, and how the minimap renders the whole battlefield on demand.

## How a chapter map is packed and loaded

Every chapter from the Prologue to the Final Chapter has a 25-byte descriptor in `aChapterMapPointers` ([engine/map/chapter_maps.asm](../../engine/map/chapter_maps.asm)). When a chapter opens, the map loader unpacks six components into WRAM and VRAM:

| Component | Destination | Format and size | Purpose |
|---|---|---|---|
| Layout | `aMapData` | 64 × 64 words (compressed) | 16 × 16 tile IDs (`wMapTileIDMask = $03FF`) plus area-restriction bits |
| Metatile table | `$7F/0000` | 1,024 metatiles × 4 words (compressed, 8 KB) | Four 8 × 8 tilemap entries per tile ID |
| Tile graphics | VRAM `$2800` | `$2000` bytes of 4bpp tiles (compressed) | Map terrain tileset |
| Palettes | `aBGPaletteBuffer` (palettes 1–7) | `$E0` bytes (uncompressed) | Seven 16-color map palettes |
| Bounds header | `wMapWidthMode`, scroll limits | 6 words | Width mode (`4` = 64 tiles, `8` = 128 tiles), min/max scroll bounds |
| Terrain table | `aTerrainTileset` | Compressed byte table | Maps each 10-bit tile ID to one of 26 terrain types |

Chapters reuse graphics wherever their geography overlaps. Chapter 2 reuses the Prologue's metatile table, 4bpp tileset, and terrain table with its own layout and palette, and the Final Chapter reuses Chapter 5's tileset and terrain table.

The bounds header stores the map's full pixel width and height rather than raw hardware scroll limits, so the loader subtracts one screen width (`$0100`, 256 pixels) and one screen height (`$00E0`, 224 pixels) to compute the maximum scroll coordinates. For the Prologue (`$0400 × $0200`), the camera pans across `0..$0300` horizontally and `0..$0120` vertically; for Chapters 1 through Final (`$0400 × $0400`), both axes run `0..$0300`.

### Metatiles and terrain from tile IDs

Each entry in `aMapData` is a 16-bit word. Its low 10 bits (`wMapTileIDMask = $03FF`) index both the visual metatile table at `$7F/0000` and the gameplay terrain table `aTerrainTileset`. Its upper six bits (`10..15`) store the chapter's area-restriction ID ([Chapter 9](09-moving-a-unit.md)).

Each metatile occupies 8 bytes (four 16-bit SNES tilemap words) in `$7F/0000`, stored in column-major order so a builder can step through either a row or a column by adding a fixed offset:

```
  Metatile at $7F/0000 + (tile_id * 8)          16×16 Map Tile on Screen
  +--------+--------+--------+--------+         +-----------+-----------+
  | +0: TL | +2: BL | +4: TR | +6: BR |  --->   |  TL (8×8) |  TR (8×8) |
  +--------+--------+--------+--------+         +-----------+-----------+
     Each word masked with $DFFF                |  BL (8×8) |  BR (8×8) |
     (clears bit 13 priority bit)               +-----------+-----------+
```

Masking each entry with `$DFFF` clears bit 13 (the SNES background priority bit), ensuring map terrain always renders behind high-priority sprites and menu windows.

Because terrain is derived directly from the tile ID, map changes—such as a raised bridge, a destroyed village, or an opened castle gate—need only overwrite words in `aMapData`. That single write updates both the rendered picture and the gameplay rules for those squares. Movement costs and avoid bonuses live in two CSV-backed tables: [data/terrain/MovementCost.csv](../../data/terrain/MovementCost.csv) (cost per movement type across all 26 terrain types, with `$80` marking impassable tiles) and [data/terrain/TerrainAvoid.csv](../../data/terrain/TerrainAvoid.csv) (ground and flying avoid bonuses, ranging from `-40` on peaks and cliffs to `+40` in thickets).

## Camera, cursor margins, and coordinates

The camera (`wMapScrollXPixels`, `wMapScrollYPixels`) tracks the map pixel at the top-left corner of the screen, while the cursor (`wCursorXOffset`, `wCursorYOffset`) is stored in map pixels as well. Converting between map space and screen space is a single subtraction (`cursor - camera`), and converting a pixel coordinate to a 16 × 16 map tile is a 4-bit right shift (`>> 4`).

Rather than centering the camera on the cursor on every D-pad press, the camera controller defines a central comfort box 48 pixels inside the screen edges (`X $30..$C7`, `Y $28..$A7`). As long as the cursor stays inside that box, the background stays still; only when the cursor steps past a margin does the camera scroll to follow it.

```
  0                    $30                 $C7         $FF
0 +---------------------+-------------------+-----------+
  |                     |                   |           |
$28                     +-------------------+           |
  |                     |  Free cursor box  |           |
  |                     |   (no scrolling)  |           |
$A7                     +-------------------+           |
  |                                                     |
$DF +---------------------------------------------------+
```

```rust
fn check_cursor_in_margins() -> bool { // rlCheckPointInScreenMargins
    let screen_x = wCursorXOffset - wMapScrollXPixels;
    let screen_y = wCursorYOffset - wMapScrollYPixels;
    // Returns true (carry clear) if inside X $30..$C7 and Y $28..$A7;
    // crossing any edge triggers a camera scroll step in that direction.
    (0x0030..0x00C8).contains(&screen_x) && (0x0028..0x00A8).contains(&screen_y)
}
```

Each scroll step advances the camera by `wMapScrollSpeed` pixels according to the joypad-style directional bitmask in `wMapScrollDirectionIdentifier` (`$0100` right, `$0200` left, `$0400` down, `$0800` up, and sums for diagonals). Event cutscenes drive the same steppers through a script compiler (`rlCreateMapScrollScriptFromCoordinates`), which translates start and target tile coordinates into a sequence of directional scroll commands in `$7E/DD88` and executes them at `wEventMapScrollSpeed`.

To index a tile `(x, y)` inside `aMapData`, the coordinate helper checks `wMapWidthMode`: mode `4` shifts `y` by 7 (`* 128` bytes, or 64 words per row), while mode `8` shifts `y` by 8 (`* 256` bytes, or 128 words per row).

## Tile streaming and the VMAIN row/column trick

The SNES BG1 tilemap at VRAM `$5000` is a 32 × 32 grid of 8 × 8 entries (2,048 bytes). Because SNES background scroll registers wrap modulo 256 pixels on both axes, the 32 × 32 tilemap behaves as a toroidal ring buffer sliding across the 64 × 64-tile chapter map:

```
  64×64 map in WRAM (aMapData)           32×32 tilemap in VRAM ($5000)
  +---------------------------+          +--------------------+
  |                           |          | wraps X mod 32     |
  |    +-------------+        |   DMA    | wraps Y mod 32     |
  |    |   Visible   | [col]--+--------->| |                | |
  |    |   viewport  |        |  VMAIN   | +----------------+ |
  |    +------+------+        |  $80/$81 | | new row        | |
  |         [row]-------------+--------->| +----------------+ |
  +---------------------------+          +--------------------+
```

Whenever a scroll step crosses an 8-pixel boundary, the streamer builds only the newly exposed 8-pixel strip into a 64-byte WRAM staging buffer (`$05DC` for a row, `$059C` for a column) and sets its upload flag. If a unit is currently picked up (`wUnitSelectedFlag != 0`), it builds the matching 64-byte strip for the BG3 movement-range overlay (`aMovementMap`) into `$06DC` or `$069C` at the same time.

```rust
fn build_map_row(map_index: usize, half_y: usize, row_buf: &mut [u16; 32]) { // rsBuildMapRowTiles
    // half_y (wR2) is 0 for the top half of a 16x16 metatile, 2 for the bottom half
    for x in 0..16 {
        let tile_id = aMapData[map_index + x] & wMapTileIDMask;
        let meta = tile_id * 4;                                           // 4 words per metatile at $7F/0000
        row_buf[x * 2]     = METATILES[meta + (half_y / 2)] & 0xDFFF;     // top/bottom-left 8x8
        row_buf[x * 2 + 1] = METATILES[meta + (half_y / 2) + 2] & 0xDFFF; // top/bottom-right 8x8
    } // wraps around the 32-word ring buffer via wMapTileBufferWrapped
}
```

When the camera begins on an odd 8-pixel boundary—halfway across a 16 × 16 metatile—dedicated `HalfOffset` builders (`rsBuildMapRowTilesHalfOffset`, `rsBuildMapColumnTilesHalfOffset`) split the edge metatiles cleanly so the seam never tears.

During VBlank, the tilemap uploader flushes any flagged row or column buffer using the SNES VRAM address increment register (`VMAIN`, `$2115`), turning a single 64-byte DMA into either a horizontal or vertical strip:

```rust
fn upload_map_row_and_column() { // rlUploadMapRowAndColumn
    if wMapRowUploadFlag != 0 {
        wMapRowUploadFlag = 0;
        // VMAIN = $80: increment VRAM word address by +1 (horizontal row)
        dma_to_vram(0x5000 + wMapRowUploadVRAMOffset, 0x05DC, 0x40, VMAIN_INC_1);
        if wUnitSelectedFlag != 0 {
            dma_to_vram(0x5800 + wMapRowUploadVRAMOffset, 0x06DC, 0x40, VMAIN_INC_1);
        }
    }
    if wMapColumnUploadFlag != 0 {
        wMapColumnUploadFlag = 0;
        // VMAIN = $81: increment VRAM word address by +32 (vertical column)
        dma_to_vram(0x5000 + wMapColumnUploadVRAMOffset, 0x059C, 0x40, VMAIN_INC_32);
        if wUnitSelectedFlag != 0 {
            dma_to_vram(0x5800 + wMapColumnUploadVRAMOffset, 0x069C, 0x40, VMAIN_INC_32);
        }
    }
}
```

When an event alters tiles across the entire screen—such as seizing a castle or triggering a bridge change—a full-screen rebuild (`rlRedrawVisibleMapTilemap`) reconstructs all 32 rows into `aBG2TilemapBuffer` (`$7E/7388`) and DMAs the full `$0800` bytes to VRAM `$5000`, while its companion (`rlRedrawRangeOverlayTilemap`) refreshes BG3. During certain scripted cutscenes, a mid-frame IRQ (`aMapRowUploadIRQ`) waits for HBlank partway down the screen, briefly forces blank on `$2100`, and invokes the row/column uploader directly.

### Animated map tiles

Water ripples, torch flames, and castle banners animate without touching any tilemap entries. On steps 0 and 1 of the 16-step `wMapSpriteFrameCounter` cycle, `rlUploadMapAnimations` ([engine/map/map_sprites.asm](../../engine/map/map_sprites.asm)) DMAs the next tile sheet frame for `g4bppMapTileAnimations1` (`$0800` bytes, 16 frames → VRAM `$0C00`) and `g4bppMapTileAnimations2` (`$0400` bytes, 32 frames → VRAM `$0A00`). Bit 0 of `wMapSpriteAnimationPauseFlags` freezes tile animation during menus or battles without disturbing map sprites.

## The minimap

Pressing Start opens `procMinimap` ([engine/map/minimap.asm](../../engine/map/minimap.asm)), which shrinks the entire 64 × 64 battlefield into a 128 × 128-pixel overview at 2 × 2 pixels per tile. Rather than stalling the frame to render all 4,096 tiles at once, the proc slices the work across eight frames at `$200` (512) tiles per frame. Each tile looks up a palette index in `aMinimapTerrainColors` (with closed villages forced to color `9`), overlays unit dots colored by allegiance, and frames the active camera region with a flashing rectangle. While open, the D-pad scrolls the map underneath, holding R, X, A, or Y toggles translucency, and B or Start closes the overlay.

The Warp staff hijacks the same proc by setting bit 11 of `wChapterFlags`. In that mode, `rsMinimapShowWarpCastle` repurposes the D-pad to step through the player's empty castles and home castle, printing each castle's name until the player confirms a destination with A or cancels with B.

## Trade-offs and hard limits

Streaming a single 8-pixel strip per frame keeps VBlank DMA overhead to 128 bytes (256 bytes with the range overlay active), leaving ample bandwidth for unit sprites, dialogue boxes, and palette fades. That design imposes four hard limits:

- **Maximum scroll speed:** Because `rlUploadMapRowAndColumn` uploads at most one row and one column per VBlank, scrolling faster than 8 pixels per frame on an axis would skip a strip and leave stale tiles on screen.
- **10-bit metatile space:** `wMapTileIDMask` (`$03FF`) caps each chapter tileset at 1,024 distinct 16 × 16 metatiles so the upper six bits of every `aMapData` word remain free for area-restriction IDs.
- **64 × 64 (or 128-wide) grid:** `rlGetMapDataIndex` supports only `wMapWidthMode` values `4` (64 tiles wide) and `8` (128 tiles wide). Every shipped chapter map—as well as the world map in [Chapter 19](19-between-chapters.md)—uses mode `4`.
- **Unused second map layer:** `rsBuildMapRowTiles` and `rsBuildMapColumnTiles` still test bit 1 of `wUnknown00075A` to build a second priority-tagged tile layer from `$7F/6400` into `$065C`/`$061C`, though nothing in the game enables that bit or uploads those buffers.

## Where it lives in the source

- [engine/map/chapter_maps.asm](../../engine/map/chapter_maps.asm): `aChapterMapPointers`, `rlLoadChapterMapLayout`, and `rlLoadChapterMapGraphics`.
- [engine/map/map_tilemap.asm](../../engine/map/map_tilemap.asm): `rlUploadMapRowAndColumn`, `rsBuildMapRowTiles`, `rlRedrawVisibleMapTilemap`, `rlRedrawRangeOverlayTilemap`, and `aMapRowUploadIRQ`.
- [engine/map/camera.asm](../../engine/map/camera.asm) and [engine/map/scroll.asm](../../engine/map/scroll.asm): `rlGetMapDataIndex`, `rlCheckPointInScreenMargins`, `rlMapScrollStep*`, and `rlCreateMapScrollScriptFromCoordinates`.
- [engine/map/map_display.asm](../../engine/map/map_display.asm): `rlSetUpChapterMapDisplay` and map display restoration.
- [engine/map/map_sprites.asm](../../engine/map/map_sprites.asm): `rlUploadMapAnimations` (`g4bppMapTileAnimations1`/`2`).
- [engine/map/minimap.asm](../../engine/map/minimap.asm): `procMinimap`, `aMinimapTerrainColors`, and `rsMinimapShowWarpCastle`.
- [data/terrain/MovementCost.csv](../../data/terrain/MovementCost.csv) and [data/terrain/TerrainAvoid.csv](../../data/terrain/TerrainAvoid.csv): terrain movement and avoid tables.
- [docs/reference/map.md](../reference/map.md): full reference for the chapter map system.
