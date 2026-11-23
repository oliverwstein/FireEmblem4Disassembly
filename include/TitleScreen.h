
  ; Title screen timelines.
  ;
  ; The title screen (game states $1A/$1B) is driven by a timeline: a list of
  ; entries, each a frame number and commands to run once the title's frame
  ; counter reaches it. Each frame rsRunTitleTimeline runs every entry whose
  ; frame has come and moves the timeline pointer past them; then
  ; rsRunTitleTimelineSlots calls the routine in each active slot (16 slots,
  ; four bytes each from $7FD006: a flag byte and a long pointer).
  ;
  ; A command is a byte and a long pointer to a routine in banks $95/$9B:
  ;   n < $80  install the routine in slot n; it runs every frame from then on,
  ;            with X = the slot's offset, until it clears its flag byte.
  ;   $80 + n  call the routine once now, with A = n.
  ; The data bank is the routine's bank in both cases. Entries need not be in
  ; frame order: an entry whose frame has passed runs at the next check.

    TITLE_TIMELINE_AT .segment Frame
      ; Start an entry that runs on frame Frame.
      .word \Frame
    .endsegment

    TITLE_TIMELINE_SLOT .segment Slot, Routine
      ; Run Routine every frame from now on, in slot Slot.
      .byte \Slot
      .long \Routine
    .endsegment

    TITLE_TIMELINE_CALL .segment Argument, Routine
      ; Call Routine once, with A = Argument.
      .byte $80 | \Argument
      .long \Routine
    .endsegment

    TITLE_TIMELINE_NEXT .segment
      ; End of an entry.
      .byte $FF
    .endsegment

    TITLE_TIMELINE_END .segment
      ; End of the timeline: a frame number the counter never reaches.
      .word $FFFF
    .endsegment

  ; A title screen sprite (aTitleSprites, 13 of them). rlUnknown95F967 sets
  ; one up from an 11-byte definition (Script, Frames, X, Y, TileBase,
  ; Attributes); rlUnknown95F89A animates and draws the active ones each frame.
  ; The script is a list of two-byte steps: a frame number + 1 and how many
  ; frames to show it, or $80 and a count of steps to go back by.

    structTitleSprite .struct
      Flags         .byte ? ; $80 active; $01 draws an afterimage
                            ; (rlUnknown9BEAE8); $02 draws it with the next
                            ; sprite's frame
      X             .word ?
      Y             .word ?
      Script        .long ? ; the step being shown
      Frames        .word ? ; table of word offsets to sprite arrays, in Script's bank
      Frame         .byte ?
      Timer         .byte ? ; frames left on the step
      Attributes    .word ? ; attribute base for rlPushToOAMBuffer (wR5)
      TileBase      .word ? ; tile base for rlPushToOAMBuffer (wR4)
      TrailX        .fill 16 * size(word) ; the last 16 positions and frames,
      TrailY        .fill 16 * size(word) ; a ring buffer for the afterimage
      TrailFrame    .fill 16
      TrailPosition .byte ?
      TrailDelay    .byte ? ; how many frames behind the afterimage is
    .endstruct
