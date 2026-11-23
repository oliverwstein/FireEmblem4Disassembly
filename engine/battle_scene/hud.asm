; The battle scene's HUD: each combatant's HP (numbers and bar, changed by
; rsBattleSceneUpdateHP1/2), the stats, names and faction banners
; (rlBattleSceneLoadHUD), and the gauge that draws the experience bar and the
; level up window (wBattleSceneGaugeValue...). Also the color helpers for battle
; type 2 and the white fade, and the HUD's shake on a critical.


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
        jsl rlBattleSceneDivide
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

      rlBattleSceneDrawStat ; 95/95CA

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws A as rlBattleSceneDrawNumber does (wR0 digits ending at X, attributes wR1), except that 255 or more is two dashes (tile $15A) and 100 the two tiles $15B-$15C.

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
        jsl rlBattleSceneDivide
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

      rlBattleSceneDrawTwoDigits ; 95/9650

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Draws A (under 100) at X: the tens as tile $40 + tens (blank under 10), then the ones as tile $4A + ones. Attributes wR1.

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
        jsl rlBattleSceneDivide
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

      rlBattleSceneDrawTallNumber ; 95/968E

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws A as wR0 digits ending at X, each digit two tiles high (tile $22 + digit over $32 + digit); leading zeroes blank. The gauges draw their number so when they have no bar (the level).

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
        jsl rlBattleSceneDivide
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

      rlBattleSceneDrawGaugeNumber ; 95/96EE

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws A as wR0 digits ending at X with tiles $40 + digit; leading zeroes blank. The gauges with a bar draw their number so.

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
        jsl rlBattleSceneDivide
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

      rlBattleSceneDrawGauge ; 95/9742

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws a bar at X: wR0 filled out of wR1, both first scaled by wR2 / 256 (at least 1), in tiles of 8 pixels from attributes wR3. The first tile holds 6 pixels; aBattleSceneGaugeEndTiles gives the last tile by the pixels left.

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
        lda aBattleSceneGaugeEndTiles,x
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
        lda aBattleSceneHPBarTiles
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
        lda aBattleSceneHPBarTiles,x
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

      aBattleSceneHPBarTiles ; 95/9890

        ; Read by rlBattleSceneDrawHPBar.

        .word $0C0E, $0509

        ; 95/9894

    .endsection Table959890Section


    .section Unsorted959895Section

      .al
      .xl

      rsBattleSceneDrawStats ; 95/9895

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the ten numbers of aBattleSceneHUDStats (each combatant's HP, level, hit, might and defense) into the HUD's tilemap, three digits for 100 or more.

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
        lda aBattleSceneHUDStats,x
        inc x
        inc x
        pha
        lda aBattleSceneHUDStats,x
        sta lR18
        inc x
        lda aBattleSceneHUDStats,x
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
        jsl rlBattleSceneDrawStat
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

      rlBattleSceneQueueHPUpload ; 95/98E7

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: queues the HUD's HP rows ($78 bytes from $7FD204) for VRAM $6D02 (rlBattleSceneQueueUpload).

        pha
        phx
        phy
        lda #$7F00
        sta lR18+1
        lda #$D204
        sta lR18
        ldy #$6D02
        lda #$0078
        jsl rlBattleSceneQueueUpload
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

      rlBattleSceneLoadHUD ; 95/9902

        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses the HUD's tiles (VRAM $FC00, $F400) and the names (rlBattleSceneLoadNames), the window tilemap ($7FC800, to VRAM $D000) and the HUD tilemap ($7FD0C0: stats, HP, colors, to VRAM $D8C0), then the faction banners.

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

        jsl rlBattleSceneLoadNames
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
        jsl rlBattleSceneBlankMissingCombatant
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
        jsr rsBattleSceneDrawStats
        lda #$7F00
        sta lR18+1
        lda #$D0C0
        sta lR18
        lda #$01FF
        jsl rlBattleSceneBlankMissingCombatant
        lda #$2940
        jsr rsBattleSceneDrawHP1
        lda #$2940
        jsr rsBattleSceneDrawHP2
        jsl rlBattleSceneSetHUDColors
        jsl rlBattleSceneRecolorHUDForType2
        jsl rlDMAByStruct

          .structDMAToVRAM $7FD0C0, $03C0, $80, $D8C0

        jsr rsBattleSceneLoadBanners
        rtl

        .databank 0

        ; 95/99E7

    .endsection Unsorted959902Section


    .section Unsorted9599E7Section

      .al
      .xl

      rlBattleSceneSetHUDColors ; 95/99E7

        .al
        .autsiz
        .databank ?

        ; Redraws both HPs, copies the HUD's base colors (aUnknownE00060) to BG palette 0, then sets each combatant's HUD colors by its faction (rlGetFactionBattleHUDColorID; in battle type $FF the low byte of the unit pointer is the color ID).

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
        jsr rsBattleSceneSetHUDColors1

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
        jsr rsBattleSceneSetHUDColors2
        rtl

        .databank 0

      rsBattleSceneLoadBanners ; 95/9A4D

        .al
        .autsiz
        .databank ?

        ; Decompresses each combatant's faction banner (aBattleBannerTable by rlGetFactionBattleBannerID; in battle type $FF the X position is the banner ID) to $7FC200 and $7FC000, copies its 7 colors to $01D2 and $01F2, and sends the banners to VRAM $F000.

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

      rlBattleSceneBlankMissingCombatant ; 95/9B49

        .al
        .xl
        .autsiz
        .databank ?

        ; When a combatant has no character (0), fills its half of the tilemap at lR18 (10 rows of 16 tiles; combatant 1 the right half) with A.

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

      rsBattleSceneSetHUDColors1 ; 95/9B84

        .al
        .autsiz
        .databank ?

        ; A = HUD color ID: copies its entry of aBattleSceneHUDColors (8 colors to $01C2, 3 to $011A) for combatant 1.

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
          lda aBattleSceneHUDColors,x
          sta $01C2,b,y
          inc x
          inc x
          inc y
          inc y
          cpy #16
          bcc -

        ldy #0
        
          -
          lda aBattleSceneHUDColors,x
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

      rsBattleSceneSetHUDColors2 ; 95/9BC1

        .al
        .xl
        .autsiz
        .databank ?

        ; The same for combatant 2 ($01E2, $010A).

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
        lda aBattleSceneHUDColors,x
        sta $01E2,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bcc _9BD8
        ldy #$0000

        _9BEB
        lda aBattleSceneHUDColors,x
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

        ; Sets bit 3 of bBattleSceneRoundState and $7FED5A to 60.

        pha
        sep #$20
        lda bBattleSceneRoundState,b
        ora #BattleSceneRoundHeld
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

      rlBattleSceneDivide ; 95/9C3E

        .al
        .xl
        .autsiz
        .databank ?

        ; wR13 / wR14 (a byte) with the hardware divider: the quotient in wR13, the remainder in wR10.

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

      rlBattleSceneLoadNames ; 96/80C2

        .al
        .xl
        .autsiz
        .databank ?

        ; Loads the name font, draws the combatants' names and weapons into tiles and sends them to VRAM $F800.

        jsr rsBattleSceneLoadNameFont
        jsr rsBattleSceneRenderNames
        jsr rsBattleSceneUploadNames
        rtl

        .databank 0

        ; 96/80CC

      rsBattleSceneLoadNameFont ; 96/80CC

        .al
        .xl
        .autsiz
        .databank ?

        ; Decompresses the font (gcUnknownC00A2B) to $7E8B88.

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

      rsBattleSceneUploadNames ; 96/80E9

        .al
        .xl
        .autsiz
        .databank ?

        ; Sends the name tiles ($7EAC88) to VRAM $F800.

        jsl rlDMAByStruct

          .structDMAToVRAM $7EAC88, $0400, $80, $F800

        rts

        .databank 0

        ; 96/80F7

      rsBattleSceneRenderNames ; 96/80F7

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws each combatant's name and weapon name (8 characters, two 2bpp tile rows each) into $7EAC88: combatant 2's right-aligned at $000 (weapon) and $100 (name), combatant 1's left-aligned at $200 and $300. No weapon ($FFFF) is blank; a combatant with no character is skipped.

        phx
        phy
        lda aBattleSceneCombatant2.Character,b
        cmp #$0000
        beq _8128
        ldx #$0100
        jsl rlGetCharacterNamePointer
        jsr rsBattleSceneGetTextLength
        jsr rsBattleSceneDrawNameRight
        lda aBattleSceneCombatant2.Weapon,b
        ldx #$0000
        cmp #$FFFF
        bne _811E
        jsr rsBattleSceneBlankWeaponName
        bra _8128


        _811E
        jsl rlGetItemNamePointerByItemID
        jsr rsBattleSceneGetTextLength
        jsr rsBattleSceneDrawWeaponNameRight

        _8128
        lda aBattleSceneCombatant1.Character,b
        cmp #$0000
        beq _8157
        ldx #$0300
        jsl rlGetCharacterNamePointer
        jsr rsBattleSceneGetTextLength
        jsr rsBattleSceneDrawNameLeft
        lda aBattleSceneCombatant1.Weapon,b
        ldx #$0200
        cmp #$FFFF
        bne _814D
        jsr rsBattleSceneBlankWeaponName
        bra _8157


        _814D
        jsl rlGetItemNamePointerByItemID
        jsr rsBattleSceneGetTextLength
        jsr rsBattleSceneDrawWeaponNameLeft

        _8157
        ply
        plx
        rts

        .databank 0

        ; 96/815A

      rsBattleSceneGetTextLength ; 96/815A

        .al
        .xl
        .autsiz
        .databank ?

        ; Points lR18 at the text in lRoutineVariable and returns its length in characters (at most 8) in wR0.

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

      rsBattleSceneDrawNameRight ; 96/8179

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the name at lR18 right-aligned in 8 characters at X.

        pha
        lda #$0008
        sec
        sbc wR0
        beq _818A

        _8182
        pha
        jsr rsBattleSceneDrawBlankCharacter
        pla
        dec a
        bne _8182

        _818A
        lda wR0

        _818C
        pha
        jsr rsBattleSceneDrawNameCharacter
        pla
        dec a
        bne _818C
        pla
        rts

        .databank 0

        ; 96/8196

      rsBattleSceneDrawNameLeft ; 96/8196

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the name at lR18 left-aligned in 8 characters at X.

        pha
        lda wR0

        _8199
        pha
        jsr rsBattleSceneDrawNameCharacter
        pla
        dec a
        bne _8199
        lda #$0008
        sec
        sbc wR0
        beq _81B1

        _81A9
        pha
        jsr rsBattleSceneDrawBlankCharacter
        pla
        dec a
        bne _81A9

        _81B1
        pla
        rts

        .databank 0

        ; 96/81B3

      rsBattleSceneDrawWeaponNameRight ; 96/81B3

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the weapon name at lR18 right-aligned in 8 characters at X.

        pha
        lda #$0008
        sec
        sbc wR0
        beq _81C4

        _81BC
        pha
        jsr rsBattleSceneDrawBlankCharacter
        pla
        dec a
        bne _81BC

        _81C4
        lda wR0

        _81C6
        pha
        jsr rsBattleSceneDrawWeaponNameCharacter
        pla
        dec a
        bne _81C6
        pla
        rts

        .databank 0

        ; 96/81D0

      rsBattleSceneDrawWeaponNameLeft ; 96/81D0

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the weapon name at lR18 left-aligned in 8 characters at X.

        pha
        lda wR0

        _81D3
        pha
        jsr rsBattleSceneDrawWeaponNameCharacter
        pla
        dec a
        bne _81D3
        lda #$0008
        sec
        sbc wR0
        beq _81EB

        _81E3
        pha
        jsr rsBattleSceneDrawBlankCharacter
        pla
        dec a
        bne _81E3

        _81EB
        pla
        rts

        .databank 0

        ; 96/81ED

      rsBattleSceneDrawNameCharacter ; 96/81ED

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the character at lR18 (its two font tiles from rlUnknown879DD1) into the name tiles at X, top half and bottom half, and steps lR18 and X.

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

      rsBattleSceneDrawWeaponNameCharacter ; 96/824C

        .al
        .xl
        .autsiz
        .databank ?

        ; As rsBattleSceneDrawNameCharacter, but 2 pixels higher (the font tiles' first two rows are skipped).

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

      rsBattleSceneDrawBlankCharacter ; 96/82CD

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears one character of the name tiles at X (both halves) and steps X.

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

      rsBattleSceneBlankWeaponName ; 96/82E8

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears 8 characters at X.

        pha
        phx
        phy
        lda #$0008

        _82EE
        jsr rsBattleSceneDrawBlankCharacter
        dec a
        bne _82EE
        ply
        plx
        pla
        rts

        .databank 0

        ; 96/82F8

      rlBattleSceneStopGauge ; 96/82F8

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the gauge's speed (wBattleSceneGaugeSpeed).

        lda #$0000
        sta wBattleSceneGaugeSpeed
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

      rlBattleSceneStartExperienceGauge ; 96/830D

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Script routine 13: sets up the gauge for the experience bar (from wBattleSceneExperience to it plus wBattleSceneExperienceGained, 99 at most) and draws it.

        lda wBattleSceneExperience,b
        and #$00FF
        xba
        sta wBattleSceneGaugeValue
        lda wBattleSceneExperienceGained,b
        sta wR0
        jsl rlBattleSceneGetHPSpeed
        sta wBattleSceneGaugeSpeed
        lda wBattleSceneExperience,b
        clc
        adc wBattleSceneExperienceGained,b
        sta wBattleSceneGaugeTarget
        lda #$0191
        sta wBattleSceneGaugeScale
        lda #$3000
        sta wBattleSceneGaugeAttributes
        lda #$0BCE
        sta wBattleSceneGaugeOffset
        sep #$20
        lda #$FF
        sta bBattleSceneGaugeMax
        lda #$02
        sta bBattleSceneGaugeDigits
        lda #$2C
        sta bBattleSceneGaugeUploadSize
        rep #$20
        jsl rlBattleSceneDrawExperienceGauge
        rtl

        .databank 0

        ; 96/8360

      rlBattleSceneStartExperienceFill ; 96/8360

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Script routine 1: plays sound $0B and sets rlBattleSceneRunExperienceFill as the routine run every frame.

        lda #$000B
        jsl rlPlaySoundEffect
        lda #(`rlBattleSceneRunExperienceFill)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlBattleSceneRunExperienceFill
        sta lBattleSceneScriptRoutine
        rtl

        .databank 0

        ; 96/8376

      rlBattleSceneRunExperienceFill ; 96/8376

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: moves the gauge toward its target and redraws the experience bar; past 100 it starts again from 0. When it stops, plays sound $0C and ends the routine (rlBattleSceneEndScriptRoutine).

        phx
        phy
        lda wBattleSceneGaugeSpeed
        bne _838D
        lda #$000C
        jsl rlPlaySoundEffect
        jsl rlBattleSceneEndScriptRoutine
        jml _8415


        _838D
        lda wBattleSceneGaugeValue
        clc
        adc wBattleSceneGaugeSpeed
        bcc _83A2
        lda bBattleSceneGaugeMax
        and #$00FF
        xba
        bra _83CA


        _83A2
        sta wBattleSceneGaugeValue
        xba
        sep #$20
        cmp bBattleSceneGaugeMax
        bcc _83B8
        lda bBattleSceneGaugeMax
        xba
        lda #$00
        bra _83CA


        _83B8
        cmp wBattleSceneGaugeTarget
        bcc _83C7
        lda wBattleSceneGaugeTarget
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
        lda wBattleSceneGaugeTarget
        sec
        sbc #$0064
        sta wBattleSceneGaugeTarget
        pla

        _83E3
        sta wBattleSceneGaugeValue
        jsl rlBattleSceneDrawExperienceGauge
        lda #$0000
        sta wBattleSceneGaugeSpeed
        bra _8415


        _83F4
        .as
        rep #$20
        cmp #$6400
        bcc _840D
        sec
        sbc #$6400
        pha
        lda wBattleSceneGaugeTarget
        sec
        sbc #$0064
        sta wBattleSceneGaugeTarget
        pla

        _840D
        sta wBattleSceneGaugeValue
        jsl rlBattleSceneDrawExperienceGauge

        _8415
        ply
        plx
        rtl

        .databank 0

        ; 96/8418

      rlBattleSceneRunStatGauge ; 96/8418

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: moves the gauge toward its target and redraws it as a level up stat (rlBattleSceneDrawStatGauge).

        phx
        phy
        lda wBattleSceneGaugeSpeed
        bne _8424
        jml _84AC


        _8424
        lda wBattleSceneGaugeValue
        clc
        adc wBattleSceneGaugeSpeed
        bcc _8439
        lda bBattleSceneGaugeMax
        and #$00FF
        xba
        bra _8461


        _8439
        sta wBattleSceneGaugeValue
        xba
        sep #$20
        cmp bBattleSceneGaugeMax
        bcc _844F
        lda bBattleSceneGaugeMax
        xba
        lda #$00
        bra _8461


        _844F
        cmp wBattleSceneGaugeTarget
        bcc _845E
        lda wBattleSceneGaugeTarget
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
        lda wBattleSceneGaugeTarget
        sec
        sbc #$0064
        sta wBattleSceneGaugeTarget
        pla

        _847A
        sta wBattleSceneGaugeValue
        jsl rlBattleSceneDrawStatGauge
        lda #$0000
        sta wBattleSceneGaugeSpeed
        bra _84AC


        _848B
        .as
        rep #$20
        cmp #$6400
        bcc _84A4
        sec
        sbc #$6400
        pha
        lda wBattleSceneGaugeTarget
        sec
        sbc #$0064
        sta wBattleSceneGaugeTarget
        pla

        _84A4
        sta wBattleSceneGaugeValue
        jsl rlBattleSceneDrawStatGauge

        _84AC
        ply
        plx
        rtl

        .databank 0

        ; 96/84AF

      rlBattleSceneDrawExperienceGauge ; 96/84AF

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the gauge as the experience bar: the number, then the bar, and queues the tilemap row for VRAM.

        lda bBattleSceneGaugeDigits
        and #$00FF
        sta wR0
        lda #$2C00
        sta wR1
        lda wBattleSceneGaugeOffset
        tax
        lda wBattleSceneGaugeValue
        xba
        and #$00FF
        jsl rlBattleSceneDrawNumber
        lda wBattleSceneGaugeValue+1
        and #$00FF
        sta wR0
        lda bBattleSceneGaugeMax
        and #$00FF
        cmp #$00FF
        bne _84E6
        lda #$0063

        _84E6
        sta wR1
        lda wBattleSceneGaugeScale
        cmp #$FFFF
        beq _850B
        sta wR2
        lda wBattleSceneGaugeAttributes
        sta wR3
        lda bBattleSceneGaugeDigits
        and #$00FF
        asl a
        clc
        adc wBattleSceneGaugeOffset
        tax
        jsl rlBattleSceneDrawGauge

        _850B
        lda #$7F00
        sta lR18+1
        lda wBattleSceneGaugeOffset
        clc
        adc #$C800
        sta lR18
        lda wBattleSceneGaugeOffset
        lsr a
        clc
        adc #$6800
        tay
        lda bBattleSceneGaugeUploadSize
        and #$00FF
        jsl rlBattleSceneQueueUpload
        rtl

        .databank 0

        ; 96/8530

      rlBattleSceneDrawStatGauge ; 96/8530

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the gauge as a level up stat: the bar, then the number (tall when it has no bar), and queues both tilemap rows for VRAM.

        lda wBattleSceneGaugeValue+1
        and #$00FF
        sta wR0
        lda bBattleSceneGaugeMax
        and #$00FF
        sta wR1
        lda wBattleSceneGaugeScale
        cmp #$FFFF
        beq _855B
        sta wR2
        lda #$2400
        sta wR3
        lda wBattleSceneGaugeOffset
        tax
        jsl rlBattleSceneDrawGauge

        _855B
        lda bBattleSceneGaugeDigits
        and #$00FF
        sta wR0
        lda #$2000
        sta wR1
        lda wBattleSceneGaugeOffset
        clc
        adc #$F9C8
        tax
        lda wBattleSceneGaugeValue
        xba
        and #$00FF
        pha
        lda wBattleSceneGaugeScale
        cmp #$FFFF
        beq _858B
        pla
        jsl rlBattleSceneDrawGaugeNumber
        bra _8590


        _858B
        pla
        jsl rlBattleSceneDrawTallNumber

        _8590
        lda #$7F00
        sta lR18+1
        lda wBattleSceneGaugeOffset
        clc
        adc #$C1C0
        sta lR18
        lda wBattleSceneGaugeOffset
        lsr a
        clc
        adc #$64E0
        tay
        lda bBattleSceneGaugeUploadSize
        and #$00FF
        jsl rlBattleSceneQueueUpload
        lda #$7F00
        sta lR18+1
        lda wBattleSceneGaugeOffset
        clc
        adc #$C800
        sta lR18
        lda wBattleSceneGaugeOffset
        lsr a
        clc
        adc #$6800
        tay
        lda bBattleSceneGaugeUploadSize
        and #$00FF
        jsl rlBattleSceneQueueUpload
        rtl

        .databank 0

        ; 96/85D9

      rlUnknown9685D9 ; 96/85D9

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Script routine 0: sets bytes of the effect variables at $7FE4C2.. and points $7FE4D2 at the word list at $98/AD7E, then sets rlUnknown96861E as the routine run every frame.

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
        sta lBattleSceneScriptRoutine+1
        lda #<>rlUnknown96861E
        sta lBattleSceneScriptRoutine
        rtl

        .databank 0

        ; 96/861E

      rlUnknown96861E ; 96/861E

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: takes the next word of the list at $7FE4D2 into $7FE4C5/$7FE4CB and copies its bytes of aUnknown98AC4C to $7FE3FD.. (rlUnknown9695AE); at $FFFF ends the routine.

        phy
        lda $7FE4D2
        sta lR18
        lda $7FE4D3
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        cmp #$FFFF
        bne _863B
        jsl rlBattleSceneEndScriptRoutine
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

      rlBattleSceneDrawLevelUpWindow ; 96/86FC

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Script routine 2: sets the window's colors and draws the nine gauges of aBattleSceneLevelUpGauges (level and the eight stats before the gains).

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
        lda aBattleSceneLevelUpGauges,x
        sta lR18
        lda aBattleSceneLevelUpGauges+1,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        xba
        sta wBattleSceneGaugeValue
        inc x
        inc x
        inc x
        lda aBattleSceneLevelUpGauges,x
        sta wBattleSceneGaugeScale
        inc x
        inc x
        lda aBattleSceneLevelUpGauges,x
        sta wBattleSceneGaugeOffset
        inc x
        inc x
        sep #$20
        lda aBattleSceneLevelUpGauges,x
        sta bBattleSceneGaugeMax
        inc x
        lda aBattleSceneLevelUpGauges,x
        sta bBattleSceneGaugeDigits
        inc x
        lda aBattleSceneLevelUpGauges,x
        sta bBattleSceneGaugeUploadSize
        inc x
        rep #$20
        lda aBattleSceneLevelUpGauges,x
        sta wBattleSceneGaugeAttributes
        inc x
        inc x
        phx
        jsl rlBattleSceneDrawStatGauge
        plx
        cpx #$006C
        bcc _8724
        jsl rlUnknown96957D
        rtl

        .databank 0

        ; 96/878D

      rlUnknown96878D ; 96/878D

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Script routine 61: sets wMusicID to $40 when the scene returns to the map in mode 3 (after Julius), $3F in the arena (battle type 1), else $39. The songs are not named.

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

      rlBattleSceneRedrawLevelUpGauges ; 96/87B3

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the nine gauges of aBattleSceneLevelUpGauges, as rlBattleSceneDrawLevelUpWindow does without the colors.

        phx
        phy
        ldx #$0000

        _87B8
        lda aBattleSceneLevelUpGauges,x
        sta lR18
        lda aBattleSceneLevelUpGauges+1,x
        sta lR18+1
        ldy #$0000
        lda [lR18],y
        and #$00FF
        xba
        sta wBattleSceneGaugeValue
        inc x
        inc x
        inc x
        lda aBattleSceneLevelUpGauges,x
        sta wBattleSceneGaugeScale
        inc x
        inc x
        lda aBattleSceneLevelUpGauges,x
        sta wBattleSceneGaugeOffset
        inc x
        inc x
        sep #$20
        lda aBattleSceneLevelUpGauges,x
        sta bBattleSceneGaugeMax
        inc x
        lda aBattleSceneLevelUpGauges,x
        sta bBattleSceneGaugeDigits
        inc x
        lda aBattleSceneLevelUpGauges,x
        sta bBattleSceneGaugeUploadSize
        inc x
        rep #$20
        lda aBattleSceneLevelUpGauges,x
        sta wBattleSceneGaugeAttributes
        inc x
        inc x
        phx
        jsl rlBattleSceneDrawStatGauge
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

      rlBattleSceneStartStatGauge ; 96/9398

        .al
        .xl
        .autsiz
        .databank ?

        ; A = stat (0-7, aBattleSceneLevelUpStatGauges): sets up the gauge to rise from the stat to the stat plus its gain.

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
        lda aBattleSceneLevelUpStatGauges,x
        sta lR18
        lda aBattleSceneLevelUpStatGauges+1,x
        sta lR18+1
        lda [lR18],y
        and #$00FF
        sta wR0
        xba
        sta wBattleSceneGaugeValue
        lda aBattleSceneLevelUpStatGauges+3,x
        sta lR18
        lda aBattleSceneLevelUpStatGauges+4,x
        sta lR18+1
        lda [lR18],y
        and #$00FF
        clc
        adc wR0
        pha
        sta wR0
        jsl rlBattleSceneGetHPSpeed
        sta wBattleSceneGaugeSpeed
        pla
        and #$00FF
        sta wBattleSceneGaugeTarget
        lda aBattleSceneLevelUpStatGauges+6,x
        sta wBattleSceneGaugeScale
        lda #$2800
        sta wBattleSceneGaugeAttributes
        lda aBattleSceneLevelUpStatGauges+8,x
        sta wBattleSceneGaugeOffset
        sep #$20
        lda aBattleSceneLevelUpStatGauges+10,x
        sta bBattleSceneGaugeMax
        lda #$02
        sta bBattleSceneGaugeDigits
        lda #$0C
        sta bBattleSceneGaugeUploadSize
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

      rlBattleSceneClearMagicSwordFlags ; 96/994B

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears bit 2 of both combatants' bBattleAnimationCombatantFlags (the magic sword strike).

        ; Clears bit 2 of both combatants' bBattleAnimationCombatantFlags.

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

        ; With bit 7 of A set: clears bit 2 of both combatants' flags, then by the low 7 bits of A runs aUnknown969995 with Y = the high byte, and steps lR18 by 2; carry set. Otherwise carry clear.

        pha
        phx
        phy
        bit #$0080
        bne _996F
        clc
        bra _9991


        _996F
        jsl rlBattleSceneClearMagicSwordFlags
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

      rlBattleSceneRecolorHUDForType2 ; 96/99DD

        .al
        .xl
        .autsiz
        .databank ?

        ; In battle type 2 (BattleSceneFlagBattleType2): moves every tile of the HUD tilemap ($7FD0C0) up four palettes, palette 1 up six.

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

      rlBattleSceneDimPalettesForType2 ; 96/9A26

        .al
        .xl
        .autsiz
        .databank ?

        ; In battle type 2: saves BG palettes 0 and 7 at $7ECC08, copies palette 0 to 1, and halves or darkens the HUD's and the scene's colors (some into $7FFE02.. and $7FFEC2..), with the sprite colors brightened into aWorldMapMarkerPalette and $7ECBC8.

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
        jsl rlBattleSceneDarkenColor
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
        jsl rlBattleSceneDarkenColor
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
        jsl rlBattleSceneDarkenColor
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
        jsl rlBattleSceneDarkenColor
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
        jsl rlBattleSceneBrightenColor
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
        jsl rlBattleSceneBrightenColor
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

      rlBattleSceneBrightenColor ; 96/9B9C

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        ; Returns color A with wR0 (0-31) added to each channel, each at most 31.

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
        adc aBattleSceneGreenSteps,x
        cmp #$0400
        bcc _9BC5
        lda #$03E0

        _9BC5
        ora #1,s
        sta #1,s
        lda #3,s
        and #$7C00
        clc
        adc aBattleSceneBlueSteps,x
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

      rlBattleSceneDarkenColor ; 96/9C63

        ; Reads the stack above its return address, but in the emulator log every
        ; caller continues right after the call: no inline arguments.
        .al
        .xl
        .autsiz
        .databank ?

        ; Returns color A with wR0 (0-31) taken from each channel, each at least 0.

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
        sbc aBattleSceneGreenSteps,x
        bcs _9C86
        lda #$0000

        _9C86
        ora #1,s
        sta #1,s
        lda #3,s
        and #$7C00
        sec
        sbc aBattleSceneBlueSteps,x
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

        ; End step (after the death quote, aBattleSceneEndSteps): when bit 7 of bBattleSceneStrikeFlags is set and Julius does not defend, plays sound $89, $8A or $8B (rlUnknown9EB0F2: 0 or 1 + a gender) panned to the defender.

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

      rlBattleSceneBuildWhiteFadePalettes ; 96/9D01

        .al
        .xl
        .autsiz
        .databank ?

        ; Builds 25 steps of sprite palettes 0-3 and 4-7 (all but palette 3's and 7's colors 10-15) fading toward white, at $7F5574 and $7FB574, by the steps of aBattleSceneWhiteFadeSteps.

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
        lda aBattleSceneWhiteFadeSteps,x
        sta wR1
        ldx #$0000

        _9D24
        lda $0202,b,x
        jsr rsBattleSceneBlendColorToWhite
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0222,b,x
        jsr rsBattleSceneBlendColorToWhite
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0242,b,x
        jsr rsBattleSceneBlendColorToWhite
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0262,b,x
        jsr rsBattleSceneBlendColorToWhite
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
        jsr rsBattleSceneBlendColorToWhite
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0222,b,x
        jsr rsBattleSceneBlendColorToWhite
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $0242,b,x
        jsr rsBattleSceneBlendColorToWhite
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
        lda aBattleSceneWhiteFadeSteps,x
        sta wR1
        ldx #$0000

        _9DD8
        lda $0282,b,x
        jsr rsBattleSceneBlendColorToWhite
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02A2,b,x
        jsr rsBattleSceneBlendColorToWhite
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02C2,b,x
        jsr rsBattleSceneBlendColorToWhite
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02E2,b,x
        jsr rsBattleSceneBlendColorToWhite
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
        jsr rsBattleSceneBlendColorToWhite
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02A2,b,x
        jsr rsBattleSceneBlendColorToWhite
        sep #$20
        sta $2180,b
        xba
        sta $2180,b
        rep #$20
        lda $02C2,b,x
        jsr rsBattleSceneBlendColorToWhite
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

      rsBattleSceneBlendColorToWhite ; 96/9E6A

        .al
        .xl
        .autsiz
        .databank ?

        ; Returns color A moved toward white by wR1 / 256 in each channel.

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

        ; With BattleSceneFlagSolo2: sets bits $48 of $7FFC6F and creates HDMA entries 3 and 6 (aUnknown95E754, aUnknown95E760).

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

      rlBattleSceneStopHUDShake ; 96/9EF9

        .al
        .xl
        .autsiz
        .databank ?

        ; Stops the HUD's shake and puts its scroll back (BG2 $00/$7F, BG3 $FC/$97).

        sep #$20
        lda #$FF
        sta bBattleSceneHUDShakeStep
        lda #$00
        sta bBattleSceneHUDBG2X
        lda #$FC
        sta bBattleSceneHUDBG3X
        lda #$7F
        sta bBattleSceneHUDBG2Y
        lda #$97
        sta bBattleSceneHUDBG3Y
        rep #$20
        rtl

        .databank 0

        ; 96/9F1C

      rlBattleSceneRunHUDShake ; 96/9F1C

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame while the HUD shakes: adds the next offsets of aBattleSceneHUDShakeOffsets to the HUD's scroll; $8080 stops it.

        lda bBattleSceneHUDShakeStep
        and #$00FF
        cmp #$00FF
        beq _9F69
        phx
        asl a
        tax
        lda aBattleSceneHUDShakeOffsets,x
        cmp #$8080
        bne _9F3A
        jsl rlBattleSceneStopHUDShake
        bra _9F68


        _9F3A
        sep #$20
        sta bBattleSceneHUDBG2X
        clc
        adc #$FC
        sta bBattleSceneHUDBG3X
        lda aBattleSceneHUDShakeOffsets+1,x
        clc
        adc #$7F
        sta bBattleSceneHUDBG2Y
        lda aBattleSceneHUDShakeOffsets+1,x
        clc
        adc #$97
        sta bBattleSceneHUDBG3Y
        lda bBattleSceneHUDShakeStep
        inc a
        sta bBattleSceneHUDShakeStep
        rep #$20

        _9F68
        plx

        _9F69
        rtl

        .databank 0

        ; 96/9F6A

      rlBattleSceneStartHUDShake ; 96/9F6A

        .al
        .xl
        .autsiz
        .databank ?

        ; Starts the HUD's shake on a critical (bit $40 of bBattleSceneStrikeFlags).

        lda bBattleSceneStrikeFlags,b
        bit #$0040
        beq _9F7C
        sep #$20
        lda #$00
        sta bBattleSceneHUDShakeStep
        rep #$20

        _9F7C
        rtl

        .databank 0

        ; 96/9F7D

    .endsection Unsorted969EF9Section


