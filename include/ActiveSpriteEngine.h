
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
  ; sprite's bank. Commands without a macro here are written as .byte rows
  ; with the command's number in a comment.

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
      ; $02: count aUpdater down; jump to Position while it is not 0.
      .byte $02
      .word <>\Position
    .endsegment

    ACTIVE_SPRITE_TABLE_FRAME .segment Duration, Index
      ; $0E: draw frame Index of the frame table at $7F4598 ($7F459B when
      ; the sprite's aUnknown001320 is set) for Duration frames. A frame
      ; table starts with the offset of its list of frame offsets; all
      ; offsets count from the table's start.
      .byte $0E, \Duration, \Index
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

    ACTIVE_SPRITE_CALL .segment Routine
      ; $17: call Routine (rtl) with X = the sprite's slot, Y = the script
      ; position after the operand.
      .byte $17
      .word <>\Routine
    .endsegment

    ACTIVE_SPRITE_MOVE .segment XOffset, YOffset
      ; $19: add the signed bytes to the sprite's X and Y
      ; (aUnknown001200, aUnknown001240).
      .byte $19
      .char \XOffset, \YOffset
    .endsegment

    ACTIVE_SPRITE_SOUND .segment Sound
      ; $1D: play a sound effect, panned by the sprite's X.
      .byte $1D, \Sound
    .endsegment
