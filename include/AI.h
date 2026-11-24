
  structAITargetEntry .struct
    UnitRAMPointer    .word ? ; $00
    DeploymentOffset  .byte ? ; $02
    ItemROMPointer    .word ? ; $03
    ItemType          .byte ? ; $05
    BattleMight       .byte ? ; $06
    BattleDefense     .byte ? ; $07
    BattleResistance  .byte ? ; $08
    XPosition         .byte ? ; $09
    YPosition         .byte ? ; $0A
    ThreatRange       .byte ? ; $0B
    TerrainType       .byte ? ; $0C
  .endstruct

  structAIUnitEntry .struct
    UnitRAMPointer    .word ? ; $00
    DeploymentOffset  .byte ? ; $02
    ItemROMPointer    .word ? ; $03
    ItemType          .byte ? ; $05
    BattleMight       .byte ? ; $06
    BattleDefense     .byte ? ; $07
    BattleResistance  .byte ? ; $08
    XPosition         .byte ? ; $09
    YPosition         .byte ? ; $0A
    ThreatRange       .byte ? ; $0B
    XTargetPosition   .byte ? ; $0C
    YTargetPosition   .byte ? ; $0D
  .endstruct

  ; AI script commands. A group's script runs from the top at the start of each of its
  ; phases (rlRunAIScript, engine/ai/scripts.asm). Commands that give the group an
  ; objective (wAIGroupObjective) end the script; the others set options and go on. A
  ; command that finds nothing to do (a castle not held by a foe, no village left) goes
  ; on to the next one. Defaults set before the script: mode 1, no formation, the leader
  ; plans with 70% of its movement, no objective.

  AI_NO_OBJECTIVE .segment
    ; Ends the script with no objective: the group sits out this phase.
    .byte $00
  .endsegment

  AI_JUMP .segment Address
    .byte $01
    .word <>\Address
  .endsegment

  AI_SET_MODE .segment Mode
    ; Sets wAIGroupMode (attack type and related rules; see WRAM.h).
    .byte $02
    .byte \Mode
  .endsegment

  MODIFY_GROUP_LEADER_FIELD_MOVEMENT .segment Multiplier
    ; The movement the leader plans the group's waypoint with: a fraction over 256
    ; of its own, or all of it if 0. The default is 0.7.
    .byte $03
    .byte \Multiplier
  .endsegment

  AI_SET_IGNORED_GENERATION_ID .segment GenerationID
    ; The leader won't attack the player's unit with this generation ID, and
    ; AI_TARGET_ALL_FOES leaves it off the target map.
    .byte $04
    .byte \GenerationID
  .endsegment

  AI_HALVE_MOVEMENT .segment
    ; Members move with half their movement (bit $0200 of wAIGroupFlags), except on a canto move.
    .byte $05
  .endsegment

  AI_ATTACK_CASTLE .segment LocationID, Mode
    ; If an enemy army holds the castle: it becomes the target, the mode is set, and
    ; the objective is 1. Otherwise goes on.
    .byte $06
    .byte \LocationID
    .byte \Mode
  .endsegment

  AI_DEFEND_CASTLE .segment LocationID, Mode
    ; If the group's army holds the castle. With mode 5: AI_STAND_IF_FOE_IN_RANGE.
    ; Otherwise, if a member can engage a foe, AI_TARGET_ALL_FOES; if not, the castle
    ; becomes the target with this mode, objective 6, and the castle defense formation
    ; unless the script chose one.
    .byte $07
    .byte \LocationID
    .byte \Mode
  .endsegment

  AI_TARGET_VILLAGE .segment LocationID
    ; If the village is still open, it becomes the target (objective 2).
    .byte $08
    .byte \LocationID
  .endsegment

  AI_FLAG_IF_LEADER_ON_COORDS .segment ChapterID, EventFlag, LeaderCoordinates
    ; If the flag is set, goes on. If the leader stands on the tile, sets the flag and
    ; goes on; otherwise the tile becomes the target (objective 7, mode 0).
    .byte $09
    .word \ChapterID
    .byte \EventFlag
    .byte \LeaderCoordinates[0]
    .byte \LeaderCoordinates[1]
  .endsegment

  AI_CHARGE_IF_ENGAGEABLE_ELSE_HOLD .segment
    ; If a member can engage a foe this turn, AI_TARGET_ALL_FOES; otherwise objective 4,
    ; mode 4 (the group holds).
    .byte $0A
  .endsegment

  AI_STAND_IF_FOE_IN_RANGE .segment
    ; If a foe is within the group's threat range: objective 5, mode 5 (attack only
    ; from where each member stands). Otherwise goes on.
    .byte $0B
  .endsegment

  AI_SET_FORMATION .segment FormationType, FormationDirection
    ; aFormationPatternOffsets entry and starting direction (0 up, 1 right, 2 down,
    ; 3 left; turned toward the waypoint each phase except for types 0 and 13).
    .byte $0C
    .byte \FormationType
    .byte \FormationDirection
  .endsegment

  AI_TARGET_SPECIFIED_UNIT .segment CharacterID
    ; If the character is alive and not guarding a castle, it becomes the target
    ; (objective 3). Otherwise goes on.
    .byte $0D
    .word \CharacterID
  .endsegment

  AI_INTERACT_WITH_UNIT .segment CharacterID, Action
    ; The character becomes the target (objective 8): members go next to it and run
    ; Action (0 wait there, 1 attack, 12 talk; only the leader talks).
    .byte $0E
    .word \CharacterID
    .byte \Action
  .endsegment

  AI_LEADER_RETURN_HOME .segment
    ; Objective 9, mode 2: the leader goes into its army's home castle; the others
    ; act on the target map the script built.
    .byte $0F
  .endsegment

  AI_RETURN_HOME_IF_NO_TARGETS .segment
    ; If the AI has no target at all: objective 12, mode 2, everyone goes home.
    .byte $10
  .endsegment

  AI_LEADER_RETREAT_IF_GROUP_BELOW .segment Ratio
    ; Goes on if there is no living leader. If fewer than Ratio / 256 of the group's
    ; members are alive: AI_TARGET_ALL_FOES, objective 10, mode 1 (the leader goes home
    ; and revives the group's dead there, action 13; the others charge).
    .byte $11
    .byte \Ratio
  .endsegment

  AI_LEADER_HOLD .segment
    ; AI_TARGET_ALL_FOES, then objective 11, mode 2: the leader stays where it is and
    ; the others charge.
    .byte $12
  .endsegment

  AI_STAND .segment
    ; Objective 7, mode 5, no target: nobody moves, and each attacks only from its tile.
    .byte $13
  .endsegment

  AI_REINFORCE_EVERY_N_TURNS .segment Turns
    ; With a living leader, on turns divisible by Turns, revives the group's dead into
    ; the home castle (they come out through the gate) and sets bit $0080 of
    ; wAIGroupFlags. Goes on.
    .byte $14
    .byte \Turns
  .endsegment

  AI_SET_CHAPTER_EVENT_FLAG .segment ChapterID, EventFlag
    ; Any chapter but the active one doesnt work
    .byte $15
    .word \ChapterID
    .byte \EventFlag
  .endsegment

  AI_UNSET_CHAPTER_EVENT_FLAG .segment ChapterID, EventFlag
    ; Any chapter but the active one doesnt work
    .byte $16
    .word \ChapterID
    .byte \EventFlag
  .endsegment

  AI_TARGET_REMAINING_VILLAGES .segment
    ; If any village is open, objective 2 (each unit finds the nearest one it can reach).
    .byte $17
  .endsegment

  AI_TARGET_ALL_FOES .segment
    ; Every living, visible unit of an enemy army goes on the target map, except the
    ; one with wAIIgnoredGenerationID (objective 3).
    .byte $18
  .endsegment

  AI_TARGET_FOES_NOT_GUARDING .segment
    ; AI_TARGET_ALL_FOES with mode 7: foes guarding a castle are left alone, and no
    ; castle is taken.
    .byte $19
  .endsegment

  ; $1A - $1D are identical: every target with at least three open sides (empty, or
  ; held by a member of this group) goes on the target map, with objective 8 and
  ; action 1 (attack), mode 0. Goes on if there is none.

  AI_SURROUND_TARGETS_1A .segment
    ; Unused.
    .byte $1A
  .endsegment

  AI_SURROUND_TARGETS_1B .segment
    ; Unused.
    .byte $1B
  .endsegment

  AI_SURROUND_TARGETS_1C .segment
    ; Unused.
    .byte $1C
  .endsegment

  AI_SURROUND_TARGETS .segment
    .byte $1D
  .endsegment

  AI_LEADER_RETREAT_IF_HP_BELOW .segment AlwaysThreshold, FieldedThreshold
    ; Goes on if there is no living leader. If the leader's HP is at or below AlwaysThreshold
    ; / 256 of its maximum, or it is in its castle and below FieldedThreshold / 256:
    ; AI_TARGET_ALL_FOES and AI_LEADER_RETURN_HOME.
    .byte $1E
    .byte \AlwaysThreshold
    .word \FieldedThreshold
  .endsegment

  AI_JUMP_IF_TURN_REACHED .segment Turn, Address
    .byte $1F
    .byte \Turn
    .word <>\Address
  .endsegment

  AI_JUMP_IF_CHAPTER_EVENT_FLAG_SET .segment ChapterID, EventFlag, Address
    ; Any chapter but the active one doesnt work
    .byte $20
    .word \ChapterID
    .byte \EventFlag
    .word <>\Address
  .endsegment

  AI_JUMP_IF_CHAPTER_EVENT_FLAG_UNSET .segment ChapterID, EventFlag, Address
    ; Any chapter but the active one doesnt work
    .byte $21
    .word \ChapterID
    .byte \EventFlag
    .word <>\Address
  .endsegment

  AI_JUMP_IF_ENGAGEABLE .segment Address
    ; Jumps if a member can engage a foe this turn (rlAICheckIfAnyGroupUnitCanEngageFoe).
    .byte $22
    .word <>\Address
  .endsegment

  AI_ASMC_CHECK .segment Routine, Address
    ; Calls Routine; jumps if it returns carry set.
    .byte $23
    .long \Routine
    .word <>\Address
  .endsegment

  AI_END .segment
    ; Ends the script; whatever objective is set stands.
    .byte $FF
  .endsegment
