; The combatants on the battle scene's stage (battle animation slots: two
; combatants at $0AF3 and $0B36 and two effect slots after them): their
; sequences and frames (rsBattleAnimationRunScript, rlBattleAnimationDrawSlot),
; the action and move queues (rlBattleAnimationQueueAction), movement against
; each other and the stage edges, the camera, gravity and jumps, facing, the
; knockback, the effect slots' flight (rlBattleAnimationMoveEffectSlot),
; afterimages and shadows, the release signals between the combatants, and the
; VBlank upload queue. The move routines are in animation_moves.asm. The effect
; slots' spawn fields ($0C03-$0C30) are still unverified.


    .section Unsorted95B184Section

      .al
      .xl

      rlBattleAnimationCompareCombatantX ; 95/B184

        .al
        .xl
        .autsiz
        .databank ?

        ; Compares the first combatant's X with the second's: carry set if it is
        ; to the right; A 0 (zero flag set) if level, else 1.

        lda wBattleAnimationX,b
        cmp wBattleAnimation2X,b
        beq _B190
        bcc _B1A6
        bcs _B1A0

        _B190
        lda wBattleAnimationXFixed,b
        cmp wBattleAnimation2XFixed,b
        bcc _B1A6
        bne _B1A0
        lda #$0000
        clc
        bra _B1AA


        _B1A0
        sec
        lda #$0001
        bra _B1AA


        _B1A6
        clc
        lda #$0001

        _B1AA
        rtl

        .databank 0

        ; 95/B1AB

      rlBattleAnimationStartMovement ; 95/B1AB

        .al
        .xl
        .autsiz
        .databank ?

        ; Starts the movement in the low byte of A: a move routine
        ; (aBattleAnimationMoveRoutines), none ($7D, $7E), or a movement script
        ; (bit 7; bit 15 switches it on, bit 14 sets bit 2 of $0AF4).

        phx
        phy
        bit #$0080
        bne _B1EF
        pha
        and #$007F
        cmp #$007E
        beq _B1C0
        cmp #$007D
        bne _B1C3

        _B1C0
        pla
        bra _B1D9


        _B1C3
        pla
        and #$007F
        phx
        phx
        asl a
        tax
        lda aBattleAnimationMoveRoutines,x
        sta wR0
        pla
        ldx #$0000
        jsr (((`*) << 16) | wR0,x) ; wR0 is the routine: X is 0, and $0000 in this bank is RAM
        plx

        _B1D9
        sep #$20
        lda bBattleAnimationFacingFlags,b,x
        and #$FE
        sta bBattleAnimationFacingFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        and #$FD
        sta bBattleAnimationFacingFlags,b,x
        rep #$20
        bra _B24D


        _B1EF
        pha
        sep #$20
        lda bBattleAnimationFacingFlags,b,x
        ora #$01
        sta bBattleAnimationFacingFlags,b,x
        rep #$20
        pla
        pha
        bit #$8000
        beq _B20F
        sep #$20
        lda bBattleAnimationFacingFlags,b,x
        ora #$02
        sta bBattleAnimationFacingFlags,b,x
        rep #$20

        _B20F
        pla
        pha
        bit #$4000
        beq _B222
        sep #$20
        lda bBattleAnimationFacingFlags,b,x
        ora #$04
        sta bBattleAnimationFacingFlags,b,x
        rep #$20

        _B222
        pla
        pha
        and #$007F
        pha
        lda bBattleAnimationFacingFlags,b,x
        and #$0006
        cmp #$0006
        pla
        asl a
        pha
        pla
        tay
        lda lBattleAnimationMoveListPointer,b,x
        sta lR18
        lda lBattleAnimationMoveListPointer+1,b,x
        sta lR18+1
        lda [lR18],y
        clc
        adc lBattleAnimationMoveListPointer,b,x
        sta wBattleAnimationMoveListLoopOffset,b,x
        sta wBattleAnimationMoveListOffset,b,x
        pla

        _B24D
        ply
        plx
        rtl

        .databank 0

        ; 95/B250

    .endsection Unsorted95B184Section


    .section Unsorted95B530Section

      .al
      .xl

      rlBattleAnimationGetTravelFrames ; 95/B530

        .al
        .xl
        .autsiz
        .databank ?

        ; Frames to travel A pixels: A * 8 / speed (rsBattleAnimationGetSpeedB
        ; with carry set, else rsBattleAnimationGetSpeedA), at least 1.

        phx
        pha
        bcs _B539
        jsr rsBattleAnimationGetSpeedA
        bra _B53C


        _B539
        jsr rsBattleAnimationGetSpeedB

        _B53C
        sta wR14
        pla
        and #$01FF
        asl a
        asl a
        asl a
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        bne _B552
        lda #$0001

        _B552
        plx
        rtl

        .databank 0

        ; 95/B554

    .endsection Unsorted95B530Section


    .section Unsorted95B554Section

      .al
      .xl

      rsBattleAnimationSetAdvance ; 95/B554

        .al
        .xl
        .autsiz
        .databank ?

        ; Toward the opponent (rlBattleAnimationCompareCombatantX; if level, to
        ; the side with more room) by up to wR0 pixels at speed A, kept within
        ; the stage (X $68-$198).

        phx
        cpx #$0000
        bne _B56F
        jsl rlBattleAnimationCompareCombatantX
        beq _B564
        bcc _B5A3
        bra _B577


        _B564
        jsr rsBattleAnimationGetRoomToStageEdges
        lda lR18+1
        cmp lR19+1
        bcc _B5A3
        bra _B577


        _B56F
        jsl rlBattleAnimationCompareCombatantX
        beq _B564
        bcs _B5A3

        _B577
        jsr rsBattleAnimationGetRoomToStageEdges
        lda lR18+1
        cmp wR0
        bcc _B582
        lda wR0

        _B582
        sta wR1
        jsr rsBattleAnimationGetSpeedA
        xba
        ora #$8000
        sta wBattleAnimationXSpeed,b,x
        sta wBattleAnimationXStartSpeed,b,x
        lda wBattleAnimationX,b,x
        sec
        sbc wR1
        bcc _B59E
        cmp #$0068
        bcs _B5C8

        _B59E
        lda #$0068
        bra _B5C8


        _B5A3
        jsr rsBattleAnimationGetRoomToStageEdges
        lda lR19+1
        cmp wR0
        bcc _B5AE
        lda wR0

        _B5AE
        sta wR1
        jsr rsBattleAnimationGetSpeedA
        xba
        sta wBattleAnimationXSpeed,b,x
        sta wBattleAnimationXStartSpeed,b,x
        lda wBattleAnimationX,b,x
        clc
        adc wR1
        cmp #$0198
        bcc _B5C8
        lda #$0198

        _B5C8
        stz wBattleAnimationTargetXFixed,b,x
        sta wBattleAnimationTargetX,b,x
        plx
        rts

        .databank 0

        ; 95/B5D0

    .endsection Unsorted95B554Section


    .section Unsorted95B5D0Section

      .al
      .xl

      rlBattleAnimationGetBodyWidth ; 95/B5D0

        .al
        .xl
        .autsiz
        .databank ?

        ; Byte 0 of the combatant's body record.

        phx
        cpx #$0000
        bne _B5DC
        lda $7FE1BE
        bra _B5E0


        _B5DC
        lda $7FE1BF

        _B5E0
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda aBattleSceneCombatantBodyRecords,x
        and #$00FF
        jsl rlBattleSceneNoOp2
        plx
        rtl

        .databank 0

        ; 95/B5FD

      rlBattleAnimationGetHitHeight ; 95/B5FD

        .al
        .xl
        .autsiz
        .databank ?

        ; Byte 1 of the combatant's body record: the height its effects aim at and fly from.

        phx
        cpx #$0000
        bne _B609
        lda $7FE1BE
        bra _B60D


        _B609
        lda $7FE1BF

        _B60D
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda aBattleSceneCombatantBodyRecords+1,x
        and #$00FF
        plx
        rtl

        .databank 0

        ; 95/B626

      rlBattleAnimationGetSpacing ; 95/B626

        .al
        .xl
        .autsiz
        .databank ?

        ; Byte 2 of the combatant's body record: the distance it keeps from the
        ; opponent.

        phx
        phy
        cpx #$0000
        bne _B633
        lda $7FE1BE
        bra _B637


        _B633
        lda $7FE1BF

        _B637
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda aBattleSceneCombatantBodyRecords+2,x
        and #$00FF
        jsl rlBattleSceneNoOp2
        ply
        plx
        rtl

        .databank 0

        ; 95/B655

      rsBattleAnimationGetSpeedA ; 95/B655

        .al
        .xl
        .autsiz
        .databank ?

        ; Byte 3 of the combatant's body record: a speed in pixels per 8 frames.

        phx
        cpx #$0000
        bne _B661
        lda $7FE1BE
        bra _B665


        _B661
        lda $7FE1BF

        _B665
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda aBattleSceneCombatantBodyRecords+3,x
        and #$00FF
        plx
        rts

        .databank 0

        ; 95/B67E

      rsBattleAnimationGetSpeedB ; 95/B67E

        .al
        .xl
        .autsiz
        .databank ?

        ; Byte 4 of the combatant's body record: another speed in pixels per 8
        ; frames.

        phx
        cpx #$0000
        bne _B68A
        lda $7FE1BE
        bra _B68E


        _B68A
        lda $7FE1BF

        _B68E
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda aBattleSceneCombatantBodyRecords+4,x
        and #$00FF
        plx
        rts

        .databank 0

        ; 95/B6A7

    .endsection Unsorted95B5D0Section


    .section Unreferenced95B6A7Section

      .al
      .xl

      rsBattleAnimationGetBodyByte5 ; 95/B6A7

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Found by tools/sweep.py. Byte 5 of the combatant's body record; the only caller is not reached.

        phx
        cpx #$0000
        bne _B6B3
        lda $7FE1BE
        bra _B6B7


        _B6B3
        lda $7FE1BF

        _B6B7
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda aBattleSceneCombatantBodyRecords+5,x
        and #$00FF
        plx
        rts

        .databank 0

        ; 95/B6D0

    .endsection Unreferenced95B6A7Section
    .section Unsorted95B6D0Section

      .al
      .xl

      rlBattleSceneGetStartGap ; 95/B6D0

        .al
        .xl
        .autsiz
        .databank ?

        ; X = 0 or $43: the distance the combatants start apart. $C8 for a magic sword (Fire Sword to Light Brand) at range; $E0 for the Physic, Restore, Silence, Sleep and Berserk Staves at distance 2; otherwise twice byte 6 of the body record (the other combatant's when a mage faces a non-mage up close and rlBattleSceneCheckAlternatingRounds says so).

        phx
        lda wBattleDistance
        cmp #$0002
        bcc _B6F4
        cpx #$0000
        bne _B6E4
        lda aBattleSceneCombatant1.Weapon,b
        bra _B6E7


        _B6E4
        lda aBattleSceneCombatant2.Weapon,b

        _B6E7
        jsl rlBattleSceneIsMagicSword
        bcc _B6F4
        lda #$00C8
        jml _B7AC


        _B6F4
        lda wBattleDistance
        cmp #$0002
        bcs _B73C
        cpx #$0000
        bne _B720
        lda aBattleSceneCombatant1.AnimStyle,b
        and #$000F
        cmp #$0005
        bne _B73C
        lda aBattleSceneCombatant2.AnimStyle,b
        and #$000F
        cmp #$0005
        beq _B73C
        jsl rlBattleSceneCheckAlternatingRounds
        bcs _B781
        bra _B73C


        _B720
        lda aBattleSceneCombatant2.AnimStyle,b
        and #$000F
        cmp #$0005
        bne _B73C
        lda aBattleSceneCombatant1.AnimStyle,b
        and #$000F
        cmp #$0005
        beq _B73C
        jsl rlBattleSceneCheckAlternatingRounds
        bcs _B781

        _B73C
        cpx #$0000
        bne _B746
        lda aBattleSceneCombatant1.Weapon,b
        bra _B749


        _B746
        lda aBattleSceneCombatant2.Weapon,b

        _B749
        cmp #$005B
        beq _B762
        cmp #$0061
        beq _B762
        cmp #$0063
        beq _B762
        cmp #$0064
        beq _B762
        cmp #$0065
        bne _B770

        _B762
        lda wBattleDistance
        cmp #$0002
        bne _B770
        lda #$00E0
        bra _B7AC


        _B770
        cpx #$0000
        bne _B77B
        lda $7FE1BE
        bra _B77F


        _B77B
        lda $7FE1BF

        _B77F
        bra _B790


        _B781
        cpx #$0000
        bne _B78C
        lda $7FE1BF
        bra _B790


        _B78C
        lda $7FE1BE

        _B790
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda aBattleSceneCombatantBodyRecords+6,x
        and #$00FF
        jsl rlBattleSceneNoOp2
        asl a

        _B7AC
        plx
        rtl

        .databank 0

        ; 95/B7AE

      rlBattleSceneIsMagicSword ; 95/B7AE

        .al
        .xl
        .autsiz
        .databank ?

        ; A = item ID: carry set for the Fire, Earth, Thunder and Wind Swords and the Light Brand.

        and #$00FF
        cmp #$000F
        beq _B7CD
        cmp #$0010
        beq _B7CD
        cmp #$0011
        beq _B7CD
        cmp #$0012
        beq _B7CD
        cmp #$0013
        beq _B7CD
        clc
        bra _B7CE


        _B7CD
        sec

        _B7CE
        rtl

        .databank 0

        ; 95/B7CF

    .endsection Unsorted95B6D0Section


    .section Unreferenced95B7CFSection

      .al
      .xl

      rlBattleAnimationGetBodyByte7 ; 95/B7CF

        ; Called only from unreachable code in rsBattleScenePlaceCombatants. X = 0 or $43 (the combatant); returns byte 7 of the combatant's aBattleSceneCombatantBodyRecords record (index $7FE1BE/$7FE1BF).
        .al
        .xl
        .autsiz
        .databank ?

        ; Called only from unreachable code in rsBattleScenePlaceCombatants: byte 7 of the combatant's body record, there a starting height.

        phx
        cpx #$0000
        bne _B7DB
        lda $7FE1BE
        bra _B7DF


        _B7DB
        lda $7FE1BF

        _B7DF
        and #$00FF
        sta wR10
        lda #$0008
        sta wR11
        jsl rlUnsignedMultiply16By16
        ldx wR12
        lda aBattleSceneCombatantBodyRecords+7,x
        and #$00FF
        plx
        rtl

        .databank 0

        ; 95/B7F8

    .endsection Unreferenced95B7CFSection
    .section Unsorted95B7F8Section

      .al
      .xl

      rlBattleSceneGetKnockbackStrength ; 95/B7F8

        .al
        .xl
        .autsiz
        .databank ?

        ; A = class: the knockback strength, $762 / its weight (rlBattleSceneGetClassWeight).

        phx
        jsl rlBattleSceneGetClassWeight
        sta wR14
        lda #$0762
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        plx
        rtl

        .databank 0

        ; 95/B80C

      rlBattleSceneGetClassWeight ; 95/B80C

        .al
        .xl
        .autsiz
        .databank ?

        ; A = class: its byte of aBattleSceneClassWeights (index class + 1).

        phx
        inc a
        and #$00FF
        tax
        lda aBattleSceneClassWeights,x
        and #$00FF
        plx
        rtl

        .databank 0

        ; 95/B81B

    .endsection Unsorted95B7F8Section


    .section Unsorted95B81BSection

      .al
      .xl

      rlBattleAnimationSetBodyIndices ; 95/B81B

        .al
        .xl
        .autsiz
        .databank ?

        ; The two combatants' body records ($7FE1BE, $7FE1BF) from their classes
        ; and weapon categories.

        phx
        sep #$20
        lda aBattleSceneCombatant1.AnimStyle,b
        lsr a
        lsr a
        lsr a
        lsr a
        xba
        lda aBattleSceneCombatant1.Class,b
        rep #$20
        jsr rsBattleAnimationGetBodyIndex
        sep #$20
        sta $7FE1BE
        lda aBattleSceneCombatant2.AnimStyle,b
        lsr a
        lsr a
        lsr a
        lsr a
        xba
        lda aBattleSceneCombatant2.Class,b
        rep #$20
        jsr rsBattleAnimationGetBodyIndex
        sep #$20
        sta $7FE1BF
        rep #$20
        plx
        rtl

        .databank 0

        ; 95/B84E

      rsBattleAnimationGetBodyIndex ; 95/B84E

        .al
        .xl
        .autsiz
        .databank ?

        ; The body record for a class (low byte of A) and weapon category (high
        ; byte), from the table at $97/E8FB (class, category, record; $FF ends
        ; it).

        phx
        ldx #$0000
        sta wR0
        sep #$20

        _B856
        lda aBattleAnimationBodyRecords,x
        cmp #$FF
        beq _B873
        cmp wR0
        bne _B86E
        lda wR0+1
        cmp #$09
        beq _B87A
        cmp aBattleAnimationBodyRecords+1,x
        beq _B87A

        _B86E
        inc x
        inc x
        inc x
        bra _B856


        _B873
        rep #$20
        lda #$0000
        bra _B882


        _B87A
        .as
        rep #$20
        inc x
        inc x
        lda aBattleAnimationBodyRecords,x

        _B882
        plx
        rts

        .databank 0

        ; 95/B884

    .endsection Unsorted95B81BSection


    .section Unsorted95B884Section

      .al
      .xl

      rsBattleAnimationStartPose ; 95/B884

        .al
        .xl
        .autsiz
        .databank ?

        ; A + bBattleAnimationPoseOffset: starts that sequence on combatant X unless it is already playing.

        phx
        clc
        adc bBattleAnimationPoseOffset,b,x
        and #$00FF
        sep #$20
        pha
        cmp bBattleAnimationSequenceID,b,x
        bne _B899
        pla
        rep #$20
        bra _B8AE


        _B899
        .as
        pla
        rep #$20
        xba
        cpx #$0000
        bne _B8A7
        ora #$0000
        bra _B8AA


        _B8A7
        ora #$0001

        _B8AA
        jsl rlBattleAnimationStartSequence

        _B8AE
        plx
        rts

        .databank 0

        ; 95/B8B0

      rlBattleAnimationGetEffectStart ; 95/B8B0

        .al
        .xl
        .autsiz
        .databank ?

        ; A = class, wR2 = AnimStyle: the offset from the thrower where its effect appears, from aBattleAnimationEffectStarts (low byte X, toward the opponent; high byte Y). Carry set and 0 for a class not listed.

        phx
        pha
        lda wR2
        and #$00F0
        cmp #AnimCategoryRangedLance << 4
        bne _B8C1
        ldx #aBattleAnimationEffectStarts._Javelins - aBattleAnimationEffectStarts
        bra _B8CE


        _B8C1
        cmp #AnimCategoryRangedAxe << 4
        bne _B8CB
        ldx #aBattleAnimationEffectStarts._HandAxes - aBattleAnimationEffectStarts
        bra _B8CE


        _B8CB
        ldx #aBattleAnimationEffectStarts._Bows - aBattleAnimationEffectStarts

        _B8CE
        lda aBattleAnimationEffectStarts,x
        cmp #$FFFF
        beq _B8EA
        cmp #1,s
        bne _B8E4
        lda aBattleAnimationEffectStarts+2,x
        sta #1,s
        clc
        bra _B8F0


        _B8E4
        inc x
        inc x
        inc x
        inc x
        bra _B8CE


        _B8EA
        lda #$0000
        sta #1,s
        sec

        _B8F0
        pla
        plx
        rtl

        .databank 0

        ; 95/B8F3

      rlBattleSceneCheckMagicSword ; 95/B8F3

        .al
        .xl
        .autsiz
        .databank ?

        ; Y = the round entry in [lR18], X = the attacker. For a magic round (bit $40) by a sword wielder (AnimCategorySword): the status swords (Berserk, Silence and Sleep Swords) start their weapon script now (rlBattleSceneGetWeaponScript) and set bit 6 of the slot's state, returning carry set; any other sword striking from range (bit $20) sets bit 2 of bBattleAnimationCombatantFlags (and bit 6 of bBattleSceneStrikeFlags for a critical) so the round queues rlBattleSceneQueueMagicSwordAttack. Carry clear otherwise.

        lda [lR18],y
        bit #$0040
        beq _B956
        cpx #$0000
        bne _B904
        lda aBattleSceneCombatant1.AnimStyle,b
        bra _B907


        _B904
        lda aBattleSceneCombatant2.AnimStyle,b

        _B907
        and #$00F0
        cmp #$0000
        bne _B956
        cpx #$0000
        bne _B919
        lda aBattleSceneCombatant1.Weapon,b
        bra _B91C


        _B919
        lda aBattleSceneCombatant2.Weapon,b

        _B91C
        and #$00FF
        cmp #$0009
        beq _B959
        cmp #$000B
        beq _B959
        cmp #$000C
        beq _B959
        lda [lR18],y
        bit #$0020
        beq _B956
        lda [lR18],y
        bit #$0004
        beq _B948
        sep #$20
        lda bBattleSceneStrikeFlags,b
        ora #$40
        sta bBattleSceneStrikeFlags,b
        rep #$20

        _B948
        sep #$20
        lda bBattleAnimationCombatantFlags,b,x
        ora #$04
        and #$C7
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20

        _B956
        clc
        bra _B96E


        _B959
        jsl rlBattleSceneGetWeaponScript
        jsl rlStartBattleSceneScriptFar
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$40
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        sec

        _B96E
        rtl

        .databank 0

        ; 95/B96F

    .endsection Unsorted95B884Section


    .section Unsorted95B96FSection

      .al
      .xl

      rlBattleAnimationResetSlots ; 95/B96F

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the state of all four slots, sets the upload budget to $C00 and clears the release signals.

        sep #$20
        ldx #$0000

        _B974
        stz bBattleAnimationStateFlags,b,x
        rep #$20
        txa
        clc
        adc #$0043
        tax
        sep #$20
        cpx #$010C
        bcc _B974
        rep #$20
        lda #$0C00
        sta wBattleSceneUploadBudget,b
        jsl rlBattleAnimationClearSignals
        rtl

        .databank 0

        ; 95/B993

    .endsection Unsorted95B96FSection


    .section Unsorted95B993Section

      .al
      .xl

      rlBattleAnimationResetSpawnSlot ; 95/B993

        .al
        .xl
        .autsiz
        .databank ?

        ; Fills the spawn slot ($0BFF) from aBattleAnimationSpawnSlotTemplate.

        pha
        phx
        sep #$20
        ldx #$0000

        _B99A
        lda aBattleAnimationSpawnSlotTemplate,x
        sta bBattleAnimationSpawnStateFlags,b,x
        inc x
        cpx #$0043
        bcc _B99A
        rep #$20
        plx
        pla
        rtl

        .databank 0

        ; 95/B9AC

      rlBattleAnimationCopySpawnSlot ; 95/B9AC

        .al
        .xl
        .autsiz
        .databank ?

        ; Points the spawn slot's script at its sequence, then copies the slot into slot A (0-3; 4 and up do nothing).

        phy
        pha
        lda lBattleAnimationSpawnFrameDataPointer+1,b
        sta lR18+1
        lda lBattleAnimationSpawnFrameDataPointer,b
        sta lR18
        sta wR0
        ldy #$0000
        lda bBattleAnimationSpawnSequenceID,b
        and #$00FF
        asl a
        clc
        adc [lR18],y
        clc
        adc lR18
        sta lR18
        lda [lR18],y
        clc
        adc wR0
        sta wBattleAnimationSpawnScriptLoopOffset,b
        sta wBattleAnimationSpawnScriptOffset,b
        pla
        and #$00FF
        cmp #$0004
        bcs _BA03
        sep #$20
        sta $4202,b
        lda #$43
        sta $4203,b
        nop
        nop
        nop
        ldx #$0000
        ldy $4216,b

        _B9F3
        lda bBattleAnimationSpawnStateFlags,b,x
        sta bBattleAnimationStateFlags,b,y
        inc y
        inc x
        cpx #$0043
        bcc _B9F3
        rep #$20
        clc

        _BA03
        ply
        rtl

        .databank 0

        ; 95/BA05

      rlBattleAnimationStartSequence ; 95/BA05

        .al
        .xl
        .autsiz
        .databank ?

        ; Starts a sequence on a slot and sets its busy bit (see ANIM_CMD_F7).

        phx
        phy
        and #$3FFF
        sep #$20
        cmp #$04
        bcs _BA71
        sta $4202,b
        lda #$43
        sta $4203,b
        nop
        nop
        nop
        nop
        ldx $4216,b
        pha
        lda bBattleAnimationStateFlags,b,x
        bit #$04
        beq _BA2B
        pla
        sec
        bra _BA71


        _BA2B
        pla
        xba
        sta bBattleAnimationSequenceID,b,x
        stz bBattleAnimationFrameTimer,b,x
        pha
        lda bBattleAnimationStateFlags,b,x
        ora #$01
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationStateFlags,b,x
        ora #$04
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        and #$9F
        sta bBattleAnimationFacingFlags,b,x
        pla
        rep #$20
        pha
        lda lBattleAnimationFrameDataPointer+1,b,x
        sta lR18+1
        lda lBattleAnimationFrameDataPointer,b,x
        sta lR18
        ldy #$0000
        pla
        and #$00FF
        asl a
        adc [lR18],y
        tay
        lda [lR18],y
        clc
        adc lR18
        sta wBattleAnimationScriptLoopOffset,b,x
        sta wBattleAnimationScriptOffset,b,x
        clc

        _BA71
        .as
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 95/BA76

      rlBattleAnimationStartSequence2 ; 95/BA76

        .al
        .xl
        .autsiz
        .databank ?

        ; The same code as rlBattleAnimationStartSequence; used for effects whose role is 4 or more.

        phx
        phy
        and #$3FFF
        sep #$20
        cmp #$04
        bcs _BAE2
        sta $4202,b
        lda #$43
        sta $4203,b
        nop
        nop
        nop
        nop
        ldx $4216,b
        pha
        lda bBattleAnimationStateFlags,b,x
        bit #$04
        beq _BA9C
        pla
        sec
        bra _BAE2


        _BA9C
        pla
        xba
        sta bBattleAnimationSequenceID,b,x
        stz bBattleAnimationFrameTimer,b,x
        pha
        lda bBattleAnimationStateFlags,b,x
        ora #$01
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationStateFlags,b,x
        ora #$04
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        and #$9F
        sta bBattleAnimationFacingFlags,b,x
        pla
        rep #$20
        pha
        lda lBattleAnimationFrameDataPointer+1,b,x
        sta lR18+1
        lda lBattleAnimationFrameDataPointer,b,x
        sta lR18
        ldy #$0000
        pla
        and #$00FF
        asl a
        adc [lR18],y
        tay
        lda [lR18],y
        clc
        adc lR18
        sta wBattleAnimationScriptLoopOffset,b,x
        sta wBattleAnimationScriptOffset,b,x
        clc

        _BAE2
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 95/BAE7

      rlBattleAnimationClearSlot ; 95/BAE7

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the slot: clears its state (bBattleAnimationStateFlags), which stops it.

        sep #$20
        stz bBattleAnimationStateFlags,b,x
        rep #$20
        rtl

        .databank 0

        ; 95/BAEF

      rlBattleAnimationUpdateAll ; 95/BAEF

        .al
        .xl
        .autsiz
        .databank ?

        ; Each frame: runs each animation slot's sequence (rsBattleAnimationUpdate), the slots taken in order of their role.

        lda $7FFC77
        bit #$0001
        bne _BB2D
        lda #$0000

        _BAFB
        sta $0C43,b
        ldx #$0000

        _BB01
        phx
        lda bBattleAnimationRole,b,x
        and #$00FF
        cmp $0C43,b
        bne _BB18
        lda bBattleAnimationStateFlags,b,x
        bit #$0080
        beq _BB18
        jsr rsBattleAnimationUpdate

        _BB18
        plx
        txa
        clc
        adc #$0043
        tax
        cpx #$010C
        bcc _BB01
        lda $0C43,b
        inc a
        cmp #$0008
        bcc _BAFB

        _BB2D
        rtl

        .databank 0

        ; 95/BB2E

      rsBattleAnimationUpdate ; 95/BB2E

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the slot: steps its sequence script when it is playing (bit 0 of its state), else rlBattleAnimationDrawSlot.

        lda bBattleAnimationStateFlags,b,x
        bit #$0001
        bne _BB3D
        clc
        jsl rlBattleAnimationDrawSlot
        bra _BB40


        _BB3D
        jsr rsBattleAnimationRunScript

        _BB40
        rts

        .databank 0

        ; 95/BB41

      rsBattleAnimationRunScript ; 95/BB41

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs the slot's sequence script when its frame timer is out: a command byte ($E8-$FF, ANIM_CMD_* in include/BattleAnimation.h) or a pose and its frames.

        lda bBattleAnimationFrameTimer,b,x
        and #$00FF
        beq _BB4D
        jml _BC9D


        _BB4D
        jsr rsBattleAnimationReadStep
        and #$00FF
        cmp #$00FE
        bne _BB5C
        jml _BCB6


        _BB5C
        cmp #$00FD
        bne _BB68
        jsr rsBattleAnimationCmdStay
        jml _BC9D


        _BB68
        cmp #$00FC
        bne _BB74
        jsr rsBattleAnimationCmdRestart
        jml _BC65


        _BB74
        cmp #$00FB
        bne _BB80
        jsr rsBattleAnimationCmdGoBack
        jml _BC65


        _BB80
        cmp #$00FA
        bne _BB8C
        jsr rsBattleAnimationCmdWait
        jml _BC9D


        _BB8C
        cmp #$00F9
        bne _BB98
        jsr rsBattleAnimationCmdPlaySound
        jml _BC65


        _BB98
        cmp #$00F8
        bne _BBA4
        jsr rsBattleAnimationCmdNothing
        jml _BC65


        _BBA4
        cmp #$00F7
        bne _BBB0
        jsr rsBattleAnimationCmdBroken
        jml _BC65


        _BBB0
        cmp #$00F6
        bne _BBBC
        jsr rsBattleAnimationCmdClearBusy
        jml _BC65


        _BBBC
        cmp #$00F5
        bne _BBC8
        jsr rsBattleAnimationCmdSetBusy
        jml _BC65


        _BBC8
        cmp #$00F4
        bne _BBD6
        jsr rsBattleAnimationCmdWaitForSignal
        bcs _BBD6
        jml _BC65


        _BBD6
        cmp #$00F3
        bne _BBE2
        jsr rsBattleAnimationCmdFreezeAndGoBack
        jml _BC65


        _BBE2
        cmp #$00F2
        bne _BBEC
        jsr rsBattleAnimationCmdSignalOther
        bra _BC65


        _BBEC
        cmp #$00F1
        bne _BBFC
        jsr rsBattleAnimationCmdQueueIdle
        bcc _BBFA
        jml _BC9D


        _BBFA
        bra _BC65


        _BBFC
        cmp #$00F0
        bne _BC06
        jsr rsBattleAnimationCmdApplyStrike
        bra _BC65


        _BC06
        cmp #$00EF
        bne _BC10
        jsr rsBattleAnimationCmdStartWeaponScript
        bra _BC65


        _BC10
        cmp #$00EE
        bne _BC1A
        jsr rsBattleAnimationCmdSpawnEffect
        bra _BC65


        _BC1A
        cmp #$00ED
        bne _BC24
        jsr rsBattleAnimationCmdDodgeIfMissed
        bra _BC65


        _BC24
        cmp #$00EC
        bne _BC2E
        jsr rsBattleAnimationCmdSetVariant
        bra _BC65


        _BC2E
        cmp #$00EB
        bne _BC38
        jsr rsBattleAnimationCmdAfterimage
        bra _BC65


        _BC38
        cmp #$00EA
        bne _BC42
        jsr rsBattleAnimationCmdEndWhenStopped
        bra _BC65


        _BC42
        cmp #$00E9
        bne _BC4C
        jsr rsBattleAnimationCmdContinue
        bra _BC65


        _BC4C
        cmp #$00E8
        bne _BC56
        jsr rsBattleAnimationCmdFaceOther
        bra _BC65


        _BC56
        cmp #$00E7
        bne _BC60
        jsr rsBattleAnimationCmdEndWhenStoppedSignal
        bra _BC65


        _BC60
        jsr rsBattleAnimationApplyScriptStep
        bra _BC69


        _BC65
        jml _BB4D


        _BC69
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$FD
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        jsr rsBattleAnimationReadStep
        pha
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        pla
        sep #$20
        sta bBattleAnimationPoseID,b,x
        xba
        jsr rsBattleAnimationScaleDelay
        sta bBattleAnimationFrameTimer,b,x
        rep #$20
        lda bBattleAnimationStateFlags,b,x
        bit #$0002
        bne _BCAA
        sec
        bra _BCA6


        _BC9D
        lda bBattleAnimationStateFlags,b,x
        bit #$0002
        bne _BCAA
        clc

        _BCA6
        jsl rlBattleAnimationDrawSlot

        _BCAA
        lda bBattleAnimationFrameTimer,b,x
        and #$00FF
        beq _BCB5
        dec bBattleAnimationFrameTimer,b,x

        _BCB5
        rts


        _BCB6
        sep #$20
        stz bBattleAnimationStateFlags,b,x
        rep #$20
        rts

        .databank 0

        ; 95/BCBE

      rsBattleAnimationCmdStay ; 95/BCBE

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$FE
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        rts

        .databank 0

        ; 95/BCCB

      rsBattleAnimationCmdRestart ; 95/BCCB

        .al
        .xl
        .autsiz
        .databank ?

        lda wBattleAnimationScriptLoopOffset,b,x
        sta wBattleAnimationScriptOffset,b,x
        jsr rsBattleAnimationRestartMoveList
        rts

        .databank 0

        ; 95/BCD5

      rsBattleAnimationCmdGoBack ; 95/BCD5

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsBattleAnimationReadStep
        xba
        and #$00FF
        bne _BCDF
        inc a

        _BCDF
        asl a
        pha
        lda wBattleAnimationScriptOffset,b,x
        sec
        sbc #1,s
        sta wBattleAnimationScriptOffset,b,x
        pla
        jsr rsBattleAnimationGoBackMoveList
        rts

        .databank 0

        ; 95/BCEF

      rsBattleAnimationCmdWait ; 95/BCEF

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsBattleAnimationReadStep
        sep #$20
        xba
        jsr rsBattleAnimationScaleDelay
        sta bBattleAnimationFrameTimer,b,x
        lda bBattleAnimationStateFlags,b,x
        ora #$02
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BD10

      rsBattleAnimationCmdPlaySound ; 95/BD10

        .al
        .xl
        .autsiz
        .databank ?

        lda @l $000AF5,x
        bit #$0040
        bne _BD60
        lda wBattleAnimationX,b,x
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        bmi _BD30
        cmp #$0100
        bcc _BD35
        lda #$1F00
        bra _BD39


        _BD30
        lda #$0100
        bra _BD39


        _BD35
        jsl rlGetSoundPanFromXPixel

        _BD39
        cpx #$0000
        bne _BD42
        clc
        adc #$2000

        _BD42
        pha
        jsr rsBattleAnimationReadStep
        inc a
        xba
        and #$00FF
        phx
        asl a
        tax
        lda aBattleAnimationSoundEffects,x
        plx
        jsr rsBattleAnimationUseWaterSounds
        jsr rsBattleAnimationUseListedWeaponSounds
        ora #1,s
        jsl rlPlaySoundEffect2
        pla

        _BD60
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BD6B

      rsBattleAnimationCmdNothing ; 95/BD6B

        .al
        .xl
        .autsiz
        .databank ?

        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BD76

      rsBattleAnimationCmdBroken ; 95/BD76

        ; Probably a bug in the original: unlike its neighbours this has no
        ; rep #$20 after storing $0C42, so adc #$0002 runs as adc #$02 and the
        ; CPU then executes the $00 as brk. Sequence byte $F8 of rsBattleAnimationRunScript; the
        ; prologue log never runs it.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$01
        sta $0C42,b
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$02
        .byte $00 ; brk
        sta wBattleAnimationScriptOffset,b,x
        sec
        rts

        .databank 0

        ; 95/BD89

      rsBattleAnimationCmdClearBusy ; 95/BD89

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$FB
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BDA0

      rsBattleAnimationCmdSetBusy ; 95/BDA0

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$04
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BDB7

      rsBattleAnimationCmdWaitForSignal ; 95/BDB7

        .al
        .xl
        .autsiz
        .databank ?

        lda $0C42,b
        bne _BDBF
        clc
        bra _BDD1


        _BDBF
        sep #$20
        stz $0C42,b
        rep #$20
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        sec

        _BDD1
        rts

        .databank 0

        ; 95/BDD2

      rsBattleAnimationCmdFreezeAndGoBack ; 95/BDD2

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$40
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        jsr rsBattleAnimationReadStep
        xba
        and #$00FF
        bne _BDE8
        inc a

        _BDE8
        asl a
        pha
        lda wBattleAnimationScriptOffset,b,x
        sec
        sbc #1,s
        sta wBattleAnimationScriptOffset,b,x
        pla
        rts

        .databank 0

        ; 95/BDF5

      rsBattleAnimationCmdSignalOther ; 95/BDF5

        .al
        .xl
        .autsiz
        .databank ?

        ; Sequence command $F3: rlBattleAnimationSignalOther.

        jsl rlBattleAnimationSignalOther
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BE04

      rsBattleAnimationCmdQueueIdle ; 95/BE04

        .al
        .xl
        .autsiz
        .databank ?

        ; Sequence command $F2: rlBattleSceneQueueIdleAction and variant 0; does not advance.

        jsl rlBattleSceneQueueIdleAction
        sep #$20
        lda bBattleAnimationCombatantFlags,b,x
        and #$FC
        ora #$00
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        rts

        .databank 0

        ; 95/BE17

      rsBattleAnimationCmdApplyStrike ; 95/BE17

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlBattleSceneApplyStrike
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BE26

      rsBattleAnimationCmdStartWeaponScript ; 95/BE26

        .al
        .xl
        .autsiz
        .databank ?

        ; Sequence command $F0: starts the weapon's battle scene script (rlBattleSceneGetWeaponScript), the spell of a tome or staff.

        jsl rlBattleSceneGetWeaponScript
        jsl rlStartBattleSceneScriptFar
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BE39

      rsBattleAnimationCmdSpawnEffect ; 95/BE39

        .al
        .xl
        .autsiz
        .databank ?

        ; Sequence command $EF Arg: starts the combatant's effect slot (arrow, thrown weapon, spell) with sequence Arg (rsBattleAnimationSpawnEffect1/2), between two calls of rlBattleAnimationSetEffectMotion.

        jsr rsBattleAnimationReadStep
        phx
        cpx #$0000
        bne _BE6E
        pha
        lda aBattleSceneCombatant1.Weapon,b
        sta wR0
        lda aBattleSceneCombatant1.AnimStyle,b
        jsl rlBattleAnimationSetEffectMotion
        sep #$20
        lda $0B7D,b
        sta bBattleAnimationSpawnRole,b
        rep #$20
        pla
        pha
        xba
        jsr rsBattleAnimationSpawnEffect1
        pla
        lda aBattleSceneCombatant1.Weapon,b
        sta wR0
        lda aBattleSceneCombatant1.AnimStyle,b
        jsl rlBattleAnimationSetEffectMotion
        bra _BE98


        _BE6E
        pha
        lda aBattleSceneCombatant2.Weapon,b
        sta wR0
        lda aBattleSceneCombatant2.AnimStyle,b
        jsl rlBattleAnimationSetEffectMotion
        sep #$20
        lda $0BC0,b
        sta bBattleAnimationSpawnRole,b
        rep #$20
        pla
        pha
        xba
        jsr rsBattleAnimationSpawnEffect2
        pla
        lda aBattleSceneCombatant2.Weapon,b
        sta wR0
        lda aBattleSceneCombatant2.AnimStyle,b
        jsl rlBattleAnimationSetEffectMotion

        _BE98
        plx
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BEA4

      rsBattleAnimationCmdDodgeIfMissed ; 95/BEA4

        .al
        .xl
        .autsiz
        .databank ?

        ; Sequence command $EE: rlBattleSceneStartHitEffectSprites, then the other combatant dodges (rlBattleSceneQueueDodge) if the strike missed.

        jsl rlBattleSceneStartHitEffectSprites
        lda bBattleSceneStrikeFlags,b
        bit #$0008
        beq _BEC3
        phx
        cpx #$0000
        beq _BEBB
        ldx #$0000
        bra _BEBE


        _BEBB
        ldx #$0043

        _BEBE
        jsl rlBattleSceneQueueDodge
        plx

        _BEC3
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BECE

      rsBattleAnimationCmdSetVariant ; 95/BECE

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsBattleAnimationReadStep
        xba
        pha
        sep #$20
        lda bBattleAnimationCombatantFlags,b,x
        and #$FC
        ora #1,s
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        pla
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BEED

      rsBattleAnimationCmdAfterimage ; 95/BEED

        .al
        .xl
        .autsiz
        .databank ?

        ; Sequence command $EC Arg: by Arg & 3, stops (0) or starts (1) the combatant's afterimage, or clears (2) or sets (3) its mirrored double (bit 7 of bBattleAnimationFacingFlags).

        cpx #$0000
        bne _BEF7
        lda #$0000
        bra _BEFA


        _BEF7
        lda #$0001

        _BEFA
        pha
        jsr rsBattleAnimationReadStep
        xba
        and #$0003
        beq _BF13
        cmp #$0001
        beq _BF1A
        cmp #$0002
        beq _BF21
        cmp #$0003
        beq _BF30

        _BF13
        pla
        jsl rlBattleAnimationStopAfterimage
        bra _BF3F


        _BF1A
        pla
        jsl rlBattleAnimationStartAfterimage
        bra _BF3F


        _BF21
        pla
        sep #$20
        lda bBattleAnimationFacingFlags,b,x
        and #$7F
        sta bBattleAnimationFacingFlags,b,x
        rep #$20
        bra _BF3F


        _BF30
        pla
        sep #$20
        lda bBattleAnimationFacingFlags,b,x
        ora #$80
        sta bBattleAnimationFacingFlags,b,x
        rep #$20
        bra _BF3F


        _BF3F
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BF4A

      rsBattleAnimationCmdEndWhenStopped ; 95/BF4A

        .al
        .xl
        .autsiz
        .databank ?

        ; Sequence command $EB: sets bit 6 of bBattleAnimationFacingFlags: the sequence ends once the slot stops moving (no X speed, no Y velocity), the camera follows the attacker alone, and rsBattleSceneCheckBusy counts it as done.

        sep #$20
        lda bBattleAnimationFacingFlags,b,x
        ora #$40
        sta bBattleAnimationFacingFlags,b,x
        rep #$20
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BF61

      rsBattleAnimationCmdEndWhenStoppedSignal ; 95/BF61

        .al
        .xl
        .autsiz
        .databank ?

        ; Sequence command $E8: as $EB; a slot not moving already also signals itself and sets bit 6 of its state.

        lda wBattleAnimationXSpeed,b,x
        bne _BF76
        jsl rlBattleAnimationSignalSelf
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        ora #$40
        sta bBattleAnimationStateFlags,b,x
        rep #$20

        _BF76
        sep #$20
        lda bBattleAnimationFacingFlags,b,x
        ora #$40
        sta bBattleAnimationFacingFlags,b,x
        rep #$20
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BF8D

      rsBattleAnimationCmdContinue ; 95/BF8D

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$FE
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BFA4

      rsBattleAnimationCmdFaceOther ; 95/BFA4

        .al
        .xl
        .autsiz
        .databank ?

        ; Sequence command $E9: rlBattleAnimationFaceOther.

        jsl rlBattleAnimationFaceOther
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        rts

        .databank 0

        ; 95/BFB3

      rsBattleAnimationReadStep ; 95/BFB3

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the word at the slot's script offset, minus 1 (a command byte $FF reads as $FE).

        phy
        lda lBattleAnimationFrameDataPointer+1,b,x
        sta lR18+1
        lda wBattleAnimationScriptOffset,b,x
        sta lR18
        ldy #$0000
        lda [lR18],y
        dec a
        ply
        rts

        .databank 0

        ; 95/BFC6

      rsBattleAnimationScaleDelay ; 95/BFC6

        .as
        .xl
        .autsiz
        .databank ?

        ; A (8-bit) = frames: returns them times the slot's 8.8 delay multiplier (bBattleAnimationDelayMultiplier2 whole, bBattleAnimationDelayMultiplier1 fraction), rounded.

        pha
        sta $4202,b
        lda bBattleAnimationDelayMultiplier1,b,x
        sta $4203,b
        nop
        nop
        nop
        lda $4216,b
        asl a
        lda #$00
        adc #$00
        sta wR12+1
        lda $4217,b
        sta wR12
        pla
        sta $4202,b
        lda bBattleAnimationDelayMultiplier2,b,x
        sta $4203,b
        nop
        nop
        nop
        lda $4216,b
        clc
        adc wR12
        clc
        adc wR12+1
        rts

        .databank 0

        ; 95/BFF9

      rsBattleAnimationGetPoseRecord ; 95/BFF9

        .al
        .xl
        .autsiz
        .databank ?

        ; Returns the address of the slot's pose's frame record: the frame data block plus its record list's offset for bBattleAnimationPoseID.

        phy
        lda lBattleAnimationFrameDataPointer+1,b,x
        sta lR18+1
        lda lBattleAnimationFrameDataPointer,b,x
        sta lR18
        sta wR9
        ldy #$0002
        lda bBattleAnimationPoseID,b,x
        and #$00FF
        asl a
        clc
        adc [lR18],y
        clc
        adc lR18
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc wR9
        ply
        rts

        .databank 0

        ; 95/C022

      rlBattleAnimationRelease ; 95/C022

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the combatant: clears its frozen bit (bit 6 of bBattleAnimationStateFlags) and moves its script on past the next $F4 command (ANIM_CMD_F4, the one that froze it), or to the next $FE.

        phx
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$BF
        sta bBattleAnimationStateFlags,b,x
        rep #$20

        _C02F
        jsr rsBattleAnimationReadStep
        and #$00FF
        cmp #$00FD
        beq _C055
        cmp #$00F3
        beq _C04B
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x
        bra _C02F


        _C04B
        lda wBattleAnimationScriptOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationScriptOffset,b,x

        _C055
        plx
        rtl

        .databank 0

        ; 95/C057

      rlBattleAnimationSignalSelf ; 95/C057

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the combatant: counts up its release signals (bBattleSceneRelease1 for 0, bBattleSceneRelease2 for $43).

        phx
        sep #$20
        cpx #$0000
        bne _C06A
        lda bBattleSceneRelease1
        inc a
        sta bBattleSceneRelease1
        bra _C073


        _C06A
        lda bBattleSceneRelease2
        inc a
        sta bBattleSceneRelease2

        _C073
        rep #$20
        plx
        rtl

        .databank 0

        ; 95/C077

      rlBattleAnimationSignalOther ; 95/C077

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the combatant: counts up the other combatant's release signals.

        phx
        sep #$20
        cpx #$0000
        beq _C08A
        lda bBattleSceneRelease1
        inc a
        sta bBattleSceneRelease1
        bra _C093


        _C08A
        lda bBattleSceneRelease2
        inc a
        sta bBattleSceneRelease2

        _C093
        rep #$20
        plx
        rtl

        .databank 0

        ; 95/C097

      rlBattleAnimationClearSignals ; 95/C097

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears both combatants' release signals.

        sep #$20
        lda #$00
        sta bBattleSceneRelease1
        sta bBattleSceneRelease2
        rep #$20
        rtl

        .databank 0

        ; 95/C0A6

      rlBattleAnimationRunSignals ; 95/C0A6

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: a combatant that is frozen (bit 6 of its state) and has a release signal is released (rlBattleAnimationRelease) and the signal counted down.

        phx
        lda bBattleSceneRelease1
        and #$00FF
        beq _C0CC
        ldx #$0000
        lda bBattleAnimationStateFlags,b,x
        bit #$0040
        beq _C0CC
        jsl rlBattleAnimationRelease
        sep #$20
        lda bBattleSceneRelease1
        dec a
        sta bBattleSceneRelease1
        rep #$20

        _C0CC
        lda bBattleSceneRelease2
        and #$00FF
        beq _C0F1
        ldx #$0043
        lda bBattleAnimationStateFlags,b,x
        bit #$0040
        beq _C0F1
        jsl rlBattleAnimationRelease
        sep #$20
        lda bBattleSceneRelease2
        dec a
        sta bBattleSceneRelease2
        rep #$20

        _C0F1
        plx
        rtl

        .databank 0

        ; 95/C0F3

      rsBattleAnimationUseWaterSounds ; 95/C0F3

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        ; A = sound: on a river, or on the sea where the combatant's 8-pixel column is water (aBattleSceneSeaColumns), sounds $11-$19 become $21-$29.

        phx
        pha
        lda wBattleSceneFlags
        bit #BattleSceneFlagRiver
        bne _C119
        lda wBattleSceneFlags
        bit #BattleSceneFlagSea
        beq _C177
        lda wBattleAnimationX,b,x
        lsr a
        lsr a
        lsr a
        phx
        tax
        lda aBattleSceneSeaColumns,x
        plx
        and #$00FF
        beq _C177

        _C119
        lda #1,s
        cmp #$0011
        bne _C125
        lda #$0021
        bra _C175


        _C125
        cmp #$0012
        bne _C12F
        lda #$0022
        bra _C175


        _C12F
        cmp #$0013
        bne _C139
        lda #$0023
        bra _C175


        _C139
        cmp #$0014
        bne _C143
        lda #$0024
        bra _C175


        _C143
        cmp #$0015
        bne _C14D
        lda #$0025
        bra _C175


        _C14D
        cmp #$0016
        bne _C157
        lda #$0026
        bra _C175


        _C157
        cmp #$0017
        bne _C161
        lda #$0027
        bra _C175


        _C161
        cmp #$0018
        bne _C16B
        lda #$0028
        bra _C175


        _C16B
        cmp #$0019
        bne _C175
        lda #$0029
        bra _C175


        _C175
        sta #1,s

        _C177
        pla
        plx
        rts

        .databank 0

        ; 95/C17A

      rsBattleAnimationUseListedWeaponSounds ; 95/C17A

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        ; A = sound: when the combatant's weapon is in aBattleSceneListedWeapons (BattleSceneFlagListedWeapon1/2), sounds $47, $6D, $8C and $8E become the next sound.

        phx
        pha
        lda wBattleSceneFlags
        cpx #$0000
        bne _C18A
        bit #BattleSceneFlagListedWeapon1
        bra _C18D


        _C18A
        bit #$0200

        _C18D
        beq _C1A8
        lda #1,s
        cmp #$008C
        beq _C1A5
        cmp #$008E
        beq _C1A5
        cmp #$006D
        beq _C1A5
        cmp #$0047
        bne _C1A8

        _C1A5
        inc a
        sta #1,s

        _C1A8
        pla
        plx
        rts

        .databank 0

        ; 95/C1AB

      rlBattleAnimationDrawSlot ; 95/C1AB

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the slot: draws its pose's sprite at its screen position (X minus the camera, plus the draw offset; Y from the anchor), flipped when rlBattleAnimationGetMirroredX says so, unless the pose is $FE (hidden) or bit 6 of its bBattleAnimationCombatantFlags is set. With carry set (a new pose) it also queues the pose's frame tiles (rlBattleAnimationLoadFrameTiles).

        phx
        phy
        php
        rep #$20
        lda wBattleAnimationBaseTile,b,x
        sta wR6
        lda wBattleAnimationX,b,x
        and #$01FF
        jsl rlBattleAnimationGetMirroredX
        bcc _C1CA
        pha
        lda wR6
        eor #$8000
        sta wR6
        pla

        _C1CA
        sec
        sbc wBattleSceneCameraX
        sta wR0
        sep #$20
        lda bBattleAnimationDrawOffsetX,b,x
        bmi _C1DF
        rep #$20
        and #$00FF
        bra _C1E4


        _C1DF
        .as
        rep #$20
        ora #$FF00

        _C1E4
        clc
        adc wR0
        jsl rlBattleSceneNoOp1
        sta wR0
        lda wBattleAnimationYAnchor,b,x
        sec
        sbc wBattleAnimationYFixed,b,x
        xba
        clc
        adc wBattleSceneCameraY
        and #$00FF
        sta wR1
        lda bBattleAnimationDrawOffsetY,b,x
        and #$00FF
        clc
        adc wR1
        and #$00FF
        sta wR1
        lda bBattleAnimationPoseID,b,x
        and #$00FF
        cmp #$00FE
        bne _C21B
        plp
        bra _C272


        _C21B
        lda wBattleAnimationBaseTile,b,x
        and #$7FFF
        sta wR4
        lda wBattleAnimationBaseTile+1,b,x
        and #$FF00
        sta wR5
        phx
        sep #$20
        phb
        lda lBattleAnimationFrameDataPointer+2,b,x
        pha
        plb
        .databank ?
        rep #$20
        jsr rsBattleAnimationGetPoseRecord
        pha
        inc a
        tay
        phx
        lda wR6
        bit #$8000
        bne _C247
        clc
        bra _C248


        _C247
        sec

        _C248
        php
        lda bBattleAnimationCombatantFlags,b,x
        bit #$0040
        beq _C256
        plp
        jml _C25B


        _C256
        plp
        jsl rlBattleScenePushSprites

        _C25B
        plx
        lda lBattleAnimationFrameDataPointer+1,b,x
        sta lR18+1
        pla
        sta lR18
        ldy #$0000
        lda [lR18],y
        plb
        .databank ?
        plx
        plp
        bcc _C272
        jsl rlBattleAnimationLoadFrameTiles

        _C272
        ply
        plx
        rtl

        .databank 0

        ; 95/C275

      rlBattleAnimationLoadFrameTiles ; 95/C275

        .al
        .xl
        .autsiz
        .databank ?

        ; A = frame number: for a combatant slot (0 or $43), queues that frame's tile rows from its sheet (lBattleAnimationSecondaryPointer1) by its frame table (lBattleAnimationSecondaryPointer2) to VRAM at wBattleAnimationSecondaryOffset.

        pha
        phx
        phy
        cpx #$0000
        beq _C284
        cpx #$0043
        beq _C284
        bra _C2A5


        _C284
        pha
        lda lBattleAnimationSecondaryPointer1+1,b,x
        sta lR18+1
        lda lBattleAnimationSecondaryPointer1,b,x
        sta lR18
        lda lBattleAnimationSecondaryPointer2+1,b,x
        sta lR19+1
        lda lBattleAnimationSecondaryPointer2,b,x
        sta lR19
        lda wBattleAnimationSecondaryOffset,b,x
        sta wR0
        pla
        jsl rlBattleAnimationQueueFrameTiles
        bra _C2A5


        _C2A5
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/C2A9

      rlBattleAnimationQueueFrameTiles ; 95/C2A9

        .al
        .xl
        .autsiz
        .databank ?

        ; A = frame number ($FF keeps the tiles loaded): finds the frame in the frame table at lR19 and queues its rows (rsBattleAnimationQueueFrameRows).

        phy
        and #$00FF
        cmp #$00FF
        beq _C2BE
        asl a
        tay
        lda [lR19],y
        clc
        adc lR19
        sta lR19
        jsr rsBattleAnimationQueueFrameRows

        _C2BE
        ply
        rtl

        .databank 0

        ; 95/C2C0

      rsBattleAnimationQueueFrameRows ; 95/C2C0

        .al
        .xl
        .autsiz
        .databank ?

        ; Queues each row of the frame at lR19 (a count byte, then per row an offset into the sheet at lR18 and a byte count) for VRAM from wR0, $100 words apart.

        phy
        lda lR18
        sta lR20
        lda lR18+1
        sta lR20+1
        ldy #$0000
        lda [lR19],y
        and #$00FF
        inc lR19
        tax
        ldy wR0

        _C2D6
        phy
        ldy #$0000
        lda [lR19],y
        inc lR19
        inc lR19
        clc
        adc lR20
        sta lR18
        lda #$0000
        adc lR20+2
        sep #$20
        sta lR18+2
        rep #$20
        lda [lR19],y
        inc lR19
        inc lR19
        ply
        jsl rlBattleSceneQueueUpload
        tya
        clc
        adc #$0100
        tay
        dec x
        bne _C2D6
        ply
        rts

        .databank 0

        ; 95/C306

    .endsection Unsorted95B993Section


    .section Unreferenced95C306Section

      .al
      .xl

      rsBattleAnimationQueueFrameTilesAbsolute ; 95/C306

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; As rlBattleAnimationQueueFrameTiles, but the frame table holds addresses rather than offsets.

        phy
        and #$00FF
        cmp #$00FF
        beq _C318
        asl a
        tay
        lda [lR19],y
        sta lR19
        jsr rsBattleAnimationQueueFrameRowsAbsolute

        _C318
        ply
        rts

        .databank 0

        ; 95/C31A

      rsBattleAnimationQueueFrameRowsAbsolute ; 95/C31A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; As rsBattleAnimationQueueFrameRows (a copy used by rsBattleAnimationQueueFrameTilesAbsolute).

        phy
        lda lR18
        sta lR20
        lda lR18+1
        sta lR20+1
        ldy #$0000
        lda [lR19],y
        and #$00FF
        inc lR19
        tax
        ldy wR0

        _C330
        phy
        ldy #$0000
        lda [lR19],y
        inc lR19
        inc lR19
        clc
        adc lR20
        sta lR18
        lda #$0000
        adc lR20+2
        sep #$20
        sta lR18+2
        rep #$20
        lda [lR19],y
        inc lR19
        inc lR19
        ply
        jsl rlBattleSceneQueueUpload
        tya
        clc
        adc #$0100
        tay
        dec x
        bne _C330
        ply
        rts

        .databank 0

        ; 95/C360

      rsBattleAnimationSetSignal ; 95/C360

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Sets $0C42, the signal sequence command $F5 waits for (rsBattleAnimationCmdWaitForSignal).

        sep #$20
        lda #$01
        sta $0C42,b
        rts

        .databank 0

        ; 95/C368

    .endsection Unreferenced95C306Section
    .section Unsorted95C368Section

      .al
      .xl

      rlBattleSceneRunUploads ; 95/C368

        .al
        .xl
        .autsiz
        .databank ?

        ; In VBlank: sends the queued uploads, last first, up to wBattleSceneUploadBudget bytes; the one that does not fit is sent in part and the rest left queued. Then resets the budget to $0C00.

        lda bBattleSceneUploadCount,b
        and #$00FF
        beq _C3B8
        cmp #$0011
        bcc _C37F
        lda #$0010
        sep #$20
        sta bBattleSceneUploadCount,b
        rep #$20

        _C37F
        tay
        dec a
        ora #$0700
        sta $4202,b
        nop
        nop
        nop
        ldx $4216,b
        lda wBattleSceneUploadBudget,b
        and #$FFFE
        sta wBattleSceneUploadBudget,b

        _C396
        lda wBattleSceneUploadBudget,b
        beq _C3B8
        sec
        sbc aBattleSceneUploads.Size,b,x
        bcs _C3A6
        jsr rsBattleSceneSendUploadPart
        bra _C3B8


        _C3A6
        sta wBattleSceneUploadBudget,b
        jsr rsBattleSceneSendUpload
        txa
        sec
        sbc #$0007
        tax
        dec bBattleSceneUploadCount,b
        dec y
        bne _C396

        _C3B8
        lda #$0C00
        sta wBattleSceneUploadBudget,b
        stz wBattleSceneUploadTotal,b
        rtl

        .databank 0

        ; 95/C3C2

      rsBattleSceneSendUpload ; 95/C3C2

        .al
        .xl
        .autsiz
        .databank ?

        ; Sends upload X whole (DMA channel 0).

        lda aBattleSceneUploads.VRAMAddress,b,x
        sta $2116,b
        lda #$1801
        sta $4300,b
        lda aBattleSceneUploads.Source,b,x
        sta $4302,b
        lda $0CCA,b,x
        sta $4303,b
        lda aBattleSceneUploads.Size,b,x
        sta $4305,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        rts

        .databank 0

        ; 95/C3EA

      rsBattleSceneSendUploadPart ; 95/C3EA

        .al
        .xl
        .autsiz
        .databank ?

        ; Sends the first wBattleSceneUploadBudget bytes of upload X (DMA channel 1) and advances it past them.

        lda aBattleSceneUploads.VRAMAddress,b,x
        sta $2116,b
        lda #$1801
        sta $4310,b
        lda aBattleSceneUploads.Source,b,x
        sta $4312,b
        lda $0CCA,b,x
        sta $4313,b
        lda wBattleSceneUploadBudget,b
        sta $4315,b
        lda wBattleSceneUploadBudget,b
        lsr a
        clc
        adc aBattleSceneUploads.VRAMAddress,b,x
        sta aBattleSceneUploads.VRAMAddress,b,x
        lda aBattleSceneUploads.Source,b,x
        clc
        adc wBattleSceneUploadBudget,b
        sta aBattleSceneUploads.Source,b,x
        lda #$0000
        adc $0CCB,b,x
        sep #$20
        sta $0CCB,b,x
        rep #$20
        lda aBattleSceneUploads.Size,b,x
        sec
        sbc wBattleSceneUploadBudget,b
        sta aBattleSceneUploads.Size,b,x
        sep #$20
        lda #$02
        sta $420B,b
        rep #$20
        rts

        .databank 0

        ; 95/C43E

    .endsection Unsorted95C368Section


    .section Unsorted95C43ESection

      .al
      .xl

      rlBattleSceneQueueUpload ; 95/C43E

        .al
        .xl
        .autsiz
        .databank ?

        ; Queues A bytes from lR18 for VRAM word address Y (aBattleSceneUploads). Carry set when the queue is full (16).

        phx
        pha
        lda bBattleSceneUploadCount,b
        and #$00FF
        cmp #$0010
        bcc _C44F
        pla
        sec
        bra _C478


        _C44F
        ora #$0700
        sta $4202,b
        nop
        nop
        nop
        ldx $4216,b
        pla
        sta aBattleSceneUploads.Size,b,x
        clc
        adc wBattleSceneUploadTotal,b
        sta wBattleSceneUploadTotal,b
        tya
        sta aBattleSceneUploads.VRAMAddress,b,x
        lda lR18
        sta aBattleSceneUploads.Source,b,x
        lda lR18+1
        sta $0CCA,b,x
        inc bBattleSceneUploadCount,b
        clc

        _C478
        plx
        rtl

        .databank 0

        ; 95/C47A

      rlBattleSceneRunLargeUpload ; 95/C47A

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: queues the next part of the large upload (wBattleSceneLargeUploadSize bytes left), as much as keeps the frame's queue under $800 bytes.

        pha
        phy
        lda wBattleSceneLargeUploadSize
        beq _C4E0
        lda #$0800
        cmp wBattleSceneUploadTotal,b
        bcc _C4E0
        beq _C4E0
        pha
        lda wBattleSceneLargeUploadVRAM
        tay
        lda lBattleSceneLargeUploadSource
        sta lR18
        lda lBattleSceneLargeUploadSource+1
        sta lR18+1
        pla
        sec
        sbc wBattleSceneUploadTotal,b
        cmp wBattleSceneLargeUploadSize
        bcc _C4BA
        lda wBattleSceneLargeUploadSize
        jsl rlBattleSceneQueueUpload
        lda #$0000
        sta wBattleSceneLargeUploadSize
        bra _C4E0


        _C4BA
        pha
        jsl rlBattleSceneQueueUpload
        lda wBattleSceneLargeUploadSize
        sec
        sbc #1,s
        sta wBattleSceneLargeUploadSize
        lda lBattleSceneLargeUploadSource
        clc
        adc #1,s
        sta lBattleSceneLargeUploadSource
        pla
        lsr a
        clc
        adc wBattleSceneLargeUploadVRAM
        sta wBattleSceneLargeUploadVRAM

        _C4E0
        ply
        pla
        rtl

        .databank 0

        ; 95/C4E3

      rlBattleSceneStartLargeUpload ; 95/C4E3

        .al
        .xl
        .autsiz
        .databank ?

        ; Starts a large upload of A bytes from lR18 to VRAM word address Y, sent over several frames by rlBattleSceneRunLargeUpload. Carry set (and nothing done) while one is still running.

        phx
        pha
        lda wBattleSceneLargeUploadSize
        beq _C4EF
        pla
        sec
        bra _C506


        _C4EF
        pla
        sta wBattleSceneLargeUploadSize
        tya
        sta wBattleSceneLargeUploadVRAM
        lda lR18
        sta lBattleSceneLargeUploadSource
        lda lR18+1
        sta lBattleSceneLargeUploadSource+1
        clc

        _C506
        plx
        rtl

        .databank 0

        ; 95/C508

      rlBattleSceneCheckDecompressing ; 95/C508

        .al
        .xl
        .autsiz
        .databank ?

        ; Returns $FF in A if bDecompressionArrayFlag is nonzero, else $00.

        lda bDecompressionArrayFlag,b
        and #$00FF
        beq _C518
        sep #$20
        lda #$FF
        rep #$20
        bra _C51E


        _C518
        sep #$20
        lda #$00
        rep #$20

        _C51E
        rtl

        .databank 0

        ; 95/C51F

      rlBattleScenePushSprites ; 95/C51F

        .al
        .xl
        .autsiz
        .databank ?

        ; Pushes the sprite array at Y (bank B) to the OAM buffer at wR0, wR1 with base tile wR4 and attributes wR5: carry clear through rlPushToOAMBuffer, carry set mirrored (X offsets taken from the right and the H-flip bit set).

        bcs _C52C
        lda wR5
        and #$BFFF
        sta wR5
        jml rlPushToOAMBuffer


        _C52C
        lda $0000,b,y
        bne _C532
        rtl


        _C532
        sta wR2
        inc y
        inc y
        lda wR5
        ora #$4000
        sta wR5
        ldx wNextFreeSpriteOffset,b
        clc

        _C541
        lda $0000,b,y
        bmi _C568
        lda wR0
        sec
        sbc $0000,b,y
        sec
        sbc #$0008
        sta aSpriteBuffer,b,x
        bit #$0100
        beq _C566
        lda aOAMSizeBitTable,x
        sta wR3
        lda (wR3)
        ora aOAMUpperXBitTable,x
        sta (wR3)

        _C566
        bra _C589


        _C568
        lda wR0
        sec
        sec
        sbc $0000,b,y
        sec
        sbc #$0010
        sta aSpriteBuffer,b,x
        bit #$0100
        beq _C589
        lda aOAMSizeBitTable,x
        sta wR3
        lda (wR3)
        ora aOAMUpperXBitTable,x
        sta (wR3)

        _C589
        clc
        lda $0002,b,y
        bit #$0080
        bne _C597
        and #$007F
        bra _C59A


        _C597
        ora #$FF80

        _C59A
        clc
        adc wR1
        sta $1C01,b,x
        clc
        adc #$0010
        cmp #$0100
        bcc _C5AF
        lda #$00F0
        sta $1C01,b,x

        _C5AF
        clc
        lda $0000,b,y
        bpl _C5C3
        lda aOAMSizeBitTable,x
        sta wR3
        lda (wR3)
        ora aOAMUpperXBitTable+2,x
        sta (wR3)

        _C5C3
        lda $0003,b,y
        adc wR4
        eor wR5
        sta $1C02,b,x
        txa
        adc #$0004
        and #$01FF
        tax
        tya
        adc #$0005
        tay
        dec wR2
        beq _C5E2
        jml _C541


        _C5E2
        stx wNextFreeSpriteOffset,b
        rtl

        .databank 0

        ; 95/C5E6

      rsBattleSceneTurnCombatants ; 95/C5E6

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: when both combatants may turn (rsBattleSceneCheckMayTurn), flips them to face each other.

        phx
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationX,b,x
        sta wR0
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        sta wR1
        lda wR0
        cmp wR1
        bcc _C609
        lda #$0000
        sta wR0
        lda #$8000
        sta wR1
        bra _C613


        _C609
        lda #$8000
        sta wR0
        lda #$0000
        sta wR1

        _C613
        ldx wBattleAnimationAttackerOffset,b
        jsr rsBattleSceneCheckMayTurn
        bcc _C639
        lda wBattleAnimationBaseTile,b,x
        and #$7FFF
        ora wR0
        sta wBattleAnimationBaseTile,b,x
        ldx wBattleAnimationDefenderOffset,b
        jsr rsBattleSceneCheckMayTurn
        bcc _C639
        lda wBattleAnimationBaseTile,b,x
        and #$7FFF
        ora wR1
        sta wBattleAnimationBaseTile,b,x

        _C639
        plx
        rts

        .databank 0

        ; 95/C63B

      rsBattleSceneCheckMayTurn ; 95/C63B

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the combatant: carry set when it may turn to face the other: no sequence playing, on the ground, both move queues empty (bBattleSceneQueuesIdle), bit 1 of $7FE186 clear, and its class is not $43-$46.

        phy
        lda bBattleAnimationStateFlags,b,x
        bit #$0001
        bne _C694
        lda wBattleAnimationYFixed,b,x
        bne _C694
        lda bBattleSceneQueuesIdle,b
        and #$0003
        cmp #$0003
        bne _C694
        lda $7FE186
        bit #$0002
        bne _C694
        lda $7FE186
        bit #$0001
        beq _C670
        sep #$20
        ora #$02
        sta $7FE186
        rep #$20

        _C670
        cpx #$0000
        bne _C67A
        lda aBattleSceneCombatant1.Class,b
        bra _C67D


        _C67A
        lda aBattleSceneCombatant2.Class,b

        _C67D
        cmp #$0043
        beq _C694
        cmp #$0044
        beq _C694
        cmp #$0045
        beq _C694
        cmp #$0046
        beq _C694
        sec
        bra _C695


        _C694
        clc

        _C695
        ply
        rts

        .databank 0

        ; 95/C697

      rlBattleAnimationFaceOther ; 95/C697

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the combatant: sets its H-flip bit (bit 15 of wBattleAnimationBaseTile) to face the other combatant.

        phx
        lda wBattleAnimationX,b,x
        sta wR0
        phx
        cpx #$0000
        bne _C6A8
        ldx #$0043
        bra _C6AB


        _C6A8
        ldx #$0000

        _C6AB
        lda wBattleAnimationX,b,x
        sta wR1
        plx
        lda wR0
        cmp wR1
        bcc _C6C2
        lda wBattleAnimationBaseTile,b,x
        and #$7FFF
        sta wBattleAnimationBaseTile,b,x
        bra _C6CB


        _C6C2
        lda wBattleAnimationBaseTile,b,x
        ora #$8000
        sta wBattleAnimationBaseTile,b,x

        _C6CB
        plx
        rtl

        .databank 0

        ; 95/C6CD

      rlBattleAnimationUpdateX ; 95/C6CD

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves X toward $0B00 by the speed $0B08 and stops on it; when both X
        ; and Y motion have stopped, ends the move. With bit 0 of $0AF6 set, X
        ; just moves by the speed.

        phx
        phy
        lda bBattleAnimationMotionFlags,b,x
        bit #$0001
        beq _C6DB
        jml _C7C7


        _C6DB
        lda wBattleAnimationXSpeed,b,x
        bne _C6E4
        jml _C7C1


        _C6E4
        bpl _C6EA
        jml _C73C


        _C6EA
        sta wR0
        lda wBattleAnimationX,b,x
        cmp wBattleAnimationTargetX,b,x
        beq _C6F8
        bcc _C718
        bcs _C700

        _C6F8
        lda wBattleAnimationXFixed,b,x
        cmp wBattleAnimationTargetXFixed,b,x
        bcc _C718

        _C700
        lda wBattleAnimationXFixed,b,x
        sec
        sbc wBattleAnimationTargetXFixed,b,x
        sta wR0
        lda wBattleAnimationTargetXFixed,b,x
        sta wBattleAnimationXFixed,b,x
        lda wBattleAnimationTargetX,b,x
        sta wBattleAnimationX,b,x
        stz wBattleAnimationXSpeed,b,x

        _C718
        lda wR0
        sec
        jsr rsBattleAnimationMoveRight
        bcc _C738
        sta wR0
        lda wBattleAnimationTargetXFixed,b,x
        sec
        sbc wR0
        sta wBattleAnimationTargetXFixed,b,x
        lda wBattleAnimationTargetX+1,b,x
        sbc #$0000
        sep #$20
        sta wBattleAnimationTargetX+1,b,x
        rep #$20

        _C738
        jml _C78F


        _C73C
        and #$7FFF
        sta wR0
        lda wBattleAnimationX,b,x
        cmp wBattleAnimationTargetX,b,x
        beq _C74D
        bcc _C757
        bcs _C76F

        _C74D
        lda wBattleAnimationXFixed,b,x
        cmp wBattleAnimationTargetXFixed,b,x
        beq _C757
        bcs _C76F

        _C757
        lda wBattleAnimationTargetXFixed,b,x
        sec
        sbc wBattleAnimationXFixed,b,x
        sta wR0
        lda wBattleAnimationTargetXFixed,b,x
        sta wBattleAnimationXFixed,b,x
        lda wBattleAnimationTargetX,b,x
        sta wBattleAnimationX,b,x
        stz wBattleAnimationXSpeed,b,x

        _C76F
        lda wR0
        sec
        jsr rsBattleAnimationMoveLeft
        bcc _C78F
        sta wR0
        lda wBattleAnimationTargetXFixed,b,x
        clc
        adc wR0
        sta wBattleAnimationTargetXFixed,b,x
        lda wBattleAnimationTargetX+1,b,x
        adc #$0000
        sep #$20
        sta wBattleAnimationTargetX+1,b,x
        rep #$20

        _C78F
        lda wBattleAnimationXSpeed,b,x
        bne _C7C1
        lda wBattleAnimationYVelocity,b,x
        bne _C7AB
        lda bBattleAnimationFacingFlags,b,x
        bit #$0040
        beq _C7AB
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$FE
        sta bBattleAnimationStateFlags,b,x

        _C7AB
        sep #$20
        lda bBattleAnimationFacingFlags,b,x
        and #$FE
        sta bBattleAnimationFacingFlags,b,x
        lda bBattleAnimationCombatantFlags,b,x
        and #$FC
        ora #$02
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20

        _C7C1
        jsr rsBattleAnimationApplyXDeceleration
        ply
        plx
        rtl


        _C7C7
        lda wBattleAnimationXSpeed,b,x
        beq _C7FF
        bmi _C7E4
        clc
        adc wBattleAnimationXFixed,b,x
        sta wBattleAnimationXFixed,b,x
        lda wBattleAnimationX+1,b,x
        adc #$0000
        sep #$20
        sta wBattleAnimationX+1,b,x
        rep #$20
        bra _C7FF


        _C7E4
        and #$7FFF
        sta wR2
        lda wBattleAnimationXFixed,b,x
        sec
        sbc wR2
        sta wBattleAnimationXFixed,b,x
        lda wBattleAnimationX+1,b,x
        sbc #$0000
        sep #$20
        sta wBattleAnimationX+1,b,x
        rep #$20

        _C7FF
        ply
        plx
        rtl

        .databank 0

        ; 95/C802

      rsBattleAnimationApplyXDeceleration ; 95/C802

        .al
        .xl
        .autsiz
        .databank ?

        ; Slows $0B08 by $0B0A each frame, or halves it when $0B0A is $FFFF.

        lda wBattleAnimationXDeceleration,b,x
        cmp #$FFFF
        bne _C82A
        lda wBattleAnimationXSpeed,b,x
        and #$8000
        pha
        lda wBattleAnimationXSpeed,b,x
        and #$7FFF
        lsr a
        bne _C822
        lda #$0000
        sta wBattleAnimationXDeceleration,b,x
        bra _C824


        _C822
        ora #1,s

        _C824
        sta wBattleAnimationXSpeed,b,x
        pla
        bra _C857


        _C82A
        lda wBattleAnimationXDeceleration,b,x
        bit #$7FFF
        beq _C857
        and #$8000
        pha
        lda wBattleAnimationXDeceleration,b,x
        and #$7FFF
        pha
        lda wBattleAnimationXSpeed,b,x
        and #$7FFF
        sec
        sbc #1,s
        bcs _C850
        lda #$0000
        sta wBattleAnimationXDeceleration,b,x
        bra _C852


        _C850
        ora #3,s

        _C852
        sta wBattleAnimationXSpeed,b,x
        pla
        pla

        _C857
        rts

        .databank 0

        ; 95/C858

      rsBattleAnimationMoveRight ; 95/C858

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        ; X = the combatant, A = 8.8 pixels: moves it right, stopping against the other combatant (rsBattleAnimationCheckBlocked) or the stage's right edge, and scrolls the camera after it (carry set: both combatants, else the attacker). Carry set when it was stopped short.

        php
        pha
        sec
        jsr rsBattleAnimationCheckBlocked
        bcc _C89B
        xba
        pha
        lda #3,s
        and #$FF00
        beq _C888
        cmp #1,s
        bcc _C888
        sec
        sbc #1,s
        sta #1,s
        lda wBattleAnimationXFixed,b,x
        clc
        adc #1,s
        sta wBattleAnimationXFixed,b,x
        lda wBattleAnimationX+1,b,x
        adc #$0000
        sep #$20
        sta wBattleAnimationX+1,b,x
        rep #$20

        _C888
        lda wBattleAnimationXFixed,b,x
        sta wBattleAnimationTargetXFixed,b,x
        lda wBattleAnimationX,b,x
        sta wBattleAnimationTargetX,b,x
        stz wBattleAnimationXSpeed,b,x
        pla
        pla
        bra _C8F1


        _C89B
        pla
        sta wR0
        sta wR2
        lda wBattleAnimationXFixed,b,x
        clc
        adc wR2
        sta wBattleAnimationXFixed,b,x
        lda wBattleAnimationX+1,b,x
        adc #$0000
        sep #$20
        sta wBattleAnimationX+1,b,x
        rep #$20
        jsr rsBattleAnimationGetRoomToStageEdges
        lda lR19+1
        bpl _C8F1
        lda lR19
        eor #$FFFF
        inc a
        sta wR1
        lda wBattleAnimationXFixed,b,x
        sec
        sbc wR1
        sta wBattleAnimationXFixed,b,x
        lda wBattleAnimationX+1,b,x
        sbc #$0000
        sep #$20
        sta wBattleAnimationX+1,b,x
        rep #$20
        lda wR0
        sec
        sbc wR1
        sta wR0
        lda wBattleAnimationXFixed,b,x
        sta wBattleAnimationTargetXFixed,b,x
        lda wBattleAnimationX,b,x
        sta wBattleAnimationTargetX,b,x
        stz wBattleAnimationXSpeed,b,x

        _C8F1
        plp
        bcc _C8FE
        lda wR0
        and #$7FFF
        jsr rsBattleSceneScrollCameraRight
        bra _C903


        _C8FE
        lda wR0
        jsr rsBattleSceneScrollCameraRightToAttacker

        _C903
        lda wR2
        sec
        sbc wR0
        beq _C90D
        sec
        bra _C90E


        _C90D
        clc

        _C90E
        rts

        .databank 0

        ; 95/C90F

      rsBattleAnimationMoveLeft ; 95/C90F

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        ; As rsBattleAnimationMoveRight, to the left.

        php
        pha
        clc
        jsr rsBattleAnimationCheckBlocked
        bcc _C952
        xba
        pha
        lda #3,s
        and #$FF00
        beq _C93F
        cmp #1,s
        bcc _C93F
        sec
        sbc #1,s
        sta #1,s
        lda wBattleAnimationXFixed,b,x
        sec
        sbc #1,s
        sta wBattleAnimationXFixed,b,x
        lda wBattleAnimationX+1,b,x
        sbc #$0000
        sep #$20
        sta wBattleAnimationX+1,b,x
        rep #$20

        _C93F
        lda wBattleAnimationXFixed,b,x
        sta wBattleAnimationTargetXFixed,b,x
        lda wBattleAnimationX,b,x
        sta wBattleAnimationTargetX,b,x
        stz wBattleAnimationXSpeed,b,x
        pla
        pla
        bra _C9A8


        _C952
        pla
        sta wR0
        sta wR2
        lda wBattleAnimationXFixed,b,x
        sec
        sbc wR2
        sta wBattleAnimationXFixed,b,x
        lda wBattleAnimationX+1,b,x
        sbc #$0000
        sep #$20
        sta wBattleAnimationX+1,b,x
        rep #$20
        jsr rsBattleAnimationGetRoomToStageEdges
        lda lR18+1
        bpl _C9A8
        lda lR18
        eor #$FFFF
        inc a
        sta wR1
        lda wBattleAnimationXFixed,b,x
        clc
        adc wR1
        sta wBattleAnimationXFixed,b,x
        lda wBattleAnimationX+1,b,x
        adc #$0000
        sep #$20
        sta wBattleAnimationX+1,b,x
        rep #$20
        lda wR0
        sec
        sbc wR1
        sta wR0
        lda wBattleAnimationXFixed,b,x
        sta wBattleAnimationTargetXFixed,b,x
        lda wBattleAnimationX,b,x
        sta wBattleAnimationTargetX,b,x
        stz wBattleAnimationXSpeed,b,x

        _C9A8
        plp
        bcc _C9B2
        lda wR0
        jsr rsBattleSceneScrollCameraLeft
        bra _C9B7


        _C9B2
        lda wR0
        jsr rsBattleSceneScrollCameraLeftToAttacker

        _C9B7
        lda wR2
        sec
        sbc wR0
        beq _C9C1
        sec
        bra _C9C2


        _C9C1
        clc

        _C9C2
        rts

        .databank 0

        ; 95/C9C3

      rsBattleAnimationGetRoomToStageEdges ; 95/C9C3

        .al
        .xl
        .autsiz
        .databank ?

        ; lR18+1 the room to the left stage edge (X $68) and lR19+1 to the right
        ; one ($198), less the combatant's width.

        phx
        lda wBattleAnimationXFixed,b,x
        sta lR18
        lda wBattleAnimationX,b,x
        sta lR18+1
        jsl rlBattleAnimationGetBodyWidth
        pha
        clc
        adc lR18+1
        sta wR9
        lda lR18
        sta lR19
        lda #$0198
        sec
        sbc wR9
        sta lR19+1
        bpl _C9F1
        sep #$20
        lda lR19
        eor #$FF
        inc a
        sta lR19
        rep #$20

        _C9F1
        pla
        sta wR9
        lda lR18+1
        sec
        sbc wR9
        sec
        sbc #$0068
        sta lR18+1
        plx
        rts

        .databank 0

        ; 95/CA01

      rsBattleAnimationCheckBlocked ; 95/CA01

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the combatant (carry set when moving right): when it is walking on the ground toward the other combatant and their bodies (rlBattleAnimationGetBodyWidth) overlap, returns carry set and the overlap in A; else carry clear and 0.

        phx
        php
        lda bBattleAnimationFacingFlags,b,x
        bit #$0001
        beq _CA0E
        plp
        bra _CA11


        _CA0E
        plp
        bra _CA71


        _CA11
        php
        lda wBattleAnimationYFixed,b,x
        bne _CA1A
        plp
        bra _CA1D


        _CA1A
        plp
        bra _CA71


        _CA1D
        php
        cpx #$0000
        bne _CA2B
        lda wBattleAnimationX,b,x
        ldx #$0043
        bra _CA34


        _CA2B
        ldx #$0043
        lda wBattleAnimationX,b,x
        ldx #$0000

        _CA34
        plp
        bcc _CA3E
        cmp wBattleAnimationX,b,x
        bcc _CA43
        bra _CA71


        _CA3E
        cmp wBattleAnimationX,b,x
        bcc _CA71

        _CA43
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationX,b,x
        ldx wBattleAnimationDefenderOffset,b
        sec
        sbc wBattleAnimationX,b,x
        bpl _CA56
        eor #$FFFF
        inc a

        _CA56
        pha
        ldx wBattleAnimationAttackerOffset,b
        jsl rlBattleAnimationGetBodyWidth
        pha
        ldx wBattleAnimationDefenderOffset,b
        jsl rlBattleAnimationGetBodyWidth
        clc
        adc #1,s
        cmp #3,s
        beq _CA6F
        bcs _CA77

        _CA6F
        pla
        pla

        _CA71
        lda #$0000
        clc
        bra _CA7F


        _CA77
        sec
        sbc #3,s
        sta #3,s
        pla
        pla
        sec

        _CA7F
        plx
        rts

        .databank 0

        ; 95/CA81

    .endsection Unsorted95C43ESection


    .section Unsorted95CA81Section

      .al
      .xl

      rlBattleSceneClearKnockback ; 95/CA81

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the knockback (bBattleSceneKnockback).

        lda #$0000
        sta bBattleSceneKnockback,b
        rtl

        .databank 0

        ; 95/CA88

    .endsection Unsorted95CA81Section


    .section Unsorted95CA88Section

      .al
      .xl

      rlBattleSceneSetKnockback ; 95/CA88

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the defender's knockback (bBattleSceneKnockback, bBattleSceneKnockbackShake): its strength by its class (rlBattleSceneGetKnockbackStrength), and its side.

        phx
        phy
        lda bBattleSceneAttackerSide,b
        bit #$0080
        beq _CAAB
        lda aBattleSceneCombatant1.Class,b
        jsl rlBattleSceneGetKnockbackStrength
        sta wR0
        jsl rlBattleAnimationCompareCombatantX
        bcc _CAA6
        lda #$0040
        bra _CAC2


        _CAA6
        lda #$0000
        bra _CAC2


        _CAAB
        lda aBattleSceneCombatant2.Class,b
        jsl rlBattleSceneGetKnockbackStrength
        sta wR0
        jsl rlBattleAnimationCompareCombatantX
        bcc _CABF
        lda #$0080
        bra _CAC2


        _CABF
        lda #$00C0

        _CAC2
        sep #$20
        pha
        ora wR0
        sta bBattleSceneKnockback,b
        pla
        ora #$18
        sta bBattleSceneKnockbackShake,b
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 95/CAD5

      rlBattleSceneRunKnockback ; 95/CAD5

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: pushes the knocked-back combatant by its knockback strength / 4 pixels (stopped by the other combatant or the stage edge) and takes the strength down to 3/4; then shakes it sideways by aBattleSceneKnockbackShake for the frames left in bBattleSceneKnockbackShake.

        phx
        lda bBattleSceneKnockback,b
        bit #$003F
        beq _CB3B
        jsl rlBattleSceneSetKnockbackDirection
        bit #$0080
        bne _CAEC
        ldx #$0000
        bra _CAEF


        _CAEC
        ldx #$0043

        _CAEF
        bit #$0040
        beq _CB0A
        and #$003F
        xba
        lsr a
        lsr a
        sec
        jsr rsBattleAnimationMoveRight
        bcc _CB06
        stz wBattleAnimationXSpeed,b,x
        stz wBattleAnimationXDeceleration,b,x

        _CB06
        jml _CB1C


        _CB0A
        and #$003F
        xba
        lsr a
        lsr a
        sec
        jsr rsBattleAnimationMoveLeft
        bcc _CB1C
        stz wBattleAnimationXSpeed,b,x
        stz wBattleAnimationXDeceleration,b,x

        _CB1C
        sep #$20
        lda bBattleSceneKnockback,b
        pha
        and #$C0
        xba
        pla
        and #$3F
        lsr a
        pha
        lsr a
        clc
        adc #1,s
        sta #1,s
        pla
        pha
        xba
        ora #1,s
        sta bBattleSceneKnockback,b
        pla
        rep #$20

        _CB3B
        lda bBattleSceneKnockbackShake,b
        bit #$003F
        beq _CB95
        lda bBattleSceneKnockbackShake,b
        bit #$003F
        beq _CB95
        bit #$0040
        bne _CB66
        and #$003F
        phx
        tax
        lda aBattleSceneKnockbackShake,x
        and #$00FF
        plx
        sep #$20
        sta bBattleAnimationDrawOffsetX,b,x
        rep #$20
        bra _CB7E


        _CB66
        and #$003F
        phx
        tax
        lda aBattleSceneKnockbackShake,x
        and #$00FF
        eor #$FFFF
        inc a
        plx
        sep #$20
        sta bBattleAnimationDrawOffsetX,b,x
        rep #$20

        _CB7E
        sep #$20
        lda bBattleSceneKnockbackShake,b
        pha
        and #$C0
        xba
        pla
        and #$3F
        dec a
        pha
        xba
        ora #1,s
        sta bBattleSceneKnockbackShake,b
        pla
        rep #$20

        _CB95
        plx
        rtl

        .databank 0

        ; 95/CB97

      rlBattleSceneSetKnockbackDirection ; 95/CB97

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bit 6 of bBattleSceneKnockback when the knocked-back combatant is pushed right: away from the other combatant, or by its side of the stage ($100) when they stand at the same X.

        pha
        phx
        lda bBattleSceneKnockback,b
        bit #$0080
        bne _CBB5
        jsl rlBattleAnimationCompareCombatantX
        bne _CBB1
        lda wBattleAnimationX,b
        cmp #$0100
        bcc _CBC9
        bra _CBD5


        _CBB1
        bcc _CBD5
        bra _CBC9


        _CBB5
        jsl rlBattleAnimationCompareCombatantX
        bne _CBC5
        lda wBattleAnimationX,b
        cmp #$0100
        bcc _CBC9
        bra _CBD5


        _CBC5
        bcc _CBC9
        bra _CBD5


        _CBC9
        sep #$20
        lda bBattleSceneKnockback,b
        ora #$40
        sta bBattleSceneKnockback,b
        bra _CBDF


        _CBD5
        .al
        sep #$20
        lda bBattleSceneKnockback,b
        and #$BF
        sta bBattleSceneKnockback,b

        _CBDF
        rep #$20
        plx
        pla
        rtl

        .databank 0

        ; 95/CBE4

      rlBattleAnimationApplyDefaultGravity ; 95/CBE4

        .al
        .xl
        .autsiz
        .databank ?

        ; Gives a combatant whose Y ($0AFD) is not 0 and that has no Y move or
        ; gravity a gravity of $18, unless bit 5 of $0AF3 is set.

        phx
        phy
        lda bBattleAnimationStateFlags,b,x
        bit #$0020
        bne _CC03
        lda wBattleAnimationYFixed,b,x
        beq _CC03
        lda wBattleAnimationYStep,b,x
        bne _CC03
        lda wBattleAnimationGravity,b,x
        bne _CC03
        lda #$0018
        sta wBattleAnimationGravity,b,x

        _CC03
        ply
        plx
        rtl

        .databank 0

        ; 95/CC06

      rlBattleAnimationUpdateJump ; 95/CC06

        .al
        .xl
        .autsiz
        .databank ?

        ; Applies the vertical velocity $0B0E, less the gravity $0B10 each
        ; frame.

        phx
        phy
        lda bBattleAnimationStateFlags,b,x
        bit #$0020
        beq _CC14
        jml _CCD2


        _CC14
        lda bBattleAnimationMotionFlags,b,x
        bit #$0001
        beq _CC20
        jml rlBattleAnimationFallToGround


        _CC20
        lda bBattleAnimationCombatantFlags,b,x
        bit #$0080
        beq _CC2C
        jml _CD3E


        _CC2C
        lda bBattleAnimationFacingFlags,b,x
        bit #$0008
        beq _CC38
        jml _CCD5


        _CC38
        lda bBattleAnimationStateFlags,b,x
        bit #$0010
        beq _CC44
        jml _CCD2


        _CC44
        lda wBattleAnimationYVelocity,b,x
        bne _CC52
        lda wBattleAnimationYFixed,b,x
        bne _CC52
        jml _CCD2


        _CC52
        lda wBattleAnimationYVelocity,b,x
        bmi _CC62
        lda wBattleAnimationYVelocity,b,x
        clc
        adc wBattleAnimationYFixed,b,x
        bcc _CC99
        bra _CC6B


        _CC62
        lda wBattleAnimationYVelocity,b,x
        clc
        adc wBattleAnimationYFixed,b,x
        bcs _CC99

        _CC6B
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$F7
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        and #$DF
        sta bBattleAnimationFacingFlags,b,x
        lda bBattleAnimationCombatantFlags,b,x
        and #$FC
        ora #$02
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        stz wBattleAnimationYFixed,b,x
        stz wBattleAnimationYVelocity,b,x
        lda bBattleAnimationStateFlags,b,x
        bit #$0004
        bne _CC97

        _CC97
        bra _CCD2


        _CC99
        sta wBattleAnimationYFixed,b,x
        beq _CCC8
        lda bBattleAnimationStateFlags,b,x
        bit #$0004
        bne _CCC8
        xba
        lda $0B12,b,x
        and #$00FF
        xba
        cmp wBattleAnimationYFixed,b,x
        bcs _CCB8
        lda #$0001
        bra _CCC5


        _CCB8
        lda wBattleAnimationYVelocity,b,x
        bmi _CCC2
        lda #$0000
        bra _CCC5


        _CCC2
        lda #$0002

        _CCC5
        jsr rsBattleAnimationStartPose

        _CCC8
        lda wBattleAnimationYVelocity,b,x
        sec
        sbc wBattleAnimationGravity,b,x
        sta wBattleAnimationYVelocity,b,x

        _CCD2
        ply
        plx
        rtl


        _CCD5
        lda bBattleAnimationStateFlags,b,x
        bit #$0010
        bne _CD3B
        lda wBattleAnimationYVelocity,b,x
        bne _CCE7
        lda wBattleAnimationYFixed,b,x
        beq _CD3B

        _CCE7
        lda wBattleAnimationYVelocity,b,x
        bmi _CCF7
        lda wBattleAnimationYVelocity,b,x
        clc
        adc wBattleAnimationYFixed,b,x
        bcc _CD2E
        bra _CD00


        _CCF7
        lda wBattleAnimationYVelocity,b,x
        clc
        adc wBattleAnimationYFixed,b,x
        bcs _CD2E

        _CD00
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$F7
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        and #$F7
        sta bBattleAnimationFacingFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        and #$DF
        sta bBattleAnimationFacingFlags,b,x
        lda bBattleAnimationCombatantFlags,b,x
        and #$FC
        ora #$02
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        stz wBattleAnimationYFixed,b,x
        stz wBattleAnimationYVelocity,b,x
        bra _CD3B


        _CD2E
        sta wBattleAnimationYFixed,b,x
        lda wBattleAnimationYVelocity,b,x
        sec
        sbc wBattleAnimationGravity,b,x
        sta wBattleAnimationYVelocity,b,x

        _CD3B
        ply
        plx
        rtl


        _CD3E
        lda bBattleAnimationStateFlags,b,x
        bit #$0010
        bne _CDA0
        lda wBattleAnimationYVelocity,b,x
        bne _CD50
        lda wBattleAnimationYFixed,b,x
        beq _CDA0

        _CD50
        lda wBattleAnimationYVelocity,b,x
        bmi _CD60
        lda wBattleAnimationYVelocity,b,x
        clc
        adc wBattleAnimationYFixed,b,x
        bcc _CD93
        bra _CD60


        _CD60
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$F7
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationCombatantFlags,b,x
        and #$7F
        sta bBattleAnimationCombatantFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        and #$DF
        sta bBattleAnimationFacingFlags,b,x
        lda bBattleAnimationStateFlags,b,x
        ora #$20
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationCombatantFlags,b,x
        and #$FC
        ora #$02
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        stz wBattleAnimationYVelocity,b,x
        bra _CDA0


        _CD93
        sta wBattleAnimationYFixed,b,x
        lda wBattleAnimationYVelocity,b,x
        sec
        sbc wBattleAnimationGravity,b,x
        sta wBattleAnimationYVelocity,b,x

        _CDA0
        ply
        plx
        rtl

        .databank 0

        ; 95/CDA3

      rlBattleAnimationUpdateYStep ; 95/CDA3

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves Y toward $0B04 by $0B13 a frame, then clears bit 4 of $0AF3.

        phx
        phy
        lda wBattleAnimationYStep,b,x
        bne _CDC4
        lda bBattleAnimationStateFlags,b,x
        bit #$0010
        bne _CDB6
        jml _CE43


        _CDB6
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$EF
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        bra _CE43


        _CDC4
        bmi _CDFB
        sta wR0
        lda wBattleAnimationYFixed,b,x
        sec
        sbc wR0
        bcc _CDDE
        sta wBattleAnimationYFixed,b,x
        xba
        and #$00FF
        cmp wBattleAnimationTargetY,b,x
        beq _CDDE
        bcs _CDF9

        _CDDE
        lda wBattleAnimationTargetY,b,x
        and #$00FF
        xba
        sta wBattleAnimationYFixed,b,x
        stz wBattleAnimationYStep,b,x
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$EF
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        bra _CDF9


        _CDF9
        bra _CE43


        _CDFB
        and #$7FFF
        sta wR0
        lda wBattleAnimationYFixed,b,x
        clc
        adc wR0
        bcs _CE16
        sta wBattleAnimationYFixed,b,x
        xba
        and #$00FF
        cmp wBattleAnimationTargetY,b,x
        beq _CE16
        bcc _CE43

        _CE16
        lda wBattleAnimationTargetY,b,x
        and #$00FF
        xba
        sta wBattleAnimationYFixed,b,x
        stz wBattleAnimationYStep,b,x
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$EF
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        and #$DF
        sta bBattleAnimationFacingFlags,b,x
        lda bBattleAnimationCombatantFlags,b,x
        and #$FC
        ora #$02
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        bra _CE43


        _CE43
        ply
        plx
        rtl

        .databank 0

        ; 95/CE46

      rlBattleAnimationFallToGround ; 95/CE46

        .al
        .xl
        .autsiz
        .databank ?

        ; The end of rlBattleAnimationUpdateJump for a slot in free X motion: adds the Y velocity until the slot reaches the ground ($5800), then stops it.

        lda wBattleAnimationYFixed,b,x
        clc
        adc wBattleAnimationYVelocity,b,x
        sta wBattleAnimationYFixed,b,x
        cmp #$5800
        bcc _CE5B
        stz wBattleAnimationYVelocity,b,x
        stz wBattleAnimationXSpeed,b,x

        _CE5B
        ply
        plx
        rtl

        .databank 0

        ; 95/CE5E

      rlBattleAnimationGetSpeed ; 95/CE5E

        .al
        .xl
        .autsiz
        .databank ?

        ; A pixels over wR0 frames as an 8.8 speed, at least 1 pixel a frame.

        phx
        phy
        sta wR13
        stz wR12
        lda wR0
        sta wR14
        stz wR15
        jsl rlUnsignedDivide32By32
        lda wR12+1
        bne _CE75
        lda #$0100

        _CE75
        ply
        plx
        rtl

        .databank 0

        ; 95/CE78

      rlBattleAnimationGetJumpArc ; 95/CE78

        .al
        .xl
        .autsiz
        .databank ?

        ; A jump arc of height A over wR0 frames: wR1 the starting upward
        ; velocity (4A / frames, 8.8) and wR0 the gravity (8A / frames squared);
        ; also sets $0B12.

        phx
        phy
        pha
        phx
        clc
        adc bBattleAnimationY,b,x
        and #$00FF
        sta wR10
        lda #$0099
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1
        plx
        sep #$20
        sta $0B12,b,x
        rep #$20
        pla
        asl a
        sta wR13
        stz wR12
        lda wR0
        lsr a
        sta wR14
        stz wR15
        jsl rlUnsignedDivide32By32
        lda wR12+1
        sta wR1
        lda wR0
        lsr a
        sta wR14
        stz wR15
        jsl rlUnsignedDivide32By32
        lda wR12+1
        sta wR0
        ply
        plx
        rtl

        .databank 0

        ; 95/CEBF

    .endsection Unsorted95CA88Section


    .section Unsorted95CEBFSection

      .al
      .xl

      rsBattleAnimationSetPathToOpponent ; 95/CEBF

        .al
        .xl
        .autsiz
        .databank ?

        ; Up to the opponent, keeping the combatant's spacing and the opponent's
        ; width (rlBattleAnimationGetPathMeasures), in the frames
        ; rlBattleAnimationGetTravelFrames gives at speed B (carry set) or A.

        phx
        php
        jsl rlBattleAnimationGetPathMeasures
        lda wR0
        cmp wR1
        bcc _CED3
        sec
        sbc wR8
        sec
        sbc wR7
        bra _CED9


        _CED3
        clc
        adc wR8
        clc
        adc wR7

        _CED9
        sta wR0
        lda wR1
        sec
        sbc wR0
        bpl _CEED
        eor #$FFFF
        inc a
        sta wR2
        lda #$8000
        bra _CEF2


        _CEED
        sta wR2
        lda #$0000

        _CEF2
        sta wR3
        lda wR2
        sta wR4
        plp
        jsl rlBattleAnimationGetTravelFrames
        sta wR0
        lda wR2
        jsl rlBattleAnimationGetSpeed
        ora wR3
        sta wBattleAnimationXSpeed,b,x
        sta wBattleAnimationXStartSpeed,b,x
        lda wR3
        bmi _CF19
        lda wBattleAnimationX,b,x
        clc
        adc wR2
        bra _CF1F


        _CF19
        lda wBattleAnimationX,b,x
        sec
        sbc wR2

        _CF1F
        pha
        lda wBattleAnimationXFixed,b,x
        sta wBattleAnimationTargetXFixed,b,x
        pla
        sta wBattleAnimationTargetX,b,x
        lda wR4
        plx
        rts

        .databank 0

        ; 95/CF2E

    .endsection Unsorted95CEBFSection


    .section Unsorted95CFA0Section

      .al
      .xl

      rsBattleAnimationSetPathToOpponentInFrames ; 95/CFA0

        .al
        .xl
        .autsiz
        .databank ?

        ; As rsBattleAnimationSetPathToOpponent, in A frames.

        phx
        pha
        jsl rlBattleAnimationGetPathMeasures
        lda wR0
        cmp wR1
        bcc _CFB4
        sec
        sbc wR8
        sec
        sbc wR7
        bra _CFBA


        _CFB4
        clc
        adc wR8
        clc
        adc wR7

        _CFBA
        sta wR0
        lda wR1
        sec
        sbc wR0
        bpl _CFCE
        eor #$FFFF
        inc a
        sta wR2
        lda #$8000
        bra _CFD3


        _CFCE
        sta wR2
        lda #$0000

        _CFD3
        sta wR3
        pla
        sta wR0
        lda wR2
        jsl rlBattleAnimationGetSpeed
        ora wR3
        sta wBattleAnimationXSpeed,b,x
        sta wBattleAnimationXStartSpeed,b,x
        lda wR3
        bmi _CFF2
        lda wBattleAnimationX,b,x
        clc
        adc wR2
        bra _CFF8


        _CFF2
        lda wBattleAnimationX,b,x
        sec
        sbc wR2

        _CFF8
        pha
        lda wBattleAnimationXFixed,b,x
        sta wBattleAnimationTargetXFixed,b,x
        pla
        sta wBattleAnimationTargetX,b,x
        lda wR4
        plx
        rts

        .databank 0

        ; 95/D007

    .endsection Unsorted95CFA0Section


    .section Unsorted95D078Section

      .al
      .xl

      rlBattleAnimationSetPathPastOpponent ; 95/D078

        .al
        .xl
        .autsiz
        .databank ?

        ; To the opponent's far side, by the spacing and the opponent's width,
        ; at speed B (carry set) or A.

        phx
        php
        jsl rlBattleAnimationGetPathMeasures
        lda wR1
        cmp wR0
        bcs _D08C
        sec
        sbc wR8
        sec
        sbc wR7
        bra _D092


        _D08C
        clc
        adc wR8
        clc
        adc wR7

        _D092
        sta wR1
        lda wR1
        sec
        sbc wR0
        bpl _D0A6
        eor #$FFFF
        inc a
        sta wR2
        lda #$8000
        bra _D0AB


        _D0A6
        sta wR2
        lda #$0000

        _D0AB
        sta wR3
        lda wR2
        sta wR4
        plp
        jsl rlBattleAnimationGetTravelFrames
        sta wR0
        lda wR2
        jsl rlBattleAnimationGetSpeed
        ora wR3
        sta wBattleAnimationXSpeed,b,x
        sta wBattleAnimationXStartSpeed,b,x
        lda wR3
        bmi _D0D2
        lda wBattleAnimationX,b,x
        clc
        adc wR2
        bra _D0D8


        _D0D2
        lda wBattleAnimationX,b,x
        sec
        sbc wR2

        _D0D8
        pha
        lda wBattleAnimationXFixed,b,x
        sta wBattleAnimationTargetXFixed,b,x
        pla
        sta wBattleAnimationTargetX,b,x
        lda wR4
        plx
        rtl

        .databank 0

        ; 95/D0E7

    .endsection Unsorted95D078Section


    .section Unsorted95D1C5Section

      .al
      .xl

      rlBattleAnimationGetPathMeasures ; 95/D1C5

        .al
        .xl
        .autsiz
        .databank ?

        ; wR0 the combatant's X, wR1 the opponent's, wR7 the opponent's width
        ; (rlBattleAnimationGetBodyWidth) and wR8 the combatant's spacing less 4
        ; (rlBattleAnimationGetSpacing).

        phx
        jsl rlBattleAnimationGetSpacing
        cmp #$0004
        bcc _D1D3
        sec
        sbc #$0004

        _D1D3
        sta wR8
        phx
        cpx #$0000
        bne _D1E0
        ldx #$0043
        bra _D1E3


        _D1E0
        ldx #$0000

        _D1E3
        jsl rlBattleAnimationGetBodyWidth
        sta wR7
        plx
        lda wBattleAnimationX,b,x
        sta wR0
        cpx #$0000
        beq _D1F9
        lda wBattleAnimationX,b
        bra _D1FC


        _D1F9
        lda wBattleAnimation2X,b

        _D1FC
        sta wR1
        plx
        rtl

        .databank 0

        ; 95/D200

    .endsection Unsorted95D1C5Section


    .section Unreferenced95D200Section

      .as
      .xl

      rsBattleAnimationAimYAtDefender ; 95/D200

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Found by tools/sweep.py: nothing in the build reaches this. Sets slot X's target Y to the defender's height and its Y step to cover the difference from the attacker's in its travel frames.

        jsl rlBattleAnimationGetTravelFrames
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
        bpl _D228
        eor #$FFFF
        inc a

        _D228
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

        ; 95/D23C

    .endsection Unreferenced95D200Section
    .section Unsorted95D2A4Section

      .al
      .xl

      rsBattleSceneScrollCameraRight ; 95/D2A4

        .al
        .xl
        .autsiz
        .databank ?

        ; A = 8.8 pixels: scrolls the camera right while the midpoint of the two followed X positions (lBattleSceneCameraAttackerX, lBattleSceneCameraDefenderX) is right of its center, at most to $C0. Carry set when it stopped there.

        phx
        phy
        sta wR9
        ldy #$0000
        lda lBattleSceneCameraAttackerX
        sta lR18
        lda lBattleSceneCameraAttackerX+1
        sta lR18+1
        lda [lR18],y
        sta wR7
        lda lBattleSceneCameraDefenderX
        sta lR18
        lda lBattleSceneCameraDefenderX+1
        sta lR18+1
        lda [lR18],y
        sta wR8
        lda wR7
        cmp wR8
        bcc _D2DC
        lda wR7
        sec
        sbc wR8
        lsr a
        clc
        adc wR8
        bra _D2E5


        _D2DC
        lda wR8
        sec
        sbc wR7
        lsr a
        clc
        adc wR7

        _D2E5
        sec
        sbc #$0080
        bcc _D31E
        cmp wBattleSceneCameraX
        bcc _D31E
        lda bBattleSceneCameraXFraction
        clc
        adc wR9
        sta bBattleSceneCameraXFraction
        lda wBattleSceneCameraX+1
        adc #$0000
        sep #$20
        sta wBattleSceneCameraX+1
        rep #$20
        lda wBattleSceneCameraX
        cmp #$00C0
        bcc _D31E
        lda #$00C0
        sta wBattleSceneCameraX
        sec
        bra _D31F


        _D31E
        clc

        _D31F
        ply
        plx
        rts

        .databank 0

        ; 95/D322

      rsBattleSceneScrollCameraLeft ; 95/D322

        .al
        .xl
        .autsiz
        .databank ?

        ; As rsBattleSceneScrollCameraRight, to the left (at least 0).

        phx
        phy
        sta wR9
        ldy #$0000
        lda lBattleSceneCameraAttackerX
        sta lR18
        lda lBattleSceneCameraAttackerX+1
        sta lR18+1
        lda [lR18],y
        sta wR7
        lda lBattleSceneCameraDefenderX
        sta lR18
        lda lBattleSceneCameraDefenderX+1
        sta lR18+1
        lda [lR18],y
        sta wR8
        lda wR7
        cmp wR8
        bcc _D35A
        lda wR7
        sec
        sbc wR8
        lsr a
        clc
        adc wR8
        bra _D363


        _D35A
        lda wR8
        sec
        sbc wR7
        lsr a
        clc
        adc wR7

        _D363
        sec
        sbc #$0080
        cmp wBattleSceneCameraX
        beq _D36F
        bcs _D39F

        _D36F
        lda wR9
        bmi _D38C
        lda bBattleSceneCameraXFraction
        sec
        sbc wR9
        sta bBattleSceneCameraXFraction
        sep #$20
        lda wBattleSceneCameraX+1
        sbc #$00
        sta wBattleSceneCameraX+1
        rep #$20

        _D38C
        lda wBattleSceneCameraX
        cmp #$0040
        bcs _D39F
        lda #$0040
        sta wBattleSceneCameraX
        sec
        bra _D3A0


        _D39F
        clc

        _D3A0
        ply
        plx
        rts

        .databank 0

        ; 95/D3A3

      rsBattleSceneScrollCameraRightToAttacker ; 95/D3A3

        .al
        .xl
        .autsiz
        .databank ?

        ; As rsBattleSceneScrollCameraRight, following the attacker's X alone.

        phx
        phy
        and #$7F00
        xba
        sta wR9
        lda bBattleAnimationFacingFlags,b,x
        bit #$0040
        beq _D41D
        ldy #$0000
        lda lBattleSceneCameraAttackerX
        sta lR18
        lda lBattleSceneCameraAttackerX+1
        sta lR18+1
        lda [lR18],y
        sta wR7
        lda lBattleSceneCameraAttackerX
        sta lR18
        lda lBattleSceneCameraAttackerX+1
        sta lR18+1
        lda [lR18],y
        sta wR8
        lda wR7
        cmp wR8
        bcc _D3E7
        lda wR7
        sec
        sbc wR8
        lsr a
        clc
        adc wR8
        bra _D3F0


        _D3E7
        lda wR8
        sec
        sbc wR7
        lsr a
        clc
        adc wR7

        _D3F0
        sec
        sbc #$0080
        bcc _D41D
        cmp wBattleSceneCameraX
        bcc _D41D
        lda wBattleSceneCameraX
        clc
        adc wR9
        cmp #$00C0
        bcc _D412
        lda wBattleSceneCameraX
        sec
        sbc #$00C0
        sta wR9

        _D412
        lda wBattleSceneCameraPan
        sec
        sbc wR9
        sta wBattleSceneCameraPan

        _D41D
        ply
        plx
        rts

        .databank 0

        ; 95/D420

      rsBattleSceneScrollCameraLeftToAttacker ; 95/D420

        .al
        .xl
        .autsiz
        .databank ?

        ; As rsBattleSceneScrollCameraLeft, following the attacker's X alone (at least $40).

        phx
        phy
        and #$7F00
        xba
        sta wR9
        lda bBattleAnimationFacingFlags,b,x
        bit #$0040
        beq _D49A
        ldy #$0000
        lda lBattleSceneCameraAttackerX
        sta lR18
        lda lBattleSceneCameraAttackerX+1
        sta lR18+1
        lda [lR18],y
        sta wR7
        lda lBattleSceneCameraAttackerX
        sta lR18
        lda lBattleSceneCameraAttackerX+1
        sta lR18+1
        lda [lR18],y
        sta wR8
        lda wR7
        cmp wR8
        bcc _D464
        lda wR7
        sec
        sbc wR8
        lsr a
        clc
        adc wR8
        bra _D46D


        _D464
        lda wR8
        sec
        sbc wR7
        lsr a
        clc
        adc wR7

        _D46D
        sec
        sbc #$0080
        cmp wBattleSceneCameraX
        beq _D479
        bcs _D49A

        _D479
        lda wBattleSceneCameraX
        sec
        sbc wR9
        cmp #$0040
        bcs _D48F
        lda #$0040
        sec
        sbc wBattleSceneCameraX
        sta wR9

        _D48F
        lda wBattleSceneCameraPan
        clc
        adc wR9
        sta wBattleSceneCameraPan

        _D49A
        ply
        plx
        rts

        .databank 0

        ; 95/D49D

      rsBattleSceneScrollCameraRightBy ; 95/D49D

        .al
        .xl
        .autsiz
        .databank ?

        ; A = 8.8 pixels: scrolls the camera right, at most to $C0, without checking where the combatants stand. Carry set when it stopped there.

        phx
        phy
        sta wR9
        ldy #$0000
        lda lBattleSceneCameraAttackerX
        sta lR18
        lda lBattleSceneCameraAttackerX+1
        sta lR18+1
        lda [lR18],y
        sta wR7
        lda lBattleSceneCameraDefenderX
        sta lR18
        lda lBattleSceneCameraDefenderX+1
        sta lR18+1
        lda [lR18],y
        sta wR8
        lda wR7
        cmp wR8
        bcc _D4D5
        lda wR7
        sec
        sbc wR8
        lsr a
        clc
        adc wR8
        bra _D4DE


        _D4D5
        lda wR8
        sec
        sbc wR7
        lsr a
        clc
        adc wR7

        _D4DE
        lda bBattleSceneCameraXFraction
        clc
        adc wR9
        sta bBattleSceneCameraXFraction
        lda wBattleSceneCameraX+1
        adc #$0000
        sep #$20
        sta wBattleSceneCameraX+1
        rep #$20
        lda wBattleSceneCameraX
        cmp #$00C0
        bcc _D50B
        lda #$00C0
        sta wBattleSceneCameraX
        sec
        bra _D50C


        _D50B
        clc

        _D50C
        ply
        plx
        rts

        .databank 0

        ; 95/D50F

      rsBattleSceneScrollCameraLeftBy ; 95/D50F

        .al
        .xl
        .autsiz
        .databank ?

        ; As rsBattleSceneScrollCameraRightBy, to the left (at least $40).

        phx
        phy
        sta wR9
        ldy #$0000
        lda lBattleSceneCameraAttackerX
        sta lR18
        lda lBattleSceneCameraAttackerX+1
        sta lR18+1
        lda [lR18],y
        sta wR7
        lda lBattleSceneCameraDefenderX
        sta lR18
        lda lBattleSceneCameraDefenderX+1
        sta lR18+1
        lda [lR18],y
        sta wR8
        lda wR7
        cmp wR8
        bcc _D547
        lda wR7
        sec
        sbc wR8
        lsr a
        clc
        adc wR8
        bra _D550


        _D547
        lda wR8
        sec
        sbc wR7
        lsr a
        clc
        adc wR7

        _D550
        lda bBattleSceneCameraXFraction
        sec
        sbc wR9
        sta bBattleSceneCameraXFraction
        sep #$20
        lda wBattleSceneCameraX+1
        sbc #$00
        sta wBattleSceneCameraX+1
        rep #$20
        lda wBattleSceneCameraX
        cmp #$0040
        bcs _D57C
        lda #$0040
        sta wBattleSceneCameraX
        sec
        bra _D57D


        _D57C
        clc

        _D57D
        ply
        plx
        rts

        .databank 0

        ; 95/D580

      rsBattleSceneUpdateStageScroll ; 95/D580

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame (not with bit 0 of $7FF5AF): steps the camera by wBattleSceneCameraPan (1 or 2 pixels a frame, between $40 and $C0), then, unless bit 2 of bBattleSceneBackgroundFlags, sets BG2's scroll from the camera plus $7FE19F/$7FE1A1, raising the stage as the attacker rises ($7FE19A, 0-$38 for Y $18-$50).

        lda $7FF5AF
        bit #$0001
        beq _D58D
        jml _D66F


        _D58D
        lda wBattleSceneCameraPan
        beq _D5F7
        bmi _D5C7
        cmp #$0004
        bcc _D5AC
        sec
        sbc #$0002
        sta wBattleSceneCameraPan
        lda wBattleSceneCameraX
        sec
        sbc #$0002
        bra _D5B6


        _D5AC
        dec a
        sta wBattleSceneCameraPan
        lda wBattleSceneCameraX
        dec a

        _D5B6
        and #$01FF
        cmp #$0040
        bcs _D5C1
        lda #$0040

        _D5C1
        sta wBattleSceneCameraX
        bra _D5F7


        _D5C7
        cmp #$FFFD
        bcs _D5DE
        clc
        adc #$0002
        sta wBattleSceneCameraPan
        lda wBattleSceneCameraX
        clc
        adc #$0002
        bra _D5E8


        _D5DE
        inc a
        sta wBattleSceneCameraPan
        lda wBattleSceneCameraX
        inc a

        _D5E8
        and #$01FF
        cmp #$00C0
        bcc _D5F3
        lda #$00C0

        _D5F3
        sta wBattleSceneCameraX

        _D5F7
        lda bBattleSceneBackgroundFlags
        bit #$0004
        bne _D66F
        lda wBattleSceneCameraX
        clc
        adc $7FE19F
        sta wBufferBG2HOFS
        phx
        lda bBattleSceneAttackerSide,b
        bit #$0080
        bne _D619
        ldx #$0000
        bra _D61C


        _D619
        ldx #$0043

        _D61C
        lda wBattleAnimationYFixed,b,x
        cmp #$1800
        bcs _D629
        lda #$0000
        bra _D638


        _D629
        cmp #$5000
        bcc _D633
        lda #$0038
        bra _D638


        _D633
        xba
        sec
        sbc #$0018

        _D638
        sep #$20
        sta wBattleSceneCameraY
        eor #$FF
        inc a
        sta wBufferBG2VOFS
        beq _D64B
        lda #$01
        sta wBufferBG2VOFS+1
        bra _D64D


        _D64B
        stz wBufferBG2VOFS+1

        _D64D
        rep #$20
        lda wBufferBG2VOFS
        sec
        sbc #$0080
        and #$01FF
        eor #$0100
        clc
        adc $7FE1A1
        sta wBufferBG2VOFS
        plx
        lda wBufferBG2HOFS
        sta wBattleSceneCameraY+1
        lda wBufferBG2VOFS
        sta $7FE19D

        _D66F
        rts

        .databank 0

        ; 95/D670

      rsBattleSceneUpdateBG1Scroll ; 95/D670

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame with bit 1 of $7FE1B3: scrolls BG1 from the camera and BG2's vertical scroll (a slower layer behind the stage).

        phx
        phy
        lda bBattleSceneBackgroundFlags
        bit #$0002
        beq _D6AF
        lda wBattleSceneCameraX
        sec
        sbc #$0040
        pha
        sta wR13
        lda #$0001
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wR13
        clc
        adc #1,s
        sta wBufferBG1HOFS
        pla
        lda #$0080
        sec
        sbc wBufferBG2VOFS
        sta wR13
        lda #$0007
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wBufferBG2VOFS
        sec
        sbc wR13
        sta wBufferBG1VOFS

        _D6AF
        ply
        plx
        rts

        .databank 0

        ; 95/D6B2

      rlBattleSceneCheckCombatant1OnScreen ; 95/D6B2

        .al
        .xl
        .autsiz
        .databank ?

        ; When combatant 1 stands outside the screen's middle (32-224) sets a camera pan toward it (bBattleSceneCameraPan) and returns carry clear.

        lda wBattleAnimationX,b
        sta wBattleSceneCheckX
        lda #$0003
        jsl rlBattleSceneCheckOnScreen
        sep #$20
        lda $7FE1A3
        and #$FE
        sta $7FE1A3
        rep #$20
        rtl

        .databank 0

        ; 95/D6CF

      rlBattleSceneCheckCombatant2OnScreen ; 95/D6CF

        .al
        .xl
        .autsiz
        .databank ?

        ; rlBattleSceneCheckCombatant1OnScreen for combatant 2.

        lda wBattleAnimation2X,b
        sta wBattleSceneCheckX
        lda #$0003
        jsl rlBattleSceneCheckOnScreen
        sep #$20
        lda $7FE1A3
        and #$FE
        sta $7FE1A3
        rep #$20
        rtl

        .databank 0

        ; 95/D6EC

      rlBattleSceneCheckOnScreen ; 95/D6EC

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set when the X in wBattleSceneCheckX is 32-224 on screen; otherwise bBattleSceneCameraPan is the signed distance to pan.

        pha
        lda wBattleSceneCheckX
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        bit #$8000
        bne _D710
        cmp #$00E1
        bcs _D70B
        cmp #$0020
        bcc _D710
        pla
        bra _D71F


        _D70B
        pla
        sep #$20
        bra _D716


        _D710
        .al
        pla
        sep #$20
        eor #$FF
        inc a

        _D716
        sta bBattleSceneCameraPan
        rep #$20
        clc
        bra _D720


        _D71F
        sec

        _D720
        rtl

        .databank 0

        ; 95/D721

      rlBattleSceneRunCameraPan ; 95/D721

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: scrolls the camera by bBattleSceneCameraPan until it stops at an end; then clears the pan and, with bit 0 of $7FE1A3, counts down bBattleSceneScriptWaitCount.

        phx
        lda bBattleSceneCameraPan
        and #$00FF
        beq _D77A
        xba
        bit #$8000
        bne _D740
        pha
        xba
        and #$00FF
        pha
        pla
        pla
        jsr rsBattleSceneScrollCameraRightBy
        bcs _D75D
        bra _D77A


        _D740
        pha
        xba
        and #$00FF
        ora #$FF00
        eor #$FFFF
        inc a
        pha
        pla
        pla
        eor #$FF00
        clc
        adc #$0100
        jsr rsBattleSceneScrollCameraLeftBy
        bcs _D75D
        bra _D77A


        _D75D
        sep #$20
        lda #$00
        sta bBattleSceneCameraPan
        lda $7FE1A3
        bit #$01
        beq _D778
        lda bBattleSceneScriptWaitCount
        beq _D778
        dec a
        sta bBattleSceneScriptWaitCount

        _D778
        rep #$20

        _D77A
        plx
        rtl

        .databank 0

        ; 95/D77C

      rsBattleSceneDrawShadows ; 95/D77C

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: draws each combatant's first frame record at its ground position (wBattleAnimationYAnchor, ignoring its height) with its attributes, combatant 1 on even frames and combatant 2 on odd ones, unless hidden (bit 6 of bBattleAnimationCombatantFlags).

        phx
        phy
        lda $7FFC77
        bit #$0001
        beq _D78E
        lda $7FFC7A
        sta wNextFreeSpriteOffset,b

        _D78E
        ldx #$0000

        _D791
        lda bBattleAnimationStateFlags,b,x
        bit #$0080
        bne _D79D
        jml _D851


        _D79D
        lda bBattleAnimationCombatantFlags,b,x
        bit #$0040
        beq _D7A9
        jml _D851


        _D7A9
        cpx #$0000
        bne _D7BD
        lda wBattleSceneFrame
        bit #$0001
        beq _D7BB
        jml _D851


        _D7BB
        bra _D7CA


        _D7BD
        lda wBattleSceneFrame
        bit #$0001
        bne _D7CA
        jml _D851


        _D7CA
        rep #$20
        lda wBattleAnimationX,b,x
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        sta wR0
        sep #$20
        lda bBattleAnimationDrawOffsetX,b,x
        bmi _D7E7
        rep #$20
        and #$00FF
        bra _D7EC


        _D7E7
        .as
        rep #$20
        ora #$FF00

        _D7EC
        clc
        adc wR0
        jsl rlBattleSceneNoOp1
        sta wR0
        lda wBattleAnimationYAnchor,b,x
        xba
        clc
        adc wBattleSceneCameraY
        and #$00FF
        sta wR1
        lda wBattleAnimationBaseTile,b,x
        and #$7FFF
        sta wR4
        lda bBattleAnimationAttributes,b,x
        and #$00FF
        xba
        sta wR5
        sep #$20
        phb
        lda lBattleAnimationFrameDataPointer+2,b,x
        pha
        plb
        .databank ?
        rep #$20
        lda lBattleAnimationFrameDataPointer+1,b,x
        sta lR18+1
        lda lBattleAnimationFrameDataPointer,b,x
        sta lR18
        sta wR9
        ldy #$0002
        lda [lR18],y
        clc
        adc lR18
        sta lR18
        ldy #$0000
        lda [lR18],y
        clc
        adc wR9
        inc a
        tay
        phx
        lda wBattleAnimationBaseTile,b,x
        bit #$8000
        bne _D84A
        clc
        bra _D84B


        _D84A
        sec

        _D84B
        jsl rlBattleScenePushSprites
        plx
        plb
        .databank ?

        _D851
        txa
        clc
        adc #$0043
        tax
        cpx #$0086
        bcs _D860
        jml _D791


        _D860
        ply
        plx
        rts

        .databank 0

        ; 95/D863

      rlBattleSceneDrawAfterimages ; 95/D863

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: rsBattleSceneUpdateAfterimages.

        jsr rsBattleSceneUpdateAfterimages
        rtl

        .databank 0

        ; 95/D867

      rsBattleSceneUpdateAfterimages ; 95/D867

        .al
        .xl
        .autsiz
        .databank ?

        ; For each of the two afterimages that is on: shifts its 16 past positions, records its owner's position, and draws it (rsBattleSceneDrawAfterimage).

        phx
        phy
        ldx #$0000

        _D86C
        phx
        lda aBattleSceneAfterimages.Flags,b,x
        bit #$0001
        beq _D8C1
        lda #$0000
        sta lR18+1
        sta lR19+1
        txa
        clc
        adc #$0C48
        sta lR18
        clc
        adc #$0003
        sta lR19
        ldy #$0000

        _D88C
        lda [lR19],y
        sta [lR18],y
        inc y
        lda [lR19],y
        sta [lR18],y
        inc y
        inc y
        cpy #$002D
        bcc _D88C
        phx
        lda aBattleSceneAfterimages.Owner,b,x
        tax
        lda wBattleAnimationX,b,x
        sta lR18
        sep #$20
        lda wBattleAnimationYAnchor+1,b,x
        sec
        sbc bBattleAnimationY,b,x
        sta lR18+2
        rep #$20
        plx
        lda lR18
        sta $0C75,b,x
        lda lR18+1
        sta $0C76,b,x
        jsr rsBattleSceneDrawAfterimage

        _D8C1
        plx
        txa
        clc
        adc #$0033
        tax
        cpx #$0066
        bcc _D86C
        ply
        plx
        rts

        .databank 0

        ; 95/D8D0

      rsBattleSceneDrawAfterimage ; 95/D8D0

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the afterimage ($00 or $33): draws its owner's pose at its position 8 or 12 frames back, alternating each frame.

        phb
        phx
        phy
        rep #$20
        phx
        sep #$20
        lda aBattleSceneAfterimages.Flags,b,x
        eor #$02
        sta aBattleSceneAfterimages.Flags,b,x
        bit #$02
        bne _D8EE
        rep #$20
        txa
        clc
        adc #$0018
        tax
        bra _D8F6


        _D8EE
        .as
        rep #$20
        txa
        clc
        adc #$0024
        tax

        _D8F6
        lda aBattleSceneAfterimages.Positions,b,x
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        sta wR0
        phx
        lda #3,s
        tax
        lda wR0
        jsl rlBattleSceneNoOp1
        sta wR0
        plx
        lda $0C49,b,x
        and #$FF00
        xba
        clc
        adc wBattleSceneCameraY
        and #$00FF
        sta wR1
        plx
        lda aBattleSceneAfterimages.Owner,b,x
        tax
        lda bBattleAnimationPoseID,b,x
        and #$00FF
        cmp #$00FE
        beq _D95F
        lda wBattleAnimationBaseTile,b,x
        and #$7FFF
        sta wR4
        lda wBattleAnimationBaseTile+1,b,x
        and #$FF00
        sta wR5
        sep #$20
        lda lBattleAnimationFrameDataPointer+2,b,x
        pha
        plb
        .databank ?
        rep #$20
        jsr rsBattleAnimationGetPoseRecord
        inc a
        tay
        lda wBattleAnimationBaseTile,b,x
        bit #$8000
        bne _D95A
        clc
        bra _D95B


        _D95A
        sec

        _D95B
        jsl rlBattleScenePushSprites

        _D95F
        ply
        plx
        plb
        .databank ?
        rts

        .databank 0

        ; 95/D963

      rlBattleAnimationStartAfterimage ; 95/D963

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the owner, A = the afterimage (0 or 1): fills its past positions with the owner's position and turns it on (sequence command $EC 1).

        phx
        phy
        pha
        lda wBattleAnimationX,b,x
        sta lR18
        sep #$20
        lda wBattleAnimationYAnchor+1,b,x
        sec
        sbc bBattleAnimationY,b,x
        sta lR18+2
        rep #$20
        pla
        sep #$20
        sta $4202,b
        lda #$33
        sta $4203,b
        nop
        nop
        rep #$20
        lda #$0000
        sta lR19+1
        lda $4216,b
        clc
        adc #$0C48
        sta lR19
        txa
        ldx $4216,b
        sta aBattleSceneAfterimages.Owner,b,x
        ldy #$0000

        _D99F
        lda lR18
        sta [lR19],y
        inc y
        lda lR18+1
        sta [lR19],y
        inc y
        inc y
        cpy #$0030
        bcc _D99F
        sep #$20
        lda aBattleSceneAfterimages.Flags,b,x
        ora #$01
        sta aBattleSceneAfterimages.Flags,b,x
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 95/D9BE

      rlBattleAnimationStopAfterimage ; 95/D9BE

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the afterimage (0 or 1): turns it off (sequence command $EC 0).

        phx
        sep #$20
        sta $4202,b
        lda #$33
        sta $4203,b
        nop
        nop
        nop
        nop
        ldx $4216,b
        lda aBattleSceneAfterimages.Flags,b,x
        and #$FE
        sta aBattleSceneAfterimages.Flags,b,x
        rep #$20
        plx
        rtl

        .databank 0

        ; 95/D9DC

      rlBattleAnimationGetMirroredX ; 95/D9DC

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the slot, A = its X: with bit 7 of its bBattleAnimationFacingFlags (sequence command $EC 3), on odd frames returns carry set and A mirrored around the defender's X, so the slot appears on both sides of it. Otherwise carry clear.

        phx
        pha
        lda bBattleAnimationFacingFlags,b,x
        bit #$0080
        beq _DA07
        lda wBattleSceneFrame
        bit #$0001
        beq _DA07
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        and #$01FF
        sec
        sbc #1,s
        clc
        adc wBattleAnimationX,b,x
        and #$01FF
        sta #1,s
        sec
        bra _DA08


        _DA07
        clc

        _DA08
        pla
        plx
        rtl

        .databank 0

        ; 95/DA0B

    .endsection Unsorted95D2A4Section


    .section Unsorted95DA0BSection

      .al
      .xl

      rlBattleAnimationClearMoveQueues ; 95/DA0B

        .al
        .xl
        .autsiz
        .databank ?

        ; Empties both combatants' move queues ($7FE144, 16 words each).

        ldx #$0000
        lda #$FFFF

        _DA11
        sta aBattleSceneMoveQueues,x
        inc x
        inc x
        cpx #$0040
        bcc _DA11
        rtl

        .databank 0

        ; 95/DA1D

    .endsection Unsorted95DA0BSection


    .section Unsorted95DA1DSection

      .al
      .xl

      rlBattleAnimationRunMoveQueue ; 95/DA1D

        .al
        .xl
        .autsiz
        .databank ?

        ; Takes the next move of each combatant whose last one is done: its
        ; movement (rlBattleAnimationStartMovement) and its sequence
        ; (rlBattleAnimationStartSequence).

        stz bBattleSceneQueuesIdle,b
        jsr rsBattleAnimationTakeMove1
        bcs _DA39
        pha
        ldx #$0000
        jsl rlBattleAnimationStartMovement
        pla
        and #$FF00
        pha
        jsl rlBattleAnimationStartSequence
        pla
        bra _DA8F


        _DA39
        jsr rsBattleAnimationTakeMove2
        bcs _DA55
        pha
        ldx #$0043
        jsl rlBattleAnimationStartMovement
        pla
        and #$FF00
        ora #$0001
        pha
        jsl rlBattleAnimationStartSequence
        pla
        bra _DA8F


        _DA55
        lda bBattleSceneQueuesIdle,b
        and #$0003
        cmp #$0003
        bne _DA97
        phx
        ldx #$0086
        lda bBattleAnimationStateFlags,b,x
        bit #$0080
        beq _DA6F
        sec
        bra _DA7E


        _DA6F
        ldx #$00C9
        lda bBattleAnimationStateFlags,b,x
        bit #$0080
        beq _DA7D
        sec
        bra _DA7E


        _DA7D
        clc

        _DA7E
        plx
        bcs _DA97
        sep #$20
        lda bBattleSceneStrikeFlags,b
        ora #$01
        sta bBattleSceneStrikeFlags,b
        rep #$20
        bra _DA97


        _DA8F
        xba
        sep #$20
        sta bBattleAnimationPoseOffset,b,x
        rep #$20

        _DA97
        rtl

        .databank 0

        ; 95/DA98

      rsBattleAnimationTakeMove1 ; 95/DA98

        .al
        .xl
        .autsiz
        .databank ?

        ; When combatant 1 stands ready (no X speed or Y velocity, its sequence done or frozen): takes its next queued move and returns carry clear with it in A. With an empty queue sets bit 0 of bBattleSceneQueuesIdle; carry set.

        lda bBattleAnimationStateFlags,b
        bit #$0080
        bne _DAA2
        bra _DADF


        _DAA2
        lda wBattleAnimationXSpeed,b
        bit #$7FFF
        bne _DADF
        lda wBattleAnimationYVelocity,b
        bne _DADF
        lda bBattleAnimationFacingFlags,b
        bit #$0020
        bne _DADF
        lda bBattleAnimationStateFlags,b
        bit #$0020
        beq _DAC7
        lda bBattleAnimationFacingFlags,b
        bit #$0040
        bne _DACF

        _DAC7
        lda bBattleAnimationStateFlags,b
        bit #$0001
        bne _DADF

        _DACF
        clc
        jsl rlBattleAnimationTakeQueuedMove
        bcc _DAE0
        lda bBattleSceneQueuesIdle,b
        ora #$0001
        sta bBattleSceneQueuesIdle,b

        _DADF
        sec

        _DAE0
        rts

        .databank 0

        ; 95/DAE1

      rsBattleAnimationTakeMove2 ; 95/DAE1

        .al
        .xl
        .autsiz
        .databank ?

        ; rsBattleAnimationTakeMove1 for combatant 2 (bit 1 of bBattleSceneQueuesIdle).

        lda bBattleAnimation2StateFlags,b
        bit #$0080
        bne _DAEB
        bra _DB28


        _DAEB
        lda wBattleAnimation2XSpeed,b
        bit #$7FFF
        bne _DB28
        lda wBattleAnimation2YVelocity,b
        bne _DB28
        lda bBattleAnimation2FacingFlags,b
        bit #$0020
        bne _DB28
        lda bBattleAnimation2StateFlags,b
        bit #$0020
        beq _DB10
        lda bBattleAnimation2FacingFlags,b
        bit #$0040
        bne _DB18

        _DB10
        lda bBattleAnimation2StateFlags,b
        bit #$0001
        bne _DB28

        _DB18
        sec
        jsl rlBattleAnimationTakeQueuedMove
        bcc _DB29
        lda bBattleSceneQueuesIdle,b
        ora #$0002
        sta bBattleSceneQueuesIdle,b

        _DB28
        sec

        _DB29
        rts

        .databank 0

        ; 95/DB2A

      rlBattleAnimationQueueMove ; 95/DB2A

        .al
        .xl
        .autsiz
        .databank ?

        ; Adds A to the queue of the first combatant (carry clear) or the
        ; second; carry set if it is full.

        phx
        phy
        bcs _DB33
        ldx #$0000
        bra _DB36


        _DB33
        ldx #$0020

        _DB36
        pha
        ldy #$0010

        _DB3A
        lda aBattleSceneMoveQueues,x
        cmp #$FFFF
        beq _DB4C
        inc x
        inc x
        dec y
        bne _DB3A
        pla
        sec
        bra _DB52


        _DB4C
        pla
        sta aBattleSceneMoveQueues,x
        clc

        _DB52
        ply
        plx
        rtl

        .databank 0

        ; 95/DB55

      rlBattleAnimationTakeQueuedMove ; 95/DB55

        .al
        .xl
        .autsiz
        .databank ?

        ; Takes the next word from the queue of the first combatant (carry
        ; clear) or the second; carry set if it is empty.

        phx
        phy
        bcs _DB5E
        ldx #$0000
        bra _DB61


        _DB5E
        ldx #$0020

        _DB61
        lda aBattleSceneMoveQueues,x
        cmp #$FFFF
        bne _DB6D
        sec
        bra _DB87


        _DB6D
        pha
        ldy #$000F

        _DB71
        lda $7FE146,x
        sta aBattleSceneMoveQueues,x
        inc x
        inc x
        dec y
        bne _DB71
        lda #$FFFF
        sta aBattleSceneMoveQueues,x
        pla
        clc

        _DB87
        ply
        plx
        rtl

        .databank 0

        ; 95/DB8A

      rlBattleAnimationQueueMoveList ; 95/DB8A

        .al
        .xl
        .autsiz
        .databank ?

        ; Queues move list A of the list table in lR19, up to its $7F byte.

        phx
        phy
        asl a
        tay
        lda [lR19],y
        tay
        cpx #$0000
        bne _DBAB

        _DB96
        sep #$20
        lda [lR19],y
        cmp #$7F
        beq _DBC0
        rep #$20
        lda [lR19],y
        clc
        jsl rlBattleAnimationQueueMove
        inc y
        inc y
        bra _DB96


        _DBAB
        sep #$20
        lda [lR19],y
        cmp #$7F
        beq _DBC0
        rep #$20
        lda [lR19],y
        sec
        jsl rlBattleAnimationQueueMove
        inc y
        inc y
        bra _DBAB


        _DBC0
        .as
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 95/DBC5

      rlBattleAnimationQueueSequence ; 95/DBC5

        .al
        .xl
        .autsiz
        .databank ?

        ; Queues sequence A without movement ($7E).

        phx
        phy
        xba
        sep #$20
        lda #$7E
        rep #$20
        cpx #$0000
        bne _DBD6
        clc
        bra _DBD7


        _DBD6
        sec

        _DBD7
        jsl rlBattleAnimationQueueMove
        ply
        plx
        rtl

        .databank 0

        ; 95/DBDE

      rlBattleAnimationSetEffectMotion ; 95/DBDE

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the combatant, A = its AnimStyle, wR0 its weapon: sets the motion of its effect slot ($86 or $C9) and sets it up: 0 (straight) for style $3x, 1 for $5x, 2 (a path) for $6x, and 3 (a path script) for the rest and for style $3x with weapons $3A-$3D.

        pha
        phx
        phy
        cpx #$0000
        bne _DBEB
        ldx #$0086
        bra _DBEE


        _DBEB
        ldx #$00C9

        _DBEE
        and #$00F0
        cmp #$0030
        bne _DC11
        lda wR0
        cmp #$003A
        beq _DC25
        cmp #$003B
        beq _DC25
        cmp #$003C
        beq _DC25
        cmp #$003D
        beq _DC25
        lda #$0000
        bra _DC28


        _DC11
        cmp #$0050
        bne _DC1B
        lda #$0001
        bra _DC28


        _DC1B
        cmp #$0060
        bne _DC25
        lda #$0002
        bra _DC28


        _DC25
        lda #$0003

        _DC28
        sep #$20
        pha
        lda bBattleAnimationMotionFlags,b,x
        and #$FC
        ora #1,s
        sta bBattleAnimationMotionFlags,b,x
        pla
        rep #$20
        sta wR0
        txy
        phb
        php
        phk
        plb
        .databank $95
        lda wR0
        asl a
        tax
        jsr (aBattleAnimationEffectSetups,x)
        plp
        plb
        .databank $95
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/DC4C

    .endsection Unsorted95DA1DSection


    .section Table95DC4CSection

      .al
      .xl

      aBattleAnimationEffectSetups ; 95/DC4C

        ; Jump table of rlBattleAnimationSetEffectMotion.
        .word <>rsBattleAnimationSetupFlyingEffect
        .word <>rsBattleAnimationSetupFlyingEffect
        .word <>rsBattleAnimationSetupPathEffect
        .word <>rsBattleAnimationSetupPathScriptEffect

    .endsection Table95DC4CSection


    .section Unsorted95DC54Section

      .al
      .xl

      rsBattleAnimationSetupFlyingEffect ; 95/DC54

        .al
        .xl
        .autsiz
        .databank ?

        ; Y = the effect slot: role 1 (motions 0 and 1).

        phx
        tyx
        sep #$20
        lda #$01
        sta bBattleAnimationRole,b,x
        rep #$20
        plx
        rts

        .databank 0

        ; 95/DC61

      rsBattleAnimationSetupPathEffect ; 95/DC61

        .al
        .xl
        .autsiz
        .databank ?

        ; Y = the effect slot: starts its path at the beginning, its X step the combatants' gap * 2, role 1 (motion 2).

        phx
        tyx
        lda #$0000
        sta wBattleAnimationSecondaryOffset,b,x
        jsl rlBattleSceneGetCombatantGap
        lda wR0
        asl a
        asl a
        asl a
        asl a
        sta wR13
        lda #$0008
        sta wR14
        phx
        jsl rlUnsignedDivide16By16R13
        plx
        lda wR13
        sta lBattleAnimationSecondaryPointer2,b,x
        sep #$20
        lda #$01
        sta bBattleAnimationRole,b,x
        rep #$20
        plx
        rts

        .databank 0

        ; 95/DC90

    .endsection Unsorted95DC54Section


    .section Unsorted95DC90Section

      .al
      .xl

      rsBattleAnimationSetupPathScriptEffect ; 95/DC90

        .al
        .xl
        .autsiz
        .databank ?

        ; Y = the effect slot: starts its path script at the beginning, role 4 (motion 3).

        phx
        tyx
        lda #$0000
        sta wBattleAnimationSecondaryOffset,b,x
        sep #$20
        lda #$04
        sta bBattleAnimationRole,b,x
        rep #$20
        plx
        rts

        .databank 0

        ; 95/DCA3

    .endsection Unsorted95DC90Section


    .section Unsorted95DCA3Section

      .al
      .xl

      rsBattleAnimationSpawnEffect1 ; 95/DCA3

        .al
        .xl
        .autsiz
        .databank ?

        ; A = sequence: starts combatant 1's effect slot (slot 2) at its start offset (rlBattleAnimationGetEffectStart), aimed at the defender (rsBattleAnimationAimEffect).

        phx
        and #$001F
        pha
        jsl rlBattleAnimationResetSpawnSlot
        pla
        pha
        sep #$20
        sta bBattleAnimationSpawnPoseOffset,b
        rep #$20
        lda lBattleAnimationFrameDataPointer+1,b
        sta lBattleAnimationSpawnFrameDataPointer+1,b
        lda lBattleAnimationFrameDataPointer,b
        sta lBattleAnimationSpawnFrameDataPointer,b
        lda wBattleAnimationX,b
        sta wR0
        lda wBattleAnimationXFixed,b
        sta wBattleAnimationSpawnXFixed,b
        lda wBattleAnimationYAnchor,b
        sta wBattleAnimationSpawnYAnchor,b
        lda wBattleAnimationYFixed,b
        sta wR1
        lda #$0000
        sta wBattleAnimationSpawnBaseTile,b
        sep #$20
        lda $0B7D,b
        sta bBattleAnimationSpawnRole,b
        rep #$20
        lda aBattleSceneCombatant1.AnimStyle,b
        sta wR2
        lda aBattleSceneCombatant1.Class,b
        jsl rlBattleAnimationGetEffectStart
        pha
        and #$00FF
        bit #$0080
        beq _DCFF
        ora #$FF00

        _DCFF
        pha
        jsl rlBattleAnimationCompareCombatantX
        pla
        bcs _DD0B
        eor #$FFFF
        inc a

        _DD0B
        clc
        adc wR0
        sta wBattleAnimationSpawnX,b
        pla
        and #$FF00
        clc
        adc wR1
        sta wBattleAnimationSpawnYFixed,b
        lda #$0000
        jsr rsBattleAnimationAimEffect
        lda #$0002
        jsl rlBattleAnimationCopySpawnSlot
        lda $0B7D,b
        and #$00FF
        cmp #$0004
        bcc _DD41
        pla
        xba
        sep #$20
        lda #$02
        rep #$20
        jsl rlBattleAnimationStartSequence2
        bra _DD4D


        _DD41
        pla
        xba
        sep #$20
        lda #$02
        rep #$20
        jsl rlBattleAnimationStartSequence

        _DD4D
        plx
        rts

        .databank 0

        ; 95/DD4F

      rsBattleAnimationSpawnEffect2 ; 95/DD4F

        .al
        .xl
        .autsiz
        .databank ?

        ; The same for combatant 2's effect slot (slot 3).

        phx
        and #$001F
        pha
        jsl rlBattleAnimationResetSpawnSlot
        pla
        pha
        sep #$20
        sta bBattleAnimationSpawnPoseOffset,b
        rep #$20
        lda lBattleAnimation2FrameDataPointer+1,b
        sta lBattleAnimationSpawnFrameDataPointer+1,b
        lda lBattleAnimation2FrameDataPointer,b
        sta lBattleAnimationSpawnFrameDataPointer,b
        lda wBattleAnimation2X,b
        sta wR0
        lda wBattleAnimation2XFixed,b
        sta wBattleAnimationSpawnXFixed,b
        lda wBattleAnimation2YAnchor,b
        sta wBattleAnimationSpawnYAnchor,b
        lda wBattleAnimation2YFixed,b
        sta wR1
        lda #$8100
        sta wBattleAnimationSpawnBaseTile,b
        sep #$20
        lda $0BC0,b
        sta bBattleAnimationSpawnRole,b
        rep #$20
        lda aBattleSceneCombatant2.AnimStyle,b
        sta wR2
        lda aBattleSceneCombatant2.Class,b
        jsl rlBattleAnimationGetEffectStart
        pha
        and #$00FF
        bit #$0080
        beq _DDAB
        ora #$FF00

        _DDAB
        pha
        jsl rlBattleAnimationCompareCombatantX
        pla
        bcc _DDB7
        eor #$FFFF
        inc a

        _DDB7
        clc
        adc wR0
        sta wBattleAnimationSpawnX,b
        pla
        and #$FF00
        clc
        adc wR1
        sta wBattleAnimationSpawnYFixed,b
        lda #$8000
        jsr rsBattleAnimationAimEffect
        lda #$0003
        jsl rlBattleAnimationCopySpawnSlot
        lda $0BC0,b
        and #$00FF
        cmp #$0004
        bcc _DDED
        pla
        xba
        sep #$20
        lda #$03
        rep #$20
        jsl rlBattleAnimationStartSequence2
        bra _DDF9


        _DDED
        pla
        xba
        sep #$20
        lda #$03
        rep #$20
        jsl rlBattleAnimationStartSequence

        _DDF9
        plx
        rts

        .databank 0

        ; 95/DDFB

      rlBattleAnimationEndEffectSlot ; 95/DDFB

        .al
        .xl
        .autsiz
        .databank ?

        ; X = an effect slot ($86 or $C9): stops it and signals the combatant other than its owner (slot $86 belongs to combatant 1, $C9 to combatant 2).

        phx
        jsl rlBattleAnimationClearSlot
        txa
        sec
        sbc #$0086
        tax
        jsl rlBattleAnimationSignalOther
        plx
        rtl

        .databank 0

        ; 95/DE0C

      rsBattleAnimationAimEffect ; 95/DE0C

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the spawn slot's X speed toward the defender (rlBattleAnimationGetEffectSpeed), its Y step to the defender's hit height (rsBattleAnimationSetEffectYStep) and its jump arc (rlBattleAnimationGetEffectArcHeight).

        pha
        pha
        jsl rlBattleSceneGetCombatantGap
        lda wR0
        sta wR1
        lda #1,s
        asl a
        jsl rlBattleAnimationGetEffectSpeed
        pha
        sta wR0
        lda wR1
        jsl rlBattleAnimationGetSpeed
        sta wR0
        pla
        sta wR1
        jsl rlBattleAnimationCompareCombatantX
        bcc _DE37
        pla
        eor #$8000
        bra _DE38


        _DE37
        pla

        _DE38
        ora wR1
        sta wBattleAnimationSpawnXSpeed,b
        pla
        pha
        sta wR1
        lda wR0
        pha
        lda wR1
        jsr rsBattleAnimationSetEffectYStep
        pla
        sta wR0
        pla
        asl a
        jsl rlBattleAnimationGetEffectArcHeight
        jsl rlBattleAnimationGetJumpArc
        lda wR0
        sta wBattleAnimationSpawnGravity,b
        lda wR1
        sta wBattleAnimationSpawnYVelocity,b
        rts

        .databank 0

        ; 95/DE61

      rlBattleAnimationMoveEffectSlot ; 95/DE61

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame, X = an effect slot: moves it by bits 0-1 of its bBattleAnimationMotionFlags: 0 and 1 fly straight (rsBattleAnimationFlyEffect), 2 follows a path of aBattleAnimationEffectPaths, 3 a path script of aBattleAnimationEffectPathScripts.

        phx
        phy
        lda bBattleAnimationStateFlags,b,x
        bit #$0080
        beq _DE81
        lda bBattleAnimationMotionFlags,b,x
        and #$0003
        sta wR0
        txy
        phb
        php
        phk
        plb
        .databank $95
        lda wR0
        asl a
        tax
        jsr (aBattleAnimationEffectMotions,x)
        plp
        plb
        .databank $95

        _DE81
        ply
        plx
        rtl

        .databank 0

        ; 95/DE84

    .endsection Unsorted95DCA3Section


    .section Table95DE84Section

      .al
      .xl

      aBattleAnimationEffectMotions ; 95/DE84

        ; Jump table of rlBattleAnimationMoveEffectSlot.
        .word <>rsBattleAnimationFlyEffect
        .word <>rsBattleAnimationFlyEffect
        .word <>rsBattleAnimationFollowEffectPath
        .word <>rsBattleAnimationRunEffectPathScript

    .endsection Table95DE84Section


    .section Unsorted95DE8CSection

      .al
      .xl

      rsBattleAnimationFlyEffect ; 95/DE8C

        .al
        .xl
        .autsiz
        .databank ?

        ; Y = the effect slot: moves it by its X speed with the pose for its angle (rsBattleAnimationSetEffectPose); on reaching the defender the strike lands (rlBattleSceneApplyEffectStrike), and off the stage the slot ends.

        phx
        phy
        tyx
        jsr rsBattleAnimationSetEffectPose
        lda wBattleAnimationXSpeed,b,x
        bne _DE9B
        jml _DED2


        _DE9B
        bpl _DEA1
        jml _DEB9


        _DEA1
        sta wR0
        jsr rsBattleAnimationMoveEffectRight
        bit #$0001
        beq _DEB1
        php
        jsl rlBattleSceneApplyEffectStrike
        plp

        _DEB1
        bcc _DEB7
        jsl rlBattleAnimationEndEffectSlot

        _DEB7
        bra _DED2


        _DEB9
        and #$7FFF
        sta wR0
        jsr rsBattleAnimationMoveEffectLeft
        bit #$0001
        beq _DECC
        php
        jsl rlBattleSceneApplyEffectStrike
        plp

        _DECC
        bcc _DED2
        jsl rlBattleAnimationEndEffectSlot

        _DED2
        ply
        plx
        rts

        .databank 0

        ; 95/DED5

      rsBattleAnimationFollowEffectPath ; 95/DED5

        .al
        .xl
        .autsiz
        .databank ?

        ; Y = the effect slot: takes the next word of its path in aBattleAnimationEffectPaths (at wBattleAnimationSecondaryOffset): the high byte is taken from its Y, the low byte (signed, toward the defender) times lBattleAnimationSecondaryPointer2 moves it in X; $8080 ends the slot.

        phx
        phy
        tyx
        lda wBattleAnimationSecondaryOffset,b,x
        phx
        tax
        lda aBattleAnimationEffectPaths,x
        cmp #$8080
        bne _DEF4
        plx
        jsl rlBattleAnimationEndEffectSlot
        ldx wBattleAnimationAttackerOffset,b
        jsl rlBattleAnimationSignalSelf
        bra _DF73


        _DEF4
        plx
        pha
        and #$FF00
        pha
        lda wBattleAnimationYFixed,b,x
        sec
        sbc #1,s
        sta wBattleAnimationYFixed,b,x
        pla
        phx
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        ldx wBattleAnimationAttackerOffset,b
        cmp wBattleAnimationX,b,x
        bcs _DF17
        plx
        pla
        bra _DF1D


        _DF17
        plx
        pla
        eor #$FFFF
        inc a

        _DF1D
        and #$00FF
        bit #$0080
        bne _DF46
        sta wR10
        lda lBattleAnimationSecondaryPointer2,b,x
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        sta wR0
        jsr rsBattleAnimationMoveEffectRight
        bit #$0001
        beq _DF42
        php
        jsl rlBattleSceneApplyEffectStrike
        plp

        _DF42
        bcc _DF44

        _DF44
        bra _DF69


        _DF46
        eor #$00FF
        inc a
        sta wR10
        lda lBattleAnimationSecondaryPointer2,b,x
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        sta wR0
        jsr rsBattleAnimationMoveEffectLeft
        bit #$0001
        beq _DF67
        php
        jsl rlBattleSceneApplyEffectStrike
        plp

        _DF67
        bcc _DF69

        _DF69
        lda wBattleAnimationSecondaryOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationSecondaryOffset,b,x

        _DF73
        ply
        plx
        rts

        .databank 0

        ; 95/DF76

    .endsection Unsorted95DE8CSection


    .section Unsorted95DF76Section

      .al
      .xl

      rsBattleAnimationRunEffectPathScript ; 95/DF76

        .al
        .xl
        .autsiz
        .databank ?

        ; Y = the effect slot: runs its path in aBattleAnimationEffectPathScripts: a word moves it as in rsBattleAnimationFollowEffectPath (in whole pixels); $8080 ends the slot, $8081 waits a frame, $8082 starts script $28, $8083 makes the defender dodge a missed strike, $8084 moves it 48 pixels toward the defender, $8085 lands the strike.

        phx
        phy
        tyx

        _DF79
        lda wBattleAnimationSecondaryOffset,b,x
        phx
        tax
        lda aBattleAnimationEffectPathScripts,x
        cmp #$8081
        bne _DF8C
        plx
        jml _E089


        _DF8C
        cmp #$8082
        bne _DFA5
        plx
        lda #$0028
        jsl rlStartBattleSceneScript
        lda wBattleAnimationSecondaryOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationSecondaryOffset,b,x
        bra _DF79


        _DFA5
        cmp #$8083
        bne _DFC8
        plx
        lda bBattleSceneStrikeFlags,b
        bit #$0008
        beq _DFBC
        phx
        ldx wBattleAnimationDefenderOffset,b
        jsl rlBattleSceneQueueDodge
        plx

        _DFBC
        lda wBattleAnimationSecondaryOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationSecondaryOffset,b,x
        bra _DF79


        _DFC8
        cmp #$8084
        bne _DFFF
        plx
        phx
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        ldx wBattleAnimationAttackerOffset,b
        cmp wBattleAnimationX,b,x
        plx
        bcs _DFE7
        lda wBattleAnimationX,b,x
        clc
        adc #$0030
        bra _DFEE


        _DFE7
        lda wBattleAnimationX,b,x
        sec
        sbc #$0030

        _DFEE
        sta wBattleAnimationX,b,x
        lda wBattleAnimationSecondaryOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationSecondaryOffset,b,x
        jml _DF79


        _DFFF
        cmp #$8085
        bne _E017
        plx
        jsl rlBattleSceneApplyEffectStrike
        lda wBattleAnimationSecondaryOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationSecondaryOffset,b,x
        jml _DF79


        _E017
        cmp #$8080
        bne _E02A
        plx
        jsl rlBattleAnimationEndEffectSlot
        ldx wBattleAnimationAttackerOffset,b
        jsl rlBattleAnimationSignalSelf
        bra _E089


        _E02A
        plx
        pha
        and #$FF00
        pha
        lda wBattleAnimationYFixed,b,x
        sec
        sbc #1,s
        sta wBattleAnimationYFixed,b,x
        pla
        phx
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        ldx wBattleAnimationAttackerOffset,b
        cmp wBattleAnimationX,b,x
        bcs _E04D
        plx
        pla
        bra _E053


        _E04D
        plx
        pla
        eor #$FFFF
        inc a

        _E053
        and #$00FF
        bit #$0080
        bne _E06C
        xba
        sta wR0
        jsr rsBattleAnimationMoveEffectRight
        bit #$0001
        beq _E068
        php
        plp

        _E068
        bcc _E06A

        _E06A
        bra _E07F


        _E06C
        eor #$00FF
        inc a
        xba
        sta wR0
        jsr rsBattleAnimationMoveEffectLeft
        bit #$0001
        beq _E07D
        php
        plp

        _E07D
        bcc _E07F

        _E07F
        lda wBattleAnimationSecondaryOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationSecondaryOffset,b,x

        _E089
        ply
        plx
        rts

        .databank 0

        ; 95/E08C

    .endsection Unsorted95DF76Section


    .section Unreferenced95E08CSection

      .as
      .xl

      rlBattleSceneScriptNextEffectPose ; 95/E08C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Found by tools/sweep.py. Script routine $18: steps the attacker's effect slot to its next pose (secondary offset + 2, pose offset + 1) and ends.

        phx
        lda wBattleAnimationAttackerOffset,b
        cmp #$0000
        bne _E09A
        ldx #$0086
        bra _E09D


        _E09A
        ldx #$00C9

        _E09D
        lda wBattleAnimationSecondaryOffset,b,x
        clc
        adc #$0002
        sta wBattleAnimationSecondaryOffset,b,x
        lda bBattleAnimationPoseOffset,b,x
        inc a
        sep #$20
        xba
        cpx #$0086
        bne _E0B7
        lda #$02
        bra _E0B9


        _E0B7
        lda #$03

        _E0B9
        rep #$20
        jsl rlBattleAnimationStartSequence
        plx
        jsl rlBattleSceneEndScriptRoutine
        rtl

        .databank 0

        ; 95/E0C5

    .endsection Unreferenced95E08CSection
    .section Unsorted95E0C5Section

      .al
      .xl

      rsBattleAnimationMoveEffectRight ; 95/E0C5

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the effect slot, A = 8.8 pixels: moves it right and scrolls the camera after it (between $C0 and $140). Returns A = 1 once it is past the combatant on the right; carry set when it has left the stage.

        phx
        sta wR2
        lda wBattleAnimationXFixed,b,x
        clc
        adc wR2
        sta wBattleAnimationXFixed,b,x
        lda wBattleAnimationX+1,b,x
        adc #$0000
        sep #$20
        sta wBattleAnimationX+1,b,x
        rep #$20
        lda wBattleAnimationX,b,x
        cmp #$0200
        bcs _E141
        pha
        lda wBattleAnimationX,b
        cmp wBattleAnimation2X,b
        bcc _E0F4
        ldx #$0000
        bra _E0F7


        _E0F4
        ldx #$0043

        _E0F7
        pla
        cmp wBattleAnimationX,b,x
        bcc _E103
        lda #$0001
        clc
        bra _E144


        _E103
        cmp #$0140
        bcc _E10D
        lda #$0140
        bra _E140


        _E10D
        cmp #$00C0
        bcs _E117
        lda #$00C0
        bra _E140


        _E117
        lda bBattleSceneCameraXFraction
        clc
        adc wR2
        sta bBattleSceneCameraXFraction
        sep #$20
        lda wBattleSceneCameraX+1
        adc #$00
        sta wBattleSceneCameraX+1
        rep #$20
        lda wBattleSceneCameraX
        cmp #$00C0
        bcc _E13C
        lda #$00C0

        _E13C
        sta wBattleSceneCameraX

        _E140
        clc

        _E141
        lda #$0000

        _E144
        plx
        rts

        .databank 0

        ; 95/E146

      rsBattleAnimationMoveEffectLeft ; 95/E146

        .al
        .xl
        .autsiz
        .databank ?

        ; As rsBattleAnimationMoveEffectRight, to the left.

        phx
        sta wR2
        lda wBattleAnimationXFixed,b,x
        sec
        sbc wR2
        sta wBattleAnimationXFixed,b,x
        lda wBattleAnimationX+1,b,x
        sbc #$0000
        sep #$20
        sta wBattleAnimationX+1,b,x
        rep #$20
        lda wBattleAnimationX,b,x
        bpl _E167
        sec
        bra _E1C4


        _E167
        pha
        lda wBattleAnimationX,b
        cmp wBattleAnimation2X,b
        bcs _E175
        ldx #$0000
        bra _E178


        _E175
        ldx #$0043

        _E178
        pla
        cmp wBattleAnimationX,b,x
        beq _E186
        bcs _E186
        lda #$0001
        clc
        bra _E1C7


        _E186
        cmp #$0140
        bcc _E190
        lda #$0140
        bra _E1C3


        _E190
        cmp #$00C0
        bcs _E19A
        lda #$00C0
        bra _E1C3


        _E19A
        lda bBattleSceneCameraXFraction
        sec
        sbc wR2
        sta bBattleSceneCameraXFraction
        sep #$20
        lda wBattleSceneCameraX+1
        sbc #$00
        sta wBattleSceneCameraX+1
        rep #$20
        lda wBattleSceneCameraX
        cmp #$0040
        bcs _E1BF
        lda #$0040

        _E1BF
        sta wBattleSceneCameraX

        _E1C3
        clc

        _E1C4
        lda #$0000

        _E1C7
        plx
        rts

        .databank 0

        ; 95/E1C9

    .endsection Unsorted95E0C5Section


    .section Unsorted95E1C9Section

      .al
      .xl

      rlBattleAnimationApplyEffectGravity ; 95/E1C9

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame, X = an effect slot flying straight: moves its Y by its velocity and slows the velocity by its gravity; on reaching the ground the slot ends.

        phx
        phy
        lda bBattleAnimationStateFlags,b,x
        bit #$0080
        beq _E229
        lda bBattleAnimationMotionFlags,b,x
        and #$0003
        cmp #$0002
        beq _E229
        cmp #$0003
        beq _E229
        lda bBattleAnimationStateFlags,b,x
        bit #$0010
        bne _E229
        lda wBattleAnimationYVelocity,b,x
        bmi _E1FB
        lda wBattleAnimationYVelocity,b,x
        clc
        adc wBattleAnimationYFixed,b,x
        bcc _E21C
        bra _E204


        _E1FB
        lda wBattleAnimationYVelocity,b,x
        clc
        adc wBattleAnimationYFixed,b,x
        bcs _E21C

        _E204
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$F7
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        stz wBattleAnimationYFixed,b,x
        stz wBattleAnimationYVelocity,b,x
        jsl rlBattleAnimationEndEffectSlot
        bra _E229


        _E21C
        sta wBattleAnimationYFixed,b,x
        lda wBattleAnimationYVelocity,b,x
        sec
        sbc wBattleAnimationGravity,b,x
        sta wBattleAnimationYVelocity,b,x

        _E229
        ply
        plx
        rtl

        .databank 0

        ; 95/E22C

      rlBattleAnimationApplyEffectYStep ; 95/E22C

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame, X = an effect slot flying straight: moves its Y by wBattleAnimationYStep (down, or up with bit 15); on reaching the ground or passing the top the slot ends.

        phx
        phy
        lda bBattleAnimationStateFlags,b,x
        bit #$0080
        beq _E28E
        lda bBattleAnimationMotionFlags,b,x
        and #$0003
        cmp #$0002
        beq _E28E
        cmp #$0003
        beq _E28E
        lda wBattleAnimationYStep,b,x
        bne _E261
        lda bBattleAnimationStateFlags,b,x
        bit #$0010
        beq _E28E
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$EF
        sta bBattleAnimationStateFlags,b,x
        rep #$20
        bra _E28E


        _E261
        bmi _E278
        sta wR0
        lda wBattleAnimationYFixed,b,x
        sec
        sbc wR0
        bcs _E273
        jsl rlBattleAnimationEndEffectSlot
        bra _E276


        _E273
        sta wBattleAnimationYFixed,b,x

        _E276
        bra _E28E


        _E278
        and #$7FFF
        sta wR0
        lda wBattleAnimationYFixed,b,x
        clc
        adc wR0
        bcc _E28B
        jsl rlBattleAnimationEndEffectSlot
        bra _E28E


        _E28B
        sta wBattleAnimationYFixed,b,x

        _E28E
        ply
        plx
        rtl

        .databank 0

        ; 95/E291

      rsBattleAnimationSetEffectYStep ; 95/E291

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the spawn slot's target Y to the defender's hit height and its Y step (8.8 a pixel, bit 15 down) from the attacker's hit height ($18 higher for motion 1).

        phx
        lda wBattleAnimationAttackerOffset,b
        clc
        adc #$0086
        tax
        lda bBattleAnimationMotionFlags,b,x
        and #$0003
        cmp #$0001
        bne _E2AA
        lda #$0018
        bra _E2AD


        _E2AA
        lda #$0000

        _E2AD
        pha
        ldx wBattleAnimationDefenderOffset,b
        jsl rlBattleAnimationGetHitHeight
        sta wR1
        ldx wBattleAnimationAttackerOffset,b
        jsl rlBattleAnimationGetHitHeight
        clc
        adc #1,s
        sta wR2
        pla
        lda wR1
        sec
        sbc wR2
        bpl _E2D6
        eor #$FFFF
        inc a
        sta wR2
        lda #$0000
        bra _E2DB


        _E2D6
        sta wR2
        lda #$8000

        _E2DB
        sta wR3
        lda wR2
        jsl rlBattleAnimationDivide8_8
        ora wR3
        sta wBattleAnimationSpawnYStep,b
        lda wR1
        sta wBattleAnimationSpawnTargetY,b
        plx
        rts

        .databank 0

        ; 95/E2EF

      rlBattleAnimationDivide8_8 ; 95/E2EF

        .al
        .xl
        .autsiz
        .databank ?

        ; A * 256 / wR0.

        phx
        phy
        sta wR13
        stz wR12
        lda wR0
        sta wR14
        stz wR15
        jsl rlUnsignedDivide32By32
        lda wR12+1
        ply
        plx
        rtl

        .databank 0

        ; 95/E304

      rlBattleAnimationGetEffectSpeed ; 95/E304

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry clear for combatant 1's effect: $800 for motion 1, else $1000 when the thrower is off the ground and $1200 on it.

        phx
        php
        bcs _E30D
        ldx #$0086
        bra _E310


        _E30D
        ldx #$00C9

        _E310
        lda bBattleAnimationMotionFlags,b,x
        and #$0003
        cmp #$0001
        beq _E335
        plp
        bcc _E323
        ldx #$0043
        bra _E326


        _E323
        ldx #$0000

        _E326
        lda wBattleAnimationYFixed,b,x
        beq _E330
        lda #$1000
        bra _E339


        _E330
        lda #$1200
        bra _E339


        _E335
        plp
        lda #$0800

        _E339
        plx
        rtl

        .databank 0

        ; 95/E33B

      rlBattleAnimationGetEffectArcHeight ; 95/E33B

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry clear for combatant 1's effect: $18 for motion 1, else 6 or 0 by wBattleAnimationYFixed of X = $0E or 0, which are offsets into aBattleSceneCombatant1, not slot offsets: they read the wrong field.

        phx
        php
        bcs _E344
        ldx #$0086
        bra _E347


        _E344
        ldx #$00C9

        _E347
        lda bBattleAnimationMotionFlags,b,x
        and #$0003
        cmp #$0001
        beq _E36C
        plp
        bcs _E35A
        ldx #$000E
        bra _E35D


        _E35A
        ldx #$0000

        _E35D
        lda wBattleAnimationYFixed,b,x
        beq _E367
        lda #$0006
        bra _E370


        _E367
        lda #$0000
        bra _E370


        _E36C
        plp
        lda #$0018

        _E370
        plx
        rtl

        .databank 0

        ; 95/E372

    .endsection Unsorted95E1C9Section


    .section Unsorted95E372Section

      .al
      .xl

      rsBattleAnimationSetEffectPose ; 95/E372

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the effect slot: picks its pose by the slope of its flight (Y velocity over X speed): 0 steeply up, 1 up, 2 level, 3 down, 4 steeply down, added to bBattleAnimationPoseOffset.

        phx
        lda wBattleAnimationXSpeed,b,x
        and #$7FFF
        sta wR10
        lda wBattleAnimationYVelocity,b,x
        beq _E3C2
        bmi _E3A0
        sta wR13
        phx
        jsl rlUnsignedDivide16By16R13
        plx
        lda wR13
        cmp #$0020
        bcc _E396
        lda #$0000
        bra _E3C5


        _E396
        cmp #$0010
        bcc _E3C2
        lda #$0002
        bra _E3C5


        _E3A0
        eor #$FFFF
        inc a
        sta wR13
        phx
        jsl rlUnsignedDivide16By16R13
        plx
        lda wR13
        cmp #$0020
        bcc _E3B8
        lda #$0004
        bra _E3C5


        _E3B8
        cmp #$0010
        bcc _E3C2
        lda #$0003
        bra _E3C5


        _E3C2
        lda #$0002

        _E3C5
        clc
        adc bBattleAnimationPoseOffset,b,x
        sep #$20
        xba
        cpx #$0086
        bne _E3D5
        lda #$02
        bra _E3D7


        _E3D5
        lda #$03

        _E3D7
        rep #$20
        jsl rlBattleAnimationStartSequence
        plx
        rts

        .databank 0

        ; 95/E3DF

    .endsection Unsorted95E372Section


    .section Unsorted95E3DFSection

      .al
      .xl

      rsBattleSceneSetRoles ; 95/E3DF

        .as
        .xl
        .autsiz
        .databank ?

        ; Carry clear: combatant 1 attacks (role 2) and combatant 2 defends (role 3); carry set the other way.

        bcs _E3EF
        sep #$20
        lda #$02
        sta bBattleAnimationRole,b
        lda #$03
        sta bBattleAnimation2Role,b
        bra _E3FB


        _E3EF
        sep #$20
        lda #$03
        sta bBattleAnimationRole,b
        lda #$02
        sta bBattleAnimation2Role,b

        _E3FB
        rep #$20
        rts

        .databank 0

        ; 95/E3FE

      rlBattleAnimationQueueAction ; 95/E3FE

        .al
        .xl
        .autsiz
        .databank ?

        ; Queues action A of the combatant's move program
        ; (aBattleAnimationPrograms): its move list or single sequence.

        pha
        phx
        phy
        phx
        pha
        cpx #$0000
        bne _E411
        ldx #$0000
        lda $7FE1B6
        bra _E418


        _E411
        ldx #$000E
        lda $7FE1BA

        _E418
        inc a
        and #$00FF
        tax
        lda aBattleAnimationProgramIndices,x
        and #$00FF
        pha
        asl a
        asl a
        asl a
        clc
        adc #1,s
        clc
        adc #$0060
        tax
        pla
        lda aBattleAnimationProgramIndices+3,x
        sta lR18
        lda aBattleAnimationProgramIndices+4,x
        sta lR18+1
        lda aBattleAnimationProgramIndices,x
        sta lR19
        lda aBattleAnimationProgramIndices+1,x
        sta lR19+1
        lda aBattleAnimationProgramIndices+6,x
        sta lR20
        lda aBattleAnimationProgramIndices+7,x
        sta lR20+1
        ply
        plx
        lda lR20
        sta lBattleAnimationMoveListPointer,b,x
        lda lR20+1
        sta lBattleAnimationMoveListPointer+1,b,x
        lda [lR18],y
        and #$00FF
        bit #$0080
        bne _E474
        and #$007F
        jsl rlBattleAnimationQueueSequence
        bra _E47B


        _E474
        and #$007F
        jsl rlBattleAnimationQueueMoveList

        _E47B
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/E47F

      rlBattleSceneCheckPaletteSwap ; 95/E47F

        .al
        .xl
        .autsiz
        .databank ?

        ; Swaps the combatants' palettes back when the defender's palette-swap bit is clear.

        phx
        ldx wBattleAnimationDefenderOffset,b
        lda bBattleAnimationAttributes,b,x
        bit #$0008
        bne _E48F
        jsl rlBattleSceneSwapCombatantPalettes

        _E48F
        plx
        rtl

        .databank 0

        ; 95/E491

      rlBattleSceneSwapCombatantPalettes ; 95/E491

        .al
        .xl
        .autsiz
        .databank ?

        ; Swaps the two combatants' sprite palettes and their palette-swap bits.

        phd
        pha
        phx
        phy
        lda #$01FE
        tcd
        ldx #$0074

        _E49C
        lda wR0,x
        ldy wBufferBG1HOFS+1,x
        sta wBufferBG1HOFS+1,x
        sty wR0,x
        dec x
        dec x
        bne _E49C
        sep #$20
        lda bBattleAnimationAttributes,b
        eor #$08
        sta bBattleAnimationAttributes,b
        lda bBattleAnimation2Attributes,b
        eor #$08
        sta bBattleAnimation2Attributes,b
        rep #$20
        ldx #$0000

        _E4BF
        lda aOAMPaletteBuffer,b,x
        sta $7FFF00,x
        inc x
        inc x
        cpx #$0100
        bcc _E4BF
        ply
        plx
        pla
        pld
        rtl

        .databank 0

        ; 95/E4D2

      rsBattleAnimationApplyScriptStep ; 95/E4D2

        .al
        .xl
        .autsiz
        .databank ?

        ; Moves the combatant by the next signed byte of its movement script,
        ; once per sequence step.

        phy
        lda bBattleAnimationFacingFlags,b,x
        bit #$0001
        bne _E4DF
        jml _E58A


        _E4DF
        lda bBattleAnimationStateFlags,b,x
        bit #$0040
        beq _E4EB
        jml _E58A


        _E4EB
        lda lBattleAnimationMoveListPointer+1,b,x
        sta lR18+1
        lda wBattleAnimationMoveListOffset,b,x
        sta lR18
        ldy #$0000
        lda bBattleAnimationFacingFlags,b,x
        bit #$0002
        beq _E547
        lda wBattleAnimationBaseTile,b,x
        bmi _E523
        lda [lR18],y
        and #$00FF
        xba
        bit #$8000
        bne _E516
        clc
        jsr rsBattleAnimationMoveRight
        bra _E53F


        _E516
        eor #$FF00
        clc
        adc #$0100
        clc
        jsr rsBattleAnimationMoveLeft
        bra _E53F


        _E523
        lda [lR18],y
        and #$00FF
        xba
        bit #$8000
        bne _E534
        clc
        jsr rsBattleAnimationMoveLeft
        bra _E53F


        _E534
        eor #$FF00
        clc
        adc #$0100
        clc
        jsr rsBattleAnimationMoveRight

        _E53F
        inc y
        lda wBattleAnimationMoveListOffset,b,x
        inc a
        sta wBattleAnimationMoveListOffset,b,x

        _E547
        lda bBattleAnimationFacingFlags,b,x
        bit #$0040
        beq _E58A
        phx
        ldx wBattleAnimationDefenderOffset,b
        jsl rlBattleAnimationGetBodyWidth
        pha
        jsl rlBattleSceneGetCombatantGap
        lda wR1
        cmp #1,s
        pla
        plx
        bcs _E58A
        sep #$20
        lda bBattleAnimationStateFlags,b,x
        and #$FE
        sta bBattleAnimationStateFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        and #$9F
        sta bBattleAnimationFacingFlags,b,x
        lda bBattleAnimationFacingFlags,b,x
        and #$FE
        sta bBattleAnimationFacingFlags,b,x
        lda bBattleAnimationCombatantFlags,b,x
        and #$FC
        ora #$02
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20

        _E58A
        ply
        rts

        .databank 0

        ; 95/E58C

      rsBattleAnimationRestartMoveList ; 95/E58C

        .al
        .xl
        .autsiz
        .databank ?

        ; With bit 0 of bBattleAnimationFacingFlags, the move list restarts with the sequence (rsBattleAnimationCmdRestart).

        lda bBattleAnimationFacingFlags,b,x
        bit #$0001
        beq _E59A
        lda wBattleAnimationMoveListLoopOffset,b,x
        sta wBattleAnimationMoveListOffset,b,x

        _E59A
        rts

        .databank 0

        ; 95/E59B

      rsBattleAnimationGoBackMoveList ; 95/E59B

        .al
        .xl
        .autsiz
        .databank ?

        ; With bit 0 of bBattleAnimationFacingFlags, the move list goes back with the sequence (rsBattleAnimationCmdGoBack): by the same count, doubled for variant 3.

        lda bBattleAnimationFacingFlags,b,x
        bit #$0001
        beq _E5C8
        jsr rsBattleAnimationReadStep
        xba
        and #$00FF
        bne _E5AD
        inc a

        _E5AD
        pha
        lda bBattleAnimationFacingFlags,b,x
        and #$0006
        cmp #$0006
        bne _E5BC
        pla
        asl a
        pha

        _E5BC
        pla
        pha
        lda wBattleAnimationMoveListOffset,b,x
        sec
        sbc #1,s
        sta wBattleAnimationMoveListOffset,b,x
        pla

        _E5C8
        rts

        .databank 0

        ; 95/E5C9

    .endsection Unsorted95E3DFSection


    .section Unsorted96961FSection

      .al
      .xl

      rlBattleSceneTrackCombatantSides ; 96/961F

        .al
        .xl
        .autsiz
        .databank ?

        ; Each frame: when combatant 1 passes to the right of combatant 2 sends sound command $1D1, and $D1 when it passes back (bit 0 of $7FFC9C remembers the side).

        lda $7FFC9C
        bit #$0001
        bne _9647
        lda wBattleAnimationX,b
        cmp wBattleAnimation2X,b
        bcs _9664
        sep #$20
        lda $7FFC9C
        ora #$01
        sta $7FFC9C
        rep #$20
        lda #$01D1
        jsl rlSendSoundCommand
        bra _9664


        _9647
        lda wBattleAnimation2X,b
        cmp wBattleAnimationX,b
        bcs _9664
        sep #$20
        lda $7FFC9C
        and #$FE
        sta $7FFC9C
        rep #$20
        lda #$00D1
        jsl rlSendSoundCommand

        _9664
        rtl

        .databank 0

        ; 96/9665

    .endsection Unsorted96961FSection


