# Chapter 11: The Game Is Watching

A chapter's story reacts to play through one mechanism. Gameplay code that does something a scene might care about, such as ending a unit's action, taking a castle, starting a talk, killing a unit, or beginning a phase, **announces** it: it writes an action number and up to four arguments into fixed variables and calls `rlGetAndRunChapterMapEventConditions`. That routine walks the current chapter's **condition list**, a list of commands in ROM. Each condition names the action it waits for and the arguments it wants. A condition that matches runs the command after it, which usually starts a scene script ([Chapter 12](OUTLINE.md)) and sometimes sets a flag, attaches a quote to the battle in progress, or loads an army on the spot.

Flags are the list's memory. Each chapter has 80 one-bit flags, and the game keeps 256 more that last the whole playthrough. A condition's flag keeps it from matching twice. Scripts and AI scripts set and clear flags to open talks, change the map, and record what has happened, and the chapter's talk table and map-change table read the same flags.

The design is close to the Observer pattern, without subscriptions. The announcing code always calls the same routine and knows nothing about who is listening; the listeners are entries in a data list, and each filters itself by action number. This chapter lists the actions, then covers the grammar of a condition list, flags and counters, the chapter's RAM entry, characters across the two generations, conditions that change a battle while it is being settled, and the costs.

## The actions

Eighteen action numbers are announced. Each comes from one or two places in the code, and each has a condition command (or several) that waits for it:

| Action | Announced when | Arguments | Conditions |
|---|---|---|---|
| `$01` | a castle's takeover finishes | the new owner's army, the location | `CHECK_SEIZING_CASTLE` |
| `$02` | a computer unit raids a village and takes its last gold | the raider's army, the location | `CHECK_VILLAGE_DESTROYED` (no chapter uses it) |
| `$03` | a unit's action ends (the action-ended note, [Chapter 8](08-the-turn.md)) | character, X, Y, army | `CHECK_UNIT_IN_AREA`, `CHECK_UNITS_WITHIN_DISTANCE` |
| `$04` | a unit goes into a castle from the map | character, its home castle | `CHECK_ENTERING_HOME_CASTLE` |
| `$06` | the castle screen opens its town for a unit | character, castle | `CHECK_ENTERING_CASTLE_MENU` |
| `$08` | the town command | character, location | `EC_09` (the command never appears, [Chapter 10](10-menus-over-the-map.md)) |
| `$09` | a village visit | character, location | `VISIT_VILLAGE` |
| `$0A` | a talk | initiator, target, the talk table's money rule | `CHECK_TALK`, `CHECK_CHILD_TALK` |
| `$11` | two units become lovers | the woman, the man | `CHECK_FELL_IN_LOVE` (no chapter uses it) |
| `$14` | a battle's rounds have been built, before it is shown; not for staves | attacker's army and character, defender's army and character | `CHECK_UNITS_FIGHTING`, `CHECK_UNITS_FIGHTING_1TO2RANGE` |
| `$17` | the map step removes a defeated unit, or a unit escapes the map | character, army | `CHECK_UNIT_DIED` |
| `$18` | a strike brings a unit to 0 HP, while the rounds are being built | the dead character, the attacker | `CHECK_UNIT_DIED_TO` |
| `$1A` | the help command rescues a civilian | rescuer, formation + 1 | `RESCUE_CIVILIAN` |
| `$1B` | a seize frees a captured player unit held in the castle | character | `CHECK_PLAYER_UNCAPTURED_IF_SEIZING` |
| `$1C` | a unit leaves the arena with winnings | character, location, last opponent | `CHECK_WON_IN_ARENA` |
| `$1D` | a lover, sibling, or triangle crit, after the rounds are built | crit type, character | `CHECK_SPECIAL_CRIT` |
| `$20` | the end of a turn (map step 9) | the turn that just ended | `START_PLAYER_PHASE` |
| `$21` | a phase starts (map step 3), and before each computer unit acts | turn, army, AI setting, character | `CHECK_TURN_PHASE_AI_ACTOR` |

At the start of a phase, action `$21` passes 0 for the AI setting and the character. During a computer phase the AI raises a request before each of its units acts, and the map step announces `$21` again with that unit's AI setting and character ([Chapter 8](08-the-turn.md)). The same action number therefore serves "Verdane's phase has begun" and "a unit of Verdane's AI group 4 is about to move".

The condition table has entries for four more numbers that nothing announces: `$05`, `$07`, `$25`, and `$26`. Their condition commands exist and no chapter uses them.

### Announcing

Every announcement has the same shape. The village visit is typical:

```rust
fn visit_village(unit, location) {                    // rlUnitVisitVillage
    close_village(location);
    add_money(unit, location.gold);
    finish_unit_action(unit);
    bEventActionIdentifier = 0x09;
    wEventEngineArgument1 = unit.character_id;
    wEventEngineArgument2 = location.id;
    run_chapter_map_event_conditions();               // rlGetAndRunChapterMapEventConditions
    redraw_location(location);
}
```

The routine it calls runs the map list of every chapter entry in RAM (there is one in practice; see below) and reports whether a scene was started:

```rust
fn run_chapter_map_event_conditions() -> bool {      // rlGetAndRunChapterMapEventConditions
    if bEventStatus & 0b11 != 0 { return false; }    // inside the opening list, or already running a list
    bEventStatus |= 0b10;
    for entry in aChapterEventRAMData {
        run_condition_list(entry.header.MapEvents);  // rlRunChapterMapEventConditions
    }
    bEventStatus &= !0b10;
    wEventEngineFlags & 0x0008 != 0                  // a script was started and hasn't begun running
}
```

The guard makes announcements non-reentrant: an announcement made while a list is already being walked, or while the opening list runs, is dropped. The result lets the caller step aside for a scene. When a unit enters its home castle and no event starts, the game tries the lover's home-castle conversation instead. When a castle is taken, the phase music resumes only if no event started. When the castle screen opens a town and an event starts, the screen waits in its event step and opens the town afterward. When a battle's announcement starts a script, the battle code doesn't start the combat animation, and the pre-combat dialogue script starts it when it ends.

## A chapter's two lists

A chapter's events begin at a three-field header: the chapter number, a pointer to the **opening list**, and a pointer to the **map list**. Both lists use the same commands.

The opening list runs once, when the chapter's map is set up for a new chapter (not when a map save is resumed). It loads the armies into their faction slots, sets every pair's relation ([Chapter 4](04-armies-and-allegiance.md)), sets the flags the chapter starts with, deploys the starting units, and starts the opening scene. Chapter 1's begins:

```
aChapter01OpeningEvent
  REGISTER_UNITGROUP_MAP_SPRITES UNITGroupChapter01Brigands
  LOAD_FACTION_GROUP FS_Player,       FG_Ch01Sigurd
  LOAD_FACTION_GROUP FS_Ch01Genoa,    FG_Ch01Genoa
  ...
  macroSetFactionsEnemies [FS_Player, FS_Ch01Genoa]
  ...
  SET_FLAG FlagChapter01_SigurdAyraTalk
  DEPLOY_UNIT_GROUP UNITGroupChapter01Brigands
  EVENT FlagAlways, EventChapter01Opening
  END_CHAPTER_EVENTS
```

`rlBeginChapterEvents` sets bit 0 of `bEventStatus` while the opening list runs, so nothing the opening list does can trigger the map list. The map list is walked from the top at every announcement until the chapter ends.

## The grammar of a condition list

A list is a sequence of commands, each an opcode byte followed by its parameters, ending in the word `$FFFF`. There are 121 opcodes (`$00` to `$78`), dispatched through one table of handlers, `aChapterEventConditionCommands`.

Each handler runs in one of two modes, chosen by the carry flag on entry. In run mode it does its work; in skip mode it only steps over its own parameters. Skipping a command means calling its handler in skip mode (`rsTrySkipEventConditionCommand`), so the length of every command lives in its handler and the list needs no length table.

```rust
fn run_condition_list(mut y: Ptr) {                   // rlRunChapterEventConditions
    while read_word(y) != 0xFFFF {
        let op = read_byte(y);
        y += 1;
        y = aChapterEventConditionCommands[op](y, /* skip: */ false);
    }
}
```

The opcodes fall into four groups:

| Opcodes | Kind | On a match | On a miss |
|---|---|---|---|
| `$01`–`$1F` | **action conditions**: compare the action, a flag, and parameters | run the next command, then skip to the next `BREAK_ACTION_EVENT_CHECKS` | skip the next command |
| `$21`–`$24` | **turn checks** | run on through the following commands | skip to the next `BREAK_TURN_EVENT_CHECKS` |
| `$29`–`$2D`, `$38`–`$47` | **state checks**: flags, permanent flags, counters, who is alive or married | run on | skip to the next `BREAK_STATE_CHECKS` |
| the rest | **actions**: start a script, set a flag, load an army, give an item, set a quote | do it | — |

The three break markers are an opcode (`$20`, `$25`, or `$2E`) followed by the word `$6666`. Reached in normal flow, a break does nothing. The skip routines don't parse commands to find them: they scan forward one byte at a time for the opcode followed by `$6666`, a value chosen because no parameter is likely to contain it.

### Action conditions

An action condition is followed by exactly one command, its **body**. Chapter 1's list is mostly pairs like these:

```
CHECK_SEIZING_CASTLE FlagChapter01_GenoaSeized, FS_Player, Ch01_Genoa
  EVENT FlagAlways, EventChapter01GenoaSeized

CHECK_UNIT_DIED FlagChapter01_AyraDied, Ayra
  EC_NOP_00
```

The first byte after the opcode is the condition's flag. All action conditions share one evaluator:

```rust
fn evaluate_action_condition(action: u8, flag: u8, test: fn() -> bool) {   // rsEvaluateEventCondition
    let ok = action == bEventActionIdentifier
        && match flag {
            0xFF => true,                               // FlagAlways
            f if f & 0x80 == 0 => !flag_set(f),         // once: not matched before
            f => flag_set(f & 0x7F),                    // needs the flag set
        }
        && test();                                      // the parameters, against the arguments
    if !ok {
        skip_next_command();
        return;
    }
    match flag {
        0xFF => {}
        f if f & 0x80 == 0 => set_flag(f),
        f => unset_flag(f & 0x7F),
    }
    run_next_command();                                 // the body
    skip_to(BREAK_ACTION_EVENT_CHECKS);                 // rsEventFindConditionBreak
}
```

The parameter test compares each parameter with the matching argument, and a negative parameter (`AnyCharacter`, `AnyFactionSlot`, `AnyLocation`, and `AnyTurn` are all -1) matches anything. A few conditions do more. `CHECK_UNITS_FIGHTING` matches its two units in either order, so a quote for Midir against Munnir plays whoever attacks. `CHECK_UNITS_FIGHTING_1TO2RANGE` also needs the battle distance to be under 3. `CHECK_UNIT_IN_AREA` tests that the tile lies inside a rectangle ([Chapter 5](05-who-stands-where.md)). `CHECK_UNITS_WITHIN_DISTANCE` finds both units on the map and compares their distance. Conditions about a talk, an area, or an arena win also record the units involved in `wEventUnit1Pointer` and `wEventUnit2Pointer`, for commands that act on "the event's unit".

A flag byte with bit 7 set turns the flag into a precondition that the match consumes. No chapter uses that form; every flag in the retail lists is either `FlagAlways` or a once-only flag.

`EC_NOP_00` as a body does nothing, so a condition with it exists only to set its flag. Chapter 1 records Ayra's death that way; a later check reads `FlagChapter01_AyraDied`.

After a match, the evaluator skips to the next action break, so among the action conditions before one break, the first match wins. The scan is positional. A break placed right after one condition gives that condition a section of its own, and a list can have as many sections as it likes.

### Turn checks

`CHECK_TURN_PHASE_AI_ACTOR` takes four signed bytes and a word: turn, army, AI setting, and character, each matching anything at -1. It compares them with action `$21`'s arguments and skips to the next turn break if anything differs. Otherwise it lets the list run on, and every command up to the break runs: a turn check has a block for a body. Every turn block that matches runs, in list order.

The AI setting and the character default to 0, the values a phase start announces, so a block written with only a turn and an army runs at the start of that army's phase. A block with an AI setting and `AnyCharacter` runs before each unit of that AI group acts. Chapter 1 uses both:

```
CHECK_TURN_PHASE_AI_ACTOR 2, FS_Player
  EVENT FlagChapter01_EdainGroupSpawn, EventChapter01EdainGroupSpawn
BREAK_TURN_EVENT_CHECKS

CHECK_TURN_PHASE_AI_ACTOR AnyTurn, FS_Ch01Verdane, 4, AnyCharacter
  CHECK_FLAG_SET FlagChapter01_FoesNearGenoa
    EVENT FlagChapter01_AyraStartsMoving, EventChapter01AyraStartsMoving
  BREAK_STATE_CHECKS
BREAK_TURN_EVENT_CHECKS
```

The first runs at the start of the player's phase on turn 2. The second runs before each unit of Verdane's AI group 4 acts, and starts its scene once `FlagChapter01_FoesNearGenoa` is set, a flag that the group's own AI script sets (`AI_SET_CHAPTER_EVENT_FLAG`) on one branch of its decision.

Three more turn-check opcodes (`$22`–`$24`) skip to the turn break unless the action is `$20`, `$25`, or `$26`. No chapter uses them.

### State checks

A state check tests something and, if the test fails, skips to the next state break. It doesn't look at the action number. State checks written one after another form a conjunction, since any failure skips to the same break; the indentation in the source shows the intent, but the engine has no nesting. From Chapter 1:

```
CHECK_TURN_PHASE_AI_ACTOR AnyTurn, FS_Ch01Verdane, 4, AnyCharacter
  CHECK_FLAG_SET FlagChapter01_GenoaSeized
    CHECK_FLAG_UNSET FlagChapter01_SigurdAyraTalk
      CHECK_FLAG_UNSET FlagChapter01_AyraDied
        EVENT FlagChapter01_GenoaSeizedAyraResponse, EventChapter01GenoaSeizedAyraResponse
  BREAK_STATE_CHECKS
BREAK_TURN_EVENT_CHECKS
```

A state block outside any turn block runs at every announcement of any kind. Chapter 1 has two, right after the action conditions:

```
CHECK_FLAG_UNSET FlagChapter01_MunnirBattleQuote
  CHECK_FLAG_IN_LIST_SET [FlagChapter01_MidirMunnirBattleQuote, FlagChapter01_AzelleMunnirBattleQuote]
    SET_FLAG FlagChapter01_MunnirBattleQuote
BREAK_STATE_CHECKS
```

Munnir has a generic battle quote and two pre-combat conversations, with Midir and with Azelle. Once either conversation has played, this block sets the generic quote's flag, and the generic quote stops matching.

### A whole list

The layout that results is the same in every chapter:

```
  action conditions, each with a one-command body   ─┐ first match wins,
  ...                                                │ then skip to ↓
  BREAK_ACTION_EVENT_CHECKS                         ◀┘
  state blocks         (every announcement)
  turn block                                        ─┐ miss: skip to ↓
    commands, state blocks                           │
  BREAK_TURN_EVENT_CHECKS                           ◀┘
  turn block ...
  END_CHAPTER_EVENTS ($FFFF)
```

Chapter 1's map list has 136 commands: 38 action conditions with their bodies, 10 turn blocks, and the state checks and breaks around them. At each announcement the evaluator reads all of it: a skipped condition still costs its opcode dispatch and a comparison of the action number.

## Flags

### Two sets

Each chapter's **event flags** are 80 bits in its RAM entry, numbered 0 to 79. `rlSetEventFlag`, `rlUnsetEventFlag`, and `rlCheckEventFlagSet` turn a number into a byte (number ÷ 8) and a bit (from an eight-entry mask table) and ignore any number from 80 up, which is how `FlagAlways` (`$FF`) passes through them untouched. Each chapter's file names its own flags (`FlagChapter01_GenoaSeized = 0`, and so on); numbers are reused from chapter to chapter.

The 256 **permanent flags** (`aPermanentEventFlags`, 32 bytes at `$7E5297`) last from a new game to the ending and are named in [include/PermanentFlags.h](../../include/PermanentFlags.h). They record who was recruited, who lived through generation 1, which generation 2 substitutes exist, which lovers visited a home castle, and whether any player unit has died in generation 2. Condition lists use them rarely: six `SET_PERMANENT_FLAG` and one `CHECK_PERMANENT_FLAG_UNSET` in all the chapters. Engine code reads them more: the endings, the generation change, death quotes, and lover conversations.

Both sets are written by the condition lists, by scene scripts (`SET_FLAG_IF_IN_CHAPTER` and its relatives), and by AI scripts (`AI_SET_CHAPTER_EVENT_FLAG`). They are read by the condition lists, the scripts, and three tables in the chapter's data: talks, map changes, and the phase flags of [Chapter 8](08-the-turn.md).

### A condition's flag and its event's flag

`EVENT` has a flag of its own:

```rust
fn event_command(flag: u8, event_id: u16) {           // rsChapterEventConditionCommandEvent
    if flag != 0xFF && flag_set(flag) { return; }
    if start_chapter_event_by_id(event_id) {          // rlStartChapterEventByID: fails while a script runs
        set_flag(flag);
    }
}
```

Only one script runs at a time. If one is already running, `rlStartChapterEventByID` refuses, `EVENT` leaves its flag clear, and the next announcement that reaches the command tries again. That matters for turn blocks, which carry no flag of their own: when two blocks both want to start a scene at the start of one phase, the first starts and the second starts at the next announcement that reaches it.

An action condition's flag is different. The evaluator sets it before the body runs, so if the body's `EVENT` can't start, the condition doesn't match again. Chapter 1 pairs most of its once-only conditions with `EVENT FlagAlways` and relies on those actions being announced while no script runs, which the map step's handlers ensure by waiting for scripts to finish ([Chapter 8](08-the-turn.md)).

### One flag, several readers

Chapter 1's talk between Sigurd and Ayra shows how a single flag connects the list, a script, and a table:

1. The opening list sets `FlagChapter01_SigurdAyraTalk`.
2. The chapter's talk table lists the talk with that flag. `rlCheckTalkEventEntryAvailable` offers a talk only while its flag is clear, so the talk command doesn't appear for Sigurd next to Ayra ([Chapter 10](10-menus-over-the-map.md)).
3. When Sigurd takes Genoa, the seize condition starts `EventChapter01GenoaSeized`, and the script clears the flag. The talk becomes available.
4. When they talk, action `$0A` reaches `CHECK_TALK FlagChapter01_SigurdAyraTalk, Sigurd, Ayra`, which matches, sets the flag again, and starts the talk's scene. The talk table stops offering it.
5. Meanwhile the turn block above reads the same flag: while Genoa is taken and the talk is available but hasn't happened, Ayra's response scene runs before her group moves.

A talk table entry can also carry a money rule: 0 always allows the talk, and 1 allows it only when the initiator has at least 10,000 gold. The rule's number becomes the talk's third argument, so a `CHECK_TALK` can tell the two cases apart.

### Map changes

The map-change table pairs a flag with a tile position and a block of replacement tiles. `UPDATE_LOCATION_AND_MAP_CHANGE_EVENTS` redraws every location for its current state and applies each map change whose flag is set and which isn't already active, marking it in `aChapterActiveMapChanges`, one bit per change. Whenever the map display is rebuilt (on the way back from a full-screen window or a battle scene, after the castle screen or the arena, or when a map save is loaded), every marked change is applied again. Chapter 1's forest opens this way: the Verdane spawn script sets `FlagChapter01_OpenForest`, and the table's one entry changes two tiles at (14, 43).

### Counters

Each chapter entry also has two byte counters, which the list can set, add to, step up or down, and compare. Chapter 6 uses both to count how often two siblings end an action next to each other:

```
CHECK_FLAG_SET FlagChapter06_LarceiCreidne_IucharbaTalk
  CHECK_UNITS_WITHIN_DISTANCE FlagAlways, Iucharba, Creidne, 1
    INCREMENT_CHAPTER_EVENT_COUNTER 1
  BREAK_ACTION_EVENT_CHECKS
BREAK_STATE_CHECKS

CHECK_CHAPTER_EVENT_COUNTER_EQUAL 1, 10
  EVENT FlagChapter06_CreidneIucharbaAdjacent, EventChapter06CreidneIucharbaAdjacent
BREAK_STATE_CHECKS
```

Once their talk has happened, each action Iucharba ends next to Creidne adds 1, and the tenth starts a scene. The action condition sits inside a state block, with an action break of its own right after it.

## The chapter's RAM entry

A chapter's event state is one `structChapterEventRAMEntry`, 17 bytes:

| Offset | Field | |
|---|---|---|
| `$00` | `Chapter` | the chapter number |
| `$02` | `EventPointer` | the chapter's event header in ROM |
| `$05` | `Counter1`, `Counter2` | the two counters |
| `$07` | `TemporaryEventFlags` | 80 flags in 10 bytes |

The entries live in `aChapterEventRAMData` at `$7E52B7`, a pool with room for three, managed by the generic RAM struct routines (`rlAppendNewStructEntry` and its relatives). Starting a chapter appends an entry and runs its opening list. The chapter's ending script removes it with `REMOVE_CHAPTER_STRUCT`, so the next chapter starts with an empty pool and only one entry exists during play.

The pool and the lookup routines were written for more than one chapter. `rlCheckIfEventFlagOfSpecifiedChapterSet` and the `..._IF_IN_CHAPTER` script commands take a chapter number. But the lookup returns a match only for the current chapter's entry; for any other chapter the flag reads as clear and a write does nothing.

Saving writes the permanent flags and the whole pool. Loading reads them back and then rewrites every entry's `EventPointer` from `aChapterEventPointers`, indexed by its chapter number (`rlRefreshChapterEventPointers`), so a save holds no ROM address that the game trusts.

## Characters across generations

Fourteen of the generation 2 children have a substitute who joins in the child's place when the child doesn't exist ([Chapter 17](OUTLINE.md)): Scathach for Dalvin, Febail for Asaello, Larcei for Creidne, and so on. A talk written for one should usually work for the other. The `CHECK_CHILD_` conditions map every character ID from Seliph's onward through `aEventsUnifiedGen2CharacterIds`, which sends each substitute to the child it replaces and every other character to itself, and compare the mapped IDs. `CHECK_CHILD_TALK Creidne, Iucharba` therefore matches a talk started by Creidne or by Larcei. Chapters 6 to 10 and the final chapter use `CHECK_CHILD_TALK` 38 times; the other `CHILD` variants exist and no chapter uses them.

## Conditions that change a battle

Two battle actions are announced while the battle is still being settled ([Chapter 6](06-resolving-a-battle.md)), so their bodies can change what is shown.

Action `$18` comes from inside the strike that brings a unit to 0 HP, before the strike is marked fatal. `COMBATANTS_STAY_ON_MAP` sets the stay-on-map bit on both combatants, and the round builder then leaves the fatal flag off. Chapter 1 handles Elliot that way:

```
CHECK_UNIT_DIED_TO FlagAlways, ElliotCh01, AnyCharacter
  COMBATANTS_STAY_ON_MAP
...
CHECK_UNIT_DIED FlagAlways, ElliotCh01
  EVENT FlagChapter01_ElliotRetreats, EventChapter01ElliotRetreats
```

The battle shows no death. On the next frame the map step's defeat handler sees the stay-on-map bit and leaves Elliot visible, then announces `$17`, and the second condition starts the retreat script. The script walks him to the top edge of the map and removes him with a condition-list command, `REMOVE_UNIT`.

Action `$14` comes after the rounds are built, before the battle is shown. `SET_BATTLE_OR_DEATH_QUOTE` gives one combatant a quote to say in the battle scene, or replaces its death quote; a battle quote is skipped if the defender is asleep or silenced. `SET_PRECOMBAT_DIALOGUE` plays a conversation with a song before the fight. It builds a short script in RAM (sound, song, dialogue, the phase music again) that ends by starting the combat animation, since the battle code, seeing a script start, didn't start it. Battles are the most common trigger in the condition lists: the chapters have 187 fighting conditions, 129 `SET_BATTLE_OR_DEATH_QUOTE` commands, and 70 `SET_PRECOMBAT_DIALOGUE` commands.

## Scripts reach back

The condition-list commands that change state (load an army, deploy a group, give an item, remove a unit, change talk targets) have no counterpart in the script language. A script runs one of them inline with `RUN_EVENT_CONDITION`, followed by the command's bytes, which the script engine hands to `rlTryRunEventConditionCommand`. The chapters' scripts do this 780 times. [Chapter 12](OUTLINE.md) covers the script side.

## Trade-offs and hard limits

Announcing through one routine keeps gameplay code ignorant of the story: a village visit adds gold and calls the routine whether the chapter has one village event or none. The conditions, their order, and their flags are all data, so a chapter's triggers can be rewritten without touching code. A new kind of trigger costs more: an action number, a condition handler and its parameter test, and a call at the place in the code where the action happens.

The list is a linear scan of every command at every announcement, with no index by action number. That is cheap enough at the rate the game announces (once per action, phase, or computer unit), and it keeps the format a plain byte stream that a skip mode can step through.

Positional breaks give the list structure without nesting. The cost is that a misplaced break changes which conditions share a "first match wins" section, and a skip scan that finds the bytes of a break inside a parameter would stop there.

One script at a time keeps scenes from overlapping. An `EVENT` that can't start retries at the next announcement that reaches it, and an action condition's flag, set before its body, doesn't.

The limits:

- **80 flags per chapter**, numbered 0 to 79; higher numbers are ignored without an error.
- **256 permanent flags**.
- **Two counters per chapter**, a byte each.
- **Four arguments** per announcement.
- **Three chapter entries** in the pool; one is used.
- **One script at a time**, with event IDs below `$0232`.
- **121 condition opcodes**, `$00` to `$78`, in one jump table.

## Where it lives in the source

- [engine/events/event_engine.asm](../../engine/events/event_engine.asm): the chapter entry pool, both flag sets and the counters, `rlGetAndRunChapterMapEventConditions`, the list runner, `aChapterEventConditionCommands` and all 121 handlers, `rsEvaluateEventCondition`, the parameter tests, the break scans, the generation 2 ID table, map changes, the arena exit announcement, `rlStartChapterEventByID`.
- [engine/events/chapter_data.asm](../../engine/events/chapter_data.asm): the chapter data getters (locations, map changes, talks, phase flags).
- [engine/events/talk_events.asm](../../engine/events/talk_events.asm): `rlCheckTalkEventEntryAvailable` and the money rule.
- The announcers: [engine/map/map_step.asm](../../engine/map/map_step.asm) (`$03`, `$04`, `$17`, `$20`, `$21`), [engine/map/map_actions.asm](../../engine/map/map_actions.asm) (`$02`, `$08`, `$09`, `$0A`, `$1A`, `$1B`), [engine/map/map_sprites.asm](../../engine/map/map_sprites.asm) (`$01`), [engine/battle/battle.asm](../../engine/battle/battle.asm) (`$14`, `$1D`), [engine/units/unit_state.asm](../../engine/units/unit_state.asm) (`$18`), [engine/units/lovers.asm](../../engine/units/lovers.asm) (`$11`), [engine/castle/castle_screen.asm](../../engine/castle/castle_screen.asm) and [engine/castle/courtyard.asm](../../engine/castle/courtyard.asm) (`$06`).
- [engine/dialogue/death_quotes.asm](../../engine/dialogue/death_quotes.asm): the pre-combat dialogue script built in RAM.
- [events/](../../events/): each chapter's flag names, header, opening list, map list, and chapter data (`Chapter01.asm` and so on).
- [include/events/Conditions.h](../../include/events/Conditions.h): every condition-list command; [include/events/Helpers.h](../../include/events/Helpers.h): `FlagAlways` and the `Any` values; [include/Chapters.h](../../include/Chapters.h): `structChapterEventHeader`, `structChapterEventRAMEntry`, the talk and map-change entries; [include/PermanentFlags.h](../../include/PermanentFlags.h); [include/WRAM.h](../../include/WRAM.h): `bEventStatus`, `bEventActionIdentifier`, the arguments, `wEventEngineFlags`.
- [docs/reference/events.md](../reference/events.md): the reference page.
