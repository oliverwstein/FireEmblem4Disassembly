# Chapter 23: Two ways to show a fight

By the time a battle is ready to be drawn, the combat engine has already decided everything: who strikes, which skills activate, how much damage lands, and whether anyone dies or levels up ([Chapter 6](06-resolving-a-battle.md)). Because *Genealogy of the Holy War* lets the player choose between full-screen battle scenes, quick animations on the map, or per-unit overrides—and because events and the attract-mode demo also stage fights on the map—the game separates combat math from presentation. The same combat output drives two completely different renderers: the full battle scene ([Chapter 24](24-the-battle-scene.md)) and the map battle.

This chapter covers the dispatch boundary between model and view, the ten-stage `procMapBattle` pipeline, the active-sprite handshake for battle sprites and ballistae, bank `$9F` map magic effects, the map battle HUD, and the non-combat map actions that reuse the same machinery.

## Model and view kept apart

The battle calculation writes its entire result into two shared structures in WRAM:

- **Combatant snapshots (`aActionStructUnit1`, `aActionStructUnit2`):** Each side's character, class, weapon, starting HP, battle stats, experience, level-up gains, and obtained gold or items.
- **Round log (`aBattleRoundsData`):** A variable-length array of 16-bit entries recording every strike, miss, critical, skill trigger (`$xxFE`), arena bout boundary (`$FEFF`), and the `$FFFF` terminator.

Once the round log is built, the animation dispatcher chooses which renderer to launch. Signature fights—those using the Valkyrie Staff, Naga, or defending with Loptous, as well as arena bouts and class changes—always force the full battle scene. Everything else checks the player's animation setting (full scene, map battle, or per-unit toggle):

```rust
fn start_combat_animation() { // rlStartCombatAnimation
    if wBattleType == 1 { return; } // arena launches rlStartBattleScene itself

    let force_scene = aActionStructUnit1.WeaponID == ValkyrieStaff
        || aActionStructUnit1.WeaponID == Naga
        || aActionStructUnit2.WeaponID == Loptous
        || (wBattleType != 0 && wBattleType != 3);

    if force_scene {
        rlStartBattleScene();
        return;
    }

    if aActionStructUnit1.WeaponType != WeaponTypeStaff
        && (wBattleCriticalType & 0x7FFF) != 0
        && (wBattleCriticalType & 0x8000) != 0
    {
        play_scripted_crit_effect(); // procScriptedCritEffect before battle
    }

    if rlCheckIfBattleAnimationOFF() { // rlStartBattleSceneOrMapBattle
        rlStartMapBattle();            // clears AI flag, ends action, starts procMapBattle
    } else {
        rlStartBattleScene();
    }
}
```

When a map battle is chosen, the starter spawns `procMapBattle` in the first free proc slot and reads `wMapBattleMode` (`$7F/4C87`) to distinguish its three callers:

| `wMapBattleMode` | Caller | Mutates unit HP? |
|---|---|---|
| `0` | Normal gameplay battle | Yes |
| `1` | Opening attract-mode demo | No |
| `2` | Scripted event battle (two-unit fight or solo dance) | No |

## The `procMapBattle` pipeline

A map battle plays out through a linear proc script (`aProcMapBattleCode` in [engine/battle/map_battle.asm](../../engine/battle/map_battle.asm)). Rather than hardcoding frame counts for every camera pan, spell, or quote, each step invokes a setup routine that sets bit `$0002` of the proc header while work is underway and bit `$0004` when it finishes; the script yields until bit `$0004` is set.

```rust
// aProcMapBattleCode (10-stage pipeline)
init_combatants();          // pause map sprites/tiles, fill aMapAction
pan_camera_to_pair();       // scroll map until both units are on screen
show_combatant_sprites();   // show battle sprites over hidden map sprites
play_battle_quote();        // dialogue box if wBattleQuotePointer != 0; re-upload sprite tiles
open_hp_windows();          // skipped for non-HP staves

while let Some(round) = next_round() { // rlMapBattleNextRound until $FFFF
    if round == 0x02FE {
        show_pavise_shield();          // procMapBattlePavise
        continue;
    }
    play_round_animation(round);       // melee, ballista bolt, or magic + sprite handshake
    if wMapBattleMode == 0 {
        rlApplyMapBattleRoundHP();     // only normal gameplay mutates real HP
    }
}

play_death_quote();         // if defeated and wDeathQuotePointer != 0
show_exp_and_level_up();    // EXP strip + level-up banner and stat gains
show_reward_popups();       // gold obtained/stolen, item obtained, weapon broken
restore_map_and_canto();    // restore palettes/map sprites, return camera, check canto
```

Several details keep this sequence clean while sharing the screen with the live chapter map:

- **Class and character sprite overrides:** Each combatant's row in `aBattleMapSpriteData` is chosen by class and weapon type, swapping in female sprites where defined and giving Seliph a distinct Knight Lord sprite.
- **Shared-tile assault shift:** When an attacker engages a defender standing on the same tile (`wBattleStatus` bit 2), the engine slides the shifted unit 16 pixels aside before round 1 and slides it back afterward.
- **Post-quote tile recovery:** Because dialogue boxes overwrite map sprite VRAM tiles, the quote step decompresses and re-uploads the battle sprite graphics as soon as the dialogue box closes.
- **Strike impact and defeat cries:** When a strike lands, the defender recoils and flashes white while a panned hit sound plays (`$94` fatal, `$93` ranged, `$91`/`$93` melee, `+$4E` for critical, or `$95` for no damage). A defeated unit plays a voice-indexed cry (`$21`–`$23` for adults, `$24`/`$25` for children) and blinks out.
- **Warp arrival:** After a Warp staff cast, a dedicated arrival proc plays at the destination if that tile is currently visible on screen.

## Battle sprites and the active-sprite handshake

Map battles draw combatants using the active sprite engine ([Chapter 29](OUTLINE.md)). Each side receives a main sprite and, for mounted or flying classes (`wSideTallSprite` nonzero), an auxiliary sprite. Because sprite animation scripts reside in decompressed WRAM in bank `$7E`, the initializer builds the sprite definitions dynamically at `$7E/FC88`.

Each class's sprite data contains one block per weapon type: a frame table followed by `(main, aux)` script pairs at fixed offsets (`+6` idle wait, `+$0A` dodge, `+$0E` melee strike, `+$12` ranged strike). Before each round, `rsGetMapBattleRoundScripts` selects the pair matching the round's hit, miss, and critical bits, and active-sprite commands `$09` and `$0A` jump to it.

Strikes and magic effects synchronize the sprite scripts with `procMapBattle` through shared WRAM handshake flags:

```
  procMapBattle          Attacker Sprite         Defender Sprite        procMapMagicEffect
       |                        |                       |                       |
       |-- start round -------->| (cmd $09/$0A)         |                       |
       |                        |-- cmd $10 ----------->|--- wMapMagicStart --->|
       |                        |   (wait cmd $11)      |                       | (runs spell,
       |                        |<-- wMapMagicDone -----|<----------------------|  fades back)
       |                        |-- cmd $04 ----------->|                       |
       |  (recoil, flash, HP) <-|-- wMapBattleStrikeSignal                      |
       |                        |   (wait cmd $05)      |                       |
       |<-- wMapBattleStrikeDone|                       |                       |
       |  (wait cmd $07, $0D)   |                       |                       |
```

Ballistician classes add three projectile opcodes to the same engine: `$1B` spawns the bolt proc (`procMapBattleBallistaBolt`), `$1A` steps the bolt along a 16-frame distance-indexed arc (`aBallistaBoltArcs`), and `$1C` signals impact.

## Map magic effects

Tomes, staves, and magic swords play full-screen spell animations over custom backgrounds using bank `$9F` ([engine/battle/map_battle_magic.asm](../../engine/battle/map_battle_magic.asm), [engine/battle/map_magic_effects.asm](../../engine/battle/map_magic_effects.asm)). The effect index is simply `ItemID - Fire ($3E)`, giving 42 contiguous slots from `0` (Fire) to `41` (`BrokenStaffA`). Magic swords map onto spell or staff animations at range: the Fire, Earth, Thunder, Wind, and Light Brands play Elfire, Nosferatu, Elthunder, Elwind, and Light, while the Berserk, Silence, and Sleep Swords play their corresponding status staff effects.

Before a magic round begins, `rlSetMapMagicFlags` computes `wMapMagicFlags`: `0` when no magic plays, `$8000` in demo and scripted battles, `1` on the castle screen, or `1` plus edge-proximity bits (`$0100` left, `$0200` right, `$0400` top) when a unit stands near the screen border in `aMapMagicEdgeMargins`, adjusting the HDMA window line counts in `aMapMagicWindowLines`.

Every magic round runs six stages:

| Stage | Work performed |
|---|---|
| 1. Select | Sets `wMapMagicEffect` to the acting side's effect number |
| 2. Decompress | Queues compressed 4bpp tiles, 32 × 32 tilemap, and 256-color palette from `aMapBattleMagicBackgrounds` (Meteor and Valflame swap tilemaps when targeting the right half of the screen) |
| 3. Upload | Sends background tiles, tilemap, palette, and spell sprite sheets (`aMapBattleMagicSprites`) to VRAM |
| 4. Launch | Saves screen registers and creates `procMapMagicEffect` |
| 5. Execute | Waits for the battler's sprite script to set `wMapMagicStart` (`$10`), dispatches through `aMapMagicEffectStarters`, and runs until the effect fades colors back and sets `wMapMagicDone` (`$11`) |
| 6. Clean up | Frees every proc and HDMA entry tracked in `aMapMagicProcList` and `aMapMagicHDMAList`, then restores screen registers |

Many starters share underlying effect procs—Heal's `procMapMagicHealingStaff` also serves Naga, Loptous, broken fire tomes, Charm, and Valkyrie, while Mend, Recover, and Physic differ only in sound effect. All spells draw on shared bank `$9F` utilities for sine and vector math (`aMapMagicSineTable`), palette tinting and darkening (`rsTintMapMagicColorsRed`/`Blue`/`Green`, `rlDarkenMapMagicColors`), background shaking (`rsShakeMapMagicBackground`), and the bank `$87` BG2 HDMA ripple (`procMapMagicRipple`).

## Map battle HUD

[engine/battle/map_battle_hud.asm](../../engine/battle/map_battle_hud.asm) draws the minimal HUD overlays directly onto BG3 without leaving the map:

- **HP windows:** Placed dynamically above or below the combatants so they stay clear of the sprites, and tinted by allegiance (`aMapBattleHPWindowPalettePointers`). Non-HP staves—Fortify, Return, Warp, Rescue, Restore, Silence, Sleep, Berserk, and Thief—suppress HP windows entirely via `rlCheckMapBattleNoHPChange`.
- **Experience and level-up strips:** `procMapExperienceWindowEffect` slides in a 24-line HDMA-masked BG3 strip (`aMapBattleExperienceWindowHDMAInfo`) and fills the five-step gauge (`rlDrawMapMenuTwoRowGauge`, `aMapMenuGaugeTiles`) before the level-up banner and stat-gain popups appear.

## Reused map action animations

Outside combat, [engine/battle/map_action_animations.asm](../../engine/battle/map_action_animations.asm) and [engine/events/cutscenes.asm](../../engine/events/cutscenes.asm) reuse the same sprite, magic, and reward procs for map events:

| Proc | Trigger | Behavior |
|---|---|---|
| `procVillageRaid` | Enemy brigand raids a village | Queues unit sprites, spawns fire sprite, runs `rlStartMapMagicVillageFire` |
| `procReturnHome` | Return staff / Return ring | Plays the Return magic effect and restores map OAM/animations |
| `procGiveGold` | Thief or lover transfers gold | Displays both units, animates coin sprite (`aGiveGoldCoinSpriteData`), runs EXP/level-up |
| `procHolyWeaponShine` | Holy weapon / skill activation | Plays `rlMapBattleStartSkillEffect` (BG palette 13, sound `$3D`) |
| `procMapActionRewards` | Non-combat EXP, gold, or item gain | Runs EXP, level-up, gold, and item popups, then restores map graphics |
| `procScriptedCritEffect` | Pre-battle scripted critical | Plays `aMapBattleScriptedCritSprites` before combat begins |
| `procWarpAway`, `procWarpIn`, `procBelhallaMagesBlast` | Event cutscenes | Reuses map magic effects (Meteor for Belhalla mages) and warp sprites |

## Trade-offs and hard limits

Keeping combat on the map avoids the full VRAM reload of a battle scene, making fast turns practical, but forces tight resource sharing with the map engine:

- **VRAM and animation contention:** `procMapBattle` must pause standing map sprites and animated tiles (`wMapSpriteAnimationPauseFlags`) while it borrows OAM and VRAM, and must re-decompress battle sprite tiles whenever a battle quote opens a dialogue box.
- **Castle courtyard fights (`wBattleType == 3`):** When a battle or staff cast occurs inside a castle, `rlGetMapBattleCombatantScreenCenter` substitutes fixed courtyard coordinates (`aCastleCourtyardSpriteX/Y`) and hides units with `DeploymentStateHiddenInCastle`.
- **42-entry magic table:** Magic effect indices are computed directly from `ItemID - $3E`, tying spell graphics and effect starters strictly to contiguous item IDs from `Fire` through `BrokenStaffA`.

## Where it lives in the source

- [engine/battle/battle.asm](../../engine/battle/battle.asm): `rlStartCombatAnimation`, `rlStartBattleSceneOrMapBattle`, `rlStartMapBattle`, and `rlStartBattleScene`.
- [engine/battle/map_battle.asm](../../engine/battle/map_battle.asm): `procMapBattle`, `aBattleMapSpriteData`, round playback, ballista bolts, and `procScriptedCritEffect`.
- [engine/battle/map_battle_hud.asm](../../engine/battle/map_battle_hud.asm): HP windows, `rlDrawMapMenuTwoRowGauge`, and `procMapExperienceWindowEffect`.
- [engine/battle/map_battle_magic.asm](../../engine/battle/map_battle_magic.asm): `aMapBattleMagicBackgrounds`, `aMapBattleMagicSprites`, `procMapMagicEffect`, and shared palette/trig/shake helpers.
- [engine/battle/map_magic_effects.asm](../../engine/battle/map_magic_effects.asm): `aMapMagicEffectStarters` and per-spell effect procs.
- [engine/battle/map_action_animations.asm](../../engine/battle/map_action_animations.asm) and [engine/events/cutscenes.asm](../../engine/events/cutscenes.asm): non-combat map animations and event cutscenes.
- [docs/reference/map_battle.md](../reference/map_battle.md): full reference for the map battle system.
