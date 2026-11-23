; Battle animation move routines: a move list step whose movement is below $7D
; runs one of these, through aBattleAnimationMoveRoutines
; (rlBattleAnimationStartMovement), and the path routines they use.
;
; Each combatant (X = 0 or $43) has a position in 8.8 pixels: X at $0AF8 (the
; whole pixels at $0AF9, 9 bits), Y at $0AFD (whole pixels at $0AFE; the ground
; is $58). A move sets some of:
;   $0B00   target X ($0AFF its fraction)
;   $0B08   X speed, 8.8 pixels a frame, bit 15 leftward ($0B0C keeps the start)
;   $0B0A   X deceleration a frame ($FFFF: halve the speed each frame)
;   $0B0E   vertical velocity, $0B10 gravity (rlBattleAnimationGetJumpArc)
;   $0B04   target Y, $0B13 Y step a frame
; and each frame rlBattleAnimationUpdateX, rlBattleAnimationApplyDefaultGravity,
; rlBattleAnimationUpdateJump and rlBattleAnimationUpdateYStep apply them.
; Distances and speeds come from the combatant's body record (the table at
; $97/EA9A: width, spacing, speeds A and B).

    .section BattleAnimationMoves95B250Section

      .al
      .xl

      rsBattleAnimationMoveJumpPastOpponent ; 95/B250

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 0. Pops an argument word (low byte frames, high byte height):
        ; goes past the opponent in that many frames
        ; (rlBattleAnimationSetPathPastOpponentInFrames) with a jump arc of that
        ; height (rlBattleAnimationGetJumpArc).

        tax
        cpx #$0000
        bne _B259
        clc
        bra _B25A


        _B259
        sec

        _B25A
        jsl rlBattleAnimationTakeQueuedMove
        pha
        and #$00FF
        clc
        jsl rlBattleAnimationSetPathPastOpponentInFrames
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$08
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        ora #$08
        sta bBattleAnimationFacingFlags,b,x
        rep #$20
        pla
        xba
        and #$00FF
        jsl rlBattleAnimationGetJumpArc
        lda wR1
        sta wBattleAnimationYVelocity,b,x
        lda wR0
        sta wBattleAnimationGravity,b,x
        rts

        .databank 0

        ; 95/B28F

      rsBattleAnimationMoveHopToOpponent ; 95/B28F

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 1, not used in the move lists: goes up to the opponent at speed B
        ; (rsBattleAnimationSetPathToOpponent) with a jump arc of height 4.

        tax
        sec
        jsr rsBattleAnimationSetPathToOpponent
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$08
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        lda #$0004
        jsl rlBattleAnimationGetJumpArc
        lda wR1
        sta wBattleAnimationYVelocity,b,x
        lda wR0
        sta wBattleAnimationGravity,b,x
        rts

        .databank 0

        ; 95/B2B2

      rsBattleAnimationMoveLeapToOpponent ; 95/B2B2

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 2, not used in the move lists: goes up to the opponent at speed B
        ; in half the time (rsBattleAnimationSetPathToOpponentHalfTime) with a
        ; jump arc of height 8.

        tax
        sec
        jsr rsBattleAnimationSetPathToOpponentHalfTime
        sec
        jsl rlBattleAnimationGetTravelFrames
        lda wR0
        lsr a
        sta wR0
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$08
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        lda #$0008
        jsl rlBattleAnimationGetJumpArc
        lda wR1
        sta wBattleAnimationYVelocity,b,x
        lda wR0
        sta wBattleAnimationGravity,b,x
        rts

        .databank 0

        ; 95/B2DF

    .endsection BattleAnimationMoves95B250Section


    .section BattleAnimationMoves95B332Section

      .al
      .xl

      rsBattleAnimationMoveGlideToOpponent ; 95/B332

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 6: goes up to the opponent in X (at least 8 frames,
        ; rsBattleAnimationSetPathToOpponentAtLeast8Frames) and to the
        ; opponent's height in Y (rsBattleAnimationSetYPathToOpponent); sets bit
        ; 4 of $0AF3 (the Y move, rlBattleAnimationUpdateYStep) and clears bit
        ; 5.

        phx
        tax
        sec
        jsr rsBattleAnimationSetPathToOpponentAtLeast8Frames
        sec
        jsr rsBattleAnimationSetYPathToOpponent
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$10
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationStateFlags,b,x
        and #$DF
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        plx
        rts

        .databank 0

        ; 95/B352

      rsBattleAnimationMoveNoDefaultGravity ; 95/B352

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 7: sets bit 5 of $0AF3, which keeps
        ; rlBattleAnimationApplyDefaultGravity from giving the combatant gravity
        ; in the air (it is also tested when the move queue advances).

        phx
        tax
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$20
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        plx
        rts

        .databank 0

        ; 95/B362

    .endsection BattleAnimationMoves95B332Section


    .section BattleAnimationMoves95B3AFSection

      .al
      .xl

      rsBattleAnimationMoveJumpInPlace ; 95/B3AF

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 11. Pops an argument word (frames, height): a jump arc of that
        ; height over that many frames, without moving in X.

        tax
        cpx #$0000
        bne _B3B8
        clc
        bra _B3B9


        _B3B8
        sec

        _B3B9
        jsl rlBattleAnimationTakeQueuedMove
        pha
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$08
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        ora #$08
        sta bBattleAnimationFacingFlags,b,x
        rep #$20
        lda #1,s
        and #$00FF
        sta wR0
        pla
        xba
        and #$00FF
        jsl rlBattleAnimationGetJumpArc
        lda wR1
        sta wBattleAnimationYVelocity,b,x
        lda wR0
        sta wBattleAnimationGravity,b,x
        rts

        .databank 0

        ; 95/B3ED

      rsBattleAnimationMoveJumpTo40 ; 95/B3ED

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 12. Pops an argument word (frames, height): goes to 40 pixels
        ; from the opponent in that many frames
        ; (rsBattleAnimationSetPathNearOpponent) with a jump arc of that height.

        tax
        cpx #$0000
        bne _B3F6
        clc
        bra _B3F7


        _B3F6
        sec

        _B3F7
        jsl rlBattleAnimationTakeQueuedMove
        pha
        and #$00FF
        pha
        lda #$0028
        sta wR8
        pla
        jsr rsBattleAnimationSetPathNearOpponent
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$08
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        ora #$08
        sta bBattleAnimationFacingFlags,b,x
        rep #$20
        pla
        xba
        and #$00FF
        jsl rlBattleAnimationGetJumpArc
        lda wR1
        sta wBattleAnimationYVelocity,b,x
        lda wR0
        sta wBattleAnimationGravity,b,x
        rts

        .databank 0

        ; 95/B431

      rsBattleAnimationMoveJumpTo80 ; 95/B431

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 13: as move 12, to 80 pixels from the opponent.

        tax
        cpx #$0000
        bne _B43A
        clc
        bra _B43B


        _B43A
        sec

        _B43B
        jsl rlBattleAnimationTakeQueuedMove
        pha
        and #$00FF
        pha
        lda #$0050
        sta wR8
        pla
        jsr rsBattleAnimationSetPathNearOpponent
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$08
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        ora #$08
        sta bBattleAnimationFacingFlags,b,x
        rep #$20
        pla
        xba
        and #$00FF
        jsl rlBattleAnimationGetJumpArc
        lda wR1
        sta wBattleAnimationYVelocity,b,x
        lda wR0
        sta wBattleAnimationGravity,b,x
        rts

        .databank 0

        ; 95/B475

    .endsection BattleAnimationMoves95B3AFSection


    .section BattleAnimationMoves95B48DSection

      .al
      .xl

      rsBattleAnimationMoveJumpTo16 ; 95/B48D

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 15. Pops an argument word (frames, height): goes to 16 pixels
        ; from the opponent in that many frames with a jump arc of that height
        ; over twice as many; sets bit 7 of $0AF5 and clears bit 5 of $0AF3.

        tax
        cpx #$0000
        bne _B496
        clc
        bra _B497


        _B496
        sec

        _B497
        jsl rlBattleAnimationTakeQueuedMove
        pha
        and #$00FF
        pha
        lda #$0010
        sta wR8
        pla
        jsr rsBattleAnimationSetPathNearOpponent
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$08
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationCombatantFlags,b,x
        ora #$80
        sta bBattleAnimationCombatantFlags,b,x
        lda bBattleAnimationStateFlags,b,x
        and #$DF
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        pla
        xba
        and #$00FF
        pha
        lda wR0
        asl a
        sta wR0
        pla
        jsl rlBattleAnimationGetJumpArc
        lda wR1
        sta wBattleAnimationYVelocity,b,x
        lda wR0
        sta wBattleAnimationGravity,b,x
        rts

        .databank 0

        ; 95/B4E0

      rsBattleAnimationMoveLaunchAwayFromAttacker ; 95/B4E0

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 16: free X motion (bit 0 of $0AF6, rlBattleAnimationUpdateX) at 8
        ; pixels a frame away from the attacker ($0AE9), Y velocity 6, and sets
        ; bit 0 of $7FF5AF.

        tax
        sep #$20
        lda bBattleAnimationMotionFlags,b,x
        ora #$01
        sta bBattleAnimationMotionFlags,b,x
        lda $7FF5AF
        ora #$01
        sta $7FF5AF
        rep #$20
        phx
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationX,b,x
        ldx wBattleAnimationDefenderOffset,b
        cmp wBattleAnimationX,b,x
        plx
        bcs _B50C
        lda #$0800
        bra _B50F


        _B50C
        lda #$8800

        _B50F
        sta wBattleAnimationXSpeed,b,x
        lda #$0600
        sta wBattleAnimationYVelocity,b,x
        rts

        .databank 0

        ; 95/B519

      rsBattleAnimationMoveDrift ; 95/B519

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 17, not used in the move lists: free X motion at 6 pixels a frame
        ; to the right.

        tax
        sep #$20
        lda bBattleAnimationMotionFlags,b,x
        ora #$01
        sta bBattleAnimationMotionFlags,b,x
        rep #$20
        stz wBattleAnimationXSpeed,b,x
        lda #$0600
        sta wBattleAnimationXSpeed,b,x
        rts

        .databank 0

        ; 95/B530

    .endsection BattleAnimationMoves95B48DSection


    .section BattleAnimationMoves95CF2ESection

      .al
      .xl

      rsBattleAnimationSetPathToOpponentHalfTime ; 95/CF2E

        .al
        .xl
        .autsiz
        .databank ?

        ; As rsBattleAnimationSetPathToOpponent, in half the frames.

        phx
        php
        jsl rlBattleAnimationGetPathMeasures
        lda wR0
        cmp wR1
        bcc _CF42
        sec
        sbc wR8
        sec
        sbc wR7
        bra _CF48


        _CF42
        clc
        adc wR8
        clc
        adc wR7

        _CF48
        sta wR0
        lda wR1
        sec
        sbc wR0
        bpl _CF5D
        eor #$FFFF
        inc a
        lsr a
        sta wR2
        lda #$8000
        bra _CF63


        _CF5D
        lsr a
        sta wR2
        lda #$0000

        _CF63
        sta wR3
        lda wR2
        sta wR4
        plp
        jsl rlBattleAnimationGetTravelFrames
        lsr a
        sta wR0
        lda wR2
        jsl rlBattleAnimationGetSpeed
        ora wR3
        sta wBattleAnimationXSpeed,b,x
        sta wBattleAnimationXStartSpeed,b,x
        lda wR3
        bmi _CF8B
        lda wBattleAnimationX,b,x
        clc
        adc wR2
        bra _CF91


        _CF8B
        lda wBattleAnimationX,b,x
        sec
        sbc wR2

        _CF91
        pha
        lda wBattleAnimationXFixed,b,x
        sta wBattleAnimationTargetXFixed,b,x
        pla
        sta wBattleAnimationTargetX,b,x
        lda wR4
        plx
        rts

        .databank 0

        ; 95/CFA0

    .endsection BattleAnimationMoves95CF2ESection


    .section BattleAnimationMoves95D007Section

      .al
      .xl

      rsBattleAnimationSetPathNearOpponent ; 95/D007

        .al
        .xl
        .autsiz
        .databank ?

        ; To wR8 pixels from the opponent, on the combatant's side, in A frames.

        phx
        pha
        lda wBattleAnimationX,b,x
        sta wR0
        cpx #$0000
        beq _D018
        lda wBattleAnimationX,b
        bra _D01B


        _D018
        lda wBattleAnimation2X,b

        _D01B
        sta wR1
        lda wR0
        cmp wR1
        bcc _D028
        clc
        adc wR8
        bra _D02B


        _D028
        sec
        sbc wR8

        _D02B
        sta wR1
        lda wR1
        sec
        sbc wR0
        bpl _D03F
        eor #$FFFF
        inc a
        sta wR2
        lda #$8000
        bra _D044


        _D03F
        sta wR2
        lda #$0000

        _D044
        sta wR3
        pla
        sta wR0
        lda wR2
        jsl rlBattleAnimationGetSpeed
        ora wR3
        sta wBattleAnimationXSpeed,b,x
        sta wBattleAnimationXStartSpeed,b,x
        lda wR3
        bmi _D063
        lda wBattleAnimationX,b,x
        clc
        adc wR2
        bra _D069


        _D063
        lda wBattleAnimationX,b,x
        sec
        sbc wR2

        _D069
        pha
        lda wBattleAnimationXFixed,b,x
        sta wBattleAnimationTargetXFixed,b,x
        pla
        sta wBattleAnimationTargetX,b,x
        lda wR4
        plx
        rts

        .databank 0

        ; 95/D078

    .endsection BattleAnimationMoves95D007Section


    .section BattleAnimationMoves95D0E7Section

      .al
      .xl

      rlBattleAnimationSetPathPastOpponentInFrames ; 95/D0E7

        .al
        .xl
        .autsiz
        .databank ?

        ; As rlBattleAnimationSetPathPastOpponent, in A frames.

        phx
        pha
        jsl rlBattleAnimationGetPathMeasures
        lda wR1
        cmp wR0
        bcs _D0FB
        sec
        sbc wR8
        sec
        sbc wR7
        bra _D101


        _D0FB
        clc
        adc wR8
        clc
        adc wR7

        _D101
        sta wR1
        lda wR1
        sec
        sbc wR0
        bpl _D115
        eor #$FFFF
        inc a
        sta wR2
        lda #$8000
        bra _D11A


        _D115
        sta wR2
        lda #$0000

        _D11A
        sta wR3
        pla
        sta wR0
        lda wR2
        jsl rlBattleAnimationGetSpeed
        ora wR3
        sta wBattleAnimationXSpeed,b,x
        sta wBattleAnimationXStartSpeed,b,x
        lda wR3
        bmi _D139
        lda wBattleAnimationX,b,x
        clc
        adc wR2
        bra _D13F


        _D139
        lda wBattleAnimationX,b,x
        sec
        sbc wR2

        _D13F
        pha
        lda wBattleAnimationXFixed,b,x
        sta wBattleAnimationTargetXFixed,b,x
        pla
        sta wBattleAnimationTargetX,b,x
        lda wR4
        plx
        rtl

        .databank 0

        ; 95/D14E
      rsBattleAnimationSetPathToOpponentAtLeast8Frames ; 95/D14E

        .al
        .xl
        .autsiz
        .databank ?

        ; As rsBattleAnimationSetPathToOpponent, taking at least 8 frames.

        phx
        php
        jsl rlBattleAnimationGetPathMeasures
        lda wR0
        cmp wR1
        bcc _D162
        sec
        sbc wR8
        sec
        sbc wR7
        bra _D168


        _D162
        clc
        adc wR8
        clc
        adc wR7

        _D168
        sta wR0
        lda wR1
        sec
        sbc wR0
        bpl _D17C
        eor #$FFFF
        inc a
        sta wR2
        lda #$8000
        bra _D181


        _D17C
        sta wR2
        lda #$0000

        _D181
        sta wR3
        lda wR2
        sta wR4
        plp
        jsl rlBattleAnimationGetTravelFrames
        cmp #$0008
        bcs _D194
        lda #$0008

        _D194
        sta wR0
        lda wR2
        jsl rlBattleAnimationGetSpeed
        ora wR3
        sta wBattleAnimationXSpeed,b,x
        sta wBattleAnimationXStartSpeed,b,x
        lda wR3
        bmi _D1B0
        lda wBattleAnimationX,b,x
        clc
        adc wR2
        bra _D1B6


        _D1B0
        lda wBattleAnimationX,b,x
        sec
        sbc wR2

        _D1B6
        pha
        lda wBattleAnimationXFixed,b,x
        sta wBattleAnimationTargetXFixed,b,x
        pla
        sta wBattleAnimationTargetX,b,x
        lda wR4
        plx
        rts

        .databank 0

        ; 95/D1C5

    .endsection BattleAnimationMoves95D0E7Section


    .section BattleAnimationMoves95D23CSection

      .al
      .xl

      rsBattleAnimationSetYPathToOpponent ; 95/D23C

        .al
        .xl
        .autsiz
        .databank ?

        ; Y to the opponent's Y ($0B04), by $0B13 a frame, over the frames for
        ; distance A at speed B (carry set) or A, at least 8.

        jsl rlBattleAnimationGetTravelFrames
        cmp #$0008
        bcs _D248
        lda #$0008

        _D248
        pha
        phx
        ldx wBattleAnimationDefenderOffset,b
        lda bBattleAnimationY,b,x
        and #$00FF
        sta wR1
        ldx wBattleAnimationAttackerOffset,b
        lda bBattleAnimationY,b,x
        and #$00FF
        sta wR0
        plx
        lda wR1
        sec
        sbc wR0
        bpl _D26C
        eor #$FFFF
        inc a

        _D26C
        sta wR2
        pla
        sta wR0
        lda wR2
        jsl rlBattleAnimationGetSpeed
        sta wBattleAnimationYStep,b,x
        lda wR1
        sta wBattleAnimationTargetY,b,x
        rts

        .databank 0

        ; 95/D280

    .endsection BattleAnimationMoves95D23CSection


    .section Unreferenced95D280Section

      .al
      .xl

      rsUnknown95D280 ; 95/D280

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $0B06,b,x
        and #$00FF
        sta wR0
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$08
        sta bBattleAnimationStateFlags,b,x
        jsr rsBattleAnimationGetBodyByte5
        jsl rlBattleAnimationGetJumpArc
        lda wR1
        sta wBattleAnimationYVelocity,b,x
        lda wR0
        sta wBattleAnimationGravity,b,x
        rts

        .databank 0

        ; 95/D2A4

    .endsection Unreferenced95D280Section
    .section BattleAnimationMoves95B2DFSection

      .al
      .xl

      rsBattleAnimationMoveAdvance80 ; 95/B2DF

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 3: advances toward the opponent by up to 80 pixels
        ; (rsBattleAnimationSetAdvance).

        tax
        lda #$0050
        sta wR0
        jsr rsBattleAnimationSetAdvance
        rts

        .databank 0

        ; 95/B2E9

      rsBattleAnimationMoveCoastLinear ; 95/B2E9

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 4: goes on at the start speed of the last X move ($0B0C), in its
        ; direction, toward the stage edge (X $198 or $68), slowing by an eighth
        ; of that speed each frame (rsBattleAnimationApplyXDeceleration).

        tax
        lda wBattleAnimationXStartSpeed,b,x
        and #$8000
        pha
        lda wBattleAnimationXStartSpeed,b,x
        and #$7FFF
        lsr a
        lsr a
        lsr a
        ora #1,s
        sta wBattleAnimationXDeceleration,b,x
        pla
        bmi _B307
        lda #$0198
        bra _B30A


        _B307
        lda #$0068

        _B30A
        sta wBattleAnimationTargetX,b,x
        lda wBattleAnimationXStartSpeed,b,x
        sta wBattleAnimationXSpeed,b,x
        rts

        .databank 0

        ; 95/B314

      rsBattleAnimationMoveCoastHalving ; 95/B314

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 5: as move 4, but the speed halves each frame ($0B0A = $FFFF).

        tax
        lda #$FFFF
        sta wBattleAnimationXDeceleration,b,x
        lda wBattleAnimationXStartSpeed,b,x
        bmi _B325
        lda #$0198
        bra _B328


        _B325
        lda #$0068

        _B328
        sta wBattleAnimationTargetX,b,x
        lda wBattleAnimationXStartSpeed,b,x
        sta wBattleAnimationXSpeed,b,x
        rts

        .databank 0

        ; 95/B332

    .endsection BattleAnimationMoves95B2DFSection


    .section BattleAnimationMoves95B362Section

      .al
      .xl

      rsBattleAnimationMoveToOpponentSpeedA ; 95/B362

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 8: goes up to the opponent at speed A
        ; (rsBattleAnimationSetPathToOpponent).

        phx
        tax
        clc
        jsr rsBattleAnimationSetPathToOpponent
        plx
        rts

        .databank 0

        ; 95/B36A

      rsBattleAnimationMoveToOpponentSpeedB ; 95/B36A

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 9: goes up to the opponent at speed B.

        phx
        tax
        sec
        jsr rsBattleAnimationSetPathToOpponent
        plx
        rts

        .databank 0

        ; 95/B372

      rsBattleAnimationMoveJumpToOpponent ; 95/B372

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 10. Pops an argument word (frames, height): goes up to the
        ; opponent in that many frames
        ; (rsBattleAnimationSetPathToOpponentInFrames) with a jump arc of that
        ; height.

        tax
        cpx #$0000
        bne _B37B
        clc
        bra _B37C


        _B37B
        sec

        _B37C
        jsl rlBattleAnimationTakeQueuedMove
        pha
        and #$00FF
        jsr rsBattleAnimationSetPathToOpponentInFrames
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$08
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        ora #$08
        sta bBattleAnimationFacingFlags,b,x
        rep #$20
        pla
        xba
        and #$00FF
        jsl rlBattleAnimationGetJumpArc
        lda wR1
        sta wBattleAnimationYVelocity,b,x
        lda wR0
        sta wBattleAnimationGravity,b,x
        rts

        .databank 0

        ; 95/B3AF

    .endsection BattleAnimationMoves95B362Section


    .section BattleAnimationMoves95B475Section

      .al
      .xl

      rsBattleAnimationMoveAdvancePastOpponent ; 95/B475

        .al
        .xl
        .autsiz
        .databank ?

        ; Move 14: measures the distance to the far side of the opponent at
        ; speed B (rlBattleAnimationSetPathPastOpponent) and advances by it
        ; (rsBattleAnimationSetAdvance), keeping 8 pixels a frame in that
        ; direction as the start speed for a coast (moves 4 and 5).

        tax
        sec
        jsl rlBattleAnimationSetPathPastOpponent
        sta wR0
        jsr rsBattleAnimationSetAdvance
        lda wBattleAnimationXStartSpeed,b,x
        and #$8000
        ora #$0800
        sta wBattleAnimationXStartSpeed,b,x
        rts

        .databank 0

        ; 95/B48D

    .endsection BattleAnimationMoves95B475Section


