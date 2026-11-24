# Chapter 1: A Unit Is Made of Parts

Up to 72 units share a chapter map at once, and every system above them—combat, AI, menus, and saving—asks all of them the same questions: what is a unit's strength, class, level, skill set, or inventory? Yet those 72 slots span four different tiers of mutability: playable characters with growing stats in work RAM, generation-2 children whose growths are derived from their parents at the start of the generation, hand-tuned major bosses with fixed stat sheets in ROM, and generic enemies whose stats are computed from class and level on demand.

To keep callers uniform without wasting work RAM on static enemies, the engine builds each unit from a small header of pointers, a set of *parts* owned in RAM or borrowed from ROM, and a layer of getters that hide which is which.

## Four kinds of unit

Every character in the ROM table `aCharacterData` ([data/character/CharacterData.csv](../../data/character/CharacterData.csv)) begins with a type byte that decides how the character is built ([include/Characters.h](../../include/Characters.h)):

| Type | Entries | Who | Where the stats come from |
|---|---:|---|---|
| `UnitTypeStatic` | 46 | Playable characters with a fixed ROM sheet: all of generation 1, plus generation 2's non-children (Shannan, Oifey, substitutes such as Daisy) | ROM bases copied into RAM, then grown by level-ups |
| `UnitTypeDynamic` | 17 | The children of generation 2 | Computed from both parents, then grown by level-ups |
| `UnitTypeHoly` | 53 | Hand-tuned non-player characters: rulers, major bosses, Arvis, Eldigan | A ROM stat sheet, read in place |
| `UnitTypeEnemy` | 453 | Everyone else on the other side, including ordinary bosses such as Gerrard | Computed from class and level whenever asked |

The disassembly names the third type `Holy` because most of its characters carry holy blood; what defines it is the full stat sheet in ROM. That is why some appear twice: `ArvisChPrologue` and `ArvisCh10` are separate entries, because a boss who returns stronger needs a new sheet. Nothing about a `Holy` unit's stats can change at run time.

## The header and its parts

Every unit has one 19-byte header in `aUnitRAMArea`: a type byte and six far pointers (three bytes each: offset and bank), one per part. A part the unit doesn't have is a null pointer.

```rust
struct CharacterDataRAM {                 // structCharacterDataRAM
    kind: UnitType,
    personal:  FarPtr<PersonalData>,      // PersonalData
    extended:  FarPtr<ExtendedData>,      // ExtendedPersonalData
    constant:  FarPtr<ConstantData>,      // ConstantData
    enemy_rom: FarPtr<EnemyROMEntry>,     // EnemyROMData
    inventory: FarPtr<InventoryData>,     // InventoryData
    lover:     FarPtr<LoverData>,         // LoverData
}
```

The parts group data by how often it changes:

- **Personal** (15 bytes, always in RAM): what changes during play. Current HP, status and its duration, faction slot, AI setting, deployment slot, waiting castle, ring and holy-weapon bonuses, Canto movement, lover, and a word of state flags.
- **Extended** (15 bytes): the stat sheet. Max HP, seven stats, class, level, leadership stars, gold, experience, and talk target.
- **Constant** (22 bytes): who the unit *is*. ID, name, generation ID, gender, father, eight growth rates, three skill bytes, and holy blood.
- **Enemy ROM data**: a generic enemy's 13-byte ROM entry, pointed at just past its type byte: ID, name, class, gender, level, leadership, faction member ID, equipment, and an item to drop.
- **Inventory** (13 bytes): a 4-byte list header (item count, capacity, entry size), eight one-byte item slots, and the equipped-weapon flags ([Chapter 3](OUTLINE.md)).
- **Lover** (30 bytes): fifteen words of love points, one per eligible man ([Chapter 17](OUTLINE.md)).

## Pointing into ROM

A playable character's 38-byte ROM entry (`structStaticCharacterROMEntry`) embeds, from offset `$0D`, a complete `structCharacterConstantData`: byte for byte the layout a child keeps in RAM.

```
structStaticCharacterROMEntry (bank $83)
 $00  Type
 $01  HP Str Mag Skl Spd Def Res Luk Class Level Leadership   ◀── a Holy unit's `extended` points here
 $0C  Money
 $0D  ┌ CharacterID Name GenerationID Gender Father ─┐        ◀── a Static or Holy unit's `constant` points here
      │ 8 growths  3 skill bytes  2 holy blood words │
 $22  └──────────────────────────────────────────────┘
 $23  Equipment1 Equipment2 UniqueEquipment
```

So `rsCreateStaticUnitRAMData` gives Sigurd 30 bytes of RAM for his personal and extended parts, copies his starting stats in, and points his `constant` part at offset `$0D` of his ROM entry. His growths and skills are never copied: the ROM *is* his constant data.

A child has a ROM entry too, but a 12-byte `structDynamicCharacterROMEntry` holds only the starting class and level, identity, starting equipment, and `MajorInfluence` (which parent dominates inheritance). Growths, skills, and holy blood exist nowhere until `rlFillChildsConstantData` computes them, so `rsCreateDynamicUnitRAMData` allocates all three parts in RAM. The `Dynamic` type exists to hold that computed data.

A `Holy` unit goes the other way: only its personal part is in RAM. Its `extended` pointer aims at ROM offset `$01`, where HP through leadership stars line up exactly with the first eleven fields of an extended part.

```
              Static (Sigurd)     Dynamic (Seliph)    Holy (Arvis)        Enemy (axe fighter)
personal  ──▶ RAM                 RAM                 RAM                 RAM
extended  ──▶ RAM                 RAM                 ROM entry + $01     —
constant  ──▶ ROM entry + $0D     RAM                 ROM entry + $0D     —
enemy_rom ──▶ —                   —                   —                   ROM entry + $01
inventory ──▶ RAM                 RAM                 RAM                 RAM
lover     ──▶ RAM if female       RAM if female       —                   —
```

### One load, either memory

> **Sidebar: the data bank register**
>
> Most 65816 instructions carry a 16-bit address; the top byte, the bank, comes from the *data bank* register `B`. `lda structExtendedCharacterDataRAM.Level,b,x` means "load from offset `Level` plus `X`, in whatever bank `B` names." It resembles a segment register: change `B`, and the same instruction reads work RAM in bank `$7E` or character data in ROM bank `$83`.

`rlGetSelectedUnitExtendedPersonalDataPointer` loads the unit's `extended` bank into `B` and its offset into `X`. Whatever load follows reads the extended part, wherever it lives:

```rust
fn get_selected_unit_level() -> u8 {               // rlGetSelectedUnitLevel
    let unit = selected_unit();
    if unit.kind == Enemy {
        return enemy_rom(unit).level;              // rlGetEnemyUnitLevel
    }
    let (bank, x) = unit.extended;                 // rlGetSelectedUnitExtendedPersonalDataPointer
    set_data_bank(bank);                           // $7E for Static/Dynamic, $83 for Holy
    read_u8(x + offset_of!(ExtendedData, level))   // the same instruction for RAM or ROM
}
```

The overlay holds for eleven fields, not fifteen. Gold is a word at offset `$0B` of an extended part; in a ROM entry that position holds a one-byte money value and half the character ID. So `rlGetSelectedUnitMoney` sends `Holy` and `Enemy` units to `rlGetEnemyClassMoney`, which reads the `ClassMoney` byte from the personal part, and `rlGetSelectedUnitExperience` answers only for units in the player's faction. The layout has no marker for where the overlay ends; that knowledge lives only in the getters, which is one reason the rest of the game never reads a part directly.

## Stats nobody stored

A generic enemy has no stat sheet anywhere. Its ROM entry names a class and a level, and each stat is derived from the class table whenever asked:

```rust
fn get_enemy_strength() -> u8 {                    // rlGetEnemyStrength
    let class = selected_unit_class();             // rlGetSelectedUnitClassDataPointer
    let level = enemy_rom(selected_unit()).level;
    // rsGetEnemyTotalSpecifiedStat
    class.base_strength + class.strength_growth * level / 100
}
```

DiMaggio, a level 10 Fighter, works out to strength 8 + 30 × 10 / 100 = 11 and HP 35 + 100 × 10 / 100 = 45. Gerrard, a level 20 Fighter, gets 14 and 55. A player unit's strength uses a different formula ([Chapter 2](OUTLINE.md)), but the caller can't tell: `rlGetSelectedUnitTotalStrength` checks the type and picks one.

This is the *Flyweight* pattern: a Fighter's bases and growths are stored once in the class table and shared by every Fighter, and each instance keeps only its own HP, status, position, and faction. FE4 goes one step further and derives the stats from the shared data. Each query costs a multiply and a divide, made through the helper routines `rlUnsignedMultiply16By16High` and `rlUnsignedDivide16By16`, since the CPU has no multiply instruction.

## The selected unit

None of these getters takes an argument. They all read one global, `wSelectedUnitDataRAMPointer`, the offset of a unit's header in bank `$7E`. Code points it at a unit and then asks questions:

```rust
fn check_character_waiting_in_home_castle(id: CharacterId) -> bool {   // rlCheckCharacterWaitingInHomeCastle
    let saved = wSelectedUnitDataRAMPointer;
    get_unit_ram_data_pointer_by_id(id);            // rlGetUnitRAMDataPointerByID: sets the global
    let result = !states().has(Fielded | Dead)
        && faction_slot() == FS_Player
        && home_castle() == player_castle();
    wSelectedUnitDataRAMPointer = saved;
    result
}
```

It is an implicit `self`, referenced about 760 times across the engine. It keeps calls to one instruction and leaves the CPU's three registers free. The cost is that any routine handling two units must swap the global and restore it, and forgetting to restore it is exactly the bug behind FE4's misdirected love points ([Chapter 17](OUTLINE.md)). To reach every unit, code walks `aUnitRAMPointers`, the list of all current headers.

## Pools

Each kind of part comes from its own region of work RAM:

| Pool | Holds | Slots | Bytes per slot |
|---|---|---:|---:|
| `aUnitRAMArea` | headers | 72 | 19 + 6 |
| `aStaticUnitRAMArea` | personal + extended | 24 | 30 + 6 |
| `aDynamicUnitRAMArea` | personal + extended + constant | 17 | 52 + 6 |
| `aHolyAndEnemyRAMArea` | personal | 63 | 15 + 6 |
| `aInventoryRAMArea` | inventories | 73 (declared as 72 + 1) | 13 + 6 |
| `aLoverRAMArea` | love points | 9 | 30 + 6 |

The `+ 6` is a block header. The pools are *RAM areas*, small heaps run by a general first-fit allocator in [engine/core/ram_structs.asm](../../engine/core/ram_structs.asm), the same one the map menus use for their variable-size option lists. `rlLoadUnit` allocates a header, appends it to `aUnitRAMPointers`, and calls `rlCreateUnit`, which reads the type byte from ROM and dispatches through `aUnitCreationRoutinesByType`:

```rust
fn create_holy_unit(unit: &mut CharacterDataRAM, rom: RomPtr) {   // rsCreateHolyUnitRAMData
    unit.kind      = Holy;
    unit.personal  = alloc(aHolyAndEnemyRAMArea, 15);   // rlAllocateRAMArea
    unit.extended  = rom + $01;                          // HP..Leadership, read in place
    unit.constant  = rom + $0D;                          // ID, growths, skills, blood, read in place
    unit.enemy_rom = NULL;
    unit.lover     = NULL;
    fill_personal_data(unit);                            // rsFillUnitRAMPersonalData
    fill_inventory_data(unit);                           // rsFillUnitRAMInventoryData
}
```

`rlDeleteUnit` reverses it, returning the unit's items to the item table and freeing its blocks.

## Word-wide working copies

Most of the game runs with a 16-bit accumulator, so each read of a byte field ends with `and #$00FF` to discard its neighbor. Code that works through a whole unit field by field avoids that by unpacking it into `aUnit1DataBuffer` or `aUnit2DataBuffer` (bank `$7F`), where almost every field is widened to a word (`rlSave*ToBuffer`, packed back by `rlLoad*FromBuffer`). Three systems do this: building a child, with the mother in one buffer and the father in the other ([inheritance.asm](../../engine/units/inheritance.asm)); class change, which saves stats before and after promotion to show the gains ([class_change.asm](../../engine/castle/class_change.asm)); and saving, which writes each unpacked field to SRAM a few bits at a time ([save.asm](../../engine/save/save.asm)).

## What the split buys, and what it costs

Per unit, the parts scheme saves memory. A generic enemy costs 65 bytes of RAM, counting header, personal part, inventory, and block headers. A playable man costs 80, a playable woman 116, and a generation-2 daughter 138. One record holding everything would be about 95 bytes.

Totaled over the pools, the saving disappears. The six pools reserve 6,732 bytes; seventy-two uniform 95-byte records would need 6,840. The six-byte block headers alone take over 1,500 bytes, about what the split saves.

The split does provide:

- **No copies of data that never changes.** Creating an enemy writes 15 bytes and an inventory. Boss stats, playable characters' growths and skills, and class bases stay in ROM, the single source of truth: changing a Fighter's base strength in the class table changes every Fighter.
- **A home for computed data.** Only the children, whose genes exist nowhere else, pay for a constant part in RAM.
- **Separate budgets.** Enemies draw on their own 63 slots and can never crowd out the 41 player stat sheets, though all units share the 72 headers.
- **Uniform questions.** Everything above the getters asks for "strength" or "level" without knowing the unit's type.

Its costs:

- **Every getter is a type switch**, and a generic enemy's stats cost a multiply and a divide each time.
- **The ROM overlay is an unwritten rule.** A `Holy` unit's gold must never be read through its `extended` pointer, and only the getters enforce that.
- **One selected unit.** The implicit `self` keeps calls cheap and invites the save-and-restore mistake.

## Hard limits

- **72 units at once:** the size of `aUnitRAMArea`, `aUnitRAMPointers`, and the deployment table ([Chapter 5](OUTLINE.md)). Chapters that bring in a new army often remove the old one first.
- **24 static and 17 dynamic units.** Generation 1's 24 playable characters fill the static pool exactly. In generation 2 the parents are deleted, the same 24 slots hold the non-children and substitutes, and the 17 children fill the dynamic pool.
- **63 non-player units**, shared between `Holy` and `Enemy`, and **9 love tables**, one per playable woman of the current generation.
- **A unit's type is fixed by its ROM entry.** A boss whose stats differ between appearances needs a second entry.
- **Running out is fatal.** Because every block in a pool is the same size, freed space is never stranded, so a pool that refuses an allocation is genuinely full. `rsFindFreeRAMAreaEntry` then compacts it, which frees nothing, tints the screen red, and executes `brk`, which the game has no handler for: a crash. Nothing checks earlier; the chapter data was written to fit.

## Where it lives in the source

- [include/Characters.h](../../include/Characters.h): the header, the parts, the ROM entry layouts, and the buffer structs.
- [include/WRAM.h](../../include/WRAM.h): the pools and the buffers.
- [engine/units/unit_creation.asm](../../engine/units/unit_creation.asm): `rlLoadUnit` and the four `rsCreate*UnitRAMData` routines.
- [engine/units/units.asm](../../engine/units/units.asm): `rlCreateUnit`, `rlDeleteUnit`, and the ROM character getters.
- [engine/units/unit_data.asm](../../engine/units/unit_data.asm): the part-pointer getters and the buffer routines.
- [engine/units/unit_info.asm](../../engine/units/unit_info.asm) and [stats.asm](../../engine/units/stats.asm): the type-switching getters.
- [engine/battle/battle_stats.asm](../../engine/battle/battle_stats.asm): the derived enemy stats.
- [engine/core/ram_structs.asm](../../engine/core/ram_structs.asm): the RAM area allocator.
- [docs/reference/units.md](../reference/units.md): the reference page.
