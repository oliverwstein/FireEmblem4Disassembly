# Code/data log analysis: prologue playthrough

`fe4.cdl` is a Mesen 2 code/data log recorded while playing the prologue. `tools/cdl.py` compares it with the build and writes everything below the marker line; this summary is written by hand and kept when the tool is run again:

```
tools/cdl.py fe4.cdl --report cdl_analysis_report.md [--entries FILE]
```

Addresses are CPU addresses (`$80`-`$BF` for code). "Built" means the byte comes from source, by the method of `./build.sh coverage`.

## Summary

The log matches this ROM (CRC32 `DC0D8CF9`). It covers 203,080 executed bytes and 970,847 bytes that were only read. At first **70,629 executed bytes were not built**: 35% of the code the prologue runs. After the game state routines came in (below), 49,952 are left. A full playthrough will find more.

### Reading the flags

The bits are `$01` code, `$02` data, `$04` jump target, `$08` subroutine entry, `$10` 8-bit X, `$20` 8-bit A. The report checks this each run against the built source: every built routine that executed code reaches with a `jsl` has `$08`, and the width bits agree with the source's `.as`/`.xs` at 3,123 of 3,135 routine starts. The first version of this report took `$04`/`$08` for the width bits, so its width check and its reading of `$8A/CFBE` were wrong. Its "18,447 unbuilt code bytes" came from treating everything up to the next label as built.

Two patterns in the log are noise:

- Data marks of 1-3 bytes scattered inside code come from the emulator's dummy reads (for example after `ply`/`plp`/`plb` at `$82/E7ED`).
- A data mark on only the first byte of a routine, right after a read table, comes from a 16-bit read of the table's last entry. For example, the read of the last entry of `aRingStatBonusTable` also touches the first byte of `rlGivePlayerItemIDToSelectedUnitsFirstItemSlot`.

### Where the unbuilt code is

Banks `$95` (20 KB) and `$96` (12 KB) hold most of it, although STATUS.md describes `$92`-`$9C` as almost all data. That code writes the BG scroll, CGRAM and INIDISP registers heavily. It may be the battle-scene engine, but this is not checked. Next come `$80` (8.5 KB), `$8A` (6.4 KB), `$89`, `$85` and `$8B` (4-5 KB each), and `$9B`, `$9F`, `$91` and `$88` (1.5-3.4 KB each).

None of it is called directly from built code. The best way in is through raw pointers in built tables:

- **`aGameStateRoutines` (`$80/9B01`)** was 56 raw `.long` values, 33 of which led to unbuilt code that ran. **Done:** they are labels now, and the tracer followed them to 459 routines (35,856 bytes; coverage 19.74% to 20.60%).
- The jump table in `rlUnknown86B307` (9 targets), `aMapMenuTypePointers` (6), `aUnknown81AE02` and `aUnknown81AFAE` also hold raw pointers to unbuilt code.

`--entries` writes all the entry points of unbuilt code, with the register widths they were entered with, as starting points for `tools/disasm.py` (`--m8`/`--x8` where the widths say 8).

### Built code that is really data

Each of these is the base of an indexed read or jump from executed code, and the log shows it read, never executed:

| Address | Built as | What it is |
|---|---|---|
| `$8A/87F3` | `rsUnknown8A87F3` | Jump table for `jsr ($87F3,x)` at `$8A/87CF`: `$883A, $87FF, $8812, $8825, $889A, $8876` |
| `$89/C326` | `rsUnknown89C326` | Jump table for `jsr ($C326,x)` at `$89/C2F2` (`$C338, $C38A, $C3BD`), then a byte table read at `$89/C2DA` |
| `$9F/8A6E` | inside `rlUnknown9F8A34` | Jump table for `jsr ($8A6E,x)` at `$9F/8A69`: `$8A97, $8AA8, $8AB5, $8AC6` |
| `$88/9BB5` | `rsUnknown889BB5` | Byte table read by `lda $889BB5,x` at `$88/9B9C` |
| `$89/A5D1` | `rsUnknown89A5D1` | 20 bytes of tilemap words read at `$89/A5BB` and `$89/A5C7` |
| `$89/9109` | `rsUnknown899109` (`rts`) and `aUnknown89910A` | A single word table starting one byte earlier than `aUnknown89910A`, read by `lda $899109,x` at `$89/90F3` |
| `$91/F7B7` | inside `rlUnknown91F75F` | Word table indexed by chapter (`lda wCurrentChapter; asl; tax; lda $91F7B7,x`) |

Also worth a look: `rsUnknown87E779` reads like a pointer table (`$E79B, $E7A6, ...`), and `rsUnknown8189E1` may be the argument byte of the active sprite script `aASMapSpriteCode`.

### Built data that is executed

Mostly bytes that `tools/disasm.py` thought unreachable inside a routine and wrote as data:

- **Separate routines entered by `jsr`/`jsl`:** `$84/F815`, `$87/9DD1` (inside `aUnknown879D77`), `$88/8ABE`, `$88/8ADD`, `$88/B2A5` and `$8A/E0D7` (inside `aUnknown8AE0C7`).
- **An unrolled loop entered by `jmp (wR0)`:** `$80/8A4A` is `.byte $86,$00,$86,$02,...`, but it runs as `stx $00; stx $02; ...`.
- **Returns pushed with `pea #ret-1`:** `$80/8EE8`, `$80/91E7` and `$9F/8080`. `disasm.py` could treat the target of `pea #X` before an indirect jump as reachable at `X+1`.
- **One byte early:** `$9E/88F9` (`phx`) is an entry point, one byte before `rlUnknown9E88FA`.
- **Branch targets:** `$84/F844`, `$84/F876`, `$85/CB36`, `$88/8B27`, `$88/8B46`, `$88/B305` and `$9E/B4A9` are jump targets inside data blocks of built routines.

### Integrity checks and other bulk reads of code

- `$80/8D56`-`8E2D` and `$87/8017`-`80A9` are the two checksummed ranges in `include/Checksums.h`. The first is still not built.
- **A second check, not in `include/Checksums.h`.** `rlUnknown878017` copies `$88/8888`-`8907` to `$1E00`, and `rlUnknown87802A` compares the copy with the ROM. On a difference it falls into an endless loop.
- Code read in bulk for reasons not yet known: `$88/8888`-`8AC7` (576 bytes) and `$82/8888`-`890D` (134 bytes, built as `rlProcUnknown828865Cycle`, `rlUnknown8288B2` and a proc header). Something may sum or copy these; find the reader in Mesen with a read breakpoint.
- `$80/D64A`-`D817` (462 bytes, unbuilt) is read and also partly executed.

### `$8A/CFBE`

Its flags are `$09` (code, subroutine entry, 16-bit A and X). Something enters it with `jsr` or `jsl`, so it is the start of a routine, not the middle of one as STATUS.md says. It can be disassembled with `tools/disasm.py 8ACFBE`.

### Tables in `include/Undisassembled.h`

The table at the end gives, for each one, the gap up to the next label, how much of it the prologue read, and the last byte read. These are lower bounds. The first report was wrong about several of them: `aUnknown879481` ($23A bytes read), `aUnknownDA7000` and `aUnknownDBB883` were read, only not at their first byte. `aUnknown8C9800` is $200 bytes, not $400. Where a gap has executed code in it (for example after `aUnknown80D1AE`, `aUnknown89935F` and `aUnknownDBB883`), the table ends before that code.

### Next steps

1. Write `aGameStateRoutines` and the other tables with raw pointers as labels, and rerun `tools/trace.py`.
2. Rewrite the seven tables built as code, and split out the routines built as data.
3. Feed the entry points to `tools/disasm.py`, bank by bank, starting with `$80`, `$8A` and `$89`, which are already partly built.
4. Record longer playthroughs (battles, later chapters, the debug menu) and rerun the tool.

<!-- Everything below is generated by tools/cdl.py. -->

## Generated report

Generated by `tools/cdl.py fe4.cdl`. Addresses are CPU addresses; code uses the `$80`-`$BF` mirror. "Built" means the byte comes from source (the method of `./build.sh coverage`).

### The log

- CRC32 in the log `DC0D8CF9`, ROM `DC0D8CF9`: they match.
- Flag `$08` is the subroutine entry mark: 1352 of the 1352 built routines that executed code reaches with a direct `jsl` carry it.
- Flags `$20` and `$10` are 8-bit accumulator and index: they agree with the `.as`/`.al` and `.xs`/`.xl` at 3767 of 3779 executed routine starts that state a width.

Where they disagree, the routine was last entered with other widths than the source assumes. That is harmless when it saves or sets the widths before they matter (`php`, `rep` or `sep` in its first 4 bytes); otherwise check its callers.

| Routine | Name | Source says | Log says A/X | Sets widths first |
|---|---|---|---|---|
| $80/81B6 | `rlUnknown8081B6` | `.al` | 8/8 | yes |
| $80/81B6 | `rlUnknown8081B6` | `.xl` | 8/8 | yes |
| $80/826E | `rlHideSprites` | `.al` | 8/8 | yes |
| $80/8341 | `rlClearSpriteExtBuffer` | `.al` | 8/8 | **no** |
| $80/8FAD | `rlUnknown808FAD` | `.al` | 8/16 | yes |
| $80/A34F | `rlProcessDMAStructArray` | `.al` | 8/8 | yes |
| $80/A5E9 | `rlDecompressByList` | `.al` | 8/16 | yes |
| $80/AA02 | `rlDecompressor` | `.al` | 8/16 | yes |
| $82/8696 | `rlApplyCOLDATA0Intensity` | `.al` | 8/16 | yes |
| $82/C198 | `rlHDMAArrayEngineProcessHDMAArray` | `.al` | 8/16 | yes |
| $86/BF65 | `rsCheckIfTileCloserToTarget` | `.al` | 8/16 | yes |
| $87/B505 | `rsEventMovementWriteToMovementScriptBuffer` | `.al` | 8/16 | **no** |

- So: `$01` code, `$02` data, `$04` jump target, `$08` subroutine entry, `$10` 8-bit X, `$20` 8-bit A.

| Bytes | In the log | Built | Not built |
|---|---|---|---|
| Executed | 203,080 | 153,128 | **49,952** |
| Read only | 970,847 | 65,963 | 904,884 |
| Untouched | 3,020,377 | 644,813 | 2,375,564 |

### Executed code that is not built

49,952 bytes. Nothing in the build calls them directly (the tracer checks that); they are reached through pointers, computed jumps and other unbuilt code.

| Bank | Bytes | Entry points |
|---|---|---|
| `$96` | 9,022 | 404 |
| `$80` | 8,209 | 218 |
| `$95` | 7,731 | 387 |
| `$8A` | 6,366 | 228 |
| `$85` | 4,581 | 240 |
| `$89` | 4,063 | 110 |
| `$9F` | 2,377 | 125 |
| `$8B` | 1,977 | 101 |
| `$91` | 1,870 | 99 |
| `$9B` | 1,567 | 92 |
| `$88` | 1,274 | 48 |
| `$9E` | 489 | 31 |
| `$82` | 140 | 13 |
| `$87` | 112 | 7 |
| `$86` | 96 | 6 |
| `$81` | 64 | 4 |
| `$97` | 13 | 1 |
| `$8D` | 1 | 1 |

469 runs (gaps of up to 16 bytes merged). The largest:

| Start | End | Executed bytes | Entry widths A/X | After |
|---|---|---|---|---|
| $80/BB9B | $80/BEEE | 700 | 16/16 | `rlUnknown80BB5D`+$3E |
| $80/BF01 | $80/C161 | 595 | 16/16 | `rlUnknown80BB5D`+$3A4 |
| $80/C3E6 | $80/C5F7 | 477 | 16/16 | `rsUnknown80C39A`+$4C |
| $80/C628 | $80/CA24 | 934 | 16/16 | `rsUnknown80C39A`+$28E |
| $80/CD2E | $80/CF02 | 408 | 16/16 | `rlUnknown80CC35`+$F9 |
| $80/D435 | $80/D661 | 548 | 16/16 | `rlUnknown80D143`+$2F2 |
| $80/D915 | $80/DB73 | 563 | 16/16 | `rlUnknown80D143`+$7D2 |
| $80/E598 | $80/E72D | 367 | 16/16 | `rsUnknown80E54D`+$4B |
| $85/C0E2 | $85/C3C4 | 709 | 16/16 | `rlUnknown85C0D5`+$D |
| $85/C55B | $85/C79B | 557 | 16/16 | `rlUnknown85C4E0`+$7B |
| $89/9702 | $89/98D3 | 443 | 16/16 | `rsUnknown8994B8`+$24A |
| $8A/80A6 | $8A/83CA | 745 | 16/16 | `rlUnknown8A8061`+$45 |
| $8A/8D6C | $8A/8F55 | 410 | 16/16 | `rsUnknown8A889A`+$4D2 |
| $8A/BB3E | $8A/BE48 | 743 | 16/16 | `PortraitPaletteF7PortraitPalettePointersEntry`+$78 |
| $8A/ECEF | $8A/EE7E | 361 | 16/16 | `rlUnknown8AE2F8`+$9F7 |
| $8A/FA34 | $8A/FBC7 | 379 | 16/16 | `rlUnknown8AE2F8`+$173C |
| $8B/9451 | $8B/96CE | 618 | 16/16 | `rlUnknown8B9275`+$1DC |
| $91/E583 | $91/E769 | 442 | 16/16 | `rlUnknown91E565`+$1E |
| $95/8000 | $95/82BD | 702 | 16/16 | `aUnifiedThraciaMapHighlightTilemap`+$11662 |
| $95/8588 | $95/8726 | 400 | 16/16 | `rlUnknown9582D8`+$2B0 |
| $96/8008 | $96/83D0 | 849 | 16/16 | `rlUnknown95F967`+$86A1 |
| $96/84AC | $96/867C | 456 | 16/16 | `rlUnknown95F967`+$8B45 |
| $96/8F50 | $96/92F7 | 907 | 16/16 | `rlUnknown95F967`+$95E9 |
| $96/9CA1 | $96/9EC3 | 544 | 16/16 | `rlUnknown9698EF`+$3B2 |
| $9B/EEB4 | $9B/F178 | 709 | 16/16 | `rsUnknown9BED9D`+$117 |

### Raw pointers in built tables that lead to unbuilt code

Values written as numbers in `.long` (any bank) or `.word` (same bank, entry points only) directives whose target is executed code that is not built. Writing them as labels gives `tools/trace.py` new starting points.

| Table | Pointers to unbuilt code | Targets |
|---|---|---|
| `rlUnknown86B307` ($86/B307) | 9 | $86/B335, $86/B343, $86/B358, $86/B38F ... |
| `aMapMenuTypePointers` ($85/89B5) | 6 | $85/89F5, $85/8A6F, $85/8AD7, $85/8B51 ... |
| `aUnknown81AE02` ($81/AE02) | 2 | $81/AFF8, $81/B016 |
| `aUnknown81AFAE` ($81/AFAE) | 2 | $85/E8A8, $85/E8C9 |
| `aDialogueCustomWidthAdjustTable` ($91/A1A5) | 1 | $91/A3D9 |
| `aUnknown8AD9FE` ($8A/D9FE) | 1 | $8A/DCDD |
| `rlUnknown95EF54` ($95/EF54) | 1 | $95/8000 |

### Built code that is read as a table

Built instructions at the base of an indexed read (`lda table,x`, `lda long,x`, `jsr (table,x)`, ...) from executed code, where the log shows reads and no execution. These are tables that were disassembled as code. For `abs,x` reads the data bank is assumed to be the program bank.

| Table | Read by | Kind | Bytes read in first 64 |
|---|---|---|---|
| $88/9BB5 `rsUnknown889BB5` | $88/9B9C | long indexed | 22 |
| $89/9109 `rsUnknown899109` | $89/90F3 | long indexed | 15 |
| $89/A5D1 `rsUnknown89A5D1` | $89/A5BB, $89/A5C7 | long indexed | 20 |
| $89/C326 `rsUnknown89C326` | $89/C2DA, $89/C2F2 | jump table | 4 |
| $8A/87F3 `rsUnknown8A87F3` | $8A/87CF | jump table | 12 |
| $91/F7B7 `rlUnknown91F75F`+$58 | $91/F7AD | long indexed | 2 |
| $9F/8A6E `rlUnknown9F8A34`+$3A | $9F/8A69 | jump table | 6 |

### Built data that is executed

Bytes built as data directives that the log shows executed. "How entered" is the mark on the first executed byte; `pea` means an executed `pea #start-1` pushes it as a return address.

| Start | Bytes | Widths A/X | How entered | In |
|---|---|---|---|---|
| $80/8A4C | 30 | 16/16 | jump target | `rsUnknown808A35`+$17 |
| $80/8EE8 | 6 | 16/16 | `pea` at $80/8EF0 | `rlUnknown808E2D`+$BB |
| $80/91E7 | 13 | 16/8 | `pea` at $80/91D7 | `rlUnknown8091B3`+$34 |
| $84/F815 | 37 | 16/16 | subroutine entry | `rsUnknown84F7F5`+$20 |
| $84/F844 | 46 | 16/16 | jump target | `rsUnknown84F7F5`+$4F |
| $84/F876 | 19 | 16/16 | jump target | `rsUnknown84F7F5`+$81 |
| $85/CB36 | 26 | 16/16 | jump target | `rlProcUnknown85CA85Cycle2`+$3A |
| $87/9DD1 | 107 | 16/16 | subroutine entry | `aUnknown879D77`+$5A |
| $88/8ABE | 24 | 16/16 | subroutine entry | `rsUnknown888A93`+$2B |
| $88/8ADD | 24 | 16/16 | subroutine entry | `rsUnknown888A93`+$4A |
| $88/8B27 | 9 | 16/16 | jump target | `rsUnknown888A93`+$94 |
| $88/8B46 | 9 | 16/16 | jump target | `rsUnknown888A93`+$B3 |
| $88/B2A5 | 90 | 16/16 | subroutine entry | `rlUnknown88B249`+$5C |
| $88/B305 | 4 | 16/16 | jump target | `rlUnknown88B249`+$BC |
| $8A/E0D7 | 88 | 16/16 | subroutine entry | `aUnknown8AE0C7`+$10 |
| $95/A0A7 | 3 | 16/16 | falls through | `rlUnknown95A086`+$21 |
| $9B/FD8C | 63 | 16/16 | subroutine entry | `rlUnknown9BFD71`+$1B |
| $9E/88F9 | 1 | 16/16 | subroutine entry | `aUnknown9E88F4`+$5 |
| $9E/B4A9 | 12 | 16/16 | jump target | `rlUnknown9EB491`+$18 |
| $9F/8080 | 1 | 16/16 | `pea` at $9F/807A | `rlProcUnknown9F805DCycle`+$1B |

### Code read as data in bulk

Runs of data reads of at least 8 bytes over code (executed or built as instructions). Dummy reads are shorter, so these are deliberate reads: checksums, copies to RAM, or tables that were disassembled as code.

| Start | End | Bytes | Executed | Built as code | Built | In |
|---|---|---|---|---|---|---|
| $80/8D56 | $80/8E2D | 216 | 198 | 1 | 1 | `rsUnknown808C50`+$106 |
| $80/D64A | $80/D817 | 462 | 24 | 0 | 0 | `rlUnknown80D143`+$507 |
| $82/8888 | $82/890D | 134 | 1 | 114 | 132 | `rlProcUnknown828865Cycle`+$12 |
| $82/E7ED | $82/E7F6 | 10 | 10 | 10 | 10 | `rlLoadRAMStructDataByIndex`+$2E |
| $87/8017 | $87/80AA | 148 | 65 | 148 | 148 | `rlUnknown878017` |
| $88/8888 | $88/8AC7 | 576 | 528 | 566 | 576 | `rlUnknown8887EC`+$9C |
| $88/9BB5 | $88/9BBF | 11 | 0 | 11 | 11 | `rsUnknown889BB5` |
| $89/A5D1 | $89/A5E4 | 20 | 0 | 20 | 20 | `rsUnknown89A5D1` |
| $8A/87F3 | $8A/87FE | 12 | 0 | 12 | 12 | `rsUnknown8A87F3` |

### Routines whose first byte is only read

Built routines whose first byte is read but never executed. When the byte before it is a read data byte, a 16-bit read of the last entry of that table explains it and the routine is fine; otherwise look at it.

| Routine | Name | Previous byte is read data | Executed later |
|---|---|---|---|
| $81/89E1 | `rsUnknown8189E1` | yes | no |
| $82/88B2 | `rlUnknown8288B2` | no | no |
| $82/88F3 | `rlProcUnknown8288E9Init` | yes | no |
| $84/F1F0 | `rlGivePlayerItemIDToSelectedUnitsFirstItemSlot` | yes | no |
| $85/A004 | `rsUnknown85A004` | yes | yes |
| $86/9A92 | `rlGetChapterEventCounter` | yes | no |
| $87/8017 | `rlUnknown878017` | no | no |
| $88/9BB5 | `rsUnknown889BB5` | no | no |
| $89/9109 | `rsUnknown899109` | no | no |
| $89/A5D1 | `rsUnknown89A5D1` | no | no |
| $89/C326 | `rsUnknown89C326` | no | no |
| $8A/87F3 | `rsUnknown8A87F3` | no | no |
| $95/AC41 | `rlUnknown95AC41` | yes | no |
| $9E/80F2 | `rlUnknown9E80F2` | yes | no |

### Tables in include/Undisassembled.h

For each table, the gap up to the next label or built byte, and what the log read in it. The log only shows what the prologue read, so these are lower bounds; "From start" is the unbroken run of reads from the first byte.

| Table | Address | Gap | Bytes read | From start | Last read | Executed in gap |
|---|---|---|---|---|---|---|
| `aUnknown80D1AE` | $80/D1AE | $127D | $37B | $4 | +$1275 | 2242 |
| `aUnknown85BE87` | $85/BE87 | $240 | $0 | $0 | - | 13 |
| `aUnknown85C51B` | $85/C51B | $530 | $B4 | $30 | +$527 | 898 |
| `aUnknown879481` | $87/9481 | $8F6 | $23A | $0 | +$74F |  |
| `aUnknown889FC3` | $88/9FC3 | $168 | $1E | $3 | +$3E |  |
| `aUnknown88C83C` | $88/C83C | $16A | $6 | $0 | +$159 | 332 |
| `aUnknown88DEFC` | $88/DEFC | $90 | $34 | $0 | +$8F |  |
| `aUnknown898B88` | $89/8B88 | $1CD | $42 | $4 | +$1BC | 203 |
| `aUnknown899099` | $89/9099 | $41 | $24 | $24 | +$23 | 28 |
| `aUnknown89935F` | $89/935F | $159 | $0 | $0 | - | 330 |
| `aUnknown89A76C` | $89/A76C | $48D | $53 | $3 | +$39E |  |
| `aUnknown89AC56` | $89/AC56 | $78 | $D | $0 | +$6E |  |
| `aUnknown89BCE6` | $89/BCE6 | $1A | $0 | $0 | - |  |
| `aUnknown89C5C9` | $89/C5C9 | $130 | $B | $0 | +$1A |  |
| `aUnknown8A945E` | $8A/945E | $58 | $8 | $6 | +$9 |  |
| `aUnknown8A98C4` | $8A/98C4 | $117 | $4 | $0 | +$B | 224 |
| `aUnknown8A9D79` | $8A/9D79 | $13E | $7 | $0 | +$5E | 86 |
| `aUnknown8AA241` | $8A/A241 | $AC | $10 | $10 | +$F |  |
| `aUnknown8AA629` | $8A/A629 | $A1 | $4 | $0 | +$F |  |
| `aUnknown8ABFF3` | $8A/BFF3 | $E5D | $2D | $0 | +$463 | 873 |
| `aUnknown8BBED5` | $8B/BED5 | $118 | $18 | $6 | +$E7 |  |
| `aUnknown8BC0B0` | $8B/C0B0 | $40 | $4 | $0 | +$7 |  |
| `aUnknown8C9520` | $8C/9520 | $2E0 | $F0 | $E0 | +$1EF |  |
| `aUnknown8C9800` | $8C/9800 | $200 | $200 | $200 | +$1FF |  |
| `aUnknown8C9A00` | $8C/9A00 | $300 | $200 | $200 | +$1FF |  |
| `aUnknown8C9D00` | $8C/9D00 | $300 | $20 | $20 | +$1F |  |
| `aUnknown8CA000` | $8C/A000 | $3600 | $1028 | $0 | +$35FF |  |
| `aUnknown8CD600` | $8C/D600 | $600 | $400 | $0 | +$5FF |  |
| `aUnknown8CDCB0` | $8C/DCB0 | $150 | $150 | $150 | +$14F |  |
| `aUnknown8CDE20` | $8C/DE20 | $EE0 | $100 | $20 | +$1BF |  |
| `aUnknown8D9BF6` | $8D/9BF6 | $3BB | $4F | $2 | +$F8 |  |
| `aUnknown91D899` | $91/D899 | $12C | $2 | $0 | +$5 | 108 |
| `aUnknown91E4F3` | $91/E4F3 | $67 | $38 | $38 | +$37 | 47 |
| `aUnknown959894` | $95/9894 | $53 | $1 | $2 | +$0 | 82 |
| `aUnknownD77000` | $D7/7000 | $1000 | $1000 | $1000 | +$FFF |  |
| `aUnknownD95000` | $D9/5000 | $3944 | $2538 | $1800 | +$3943 |  |
| `aUnknown998944` | $99/8944 | $440 | $43 | $1 | +$C5 |  |
| `aUnknownDA7000` | $DA/7000 | $14883 | $9EE4 | $0 | +$10FFF |  |
| `aUnknownDBB883` | $DB/B883 | $23A1 | $B6 | $0 | +$217F |  |
| `aUnknownDE0000` | $DE/0000 | $6200 | $5780 | $1E80 | +$61FF |  |
| `aUnknownDE6200` | $DE/6200 | $1E0C | $20 | $20 | +$1F |  |
| `aUnknown9EA513` | $9E/A513 | $169 | $0 | $0 | - |  |
| `aUnknown9F80D9` | $9F/80D9 | $17A | $1B | $9 | +$104 |  |
| `aUnknown9F8724` | $9F/8724 | $1DC | $27 | $5 | +$11B |  |
| `aUnknownE00060` | $E0/0060 | $27DF | $536 | $0 | +$27BE |  |
| `aUnknownE0285D` | $E0/285D | $E57A3 | $191B3 | $5C | +$E5781 |  |
| `aUnknownF77C12` | $F7/7C12 | $883EE | $2B0EC | $4 | +$867BC |  |
