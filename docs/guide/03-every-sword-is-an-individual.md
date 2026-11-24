# Chapter 3: Every Sword Is an Individual

A Silver Sword that has felled fifty enemies starts landing critical hits, and grows more likely to with every kill after that. When its uses run out it becomes a Broken Sword, and repairing it at a castle brings back the same sword, kills and all. When its owner's child inherits it a generation later, the count comes too. Sell it, and it waits in that castle's pawn shop for someone else to buy.

Most games in the series store an inventory slot as an item type and a number of uses. That is enough to fight with, but a slot like that has no identity: two Silver Swords are interchangeable, and nothing can remember what one of them has done. *Genealogy of the Holy War* needs swords that can be told apart. This chapter covers how it gives every item an identity: one global table of item records, inventories that hold handles into it, and a state field that decides where each record is.

## One table for every item

Every item the player can own is a six-byte record in `aItemRAMData` ([include/Items.h](../../include/Items.h)), a table of up to 256 entries in work RAM:

```rust
struct ItemRAMEntry {            // structItemRAMEntry, 6 bytes
    item_id: ItemId,             // which kind: Silver Sword, Tyrfing, Speed Ring...
    durability: u8,              // uses left; $FF never breaks
    state: ItemState,            // Inventory, Supply, Shop, Pawnbroker, Unobtained
    owner: u16,                  // a unit's header, or a castle, depending on state
    kill_count: u8,              // enemies defeated with it, up to 100
}
```

Everything that never changes (might, weight, hit rate, range, price, rank) stays in the 138-entry ROM table `aItemData`, reached through `item_id`. The record holds only what makes this sword *this* sword.

A player unit's inventory doesn't hold items. It holds eight one-byte *player item indices*, 1-based positions in `aItemRAMData`, which the source names `PI_SilverSword1`, `PI_Tyrfing`, and so on. To learn anything about the item in slot 3, the code reads the index, finds the record, and follows its `item_id` into ROM:

```
inventory slot 3 ──▶ PI_Tyrfing (39) ──▶ aItemRAMData[39] ──▶ item_id ──▶ aItemData[Tyrfing]
                                          durability 50          might 30, weight 7,
                                          state Inventory        rank ★, ...
                                          owner Sigurd
                                          kills 12
```

This is an object table with indices as handles, the same idea a modern engine uses when it hands out entity IDs instead of pointers. A one-byte handle is a third the size of a pointer, and the record can be found from anywhere without knowing where the unit that holds it lives.

Non-player units don't take part. The inventories of `Holy` and `Enemy` units ([Chapter 1](01-a-unit-is-made-of-parts.md)) hold raw ROM item IDs, and `rlGetItemROMDataByInventorySlot` checks the unit type and skips the table for them. An enemy's Steel Axe, or Arvis's Valflame, has no record and no history.

## A closed world

On a new game, `rlInitiateItemRAMData` clears the table and fills it from [data/item/PlayerItemTable.csv](../../data/item/PlayerItemTable.csv): 140 records, every one in the state `ItemStateUnobtained`. After that, nothing adds a record. Every item the player will ever own already exists, waiting.

Each way of getting an item hands over one of those records:

- **Starting equipment.** A playable character's ROM entry lists player item indices, not item types: Sigurd starts with `PI_SteelSword1` and `PI_IronLance1`.
- **Gifts and villages.** Event scripts give a specific record: `GIVE_UNIT_PID_EQUIP Sigurd, PI_Tyrfing`.
- **Shops.** A castle's shop list names records too. When the castle's location is set up (`rlInitLocation`), each listed record still unobtained moves to `ItemStateShop`, owned by that castle. Buying one (`rlBuyItemForSelectedUnit`) changes its state and owner; nothing is created.
- **Enemy drops.** An enemy that carries a prize names it in its `Drops` field as a player item index, and `rlCheckForValidUniqueItemOrDrops` treats the record as held only while it is still unobtained or already that unit's.

A closed world has a few consequences. The table can never fill, because only 140 of its 256 slots are ever used. Two Silver Swords are always two distinct records with two names in the source. And a save file never has to say *which* item a record is: loading rebuilds all 140 records from the table and then restores each one's durability, state, owner, and kills (`rsLoadItemRAMData`). An item costs 25 bits of battery-backed RAM instead of 48.

## ItemState: one array, many places

The `state` field says where a record is, and the `owner` field says whose it is:

| State | Value | Owner | Where the item is |
|---|---:|---|---|
| `ItemStateInventory` | 1 | a unit | in that unit's hands |
| `ItemStateSupply` | 2 | a unit | in that unit's castle storage |
| `ItemStateShop` | 4 | a castle | on sale in that castle's shop |
| `ItemStatePawnbroker` | 5 | a castle | sold there, for anyone to buy back |
| `ItemStateUnobtained` | 7 | none | not yet in the game |

Values 3 and 6 are never used. Only one of these places has a list of its own, the unit's eight-slot inventory, which keeps the order the player sees. Every other place is a *query*. The supply screen, a shop's stock, and the pawn shop are built by walking the table and keeping the records with the right state and owner:

```rust
fn pawn_shop_stock(castle: CastleId) -> Vec<PlayerItemIndex> {
    (1..=item_count())                                   // rlGetItemRAMDataCount
        .filter(|&i| {
            let item = &aItemRAMData[i];                 // rlGetItemRAMStructEntryByPlayerItemIndex
            item.state == Pawnbroker && item.owner == castle
        })
        .collect()
}
```

Moving an item between places is a two-field write. Sending a sword to storage (`rlSendInventorySlotItemToSupply`) sets its state to `Supply` and removes it from the inventory list. Selling it (`rlSellInventorySlotItem`, then `rlMoveItemToSecondhandStock`) sets its state to `Pawnbroker` with the castle as owner, which is why a sold weapon shows up for sale at the castle where it was sold, still carrying its kills.

The cost is a scan of 140 records each time one of those lists opens, which is cheap next to drawing the screen. The gain is that an item can never be in two places at once, because its place is one field.

## Breaking, repairing, and remembering

A weapon's durability counts down with each use (`rlReduceItemCurrentDurability`). At zero the record isn't removed, and its `item_id` doesn't change. Instead, the two routines that every lookup passes through, `rlGetEffectiveItemIDByItemRAMStructEntry` and `rlGetEffectiveItemROMPointerByItemRAMStructEntry`, check the durability first:

```rust
fn effective_item_id(record: &ItemRAMEntry) -> ItemId {   // rlGetEffectiveItemIDByItemRAMStructEntry
    if record.durability == 0 {
        broken_weapon_id(record.item_id)                   // rsGetBrokenWeaponID
    } else {
        record.item_id
    }
}
```

`rsGetBrokenWeaponID` looks up the weapon's type and rank in [data/item/BrokenWeaponData.csv](../../data/item/BrokenWeaponData.csv): a broken B-rank lance is a Broken Lance B, and a broken holy weapon of any kind is its type's broken holy version. The table is indexed by rank plus one, which turns the holy rank `$FF` into column 0 without a special case. Broken physical weapons (and the broken holy staff) have 0 might, 30 hit, and 30 weight; broken tomes have zeroes across the board, and ordinary broken staves 80 hit. The unit can still carry one, but not fight well with it.

Repair (`rlRepairSelectedUnitItem`) writes the maximum durability back, and the effective ID is the original weapon again. Because the record was never replaced, its kill count was never lost.

Kills are counted on the record by `rlAddWinToSelectedUnitAndWeapon` and capped at 100. At 50, `rlGetItemRAMKillCountAndCritAbility` reports that the weapon lets its wielder land critical hits, and the battle code turns the surplus into crit rate:

```rust
fn battle_crit() -> u8 {                              // rlGetSelectedUnitBattleCrit
    // Holy and Enemy units have no item records, so they skip the kill check.
    let kills = if unit.is_player() { weapon_record().kill_count } else { 0 };   // rlGetItemRAMKillCountAndCritAbility
    if kills >= 50 {
        return total_skill() + (kills - 50);          // a veteran weapon: +1 per kill past 50
    }
    if has_skill(CRITICAL) || weapon.skills.contains(CRITICAL) {
        return total_skill();
    }
    0                                                 // no way to crit
}
```

A sword at 100 kills adds 50 to its wielder's crit rate, on top of making crits possible for a unit with no Critical skill.

## Prices from the record

Because each record knows its own wear, prices come from the record rather than the item type ([engine/items/items.asm](../../engine/items/items.asm)):

- **Sell price** (`rlGetItemSellPrice`): half the ROM cost, scaled by uses left: `cost / 2 × durability / max_durability`.
- **Buy price** (`rlGetItemBuyPrice`): the full cost for an unused or unbreakable item, twice the sell price for a used one, and a flat 1,000 gold for a broken one, so a broken holy weapon in a pawn shop is a bargain.
- **Repair cost** (`rlGetItemRepairCost`): the cost of the missing uses, `cost × (max − current) / max`.

The Bargain skill halves the buy and repair prices; the shop code applies it, not the price routines.

## Inventories and inheritance

The per-unit list, `structInventoryDataRAM`, holds the eight indices, a small list header with the item count, and an *equipped-weapon* byte with one bit per slot. The player's menus allow seven items. The eighth slot exists so that a gift or a purchase can always succeed: when a unit reaches eight items, `rlGiveItemToUnitCheckEncumbered` flags it, and the next thing the player sees is the screen that makes them give one up.

Inheritance ([Chapter 17](OUTLINE.md)) is where the handles pay off most. When a child joins in generation 2, `rlInheritInventoryToChild` moves records from the parent to the child: the owner field changes and the indices move into the child's list. The swords are the same records, with the same kills and the same wear. When a parent is deleted at the generation change, anything left in their hands or storage is reverted to unobtained with full durability (`rlRevertItemAcquirement`), and shop and pawn shop stock go back too.

Tyrfing shows the whole cycle. Sigurd receives the record `PI_Tyrfing` from Byron in Chapter 5. When Sigurd is deleted at the generation change, the record reverts to unobtained. In Chapter 10, an event gives the same record to Seliph: same index, same entry, and, since reverting resets durability but not kills, the same kill count.

## Trade-offs and hard limits

The table design trades a little indirection for identity. Every item query costs an extra lookup: slot to index, index to record, record to ROM. In return an item has a history, can be in exactly one place, and can be passed between units or across generations without copying anything.

The limits:

- **140 player items, fixed at build time.** The table has room for 256, but nothing creates a record after a new game. A new item for the player needs a new row in `PlayerItemTable`, and every shop, gift, and drop names its records by index.
- **8 slots, 7 kept.** The eighth slot only holds a new arrival until the player gives an item up.
- **100 kills.** Critical hits start at 50, with +1 crit per kill past it. The count takes seven bits in the save file.
- **Durability up to 63 in the save file.** It is stored in six bits; an unbreakable `$FF` is saved as 63 and restored as `$FF` on load (`rlFillItemDurabilityData`).
- **Non-player items are anonymous.** Only an enemy's single `Drops` record can pass to the player.

## Where it lives in the source

- [include/Items.h](../../include/Items.h): the record, the ROM item structs, and the `ItemState` values.
- [engine/items/items.asm](../../engine/items/items.asm): table setup, the effective-ID routines, durability, kills, and prices.
- [engine/items/inventory.asm](../../engine/items/inventory.asm): per-unit inventories, giving and removing items, and equipping.
- [engine/units/unit_state.asm](../../engine/units/unit_state.asm): buying, selling, repairing, and sending to the supply.
- [engine/map/locations.asm](../../engine/map/locations.asm) and [engine/castle/](../../engine/castle/): shop stock and the pawn shop.
- [engine/save/save.asm](../../engine/save/save.asm): the 25-bit item record in the save file.
- [data/item/](../../data/item/): `ItemData.csv`, `PlayerItemTable.csv`, and the broken weapon tables.
- [docs/reference/items.md](../reference/items.md): the reference page.
