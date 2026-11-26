  ; Indices into aGameStateRoutines ($80/9B01). Two of them are current at once:
  ; every frame rlRunGameStateRoutines runs entry wGameStateRoutine1, then entry
  ; wGameStateRoutine2.
  ;
  ; Most screens own three entries in a row:
  ;   _UPKEEP  run every frame from wGameStateRoutine2 while the screen is up;
  ;   _SETUP   put in wGameStateRoutine1 by the screen's opener, run once, and
  ;            ends by adding one to wGameStateRoutine1, so that...
  ;   _STEP    runs every frame from the next one on, usually by calling the
  ;            routine for wGameStateStep from its own table.
  ; The battle scene, the title screen and the unused screen have only a setup and
  ; a step (wGameStateRoutine2 is 0). $1C-$1F point into zero padding.

  GAMESTATE_NONE                       = $00
  GAMESTATE_OPENING_LOGO_UPKEEP        = $01
  GAMESTATE_OPENING_LOGO_SETUP         = $02
  GAMESTATE_OPENING_LOGO_STEP          = $03
  GAMESTATE_SAVE_MENU_UPKEEP           = $04
  GAMESTATE_SAVE_MENU_SETUP            = $05
  GAMESTATE_SAVE_MENU_STEP             = $06
  GAMESTATE_STATUS_SCREEN_UPKEEP       = $07
  GAMESTATE_STATUS_SCREEN_SETUP        = $08
  GAMESTATE_STATUS_SCREEN_STEP         = $09
  GAMESTATE_CASTLE_SCREEN_UPKEEP       = $0A
  GAMESTATE_CASTLE_SCREEN_SETUP        = $0B
  GAMESTATE_CASTLE_SCREEN_STEP         = $0C
  GAMESTATE_WORLD_MAP_UPKEEP           = $0D
  GAMESTATE_WORLD_MAP_SETUP            = $0E
  GAMESTATE_WORLD_MAP_STEP             = $0F
  GAMESTATE_MAP_UPKEEP                 = $10
  GAMESTATE_MAP_SETUP                  = $11
  GAMESTATE_MAP_STEP                   = $12
  GAMESTATE_UNUSED_13                  = $13
  GAMESTATE_UNUSED_14                  = $14
  GAMESTATE_UNUSED_15                  = $15
  GAMESTATE_UNUSED_SCREEN_SETUP        = $16
  GAMESTATE_UNUSED_SCREEN_STEP         = $17
  GAMESTATE_BATTLE_SCENE_SETUP         = $18
  GAMESTATE_BATTLE_SCENE_STEP          = $19
  GAMESTATE_TITLE_SCREEN_SETUP           = $1A
  GAMESTATE_TITLE_SCREEN_STEP            = $1B
  GAMESTATE_UNIT_WINDOW_UPKEEP         = $20
  GAMESTATE_UNIT_WINDOW_SETUP          = $21
  GAMESTATE_UNIT_WINDOW_STEP           = $22
  GAMESTATE_ITEM_WINDOW_UPKEEP         = $23
  GAMESTATE_ITEM_WINDOW_SETUP          = $24
  GAMESTATE_ITEM_WINDOW_STEP           = $25
  GAMESTATE_DEBUG_MENU_UPKEEP          = $26
  GAMESTATE_DEBUG_MENU_SETUP           = $27
  GAMESTATE_DEBUG_MENU_STEP            = $28
  GAMESTATE_OPTIONS_MENU_UPKEEP        = $29
  GAMESTATE_OPTIONS_MENU_SETUP         = $2A
  GAMESTATE_OPTIONS_MENU_STEP          = $2B
  GAMESTATE_SKILL_WINDOW_UPKEEP        = $2C
  GAMESTATE_SKILL_WINDOW_SETUP         = $2D
  GAMESTATE_SKILL_WINDOW_STEP          = $2E
  GAMESTATE_DATA_WINDOW_UPKEEP         = $2F
  GAMESTATE_DATA_WINDOW_SETUP          = $30
  GAMESTATE_DATA_WINDOW_STEP           = $31
  GAMESTATE_REVIVE_SCREEN_UPKEEP       = $32
  GAMESTATE_REVIVE_SCREEN_SETUP        = $33
  GAMESTATE_REVIVE_SCREEN_STEP         = $34
  GAMESTATE_EPILOGUE_UPKEEP            = $35
  GAMESTATE_EPILOGUE_SETUP             = $36
  GAMESTATE_EPILOGUE_STEP              = $37
