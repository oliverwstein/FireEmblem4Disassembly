# Chapter 13: Dialogue and text

The game's words are 1,986 **texts**: conversations, narration, death quotes, shopkeepers' lines, and the names of characters, classes, items, and castles. Each is a byte string in a small markup language. Bytes from `$10` up are characters; bytes below `$10` are commands that end a line, switch speakers, wait for a button, load a portrait, or open a box. One interpreter, the **dialogue engine**, reads a text one step per frame and draws it a character at a time in a proportional font of 1,280 glyphs.

The engine keeps its state in one block of low RAM, `aDialogue`, so only one text runs at a time. It draws into two **slots**, one per speaker, and what a slot looks like on screen depends on the **mode** the text was started in: a box over the map, a window on the full-screen conversation scene, a shopkeeper's box, or bare text on whatever screen asked for it. The engine doesn't run itself. Whatever started the text calls it once per frame, usually from a proc ([Chapter 28](OUTLINE.md)), until it reports that the text has ended.

Menus have a second, simpler text renderer. Menu strings are stored as Shift-JIS, every character is 8 pixels wide, and a whole string is written into a tilemap at once. This chapter covers the text format and its build, the font, how a character is drawn, pacing and buttons, lines and scrolling, the four modes and the procs that host them, portraits, inserted text, menu text, and the costs.

## Texts as data

The texts live in [text/dialogue/](../../text/dialogue/), one file each, grouped by where they are used:

| Group | Texts |
|---|---|
| Chapter scenes, Prologue to Final | 822 |
| Epilogue and its world map | 429 |
| Names: items (110), classes (71), characters (63), castles (46) | 290 |
| Death quotes | 187 |
| Lovers' home castle visits | 130 |
| Shops and other keepers | 79 |
| Attract-mode battles, battle scene, opening, debug | 49 |

A source file is plain Japanese with commands in braces. Chapter 1's talk between Quan and Ayra begins:

```
{DIALOGUE_LEFT}{DIALOGUE_OPEN_BOX}{DIALOGUE_LOAD_PORTRAIT PortraitQuan}
{DIALOGUE_RIGHT}{DIALOGUE_OPEN_BOX}{DIALOGUE_LOAD_PORTRAIT PortraitAyra}
{DIALOGUE_LEFT}{DIALOGUE_FONT_0}きみがイザークのアイラ王女か{DIALOGUE_NL}
シグルドから話はきいた{DIALOGUE_NL}
私はレンスターのキュアンだ{DIALOGUE_RIGHT}{DIALOGUE_PAUSE 16}{DIALOGUE_FONT_0}･･･よろしくたのむ{DIALOGUE_NL}
{DIALOGUE_WAIT_PRESS}
{DIALOGUE_LEFT}{DIALOGUE_SCROLL_ALL}{DIALOGUE_FONT_0}
```

Each speaker gets a box and a portrait, Quan speaks three lines on the left, and Ayra answers on the right after 16 frames. Only then does the text wait for the player. A conversation fills both boxes before each button press; the pair `DIALOGUE_RIGHT` + `DIALOGUE_PAUSE 16` appears 1,359 times.

The font has more glyphs than one byte can name, so it is split into six **pages** of 240, and a page command (`DIALOGUE_FONT_0` to `_5`) chooses the page that later character bytes index. Writers don't place these. The build runs [tools/process_dialogue.py](../../tools/process_dialogue.py) over each source file, which looks every character up in the font list ([DialogueFont.txt](../../text/dialogue/DialogueFont.txt)) and inserts a page command wherever the page changes. The first line above becomes:

```
DIALOGUE_FONT_0
.text "きみがイザークのアイラ"
DIALOGUE_FONT_1
.text "王女"
DIALOGUE_FONT_0
.text "か"
```

The generated `.dialogue.txt` files are assembled with six 64tass encodings (`DialoguePage0` to `DialoguePage5`, [text/dialogue/Dialogue.h](../../text/dialogue/Dialogue.h)), one per page. The generated texts hold 46,346 page commands, a byte each.

### The command set

A command byte below `$10` is a one-byte command. `$00` is an escape: the next byte is the command number, so every command can be written as two bytes, and the ones above `$0F` can only be written that way. A command number with bit 7 set is handed to the world map's own command table, for its narration ([Chapter 19](OUTLINE.md)). The handlers are in `aDialogueCommandPointers`; the macros are in [include/Dialogue.h](../../include/Dialogue.h). The counts below are uses in the source texts:

| Family | Commands (uses) |
|---|---|
| Layout | `DIALOGUE_NL` (11,835), `DIALOGUE_SCROLL` (2,158), `DIALOGUE_SCROLL_ALL` (1,542), `DIALOGUE_CLEAR` (92) |
| Speakers and boxes | `DIALOGUE_RIGHT` (2,934), `DIALOGUE_LEFT` (2,698), `DIALOGUE_OPEN_BOX` (1,802), `DIALOGUE_CLOSE_BOX` (260) |
| Portraits | `DIALOGUE_LOAD_PORTRAIT` (1,676), `DIALOGUE_UNLOAD_PORTRAIT` (261), `DIALOGUE_LOAD_UNIT1_PORTRAIT` (93), `DIALOGUE_LOAD_UNIT2_PORTRAIT` (27) |
| Pacing | `DIALOGUE_WAIT_PRESS` (4,103), `DIALOGUE_PAUSE` (2,831), `DIALOGUE_SET_SPEED` (9) |
| Inserted text | `DIALOGUE_UNIT1_NAME` (221), `DIALOGUE_UNIT2_NAME` (173), `DIALOGUE_SET_TEXT` (172), `DIALOGUE_CHILD_NAME` (171), `DIALOGUE_NUMBER1` (20), and five more used under 15 times |
| Escapes | `DIALOGUE_ASMC` (237) |
| Sound | `DIALOGUE_PLAY_SONG` (34), `DIALOGUE_PLAY_SFX2B` (32), and two more |
| End | `DIALOGUE_EOF` (1,982) |

Sixteen of the commands appear in no text. Most of them set the engine's internals directly: the slot's tilemap position, display area, VRAM address, base and clear tiles, and status bits. Command numbers from `$41` to `$7F` have no handler, and the dispatcher meets them with an endless loop.

## Six pages of glyphs

The font holds 1,280 glyphs, each 16 × 16 pixels in two bits per pixel: 64 bytes, or 80 KB in all, filling banks `$92` and `$93` and half of `$94`. Page 0 has the kana, digits, punctuation, the letters A to S, and the numeral kanji 一 to 十. Page 1 opens with T to Z and a few symbols, and pages 1 to 5 hold the other 1,014 kanji. Page 5 has only 80 glyphs, which leaves room for 160 more. A character's glyph number is

```
glyph = page × 240 + (byte − $10)
```

and the same number indexes the width table, `aDialogueFontWidth` ([data/dialogue/DialogueFontWidth.asm](../../data/dialogue/DialogueFontWidth.asm)). Most glyphs are 12 pixels wide (784 of them) or 13 (265); the narrowest punctuation is 1 or 2.

Page 0 gets one more adjustment. When the current page is 0, the engine looks at the next character in the text and may draw the current one a pixel narrower. A following て, で, or ョ always tightens it (`aDialogueAdjustPriorCharacterWidth`). For any other following character, `aDialogueCustomWidthAdjustTable` points to a list of characters that tighten before it, and the current character loses a pixel if it is on the list. This is kerning by pairs, stored as one list per right-hand character.

## Drawing a character

### The frame

Each call to `rlRunDialogueCycle` advances the text by at most one character. `wPauseTimer` counts the frames to the next one. When it runs out, the engine runs commands until one asks to stop for the frame or a character is drawn:

```rust
fn run_dialogue_cycle() {                          // rlRunDialogueCycle
    if scroll_in_progress() { return finish_frame(); }   // rsDialogueStepAutoscroll
    if wPauseTimer == 0 { return finish_frame(); }       // the text has ended
    if wPauseTimer != FAST {
        // Start, A and B are handled here (see "Pace")
        if wStatus & WaitForInput { blink_caret(); return finish_frame(); }
        wPauseTimer -= 1;
        if wPauseTimer != 0 { return finish_frame(); }
    }
    shift_out_finished_cells();                    // rsDialogueHandleGraphicBufferClearing
    loop {
        let byte = text[0];
        if byte < 0x10 {
            if run_command() { break; }            // rsRunDialogueCommand; true: stop for this frame
        } else {
            draw_character(byte);                  // rsDialogueHandleCharacter
            if wPauseTimer != FAST { wPauseTimer = wTextSpeed; }
            break;
        }
    }
    finish_frame();   // mouth animation, upload drawn tiles and play the blip, rebuild the scroll HDMA table
}
```

Commands that change only state (a speaker switch, a page switch, an inserted name) return at once and the loop goes on. Commands that take time return "stop": a newline, a pause, a button wait, opening a box, loading a portrait.

Several of these take more than one frame. Opening a map box takes about ten, and loading a portrait five or six. Such a command keeps its own step counter in `wCommandCycle`, does one step, moves the text pointer back to its own first byte, and stops. The next frame runs the same command again at its next step, and the last step leaves the pointer past it. The event interpreter's retrying commands ([Chapter 12](12-screenplays.md)) work the same way.

### Glyphs into tiles

The SNES draws backgrounds from 8 × 8 tiles, and a proportional font doesn't line up with them. The engine composes text in a small buffer of 8 × 16-pixel **cells** (`aCharacterGraphicsBuffer`, 512 bytes, sixteen cells). Each cell is two tiles, one above the other. `wGraphicBufferPixelOffset` is the pen position in pixels from the left edge of the buffer's first cell.

To draw a glyph, `rsDialogueLoadCharacterGraphicIntoBuffer` reads its four tiles, shifts each row right by the pen's position within its cell (`offset & 7`), and ORs the result into the buffer, so a glyph that starts partway into a cell shares that cell with the previous one. Then the pen advances by the glyph's width:

```
pixel   0       8       16      24      32
        |-------|-------|-------|-------|
        [ あ  12 px ]
                    [ い  11 px ]
cells   0       1       2       3
```

After drawing, the engine writes tilemap entries for every cell the pen has touched into the slot's area of the BG3 tilemap buffer (`aBG3TilemapBuffer`), each cell as a tile above and the next tile below, and queues the touched part of the buffer for upload to the slot's tiles in VRAM. The upload happens during the next vertical blank ([Chapter 26](OUTLINE.md)).

Before the next character, `rsDialogueHandleGraphicBufferClearing` moves the finished cells out. If the pen has passed one or more whole cells, those cells are already in VRAM; the buffer shifts left by that many cells, the slot's tile and tilemap positions advance, and the pen keeps only its offset within the partly filled cell. The cell under the pen is uploaded again with each glyph that touches it.

## Pace: speed, pauses, and buttons

The message speed option has five settings, which `rsDialogueGetOptionsTextSpeed` turns into frames per character:

| Setting | 0 | 1 | 2 | 3 | 4 |
|---|---|---|---|---|---|
| Frames per character | 6 | 5 | 4 | 3 | 1 |

The formula is 6 − setting, and the fastest setting's 2 is replaced by 1. A text can override it with `DIALOGUE_SET_SPEED` (nine uses).

`DIALOGUE_PAUSE n` sets the timer to `n` frames and stops. The most common values are 16 (1,385 uses, almost all before a reply), 96 (608), and 32 (331). The epilogue's pages advance themselves: its 604 pauses of 96 frames stand where other texts wait for a button, and the epilogue sets the speed to six frames per character and `DialogueStatusPreventASpeedUp`, so the player can't hurry them. `DIALOGUE_WAIT_PRESS` stops the text with the wait bit set, and the caret beside the box blinks, light for 20 frames and dark for 12.

The buttons:

- **A or B** during a wait resumes the text. At any other time it sets the timer to `$FFFF`, which cuts short a running pause and draws one character every frame until the next pause or wait command sets the timer again. `DialogueStatusPreventASpeedUp` and `DialogueStatusPreventBSkipping` turn this off; the castle name pop-up sets both.
- **Start** ends the text. `rlAbortDialogueAndFreeBoxes` frees the boxes, empties the insert stack, and points the engine at a two-byte script holding only the end command, so the closing sequence runs as if the text had ended there. It doesn't apply in the keeper mode, while a song change is still running (`wMusicID` nonzero), with `DialogueStatusPreventASpeedUp` set, or while a multi-frame command is running.

Each frame that draws a character also plays the text sound chosen by `wTextSound`. The map boxes and the conversation screen set it to 1, sound effect 1. At the fastest speed or while fast-forwarding, the sound plays only on every fourth frame.

## Lines, slots, and scrolling

### Two slots

A text has two slots, `_Slot[0]` and `_Slot[1]`, and `DIALOGUE_LEFT` and `DIALOGUE_RIGHT` choose which one later characters go to. Each slot has its own tiles in VRAM, its own area of the BG3 tilemap, its own pen position, and its own portrait. On the map the two slots are the upper and lower boxes; on the conversation screen they are the left and right windows.

A map box's slot is 28 cells wide and six tile rows tall: three lines of 16 pixels. Its tiles are at VRAM `$8000` for the upper box and `$9000` for the lower, and its tilemap starts at row 2 or row 20 of BG3, three columns in. With glyphs 11 to 13 pixels wide, a line holds about 18 characters.

### Scrolling a line

`DIALOGUE_NL` moves the slot's tilemap position to the start of the next line, which wraps around the slot's three lines, and starts a scroll. The slot's `wScrollOffset` counts pixels scrolled; the newline adds 2, and on each later frame the scroll step adds 2 more until it reaches the next multiple of 16, stopping the text meanwhile. One line takes eight frames. Near the end of the scroll the line that comes next is cleared, ready to be written.

The scroll happens on screen through HDMA ([Chapter 29](OUTLINE.md)). Every frame, `rlDialogueUpdateHDMATable` rebuilds a table that sets BG3's scroll registers scanline by scanline. Rows outside the boxes get the ordinary scroll. Within a box, once `wScrollOffset` passes the box's last line, the table scrolls the box's rows up by the excess, so the text rises inside the box while the rest of BG3 stays still. The two boxes scroll independently. The engine keeps two copies of the table and alternates between them, so it never rewrites the one being displayed.

`DIALOGUE_SCROLL` scrolls the current slot's three lines out, one after another, and resets the slot to its first line. `DIALOGUE_SCROLL_ALL` does that to both slots. Together they appear 3,700 times, almost always right after a button wait: the player presses A, and the old lines scroll away before the next speaker begins. `DIALOGUE_CLEAR` blanks a slot at once.

## Four modes and their hosts

The mode, `aDialogue.wMode`, is given when a text is started (`rlDialogueStartText`). It decides what the box and portrait commands do:

| Mode | Constant | Boxes and portraits | Started by |
|---|---|---|---|
| 0 | `DIALOGUE_MODE_NONE` | none; the commands do nothing | castle name pop-ups, battle scene quotes, world map narration, the save menu |
| 1 | `DIALOGUE_MODE_MAP` | two boxes over the map, portraits drawn in them | the `DIALOGUE` event command, map battle quotes |
| 2 | `DIALOGUE_MODE_CONVERSATION` | the conversation screen's windows and portrait fades | `DIALOGUE_WITH_BG`, castle talks, the credits |
| 3 | `DIALOGUE_MODE_KEEPER` | a keeper's box; Start can't skip | shops, the arena, the augury, class change, the depot |

### Map dialogue

The `DIALOGUE` event command creates `procDialogue` as an event proc, so the script waits until it ends ([Chapter 12](12-screenplays.md)). Its init routine starts the text in mode 1 (`rlStartMapDialogue`) and copies the units the matching condition recorded (`wEventUnit1Pointer` and `wEventUnit2Pointer`, [Chapter 11](11-the-game-is-watching.md)) into `aDialogue.wUnit1` and `wUnit2`, with Sigurd standing in for a null pointer. Its cycles then run the scene:

| Cycles | Does |
|---|---|
| 1–2 | wait a frame; load the box graphics and palette |
| 3 | darken the map: color math subtracts a fixed color from the map layer and the sprites, raised by 1 every second frame up to 5 |
| 4 | each frame at full brightness, run the dialogue engine (`rlRunDialogueCycleAndSprites`) until the text ends |
| 5 | lower the subtracted color back to 0 |
| 6–11 | reload the menu font and icons, then free the proc |

The last step is there because the two slots' tiles at VRAM `$8000` and `$9000` sit on top of the menu font and icons, which the map's windows need.

The boxes are opened by the text itself. `DIALOGUE_OPEN_BOX` in mode 1 creates `procDialogueBox`, which draws a map window ([Chapter 10](10-menus-over-the-map.md)) on BG2 and unfolds it. An HDMA effect on BG2's vertical scroll shows a band of the box that grows taller over eight frames, while the window's tilemap widens by two columns a frame. The text waits on this through `wCommandCycle` and resumes when the HDMA reports it has finished. When the text ends, `rlRunDialogueEndSequence` pauses the map's sprite and tile animations, clears both portraits and BG3, folds the lower box and then the upper, waits for both to close, and resumes the animations. Only then does the engine report the text over.

### The other hosts

The conversation screen is a step of the castle screen ([Chapter 15](OUTLINE.md)): a full-screen background picture (`DIALOGUE_BG_*`) with a window on each side. `DIALOGUE_WITH_BG` reaches it by fading out the map and switching the main loop to the castle screen's conversation handler; when the text ends, the screen leaves for the map, the courtyard, the town, or an epilogue page, as `wConversationExitMode` says. In this mode `DIALOGUE_OPEN_BOX` opens a window, and the portrait commands start fade-in and fade-out procs instead of drawing tiles.

Keepers use mode 3. `rsSetupKeeperDialogueBox` gives the slot a 30 × 6 area and sets the speed to two frames per character, whatever the option says. Mode 0 draws text into a tilemap area its caller set up: the castle name pop-up gives slot 0 a 10 × 4 area, and the battle scene draws its quotes into its own layout.

## Portraits

In mode 1, `DIALOGUE_LOAD_PORTRAIT` takes several frames: it waits until no song change is running, decompresses the portrait, copies its 16 colors into background palette 6 (upper box) or 7 (lower box), uploads its 64 tiles to VRAM `$7000` or `$7800`, and writes its tilemap into the box. The face is 6 × 8 tiles, 48 × 64 pixels. The upper box's portrait is mirrored, with its columns reversed and the tiles' horizontal flip bit set, so the two speakers face each other. The other 16 of the 64 tiles hold mouth frames, which `rlUpdateDialoguePortraitOverlayTiles` swaps into the face's tilemap.

While a slot draws characters, its speaker's mouth moves. Every frame that draws a character other than ･ sets `wMouthTimer` to 15, and the mouth keeps moving while the timer is 8 or above, changing every eighth frame through the sequence in `aDialogueMouthAnimationFrames` (frames 0, 1, 2, 1, 0, 2, 1, 2, where 0 is closed). It closes about seven frames after the last character, so a speaker falls silent partway through the ･･･ that end so many lines.

### Children and substitutes

From Chapter 6 on, fourteen pairs of characters share their texts. Each child of the first generation has a substitute who joins in their place if the child was never born ([Chapter 17](OUTLINE.md)): Lester or Deimne, Arthur or Amid, Nanna or Jeanne. Every portrait command and the child name command pass their character through `rlDialogueTryGetActiveChildCharacterID`. If the character belongs to one of the pairs in `aDialogueChildrenCharacterIDs`, the routine finds whoever holds that pair's generation ID and returns them, and falls back to the substitute if no one does. Chapter 6's talk between Arthur and Seliph is written once:

```
{DIALOGUE_LEFT}{DIALOGUE_OPEN_BOX}{DIALOGUE_LOAD_PORTRAIT PortraitArthur}
...
私は{DIALOGUE_CHILD_NAME Arthur}､{DIALOGUE_NL}
シレジアから来ました{DIALOGUE_NL}
```

With Amid in the army, his portrait and name appear and every other word stays the same. The pair's lines can't differ; a scene that needs them to has to be split into separate texts chosen by an event.

## Inserting text

Names, numbers, and shared passages are texts of their own, spliced into the running text through a stack. A command that inserts text saves the current text pointer and starts the inserted text; the inserted text's end command pops the saved pointer instead of ending, and reading carries on after the command. The stack holds six pointers (`lActivePointerStack1` to `6`); a seventh insert is skipped, and the text goes on without it.

| Command | Inserts |
|---|---|
| `DIALOGUE_UNIT1_NAME`, `DIALOGUE_UNIT2_NAME` | the name of `wUnit1` or `wUnit2`, from `aDialogueCharacterNames` |
| `DIALOGUE_CHILD_NAME c` | the name of the child or substitute standing for `c` |
| `DIALOGUE_ITEM_NAME`, `DIALOGUE_CLASS_NAME` | the name of `wItemID` or `wClassID` |
| `DIALOGUE_NUMBER1`, `DIALOGUE_NUMBER2` | `wNumber1` or `wNumber2`, built as a text in RAM: digit glyphs without leading zeros, then the end byte |
| `DIALOGUE_SET_TEXT t` | the text at `t` |

The name tables are bounded. A character after Nanna in the ID order, or an item or class past the end of its table, gets the table's first entry.

`DIALOGUE_SET_TEXT` lets texts share passages. Chapter 4 has four versions of Daccar's reaction to the fall of Silesse, depending on whether Pamela and Lamia are alive. The one with both dead is a complete text; the other three are made from it and two short pieces:

```
; DaccarResponsePamelaAliveLamiaAlive
{DIALOGUE_SET_TEXT dialogueChapter04DaccarResponsePamelaDeadLamiaDead}{DIALOGUE_SCROLL}
{DIALOGUE_SET_TEXT dialogueChapter04Piece_LamiaChargeOrder}{DIALOGUE_SCROLL}
{DIALOGUE_SET_TEXT dialogueChapter04Piece_PamelaChargeOrder}{DIALOGUE_EOF}
```

The epilogue builds its pages this way: 122 of its texts insert pieces. `DIALOGUE_ASMC` calls a routine and goes on. The epilogue uses it to choose pieces at run time, and the lovers' home-castle visits use it to insert the waiting lover's name, with 様 (sama) added for Seliph and Leif.

### Death quotes

When a unit dies, `rlGetDeathQuote` picks its quote. A character in the lover table (`aLoverDeathQuotes`, 16 entries) whose lover is alive gets the lover quote, and the lover's ID goes into `wUnit1` for the quote to name. Ayra's:

```
{DIALOGUE_RIGHT}{DIALOGUE_OPEN_BOX}{DIALOGUE_LOAD_PORTRAIT PortraitAyra}{DIALOGUE_FONT_0}シャナン､元気でね･･･{DIALOGUE_NL}
････{DIALOGUE_UNIT1_NAME}､{DIALOGUE_NL}
また会いたいな･････{DIALOGUE_WAIT_PRESS}{DIALOGUE_EOF}
```

Everyone else is looked up in one of four tables, chosen by whether the unit is in the player's army slot and whether the chapter is before or after Chapter 6. A character with no entry gets a null pointer and no quote.

## Menu text

Menus draw text with a different renderer and a different encoding. Menu strings ([text/menutext/](../../text/menutext/), `include/MenuText.h`) are Shift-JIS, two bytes per character, ending in a zero word. `rlDrawMenuTextLine` writes a whole string into a map window's tilemap in one call. For each character it looks up two tiles, the top and bottom halves of an 8 × 16 cell, and writes them on two rows. Kana and symbols, with lead bytes `$81` to `$83`, are found by a table indexed by the two bytes. Kanji are found by a search of a 15-entry list, and the menu font has no others:

```
剣 庫 回 城 兵 大 書 杖 国 軍 帝 系 特 効 部
```

These are the kanji of the menu labels ("sword", "storage", "castle", "staff", "army", …). A character missing from both tables is drawn as the window's blank tile. Every menu character is one cell wide, and the string is on screen as soon as the tilemap is uploaded.

Two smaller helpers draw into BG3 directly. `rlDrawBG3TileRun` writes a run of consecutive two-row tiles, used by the full-screen windows for labels drawn as pictures ([Chapter 25](OUTLINE.md)), and `rlDrawMenuTextNumber` draws up to five digits.

The menu font (`gcHiraganaFont`, `$1800` bytes) lives at VRAM `$8000`, where the map dialogue slots draw. That is why each map conversation ends by decompressing it again.

## Trade-offs and hard limits

A text says where to wait and what to show, and the engine turns it into per-frame work: one character per tick of the timer, commands in between, and multi-frame commands that step back and run again. Writers never manage a timer. The cost is the same as for event scripts: nothing checks a text against the screen it will appear on. Neither the engine nor the build measures a line against the width of its box.

Drawing one character a frame keeps each frame's work small and fixed: one glyph ORed into a buffer, a few tilemap entries, and an upload of at most a few cells. The proportional font and the kerning cost a width lookup and a short list search per character.

Splitting the font into pages kept every character to one byte at the price of a page command at each change. Writers never see the page commands; the build adds them.

The limits:

- **One text at a time**: the engine's state is a single block.
- **1,280 glyphs** in six pages of 240; page 5 has room for 160 more.
- **Two slots**, three lines of 28 cells each in the map boxes.
- **Six nested inserts**; a seventh is skipped.
- **Command numbers `$41`–`$7F`** hang the game.
- **Names**: characters up to Nanna, items up to the broken holy staff, classes up to the dark prince; anything past gets the first entry.
- **Children's texts are shared** with their substitutes; only the portrait and the name change.
- **Menu text** has 15 kanji and a fixed width of 8 pixels.
- **Shared VRAM**: map dialogue draws over the menu font, which is reloaded after every map conversation.

## Where it lives in the source

- [engine/dialogue/dialogue.asm](../../engine/dialogue/dialogue.asm): the dialogue engine. `rlDialogueStartText`, `rlRunDialogueCycle`, glyph drawing (`rsDialogueLoadCharacterGraphicIntoBuffer`, `rsDialogueAdvancePixelOffset`, `rsDialogueAdjustCharacterWidthByNextCharacter`), the uploads, lines and scrolling (`rsDialogueAdvanceLine`, `rsDialogueStepAutoscroll`, `rlDialogueUpdateHDMATable`), `aDialogueCommandPointers` and every command, the insert stack, the end sequence, box and portrait commands, the mouth animation, and the width and kerning tables.
- [engine/dialogue/dialogue_procs.asm](../../engine/dialogue/dialogue_procs.asm): `procDialogue` and `rlStartMapDialogue`, `procDialogueWithBG` (the `DIALOGUE_WITH_BG` command), and the color math that darkens the map.
- [engine/dialogue/dialogue_box.asm](../../engine/dialogue/dialogue_box.asm): `procDialogueBox` and its folding and unfolding HDMA, the slot setup for the map boxes, and the portrait overlay tiles.
- [engine/dialogue/death_quotes.asm](../../engine/dialogue/death_quotes.asm): death quote selection, the child and substitute lookup (`rlDialogueTryGetActiveChildCharacterID`), and the pre-combat dialogue templates ([Chapter 12](12-screenplays.md)).
- [engine/dialogue/portraits.asm](../../engine/dialogue/portraits.asm) and [backgrounds.asm](../../engine/dialogue/backgrounds.asm): portrait decompression and the conversation backgrounds.
- [engine/castle/conversation.asm](../../engine/castle/conversation.asm): the conversation screen; [engine/castle/keepers.asm](../../engine/castle/keepers.asm): the keepers' box.
- [engine/menus/menu_text.asm](../../engine/menus/menu_text.asm): menu text (`rlDrawMenuTextLine`, `rlDrawBG3TileRun`, `rlDrawMenuTextNumber`) and the menu font loaders.
- [text/dialogue/](../../text/dialogue/): every text, the font list, and the page encodings; [tools/process_dialogue.py](../../tools/process_dialogue.py): the page-command pass; [data/dialogue/](../../data/dialogue/): the width tables and the name tables; [gfx/font/](../../gfx/font/): the dialogue font.
- [include/Dialogue.h](../../include/Dialogue.h): the commands, status bits, and modes; `aDialogue` is in [include/WRAM.h](../../include/WRAM.h).
- [docs/reference/dialogue.md](../reference/dialogue.md): the reference page.
