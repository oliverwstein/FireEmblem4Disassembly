# Introduction: How a 1996 Game Is Put Together

*Fire Emblem: Genealogy of the Holy War* came out in May 1996 on a 4 MB cartridge. Its machine has a 3.58 MHz CPU, 128 KB of work RAM, 64 KB of video RAM, and no operating system. The game still has to run a war: dozens of units on a map larger than the screen, armies with their own minds, castles changing hands, couples falling in love, children inheriting their parents' blood and weapons a generation later. All of it has to stay smooth at sixty frames a second.

This chapter is the map before the territory. It doesn't explain any one system in depth. It shows the shape of the whole program, the handful of big ideas everything else hangs on, and where those ideas live in the source. The later chapters fill in the details. If you finish this one and can say "ah, so *that* is what `engine/core/` is for", it has done its job.

One promise: you won't need to read 65816 assembly. Where code helps, it's shown as Rust-flavoured pseudocode, with the real names of the routines and variables it translates, so you can find the original.

## The machine in one page

You need just enough hardware to see why the code looks the way it does.

**The CPU (the 65816)** is a 16-bit descendant of the 6502 in the NES and the Apple II. It has three registers that matter: an accumulator `A` and two index registers, `X` and `Y`. It can switch each between 8-bit and 16-bit mode at any moment, which is why the source is full of `.al`/`.as` (16-bit/8-bit accumulator) and `.xl`/`.xs` markers. Addresses are 24 bits wide: a *bank* byte and a 16-bit offset, written `$80/9B01` in this project ("bank `$80`, offset `$9B01`"). The cartridge is mapped into banks `$80`-`$FF`. Work RAM is banks `$7E`-`$7F`, and its first 8 KB is also visible in every bank, which makes it the cheapest memory to reach.

**The PPU (the picture processor)** draws the screen from video RAM: up to four *background layers* made of 8×8 tiles, plus up to 128 *sprites*. The CPU cannot touch video RAM while the screen is being drawn. It gets a window of about 2,300 microseconds per frame, the **vertical blank** (VBlank), after the last line is drawn and before the next frame starts. Everything that changes on screen has to be squeezed through that window, usually by **DMA**, a hardware copier much faster than the CPU. **HDMA** is DMA that fires once per scanline, which lets the game change a register partway down the screen. That's how it gets wavy water, gradients and the dialogue box folding open.

**The sound chip (the SPC700)** is a separate computer with its own CPU and 64 KB of RAM. The game uploads a sound driver and samples to it, then sends it short commands through four one-byte ports. Sound gets its own chapter; for now, think of it as a peripheral you mail requests to.

That's the whole budget: a slow CPU, a small RAM, a short VBlank, and a pipe to a second computer. Nearly every design decision below follows from it.

## Two threads, one CPU

Here's the first surprise. Most game loops you've seen look like this:

```rust
loop {
    process_input();
    update();
    render();
    wait_for_vblank();
}
```

FE4 turns this inside out. The CPU has an interrupt, the **NMI**, that fires at the start of every VBlank. FE4 does almost all of its *per-frame* work inside that interrupt handler, game logic included. The ordinary "main loop" is left for slow jobs that don't need to finish within one frame.

The interrupt side ([engine/core/interrupts.asm](../../engine/core/interrupts.asm), [engine/map/map_loop.asm](../../engine/map/map_loop.asm)) runs whatever routine `wVBlankPointer` names. On the chapter map that is `rsMapVBlank`, and it reads almost like a frame's to-do list:

```rust
fn rs_map_vblank() {                    // runs 60 times a second, inside the NMI
    // 1. Use the VBlank window first, while video RAM is open.
    dma_palette_and_oam_buffer();       // rlDMAPaletteAndOAMBuffer
    process_dma_queue();                // rlProcessDMAStructArray
    handle_hdma();                      // rlHandlePossibleHDMA
    copy_ppu_register_buffer();         // rlCopyPPURegisterBuffer
    send_sound_queues_to_apu();         // rlSendSoundQueuesToAPU

    // 2. Then the frame's logic, after the screen has started drawing.
    read_joypads();                     // rlGetJoypadInput
    increase_frame_counters();
    run_game_state_routines();          // rlRunGameStateRoutines: what screen are we on?
    run_vblank_hooks();                 // rlRunVBlankHooks: procs, active sprites, HDMA
    update_map_sprites();               // (still-unnamed routines in bank $88)
    hide_unused_sprites();              // rlHideSprites
    update_sound();                     // rlUpdateSound
}
```

The main-loop side ([engine/core/boot.asm](../../engine/core/boot.asm)) is a loop that runs whatever routine `wMainLoopPointer` names and then sleeps until the next interrupt. On the map that is `rsMapMainLoop`:

```rust
fn rs_map_main_loop() {                 // runs in whatever time the interrupt leaves over
    check_soft_reset_buttons();         // rlButtonCombinationResetCheck
    decompress_by_list();               // rlDecompressByList: unpack queued graphics
    run_ai_engine_cycle();              // rlRunAIEngineCycle: the enemy thinks
    run_deferred_sound_upload();
}
```

Look at what lands on each side. Anything that must happen *exactly once per frame* goes in the interrupt: drawing, input, animation, the menus. Anything *heavy and divisible* goes in the main loop, which acts as a background thread: decompressing graphics, and above all the **AI**. While an enemy army "thinks" during its phase, it is using the leftover time in each frame, a little at a time, and the animation never stutters because the interrupt always gets the CPU first.

Each screen installs its own pair. The opening logo, the world map, the battle scene and the map each set `wVBlankPointer` and `wMainLoopPointer` to their own routines when they start. That's how the game changes the shape of its frame.

This is the *Game Loop* pattern, adapted to the hardware: the frame is driven by the display, not by the program, and the program fits its work around it.

## Game states: what screen are we on?

Inside the interrupt, `rlRunGameStateRoutines` decides which screen's logic runs ([engine/core/game_states.asm](../../engine/core/game_states.asm), [include/GameStates.h](../../include/GameStates.h)). There is a table of 56 routine pointers, `aGameStateRoutines`, and two variables index it, `wGameStateRoutine1` and `wGameStateRoutine2`. Every frame, both indexed routines run.

Entries come in threes, one triple per screen: title menu, castle, world map, chapter map, battle scene, unit window, item window, options, epilogue and so on. Here's how they appear to work together, judging from the opening logo and the map. One slot holds the screen's every-frame upkeep (keep the camera and sprites in step). The other starts at the screen's setup routine, which advances the index by one when done, so from the next frame it runs the screen's step routine. A third variable, `wGameStateStep`, says which phase of that screen the step routine is in.

```rust
fn rl_run_game_state_routines() {
    AGAME_STATE_ROUTINES[wGameStateRoutine1]();   // setup, then the screen's steps
    AGAME_STATE_ROUTINES[wGameStateRoutine2]();   // the screen's every-frame upkeep
}
```

This is a *State* machine in its most stripped-down form: no objects and no interface, just an index into a table of function pointers. Changing screens means writing two numbers. You'll see this idiom, *the table of routines indexed by a number*, everywhere in the game: event commands, AI cycle steps, battle scene commands, target filters. It is how 1990s assembly does polymorphism.

> The names of the individual game-state routines are recent and still being checked; treat them as labels, not proof.

## Procs: sixteen tiny threads

A screen's step routine could, in principle, do everything itself. In practice a screen has many things going on at once: a fade in progress, a window sliding in, a cursor blinking, a map scrolling to a castle while a dialogue box unfolds. Writing all of that as one routine with a pile of flags would be miserable. FE4 instead has a small cooperative multitasking system. The code calls its tasks **procs** ([engine/core/proc.asm](../../engine/core/proc.asm), [include/Procs.h](../../include/Procs.h)). The name, and much of the design, carried on through Intelligent Systems' later Fire Emblem games.

A proc is defined by a little record in ROM: a two-letter name, an *init* routine, an *on-cycle* routine, and a *script*:

```rust
struct ProcInfo {            // structProcInfo
    name: [u8; 2],           // e.g. "FI" for a fade-in; useful only to humans with a debugger
    init: fn(slot),          // runs once when the proc is created
    on_cycle: fn(slot),      // runs every frame
    code: &[ProcCommand],    // a tiny script: wait N frames, call this, jump there, end
}
```

Up to sixteen procs can be alive at once. Every frame, `rlProcEngineMainProcLoop` walks the slots and gives each live proc its turn: run its on-cycle routine, then step its script until it yields (`PROC_YIELD n` waits n frames), halts or ends. A fade, for instance, is a proc whose on-cycle routine nudges the screen brightness one step each frame and whose script ends when it reaches the target. Whoever started the fade doesn't wait for it; it goes on with its own work, and can ask later whether the proc has ended (`rlProcEngineCheckProcEnded`).

There are about 160 proc definitions in the game, and they're the glue of the presentation layer. The map's scrolling, every screen transition, the dialogue scenes, the event scripts themselves (an event runs *inside* a proc), the castle name pop-up, and so on. This is Nystrom's *Update Method*, with a *Bytecode*-like script bolted on.

### How the memory is laid out, and why

The way the proc engine stores its procs is worth stopping on, because the rest of the game does it too. You'd expect an array of sixteen proc structs. Instead `aProcSystem` ([include/WRAM.h](../../include/WRAM.h)) is a set of arrays, one per field, each sixteen entries long: `aHeaderTypeOffset[16]`, `aBody0[16]`, `aBody1[16]`, … `aBody7[16]`.

```rust
// Not this:                            // But this:
struct Proc { header, body0, body1 }    struct ProcSystem {
let procs: [Proc; 16];                      header: [u16; 16],
                                            body0:  [u16; 16],
                                            body1:  [u16; 16], /* … */
                                        }
```

Today we'd call this *structure of arrays*, and associate it with cache-friendly, data-oriented engines. On the 65816 the reason is simpler: there are only two index registers. Put the proc's slot number (times two) in `X`, and `lda aBody0,x`, `lda aBody3,x`, `sta aBody5,x` each reach a different field of the same proc in one instruction. You never compute "base + slot × size + field offset". The CPU's addressing modes make this layout the cheap one. The deployment table, the active sprites and the AI's unit lists are built the same way.

### Its siblings

Two more engines run beside the procs as **VBlank hooks**. These are entries in `aTaskTable`, a short list of per-frame engines that `rlRunVBlankHooks` walks, set up at boot by `rlRegisterVBlankHook`:

- **Active sprites** ([engine/core/active_sprites.asm](../../engine/core/active_sprites.asm)): scripted, animated sprites. The map's units, cursors and icons are active sprites, each with its own little animation script.
- **The HDMA engine** ([engine/core/hdma.asm](../../engine/core/hdma.asm)): per-frame scanline effects, also scripted, such as the dialogue box folding, gradients and the battle scene's wobbles.

Three engines, same shape: a fixed number of slots, a definition record in ROM, an on-cycle routine and a script. Once you've seen one, you know how to read the other two.

## The data model: what a unit is

The first two big ideas were about *time*. The third is about *memory*, and it's where FE4's scale meets its budget.

A Fire Emblem unit needs a lot of data: stats, growths, class, level, experience, money, HP, status, inventory, skills, holy blood, a lover, love points with every eligible partner, a place on the map. FE4 has up to 72 units at once and only 128 KB of RAM for everything. It can't afford a full record for every bandit.

So a unit is assembled from **parts**, and each kind of unit gets only the parts it needs ([include/Characters.h](../../include/Characters.h), [include/WRAM.h](../../include/WRAM.h)). Every unit has a small header record, `structCharacterDataRAM`, which is a type byte and a list of pointers:

```rust
struct CharacterDataRAM {               // one per unit, 72 in all (aUnitRAMArea)
    kind: u8,
    personal: Ptr<PersonalData>,        // HP now, status, faction, AI, deployment, castle…
    extended: Ptr<ExtendedData>,        // stats, class, level, money, experience
    constant: Ptr<ConstantData>,        // growths, skills, holy blood (gen-2 children)
    enemy_rom: Ptr<CharacterROMEntry>,  // or: read the rest straight from ROM
    inventory: Ptr<InventoryData>,
    lover: Ptr<LoverData>,              // love points with each partner
}
```

The parts live in separate pools, each sized for its kind:

| Pool | Size | Who gets one | Parts |
|---|---|---|---|
| `aStaticUnitRAMArea` | 24 | the playable characters | personal + extended |
| `aDynamicUnitRAMArea` | 17 | generation-2 children, whose growths and blood are *computed* from their parents | personal + extended + constant |
| `aHolyAndEnemyRAMArea` | 63 | bosses, holy-blood enemies and ordinary enemies | personal only; everything else is read from the character's ROM entry |
| `aInventoryRAMArea` | 73 | anyone with items | 7 slots + equipped flags |
| `aLoverRAMArea` | 9 | the eligible women of generation 1 | love points with 15 men |

An ordinary enemy soldier costs its header plus a 15-byte personal part: under forty bytes. A playable character adds a 15-byte block of stats, and a generation-2 child adds its computed growths and blood on top of that. Data that can't change, like an enemy's stats, is never copied out of ROM. This is the *Flyweight* idea, and it explains a lot of the game's code: almost everything that reads a stat goes through a *getter* (`engine/units/unit_info.asm`, `unit_data.asm`) that knows which part to look in for this kind of unit.

**Items are objects too.** In most Fire Emblem games an inventory slot holds an item type and its uses left. In FE4 every weapon is an individual: `aItemRAMData` holds 256 item records, each with its type, durability, owner and **kill count** ([include/Items.h](../../include/Items.h)). An inventory slot holds just a one-byte index into that table. That's how a sword can remember its kills, and how a father's weapon passes intact to his child.

**The map knows units through the deployment table.** `aDeploymentTable` is another structure of arrays, 72 entries per field: state, tile position, pixel position, faction slot, map sprite, and a pointer back to the unit's record ([engine/map/deployment.asm](../../engine/map/deployment.asm)). The unit record says *who* someone is. The deployment entry says *where* they are and what they look like on the map.

**Allegiance is per faction, not per unit.** Units belong to *factions* (Sigurd's army, Verdane, Augustria…), each faction sits in a faction slot, and relations are kept per pair of factions ([engine/units/factions.asm](../../engine/units/factions.asm)). That's how an army can be neutral to you but at war with someone else, and why the castle-and-army structure of FE4's chapters works at all.

## Data-driven content: the game is mostly scripts and tables

Count the bytes and the "engine" is the smaller part of the cartridge. Most of FE4 is **content in custom formats**, interpreted by small engines:

- **Event scripts** ([events/](../../events/), interpreted by [engine/events/event_scripts.asm](../../engine/events/event_scripts.asm)): every chapter's opening, every castle seized, every village visit and recruitment is a script in a bytecode of about a hundred commands. Here's a piece of the prologue, as the source writes it:

  ```
  PLAY_SONG $6C
  MAP_SCROLL [26, 17], 4
  DIALOGUE dialogueChapterPrologueMunnirAttackCastle
  RUN_ASM rlASMC_SetMidirHidden
  MOVE_TEMPORARY_BY_SCRIPT Munnir, [33, 25], 4, MAP_SPRITE_RED, _MunnirMovementScript
  ```

  It's a screenplay. Event *conditions* (who fights whom, who talks to whom, who stands where) decide which scripts fire. When a scene needs something the language can't express, `RUN_ASM` escapes to a hand-written routine (an "ASMC", [engine/events/asmc.asm](../../engine/events/asmc.asm)). This is Nystrom's *Bytecode* pattern, nearly by the book.
- **Dialogue** ([text/dialogue/](../../text/dialogue/)): about 1,700 texts in their own little language of text, pauses, portraits and music cues, drawn a character at a time by [engine/dialogue/](../../engine/dialogue/).
- **The battle scene** has its own script language too ([engine/battle_scene/script.asm](../../engine/battle_scene/script.asm)), with 25 commands for loading backgrounds, showing quotes, shaking the screen and playing the fight. Battle *animations* are yet another layer: frame sequences and movement programs ([data/battle_animation/](../../data/battle_animation/)).
- **The AI** reads per-group scripts that set goals ([engine/ai/scripts.asm](../../engine/ai/scripts.asm)).
- **Tables** carry the rules: classes ([data/class/](../../data/class/)), characters ([data/character/](../../data/character/)), items ([data/item/](../../data/item/)), terrain ([data/terrain/](../../data/terrain/)), chapter setups ([data/chapter/](../../data/chapter/)).

That's why FE4 is moddable even in its original form: to change *what happens*, you mostly edit scripts and tables, not code.

## The life of the game, top down

With those ideas in hand, here's the whole game as one pass from power-on to credits. Each step is a later chapter.

1. **Boot** ([engine/core/boot.asm](../../engine/core/boot.asm)). The reset vector lands in `rlReset`. RAM and video RAM are cleared and the sound driver is uploaded. The three engines (procs, active sprites, HDMA) are registered as VBlank hooks, unit and event RAM are initialised, and the game state is set to the opening logo. The checksums are a curiosity here: the game sums parts of its own code at boot and, if they've been tampered with, quietly sabotages its random number generator ([include/Checksums.h](../../include/Checksums.h)).
2. **Title and save select**: game states and procs drawing menus; saving and loading in [engine/save/](../../engine/save/).
3. **A chapter begins**: the world map and chapter intro ([engine/worldmap/](../../engine/worldmap/)), then the chapter's units are created from ROM tables ([engine/units/unit_creation.asm](../../engine/units/unit_creation.asm)), deployed, and the opening event script plays.
4. **The turn cycle**: player phase, then each other faction's phase. Start-of-turn effects first (healing, status, castles: [engine/units/turn_start.asm](../../engine/units/turn_start.asm)). In the player phase the map waits for input ([engine/map/input.asm](../../engine/map/input.asm)): move a unit, open the map menu, enter a castle ([engine/menus/castle_menu.asm](../../engine/menus/castle_menu.asm)) to shop, repair, or talk. In an AI phase the main loop runs the AI engine, which builds threat and movement maps and picks actions, a few steps per frame ([engine/ai/](../../engine/ai/)).
5. **Combat**: choosing a target ([engine/battle/](../../engine/battle/)), building the *battle rounds* (who strikes, in what order, with which skills), resolving each strike (hit, crit, damage, durability, life-steal, experience), then showing it either as a full battle scene or as a quick map battle ([engine/battle_scene/](../../engine/battle_scene/)). Level-ups roll growths ([engine/units/level_up.asm](../../engine/units/level_up.asm)).
6. **Events fire throughout**: a castle seized, a talk, a death, a turn count. Each runs its script, which can create units, move them, change factions, give items, and play dialogue.
7. **Between generations**: love points accumulate turn by turn ([engine/units/lovers.asm](../../engine/units/lovers.asm)). At the end of chapter 5 the game removes the parents and builds their children ([engine/units/generations.asm](../../engine/units/generations.asm), [engine/units/inheritance.asm](../../engine/units/inheritance.asm)): growths, holy blood, skills, items and money, all derived from who married whom.
8. **The end**: the epilogue chooses each region's and each character's ending from parents, lovers and survivors ([engine/epilogue/](../../engine/epilogue/)), then the rankings score your play ([engine/rankings/](../../engine/rankings/)).

## How to read the source

A few conventions make the files much easier to scan.

**Name prefixes say what a label is:**

| Prefix | Meaning | Example |
|---|---|---|
| `rl` | routine, returns with a long return (callable from any bank) | `rlRunGameStateRoutines` |
| `rs` | routine, short return (callable only from its own bank) | `rsMapVBlank` |
| `proc` | a proc definition | `procMainLoopChangeFade` |
| `a` | a table or block of data, in ROM or RAM | `aGameStateRoutines`, `aDeploymentTable` |
| `w` / `b` / `l` | a RAM variable that is a word / byte / long (3 bytes) | `wGameStateStep`, `bSoundFlags` |
| `g` / `gc` | graphics / compressed graphics | |
| `Unknown` | not yet understood; the hex is its address | `rlUnknown88C7CF` |

**Each routine is in a `.section`**, which lets the assembler place it, and move it when something before it grows. The comment after a label (`; 80/9B01`) is where it sits in the original ROM. That's useful with an emulator, but nothing depends on it.

**Folders follow game systems**: `engine/core/` (the machine and the three engines), `units/`, `items/`, `battle/`, `battle_scene/`, `map/`, `ai/`, `events/`, `dialogue/`, `menus/`, `worldmap/`, `save/`, `sound/`, `epilogue/`, `rankings/`. `engine/unsorted/` holds code not yet assigned to a system. It is shrinking, and the project's Phase 3 ends when it is empty. `include/` holds the shapes: RAM layout (`WRAM.h`), structs, constants and script macros. `data/`, `events/`, `text/`, `gfx/` and `audio/` hold the content.

## What comes next

The chapters after this one go system by system. They come in an order designed so that each one gives you what the next needs, and they're written as each system is fully understood. Alongside them is the reference set in `docs/reference/`: every routine, structure and RAM variable, documented for lookup rather than reading straight through.

If you want to explore now, three files reward a slow read after this chapter:

- [engine/core/proc.asm](../../engine/core/proc.asm): the proc engine is short, and everything in the presentation layer uses it;
- [events/ChapterPrologue/EventPrologueEdainAbduction.asm](../../events/ChapterPrologue/EventPrologueEdainAbduction.asm): an event script you can read almost like a screenplay;
- [include/Characters.h](../../include/Characters.h): the parts a unit is built from.
