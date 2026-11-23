; The battle scene's HUD: each combatant's HP (numbers and bar, changed by
; rsBattleSceneUpdateHP1/2), the name and stat windows, and the experience bar
; and level up windows. Much here is still Unknown.


    .section Unsorted95938CSection

      .al
      .xl

      rsBattleSceneUpdateHP2 ; 95/938C

        .al
        .xl
        .autsiz
        .databank ?

        ; rsBattleSceneUpdateHP1 for aBattleSceneCombatant2.

        lda aBattleSceneCombatant2.HPSpeed,b
        bne _9395
        jml _944A


        _9395
        lda aBattleSceneCombatant2.HPSpeed,b
        bmi _93FA
        lda #$2940
        pha
        lda aBattleSceneCombatant2.HP,b
        clc
        adc aBattleSceneCombatant2.HPSpeed,b
        and #$FF00
        pha
        lda aBattleSceneCombatant2.HP,b
        and #$FF00
        cmp #1,s
        beq _93BA
        lda #$000D
        jsl rlPlaySoundEffect

        _93BA
        pla
        lda aBattleSceneCombatant2.HP,b
        clc
        adc aBattleSceneCombatant2.HPSpeed,b
        bcc _93CD
        lda aBattleSceneCombatant2.MaxHP,b
        and #$00FF
        xba
        bra _93F0


        _93CD
        sta aBattleSceneCombatant2.HP,b
        xba
        sep #$20
        cmp aBattleSceneCombatant2.MaxHP,b
        bcc _93E0
        lda aBattleSceneCombatant2.MaxHP,b
        xba
        lda #$00
        bra _93F0


        _93E0
        cmp aBattleSceneCombatant2.HPTarget,b
        bcc _93ED
        lda aBattleSceneCombatant2.HPTarget,b
        xba
        lda #$00
        bra _93F0


        _93ED
        xba
        bra _9441


        _93F0
        .al
        rep #$20
        sta aBattleSceneCombatant2.HP,b
        stz aBattleSceneCombatant2.HPSpeed,b
        bra _9446


        _93FA
        lda #$3540
        pha
        lda aBattleSceneCombatant2.HPSpeed,b
        eor #$FFFF
        inc a
        sta wR0
        lda aBattleSceneCombatant2.HP,b
        sec
        sbc wR0
        bcs _9415
        lda #$0000
        xba
        bra _942D


        _9415
        sta aBattleSceneCombatant2.HP,b
        xba
        sep #$20
        cmp aBattleSceneCombatant2.HPTarget,b
        beq _9422
        bcs _942A

        _9422
        lda aBattleSceneCombatant2.HPTarget,b
        xba
        lda #$00
        bra _942D


        _942A
        xba
        bra _9441


        _942D
        rep #$20
        sta aBattleSceneCombatant2.HP,b
        stz aBattleSceneCombatant2.HPSpeed,b
        sep #$20
        lda #$10
        sta $7FE1C1
        rep #$20
        bra _9446


        _9441
        .as
        rep #$20
        sta aBattleSceneCombatant2.HP,b

        _9446
        pla
        jsr rsBattleSceneDrawHP2

        _944A
        lda $7FE1C1
        and #$00FF
        beq _9473
        dec a
        sep #$20
        sta $7FE1C1
        rep #$20
        beq _946D
        tax
        lda aUnknown95937C,x
        and #$00FF
        bne _946D
        lda #$3540
        bra _9470


        _946D
        lda #$2940

        _9470
        jsr rsBattleSceneDrawHP2

        _9473
        rts

        .databank 0

        ; 95/9474

      rsBattleSceneStartHPGain1 ; 95/9474

        .al
        .xl
        .autsiz
        .databank ?

        ; Combatant 1's HP rises by wR0 over A frames.

        jsl rlBattleSceneGetHPSpeed
        sta aBattleSceneCombatant1.HPSpeed,b
        sep #$20
        lda aBattleSceneCombatant1.HP+1,b
        clc
        adc wR0
        bcc _9487
        lda #$FF

        _9487
        sta aBattleSceneCombatant1.HPTarget,b
        rep #$20
        rts

        .databank 0

        ; 95/948D

      rsBattleSceneStartHPLoss1 ; 95/948D

        .al
        .xl
        .autsiz
        .databank ?

        ; Combatant 1's HP falls by wR0 over A frames.

        jsl rlBattleSceneGetHPSpeed
        eor #$FFFF
        inc a
        sta aBattleSceneCombatant1.HPSpeed,b
        sep #$20
        lda aBattleSceneCombatant1.HP+1,b
        sec
        sbc wR0
        bcs _94A4
        lda #$00

        _94A4
        sta aBattleSceneCombatant1.HPTarget,b
        rep #$20
        rts

        .databank 0

        ; 95/94AA

      rsBattleSceneStartHPGain2 ; 95/94AA

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlBattleSceneGetHPSpeed
        sta aBattleSceneCombatant2.HPSpeed,b
        sep #$20
        lda aBattleSceneCombatant2.HP+1,b
        clc
        adc wR0
        bcc _94BD
        lda #$FF

        _94BD
        sta aBattleSceneCombatant2.HPTarget,b
        rep #$20
        rts

        .databank 0

        ; 95/94C3

      rsBattleSceneStartHPLoss2 ; 95/94C3

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlBattleSceneGetHPSpeed
        eor #$FFFF
        inc a
        sta aBattleSceneCombatant2.HPSpeed,b
        sep #$20
        lda aBattleSceneCombatant2.HP+1,b
        sec
        sbc wR0
        bcs _94DA
        lda #$00

        _94DA
        sta aBattleSceneCombatant2.HPTarget,b
        rep #$20
        rts

        .databank 0

        ; 95/94E0

      rlBattleSceneGetHPSpeed ; 95/94E0

        .al
        .xl
        .autsiz
        .databank ?

        ; A = wR0 * 256 / A (A 0 counts as 1): the 8.8 HP change a frame.

        phx
        cmp #$0000
        bne _94E9
        lda #$0001

        _94E9
        sta wR14
        lda wR0
        xba
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        plx
        rtl

        .databank 0

        ; 95/94F8

    .endsection Unsorted95938CSection


    .section Unsorted9594F8Section

      .al
      .xl

      rsBattleSceneDrawHP1 ; 95/94F8

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws combatant 1's HP as two digits and its HP bar into the HUD tilemap buffer.

        pha
        lda aBattleSceneCombatant1.Character,b
        cmp #$0000
        bne _9504
        pla
        bra _9536


        _9504
        lda #$0002
        sta wR0
        lda #$2C00
        sta wR1
        lda aBattleSceneCombatant1.HP,b
        xba
        and #$00FF
        ldx #$0A62
        jsl rlBattleSceneDrawNumber
        lda aBattleSceneCombatant1.HP+1,b
        and #$00FF
        sta wR0
        lda aBattleSceneCombatant1.MaxHP,b
        and #$00FF
        sta wR1
        pla
        sta wR3
        ldx #$0A66
        jsl rlBattleSceneDrawHPBar

        _9536
        rts

        .databank 0

        ; 95/9537

      rsBattleSceneDrawHP2 ; 95/9537

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda aBattleSceneCombatant2.Character,b
        cmp #$0000
        bne _9543
        pla
        bra _9575


        _9543
        lda #$0002
        sta wR0
        lda #$2400
        sta wR1
        lda aBattleSceneCombatant2.HP,b
        xba
        and #$00FF
        ldx #$0A44
        jsl rlBattleSceneDrawNumber
        lda aBattleSceneCombatant2.HP+1,b
        and #$00FF
        sta wR0
        lda aBattleSceneCombatant2.MaxHP,b
        and #$00FF
        sta wR1
        pla
        sta wR3
        ldx #$0A48
        jsl rlBattleSceneDrawHPBar

        _9575
        rts

        .databank 0

        ; 95/9576

      rlBattleSceneDrawNumber ; 95/9576

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws A right-aligned as wR0 digits ending at X in the tilemap buffer at $7FC800, with attributes wR1; leading zeroes blank.

        pha
        phx
        pha
        lda wR0
        and #$007F
        bne _9583
        pla
        bra _95C7


        _9583
        sta wR0
        dec a
        asl a
        pha
        txa
        clc
        adc #1,s
        tax
        pla
        pla
        bra _95A4


        _9591
        bit #$FFFF
        bne _95A4
        lda #$01FF
        ora wR1
        sta $7FC800,x
        lda #$0000
        bra _95C1


        _95A4
        sta wR13
        pha
        lda #$000A
        sta wR14
        phx
        jsl rlUnknown959C3E
        plx
        pla
        lda wR10
        clc
        adc #$0150
        ora wR1
        sta $7FC800,x
        lda wR13

        _95C1
        dec x
        dec x
        dec wR0
        bne _9591

        _95C7
        plx
        pla
        rtl

        .databank 0

        ; 95/95CA

    .endsection Unsorted9594F8Section


    .section Unsorted9595CASection

      .al
      .xl

      rlUnknown9595CA ; 95/95CA

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        cmp #$00FF
        bcc _95E5
        lda #$015A
        ora wR1
        sta $7FC804,x
        lda #$015A
        ora wR1
        sta $7FC802,x
        bra _964D


        _95E5
        cmp #$0064
        bne _95FE
        lda #$015C
        ora wR1
        sta $7FC804,x
        lda #$015B
        ora wR1
        sta $7FC802,x
        bra _964D


        _95FE
        pha
        lda wR0
        and #$007F
        bne _9609
        pla
        bra _964D


        _9609
        sta wR0
        dec a
        asl a
        pha
        txa
        clc
        adc #1,s
        tax
        pla
        pla
        bra _962A


        _9617
        bit #$FFFF
        bne _962A
        lda #$01FF
        ora wR1
        sta $7FC800,x
        lda #$0000
        bra _9647


        _962A
        sta wR13
        pha
        lda #$000A
        sta wR14
        phx
        jsl rlUnknown959C3E
        plx
        pla
        lda wR10
        clc
        adc #$0150
        ora wR1
        sta $7FC800,x
        lda wR13

        _9647
        dec x
        dec x
        dec wR0
        bne _9617

        _964D
        plx
        pla
        rtl

        .databank 0

        ; 95/9650

    .endsection Unsorted9595CASection


    .section Unreferenced959650Section

      .al
      .xl

      rlUnknown959650 ; 95/9650

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        cmp #$000A
        bcs _9664
        pha
        lda #$00FF
        ora wR1
        sta $7FC800,x
        pla
        bra _967F


        _9664
        sta wR13
        lda #$000A
        sta wR14
        phx
        jsl rlUnknown959C3E
        plx
        lda wR13
        clc
        adc #$0040
        ora wR1
        sta $7FC800,x
        lda wR10

        _967F
        inc x
        inc x
        clc
        adc #$004A
        ora wR1
        sta $7FC800,x
        plx
        pla
        rtl

        .databank 0

        ; 95/968E

    .endsection Unreferenced959650Section
    .section Unsorted95968ESection

      .al
      .xl

      rlUnknown95968E ; 95/968E

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        pha
        lda wR0
        and #$007F
        bne _969B
        pla
        bra _96EB


        _969B
        sta wR0
        dec a
        asl a
        pha
        txa
        clc
        adc #1,s
        tax
        pla
        pla
        bra _96BC


        _96A9
        bit #$FFFF
        bne _96BC
        lda #$00FF
        ora wR1
        sta $7FC800,x
        lda #$0000
        bra _96E5


        _96BC
        sta wR13
        pha
        lda #$000A
        sta wR14
        phx
        jsl rlUnknown959C3E
        plx
        pla
        lda wR10
        clc
        adc #$0022
        ora wR1
        sta $7FC800,x
        lda wR10
        clc
        adc #$0032
        ora wR1
        sta $7FC840,x
        lda wR13

        _96E5
        dec x
        dec x
        dec wR0
        bne _96A9

        _96EB
        plx
        pla
        rtl

        .databank 0

        ; 95/96EE

      rlUnknown9596EE ; 95/96EE

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        pha
        lda wR0
        and #$007F
        bne _96FB
        pla
        bra _973F


        _96FB
        sta wR0
        dec a
        asl a
        pha
        txa
        clc
        adc #1,s
        tax
        pla
        pla
        bra _971C


        _9709
        bit #$FFFF
        bne _971C
        lda #$00FF
        ora wR1
        sta $7FC800,x
        lda #$0000
        bra _9739


        _971C
        sta wR13
        pha
        lda #$000A
        sta wR14
        phx
        jsl rlUnknown959C3E
        plx
        pla
        lda wR10
        clc
        adc #$0040
        ora wR1
        sta $7FC800,x
        lda wR13

        _9739
        dec x
        dec x
        dec wR0
        bne _9709

        _973F
        plx
        pla
        rtl

        .databank 0

        ; 95/9742

      rlUnknown959742 ; 95/9742

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        lda wR0
        beq _975C
        sta wR10
        lda wR2
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1
        and #$00FF
        bne _975A
        inc a

        _975A
        sta wR0

        _975C
        lda wR1
        beq _9774
        sta wR10
        lda wR2
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1
        and #$00FF
        bne _9772
        inc a

        _9772
        sta wR1

        _9774
        lda #$0006
        sta wR2
        lda wR0
        cmp #$0007
        bcc _9782
        lda wR2

        _9782
        pha
        clc
        adc #$0000
        clc
        adc wR3
        sta $7FC800,x
        inc x
        inc x
        lda wR0
        sec
        sbc #1,s
        sta wR0
        pla

        _9798
        lda wR2
        clc
        adc #$0008
        cmp wR1
        beq _97A4
        bcs _97C8

        _97A4
        sta wR2
        lda wR0
        cmp #$0009
        bcc _97B0
        lda #$0008

        _97B0
        pha
        clc
        adc #$0007
        clc
        adc wR3
        sta $7FC800,x
        inc x
        inc x
        lda wR0
        sec
        sbc #1,s
        sta wR0
        pla
        bra _9798


        _97C8
        lda wR1
        sec
        sbc wR2
        pha
        phx
        tax
        lda aUnknown98ACB8,x
        and #$00FF
        plx
        clc
        adc wR0
        clc
        adc #$0010
        ora wR3
        sta $7FC800,x
        pla
        cmp #$0007
        bne _97F7
        inc x
        inc x
        lda #$0034
        clc
        adc wR3
        sta $7FC800,x

        _97F7
        plx
        pla
        rtl

        .databank 0

        ; 95/97FA

    .endsection Unsorted95968ESection


    .section Unsorted9597FASection

      .al
      .xl

      rlBattleSceneDrawHPBar ; 95/97FA

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws an HP bar of wR0 out of wR1 (at most 80) at X in the tilemap buffer.

        pha
        phx
        lda wR1
        cmp #$0050
        bcc _9808
        lda #$0050
        sta wR1

        _9808
        lda wR0
        cmp wR1
        bcc _9812
        lda wR1
        sta wR0

        _9812
        stz wR9

        _9814
        lda wR9
        cmp #$000A
        bcc _9831
        lda aUnknown959890
        and #$00FF
        clc
        adc wR3
        sta $7FC800,x
        txa
        sec
        sbc #$0054
        tax
        stz wR9

        _9831
        lda wR1
        cmp #$0004
        bcc _986D
        lda aUnknown959894
        and #$00FF
        pha
        lda wR0
        cmp #$0004
        bcc _9852
        sec
        sbc #$0004
        sta wR0
        lda #$0004
        bra _9854


        _9852
        stz wR0

        _9854
        clc
        adc #1,s
        clc
        adc wR3
        sta $7FC800,x
        pla
        lda wR1
        sec
        sbc #$0004
        sta wR1
        inc wR9
        inc x
        inc x
        bra _9814


        _986D
        phx
        tax
        cmp #$0000
        bne _987B
        lda wR9
        bne _987B
        plx
        bra _988D


        _987B
        lda aUnknown959890,x
        and #$00FF
        clc
        adc wR0
        plx
        clc
        adc wR3
        sta $7FC800,x

        _988D
        plx
        pla
        rtl

        .databank 0

        ; 95/9890

    .endsection Unsorted9597FASection


    .section Table959890Section

      .al
      .xl

      aUnknown959890 ; 95/9890

        ; Read by rlBattleSceneDrawHPBar.

        .word $0C0E, $0509

        ; 95/9894

    .endsection Table959890Section


    .section Unsorted959895Section

      .al
      .xl

      rsUnknown959895 ; 95/9895

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        ldy #$0000
        ldx #$0000
        lda #$000A

        _98A1
        pha
        cmp #$0006
        bcc _98AC
        lda #$2C00
        bra _98AF


        _98AC
        lda #$2400

        _98AF
        sta wR1
        lda #$0002
        sta wR0
        lda aUnknown98AC86,x
        inc x
        inc x
        pha
        lda aUnknown98AC86,x
        sta lR18
        inc x
        lda aUnknown98AC86,x
        sta lR18+1
        inc x
        inc x
        pla
        phx
        tax
        lda [lR18],y
        cmp #$0064
        bcc _98DA
        inc wR0
        dec x
        dec x

        _98DA
        jsl rlUnknown9595CA
        plx
        pla
        dec a
        bne _98A1
        ply
        plx
        pla
        rts

        .databank 0

        ; 95/98E7

    .endsection Unsorted959895Section


    .section Unsorted9598E7Section

      .al
      .xl

      rlUnknown9598E7 ; 95/98E7

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        lda #$7F00
        sta lR18+1
        lda #$D204
        sta lR18
        ldy #$6D02
        lda #$0078
        jsl rlUnknown95C43E
        ply
        plx
        pla
        rtl

        .databank 0

        ; 95/9902

    .endsection Unsorted9598E7Section


    .section Unsorted959902Section

      .al
      .xl

      rlUnknown959902 ; 95/9902

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>gcUnknownE02EBD
        stx DecompressionVariables
        lda #`gcUnknownE02EBD
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0400, $80, $FC00

        sep #$20
        rep #$10
        ldx #<>gcUnknownE03539
        stx DecompressionVariables
        lda #`gcUnknownE03539
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8B88, $0400, $80, $F400

        jsl rlUnknown9680C2
        sep #$20
        rep #$10
        ldx #<>gcUnknownE03A1D
        stx DecompressionVariables
        lda #`gcUnknownE03A1D
        sta $CA
        ldx #$C800
        stx $CB
        lda #$7F
        sta $CD
        jsl rlDecompressor
        rep #$30
        lda #$7F00
        sta lR18+1
        lda #$C800
        sta lR18
        lda #$00FF
        jsl rlUnknown959B49
        jsl rlDMAByStruct

          .structDMAToVRAM $7FC800, $03C0, $80, $D000

        sep #$20
        rep #$10
        ldx #<>gcUnknownE03C68
        stx DecompressionVariables
        lda #`gcUnknownE03C68
        sta $CA
        ldx #$D0C0
        stx $CB
        lda #$7F
        sta $CD
        jsl rlDecompressor
        rep #$30
        jsr rsUnknown959895
        lda #$7F00
        sta lR18+1
        lda #$D0C0
        sta lR18
        lda #$01FF
        jsl rlUnknown959B49
        lda #$2940
        jsr rsBattleSceneDrawHP1
        lda #$2940
        jsr rsBattleSceneDrawHP2
        jsl rlUnknown9599E7
        jsl rlUnknown9699DD
        jsl rlDMAByStruct

          .structDMAToVRAM $7FD0C0, $03C0, $80, $D8C0

        jsr rsUnknown959A4D
        rtl

        .databank 0

        ; 95/99E7

    .endsection Unsorted959902Section


    .section Unsorted9599E7Section

      .al
      .xl

      rlUnknown9599E7 ; 95/99E7

        .al
        .autsiz
        .databank ?

        lda #$2940
        jsr rsBattleSceneDrawHP1

        lda #$2940
        jsr rsBattleSceneDrawHP2

        ldx #2
        
          -
          lda aUnknownE00060,x
          sta $0100,b,x
          inc x
          inc x
          cpx #32
          bcc -

        lda wBattleType
        and #$00FF
        cmp #$00FF
        bne +

        lda aActionStructUnit1.UnitRAMPointer
        bra ++
        
        +
        lda aActionStructUnit1.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleHUDColorID

        +
        jsr rsUnknown959B84

        lda wBattleType
        and #$00FF
        cmp #$00FF
        bne +

        lda aActionStructUnit2.UnitRAMPointer
        bra ++
        
        +
        lda aActionStructUnit2.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleHUDColorID
        
        +
        jsr rsUnknown959BC1
        rtl

        .databank 0

      rsUnknown959A4D ; 95/9A4D

        .al
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>aUnknown9CEAEE
        stx DecompressionVariables.lSource
        lda #`aUnknown9CEAEE
        sta DecompressionVariables.lSource+2
        ldx #<>aDecompressionBuffer
        stx $CB
        lda #`aDecompressionBuffer
        sta $CD
        jsl rlDecompressor
        rep #$30

        lda wBattleType
        and #$00FF
        cmp #$00FF
        bne +

        lda aActionStructUnit1.XPosition
        bra ++
        
        +
        lda aActionStructUnit1.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleBannerID
        
        +
        asl a
        pha
        asl a
        clc
        adc #1,s
        tax
        pla

        lda aBattleBannerTable+1,x
        sta lR45+1
        lda aBattleBannerTable,x
        sta lR45
        lda #(`$7FC200)<<8
        sta lR47+1
        lda #<>$7FC200
        sta lR47
        phx
        jsl rlDecompressSingle
        plx

        lda aBattleBannerTable+3+1,x
        sta lR18+1
        lda aBattleBannerTable+3,x
        sta lR18
        ldx #0
        ldy #0
        
        -
        lda [lR18],y
        sta $01D2,b,x
        sta $7FC1F0,x
        inc y
        inc y
        inc x
        inc x
        cpx #14
        bcc -

        lda wBattleType
        and #$00FF
        cmp #$00FF
        bne +

        lda aActionStructUnit2.XPosition
        bra ++
        
        +
        lda aActionStructUnit2.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleBannerID
        
        +
        asl a
        pha
        asl a
        clc
        adc #1,s
        tax
        pla

        lda aBattleBannerTable+1,x
        sta lR45+1
        lda aBattleBannerTable,x
        sta lR45
        lda #(`$7FC000)<<8
        sta lR47+1
        lda #<>$7FC000
        sta lR47
        phx
        jsl rlDecompressSingle
        plx

        lda aBattleBannerTable+3+1,x
        sta lR18+1
        lda aBattleBannerTable+3,x
        sta lR18

        ldx #0
        ldy #0
        
        -
        lda [lR18],y
        sta $01F2,b,x
        sta $7FC3F0,x
        inc y
        inc y
        inc x
        inc x
        cpx #14
        bcc -

        jsl rlDMAByStruct

          .structDMAToVRAM $7FC000, $0400, $80, $F000

        rts

        .databank 0

        ; 95/9B49

    .endsection Unsorted9599E7Section


    .section Unsorted959B49Section

      .al
      .xl

      rlUnknown959B49 ; 95/9B49

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        pha
        lda aBattleSceneCombatant1.Character,b
        cmp #$0000
        beq _9B5E
        lda aBattleSceneCombatant2.Character,b
        cmp #$0000
        beq _9B63
        bra _9B80


        _9B5E
        ldy #$0020
        bra _9B66


        _9B63
        ldy #$0000

        _9B66
        lda #$000A

        _9B69
        pha
        ldx #$0010
        lda #3,s

        _9B6F
        sta [lR18],y
        inc y
        inc y
        dec x
        bne _9B6F
        tya
        clc
        adc #$0020
        tay
        pla
        dec a
        bne _9B69

        _9B80
        pla
        ply
        plx
        rtl

        .databank 0

        ; 95/9B84

    .endsection Unsorted959B49Section


    .section Unsorted959B84Section

      .al
      .xl

      rsUnknown959B84 ; 95/9B84

        .al
        .autsiz
        .databank ?

        phx
        phy
        and #$00FF
        asl a
        pha
        asl a
        pha
        asl a
        asl a
        clc
        adc #1,s
        clc
        adc #3,s
        tax
        pla
        pla

        ldy #0

          -
          lda aUnknown998944,x
          sta $01C2,b,y
          inc x
          inc x
          inc y
          inc y
          cpy #16
          bcc -

        ldy #0
        
          -
          lda aUnknown998944,x
          sta $011A,b,y
          inc x
          inc x
          inc y
          inc y
          cpy #6
          bcc -

        ply
        plx
        rts

        .databank 0

        ; 95/9BC1

    .endsection Unsorted959B84Section


    .section Unsorted959BC1Section

      .al
      .xl

      rsUnknown959BC1 ; 95/9BC1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        and #$00FF
        asl a
        pha
        asl a
        pha
        asl a
        asl a
        clc
        adc #1,s
        clc
        adc #3,s
        tax
        pla
        pla
        ldy #$0000

        _9BD8
        lda aUnknown998944,x
        sta $01E2,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bcc _9BD8
        ldy #$0000

        _9BEB
        lda aUnknown998944,x
        sta $010A,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0006
        bcc _9BEB
        ply
        plx
        rts

        .databank 0

        ; 95/9BFE

    .endsection Unsorted959BC1Section


    .section Unreferenced959BFESection

      .al
      .xl

      rsUnknown959BFE ; 95/9BFE

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        pha
        sep #$20
        lda bBattleSceneRoundState,b
        ora #$08
        sta bBattleSceneRoundState,b
        rep #$20
        lda #$003C
        sta $7FED5A
        pla
        rts

        .databank 0

        ; 95/9C14

    .endsection Unreferenced959BFESection
    .section Unsorted959C3ESection

      .al
      .xl

      rlUnknown959C3E ; 95/9C3E

        .al
        .xl
        .autsiz
        .databank ?

        php
        pha
        phx
        lda wR13
        sta $4204,b
        sep #$20
        lda wR14
        sta $4206,b
        rep #$20
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        lda $4214,b
        sta wR13
        lda $4216,b
        sta wR10
        plx
        pla
        plp
        rtl

        .databank 0

        ; 95/9C64

    .endsection Unsorted959C3ESection


    .section Unsorted9680C2Section

      .al
      .xl

      rlUnknown9680C2 ; 96/80C2

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown9680CC
        jsr rsUnknown9680F7
        jsr rsUnknown9680E9
        rtl

        .databank 0

        ; 96/80CC

      rsUnknown9680CC ; 96/80CC

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>gcUnknownC00A2B
        stx DecompressionVariables
        lda #`gcUnknownC00A2B
        sta $CA
        ldx #$8B88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        rts

        .databank 0

        ; 96/80E9

      rsUnknown9680E9 ; 96/80E9

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM $7EAC88, $0400, $80, $F800

        rts

        .databank 0

        ; 96/80F7

      rsUnknown9680F7 ; 96/80F7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda aBattleSceneCombatant2.Character,b
        cmp #$0000
        beq _8128
        ldx #$0100
        jsl rlGetCharacterNamePointer
        jsr rsUnknown96815A
        jsr rsUnknown968179
        lda aBattleSceneCombatant2.Weapon,b
        ldx #$0000
        cmp #$FFFF
        bne _811E
        jsr rsUnknown9682E8
        bra _8128


        _811E
        jsl rlGetItemNamePointerByItemID
        jsr rsUnknown96815A
        jsr rsUnknown9681B3

        _8128
        lda aBattleSceneCombatant1.Character,b
        cmp #$0000
        beq _8157
        ldx #$0300
        jsl rlGetCharacterNamePointer
        jsr rsUnknown96815A
        jsr rsUnknown968196
        lda aBattleSceneCombatant1.Weapon,b
        ldx #$0200
        cmp #$FFFF
        bne _814D
        jsr rsUnknown9682E8
        bra _8157


        _814D
        jsl rlGetItemNamePointerByItemID
        jsr rsUnknown96815A
        jsr rsUnknown9681D0

        _8157
        ply
        plx
        rts

        .databank 0

        ; 96/815A

      rsUnknown96815A ; 96/815A

        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldy #$0000

        _8168
        lda [lR18],y
        beq _8173
        inc y
        inc y
        cpy #$0010
        bcc _8168

        _8173
        tya
        lsr a
        sta wR0
        ply
        rts

        .databank 0

        ; 96/8179

      rsUnknown968179 ; 96/8179

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #$0008
        sec
        sbc wR0
        beq _818A

        _8182
        pha
        jsr rsUnknown9682CD
        pla
        dec a
        bne _8182

        _818A
        lda wR0

        _818C
        pha
        jsr rsUnknown9681ED
        pla
        dec a
        bne _818C
        pla
        rts

        .databank 0

        ; 96/8196

      rsUnknown968196 ; 96/8196

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda wR0

        _8199
        pha
        jsr rsUnknown9681ED
        pla
        dec a
        bne _8199
        lda #$0008
        sec
        sbc wR0
        beq _81B1

        _81A9
        pha
        jsr rsUnknown9682CD
        pla
        dec a
        bne _81A9

        _81B1
        pla
        rts

        .databank 0

        ; 96/81B3

      rsUnknown9681B3 ; 96/81B3

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #$0008
        sec
        sbc wR0
        beq _81C4

        _81BC
        pha
        jsr rsUnknown9682CD
        pla
        dec a
        bne _81BC

        _81C4
        lda wR0

        _81C6
        pha
        jsr rsUnknown96824C
        pla
        dec a
        bne _81C6
        pla
        rts

        .databank 0

        ; 96/81D0

      rsUnknown9681D0 ; 96/81D0

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda wR0

        _81D3
        pha
        jsr rsUnknown96824C
        pla
        dec a
        bne _81D3
        lda #$0008
        sec
        sbc wR0
        beq _81EB

        _81E3
        pha
        jsr rsUnknown9682CD
        pla
        dec a
        bne _81E3

        _81EB
        pla
        rts

        .databank 0

        ; 96/81ED

      rsUnknown9681ED ; 96/81ED

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phy
        ldy #$0000
        lda [lR18],y
        jsl rlUnknown879DD1
        lda #$7E00
        sta lR19+1
        lda wR10
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$8B88
        sta lR19
        ldy #$0000

        _820C
        lda [lR19],y
        sta $7EAC88,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bcc _820C
        phx
        lda wR11
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$8B88
        sta lR19
        txa
        clc
        adc #$0070
        tax
        ldy #$0000

        _8231
        lda [lR19],y
        sta $7EAC88,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bcc _8231
        plx
        lda lR18
        clc
        adc #$0002
        sta lR18
        ply
        pla
        rts

        .databank 0

        ; 96/824C

      rsUnknown96824C ; 96/824C

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phy
        ldy #$0000
        lda [lR18],y
        jsl rlUnknown879DD1
        lda #$7E00
        sta lR19+1
        lda wR10
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$8B88
        sta lR19
        ldy #$0004

        _826B
        lda [lR19],y
        sta $7EAC88,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bcc _826B
        lda wR11
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$8B88
        sta lR19
        ldy #$0000
        lda [lR19],y
        sta $7EAC88,x
        ldy #$0002
        lda [lR19],y
        sta $7EAC8A,x
        txa
        clc
        adc #$0004
        pha
        txa
        clc
        adc #$0074
        tax
        ldy #$0004

        _82A7
        lda [lR19],y
        sta $7EAC88,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bcc _82A7
        lda #$0000
        sta $7EAC88,x
        sta $7EAC8A,x
        plx
        lda lR18
        clc
        adc #$0002
        sta lR18
        ply
        pla
        rts

        .databank 0

        ; 96/82CD

      rsUnknown9682CD ; 96/82CD

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phy
        ldy #$0000
        lda #$0000

        _82D5
        sta $7EAC88,x
        sta $7EAD08,x
        inc x
        inc x
        inc y
        cpy #$0008
        bcc _82D5
        ply
        pla
        rts

        .databank 0

        ; 96/82E8

      rsUnknown9682E8 ; 96/82E8

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        lda #$0008

        _82EE
        jsr rsUnknown9682CD
        dec a
        bne _82EE
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/82F8

      rlUnknown9682F8 ; 96/82F8

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7FED4E
        rtl

        .databank 0

        ; 96/8300

      rlBattleSceneShowExperience ; 96/8300

        .al
        .xl
        .autsiz
        .databank ?

        ; When aActionStructUnit1 gained experience, starts script 0 (the experience bar).

        lda wBattleSceneExperienceGained,b
        beq _830C
        lda #$0000
        jsl rlStartBattleSceneScript

        _830C
        rtl

        .databank 0

        ; 96/830D

      rlUnknown96830D ; 96/830D

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda wBattleSceneExperience,b
        and #$00FF
        xba
        sta $7FED4B
        lda wBattleSceneExperienceGained,b
        sta wR0
        jsl rlBattleSceneGetHPSpeed
        sta $7FED4E
        lda wBattleSceneExperience,b
        clc
        adc wBattleSceneExperienceGained,b
        sta $7FED50
        lda #$0191
        sta $7FED56
        lda #$3000
        sta $7FED58
        lda #$0BCE
        sta $7FED53
        sep #$20
        lda #$FF
        sta $7FED4D
        lda #$02
        sta $7FED52
        lda #$2C
        sta $7FED55
        rep #$20
        jsl rlUnknown9684AF
        rtl

        .databank 0

        ; 96/8360

      rlUnknown968360 ; 96/8360

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000B
        jsl rlPlaySoundEffect
        lda #(`rlUnknown968376)<<8
        sta $7FED00
        lda #<>rlUnknown968376
        sta $7FECFF
        rtl

        .databank 0

        ; 96/8376

      rlUnknown968376 ; 96/8376

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FED4E
        bne _838D
        lda #$000C
        jsl rlPlaySoundEffect
        jsl rlUnknown96C9FE
        jml _8415


        _838D
        lda $7FED4B
        clc
        adc $7FED4E
        bcc _83A2
        lda $7FED4D
        and #$00FF
        xba
        bra _83CA


        _83A2
        sta $7FED4B
        xba
        sep #$20
        cmp $7FED4D
        bcc _83B8
        lda $7FED4D
        xba
        lda #$00
        bra _83CA


        _83B8
        cmp $7FED50
        bcc _83C7
        lda $7FED50
        xba
        lda #$00
        bra _83CA


        _83C7
        xba
        bra _83F4


        _83CA
        rep #$20
        cmp #$6400
        bcc _83E3
        sec
        sbc #$6400
        pha
        lda $7FED50
        sec
        sbc #$0064
        sta $7FED50
        pla

        _83E3
        sta $7FED4B
        jsl rlUnknown9684AF
        lda #$0000
        sta $7FED4E
        bra _8415


        _83F4
        .as
        rep #$20
        cmp #$6400
        bcc _840D
        sec
        sbc #$6400
        pha
        lda $7FED50
        sec
        sbc #$0064
        sta $7FED50
        pla

        _840D
        sta $7FED4B
        jsl rlUnknown9684AF

        _8415
        ply
        plx
        rtl

        .databank 0

        ; 96/8418

      rlUnknown968418 ; 96/8418

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $7FED4E
        bne _8424
        jml _84AC


        _8424
        lda $7FED4B
        clc
        adc $7FED4E
        bcc _8439
        lda $7FED4D
        and #$00FF
        xba
        bra _8461


        _8439
        sta $7FED4B
        xba
        sep #$20
        cmp $7FED4D
        bcc _844F
        lda $7FED4D
        xba
        lda #$00
        bra _8461


        _844F
        cmp $7FED50
        bcc _845E
        lda $7FED50
        xba
        lda #$00
        bra _8461


        _845E
        xba
        bra _848B


        _8461
        rep #$20
        cmp #$6400
        bcc _847A
        sec
        sbc #$6400
        pha
        lda $7FED50
        sec
        sbc #$0064
        sta $7FED50
        pla

        _847A
        sta $7FED4B
        jsl rlUnknown968530
        lda #$0000
        sta $7FED4E
        bra _84AC


        _848B
        .as
        rep #$20
        cmp #$6400
        bcc _84A4
        sec
        sbc #$6400
        pha
        lda $7FED50
        sec
        sbc #$0064
        sta $7FED50
        pla

        _84A4
        sta $7FED4B
        jsl rlUnknown968530

        _84AC
        ply
        plx
        rtl

        .databank 0

        ; 96/84AF

      rlUnknown9684AF ; 96/84AF

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FED52
        and #$00FF
        sta wR0
        lda #$2C00
        sta wR1
        lda $7FED53
        tax
        lda $7FED4B
        xba
        and #$00FF
        jsl rlBattleSceneDrawNumber
        lda $7FED4C
        and #$00FF
        sta wR0
        lda $7FED4D
        and #$00FF
        cmp #$00FF
        bne _84E6
        lda #$0063

        _84E6
        sta wR1
        lda $7FED56
        cmp #$FFFF
        beq _850B
        sta wR2
        lda $7FED58
        sta wR3
        lda $7FED52
        and #$00FF
        asl a
        clc
        adc $7FED53
        tax
        jsl rlUnknown959742

        _850B
        lda #$7F00
        sta lR18+1
        lda $7FED53
        clc
        adc #$C800
        sta lR18
        lda $7FED53
        lsr a
        clc
        adc #$6800
        tay
        lda $7FED55
        and #$00FF
        jsl rlUnknown95C43E
        rtl

        .databank 0

        ; 96/8530

      rlUnknown968530 ; 96/8530

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FED4C
        and #$00FF
        sta wR0
        lda $7FED4D
        and #$00FF
        sta wR1
        lda $7FED56
        cmp #$FFFF
        beq _855B
        sta wR2
        lda #$2400
        sta wR3
        lda $7FED53
        tax
        jsl rlUnknown959742

        _855B
        lda $7FED52
        and #$00FF
        sta wR0
        lda #$2000
        sta wR1
        lda $7FED53
        clc
        adc #$F9C8
        tax
        lda $7FED4B
        xba
        and #$00FF
        pha
        lda $7FED56
        cmp #$FFFF
        beq _858B
        pla
        jsl rlUnknown9596EE
        bra _8590


        _858B
        pla
        jsl rlUnknown95968E

        _8590
        lda #$7F00
        sta lR18+1
        lda $7FED53
        clc
        adc #$C1C0
        sta lR18
        lda $7FED53
        lsr a
        clc
        adc #$64E0
        tay
        lda $7FED55
        and #$00FF
        jsl rlUnknown95C43E
        lda #$7F00
        sta lR18+1
        lda $7FED53
        clc
        adc #$C800
        sta lR18
        lda $7FED53
        lsr a
        clc
        adc #$6800
        tay
        lda $7FED55
        and #$00FF
        jsl rlUnknown95C43E
        rtl

        .databank 0

        ; 96/85D9

      rlUnknown9685D9 ; 96/85D9

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$9C
        sta $7FE4C5
        lda #$A1
        sta $7FE4CB
        rep #$20
        lda #$FFC3
        sta $7FE4C6
        lda #$00DB
        sta $7FE4C8
        sep #$20
        lda #$01
        sta $7FE4C2
        rep #$20
        lda #$9800
        sta $7FE4D3
        lda #$AD7E
        sta $7FE4D2
        lda #(`rlUnknown96861E)<<8
        sta $7FED00
        lda #<>rlUnknown96861E
        sta $7FECFF
        rtl

        .databank 0

        ; 96/861E

      rlUnknown96861E ; 96/861E

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phy
        lda $7FE4D2
        sta lR18
        lda $7FE4D3
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        cmp #$FFFF
        bne _863B
        jsl rlUnknown96C9FE
        bra _865A


        _863B
        pha
        sep #$20
        sta $7FE4C5
        xba
        sta $7FE4CB
        rep #$20
        pla
        jsl rlUnknown9695AE
        lda $7FE4D2
        clc
        adc #$0002
        sta $7FE4D2

        _865A
        ply
        rtl

        .databank 0

        ; 96/865C

      rlBattleScenePrepareLevelUp ; 96/865C

        .al
        .xl
        .autsiz
        .databank ?

        ; When aActionStructUnit1 gained a level, starts the script that leads into the level up: $40 when bit 0 of $7FF5AF is set, $3E for a staff of range 3 or more (Physic, Restore, Silence, Sleep, Berserk), $32 when combatant 1 attacks, else $3D.

        lda aActionStructUnit1.GainedLevels
        beq _86BA
        lda $7FF5AF
        bit #$0001
        beq _8674
        lda #$0040
        jsl rlStartBattleSceneScript
        bra _86BA


        _8674
        lda wBattleDistance
        cmp #$0003
        bcc _86A2
        lda aBattleSceneCombatant1.Weapon,b
        cmp #PhysicStaff
        beq _8699
        cmp #RestoreStaff
        beq _8699
        cmp #SilenceStaff
        beq _8699
        cmp #SleepStaff
        beq _8699
        cmp #BerserkStaff
        bne _86A2

        _8699
        lda #$003E
        jsl rlStartBattleSceneScript
        bra _86BA


        _86A2
        lda wBattleAnimationAttackerOffset,b
        cmp #$0000
        bne _86B3
        lda #$0032
        jsl rlStartBattleSceneScript
        bra _86BA


        _86B3
        lda #$003D
        jsl rlStartBattleSceneScript

        _86BA
        rtl

        .databank 0

        ; 96/86BB

      rlBattleSceneEndStepJulius2 ; 96/86BB

        .al
        .xl
        .autsiz
        .databank ?

        ; When the battle ends on Julius: script $4B if aActionStructUnit1 gained a level and bit 0 of $7FF5AF is set, else $3D.

        lda wBattleSceneFlags
        bit #BattleSceneFlagToMapMode3
        beq _86E6
        lda $7FF5AF
        bit #$0001
        beq _86DF
        lda aActionStructUnit1.GainedLevels
        and #$00FF
        beq _86DF
        lda #$004B
        jsl rlStartBattleSceneScript
        bra _86E6


        _86DF
        lda #$003D
        jsl rlStartBattleSceneScript

        _86E6
        rtl

        .databank 0

        ; 96/86E7

      rlBattleSceneShowLevelUp ; 96/86E7

        .al
        .xl
        .autsiz
        .databank ?

        ; When aActionStructUnit1 gained a level, fades the music (sound $E0) and starts script 1 (the stat gains).

        lda aActionStructUnit1.GainedLevels
        beq _86FB
        lda #$00E0
        jsl rlSendSoundCommand
        lda #$0001
        jsl rlStartBattleSceneScript

        _86FB
        rtl

        .databank 0

        ; 96/86FC

      rlUnknown9686FC ; 96/86FC

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$02
        sta $7FE4C2
        rep #$20
        stz aBGPaletteBuffer,b
        lda aUnknownE000B0+12
        sta $0108,b
        ldx #$0000

        _8713
        lda aUnknownE000B0,x
        sta $010A,b,x
        inc x
        inc x
        cpx #$0006
        bcc _8713
        ldx #$0000

        _8724
        lda aUnknown9984C6,x
        sta lR18
        lda aUnknown9984C6+1,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        xba
        sta $7FED4B
        inc x
        inc x
        inc x
        lda aUnknown9984C6,x
        sta $7FED56
        inc x
        inc x
        lda aUnknown9984C6,x
        sta $7FED53
        inc x
        inc x
        sep #$20
        lda aUnknown9984C6,x
        sta $7FED4D
        inc x
        lda aUnknown9984C6,x
        sta $7FED52
        inc x
        lda aUnknown9984C6,x
        sta $7FED55
        inc x
        rep #$20
        lda aUnknown9984C6,x
        sta $7FED58
        inc x
        inc x
        phx
        jsl rlUnknown968530
        plx
        cpx #$006C
        bcc _8724
        jsl rlUnknown96957D
        rtl

        .databank 0

        ; 96/878D

      rlUnknown96878D ; 96/878D

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda wBattleSceneFlags
        bit #BattleSceneFlagToMapMode3
        bne _87AC
        lda wBattleType
        and #$00FF
        cmp #$0001
        beq _87A7
        lda #$0039
        bra _87AF


        _87A7
        lda #$003F
        bra _87AF


        _87AC
        lda #$0040

        _87AF
        sta wMusicID,b
        rtl

        .databank 0

        ; 96/87B3

    .endsection Unsorted9680C2Section


    .section Unreferenced9687B3Section

      .al
      .xl

      rlUnknown9687B3 ; 96/87B3

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        ldx #$0000

        _87B8
        lda aUnknown9984C6,x
        sta lR18
        lda aUnknown9984C6+1,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        xba
        sta $7FED4B
        inc x
        inc x
        inc x
        lda aUnknown9984C6,x
        sta $7FED56
        inc x
        inc x
        lda aUnknown9984C6,x
        sta $7FED53
        inc x
        inc x
        sep #$20
        lda aUnknown9984C6,x
        sta $7FED4D
        inc x
        lda aUnknown9984C6,x
        sta $7FED52
        inc x
        lda aUnknown9984C6,x
        sta $7FED55
        inc x
        rep #$20
        lda aUnknown9984C6,x
        sta $7FED58
        inc x
        inc x
        phx
        jsl rlUnknown968530
        plx
        cpx #$006C
        bcc _87B8
        ply
        plx
        rtl

        .databank 0

        ; 96/881F

    .endsection Unreferenced9687B3Section
    .section Unsorted969398Section

      .al
      .xl

      rlUnknown969398 ; 96/9398

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        pha
        asl a
        pha
        asl a
        asl a
        clc
        adc #1,s
        clc
        adc #3,s
        tax
        pla
        pla
        ldy #$0000
        lda aUnknown9986CD,x
        sta lR18
        lda aUnknown9986CD+1,x
        sta lR18+1
        lda [lR18],y
        and #$00FF
        sta wR0
        xba
        sta $7FED4B
        lda aUnknown9986CD+3,x
        sta lR18
        lda aUnknown9986CD+4,x
        sta lR18+1
        lda [lR18],y
        and #$00FF
        clc
        adc wR0
        pha
        sta wR0
        jsl rlBattleSceneGetHPSpeed
        sta $7FED4E
        pla
        and #$00FF
        sta $7FED50
        lda aUnknown9986CD+6,x
        sta $7FED56
        lda #$2800
        sta $7FED58
        lda aUnknown9986CD+8,x
        sta $7FED53
        sep #$20
        lda aUnknown9986CD+10,x
        sta $7FED4D
        lda #$02
        sta $7FED52
        lda #$0C
        sta $7FED55
        rep #$20
        ply
        plx
        rtl

        .databank 0

        ; 96/941C

    .endsection Unsorted969398Section


    .section Unsorted96994BSection

      .al
      .xl

      rlUnknown96994B ; 96/994B

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        sep #$20
        lda bBattleAnimationCombatantFlags,b
        and #$FB
        sta bBattleAnimationCombatantFlags,b
        lda bBattleAnimation2CombatantFlags,b
        and #$FB
        sta bBattleAnimation2CombatantFlags,b
        rep #$20
        plx
        pla
        rtl

        .databank 0

        ; 96/9964

    .endsection Unsorted96994BSection


    .section Unreferenced969964Section

      .al
      .xl

      rlUnknown969964 ; 96/9964

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        pha
        phx
        phy
        bit #$0080
        bne _996F
        clc
        bra _9991


        _996F
        jsl rlUnknown96994B
        pha
        xba
        and #$00FF
        tay
        pla
        and #$007F
        sta wR0
        phb
        php
        phk
        plb
        .databank $96
        lda wR0
        asl a
        tax
        jsr (aUnknown969995,x)
        plp
        plb
        .databank $96
        inc lR18
        inc lR18
        sec

        _9991
        ply
        plx
        pla
        rtl

        .databank 0

        ; 96/9995

      aUnknown969995 ; 96/9995

        ; Jump table of rlUnknown969964.

        .word <>rsUnknown969999
        .word <>rsUnknown9699BB

      rsUnknown969999 ; 96/9999

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bits 3-5 of $0AF5 in the first combatant slot to Y, and bit 2.

        phx
        tya
        ldx #$0000
        sep #$20
        asl a
        asl a
        asl a
        pha
        lda bBattleAnimationCombatantFlags,b,x
        and #$C7
        ora #1,s
        sta bBattleAnimationCombatantFlags,b,x
        pla
        lda bBattleAnimationCombatantFlags,b,x
        ora #$04
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        plx
        rts

        .databank 0

        ; 96/99BB

      rsUnknown9699BB ; 96/99BB

        .al
        .xl
        .autsiz
        .databank ?

        ; The same for the second combatant slot ($43 on).

        phx
        tya
        ldx #$0043
        sep #$20
        asl a
        asl a
        asl a
        pha
        lda bBattleAnimationCombatantFlags,b,x
        and #$C7
        ora #1,s
        sta bBattleAnimationCombatantFlags,b,x
        pla
        lda bBattleAnimationCombatantFlags,b,x
        ora #$04
        sta bBattleAnimationCombatantFlags,b,x
        rep #$20
        plx
        rts

        .databank 0

        ; 96/99DD

    .endsection Unreferenced969964Section
    .section Unsorted9699DDSection

      .al
      .xl

      rlUnknown9699DD ; 96/99DD

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wBattleSceneFlags
        bit #BattleSceneFlagBattleType2
        beq _9A24
        ldx #$0000
        lda #$000A

        _99ED
        pha
        lda #$0010

        _99F1
        pha
        lda $7FD0C0,x
        and #$1C00
        cmp #$0400
        bne _9A08
        lda $7FD0C0,x
        clc
        adc #$1800
        bra _9A10


        _9A08
        lda $7FD0C0,x
        clc
        adc #$1000

        _9A10
        sta $7FD0C0,x
        inc x
        inc x
        pla
        dec a
        bne _99F1
        txa
        clc
        adc #$0020
        tax
        pla
        dec a
        bne _99ED

        _9A24
        plx
        rtl

        .databank 0

        ; 96/9A26

      rlUnknown969A26 ; 96/9A26

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wBattleSceneFlags
        bit #BattleSceneFlagBattleType2
        bne _9A34
        jml _9B9A


        _9A34
        ldx #$0000

        _9A37
        lda $0102,b,x
        sta $7ECC08,x
        inc x
        inc x
        cpx #$001E
        bcc _9A37
        ldx #$0000

        _9A48
        lda $01C2,b,x
        sta $7ECC28,x
        inc x
        inc x
        cpx #$001E
        bcc _9A48
        ldx #$0000

        _9A59
        lda $0102,b,x
        sta $0122,b,x
        sta $7FFE22,x
        inc x
        inc x
        cpx #$0016
        bcc _9A59
        ldx #$0000

        _9A6D
        lda $0108,b,x
        sta $0138,b,x
        sta $7FFE38,x
        inc x
        inc x
        cpx #$0008
        bcc _9A6D
        ldx #$0000

        _9A81
        lda $01E2,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        sta $01E2,b,x
        inc x
        inc x
        cpx #$001E
        bcc _9A81
        ldx #$0000

        _9A99
        lda $0122,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        sta $0122,b,x
        inc x
        inc x
        cpx #$0006
        bcc _9A99
        ldx #$0000
        lda #$0001
        sta wR0

        _9AB6
        lda $0132,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        jsl rlUnknown969C63
        sta $0132,b,x
        inc x
        inc x
        cpx #$0006
        bcc _9AB6
        ldx #$0000
        lda #$0003
        sta wR0

        _9AD7
        lda $013A,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        jsl rlUnknown969C63
        sta $013A,b,x
        inc x
        inc x
        cpx #$0006
        bcc _9AD7
        ldx #$0000

        _9AF3
        lda $01C2,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        sta $7FFEC2,x
        inc x
        inc x
        cpx #$001E
        bcc _9AF3
        ldx #$0000

        _9B0C
        lda $0102,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        sta $7FFE02,x
        inc x
        inc x
        cpx #$0006
        bcc _9B0C
        ldx #$0000
        lda #$0001
        sta wR0

        _9B2A
        lda $0112,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        jsl rlUnknown969C63
        sta $7FFE12,x
        inc x
        inc x
        cpx #$0006
        bcc _9B2A
        ldx #$0000
        lda #$0003
        sta wR0

        _9B4C
        lda $011A,b,x
        jsl rlUnknown96EDC0
        lsr a
        and #$3DEF
        jsl rlUnknown969C63
        sta $7FFE1A,x
        inc x
        inc x
        cpx #$0006
        bcc _9B4C
        ldx #$0000
        lda #$0008
        sta wR0

        _9B6E
        lda $0162,b,x
        jsl rlUnknown969B9C
        sta aWorldMapMarkerPalette,x
        inc x
        inc x
        cpx #$003E
        bcc _9B6E
        ldx #$0000
        lda #$0014
        sta wR0

        _9B88
        lda $0162,b,x
        jsl rlUnknown969B9C
        sta $7ECBC8,x
        inc x
        inc x
        cpx #$003E
        bcc _9B88

        _9B9A
        plx
        rtl

        .databank 0

        ; 96/9B9C

      rlUnknown969B9C ; 96/9B9C

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        lda wR0
        asl a
        tax
        lda #1,s
        and #$001F
        clc
        adc wR0
        cmp #$0020
        bcc _9BB2
        lda #$001F

        _9BB2
        pha
        lda #3,s
        and #$03E0
        clc
        adc aUnknown969BE3,x
        cmp #$0400
        bcc _9BC5
        lda #$03E0

        _9BC5
        ora #1,s
        sta #1,s
        lda #3,s
        and #$7C00
        clc
        adc aUnknown969C23,x
        cmp #$8000
        bcc _9BDB
        lda #$7C00

        _9BDB
        ora #1,s
        sta #3,s
        pla
        pla
        plx
        rtl

        .databank 0

        ; 96/9BE3

    .endsection Unsorted9699DDSection


    .section Unsorted969C63Section

      .al
      .xl

      rlUnknown969C63 ; 96/9C63

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        lda wR0
        asl a
        tax
        lda #1,s
        and #$001F
        sec
        sbc wR0
        bcs _9C76
        lda #$0000

        _9C76
        pha
        lda #3,s
        and #$03E0
        sec
        sbc aUnknown969BE3,x
        bcs _9C86
        lda #$0000

        _9C86
        ora #1,s
        sta #1,s
        lda #3,s
        and #$7C00
        sec
        sbc aUnknown969C23,x
        bcs _9C99
        lda #$0000

        _9C99
        ora #1,s
        sta #3,s
        pla
        pla
        plx
        rtl

        .databank 0

        ; 96/9CA1

      rlUnknown969CA1 ; 96/9CA1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda bBattleSceneStrikeFlags,b
        bit #$0080
        beq _9CFF
        jsl rlBattleSceneCheckJuliusDefends
        bcs _9CFF
        lda wBattleAnimationDefenderOffset,b
        cmp #$0000
        bne _9CBD
        lda #$0000
        bra _9CC0


        _9CBD
        lda #$0001

        _9CC0
        jsl rlUnknown9EB0F2
        cmp #$0002
        beq _9CD8
        cmp #$0001
        beq _9CD3
        lda #$0089
        bra _9CDB


        _9CD3
        lda #$008A
        bra _9CDB


        _9CD8
        lda #$008B

        _9CDB
        pha
        ldx wBattleAnimationDefenderOffset,b
        lda wBattleAnimationX,b,x
        and #$01FF
        sec
        sbc wBattleSceneCameraX
        jsl rlGetSoundPanFromXPixel
        cpx #$0000
        bne _9CF7
        clc
        adc #$2000

        _9CF7
        clc
        adc #1,s
        jsl rlPlaySoundEffect2
        pla

        _9CFF
        plx
        rtl

        .databank 0

        ; 96/9D01

      rlUnknown969D01 ; 96/9D01

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$74
        sta $2181,b
        lda #$55
        sta $2182,b
        lda #$01
        sta $2183,b
        rep #$20
        lda #$0000

        _9D17
        sta wR0
        asl a
        tax
        lda aUnknown98B388,x
        sta wR1
        ldx #$0000

        _9D24
        lda $0202,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0222,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0242,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0262,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        inc x
        inc x
        cpx #$0012
        bcc _9D24

        _9D6F
        lda $0202,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0222,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0242,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        inc x
        inc x
        cpx #$001E
        bcc _9D6F
        lda wR0
        inc a
        cmp #$0019
        bcs _9DB5
        jml _9D17


        _9DB5
        sep #$20
        lda #$74
        sta $2181,b
        lda #$B5
        sta $2182,b
        lda #$01
        sta $2183,b
        rep #$20
        lda #$0000

        _9DCB
        sta wR0
        asl a
        tax
        lda aUnknown98B388,x
        sta wR1
        ldx #$0000

        _9DD8
        lda $0282,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02A2,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02C2,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02E2,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        inc x
        inc x
        cpx #$0012
        bcc _9DD8

        _9E23
        lda $0282,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02A2,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02C2,b,x
        jsr rsUnknown969E6A
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        inc x
        inc x
        cpx #$001E
        bcc _9E23
        lda wR0
        inc a
        cmp #$0019
        bcs _9E69
        jml _9DCB


        _9E69
        rtl

        .databank 0

        ; 96/9E6A

      rsUnknown969E6A ; 96/9E6A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        pha
        eor #$FFFF
        pha
        and #$001F
        sta wR10
        lda wR1
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1
        and #$001F
        sta wR2
        pla
        pha
        and #$03E0
        sta wR10
        lda wR1
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1
        and #$03E0
        ora wR2
        sta wR2
        pla
        pha
        and #$7C00
        sta wR10
        lda wR1
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1
        and #$7C00
        ora wR2
        sta wR2
        pla
        pla
        clc
        adc wR2
        plx
        rts

        .databank 0

        ; 96/9EBB

      rlUnknown969EBB ; 96/9EBB

        .al
        .xl
        .autsiz
        .databank ?

        lda wBattleSceneFlags
        bit #BattleSceneFlagSolo2
        beq _9EF8
        sep #$20
        lda $7FFC6F
        ora #$48
        sta $7FFC6F
        rep #$20
        lda #(`aUnknown95E754)<<8
        sta lR44+1
        lda #<>aUnknown95E754
        sta lR44
        lda #$0003
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex
        lda #(`aUnknown95E760)<<8
        sta lR44+1
        lda #<>aUnknown95E760
        sta lR44
        lda #$0006
        sta wR40
        jsl rlHDMAEngineCreateEntryByIndex

        _9EF8
        rtl

        .databank 0

        ; 96/9EF9

    .endsection Unsorted969C63Section


    .section Unsorted969EF9Section

      .al
      .xl

      rlUnknown969EF9 ; 96/9EF9

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$FF
        sta $7FFC72
        lda #$00
        sta $7FFC73
        lda #$FC
        sta $7FFC75
        lda #$7F
        sta $7FFC74
        lda #$97
        sta $7FFC76
        rep #$20
        rtl

        .databank 0

        ; 96/9F1C

      rlUnknown969F1C ; 96/9F1C

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FFC72
        and #$00FF
        cmp #$00FF
        beq _9F69
        phx
        asl a
        tax
        lda aUnknown998F0F,x
        cmp #$8080
        bne _9F3A
        jsl rlUnknown969EF9
        bra _9F68


        _9F3A
        sep #$20
        sta $7FFC73
        clc
        adc #$FC
        sta $7FFC75
        lda aUnknown998F0F+1,x
        clc
        adc #$7F
        sta $7FFC74
        lda aUnknown998F0F+1,x
        clc
        adc #$97
        sta $7FFC76
        lda $7FFC72
        inc a
        sta $7FFC72
        rep #$20

        _9F68
        plx

        _9F69
        rtl

        .databank 0

        ; 96/9F6A

      rlUnknown969F6A ; 96/9F6A

        .al
        .xl
        .autsiz
        .databank ?

        lda bBattleSceneStrikeFlags,b
        bit #$0040
        beq _9F7C
        sep #$20
        lda #$00
        sta $7FFC72
        rep #$20

        _9F7C
        rtl

        .databank 0

        ; 96/9F7D

    .endsection Unsorted969EF9Section


