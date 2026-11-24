# Uncompressed tile sheets that code copies to VRAM

These sheets are stored uncompressed and copied to VRAM whole by `.structDMAToVRAM` entries (`rlDMAByStruct`). `build.sh` converts each `NAME.4bpp.png` or `NAME.2bpp.png` to `NAME.4bpp`/`NAME.2bpp`, and `build.asm` includes that with `.binary`. `tools/gfx_blocks.py` made them from labelled slices. `../map/MapTiles.4bpp.png` was made the same way.

**How the depth was settled.** Every screen here runs in BG mode 1, where BG1, BG2 and the sprites are 4bpp and only BG3 is 2bpp. For each sheet, the layout the code sets before the copy (`rlSetLayerPositionsAndSizes`: wR1-wR4 are the BG tile bases, wR5 the sprite base and wR6-wR9 the tilemaps, all as VRAM word addresses) shows which layer can reach the destination. A sheet is 2bpp only where BG3 reaches it.

**Colours.** The PNGs are grey: index 0 is black and the rest are evenly spaced greys. The pixel values are the game's colour numbers, but which palette row each tile uses is set by tilemaps or sprite attributes not read yet. When a palette is proven, recolour the PNG without changing its indices.

| Sheet | ROM | Tiles | Copied to (VRAM byte address) | Why that depth |
|---|---|---|---|---|
| `WindowFrames.4bpp` | `$DD/72B0` | 96 | `$6000` (tile `$300`) by the unit, item, skill and data windows, `rlLoadStatusScreenDisplay`, `rsLoadOptionsMenuGraphics`; `$7200` by the revive screen; the first half by the four `rsLoadWindowGraphicsStyle0`-`89A047` | BG1/BG2 tiles start at `$0000` in all of these, so the address is beyond BG3's reach (BG3 at `$0000` or `$8000`, 2bpp, ends `$4000` later) |
| `DialogueBoxFrames.4bpp` | `$DE/2CC0` | 64 | `$6000` by `rlGetDialogueBoxGraphicsAndPalette` | as above |
| `MenuLabels.2bpp` | `$DE/48C0` | 384 | `$9800` (BG3 base `$8000`) in the unit window and `rlLoadStatusScreenDisplay`; `$1800` (BG3 base `$0000`) in the item and skill windows and `rsLoadOptionsMenuGraphics` | BG3 tile `$180` in both layouts; `$9800` is past BG1/BG2's reach (tile `$4C0`) and below the sprites (`$C000`) |
| `ItemStatLabels.2bpp` | `$D7/6000` | 128 | `$9800`, BG3 base `$8000`, by `rlShopScreenSetup`, `rlArenaScreenSetup` (arena), `rlClassChangeScreenSetup`, `rlDepotScreenSetup`, `rlAuguryScreenSetup` | as above |
| `ShopLabels.2bpp` | `$D7/6800` | 128 | `$9800`, BG3 base `$8000`, by `rsCastleLoadCourtyardScreen`, `rlSetupCastleCourtyardDisplay`, `rlSetupCastleTownDisplay` | as above |
| `BlankTile.2bpp` | `$91/D7E8` | 1 | `$DFF0` by `rlLoadSaveMenuScreen` and `rsFileMenuReloadTiles`, after filling the BG3 tilemap with tile `$3FF` | `rsSetSaveMenuScreenRegisters` sets BG34NBA to `$55`: BG3 tiles at `$A000`, so `$DFF0` is BG3 tile `$3FF`. All zero: it clears BG3 |
| `ShopScreen.4bpp` | `$D8/0000` | 512 | `$0000`, BG1/BG2, by `rsCastleLoadCourtyardScreen`, `rlSetupCastleCourtyardDisplay` (the first half by `rlSetupCastleTownDisplay`) | BG3 starts at `$8000` there |
| `../map/MapTiles.4bpp` | `$D9/0000` | 640 | `$0000`, BG1/BG2, by `rlSetUpChapterMapDisplay` and `rlSetUpChapterMapDisplayAllFrames`, the chapter map loaders | `rsResetMapGraphicsAndSystems` sets BG3 to `$8000` first |
| `CursorSprites.4bpp` | `$DE/40C0` | 32 | the sprite base: `$C000` (most), `$8000` in `rsLoadOptionsMenuGraphics` | only sprites reach these addresses in those layouts |
| `MenuCursorSprites.4bpp` | `$DE/44C0` | 32 | the sprite base: `$C000` in the unit window, `$8000` in the item, skill and data windows, `$0000` in `rsCopyDebugMenuGraphics` (sprite base `$0000`) | as above |
| `WeaponTypeIcons.4bpp` | `$DE/0200` | 64 | sprites: `$C800` in the unit window, `$E000` in `rlLoadStatusScreenDisplay`, `$D600` in the shop and arena screens | as above |
| `SkillIcons.4bpp` | `$DE/34C0` | 96 | `$0000` (BG1/BG2) in the unit window; sprites at `$8400` in the skill window and `$D000` in `rlLoadStatusScreenDisplay` | 4bpp either way |
| `StatusScreenHolyBloodIcons.4bpp` | `$DE/0A00` | 96 | `$E800`, sprites (the second name table), in `rlLoadStatusScreenDisplay` | only sprites reach `$E000` and up there |
| `ConversationSprites.4bpp` | `$DA/7A00` | 32 | `$C400`, sprites, in `rlConversationSceneSetup` | as above |

The names follow what the sheets show and who loads them. `StatusScreenHolyBloodIcons` shows 13 holy weapon icons and the round blood markers; `ConversationSprites` holds one small stroke, so its name says only who loads it.

## Blocks left as labelled slices

These are tilemaps, not tiles: each is copied into a layer's tilemap area in the layout in force. Most are named after the screen that loads them (`gfx/ui/tilemaps/*.bin`); `$D9/7940` stays `gUnknownD97940` because what it is (tiles or tilemap) is not settled, and the unreferenced blocks keep their addresses.

| Block | Bytes | Copied to |
|---|---|---|
| `$D7/7800` | `$800` | `$A000`, BG1 tilemap (`rsCastleLoadCourtyardScreen`, `rlSetupCastleCourtyardDisplay`) |
| `$D9/6C00` | `$800` | `$B000`: BG3 tilemap in `rlInitWorldMapGraphics`'s layout; also `rsUnusedWorldMapTestButtons`, whose layout is not read |
| `$D9/7940` | `$1C0` | `$AD40` in `rlLoadWorldMapCursorTiles` (BG2 tilemap row 21 if the world map uses the usual layout; not read) and `$9D40` in `rlInitWorldMapGraphics` (BG3 tile area there, which the routine first clears as if it were a tilemap): not settled |
| `$DA/6800`, `$DA/6A40`, `$DA/6D00` | `$240` each | `$E800` and `$ED00`, BG2 tilemap of `rlConversationSceneSetup`'s layout (`rsConversationDrawWindows`, `rlConversationCloseLeftWindow`, `rlConversationCloseRightWindow`) |
| `$DD/6730`, `$DD/69F0` | `$2C0`, `$8C0` | `$4000` and `$5280`, BG1 and BG2 tilemaps in `rlLoadStatusScreenDisplay` |
| `$DE/1600`, `$DE/1A40`, `$DE/1E80` | `$440` each | `$4800`, `$5B40`, `$4800`, the same tilemaps |
| `$DE/22C0` | `$1C0` | `$5000`, the unit window's BG1 tilemap (`rsUnitWindowBuildList`) |
| `$DE/2480`-`$DE/2980`, `$DE/60C0` | `$140` each | `$B040`, the unit window's BG3 tilemap: one per page (`rsUnitWindowDrawPage0`-`5`) |
