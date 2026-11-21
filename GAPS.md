# ROM bytes not built from source

Made by `tools/gaps.py`; do not edit. Every run of bytes the build still copies from
`fe4.sfc`, with the evidence of what it is. Classes, strongest evidence first:
`code` (a call or jump in the source targets it), `table` (built code reads it at its
first byte), `inside` (built code points into it, not at its start), `log` (read in
`fe4.cdl` only), `none` (no evidence). Addresses are given where the game reads them:
upper halves in banks `$80`-`$BF`, lower halves in `$C0`-`$FF`.

1,141,727 bytes in 885 runs: 255 runs of padding (35,944 bytes) and 630 pieces (1,105,783 bytes).

| Class | Pieces | Bytes | Read in the log |
|---|---|---|---|
| `code` | 0 | 0 | 0 |
| `table` | 136 | 615,799 | 201,114 |
| `inside` | 40 | 53,425 | 9,256 |
| `log` | 116 | 370,152 | 184,942 |
| `none` | 338 | 66,407 | 0 |

## `code` (0)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|

## `table` (136)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|
| $80/B6AD-$80/B6B5 | 9 | 5 (+0-+8) | `rsUnknown80B641` / `rsUnknown80B6B6` | **at start** halves `engine/arena/arena.asm:309`: `long pointer in lMapMenuTilemapRAMEntryPointer`; **at start** halves `engine/arena/arena.asm:530`: `long pointer in lMapMenuTilemapRAMEntryPointer`; **at start** halves `engine/arena/arena.asm:639`: `long pointer in lMapMenuTilemapRAMEntryPointer`; **at start** halves `engine/arena/arena.asm:646`: `long pointer in lMapMenuTilemapRAMEntryPointer`; and 20 more |
| $80/C3DD-$80/C3E5 | 9 | 5 (+0-+8) | `rsUnknown80C39A` / `rsUnitWindowOpen` | **at start** halves `engine/menus/unit_window.asm:1028`: `long pointer in lMapMenuTilemapRAMEntryPointer` |
| $80/C6CD-$80/C6D7 | 11 | 11 (+0-+A) | `rsUnitWindowSetHDMA` / `rlUnitWindowBG3VOFSHDMAInit` | **at start** halves `engine/menus/unit_window.asm:399`: `long pointer in lR44` |
| $80/D046-$80/D088 | 67 | 11 (+38-+42) | `rsItemWindowDrawHeader` / `rlMapMenuWindowCOLDATAHDMAInit` | +38 halves `engine/menus/item_window.asm:252`: `long pointer in lR44`; **at start** halves `engine/menus/item_window.asm:284`: `long pointer in lR18`; +1E halves `engine/menus/item_window.asm:290`: `long pointer in lR18`; +38 halves `engine/menus/skill_window.asm:245`: `long pointer in lR44` |
| $80/D1AE-$80/D2C5 | 280 | 20 (+0-+E7) | `rlItemWindowGetItemData` / `rsSkillWindowOpen` | **at start** named `include/Undisassembled.h:23`: `aUnknown80D1AE, read by rlItemWindowGetItemData` |
| $80/D662-$80/D817 | 438 | 438 (+0-+1B5) | `rsSkillWindowDrawSkillList` / `rsSkillWindowGetUnits` | **at start** halves `engine/menus/skill_window.asm:334`: `long pointer in lR18`; +18 halves `engine/menus/skill_window.asm:340`: `long pointer in lR18`; +30 halves `engine/menus/skill_window.asm:346`: `long pointer in lR18`; +48 halves `engine/menus/skill_window.asm:352`: `long pointer in lR18`; and 14 more |
| $80/D8E8-$80/D90B | 36 | 15 (+0-+1A) | `rsSkillWindowGetSkillHolders` / `aDataWindowMenuTilemapEntry` | +9 halves `engine/menus/skill_window.asm:328`: `long pointer in lMapMenuTilemapRAMEntryPointer`; **at start** halves `engine/menus/skill_window.asm:442`: `long pointer in lMapMenuTilemapRAMEntryPointer`; **at start** halves `engine/menus/skill_window.asm:1017`: `long pointer in lMapMenuTilemapRAMEntryPointer`; +12 halves `engine/menus/skill_window.asm:1059`: `long pointer in lMapMenuTilemapRAMEntryPointer` |
| $80/E586-$80/E597 | 18 | 10 (+0-+11) | `rsUnknown80E54D` / `rsUnknown80E598` | **at start** halves `engine/unsorted/bank80.asm:7277`: `long pointer in lMapMenuTilemapRAMEntryPointer`; +9 halves `engine/unsorted/bank89.asm:8012`: `long pointer in lMapMenuTilemapRAMEntryPointer`; **at start** halves `engine/unsorted/bank89.asm:8086`: `long pointer in lMapMenuTilemapRAMEntryPointer` |
| $80/E84E-$80/E8EF | 162 | 142 (+0-+8D) | `rsUnknown80E746` / `rsUnknown80E8F0` | **at start** halves `engine/unsorted/bank80.asm:7309`: `long pointer in lR18`; +10 halves `engine/unsorted/bank80.asm:7315`: `long pointer in lR18`; +22 halves `engine/unsorted/bank80.asm:7321`: `long pointer in lR18`; +36 halves `engine/unsorted/bank80.asm:7327`: `long pointer in lR18`; and 5 more |
| $80/E96E-$80/E978 | 11 | 11 (+0-+A) | `rsUnknown80E951` / `rlUnknown80E979` | **at start** halves `engine/unsorted/bank80.asm:7453`: `long pointer in lR44` |
| $80/EA80-$80/EE36 | 951 | 183 (+0-+B6) | `aUnknown80E9F3` / `rlUnknown80EE37` | **at start** named `include/Undisassembled.h:31`: `aUnknown80EA80, read by rlUnknown80E9B2` |
| $80/F36C-$80/F376 | 11 | 11 (+0-+A) | `rsUnknown80F340` / `rlUnknown80F377` | **at start** halves `engine/unsorted/bank80.asm:8293`: `long pointer in lR44` |
| $81/B42D-$81/B43E | 18 | 16 (+0-+11) | `rlUnknown81B3A6` / `rlUnknown81B43F` | **at start** halves `engine/unsorted/bank81.asm:2071`: `long pointer in lMapMenuTilemapRAMEntryPointer`; +9 halves `engine/unsorted/bank81.asm:2088`: `long pointer in lMapMenuTilemapRAMEntryPointer` |
| $81/B522-$81/B529 | 8 | 8 (+0-+7) | `rlUnknown81B503` / `rlUnknown81B52A` | **at start** halves `engine/events/event_scripts.asm:4786`: `long pointer in lR44` |
| $85/8647-$85/864A | 4 | 4 (+0-+3) | `rsUnknown85860E` / `rlUnknown85864B` | **at start** halves `engine/unsorted/bank85.asm:526`: `long pointer in lR18`; **at start** halves `engine/unsorted/bank85.asm:537`: `long pointer in lR18` |
| $85/89DE-$85/89E6 | 9 | 9 (+0-+8) | `rsUnknown8589C5` / `rsUnknown8589E7` | **at start** halves `engine/unsorted/bank85.asm:1298`: `long pointer in lR18` |
| $85/8A1B-$85/8A6E | 84 | 84 (+0-+53) | `rsUnknown8589F5` / `rsUnknown858A6F` | **at start** halves `engine/unsorted/bank85.asm:1345`: `long pointer in lR18`; +2C halves `engine/unsorted/bank85.asm:1350`: `long pointer in lR18` |
| $85/8A95-$85/8AD6 | 66 | 64 (+0-+41) | `rsUnknown858A6F` / `rsUnknown858AD7` | **at start** halves `engine/unsorted/bank85.asm:1379`: `long pointer in lR18`; +1A halves `engine/unsorted/bank85.asm:1384`: `long pointer in lR18` |
| $85/8AFD-$85/8B50 | 84 | 82 (+0-+53) | `rsUnknown858AD7` / `rsUnknown858B51` | **at start** halves `engine/unsorted/bank85.asm:1413`: `long pointer in lR18`; +2C halves `engine/unsorted/bank85.asm:1418`: `long pointer in lR18` |
| $85/8BD3-$85/8C4D | 123 | 110 (+0-+7A) | `rsUnknown858B59` / `rsUnknown858C4E` | **at start** halves `engine/unsorted/bank85.asm:1465`: `long pointer in lR18`; +3A halves `engine/unsorted/bank85.asm:1472`: `long pointer in lR18`; +53 halves `engine/unsorted/bank85.asm:1480`: `long pointer in lR18`; +26 halves `engine/unsorted/bank85.asm:1491`: `long pointer in lR18`; and 1 more |
| $85/8C85-$85/8CD2 | 78 | 78 (+0-+4D) | `rsUnknown858C4E` / `rsMapMenuTypeDialogue` | **at start** halves `engine/unsorted/bank85.asm:1536`: `long pointer in lR18`; +26 halves `engine/unsorted/bank85.asm:1543`: `long pointer in lR18` |
| $85/8EA1-$85/8EC4 | 36 | 36 (+0-+23) | `rlUnknown858DB5` / `rlUnknown858EC5` | **at start** halves `engine/unsorted/bank85.asm:1632`: `long pointer in lR18`; +6 halves `engine/unsorted/bank85.asm:1641`: `long pointer in lR18`; +6 halves `engine/unsorted/bank85.asm:1651`: `long pointer in lR18`; +C halves `engine/unsorted/bank85.asm:1659`: `long pointer in lR18`; and 5 more |
| $85/9078-$85/90B8 | 65 | 55 (+0-+40) | `rlUnknown858F61` / `rlUnknown8590B9` | +8 halves `engine/unsorted/bank85.asm:1891`: `long pointer in lR18`; +8 halves `engine/unsorted/bank85.asm:1897`: `long pointer in lR18`; +8 halves `engine/unsorted/bank85.asm:1903`: `long pointer in lR18`; **at start** halves `engine/unsorted/bank85.asm:1933`: `long pointer in lR18`; and 3 more |
| $85/9953-$85/9972 | 32 | 32 (+0-+1F) | `rlUnknown85989A` / `rlUnknown859973` | +18 halves `engine/unsorted/bank85.asm:3292`: `long pointer in lR18`; +1C halves `engine/unsorted/bank85.asm:3298`: `long pointer in lR18`; **at start** halves `engine/unsorted/bank85.asm:3304`: `long pointer in lR18`; +4 halves `engine/unsorted/bank85.asm:3310`: `long pointer in lR18`; and 4 more |
| $85/9AA8-$85/9AB3 | 12 | 12 (+0-+B) | `rsUnknown859A66` / `rlUnknown859AB4` | +4 halves `engine/unsorted/bank85.asm:3486`: `long pointer in lR18`; **at start** halves `engine/unsorted/bank85.asm:3495`: `long pointer in lR18`; +8 halves `engine/unsorted/bank85.asm:3504`: `long pointer in lR18` |
| $85/9D88-$85/9D93 | 12 | 12 (+0-+B) | `rlUnknown859D60` / `rlUnknown859D94` | **at start** halves `engine/unsorted/bank85.asm:4177`: `long pointer in lR44` |
| $85/A4E6-$85/A507 | 34 | 34 (+0-+21) | `rlProcUnknown85A47FInit` / `rlProcUnknown85A47FCycle1` | **at start** halves `engine/unsorted/bank85.asm:5089`: `long pointer in lR18`; +14 halves `engine/unsorted/bank85.asm:5095`: `long pointer in lR18`; +1A halves `engine/unsorted/bank85.asm:5101`: `long pointer in lR18` |
| $85/A670-$85/A699 | 42 | 42 (+0-+29) | `rlUnknown85A5FB` / `rlUnknown85A69A` | **at start** halves `engine/unsorted/bank85.asm:5369`: `long pointer in lR18`; +10 halves `engine/unsorted/bank85.asm:5375`: `long pointer in lR18`; +18 halves `engine/unsorted/bank85.asm:5381`: `long pointer in lR18`; +20 halves `engine/unsorted/bank85.asm:5387`: `long pointer in lR18` |
| $85/A7CE-$85/A7DD | 16 | 16 (+0-+F) | `rlUnknown85A799` / `rlUnknown85A7DE` | **at start** halves `engine/unsorted/bank85.asm:5602`: `long pointer in lR18`; +8 halves `engine/unsorted/bank85.asm:5608`: `long pointer in lR18` |
| $85/AB82-$85/AB8D | 12 | 12 (+0-+B) | `rlFreeDialogueBoxes` / `rlUnknown85AB8E` | **at start** halves `engine/unsorted/bank85.asm:13428`: `long pointer in lR44` |
| $85/AD47-$85/AD66 | 32 | 25 (+0-+1F) | `rlUnknown85ACEE` / `rlUnknown85AD67` | +E halves `engine/unsorted/bank85.asm:6031`: `long pointer in lMapMenuTilemapRAMEntryPointer`; +17 halves `engine/unsorted/bank85.asm:6087`: `long pointer in lMapMenuTilemapRAMEntryPointer`; **at start** halves `engine/unsorted/bank85.asm:6092`: `long pointer in lR18`; +E halves `engine/unsorted/bank85.asm:6255`: `long pointer in lMapMenuTilemapRAMEntryPointer`; and 1 more |
| $85/AEBB-$85/AEC6 | 12 | 12 (+0-+B) | `aProcUnknown85ABF6Code` / `rlUnknown85AEC7` | **at start** halves `engine/unsorted/bank85.asm:6125`: `long pointer in lR44` |
| $85/B4E9-$85/B4EC | 4 | 0 | `rsUnknown85B489` / `rsUnknown85B4ED` | **at start** halves `engine/unsorted/bank85.asm:7646`: `long pointer in lR18` |
| $85/B547-$85/B63A | 244 | 0 | `rlUnknown85B52F` / `procUnknown85B63B` | **at start** halves `engine/unsorted/bank85.asm:7494`: `long pointer in lR44`; **at start** halves `engine/unsorted/bank85.asm:7551`: `long pointer in lR44` |
| $85/B6A0-$85/B6DF | 64 | 0 | `rlProcUnknown85B63BInit` / `rlProcUnknown85B63BCycle` | **at start** halves `engine/unsorted/bank85.asm:7788`: `long pointer in lR18`; +1A halves `engine/unsorted/bank85.asm:7794`: `long pointer in lR18`; +34 halves `engine/unsorted/bank85.asm:7800`: `long pointer in lR18` |
| $85/B786-$85/B789 | 4 | 0 | `rlProcUnknown85B6E3Init` / `rlProcUnknown85B6E3Cycle` | **at start** halves `engine/unsorted/bank85.asm:7888`: `long pointer in lR18` |
| $85/B8E5-$85/B8ED | 9 | 9 (+0-+8) | `rlUnknown85B8D6` / `aUnknown85B8EE` | **at start** number `engine/unsorted/bank85.asm:8083`: `.long $85B8E5` |
| $85/B9BC-$85/B9D3 | 24 | 24 (+0-+17) | `rlProcUnknown85B8FAInit` / `rlProcUnknown85B9D4Cycle1` | **at start** halves `engine/unsorted/bank85.asm:8196`: `long pointer in lR18` |
| $85/BAB3-$85/BAC6 | 20 | 20 (+0-+13) | `rlProcUnknown85BA41Init` / `rlProcUnknown85BA41Cycle` | **at start** number `engine/unsorted/bank85.asm:8354`: `lda #(`$85BAB3)<<8`; **at start** number `engine/unsorted/bank85.asm:8356`: `lda #<>$85BAB3` |
| $85/BE87-$85/C0B9 | 563 | 0 | `aUnknown85BE76` / `rlUnknown85C0BA` | **at start** named `include/Undisassembled.h:24`: `aUnknown85BE87, read by rlUnknown85BDA1` |
| $85/C19B-$85/C1A3 | 9 | 5 (+0-+8) | `rsUnknown85C162` / `rsUnknown85C1A4` | **at start** halves `engine/unsorted/bank85.asm:9292`: `long pointer in lMapMenuTilemapRAMEntryPointer` |
| $85/C652-$85/C659 | 8 | 8 (+0-+7) | `rsUnknown85C631` / `rlUnknown85C65A` | **at start** number `engine/map/windows.asm:18`: `lda #(`$85C652)<<8`; **at start** number `engine/map/windows.asm:20`: `lda #<>$85C652`; **at start** number `engine/map/windows.asm:52`: `lda #(`$85C652)<<8`; **at start** number `engine/map/windows.asm:54`: `lda #<>$85C652`; and 2 more |
| $85/C983-$85/C99E | 28 | 6 (+0-+5) | `rsUnknown85C867` / `rsUnknown85C99F` | **at start** halves `engine/unsorted/bank85.asm:10460`: `long pointer in lR18`; +3 halves `engine/unsorted/bank85.asm:10469`: `long pointer in lR18`; +14 halves `engine/unsorted/bank85.asm:10512`: `long pointer in lR18`; +14 halves `engine/unsorted/bank85.asm:10537`: `long pointer in lR18` |
| $85/D96D-$85/D970 | 4 | 4 (+0-+3) | `rlProcUnknown85D8AACycle` / `rlUnknown85D971` | **at start** halves `engine/unsorted/bank85.asm:13458`: `long pointer in lR18` |
| $87/9481-$87/9D76 | 2,294 | 570 (+6-+74F) | `aUnknown879471` / `aUnknown879D77` | **at start** named `include/Undisassembled.h:9`: `aUnknown879481, read by rlDrawMenuTextLine`; 78% $00/$FF |
| $87/C5BF-$87/C645 | 135 | 0 | `rlUnknown87C5AA` / `rlUnknown87C646` | **at start** halves `engine/unsorted/bank87.asm:5905`: `long pointer in lR19` |
| $87/C784-$87/C7B3 | 48 | 0 | `rlUnknown87C712` / `rlUnknown87C7B4` | **at start** halves `engine/unsorted/bank87.asm:6078`: `long pointer in lR19`; +27 halves `engine/unsorted/bank87.asm:6095`: `long pointer in lMapMenuTilemapRAMEntryPointer`; +27 halves `engine/unsorted/bank87.asm:6181`: `long pointer in lMapMenuTilemapRAMEntryPointer` |
| $87/C866-$87/C879 | 20 | 0 | `rsUnknown87C821` / `rsUnknown87C87A` | **at start** halves `engine/unsorted/bank87.asm:6230`: `long pointer in lR18`; +5 halves `engine/unsorted/bank87.asm:6236`: `long pointer in lR18`; +A halves `engine/unsorted/bank87.asm:6242`: `long pointer in lR18`; +F halves `engine/unsorted/bank87.asm:6248`: `long pointer in lR18` |
| $87/C8E1-$87/CBC4 | 740 | 0 | `rsUnknown87C87A` / `rlUnknown87CBC5` | **at start** halves `engine/unsorted/bank87.asm:6275`: `long pointer in lR18`; +A halves `engine/unsorted/bank87.asm:6281`: `long pointer in lR18`; +14 halves `engine/unsorted/bank87.asm:6287`: `long pointer in lR18`; +1E halves `engine/unsorted/bank87.asm:6293`: `long pointer in lR18`; and 2 more |
| $88/93DB-$88/93FF | 37 | 37 (+0-+24) | `rlProcUnknown889396Init` / `rlProcUnknown889396Cycle` | **at start** halves `engine/unsorted/bank88.asm:2676`: `long pointer in lR19` |
| $88/94F2-$88/9503 | 18 | 8 (+9-+11) | `rlUnknown88949F` / `aProcUnknown889396Code` | **at start** halves `engine/unsorted/bank88.asm:2862`: `long pointer in lMapMenuTilemapRAMEntryPointer`; +9 halves `engine/unsorted/bank88.asm:2870`: `long pointer in lMapMenuTilemapRAMEntryPointer` |
| $88/958F-$88/96AE | 288 | 212 (+2-+FF) | `rsUnknown889506` / `rsUnknown8896AF` | **at start** named `include/Undisassembled.h:32`: `aUnknown88958F, read by rsUnknown889506` |
| $88/99A4-$88/99B7 | 20 | 0 | `rsUnknown88986C` / `rlUnknown8899B8` | **at start** halves `engine/unsorted/bank88.asm:3376`: `long pointer in lRoutineVariable` |
| $88/9D92-$88/9DA5 | 20 | 20 (+0-+13) | `rlUnknown889D20` / `rlUnknown889DA6` | **at start** halves `engine/unsorted/bank88.asm:4045`: `long pointer in lRoutineVariable` |
| $88/E2DE-$88/E2E8 | 11 | 0 | `aProcUnknown88E26ACode` / `rlUnknown88E2E9` | **at start** halves `engine/unsorted/bank88.asm:12654`: `long pointer in lR44` |
| $89/8973-$89/89AC | 58 | 40 (+0-+27) | `rlUnknown89876D` / `rsUnknown8989AD` | **at start** halves `engine/unsorted/bank89.asm:1197`: `long pointer in lR18`; +C halves `engine/unsorted/bank89.asm:1203`: `long pointer in lR18`; +16 halves `engine/unsorted/bank89.asm:1209`: `long pointer in lR18`; +20 halves `engine/unsorted/bank89.asm:1215`: `long pointer in lR18`; and 1 more |
| $89/9140-$89/914A | 11 | 11 (+0-+A) | `rlClearTilemapRect` / `rlUnknown89914B` | **at start** halves `engine/unsorted/bank80.asm:6169`: `long pointer in lR44` |
| $89/91B9-$89/91C3 | 11 | 11 (+0-+A) | `rlUnknown899185` / `rlUnknown8991C4` | **at start** halves `engine/unsorted/bank80.asm:6179`: `long pointer in lR44` |
| $89/9703-$89/970C | 10 | 4 (+6-+9) | `rlUnknown899510` / `rlUnknown89970D` | **at start** halves `engine/unsorted/bank89.asm:3100`: `long pointer in lR18`; **at start** halves `engine/unsorted/bank89.asm:3163`: `long pointer in lR18`; +6 halves `engine/unsorted/bank89.asm:3194`: `long pointer in lR18`; **at start** halves `engine/unsorted/bank89.asm:3218`: `long pointer in lR18` |
| $89/9C44-$89/9C7B | 56 | 56 (+0-+37) | `rlUnknown899BA5` / `rlUnknown899C7C` | **at start** halves `engine/unsorted/bank89.asm:3799`: `long pointer in lR18`; +A halves `engine/unsorted/bank89.asm:3813`: `long pointer in lR18`; +E halves `engine/unsorted/bank89.asm:3821`: `long pointer in lR18`; +18 halves `engine/unsorted/bank89.asm:3827`: `long pointer in lR18`; and 2 more |
| $89/9D26-$89/9D71 | 76 | 76 (+0-+4B) | `rlUnknown899C7C` / `rlUnknown899D72` | **at start** halves `engine/unsorted/bank89.asm:3884`: `long pointer in lR18`; +8 halves `engine/unsorted/bank89.asm:3890`: `long pointer in lR18`; +12 halves `engine/unsorted/bank89.asm:3896`: `long pointer in lR18`; +18 halves `engine/unsorted/bank89.asm:3902`: `long pointer in lR18`; and 3 more |
| $89/9F0B-$89/9FA0 | 150 | 140 (+A-+95) | `rlUnknown899D72` / `rlUnknown899FA1` | +A halves `engine/unsorted/bank89.asm:3982`: `long pointer in lR18`; **at start** halves `engine/unsorted/bank89.asm:3990`: `long pointer in lR18`; +3C halves `engine/unsorted/bank89.asm:4000`: `long pointer in lR18`; +14 halves `engine/unsorted/bank89.asm:4008`: `long pointer in lR18`; and 14 more |
| $89/A4C5-$89/A4E2 | 30 | 0 | `rsUnknown89A3C0` / `rsUnknown89A4E3` | +E halves `engine/unsorted/bank89.asm:4841`: `long pointer in lR18`; **at start** halves `engine/unsorted/bank89.asm:4849`: `long pointer in lR18` |
| $89/BAC1-$89/BAF2 | 50 | 40 (+0-+27) | `rlItemWindowDrawItemInfo` / `rsItemWindowClearItemInfo` | **at start** halves `engine/menus/item_window.asm:1432`: `long pointer in lR18`; +C halves `engine/menus/item_window.asm:1438`: `long pointer in lR18`; +16 halves `engine/menus/item_window.asm:1444`: `long pointer in lR18`; +20 halves `engine/menus/item_window.asm:1450`: `long pointer in lR18` |
| $89/EF40-$89/EF4F | 16 | 0 | `rsUnknown89EF13` / `rsUnknown89EF50` | **at start** halves `engine/unsorted/bank89.asm:7432`: `long pointer in lR18`; +8 halves `engine/unsorted/bank89.asm:7441`: `long pointer in lR18` |
| $89/F051-$89/F064 | 20 | 0 | `rsUnknown89F03F` / `rlUnknown89F065` | +A halves `engine/unsorted/bank89.asm:7751`: `long pointer in lR18`; **at start** halves `engine/unsorted/bank89.asm:7770`: `long pointer in lR18` |
| $89/F338-$89/F578 | 577 | 71 (+0-+5E) | `rlUnknown89F246` / `aUnknown89F579` | **at start** named `include/Undisassembled.h:33`: `aUnknown89F338, read by rlUnknown89F246` |
| $89/F88B-$89/FFFF | 1,909 | 28 (+8-+2B) | `rlUnknown89F842` / `` | +4 halves `engine/unsorted/bank89.asm:7130`: `long pointer in lR18`; +8 halves `engine/unsorted/bank89.asm:7148`: `long pointer in lR18`; +C halves `engine/unsorted/bank89.asm:7174`: `long pointer in lR18`; +22 halves `engine/unsorted/bank89.asm:7216`: `long pointer in lR18`; and 14 more; 98% $00/$FF |
| $8A/85EF-$8A/8642 | 84 | 60 (+0-+3B) | `rlUnknown8A8496` / `rsUnknown8A8643` | **at start** halves `engine/unsorted/bank8A.asm:1079`: `long pointer in lRoutineVariable`; +32 halves `engine/unsorted/bank8A.asm:1122`: `long pointer in lRoutineVariable`; +38 halves `engine/unsorted/bank8A.asm:1132`: `long pointer in lRoutineVariable`; +4C halves `engine/unsorted/bank8A.asm:1184`: `long pointer in lRoutineVariable` |
| $8A/88E0-$8A/897F | 160 | 100 (+0-+77) | `rsUnknown8A889A` / `rsUnknown8A8980` | **at start** halves `engine/unsorted/bank8A.asm:1534`: `long pointer in lRoutineVariable`; +14 halves `engine/unsorted/bank8A.asm:1553`: `long pointer in lRoutineVariable`; +28 halves `engine/unsorted/bank8A.asm:1572`: `long pointer in lRoutineVariable`; +3C halves `engine/unsorted/bank8A.asm:1592`: `long pointer in lRoutineVariable`; and 6 more |
| $8A/9158-$8A/9189 | 50 | 0 | `rsUnknown8A90C7` / `rsUnknown8A918A` | **at start** halves `engine/unsorted/bank8A.asm:2785`: `long pointer in lRoutineVariable` |
| $8A/91D7-$8A/9208 | 50 | 0 | `rsUnknown8A918A` / `rsUnknown8A9209` | **at start** halves `engine/unsorted/bank8A.asm:2850`: `long pointer in lRoutineVariable` |
| $8A/9269-$8A/929A | 50 | 0 | `rsUnknown8A9209` / `rsUnknown8A929B` | **at start** halves `engine/unsorted/bank8A.asm:2906`: `long pointer in lRoutineVariable` |
| $8A/945E-$8A/94B5 | 88 | 8 (+0-+9) | `rsUnknown8A9389` / `rlUnknown8A94B6` | **at start** named `include/Undisassembled.h:25`: `aUnknown8A945E, read by rsUnknown8A9389` |
| $8A/9DD5-$8A/9DF1 | 29 | 3 (+0-+2) | `aUnknown8A9D79` / `rlUnknown8A9DF2` | **at start** named `include/Undisassembled.h:34`: `aUnknown8A9DD5, read by rsUnknown8AC168, rsUnknown8AC524, rs` |
| $8A/A022-$8A/A02A | 9 | 0 | `rlUnknown8AA013` / `rsUnknown8AA02B` | **at start** halves `engine/unsorted/bank8A.asm:4709`: `long pointer in lMapMenuTilemapRAMEntryPointer` |
| $8A/A12E-$8A/A141 | 20 | 0 | `rsUnknown8AA02B` / `rsUnknown8AA142` | **at start** halves `engine/unsorted/bank8A.asm:4804`: `long pointer in lRoutineVariable` |
| $8A/A241-$8A/A2EC | 172 | 16 (+0-+F) | `rsUnknown8AA222` / `rsUnknown8AA2ED` | **at start** named `include/Undisassembled.h:26`: `aUnknown8AA241, read by rsUnknown8AA142` |
| $8A/A31C-$8A/A3FF | 228 | 44 (+0-+2B) | `rsUnknown8AA2ED` / `rsUnknown8AA400` | **at start** halves `engine/unsorted/bank8A.asm:5018`: `long pointer in lRoutineVariable`; +4 halves `engine/unsorted/bank8A.asm:6047`: `long pointer in lR18`; +4 halves `engine/unsorted/bank8A.asm:6291`: `long pointer in lR18`; +4 halves `engine/unsorted/bank8A.asm:6409`: `long pointer in lR18`; and 3 more |
| $8A/A7DD-$8A/A82F | 83 | 24 (+0-+17) | `rsUnknown8AA6CA` / `rsUnknown8AA830` | **at start** halves `engine/unsorted/bank8A.asm:5611`: `long pointer in lRoutineVariable`; **at start** halves `engine/unsorted/bank8A.asm:5621`: `long pointer in lRoutineVariable`; +14 halves `engine/unsorted/bank8A.asm:5646`: `long pointer in lRoutineVariable` |
| $8A/A8B5-$8A/A8C8 | 20 | 0 | `rlUnknown8AA83D` / `rsUnknown8AA8C9` | **at start** halves `engine/unsorted/bank8A.asm:5720`: `long pointer in lRoutineVariable` |
| $8A/AA78-$8A/AA89 | 18 | 0 | `rsUnknown8AAA3A` / `rsUnknown8AAA8A` | **at start** halves `engine/unsorted/bank8A.asm:6080`: `long pointer in lR18` |
| $8A/AB40-$8A/AB47 | 8 | 0 | `rsUnknown8AAAE7` / `rsUnknown8AAB48` | **at start** halves `engine/unsorted/bank8A.asm:6215`: `long pointer in lR18` |
| $8A/ABEA-$8A/ABFB | 18 | 18 (+0-+11) | `rsUnknown8AABAB` / `rsUnknown8AABFC` | **at start** halves `engine/unsorted/bank8A.asm:6324`: `long pointer in lR18` |
| $8A/ACA0-$8A/ACA7 | 8 | 0 | `rsUnknown8AAC51` / `rsUnknown8AACA8` | **at start** halves `engine/unsorted/bank8A.asm:6465`: `long pointer in lR18` |
| $8A/ADCE-$8A/ADF3 | 38 | 26 (+0-+19) | `rsUnknown8AADC3` / `rsUnknown8AADF4` | **at start** halves `engine/unsorted/bank8A.asm:6726`: `long pointer in lR18`; +E halves `engine/unsorted/bank8A.asm:6743`: `long pointer in lR18`; +1A halves `engine/unsorted/bank8A.asm:6768`: `long pointer in lR18` |
| $8A/AEDA-$8A/AF09 | 48 | 0 | `rsUnknown8AADF4` / `rsUnknown8AAF0A` | **at start** halves `engine/unsorted/bank8A.asm:6795`: `long pointer in lRoutineVariable`; +12 halves `engine/unsorted/bank8A.asm:6845`: `long pointer in lRoutineVariable`; +C halves `engine/unsorted/bank8A.asm:6855`: `long pointer in lRoutineVariable` |
| $8A/B230-$8A/B23A | 11 | 11 (+0-+A) | `rlUnknown8AB111` / `rlUnknown8AB23B` | **at start** halves `engine/unsorted/bank8A.asm:7816`: `long pointer in lR44`; **at start** halves `engine/unsorted/bank8A.asm:12114`: `long pointer in lR44`; **at start** halves `engine/unsorted/bank8A.asm:12846`: `long pointer in lR44` |
| $8A/C447-$8A/C456 | 16 | 16 (+0-+F) | `rsUnknown8AC1BC` / `rsUnknown8AC457` | **at start** halves `engine/unsorted/bank8A.asm:8588`: `long pointer in lR18` |
| $8A/D071-$8A/D091 | 33 | 12 (+6-+16) | `rsUnknown8ACFBE` / `rsUnknown8AD092` | +17 halves `engine/arena/arena.asm:338`: `long pointer in lR19`; +19 halves `engine/arena/arena.asm:342`: `long pointer in lR20`; +1B halves `engine/arena/arena.asm:673`: `long pointer in lR19`; +1E halves `engine/arena/arena.asm:677`: `long pointer in lR20`; and 8 more |
| $8A/F475-$8A/F4A0 | 44 | 44 (+0-+2B) | `rsUnknown8AF362` / `rsUnknown8AF4A1` | **at start** halves `engine/unsorted/bank8A.asm:13054`: `long pointer in lR18` |
| $8B/911F-$8B/9129 | 11 | 11 (+0-+A) | `aProcUnknown8B90D9Code` / `rlUnknown8B912A` | **at start** halves `engine/unsorted/bank80.asm:4962`: `long pointer in lR44` |
| $8B/9449-$8B/9450 | 8 | 8 (+0-+7) | `rlUnknown8B9275` / `rlUnknown8B9451` | **at start** halves `engine/unsorted/bank80.asm:4739`: `long pointer in lR44` |
| $8B/9594-$8B/959B | 8 | 8 (+0-+7) | `rlUnknown8B9458` / `rlUnknown8B959C` | **at start** halves `engine/unsorted/bank80.asm:4744`: `long pointer in lR44` |
| $8B/C96A-$8B/C971 | 8 | 0 | `rsUnknown8BC952` / `rsUnknown8BC972` | **at start** halves `engine/menus/unit_window.asm:5330`: `long pointer in lR18` |
| $8B/DC22-$8B/DC91 | 112 | 9 (+4-+1F) | `rsSkillWindowRenderArrows` / `rsSkillWindowMoveUp` | **at start** named `include/Undisassembled.h:35`: `aUnknown8BDC22, read by rsSkillWindowRenderArrows` |
| $8C/9800-$8C/9CFF | 1,280 | 1024 (+0-+3FF) | `aUnknown8C9700` / `aUnknown8C9D00` | **at start** named `include/Undisassembled.h:12`: `aUnknown8C9800, read by rlUnknown8A8F68`; +200 named `include/Undisassembled.h:13`: `aUnknown8C9A00, read by rlUnknown80BA52` |
| $8C/A000-$8C/A7FF | 2,048 | 0 | `aDialogueBackgroundFountainPalette` / `aPortraitPaletteSigurd` | **at start** named `include/Undisassembled.h:14`: `aUnknown8CA000, read by rsUnknown8AE076`; +200 named `include/Undisassembled.h:36`: `aUnknown8CA200, read by rlUnknown80EE37`; +400 named `include/Undisassembled.h:37`: `aUnknown8CA400, read by rlUnknown80EFD8, rlUnknown8DAF33`; +620 named `include/Undisassembled.h:38`: `aUnknown8CA620, read by rlUnknown88E033` |
| $8C/D000-$8C/DBFF | 3,072 | 2560 (+0-+BFF) | `aDialogueBackgroundCloisterPalette` / `aUnknown8CDC00` | +600 named `include/Undisassembled.h:27`: `aUnknown8CD600, read by rlUnknown8AE2F8`; **at start** named `include/Undisassembled.h:39`: `aUnknown8CD000, read by rlUnknown8AECEF`; +200 named `include/Undisassembled.h:40`: `aUnknown8CD200, read by rsUnknown8ABE63`; +400 named `include/Undisassembled.h:41`: `aUnknown8CD400, read by rsUnknown8ABE63`; and 2 more |
| $8C/DCB0-$8C/DDFF | 336 | 336 (+0-+14F) | `aUnknown8CDC30` / `aUnknown8CDE00` | **at start** named `include/Undisassembled.h:15`: `aUnknown8CDCB0, read by rsWorldMapMarkerShadowLoadRedPalette` |
| $8D/9BF6-$8D/9FB0 | 955 | 79 (+0-+F8) | `aUnknown8D9B65` / `dialogueGen1HomeCastleSeized` | +BE halves `engine/unsorted/bank91.asm:619`: `long pointer in lR19`; +BE halves `engine/unsorted/bank91.asm:628`: `long pointer in lR19`; +B6 halves `engine/unsorted/bank91.asm:701`: `long pointer in lR19`; +92 halves `engine/unsorted/bank91.asm:804`: `long pointer in lR18`; and 4 more |
| $90/E8CE-$90/EBC9 | 764 | 6 (+6B-+70) | `dialogueChapter06DanannBattleQuote` / `rlUnknown90EBCA` | **at start** halves `engine/unsorted/bank9B.asm:423`: `long pointer in lR18` |
| $91/B34C-$91/B495 | 330 | 48 (+0-+2F) | `rsUnknown91B341` / `rsUnknown91B496` | **at start** named `include/Undisassembled.h:44`: `aUnknown91B34C, read by rlUnknown91B164, rsUnknown91B20A, rs`; 59% $00/$FF |
| $91/B546-$91/BA45 | 1,280 | 512 (+0-+1FF) | `rsUnknown91B511` / `rlUnknown91BA46` | **at start** named `include/Undisassembled.h:45`: `aUnknown91B546, read by rsUnknown91B511` |
| $91/DE9F-$91/DEA0 | 2 | 2 (+0-+1) | `rsUnknown91DE4D` / `rsUnknown91DEA1` | **at start** halves `engine/unsorted/bank91.asm:3407`: `long pointer in lR18` |
| $91/E089-$91/E094 | 12 | 12 (+0-+B) | `rlUnknown91E07A` / `rlUnknown91E095` | **at start** halves `engine/unsorted/bank91.asm:3663`: `long pointer in lR44` |
| $95/AB80-$95/ABBA | 59 | 2 (+0-+1) | `rlUnknown95AB53` / `rlUnknown95ABBB` | **at start** named `include/Undisassembled.h:46`: `aUnknown95AB80, read by rlUnknown95AB53` |
| $95/AD8C-$95/ADD5 | 74 | 0 | `aUnknown95AD64` / `rlUnknown95ADD6` | **at start** named `include/Undisassembled.h:47`: `aUnknown95AD8C, read by rlUnknown95ACF6` |
| $95/E69E-$95/E6A9 | 12 | 0 | `rlUnknown95E5DB` / `rlUnknown95E6AA` | **at start** halves `engine/battle_scene/script.asm:456`: `long pointer in lR44` |
| $95/EA91-$95/ED4D | 701 | 23 (+0-+16) | `rlUnknown95EA6A` / `rlUnknown95ED4E` | **at start** halves `engine/unsorted/bank95.asm:17663`: `long pointer in lR18` |
| $D7/7000-$D7/7FFF | 4,096 | 4096 (+0-+FFF) | `g2bppShopLabels` / `rlUnknown978000` | **at start** named `include/Undisassembled.h:18`: `aUnknownD77000, read by rlUnknown80BA52` |
| $97/BEAC-$97/C827 | 2,428 | 80 (+24-+5E7) | `aUnknown97BDD4` / `aUnknown97C828` | **at start** named `include/Undisassembled.h:49`: `aUnknown97BEAC, read by rlBattleSceneCommandBGScrollEffect`; +428 named `include/Undisassembled.h:50`: `aUnknown97C2D4, read by rlBattleSceneStartBG2Shake`; +5B6 named `include/Undisassembled.h:51`: `aUnknown97C462, read by rlUnknown96C008` |
| $97/E8FB-$97/FFFF | 5,893 | 1073 (+0-+1256) | `aBattleAnimationMoveScriptsJuniorLordSword` / `g4bppShopScreen` | +D53 halves `engine/unsorted/bank95.asm:18602`: `long pointer in lR18`; **at start** named `include/Undisassembled.h:52`: `aUnknown97E8FB, read by rsBattleAnimationGetBodyIndex`; +19F named `include/Undisassembled.h:53`: `aUnknown97EA9A, read by rlBattleAnimationGetBodyWidth, rlBat`; +31F named `include/Undisassembled.h:54`: `aUnknown97EC1A, read by rlUnknown95B80C`; and 1 more |
| $98/AD65-$98/AFFC | 664 | 58 (+1-+3A) | `aUnknown98AD04` / `aUnknown98AFFD` | **at start** named `include/Undisassembled.h:56`: `aUnknown98AD65, read by rlUnknown95CAD5`; 58% $00/$FF |
| $98/B231-$98/B387 | 343 | 0 | `aUnknown98B173` / `aUnknown98B388` | **at start** named `include/Undisassembled.h:57`: `aUnknown98B231, read by rsUnknown96F7EB` |
| $D9/5000-$99/8193 | 12,692 | 8726 (+0-+3193) | `g4bppMapTiles` / `aBattleCharacterPieceLookup` | **at start** named `include/Undisassembled.h:19`: `aUnknownD95000, read by rlUnknown888082, rlUnknown88821A`; +3000 named `include/Undisassembled.h:58`: `aUnknown998000, read by rlUnknown96C8A1`; +2C00 named `include/Undisassembled.h:63`: `aUnknownD97C00, read by rlUnknown88E033` |
| $99/8944-$99/8D83 | 1,088 | 67 (+0-+C5) | `aUnknown99892A` / `aBattleBannerTable` | **at start** named `include/Undisassembled.h:16`: `aUnknown998944, read by rsUnknown959B84, rsUnknown959BC1`; +1CA named `include/Undisassembled.h:59`: `aUnknown998B0E, read by rsUnknown95C0F3` |
| $DA/65B2-$DA/79FF | 5,198 | 2222 (+0-+F1F) | `aUnknownDA65AA` / `g4bppUnknownDA7A00` | +A4E named `include/Undisassembled.h:29`: `aUnknownDA7000, read by rsUnknown8AA9A6`; **at start** named `include/Undisassembled.h:64`: `aUnknownDA65B2, read by rsUnknown8A8CB7` |
| $9B/DF09-$9B/DFA9 | 161 | 44 (+0-+2B) | `rlUnknown9BDE69` / `rlUnknown9BDFAA` | **at start** halves `engine/unsorted/bank9B.asm:354`: `long pointer in lR18` |
| $9B/F69D-$9B/F6B0 | 20 | 20 (+0-+13) | `rlUnknown9BF65C` / `rlUnknown9BF6B1` | **at start** halves `engine/unsorted/bank9B.asm:2324`: `long pointer in lR18` |
| $9B/F715-$9B/F725 | 17 | 17 (+0-+10) | `rlUnknown9BF6D6` / `rlUnknown9BF726` | **at start** halves `engine/unsorted/bank9B.asm:2404`: `long pointer in lR18` |
| $9B/FA69-$9B/FA6D | 5 | 5 (+0-+4) | `rlUnknown9BFA58` / `rlUnknown9BFA6E` | **at start** halves `engine/unsorted/bank9B.asm:2513`: `long pointer in lR18`; 60% $00/$FF |
| $9B/FA7F-$9B/FA84 | 6 | 6 (+0-+5) | `rlUnknown9BFA6E` / `rlUnknown9BFA85` | **at start** halves `engine/unsorted/bank9B.asm:2542`: `long pointer in lR18` |
| $9B/FA96-$9B/FAA0 | 11 | 11 (+0-+A) | `rlUnknown9BFA85` / `rlUnknown9BFAA1` | **at start** halves `engine/unsorted/bank9B.asm:2571`: `long pointer in lR18`; 63% $00/$FF |
| $9B/FAB2-$9B/FAB6 | 5 | 5 (+0-+4) | `rlUnknown9BFAA1` / `rlUnknown9BFAB7` | **at start** halves `engine/unsorted/bank9B.asm:2600`: `long pointer in lR18`; 60% $00/$FF |
| $9B/FB46-$9B/FB5C | 23 | 23 (+0-+16) | `rlUnknown9BFAC6` / `rlUnknown9BFB5D` | **at start** halves `engine/unsorted/bank9B.asm:2653`: `long pointer in lR18` |
| $9E/98B0-$9E/98C3 | 20 | 0 | `rlUnknown9E985E` / `rlUnknown9E98C4` | **at start** halves `engine/unsorted/bank9E.asm:3959`: `long pointer in lR19` |
| $9E/9910-$9E/9927 | 24 | 0 | `rlUnknown9E98C4` / `rlUnknown9E9928` | **at start** halves `engine/unsorted/bank9E.asm:4011`: `long pointer in lR19` |
| $9E/994F-$9E/9966 | 24 | 0 | `rlUnknown9E9928` / `rlUnknown9E9967` | **at start** halves `engine/unsorted/bank9E.asm:4052`: `long pointer in lR19` |
| $9E/998E-$9E/99A3 | 22 | 0 | `rlUnknown9E9967` / `rlUnknown9E99A4` | **at start** halves `engine/unsorted/bank9E.asm:4088`: `long pointer in lR19` |
| $9E/A513-$9E/A67B | 361 | 0 | `aUnknown9EA50F` / `rlUnknown9EA67C` | **at start** named `include/Undisassembled.h:17`: `aUnknown9EA513, read by rlUnknown9EA417` |
| $9E/AA5C-$9E/AA60 | 5 | 0 | `rlUnknown9EA9B5` / `aUnknown9EAA61` | **at start** halves `engine/unsorted/bank9E.asm:6580`: `long pointer in lR18` |
| $9F/8C3A-$9F/8E6B | 562 | 264 (+0-+1FD) | `rlUnknown9F8C05` / `rlSavePaletteBufferColorsToRAM` | **at start** named `include/Undisassembled.h:62`: `aUnknown9F8C3A, read by rlUnknown9F8B7A, rlUnknown9F8C05` |
| $9F/936C-$9F/9377 | 12 | 6 (+0-+5) | `rlUnknown9F9341` / `rlUnknown9F9378` | **at start** halves `engine/unsorted/bank9F.asm:1999`: `long pointer in lR44` |
| $9F/FACC-$9F/FFFF | 1,332 | 0 | `rlUnknown9FFAC0` / `aBattleBackgroundBridgePalette` | **at start** number `engine/unsorted/bank80.asm:3377`: `.long $9FFACC`; **at start** number `engine/unsorted/bank80.asm:3378`: `.long $9FFACC`; **at start** number `engine/unsorted/bank80.asm:3379`: `.long $9FFACC`; **at start** number `engine/unsorted/bank80.asm:3380`: `.long $9FFACC`; and 1 more; 93% $00/$FF |
| $F7/7C12-$BF/FFFF | 558,062 | 176364 (+0-+867BC) | `aUnknownF77C0C` / `` | **at start** named `include/Undisassembled.h:21`: `aUnknownF77C12, read by rsUnknown8093C6` |

## `inside` (40)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|
| $80/C716-$80/C722 | 13 | 13 (+0-+C) | `rlUnitWindowBG3VOFSHDMACycle` / `rlUnitWindowBG1VOFSHDMAInit` | +2 halves `engine/menus/unit_window.asm:404`: `long pointer in lR44` |
| $80/C760-$80/C76C | 13 | 13 (+0-+C) | `rlUnitWindowBG1VOFSHDMACycle` / `rlUnitWindowCGADSUBHDMAInit` | +2 halves `engine/menus/unit_window.asm:409`: `long pointer in lR44` |
| $80/C88A-$80/C896 | 13 | 13 (+0-+C) | `rlUnitWindowCGADSUBHDMACycle` / `rlUnitWindowBG2VOFSHDMAInit` | +2 halves `engine/menus/unit_window.asm:414`: `long pointer in lR44` |
| $80/F37D-$80/F389 | 13 | 13 (+0-+C) | `rlUnknown80F37C` / `rlUnknown80F38A` | +2 halves `engine/unsorted/bank80.asm:8298`: `long pointer in lR44` |
| $82/C26D-$82/E027 | 7,611 | 4 (+1D93-+1D96) | `rsHDMACodeSetTableBank` / `rsUnknown82E028` | +1D93 halves `engine/unsorted/bank80.asm:3714`: `long pointer in lR44`; 99% $00/$FF |
| $85/8D62-$85/8D82 | 33 | 33 (+0-+20) | `rsUnknown858D18` / `rlUnknown858D83` | +15 halves `engine/unsorted/bank85.asm:2221`: `long pointer in lR44`; +15 halves `engine/unsorted/bank85.asm:2285`: `long pointer in lR44` |
| $85/AF0D-$85/AF1A | 14 | 14 (+0-+D) | `rlUnknown85AF0C` / `rlUnknown85AF1B` | +2 halves `engine/unsorted/bank85.asm:6227`: `long pointer in lR44` |
| $85/B6EB-$85/B724 | 58 | 0 | `procUnknown85B6E3` / `rlProcUnknown85B6E3Init` | +19 halves `engine/unsorted/bank85.asm:7489`: `long pointer in lR44` |
| $85/BA2C-$85/BA40 | 21 | 21 (+0-+14) | `rlUnknown85B9F2` / `procUnknown85BA41` | +9 number `engine/unsorted/bank85.asm:8307`: `.long $85BA35` |
| $85/C33D-$85/C346 | 10 | 10 (+0-+9) | `rlUnknown85C31A` / `rlUnknown85C347` | +2 number `engine/map/windows.asm:32`: `lda #(`$85C33F)<<8`; +2 number `engine/map/windows.asm:34`: `lda #<>$85C33F`; +2 number `engine/map/windows.asm:62`: `lda #(`$85C33F)<<8`; +2 number `engine/map/windows.asm:64`: `lda #<>$85C33F` |
| $88/E9E4-$88/EEB0 | 1,229 | 110 (+458-+4C5) | `rlUnknown88E9BE` / `rlUnknown88EEB1` | +1 halves `engine/unsorted/bank88.asm:12728`: `long pointer in lR18`; +250 halves `engine/unsorted/bank88.asm:13043`: `long pointer in lR18`; +26D halves `engine/unsorted/bank88.asm:13072`: `long pointer in lR18`; +288 halves `engine/unsorted/bank88.asm:13101`: `long pointer in lR18`; and 35 more |
| $89/9178-$89/9184 | 13 | 13 (+0-+C) | `rlUnknown89914B` / `rlUnknown899185` | +2 halves `engine/unsorted/bank80.asm:6174`: `long pointer in lR44` |
| $89/9B8F-$89/9BA4 | 22 | 10 (+4-+D) | `rlUnknown8998E1` / `rlUnknown899BA5` | +4 halves `engine/unsorted/bank89.asm:3495`: `long pointer in lR18`; +4 halves `engine/unsorted/bank89.asm:3508`: `long pointer in lRoutineVariable`; +4 halves `engine/unsorted/bank89.asm:3531`: `long pointer in lRoutineVariable`; +4 halves `engine/unsorted/bank89.asm:3583`: `long pointer in lRoutineVariable`; and 3 more |
| $89/A72E-$89/ABF8 | 1,227 | 145 (+0-+3DC) | `rsUnknown89A68C` / `aSkillDescriptionPointers` | +3E named `include/Undisassembled.h:10`: `aUnknown89A76C, read by rlUnknown8A8496` |
| $8A/9899-$8A/98AB | 19 | 18 (+1-+12) | `rlUnknown8A9858` / `aUnknown8A98AC` | +1 halves `engine/unsorted/bank8A.asm:3729`: `long pointer in lR18` |
| $8A/DB9F-$8A/DBBC | 30 | 14 (+10-+1D) | `rlDisplayDialogueAPressArrows` / `rsUnknown8ADBBD` | +10 number `engine/dialogue/dialogue_box.asm:980`: `lda #`$8ADBAF`; +10 number `engine/dialogue/dialogue_box.asm:985`: `ldy #<>$8ADBAF`; +17 number `engine/dialogue/dialogue_box.asm:990`: `lda #`$8ADBB6`; +17 number `engine/dialogue/dialogue_box.asm:994`: `ldy #<>$8ADBB6`; 66% $00/$FF |
| $8C/EAE0-$8C/ECFF | 544 | 0 | `aChapterMapFinalPalette` / `rlUnknown8CED00` | +E0 number `engine/unsorted/bank8D.asm:1533`: `lda $8CEBC0,x`; +22 number `engine/unsorted/bank8D.asm:1541`: `lda $8CEB02,x`; +E0 number `engine/unsorted/bank8D.asm:1657`: `lda $8CEBC0,x`; +22 number `engine/unsorted/bank8D.asm:1665`: `lda $8CEB02,x` |
| $8D/A449-$8D/A4B2 | 106 | 0 | `rlUnknown8DA3DE` / `rlUnknown8DA4B3` | +5F halves `engine/unsorted/bank8D.asm:197`: `long pointer in lR44` |
| $8D/A502-$8D/A50E | 13 | 0 | `rlUnknown8DA4B3` / `rlUnknown8DA50F` | +2 halves `engine/unsorted/bank8D.asm:192`: `long pointer in lR44` |
| $8D/ADFA-$8D/AE84 | 139 | 0 | `rsUnknown8DAD9E` / `rlUnknown8DAE85` | +80 halves `engine/unsorted/bank80.asm:8005`: `long pointer in lR44` |
| $8D/C964-$8D/CF87 | 1,572 | 0 | `rlASMCUnknown8DC955` / `aUnknown8DCF88` | +42 halves `engine/unsorted/bank80.asm:7791`: `long pointer in lR18`; +9B halves `engine/unsorted/bank80.asm:7997`: `long pointer in lR18`; +42 halves `engine/unsorted/bank8D.asm:1871`: `long pointer in lR18`; +2D9 halves `engine/unsorted/bank8D.asm:2825`: `long pointer in lR18`; and 7 more |
| $91/E09E-$91/E274 | 471 | 2 (+0-+1) | `rlUnknown91E09D` / `rsUnknown91E275` | +E7 halves `engine/menus/revive_screen.asm:293`: `long pointer in lR44` |
| $95/E6AC-$95/E7B2 | 263 | 50 (+0-+EE) | `rlUnknown95E6AB` / `rlUnknown95E7B3` | +62 halves `engine/battle_scene/script.asm:467`: `long pointer in lR44`; +3E halves `engine/unsorted/bank95.asm:5968`: `long pointer in lR44`; +26 halves `engine/unsorted/bank95.asm:5988`: `long pointer in lR44`; +A8 halves `engine/unsorted/bank96.asm:4808`: `long pointer in lR44`; and 6 more |
| $D6/7F1B-$96/8007 | 237 | 8 (+E5-+EC) | `gcUnknownD67D7D` / `rlUnknown968008` | +E5 halves `engine/unsorted/bank80.asm:6382`: `long pointer in lR44`; 97% $00/$FF |
| $96/800D-$96/8016 | 10 | 10 (+0-+9) | `rlUnknown968008` / `rlUnknown968017` | +2 halves `engine/unsorted/bank80.asm:6387`: `long pointer in lR44` |
| $96/804E-$96/8057 | 10 | 10 (+0-+9) | `rlUnknown968017` / `rlUnknown968058` | +2 halves `engine/unsorted/bank80.asm:6392`: `long pointer in lR44` |
| $96/8076-$96/807F | 10 | 10 (+0-+9) | `rlUnknown968058` / `rlUnknown968080` | +2 halves `engine/unsorted/bank80.asm:6397`: `long pointer in lR44` |
| $96/8093-$96/809C | 10 | 10 (+0-+9) | `rlUnknown968080` / `rlUnknown96809D` | +2 halves `engine/unsorted/bank80.asm:6377`: `long pointer in lR44` |
| $96/80A2-$96/80AB | 10 | 10 (+0-+9) | `rlUnknown96809D` / `rlUnknown9680AC` | +2 halves `engine/unsorted/bank80.asm:6463`: `long pointer in lR44` |
| $96/80B1-$96/80BA | 10 | 10 (+0-+9) | `rlUnknown9680AC` / `rlUnknown9680BB` | +2 halves `engine/unsorted/bank80.asm:6468`: `long pointer in lR44` |
| $97/8F39-$97/BDD3 | 11,931 | 764 (+1-+2E43) | `aBattleAnimationLookup` / `aUnknown97BDD4` | +1ED1 halves `engine/unsorted/bank95.asm:18536`: `long pointer in lR18`; +188E halves `engine/unsorted/bank95.asm:18630`: `long pointer in lR18`; +1FE8 halves `engine/unsorted/bank96.asm:17200`: `long pointer in lR18`; +1 named `include/Undisassembled.h:48`: `aUnknown978F3A, read by rlUnknown95B993` |
| $99/8DD8-$99/8F01 | 298 | 184 (+20-+129) | `aBattleBannerTable` / `aUnknown998F02` | +20 named `include/Undisassembled.h:60`: `aUnknown998DF8, read by rlUnknown95A167` |
| $99/F6C1-$99/FFE6 | 2,342 | 1022 (+3CC-+925) | `aBattleAnimationSequencesJuniorLordSword` / `aUnknown99FFE7` | +757 halves `engine/unsorted/bank95.asm:18480`: `long pointer in lR18`; +75F halves `engine/unsorted/bank95.asm:18501`: `long pointer in lR18`; +764 halves `engine/unsorted/bank95.asm:18508`: `long pointer in lR18`; +769 halves `engine/unsorted/bank95.asm:18515`: `long pointer in lR18`; and 2 more |
| $DA/7E00-$9A/BA29 | 15,402 | 3010 (+B08-+2FED) | `g4bppUnknownDA7A00` / `aBattleAnimationFramesKnightLordSword` | +250A number `engine/unsorted/bank9F.asm:3611`: `lda $9AA30A,x`; +250A number `engine/unsorted/bank9F.asm:3616`: `lda $9AA30A,x`; +250A named `include/Undisassembled.h:61`: `aUnknown9AA30A, read by rlUnknown96B517, rsUnknown96B56F, rs` |
| $DE/1600-$DE/2CBF | 5,824 | 3136 (+0-+16BF) | `gUnknownDE1600` / `g4bppDialogueBoxFrames` | +14BE named `include/Undisassembled.h:65`: `aUnknownDE2ABE, read by rlUnknown80BD27`; +169E named `include/Undisassembled.h:66`: `aUnknownDE2C9E, read by rsUnknown898105, rsUnknown89831F, rs` |
| $9E/D900-$9E/DAE6 | 487 | 0 | `rlUnknown9ED8B6` / `rlUnknown9EDAE7` | +1E0 halves `engine/unsorted/bank9E.asm:11606`: `long pointer in lR44` |
| $9E/DE89-$9E/DF7E | 246 | 0 | `rlUnknown9EDE60` / `rlUnknown9EDF7F` | +EF halves `engine/unsorted/bank9E.asm:12121`: `long pointer in lR44` |
| $E0/205C-$E0/2666 | 1,547 | 448 (+23D-+60A) | `aBattleAnimationPaletteDarkPrince` / `aUnknownE02667` | +23D named `include/Undisassembled.h:67`: `aUnknownE02299, read by rlUnknown9BE1C0`; +355 named `include/Undisassembled.h:68`: `aUnknownE023B1, read by rlUnknown9BE1C0`; +487 named `include/Undisassembled.h:69`: `aUnknownE024E3, read by rlUnknown9BF3F3` |
| $AD/FF29-$AD/FFFF | 215 | 128 (+57-+D6) | `aMapBattleCavalierLayout6` / `` | +57 number `engine/unsorted/bank9E.asm:4187`: `lda #(`$ADFF80)<<8`; +57 number `engine/unsorted/bank9E.asm:4189`: `lda #<>$ADFF80`; 70% $00/$FF |
| $AF/C293-$AF/C7FF | 1,389 | 0 | `dialogueChapter06HerminaSeliphTalk` / `aBattleBackgroundVillagePalette` | +16D halves `engine/unsorted/bank9E.asm:12040`: `long pointer in lR18`; 75% $00/$FF |

## `log` (116)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|
| $C0/0000-$C0/0A2A | 2,603 | 2 (+0-+1) | `wR0` / `gcUnknownC00A2B` |  |
| $80/95A1-$80/95CC | 44 | 22 (+0-+26) | `rsUnknown809583` / `rlUnknown8095CD` | 63% $00/$FF |
| $80/C8D3-$80/C8D4 | 2 | 2 (+0-+1) | `rlUnitWindowBG2VOFSHDMACycle` / `rsUnitWindowGetUnits` |  |
| $80/D0B2-$80/D0B3 | 2 | 2 (+0-+1) | `rlMapMenuWindowCOLDATAHDMACycle` / `rsItemWindowBuildItemList` |  |
| $80/E97A-$80/E97B | 2 | 2 (+0-+1) | `rlUnknown80E979` / `rlUnknown80E97C` |  |
| $80/E9B0-$80/E9B1 | 2 | 2 (+0-+1) | `rlUnknown80E9AF` / `rlUnknown80E9B2` |  |
| $80/F390-$80/F391 | 2 | 2 (+0-+1) | `rlUnknown80F38F` / `rsUnknown80F392` |  |
| $80/F628-$80/FFFF | 2,520 | 165 (+8F2-+9D5) | `rsUnknown80F5D0` / `g4bppcMageFemaleMapMovementSprite` | 97% $00/$FF |
| $81/B54A-$81/BFFF | 2,742 | 2 (+0-+1) | `rlUnknown81B52A` / `UNITGroupPrologueStartUNITGroupPointersEntry` | 99% $00/$FF |
| $85/8000-$85/827F | 640 | 640 (+0-+27F) | `aDialogueBoxTilemap` / `rlLoadMapMenuDataFromProc` |  |
| $85/839A-$85/83C1 | 40 | 24 (+0-+17) | `aProcDialogueBoxCode` / `rlUnknown8583C2` |  |
| $85/9158-$85/9159 | 2 | 2 (+0-+1) | `rlUnknown859108` / `rsUnknown85915A` |  |
| $85/926C-$85/9280 | 21 | 21 (+0-+14) | `rlUnknown85921D` / `procUnknown859281` |  |
| $85/9289-$85/928C | 4 | 4 (+0-+3) | `procUnknown859281` / `rlUnknown85928D` |  |
| $85/9831-$85/988D | 93 | 48 (+0-+5C) | `rsUnknown8597CD` / `procUnknown85988E` |  |
| $85/9896-$85/9899 | 4 | 4 (+0-+3) | `procUnknown85988E` / `rlUnknown85989A` |  |
| $85/9B21-$85/9B27 | 7 | 7 (+0-+6) | `rsUnknown859AFD` / `aProcUnknown85988ECode` |  |
| $85/9DCB-$85/9DCC | 2 | 2 (+0-+1) | `rlUnknown859DCA` / `rsUnknown859DCD` |  |
| $85/9E07-$85/9E07 | 1 | 1 (+0-+0) | `rsUnknown859DCD` / `rsUnknown859E08` |  |
| $85/9EE7-$85/9F96 | 176 | 60 (+0-+A3) | `rsUnknown859ECB` / `rsUnknown859F97` |  |
| $85/A241-$85/A313 | 211 | 21 (+BE-+D2) | `rlUnknown85A234` / `procUnknown85A314` |  |
| $85/A31C-$85/A31F | 4 | 4 (+0-+3) | `procUnknown85A314` / `rlUnknown85A320` |  |
| $85/A46A-$85/A47E | 21 | 21 (+0-+14) | `rlUnknown85A3F8` / `procUnknown85A47F` |  |
| $85/A487-$85/A48A | 4 | 4 (+0-+3) | `procUnknown85A47F` / `rlProcUnknown85A47FInit` |  |
| $85/A5DA-$85/A5EE | 21 | 21 (+0-+14) | `rlUnknown85A5C5` / `procUnknown85A5EF` |  |
| $85/A5F7-$85/A5FA | 4 | 4 (+0-+3) | `procUnknown85A5EF` / `rlUnknown85A5FB` |  |
| $85/A76D-$85/A781 | 21 | 21 (+0-+14) | `aProcUnknown85A5EFCode` / `procUnknown85A782` |  |
| $85/A78A-$85/A78D | 4 | 4 (+0-+3) | `procUnknown85A782` / `rlUnknown85A78E` |  |
| $85/AB94-$85/AB95 | 2 | 2 (+0-+1) | `rlUnknown85AB8E` / `rsUnknown85AB96` |  |
| $85/ABED-$85/ABF0 | 4 | 4 (+0-+3) | `rsUnknown85AB96` / `rlUnknown85ABF1` |  |
| $85/AFC3-$85/AFC4 | 2 | 2 (+0-+1) | `rsUnknown85AF78` / `rsUnknown85AFC5` |  |
| $85/B8F7-$85/B8F9 | 3 | 3 (+0-+2) | `aUnknown85B8EE` / `procUnknown85B8FA` |  |
| $85/B902-$85/B905 | 4 | 4 (+0-+3) | `procUnknown85B8FA` / `rlProcUnknown85B8FAInit` |  |
| $85/BB3D-$85/BB51 | 21 | 21 (+0-+14) | `rlUnknown85BB2E` / `procUnknown85BB52` |  |
| $85/BB5A-$85/BB5D | 4 | 4 (+0-+3) | `procUnknown85BB52` / `rlProcUnknown85BB52Init` |  |
| $85/BD10-$85/BD11 | 2 | 2 (+0-+1) | `rlUnknown85BCD4` / `rlUnknown85BD12` |  |
| $85/C3C5-$85/C41E | 90 | 90 (+0-+59) | `rsUnknown85C3A9` / `rsUnknown85C41F` |  |
| $85/C6C6-$85/C6D1 | 12 | 12 (+0-+B) | `rlUnknown85C6B0` / `rsUnknown85C6D2` |  |
| $85/C7BF-$85/C818 | 90 | 90 (+0-+59) | `rsUnknown85C7AE` / `rsUnknown85C819` |  |
| $85/CA0B-$85/CA4A | 64 | 12 (+C-+37) | `rsUnknown85C9BF` / `rlUnknown85CA4B` |  |
| $85/CA70-$85/CA84 | 21 | 21 (+0-+14) | `rlUnknown85CA4B` / `procUnknown85CA85` |  |
| $85/CA8D-$85/CA90 | 4 | 4 (+0-+3) | `procUnknown85CA85` / `rlProcUnknown85CA85Init` |  |
| $85/CCF7-$85/CD0B | 21 | 21 (+0-+14) | `rsUnknown85CCC9` / `procUnknown85CD0C` |  |
| $85/CD14-$85/CD2C | 25 | 25 (+0-+18) | `procUnknown85CD0C` / `procUnknown85CD2D` |  |
| $85/CD35-$85/CD38 | 4 | 4 (+0-+3) | `procUnknown85CD2D` / `rlUnknown85CD39` |  |
| $85/D895-$85/D8A9 | 21 | 21 (+0-+14) | `rlUnknown85D82A` / `procUnknown85D8AA` |  |
| $85/D8B2-$85/D8B5 | 4 | 4 (+0-+3) | `procUnknown85D8AA` / `rlProcUnknown85D8AAInit` |  |
| $85/DCE2-$85/DDDA | 249 | 231 (+0-+F8) | `rlUnknown85DCCA` / `procUnknown85DDDB` |  |
| $85/DDE3-$85/DDF8 | 22 | 12 (+0-+15) | `procUnknown85DDDB` / `rlProcUnknown85DDDBInit` |  |
| $85/E070-$85/E1CB | 348 | 215 (+0-+15B) | `rlUnknown85E050` / `procUnknown85E1CC` |  |
| $85/E1D4-$85/E1DA | 7 | 6 (+0-+6) | `procUnknown85E1CC` / `rlProcUnknown85E1CCInit` |  |
| $85/E2AF-$85/E2DE | 48 | 30 (+0-+2F) | `aUnknown85E27F` / `rsUnknown85E2DF` |  |
| $88/83C4-$88/83C6 | 3 | 1 (+1-+1) | `rlUnknown88821A` / `rlUnknown8883C7` | 66% $00/$FF |
| $88/CC49-$88/CC74 | 44 | 44 (+0-+2B) | `aUnknown88CBE8` / `rlUnknown88CC75` |  |
| $89/8A29-$89/8A40 | 24 | 17 (+7-+17) | `rsUnknown8989EA` / `rsUnknown898A41` |  |
| $89/8AC1-$89/8AF4 | 52 | 52 (+0-+33) | `rsUnknown898A7E` / `rsUnknown898AF5` |  |
| $89/8ED8-$89/8F15 | 62 | 62 (+0-+3D) | `rsUnknown898EB4` / `rsUnknown898F16` |  |
| $89/9509-$89/950F | 7 | 7 (+0-+6) | `rsUnknown8994B8` / `rlUnknown899510` |  |
| $89/9FD5-$89/9FDB | 7 | 6 (+0-+5) | `rlUnknown899FA1` / `rlUnknown899FDC` |  |
| $89/BE49-$89/BE56 | 14 | 14 (+0-+D) | `rsItemWindowRenderSelectedItemSprites` / `aUnknown89BE57` |  |
| $89/F74B-$89/F7A5 | 91 | 42 (+2A-+53) | `rlUnknown89F713` / `rlUnknown89F7A6` |  |
| $8A/9586-$8A/974F | 458 | 434 (+0-+1C9) | `rsUnknown8A956F` / `rlUnknown8A9750` |  |
| $8A/9CA8-$8A/9D21 | 122 | 35 (+0-+76) | `rlUnknown8A9C61` / `rsUnknown8A9D22` |  |
| $8A/AA2A-$8A/AA39 | 16 | 16 (+0-+F) | `rsUnknown8AA9CE` / `rsUnknown8AAA3A` |  |
| $8A/B261-$8A/B316 | 182 | 2 (+0-+1) | `rlUnknown8AB23B` / `rlDecompressDialoguePortrait` |  |
| $8A/DB30-$8A/DB36 | 7 | 7 (+0-+6) | `rsUnknown8ADB04` / `rsUnknown8ADB37` |  |
| $8A/E23D-$8A/E242 | 6 | 6 (+0-+5) | `rlProcUnknown8AE1EBCycle` / `aProcUnknown8AE1EBCode` |  |
| $8A/EE7F-$8A/EE88 | 10 | 1 (+1-+1) | `rlUnknown8AECEF` / `aDecompressionDMAEntry8AEE89` | 60% $00/$FF |
| $8B/9456-$8B/9457 | 2 | 2 (+0-+1) | `rlUnknown8B9451` / `rlUnknown8B9458` |  |
| $8B/95A1-$8B/95A2 | 2 | 2 (+0-+1) | `rlUnknown8B959C` / `rlUnknown8B95A3` |  |
| $8B/A0B5-$8B/A7CA | 1,814 | 453 (+551-+715) | `rlUnknown8BA0B4` / `rlUnknown8BA7CB` | 84% $00/$FF |
| $8B/DAF4-$8B/DB53 | 96 | 92 (+0-+5E) | `rsSkillWindowRenderBG2Sprites` / `rsSkillWindowRenderSkillIcon` |  |
| $8B/DB77-$8B/DB7D | 7 | 7 (+0-+6) | `rsSkillWindowRenderSkillIcon` / `aUnknown8BDB7E` |  |
| $8B/DFA9-$8B/DFBE | 22 | 22 (+0-+15) | `rsSkillWindowCopyVisibleHolders` / `aUnknown8BDFBF` |  |
| $8B/E01E-$8B/E03B | 30 | 30 (+0-+1D) | `aBattleAnimationPaletteBarbarian` / `g4bppcBattleAnimationSheetBarbarian` |  |
| $8D/D042-$8D/DCA6 | 3,173 | 453 (+8DB-+A9F) | `rlUnknown8DD041` / `dialogueChapterEpilogueWorldMapSilesse` | 68% $00/$FF |
| $92/8000-$92/FFFF | 32,768 | 19776 (+0-+7FFF) | `g2bppDialogueFont` / `` |  |
| $93/8000-$93/FFFF | 32,768 | 12096 (+20-+7FBF) | `gcUnknownD35EB4` / `` |  |
| $D4/6B27-$94/BFFF | 21,721 | 2432 (+14D9-+45F8) | `aUnifiedThraciaMapHighlightTilemap` / `aBattleBackgroundRoadPalette` | 61% $00/$FF |
| $96/80C0-$96/80C1 | 2 | 2 (+0-+1) | `rlUnknown9680BB` / `rlUnknown9680C2` |  |
| $96/FD6F-$D7/5FFF | 25,233 | 3264 (+411-+5E50) | `rlUnknown96FD54` / `g2bppItemStatLabels` |  |
| $98/8000-$98/A8FF | 10,496 | 4910 (+0-+2008) | `g4bppItemIcons` / `aBattleBackgrounds` |  |
| $99/88E2-$99/8929 | 72 | 72 (+0-+47) | `aBattleWeaponGraphics` / `aUnknown99892A` |  |
| $DA/0000-$DA/64FF | 25,856 | 4032 (+240-+18BF) | `aUnknown99FFE7` / `aUnknownDA6500` |  |
| $9A/FEAA-$DB/7FFF | 33,110 | 32768 (+156-+8155) | `aBattleAnimationSequencesDarkPrinceMagic` / `aBattleAnimationFramesPegasusKnightSword` |  |
| $9B/C16F-$9B/DC23 | 6,837 | 182 (+134D-+1893) | `aBattleAnimationSequencesDancerDance` / `rlUnknown9BDC24` |  |
| $9B/FE13-$DC/7FFF | 33,261 | 32768 (+1ED-+81EC) | `rlUnknown9BFE06` / `gcUnknown9C8000` |  |
| $9C/ECA6-$9C/FFFF | 4,954 | 1152 (+65A-+1079) | `acDialogueBackgroundCloisterForegroundTilemap` / `gcUnknownDD0000` | 65% $00/$FF |
| $DD/6655-$DD/72AF | 3,163 | 2944 (+DB-+C5A) | `gcUnknownDD629E` / `g4bppWindowFrames` |  |
| $DE/60C0-$DE/61FF | 320 | 320 (+0-+13F) | `gUnknownDE60C0` / `aUnknownDE6200` |  |
| $9E/CE9E-$9E/CE9F | 2 | 2 (+0-+1) | `aProcUnknown9EC70BCode` / `rlUnknown9ECEA0` |  |
| $9E/FD02-$DF/3191 | 13,456 | 3535 (+35D-+348F) | `rlUnknown9EFC9B` / `g4bppcBattleBackgroundThicket` |  |
| $9F/8085-$9F/80D8 | 84 | 6 (+0-+39) | `rlProcUnknown9F805DCycle` / `aMapBattleMagicBackgrounds` |  |
| $9F/83E9-$9F/83F0 | 8 | 8 (+0-+7) | `rsUnknown9F83D0` / `rsUnknown9F83F1` |  |
| $9F/8B3A-$9F/8B79 | 64 | 8 (+0-+35) | `rsUnknown9F8B24` / `rlUnknown9F8B7A` | 57% $00/$FF |
| $9F/92AC-$9F/92D1 | 38 | 8 (+16-+1D) | `rlUnknown9F9296` / `rlUnknown9F92D2` |  |
| $9F/9527-$9F/956F | 73 | 56 (+0-+37) | `rlUnknown9F94FE` / `rlUnknown9F9570` |  |
| $9F/9601-$9F/9690 | 144 | 23 (+0-+16) | `rlUnknown9F95F1` / `rlUnknown9F9691` |  |
| $9F/96D5-$9F/9953 | 639 | 226 (+0-+E1) | `rlUnknown9F9691` / `rlUnknown9F9954` |  |
| $9F/99BB-$9F/99CD | 19 | 19 (+0-+12) | `rsUnknown9F999E` / `rlUnknown9F99CE` |  |
| $9F/9B08-$9F/BD6A | 8,803 | 62 (+2-+3F) | `rlUnknown9F9ABF` / `rlUnknown9FBD6B` |  |
| $9F/DB6A-$9F/DB8A | 33 | 33 (+0-+20) | `rlUnknown9FDB69` / `rlUnknown9FDB8B` |  |
| $9F/DBA1-$9F/DBC3 | 35 | 35 (+0-+22) | `rlUnknown9FDB8B` / `rlUnknown9FDBC4` |  |
| $9F/DBDA-$9F/DBFC | 35 | 35 (+0-+22) | `rlUnknown9FDBC4` / `rlUnknown9FDBFD` |  |
| $9F/DC13-$9F/DC3F | 45 | 19 (+1A-+2C) | `rlUnknown9FDBFD` / `rlUnknown9FDC40` |  |
| $9F/DC56-$9F/DC82 | 45 | 38 (+0-+2C) | `rlUnknown9FDC40` / `rlUnknown9FDC83` |  |
| $9F/DCD3-$9F/DEE2 | 528 | 43 (+0-+18A) | `rlUnknown9FDC83` / `rlUnknown9FDEE3` |  |
| $9F/DF58-$9F/E005 | 174 | 28 (+0-+1B) | `rlUnknown9FDEE3` / `rlUnknown9FE006` |  |
| $9F/EBAB-$9F/ECB1 | 263 | 27 (+0-+3B) | `aProcUnknown9F805DCode` / `rlUnknown9FECB2` |  |
| $E0/1C8C-$E0/1CA9 | 30 | 30 (+0-+1D) | `aBattleAnimationPaletteFighter` / `aBattleAnimationPaletteBrigand` |  |
| $E0/1CC8-$E0/1CE5 | 30 | 30 (+0-+1D) | `aBattleAnimationPaletteBrigand` / `aBattleAnimationPalettePirate` |  |
| $E0/2EBD-$E0/421F | 4,963 | 4417 (+0-+1215) | `aBattleAnimationPaletteFinn` / `g4bppcBattleAnimationSheetJuniorLord` |  |
| $F3/365D-$F3/7FFF | 18,851 | 15766 (+C0D-+49A2) | `gcUnknownF30E6F` / `dialogueChapter09Opening1` |  |
| $F4/0000-$F4/7FFF | 32,768 | 10346 (+0-+7E54) | `aEpilogueLoverPointersJeanneNanna` / `aBattleBackgroundPlainsPalette` |  |
| $F5/0000-$F5/7FFF | 32,768 | 22571 (+24B7-+7FFF) | `g4bppcBattleBackgroundMountain` / `` |  |
| $F6/0000-$F6/23D2 | 9,171 | 7092 (+0-+1BB3) | `g4bppcBattleBackgroundRiver` / `g4bppcDialogueBackgroundFountainForeground` |  |

## `none` (338)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|
| $C0/3C05-$80/8001 | 17,405 | 0 | `gcUnknownC0365A` / `rlGetJoypadInput` | 99% $00/$FF |
| $80/8372-$80/83C6 | 85 | 0 | `rlClearSpriteExtBuffer` / `aOAMUpperXBitTable` |  |
| $80/9727-$80/9728 | 2 | 0 | `aUnknown809703` / `rsUnknown809729` |  |
| $80/9C3E-$80/9C79 | 60 | 0 | `rlUnknown809C3B` / `rlUnknown809C7A` |  |
| $80/9FB2-$80/A095 | 228 | 0 | `rlSetLayerPositionsAndSizes` / `rlUnsignedMultiply16By16High` |  |
| $80/A678-$80/A6C2 | 75 | 0 | `rlAppendDecompList` / `rlButtonCombinationResetCheck` |  |
| $80/ADFF-$80/AE24 | 38 | 0 | `rsUnknown80AD24` / `rsUnknown80AE25` |  |
| $80/B316-$80/B346 | 49 | 0 | `rsUnknown80B301` / `rsUnknown80B347` |  |
| $80/B63E-$80/B63E | 1 | 0 | `aDecompressionDMAEntry80B636` / `rlUnknown80B63F` |  |
| $80/B640-$80/B640 | 1 | 0 | `rlUnknown80B63F` / `rsUnknown80B641` |  |
| $80/B77D-$80/B77E | 2 | 0 | `rlUnknown80B74B` / `rlUnknown80B77F` |  |
| $80/C1BA-$80/C1C9 | 16 | 0 | `rlUnknown80C1A0` / `rlUnknown80C1CA` |  |
| $80/F337-$80/F33F | 9 | 0 | `rsUnknown80F2BE` / `rsUnknown80F340` |  |
| $81/9062-$81/9091 | 48 | 0 | `rsCapSpawnDestinationCoordinates100` / `rsFillMovingMapSpriteData` |  |
| $81/90CC-$81/9165 | 154 | 0 | `rsFillMovingMapSpriteDataPathScriptPointer` / `rlUnknown819166` |  |
| $81/EBBC-$81/FFFF | 5,188 | 0 | `aUNITGroupDataChapterFinalUnused` / `` | 92% $00/$FF |
| $82/83B5-$82/83E2 | 46 | 0 | `aProcMainLoopChangeFadeByTimerCode` / `procUnknown8283E3` |  |
| $82/8816-$82/8864 | 79 | 0 | `aProcCastleNamePopUpCode` / `procUnknown828865` |  |
| $82/8D21-$82/8D51 | 49 | 0 | `aProcUnknown828CA3Code` / `procUnknown828D52` |  |
| $82/90B0-$82/921D | 366 | 0 | `aProcEventFadeOutByTimerCode` / `procEventPause` |  |
| $82/9285-$82/92A8 | 36 | 0 | `aProcUnknown82925ECode` / `procUnknown8292A9` |  |
| $82/9469-$82/9477 | 15 | 0 | `aProcUnknown8293AECode` / `rlCreateProcHaltEvent` |  |
| $82/94B1-$82/94BF | 15 | 0 | `rlUnknown829496` / `rlUnknown8294C0` |  |
| $82/E030-$82/E072 | 67 | 0 | `rsUnknown82E028` / `rlResetIRQEngine` |  |
| $82/E120-$82/E132 | 19 | 0 | `rlUnknown82E0C6` / `rlUnknown82E133` |  |
| $82/E134-$82/E146 | 19 | 0 | `rlUnknown82E133` / `rlUnknown82E147` |  |
| $82/E41A-$82/E41A | 1 | 0 | `rlUnknown82E400` / `rlBuildRAMStructHeader` |  |
| $82/EB4C-$82/ECB8 | 365 | 0 | `rsUnknown82EB15` / `rlBuildRAMAreaHeaderAndGuidingEntry` |  |
| $82/EDBB-$82/EDE6 | 44 | 0 | `rlUnknown82ED24` / `rlAllocateRAMArea` |  |
| $82/F207-$82/F210 | 10 | 0 | `rsUnknown82F1EA` / `rlUnknown82F211` |  |
| $82/F4BF-$82/F4DD | 31 | 0 | `rlUnknown82F4A7` / `rlGetUNITGroupPointer` |  |
| $82/F4F9-$82/F516 | 30 | 0 | `rlGetUNITGroupPointer` / `rlUnknown82F517` |  |
| $82/F54F-$82/F566 | 24 | 0 | `rlUnknown82F517` / `rlAddOffsetTableEntry` |  |
| $82/F7A2-$82/F865 | 196 | 0 | `rlUpdateOffsetTable` / `rlSetParentsPermanentFlags` |  |
| $83/B602-$83/B602 | 1 | 0 | `aCharacterData` / `` |  |
| $83/B6A6-$83/B6A6 | 1 | 0 | `aCharacterData` / `` |  |
| $83/B8A0-$83/B8A0 | 1 | 0 | `aCharacterData` / `` |  |
| $83/B95E-$83/B95E | 1 | 0 | `aCharacterData` / `` |  |
| $83/B96A-$83/B96A | 1 | 0 | `aCharacterData` / `` |  |
| $83/B982-$83/B982 | 1 | 0 | `aCharacterData` / `` |  |
| $83/B98E-$83/B98E | 1 | 0 | `aCharacterData` / `` |  |
| $83/B99A-$83/B99A | 1 | 0 | `aCharacterData` / `` |  |
| $83/B9A6-$83/B9A6 | 1 | 0 | `aCharacterData` / `` |  |
| $83/B9B2-$83/B9B2 | 1 | 0 | `aCharacterData` / `` |  |
| $83/B9BE-$83/B9BE | 1 | 0 | `aCharacterData` / `` |  |
| $83/C5AA-$83/C5AA | 1 | 0 | `aCharacterData` / `` |  |
| $83/C65F-$83/C65F | 1 | 0 | `aCharacterData` / `` |  |
| $83/C69F-$83/C69F | 1 | 0 | `aCharacterData` / `` |  |
| $83/CACD-$83/CACD | 1 | 0 | `aCharacterData` / `` |  |
| $83/CB27-$83/CB27 | 1 | 0 | `aCharacterData` / `` |  |
| $83/CBB5-$83/CBB5 | 1 | 0 | `aCharacterData` / `` |  |
| $83/CC9D-$83/CC9D | 1 | 0 | `aCharacterData` / `` |  |
| $83/CD93-$83/CD93 | 1 | 0 | `aCharacterData` / `` |  |
| $83/CDB9-$83/CDB9 | 1 | 0 | `aCharacterData` / `` |  |
| $83/EBA1-$83/EBA1 | 1 | 0 | `aItemData` / `` |  |
| $83/EBC7-$83/EBC7 | 1 | 0 | `aItemData` / `` |  |
| $83/EBDA-$83/EBDA | 1 | 0 | `aItemData` / `` |  |
| $83/EC13-$83/EC13 | 1 | 0 | `aItemData` / `` |  |
| $83/EC26-$83/EC26 | 1 | 0 | `aItemData` / `` |  |
| $83/EC39-$83/EC39 | 1 | 0 | `aItemData` / `` |  |
| $83/EC4C-$83/EC4C | 1 | 0 | `aItemData` / `` |  |
| $83/EC5F-$83/EC5F | 1 | 0 | `aItemData` / `` |  |
| $83/F0E6-$83/F0E6 | 1 | 0 | `aItemData` / `` |  |
| $83/F24F-$83/F24F | 1 | 0 | `aItemData` / `` |  |
| $83/F262-$83/F262 | 1 | 0 | `aItemData` / `` |  |
| $83/F275-$83/F275 | 1 | 0 | `aItemData` / `` |  |
| $85/82CB-$85/82D3 | 9 | 0 | `rlMapMenuCloseAndRestoreMapState` / `rlUnknown8582D4` |  |
| $85/8335-$85/8340 | 12 | 0 | `rlUnknown8582D4` / `rlStallProcUntilMapMenuDataLoaded` |  |
| $85/837C-$85/8397 | 28 | 0 | `rlProcCycleMapMenuWaitForPaletteGraphicFinish` / `aProcDialogueBoxCode` |  |
| $85/84CF-$85/84DB | 13 | 0 | `rlUnknown8584AC` / `rlUnknown8584DC` |  |
| $85/85B3-$85/860D | 91 | 0 | `rlUnknown85856E` / `rsUnknown85860E` |  |
| $85/8820-$85/8849 | 42 | 0 | `rlUnknown8587F2` / `rlUnknown85884A` |  |
| $85/9FE5-$85/9FE9 | 5 | 0 | `rlUnknown859FCD` / `rlUnknown859FEA` |  |
| $85/A03F-$85/A03F | 1 | 0 | `rlUnknown85A03D` / `rsUnknown85A040` |  |
| $85/A0F6-$85/A116 | 33 | 0 | `rsUnknown85A0F5` / `rlUnknown85A117` |  |
| $85/B069-$85/B07B | 19 | 0 | `rsUnknown85B039` / `rsUnknown85B07C` |  |
| $85/B197-$85/B1AF | 25 | 0 | `procUnknown85B18F` / `rlProcUnknown85B18FInit` |  |
| $85/B26B-$85/B281 | 23 | 0 | `rlUnknown85B207` / `rlUnknown85B282` |  |
| $85/B2CA-$85/B2D7 | 14 | 0 | `rlUnknown85B282` / `aProcUnknown85B18FCode` |  |
| $85/B4FA-$85/B51F | 38 | 0 | `rsUnknown85B4ED` / `rlUnknown85B520` |  |
| $85/B643-$85/B65B | 25 | 0 | `procUnknown85B63B` / `rlProcUnknown85B63BInit` |  |
| $85/C305-$85/C30C | 8 | 0 | `rsUnknown85C2FB` / `rlUnknown85C30D` |  |
| $85/CD72-$85/CD80 | 15 | 0 | `rlUnknown85CD39` / `rsUnknown85CD81` |  |
| $85/D337-$85/D384 | 78 | 0 | `rlUnknown85D32D` / `rlUnknown85D385` |  |
| $85/D3BD-$85/D3F4 | 56 | 0 | `rlUnknown85D385` / `rlUnknown85D3F5` |  |
| $85/D438-$85/D441 | 10 | 0 | `rlUnknown85D41E` / `rlUnknown85D442` |  |
| $85/D604-$85/D605 | 2 | 0 | `rlUnknown85D5CC` / `aUnknown85D606` |  |
| $85/DAF2-$85/DAF5 | 4 | 0 | `procUnknown85DAEA` / `rlProcUnknown85DAEAInit` |  |
| $85/DBAB-$85/DBDC | 50 | 0 | `rlUnknown85DB91` / `rlMapMenuOpenUnitWindow` |  |
| $85/DEFB-$85/DF1F | 37 | 0 | `rlUnknown85DED6` / `rlUnknown85DF20` |  |
| $85/DFDE-$85/DFFC | 31 | 0 | `rlUnknown85DFC2` / `rlUnknown85DFFD` |  |
| $85/E910-$85/E950 | 65 | 0 | `rlUnknown85E8FB` / `procUnknown85E951` |  |
| $85/E959-$85/E95F | 7 | 0 | `procUnknown85E951` / `rlUnknown85E960` |  |
| $85/E96B-$85/E9C6 | 92 | 0 | `rlUnknown85E960` / `procUnknown85E9C7` |  |
| $85/E9CF-$85/E9D5 | 7 | 0 | `procUnknown85E9C7` / `rlUnknown85E9D6` |  |
| $85/EA3E-$85/EA41 | 4 | 0 | `aUnknown85EA3A` / `rlUnknown85EA42` |  |
| $87/84CC-$87/84E0 | 21 | 0 | `rlUnknown8784B7` / `rlUnknown8784E1` |  |
| $87/8833-$87/8851 | 31 | 0 | `rlReplaceMapMenuTilemapROMWithRAMPointer` / `rlUnknown878852` |  |
| $87/890B-$87/8915 | 11 | 0 | `rlUnknown878900` / `rlUnknown878916` |  |
| $87/C6DC-$87/C709 | 46 | 0 | `rsUnknown87C6AA` / `procUnknown87C70A` |  |
| $87/C7CF-$87/C7F2 | 36 | 0 | `rlUnknown87C7B4` / `rlUnknown87C7F3` |  |
| $87/E6D5-$87/E6D6 | 2 | 0 | `rsUnknown87E6D3` / `rsUnknown87E6D7` |  |
| $87/E761-$87/E761 | 1 | 0 | `rsUnknown87E75F` / `rlUnknown87E762` |  |
| $88/857E-$88/85D2 | 85 | 0 | `rlUnknown888560` / `rlUnknown8885D3` |  |
| $88/9AC4-$88/9AE1 | 30 | 0 | `rlUnknown889A85` / `aUnknown889AE2` |  |
| $88/9C38-$88/9C51 | 26 | 0 | `rlUnknown889BF7` / `procUnknown889C52` |  |
| $88/9E6E-$88/9FC2 | 341 | 0 | `aProcUnknown889C52Code` / `aChapterMapPointers` |  |
| $88/A383-$88/A38B | 9 | 0 | `rsUnknown88A32D` / `rlUnknown88A38C` |  |
| $88/A505-$88/A550 | 76 | 0 | `rlUnknown88A4FC` / `rsUnknown88A551` |  |
| $88/A6CA-$88/A703 | 58 | 0 | `rsUnknown88A698` / `rlUnknown88A704` |  |
| $88/A816-$88/A81C | 7 | 0 | `rsUnknown88A7F5` / `rlUnknown88A81D` |  |
| $88/ACBB-$88/ACF0 | 54 | 0 | `rsUnknown88ACA6` / `aUnknown88ACF1` | 64% $00/$FF |
| $88/AD09-$88/AD45 | 61 | 0 | `aUnknown88ACF1` / `rlUnknown88AD46` |  |
| $88/B3C2-$88/B3DE | 29 | 0 | `rlUnknown88B3AF` / `rlUnknown88B3DF` |  |
| $88/BEFF-$88/BF36 | 56 | 0 | `rsUnknown88BEEF` / `rlUnknown88BF37` |  |
| $88/E00E-$88/E02A | 29 | 0 | `rsUnknown88DFDA` / `procUnknown88E02B` |  |
| $88/E0F5-$88/E10A | 22 | 0 | `rlUnknown88E0DF` / `rlUnknown88E10B` |  |
| $88/E154-$88/E178 | 37 | 0 | `rlUnknown88E10B` / `rlUnknown88E179` |  |
| $88/E2D6-$88/E2DB | 6 | 0 | `rlProcUnknown88E26ACycle` / `aProcUnknown88E26ACode` | 66% $00/$FF |
| $88/E33B-$88/E33C | 2 | 0 | `rlUnknown88E2E9` / `rlUnknown88E33D` |  |
| $88/EED9-$88/EF0C | 52 | 0 | `rlUnknown88EEB1` / `aUnknown88EF0D` |  |
| $89/8A61-$89/8A7D | 29 | 0 | `rsUnknown898A41` / `rsUnknown898A7E` |  |
| $89/8E65-$89/8E6B | 7 | 0 | `rsUnknown898D5F` / `aUnknown898E6C` |  |
| $89/90D9-$89/90D9 | 1 | 0 | `rlUnknown8990BD` / `rlUnknown8990DA` |  |
| $89/91D3-$89/91FF | 45 | 0 | `rlUnknown8991D2` / `rlUnknown899200` |  |
| $89/B133-$89/B20A | 216 | 0 | `rsUnknown89B10C` / `rsUnknown89B20B` |  |
| $8A/8682-$8A/8699 | 24 | 0 | `rsUnknown8A8643` / `rsUnknown8A869A` | 54% $00/$FF |
| $8A/B10A-$8A/B110 | 7 | 0 | `rlUnknown8AB093` / `rlUnknown8AB111` |  |
| $8A/BAC9-$8A/BACE | 6 | 0 | `PortraitPaletteGhostDeirdrePortraitPalettePointersEntry` / `aDialogueBackgroundPointers` |  |
| $8A/CE4F-$8A/CE4F | 1 | 0 | `rsUnknown8ACE3A` / `rlUnknown8ACE50` |  |
| $8A/DD98-$8A/E05D | 710 | 0 | `rsUnknown8ADCF9` / `rsUnknown8AE05E` | 73% $00/$FF |
| $8A/F045-$8A/F047 | 3 | 0 | `rsUnknown8AEF4B` / `rsUnknown8AF048` |  |
| $8A/F259-$8A/F262 | 10 | 0 | `rlUnknown8AF0F2` / `aDecompressionDMAEntry8AF263` | 60% $00/$FF |
| $8B/812A-$8B/818C | 99 | 0 | `rsUnknown8B8114` / `rsUnknown8B818D` |  |
| $8B/81EC-$8B/821E | 51 | 0 | `rsUnknown8B818D` / `rlFadeInWorldMapPortraitSlot` |  |
| $8B/83A7-$8B/84E4 | 318 | 0 | `aPortraitSlotVRAMOffsets` / `rlLoadWorldMapMarkerData` |  |
| $8B/8A58-$8B/8A83 | 44 | 0 | `rsDecompressUnifiedThraciaMapHighlight` / `rlClearHighlightWorldMapPart` | 56% $00/$FF |
| $8B/8BA5-$8B/8BB4 | 16 | 0 | `aProcWorldMapMarkerShadowFadeInCode` / `rlUnknown8B8BB5` |  |
| $8B/8BF2-$8B/8BF3 | 2 | 0 | `rlUnknown8B8BB5` / `procWorldMapMarkerShadowFadeOut` |  |
| $8B/8C7B-$8B/8C80 | 6 | 0 | `rlUnknown8B8C4A` / `aProcUnknown8B8C3ACode` | 66% $00/$FF |
| $8B/A088-$8B/A0B3 | 44 | 0 | `ClassPortraitDarkPrinceClassPortraitDataIDsEntry` / `rlUnknown8BA0B4` |  |
| $8B/A7CE-$8B/A7F1 | 36 | 0 | `rlUnknown8BA7CD` / `rlUnitWindowShow` |  |
| $8B/B534-$8B/B53A | 7 | 0 | `rsUnitWindowRenderWeaponRankSortIcon` / `aUnknown8BB53B` |  |
| $8B/B58F-$8B/B595 | 7 | 0 | `rlUnitWindowRenderUnitSwapCursors` / `rsUnitWindowMoveToLastUnit` |  |
| $8B/B80A-$8B/B810 | 7 | 0 | `rsUnitWindowRenderItemIcons` / `aUnknown8BB811` |  |
| $8B/B882-$8B/B8B5 | 52 | 0 | `rsUnitWindowRenderWeaponRankIcons` / `rsUnitWindowCopyLineHighlightColors` |  |
| $8B/C4F3-$8B/C517 | 37 | 0 | `rsUnitWindowUpdateSort` / `aUnitWindowPageSortTypePointers` |  |
| $8C/C4E0-$8C/C4FF | 32 | 0 | `PortraitPaletteClassCardThiefPointer` / `aDialogueBackgroundGatePalette` |  |
| $8C/F09B-$8C/FFFF | 3,941 | 0 | `rlUnknown8CF07F` / `` |  |
| $8D/8000-$8D/863E | 1,599 | 0 | `PortraitDataMacBethPointer` / `aEventChapter10Opening` |  |
| $8D/A612-$8D/A623 | 18 | 0 | `rlUnknown8DA50F` / `rsUnknown8DA624` |  |
| $8D/AAFD-$8D/AD72 | 630 | 0 | `aProcUnknown8DAA96Code` / `rlUnknown8DAD73` |  |
| $8D/AEC0-$8D/AEC1 | 2 | 0 | `rlUnknown8DAE85` / `rlUnknown8DAEC2` |  |
| $8D/B539-$8D/B539 | 1 | 0 | `rlUnknown8DB52C` / `rsUnknown8DB53A` |  |
| $D0/5639-$D0/5672 | 58 | 0 | `PortraitDataClassCardIronBallistaPointer` / `gcUnknownD05673` |  |
| $91/A3DD-$91/A3DD | 1 | 0 | `rlUnknown91A3D9` / `rsUnknown91A3DE` |  |
| $91/A7EA-$91/A80C | 35 | 0 | `rlUnknown91A7DF` / `rlUnknown91A80D` |  |
| $91/A8E4-$91/A927 | 68 | 0 | `rsDialogueEventCommand07` / `rlUnknown91A928` |  |
| $91/A9F2-$91/AA14 | 35 | 0 | `aUnknown91A9E4` / `rsUnknown91AA15` |  |
| $91/B11C-$91/B130 | 21 | 0 | `dialogueChapterFinalEddaSeizedClaudsChildrenAloneStart` / `rlUnknown91B131` |  |
| $91/B1FB-$91/B1FB | 1 | 0 | `aUnknown91B1E3` / `rsUnknown91B1FC` |  |
| $91/BD42-$91/BD93 | 82 | 0 | `aEpilogueLoverPartners` / `rlASMCStatUpDisplay` |  |
| $91/DF08-$91/DF31 | 42 | 0 | `rsUnknown91DEA1` / `rlUnknown91DF32` |  |
| $91/E006-$91/E079 | 116 | 0 | `rsUnknown91DF6D` / `rlUnknown91E07A` |  |
| $91/E4A3-$91/E4B2 | 16 | 0 | `rlUnknown91E472` / `aUnknown91E4B3` | 87% $00/$FF |
| $91/E913-$91/E914 | 2 | 0 | `rlUnknown91E8C1` / `rsUnknown91E915` |  |
| $95/9650-$95/968D | 62 | 0 | `rlUnknown9595CA` / `rlUnknown95968E` |  |
| $95/9BFE-$95/9C13 | 22 | 0 | `rsUnknown959BC1` / `rsUnknown959C14` |  |
| $95/9E71-$95/9F42 | 210 | 0 | `rlUnknown959E22` / `rlUnknown959F43` |  |
| $95/9FEA-$95/A085 | 156 | 0 | `rlUnknown959F43` / `rlUnknown95A086` |  |
| $95/A166-$95/A166 | 1 | 0 | `rlUnknown95A165` / `rlUnknown95A167` |  |
| $95/AA8D-$95/AAFE | 114 | 0 | `rsUnknown95A761` / `rlUnknown95AAFF` |  |
| $95/B114-$95/B183 | 112 | 0 | `rlUnknown95B0D7` / `rlBattleAnimationCompareCombatantX` |  |
| $95/B6A7-$95/B6CF | 41 | 0 | `rsBattleAnimationGetSpeedB` / `rlUnknown95B6D0` |  |
| $95/B7CF-$95/B7F7 | 41 | 0 | `rlUnknown95B7AE` / `rlUnknown95B7F8` |  |
| $95/C306-$95/C367 | 98 | 0 | `rsUnknown95C2C0` / `rlUnknown95C368` |  |
| $95/D200-$95/D23B | 60 | 0 | `rlBattleAnimationGetPathMeasures` / `rsBattleAnimationSetYPathToOpponent` |  |
| $95/D280-$95/D2A3 | 36 | 0 | `rsBattleAnimationSetYPathToOpponent` / `rsUnknown95D2A4` |  |
| $95/E08C-$95/E0C4 | 57 | 0 | `rsUnknown95DF76` / `rsUnknown95E0C5` |  |
| $95/E80D-$95/E833 | 39 | 0 | `rlUnknown95E7EC` / `rsUnknown95E834` |  |
| $95/E877-$95/E887 | 17 | 0 | `rsUnknown95E834` / `rlUnknown95E888` |  |
| $95/ED7B-$95/EE72 | 248 | 0 | `rlUnknown95ED6A` / `rlUnknown95EE73` |  |
| $95/F2E5-$95/F425 | 321 | 0 | `rlUnknown95F29B` / `rlUnknown95F426` |  |
| $95/F48E-$95/F740 | 691 | 0 | `rlUnknown95F47A` / `rlUnknown95F741` |  |
| $95/F777-$95/F7B6 | 64 | 0 | `rlUnknown95F741` / `rlUnknown95F7B7` |  |
| $95/F831-$95/F87E | 78 | 0 | `rlUnknown95F7F7` / `rlUnknown95F87F` |  |
| $95/F9B4-$95/FCA3 | 752 | 0 | `rlUnknown95F967` / `rlUnknown95FCA4` |  |
| $95/FD1C-$95/FD43 | 40 | 0 | `rlUnknown95FCF4` / `rlUnknown95FD44` |  |
| $95/FDE4-$95/FF50 | 365 | 0 | `rlUnknown95FDA6` / `rlUnknown95FF51` |  |
| $95/FF6E-$95/FFFF | 146 | 0 | `rlUnknown95FF51` / `` | 58% $00/$FF |
| $96/87B3-$96/881E | 108 | 0 | `rlUnknown96878D` / `rlUnknown96881F` |  |
| $96/88E4-$96/890D | 42 | 0 | `rlUnknown9688BA` / `rlUnknown96890E` |  |
| $96/8DBB-$96/8DBC | 2 | 0 | `rlUnknown968DAA` / `rlUnknown968DBD` |  |
| $96/8DE1-$96/8E4B | 107 | 0 | `rlUnknown968DC8` / `rlUnknown968E4C` |  |
| $96/8E8F-$96/8F4F | 193 | 0 | `rlUnknown968E7E` / `rlUnknown968F50` |  |
| $96/92F8-$96/9397 | 160 | 0 | `rlUnknown9691C8` / `rlUnknown969398` |  |
| $96/9766-$96/97F9 | 148 | 0 | `rsUnknown969765` / `rlUnknown9697FA` |  |
| $96/9964-$96/99DC | 121 | 0 | `rlUnknown96994B` / `rlUnknown9699DD` |  |
| $96/A0EB-$96/A20D | 291 | 0 | `rlUnknown96A0E2` / `rlUnknown96A20E` |  |
| $96/ACC5-$96/AD06 | 66 | 0 | `rsUnknown96ACAB` / `rsUnknown96AD07` |  |
| $96/AD37-$96/AD38 | 2 | 0 | `rsUnknown96AD07` / `rlUnknown96AD39` |  |
| $96/B08D-$96/B0E0 | 84 | 0 | `rlUnknown96AFCF` / `rsUnknown96B0E1` |  |
| $96/B7E2-$96/B851 | 112 | 0 | `rsUnknown96B794` / `rsUnknown96B852` |  |
| $96/BE68-$96/BFE4 | 381 | 0 | `rlUnknown96BE53` / `rlUnknown96BFE5` |  |
| $96/C07F-$96/C7DA | 1,884 | 0 | `rlUnknown96C008` / `rlUnknown96C7DB` |  |
| $96/CD0E-$96/CD22 | 21 | 0 | `rsUnknown96CCAF` / `rsUnknown96CD23` |  |
| $96/D254-$96/D255 | 2 | 0 | `rlUnknown96D1EC` / `rlUnknown96D256` |  |
| $96/D2D5-$96/D2D6 | 2 | 0 | `rlUnknown96D256` / `rlUnknown96D2D7` |  |
| $96/D3EB-$96/D3EC | 2 | 0 | `rlUnknown96D2D7` / `rsUnknown96D3ED` |  |
| $96/D400-$96/D401 | 2 | 0 | `rsUnknown96D3ED` / `rsUnknown96D402` |  |
| $96/D415-$96/D416 | 2 | 0 | `rsUnknown96D402` / `rsUnknown96D417` |  |
| $96/D42A-$96/D42B | 2 | 0 | `rsUnknown96D417` / `rsUnknown96D42C` |  |
| $96/DCC8-$96/DD38 | 113 | 0 | `rlUnknown96DC7C` / `rlUnknown96DD39` |  |
| $96/DF98-$96/DFBA | 35 | 0 | `aUnknown96DF60` / `rsUnknown96DFBB` |  |
| $96/F28B-$96/F28C | 2 | 0 | `rlUnknown96F275` / `rlUnknown96F28D` |  |
| $96/F41A-$96/F557 | 318 | 0 | `rsUnknown96F3FE` / `rlUnknown96F558` |  |
| $96/F580-$96/F675 | 246 | 0 | `rlUnknown96F56C` / `rlUnknown96F676` |  |
| $96/F89B-$96/F914 | 122 | 0 | `rsUnknown96F7EB` / `rsUnknown96F915` |  |
| $96/FA92-$96/FAB5 | 36 | 0 | `rlUnknown96F9BF` / `rsUnknown96FAB6` |  |
| $96/FADA-$96/FBF8 | 287 | 0 | `rsUnknown96FAB6` / `rlUnknown96FBF9` |  |
| $96/FC49-$96/FD53 | 267 | 0 | `rlUnknown96FBF9` / `rlUnknown96FD54` |  |
| $97/8024-$97/802B | 8 | 0 | `rlUnknown978000` / `rlUnknown97802C` |  |
| $98/FF85-$98/FFFF | 123 | 0 | `aBattleAnimationSequencesUnknown10` / `g4bppMapTiles` |  |
| $9B/E15F-$9B/E178 | 26 | 0 | `rsUnknown9BE128` / `rlUnknown9BE179` |  |
| $9B/E2A4-$9B/E5B1 | 782 | 0 | `rlUnknown9BE1C0` / `rlUnknown9BE5B2` |  |
| $9B/E697-$9B/EAA4 | 1,038 | 0 | `rlUnknown9BE619` / `rlUnknown9BEAA5` |  |
| $9B/EDD7-$9B/EEB3 | 221 | 0 | `rsUnknown9BED9D` / `rlUnknown9BEEB4` |  |
| $9B/F1F4-$9B/F23B | 72 | 0 | `rlUnknown9BF179` / `rlUnknown9BF23C` |  |
| $9B/F2AA-$9B/F3F2 | 329 | 0 | `rlUnknown9BF297` / `rlUnknown9BF3F3` |  |
| $9B/F49E-$9B/F650 | 435 | 0 | `rlUnknown9BF3F3` / `rlUnknown9BF651` |  |
| $9B/F77A-$9B/FA57 | 734 | 0 | `rlUnknown9BF726` / `rlUnknown9BFA58` |  |
| $9B/FB73-$9B/FB7D | 11 | 0 | `rlUnknown9BFB68` / `rlUnknown9BFB7E` |  |
| $9B/FBB0-$9B/FBBF | 16 | 0 | `rlUnknown9BFBA9` / `rlUnknown9BFBC0` |  |
| $9E/8035-$9E/805D | 41 | 0 | `rlUnknown9E800C` / `rlUnknown9E805E` |  |
| $9E/9C94-$9E/9CB8 | 37 | 0 | `rlUnknown9E9C70` / `rlProcUnknown9E9A43Cycle1` |  |
| $9E/9ECF-$9E/9F25 | 87 | 0 | `rlUnknown9E9E61` / `rlUnknown9E9F26` |  |
| $9E/A38C-$9E/A403 | 120 | 0 | `rlProcUnknown9EA334Cycle` / `aProcUnknown9EA334Code` |  |
| $9E/B3C8-$9E/B3DD | 22 | 0 | `rlUnknown9EB39F` / `rlUnknown9EB3DE` |  |
| $9E/B433-$9E/B490 | 94 | 0 | `rlUnknown9EB41C` / `rlUnknown9EB491` |  |
| $9E/CEB9-$9E/CEDC | 36 | 0 | `rlUnknown9ECEA0` / `procUnknown9ECEDD` |  |
| $9E/D006-$9E/D079 | 116 | 0 | `rlUnknown9ECFEB` / `rlUnknown9ED07A` |  |
| $9E/D1BB-$9E/D1F3 | 57 | 0 | `rlProcUnknown9EAF98Cycle2` / `aProcUnknown9ED089Code` |  |
| $9E/D412-$9E/D429 | 24 | 0 | `rlUnknown9ED401` / `rlUnknown9ED42A` |  |
| $9E/D528-$9E/D534 | 13 | 0 | `rlProcUnknown9ED441Init` / `rlProcUnknown9ED441Cycle2` |  |
| $9E/D72A-$9E/D741 | 24 | 0 | `rlUnknown9ED71E` / `rlUnknown9ED742` |  |
| $9E/DC14-$9E/DC14 | 1 | 0 | `rlProcUnknown9EDAF6Cycle1` / `aProcUnknown9EDAF6Code` |  |
| $9E/E079-$9E/E091 | 25 | 0 | `rlProcUnknown9EE03CCycle` / `aProcUnknown9EE03CCode` |  |
| $9E/E177-$9E/E227 | 177 | 0 | `rlUnknown9EE156` / `rlUnknown9EE228` |  |
| $9E/E2E4-$9E/EC94 | 2,481 | 0 | `rlUnknown9EE2D1` / `rlUnknown9EEC95` |  |
| $9E/F5AC-$9E/F5CF | 36 | 0 | `rlUnknown9EF578` / `rlUnknown9EF5D0` |  |
| $DF/7FF8-$9F/801F | 40 | 0 | `g4bppcBattleAnimationSheetHighPriest` / `rlUnknown9F8020` |  |
| $9F/827A-$9F/82A6 | 45 | 0 | `rsUnknown9F8253` / `rsUnknown9F82A7` |  |
| $9F/82BE-$9F/82D6 | 25 | 0 | `rsUnknown9F82A7` / `rsUnknown9F82D7` |  |
| $9F/8398-$9F/83CF | 56 | 0 | `rsUnknown9F8389` / `rsUnknown9F83D0` |  |
| $9F/88C0-$9F/88FF | 64 | 0 | `aMapBattleMagicSpritePaletteLight` / `rlUnknown9F8900` |  |
| $9F/89D4-$9F/8A33 | 96 | 0 | `rlUnknown9F8999` / `rlUnknown9F8A34` |  |
| $9F/8F95-$9F/8FE2 | 78 | 0 | `rlFadePaletteToBlack` / `rlFadeFromToColorByStep` |  |
| $9F/90FE-$9F/9109 | 12 | 0 | `rlUnknown9F90FA` / `rsUnknown9F910A` |  |
| $9F/91B8-$9F/9216 | 95 | 0 | `rsUnknown9F9116` / `rlUnknown9F9217` |  |
| $9F/94D5-$9F/94FD | 41 | 0 | `rlUnknown9F944F` / `rlUnknown9F94FE` |  |
| $9F/957A-$9F/95E0 | 103 | 0 | `rlUnknown9F9570` / `rlUnknown9F95E1` |  |
| $9F/9965-$9F/9975 | 17 | 0 | `rlUnknown9F9954` / `rlUnknown9F9976` |  |
| $9F/9987-$9F/999D | 23 | 0 | `rlUnknown9F9976` / `rsUnknown9F999E` |  |
| $9F/9A2B-$9F/9ABE | 148 | 0 | `rlUnknown9F9A1E` / `rlUnknown9F9ABF` |  |
| $9F/BDC1-$9F/DB67 | 7,591 | 0 | `rlUnknown9FBD6B` / `rlUnknown9FDB68` |  |
| $9F/E0AA-$9F/E823 | 1,914 | 0 | `rlUnknown9FE006` / `rlUnknown9FE824` |  |
| $9F/EBA8-$9F/EBA8 | 1 | 0 | `rlProcUnknown9F805DInit` / `aProcUnknown9F805DCode` |  |
| $9F/ED29-$9F/ED59 | 49 | 0 | `rlUnknown9FECFE` / `rlUnknown9FED5A` |  |
| $9F/EE45-$9F/F05F | 539 | 0 | `rlUnknown9FEDB3` / `rlUnknown9FF060` |  |
| $9F/F0DC-$9F/F0FF | 36 | 0 | `rlUnknown9FF060` / `rlUnknown9FF100` |  |
| $9F/F1BC-$9F/F24F | 148 | 0 | `rlUnknown9FF100` / `rsUnknown9FF250` |  |
| $9F/F2FD-$9F/F375 | 121 | 0 | `rsUnknown9FF2E4` / `rsUnknown9FF376` |  |
| $9F/F66D-$9F/F67C | 16 | 0 | `rlUnknown9FF65A` / `rlUnknown9FF67D` |  |
| $9F/F98E-$9F/F9A7 | 26 | 0 | `rsUnknown9FF97A` / `rlUnknown9FF9A8` | 53% $00/$FF |
| $E0/01D6-$E0/01F3 | 30 | 0 | `aBattleAnimationPaletteJuniorLord` / `aBattleAnimationPaletteWarMage` |  |
| $E0/0212-$E0/022F | 30 | 0 | `aBattleAnimationPaletteWarMage` / `aBattleAnimationPaletteWarMageF` |  |
| $E0/024E-$E0/026B | 30 | 0 | `aBattleAnimationPaletteWarMageF` / `aBattleAnimationPalettePrince` |  |
| $E0/028A-$E0/02A7 | 30 | 0 | `aBattleAnimationPalettePrince` / `aBattleAnimationPalettePrincess` |  |
| $E0/02C6-$E0/02E3 | 30 | 0 | `aBattleAnimationPalettePrincess` / `aBattleAnimationPaletteQueen` |  |
| $E0/0302-$E0/031F | 30 | 0 | `aBattleAnimationPaletteQueen` / `aBattleAnimationPaletteDancer` |  |
| $E0/037A-$E0/03D3 | 90 | 0 | `aBattleAnimationPalettePriest` / `aBattleAnimationPaletteMage` |  |
| $E0/03F2-$E0/040F | 30 | 0 | `aBattleAnimationPaletteMage` / `aBattleAnimationPaletteMage2` |  |
| $E0/042E-$E0/044B | 30 | 0 | `aBattleAnimationPaletteMage2` / `aBattleAnimationPaletteFireMage` |  |
| $E0/046A-$E0/0487 | 30 | 0 | `aBattleAnimationPaletteFireMage` / `aBattleAnimationPaletteThunderMage` |  |
| $E0/04A6-$E0/04C3 | 30 | 0 | `aBattleAnimationPaletteThunderMage` / `aBattleAnimationPaletteWindMage` |  |
| $E0/04E2-$E0/04FF | 30 | 0 | `aBattleAnimationPaletteWindMage` / `aBattleAnimationPaletteHighPriest` |  |
| $E0/051E-$E0/053B | 30 | 0 | `aBattleAnimationPaletteHighPriest` / `aBattleAnimationPaletteHighPriest2` |  |
| $E0/055A-$E0/0577 | 30 | 0 | `aBattleAnimationPaletteHighPriest2` / `aBattleAnimationPaletteBishop` |  |
| $E0/0596-$E0/05B3 | 30 | 0 | `aBattleAnimationPaletteBishop` / `aBattleAnimationPaletteBard` |  |
| $E0/05D2-$E0/05EF | 30 | 0 | `aBattleAnimationPaletteBard` / `aBattleAnimationPalettePriestess` |  |
| $E0/060E-$E0/062B | 30 | 0 | `aBattleAnimationPalettePriestess` / `aBattleAnimationPaletteDarkMage` |  |
| $E0/064A-$E0/0667 | 30 | 0 | `aBattleAnimationPaletteDarkMage` / `aBattleAnimationPaletteDarkBishop` |  |
| $E0/0686-$E0/06A3 | 30 | 0 | `aBattleAnimationPaletteDarkBishop` / `aBattleAnimationPaletteSage` |  |
| $E0/06C2-$E0/06DF | 30 | 0 | `aBattleAnimationPaletteSage` / `aBattleAnimationPaletteSage2` |  |
| $E0/06FE-$E0/071B | 30 | 0 | `aBattleAnimationPaletteSage2` / `aBattleAnimationPaletteSage3` |  |
| $E0/0778-$E0/07B5 | 62 | 0 | `aBattleAnimationPalettePegasusKnight` / `aBattleAnimationPalette0E` |  |
| $E0/0832-$E0/086F | 62 | 0 | `aBattleAnimationPaletteDragonrider` / `aBattleAnimationPaletteDragonknight` |  |
| $E0/08AE-$E0/08EB | 62 | 0 | `aBattleAnimationPaletteDragonknight` / `aBattleAnimationPaletteDragonmaster` |  |
| $E0/092A-$E0/0B67 | 574 | 0 | `aBattleAnimationPaletteDragonmaster` / `aBattleAnimationPaletteGeneral` |  |
| $E0/0B86-$E0/0BA3 | 30 | 0 | `aBattleAnimationPaletteGeneral` / `aBattleAnimationPaletteBaron` |  |
| $E0/0BC2-$E0/0BDF | 30 | 0 | `aBattleAnimationPaletteBaron` / `aBattleAnimationPaletteEmperor` |  |
| $E0/0BFE-$E0/0C1B | 30 | 0 | `aBattleAnimationPaletteEmperor` / `aBattleAnimationPalettePaladin` |  |
| $E0/0C5A-$E0/0C97 | 62 | 0 | `aBattleAnimationPalettePaladin` / `aBattleAnimationPalettePaladinF` |  |
| $E0/0CD6-$E0/0D13 | 62 | 0 | `aBattleAnimationPalettePaladinF` / `aBattleAnimationPaletteArcher` |  |
| $E0/0D32-$E0/0F2F | 510 | 0 | `aBattleAnimationPaletteArcher` / `aBattleWeaponPaletteIronSword` | 90% $00/$FF |
| $E0/155A-$E0/1577 | 30 | 0 | `aBattleAnimationPaletteMyrmidon` / `aBattleAnimationPaletteArcher2` |  |
| $E0/1596-$E0/15B3 | 30 | 0 | `aBattleAnimationPaletteArcher2` / `aBattleAnimationPaletteSwordmaster` |  |
| $E0/15D2-$E0/15EF | 30 | 0 | `aBattleAnimationPaletteSwordmaster` / `aBattleAnimationPaletteSwordmaster2` |  |
| $E0/160E-$E0/162B | 30 | 0 | `aBattleAnimationPaletteSwordmaster2` / `aBattleAnimationPaletteHero` |  |
| $E0/164A-$E0/1667 | 30 | 0 | `aBattleAnimationPaletteHero` / `aBattleAnimationPaletteHero2` |  |
| $E0/1686-$E0/16C1 | 60 | 0 | `aBattleAnimationPaletteHero2` / `aBattleAnimationPaletteSniper` |  |
| $E0/16E0-$E0/16FD | 30 | 0 | `aBattleAnimationPaletteSniper` / `aBattleAnimationPaletteSniper2` |  |
| $E0/171C-$E0/1757 | 60 | 0 | `aBattleAnimationPaletteSniper2` / `aBattleAnimationPaletteCavalier` |  |
| $E0/1796-$E0/17D3 | 62 | 0 | `aBattleAnimationPaletteCavalier` / `aBattleAnimationPaletteFreeKnight` |  |
| $E0/1812-$E0/188D | 124 | 0 | `aBattleAnimationPaletteFreeKnight` / `aBattleAnimationPaletteTroubadour` |  |
| $E0/18CC-$E0/1909 | 62 | 0 | `aBattleAnimationPaletteTroubadour` / `aBattleAnimationPaletteKnightLord` |  |
| $E0/1948-$E0/1985 | 62 | 0 | `aBattleAnimationPaletteKnightLord` / `aBattleAnimationPaletteDukeKnight` |  |
| $E0/19C4-$E0/1A01 | 62 | 0 | `aBattleAnimationPaletteDukeKnight` / `aBattleAnimationPaletteMasterKnight` |  |
| $E0/1A40-$E0/1A7D | 62 | 0 | `aBattleAnimationPaletteMasterKnight` / `aBattleAnimationPaletteMasterKnight2` |  |
| $E0/1ABC-$E0/1AF9 | 62 | 0 | `aBattleAnimationPaletteMasterKnight2` / `aBattleAnimationPaletteRanger` |  |
| $E0/1B38-$E0/1B75 | 62 | 0 | `aBattleAnimationPaletteRanger` / `aBattleAnimationPaletteMageKnight` |  |
| $E0/1BB4-$E0/1BF1 | 62 | 0 | `aBattleAnimationPaletteMageKnight` / `aBattleAnimationPaletteGreatKnight` |  |
| $E0/1C30-$E0/1C6D | 62 | 0 | `aBattleAnimationPaletteGreatKnight` / `aBattleAnimationPaletteFighter` |  |
| $E0/1D04-$E0/1D21 | 30 | 0 | `aBattleAnimationPalettePirate` / `aBattleAnimationPaletteThief` |  |
| $E0/1D40-$E0/1D5D | 30 | 0 | `aBattleAnimationPaletteThief` / `aBattleAnimationPaletteThief2` |  |
| $E0/1D7C-$E0/1D99 | 30 | 0 | `aBattleAnimationPaletteThief2` / `aBattleAnimationPaletteRogue` |  |
| $E0/1DB8-$E0/1DD5 | 30 | 0 | `aBattleAnimationPaletteRogue` / `aBattleAnimationPaletteRogue2` |  |
| $E0/1DF4-$E0/1E11 | 30 | 0 | `aBattleAnimationPaletteRogue2` / `aBattleAnimationPaletteLanceArmor` |  |
| $E0/1E30-$E0/1E4D | 30 | 0 | `aBattleAnimationPaletteLanceArmor` / `aBattleAnimationPaletteBallistician` |  |
| $E0/1E8C-$E0/1EC9 | 62 | 0 | `aBattleAnimationPaletteBallistician` / `aBattleAnimationPaletteIronBallistician` |  |
| $E0/1F08-$E0/1F45 | 62 | 0 | `aBattleAnimationPaletteIronBallistician` / `aBattleAnimationPaletteKillerBallistician` |  |
| $E0/1F84-$E0/1FC1 | 62 | 0 | `aBattleAnimationPaletteKillerBallistician` / `aBattleAnimationPaletteGreatBallistician` |  |
| $E0/2000-$E0/203D | 62 | 0 | `aBattleAnimationPaletteGreatBallistician` / `aBattleAnimationPaletteDarkPrince` |  |
| $E0/2AE5-$E0/2B04 | 32 | 0 | `aBattleAnimationPaletteBeowulf` / `aBattleAnimationPaletteBeowulf2` | 96% $00/$FF |
| $E0/2B23-$E0/2B42 | 32 | 0 | `aBattleAnimationPaletteBeowulf2` / `aBattleAnimationPaletteLeif` | 96% $00/$FF |
| $E0/2C35-$E0/2C54 | 32 | 0 | `aBattleAnimationPaletteFebail2` / `aBattleAnimationPaletteArthur` | 96% $00/$FF |
| $E0/2C73-$E0/2C92 | 32 | 0 | `aBattleAnimationPaletteArthur` / `aBattleAnimationPaletteArthur2` | 90% $00/$FF |
| $E0/2CB1-$E0/2CD0 | 32 | 0 | `aBattleAnimationPaletteArthur2` / `aBattleAnimationPaletteAmid` |  |
