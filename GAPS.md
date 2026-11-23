# ROM bytes not built from source

Made by `tools/gaps.py`; do not edit. Every run of bytes the build still copies from
`fe4.sfc`, with the evidence of what it is. Classes, strongest evidence first:
`code` (a call or jump in the source targets it), `table` (built code reads it at its
first byte), `inside` (built code points into it, not at its start), `log` (read in
`fe4.cdl` only), `none` (no evidence). Addresses are given where the game reads them:
upper halves in banks `$80`-`$BF`, lower halves in `$C0`-`$FF`.

80,164 bytes in 74 runs: 58 runs of padding (42,204 bytes) and 16 pieces (37,960 bytes).

| Class | Pieces | Bytes | Read in the log |
|---|---|---|---|
| `code` | 0 | 0 | 0 |
| `table` | 0 | 0 | 0 |
| `inside` | 0 | 0 | 0 |
| `log` | 0 | 0 | 0 |
| `none` | 16 | 37,960 | 0 |

## `code` (0)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|

## `table` (0)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|

## `inside` (0)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|

## `log` (0)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|

## `none` (16)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|
| $C0/3C05-$80/8001 | 17,405 | 0 | `gcUnknownC0365A` / `rlGetJoypadInput` | 99% $00/$FF |
| $81/EBBC-$81/FFFF | 5,188 | 0 | `aUNITGroupDataChapterFinalUnused` / `` | 92% $00/$FF |
| $82/90B0-$82/921D | 366 | 0 | `aProcEventFadeOutByTimerCode` / `procEventPause` |  |
| $82/EB77-$82/EC6F | 249 | 0 | `rlUnknown82EB4C` / `rlUnknown82EC70` |  |
| $91/B1FB-$91/B1FB | 1 | 0 | `aJugdralHistoryLineSteps` / `rsJugdralHistoryDrawEntry` |  |
| $96/BE68-$96/BFE4 | 381 | 0 | `rlUnknown96BE53` / `rlUnknown96BFE5` |  |
| $D9/6800-$D9/6BFF | 1,024 | 0 | `aUnknownD95000` / `gUnknownD96C00` |  |
| $D9/7400-$D9/793F | 1,344 | 0 | `gUnknownD96C00` / `gUnknownD97940` |  |
| $D9/7B00-$D9/7BFF | 256 | 0 | `gUnknownD97940` / `aUnknownD97C00` |  |
| $DA/45C0-$DA/64FF | 8,000 | 0 | `g4bppStandingMapSprites2` / `aUnknownDA6500` | 92% $00/$FF |
| $DA/6700-$DA/67FF | 256 | 0 | `aUnknownDA65B2` / `gUnknownDA6800` |  |
| $DA/6C80-$DA/6CFF | 128 | 0 | `gUnknownDA6A40` / `gUnknownDA6D00` |  |
| $DA/6F40-$DA/6FFF | 192 | 0 | `gUnknownDA6D00` / `aUnknownDA7000` |  |
| $DA/7800-$DA/79FF | 512 | 0 | `aUnknownDA7000` / `g4bppUnknownDA7A00` |  |
| $9E/E177-$9E/E227 | 177 | 0 | `rlUnknown9EE156` / `rlUnknown9EE228` |  |
| $9E/E2E4-$9E/EC94 | 2,481 | 0 | `rlUnknown9EE2D1` / `rlUnknown9EEC95` |  |
