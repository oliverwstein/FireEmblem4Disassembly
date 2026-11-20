; Code from bank $9E not yet assigned to a game system.

    .section Unsorted9E8000Section

      .al
      .xl

      rlUnknown9E8000 ; 9E/8000

        ; Nothing in the build reaches this. Runs rlUnknown9E800C with $7F4C87 = 1.

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0001
        sta $7F4C87
        jml rlUnknown9E800C._8014

        .databank 0

        ; 9E/800C

    .endsection Unsorted9E8000Section


    .section Unsorted9E800CSection

      .al
      .xl

      rlUnknown9E800C ; 9E/800C

        .al
        .xl
        .autsiz
        .databank ?

        ; Entered here with $7F4C87 = 0, at rlUnknown9E8000 with 1, and by
        ; rlUnknown9EEFF1 and rlUnknown9EF0CF at _8014 with 2.

        phx
        lda #$0000
        sta $7F4C87
        _8014

        lda #(`procUnknown9EC70B)<<8
        sta lR44+1
        lda #<>procUnknown9EC70B
        sta lR44
        lda #$0008
        dec a

        _8022
        sta $7F57F0
        jsl rlProcEngineCreateProcByIndex
        bcc _8033
        lda $7F57F0
        dec a
        bpl _8022

        _8033
        plx
        rtl

        .databank 0

        ; 9E/8035

    .endsection Unsorted9E800CSection


    .section Unsorted9E805ESection

      .al
      .xl

      rlUnknown9E805E ; 9E/805E

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb
        phx
        phk
        plb
        .databank $9E
        lda aMapAction.wXTilePosition
        sec
        sbc aMapAction.wUnknown7F4556
        sta wR0
        lda aMapAction.wYTilePosition
        sec
        sbc aMapAction.wUnknown7F4558
        sta wR1
        lda wR0
        bpl _8081
        dec a
        eor #$FFFF

        _8081
        sta wR2
        lda wR1
        bpl _808B
        dec a
        eor #$FFFF

        _808B
        sta wR3
        lda wR2
        clc
        adc wR3
        cmp #$0003
        bcs _80C3
        lda wR1
        xba
        and #$FF00
        sta wR15
        lda wR0
        and #$00FF
        ora wR15
        ldx #$0000

        _80A9
        cmp @l aUnknown9E80CB,x
        beq _80B4
        inc x
        inc x
        inc x
        bra _80A9


        _80B4
        inc x
        inc x
        lda @l aUnknown9E80CB,x
        and #$00FF
        sta aMapAction.wUnknown7F455E
        bra _80C7


        _80C3
        jsl rlUnknown9E80F2

        _80C7
        plx
        plb
        .databank $9E
        plp
        rtl

        .databank 0

        ; 9E/80CB

    .endsection Unsorted9E805ESection


    .section Table9E80CBSection

      .al
      .xl

      aUnknown9E80CB ; 9E/80CB

        ; Read by rlUnknown9E805E.

        .byte $00, $FE, $06, $FF, $FF, $05, $00, $FF, $06, $01, $FF, $07, $FE, $00, $04, $FF
        .byte $00, $04, $00, $00, $00, $01, $00, $00, $02, $00, $00, $FF, $01, $03, $00, $01
        .byte $02, $01, $01, $01, $00, $02, $02

        ; 9E/80F2

    .endsection Table9E80CBSection


    .section Unsorted9E80F2Section

      .al
      .xl

      rlUnknown9E80F2 ; 9E/80F2

        .al
        .xl
        .autsiz
        .databank ?

        lda wR0
        asl a
        asl a
        asl a
        asl a
        sta wR0
        lda wR1
        asl a
        asl a
        asl a
        asl a
        sta wR1
        jsl rlUnknown9FF3ED
        sec
        sbc #$0010
        and #$00FF
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda #$0007
        sec
        sbc wR0
        sta aMapAction.wUnknown7F455E
        rtl

        .databank 0

        ; 9E/811F

    .endsection Unsorted9E80F2Section


    .section Unsorted9E811FSection

      .al
      .xl

      rlUnknown9E811F ; 9E/811F

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta $7F508F
        lda $7F4C87
        beq _8139
        lda #$8000
        sta $7F508F
        jml _8268


        _8139
        lda aActionStructUnit1.WeaponID
        cmp #$FFFF
        beq _817A
        jsl rlGetItemDataROMPointer
        sta $7F57EA
        jsl rlGetItemWeaponType
        cmp #$0004
        bcs _81C5
        lda $7F57EA
        jsl rlGetItemWeaponTraits
        cmp #$0001
        beq _8171
        cmp #$0002
        beq _8171
        cmp #$0003
        beq _8171
        cmp #$0006
        beq _81C5
        bra _817A


        _8171
        lda wBattleDistance
        cmp #$0002
        bcs _81C5

        _817A
        lda aActionStructUnit2.WeaponID
        cmp #$FFFF
        bne _8187
        jml _8261


        _8187
        jsl rlGetItemDataROMPointer
        sta $7F57EA
        jsl rlGetItemWeaponType
        cmp #$0004
        bcs _81C5
        lda $7F57EA
        jsl rlGetItemWeaponTraits
        cmp #$0001
        beq _81B8
        cmp #$0002
        beq _81B8
        cmp #$0003
        beq _81B8
        cmp #$0006
        beq _81C5
        jml _8261


        _81B8
        lda wBattleDistance
        cmp #$0002
        bcs _81C5
        jml _8261


        _81C5
        lda aActionStructUnit2
        cmp #$FFFF
        bne _81D9
        lda #$8000
        sta $7F508F
        jml _8268


        _81D9
        lda wBattleType
        and #$00FF
        cmp #$0003
        bne _81EE
        lda #$0001
        sta $7F508F
        bra _8268


        _81EE
        jsl rlUnknown9E8271
        lda aActionStructUnit1.XPosition
        sta wR4
        lda aActionStructUnit1.YPosition
        sta wR5
        lda aActionStructUnit2.XPosition
        sta wR6
        lda aActionStructUnit2.YPosition
        sta wR7
        lda wR0
        clc
        adc aUnknown9E826B
        cmp wR4
        bcs _8219
        cmp wR6
        bcc _8222

        _8219
        lda #$0101
        sta $7F508F
        bra _8238


        _8222
        lda wR1
        sec
        sbc aUnknown9E826B+2
        cmp wR4
        bcc _8231
        cmp wR6
        bcs _8238

        _8231
        lda #$0201
        sta $7F508F

        _8238
        lda wR2
        clc
        adc aUnknown9E826B+4
        cmp wR5
        bcs _8247
        cmp wR7
        bcc _8254

        _8247
        lda $7F508F
        ora #$0401
        sta $7F508F
        bra _8268


        _8254
        lda $7F508F
        ora #$0001
        sta $7F508F
        bra _8268


        _8261
        lda #$0000
        sta $7F508F

        _8268
        plx
        ply
        rtl

        .databank 0

        ; 9E/826B

    .endsection Unsorted9E811FSection


    .section Table9E826BSection

      .al
      .xl

      aUnknown9E826B ; 9E/826B

        ; Read by rlUnknown9E811F.

        .word $0005, $0006, $0006

        ; 9E/8271

    .endsection Table9E826BSection


    .section Unsorted9E8271Section

      .al
      .xl

      rlUnknown9E8271 ; 9E/8271

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $9E
        lda wMapMinXScroll,b
        clc
        adc #$0010
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wMapMaxXScroll,b
        clc
        adc #$00E0
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        lda wMapMinYScroll,b
        clc
        adc #$0010
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR2
        lda wMapMaxYScroll,b
        clc
        adc #$00C0
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR3
        plb
        .databank $9E
        rtl

        .databank 0

        ; 9E/82AA

    .endsection Unsorted9E8271Section


    .section Unsorted9E82AASection

      .al
      .xl

      rlUnknown9E82AA ; 9E/82AA

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        phy
        phx
        lda #$0001
        sta $4584,b
        lda $4599,b
        sta $458A,b
        sta $4587,b
        lda $4598,b
        sta lR18
        lda $4599,b
        sta lR18+1
        lda @l aMapAction.wUnknown7F455E
        sta wR0
        lda $459E,b
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        sta $4BEB,b
        and #$0001
        and #$00FF
        jsr rsUnknown9E832C
        stx $4589,b
        sty $4586,b
        lda $459C,b
        sta $4590,b
        sta $458D,b
        lda $459B,b
        sta lR18
        lda $459C,b
        sta lR18+1
        lda @l aMapAction.wUnknown7F4560
        sta wR0
        lda $459E,b
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        and #$00FF
        eor #$0001
        jsr rsUnknown9E832C
        stx $458F,b
        sty $458C,b
        inc $459E,b
        plx
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/832C

    .endsection Unsorted9E82AASection


    .section Unsorted9E832CSection

      .al
      .xl

      rsUnknown9E832C ; 9E/832C

        .al
        .xl
        .autsiz
        .databank ?

        and #$0001
        bne _8353
        lda @l wR0
        and #$0001
        bne _8343
        lda aBattleRoundsData._Entry[0],x
        and #$0020
        bne _834B

        _8343
        ldx #$000E
        ldy #$0010
        bra _8378


        _834B
        ldx #$0012
        ldy #$0014
        bra _8378


        _8353
        lda aBattleRoundsData._Entry[0],x
        and #$0008
        beq _836B
        lda #$0000
        sta $7F45A2
        ldx #$000A
        ldy #$000C
        bra _8378


        _836B
        lda #$0000
        sta $7F45A2
        ldx #$0006
        ldy #$0008

        _8378
        lda [lR18],y
        clc
        adc @l lR18
        pha
        txy
        lda [lR18],y
        clc
        adc @l lR18
        tax
        ply
        rts

        .databank 0

        ; 9E/838B

    .endsection Unsorted9E832CSection


    .section Unsorted9E838BSection

      .al
      .xl

      rlUnknown9E838B ; 9E/838B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0000
        sta $4580,b
        sta $4582,b
        sta $4584,b
        sta $4BE7,b
        sta $5091,b
        sta $5093,b
        sta $4C1B,b
        sta $4C1D,b
        sta $4C0B,b
        sta $4C0D,b
        sta $4C11,b
        sta $4C13,b
        lda #$FFFF
        sta $508B,b
        sta $508D,b
        sta $5089,b
        lda aActionStructUnit1.ClassID
        sta @l wR0
        lda aActionStructUnit1.Gender
        sta @l wR1
        lda aActionStructUnit1.CharacterID
        sta @l wR2
        jsl rlUnknown9E85A4
        sta $454E,b
        lda aActionStructUnit1.XPosition
        sta $4552,b
        lda aActionStructUnit1.YPosition
        sta $4554,b
        jsl rlUnknown9E852A
        bcc _83FD
        jml _8504


        _83FD
        lda #$0000
        sta @l wR15
        lda $454E,b
        jsl rlUnknown9E857D
        bcs _845B
        lda aActionStructUnit1.WeaponID
        jsl rlUnknown9E866F
        bcs _845B
        lda aActionStructUnit1.Unknown
        tay
        lda aActionStructUnit1.WeaponID
        jsl rlUnknown9E86CF
        sta $508B,b
        lda $7F4BF1
        sta $7F4BED
        lda $7F4C09
        sta $7F4C0B
        lda #$0000
        bcs _845B
        lda aActionStructUnit1.WeaponID
        jsl rlGetItemDataROMPointer
        jsl rlGetItemWeaponType
        cmp #$0004
        bcc _845B
        lda aActionStructUnit1.WeaponID
        sec
        sbc #$003E
        sta $508B,b
        lda #$0004

        _845B
        sta $454A,b
        lda aActionStructUnit2.ClassID
        sta @l wR0
        lda aActionStructUnit2.Gender
        sta @l wR1
        lda aActionStructUnit2.CharacterID
        sta @l wR2
        jsl rlUnknown9E85A4
        sta $4550,b
        lda aActionStructUnit2
        cmp #$FFFF
        bne _848E
        lda #$0006
        sta $455E,b
        bra _8504


        _848E
        lda aActionStructUnit2.XPosition
        sta $4556,b
        lda aActionStructUnit2.YPosition
        sta $4558,b
        lda #$0001
        sta @l wR15
        lda $4550,b
        jsl rlUnknown9E857D
        bcs _84FA
        lda aActionStructUnit2.WeaponID
        jsl rlUnknown9E866F
        bcs _84FA
        lda aActionStructUnit2.Unknown
        tay
        lda aActionStructUnit2.WeaponID
        jsl rlUnknown9E86CF
        sta $508D,b
        lda $7F4BF1
        sta $7F4BEF
        lda $7F4C09
        sta $7F4C0D
        lda #$0000
        bcs _84FA
        lda aActionStructUnit2.WeaponID
        jsl rlGetItemDataROMPointer
        jsl rlGetItemWeaponType
        cmp #$0004
        bcc _84FA
        lda aActionStructUnit2.WeaponID
        sec
        sbc #$003E
        sta $508D,b
        lda #$0004

        _84FA
        sta $454C,b
        jsl rlUnknown9E805E
        lda $455E,b

        _8504
        eor #$0004
        sta $4560,b
        lda wBattleType
        and #$00FF
        cmp #$0003
        bne _8526
        lda #$0006
        sta $455E,b
        sta $4560,b
        lda #$0000
        sta @l $000891

        _8526
        plb
        .databank ?
        ply
        plx
        rtl

        .databank 0

        ; 9E/852A

      rlUnknown9E852A ; 9E/852A

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        phx
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda wR0
        cmp #$0032
        bne _8578
        lda aActionStructUnit1.Unknown
        cmp #$0008
        beq _854B
        lda aActionStructUnit2
        cmp #$FFFF
        bne _8578

        _854B
        lda #$0004
        sta $454A,b
        lda #$FFFF
        sta $508B,b
        sta $508D,b
        sta $4550,b
        lda #$0000
        sta $4556,b
        sta $4558,b
        sta $454C,b
        lda #$0001
        sta $4BE7,b
        lda #$0006
        sta $455E,b
        sec
        bra _8579


        _8578
        clc

        _8579
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/857D

      rlUnknown9E857D ; 9E/857D

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda @l wR0
        cmp #$0043
        bcc _85A0
        cmp #$0047
        bcs _85A0
        lda @l wR15
        asl a
        tax
        lda #$0001
        sta $7F4C11,x
        lda #$0003
        sec
        bra _85A1


        _85A0
        clc

        _85A1
        plx
        ply
        rtl

        .databank 0

        ; 9E/85A4

    .endsection Unsorted9E838BSection


    .section Unsorted9E85A4Section

      .al
      .xl

      rlUnknown9E85A4 ; 9E/85A4

        .al
        .autsiz
        .databank ?

        ; Get gendered battle sprite?

        ; wR0 = ClassID
        ; wR1 = Gender
        ; wR2 = CharacterID

        phx
        phy
        lda wR0
        cmp #KnightLord
        bne +

          lda wR2
          cmp #Seliph
          bne +

            lda #$005D
            bra _End

        +
        asl a
        tax
        lda aUnknown9E85DF,x
        cmp #$FFFF
        bne +

          lda wR0
          bra _End

        +
        lda wR1
        dec a
        beq +

          lda wR0
          bra _End

        +
        lda wR0
        asl a
        tax
        lda aUnknown9E85DF+1,x
        and #$00FF

        _End
        ply
        plx
        rtl

        .databank 0

    .endsection Unsorted9E85A4Section


    .section Unsorted9E85DFSection

      .al
      .xl

      aUnknown9E85DF ; 9E/85DF

        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte MasterKnight, $48
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte MageKnight, $49
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte Dragonrider, $4A
        .byte Dragonknight, $4B
        .byte Dragonmaster, $4C
        .byte Archer, $4D
        .byte Myrmidon, $4E
        .byte Swordmaster, $4F
        .byte Sniper, $50
        .byte Hero, $51
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte Priest, $52
        .byte Mage, $53
        .byte FireMage, $54
        .byte ThunderMage, $55
        .byte WindMage, $56
        .byte HighPriest, $57
        .byte $FF, $FF
        .byte Sage, $58
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte Thief, $59
        .byte Rogue, $5A
        .byte Civilian, $5B
        .byte Child, $5C
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF
        .byte $FF, $FF

      rlUnknown9E866F ; 9E/866F

        .al
        .autsiz
        .databank ?

        ; Get class' main battle weapon type
        ; 0 = sword
        ; 1 = lance
        ; 2 = axe
        ; 3 = bow
        ; 4 = magic

        phy
        phx
        cmp #$FFFF
        bne _CLC

          lda wR0
          tax
          lda aUnknown9E8687,x
          and #$00FF
          sec
          bra +

        _CLC
        clc

        +
        plx
        ply
        rtl

        .databank 0

      aUnknown9E8687 ; 9E/8687

        .byte 1 ; Cavalier
        .byte 1 ; LanceKnight
        .byte 3 ; BowKnight
        .byte 2 ; AxeKnight
        .byte 0 ; FreeKnight
        .byte 0 ; Troubadour
        .byte 0 ; KnightLord
        .byte 1 ; DukeKnight
        .byte 0 ; MasterKnight
        .byte 1 ; Paladin
        .byte 1 ; PaladinF
        .byte 3 ; ArchKnight
        .byte 0 ; Ranger
        .byte 1 ; MageKnight
        .byte 2 ; GreatKnight
        .byte 0 ; PegasusRider
        .byte 0 ; PegasusKnight
        .byte 0 ; FalconKnight
        .byte 1 ; Dragonrider
        .byte 1 ; Dragonknight
        .byte 1 ; Dragonmaster
        .byte 3 ; Archer
        .byte 0 ; Myrmidon
        .byte 0 ; Swordmaster
        .byte 3 ; Sniper
        .byte 0 ; Hero
        .byte 1 ; General
        .byte 1 ; Emperor
        .byte 1 ; Baron
        .byte 1 ; Soldier
        .byte 1 ; SpearSoldier
        .byte 2 ; AxeSoldier
        .byte 3 ; BowSoldier
        .byte 0 ; SwordSoldier
        .byte 1 ; LanceArmor
        .byte 2 ; AxeArmor
        .byte 3 ; BowArmor
        .byte 0 ; SwordArmor
        .byte 2 ; Barbarian
        .byte 2 ; Fighter
        .byte 2 ; Brigand
        .byte 2 ; Warrior
        .byte 3 ; Hunter
        .byte 2 ; Pirate
        .byte 0 ; JuniorLord
        .byte 0 ; WarMage
        .byte 0 ; Prince
        .byte 0 ; Princess
        .byte 4 ; WarMageF
        .byte 4 ; Queen
        .byte 0 ; Dancer
        .byte 4 ; Priest
        .byte 4 ; Mage
        .byte 4 ; FireMage
        .byte 4 ; ThunderMage
        .byte 4 ; WindMage
        .byte 4 ; HighPriest
        .byte 4 ; Bishop
        .byte 4 ; Sage
        .byte 4 ; Bard
        .byte 4 ; Priestess
        .byte 4 ; DarkMage
        .byte 4 ; DarkBishop
        .byte 0 ; Thief
        .byte 0 ; Rogue
        .byte 0 ; Civilian
        .byte 0 ; Child
        .byte 3 ; Ballistician
        .byte 3 ; IronBallistician
        .byte 3 ; KillerBallistician
        .byte 3 ; GreatBallistician
        .byte 4 ; DarkPrince

      ; 9E/86CF

    .endsection Unsorted9E85DFSection


    .section Unsorted9E86CFSection

      .al
      .xl

      rlUnknown9E86CF ; 9E/86CF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        sta $7F57EE
        tya
        sta $7F57F0
        lda #$FFFF
        sta $7F4BF1
        lda #$0000
        sta $7F4C09
        lda $7F57EE
        jsl rlGetItemDataROMPointer
        sta $7F57EA
        jsl rlGetItemWeaponType
        sta $7F57EC
        cmp #WeaponTypeSword
        beq _8705
        jml _878B


        _8705
        lda $7F57EA
        jsl rlGetItemWeaponTraits
        cmp #$0001
        beq _8726
        cmp #$0002
        beq _8726
        cmp #$0003
        beq _8726
        cmp #$0006
        beq _875C

        _8721
        lda #$FFFF
        bra _8782


        _8726
        lda wBattleDistance
        dec a
        bne _873F
        lda $7F57EE
        cmp #$0010
        bne _8721
        lda #$0001
        sta $7F4C09
        bra _8721


        _873F
        jsl rlUnknown9E811F
        lda $7F57EE
        sec
        sbc #$000F
        cmp #$0005
        bcs _8782
        asl a
        tax
        lda aUnknown9E8792,x
        sec
        sbc #$003E
        bra _8782


        _875C
        jsl rlUnknown9E811F
        lda $7F57EE
        sec
        sbc #$0009
        cmp #$0004
        bcs _8782
        cmp #$0001
        beq _8782
        sta $7F4BF1
        asl a
        tax
        lda aUnknown9E879C,x
        bmi _8782
        sec
        sbc #$003E

        _8782
        sta wR0
        lda wR0
        bmi _878F
        sec
        bra _878F


        _878B
        lda #$FFFF
        clc

        _878F
        ply
        plx
        rtl

        .databank 0

        ; 9E/8792

    .endsection Unsorted9E86CFSection


    .section Table9E8792Section

      .al
      .xl

      aUnknown9E8792 ; 9E/8792

        ; Read by rlUnknown9E86CF.

        .word $003F, $004E, $0044, $0049, $004D

        ; 9E/879C

    .endsection Table9E8792Section


    .section Table9E879CSection

      .al
      .xl

      aUnknown9E879C ; 9E/879C

        ; Read by rlUnknown9E86CF.

        .word $0065, $FFFF, $0063, $0064

        ; 9E/87A4

    .endsection Table9E879CSection


    .section Unsorted9E87A4Section

      .al
      .xl

      rlUnknown9E87A4 ; 9E/87A4

        .al
        .autsiz
        .databank ?

        phb
        pea #$7F00
        plb
        plb

        lda $454E,b
        sta $4568,b
        lda $454A,b
        sta $4566,b
        lda $454E,b
        sta $456E,b
        lda $455E,b
        sta $4570,b
        lda #0
        sta $4576,b
        plb
        rtl

        .databank 0

        ; 9E/87CA

    .endsection Unsorted9E87A4Section


    .section Unsorted9E87CASection

      .al
      .xl

      rlUnknown9E87CA ; 9E/87CA

        .al
        .xl
        .autsiz
        .databank ?

        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda $4550,b
        sta $4568,b
        lda $454C,b
        sta $4566,b
        lda $4550,b
        sta $456E,b
        lda $4560,b
        sta $4570,b
        lda #$0001
        sta $4576,b
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/87F0

      rlUnknown9E87F0 ; 9E/87F0

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        phx
        sta wR0
        lda $7F456E
        sta wR10
        lda #$0031
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda #$9E00
        sta lR18+1
        lda #$B50D
        clc
        adc wR12
        sta lR18
        ldy #$0030
        lda [lR18],y
        and #$00FF
        sta $7F4572
        lda wR0
        asl a
        tax
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc aUnknown9E8863,x
        sta lR18
        lda lR18+1
        sta $7F4593
        sta $7F4596
        lda $7F4566
        asl a
        tay
        lda [lR18],y
        clc
        adc lR18
        sta lR18
        ldy #$0006
        lda [lR18],y
        clc
        adc lR18
        sta $7F4592
        ldy #$0008
        lda [lR18],y
        clc
        adc lR18
        sta $7F4595
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/8863

    .endsection Unsorted9E87CASection


    .section Table9E8863Section

      .al
      .xl

      aUnknown9E8863 ; 9E/8863

        ; Read by rlUnknown9E87F0.

        .word $6000, $6880

        ; 9E/8867

    .endsection Table9E8863Section


    .section Unsorted9E8867Section

      .al
      .xl

      rlUnknown9E8867 ; 9E/8867

        .al
        .autsiz
        .databank ?

        phb
        phy
        phx
        sta $00
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda @l $7F4570
        asl a
        clc
        adc @l $7F4570
        asl a
        sta wR1
        lda @l $7F456E
        sta wR10
        lda #49
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        clc
        adc wR1
        tax
        lda aBattleMapSpriteData+1,x
        sta lR18+1
        lda aBattleMapSpriteData,x
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$6000
        sta lR19

        lda wR0
        beq +

          lda #(`aDecompressionBuffer)<<8
          sta lR19+1
          lda #<>aDecompressionBuffer
          clc
          adc #$6880
          sta lR19

        +
        plp
        plb
        jsl rlAppendDecompList
        plx
        ply
        plb
        rtl

        .databank 0

    .endsection Unsorted9E8867Section


    .section Unsorted9E88CESection

      .al
      .xl

      rlUnknown9E88CE ; 9E/88CE

        .al
        .autsiz
        .databank ?

        phx
        ldx #2

          -
          lda aUnknown9E88F4,x
          sta $7EFC88,x
          sta $7EFC8E,x
          sta $7EFC94,x
          sta $7EFC9A,x
          dec x
          dec x
          bpl -

        lda aUnknown9E88F4 + 4
        sta $7EFCA0
        plx
        rtl

        .databank 0

    .endsection Unsorted9E88CESection


    .section Unsorted9E88F4Section

      .al
      .xl

      aUnknown9E88F4 ; 9E/88F4

        .word $FCA0
        .word $FCA0
        .byte $6B

      rlUnknown9E88F9 ; 9E/88F9

        ; Pushes X and runs on into rlUnknown9E88FA.
        .al
        .xl
        .autsiz
        .databank ?

        phx

        .databank 0

    .endsection Unsorted9E88F4Section


    .section Unsorted9E88FASection

      .al
      .xl

      rlUnknown9E88FA ; 9E/88FA

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phy
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda @l $7F4BE7
        beq _8929
        lda #$213F
        sta @l $000224
        lda #$0002
        sta @l $000226
        lda #$AC00
        sta @l lR18+1
        lda #$C8C3
        sta @l lR18
        bra _895A


        _8929
        lda @l aMapAction.wUnknown7F455E
        asl a
        clc
        adc @l aMapAction.wUnknown7F455E
        asl a
        sta wR0
        lda @l aMapAction.wBattleClassID
        sta wR10
        lda #$0031
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        clc
        adc wR0
        adc #$0003
        tax
        lda $9EB50E,x
        sta lR18+1
        lda aBattleMapSpriteData,x
        sta lR18

        _895A
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$0000
        sta lR19
        plp
        plb
        .databank $7F
        jsl rlAppendDecompList
        lda aActionStructUnit2
        cmp #$FFFF
        beq _89EE
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda @l aMapAction.wUnknown7F4560
        asl a
        clc
        adc @l aMapAction.wUnknown7F4560
        asl a
        sta wR0
        lda @l aMapAction.wUnknown7F4450
        sta wR10
        lda #$0031
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        clc
        adc wR0
        adc #$0003
        tax
        lda $9EB50E,x
        sta lR18+1
        lda aBattleMapSpriteData,x
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$2000
        sta lR19
        plp
        plb
        .databank $7F
        jsl rlAppendDecompList
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda #(`gcUnknownACCC17)<<8
        sta lR18+1
        lda #<>gcUnknownACCC17
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$4000
        sta lR19
        plp
        plb
        .databank $7F
        jsl rlAppendDecompList

        _89EE
        ply
        plx
        rtl

        .databank 0

        ; 9E/89F1

    .endsection Unsorted9E88FASection


    .section Unsorted9E89F1Section

      .al
      .xl

      rlUnknown9E89F1 ; 9E/89F1

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $9E
        phy
        phx
        jsl rlUnknown9E87A4
        lda #$0000
        jsl rlUnknown9E87F0
        lda lR18
        sta $7F4598
        lda lR18+1
        sta $7F4599
        lda wBattleType
        and #$00FF
        cmp #$0003
        beq _8A2D
        lda $7F4C87
        and #$0001
        bne _8A35
        lda aActionStructUnit1
        tax
        jsl rlDeployedUnitSetHidden
        bra _8A35


        _8A2D
        lda aActionStructUnit1
        jsl rlUnknown9EAC0E

        _8A35
        lda $7F4C87
        bne _8A51
        lda aActionStructUnit1
        tax
        lda aDeploymentTable,x
        and #$0003
        sta aMapAction.wUnknown7F4562
        sta $7F4574
        bra _8A59


        _8A51
        lda aMapAction.wUnknown7F4562
        sta $7F4574

        _8A59
        jsl rlUnknown9E8D6C
        jsl rlUnknown9E8DBB
        lda aActionStructUnit1.WeaponID
        jsl rlUnknown9E8E01
        lda aMapAction.wXTilePosition
        tax
        lda aMapAction.wYTilePosition
        tay
        lda aActionStructUnit1.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda wR0
        and #$00FF
        sta $7F4578
        lda wR1
        and #$00FF
        sta $7F457A
        lda #$7E00
        sta lR44+1
        lda #$FC88
        sta lR44
        lda $7F4592
        sta $7EFC8C
        lda #$FC88
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F45A4
        lda $7F4576
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda $7F4572
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda aMapAction.wUnknown7F4562
        inc a
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda $7F4576
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda $7F4572
        bne _8AE1
        lda $7F4C11
        bne _8AE1
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001280,b,x

        _8AE1
        lda $7F4572
        beq _8B30
        lda $7F4C11
        bne _8B30
        lda $7F4566
        cmp #$0004
        bcs _8B30
        lda #$7E00
        sta lR44+1
        lda #$FC8E
        sta lR44
        lda $7F4595
        sta $7EFC92
        lda #$FC8E
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F45A6
        lda #$0020
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda aMapAction.wUnknown7F4562
        inc a
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda $7F4576
        sta aActiveSpriteSystem.aUnknown001320,b,x

        _8B30
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/8B34

      rlUnknown9E8B34 ; 9E/8B34

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $9E
        phy
        phx
        jsl rlUnknown9E87CA
        lda aActionStructUnit2
        cmp #$FFFF
        bne _8B4A
        jml _8C7D


        _8B4A
        lda #$0001
        jsl rlUnknown9E87F0
        lda lR18
        sta $7F459B
        lda lR18+1
        sta $7F459C
        lda wBattleType
        and #$00FF
        cmp #$0003
        beq _8B74
        lda aActionStructUnit2
        tax
        jsl rlDeployedUnitSetHidden
        bra _8B7C


        _8B74
        lda aActionStructUnit2
        jsl rlUnknown9EAC0E

        _8B7C
        lda $7F4C87
        bne _8B98
        lda aActionStructUnit2
        tax
        lda aDeploymentTable,x
        and #$0003
        sta $7F4564
        sta $7F4574
        bra _8BA0


        _8B98
        lda $7F4564
        sta $7F4574

        _8BA0
        jsl rlUnknown9E8D6C
        jsl rlUnknown9E8DBB
        lda aActionStructUnit2.WeaponID
        jsl rlUnknown9E8E01
        lda aMapAction.wUnknown7F4556
        tax
        lda aMapAction.wUnknown7F4558
        tay
        lda aActionStructUnit2.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda wR0
        and #$00FF
        sta $7F457C
        lda wR1
        and #$00FF
        sta $7F457E
        lda #$7E00
        sta lR44+1
        lda #$FC94
        sta lR44
        lda $7F4592
        sta $7EFC98
        lda #$FC94
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F45A8
        lda #$0008
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda $7F4576
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda $7F4572
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda $7F4564
        inc a
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda $7F4576
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda $7F4C13
        bne _8C28
        lda $7F4572
        bne _8C2E

        _8C28
        lda #$0020
        sta aActiveSpriteSystem.aUnknown001280,b,x

        _8C2E
        lda $7F4572
        beq _8C7D
        lda $7F4C13
        bne _8C7D
        lda $7F4566
        cmp #$0004
        bcs _8C7D
        lda #$7E00
        sta lR44+1
        lda #$FC9A
        sta lR44
        lda $7F4595
        sta $7EFC9E
        lda #$FC9A
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F45AA
        lda #$0040
        sta aActiveSpriteSystem.aUnknown001260,b,x
        lda $7F4564
        inc a
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda $7F4576
        sta aActiveSpriteSystem.aUnknown001320,b,x

        _8C7D
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/8C81

      rlUnknown9E8C81 ; 9E/8C81

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7F5091
        jsr rsUnknown9E8CED
        lda $7F457A
        xba
        ora $7F4578
        sta wR0
        lda $7F457E
        xba
        ora $7F457C
        sta wR1
        lda #$0000
        sta $7F509F
        lda aActionStructUnit2
        cmp #$FFFF
        bne _8CBE
        lda wR0
        sta $7F5099
        sta $7F509B
        bra _8CEB


        _8CBE
        lda $7F459E
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        sta $7F4BEB
        and #$0001
        bne _8CDF
        lda wR0
        sta $7F5099
        lda wR1
        sta $7F509B
        bra _8CEB


        _8CDF
        lda wR1
        sta $7F5099
        lda wR0
        sta $7F509B

        _8CEB
        plx
        rtl

        .databank 0

        ; 9E/8CED

      rsUnknown9E8CED ; 9E/8CED

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$FFFF
        sta $7F509D
        lda $7F508B
        cmp #$0021
        bne _8D23
        lda $7E4F77
        tax
        lda $7E4F79
        tay
        lda aActionStructUnit2.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        xba
        ora wR0
        sta $7F509D

        _8D23
        plx
        rts

        .databank 0

        ; 9E/8D25

    .endsection Unsorted9E89F1Section


    .section Unsorted9E8D25Section

      .al
      .xl

      rlUnknown9E8D25 ; 9E/8D25

        .al
        .autsiz
        .databank ?

        sta wR0
        lda wBattleType
        and #$00FF
        cmp #3
        beq +

          txa
          asl a
          asl a
          asl a
          asl a
          clc
          adc #8
          sec
          sbc wMapScrollXPixels,b
          sta wR0

          tya
          asl a
          asl a
          asl a
          asl a
          clc
          adc #8
          sec
          sbc wMapScrollYPixels,b
          sta wR1
          rtl

        +
        lda wR0
        sta wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitGenerationID
        dec a
        asl a
        tax
        lda $7F75DA,x
        sta wR0
        lda $7F760A,x
        sta wR1
        rtl

        .databank 0

        ; 9E/8D6C

    .endsection Unsorted9E8D25Section


    .section Unsorted9E8D6CSection

      .al
      .xl

      rlUnknown9E8D6C ; 9E/8D6C

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $9E
        phy
        phx
        lda $7F4566
        asl a
        tay
        lda $B4CD,b,y
        sta wR2
        lda $7F4576
        asl a
        tay
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc wR2
        adc $B4C9,b,y
        sta lR18
        lda #$0400
        sta wR0
        lda $7F4576
        asl a
        tax
        lda @l aUnknown9EB4DB,x
        sta wR2
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc wR2
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/8DBB

      rlUnknown9E8DBB ; 9E/8DBB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        phk
        plb
        .databank $9E
        lda $7F4576
        asl a
        tax
        lda @l aUnknown9EB4C9,x
        sta wR2
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$1000
        adc wR2
        sta lR18
        lda @l aUnknown9EB4D7,x
        sta wR2
        lda $7F4572
        and #$00FF
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc wR2
        sta wR1
        jsl rlUnknown88DD9C
        plb
        .databank $9E
        plx
        rtl

        .databank 0

        ; 9E/8E01

      rlUnknown9E8E01 ; 9E/8E01

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        cmp #$FFFF
        bne _8E0C
        jml _8EC1


        _8E0C
        cmp #$007A
        bcs _8E23
        cmp #$007D
        bcc _8E1A
        jml _8EC1


        _8E1A
        cmp #$003A
        bcc _8E23
        jml _8EC1


        _8E23
        cmp #$007A
        bcc _8E30
        sec
        sbc #$007A
        clc
        adc #$003A

        _8E30
        sta $7F57EA
        asl a
        tax
        lda aUnknown9E8EC4,x
        and #$00FF
        xba
        sta wR2
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$4000
        adc wR2
        sta lR18
        lda #$0080
        sta wR0
        lda $7F4576
        asl a
        tax
        lda aUnknown9EB4DB,x
        sta wR2
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc wR2
        sta wR1
        jsl rlDMAByPointer
        lda lR18
        clc
        adc #$0080
        sta lR18
        lda wR1
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        lda $7F57EA
        asl a
        tax
        lda aUnknown9E8EC4,x
        and #$FF00
        xba
        asl a
        asl a
        tax
        lda aUnknown9E8F3E,x
        pha
        inc x
        inc x
        lda aUnknown9E8F3E,x
        pha
        lda $7F4574
        inc a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$0006
        tax
        pla
        sta @l aOAMPaletteBuffer,x
        dec x
        dec x
        pla
        sta @l aOAMPaletteBuffer,x

        _8EC1
        ply
        plx
        rtl

        .databank 0

        ; 9E/8EC4

    .endsection Unsorted9E8D6CSection


    .section Table9E8EC4Section

      .al
      .xl

      aUnknown9E8EC4 ; 9E/8EC4

        ; Read by rlUnknown9E8E01.

        .word $0200, $0000, $0900, $0205, $0005, $0905, $0607, $0608
        .word $0408, $0102, $0804, $0302, $0002, $0007, $0807, $0103
        .word $0203, $0403, $0003, $0603, $0706, $0806, $0509, $0104
        .word $0004, $0301, $0301, $0301, $020A, $000A, $090A, $020C
        .word $040C, $090F, $060C, $0A0D, $010E, $020B, $020B, $020B
        .word $0210, $0010, $0910, $0114, $0013, $0212, $0311, $0311
        .word $0311, $0216, $0016, $0916, $0019, $0118, $0417, $0315
        .word $0315, $0315, $0301, $020B, $0315

        ; 9E/8F3E

    .endsection Table9E8EC4Section


    .section Table9E8F3ESection

      .al
      .xl

      aUnknown9E8F3E ; 9E/8F3E

        ; Read by rlUnknown9E8E01.

        .word $6481, $1F19, $213F, $03A0, $2DD2, $6E10, $2D6B, $08B1
        .word $0B7F, $013E, $6481, $0197, $03E0, $0D23, $213F, $0197
        .word $0B7F, $0197, $7FFF, $6E10, $001B, $1E9C

        ; 9E/8F6A

    .endsection Table9E8F3ESection


    .section Unsorted9E8F6ASection

      .al
      .xl

      rlUnknown9E8F6A ; 9E/8F6A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7F4584
        lda aUnknown9E8FB2
        sta $7EFCA1
        lda #$7E00
        sta $7F4587
        lda #$FCA1
        sta $7F4586
        lda #$7E00
        sta $7F458A
        lda #$FCA1
        sta $7F4589
        lda #$7E00
        sta $7F458D
        lda #$FCA1
        sta $7F458C
        lda #$7E00
        sta $7F4590
        lda #$FCA1
        sta $7F458F
        rtl

        .databank 0

        ; 9E/8FB2

    .endsection Unsorted9E8F6ASection


    .section Table9E8FB2Section

      .al
      .xl

      aUnknown9E8FB2 ; 9E/8FB2

        ; Read by rlUnknown9E8F6A.

        .byte $01

        ; 9E/8FB3

    .endsection Table9E8FB2Section


    .section Unsorted9E8FB3Section

      .al
      .xl

      rlUnknown9E8FB3 ; 9E/8FB3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0001
        sta $7F4584
        lda $7F4C31
        beq _8FD0
        lda aActionStructUnit1
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive
        lda $7F4C31
        bpl _8FEA

        _8FD0
        jsl rlUnknown81AE16
        stz wR15
        rol wR15
        lda wR15
        bne _8FEA
        lda aActionStructUnit2
        cmp #$FFFF
        beq _8FEA
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive

        _8FEA
        plx
        jsl rlUnknown88CD4C
        lda wBattleType
        and #$00FF
        cmp #$0003
        beq _9007
        lda $7F4C87
        bne _900B
        jsl rlUnknown88CD5A
        bra _900B


        _9007
        jsl rlUnknown9EAC1D

        _900B
        lda #(`rlPushToOAMBuffer)<<8
        sta $15E5,b
        lda #<>rlPushToOAMBuffer
        sta $15E4,b
        lda $7F4BD9
        sta aActiveSpriteSystem,b
        jsl rlUnknown808882
        stz wBufferBG3VOFS
        rtl

        .databank 0

        ; 9E/9025

      rlUnknown9E9025 ; 9E/9025

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        stx wR0
        lda $7F4BEB
        bit #$0008
        beq _9041
        lda $7F45A2
        cmp #$FFFF
        beq _9071
        jsl rlUnknown9EB24C
        bra _9071


        _9041
        bit #$0002
        beq _904E
        xba
        and #$00FF
        beq _9071
        bra _906B


        _904E
        xba
        and #$00FF
        beq _905D
        lda $7F4BEB
        bit #$0004
        beq _906B

        _905D
        jsl rlUnknown9E9074
        lda $7F4BEB
        xba
        and #$00FF
        beq _9071

        _906B
        ldx wR0
        jsl rlUnknown9E91CF

        _9071
        plx
        ply
        rtl

        .databank 0

        ; 9E/9074

      rlUnknown9E9074 ; 9E/9074

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        phx
        lda @l $7F4580
        bne _908A
        jml _911E


        _908A
        lda @l $001057,x
        dec a
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        eor #$0001
        asl a
        asl a
        tay
        lda @l $7F45A2
        bmi _911E
        cmp #$0004
        bcc _9100
        asl a
        tax
        lda @l $7F4BEB
        xba
        and #$00FF
        beq _90C0
        lda aUnknown9E9123,x
        cmp #$8000
        bne _90DD
        bra _90D4


        _90C0
        lda aUnknown9E914B,x
        cmp #$8000
        bne _90DD
        lda #$0000
        sta @l $7F4580
        jsl rlUnknown9EB214

        _90D4
        lda #$FFFF
        sta @l $7F45A2
        bra _911E


        _90DD
        sta wR1
        ldx $45A4,b,y
        clc
        adc @l $001200,x
        sta @l $001200,x
        inc y
        inc y
        ldx $45A4,b,y
        cpx #$FFFF
        beq _9100
        lda wR1
        clc
        adc @l $001200,x
        sta @l $001200,x

        _9100
        inc $45A2,b
        lda @l $7F45A2
        cmp #$0005
        bne _911E
        plx
        plp
        plb
        .databank ?
        jsl rlUnknown9E9276
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        phx

        _911E
        plx
        plp
        plb
        .databank ?
        ply
        rtl

        .databank 0

        ; 9E/9123

    .endsection Unsorted9E8FB3Section


    .section Table9E9123Section

      .al
      .xl

      aUnknown9E9123 ; 9E/9123

        ; Read by rlUnknown9E9074.

        .word $0000, $0000, $0000, $0000, $FFFF, $0003, $FFFD, $0003
        .word $FFFD, $0003, $FFFD, $0003, $FFFD, $0003, $FFFD, $0003
        .word $FFFD, $0003, $FFFE, $8000

        ; 9E/914B

    .endsection Table9E9123Section


    .section Table9E914BSection

      .al
      .xl

      aUnknown9E914B ; 9E/914B

        ; Read by rlUnknown9E9074.

        .word $0000, $0000, $0000, $0000, $FFFF, $0002, $FFFF, $8000

        ; 9E/915B

    .endsection Table9E914BSection


    .section Unsorted9E915BSection

      .al
      .xl

      rlUnknown9E915B ; 9E/915B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda @l $001057,x
        dec a
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        eor #$0001
        asl a
        asl a
        tax
        phx
        lda $7F45A4,x
        tax
        lda #$0005
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        plx
        lda $7F45A6,x
        bmi _918F
        tax
        lda #$0005
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        clc
        bra _918F

        .byte $38


        _918F
        ply
        plx
        rtl

        .databank 0

        ; 9E/9192

      rlUnknown9E9192 ; 9E/9192

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda @l aMapAction.wUnknown7F4562
        inc a
        ldx $45A4,b
        sta @l $0012A0,x
        ldx $45A6,b
        bmi _91B3
        sta @l $0012A0,x

        _91B3
        lda @l $7F4564
        inc a
        ldx $45A8,b
        bmi _91CA
        sta @l $0012A0,x
        ldx $45AA,b
        bmi _91CA
        sta @l $0012A0,x

        _91CA
        plp
        plb
        .databank $7F
        ply
        plx
        rtl

        .databank 0

        ; 9E/91CF

      rlUnknown9E91CF ; 9E/91CF

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F4580
        bne _91DB
        jml _9273


        _91DB
        lda $7F45CC
        bne _924E
        jsl rlUnknown9E915B
        bcc _91EB
        jml _9273


        _91EB
        lda @l $001057,x
        dec a
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        eor #$0001
        asl a
        tax
        lda aMapAction.wUnknown7F4562,x
        clc
        adc #$0009
        xba
        lsr a
        lsr a
        lsr a
        tax
        ldy #$0000

        _920E
        lda aBGPaletteBuffer,b,x
        sta wR0
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda wR0
        sta $45AC,b,y
        plp
        plb
        .databank $7F
        inc x
        inc x
        inc y
        inc y
        cpy #$0020
        bne _920E
        ldx #$01A2

        _9230
        lda #$7FFF
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        cpx #$01C0
        bne _9230
        lda #$0001
        sta @l $7F45CC
        plx
        jsl rlUnknown9EB160
        jsl rlUnknown9E9276
        phx

        _924E
        lda #$7F00
        sta lR18+1
        lda #$45AC
        clc
        adc #$0002
        sta lR18
        ldy #$000F
        lda #$00D1
        jsl rlUnknown959F43
        bcc _9273
        jsl rlUnknown9E9192
        lda #$0000
        sta @l $7F4580

        _9273
        plx
        ply
        rtl

        .databank 0

        ; 9E/9276

      rlUnknown9E9276 ; 9E/9276

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F4C87
        beq _9282
        jml _9316


        _9282
        lda #(`aBattleRoundsData)<<8
        sta lStructPointer2+1,b
        lda #<>aBattleRoundsData
        sta lStructPointer2,b
        lda @l $001057,x
        sta wStructIndex,b
        jsl rlLoadRAMStructDataByIndex
        lda lStructPointer1,b
        sta @l $001077,x
        lda lStructPointer1+1,b
        and #$00FF
        sta wR0
        lda lStructPointer1,b
        bit #$0001
        bne _92E3
        lda lStructPointer1,b
        bit #$0002
        beq _92C0
        lda wR0
        jsl rlUnknown85D32D
        bra _9316


        _92C0
        lda wR0
        jsl rlUnknown85D319
        lda $7F508B
        cmp #$0010
        beq _92DB
        lda $7F4BE9
        bne _92DB
        lda $7F4C0B
        beq _9316

        _92DB
        lda wR0
        jsl rlUnknown85D323
        bra _9316


        _92E3
        lda lStructPointer1,b
        bit #$0002
        beq _92F3
        lda wR0
        jsl rlUnknown85D323
        bra _9316


        _92F3
        lda wR0
        jsl rlUnknown85D30F
        lda $7F508D
        cmp #$0010
        beq _930E
        lda $7F4BE9
        bne _930E
        lda $7F4C0D
        beq _9316

        _930E
        lda wR0
        jsl rlUnknown85D32D
        bcc _9316

        _9316
        lda #$0000
        sta $7F4BE9
        plx
        ply
        rtl

        .databank 0

        ; 9E/9320

    .endsection Unsorted9E915BSection


    .section Unsorted9E9320Section

      .al
      .xl

      rlUnknown9E9320 ; 9E/9320

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda bUnknown000E7B,b
        bit #$0040
        bne _9340
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable,x
        bit #$0020
        bne _9340
        bit #$0010
        beq _9340
        jsl rlUnknown88B6FD
        bra _9340


        _9340
        plx
        rtl

        .databank 0

        ; 9E/9342

    .endsection Unsorted9E9320Section


    .section Unsorted9E9342Section

      .al
      .xl

      rlUnknown9E9342 ; 9E/9342

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7E4ECB
        beq _936A
        lda #<>rlUnknown9E936B
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0000
        sta $7F45CE
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _936A
        rtl

        .databank 0

        ; 9E/936B

      rlUnknown9E936B ; 9E/936B

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        phx
        lda $7F45CE
        bne _937F
        jsl rlUnknown9E93A4
        lda #$0000
        sta $7F45CE

        _937F
        jsl rlUnknown9E93E7
        lda $7F45CE
        cmp #$0019
        bne _9397
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        bra _93A0


        _9397
        lda $7F45CE
        inc a
        sta $7F45CE

        _93A0
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/93A4

      rlUnknown9E93A4 ; 9E/93A4

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$9C00
        sta lR18+1
        lda #$FC00
        clc
        adc #$0100
        sta lR18
        ldy #$001E

        _93B7
        lda [lR18],y
        sta aOAMPaletteBuffer,b,y
        dec y
        dec y
        bpl _93B7
        lda #$9C00
        sta lR18+1
        lda #$F000
        clc
        adc #$0300
        sta lR18
        lda #$0060
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        rtl

        .databank 0

        ; 9E/93E7

      rlUnknown9E93E7 ; 9E/93E7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        phx
        lda $7F45CE
        asl a
        tax
        lda aUnknown9E9480,x
        cmp #$8000
        bne _93FE
        sec
        jml _947C


        _93FE
        lda $7F4578
        clc
        adc aUnknown9E9480,x
        sta wR0
        jsl rlUnknown9E950A
        lda $7F457A
        clc
        adc wR1
        adc aUnknown9E94B6,x
        sta wR1
        lda $7F45CE
        tax
        lda aUnknown9E94EA,x
        and #$00FF
        sta wR15
        stz wR4
        stz wR5
        stz wR6
        stz wR14
        stz wR13
        lda #$0003
        sta $7E52F0
        ldx #$0000

        _943C
        lda wR14
        sta $7E52F2,x
        clc
        adc wR15
        sta wR14
        sep #$20
        lda #$00
        sta $7E52F4,x
        rep #$20
        phx
        lda wR13
        asl a
        tax
        lda aUnknown9E9504,x
        ora #$2000
        plx
        sta $7E52F5,x
        inc wR13
        txa
        clc
        adc #$0005
        tax
        cpx #$000F
        bne _943C
        pea #$7E00
        plb
        .databank ?
        plb
        .databank ?
        ldy #$52F0
        jsl rlPushToOAMBuffer
        clc

        _947C
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/9480

    .endsection Unsorted9E9342Section


    .section Table9E9480Section

      .al
      .xl

      aUnknown9E9480 ; 9E/9480

        ; Read by rlUnknown9E93E7.

        .word $FFF4, $FFF4, $FFEF, $FFEF, $FFEC, $FFEC, $FFEF, $FFEF
        .word $FFF4, $FFF4, $FFF9, $FFF9, $FFFC, $FFFC, $FFF9, $FFF9
        .word $FFF4, $FFF4, $FFF4, $FFF4, $FFF4, $FFF4, $FFF4, $FFF4
        .word $FFF4, $FFF4, $8000

        ; 9E/94B6

    .endsection Table9E9480Section


    .section Table9E94B6Section

      .al
      .xl

      aUnknown9E94B6 ; 9E/94B6

        ; Read by rlUnknown9E93E7.

        .word $FFEC, $FFEC, $FFE9, $FFE9, $FFE4, $FFE4, $FFDF, $FFDF
        .word $FFDC, $FFDC, $FFDF, $FFDF, $FFE4, $FFE4, $FFE9, $FFE9
        .word $FFEC, $FFEC, $FFEB, $FFEC, $FFEB, $FFEC, $FFEB, $FFEC
        .word $FFEB, $FFEC

        ; 9E/94EA

    .endsection Table9E94B6Section


    .section Table9E94EASection

      .al
      .xl

      aUnknown9E94EA ; 9E/94EA

        ; Read by rlUnknown9E93E7.

        .word $0101, $0202, $0303, $0404, $0505, $0606, $0707, $0808
        .word $0808, $0808, $0808, $0808, $0808

        ; 9E/9504

    .endsection Table9E94EASection


    .section Table9E9504Section

      .al
      .xl

      aUnknown9E9504 ; 9E/9504

        ; Read by rlUnknown9E93E7.

        .word $0000, $0001, $0002

        ; 9E/950A

    .endsection Table9E9504Section


    .section Unsorted9E950ASection

      .al
      .xl

      rlUnknown9E950A ; 9E/950A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        stz wR1
        lda wBattleStatus
        and #$00FF
        bit #$0004
        beq _952B
        bit #$0002
        bne _952B
        ldx #$FFF0
        bit #$0008
        bne _9529
        ldx #$0010

        _9529
        stx wR1

        _952B
        plx
        rtl

        .databank 0

        ; 9E/952D

      rlUnknown9E952D ; 9E/952D

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        stz wR0
        lda #$7E00
        sta lR18+1
        lda #$4EF5
        sta lR18
        phx
        phy
        ldx #$0000

        _954A
        lda aUnknown9E964C,x
        cmp #$FFFF
        beq _955E
        tay
        lda [lR18],y
        ora wR0
        sta wR0
        inc x
        inc x
        bra _954A


        _955E
        lda #$9C00
        sta lR18+1
        lda #$FC00
        clc
        adc #$0100
        sta lR18
        ldy #$001E

        _956F
        lda [lR18],y
        sta aOAMPaletteBuffer,b,y
        dec y
        dec y
        bpl _956F
        ply
        plx
        lda wR0
        beq _95AA
        lda #<>rlUnknown9E95AB
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$7E00
        sta $7F45D1
        lda #$4EA9
        clc
        adc #$004C
        sta $7F45D0
        lda #$0000
        sta $7F45D3
        sta $7F45CE
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _95AA
        rtl

        .databank 0

        ; 9E/95AB

      rlUnknown9E95AB ; 9E/95AB

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F45CE
        bne _95F1
        lda $7F45D1
        sta lR18+1
        lda $7F45D0
        sta lR18
        lda $7F45D3
        asl a
        tax
        lda aUnknown9E964C,x
        tay
        lda [lR18],y
        beq _961D
        sta $7F45D7
        jsl rlUnknown9E965E
        jsl rlUnknown9EB4AF
        lda #$0008
        sta $7F45CE
        lda #$0000
        sta $7F45D5

        _95F1
        jsl rlUnknown9E96C0
        jsl rlUnknown9E978D
        jsl rlUnknown9E97F3
        lda $7F45CE
        cmp #$0023
        beq _960D
        inc a
        sta $7F45CE
        bra _9649


        _960D
        lda $7F45D5
        cmp #$000C
        beq _961D
        inc a
        sta $7F45D5
        bra _9649


        _961D
        lda #$0000
        sta $7F45CE
        lda $7F45D3
        inc a
        sta $7F45D3
        asl a
        tax
        lda aUnknown9E964C,x
        cmp #$FFFF
        bne _9649
        plx
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        phx

        _9649
        plx
        ply
        rtl

        .databank 0

        ; 9E/964C

    .endsection Unsorted9E950ASection


    .section Table9E964CSection

      .al
      .xl

      aUnknown9E964C ; 9E/964C

        ; Read by rlUnknown9E952D, rlUnknown9E95AB.

        .word $0010, $0012, $0014, $0016, $0018, $001E, $001A, $001C
        .word $FFFF

        ; 9E/965E

    .endsection Table9E964CSection


    .section Unsorted9E965ESection

      .al
      .xl

      rlUnknown9E965E ; 9E/965E

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F45D3
        xba
        lsr a
        lsr a
        sta wR2
        lsr a
        clc
        adc wR2
        sta wR2
        lda #$9C00
        sta lR18+1
        lda #$F000
        lda #$F600
        clc
        adc wR2
        sta lR18
        lda #$0060
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        sta wR1
        jsl rlDMAByPointer
        lda #$9C00
        sta lR18+1
        lda #$F000
        clc
        adc #$0400
        sta lR18
        lda #$0160
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        rtl

        .databank 0

        ; 9E/96C0

      rlUnknown9E96C0 ; 9E/96C0

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        phx
        lda $7F45CE
        asl a
        tax
        lda $7F4578
        clc
        adc #$FFF0
        sta wR0
        jsl rlUnknown9E950A
        lda $7F457A
        clc
        adc wR1
        adc aUnknown9E973D,x
        sta wR1
        stz wR4
        stz wR5
        stz wR6
        stz wR14
        stz wR13
        lda #$0003
        sta $7E52F0
        ldx #$0000

        _96F8
        lda wR14
        sta $7E52F2,x
        clc
        adc #$0008
        sta wR14
        sep #$20
        lda #$00
        sta $7E52F4,x
        rep #$20
        phx
        lda wR13
        asl a
        tax
        lda aUnknown9E9787,x
        ora #$2000
        plx
        sta $7E52F5,x
        inc wR13
        txa
        clc
        adc #$0005
        tax
        cpx #$000F
        bne _96F8
        pea #$7E00
        plb
        .databank ?
        plb
        .databank ?
        ldy #$52F0
        jsl rlPushToOAMBuffer
        clc
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/973D

    .endsection Unsorted9E965ESection


    .section Table9E973DSection

      .al
      .xl

      aUnknown9E973D ; 9E/973D

        ; Read by rlUnknown9E96C0, rlUnknown9E978D, rlUnknown9E97F3.

        .word $FFEC, $FFEC, $FFEC, $FFEC, $FFEC, $FFEC, $FFEC, $FFEC
        .word $FFEC, $FFEC, $FFEC, $FFEC, $FFE9, $FFE9, $FFE4, $FFE4
        .word $FFDF, $FFDF, $FFDC, $FFDC, $FFDF, $FFDF, $FFE4, $FFE4
        .word $FFE9, $FFE9, $FFEC, $FFEC, $FFEB, $FFEC, $FFEB, $FFEC
        .word $FFEB, $FFEC, $FFEB, $FFEC, $8000

        ; 9E/9787

    .endsection Table9E973DSection


    .section Table9E9787Section

      .al
      .xl

      aUnknown9E9787 ; 9E/9787

        ; Read by rlUnknown9E96C0.

        .word $0000, $0001, $0002

        ; 9E/978D

    .endsection Table9E9787Section


    .section Unsorted9E978DSection

      .al
      .xl

      rlUnknown9E978D ; 9E/978D

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        phx
        lda $7F4578
        clc
        adc #$0004
        sta wR0
        lda $7F45CE
        sec
        sbc #$0004
        cmp #$0008
        bcc _97EF
        asl a
        tax
        jsl rlUnknown9E950A
        lda $7F457A
        clc
        adc wR1
        adc aUnknown9E973D,x
        sta wR1
        stz wR4
        stz wR5
        stz wR6
        lda #$0001
        sta $7E52F0
        lda #$0000
        sta $7E52F2
        sep #$20
        lda #$00
        sta $7E52F4
        rep #$20
        lda #$001A
        ora #$2000
        sta $7E52F5
        pea #$7E00
        plb
        .databank ?
        plb
        .databank ?
        ldy #$52F0
        jsl rlPushToOAMBuffer
        clc

        _97EF
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/97F3

      rlUnknown9E97F3 ; 9E/97F3

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phy
        phx
        lda $7F4578
        clc
        adc #$000C
        sta wR0
        lda $7F45CE
        sec
        sbc #$0008
        cmp #$0008
        bcc _985A
        asl a
        tax
        jsl rlUnknown9E950A
        lda $7F457A
        clc
        adc wR1
        adc aUnknown9E973D,x
        sta wR1
        stz wR4
        stz wR5
        stz wR6
        lda #$0001
        sta $7E52F0
        lda #$0000
        sta $7E52F2
        sep #$20
        lda #$00
        sta $7E52F4
        rep #$20
        lda #$0010
        clc
        adc $7F45D7
        ora #$2000
        sta $7E52F5
        pea #$7E00
        plb
        .databank ?
        plb
        .databank ?
        ldy #$52F0
        jsl rlPushToOAMBuffer
        clc

        _985A
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/985E

      rlUnknown9E985E ; 9E/985E

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7E4ED1
        cmp #$FFFF
        beq _98AD
        sep #$20
        stz wBufferBG3HOFS,b
        rep #$20
        phx
        jsl rlGetItemNamePointerByItemID
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        lda #$9E00
        sta lR19+1
        lda #$98B0
        sta lR19
        lda #$0D05
        ldx #$0416
        ldy #$0000
        jsl rlUnknown85B7D1
        jsl rlUnknown85DB63
        plx
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _98AD
        plx
        ply
        rtl

        .databank 0

        ; 9E/98B0

    .endsection Unsorted9E978DSection


    .section Unsorted9E98C4Section

      .al
      .xl

      rlUnknown9E98C4 ; 9E/98C4

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda aActionStructUnit1.WeaponInventorySlot
        bpl _990D
        phx
        lda aActionStructUnit1.WeaponID
        jsl rlGetItemNamePointerByItemID
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        lda #$9E00
        sta lR19+1
        lda #$9910
        sta lR19
        lda #$0D05
        ldx #$0416
        ldy #$0000
        jsl rlUnknown85B7D1
        jsl rlUnknown85DB63
        plx
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _990D
        plx
        ply
        rtl

        .databank 0

        ; 9E/9910

    .endsection Unsorted9E98C4Section


    .section Unsorted9E9928Section

      .al
      .xl

      rlUnknown9E9928 ; 9E/9928

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$9E00
        sta lR19+1
        lda #$994F
        sta lR19
        lda $7E4ED3
        beq _994E
        jsl rlUnknown9E99A4
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _994E
        rtl

        .databank 0

        ; 9E/994F

    .endsection Unsorted9E9928Section


    .section Unsorted9E9967Section

      .al
      .xl

      rlUnknown9E9967 ; 9E/9967

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$9E00
        sta lR19+1
        lda #$998E
        sta lR19
        lda aActionStructUnit2.ObtainedStealMoney
        beq _998D
        jsl rlUnknown9E99A4
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _998D
        rtl

        .databank 0

        ; 9E/998E

    .endsection Unsorted9E9967Section


    .section Unsorted9E99A4Section

      .al
      .xl

      rlUnknown9E99A4 ; 9E/99A4

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        jsl rlSplitNumberIntoDigits
        ldy #$0008

        _99AD
        lda $0000,b,y
        bne _99BA
        dec a
        sta $0000,b,y
        dec y
        dec y
        bpl _99AD

        _99BA
        ldx #$0000
        ldy #$0008

        _99C0
        lda $0000,b,y
        clc
        adc #$824F
        xba
        sta $7F4BDB,x
        inc x
        inc x
        dec y
        dec y
        bpl _99C0
        lda #$0000
        sta $7F4BDB,x
        lda #$7F00
        sta lR18+1
        lda #$4BDB
        sta lR18
        lda #$0D05
        ldx #$0416
        ldy #$0000
        jsl rlUnknown85B7D1
        jsl rlUnknown85DB63
        plx
        ply
        rtl

        .databank 0

        ; 9E/99F7

    .endsection Unsorted9E99A4Section


    .section Unsorted9E99F7Section

      .al
      .xl

      rlUnknown9E99F7 ; 9E/99F7

        .al
        .autsiz
        .databank ?

        ; dma shadows?

        phy
        phx
        lda #(`$ADFF80)<<8
        sta lR18+1
        lda #<>$ADFF80
        sta lR18
        lda #$0040 ; size
        sta wR0

        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc #$00E0
        sta wR1
        jsl rlDMAByPointer

        lda lR18
        clc
        adc #$0040
        sta lR18
        lda wR1
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        rtl

        .databank 0

        ; 9E/9A34

    .endsection Unsorted9E99F7Section


    .section Unsorted9E9A34Section

      .al
      .xl

      rlUnknown9E9A34 ; 9E/9A34

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown9E9A43)<<8
        sta lR44+1
        lda #<>procUnknown9E9A43
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/9A43

    .endsection Unsorted9E9A34Section


    .section ProcScript9E9A43Section

      .al
      .xl

      procUnknown9E9A43 ; 9E/9A43

        .structProcInfo "ON", rlProcUnknown9E9A43Init, rlProcUnknown9E9A43Cycle1, aProcUnknown9E9A43Code

    .endsection ProcScript9E9A43Section


    .section Unsorted9E9A4BSection

      .al
      .xl

      rlProcUnknown9E9A43Init ; 9E/9A4B

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0000
        sta $4580,b
        sta $4582,b
        sta $4584,b
        sta @l $000FD7,x
        sta aMapAction.wUnknown7F455A
        sta $7F4572
        sta $7F4C87
        sta $4C11,b
        sta $4C13,b
        sta $7F4C07
        lda #$0001
        sta $7F4BEB
        lda $7E4EAF
        sta $454E,b
        lda wBattleDistance
        sta $4552,b
        lda wBattleQuotePointer
        sta $4554,b
        lda wDeathQuotePointer+1
        jsl rlGetItemDataROMPointer
        jsl rlGetItemWeaponType
        sta $454A,b
        lda #$0000
        sta $4550,b
        sta $4556,b
        sta $4558,b
        sta $454C,b
        lda #$0006
        sta $455E,b
        sta $4560,b
        lda #$003E
        sec
        sbc #$003E
        sta $5089,b
        lda wBattleSong
        asl a
        asl a
        tax
        plb
        .databank ?
        lda aMapAction.wYTilePosition
        clc
        adc aUnknown9E9B50+2,x
        tay
        lda aMapAction.wXTilePosition
        clc
        adc aUnknown9E9B50,x
        tax
        lda aActionStructUnit1.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda wR1
        jsl rlUnknown9EAC49
        lda $7F508F
        ora #$8000
        sta $7F508F
        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1
        lda wR1
        xba
        ora wR0
        sta $7F5099
        sta $7F509B
        lda $7E4EA9
        sta aActionStructUnit1
        lda $7E4EAF
        sta aActionStructUnit1.ClassID
        lda wDeathQuotePointer+1
        sta aActionStructUnit1.WeaponID
        lda #$8100
        sta @l $0015E5
        lda #$841B
        sta @l $0015E4
        plx
        lda @l $000302
        sta @l $0010B7,x
        stz wGameStateRoutine1,b
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        ply
        rtl

        .databank 0

        ; 9E/9B50

    .endsection Unsorted9E9A4BSection


    .section Table9E9B50Section

      .al
      .xl

      aUnknown9E9B50 ; 9E/9B50

        ; Read by rlProcUnknown9E9A43Init.

        .word $FFFF, $FFFF, $0000, $FFFF, $0001, $FFFF, $FFFF, $0000
        .word $0000, $0000, $0001, $0000

        ; 9E/9B68

    .endsection Table9E9B50Section


    .section Unsorted9E9B68Section

      .al
      .xl

      rlProcUnknown9E9A43Cycle4 ; 9E/9B68

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F4584
        beq _9B74
        lda #<>rlUnknown9E9B82
        sta aProcSystem.aHeaderOnCycle,b,x

        _9B74
        lda $7F4580
        beq _9B81
        lda #$0000
        sta $7F4580

        _9B81
        rtl

        .databank 0

        ; 9E/9B82

    .endsection Unsorted9E9B68Section


    .section Unsorted9E9B82Section

      .al
      .xl

      rlUnknown9E9B82 ; 9E/9B82

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F4584
        bne _9B97
        lda #<>rlUnknown9E9BAD
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _9B97
        lda $7F4580
        beq _9BAC
        lda #$0000
        sta $7F4580
        jsl rlUnknown9E9E61
        jsl rlUnknown9E9C70

        _9BAC
        rtl

        .databank 0

        ; 9E/9BAD

      rlUnknown9E9BAD ; 9E/9BAD

        .al
        .xl
        .autsiz
        .databank ?

        phx
        inc aProcSystem.aBody0,b,x
        lda aProcSystem.aBody0,b,x
        cmp #$0001
        beq _9BC8
        lda #$0000
        sta $7F4584
        lda #<>rlUnknown9E9BE0
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _9BDE


        _9BC8
        jsl rlUnknown9E8F6A
        lda #<>rlUnknown9E9BE0
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _9BDE
        plx
        rtl

        .databank 0

        ; 9E/9BE0

      rlUnknown9E9BE0 ; 9E/9BE0

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/9BE1

    .endsection Unsorted9E9B82Section


    .section ProcScript9E9BE1Section

      .al
      .xl

      aProcUnknown9E9A43Code ; 9E/9BE1

        PROC_YIELD 1
        PROC_CALL rlUnknown9F86B0
        PROC_JUMP_IF_BITS_UNSET aProcUnknown9E9A43Code, $0001
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown9E9A43Cycle2
        PROC_YIELD 16
        PROC_CALL rlUnknown9E99F7
        PROC_YIELD 4
        PROC_CALL rlUnknown9E9D3B
        PROC_YIELD 4
        PROC_CALL rlUnknown9E9D76
        PROC_YIELD 4
        PROC_CALL rlUnknown9E89F1
        PROC_YIELD 2
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlUnknown9EC9FD
        PROC_YIELD 8
        PROC_CALL rlUnknown9F85A3
        PROC_YIELD 4
        PROC_CALL rlUnknown9F85F5
        PROC_YIELD 2
        PROC_CALL rlUnknown9F861F
        PROC_YIELD 2
        _9C2F
        PROC_YIELD 8
        PROC_CALL rlUnknown9E9E10
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown9E9A43Cycle4
        _9C3C
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _9C3C, $0002
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _9C2F, $0001
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _9C54, $0004
        _9C54
        PROC_CALL rlUnknown9E9F66
        PROC_YIELD 2
        PROC_CALL rlUnknown9E9F26
        PROC_CALL rlUnknown888197
        PROC_YIELD 4
        PROC_CALL rlUnknown8881A7
        PROC_YIELD 1
        PROC_END


        ; 9E/9C70

    .endsection ProcScript9E9BE1Section


    .section Unsorted9E9C70Section

      .al
      .xl

      rlUnknown9E9C70 ; 9E/9C70

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda wBattleSong
        cmp #$0006
        bcs _9C93
        jsl rlUnknown9F9217
        sta $7F57EE
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _9C93
        rtl

        .databank 0

        ; 9E/9C94

    .endsection Unsorted9E9C70Section


    .section Unsorted9E9CB9Section

      .al
      .xl

      rlProcUnknown9E9A43Cycle1 ; 9E/9CB9

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda @l aMapAction.wUnknown7F455E
        asl a
        clc
        adc @l aMapAction.wUnknown7F455E
        asl a
        sta wR0
        lda @l aMapAction.wBattleClassID
        sta wR10
        lda #$0031
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        clc
        adc wR0
        adc #$0003
        tax
        lda $9EB50E,x
        sta lR18+1
        lda aBattleMapSpriteData,x
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$0000
        sta lR19
        plp
        plb
        .databank $7F
        jsl rlAppendDecompList
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda #(`gcUnknownACCC17)<<8
        sta lR18+1
        lda #<>gcUnknownACCC17
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$4000
        sta lR19
        plp
        plb
        .databank $7F
        jsl rlAppendDecompList
        ply
        plx
        lda #<>rlUnknown9E9BE0
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/9D3B

    .endsection Unsorted9E9CB9Section


    .section Unsorted9E9D3BSection

      .al
      .xl

      rlUnknown9E9D3B ; 9E/9D3B

        .al
        .autsiz
        .databank ?

        phx
        lda #(`gcUnknownD676F6)<<8
        sta lR18+1
        lda #<>gcUnknownD676F6
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$2000
        sta lR19
        jsl rlAppendDecompList

        lda #(`gcUnknownD677E9)<<8
        sta lR18+1
        lda #<>gcUnknownD677E9
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$3000
        sta lR19
        jsl rlAppendDecompList
        plx
        rtl

        .databank 0

        ; 9E/9D76

    .endsection Unsorted9E9D3BSection


    .section Unsorted9E9D76Section

      .al
      .xl

      rlUnknown9E9D76 ; 9E/9D76

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$2000
        sta lR18
        lda #$0400
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc #$0600
        sta wR1
        jsl rlDMAByPointer
        ldx #$0000
        ldy #$01C0

        _9DA6
        lda aUnknown9E9DB9,x
        sta aBGPaletteBuffer,b,y
        inc y
        inc y
        inc x
        inc x
        cpx #$0020
        bne _9DA6
        plx
        ply
        rtl

        .databank 0

        ; 9E/9DB9

    .endsection Unsorted9E9D76Section


    .section Table9E9DB9Section

      .al
      .xl

      aUnknown9E9DB9 ; 9E/9DB9

        ; Read by rlUnknown9E9D76.

        .word $3800, $7FFF, $035F, $01BF, $0037, $0C8A, $0425, $7FBA
        .word $7E6E, $7C84, $30C4, $1421, $0000, $0000, $0000, $0000

        ; 9E/9DD9

    .endsection Table9E9DB9Section


    .section Unsorted9E9DD9Section

      .al
      .xl

      rlProcUnknown9E9A43Cycle2 ; 9E/9DD9

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta $7F4580
        sta $7F4582
        sta $7F4584
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$FFFF
        sta $7F45A4
        sta $7F45A6
        jsl rlUnknown9E88CE
        jsl rlUnknown9E87A4
        lda #$0000
        jsl rlUnknown9E8867
        plx
        ply
        lda #<>rlUnknown9E9BE0
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/9E10

      rlUnknown9E9E10 ; 9E/9E10

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        phy
        phx
        lda #$0000
        sta $4580,b
        sta $4582,b
        sta $4584,b
        sta @l $000F37,x
        lda #$0001
        sta $4584,b
        lda $4599,b
        sta $458A,b
        sta $4587,b
        lda $4598,b
        sta @l lR18
        lda $4599,b
        sta @l lR18+1
        lda $455E,b
        sta @l wR0
        lda #$0000
        jsr rsUnknown9E832C
        stx $4589,b
        sty $4586,b
        plx
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/9E61

    .endsection Unsorted9E9DD9Section


    .section Unsorted9E9E61Section

      .al
      .xl

      rlUnknown9E9E61 ; 9E/9E61

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$7E00
        sta $7F459C
        sta lR18+1
        lda #$8B88
        clc
        adc #$3000
        sta $7F459B
        sta lR18
        ldy #$0002
        lda [lR18],y
        clc
        adc lR18
        sta $7EFC98
        lda aMapAction.wYTilePosition
        tay
        lda aMapAction.wXTilePosition
        tax
        lda aActionStructUnit1.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda #$7E00
        sta lR44+1
        lda #$FC94
        sta lR44
        lda #$FC94
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F45A8
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0040
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/9ECF

    .endsection Unsorted9E9E61Section


    .section Unsorted9E9F26Section

      .al
      .xl

      rlUnknown9E9F26 ; 9E/9F26

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F45A4
        tax
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x
        lda $7F45A6
        tax
        cpx #$FFFF
        beq _9F42
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x

        _9F42
        lda #$0001
        sta $7F4584
        lda aActionStructUnit1
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive
        plx
        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        lda #(`rlPushToOAMBuffer)<<8
        sta $15E5,b
        lda #<>rlPushToOAMBuffer
        sta $15E4,b
        rtl

        .databank 0

        ; 9E/9F66

      rlUnknown9E9F66 ; 9E/9F66

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown888410
        plx
        jsl rlUnknown9EB345
        rtl

        .databank 0

        ; 9E/9F71

      rlUnknown9E9F71 ; 9E/9F71

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        stx wR0
        lda #$FFFF
        sta $7F4C31
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4C2F
        bit #$0010
        beq _9FD1
        and #$0001
        and #$0001
        eor #$0001
        sta $7F4C31
        asl a
        asl a
        tax
        lda $7F45A4,x
        sta $7F4C37
        lda $7F45A6,x
        sta $7F4C39
        ldx wR0
        lda #<>rlProcUnknown9EC70BCycle8
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$0000
        sta $7F4C33
        sta $7F4C35
        jsl rlUnknown9EB0BA

        _9FD1
        plx
        ply
        rtl

        .databank 0

        ; 9E/9FD4

      rlProcUnknown9EC70BCycle8 ; 9E/9FD4

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F4C35
        beq _9FE0
        jml _A079


        _9FE0
        lda $7F4C33
        tax
        lda aUnknown9EA085,x
        and #$00FF
        cmp #$00FF
        beq _A033
        sta $7F4C35
        lda $7F4C33
        inc a
        sta $7F4C33
        lda $7F4C37
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        eor #$1000
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda aActiveSpriteSystem.aUnknown001240,b,x
        eor #$1000
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda $7F4C39
        tax
        cpx #$FFFF
        beq _A082
        lda aActiveSpriteSystem.aUnknown001200,b,x
        eor #$1000
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda aActiveSpriteSystem.aUnknown001240,b,x
        eor #$1000
        sta aActiveSpriteSystem.aUnknown001240,b,x
        bra _A082


        _A033
        lda $7F4C37
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        ora #$1000
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda aActiveSpriteSystem.aUnknown001240,b,x
        ora #$1000
        sta aActiveSpriteSystem.aUnknown001240,b,x
        lda $7F4C39
        cmp #$FFFF
        beq _A066
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        ora #$1000
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda aActiveSpriteSystem.aUnknown001240,b,x
        ora #$1000
        sta aActiveSpriteSystem.aUnknown001240,b,x

        _A066
        plx
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        phx
        bra _A082


        _A079
        lda $7F4C35
        dec a
        sta $7F4C35

        _A082
        plx
        ply
        rtl

        .databank 0

        ; 9E/A085

    .endsection Unsorted9E9F26Section


    .section Table9EA085Section

      .al
      .xl

      aUnknown9EA085 ; 9E/A085

        ; Read by rlProcUnknown9EC70BCycle8.

        .byte $04, $04, $04, $04, $02, $02, $02, $02, $01, $01, $01, $01, $01, $01, $01, $01
        .byte $FF

        ; 9E/A096

    .endsection Table9EA085Section


    .section Unsorted9EA096Section

      .al
      .xl

      rlUnknown9EA096 ; 9E/A096

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda wBattleQuotePointer
        beq _A0B6
        sta lR18
        lda wBattleQuotePointer+1
        sta lR18+1
        jsl rlUnknown9EA106

        _A0B6
        plx
        ply
        rtl

        .databank 0

        ; 9E/A0B9

      rlUnknown9EA0B9 ; 9E/A0B9

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda aProcSystem.aBody5,b,x
        cmp #$FFFF
        bne _A0DD
        lda wDeathQuotePointer
        beq _A0DD
        jsl rlUnknown91AD7F
        jsl rlUnknown9EA106

        _A0DD
        plx
        ply
        rtl

        .databank 0

        ; 9E/A0E0

      rlUnknown9EA0E0 ; 9E/A0E0

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda aProcSystem.aBody5,b,x
        cmp #$FFFF
        bne _A103
        lda #$0000
        beq _A103
        sta lR18
        sta lR18+1
        jsl rlUnknown9EA106

        _A103
        plx
        ply
        rtl

        .databank 0

        ; 9E/A106

      rlUnknown9EA106 ; 9E/A106

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        jsl rlResetDialogueEngine
        jsl rlUnknown828648
        lda #$0001
        sta aDialogue.wTextSound,b
        plx
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        ply
        rtl

        .databank 0

        ; 9E/A122

      rlUnknown9EA122 ; 9E/A122

        .al
        .xl
        .autsiz
        .databank ?

        phb
        jsl rlUnknown8285E1
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/A129

      rlUnknown9EA129 ; 9E/A129

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda aDialogue.wStatus,b
        bne _A13D
        jsl rlDialogueFreeHDMA
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _A13D
        plx
        ply
        rtl

        .databank 0

        ; 9E/A140

      rlUnknown9EA140 ; 9E/A140

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aProcSystem.wInput0,b
        lda $7E4ECD
        sta aProcSystem.wInput1,b
        lda $7E4ECF
        sta aProcSystem.wInput3,b
        rtl

        .databank 0

        ; 9E/A155

      rlUnknown9EA155 ; 9E/A155

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`gcUnknownC00A2B)<<8
        sta lR18+1
        lda #<>gcUnknownC00A2B
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$4000
        sta lR19
        jsl rlAppendDecompList
        plx
        rtl

        .databank 0

        ; 9E/A174

      rlUnknown9EA174 ; 9E/A174

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$4000
        sta lR18
        lda #$0800
        sta wR0
        lda #$4000
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        rtl

        .databank 0

        ; 9E/A195

      rlUnknown9EA195 ; 9E/A195

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$4800
        sta lR18
        lda #$0800
        sta wR0
        lda #$4400
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        rtl

        .databank 0

        ; 9E/A1B6

      rlUnknown9EA1B6 ; 9E/A1B6

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$5000
        sta lR18
        lda #$0800
        sta wR0
        lda #$4800
        sta wR1
        jsl rlDMAByPointer
        plx
        ply
        rtl

        .databank 0

        ; 9E/A1D7

    .endsection Unsorted9EA096Section


    .section Unsorted9EA1D7Section

      .al
      .xl

      rlUnknown9EA1D7 ; 9E/A1D7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C11
        ora $7F4C13
        beq _A1F5
        lda $7F4C1F
        tax
        lda aProcSystem.aHeaderTypeOffset,b,x
        cmp #$A334
        bne _A1F5
        lda #$0000
        sta aProcSystem.aHeaderTypeOffset,b,x

        _A1F5
        ldy #$0000
        lda $7F45A4
        tax
        tya
        sta aActiveSpriteSystem.aTypeOffset,b,x
        lda $7F45A6
        cmp #$FFFF
        beq _A20F
        tax
        tya
        sta aActiveSpriteSystem.aTypeOffset,b,x

        _A20F
        lda $7F45A8
        tax
        tya
        sta aActiveSpriteSystem.aTypeOffset,b,x
        lda $7F45AA
        cmp #$FFFF
        beq _A226
        tax
        tya
        sta aActiveSpriteSystem.aTypeOffset,b,x

        _A226
        ldx #$001E

        _A229
        lda @l $001100,x
        bne _A235
        dec x
        dec x
        bpl _A229
        plx
        rtl


        _A235
        nop
        plx
        rtl

        .databank 0

        ; 9E/A238

    .endsection Unsorted9EA1D7Section


    .section Unsorted9EA238Section

      .al
      .xl

      rlUnknown9EA238 ; 9E/A238

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        lda wUnknown000D79,b
        and #$7FFF
        sta wUnknown000D79,b
        lda #$0000
        sta $7F4C0F
        lda #$FFFF
        sta $7F4BF3
        lda $7F459E
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        cmp #$FFFF
        bne _A26E
        lda $7F459E
        beq _A2C9

        _A26E
        cmp #$FEFF
        beq _A2A5
        cmp #$00FD
        beq _A2A5
        sta wR0
        and #$00FF
        cmp #$00FE
        bne _A2F6
        lda wR0
        and #$FF00
        xba
        cmp #$0002
        bne _A296
        lda #$0001
        sta $7F4C0F
        bra _A2A5


        _A296
        sec
        sbc #$0013
        bmi _A2A5
        cmp #$0005
        bcs _A2A5
        sta $7F4BF3

        _A2A5
        lda $7F459E
        inc a
        sta $7F459E
        lda #1,s
        tax
        lda @l $001057,x
        inc a
        sta @l $001057,x
        lda $7F459E
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        cmp #$FFFF
        bne _A2EC

        _A2C9
        pha
        lda #3,s
        tax
        pla
        sta aProcSystem.aBody5,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlUnknown9E8F6A
        lda wUnknown000D79,b
        ora #$8000
        sta wUnknown000D79,b
        bra _A2F6


        _A2EC
        cmp #$FEFF
        beq _A2A5
        cmp #$00FD
        beq _A2A5

        _A2F6
        plx
        rtl

        .databank 0

        ; 9E/A2F8

      rlUnknown9EA2F8 ; 9E/A2F8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C11
        ora $7F4C13
        beq _A332
        lda $7F4C1F
        cmp #$FFFF
        beq _A315
        tax
        lda aProcSystem.aHeaderTypeOffset,b,x
        cmp #$A334
        beq _A332

        _A315
        lda wBattleStatus
        and #$0001
        sta $7F4C2D
        lda #(`procUnknown9EA334)<<8
        sta lR44+1
        lda #<>procUnknown9EA334
        sta lR44
        jsl rlProcEngineCreateProc
        sta $7F4C1F

        _A332
        plx
        rtl

        .databank 0

        ; 9E/A334

    .endsection Unsorted9EA238Section


    .section ProcScript9EA334Section

      .al
      .xl

      procUnknown9EA334 ; 9E/A334

        .structProcInfo "ON", rlProcUnknown9EA334Init, rlProcUnknown9EA334Cycle, aProcUnknown9EA334Code

    .endsection ProcScript9EA334Section


    .section Unsorted9EA33CSection

      .al
      .xl

      rlProcUnknown9EA334Init ; 9E/A33C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7F4C17
        sta $7F4C19
        sta aProcSystem.aHeaderBitfield,b,x
        lda wBattleDistance
        sta $7F4C21
        rtl

        .databank 0

        ; 9E/A353

      rlProcUnknown9EA334Cycle ; 9E/A353

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C1B
        beq _A38A
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        phx
        lda $7F4C2D
        asl a
        asl a
        tax
        lda $7F4578,x
        tax
        jsl rlUnknown9EB4BB
        ora #$0046
        jsl rlPlaySoundEffect2
        plx
        jsl rlUnknown9EA417
        lda #$A38C
        sta aProcSystem.aHeaderOnCycle,b,x
        jsl rlUnknown9EA67C

        _A38A
        plx
        rtl

        .databank 0

        ; 9E/A38C

    .endsection Unsorted9EA33CSection


    .section ProcScript9EA404Section

      .al
      .xl

      aProcUnknown9EA334Code ; 9E/A404

        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET aProcUnknown9EA334Code, $0004
        PROC_YIELD 40
        PROC_CALL rlUnknown9EA712
        PROC_YIELD 3
        PROC_END


        ; 9E/A417

    .endsection ProcScript9EA404Section


    .section Unsorted9EA417Section

      .al
      .xl

      rlUnknown9EA417 ; 9E/A417

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F4C2D
        asl a
        clc
        adc $7F4C2D
        tax
        lda $7F4598,x
        sta lR18
        lda $7F4599,x
        sta lR18+1
        lda #$7E00
        sta $7F4596
        ldy #$0014
        lda $7F4C2D
        asl a
        tax
        lda aMapAction.wUnknown7F455E,x
        lsr a
        bcc _A44A
        ldy #$0010

        _A44A
        lda [lR18],y
        clc
        adc lR18
        sta $7F4595
        lda #$0000
        sta $7F4C23
        sta $7F4C27
        lda $7F4C2D
        asl a
        asl a
        sta $7F57EA
        eor #$0004
        sta $7F57EC
        lda $7F4C2D
        asl a
        tax
        lda aMapAction.wUnknown7F455E,x
        asl a
        tay
        lda $7F57EA
        tax
        lda $7F4578,x
        tyx
        clc
        adc aUnknown9EA513,x
        sta $7F4C25
        sta wR0
        lda $7F57EA
        tax
        lda $7F457A,x
        sec
        sbc #$000C
        sta $7F4C29
        sta wR1
        lda $7F4C2D
        bne _A4C0
        lda #$7E00
        sta lR44+1
        lda #$FC8E
        sta lR44
        lda $7F4595
        sta $7EFC92
        lda #$FC8E
        bra _A4D5


        _A4C0
        lda #$7E00
        sta lR44+1
        lda #$FC9A
        sta lR44
        lda $7F4595
        sta $7EFC9E
        lda #$FC9A

        _A4D5
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldy aActiveSpriteSystem.wOffset,b
        lda $7F57EA
        tax
        tya
        sta $7F45A6,x
        txa
        lsr a
        sta wR0,b
        tax
        lda aUnknown9EA50F,x
        tyx
        sta aActiveSpriteSystem.aUnknown001260,b,x
        phx
        ldx wR0,b
        lda aMapAction.wUnknown7F4562,x
        plx
        inc a
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda $7F4C2D
        sta aActiveSpriteSystem.aUnknown001320,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/A50F

    .endsection Unsorted9EA417Section


    .section Table9EA50FSection

      .al
      .xl

      aUnknown9EA50F ; 9E/A50F

        ; Read by rlUnknown9EA417.

        .word $0020, $0040

        ; 9E/A513

    .endsection Table9EA50FSection


    .section Unsorted9EA67CSection

      .al
      .xl

      rlUnknown9EA67C ; 9E/A67C

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta wR0
        lda $7F4C2D
        asl a
        asl a
        sta wR14,b
        eor #$0004
        sta wR15,b
        ldx wR15,b
        lda $7F4578,x
        sec
        sbc $7F4C25
        bpl _A6A9
        dec a
        eor #$FFFF
        ldy #$0001
        sty wR0

        _A6A9
        xba
        sta wR13
        lda #$0010
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda $7F4C2D
        asl a
        asl a
        tax
        lda $7F45A6,x
        tax
        lda wR13
        ldy wR0
        beq _A6CB
        eor #$FFFF
        inc a

        _A6CB
        sta aActiveSpriteSystem.aUnknown0013C0,b,x
        lda #$0000
        sta wR0
        ldx wR15,b
        lda $7F457A,x
        sec
        sbc $7F4C29
        bpl _A6EA
        dec a
        eor #$FFFF
        ldy #$0001
        sty wR0

        _A6EA
        xba
        sta wR13
        lda #$0010
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda $7F4C2D
        asl a
        asl a
        tax
        lda $7F45A6,x
        tax
        lda wR13
        ldy wR0
        beq _A70C
        eor #$FFFF
        inc a

        _A70C
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/A712

      rlUnknown9EA712 ; 9E/A712

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta $7F4C1D
        rtl

        .databank 0

        ; 9E/A71A

      rlUnknown9EA71A ; 9E/A71A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wR0
        clc
        adc wR2
        sec
        sbc #$0100
        bmi _A72C
        lsr a
        cmp wMapMinXScroll,b
        bcs _A731

        _A72C
        lda wMapMinXScroll,b
        bra _A739


        _A731
        cmp wMapMaxXScroll,b
        bcc _A739
        lda wMapMaxXScroll,b

        _A739
        sta wR4
        lda wR1
        clc
        adc wR3
        sec
        sbc #$00E0
        bmi _A74C
        lsr a
        cmp wMapMinYScroll,b
        bcs _A751

        _A74C
        lda wMapMinYScroll,b
        bra _A759


        _A751
        cmp wMapMaxYScroll,b
        bcc _A759
        lda wMapMaxYScroll,b

        _A759
        sta wR5
        plx
        rtl

        .databank 0

        ; 9E/A75D

      rlUnknown9EA75D ; 9E/A75D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wBattleType
        and #$00FF
        cmp #$0003
        bne _A76E
        jml _A804


        _A76E
        lda wMapScrollXPixels,b
        sta $7F4BF9
        lda wMapScrollYPixels,b
        sta $7F4BFB
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4C87
        bne _A804
        lda $7F4C11
        ora $7F4C13
        bne _A7A4
        lda $7F508F
        beq _A804
        jsl rlUnknown9EA850
        bcc _A804

        _A7A4
        lda aMapAction.wXTilePosition
        asl a
        asl a
        asl a
        asl a
        sta wR0
        lda aMapAction.wYTilePosition
        asl a
        asl a
        asl a
        asl a
        sta wR1
        lda aActionStructUnit2
        cmp #$FFFF
        bne _A7CB
        lda wR0
        sta wR2
        lda wR1
        sta wR3
        bra _A7DF


        _A7CB
        lda aMapAction.wUnknown7F4556
        asl a
        asl a
        asl a
        asl a
        sta wR2
        lda aMapAction.wUnknown7F4558
        asl a
        asl a
        asl a
        asl a
        sta wR3

        _A7DF
        jsl rlUnknown9EA71A
        lda wR4
        and #$FFF0
        sta $7F4BF5
        lda wR5
        and #$FFF0
        sta $7F4BF7
        jsl rlUnknown9EA806
        bcc _A804
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _A804
        plx
        rtl

        .databank 0

        ; 9E/A806

      rlUnknown9EA806 ; 9E/A806

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        sec
        sbc $7F4BF5
        bpl _A814
        eor #$FFFF
        inc a

        _A814
        cmp aUnknown9EA84A
        bcs _A848
        lda wMapScrollYPixels,b
        sec
        sbc $7F4BF7
        bpl _A828
        eor #$FFFF
        inc a

        _A828
        cmp aUnknown9EA84A+2
        bcs _A848
        lda wBattleDistance
        cmp aUnknown9EA84A+4
        bcs _A848
        lda wMapScrollXPixels,b
        sta $7F4BF5
        lda wMapScrollYPixels,b
        sta $7F4BF7
        clc
        rtl


        _A848
        sec
        rtl

        .databank 0

        ; 9E/A84A

    .endsection Unsorted9EA67CSection


    .section Table9EA84ASection

      .al
      .xl

      aUnknown9EA84A ; 9E/A84A

        ; Read by rlUnknown9EA806.

        .word $0030, $0030, $0008

        ; 9E/A850

    .endsection Table9EA84ASection


    .section Unsorted9EA850Section

      .al
      .xl

      rlUnknown9EA850 ; 9E/A850

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F508B
        tax
        lda aUnknown9EA873,x
        and #$00FF
        bne _A86D
        lda $7F508D
        tax
        lda aUnknown9EA873,x
        and #$00FF
        beq _A870

        _A86D
        sec
        plx
        rtl


        _A870
        clc
        plx
        rtl

        .databank 0

        ; 9E/A873

    .endsection Unsorted9EA850Section


    .section Table9EA873Section

      .al
      .xl

      aUnknown9EA873 ; 9E/A873

        ; Read by rlUnknown9EA850.

        .word $0101, $0101, $0101, $0101, $0101, $0101, $0101, $0101
        .word $0101, $0100, $0101, $0000, $0000, $0101, $0101, $0101
        .word $0101, $0100, $0100, $0101, $0000, $0000

        ; 9E/A89F

    .endsection Table9EA873Section


    .section Unsorted9EA89FSection

      .al
      .xl

      rlUnknown9EA89F ; 9E/A89F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown88C2BA
        bcc _A8B8
        plx
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        bra _A8B9


        _A8B8
        plx

        _A8B9
        rtl

        .databank 0

        ; 9E/A8BA

      rlUnknown9EA8BA ; 9E/A8BA

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4BEB
        bit #$0001
        bne _A8D5
        lda $7F4BED
        bra _A8D9


        _A8D5
        lda $7F4BEF

        _A8D9
        cmp #$FFFF
        beq _A924
        cmp #$FFFE
        beq _A91D
        lda $7F4BEB
        and #$0001
        sta $7F57EA
        jsr rsUnknown9EA925
        bcc _A91D
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        ldx #$FFFE
        lda $7F4BEB
        bit #$0001
        bne _A90F
        txa
        sta $7F4BED
        bra _A914


        _A90F
        txa
        sta $7F4BEF

        _A914
        lda #$0001
        sta $7F5091
        bra _A924


        _A91D
        lda #$FFFF
        sta $7F5091

        _A924
        rtl

        .databank 0

        ; 9E/A925

      rsUnknown9EA925 ; 9E/A925

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F459E
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        cmp #$FFFF
        beq _A962
        cmp #$FEFF
        beq _A962
        cmp #$7F00
        beq _A962
        and #$00FF
        cmp #$00FE
        beq _A962
        cmp #$00FD
        beq _A962
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        cmp $7F57EA
        bne _A962
        lda aBattleRoundsData._Entry[0],x
        and #$0040
        bne _A965

        _A962
        plx
        clc
        rts


        _A965
        lda $7E4F87,x
        cmp #$FFFF
        bne _A97F
        pha
        lda #3,s
        tax
        pla
        sta aProcSystem.aBody5,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _A97F
        lda $7F459E
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        sta $7F4C2F
        lda $7F459E
        inc a
        sta $7F459E
        lda #1,s
        tax
        lda @l $001057,x
        inc a
        sta @l $001057,x
        plx
        sec
        rts

        .databank 0

        ; 9E/A9A5

      rlUnknown9EA9A5 ; 9E/A9A5

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5093
        beq _A9B4
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _A9B4
        rtl

        .databank 0

        ; 9E/A9B5

      rlUnknown9EA9B5 ; 9E/A9B5

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta $7F4BE9
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4BF3
        cmp #$FFFF
        bne _A9D7
        jml _AA59


        _A9D7
        cmp #$0002
        bne _A9E3
        lda #$0001
        sta $7F4BE9

        _A9E3
        lda $7F459E
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        sta $7F57EA
        asl a
        asl a
        sta wR0
        tax
        lda $7F45A4,x
        tax
        lda #$0005
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        ldx wR0
        lda $7F45A6,x
        cmp #$FFFF
        beq _AA16
        tax
        lda #$0005
        sta aActiveSpriteSystem.aUnknown0012A0,b,x

        _AA16
        lda $7F4BF3
        and #$00FF
        xba
        lsr a
        lsr a
        lsr a
        tax
        ldy #$01A0

        _AA25
        lda aUnknown9EAA61,x
        sta aBGPaletteBuffer,b,y
        inc x
        inc x
        inc y
        inc y
        cpy #$01C0
        bne _AA25
        jsl rlUnknown96D659
        stz wR0
        lda #$9E00
        sta lR18+1
        lda #$AA5C
        sta lR18
        jsl rlBattleSceneStartPaletteEffect
        jsl rlUnknown9EB36C
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _AA59
        plx
        ply
        rtl

        .databank 0

        ; 9E/AA5C

    .endsection Unsorted9EA89FSection


    .section Table9EAA61Section

      .al
      .xl

      aUnknown9EAA61 ; 9E/AA61

        ; Read by rlUnknown9EA9B5.

        .word $5BF6, $53F2, $33EC, $03E0, $0280, $0180, $1104, $0080
        .word $1104, $0180, $0280, $03E0, $33EC, $53F2, $5BF6, $6BF8
        .word $7F77, $7EB2, $7DC9, $7C00, $4800, $3000, $2082, $1000
        .word $2082, $3000, $4800, $7C00, $7DC9, $7EB2, $7F77, $7F7A
        .word $52FF, $4E7F, $29BF, $1D1F, $001F, $0015, $000D, $0006
        .word $0009, $000D, $0015, $001F, $1D1F, $29BF, $4E7F, $62FF
        .word $5F9F, $3B1F, $1E9F, $021F, $015B, $00F3, $00CD, $0088
        .word $00CD, $00F3, $015B, $021F, $1E9F, $3B1F, $5F9F, $73DF
        .word $7E9A, $7DB8, $7974, $78F1, $588B, $2844, $1C83, $1403
        .word $1C83, $2844, $588B, $78F1, $7974, $7DB8, $7E9A, $7F1F
        .word $57FF, $3FFF, $27FF, $03FF, $02B9, $01CE, $00C6, $0084
        .word $00C6, $01CE, $02B9, $03FF, $27FF, $3FFF, $57FF, $63FF

        ; 9E/AB21

    .endsection Table9EAA61Section


    .section Unsorted9EAB21Section

      .al
      .xl

      rlUnknown9EAB21 ; 9E/AB21

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown9E9192
        sep #$20
        lda $7FFD9A
        ora #$80
        sta $7FFD9A
        rep #$20
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F459E
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        and #$00FF
        cmp #$00FE
        bne _AB5B
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _AB5B
        plx
        rtl

        .databank 0

        ; 9E/AB5D

      rlUnknown9EAB5D ; 9E/AB5D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F454A
        cmp #$0004
        bcs _AB71
        lda #$0000
        jsr rsUnknown9EABE9
        bcs _ABBA
        bra _AB87


        _AB71
        lda $7F508B
        tax
        lda aUnknown9EABBD,x
        and #$00FF
        bne _AB87
        lda #$0000
        jsr rsUnknown9EABE9
        bcs _ABBA

        _AB87
        lda aMapAction.wUnknown7F454C
        cmp #$0004
        bcs _AB9A
        lda #$0001
        jsr rsUnknown9EABE9
        bcs _ABBA
        bra _ABB0


        _AB9A
        lda $7F508D
        tax
        lda aUnknown9EABBD,x
        and #$00FF
        bne _ABB0
        lda #$0001
        jsr rsUnknown9EABE9
        bcs _ABBA

        _ABB0
        lda #$8000
        sta $7F508F
        sec
        plx
        rtl


        _ABBA
        clc
        plx
        rtl

        .databank 0

        ; 9E/ABBD

    .endsection Unsorted9EAB21Section


    .section Table9EABBDSection

      .al
      .xl

      aUnknown9EABBD ; 9E/ABBD

        ; Read by rlUnknown9EAB5D.

        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0101
        .word $0101, $0100, $0100, $0101, $0001, $0000

        ; 9E/ABE9

    .endsection Table9EABBDSection


    .section Unsorted9EABE9Section

      .al
      .xl

      rsUnknown9EABE9 ; 9E/ABE9

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR0
        ldx #$0000

        _ABEF
        lda aBattleRoundsData._Entry[0],x
        cmp #$FFFF
        beq _AC0B
        cpx #$0050
        beq _AC0B
        and #$0001
        cmp wR0
        beq _AC08
        inc x
        inc x
        bra _ABEF


        _AC08
        sec
        plx
        rts


        _AC0B
        clc
        plx
        rts

        .databank 0

        ; 9E/AC0E

      rlUnknown9EAC0E ; 9E/AC0E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        tax
        lda aDeploymentTable,x
        ora #$8000
        sta aDeploymentTable,x
        plx
        rtl

        .databank 0

        ; 9E/AC1D

      rlUnknown9EAC1D ; 9E/AC1D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aActionStructUnit1
        tax
        lda aDeploymentTable,x
        and #$7FFF
        sta aDeploymentTable,x
        lda wR15
        bne _AC47
        lda aActionStructUnit2
        cmp #$FFFF
        beq _AC47
        tax
        lda aDeploymentTable,x
        and #$7FFF
        sta aDeploymentTable,x

        _AC47
        plx
        rtl

        .databank 0

        ; 9E/AC49

    .endsection Unsorted9EABE9Section


    .section Unsorted9EAC49Section

      .al
      .xl

      rlUnknown9EAC49 ; 9E/AC49

        .al
        .xl
        .autsiz
        .databank ?

        and #$0080
        eor #$0080
        asl a
        asl a
        asl a
        ora #$0101
        sta $7F508F
        rtl

        .databank 0

        ; 9E/AC5A

    .endsection Unsorted9EAC49Section


    .section Unsorted9EAC5ASection

      .al
      .xl

      rlUnknown9EAC5A ; 9E/AC5A

        .al
        .autsiz
        .databank ?

        lda #(`procUnknown9EAC69)<<8
        sta lR44+1
        lda #<>procUnknown9EAC69
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/AC69


      procUnknown9EAC69 .structProcInfo "ON", rlProcUnknown9EAC69Init, rlProcUnknown9EAC69Cycle, aProcUnknown9EAC69Code ; 9E/AC69

      rlProcUnknown9EAC69Init ; 9E/AC71

        .al
        .autsiz
        .databank ?

        lda wGameStateRoutine1,b
        sta aProcSystem.aBody7,x

        stz wGameStateRoutine1,b
        stz aProcSystem.aHeaderBitfield,b,x

        lda aActionStructUnit1.XPosition
        tax
        lda aActionStructUnit1.YPosition
        tay
        lda aActionStructUnit1.UnitRAMPointer
        jsl rlUnknown9E8D25

        lda wR0
        and #$00FF
        sta $7F4578
        lda wR1
        and #$00FF
        sta $7F457A
        lda #0
        sta $7F4C05
        sta $7F4C07
        rtl

        .databank 0

      rlProcUnknown9EAC69Cycle ; 9E/ACAE

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

    .endsection Unsorted9EAC5ASection


    .section Unsorted9EACAFSection

      .al
      .xl

      aProcUnknown9EAC69Code ; 9E/ACAF

        PROC_YIELD 1
        PROC_SET_ONCYCLE $9ECA45

        PROC_YIELD 48
        PROC_CALL rlUnknown9EC91A

        PROC_JUMP_IF_BITS_UNSET _ACD1, $0002

            _ACC2
            PROC_YIELD 1
            PROC_CALL rlUnknown9EC944

            PROC_JUMP_IF_BITS_UNSET _ACC2, $0004

          PROC_YIELD 1
        _ACD1
        PROC_CALL rlUnknown9E9342
        PROC_JUMP_IF_BITS_UNSET _ACFC, $0002

          PROC_CALL rlUnknown9EB3F3
          PROC_JUMP_IF_BITS_UNSET _ACEE, $0004

            PROC_YIELD 16
            PROC_CALL $9EB4A9

        _ACEE
        PROC_YIELD 1
        PROC_SET_ONCYCLE $9E936B
        PROC_JUMP_IF_BITS_UNSET _ACEE, $0004

        PROC_YIELD 107

        _ACFC
        PROC_CALL rlUnknown9E952D

        PROC_JUMP_IF_BITS_UNSET _AD22, $0002
        PROC_CALL rlUnknown9EB3F3

        PROC_JUMP_IF_BITS_UNSET _AD14, $0004

          PROC_YIELD 16

        _AD14
        PROC_SET_ONCYCLE $9E95AB

        _AD18
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _AD18, $0004

        PROC_YIELD 8

        _AD22
        PROC_CALL rlUnknown9E9928

        PROC_JUMP_IF_BITS_UNSET _AD48, $0002

        PROC_CALL rlUnknown9EB3F3
        PROC_JUMP_IF_BITS_UNSET _AD3A, $0004

          PROC_YIELD 16

        _AD3A
        PROC_CALL rlUnknown9EB491
        PROC_YIELD 117
        PROC_CALL rlUnknown85DB91
        PROC_YIELD 8

        _AD48
        PROC_CALL rlUnknown9E985E

        PROC_JUMP_IF_BITS_UNSET _AD6E, $0002

        PROC_CALL rlUnknown9EB3F3

        PROC_JUMP_IF_BITS_UNSET _AD60, $0004

          PROC_YIELD 16

        _AD60
        PROC_CALL $9EB49D
        PROC_YIELD 117
        PROC_CALL rlUnknown85DB91
        PROC_YIELD 8

        _AD6E
        PROC_CALL rlUnknown9EB41C
        PROC_YIELD 16
        PROC_SET_ONCYCLE $9EAD7B
        PROC_HALT

        ; AD7B

    .endsection Unsorted9EACAFSection


    .section Unsorted9EAD7BSection

      .al
      .xl

      rlUnknown9EAD7B ; 9E/AD7B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$CE9E
        sta aProcSystem.aHeaderCodeOffset,b,x
        lda #$0001
        sta aProcSystem.aHeaderSleepTimer,b,x
        jsl rlUnknown888197
        lda wBattleType
        and #$00FF
        cmp #$0003
        beq _AD9E
        jsl rlUnknown85D648
        bra _ADA6


        _AD9E
        jsl rlUnknown8A8F68
        jsl rlUnknown9EAC1D

        _ADA6
        phb
        jsl rlUnknown8881A7
        plb
        .databank ?
        plx
        lda #$ADB4
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/ADB4

    .endsection Unsorted9EAD7BSection


    .section Unsorted9EADD1Section

      .al
      .xl

      rlUnknown9EADD1 ; 9E/ADD1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR0
        lda wBattleStatus
        and #$00FF
        bit #$0004
        beq _AE20
        and #$0002
        lsr a
        cmp wR0
        bne _AE20
        asl a
        asl a
        sta wR1
        ldx #$0010
        lda wBattleStatus
        and #$00FF
        bit #$0008
        beq _ADFE
        ldx #$FFF0

        _ADFE
        stx wR0
        ldx wR1
        lda $7F45A4,x
        tax
        lda aActiveSpriteSystem.aUnknown001240,b,x
        clc
        adc wR0
        sta aActiveSpriteSystem.aUnknown001240,b,x
        ldx wR1
        lda $7F45A6,x
        tax
        lda aActiveSpriteSystem.aUnknown001240,b,x
        clc
        adc wR0
        sta aActiveSpriteSystem.aUnknown001240,b,x

        _AE20
        plx
        rtl

        .databank 0

        ; 9E/AE22

      rlUnknown9EAE22 ; 9E/AE22

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda wBattleStatus
        and #$00FF
        bit #$0004
        beq _AE58
        and #$0002
        lsr a
        sta $7F57EA
        lda wBattleStatus
        and #$0008
        asl a
        sta $7F57EC
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _AE58
        plx
        rtl

        .databank 0

        ; 9E/AE5A

      rlUnknown9EAE5A ; 9E/AE5A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F57EC
        tax
        lda aUnknown9EAEAF,x
        sta wR0
        cmp #$8000
        beq _AEA1
        lda $7F57EA
        asl a
        asl a
        tax
        phx
        lda $7F45A4,x
        tax
        lda aActiveSpriteSystem.aUnknown001240,b,x
        sec
        sbc wR0
        sta aActiveSpriteSystem.aUnknown001240,b,x
        plx
        lda $7F45A6,x
        cmp #$FFFF
        beq _AE95
        tax
        lda aActiveSpriteSystem.aUnknown001240,b,x
        sec
        sbc wR0
        sta aActiveSpriteSystem.aUnknown001240,b,x

        _AE95
        lda $7F57EC
        inc a
        inc a
        sta $7F57EC
        bra _AEAD


        _AEA1
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _AEAD
        plx
        rtl

        .databank 0

        ; 9E/AEAF

    .endsection Unsorted9EADD1Section


    .section Table9EAEAFSection

      .al
      .xl

      aUnknown9EAEAF ; 9E/AEAF

        ; Read by rlUnknown9EAE5A.

        .word $0001, $0001, $0002, $0002, $0002, $0004, $0004, $8000
        .word $FFFF, $FFFF, $FFFE, $FFFE, $FFFE, $FFFC, $FFFC, $8000

        ; 9E/AECF

    .endsection Table9EAEAFSection


    .section Unsorted9EAECFSection

      .al
      .xl

      rlUnknown9EAECF ; 9E/AECF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F57EC
        tax
        lda aUnknown9EAF24,x
        sta wR0
        cmp #$8000
        beq _AF16
        lda $7F57EA
        asl a
        asl a
        tax
        phx
        lda $7F45A4,x
        tax
        lda aActiveSpriteSystem.aUnknown001240,b,x
        clc
        adc wR0
        sta aActiveSpriteSystem.aUnknown001240,b,x
        plx
        lda $7F45A6,x
        cmp #$FFFF
        beq _AF0A
        tax
        lda aActiveSpriteSystem.aUnknown001240,b,x
        clc
        adc wR0
        sta aActiveSpriteSystem.aUnknown001240,b,x

        _AF0A
        lda $7F57EC
        inc a
        inc a
        sta $7F57EC
        bra _AF22


        _AF16
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _AF22
        plx
        rtl

        .databank 0

        ; 9E/AF24

    .endsection Unsorted9EAECFSection


    .section Table9EAF24Section

      .al
      .xl

      aUnknown9EAF24 ; 9E/AF24

        ; Read by rlUnknown9EAECF.

        .word $0004, $0004, $0002, $0002, $0002, $0001, $0001, $8000
        .word $FFFC, $FFFC, $FFFE, $FFFE, $FFFE, $FFFF, $FFFF, $8000

        ; 9E/AF44

    .endsection Table9EAF24Section


    .section Unsorted9EAF44Section

      .al
      .xl

      rlUnknown9EAF44 ; 9E/AF44

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F5089
        cmp #$0020
        bne _AF77
        jsl rlUnknown9EB01B
        bcs _AF77
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        lda #(`procUnknown9EAF98)<<8
        sta lR44+1
        lda #<>procUnknown9EAF98
        sta lR44
        jsl rlProcEngineCreateProc

        _AF77
        plx
        rtl

        .databank 0

        ; 9E/AF79

      rlUnknown9EAF79 ; 9E/AF79

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`procUnknown9EAF98)<<8
        sta lR44+1
        lda #<>procUnknown9EAF98
        sta lR44
        jsl rlProcEngineFindProc
        bcs _AF96
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _AF96
        plx
        rtl

        .databank 0

        ; 9E/AF98

    .endsection Unsorted9EAF44Section


    .section ProcScript9EAF98Section

      .al
      .xl

      procUnknown9EAF98 ; 9E/AF98

        .structProcInfo "ON", rlProcUnknown9EAF98Init, rlProcUnknown9EAF98Cycle1, aProcUnknown9EAF98Code

    .endsection ProcScript9EAF98Section


    .section Unsorted9EAFA0Section

      .al
      .xl

      rlProcUnknown9EAF98Init ; 9E/AFA0

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0000
        sta $4580,b
        sta $4582,b
        sta $4584,b
        sta $5091,b
        sta $5093,b
        sta $4C11,b
        sta $4C13,b
        sta $7F4C07
        lda #$0029
        sta $5089,b
        plb
        .databank ?
        lda $7E4F77
        tax
        lda $7E4F79
        tay
        lda aActionStructUnit2.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1
        lda wR1
        xba
        ora wR0
        sta $7F509B
        plx
        ply
        rtl

        .databank 0

        ; 9E/AFF7

      rlProcUnknown9EAF98Cycle1 ; 9E/AFF7

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/AFF8

    .endsection Unsorted9EAFA0Section


    .section ProcScript9EAFF8Section

      .al
      .xl

      aProcUnknown9EAF98Code ; 9E/AFF8

        PROC_CALL rlUnknown9EB08E
        PROC_YIELD 1
        PROC_CALL rlUnknown9F8020
        PROC_YIELD 1
        PROC_CALL rlUnknown9EB0B2
        PROC_SET_ONCYCLE rlProcUnknown9EAF98Cycle2
        _B00F
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _B00F, $0002
        PROC_YIELD 1
        PROC_END


        ; 9E/B01B

    .endsection ProcScript9EAFF8Section


    .section Unsorted9EB01BSection

      .al
      .xl

      rlUnknown9EB01B ; 9E/B01B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7E4F77
        sta wR0
        lda $7E4F79
        sta wR1
        lda wBattleType
        and #$00FF
        cmp #$0003
        beq _B03A
        jsl rlUnknown9EB046
        bra _B044


        _B03A
        lda aActionStructUnit2.UnitRAMPointer
        sta wR2
        jsl rlUnknown9EB06C

        _B044
        plx
        rtl

        .databank 0

        ; 9E/B046

      rlUnknown9EB046 ; 9E/B046

        .al
        .xl
        .autsiz
        .databank ?

        lda wR0
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        bmi _B06A
        cmp #$0100
        bcs _B06A
        lda wR1
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        bmi _B06A
        cmp #$00E0
        bcs _B06A
        clc
        rtl


        _B06A
        sec
        rtl

        .databank 0

        ; 9E/B06C

      rlUnknown9EB06C ; 9E/B06C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown87EA09
        jsl rlGetEventLocationEntryID
        sta $7F57EA
        lda wR2
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitHomeCastle
        cmp $7F57EA
        beq _B08B
        sec
        plx
        rtl


        _B08B
        clc
        plx
        rtl

        .databank 0

        ; 9E/B08E

      rlUnknown9EB08E ; 9E/B08E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F45A8
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        ora #$8000
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F45AA
        cmp #$FFFF
        beq _B0B0
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        ora #$8000
        sta aActiveSpriteSystem.aUnknown001200,b,x

        _B0B0
        plx
        rtl

        .databank 0

        ; 9E/B0B2

      rlUnknown9EB0B2 ; 9E/B0B2

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta $7F5091
        rtl

        .databank 0

        ; 9E/B0BA

      rlUnknown9EB0BA ; 9E/B0BA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C31
        asl a
        asl a
        tax
        lda $7F45A4,x
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        pha
        lda $7F4C31
        jsl rlUnknown9EB0F2
        asl a
        tax
        lda aUnknown9EB0EC,x
        sta wR0
        jsl rlUnknown9EB12B
        pla
        jsl rlUnknown9EB4BB
        ora wR0
        jsl rlPlaySoundEffect2
        plx
        rtl

        .databank 0

        ; 9E/B0EC

    .endsection Unsorted9EB01BSection


    .section Table9EB0ECSection

      .al
      .xl

      aUnknown9EB0EC ; 9E/B0EC

        ; Read by rlUnknown9EB0BA.

        .word $0021, $0022, $0023

        ; 9E/B0F2

    .endsection Table9EB0ECSection


    .section Unsorted9EB0F2Section

      .al
      .xl

      rlUnknown9EB0F2 ; 9E/B0F2

        .al
        .xl
        .autsiz
        .databank ?

        bne _B10C
        lda aActionStructUnit1
        tax
        lda aDeploymentTable,x
        and #$0003
        cmp #$0001
        beq _B120
        lda aActionStructUnit1.Gender
        inc a
        bra _B12A


        _B10C
        lda wBattleSong
        cmp #$003E
        bne _B120
        lda aActionStructUnit2.CharacterID
        cmp #$003F
        beq _B125
        bcc _B125

        _B120
        lda #$0000
        bra _B12A


        _B125
        lda aActionStructUnit2.Gender
        inc a

        _B12A
        rtl

        .databank 0

        ; 9E/B12B

      rlUnknown9EB12B ; 9E/B12B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C31
        bne _B141
        lda aActionStructUnit1.ClassID
        cmp #$0042
        bne _B158
        lda aActionStructUnit1.Gender
        bra _B14E


        _B141
        lda aActionStructUnit2.ClassID
        cmp #$0042
        bne _B158
        lda aActionStructUnit2.Gender

        _B14E
        inc a
        asl a
        tax
        lda aUnknown9EB15A,x
        sta wR0,b

        _B158
        plx
        rtl

        .databank 0

        ; 9E/B15A

    .endsection Unsorted9EB0F2Section


    .section Table9EB15ASection

      .al
      .xl

      aUnknown9EB15A ; 9E/B15A

        ; Read by rlUnknown9EB12B.

        .word $0024, $0024, $0025

        ; 9E/B160

    .endsection Table9EB15ASection


    .section Unsorted9EB160Section

      .al
      .xl

      rlUnknown9EB160 ; 9E/B160

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda @l $001057,x
        dec a
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        sta wR1
        and #$0010
        beq _B17B
        lda #$0094
        sta wR0
        bra _B1C8


        _B17B
        lda $7F5089
        cmp #$FFFF
        beq _B19B
        lda #1,s
        tax
        lda @l $001057,x
        dec a
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        bit #$0002
        beq _B1BC
        jml _B211


        _B19B
        lda wR1
        and #$0020
        beq _B1A9
        lda #$0093
        sta wR0
        bra _B1C8


        _B1A9
        lda wR1
        and #$0001
        and #$0001
        asl a
        tax
        lda $7F454A,x
        and #$0001
        bne _B1C3

        _B1BC
        lda #$0091
        sta wR0
        bra _B1C8


        _B1C3
        lda #$0093
        sta wR0

        _B1C8
        lda $7F45A8
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay
        lda $7F57EA
        bne _B1E0
        lda $7F45A4
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay

        _B1E0
        tya
        sta $7F57EA
        jsl rlUnknown9EB4BB
        ora wR0
        jsl rlPlaySoundEffect2
        lda #1,s
        tax
        lda @l $001057,x
        dec a
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        bit #$0004
        beq _B211
        lda $7F57EA
        jsl rlUnknown9EB4BB
        ora #$004E
        jsl rlPlaySoundEffect2

        _B211
        plx
        ply
        rtl

        .databank 0

        ; 9E/B214

      rlUnknown9EB214 ; 9E/B214

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F5089
        cmp #$FFFF
        bne _B249
        lda #$0095
        sta wR0
        lda $7F45A8
        tax
        lda @l $001200,x
        tay
        lda $7F57EA
        bne _B23E
        lda $7F45A4
        tax
        lda @l $001200,x
        tay

        _B23E
        tya
        jsl rlUnknown9EB4BB
        ora wR0
        jsl rlPlaySoundEffect2

        _B249
        plx
        ply
        rtl

        .databank 0

        ; 9E/B24C

      rlUnknown9EB24C ; 9E/B24C

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F45A2
        cmp #$0023
        bne _B2AE
        lda #$FFFE
        sta $7F45A2
        lda $7F5089
        cmp #$FFFF
        bne _B2B7
        ldx #$0000
        lda $7F4BEB
        and #$0001
        bne _B276
        ldx #$0002

        _B276
        lda aMapAction.wBattleClassID,x
        cmp #$002C
        beq _B284
        cmp #$002E
        bne _B2B7

        _B284
        lda #$0097
        sta wR0
        bra _B28B


        _B28B
        lda $7F45A8
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay
        lda $7F57EA
        bne _B2A3
        lda $7F45A4
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay

        _B2A3
        tya
        jsl rlUnknown9EB4BB
        ora wR0
        jsl rlPlaySoundEffect2

        _B2AE
        lda $7F45A2
        inc a
        sta $7F45A2

        _B2B7
        plx
        ply
        rtl

        .databank 0

        ; 9E/B2BA

    .endsection Unsorted9EB160Section


    .section Unsorted9EB345Section

      .al
      .xl

      rlUnknown9EB345 ; 9E/B345

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0048
        sta wR0
        lda aActionStructUnit1.XPosition
        bne _B357
        lda #$0049
        sta wR0

        _B357
        lda $7F45A4
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        jsl rlUnknown9EB4BB
        ora wR0
        jsl rlPlaySoundEffect2
        plx
        ply
        rtl

        .databank 0

        ; 9E/B36C

      rlUnknown9EB36C ; 9E/B36C

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F45A8
        cmp #$FFFF
        beq _B382
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay
        lda $7F57EA
        bne _B390

        _B382
        lda $7F45A4
        cmp #$FFFF
        beq _B39C
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay

        _B390
        tya
        jsl rlUnknown9EB4BB
        ora #$003D
        jsl rlPlaySoundEffect2

        _B39C
        plx
        ply
        rtl

        .databank 0

        ; 9E/B39F

      rlUnknown9EB39F ; 9E/B39F

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F45A8
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay
        lda $7F57EA
        beq _B3B9
        lda $7F45A4
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay

        _B3B9
        tya
        jsl rlUnknown9EB4BB
        ora #$002E
        jsl rlPlaySoundEffect2
        plx
        ply
        rtl

        .databank 0

        ; 9E/B3C8

    .endsection Unsorted9EB345Section


    .section Unsorted9EB3DESection

      .al
      .xl

      rlUnknown9EB3DE ; 9E/B3DE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F5099
        and #$00FF
        jsl rlUnknown9EB4BB
        ora #$0032
        jsl rlPlaySoundEffect2
        plx
        rtl

        .databank 0

        ; 9E/B3F3

      rlUnknown9EB3F3 ; 9E/B3F3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4C05
        bne _B41A
        lda #$0001
        sta $7F4C05
        lda #$00F7
        jsl rlSendSoundCommand
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _B41A
        plx
        rtl

        .databank 0

        ; 9E/B41C

      rlUnknown9EB41C ; 9E/B41C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F4C05
        beq _B431
        lda #$0000
        sta $7F4C05
        lda #$00E8
        jsl rlSendSoundCommand

        _B431
        plx
        rtl

        .databank 0

        ; 9E/B433

    .endsection Unsorted9EB3DESection


    .section Unsorted9EB491Section

      .al
      .xl

      rlUnknown9EB491 ; 9E/B491

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0092
        bra $9EB4B5

        .byte $DA, $A9, $93, $00, $80, $18, $DA, $A9, $92, $00, $80, $12, $DA, $A9, $93, $00
        .byte $80, $0C

        phx
        lda #$0091
        bra $9EB4B5

        .databank 0

        ; 9E/B4AF

      rlUnknown9EB4AF ; 9E/B4AF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0023
        bra _B4B5


        _B4B5
        jsl rlPlaySoundEffect
        plx
        rtl

        .databank 0

        ; 9E/B4BB

    .endsection Unsorted9EB491Section


    .section Unsorted9EB4BBSection

      .al
      .xl

      rlUnknown9EB4BB ; 9E/B4BB

        .al
        .xl
        .autsiz
        .databank ?

        and #$00FF
        lsr a
        lsr a
        lsr a
        cmp #$0010
        bcs _B4C7
        inc a

        _B4C7
        xba
        rtl

        .databank 0

        ; 9E/B4C9

    .endsection Unsorted9EB4BBSection


    .section Table9EB4C9Section

      .al
      .xl

      aUnknown9EB4C9 ; 9E/B4C9

        ; Read by rlUnknown9E8D6C, rlUnknown9E8DBB, rsActiveSpriteCommand03.

        .word $0000, $2000

        ; 9E/B4CD

    .endsection Table9EB4C9Section


    .section Table9EB4CDSection

      .al
      .xl

      aUnknown9EB4CD ; 9E/B4CD

        ; Read by rlUnknown9E8D6C.

        .word $0000, $0000, $0000, $0400, $0600

        ; 9E/B4D7

    .endsection Table9EB4CDSection


    .section Table9EB4D7Section

      .al
      .xl

      aUnknown9EB4D7 ; 9E/B4D7

        ; Read by rlUnknown9E8DBB, rsActiveSpriteCommand03.

        .word $0200, $0280

        ; 9E/B4DB

    .endsection Table9EB4D7Section


    .section Table9EB4DBSection

      .al
      .xl

      aUnknown9EB4DB ; 9E/B4DB

        ; Read by rlUnknown9E8D6C, rlUnknown9E8E01.

        .word $0400, $0600

        ; 9E/B4DF

    .endsection Table9EB4DBSection


    .section BattleMapSpriteDataSection

      .al
      .xl

      aBattleMapSpriteData ; 9E/B50D

        ; Graphics for the units in map battles. Indexed by
        ; aMapAction.wBattleClassID * 49 + frame * 6. Each row has 8 frames,
        ; each a pair of long pointers to compressed graphics (the second is
        ; read at +3), then a byte whose meaning is unknown. The row names
        ; come from the original notes; some classes have more than one row.

        ; Cavalier
        .long aMapBattleCavalierLayout0, g4bppcMapBattleCavalier0, aMapBattleCavalierLayout1, g4bppcMapBattleCavalier1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleCavalier2, aMapBattleCavalierLayout3, g4bppcMapBattleCavalier3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleCavalier3, aMapBattleCavalierLayout5, g4bppcMapBattleCavalier5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleCavalier6, aMapBattleCavalierLayout7, g4bppcMapBattleCavalier0
        .byte 1
        ; LanceKnight
        .long aMapBattleLanceKnightLayout0, g4bppcMapBattleCavalier0, aMapBattleLanceKnightLayout1, g4bppcMapBattleCavalier1
        .long aMapBattleLanceKnightLayout2, g4bppcMapBattleCavalier2, aMapBattleLanceKnightLayout3, g4bppcMapBattleCavalier3
        .long aMapBattleLanceKnightLayout4, g4bppcMapBattleCavalier3, aMapBattleLanceKnightLayout5, g4bppcMapBattleCavalier5
        .long aMapBattleLanceKnightLayout6, g4bppcMapBattleCavalier6, aMapBattleLanceKnightLayout7, g4bppcMapBattleCavalier0
        .byte 1
        ; BowKnight
        .long aMapBattleCavalierLayout0, g4bppcMapBattleCavalier0, aMapBattleCavalierLayout1, g4bppcMapBattleCavalier1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleCavalier2, aMapBattleCavalierLayout3, g4bppcMapBattleCavalier3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleCavalier3, aMapBattleCavalierLayout5, g4bppcMapBattleCavalier5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleCavalier6, aMapBattleCavalierLayout7, g4bppcMapBattleCavalier0
        .byte 1
        ; AxeKnight
        .long aMapBattleLanceKnightLayout0, g4bppcMapBattleCavalier0, aMapBattleLanceKnightLayout1, g4bppcMapBattleCavalier1
        .long aMapBattleLanceKnightLayout2, g4bppcMapBattleCavalier2, aMapBattleLanceKnightLayout3, g4bppcMapBattleCavalier3
        .long aMapBattleLanceKnightLayout4, g4bppcMapBattleCavalier3, aMapBattleLanceKnightLayout5, g4bppcMapBattleCavalier5
        .long aMapBattleLanceKnightLayout6, g4bppcMapBattleCavalier6, aMapBattleLanceKnightLayout7, g4bppcMapBattleCavalier0
        .byte 1
        ; FreeKnight
        .long aMapBattleLanceKnightLayout0, g4bppcMapBattleCavalier0, aMapBattleLanceKnightLayout1, g4bppcMapBattleCavalier1
        .long aMapBattleLanceKnightLayout2, g4bppcMapBattleCavalier2, aMapBattleLanceKnightLayout3, g4bppcMapBattleCavalier3
        .long aMapBattleLanceKnightLayout4, g4bppcMapBattleCavalier3, aMapBattleLanceKnightLayout5, g4bppcMapBattleCavalier5
        .long aMapBattleLanceKnightLayout6, g4bppcMapBattleCavalier6, aMapBattleLanceKnightLayout7, g4bppcMapBattleCavalier0
        .byte 1
        ; Troubadour
        .long aMapBattleLanceKnightLayout0, g4bppcMapBattleTroubadour0, aMapBattleLanceKnightLayout1, g4bppcMapBattleTroubadour1
        .long aMapBattleLanceKnightLayout2, g4bppcMapBattleTroubadour2, aMapBattleLanceKnightLayout3, g4bppcMapBattleTroubadour3
        .long aMapBattleLanceKnightLayout4, g4bppcMapBattleTroubadour3, aMapBattleLanceKnightLayout5, g4bppcMapBattleTroubadour5
        .long aMapBattleLanceKnightLayout6, g4bppcMapBattleTroubadour6, aMapBattleLanceKnightLayout7, g4bppcMapBattleTroubadour0
        .byte 1
        ; KnightLord
        .long aMapBattleCavalierLayout0, g4bppcMapBattleKnightLord0, aMapBattleCavalierLayout1, g4bppcMapBattleKnightLord1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleKnightLord2, aMapBattleCavalierLayout3, g4bppcMapBattleKnightLord3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleKnightLord3, aMapBattleCavalierLayout5, g4bppcMapBattleKnightLord5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleKnightLord6, aMapBattleCavalierLayout7, g4bppcMapBattleKnightLord0
        .byte 1
        ; DukeKnight
        .long aMapBattleCavalierLayout0, g4bppcMapBattleDukeKnight0, aMapBattleCavalierLayout1, g4bppcMapBattleDukeKnight1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleDukeKnight2, aMapBattleCavalierLayout3, g4bppcMapBattleDukeKnight3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleDukeKnight3, aMapBattleCavalierLayout5, g4bppcMapBattleDukeKnight5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleDukeKnight6, aMapBattleCavalierLayout7, g4bppcMapBattleDukeKnight0
        .byte 1
        ; MasterKnight
        .long aMapBattleCavalierLayout0, g4bppcMapBattleMasterKnight0, aMapBattleCavalierLayout1, g4bppcMapBattleMasterKnight1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleMasterKnight2, aMapBattleCavalierLayout3, g4bppcMapBattleMasterKnight3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleMasterKnight3, aMapBattleCavalierLayout5, g4bppcMapBattleMasterKnight5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleMasterKnight6, aMapBattleCavalierLayout7, g4bppcMapBattleMasterKnight0
        .byte 1
        ; Paladin
        .long aMapBattleCavalierLayout0, g4bppcMapBattlePaladin0, aMapBattleCavalierLayout1, g4bppcMapBattlePaladin1
        .long aMapBattleCavalierLayout2, g4bppcMapBattlePaladin2, aMapBattleCavalierLayout3, g4bppcMapBattlePaladin3
        .long aMapBattleCavalierLayout4, g4bppcMapBattlePaladin3, aMapBattleCavalierLayout5, g4bppcMapBattlePaladin5
        .long aMapBattleCavalierLayout6, g4bppcMapBattlePaladin6, aMapBattleCavalierLayout7, g4bppcMapBattlePaladin0
        .byte 1
        ; PaladinF
        .long aMapBattleCavalierLayout0, g4bppcMapBattlePaladinF0, aMapBattleCavalierLayout1, g4bppcMapBattlePaladinF1
        .long aMapBattleCavalierLayout2, g4bppcMapBattlePaladinF2, aMapBattleCavalierLayout3, g4bppcMapBattlePaladinF3
        .long aMapBattleCavalierLayout4, g4bppcMapBattlePaladinF3, aMapBattleCavalierLayout5, g4bppcMapBattlePaladinF5
        .long aMapBattleCavalierLayout6, g4bppcMapBattlePaladinF6, aMapBattleCavalierLayout7, g4bppcMapBattlePaladinF0
        .byte 1
        ; ArchKnight
        .long aMapBattleCavalierLayout0, g4bppcMapBattleArchKnight0, aMapBattleCavalierLayout1, g4bppcMapBattleArchKnight1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleArchKnight2, aMapBattleCavalierLayout3, g4bppcMapBattleArchKnight3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleArchKnight3, aMapBattleCavalierLayout5, g4bppcMapBattleArchKnight5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleArchKnight6, aMapBattleCavalierLayout7, g4bppcMapBattleArchKnight0
        .byte 1
        ; Ranger
        .long aMapBattleCavalierLayout0, g4bppcMapBattleRanger0, aMapBattleCavalierLayout1, g4bppcMapBattleRanger1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleRanger2, aMapBattleCavalierLayout3, g4bppcMapBattleRanger3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleRanger3, aMapBattleCavalierLayout5, g4bppcMapBattleRanger5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleRanger6, aMapBattleCavalierLayout7, g4bppcMapBattleRanger0
        .byte 1
        ; MageKnight
        .long aMapBattleCavalierLayout0, g4bppcMapBattleMageKnight0, aMapBattleCavalierLayout1, g4bppcMapBattleMageKnight1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleMageKnight2, aMapBattleCavalierLayout3, g4bppcMapBattleMageKnight3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleMageKnight3, aMapBattleCavalierLayout5, g4bppcMapBattleMageKnight5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleMageKnight6, aMapBattleCavalierLayout7, g4bppcMapBattleMageKnight0
        .byte 1
        ; GreatKnight
        .long aMapBattleCavalierLayout0, g4bppcMapBattleGreatKnight0, aMapBattleCavalierLayout1, g4bppcMapBattleGreatKnight1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleGreatKnight2, aMapBattleCavalierLayout3, g4bppcMapBattleGreatKnight3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleGreatKnight3, aMapBattleCavalierLayout5, g4bppcMapBattleGreatKnight5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleGreatKnight6, aMapBattleCavalierLayout7, g4bppcMapBattleGreatKnight0
        .byte 1
        ; PegasusRider
        .long aMapBattlePegasusRiderLayout0, g4bppcMapBattlePegasusRider0, aMapBattlePegasusRiderLayout1, g4bppcMapBattlePegasusRider1
        .long aMapBattlePegasusRiderLayout2, g4bppcMapBattlePegasusRider2, aMapBattlePegasusRiderLayout3, g4bppcMapBattlePegasusRider3
        .long aMapBattlePegasusRiderLayout4, g4bppcMapBattlePegasusRider3, aMapBattlePegasusRiderLayout5, g4bppcMapBattlePegasusRider5
        .long aMapBattlePegasusRiderLayout6, g4bppcMapBattlePegasusRider6, aMapBattlePegasusRiderLayout7, g4bppcMapBattlePegasusRider0
        .byte 1
        ; PegasusKnight
        .long aMapBattlePegasusRiderLayout0, g4bppcMapBattlePegasusKnight0, aMapBattlePegasusRiderLayout1, g4bppcMapBattlePegasusKnight1
        .long aMapBattlePegasusRiderLayout2, g4bppcMapBattlePegasusKnight2, aMapBattlePegasusRiderLayout3, g4bppcMapBattlePegasusKnight3
        .long aMapBattlePegasusRiderLayout4, g4bppcMapBattlePegasusKnight3, aMapBattlePegasusRiderLayout5, g4bppcMapBattlePegasusKnight5
        .long aMapBattlePegasusRiderLayout6, g4bppcMapBattlePegasusKnight6, aMapBattlePegasusRiderLayout7, g4bppcMapBattlePegasusKnight0
        .byte 1
        ; FalconKnight
        .long aMapBattlePegasusRiderLayout0, g4bppcMapBattleFalconKnight0, aMapBattlePegasusRiderLayout1, g4bppcMapBattleFalconKnight1
        .long aMapBattlePegasusRiderLayout2, g4bppcMapBattleFalconKnight2, aMapBattlePegasusRiderLayout3, g4bppcMapBattleFalconKnight3
        .long aMapBattlePegasusRiderLayout4, g4bppcMapBattleFalconKnight3, aMapBattlePegasusRiderLayout5, g4bppcMapBattleFalconKnight5
        .long aMapBattlePegasusRiderLayout6, g4bppcMapBattleFalconKnight6, aMapBattlePegasusRiderLayout7, g4bppcMapBattleFalconKnight0
        .byte 1
        ; Dragonrider
        .long aMapBattleDragonriderLayout0, g4bppcMapBattleDragonrider0, aMapBattleDragonriderLayout1, g4bppcMapBattleDragonrider1
        .long aMapBattleDragonriderLayout2, g4bppcMapBattleDragonrider2, aMapBattleDragonriderLayout3, g4bppcMapBattleDragonrider3
        .long aMapBattleDragonriderLayout4, g4bppcMapBattleDragonrider3, aMapBattleDragonriderLayout5, g4bppcMapBattleDragonrider5
        .long aMapBattleDragonriderLayout6, g4bppcMapBattleDragonrider6, aMapBattleDragonriderLayout7, g4bppcMapBattleDragonrider0
        .byte 1
        ; Dragonknight
        .long aMapBattleDragonriderLayout0, g4bppcMapBattleDragonknight0, aMapBattleDragonriderLayout1, g4bppcMapBattleDragonknight1
        .long aMapBattleDragonriderLayout2, g4bppcMapBattleDragonknight2, aMapBattleDragonriderLayout3, g4bppcMapBattleDragonknight3
        .long aMapBattleDragonriderLayout4, g4bppcMapBattleDragonknight3, aMapBattleDragonriderLayout5, g4bppcMapBattleDragonknight5
        .long aMapBattleDragonriderLayout6, g4bppcMapBattleDragonknight6, aMapBattleDragonriderLayout7, g4bppcMapBattleDragonknight0
        .byte 1
        ; Dragonmaster
        .long aMapBattleDragonriderLayout0, g4bppcMapBattleDragonmaster0, aMapBattleDragonriderLayout1, g4bppcMapBattleDragonmaster1
        .long aMapBattleDragonriderLayout2, g4bppcMapBattleDragonmaster2, aMapBattleDragonriderLayout3, g4bppcMapBattleDragonmaster3
        .long aMapBattleDragonriderLayout4, g4bppcMapBattleDragonmaster3, aMapBattleDragonriderLayout5, g4bppcMapBattleDragonmaster5
        .long aMapBattleDragonriderLayout6, g4bppcMapBattleDragonmaster6, aMapBattleDragonriderLayout7, g4bppcMapBattleDragonmaster0
        .byte 1
        ; Archer
        .long aMapBattleArcherLayout0, g4bppcMapBattleArcher0, aMapBattleArcherLayout1, g4bppcMapBattleArcher1
        .long aMapBattleArcherLayout2, g4bppcMapBattleArcher2, aMapBattleArcherLayout3, g4bppcMapBattleArcher3
        .long aMapBattleArcherLayout4, g4bppcMapBattleArcher3, aMapBattleArcherLayout5, g4bppcMapBattleArcher5
        .long aMapBattleArcherLayout6, g4bppcMapBattleArcher6, aMapBattleArcherLayout7, g4bppcMapBattleArcher0
        .byte 0
        ; Myrmidon
        .long aMapBattleMyrmidonLayout0, g4bppcMapBattleMyrmidon0, aMapBattleMyrmidonLayout1, g4bppcMapBattleMyrmidon1
        .long aMapBattleMyrmidonLayout2, g4bppcMapBattleMyrmidon2, aMapBattleMyrmidonLayout3, g4bppcMapBattleMyrmidon3
        .long aMapBattleMyrmidonLayout4, g4bppcMapBattleMyrmidon3, aMapBattleMyrmidonLayout5, g4bppcMapBattleMyrmidon5
        .long aMapBattleMyrmidonLayout6, g4bppcMapBattleMyrmidon6, aMapBattleMyrmidonLayout7, g4bppcMapBattleMyrmidon0
        .byte 0
        ; Swordmaster
        .long aMapBattleMyrmidonLayout0, g4bppcMapBattleSwordmaster0, aMapBattleMyrmidonLayout1, g4bppcMapBattleSwordmaster1
        .long aMapBattleMyrmidonLayout2, g4bppcMapBattleSwordmaster2, aMapBattleMyrmidonLayout3, g4bppcMapBattleSwordmaster3
        .long aMapBattleMyrmidonLayout4, g4bppcMapBattleSwordmaster3, aMapBattleMyrmidonLayout5, g4bppcMapBattleSwordmaster5
        .long aMapBattleMyrmidonLayout6, g4bppcMapBattleSwordmaster6, aMapBattleMyrmidonLayout7, g4bppcMapBattleSwordmaster0
        .byte 0
        ; Sniper
        .long aMapBattleArcherLayout0, g4bppcMapBattleSniper0, aMapBattleArcherLayout1, g4bppcMapBattleSniper1
        .long aMapBattleArcherLayout2, g4bppcMapBattleSniper2, aMapBattleArcherLayout3, g4bppcMapBattleSniper3
        .long aMapBattleArcherLayout4, g4bppcMapBattleSniper3, aMapBattleArcherLayout5, g4bppcMapBattleSniper5
        .long aMapBattleArcherLayout6, g4bppcMapBattleSniper6, aMapBattleArcherLayout7, g4bppcMapBattleSniper0
        .byte 0
        ; Hero
        .long aMapBattleMyrmidonLayout0, g4bppcMapBattleHero0, aMapBattleMyrmidonLayout1, g4bppcMapBattleHero1
        .long aMapBattleMyrmidonLayout2, g4bppcMapBattleHero2, aMapBattleMyrmidonLayout3, g4bppcMapBattleHero3
        .long aMapBattleMyrmidonLayout4, g4bppcMapBattleHero3, aMapBattleMyrmidonLayout5, g4bppcMapBattleHero5
        .long aMapBattleMyrmidonLayout6, g4bppcMapBattleHero6, aMapBattleMyrmidonLayout7, g4bppcMapBattleHero0
        .byte 0
        ; General
        .long aMapBattleGeneralLayout0, g4bppcMapBattleGeneral0, aMapBattleGeneralLayout1, g4bppcMapBattleGeneral1
        .long aMapBattleGeneralLayout2, g4bppcMapBattleGeneral2, aMapBattleGeneralLayout3, g4bppcMapBattleGeneral3
        .long aMapBattleGeneralLayout4, g4bppcMapBattleGeneral3, aMapBattleGeneralLayout5, g4bppcMapBattleGeneral5
        .long aMapBattleGeneralLayout6, g4bppcMapBattleGeneral6, aMapBattleGeneralLayout7, g4bppcMapBattleGeneral0
        .byte 0
        ; Emperor
        .long aMapBattleGeneralLayout0, g4bppcMapBattleEmperor0, aMapBattleGeneralLayout1, g4bppcMapBattleEmperor1
        .long aMapBattleGeneralLayout2, g4bppcMapBattleEmperor2, aMapBattleGeneralLayout3, g4bppcMapBattleEmperor3
        .long aMapBattleGeneralLayout4, g4bppcMapBattleEmperor3, aMapBattleGeneralLayout5, g4bppcMapBattleEmperor5
        .long aMapBattleGeneralLayout6, g4bppcMapBattleEmperor6, aMapBattleGeneralLayout7, g4bppcMapBattleEmperor0
        .byte 0
        ; Baron
        .long aMapBattleGeneralLayout0, g4bppcMapBattleBaron0, aMapBattleGeneralLayout1, g4bppcMapBattleBaron1
        .long aMapBattleGeneralLayout2, g4bppcMapBattleBaron2, aMapBattleGeneralLayout3, g4bppcMapBattleBaron3
        .long aMapBattleGeneralLayout4, g4bppcMapBattleBaron3, aMapBattleGeneralLayout5, g4bppcMapBattleBaron5
        .long aMapBattleGeneralLayout6, g4bppcMapBattleBaron6, aMapBattleGeneralLayout7, g4bppcMapBattleBaron0
        .byte 0
        ; Soldier
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; SpearSoldier
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; AxeSoldier
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; BowSoldier
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; SwordSoldier
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; LanceArmor
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; AxeArmor
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; BowArmor
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; SwordArmor
        .long aMapBattleSoldierLayout0, g4bppcMapBattleSoldier0, aMapBattleSoldierLayout1, g4bppcMapBattleSoldier1
        .long aMapBattleSoldierLayout2, g4bppcMapBattleSoldier2, aMapBattleSoldierLayout3, g4bppcMapBattleSoldier3
        .long aMapBattleSoldierLayout4, g4bppcMapBattleSoldier3, aMapBattleSoldierLayout5, g4bppcMapBattleSoldier5
        .long aMapBattleSoldierLayout6, g4bppcMapBattleSoldier6, aMapBattleSoldierLayout7, g4bppcMapBattleSoldier0
        .byte 0
        ; Barbarian
        .long aMapBattleBarbarianLayout0, g4bppcMapBattleBarbarian0, aMapBattleBarbarianLayout1, g4bppcMapBattleBarbarian1
        .long aMapBattleBarbarianLayout2, g4bppcMapBattleBarbarian2, aMapBattleBarbarianLayout3, g4bppcMapBattleBarbarian3
        .long aMapBattleBarbarianLayout4, g4bppcMapBattleBarbarian3, aMapBattleBarbarianLayout5, g4bppcMapBattleBarbarian5
        .long aMapBattleBarbarianLayout6, g4bppcMapBattleBarbarian6, aMapBattleBarbarianLayout7, g4bppcMapBattleBarbarian0
        .byte 0
        ; Fighter
        .long aMapBattleBarbarianLayout0, g4bppcMapBattleFighter0, aMapBattleBarbarianLayout1, g4bppcMapBattleFighter1
        .long aMapBattleBarbarianLayout2, g4bppcMapBattleFighter2, aMapBattleBarbarianLayout3, g4bppcMapBattleFighter3
        .long aMapBattleBarbarianLayout4, g4bppcMapBattleFighter3, aMapBattleBarbarianLayout5, g4bppcMapBattleFighter5
        .long aMapBattleBarbarianLayout6, g4bppcMapBattleFighter6, aMapBattleBarbarianLayout7, g4bppcMapBattleFighter0
        .byte 0
        ; Brigand
        .long aMapBattleBarbarianLayout0, g4bppcMapBattleBrigand0, aMapBattleBarbarianLayout1, g4bppcMapBattleBrigand1
        .long aMapBattleBarbarianLayout2, g4bppcMapBattleBrigand2, aMapBattleBarbarianLayout3, g4bppcMapBattleBrigand3
        .long aMapBattleBarbarianLayout4, g4bppcMapBattleBrigand3, aMapBattleBarbarianLayout5, g4bppcMapBattleBrigand5
        .long aMapBattleBarbarianLayout6, g4bppcMapBattleBrigand6, aMapBattleBarbarianLayout7, g4bppcMapBattleBrigand0
        .byte 0
        ; Warrior
        .long aMapBattleWarriorLayout0, g4bppcMapBattleWarrior0, aMapBattleWarriorLayout1, g4bppcMapBattleWarrior1
        .long aMapBattleWarriorLayout2, g4bppcMapBattleWarrior2, aMapBattleWarriorLayout3, g4bppcMapBattleWarrior3
        .long aMapBattleWarriorLayout4, g4bppcMapBattleWarrior3, aMapBattleWarriorLayout5, g4bppcMapBattleWarrior5
        .long aMapBattleWarriorLayout6, g4bppcMapBattleWarrior6, aMapBattleWarriorLayout7, g4bppcMapBattleWarrior0
        .byte 0
        ; Hunter
        .long aMapBattleWarriorLayout0, g4bppcMapBattleHunter0, aMapBattleWarriorLayout1, g4bppcMapBattleHunter1
        .long aMapBattleWarriorLayout2, g4bppcMapBattleHunter2, aMapBattleWarriorLayout3, g4bppcMapBattleHunter3
        .long aMapBattleWarriorLayout4, g4bppcMapBattleHunter3, aMapBattleWarriorLayout5, g4bppcMapBattleHunter5
        .long aMapBattleWarriorLayout6, g4bppcMapBattleHunter6, aMapBattleWarriorLayout7, g4bppcMapBattleHunter0
        .byte 0
        ; Pirate
        .long aMapBattleBarbarianLayout0, g4bppcMapBattlePirate0, aMapBattleBarbarianLayout1, g4bppcMapBattlePirate1
        .long aMapBattleBarbarianLayout2, g4bppcMapBattlePirate2, aMapBattleBarbarianLayout3, g4bppcMapBattlePirate3
        .long aMapBattleBarbarianLayout4, g4bppcMapBattlePirate3, aMapBattleBarbarianLayout5, g4bppcMapBattlePirate5
        .long aMapBattleBarbarianLayout6, g4bppcMapBattlePirate6, aMapBattleBarbarianLayout7, g4bppcMapBattlePirate0
        .byte 0
        ; JuniorLord
        .long aMapBattleJuniorLordLayout0, g4bppcMapBattleJuniorLord0, aMapBattleJuniorLordLayout1, g4bppcMapBattleJuniorLord1
        .long aMapBattleJuniorLordLayout2, g4bppcMapBattleJuniorLord2, aMapBattleJuniorLordLayout3, g4bppcMapBattleJuniorLord3
        .long aMapBattleJuniorLordLayout4, g4bppcMapBattleJuniorLord3, aMapBattleJuniorLordLayout5, g4bppcMapBattleJuniorLord5
        .long aMapBattleJuniorLordLayout6, g4bppcMapBattleJuniorLord6, aMapBattleJuniorLordLayout7, g4bppcMapBattleJuniorLord0
        .byte 0
        ; WarMage
        .long aMapBattleWarMageLayout0, g4bppcMapBattleWarMage0, aMapBattleWarMageLayout1, g4bppcMapBattleWarMage1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleWarMage2, aMapBattleWarMageLayout3, g4bppcMapBattleWarMage3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleWarMage3, aMapBattleWarMageLayout5, g4bppcMapBattleWarMage5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleWarMage6, aMapBattleWarMageLayout7, g4bppcMapBattleWarMage0
        .byte 0
        ; Prince
        .long aMapBattleJuniorLordLayout0, g4bppcMapBattlePrince0, aMapBattleJuniorLordLayout1, g4bppcMapBattlePrince1
        .long aMapBattleJuniorLordLayout2, g4bppcMapBattlePrince2, aMapBattleJuniorLordLayout3, g4bppcMapBattlePrince3
        .long aMapBattleJuniorLordLayout4, g4bppcMapBattlePrince3, aMapBattleJuniorLordLayout5, g4bppcMapBattlePrince5
        .long aMapBattleJuniorLordLayout6, g4bppcMapBattlePrince6, aMapBattleJuniorLordLayout7, g4bppcMapBattlePrince0
        .byte 0
        ; Princess
        .long aMapBattleWarMageLayout0, g4bppcMapBattlePrincess0, aMapBattleWarMageLayout1, g4bppcMapBattlePrincess1
        .long aMapBattleWarMageLayout2, g4bppcMapBattlePrincess2, aMapBattleWarMageLayout3, g4bppcMapBattlePrincess3
        .long aMapBattleWarMageLayout4, g4bppcMapBattlePrincess3, aMapBattleWarMageLayout5, g4bppcMapBattlePrincess5
        .long aMapBattleWarMageLayout6, g4bppcMapBattlePrincess6, aMapBattleWarMageLayout7, g4bppcMapBattlePrincess0
        .byte 0
        ; WarMageF
        .long aMapBattleWarMageLayout0, g4bppcMapBattleWarMageF0, aMapBattleWarMageLayout1, g4bppcMapBattleWarMageF1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleWarMageF2, aMapBattleWarMageLayout3, g4bppcMapBattleWarMageF3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleWarMageF3, aMapBattleWarMageLayout5, g4bppcMapBattleWarMageF5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleWarMageF6, aMapBattleWarMageLayout7, g4bppcMapBattleWarMageF0
        .byte 0
        ; Queen
        .long aMapBattleWarMageLayout0, g4bppcMapBattleQueen0, aMapBattleWarMageLayout1, g4bppcMapBattleQueen1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleQueen2, aMapBattleWarMageLayout3, g4bppcMapBattleQueen3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleQueen3, aMapBattleWarMageLayout5, g4bppcMapBattleQueen5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleQueen6, aMapBattleWarMageLayout7, g4bppcMapBattleQueen0
        .byte 0
        ; Dancer
        .long aMapBattleDancerLayout0, g4bppcMapBattleDancer0, aMapBattleDancerLayout1, g4bppcMapBattleDancer1
        .long aMapBattleDancerLayout2, g4bppcMapBattleDancer2, aMapBattleDancerLayout3, g4bppcMapBattleDancer3
        .long aMapBattleDancerLayout4, g4bppcMapBattleDancer3, aMapBattleDancerLayout5, g4bppcMapBattleDancer5
        .long aMapBattleDancerLayout6, g4bppcMapBattleDancer6, aMapBattleDancerLayout7, g4bppcMapBattleDancer0
        .byte 0
        ; Priest
        .long aMapBattleWarMageLayout0, g4bppcMapBattlePriest0, aMapBattleWarMageLayout1, g4bppcMapBattlePriest1
        .long aMapBattleWarMageLayout2, g4bppcMapBattlePriest2, aMapBattleWarMageLayout3, g4bppcMapBattlePriest3
        .long aMapBattleWarMageLayout4, g4bppcMapBattlePriest3, aMapBattleWarMageLayout5, g4bppcMapBattlePriest5
        .long aMapBattleWarMageLayout6, g4bppcMapBattlePriest6, aMapBattleWarMageLayout7, g4bppcMapBattlePriest0
        .byte 0
        ; Mage
        .long aMapBattleWarMageLayout0, g4bppcMapBattleMage0, aMapBattleWarMageLayout1, g4bppcMapBattleMage1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleMage2, aMapBattleWarMageLayout3, g4bppcMapBattleMage3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleMage3, aMapBattleWarMageLayout5, g4bppcMapBattleMage5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleMage6, aMapBattleWarMageLayout7, g4bppcMapBattleMage0
        .byte 0
        ; FireMage
        .long aMapBattleWarMageLayout0, g4bppcMapBattleFireMage0, aMapBattleWarMageLayout1, g4bppcMapBattleFireMage1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleFireMage2, aMapBattleWarMageLayout3, g4bppcMapBattleFireMage3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleFireMage3, aMapBattleWarMageLayout5, g4bppcMapBattleFireMage5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleFireMage6, aMapBattleWarMageLayout7, g4bppcMapBattleFireMage0
        .byte 0
        ; ThunderMage
        .long aMapBattleWarMageLayout0, g4bppcMapBattleThunderMage0, aMapBattleWarMageLayout1, g4bppcMapBattleThunderMage1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleThunderMage2, aMapBattleWarMageLayout3, g4bppcMapBattleThunderMage3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleThunderMage3, aMapBattleWarMageLayout5, g4bppcMapBattleThunderMage5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleThunderMage6, aMapBattleWarMageLayout7, g4bppcMapBattleThunderMage0
        .byte 0
        ; WindMage
        .long aMapBattleWarMageLayout0, g4bppcMapBattleWindMage0, aMapBattleWarMageLayout1, g4bppcMapBattleWindMage1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleWindMage2, aMapBattleWarMageLayout3, g4bppcMapBattleWindMage3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleWindMage3, aMapBattleWarMageLayout5, g4bppcMapBattleWindMage5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleWindMage6, aMapBattleWarMageLayout7, g4bppcMapBattleWindMage0
        .byte 0
        ; HighPriest
        .long aMapBattleWarMageLayout0, g4bppcMapBattleHighPriest0, aMapBattleWarMageLayout1, g4bppcMapBattleHighPriest1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleHighPriest2, aMapBattleWarMageLayout3, g4bppcMapBattleHighPriest3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleHighPriest3, aMapBattleWarMageLayout5, g4bppcMapBattleHighPriest5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleHighPriest6, aMapBattleWarMageLayout7, g4bppcMapBattleHighPriest0
        .byte 0
        ; Bishop
        .long aMapBattleWarMageLayout0, g4bppcMapBattleBishop0, aMapBattleWarMageLayout1, g4bppcMapBattleBishop1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleBishop2, aMapBattleWarMageLayout3, g4bppcMapBattleBishop3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleBishop3, aMapBattleWarMageLayout5, g4bppcMapBattleBishop5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleBishop6, aMapBattleWarMageLayout7, g4bppcMapBattleBishop0
        .byte 0
        ; Sage
        .long aMapBattleWarMageLayout0, g4bppcMapBattleSage0, aMapBattleWarMageLayout1, g4bppcMapBattleSage1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleSage2, aMapBattleWarMageLayout3, g4bppcMapBattleSage3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleSage3, aMapBattleWarMageLayout5, g4bppcMapBattleSage5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleSage6, aMapBattleWarMageLayout7, g4bppcMapBattleSage0
        .byte 0
        ; Bard
        .long aMapBattleWarMageLayout0, g4bppcMapBattleBard0, aMapBattleWarMageLayout1, g4bppcMapBattleBard1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleBard2, aMapBattleWarMageLayout3, g4bppcMapBattleBard3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleBard3, aMapBattleWarMageLayout5, g4bppcMapBattleBard5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleBard6, aMapBattleWarMageLayout7, g4bppcMapBattleBard0
        .byte 0
        ; Priestess
        .long aMapBattleWarMageLayout0, g4bppcMapBattlePriestess0, aMapBattleWarMageLayout1, g4bppcMapBattlePriestess1
        .long aMapBattleWarMageLayout2, g4bppcMapBattlePriestess2, aMapBattleWarMageLayout3, g4bppcMapBattlePriestess3
        .long aMapBattleWarMageLayout4, g4bppcMapBattlePriestess3, aMapBattleWarMageLayout5, g4bppcMapBattlePriestess5
        .long aMapBattleWarMageLayout6, g4bppcMapBattlePriestess6, aMapBattleWarMageLayout7, g4bppcMapBattlePriestess0
        .byte 0
        ; DarkMage
        .long aMapBattleWarMageLayout0, g4bppcMapBattleDarkMage0, aMapBattleWarMageLayout1, g4bppcMapBattleDarkMage1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleDarkMage2, aMapBattleWarMageLayout3, g4bppcMapBattleDarkMage3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleDarkMage3, aMapBattleWarMageLayout5, g4bppcMapBattleDarkMage5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleDarkMage6, aMapBattleWarMageLayout7, g4bppcMapBattleDarkMage0
        .byte 0
        ; DarkBishop
        .long aMapBattleWarMageLayout0, g4bppcMapBattleDarkBishop0, aMapBattleWarMageLayout1, g4bppcMapBattleDarkBishop1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleDarkBishop2, aMapBattleWarMageLayout3, g4bppcMapBattleDarkBishop3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleDarkBishop3, aMapBattleWarMageLayout5, g4bppcMapBattleDarkBishop5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleDarkBishop6, aMapBattleWarMageLayout7, g4bppcMapBattleDarkBishop0
        .byte 0
        ; Thief
        .long aMapBattleThiefLayout0, g4bppcMapBattleThief0, aMapBattleThiefLayout1, g4bppcMapBattleThief1
        .long aMapBattleThiefLayout2, g4bppcMapBattleThief2, aMapBattleThiefLayout3, g4bppcMapBattleThief3
        .long aMapBattleThiefLayout4, g4bppcMapBattleThief3, aMapBattleThiefLayout5, g4bppcMapBattleThief5
        .long aMapBattleThiefLayout6, g4bppcMapBattleThief6, aMapBattleThiefLayout7, g4bppcMapBattleThief0
        .byte 0
        ; Rogue
        .long aMapBattleThiefLayout0, g4bppcMapBattleRogue0, aMapBattleThiefLayout1, g4bppcMapBattleRogue1
        .long aMapBattleThiefLayout2, g4bppcMapBattleRogue2, aMapBattleThiefLayout3, g4bppcMapBattleRogue3
        .long aMapBattleThiefLayout4, g4bppcMapBattleRogue3, aMapBattleThiefLayout5, g4bppcMapBattleRogue5
        .long aMapBattleThiefLayout6, g4bppcMapBattleRogue6, aMapBattleThiefLayout7, g4bppcMapBattleRogue0
        .byte 0
        ; Civilian
        .long aMapBattleDancerLayout0, g4bppcMapBattleCivilian0, aMapBattleDancerLayout1, g4bppcMapBattleCivilian1
        .long aMapBattleDancerLayout2, g4bppcMapBattleCivilian2, aMapBattleDancerLayout3, g4bppcMapBattleCivilian3
        .long aMapBattleDancerLayout4, g4bppcMapBattleCivilian3, aMapBattleDancerLayout5, g4bppcMapBattleCivilian5
        .long aMapBattleDancerLayout6, g4bppcMapBattleCivilian6, aMapBattleDancerLayout7, g4bppcMapBattleCivilian0
        .byte 0
        ; Child
        .long aMapBattleDancerLayout0, g4bppcMapBattleChild0, aMapBattleDancerLayout1, g4bppcMapBattleChild1
        .long aMapBattleDancerLayout2, g4bppcMapBattleChild2, aMapBattleDancerLayout3, g4bppcMapBattleChild3
        .long aMapBattleDancerLayout4, g4bppcMapBattleChild3, aMapBattleDancerLayout5, g4bppcMapBattleChild5
        .long aMapBattleDancerLayout6, g4bppcMapBattleChild6, aMapBattleDancerLayout7, g4bppcMapBattleChild0
        .byte 0
        ; Ballistician
        .long aMapBattleBallisticianLayout0, g4bppcMapBattleBallistician0, aMapBattleBallisticianLayout1, g4bppcMapBattleBallistician1
        .long aMapBattleBallisticianLayout2, g4bppcMapBattleBallistician2, aMapBattleBallisticianLayout3, g4bppcMapBattleBallistician3
        .long aMapBattleBallisticianLayout4, g4bppcMapBattleBallistician4, aMapBattleBallisticianLayout5, g4bppcMapBattleBallistician5
        .long aMapBattleBallisticianLayout6, g4bppcMapBattleBallistician6, aMapBattleBallisticianLayout7, g4bppcMapBattleBallistician7
        .byte 1
        ; IronBallistician
        .long aMapBattleBallisticianLayout0, g4bppcMapBattleIronBallistician0, aMapBattleBallisticianLayout1, g4bppcMapBattleIronBallistician1
        .long aMapBattleBallisticianLayout2, g4bppcMapBattleIronBallistician2, aMapBattleBallisticianLayout3, g4bppcMapBattleIronBallistician3
        .long aMapBattleBallisticianLayout4, g4bppcMapBattleIronBallistician4, aMapBattleBallisticianLayout5, g4bppcMapBattleIronBallistician5
        .long aMapBattleBallisticianLayout6, g4bppcMapBattleIronBallistician6, aMapBattleBallisticianLayout7, g4bppcMapBattleIronBallistician7
        .byte 1
        ; KillerBallistician
        .long aMapBattleBallisticianLayout0, g4bppcMapBattleKillerBallistician0, aMapBattleBallisticianLayout1, g4bppcMapBattleKillerBallistician1
        .long aMapBattleBallisticianLayout2, g4bppcMapBattleKillerBallistician2, aMapBattleBallisticianLayout3, g4bppcMapBattleKillerBallistician3
        .long aMapBattleBallisticianLayout4, g4bppcMapBattleKillerBallistician4, aMapBattleBallisticianLayout5, g4bppcMapBattleKillerBallistician5
        .long aMapBattleBallisticianLayout6, g4bppcMapBattleKillerBallistician6, aMapBattleBallisticianLayout7, g4bppcMapBattleKillerBallistician7
        .byte 1
        ; GreatBallistician
        .long aMapBattleBallisticianLayout0, g4bppcMapBattleGreatBallistician0, aMapBattleBallisticianLayout1, g4bppcMapBattleGreatBallistician1
        .long aMapBattleBallisticianLayout2, g4bppcMapBattleGreatBallistician2, aMapBattleBallisticianLayout3, g4bppcMapBattleGreatBallistician3
        .long aMapBattleBallisticianLayout4, g4bppcMapBattleGreatBallistician4, aMapBattleBallisticianLayout5, g4bppcMapBattleGreatBallistician5
        .long aMapBattleBallisticianLayout6, g4bppcMapBattleGreatBallistician6, aMapBattleBallisticianLayout7, g4bppcMapBattleGreatBallistician7
        .byte 1
        ; DarkPrince
        .long aMapBattleWarMageLayout0, g4bppcMapBattleDarkPrince0, aMapBattleWarMageLayout1, g4bppcMapBattleDarkPrince1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleDarkPrince2, aMapBattleWarMageLayout3, g4bppcMapBattleDarkPrince3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleDarkPrince3, aMapBattleWarMageLayout5, g4bppcMapBattleDarkPrince5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleDarkPrince6, aMapBattleWarMageLayout7, g4bppcMapBattleDarkPrince0
        .byte 0
        ; MasterKnightFemale
        .long aMapBattleCavalierLayout0, g4bppcMapBattleMasterKnightFemale0, aMapBattleCavalierLayout1, g4bppcMapBattleMasterKnightFemale1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleMasterKnightFemale2, aMapBattleCavalierLayout3, g4bppcMapBattleMasterKnightFemale3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleMasterKnightFemale3, aMapBattleCavalierLayout5, g4bppcMapBattleMasterKnightFemale5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleMasterKnightFemale6, aMapBattleCavalierLayout7, g4bppcMapBattleMasterKnightFemale0
        .byte 1
        ; MageKnightFemale
        .long aMapBattleCavalierLayout0, g4bppcMapBattleMageKnightFemale0, aMapBattleCavalierLayout1, g4bppcMapBattleMageKnightFemale1
        .long aMapBattleCavalierLayout2, g4bppcMapBattleMageKnightFemale2, aMapBattleCavalierLayout3, g4bppcMapBattleMageKnightFemale3
        .long aMapBattleCavalierLayout4, g4bppcMapBattleMageKnightFemale3, aMapBattleCavalierLayout5, g4bppcMapBattleMageKnightFemale5
        .long aMapBattleCavalierLayout6, g4bppcMapBattleMageKnightFemale6, aMapBattleCavalierLayout7, g4bppcMapBattleMageKnightFemale0
        .byte 1
        ; DragonRiderFemale
        .long aMapBattleDragonriderLayout0, g4bppcMapBattleDragonRiderFemale0, aMapBattleDragonriderLayout1, g4bppcMapBattleDragonRiderFemale1
        .long aMapBattleDragonriderLayout2, g4bppcMapBattleDragonRiderFemale2, aMapBattleDragonriderLayout3, g4bppcMapBattleDragonRiderFemale3
        .long aMapBattleDragonriderLayout4, g4bppcMapBattleDragonRiderFemale3, aMapBattleDragonriderLayout5, g4bppcMapBattleDragonRiderFemale5
        .long aMapBattleDragonriderLayout6, g4bppcMapBattleDragonRiderFemale6, aMapBattleDragonriderLayout7, g4bppcMapBattleDragonRiderFemale0
        .byte 1
        ; DragonknightFemale
        .long aMapBattleDragonriderLayout0, g4bppcMapBattleDragonknightFemale0, aMapBattleDragonriderLayout1, g4bppcMapBattleDragonknightFemale1
        .long aMapBattleDragonriderLayout2, g4bppcMapBattleDragonknightFemale2, aMapBattleDragonriderLayout3, g4bppcMapBattleDragonknightFemale3
        .long aMapBattleDragonriderLayout4, g4bppcMapBattleDragonknightFemale3, aMapBattleDragonriderLayout5, g4bppcMapBattleDragonknightFemale5
        .long aMapBattleDragonriderLayout6, g4bppcMapBattleDragonknightFemale6, aMapBattleDragonriderLayout7, g4bppcMapBattleDragonknightFemale0
        .byte 1
        ; DragonmasterFemale
        .long aMapBattleDragonriderLayout0, g4bppcMapBattleDragonmasterFemale0, aMapBattleDragonriderLayout1, g4bppcMapBattleDragonmasterFemale1
        .long aMapBattleDragonriderLayout2, g4bppcMapBattleDragonmasterFemale2, aMapBattleDragonriderLayout3, g4bppcMapBattleDragonmasterFemale3
        .long aMapBattleDragonriderLayout4, g4bppcMapBattleDragonmasterFemale3, aMapBattleDragonriderLayout5, g4bppcMapBattleDragonmasterFemale5
        .long aMapBattleDragonriderLayout6, g4bppcMapBattleDragonmasterFemale6, aMapBattleDragonriderLayout7, g4bppcMapBattleDragonmasterFemale0
        .byte 1
        ; ArcherFemale
        .long aMapBattleArcherLayout0, g4bppcMapBattleArcherFemale0, aMapBattleArcherLayout1, g4bppcMapBattleArcherFemale1
        .long aMapBattleArcherLayout2, g4bppcMapBattleArcherFemale2, aMapBattleArcherLayout3, g4bppcMapBattleArcherFemale3
        .long aMapBattleArcherLayout4, g4bppcMapBattleArcherFemale3, aMapBattleArcherLayout5, g4bppcMapBattleArcherFemale5
        .long aMapBattleArcherLayout6, g4bppcMapBattleArcherFemale6, aMapBattleArcherLayout7, g4bppcMapBattleArcherFemale0
        .byte 0
        ; MyrmidonFemale
        .long aMapBattleMyrmidonLayout0, g4bppcMapBattleMyrmidonFemale0, aMapBattleMyrmidonLayout1, g4bppcMapBattleMyrmidonFemale1
        .long aMapBattleMyrmidonLayout2, g4bppcMapBattleMyrmidonFemale2, aMapBattleMyrmidonLayout3, g4bppcMapBattleMyrmidonFemale3
        .long aMapBattleMyrmidonLayout4, g4bppcMapBattleMyrmidonFemale3, aMapBattleMyrmidonLayout5, g4bppcMapBattleMyrmidonFemale5
        .long aMapBattleMyrmidonLayout6, g4bppcMapBattleMyrmidonFemale6, aMapBattleMyrmidonLayout7, g4bppcMapBattleMyrmidonFemale0
        .byte 0
        ; SwordmasterFemale
        .long aMapBattleMyrmidonLayout0, g4bppcMapBattleSwordmasterFemale0, aMapBattleMyrmidonLayout1, g4bppcMapBattleSwordmasterFemale1
        .long aMapBattleMyrmidonLayout2, g4bppcMapBattleSwordmasterFemale2, aMapBattleMyrmidonLayout3, g4bppcMapBattleSwordmasterFemale3
        .long aMapBattleMyrmidonLayout4, g4bppcMapBattleSwordmasterFemale3, aMapBattleMyrmidonLayout5, g4bppcMapBattleSwordmasterFemale5
        .long aMapBattleMyrmidonLayout6, g4bppcMapBattleSwordmasterFemale6, aMapBattleMyrmidonLayout7, g4bppcMapBattleSwordmasterFemale0
        .byte 0
        ; SniperFemale
        .long aMapBattleArcherLayout0, g4bppcMapBattleSniperFemale0, aMapBattleArcherLayout1, g4bppcMapBattleSniperFemale1
        .long aMapBattleArcherLayout2, g4bppcMapBattleSniperFemale2, aMapBattleArcherLayout3, g4bppcMapBattleSniperFemale3
        .long aMapBattleArcherLayout4, g4bppcMapBattleSniperFemale3, aMapBattleArcherLayout5, g4bppcMapBattleSniperFemale5
        .long aMapBattleArcherLayout6, g4bppcMapBattleSniperFemale6, aMapBattleArcherLayout7, g4bppcMapBattleSniperFemale0
        .byte 0
        ; HeroFemale
        .long aMapBattleMyrmidonLayout0, g4bppcMapBattleHeroFemale0, aMapBattleMyrmidonLayout1, g4bppcMapBattleHeroFemale1
        .long aMapBattleMyrmidonLayout2, g4bppcMapBattleHeroFemale2, aMapBattleMyrmidonLayout3, g4bppcMapBattleHeroFemale3
        .long aMapBattleMyrmidonLayout4, g4bppcMapBattleHeroFemale3, aMapBattleMyrmidonLayout5, g4bppcMapBattleHeroFemale5
        .long aMapBattleMyrmidonLayout6, g4bppcMapBattleHeroFemale6, aMapBattleMyrmidonLayout7, g4bppcMapBattleHeroFemale0
        .byte 0
        ; PriestFemale
        .long aMapBattleWarMageLayout0, g4bppcMapBattlePriestFemale0, aMapBattleWarMageLayout1, g4bppcMapBattlePriestFemale1
        .long aMapBattleWarMageLayout2, g4bppcMapBattlePriestFemale2, aMapBattleWarMageLayout3, g4bppcMapBattlePriestFemale3
        .long aMapBattleWarMageLayout4, g4bppcMapBattlePriestFemale3, aMapBattleWarMageLayout5, g4bppcMapBattlePriestFemale5
        .long aMapBattleWarMageLayout6, g4bppcMapBattlePriestFemale6, aMapBattleWarMageLayout7, g4bppcMapBattlePriestFemale0
        .byte 0
        ; MageFemale
        .long aMapBattleWarMageLayout0, g4bppcMapBattleMageFemale0, aMapBattleWarMageLayout1, g4bppcMapBattleMageFemale1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleMageFemale2, aMapBattleWarMageLayout3, g4bppcMapBattleMageFemale3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleMageFemale3, aMapBattleWarMageLayout5, g4bppcMapBattleMageFemale5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleMageFemale6, aMapBattleWarMageLayout7, g4bppcMapBattleMageFemale0
        .byte 0
        ; FireMageFemale
        .long aMapBattleWarMageLayout0, g4bppcMapBattleFireMageFemale0, aMapBattleWarMageLayout1, g4bppcMapBattleFireMageFemale1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleFireMageFemale2, aMapBattleWarMageLayout3, g4bppcMapBattleFireMageFemale3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleFireMageFemale3, aMapBattleWarMageLayout5, g4bppcMapBattleFireMageFemale5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleFireMageFemale6, aMapBattleWarMageLayout7, g4bppcMapBattleFireMageFemale0
        .byte 0
        ; ThunderMageFemale
        .long aMapBattleWarMageLayout0, g4bppcMapBattleThunderMageFemale0, aMapBattleWarMageLayout1, g4bppcMapBattleThunderMageFemale1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleThunderMageFemale2, aMapBattleWarMageLayout3, g4bppcMapBattleThunderMageFemale3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleThunderMageFemale3, aMapBattleWarMageLayout5, g4bppcMapBattleThunderMageFemale5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleThunderMageFemale6, aMapBattleWarMageLayout7, g4bppcMapBattleThunderMageFemale0
        .byte 0
        ; WindMageFemale
        .long aMapBattleWarMageLayout0, g4bppcMapBattleWindMageFemale0, aMapBattleWarMageLayout1, g4bppcMapBattleWindMageFemale1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleWindMageFemale2, aMapBattleWarMageLayout3, g4bppcMapBattleWindMageFemale3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleWindMageFemale3, aMapBattleWarMageLayout5, g4bppcMapBattleWindMageFemale5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleWindMageFemale6, aMapBattleWarMageLayout7, g4bppcMapBattleWindMageFemale0
        .byte 0
        ; HighPriestFemale
        .long aMapBattleWarMageLayout0, g4bppcMapBattleHighPriestFemale0, aMapBattleWarMageLayout1, g4bppcMapBattleHighPriestFemale1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleHighPriestFemale2, aMapBattleWarMageLayout3, g4bppcMapBattleHighPriestFemale3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleHighPriestFemale3, aMapBattleWarMageLayout5, g4bppcMapBattleHighPriestFemale5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleHighPriestFemale6, aMapBattleWarMageLayout7, g4bppcMapBattleHighPriestFemale0
        .byte 0
        ; SageFemale
        .long aMapBattleWarMageLayout0, g4bppcMapBattleSageFemale0, aMapBattleWarMageLayout1, g4bppcMapBattleSageFemale1
        .long aMapBattleWarMageLayout2, g4bppcMapBattleSageFemale2, aMapBattleWarMageLayout3, g4bppcMapBattleSageFemale3
        .long aMapBattleWarMageLayout4, g4bppcMapBattleSageFemale3, aMapBattleWarMageLayout5, g4bppcMapBattleSageFemale5
        .long aMapBattleWarMageLayout6, g4bppcMapBattleSageFemale6, aMapBattleWarMageLayout7, g4bppcMapBattleSageFemale0
        .byte 0
        ; ThiefFemale
        .long aMapBattleThiefLayout0, g4bppcMapBattleThiefFemale0, aMapBattleThiefLayout1, g4bppcMapBattleThiefFemale1
        .long aMapBattleThiefLayout2, g4bppcMapBattleThiefFemale2, aMapBattleThiefLayout3, g4bppcMapBattleThiefFemale3
        .long aMapBattleThiefLayout4, g4bppcMapBattleThiefFemale3, aMapBattleThiefLayout5, g4bppcMapBattleThiefFemale5
        .long aMapBattleThiefLayout6, g4bppcMapBattleThiefFemale6, aMapBattleThiefLayout7, g4bppcMapBattleThiefFemale0
        .byte 0
        ; RogueFemale
        .long aMapBattleThiefLayout0, g4bppcMapBattleRogueFemale0, aMapBattleThiefLayout1, g4bppcMapBattleRogueFemale1
        .long aMapBattleThiefLayout2, g4bppcMapBattleRogueFemale2, aMapBattleThiefLayout3, g4bppcMapBattleRogueFemale3
        .long aMapBattleThiefLayout4, g4bppcMapBattleRogueFemale3, aMapBattleThiefLayout5, g4bppcMapBattleRogueFemale5
        .long aMapBattleThiefLayout6, g4bppcMapBattleRogueFemale6, aMapBattleThiefLayout7, g4bppcMapBattleRogueFemale0
        .byte 0
        ; CivilianFemale
        .long aMapBattleDancerLayout0, g4bppcMapBattleCivilianFemale0, aMapBattleDancerLayout1, g4bppcMapBattleCivilianFemale1
        .long aMapBattleDancerLayout2, g4bppcMapBattleCivilianFemale2, aMapBattleDancerLayout3, g4bppcMapBattleCivilianFemale3
        .long aMapBattleDancerLayout4, g4bppcMapBattleCivilianFemale3, aMapBattleDancerLayout5, g4bppcMapBattleCivilianFemale5
        .long aMapBattleDancerLayout6, g4bppcMapBattleCivilianFemale6, aMapBattleDancerLayout7, g4bppcMapBattleCivilianFemale0
        .byte 0
        ; ChildFemale
        .long aMapBattleDancerLayout0, g4bppcMapBattleChildFemale0, aMapBattleDancerLayout1, g4bppcMapBattleChildFemale1
        .long aMapBattleDancerLayout2, g4bppcMapBattleChildFemale2, aMapBattleDancerLayout3, g4bppcMapBattleChildFemale3
        .long aMapBattleDancerLayout4, g4bppcMapBattleChildFemale3, aMapBattleDancerLayout5, g4bppcMapBattleChildFemale5
        .long aMapBattleDancerLayout6, g4bppcMapBattleChildFemale6, aMapBattleDancerLayout7, g4bppcMapBattleChildFemale0
        .byte 0
        ; (no name in the original notes)
        .long aMapBattleCavalierLayout0, g4bppcMapBattleChildFemale8, aMapBattleCavalierLayout1, g4bppcMapBattleChildFemale9
        .long aMapBattleCavalierLayout2, g4bppcMapBattleChildFemale10, aMapBattleCavalierLayout3, g4bppcMapBattleChildFemale11
        .long aMapBattleCavalierLayout4, g4bppcMapBattleChildFemale11, aMapBattleCavalierLayout5, g4bppcMapBattleChildFemale13
        .long aMapBattleCavalierLayout6, g4bppcMapBattleChildFemale14, aMapBattleCavalierLayout7, g4bppcMapBattleChildFemale8
        .byte 1

        ; 9E/C70B

    .endsection BattleMapSpriteDataSection


    .section Unsorted9EC70BSection

      .al
      .xl

      procUnknown9EC70B ; 9E/C70B

        .structProcInfo "ON", rlProcUnknown9EC70BInit, rlProcUnknown9EC70BCycle, $9ECAD2

      rlProcUnknown9EC70BInit ; 9E/C713
      
        .al
        .autsiz
        .databank ?

        lda wGameStateRoutine1,b
        sta aProcSystem.aBody7,b,x

        stz wGameStateRoutine1,b
        jsl rlUnknown88CD53
        jsl rlUnknown88CD61

        lda #1
        sta aProcSystem.aBody4,b,x
        sta $7F4C2D

        lda #0
        sta $7F459E
        sta $7F4BE7
        sta $7F4BE9
        sta $7F4C05
        sta $7F4C07
        sta $7F50CB

        lda #$FFFF
        sta $7F4BED
        sta $7F4BEF
        sta $7F4BF1
        sta $7F4BF3
        sta $7F4C1F

        jsl rlUnknown9E811F

        lda aActiveSpriteSystem.wFlag,b
        sta $7F4BD9

        lda aActiveSpriteSystem.wFlag,b
        ora #$4000
        sta aActiveSpriteSystem.wFlag,b

        rtl

        .databank 0

      rlProcUnknown9EC70BCycle ; 9E/C775
      
        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/C776

    .endsection Unsorted9EC70BSection


    .section Unsorted9EC776Section

      .al
      .xl

      rlProcUnknown9EC70BCycle2 ; 9E/C776

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlUnknown9E838B
        jsl rlUnknown9E88F9
        lda #(`rlUnknown81841B)<<8
        sta $15E5,b
        lda #<>rlUnknown81841B
        sta $15E4,b
        lda #<>rlUnknown9EC79B
        sta aProcSystem.aHeaderOnCycle,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/C79B

    .endsection Unsorted9EC776Section


    .section Unsorted9EC79BSection

      .al
      .xl

      rlUnknown9EC79B ; 9E/C79B

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        and #$00FF
        bne _C7B2
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$C7B2
        sta aProcSystem.aHeaderOnCycle,b,x

        _C7B2
        rtl

        .databank 0

        ; 9E/C7B3

    .endsection Unsorted9EC79BSection


    .section Unsorted9EC7B3Section

      .al
      .xl

      rlProcUnknown9EC70BCycle3 ; 9E/C7B3

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$FFFF
        sta $7F45A4
        sta $7F45A6
        sta $7F45A8
        sta $7F45AA
        jsl rlUnknown9E88CE
        jsl rlUnknown9E87A4
        lda #$0000
        jsl rlUnknown9E8867
        lda aActionStructUnit2
        cmp #$FFFF
        beq _C7F1
        jsl rlUnknown9E87CA
        lda #$0001
        jsl rlUnknown9E8867

        _C7F1
        lda #<>rlUnknown9EC79B
        sta aProcSystem.aHeaderOnCycle,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/C7FA

      rlUnknown9EC7FA ; 9E/C7FA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda aMapAction.wYTilePosition
        cmp aMapAction.wUnknown7F4558
        bne _C812
        lda aMapAction.wXTilePosition
        cmp aMapAction.wUnknown7F4556
        bcc _C814
        bra _C821


        _C812
        bcc _C821

        _C814
        jsl rlUnknown9E8B34
        lda #$0001
        jsl rlUnknown9EADD1
        bra _C82C


        _C821
        jsl rlUnknown9E89F1
        lda #$0000
        jsl rlUnknown9EADD1

        _C82C
        jsl rlUnknown808875
        plx
        ply
        rtl

        .databank 0

        ; 9E/C833

      rlUnknown9EC833 ; 9E/C833

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda aMapAction.wYTilePosition
        cmp aMapAction.wUnknown7F4558
        bne _C84B
        lda aMapAction.wXTilePosition
        cmp aMapAction.wUnknown7F4556
        bcc _C84D
        bra _C85A


        _C84B
        bcc _C85A

        _C84D
        jsl rlUnknown9E89F1
        lda #$0000
        jsl rlUnknown9EADD1
        bra _C865


        _C85A
        jsl rlUnknown9E8B34
        lda #$0001
        jsl rlUnknown9EADD1

        _C865
        plx
        ply
        rtl

        .databank 0

        ; 9E/C868

      rlProcUnknown9EC70BCycle6 ; 9E/C868

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta $7F4580
        sta $7F4582
        sta $7F4584
        sta $7F5091
        sta $7F5093
        sta $7F45A2
        sta $7F45CC
        sta $7F45CE
        sta aProcSystem.aHeaderBitfield,b,x
        plx
        ply
        lda #<>rlUnknown9EC899
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/C899

    .endsection Unsorted9EC7B3Section


    .section Unsorted9EC899Section

      .al
      .xl

      rlUnknown9EC899 ; 9E/C899

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F4584
        beq _C8A5
        lda #<>rlUnknown9EC8A6
        sta aProcSystem.aHeaderOnCycle,b,x

        _C8A5
        rtl

        .databank 0

        ; 9E/C8A6

      rlUnknown9EC8A6 ; 9E/C8A6

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F4584
        bne _C8B2
        lda #<>rlUnknown9EC8B3
        sta aProcSystem.aHeaderOnCycle,b,x

        _C8B2
        rtl

        .databank 0

        ; 9E/C8B3

    .endsection Unsorted9EC899Section


    .section Unsorted9EC8B3Section

      .al
      .xl

      rlUnknown9EC8B3 ; 9E/C8B3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aBattleRoundsData)<<8
        sta lStructPointer2+1,b
        lda #<>aBattleRoundsData
        sta lStructPointer2,b
        lda aProcSystem.aBody4,b,x
        sta wStructIndex,b
        jsl rlLoadRAMStructDataByIndex
        lda lStructPointer1,b
        sta aProcSystem.aBody5,b,x
        sta $7F4C2F
        inc aProcSystem.aBody4,b,x
        lda aProcSystem.aBody4,b,x
        sta wStructIndex,b
        jsl rlLoadRAMStructDataByIndex
        lda lStructPointer1,b
        sta aProcSystem.aBody5,b,x
        cmp #$FFFF
        beq _C907
        cmp #$7F00
        bne _C8F7
        lda #$0001
        sta $7F4C07

        _C8F7
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl


        _C907
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        rtl

        .databank 0

        ; 9E/C91A

    .endsection Unsorted9EC8B3Section


    .section Unsorted9EC91ASection

      .al
      .xl

      rlUnknown9EC91A ; 9E/C91A

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7E4ECF
        beq _C943
        jsl rlUnknown9EA140
        jsl rlUnknown85D385
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _C943
        rtl

        .databank 0

        ; 9E/C944

      rlUnknown9EC944 ; 9E/C944

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85D3F5
        cmp #$FFFF
        beq _C956
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _C956
        rtl

        .databank 0

        ; 9E/C957

      rlProcUnknown9EC70BCycle12 ; 9E/C957

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$CE9E
        sta aProcSystem.aHeaderCodeOffset,b,x
        lda #$0001
        sta aProcSystem.aHeaderSleepTimer,b,x
        jsl rlUnknown9E8FB3
        jsl rlUnknown888197
        phb
        jsl rlUnknown8881A7
        plb
        .databank ?
        lda wBattleType
        and #$00FF
        cmp #$0003
        bne _C982
        jsl rlUnknown8A8F68

        _C982
        plx
        lda #<>rlUnknown9EC98A
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/C98A

    .endsection Unsorted9EC91ASection


    .section Unsorted9EC98ASection

      .al
      .xl

      rlUnknown9EC98A ; 9E/C98A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7E4EA9
        and #$00FF
        cmp #$0003
        beq _C9A4
        jsl rlUnknown88C355
        bcc _C9A4
        lda #<>rlUnknown9EC9AB
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _C9AA


        _C9A4
        lda #<>rlUnknown9EC9BD
        sta aProcSystem.aHeaderOnCycle,b,x

        _C9AA
        rtl

        .databank 0

        ; 9E/C9AB

      rlUnknown9EC9AB ; 9E/C9AB

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown88C2BA
        bcc _C9BB
        plx
        lda #<>rlUnknown9EC9BD
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _C9BC


        _C9BB
        plx

        _C9BC
        rtl

        .databank 0

        ; 9E/C9BD

      rlUnknown9EC9BD ; 9E/C9BD

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85D414
        lda #<>rlUnknown9EC9C8
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/C9C8

      rlUnknown9EC9C8 ; 9E/C9C8

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85D648
        lda #<>rlUnknown9EC9D3
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/C9D3

      rlUnknown9EC9D3 ; 9E/C9D3

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85D671
        bcs _C9FC
        lda $7F4C87
        bne _C9E3
        jsl rlUnknown81B189

        _C9E3
        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        jsl rlUnknown9EA1D7
        jsl rlProcEngineFreeProc
        lda $7F4C07
        ora #$0002
        sta $7F4C07

        _C9FC
        rtl

        .databank 0

        ; 9E/C9FD

    .endsection Unsorted9EC98ASection


    .section Unsorted9EC9FDSection

      .al
      .xl

      rlUnknown9EC9FD ; 9E/C9FD

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9F84DD
        jsl rlUnknown9F850B
        jsl rlUnknown9F8575
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/CA10

      rlProcUnknown9EC70BCycle4 ; 9E/CA10

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85D65A
        bcc _CA17
        rtl


        _CA17
        lda aActionStructUnit2
        cmp #$FFFF
        beq _CA34
        lda $7F4C87
        bne _CA34
        jsl rlUnknown9EAB5D
        bcs _CA34
        jsl rlUnknown85D5CC
        jsl rlUnknown85D066

        _CA34
        lda #$CA3A
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/CA3B

      rlUnknown9ECA3B ; 9E/CA3B

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        rtl

        .databank 0

        ; 9E/CA45

      rlUnknown9ECA45 ; 9E/CA45

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85D65A
        bcc _CA4C
        rtl


        _CA4C
        jsl rlUnknown85D5CC
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$CA5F
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/CA60

      rlUnknown9ECA60 ; 9E/CA60

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda aActionStructUnit2
        cmp #$FFFF
        beq _CA9A
        jsl rlUnknown9EAB5D
        bcs _CA9A
        lda aProcSystem.aBody5,b,x
        cmp #$FFFF
        bne _CA94
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _CA9A


        _CA94
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x

        _CA9A
        rtl

        .databank 0

        ; 9E/CA9B

      rlProcUnknown9EC70BCycle7 ; 9E/CA9B

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F4C87
        bne _CAB4
        jsl rlUnknown9EAB5D
        bcs _CAB4
        jsl rlUnknown85D41E
        cmp #$FFFF
        beq _CABA
        jsl rlUnknown85D648

        _CAB4
        lda #<>rlUnknown9ECABB
        sta aProcSystem.aHeaderOnCycle,b,x

        _CABA
        rtl

        .databank 0

        ; 9E/CABB

    .endsection Unsorted9EC9FDSection


    .section Unsorted9ECABBSection

      .al
      .xl

      rlUnknown9ECABB ; 9E/CABB

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85D671
        bcs _CAD0
        lda #<>rlUnknown9ECAD1
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _CAD0
        rtl

        .databank 0

        ; 9E/CAD1

      rlUnknown9ECAD1 ; 9E/CAD1

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/CAD2

    .endsection Unsorted9ECABBSection


    .section ProcScript9ECAD2Section

      .al
      .xl

      aProcUnknown9EC70BCode ; 9E/CAD2

        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown9EC70BCycle2
        _CAD8
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CAD8, $0001
        PROC_SET_ONCYCLE rlProcUnknown9EC70BCycle3
        _CAE4
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CAE4, $0001
        PROC_CALL rlUnknown9EA75D
        PROC_JUMP_IF_BITS_UNSET _CB04, $0002
        _CAF7
        PROC_YIELD 1
        PROC_CALL rlUnknown9EA89F
        PROC_JUMP_IF_BITS_UNSET _CAF7, $0004
        _CB04
        PROC_CALL rlUnknown9E99F7
        PROC_YIELD 4
        PROC_CALL rlUnknown9EC7FA
        PROC_YIELD 12
        PROC_CALL rlUnknown9EC833
        PROC_YIELD 12
        PROC_CALL rlUnknown9EA096
        PROC_JUMP_IF_BITS_UNSET _CB52, $0002
        _CB24
        PROC_YIELD 1
        PROC_CALL rlUnknown9EA122
        PROC_CALL rlUnknown9EA129
        PROC_JUMP_IF_BITS_UNSET _CB24, $0004
        PROC_CALL rlUnknown9EA155
        PROC_YIELD 18
        PROC_CALL rlUnknown9EA174
        PROC_YIELD 4
        PROC_CALL rlUnknown9EA195
        PROC_YIELD 4
        PROC_CALL rlUnknown9EA1B6
        PROC_YIELD 4
        _CB52
        PROC_CALL rlUnknown9EAE22
        PROC_JUMP_IF_BITS_UNSET _CB6A, $0002
        _CB5D
        PROC_YIELD 1
        PROC_CALL rlUnknown9EAE5A
        PROC_JUMP_IF_BITS_UNSET _CB5D, $0004
        _CB6A
        PROC_SET_ONCYCLE rlProcUnknown9EC70BCycle4
        PROC_YIELD 48
        _CB70
        PROC_CALL rlUnknown9EA2F8
        PROC_CALL rlUnknown9EA238
        PROC_JUMP_IF_BITS_UNSET _CC6C, $0002
        PROC_CALL rlUnknown9EA9B5
        PROC_JUMP_IF_BITS_UNSET _CBA7, $0002
        PROC_SET_UNK_TIMER 96
        _CB8F
        PROC_YIELD 1
        PROC_CALL rlUnknown96D695
        PROC_JUMP_WHILE_UNK_TIMER _CB8F
        PROC_CALL rlUnknown9EAB21
        PROC_JUMP_IF_BITS_SET _CB70, $0002
        PROC_YIELD 16
        _CBA7
        PROC_CALL rlUnknown9ED742
        PROC_JUMP_IF_BITS_UNSET _CBBF, $0002
        _CBB2
        PROC_YIELD 1
        PROC_CALL rlUnknown9ED775
        PROC_JUMP_IF_BITS_UNSET _CBB2, $0004
        _CBBF
        PROC_CALL rlUnknown9E8C81
        PROC_CALL rlUnknown9F8900
        PROC_JUMP_IF_BITS_UNSET _CC15, $0002
        PROC_SET_ONCYCLE rlUnknown9EC9FD
        PROC_YIELD 16
        PROC_CALL rlUnknown9F85A3
        PROC_YIELD 2
        PROC_CALL rlUnknown9F85CC
        PROC_YIELD 2
        PROC_CALL rlUnknown9F85F5
        PROC_YIELD 2
        PROC_CALL rlUnknown9F861F
        PROC_YIELD 2
        PROC_CALL rlUnknown9F86BF
        PROC_JUMP_IF_BITS_UNSET _CC10, $0002
        _CBFC
        PROC_YIELD 1
        PROC_CALL rlUnknown9F86B0
        PROC_JUMP_IF_BITS_UNSET _CBFC, $0001
        PROC_CALL rlUnknown9F8677
        PROC_YIELD 2
        _CC10
        PROC_CALL rlUnknown9F8020
        _CC15
        PROC_SET_ONCYCLE rlProcUnknown9EC70BCycle6
        PROC_YIELD 1
        PROC_CALL rlUnknown9E82AA
        _CC20
        PROC_YIELD 1
        PROC_CALL rlUnknown9E9025
        PROC_JUMP_IF_BITS_UNSET _CC20, $0002
        PROC_SET_UNK_TIMER 16
        _CC31
        PROC_YIELD 1
        PROC_CALL rlUnknown9E9025
        PROC_JUMP_WHILE_UNK_TIMER _CC31
        PROC_CALL rlUnknown9EAF44
        PROC_JUMP_IF_BITS_UNSET _CC54, $0002
        _CC47
        PROC_YIELD 1
        PROC_CALL rlUnknown9EAF79
        PROC_JUMP_IF_BITS_UNSET _CC47, $0004
        _CC54
        PROC_CALL rlUnknown9EA8BA
        PROC_JUMP_IF_BITS_UNSET _CC6C, $0002
        _CC5F
        PROC_YIELD 1
        PROC_CALL rlUnknown9EA9A5
        PROC_JUMP_IF_BITS_UNSET _CC5F, $0004
        _CC6C
        PROC_CALL rlUnknown9F8349
        PROC_CALL rlUnknown9F8473
        PROC_CALL rlUnknown9ECA60
        PROC_JUMP_IF_BITS_UNSET _CC98, $0002
        PROC_YIELD 40
        PROC_CALL rlUnknown85D414
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown9EC70BCycle7
        _CC8E
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CC8E, $0004
        PROC_YIELD 1
        _CC98
        PROC_CALL rlUnknown9EA0B9
        PROC_JUMP_IF_BITS_UNSET _CCE4, $0002
        PROC_YIELD 2
        PROC_CALL rlUnknown888197
        PROC_CALL rlUnknown9E99F7
        PROC_CALL rlUnknown8881A7
        PROC_YIELD 2
        _CCB6
        PROC_YIELD 1
        PROC_CALL rlUnknown9EA122
        PROC_CALL rlUnknown9EA129
        PROC_JUMP_IF_BITS_UNSET _CCB6, $0004
        PROC_CALL rlUnknown9EA155
        PROC_YIELD 18
        PROC_CALL rlUnknown9EA174
        PROC_YIELD 4
        PROC_CALL rlUnknown9EA195
        PROC_YIELD 4
        PROC_CALL rlUnknown9EA1B6
        PROC_YIELD 4
        _CCE4
        PROC_CALL rlUnknown9E9F71
        PROC_JUMP_IF_BITS_UNSET _CCFD, $0002
        _CCEF
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown9EC70BCycle8
        PROC_JUMP_IF_BITS_UNSET _CCEF, $0004
        PROC_YIELD 1
        _CCFD
        PROC_CALL rlUnknown9EF1B5
        _CD02
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_SET _CD02, $0004
        PROC_CALL rlUnknown9EA0E0
        PROC_JUMP_IF_BITS_UNSET _CD4D, $0002
        PROC_CALL rlUnknown888197
        PROC_CALL rlUnknown8881A7
        _CD1F
        PROC_YIELD 1
        PROC_CALL rlUnknown9EA122
        PROC_CALL rlUnknown9EA129
        PROC_JUMP_IF_BITS_UNSET _CD1F, $0004
        PROC_CALL rlUnknown9EA155
        PROC_YIELD 18
        PROC_CALL rlUnknown9EA174
        PROC_YIELD 4
        PROC_CALL rlUnknown9EA195
        PROC_YIELD 4
        PROC_CALL rlUnknown9EA1B6
        PROC_YIELD 4
        _CD4D
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CB70, $0001
        PROC_CALL rlUnknown9EAE22
        PROC_JUMP_IF_BITS_UNSET _CD6D, $0002
        _CD60
        PROC_YIELD 1
        PROC_CALL rlUnknown9EAECF
        PROC_JUMP_IF_BITS_UNSET _CD60, $0004
        _CD6D
        PROC_CALL rlUnknown9ECA3B
        PROC_SET_ONCYCLE rlUnknown9ECA45
        _CD76
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CD76, $0004
        PROC_YIELD 4
        PROC_CALL rlUnknown9ECEA0
        PROC_JUMP_IF_BITS_UNSET _CE88, $0004
        PROC_CALL rlUnknown9EC91A
        PROC_JUMP_IF_BITS_UNSET _CDA5, $0002
        _CD96
        PROC_YIELD 1
        PROC_CALL rlUnknown9EC944
        PROC_JUMP_IF_BITS_UNSET _CD96, $0004
        PROC_YIELD 1
        _CDA5
        PROC_CALL rlUnknown9E9342
        PROC_JUMP_IF_BITS_UNSET _CDD0, $0002
        PROC_CALL rlUnknown9EB3F3
        PROC_JUMP_IF_BITS_UNSET _CDC2, $0004
        PROC_YIELD 16
        PROC_CALL $9EB4A9
        _CDC2
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlUnknown9E936B
        PROC_JUMP_IF_BITS_UNSET _CDC2, $0004
        PROC_YIELD 105
        _CDD0
        PROC_CALL rlUnknown9E952D
        PROC_JUMP_IF_BITS_UNSET _CDE9, $0002
        PROC_SET_ONCYCLE rlUnknown9E95AB
        _CDDF
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CDDF, $0004
        PROC_YIELD 8
        _CDE9
        PROC_CALL rlUnknown9E9928
        PROC_JUMP_IF_BITS_UNSET _CE0F, $0002
        PROC_CALL rlUnknown9EB3F3
        PROC_JUMP_IF_BITS_UNSET _CE01, $0004
        PROC_YIELD 16
        _CE01
        PROC_CALL rlUnknown9EB491
        PROC_YIELD 117
        PROC_CALL rlUnknown85DB91
        PROC_YIELD 8
        _CE0F
        PROC_CALL rlUnknown9E9967
        PROC_JUMP_IF_BITS_UNSET _CE35, $0002
        PROC_CALL rlUnknown9EB3F3
        PROC_JUMP_IF_BITS_UNSET _CE27, $0004
        PROC_YIELD 16
        _CE27
        PROC_CALL $9EB497
        PROC_YIELD 133
        PROC_CALL rlUnknown85DB91
        PROC_YIELD 8
        _CE35
        PROC_CALL rlUnknown9E985E
        PROC_JUMP_IF_BITS_UNSET _CE5B, $0002
        PROC_CALL rlUnknown9EB3F3
        PROC_JUMP_IF_BITS_UNSET _CE4D, $0004
        PROC_YIELD 16
        _CE4D
        PROC_CALL $9EB49D
        PROC_YIELD 117
        PROC_CALL rlUnknown85DB91
        PROC_YIELD 8
        _CE5B
        PROC_CALL rlUnknown9E98C4
        PROC_JUMP_IF_BITS_UNSET _CE81, $0002
        PROC_CALL rlUnknown9EB3F3
        PROC_JUMP_IF_BITS_UNSET _CE73, $0004
        PROC_YIELD 16
        _CE73
        PROC_CALL $9EB4A3
        PROC_YIELD 133
        PROC_CALL rlUnknown85DB91
        PROC_YIELD 8
        _CE81
        PROC_CALL rlUnknown9EB41C
        PROC_YIELD 16
        _CE88
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown9EC70BCycle12
        PROC_YIELD 1
        _CE90
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_SET _CE90, $0001
        _CE98
        PROC_YIELD 1
        PROC_JUMP _CE98


        ; 9E/CE9E

    .endsection ProcScript9ECAD2Section


    .section Unsorted9ECEA0Section

      .al
      .xl

      rlUnknown9ECEA0 ; 9E/CEA0

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4C87
        bne _CEB8
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _CEB8
        rtl

        .databank 0

        ; 9E/CEB9

    .endsection Unsorted9ECEA0Section


    .section ProcScript9ECEDDSection

      .al
      .xl

      procUnknown9ECEDD ; 9E/CEDD

        .structProcInfo "ON", rlProcUnknown9ECEDDInit, rlProcUnknown9ECEDDCycle1, aProcUnknown9ECEDDCode

    .endsection ProcScript9ECEDDSection


    .section Unsorted9ECEE5Section

      .al
      .xl

      rlProcUnknown9ECEDDInit ; 9E/CEE5

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #$FFFF
        sta aActionStructUnit2
        lda aProcSystem.wInput0,b
        sta wR4
        sta wR6
        sta aMapAction.wXTilePosition
        lda aProcSystem.wInput1,b
        sta wR5
        sta wR7
        sta aMapAction.wYTilePosition
        ldx aProcSystem.wInput0,b
        ldy aProcSystem.wInput1,b
        lda aActionStructUnit1.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda wR1
        jsl rlUnknown9EAC49
        lda wR1
        xba
        ora wR0
        sta $7F509B
        lda aProcSystem.wInput3,b
        asl a
        tax
        lda aUnknown9ECF72,x
        sec
        sbc #$003E
        sta $7F5089
        plx
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        sta $7F5091
        sta $7F5093
        sta $7F4C07
        lda wGameStateRoutine1,b
        sta aProcSystem.aBody7,b,x
        stz wGameStateRoutine1,b
        sep #$20
        lda bBufferBG2SC
        sta $7F57EA
        lda #$5C
        sta bBufferBG2SC
        lda bBufferTM
        sta $7F57EC
        lda #$15
        sta bBufferTM
        rep #$20
        ply
        rtl

        .databank 0

        ; 9E/CF72

    .endsection Unsorted9ECEE5Section


    .section Table9ECF72Section

      .al
      .xl

      aUnknown9ECF72 ; 9E/CF72

        ; Read by rlProcUnknown9ECEDDInit.

        .word $0058, $0058, $005A, $0058

        ; 9E/CF7A

    .endsection Table9ECF72Section


    .section Unsorted9ECF7ASection

      .al
      .xl

      rlProcUnknown9ECEDDCycle1 ; 9E/CF7A

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/CF7B

    .endsection Unsorted9ECF7ASection


    .section ProcScript9ECF7BSection

      .al
      .xl

      aProcUnknown9ECEDDCode ; 9E/CF7B

        PROC_YIELD 1
        PROC_SET_ONCYCLE rlUnknown9EC9FD
        PROC_YIELD 16
        PROC_CALL rlUnknown9F85A3
        PROC_YIELD 2
        PROC_CALL rlUnknown9F85CC
        PROC_YIELD 2
        PROC_CALL rlUnknown9F85F5
        PROC_YIELD 2
        PROC_CALL rlUnknown9F861F
        PROC_YIELD 2
        PROC_CALL rlUnknown9F8020
        PROC_YIELD 16
        PROC_CALL rlUnknown9ECFCD
        _CFAB
        PROC_YIELD 1
        PROC_CALL rlUnknown9ECFD5
        PROC_JUMP_IF_BITS_UNSET _CFAB, $0004
        PROC_CALL rlUnknown9F8349
        PROC_CALL rlUnknown9F8473
        PROC_YIELD 1
        PROC_CALL rlUnknown9ECFEB
        PROC_YIELD 1
        PROC_END


        ; 9E/CFCD

    .endsection ProcScript9ECF7BSection


    .section Unsorted9ECFCDSection

      .al
      .xl

      rlUnknown9ECFCD ; 9E/CFCD

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta $7F5091
        rtl

        .databank 0

        ; 9E/CFD5

      rlUnknown9ECFD5 ; 9E/CFD5

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5093
        beq _CFEA
        lda #<>rlProcUnknown9ECEDDCycle1
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _CFEA
        rtl

        .databank 0

        ; 9E/CFEB

      rlUnknown9ECFEB ; 9E/CFEB

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda $7F57EA
        sta bBufferBG2SC
        lda $7F57EC
        sta bBufferTM
        sta $7F57EC
        rep #$20
        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        rtl

        .databank 0

        ; 9E/D006

    .endsection Unsorted9ECFCDSection


    .section Unsorted9ED07ASection

      .al
      .xl

      rlUnknown9ED07A ; 9E/D07A

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown9ED089)<<8
        sta lR44+1
        lda #<>procUnknown9ED089
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/D089

    .endsection Unsorted9ED07ASection


    .section Unsorted9ED089Section

      .al
      .xl

      procUnknown9ED089 ; 9E/D089

        .structProcInfo "ON", rlProcUnknown9ED089Init, $9ED2B5, $9ED1F4

      rlProcUnknown9ED089Init ; 9E/D091

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0000
        sta $4580,b
        sta $4582,b
        sta $4584,b
        sta aMapAction.wUnknown7F455A
        sta $7F4572
        sta $7F4C87
        sta $7F5091
        sta $7F5093
        sta $4C11,b
        sta $4C13,b
        sta $7F4C07
        lda $7E4EA9
        sta aActionStructUnit1
        sta aActionStructUnit2
        lda $7E4EAF
        sta @l wR0
        lda aActionStructUnit1.CharacterID
        sta @l wR1
        lda aActionStructUnit1.UnitRAMPointer
        sta @l wR2
        jsl rlUnknown9E85A4
        sta $454E,b
        lda wBattleDistance
        sta $4552,b
        lda wBattleQuotePointer
        sta $4554,b
        lda #$FFFF
        jsl rlUnknown9E866F
        sta $454A,b
        lda #$FFFF
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta $4550,b
        sta $4556,b
        sta $4558,b
        sta $454C,b
        lda #$0006
        sta $455E,b
        sta $4560,b
        lda #$001F
        sta $5089,b
        plb
        .databank ?
        lda aMapAction.wYTilePosition
        tay
        lda aMapAction.wXTilePosition
        tax
        jsl rlUnknown9E8D25
        lda #$8000
        sta $7F508F
        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1
        lda wR1
        xba
        ora wR0
        sta $7F5099
        sta $7F509B
        lda #$8100
        sta @l $0015E5
        lda #$841B
        sta @l $0015E4
        lda @l aActiveSpriteSystem
        sta $7F4BD9
        lda @l aActiveSpriteSystem
        ora #$4000
        sta @l aActiveSpriteSystem
        plx
        lda @l $000302
        sta @l $0010B7,x
        stz wGameStateRoutine1,b
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7E4EAF
        sta aActionStructUnit1.ClassID
        jsl rlUnknown88CD53
        jsl rlUnknown88CD61
        ply
        rtl

        .databank 0

    .endsection Unsorted9ED089Section


    .section Unsorted9ED1A1Section

      .al
      .xl

      rlProcUnknown9EAF98Cycle2 ; 9E/D1A1

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F5091
        beq _D1AD
        lda #$D1BB
        sta aProcSystem.aHeaderOnCycle,b,x

        _D1AD
        lda $7F4580
        beq _D1BA
        lda #$0000
        sta $7F4580

        _D1BA
        rtl

        .databank 0

        ; 9E/D1BB

    .endsection Unsorted9ED1A1Section


    .section Unsorted9ED2B5Section

      .al
      .xl

      rlUnknown9ED2B5 ; 9E/D2B5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda @l aMapAction.wUnknown7F455E
        asl a
        clc
        adc @l aMapAction.wUnknown7F455E
        asl a
        sta wR0
        lda @l aMapAction.wBattleClassID
        sta wR10
        lda #$0031
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        clc
        adc wR0
        adc #$0003
        tax
        lda $9EB50E,x
        sta lR18+1
        lda aBattleMapSpriteData,x
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$0000
        sta lR19
        plp
        plb
        .databank $7F
        jsl rlAppendDecompList
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        lda #(`gcUnknownACCC17)<<8
        sta lR18+1
        lda #<>gcUnknownACCC17
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$4000
        sta lR19
        plp
        plb
        .databank $7F
        jsl rlAppendDecompList
        ply
        plx
        lda #$D1F3
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/D337

    .endsection Unsorted9ED2B5Section


    .section Unsorted9ED337Section

      .al
      .xl

      rlUnknown9ED337 ; 9E/D337

        .al
        .autsiz
        .databank ?

        phy
        phx
        lda #0
        sta $7F4580
        sta $7F4582
        sta $7F4584
        sta $7F5091
        sta aProcSystem.aHeaderBitfield,b,x

        lda #$FFFF
        sta $7F45A4
        sta $7F45A6
        jsl rlUnknown9E88CE
        jsl rlUnknown9E87A4
        lda #0
        jsl rlUnknown9E8867
        plx
        lda #$D1F3
        sta aProcSystem.aHeaderOnCycle,b,x
        ply
        rtl

        .databank 0

        ; 9E/D372

    .endsection Unsorted9ED337Section


    .section Unsorted9ED372Section

      .al
      .xl

      rlUnknown9ED372 ; 9E/D372

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        phy
        phx
        lda #$0000
        sta @l $7F4580
        sta @l $7F4582
        sta @l $7F4584
        sta @l $000F37,x
        lda #$0001
        sta $5091,b
        lda $4599,b
        sta $458A,b
        sta $4587,b
        lda $4598,b
        sta lR18
        lda $4599,b
        sta lR18+1
        lda @l aMapAction.wUnknown7F455E
        sta wR0
        lda #$0000
        jsr rsUnknown9E832C
        stx $4589,b
        sty $4586,b
        plx
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/D3C1

    .endsection Unsorted9ED372Section


    .section Unsorted9ED3C1Section

      .al
      .xl

      rlUnknown9ED3C1 ; 9E/D3C1

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F45A4
        tax
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda $7F45A6
        tax
        cpx #$FFFF
        beq _D3D7
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _D3D7
        lda #$0001
        sta $7F4584
        jsl rlUnknown88CD4C
        jsl rlUnknown88CD5A
        plx
        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        lda #(`rlPushToOAMBuffer)<<8
        sta $15E5,b
        lda #<>rlPushToOAMBuffer
        sta $15E4,b
        lda $7F4BD9
        sta aActiveSpriteSystem,b
        rtl

        .databank 0

        ; 9E/D401

    .endsection Unsorted9ED3C1Section


    .section Unsorted9ED401Section

      .al
      .xl

      rlUnknown9ED401 ; 9E/D401

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F45A4
        sta $7F45A8
        lda $7F45A6
        sta $7F45AA
        rtl

        .databank 0

        ; 9E/D412

    .endsection Unsorted9ED401Section


    .section Unsorted9ED42ASection

      .al
      .xl

      rlUnknown9ED42A ; 9E/D42A

        .al
        .autsiz
        .databank ?

        jsl rlClearBattleData
        jsl rlUnknown9ED5A1

        lda #(`procUnknown9ED441)<<8
        sta lR44+1
        lda #<>procUnknown9ED441
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      procUnknown9ED441 .structProcInfo "ON", rlProcUnknown9ED441Init, rlProcUnknown9ED441Cycle1, aProcUnknown9ED441Code ; 9E/D441

    .endsection Unsorted9ED42ASection


    .section Unsorted9ED449Section

      .al
      .xl

      rlProcUnknown9ED441Init ; 9E/D449

        .al
        .autsiz
        .databank ?

        phy
        phx
        phb
        pea $7F00
        plb
        plb

        lda #0
        sta $7F4580
        sta $7F4582
        sta $7F4584
        sta aMapAction.wUnknown7F455A
        sta $7F4572
        sta $7F4C87
        sta $7F4BE9
        sta $7F4C07
        sta $4C11,b
        sta $4C13,b

        lda #$FFFF
        sta $7F45A4
        sta $7F45A6
        sta $7F45A8
        sta $7F45AA

        lda aActionStructUnit1.ClassID
        sta @l wR0
        lda aActionStructUnit1.Gender
        sta @l wR1
        lda aActionStructUnit1.CharacterID
        sta @l wR2
        jsl rlUnknown9E85A4
        sta $454E,b
        lda aActionStructUnit1.XPosition
        sta $4552,b
        lda aActionStructUnit1.YPosition
        sta $4554,b

        lda #$FFFF
        jsl rlUnknown9E866F
        sta $454A,b

        lda #$FFFF
        sta aActionStructUnit1.WeaponID

        lda #0
        sta $4550,b
        sta $4556,b
        sta $4558,b
        sta $454C,b

        lda #$FFFF
        sta aActionStructUnit2.DeploymentNumber

        lda #6
        sta $455E,b
        sta $4560,b

        lda #0
        sta $508F,b
        sta $459E,b
        sta $7E4F85

        lda #5
        sta $4BF3,b

        plb
        lda #(`rlUnknown81841B)<<8
        sta $0015E4+1
        lda #<>rlUnknown81841B
        sta $0015E4
        plx

        lda $000302
        sta aProcSystem.aBody7,x
        stz wGameStateRoutine1,b

        lda #0
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlUnknown88CD53
        jsl rlUnknown88CD61
        ply
        rtl

        .databank 0

        ; 9E/D528

    .endsection Unsorted9ED449Section


    .section Unsorted9ED535Section

      .al
      .xl

      rlProcUnknown9ED441Cycle2 ; 9E/D535

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aProcUnknown9ED441Code ; 9E/D536

        -
        PROC_YIELD 1
        PROC_CALL rlUnknown9F86B0
        PROC_JUMP_IF_BITS_UNSET -, $0001

        PROC_SET_ONCYCLE rlProcUnknown9ED441Cycle3
        PROC_YIELD 40
        PROC_CALL rlUnknown9E99F7
        PROC_YIELD 4
        PROC_CALL rlUnknown9E9D3B
        PROC_YIELD 4
        PROC_CALL rlUnknown9E9D76
        PROC_YIELD 4
        PROC_CALL rlUnknown9E89F1
        PROC_YIELD 2
        PROC_CALL rlUnknown9ED6BA
        PROC_YIELD 1
        PROC_CALL rlUnknown9EA9B5
        PROC_SET_UNK_TIMER 96

        -
        PROC_YIELD 1
        PROC_CALL rlUnknown96D695
        PROC_JUMP_WHILE_UNK_TIMER -

        PROC_CALL rlUnknown9EAB21
        PROC_YIELD 16
        PROC_CALL rlUnknown9ED6D6
        PROC_CALL rlUnknown888197
        PROC_YIELD 4
        PROC_CALL rlUnknown8881A7
        PROC_YIELD 1
        PROC_CALL rlUnknown9ED71E
        PROC_END

      rlUnknown9ED5A1 ; 9E/D5A1

        .al
        .autsiz
        .databank ?

        phx
        lda wEventUnitSlot1ID,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit1.DeploymentNumber
        jsl rlGetSelectedUnitClassID
        sta aActionStructUnit1.ClassID
        jsl rlGetSelectedUnitGender
        sta aActionStructUnit1.Gender
        jsl rlGetSelectedUnitCharacterID
        sta aActionStructUnit1.CharacterID
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._XTilePosition,x
        sta aActionStructUnit1.XPosition
        lda aDeploymentTable._YTilePosition,x
        sta aActionStructUnit1.YPosition
        jsl rlGetFirstEquippableWeaponInInventory

        ldx wCurrentItemDataROMPointer,b
        bne +

        lda #$FFFF
        bra ++

        +
        jsl rlGetItemIDByInventorySlot

        +
        sta aActionStructUnit1.WeaponID
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit1.DeploymentNumber
        tax
        lda aDeploymentTable._State,x
        and #DeploymentAllegianceMask
        sta aMapAction.wUnknown7F4562
        plx
        rtl

        .databank 0

    .endsection Unsorted9ED535Section


    .section Unsorted9ED609Section

      .al
      .xl

      rlProcUnknown9ED441Cycle1 ; 9E/D609

        .al
        .autsiz
        .databank ?

        phx
        phy
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda @l aMapAction.wUnknown7F455E
        asl a
        clc
        adc @l aMapAction.wUnknown7F455E
        asl a
        sta wR0

        lda @l aMapAction.wBattleClassID
        sta wR10
        lda #$0031
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        clc
        adc wR0
        adc #$0003
        tax
        lda aBattleMapSpriteData+1,x
        sta lR18+1
        lda aBattleMapSpriteData,x
        sta lR18

        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #0
        sta lR19
        plp
        plb
        jsl rlAppendDecompList
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda #(`gcUnknownACCC17)<<8
        sta lR18+1
        lda #<>gcUnknownACCC17
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$4000
        sta lR19
        plp
        plb
        jsl rlAppendDecompList
        ply
        plx
        lda #<>rlProcUnknown9ED441Cycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

    .endsection Unsorted9ED609Section


    .section Unsorted9ED68BSection

      .al
      .xl

      rlProcUnknown9ED441Cycle3 ; 9E/D68B

        .al
        .autsiz
        .databank ?

        phy
        phx
        lda #0
        sta $7F4584
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$FFFF
        sta $7F45A4
        sta $7F45A6
        jsl rlUnknown9E88CE
        jsl rlUnknown9E87A4
        lda #0
        jsl rlUnknown9E8867
        plx
        lda #<>rlProcUnknown9ED441Cycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        ply
        rtl

        .databank 0

        ; 9E/D6BA

    .endsection Unsorted9ED68BSection


    .section Unsorted9ED6BASection

      .al
      .xl

      rlUnknown9ED6BA ; 9E/D6BA

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        phy
        phx
        lda #$0000
        sta @l $7F4584
        sta @l $000F37,x
        plx
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/D6D6

      rlUnknown9ED6D6 ; 9E/D6D6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F45A4
        tax
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x
        lda $7F45A6
        tax
        cpx #$FFFF
        beq _D6F2
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x

        _D6F2
        lda #$0001
        sta $7F4584
        lda aActionStructUnit1
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive
        jsl rlUnknown88CD4C
        jsl rlUnknown88CD5A
        plx
        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        lda #(`rlPushToOAMBuffer)<<8
        sta $15E5,b
        lda #<>rlPushToOAMBuffer
        sta $15E4,b
        rtl

        .databank 0

        ; 9E/D71E

      rlUnknown9ED71E ; 9E/D71E

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F4C07
        ora #$0002
        sta $7F4C07
        rtl

        .databank 0

        ; 9E/D72A

    .endsection Unsorted9ED6BASection


    .section Unsorted9ED742Section

      .al
      .xl

      rlUnknown9ED742 ; 9E/D742

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4C0F
        beq _D773
        lda #(`procUnknown9ED78B)<<8
        sta lR44+1
        lda #<>procUnknown9ED78B
        sta lR44
        jsl rlProcEngineCreateProc
        sta $7F57F0
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _D773
        plx
        rtl

        .databank 0

        ; 9E/D775

      rlUnknown9ED775 ; 9E/D775

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F57F0
        jsl rlUnknown8280F8
        bcc _D789
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _D789
        plx
        rtl

        .databank 0

        ; 9E/D78B

    .endsection Unsorted9ED742Section


    .section ProcScript9ED78BSection

      .al
      .xl

      procUnknown9ED78B ; 9E/D78B

        .structProcInfo "ON", rlProcUnknown9ED78BInit, rlProcUnknown9ED78BCycle, aProcUnknown9ED78BCode

    .endsection ProcScript9ED78BSection


    .section Unsorted9ED793Section

      .al
      .xl

      rlProcUnknown9ED78BInit ; 9E/D793

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlUnknown9ED7B7
        rtl

        .databank 0

        ; 9E/D79E

      rlProcUnknown9ED78BCycle ; 9E/D79E

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/D79F

    .endsection Unsorted9ED793Section


    .section ProcScript9ED79FSection

      .al
      .xl

      aProcUnknown9ED78BCode ; 9E/D79F

        PROC_YIELD 16
        PROC_CALL rlUnknown9ED808
        _D7A6
        PROC_YIELD 1
        PROC_CALL rlUnknown9ED8B6
        PROC_JUMP_IF_BITS_UNSET _D7A6, $0004
        PROC_YIELD 14
        PROC_END


        ; 9E/D7B7

    .endsection ProcScript9ED79FSection


    .section Unsorted9ED7B7Section

      .al
      .xl

      rlUnknown9ED7B7 ; 9E/D7B7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$9F00
        sta lR18+1
        lda #$FC00
        sta lR18
        lda #$0400
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        sta wR1
        jsl rlDMAByPointer
        ldx #$001E

        _D7DB
        lda aUnknown9ED7E8,x
        sta aOAMPaletteBuffer.aPalette6,b,x
        dec x
        dec x
        bpl _D7DB
        plx
        rtl

        .databank 0

        ; 9E/D7E8

    .endsection Unsorted9ED7B7Section


    .section Table9ED7E8Section

      .al
      .xl

      aUnknown9ED7E8 ; 9E/D7E8

        ; Read by rlUnknown9ED7B7.

        .word $3800, $7FFF, $035F, $01BF, $0037, $0C8A, $0425, $7FBA
        .word $7E6E, $7C84, $30C4, $1421, $0000, $0000, $0000, $0000

        ; 9E/D808

    .endsection Table9ED7E8Section


    .section Unsorted9ED808Section

      .al
      .xl

      rlUnknown9ED808 ; 9E/D808

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F459E
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        bit #$0001
        beq _D839
        lda $7F4598
        sta $7F57EA
        lda $7F4599
        sta $7F57EC
        lda #$9E00
        sta $7F4599
        lda #$D900
        sta $7F4598
        bra _D857


        _D839
        lda $7F459B
        sta $7F57EA
        lda $7F459C
        sta $7F57EC
        lda #$9E00
        sta $7F459C
        lda #$D900
        sta $7F459B

        _D857
        lda aBattleRoundsData._Entry[0],x
        and #$0001
        eor #$0001
        sta $7F4576
        asl a
        asl a
        tax
        lda aMapAction.wYTilePosition,x
        tay
        lda aMapAction.wXTilePosition,x
        tax
        jsl rlUnknown9E8D25
        lda #$9E00
        sta lR44+1
        lda #$DAE0
        sta lR44
        lda #$DAE0
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta $7F57EE
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda $7F4576
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        jsl rlUnknown9EB39F
        plx
        ply
        rtl

        .databank 0

        ; 9E/D8B6

      rlUnknown9ED8B6 ; 9E/D8B6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F57EE
        tax
        lda aActiveSpriteSystem.aTypeOffset,b,x
        bne _D8FE
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F459E
        asl a
        tax
        lda aBattleRoundsData._Entry[0],x
        bit #$0001
        beq _D8EE
        lda $7F57EA
        sta $7F4598
        lda $7F57EC
        sta $7F4599
        bra _D8FE


        _D8EE
        lda $7F57EA
        sta $7F459B
        lda $7F57EC
        sta $7F459C

        _D8FE
        plx
        rtl

        .databank 0

        ; 9E/D900

    .endsection Unsorted9ED808Section


    .section Unsorted9EDAE7Section

      .al
      .xl

      rlUnknown9EDAE7 ; 9E/DAE7

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown9EDAF6)<<8
        sta lR44+1
        lda #<>procUnknown9EDAF6
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/DAF6

    .endsection Unsorted9EDAE7Section


    .section ProcScript9EDAF6Section

      .al
      .xl

      procUnknown9EDAF6 ; 9E/DAF6

        .structProcInfo "ON", rlProcUnknown9EDAF6Init, rlProcUnknown9EDAF6Cycle1, aProcUnknown9EDAF6Code

    .endsection ProcScript9EDAF6Section


    .section Unsorted9EDAFESection

      .al
      .xl

      rlProcUnknown9EDAF6Init ; 9E/DAFE

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0000
        sta $4580,b
        sta $4582,b
        sta $4584,b
        sta $455A,b
        sta $4572,b
        sta $4C87,b
        sta $4BE9,b
        sta $4BE7,b
        sta $4C11,b
        sta $4C13,b
        sta $4C05,b
        sta @l $000F37,x
        sta $7F4C07
        lda aActionStructUnit1.ClassID
        sta @l wR0
        lda aActionStructUnit1.Gender
        sta @l wR1
        lda aActionStructUnit1.CharacterID
        sta @l wR2
        jsl rlUnknown9E85A4
        sta $454E,b
        lda aActionStructUnit1.XPosition
        sta $4552,b
        lda aActionStructUnit1.YPosition
        sta $4554,b
        lda #$FFFF
        jsl rlUnknown9E866F
        sta $454A,b
        lda #$FFFF
        sta aActionStructUnit1.WeaponID
        lda aActionStructUnit2.ClassID
        sta @l wR0
        lda aActionStructUnit2.Gender
        sta @l wR1
        lda aActionStructUnit2.CharacterID
        sta @l wR2
        jsl rlUnknown9E85A4
        sta $4550,b
        lda aActionStructUnit2.XPosition
        sta $4556,b
        lda aActionStructUnit2.YPosition
        sta $4558,b
        lda #$FFFF
        jsl rlUnknown9E866F
        sta $454C,b
        lda #$FFFF
        sta aActionStructUnit2.WeaponID
        jsl rlUnknown9E805E
        lda $455E,b
        eor #$0004
        sta $4560,b
        lda wBattleType
        and #$00FF
        cmp #$0003
        bne _DBD7
        lda #$0006
        sta $455E,b
        sta $4560,b
        lda #$0000
        sta @l $000891

        _DBD7
        lda #$0000
        sta $508F,b
        sta $459E,b
        sta $7E4F85
        plb
        .databank ?
        lda #$8100
        sta @l $0015E5
        lda #$841B
        sta @l $0015E4
        plx
        lda @l $000302
        sta @l $0010B7,x
        stz wGameStateRoutine1,b
        jsl rlUnknown88CD53
        jsl rlUnknown88CD61
        ply
        rtl

        .databank 0

        ; 9E/DC09

      rlProcUnknown9EDAF6Cycle1 ; 9E/DC09

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown9E88F9
        lda #<>rlUnknown9EC79B
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/DC14

    .endsection Unsorted9EDAFESection


    .section ProcScript9EDC15Section

      .al
      .xl

      aProcUnknown9EDAF6Code ; 9E/DC15

        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET aProcUnknown9EDAF6Code, $0001
        PROC_YIELD 4
        PROC_SET_ONCYCLE rlProcUnknown9EDAF6Cycle2
        PROC_YIELD 32
        PROC_CALL rlUnknown9E99F7
        PROC_YIELD 2
        PROC_CALL rlUnknown9E89F1
        PROC_YIELD 2
        PROC_CALL rlUnknown9E8B34
        PROC_YIELD 2
        PROC_CALL rlUnknown9EDD14
        PROC_YIELD 32
        PROC_CALL rlUnknown9EDD97
        PROC_YIELD 4
        PROC_CALL rlUnknown9EDDE8
        _DC4D
        PROC_YIELD 1
        PROC_CALL rlUnknown9EDE60
        PROC_JUMP_IF_BITS_UNSET _DC4D, $0004
        PROC_YIELD 4
        PROC_SET_ONCYCLE rlUnknown9ECA45
        PROC_YIELD 48
        PROC_CALL rlUnknown9EC91A
        PROC_JUMP_IF_BITS_UNSET _DC7C, $0002
        _DC6D
        PROC_YIELD 1
        PROC_CALL rlUnknown9EC944
        PROC_JUMP_IF_BITS_UNSET _DC6D, $0004
        PROC_YIELD 1
        _DC7C
        PROC_CALL rlUnknown9E9342
        PROC_JUMP_IF_BITS_UNSET _DCA7, $0002
        PROC_CALL rlUnknown9EB3F3
        PROC_JUMP_IF_BITS_UNSET _DC99, $0004
        PROC_YIELD 16
        PROC_CALL $9EB4A9
        _DC99
        PROC_YIELD 1
        PROC_SET_ONCYCLE rlUnknown9E936B
        PROC_JUMP_IF_BITS_UNSET _DC99, $0004
        PROC_YIELD 116
        _DCA7
        PROC_CALL rlUnknown9E952D
        PROC_JUMP_IF_BITS_UNSET _DCC0, $0002
        PROC_SET_ONCYCLE rlUnknown9E95AB
        _DCB6
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _DCB6, $0004
        PROC_YIELD 8
        _DCC0
        PROC_CALL rlUnknown9EB41C
        PROC_YIELD 16
        PROC_CALL rlUnknown9EDD20
        PROC_SET_ONCYCLE rlUnknown9EAD7B
        PROC_HALT


        ; 9E/DCD2

    .endsection ProcScript9EDC15Section


    .section Unsorted9EDCD2Section

      .al
      .xl

      rlProcUnknown9EDAF6Cycle2 ; 9E/DCD2

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta $7F4584
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$FFFF
        sta $7F45A4
        sta $7F45A6
        sta $7F45A8
        sta $7F45AA
        jsl rlUnknown9E88CE
        jsl rlUnknown9E87A4
        lda #$0000
        jsl rlUnknown9E8867
        jsl rlUnknown9E87CA
        lda #$0001
        jsl rlUnknown9E8867
        plx
        lda #$DC14
        sta aProcSystem.aHeaderOnCycle,b,x
        ply
        rtl

        .databank 0

        ; 9E/DD14

      rlUnknown9EDD14 ; 9E/DD14

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7F4584
        sta @l $000F37,x
        rtl

        .databank 0

        ; 9E/DD20

      rlUnknown9EDD20 ; 9E/DD20

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F45A4
        tax
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x
        lda $7F45A6
        tax
        cpx #$FFFF
        beq _DD3C
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x

        _DD3C
        lda $7F45A8
        tax
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x
        lda $7F45AA
        tax
        cpx #$FFFF
        beq _DD57
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x

        _DD57
        lda #$0001
        sta $7F4584
        lda aActionStructUnit1
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive
        lda aActionStructUnit2
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive
        lda #1,s
        tax
        jsl rlUnknown88CD4C
        lda wBattleType
        and #$00FF
        cmp #$0003
        beq _DD87
        jsl rlUnknown88CD5A

        _DD87
        lda #(`rlPushToOAMBuffer)<<8
        sta $15E5,b
        lda #<>rlPushToOAMBuffer
        sta $15E4,b
        stz wBufferBG3VOFS
        plx
        rtl

        .databank 0

        ; 9E/DD97

      rlUnknown9EDD97 ; 9E/DD97

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$AF00
        sta lR18+1
        lda #$C400
        sta lR18
        lda #$0400
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        sta wR1
        jsl rlDMAByPointer
        ldx #$001E

        _DDBB
        lda aUnknown9EDDC8,x
        sta aOAMPaletteBuffer.aPalette6,b,x
        dec x
        dec x
        bpl _DDBB
        plx
        rtl

        .databank 0

        ; 9E/DDC8

    .endsection Unsorted9EDCD2Section


    .section Table9EDDC8Section

      .al
      .xl

      aUnknown9EDDC8 ; 9E/DDC8

        ; Read by rlUnknown9EDD97.

        .word $3800, $7FFF, $035F, $01BF, $0037, $0C8A, $0425, $7FBA
        .word $7E6E, $7C84, $30C4, $1421, $0000, $0000, $0000, $0000

        ; 9E/DDE8

    .endsection Table9EDDC8Section


    .section Unsorted9EDDE8Section

      .al
      .xl

      rlUnknown9EDDE8 ; 9E/DDE8

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4598
        sta $7F57EA
        lda $7F4599
        sta $7F57EC
        lda #$9E00
        sta $7F4599
        lda #$DE89
        sta $7F4598
        lda aMapAction.wUnknown7F4558
        tay
        lda aMapAction.wUnknown7F4556
        tax
        lda aActionStructUnit2.UnitRAMPointer
        jsl rlUnknown9E8D25
        lda #$9E00
        sta lR44+1
        lda #$DF78
        sta lR44
        ldx wR0
        lda wR1
        clc
        adc #$0002
        tay
        lda #$DF78
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        ldx aActiveSpriteSystem.wOffset,b
        txa
        sta @l $001097
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0006
        sta aActiveSpriteSystem.aUnknown0012A0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001260,b,x
        sta aActiveSpriteSystem.aUnknown001280,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9E/DE60

      rlUnknown9EDE60 ; 9E/DE60

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda @l $001097
        tax
        lda aActiveSpriteSystem.aTypeOffset,b,x
        bne _DE87
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F57EA
        sta $7F4598
        lda $7F57EC
        sta $7F4599

        _DE87
        plx
        rtl

        .databank 0

        ; 9E/DE89

    .endsection Unsorted9EDDE8Section


    .section Unsorted9EDF7FSection

      .al
      .xl

      rlUnknown9EDF7F ; 9E/DF7F

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown9EDF8E)<<8
        sta lR44+1
        lda #<>procUnknown9EDF8E
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/DF8E

    .endsection Unsorted9EDF7FSection


    .section ProcScript9EDF8ESection

      .al
      .xl

      procUnknown9EDF8E ; 9E/DF8E

        .structProcInfo "ON", rlProcUnknown9EDF8EInit, rlProcUnknown9EDF8ECycle1, aProcUnknown9EDF8ECode

    .endsection ProcScript9EDF8ESection


    .section Unsorted9EDF96Section

      .al
      .xl

      rlProcUnknown9EDF8EInit ; 9E/DF96

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlUnknown88AF7B
        jsl rlUnknown9EE02D
        sta aProcSystem.aBody6,b,x
        lda aActionStructUnit1.XPosition
        sta $7F57EE
        lda aActionStructUnit1.YPosition
        sta $7F57F0
        lda wBattleStatus
        and #$0001
        sta wR0
        lda wBattleStatus
        and #$00FF
        bit #$0004
        beq _DFDD
        and #$0002
        lsr a
        cmp wR0
        bne _DFDD
        lda $7F57F0
        inc a
        sta $7F57F0

        _DFDD
        lda wBattleStatus
        and #$0001
        beq _DFF6
        lda aActionStructUnit2.XPosition
        sta $7F57EE
        lda aActionStructUnit2.YPosition
        sta $7F57F0

        _DFF6
        rtl

        .databank 0

        ; 9E/DFF7

      rlProcUnknown9EDF8ECycle1 ; 9E/DFF7

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9E/DFF8

    .endsection Unsorted9EDF96Section


    .section Unsorted9EDFF8Section

      .al
      .xl

      rlProcUnknown9EDF8ECycle2 ; 9E/DFF8

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody6,b,x
        jsl rlUnknown8280F8
        bcc _E010
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$E010
        sta aProcSystem.aHeaderOnCycle,b,x

        _E010
        rtl

        .databank 0

        ; 9E/E011

    .endsection Unsorted9EDFF8Section


    .section ProcScript9EE011Section

      .al
      .xl

      aProcUnknown9EDF8ECode ; 9E/E011

        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown9EDF8ECycle2
        _E017
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _E017, $0001
        PROC_END


        ; 9E/E021

    .endsection ProcScript9EE011Section


    .section Unsorted9EE021Section

      .al
      .xl

      rlUnknown9EE021 ; 9E/E021

        .al
        .xl
        .autsiz
        .databank ?

        lda aActionStructUnit1.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown84BB54
        rtl

        .databank 0

        ; 9E/E02D

    .endsection Unsorted9EE021Section


    .section Unsorted9EE02DSection

      .al
      .xl

      rlUnknown9EE02D ; 9E/E02D

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown9EE03C)<<8
        sta lR44+1
        lda #<>procUnknown9EE03C
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/E03C

    .endsection Unsorted9EE02DSection


    .section ProcScript9EE03CSection

      .al
      .xl

      procUnknown9EE03C ; 9E/E03C

        .structProcInfo "ON", rlProcUnknown9EE03CInit, rlProcUnknown9EE03CCycle, aProcUnknown9EE03CCode

    .endsection ProcScript9EE03CSection


    .section Unsorted9EE044Section

      .al
      .xl

      rlProcUnknown9EE03CInit ; 9E/E044

        .al
        .xl
        .autsiz
        .databank ?

        lda wGameStateRoutine1,b
        sta aProcSystem.aBody7,b,x
        stz wGameStateRoutine1,b
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        lda #(`rlUnknown81841B)<<8
        sta $15E5,b
        lda #<>rlUnknown81841B
        sta $15E4,b
        rtl

        .databank 0

        ; 9E/E060

      rlProcUnknown9EE03CCycle ; 9E/E060

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda wBattleCriticalType
        dec a
        jsl rlUnknown9EE0F1
        lda #$E079
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 9E/E079

    .endsection Unsorted9EE044Section


    .section ProcScript9EE092Section

      .al
      .xl

      aProcUnknown9EE03CCode ; 9E/E092

        PROC_YIELD 1
        _E094
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _E094, $0002
        PROC_CALL rlUnknown9EE127
        PROC_YIELD 8
        PROC_CALL rlUnknown9EE228
        _E0A8
        PROC_CALL rlUnknown9EE23D
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _E0A8, $0004
        PROC_YIELD 1
        PROC_CALL rlUnknown9EE290
        _E0BC
        PROC_YIELD 1
        PROC_CALL rlUnknown9EE2BE
        PROC_JUMP_IF_BITS_UNSET _E0BC, $0001
        PROC_YIELD 30
        PROC_CALL rlUnknown9EE254
        PROC_JUMP_IF_BITS_UNSET _E0E3, $0002
        _E0D6
        PROC_CALL rlUnknown9EE279
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _E0D6, $0004
        _E0E3
        PROC_YIELD 1
        PROC_CALL rlUnknown9EE2D1
        PROC_CALL rlUnknown9EE021
        PROC_END


        ; 9E/E0F1

    .endsection ProcScript9EE092Section


    .section Unsorted9EE0F1Section

      .al
      .xl

      rlUnknown9EE0F1 ; 9E/E0F1

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown9EE11B,x
        sta lR18
        lda aUnknown9EE11B+1,x
        sta lR18+1
        lda #$7E00
        sta lR19+1
        lda #$8B88
        clc
        adc #$6000
        sta lR19
        jsl rlAppendDecompList
        plx
        ply
        rtl

        .databank 0

        ; 9E/E11B

    .endsection Unsorted9EE0F1Section


    .section Table9EE11BSection

      .al
      .xl

      aUnknown9EE11B ; 9E/E11B

        ; Read by rlUnknown9EE0F1.

        .word $7840, $84D6, $D679, $7CC7, $C6D6, $D67B

        ; 9E/E127

    .endsection Table9EE11BSection


    .section Unsorted9EE127Section

      .al
      .xl

      rlUnknown9EE127 ; 9E/E127

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$7E00
        sta lR18+1
        lda #$8B88
        clc
        adc #$6000
        sta lR18
        lda #$0400
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc #$0400
        sta wR1
        jsl rlDMAByPointer
        jsl rlUnknown9EE156
        plx
        rtl

        .databank 0

        ; 9E/E156

      rlUnknown9EE156 ; 9E/E156

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda wBattleCriticalType
        and #$00FF
        xba
        lsr a
        lsr a
        lsr a
        tax
        ldy #$001E

        _E167
        lda $9EE175,x
        sta aOAMPaletteBuffer.aPalette6,b,y
        dec x
        dec x
        dec y
        dec y
        bpl _E167
        plx
        ply
        rtl

        .databank 0

        ; 9E/E177

    .endsection Unsorted9EE127Section


    .section Unsorted9EE228Section

      .al
      .xl

      rlUnknown9EE228 ; 9E/E228

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        phb
        pea #$9F9F
        plb
        .databank ?
        plb
        .databank ?
        jsl rlUnknown9F90FA
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/E23D

      rlUnknown9EE23D ; 9E/E23D

        .al
        .xl
        .autsiz
        .databank ?

        phb
        pea #$9F9F
        plb
        .databank ?
        plb
        .databank ?
        jsl rlUnknown9F90F2
        bcc _E252
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _E252
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/E254

      rlUnknown9EE254 ; 9E/E254

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        lda aActionStructUnit1.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlCheckIfBattleAnimationOFF
        bcc _E277
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _E277
        plx
        rtl

        .databank 0

        ; 9E/E279

      rlUnknown9EE279 ; 9E/E279

        .al
        .xl
        .autsiz
        .databank ?

        phb
        pea #$9F9F
        plb
        .databank ?
        plb
        .databank ?
        jsl rlUnknown9F90F6
        bcc _E28E
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _E28E
        plb
        .databank ?
        rtl

        .databank 0

        ; 9E/E290

      rlUnknown9EE290 ; 9E/E290

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wBattleCriticalType
        dec a
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown9EE2B2+1,x
        sta lR44+1
        lda aUnknown9EE2B2,x
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        sta aProcSystem.aBody6,b,x
        rtl

        .databank 0

        ; 9E/E2B2

    .endsection Unsorted9EE228Section


    .section Table9EE2B2Section

      .al
      .xl

      aUnknown9EE2B2 ; 9E/E2B2

        ; Read by rlUnknown9EE290.

        .word $E2E4, $CA9E, $9EE3, $E5D7, $3B9E, $9EE8

        ; 9E/E2BE

    .endsection Table9EE2B2Section


    .section Unsorted9EE2BESection

      .al
      .xl

      rlUnknown9EE2BE ; 9E/E2BE

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody6,b,x
        jsl rlUnknown8280F8
        bcc _E2D0
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _E2D0
        rtl

        .databank 0

        ; 9E/E2D1

      rlUnknown9EE2D1 ; 9E/E2D1

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        lda #(`rlPushToOAMBuffer)<<8
        sta $15E5,b
        lda #<>rlPushToOAMBuffer
        sta $15E4,b
        rtl

        .databank 0

        ; 9E/E2E4

    .endsection Unsorted9EE2BESection


    .section Unsorted9EEDB5Section

      .al
      .xl

      rlUnknown9EEDB5 ; 9E/EDB5

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0019
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0038
        sta aActionStructUnit1.XPosition
        lda #$0039
        sta aActionStructUnit1.YPosition
        lda #$000A
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0012
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$0039
        sta aActionStructUnit2.XPosition
        lda #$0039
        sta aActionStructUnit2.YPosition
        lda #$001D
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta $7F4564
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0009
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$1B00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$1614
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 9E/EED3

      rlUnknown9EEED3 ; 9E/EED3

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$003B
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0039
        sta aActionStructUnit1.XPosition
        lda #$0037
        sta aActionStructUnit1.YPosition
        lda #$004B
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$000E
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$0039
        sta aActionStructUnit2.XPosition
        lda #$0038
        sta aActionStructUnit2.YPosition
        lda #$002A
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta $7F4564
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0148
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0109
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0140
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 9E/EFF1

    .endsection Unsorted9EEDB5Section


    .section Unsorted9EEFF1Section

      .al
      .xl

      rlUnknown9EEFF1 ; 9E/EFF1

        ; Nothing in the build reaches this. Fills the battle action structs for the
        ; selected unit alone (no opponent: aActionStructUnit2 = $FFFF), then runs
        ; rlUnknown9E800C with $7F4C87 = 2.

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit1
        jsl rlGetSelectedUnitClassID
        sta aActionStructUnit1.ClassID
        jsl rlGetSelectedUnitGender
        sta aActionStructUnit1.Gender
        jsl rlGetSelectedUnitCharacterID
        sta aActionStructUnit1.CharacterID
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._XTilePosition,x
        sta aActionStructUnit1.XPosition
        lda aDeploymentTable._YTilePosition,x
        sta aActionStructUnit1.YPosition
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$FFFF
        sta aActionStructUnit1.WeaponID
        lda #$0008
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        lda #$FFFF
        sta aActionStructUnit2
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        sta aActionStructUnit2.XPosition
        sta aActionStructUnit2.YPosition
        sta aActionStructUnit2.WeaponID
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0002
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        lda #$0002
        sta $7F4C87
        jml rlUnknown9E800C._8014

        .databank 0

        ; 9E/F0CF

      rlUnknown9EF0CF ; 9E/F0CF

        ; Nothing in the build reaches this. Fills the battle action structs for
        ; the unit at wR0 and the unit at wR1, then runs rlUnknown9E800C with
        ; $7F4C87 = 2. When the second unit has no usable weapon, the original
        ; branches back to the first unit's code (bra _F11F); that looks like a bug.

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wR1
        pha
        lda wR0
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit1
        jsl rlGetSelectedUnitClassID
        sta aActionStructUnit1.ClassID
        jsl rlGetSelectedUnitGender
        sta aActionStructUnit1.Gender
        jsl rlGetSelectedUnitCharacterID
        sta aActionStructUnit1.CharacterID
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._XTilePosition,x
        sta aActionStructUnit1.XPosition
        lda aDeploymentTable._YTilePosition,x
        sta aActionStructUnit1.YPosition
        jsl rlGetFirstEquippableWeaponInInventory
        ldx wCurrentItemDataROMPointer,b
        bne _F11B
        lda #$FFFF
        bra _F11F


        _F11B
        jsl rlGetItemIDByInventorySlot

        _F11F
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit1
        tax
        lda aDeploymentTable,x
        and #$0003
        sta aMapAction.wUnknown7F4562
        pla
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit2
        jsl rlGetSelectedUnitClassID
        sta aActionStructUnit2.ClassID
        jsl rlGetSelectedUnitGender
        sta aActionStructUnit2.Gender
        jsl rlGetSelectedUnitCharacterID
        sta aActionStructUnit2.CharacterID
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._XTilePosition,x
        sta aActionStructUnit2.XPosition
        lda aDeploymentTable._YTilePosition,x
        sta aActionStructUnit2.YPosition
        jsl rlGetFirstEquippableWeaponInInventory
        ldx wCurrentItemDataROMPointer,b
        bne _F185
        lda #$FFFF
        bra _F11F


        _F185
        jsl rlGetItemIDByInventorySlot
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        jsl rlGetSelectedUnitDeploymentOffset
        sta aActionStructUnit2
        tax
        lda aDeploymentTable,x
        and #$0003
        sta $7F4564
        lda #$0002
        sta $7F4C87
        jml rlUnknown9E800C._8014

        .databank 0

        ; 9E/F1B3

      rlUnknown9EF1B3 ; 9E/F1B3

        ; Only plx / rtl; nothing reaches it.

        .al
        .xl
        .autsiz
        .databank ?

        plx
        rtl

        .databank 0

        ; 9E/F1B5

    .endsection Unsorted9EEFF1Section


    .section Unsorted9EF1B5Section

      .al
      .xl

      rlUnknown9EF1B5 ; 9E/F1B5

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4C07
        beq _F1D8
        lda $7F4C07
        ora #$0002
        sta $7F4C07
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _F1D8
        rtl

        .databank 0

        ; 9E/F1D9

    .endsection Unsorted9EF1B5Section


    .section Unsorted9EF1FASection

      .al
      .xl

      rlUnknown9EF1FA ; 9E/F1FA

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wEventUnitSlot1ID,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta $7E4EA9
        jsl rlGetSelectedUnitClassID
        sta $7E4EAF
        jsl rlGetSelectedUnitGender
        sta aActionStructUnit1.CharacterID
        jsl rlGetSelectedUnitCharacterID
        sta aActionStructUnit1.UnitRAMPointer
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._XTilePosition,x
        sta wBattleDistance
        lda aDeploymentTable._YTilePosition,x
        sta wBattleQuotePointer
        lda #$0000
        sta $7F4C87
        lda #(`procUnknown9EF24B)<<8
        sta lR44+1
        lda #<>procUnknown9EF24B
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/F24B

      procUnknown9EF24B ; 9E/F24B

        .structProcInfo "ON", rlProcUnknown9EF24BInit, $9ED2B5, $9ED1F4

      rlProcUnknown9EF24BInit ; 9E/F253

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0000
        sta $4580,b
        sta $4582,b
        sta $4584,b
        sta aMapAction.wUnknown7F455A
        sta $7F4572
        sta $7F5091
        sta $7F5093
        sta $7F4C07
        lda $7E4EA9
        sta aActionStructUnit1
        sta aActionStructUnit2
        lda $7E4EAF
        sta @l wR0
        lda aActionStructUnit1.CharacterID
        sta @l wR1
        lda aActionStructUnit1.UnitRAMPointer
        sta @l wR2
        jsl rlUnknown9E85A4
        sta $454E,b
        lda wBattleDistance
        sta $4552,b
        lda wBattleQuotePointer
        sta $4554,b
        lda #$FFFF
        jsl rlUnknown9E866F
        sta $454A,b
        lda #$FFFF
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta $4550,b
        sta $4556,b
        sta $4558,b
        sta $454C,b
        lda #$0006
        sta $455E,b
        sta $4560,b
        lda #$0020
        sta $5089,b
        plb
        .databank ?
        lda aMapAction.wYTilePosition
        tay
        lda aMapAction.wXTilePosition
        tax
        jsl rlUnknown9E8D25
        lda #$8000
        sta $7F508F
        lda $7E4EAF
        sta aActionStructUnit1.ClassID
        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1
        lda wR1
        xba
        ora wR0
        sta $7F5099
        sta $7F509B
        lda #$8100
        sta @l $0015E5
        lda #$841B
        sta @l $0015E4
        lda @l aActiveSpriteSystem
        sta $7F4BD9
        lda @l aActiveSpriteSystem
        ora #$4000
        sta @l aActiveSpriteSystem
        plx
        lda @l $000302
        sta @l $0010B7,x
        stz wGameStateRoutine1,b
        jsl rlUnknown88CD53
        jsl rlUnknown88CD61
        ply
        rtl

        .databank 0

    .endsection Unsorted9EF1FASection


    .section Unsorted9EF37FSection

      .al
      .xl

      procUnknown9EF37F ; 9E/F37F

        .structProcInfo "ON", rlProcUnknown9EF37FInit, $9ED2B5, $9EF49E

      rlProcUnknown9EF37FInit ; 9E/F387

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        phb
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #$0000
        sta $4580,b
        sta $4582,b
        sta $4584,b
        sta aMapAction.wUnknown7F455A
        sta $7F4572
        sta $7F5091
        sta $7F5093
        lda #$0001
        sta $7F4C87
        lda #$FFFF
        sta aActionStructUnit1
        sta aActionStructUnit2
        lda $7E4EAF
        sta @l wR0
        lda aActionStructUnit1.CharacterID
        sta @l wR1
        lda #$FFFF
        sta @l wR2
        jsl rlUnknown9E85A4
        sta $454E,b
        lda wBattleDistance
        sta $4552,b
        lda wBattleQuotePointer
        sta $4554,b
        lda #$FFFF
        jsl rlUnknown9E866F
        sta $454A,b
        lda #$FFFF
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta $4550,b
        sta $4556,b
        sta $4558,b
        sta $454C,b
        lda #$0006
        sta $455E,b
        sta $4560,b
        lda #$0029
        sta $5089,b
        plb
        .databank ?
        lda aMapAction.wYTilePosition
        tay
        lda aMapAction.wXTilePosition
        tax
        jsl rlUnknown9E8D25
        lda #$8000
        sta $7F508F
        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1
        lda wR1
        xba
        ora wR0
        sta $7F509B
        sta $7F5099
        lda #$8100
        sta @l $0015E5
        lda #$841B
        sta @l $0015E4
        lda @l aActiveSpriteSystem
        sta $7F4BD9
        lda @l aActiveSpriteSystem
        ora #$4000
        sta @l aActiveSpriteSystem
        plx
        lda @l $000302
        sta @l $0010B7,x
        stz wGameStateRoutine1,b
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$0038
        sta aProcSystem.aBody3,b,x
        lda $7E4EAF
        sta aActionStructUnit1.ClassID
        jsl rlUnknown88CD53
        jsl rlUnknown88CD61
        ply
        rtl

        .databank 0

    .endsection Unsorted9EF37FSection


    .section Unsorted9EF55BSection

      .al
      .xl

      rlUnknown9EF55B ; 9E/F55B

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody3,b,x
        bne _F570
        lda bDecompressionArrayFlag,b
        bne _F577
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        bra _F577


        _F570
        lda aProcSystem.aBody3,b,x
        dec a
        sta aProcSystem.aBody3,b,x

        _F577
        rtl

        .databank 0

        ; 9E/F578

      rlUnknown9EF578 ; 9E/F578

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7F45A4
        sta $7F45A8
        lda $7F45A6
        sta $7F45AA
        lda $7F45A4
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        ora #$8000
        sta aActiveSpriteSystem.aUnknown001200,b,x
        lda $7F45A6
        cmp #$FFFF
        beq _F5AA
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        ora #$8000
        sta aActiveSpriteSystem.aUnknown001200,b,x

        _F5AA
        plx
        rtl

        .databank 0

        ; 9E/F5AC

    .endsection Unsorted9EF55BSection


    .section Unsorted9EF5D0Section

      .al
      .xl

      rlUnknown9EF5D0 ; 9E/F5D0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFD
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda $7F4C07
        bit #$0004
        beq _F5EF
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _F5EF
        plx
        rtl

        .databank 0

        ; 9E/F5F1

      rlUnknown9EF5F1 ; 9E/F5F1

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F4C07
        ora #$0010
        sta $7F4C07
        lda $7F4C07
        bit #$0008
        beq _F60E
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _F60E
        rtl

        .databank 0

        ; 9E/F60F

    .endsection Unsorted9EF5D0Section


    .section Unsorted9EF60FSection

      .al
      .xl

      rlUnknown9EF60F ; 9E/F60F

        .al
        .autsiz
        .databank ?

        lda #(`procBelhallaMagesAttack)<<8
        sta lR44+1
        lda #<>procBelhallaMagesAttack
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

    .endsection Unsorted9EF60FSection


    .section Unsorted9EF9DFSection

      .al
      .xl

      rlProcUnknown9EF837Cycle2 ; 9E/F9DF

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

    .endsection Unsorted9EF9DFSection


    .section Unsorted9EF9E0Section

      .al
      .xl

      aProcUnknown9EF837Code ; 9E/F9E0

        PROC_YIELD 44
        PROC_SET_ONCYCLE rlUnknown9ED337
        PROC_YIELD 32
        PROC_CALL rlUnknown9E99F7
        PROC_YIELD 2
        PROC_CALL rlUnknown9E89F1
        PROC_CALL rlUnknown9EB3DE
        PROC_YIELD 1
        PROC_CALL rlUnknown9EFA4F
        PROC_YIELD 32
        PROC_CALL rlUnknown9EFA9A
        PROC_CALL rlUnknown888197
        PROC_YIELD 4
        PROC_CALL rlUnknown8881A7
        PROC_YIELD 1
        PROC_END

    .endsection Unsorted9EF9E0Section


    .section Unsorted9EFA17Section

      .al
      .xl

      rlUnknown9EFA17 ; 9E/FA17

        .al
        .autsiz
        .databank ?

        phx
        jsl rlGetSelectedUnitDeploymentOffset
        sta aScriptedUnitMapAction + structScriptedMapAttack.wDeploymentOffset
        jsl rlGetSelectedUnitClassID
        sta aScriptedUnitMapAction + structScriptedMapAttack.wClass
        jsl rlGetSelectedUnitGender
        sta aScriptedUnitMapAction + structScriptedMapAttack.wGender
        jsl rlGetSelectedUnitCharacterID
        sta aScriptedUnitMapAction + structScriptedMapAttack.wCharacterID
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._XTilePosition,x
        sta aScriptedUnitMapAction + structScriptedMapAttack.wXTilePosition
        lda aDeploymentTable._YTilePosition,x
        sta aScriptedUnitMapAction + structScriptedMapAttack.wYTilePosition
        plx
        rtl

        .databank 0

      rlUnknown9EFA4F ; 9E/FA4F

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        phy
        phx
        lda #0
        sta @l $7F4580
        sta @l $7F4582
        sta aProcSystem.aHeaderBitfield,x

        lda #1
        sta @l $7F4584
        lda $4599,b
        sta $458A,b
        sta $4587,b

        lda $4598,b
        sta lR18
        lda $4598+1,b
        sta lR18+1
        lda $455E,b
        sta wR0
        lda #0
        jsr rsUnknown9E832C
        stx $4589,b
        sty $4586,b
        plx
        ply
        plp
        plb
        rtl

        .databank 0

      rlUnknown9EFA9A ; 9E/FA9A

        .al
        .autsiz
        .databank ?

        phx
        lda $7F45A4
        tax
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda $7F45A6
        tax
        cpx #$FFFF
        beq +

          stz aActiveSpriteSystem.aTypeOffset,b,x

        +
        lda $7E4EA9
        tax
        jsl rlDeployedUnitUnsetHiddenIfAlive
        plx
        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        lda #$8000
        sta $15E4+1,b
        lda #$87C7
        sta $15E4,b

        lda $7F4BD9
        sta aActiveSpriteSystem.wFlag,b
        rtl

        .databank 0

      rlUnknown9EFAD4 ; 9E/FAD4

        .al
        .autsiz
        .databank ?

        lda #(`procUnknown9EFAE3)<<8
        sta lR44+1
        lda #<>procUnknown9EFAE3
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      procUnknown9EFAE3 ; 9E/FAE3

        .structProcInfo "ON", rlProcUnknown9EFAE3Init, rlProcUnknown9EFAE3Cycle, aProcUnknown9EFAE3Code
        
      rlProcUnknown9EFAE3Init ; 9E/FAEB

        .al
        .autsiz
        .databank ?

        phx
        lda #0
        sta aProcSystem.aHeaderBitfield,b,x
        sta $7F45CC
        plx
        rtl

        .databank 0

      aUnknown9EFAF8 ; 9E/FAF8

        .long aUnknown9EFB07
        .long aUnknown9EFB1B
        .long aUnknown9EFB29
        .long aUnknown9EFB37
        .long aUnknown9EFB45

      aUnknown9EFB07 ; 9E/FB07

        .byte $05, $30
        .byte $06, $30
        .byte $07, $30
        .byte $05, $31
        .byte $06, $31
        .byte $07, $31
        .byte $05, $32
        .byte $06, $32
        .byte $07, $32
        .word $FFFF

      aUnknown9EFB1B ; 9E/FB1B

        .byte $06, $2F
        .byte $07, $2F
        .byte $06, $30
        .byte $07, $30
        .byte $06, $31
        .byte $07, $31
        .word $FFFF

      aUnknown9EFB29 ; 9E/FB29

        .byte $05, $2E
        .byte $06, $2E
        .byte $05, $2F
        .byte $06, $2F
        .byte $05, $30
        .byte $06, $30
        .word $FFFF

      aUnknown9EFB37 ; 9E/FB37

        .byte $06, $2D
        .byte $07, $2D
        .byte $06, $2E
        .byte $07, $2E
        .byte $06, $2F
        .byte $07, $2F
        .word $FFFF

      aUnknown9EFB45 ; 9E/FB45

        .byte $06, $2C
        .byte $05, $2D
        .byte $06, $2D
        .byte $07, $2D
        .byte $05, $2E
        .byte $06, $2E
        .byte $07, $2E
        .word $FFFF

      rlProcUnknown9EFAE3Cycle ; 9E/FB55

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aProcUnknown9EFAE3Code ; 9E/FB56

        PROC_YIELD 1

        -
        PROC_YIELD 1
        PROC_CALL rlUnknown9EFB80
        PROC_JUMP_IF_BITS_UNSET -, $0004

        -
        PROC_YIELD 1
        PROC_CALL rlUnknown9EFBB6
        PROC_CALL rlUnknown9EFB9B
        PROC_JUMP_IF_BITS_UNSET -, $0004

        PROC_CALL rlUnknown9EFC9B
        PROC_YIELD 16
        PROC_END

      rlUnknown9EFB80 ; 9E/FB80

        .al
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #~$0004
        sta aProcSystem.aHeaderBitfield,b,x

        lda $7F4580
        beq +

          lda aProcSystem.aHeaderBitfield,b,x
          ora #$0004
          sta aProcSystem.aHeaderBitfield,b,x

        +
        plx
        rtl

        .databank 0

      rlUnknown9EFB9B ; 9E/FB9B

        .al
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #~$0004
        sta aProcSystem.aHeaderBitfield,b,x

        lda $7F4580
        bne +

          lda aProcSystem.aHeaderBitfield,b,x
          ora #$0004
          sta aProcSystem.aHeaderBitfield,b,x

        +
        plx
        rtl

        .databank 0

      rlUnknown9EFBB6 ; 9E/FBB6

        .al
        .autsiz
        .databank ?

        phy
        phx
        lda $7F4580
        bne +

          jml _End

        +
        lda $7F45CC
        bne _FC23

          jsl rlUnknown9EFC47

          lda #9
          xba
          lsr a
          lsr a
          lsr a
          tax
          ldy #0

            -
            lda aBGPaletteBuffer,b,x
            sta wR0

            phb
            php
            sep #$20
            lda #$7F
            pha
            rep #$20
            plb
            .databank $7F

            lda wR0
            sta $45AC,b,y

            plp
            plb

            inc x
            inc x
            inc y
            inc y
            cpy #$0020
            bne -

          ldx #$01E2

            -
            lda #$7FFF
            sta aBGPaletteBuffer,b,x
            inc x
            inc x
            cpx #$0200
            bne -

          lda #1
          sta @l $7F45CC
          lda #$0091
          sta wR0
          lda @l $7F509B
          and #$00FF
          jsl rlUnknown9EB4BB
          ora wR0
          jsl rlPlaySoundEffect2 ; sound
        
        _FC23
        lda #(`$7F45AC)<<8
        sta lR18+1
        lda #<>$7F45AC
        clc
        adc #2
        sta lR18
        ldy #$000F
        lda #$00F1
        jsl rlUnknown959F43
        bcc _End

          lda #0
          sta @l $7F4580

        _End
        plx
        ply
        rtl

        .databank 0

    .endsection Unsorted9EFA17Section


    .section Unsorted9EFC47Section

      .al
      .xl

      rlUnknown9EFC47 ; 9E/FC47

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb
        phx
        phy
        lda $7F57F0
        asl a
        clc
        adc $7F57F0
        tax
        lda aUnknown9EFAF8,x
        sta lR18,b
        lda aUnknown9EFAF8+1,x
        sta lR18+1,b
        ldy #0

        _Loop
        lda [lR18],y
        cmp #$FFFF
        beq _End

          and #$00FF
          sta wR0
          inc y
          lda [$24],y
          and #$00FF
          sta wR1
          phy
          jsl rlGetUnitByCoordinates
          bcs _Next

            jsl rlGetSelectedUnitDeploymentOffset
            tax
            lda aDeploymentTable._State,x
            ora #DeploymentStateGrayed
            sta aDeploymentTable._State,x

          _Next
          ply
          inc y
          bra _Loop

        _End
        ply
        plx
        plb
        rtl

        .databank 0

      rlUnknown9EFC9B ; 9E/FC9B

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb
        phx
        phy
        lda #0
        sta aProcSystem.aHeaderBitfield,b,x
        sta $7F45CC

        lda $7F57F0
        asl a
        clc
        adc $7F57F0
        tax
        lda aUnknown9EFAF8,x
        sta lR18,b
        lda aUnknown9EFAF8+1,x
        sta lR18+1,b
        ldy #0
        
        _Loop
        lda [lR18],y
        cmp #$FFFF
        beq _End

          and #$00FF
          sta wR0
          inc y
          lda [lR18],y
          and #$00FF
          sta wR1
          phy
          jsl rlGetUnitByCoordinates
          bcs _Next

            jsl rlGetSelectedUnitDeploymentOffset
            tax
            lda aDeploymentTable._State,x
            and #~DeploymentStateGrayed
            sta aDeploymentTable._State,x

          _Next
          ply
          inc y
          bra _Loop

        _End
        lda $7F57F0
        inc a
        sta $7F57F0

        ply
        plx
        plb
        rtl

        .databank 0

        ; 9E/FD02

        ; fill 0

    .endsection Unsorted9EFC47Section
