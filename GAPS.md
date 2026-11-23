# ROM bytes not built from source

Made by `tools/gaps.py` on 2026-11-23; do not edit. Every run of bytes the build still copies from
`fe4.sfc`, with the evidence of what it is. Classes, strongest evidence first:
`code` (a call or jump in the source targets it), `table` (built code reads it at its
first byte), `inside` (built code points into it, not at its start), `log` (read in
`fe4.cdl` only), `none` (no evidence). Addresses are given where the game reads them:
upper halves in banks `$80`-`$BF`, lower halves in `$C0`-`$FF`.

0 bytes in 0 runs: 0 runs of padding (0 bytes) and 0 pieces (0 bytes).

| Class | Pieces | Bytes | Read in the log |
|---|---|---|---|
| `code` | 0 | 0 | 0 |
| `table` | 0 | 0 | 0 |
| `inside` | 0 | 0 | 0 |
| `log` | 0 | 0 | 0 |
| `none` | 0 | 0 | 0 |

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

## `none` (0)

| Piece | Bytes | Log reads | Between | Evidence |
|---|---|---|---|---|
