  ; Struct arrays (engine/core/lib/ram_structs.asm): this header, then MaxStructCount
  ; entries of StructSize bytes, numbered from 1. An entry of 1-3 bytes is passed in
  ; lStructPointer1 itself; a larger one through lStructPointer1 as a pointer, and
  ; one more entry's room after the last is kept as scratch for moves.
  structRAMStructHeader .struct
    CurrentStructCount  .byte ? ; $00
    MaxStructCount      .byte ? ; $01
    StructSize          .byte ? ; $02
    Flags               .byte ? ; $03 ; bits 0-1: 0 for sizes 0-1, 1 for 2, 2 for 3, 3 for 4 and up; $80: adding and removing do nothing (rlBuildRAMStructHeader never sets it)
  .endstruct

  ; RAM areas (engine/core/lib/ram_areas.asm): this header, then entries, each a
  ; structRAMAreaEntryHeader followed by its data, up to AreaEnd.
  ; Flags: $80 built without handles (rlBuildRAMAreaHeaderAndGuidingEntry with
  ; wStructIndex not 0), $40 compacted, $20 an entry was allocated, $10 one was freed.
  structRAMAreaHeader .struct
    Flags           .byte ? ; $00
    AreaEnd         .word ? ; $01 ; the address after the area
    AreaSize        .word ? ; $03 ; the size after this header
    HandlesPerBlock .byte ? ; $05 ; handles in each handle block (wRAMAreaHandlesPerBlock, 16); 0 without handles
    HandleBlock     .word ? ; $06 ; the first handle block (rsFindOrAllocateRAMAreaHandle reads it here)
  .endstruct

  ; Flags: $80 free, $40 allocated in place (rlAllocateRAMArea), 0 allocated
  ; through a handle and movable by rlCompactRAMArea. BaseTable is the area for an
  ; entry allocated in place, the handle for a movable one.
  structRAMAreaEntryHeader .struct
    Flags     .byte ? ; $00
    Size      .word ? ; $01 ; the entry's size, this header included
    BaseTable .long ? ; $03
  .endstruct
