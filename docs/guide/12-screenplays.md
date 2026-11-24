# Chapter 12: Screenplays

Every scene in the game is an **event script**: a sequence of commands in ROM, run by a small interpreter in the event engine. A command does one concrete thing. It plays a song, opens a conversation, scrolls the camera, walks a unit across the map, waits a number of frames, or sets a flag. The language has 93 commands (opcodes `$00` to `$5F`, with three gaps), and the game's scripts use 56 of them. One script runs at a time.

The interpreter runs once per frame. Some commands finish at once, and the interpreter moves on to the next. Others start a proc ([Chapter 28](OUTLINE.md)) that takes many frames: a conversation, a fade, a pause, a scroll. The script doesn't stop at such a command. It runs on to the next `YIELD`, which ends its work for the frame, and on every later frame the interpreter checks whether the procs the script started have ended before it reads another command. A scene is written as a list of things to start and places to wait for them.

Scripts also have two ways out of the language. `RUN_EVENT_CONDITION` runs one command of the condition-list language ([Chapter 11](11-the-game-is-watching.md)) inline, and every change to the game's state (deploying an army, giving an item, raising a stat, removing a unit) goes through it. `RUN_ASM` calls a hand-written routine. This is the Bytecode pattern with its usual escape hatch, and a second hatch into a sibling language. This chapter covers how a script starts and ends, the interpreter and its three ways of waiting, the commands, branches, moving units, the two escapes, scripts outside the chapters, and the costs.

## Starting and ending a script

Scripts are numbered. `aEventPointers` ([data/chapter/EventPointers.csv](../../data/chapter/EventPointers.csv)) holds a three-byte pointer for each of 562 event IDs, `$000` to `$231`; 531 of the pointers are distinct. The most shared script, behind nine IDs, is nothing but `END_EVENT`. A condition list's `EVENT` command starts a script by its ID, and so does the map step when the game is lost (`aGameOverEventIDs`).

```rust
fn start_chapter_event_by_id(id: u16) -> bool {       // rlStartChapterEventByID
    if wEventEngineFlags != 0 || id >= 0x232 {
        return false;                                  // a script is running, or no such ID
    }
    wEventEngineState = 0;
    start_event_script(aEventPointers[id]);            // rlStartEventScript
    true
}

fn start_event_script(script: Ptr) {                   // rlStartEventScript
    lActiveEventPointer = script;
    wActiveEventOffset = 0;
    wEventEngineFlags = 0b1001;                        // bit 0 running; bit 3 started, not yet begun
}
```

Starting a script only records it. The work happens in the event engine, one of the five per-frame engines registered at boot ([Chapter 26](OUTLINE.md)). Each frame, after the procs have run, `rlEventEngineMainLoop` checks bit 0 of `wEventEngineFlags` and, if it is set, calls the routine for `wEventEngineState`:

| State | Routine | Does |
|---|---|---|
| 0 | `rlEventEngineBeginScript` | moves to state 1; clears the event's menu windows; records the skip point; frees leftover event procs, the moving map sprites, and every active sprite; clears bit 3; runs the first commands at once |
| 1 | `rlRunEventCommand` | runs commands until the script stops for the frame |
| 2 | `rlResetEventAndSpriteState` | zeroes `wEventEngineFlags` and the state, frees the event procs, clears every active sprite, stops the map sprites' sounds |

`END_EVENT` (the word `$FFFF`) moves the engine to state 2, and the next frame ends the script. With `wEventEngineFlags` back at 0, the map step and the map routines that wait for scripts carry on ([Chapter 8](08-the-turn.md)), and the next `EVENT` can start a new one.

## The interpreter

A script is a byte stream. Each command is an opcode byte and its parameters, and `aEventCommandPointers` holds one handler for each opcode. A handler reads its own parameters, advances the read position past them, and returns with the carry flag clear to go on or set to stop for this frame. Three values never reach a handler:

| Bytes | Macro | Meaning |
|---|---|---|
| `$FD` | `YIELD` | stop for this frame |
| `$FEFE` | `SKIP_POINT` | step over (see [Skip points](#skip-points)) |
| `$FFFF` | `END_EVENT` | the script is over |

```rust
fn run_event_commands() {                              // rlRunEventCommand
    if !event_procs_done() { return; }                 // rsEventEngineCheckProcsDone
    let mut y = wActiveEventOffset;
    loop {
        if read_word(y) == 0xFEFE { y += 2; }          // SKIP_POINT
        if read_word(y) == 0xFFFF {                    // END_EVENT
            wEventEngineState = 2;
            return;
        }
        let op = read_byte(y);
        y += 1;
        if op == 0xFD { break; }                       // YIELD
        wActiveEventOffset = y;                        // the parameters, for handlers and procs
        let (next, stop) = aEventCommandPointers[op](y);
        y = next;
        if stop { break; }
    }
    wActiveEventOffset = y;
}
```

Nothing limits how many commands run in one frame. A script with no `YIELD` and nothing to wait for would run to its end in a single frame, and in practice the scripts are full of yields: 3,354 of them, against about 7,100 other commands (these counts include `END_EVENT`).

## Three ways to wait

### Event procs

Most commands that take time create a proc through `rlEventEngineCreateProc`, which creates it like any other proc and also records its definition in `wEventProcBanks` and `wEventProcOffsets` at the index of the slot it landed in. These tables have one entry for each of the proc engine's 16 slots. The routine also sets bit 2 of `wEventEngineFlags` to say the script has procs to wait for.

The handler returns with the carry clear, so the script goes on. At the start of the next frame, and every frame after, the interpreter asks whether its procs are done:

```rust
fn event_procs_done() -> bool {                        // rsEventEngineCheckProcsDone
    if wEventEngineFlags & 0x0004 == 0 { return true; }   // nothing started
    let mut done = true;                               // rsEventEnginePollBlockingProcs
    for slot in 0..16 {
        let Some(entry) = wEventProcs[slot] else { continue };
        if entry.non_blocking { continue; }
        if aProcSystem.definition(slot) == entry.definition {
            done = false;                              // still running
        } else {
            wEventProcs[slot] = None;                  // the proc ended
        }
    }
    if done { wEventEngineFlags &= !0x0006; }
    done
}
```

A proc counts as ended when its slot no longer holds the same definition, either because it freed itself or because something else took the slot. A proc can be marked non-blocking (bit `$0200` of its bank entry); the script then doesn't wait for it. Only the attract mode's opening does that, so that its script can carry on while a conversation is still on screen (`rlASMCContinueDuringDialogue`).

Most of these procs read their parameters straight from the script. A proc's init routine runs as soon as it is created, while `wActiveEventOffset` still points at the command's parameters, and reads them from there. `PAUSE`'s handler does no more than create `procEventPause` and step over the two-byte timer:

```rust
fn proc_event_pause_init(proc) {                       // rlProcEventPauseInit
    proc.body0 = max(read_word(wActiveEventOffset), 2);
}

fn proc_event_pause_cycle(proc) {                      // rlProcEventPauseCycle
    proc.body0 -= 1;
    if proc.body0 == 0 { event_engine_free_proc(proc); }
}
```

`DIALOGUE`, `DIALOGUE_WITH_BG`, `CASTLE_NAME`, and the timed fades work the same way. The scroll commands read their own parameters and build a scroll script before creating the scroll proc.

### Running alongside

Because a proc-starting command doesn't stop the script, everything between it and the next `YIELD` runs in the same frame, while the proc is just beginning. Writers use this to start several things at once and wait for all of them, or to change something the proc has just set up. Chapter 1's Genoa scene opens a conversation over a background picture and then sets the camera:

```
DIALOGUE_WITH_BG dialogueChapter01GenoaSeizedAyraAlive, DIALOGUE_BG_HALLWAY, 3, 2
SET_CAMERA_POSITION [48, 34]
YIELD
```

`DIALOGUE_WITH_BG` leaves the map for a full-screen conversation scene. Its proc's init routine saves the map's camera position (`wMapXOffset`, `wMapYOffset`), from which the map is rebuilt when the scene ends, and starts the fade. `SET_CAMERA_POSITION`, run in the same frame, overwrites that saved position, so the map comes back with the camera at Genoa. The chapter's opening starts a castle name banner, releases the moving units, and opens a conversation before one `YIELD`, and the script waits until both the banner and the conversation are gone.

### Commands that retry

A few commands poll instead of creating a proc. When the thing they wait for isn't ready, they step the read position back to their own opcode and return with the carry set, so the interpreter stops and runs the same command again next frame. `WAIT_UNIT_SPRITE_DECOMPRESSED` works this way, and so does every command that puts a unit sprite in motion when the sprite system is busy (see [Units on the move](#units-on-the-move)).

`PLAY_SONG` is the one command that stops the frame itself. It sets the song and returns with the carry set, and the proc it creates keeps the script waiting while a map battle is running. `RESTORE_PHASE_MUSIC` waits for the map battle in the same way.

## The commands

The commands fall into a few families. The counts are uses across all of the game's scripts:

| Family | Commands (uses) | Waits |
|---|---|---|
| Conversation | `DIALOGUE` (293), `DIALOGUE_WITH_BG` (206), `CASTLE_NAME` (55) | proc until it closes |
| Sound | `PLAY_SFX_WORD` (674), `PLAY_SONG` (392), `RESTORE_PHASE_MUSIC` (298), `PLAY_SFX_BYTE` (6) | the two music commands, during a map battle |
| Time and screen | `PAUSE` (1,153), `FADE_OUT_BY_TIMER` (97), `FADE_IN_BY_TIMER` (28), `RELOAD_MAP_SCREEN` (38) | proc |
| Camera and cursor | `MAP_SCROLL` (149), `MAP_SCROLL_TO_EVENT_UNIT_SLOT_1` (80), `SET_CAMERA_POSITION` (79), `SET_CURSOR_TO_EVENT_UNIT_SLOT_1` (19), `SCRIPTED_MAP_SCROLL` (15) | the scrolls, proc |
| Units | `WAIT_UNIT_SPRITE_DECOMPRESSED` (391), `WAIT_UNTIL_MAP_SPRITES_HALTING` (251), `LOAD_UNIT_BY_GROUP` (196), `MOVE_TEMPORARY_BY_SCRIPT` (104), `LOAD_UNIT_BY_GROUP_SILENT` (46), `LOAD_UNIT_DIRECT` (45), `CONTINUE_FORM_MAP_SPRITE_HALT` (34), `MOVE_TEMPORARY_TO_COORDS_CLASS` (15), `MOVE_TEMPORARY_TO_COORDS` (9), `FACTION_UNIT_DEATH` (8), `MOVE_TEMPORARY_TO_COORDS_FOLLOW` (2), `BERSERK_CAST` (1) | retry, or proc |
| Event unit slots | `FILL_EVENT_UNIT_SLOT` (208), `FILL_EVENT_UNIT_SLOT_BY_COORDS` (2) | — |
| Flags and branches | `JUMP` (96), `JUMP_TRUE` (80), `TEST_FLAG_IN_CHAPTER_SET` (61), `SET_FLAG_IF_IN_CHAPTER` (52), `TEST_PERMANENT_FLAG_SET` (49), `JUMP_FALSE` (47), `UNSET_FLAG_IF_IN_CHAPTER` (18), `JUMP_RELATIVE_FALSE` (1) | — |
| Escapes | `RUN_EVENT_CONDITION` (780), `RUN_ASM` (310), `RUN_EVENT_CONDITION_AND_WAIT` (2) | as the command or routine decides |
| World map | `WM_DIALOGUE` (50), `WM_CLEAR_DIALOGUE` (41), `WM_SCROLL` (40), `WM_FADE_IN` (13), `WM_FADE_OUT` (12), `WM_FADE_OUT_PORTRAIT` (10), and six more used once to three times | proc |
| Attract mode | `DEMO_ALLOW_SKIP` (1), `OPEN_TITLE_SCREEN` (1) | — |

Sound commands are the most common. The pair `PLAY_SFX_WORD $00E0` and `PAUSE 35` appears 572 times; `$E0` is a command to the sound driver that the game also sends before the phase music changes ([Chapter 31](OUTLINE.md)).

`RELOAD_MAP_SCREEN` fades the screen out and rebuilds the map display through the main-loop routine that the full-screen windows and the battle scene use to return to the map (`rsReturnToMapMainLoop`). Its parameter holds the fade time in the low six bits and two mode bits. With bit 7 set the script carries on once the map is rebuilt and still dark, ready for a `FADE_IN_BY_TIMER`; otherwise it waits until the map has faded in. Every chapter's opening script starts with it: after registering map sprites (in most chapters) and setting the camera position, it rebuilds the map with `RELOAD_MAP_SCREEN $80` and fades in.

The other 37 commands appear in no script. They include palette changes and cycles, HDMA and sprite creation, a raw word store, a button wait with and without a timeout, two menu commands, a forced lover conversation, and several commands that do nothing. One of them, `EVENT_0A`, appears in a single debug script.

## Branches

A script has one condition register, `wEventEngineTruthFlag`. The two test commands set it from a flag: `TEST_FLAG_IN_CHAPTER_SET` from a chapter flag and `TEST_PERMANENT_FLAG_SET` from a permanent flag ([Chapter 11](11-the-game-is-watching.md)). A few ASMCs set it too. `JUMP_TRUE` and `JUMP_FALSE` read it, and `JUMP` jumps unconditionally.

A jump's target is a 16-bit address in the script's own bank. The handler turns it into an offset by subtracting the address of the script's start, so a script can only jump within its bank. `TEST_FLAG_IN_CHAPTER_SET` names a chapter as well as a flag; if the chapter isn't the current one, it leaves the truth flag as the last test left it.

Chapter 1's Genoa scene, started when Sigurd takes the castle, branches on whether Ayra died before it was taken:

```
PLAY_SFX_WORD $00E0
PAUSE 35
YIELD

TEST_FLAG_IN_CHAPTER_SET Chapter01, FlagChapter01_AyraDied
JUMP_TRUE _AyraDied

PLAY_SONG SONG_CASTLE_SEIZED
YIELD
DIALOGUE_WITH_BG dialogueChapter01GenoaSeizedAyraAlive, DIALOGUE_BG_HALLWAY, 3, 2
SET_CAMERA_POSITION [48, 34]
YIELD
JUMP _Continue

_AyraDied
PLAY_SONG $77
YIELD
DIALOGUE_WITH_BG dialogueChapter01GenoaSeizedAyraDead, DIALOGUE_BG_HALLWAY, 3, 2
SET_CAMERA_POSITION [48, 34]
YIELD

_Continue
UNSET_FLAG_IF_IN_CHAPTER Chapter01, FlagChapter01_SigurdAyraTalk
SET_FLAG_IF_IN_CHAPTER Chapter01, FlagChapter01_GenoaOrMarphaSeized
FILL_EVENT_UNIT_SLOT Sigurd, EventUnitSlot1
SET_CURSOR_TO_EVENT_UNIT_SLOT_1
RUN_EVENT_CONDITION
  SET_TALK_TARGET_IF_UNMARRIED Dew, Edain
PLAY_SFX_WORD $00E0
PAUSE 35
YIELD
RESTORE_PHASE_MUSIC
YIELD
END_EVENT
```

The flag `FlagChapter01_AyraDied` was set by an action condition with an empty body when Ayra fell. After the conversation the script clears the Sigurd–Ayra talk flag, which makes that talk available ([Chapter 11](11-the-game-is-watching.md)), sets the flag the chapter's later conditions test, puts the map cursor on Sigurd, makes Dew a talk target for Edain, and brings back the phase music. The language has no subroutine call: two branches that end alike repeat their common commands or jump to a shared label, as these do.

## Units on the move

### Moving map sprites

A unit walking during a scene is a **moving map sprite**: an active sprite that steps along a short **movement script**. The moving sprite system (`aMovingMapSprites`) has four slots, so at most four units walk at once. A movement script is a list of byte commands:

| Command | Effect |
|---|---|
| `MAP_LEFT`, `MAP_UP_RIGHT`, … | one tile in one of eight directions |
| `MAP_LEFT_MULTIPLE n`, … | `n` tiles in a direction |
| `MAP_PAUSE t` | stand still for `t` frames |
| `MAP_SET_SPEED s` | change speed |
| `MAP_FACE_LEFT`, … | turn without moving |
| `MAP_HALT` | stop until the event script releases the sprite |
| `MAP_END` | the walk is over |

The camera uses the same direction commands. `SCRIPTED_MAP_SCROLL` follows a hand-written scroll script, and `MAP_SCROLL` builds one from the camera's position and a target tile (`rlCreateMapScrollScriptFromCoordinates`) and hands it to the same scroll proc.

### Three kinds of unit command

The unit commands differ in where the movement script comes from and whether a real unit is involved:

- `MOVE_TEMPORARY_BY_SCRIPT` draws a character's sprite at a tile and runs a hand-written movement script. Nothing in the unit pools changes.
- `MOVE_TEMPORARY_TO_COORDS` draws a sprite and walks it to a destination along a route the game plans. It also changes nothing; if the character is a unit on the map, the script deals with that unit separately.
- `LOAD_UNIT_BY_GROUP` and `LOAD_UNIT_DIRECT` load a real unit into its army, hidden, and walk its sprite from a starting tile; the unit appears when the walk ends. A group unit walks to its own tile in the unit group; a direct unit takes its character, army slot, destination, AI setting, and leader bit from the command. `LOAD_UNIT_BY_GROUP_SILENT` loads a group unit and shows it at once, with no walk.

A unit command first checks that no decompression is queued, that the route planner is idle, and that one of the four slots is free. If not, it steps back and retries next frame.

A planned route takes longer than the frame's interrupt time allows. The command fills in the request and sets `aMovingMapSprites.wState` to 1, and the map's main loop, which runs in the time left over between frames ([Chapter 26](OUTLINE.md)), finds the request:

```rust
fn plan_queued_map_sprite_movement() {                 // rlPlanQueuedMapSpriteMovement (main loop)
    if decompression_pending() { return; }
    match aMovingMapSprites.wState {
        1 => {
            // a flood fill over the class's movement costs, toward the destination
            // or the nearest free tile to it; the moves go into one of four buffers
            if !plan_route(request) { brk(); }         // rlEventMovementPlanRoute
            aMovingMapSprites.wState = 2;
        }
        2 => aMovingMapSprites.wState = 0,
        _ => {}
    }
}
```

The route is built over the movement cost table of the character's class, the same costs the player's moves use ([Chapter 9](09-moving-a-unit.md)). A starting tile of -1 means the unit's current tile. The state stays at 2 for one pass of the main loop before it returns to 0. `WAIT_UNIT_SPRITE_DECOMPRESSED` waits until the state is 0 and no decompression is pending, and all 371 unit commands in the scripts are followed by one. If no route exists, the planner executes `brk` and the game stops; a unit load that fails does the same.

### Halts as a barrier

`MAP_HALT` pauses a sprite partway through its movement script. Two event commands use halts to keep the walking sprites and the scene in step. `WAIT_UNTIL_MAP_SPRITES_HALTING` creates a proc that ends once every moving sprite has halted or finished, and `CONTINUE_FORM_MAP_SPRITE_HALT` releases every halted sprite at once. Chapter 1's opening walks a cross knight and Eldigan this way:

```
MOVE_TEMPORARY_BY_SCRIPT CrossKnightCh01Cavalier, [29, 10], 4, MAP_SPRITE_YELLOW, _ScriptedMovementCrossKnight
WAIT_UNIT_SPRITE_DECOMPRESSED
WAIT_UNTIL_MAP_SPRITES_HALTING
YIELD

MOVE_TEMPORARY_BY_SCRIPT EldiganCh01, [14, 5], 4, MAP_SPRITE_YELLOW, _ScriptedMovementEldigan1
WAIT_UNIT_SPRITE_DECOMPRESSED
SCRIPTED_MAP_SCROLL _ScriptedMapScroll1, 1
WAIT_UNTIL_MAP_SPRITES_HALTING
YIELD

PAUSE 10
YIELD
DIALOGUE dialogueChapter01Opening1
YIELD

CONTINUE_FORM_MAP_SPRITE_HALT
...

_ScriptedMovementCrossKnight
  MAP_FACE_DOWN
  MAP_HALT
  MAP_DOWN_MULTIPLE 1
  MAP_HALT
  MAP_HALT
  MAP_END
```

The cross knight turns and halts at once. Eldigan walks his first leg while a scripted scroll moves the camera, and halts. The conversation plays with both of them standing, and each `CONTINUE_FORM_MAP_SPRITE_HALT` after it moves every halted sprite on to its next halt. Two halts in a row cost one release each, so a sprite can sit out a release while another sprite moves.

### Event unit slots

Scripts often need a unit's position without knowing it in advance: where Sigurd stands when he takes a castle, or where Elliot is when he retreats. `FILL_EVENT_UNIT_SLOT` looks up a character and stores its RAM pointer and tile in one of two slots (`wEventUnitSlot1Pointer`, `wEventUnitSlot2Pointer`, and their coordinates). The slot commands read them: `MAP_SCROLL_TO_EVENT_UNIT_SLOT_1` scrolls the camera to center on slot 1's unit, `SET_CURSOR_TO_EVENT_UNIT_SLOT_1` puts the map cursor on it, and a moving sprite's command can take its starting tile from slot 1 or its destination from slot 2. The stat-up display and the warp-away ASMCs act on slot 1's unit. If the character isn't on the map, the coordinates become `$FFFF` and the commands that read them do nothing.

These slots belong to the script. The unit a condition records when it matches (`wEventUnit1Pointer`, [Chapter 11](11-the-game-is-watching.md)) is separate.

Elliot's retreat in Chapter 1 uses both kinds of unit: a sprite that walks away and a real unit that is removed.

```
FILL_EVENT_UNIT_SLOT ElliotCh01, EventUnitSlot1
MOVE_TEMPORARY_TO_COORDS ElliotCh01, [-1, -1], [16, 0], 4, EventUnitSlot1, MAP_SPRITE_RED, true
WAIT_UNIT_SPRITE_DECOMPRESSED
WAIT_UNIT_SPRITE_DECOMPRESSED
RUN_EVENT_CONDITION
  REMOVE_UNIT ElliotCh01
WAIT_UNTIL_MAP_SPRITES_HALTING
YIELD
END_EVENT
```

The sprite starts on Elliot's tile (slot 1) and walks to the top edge of the map, disappearing when it leaves the screen. Once the route is planned, the script removes the real Elliot in the same frame, so the player sees one Elliot walking away. The second wait is redundant; it passes at once.

## The escape hatches

### Into the condition list

`RUN_EVENT_CONDITION` is followed by the bytes of one condition-list command. The handler sets the data bank to the script's bank, passes the command's address to `rlTryRunEventConditionCommand`, which runs it through the condition engine's dispatch table in run mode, and continues after the command's parameters. The scripts do this 780 times. The most common commands:

| Command | Uses | |
|---|---|---|
| `ADD_UNIT_STAT` | 113 | stat rewards from talks and villages |
| `DEPLOY_UNIT_GROUP` | 57 | put a whole unit group on the map |
| `SET_TALK_TARGET` | 55 | open a talk |
| `REGISTER_CHARACTER_MAP_SPRITE` | 51 | load a map sprite before a unit walks in |
| `MODIFY_LOVE_POINTS` | 51 | talks that bring a couple closer |
| `REGISTER_UNITGROUP_MAP_SPRITES` | 50 | |
| `REMOVE_UNIT` | 39 | |
| `SET_UNIT_POSITION` | 37 | |
| `GIVE_UNIT_PID` | 37 | give an item |
| `UPDATE_LOCATION_AND_MAP_CHANGE_EVENTS` | 35 | redraw locations and apply map changes |

None of these has a counterpart in the script language. The game has one implementation of each state change, reachable from a condition list and from a script alike.

`RUN_EVENT_CONDITION_AND_WAIT` runs a condition command and then waits until bit 0 of `bUnknown000E7B` is clear, and four frames more. The prologue uses it twice, with `SET_SCRIPTED_ACTION`, which starts a map action for a unit (the same machinery the AI drives its units with) and sets that bit; the battle scene clears it when the scripted fight ends.

### Into assembly

`RUN_ASM` calls a routine by its 24-bit address and continues when it returns. The scripts call 104 distinct routines in 310 places, most of them small ASMCs written for one scene: a chapter's warp-away effect, Silvia's dance in Chapter 4, Julia receiving the Light tome in the final chapter if she has no weapon, the eight pages of staff credits in the attract mode. An ASMC can block the script by creating an event proc of its own. The most used one pairs with `ADD_UNIT_STAT`, here from Chapter 1's talk between Quan and Finn:

```
RUN_EVENT_CONDITION
  ADD_UNIT_STAT Finn, Skill, 1
RUN_EVENT_CONDITION
  ADD_UNIT_STAT Finn, Defense, 1
FILL_EVENT_UNIT_SLOT Finn, EventUnitSlot1
RUN_ASM rlASMCStatUpDisplay
YIELD
```

`rlASMCStatUpDisplay` (78 uses) runs the map's reward display for the unit in slot 1 with no item, gold, level, or experience, so only the stat gains show, and creates `procHaltEvent`, which ends when the display signals it has finished. The script waits on it like any other proc.

## Scripts outside the chapters

The chapter events are the bulk of the scripts, and the same engine runs several other kinds:

| Script | Started by | Uses |
|---|---|---|
| Chapter events (by ID) | `EVENT` in a condition list; the map step on a game over | everything above |
| A chapter's world map introduction (`aWorldMapEvents`) | `rsStartChapterWorldMapEvents`, a step of the save menu screen between chapters; the script's `WM_FADE_IN` opens the world map screen, and its `WM_FADE_OUT` goes on to the chapter intro | the `WM_` commands |
| The epilogue's world map (`aEventChapterEpilogueWorldMap`) | epilogue step 12 | the `WM_` commands |
| The attract mode's opening (`aOpeningEvent`) | the title screen, when its intro ends | `MOVE_TEMPORARY_TO_COORDS_CLASS`, `DEMO_ALLOW_SKIP`, `OPEN_TITLE_SCREEN` |
| A pre-combat conversation | `SET_PRECOMBAT_DIALOGUE` ([Chapter 11](11-the-game-is-watching.md)) | a template copied to RAM |

The world map commands scroll the world map, fade it, show and clear its narration box, and place portraits, markers, and highlights ([Chapter 19](OUTLINE.md)). Chapter 2's introduction:

```
PLAY_SONG SONG_WORLD_MAP_GENERATION1
YIELD
SET_CAMERA_POSITION [16, 32]
WM_FADE_IN
WM_SCROLL [9 * 16, 36 * 16]
YIELD
WM_DIALOGUE dialogueChapter02WorldMap1
YIELD
WM_CLEAR_DIALOGUE
YIELD
...
```

The attract mode's opening ([Chapter 20](OUTLINE.md)) walks units with `MOVE_TEMPORARY_TO_COORDS_CLASS`, which can draw a character with a different map sprite. `DEMO_ALLOW_SKIP` starts a proc that ends the opening when the script finishes or the player presses Start, and `OPEN_TITLE_SCREEN` fades to the title screen.

### Templates in RAM

A pre-combat conversation's script is assembled when it is needed. `rsRunSongAndDialogueEventScript` copies a template from ROM into `aEventScriptBuffer`, a 34-byte buffer in low RAM, writes the song number and the dialogue pointer into its operands, and starts the copy:

```
aSongAndDialogueEventTemplate
  PLAY_SFX_WORD $00E0
  PAUSE 35
  YIELD
  PLAY_SONG 0                  ; song patched in at offset 8
  DIALOGUE 0                   ; dialogue patched in at offset 10
  YIELD
  RUN_ASM rlASMCCheckIfAnimationsOff
  JUMP_RELATIVE_FALSE +
    PLAY_SFX_WORD $00E0
    PAUSE 35
    YIELD
    RESTORE_PHASE_MUSIC
    YIELD
  +
  RUN_EVENT_CONDITION
    START_COMBAT_ANIMATION
  END_EVENT
```

An absolute `JUMP` here would name an address in the template's ROM bank, which means nothing once the script runs from RAM. The relative jumps measure from the command itself and work in any copy. This template holds the only relative jump in the game. The ASMC before it sets the truth flag from a bit of `wBattleStatus`, and the script brings back the phase music only when that bit is set. Its last command starts the combat animation that the battle code held back when the conversation began ([Chapter 11](11-the-game-is-watching.md)).

## Skip points

When a script begins, `rsGetEventLength` scans it for the word `$FEFE` and records the offset just after it in `wActiveEventLength`. The interpreter steps over the marker. A routine in the event code, `rsCheckSkipActiveEventUnused`, would use the offset: on a Start press before the marker, it clears the fades, the map windows, and the event procs, and moves the script to just past the marker. Nothing calls it, and a code-data log recorded over a playthrough of the prologue shows it never ran.

The nine markers in the game are all in chapter openings, just before each opening's closing setup: a fade-out, in most chapters the deployment of the player's army, the camera position, and `RELOAD_MAP_SCREEN`. A skipped opening would still have ended with the army on the map and the screen rebuilt. No chapter script can be skipped with Start. The attract mode's opening has its own way out (`DEMO_ALLOW_SKIP`).

## Trade-offs and hard limits

The script is written as a straight list of things to do, and the engine turns it into per-frame work: each `YIELD` is a point where the script gives up the frame, and each event proc is work the script will wait for. Writers state the order of events and where to wait, and none of them has to manage a timer. The cost is that waiting happens only at frame boundaries. A writer who leaves out a `YIELD` after a proc-starting command gets the following commands in the same frame, which is sometimes what the scene wants (a camera move behind a conversation) and otherwise a mistake that no tool catches.

Keeping state changes in the condition-list language gives each change one implementation. The script language itself stays small, with sequencing, waiting, and presentation, and `RUN_ASM` takes whatever is left over. Of the 93 commands, 37 are never used.

The limits:

- **One script at a time.** `EVENT` fails while one runs and retries at a later announcement ([Chapter 11](11-the-game-is-watching.md)).
- **562 event IDs** (`$000`–`$231`).
- **16 event procs**, shared with every other proc in the proc engine's 16 slots.
- **Four moving map sprites** at once; a unit command waits for a free slot.
- **One condition register** (the truth flag), two event unit slots, and the event flags; no variables, counters, or subroutine calls in the script language.
- **Jumps within a bank**: a script must fit in one ROM bank.
- **No route, no game**: a planned walk with no path, or a unit load that fails, executes `brk`.
- **No skipping**: the skip point is recorded and never used; only the attract mode's opening ends on Start.

## Where it lives in the source

- [engine/events/event_scripts.asm](../../engine/events/event_scripts.asm): `rlEventEngineBeginScript`, `rlRunEventCommand`, `aEventCommandPointers` and every command handler, the event proc tables and their poll (`rsEventEnginePollBlockingProcs`), the unit move dispatch (`aEventUnitMoveHandlers`), the wait procs (`procEventWaitMapSpritesHalting`, `procEventWaitFadeToMap`, `procEventWaitFlag0E7B`), and `rsReturnToMapMainLoop`.
- [engine/events/event_engine.asm](../../engine/events/event_engine.asm): `rlStartChapterEventByID`, `rlStartEventScript`, the per-frame hook and its state table (`rsRunEventEngineState`, `aEventEngineStateRoutines`), `rlTryRunEventConditionCommand`.
- [engine/core/fade.asm](../../engine/core/fade.asm): `rlResetEventAndSpriteState` (state 2) and the unused skip routine.
- [engine/events/event_procs.asm](../../engine/events/event_procs.asm): `procEventPause`, the timed fades, `procHaltEvent`.
- [engine/events/event_movement.asm](../../engine/events/event_movement.asm): route planning for moving sprites (`rlEventMovementPlanRoute`, `rlPlanQueuedMapSpriteMovement`); [engine/map/scroll.asm](../../engine/map/scroll.asm): `rlSpawnMovingMapSprite` and the scroll scripts; [engine/map/map_sprites.asm](../../engine/map/map_sprites.asm): showing a loaded unit when its walk ends.
- [engine/events/asmc.asm](../../engine/events/asmc.asm) and [engine/events/cutscenes.asm](../../engine/events/cutscenes.asm): the shared ASMCs and the scripted map-battle cutscenes.
- [engine/dialogue/death_quotes.asm](../../engine/dialogue/death_quotes.asm): the RAM templates for pre-combat conversations.
- [events/](../../events/): every chapter's scripts, one file each; [data/chapter/EventPointers.csv](../../data/chapter/EventPointers.csv): the event ID table.
- [include/events/Main.h](../../include/events/Main.h): every script command; [include/events/Helpers.h](../../include/events/Helpers.h): the movement script commands, sprite colors, and dialogue backgrounds.
- [docs/reference/events.md](../reference/events.md): the reference page.
