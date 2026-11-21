; Battle animation move programs: action, move list and movement script tables
; reached from aBattleAnimationPrograms. Written by tools/battle_moves.py;
; formats and macros in include/BattleAnimation.h.

    .section BattleAnimationMoveDataSection

      aBattleAnimationActionsMyrmidonSword ; 97/CA8B

        ; Move program of entry 1 of aBattleAnimationPrograms, used by: Myrmidon (Sword).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 20
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 4
        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 14
        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 3
        ANIM_ACTION_SEQUENCE 31
        ANIM_ACTION_SEQUENCE 31

      aBattleAnimationMoveListsMyrmidonSword ; 97/CAC4

        .word _List00 - aBattleAnimationMoveListsMyrmidonSword
        .word _List01 - aBattleAnimationMoveListsMyrmidonSword
        .word _List02 - aBattleAnimationMoveListsMyrmidonSword
        .word _List03 - aBattleAnimationMoveListsMyrmidonSword
        .word _List04 - aBattleAnimationMoveListsMyrmidonSword
        .word _List05 - aBattleAnimationMoveListsMyrmidonSword
        .word _List06 - aBattleAnimationMoveListsMyrmidonSword
        .word _List07 - aBattleAnimationMoveListsMyrmidonSword
        .word _List08 - aBattleAnimationMoveListsMyrmidonSword
        .word _List09 - aBattleAnimationMoveListsMyrmidonSword
        .word _List10 - aBattleAnimationMoveListsMyrmidonSword
        .word _List11 - aBattleAnimationMoveListsMyrmidonSword
        .word _List12 - aBattleAnimationMoveListsMyrmidonSword
        .word _List13 - aBattleAnimationMoveListsMyrmidonSword
        .word _List14 - aBattleAnimationMoveListsMyrmidonSword
        .word _List15 - aBattleAnimationMoveListsMyrmidonSword
        .word _List16 - aBattleAnimationMoveListsMyrmidonSword
        .word _List17 - aBattleAnimationMoveListsMyrmidonSword
        .word _List18 - aBattleAnimationMoveListsMyrmidonSword
        .word _List19 - aBattleAnimationMoveListsMyrmidonSword
        .word _List20 - aBattleAnimationMoveListsMyrmidonSword

      _List00
        ANIM_MOVE_SCRIPT 1, 0
        ANIM_MOVE_ROUTINE_ARG 11, 10, $2820
        ANIM_MOVE_STILL 5
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 17, 0
        ANIM_MOVE_SCRIPT 5, 8
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 7, 2
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_STILL 12
        ANIM_MOVE_STILL 5
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 9, 3
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 13, 4
        ANIM_MOVE_ROUTINE 14, 14
        ANIM_MOVE_ROUTINE 14, 4
        ANIM_MOVE_STILL 15
        ANIM_MOVE_STILL 16
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_SCRIPT 21, 7
        ANIM_MOVE_STILL 5
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_SCRIPT 21, 7
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 17, 0
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_SCRIPT 1, 0
        ANIM_MOVE_ROUTINE_ARG 18, 10, $2820
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_STILL 22
        ANIM_MOVE_ROUTINE_ARG 19, 12, $0710
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_SCRIPT 20, 5
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_STILL 14
        ANIM_MOVE_ROUTINE 14, 14
        ANIM_MOVE_ROUTINE 15, 4
        ANIM_MOVE_STILL 16
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_SCRIPT 10, 9
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_SCRIPT 23, 7
        ANIM_MOVE_LIST_END

      _List15
        ANIM_MOVE_SCRIPT 24, 10
        ANIM_MOVE_LIST_END

      _List16
        ANIM_MOVE_SCRIPT 25, 11
        ANIM_MOVE_LIST_END

      _List17
        ANIM_MOVE_ROUTINE 26, 9
        ANIM_MOVE_ROUTINE 28, 4
        ANIM_MOVE_SCRIPT 5, 8
        ANIM_MOVE_LIST_END

      _List18
        ANIM_MOVE_ROUTINE 26, 9
        ANIM_MOVE_ROUTINE 28, 4
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List19
        ANIM_MOVE_SCRIPT 29, 13
        ANIM_MOVE_LIST_END

      _List20
        ANIM_MOVE_SCRIPT 30, 14
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsMyrmidonSword ; 97/CB63

        .word _Script00 - aBattleAnimationMoveScriptsMyrmidonSword
        .word _Script01 - aBattleAnimationMoveScriptsMyrmidonSword
        .word _Script02 - aBattleAnimationMoveScriptsMyrmidonSword
        .word _Script03 - aBattleAnimationMoveScriptsMyrmidonSword
        .word _Script04 - aBattleAnimationMoveScriptsMyrmidonSword
        .word _Script05 - aBattleAnimationMoveScriptsMyrmidonSword
        .word _Script06 - aBattleAnimationMoveScriptsMyrmidonSword
        .word _Script07 - aBattleAnimationMoveScriptsMyrmidonSword
        .word _Script08 - aBattleAnimationMoveScriptsMyrmidonSword
        .word _Script09 - aBattleAnimationMoveScriptsMyrmidonSword
        .word _Script10 - aBattleAnimationMoveScriptsMyrmidonSword
        .word _Script11 - aBattleAnimationMoveScriptsMyrmidonSword
        .word _Script12 - aBattleAnimationMoveScriptsMyrmidonSword
        .word _Script13 - aBattleAnimationMoveScriptsMyrmidonSword
        .word _Script14 - aBattleAnimationMoveScriptsMyrmidonSword

      _Script00
        .char -10, -8, -11, -11

      _Script01
        .char 2, 2, 0

      _Script02
        .char 0, 8, 4, 0

      _Script03
        .char 0, 0, 0, 0, 0, -4, 0, 0, 0, 0, 0, 0, 0

      _Script04
        .char 0, 4, 0

      _Script05
        .char 0, -5, -11

      _Script06
        .char 0, -2, 0

      _Script07
        .char 0, -5, -9, 0

      _Script08
        .char -6, 0, 0, 0, 0, 0

      _Script09
        .char 0, 2, 13, 0, 0, -13, 2

      _Script10
        .char 0, -2, -4, -8

      _Script11
        .char 0, 2

      _Script12
        .char -12, -8

      _Script13
        .char 0, 9, -2

      _Script14
        .char 8, 5, 2, 0, 5, 0

      aBattleAnimationActionsSwordmasterSword ; 97/CBC4

        ; Move program of entry 2 of aBattleAnimationPrograms, used by: Swordmaster (Sword), Hero
        ; (Sword).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 20
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8

      aBattleAnimationMoveListsSwordmasterSword ; 97/CBFB

        .word _List00 - aBattleAnimationMoveListsSwordmasterSword
        .word _List01 - aBattleAnimationMoveListsSwordmasterSword
        .word _List02 - aBattleAnimationMoveListsSwordmasterSword
        .word _List03 - aBattleAnimationMoveListsSwordmasterSword
        .word _List04 - aBattleAnimationMoveListsSwordmasterSword
        .word _List05 - aBattleAnimationMoveListsSwordmasterSword
        .word _List06 - aBattleAnimationMoveListsSwordmasterSword
        .word _List07 - aBattleAnimationMoveListsSwordmasterSword
        .word _List08 - aBattleAnimationMoveListsSwordmasterSword
        .word _List09 - aBattleAnimationMoveListsSwordmasterSword
        .word _List10 - aBattleAnimationMoveListsSwordmasterSword
        .word _List11 - aBattleAnimationMoveListsSwordmasterSword
        .word _List12 - aBattleAnimationMoveListsSwordmasterSword
        .word _List13 - aBattleAnimationMoveListsSwordmasterSword
        .word _List14 - aBattleAnimationMoveListsSwordmasterSword
        .word _List15 - aBattleAnimationMoveListsSwordmasterSword
        .word _List16 - aBattleAnimationMoveListsSwordmasterSword
        .word _List17 - aBattleAnimationMoveListsSwordmasterSword
        .word _List18 - aBattleAnimationMoveListsSwordmasterSword
        .word _List19 - aBattleAnimationMoveListsSwordmasterSword
        .word _List20 - aBattleAnimationMoveListsSwordmasterSword

      _List00
        ANIM_MOVE_ROUTINE 2, 8
        ANIM_MOVE_ROUTINE 7, 4
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_ROUTINE 11, 9
        ANIM_MOVE_ROUTINE 17, 5
        ANIM_MOVE_STILL 12
        ANIM_MOVE_ROUTINE_ARG 13, 11, $4834
        ANIM_MOVE_SCRIPT 15, 1
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_ROUTINE 17, 5
        ANIM_MOVE_STILL 12
        ANIM_MOVE_ROUTINE_ARG 13, 11, $4834
        ANIM_MOVE_SCRIPT 15, 1
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_STILL 7
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_STILL 4
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 1, 0
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_ROUTINE_ARG 10, 10, $403D
        ANIM_MOVE_STILL 16
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_STILL 16
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_STILL 9
        ANIM_MOVE_ROUTINE 18, 3
        ANIM_MOVE_ROUTINE 19, 5
        ANIM_MOVE_STILL 20
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_STILL 5
        ANIM_MOVE_STILL 9
        ANIM_MOVE_ROUTINE 18, 3
        ANIM_MOVE_ROUTINE 19, 5
        ANIM_MOVE_STILL 20
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_SCRIPT 14, 1
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_SCRIPT 21, 1
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_STILL 12
        ANIM_MOVE_ROUTINE_ARG 13, 11, $1034
        ANIM_MOVE_STILL 12
        ANIM_MOVE_ROUTINE_ARG 13, 11, $3034
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_ROUTINE 11, 9
        ANIM_MOVE_STILL 21
        ANIM_MOVE_STILL 5
        ANIM_MOVE_STILL 24
        ANIM_MOVE_ROUTINE 18, 3
        ANIM_MOVE_ROUTINE 19, 4
        ANIM_MOVE_STILL 25
        ANIM_MOVE_LIST_END

      _List15
        ANIM_MOVE_SCRIPT 26, 2
        ANIM_MOVE_SCRIPT 7, 3
        ANIM_MOVE_LIST_END

      _List16
        ANIM_MOVE_STILL 28
        ANIM_MOVE_ROUTINE 18, 14
        ANIM_MOVE_ROUTINE 29, 5
        ANIM_MOVE_STILL 27
        ANIM_MOVE_STILL 28
        ANIM_MOVE_ROUTINE 18, 14
        ANIM_MOVE_STILL 29
        ANIM_MOVE_STILL 27
        ANIM_MOVE_STILL 24
        ANIM_MOVE_ROUTINE 18, 3
        ANIM_MOVE_ROUTINE 25, 5
        ANIM_MOVE_STILL 20
        ANIM_MOVE_LIST_END

      _List17
        ANIM_MOVE_SCRIPT 30, 5
        ANIM_MOVE_LIST_END

      _List18
        ANIM_MOVE_SCRIPT 8, 6
        ANIM_MOVE_LIST_END

      _List19
        ANIM_MOVE_SCRIPT 3, 7
        ANIM_MOVE_LIST_END

      _List20
        ANIM_MOVE_SCRIPT 31, 8
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsSwordmasterSword ; 97/CCB8

        .word _Script00 - aBattleAnimationMoveScriptsSwordmasterSword
        .word _Script01 - aBattleAnimationMoveScriptsSwordmasterSword
        .word _Script02 - aBattleAnimationMoveScriptsSwordmasterSword
        .word _Script03 - aBattleAnimationMoveScriptsSwordmasterSword
        .word _Script04 - aBattleAnimationMoveScriptsSwordmasterSword
        .word _Script05 - aBattleAnimationMoveScriptsSwordmasterSword
        .word _Script06 - aBattleAnimationMoveScriptsSwordmasterSword
        .word _Script07 - aBattleAnimationMoveScriptsSwordmasterSword
        .word _Script08 - aBattleAnimationMoveScriptsSwordmasterSword

      _Script00
        .char 0, 3, 2, 2, -2, 0, 0

      _Script01
        .char 6, 11, 5, 0, 0

      _Script02
        .char 0, -4, 0

      _Script03
        .char -14, 0, 0, 0, 0, 0, 0, 0

      _Script04
        .char 0, 7, 9, 0

      _Script05
        .char 0, 0, 0, 0, 0, 0, 13, 2

      _Script06
        .char 0, 5, 4

      _Script07
        .char 0, 14, 0, 5

      _Script08
        .char 0, 8, 4

      aBattleAnimationActionsPrincessStaff ; 97/CCF7

        ; Move program of entry 3 of aBattleAnimationPrograms, used by: Princess (Staff), WarMageF
        ; (Staff), Queen (Staff), Priest (Staff), HighPriest (Staff), Bishop (Staff), Sage
        ; (Staff), Priestess (Staff), DarkMage (Staff), DarkBishop (Staff).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3

      aBattleAnimationMoveListsPrincessStaff ; 97/CCFF

        .word _List00 - aBattleAnimationMoveListsPrincessStaff
        .word _List01 - aBattleAnimationMoveListsPrincessStaff
        .word _List02 - aBattleAnimationMoveListsPrincessStaff
        .word _List03 - aBattleAnimationMoveListsPrincessStaff

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 3, 0
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 4, 1
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 1, 2
        ANIM_MOVE_SCRIPT 2, 3
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsPrincessStaff ; 97/CD19

        .word _Script00 - aBattleAnimationMoveScriptsPrincessStaff
        .word _Script01 - aBattleAnimationMoveScriptsPrincessStaff
        .word _Script02 - aBattleAnimationMoveScriptsPrincessStaff
        .word _Script03 - aBattleAnimationMoveScriptsPrincessStaff
        .word _Script04 - aBattleAnimationMoveScriptsPrincessStaff

      _Script00
        .char 2, 1, 0, 0, 0, 0, 0

      _Script01
        .char 5, 5, 5, 4, 4, 3, 3, 2, 2, 0, 0, 0, 0, 0

      _Script02
        .char 0, 0, 2, 1, 0, 0

      _Script03
        .char 1, 0, -4, 0, 0, 0

      _Script04
        .char 2, 0, 0

      aBattleAnimationActionsWarMageMagic ; 97/CD47

        ; Move program of entry 4 of aBattleAnimationPrograms, used by: WarMage (Magic), WarMageF
        ; (Magic), Queen (Magic), Mage (Magic), FireMage (Magic), ThunderMage (Magic), WindMage
        ; (Magic), HighPriest (Magic), Bishop (Magic), Sage (Magic), Bard (Magic), Priestess
        ; (Magic), DarkMage (Magic), DarkBishop (Magic).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4

      aBattleAnimationMoveListsWarMageMagic ; 97/CD57

        .word _List00 - aBattleAnimationMoveListsWarMageMagic
        .word _List01 - aBattleAnimationMoveListsWarMageMagic
        .word _List02 - aBattleAnimationMoveListsWarMageMagic
        .word _List03 - aBattleAnimationMoveListsWarMageMagic
        .word _List04 - aBattleAnimationMoveListsWarMageMagic

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 4, 1
        ANIM_MOVE_SCRIPT 8, 7
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 5, 2
        ANIM_MOVE_SCRIPT 8, 7
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 1, 3
        ANIM_MOVE_SCRIPT 3, 6
        ANIM_MOVE_SCRIPT 7, 5
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 2, 0
        ANIM_MOVE_SCRIPT 6, 4
        ANIM_MOVE_SCRIPT 7, 5
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsWarMageMagic ; 97/CD7C

        .word _Script00 - aBattleAnimationMoveScriptsWarMageMagic
        .word _Script01 - aBattleAnimationMoveScriptsWarMageMagic
        .word _Script02 - aBattleAnimationMoveScriptsWarMageMagic
        .word _Script03 - aBattleAnimationMoveScriptsWarMageMagic
        .word _Script04 - aBattleAnimationMoveScriptsWarMageMagic
        .word _Script05 - aBattleAnimationMoveScriptsWarMageMagic
        .word _Script06 - aBattleAnimationMoveScriptsWarMageMagic
        .word _Script07 - aBattleAnimationMoveScriptsWarMageMagic

      _Script00
        .char 0, 2, 2, 0, 0, 0, -2, 0, 0

      _Script01
        .char 2, 1, 0, 0, 0, 0

      _Script02
        .char 5, 5, 5, 4, 4, 3, 3, 2, 2, 0, 0, 0, 0, 0

      _Script03
        .char 0, 0, 2, 2, 0, 0, 0, 0, 0, 0

      _Script04
        .char 0, 2, 0, 0, 0, 0

      _Script05
        .char 0, -5, 0

      _Script06
        .char 1, 0, 0

      _Script07
        .char 3, 0, 0

      aBattleAnimationActionsUnknown05 ; 97/CDC2

        ; Move program of entry 5 of aBattleAnimationPrograms; nothing selects it.

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsUnknown05 ; 97/CE02

        .word _List00 - aBattleAnimationMoveListsUnknown05
        .word _List01 - aBattleAnimationMoveListsUnknown05
        .word _List02 - aBattleAnimationMoveListsUnknown05
        .word _List03 - aBattleAnimationMoveListsUnknown05
        .word _List04 - aBattleAnimationMoveListsUnknown05
        .word _List05 - aBattleAnimationMoveListsUnknown05
        .word _List06 - aBattleAnimationMoveListsUnknown05
        .word _List07 - aBattleAnimationMoveListsUnknown05
        .word _List08 - aBattleAnimationMoveListsUnknown05
        .word _List09 - aBattleAnimationMoveListsUnknown05
        .word _List10 - aBattleAnimationMoveListsUnknown05
        .word _List11 - aBattleAnimationMoveListsUnknown05
        .word _List12 - aBattleAnimationMoveListsUnknown05
        .word _List13 - aBattleAnimationMoveListsUnknown05
        .word _List14 - aBattleAnimationMoveListsUnknown05
        .word _List15 - aBattleAnimationMoveListsUnknown05
        .word _List16 - aBattleAnimationMoveListsUnknown05
        .word _List17 - aBattleAnimationMoveListsUnknown05
        .word _List18 - aBattleAnimationMoveListsUnknown05
        .word _List19 - aBattleAnimationMoveListsUnknown05

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 18, 17
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 6, 5
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_SCRIPT 7, 6
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_SCRIPT 8, 7
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 9, 8
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_SCRIPT 18, 17
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_SCRIPT 9, 8
        ANIM_MOVE_SCRIPT 10, 9
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_SCRIPT 1, 0
        ANIM_MOVE_SCRIPT 10, 9
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_SCRIPT 10, 9
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_SCRIPT 12, 11
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_SCRIPT 14, 13
        ANIM_MOVE_SCRIPT 10, 9
        ANIM_MOVE_LIST_END

      _List15
        ANIM_MOVE_SCRIPT 13, 12
        ANIM_MOVE_LIST_END

      _List16
        ANIM_MOVE_SCRIPT 15, 14
        ANIM_MOVE_LIST_END

      _List17
        ANIM_MOVE_SCRIPT 16, 15
        ANIM_MOVE_LIST_END

      _List18
        ANIM_MOVE_SCRIPT 17, 16
        ANIM_MOVE_LIST_END

      _List19
        ANIM_MOVE_SCRIPT 19, 18
        ANIM_MOVE_SCRIPT 20, 19
        ANIM_MOVE_SCRIPT 21, 20
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsUnknown05 ; 97/CE78

        .word _Script00 - aBattleAnimationMoveScriptsUnknown05
        .word _Script01 - aBattleAnimationMoveScriptsUnknown05
        .word _Script02 - aBattleAnimationMoveScriptsUnknown05
        .word _Script03 - aBattleAnimationMoveScriptsUnknown05
        .word _Script04 - aBattleAnimationMoveScriptsUnknown05
        .word _Script05 - aBattleAnimationMoveScriptsUnknown05
        .word _Script06 - aBattleAnimationMoveScriptsUnknown05
        .word _Script07 - aBattleAnimationMoveScriptsUnknown05
        .word _Script08 - aBattleAnimationMoveScriptsUnknown05
        .word _Script09 - aBattleAnimationMoveScriptsUnknown05
        .word _Script10 - aBattleAnimationMoveScriptsUnknown05
        .word _Script11 - aBattleAnimationMoveScriptsUnknown05
        .word _Script12 - aBattleAnimationMoveScriptsUnknown05
        .word _Script13 - aBattleAnimationMoveScriptsUnknown05
        .word _Script14 - aBattleAnimationMoveScriptsUnknown05
        .word _Script15 - aBattleAnimationMoveScriptsUnknown05
        .word _Script16 - aBattleAnimationMoveScriptsUnknown05
        .word _Script17 - aBattleAnimationMoveScriptsUnknown05
        .word _Script18 - aBattleAnimationMoveScriptsUnknown05
        .word _Script19 - aBattleAnimationMoveScriptsUnknown05
        .word _Script20 - aBattleAnimationMoveScriptsUnknown05

      _Script00
        .char 0, 6, 7, 0, 5

      _Script01
        .char 0, 5, 2, 2, 6, 7, 0, 0

      _Script02
        .char -1, -1, -3, -4, -2, -2, -2, 0

      _Script03
        .char 6, 7, 0, 0, -13, -4, 0, 0

      _Script04
        .char 0, 12, 7, 0

      _Script05
        .char 0, 12, 7, 0

      _Script06
        .char 0, 0, 0, 0, -15, -4, 0, 0, 0

      _Script07
        .char 12, 0, 7, 0, 0, -15, -3, 0, 0

      _Script08
        .char 0, 7

      _Script09
        .char 0, 0, 0, 0, 0, -14, -6, 0, 0, 0, 0, 0, 0

      _Script10
        .char 0, 0, 0, 0, 0, 0

      _Script11
        .char 0, 13, 0, 8, 0, 0, -15, -5

      _Script12
        .char 6, 7

      _Script13
        .char 12, 8

      _Script14
        .char 0

      _Script15
        .char 0, 12, 0, 7, 0

      _Script16
        .char 0, 12, 0, 7, 0

      _Script17
        .char 0, -2, 0, 0

      _Script18
        .char 0, 0, 0, 0, 0

      _Script19
        .char 0, -13, -4, 0

      _Script20
        .char 0, 9, 3

      aBattleAnimationActionsUnknown06 ; 97/CF15

        ; Move program of entry 6 of aBattleAnimationPrograms; nothing selects it.

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1

      aBattleAnimationMoveListsUnknown06 ; 97/CF50

        .word _List00 - aBattleAnimationMoveListsUnknown06
        .word _List01 - aBattleAnimationMoveListsUnknown06
        .word _List02 - aBattleAnimationMoveListsUnknown06
        .word _List03 - aBattleAnimationMoveListsUnknown06
        .word _List04 - aBattleAnimationMoveListsUnknown06
        .word _List05 - aBattleAnimationMoveListsUnknown06
        .word _List06 - aBattleAnimationMoveListsUnknown06
        .word _List07 - aBattleAnimationMoveListsUnknown06
        .word _List08 - aBattleAnimationMoveListsUnknown06
        .word _List09 - aBattleAnimationMoveListsUnknown06
        .word _List10 - aBattleAnimationMoveListsUnknown06

      _List00
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 14, 8
        ANIM_MOVE_SCRIPT 2, 0
        ANIM_MOVE_SCRIPT 3, 1
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 6, 3
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 1, 2
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 15, 9
        ANIM_MOVE_SCRIPT 3, 1
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 14, 8
        ANIM_MOVE_SCRIPT 2, 0
        ANIM_MOVE_SCRIPT 4, 5
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 4, 5
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_SCRIPT 12, 6
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_SCRIPT 13, 7
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 16, 4
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_SCRIPT 4, 5
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsUnknown06 ; 97/CF93

        .word _Script00 - aBattleAnimationMoveScriptsUnknown06
        .word _Script01 - aBattleAnimationMoveScriptsUnknown06
        .word _Script02 - aBattleAnimationMoveScriptsUnknown06
        .word _Script03 - aBattleAnimationMoveScriptsUnknown06
        .word _Script04 - aBattleAnimationMoveScriptsUnknown06
        .word _Script05 - aBattleAnimationMoveScriptsUnknown06
        .word _Script06 - aBattleAnimationMoveScriptsUnknown06
        .word _Script07 - aBattleAnimationMoveScriptsUnknown06
        .word _Script08 - aBattleAnimationMoveScriptsUnknown06
        .word _Script09 - aBattleAnimationMoveScriptsUnknown06

      _Script00
        .char 0, -1, -3, -4, -2, -2, -2, 0, 0, 0, 0

      _Script01
        .char 0, 0, -1, -12, 0, 11, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0

      _Script02
        .char 7, 2, 1, 0, 0

      _Script03
        .char 0, 7, 1, 5, -14, -4

      _Script04
        .char 7, 1, 5

      _Script05
        .char 8, 1, 5, 0, -7, -9, 0, 12, 1, 0, 0, 0, 0, 0

      _Script06
        .char 0, 0, -6, -12, 0, 12, 1, 0, 0

      _Script07
        .char 0, -13, -6, 0

      _Script08
        .char 0, -2, 0

      _Script09
        .char 12, 1

      aBattleAnimationActionsUnknown07 ; 97/CFF0

        ; Move program of entry 7 of aBattleAnimationPrograms; nothing selects it.

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8

      aBattleAnimationMoveListsUnknown07 ; 97/D01F

        .word _List00 - aBattleAnimationMoveListsUnknown07
        .word _List01 - aBattleAnimationMoveListsUnknown07
        .word _List02 - aBattleAnimationMoveListsUnknown07
        .word _List03 - aBattleAnimationMoveListsUnknown07
        .word _List04 - aBattleAnimationMoveListsUnknown07
        .word _List05 - aBattleAnimationMoveListsUnknown07
        .word _List06 - aBattleAnimationMoveListsUnknown07
        .word _List07 - aBattleAnimationMoveListsUnknown07
        .word _List08 - aBattleAnimationMoveListsUnknown07
        .word _List09 - aBattleAnimationMoveListsUnknown07
        .word _List10 - aBattleAnimationMoveListsUnknown07

      _List00
        ANIM_MOVE_SCRIPT 5, 3
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 6, 2
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 1, 1
        ANIM_MOVE_SCRIPT 5, 3
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_SCRIPT 12, 4
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 13, 5
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_STILL 14
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsUnknown07 ; 97/D058

        .word _Script00 - aBattleAnimationMoveScriptsUnknown07
        .word _Script01 - aBattleAnimationMoveScriptsUnknown07
        .word _Script02 - aBattleAnimationMoveScriptsUnknown07
        .word _Script03 - aBattleAnimationMoveScriptsUnknown07
        .word _Script04 - aBattleAnimationMoveScriptsUnknown07
        .word _Script05 - aBattleAnimationMoveScriptsUnknown07

      _Script00
        .char 0, 7, 1, 5, -14, -4, 0

      _Script01
        .char 7, 2, 1, 0, 0

      _Script02
        .char 0, 7, 1, 5, -14, -4, 0, 4, 0

      _Script03
        .char 7, 1, 5

      _Script04
        .char 0, -13, -6, 0, 4, 0, 0

      _Script05
        .char 0, 7, 1, 5

      aBattleAnimationActionsUnknown08 ; 97/D087

        ; Move program of entry 8 of aBattleAnimationPrograms; nothing selects it.

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 5

      aBattleAnimationMoveListsUnknown08 ; 97/D0B7

        .word _List00 - aBattleAnimationMoveListsUnknown08
        .word _List01 - aBattleAnimationMoveListsUnknown08
        .word _List02 - aBattleAnimationMoveListsUnknown08
        .word _List03 - aBattleAnimationMoveListsUnknown08
        .word _List04 - aBattleAnimationMoveListsUnknown08
        .word _List05 - aBattleAnimationMoveListsUnknown08
        .word _List06 - aBattleAnimationMoveListsUnknown08
        .word _List07 - aBattleAnimationMoveListsUnknown08
        .word _List08 - aBattleAnimationMoveListsUnknown08
        .word _List09 - aBattleAnimationMoveListsUnknown08

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 1
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 2
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 5, 5
        ANIM_MOVE_SCRIPT 3, 3
        ANIM_MOVE_SCRIPT 4, 4
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 3, 3
        ANIM_MOVE_SCRIPT 4, 4
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 5, 5
        ANIM_MOVE_SCRIPT 3, 3
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 3, 3
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_SCRIPT 6, 6
        ANIM_MOVE_SCRIPT 5, 5
        ANIM_MOVE_SCRIPT 3, 3
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_SCRIPT 4, 4
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 6, 6
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsUnknown08 ; 97/D0F5

        .word _Script00 - aBattleAnimationMoveScriptsUnknown08
        .word _Script01 - aBattleAnimationMoveScriptsUnknown08
        .word _Script02 - aBattleAnimationMoveScriptsUnknown08
        .word _Script03 - aBattleAnimationMoveScriptsUnknown08
        .word _Script04 - aBattleAnimationMoveScriptsUnknown08
        .word _Script05 - aBattleAnimationMoveScriptsUnknown08
        .word _Script06 - aBattleAnimationMoveScriptsUnknown08

      _Script00
        .char 0, 0

      _Script01
        .char 6, 7, 0

      _Script02
        .char 0, 5, 2, 2, 6, 7, 0

      _Script03
        .char 0, 0, 0, 0

      _Script04
        .char 0, -16, -6, 13, 6

      _Script05
        .char 6, 7, 0

      _Script06
        .char 0, 9

      aBattleAnimationActionsUnknown09 ; 97/D11D

        ; Move program of entry 9 of aBattleAnimationPrograms; nothing selects it.

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4

      aBattleAnimationMoveListsUnknown09 ; 97/D14C

        .word _List00 - aBattleAnimationMoveListsUnknown09
        .word _List01 - aBattleAnimationMoveListsUnknown09
        .word _List02 - aBattleAnimationMoveListsUnknown09
        .word _List03 - aBattleAnimationMoveListsUnknown09
        .word _List04 - aBattleAnimationMoveListsUnknown09
        .word _List05 - aBattleAnimationMoveListsUnknown09
        .word _List06 - aBattleAnimationMoveListsUnknown09
        .word _List07 - aBattleAnimationMoveListsUnknown09

      _List00
        ANIM_MOVE_STILL 1
        ANIM_MOVE_SCRIPT 17, 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_STILL 3
        ANIM_MOVE_STILL 4
        ANIM_MOVE_SCRIPT 18, 1
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_STILL 5
        ANIM_MOVE_STILL 2
        ANIM_MOVE_SCRIPT 18, 1
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_STILL 16
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_STILL 19
        ANIM_MOVE_STILL 21
        ANIM_MOVE_SCRIPT 18, 1
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_STILL 20
        ANIM_MOVE_STILL 22
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_STILL 23
        ANIM_MOVE_STILL 2
        ANIM_MOVE_SCRIPT 18, 1
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_STILL 24
        ANIM_MOVE_STILL 4
        ANIM_MOVE_SCRIPT 18, 1
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsUnknown09 ; 97/D18C

        .word _Script00 - aBattleAnimationMoveScriptsUnknown09
        .word _Script01 - aBattleAnimationMoveScriptsUnknown09

      _Script00
        .char 4

      _Script01
        .char 0, 0, 5

      aBattleAnimationActionsDancerSword ; 97/D194

        ; Move program of entry 10 of aBattleAnimationPrograms, used by: Dancer (Sword), Thief
        ; (Sword), Rogue (Sword).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4

      aBattleAnimationMoveListsDancerSword ; 97/D1CB

        .word _List00 - aBattleAnimationMoveListsDancerSword
        .word _List01 - aBattleAnimationMoveListsDancerSword
        .word _List02 - aBattleAnimationMoveListsDancerSword
        .word _List03 - aBattleAnimationMoveListsDancerSword
        .word _List04 - aBattleAnimationMoveListsDancerSword
        .word _List05 - aBattleAnimationMoveListsDancerSword
        .word _List06 - aBattleAnimationMoveListsDancerSword
        .word _List07 - aBattleAnimationMoveListsDancerSword
        .word _List08 - aBattleAnimationMoveListsDancerSword
        .word _List09 - aBattleAnimationMoveListsDancerSword
        .word _List10 - aBattleAnimationMoveListsDancerSword
        .word _List11 - aBattleAnimationMoveListsDancerSword
        .word _List12 - aBattleAnimationMoveListsDancerSword
        .word _List13 - aBattleAnimationMoveListsDancerSword
        .word _List14 - aBattleAnimationMoveListsDancerSword

      _List00
        ANIM_MOVE_ROUTINE 2, 9
        ANIM_MOVE_ROUTINE 1, 4
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_STILL 4
        ANIM_MOVE_STILL 5
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 7, 0
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_STILL 1
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_ROUTINE_ARG 10, 10, $2821
        ANIM_MOVE_STILL 11
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 9, 4
        ANIM_MOVE_ROUTINE_ARG 13, 12, $1027
        ANIM_MOVE_STILL 14
        ANIM_MOVE_ROUTINE_ARG 10, 10, $3021
        ANIM_MOVE_STILL 11
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 9, 4
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_STILL 6
        ANIM_MOVE_STILL 1
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_STILL 11
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 8, 2
        ANIM_MOVE_SCRIPT 0, 3
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_SCRIPT 9, 6
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_SCRIPT 12, 5
        ANIM_MOVE_ROUTINE_ARG 13, 12, $1027
        ANIM_MOVE_STILL 14
        ANIM_MOVE_ROUTINE 2, 9
        ANIM_MOVE_ROUTINE 1, 4
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_ROUTINE 2, 8
        ANIM_MOVE_ROUTINE_ARG 16, 0, $3B14
        ANIM_MOVE_STILL 17
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_SCRIPT 18, 8
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsDancerSword ; 97/D246

        .word _Script00 - aBattleAnimationMoveScriptsDancerSword
        .word _Script01 - aBattleAnimationMoveScriptsDancerSword
        .word _Script02 - aBattleAnimationMoveScriptsDancerSword
        .word _Script03 - aBattleAnimationMoveScriptsDancerSword
        .word _Script04 - aBattleAnimationMoveScriptsDancerSword
        .word _Script05 - aBattleAnimationMoveScriptsDancerSword
        .word _Script06 - aBattleAnimationMoveScriptsDancerSword
        .word _Script07 - aBattleAnimationMoveScriptsDancerSword
        .word _Script08 - aBattleAnimationMoveScriptsDancerSword

      _Script00
        .char 4, 12, 0

      _Script01
        .char 3

      _Script02
        .char 0, 3, 0, 0, 0

      _Script03
        .char -1

      _Script04
        .char 0, 0, 0, 0, 0

      _Script05
        .char 4, 0, 0, 0, 0

      _Script06
        .char 1

      _Script07
        .char 0, -6, -11, -7

      _Script08
        .char 0, 4

      aBattleAnimationActionsCavalierSword ; 97/D273

        ; Move program of entry 11 of aBattleAnimationPrograms, used by: Cavalier (Sword),
        ; AxeKnight (Axe), FreeKnight (Sword), Troubadour (Sword).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsCavalierSword ; 97/D2AA

        .word _List00 - aBattleAnimationMoveListsCavalierSword
        .word _List01 - aBattleAnimationMoveListsCavalierSword
        .word _List02 - aBattleAnimationMoveListsCavalierSword
        .word _List03 - aBattleAnimationMoveListsCavalierSword
        .word _List04 - aBattleAnimationMoveListsCavalierSword
        .word _List05 - aBattleAnimationMoveListsCavalierSword
        .word _List06 - aBattleAnimationMoveListsCavalierSword
        .word _List07 - aBattleAnimationMoveListsCavalierSword
        .word _List08 - aBattleAnimationMoveListsCavalierSword
        .word _List09 - aBattleAnimationMoveListsCavalierSword
        .word _List10 - aBattleAnimationMoveListsCavalierSword
        .word _List11 - aBattleAnimationMoveListsCavalierSword
        .word _List12 - aBattleAnimationMoveListsCavalierSword
        .word _List13 - aBattleAnimationMoveListsCavalierSword
        .word _List14 - aBattleAnimationMoveListsCavalierSword
        .word _List15 - aBattleAnimationMoveListsCavalierSword
        .word _List16 - aBattleAnimationMoveListsCavalierSword

      _List00
        ANIM_MOVE_ROUTINE 1, 8
        ANIM_MOVE_ROUTINE 10, 4
        ANIM_MOVE_STILL 5
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_STILL 10
        ANIM_MOVE_STILL 5
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_ROUTINE 1, 8
        ANIM_MOVE_ROUTINE 10, 4
        ANIM_MOVE_STILL 7
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_STILL 10
        ANIM_MOVE_STILL 7
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 4, 0
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_STILL 7
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_STILL 2
        ANIM_MOVE_STILL 7
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_STILL 2
        ANIM_MOVE_STILL 5
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_STILL 10
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_STILL 9
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_STILL 5
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_SCRIPT 3, 1
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_SCRIPT 3, 1
        ANIM_MOVE_LIST_END

      _List15
        ANIM_MOVE_ROUTINE 13, 9
        ANIM_MOVE_ROUTINE 10, 4
        ANIM_MOVE_STILL 7
        ANIM_MOVE_LIST_END

      _List16
        ANIM_MOVE_ROUTINE 13, 9
        ANIM_MOVE_ROUTINE 10, 4
        ANIM_MOVE_STILL 5
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsCavalierSword ; 97/D317

        .word _Script00 - aBattleAnimationMoveScriptsCavalierSword
        .word _Script01 - aBattleAnimationMoveScriptsCavalierSword
        .word _Script02 - aBattleAnimationMoveScriptsCavalierSword

      _Script00
        .char 3, 6, 10, -3

      _Script01
        .char 0, 3, 6, 10, -3

      _Script02
        .char 0, 0, 16, 0, -2

      aBattleAnimationActionsCavalierLance ; 97/D32B

        ; Move program of entry 12 of aBattleAnimationPrograms, used by: Cavalier (Lance),
        ; LanceKnight (Lance).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsCavalierLance ; 97/D367

        .word _List00 - aBattleAnimationMoveListsCavalierLance
        .word _List01 - aBattleAnimationMoveListsCavalierLance
        .word _List02 - aBattleAnimationMoveListsCavalierLance
        .word _List03 - aBattleAnimationMoveListsCavalierLance
        .word _List04 - aBattleAnimationMoveListsCavalierLance
        .word _List05 - aBattleAnimationMoveListsCavalierLance
        .word _List06 - aBattleAnimationMoveListsCavalierLance
        .word _List07 - aBattleAnimationMoveListsCavalierLance
        .word _List08 - aBattleAnimationMoveListsCavalierLance
        .word _List09 - aBattleAnimationMoveListsCavalierLance
        .word _List10 - aBattleAnimationMoveListsCavalierLance
        .word _List11 - aBattleAnimationMoveListsCavalierLance

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 1
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 2
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_ROUTINE 3, 8
        ANIM_MOVE_ROUTINE 4, 4
        ANIM_MOVE_SCRIPT 5, 5
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 4, 4
        ANIM_MOVE_SCRIPT 5, 5
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 5, 5
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 4, 4
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_ROUTINE 3, 8
        ANIM_MOVE_ROUTINE 4, 4
        ANIM_MOVE_SCRIPT 6, 6
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_SCRIPT 4, 4
        ANIM_MOVE_SCRIPT 6, 6
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 6, 6
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_ROUTINE 11, 9
        ANIM_MOVE_ROUTINE 4, 4
        ANIM_MOVE_SCRIPT 5, 5
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_ROUTINE 3, 9
        ANIM_MOVE_ROUTINE 4, 4
        ANIM_MOVE_SCRIPT 6, 6
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsCavalierLance ; 97/D3B7

        .word _Script00 - aBattleAnimationMoveScriptsCavalierLance
        .word _Script01 - aBattleAnimationMoveScriptsCavalierLance
        .word _Script02 - aBattleAnimationMoveScriptsCavalierLance
        .word _Script03 - aBattleAnimationMoveScriptsCavalierLance
        .word _Script04 - aBattleAnimationMoveScriptsCavalierLance
        .word _Script05 - aBattleAnimationMoveScriptsCavalierLance
        .word _Script06 - aBattleAnimationMoveScriptsCavalierLance
        .word _Script07 - aBattleAnimationMoveScriptsCavalierLance
        .word _Script08 - aBattleAnimationMoveScriptsCavalierLance
        .word _Script09 - aBattleAnimationMoveScriptsCavalierLance

      _Script00
        .char 0

      _Script01
        .char 0, 3, 6, 10, -3

      _Script02
        .char 0, 0, 5, 10, 5, 0, -3

      _Script03
        .char 0, 0, 0, 0, 0, 0

      _Script04
        .char 0, 0, 0, 0

      _Script05
        .char 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

      _Script06
        .char 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        .char 0

      _Script07
        .char 0, 3, 6, 10, -3, 0

      _Script08
        .char 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

      _Script09
        .char 0, 0, 0, 0, 0, 0, 5, 16, 0, 0, 0

      aBattleAnimationActionsCavalierRangedLance ; 97/D41B

        ; Move program of entry 13 of aBattleAnimationPrograms, used by: Cavalier (RangedLance),
        ; LanceKnight (RangedLance).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsCavalierRangedLance ; 97/D44B

        .word _List00 - aBattleAnimationMoveListsCavalierRangedLance
        .word _List01 - aBattleAnimationMoveListsCavalierRangedLance
        .word _List02 - aBattleAnimationMoveListsCavalierRangedLance
        .word _List03 - aBattleAnimationMoveListsCavalierRangedLance
        .word _List04 - aBattleAnimationMoveListsCavalierRangedLance
        .word _List05 - aBattleAnimationMoveListsCavalierRangedLance
        .word _List06 - aBattleAnimationMoveListsCavalierRangedLance

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 1
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 2
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 3, 3
        ANIM_MOVE_SCRIPT 4, 4
        ANIM_MOVE_SCRIPT 2, 2
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 4, 4
        ANIM_MOVE_SCRIPT 2, 2
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 3, 3
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 5, 5
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsCavalierRangedLance ; 97/D474

        .word _Script00 - aBattleAnimationMoveScriptsCavalierRangedLance
        .word _Script01 - aBattleAnimationMoveScriptsCavalierRangedLance
        .word _Script02 - aBattleAnimationMoveScriptsCavalierRangedLance
        .word _Script03 - aBattleAnimationMoveScriptsCavalierRangedLance
        .word _Script04 - aBattleAnimationMoveScriptsCavalierRangedLance
        .word _Script05 - aBattleAnimationMoveScriptsCavalierRangedLance
        .word _Script06 - aBattleAnimationMoveScriptsCavalierRangedLance

      _Script00
        .char 0

      _Script01
        .char 3, 6, 10, -3, 0

      _Script02
        .char 0, 0, 0, 0, 0, -3, 0

      _Script03
        .char 0, 3, 0, 0

      _Script04
        .char 0, 0, 0, 0, 0, 0, 0, 0, 0

      _Script05
        .char 0

      _Script06
        .char 0

      aBattleAnimationActionsAxeKnightRangedAxe ; 97/D49E

        ; Move program of entry 14 of aBattleAnimationPrograms, used by: AxeKnight (RangedAxe).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2

      aBattleAnimationMoveListsAxeKnightRangedAxe ; 97/D4CD

        .word _List00 - aBattleAnimationMoveListsAxeKnightRangedAxe
        .word _List01 - aBattleAnimationMoveListsAxeKnightRangedAxe
        .word _List02 - aBattleAnimationMoveListsAxeKnightRangedAxe
        .word _List03 - aBattleAnimationMoveListsAxeKnightRangedAxe
        .word _List04 - aBattleAnimationMoveListsAxeKnightRangedAxe
        .word _List05 - aBattleAnimationMoveListsAxeKnightRangedAxe
        .word _List06 - aBattleAnimationMoveListsAxeKnightRangedAxe

      _List00
        ANIM_MOVE_SCRIPT 5, 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_STILL 13
        ANIM_MOVE_STILL 11
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_STILL 11
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_STILL 13
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 14, 1
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_STILL 11
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_STILL 2
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsAxeKnightRangedAxe ; 97/D4F2

        .word _Script00 - aBattleAnimationMoveScriptsAxeKnightRangedAxe
        .word _Script01 - aBattleAnimationMoveScriptsAxeKnightRangedAxe

      _Script00
        .char 0, 3, 6, 10, -3

      _Script01
        .char 0, 3, 6, 10, -3

      aBattleAnimationActionsBowKnightBow ; 97/D500

        ; Move program of entry 15 of aBattleAnimationPrograms, used by: BowKnight (Bow),
        ; MasterKnight (Bow), ArchKnight (Bow).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3

      aBattleAnimationMoveListsBowKnightBow ; 97/D52F

        .word _List00 - aBattleAnimationMoveListsBowKnightBow
        .word _List01 - aBattleAnimationMoveListsBowKnightBow
        .word _List02 - aBattleAnimationMoveListsBowKnightBow
        .word _List03 - aBattleAnimationMoveListsBowKnightBow
        .word _List04 - aBattleAnimationMoveListsBowKnightBow
        .word _List05 - aBattleAnimationMoveListsBowKnightBow
        .word _List06 - aBattleAnimationMoveListsBowKnightBow

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 15, 13
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 14, 1
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 16, 2
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsBowKnightBow ; 97/D552

        .word _Script00 - aBattleAnimationMoveScriptsBowKnightBow
        .word _Script01 - aBattleAnimationMoveScriptsBowKnightBow
        .word _Script02 - aBattleAnimationMoveScriptsBowKnightBow
        .word _Script03 - aBattleAnimationMoveScriptsBowKnightBow
        .word _Script04 - aBattleAnimationMoveScriptsBowKnightBow
        .word _Script05 - aBattleAnimationMoveScriptsBowKnightBow
        .word _Script06 - aBattleAnimationMoveScriptsBowKnightBow
        .word _Script07 - aBattleAnimationMoveScriptsBowKnightBow
        .word _Script08 - aBattleAnimationMoveScriptsBowKnightBow
        .word _Script09 - aBattleAnimationMoveScriptsBowKnightBow
        .word _Script10 - aBattleAnimationMoveScriptsBowKnightBow
        .word _Script11 - aBattleAnimationMoveScriptsBowKnightBow
        .word _Script12 - aBattleAnimationMoveScriptsBowKnightBow
        .word _Script13 - aBattleAnimationMoveScriptsBowKnightBow

      _Script00
        .char 3, 6, 10, -3, 0

      _Script01
        .char -3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0

      _Script02
        .char -3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0

      _Script03
        .char 0

      _Script04
        .char 0

      _Script05
        .char 0

      _Script06
        .char 0

      _Script07
        .char 0

      _Script08
        .char 0

      _Script09
        .char 0

      _Script10
        .char 0

      _Script11
        .char 0

      _Script12
        .char 0

      _Script13
        .char 0, 0

      aBattleAnimationActionsTroubadourStaff ; 97/D599

        ; Move program of entry 16 of aBattleAnimationPrograms, used by: Troubadour (Staff).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsTroubadourStaff ; 97/D5A1

        .word _List00 - aBattleAnimationMoveListsTroubadourStaff
        .word _List01 - aBattleAnimationMoveListsTroubadourStaff

      _List00
        ANIM_MOVE_STILL 5
        ANIM_MOVE_STILL 7
        ANIM_MOVE_STILL 9
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 0
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsTroubadourStaff ; 97/D5AF

        .word _Script00 - aBattleAnimationMoveScriptsTroubadourStaff

      _Script00
        .char 3, 6, 10, -3

      aBattleAnimationActionsKnightLordSword ; 97/D5B5

        ; Move program of entry 17 of aBattleAnimationPrograms, used by: KnightLord (Sword),
        ; MasterKnight (Sword), MasterKnight (Axe), Paladin (Sword), PaladinF (Sword), Ranger
        ; (Sword), MageKnight (Sword), GreatKnight (Axe).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 6

      aBattleAnimationMoveListsKnightLordSword ; 97/D5EC

        .word _List00 - aBattleAnimationMoveListsKnightLordSword
        .word _List01 - aBattleAnimationMoveListsKnightLordSword
        .word _List02 - aBattleAnimationMoveListsKnightLordSword
        .word _List03 - aBattleAnimationMoveListsKnightLordSword
        .word _List04 - aBattleAnimationMoveListsKnightLordSword
        .word _List05 - aBattleAnimationMoveListsKnightLordSword
        .word _List06 - aBattleAnimationMoveListsKnightLordSword
        .word _List07 - aBattleAnimationMoveListsKnightLordSword
        .word _List08 - aBattleAnimationMoveListsKnightLordSword
        .word _List09 - aBattleAnimationMoveListsKnightLordSword
        .word _List10 - aBattleAnimationMoveListsKnightLordSword
        .word _List11 - aBattleAnimationMoveListsKnightLordSword
        .word _List12 - aBattleAnimationMoveListsKnightLordSword
        .word _List13 - aBattleAnimationMoveListsKnightLordSword
        .word _List14 - aBattleAnimationMoveListsKnightLordSword
        .word _List15 - aBattleAnimationMoveListsKnightLordSword

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_ROUTINE_ARG 3, 10, $2022
        ANIM_MOVE_ROUTINE 4, 4
        ANIM_MOVE_STILL 5
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_ROUTINE_ARG 6, 10, $000F
        ANIM_MOVE_ROUTINE 4, 4
        ANIM_MOVE_STILL 5
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_STILL 7
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_STILL 5
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_ROUTINE_ARG 3, 10, $2022
        ANIM_MOVE_ROUTINE 4, 4
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_ROUTINE_ARG 6, 10, $000F
        ANIM_MOVE_ROUTINE 4, 4
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_STILL 9
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_STILL 9
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_STILL 10
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_STILL 11
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_STILL 12
        ANIM_MOVE_LIST_END

      _List15
        ANIM_MOVE_STILL 13
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsKnightLordSword ; 97/D656

        .word _Script00 - aBattleAnimationMoveScriptsKnightLordSword
        .word _Script01 - aBattleAnimationMoveScriptsKnightLordSword
        .word _Script02 - aBattleAnimationMoveScriptsKnightLordSword

      _Script00
        .char 3, 6, 10, -3

      _Script01
        .char 0, 0, 4, 16, 0, -3

      _Script02
        .char 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

      aBattleAnimationActionsKnightLordLance ; 97/D673

        ; Move program of entry 18 of aBattleAnimationPrograms, used by: KnightLord (Lance),
        ; DukeKnight (Lance), MasterKnight (Lance), Paladin (Lance), PaladinF (Lance).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsKnightLordLance ; 97/D6B3

        .word _List00 - aBattleAnimationMoveListsKnightLordLance
        .word _List01 - aBattleAnimationMoveListsKnightLordLance
        .word _List02 - aBattleAnimationMoveListsKnightLordLance
        .word _List03 - aBattleAnimationMoveListsKnightLordLance
        .word _List04 - aBattleAnimationMoveListsKnightLordLance
        .word _List05 - aBattleAnimationMoveListsKnightLordLance
        .word _List06 - aBattleAnimationMoveListsKnightLordLance
        .word _List07 - aBattleAnimationMoveListsKnightLordLance
        .word _List08 - aBattleAnimationMoveListsKnightLordLance
        .word _List09 - aBattleAnimationMoveListsKnightLordLance
        .word _List10 - aBattleAnimationMoveListsKnightLordLance
        .word _List11 - aBattleAnimationMoveListsKnightLordLance

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_ROUTINE_ARG 1, 10, $2022
        ANIM_MOVE_ROUTINE 2, 4
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_ROUTINE_ARG 6, 10, $000F
        ANIM_MOVE_ROUTINE 7, 4
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 7, 5
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_ROUTINE_ARG 1, 10, $2022
        ANIM_MOVE_ROUTINE 2, 4
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_ROUTINE_ARG 6, 10, $000F
        ANIM_MOVE_ROUTINE 7, 4
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 7, 5
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_SCRIPT 7, 5
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsKnightLordLance ; 97/D70B

        .word _Script00 - aBattleAnimationMoveScriptsKnightLordLance
        .word _Script01 - aBattleAnimationMoveScriptsKnightLordLance
        .word _Script02 - aBattleAnimationMoveScriptsKnightLordLance
        .word _Script03 - aBattleAnimationMoveScriptsKnightLordLance
        .word _Script04 - aBattleAnimationMoveScriptsKnightLordLance
        .word _Script05 - aBattleAnimationMoveScriptsKnightLordLance
        .word _Script06 - aBattleAnimationMoveScriptsKnightLordLance

      _Script00
        .char 0, 0

      _Script01
        .char 0, 0, 0, 0, 0, 0

      _Script02
        .char 0, 0, 0, 0, 0, 0, 0

      _Script03
        .char 0, 3, 6, 10, -3

      _Script04
        .char 0, 0, 0, 16, 5, 0, -3

      _Script05
        .char 0, 3, 4, 0, 0

      _Script06
        .char 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        .char 0, 0

      aBattleAnimationActionsKnightLordRangedLance ; 97/D74B

        ; Move program of entry 19 of aBattleAnimationPrograms, used by: KnightLord (RangedLance),
        ; DukeKnight (RangedLance), MasterKnight (RangedLance), Paladin (RangedLance), PaladinF
        ; (RangedLance).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsKnightLordRangedLance ; 97/D784

        .word _List00 - aBattleAnimationMoveListsKnightLordRangedLance
        .word _List01 - aBattleAnimationMoveListsKnightLordRangedLance
        .word _List02 - aBattleAnimationMoveListsKnightLordRangedLance
        .word _List03 - aBattleAnimationMoveListsKnightLordRangedLance
        .word _List04 - aBattleAnimationMoveListsKnightLordRangedLance
        .word _List05 - aBattleAnimationMoveListsKnightLordRangedLance
        .word _List06 - aBattleAnimationMoveListsKnightLordRangedLance

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 1
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 2
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 3, 3
        ANIM_MOVE_SCRIPT 4, 4
        ANIM_MOVE_SCRIPT 2, 2
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 4, 4
        ANIM_MOVE_SCRIPT 2, 2
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 3, 3
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 5, 5
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsKnightLordRangedLance ; 97/D7AD

        .word _Script00 - aBattleAnimationMoveScriptsKnightLordRangedLance
        .word _Script01 - aBattleAnimationMoveScriptsKnightLordRangedLance
        .word _Script02 - aBattleAnimationMoveScriptsKnightLordRangedLance
        .word _Script03 - aBattleAnimationMoveScriptsKnightLordRangedLance
        .word _Script04 - aBattleAnimationMoveScriptsKnightLordRangedLance
        .word _Script05 - aBattleAnimationMoveScriptsKnightLordRangedLance

      _Script00
        .char 0, 0

      _Script01
        .char 3, 6, 10, -3

      _Script02
        .char 0, 0, 0, 3, 5, 0, -3

      _Script03
        .char 0, 3, 0, 0

      _Script04
        .char 0, 0, 0, 0, 0, 0, 0, 0

      _Script05
        .char 0

      aBattleAnimationActionsMasterKnightRangedAxe ; 97/D7D3

        ; Move program of entry 20 of aBattleAnimationPrograms, used by: MasterKnight (RangedAxe),
        ; GreatKnight (RangedAxe).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2

      aBattleAnimationMoveListsMasterKnightRangedAxe ; 97/D802

        .word _List00 - aBattleAnimationMoveListsMasterKnightRangedAxe
        .word _List01 - aBattleAnimationMoveListsMasterKnightRangedAxe
        .word _List02 - aBattleAnimationMoveListsMasterKnightRangedAxe
        .word _List03 - aBattleAnimationMoveListsMasterKnightRangedAxe
        .word _List04 - aBattleAnimationMoveListsMasterKnightRangedAxe
        .word _List05 - aBattleAnimationMoveListsMasterKnightRangedAxe
        .word _List06 - aBattleAnimationMoveListsMasterKnightRangedAxe

      _List00
        ANIM_MOVE_SCRIPT 6, 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_STILL 14
        ANIM_MOVE_STILL 12
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_STILL 12
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_STILL 14
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 15, 1
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_STILL 12
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_STILL 2
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsMasterKnightRangedAxe ; 97/D827

        .word _Script00 - aBattleAnimationMoveScriptsMasterKnightRangedAxe
        .word _Script01 - aBattleAnimationMoveScriptsMasterKnightRangedAxe

      _Script00
        .char 3, 6, 10, -3

      _Script01
        .char 0, 0, 3, 6, 10, -3

      aBattleAnimationActionsMasterKnightStaff ; 97/D835

        ; Move program of entry 21 of aBattleAnimationPrograms, used by: MasterKnight (Staff),
        ; PaladinF (Staff).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsMasterKnightStaff ; 97/D83D

        .word _List00 - aBattleAnimationMoveListsMasterKnightStaff
        .word _List01 - aBattleAnimationMoveListsMasterKnightStaff

      _List00
        ANIM_MOVE_STILL 2
        ANIM_MOVE_STILL 8
        ANIM_MOVE_STILL 3
        ANIM_MOVE_STILL 10
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 6, 0
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsMasterKnightStaff ; 97/D84D

        .word _Script00 - aBattleAnimationMoveScriptsMasterKnightStaff

      _Script00
        .char 3, 6, 10, -3

      aBattleAnimationActionsMasterKnightMagic ; 97/D853

        ; Move program of entry 22 of aBattleAnimationPrograms, used by: MasterKnight (Magic),
        ; MageKnight (Magic).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 2

      aBattleAnimationMoveListsMasterKnightMagic ; 97/D863

        .word _List00 - aBattleAnimationMoveListsMasterKnightMagic
        .word _List01 - aBattleAnimationMoveListsMasterKnightMagic
        .word _List02 - aBattleAnimationMoveListsMasterKnightMagic
        .word _List03 - aBattleAnimationMoveListsMasterKnightMagic

      _List00
        ANIM_MOVE_STILL 2
        ANIM_MOVE_STILL 8
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 6, 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_STILL 8
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 10, 1
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsMasterKnightMagic ; 97/D87D

        .word _Script00 - aBattleAnimationMoveScriptsMasterKnightMagic
        .word _Script01 - aBattleAnimationMoveScriptsMasterKnightMagic

      _Script00
        .char 3, 6, 10, -3

      _Script01
        .char 0, 3, 6, 10, -3

      aBattleAnimationActionsPegasusKnightSword ; 97/D88A

        ; Move program of entry 23 of aBattleAnimationPrograms, used by: PegasusKnight (Sword),
        ; FalconKnight (Sword).

        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 24
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 22
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 21
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 23
        ANIM_ACTION_LIST 23
        ANIM_ACTION_LIST 23
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 22
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 22
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 22
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 22
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 22
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 22
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 22
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsPegasusKnightSword ; 97/D8C3

        .word _List00 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List01 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List02 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List03 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List04 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List05 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List06 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List07 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List08 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List09 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List10 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List11 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List12 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List13 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List14 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List15 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List16 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List17 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List18 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List19 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List20 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List21 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List22 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List23 - aBattleAnimationMoveListsPegasusKnightSword
        .word _List24 - aBattleAnimationMoveListsPegasusKnightSword

      _List00
        ANIM_MOVE_STILL 2
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_ROUTINE 10, 6
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_ROUTINE 10, 6
        ANIM_MOVE_STILL 8
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 4, 0
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_STILL 8
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_ROUTINE 5, 6
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_STILL 5
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_ROUTINE_ARG 11, 10, $1020
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 1, 1
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_ROUTINE_ARG 2, 15, $3030
        ANIM_MOVE_ROUTINE_ARG 2, 15, $3030
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_ROUTINE_ARG 11, 10, $1020
        ANIM_MOVE_STILL 8
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_STILL 16
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_ROUTINE 5, 6
        ANIM_MOVE_ROUTINE 13, 16
        ANIM_MOVE_LIST_END

      _List15
        ANIM_MOVE_ROUTINE_ARG 11, 10, $1020
        ANIM_MOVE_STILL 16
        ANIM_MOVE_STILL 17
        ANIM_MOVE_STILL 18
        ANIM_MOVE_LIST_END

      _List16
        ANIM_MOVE_STILL 5
        ANIM_MOVE_ROUTINE 13, 16
        ANIM_MOVE_LIST_END

      _List17
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List18
        ANIM_MOVE_STILL 15
        ANIM_MOVE_ROUTINE_ARG 14, 15, $5815
        ANIM_MOVE_LIST_END

      _List19
        ANIM_MOVE_STILL 16
        ANIM_MOVE_STILL 17
        ANIM_MOVE_LIST_END

      _List20
        ANIM_MOVE_STILL 15
        ANIM_MOVE_ROUTINE_ARG 14, 15, $3015
        ANIM_MOVE_ROUTINE 10, 6
        ANIM_MOVE_STILL 8
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      _List21
        ANIM_MOVE_STILL 15
        ANIM_MOVE_ROUTINE_ARG 14, 15, $5015
        ANIM_MOVE_ROUTINE 10, 6
        ANIM_MOVE_STILL 19
        ANIM_MOVE_STILL 17
        ANIM_MOVE_LIST_END

      _List22
        ANIM_MOVE_STILL 15
        ANIM_MOVE_ROUTINE_ARG 14, 15, $5015
        ANIM_MOVE_ROUTINE 10, 6
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      _List23
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List24
        ANIM_MOVE_STILL 15
        ANIM_MOVE_ROUTINE_ARG 14, 15, $3815
        ANIM_MOVE_ROUTINE 10, 6
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsPegasusKnightSword ; 97/D992

        .word _Script00 - aBattleAnimationMoveScriptsPegasusKnightSword
        .word _Script01 - aBattleAnimationMoveScriptsPegasusKnightSword

      _Script00
        .char 0, 0, 10, 13, 0, 0

      _Script01
        .char 0, -2, -2, -9, -2, -2, -2, -2

      aBattleAnimationActionsPegasusKnightLance ; 97/D9A4

        ; Move program of entry 24 of aBattleAnimationPrograms, used by: PegasusKnight (Lance),
        ; FalconKnight (Lance).

        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 21
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 20
        ANIM_ACTION_LIST 0
        ANIM_ACTION_SEQUENCE 9
        ANIM_ACTION_SEQUENCE 9
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 21
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 21
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 21
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 21
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 21
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 21
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 21
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 21
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsPegasusKnightLance ; 97/D9E1

        .word _List00 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List01 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List02 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List03 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List04 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List05 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List06 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List07 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List08 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List09 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List10 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List11 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List12 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List13 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List14 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List15 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List16 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List17 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List18 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List19 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List20 - aBattleAnimationMoveListsPegasusKnightLance
        .word _List21 - aBattleAnimationMoveListsPegasusKnightLance

      _List00
        ANIM_MOVE_STILL 1
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_ROUTINE 10, 6
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_ROUTINE 10, 6
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 4, 0
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_STILL 1
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_ROUTINE 10, 6
        ANIM_MOVE_STILL 19
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_ROUTINE_ARG 12, 10, $1021
        ANIM_MOVE_STILL 19
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_ROUTINE_ARG 12, 10, $1021
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_ROUTINE_ARG 1, 15, $2030
        ANIM_MOVE_ROUTINE_ARG 1, 15, $2030
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_ROUTINE_ARG 12, 10, $1021
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_STILL 14
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_ROUTINE 5, 6
        ANIM_MOVE_ROUTINE 13, 16
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_ROUTINE_ARG 12, 10, $1021
        ANIM_MOVE_STILL 5
        ANIM_MOVE_ROUTINE 13, 16
        ANIM_MOVE_LIST_END

      _List15
        ANIM_MOVE_STILL 5
        ANIM_MOVE_ROUTINE 13, 16
        ANIM_MOVE_LIST_END

      _List16
        ANIM_MOVE_STILL 16
        ANIM_MOVE_ROUTINE_ARG 15, 15, $5815
        ANIM_MOVE_LIST_END

      _List17
        ANIM_MOVE_STILL 17
        ANIM_MOVE_LIST_END

      _List18
        ANIM_MOVE_STILL 20
        ANIM_MOVE_LIST_END

      _List19
        ANIM_MOVE_STILL 16
        ANIM_MOVE_ROUTINE_ARG 15, 15, $4015
        ANIM_MOVE_ROUTINE 10, 6
        ANIM_MOVE_STILL 19
        ANIM_MOVE_LIST_END

      _List20
        ANIM_MOVE_ROUTINE 10, 6
        ANIM_MOVE_LIST_END

      _List21
        ANIM_MOVE_STILL 16
        ANIM_MOVE_ROUTINE_ARG 15, 15, $4015
        ANIM_MOVE_ROUTINE 10, 6
        ANIM_MOVE_STILL 17
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsPegasusKnightLance ; 97/DA85

        .word _Script00 - aBattleAnimationMoveScriptsPegasusKnightLance

      _Script00
        .char 0, 0, 10, 13, 0, 0

      aBattleAnimationActionsPegasusKnightRangedLance ; 97/DA8D

        ; Move program of entry 25 of aBattleAnimationPrograms, used by: PegasusKnight
        ; (RangedLance), FalconKnight (RangedLance).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1

      aBattleAnimationMoveListsPegasusKnightRangedLance ; 97/DABC

        .word _List00 - aBattleAnimationMoveListsPegasusKnightRangedLance
        .word _List01 - aBattleAnimationMoveListsPegasusKnightRangedLance

      _List00
        ANIM_MOVE_SCRIPT 4, 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_STILL 8
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsPegasusKnightRangedLance ; 97/DAC6

        .word _Script00 - aBattleAnimationMoveScriptsPegasusKnightRangedLance

      _Script00
        .char 0, 0, 10, 13, 0

      aBattleAnimationActionsFalconKnightStaff ; 97/DACD

        ; Move program of entry 26 of aBattleAnimationPrograms, used by: FalconKnight (Staff).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1

      aBattleAnimationMoveListsFalconKnightStaff ; 97/DAD5

        .word _List00 - aBattleAnimationMoveListsFalconKnightStaff
        .word _List01 - aBattleAnimationMoveListsFalconKnightStaff

      _List00
        ANIM_MOVE_SCRIPT 4, 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsFalconKnightStaff ; 97/DADF

        .word _Script00 - aBattleAnimationMoveScriptsFalconKnightStaff

      _Script00
        .char 0, 10, 13, 0

      aBattleAnimationActionsDragonriderSword ; 97/DAE5

        ; Move program of entry 27 of aBattleAnimationPrograms, used by: Dragonrider (Sword),
        ; Dragonknight (Sword), Dragonmaster (Sword).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 13

      aBattleAnimationMoveListsDragonriderSword ; 97/DB1F

        .word _List00 - aBattleAnimationMoveListsDragonriderSword
        .word _List01 - aBattleAnimationMoveListsDragonriderSword
        .word _List02 - aBattleAnimationMoveListsDragonriderSword
        .word _List03 - aBattleAnimationMoveListsDragonriderSword
        .word _List04 - aBattleAnimationMoveListsDragonriderSword
        .word _List05 - aBattleAnimationMoveListsDragonriderSword
        .word _List06 - aBattleAnimationMoveListsDragonriderSword
        .word _List07 - aBattleAnimationMoveListsDragonriderSword
        .word _List08 - aBattleAnimationMoveListsDragonriderSword
        .word _List09 - aBattleAnimationMoveListsDragonriderSword
        .word _List10 - aBattleAnimationMoveListsDragonriderSword
        .word _List11 - aBattleAnimationMoveListsDragonriderSword
        .word _List12 - aBattleAnimationMoveListsDragonriderSword
        .word _List13 - aBattleAnimationMoveListsDragonriderSword
        .word _List14 - aBattleAnimationMoveListsDragonriderSword
        .word _List15 - aBattleAnimationMoveListsDragonriderSword
        .word _List16 - aBattleAnimationMoveListsDragonriderSword
        .word _List17 - aBattleAnimationMoveListsDragonriderSword
        .word _List18 - aBattleAnimationMoveListsDragonriderSword

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_ROUTINE_ARG 1, 12, $1024
        ANIM_MOVE_SCRIPT 6, 4
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_ROUTINE 12, 6
        ANIM_MOVE_ROUTINE 18, 4
        ANIM_MOVE_SCRIPT 4, 2
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 3, 1
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 4, 2
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_ROUTINE_ARG 17, 15, $1B2C
        ANIM_MOVE_ROUTINE_ARG 17, 15, $192C
        ANIM_MOVE_ROUTINE 12, 6
        ANIM_MOVE_ROUTINE 18, 4
        ANIM_MOVE_SCRIPT 19, 9
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_ROUTINE_ARG 5, 15, $301C
        ANIM_MOVE_ROUTINE 7, 6
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_SCRIPT 9, 5
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_STILL 22
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_ROUTINE 2, 6
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_ROUTINE_ARG 5, 15, $301C
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_SCRIPT 6, 4
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_ROUTINE 8, 7
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_ROUTINE_ARG 7, 15, $1D26
        ANIM_MOVE_ROUTINE_ARG 17, 15, $202C
        ANIM_MOVE_ROUTINE 15, 6
        ANIM_MOVE_SCRIPT 4, 2
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_SCRIPT 13, 7
        ANIM_MOVE_LIST_END

      _List15
        ANIM_MOVE_SCRIPT 14, 8
        ANIM_MOVE_LIST_END

      _List16
        ANIM_MOVE_ROUTINE_ARG 7, 15, $1A26
        ANIM_MOVE_ROUTINE_ARG 23, 15, $1726
        ANIM_MOVE_ROUTINE_ARG 17, 15, $202C
        ANIM_MOVE_ROUTINE 16, 6
        ANIM_MOVE_SCRIPT 9, 5
        ANIM_MOVE_LIST_END

      _List17
        ANIM_MOVE_STILL 20
        ANIM_MOVE_LIST_END

      _List18
        ANIM_MOVE_STILL 10
        ANIM_MOVE_STILL 21
        ANIM_MOVE_STILL 22
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsDragonriderSword ; 97/DBB4

        .word _Script00 - aBattleAnimationMoveScriptsDragonriderSword
        .word _Script01 - aBattleAnimationMoveScriptsDragonriderSword
        .word _Script02 - aBattleAnimationMoveScriptsDragonriderSword
        .word _Script03 - aBattleAnimationMoveScriptsDragonriderSword
        .word _Script04 - aBattleAnimationMoveScriptsDragonriderSword
        .word _Script05 - aBattleAnimationMoveScriptsDragonriderSword
        .word _Script06 - aBattleAnimationMoveScriptsDragonriderSword
        .word _Script07 - aBattleAnimationMoveScriptsDragonriderSword
        .word _Script08 - aBattleAnimationMoveScriptsDragonriderSword
        .word _Script09 - aBattleAnimationMoveScriptsDragonriderSword

      _Script00
        .char 0, 0, 0, 0, 0, 0, 0, 0, 0

      _Script01
        .char 0, 9, -9, 0, 0, 0

      _Script02
        .char -8, 0, 0, 0, 0, 0, 0, 0, 0

      _Script03
        .char 0, 11, -11, 0, 0

      _Script04
        .char -9

      _Script05
        .char 0, -8, 0, 0, 0, 0, 0, 0

      _Script06
        .char 0

      _Script07
        .char 0, 0, 8, 0, -8, 0, 0

      _Script08
        .char 0, 0, 8, -8

      _Script09
        .char 0, -8, 0, 0, 0

      aBattleAnimationActionsDragonriderLance ; 97/DBFF

        ; Move program of entry 28 of aBattleAnimationPrograms, used by: Dragonrider (Lance),
        ; Dragonknight (Lance), Dragonmaster (Lance).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 11

      aBattleAnimationMoveListsDragonriderLance ; 97/DC3C

        .word _List00 - aBattleAnimationMoveListsDragonriderLance
        .word _List01 - aBattleAnimationMoveListsDragonriderLance
        .word _List02 - aBattleAnimationMoveListsDragonriderLance
        .word _List03 - aBattleAnimationMoveListsDragonriderLance
        .word _List04 - aBattleAnimationMoveListsDragonriderLance
        .word _List05 - aBattleAnimationMoveListsDragonriderLance
        .word _List06 - aBattleAnimationMoveListsDragonriderLance
        .word _List07 - aBattleAnimationMoveListsDragonriderLance
        .word _List08 - aBattleAnimationMoveListsDragonriderLance
        .word _List09 - aBattleAnimationMoveListsDragonriderLance
        .word _List10 - aBattleAnimationMoveListsDragonriderLance
        .word _List11 - aBattleAnimationMoveListsDragonriderLance

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_ROUTINE_ARG 1, 12, $0820
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_ROUTINE 4, 6
        ANIM_MOVE_ROUTINE 5, 4
        ANIM_MOVE_STILL 6
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_ROUTINE_ARG 7, 15, $202D
        ANIM_MOVE_ROUTINE_ARG 8, 15, $202B
        ANIM_MOVE_ROUTINE 9, 6
        ANIM_MOVE_SCRIPT 10, 3
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_STILL 11
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_ROUTINE_ARG 7, 15, $202D
        ANIM_MOVE_ROUTINE_ARG 12, 15, $1C25
        ANIM_MOVE_ROUTINE_ARG 12, 15, $1C25
        ANIM_MOVE_ROUTINE 9, 6
        ANIM_MOVE_SCRIPT 10, 3
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_ROUTINE_ARG 12, 15, $1C25
        ANIM_MOVE_ROUTINE_ARG 12, 15, $1C25
        ANIM_MOVE_ROUTINE_ARG 12, 15, $2025
        ANIM_MOVE_ROUTINE 9, 6
        ANIM_MOVE_ROUTINE 14, 4
        ANIM_MOVE_SCRIPT 10, 3
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_STILL 15
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 19, 4
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_ROUTINE_ARG 7, 15, $202D
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_ROUTINE 20, 7
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsDragonriderLance ; 97/DCAA

        .word _Script00 - aBattleAnimationMoveScriptsDragonriderLance
        .word _Script01 - aBattleAnimationMoveScriptsDragonriderLance
        .word _Script02 - aBattleAnimationMoveScriptsDragonriderLance
        .word _Script03 - aBattleAnimationMoveScriptsDragonriderLance
        .word _Script04 - aBattleAnimationMoveScriptsDragonriderLance

      _Script00
        .char 0

      _Script01
        .char -9

      _Script02
        .char 0, 9, -9, 0

      _Script03
        .char 0, 0, -10, 0, 0

      _Script04
        .char 0

      aBattleAnimationActionsDragonriderRangedLance ; 97/DCC0

        ; Move program of entry 29 of aBattleAnimationPrograms, used by: Dragonrider
        ; (RangedLance), Dragonknight (RangedLance), Dragonmaster (RangedLance).

        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsDragonriderRangedLance ; 97/DCFD

        .word _List00 - aBattleAnimationMoveListsDragonriderRangedLance
        .word _List01 - aBattleAnimationMoveListsDragonriderRangedLance
        .word _List02 - aBattleAnimationMoveListsDragonriderRangedLance
        .word _List03 - aBattleAnimationMoveListsDragonriderRangedLance
        .word _List04 - aBattleAnimationMoveListsDragonriderRangedLance
        .word _List05 - aBattleAnimationMoveListsDragonriderRangedLance
        .word _List06 - aBattleAnimationMoveListsDragonriderRangedLance
        .word _List07 - aBattleAnimationMoveListsDragonriderRangedLance
        .word _List08 - aBattleAnimationMoveListsDragonriderRangedLance
        .word _List09 - aBattleAnimationMoveListsDragonriderRangedLance
        .word _List10 - aBattleAnimationMoveListsDragonriderRangedLance
        .word _List11 - aBattleAnimationMoveListsDragonriderRangedLance
        .word _List12 - aBattleAnimationMoveListsDragonriderRangedLance
        .word _List13 - aBattleAnimationMoveListsDragonriderRangedLance
        .word _List14 - aBattleAnimationMoveListsDragonriderRangedLance

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 2, 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_ROUTINE 3, 6
        ANIM_MOVE_SCRIPT 4, 1
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_ROUTINE_ARG 6, 15, $3045
        ANIM_MOVE_ROUTINE 5, 6
        ANIM_MOVE_SCRIPT 4, 1
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 4, 1
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_ROUTINE 1, 7
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 8, 3
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_ROUTINE 3, 6
        ANIM_MOVE_SCRIPT 8, 3
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_ROUTINE_ARG 6, 15, $3045
        ANIM_MOVE_ROUTINE 5, 6
        ANIM_MOVE_SCRIPT 8, 3
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_ROUTINE_ARG 6, 15, $3045
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_ROUTINE_ARG 9, 13, $202F
        ANIM_MOVE_SCRIPT 10, 4
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_ROUTINE_ARG 6, 15, $2045
        ANIM_MOVE_ROUTINE_ARG 6, 15, $2045
        ANIM_MOVE_ROUTINE 11, 6
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_ROUTINE 5, 6
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_SCRIPT 12, 5
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsDragonriderRangedLance ; 97/DD66

        .word _Script00 - aBattleAnimationMoveScriptsDragonriderRangedLance
        .word _Script01 - aBattleAnimationMoveScriptsDragonriderRangedLance
        .word _Script02 - aBattleAnimationMoveScriptsDragonriderRangedLance
        .word _Script03 - aBattleAnimationMoveScriptsDragonriderRangedLance
        .word _Script04 - aBattleAnimationMoveScriptsDragonriderRangedLance
        .word _Script05 - aBattleAnimationMoveScriptsDragonriderRangedLance
        .word _Script06 - aBattleAnimationMoveScriptsDragonriderRangedLance

      _Script00
        .char 0, 9, -9, 0

      _Script01
        .char -9, 0, 0, 0, 0

      _Script02
        .char 0

      _Script03
        .char 0, 0, 9, 0, -9, 0

      _Script04
        .char -6

      _Script05
        .char 0

      _Script06
        .char 0, 0, 0, 0, 0

      aBattleAnimationActionsBowArmorBow ; 97/DD8B

        ; Move program of entry 30 of aBattleAnimationPrograms, used by: BowArmor (Bow).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsBowArmorBow ; 97/DDBC

        .word _List00 - aBattleAnimationMoveListsBowArmorBow
        .word _List01 - aBattleAnimationMoveListsBowArmorBow
        .word _List02 - aBattleAnimationMoveListsBowArmorBow
        .word _List03 - aBattleAnimationMoveListsBowArmorBow
        .word _List04 - aBattleAnimationMoveListsBowArmorBow
        .word _List05 - aBattleAnimationMoveListsBowArmorBow
        .word _List06 - aBattleAnimationMoveListsBowArmorBow
        .word _List07 - aBattleAnimationMoveListsBowArmorBow
        .word _List08 - aBattleAnimationMoveListsBowArmorBow
        .word _List09 - aBattleAnimationMoveListsBowArmorBow
        .word _List10 - aBattleAnimationMoveListsBowArmorBow

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 7, 5
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 8, 6
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 19, 5
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_SCRIPT 20, 2
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsBowArmorBow ; 97/DDFF

        .word _Script00 - aBattleAnimationMoveScriptsBowArmorBow
        .word _Script01 - aBattleAnimationMoveScriptsBowArmorBow
        .word _Script02 - aBattleAnimationMoveScriptsBowArmorBow
        .word _Script03 - aBattleAnimationMoveScriptsBowArmorBow
        .word _Script04 - aBattleAnimationMoveScriptsBowArmorBow
        .word _Script05 - aBattleAnimationMoveScriptsBowArmorBow
        .word _Script06 - aBattleAnimationMoveScriptsBowArmorBow

      _Script00
        .char 0, 2, 0

      _Script01
        .char 4, 4, 4, 4, 4, 3, 3, 2, 2

      _Script02
        .char 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

      _Script03
        .char 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0

      _Script04
        .char 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

      _Script05
        .char 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0

      _Script06
        .char 0, 2

      aBattleAnimationActionsArcherBow ; 97/DE4E

        ; Move program of entry 31 of aBattleAnimationPrograms, used by: Archer (Bow), Sniper
        ; (Bow).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsArcherBow ; 97/DE80

        .word _List00 - aBattleAnimationMoveListsArcherBow
        .word _List01 - aBattleAnimationMoveListsArcherBow
        .word _List02 - aBattleAnimationMoveListsArcherBow
        .word _List03 - aBattleAnimationMoveListsArcherBow
        .word _List04 - aBattleAnimationMoveListsArcherBow
        .word _List05 - aBattleAnimationMoveListsArcherBow
        .word _List06 - aBattleAnimationMoveListsArcherBow

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 1
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 2
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 3, 3
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 4, 4
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 10, 2
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 11, 3
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsArcherBow ; 97/DEA3

        .word _Script00 - aBattleAnimationMoveScriptsArcherBow
        .word _Script01 - aBattleAnimationMoveScriptsArcherBow
        .word _Script02 - aBattleAnimationMoveScriptsArcherBow
        .word _Script03 - aBattleAnimationMoveScriptsArcherBow
        .word _Script04 - aBattleAnimationMoveScriptsArcherBow

      _Script00
        .char 0, 0

      _Script01
        .char 0, 8, 9, -1

      _Script02
        .char 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2
        .char 0

      _Script03
        .char 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        .char -2

      _Script04
        .char 0

      aBattleAnimationActionsGeneralSword ; 97/DED6

        ; Move program of entry 32 of aBattleAnimationPrograms, used by: General (Sword), General
        ; (Axe), Emperor (Sword), Emperor (Axe), Baron (Sword), Baron (Axe), AxeArmor (Axe),
        ; SwordArmor (Sword).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 18
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 22
        ANIM_ACTION_LIST 23
        ANIM_ACTION_LIST 22
        ANIM_ACTION_LIST 22
        ANIM_ACTION_LIST 24
        ANIM_ACTION_LIST 24
        ANIM_ACTION_LIST 24
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 11
        ANIM_ACTION_SEQUENCE 25

      aBattleAnimationMoveListsGeneralSword ; 97/DF0E

        .word _List00 - aBattleAnimationMoveListsGeneralSword
        .word _List01 - aBattleAnimationMoveListsGeneralSword
        .word _List02 - aBattleAnimationMoveListsGeneralSword
        .word _List03 - aBattleAnimationMoveListsGeneralSword
        .word _List04 - aBattleAnimationMoveListsGeneralSword
        .word _List05 - aBattleAnimationMoveListsGeneralSword
        .word _List06 - aBattleAnimationMoveListsGeneralSword
        .word _List07 - aBattleAnimationMoveListsGeneralSword
        .word _List08 - aBattleAnimationMoveListsGeneralSword
        .word _List09 - aBattleAnimationMoveListsGeneralSword
        .word _List10 - aBattleAnimationMoveListsGeneralSword
        .word _List11 - aBattleAnimationMoveListsGeneralSword
        .word _List12 - aBattleAnimationMoveListsGeneralSword
        .word _List13 - aBattleAnimationMoveListsGeneralSword
        .word _List14 - aBattleAnimationMoveListsGeneralSword
        .word _List15 - aBattleAnimationMoveListsGeneralSword
        .word _List16 - aBattleAnimationMoveListsGeneralSword
        .word _List17 - aBattleAnimationMoveListsGeneralSword
        .word _List18 - aBattleAnimationMoveListsGeneralSword
        .word _List19 - aBattleAnimationMoveListsGeneralSword
        .word _List20 - aBattleAnimationMoveListsGeneralSword
        .word _List21 - aBattleAnimationMoveListsGeneralSword
        .word _List22 - aBattleAnimationMoveListsGeneralSword
        .word _List23 - aBattleAnimationMoveListsGeneralSword
        .word _List24 - aBattleAnimationMoveListsGeneralSword

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_SCRIPT 8, 7
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_SCRIPT 7, 6
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_SCRIPT 7, 6
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_SCRIPT 7, 6
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_SCRIPT 10, 9
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_SCRIPT 11, 10
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_LIST_END

      _List15
        ANIM_MOVE_SCRIPT 11, 10
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List16
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_STILL 16
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List17
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_STILL 16
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List18
        ANIM_MOVE_STILL 16
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List19
        ANIM_MOVE_SCRIPT 11, 10
        ANIM_MOVE_STILL 16
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List20
        ANIM_MOVE_SCRIPT 18, 15
        ANIM_MOVE_LIST_END

      _List21
        ANIM_MOVE_SCRIPT 19, 16
        ANIM_MOVE_LIST_END

      _List22
        ANIM_MOVE_SCRIPT 20, 17
        ANIM_MOVE_LIST_END

      _List23
        ANIM_MOVE_STILL 21
        ANIM_MOVE_LIST_END

      _List24
        ANIM_MOVE_SCRIPT 22, 18
        ANIM_MOVE_SCRIPT 23, 19
        ANIM_MOVE_SCRIPT 24, 20
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsGeneralSword ; 97/DFB5

        .word _Script00 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script01 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script02 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script03 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script04 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script05 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script06 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script07 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script08 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script09 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script10 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script11 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script12 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script13 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script14 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script15 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script16 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script17 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script18 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script19 - aBattleAnimationMoveScriptsGeneralSword
        .word _Script20 - aBattleAnimationMoveScriptsGeneralSword

      _Script00
        .char 0, 16, 0, 0, 0, 0, 0

      _Script01
        .char -4, -2, -2, -1, 0, 0, -6, -1, -2, 0, 0, 0, 0

      _Script02
        .char 0, 0, 0, -16, -4, 0, 0, 0, 0

      _Script03
        .char 8, 16, 0, 0, 0

      _Script04
        .char 0, 0, 0, -19, -5, 0, 0, 0, 0, 0

      _Script05
        .char 0, 0, 0, 0, 0, 0, 0

      _Script06
        .char 0, 0, 0

      _Script07
        .char 0

      _Script08
        .char 0, 0, 0, 0, 0, 0, 0, 0

      _Script09
        .char 4, 2, 2, 5, 0, 16, 0, 0, 0

      _Script10
        .char 8, 16, 0, 0, 0

      _Script11
        .char 0, 16, 0, 0, 0, 0, 0, 0, 0, 0

      _Script12
        .char -18, -6, 0

      _Script13
        .char 0, 0, 0

      _Script14
        .char 0, 0

      _Script15
        .char 0, 6, 16, 0, 0, 0

      _Script16
        .char 0, 6, 16, 0, 0, 0

      _Script17
        .char 0, 0, 16, 0, 0, 0

      _Script18
        .char 0, 0

      _Script19
        .char 0, -16, -4, 0

      _Script20
        .char 0, 5, 0

      aBattleAnimationActionsGeneralLance ; 97/E059

        ; Move program of entry 33 of aBattleAnimationPrograms, used by: General (Lance), Emperor
        ; (Lance), Baron (Lance), LanceArmor (Lance).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 13

      aBattleAnimationMoveListsGeneralLance ; 97/E094

        .word _List00 - aBattleAnimationMoveListsGeneralLance
        .word _List01 - aBattleAnimationMoveListsGeneralLance
        .word _List02 - aBattleAnimationMoveListsGeneralLance
        .word _List03 - aBattleAnimationMoveListsGeneralLance
        .word _List04 - aBattleAnimationMoveListsGeneralLance
        .word _List05 - aBattleAnimationMoveListsGeneralLance
        .word _List06 - aBattleAnimationMoveListsGeneralLance
        .word _List07 - aBattleAnimationMoveListsGeneralLance
        .word _List08 - aBattleAnimationMoveListsGeneralLance
        .word _List09 - aBattleAnimationMoveListsGeneralLance
        .word _List10 - aBattleAnimationMoveListsGeneralLance
        .word _List11 - aBattleAnimationMoveListsGeneralLance
        .word _List12 - aBattleAnimationMoveListsGeneralLance
        .word _List13 - aBattleAnimationMoveListsGeneralLance
        .word _List14 - aBattleAnimationMoveListsGeneralLance

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 12, 11
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 6, 5
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_SCRIPT 7, 6
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_SCRIPT 7, 6
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_SCRIPT 7, 6
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 8, 7
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_SCRIPT 10, 9
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_SCRIPT 9, 8
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_SCRIPT 11, 10
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_SCRIPT 11, 10
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_SCRIPT 7, 6
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsGeneralLance ; 97/E0EF

        .word _Script00 - aBattleAnimationMoveScriptsGeneralLance
        .word _Script01 - aBattleAnimationMoveScriptsGeneralLance
        .word _Script02 - aBattleAnimationMoveScriptsGeneralLance
        .word _Script03 - aBattleAnimationMoveScriptsGeneralLance
        .word _Script04 - aBattleAnimationMoveScriptsGeneralLance
        .word _Script05 - aBattleAnimationMoveScriptsGeneralLance
        .word _Script06 - aBattleAnimationMoveScriptsGeneralLance
        .word _Script07 - aBattleAnimationMoveScriptsGeneralLance
        .word _Script08 - aBattleAnimationMoveScriptsGeneralLance
        .word _Script09 - aBattleAnimationMoveScriptsGeneralLance
        .word _Script10 - aBattleAnimationMoveScriptsGeneralLance
        .word _Script11 - aBattleAnimationMoveScriptsGeneralLance

      _Script00
        .char 0, 16, 0, 0, 0

      _Script01
        .char -4, -2, -1, -1, 0, 0, -6, -1, -2, 0, 0, 0

      _Script02
        .char 0, 16, 0, 0, 0

      _Script03
        .char 0, 0, 0, -18, -4, 0, 0

      _Script04
        .char 0, 4, 2, 1, 6, 7, 0, 0, 0, 0

      _Script05
        .char 6, 16, 0, 0, 0

      _Script06
        .char 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -17, -6, 0, 0, 0

      _Script07
        .char 0, 6

      _Script08
        .char 0, -14, -2, 0, 0, 0, 0, 0, 0

      _Script09
        .char 0

      _Script10
        .char 0, 0, 0

      _Script11
        .char 7, 1, 0, 2, 5, 0, 16, 0, 0, 0

      aBattleAnimationActionsGeneralRangedLance ; 97/E15B

        ; Move program of entry 34 of aBattleAnimationPrograms, used by: General (RangedLance),
        ; Emperor (RangedLance), Baron (RangedLance), LanceArmor (RangedLance).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_SEQUENCE 5
        ANIM_ACTION_SEQUENCE 5
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_SEQUENCE 5
        ANIM_ACTION_SEQUENCE 5
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3

      aBattleAnimationMoveListsGeneralRangedLance ; 97/E18A

        .word _List00 - aBattleAnimationMoveListsGeneralRangedLance
        .word _List01 - aBattleAnimationMoveListsGeneralRangedLance
        .word _List02 - aBattleAnimationMoveListsGeneralRangedLance
        .word _List03 - aBattleAnimationMoveListsGeneralRangedLance
        .word _List04 - aBattleAnimationMoveListsGeneralRangedLance

      _List00
        ANIM_MOVE_SCRIPT 8, 0
        ANIM_MOVE_SCRIPT 3, 4
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 4, 1
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 1, 2
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 14, 3
        ANIM_MOVE_SCRIPT 3, 4
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 3, 4
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsGeneralRangedLance ; 97/E1A7

        .word _Script00 - aBattleAnimationMoveScriptsGeneralRangedLance
        .word _Script01 - aBattleAnimationMoveScriptsGeneralRangedLance
        .word _Script02 - aBattleAnimationMoveScriptsGeneralRangedLance
        .word _Script03 - aBattleAnimationMoveScriptsGeneralRangedLance
        .word _Script04 - aBattleAnimationMoveScriptsGeneralRangedLance

      _Script00
        .char 0, 16, 0, 0, 0, -16, -6, 0

      _Script01
        .char 0, 16, 0, 0, 0, 0

      _Script02
        .char 4, 2, 2, 5, 0, 16, 0, 0, 0, 0

      _Script03
        .char 0, -16, -6, 0

      _Script04
        .char 5, 16, 0, 0, 0, 0

      aBattleAnimationActionsGeneralRangedAxe ; 97/E1D3

        ; Move program of entry 35 of aBattleAnimationPrograms, used by: General (RangedAxe),
        ; Emperor (RangedAxe), Baron (RangedAxe), AxeArmor (RangedAxe).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_SEQUENCE 9
        ANIM_ACTION_SEQUENCE 9
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_SEQUENCE 9
        ANIM_ACTION_SEQUENCE 9
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3

      aBattleAnimationMoveListsGeneralRangedAxe ; 97/E202

        .word _List00 - aBattleAnimationMoveListsGeneralRangedAxe
        .word _List01 - aBattleAnimationMoveListsGeneralRangedAxe
        .word _List02 - aBattleAnimationMoveListsGeneralRangedAxe
        .word _List03 - aBattleAnimationMoveListsGeneralRangedAxe
        .word _List04 - aBattleAnimationMoveListsGeneralRangedAxe

      _List00
        ANIM_MOVE_SCRIPT 5, 0
        ANIM_MOVE_SCRIPT 7, 1
        ANIM_MOVE_SCRIPT 5, 3
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 12, 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 1, 2
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 7, 1
        ANIM_MOVE_SCRIPT 5, 3
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 5, 0
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsGeneralRangedAxe ; 97/E221

        .word _Script00 - aBattleAnimationMoveScriptsGeneralRangedAxe
        .word _Script01 - aBattleAnimationMoveScriptsGeneralRangedAxe
        .word _Script02 - aBattleAnimationMoveScriptsGeneralRangedAxe
        .word _Script03 - aBattleAnimationMoveScriptsGeneralRangedAxe

      _Script00
        .char 0, 16, 0, 0, 0, 0

      _Script01
        .char 0, 0, -16, -6

      _Script02
        .char 4, 2, 2, 5, 0, 16, 0, 0, 0, 0

      _Script03
        .char 5, 16, 0, 0, 0, 0

      aBattleAnimationActionsGeneralBow ; 97/E243

        ; Move program of entry 36 of aBattleAnimationPrograms, used by: General (Bow), Emperor
        ; (Bow), Baron (Bow).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsGeneralBow ; 97/E274

        .word _List00 - aBattleAnimationMoveListsGeneralBow
        .word _List01 - aBattleAnimationMoveListsGeneralBow
        .word _List02 - aBattleAnimationMoveListsGeneralBow
        .word _List03 - aBattleAnimationMoveListsGeneralBow
        .word _List04 - aBattleAnimationMoveListsGeneralBow
        .word _List05 - aBattleAnimationMoveListsGeneralBow
        .word _List06 - aBattleAnimationMoveListsGeneralBow
        .word _List07 - aBattleAnimationMoveListsGeneralBow
        .word _List08 - aBattleAnimationMoveListsGeneralBow
        .word _List09 - aBattleAnimationMoveListsGeneralBow
        .word _List10 - aBattleAnimationMoveListsGeneralBow

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 7, 5
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 8, 6
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 19, 5
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_SCRIPT 20, 2
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsGeneralBow ; 97/E2B7

        .word _Script00 - aBattleAnimationMoveScriptsGeneralBow
        .word _Script01 - aBattleAnimationMoveScriptsGeneralBow
        .word _Script02 - aBattleAnimationMoveScriptsGeneralBow
        .word _Script03 - aBattleAnimationMoveScriptsGeneralBow
        .word _Script04 - aBattleAnimationMoveScriptsGeneralBow
        .word _Script05 - aBattleAnimationMoveScriptsGeneralBow
        .word _Script06 - aBattleAnimationMoveScriptsGeneralBow

      _Script00
        .char 0, 2, 0

      _Script01
        .char 4, 4, 4, 4, 4, 3, 3, 2, 2

      _Script02
        .char 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

      _Script03
        .char 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0

      _Script04
        .char 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

      _Script05
        .char 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0

      _Script06
        .char 0, 1

      aBattleAnimationActionsEmperorStaff ; 97/E305

        ; Move program of entry 37 of aBattleAnimationPrograms, used by: Emperor (Staff), Baron
        ; (Staff).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1

      aBattleAnimationMoveListsEmperorStaff ; 97/E30D

        .word _List00 - aBattleAnimationMoveListsEmperorStaff
        .word _List01 - aBattleAnimationMoveListsEmperorStaff
        .word _List02 - aBattleAnimationMoveListsEmperorStaff

      _List00
        ANIM_MOVE_SCRIPT 5, 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 1, 1
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsEmperorStaff ; 97/E31C

        .word _Script00 - aBattleAnimationMoveScriptsEmperorStaff
        .word _Script01 - aBattleAnimationMoveScriptsEmperorStaff

      _Script00
        .char 0, 16, 0, 0, 0, 0

      _Script01
        .char 4, 2, 2, 5, 0, 16, 0, 0, 0, 0

      aBattleAnimationActionsEmperorMagic ; 97/E330

        ; Move program of entry 38 of aBattleAnimationPrograms, used by: Emperor (Magic), Baron
        ; (Magic).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 4

      aBattleAnimationMoveListsEmperorMagic ; 97/E340

        .word _List00 - aBattleAnimationMoveListsEmperorMagic
        .word _List01 - aBattleAnimationMoveListsEmperorMagic
        .word _List02 - aBattleAnimationMoveListsEmperorMagic
        .word _List03 - aBattleAnimationMoveListsEmperorMagic
        .word _List04 - aBattleAnimationMoveListsEmperorMagic
        .word _List05 - aBattleAnimationMoveListsEmperorMagic

      _List00
        ANIM_MOVE_SCRIPT 5, 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 1, 1
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 6, 2
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 7, 0
        ANIM_MOVE_SCRIPT 8, 3
        ANIM_MOVE_SCRIPT 9, 4
        ANIM_MOVE_SCRIPT 11, 5
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 6, 2
        ANIM_MOVE_SCRIPT 7, 0
        ANIM_MOVE_SCRIPT 8, 3
        ANIM_MOVE_SCRIPT 9, 4
        ANIM_MOVE_SCRIPT 11, 5
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsEmperorMagic ; 97/E36E

        .word _Script00 - aBattleAnimationMoveScriptsEmperorMagic
        .word _Script01 - aBattleAnimationMoveScriptsEmperorMagic
        .word _Script02 - aBattleAnimationMoveScriptsEmperorMagic
        .word _Script03 - aBattleAnimationMoveScriptsEmperorMagic
        .word _Script04 - aBattleAnimationMoveScriptsEmperorMagic
        .word _Script05 - aBattleAnimationMoveScriptsEmperorMagic

      _Script00
        .char 0, 16, 0, 0, 0, 0

      _Script01
        .char 4, 2, 2, 5, 0, 16, 0, 0, 0, 0

      _Script02
        .char 0, 4, 2, 2, 5

      _Script03
        .char 0, -16, 0

      _Script04
        .char -5, 0

      _Script05
        .char 5, 0, 0

      aBattleAnimationActionsBarbarianAxe ; 97/E397

        ; Move program of entry 39 of aBattleAnimationPrograms, used by: Barbarian (Axe), Fighter
        ; (Axe), Brigand (Axe), Warrior (Axe), Pirate (Axe).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 20
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 14
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 19
        ANIM_ACTION_LIST 19

      aBattleAnimationMoveListsBarbarianAxe ; 97/E3D6

        .word _List00 - aBattleAnimationMoveListsBarbarianAxe
        .word _List01 - aBattleAnimationMoveListsBarbarianAxe
        .word _List02 - aBattleAnimationMoveListsBarbarianAxe
        .word _List03 - aBattleAnimationMoveListsBarbarianAxe
        .word _List04 - aBattleAnimationMoveListsBarbarianAxe
        .word _List05 - aBattleAnimationMoveListsBarbarianAxe
        .word _List06 - aBattleAnimationMoveListsBarbarianAxe
        .word _List07 - aBattleAnimationMoveListsBarbarianAxe
        .word _List08 - aBattleAnimationMoveListsBarbarianAxe
        .word _List09 - aBattleAnimationMoveListsBarbarianAxe
        .word _List10 - aBattleAnimationMoveListsBarbarianAxe
        .word _List11 - aBattleAnimationMoveListsBarbarianAxe
        .word _List12 - aBattleAnimationMoveListsBarbarianAxe
        .word _List13 - aBattleAnimationMoveListsBarbarianAxe
        .word _List14 - aBattleAnimationMoveListsBarbarianAxe
        .word _List15 - aBattleAnimationMoveListsBarbarianAxe
        .word _List16 - aBattleAnimationMoveListsBarbarianAxe
        .word _List17 - aBattleAnimationMoveListsBarbarianAxe
        .word _List18 - aBattleAnimationMoveListsBarbarianAxe
        .word _List19 - aBattleAnimationMoveListsBarbarianAxe
        .word _List20 - aBattleAnimationMoveListsBarbarianAxe

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 5, 4
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 9, 7
        ANIM_MOVE_ROUTINE 6, 9
        ANIM_MOVE_SCRIPT 7, 5
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_SCRIPT 7, 5
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_SCRIPT 8, 6
        ANIM_MOVE_SCRIPT 7, 5
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_SCRIPT 10, 8
        ANIM_MOVE_SCRIPT 7, 5
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_ROUTINE_ARG 11, 10, $402B
        ANIM_MOVE_SCRIPT 12, 10
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_SCRIPT 10, 8
        ANIM_MOVE_SCRIPT 8, 6
        ANIM_MOVE_SCRIPT 7, 5
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_SCRIPT 10, 8
        ANIM_MOVE_ROUTINE_ARG 11, 10, $4027
        ANIM_MOVE_SCRIPT 14, 11
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_SCRIPT 8, 6
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_SCRIPT 10, 8
        ANIM_MOVE_SCRIPT 8, 6
        ANIM_MOVE_LIST_END

      _List15
        ANIM_MOVE_ROUTINE_ARG 13, 10, $4027
        ANIM_MOVE_SCRIPT 14, 11
        ANIM_MOVE_LIST_END

      _List16
        ANIM_MOVE_ROUTINE_ARG 15, 10, $4027
        ANIM_MOVE_SCRIPT 14, 11
        ANIM_MOVE_LIST_END

      _List17
        ANIM_MOVE_SCRIPT 19, 14
        ANIM_MOVE_ROUTINE 18, 9
        ANIM_MOVE_ROUTINE_ARG 15, 11, $3027
        ANIM_MOVE_LIST_END

      _List18
        ANIM_MOVE_STILL 17
        ANIM_MOVE_LIST_END

      _List19
        ANIM_MOVE_SCRIPT 20, 15
        ANIM_MOVE_LIST_END

      _List20
        ANIM_MOVE_ROUTINE 6, 9
        ANIM_MOVE_SCRIPT 7, 5
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsBarbarianAxe ; 97/E46B

        .word _Script00 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script01 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script02 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script03 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script04 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script05 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script06 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script07 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script08 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script09 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script10 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script11 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script12 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script13 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script14 - aBattleAnimationMoveScriptsBarbarianAxe
        .word _Script15 - aBattleAnimationMoveScriptsBarbarianAxe

      _Script00
        .char 0, 4, -4

      _Script01
        .char 0, 2, 6, 6, 6, 6, -2

      _Script02
        .char 0, 0, 0

      _Script03
        .char -6, -6, -6, -6

      _Script04
        .char 0, 1, -2, 0, -1, 0, 0, 0

      _Script05
        .char -3, -5, 0, -5, 1, -4, 0, -5, 0, 0, 0

      _Script06
        .char 0, 5, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

      _Script07
        .char 0, 0, 0, 0, 0, 0, 0, 0, 0

      _Script08
        .char 0, -3

      _Script09
        .char 0, 0, 0, 0, 0

      _Script10
        .char -3, 0

      _Script11
        .char 0

      _Script12
        .char 0, 0, 0, 0, 0, 0, 0, 0

      _Script13
        .char 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

      _Script14
        .char 0, 0, 0, 0, 0, 0, 0, 0, 0

      _Script15
        .char 0, 0, 0, 0, 0

      aBattleAnimationActionsBarbarianRangedAxe ; 97/E4F0

        ; Move program of entry 40 of aBattleAnimationPrograms, used by: Barbarian (RangedAxe),
        ; Fighter (RangedAxe), Brigand (RangedAxe), Warrior (RangedAxe), Pirate (RangedAxe).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsBarbarianRangedAxe ; 97/E525

        .word _List00 - aBattleAnimationMoveListsBarbarianRangedAxe
        .word _List01 - aBattleAnimationMoveListsBarbarianRangedAxe
        .word _List02 - aBattleAnimationMoveListsBarbarianRangedAxe
        .word _List03 - aBattleAnimationMoveListsBarbarianRangedAxe
        .word _List04 - aBattleAnimationMoveListsBarbarianRangedAxe
        .word _List05 - aBattleAnimationMoveListsBarbarianRangedAxe
        .word _List06 - aBattleAnimationMoveListsBarbarianRangedAxe
        .word _List07 - aBattleAnimationMoveListsBarbarianRangedAxe

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 1
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 3, 2
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 4, 3
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_STILL 5
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 6, 4
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_SCRIPT 7, 4
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsBarbarianRangedAxe ; 97/E54D

        .word _Script00 - aBattleAnimationMoveScriptsBarbarianRangedAxe
        .word _Script01 - aBattleAnimationMoveScriptsBarbarianRangedAxe
        .word _Script02 - aBattleAnimationMoveScriptsBarbarianRangedAxe
        .word _Script03 - aBattleAnimationMoveScriptsBarbarianRangedAxe
        .word _Script04 - aBattleAnimationMoveScriptsBarbarianRangedAxe

      _Script00
        .char 0, 0, 0

      _Script01
        .char 0, 2, 6, 6, 6, 6, -2

      _Script02
        .char 0, 4, -4, 4, -4

      _Script03
        .char 0, 4, -4, 4, -4

      _Script04
        .char 0

      aBattleAnimationActionsWarriorBow ; 97/E56C

        ; Move program of entry 41 of aBattleAnimationPrograms, used by: Warrior (Bow), Hunter
        ; (Bow).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 5
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6

      aBattleAnimationMoveListsWarriorBow ; 97/E59B

        .word _List00 - aBattleAnimationMoveListsWarriorBow
        .word _List01 - aBattleAnimationMoveListsWarriorBow
        .word _List02 - aBattleAnimationMoveListsWarriorBow
        .word _List03 - aBattleAnimationMoveListsWarriorBow
        .word _List04 - aBattleAnimationMoveListsWarriorBow
        .word _List05 - aBattleAnimationMoveListsWarriorBow
        .word _List06 - aBattleAnimationMoveListsWarriorBow
        .word _List07 - aBattleAnimationMoveListsWarriorBow
        .word _List08 - aBattleAnimationMoveListsWarriorBow

      _List00
        ANIM_MOVE_SCRIPT 4, 0
        ANIM_MOVE_SCRIPT 7, 1
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 8, 3
        ANIM_MOVE_SCRIPT 7, 1
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 2
        ANIM_MOVE_STILL 5
        ANIM_MOVE_SCRIPT 7, 1
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_STILL 3
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 19, 4
        ANIM_MOVE_STILL 5
        ANIM_MOVE_SCRIPT 7, 1
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_SCRIPT 6, 2
        ANIM_MOVE_STILL 1
        ANIM_MOVE_SCRIPT 7, 1
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 20, 2
        ANIM_MOVE_STILL 5
        ANIM_MOVE_SCRIPT 7, 1
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_SCRIPT 21, 2
        ANIM_MOVE_STILL 5
        ANIM_MOVE_SCRIPT 7, 1
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_SCRIPT 22, 2
        ANIM_MOVE_STILL 1
        ANIM_MOVE_SCRIPT 7, 1
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsWarriorBow ; 97/E5E4

        .word _Script00 - aBattleAnimationMoveScriptsWarriorBow
        .word _Script01 - aBattleAnimationMoveScriptsWarriorBow
        .word _Script02 - aBattleAnimationMoveScriptsWarriorBow
        .word _Script03 - aBattleAnimationMoveScriptsWarriorBow
        .word _Script04 - aBattleAnimationMoveScriptsWarriorBow

      _Script00
        .char 5, 5, 6, 6, 0

      _Script01
        .char 1

      _Script02
        .char 0, 0, 0, 4, 0

      _Script03
        .char 0, 5

      _Script04
        .char 0, 0, 4, 0, 0

      aBattleAnimationActionsWarMageSword ; 97/E600

        ; Move program of entry 42 of aBattleAnimationPrograms, used by: WarMage (Sword), WarMageF
        ; (Sword).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 17
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_SEQUENCE 23
        ANIM_ACTION_SEQUENCE 23
        ANIM_ACTION_SEQUENCE 23
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 10

      aBattleAnimationMoveListsWarMageSword ; 97/E637

        .word _List00 - aBattleAnimationMoveListsWarMageSword
        .word _List01 - aBattleAnimationMoveListsWarMageSword
        .word _List02 - aBattleAnimationMoveListsWarMageSword
        .word _List03 - aBattleAnimationMoveListsWarMageSword
        .word _List04 - aBattleAnimationMoveListsWarMageSword
        .word _List05 - aBattleAnimationMoveListsWarMageSword
        .word _List06 - aBattleAnimationMoveListsWarMageSword
        .word _List07 - aBattleAnimationMoveListsWarMageSword
        .word _List08 - aBattleAnimationMoveListsWarMageSword
        .word _List09 - aBattleAnimationMoveListsWarMageSword
        .word _List10 - aBattleAnimationMoveListsWarMageSword
        .word _List11 - aBattleAnimationMoveListsWarMageSword
        .word _List12 - aBattleAnimationMoveListsWarMageSword
        .word _List13 - aBattleAnimationMoveListsWarMageSword
        .word _List14 - aBattleAnimationMoveListsWarMageSword
        .word _List15 - aBattleAnimationMoveListsWarMageSword
        .word _List16 - aBattleAnimationMoveListsWarMageSword
        .word _List17 - aBattleAnimationMoveListsWarMageSword
        .word _List18 - aBattleAnimationMoveListsWarMageSword

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 14, 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_STILL 3
        ANIM_MOVE_STILL 4
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_ROUTINE 18, 4
        ANIM_MOVE_STILL 2
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 10, 3
        ANIM_MOVE_ROUTINE 16, 9
        ANIM_MOVE_STILL 4
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_ROUTINE_ARG 15, 12, $1827
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 9, 1
        ANIM_MOVE_SCRIPT 1, 2
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_SCRIPT 19, 3
        ANIM_MOVE_STILL 4
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_ROUTINE_ARG 6, 10, $402C
        ANIM_MOVE_STILL 16
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_ROUTINE 10, 8
        ANIM_MOVE_ROUTINE 18, 4
        ANIM_MOVE_STILL 2
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_SCRIPT 12, 4
        ANIM_MOVE_SCRIPT 11, 5
        ANIM_MOVE_SCRIPT 13, 6
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_STILL 5
        ANIM_MOVE_STILL 2
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_ROUTINE_ARG 14, 12, $1827
        ANIM_MOVE_ROUTINE 16, 9
        ANIM_MOVE_STILL 4
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_STILL 10
        ANIM_MOVE_ROUTINE_ARG 14, 12, $1827
        ANIM_MOVE_ROUTINE 16, 9
        ANIM_MOVE_STILL 4
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_STILL 11
        ANIM_MOVE_ROUTINE_ARG 15, 12, $1827
        ANIM_MOVE_LIST_END

      _List15
        ANIM_MOVE_ROUTINE 20, 9
        ANIM_MOVE_STILL 21
        ANIM_MOVE_ROUTINE_ARG 22, 11, $402B
        ANIM_MOVE_LIST_END

      _List16
        ANIM_MOVE_ROUTINE_ARG 15, 12, $1827
        ANIM_MOVE_ROUTINE 10, 8
        ANIM_MOVE_ROUTINE 18, 4
        ANIM_MOVE_STILL 2
        ANIM_MOVE_LIST_END

      _List17
        ANIM_MOVE_STILL 11
        ANIM_MOVE_ROUTINE_ARG 15, 12, $1827
        ANIM_MOVE_ROUTINE 10, 8
        ANIM_MOVE_ROUTINE 18, 4
        ANIM_MOVE_STILL 2
        ANIM_MOVE_LIST_END

      _List18
        ANIM_MOVE_STILL 24
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsWarMageSword ; 97/E6DC

        .word _Script00 - aBattleAnimationMoveScriptsWarMageSword
        .word _Script01 - aBattleAnimationMoveScriptsWarMageSword
        .word _Script02 - aBattleAnimationMoveScriptsWarMageSword
        .word _Script03 - aBattleAnimationMoveScriptsWarMageSword
        .word _Script04 - aBattleAnimationMoveScriptsWarMageSword
        .word _Script05 - aBattleAnimationMoveScriptsWarMageSword
        .word _Script06 - aBattleAnimationMoveScriptsWarMageSword

      _Script00
        .char 9, 13, 0, 0, 0

      _Script01
        .char 0, 6, 0, 0, 0

      _Script02
        .char 2, 0

      _Script03
        .char 3, 3, 0, -1, 0

      _Script04
        .char 0, 0, 3, 0, 0

      _Script05
        .char 2, 2, 0

      _Script06
        .char 5, 0, 0, 0

      aBattleAnimationActionsBallisticianBow ; 97/E707

        ; Move program of entry 43 of aBattleAnimationPrograms, used by: Ballistician (Bow),
        ; IronBallistician (Bow), KillerBallistician (Bow), GreatBallistician (Bow). Its actions
        ; are all single sequences, so its list and script pointers are never followed; both point
        ; at the next entry's action table.

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_SEQUENCE 2
        ANIM_ACTION_SEQUENCE 2
        ANIM_ACTION_SEQUENCE 2
        ANIM_ACTION_SEQUENCE 2
        ANIM_ACTION_SEQUENCE 2
        ANIM_ACTION_SEQUENCE 2
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1
        ANIM_ACTION_SEQUENCE 1

      aBattleAnimationActionsDarkPrinceMagic ; 97/E735

        ; Move program of entry 44 of aBattleAnimationPrograms, used by: DarkPrince (Magic).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3

      aBattleAnimationMoveListsDarkPrinceMagic ; 97/E745

        .word _List00 - aBattleAnimationMoveListsDarkPrinceMagic
        .word _List01 - aBattleAnimationMoveListsDarkPrinceMagic
        .word _List02 - aBattleAnimationMoveListsDarkPrinceMagic
        .word _List03 - aBattleAnimationMoveListsDarkPrinceMagic
        .word _List04 - aBattleAnimationMoveListsDarkPrinceMagic

      _List00
        ANIM_MOVE_ROUTINE 1, 3
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 5, 3
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_STILL 2
        ANIM_MOVE_SCRIPT 4, 0
        ANIM_MOVE_SCRIPT 7, 1
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_STILL 3
        ANIM_MOVE_SCRIPT 6, 2
        ANIM_MOVE_SCRIPT 8, 4
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 9, 5
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsDarkPrinceMagic ; 97/E766

        .word _Script00 - aBattleAnimationMoveScriptsDarkPrinceMagic
        .word _Script01 - aBattleAnimationMoveScriptsDarkPrinceMagic
        .word _Script02 - aBattleAnimationMoveScriptsDarkPrinceMagic
        .word _Script03 - aBattleAnimationMoveScriptsDarkPrinceMagic
        .word _Script04 - aBattleAnimationMoveScriptsDarkPrinceMagic
        .word _Script05 - aBattleAnimationMoveScriptsDarkPrinceMagic

      _Script00
        .char 1, 0, 0

      _Script01
        .char 0, -1

      _Script02
        .char 0, 1, 0

      _Script03
        .char 0, 5, 5, 4, 4, 4, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1
        .char 1, 1, 1

      _Script04
        .char 0, -1, 0

      _Script05
        .char 0, 2, -4, 6, -8, 10, -12, 14, -16, 18, -20, 20, -20, 20, -18, 16
        .char -14, 12, -10, 8, -4, 0

      aBattleAnimationActionsDancerDance ; 97/E7A6

        ; Move program of entry 45 of aBattleAnimationPrograms, used by: Dancer (dancing).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 0
        ANIM_ACTION_LIST 0

      aBattleAnimationMoveListsDancerDance ; 97/E7AB

        .word _List00 - aBattleAnimationMoveListsDancerDance
        .word _List01 - aBattleAnimationMoveListsDancerDance
        .word _List02 - aBattleAnimationMoveListsDancerDance
        .word _List03 - aBattleAnimationMoveListsDancerDance
        .word _List04 - aBattleAnimationMoveListsDancerDance

      _List00
        ANIM_MOVE_STILL 0
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 1, 1
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_SCRIPT 2, 2
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_SCRIPT 3, 3
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 4, 4
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsDancerDance ; 97/E7C4

        .word _Script00 - aBattleAnimationMoveScriptsDancerDance
        .word _Script01 - aBattleAnimationMoveScriptsDancerDance
        .word _Script02 - aBattleAnimationMoveScriptsDancerDance
        .word _Script03 - aBattleAnimationMoveScriptsDancerDance
        .word _Script04 - aBattleAnimationMoveScriptsDancerDance

      _Script00
        .char 0

      _Script01
        .char 0, 0, 0, 4, 1, -3, 4, -3, 4, 2, 0, 0, 0, 0, 0, 0
        .char 5, 0, -4, 0, 0, 0

      _Script02
        .char 0, 0, 4, 1, -3, 4, -3, 4, 0

      _Script03
        .char 4, 2, 0, 0, 0, 0, 0, 0

      _Script04
        .char 0, 0, 5, 0, -4, 0, 0, 0

      aBattleAnimationActionsJuniorLordSword ; 97/E7FE

        ; Move program of entry 46 of aBattleAnimationPrograms, used by: JuniorLord (Sword),
        ; Prince (Sword), Princess (Sword).

        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 1
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 6
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 9
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 3
        ANIM_ACTION_LIST 11
        ANIM_ACTION_LIST 2
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 16
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 15
        ANIM_ACTION_LIST 4
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 7
        ANIM_ACTION_LIST 13
        ANIM_ACTION_LIST 13
        ANIM_ACTION_SEQUENCE 0
        ANIM_ACTION_SEQUENCE 18
        ANIM_ACTION_SEQUENCE 18
        ANIM_ACTION_SEQUENCE 18
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 10
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 8
        ANIM_ACTION_LIST 12
        ANIM_ACTION_LIST 8

      aBattleAnimationMoveListsJuniorLordSword ; 97/E835

        .word _List00 - aBattleAnimationMoveListsJuniorLordSword
        .word _List01 - aBattleAnimationMoveListsJuniorLordSword
        .word _List02 - aBattleAnimationMoveListsJuniorLordSword
        .word _List03 - aBattleAnimationMoveListsJuniorLordSword
        .word _List04 - aBattleAnimationMoveListsJuniorLordSword
        .word _List05 - aBattleAnimationMoveListsJuniorLordSword
        .word _List06 - aBattleAnimationMoveListsJuniorLordSword
        .word _List07 - aBattleAnimationMoveListsJuniorLordSword
        .word _List08 - aBattleAnimationMoveListsJuniorLordSword
        .word _List09 - aBattleAnimationMoveListsJuniorLordSword
        .word _List10 - aBattleAnimationMoveListsJuniorLordSword
        .word _List11 - aBattleAnimationMoveListsJuniorLordSword
        .word _List12 - aBattleAnimationMoveListsJuniorLordSword
        .word _List13 - aBattleAnimationMoveListsJuniorLordSword
        .word _List14 - aBattleAnimationMoveListsJuniorLordSword
        .word _List15 - aBattleAnimationMoveListsJuniorLordSword
        .word _List16 - aBattleAnimationMoveListsJuniorLordSword
        .word _List17 - aBattleAnimationMoveListsJuniorLordSword

      _List00
        ANIM_MOVE_STILL 7
        ANIM_MOVE_LIST_END

      _List01
        ANIM_MOVE_SCRIPT 13, 0
        ANIM_MOVE_LIST_END

      _List02
        ANIM_MOVE_STILL 3
        ANIM_MOVE_STILL 4
        ANIM_MOVE_LIST_END

      _List03
        ANIM_MOVE_STILL 17
        ANIM_MOVE_STILL 2
        ANIM_MOVE_LIST_END

      _List04
        ANIM_MOVE_SCRIPT 10, 6
        ANIM_MOVE_ROUTINE 16, 9
        ANIM_MOVE_STILL 4
        ANIM_MOVE_LIST_END

      _List05
        ANIM_MOVE_STILL 14
        ANIM_MOVE_LIST_END

      _List06
        ANIM_MOVE_SCRIPT 8, 5
        ANIM_MOVE_LIST_END

      _List07
        ANIM_MOVE_SCRIPT 22, 4
        ANIM_MOVE_STILL 4
        ANIM_MOVE_LIST_END

      _List08
        ANIM_MOVE_ROUTINE_ARG 6, 10, $402C
        ANIM_MOVE_STILL 15
        ANIM_MOVE_LIST_END

      _List09
        ANIM_MOVE_ROUTINE 9, 8
        ANIM_MOVE_ROUTINE 17, 4
        ANIM_MOVE_STILL 2
        ANIM_MOVE_LIST_END

      _List10
        ANIM_MOVE_SCRIPT 11, 1
        ANIM_MOVE_SCRIPT 10, 2
        ANIM_MOVE_SCRIPT 12, 3
        ANIM_MOVE_LIST_END

      _List11
        ANIM_MOVE_STILL 5
        ANIM_MOVE_STILL 2
        ANIM_MOVE_LIST_END

      _List12
        ANIM_MOVE_ROUTINE_ARG 14, 12, $1827
        ANIM_MOVE_ROUTINE 16, 9
        ANIM_MOVE_STILL 4
        ANIM_MOVE_LIST_END

      _List13
        ANIM_MOVE_STILL 10
        ANIM_MOVE_ROUTINE_ARG 14, 12, $1827
        ANIM_MOVE_ROUTINE 16, 9
        ANIM_MOVE_STILL 4
        ANIM_MOVE_LIST_END

      _List14
        ANIM_MOVE_STILL 10
        ANIM_MOVE_ROUTINE_ARG 14, 12, $1827
        ANIM_MOVE_LIST_END

      _List15
        ANIM_MOVE_ROUTINE 19, 9
        ANIM_MOVE_STILL 20
        ANIM_MOVE_ROUTINE_ARG 21, 11, $402B
        ANIM_MOVE_LIST_END

      _List16
        ANIM_MOVE_ROUTINE_ARG 14, 12, $1827
        ANIM_MOVE_ROUTINE_ARG 6, 10, $402C
        ANIM_MOVE_STILL 15
        ANIM_MOVE_LIST_END

      _List17
        ANIM_MOVE_STILL 10
        ANIM_MOVE_ROUTINE_ARG 14, 12, $1827
        ANIM_MOVE_ROUTINE_ARG 6, 10, $402C
        ANIM_MOVE_STILL 15
        ANIM_MOVE_LIST_END

      aBattleAnimationMoveScriptsJuniorLordSword ; 97/E8D1

        .word _Script00 - aBattleAnimationMoveScriptsJuniorLordSword
        .word _Script01 - aBattleAnimationMoveScriptsJuniorLordSword
        .word _Script02 - aBattleAnimationMoveScriptsJuniorLordSword
        .word _Script03 - aBattleAnimationMoveScriptsJuniorLordSword
        .word _Script04 - aBattleAnimationMoveScriptsJuniorLordSword
        .word _Script05 - aBattleAnimationMoveScriptsJuniorLordSword
        .word _Script06 - aBattleAnimationMoveScriptsJuniorLordSword

      _Script00
        .char 9, 13, 0, 0

      _Script01
        .char 0, 0, 3, 0, -3

      _Script02
        .char 0, 0, 0

      _Script03
        .char 0, -1, 0

      _Script04
        .char 3, 3, 0, -1, 0

      _Script05
        .char 0, 6, 0, 0, 3

      _Script06
        .char 3, 3, -1

    .endsection BattleAnimationMoveDataSection
