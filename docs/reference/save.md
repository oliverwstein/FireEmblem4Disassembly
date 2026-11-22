# Save

The game keeps four save slots in battery-backed SRAM (`$306000`-`$307FFF`, 2 KB each). A save packs the whole game state into a slot as bitfields, and loading unpacks it and rebuilds every unit. A few things live in SRAM outside the slots' game state and are written as they happen, not when the player saves: unit losses, the game timer, the last used options, the best final ranking, the last saved slot and the anti-tamper mark. Per-routine details: [routines/save.md](routines/save.md).

## Files

| File | Responsible for |
|---|---|
| [save.asm](../../engine/save/save.asm) | everything here: the save menu's openers and main loop (bank `$80`); saving, loading, checksums, slot management, losses and the timer (bank `$91`); rebuilding units from the save buffers (bank `$87`) |

The file and save menus' screens are in bank `$91`, not yet named.

Data: the slot layout `structSaveDataEntry` and the save constants (`SAVE_MAGIC_NUMBER`, the SRAM tags) in [include/Save.h](../../include/Save.h); the SRAM map `aSRAM` in [include/SRAM.h](../../include/SRAM.h); the working block `aSave` (`$1B09`: menu operation, active slot, save data word, the four slots' data words, the timer, bit offsets) and the unit buffers (`aUnit1DataBuffer` at `$7FEB4A`) in [include/WRAM.h](../../include/WRAM.h). The bit widths of each saved field are in the `aSave...` tables in [engine/save/](../../engine/save/save.asm).

## A slot

Each slot is a `structSaveDataEntry`:

- **`SaveData`**, the first byte: the save ID (bits 0-2, unique among the slots, from `rsGetNewUniqueSaveID`), the completion count (bits 3-6) and a finished flag (bit 7, `rlSetSaveSlotCompletionFlag`). With `CurrentChapter` after it, this is the slot's "data word", copied for all four slots into `aSave.aSlotDataBuffer`.
- **The game state**, from offset 1 to `$07BB`, packed as bitfields: chapter and turn, options, map and cursor position, map changes, counters, the turn counts of each chapter, win counts, the random number array, join order, faction headers, all 144 player items, locations and their rewards, permanent flags, chapter events, and every unit.
- **`MagicNumber`** (`$07BC`): `SAVE_MAGIC_NUMBER` (`$9207`). Loading also accepts `SAVE_MAGIC_NUMBER_OLDER` (`$1206`), which this ROM never writes: that format stores the items in another order (`aSaveOlderItemOrder`) and turn `$FF` between chapters.
- **`Checksum`** (`$07BE`): the sum of the bytes from offset 0 to `$07BD` with carries, plus 1. A slot is valid when the checksum and magic number match (`rsFillSaveSlotDataBuffers`); erasing a slot (`rlEraseSaveSlot`) stores the checksum plus 1, so it no longer matches.
- **`UnitLossesCount`** (48 bytes) and **the game timer** (two words), after the checksum, so they can change without re-summing the slot.

The words after each slot hold `wLastUsedOptions`, `wRankingScore`, `wAntiTamperMark` and `wLastSavedSlot`.

## Saving and loading

The save menu sets `aSave.wMenuOperation` to the slot (1-4), with bit 15 set for a load; `rlHandleSaveFile` acts on it.

**Saving** (`rlSaveToSaveSlot`): clears the slot, writes the timer and losses, then the body (`rsSaveSaveFileBody`): each part is a list of (offset, bit width) pairs read by `rsSaveBitpackedDataOffsets` and written bit by bit (`rsWriteBitpackedSaveData`) from `aSave.wAvtiveSaveSlotOffset`. Units go through the buffers: a unit's personal, extended, ROM, inventory and lover data are copied into `aUnit1DataBuffer` and compacted (`rlCompactStaticDynamicUnitBuffer1UnitStates`...) before packing, and each item records its owner's character ID and inventory slot. Then the magic number and checksum, the last used options, and `rlSetLastSavedSlot`.

**Loading** (`rlLoadFromSaveSlot`): resets the game's RAM, reads the timer and losses, then the body in the same order. Each unit is rebuilt by `rlCreateUnitFromBuffers`: allocate the unit and its data blocks by unit type (static, dynamic, holy, enemy; `aSave.wCreatedUnitType`), unpack the buffers into them, and restore what the save does not keep (`rsRestorePersonalData`: love data ID, cleared bonuses, class money; `rsRestoreLeadershipStars`; a child's constant data; `rsGatherUnitItems`, which finds the unit's items by owner ID and slot and writes the unit pointer over them; inventory; lover data for female units). The unit is put back on the map (`rsRestoreUnitDeployment`) and in its faction's list (`rsAddUnitToFaction`).

**A new game** (`rlStartNewGameSave`) takes a save ID no slot uses and clears the losses and timer.

## Written as they happen

- **Unit losses**: `rlRecordUnitLoss` counts a loss in `aUnitLossesCount` and straight away in every slot that holds the same save at the same chapter (same save ID and chapter in the data word), so resetting does not undo it. The index is generation ID - 1, plus 24 from chapter 6 (`rlGetUnitLossCount`); the arena, augury and rankings read it.
- **The game timer**: `rlTickGameTimer` runs from the interrupt handlers once a frame while a save is active and writes the timer into the same slots every `$800` frames. `rlGetGameTimeHoursMinutes` turns it into hours and minutes.
- **The final ranking**: when a slot is marked finished, `rsKeepFinalRanking` keeps the ranking (plus 1) in `wRankingScore` under the tag `SRAM_RANKING_TAG`, unless the kept one is lower.
- **The last saved slot**: under `SRAM_LAST_SAVED_SLOT_TAG`; the file menu starts on it.
- **The anti-tamper mark**: when the code checksum check fails, the game writes `SRAM_ANTI_TAMPER_MARK` and stops in an endless loop after `rlUnknown91E8CC`; failing again with the mark already there takes the other path (`rlUnknown91E8C1`). A later boot with a good checksum clears it (`rlUnknown878074`). See [include/Checksums.h](../../include/Checksums.h).

## Depends on

- **Units** ([units.md](routines/units.md)): RAM areas and allocation, unit data blocks, deployment, the getters and setters the rebuild uses.
- **Items** ([items.md](routines/items.md)): item RAM entries, equipment from ROM, the equipped weapon's bonus.
- **Core** ([core.md](core.md)): the interrupt handlers (timer), boot (last used options), the code checksums.
- **Rankings, arena, castle**: read the losses and the completion count.

## Open questions

- Whether a lower kept ranking value is the better rank (`rlCalculateFinalRankingScore`).
- The file and save menu screens in bank `$91` (`rsSetupSaveSelectMenu`, `rsOpenMapSaveMenu` and the code they call) are not yet named.
- What the `Unknown` fields of `structSaveDataEntry` hold (`Unknown0006`, `Unknown0013`, the unnamed words after `UnitLosses`).
- Where saves in the older format (`$1206`) came from.
