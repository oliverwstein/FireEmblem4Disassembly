# Chapter 22: A Map Bigger than the Screen

A chapter map is a grid of 64 × 64 tiles, each 16 × 16 pixels, so 1,024 pixels on a side. The screen shows 256 × 224 pixels of it, 16 tiles across and 14 down. The SNES draws a background layer from a **tilemap** in video RAM: a grid of 8 × 8-pixel cells, each a two-byte entry naming a tile graphic, a palette, a priority bit, and two flip bits. The map's layer uses a tilemap of 32 × 32 cells, 256 pixels square, and the layer's scroll registers wrap around it in both directions. Written out as 8 × 8 cells, a whole chapter would be 128 × 128 entries, 32 KB, half of video RAM.

The engine keeps one 32 × 32 tilemap and rewrites its edges as the camera moves. Every step of the camera builds the row or column of cells about to come into view from the map data in work RAM, and the next vertical blank (VBlank) copies it into the tilemap. The same map data supplies the terrain: one tile ID per map tile picks both the four cells that draw it and the terrain the rules read.

This chapter covers the map data and how a chapter loads it, the camera and the cursor, streaming rows and columns, the animated tiles, and the minimap.

## The map data

### Tile IDs

`aMapData` holds one word per map tile, row by row. The low 10 bits are the **tile ID**, kept by the mask `wMapTileIDMask` (`$03FF`). The top 6 bits are the area tags that close parts of the map to the player ([Chapter 9](09-moving-a-unit.md)).

A tile ID is an index into two tables the chapter loads:

- **The metatile table** at `$7F/0000`: four tilemap entries per ID, 8 bytes each, 1,024 IDs, 8 KB in all. The four entries are the tile's 8 × 8 quarters, stored by column:

```
  $7F/0000 + id × 8                    on screen
  +------+------+------+------+        +------+------+
  |  TL  |  BL  |  TR  |  BR  |        |  TL  |  TR  |
  +------+------+------+------+        +------+------+
   +0     +2     +4     +6             |  BL  |  BR  |
                                       +------+------+
```

- **The terrain table** `aTerrainTileset`: one byte per ID, naming one of 26 terrains (plains, forest, castle, river, and so on, listed in [include/Terrain.h](../../include/Terrain.h)). Movement costs by terrain are in [data/terrain/MovementCost.csv](../../data/terrain/MovementCost.csv) ([Chapter 9](09-moving-a-unit.md)), and avoid bonuses in [data/terrain/TerrainAvoid.csv](../../data/terrain/TerrainAvoid.csv) ([Chapter 6](06-resolving-a-battle.md)): ground units get +40 in thickets, +30 on mountains, castles, and forts, +20 in forests, villages, and shrines, and −40 on peaks and cliffs. Fliers get nothing except +20 on a shrine.

Since both tables are keyed by the same ID, writing a new ID into `aMapData` changes both the picture and the rules on that square. That is how the chapters' map changes work: a table in the chapter data pairs an event flag with a position and a block of replacement IDs, and the event engine writes them in once the flag is set ([Chapter 11](11-the-game-is-watching.md)). A battle scene or the castle screen can overwrite `aMapData`, and the way back decompresses the layout from ROM again, so the engine marks each applied change (`aChapterActiveMapChanges`) and writes it in again after a reload (`rlApplyAllActiveMapChanges`).

### A chapter's descriptor

`aChapterMapPointers` ([engine/map/chapter_maps.asm](../../engine/map/chapter_maps.asm)) has one long pointer per chapter, prologue to final. Each points to a 27-byte descriptor:

| Field | Destination | Notes |
|---|---|---|
| Layout | `aMapData` | Compressed, 64 × 64 words |
| Metatile table | `$7F/0000` | Compressed, 8 KB |
| Tile graphics | Video RAM `$2800` | Compressed 4bpp tiles |
| Palette | Background palettes 1–7 | Uncompressed |
| Width mode, a second width word, minimum X and Y scroll | `wMapWidthMode`, `$075E`, `wMapMinXScroll`, `wMapMinYScroll` | 4, 4, 0, 0 in every chapter. Nothing reads `$075E`. |
| Map width and height in pixels | `wMapMaxXScroll`, `wMapMaxYScroll` | The loader subtracts one screen, `$0100` and `$00E0` |
| Terrain table | `aTerrainTileset` | Compressed |

Chapters 1 through Final are `$0400` pixels square, so the camera's top-left corner runs from 0 to `$0300` on both axes. The prologue is `$0400` wide and `$0200` tall (64 × 32 tiles), so its vertical range is 0 to `$0120`.

Two chapters borrow another's tiles. Chapter 2 has its own layout and palette but the prologue's metatiles, graphics, and terrain table; the final chapter does the same with Chapter 5's. A borrowed tile set brings its terrain table along, so the same tile ID means the same terrain in both chapters.

`rlGetMapDataIndex` turns a tile position into an offset in `aMapData`. Width mode 4 is a 64-tile row and mode 8 a 128-tile row. Every chapter uses mode 4, and so does the world map, which sets the word itself ([Chapter 19](19-between-chapters.md)).

## The camera and the cursor

The **camera** (`wMapScrollXPixels`, `wMapScrollYPixels`) is the map pixel at the screen's top-left corner, kept between the descriptor's limits. The **cursor** (`wCursorXOffset`, `wCursorYOffset`) is a position on the screen, so the tile under it is `(camera + cursor) / 16` on each axis.

The D-pad moves the cursor one tile per press, 4 pixels a frame (8 with Y held), so a tile takes four frames, or two. The cursor moves freely while it stays at least 48 pixels from every edge of the screen: X from `$30` to `$C0`, Y from `$30` to `$A0`, measured at the cursor tile's top-left corner. A press that would carry it past that margin moves the camera instead, at the same speed, and the cursor stays put on the screen. When the camera is already against the edge of the map, the cursor may go to within 16 pixels of the screen's edge (`rsMoveMapCursorLeft` and its three neighbors in [engine/map/map_cursor.asm](../../engine/map/map_cursor.asm)).

A **scroll step** moves the camera `wMapScrollSpeed` pixels in a direction given as joypad bits in `wMapScrollDirectionIdentifier`: `$0100` right, `$0200` left, `$0400` down, `$0800` up, and their sums for diagonals. `rlContinueMapScroll` runs one step per frame while `wMapScrollingFlag` is set. Each step sets the background scroll registers and builds the strip of cells entering the screen on that side:

```rust
fn map_scroll_step_left() {                  // rlMapScrollStepLeft
    camera_x -= wMapScrollSpeed;             // rsMapScrollLeftSetBGOFS
    build_left_column();                     // rsBuildMapLeftColumn
    wMapColumnUploadVRAMOffset = (camera_x & 0xF8) >> 3;   // tilemap column
    wMapColumnUploadFlag = 1;                // copy it in the next VBlank
}
```

The diagonal steps do both a column and a row. Events move the camera through the same steps: `rlCreateMapScrollScriptFromCoordinates` turns a start and an end tile into a list of directional steps at `$7E/DD88`, which the event's scroll runs at `wEventMapScrollSpeed`.

## Streaming rows and columns

### The tilemap as a ring

The map layer's tilemap is at video RAM `$5000`. Because the scroll registers wrap at 256 pixels, map pixel `(x, y)` always lands in tilemap cell `((x / 8) mod 32, (y / 8) mod 32)`, wherever the camera is. A cell that scrolls off one side is the cell that will be needed next on the opposite side, so the engine never moves anything already in the tilemap. It only overwrites the cells for the strip entering the screen:

```
  aMapData (64 × 64 tiles, work RAM)        tilemap at $5000 (32 × 32 cells)
  +-------------------------------+         +------------------------+
  |      camera                   |         |   row = (y/8) mod 32   |
  |      +-------------+          |         |  +------------------+  |
  |      |   screen    |<- new    |  VBlank |  |                  |  |
  |      | 16 × 14     |  column  | ------> |  |  same cells, in  |  |
  |      +-------------+          |         |  |  wrapped order   |  |
  |            ^ new row          |         |  +------------------+  |
  +-------------------------------+         +------------------------+
```

Vertically, the screen's 224 lines leave 32 lines of the tilemap off screen, room for the next row. Horizontally, the screen is the tilemap's full 256 pixels, so when the camera sits between two 8-pixel columns, the column leaving on the left and the column entering on the right are the same tilemap column. The map's display setup hides it: it sets window 1 to pixels 8 through 247 and masks the map layer and the sprites outside it, leaving an 8-pixel black band at each side of the screen (`rlSetUpChapterMapDisplay` in [engine/map/map_display.asm](../../engine/map/map_display.asm)).

### Building a strip

A row of the tilemap is 32 cells, the width of 16 map tiles. The row builders read 16 entries of `aMapData`, look up each tile ID's four cells, and take the top two or the bottom two, depending on which half of the map tile this row of cells crosses (bit 3 of the row's Y). They write into a 64-byte buffer laid out like the tilemap row, starting at the cell where the leftmost tile lands and wrapping at the end (`wMapTileBufferWrapped`):

```rust
fn build_map_row(map_index: usize, half: usize, start_cell: usize) { // rsBuildMapRowTiles
    // half: 0 for the tiles' top quarters, 1 for their bottom quarters
    let mut cell = start_cell;                          // (camera_x / 8) % 32
    for i in 0..16 {
        let id = aMapData[map_index + i] & wMapTileIDMask;
        let quarters = &METATILES[id];                  // TL, BL, TR, BR at $7F/0000
        row_buffer[cell]     = quarters[half]     & !0x2000; // left quarter
        row_buffer[cell + 1] = quarters[half + 2] & !0x2000; // right quarter
        cell = (cell + 2) % 32;
    }
}
```

Each entry has its priority bit (bit 13) cleared on the way, whatever the metatile table holds, so map terrain always draws at the layer's low priority.

When the camera's X is not a multiple of 16, the screen starts halfway across a map tile. `rsBuildMapRowTilesHalfOffset` handles that case: it begins with the right quarter of the first tile and ends with the left quarter of the seventeenth. Columns work the same way, with `rsBuildMapColumnTiles` and `rsBuildMapColumnTilesHalfOffset` choosing left or right quarters by bit 3 of the camera's X.

The buffers are `$05DC` for a row and `$059C` for a column. While a unit is picked up (`wUnitSelectedFlag`), the same step builds the matching strip of the range overlay from `aMovementMap` into `$06DC` or `$069C` ([Chapter 9](09-moving-a-unit.md)). The overlay is a second background layer, BG3, scrolled with the map.

### Uploading in VBlank

`rlUploadMapRowAndColumn` copies the flagged strips to video RAM during VBlank. One register makes the same 64-byte copy write a row or a column. The video port's address-increment setting (`VMAIN`, `$2115`) says how far the write address moves after each two-byte entry: one word, for the next cell in the row, or 32 words, for the cell below:

```rust
fn upload_map_row_and_column() {                         // rlUploadMapRowAndColumn
    if wMapRowUploadFlag != 0 {
        wMapRowUploadFlag = 0;
        VMAIN = 0x80;                                     // +1 word per entry: a row
        dma_to_vram(0x5000 + wMapRowUploadVRAMOffset, 0x05DC, 64);
        if wUnitSelectedFlag != 0 {
            dma_to_vram(0x5800 + wMapRowUploadVRAMOffset, 0x06DC, 64);
        }
    }
    if wMapColumnUploadFlag != 0 {
        wMapColumnUploadFlag = 0;
        VMAIN = 0x81;                                     // +32 words per entry: a column
        dma_to_vram(0x5000 + wMapColumnUploadVRAMOffset, 0x059C, 64);
        if wUnitSelectedFlag != 0 {
            dma_to_vram(0x5800 + wMapColumnUploadVRAMOffset, 0x069C, 64);
        }
    }
}
```

A scroll step costs at most 128 bytes of VBlank time, or 256 with the overlay showing.

### Redrawing the whole screen

When many tiles change at once (a castle taken, a map change, the return from a full-screen window), `rlRedrawVisibleMapTilemap` rebuilds the screen. It saves the camera, moves it a screen's height down, sets the scroll speed to 8, and steps it back up one row at a time, building each row in turn into `aBG2TilemapBuffer` at `$7E/7388`. The finished `$0800`-byte tilemap is then copied to `$5000` in one piece, and the camera restored. `rlRedrawRangeOverlayTilemap` does the same for the overlay.

During some events the strips are uploaded mid-frame instead: `aMapRowUploadIRQ` asks for an interrupt at scanline `$D7`, near the bottom of the screen, whose handler waits for the horizontal blank, turns the display off, runs the uploader, and turns it back on.

## Animated tiles

Water and other animated terrain change without any tilemap writes. Two sheets of tile graphics, `g4bppMapTileAnimations1` and `g4bppMapTileAnimations2`, hold successive frames of a block of tiles. Every eight frames, `rlUploadMapAnimations` ([engine/map/map_sprites.asm](../../engine/map/map_sprites.asm)) copies the next frame of the first sheet (`$0800` bytes) to video RAM `$0C00`, and on the following frame the next frame of the second (`$0400` bytes) to `$0A00`. Every tilemap cell that names those tiles changes picture at once. The other six frames of each eight upload the standing units' sprite frames ([Chapter 5](05-who-stands-where.md)), so the tile animations and the map sprites take turns with the VBlank time.

Bit 0 of `wMapSpriteAnimationPauseFlags` stops the tile animations (`rlPauseMapTileAnimation`), and bit 15 stops the sprites. Map battles, map action animations, cutscenes, the dialogue box, the castle screen, and the credits pause the tiles.

## The minimap

Start opens the minimap (`procMinimap` in [engine/map/minimap.asm](../../engine/map/minimap.asm)). It draws the whole map with each tile as a 2 × 2-pixel dot, a 128 × 128-pixel picture for a 64 × 64 map. There's no hardware mode for drawing single pixels, so the engine treats a block of 256 tile graphics as a bitmap. It sets bits directly in a copy of those graphics in work RAM (`$7E/8B88`), then copies them to video RAM and writes a 16 × 16-cell tilemap (16 × 8 for the prologue) that places each of those tiles once.

The proc spreads the work over several frames:

1. Clear the pixel buffer.
2. Draw terrain, `$200` tiles a frame, eight frames for a full map. Each tile's terrain picks a color from `aMinimapTerrainColors`, and closed villages are drawn in color 9.
3. Draw a dot for each unit, colored by army.
4. Copy the pixels to video RAM, `$0800` bytes a frame for four frames.
5. Write the tilemap.

The minimap is on BG2, a layer the map otherwise leaves off. Color math dims the map layers under it. A box of sprites shows the part of the map currently on screen, cycling through four colors. While the minimap is open (bit 5 of `wMapSystemFlags`), the D-pad scrolls the map under it, holding R, X, A, or Y makes it see-through, and B or Start closes it.

The Warp staff uses the same proc to choose a destination. With bit 11 of `wChapterFlags` set, the D-pad steps through the player's empty castles and the home castle, showing each one's name (`rsMinimapShowWarpCastle`); A chooses, and B cancels.

## Trade-offs and hard limits

- **Scroll speed.** Each step builds one row and one column at the leading edge, so a step can't be more than 8 pixels, or a strip of cells would be skipped and left stale. The player's fastest speed, with Y held, is exactly 8.
- **1,024 tile IDs per chapter.** The 10-bit mask leaves the top 6 bits of each map word for area tags.
- **Width.** `rlGetMapDataIndex` knows only 64-tile and 128-tile rows. Nothing uses the wider mode.
- **One frame's work per strip.** A big change goes through the full redraw, which rebuilds all 32 rows in one pass and copies `$0800` bytes.
- **An unused second layer.** With bit 1 of `wUnknown00075A`, the row and column builders also build a second strip from IDs at `$7F/6400`, with the priority bit set, into `$065C` and `$061C`. The only writes to that variable, in the two map display setups, store 1, and nothing uploads those buffers.

## Where it lives in the source

- [engine/map/chapter_maps.asm](../../engine/map/chapter_maps.asm): `aChapterMapPointers`, the 12 descriptors, `rlLoadChapterMapLayout`, `rlLoadChapterMapGraphics`.
- [engine/map/camera.asm](../../engine/map/camera.asm): `rlGetMapDataIndex`, the conversions between tiles, map pixels, and screen positions, and centering the camera.
- [engine/map/scroll.asm](../../engine/map/scroll.asm): the scroll steps, `rlContinueMapScroll`, the strip queuing routines, and `rlCreateMapScrollScriptFromCoordinates`.
- [engine/map/map_tilemap.asm](../../engine/map/map_tilemap.asm): the row and column builders, `rlUploadMapRowAndColumn`, the full redraws, and `aMapRowUploadIRQ`.
- [engine/map/map_cursor.asm](../../engine/map/map_cursor.asm): cursor movement and the screen margins.
- [engine/map/map_display.asm](../../engine/map/map_display.asm): `rlSetUpChapterMapDisplay`, including the side window.
- [engine/map/map_sprites.asm](../../engine/map/map_sprites.asm): `rlUploadMapAnimations` and the pause flags.
- [engine/map/minimap.asm](../../engine/map/minimap.asm): `procMinimap` and the Warp castle choice.
- [data/terrain/](../../data/terrain/): movement costs and avoid bonuses by terrain.
- [docs/reference/map.md](../reference/map.md): the reference page.
