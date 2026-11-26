# Engine guide: outline

Draft table of contents for the guide (see [PLAN.md](../../PLAN.md), "The engine guide"). The guide moves from the game's structured data—its units, items, armies, and board—through combat, the turn, stories, and long-term systems, down to screen rendering and the SNES hardware beneath it. The [introduction](00-introduction.md) supplies the high-level model of frames, game states, and procs until Part VII opens the lid on them.

Each chapter opens with a problem the developers faced, then walks through the solution, its trade-offs, and where it lives in the source. Short **Interludes** trace a single action across multiple systems from start to finish.

**Ready** means the system has a reference page in `docs/reference/` to write from. **Needs reference** means its page has to be written first, from the named source files.

## Part I: The pieces on the board

The structured game data—the nouns of *Genealogy of the Holy War*—and how they fit into 128 KB of RAM and 4 MB of ROM.

| # | Chapter | Opening problem | Patterns | Source | Status |
|---|---|---|---|---|---|
| 1 | **[A unit is made of parts](01-a-unit-is-made-of-parts.md)** | A playable lord needs a hundred bytes; a bandit needs almost none. | Flyweight; getters that hide where a field lives; fixed pools | `units/unit_data`, `unit_info`, `units`, `unit_creation`, `include/Characters.h` | Drafted |
| 2 | **[Classes, stats, skills, and weapon ranks](02-classes-stats-skills-and-weapon-ranks.md)** | A skill can come from a character, a class, or an item; a stat from a base, a class, a ring, and a weapon; a weapon rank from class and Holy Blood. | Data-driven tables; one query over several sources | `units/classes`, `stats`, `skills`, `data/class/`, `data/character/` | Drafted |
| 3 | **[Every sword is an individual](03-every-sword-is-an-individual.md)** | Weapons that remember their kills and pass from parent to child. | A global object table with indices as handles | `items/items`, `inventory`, `staves`, `include/Items.h` | Drafted |
| 4 | **[Armies and allegiance](04-armies-and-allegiance.md)** | An army can be neutral to the player and at war with its neighbor. | Relations per pair of factions instead of per unit | `units/factions`, `unit_state` | Drafted |
| 5 | **[Who stands where](05-who-stands-where.md)** | The unit record says who someone is; something has to say where they are. | The deployment table (structure of arrays); locations: castles and villages | `map/deployment`, `locations`, `map_sprites` | Drafted |

## Part II: Combat

How a fight is settled in memory and how units grow from it.

| # | Chapter | Opening problem | Patterns | Source | Status |
|---|---|---|---|---|---|
| 6 | **[Resolving a battle](06-resolving-a-battle.md)** | Weapon triangle, leadership, skills that fire on chance, doubling, durability, and a linear RNG that the boot checksums can quietly sabotage—all settled before anything is drawn. | Compute first, show later: battle rounds as a recorded result; linear RNG and anti-tamper hook | `battle/battle`, `battle_stats`, `effects`, `scripted_crits`, `core/random` | Drafted |
| 7 | **[Growing stronger](07-growing-stronger.md)** | Experience, level-ups, and class promotion. | Growth rolls against tables; promotion rules and class changes | `units/level_up`, `battle_scene/results`, class-change mechanics | Drafted |

## Part III: The map and the turn

How the player commands a chapter once the pieces are on the board.

| # | Chapter | Opening problem | Patterns | Source | Status |
|---|---|---|---|---|---|
| 8 | **[The turn](08-the-turn.md)** | A turn is where almost every system in the game converges: phases, music fades, healing, love points, and multi-step battle fallout that cannot collide on the same frame. | A thirteen-step state machine; consequences left as notes and handled on the next frame (an event queue) | `map/map_step`, `units/turn_start`, `map/phase_banner` | Drafted |
| 9 | **[Moving a unit](09-moving-a-unit.md)** | Where can this unit go, given terrain, foes, and its class? | Flood fill over a cost grid (a bucket queue); paths by climbing; the range overlay | `map/range_maps`, `unit_movement`, `map_cursor`, `input` | Drafted |
| 10 | **[Menus over the map](10-menus-over-the-map.md)** | A turn is a chain of choices, each with a way back. | A stack of option lists; windows as procs; which commands appear, and why; battle forecast and popups | `menus/map_menu`, `main_map_menu`, `unit_menu`, `item_list`, `inventory_full`, `battle_forecast`, `map/windows`, `map/popups`, `map/map_actions` | Drafted |

- **Interlude: One attack, cursor press to HP loss** — A vertical slice tracing a single player attack from target selection through the battle forecast, combat resolution, presentation, experience gain, and deferred turn consequences.

## Part IV: Stories and minds

The parts of the game written as content rather than code.

| # | Chapter | Opening problem | Patterns | Source | Status |
|---|---|---|---|---|---|
| 11 | **[The game is watching](11-the-game-is-watching.md)** | A castle seized, a talk, a death, a turn count: each might start a scene. | Gameplay announces an action; each chapter's list of conditions checks it (close to Observer, without subscriptions); event flags | `events/event_engine`, `chapter_data`, `talk_events` | Drafted |
| 12 | **[Screenplays](12-screenplays.md)** | Writers need to stage scenes without writing assembly. | Bytecode with an escape hatch (`RUN_ASM`); scripts that block on procs | `events/event_scripts`, `event_procs`, `event_movement`, `asmc`, `events/` | Drafted |
| 13 | **[Dialogue and text](13-dialogue-and-text.md)** | About 2,000 texts with portraits, pauses, and music cues, drawn a letter at a time alongside menu glyphs. | A text markup language; glyph/tile-run rendering; the box as a proc | `dialogue/`, `text/dialogue/`, `menus/menu_text` | Drafted |
| 14 | **[Armies with a mind](14-armies-with-a-mind.md)** | Dozens of enemies have to think without dropping a frame. | Time-slicing in the main loop; a cycle state machine; group scripts that set goals; general tactics code | `ai/` | Drafted |

- **Interlude: One enemy turn** — A vertical slice tracing how the main loop time-slices AI group scripts, threat maps, movement, and combat without dropping a frame.

## Part V: The long game

What carries across castles, chapters, and generations, along with the bookends of a playthrough.

| # | Chapter | Opening problem | Patterns | Source | Status |
|---|---|---|---|---|---|
| 15 | **[Castles and towns](15-castles-and-towns.md)** | A home base inside the map: shops, the pawn shop, repair, storage, the augury, class change, and conversations. | A screen within a screen; lists shared by many facilities | `castle/` | Drafted |
| 16 | **[The arena](16-the-arena.md)** | An opponent ladder inside the castle that reuses the battle engine while tracking yields, defeats, and prizes. | Reusing combat in a controlled loop; arena state per unit | `arena/` | Drafted |
| 17 | **[Love and lineage](17-love-and-lineage.md)** | Love points every turn, and children whose growths, blood, and weapons come from whom their parents married. | A 9 × 15 grid; derived data computed once at a generation change | `units/lovers`, `generations`, `inheritance`, `events/first_generation_ending` | Drafted |
| 18 | **[Saving](18-saving.md)** | Battery-backed SRAM, four slots, and data that must be written the moment it happens. | Serializing the pools; checksums | `save/` | Drafted |
| 19 | **[Between chapters](19-between-chapters.md)** | The world map, the chapter intro, and the history pages. | Another screen with its own frame; edge IRQs and layer HDMA | `worldmap/`, `save/jugdral_history` | Drafted |
| 20 | **[The opening](20-the-opening.md)** | The title screen, its intro, and an attract mode that plays real battles. | Timelines; reusing gameplay code as a demo | `title/`, `demo/` | Drafted |
| 21 | **[Endings and scores](21-endings-and-scores.md)** | Endings chosen from parents, lovers, and survivors; a ranking of the whole playthrough. | Data-driven endings; records kept across the game | `epilogue/`, `rankings/` | Drafted |

> **Epigraph for Chapter 17 (Love and lineage):**
> *"One generation passes away, and another generation comes;
> But the earth abides forever."* — Ecclesiastes 1:4

## Part VI: Putting it on screen

How the game renders maps, fights, and full-screen menus onto the SNES display.

| # | Chapter | Opening problem | Patterns | Source | Status |
|---|---|---|---|---|---|
| 22 | **[A map bigger than the screen](22-a-map-bigger-than-the-screen.md)** | A 64×64-tile map, and only enough video RAM for a little of it. | Tile streaming (new rows and columns as the camera moves); terrain from tile IDs | `map/chapter_maps`, `map_tilemap`, `scroll`, `camera`, `data/terrain/` | Drafted |
| 23 | **[Two ways to show a fight](23-two-ways-to-show-a-fight.md)** | One result, two presentations: a full battle scene or a quick one on the map. | Model and view kept apart | `battle/map_battle*`, `battle/map_magic_effects`, `battle/map_battle_hud` | Drafted |
| 24 | **[The battle scene](24-the-battle-scene.md)** | Backgrounds, two animated combatants, spell effects, quotes, and HP bars, in one screen. | A third bytecode (the scene script); animation frame programs; palette effects | `battle_scene/` | Drafted |
| 25 | **[Full-screen windows and the status screen](25-full-screen-windows-and-the-status-screen.md)** | Full-screen unit sheets, sortable overview tables, options, and the Valkyrie revive screen that take over the display and return to whatever opened them. | Shared menu VBlank (`rsRunMenuScreenVBlank`); scoped RAM reuse; caller-return pointers (`wStatusScreenCaller`); HDMA split scrolling; tile-run text drawing | `menus/status_screen`, `unit_window`, `item_window`, `skill_window`, `data_window`, `options_menu`, `revive_screen`, `game_over`, `window_graphics`, `menu_text` | Drafted |

## Part VII: Under the hood

How a program with no operating system keeps sixty frames a second, schedules concurrent effects, and talks to the sound chip.

| # | Chapter | Opening problem | Patterns | Source | Status |
|---|---|---|---|---|---|
| 26 | **[The frame](26-the-frame.md)** | The screen can only be changed for about 2.3 ms out of every 16.7 ms. How does a whole game's worth of drawing get through that gap, and how does the machine boot cleanly into it? | Game Loop; double buffering (PPU register buffer, OAM buffer); work queue (DMA struct array); boot checksums | `core/frame/` (`interrupts`, `boot`, `dma`, `ppu_buffers`, `joypad`, `frame`, `anti_tamper`), `include/Checksums.h` | Drafted |
| 27 | **[Screens](27-screens.md)** | A title screen, a castle, a map, and a battle each need a different frame. How does one program become many programs? | State; table of function pointers as polymorphism; setup, step, and upkeep; returning to the map (`rsReturnToMapMainLoop`) | `core/frame/game_states`, `map/map_loop`, `map/map_display` | Drafted |
| 28 | **[Procs](28-procs.md)** | A fade, a sliding window, and a scrolling camera all happen at once, and none of them can block. | Update Method; Bytecode (the proc script); cooperative multitasking; structure of arrays in depth | `core/proc`, `include/Procs.h` | Drafted |
| 29 | **[Sprites and scanlines](29-sprites-and-scanlines.md)** | 128 hardware sprites, and effects that change partway down the screen. | Active sprites as a second proc engine; HDMA scripts; the IRQ engine's sorted list of mid-frame interrupts | `core/display/` (`active_sprites`, `oam`, `hdma`, `irq`) | Drafted |
| 30 | **[Getting graphics in](30-getting-graphics-in.md)** | 4 MB of cartridge and 64 KB of video RAM. Graphics are compressed, and unpacking them is slow. | Compression; deferred work queue run from the main loop (`rlDecompressByList`); palettes and fades as data | `core/graphics/` (`decompressor`, `fade`, `palette_fade`, `palettes`, `tilemaps`) | Drafted |
| 31 | **The second computer** | A sound chip with its own CPU, reached through four one-byte ports. | Message passing; a sound command queue | `sound/`, `audio/` | Needs reference (sound, lowest priority) |

- **Interlude: One frame on the map** — A closing vertical slice tying the hardware stack back to a single 16.7 ms frame on the map, from NMI entry through VBlank uploads, game-state step, procs, map sprites, and leftover main-loop time.

## Appendices

- **A. Limits, and where they are enforced**: every fixed pool and table size, where it is checked, and what would have to change to lift it. Collected from the chapters.
- **B. ROM layout and shiftability**: how the 64 banks are divided between code, tables, events, graphics, and audio, and how `.section` relocations keep the build shiftable.
- **C. Leftovers**: the debug menu, the world map test, unused game states, and code nothing reaches (`debug/`, `core/unused_game_state`).
- **D. Glossary**: the hardware and project terms used in the guide.

## Order of writing

The order of reading is not the order of writing. Chapters marked Ready can be written now, in any order. A chapter that leans on a later one can link ahead until that one exists.

Proposed first: **Part I**, Chapters 1–5, in order; all five have reference pages (`units.md`, `items.md`, `map.md`).

Before Part II can be written, the reference needs a page for `battle/`.
