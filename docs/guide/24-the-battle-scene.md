# Chapter 24: The battle scene

When battle animations are enabled—or when a signature duel like Naga, Loptous, the Valkyrie Staff, an arena bout, or a class change requires full spectacle—the game leaves the chapter map behind and hands the entire SNES display to the battle scene. Two full-size combatants stand on terrain-matched parallax backgrounds with foreground foliage, spell polygons, palette animations, a dynamic camera, battle quotes, a bottom HUD with HP bars and combat stats, and an end-of-fight sequence for experience, level-ups, and item drops. All of it must fit inside 64 KB of VRAM and run at 60 frames per second.

This chapter covers how the battle scene takes over the screen, how it structures its five-IRQ frame and `$0C00`-byte VBlank upload budget, how it loads backgrounds and places combatants, how it reads rounds and resolves strike physics, how the four animation slots and sequence programs drive motion, how the battle scene script bytecode and palette engine stage spells, and how the HUD, gauges, and 21 end steps close the fight.

## Entry, transition, and screen architecture

From the map, starting a battle scene stops the music and picks a transition by `wBattleType`. Normal battles (`0`) launch an indirect HDMA window wipe (`aBattleTransitionHDMAInfo`) that alternates between two 240-line `WH0` buffers each frame, closing the screen shut along the jagged contour in `aBattleTransitionShape` before installing the scene opener. Arena bouts (`1`), class changes (`2`), and castle battles (`3`) fade out through `procMainLoopChangeFade` instead, while the opening attract-mode demo enters the scene opener directly.

The opener (`rsOpenBattleScene` in [engine/battle_scene/battle_screen.asm](../../engine/battle_scene/battle_screen.asm)) resets the active sprite, HDMA, and IRQ engines, clears the four animation slots, installs five mid-frame IRQ splits, and sets game state `$18` (`rlBattleSceneSetup`) with the scene's own VBlank and main-loop handlers.

The five IRQs carve the 224-line frame into a letterboxed arena on top and a multi-band HUD on the bottom:

```
  Scanline  0 +----------------------------------------------+  Forced blank (top letterbox)
  IRQ 1 (14)  +----------------------------------------------+  rlBattleSceneHBlankApplyINIDISP
              |  Arena: background, foreground, combatants   |  Camera pans BG2/BG3
              |  (camera tracks midpoint or active striker)  |
  IRQ 2 (126) +----------------------------------------------+  Switch to HUD mode; set $7FE1CF = 1
              |  Upper HUD ($7F/C800, $7F/D0C0)              |  Independent HUD BG2/BG3 scroll
  IRQ 3 (156) +----------------------------------------------+  Mid-HUD split (HUD modes 1 and 3)
  IRQ 4 (161) +----------------------------------------------+  Lower-HUD split (HUD mode 1)
  IRQ 5 (207) +----------------------------------------------+  rlBattleSceneHBlankForceBlank (bottom letterbox)
```

Once setup blanks the screen once, game state `$19` executes the scene frame loop until the closing fade finishes (`bBattleSceneFade == $40` at brightness `0`):

```rust
fn battle_scene_frame() -> bool { // rsBattleSceneRunFrame
    run_intro_steps();            // fade in, opening script, wait for BattleSceneRoundMayRun
    update_brightness_and_fade();

    if bBattleSceneRoundState & BattleSceneRoundMayRun != 0 {
        rlBattleAnimationRunMoveQueue();
        rlBattleSceneRunRounds(); // advance aBattleRoundsData when queues are idle
    }

    step_combatant_physics();     // X, gravity, jump, Y for slots $00/$43 and effects $86/$C9
    rlBattleAnimationUpdateAll(); // sequence scripts and sprite drawing
    rlRunBattleSceneScript();     // spell/camera/window bytecode
    run_effects_and_camera();     // palette slots, camera tracking, HP bar drain (1 pt/frame)

    wait_for_vblank();            // polls $7FE1CF cleared by VBlank
    build_hdma_tables();
    check_arena_and_end_steps();  // B-retreat, arena next bout ($FEFF), or 21 end steps
    fade_finished()
}
```

### The VBlank upload queue

Decompressing battle sheets, backgrounds, and spell frames produces more bytes than a single 2.3 ms VBlank can transfer. The scene therefore routes VRAM writes through a 16-slot queue (`aBattleSceneUploads`). Each VBlank, the uploader sends queued entries up to a hard cap of `$0C00` (3,072) bytes and leaves the rest for the next frame; oversized graphics go through a chunked feeder (`rlBattleSceneStartLargeUpload`) that pushes one slice per frame.

## Backgrounds, foregrounds, and placement

During initialization, `rlBattleSceneInit` ([engine/battle_scene/scene.asm](../../engine/battle_scene/scene.asm)) configures Mode 1 with BG3 priority, copies both action structs into `aBattleSceneCombatant1`/`2`, and loads the stage:

1. **Terrain backgrounds and snow variants:** Each combatant's terrain indexes `aBattleBackgroundTerrainIndices` ([engine/battle_scene/backgrounds.asm](../../engine/battle_scene/backgrounds.asm)). In Chapter 4, the loader adds 26 to pick the snowy versions (`PlainsSnow`, `ForestSnow`, `CastleSnow`, and so on). When `wBattleType == 2` (class change), the loader ignores terrain and selects background `$17`.
2. **Foreground layers:** `rsBattleSceneGetForeground` scans `aBattleForegroundTerrainPairs` for matching attacker/defender terrain pairs (such as forest or village edges) and loads two foreground tilemaps over the arena.
3. **Combatant sheets and character accents:** Each unit's weapon, extra tiles, class sheet, and palette are decompressed, and selected named characters overwrite sprite colors 12–14 with personal accent colors.
4. **Placement modes:** The starting gap between combatants defaults to twice byte 6 of the body record (`$C8` for ranged magic swords, `$E0` for distance-2 staves), then the first striker's weapon can override placement via `aBattleSceneWeaponPlacements`:

| Mode | Weapons | Stage layout |
|---|---|---|
| `0` | Meteor, Bolting, Blizzard, Fenrir, ballistae; ranged Physic, Restore, Silence, Sleep, Berserk | Striker centered alone; target hidden (`bBattleAnimationCombatantFlags` bit 6) |
| `1` | Fortify | Both centered (`BattleSceneFlagSolo2`) |
| `2` | Rescue, Valkyrie | Target hidden until revealed by script |
| `3` | Class change (`wBattleType == 2`), any weapon | Old class centered; other side hidden |
| `4` | Magic and status swords | Default gap (no override) |

For a Dancer's refresh (`wActionStructUnit1` action `$08`), the scene sets `BattleSceneFlagDance` and `BattleSceneFlagSolo2`, centers both units, and assigns the Dancer's dedicated animation IDs.

## Reading rounds and strike physics

While `BattleSceneRoundMayRun` is set and both move queues are idle, `rsBattleSceneStartNextRound` ([engine/battle_scene/rounds.asm](../../engine/battle_scene/rounds.asm)) reads the next 16-bit entry from `aBattleRoundsData`:

| Entry | Meaning |
|---|---|
| Low byte `bBattleRoundFlags`, high byte damage | Strike: bit `0` side (`0` attacker, `1` defender), `$02` staff, `$04` critical, `$08` miss, `$10` fatal, `$20` ranged, `$40` magic |
| `$xxFE` | Skill activation: high byte is `SkillID` (`Astra`, `Luna`, `Sol`, `Holy`, `Darkness`, `Pavise`) |
| `$xxFD` | Skipped entry |
| `$FEFF` | End of an arena bout; loops back to round 0 unless B was held (`BattleSceneRoundArenaRetreat`) |
| `$FFFF` | End of rounds |

Before a combatant's first round with a holy weapon (`Tyrfing`, `Gungnir`, ..., `ValkyrieStaff`), the scene plays script `$43` and sound `$90`. For a skill entry (`$xxFE`), it plays the corresponding banner script (`$36`–`$3A` or `$3F`). After any fatal strike (`$10`), the reader sets bit 7 of `bBattleSceneStrikeFlags` and stops reading further entries.

Each strike selects an action ID from `aBattleSceneAttackActions` using the weapon's `AnimStyle` (`Sword`, `Lance`, `Axe`, `Ranged`, `Magic`, `Staff`—with javelins and hand axes switching to `AttackStyleRanged` at distance 2 or more) and the combatant's variant bits. Magic swords branch by type: status swords launch their weapon script immediately, while elemental magic swords queue a physical swing followed by a spell.

A strike lands when the attacker's sequence hits `ANIM_CMD_F1` or a scene script executes `$FFFA`:

```rust
fn apply_strike(defender: &mut Combatant, round: RoundEntry) { // rlBattleSceneApplyStrike
    defender.hp_target = defender.hp_whole.saturating_sub(round.damage);
    defender.hp_speed = -1.0;                                // 8.8 fixed-point: 1 HP per frame
    defender.damage_flash_timer = 25;                        // 25 frames of white flash

    // Knockback velocity scales inversely with class weight, then decays by 3/4 each frame
    let weight = aBattleSceneClassWeights[defender.class];
    defender.knockback_velocity = 0x0762 / weight;           // followed by $18 frames of shake

    let pan = sound_pan(defender.screen_x);
    let sfx = if round.damage == 0 { 0x95 } else { 0x91 + hit_kind };
    play_sound(sfx + if round.is_critical { 0x50 } else { 0 }, pan);

    if attacker.weapon == EarthSword || active_skill == Sol {
        rlBattleSceneStartDrain();                           // attacker regains dealt damage
    }
}
```

HP is stored in 8.8 fixed-point (`structBattleSceneCombatant.HP`), so the HUD updater ticks the number and bar smoothly each frame, chiming sound `$0D` for every whole point lost or healed (`$FFFB` heals instead of damaging).

## The four animation slots and sequence programs

[engine/battle_scene/combatants.asm](../../engine/battle_scene/combatants.asm) manages four `$43`-byte animation slots starting at `$0AF3`, plus a fifth `$0BFF` spawn template used to initialize projectiles:

```
  $0AF3 + $00 : Combatant 1 (main unit)      <--->  $0AF3 + $86 : Combatant 1 Effect (arrow/axe/spell)
  $0AF3 + $43 : Combatant 2 (main unit)      <--->  $0AF3 + $C9 : Combatant 2 Effect (arrow/axe/spell)
                                                       ^
                                                       | copied from $0BFF spawn template on ANIM_CMD_EF
```

Each slot runs two layered engines:

- **Move queues (`aBattleSceneMoveQueues`, 16 entries per combatant):** Queuing an action pushes a class's move program from [engine/battle_scene/animations.asm](../../engine/battle_scene/animations.asm), and [engine/battle_scene/animation_moves.asm](../../engine/battle_scene/animation_moves.asm) steps through approaches, leaps, and retreats while collision checks stop combatants from overlapping. The camera tracks either the midpoint of both units or the attacker alone.
- **Sequence scripts:** The sequence interpreter reads pose indices and control opcodes `$E8`–`$FF` ([include/BattleAnimation.h](../../include/BattleAnimation.h)). Pose delays scale by an 8.8 speed multiplier, and whenever a pose changes, the renderer queues its tile rows for VBlank. Command `$F4` freezes a combatant until the opposite side or its effect slot sends a release signal (`$F3`). Command `$EF` spawns the projectile in the effect slot (`rlBattleAnimationSetEffectMotion`), which flies by straight gravity, a coordinate table, or a path script (`$8080`–`$8085`). Command `$EC` spawns afterimages (drawn 8 or 12 frames behind) or odd-frame mirrored illusions.

Each combatant also references an 8-byte body record (width, aim/launch height, minimum gap, two speeds, and half-start distance), and shadows are drawn on alternate frames under each visible combatant's ground position. On river or sea terrain, footstep sounds `$11`–`$19` automatically switch to water splashes (`$21`–`$29`).

## The battle scene script bytecode and palette effects

While animation slots move sprites, [engine/battle_scene/script.asm](../../engine/battle_scene/script.asm) runs a third bytecode engine (alongside event scripts and proc scripts) to orchestrate backgrounds, spell polygons, mosaic/wave window effects, screen shakes, and sound cues. Every instruction is a 16-bit word:

```
  15   14   13        9   8                   0
 +----+----+-----------+-----------------------+
 | 0  |Wait|  Command  |     9-bit Argument    |   Normal command (0..24)
 +----+----+-----------+-----------------------+
 | 1  | 1  | 1  1  1  1  1  1  1  1 | Control  |   $FFF8..$FFFF control word
 +----+----+-----------+-----------------------+
```

```rust
fn run_battle_scene_script_word(word: u16) { // rlRunBattleSceneScript
    if word >= 0xFFF8 {
        match word {
            0xFFFF => stop_script(),
            0xFFFE => yield_frame(),
            0xFFFB => rlBattleSceneStartHeal(),
            0xFFFA => rlBattleSceneApplyStrike(),
            0xFFF8 => if !missed { rlBattleSceneStartDrain() },
            _ => {}
        }
        return;
    }

    let cmd = (word & 0x3E00) >> 9;          // 25 handlers in aBattleSceneCommandHandlers
    let arg = word & 0x01FF;                 // 9-bit argument
    let wait = (word & 0x4000) != 0;         // stall script until operation finishes
    dispatch_command(cmd, arg, wait);
}
```

Commands `4`, `5`, and `8` index into 72 long pointers in `aBattleSceneScriptRoutines` ([engine/battle_scene/data.asm](../../engine/battle_scene/data.asm)) to call a helper once, poll it every frame until bit 0 of `$7F/E4B7` clears, or install it as a persistent per-frame callback.

### Palette effects

Command `11` launches entries from `aBattleScenePaletteEffects` into ten slots (`aBattleScenePaletteSlots` at `$7F/FD9A`). Each frame, `rlBattleSceneRunPaletteEffects` ([engine/battle_scene/effects.asm](../../engine/battle_scene/effects.asm)) mutates `aBGPaletteBuffer` according to one of 13 effect types:

| Type | Behavior |
|---|---|
| `0` | Plays a sequence of color frames (`$80 \| delay` optional; `$FE` loops, `$FF` ends) |
| `1`, `2` | Scrolls colors down (`1`) or up (`2`) by one slot, shifting in the next color from data |
| `3`, `4` | Rotates the color range down (`3`) or up (`4`) every `Value` frames |
| `5`, `6` | Fades a step at a time toward black (`5`) or white (`6`) |
| `7` | Fades a step at a time toward target colors in data |
| `8`, `9` | Sets the range immediately to black (`8`) or white (`9`) |
| `10` | Copies target colors immediately from data |
| `11` | Restores the saved palette from `$7F/FE00` |
| `12` | Scrolls like type `1`, brightened by `wBattleScenePaletteBrighten` steps |

## The HUD, gauges, and the 21 end steps

[engine/battle_scene/hud.asm](../../engine/battle_scene/hud.asm) builds the bottom panel once during initialization into `$7F/C800` (VRAM `$D000`) and `$7F/D0C0` (VRAM `$D8C0`). It renders ten combat stats (`CurrentHP`, `Level`, `BattleAdjustedHit`, `BattleMight`, `BattleDefense` for each side, printing `255` as `--`), applies faction colors and banners, and pre-renders unit and weapon names into 2bpp tiles at `$7E/AC88` (VRAM `$F800`). On a critical hit, `rlBattleSceneStartHUDShake` shakes only the bottom split by feeding `aBattleSceneHUDShakeOffsets` into the IRQ scroll registers (`$7F/FC73`–`$7F/FC76`).

A single shared 8.8 gauge engine at `$7F/ED4B` (`wBattleSceneGaugeValue`...) drives both post-battle progress displays:

- **Experience bar (script `0`):** Counts from `wBattleSceneExperience` to `wBattleSceneExperience + wBattleSceneExperienceGained` while playing sound `$0B`, wrapping past 100 and chiming `$0C` when it stops.
- **Level-up window (script `1`):** Draws all nine gauges of `aBattleSceneLevelUpGauges` (level and eight stats, capped at 80 for HP and 30 for all other stats) and fills each gained stat.

Once the round log ends, `rlBattleSceneRunEndStep` ([engine/battle_scene/results.asm](../../engine/battle_scene/results.asm)) walks the 21 entries of `aBattleSceneEndSteps` in reverse order whenever nothing else is active: revealing BG3, playing class-change scripts (`$33`/`$35` when `wBattleType == 2`) or fatal defeat scripts (`$34`/`$31`) with voice-indexed defeat cries (`$89`–`$8B`), displaying the death quote, running the experience bar and level-up window, opening the message window (`$2A`) for obtained items (`$2C`), gold (`$2F`), and broken weapons (`$44`) via the dialogue engine, running Julius's finale scripts (`$4A`–`$4C` when combatant 1 defeats `JuliusChFinal`, switching to map mode 3), and fading out.

## Trade-offs and hard limits

Separating the battle scene into its own game state with dedicated IRQ splits and a 4-slot animator lets the game render large, multi-part sprites and full-screen spells that would never fit alongside the map, at the cost of strict resource budgets:

- **VBlank upload cap (`$0C00` bytes/frame):** Oversized transfers must be chunked across frames, and `aBattleSceneUploads` holds at most 16 pending copies.
- **Fixed slot counts:** 4 animation slots (2 combatants + 2 effects), 10 palette effect slots, and 16-entry move queues.
- **Shared WRAM (`$7F/E000`–`$7F/FFFF`):** The battle scene's working RAM overlaps the map's text and unit buffers, so entering a battle scene requires a full screen transition rather than an instant overlay.
- **Engine quirks:** `bBattleSceneRanged` is read but never stored in `rsBattleSceneStartNextRound` (the branch skips the store), and `rlBattleAnimationGetEffectArcHeight` indexes `aBattleSceneCombatant1` with `X = $0E` instead of the animation slot offset.

## Where it lives in the source

- [engine/battle_scene/battle_screen.asm](../../engine/battle_scene/battle_screen.asm): `rsOpenBattleScene`, `rsRunBattleSceneVBlank`, `rsRunBattleSceneMainLoop`, and `aBattleTransitionHDMAInfo`.
- [engine/battle_scene/scene.asm](../../engine/battle_scene/scene.asm) and [screen.asm](../../engine/battle_scene/screen.asm): `rlBattleSceneInit`, `rsBattleSceneRunFrame`, IRQs (`aBattleSceneIRQ1Setup`–`5Setup`), HDMA tables, and VBlank uploads.
- [engine/battle_scene/rounds.asm](../../engine/battle_scene/rounds.asm) and [results.asm](../../engine/battle_scene/results.asm): `aBattleRoundsData` playback, `rlBattleSceneApplyStrike`, and the 21 end steps.
- [engine/battle_scene/combatants.asm](../../engine/battle_scene/combatants.asm), [animation_moves.asm](../../engine/battle_scene/animation_moves.asm), and [animations.asm](../../engine/battle_scene/animations.asm): the four animation slots, sequence interpreter, move routines, and class animation data.
- [engine/battle_scene/script.asm](../../engine/battle_scene/script.asm), [effects.asm](../../engine/battle_scene/effects.asm), and [data.asm](../../engine/battle_scene/data.asm): the battle scene bytecode, palette effects, window/HDMA effects, and bank `$97`–`$99`/`$E0` tables.
- [engine/battle_scene/loading.asm](../../engine/battle_scene/loading.asm), [backgrounds.asm](../../engine/battle_scene/backgrounds.asm), and [hud.asm](../../engine/battle_scene/hud.asm): graphics/terrain loading and the bottom HUD and gauges.
- [engine/castle/class_change.asm](../../engine/castle/class_change.asm): `rlStartCastleClassChange`, which launches the scene with `wBattleType == 2`.
- [docs/reference/battle_scene.md](../reference/battle_scene.md): full reference for the battle scene.
