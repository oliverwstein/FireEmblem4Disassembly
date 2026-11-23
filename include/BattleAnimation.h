
  ; Battle animation frame data (data/battle_animation/), written by
  ; tools/battle_frames.py.
  ;
  ; Each entry of aBattleAnimationFrameTables points at a sequence data block
  ; and a frame table:
  ;
  ;   sequence data block: .word offset of the sequence index, offset of the
  ;     frame record list; the index (a word offset per sequence) and the list
  ;     (a word offset per frame record) follow, all offsets from the block
  ;     start. Sequences are two-byte steps read by rsBattleAnimationRunScript; a frame
  ;     record is a frame number and a structSpriteArray (rlBattleScenePushSprites).
  ;   frame table: a word offset per frame from the table start (the first
  ;     word / 2 is the count). A frame is a count byte and that many pairs of
  ;     words, an offset into the class sheet and a byte count, each filling
  ;     one 16-tile row of sprite VRAM (rsBattleAnimationQueueFrameRows).

  ; Where the extra tiles of entry 0 (no extra tiles) are copied from:
  ; rsBattleSceneLoadExtraTiles copies $C0 tiles from ANIM_NO_EXTRA_TILES_SOURCE
  ; without decompressing, and the table's own entry 0 names
  ; ANIM_NO_EXTRA_TILES_TABLE_SOURCE (never read: the routine skips it). Both are
  ; fixed addresses in bank $86 that hold event data in the released ROM, not
  ; tiles: placeholders, kept as numbers so that moving the events does not
  ; move them.

    ANIM_NO_EXTRA_TILES_SOURCE       = $86E000
    ANIM_NO_EXTRA_TILES_TABLE_SOURCE = $86E800

  ; Frame number of a record that keeps the tiles already loaded.

    ANIM_KEEP_TILES = $FF

  ; A frame record: its frame number, then the sprites (.structSpriteEntry),
  ; then ANIM_RECORD_END. The sprite count is worked out from the two.

    ANIM_RECORD .segment Frame
      .byte \Frame
      .word ((+) - * - 2) / size(structSpriteEntry)
    .endsegment

    ANIM_RECORD_END .segment
      +
    .endsegment

  ; A frame: ANIM_TILES, the rows (ANIM_TILE_ROW), then ANIM_TILES_END.

    ANIM_TILES .segment
      .byte ((+) - * - 1) / 4
    .endsegment

    ANIM_TILE_ROW .segment SheetOffset, Size
      .word \SheetOffset, \Size
    .endsegment

    ANIM_TILES_END .segment
      +
    .endsegment

  ; Sequence steps. Each is two bytes. rsBattleAnimationReadStep reads the first byte
  ; less 1, so the handlers in rsBattleAnimationRunScript compare with $FE and below.
  ; The step position is $0B21,x and the sequence start $0B1F,x.

  ; Show frame record Record (numbered from 0 in the block's list) for
  ; Duration frames, scaled by the speed in $0B15/$0B16 (rsBattleAnimationScaleDelay).

    ANIM_STEP .segment Record, Duration
      .byte \Record + 1, \Duration
    .endsegment

  ; Commands $E8-$FF. Where the handler's purpose is not known, the macro is
  ; named after the byte and the comment says what the handler does.

    ; $FF: stop the animation (clears $0AF3,x).
    ANIM_END .segment Arg=0
      .byte $FF, \Arg
    .endsegment

    ; $FE: stay on this step (clears bit 0 of $0AF3,x, does not advance).
    ANIM_HOLD .segment Arg=0
      .byte $FE, \Arg
    .endsegment

    ; $FD: go back to the start of the sequence (rsBattleAnimationCmdRestart).
    ANIM_RESTART .segment Arg=0
      .byte $FD, \Arg
    .endsegment

    ; $FC: go back Steps steps (at least 1; rsBattleAnimationCmdGoBack). Not used.
    ANIM_BACK .segment Steps
      .byte $FC, \Steps
    .endsegment

    ; $FB: wait Frames frames, scaled like a step (rsBattleAnimationCmdWait). Not used.
    ANIM_WAIT .segment Frames
      .byte $FB, \Frames
    .endsegment

    ; $FA: play sound effect Index of aBattleAnimationSoundEffects, at the
    ; combatant's position (rsBattleAnimationCmdPlaySound).
    ANIM_SOUND .segment Index
      .byte $FA, \Index
    .endsegment

    ; $F9: nothing (rsBattleAnimationCmdNothing). Not used.
    ANIM_NOP .segment Arg=0
      .byte $F9, \Arg
    .endsegment

    ; $F8: rsBattleAnimationCmdBroken runs into a brk (a bug), so it cannot be used.
    ANIM_CMD_F8 .segment Arg=0
      .byte $F8, \Arg
    .endsegment

    ; $F7: clear the combatant's busy bit (bit 2 of $0AF3,x; rsBattleAnimationCmdClearBusy).
    ; rlBattleAnimationStartSequence and rlUnknown95BA76 set it when they start a sequence and
    ; refuse to start another while it is set, and rsBattleSceneCheckRoundsOver waits until
    ; both combatants have it clear. Most sequences end ANIM_CLEAR_BUSY,
    ; ANIM_HOLD.
    ANIM_CLEAR_BUSY .segment Arg=0
      .byte $F7, \Arg
    .endsegment

    ; $F6: set the busy bit again (rsBattleAnimationCmdSetBusy). Not used.
    ANIM_SET_BUSY .segment Arg=0
      .byte $F6, \Arg
    .endsegment

    ; $F5: wait until $0C42 is set, then clear it (rsBattleAnimationCmdWaitForSignal). Not used.
    ANIM_CMD_F5 .segment Arg=0
      .byte $F5, \Arg
    .endsegment

    ; $F4: set bit 6 of $0AF3,x (which skips the move scripts of
    ; rsBattleAnimationApplyScriptStep) and go back Steps steps, at least 1 (rsBattleAnimationCmdFreezeAndGoBack).
    ANIM_CMD_F4 .segment Steps
      .byte $F4, \Steps
    .endsegment

    ; $F3: rlBattleAnimationSignalOther (rsBattleAnimationCmdSignalOther).
    ANIM_CMD_F3 .segment Arg=0
      .byte $F3, \Arg
    .endsegment

    ; $F2: rlUnknown95AAFF, then clear bits 0-1 of $0AF5,x; does not advance
    ; (rsUnknown95BE04). Not used.
    ANIM_CMD_F2 .segment Arg=0
      .byte $F2, \Arg
    .endsegment

    ; $F1: rlBattleSceneApplyStrike (rsBattleAnimationCmdApplyStrike).
    ANIM_CMD_F1 .segment Arg=0
      .byte $F1, \Arg
    .endsegment

    ; $F0: rlUnknown96DC7C and rlUnknown96BCEC (rsUnknown95BE26).
    ANIM_CMD_F0 .segment Arg=0
      .byte $F0, \Arg
    .endsegment

    ; $EF: Arg to rsUnknown95DCA3 (first combatant) or rsUnknown95DD4F
    ; (second), around calls of rlUnknown95DBDE (rsUnknown95BE39).
    ANIM_CMD_EF .segment Arg
      .byte $EF, \Arg
    .endsegment

    ; $EE: rlUnknown96F9BF, and rlBattleSceneQueueDodge for the other combatant if
    ; bit 3 of $0AE4 is set (rsUnknown95BEA4).
    ANIM_CMD_EE .segment Arg=0
      .byte $EE, \Arg
    .endsegment

    ; $ED: store Arg in bits 0-1 of $0AF5,x (rsBattleAnimationCmdSetVariant).
    ANIM_CMD_ED .segment Arg
      .byte $ED, \Arg
    .endsegment

    ; $EC: by Arg & 3, rlUnknown95D9BE, rlUnknown95D963, clear or set bit 7
    ; of $0AF4,x (rsUnknown95BEED).
    ANIM_CMD_EC .segment Arg
      .byte $EC, \Arg
    .endsegment

    ; $EB: set bit 6 of $0AF4,x (rsUnknown95BF4A).
    ANIM_CMD_EB .segment Arg=0
      .byte $EB, \Arg
    .endsegment

    ; $EA: clear bit 0 of $0AF3,x and go on (rsBattleAnimationCmdContinue). Not used.
    ANIM_CMD_EA .segment Arg=0
      .byte $EA, \Arg
    .endsegment

    ; $E9: rlBattleAnimationFaceOther (rsUnknown95BFA4).
    ANIM_CMD_E9 .segment Arg=0
      .byte $E9, \Arg
    .endsegment

    ; $E8: if $0B08,x is 0, rlBattleAnimationSignalSelf and set bit 6 of $0AF3,x; then
    ; set bit 6 of $0AF4,x (rsUnknown95BF61).
    ANIM_CMD_E8 .segment Arg=0
      .byte $E8, \Arg
    .endsegment

  ; The animation lookup (aBattleAnimationLookup, read by rlUnknown95A2C8).

  ; Weapon categories: the high nibble of an item's byte in the table at
  ; $99/83B9 (rlUnknown95A1ED). The ranged ones (Javelin; Hand Axe and
  ; Helswath) count only at wBattleDistance 2 or more, else they become the
  ; plain lance or axe. A combatant without one gets AnimCategoryAny, which
  ; matches any record of its class.

    AnimCategorySword       = 0
    AnimCategoryLance       = 1
    AnimCategoryAxe         = 2
    AnimCategoryBow         = 3
    AnimCategoryRangedSword = 4
    AnimCategoryRangedLance = 5
    AnimCategoryRangedAxe   = 6
    AnimCategoryMagic       = 7
    AnimCategoryStaff       = 8
    AnimCategoryAny         = 9

  ; A record's character: AnimAnyCharacter, or the low byte of a character ID.

    AnimAnyCharacter = 0

    ; Gender is the unit's, or the class default from the table at $99/847F
    ; when the unit's is Genderless (rlBattleSceneGetGender). The four IDs: the
    ; frames (aBattleAnimationFrameIndices), the sheet
    ; (aBattleAnimationSheetIndices), the extra tiles
    ; (aBattleAnimationExtraIndices) and the palettes
    ; (aBattleAnimationPaletteIndices); each table is indexed by ID plus 1.

    structBattleAnimationLookupEntry .struct Class, Category, Character, Gender, Frames, Sheet, Extras, Palette
      Class     .byte \Class
      Category  .byte \Category
      Character .byte \Character
      Gender    .byte \Gender
      Frames    .byte \Frames
      Sheet     .byte \Sheet
      Extras    .byte \Extras
      Palette   .byte \Palette
    .endstruct

  ; Move programs (data/battle_animation/moves.asm, written by
  ; tools/battle_moves.py). Each aBattleAnimationPrograms entry points at a
  ; list table, an action table and a script table, all in bank $97.
  ;
  ;   action table: a byte per action (rlBattleAnimationQueueAction takes the action from
  ;     a small table in bank $95 plus the variant in bits 0-1 of $0AF5,x,
  ;     which ANIM_CMD_ED sets): a move list, or a single sequence.
  ;   list table: a word offset per move list from the table start. A list
  ;     is a run of steps rlBattleAnimationQueueMoveList queues for the combatant
  ;     ($7FE144), up to a $7F byte. rlBattleAnimationRunMoveQueue takes them one at a
  ;     time: the low byte is the movement (rlBattleAnimationStartMovement), the high byte
  ;     the sequence it plays (rlBattleAnimationStartSequence; bits 0-5).
  ;   script table: a word offset per movement script from the table start.
  ;     A script is a signed byte per frame step of the sequence, moving the
  ;     combatant (rsBattleAnimationApplyScriptStep); it has no end of its own.

  ; Action table bytes.

    ANIM_ACTION_LIST .segment List
      .byte $80 | \List
    .endsegment

    ; Play the sequence without moving (rlBattleAnimationQueueSequence queues it as $7E).
    ANIM_ACTION_SEQUENCE .segment Sequence
      .byte \Sequence
    .endsegment

  ; Move list steps.

    ; Play Sequence while the combatant follows movement script Script
    ; (bit 15 switches the movement on: bit 1 of $0AF4,x).
    ANIM_MOVE_SCRIPT .segment Sequence, Script
      .word $8000 | (\Sequence << 8) | $80 | \Script
    .endsegment

    ; Play Sequence without moving.
    ANIM_MOVE_STILL .segment Sequence
      .word (\Sequence << 8) | $7E
    .endsegment

    ; Play Sequence and run move routine Routine (AnimMove... below).
    ANIM_MOVE_ROUTINE .segment Sequence, Routine
      .word (\Sequence << 8) | \Routine
    .endsegment

    ; Play Sequence and run a jumping move routine, which takes the next word:
    ; Frames for the move and the Height of the jump arc.
    ANIM_MOVE_JUMP .segment Sequence, Routine, Frames, Height
      .word (\Sequence << 8) | \Routine, (\Height << 8) | \Frames
    .endsegment

    ANIM_MOVE_LIST_END .segment
      .byte $7F
    .endsegment

  ; Move routines (aBattleAnimationMoveRoutines; engine/battle_scene/animation_moves.asm).

    AnimMoveJumpPastOpponent        = 0     ; jump
    AnimMoveHopToOpponent           = 1     ; not used
    AnimMoveLeapToOpponent          = 2     ; not used
    AnimMoveAdvance80               = 3
    AnimMoveCoastLinear             = 4
    AnimMoveCoastHalving            = 5
    AnimMoveGlideToOpponent         = 6
    AnimMoveNoDefaultGravity        = 7
    AnimMoveToOpponentSpeedA        = 8
    AnimMoveToOpponentSpeedB        = 9
    AnimMoveJumpToOpponent          = 10    ; jump
    AnimMoveJumpInPlace             = 11    ; jump
    AnimMoveJumpTo40                = 12    ; jump
    AnimMoveJumpTo80                = 13    ; jump
    AnimMoveAdvancePastOpponent     = 14
    AnimMoveJumpTo16                = 15    ; jump
    AnimMoveLaunchAwayFromAttacker  = 16
    AnimMoveDrift                   = 17    ; not used

  ; Lists of RAM writes for rlBattleSceneWriteRAM, written by tools/ram_lists.py.
  ; Each entry is a word, the address (below $4000, in practice the PPU register
  ; buffers in the direct page) with the entry's type in bits 14-15, and its
  ; operands. The battle scene and the title screen set up their screens this
  ; way.

    WRITE_RAM_BYTE .segment Address, Value
      ; Type 0: write the byte Value to Address.
      .word \Address
      .byte \Value
    .endsegment

    WRITE_RAM_WORD .segment Address, Value
      ; Type $4000: write the word Value to Address.
      .word $4000 | \Address
      .word \Value
    .endsegment

    WRITE_RAM_MASK_BYTE .segment Address, And, Or
      ; Type $8000: the byte at Address = (it AND And) OR Or.
      .word $8000 | \Address
      .byte \And, \Or
    .endsegment

    WRITE_RAM_MASK_WORD .segment Address, And, Or
      ; Type $C000: the same for a word.
      .word $C000 | \Address
      .word \And, \Or
    .endsegment

    WRITE_RAM_END .segment
      .word $FFFF
    .endsegment
