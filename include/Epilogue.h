  ; The epilogue (engine/epilogue/).

  ; wEpiloguePart: which part rsOpenEpilogueScreen starts (engine/epilogue/).
  EPILOGUE_PART_ENDINGS           = 0 ; work out the endings, then the world map epilogue
  EPILOGUE_PART_CREDITS           = 1
  EPILOGUE_PART_RECORDS           = 2 ; the play record and the ranking screen
  EPILOGUE_PART_CHARACTER_ENDINGS = 3

  ; wGameStateStep while the epilogue runs (aEpilogueStepRoutines).
  EPILOGUE_STEP_SHOW_TEXT         = 0
  EPILOGUE_STEP_HOLD_TEXT         = 1
  EPILOGUE_STEP_SET_UP_CREDITS    = 2
  EPILOGUE_STEP_START_CREDITS     = 3
  EPILOGUE_STEP_SCROLL_CREDITS    = 4
  EPILOGUE_STEP_WORLD_MAP         = 5
  EPILOGUE_STEP_SET_UP_RECORDS    = 6
  EPILOGUE_STEP_SCROLL_RECORDS    = 7
  EPILOGUE_STEP_START_CHARACTER_ENDINGS = 8
  EPILOGUE_STEP_NEXT_CHARACTER_ENDING   = 9
  EPILOGUE_STEP_FADE_OUT          = 10 ; then the step in wNextMenuState
  EPILOGUE_STEP_FADE_IN           = 11 ; likewise
  EPILOGUE_STEP_START_WORLD_MAP   = 12
  EPILOGUE_STEP_SHOW_END_SCREEN   = 13
  EPILOGUE_STEP_WAIT_END_SCREEN   = 14
  EPILOGUE_STEP_SHOW_RANKING      = 15
  EPILOGUE_STEP_WAIT_RANKING      = 16
  EPILOGUE_STEP_SECRET_CODE       = 17
  EPILOGUE_STEP_END               = 18
