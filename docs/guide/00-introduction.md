# Introduction: How a 1996 Game Is Put Together

*Fire Emblem: Genealogy of the Holy War* came out in May 1996 on a 4 MB cartridge. Its machine has a 3.58 MHz CPU, 128 KB of work RAM, 64 KB of video RAM, and no operating system. The game still has to run a war: dozens of units on a map larger than the screen, armies with their own minds, castles changing hands, couples falling in love, children inheriting their parents' blood and weapons a generation later. All of it has to stay smooth at sixty frames a second.

This chapter is the map before the territory. It doesn't explain any one system in depth. It shows the shape of the whole program, the handful of big ideas everything else hangs on, and where those ideas live in the source. The later chapters fill in the details. The chapter has done its job if, at the end, the reader can say "ah, so *that* is what `engine/core/` is for".

None of it requires reading 65816 assembly. Where code helps, it appears as Rust-flavoured pseudocode, with the real names of the routines and variables it translates, so the original is easy to find.

## The machine in one page

A little hardware goes a long way toward explaining why the code looks the way it does.

**The CPU (the 65816)** is a 16-bit descendant of the 6502 in the NES and the Apple II. It has three registers that matter: an accumulator `A` and two index registers, `X` and `Y` (see the sidebar below). It can switch each between 8-bit and 16-bit mode at any moment, which is why the source is full of `.al`/`.as` (16-bit/8-bit accumulator) and `.xl`/`.xs` markers. Addresses are 24 bits wide: a *bank* byte and a 16-bit offset, written `$80/9B01` in this project ("bank `$80`, offset `$9B01`"). The cartridge is mapped into banks `$80`-`$FF`. Work RAM is banks `$7E`-`$7F`, and its first 8 KB is also visible in every bank, which makes it the cheapest memory to reach.

**The PPU (the picture processor)** draws the screen from video RAM: up to four *background layers* made of 8×8 tiles, plus up to 128 *sprites*. It isn't programmable the way a modern GPU is. It draws whatever video RAM and its registers describe, and nothing else. The CPU cannot touch video RAM while the screen is being drawn. It gets a window of about 2,300 microseconds per frame, the **vertical blank** (VBlank), after the last line is drawn and before the next frame starts. Everything that changes on screen has to be squeezed through that window, usually by **DMA**, a hardware copier much faster than the CPU. **HDMA** is DMA that fires once per scanline, which lets the game change a register partway down the screen. That's how it gets wavy water, gradients and the dialogue box folding open.

**The sound chip (the SPC700)** is a separate computer with its own CPU and 64 KB of RAM. The game uploads a sound driver and samples to it, then sends it short commands through four one-byte ports. Sound gets its own chapter; for now it is a peripheral that receives requests by mail.

That's the whole budget: a slow CPU, a small RAM, a short VBlank, and a pipe to a second computer. Nearly every design decision below follows from it.

> **Sidebar: registers, and why they shape the data**
>
> In a modern language a variable is a name, and the compiler decides where it lives. On the 65816 the programmer decides. Almost all work happens in three *registers*, tiny storage cells inside the CPU itself. `A` (the accumulator) is where arithmetic happens: load a value into `A`, add to it, store it back to memory. `X` and `Y` are the *index registers*, and their main job is to say *which one*. The instruction `lda aBody0,x` means "load `A` from the address `aBody0` plus whatever is in `X`." It's the machine's version of `body0[x]`.
>
> That is the whole of the CPU's help with arrays: one base address, written into the instruction, plus one index register. There is no instruction for "the field `body3` of element `i` of an array of structs". In Rust, `procs[i].body3` compiles to *base + i × size_of::<Proc>() + offset_of!(body3)*, and a modern CPU does that multiply for free. **The 65816 has no multiply instruction at all.** A multiply by an awkward size like 14 means a sequence of shifts and adds, or a trip to a hardware multiplier outside the CPU that takes several cycles to answer.
>
> So 1990s SNES code arranges its data to avoid the multiply. The trick appears below as "structure of arrays", and it turns up all over the game.

## Two threads, one CPU

Splitting a game's work by deadline is a familiar idea. Some work must finish every frame; some can take as long as it needs and run in the background. The textbook game loop puts the per-frame work in a loop and waits for the display between iterations:

```rust
loop {
    process_input();
    update();
    render();
    wait_for_vblank();
}
```

On the SNES, the CPU has an interrupt, the **NMI**, that fires at the start of every VBlank. Games of the era split into two broad camps over how much to do inside it. Some keep the interrupt short (copy to video RAM, set registers, return) and run the game logic in the main loop, as above. Others run the *whole frame* inside the interrupt, logic included, and leave the main loop for background work. FE4 is in the second camp, and it makes deliberate use of the spare main loop.

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
    run_game_state_routines();          // rlRunGameStateRoutines: which screen is up?
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

Anything that must happen *exactly once per frame* goes in the interrupt: drawing, input, animation, the menus. Anything *heavy and divisible* goes in the main loop, which acts as a background thread: decompressing graphics, and above all the **AI**. While an enemy army "thinks" during its phase, it uses the leftover time in each frame, a little at a time. The animation never stutters, because the interrupt always gets the CPU first. A modern engine would put pathfinding on a worker thread or time-slice it across frames; FE4 gets the same effect with a single CPU and an interrupt.

Each screen installs its own pair. The opening logo, the world map, the battle scene and the map each set `wVBlankPointer` and `wMainLoopPointer` to their own routines when they start. That's how the game changes the shape of its frame.

This is Nystrom's *Game Loop* pattern, fitted to the hardware: the display drives the frame, and the program fits its work around it.

## Game states: which screen is up?

Inside the interrupt, `rlRunGameStateRoutines` decides which screen's logic runs ([engine/core/game_states.asm](../../engine/core/game_states.asm), [include/GameStates.h](../../include/GameStates.h)). It is a finite state machine, with an unusual twist: there are *two* current states at once.

There is a table of 56 routine pointers, `aGameStateRoutines`, and two variables index it, `wGameStateRoutine1` and `wGameStateRoutine2`. Every frame, both routines run:

```rust
fn rl_run_game_state_routines() {
    AGAME_STATE_ROUTINES[wGameStateRoutine1]();   // the screen's logic: set up, then step
    AGAME_STATE_ROUTINES[wGameStateRoutine2]();   // the screen's every-frame upkeep
}
```

The table is laid out in groups of three entries per screen: title menu, castle, world map, chapter map, battle scene, unit window, item window, options, epilogue and so on. The chapter map's three are entries `$10`, `$11` and `$12`. Each group holds:

1. an **upkeep** routine, run every frame for as long as the screen is up (on the map: keep the map sprites animated and the camera in step);
2. a **setup** routine, run once when the screen opens; it loads graphics, builds the screen and, as its last act, adds one to `wGameStateRoutine1`;
3. a **step** routine, which therefore runs from the following frame on; it handles input and does the screen's work.

Opening the map means pointing `wGameStateRoutine2` at entry `$10` and `wGameStateRoutine1` at entry `$11`. One frame later, slot 1 has moved itself on to `$12` and stays there. Other code agrees with this reading: the AI engine only runs while `wGameStateRoutine1` is `$12`, the map's step routine. Inside a step routine, a third variable, `wGameStateStep`, says which phase of that screen's work is current.

This is a *State* machine in its most stripped-down form: no objects and no interface, just an index into a table of function pointers. Changing screens means writing two numbers. The idiom, *a table of routines indexed by a number*, is everywhere in the game: event commands, AI cycle steps, battle scene commands, target filters. It is how 1990s assembly does polymorphism.

**What about the nested menus?** A Fire Emblem turn is a chain of choices: unit, then destination, then action, then item, then confirm, with a way back at every step. A stack is the natural way to build that. The game-state table isn't it: it holds one screen at a time, with no history. The map's menus do keep a stack of their own ([engine/menus/map_menu.asm](../../engine/menus/map_menu.asm)). `rlPushMenuOptionList` allocates a block of RAM for a new list of menu options, stores the current top of the stack (`lMenuOptionListTop`) inside it and becomes the new top; `rlPopMenuOptionList` frees the top block and restores the one it saved. Whether this is the whole story of how a turn's chain of choices backs out step by step is still to be worked out with the map menu code.

The routines are named after their role, `rl<Screen>Upkeep`, `rl<Screen>Setup` and `rl<Screen>Step` (the chapter map's are `rlMapUpkeep`, `rlMapSetup`, `rlMapStep`), and [include/GameStates.h](../../include/GameStates.h) gives each entry a constant such as `GAMESTATE_MAP_STEP`. A few screens break the pattern: the battle scene and the map battle have only a setup and a step, and the screens built earlier in the project (the unit, item, skill and data windows) keep names that say what their routines do.

## Procs: sixteen tiny threads

A screen's step routine could, in principle, do everything itself. In practice a screen has many things going on at once: a fade in progress, a window sliding in, a cursor blinking, a map scrolling to a castle while a dialogue box unfolds. Writing all of that as one routine with a pile of flags would be miserable. FE4 instead has a small cooperative multitasking system. The code calls its tasks **procs** ([engine/core/proc.asm](../../engine/core/proc.asm), [include/Procs.h](../../include/Procs.h)). The name, and much of the design, carried on through Intelligent Systems' later Fire Emblem games.

A proc is defined by a little record in ROM: a two-letter name, an *init* routine, an *on-cycle* routine, and a *script*:

```rust
struct ProcInfo {            // structProcInfo
    name: [u8; 2],           // e.g. "FI" for a fade-in; useful only to a human with a debugger
    init: fn(slot),          // runs once when the proc is created
    on_cycle: fn(slot),      // runs every frame
    code: &[ProcCommand],    // a tiny script: wait N frames, call this, jump there, end
}
```

Up to sixteen procs can be alive at once. Every frame, `rlProcEngineMainProcLoop` walks the slots and gives each live proc its turn: run its on-cycle routine, then step its script until it yields (`PROC_YIELD n` waits n frames), halts or ends. A fade, for instance, is a proc whose on-cycle routine nudges the screen brightness one step each frame and whose script ends when it reaches the target. Whoever started the fade doesn't wait for it; it goes on with its own work, and can ask later whether the proc has ended (`rlProcEngineCheckProcEnded`).

There are about 160 proc definitions in the game, and they're the glue of the presentation layer: the map's scrolling, every screen transition, the dialogue scenes, the event scripts themselves (an event runs *inside* a proc), the castle name pop-up, and so on.

Procs can look like an event system, but nothing is broadcast and nothing subscribes. Two of Nystrom's patterns describe them better:

- **Update Method.** A game has many things that each need to do a little work every frame. Rather than one routine that knows about all of them, each thing gets its own `update()`, and the engine calls every live one once per frame. The proc's on-cycle routine is exactly that.
- **Bytecode.** Behaviour is written as data: a list of small instructions, run by an interpreter inside the program, instead of compiled code. Bytecode is quick to write and safe to change, and the interpreter decides what the language can and cannot do. A proc's script is a tiny bytecode with a dozen instructions: wait, call, jump, change the on-cycle routine, end.

A proc is an Update Method whose behaviour can also follow a script. The on-cycle routine does the continuous work, and the script sequences the steps.

### How the memory is laid out, and why

The way the proc engine stores its procs is worth stopping on, because the rest of the game does it too. The obvious design, given sixteen procs that each have the same fields, is an array of sixteen proc structs: that's what a struct is for, and it keeps each proc's data together. Instead `aProcSystem` ([include/WRAM.h](../../include/WRAM.h)) is a set of arrays, one per field, each sixteen entries long: `aHeaderTypeOffset[16]`, `aBody0[16]`, `aBody1[16]`, … `aBody7[16]`.

```rust
// The obvious layout:                  // FE4's layout:
struct Proc { header, body0, body1 }    struct ProcSystem {
let procs: [Proc; 16];                      header: [u16; 16],
// procs[i].body3                           body0:  [u16; 16],
                                            body1:  [u16; 16], /* … */
                                        }
                                        // system.body3[i]
```

Today this is called *structure of arrays*, and associated with cache-friendly, data-oriented engines. On the 65816 the reason is the one in the sidebar. With the proc's slot number (times two, since each field is a two-byte word) in `X`, the instructions `lda aBody0,x`, `lda aBody3,x` and `sta aBody5,x` each reach a different field of the same proc in one instruction, with no multiply anywhere. Every field is an array the CPU can index directly. The deployment table, the active sprites and the AI's unit lists are built the same way.

In Rust, either layout reads naturally: `procs[i].body3` or `system.body3[i]`, and the compiler handles the arithmetic. The layout only becomes a design decision when the programmer *is* the compiler.

### Its siblings

Two more engines run beside the procs as **VBlank hooks**. These are entries in `aTaskTable`, a short list of per-frame engines that `rlRunVBlankHooks` walks, set up at boot by `rlRegisterVBlankHook`:

- **Active sprites** ([engine/core/active_sprites.asm](../../engine/core/active_sprites.asm)): scripted, animated sprites. The map's units, cursors and icons are active sprites, each with its own little animation script.
- **The HDMA engine** ([engine/core/hdma.asm](../../engine/core/hdma.asm)): per-frame scanline effects, also scripted, such as the dialogue box folding, gradients and the battle scene's wobbles.

Three engines, same shape: a fixed number of slots, a definition record in ROM, an on-cycle routine and a script. Learning to read one is learning to read all three.

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

An ordinary enemy soldier costs its header plus a 15-byte personal part: under forty bytes. A playable character adds a 15-byte block of stats, and a generation-2 child adds its computed growths and blood on top of that. Data that can't change, like an enemy's stats, is never copied out of ROM. This is the *Flyweight* idea: share what is common, store only what differs. It explains a lot of the game's code, because almost everything that reads a stat goes through a *getter* (`engine/units/unit_info.asm`, `unit_data.asm`) that knows which part to look in for this kind of unit. The separate pools also mean each kind of unit has a fixed budget, set when the game was built, rather than all kinds competing for one heap.

**Items are objects too.** In most Fire Emblem games an inventory slot holds an item type and its uses left. In FE4 every weapon is an individual: `aItemRAMData` holds 256 item records, each with its type, durability, owner and **kill count** ([include/Items.h](../../include/Items.h)). An inventory slot holds just a one-byte index into that table. That's how a sword can remember its kills, and how a father's weapon passes intact to his child.

**The map knows units through the deployment table.** `aDeploymentTable` is another structure of arrays, 72 entries per field: state, tile position, pixel position, faction slot, map sprite, and a pointer back to the unit's record ([engine/map/deployment.asm](../../engine/map/deployment.asm)). The unit record says *who* someone is. The deployment entry says *where* they are and what they look like on the map. Questions like "which foes can reach this tile?" are answered from whole-map grids built from this table, such as the AI's movement, range and threat maps ([engine/ai/maps.asm](../../engine/ai/maps.asm)). Passing units to functions doesn't come into it: the data is global, and a query is a walk over a grid or a table.

**Allegiance is per faction, not per unit.** Units belong to *factions* (Sigurd's army, Verdane, Augustria…), each faction sits in a faction slot, and relations are kept per pair of factions ([engine/units/factions.asm](../../engine/units/factions.asm)). That's how an army can be neutral to the player but at war with someone else, and why the castle-and-army structure of FE4's chapters works at all.

### What the structures cost the design

Fixed pools are cheap and predictable, and every one of them is also a rule the designers had to live with. Several of FE4's familiar limits can be read straight off the structures:

- **72 units on the map at once** (the deployment table), of which **63 can be enemies, bosses and other non-player units**. A chapter that wants a fresh army has to make room by deleting the old one, which is probably part of why FE4's armies arrive and leave as whole groups through events.
- **24 player characters per generation**, and **17 child slots** in the second.
- **256 items in the whole game world.** Every weapon in every unit's hands, the player's and the enemy's alike, is a record in the same table. A sword created is a record used up.
- **7 items per unit**, **9 women with love points** in generation 1, each tracking **15 possible partners**. The love system is literally a 9 × 15 grid.
- **Stats are bytes; money is a word.** Each stat fits in 0-255, and a unit's gold in 0-65,535, before any cap the rules impose.
- **16 procs at once.** A scene that wants more simultaneous effects must wait for some to end.

Each limit fits the game as it shipped. They matter to anyone modding it, though. The chapters on units, items and events show where each limit is enforced, and what would have to change to lift it.

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

  It's a screenplay. Event *conditions* (who fights whom, who talks to whom, who stands where) decide which scripts fire. When a scene needs something the language can't express, `RUN_ASM` escapes to a hand-written routine (an "ASMC", [engine/events/asmc.asm](../../engine/events/asmc.asm)). This is the *Bytecode* pattern nearly by the book, including its escape hatch. The language stays small and each command does one concrete thing; anything unusual goes in code, where it can be as odd as it needs to be, rather than stretching the language to fit.
- **Dialogue** ([text/dialogue/](../../text/dialogue/)): about 1,700 texts in their own little language of text, pauses, portraits and music cues, drawn a character at a time by [engine/dialogue/](../../engine/dialogue/).
- **The battle scene** has its own script language too ([engine/battle_scene/script.asm](../../engine/battle_scene/script.asm)), with 25 commands for loading backgrounds, showing quotes, shaking the screen and playing the fight. Battle *animations* are yet another layer: frame sequences and movement programs ([data/battle_animation/](../../data/battle_animation/)).
- **The AI** reads one script per *group* of enemy units ([engine/ai/scripts.asm](../../engine/ai/scripts.asm), [include/AI.h](../../include/AI.h)). The scripts set goals, not moves: raid the villages, hold formation, target this unit, wait until turn N or until an event flag is set, charge once the leader's HP drops below a threshold. The per-unit tactics (whom to hit, from which tile) are computed by general code. The gain is authored pacing: armies sit in their castles and march when the story says so, which is what makes FE4's huge maps feel like a campaign. The cost is predictability. A group only ever does what its script names, players learn the triggers, and any behaviour outside the command set needs new code.
- **Tables** carry the rules: classes ([data/class/](../../data/class/)), characters ([data/character/](../../data/character/)), items ([data/item/](../../data/item/)), terrain ([data/terrain/](../../data/terrain/)), chapter setups ([data/chapter/](../../data/chapter/)).

That's why FE4 is moddable even in its original form: changing *what happens* mostly means editing scripts and tables, not code.

## The life of the game, top down

With those ideas in hand, here's the whole game as one pass from power-on to credits. Each step is a later chapter.

1. **Boot** ([engine/core/boot.asm](../../engine/core/boot.asm)). The reset vector lands in `rlReset`. RAM and video RAM are cleared and the sound driver is uploaded. The three engines (procs, active sprites, HDMA) are registered as VBlank hooks, unit and event RAM are initialised, and the game state is set to the opening logo. The checksums are a curiosity here: the game sums parts of its own code at boot and, if they've been tampered with, quietly sabotages its random number generator ([include/Checksums.h](../../include/Checksums.h)).
2. **Title and save select**: game states and procs drawing menus; saving and loading in [engine/save/](../../engine/save/).
3. **A chapter begins**: the world map and chapter intro ([engine/worldmap/](../../engine/worldmap/)), then the chapter's units are created from ROM tables ([engine/units/unit_creation.asm](../../engine/units/unit_creation.asm)), deployed, and the opening event script plays.
4. **The turn cycle**: player phase, then each other faction's phase. Start-of-turn effects come first (healing, status, castles: [engine/units/turn_start.asm](../../engine/units/turn_start.asm)). In the player phase the map waits for input ([engine/map/input.asm](../../engine/map/input.asm)): move a unit, open the map menu, enter a castle ([engine/castle/](../../engine/castle/), [castle.md](../reference/castle.md)) to send units out, shop, repair, store items or talk. In an AI phase the main loop runs the AI engine, which builds threat and movement maps and picks actions, a few steps per frame ([engine/ai/](../../engine/ai/)).
5. **Combat**: choosing a target ([engine/battle/](../../engine/battle/)), building the *battle rounds* (who strikes, in what order, with which skills), resolving each strike (hit, crit, damage, durability, life-steal, experience), then showing it either as a full battle scene or as a quick map battle ([engine/battle_scene/](../../engine/battle_scene/)). Level-ups roll growths ([engine/units/level_up.asm](../../engine/units/level_up.asm)).
6. **Events fire throughout**: a castle seized, a talk, a death, a turn count. Each runs its script, which can create units, move them, change factions, give items, and play dialogue.
7. **Between generations**: love points accumulate turn by turn ([engine/units/lovers.asm](../../engine/units/lovers.asm)). At the end of chapter 5 the game removes the parents and builds their children ([engine/units/generations.asm](../../engine/units/generations.asm), [engine/units/inheritance.asm](../../engine/units/inheritance.asm)): growths, holy blood, skills, items and money, all derived from who married whom.
8. **The end**: the epilogue chooses each region's and each character's ending from parents, lovers and survivors ([engine/epilogue/](../../engine/epilogue/)), then the rankings score the play ([engine/rankings/](../../engine/rankings/)).

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

The chapters after this one go system by system, in an order designed so that each provides what the next needs, and each is written once its system is fully understood. Alongside them is the reference set in `docs/reference/`: every routine, structure and RAM variable, documented for lookup rather than for reading straight through.

Three files reward a slow read after this chapter:

- [engine/core/proc.asm](../../engine/core/proc.asm): the proc engine is short, and everything in the presentation layer uses it;
- [events/ChapterPrologue/EventPrologueEdainAbduction.asm](../../events/ChapterPrologue/EventPrologueEdainAbduction.asm): an event script that reads almost like a screenplay;
- [include/Characters.h](../../include/Characters.h): the parts a unit is built from.
