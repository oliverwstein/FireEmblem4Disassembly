# Chapter 26: The Frame

The SNES draws a frame 60 times a second: 262 scanlines, of which 224 are the picture. During the picture, the PPU is reading video RAM, sprite memory (OAM), and palette memory (CGRAM), and the CPU can't write to any of them. It can write during the **vertical blank**, the 37 or so lines after the picture ends and before the next one starts, which is about 2.3 ms of every 16.7 ms frame. It can also write whenever the screen is **force-blanked**, switched off by bit 7 of the `INIDISP` register, at the cost of a black screen.

The engine's frame machinery is built around that gap. Two threads share the CPU: the VBlank interrupt, which runs once a frame and carries nearly all of the game's logic, and the main loop, which gets whatever time the interrupt leaves. Everything the frame wants to change on screen is written first to copies in work RAM: a buffer for each PPU register the game uses, a buffer for the palettes, a buffer for the sprites, and a queue of DMA transfers for video RAM. The next VBlank sends all of it to the hardware before anything else runs. Below the frame sits the boot code, which brings the machine from power-on into the first frame and checks two stretches of its own code against stored sums.

This chapter covers the two threads, a VBlank routine from end to end, the buffers and the DMA queue, the joypads and the soft reset, the boot sequence, and the checksums. Which screen's logic runs inside a frame is [Chapter 27](27-screens.md); the procs and the other per-frame engines are Chapters 28 and 29.

## The timing budget

```
line 225                 261   0                                      224
     |------ VBlank -------|  |-------------- picture ------------------|
     |<----- ~2.3 ms ----->|  |<------------- ~14.3 ms ---------------->|
     ^
     NMI: rlVBlank
     [hardware writes      ][ game logic ................... ]
                                                             [ leftover ] (main loop)
```

The hardware writes have to fit in the blank. DMA moves a byte every 8 master clock cycles, about 2.7 MB a second, so a VBlank can carry at most about 6 KB. On the chapter map, 1,056 bytes go every frame whatever happens: 544 bytes of sprites and 512 of palettes. On top of that come the animated map tiles (2 KB or 1 KB on two frames of every eight, [Chapter 22](22-a-map-bigger-than-the-screen.md)) or the standing units' sprite frames, and whatever the frame's code queued. The map's row and column uploads don't use this time at all; they run from an interrupt near the bottom of the picture.

The game logic runs after the writes, inside the same interrupt, while the next picture is already being drawn. Nothing it does reaches the screen until the following VBlank sends the buffers it filled. A press of the D-pad is read in one frame's VBlank, moves the cursor's sprite in that frame's logic, and shows up on screen one frame later.

## Two threads

### VBlank

The PPU raises a **non-maskable interrupt** (NMI) at the start of every vertical blank, and the CPU jumps to `rlVBlank`. It saves the registers and calls the routine whose address is in `wVBlankPointer`. Each screen installs its own: the game has twelve, including `rsMapVBlank` for the chapter map, `rsRunMenuScreenVBlank` for the full-screen windows ([Chapter 25](25-full-screen-windows-and-the-status-screen.md)), and dedicated routines for the battle scene, world map, and castle screen.

```rust
fn vblank() {                                    // rlVBlank, the NMI handler
    enable_irqs();                               // cli: the IRQ engine may interrupt this
    save_registers();
    if wVBlankFlag & 0x8000 != 0 {               // the last VBlank routine is still running
        wVBlankDisabledFramecount += 1;
        send_sound_queues_to_apu();              // rlSendSoundQueuesToAPU
        INIDISP = bBufferINIDISP;                // rlCopyINIDISPBuffer
        tick_game_timer();                       // rlTickGameTimer
        restore_registers();
        return;                                  // back into the routine it interrupted
    }
    wVBlankFlag |= 0x8000;
    (wVBlankPointer)();                          // the screen's VBlank routine
    tick_game_timer();
    wVBlankEnabledFramecount += 1;
    restore_registers();
    wVBlankFlag = 0;
}
```

An NMI can't be masked by the CPU's interrupt flag (`sei`), so unless NMI generation is turned off in `NMITIMEN`, a new VBlank arrives on top of an unfinished routine. Bit 15 of `wVBlankFlag` catches that case, a **lag frame**. The nested call does the few things that must happen on time, sends the sound commands, keeps the screen brightness, and ticks the play timer, and then returns into the unfinished routine. The game's logic slows down by a frame, and the timer still counts 60 ticks a second. `wVBlankDisabledFramecount` counts the lag frames; nothing reads it.

The handler's first instruction re-enables the ordinary interrupt (IRQ), which the CPU masks on entry to any interrupt. The game logic inside the VBlank routine runs while the picture is being drawn, and the IRQ engine's mid-screen interrupts, such as the map's row upload at line 215, have to be able to break into it ([Chapter 29](29-sprites-and-scanlines.md)). `rlIRQ` reads `TIMEUP` to confirm a timer interrupt fired and calls the routine at `wIRQPointer`, which is an empty `rts` until the IRQ engine installs its own.

### The main loop

The other thread starts at boot and never ends:

```rust
fn main_loop() -> ! {                            // rlMainLoop
    loop {
        (wMainLoopPointer)();                    // the screen's main loop routine
        let n = wVBlankEnabledFramecount;        // rlHaltUntilVBlank
        while wVBlankEnabledFramecount == n {}
    }
}
```

After its routine returns, the loop spins until a VBlank routine has finished. A lag frame doesn't count, since the nested handler leaves `wVBlankEnabledFramecount` alone. Because NMIs interrupt the main loop wherever it is, a main loop routine can take as long as it needs: it is paused for each VBlank and picks up where it left off. That is where the game puts work that is heavy and can be split up. The usual routine, `rsRunFrameTasks`, checks the soft-reset buttons, runs the decompression queue ([Chapter 30](30-getting-graphics-in.md)), and sends deferred sound uploads. The map's `rsMapMainLoop` adds the AI's cycle ([Chapter 14](14-armies-with-a-mind.md)) and the planning of queued map sprite movement.

`wMainLoopPointer` also changes screens. A screen's step routine, running in VBlank, writes the address of the next screen's **opener** there. On the main loop's next pass the opener runs, blanks the screen, installs the new VBlank routine, loads the new screen, and installs that screen's main loop routine in its own place ([Chapter 27](27-screens.md)).

## A VBlank routine

The twelve VBlank routines are built from the same calls: hardware writes first, with the screen force-blanked, then the joypads, then the logic. `rsDefaultVBlankRoutine`, which boot installs, and the map's `rsMapVBlank`:

| Order | `rsDefaultVBlankRoutine` | `rsMapVBlank` |
|---|---|---|
| 1 | force blank | force blank |
| 2 | the DMA queue | the palette and sprite buffers |
| 3 | the palette and sprite buffers | the moving unit's frame and the animated tiles or standing sprites, if the DMA queue is empty; then the DMA queue |
| 4 | the PPU register buffers (ends the forced blank) | queued DMA channels and HDMA (`rlHandlePossibleHDMA`), then the PPU register buffers |
| 5 | the sound queues, the joypads, the frame counters | the sound queues, the joypads, the frame counters, the IRQ engine's sort |
| 6 | clear the sprite size bits | clear the sprite size bits |
| 7 | the game state routines, the per-frame engines | the game state routines, the per-frame engines, the dialogue boxes' tilemaps, the map menu's upload |
| 8 | hide unused sprites, update sound | draw the moving unit and the map sprites, hide unused sprites, update sound |

The routine opens by writing `$80` straight to `INIDISP`, forcing the blank, and the blank ends when the PPU register buffers are copied, since `bBufferINIDISP` holds the frame's real brightness. If the transfers ever ran past the end of the vertical blank, the top lines of the picture would come out black.

Steps 6 to 8 build next frame's sprites. Clearing the sprite size bits and hiding the unused sprites bracket the frame's drawing: everything that draws a sprite in between writes it into the sprite buffer, and whatever slots are left over are moved off screen. The map skips both, and its own sprite drawing, while an AI cycle step is running in the main loop (bit `$10` of `bAIEngineFlags`): such a step can last longer than a frame, and the AI's working maps share RAM with the moving map sprites' buffers.

The map routine's step 3 makes room in the blank: the tile and sprite-frame uploads wait for a frame whose DMA queue is empty, and the routine notes the skip in bit `$0008` of `wChapterFlags`. Nothing reads that bit. A second bit (`$0200`) would also suspend the tile animations and stop the map step from moving the cursor and camera; its only setter is a routine nothing calls.

## Buffers

Every PPU change the game makes during a frame goes into work RAM first. This is **double buffering** at the level of registers: the frame's code writes the next state into a back copy, and VBlank presents it all at once. It also means the code that changes a palette or a scroll offset doesn't have to know whether it is running in the blank or in the middle of the picture.

### Palettes and sprites

The game never writes CGRAM or OAM directly. `aBGPaletteBuffer` and `aOAMPaletteBuffer` (`$0100`-`$02FF`) hold all 256 colors, and `aSpriteBuffer` with `aSpriteExtBuffer` (`$1C00`-`$1E1F`) holds all 128 sprite entries. `rlDMAPaletteAndOAMBuffer` sends both in full every frame on two DMA channels, then writes the OAM address register from `wBufferOAMADD`. A palette fade ([Chapter 30](30-getting-graphics-in.md)) is a proc that changes colors in the buffer a few at a time; the next VBlank shows the result.

### The register buffers

The PPU's registers are write-only, so the game keeps a copy of each one it uses, named after the register: `bBufferINIDISP`, `bBufferBGMODE`, `bBufferTM`, `wBufferBG1HOFS`, and so on. `rlCopyPPURegisterBuffer` writes 33 PPU registers from 35 buffered values every VBlank: brightness and blanking, sprite size and address, the background mode, mosaic, the four layers' tilemap and tile addresses, the windows, the main and sub screen layer lists, color math, the fixed color (`COLDATA`, written three times for red, green, and blue), the interlace setting, and the scroll offsets of BG1 to BG3.

Two details in that copy:

- **Vertical offsets are written minus one.** The PPU starts each frame's picture one line below the vertical scroll value, so writing `buffer - 1` makes a buffer value of 0 put the layer's first line at the top of the screen.
- **BG4 has buffers (`wBufferBG4HOFS`, `wBufferBG4VOFS`) that the routine never writes.** Every screen uses mode 1 or mode 3, and neither has a fourth layer.

`rlEnableForcedBlank` and `rlDisableForcedBlank` set or clear bit 7 of `bBufferINIDISP` and return after the next VBlank routine has finished. `rlEnableVBlank` and `rlDisableVBlank` turn the NMI on and off, in both `NMITIMEN` and its buffer.

Screen openers start from known values. `rlHardwareResetScreenRegisters` writes the defaults into each register and its buffer: forced blank, mode 1 with BG3 at high priority, BG1 and sprites on the main screen, nothing on the sub screen, subtractive color math, window 1 from pixel 0 to `$F8`. `rlHardwareResetScreenPosMathHDMA` turns on automatic joypad reading, clears the hardware multiplier, divider, and timers, stops DMA and HDMA, and sets FastROM.

## The DMA queue

Video RAM transfers vary too much for a fixed buffer, so they go through a queue. Any code, at any point in the frame, appends a description of a transfer to `aDMAArray`, a 256-byte array at `$0346`; VBlank sends everything in it with `rlProcessDMAStructArray`. This is a **work queue** of commands: each entry is a type byte followed by that type's fields, and a 0 ends the list.

| Type | Size | Fields | Transfer |
|---|---|---|---|
| 0 | 1 | | end of the queue |
| 1 | 7 | source (24-bit), byte count, CGRAM address | to CGRAM |
| 2 | 9 | source, byte count, `VMAIN`, VRAM word address | to VRAM |
| 3 | 9 | the same | from VRAM to the source address |
| 4 | 11 | source, byte count, DMA mode, register, `VMAIN`, VRAM address | to any PPU register |

All four run on DMA channel 1, one after another. A byte count of 0 means 64 KB.

Most entries come from `rlDMAByStruct`, which takes its entry from the bytes right after the call. The assembler writes them with a macro, so a call reads like a statement:

```
jsl rlDMAByStruct
  .structDMAToVRAM aDecompressionBuffer, $0800, $80, $6000
```

The routine reads the struct through its own return address on the stack, copies it into the queue, adds the 0 that ends it, and moves the return address past the struct so execution continues after it. All 303 `rlDMAByStruct` calls in the source are type 2 (297 `.structDMAToVRAM` and 6 `.dstruct structDMAToVRAM`; [include/DMA.h](../../include/DMA.h)), which takes a VRAM byte address and halves it into the queue's word address. `rlDMAByPointer` queues a type-2 transfer from values in the scratch registers instead (`lR18` source, `wR0` count, `wR1` VRAM word destination), for sources computed at run time. Direct queue builders also use type 2; types 1, 3, and 4 are never queued.

```rust
fn dma_by_struct(entry: &DMAEntry) {             // rlDMAByStruct
    aDMAArray[wDMAArrayPosition..].copy_from(entry);
    wDMAArrayPosition += entry.size();
    aDMAArray[wDMAArrayPosition] = 0;            // end marker
    bDMAArrayFlag = 1;
    if bBufferINIDISP & 0x80 != 0 {              // the screen is off: VRAM is open now
        process_dma_struct_array();              // rlProcessDMAStructArray
    }
}
```

The last branch lets a screen opener load a whole screen without waiting on the VBlank budget. The status screen's opener, for one, force-blanks the screen and turns the NMI off before it loads ([Chapter 25](25-full-screen-windows-and-the-status-screen.md)), so every transfer it queues is sent on the spot, whatever its size.

`rlProcessDMAStructArray` does nothing if `bDMAArrayFlag` is clear. Otherwise it stops any running DMA and HDMA, sends each entry, and resets the queue's position to 0. A VBlank routine that wants HDMA turns it back on afterwards with `rlHandlePossibleHDMA`, which also starts any DMA channels a caller left pending in `bDMAPendingChannels`.

Nothing checks the queue's size when an entry goes in. The sender checks its position before each entry and, if it has reached 256 bytes, loops forever. 28 VRAM transfers fill the queue.

## Joypads and the soft reset

`rlGetJoypadInput` runs in every VBlank routine, after the hardware writes. It waits for the SNES's automatic controller read to finish and reads both pads into three words each:

- `wJoy1Input`, the buttons held;
- `wJoy1New`, the buttons pressed this frame and not the last;
- `wJoy1Repeated`, the new presses, plus every held button again when the repeat timer runs out. The timer starts at `wJoyRepeatDelay` when the held buttons change and restarts at `wJoyRepeatInterval` each time it fires. Boot initializes these to 40 and 10 frames, `rsSetupOpeningLogoScreen` overwrites them to 10 and 6 before the first VBlank, and chapter map display setup sets them to 10 and 2—so held directions wait a sixth of a second and then step 10 times a second on early screens or 30 times a second on the map.

A pad whose low four bits aren't 0 isn't a standard controller, and its input is replaced by the previous frame's. The second pad's words (`wJoy2*`) are kept the same way.

`rlIncreaseFrameCounters` adds 1 to `bFrameCounterByOnes` and 3 to `bFrameCounterByThrees` each frame. Nothing reads the second. The first is read once, to seed the random number table, at a point before the first VBlank where it is always 0 ([Chapter 6](06-resolving-a-battle.md)). Code that times something in frames reads `wVBlankEnabledFramecount` instead.

**The soft reset.** `rlButtonCombinationResetCheck` runs in the main loop each frame. When the held buttons are exactly Select, L, and R (Start may be held too) and Start is newly pressed, it blanks the screen, turns off the NMI and timer IRQs, clears the pending DMA/HDMA flags and the DMA queue, and jumps to `rlSoftReset`. That resets the stack, stops hardware DMA and HDMA, and goes straight to the memory clear in the boot sequence below, skipping the copier scan.

## Boot

The cartridge header ([header.asm](../../engine/core/frame/header.asm)) ends with the interrupt vectors. The reset vector points at `rlReset`, the native NMI vector at `rlVBlank`, the native IRQ vector at `rlIRQ`, and every other vector at `$8000`. The CPU wakes in 6502 emulation mode, running bank 0.

```
power-on / reset button
  rlReset                         native mode; jump into bank $80 (FastROM)
  rlBootInitAndCheckHardware      stack at $1FF7; FastROM on; screen, NMI, DMA, HDMA off
     "ELM0" at $1FFC?  -- no -->  scan $0000-$1FFD for copier hooks --> found: hang
           | yes                          | none
           +------------------------------+
     running in bank 0?  -- yes --> hang
     rlCheckCodeChecksumsAtReset; write "ELM0"
                                      |
soft reset (Select+L+R+Start)         |
  rlSoftReset ------------------------+
                                      v
  rlColdResetClearMemory          clear work RAM and VRAM; PPU defaults; sound driver;
                                  checksums again; default joypad repeat; default VBlank
                                  and IRQ routines; main loop routine = rlInitEngineAndStartLogo
  rlMainLoop
     rlInitEngineAndStartLogo     clear sprites and the decompression queue; RAM code stubs;
                                  register the five per-frame engines; game states to 0;
                                  open the opening logo
```

**`rlReset`** turns off interrupts, switches the CPU to native 65816 mode, and jumps to `rlBootInitAndCheckHardware` at its bank `$80` address. Banks `$80`-`$FF` are the cartridge's fast mirror once FastROM is turned on. Before the jump it tests three things that hold after a real reset: the CPU was in emulation mode, the direct page is 0, and the reset vector still holds `rlReset`'s address. A failed test takes a short branch to the same routine instead, which leaves the code running in bank 0, and the bank check below catches it.

**`rlBootInitAndCheckHardware`** sets the stack, turns on FastROM (`MEMSEL`), forces the blank, and stops the NMI, DMA, and HDMA. Work RAM keeps its contents through a press of the reset button, so the routine looks for the four bytes `"ELM0"` at `$1FFC`, which it writes at the end of every clean boot. If they're there, it skips straight to the bank check. Without them (at power-on, or after an anti-tamper hang erased them), it scans the first 8 KB of RAM for signs that a copier or cheat device has hooked the reset:

- the word just below the pre-reset stack pointer, plus one, is `rlReset`'s address: a return address into the reset code;
- anywhere in `$0000`-`$1FFD`, a `JMP ($FFFC)` (a jump through the reset vector), a `JMP (addr)` with `addr < $1FFF` whose target holds `rlReset`'s address, a `JMP rlReset`, or the 32 bytes `$60`, `$61`, ..., `$7F` in a row.

Any of these, or finding the code running in bank 0 instead of `$80`, goes to the anti-tamper hang (below). A clean boot runs the first checksum check and writes `"ELM0"`.

**`rlColdResetClearMemory`** clears `$7E/0000`–`$7E/1FF7`, `$7E/2000`–`$7E/FFFF`, and all of bank `$7F`, leaving only `$1FF8`–`$1FFB` (above the stack top) and `"ELM0"`. It clears all 64 KB of video RAM with a single DMA in fixed-source mode, which sends the same single zero byte over and over. Its source is the first operand byte of an `lda #$0000` instruction a few bytes further on in the same routine (`_DMAFillZero+1`). The routine then sets every PPU and CPU register to a default (`rsInitPPURegisters`), uploads the sound driver to the sound CPU (`rlInitSound`, [Chapter 31](31-the-second-computer.md)), runs the checksum check again, sets the initial joypad repeat times, installs `rsDefaultVBlankRoutine` and the empty IRQ routine, and enters the main loop with `rlInitEngineAndStartLogo` as its routine.

**`rlInitEngineAndStartLogo`** is the first main loop routine. It clears the sprite buffer and the decompression queue, copies the block-copy stubs into RAM, empties the table of per-frame engines and registers five: the procs, the active sprites, the HDMA engine, the IRQ engine, and the event engine. `rlRunVBlankHooks` calls them in that order every frame. It sets both game state numbers to 0 and jumps to the opening logo's setup ([opening_logo.asm](../../engine/title/opening_logo.asm)), which seeds the random number table, sets the logo's joypad repeat times (10/6), installs its VBlank routine and game states, and turns the NMI on.

## Checksums and the anti-tamper screens

The game guards two short stretches of its own code: the reset code and copier scan in bank `$80` (`$80/8D56`–`$80/8E2C`, from `rlReset` to `rlColdResetClearMemory`), and the reset signature routines and the boot-time checksum check in bank `$87` (`$87/8017`–`$87/80A9`). Each check adds up a range as 16-bit words, ignoring overflow, and compares the total with a stored sum. A patch that changes the copier scan or the check itself changes a sum.

The sums are stored three times, as `structCodeChecksums` records of three words: the bank `$80` sum, the bank `$87` sum, and `ChecksEnabled`, which turns the checks off when it is 0 ([include/Checksums.h](../../include/Checksums.h)). The game stores `$AA24`, `$B66C`, and `$5349` (the ASCII `"IS"`) in all three copies. Three routines read them, each against a different copy:

| Routine | Copy | Called | Checks | On a mismatch |
|---|---|---|---|---|
| `rlCheckCodeChecksumsAtReset` | `$87/8008` | twice at boot | the reset signature; the bank `$80` sum | the second anti-tamper screen (a matching reset signature runs the anti-tamper hang below) |
| `rlCheckCodeChecksumsCopy88` | `$88/8000` | twice by the save menu screen | both sums; copy 87 against copy 88 | the second anti-tamper screen |
| `rlCheckCodeChecksums` | `$8F/8000` | each time the random number table is reshuffled (every 55 rolls) | both sums; this copy against the other two | returns carry set, and the caller rigs the random numbers |

The third never stops the game. A failed check zeroes part of the random number table, more of it the longer the save has been played, until every roll comes out 99 ([Chapter 6](06-resolving-a-battle.md)).

**The reset signature.** `rlWriteResetSignature` copies 128 bytes of ROM (`$88/8888`-`$8907`) into `$1E00`-`$1E7F`, spanning `aSpriteExtBuffer` (`$1E00`-`$1E1F`) and the 96 bytes after it. `rlCheckResetSignature` compares them at boot: on a normal boot any differing word returns at once without writing. Only when all 128 bytes match—or when the copier or bank-0 check jumps straight to it—does the anti-tamper hang write the signature. Because the hang clears only the low 4 KB of RAM and its VBlank routine never clears the sprite buffer, pressing Reset after the first warning screen leaves all 128 bytes intact, so the next boot trips the check again and escalates to the second screen.

**The anti-tamper hang.** The hang erases `"ELM0"`, so the next reset runs the copier scan again, and reads a mark in battery-backed SRAM (`aSRAM.wAntiTamperMark`). If the mark is not set, it writes `SRAM_ANTI_TAMPER_MARK` and shows the first warning screen; if the mark is already set, or a checksum failed, it shows the second. Each screen clears the low 4 KB of RAM, reloads the sound driver, resets the registers, draws its picture through the decompressor and the DMA queue, fades in one brightness step a frame, turns off the NMI, and loops forever. A later boot whose checksum matches clears the mark again.

Moving code changes the sums even when nothing in the guarded ranges was edited, because the ranges hold absolute addresses of other routines. `./build.sh mod` rewrites all three copies after a build (`tools/checksums.py`), and `./build.sh mod --disable-checks` sets `ChecksEnabled` to 0.

## Trade-offs and hard limits

- **About 2.3 ms of transfers a frame.** The VBlank routine's hardware writes share the blank, and 1,056 bytes of it go to the palette and sprite buffers every frame on every screen. Larger loads happen with the screen off, or in pieces over several frames.
- **Logic one frame behind the screen.** The logic fills buffers that the next VBlank sends.
- **A 256-byte DMA queue with no bounds check.** Adding past the end overwrites the variables after it, and the sender hangs once it reaches the end.
- **Lag frames slow the game.** An overrunning VBlank routine finishes in the next frame; the sound, brightness, and play timer keep time.
- **Sixteen engine slots.** `aTaskTable` has room for 16 per-frame engines; five are used.
- **BG1 to BG3.** The register copy writes three layers' scroll offsets; BG4's buffers are never sent.
- **Checksum ranges hold addresses.** Any shift of the code they point at needs `./build.sh mod`.

## Where it lives in the source

- [engine/core/frame/boot.asm](../../engine/core/frame/boot.asm): `rlReset`, `rlBootInitAndCheckHardware`, `rlColdResetClearMemory`, `rlSoftReset`, `rlMainLoop`, `rlInitEngineAndStartLogo`, `rsRunFrameTasks`.
- [engine/core/frame/interrupts.asm](../../engine/core/frame/interrupts.asm): `rlVBlank`, `rlIRQ`, `rsDefaultVBlankRoutine`, `rlHaltUntilVBlank`, the VBlank and forced-blank switches.
- [engine/core/frame/dma.asm](../../engine/core/frame/dma.asm): `rlDMAPaletteAndOAMBuffer`, `rlProcessDMAStructArray`, `rlDMAByStruct`, `rlDMAByPointer`.
- [engine/core/frame/ppu_buffers.asm](../../engine/core/frame/ppu_buffers.asm): `rlCopyPPURegisterBuffer`, `rlCopyINIDISPBuffer`.
- [engine/core/frame/hardware.asm](../../engine/core/frame/hardware.asm): the register defaults.
- [engine/core/frame/joypad.asm](../../engine/core/frame/joypad.asm) and [frame.asm](../../engine/core/frame/frame.asm): the joypads, the frame counters, the soft reset.
- [engine/core/frame/anti_tamper.asm](../../engine/core/frame/anti_tamper.asm) and [include/Checksums.h](../../include/Checksums.h): the checksums, the reset signature, the anti-tamper screens.
- [engine/core/frame/header.asm](../../engine/core/frame/header.asm): the cartridge header and vectors.
- [engine/map/map_loop.asm](../../engine/map/map_loop.asm): `rsMapVBlank` and `rsMapMainLoop`.
- [include/WRAM.h](../../include/WRAM.h): the frame's pointers and counters (`$D3`-`$DE`), the joypad words, the buffers, and `aDMAArray`; [include/DMA.h](../../include/DMA.h): the DMA struct macros.
- [docs/reference/frame.md](../reference/frame.md): the reference page.

---

← Previous: [Chapter 25: Full-Screen Windows and the Status Screen](25-full-screen-windows-and-the-status-screen.md) | [Contents](OUTLINE.md) | Next: [Chapter 27: Screens](27-screens.md) →
