# Chapter 23: Two Ways to Show a Fight

The battle calculation of [Chapter 6](06-resolving-a-battle.md) settles a fight completely before anything is drawn. It decides every strike, miss, critical, and skill, and commits the results to the units: HP, weapon uses, kills, experience, level-up gains, items, and gold. What it leaves for the screen is a record of what happened. Two renderers play that record back. The **battle scene** ([Chapter 24](24-the-battle-scene.md)) replaces the map with a full-screen view of the two combatants. The **map battle** plays the fight on the map itself, with small battle sprites standing on the two units' tiles, HP windows, and spell effects drawn over the map.

Neither renderer changes the game's state. A map battle's HP windows count down from numbers that are already true in the unit records. The opening's attract mode and the chapters' scripted scenes stage fights through the same map battle code by filling in a record of their own, and no unit is touched.

This chapter covers what the renderers read, how the engine chooses between them, the map battle's proc script and its round loop, the battle sprites and how they mark the moment a blow lands, magic effects on the map, and the other map animations built from the same parts.

## What the renderers read

The calculation leaves two things in work RAM:

- **The action structs** `aActionStructUnit1` and `aActionStructUnit2`: one per side, with the unit's character, class, weapon, HP before the fight, battle stats, experience gained, level-up gains, and any gold or item obtained. The player's side, or an allied army's, is always unit 1 ([Chapter 6](06-resolving-a-battle.md)).
- **The round log** `aBattleRoundsData`: one 16-bit entry per event, in order. A strike's low byte is its flags (which side, staff, critical, miss, fatal, ranged, magic) and its high byte the damage. An entry `$xxFE` is a skill activating, with the skill's ID in the high byte; `$FEFF` ends one arena bout; `$FFFF` ends the log.

`wBattleType` says what kind of fight it is: 0 a battle on the map, 1 an arena bout, 2 a class change (played as a scene, [Chapter 15](15-castles-and-towns.md)), 3 a fight or staff on the castle screen.

## Choosing a renderer

`rlStartCombatAnimation` ([engine/battle/battle.asm](../../engine/battle/battle.asm)) runs once the calculation is done:

```rust
fn start_combat_animation() {                     // rlStartCombatAnimation
    if wBattleType == 1 { return; }               // the arena starts its own scene
    if unit1.weapon == ValkyrieStaff || unit1.weapon == Naga
        || unit2.weapon == Loptous
        || wBattleType == 2                       // class change
    {
        return rlStartBattleScene();
    }
    if unit1.weapon_type != Staff && scripted_critical_pending() {
        return rlStartScriptedCritEffect();       // its proc continues below when it ends
    }
    select_unit(unit1);
    rlStartBattleSceneOrMapBattle();
}

fn start_battle_scene_or_map_battle() {           // rlStartBattleSceneOrMapBattle
    if animation_off() { rlStartMapBattle() } else { rlStartBattleScene() }
}
```

A scripted critical ([Chapter 6](06-resolving-a-battle.md)) first plays a short effect on the map (`procScriptedCritEffect`), and that proc calls `rlStartBattleSceneOrMapBattle` when it finishes.

The option and the unit decide the rest. `rlCheckIfBattleAnimationOFF` ([engine/core/options.asm](../../engine/core/options.asm)) looks at unit 1:

| Unit 1 | Animation option | Renderer |
|---|---|---|
| Belongs to an army other than the player's | any | Map |
| A Civilian or a Child | any | Map |
| Otherwise | Real | Scene |
| | Map | Map |
| | Each unit | Map if the unit's `UnitStateMapAnimation` bit is set, else scene |

So a fight whose first side is an allied army's unit, a Civilian, or a Child is always shown on the map, and the Valkyrie Staff, Naga, and Loptous fights are always scenes, whatever the option says. "Player's army" here is faction slot 0 ([Chapter 4](04-armies-and-allegiance.md)).

`rlStartMapBattle` ends the acting unit's action and calls `rlStartMapBattleAnimation`, which creates `procMapBattle`. The battle scene's start is in [Chapter 24](24-the-battle-scene.md).

## The map battle

### A proc script that waits on bits

A **proc** is a small task the engine runs once per frame alongside everything else; its **script** is a list of steps with yields between them ([Chapter 28](OUTLINE.md)). `procMapBattle`'s script, `aProcMapBattleCode` in [engine/battle/map_battle.asm](../../engine/battle/map_battle.asm), is the outline of the whole fight.

Most steps follow one pattern. The script calls a start routine, which sets bit `$0002` of the proc's flags if there is something to do (a quote to show, a window to open). If the bit is clear, the script skips ahead. If it is set, the script yields and calls a step routine every frame until that routine sets bit `$0004`, meaning done. Optional parts of a fight are therefore one test each, and the script never counts frames for work whose length varies, such as a quote the player reads at their own speed.

The script, in outline:

1. **Set up.** Pause the map's sprite and tile animations ([Chapter 22](22-a-map-bigger-than-the-screen.md)), fill `aMapAction` from the action structs, and queue the battle sprites' graphics.
2. **Camera.** Scroll the map until both units are on screen.
3. **Sprites.** Show the attacker's battle sprite, then twelve frames later the defender's, over their map sprites.
4. **Battle quote**, if `wBattleQuotePointer` is set. The dialogue box overwrites battle sprite tiles in video RAM, so afterwards they are decompressed again and uploaded over three frames.
5. **Shared tile.** A unit attacking from the tile its target stands on (`wBattleStatus` bit 2) slides 16 pixels aside.
6. **HP windows.**
7. **Rounds**, below.
8. **Close the HP windows**; slide the shifted unit back.
9. **Experience and level up.** The experience window, then the level-up banner with its jingle, then the stat gains.
10. **Popups**, each with the music lowered and a jingle: gold obtained, gold stolen, item obtained, weapon broken.
11. **End.** Return the camera to the cursor, restore the palettes and the units' map sprites, and check for canto.

### The round loop

```rust
loop {                                           // aProcMapBattleCode, from _CB70
    let Some(entry) = next_round() else { break };   // rlMapBattleNextRound; $FFFF ends
    // a skill entry ($xxFE) is read together with the strike after it
    if entry.skill_shown != None {               // Astra to Darkness
        show_skill_effect(entry.skill_shown);    // 96 frames of palette effect
        // another skill entry next: back to the top of the loop
    }
    if entry.pavise { show_pavise_shield(); }    // $02FE
    if entry.has_magic() { load_and_start_magic(); }     // below
    play_round();                                // the sprites' round scripts
    if warp { show_warp_arrival(); }
    if status_sword { show_staff_effect(); }
    end_magic_and_restore_screen();
    if defeated && wDeathQuotePointer != 0 { show_death_quote(); }
    if defeated { defeat_blink(); }
    if entry == 0x7F00 { signal_waiting_event(); }   // scripted battles
}
```

The skill effect whitens the side's sprites, loads the skill's colors into background palette 13, plays sound `$3D`, and runs the palette for 96 frames through `rlBattleSceneRunPaletteEffects`, the battle scene's own palette engine ([Chapter 24](24-the-battle-scene.md)). Pavise has its own shield animation. Holy weapon shine on the map is the same skill effect, started by `procHolyWeaponShine`.

The entry `$7F00` is a marker for scripted battles. When the loop reads it, it sets a bit in `wMapAnimationSignals` that an event script is waiting on, so a scene can react partway through a fight.

### Three callers

`wMapBattleMode` (`$7F/4C87`) records who started the battle:

| Mode | Started by |
|---|---|
| 0 | A battle in play (`rlStartMapBattle`) |
| 1 | The opening's attract-mode demo (`rlASMCStartDemoMapBattle`, [Chapter 20](20-the-opening.md)) |
| 2 | An event: a two-unit fight (`rlStartScriptedMapBattleAnimation`) or one unit alone (`rlStartSoloMapBattleAnimation`, such as Silvia's dance in Chapter 4) |

Modes 1 and 2 fill the action structs and round log themselves. In those modes the HP windows don't drain (`rlApplyMapBattleRoundHP` returns at once), and the experience, level-up, and popup steps are skipped (`rlMapBattleCheckExperience`). `wMapMagicFlags` is set to `$8000` (below).

## Battle sprites

### Sprites with scripts

Each side is drawn by **active sprites**: sprites with their own little script engine, which steps a script of frames, moves, waits, and commands every frame ([Chapter 29](OUTLINE.md)). Each side has a main sprite and, for mounted and flying classes, a second **aux** sprite for the mount or the rider (`wSideTallSprite`). The engine builds their definitions in RAM at `$7E/FC88`, because their scripts live in sprite data decompressed into work RAM.

The sprite a unit uses depends on its class, its gender, and one character: `rlGetMapBattleClassSprite` gives classes listed in `aMapBattleFemaleClassSprites` a different sprite for women, and Seliph as a Knight Lord his own. A class's row in `aBattleMapSpriteData` has, for each of eight facings, pointers to the sprite data and to its graphics. The sprite data has one block per weapon type: a frame table, then pairs of scripts (main, aux) at fixed offsets:

| Offset | Script |
|---|---|
| `+6` | Idle, waiting for a round |
| `+$0A` | Dodge |
| `+$0E` | Strike |
| `+$12` | Strike at range, with a magic effect |

Before each round, `rsGetMapBattleRoundScripts` picks each side's pair from the round's side, hit, miss, and critical bits, and the sprites' commands `$09` and `$0A` jump into them.

### Marking the moment of impact

The moment the blow lands is a command in the striker's sprite script. The two sides' scripts pass that moment along through two flags in `aMapAction`:

| Command | Effect |
|---|---|
| `$04` strike | Sets `wMapBattleStrikeSignal` and plays the hit sound |
| `$06` wait for strike | Waits until the signal is set; a main sprite then clears it |
| `$05` wait until taken | Waits until the signal is clear, then sets `wMapBattleStrikeDone` |
| `$07` wait until done | Waits until `wMapBattleStrikeDone` is set |
| `$0D` end round | Ends the round (`rlMapBattleEndRoundScripts`) |

Each frame of the round, `rlMapBattleRoundStep` gives the struck side its reaction. A hit that does damage flashes the side white (`rlMapBattleRunHitFlash`), and a critical or a hit for no damage also knocks it back (`rlMapBattleRunRecoil`). The HP window starts draining at the same moment. The hit sound is `$94` for a fatal strike and `$93` for a ranged one, otherwise `$91` or `$93` by side; a critical adds sound `$4E`, and a hit for no damage plays `$95`. On a miss, a Junior Lord or Prince plays a dodge sound, `$97`. A defeated unit cries out by voice (`$21`–`$23` for adults, `$24` or `$25` for children) and blinks out.

The ballistician classes add a projectile: command `$1B` launches `procMapBattleBallistaBolt`, `$1A` advances the bolt along one of the 16-frame arcs in `aBallistaBoltArcs` (chosen by distance), and `$1C` reports it landed.

## Magic on the map

A tome, a staff, or a magic sword at range plays an effect over its own background. The effect number is the item ID minus Fire's (`$3E`), from 0 for Fire to 41 for `BrokenStaffA`. Magic swords borrow a spell's or staff's: at range the Fire, Earth, Thunder, and Wind Swords and the Light Brand play Elfire, Nosferatu, Elthunder, Elwind, and Light, and the Berserk, Silence, and Sleep Swords play their staff's.

Before the rounds, `rlSetMapMagicFlags` sets `wMapMagicFlags`: 0 when neither side plays an effect, `$8000` in demo and scripted battles, 1 on the castle screen, otherwise 1 plus a bit for each screen edge the units are close to (`$0100` left, `$0200` right, `$0400` top, by `aMapMagicEdgeMargins`). The edge bits adjust the window line counts (`aMapMagicWindowLines`) so an effect isn't cut off at the edge of the screen.

A magic round loads and runs the effect in steps of the battle's script:

1. **Select** the acting side's effect (`rlSelectMapMagicEffectForRound`).
2. **Decompress** its background tiles, tilemap, and colors from `aMapBattleMagicBackgrounds`. Meteor and Valflame have a second tilemap for a target on the right half of the screen.
3. **Upload** them over several frames, then the effect's sprite graphics (`aMapBattleMagicSprites`).
4. **Start**: save the screen registers and create `procMapMagicEffect`.
5. **Wait for the caster.** The caster's sprite script runs command `$10` at the moment of casting, which sets `wMapMagicStart`. The effect proc then runs the spell's starter from `aMapMagicEffectStarters` ([engine/battle/map_magic_effects.asm](../../engine/battle/map_magic_effects.asm)). The script waits at command `$11` until the effect sets `wMapMagicDone`, usually after fading the colors back.
6. **Clean up**: free every proc and HDMA entry the effect created, tracked in `aMapMagicProcList` and `aMapMagicHDMAList`, and restore the screen registers.

Effects share code where spells look alike. Heal's proc also plays for Naga, Loptous, the broken fire tomes, Charm, and Valkyrie; Mend, Recover, and Physic are the same effect with different sounds; Elthunder's serves Bolting, Wind's serves Elwind, and Warp's serves Rescue. Shared helpers in bank `$9F` ([engine/battle/map_battle_magic.asm](../../engine/battle/map_battle_magic.asm)) provide a sine table and vector math, palette darkening and tinting, background shaking, and a rippling HDMA effect on BG2 (`procMapMagicRipple`). HDMA rewrites a register on every scanline, so a table of offsets one line apart bends the layer into a wave.

## Windows and popups

[engine/battle/map_battle_hud.asm](../../engine/battle/map_battle_hud.asm) holds the windows the map battle draws over the map:

- **HP windows**, one per side, placed above or below the units so they don't cover the sprites, colored by army (`aMapBattleHPWindowPalettePointers`). Staves that change no HP (Fortify, Return, Warp, Rescue, Restore, Silence, Sleep, Berserk, and Thief) open none (`rlCheckMapBattleNoHPChange`).
- **The experience window**, which slides open through an HDMA table (`aMapBattleExperienceWindowHDMAInfo`) and fills a five-step gauge (`rlDrawMapMenuTwoRowGauge`).
- **The text box** for the gold, item, and broken-weapon popups.

## The same parts outside battle

The map battle's sprites, magic effects, windows, and reward steps serve other animations on the map, in [engine/battle/map_action_animations.asm](../../engine/battle/map_action_animations.asm) and [engine/events/cutscenes.asm](../../engine/events/cutscenes.asm):

| Proc | Shown when | Built from |
|---|---|---|
| `procVillageRaid` | A brigand destroys a village | The unit's sprites and the village fire effect |
| `procReturnHome` | A unit uses Return | The Return magic effect |
| `procGiveGold` | A unit gives gold to another | Both units' sprites, a coin sprite, then experience and level up |
| `procHolyWeaponShine` | A holy weapon's skill shows on the map | The skill effect |
| `procMapActionRewards` | Experience, gold, or an item gained without a battle | The battle's reward steps |
| `procScriptedCritEffect` | Before a battle with a scripted critical | Its own sprites (`aMapBattleScriptedCritSprites`) |
| `procWarpAway`, `procWarpIn` | Event warps | The warp sprites |
| `procBelhallaMagesBlast` | The Belhalla massacre | Meteor's effect |

## Trade-offs and hard limits

- **Sharing the map's video RAM.** The battle sprites and effects borrow video RAM and sprite slots from the map, so the map's own animations are paused for the whole fight, and the sprite tiles are reloaded after every dialogue box.
- **Effects tied to item IDs.** The effect number is computed from the item ID, so the 42 effects follow the order of the items from Fire to `BrokenStaffA`. A new spell in that range needs a new effect; one outside it has none.
- **Inside a castle.** A fight or staff on the castle screen has no map tiles to stand on. `rlGetMapBattleUnitScreenPosition` uses the units' courtyard positions (`aCastleCourtyardSpriteX`/`Y`) instead, and the units' courtyard sprites are hidden for the fight (`DeploymentStateHiddenInCastle`).
- **An unused quote.** After each round the script asks for a third quote whose text pointer is the constant 0 (`rlMapBattleStartUnusedQuote`), so it never shows.

## Where it lives in the source

- [engine/battle/battle.asm](../../engine/battle/battle.asm): `rlStartCombatAnimation`, `rlStartBattleSceneOrMapBattle`, `rlStartMapBattle`, `rlStartBattleScene`.
- [engine/core/options.asm](../../engine/core/options.asm): `rlCheckIfBattleAnimationOFF`.
- [engine/battle/map_battle.asm](../../engine/battle/map_battle.asm): `procMapBattle` and its script, sprite selection, the round steps, the strike reaction and sounds, ballista bolts, the skill and Pavise effects, and `procScriptedCritEffect`.
- [engine/battle/map_battle_magic.asm](../../engine/battle/map_battle_magic.asm): loading map magic, `procMapMagicEffect`, and the shared effect helpers.
- [engine/battle/map_magic_effects.asm](../../engine/battle/map_magic_effects.asm): `aMapMagicEffectStarters` and each spell's effect.
- [engine/battle/map_battle_hud.asm](../../engine/battle/map_battle_hud.asm): HP windows, the experience window, the text box.
- [engine/battle/map_action_animations.asm](../../engine/battle/map_action_animations.asm) and [engine/events/cutscenes.asm](../../engine/events/cutscenes.asm): the other map animations.
- [include/ActiveSpriteEngine.h](../../include/ActiveSpriteEngine.h): the active sprite commands, including the map battle's.
- [docs/reference/map_battle.md](../reference/map_battle.md): the reference page.
