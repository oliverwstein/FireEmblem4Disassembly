
  structMapMenu .struct PaletteDataPointer, GraphicsDataPointer, TilemapDataPointer, Type, Position, Next
    .if (\PaletteDataPointer === ?)
      PaletteDataPointer  .long ? ; $00
      GraphicsDataPointer .long ? ; $03
      TilemapDataPointer  .long ? ; $06
      Type                .byte ? ; $09
      .union
        Position          .word ? ; $0A
        .struct
          XPosition       .byte ? ; $0A
          YPosition       .byte ? ; $0B
        .endstruct
      .endunion
      Next            .long ? ; $0C ; the next open map menu (lMapMenuListHead)
    .else
      PaletteDataPointer  .long \PaletteDataPointer  ; $00
      GraphicsDataPointer .long \GraphicsDataPointer ; $03
      TilemapDataPointer  .long \TilemapDataPointer  ; $06
      Type                .byte \Type                ; $09
      XPosition           .byte \Position[0]         ; $0A
      YPosition           .byte \Position[1]         ; $0B
      Next            .long \Next            ; $0C
    .endif
  .endstruct

  structMapMenuPaletteData .struct Size, Palette, Color, Source
    Size    .word \Size    ; $00
      ; How many color words to copy over.
    Palette .byte \Palette ; $02
    Color   .byte \Color   ; $03
      ; Which palette and which color in the palette to overwrite
    Source  .long \Source  ; $04
  .endstruct

  structMapMenuGraphicsData .struct DMACount, DMADestination, DecompressFlag, DataSource
    DMACount        .word \DMACount       ; $00
    DMADestination  .word \DMADestination ; $02
    DecompressFlag  .byte \DecompressFlag ; $04
    DataSource      .long \DataSource     ; $05
      ; If flag is set, decompress this data, then DMA from decomp buffer to VRAM
      ; If unset, directly DMA this.
  .endstruct

  structMapMenuTilemapData .struct Width, Height, BGBuffer, Unknown1, TilesPointer
    .if (\Width === ?)
      .union
        Area        .word ?
        .struct
          Width     .byte ?
          Height    .byte ?
        .endstruct
      .endunion
      BGBuffer      .long ?
      Unknown1      .byte ?
      TilesPointer  .long ?     ; Width * Height words of tiles, or 0
    .else
      Width     .byte \Width    ; $00
      Height    .byte \Height   ; $01
      BGBuffer  .long \BGBuffer ; $02
      Unknown1  .byte \Unknown1 ; $05
      TilesPointer .long \TilesPointer ; $06
    .endif
  .endstruct

  ; procUnitMenu's mode (aBody7, from wInput0): rlOpenUnitMenu picks it from
  ; wMapStateFlags.
  UNIT_MENU_MODE_NORMAL              = 0
  UNIT_MENU_MODE_1                   = 1 ; bit 3 of wMapStateFlags; B cannot close the menu
  UNIT_MENU_MODE_2                   = 2 ; bit 4 of wMapStateFlags; no attack or Return

  ; Requests to the map battle HP windows (wMapBattleHPWindowLeftRequest/RightRequest).
  MAP_BATTLE_HP_REQUEST_EXPERIENCE   = $0100
  MAP_BATTLE_HP_REQUEST_HEAL         = $0800 ; + HP in the low byte
  MAP_BATTLE_HP_REQUEST_CLOSE        = $1000
  MAP_BATTLE_HP_REQUEST_BUSY         = $2000 ; set by the window while it drains or fills
  MAP_BATTLE_HP_REQUEST_DAMAGE       = $4000 ; + damage in the low byte

  ; The full-screen menus (engine/menus/): the status screen, the revive screen
  ; and the options menu.

  ; wGameStateStep while the status screen is up (aStatusScreenSteps).
  STATUS_SCREEN_STEP_TOP_PAGE        = $00 ; also while scrolling down
  STATUS_SCREEN_STEP_BOTTOM_PAGE     = $01 ; also while scrolling up
  STATUS_SCREEN_STEP_HOLY_BLOOD_PAGE = $02
  STATUS_SCREEN_STEP_ITEM_DETAILS    = $03
  STATUS_SCREEN_STEP_LEAVE           = $04 ; install wStatusScreenExitRoutine
  STATUS_SCREEN_STEP_LOAD_HOLY_BLOOD = $05
  STATUS_SCREEN_STEP_RETURN_TO_MAP   = $06
  STATUS_SCREEN_STEP_RETURN_TO_CASTLE = $07
  STATUS_SCREEN_STEP_SKILL_DETAILS   = $08
  STATUS_SCREEN_STEP_FADE_IN         = $09 ; then wStatusScreenStepAfterFade
  STATUS_SCREEN_STEP_FADE_OUT        = $0A ; then wStatusScreenStepAfterFade

  ; wStatusScreenReopenMode: how R or L reopen the screen for another unit.
  STATUS_SCREEN_REOPEN_TOP_PAGE      = $1234
  STATUS_SCREEN_REOPEN_BOTTOM_PAGE   = $4321
  STATUS_SCREEN_REOPEN_HOLY_BLOOD    = $1111

  ; wStatusScreenScroll at the bottom half of the stat page, and the scroll per frame.
  STATUS_SCREEN_SCROLL_BOTTOM        = $87
  STATUS_SCREEN_SCROLL_SPEED         = 7

  ; wGameStateStep while the revive screen is up (aReviveScreenSteps).
  REVIVE_SCREEN_STEP_CHOOSE_UNIT     = $00
  REVIVE_SCREEN_STEP_CONFIRM         = $01
  REVIVE_SCREEN_STEP_NOBODY_DEAD     = $02
  REVIVE_SCREEN_STEP_LEAVE_TO_STATUS = $03 ; waiting for the fade
  REVIVE_SCREEN_STEP_LEAVE_TO_CASTLE = $04 ; waiting for the fade

  ; wReviveScreenDrawMode (aReviveScreenDrawModes).
  REVIVE_SCREEN_DRAW_GRID            = 0
  REVIVE_SCREEN_DRAW_CONFIRM         = 1
  REVIVE_SCREEN_DRAW_NOTHING         = 2

  ; wGameStateStep while the options menu is up (aOptionsMenuSteps).
  OPTIONS_MENU_STEP_CHOOSE           = $00
  OPTIONS_MENU_STEP_LEAVE            = $01
  OPTIONS_MENU_STEP_RETURN_TO_MAP    = $02 ; nothing sets it
  OPTIONS_MENU_STEP_WAIT             = $03

  ; wOptionsMenuCursor: the options, in the order of aOptionsMenuValues.
  OPTION_ANIMATION                   = 0
  OPTION_TERRAIN_WINDOW              = 1
  OPTION_UNIT_WINDOW                 = 2
  OPTION_MESSAGE_SPEED               = 3
  OPTION_ENEMY_SPEED                 = 4
  OPTION_SOUND                       = 5
  OPTION_AUTO_SAVE                   = 6
  OPTION_AUTO_CURSOR                 = 7
  OPTION_ENEMY_AI                    = 8 ; shown once the game has been finished
