# Chapter 24: The Battle Scene

The battle scene is the full-screen view of a fight: two large combatants on a background drawn from their terrain, and a panel along the bottom with each side's name, weapon, HP, and battle stats. It plays the same record the map battle does ([Chapter 23](23-two-ways-to-show-a-fight.md)), the action structs and the round log, and like the map battle it changes nothing in the game's state. It takes over the whole display, as its own game state with its own VBlank routine, and returns to the map, the castle, or the arena when the fight is over.

Its work is divided among several small engines, each running every frame:

- **The round reader** takes the next entry of the round log when the stage is quiet, and turns it into an action for the attacker.
- **Four animation slots**, one for each combatant and one for each combatant's projectile, play the actions. Each slot runs a queue of moves and a **sequence script** of poses and commands.
- **The battle scene script**, a bytecode of its own, stages everything that isn't a combatant: spell graphics, background changes, window and scroll effects, screen shakes, sounds, and the HUD's gauges.
- **Ten palette effect slots** animate colors.
- **The end steps** run after the last round: experience, level up, messages, and the fade out.

The engines pass control back and forth through small flags. A sequence can start a script, a script can land a strike, and a combatant can freeze until the other side releases it.

This chapter covers getting into and out of the scene, how the screen is divided, setting the stage, the rounds and the animation slots, the scene script and the palette effects, the HUD, and the end steps.

## Getting in and out

`rlStartBattleScene` ([engine/battle/battle.asm](../../engine/battle/battle.asm)) stops the music and leaves the map. An ordinary battle (`wBattleType` 0) closes the screen with a window wipe: an HDMA table rewrites a window's left edge on every scanline, and two 240-line buffers alternate each frame as the shape in `aBattleTransitionShape` closes in (`aBattleTransitionHDMAInfo`). Arena bouts, class changes, and fights on the castle screen fade out instead. The opening's demo goes straight in.

`rsOpenBattleScene` ([engine/battle_scene/battle_screen.asm](../../engine/battle_scene/battle_screen.asm)) frees the map's unit and terrain window procs and resets the active sprite, HDMA, and interrupt engines, clears the animation slots, runs `rlBattleSceneInit`, sets up five mid-frame interrupts, and installs game state `$18` with the scene's VBlank and main loop routines. State `$18` blanks the screen once and moves to state `$19`, which runs the scene's frame until the fade out ends. Then it leaves according to the fight: to the map (in mode 3 after Julius's defeat, below), back to the arena's castle handler (`rlReturnToCastleFromArena`) after an arena fight, to the castle screen after a class change or a castle fight, or to game state 0.

## The screen

### Layers

The scene uses background mode 1, three layers of tiles, with BG3 drawn above everything when its priority bit is set:

| Layer | Holds |
|---|---|
| BG2 | The terrain background: a 64 × 32-cell tilemap, 512 pixels wide, so the camera can pan across it |
| BG1 | The foreground drawn over the combatants for some pairs of terrains; spell scripts also use it |
| BG3 | Message windows and text |
| Sprites | The combatants, their projectiles, and spell sprites |

The combatants are built from many hardware sprites each. Their pose graphics are uploaded to video RAM when the pose changes, a few rows of tiles at a time.

### Five interrupts per frame

The bottom of the screen is a different picture from the top. The arena and the HUD use different tilemaps, tile bases, layers, and scroll positions, and the scene reprograms the PPU (the picture processor) partway down the screen to switch between them. A horizontal-blank interrupt (an IRQ, set to fire on a given scanline) stops the CPU at that line, and its handler rewrites the registers in the short gap before the next line is drawn. The scene installs five, through the IRQ engine ([Chapter 29](29-sprites-and-scanlines.md)):

```
  line   0  +--------------------------------------------+  display off: black band
  line  14  +--------------------------------------------+  IRQ 1: display on, at the fade's brightness
            |  the arena: BG2 background, BG1 foreground |
            |  combatants, effects; scrolled by camera   |
  line 126  +--------------------------------------------+  IRQ 2: switch to the HUD's tilemaps,
            |  HUD: names, weapons, HP, stats            |  tiles, layers, and scroll
  line 156  +--------------------------------------------+  IRQ 3: split within the HUD (some layouts)
  line 161  +--------------------------------------------+  IRQ 4: split within the HUD (one layout)
  line 207  +--------------------------------------------+  IRQ 5: display off: black band
  line 224  +--------------------------------------------+
```

IRQ 2 turns the display off for an instant, switches the main screen to BG2 and BG3, points them at the HUD's tilemap and tiles, sets their scroll, rewrites a few colors, and turns the display back on. `bBattleSceneBG3Mode` (`$7F/E4C2`, modes 0–4+) picks one of four HUD layouts in IRQ 2, with IRQ 3 running in modes 1 and 3 and IRQ 4 only in mode 1. A critical hit shakes only the HUD: the shake changes the scroll values IRQ 2 writes (`$7F/FC73`–`$7F/FC76`, from `aBattleSceneHUDShakeOffsets`), so the arena above stays still.

### The frame

The scene's frame runs from its VBlank routine, after the uploads, the same way the map's does ([the introduction](00-introduction.md)). `rsBattleSceneRunFrame` ([engine/battle_scene/scene.asm](../../engine/battle_scene/scene.asm)):

```rust
fn battle_scene_frame() -> bool {              // rsBattleSceneRunFrame
    run_intro_steps();                         // fade in, opening script, wait
    update_fade();
    if round_may_run() {
        run_move_queues();                     // rlBattleAnimationRunMoveQueue
        run_rounds();                          // rlBattleSceneRunRounds
    }
    move_combatants_and_effects();             // X, gravity, jumps, Y; slots $00, $43, $86, $C9
    run_sequences_and_draw();                  // rlBattleAnimationUpdateAll
    run_scene_script();                        // rlRunBattleSceneScript
    run_palette_effects_flash_shake_hp();
    wait_until_flag_set(0x7FE1CF);             // set by IRQ 2 at line 126
    build_bg2_scroll_tables();                 // per-line scroll and perspective for the arena
    check_arena_and_end_steps();
    fade_out_finished()
}
```

The arena's BG2 scroll is changed on every scanline by HDMA, from tables the frame rebuilds. VBlank clears the flag at `$7F/E1CF`, and IRQ 2 sets it once the arena has been drawn. Waiting on the flag means a table is never rewritten while the lines it controls are on their way to the screen.

### Uploading in pieces

Decompressed graphics for poses, spells, and backgrounds would often need more than one VBlank to copy. The scene queues copies to video RAM in a 16-entry list (`aBattleSceneUploads`), and each VBlank `rlBattleSceneRunUploads` sends queued entries up to `$0C00` bytes, leaving the rest for the next frame. A copy too big for the queue goes through `rlBattleSceneStartLargeUpload`, which feeds the queue one slice per frame.

## Setting the stage

`rlBattleSceneInit` copies each side's class, character, weapon, HP, maximum HP, gender, terrain, and experience from the action structs into `aBattleSceneCombatant1` and `aBattleSceneCombatant2`, and loads the stage.

### Background and foreground

The background shows the defender's terrain, or the attacker's for a dance and for placements 0 and 1 (below). `rlGetBattleBackgroundPointers` maps the terrain to one of 24 backgrounds in `aBattleBackgrounds` ([engine/battle_scene/backgrounds.asm](../../engine/battle_scene/backgrounds.asm)). In Chapter 4 it uses a second mapping that picks the snowy versions. A snowy background is the same tiles and tilemap with a different palette, and so is Desert, which reuses Sand's. A class change ignores terrain and uses background `$17`.

A foreground goes on BG1 when `aBattleForegroundTerrainPairs` has an entry for the attacker's and defender's terrains, Chapter 4 again having its own set. Bows, tomes, and staves get no foreground (`aBattleSceneNoForegroundList`).

### Placing the combatants

The two start apart by twice a distance in the combatant's body record (below), or by `$C8` pixels for a magic sword used at range and `$E0` for a staff used from two tiles away. The first striker's weapon can then change the layout (`aBattleSceneWeaponPlacements`):

| Placement | Weapons | Layout |
|---|---|---|
| 0 | Meteor, Bolting, Blizzard, Fenrir, the ballistae; Physic, Restore, Silence, Sleep, and Berserk from 3 or more tiles away | The striker alone at the center; the target hidden |
| 1 | Fortify | Both at the center |
| 2 | Rescue, Valkyrie | The target hidden until a script shows it |
| 3 | Any weapon in a class change | The unit at the center; the other side hidden |
| 4 | The magic and status swords | No change |

A dance (action `$08` in unit 1's action struct) puts both at the center and gives a Dancer its dance animations.

### Choosing animations

Each weapon has an animation category and an **attack style**: sword, lance, axe, ranged, magic, or staff. A javelin or hand axe used from two tiles away becomes ranged. The class, the category, and the style select four animation IDs from `aBattleAnimationLookup`. A few named characters also get three colors of their own over sprite colors 12–14.

## Playing the rounds

### Reading an entry

`rlBattleSceneRunRounds` ([engine/battle_scene/rounds.asm](../../engine/battle_scene/rounds.asm)) waits until both combatants' move queues are empty and nothing is moving. Then `rsBattleSceneStartNextRound` reads one entry of the round log:

- **A strike** (low byte flags, high byte damage). It sets who attacks and who defends, pans the camera if the attacker is off center, and queues the attacker's action for its attack style: a normal attack, a critical, a fatal critical, or a staff. A combatant too far away first closes in.
- **A skill** (`$xxFE`). It shows the skill's banner: scripts `$36`–`$3A` for Astra, Luna, Sol, Holy, and Darkness, and `$3F` for Pavise.
- **`$FEFF`**, the end of an arena bout: back to the first round for another bout, unless the player held B to retreat ([Chapter 16](16-the-arena.md)).
- **`$FFFF`**, the end.

At a combatant's first round with a holy weapon (Tyrfing, Gungnir, and the rest through the Valkyrie Staff), the reader first plays script `$43` and sound `$90`. Before reading an entry it checks the previous one, and after a fatal strike it marks the fight as over (bit 7 of `bBattleSceneStrikeFlags`) and reads no further.

Magic swords take one more decision. The Berserk, Silence, and Sleep Swords start their weapon's script at once. Any other magic sword striking from range queues a swing and then the spell. Tomes, staves, and magic swords each name a script in `aBattleSceneWeaponScripts`, and the four long-range staves name a second one for use from three or more tiles away. The attacker's sequence starts that script with command `$F0`.

### When the strike lands

The round log gives no timing. The strike lands when the attacker's sequence reaches command `$F1`, when a projectile reaches the defender, or when a spell's script issues `$FFFA`. All three call `rlBattleSceneApplyStrike`:

```rust
fn apply_strike(round: RoundEntry) {                 // rlBattleSceneApplyStrike
    if round.damage > 0 {
        defender.hp_target = defender.hp - round.damage; // falls one point a frame
        start_damage_flash(defender, 25);            // frames
    }
    defender.knockback = 0x0762 / class_weight(defender.class);  // aBattleSceneClassWeights
    play_hit_sound(round);                           // $91-$94, $95 for no damage; +$50 critical
    if round.critical { start_hud_shake(); }
    if attacker.weapon == EarthSword || sol_active() {
        start_drain(attacker, round.damage);         // the attacker regains it
    }
}
```

HP is held as an 8.8 fixed-point number (`structBattleSceneCombatant.HP`). Each frame the HP routines move it toward its target, redraw the number and bar, and play sound `$0D` for every whole point. The knockback pushes the defender away by a strength that loses a quarter each frame, then shakes it sideways for 24 frames. The heavier the class, the shorter the push. Script command `$FFFB` starts a heal in place of a strike.

## The animation slots

[engine/battle_scene/combatants.asm](../../engine/battle_scene/combatants.asm) keeps four slots of `$43` bytes from `$0AF3`, with a fifth record used to build projectiles:

```
  $0AF3 + $00   combatant 1         $0AF3 + $86   combatant 1's effect (arrow, axe, spell)
  $0AF3 + $43   combatant 2         $0AF3 + $C9   combatant 2's effect
  $0BFF         spawn record: a new effect is built here, then copied into its slot
```

### Moves

An **action** is an entry in the class's move program ([engine/battle_scene/animations.asm](../../engine/battle_scene/animations.asm)): a list of moves or a single sequence. The moves wait in a 16-entry queue per combatant (`aBattleSceneMoveQueues`) and run one at a time when the combatant stands ready. The move routines in [engine/battle_scene/animation_moves.asm](../../engine/battle_scene/animation_moves.asm) walk, leap, and retreat. A combatant stops against the other's body or the edge of the stage. The camera follows the midpoint of the two combatants, or the attacker alone. A missed strike queues a dodge for the defender.

Each combatant has an 8-byte **body record**, chosen by class and weapon category: its width, the height projectiles aim at and fly from, the distance it keeps from the other side, two speeds, and half its starting distance.

### Sequences

A **sequence** is a list of poses, each with a delay, and of commands `$E8`–`$FF` ([include/BattleAnimation.h](../../include/BattleAnimation.h)). The delays are scaled by the slot's 8.8 speed multiplier. Some of the commands:

| Command | Does |
|---|---|
| `$F0` | Start the weapon's scene script |
| `$F1` | Land the strike |
| `$F4` | Freeze until released |
| `$F3` | Release the other side |
| `$EF` | Launch the effect slot |
| `$EC` | Start an afterimage, or a mirrored double |

Freezing and releasing are how the two sides stay in step. A defender can wait at `$F4` until the attacker's swing (`$F3`) or its projectile (on landing) releases it, and a script can release either side with `$FFFD` or `$FFFC`.

A new pose queues its tiles for upload. Shadows are drawn under each visible combatant on alternate frames. On river or sea terrain, the footstep sounds `$11`–`$19` become splashes `$21`–`$29`.

### Projectiles

Command `$EF` builds the effect in the spawn record from a template, places it at the thrower plus an offset for its class (one list each for bows, hand axes, and javelins), aims it at the defender's height from the body record, and copies it into slot `$86` or `$C9`. Each frame the slot moves by one of three motions, chosen by attack style and weapon: straight flight under gravity, with a pose chosen by its slope; a table of positions (`aBattleAnimationEffectPaths`); or a small path script with commands `$8080`–`$8085`. Reaching the defender lands the strike. Afterimages draw the owner's pose as it was 8 or 12 frames earlier, and the mirrored double draws the slot reflected around the defender on odd frames.

## The battle scene script

The scene's third engine runs scripts that stage spells and every other screen effect ([engine/battle_scene/script.asm](../../engine/battle_scene/script.asm)). It is the game's third bytecode, after event scripts ([Chapter 12](12-screenplays.md)) and proc scripts. A script is a list of 16-bit words:

```
   15  14  13 ........ 9  8 ................ 0
  +---+---+-------------+--------------------+
  | 0 | W |   command   |      argument      |   command 0-24; W: wait until it finishes
  +---+---+-------------+--------------------+
  $FFF8-$FFFF: control words
```

The 25 commands (`aBattleSceneCommandHandlers`) cover the stage: decompress graphics to video RAM, copy, write values into RAM, load a background, a portrait, or colors, start a palette effect, a window effect, an HDMA scroll effect, or a BG2 shake, scroll the camera to a combatant, play a sound (optionally panned to a combatant or its opponent), and wait. Three commands run routines from a table of 72 (`aBattleSceneScriptRoutines`): once, every frame until the routine reports it is done, or every frame from then on. The control words end the script (`$FFFF`), stop for the frame (`$FFFE`), release a combatant (`$FFFD`, `$FFFC`), heal (`$FFFB`), land a strike (`$FFFA`), start hit-effect sprites or a dodge (`$FFF9`), or drain (`$FFF8`).

```rust
fn run_script_word(word: u16) {                  // rlRunBattleSceneScript
    match word {
        0xFFFF => end_script(),
        0xFFFE => stop_for_frame(),
        0xFFFD | 0xFFFC => release_combatant(word),
        0xFFFB => rlBattleSceneStartHeal(),
        0xFFFA => rlBattleSceneApplyStrike(),
        0xFFF9 => rsBattleSceneControlDodgeIfMissed(),
        0xFFF8 => rlBattleSceneStartDrain(),
        _ => {
            let command = (word >> 9) & 0x1F;
            let argument = word & 0x01FF;
            let wait = word & 0x4000 != 0;
            run_command(command, argument, wait); // aBattleSceneCommandHandlers
        }
    }
}
```

Each frame the interpreter counts down its wait timers, holds while a command it waits on is unfinished, runs any leading control words (`$FFF8`–`$FFFD`), and then runs one command (or stops on `$FFFE`/`$FFFF`). Holding A clears the skippable wait timer, so some pauses can be cut short.

### Palette effects

Command 11 starts an entry of `aBattleScenePaletteEffects` in one of ten slots (`aBattleScenePaletteSlots`). Each frame `rlBattleSceneRunPaletteEffects` ([engine/battle_scene/effects.asm](../../engine/battle_scene/effects.asm)) changes a range of colors in the palette buffer by the slot's type:

| Type | Does |
|---|---|
| 0 | Plays frames of colors, with optional delays; `$FE` loops and `$FF` ends |
| 1, 2 | Scrolls the colors down or up one place, bringing in the next color from the data |
| 3, 4 | Rotates the colors down or up every few frames |
| 5, 6 | Fades a step at a time to black or white |
| 7 | Fades a step at a time toward the colors in the data |
| 8, 9 | Sets black or white |
| 10 | Sets the colors in the data |
| 11 | Restores the saved palette |
| 12 | As type 1, with each new color brightened |

A slot can count down the script's wait when it ends, so a script can wait for a flash to finish. The map battle borrows this engine for its skill effects ([Chapter 23](23-two-ways-to-show-a-fight.md)), and the title screen for its own ([Chapter 20](20-the-opening.md)).

## The HUD

[engine/battle_scene/hud.asm](../../engine/battle_scene/hud.asm) builds the bottom panel once, during setup, into two tilemaps in work RAM (`$7F/C800` and `$7F/D0C0`). It holds each side's HP with its bar, level, hit, might, and defense (a 255 shows as two dashes), the army's color and banner, and the unit's and weapon's names. The names are drawn with the text font into tiles of their own at setup. During the fight only the HP rows change, and they are queued for upload every frame.

One **gauge** engine (`wBattleSceneGaugeValue` at `$7F/ED4B`) counts a number toward a target at an 8.8 speed and draws it with a bar. It serves two displays:

- **The experience bar** counts from the unit's experience to that plus the gain, with sound `$0B`, wrapping past 100, and plays `$0C` when it stops.
- **The level-up window** draws nine gauges, the level and eight stats, and fills each stat that rose. HP's bar holds 80 points and the others 30.

## The end steps

When the rounds are over, `rlBattleSceneRunEndStep` ([engine/battle_scene/scene.asm](../../engine/battle_scene/scene.asm), dispatching handlers in [results.asm](../../engine/battle_scene/results.asm) via `aBattleSceneEndSteps` in [data.asm](../../engine/battle_scene/data.asm)) works through the 21 entries, last to first, starting the next one whenever nothing else is running. Most start a scene script:

1. Show BG3.
2. For a class change, script `$33`; after a fatal strike, script `$34`.
3. The death quote.
4. The defeated unit's cry (`$89`–`$8B`, by voice) and defeat script `$31`.
5. The experience bar, and a level up: its banner (`$3B`) and the stat gains.
6. For a class change, the closing script `$35`.
7. The message window (`$2A`), and each message: gold obtained or stolen (`$2F`), an item obtained (`$2C`), a weapon broken (`$44`), followed by a button wait (`$30`). The messages run through the dialogue engine ([Chapter 13](13-dialogue-and-text.md)), drawn into the scene's BG3.
8. Julius's scripts when the fight ends with his defeat (`$4B`/`$3D`, `$4C`, and his death quote `$4A`).
9. The fade out.

Julius's defeat is noticed at the moment of the strike. A fatal blow by unit 1 on `JuliusChFinal` slows the fade, fades the music, and sets the flag that returns to the map in mode 3. His death quote is shown through `rlBattleSceneShowJuliusQuote` in place of the normal one.

## Trade-offs and hard limits

- **Upload budget.** At most `$0C00` bytes reach video RAM per frame through the queue, which holds 16 copies. Anything larger is fed in slices, so big graphics arrive over several frames.
- **Fixed slots.** Two combatants, two projectiles, ten palette effects, and 16 queued moves per combatant.
- **Shared work RAM.** The scene's variables at `$7F/E000`–`$7F/FFFF` occupy the same addresses as the map's text buffer and unit buffers. The scene overwrites them, and the map rebuilds its display when the scene returns.
- **The background follows one side.** Only one terrain's background is drawn, the defender's in most fights.
- **Two oddities.** `rsBattleSceneStartNextRound` loads the round's ranged bit for `bBattleSceneRanged` but branches past the store, so the variable never holds it. `rlBattleAnimationGetEffectArcHeight` reads the defender's height using an offset meant for the slots on combatant 1's record, a different byte; what that changes on screen isn't known.

## Where it lives in the source

- [engine/battle/battle.asm](../../engine/battle/battle.asm): `rlStartBattleScene`.
- [engine/battle_scene/battle_screen.asm](../../engine/battle_scene/battle_screen.asm): `rsOpenBattleScene`, the scene's VBlank and main loop, and the window wipe.
- [engine/battle_scene/scene.asm](../../engine/battle_scene/scene.asm): `rlBattleSceneInit`, `rsBattleSceneRunFrame`, `rlBattleSceneRunEndStep`, the scene's flags, the fade, and the intro.
- [engine/battle_scene/screen.asm](../../engine/battle_scene/screen.asm): the five IRQs, the HDMA tables, and the VBlank work.
- [engine/battle_scene/loading.asm](../../engine/battle_scene/loading.asm) and [backgrounds.asm](../../engine/battle_scene/backgrounds.asm): graphics, backgrounds, foregrounds, and placement.
- [engine/battle_scene/rounds.asm](../../engine/battle_scene/rounds.asm): reading the rounds and landing a strike.
- [engine/battle_scene/combatants.asm](../../engine/battle_scene/combatants.asm), [animation_moves.asm](../../engine/battle_scene/animation_moves.asm), and [animations.asm](../../engine/battle_scene/animations.asm): the animation slots, moves, sequences, projectiles, and each class's animation data.
- [engine/battle_scene/script.asm](../../engine/battle_scene/script.asm), [effects.asm](../../engine/battle_scene/effects.asm), and [data.asm](../../engine/battle_scene/data.asm): the scene script, its effects, and its tables.
- [engine/battle_scene/hud.asm](../../engine/battle_scene/hud.asm) and [results.asm](../../engine/battle_scene/results.asm): the HUD, the gauge, and the end steps.
- [include/BattleScene.h](../../include/BattleScene.h) and [include/BattleAnimation.h](../../include/BattleAnimation.h): structures, flags, and sequence commands.
- [docs/reference/battle_scene.md](../reference/battle_scene.md): the reference page.

---

← Previous: [Chapter 23: Two Ways to Show a Fight](23-two-ways-to-show-a-fight.md) | [Contents](OUTLINE.md) | Next: [Chapter 25: Full-Screen Windows and the Status Screen](25-full-screen-windows-and-the-status-screen.md) →
