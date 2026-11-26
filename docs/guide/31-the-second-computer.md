# Chapter 31: The Second Computer

The SNES's sound is made by a second computer inside the console, the APU. It has its own CPU, a Sony SPC700, its own 64 KB of RAM, and a DSP that mixes eight voices, each playing a sample stored in that RAM in BRR, a compressed sample format of 9-byte blocks. The main CPU can't read or write the APU's RAM. The two computers share four one-byte **ports** (`$2140`-`$2143` on the main side): a byte written to port n on one side can be read from port n on the other. Everything the game does with sound goes through those four bytes.

The APU starts in a tiny boot program, its IPL ROM, that can only receive data and jump to it. The game sends it a sound driver, a program of about 7.6 KB that runs on the SPC700 for as long as the console is on, plays the music, and mixes the sound effects. After that, the main CPU's job is to send the driver short messages (play this effect, start the song just uploaded, fade out) and to upload the data each song needs: its sequence, its instruments, its samples. The driver itself is not disassembled in this project, so what it does with a message is known from how the game uses it.

This chapter covers booting the APU, the per-frame exchange of messages on the ports, uploading data, the sound scripts that songs are written as, how the music is chosen, and the sound data. The code is in [engine/sound/](../../engine/sound/); the data, from `$F7/7C00` to the end of the ROM, is in [audio/](../../audio/). The reference page is [sound.md](../reference/sound.md).

## Booting the second computer

`rlInitSound` runs at boot ([Chapter 26](26-the-frame.md)), and again on the anti-tamper screens. It sends the driver with `rlUploadToAPU`, which speaks the IPL ROM's protocol: blocks of a size, an SPC address, and bytes, sent one byte per handshake, ended by a size of 0 and the address to start at.

```rust
fn upload_to_apu(blocks: &[Block], start: u16) {    // rlUploadToAPU
    // writing $FE to port 0 while waiting reboots an active driver
    wait_until(port_word(0) == 0xBBAA);              // the IPL ROM is ready
    for block in blocks {
        port[2..4] = block.spc_address;
        port[1] = 1;                                 // "another block follows"
        port[0] = next_counter();                    // ... and wait for the echo
        for (i, byte) in block.bytes.iter().enumerate() {
            port[1] = *byte;
            port[0] = i as u8;                       // the counter is the handshake
            wait_until(port[0] == i as u8);          // the APU echoes it when it has the byte
        }
    }
    port[2..4] = start; port[1] = 0;                 // "run from here"
    port[0] = next_counter();
}
```

The driver is five blocks: `$0200` (175 bytes), `$0660` (5,448), `$1BC0` (1,945), and two small ones at `$C502` and `$FF80`. It starts at `$0200`. Its ID text in the ROM is `"ELM SND1960327W"`. Once it runs, `rlInitSound` sends one upload list through the driver's own loader (below), the data every song needs.

## Messages

Each frame, every VBlank routine calls `rlSendSoundQueuesToAPU`, even on a lag frame. It uses the ports as two mailboxes going in and two status bytes coming out:

| Port | Direction | Carries |
|---|---|---|
| 0–1 | to the APU (16-bit write) | a sound effect or command on port 0, and its argument byte on port 1 |
| 2–3 | to the APU (16-bit write) | a second stream of sound effects on port 2, and volume/panning on port 3 |
| 1 | from the APU | a value the game compares with the chunk it last decompressed |
| 3 | from the APU | status bits: a song is playing, a fade is under way, mono is on |

The handshake on ports 0 and 2 is an echo. The game writes its current 16-bit value to the port pair every frame. When the driver has taken it, the driver writes the low byte back on its side of port 0 or 2; the game sees the echo, takes the next value off its queue, and writes that one. Because the APU ports are bidirectional latches, outgoing writes on ports 1 and 3 do not overwrite the driver's incoming values.

```rust
fn send_sound_queues_to_apu() {                        // rlSendSoundQueuesToAPU
    if bAPUUploading != 0 { return; }                  // the ports are busy with an upload
    bAPUPort1 = read_stable(1);
    if read_stable(0) == wSoundEffectCurrent as u8 {   // echoed: the APU has it
        wSoundEffectCurrent = aSoundEffectQueue.pop_front().unwrap_or(0);
    }
    port_word(0) = wSoundEffectCurrent;                // ports 0 and 1
    bAPUStatus = read_stable(3);
    if read_stable(2) == wSoundEffect2Current as u8 {
        wSoundEffect2Current = aSoundEffect2Queue.pop_front().unwrap_or(0);
    }
    port_word(2) = wSoundEffect2Current;               // ports 2 and 3
}
```

`read_stable` reads a port until two reads agree, since the APU may be writing it at that moment. Each mailbox carries at most one new message a frame. This is **message passing** between two processors that share no memory: neither waits for the other, the queue absorbs bursts, and the echo is the acknowledgment. Each queue holds four messages, and a fifth overwrites the fourth.

Code adds to the queues through a few routines. `rlPlaySoundEffect` (297 calls) queues on port 0, unless an upload is running or the sound effects are turned off; menus play `$06` for the cursor, `$08` to confirm, and `$21` to cancel. `rlPlaySoundEffect2` (47 calls) queues on port 2 and is the battle animations' channel. `rlSendSoundCommand` and `rlQueueSoundCommand` queue commands on port 0. Values from `$C0` up are commands to the driver, and their uses show what they do:

| Command | Does |
|---|---|
| `$C8`-`$CD` | start the song just uploaded |
| `$C0` | stop the song |
| `$E0` | fade the music out: before a battle scene, a level-up, the phase change, game over |
| `$E1` | the fade over to the victory theme |
| `$F7`, `$E8` | lower the music, and raise it again: around a map battle, the gold pop-up, the castle |
| `$F2`, `$F3` | mono, stereo |

## Uploading data

The driver keeps a fixed layout in SPC RAM, and the songs' data is uploaded into it:

```
SPC RAM
$0000 ┌───────────────────────┐
      │ driver ($0200-...)    │
      │ samples (BRR)         │  placed one after another by the upload lists
      │   ...                 │
$C500 │ song sequence         │  (a few songs use $B500, $BC00, $D400)
      │   ...                 │
$FD00 │ sample directory      │  (start, loop) per sample; the DSP's DIR register = $FD
$FE00 │ instrument table      │  6 bytes per instrument: a sample number, ADSR, ...
$FF50 │ small blocks          │
$FFFF └───────────────────────┘
```

Data is cut into **chunks**, each an entry in a chunk table of 773 (`aSoundChunks`): its address in ROM, its size, the SPC address to load it to (0 for right after the previous chunk), and whether it is compressed. An **upload list** names chunks in order, with a few commands mixed in, such as one that sets the SPC address for what follows. `rlRunSoundUploadList` sends a list through the driver's own loader, which takes two bytes per handshake on ports 2 and 3 where the IPL ROM took one. While it runs, `bAPUUploading` holds the mode value (`$FA`-`$FD`) it sent on port 0 to start the upload, and the message queues wait.

The upload code avoids sending what the APU already has, in two places:

- **Compressed chunks** (the 112 song sequences) are unpacked into one of two work RAM buffers before the upload ([Chapter 30](30-getting-graphics-in.md)). The buffer remembers which chunk it holds, and the same chunk isn't unpacked twice.
- **Indirect uploads.** A list can name, instead of a chunk, an indirect list, one of 68 shared lists such as a set of instruments and their samples. If the same indirect list was the last one sent, it is skipped: two songs that share an instrument set don't send it twice in a row.

Four of the indirect IDs depend on the battle being shown. IDs 1 and 2 read the defender's and the attacker's weapon from the battle's action structs ([Chapter 6](06-resolving-a-battle.md)) and pick an upload list for that weapon. IDs 3 and 4 read the two units' classes and pick a list by class and by the terrain each unit stands on. The battle songs' upload lists end with these four, so starting a battle's music also sends the sounds for those two weapons and those two classes on that terrain, and no others.

## Songs are scripts

A song number, from 1 to 160, names a **sound script** (`aSoundScripts`). A script is a list of words: the top six bits of a word are a command, the next word its argument, and the low ten bits a number of frames to wait afterwards. Code plays a song by writing its number to `wMusicID`. At the end of every VBlank routine, `rlUpdateSound` steps the script:

```rust
fn step_sound_script() {                         // rsStepSoundScript, channel 0
    if wMusicID == 0 { return; }
    if wMusicID != aSoundScriptRunning {         // a new request: start from the top
        aSoundScriptRunning = wMusicID;
        pos = aSoundScripts[wMusicID - 1];
        wait = 1;
    }
    wait -= 1;
    if wait != 0 { return; }
    loop {
        let mut word = script[pos];
        if word == 0 {                           // the end
            aSoundScriptPrevious = wMusicID;     // the song now playing
            wMusicID = 0; aSoundScriptRunning = 0;
            return;
        }
        let cmd = word >> 10;
        if cmd != 0 {
            let arg = script[pos + 1];
            if run_command(cmd, arg) == Retry {  // backs up pos and waits 1 frame
                wait = 1;
                return;
            }
        }
        if word & 0x3FF != 0 { wait = word & 0x3FF; return; }
    }
}
```

`wMusicID` is therefore a request. It goes back to 0 once the script has run, and the song plays on in the APU. Code that needs to know the new song has started waits for `wMusicID` to read 0, and `aSoundScriptPrevious` records which song it was.

Nearly every song's script is the same two commands:

```
aSoundScriptF7988A                       ; song $04, the Jugdral history
  .word $2C00, <>aSoundUploadF7A68C      ; command 11: leave this upload list for the main loop
  .word $4400, $00C8                     ; command 17: when no upload is waiting, queue $C8
  .word $0000
```

Command 11 doesn't upload anything itself. It leaves the list in `wSoundDeferredUpload`, and the main loop's `rlRunDeferredSoundUpload` sends it ([Chapter 26](26-the-frame.md)). An upload is a busy loop of thousands of handshakes; in the main loop, the VBlank interrupts it every frame and the game keeps running. Command 17 then waits, a frame at a time, until the deferred upload has gone, and queues the start command. Scripts use command 11 141 times and command 17 124 times. The commands that would upload at once, inside VBlank (7-10), exist and are never used.

The other commands play effects, send commands, wait on a status bit, and pick a sound by the battle's terrain. The engine has a second script channel, `wSoundScript1ID`, which nothing ever sets. [audio/SONGS.md](../../audio/SONGS.md) lists every script with where the game asks for it: in code, in event scripts (`PLAY_SONG`, [Chapter 12](12-screenplays.md)), in dialogue (`DIALOGUE_PLAY_SONG`, [Chapter 13](13-dialogue-and-text.md)), and in the debug menu's sound test.

## Choosing the music

Which song a phase gets is decided on the map ([Chapter 8](08-the-turn.md)): the chapter's player-phase song or the victory theme, an enemy army's song by its name (53 names share 11 songs), the allied or neutral phase song. `rlStartPhaseMusic` stores the choice in `wPhaseSongID` and writes it to `wMusicID`. After an event or another screen, `rlResumePhaseMusic` writes it again, unless status bit 1 says a song is playing and `aSoundScriptPrevious` says it is that one.

When the last enemy falls in the middle of a phase, `rlCheckVictoryTheme` makes the victory theme the phase song and starts `procFadeOutAndChangeSong` ([Chapter 28](28-procs.md)). The proc sends `$E1`, waits until `wMusicID` is 0 and the fade bits of the status byte are clear, writes the new song to `wMusicID`, and ends when that request reads 0.

The options menu's sound setting ([Chapter 25](25-full-screen-windows-and-the-status-screen.md)) sets two bits of `bSoundFlags`. `rlUpdateSound` notices when they change and sends `$F2` or `$F3` for mono or stereo. Turning the sound off sends `$F8` if a song is playing and drops song-start commands (`$C8`-`$DF`) from then on, but it keeps the sound effects. Turning it back on resends the last song-start command from `$CB` to `$CD`.

## The data

The sound data runs from `aSoundHeader` at `$F7/7C00` to the end of the ROM, 558,080 bytes. The header points at the driver, the scripts, the upload lists, the chunk table, and the battle tables. All pointers are relative to the header's bank, and the data is read straight across bank boundaries. [tools/sound.py](../../tools/sound.py) extracts it into files, and [tools/sound_kinds.py](../../tools/sound_kinds.py) classifies the 723 distinct chunks shared across the 773-entry table (720 reached by uploads, plus three unreached) by replaying every upload into an image of SPC RAM and checking where each chunk lands:

| Kind | Chunks | Where in SPC RAM |
|---|---|---|
| samples | 158 | wherever the list places them; 380,466 bytes (~372 KB) of BRR in all |
| sequences | 112 | `$C500` and three other addresses; compressed in ROM |
| sample directories | 210 | `$FD00` |
| instrument tables | 122 | `$FE00` |
| other | 118 | small blocks near the top of RAM, three at `$2380` |

A sequence is a list of patterns, each holding eight track pointers, one per voice. The build recompresses an edited sequence. A sample can be replaced, but the directory entries hold fixed SPC addresses, so a sample of a different length moves every sample after it and their entries must be changed to match ([audio/README.md](../../audio/README.md)).

## Trade-offs and hard limits

- **One message a frame per mailbox.** A burst of sound effects is spread over several frames by the queue, and a fifth waiting message overwrites the fourth.
- **Silence during uploads.** While a list is sent, the queues hold back and new sound effects are dropped.
- **One deferred upload at a time.** A second song request waits until the first song's upload has gone.
- **A fixed SPC RAM layout.** The directory, the instruments, and the sequences have fixed addresses in the driver.
- **A black box.** The driver isn't disassembled, so the meaning of each command, of the four upload modes, and of the status bits rests on how the game uses them.

## Where it lives in the source

- [engine/sound/driver.asm](../../engine/sound/driver.asm): `rlInitSound`, the queues and `rlSendSoundQueuesToAPU`, `rlUploadToAPU`, `rlRunSoundUploadList`, the indirect uploads, `rlUpdateSound` and the script commands, `rlRunDeferredSoundUpload`.
- [engine/sound/music.asm](../../engine/sound/music.asm): the phase songs, the victory theme, `rlResumePhaseMusic`, `procFadeOutAndChangeSong`.
- [engine/core/options.asm](../../engine/core/options.asm): `rlApplySoundOption`.
- [include/Sound.h](../../include/Sound.h): the chunk flags and the `SONG_*` numbers.
- [audio/](../../audio/): the driver blocks, samples, sequences, directories, instruments, and [sound_data.asm](../../audio/sound_data.asm) with the scripts and lists.
- [tools/sound.py](../../tools/sound.py), [tools/sound_kinds.py](../../tools/sound_kinds.py), [tools/songs.py](../../tools/songs.py).
- [docs/reference/sound.md](../reference/sound.md): the reference page.

---

← Previous: [Chapter 30: Getting Graphics In](30-getting-graphics-in.md) | [Contents](OUTLINE.md) | Next: [Interlude: One Frame on the Map](interlude-one-frame-on-the-map.md) →
