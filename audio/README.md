# Sound data

Everything the sound code reads, from `aSoundHeader` (`$F7/7C00`) to the end of the ROM.
`tools/sound.py` writes it and describes every format; `tools/sound_kinds.py` proves what
each chunk is by replaying the uploads into SPC RAM; `tools/songs.py` writes
[SONGS.md](SONGS.md), where the game asks for each song.

| Path | What | Edit |
|---|---|---|
| `sound_data.asm` | Header, chunk table, song scripts, upload lists, tables; every pointer a label | Yes: lists and tables can grow |
| `driver/ADDR.bin` | The SPC700 driver, as the upload blocks it is sent in (ADDR = SPC address) | Not disassembled yet |
| `sequences/ID.bin` | Song sequence data, decompressed (SPC `$C500`; a few at `$B500`, `$BC00`, `$D400`): a list of patterns, each 8 track pointers | Yes: the build recompresses a changed file; `ID.bin.comp` is the original stream, kept while the file is unchanged |
| `samples/ID.brr` | BRR samples (9-byte blocks) | Yes |
| `directories/ID.bin` | Entries of the DSP sample directory at SPC `$FD00`: (start, loop) words | Yes |
| `instruments/ID.bin` | Instrument tables at SPC `$FE00`: 6 bytes each, a sample number, then ADSR and the rest | Yes |
| `chunks/ID.bin` | Chunks no test identifies yet (small blocks to `$FF50`-`$FFF8`, three to `$2380`) | Yes |

Files are named after the lowest chunk ID that uses them (`aSoundChunks` in
`sound_data.asm` lists every ID with its file's label). Sizes in the chunk table are the
files' lengths, so a longer file is uploaded whole. SPC addresses do not follow, though:
a chunk with SPC address 0 goes after the one before it, but the directory entries
(start, loop) are fixed SPC addresses, so when a sample changes length the entries of
the samples after it must be changed to match.
