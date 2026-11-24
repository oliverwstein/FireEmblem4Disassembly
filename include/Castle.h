
  ; The castle screen (engine/castle/).

  ; wCastleScreenHandler: what rsOpenCastleScreen does (aCastleStateHandlers).
  CASTLE_SCREEN_COURTYARD           = 0
  CASTLE_SCREEN_TOWN                = 1 ; a unit entered from the map: its town screen
  CASTLE_SCREEN_CONVERSATION        = 2
  CASTLE_SCREEN_ARENA               = 3
  CASTLE_SCREEN_COURTYARD_AGAIN     = 4 ; same routine as 0
  CASTLE_SCREEN_RELOAD_MAP          = 5 ; after a battle: reload the chapter map, then the courtyard

  ; wGameStateStep while the castle screen is up (aCastleScreenStepHandlers).
  CASTLE_STEP_COURTYARD_START       = $00
  CASTLE_STEP_COURTYARD             = $01
  CASTLE_STEP_WAIT                  = $02
  CASTLE_STEP_ARENA_SETUP           = $03
  CASTLE_STEP_ARENA                 = $04
  CASTLE_STEP_AUGURY_SETUP          = $05
  CASTLE_STEP_AUGURY                = $06
  CASTLE_STEP_DEPOT_SETUP           = $07
  CASTLE_STEP_DEPOT                 = $08
  CASTLE_STEP_CLASS_CHANGE_SETUP    = $09
  CASTLE_STEP_CLASS_CHANGE          = $0A
  CASTLE_STEP_CONVERSATION_SETUP    = $0B
  CASTLE_STEP_CONVERSATION          = $0C
  CASTLE_STEP_SHOP_SETUP            = $0D
  CASTLE_STEP_SHOP                  = $0E
  CASTLE_STEP_FADE_OUT              = $0F ; then wNextMenuState
  CASTLE_STEP_FADE_IN               = $10 ; then wNextMenuState
  CASTLE_STEP_RETURN_TO_COURTYARD   = $11
  CASTLE_STEP_REOPEN_TOWN_SAME_SONG = $12
  CASTLE_STEP_EXIT_TO_MAP_NO_RESET  = $13
  CASTLE_STEP_RETURN_TO_COURTYARD_2 = $14 ; same routine as $11
  CASTLE_STEP_REOPEN_TOWN           = $15
  CASTLE_STEP_EXIT_TO_MAP           = $16

  ; wCastleCursorState: where the courtyard's cursor is.
  CASTLE_CURSOR_GRID                = 0     ; the 4x6 unit grid
  CASTLE_CURSOR_COMMANDS            = 1     ; the six unit commands
  CASTLE_CURSOR_TOWN                = 3     ; the town's facility buttons
  CASTLE_CURSOR_STAFF_TARGET        = 4     ; choosing a unit to use a staff on
  CASTLE_CURSOR_GIVE_TARGET         = 5     ; choosing a unit to give money to
  CASTLE_CURSOR_GAVE                = 7     ; money given; A or B goes back to the grid
  CASTLE_CURSOR_STATUS_SCREEN       = $FFFF ; X opened the status screen

  ; wCastleUnitCommand: the unit command under the cursor.
  CASTLE_COMMAND_TOWN               = 0
  CASTLE_COMMAND_SORTIE             = 1
  CASTLE_COMMAND_GUARD              = 2
  CASTLE_COMMAND_CLASS_CHANGE       = 3
  CASTLE_COMMAND_STAFF_OR_DANCE     = 4
  CASTLE_COMMAND_GIVE               = 5

  ; wCastleTownFacility: the town's buttons, two rows of three.
  CASTLE_TOWN_REPAIR_SHOP           = 0
  CASTLE_TOWN_SECONDHAND_SHOP       = 1
  CASTLE_TOWN_DEPOT                 = 2
  CASTLE_TOWN_ARENA                 = 3
  CASTLE_TOWN_AUGURY                = 4
  CASTLE_TOWN_ITEM_SHOP             = 5

  ; The facility bits of a castle: byte $05 of its location entry (rlGetCastleFacilities).
  CastleFacilityArena               = bits($0004)
  CastleFacilityAugury              = bits($0008)
  CastleFacilityDepot               = bits($0010)
  CastleFacilityRepairShop          = bits($0020)
  CastleFacilitySecondhandShop      = bits($0040)
  CastleFacilityItemShop            = bits($0080)
  CastleFacilityAll                 = CastleFacilityItemShop | CastleFacilitySecondhandShop | CastleFacilityRepairShop | CastleFacilityDepot | CastleFacilityAugury | CastleFacilityArena

  ; $7F8082: the keeper, which picks the lines (aShopDialoguePointers), the
  ; portrait (aKeeperPortraits) and the option list (rsSetKeeperOptionList).
  KEEPER_ITEM_SHOP                  = 0
  KEEPER_SECONDHAND_SHOP            = 1
  KEEPER_REPAIR_SHOP                = 2
  KEEPER_DEPOT                      = 3
  KEEPER_CLASS_CHANGE               = 5
  KEEPER_ARENA                      = 7

  ; wConversationExitMode: where a conversation scene goes when it ends (rsConversationEnd).
  CONVERSATION_EXIT_COURTYARD       = 0
  CONVERSATION_EXIT_TOWN            = 1
  CONVERSATION_EXIT_MAP             = 3
  CONVERSATION_EXIT_CALLBACK        = 4 ; fade out, then rlShowNextEpilogueCharacterEnding
  CONVERSATION_EXIT_FADE_OUT        = 5
