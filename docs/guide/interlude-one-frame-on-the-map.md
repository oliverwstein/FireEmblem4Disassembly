# Interlude: One Frame on the Map

This interlude follows one frame of the chapter map through every layer of Part VII, from the interrupt that starts it to the interrupt that ends it. The frame is a quiet one: the player's phase, map step 7, with the player holding Right. The cursor is already at the right-hand margin, so instead of the cursor moving, the camera scrolls right at 4 pixels a frame, and a column of tiles has to be ready at the right-hand edge. A few units stand on screen, animating, and nothing else is going on: no event, no menu, no fade.

The frame starts at scanline 225 of one picture and ends at scanline 225 of the next.

## Line 225: the interrupt

The PPU finishes drawing the picture and raises the NMI. The CPU stops whatever it was doing, which on a quiet frame is the main loop's wait, and jumps to `rlVBlank` ([Chapter 26](26-the-frame.md)). The handler re-enables the IRQ, saves the registers, sets bit 15 of `wVBlankFlag` to mark the VBlank routine as running, and calls the routine in `wVBlankPointer`. On the map that is `rsMapVBlank`.

## In the blank: last frame's work goes out

The first half of `rsMapVBlank` sends what the previous frame prepared. The screen is force-blanked while it does so.

1. **Sprites and palettes.** `rlDMAPaletteAndOAMBuffer` sends the 544-byte sprite buffer and the 512-byte palette buffer. The sprites are where last frame's logic put them: the cursor, the standing units.
2. **Animated tiles or standing sprite frames.** If nothing is waiting in the DMA queue, `rlUploadMapAnimations` runs; if last frame queued something, these uploads wait a frame. On two frames of every eight it uploads the next frame of the water and other animated tiles; on the other six, the next frames of the standing units' sprites ([Chapter 22](22-a-map-bigger-than-the-screen.md)).
3. **The DMA queue.** Anything queued last frame. On a quiet frame that is usually nothing; when a window has changed, it is that window's rows of the BG3 menu layer.
4. **HDMA.** `rlHandlePossibleHDMA` programs the channels of the live HDMA entries and turns them on.
5. **The register buffers.** `rlCopyPPURegisterBuffer` writes 33 PPU registers, among them `BG1HOFS` with the camera position last frame's logic left in the buffer, and `INIDISP`, which ends the forced blank at the map's full brightness.
6. **Sound.** `rlSendSoundQueuesToAPU` checks whether the APU has echoed the last value on port 0 and sends the next one waiting, if any ([Chapter 31](31-the-second-computer.md)).
7. **Input and counters.** `rlGetJoypadInput` reads the pads: Right is held. `rlIncreaseFrameCounters` counts the frame.
8. **The IRQ list.** `rlIRQEngineSyncAndSort` finds the number of IRQ entries unchanged, one, the map's row upload at line `$D7`, and does nothing.

Everything from here on runs while the next picture is being drawn, and none of it reaches the screen this frame.

## The logic

`rlClearSpriteExtBuffer` clears the sprites' size bits, and the frame's sprites start again from offset 0. Then the game state routines run ([Chapter 27](27-screens.md)), slot 1 first.

**Slot 1, `rlMapStep`.** The chain of checks for queued consequences finds nothing: no defeated unit, no relocation, no queued menu or pop-up, no canto, no action-ended event. It runs step 7, the phase, from `aMapStepRoutines`, and step 7 calls two routines:

- `rlMapCursorStep` updates `wMapSystemFlags`, sees that it is the player's phase and that the cursor is free, and reads the D-pad. Right is held and the cursor is at the margin, so the camera moves instead of the cursor. The cursor pushes its own sprite into the buffer at once, which makes it the frontmost sprite of the frame ([Chapter 29](29-sprites-and-scanlines.md)).
- `rlContinueMapScroll` takes one scroll step: the camera moves 4 pixels right and the new position goes into the BG1 scroll buffer. Then the step builds the column of tilemap cells at the right-hand edge. It does this on every step, with no check for an 8-pixel boundary, so at 4 pixels a frame each column is built and sent twice. It reads 16 map tiles from `aMapData`, looks up each one's quarters in the metatile table, writes 32 cells into the column buffer at `$059C`, and sets `wMapColumnUploadFlag` with the column's place in the tilemap ([Chapter 22](22-a-map-bigger-than-the-screen.md)).

Step 7 sees that the phase isn't over and returns. `rlMapStep` saves the step in `wSavedMapStep`.

**Slot 2, `rlMapUpkeep`.** It queues the standing units' sprite frames for this point in their animation, pulses the range overlay's colors, and copies the camera into `wBufferBG1HOFS` and `wBufferBG1VOFS`. The new camera position is now in the buffer, waiting for the next VBlank.

**The per-frame engines** run in registration order ([Chapter 28](28-procs.md), [Chapter 29](29-sprites-and-scanlines.md)):

1. **Procs.** The live ones on a quiet map are the unit window and the terrain window. Each checks whether the cursor has come to rest on a new tile, and while the camera is moving it leaves its window as it is.
2. **Active sprites.** The engine is on, but no sprite is alive, so nothing is drawn.
3. **HDMA.** Any live entries step and mark their channels for the next hand-off.
4. **IRQ.** The stub does nothing; the IRQ engine's work happens at its line.
5. **Events.** No script is running.

**The map's own drawing.** `rlRedrawDialogueBoxTilemaps` finds no dialogue box has moved. `rlRunMapMenuUploadIfEnabled` queues any rows of the BG3 menu buffer that changed onto the DMA queue for the next VBlank. No unit is moving, so `rlDrawMovingUnitSprite` draws nothing. `rlDrawDeployedUnitMapSprites` pushes the standing units through the band quotas: each 16-line band of the screen has room for what is left of the hardware's 17 sixteen-pixel sprites per line after the cursor ([Chapter 29](29-sprites-and-scanlines.md)). `rlHideSprites` moves the unused entries below the screen, and `rlUpdateSound` finds no song request in `wMusicID`.

`rsMapVBlank` returns. `rlVBlank` ticks the play timer, adds 1 to `wVBlankEnabledFramecount`, clears `wVBlankFlag`, and returns from the interrupt.

## The main loop

The CPU goes back to where the NMI found it: `rlHaltUntilVBlank`, which has been waiting for `wVBlankEnabledFramecount` to change. It has, so the main loop runs its routine, `rsMapMainLoop`:

| Call | On this frame |
|---|---|
| `rlButtonCombinationResetCheck` | Select, L, and R aren't held |
| `rlDecompressByList` | the queue is empty |
| `rlRunAIEngineCycle` | the AI's cycle is off in the player's phase |
| `rlRunDeferredSoundUpload` | nothing is waiting |
| `rlPlanQueuedMapSpriteMovement` | no event has queued a move |

The routine returns, and the main loop spins in `rlHaltUntilVBlank` until the next VBlank routine finishes, interrupted once by the IRQ below.

## Line 215: the column goes in

At scanline `$D7` (215), near the bottom of the picture, the IRQ the map installed fires ([Chapter 29](29-sprites-and-scanlines.md)). `rlIRQ` reads `TIMEUP`, sees the timer interrupt, and calls `rsIRQEngineCycle`, which runs the map's one entry, `rlIRQUploadMapRowAndColumn`. It waits for the horizontal blank, forces the display off, and runs `rlUploadMapRowAndColumn`: the column flag is set, so it sets the VRAM increment to 32 words and sends the 64-byte column from `$059C` into the BG1 tilemap at `$5000`, at the column the scroll step chose ([Chapter 22](22-a-map-bigger-than-the-screen.md)). It writes `INIDISP` back with brightness 0, so lines 216 to 224 are black, and the IRQ engine programs the same entry again for the next frame.

The new column is in video RAM before any picture shows the camera's new position.

## Line 225 again

The next NMI arrives and `rsMapVBlank` begins again with the first half above. This time `rlCopyPPURegisterBuffer` writes the new camera position to `BG1HOFS`, the sprite buffer carries the cursor and the units drawn in the logic above, and the next waiting sound value, if any, goes out on port 0. The picture drawn after this VBlank is the first to show the camera 4 pixels further right.

```
          frame N                                          frame N + 1
 line: 225 ───────────── 261 │ 0 ─────────────────── 215 ── 224 │ 225 ...
       │ VBlank             │  picture                │IRQ│dark  │ VBlank
       │                    │                         │   │      │
 NMI ─►[send last frame's   ][ logic: map step, scroll step builds column,
        buffers, read pads ]   upkeep, engines, units drawn ]
                                         [ main loop: nothing to do ... ]
                                                      [ column → VRAM ]
                                                                   ─► [ BG1HOFS = new camera,
                                                                         new sprites sent ]
                                                                        picture N + 2 shows it
```

A press of Right is read in one VBlank, changes the buffers during the picture that follows, and appears on screen in the picture after the next VBlank.

## The same frame on an enemy phase

On a computer army's phase, the shape of the frame stays the same, but the main loop has work to do. `rlMapCursorStep` hands the cursor to the AI's movement (`rlMapAIMoveStep`), and in the main loop `rlRunAIEngineCycle` runs one step of the AI's cycle ([Chapter 14](14-armies-with-a-mind.md)): building a threat map, choosing a target, planning a route. A step can take longer than the time left in the frame. The NMI interrupts it at line 225 like anything else, the VBlank routine runs, and the AI step picks up where it was when the interrupt returns.

While a step is in progress, the AI sets bit `$0010` of `bAIEngineFlags`, because its working maps share RAM with the moving map sprites' buffers. `rsMapVBlank` sees the bit and skips the units' sprites: it doesn't clear the size bits, draw the moving or standing units, or hide the unused entries. The sprite buffer keeps the units as the last frame left them. The tile animations still upload in the blank and the music plays on, and the units are redrawn on the first frame after the step ends.

## Where it lives in the source

- [engine/core/frame/interrupts.asm](../../engine/core/frame/interrupts.asm): `rlVBlank`, `rlIRQ`, `rlHaltUntilVBlank`.
- [engine/map/map_loop.asm](../../engine/map/map_loop.asm): `rsMapVBlank`, `rsMapMainLoop`.
- [engine/map/map_step.asm](../../engine/map/map_step.asm): `rlMapStep`, `rlMapUpkeep`.
- [engine/map/map_cursor.asm](../../engine/map/map_cursor.asm), [engine/map/scroll.asm](../../engine/map/scroll.asm), [engine/map/map_tilemap.asm](../../engine/map/map_tilemap.asm): the cursor, the scroll step, the column and its upload.
- [engine/map/map_sprites.asm](../../engine/map/map_sprites.asm): the units' sprites and the animation uploads.
- [docs/reference/map.md](../reference/map.md), [docs/reference/frame.md](../reference/frame.md).
