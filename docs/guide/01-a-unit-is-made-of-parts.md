# Chapter 1: A Unit Is Made of Parts

In the first chapter of the second generation, Seliph rides out of Tirnanog toward an axe fighter of the Isaach occupation. On screen the two are the same kind of thing: a sprite on a tile, a name, a class, HP, seven stats, an inventory. Underneath they have almost nothing in common.

Seliph's strength can rise at every level-up. His growth rates exist nowhere in the cartridge: the game worked them out from his parents at the start of the generation. He carries gold and gains experience. The axe fighter will never level up, never marry, and never be saved to the battery; his stats follow entirely from his class and his level. Between the two sit the bosses and rulers, such as Arvis and Danann, whose stat sheets were set by hand and never change during a chapter.

The engine has to hold up to 72 of these at once in a few kilobytes of work RAM, and every system above it (combat, AI, menus, saving) has to be able to ask any of them the same questions: what is its strength, its class, its level? This chapter covers how *Genealogy of the Holy War* lays out a unit: a small header of pointers, a set of *parts* that each kind of unit owns or borrows from ROM, and a layer of getters that hide which is which.

## Four kinds of unit

Every character in the ROM table `aCharacterData` ([data/character/CharacterData.csv](../../data/character/CharacterData.csv)) begins with a type byte, and that byte decides how the character is built for its whole life. The disassembly calls the four types `Static`, `Dynamic`, `Holy`, and `Enemy` ([include/Characters.h](../../include/Characters.h)):

| Type | Entries in ROM | Who | Where the stats come from |
|---|---:|---|---|
| `UnitTypeStatic` | 46 | Playable characters with a fixed ROM sheet: all of generation 1, and generation 2's non-children (Shannan, Oifey, the substitutes such as Daisy and Creidne) | ROM bases copied into RAM at creation, then grown by level-ups |
| `UnitTypeDynamic` | 17 | The children of generation 2 | Computed from both parents at creation, then grown by level-ups |
| `UnitTypeHoly` | 53 | Hand-tuned non-player characters: rulers, major bosses, Arvis, Eldigan | A ROM stat sheet, read in place |
| `UnitTypeEnemy` | 453 | Everyone else on the other side, including ordinary bosses such as Gerrard | Computed from class and level whenever asked |

The name *Holy* comes from the project, not the game: most of these characters carry holy blood. What actually sets them apart from `Enemy` is that each has a full stat sheet in ROM. That is also why some of them appear more than once. `ArvisChPrologue` and `ArvisCh10`, `IshtarCh08` and `IshtarCh10`, are separate characters with separate sheets: a boss who returns stronger is a new entry in the table, because nothing about a `Holy` unit's stats can change at run time.

The four types differ in three things: which data changes during play, which data exists in ROM, and which data has to be invented. Laid side by side, they explain the whole layout:

| Data | Static | Dynamic | Holy | Enemy |
|---|---|---|---|---|
| Changes every turn (HP, status, faction, position) | yes | yes | yes | yes |
| Stats that grow, gold, experience | yes | yes | no | no |
| Growths, skills, holy blood | in ROM | computed | in ROM | from class |
| Items | yes | yes | yes | yes |
| Love points | women only | women only | no | no |

## The header and its parts

Every unit, of any type, has one 19-byte header in `aUnitRAMArea`, `structCharacterDataRAM`. It is a type byte and six far pointers, one for each part a unit might have:

```rust
struct CharacterDataRAM {                 // structCharacterDataRAM, 19 bytes, in aUnitRAMArea
    kind: UnitType,                       // Static, Dynamic, Holy, or Enemy
    personal:  FarPtr<PersonalData>,      // PersonalData
    extended:  FarPtr<ExtendedData>,      // ExtendedPersonalData
    constant:  FarPtr<ConstantData>,      // ConstantData
    enemy_rom: FarPtr<EnemyROMEntry>,     // EnemyROMData
    inventory: FarPtr<InventoryData>,     // InventoryData
    lover:     FarPtr<LoverData>,         // LoverData
}
```

A far pointer is three bytes: a 16-bit offset and a bank. A part a unit doesn't have is a null pointer. Each part groups data by *how often it changes*:

- **Personal data** (`structPersonalCharacterDataRAM`, 15 bytes) is what changes during play: current HP, status and its duration, faction slot, AI setting, deployment slot, the castle the unit is waiting in, ring and holy-weapon bonuses, Canto movement left, the unit's lover, and a word of state flags. Every unit has one, and it is always in RAM.
- **Extended data** (`structExtendedCharacterDataRAM`, 15 bytes) is the stat sheet: max HP, the seven other stats, class, level, leadership stars, gold, experience, and talk target.
- **Constant data** (`structCharacterConstantData`, 22 bytes) is who the unit *is*: character ID, name, generation ID, gender, father, eight growth rates, three skill bytes, and the holy blood bitfields.
- **Enemy ROM data** points at a generic enemy's 13-byte ROM entry: ID, name, class, gender, level, leadership, and equipment.
- **Inventory data** holds eight one-byte item slots and the equipped-weapon flags ([Chapter 3](OUTLINE.md) covers what those bytes point at).
- **Lover data** is fifteen words of love points, one per eligible man ([Chapter 17](OUTLINE.md)).

What makes the scheme work is that a pointer can aim at RAM *or* ROM, and the two have been laid out to match.

## Pointing into ROM

A playable character's ROM entry (`structStaticCharacterROMEntry`, 38 bytes) is not a flat list of fields. In the middle of it, from offset `$0D`, sits a complete `structCharacterConstantData`, byte for byte the same layout as the constant part a child keeps in RAM:

```
structStaticCharacterROMEntry (bank $83)
 $00  Type
 $01  HP Str Mag Skl Spd Def Res Luk Class Level Leadership   ◀── a Holy unit's `extended` points here
 $0C  Money
 $0D  ┌ CharacterID Name GenerationID Gender Father ─┐        ◀── a Static or Holy unit's `constant` points here
      │ 8 growths  3 skill bytes  2 holy blood words │            (same layout as a child's ConstantData in RAM)
 $22  └──────────────────────────────────────────────┘
 $23  Equipment1 Equipment2 UniqueEquipment
```

So when `rsCreateStaticUnitRAMData` builds Sigurd, it allocates 30 bytes of RAM for his personal and extended parts, copies his starting stats into the extended part, and then points his `constant` part straight at offset `$0D` of his ROM entry. His growths and skills are never copied: the ROM *is* his constant data. A child's growths, by contrast, exist nowhere until `rlFillChildsConstantData` computes them, so `rsCreateDynamicUnitRAMData` allocates 52 bytes and fills in all three parts. That difference is the entire reason the `Dynamic` type exists.

A `Holy` unit goes one step further. `rsCreateHolyUnitRAMData` allocates only the 15-byte personal part, and points *both* `constant` and `extended` into ROM. The `extended` pointer aims at offset `$01`, where the ROM's HP through leadership stars line up exactly with the first eleven fields of an extended part in RAM.

```
              Static (Sigurd)     Dynamic (Seliph)    Holy (Arvis)        Enemy (axe fighter)
personal  ──▶ RAM                 RAM                 RAM                 RAM
extended  ──▶ RAM                 RAM                 ROM entry + $01     —
constant  ──▶ ROM entry + $0D     RAM                 ROM entry + $0D     —
enemy_rom ──▶ —                   —                   —                   ROM entry + $01
inventory ──▶ RAM                 RAM                 RAM                 RAM
lover     ──▶ RAM if female       RAM if female       —                   —
```

### How one load instruction reads either

The pointer trick only pays off if the code that reads a part doesn't care where the part is. Here the 65816 helps, through its **data bank register**.

> **Sidebar: the data bank register**
>
> A 65816 address is 24 bits, but most instructions carry only a 16-bit address. The missing top byte, the bank, comes from a register: the *data bank*, `B`. An instruction such as `lda structExtendedCharacterDataRAM.Level,b,x` means "load from offset `Level` plus `X`, in whatever bank `B` currently names." It resembles a segment register on the old x86, or a base pointer that every load implicitly adds. Change `B`, and the same instruction reads a different 64 KB of the address space: work RAM in bank `$7E`, or character data in ROM bank `$83`.

`rlGetSelectedUnitExtendedPersonalDataPointer` takes the unit's three-byte `extended` pointer, puts its bank into `B` and its offset into `X`, and returns. Whatever load follows reads the extended part, wherever it lives. Here is `rlGetSelectedUnitLevel`, translated:

```rust
fn get_selected_unit_level() -> u8 {               // rlGetSelectedUnitLevel
    let unit = selected_unit();
    if unit.kind == Enemy {
        return enemy_rom(unit).level;              // rlGetEnemyUnitLevel
    }
    let (bank, x) = unit.extended;                 // rlGetSelectedUnitExtendedPersonalDataPointer
    set_data_bank(bank);                           // $7E for Static/Dynamic, $83 for Holy
    read_u8(x + offset_of!(ExtendedData, level))   // one instruction, RAM or ROM
}
```

Three of the four types take the same path. Only the generic enemy, which has no extended part at all, needs its own branch.

### Where the overlay stops

The ROM and RAM layouts agree for eleven fields, not fifteen. In RAM, gold is a word at offset `$0B` of the extended part. In a ROM entry, that same position holds a one-byte money value followed by the low byte of the character ID, and experience would land on the high byte of the ID. Reading a `Holy` unit's gold through its `extended` pointer would return nonsense.

The getters know where the overlay ends. `rlGetSelectedUnitMoney` sends every `Holy` and `Enemy` unit to `rlGetEnemyClassMoney`, which reads the `ClassMoney` byte from the personal part instead. `rlGetSelectedUnitExperience` returns experience only for units in the player's faction. Nothing in the data marks these boundaries. They live in the getters, which is one reason the rest of the game never reads a part directly.

## Stats nobody stored

A generic enemy has no stat sheet in RAM or in ROM. Its 13-byte ROM entry names a class and a level, and every stat is worked out from the class table each time some code asks for it:

```rust
fn get_enemy_strength() -> u8 {                    // rlGetEnemyStrength
    let class = selected_unit_class();             // rlGetSelectedUnitClassDataPointer
    let level = enemy_rom(selected_unit()).level;
    // rsGetEnemyTotalSpecifiedStat
    class.base_strength + class.strength_growth * level / 100
}
```

DiMaggio, a level 10 Fighter, works out to strength 8 + 30 × 10 / 100 = 11 and HP 35 + 100 × 10 / 100 = 45. Gerrard, the same class at level 20, gets 14 and 55. Every Fighter at a given level is identical, which is exactly how the game's armies look on the map. A player unit's strength comes from a different formula (class base plus personal stat, capped at 30, plus weapon and ring bonuses), but the caller can't tell: `rlGetSelectedUnitTotalStrength` checks the type and picks the formula. [Chapter 2](OUTLINE.md) takes these formulas apart.

This is the *Flyweight* pattern in its plainest form: the intrinsic data (a Fighter's bases and growths) is stored once in the class table and shared by every Fighter on the map; each instance keeps only its extrinsic data (current HP, position, faction, status) in its 15-byte personal part. FE4's variant goes further than the textbook one, because the shared data doesn't just stand in for copies; it is used to *derive* the stats on demand. The price is a multiply and a divide on every stat query, on a CPU that has no multiply instruction. The battle code asks for these numbers constantly.

## The selected unit

None of the getters above take an argument. They all read one global, `wSelectedUnitDataRAMPointer`: the 16-bit offset of a unit's header in bank `$7E`. Calling code points it at a unit, then asks questions:

```rust
fn check_character_waiting_in_home_castle(id: CharacterId) -> bool {   // rlCheckCharacterWaitingInHomeCastle
    let saved = wSelectedUnitDataRAMPointer;
    get_unit_ram_data_pointer_by_id(id);            // rlGetUnitRAMDataPointerByID: sets the global
    let result = !states().has(Fielded | Dead)      // rlGetSelectedUnitStates
        && faction_slot() == FS_PLAYER              // rlGetSelectedUnitFactionSlot
        && home_castle() == player_castle();        // rlGetSelectedUnitHomeCastle
    wSelectedUnitDataRAMPointer = saved;
    result
}
```

It works like an implicit `self`. The engine refers to the global about 760 times, which keeps each call to a single instruction and leaves the CPU's three registers free for the work itself. The convention has a cost, and the game pays it. Any routine that handles two units must swap the global back and forth, and one that forgets leaves later code asking questions of the wrong unit. That is exactly the bug behind FE4's misdirected love points: `rsAddAdjacentLovePoints` points the global at a neighbor to check its gender and, when the neighbor is a woman, branches out without pointing it back ([Chapter 17](OUTLINE.md)).

To reach all the units rather than one, code walks `aUnitRAMPointers`, a list of the header offsets of every unit that currently exists. `rlGetUnitRAMDataPointerByID`, for example, walks it comparing character IDs.

## Pools

Each kind of part is allocated from its own fixed region of work RAM:

| Pool | Holds | Slots | Bytes per slot |
|---|---|---:|---:|
| `aUnitRAMArea` | headers | 72 | 19 + 6 |
| `aStaticUnitRAMArea` | personal + extended | 24 | 30 + 6 |
| `aDynamicUnitRAMArea` | personal + extended + constant | 17 | 52 + 6 |
| `aHolyAndEnemyRAMArea` | personal | 63 | 15 + 6 |
| `aInventoryRAMArea` | inventories | 73 | 13 + 6 |
| `aLoverRAMArea` | love points | 9 | 30 + 6 |

The `+ 6` is bookkeeping. The pools are not plain arrays but *RAM areas*, small heaps managed by a general allocator in [engine/core/ram_structs.asm](../../engine/core/ram_structs.asm). Each block carries a six-byte header with its size and flags. `rlAllocateRAMArea` finds the first free block large enough and carves the request from it, and freeing a block merges it with free neighbors. The same allocator serves the map menus' option lists, where block sizes really do vary.

Creating a unit touches several pools. `rlLoadUnit` allocates a header, appends it to `aUnitRAMPointers`, and calls `rlCreateUnit`, which reads the type byte from the character's ROM entry and dispatches through a table of four routines, `aUnitCreationRoutinesByType`. The `Holy` one is short enough to show whole:

```rust
fn create_holy_unit(unit: &mut CharacterDataRAM, rom: RomPtr) {   // rsCreateHolyUnitRAMData
    unit.kind      = Holy;
    unit.personal  = alloc(aHolyAndEnemyRAMArea, 15);
    unit.extended  = rom + 0x01;           // HP..Leadership, read in place
    unit.constant  = rom + 0x0D;           // ID, growths, skills, blood, read in place
    unit.enemy_rom = NULL;
    unit.lover     = NULL;
    fill_personal_data(unit);              // rsFillUnitRAMPersonalData
    fill_inventory_data(unit);             // rsFillUnitRAMInventoryData: allocates the inventory
}
```

`rlDeleteUnit` reverses it: it removes the unit from `aUnitRAMPointers`, takes it off the map, returns the items it owned to the item table, and frees each of its blocks.

## Word-wide working copies

The parts are packed into bytes to save space. Most of the game's code, though, runs with a 16-bit accumulator, and reading a byte in 16-bit mode drags in the next byte too, so nearly every getter ends with `and #$00FF` to throw it away. For code that works on a whole unit at once, field by field, that tax adds up.

Two staging areas avoid it: `aUnit1DataBuffer` and `aUnit2DataBuffer`, in bank `$7F`. Each holds an unpacked, word-wide copy of a unit: personal fields, extended fields, the constant data, the inventory, and the love points, every field widened to 16 bits. `rlSavePersonalCharacterDataToBuffer` and its siblings unpack a unit into one; `rlLoad*FromBuffer` routines pack it back. Three systems use them:

- **Building a child** puts the mother in buffer 1 and the father in buffer 2, then computes the child's growths, stats, and blood from the two side by side ([engine/units/inheritance.asm](../../engine/units/inheritance.asm)).
- **Class change** saves a unit's stats before and after promotion to show the gains ([engine/castle/class_change.asm](../../engine/castle/class_change.asm)).
- **Saving** unpacks each unit and writes its fields to SRAM a few bits at a time ([engine/save/save.asm](../../engine/save/save.asm)).

The buffers are an interchange format: one uniform shape that any unit can be converted into, so code that needs every field doesn't have to care about types, pools, or which parts live in ROM.

## What the split buys, and what it costs

It is tempting to read the parts scheme as a memory optimization, and per unit it is one. A generic enemy costs 65 bytes of RAM counting its header, personal part, inventory, and block headers. A playable man costs 80, a playable woman 116 with her love points, and a generation-2 daughter 138. A single record holding everything would be about 95 bytes for every unit.

Totaled over the pools, the picture changes. The six pools reserve 6,732 bytes. Seventy-two uniform 95-byte records would need 6,840, almost exactly the same. The allocator's six-byte block headers alone account for over 1,500 bytes, about what the split saves. Whatever the developers bought with this design, it wasn't a smaller budget.

What they did buy:

- **No copies of data that never changes.** Creating an enemy writes 15 bytes and an inventory. A boss's stats, every playable character's growths and skills, and every Fighter's bases stay in ROM, which remains the single source of truth: changing a Fighter's base strength in the class table changes every Fighter in the game.
- **A home for computed data.** A child's genes have to live somewhere, and only the `Dynamic` type pays for that space.
- **Separate budgets.** Non-player units draw on their own 63 slots, so enemy reinforcements can never use up the space set aside for the 41 player stat sheets. (All units still share the 72 headers.)
- **Uniform questions.** Everything above the getters asks for "strength" or "level" without knowing the unit's type.

What it costs:

- **Every getter is a type switch.** Most of [engine/units/stats.asm](../../engine/units/stats.asm) and [unit_info.asm](../../engine/units/unit_info.asm) is the same question asked four ways, and a generic enemy's stats cost a multiply and a divide each time.
- **The ROM overlay is a convention.** Nothing in the data says that a `Holy` unit's gold must not be read through its `extended` pointer; the getters simply know.
- **One selected unit.** The implicit `self` keeps calls cheap and invites exactly the save-and-restore mistake behind the love point bug.

## Hard limits

- **72 units at once.** That is the size of `aUnitRAMArea`, of `aUnitRAMPointers`, and of the deployment table ([Chapter 5](OUTLINE.md)). Chapters that bring in a new army often remove the old one through events first.
- **24 static and 17 dynamic units.** Generation 1's 24 playable characters fill the static pool exactly. In generation 2 the parents are deleted, and the same 24 slots hold the non-children and substitutes while the 17 children take the dynamic pool.
- **63 non-player units**, shared between `Holy` and `Enemy`.
- **9 love tables**, one per playable woman of the current generation.
- **A unit's type is fixed by its ROM entry.** A boss whose stats must differ between appearances needs a second character entry.
- **Running out is fatal.** Every block in a pool is the same size, so any freed block fits the next unit. If a pool is truly full, `rsFindFreeRAMAreaEntry` compacts it, which can't create space when there are no gaps, then tints the screen red and executes `brk`, an instruction the game has no handler for. In practice that is a crash. Nothing earlier checks: the chapter data was written to fit.

## Where it lives in the source

- [include/Characters.h](../../include/Characters.h): the header, the parts, the ROM entry layouts, and the word-wide buffer structs.
- [include/WRAM.h](../../include/WRAM.h): the pools (`aUnitRAMArea` through `aLoverRAMArea`) and the buffers (`aUnit1DataBuffer`, `aUnit2DataBuffer`).
- [engine/units/unit_creation.asm](../../engine/units/unit_creation.asm): `rlLoadUnit` and the four `rsCreate*UnitRAMData` routines.
- [engine/units/units.asm](../../engine/units/units.asm): `rlCreateUnit`, `rlDeleteUnit`, and the ROM character getters.
- [engine/units/unit_data.asm](../../engine/units/unit_data.asm): the part-pointer getters and the buffer routines.
- [engine/units/unit_info.asm](../../engine/units/unit_info.asm) and [stats.asm](../../engine/units/stats.asm): the type-switching getters.
- [engine/battle/battle_stats.asm](../../engine/battle/battle_stats.asm): `rlGetEnemyStrength` and the other derived enemy stats.
- [engine/core/ram_structs.asm](../../engine/core/ram_structs.asm): the RAM area allocator.
- [docs/reference/units.md](../reference/units.md): the reference page for all of the above.
