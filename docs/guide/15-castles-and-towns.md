# Chapter 15: Castles and towns

The **castle screen** is the game state for the inside of a castle, with its own frame routine and its own step table. It has four parts. The **courtyard** shows the units waiting in the player's home castle, one fixed seat per character, and gives each of them six commands: go to town, sortie, guard, class change, use a staff or dance, and give money. The **town** is a row of up to six buttons, one per **facility**: item shop, secondhand shop, repair shop, depot, augury, and arena. Each facility is a **keeper**, a portrait that talks through a dialogue box beside a list of items, topics, or weapons. The same screen also hosts the **conversation scene**, the full-screen backdrop with two portraits that events use for their longer scenes.

The castle screen changes no unit data of its own. It reads units and items through the same getters as the map, writes them back through the same setters, and keeps only its tables and cursors, in RAM it borrows from the map. Leaving it reloads the map display and hands control back to the map's main loop.

This chapter covers who is inside a castle and how the screen is entered and left, the castle screen as a state, the courtyard and its commands, the town and its facility bits, the keepers and the lists they share, each facility in turn, the conversation scene, and the costs. The arena has [Chapter 16](16-the-arena.md) to itself.

## Inside a castle

### Residence

Each unit's personal data has a **residing castle**, a location ID, and its unit states have a **fielded** bit ([Chapter 1](01-a-unit-is-made-of-parts.md)). A unit is inside a castle when it isn't fielded; the residing castle says which. The routine the disassembly calls `rlGetSelectedUnitHomeCastle` returns this byte, with carry set if the unit is on the map. It is a per-unit value, distinct from the army's home castle in its faction header ([Chapter 4](04-armies-and-allegiance.md)), though for most units the two agree.

Going inside sets both fields. `rlSetUnitResidingInCastle` writes the castle's ID into the unit, clears the fielded bit, marks the unit's deployment row hidden and moves it onto the castle's gate. The row stays in the deployment table ([Chapter 5](05-who-stands-where.md)), so nothing has to be re-created when the unit comes out.

The courtyard's unit list is a query over every unit header, not a stored list:

```rust
fn castle_unit_list(castle: LocationId) -> [Option<DeploymentOffset>; 24] {  // rlBuildCastleUnitList
    let mut list = [None; 24];
    let mut n = 0;
    for unit in aUnitRAMPointers {
        if unit.residing_castle() == castle                    // rlGetSelectedUnitHomeCastle
            && !unit.states().intersects(FIELDED | DEAD)
            && let Some(row) = unit.deployment_offset()
        {
            list[n] = Some(row);                               // aCastleUnitDeploymentOffsets
            n += 1;
        }
    }
    list
}
```

The list has 24 entries, as many as there are generation IDs (below), and the loop doesn't check its count.

### The ways in

Whoever opens the castle screen sets `wCastleScreenHandler` first, and the screen's opener dispatches on it:

| Handler | Opens | Reached by |
|---|---|---|
| `CASTLE_SCREEN_COURTYARD` (0, also 4) | the courtyard | A on the player's home castle with no unit picked up (`rlEnterHomeCastleAtCursor`); the revive screen and a map staff used from inside, on their way back |
| `CASTLE_SCREEN_TOWN` (1) | the town, for one unit | a unit entering a castle other than its army's home (the はいる enter command on an allied castle's gate, [Chapter 10](10-menus-over-the-map.md)) |
| `CASTLE_SCREEN_CONVERSATION` (2) | the conversation scene | `DIALOGUE_WITH_BG` in an event script, the lovers' home castle visits, the epilogue |
| `CASTLE_SCREEN_ARENA` (3) | the arena menu | the end of an arena fight's battle scene |
| `CASTLE_SCREEN_RELOAD_MAP` (5) | the courtyard, after reloading the map | the end of any other battle scene started from the castle |

A player unit that enters its own army's home castle from the map doesn't open the screen. It goes inside, the map step announces event action 4 ([Chapter 11](11-the-game-is-watching.md)), and it waits there until the player opens the courtyard. A unit that enters an allied castle is taken off the map into that castle (its residing castle becomes the visited one) and the screen opens straight at that castle's town. The town needs to know who walked in: `rlEndUnitAction` stores the acting unit in `wCastleSavedUnitRAMPointer` at the end of every action, so when the town opens the visitor is already there. Entering from the cursor stores `$FFFF`, no one.

The castle's location entry identifies the castle for everything that follows. `wEventLocationEntry` points at it and `wEnteredCastleLocationID` holds its ID; facilities, songs, and the courtyard all read one or the other.

## A screen within the screen

### Taking over the frame

The map installs `rsOpenCastleScreen` as the main loop routine through a fade proc. The opener blanks the screen, resets the sprite, HDMA, and IRQ engines, and replaces three things:

| Replaced | Map | Castle |
|---|---|---|
| VBlank routine | the map's | `rsRunCastleScreenVBlank` |
| main loop routine | `rsMapMainLoop` | `rsRunFrameTasks` |
| game state routines | map setup and step | `GAMESTATE_CASTLE_SCREEN_SETUP` (once), then `_UPKEEP` and the step `rlCastleScreenStep` |

The castle's main loop runs only the shared background tasks (the soft-reset check, the decompression queue, and a deferred sound upload), so the AI, which runs from the map's main loop ([Chapter 14](14-armies-with-a-mind.md)), can't run while the castle is open. The castle's VBlank routine is the usual list of uploads and input reads ([Chapter 26](OUTLINE.md)), plus the courtyard's unit sprites when the courtyard is showing and a call to the dialogue engine every frame for the keepers.

The opener also sets bit `$0020` of `wChapterFlags`, which tells code shared with the map that the castle screen is up: a unit relocation refreshes the courtyard instead of announcing an event, staff checks look for targets inside the castle, and battles started here use battle type 3.

### Steps

`rlCastleScreenStep` runs every frame. It first applies buffered deployment states and any queued unit relocation, exactly as the map step does ([Chapter 8](08-the-turn.md)), then runs step `wGameStateStep` from `aCastleScreenStepHandlers`, a table of 23 routines (`CASTLE_STEP_*` in [include/Castle.h](../../include/Castle.h)):

| Steps | Purpose |
|---|---|
| `$00`, `$01` | the courtyard and the town (the town is a cursor state of the courtyard's step) |
| `$02` | wait: nothing, while a fade proc, an event, or another screen has control |
| `$03`/`$04`, `$05`/`$06`, `$07`/`$08`, `$09`/`$0A`, `$0B`/`$0C`, `$0D`/`$0E` | a *setup* and a *run* step for each of the arena, augury, depot, class change, conversation scene, and shop |
| `$0F`, `$10` | fade out or in one brightness level a frame, then go to the step in `wNextMenuState` |
| `$11`, `$14` | reload the courtyard |
| `$12`, `$15` | reopen the town, without or with restarting the castle's song |
| `$13`, `$16` | leave for the map |

Each facility is a setup/run pair. Setup blanks the screen, loads the facility's graphics, portrait, and list, and moves to its run step. The run step dispatches every frame on its own sub-state, `wMenuState`, through the facility's table: `aShopStepHandlers` has 21 sub-states, `aDepotStepHandlers` 13, `aAuguryStepHandlers` 8, `aClassChangeStepHandlers` 6, the conversation scene 5, and the arena 16. Two levels of the State pattern, then: the castle step picks the facility, and the facility's sub-state picks the moment within it. Moving between facilities goes through the town, and every return to the town runs `rlCastleOpenTown` again.

Step `$14` runs the same routine as `$11`; B in the town uses it. Step `$13`, the exit to the map without resuming the phase music, has no caller.

### Borrowed memory

The castle screen keeps its tables in RAM that belongs to the map. The courtyard's tables, the list arrays, the keeper, and the cursors sit in a block at `$7F757A`-`$7F8092`, inside the map's buffers, and the courtyard's slot table is written into `aMovementMap` itself, which `rlClearMovementMapBuffer` zeroes (`$C38` bytes) each time the courtyard is built. Names in that block are scoped to the castle's files (`SCOPED` in [tools/name_ram.py](../../tools/name_ram.py)).

The map rebuilds its range maps when a unit is picked up, so the borrowing is safe in normal play. [Chapter 9](09-moving-a-unit.md) describes the one place it shows: undoing a guard chosen on the castle screen reads an `aMovementMap` the castle left behind.

### Leaving

Step `$16` waits for the screen to be fully bright, resumes the phase music, and creates a fade proc that switches the main loop to `rsReturnToMapMainLoop` ([Chapter 27](OUTLINE.md)), which rebuilds the map's display from the unit and location data. The castle steps to `$02` and waits for the fade to take it away.

A battle scene started from the castle (a staff, a dance, or a class change) overwrites the map's graphics and much of its RAM. Coming back, `CASTLE_SCREEN_RELOAD_MAP` reloads the chapter's map layout, redraws every location for its state, reapplies the map changes ([Chapter 11](11-the-game-is-watching.md)), restarts the music, rebuilds the castle's unit list, and only then opens the courtyard.

## The courtyard

### Seats

The courtyard has 24 seats on a 4 × 6 grid, one for each **generation ID**: the 15 men's and 9 women's IDs that the love and inheritance tables are indexed by ([Chapter 17](OUTLINE.md)). In generation 2 a child and the substitute who can join in its place share an ID, and so a seat. Each character's seat is fixed, by two tables per generation: `aCastleGridCharactersGen1`/`Gen2` map a grid slot to a generation ID, and `aCastleCourtyardSpotsGen1`/`Gen2` give each generation ID a spot in the courtyard picture. Chapter 6 on uses the generation 2 tables. `rlCastleBuildCourtyardTables` fills, from the unit list, a table from generation ID to unit (`aCastleUnitsByCharacter`) and each seat's sprite position, and counts the units present.

The VBlank routine draws each unit at its spot as a map sprite (`rlCastleDrawCourtyardUnitSprites`), grey if it has moved this turn or is asleep. A seat whose character isn't inside is an empty spot.

The cursor moves over the grid with the D-pad; L and R jump to the previous or next occupied seat, wrapping around. The bottom line shows the unit under the cursor (name and HP, or a status and its turns left) or the castle's name for an empty seat. X opens the status screen for the unit ([Chapter 25](OUTLINE.md)), which returns to the castle through `wStatusScreenCaller`. Select opens the same main menu the map opens. B leaves for the map.

### Commands

A on a unit that hasn't moved and isn't asleep opens its command bar, with the unit's portrait above it. Left and right move along six commands; the name of one the unit can't use is drawn grey, and choosing it plays the error sound.

| Command | Allowed when | Does |
|---|---|---|
| まち town | always | fades out and opens the town for this unit |
| しゅつげき sortie | not dead, moved, or fielded; the castle's gate is empty; not Deirdre from Chapter 3 on | deploys the unit on the gate and returns to the map; the cursor picks it up there ([Chapter 9](09-moving-a-unit.md)) |
| しゅび guard | the same, and the castle has no guard yet | puts the unit on the guarding spot and returns to the map in the castle-guard mode |
| クラスチェンジ class change | not in Chapter 6 | opens class change |
| つえ staff, or おどる dance for a dancer | a staff with a target, or a dancer with a target | below |
| あげる give | the unit has money and someone inside can take it | choose a unit inside; the money moves |

The Deirdre rule compares the character ID with `$10`. In Chapter 6 the class change label is blanked and the command refuses; the code gives no reason, and Chapter 6's castles also have no arena.

### Staves, dances, and gifts inside

A staff user's command opens a two-line menu: じょうない (inside the castle) and じょうがい (outside). Each line appears only when its list has a staff. Both lists are built by `rlBuildCastleStaffSlotLists`:

- **Outside** lists staves with a target on the map, measured from the tile one above the castle's gate. Choosing one deploys the unit on that tile (`rlSortieUnitNorthOfCastle`), returns to the map, and starts target selection there. The same routine sets bit `$0040` of `wChapterFlags`, and when the unit goes back inside afterwards the relocation code sees the bit and reopens the courtyard.
- **Inside** lists staves with a target among the units in the castle. Each staff effect has its own test (`aCastleStaffTargetChecks`): the five healing staves need a unit below full HP, Warp a unit of the same army, Restore a unit with a status, and Valkyrie always passes and opens the revive screen. Return, Rescue, Charm, and the four offensive staves never work inside. Every test except Valkyrie's also fails when the user is the only unit in the castle.

An inside target is chosen with the courtyard cursor, which jumps between the units of a target list (`rlBuildCastleTargetList`): every unit in the castle, other than the user, that passes the map's target filter for the staff ([Chapter 10](10-menus-over-the-map.md)) without the range test. Dance and give use the same list with their own filters: a unit that has moved, for a dance; a unit of the army under the 50,000-gold cap for a giver with Steal, or the giver's lover otherwise.

The action itself is a battle. `rlBuildCastleActionRounds` ends the user's action, fills the two action structs with both units standing on terrain 9, and builds the rounds ([Chapter 6](06-resolving-a-battle.md)) with battle type 3. With battle animations off, type 3 plays as a map battle whose two units are drawn at their courtyard spots (`rlGetMapBattleUnitScreenPosition`); with animations on, it is a full battle scene, and the castle reloads the map on the way back.

A dance inside has no single target. `rlBuildCastleDanceRounds` passes `$FFFF`, and the dance's effect routine, seeing the castle bit, refreshes every unit in the dancer's castle except the dancer. On the map, the same routine refreshes every unit in the target grid: each adjacent unit of the army that has moved. The dancer gets 10 experience either way.

## The town

### Opening

Every time the town opens, `rlCastleOpenTown` first announces event action 6 with the unit's character and the castle ([Chapter 11](11-the-game-is-watching.md)). If an event starts, the castle saves the unit in `wCastleEventUnit` and waits in step `$02` while the event's conversation scene runs, and the scene's exit (below) decides what follows. Chapter 2 uses this for Chulainn. Once he has been beaten in the arena ([Chapter 16](16-the-arena.md)), entering any of five castles runs his recruitment conversation, which exits back to the town:

```
CHECK_FLAG_SET FlagChapter02_ArenaChulainnDefeated
  CHECK_ENTERING_CASTLE_MENU FlagChapter02_ArenaChulainnPostDefeat, AnyCharacter, Ch02_Evans
    EVENT FlagChapter02_ChulainnRecruitment, EventChapter02ChulainnRecruitmentEvans
  CHECK_ENTERING_CASTLE_MENU FlagChapter02_ArenaChulainnPostDefeat, AnyCharacter, Ch02_Heirhein
    ...
```

With no event, the town screen loads: the castle's name, six buttons in two rows of three, the unit's portrait, and the castle's song (`aCastleSongs`, by the castle's name ID).

### Facility bits

Byte `$05` of a castle's location entry is its **facilities** (`structChapterCastleLocationEntry.Facilities`), one bit per button (`CastleFacility*` in [include/Castle.h](../../include/Castle.h)). `rlCastleBlankMissingFacilities` blanks the button of each facility the castle lacks, and `rsCastleEnterFacility` ignores A on it. Across the 59 castles in the chapter data:

| Facilities | Castles |
|---|---|
| all six (`CastleFacilityAll`, `$FC`) | 39 |
| all but the arena (`$F8`) | 4: Chapter 6's |
| secondhand shop, repair shop, depot, augury (`$78`) | 2: the Prologue's Chalphy and Yngvi |
| repair shop only (`$20`) | 1: Leonster in Chapter 7 |
| none | 13, at least one per chapter, among them each chapter's last castle to be taken |

A castle with no facilities still opens a town; all six of its buttons are blank.

A on a button sets the keeper, the item state the facility's lists collect, and the setup step:

| Button | Bit | Keeper | Item state | Step |
|---|---|---|---|---|
| repair shop | `$20` | `KEEPER_REPAIR_SHOP` | 4 (shop) | shop |
| secondhand shop | `$40` | `KEEPER_SECONDHAND_SHOP` | 5 (pawnbroker) | shop |
| depot | `$10` | `KEEPER_DEPOT` | 2 (supply) | depot |
| arena | `$04` | `KEEPER_ARENA` | — | arena |
| augury | `$08` | — | — | augury |
| item shop | `$80` | `KEEPER_ITEM_SHOP` | 4 (shop) | shop |

B leaves the town. A unit that came in from the courtyard goes back to the courtyard. A visitor from the map is sortied from its residing castle, now the visited one, onto that castle's gate, and the screen returns to the map.

## Keepers and shared lists

### The keeper

Every facility screen has the same parts: a background, the keeper's portrait, a dialogue box for the keeper's lines, an option row, a list, and the unit's money. The keeper's portrait is drawn as sprites in OAM palette 5, mirrored to face the list; the unit's portrait, where one is shown, uses palette 4. The box is the dialogue engine's keeper mode ([Chapter 13](13-dialogue-and-text.md)): a 30 × 6 area, two frames per character whatever the message speed option says, and no skipping with Start.

The keeper's lines come from one table, `aShopDialoguePointers`, of 89 long pointers into [text/dialogue/Shops/](../../text/dialogue/Shops/), indexed by a line's offset plus three times `wKeeper`: the same moment (greeting, "not enough money", "anything else?") has a line for each keeper. Each facility has the same rhythm: a sub-state starts a line and names the sub-state to go to after it, and sub-state 1 waits for the text to end and moves there. The option row is a list per keeper (`lKeeperOptionList`); the option under the cursor chooses which list is drawn beside it.

### The lists

The facilities' lists share one set of parallel arrays at `$7F7672`, a Structure of Arrays with one word per entry; the first five have room for 256 entries, the last for 8:

| Array | Holds |
|---|---|
| `aCastleListItemIndices` | the player item index ([Chapter 3](03-every-sword-is-an-individual.md)) |
| `aCastleListItemRAMPointers` | the item record |
| `aCastleListItemIDs` | the effective item ID (broken weapons show as broken) |
| `aCastleListItemROMPointers` | the item's ROM data |
| `aCastleListItemUnavailable` | `$FFFF` if the unit can't use the item |
| `aCastleListInventorySlots` | the inventory slot, for the arena's weapon list |

`wCastleListItemCount` counts the entries. Three builders fill the arrays, and every facility draws from them with the same row, price, durability, scrolling, and detail routines in [engine/castle/lists.asm](../../engine/castle/lists.asm):

| Builder | Collects | Used by |
|---|---|---|
| `rlBuildStockList` | every item in state `wCastleListItemState` | the item shop, the secondhand shop |
| `rlBuildUnitStoredItemList` | items in that state owned by the selected unit | the depot |
| `rlBuildEquippableWeaponList` | the unit's weapons it can equip, equipped first | the arena |

The unit's inventory has its own list, the eight-slot record ([Chapter 3](03-every-sword-is-an-individual.md)), and the sell, repair, and deposit options draw it directly.

## Shops

### One stock per generation

`rlBuildStockList` is a query over the item table:

```rust
fn stock_list(state: ItemState) {                                  // rlBuildStockList
    wCastleListItemCount = 0;
    for index in 1..=item_count() {
        let item = item_record(index);
        if item.state != state { continue; }                       // the owner is never compared
        let entry = push_entry(index, item);
        entry.unavailable = !selected_unit_can_use(item);          // rlCheckSelectedUnitCanUseItem
    }
}
```

The loop compares the item's state and nothing else. Item records in the shop and pawnbroker states have an owner, a castle ID, but no list reads it. Every item shop sells the same stock, and every secondhand shop offers everything sold anywhere.

The stock comes from the chapter data. A castle's location entry has a pointer to a shop list of player item indices, and `rlInitLocation` puts each listed record that is still unobtained into the shop state when the chapter's locations are set up. One castle per chapter has a list, the player's starting castle, and the Prologue, Chapter 5, and the Final Chapter have none:

| Chapter | Castle | Items |
|---|---|---|
| 1 | Evans | 4 |
| 2 | Evans | 4 |
| 3 | Agusti | 5 |
| 4 | Sailane | 3 |
| 6 | Tirnanog | 6 |
| 7 | Ribaut | 23 |
| 8 | Ulster | 21 |
| 9 | Meath | 15 |
| 10 | Perlucos | 7 |

Nothing takes an item out of the shop state except a purchase, so the stock grows by one list per chapter. A Slim Sword left unbought in Chapter 1 is still for sale in Chapter 4. At the start of Chapter 6, `rlResetUnitsForChapter` returns every shop and pawnbroker record to unobtained ([Chapter 17](OUTLINE.md)), and the generation 2 lists start the stock over.

### Buying, selling, repairing

The item shop offers *buy* and *belongings*; belongings shows the unit's inventory and can't be chosen from. The secondhand shop offers *sell* and *buy*, and with nothing in stock its keeper greets the unit with a sell-only line. The repair shop goes straight to the unit's inventory and sends away a unit with no items. Prices come from the item record ([Chapter 3](03-every-sword-is-an-individual.md)); every one of them is paid from or into the visiting unit's own money.

**Buying** refuses three ways. An item the unit can't use is drawn grey and plays the error sound: `rlCheckSelectedUnitCanUseItem` passes rings and other items, holy weapons, and weapons and staves whose rank the unit has, and refuses a women-only weapon to a man. A unit with seven items is told its hands are full, and a unit that can't pay is told so. Otherwise the keeper asks to confirm, and `rlBuyItemForSelectedUnit` gives the record to the unit and takes the price, halved if the unit, its class, or anything it carries has Bargain (`rlCheckUnitHasBargain`). After a purchase the stock list is rebuilt.

**Selling** (`rlSellInventorySlotItem`) refuses holy weapons; anything else leaves the inventory for the unit's money, and `rlMoveItemToSecondhandStock` puts the record in the pawnbroker state with the entered castle as its owner. The same record, with its kills and wear, is then on sale in every secondhand shop.

**Repairing** lists the inventory with each item's repair cost, halved with Bargain, and only items with a cost can be chosen. A weapon with 50 or more kills gets its own line from the keeper. `rlRepairSelectedUnitItem` restores full durability if the unit can pay for all of it; otherwise it buys as many uses as the money covers, at the per-use cost, and leaves the remainder of the money.

## The depot

The depot stores items per unit. Deposit lists the inventory and moves the chosen item into the supply state owned by the unit (`rlSendInventorySlotItemToSupply`); any item can be deposited. Withdraw lists the unit's stored items (`rlBuildUnitStoredItemList`) and gives one back if the inventory has room. Each option checks its list first: a unit with an empty inventory or an empty store gets a line saying so.

Because the owner is the unit, storage follows the unit from castle to castle and chapter to chapter: any castle's depot shows the same items for the same unit. At the generation change, a deleted parent's stored items revert to unobtained with the rest of their records ([Chapter 3](03-every-sword-is-an-individual.md)).

## The augury

The fortune teller answers questions on a short list of topics. `rlAuguryScreenSetup` writes the topics into a small array: love and record for every unit, and parents too for a generation 2 child (unit type dynamic, [Chapter 1](01-a-unit-is-made-of-parts.md)). The topic list is drawn from the last index down, so a child sees three topics and anyone else two.

- **Record** reads the unit's win and loss counts (`rlGetUnitWinCount`, `rlGetUnitLossCount`), which are kept per generation ID in two halves, one per generation.
- **Parents** names the child's father and mother.
- **Love** finds the unit's lover, or, without one, the unpaired unit of the other sex with the most love points (`rlGetUnitLoverOrTopCandidate`; a tie goes to the later unit in the list), and reads their points. The points are kept on the woman's side of the love table ([Chapter 17](OUTLINE.md)), so a man's question looks up his own ID in the woman's row.

| Love points | Answer |
|---|---|
| exactly 500 | they are lovers |
| 400 and up | loves |
| 300 and up | likes |
| 200 and up | is interested in |
| below 200, or no candidate | is interested in no one |

## Class change

Class change is a unit command, not a town facility, but it runs on the same keeper screen with its own keeper. `rlGetPromotedClassIfAvailable` decides between three lines: no promotion at all, a promotion the unit hasn't reached level 20 for, or an offer of the new class. Generation 2 has its own keeper lines. A yes fades out and starts the class change, which [Chapter 7](07-growing-stronger.md) describes: the class ID is written, and a battle scene with no rounds (battle type 2) shows the stat differences as a level up. The scene returns through `CASTLE_SCREEN_RELOAD_MAP` to the courtyard.

The class change command sets the list item state to 3, which no item ever has, so the list its screen builds is always empty.

## The conversation scene

### Setup

The conversation scene is a castle step that events borrow. It is entered with handler 2, and `rlConversationSceneSetup` reads four variables the caller has set:

| Variable | Holds |
|---|---|
| `lConversationDialoguePointer` | the text |
| `wConversationBackground` | the background (`DIALOGUE_BG_*`: fountain, gate, alley, throne, hallway, cloister) |
| `wConversationFlags` | which portraits and windows to show, load, or fade (below) |
| `wConversationExitMode` | where to go when the text ends |

`DIALOGUE_WITH_BG` fills them from its arguments ([Chapter 12](12-screenplays.md)): `procDialogueWithBG` copies the text pointer, background, exit mode, and fade timer, then fades the map out into the castle screen.

The background is a full-screen picture with two tile sets, two tilemaps, and a palette (`rlLoadDialogueBackground`). Two of the six are animated every frame: the fountain (`rsAnimateFountainBackground`), and the throne room, which cycles four palettes (`aThroneBackgroundPaletteAnim1`-`4`).

The portraits are sprites. The left speaker is drawn through the keeper's routine, in OAM palette 5, mirrored, and the right speaker through the unit portrait's, in palette 4; the windows behind them are tilemaps on a background layer. The dialogue engine, running in conversation mode ([Chapter 13](13-dialogue-and-text.md)), drives them through `wConversationFlags`:

| Bit | Meaning |
|---|---|
| `$01`, `$02` | left, right portrait shown |
| `$04`, `$08` | left, right window frame drawn |
| `$10`, `$20` | load the left, right portrait and start its fade-in |
| `$40`, `$80` | send the left, right window's tiles this frame |

`DIALOGUE_LOAD_PORTRAIT` in this mode sets a load bit, and the scene's step loads the portrait on its next frame and creates a fade-in proc. The proc saves the portrait's 16 colors, clears the palette to black, and fades back up over 16 steps. Closing a portrait creates a fade-out proc that fades to black in 8 steps and then clears the shown bit, unless a fade-in for the same side is still running.

### Exits

When the text ends, `rsConversationEnd` leaves by `wConversationExitMode`:

| Exit | Goes to | Set by |
|---|---|---|
| `CONVERSATION_EXIT_COURTYARD` (0) | the courtyard, with the unit list rebuilt | no script |
| `CONVERSATION_EXIT_TOWN` (1) | the town again, for `wCastleEventUnit` | 1 script: Chulainn's recruitment, run on entering a town |
| `CONVERSATION_EXIT_MAP` (3) | the map, through `rsReturnToMapMainLoop` | 185 scripts; the lovers' home castle visits |
| `CONVERSATION_EXIT_CALLBACK` (4) | a fade, then the next epilogue page (`rlShowNextEpilogueCharacterEnding`) | the epilogue ([Chapter 21](OUTLINE.md)) |
| `CONVERSATION_EXIT_FADE_OUT` (5) | a fade to black; the scene then waits | 18 scripts, whose next commands rebuild the screen |

`DIALOGUE_WITH_BG`'s handler first sets exit 0 and the proc then overwrites it with the script's argument, so no script reaches the courtyard exit.

### The lovers' home castle visits

When a unit goes into its home castle while its lover waits inside, the two have a short conversation, once per couple. After a unit goes into its home castle from the map, the map step announces event action 4, and if no event starts it calls `rlTryStartLoverHomeCastleConversation` (an event command, `rsEventCommandLoverHomeCastle`, calls it too). It checks that the unit has a lover, that the lover is alive, a player unit, off the map, and residing in the player's home castle (`rlCheckCharacterWaitingInHomeCastle`), and that the woman's permanent flag in `aLoverHomeCastleFlags` is clear. Then it sets the flag and opens the conversation scene with the arriving unit on the left, the fountain behind them, and exit 3. A mother and the daughter who can stand in for her ([Chapter 13](13-dialogue-and-text.md)) share a flag.

The text is assembled on the way in. `rlBuildLoverHomeCastleConversation` copies the arriving unit's line from `aLoverHomeCastleArrivalLines` into RAM at `$7F8183`, then appends the waiting lover's reply from `aLoverHomeCastleReplyLines` over the first line's end code. Each table is indexed by character ID, so any arrival line can meet any reply: 63 arrival lines and 63 replies cover every couple, and four short name texts make up the 130 in the folder. Two ASMC commands in the lines insert the other person's name, adding 様 (sama) for Seliph and Leif.

## Trade-offs and limits

The castle screen is cheap in memory because it owns almost nothing. Units, items, money, and love points stay where the map keeps them, and the screen's tables live in borrowed map RAM and are rebuilt every time a part of the screen opens. The facilities share one list format and one set of drawing routines, and the keeper pattern turns each facility into a sub-state table plus a column of lines.

The queries are simple. Shop and pawnbroker records carry an owning castle that nothing reads, so the facility bits are all that distinguishes one town's shops from another's, and the stock is one pool per generation. Step `$13`, shop sub-state `$14`, keepers 4 and 6, and option codes 3 to 5 are in the tables with no way to reach them.

The limits:

- **24 seats**, one per generation ID; a unit without a generation ID has no seat.
- **24 units in the castle list**, with no count check.
- **256 entries per list array**, more than the 140 player items that exist.
- **Seven items** to buy or withdraw into; the eighth inventory slot isn't offered.
- **One shop list per chapter**, accumulating until Chapter 6.
- **Love answers** read only one candidate, and only five bands of points.

## Where it lives in the source

- [engine/castle/castle_screen.asm](../../engine/castle/castle_screen.asm): the opener, VBlank routine, game state routines, the five handlers, the 23 steps, fades, and exits.
- [engine/castle/courtyard.asm](../../engine/castle/courtyard.asm): the seats and their tables, the cursor, the six commands, the town's buttons and facility bits, the courtyard sprites, and the castle songs.
- [engine/castle/unit_commands.asm](../../engine/castle/unit_commands.asm): who can sortie, guard, dance, or give; the target list; deploying on or above the gate; the castle action rounds; giving money.
- [engine/castle/keepers.asm](../../engine/castle/keepers.asm): portraits as sprites and the keeper's dialogue box.
- [engine/castle/lists.asm](../../engine/castle/lists.asm): the list arrays, their builders, drawing, and input; the yes/no prompt and the option row.
- [engine/castle/shop.asm](../../engine/castle/shop.asm), [depot.asm](../../engine/castle/depot.asm), [augury.asm](../../engine/castle/augury.asm), [class_change.asm](../../engine/castle/class_change.asm): the facilities.
- [engine/castle/conversation.asm](../../engine/castle/conversation.asm) and [lover_conversation.asm](../../engine/castle/lover_conversation.asm): the conversation scene and the lovers' visits.
- [engine/units/unit_state.asm](../../engine/units/unit_state.asm): buying, selling, repairing, storing, and residing in a castle; [engine/map/locations.asm](../../engine/map/locations.asm): `rlBuildCastleUnitList` and the shop lists' setup; [engine/items/staves.asm](../../engine/items/staves.asm): the inside staff tests; [engine/battle/battle.asm](../../engine/battle/battle.asm): the castle dance.
- [include/Castle.h](../../include/Castle.h): handlers, steps, cursor states, commands, facility bits, keepers, exits; the castle's RAM is in [include/WRAM.h](../../include/WRAM.h); each chapter's castles, facility bits, and shop list are in [events/](../../events/).
- [docs/reference/castle.md](../reference/castle.md): the reference page.
