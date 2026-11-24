
    ; Script commands for the event script engine (rlRunEventCommand, aEventCommandPointers).
    ; Each command is an opcode byte and its parameters. A handler returns carry clear to
    ; go on to the next command in the same frame, or carry set to stop for this frame.
    ; A command that starts an event proc doesn't stop the script: the commands after it
    ; run until the next YIELD, and at the start of each later frame the script waits
    ; until every event proc it started has ended. Wait commands that poll (the map
    ; sprite ones) step back to their own opcode and stop, so they run again next frame.
    ; Most procs read their parameters from the script themselves, in their init routine,
    ; at wActiveEventOffset. Guide: docs/guide/12-screenplays.md.

    YIELD .segment
      ; Ends the script's work for this frame.
      .byte $FD
    .endsegment

    END_EVENT .segment
      .word $FFFF
    .endsegment

    SKIP_POINT .segment
      ; Marks where Start would skip the script to: rsGetEventLength records the offset
      ; after it in wActiveEventLength when the script begins, and the interpreter steps
      ; over it. The routine that would skip there (rsCheckSkipActiveEventUnused) has no
      ; caller, so scripts can't be skipped. Every use is in a chapter opening, just
      ; before the setup at its end (fade out, deploy, RELOAD_MAP_SCREEN).
      .word $FEFE
    .endsegment

    EVENT_00 .segment Length
      ; Unused.
      ; Calls a proc "NP" that does nothing anymore.
      .byte $00
      .byte \Length
    .endsegment

    EVENT_01 .segment
      ; Unused.
      ; Writes 2 to wEventEngineState.
      .byte $01
    .endsegment

    JUMP .segment Address
      ; Address is a 16-bit address in the script's own bank.
      .byte $02
      .addr \Address
    .endsegment

    JUMP_TRUE .segment Address
      ; Jumps if wEventEngineTruthFlag is set.
      .byte $03
      .addr \Address
    .endsegment

    JUMP_FALSE .segment Address
      ; Jumps if wEventEngineTruthFlag is unset.
      .byte $04
      .addr \Address
    .endsegment

    JUMP_RELATIVE_TRUE .segment Address
      ; Unused. The relative jumps work in a script copied to RAM, where JUMP's
      ; address (an offset in the script's ROM bank) would be wrong.
      ; Modifies the distance if wEventEngineTruthFlag is set.
      ; The distance is measured from the beginning of the command.
      .byte $05
      .sint (\Address) - *
    .endsegment

    JUMP_RELATIVE_FALSE .segment Address
      ; Used once, by the song-and-dialogue template copied to RAM (death_quotes.asm).
      ; Modifies the distance if wEventEngineTruthFlag is unset.
      ; The distance is measured from the beginning of the command.
      .byte $06
      .sint (\Address) - *
    .endsegment

    TEST_PERMANENT_FLAG_SET .segment EventFlag
      ; Sets wEventEngineTruthFlag to 1 if the permanent flag is set, 0 if not.
      .byte $07
      .byte \EventFlag
    .endsegment

    TEST_FLAG_IN_CHAPTER_SET .segment ChapterID, EventFlag
      ; Sets wEventEngineTruthFlag if flag is set in chapter.
      ; Only works if specified chapter is the current one; for any other chapter
      ; the truth flag keeps whatever the last test left in it.
      .byte $08
      .byte \ChapterID
      .byte \EventFlag
    .endsegment

    CHANGE_PALETTE_PROC .segment PalettePointer, ChangeData
      ; Unused.
      ; Kind of janky command to write a bunch of colors to
      ; the aBGPaletteBuffer.
      ; First pointer points to several color words.
      ; Second pointer points to:
      ; - A byte for the aBGPaletteBuffer color ID.
      ; - A byte for the palette count to copy.
      ; - A byte for the color offset for the first pointer.
      ; - A byte for a timer thats pretty much useless as the proc code consists of one HALT.
      ; - A 2nd version of the previous 2 bytes that have priority if the timer isn't 0.
      .byte $09
      .long PalettePointer
      .long ChangeData
    .endsegment

    EVENT_0A .segment
      ; Unused except for one debug event.
      ; Resets the Dialogue engine and a bunch of registers around $0516?
      .byte $0A
    .endsegment

    EVENT_0B .segment
      ; Unused.
      ; Resets bit $80 of $0521?
      ; May prevent BG3 tilemap modification?
      .byte $0B
    .endsegment

    DIALOGUE .segment DialoguePointer
      .byte $0C
      .long \DialoguePointer
    .endsegment

    CASTLE_NAME .segment NamePointer, Color, Duration
      .byte $0D
      .long \NamePointer
      .byte \Color
      .byte \Duration
    .endsegment

    PLAY_SONG .segment SongID
      ; Sets wMusicID and stops for this frame; the script then waits while a map
      ; battle (procMapBattle) is running.
      .byte $0E
      .byte \SongID
    .endsegment

    ; $0F and $10 are the same

    EVENT_0F .segment SoundID
      ; Unused.
      ; Played if $04EA doesnt have $0001 set
      .byte $0F
      .byte \SoundID
    .endsegment

    EVENT_10 .segment SoundID
      ; Unused.
      ; Played if $04EA doesnt have $0001 set
      .byte $10
      .byte \SoundID
    .endsegment

    PLAY_SFX_BYTE .segment SoundID
      ; Played if $04EA doesnt have $0004 set
      .byte $11
      .byte \SoundID
    .endsegment

    PLAY_SFX_WORD .segment SoundID
      ; JP notes say adjust volume?
      .byte $12
      .word \SoundID
    .endsegment

    RESTORE_PHASE_MUSIC .segment
      ; Resumes the phase music; the script then waits while a map battle is running.
      .byte $13
    .endsegment

    DIALOGUE_WITH_BG .segment DialoguePointer, BackgroundID, DialogueType, FadeTimer
      .byte $14
      .long \DialoguePointer
      .byte \BackgroundID
      .byte \DialogueType
      .byte \FadeTimer
    .endsegment

    EVENT_15 .segment DialoguePointer, BackgroundID, DialogueType, FadeTimer
      ; Unused.
      ; Essentially identical to DIALOGUE_WITH_BG. This one tries to set the DialogueType
      ; to 1 instead of 0 before getting overwritten with the value specified in the segment.
      .byte $15
      .long \DialoguePointer
      .byte \BackgroundID
      .byte \DialogueType
      .byte \FadeTimer
    .endsegment

    LOVER_HOME_CASTLE .segment
      ; Unused.
      ; Forcibly triggers the talk convo when a lover enters
      ; the home castle while the other is already there.
      ; Requires the selected unit to have a lover, and that one
      ; has to be within the home castle and be alive.
      .byte $16
    .endsegment

    BERSERK_CAST .segment Coordinates
      .byte $17
      .byte \Coordinates[0]
      .byte \Coordinates[1]
    .endsegment

    ; Command $18 doesn't exist

    EVENT_19 .segment UnknownPointer, UnknownValue
      ; Unused.
      ; Sets up dialogue values, but then calls a routine that does nothing.
      .byte $19
      .long \UnknownPointer
      .long \UnknownValue
    .endsegment

    EVENT_1A .segment
      ; Unused.
      ; DMA's dialogue data set up by EVENT_1B.
      .byte $1A
    .endsegment

    EVENT_1B .segment UnknownPointer
      ; Unused.
      ; Sets the pointer for EVENT_1A to DMA.
      .byte $1B
      .long \UnknownPointer
    .endsegment

    CHANGE_DIALOGUE .segment DialoguePointer
      ; Unused.
      ; Overwrites the active dialogue pointer.
      .byte $1C
      .long \DialoguePointer
    .endsegment

    EVENT_1D .segment
      ; Unused.
      ; Clears currently moving map sprites?
      .byte $1D
    .endsegment

    ; Command $1E doesn't exist.

    CREATE_HDMA .segment HDMAPointer
      ; Unused.
      .byte $1F
      .long \HDMAPointer
    .endsegment

    EVENT_20 .segment DMAPointer, Destination, Size
      ; Unused.
      ; Resets sprite engine and then DMA's data.
      .byte $20
      .long \DMAPointer
      .word \Destination
      .word \Size
    .endsegment

    CREATE_SPRITE .segment SpritePointer, Unknown1, Unknown2
      ; Unused.
      .byte $21
      .long \SpritePointer
      .word \Unknown1
      .word \Unknown2
    .endsegment

    MOVE_TEMPORARY_TO_COORDS .segment CharacterID, StartCoordinates, DestinationCoordinates, MovementSpeed, UnitSlot, SpriteColor, DisappearOffscreenFlag=false, UnknownFlag=false
      ; The unit specified does not need to be loaded, and wont be loaded via this.
      ; This is purely visual.
      .byte $22
      .word \CharacterID
      .char \StartCoordinates[0]
      .char \StartCoordinates[1]
      .byte \DestinationCoordinates[0]
      .byte \DestinationCoordinates[1]
      .byte (\MovementSpeed & $0F | int(\DisappearOffscreenFlag) << 4 | (\UnitSlot & $03) << 5 | int(\UnknownFlag)<<7)
      .byte \SpriteColor
    .endsegment

    LOAD_UNIT_BY_GROUP .segment UnitGroupID, IDInGroup, StartCoordinates, MovementSpeed, SpriteColor
      ; Loads a unit specified in UNITGroupData, hidden, and walks it from StartCoordinates
      ; to its own tile in the group (a route planned by the map main loop); it is shown
      ; when it arrives. SpriteColor is read and then replaced by the color of the unit's
      ; allegiance (aEventUnitAllegianceValues), so it has no effect.
      .byte $23
      .byte \UnitGroupID
      .word \IDInGroup
      .byte \StartCoordinates[0]
      .byte \StartCoordinates[1]
      .byte \MovementSpeed ; 0 - 7
      .byte \SpriteColor
    .endsegment

    LOAD_UNIT_DIRECT .segment CharacterID, FactionSlot, StartCoordinates, DestinationCoordinates, MovementSpeed, SpriteColor, GroupLeaderFlag=false, AISetting=0
      ; Loads a unit outside UNITGroupData.
      .byte $24
      .word \CharacterID
      .byte \FactionSlot
      .byte \StartCoordinates[0]
      .byte \StartCoordinates[1]
      .byte \DestinationCoordinates[0]
      .byte \DestinationCoordinates[1]
      .byte \MovementSpeed
      .byte \SpriteColor
      .byte int(\GroupLeaderFlag) << 7 | \AISetting & $0F
    .endsegment

    MOVE_TEMPORARY_TO_COORDS_FOLLOW .segment CharacterID, StartCoordinates, DestinationCoordinates, MovementSpeed, UnitSlot, SpriteColor
      ; The unit specified does not need to be loaded, and wont be loaded via this.
      ; This is purely visual.
      ; Camera will follow unit if they get too close to the screen edge.
      .byte $25
      .word \CharacterID
      .char \StartCoordinates[0]
      .char \StartCoordinates[1]
      .byte \DestinationCoordinates[0]
      .byte \DestinationCoordinates[1]
      .byte (\MovementSpeed & $0F | (\UnitSlot & $03) << 5)
      .byte \SpriteColor
    .endsegment

    MOVE_TEMPORARY_TO_COORDS_CLASS .segment CharacterID, StartCoordinates, DestinationCoordinates, MovementSpeed, SpriteColor, FactionSlot, MapSprite=0, DisappearOffscreenFlag=false
      ; Used only by the attract mode's opening (engine/demo/opening.asm).
      ; If a map sprite is specified, use that instead of the characters regualar sprite
      .byte $26
      .word \CharacterID
      .byte \StartCoordinates[0]
      .byte \StartCoordinates[1]
      .byte \DestinationCoordinates[0]
      .byte \DestinationCoordinates[1]
      .byte (\MovementSpeed & $0F | int(\DisappearOffscreenFlag) << 4)
      .byte \SpriteColor
      .byte \FactionSlot
      .word \MapSprite
    .endsegment

    MOVE_TEMPORARY_BY_SCRIPT .segment CharacterID, StartCoordinates, MovementSpeed, SpriteColor, MovementScriptPointer, DisappearOffscreenFlag=false
      ; The unit specified does not need to be loaded, and wont be loaded via this.
      ; This is purely visual.
      .byte $27
      .word \CharacterID
      .byte \StartCoordinates[0]
      .byte \StartCoordinates[1]
      .byte (\MovementSpeed & $0F | int(\DisappearOffscreenFlag) << 4)
      .byte \SpriteColor
      .long \MovementScriptPointer
    .endsegment

    LOAD_UNIT_BY_GROUP_SILENT .segment UnitGroupID, IDInGroup
      .byte $28
      .byte \UnitGroupID
      .word \IDInGroup
    .endsegment

    WAIT_UNIT_SPRITE_DECOMPRESSED .segment
      ; Waits (re-running each frame) until no decompression is queued and
      ; aMovingMapSprites.wState is 0, which means the map main loop has planned the
      ; last queued unit's route (rlPlanQueuedMapSpriteMovement).
      .byte $29
    .endsegment

    WAIT_UNTIL_MAP_SPRITES_HALTING .segment
      ; Waits until every map sprite finished moving or until
      ; everyone executed a MS_HALT command, then continues with
      ; event execution.
      .byte $2A
    .endsegment

    CONTINUE_FORM_MAP_SPRITE_HALT .segment
      ; This is the counterpart to the previous command and
      ; continues with map sprite movement that was halted before.
      .byte $2B
    .endsegment

    EVENT_2C .segment
      ; Unused.
      ; Clears all moving map sprites?
      .byte $2C
    .endsegment

    CHANGE_PALETTE .segment SourcePointer, PaletteID, PaletteCount
      ; Unused.
      ; PaletteID 0 writes to aBGPaletteBuffer.aPalette0, ID1 to aPalette1 and so on.
      .byte $2D
      .long \SourcePointer
      .byte \PaletteID
      .byte \PaletteCount
    .endsegment

    PALETTE_SWAP .segment FirstPalettePointer, SecondPalettePointer, Timer, ColorOffset, Size
      ; Unused.
      .byte $2E
      .long \FirstPalettePointer
      .long \SecondPalettePointer
      .byte \Timer
      .word \ColorOffset
      .word \Size
    .endsegment

    STORE_WORD .segment Address, Value
      ; Unused.
      .byte $2F
      .long \Address
      .word \Value
    .endsegment

    EVENT_30 .segment EventPointer, CycleCounter
      ; Unused.
      ; EventPointer needs to be in the same bank this command was called from.
      ; First word needs to be a short pointer to ASMC in bank $91.
      ; Only runs for X many specified cycles.
      ; If CycleCounter = -1, keep running until event ends.
      .byte $30
      .long \EventPointer
      .byte \CycleCounter
    .endsegment

    EVENT_31 .segment
      ; Unused.
      ; Does nothing.
      .byte $31
    .endsegment

    EVENT_32 .segment
      ; Unused.
      ; Does nothing.
      .byte $32
    .endsegment

    RESET_SPRITE_ENGINE .segment
      ; Unused.
      ; Just resets the active sprite engine.
      .byte $33
    .endsegment

    PAUSE .segment Timer
      .byte $34
      .word \Timer
    .endsegment

    EVENT_35 .segment
      ; Unused.
      ; Creates a proc that exists until A, B, X or Y is pressed.
      .byte $35
    .endsegment

    EVENT_36 .segment Timer
      ; Unused.
      ; Like EVENT_35, but also gets cleared when the timer hits 0.
      .byte $36
      .word \Timer
    .endsegment

    EVENT_37 .segment
      ; Unused.
      ; Sets up some background registers?
      .byte $37
    .endsegment

    EVENT_38 .segment
      ; Unused.
      ; Sets up some background registers?
      .byte $38
    .endsegment

    SET_CAMERA_TO_EVENT_UNIT_SLOT_1 .segment
      .byte $39
    .endsegment

    SET_CAMERA_POSITION .segment Coordinates
      .byte $3A
      .byte \Coordinates[0]
      .byte \Coordinates[1]
    .endsegment

    RELOAD_MAP_SCREEN .segment Mode
      ; Fades out over (Mode & $3F) frames and rebuilds the map screen through
      ; rsReturnToMapMainLoop, with wMainGameMode 3 if bit 7 is set, 2 if bit 6 is set,
      ; and 0 otherwise. With bit 7 the script goes on once the map is rebuilt and the
      ; screen is still dark, for a FADE_IN_BY_TIMER; otherwise it waits for the fade-in
      ; to full brightness (procEventWaitFadeToMap). Chapter openings use $80 to show
      ; the map after the opening list has set it up, and 1 after deploying the army.
      .byte $3B
      .byte \Mode
    .endsegment

    EVENT_3C .segment
      ; Unused.
      ; Background stuff?
      .byte $3C
    .endsegment

    EVENT_3D .segment
      ; Unused.
      ; Background stuff?
      .byte $3D
    .endsegment

    EVENT_3E .segment Unknown1, Unknown2
      ; Unused.
      ; ?
      .byte $3E
      .word \Unknown1
      .byte \Unknown2
    .endsegment

    SCRIPTED_MAP_SCROLL .segment ScriptPointer, ScrollSpeed
      .byte $3F
      .long \ScriptPointer
      .byte \ScrollSpeed
    .endsegment

    MAP_SCROLL .segment Coordinates, ScrollSpeed
      .byte $40
      .byte \Coordinates[0]
      .byte \Coordinates[1]
      .byte \ScrollSpeed
    .endsegment

    MAP_SCROLL_TO_EVENT_UNIT_SLOT_1 .segment ScrollSpeed
      .byte $41
      .byte \ScrollSpeed
    .endsegment

    FILL_EVENT_UNIT_SLOT .segment CharacterID, Slot
      ; Stores the unit's RAM pointer and tile in wEventUnitSlot1Pointer/2Pointer and the
      ; slot's coordinates. If the unit isn't found, the coordinates become $FFFF and
      ; the commands that read the slot do nothing.
      .byte $42
      .word \CharacterID
      .byte \Slot >> 1
    .endsegment

    FILL_EVENT_UNIT_SLOT_BY_COORDS .segment Coordinates, Slot
      .byte $43
      .byte \Coordinates[0]
      .byte \Coordinates[1]
      .byte \Slot >> 1
    .endsegment

    FACTION_UNIT_DEATH .segment FactionSlot, AISetting=$FF, CharacterID=$FFFF
      ; Handles the flickering of units on the map, simulating their death.
      ; Basically what seizing a castle does to remaining units of a faction, but on demand.
      .byte $44
      .byte \FactionSlot
      .char \AISetting
      .sint \CharacterID
    .endsegment

    RUN_ASM .segment Address
      ; Calls the routine (an ASMC) at once. It can block the script by creating an
      ; event proc (rlEventEngineCreateProc), as rlASMCStatUpDisplay does.
      .byte $45
      .long \Address
    .endsegment

    FADE_IN_BY_TIMER .segment Timer
      .byte $46
      .byte \Timer
    .endsegment

    FADE_OUT_BY_TIMER .segment Timer
      .byte $47
      .byte \Timer
    .endsegment

    EVENT_48 .segment Unknown1, Unknown2
      ; Unused.
      ; Tries to create a map menu?
      .byte $48
      .byte \Unknown1
      .long \Unknown2
    .endsegment

    EVENT_49 .segment Unknown
      ; Unused.
      ; Tries to load created menu by EVENT_48?
      .byte $49
      .byte \Unknown
    .endsegment

    RUN_EVENT_CONDITION .segment
      ; Followed by one condition-list command (include/events/Conditions.h), which
      ; rlTryRunEventConditionCommand runs in run mode; the script goes on after it.
      .byte $4A
    .endsegment

    SET_FLAG_IF_IN_CHAPTER .segment Chapter, EventFlag
      ; If the specified chapter matches the current one, set the
      ; specified event flag.
      .byte $4B
      .byte \Chapter
      .byte \EventFlag
    .endsegment

    UNSET_FLAG_IF_IN_CHAPTER .segment Chapter, EventFlag
      ; If the specified chapter matches the current one, unset the
      ; specified event flag.
      .byte $4C
      .byte \Chapter
      .byte \EventFlag
    .endsegment

    RUN_EVENT_CONDITION_AND_WAIT .segment
      ; Runs one condition-list command like RUN_EVENT_CONDITION, then waits until bit 0
      ; of bUnknown000E7B is clear, and 4 frames more (procEventWaitFlag0E7B). The prologue
      ; uses it for SET_SCRIPTED_ACTION, which sets that bit; the battle scene clears it
      ; when the scripted action's fight ends.
      .byte $4D
    .endsegment

    EVENT_4E .segment DialoguePointer
      ; Unused.
      ; Uses the same proc as WM_DIALOGUE but does something slightly different?
      .byte $4E
      .long \DialoguePointer
    .endsegment

    WM_FADE_IN .segment
      .byte $4F
    .endsegment

    WM_FADE_OUT .segment
      .byte $50
    .endsegment

    WM_SCROLL .segment Coordinates
      .byte $51
      .word \Coordinates[0]
      .word \Coordinates[1]
    .endsegment

    WM_MARKER .segment Coordinates, Slot, Type
      .byte $52
      .byte \Coordinates[0]
      .byte \Coordinates[1]
      .byte \Slot
      .byte \Type
    .endsegment

    WM_CLEAR_MARKER .segment Slot
      .byte $53
      .byte \Slot
    .endsegment

    WM_LOAD_PORTRAIT .segment Slot, Portrait
      .byte $54
      .byte \Slot
      .word \Portrait
    .endsegment

    WM_FADE_IN_PORTRAIT .segment Slot, Coordinates
      .byte $55
      .byte \Slot
      .byte \Coordinates[0]
      .byte \Coordinates[1]
    .endsegment

    WM_FADE_OUT_PORTRAIT .segment Slot
      .byte $56
      .byte \Slot
    .endsegment

    WM_MOVE_PORTRAIT .segment Slot, Coordinates
      .byte $57
      .byte \Slot
      .byte \Coordinates[0]
      .byte \Coordinates[1]
    .endsegment

    WM_DIALOGUE .segment DialoguePointer
      .byte $58
      .long \DialoguePointer
    .endsegment

    EVENT_59 .segment
      ; Unused.
      ; Does nothing.
      .byte $59
    .endsegment

    WM_CLEAR_DIALOGUE .segment
      ; Clears WM_DIALOGUE proc and the BG2 buffer (Used for the fading, glowing location indicators).
      .byte $5A
    .endsegment

    WM_HIGHLIGHT .segment Part
      .byte $5B
      .byte \Part
    .endsegment

    WM_CLEAR_HIGHLIGHT .segment
      .byte $5C
    .endsegment

    DEMO_ALLOW_SKIP .segment
      ; The attract mode's opening: when the event ends or Start is pressed,
      ; fade out and go to the title screen, skipping its intro (procDemoSkipFadeOut,
      ; rsOpenTitleScreenWithoutIntro). Also sets $1832 (see the command routine).
      .byte $5D
    .endsegment

    OPEN_TITLE_SCREEN .segment
      ; Flashes in the title screen (rlFlashToTitleScreen, rsOpenTitleScreen).
      .byte $5E
    .endsegment
