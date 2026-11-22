# Core: the frame, boot, game states, per-frame engines, procs

The core is the part of the program that decides what runs, and when. Everything else (the map, battles, menus, events) is called from here. This page is the reference; the [guide's introduction](../guide/00-introduction.md) tells the same story more slowly. Per-routine details: [routines/core.md](routines/core.md).

## Files

| File | Responsible for |
|---|---|
| [boot.asm](../../engine/core/boot.asm) | reset, clearing memory, registering the engines, the main loop, the opening logo screen |
| [interrupts.asm](../../engine/core/interrupts.asm) | the VBlank (NMI) and IRQ handlers, turning VBlank on and off, the IRQ engine |
| [game_states.asm](../../engine/core/game_states.asm) | `aGameStateRoutines` and its dispatcher; the per-frame engine table (`aTaskTable`) |
| [proc.asm](../../engine/core/proc.asm) | the proc engine and its script commands |
| [active_sprites.asm](../../engine/core/active_sprites.asm) | the active sprite engine and its script commands |
| [hdma.asm](../../engine/core/hdma.asm) | the HDMA engine and its script commands |
| [ram_structs.asm](../../engine/core/ram_structs.asm) | allocated RAM: struct arrays, RAM areas with handles, offset tables |
| [memory.asm](../../engine/core/memory.asm) | block copies (MVN/MVP stubs in RAM), indirect calls, `rlSetMainLoopPointer` |
| [random.asm](../../engine/core/random.asm) | the random number generator, and the code checksum checks that can rig it |
| [frame.asm](../../engine/core/frame.asm), [joypad.asm](../../engine/core/joypad.asm), [ppu_buffers.asm](../../engine/core/ppu_buffers.asm), [dma.asm](../../engine/core/dma.asm), [oam.asm](../../engine/core/oam.asm), [decompressor.asm](../../engine/core/decompressor.asm), [fade.asm](../../engine/core/fade.asm), [palettes.asm](../../engine/core/palettes.asm), [tilemaps.asm](../../engine/core/tilemaps.asm), [hardware.asm](../../engine/core/hardware.asm), [math.asm](../../engine/core/math.asm), [options.asm](../../engine/core/options.asm) | frame counters, input, the PPU register buffers, DMA queue, sprite buffer, decompression queue, fades, shared palettes, tilemap buffers, register defaults, arithmetic, option settings |
| [unused_game_state.asm](../../engine/core/unused_game_state.asm) | a screen nothing opens (game states `$16`/`$17`) |

Data: [include/WRAM.h](../../include/WRAM.h) (`wVBlankPointer`, `wMainLoopPointer`, `wIRQPointer`, `wGameStateRoutine1/2`, `wGameStateStep`, `aTaskTable`, `aProcSystem`, `aActiveSpriteSystem`), [include/GameStates.h](../../include/GameStates.h), [include/Procs.h](../../include/Procs.h), [include/ActiveSpriteEngine.h](../../include/ActiveSpriteEngine.h), [include/HDMA.h](../../include/HDMA.h), [include/RAMStructs.h](../../include/RAMStructs.h), [include/Checksums.h](../../include/Checksums.h).

## Control flow

### Two loops

The program has two threads of control.

1. **The main loop** (`rlMainLoop`) runs in the time left between frames. It pushes a return to `rlMainLoopWaitForVBlank` and jumps through `wMainLoopPointer`; when that routine returns, the CPU waits for the next VBlank and starts again. Each screen installs its own main loop routine. Most use `rsRunFrameTasks`: the soft-reset button check, the decompression queue and deferred sound uploads. The map's `rsMapMainLoop` also runs the AI (`rlRunAIEngineCycle`). Changing `wMainLoopPointer` is also how the game moves between screens: the next screen's *opener* (`rsOpenCastleScreen`, `rsOpenStatusScreen`, …) is installed as the main loop routine, usually by a fade proc (`procMainLoopChangeFade`), and runs once to set the screen up.

2. **The VBlank interrupt** (`rlVBlank`) runs once per frame, 60 times a second. It jumps through `wVBlankPointer`, also chosen by each screen. A typical VBlank routine (`rsMapVBlank`, `rsRunCastleScreenVBlank`, …) blanks the screen, sends the DMA queue, the palette and sprite buffers and the PPU register buffers to the hardware, sends queued sound to the APU, reads the joypads, counts the frame, then runs the **game state routines** (`rlRunGameStateRoutines`), then the **per-frame engines** (`rlRunVBlankHooks`), then updates the sound. If the previous VBlank routine has not finished (a lag frame), `rlVBlank` only counts the frame, sends sound and copies the brightness.

So almost all game logic runs inside the interrupt, after the hardware has been updated for this frame. The main loop does slow work that can be spread over frames.

A third pointer, `wIRQPointer`, is used by the IRQ handler for mid-frame effects (the IRQ engine, below).

### Boot

`rlReset` (the reset vector) puts the CPU in native mode, checks for copier hooks in RAM and the code checksums (see [Checksums.h](../../include/Checksums.h)), then `rlColdResetClearMemory` clears RAM and VRAM, sets up the PPU, the sound driver and the joypad repeat, and enters the main loop with `rlInitEngineAndStartLogo` installed. That routine clears the sprite and decompression state, copies the block-copy stubs to RAM, and registers five per-frame engines: procs, active sprites, HDMA, the IRQ engine and the dialogue engine. It sets both game state routines to 0 and jumps to `rsSetupOpeningLogoScreen`, which selects the opening logo's game states.

### Game states

`aGameStateRoutines` is a table of 56 long pointers. Two variables index it, and every frame `rlRunGameStateRoutines` runs entry `wGameStateRoutine1` and then entry `wGameStateRoutine2`. An entry whose bank byte is `$7D` is not called: its low word is written to `wGameStateRoutine1` instead.

Most screens own three consecutive entries ([GameStates.h](../../include/GameStates.h) names them all):

| Entry | Name | Selected by | Runs |
|---|---|---|---|
| 3k+1 | `rl<Screen>Upkeep` | the opener, in `wGameStateRoutine2` | every frame while the screen is up: sprites, scrolling, sometimes input |
| 3k+2 | `rl<Screen>Setup` | the opener, in `wGameStateRoutine1` | once: turns on sprites, starts a fade-in; ends with `inc wGameStateRoutine1` |
| 3k+3 | `rl<Screen>Step` | (the increment) | every frame after that: calls the routine for `wGameStateStep` from the screen's own table |

The screens with three entries are the opening logo, the save menu screen (which also shows the chapter intro card), the status screen, the castle, the world map, the chapter map, the unit, item and skill windows, the data window, the debug menu, the options menu, the revive screen and the epilogue. The battle scene (`$18`/`$19`) and the map battle (`$1A`/`$1B`) have only a setup and a step, with `wGameStateRoutine2` at 0. Entries `$13`-`$15` do nothing and are not selected; `$16`/`$17` belong to a screen nothing opens; `$1C`-`$1F` point into padding.

`wGameStateStep` is the screen's own sub-state. Other systems test the game state to know what is going on: the AI engine only runs while `wGameStateRoutine1` is `GAMESTATE_MAP_STEP`, and some event procs wait for the battle entries (`$18`-`$1B`) to end.

### Per-frame engines (`aTaskTable`)

`rlRegisterVBlankHook` takes a long pointer (in `lR44`) to a small table of routine addresses in one bank: +0 an init routine, which it runs at once, and +2 a per-frame routine, which it stores in the first free slot of `aTaskTable` (16 three-byte slots). Every frame, `rlRunVBlankHooks` calls each stored routine. Boot registers five:

| Table | Per-frame routine | Engine |
|---|---|---|
| `aProcEngineMainProcActionTable` | `rlProcEngineMainProcLoop` | procs |
| `aActiveSpriteEngineMainActionTable` | `rlActiveSpriteEngineMainLoop` | active sprites: scripted, animated sprites |
| `aHDMAEngineMainActionTable` | `rlHDMAEngineMainLoop` | HDMA effects, scripted |
| `aIRQEngineMainActionTable` | `rlIRQEngineStub` (nothing) | mid-frame IRQ effects; the work runs from the IRQ handler (`rsIRQEngineCycle` → `rlRunIRQEngine`): a few slots, each with a script that sets the IRQ line and a routine to call there |
| `aDialogueEngineMainActionTable` | `rlUnknown91A3D9` | the dialogue text engine |

Each table has a third word that `rlRegisterVBlankHook` never reads: a routine that does nothing for procs, active sprites and HDMA, `rlIRQEngineRestoreDefaultIRQ` for the IRQ engine, and `rlUnknown91A3DD` for dialogue. Nothing is known to call them; they look like a "shut down" entry that was never used.

### Procs

A proc is a cooperative task. Its definition in ROM (`structProcInfo`, [Procs.h](../../include/Procs.h)) is a two-letter name, an init routine, an on-cycle routine and a script, all in the definition's bank. `rlProcEngineCreateProc` (definition pointer in `lR44`) finds a free slot of 16, clears the proc's fields, runs its init routine and then one step at once, and marks it so that the main loop skips it for the rest of this frame.

Each frame `rlProcEngineMainProcLoop` gives every live proc a step (`rsProcEngineRunProcOnCycleAndCode`): unless bit `$1000` of its bitfield is set (paused, it seems), it calls the on-cycle routine, then counts down its sleep timer. When the timer reaches 0 the script runs from where it stopped. A script is a list of words: a word below `$8000` is a number of frames to sleep (`PROC_YIELD n`), which ends this step; a word from `$8000` up is the address of a command routine, followed by its operands. The commands (`rsProcCode*`) end the proc, halt it, call a routine, change the on-cycle routine, jump, loop on a counter, test bits, or create an active sprite.

The proc's fields live in `aProcSystem` as parallel arrays of 16 words, indexed by the slot number times two (`wOffset` holds it while a proc runs): `aHeaderTypeOffset`/`aHeaderTypeBank` (the definition; 0 means the slot is free), `aHeaderName`, `aHeaderBitfield`, `aHeaderOnCycle`, `aHeaderCodeOffset`, `aHeaderSleepTimer`, `aHeaderUnknownTimer` (the loop counter), and eight words of the proc's own data, `aBody0`-`aBody7`. A creator passes arguments in `wInput0`-`wInput3`. Other calls: `rlProcEngineFindProc`, `rlProcEngineFreeProc`, `rlProcEngineCheckProcEnded`, `rlProcEngineResetProcEngine`.

Events run their own procs in a separate set (`rlEventEngineCreateProc`, [engine/events/](../../engine/events/)).

### Allocated RAM

[ram_structs.asm](../../engine/core/ram_structs.asm) manages blocks of RAM that screens build at setup (`rlBuildRAMAreaHeaderAndGuidingEntry`): a *RAM area* is a heap with entries allocated, freed and compacted, some reached through handles so they can move; a *RAM struct* is an array of fixed-size entries with a count and a maximum, used through `lStructPointer1`/`lStructPointer2`. The map menus' option lists are an example (see `rlPushMenuOptionList` in [engine/menus/map_menu.asm](../../engine/menus/map_menu.asm)).

## Depends on

Nothing above it. The game state routines and procs call into every other system; the core itself calls the sound driver ([engine/sound/](../../engine/sound/)) and the dialogue engine's per-frame routine.

## Open questions

- Whether anything calls the third routine of an engine's action table.
- What sets bit `$1000` of a proc's bitfield (paused). `rlProcEngineCheckProcEnded` tests bit `$2000` of `aUnknownBitfield`, a separate array.
