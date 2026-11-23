; The rounds: rsBattleSceneStartNextRound reads aBattleRoundsData one entry at a
; time and queues the attacker's action (attack, critical, staff, skill banner);
; rlBattleSceneApplyStrike lands it: HP loss, damage flash, knockback, hit sound.


    .section Unsorted95A65FSection

      .al
      .xl

      rlBattleSceneRunRounds ; 95/A65F

        .al
        .xl
        .autsiz
        .databank ?

        ; When nothing is moving or playing, starts the next round of aBattleRoundsData (rsBattleSceneStartNextRound).

        jsr rsBattleSceneCheckBusy
        bcs _A669
        jsr rsBattleSceneStartNextRound
        bcs _A669

        _A669
        rtl

        .databank 0

        ; 95/A66A

      rsBattleSceneCheckBusy ; 95/A66A

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set while anything is still going: a queued move, a combatant or effect slot in motion, the HP bars, a script, a fade.

        lda aBattleSceneMoveQueues
        cmp #$FFFF
        beq _A677
        jml _A75F


        _A677
        lda $7FE164
        cmp #$FFFF
        beq _A684
        jml _A75F


        _A684
        lda bBattleAnimationStateFlags,b
        bit #$0020
        beq _A694
        lda bBattleAnimationFacingFlags,b
        bit #$0040
        bne _A6A0

        _A694
        lda bBattleAnimationStateFlags,b
        bit #$0001
        beq _A6A0
        jml _A75F


        _A6A0
        lda wBattleAnimationXSpeed,b
        ora wBattleAnimationYVelocity,b
        ora wBattleAnimationYStep,b
        beq _A6AF
        jml _A75F


        _A6AF
        lda bBattleAnimation2StateFlags,b
        bit #$0020
        beq _A6BF
        lda bBattleAnimation2FacingFlags,b
        bit #$0040
        bne _A6CB

        _A6BF
        lda bBattleAnimation2StateFlags,b
        bit #$0001
        beq _A6CB
        jml _A75F


        _A6CB
        lda wBattleAnimation2XSpeed,b
        ora wBattleAnimation2YVelocity,b
        ora wBattleAnimation2YStep,b
        beq _A6DA
        jml _A75F


        _A6DA
        lda $0B79,b
        bit #$0080
        beq _A6F5
        lda $0B79,b
        bit #$0001
        bne _A75F
        lda $0B8E,b
        ora $0B94,b
        ora $0B99,b
        bne _A75F

        _A6F5
        lda $0BBC,b
        bit #$0080
        beq _A710
        lda $0BBC,b
        bit #$0001
        bne _A75F
        lda $0BD1,b
        ora $0BD7,b
        ora $0BDC,b
        bne _A75F

        _A710
        lda bBattleSceneKnockback,b
        and #$003F
        bne _A75F
        lda aBattleScenePaletteSlots.Type
        bit #$0080
        beq _A75F
        lda $7FFDA4
        bit #$0080
        beq _A75F
        lda bBattleSceneDamageFlash1
        bne _A75F
        lda aBattleSceneCombatant1.HPSpeed,b
        ora aBattleSceneCombatant2.HPSpeed,b
        bne _A75F
        lda bBattleSceneCameraPan
        and #$00FF
        bne _A75F
        lda $7FE4B7
        bit #$0080
        bne _A75F
        lda $7FFC5D
        bit #$0001
        bne _A75F
        lda $7FE187
        bit #$0007
        bne _A75F
        clc
        bra _A760


        _A75F
        sec

        _A760
        rts

        .databank 0

        ; 95/A761

      rsBattleSceneStartNextRound ; 95/A761

        .al
        .xl
        .autsiz
        .databank ?

        ; Reads the round at lBattleSceneRoundPointer: $FD skipped, $FE a skill activation (rlUnknown96F697), $FFFF the end, $FEFF the end of an arena round. Otherwise sets attacker and defender by bit 0 and queues the attacker's action: staff, normal, critical, miss; then moves on and sets bit 0 of $7FE186 at the end.

        lda lBattleSceneRoundPointer+1,b
        sta lR18+1
        lda lBattleSceneRoundPointer,b
        sec
        sbc #$0002
        sta lR18
        ldy #$0002
        lda [lR18],y
        cmp #$00FD
        bne _A792
        lda lBattleSceneRoundPointer,b
        clc
        adc #$0002
        sta lBattleSceneRoundPointer,b
        lda lBattleSceneRoundPointer+2,b
        adc #$0000
        sep #$20
        sta lBattleSceneRoundPointer+2,b
        rep #$20
        bra rsBattleSceneStartNextRound


        _A792
        sep #$20
        cmp #$FE
        bne _A7A2
        rep #$20
        jsl rlBattleSceneShowSkill
        jml _AA53


        _A7A2
        .as
        rep #$20
        ldy #$0000
        lda bBattleSceneRoundState,b
        bit #BattleSceneRoundAllRead
        beq _A7B3
        jml _AA8C


        _A7B3
        lda bBattleSceneRoundState,b
        bit #$0020
        bne _A7D7
        lda [lR18],y
        bit #$0080
        bne _A7D7
        bit #$0010
        beq _A7D7
        sep #$20
        lda bBattleSceneStrikeFlags,b
        ora #$80
        sta bBattleSceneStrikeFlags,b
        rep #$20
        jml _AA8C


        _A7D7
        inc lR18
        ldy #$0002
        sep #$20
        lda [lR18],y
        sta bBattleSceneRoundDamage,b
        rep #$20
        ldy #$0000
        sep #$20
        lda bBattleSceneStrikeFlags,b
        and #$80
        sta bBattleSceneStrikeFlags,b
        rep #$20
        inc lR18
        lda [lR18],y
        cmp #$FFFF
        bne _A80E
        sep #$20
        lda bBattleSceneRoundState,b
        ora #BattleSceneRoundAllRead
        sta bBattleSceneRoundState,b
        rep #$20
        sec
        jml _AA8C


        _A80E
        cmp #$FEFF
        bne _A836
        sep #$20
        lda bBattleSceneRoundState,b
        ora #BattleSceneRoundAllRead
        sta bBattleSceneRoundState,b
        rep #$20
        jsl rlBattleSceneCheckArenaRetreat
        bcs _A831
        sep #$20
        lda bBattleSceneRoundState,b
        ora #BattleSceneRoundArenaNextBout
        sta bBattleSceneRoundState,b
        rep #$20

        _A831
        sec
        jml _AA8C


        _A836
        bit #$0001
        beq _A83F
        jml _A8AA


        _A83F
        lda wBattleSceneFlags
        bit #BattleSceneFlagHolyWeapon1
        beq _A865
        lda #$0043
        jsl rlStartBattleSceneScript
        ldx #$0000
        jsl rlBattleScenePlayHolyWeaponSound
        lda wBattleSceneFlags
        and #~BattleSceneFlagHolyWeapon1
        sta wBattleSceneFlags
        jml _AA8C


        _A865
        lda #$0000
        sta wBattleAnimationAttackerOffset,b
        lda #$0043
        sta wBattleAnimationDefenderOffset,b
        sep #$20
        lda bBattleSceneAttackerSide,b
        and #$7F
        sta bBattleSceneAttackerSide,b
        clc
        jsr rsBattleSceneSetRoles
        .al
        lda #$0000
        sta lBattleSceneCameraAttackerX+1
        lda #<>wBattleAnimationX
        sta lBattleSceneCameraAttackerX
        lda #$0000
        sta lBattleSceneCameraDefenderX+1
        lda #<>wBattleAnimation2X
        sta lBattleSceneCameraDefenderX
        jsl rlBattleSceneCheckCombatant1OnScreen
        bcs _A8A5
        jml _AA8C


        _A8A5
        ldx #$0000
        bra _A913


        _A8AA
        lda wBattleSceneFlags
        bit #BattleSceneFlagHolyWeapon2
        beq _A8D0
        lda #$0043
        jsl rlStartBattleSceneScript
        ldx #$0043
        jsl rlBattleScenePlayHolyWeaponSound
        lda wBattleSceneFlags
        and #~BattleSceneFlagHolyWeapon2
        sta wBattleSceneFlags
        jml _AA8C


        _A8D0
        lda #$0043
        sta wBattleAnimationAttackerOffset,b
        lda #$0000
        sta wBattleAnimationDefenderOffset,b
        sep #$20
        lda bBattleSceneAttackerSide,b
        ora #$80
        sta bBattleSceneAttackerSide,b
        sec
        jsr rsBattleSceneSetRoles
        .al
        lda #$0000
        sta lBattleSceneCameraDefenderX+1
        lda #<>wBattleAnimationX
        sta lBattleSceneCameraDefenderX
        lda #$0000
        sta lBattleSceneCameraAttackerX+1
        lda #<>wBattleAnimation2X
        sta lBattleSceneCameraAttackerX
        jsl rlBattleSceneCheckCombatant2OnScreen
        bcs _A910
        jml _AA8C


        _A910
        ldx #$0043

        _A913
        jsl rlBattleAnimationClearSignals
        jsl rlBattleSceneCheckPaletteSwap
        lda wBattleSceneFlags
        bit #BattleSceneFlagSolo
        bne _A92D
        lda [lR18],y
        bit #$0002
        beq _A958
        bra _A935


        _A92D
        jsl rlBattleSceneQueueSoloAction
        jml _AA53


        _A935
        lda [lR18],y
        bit #$0008
        beq _A950
        sep #$20
        lda bBattleSceneStrikeFlags,b
        ora #$08
        sta bBattleSceneStrikeFlags,b
        lda bBattleSceneRoundState,b
        ora #BattleSceneRoundMissed
        sta bBattleSceneRoundState,b
        rep #$20

        _A950
        jsl rlBattleSceneQueueStaffAction
        jml _AA53


        _A958
        sep #$20
        lda [lR18],y
        bit #$20
        beq _A969
        lda bBattleSceneRanged,b
        ora #$01
        rep #$20
        bra _A9C3


        _A969
        .as
        lda bBattleSceneRanged,b
        and #$FE
        sta bBattleSceneRanged,b
        rep #$20
        lda [lR18],y
        bit #$0040
        beq _A98F
        cpx #$0000
        bne _A984
        lda aBattleSceneCombatant1.AnimStyle,b
        bra _A987


        _A984
        lda aBattleSceneCombatant2.AnimStyle,b

        _A987
        and #$00F0
        cmp #$0000
        bne _A9C3

        _A98F
        jsl rlBattleSceneGetCombatantGap
        lda wR1
        cmp #$0010
        bcc _A9C3
        lda wR1
        cmp #$003C
        bcs _A9AA
        lda #$0001
        sta $7FF5AD
        bra _A9CA


        _A9AA
        lda lR18
        pha
        lda lR18+1
        pha
        jsl rlBattleSceneQueueApproach
        pla
        sta lR18+1
        pla
        sta lR18
        lda #$0002
        sta $7FF5AD
        bra _A9CA


        _A9C3
        lda #$0000
        sta $7FF5AD

        _A9CA
        sep #$20
        lda bBattleSceneRoundState,b
        and #$BF
        sta bBattleSceneRoundState,b
        lda bBattleSceneStrikeFlags,b
        and #$BF
        sta bBattleSceneStrikeFlags,b
        rep #$20
        lda [lR18],y
        bit #$0008
        bne _A9E9
        jml _A9FD


        _A9E9
        sep #$20
        lda bBattleSceneStrikeFlags,b
        ora #$08
        sta bBattleSceneStrikeFlags,b
        lda bBattleSceneRoundState,b
        ora #BattleSceneRoundMissed
        sta bBattleSceneRoundState,b
        rep #$20

        _A9FD
        sep #$20
        lda bBattleSceneStrikeFlags,b
        ora #$10
        sta bBattleSceneStrikeFlags,b
        rep #$20
        jsl rlUnknown95B8F3
        bcs _AA53
        lda bBattleAnimationCombatantFlags,b,x
        bit #$0004
        beq _AA1D
        jsl rlUnknown95ACF6
        bra _AA53


        _AA1D
        lda [lR18],y
        bit #$0004
        beq _AA4D
        bit #$0010
        beq _AA3B
        jsl rlBattleSceneQueueSpecialCriticalAttack
        sep #$20
        lda bBattleSceneStrikeFlags,b
        ora #$40
        sta bBattleSceneStrikeFlags,b
        rep #$20
        bra _AA53


        _AA3B
        jsl rlBattleSceneQueueCriticalAttack
        sep #$20
        lda bBattleSceneStrikeFlags,b
        ora #$40
        sta bBattleSceneStrikeFlags,b
        rep #$20
        bra _AA53


        _AA4D
        jsl rlBattleSceneQueueAttack
        bra _AA53


        _AA53
        lda lBattleSceneRoundPointer,b
        clc
        adc #$0002
        sta lBattleSceneRoundPointer,b
        lda lBattleSceneRoundPointer+2,b
        adc #$0000
        sep #$20
        sta lBattleSceneRoundPointer+2,b
        rep #$20
        lda lBattleSceneRoundPointer+1,b
        sta lR18+1
        lda lBattleSceneRoundPointer,b
        sta lR18
        ldy #$0000
        lda [lR18],y
        cmp #$FFFF
        bne _AA8C
        sep #$20
        lda $7FE186
        ora #$01
        sta $7FE186
        rep #$20

        _AA8C
        rts

        .databank 0

        ; 95/AA8D

    .endsection Unsorted95A65FSection


    .section Unreferenced95AA8DSection

      .al
      .xl

      rsUnknown95AA8D ; 95/AA8D

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda aBattleSceneCombatant1,b,x
        sta $7FE0B6
        lda aBattleSceneCombatant1.Weapon,b,x
        sta $7FE0B7
        lda $0D55,b
        sta $7FE0B8
        ldx wBattleAnimationAttackerOffset,b
        lda bBattleAnimationStateFlags,b,x
        sta $7FE0AE
        lda wBattleAnimationYAnchor+1,b,x
        sta $7FE0B2
        lda bBattleAnimationY,b,x
        sta $7FE0B4
        rep #$20
        lda wBattleAnimationX,b,x
        sta $7FE0AF
        rts

        .databank 0

        ; 95/AAC6

      rsUnknown95AAC6 ; 95/AAC6

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda aBattleSceneCombatant1,b,x
        sta $7FE0C1
        lda aBattleSceneCombatant1.Weapon,b,x
        sta $7FE0C2
        lda $0D55,b
        sta $7FE0C3
        ldx wBattleAnimationAttackerOffset,b
        lda bBattleAnimationStateFlags,b,x
        sta $7FE0B9
        lda wBattleAnimationYAnchor+1,b,x
        sta $7FE0BD
        lda bBattleAnimationY,b,x
        sta $7FE0BF
        rep #$20
        lda wBattleAnimationX,b,x
        sta $7FE0BA
        rts

        .databank 0

        ; 95/AAFF

    .endsection Unreferenced95AA8DSection
    .section Unsorted95AAFFSection

      .al
      .xl

      rlUnknown95AAFF ; 95/AAFF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda @l $000AF5,x
        and #$FC
        ora #$00
        sta @l $000AF5,x
        rep #$20
        lda bBattleAnimationY,b,x
        and #$00FF
        beq _AB4A
        phx
        cpx #$0000
        bne _AB23
        ldx #$0000
        bra _AB26


        _AB23
        ldx #$000E

        _AB26
        lda aBattleSceneCombatant1.AnimStyle,b,x
        and #$000F
        cmp #$0000
        bne _AB36
        lda #$0038
        bra _AB43


        _AB36
        cmp #$0002
        bne _AB40
        lda #$003C
        bra _AB43


        _AB40
        plx
        bra _AB4A


        _AB43
        plx
        jsl rlBattleAnimationQueueAction
        bra _AB51


        _AB4A
        lda #$0000
        jsl rlBattleAnimationQueueAction

        _AB51
        plx
        rtl

        .databank 0

        ; 95/AB53

      rlBattleSceneQueueDodge ; 95/AB53

        .al
        .xl
        .autsiz
        .databank ?

        ; X = the defender of a missed strike: queues its action from aBattleSceneDodgeActions by its attack style (action 1 for every style) plus its variant, then sets variant 1.

        phx
        jsr rsBattleSceneGetAttackStyle
        lda aBattleSceneDodgeActions,x
        and #$00FF
        plx
        pha
        lda @l $000AF5,x
        and #$0003
        clc
        adc #1,s
        jsl rlBattleAnimationQueueAction
        pla
        sep #$20
        lda @l $000AF5,x
        and #$FC
        ora #$01
        sta @l $000AF5,x
        rep #$20
        rtl

        .databank 0

        ; 95/AB80

    .endsection Unsorted95AAFFSection


    .section Unsorted95AB80Section

      .al
      .xl

      aBattleSceneDodgeActions ; 95/AB80

        ; Read by rlBattleSceneQueueDodge.

        .byte $01, $01, $01, $01, $01, $01, $01

      rlUnknown95AB87 ; 95/AB87

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsr rsBattleSceneGetAttackStyle
        lda aUnknown95ABB4,x
        and #$00FF
        plx
        pha
        lda @l $000AF5,x
        and #$0003
        clc
        adc #1,s
        jsl rlBattleAnimationQueueAction
        pla
        sep #$20
        lda @l $000AF5,x
        and #$FC
        ora #$01
        sta @l $000AF5,x
        rep #$20
        rtl

        .databank 0

        ; 95/ABB4


      aUnknown95ABB4 ; 95/ABB4

        .byte $05, $05, $05, $05, $04, $04, $03

        ; 95/ABBB

    .endsection Unsorted95AB80Section


    .section Unsorted95ABBBSection

      .al
      .xl

      rlBattleSceneQueueAttack ; 95/ABBB

        .al
        .xl
        .autsiz
        .databank ?

        ; The attacker's normal attack: the action from aUnknown95AC3B by attack style.

        lda [lR18],y
        bit #$0010
        beq _ABCF
        sep #$20
        lda #$03
        sta bBattleSceneHitKind
        sec
        rep #$20
        bra _ABD0


        _ABCF
        clc

        _ABD0
        php
        phx
        jsr rsBattleSceneGetAttackStyle
        lda aUnknown95AC3B,x
        and #$00FF
        plx
        pha
        lda $7FF5AD
        beq _ABED
        lda #1,s
        sec
        sbc $7FF5AD
        bra _ABF7


        _ABED
        lda @l $000AF5,x
        and #$0003
        clc
        adc #1,s

        _ABF7
        jsl rlBattleAnimationQueueAction
        pla
        plp
        bcs _AC3A
        jsr rsBattleSceneGetAnimCategory
        cmp #$0010
        bne _AC0D
        sep #$20
        lda #$02
        bra _AC28


        _AC0D
        .al
        lda $7FF5AD
        beq _AC17
        sep #$20
        bra _AC22


        _AC17
        .al
        sep #$20
        lda bBattleAnimationCombatantFlags,b,x
        and #$03
        cmp #$03
        beq _AC26

        _AC22
        lda #$00
        bra _AC28


        _AC26
        lda #$01

        _AC28
        sta bBattleSceneHitKind
        lda @l $000AF5,x
        and #$FC
        ora #$02
        sta @l $000AF5,x
        rep #$20

        _AC3A
        rtl

        .databank 0

        ; 95/AC3B

    .endsection Unsorted95ABBBSection


    .section Unsorted95AC41Section

      .al
      .xl

      rlBattleSceneQueueCriticalAttack ; 95/AC41

        .al
        .xl
        .autsiz
        .databank ?

        ; The attacker's critical: the action from aUnknown95ACA8 by attack style.

        phx
        jsr rsBattleSceneGetAttackStyle
        lda aUnknown95ACA8,x
        and #$00FF
        plx
        pha
        lda $7FF5AD
        beq _AC5D
        lda #1,s
        sec
        sbc $7FF5AD
        bra _AC67


        _AC5D
        lda @l $000AF5,x
        and #$0003
        clc
        adc #1,s

        _AC67
        jsl rlBattleAnimationQueueAction
        pla
        jsr rsBattleSceneGetAnimCategory
        cmp #$0010
        bne _AC7A
        sep #$20
        lda #$02
        bra _AC95


        _AC7A
        .al
        lda $7FF5AD
        beq _AC84
        sep #$20
        bra _AC8F


        _AC84
        .al
        sep #$20
        lda bBattleAnimationCombatantFlags,b,x
        and #$03
        cmp #$03
        beq _AC93

        _AC8F
        lda #$00
        bra _AC95


        _AC93
        lda #$01

        _AC95
        sta bBattleSceneHitKind
        lda @l $000AF5,x
        and #$FC
        ora #$02
        sta @l $000AF5,x
        rep #$20
        rtl

        .databank 0

        ; 95/ACA8

    .endsection Unsorted95AC41Section


    .section Unsorted95ACAESection

      .al
      .xl

      rlBattleSceneQueueSpecialCriticalAttack ; 95/ACAE

        .al
        .xl
        .autsiz
        .databank ?

        ; A critical with round bit 4: the action from aUnknown95ACF0 by attack style.

        phx
        jsr rsBattleSceneGetAttackStyle
        lda aUnknown95ACF0,x
        and #$00FF
        plx
        pha
        lda $7FF5AD
        beq _ACCA
        lda #1,s
        sec
        sbc $7FF5AD
        bra _ACD4


        _ACCA
        lda @l $000AF5,x
        and #$0003
        clc
        adc #1,s

        _ACD4
        jsl rlBattleAnimationQueueAction
        pla
        sep #$20
        lda @l $000AF5,x
        and #$FC
        ora #$02
        sta @l $000AF5,x
        lda #$03
        sta bBattleSceneHitKind
        rep #$20
        rtl

        .databank 0

        ; 95/ACF0

    .endsection Unsorted95ACAESection


    .section Unsorted95ACF6Section

      .al
      .xl

      rlUnknown95ACF6 ; 95/ACF6

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda [lR18],y
        bit #$10
        beq _AD02
        lda #$03
        bra _AD04


        _AD02
        lda #$00

        _AD04
        sta bBattleSceneHitKind
        rep #$20
        phx
        jsr rsBattleSceneGetAttackStyle
        lda aUnknown95AD8C,x
        and #$00FF
        plx
        pha
        lda @l $000AF5,x
        and #$0003
        clc
        adc #1,s
        jsl rlBattleAnimationQueueAction
        pla
        phx
        lda bBattleAnimationCombatantFlags,b,x
        and #$0038
        lsr a
        lsr a
        lsr a
        sta wR10
        lda #$0005
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        pha
        jsr rsBattleSceneGetAttackStyle
        txa
        clc
        adc #1,s
        tax
        pla
        lda aUnknown95AD64,x
        and #$00FF
        plx
        jsl rlBattleAnimationQueueAction
        sep #$20
        lda @l $000AF5,x
        and #$FC
        ora #$02
        sta @l $000AF5,x
        rep #$20
        rtl

        .databank 0

        ; 95/AD64

    .endsection Unsorted95ACF6Section


    .section Unsorted95AD8CSection

      .al
      .xl

      aUnknown95AD8C ; 95/AD8C

        ; Read by rlUnknown95ACF6.

        .byte $1B, $1B, $3A, $1F, $10

      rlUnknown95AD91 ; 95/AD91

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsr rsBattleSceneGetAttackStyle
        lda aUnknown95ADD2,x
        and #$00FF
        plx
        pha
        lda @l $000AF5,x
        and #$0003
        clc
        adc #1,s
        phx
        pha
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationYFixed,b,x
        beq _ADBA
        lda #$0014
        clc
        adc #1,s
        sta #1,s

        _ADBA
        pla
        plx
        jsl rlBattleAnimationQueueAction
        pla
        sep #$20
        lda @l $000AF5,x
        and #$FC
        ora #$02
        sta @l $000AF5,x
        rep #$20
        rtl

        .databank 0

        ; 95/ADD2


      aUnknown95ADD2 ; 95/ADD2

        .byte $00, $00, $1B, $1B

        ; 95/ADD6

    .endsection Unsorted95AD8CSection


    .section Unsorted95ADD6Section

      .al
      .xl

      rlBattleSceneQueueStaffAction ; 95/ADD6

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 5.

        lda #$0005
        jsl rlBattleAnimationQueueAction
        sep #$20
        lda @l $000AF5,x
        and #$FC
        ora #$02
        sta @l $000AF5,x
        rep #$20
        rtl

        .databank 0

        ; 95/ADEE

      rlBattleSceneQueueSoloAction ; 95/ADEE

        .al
        .xl
        .autsiz
        .databank ?

        ; Action 1, for a scene with BattleSceneSolo set (aActionStructUnit1.Unknown 8: both combatants stand at the center).

        lda #$0001
        jsl rlBattleAnimationQueueAction
        sep #$20
        lda @l $000AF5,x
        and #$FC
        ora #$02
        sta @l $000AF5,x
        rep #$20
        rtl

        .databank 0

        ; 95/AE06

      rlBattleSceneQueueApproach ; 95/AE06

        .al
        .xl
        .autsiz
        .databank ?

        ; For an attacker of class $0F-$14 on the ground: action $37 (style 0) or $3B (style 2) before a far attack.

        phx
        lda bBattleAnimationY,b,x
        and #$00FF
        bne _AE63
        phx
        cpx #$0000
        bne _AE1A
        ldx #$0000
        bra _AE1D


        _AE1A
        ldx #$000E

        _AE1D
        lda aBattleSceneCombatant1.Class,b,x
        cmp #$000F
        beq _AE41
        cmp #$0010
        beq _AE41
        cmp #$0011
        beq _AE41
        cmp #$0012
        beq _AE41
        cmp #$0013
        beq _AE41
        cmp #$0014
        beq _AE41
        plx
        bra _AE63


        _AE41
        lda aBattleSceneCombatant1.AnimStyle,b,x
        and #$000F
        cmp #$0000
        bne _AE51
        lda #$0037
        bra _AE5E


        _AE51
        cmp #$0002
        bne _AE5B
        lda #$003B
        bra _AE5E


        _AE5B
        plx
        bra _AE63


        _AE5E
        plx
        jsl rlBattleAnimationQueueAction

        _AE63
        plx
        rtl

        .databank 0

        ; 95/AE65

      rsBattleSceneGetAttackStyle ; 95/AE65

        .al
        .xl
        .autsiz
        .databank ?

        ; X = 0 or $43: the combatant's attack style (low nibble of its AnimStyle byte).

        cpx #$0000
        bne _AE6F
        ldx #$0000
        bra _AE72


        _AE6F
        ldx #$000E

        _AE72
        lda aBattleSceneCombatant1.AnimStyle,b,x
        and #$000F
        tax
        rts

        .databank 0

        ; 95/AE7A

      rsBattleSceneGetAnimCategory ; 95/AE7A

        .al
        .xl
        .autsiz
        .databank ?

        ; X = 0 or $43: the combatant's animation category << 4.

        cpx #$0000
        bne _AE84
        lda aBattleSceneCombatant1.AnimStyle,b
        bra _AE87


        _AE84
        lda aBattleSceneCombatant2.AnimStyle,b

        _AE87
        and #$00F0
        rts

        .databank 0

        ; 95/AE8B

    .endsection Unsorted95ADD6Section


    .section Unsorted95AE8BSection

      .al
      .xl

      rlBattleSceneApplyEffectStrike ; 95/AE8B

        .al
        .xl
        .autsiz
        .databank ?

        ; An effect slot's projectile reaches the defender: the hit kind becomes 2 (unless it is 3), then rlBattleSceneApplyStrike.

        sep #$20
        lda bBattleSceneHitKind
        cmp #$03
        beq _AE9B
        lda #$02
        sta bBattleSceneHitKind

        _AE9B
        rep #$20
        jsl rlBattleSceneApplyStrike
        rtl

        .databank 0

        ; 95/AEA2

    .endsection Unsorted95AE8BSection


    .section Unsorted95AEA2Section

      .al
      .xl

      rlBattleSceneApplyStrike ; 95/AEA2

        .al
        .xl
        .autsiz
        .databank ?

        ; The strike lands (battle scene script command $FFFA): starts the defender's HP loss by bBattleSceneRoundDamage, one point a frame, its damage flash, the knockback and the hit sound; with EarthSword or Sol the attacker regains the damage (rlBattleSceneStartDrain).

        phx
        lda bBattleSceneStrikeFlags,b
        bit #$0008
        beq _AEAF
        jml _AF45


        _AEAF
        lda bBattleSceneStrikeFlags,b
        bit #$0010
        bne _AEBB
        jml _AF45


        _AEBB
        sep #$20
        lda bBattleSceneStrikeFlags,b
        and #$F7
        sta bBattleSceneStrikeFlags,b
        lda bBattleSceneStrikeFlags,b
        and #$EF
        sta bBattleSceneStrikeFlags,b
        rep #$20
        lda bBattleAnimationMotionFlags,b,x
        and #$0003
        cmp #$0002
        beq _AEE6
        lda wBattleAnimationAttackerOffset,b
        clc
        adc #$0086
        tax
        jsl rlBattleAnimationEndEffectSlot

        _AEE6
        lda bBattleSceneAttackerSide,b
        bit #$0080
        beq _AF11
        lda bBattleSceneRoundDamage,b
        and #$00FF
        beq _AF00
        sta wR0
        jsr rsBattleSceneStartHPLoss1
        clc
        jsl rlBattleSceneStartDamageFlash

        _AF00
        jsl rlBattleSceneSetKnockback
        jsl rlBattleScenePlayHitSound
        jsl rlBattleSceneStartHUDShake
        lda aBattleSceneCombatant2.Weapon,b
        bra _AF33


        _AF11
        lda bBattleSceneRoundDamage,b
        and #$00FF
        beq _AF23
        sta wR0
        jsr rsBattleSceneStartHPLoss2
        sec
        jsl rlBattleSceneStartDamageFlash

        _AF23
        jsl rlBattleSceneSetKnockback
        jsl rlBattleScenePlayHitSound
        jsl rlBattleSceneStartHUDShake
        lda @l $000D52

        _AF33
        cmp #EarthSword
        beq _AF41
        lda $7FFC5D
        bit #$0004
        beq _AF45

        _AF41
        jsl rlBattleSceneStartDrain

        _AF45
        sep #$20
        lda $7FFC5D
        and #$FB
        sta $7FFC5D
        rep #$20
        plx
        rtl

        .databank 0

        ; 95/AF55

      rlBattleScenePlayHitSound ; 95/AF55

        .al
        .xl
        .autsiz
        .databank ?

        ; Sound by bBattleSceneHitKind ($91-$94), $95 for no damage, panned to the defender; a critical adds $50. Hit kind 3 by combatant 1 on JuliusChFinal slows the fade, fades the music and sets BattleSceneFlagToMapMode3.

        phx
        lda bBattleSceneRoundDamage,b
        and #$00FF
        beq _AFBA
        lda bBattleSceneHitKind
        and #$00FF
        cmp #$0003
        beq _AF83
        cmp #$0002
        beq _AF7E
        cmp #$0001
        beq _AF79
        lda #$0091
        bra _AFBD


        _AF79
        lda #$0092
        bra _AFBD


        _AF7E
        lda #$0093
        bra _AFBD


        _AF83
        lda wBattleAnimationAttackerOffset,b
        cmp #$0000
        bne _AFB5
        lda aBattleSceneCombatant2.Character,b
        cmp #JuliusChFinal
        bne _AFB5
        lda wBattleType
        and #$00FF
        cmp #$00FF
        beq _AFB5
        lda #$1414
        sta bBattleSceneFadeDelay
        lda wBattleSceneFlags
        ora #BattleSceneFlagToMapMode3
        sta wBattleSceneFlags
        jsl rlBattleSceneFadeMusicForJulius

        _AFB5
        lda #$0094
        bra _AFBD


        _AFBA
        lda #$0095

        _AFBD
        pha
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        bmi _AFD8
        cmp #$0100
        bcc _AFDD
        lda #$1F00
        bra _AFE1


        _AFD8
        lda #$0100
        bra _AFE1


        _AFDD
        jsl rlGetSoundPanFromXPixel

        _AFE1
        cpx #$0000
        bne _AFEA
        clc
        adc #$2000

        _AFEA
        sta wR0
        ora #1,s
        jsl rlPlaySoundEffect2
        pla
        lda bBattleSceneStrikeFlags,b
        bit #$0040
        beq _B004
        lda wR0
        ora #$0050
        jsl rlPlaySoundEffect2

        _B004
        plx
        rtl

        .databank 0

        ; 95/B006

      rlBattleSceneStartHeal ; 95/B006

        .al
        .xl
        .autsiz
        .databank ?

        ; Battle scene script command $FFFB: the target regains bBattleSceneRoundDamage HP, 4 frames a point.

        lda bBattleSceneAttackerSide,b
        bit #$0080
        beq _B01D
        lda bBattleSceneRoundDamage,b
        and #$00FF
        sta wR0
        asl a
        asl a
        jsr rsBattleSceneStartHPGain1
        bra _B02A


        _B01D
        lda bBattleSceneRoundDamage,b
        and #$00FF
        sta wR0
        asl a
        asl a
        jsr rsBattleSceneStartHPGain2

        _B02A
        rtl

        .databank 0

        ; 95/B02B

      rlBattleSceneStartDrain ; 95/B02B

        .al
        .xl
        .autsiz
        .databank ?

        ; The attacker regains bBattleSceneRoundDamage HP, 4 frames a point.

        lda bBattleSceneAttackerSide,b
        bit #$0080
        bne _B042
        lda bBattleSceneRoundDamage,b
        and #$00FF
        sta wR0
        asl a
        asl a
        jsr rsBattleSceneStartHPGain1
        bra _B04F


        _B042
        lda bBattleSceneRoundDamage,b
        and #$00FF
        sta wR0
        asl a
        asl a
        jsr rsBattleSceneStartHPGain2

        _B04F
        rtl

        .databank 0

        ; 95/B050

      rlBattleSceneGetCombatantGap ; 95/B050

        .al
        .xl
        .autsiz
        .databank ?

        ; wR0 = the distance between the attacker and the defender, wR1 = the room between the attacker's reach and the defender's body.

        phx
        phy
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationX,b,x
        ldx wBattleAnimationDefenderOffset,b
        sec
        sbc wBattleAnimationX,b,x
        bpl _B065
        eor #$FFFF
        inc a

        _B065
        sta wR0
        ldx wBattleAnimationAttackerOffset,b
        jsl rlBattleAnimationGetSpacing
        sta wR8
        ldx wBattleAnimationDefenderOffset,b
        jsl rlBattleAnimationGetBodyWidth
        sta wR9
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        sta wR1
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationX,b,x
        sta wR2
        lda wR2
        cmp wR1
        bcc _B0AC
        lda wR8
        clc
        adc wR9
        clc
        adc wR1
        pha
        lda wR2
        sec
        sbc #1,s
        bcs _B0A7
        pla
        lda #$0000
        sta wR1
        bra _B0C7


        _B0A7
        sta wR1
        pla
        bra _B0C7


        _B0AC
        lda wR8
        clc
        adc wR9
        clc
        adc wR2
        pha
        lda wR1
        sec
        sbc #1,s
        bcs _B0C4
        pla
        lda #$0000
        sta wR1
        bra _B0C7


        _B0C4
        sta wR1
        pla

        _B0C7
        jsl rlUnknown95B0D7
        bcc _B0D4
        lda #$0000
        sta wR0
        sta wR1

        _B0D4
        ply
        plx
        rtl

        .databank 0

        ; 95/B0D7

      rlUnknown95B0D7 ; 95/B0D7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx wBattleAnimationAttackerOffset,b
        lda wBattleAnimationX,b,x
        ldx wBattleAnimationDefenderOffset,b
        sec
        sbc wBattleAnimationX,b,x
        bpl _B0EC
        eor #$FFFF
        inc a

        _B0EC
        sta wR9
        ldx wBattleAnimationAttackerOffset,b
        jsl rlBattleAnimationGetBodyWidth
        pha
        ldx wBattleAnimationDefenderOffset,b
        jsl rlBattleAnimationGetBodyWidth
        clc
        adc #1,s
        sta #1,s
        pla
        cmp wR9
        bcc _B10D
        sec
        sbc wR9
        sec
        bra _B111


        _B10D
        lda #$0000
        clc

        _B111
        ply
        plx
        rtl

        .databank 0

        ; 95/B114

    .endsection Unsorted95AEA2Section


    .section Unreferenced95B114Section

      .al
      .xl

      rsUnknown95B114 ; 95/B114

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wBattleAnimationAttackerOffset,b
        clc
        adc #$0086
        tax
        lda bBattleAnimationStateFlags,b,x
        bit #$0080
        bne _B12A
        lda #$FFFF
        bra _B13A


        _B12A
        lda wBattleAnimationX,b,x
        ldx wBattleAnimationDefenderOffset,b
        sec
        sbc wBattleAnimationX,b,x
        bpl _B13A
        eor #$FFFF
        inc a

        _B13A
        sta wR0
        cmp #$000A
        bcs _B14D
        sep #$20
        lda bBattleSceneStrikeFlags,b
        ora #$20
        sta bBattleSceneStrikeFlags,b
        rep #$20

        _B14D
        plx
        rts

        .databank 0

        ; 95/B14F

      rsUnknown95B14F ; 95/B14F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FEC1D
        bit #$0080
        bne _B15E
        lda #$FFFF
        bra _B16F


        _B15E
        lda $7FEC1F
        ldx wBattleAnimationDefenderOffset,b
        sec
        sbc wBattleAnimationX,b,x
        bpl _B16F
        eor #$FFFF
        inc a

        _B16F
        sta wR0
        cmp #$000A
        bcs _B182
        sep #$20
        lda bBattleSceneStrikeFlags,b
        ora #$20
        sta bBattleSceneStrikeFlags,b
        rep #$20

        _B182
        plx
        rts

        .databank 0

        ; 95/B184

    .endsection Unreferenced95B114Section
    .section Unsorted978000Section

      .al
      .xl

      rlBattleScenePlayHolyWeaponSound ; 97/8000

        .al
        .xl
        .autsiz
        .databank ?

        ; X = 0 or $43: plays sound $90 panned to the combatant's place on screen (combatant 1 adds $2000).

        lda wBattleAnimationX,b,x
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        jsl rlGetSoundPanFromXPixel
        cpx #$0000
        bne _8018
        clc
        adc #$2000

        _8018
        pha
        lda #$0090
        ora #1,s
        jsl rlPlaySoundEffect2
        pla
        rtl

        .databank 0

        ; 97/8024

    .endsection Unsorted978000Section


    .section Unreferenced978024Section

      .al
      .xl

      rlUnknown978024 ; 97/8024

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000B
        jsl rlPlaySoundEffect2
        rtl

        .databank 0

        ; 97/802C

    .endsection Unreferenced978024Section
