# Chapter 30: Getting Graphics In

Most of the cartridge is pictures. The game's graphics, tilemaps, and layouts are stored as 1,647 compressed streams that take 2.19 MB of the 4 MB ROM and unpack to 8.4 MB, a ratio of almost four to one. Video RAM holds 64 KB, so a screen loads only the part it needs, and it loads it in two steps: the **decompressor** unpacks a stream from ROM into work RAM, and the DMA queue copies the result from work RAM into video RAM during a vertical blank ([Chapter 26](26-the-frame.md)). Unpacking is slow, much slower than the copy, so it runs in the main loop or with the screen switched off, never in VBlank.

Colors take a separate route. All 256 colors live in a palette buffer in work RAM, sent to the PPU every frame, and the screen's overall brightness is one nibble of a register buffer. A fade, of the whole screen or of a few colors, changes those buffers a step per frame.

This chapter covers the compressed format, the decompressor and its queue, the two ways screens load graphics, brightness fades, palette fades, the layer setup, and how the repository rebuilds the compressed streams from editable files. The code is in [engine/core/graphics/](../../engine/core/graphics/).

## The compressed format

A stream is a sequence of **methods**, each introduced by one byte whose top bits say which method it is and whose low bits carry a count. The format mixes three ideas: literal bytes, runs and patterns, and copies of what has already been written ([tools/decompress.py](../../tools/decompress.py) has every bit):

| First byte | Method | Writes |
|---|---|---|
| `$00`-`$3F` | literal | the next (b & `$3F`) + 1 bytes as they are |
| `$40`-`$4F` | nybble fill | bytes built from the nybbles that follow, each combined with a fixed nybble |
| `$50`-`$5F` | doubled | each following byte twice |
| `$60`-`$7F` | interleave | a fixed byte before, or after, each following byte |
| `$80`-`$DF` | copy | bytes from earlier in the output, at a distance, in a one- or two-byte form |
| `$E0`-`$F7` | run | one byte repeated, in a long and a short form |
| `$F8`-`$FD` | lookback | a stretch of the compressed stream itself, replayed |
| `$FE`, `$FF` | end | |

The copy methods repeat earlier output, such as a tile or a tilemap row that has already appeared. The interleave and nybble methods store a byte or nybble that recurs throughout a stretch only once.

The lookback is the unusual one. It points back into the compressed stream, not the output, and reads the methods it finds there again for a counted number of stream bytes, then returns to where it was. A sequence of methods that recurs in a stream is stored once and replayed. The count goes down once per stream byte read, and the points at which it is checked differ from method to method, so a lookback can end in the middle of a method; the Python port reproduces the assembly's reading order exactly for that reason.

A stream can cross a bank boundary. One that starts in the lower half of a bank (`$0000`-`$7FFF`) continues at `$0000` of the next bank when it reaches `$8000`; one in the upper half continues at `$8000` of the next. The portraits in banks `$CA`-`$D0` cross this way.

## The decompressor and its queue

`rlDecompressor` (`$80/AA02`) unpacks one stream from a source address to a destination address, both 24-bit, given in `DecompressionVariables`. `rlDecompressSingle` takes them in scratch registers instead (32 calls), and `rlDecompressLinear`, the sound loader's entry, reads a stream that runs on from `$xx/FFFF` to the next bank's `$0000`. The code calls `rlDecompressor` directly 55 times, from screens such as the title, the world map, and the minimap.

The other 61 calls go through a queue (one of them in an unused proc). `rlAppendDecompList` adds an entry, a source and a destination in `lR18` and `lR19`, to `aDecompressionArray`; `rlDecompressByList` runs the whole queue from the main loop routine (`rsRunFrameTasks`, `rsMapMainLoop`):

```rust
fn append_decomp_list(source: Addr24, dest: Addr24) {   // rlAppendDecompList
    queue[wDecompressionArrayPosition] = Entry { source, dest };
    queue[wDecompressionArrayPosition + 1].source = 0;  // end marker
    wDecompressionArrayPosition += 1;
    bDecompressionArrayFlag = 1;
    if bBufferINIDISP & 0x80 != 0 {              // the screen is off: no frame to protect
        decompress_by_list();
    }
}

fn decompress_by_list() {                        // rlDecompressByList, in the main loop
    if bDecompressionArrayFlag == 0 { return; }
    wDecompressionArrayPosition = 0;
    for entry in queue.iter().take_while(|e| e.source != 0) {
        decompress(entry.source, entry.dest);    // rlDecompressor: may take many frames
    }
    bDecompressionArrayFlag = 0;                 // only now: everything is unpacked
}
```

The main loop is interrupted by every VBlank, so a long stream simply takes several frames to unpack while the game keeps animating. `bDecompressionArrayFlag` stays set until the last entry is done, and that is how other code knows the data is ready.

The queue is 32 bytes, room for five 6-byte entries. The fifth's end marker runs two bytes past the array, onto `bFrameCounterByOnes` and `bFrameCounterByThrees`, neither of which is read after boot. Nothing checks for a sixth entry, which would be written over the frame counters and the random number table, and the reader hangs in an endless loop if it ever reads past 32 bytes.

## Two ways to load

**With the screen off.** A screen opener force-blanks the display and turns off the NMI before it loads ([Chapter 27](27-screens.md)). In forced blank, `rlAppendDecompList` runs the queue at once and the DMA queue sends each transfer at once ([Chapter 26](26-the-frame.md)), so an opener can write its loading as a straight list: unpack this into the decompression buffer, copy it to video RAM, unpack the next. The anti-tamper screen's loader is typical:

```
lR18 = gcAntiPiracyWarningTiles; lR19 = aDecompressionBuffer
jsl rlAppendDecompList                     ; unpacked now: the screen is blank
jsl rlDMAByStruct
  .structDMAToVRAM aDecompressionBuffer, $4800, $80, $A000   ; sent now, for the same reason
```

**During play.** A screen that changes graphics while it is showing, such as the battle scene or the map battle, can't let the copy go out before the unpacking has finished. It queues the decompression, then waits for `bDecompressionArrayFlag` to clear before it queues the DMA:

| Code | Waits by |
|---|---|
| the battle scene's loader, for the script commands that load graphics | a state byte (`bBattleSceneDecompState`): 1 = unpack then copy, 2 = copy, 3 = unpack only; each frame it checks the flag, and when it is clear it queues the copy and lets the scene script go on |
| the map battle | an on-cycle routine (`rlMapBattleWaitDecompression`) that polls the flag and sets its proc's bit `$0001` for the script when it clears ([Chapter 28](28-procs.md)) |
| the map magic and the event unit movers | a check of the flag before they start |

The map's VBlank routine follows the same rule from the other side: its animated tile uploads wait for a frame in which the DMA queue is empty ([Chapter 26](26-the-frame.md)).

## Brightness

The screen's brightness is the low nibble of `bBufferINIDISP`, 0 to 15, sent to the PPU every VBlank. Bit 7 of the same register is forced blank. `rlFadeInByTimer` and `rlFadeOutByTimer` ([fade.asm](../../engine/core/graphics/fade.asm)) move it one step every A frames, A given by the caller, and are called once a frame until they return the carry set. A fade-out ends by setting forced blank, so a dark screen is also one that can be loaded. A whole fade takes 15 × A frames.

The fade procs wrap them:

| Proc | Speed |
|---|---|
| `procFadeIn`, `procFadeOut` | a step a frame: a quarter of a second |
| `procFadeInByScreenFadingTimer`, `procFadeOutByScreenFadingTimer` | `wScreenFadingProcInput` frames a step |
| `procMainLoopChangeFade`, `procMainLoopChangeFadeByTimer` | fade out, then install a screen opener ([Chapter 27](27-screens.md)) |

Eight files create `procFadeIn`, screen setups among them, and a screen faded in that way comes up from black in 15 frames. Only `procMainLoopChangeFade` creates `procFadeOut`. The event engine has fade procs of its own. All of them share one timer (`wScreenFadingTimer` and its flag), so two fades running at once would step each other's timer; `rlClearAllFadeProcs` frees every fade proc, the events' included.

## Palette fades

The palette fades change colors in `aBGPaletteBuffer` (and `aOAMPaletteBuffer` immediately after it) toward a target, one step per call ([palette_fade.asm](../../engine/core/graphics/palette_fade.asm)). The caller sets the number of steps in `aPaletteFading.wMaxSteps` and calls a fade once a frame until it returns the carry set. Each takes its arguments from the bytes after the call, as the DMA queue's struct calls do, and returns past them:

| Routine | Fades | Toward |
|---|---|---|
| `rlFadePaletteToColors` | a run of colors | colors stored in RAM |
| `rlFadePaletteToBlack` | a list of runs | `wDesiredColor`, black when it is 0 |
| `rlFadeBGPaletteColorRanges` | a list of runs | a color of its own for each run |
| `rlSavePaletteBufferColorsToRAM` | | copies colors out of the buffer, to fade back to them later |

Every color is three 5-bit channels, and each channel steps on its own. A step moves the channel from its current value toward the target by an equal share of what is left:

```rust
fn interpolate_channel(current: u8, target: u8, step: u16) -> u8 {   // rsInterpolateColorChannel
    let n = aPaletteFading.wMaxSteps;
    if step == 0 { return current; }
    if step == n + 1 { return target; }
    let remaining = n - step + 1;                     // steps left, this one included
    let delta = ((target as i16 - current as i16) << 8) / remaining as i16;   // 8.8, hardware divider
    ((current as i16 * 256 + delta) >> 8) as u8       // truncated
}
```

The fade reads the current color from the buffer each time, so the distance covered per step stays the same: the fade is linear, and on the last step the divisor is 1 and the channel lands exactly on the target, whatever was lost to truncation along the way. The map magic effects, the castle conversations, the first generation's ending, the save menu, the title, and the world map use these fades. Two more routines fade the fixed color that color math adds or subtracts (`COLDATA`); nothing calls them.

Palette data that more than one screen uses sits in [palettes.asm](../../engine/core/graphics/palettes.asm): the unit relation colors of the status screen and the data window, the castle's sprites and shops, the map's sprites, and the portrait and menu palettes.

## Layers

Each background layer reads its tiles and its tilemap from places in video RAM that the screen chooses. `rlSetLayerPositionsAndSizes` takes nine VRAM word addresses in scratch registers, the four layers' tile areas, the sprites' tile area, and the four tilemaps, and writes them into both the hardware registers (`BG12NBA`, `BG34NBA`, `OBSEL`, `BG1SC`-`BG4SC`) and their RAM buffers. It does nothing unless the screen is force-blanked, and 24 files call it, every screen opener among them. The video RAM layout of a screen is therefore a set of nine numbers in its opener. The status screen puts the BG1 and BG2 tiles at 0, BG3's at `$4000`, the sprites' at `$6000`, and its tilemaps at `$2000`, `$2800`, and `$5800`.

Three helpers fill a page of the BG2 or BG3 tilemap buffer with one tile word, the usual way to clear a layer before drawing on it.

## In the repository

The disassembly keeps every compressed stream as editable files and rebuilds the ROM from them. For a 4bpp sheet:

```
NAME.4bpp.png ──(tools/gfx.py png2bpp)──► NAME.4bpp ──(tools/gfx.py lz)──► NAME.4bpp.lz ──► Layout.asm ──► ROM
                                                          │
                                       NAME.4bpp.comp ────┘  (the stream as the ROM has it)
```

- The PNG is indexed: its pixel values are the tile's color numbers, so it converts to tile data and back without loss ([tools/gfx.py](../../tools/gfx.py)). Tilemaps and other data are `.bin` files and skip this step.
- Most graphics are not kept as sheets in tile order but in a form drawn as the game shows them: portraits, scenes and UI layouts, chapter maps, map sprites and map battle sheets each have a folder in `gfx/` and a tool that writes `NAME.4bpp` or `NAME.bin` before `gfx.py lz` runs. The battle animation sheets in `gfx/battle_animation/` are still tiles in the order the game uploads them; their tool draws the frames as a preview. [AUTHORING_GRAPHICS_PLAN.md](../AUTHORING_GRAPHICS_PLAN.md) gives each format and what it was checked against.
- `gfx.py lz` decompresses the committed original stream, `NAME.4bpp.comp`, and compares it with the tile data. If they match, it uses the original bytes; if the file has been edited, it compresses the new data with [tools/compress.py](../../tools/compress.py), a compressor for the same format. An unedited build is byte-identical to the original ROM, and an edited one still decompresses with the game's own routine.
- A `.streams` list in each region of [gfx/build/](../../gfx/build/) names the streams in order between a start and an end address. [tools/stream_layout.py](../../tools/stream_layout.py) places them one after another into each region's `Layout.asm`, crossing bank halves the way the decompressor expects, and fails if an edited stream no longer fits before the region's end.

## Trade-offs and hard limits

- **Unpacking is slow and unbounded.** A long stream takes several frames in the main loop. Anything that depends on the result must wait for `bDecompressionArrayFlag`, or load with the screen off.
- **Five queued decompressions.** The queue holds five entries, unchecked, and its last end marker spills two bytes onto the frame counters.
- **One fade timer.** Brightness fades share a timer; overlapping fades interfere.
- **Layout fixed per opener.** A screen's video RAM layout is set once, with the screen off, by `rlSetLayerPositionsAndSizes`.
- **Space per region.** An edited stream that compresses worse than the original must still fit before the end address of its `.streams` region; regions don't spill into each other.

## Where it lives in the source

- [engine/core/graphics/decompressor.asm](../../engine/core/graphics/decompressor.asm): `rlDecompressor`, the queue, the single and linear entry points.
- [engine/core/graphics/fade.asm](../../engine/core/graphics/fade.asm): brightness fades and the fade procs.
- [engine/core/graphics/palette_fade.asm](../../engine/core/graphics/palette_fade.asm): palette fades.
- [engine/core/graphics/palettes.asm](../../engine/core/graphics/palettes.asm): shared palette data.
- [engine/core/graphics/tilemaps.asm](../../engine/core/graphics/tilemaps.asm): `rlSetLayerPositionsAndSizes` and the tilemap fills.
- [include/Decompressor.h](../../include/Decompressor.h), [include/Palettes.h](../../include/Palettes.h).
- [tools/decompress.py](../../tools/decompress.py), [tools/compress.py](../../tools/compress.py), [tools/gfx.py](../../tools/gfx.py), [tools/stream_layout.py](../../tools/stream_layout.py): the format and the asset pipeline.
- [gfx/](../../gfx/): the extracted graphics.
- [docs/reference/graphics.md](../reference/graphics.md): the reference page.

---

← Previous: [Chapter 29: Sprites and Scanlines](29-sprites-and-scanlines.md) | [Contents](OUTLINE.md) | Next: [Chapter 31: The Second Computer](31-the-second-computer.md) →
