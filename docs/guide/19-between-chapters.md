# Chapter 19: Between Chapters

Between playable maps—and before the Prologue begins—the game switches away from the chapter map to three distinct presentation screens: the **Jugdral history** timeline on a new game, the **world map** narration driven by event scripts, and the **chapter intro** title card. Each screen sets up its own PPU registers, mid-frame raster effects, and VBlank handler while borrowing existing subsystems—the chapter map's tile streamer, the dialogue engine, and the save menu's game state—to avoid duplicating whole-screen plumbing.

This chapter covers the world map screen and its split-screen IRQs, the markers, portraits, and region highlights placed on it, the chapter intro title card, the Jugdral history scroll, and the trade-offs and limits.

## The world map screen

### Game states and tile streaming

When an event script executes `WM_FADE_IN` ([Chapter 12](12-screenplays.md)), `rsSetupWorldMapScreen` in [engine/worldmap/world_map.asm](../../engine/worldmap/world_map.asm) installs `rsWorldMapVBlank`, calls `rlInitWorldMapGraphics`, registers two IRQs and a layer HDMA, and activates three game states:

- **`rlWorldMapSetup` (`$0E`, once):** Clears `$7F/4400..$7F/5708`, builds a RAM area at `$7F/5709`, enables active sprites, and advances to `$0F` step 0.
- **`rlWorldMapStep` (`$0F`, every frame):** Dispatches `wGameStateStep` through `aWorldMapStepHandlers`: step 0 (`rsWorldMapStepFadeIn`) raises `bBufferINIDISP` by 1 every 8 frames while running the frame; step 1 (`rsWorldMapStepRun`) runs the frame (and in the epilogue, where `wCurrentChapter == $FFFF`, counts frames in `wEpilogueRecordCharacter`); step 2 (`rsWorldMapStepFadeOut`) exists in the table but nothing selects it.
- **`rlWorldMapUpkeep` (`$0D`, every frame):** Copies `wMapScrollXPixels` and `wMapScrollYPixels` to BG1 and BG3 (`BG3HOFS` uses `(X & $0F) - 8`).

The continent of Jugdral is a 1024 × 1024-pixel (`$0400 × $0400`) map (`wMapWidthMode = 4`, scroll bounds `0..$0300` × `0..$0320`). Rather than building a second map renderer, `rlInitWorldMapGraphics` decompresses `gcWorldMapTileset` and `gcWorldMapTilemap` and hands them to `rlDrawVisibleMapToVRAM` and `rlUploadMapRowAndColumn`—the same tile streamer the chapter map uses ([Chapter 22](22-a-map-bigger-than-the-screen.md)).

Each running frame (`rlWorldMapRunFrame`) checks whether Start is pressed (outside the epilogue) to fade directly to `rsOpenChapterIntroScreen`, updates portraits and markers, uploads dialogue A-press arrows and BG3 text when a dialogue is active, and cycles color 5 of OAM palettes 1 and 2 across a 16-step orange-to-pale-yellow ramp every 4 frames (`rsCycleWorldMapSpriteColors`). When the event reaches `WM_FADE_OUT`, it fades to the chapter intro (or to `rlStartEpilogueCredits` in the epilogue).

### Split-screen framing: two IRQs and one layer HDMA

In SNES Mode 1, the screen needs BG1 for the continent, BG2 for both map highlights/shadows *and* the narration panel border below the map, and BG3 for narration text. The engine splits BG2 in two—tilemap `$5400` for the map overlay and `$4C00` for the unscrolled bottom panel—and uses two IRQs plus an HDMA channel on `TM` (`$212C`) to frame the screen:

```
Scanline
   0 ─────── Top IRQ (rlWorldMapTopEdgeFadeIn): BG2SC = $54, ramp INIDISP 2..15 over 8 lines
   1..167 ── Map viewport: BG1 (continent) + BG2 ($5400 highlights/shadows) + OBJ
 160 ─────── Bottom IRQ (rlWorldMapBottomEdgeFadeOut): ramp INIDISP 14..2 over 8 lines,
             brief blank ($80), switch BG2SC = $4C (unscrolled), restore INIDISP
 168..175 ── Panel border: TM = $02 (BG2 only)
 176..207 ── Narration box: TM = $16 (BG2 + BG3 + OBJ) if dialogue active, else $12 (BG2 + OBJ)
 208..215 ── Panel bottom: TM = $12 (BG2 + OBJ)
```

`rlWorldMapBuildLayersHDMATable` writes that `TM` table at `$00/08BC` every frame, checking `wWorldMapLayersDialogueStatus` so BG3 only appears in the panel while a dialogue is active.

## Actors on the continent

### Markers, portraits, and region highlights

Event commands (`WM_*`) populate three visual layers over the map:

- **Markers ([engine/worldmap/markers.asm](../../engine/worldmap/markers.asm)):** `aWorldMapMarker` (`$7F/5400`) holds 8 slots of army icons drawn as OAM sprites (`rsHandleWorldMapMarkers`). Each marker also decompresses a red or blue shadow overlay (`aWorldMapMarkerShadowTilemap`, `aWorldMapMarkerShadowPalettes`) onto BG2 (`$A800`) and fades it with procs.
- **Portraits ([engine/worldmap/portraits.asm](../../engine/worldmap/portraits.asm)):** `aWorldMapPortrait` (`$7F/5450`) allocates 7 words, with 6 usable portrait slots (OAM palettes 2–7 and VRAM `$0800..$1C00`). Each slot unpacks a portrait, draws it as sprites, and fades it in or out with procs ([Chapter 28](28-procs.md)). When `wGameStateRoutine1 == 0`, the load and fade helpers divert to the Chapter 5 memorial's portrait handlers ([Chapter 17](17-love-and-lineage.md)).
- **Region highlights ([engine/worldmap/highlight.asm](../../engine/worldmap/highlight.asm)):** `rlHighlightWorldMapPart` indexes 11 entries in `aWorldMapHighlights` (`WMH_Verdane` through `WMH_UnifiedThracia` in [WorldMapHighlights.csv](../../data/system/WorldMapHighlights.csv)), decompresses a 32 × 21-tile BG2 overlay to `$7E/7B88`, DMAs it to `$A800`, and starts `procWorldMapFadeInHighlightColor`.

## The chapter intro title card

When the world map finishes (or is skipped with Start), `rsOpenChapterIntroScreen` ([engine/worldmap/chapter_intro.asm](../../engine/worldmap/chapter_intro.asm)) borrows the save menu's game state (`GAMESTATE_SAVE_MENU_SETUP`/`UPKEEP`/`STEP`) at steps `$24`–`$27` with `rsRunMenuScreenVBlank`.

`rsLoadChapterIntroGraphics` dispatches `wCurrentChapter` (`0..11`) through `aChapterIntroTitleDMATable` to DMA that chapter's title tilemap, then `rsCreateChapterIntroHDMA` starts two HDMA channels ([Chapter 29](29-sprites-and-scanlines.md)):

- **`aChapterIntroBG2VOFSHDMA` (`$7F/828F` → `BG2VOFS`):** Applies a static 24-line wave offset table over the scrolled background (`rlCycleChapterIntroBG2VOFSHDMA` is a no-op).
- **`aChapterIntroBG1HOFSHDMA` (`$7F/838F` → `BG1HOFS`):** Actively steps the title card's alternating scanline bands toward `0` each frame until they align.

The card runs through four active steps: step `$24` (`rsChapterIntroStart`) clears brightness and advances; step `$25` (`rlChapterIntroFadeInStep`) plays the chapter intro song (`0` for the Final Chapter), raises brightness, and fades BG palette 4 in; step `$26` (`rlChapterIntroHold`) holds for 180–210 frames; and step `$27` (`rlChapterIntroFadeOutStep`) darkens the screen and starts `rsStartChapterMap` through `procMainLoopChangeFade`. Step `$28` (`rsChapterIntroSkip`) exists in the step table, but no code selects it.

## The Jugdral history

Choosing New Game on the title file menu runs the scrolling Jugdral history ([engine/save/jugdral_history.asm](../../engine/save/jugdral_history.asm)) in save menu steps `$1C`–`$21` before `rlStartNewGameSave` and the Prologue's world map.

`aJugdralHistoryEntries` lists a BG2 row pattern, a year (`$FF` for the era heading), and a text pointer for each milestone. `rlScrollJugdralHistory` creates parallax by scrolling BG1 one pixel every frame while scrolling BG2 and BG3 one pixel every *two* frames (`wVBlankEnabledFramecount & 1 == 0`), spreading each 16-pixel line's glyph rendering across twelve ticks ([Chapter 13](13-dialogue-and-text.md)):

```rust
fn scroll_jugdral_history() -> bool {                // rlScrollJugdralHistory
    if joy1_new & JOY_Start != 0 { return true; }    // skip to step $22
    wBufferBG1VOFS += 1;                             // BG1 scrolls every frame
    if wVBlankEnabledFramecount & 1 == 0 {           // BG2/BG3 scroll every 2 frames
        draw_line_step(wSaveMenuSlotRow & 0x0F);     // 12 ticks: BG2, year, 7× text, BG3, VRAM+=8
        if wSaveMenuSlotRow & 0x0F == 15 {
            if aJugdralHistoryEntries[wSaveMenuCommandRow] == 0xFFFF { return true; }
            wSaveMenuCommandRow += 1;
            if wSaveMenuCommandRow & 0x1F == 0 {
                aDialogue._Slot[0].wVRAMTileOffset = 0x0080;  // wrap 32-line tile ring
            }
        }
        wBufferBG2VOFS += 1;
        wBufferBG3VOFS += 1;
        wSaveMenuSlotRow += 1;
    }
    false
}
```

Because rendering a full line of dialogue glyphs in one frame would blow VBlank, `rlJugdralHistoryDrawLineStep` steps through `aJugdralHistoryLineSteps`: copying and uploading the BG2 backdrop row (ticks 0–1), clearing and drawing the year (tick 2), running the dialogue glyph renderer across 7 ticks (3–9), uploading BG3 (tick 10), and advancing the VRAM tile offset (tick 11)—spaced across 24 of the 32 frames a 16-pixel line takes to scroll in. Pressing Start jumps straight to step `$22`.

## Trade-offs and hard limits

Sharing BG2 between the map overlay (`$5400`) and the narration panel (`$4C00`) via an IRQ-timed bank switch avoids needing a fourth BG layer in Mode 1, at the cost of burning CPU cycles polling H-blank (`$4212 & $40`) across 16 scanlines every frame (8 at the top, 8 at the bottom). Sharing the save menu's game state for both the chapter intro and Jugdral history avoids registering extra game-state handlers.

The limits:

- **1024 × 1024-pixel world map** (`$0400 × $0400`).
- **8 marker slots**, **6 usable portrait slots** (7 words allocated in `aWorldMapPortrait`, 6 entries in the VRAM and palette tables), and **11 region highlights**.
- **12 chapter title slots (`0..11`):** `rsLoadChapterIntroGraphics` hangs in an infinite loop if `wCurrentChapter >= 12`.
- **32-line wrapping tile ring** for Jugdral history text.
- **Unreachable leftovers:** [engine/debug/world_map_test.asm](../../engine/debug/world_map_test.asm), world map step 2 (`rsWorldMapStepFadeOut`), and `procWorldMapMarkerShadow2FadeIn`.

## Where it lives in the source

- [engine/worldmap/world_map.asm](../../engine/worldmap/world_map.asm): `rsSetupWorldMapScreen`, `rsWorldMapVBlank`, game states `$0D`–`$0F`, top/bottom edge IRQs, and `rlWorldMapBuildLayersHDMATable`.
- [engine/worldmap/markers.asm](../../engine/worldmap/markers.asm), [portraits.asm](../../engine/worldmap/portraits.asm), and [highlight.asm](../../engine/worldmap/highlight.asm): markers, portraits, and region highlights.
- [engine/worldmap/chapter_intro.asm](../../engine/worldmap/chapter_intro.asm): `rsOpenChapterIntroScreen`, HDMA wave/slide setup, and steps `$24`–`$28`.
- [engine/save/jugdral_history.asm](../../engine/save/jugdral_history.asm): `rsJugdralHistorySetup`, `rlScrollJugdralHistory`, and `rlJugdralHistoryDrawLineStep`.
- [docs/reference/worldmap.md](../reference/worldmap.md) and [docs/reference/save.md](../reference/save.md): the reference pages.

---

← Previous: [Chapter 18: Saving](18-saving.md) | [Contents](OUTLINE.md) | Next: [Chapter 20: The Opening](20-the-opening.md) →
