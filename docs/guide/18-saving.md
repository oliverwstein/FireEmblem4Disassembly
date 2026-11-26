# Chapter 18: Saving

*Genealogy of the Holy War* lets the player save at the start of every turn, between castles, and between chapters, while tracking up to 72 live units, 144 item slots (the 140 defined player items plus four spare slots), 7 factions, locations, permanent flags, chapter event flags, win counts, turn counts, and the 56-entry RNG table. All of that state must fit into 2 KB per slot inside an 8 KB battery-backed SRAM chip (`$30/6000`–`$30/7FFF`), alongside a handful of counters—unit losses, the game timer, the best final ranking, and an anti-tamper mark—that must persist immediately when they happen rather than waiting for the next manual save.

This chapter covers the 8 KB SRAM layout, bitpacked serialization and unit reconstruction on load, the counters written in place as events occur, the save menu screen, and the hard limits.

## The 8 KB SRAM map

Battery-backed SRAM holds **four** 2 KB (`$0800`-byte) save slots (`aSaveSlot1`–`aSaveSlot4` in [include/SRAM.h](../../include/SRAM.h)), any one of which can also be designated as the auto-save slot in the Options menu. Four global 16-bit words sit in the final two bytes of each 2 KB block, outside the save slots' checksums:

```
$30/6000 ┌───────────────────────────────────────┐
         │ aSaveSlot1 (2,046 bytes)              │
$30/67FE │ wLastUsedOptions (2 bytes)            │
$30/6800 ├───────────────────────────────────────┤
         │ aSaveSlot2 (2,046 bytes)              │
$30/6FFE │ wRankingScore (2B, tag $F290)         │
$30/7000 ├───────────────────────────────────────┤
         │ aSaveSlot3 (2,046 bytes)              │
$30/77FE │ wAntiTamperMark (2B, $6A19 on fail)   │
$30/7800 ├───────────────────────────────────────┤
         │ aSaveSlot4 (2,046 bytes)              │
$30/7FFE │ wLastSavedSlot (2B, tag $D8C0)        │
         └───────────────────────────────────────┘
```

Inside each `structSaveDataEntry` ([include/Save.h](../../include/Save.h)), the checksum covers the header and bitpacked body while live counters sit after it:

| Offset | Field | Size | Covered by checksum? |
|---|---|---|---|
| `$0000` | `SaveData` (bits `0..2` Save ID `1..7`; bits `3..6` completion count; bit `7` finished flag) | 1 B | Yes |
| `$0001..$07BB` | Bitpacked game state (chapter, turn, options, camera, cursor, turn counts, wins, RNG array, join order, factions, 144 items, locations, permanent flags, events, units) | 1,979 B | Yes |
| `$07BC..$07BD` | `MagicNumber` (`SAVE_MAGIC_NUMBER = $9207`; loader also accepts `$1206`) | 2 B | Yes |
| `$07BE..$07BF` | `Checksum` (16-bit byte sum of `$0000..$07BD` with carry, plus `1`) | 2 B | — |
| `$07C0..$07EF` | `UnitLossesCount` (48 byte counters) | 48 B | No |
| `$07F0..$07F3` | `GameTimerLow`, `GameTimerHigh` (32-bit frame counter) | 4 B | No |

Together with `CurrentChapter` at `$0001`, `SaveData` forms a slot's 16-bit "data word," cached for all four slots in `aSave.aSlotDataBuffer`.

## Bitpacking and serializing the pools

### The bit cursor and data tables

Fixed-byte structs waste too much space for 144 items and 72 units, so `rsSaveSaveFileBody` and `rsLoadSaveFileBody` in [engine/save/save.asm](../../engine/save/save.asm) stream fields sequentially through a running bit cursor (`aSave.wCurrentBitOffset`) into `aSRAM`:

```rust
fn write_bitpacked(val: u16, bits: u16) {                  // rsWriteBitpackedSaveData
    if bits == 0 { return; }
    let mut lo = val & BITMASK[bits - 1];                   // aSaveDataBitmasks
    let mut hi = 0u16;
    let shift = aSave.wCurrentBitOffset & 7;
    for _ in 0..shift {
        let carry = lo >> 15;
        lo <<= 1;
        hi = (hi << 1) | carry;
    }
    let byte_off = aSave.wActiveSaveSlotOffset + (aSave.wCurrentBitOffset >> 3);
    if lo != 0 { sram_write16(byte_off, sram_read16(byte_off) | lo); }
    if hi != 0 { sram_write16(byte_off + 2, sram_read16(byte_off + 2) | hi); }
    aSave.wCurrentBitOffset += bits;
}
```

Both save and load walk identical descriptor tables in two formats: absolute-address lists of `(bit_length | flag, 24-bit RAM_address)` pairs (for global state and deployment headers) and struct-offset tables of `(struct_offset, bit_length | flag)` relative to a base pointer (for per-unit and per-item records), with `LoadAsByteFlag` (`$80`) marking 8-bit targets so loading never overwrites an adjacent byte. After packing every section, `rsSaveSaveFileBody` writes `SAVE_MAGIC_NUMBER` (`$9207`), computes the checksum, and asserts `wCurrentBitOffset < structSaveDataEntry.Checksum * 8` (trapping with `brk` on overflow).

### Pointer-free items and type-dispatched units

In RAM, each `aItemRAMData` entry holds a 16-bit pointer into `aUnitRAMArea` that becomes meaningless once unit pools are reallocated on load. Before packing, `rlFillItemsOwnerAndSlotData` temporarily encodes each owned item's owner `CharacterID` and inventory slot into the fields that get serialized; after saving (and after loading), `rlFillItemDurabilityData` restores the live item fields.

Units vary in size by type ([Chapter 1](01-a-unit-is-made-of-parts.md)). `rsSaveSpecifiedUnitsData` copies the unit into `aUnit1DataBuffer`, writes a 26-bit deployment header (`aSaveCharacterDeploymentData`: 9-bit `CharacterID`, 5-bit deployment state, 6-bit `X`, 6-bit `Y`), and dispatches by `UnitType`:

- **`UnitTypeStatic` and `UnitTypeDynamic`:** Pack compacted personal and extended personal data, the 7-bit equipped-weapon bitfield (`EquippedWeaponBitfield >> 1`), `ConstantData` (for dynamic children), and 15 × 9-bit `LoverData` entries (for female units, truncating `$FFFF` to `$01FF` on save and expanding it back on load, [Chapter 17](17-love-and-lineage.md)).
- **`UnitTypeHoly` and `UnitTypeEnemy`:** Pack only compacted personal data; their ROM templates already supply everything else.

### Rebuilding on load and the leadership star quirk

`rlLoadFromSaveSlot` resets map and unit pools (`rlClearMapRAM`, `rlInitializeUnitRAM`) and unpacks the stream in the exact order it was written. For each unit, `rlCreateUnitFromBuffers` (bank `$87`) allocates fresh blocks in `aStaticUnitRAMArea`, `aDynamicUnitRAMArea`, `aHolyAndEnemyRAMArea`, `aInventoryRAMArea`, and `aLoverRAMArea`, unpacks the buffers, and runs `rsRestore*` helpers to reconstruct fields the save omits:

- `rsRestorePersonalData` recomputes `LoveDataID` from `CharacterID`, clears Canto and temporary ring/weapon bonuses, clears `LoverGenerationID` on holy/enemy units, and restores default `ClassMoney` only when the 1-bit saved flag is `1` (preserving stolen `0` gold).
- `rsRestoreDynamicConstantData` copies the 6 unchanging ROM bytes for dynamic children from bank `$83`.
- `rsGatherUnitItems` and `rsCreateUnitInventory` scan `aItemRAMData` for items tagged with the unit's `CharacterID` and slot, rewrite their owner pointers to the newly allocated unit header, rebuild the inventory list, and reapply both the equipped weapon's stat bonus and any inventory ring bonuses (`rlAddItemStatBonusIfRingByItemRAMStructEntry`).
- `rsRestoreLeadershipStars` (`$87/F80F`) restores leadership stars from a hardcoded character check rather than SRAM: `Sigurd` and `Quan` get `2`, `Seliph` and `Altena` get `3`, `Hannibal` gets `5`, and everyone else gets `0`. Because `rsOverwriteSeliphUnitData` ([Chapter 17](17-love-and-lineage.md)) initializes Seliph with `2` stars at the start of Chapter 6, saving and reloading bumps Seliph from `2` to `3` leadership stars.

### Checksums and erasing

`rsCalculateSaveSlotChecksum` sums bytes `$0000..$07BD` of a slot with carry and adds `1`. A slot is valid in `rsFillSaveSlotDataBuffers` only when both its checksum and its magic number (`$9207`, or legacy `$1206`) match.

`rlEraseSaveSlot` does not zero SRAM. It computes the slot's real checksum, adds `1`, and writes that off-by-one value back so validation fails. If all four slots are now invalid, it clears `aSRAM.wLastUsedOptions` and `aSRAM.wRankingScore`.

## Data written as it happens

Keeping `UnitLossesCount` and `GameTimerLow`/`High` after `Checksum` allows the engine to update them in SRAM immediately without recomputing the slot checksum:

- **Unit losses (`rlRecordUnitLoss`, `$91/EB0F`):** Increments `aUnitLossesCount[index]` (0–23 for Generation 1, 24–47 for Generation 2, capped at `255`) in RAM and immediately in every SRAM slot whose `SaveData & $7F` and `CurrentChapter` match the active game. Resetting after a unit falls does not erase the loss from the Combat ranking or augury.
- **Game timer (`rlTickGameTimer`, `$91/EB76`):** Runs once a frame from the interrupt handler while `aSave.wActiveSaveData != 0`. Every `$800` frames (2,048 frames, about 34 seconds), it flushes the 32-bit timer to every SRAM slot sharing the active Save ID.
- **Completion flag and kept ranking (`rlSetSaveSlotCompletionFlag`, `rsKeepFinalRanking`):** When the game finishes, sets bit 7 (`+$80`) on `SaveData` in every matching slot and adds `$80` to each slot's checksum in place. It then stores `rlCalculateFinalRankingScore() + 1` (`1` = A .. `5` = E; [Chapter 21](21-endings-and-scores.md)) in `aSRAM.wRankingScore` (tagged `SRAM_RANKING_TAG = $F290`) unless a lower nonzero rank is already recorded.
- **Anti-tamper mark and last saved slot:** `rlSetAntiTamperMark` writes `SRAM_ANTI_TAMPER_MARK` (`$6A19`) on the first copier, bank-0, or reset-signature anti-tamper hang ([Chapter 6](06-resolving-a-battle.md), [Chapter 26](26-the-frame.md)); `rlSetLastSavedSlot` writes `SRAM_LAST_SAVED_SLOT_TAG | slot` (`$D8C0 | slot`) so the Load cursor starts on the most recent file.

## The save menu screen

One game state (`rlSaveMenuStep`, routine `$06`, dispatching through `aSaveMenuSteps`) serves the title file menu (step 0), map save (step 2), erase (step `$0B`), the Jugdral history scroll (steps `$1C`–`$21`), starting a new game (step `$22`), the chapter-to-chapter world map transition (steps `$23` and `$29`), and the chapter intro title card (steps `$24`–`$27`; [Chapter 19](19-between-chapters.md)).

When a new game starts, `rsGetNewUniqueSaveID` scans the four slots for an unused 3-bit Save ID (`1..7`) and carries forward `highest_completion_count + 1` (up to `15`) whenever any finished slot (bit 7 set) exists in SRAM—which drives the battle-scene demo unlocks ([Chapter 20](20-the-opening.md)) and the epilogue's completion counter ([Chapter 21](21-endings-and-scores.md)).

To keep row drawing fast, [engine/save/save_menu.asm](../../engine/save/save_menu.asm) pre-renders every row type's text into VRAM tiles once on screen open (`rlStartTextToTiles`), including each used slot's chapter number, turn count, and chapter title; `rsSaveMenuDrawRowTiles` then only updates tilemap entries, using a distinct palette for the designated auto-save slot. Confirming a slot sets `aSave.wMenuOperation` (`1..4`, with bit 15 set for load), and `rlHandleSaveFile` executes the actual SRAM read or write from the main loop.

An unfinished **Copy** command remains in the menu: step 9 and row type 5 exist, and `rsSaveMenuBuildCommandRows` loads `lda #$0005` when slots are occupied, but it omits the `jsr rsSaveMenuAddRow` call, and step 9's confirmation handler does nothing.

## Trade-offs and hard limits

Bitpacking fits 72 units and 144 items into under 2 KB without compression, at the cost of a two-step marshalling pass (`rlFillItemsOwnerAndSlotData` and `rlCreateUnitFromBuffers`) and brittle `rsRestore*` tables that must stay in sync with unit initialization. Placing losses and the timer past the checksum lets the engine write them live in a few cycles without risking half-written checksums on reset.

The limits:

- **4 slots × 2 KB** in 8 KB SRAM, with a **1,979-byte** bitpacked body (`$0001..$07BB`).
- **3-bit Save ID (`1..7`)** and **4-bit completion count (`0..15`)** in `SaveData`.
- **48 byte-sized loss counters**, each capped at `255`.

## Where it lives in the source

- [engine/save/save.asm](../../engine/save/save.asm): `rlSaveToSaveSlot`, `rlLoadFromSaveSlot`, `rlStartNewGameSave`, `rlEraseSaveSlot`, `rsWriteBitpackedSaveData`, `rlRecordUnitLoss`, `rlTickGameTimer`, `rsKeepFinalRanking`, and `rlCreateUnitFromBuffers` (`$87/F515`).
- [engine/save/save_menu.asm](../../engine/save/save_menu.asm): `rlSaveMenuStep`, `aSaveMenuSteps`, row builders, and input loops.
- [include/Save.h](../../include/Save.h) and [include/SRAM.h](../../include/SRAM.h): `structSaveDataEntry`, `aSRAM`, magic numbers, and SRAM tags.
- [include/Checksums.h](../../include/Checksums.h): anti-tamper mark constants.
- [docs/reference/save.md](../reference/save.md): the reference page.

---

← Previous: [Chapter 17: Love and Lineage](17-love-and-lineage.md) | [Contents](OUTLINE.md) | Next: [Chapter 19: Between Chapters](19-between-chapters.md) →
