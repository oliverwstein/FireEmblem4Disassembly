
  EventUnitSlot1 = 1
  EventUnitSlot2 = 2

  FlagAlways = $FF

  AnyFactionSlot  = -1
  AnyCharacter    = -1
  AnyLocation     = -1
  AnyTurn         = -1
  AnyAI           = -1


  DIALOGUE_BG_FOUNTAIN  = 0
  DIALOGUE_BG_GATE      = 1
  DIALOGUE_BG_ALLEY     = 2
  DIALOGUE_BG_THRONE    = 3
  DIALOGUE_BG_HALLWAY   = 4
  DIALOGUE_BG_CLOISTER  = 5


  ; for SET_FACTION_HOSTILITY

  HOSTILITY_ENEMIES = 1
  HOSTILITY_ALLIES  = 2
  HOSTILITY_NEUTRAL = 3

  ; for CASTLE_NAME

  CASLTE_NAME_BLUE   = 0
  CASLTE_NAME_RED    = 1
  CASLTE_NAME_GREEN  = 2
  CASLTE_NAME_YELLOW = 3

  ; Unit loading

  MAP_SPRITE_BLUE   = 2
  MAP_SPRITE_RED    = 4
  MAP_SPRITE_GREEN  = 6
  MAP_SPRITE_YELLOW = 8

  ; For unit movement and map scrolling
  ; Maps only support directions, speed and end

  ; Movement script command codes. The MAP_* macros below emit these;
  ; code that builds movement scripts uses the numbers directly.

  MAP_CMD_LEFT       = 1
  MAP_CMD_RIGHT      = 2
  MAP_CMD_UP         = 3
  MAP_CMD_DOWN       = 4
  MAP_CMD_UP_LEFT    = 5
  MAP_CMD_DOWN_LEFT  = 6
  MAP_CMD_UP_RIGHT   = 7
  MAP_CMD_DOWN_RIGHT = 8
  MAP_CMD_MULTIPLE   = 9 ; added to a direction: move Count tiles
  MAP_CMD_PAUSE      = $12
  MAP_CMD_END        = $80
  MAP_CMD_HALT       = $81

  MAP_LEFT .segment
    .byte MAP_CMD_LEFT
  .endsegment

  MAP_RIGHT .segment
    .byte MAP_CMD_RIGHT
  .endsegment

  MAP_UP .segment
    .byte MAP_CMD_UP
  .endsegment

  MAP_DOWN .segment
    .byte MAP_CMD_DOWN
  .endsegment

  MAP_UP_LEFT .segment
    .byte MAP_CMD_UP_LEFT
  .endsegment

  MAP_DOWN_LEFT .segment
    .byte MAP_CMD_DOWN_LEFT
  .endsegment

  MAP_UP_RIGHT .segment
    .byte MAP_CMD_UP_RIGHT
  .endsegment

  MAP_DOWN_RIGHT .segment
    .byte MAP_CMD_DOWN_RIGHT
  .endsegment

  MAP_LEFT_MULTIPLE .segment Count
    .byte MAP_CMD_LEFT + MAP_CMD_MULTIPLE ; $0A
    .byte \Count
  .endsegment

  MAP_RIGHT_MULTIPLE .segment Count
    .byte MAP_CMD_RIGHT + MAP_CMD_MULTIPLE ; $0B
    .byte \Count
  .endsegment

  MAP_UP_MULTIPLE .segment Count
    .byte MAP_CMD_UP + MAP_CMD_MULTIPLE ; $0C
    .byte \Count
  .endsegment

  MAP_DOWN_MULTIPLE .segment Count
    .byte MAP_CMD_DOWN + MAP_CMD_MULTIPLE ; $0D
    .byte \Count
  .endsegment

  MAP_UP_LEFT_MULTIPLE .segment Count
    .byte MAP_CMD_UP_LEFT + MAP_CMD_MULTIPLE ; $0E
    .byte \Count
  .endsegment

  MAP_DOWN_LEFT_MULTIPLE .segment Count
    .byte MAP_CMD_DOWN_LEFT + MAP_CMD_MULTIPLE ; $0F
    .byte \Count
  .endsegment

  MAP_UP_RIGHT_MULTIPLE .segment Count
    .byte MAP_CMD_UP_RIGHT + MAP_CMD_MULTIPLE ; $10
    .byte \Count
  .endsegment

  MAP_DOWN_RIGHT_MULTIPLE .segment Count
    .byte MAP_CMD_DOWN_RIGHT + MAP_CMD_MULTIPLE ; $11
    .byte \Count
  .endsegment

  MAP_PAUSE .segment Time
    .byte MAP_CMD_PAUSE ; $12
    .byte \Time
  .endsegment

  MAP_END .segment
    .byte MAP_CMD_END
  .endsegment

  MAP_HALT .segment
    ; If all scripted moving units are halting, continue
    ; executing events.
    .byte MAP_CMD_HALT
  .endsegment

  MAP_82 .segment
    ; Placeholder, may have arguments
    .byte $82
  .endsegment

  MAP_83 .segment
    ; Placeholder, may have arguments
    .byte $83
  .endsegment

  MAP_SET_SPEED .segment Speed
    ; 1 is slow, 5 is fast
    .byte $84
    .byte \Speed
  .endsegment

  MAP_FACE_LEFT .segment
    .byte 1 + 4 + $80 ; $85
  .endsegment

  MAP_FACE_RIGHT .segment
    .byte 2 + 4 + $80 ; $86
  .endsegment

  MAP_FACE_UP .segment
    .byte 3 + 4 + $80 ; $87
  .endsegment

  MAP_FACE_DOWN .segment
    .byte 4 + 4 + $80 ; $88
  .endsegment


  SCRIPTED_BATTLE .segment DefenderID, DefenderInventorySlot, AttackerID, BattleQuote, DefeatQuote
    .word \DefenderID
    .word \DefenderInventorySlot
    .word \AttackerID
    .byte 0
    .long \BattleQuote
    .long \DefeatQuote
  .endsegment

  SB_END .segment
    .word $FFFF
  .endsegment
