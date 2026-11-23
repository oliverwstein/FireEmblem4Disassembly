
  ; The battle scene (game states $18 and $19; engine/battle_scene/).
  ; Its RAM is in WRAM.h ("The battle scene").

  ; Each combatant's record (aBattleSceneCombatant1 and 2), filled from the
  ; action structs by rsBattleSceneCopyCombatants.

    structBattleSceneCombatant .struct
      Class      .word ? ; $00
      Character  .word ? ; $02 ; 0: no combatant on this side
      Weapon     .word ? ; $04 ; only the low byte is read
      HP         .word ? ; $06 ; 8.8: the whole points are the high byte
      MaxHP      .byte ? ; $08
      HPSpeed    .word ? ; $09 ; 8.8 points a frame, negative for a loss; 0 when still
      HPTarget   .byte ? ; $0B
      Gender     .byte ? ; $0C
      AnimStyle  .byte ? ; $0D ; low nibble the attack style, high nibble the AnimCategory
    .endstruct

  ; Bits of wBattleSceneFlags, set by rlBattleSceneSetFlags and rsBattleSceneSetWaterFlags.

    BattleSceneFlagMelee          = bits($0001) ; battle distance under 2, not battle type 2
    BattleSceneFlagBattleType2    = bits($0002) ; wBattleType 2: no quotes, no foreground
    BattleSceneFlagSolo           = bits($0004) ; aActionStructUnit1.Unknown is 8: both stand at the center
    BattleSceneFlagSolo2          = bits($0008) ; set with BattleSceneFlagSolo
    BattleSceneFlagSea            = bits($0010)
    BattleSceneFlagRiver          = bits($0020)
    BattleSceneFlagHolyWeapon2    = bits($0040) ; combatant 2 carries a holy weapon; cleared at its first round
    BattleSceneFlagHolyWeapon1    = bits($0080) ; the same for combatant 1
    BattleSceneFlagListedWeapon1  = bits($0100) ; combatant 1's weapon is in aUnknown998F02
    BattleSceneFlagListedWeapon2  = bits($0200)
    BattleSceneFlagToMapMode3     = bits($0400) ; on leaving, wMainGameMode 3 (rlBattleSceneStep)

  ; Bits of bBattleSceneRoundState.

    BattleSceneRoundMayRun        = bits($01) ; the intro is over (rlBattleSceneCheckIntroDone)
    BattleSceneRoundAllRead       = bits($02) ; the last round has been read
    BattleSceneRoundHeld          = bits($08) ; cleared by a countdown or Start (rsUnknown959C14)
    BattleSceneRoundArenaNextBout = bits($10) ; the arena round list ended with $FEFF: fight again
    BattleSceneRoundMissed        = bits($40) ; the current strike misses
    BattleSceneRoundArenaRetreat  = bits($80) ; B was pressed in the arena (rlBattleSceneReadArenaRetreat)
