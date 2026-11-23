
  ; The battle scene (game states $18 and $19; engine/battle_scene/).
  ; Its RAM is in WRAM.h ("The battle scene").

  ; Each combatant's record (aBattleSceneCombatant1 and 2), filled from the
  ; action structs by rsBattleSceneCopyCombatants.

    structBattleSceneCombatant .struct
      Class      .word ? ; $00
      Character  .word ? ; $02 ; 0: no combatant on this side
      Weapon     .word ? ; $04 ; only the low byte is read
      HP         .word ? ; $06 ; 8.8: the whole points are the high byte
      MaxHP      .byte ? ; $08
      HPSpeed    .word ? ; $09 ; 8.8 points a frame, negative for a loss; 0 when still
      HPTarget   .byte ? ; $0B
      Gender     .byte ? ; $0C
      AnimStyle  .byte ? ; $0D ; low nibble the attack style, high nibble the AnimCategory
    .endstruct

  ; Bits of wBattleSceneFlags, set by rlBattleSceneSetFlags and rsBattleSceneSetWaterFlags.

    BattleSceneFlagMelee          = bits($0001) ; battle distance under 2, not battle type 2
    BattleSceneFlagBattleType2    = bits($0002) ; wBattleType 2: no quotes, no foreground
    BattleSceneFlagSolo           = bits($0004) ; aActionStructUnit1.Unknown is 8: both stand at the center
    BattleSceneFlagSolo2          = bits($0008) ; set with BattleSceneFlagSolo
    BattleSceneFlagSea            = bits($0010)
    BattleSceneFlagRiver          = bits($0020)
    BattleSceneFlagHolyWeapon2    = bits($0040) ; combatant 2 carries a holy weapon; cleared at its first round
    BattleSceneFlagHolyWeapon1    = bits($0080) ; the same for combatant 1
    BattleSceneFlagListedWeapon1  = bits($0100) ; combatant 1's weapon is in aUnknown998F02
    BattleSceneFlagListedWeapon2  = bits($0200)
    BattleSceneFlagToMapMode3     = bits($0400) ; on leaving, wMainGameMode 3 (rlBattleSceneStep)

  ; Bits of bBattleSceneRoundState.

    BattleSceneRoundMayRun        = bits($01) ; the intro is over (rlBattleSceneCheckIntroDone)
    BattleSceneRoundAllRead       = bits($02) ; the last round has been read
    BattleSceneRoundHeld          = bits($08) ; cleared by a countdown or Start (rsUnknown959C14)
    BattleSceneRoundArenaNextBout = bits($10) ; the arena round list ended with $FEFF: fight again
    BattleSceneRoundMissed        = bits($40) ; the current strike misses
    BattleSceneRoundArenaRetreat  = bits($80) ; B was pressed in the arena (rlBattleSceneReadArenaRetreat)

  ; Palette effect entries for rlBattleSceneStartPaletteEffect (script command
  ; 11 takes them from aBattleScenePaletteEffects; tools/palette_effects.py).
  ; Slot is one of ten slots ($7FFD9A, 10 bytes each), Type (bits 0-5) picks
  ; what rlBattleSceneRunPaletteEffects does each frame; FirstColor and Count are the colors
  ; of aBGPaletteBuffer it changes. Type 0 plays Data as frames of Count colors,
  ; each optionally led by a byte $80 | frames (else the slot's own delay); a
  ; byte $FE goes back to the start and $FF ends it.

    ; Types 0-2, 10 and 12: a long pointer to the type's data.
    PALETTE_EFFECT .segment Slot, Type, FirstColor, Count, Data
      .byte \Slot, \Type, \FirstColor, \Count
      .long \Data
    .endsegment

    ; Types 3-6: one byte.
    PALETTE_EFFECT_VALUE .segment Slot, Type, FirstColor, Count, Value
      .byte \Slot, \Type, \FirstColor, \Count, \Value
    .endsegment

    ; Type 7: one byte and a long pointer.
    PALETTE_EFFECT_VALUE_DATA .segment Slot, Type, FirstColor, Count, Value, Data
      .byte \Slot, \Type, \FirstColor, \Count, \Value
      .long \Data
    .endsegment

    ; Types 8, 9 and 11 (and any type above 12, which stops the slot).
    PALETTE_EFFECT_NO_DATA .segment Slot, Type, FirstColor, Count
      .byte \Slot, \Type, \FirstColor, \Count
    .endsegment


  ; An upload queued for VBlank (aBattleSceneUploads).

  structBattleSceneUpload .struct
    Source      .long ?
    VRAMAddress .word ?
    Size        .word ? ; bytes
  .endstruct

  ; The gauges the level up window draws (aBattleSceneLevelUpGauges): the value's
  ; address, then the gauge's variables (wBattleSceneGaugeScale ...).

  BATTLE_SCENE_GAUGE .segment Value, Scale, Offset, Max, Digits, UploadSize, Attributes
    .long \Value
    .word \Scale, \Offset
    .byte \Max, \Digits, \UploadSize
    .word \Attributes
  .endsegment

  ; The stats a level up raises (aBattleSceneLevelUpStatGauges): the stat and
  ; its gain, then the gauge's scale, offset and length.

  BATTLE_SCENE_STAT_GAUGE .segment Stat, Gain, Scale, Offset, Max
    .long \Stat, \Gain
    .word \Scale, \Offset
    .byte \Max
  .endsegment

  ; An afterimage (aBattleSceneAfterimages): a copy of a combatant drawn at its
  ; position a few frames back (rsBattleSceneUpdateAfterimages).

  structBattleSceneAfterimage .struct
    Flags     .byte ?        ; bit 0 on, bit 1 alternates the delay (8 or 12 frames)
    Owner     .word ?        ; the slot (0 or $43)
    Positions .fill 16 * 3   ; X (word) and screen Y (byte), oldest first
  .endstruct

  ; A palette effect slot (aBattleScenePaletteSlots), filled by
  ; rlBattleSceneStartPaletteEffect from a PALETTE_EFFECT entry and run by
  ; rlBattleSceneRunPaletteEffects.

  structBattleScenePaletteSlot .struct
    Type       .byte ? ; bits 0-5 the type; bit 6 a script waits for it; bit 7 stopped
    Data       .long ? ; the start of the type's data
    Position   .word ? ; the next byte of the data (in Data's bank)
    FirstColor .byte ?
    Count      .byte ?
    Delay      .byte ? ; frames between steps
    Timer      .byte ?
  .endstruct
