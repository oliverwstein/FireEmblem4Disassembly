# Chapter 25: Full-screen windows and the status screen

A tactical RPG needs more than small map popups: it needs a multi-page character sheet, sortable unit, item, skill, and army overviews, an options screen, a Valkyrie revival grid, and a Game Over screen. Every one of these views must temporarily take over the entire SNES display and working RAM—whether opened from the chapter map or from inside a castle—and return cleanly to whatever launched it without losing the caller's cursor or page.

This chapter covers the shared full-screen menu architecture and scoped WRAM reuse, the status screen's split-scrolling pages and Holy Blood ring, each of the four map-menu overview windows, the options, revive, and Game Over screens, and the shared window and text primitives beneath them.

## The shared full-screen menu pattern

Every full-screen menu follows the same lifecycle, split between a bank `$80` opener and bank `$89`/`$8B` step routines. Rather than inventing a fresh VBlank handler per screen, all seven menus share `rsRunMenuScreenVBlank` ([engine/menus/status_screen.asm](../../engine/menus/status_screen.asm)), which flushes DMA, OAM, HDMA, PPU register buffers, joypad input, and menu tilemap uploads each frame:

```rust
fn open_full_screen_menu(opener: fn(), setup_state: u16, upkeep_state: u16) {
    set_forced_blank(0x80);
    wVBlankPointer = rsRunMenuScreenVBlank;
    halt_and_disable_vblank();
    reset_screen_registers_and_engines(); // proc, active-sprite, HDMA, IRQ

    configure_vram_layer_bases();
    init_screen_variables_and_graphics();

    wGameStateRoutine1 = setup_state;     // runs once, then advances to step routine
    wGameStateRoutine2 = upkeep_state;    // runs every frame (e.g., cursor/sprite upkeep)
    wGameStateStep = 0;
    wMainLoopPointer = rsRunFrameTasks;   // soft-reset check, decompression, deferred sound
    enable_vblank_and_unblank();
}
```

### Scoped WRAM reuse and caller-return pointers

Because full-screen menus never run simultaneously, they overlay the same WRAM region starting at `$7F/8183`:

```
  $7F/8183 +--------------------------------------------------------+
           | Status screen: unit snapshot, Holy Blood levels, steps |
           |--------------------------------------------------------|
           | Unit / Item / Skill / Data windows:                    |
           |   aUnitWindowDeploymentSlots, sort scores, cursors     |
           |--------------------------------------------------------|
           | Options menu: cursor, aOptionsMenuValues / Opening     |
           |--------------------------------------------------------|
           | Revive screen: borrows aUnitWindowDeploymentSlots      |
           |   & saves cursor in wItemWindowCursorRow before X!     |
           +--------------------------------------------------------+
```

When a screen can be reached from multiple callers, the caller writes its own low-word opener address into `wStatusScreenCaller` (or `wUnitWindowCaller`) before jumping:

| `wStatusScreenCaller` | Opened from | Fade-in speed | B returns to |
|---|---|---|---|
| `rsUnitWindowOpen` | Unit window (A on off-map unit) | `5` | Unit window (preserving place via `wUnitWindowCaller = rsOpenStatusScreen`) |
| `rsReviveScreenOpen` | Revive screen (X) | `1` | Revive screen (cursor saved in `wItemWindowCursorRow`) |
| `rsOpenCastleScreen` | Castle courtyard | `1` | Castle screen (`wChapterFlags` bit 5 set) |
| `rsReturnToMapMainLoop` | Chapter map (X on unit) | None (full brightness) | Map, or castle if `wChapterFlags` bit 5 is set |

## The status screen

The status screen runs an 11-step state machine (`$00`–`$0A` in `rlStatusScreenStep`) across three primary views:

```
  Scanline  0 +----------------------------------------------+  BG3VOFS = 0 (pinned by HDMA)
              |  Unit header: portrait, name, class, LV/EXP  |  First $57 (87) scanlines
  Scanline 87 +----------------------------------------------+  BG3VOFS = wBufferBG3VOFS
              |  Scrollable body (steps $00 <-> $01):        |  Down/Up scrolls at 7 px/frame
              |    Top half: 7 stats + bonuses, inventory    |
              |    Bottom half: leadership, lover/army,      |
              |      movement, gold, arena, ranks, skills    |
              +----------------------------------------------+
```

- **Top and bottom stat pages (`$00`, `$01`):** Both halves live on a single tall BG3 tilemap. Pressing Down or Up scrolls BG2 and BG3 together by `STATUS_SCREEN_SCROLL_SPEED` (7) lines per frame toward `STATUS_SCREEN_SCROLL_BOTTOM`, while `rlStatusScreenBuildBG3SplitTable` keeps the first `$57` scanlines pinned at scroll `0` and a second HDMA draws the background gradient.
- **Holy blood page (`$02`, `$05`):** Pressing A switches to a ring of twelve crests, with Loptous—the thirteenth blood—centered in the middle with its own graphics and gradient. On the first visit, step `$05` (`STATUS_SCREEN_STEP_LOAD_HOLY_BLOOD`) decompresses the crest sheet into `aDecompressionBuffer` and streams it to VRAM over five consecutive frames. Each inherited blood glints once for minor blood or twice on independent timers for major blood.
- **Item and skill details (`$03`, `$08`):** Pressing X places a cursor onto inventory items (displaying hit, might, range, weight, uses, kills, description, and weapon triangle) or onto skills on the bottom half (name, description, and personal vs. class origin).

Before drawing, `rsInitializeStatusScreenVariables` snapshots the unit's data and applies context redactions: non-player units hide experience, item uses, kills, and lover (and enemy luck displays as `0`); promotion-ready units blink a marker beside their portrait; dropped or unique items carry a marker; and `rsDrawWeaponRankLetter` prints `A`, `B`, `C`, `-`, or a star for major-blood weapon ranks and arena level 7.

Pressing R or L cycles through player generation IDs `1..$18`:

```rust
fn cycle_status_unit(direction: i8) { // rsStatusScreenNextUnit / PreviousUnit
    loop {
        gen_id = wrap_1_to_24(gen_id + direction);
        if let Some(unit) = player_unit_by_gen_id(gen_id) {
            if !unit.is_dead_or_captive() || joypad_held(SELECT) {
                select_unit(unit);
                break;
            }
        }
    }
    wStatusScreenReopenMode = current_page_tag(); // $1234 top, $4321 bottom, $1111 holy blood
    fade_out_and_reopen(rsOpenStatusScreen);
}
```

Holding Select lets the player inspect units that have already died or been captured.

## The four map-menu overview windows

Each of the four overview commands in the main map menu ([Chapter 10](10-menus-over-the-map.md)) installs its own full-screen view:

### Unit window

[engine/menus/unit_window.asm](../../engine/menus/unit_window.asm) (game states `$20`–`$22`) presents the player's army across six scrollable pages (`wGameStateStep 0..5`) covering stats, combat parameters, weapon ranks, skills, and personal status. Columns can be sorted by any stat, weapon rank, skill, or original recruitment order (`aUnitJoinOrder`), and a swap mode lets the player reorder rows directly. Pressing A on a deployed unit closes the window and jumps the map cursor to that unit; pressing A on a unit inside a castle opens its status screen instead, setting `wUnitWindowCaller` so closing the status screen returns to the same row.

### Item window

[engine/menus/item_window.asm](../../engine/menus/item_window.asm) (states `$23`–`$25`) scans every player unit's inventory and storage to build a flat list of all owned items alongside the selected item's stats and description. Three sort modes—by owner, item type, or name—cycle with a button press and persist across visits in `wItemWindowSortMode`. Pressing A jumps straight to the unit holding the highlighted item.

### Skill window

[engine/menus/skill_window.asm](../../engine/menus/skill_window.asm) (states `$2C`–`$2E`) lists 18 skills with each skill's icon, description, and every player unit that possesses it. Normally the scan checks only personal and class skills; holding Select while opening the window instructs the builder to count skills granted by held items (such as the Pursuit Ring or Miracle Sword) as well.

### Data window

[engine/menus/data_window.asm](../../engine/menus/data_window.asm) (states `$2F`–`$31`) summarizes the strategic state of the chapter: chapter title, victory goal, turn number, and a table of every active army with its leader, diplomatic relation to the player, and living unit count. Pressing X opens an army's detail panel showing its home castle and its leader's portrait, map sprite, level, HP, and attack power.

## Options, Valkyrie revive, and Game Over

Three specialized screens complete the full-screen menu suite:

- **Options menu ([options_menu.asm](../../engine/menus/options_menu.asm), states `$29`–`$2B`):** Copies current settings into `aOptionsMenuValues` and keeps a backup in `aOptionsMenuOpeningValues`. Up and Down move the cursor (animating a 10-pixel slide for one frame via `wOptionsMenuCursorMove`), Left/L and Right/R cycle values within `aOptionsMenuValueCounts`, Y restores `aOptionsMenuOpeningValues`, and A or B commits changes (`rlOptionsMenuApplyValues`) back to the map or castle:

| Option | Choices | Availability |
|---|---|---|
| `OPTION_ANIMATION` | Real, map, each unit | Always |
| `OPTION_TERRAIN_WINDOW`, `UNIT_WINDOW`, `AUTO_CURSOR` | On, off | Always |
| `OPTION_MESSAGE_SPEED` | `1`–`5` | Always |
| `OPTION_ENEMY_SPEED` | Real, fast | Always |
| `OPTION_SOUND` | Stereo, mono, off | Always |
| `OPTION_AUTO_SAVE` | Off, file `1`–`4` (`0` or `file + 1`) | Always |
| `OPTION_ENEMY_AI` | Normal, clever | Save completion count `> 0` |

- **Revive screen ([revive_screen.asm](../../engine/menus/revive_screen.asm), states `$32`–`$34`):** Launched by `rsCastleStaffValkyrie`, it scans for dead player units and arranges their names and animated map sprites in a three-column grid (or displays `REVIVE_SCREEN_STEP_NOBODY_DEAD`). Pressing X opens the highlighted unit's status screen, stashing the grid cursor in `wItemWindowCursorRow` so it survives the round trip; pressing A asks for confirmation and calls `rlBuildCastleActionRounds` to execute the Valkyrie Staff.
- **Game Over ([game_over.asm](../../engine/menus/game_over.asm)):** `rsSetupGameOverScreen` decompresses the Game Over 4bpp tiles (`gcUnknownC02B6B` → VRAM `$0000`) and both tilemaps (`gcUnknownC03455` → `$A000`, `gcUnknownC03558` → `$A800`), spawns `procGameOver` (`"GO"`), loads `aGameOverPalettes`, starts music `$72`, and fades in. From frame `$84` onward, `rsGameOverShake` shakes BG2 using `aGameOverShakeOffsets`; pressing Start once faded in—or letting the 1,020-frame timer expire—calls `rlSoftReset`.

## Shared window and text primitives

Two small modules supply the visual building blocks used across maps, castles, and full-screen menus:

- **Window frames ([window_graphics.asm](../../engine/menus/window_graphics.asm)):** `rlLoadWindowGraphics` dispatches on a style index at `$0756` (`0..3`) to DMA border tiles to VRAM `$6000` and copy `aWindowPalette` into BG palette 0. All four handlers load the exact same `g4bppWindowFrames` and `aWindowPalette`, leaving behind a stub for selectable window borders that never shipped. `rlGetDialogueBoxGraphicsAndPalette` loads the dialogue box's frame tiles and palette (`$DE/6200`) into the same slot.
- **Menu text ([menu_text.asm](../../engine/menus/menu_text.asm)):** `rlDrawMenuTextLine` stamps Shift-JIS strings into a menu tilemap as top and bottom 8 × 8 tile pairs:

```rust
fn draw_menu_text_char(ch: u16, tilemap: &mut [u16], row_stride: usize) { // rlDrawMenuTextLine
    if let Some((top, bottom)) = lookup_kanji_override(ch) { // 15 entries in aMenuFontKanjiOverrides
        write_tile_pair(tilemap, row_stride, base_tile + top, base_tile + bottom);
        return;
    }
    let bank_offset = aMenuFontBankOffsets[(ch.high_byte() - 0x81) as usize];
    let idx = decode_sjis_low_index(ch.low_byte()) + bank_offset;
    write_tile_pair(
        tilemap, row_stride,
        base_tile + aMenuFontBankOffsets[idx],               // top 8x8 glyph tile
        base_tile + aMenuFontBottomTiles[idx],               // bottom 8x8 glyph tile
    );
}
```

Two companion helpers handle BG3 directly: `rlDrawBG3TileRun` stamps consecutive two-row graphic labels, and `rlDrawMenuTextNumber` formats up to five-digit numbers.

## Trade-offs and hard limits

Reusing `$7F/8183`+ across seven full-screen menus keeps WRAM free for the map and battle engines, at the cost of requiring explicit state handoffs whenever two screens nest:

- **Cursor preservation across nested screens:** Because the revive screen borrows unit-window WRAM and the status screen overwrites `$7F/8183`+, the revive screen must stash its cursor in `wItemWindowCursorRow` before opening the status screen.
- **Fixed pool caps:** Unit cycling and join-order sorting assume at most 24 player units (`GenID 1..$18`), and the skill window indexes a fixed list of 18 skills.
- **Unused remnants:** `rlStatusScreenBuildBG2SplitTableUnused` and options-menu step `$02` (`rsOptionsMenuReturnToMap`) remain in the ROM with no callers.

## Where it lives in the source

- [engine/menus/status_screen.asm](../../engine/menus/status_screen.asm): `rsRunMenuScreenVBlank`, `rsOpenStatusScreen`, the 11-step state machine, and condition/skill description tables.
- [engine/menus/unit_window.asm](../../engine/menus/unit_window.asm), [item_window.asm](../../engine/menus/item_window.asm), [skill_window.asm](../../engine/menus/skill_window.asm), and [data_window.asm](../../engine/menus/data_window.asm): the four map-menu overview screens.
- [engine/menus/options_menu.asm](../../engine/menus/options_menu.asm), [revive_screen.asm](../../engine/menus/revive_screen.asm), and [game_over.asm](../../engine/menus/game_over.asm): options, Valkyrie revival, and Game Over.
- [engine/menus/window_graphics.asm](../../engine/menus/window_graphics.asm) and [menu_text.asm](../../engine/menus/menu_text.asm): shared window frames, palettes, and text/number helpers.
- [include/Menus.h](../../include/Menus.h) and [include/WRAM.h](../../include/WRAM.h): step constants and scoped menu WRAM definitions.
- [docs/reference/menus.md](../reference/menus.md): full reference for full-screen menus.
