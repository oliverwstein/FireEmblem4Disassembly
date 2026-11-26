# Chapter 21: Endings and Scores

When Julius falls at the end of the Final Chapter, up to 63 playable characters may be alive, dead, unrecruited, married, or represented by substitutes. The epilogue resolves every kingdom's ruler and supporting spouse without duplicating anyone, narrates their fates across the world map, gates the full credits behind the final rank, scrolls a campaign play record, grades the playthrough, and hides a 16-letter pairing password behind a 12-button secret code.

This chapter covers how endings are resolved, the epilogue's multi-part state machine, the four ranking formulas, the pairing password and secret code, and the hard limits.

## Resolving who gets which ending

Several characters can claim the same throne—`Shannan`, `Scathach`, or `Larcei` for Isaach; `Lewyn`'s son or daughter for Silesse; `Ares`, `Diarmuid`, or `Nanna` for Agustria—and a married woman who moves to her husband's kingdom must not also receive a standalone unmarried ending. `rlEvaluateEpilogueEndings` in [engine/epilogue/endings.asm](../../engine/epilogue/endings.asm) solves this in three passes:

### Pass 1: Snapshot states

`rsEpilogueGetParentsEpilogueStates` and `rsEpilogueGetChildrenEpilogueStates` build a 64-word table `aEpilogueUnitStates` (`$7F/C54A`, one word per `CharacterID 1..63`) and clear `aEpilogueUnitProcessedFlags` to `$FFFF`:

- **Bit 15 (`$8000`):** Dead or missing.
- **Bit 14 (`$4000`):** Unrecruited. For Generation 1, this reads the permanent flags `CharID + 40` and `CharID + 64` saved at the start of Chapter 6 by `rlSetParentsPermanentFlags` ([Chapter 17](17-love-and-lineage.md)); Generation 1 spouses are recovered from their children's `FatherID` and `MotherID` via a nine-child lookup table (one child per Generation 1 mother).
- **Bit 13 (`$2000`) + bits 0–7:** Married, with the partner's `CharacterID` in the low byte.
- **Bit 8 (`$0100`):** Has regional ruling priority.
- **Bit 9 (`$0200`):** Assigned as a supporting spouse.

### Pass 2: Priority walk

`rsEvaluateEpiloguePriorities` walks `aEpiloguePriorityList`, a table of `(Rule, CharacterOrFather, EpilogueID)` triples across 50 epilogue slots (`aEpilogueMainCharacters[50]` and `aEpilogueSupportingCharacters[50]`):

```rust
fn assign_epilogue_slot(char_id: u8, epilogue_id: usize, role_bits: u16, priority_taken: &mut bool) {
    if aEpilogueUnitStates[char_id] & 0x8000 != 0 { return; }          // dead or unrecruited
    if aEpilogueUnitProcessedFlags[char_id] >= 0 { return; }            // already assigned
    aEpilogueUnitStates[char_id] |= role_bits;
    aEpilogueUnitProcessedFlags[char_id] = epilogue_id as i16;
    if role_bits == 0x0200 {
        aEpilogueSupportingCharacters[epilogue_id] = char_id;
    } else {
        aEpilogueMainCharacters[epilogue_id] = char_id;
    }
    if role_bits == 0x0100 { *priority_taken = true; }                  // wR3 = 1
}
```

The list runs in three waves:

1. **Regional rulers and heirs (`EPrio_StartRegion`, `EPrio_FollowUp1/2`, `EPrio_Main`, and dynamic father rules):** `wR3` tracks whether anyone has claimed ruling priority in the current region. The first living unprocessed claimant sets `wR3 = 1` and bit `$0100`; subsequent candidates either take a non-priority slot or yield if `wR3` is set (for example, `Shannan` claims Isaach's ruling priority first, `Scathach` yields if `Shannan` rules, and `Larcei` steps in only if both are unavailable), while `EPrio_Main` covers `Julia` and the ten un-regioned men. Dynamic father rules (`Jamke`, `Lex`, `Claud`, `Azelle`, `Lewyn`) look up the father's son or daughter via `rlGetFatherUnitsChildrenRAMPointers`.
2. **Supporting spouses (`EPrio_Male_Lover`, `EPrio_Son_Lover`):** For every living male main character who is married, claims his wife into `aEpilogueSupportingCharacters[epilogue_id]` with bit `$0200`, marking her processed so she will not receive a separate ending.
3. **Remaining women (`EPrio_Daughter_Main_NoPriority`, `EPrio_Main`):** Any living woman still unprocessed—unmarried, or whose husband died—receives her own epilogue slot.

### Pass 3: Dialogue variants

`rsEvaluateEpilogueDialogueIDs` evaluates `aEpilogueDialogueIDEvaluationTable` across all 50 epilogue slots, dispatching through `aEpilogueDialogueIDRoutines` (checking support presence, whether a target partner or sibling is alive, regional priority, and `PermanentFlagChapterFinalArionDied` for Altena) to store a variant index (`0..5`) in `aEpilogueChosenDialogueID[50]`. Before leaving the throne room, `EventChapterFinalEnding.asm` invokes each region's `rlASMCSet*Epilogue` (`Belhalla`, `Isaach`, `NewThracia`, `Agustria`, `Verdane`, `Yngvi`, `Friege`, `Dozel`, `Edda`, `Velthomer`, `Chalphy`, `Silesse`) in [engine/epilogue/dialogue.asm](../../engine/epilogue/dialogue.asm) to play the farewell lines.

## Staging the epilogue screens

`rlStartEpilogue` ([engine/epilogue/epilogue_steps.asm](../../engine/epilogue/epilogue_steps.asm)) sets `wEpiloguePart = 0`, clears `wCurrentChapter = $FFFF`, and fades to `rsOpenEpilogueScreen` (game states `$36`/`$35`/`$37`, 19 steps in `aEpilogueStepRoutines`, with shared `EPILOGUE_STEP_FADE_OUT`/`_FADE_IN` steps 10–11 routing through `wNextMenuState`):

```
  Part 0: World Map Endings ──▶ Rank A (`0`) ──▶ Part 1: Full Credits ──┐
         (steps 5, 12)      └──▶ Ranks B–E    ──▶ FIN Screen (step 13) ──┼──▶ Part 2: Play Record ──▶ Ranking Screen ──▶ Secret Code (step 18)
```

| Part | Setup | Steps & behavior |
|---|---|---|
| **0, Endings** | `rlBeginEpilogueEndingsEvaluation` | Evaluates endings, then step 12 starts `aEventChapterEpilogueWorldMap` on the world map screen while step 5 (`rsEpilogueStepWorldMap`) runs every frame and draws three credits sprites (Start disabled); exits via `rlStartEpilogueCredits` |
| **1, Credits** | `rlSetupEpilogueCreditsDisplay` | **Rank A (`0`) only:** steps 2–4 scroll `dialogueEpilogueCredits8DC9A6` over two parallax backgrounds with six sprites (reusing `aWorldMapMarker`/`aWorldMapPortrait` RAM) and two HDMAs. **Ranks B–E (`1..4`):** jumps straight to step 13 (FIN end screen) with song `$5A`. Step 14 holds 2,880 frames (skippable after 256) and fades to Part 2 (sound `$E3` if rank `< 3`) |
| **2, Records** | `rlSetupEpilogueRankingsDisplay` | Steps 6–7 scroll the play record (`dialogueEpilogueCredits8DC9FF`); steps 15–18 show the ranking screen |
| **3, Character endings** | `rlStartEpilogueCharacterEndings` | Steps 8–9 cycle characters `25..63` through the castle conversation scene ([engine/epilogue/character_endings.asm](../../engine/epilogue/character_endings.asm)); unreachable except via debug handler `rsEpilogueDebugButtons2Unused` |

In Part 2, the **play record** (`rlSetUpEpilogueRecordTextWindow` in [engine/epilogue/records.asm](../../engine/epilogue/records.asm)) implements a loop inside dialogue: `rlASMCRecordTurnsPrologue`..`Final` and `rlASMCRecordTurnsTotal` right-align `aChapterTurncounts` into `DIALOGUE_NUMBER1`, and then `rlASMCRecordNextGeneration1Unit` and `...Generation2Unit` find the next recruited unit, push its name, `rlGetCharacterWinCount`, and `rlGetCharacterLossCount` (in gray if dead), and push a recursive ASMC call to themselves until the last character.

On the **ranking screen** (`rlShowEpilogueRankingScreen`), the engine draws all five grades, play time (`rlGetGameTimeHoursMinutes`), completion count + 1, and the 16-letter pairing password—then copies the bottom three rows (`$7E/8888`, `$C0` bytes) into `$7E/8088` and blanks them before uploading to VRAM. Step 16 waits 384 frames and DMAs row 0 (`$7E/8088` → VRAM `$D500`, play time and completions) into view; step 17 waits for the secret code.

## The ranking formulas

[engine/rankings/rankings.asm](../../engine/rankings/rankings.asm) grades the campaign on a `0..4` scale (`0` = A, `1` = B, `2` = C, `3` = D, `4` = E) using `rsEvaluateSpecifiedRankingScore`, which checks four `(min, max)` intervals and falls through to `4` (E):

| Category | Metric | A (`0`) | B (`1`) | C (`2`) | D (`3`) | E (`4`) |
|---|---|---|---|---|---|---|
| **Tactics** | Sum of 12 `aChapterTurncounts` (graded below), then `+ wDestroyedLocationsCount` added to the grade (clamped `<= 4`) | `1..399` | `400..549` | `550..799` | `800..1099` | `1100+` or `0` |
| **Survival** | `wTotalAlivePlayerUnitCount` (living `FS_Player` units at end of Ch 5 + Final) | `44..48` | `43` | `42` | `41` | `<= 40` |
| **Combat** | Sum of all 48 `aUnitLossesCount` bytes | `0..3` | `4..10` | `11..30` | `31..50` | `51+` |
| **Experience** | `wTotalLevelUpCount` | `1000..1440` | `800..999` | `600..799` | `400..599` | `< 400` or `> 1440` |

Every destroyed village (`wDestroyedLocationsCount`, incremented in `engine/map/map_actions.asm`) directly penalizes Tactics by one full grade. `rlSaveChapterTurncount` ([engine/events/event_engine.asm](../../engine/events/event_engine.asm)) records `wTotalAlivePlayerUnitCount` at the end of Chapter 5 and the Final Chapter (the practical maximum is 44: 20 Generation 1 survivors after Deirdre, Quan, Ethlyn, and Finn leave, plus 24 Generation 2 units).

`rlCalculateFinalRankingScore` averages all four grades, rounding half up:

```rust
fn final_ranking_score() -> u16 {                            // rlCalculateFinalRankingScore
    let sum = tactics() + survival() + combat() + experience();
    (sum + 2) >> 2                                          // three A's + one B -> (1 + 2) >> 2 = 0 (A)
}
```

## The hidden pairing password and secret code

During `rlEvaluateEpilogueEndings`, three routines encode the playthrough's pairings into a 16-letter uppercase string at `aEpiloguePairingPassword`:

1. **`rsCollectEpiloguePairingsForCode`:** Reads 16 four-bit partner IDs (`& $0F`)—7 Generation 1 mothers (`CharID $12..$18`, Lachesis–Brigid) and 9 Generation 2 women (`GenID 16..24`).
2. **`rsPackEpiloguePairingsChecksum`:** Packs the 16 nibbles into 8 bytes (`aEpiloguePackedPairings[0..7]`) and appends their 8-bit sum as byte 8.
3. **`rsEncodeEpiloguePassword`:** Adds `"FireEmblm"` (`aEpiloguePasswordKey`) byte-by-byte and encodes each 9-bit slice into two base-26 uppercase letters:

```rust
fn encode_epilogue_password(packed: &mut [u8; 9], out: &mut [u8; 16]) { // rsEncodeEpiloguePassword
    for i in 0..9 { packed[i] = packed[i].wrapping_add(b"FireEmblm"[i]); }
    for i in 0..8 {                                        // 8 × 9-bit slices across 72 bits
        let val = ((packed[i] as u16 | ((packed[i + 1] as u16) << 8)) >> i) & 0x01FF;
        out[i * 2]     = b'A' + (val / 26) as u8;
        out[i * 2 + 1] = b'A' + (val % 26) as u8;
    }
}
```

At step 17 on the ranking screen, `rlCheckEpilogueSecretCode` compares each new button press against `aEpilogueSecretCode` (**Select, Up, A, Down, B, Left, X, Right, Y, L, R, Start**), resetting `wEpilogueTimer` on any wrong press. Completing all 12 inputs DMAs `$7E/8108` (`$40` bytes) to VRAM `$D580`—revealing the 16-letter pairing password—and enters step 18 (`rsEpilogueStepEnd`), where the game rests permanently.

## Trade-offs and hard limits

Representing ending eligibility as a bitset and a data-driven priority table keeps multi-heir and marriage rules maintainable without sprawling conditionals, and writing the play record as self-pushing dialogue ASMCs lets it reuse the dialogue box's scrolling renderer intact. Maintaining turn counts, level-ups, alive counts, and SRAM loss counters incrementally during the campaign makes end-game grading instantaneous.

The limits:

- **50 epilogue slots** and **63 character state words** (`1..63`).
- **48 loss counters** and **12 chapter turn counts**.
- **4-bit lover nibbles** in the pairing password (`0` = unmarried, `1..15` = the 15 eligible men in each generation; nothing wraps in the game's cast, though a 16th husband ID would).

## Where it lives in the source

- [engine/epilogue/endings.asm](../../engine/epilogue/endings.asm): `rlSetParentsPermanentFlags`, `rlEvaluateEpilogueEndings`, `aEpiloguePriorityList`, `rsEvaluateEpilogueDialogueIDs`, and the pairing password encoder.
- [engine/epilogue/epilogue_steps.asm](../../engine/epilogue/epilogue_steps.asm): `rlStartEpilogue` and the 19 steps of `rlEpilogueStep`.
- [engine/epilogue/credits.asm](../../engine/epilogue/credits.asm), [records.asm](../../engine/epilogue/records.asm), [dialogue.asm](../../engine/epilogue/dialogue.asm), [movement.asm](../../engine/epilogue/movement.asm), [world_map.asm](../../engine/epilogue/world_map.asm), and [character_endings.asm](../../engine/epilogue/character_endings.asm): credits, play record, ranking screen, secret code, and world map epilogue.
- [engine/rankings/rankings.asm](../../engine/rankings/rankings.asm): the four category calculators and `rlCalculateFinalRankingScore`.
- [engine/events/event_engine.asm](../../engine/events/event_engine.asm): `rlSaveChapterTurncount`.
- [events/ChapterFinal/EventChapterFinalEnding.asm](../../events/ChapterFinal/EventChapterFinalEnding.asm) and [include/Epilogue.h](../../include/Epilogue.h): the final-chapter trigger and epilogue constants.
- [docs/reference/epilogue.md](../reference/epilogue.md) and [docs/reference/rankings.md](../reference/rankings.md): the reference pages.

---

← Previous: [Chapter 20: The Opening](20-the-opening.md) | [Contents](OUTLINE.md) | Next: [Chapter 22: A Map Bigger than the Screen](22-a-map-bigger-than-the-screen.md) →
