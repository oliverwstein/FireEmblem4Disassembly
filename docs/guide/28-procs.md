# Chapter 28: Procs

A **proc** is a small task that does a little work every frame until it is finished: a fade, a pop-up window opening and closing, a castle changing hands, the whole of a map battle. The proc engine keeps up to 16 of them alive at once and gives each one a turn every frame. Each proc has two ways of acting. It has an **on-cycle routine**, which runs every frame, and a **script**, a list of words that can sleep for a number of frames, call routines, and branch. Neither can block: a proc that has to wait returns, and tries again next frame.

The code that starts a proc carries on with its own work. It can ask later whether the proc is still running, or it can stop its own logic until the proc lets it go. This is how the game runs several animations at once on one CPU with no threads: the engine calls each proc once a frame, and each proc remembers where it was.

This chapter covers a proc's definition, its slot in RAM, creating and freeing, the frame step and the script interpreter, the two styles procs are written in, waiting for a proc, and the event engine's procs. The engine is in [engine/core/proc.asm](../../engine/core/proc.asm), bank `$82`; the procs themselves live with the systems that use them.

## A definition

A proc is created from a **definition** in ROM, a `structProcInfo` of four words ([include/Procs.h](../../include/Procs.h)):

| Offset | Field | |
|---|---|---|
| +0 | name | two characters, such as `"FI"` for the fade-in |
| +2 | init | a routine run once, when the proc is created |
| +4 | on-cycle | a routine run every frame |
| +6 | script | the address of the proc's script |

The three addresses are 16-bit, in the definition's own bank, so a proc's routines and script sit next to its definition. The source has 177 definitions. The engine copies the name into RAM and never reads it. The only code that does is a routine nothing calls, which looks for procs named `"NO"`; whatever used the names during development isn't in the ROM.

The fade-in is a complete proc in a dozen lines:

```rust
// procFadeIn: "FI", rlProcFadeInInit, rlProcFadeInCycle, aProcFadeInCode

fn fade_in_init(slot: Slot) {                    // rlProcFadeInInit
    wScreenFadingFlag = 0xFF;                    // restart the fade timer
}

fn fade_in_cycle(slot: Slot) {                   // rlProcFadeInCycle
    if fade_in_by_timer(1) {                     // rlFadeInByTimer: +1 brightness per frame
        free_proc(slot);                         // rlProcEngineFreeProc: at 15, done
    }
}

// aProcFadeInCode:
//     PROC_HALT
```

Its script does nothing but halt, so the on-cycle routine does all the work: one brightness step a frame until the screen is fully bright, then the proc frees itself. A setup routine that wants its screen to come up from black creates this proc and returns. It doesn't wait for the fade.

## The slots

`aProcSystem` ([include/WRAM.h](../../include/WRAM.h), `$0EC8`-`$10F6`) holds the 16 slots as a **structure of arrays**: each field is an array of 16 words, and a slot's fields sit at the same index in every array. That index is the slot number times two, the size of a word. The engine and every proc routine keep it in the X register, so `lda aBody0,x` reads the running proc's first body word in one instruction ([the Introduction](00-introduction.md) explains why the layout avoids a multiply).

| Field | Holds |
|---|---|
| `aHeaderTypeOffset`, `aHeaderTypeBank` | the definition; an offset of 0 marks a free slot |
| `aHeaderName` | the name |
| `aHeaderBitfield` | the engine's bits, and the proc's own |
| `aHeaderOnCycle` | the current on-cycle routine, which the proc can change |
| `aHeaderCodeOffset` | where the script carries on |
| `aHeaderSleepTimer` | frames until the script is read again |
| `aHeaderLoopCounter` | a counter for script loops |
| `aBody0`-`aBody7` | eight words of the proc's own data |
| `aLastFrameBitfield` | the bitfield as the last frame ended |

Five single words come first: `wFlag`, whose bit 15 is set while the engine steps the procs; `wOffset`, the index of the proc being stepped; a scratch pointer for the engine's indirect jumps; and `wInput0`-`wInput3`, through which a creator passes arguments to a proc's init routine.

The engine uses the bitfield's high bits:

| Bit | Meaning |
|---|---|
| `$0800` | the on-cycle routine was changed by the script; nothing reads it |
| `$1000` | skip the proc entirely; only an unused routine sets it |
| `$2000` | the proc has ended |
| `$4000` | created this frame: the engine's loop skips it until the frame ends |

The low bits belong to the proc. Its routines set them to signal its script, which tests them with `PROC_JUMP_IF_BITS_UNSET` and `PROC_JUMP_IF_BITS_SET`. The scripts in the game use `$0001`, `$0002`, and `$0004`.

## Creating and freeing

Code creates a proc by putting the definition's address in `lR44`, any arguments in `wInput0`-`wInput3`, and calling `rlProcEngineCreateProc` (155 calls in the source):

```rust
fn create_proc(def: &ProcInfo) -> Option<Slot> { // rlProcEngineCreateProc
    let slot = (0..16).rev()                     // highest free slot first
        .find(|&s| is_free(s) && !(stepping() && s == wOffset))?;  // all taken: carry set
    header_type[slot] = def;
    sleep_timer[slot] = 1;
    bitfield[slot] = 0; loop_counter[slot] = 0; body[..][slot] = 0;
    name[slot] = def.name;
    on_cycle[slot] = def.on_cycle;
    code_offset[slot] = def.script;
    (def.init)(slot);                            // X = slot × 2, data bank = def's bank
    step(slot);                                  // its first step, at once
    bitfield[slot] |= 0x4000;                    // not again this frame
    Some(slot)
}
```

A typical init copies its inputs into body words, since the inputs are shared by every creation and will be overwritten by the next one. The castle-taken proc below copies `wInput0`-`wInput2` (the castle, its old owner, and its new owner) into `aBody0`-`aBody2`.

The new proc gets its first step immediately, inside the creation call: its on-cycle routine runs, the sleep timer counts down from 1 to 0, and its script runs up to the first sleep. A script that begins with `PROC_YIELD 32` has started its 32-frame wait by the time the creator gets control back. Bit `$4000` then keeps the engine's own loop from stepping it a second time in the same frame. A proc created by another proc during the loop is therefore stepped exactly once that frame, whichever slot it lands in.

`rlProcEngineCreateProc` returns with the carry set when all 16 slots are taken, and nothing is created. Two of the 155 calls check. Other entry points:

| Routine | Does |
|---|---|
| `rlProcEngineCreateProcByIndex` | creates the proc in a given slot; carry set if the slot is taken |
| `rlProcEngineFindProc` | finds a running proc made from a given definition; X = its slot |
| `rlProcEngineFreeProc` | frees slot X: clears the definition, sets bit `$2000` |
| `rlProcEngineFreeProcByIndex` | frees a given slot |
| `rlProcEngineCheckProcEnded` | carry set if bit `$2000` is set in the slot's `aLastFrameBitfield` |
| `rlProcEngineResetProcEngine` | zeroes `aProcSystem`, freeing every proc; some screen openers call it |

## The frame step

The proc engine is the first of the five per-frame engines ([Chapter 27](27-screens.md)), so it runs inside every VBlank routine, after the game state routines. `rlProcEngineMainProcLoop` sets bit 15 of `wFlag`, steps every live slot from 15 down to 0, then clears bit `$4000` in every slot and copies each bitfield to `aLastFrameBitfield`.

One step of one proc:

```rust
fn step(slot: Slot) {                            // rsProcEngineRunProcOnCycleAndCode
    set_data_bank(header_type_bank[slot]);
    if bitfield[slot] & 0x1000 != 0 { return; }  // paused (never set)
    if bitfield[slot] & 0x4000 != 0 { return; }  // created this frame
    on_cycle[slot](slot);
    sleep_timer[slot] -= 1;
    if sleep_timer[slot] != 0 { return; }
    let mut pc = code_offset[slot];
    loop {
        let word = read_word(pc);                // in the proc's bank
        if word >= 0x8000 {                      // a command
            pc += 2;
            pc = run_command(word, pc);          // a routine in bank $82; may end the step
        } else {                                 // a sleep
            sleep_timer[slot] = word;
            code_offset[slot] = pc + 2;
            return;
        }
    }
}
```

The on-cycle routine runs every frame; the script runs only on the frames its sleeps allow. Between sleeps the script can run any number of commands in one frame.

### The script interpreter

A script is a list of words, and the interpreter tells commands from sleeps by the top bit. Every command routine is in bank `$82`, where code addresses run from `$8000` to `$FFFF`, so a command word is simply the address of the routine that carries it out. The interpreter jumps to it, and the routine reads its operands from the words after it and returns to read on. This is **threaded code**: the script has no opcodes to decode, only the addresses of its handlers. A word below `$8000` can't be a code address, so the format uses those values for sleeps: a number of frames.

The script is read through the data bank, which the step sets to the definition's bank, so a proc's script has to be in the same bank as its definition. The macros in [Procs.h](../../include/Procs.h) write the words:

| Macro | Does | Uses |
|---|---|---|
| `PROC_YIELD n` | sleep n frames | 374 |
| `PROC_CALL r` | call a routine anywhere in the ROM, with X = the slot | 309 |
| `PROC_JUMP_IF_BITS_UNSET p, b` | jump to p if none of the bits b are set in the bitfield | 116 |
| `PROC_HALT` | stop here; only the on-cycle routine runs from now on | 88 |
| `PROC_CALL_ARGS r, n` | call a routine with Y pointing at n bytes of arguments in the script, then skip them | 60 |
| `PROC_SET_ONCYCLE r` | change the on-cycle routine | 52 |
| `PROC_END` | free the proc and stop | 21 |
| `PROC_JUMP p` | continue at p | 14 |
| `PROC_SET_LOOP_COUNTER n`, `PROC_JUMP_WHILE_LOOP_COUNTER p` | a counted loop | 10 each |
| `PROC_JUMP_IF_BITS_SET p, b` | jump to p if any of the bits are set | 4 |
| `PROC_HALT_SLEEP`, `PROC_CREATE_ACTIVE_SPRITE` | a halt read every frame; create an active sprite | 0 |

`PROC_HALT` leaves the script pointing at itself and doesn't set the sleep timer, which the step has just counted down to 0. The next frame's count wraps it to `$FFFF`, so a halted script isn't read again for 65,536 frames, about 18 minutes. A halted proc moves on only when its on-cycle routine frees it or writes a new `aHeaderCodeOffset`. `PROC_YIELD 0` would do the same, and no script uses it.

## Two ways to write a proc

### Routines that replace themselves

129 of the 177 definitions have a script that is a single `PROC_HALT`. Those procs are written entirely as on-cycle routines, and they move from stage to stage by storing the next routine's address in their own `aHeaderOnCycle`. The source does this 275 times. The proc is a state machine whose state is the address of its current routine. The castle-name pop-up has four stages:

| Stage | Every frame |
|---|---|
| init | read the text, box color, display time, box size, and position from the event command that started it into the body; start rendering the text |
| `rlProcCastleNamePopUpCycle1` | run the text renderer; when the name is done, measure it, size the box to fit, and switch to Cycle2 |
| `rlProcCastleNamePopUpCycle2` | render again into the sized box; when done, open the pop-up window and switch to Cycle3 |
| `rlProcCastleNamePopUpCycle3` | count the display time down; at 0, close the window and switch to the dialogue proc's last stages (`rlProcDialogueCycle6` onward) |

Many procs share one halting script: 35 map magic effects point at the same `aProcMapMagicHaltCode`, and 13 dialogue boxes and pop-ups at `aProcDialogueBoxCode`.

### Scripts

The other 46 have real scripts, and nearly all of them are timed animations: the map battle, the map magic effects, the map action animations (a village raid, gold handed over, a unit going home), and the cutscenes. A script suits a sequence of fixed delays, where each beat is a call. The proc that plays when an army seizes a castle (`procCastleTakenOver`) is typical:

```
aProcCastleTakenOverCode
  PROC_YIELD 32
  PROC_CALL rlPlayCastleTakenOverSound
  PROC_SET_ONCYCLE rlProcCycleFlickerUnitsOfFactionSlot   ; units blink every frame
  PROC_YIELD 64
  PROC_CALL rlHideUnitsOfFactionSlot
  PROC_SET_ONCYCLE rlProcCastleTakenOverCycle            ; does nothing
  PROC_YIELD 16
_C235
  PROC_CALL rlUnloadFactionAndCheckVictoryTheme          ; the old owner's army is gone
_C23A
  PROC_YIELD 16
  PROC_CALL rlRedrawVisibleMapTilemap                   ; redraw the screen's map tiles
  PROC_YIELD 1
  PROC_SET_ONCYCLE rlProcCastleTakenOverCycle3
  PROC_HALT
```

The script and the routines share the work. While the script sleeps 64 frames, the on-cycle routine shows the old owner's units on odd frames and hides them on even ones. The init chooses where the script starts by writing `aHeaderCodeOffset` itself: at `_C23A` when the castle wasn't its owner's home castle, so no army falls with it, and at `_C235` when none of that army's units are on screen to blink. The last on-cycle routine frees the proc, gives the map step back its game state, which the init had set to 0, and queues the seize pop-up and the castle's event.

### Waiting on a bit

A script that has to wait for something only its routines can notice loops on one of the proc's own bits. The map battle's Pavise effect:

```
aProcMapBattlePaviseCode
  PROC_YIELD 16
  PROC_CALL rlMapBattleShowPavise
_D7A6
  PROC_YIELD 1
  PROC_CALL rlMapBattleCheckPaviseDone            ; sets bit $0004 when the effect is over
  PROC_JUMP_IF_BITS_UNSET _D7A6, $0004
  PROC_YIELD 14
  PROC_END
```

Every frame, the script calls a check, and the check sets bit `$0004` when the effect has finished. The jump falls through on the frame the bit appears, and the proc waits 14 more frames and ends. The map battle and the map action animations are built from waits like this one.

## Waiting for a proc

The code that creates a proc has three ways to follow it.

**Let it run.** Most creators don't look again. A fade, a window, or a sound fade-out finishes on its own and frees its slot.

**Ask whether it has ended.** `rlProcEngineCheckProcEnded` takes the slot that creation returned and tests bit `$2000` in `aLastFrameBitfield`. Freeing a proc clears its definition but leaves `$2000` in its bitfield, and the end-of-frame copy carries it into `aLastFrameBitfield`, where it stays until another proc takes the slot. The answer is about the slot, not the proc: if something else has been created there since, the check reports on the newcomer. The map battle waits this way for its Pavise proc and the scripted critical's effect, and the village raid and the Belhalla mages cutscene for the procs they start. `rlProcEngineFindProc` asks a different question: is any proc made from this definition still running?

**Stop the screen until it is done.** A proc can set `wGameStateRoutine1` to 0 when it starts and restore it when it ends, which stops the screen's step routine, and on the map the AI with it ([Chapter 27](27-screens.md)). About a dozen procs do this: the map menus, the map battle, the map action animations, the phase banner, and the castle-taken proc above.

Freeing a proc doesn't stop the step that is running. If an on-cycle routine or a `PROC_CALL` routine frees its own proc, the engine goes on reading the script until the next sleep or halt; `PROC_END` is the one command that frees the proc and stops reading at once. Procs end themselves from a routine (69 calls of `rlProcEngineFreeProc`) far more often than with `PROC_END` (21).

## Event procs

Event scripts ([Chapter 12](12-screenplays.md)) start procs for fades, camera scrolls, map battles, and cutscene effects, and can hold the script until they finish. The event engine shares the same 16 slots and keeps its own record of which ones are its:

- `rlEventEngineCreateProc` creates the proc and records its definition in `wEventProcOffsets` and `wEventProcBanks`, under the slot it landed in. It sets bit `$0004` of `wEventEngineFlags`: an event proc is running.
- While that bit is set, the event engine polls each frame (`rsEventEnginePollBlockingProcs`). A recorded slot that no longer holds the same definition has ended, and its record is cleared. When no recorded proc is still alive it sets bit `$0002`, and the script carries on.
- A proc whose record is marked `$0200` (`rlEventEngineMarkProcNonBlocking`) doesn't hold the script.
- `rlEventEngineFreeAllProcs` frees every recorded proc when a script starts and ends.

The poll compares definitions, not the `$2000` bit, so a slot freed and taken again by the same kind of proc in one frame would look as if the first had never ended. `rlEventEngineCreateProc` doesn't check whether creation succeeded. With all 16 slots full, it writes its record under whatever value was left in the A register, outside the table.

## Trade-offs and hard limits

- **16 slots, shared by everything.** Screens, menus, the map battle, and events draw from the same pool. A full pool makes creation fail quietly; two callers check.
- **Every step runs inside VBlank.** On-cycle routines and script commands run in the interrupt's logic time, so long work in a proc adds to every frame it runs in ([Chapter 26](26-the-frame.md)). Heavy work belongs in the main loop.
- **Eight body words.** A proc that needs more state keeps it elsewhere in RAM, as the map menus do with their RAM area.
- **Scripts share a bank with their definitions.** The script is read through the data bank, and its command routines must be in bank `$82`.
- **Ended means the slot.** `rlProcEngineCheckProcEnded` reports on whatever is in the slot now.
- **Order is by slot.** Procs step from slot 15 down, and new procs take the highest free slot, so the order in which procs act within a frame depends on which slots were free when they were created.

## Where it lives in the source

- [engine/core/proc.asm](../../engine/core/proc.asm): the engine (create, find, free, the frame step) and the script command routines.
- [include/Procs.h](../../include/Procs.h): `structProcInfo` and the `PROC_*` macros.
- [include/WRAM.h](../../include/WRAM.h): `aProcSystem`, `wEventProcOffsets`, `wEventProcBanks`.
- [engine/core/graphics/fade.asm](../../engine/core/graphics/fade.asm): `procFadeIn`, `procFadeOut`, `procMainLoopChangeFade`.
- [engine/map/popups.asm](../../engine/map/popups.asm): the castle-name pop-up and the other map pop-ups.
- [engine/map/map_sprites.asm](../../engine/map/map_sprites.asm): `procCastleTakenOver`.
- [engine/battle/map_battle.asm](../../engine/battle/map_battle.asm): the map battle and its effect procs.
- [engine/events/event_scripts.asm](../../engine/events/event_scripts.asm): the event procs.
- [tools/procs.py](../../tools/procs.py): reads proc scripts out of the ROM.
- [docs/reference/procs.md](../reference/procs.md): the reference page.
