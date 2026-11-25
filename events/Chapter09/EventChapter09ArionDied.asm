
  aEventChapter09ArionDied ; B1/DBC2

    RUN_EVENT_CONDITION
      REGISTER_CHARACTER_MAP_SPRITE JuliusChFinal

    PAUSE 20
    YIELD

    PLAY_SFX_WORD $00E0
    PAUSE 35
    YIELD

    PLAY_SONG $83
    YIELD

    FILL_EVENT_UNIT_SLOT ArionCh09, EventUnitSlot1
    MAP_SCROLL_TO_EVENT_UNIT_SLOT_1 3
    YIELD

    PAUSE 2
    YIELD

    FILL_EVENT_UNIT_SLOT ArionCh09, EventUnitSlot1
    RUN_ASM rlASMCChapter09JuliusWarpInStart
    RUN_ASM rlASMCChapter09DeployJulius
    YIELD

    PAUSE 2
    YIELD

    RUN_ASM rlASMCChapter09UnhideJulius
    PAUSE 10
    YIELD

    DIALOGUE dialogueChapter09ArionDied
    YIELD

    FILL_EVENT_UNIT_SLOT ArionCh09, EventUnitSlot1
    RUN_ASM rlASMCChapter09WarpAway
    YIELD

    FILL_EVENT_UNIT_SLOT JuliusChFinal, EventUnitSlot1
    RUN_ASM rlASMCChapter09WarpAway
    YIELD

    RUN_EVENT_CONDITION
      REMOVE_UNIT ArionCh09

    RUN_EVENT_CONDITION
      REMOVE_UNIT JuliusChFinal

    PLAY_SFX_WORD $00E0
    PAUSE 35
    YIELD

    RESTORE_PHASE_MUSIC
    YIELD

    RUN_ASM rlASMCLoadActiveUnitCoordinatesInEventUnitSlot1
    MAP_SCROLL_TO_EVENT_UNIT_SLOT_1 4
    YIELD

    SET_CURSOR_TO_EVENT_UNIT_SLOT_1

    END_EVENT

  rlASMCChapter09JuliusWarpInStart ; B1/DC2A

    .al
    .autsiz
    .databank ?

    lda #ArionCh09
    sta wRoutineVariable1
    jsl rlEventJuliusWarpInStart
    rtl

    .databank 0

  rlASMCChapter09DeployJulius ; B1/DC36

    .al
    .autsiz
    .databank ?

    ldx #4
    jsl rlEventDeployJuliusChFinal
    rtl

    .databank 0

  rlASMCChapter09UnhideJulius ; B1/DC3E

    .al
    .autsiz
    .databank ?

    jsl rlEventUnhideJuliusChFinal
    rtl

    .databank 0

  rlASMCChapter09WarpAway ; B1/DC43

    .al
    .autsiz
    .databank ?

    jsl rlStartWarpAwayAnimation
    jsl rlCreateProcHaltEvent
    rtl

    .databank 0
