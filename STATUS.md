# Status

Current state and next steps. Read this first, then [PLAN.md](PLAN.md) (roadmap, per-wave checklist, engine guide). Past work and older technical notes are in [HISTORY.md](HISTORY.md); tool usage and 64tass pitfalls are in [tools/README.md](tools/README.md). **Rewrite this file at the end of every session** to keep it short and about the present.

## Current state (2026-11-24, after the Part I review)

Numbers come from `python3 tools/counts.py --fast --breakdown`; quote nothing else.

- `./build.sh` is byte-identical and checksums verify (`./build.sh mod` builds the identical ROM without `fe4.sfc`; GAPS.md is empty).
- Routines: 6,505 in `engine/`, 6,505 named, 0 `Unknown` (100.0% named). 172 pinned blocks.
- **Stage 1 and Stage 2 complete:** all 20 folders in `engine/` now have **0 `Unknown`** (`ai/`, `arena/`, `battle/`, `battle_scene/`, `castle/`, `core/`, `debug/`, `demo/`, `dialogue/`, `epilogue/`, `events/`, `items/`, `map/`, `menus/`, `rankings/`, `save/`, `sound/`, `title/`, `units/`, `worldmap/` — 6,505 routines total).
- Reference pages: `docs/reference/core.md`, `ai.md`, `arena.md`, `battle_scene.md`, `castle.md`, `demo.md`, `dialogue.md`, `epilogue.md`, `events.md`, `items.md`, `map_battle.md`, `map_menu.md`, `map.md`, `menus.md`, `save.md`, `title.md`, `units.md`, `worldmap.md` (`tools/reference.py` output is gitignored). Still missing: `battle/` (blocks Part III) and `rankings/`.
- Engine guide: [00-introduction.md](docs/guide/00-introduction.md), [OUTLINE.md](docs/guide/OUTLINE.md) (31 chapters in 7 parts, data first), [STYLE.md](docs/guide/STYLE.md), and the Part I opener [part-1-the-pieces-on-the-board.md](docs/guide/part-1-the-pieces-on-the-board.md), Chapter 1 [01-a-unit-is-made-of-parts.md](docs/guide/01-a-unit-is-made-of-parts.md), Chapter 2 [02-classes-stats-skills-and-weapon-ranks.md](docs/guide/02-classes-stats-skills-and-weapon-ranks.md), Chapter 3 [03-every-sword-is-an-individual.md](docs/guide/03-every-sword-is-an-individual.md), and Chapter 4 [04-armies-and-allegiance.md](docs/guide/04-armies-and-allegiance.md) (drafts); a draft of Chapter 6 (The turn) waits in `wip/the-turn-draft.md`.

## Remaining Unknowns

From `python3 tools/counts.py --fast --breakdown` (top-level `rl`/`rs` routines in `engine/`):

| System | Unknown | Total | Where | Notes |
|---|---:|---:|---|---|
| All 20 folders (`ai/` .. `worldmap/`) | 0 | 6,505 | — | 0 `Unknown` |
| **Total** | **0** | **6,505** | | **6,505 named (100.0%)** |

## Data, table and text Unknowns (2026-11-23 pass)

Routines are done; this pass named data. Distinct `*Unknown*` names in source went from 1,796 to 1,120 (`grep -rIoh '\b[A-Za-z_]*Unknown[A-Za-z0-9_]*'` over the tree minus `.git`, `build`, `wip`, `gfx`, `*.md`). Done: map magic procs, sprite infos, scripts, frames and palettes (4 raw scripts decoded with `tools/sprite_scripts.py`); 33 shop/arena/augury/class change texts (named from what they say); 83 tables named from their reader; menu texts, screen palettes, HDMA infos, UI tilemaps (files renamed too); debug menu labels. Findings: `UnitState0400` is `UnitStateAssault`; four Warp/Valflame routines tagged `Unused` are called from scripts that were raw bytes.

What's left, easiest first:
- **Labels used by one named routine** (~300: list each Unknown label with the labels that reference it). Name from the reader where its name and the data's shape say what the table is; skip the rest.
- **`aBattleScenePaletteEffects` targets** (80): name by which spell scripts use each effect ID (trace the battle animation scripts' palette effect commands).
- **`gcUnknown`** (261 compressed streams): asset work; name from the loading routine and confirm by rendering (`gfx/compressed/CATALOG.md`), per the asset rules.
- **Labels with no references** (114): don't call them unused until raw `.byte`/`.word` data near them is decoded; hidden pointers in raw scripts were the reason four "Unused" routines were wrong.
- `wUnknown` (51) WRAM variables, `aPortraitPaletteUnknown` (14), `aSoundUnknown` (12), the dialogueShopNN placeholders (named by table index; could take content names like the Unknown ones did).
- **Project Naga's build files** (github.com/Miacidae/Project-Naga-beta-v7) replace every graphic that carries text. Their `Graphics/_GraphicsInstaller.asm` repoints and comments map Naga files to vanilla streams; used for the intro captions, world map, genealogy wheel and battle labels (commit c0f5809). Its `MenuText/` is newly drawn English menu text in expanded ROM, so it maps only through its code patches. Darrman's FE4BinaryTranslation targets the FE Binary romhack; its text tables match ours where the layout is vanilla and add nothing new.

## Who wrote what

Claude's commits carry a `Co-Authored-By: Claude ...` line. Gemini wrote `f56d5ee`..`ef5fff9` (no `Co-Authored-By` trailer), Wave 10 (`3590264`..`ecdded8`), Waves 11–13 (`cfef06b`..`9ebe9bb`), Waves 14–15 (`1fb5962`..`ac2e45b`), Wave 16 (`495d670`..`80c1e1d`), Wave 17 (`d7054ee`..`4fa5320`, with evidence bodies and `Co-Authored-By: Gemini <noreply@google.com>`), and Wave 18 (`ea75480`..`0e1f146`, with evidence bodies and `Co-Authored-By: Gemini <noreply@google.com>`), and the guide outline, style guide, Part I opener, items/units cleanup and their reference pages (`c377271`..`61d8290`, no trailer). Claude reviewed that last run on 2026-11-24: the code cleanup's comment fixes and the reference pages' sampled claims (jealousy bug, faction `$0080` guard, healing order and costs, inheritance formulas, staff effects, pricing) all matched the code; corrections are in `496621f` and `9da974d`. Its earlier Wave 1 game-state names follow a template (`…Stub/Show/RunStep/Render`) and some don't match their code (`rlCastleScreenIdle` is a compare whose result is never used).

## Active decisions

- **Mechanics over visuals:** low-level rendering, HDMA, OAM, and spell *visual effect* helpers may stay `Unknown`; move on once a system's mechanics are done (unless explicitly pushing to literal 0 `Unknown` in Stage 2 below).
- **Sound is lowest priority:** no SPC700 driver work unless the user asks.
- **Batch emulator checks:** `fe4.cdl` covers the prologue; answer what the code can settle first, and collect remaining screen questions below.

## Next session

1. **Engine guide, Part I:** Chapters 1–4 are drafted (4 awaiting the user's read). Next: Chapter 5 (*Who stands where*) from `map.md`, which closes Part I. The old limits list in `git show 9da974d:docs/guide/00-introduction.md` ("What the structures cost the design") is raw material for each chapter's closing limits.
2. **Loose ends:**
   - Pad-test banks `$88`, `$9B`, and `$9F` (`./build.sh pad SECTION N`).
   - Fix `tools/songs.py` (stops at stale `aUnknown8A9D79`) before regenerating `audio/SONGS.md`, and investigate why `tools/stream_catalog.py` deleted catalog previews.
   - Check whether `tools/dialogue.py` decodes the Jugdral history texts (`engine/save/jugdral_history.asm`).
   - `wip/` holds `the-turn-draft.md` on purpose until Chapter 6 is written.

## Emulator questions (for one batched session)

Each is one screen. Answers so far are in HISTORY.md under the wave that asked them.

1. (When a save reaches chapter 6.) Augury with a generation 2 child: are there three topics (love, record, parents)? The code reads the topic count from `$7F8183`; only the screen shows which topics a child gets.
2. The unit command menu's mode 1: move a player unit onto its own home castle and choose たいき (wait). Does the command menu open again by itself, and which commands does it list? The code shows mode 1 follows a player unit ending its action at its home castle, hides attack, staff, items, dance, talk and give, and that B cannot close it; only the screen shows what the menu is for.
3. Where does まち (town) appear? The code shows it at a location of type 1 and that its handler opens the castle screen; one screenshot of a unit standing where it is offered settles what a type 1 location is.
4. The item window (from the map menu's item command) with a weapon selected: what is the sprite at the right edge, about (195, 76)? The code draws it only for weapons (`aUnknown89BE50`, tile `$0E`); the weapon type icon and the weapon triangle icons beside it are known.
5. (Needs a save that has finished the game.) The ranking screen: what are the 16 letters drawn from `aUnknown7FC70A`, and what row appears after the secret code (Select, Up, A, Down, B, Left, X, Right, Y, L, R, Start)? The code shows the code check (`rlCheckEpilogueSecretCode`) and where the row is uploaded; only the screen shows what it says.
6. The title screen's intro (let the game sit after the attract opening, about two minutes): what each of its eight scenes shows and what the captions say. The code shows the scenes' timing and setup (title.md); the captions are graphics, so only the screen shows their words.
7. A battle scene with Fortify or a dance (both combatants at the center, `BattleSceneFlagSolo2`): what does the screen show besides the two combatants? The code shows that the flag turns on HDMA entries 3 and 6; only the screen shows what they draw.
