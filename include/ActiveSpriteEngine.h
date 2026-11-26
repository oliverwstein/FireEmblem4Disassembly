
  ActiveSpriteEngineInactive           = $0001

  ActiveSpriteEngine2000               = $2000
  ActiveSpriteEngineRenderOnScreenOnly = $4000
  ActiveSpriteEngineEnabled            = $8000

  ; Active sprite definitions and scripts.
  ;
  ; An active sprite is created from a definition of three words in the bank
  ; the sprite runs in: an init routine, an on-cycle routine and a script.
  ; Each frame the engine calls the on-cycle routine, counts down the frame
  ; timer, and when it reaches 0 runs the script from where it stopped
  ; (rsActiveSpriteRunOnCycleAndCode). A script is a list of commands, each a
  ; byte (an index into aActiveSpriteCommandPointers) followed by its
  ; operands. Commands that show a frame or wait end the script's run for
  ; this frame; the others run on to the next command. Addresses are in the
  ; sprite's bank. Commands $03-$0D, $1A-$1C and $10-$11 serve the map
  ; battle (procMapBattle), whose scripts are in its compressed sprite data.

    structActiveSpriteInfo .struct Init, OnCycle, Code
      Init    .word <>\Init
      OnCycle .word <>\OnCycle
      Code    .word <>\Code
    .endstruct

    ACTIVE_SPRITE_FRAME .segment Duration, Frame
      ; $00: draw the sprite array Frame for Duration frames.
      .byte $00, \Duration
      .word <>\Frame
    .endsegment

    ACTIVE_SPRITE_END .segment
      ; $01: free the sprite.
      .byte $01
    .endsegment

    ACTIVE_SPRITE_JUMP_WHILE_COUNTER .segment Position
      ; $02: count aLoopCounter down; jump to Position while it is not 0. No command
      ; in the table sets the counter, and no script uses this command.
      .byte $02
      .word <>\Position
    .endsegment

    ACTIVE_SPRITE_MAP_BATTLE_FRAME .segment Frame
      ; $03 (map battle): upload frame Frame of the side's frame tiles
      ; (aMapBattleSpriteDMATable) to the side's frame VRAM.
      .byte $03, \Frame
    .endsegment

    ACTIVE_SPRITE_MAP_BATTLE_STRIKE .segment
      ; $04 (map battle): the strike lands: set wMapBattleStrikeSignal and play
      ; the hit sound (rlPlayMapBattleHitSFX).
      .byte $04
    .endsegment

    ACTIVE_SPRITE_WAIT_STRIKE_TAKEN .segment
      ; $05 (map battle): wait until wMapBattleStrikeSignal is clear, then set
      ; wMapBattleStrikeDone.
      .byte $05
    .endsegment

    ACTIVE_SPRITE_WAIT_STRIKE .segment
      ; $06 (map battle): wait until wMapBattleStrikeSignal is set; a main
      ; (not aux) battle sprite then clears it.
      .byte $06
    .endsegment

    ACTIVE_SPRITE_WAIT_STRIKE_DONE .segment
      ; $07 (map battle): wait until wMapBattleStrikeDone is set.
      .byte $07
    .endsegment

    ACTIVE_SPRITE_WAIT_ROUND .segment
      ; $08 (map battle): wait until a round starts (wMapBattleRoundRunning).
      .byte $08
    .endsegment

    ACTIVE_SPRITE_ROUND_SCRIPT .segment
      ; $09 (map battle): jump to the side's round script
      ; (aMapAction.lAttackerRoundScript, or lDefenderRoundScript when the
      ; sprite's aMapBattleSpriteSide is set), chosen by rsGetMapBattleRoundScripts.
      .byte $09
    .endsegment

    ACTIVE_SPRITE_AUX_ROUND_SCRIPT .segment
      ; $0A (map battle): the same for the side's aux sprite.
      .byte $0A
    .endsegment

    ACTIVE_SPRITE_SIDE_SCRIPT .segment
      ; $0B (map battle): jump to the side's first script (offset +6 of its
      ; sprite data, aMapAction.lAttackerSpriteData).
      .byte $0B
    .endsegment

    ACTIVE_SPRITE_SIDE_AUX_SCRIPT .segment
      ; $0C (map battle): jump to the side's first aux script (offset +8).
      .byte $0C
    .endsegment

    ACTIVE_SPRITE_END_ROUND .segment
      ; $0D (map battle): end the round: rlMapBattleEndRoundScripts.
      .byte $0D
    .endsegment

    ACTIVE_SPRITE_TABLE_FRAME .segment Duration, Index
      ; $0E: draw frame Index of the frame table at $7F4598 ($7F459B when
      ; the sprite's aMapBattleSpriteSide is set) for Duration frames. A frame
      ; table starts with the offset of its list of frame offsets; all
      ; offsets count from the table's start.
      .byte $0E, \Duration, \Index
    .endsegment

    ACTIVE_SPRITE_DRAW_MOVING_MAP_SPRITE .segment
      ; $0F: draw the moving map sprite (rlDrawMovingMapSprite) every frame,
      ; staying on this command.
      .byte $0F
    .endsegment

    ACTIVE_SPRITE_START_MAP_MAGIC .segment
      ; $10: start the map battle's magic effect ($7F5091 = 1, $7F5093 = 0).
      .byte $10
    .endsegment

    ACTIVE_SPRITE_WAIT_MAP_MAGIC .segment
      ; $11: wait until the magic effect is done ($7F5093), then clear
      ; $7F5091 and acknowledge (wMapBattleStrikeDone).
      .byte $11
    .endsegment

    ACTIVE_SPRITE_WAIT .segment Frames
      ; $12: wait Frames frames, keeping the current frame.
      .byte $12, \Frames
    .endsegment

    ACTIVE_SPRITE_WAIT_WORD .segment Frames
      ; $13: like $12, but the frame count is read as a word while only one
      ; byte is skipped: the next command's byte is its high byte.
      .byte $13, \Frames
    .endsegment

    ACTIVE_SPRITE_SET_ONCYCLE .segment Routine
      ; $14
      .byte $14
      .word <>\Routine
    .endsegment

    ACTIVE_SPRITE_JUMP .segment Position
      ; $15
      .byte $15
      .word <>\Position
    .endsegment

    ACTIVE_SPRITE_JUMP_RELATIVE .segment Position
      ; $16: jump to Position, at most 128 bytes away.
      .byte $16
      .char \Position - *
    .endsegment

    ACTIVE_SPRITE_CALL .segment Routine
      ; $17: call Routine (rtl) with X = the sprite's slot, Y = the script
      ; position after the operand.
      .byte $17
      .word <>\Routine
    .endsegment

    ACTIVE_SPRITE_FRAME_RELATIVE .segment Duration, Offset
      ; $18: like $00, but Offset counts from the sprite's definition
      ; (aTypeOffset).
      .byte $18, \Duration
      .word \Offset
    .endsegment

    ACTIVE_SPRITE_MOVE .segment XOffset, YOffset
      ; $19: add the signed bytes to the sprite's X and Y
      ; (aXPosition, aYPosition).
      .byte $19
      .char \XOffset, \YOffset
    .endsegment

    ACTIVE_SPRITE_WAIT_BOLT_SIGNAL .segment
      ; $1A (map battle): wait until wBallistaBoltSignal is set, then clear it.
      .byte $1A
    .endsegment

    ACTIVE_SPRITE_FIRE_BOLT .segment
      ; $1B (map battle): fire the ballista bolt (wBallistaBoltFire).
      .byte $1B
    .endsegment

    ACTIVE_SPRITE_WAIT_BOLT_DONE .segment
      ; $1C (map battle): wait until the bolt has landed (wBallistaBoltDone),
      ; then set wMapBattleStrikeDone.
      .byte $1C
    .endsegment

    ACTIVE_SPRITE_SOUND .segment Sound
      ; $1D: play a sound effect, panned by the sprite's X.
      .byte $1D, \Sound
    .endsegment

    ACTIVE_SPRITE_SET_MUSIC .segment Song
      ; $1E: set wMusicID.
      .byte $1E, \Song
    .endsegment

    MAP_BATTLE_SPRITE_DATA_END .segment Size
      ; The end of a map battle sprite data stream (gfx/compressed/*/aMapBattle*Layout*.asm,
      ; assembled at 0 by tools/map_battle_layouts.py): zeros up to Size, the stream's
      ; original length. A stream may grow to $880 bytes, the distance between the two
      ; sides' copies (aMapBattleSpriteBufferOffsets).
      .if * < \Size
        .fill \Size - *, 0
      .endif
      .cerror * > $880, "map battle sprite data is larger than $880 bytes"
    .endsegment
