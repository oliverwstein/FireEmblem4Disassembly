# Chapter 29: Sprites and Scanlines

Background layers are one half of the SNES picture. The other half is made of two things this chapter covers. **Sprites** are small pictures the PPU places anywhere on the screen, independently of the layers: up to 128 of them, described by a table in sprite memory (OAM). **Scanline effects** change the PPU's registers partway down the screen, so that one part of the picture is drawn with different settings from another. The hardware offers two ways to do that: HDMA, which writes a value to a register at the start of every line from a table, and a timer interrupt, which stops the CPU at a chosen line and lets code rewrite whatever it likes.

The engine has a layer of code for each:

| Piece | Does | Code |
|---|---|---|
| the sprite buffer | a copy of OAM in RAM that routines fill each frame and VBlank sends | `oam.asm` |
| band quotas | keep the map's units within the hardware's sprites-per-line limit | `oam.asm`, `map_sprites.asm` |
| the active sprite engine | 16 scripted, animated sprites | `active_sprites.asm` |
| the HDMA engine | 8 entries, one per HDMA channel, each with a table and a script | `hdma.asm` |
| the IRQ engine | up to 7 mid-frame interrupts, sorted by line | `irq.asm` |

The last three are built like the proc engine ([Chapter 28](28-procs.md)): fixed slots stored as parallel arrays, a definition in ROM with an init routine, an on-cycle routine and a script, and a step that runs the on-cycle routine and reads the script when its sleep runs out. They are the second, third and fourth of the per-frame engines ([Chapter 27](27-screens.md)). The code is in [engine/core/display/](../../engine/core/display/).

## The sprite buffer

An OAM entry is four bytes: X, Y, a tile number, and an attribute byte holding the tile's high bit, its palette, its priority against the layers, and two flip bits. A second, 32-byte table holds two more bits per sprite: the ninth bit of X, so a sprite can sit partly off the left edge, and the sprite's size, small or large (the two sizes are set for the whole screen by the `OBSEL` register). The game keeps both tables in RAM, as `aSpriteBuffer` (`$1C00`, 512 bytes) and `aSpriteExtBuffer` (`$1E00`, 32 bytes), and the VBlank routine sends them to OAM in full every frame ([Chapter 26](26-the-frame.md)).

The buffer is refilled from scratch each frame:

```rust
// in every VBlank routine
dma_palette_and_oam_buffer();        // send last frame's sprites
clear_sprite_ext_buffer();           // rlClearSpriteExtBuffer: sizes and X bit 8 to 0
run_game_state_routines();           // these and everything after push sprites,
run_vblank_hooks();                  //   each at wNextFreeSpriteOffset, which moves up
/* screen-specific drawing, such as the map's units */
hide_sprites();                      // rlHideSprites: the rest go off screen; offset = 0
```

Sprites pushed earlier get lower OAM numbers, and the PPU draws a lower-numbered sprite in front of a higher one. The order of the calls in a VBlank routine is therefore the order of the sprites from front to back. On the chapter map, sprites pushed by the game state routines come first, then the active sprites (the map battle's weapons and spell effects among them), then the moving unit, then the standing units.

### Sprite arrays

Code draws sprites from **sprite arrays** in ROM ([include/Sprites.h](../../include/Sprites.h)): a count, then five bytes per sprite, an X offset (with the size in bit 15), a Y offset, and the tile and attribute word. `rlPushToOAMBuffer` draws one array at a position:

```rust
fn push_to_oam_buffer(array: &SpriteArray) {     // rlPushToOAMBuffer
    // wR0, wR1: the position; wR4: added to each tile; wR5: ORed into each attribute
    let mut i = wNextFreeSpriteOffset;
    for s in array.entries() {
        oam[i].x = s.x + wR0;                    // set X bit 8 and the size in the ext table
        let y = s.y as i8 as i16 + wR1;
        oam[i].y = if y + 16 > 255 { 240 } else { y };   // off the bottom: hide it
        oam[i].tile_attr = (s.tile_attr + wR4) | wR5;
        i = (i + 4) & 0x1FF;                     // wraps after 128 sprites
    }
    wNextFreeSpriteOffset = i;
}
```

The tile base and attribute base let one array serve wherever its graphics are loaded in video RAM and whatever palette it should use. The ext table's two bits per sprite are set through two lookup tables indexed by the buffer offset, one giving the address of the ext byte and the other the bit mask for that sprite, so the push never computes a shift.

`rlHideSprites` moves every unused entry to Y = 240, below the screen. It does it with a run of 64 store instructions, one per entry, each writing a Y byte, and jumps into the middle of the run at the first unused entry, so it executes exactly as many stores as there are entries to hide. The buffer offset wraps at 512 bytes and nothing counts the sprites: a 129th sprite overwrites the first.

## Too many sprites on a line

The PPU can draw at most 34 eight-pixel slices of sprite on one scanline, and it drops the rest. A 16 × 16 sprite is two slices wide, so 17 of them on one line is the limit. A row of the chapter map can hold more units than that, and the standing units are drawn through a quota kept per 16-line band of the screen (`rlDrawDeployedUnitMapSprites`, [engine/map/map_sprites.asm](../../engine/map/map_sprites.asm)):

1. **Count what is already there.** `rlBeginOAMScanlineFrame` counts, for each scanline, the slices of the sprites already in the buffer: everything pushed before the units, such as the active sprites and the moving unit.
2. **Set each band's quota.** For each of the 16 bands, the quota is 17 minus the busiest line's count halved: the number of 16-pixel units that still fit. A lower quota applies at once; a higher one waits for the band's cooldown, normally 1 frame and 48 frames while a map battle has turned flicker on (`rlEnableOAMScanlineFlicker`), so the counts don't swing from frame to frame.
3. **Push the units.** Each unit goes into the list of the band it stands in. When a band is full, a unit within 16 pixels of either side of the screen is dropped. Any other unit takes the place of a sprite already in the band, which is moved off screen. The engine takes a tall unit's top half that way every frame, and other sprites only on odd frames.

In a crowded band, the units away from the screen's sides take turns being drawn, one frame in two, and those at the edges are dropped.

## Active sprites

An **active sprite** is a sprite array with a position, a routine that runs every frame, and a script that changes the array over time. The map battle's sprites, the map magic effects, the map action animations (a village raid, a unit going home), and two event commands create them. The map's units and cursor are not active sprites, and the battle scene has its own animation system ([Chapter 24](24-the-battle-scene.md)).

`aActiveSpriteSystem` holds 16 slots. Beside the proc engine's fields (definition, on-cycle routine, script position, frame timer, loop counter, eight body words), each slot has:

| Field | Holds |
|---|---|
| `aFrameOffset` | the sprite array drawn this frame |
| `aXPosition`, `aYPosition` | the position on the screen |
| `aTileBase`, `aTileBaseHigh`, `aPalette` | passed to the renderer as the tile and attribute bases |
| `aXVelocity`, `aYVelocity`, `aXSubpixel`, `aYSubpixel` | an 8.8 fixed-point velocity and the fractions it accumulates, for `rlMoveActiveSpriteByVelocity` |

A definition (`structActiveSpriteInfo`) is three addresses in its bank: init, on-cycle, script. Four create routines differ in which slot they take (the highest free, the lowest free, or the lowest free above 0) and all take the position in the X and Y registers.

Each frame, when the engine is switched on (`wFlag` bit 15, set by the screens that use it):

1. each live sprite is stepped, slot 15 down to 0: its on-cycle routine, then its frame timer, then at 0 its script;
2. every live sprite is drawn through the routine in `lActiveSpriteRenderer`, with `aFrameOffset` as the array;
3. a render queue for extra sprites is flushed. Nothing ever adds to it.

The renderer is normally `rlPushToOAMBuffer`. The map battle, the map actions and the cutscenes install `rlPushToOAMBufferDualTileBase`, which lets one array use two areas of video RAM: tiles below `$20` as they are, `$20`-`$3F` offset by `aTileBase`, `$40` and up by `aTileBaseHigh`.

### The script

An active sprite's script is a byte format. Each command is one byte, an index into a table of 31 command routines (`aActiveSpriteCommandPointers`), followed by its operands. The proc engine instead stores each command as the address of its routine ([Chapter 28](28-procs.md)). The most used command is the frame:

| Command | Does | Uses |
|---|---|---|
| `ACTIVE_SPRITE_FRAME d, f` | draw array f for d frames | 293 |
| `ACTIVE_SPRITE_TABLE_FRAME d, i` | draw frame i of the map battle's frame table for d frames | 97 |
| `ACTIVE_SPRITE_CALL r` | call a routine in the same bank | 59 |
| `ACTIVE_SPRITE_JUMP p` | continue at p | 38 |
| `ACTIVE_SPRITE_END` | free the sprite | 13 |
| `ACTIVE_SPRITE_MOVE x, y` | move by signed bytes | 4 |

Commands that show a frame, wait, or end the sprite end the step; the others read on. Sixteen commands serve the map battle and its magic: they upload frames, signal and wait for strikes, rounds and the ballista's bolt, and start and wait for map magic. The map battle's own scripts, which use them, are inside its compressed sprite data ([Chapter 23](23-two-ways-to-show-a-fight.md)), so the counts above leave them out.

## HDMA

An HDMA channel reads a table during the picture and writes it to one PPU register, line by line. The table is a list of entries, each a line count and the value or values to write; a count below `$80` writes once and holds for that many lines, a count of `$80` or more writes on every line. In **indirect** mode, the table holds pointers to the values instead of the values. Eight channels can run at once, each on its own register. With them a game changes a scroll offset, a window edge, or a color line by line: wavy water, a gradient, a window that opens from the middle.

The HDMA engine pairs each of the eight channels with an entry. `aHDMASystem` holds, per entry, the proc engine's fields plus the table's address and bank, the register it writes, the transfer mode, and an indirect table's data bank. A definition ([include/HDMA.h](../../include/HDMA.h)) is the three routines, then the table, the register and the mode. `rlHDMAEngineCreateEntry` takes the lowest free entry, so the entry number is the channel. About 70 places in the code create entries: the battle scene's effects and HUD, the title and opening, the windows and menus, the dialogue box, and the phase banner are the main users.

Each frame, the engine steps entries 0 to 7 and collects the channels of the live ones in `bHDMAPendingChannels`. The next VBlank routine, after the DMA queue, calls `rlHandlePossibleHDMA`, which writes each live entry's table address, register and mode to its channel's registers and turns on those channels in `HDMAEN`. The table address is written every frame, so changing `aOffset` is all it takes to switch tables. The order matters because the DMA queue turns HDMA off and uses channel 1; a VBlank routine without `rlHandlePossibleHDMA`, such as the default one, has no HDMA at all.

The script format is the proc engine's with one change: a word below `$8000` begins an `HDMA_YIELD`, a frame count followed by the table to use for those frames, so a script of yields is an animation of tables. Few entries use it. `HDMA_HALT` appears 36 times and every other command once or never. Most entries halt at once and rewrite their tables in RAM from the on-cycle routine.

### The dialogue box unfolding

The dialogue box opens over eight frames, more of it shown each frame. It is an indirect HDMA entry on `BG2VOFS`, the vertical scroll of the layer that holds the box ([engine/dialogue/dialogue_box.asm](../../engine/dialogue/dialogue_box.asm)):

```rust
fn dialogue_box_unfolding_cycle1(entry: Entry) { // rlDialogueBoxUnfoldingHDMACycle1
    build_tables(wDialogueBoxHDMAYPixelPosition, wDialogueBoxHDMACycleCounter);
    if wDialogueBoxHDMACycleCounter < 7 {
        wDialogueBoxHDMACycleCounter += 1;       // one step wider next frame
    } else {
        entry.on_cycle = dialogue_box_unfolding_cycle2;   // open: mark it done
    }
}

fn build_tables(y: u16, cycle: u16) {            // rsDialogueBoxHDMABuildTables
    let copy = if wVBlankEnabledFramecount & 1 == 0 { EVEN } else { ODD };
    // in that copy: lines above the box's visible part, the visible part, the lines below,
    // each pointing at a scroll value that shows either the box's rows or empty rows
    write_box_table(copy, y, cycle);
    entry.offset = copy;                         // the channel reads this one next frame
}
```

The table the hardware reads during a frame is the one built the frame before, so the routine writes the other copy, chosen by whether the frame count is even or odd, and points the entry at it. This is double buffering again ([Chapter 26](26-the-frame.md)), here for a table that is being read during the same frame it is rebuilt. The folding entry runs the same steps from 6 down to 0.

`rlBuildHDMADirectTableEntries` writes direct tables for code that builds them at run time. It splits a run of 127 lines or more into `$78` lines and the rest, since a count of `$80` or more would switch the hardware to writing every line.

## Mid-frame interrupts

The SNES can raise an interrupt when the beam reaches a chosen dot on a chosen line (the H and V timer registers, `HTIME` and `VTIME`). There is one such point at a time. To get several interrupts in one frame, the handler of each must program the next before it returns. The IRQ engine does that for up to seven entries.

`aIRQSystem` holds, per entry, the definition, the H and V times, the routine to call, and a script. A definition is four words: H time, V time, routine, script. The engine keeps the entries sorted by V time, the lowest line at the highest index, and walks down the indexes as the beam walks down the screen:

```rust
fn run_irq_engine() {                            // rlRunIRQEngine, from rlIRQ
    if engine_off() { return; }
    let e = wOffset;
    call_with_bank(lRoutine);                    // the entry's routine at its line
    step_script(e);                              // sleeps count IRQs, not frames
    wOffset = if e == 0 { top_entry() } else { e - 1 };   // next line down, or wrap
    program_entry(wOffset);                      // write HTIME, VTIME, lRoutine
}
```

After the bottom entry, the engine programs the top one, which fires on the next frame, so the cycle runs on through VBlank with nothing to restart it. The engine's per-frame routine in the hook table does nothing; all its work happens in the interrupt. Because the VBlank routine runs the game's logic during the picture with interrupts enabled ([Chapter 26](26-the-frame.md)), these interrupts break into the logic wherever it is.

A script word below `$8000` is a sleep, counted in interrupts, followed by a new V time for the entry, so a script can move its interrupt from frame to frame. Every IRQ script in the game is a single halt.

**Users.** The screens install few entries:

- **The chapter map** has one, at line `$D7`, which uploads the map's streamed row and column with the display off for the last lines of the frame ([Chapter 22](22-a-map-bigger-than-the-screen.md)).
- **The world map** and **the title screen** have two each.
- **The battle scene** has five, all at H `$60`. The scene's step writes brightness 0 every frame, so the picture starts black. At line `$0E` an interrupt writes the scene's real brightness, and at line `$CF` another forces the display off: the fight is drawn in a band from line 14 to line 206. At lines `$7E`, `$9C` and `$A1`, three more switch the layer settings (the layers shown, the tilemap and tile addresses, the scroll offsets, windows and color math) for the HUD in the lower part of the screen, according to the HUD's current mode. Each handler waits for the horizontal blank before it writes, so the change lands between two lines.

**Sorting.** `rlIRQEngineSyncAndSort` sorts the entries when their count has changed since the last sort; the map's and the battle scene's VBlank routines call it every frame. The sort makes one compare-and-swap pass at each gap, from half the count down to 1. One pass per gap doesn't order every arrangement (two of the six orders of three entries come out wrong), but the game creates its entries in order or close to it, and every set it creates comes out sorted.

## Four engines side by side

| | Procs | Active sprites | HDMA | IRQ |
|---|---|---|---|---|
| slots | 16 | 16 | 8, one per channel | 7 |
| stepped | once a frame, 15 to 0 | once a frame, 15 to 0 | once a frame, 0 to 7 | once per interrupt, top of the screen down |
| script commands | the routine's address (a word) | an index into a table (a byte) | the routine's address | the routine's address |
| a non-command word | sleep n frames | (none; a byte format) | sleep n frames with table t | sleep n interrupts, move to line v |
| output | whatever its routines do | sprites in the buffer | a table for its channel | register writes at its line |

## Trade-offs and hard limits

- **128 sprites, unchecked.** More wrap over the first entries.
- **17 sixteen-pixel sprites per line.** The map's units are fitted to it by the band quotas; other screens don't check.
- **16 active sprites, 8 HDMA entries, 7 IRQ entries.** Creation returns the carry set when they are full.
- **A frame of latency for HDMA tables.** A table built in a frame is read in the next, so animated tables need two copies.
- **One pass of sorting.** An arrangement of IRQ entries far from line order would run out of order.
- **Unused machinery.** The active sprite render queue, nine command routines missing from the command table, and five of the IRQ engine's commands are never used.

## Where it lives in the source

- [engine/core/display/oam.asm](../../engine/core/display/oam.asm): the sprite buffer, `rlPushToOAMBuffer`, `rlHideSprites`, the band quotas.
- [engine/core/display/active_sprites.asm](../../engine/core/display/active_sprites.asm): the active sprite engine, its renderers and its commands.
- [engine/core/display/hdma.asm](../../engine/core/display/hdma.asm): the HDMA engine, `rlHandlePossibleHDMA`, direct tables.
- [engine/core/display/irq.asm](../../engine/core/display/irq.asm): the IRQ engine.
- [include/Sprites.h](../../include/Sprites.h), [include/ActiveSpriteEngine.h](../../include/ActiveSpriteEngine.h), [include/HDMA.h](../../include/HDMA.h): structures and script macros.
- [engine/map/map_sprites.asm](../../engine/map/map_sprites.asm): the map's unit sprites.
- [engine/dialogue/dialogue_box.asm](../../engine/dialogue/dialogue_box.asm): the dialogue box's HDMA.
- [engine/battle_scene/screen.asm](../../engine/battle_scene/screen.asm): the battle scene's five IRQ entries.
- [docs/reference/sprites.md](../reference/sprites.md), [docs/reference/scanlines.md](../reference/scanlines.md): the reference pages.
