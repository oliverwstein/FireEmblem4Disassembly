# Castle

When the player's units go home to a castle, the game leaves the map for the **castle screen**. It has three parts: the **courtyard** shows every unit waiting in the castle; the **unit commands** send a unit out (sortie or guard) or act inside the castle; the **town** holds the facilities (shops, depot, augury, arena). Class change and the castle conversation scenes run on the same screen. Per-routine details: [routines/castle.md](routines/castle.md).

## Files

| File | Responsible for |
|---|---|
| [castle_screen.asm](../../engine/castle/castle_screen.asm) | the opener, VBlank routine and game state routines; the handler chosen on entry (`aCastleStateHandlers`); the 23 castle steps (`aCastleScreenStepHandlers`); fades and exits |
| [courtyard.asm](../../engine/castle/courtyard.asm) | the unit grid, the six unit commands, the town's facility buttons, the courtyard tables and sprites, the castle's song |
| [unit_commands.asm](../../engine/castle/unit_commands.asm) | the rules: who can sortie, guard, dance or give; the target list; deploying a unit; the castle action rounds; giving money |
| [keepers.asm](../../engine/castle/keepers.asm) | portraits: loading them, drawing them as sprites with a talking mouth; the keeper's dialogue box |
| [lists.asm](../../engine/castle/lists.asm) | what the facilities share: the stock, stored-item and weapon lists, their drawing and scrolling, item details, the yes/no prompt, the option menu, money |
| [shop.asm](../../engine/castle/shop.asm) | the shop screen used by the item shop, secondhand shop and repair shop; Bargain |
| [depot.asm](../../engine/castle/depot.asm) | the depot: storing items and taking them back |
| [augury.asm](../../engine/castle/augury.asm) | the fortune teller: love, record, parents |
| [class_change.asm](../../engine/castle/class_change.asm) | class change in the castle |
| [conversation.asm](../../engine/castle/conversation.asm) | the conversation scene: two portraits over a dialogue background |

The arena's menu, screen setup and opponent window are in [engine/arena/arena.asm](../../engine/arena/arena.asm), with the start of each fight (`rlStartArenaBattle`: the opponent is unit `$2100`, `wBattleType` 1, battle song `$3B`) and its result (`rlGetArenaBattleResult`: won, lost, or neither side fell).

Data: constants in [include/Castle.h](../../include/Castle.h); RAM `$087B`-`$08BA` (`wCastleScreenHandler`, `wCastleCursorState`, `wCastleGridSlot`, `wCastleUnitCommand`, `wCastleTownFacility`, the list cursors, `wConversation*`) and the castle block at `$7F757A` (`aCastleGridCharacters`, `aCastleUnitsByCharacter`, the list arrays `aCastleListItem*`, `wKeeper`, `lKeeperOptionList`) in [include/WRAM.h](../../include/WRAM.h). The `$7F` block reuses the map buffers, so its names are only written in the castle files (`SCOPED` in [tools/name_ram.py](../../tools/name_ram.py)). The shop, depot, augury, class change and arena lines are in [text/dialogue/Shops/](../../text/dialogue/Shops/).

## Control flow

### Entering

The map installs `rsOpenCastleScreen` as the main loop routine (through a fade proc). The opener resets the engines, sets the game state routines to `GAMESTATE_CASTLE_SCREEN_SETUP`/`_UPKEEP` and the VBlank routine to `rsRunCastleScreenVBlank`, then jumps through `wCastleScreenHandler`:

| Handler | Routine | Used when |
|---|---|---|
| `CASTLE_SCREEN_COURTYARD` (0, also 4) | `rlOpenCastleCourtyard` | A on the player's home castle with no unit picked up (`rlEnterHomeCastleAtCursor`, then `rlOpenCastleCourtyardFromMap`); the revive screen and a staff used outside, on their way back. A unit that enters its own army's home castle just goes inside (event action 4) |
| `CASTLE_SCREEN_TOWN` (1) | `rlResumeCastleTown` | a unit enters a castle other than its army's home, or a location of type 1 (`rlOpenCastleTownFromMap`): it goes straight to the town. The unit is `wCastleSavedUnitRAMPointer`, which `rlEndUnitAction` sets for every action |
| `CASTLE_SCREEN_CONVERSATION` (2) | `rlEnterCastleConversation` | an event or the dialogue engine starts a conversation scene |
| `CASTLE_SCREEN_ARENA` (3) | `rlEnterCastleArenaScreen` | coming back from an arena battle |
| `CASTLE_SCREEN_RELOAD_MAP` (5) | `rlReloadChapterMapAndOpenCastle` | coming back from another battle scene |

The VBlank routine draws the courtyard's unit sprites (`rlCastleDrawCourtyardUnitSprites`) every frame unless the town is up. The step routine `rlCastleScreenStep` runs `aCastleScreenStepHandlers[wGameStateStep]`. Each facility is a pair of steps: *setup* blanks the screen, loads graphics and lists and moves to *run*, which runs the facility's own sub-state table on `wMenuState` every frame. Moving between them goes through the fade steps: `CASTLE_STEP_FADE_OUT`/`_FADE_IN` change the brightness one level a frame and then move to the step in `wNextMenuState`.

### The courtyard

`rlCastleBuildCourtyardTables` lays out the units in the castle (`aCastleUnitDeploymentOffsets`, from `rlBuildCastleUnitList`: units whose home castle this is and who are neither fielded nor dead). Every character has a fixed slot on a 4x6 grid and a fixed spot in the courtyard picture, one table for generation 1 and one for generation 2. `wCastleCursorState` says where the cursor is:

- `CASTLE_CURSOR_GRID`: the D-pad moves over the grid (`rsCastleGridMoveCursor`), L and R jump to the next unit, X opens the status screen, Select opens the map's menu, B returns to the map (`CASTLE_STEP_EXIT_TO_MAP`). The bottom line shows the unit's name and HP, its status and the turns left, or the castle's name.
- A on a unit that has not moved and is not asleep: `CASTLE_CURSOR_COMMANDS`. Left and right step through six commands. The name of a command the unit cannot use is drawn grey.

| Command | Allowed when | Does |
|---|---|---|
| Town (まち) | always | fades out and opens the town for this unit (`CASTLE_STEP_REOPEN_TOWN`) |
| Sortie (しゅつげき) | `rlCheckUnitCanSortie`: not dead, moved or fielded; nothing on the castle tile; not Deirdre from chapter 3 on | deploys the unit on its castle's tile (`rlSortieUnitFromCastle`) and returns to the map |
| Guard (しゅび) | `rlCheckUnitCanGuard`: likewise, and the castle is not already guarded | returns to the map with the unit set to guard (map action mode 3) |
| Class change | not in chapter 6 | opens class change (`CASTLE_STEP_CLASS_CHANGE_SETUP`) |
| Staff (つえ) or Dance (おどる) | a dancer: `rlCheckUnitCanDance`; anyone else: has a usable staff | staff: opens the castle staff menu, then `CASTLE_CURSOR_STAFF_TARGET` (or the map, for a staff used there); dance: `rlBuildCastleDanceRounds` |
| Give (あげる) | `rlCheckUnitCanGive`: has money and some unit in the castle can receive it | `CASTLE_CURSOR_GIVE_TARGET`, then `rlCastleGiveMoney` |

Targets for a staff, dance or gift come from `rlBuildCastleTargetList`: each unit in the castle that passes `rlCheckUnitPassesTargetFilter` for the target type: the map's target filters (`aTargetFilterRoutines`) without the range check, and never the unit itself. The castle versions of staff and dance build their action struct with both units standing on castle terrain (`rlBuildCastleActionRounds`).

### The town

`rlCastleOpenTown` first runs the chapter's event conditions for action 6 (the character entering this castle). If an event runs, the castle waits (`CASTLE_STEP_WAIT`) and the conversation scene takes over. Otherwise the town shows six buttons, two rows of three. Byte `$05` of the castle's location entry (`structChapterCastleLocationEntry.Facilities`, read by `rlGetCastleFacilities`) says which facilities it has: all six in 39 of the 59 castles, none in 13 (`CastleFacility*` in [include/Castle.h](../../include/Castle.h)); the others are blanked. A on a button (`rsCastleEnterFacility`) sets the keeper (`wKeeper`), the item state the lists collect (`wCastleListItemState`) and the step:

| Button | Facility bit | Keeper | Item state | Step |
|---|---|---|---|---|
| repair shop | `$20` | `KEEPER_REPAIR_SHOP` | `ItemStateShop` | shop |
| secondhand shop | `$40` | `KEEPER_SECONDHAND_SHOP` | `ItemStatePawnbroker` | shop |
| depot | `$10` | `KEEPER_DEPOT` | `ItemStateSupply` | depot |
| arena | `$04` | `KEEPER_ARENA` | — | arena |
| augury | `$08` | — | — | augury |
| item shop | `$80` | `KEEPER_ITEM_SHOP` | `ItemStateShop` | shop |

B leaves the town: back to the courtyard, or, for a unit that came in from the map, onto the map at the castle.

### The facilities

All the keeper screens work alike: the keeper's portrait (OAM palette 5, mirrored) talks through a dialogue box (`rsSetupKeeperDialogueBox`). The lines come from `aShopDialoguePointers`, one table indexed by line group and keeper. Sub-state 1 always waits for the text and then moves to `wNextMenuState`. The options come from `lKeeperOptionList`, and each option's code chooses which list is drawn beside it (`rsDrawCastleListIcons`): 0 the stock, 1 and 2 the unit's inventory.

- **Shop** (`aShopStepHandlers`, 21 sub-states). The item shop offers *buy* and *belongings*. The belongings list can only be looked at, and the keeper tells you to look at the goods instead. The secondhand shop offers *sell* and *buy*, the repair shop only repair.
  - **Buying** (`$03`-`$08`): the stock is every item in the shop's item state (`rlBuildStockList`), from every castle: the owner is never compared, so the stock is every shop list put on sale so far in the generation (one castle per chapter has a list). Items the unit can't use (`rlCheckSelectedUnitCanUseItem`: rank, women-only weapons) are marked unavailable and can't be bought. The price is halved if the unit, its class or an item it holds has Bargain (`rlCheckUnitHasBargain`). Buying fails if the inventory has 7 items or the unit cannot pay.
  - **Selling** (`$09`-`$0C`): `rlSellInventorySlotItem`, then `rlMoveItemToSecondhandStock`. The item goes to `ItemStatePawnbroker` owned by this castle, but the stock list ignores the owner, so every secondhand shop offers it (the emulator confirmed it turns up where it was sold, 2026-11-22). Any unit can buy it back, for more than it sold for. Holy weapons can't be sold.
  - **Repairing** (`$0D`-`$10`): only items with a repair cost can be chosen, and the cost is halved with Bargain. An item with 50 or more kills gets a different line. `rlRepairSelectedUnitItem` (beside the buying routine in `unit_state.asm`) does the repair: if the unit cannot pay for all of it, it buys as many uses as its money pays for.
- **Depot** (`aDepotStepHandlers`, 13 sub-states): *deposit* moves an inventory item to `ItemStateSupply` (`rlSendInventorySlotItemToSupply`); *withdraw* lists the unit's stored items (`rlBuildUnitStoredItemList`) and gives one back if the inventory has room.
- **Augury** (`aAuguryStepHandlers`, 8 sub-states): every unit can ask about love and record; children (`UnitTypeDynamic`) can also ask about their parents. The setup writes the last topic index (1, or 2 for a child) and the topics 0, 1, 2 at `$7F8183`; the list is drawn from that index down.
  - *Record*: wins and losses (`rlGetUnitWinCount`, `rlGetUnitLossCount`).
  - *Parents*: father and mother.
  - *Love* (`rsAuguryAnswer`): takes the love points between the unit and its lover, or the unpaired unit of the other sex with the most points (`rlGetUnitLoverOrTopCandidate`). The points are kept on the woman's side. Exactly 500 is "bound to" (lovers), 400 and up "loves", 300 and up "likes", 200 and up "interested in", below that "not interested in anyone".
- **Class change** (`aClassChangeStepHandlers`, 6 sub-states): `rlGetPromotedClassIfAvailable` decides between "you cannot class change" (no promoted class), "you need level 20", and an offer of the new class. Yes starts `rlStartCastleClassChange`, which sets the class and plays the class change scene through the battle scene engine (`wBattleType` 2, battle song `$3C`). Before and after the change it saves the unit's total stats (`rlSaveSelectedUnitTotalStatsToBuffer`, into `aUnit1DataBuffer` and `aUnit2DataBuffer`); the scene's level up window shows the difference (`rsClassChangeStoreStatGains`), with no HP or luck gain. Generation 2 has its own keeper and lines.
- **Arena**: see [arena.asm](../../engine/arena/arena.asm). The castle sets it up (`rlArenaScreenSetup`, with the unit's equippable weapons from `rlBuildEquippableWeaponList`) and comes back to it after each fight (`CASTLE_SCREEN_ARENA`).

### The conversation scene

`rlConversationSceneSetup` loads dialogue background `wConversationBackground` (fountain, gate, alley, hallway, throne, cloister) and two portraits. `rlConversationSceneStep` animates the fountain or the throne room and starts `lConversationDialoguePointer`. Each frame it loads or fades portraits as `wConversationFlags` asks; the fades are four small procs, `procConversationFadeIn/OutLeft/RightPortrait`. When the text ends, `rsConversationEnd` leaves by `wConversationExitMode`:

| Exit | Goes to |
|---|---|
| `CONVERSATION_EXIT_COURTYARD` | the courtyard |
| `CONVERSATION_EXIT_TOWN` | the town, with the unit whose entry event ran (`wCastleEventUnit`) |
| `CONVERSATION_EXIT_MAP` | the map |
| `CONVERSATION_EXIT_CALLBACK` | fades out, then `rlShowNextEpilogueCharacterEnding` |
| `CONVERSATION_EXIT_FADE_OUT` | fades out and waits |

### The lovers' home castle conversation

[lover_conversation.asm](../../engine/castle/lover_conversation.asm). When a unit ends its move at its home castle, the map step (and the event command `rsEventCommandLoverHomeCastle`) calls `rlTryStartLoverHomeCastleConversation`. If the unit's lover is alive, off the map, and residing in the player's home castle (`rlCheckCharacterWaitingInHomeCastle`), and the woman's flag is not set yet, it sets the flag and opens the castle screen in conversation mode (`rlStartLoverHomeCastleConversation`), coming back to the map afterwards. The flags are the permanent flags `PermanentFlag...LoverHomeCastle` (`aLoverHomeCastleFlags`, by character ID), so each couple talks once. A mother and the daughter who can replace her share a flag.

The text is put together for each couple (`rlBuildLoverHomeCastleConversation`, run when the castle screen sees `wLoverHomeCastleConversationPending`). It is the arriving unit's line, from `aLoverHomeCastleArrivalLines` by its character ID, then the waiting lover's reply, from `aLoverHomeCastleReplyLines`, copied over the end code of the first. Both go to `$7F8183`. The lines are in [text/dialogue/LoverHomeCastle](../../text/dialogue/LoverHomeCastle), one file per character and side. Two ASMCs in them name the other person, with 様 added for Seliph and Leif.

## Depends on

- **Units** ([units.md](routines/units.md)): unit getters, love points, generation IDs, deploying units, `rlGetPromotedClassIfAvailable`.
- **Items** ([items.md](routines/items.md)): item RAM entries and states, prices, durability, buying, selling, sending to supply.
- **Map** ([map.md](routines/map.md)): location entries (`rlGetCastleFacilities`, `rlCheckIfCastleGuarded`), the location events, the map's menu proc, map sprites.
- **Dialogue** ([dialogue.md](routines/dialogue.md)): the dialogue engine, portraits and backgrounds.
- **Events**: chapter event action 6 when a unit enters a castle; events start conversation scenes.
- **Battle**: the action struct for castle staves and dances; the battle scene for class change and the arena.
- **Core**: the game state routines, procs, fades, HDMA, DMA.

## Open questions

- `wCastleCursorState` 2: the VBlank routine and `rlCastleScreenUpkeep` treat it like the town, but nothing found sets it.
- Step `$13` (`rsCastleStepExitToMapNoReset`) and shop sub-state `$14` (`rsShopLeaveToCourtyard`): nothing found selects them. (Step `$14` is B in the town.)
- Keepers 4 and 6, and option codes 3-5: present in the tables (`rsSetKeeperOptionList`, `aKeeperPortraits`) but not seen used.
- `$7F80A3`-`$7F80A7` hold both the fountain animation and the town's HDMA table, and are unnamed for now. `$7F8183` holds the augury topics; as the status screen's `wStatusScreenCaller` it is named only in the status screen's files (see [menus.md](menus.md)).
- `rlUnknown84D334` and `rlUnknown9EDAE7` (giving money) are still `Unknown`.
- Why class change is refused in chapter 6. In that chapter the command's label is drawn blank, its button gets another palette, and pressing it only plays the error sound (`rsCastleUnitCommandNameClassChange`, `rsCastleUnitCommandClassChange`); the code gives no reason.
