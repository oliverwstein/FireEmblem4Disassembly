
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
