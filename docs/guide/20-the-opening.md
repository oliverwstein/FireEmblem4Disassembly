# Chapter 20: The Opening

Booting *Genealogy of the Holy War* launches a two-minute illustrated prologue, an animated sprite title logo, and an attract-mode opening featuring staff credits, conversations, map scenes, and real battles—all looping indefinitely while remaining ready to jump to the file menu or skip ahead on Start. Rather than building a second rendering stack or a second combat engine, the developers borrowed the battle scene's effect engines for the title screen and drove the entire attract mode through an ordinary event script feeding pre-scripted rounds into the real map-battle and battle-scene engines.

This chapter covers the title-to-demo loop, the title screen's timeline interpreter and paced loader, the attract mode's event script, how demo battles reuse combat and unlock from SRAM progress, and the hard limits.

## The loop between title and attract mode

```
  Boot ──► Opening Logo (init demo indices from SRAM) ──► Title Screen (GAMESTATE $1A/$1B)
                                                            │
      ┌─────────────────────────────────────────────────────┘
      ├─ Phase 0: Intro (aTitleIntroTimeline, ~2 min)
      │     ├─ Start pressed ──────────────────► Phase 1: Title Logo (aTitleTimeline)
      │     ├─ Frame $186D ────────────────────► Phase 1: Title Logo ──► Timeout ($1C9F) ─┐
      │                                                                                   ▼
      ├─ Phase 1 (from Start): Title Logo ─────► Timeout ($041E) ──────────────► Attract Mode
      │     │                                                                    (aOpeningEvent)
      │     └─ Start pressed ──► Phase 2: Fade Out (aTitleFadeOutTimeline)         │
      │                            │                                               ├─ Start (DEMO_ALLOW_SKIP)
      │                            ▼                                               │    ──► Title (skip intro)
      └──────────────────────► File Menu                                           └─ OPEN_TITLE_SCREEN ($5E)
                                                                                          ──► Title (with intro)
```

Before the title screen opens, `rlLoadOpeningLogoScreen` ([engine/title/opening_logo.asm](../../engine/title/opening_logo.asm)) sets `wDemoIndex` and `wDemoBattlePair` from SRAM so the attract mode knows which demos are unlocked. Holding Start as the title screen opens (`bTitleScreenSkipIntro`) jumps straight to Phase 1, and Phase 2 (`aTitleFadeOutTimeline`) dims the palettes over ~50 frames and hands over to the file menu (`rlReturnToFileMenu`). In both Phase 0 and Phase 1, `rlTitleScreenIsStartPressed` and `rlTitleScreenIsStartHeld` ignore Start while `wMusicID != 0` so a song change in flight cannot be interrupted mid-transfer.

## The title screen and its timelines

### Borrowing the battle scene's engines

`rlTitleScreenSetup` (`$1A`) and `rlTitleScreenStep` (`$1B`) in [engine/title/title_screen.asm](../../engine/title/title_screen.asm) borrow the battle scene's palette-effect, window-effect, and screen-register engines ([Chapter 24](24-the-battle-scene.md), banks `$95`/`$96`) as well as its `$7F/D000` RAM block.

### The timeline interpreter

Three timelines in [engine/title/title_timelines.asm](../../engine/title/title_timelines.asm)—`aTitleIntroTimeline`, `aTitleTimeline`, and `aTitleFadeOutTimeline`—script every cut, scroll, fade, and sprite spawn against `wTitleScreenFrame` ([include/TitleScreen.h](../../include/TitleScreen.h)):

```rust
fn run_title_timeline() {                                   // rsRunTitleTimeline
    if timeline.peek_frame() <= wTitleScreenFrame {         // at most one entry per frame
        timeline.advance_u16();
        loop {
            let cmd = timeline.read_u8();
            if cmd == 0xFF { break; }                       // TITLE_TIMELINE_NEXT
            let routine = timeline.read_u24();
            if cmd & 0x80 != 0 {
                call_with_a(routine, cmd & 0x7F);           // TITLE_TIMELINE_CALL
            } else {
                let slot = &mut aTitleTimelineSlots[cmd as usize];
                slot.active |= 0x01;                        // TITLE_TIMELINE_SLOT
                slot.routine = routine;
            }
        }
    }
    for (idx, slot) in aTitleTimelineSlots.iter().enumerate() { // rsRunTitleTimelineSlots
        if slot.active & 0x01 != 0 {
            call_with_x(slot.routine, idx * 4);
        }
    }
}
```

Each of the 16 `aTitleTimelineSlots` acts as a lightweight cooperative state machine: once installed by `TITLE_TIMELINE_SLOT`, its routine runs every frame with `X = slot offset` until it clears its own active bit. By convention, slot 0 steps `INIDISP` brightness lists (`rlRunTitleBrightnessList`), slot 1 scrolls backgrounds, slots 2–4, 6, and 8 drive HDMA and palette effects, and slot 7 fades captions.

### Paced background loading

The eight illustrated scenes cannot be decompressed in a single blanked frame without stalling music and animation. Instead, `aTitleIntroTimeline` sprinkles `TITLE_TIMELINE_CALL 2, rlAllowTitleLoad` calls throughout the *preceding* scene. Each call increments `bTitleLoadRequests`; every frame, `rlRunTitleLoadList` checks whether the previous transfer has finished and starts the next decompression (type 0) or copy (type 2) from `aTitleLoadList` in the background.

### Scenes, captions, edge fade, and title sprites

- **Eight intro scenes (`$0001`–`$1719`):** Scene 7 pre-interpolates 33 palettes into `$7F/8000` at setup (`rlBuildTitleIntroScene7PaletteTable`); Scene 8 animates a moving sprite with an afterimage; at frame `$186D`, `rlEnterTitlePhase` enters Phase 1 and spawns the 11 title logo sprites (`$1873`–`$1889`).
- **Two IRQs ([Chapter 29](29-sprites-and-scanlines.md)):** Line 6 (`rlFadeTitleScreenTopEdge`) fades the top edge when `bTitleScreenEdgeFade` is set; line 189 (`rlDrawTitleCaptionStrip`) switches the PPU below scanline 189 to BG1 alone at `bTitleCaptionBrightness` to show pre-rendered graphic captions scrolled via `aTitleCaptionScrolls` (not encoded dialogue text).
- **Title sprites (`aTitleSprites`):** 13 entries of `structTitleSprite`, each initialized from a 13-byte `TITLE_SPRITE` definition (`rlStartTitleSprite`) and animated by 2-byte step scripts (`frame + 1, duration`, or `$80, back_count` to loop). Each sprite also keeps a 16-entry position/frame ring (`TrailX`/`TrailY`/`TrailFrame`) for drawing afterimages (`rlDrawTitleSpriteAfterimage`).

## The attract mode as an event script

When a title timeline reaches `rlEndTitleScreen`, `rlStartOpeningEvent` launches `aOpeningEvent` in [engine/demo/opening.asm](../../engine/demo/opening.asm) (bank `$90`). It is a standard event script ([Chapter 12](12-screenplays.md)) with two demo-only opcodes: `DEMO_ALLOW_SKIP` (`$5D`), which enables `procDemoSkipFadeOut` on Start, and `OPEN_TITLE_SCREEN` (`$5E`), which flashes white with sound `$84` (`rlFlashToTitleScreen`).

The script plays seven beats in sequence:

1. Chapter 9's map under two drifting sky layers (`procOpeningSkyScroll`) as Annand's pegasus squad flies across (`MOVE_TEMPORARY_BY_SCRIPT`).
2. Credits page 1, full-screen battle scene #1, page 2, the Shannan–Ayra conversation (`DIALOGUE_WITH_BG`), and page 3.
3. **Map scene #1** (`wDemoIndex` forced odd by `rlASMCSetDemoIndexOdd`) and its scripted map battle ([Chapter 23](23-two-ways-to-show-a-fight.md)).
4. Credits page 4, the Eldigan–Lachesis conversation, page 5, battle scene #2, and page 6.
5. **Map scene #2** (the even `wDemoIndex` below it) and its scripted map battle.
6. Credits page 7, followed by Arvis ordering the final attack on Chapter 11's map (`MOVE_TEMPORARY_TO_COORDS_CLASS`).
7. Credits page 8 (producer) and `OPEN_TITLE_SCREEN`.

Each of the eight staff credit pages ([engine/demo/opening_credits.asm](../../engine/demo/opening_credits.asm)) is a `RUN_ASM` routine (`rlShowOpeningCreditsPage1`–`8`) that decompresses a BG3 tilemap to VRAM `$5800` with `gcOpeningCreditsFont`; pages 1–6 also start HDMA effects that scroll BG3 vertically and horizontally.

## Reusing combat—and unlocking more demos

Because the battle engine separates round calculation from presentation ([Chapter 6](06-resolving-a-battle.md)), attract mode skips stat math and RNG altogether and feeds hand-authored data straight to the renderers:

- **Map-battle demos ([engine/demo/demo_battles.asm](../../engine/demo/demo_battles.asm)):** `rlASMCLoadDemoMapScene` loads the chapter (`aDemoSceneChapters`), camera (`aDemoSceneCameraPositions`), and `wMainGameMode = 2`, and `rlASMCPlaceDemoSceneSprites` places the units (`aDemoSceneSpriteLists`). `rlRunDemoBattleSetup` then writes `aActionStructUnit1`/`2` and pushes hardcoded round words directly into `aBattleRoundsData`, after which `rlASMCStartDemoMapBattle` runs the real map-battle engine.
- **Full-screen battle scenes ([engine/demo/demo_battle_scenes.asm](../../engine/demo/demo_battle_scenes.asm)):** `rsLoadDemoBattle` reads an entry from `aDemoBattlesPointerTable` (combatants, classes, weapons, HP, terrain, quotes, and scripted rounds) into the battle-scene action structs and waits on `rlCreateProcEventWaitBattleSceneEnd`.

Both demo pools expand as the player clears the game and improves their saved ranking in SRAM ([Chapter 18](18-saving.md), [Chapter 21](21-endings-and-scores.md)):

| Demo pool | Index & wrapping | How unlocks scale with SRAM |
|---|---|---|
| **Map-battle scenes** (`12` total, `6` pairs) | `rlSetDemoIndexFromRanking` sets `wDemoIndex = 2 * (7 - rank) - 1` (using `6` if no rank is kept); each showing plays the odd/even pair and decrements back to `wDemoRestartIndex` | No clear → `1` pair (`1..0`); Rank E (`5`) → `2` pairs; D → `3`; C → `4`; B → `5`; Rank A (`1`) → all `6` pairs (`11..0`) |
| **Battle-scene demos** (`32` total, `16` pairs) | `rlASMCLoadNextDemoBattle` plays pair `wDemoBattlePair`, decrements it, and on wrapping past `0` reloads `min(rlGetHighestCompletionCount(), 15)` | Unlocks `1` additional pair per game clear, up to all `16` pairs (`32` battles) at `15` clears |

## Trade-offs and hard limits

Timeline slots are lighter than general procs and lock tightly to `wTitleScreenFrame` for music sync, though they only work on a screen with a single monotonic frame counter. Borrowing the battle scene's effect engines and `$7F/D000` RAM saves ROM bank space, and pre-scripted action structs let the attract mode showcase real map battles and battle scenes without maintaining separate demo renderers.

The limits:

- **16 timeline slots**, **13 title sprites**, and a **16-entry afterimage ring** per sprite.
- **12 map-battle demos** (6 rank tiers) and **32 battle-scene demos** (16 completion tiers).
- **Unreached title leftovers:** 13 unused slot installers/steps in [engine/title/title_scenes.asm](../../engine/title/title_scenes.asm) (such as `rlRestartTitleIntro` and `rlStopTitleSprite`) plus `aTitleSpriteScriptsAndFramesUnused`.

## Where it lives in the source

- [engine/title/opening_logo.asm](../../engine/title/opening_logo.asm) and [engine/title/title_screen.asm](../../engine/title/title_screen.asm): `rlLoadOpeningLogoScreen`, `rlTitleScreenSetup`, `rlTitleScreenStep`, `rsRunTitleTimeline`, `rlRunTitleLoadList`, `rlUpdateTitleSprites`, and the top/bottom IRQs.
- [engine/title/title_scenes.asm](../../engine/title/title_scenes.asm), [title_timelines.asm](../../engine/title/title_timelines.asm), [title_data.asm](../../engine/title/title_data.asm), and [include/TitleScreen.h](../../include/TitleScreen.h): the three timelines, scene setups, and sprite scripts.
- [engine/demo/opening.asm](../../engine/demo/opening.asm) and [opening_credits.asm](../../engine/demo/opening_credits.asm): `aOpeningEvent` and the 8 staff credit pages.
- [engine/demo/demo_battles.asm](../../engine/demo/demo_battles.asm) and [demo_battle_scenes.asm](../../engine/demo/demo_battle_scenes.asm): `rlSetDemoIndexFromRanking`, `aDemoBattleSetups`, and `aDemoBattlesPointerTable`.
- [docs/reference/title.md](../reference/title.md) and [docs/reference/demo.md](../reference/demo.md): the reference pages.

---

← Previous: [Chapter 19: Between Chapters](19-between-chapters.md) | [Contents](OUTLINE.md) | Next: [Chapter 21: Endings and Scores](21-endings-and-scores.md) →
