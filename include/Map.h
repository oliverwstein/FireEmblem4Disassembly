
  ; The chapter map engine (engine/map/).

  ; wMapCursorState: what the map cursor is doing (engine/map/map_cursor.asm).
  MAP_CURSOR_FREE              = $0000
  MAP_CURSOR_BACK_TO_UNIT      = $0001 ; a move was chosen: the cursor goes back to the unit
  MAP_CURSOR_UNIT_WALKING      = $0002 ; the unit walks aMovementPath
  MAP_CURSOR_CHOOSE_TARGET     = $0003
  MAP_CURSOR_TO_UNIT           = $0004 ; travelling to a unit or tile (wMapCursorXTile/YTile)
  MAP_CURSOR_TO_UNIT_SELECT    = $0005 ; then picks up the unit there
  MAP_CURSOR_TO_TARGET         = $0006 ; then goes on choosing a target
  MAP_CURSOR_TO_UNIT_MENU      = $0007 ; then picks up the unit or opens its command menu
  MAP_CURSOR_TO_UNIT_ACTION    = $0008 ; like 4, for wMapActionMode 4 and 5
  MAP_CURSOR_LOCKED            = $FFFF ; only drawn, while the map is left for another screen

  ; In a computer phase rlMapAIMoveStep gives the states its own meanings.
  MAP_AI_CURSOR_TO_UNIT        = $0001
  MAP_AI_UNIT_WALKING          = $0002
  MAP_AI_CURSOR_TO_TARGET      = $0003
  MAP_AI_WAIT                  = $0004 ; a short wait before the AI action runs

  ; wMapReturnFlags: what the map does on return from a menu or the castle.
  MAP_RETURN_CENTER_ON_UNIT    = bits($0001) ; the cursor travels to the active unit
  MAP_RETURN_START_CASTLE_STAFF = bits($0002) ; start the active unit's staff target selection
  MAP_RETURN_CASTLE_STAFF_ACTIVE = bits($0004) ; that selection is running (B puts the unit back)
  MAP_RETURN_CASTLE_GRID_STAFF = bits($0008) ; the staff was chosen on the castle grid

  ; wMapActionTargetType: the action rlRunMapAction runs (aMapActionRoutines).
  MAP_ACTION_BATTLE            = $0000
  MAP_ACTION_STAFF             = $0001 ; also a battle
  MAP_ACTION_HELP              = $0002
  MAP_ACTION_GIVE_GOLD         = $0003
  MAP_ACTION_TALK              = $0004

  ; aMovementPath: the step directions.
  PATH_DOWN                    = 1
  PATH_UP                      = 2
  PATH_RIGHT                   = 3
  PATH_LEFT                    = 4

  ; wGameStateStep while the map step runs (aMapStepRoutines, engine/map/map_step.asm).
  MAP_STEP_START_TURN          = 0
  MAP_STEP_FADE_OUT_MUSIC      = 1 ; the first step of each army's phase
  MAP_STEP_PHASE_BANNER        = 2
  MAP_STEP_PHASE_START_EVENTS  = 3
  MAP_STEP_START_PHASE         = 4
  MAP_STEP_TURN_START_HEALING  = 5
  MAP_STEP_AUTO_SAVE_PROMPT    = 6
  MAP_STEP_PHASE               = 7 ; the phase itself
  MAP_STEP_NEXT_FACTION        = 8
  MAP_STEP_END_TURN            = 9
  MAP_STEP_OPEN_STATUS_SCREEN  = 10
  MAP_STEP_RESUME              = 11 ; back from another screen
  MAP_STEP_GAME_OVER           = 12
  MAP_STEP_COUNT               = 13

  ; wUnitRelocationType: what the map step does next for a unit after an action
  ; (aUnitRelocationRoutines).
  UNIT_RELOCATION_TO_TILE      = 0 ; Warp and Rescue onto a tile
  UNIT_RELOCATION_ESCAPED      = 1
  UNIT_RELOCATION_CAPTURED     = 2
  UNIT_RELOCATION_INTO_CASTLE  = 3
  UNIT_RELOCATION_SORTIE       = 4 ; an AI unit leaves its castle
  UNIT_RELOCATION_SEIZE_POPUP  = 5
  UNIT_RELOCATION_SAVE_PROMPT  = 6 ; the end of a chapter
  UNIT_RELOCATION_HELPED       = 7
  UNIT_RELOCATION_ITEM_POPUP   = 8
  UNIT_RELOCATION_RESCUED      = 9 ; the Rescue staff into a castle
