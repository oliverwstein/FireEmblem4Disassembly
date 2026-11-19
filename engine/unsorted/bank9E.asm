; Code from bank $9E not yet assigned to a game system.

    .section Unsorted9E800CSection

      .al
      .xl

      rlUnknown9E800C ; 9E/800C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $7F4C87
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
        lda $7E4EDD
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
        lda $7E4F3D
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
        lda $7E4EA9
        and #$00FF
        cmp #$0003
        bne _81EE
        lda #$0001
        sta $7F508F
        bra _8268


        _81EE
        jsl rlUnknown9E8271
        lda $7E4EB7
        sta wR4
        lda $7E4EB9
        sta wR5
        lda $7E4F17
        sta wR6
        lda $7E4F19
        sta wR7
        lda wR0
        clc
        adc $9E826B
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
        sbc $9E826D
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
        adc $9E826F
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


    .section Unsorted9E832CSection

      .al
      .xl

      rlUnknown9E832C ; 9E/832C

        .al
        .xl
        .autsiz
        .databank ?

        and #$0001
        bne _8353
        lda @l wR0
        and #$0001
        bne _8343
        lda $7E4F85,x
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
        lda $7E4F85,x
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

        .word $DA6B

    .endsection Unsorted9E88F4Section


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
        lda $9E8FB2
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

        lda #$9E00
        sta lR44+1
        lda #$9A43
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/9A43

    .endsection Unsorted9E9A34Section


    .section Unsorted9E9D3BSection

      .al
      .xl

      rlUnknown9E9D3B ; 9E/9D3B

        .al
        .autsiz
        .databank ?

        phx
        lda #(`$D676F6)<<8
        sta lR18+1
        lda #<>$D676F6
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$2000
        sta lR19
        jsl rlAppendDecompList

        lda #(`$D677E9)<<8
        sta lR18+1
        lda #<>$D677E9
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


    .section Unsorted9EAC5ASection

      .al
      .xl

      rlUnknown9EAC5A ; 9E/AC5A

        .al
        .autsiz
        .databank ?

        lda #(`$9EAC69)<<8
        sta lR44+1
        lda #<>$9EAC69
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

        lda $0302,b
        sta aProcSystem.aBody7,x

        stz $0302,b
        stz aProcSystem.aHeaderBitfield,b,x

        lda $7E4EB7
        tax
        lda $7E4EB9
        tay
        lda $7E4EBB
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
        PROC_CALL $9EC91A

        PROC_JUMP_IF_BITS_UNSET _ACD1, $0002

            _ACC2
            PROC_YIELD 1
            PROC_CALL $9EC944

            PROC_JUMP_IF_BITS_UNSET _ACC2, $0004

          PROC_YIELD 1
        _ACD1
        PROC_CALL $9E9342
        PROC_JUMP_IF_BITS_UNSET _ACFC, $0002

          PROC_CALL $9EB3F3
          PROC_JUMP_IF_BITS_UNSET _ACEE, $0004

            PROC_YIELD 16
            PROC_CALL $9EB4A9

        _ACEE
        PROC_YIELD 1
        PROC_SET_ONCYCLE $9E936B
        PROC_JUMP_IF_BITS_UNSET _ACEE, $0004

        PROC_YIELD 107

        _ACFC
        PROC_CALL $9E952D

        PROC_JUMP_IF_BITS_UNSET _AD22, $0002
        PROC_CALL $9EB3F3

        PROC_JUMP_IF_BITS_UNSET _AD14, $0004

          PROC_YIELD 16

        _AD14
        PROC_SET_ONCYCLE $9E95AB

        _AD18
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _AD18, $0004

        PROC_YIELD 8

        _AD22
        PROC_CALL $9E9928

        PROC_JUMP_IF_BITS_UNSET _AD48, $0002

        PROC_CALL $9EB3F3
        PROC_JUMP_IF_BITS_UNSET _AD3A, $0004

          PROC_YIELD 16

        _AD3A
        PROC_CALL $9EB491
        PROC_YIELD 117
        PROC_CALL $85DB91
        PROC_YIELD 8

        _AD48
        PROC_CALL $9E985E

        PROC_JUMP_IF_BITS_UNSET _AD6E, $0002

        PROC_CALL $9EB3F3

        PROC_JUMP_IF_BITS_UNSET _AD60, $0004

          PROC_YIELD 16

        _AD60
        PROC_CALL $9EB49D
        PROC_YIELD 117
        PROC_CALL $85DB91
        PROC_YIELD 8

        _AD6E
        PROC_CALL $9EB41C
        PROC_YIELD 16
        PROC_SET_ONCYCLE $9EAD7B
        PROC_HALT

        ; AD7B

    .endsection Unsorted9EACAFSection


    .section Unsorted9EB2BASection

      .al
      .xl

      rlUnknown9EB2BA ; 9E/B2BA

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda $7F4BEB
        and #$0001
        asl a
        tax
        lda $7F4C11,x
        beq _B2D4
        lda $7F4BEB
        and #$0001
        bne _B342

        _B2D4
        lda $7F4BEB
        and #$0001
        asl a
        tax
        lda $7F454A,x
        bne _B2EA
        lda #$0041
        sta wR0
        bra _B315


        _B2EA
        dec a
        bne _B2F4
        lda #$0044
        sta wR0
        bra _B315


        _B2F4
        dec a
        bne _B30E
        lda $7F4BEB
        and #$0020
        beq _B307
        lda #$0045
        sta wR0
        bra _B315


        _B307
        lda #$0041
        sta wR0
        bra _B315


        _B30E
        lda #$0043
        sta wR0
        bra _B315


        _B315
        lda $7F45A8
        cmp #$FFFF
        beq _B329
        tax
        lda $1200,b,x
        tay
        lda $7F57EA
        bne _B337

        _B329
        lda $7F45A4
        cmp #$FFFF
        beq _B342
        tax
        lda $1200,b,x
        tay

        _B337
        tya
        jsl rlUnknown9EB4BB
        ora wR0
        jsl rlUnknown80900D

        _B342
        plx
        ply
        rtl

        .databank 0

        ; 9E/B345

    .endsection Unsorted9EB2BASection


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
        .long $ADF4CB, $AAA0F6, $ADEDD1, $AA966C
        .long $ADEA4E, $AA92C3, $ADE6C6, $AA8F26
        .long $ADF10B, $AA8F26, $ADF890, $AA9A00
        .long $ADFBD9, $AA9D2F, $D50000, $AAA0F6
        .byte 1
        ; LanceKnight
        .long $D510B1, $AAA0F6, $D50A01, $AA966C
        .long $D506AD, $AA92C3, $D50333, $AA8F26
        .long $D50D0F, $AA8F26, $D514DD, $AA9A00
        .long $D51825, $AA9D2F, $D51B75, $AAA0F6
        .byte 1
        ; BowKnight
        .long $ADF4CB, $AAA0F6, $ADEDD1, $AA966C
        .long $ADEA4E, $AA92C3, $ADE6C6, $AA8F26
        .long $ADF10B, $AA8F26, $ADF890, $AA9A00
        .long $ADFBD9, $AA9D2F, $D50000, $AAA0F6
        .byte 1
        ; AxeKnight
        .long $D510B1, $AAA0F6, $D50A01, $AA966C
        .long $D506AD, $AA92C3, $D50333, $AA8F26
        .long $D50D0F, $AA8F26, $D514DD, $AA9A00
        .long $D51825, $AA9D2F, $D51B75, $AAA0F6
        .byte 1
        ; FreeKnight
        .long $D510B1, $AAA0F6, $D50A01, $AA966C
        .long $D506AD, $AA92C3, $D50333, $AA8F26
        .long $D50D0F, $AA8F26, $D514DD, $AA9A00
        .long $D51825, $AA9D2F, $D51B75, $AAA0F6
        .byte 1
        ; Troubadour
        .long $D510B1, $AC8CFB, $D50A01, $ABFF18
        .long $D506AD, $ABFA3D, $D50333, $ABF59A
        .long $D50D0F, $ABF59A, $D514DD, $AC83BF
        .long $D51825, $AC8842, $D51B75, $AC8CFB
        .byte 1
        ; KnightLord
        .long $ADF4CB, $A587D6, $ADEDD1, $A4FF5A
        .long $ADEA4E, $A4FC4A, $ADE6C6, $A4F926
        .long $ADF10B, $A4F926, $ADF890, $A5822D
        .long $ADFBD9, $A584DD, $D50000, $A587D6
        .byte 1
        ; DukeKnight
        .long $ADF4CB, $A2F96D, $ADEDD1, $A2F0BF
        .long $ADEA4E, $A2ED85, $ADE6C6, $A2EA71
        .long $ADF10B, $A2EA71, $ADF890, $A2F38E
        .long $ADFBD9, $A2F66B, $D50000, $A2F96D
        .byte 1
        ; MasterKnight
        .long $ADF4CB, $A5CE40, $ADEDD1, $A5BBB8
        .long $ADEA4E, $A5B553, $ADE6C6, $A5AF39
        .long $ADF10B, $A5AF39, $ADF890, $A5C1D7
        .long $ADFBD9, $A5C7E4, $D50000, $A5CE40
        .byte 1
        ; Paladin
        .long $ADF4CB, $A7B1DB, $ADEDD1, $A7A11A
        .long $ADEA4E, $A79B12, $ADE6C6, $A79536
        .long $ADF10B, $A79536, $ADF890, $A7A6A4
        .long $ADFBD9, $A7AC2D, $D50000, $A7B1DB
        .byte 1
        ; PaladinF
        .long $ADF4CB, $A78F7B, $ADEDD1, $A6FF22
        .long $ADEA4E, $A6F94B, $ADE6C6, $A6F392
        .long $ADF10B, $A6F392, $ADF890, $A784C2
        .long $ADFBD9, $A789F9, $D50000, $A78F7B
        .byte 1
        ; ArchKnight
        .long $ADF4CB, $A0D607, $ADEDD1, $A0CE50
        .long $ADEA4E, $A0CBEA, $ADE6C6, $A0C992
        .long $ADF10B, $A0C992, $ADF890, $A0D0F2
        .long $ADFBD9, $A0D35A, $D50000, $A0D607
        .byte 1
        ; Ranger
        .long $ADF4CB, $A4B00B, $ADEDD1, $A4A7DB
        .long $ADEA4E, $A4A4EB, $ADE6C6, $A4A1E9
        .long $ADF10B, $A4A1E9, $ADF890, $A4AAA5
        .long $ADFBD9, $A4AD3B, $D50000, $A4B00B
        .byte 1
        ; MageKnight
        .long $ADF4CB, $ABEFDD, $ADEDD1, $ABE015
        .long $ADEA4E, $ABDA4A, $ADE6C6, $ABD4B1
        .long $ADF10B, $ABD4B1, $ADF890, $ABE525
        .long $ADFBD9, $ABEA44, $D50000, $ABEFDD
        .byte 1
        ; GreatKnight
        .long $ADF4CB, $A38A8E, $ADEDD1, $A3825F
        .long $ADEA4E, $A2FF6D, $ADE6C6, $A2FC7C
        .long $ADF10B, $A2FC7C, $ADF890, $A38530
        .long $ADFBD9, $A387C2, $D50000, $A38A8E
        .byte 1
        ; PegasusRider
        .long $D528B8, $A7E6F4, $D523F3, $A7D9E8
        .long $D52134, $A7D5BB, $D51EE2, $A7D186
        .long $D52630, $A7D186, $D52B4C, $A7DE05
        .long $D52D65, $A7E282, $D52FDC, $A7E6F4
        .byte 1
        ; PegasusKnight
        .long $D528B8, $A7CD09, $D523F3, $A7BFF9
        .long $D52134, $A7BBBF, $D51EE2, $A7B788
        .long $D52630, $A7B788, $D52B4C, $A7C409
        .long $D52D65, $A7C879, $D52FDC, $A7CD09
        .byte 1
        ; FalconKnight
        .long $D528B8, $A3F50C, $D523F3, $A3DEAB
        .long $D52134, $A3D786, $D51EE2, $A3CFD9
        .long $D52630, $A3CFD9, $D52B4C, $A3E64B
        .long $D52D65, $A3EDAA, $D52FDC, $A3F50C
        .byte 1
        ; Dragonrider
        .long $ADA7B5, $A2E51A, $ADA37A, $A2D726
        .long $ADA150, $A2D334, $AD9F97, $A2CEC0
        .long $ADA578, $A2CEC0, $ADA9C5, $A2DBD4
        .long $ADAB7F, $A2DFFB, $ADAD79, $A2E51A
        .byte 1
        ; Dragonknight
        .long $ADA7B5, $A1F489, $ADA37A, $A1E63B
        .long $ADA150, $A1E25B, $AD9F97, $A1DDF1
        .long $ADA578, $A1DDF1, $ADA9C5, $A1EB31
        .long $ADAB7F, $A1EF62, $ADAD79, $A1F489
        .byte 1
        ; Dragonmaster
        .long $ADA7B5, $A2ADD8, $ADA37A, $A29F0C
        .long $ADA150, $A29B16, $AD9F97, $A29697
        .long $ADA578, $A29697, $ADA9C5, $A2A41B
        .long $ADAB7F, $A2A86E, $ADAD79, $A2ADD8
        .byte 1
        ; Archer
        .long $AD9A90, $A0C809, $AD9811, $A0C472
        .long $AD96F4, $A0C352, $AD95BD, $A0C252
        .long $AD995A, $A0C252, $AD9BD2, $A0C59B
        .long $AD9D12, $A0C6CA, $AD9E4B, $A0C809
        .byte 0
        ; Myrmidon
        .long $ADCC79, $AAED54, $ADC8CA, $AAE6E1
        .long $ADC6E8, $AAE3BC, $ADC56D, $AAE08C
        .long $ADCA27, $AAE08C, $ADCED6, $AAE83C
        .long $ADD039, $AAEA0D, $ADD233, $AAED54
        .byte 0
        ; Swordmaster
        .long $ADCC79, $AA8B7B, $ADC8CA, $AA8467
        .long $ADC6E8, $AA812E, $ADC56D, $A9FE02
        .long $ADCA27, $A9FE02, $ADCED6, $AA85DA
        .long $ADD039, $AA87D2, $ADD233, $AA8B7B
        .byte 0
        ; Sniper
        .long $AD9A90, $AAB1CC, $AD9811, $AAAE30
        .long $AD96F4, $AAACF9, $AD95BD, $AAAC0F
        .long $AD995A, $AAAC0F, $AD9BD2, $AAAF56
        .long $AD9D12, $AAB08A, $AD9E4B, $AAB1CC
        .byte 0
        ; Hero
        .long $ADCC79, $A49DE7, $ADC8CA, $A495F2
        .long $ADC6E8, $A4925E, $ADC56D, $A48ED0
        .long $ADCA27, $A48ED0, $ADCED6, $A4978F
        .long $ADD039, $A499C1, $ADD233, $A49DE7
        .byte 0
        ; General
        .long $ACFBAC, $A4D0B9, $ACF405, $A4C72D
        .long $ACF029, $A4C497, $ACEC8F, $A4C198
        .long $ACF7A3, $A4C198, $ACFFEE, $A4CA6F
        .long $AD835A, $A4CD75, $AD8745, $A4D0B9
        .byte 0
        ; Emperor
        .long $ACFBAC, $A3ABA3, $ACF405, $A39978
        .long $ACF029, $A393A2, $ACEC8F, $A38D58
        .long $ACF7A3, $A38D58, $ACFFEE, $A39FA1
        .long $AD835A, $A3A542, $AD8745, $A3ABA3
        .byte 0
        ; Baron
        .long $ACFBAC, $A0F859, $ACF405, $A0E56D
        .long $ACF029, $A0DF8B, $ACEC8F, $A0D8AB
        .long $ACF7A3, $A0D8AB, $ACFFEE, $A0EBA0
        .long $AD835A, $A0F163, $AD8745, $A0F859
        .byte 0
        ; Soldier
        .long $ACDF93, $A08CF4, $ACD92B, $A08501
        .long $ACD606, $A082A2, $ACD31C, $A08000
        .long $ACDC16, $A08000, $ACE32A, $A08784
        .long $ACE615, $A08A50, $ACE977, $A08CF4
        .byte 0
        ; SpearSoldier
        .long $ACDF93, $A08CF4, $ACD92B, $A08501
        .long $ACD606, $A082A2, $ACD31C, $A08000
        .long $ACDC16, $A08000, $ACE32A, $A08784
        .long $ACE615, $A08A50, $ACE977, $A08CF4
        .byte 0
        ; AxeSoldier
        .long $ACDF93, $A08CF4, $ACD92B, $A08501
        .long $ACD606, $A082A2, $ACD31C, $A08000
        .long $ACDC16, $A08000, $ACE32A, $A08784
        .long $ACE615, $A08A50, $ACE977, $A08CF4
        .byte 0
        ; BowSoldier
        .long $ACDF93, $A08CF4, $ACD92B, $A08501
        .long $ACD606, $A082A2, $ACD31C, $A08000
        .long $ACDC16, $A08000, $ACE32A, $A08784
        .long $ACE615, $A08A50, $ACE977, $A08CF4
        .byte 0
        ; SwordSoldier
        .long $ACDF93, $A08CF4, $ACD92B, $A08501
        .long $ACD606, $A082A2, $ACD31C, $A08000
        .long $ACDC16, $A08000, $ACE32A, $A08784
        .long $ACE615, $A08A50, $ACE977, $A08CF4
        .byte 0
        ; LanceArmor
        .long $ACDF93, $A08CF4, $ACD92B, $A08501
        .long $ACD606, $A082A2, $ACD31C, $A08000
        .long $ACDC16, $A08000, $ACE32A, $A08784
        .long $ACE615, $A08A50, $ACE977, $A08CF4
        .byte 0
        ; AxeArmor
        .long $ACDF93, $A08CF4, $ACD92B, $A08501
        .long $ACD606, $A082A2, $ACD31C, $A08000
        .long $ACDC16, $A08000, $ACE32A, $A08784
        .long $ACE615, $A08A50, $ACE977, $A08CF4
        .byte 0
        ; BowArmor
        .long $ACDF93, $A08CF4, $ACD92B, $A08501
        .long $ACD606, $A082A2, $ACD31C, $A08000
        .long $ACDC16, $A08000, $ACE32A, $A08784
        .long $ACE615, $A08A50, $ACE977, $A08CF4
        .byte 0
        ; SwordArmor
        .long $ACDF93, $A08CF4, $ACD92B, $A08501
        .long $ACD606, $A082A2, $ACD31C, $A08000
        .long $ACDC16, $A08000, $ACE32A, $A08784
        .long $ACE615, $A08A50, $ACE977, $A08CF4
        .byte 0
        ; Barbarian
        .long $AD904F, $A0ABAC, $AD8DB0, $A0A43A
        .long $AD8C5B, $A0A20F, $AD8B10, $A09F53
        .long $AD8F00, $A09F53, $AD91C6, $A0A6F2
        .long $AD930D, $A0A93A, $AD947A, $A0ABAC
        .byte 0
        ; Fighter
        .long $AD904F, $A09C49, $AD8DB0, $A09498
        .long $AD8C5B, $A09267, $AD8B10, $A08FC2
        .long $AD8F00, $A08FC2, $AD91C6, $A09761
        .long $AD930D, $A099B1, $AD947A, $A09C49
        .byte 0
        ; Brigand
        .long $AD904F, $A6E1B9, $AD8DB0, $A6D9E9
        .long $AD8C5B, $A6D7A8, $AD8B10, $A6D4FD
        .long $AD8F00, $A6D4FD, $AD91C6, $A6DCCB
        .long $AD930D, $A6DF0D, $AD947A, $A6E1B9
        .byte 0
        ; Warrior
        .long $ADDCED, $ACA6D3, $ADD80A, $AC9A19
        .long $ADD5EA, $AC9648, $ADD39B, $AC91BF
        .long $ADDA75, $AC91BF, $ADDF86, $AC9E5E
        .long $ADE1DC, $ACA24F, $ADE463, $ACA6D3
        .byte 0
        ; Hunter
        .long $ADDCED, $A4BE6B, $ADD80A, $A4B77E
        .long $ADD5EA, $A4B58A, $ADD39B, $A4B2E0
        .long $ADDA75, $A4B2E0, $ADDF86, $A4B9CD
        .long $ADE1DC, $A4BBE8, $ADE463, $A4BE6B
        .byte 0
        ; Pirate
        .long $AD904F, $A6F0B0, $AD8DB0, $A6E936
        .long $AD8C5B, $A6E717, $AD8B10, $A6E470
        .long $AD8F00, $A6E470, $AD91C6, $A6EBF4
        .long $AD930D, $A6EE33, $AD947A, $A6F0B0
        .byte 0
        ; JuniorLord
        .long $D66B0C, $A4E30D, $D6693A, $A4DB00
        .long $D6680A, $A4D7AD, $D66761, $A4D411
        .long $D669DE, $A4D411, $D66C35, $A4DD21
        .long $D66CE1, $A4DF51, $D66E2A, $A4E30D
        .byte 0
        ; WarMage
        .long $ADC013, $A6B0FD, $ADBD4A, $A6A3BA
        .long $ADBBC7, $A69FA0, $ADBA86, $A69BEB
        .long $ADBE85, $A69BEB, $ADC199, $A6A784
        .long $ADC2D4, $A6ABE5, $ADC436, $A6B0FD
        .byte 0
        ; Prince
        .long $D66B0C, $A89CC4, $D6693A, $A89492
        .long $D6680A, $A8911B, $D66761, $A88D85
        .long $D669DE, $A88D85, $D66C35, $A896CC
        .long $D66CE1, $A898F2, $D66E2A, $A89CC4
        .byte 0
        ; Princess
        .long $ADC013, $A8B74F, $ADBD4A, $A8A9AC
        .long $ADBBC7, $A8A552, $ADBA86, $A8A0E3
        .long $ADBE85, $A8A0E3, $ADC199, $A8ADE3
        .long $ADC2D4, $A8B273, $ADC436, $A8B74F
        .byte 0
        ; WarMageF
        .long $ADC013, $A69712, $ADBD4A, $A68A97
        .long $ADBBC7, $A68686, $ADBA86, $A682C9
        .long $ADBE85, $A682C9, $ADC199, $A68E87
        .long $ADC2D4, $A69293, $ADC436, $A69712
        .byte 0
        ; Queen
        .long $ADC013, $A8CA36, $ADBD4A, $A8C16A
        .long $ADBBC7, $A8BECA, $ADBA86, $A8BC3F
        .long $ADBE85, $A8BC3F, $ADC199, $A8C3F0
        .long $ADC2D4, $A8C708, $ADC436, $A8CA36
        .byte 0
        ; Dancer
        .long $ADB4CB, $A19E6A, $ADB1F1, $A196A1
        .long $ADB068, $A19376, $ADAF0F, $A19090
        .long $ADB335, $A19090, $ADB666, $A198CB
        .long $ADB7AA, $A19B43, $ADB93C, $A19E6A
        .byte 0
        ; Priest
        .long $ADC013, $A88A76, $ADBD4A, $A8827A
        .long $ADBBC7, $A7FF9A, $ADBA86, $A7FCD3
        .long $ADBE85, $A7FCD3, $ADC199, $A884F6
        .long $ADC2D4, $A88764, $ADC436, $A88A76
        .byte 0
        ; Mage
        .long $ADC013, $A6D1ED, $ADBD4A, $A6C964
        .long $ADBBC7, $A6C6A5, $ADBA86, $A6C402
        .long $ADBE85, $A6C402, $ADC199, $A6CC07
        .long $ADC2D4, $A6CED2, $ADC436, $A6D1ED
        .byte 0
        ; FireMage
        .long $ADC013, $A3CD28, $ADBD4A, $A3C579
        .long $ADBBC7, $A3C308, $ADBA86, $A3C0E9
        .long $ADBE85, $A3C0E9, $ADC199, $A3C7D4
        .long $ADC2D4, $A3CA82, $ADC436, $A3CD28
        .byte 0
        ; ThunderMage
        .long $ADC013, $AB9E22, $ADBD4A, $AB9668
        .long $ADBBC7, $AB9423, $ADBA86, $AB9208
        .long $ADBE85, $AB9208, $ADC199, $AB98D0
        .long $ADC2D4, $AB9B8E, $ADC436, $AB9E22
        .byte 0
        ; WindMage
        .long $ADC013, $ACC635, $ADBD4A, $ACBEC3
        .long $ADBBC7, $ACBC94, $ADBA86, $ACBA7A
        .long $ADBE85, $ACBA7A, $ADC199, $ACC12B
        .long $ADC2D4, $ACC3A0, $ADC436, $ACC635
        .byte 0
        ; HighPriest
        .long $ADC013, $A5F01D, $ADBD4A, $A5E7EF
        .long $ADBBC7, $A5E57B, $ADBA86, $A5E35F
        .long $ADBE85, $A5E35F, $ADC199, $A5EA5B
        .long $ADC2D4, $A5ED72, $ADC436, $A5F01D
        .byte 0
        ; Bishop
        .long $ADC013, $A18D71, $ADBD4A, $A18438
        .long $ADBBC7, $A18193, $ADBA86, $A0FEDF
        .long $ADBE85, $A0FEDF, $ADC199, $A18704
        .long $ADC2D4, $A18A23, $ADC436, $A18D71
        .byte 0
        ; Sage
        .long $ADC013, $A8EA83, $ADBD4A, $A8E225
        .long $ADBBC7, $A8DFBE, $ADBA86, $A8DD73
        .long $ADBE85, $A8DD73, $ADC199, $A8E4BF
        .long $ADC2D4, $A8E7A1, $ADC436, $A8EA83
        .byte 0
        ; Bard
        .long $ADC013, $A0B8DF, $ADBD4A, $A0B279
        .long $ADBBC7, $A0B070, $ADBA86, $A0AE8B
        .long $ADBE85, $A0AE8B, $ADC199, $A0B46B
        .long $ADC2D4, $A0B69D, $ADC436, $A0B8DF
        .byte 0
        ; Priestess
        .long $ADC013, $A9EB7B, $ADBD4A, $A9E452
        .long $ADBBC7, $A9E25E, $ADBA86, $A9DFFE
        .long $ADBE85, $A9DFFE, $ADC199, $A9E6AD
        .long $ADC2D4, $A9E903, $ADC436, $A9EB7B
        .byte 0
        ; DarkMage
        .long $ADC013, $A1BF5C, $ADBD4A, $A1B75A
        .long $ADBBC7, $A1B4AD, $ADBA86, $A1B249
        .long $ADBE85, $A1B249, $ADC199, $A1B9CF
        .long $ADC2D4, $A1BCAB, $ADC436, $A1BF5C
        .byte 0
        ; DarkBishop
        .long $ADC013, $A1AF51, $ADBD4A, $A1A6A2
        .long $ADBBC7, $A1A409, $ADBA86, $A1A1A7
        .long $ADBE85, $A1A1A7, $ADC199, $A1A8F4
        .long $ADC2D4, $A1ABEF, $ADC436, $A1AF51
        .byte 0
        ; Thief
        .long $D672E2, $AB81EF, $D670EE, $AAFD13
        .long $D66FC6, $AAFBAF, $D66ED6, $AAFA0F
        .long $D671DC, $AAFA0F, $D67408, $AAFEB0
        .long $D674F4, $AB805B, $D67607, $AB81EF
        .byte 0
        ; Rogue
        .long $D672E2, $ABB228, $D670EE, $ABAD5A
        .long $D66FC6, $ABABFA, $D66ED6, $ABAA5B
        .long $D671DC, $ABAA5B, $D67408, $ABAEEB
        .long $D674F4, $ABB0A1, $D67607, $ABB228
        .byte 0
        ; Civilian
        .long $ADB4CB, $AACF63, $ADB1F1, $AACB9F
        .long $ADB068, $AACA3C, $ADAF0F, $AAC90D
        .long $ADB335, $AAC90D, $ADB666, $AACCC7
        .long $ADB7AA, $AACE0C, $ADB93C, $AACF63
        .byte 0
        ; Child
        .long $ADB4CB, $AABF6A, $ADB1F1, $AABC2A
        .long $ADB068, $AABB27, $ADAF0F, $AABA0A
        .long $ADB335, $AABA0A, $ADB666, $AABD3B
        .long $ADB7AA, $AABE5A, $ADB93C, $AABF6A
        .byte 0
        ; Ballistician
        .long $D66343, $A8FBAD, $D66118, $A8F46F
        .long $D6601E, $A8F112, $D65F0D, $A8ED7E
        .long $D66227, $A8F825, $D66444, $A8FF68
        .long $D66556, $A9835D, $D66652, $A98680
        .byte 1
        ; IronBallistician
        .long $D66343, $A99857, $D66118, $A99158
        .long $D6601E, $A98DFB, $D65F0D, $A98A62
        .long $D66227, $A994D4, $D66444, $A99C0A
        .long $D66556, $A99FF7, $D66652, $A9A309
        .byte 1
        ; KillerBallistician
        .long $D66343, $A9B4D6, $D66118, $A9ADB1
        .long $D6601E, $A9AA61, $D65F0D, $A9A6C8
        .long $D66227, $A9B147, $D66444, $A9B869
        .long $D66556, $A9BC3E, $D66652, $A9BF43
        .byte 1
        ; GreatBallistician
        .long $D66343, $A9D0EF, $D66118, $A9C97D
        .long $D6601E, $A9C650, $D65F0D, $A9C2D8
        .long $D66227, $A9CD2F, $D66444, $A9D4C6
        .long $D66556, $A9D8F4, $D66652, $A9DC22
        .byte 1
        ; DarkPrince
        .long $ADC013, $A68003, $ADBD4A, $A5F823
        .long $ADBBC7, $A5F554, $ADBA86, $A5F328
        .long $ADBE85, $A5F328, $ADC199, $A5FA54
        .long $ADC2D4, $A5FD17, $ADC436, $A68003
        .byte 0
        ; MasterKnightFemale
        .long $ADF4CB, $A5A904, $ADEDD1, $A59744
        .long $ADEA4E, $A59112, $ADE6C6, $A58ACE
        .long $ADF10B, $A58ACE, $ADF890, $A59D62
        .long $ADFBD9, $A5A2C9, $D50000, $A5A904
        .byte 1
        ; MageKnightFemale
        .long $ADF4CB, $ABCF52, $ADEDD1, $ABBF33
        .long $ADEA4E, $ABB99C, $ADE6C6, $ABB3E8
        .long $ADF10B, $ABB3E8, $ADF890, $ABC43D
        .long $ADFBD9, $ABC9B0, $D50000, $ABCF52
        .byte 1
        ; DragonRiderFemale
        .long $ADA7B5, $A2C989, $ADA37A, $A2BB7F
        .long $ADA150, $A2B7B2, $AD9F97, $A2B360
        .long $ADA578, $A2B360, $ADA9C5, $A2C04E
        .long $ADAB7F, $A2C469, $ADAD79, $A2C989
        .byte 1
        ; DragonknightFemale
        .long $ADA7B5, $A1D8C1, $ADA37A, $A1CA4B
        .long $ADA150, $A1C67B, $AD9F97, $A1C23C
        .long $ADA578, $A1C23C, $ADA9C5, $A1CF61
        .long $ADAB7F, $A1D39D, $ADAD79, $A1D8C1
        .byte 1
        ; DragonmasterFemale
        .long $ADA7B5, $A29107, $ADA37A, $A28228
        .long $ADA150, $A1FE4A, $AD9F97, $A1F9D6
        .long $ADA578, $A1F9D6, $ADA9C5, $A2873F
        .long $ADAB7F, $A28BA1, $ADAD79, $A29107
        .byte 1
        ; ArcherFemale
        .long $AD9A90, $A0C0E9, $AD9811, $A0BD74
        .long $AD96F4, $A0BC63, $AD95BD, $A0BB5A
        .long $AD995A, $A0BB5A, $AD9BD2, $A0BEAE
        .long $AD9D12, $A0BFC8, $AD9E4B, $A0C0E9
        .byte 0
        ; MyrmidonFemale
        .long $ADCC79, $AADCCC, $ADC8CA, $AAD684
        .long $ADC6E8, $AAD3DC, $ADC56D, $AAD0AC
        .long $ADCA27, $AAD0AC, $ADCED6, $AAD80B
        .long $ADD039, $AAD9A2, $ADD233, $AADCCC
        .byte 0
        ; SwordmasterFemale
        .long $ADCC79, $A9FA2A, $ADC8CA, $A9F3B6
        .long $ADC6E8, $A9F10C, $ADC56D, $A9EDCD
        .long $ADCA27, $A9EDCD, $ADCED6, $A9F53D
        .long $ADD039, $A9F6DD, $ADD233, $A9FA2A
        .byte 0
        ; SniperFemale
        .long $AD9A90, $AAAA74, $AD9811, $AAA6BB
        .long $AD96F4, $AAA5A4, $AD95BD, $AAA486
        .long $AD995A, $AAA486, $AD9BD2, $AAA7F6
        .long $AD9D12, $AAA92C, $AD9E4B, $AAAA74
        .byte 0
        ; HeroFemale
        .long $ADCC79, $A48A78, $ADC8CA, $A48344
        .long $ADC6E8, $A48019, $ADC56D, $A3FC94
        .long $ADCA27, $A3FC94, $ADCED6, $A484FC
        .long $ADD039, $A486EA, $ADD233, $A48A78
        .byte 0
        ; PriestFemale
        .long $ADC013, $A7F9D7, $ADBD4A, $A7F146
        .long $ADBBC7, $A7EE34, $ADBA86, $A7EB5C
        .long $ADBE85, $A7EB5C, $ADC199, $A7F412
        .long $ADC2D4, $A7F6C6, $ADC436, $A7F9D7
        .byte 0
        ; MageFemale
        .long $ADC013, $A6C184, $ADBD4A, $A6BA52
        .long $ADBBC7, $A6B822, $ADBA86, $A6B5D4
        .long $ADBE85, $A6B5D4, $ADC199, $A6BCA0
        .long $ADC2D4, $A6BF0D, $ADC436, $A6C184
        .byte 0
        ; FireMageFemale
        .long $ADC013, $A3BE34, $ADBD4A, $A3B6A0
        .long $ADBBC7, $A3B491, $ADBA86, $A3B26E
        .long $ADBE85, $A3B26E, $ADC199, $A3B8E8
        .long $ADC2D4, $A3BB9E, $ADC436, $A3BE34
        .byte 0
        ; ThunderMageFemale
        .long $ADC013, $AB8F6F, $ADBD4A, $AB8816
        .long $ADBBC7, $AB85F7, $ADBA86, $AB83A2
        .long $ADBE85, $AB83A2, $ADC199, $AB8A5A
        .long $ADC2D4, $AB8CDD, $ADC436, $AB8F6F
        .byte 0
        ; WindMageFemale
        .long $ADC013, $ACB7E2, $ADBD4A, $ACB005
        .long $ADBBC7, $ACAD97, $ADBA86, $ACAB39
        .long $ADBE85, $ACAB39, $ADC199, $ACB26E
        .long $ADC2D4, $ACB50D, $ADC436, $ACB7E2
        .byte 0
        ; HighPriestFemale
        .long $ADC013, $A5E0A2, $ADBD4A, $A5D8FA
        .long $ADBBC7, $A5D6B3, $ADBA86, $A5D458
        .long $ADBE85, $A5D458, $ADC199, $A5DB55
        .long $ADC2D4, $A5DE20, $ADC436, $A5E0A2
        .byte 0
        ; SageFemale
        .long $ADC013, $A8DA64, $ADBD4A, $A8D223
        .long $ADBBC7, $A8CFA3, $ADBA86, $A8CD61
        .long $ADBE85, $A8CD61, $ADC199, $A8D471
        .long $ADC2D4, $A8D78F, $ADC436, $A8DA64
        .byte 0
        ; ThiefFemale
        .long $D672E2, $AAF846, $D670EE, $AAF3A2
        .long $D66FC6, $AAF261, $D66ED6, $AAF0D4
        .long $D671DC, $AAF0D4, $D67408, $AAF534
        .long $D674F4, $AAF6C1, $D67607, $AAF846
        .byte 0
        ; RogueFemale
        .long $D672E2, $ABA888, $D670EE, $ABA3C8
        .long $D66FC6, $ABA271, $D66ED6, $ABA0DF
        .long $D671DC, $ABA0DF, $D67408, $ABA55D
        .long $D674F4, $ABA70D, $D67607, $ABA888
        .byte 0
        ; CivilianFemale
        .long $ADB4CB, $AAC797, $ADB1F1, $AAC346
        .long $ADB068, $AAC1E1, $ADAF0F, $AAC08F
        .long $ADB335, $AAC08F, $ADB666, $AAC499
        .long $ADB7AA, $AAC613, $ADB93C, $AAC797
        .byte 0
        ; ChildFemale
        .long $ADB4CB, $AAB8EA, $ADB1F1, $AAB57F
        .long $ADB068, $AAB489, $ADAF0F, $AAB35C
        .long $ADB335, $AAB35C, $ADB666, $AAB693
        .long $ADB7AA, $AAB7BF, $ADB93C, $AAB8EA
        .byte 0
        ; (no name in the original notes)
        .long $ADF4CB, $A4F610, $ADEDD1, $A4ED49
        .long $ADEA4E, $A4EA2A, $ADE6C6, $A4E705
        .long $ADF10B, $A4E705, $ADF890, $A4F03A
        .long $ADFBD9, $A4F313, $D50000, $A4F610
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

        lda $0302,b
        sta aProcSystem.aBody7,b,x

        stz $0302,b
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

        lda $10F7,b
        sta $7F4BD9

        lda $10F7,b
        ora #$4000
        sta $10F7,b

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
        sta $7F455A
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

        lda $7E4EBF
        sta @l wR0
        lda $7E4EC1
        sta @l wR1
        lda $7E4EBD
        sta @l wR2
        jsl rlUnknown9E85A4
        sta $454E,b
        lda $7E4EB7
        sta $4552,b
        lda $7E4EB9
        sta $4554,b

        lda #$FFFF
        jsl rlUnknown9E866F
        sta $454A,b

        lda #$FFFF
        sta $7E4EDD

        lda #0
        sta $4550,b
        sta $4556,b
        sta $4558,b
        sta $454C,b

        lda #$FFFF
        sta $7E4F15

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
        stz $0302,b

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
        PROC_CALL $9E9D76
        PROC_YIELD 4
        PROC_CALL $9E89F1
        PROC_YIELD 2
        PROC_CALL $9ED6BA
        PROC_YIELD 1
        PROC_CALL $9EA9B5
        PROC_SET_UNK_TIMER 96

        -
        PROC_YIELD 1
        PROC_CALL $96D695
        PROC_JUMP_WHILE_UNK_TIMER -

        PROC_CALL $9EAB21
        PROC_YIELD 16
        PROC_CALL $9ED6D6
        PROC_CALL $888197
        PROC_YIELD 4
        PROC_CALL $8881A7
        PROC_YIELD 1
        PROC_CALL $9ED71E
        PROC_END

      rlUnknown9ED5A1 ; 9E/D5A1

        .al
        .autsiz
        .databank ?

        phx
        lda wEventUnitSlot1ID,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        sta $7E4EB5
        jsl rlGetSelectedUnitClassID
        sta $7E4EBF
        jsl rlGetSelectedUnitGender
        sta $7E4EC1
        jsl rlGetSelectedUnitCharacterID
        sta $7E4EBD
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._XTilePosition,x
        sta $7E4EB7
        lda aDeploymentTable._YTilePosition,x
        sta $7E4EB9
        jsl rlGetFirstEquippableWeaponInInventory

        ldx wCurrentItemDataROMPointer,b
        bne +

        lda #$FFFF
        bra ++

        +
        jsl rlGetItemIDByInventorySlot

        +
        sta $7E4EDD
        jsl rlGetSelectedUnitDeploymentOffset
        sta $7E4EB5
        tax
        lda aDeploymentTable._State,x
        and #DeploymentAllegianceMask
        sta $7F4562
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

        lda @l $7F455E
        asl a
        clc
        adc @l $7F455E
        asl a
        sta wR0

        lda @l $7F454E
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

        lda #(`$ACCC17)<<8
        sta lR18+1
        lda #<>$ACCC17
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


    .section Unsorted9EDAE7Section

      .al
      .xl

      rlUnknown9EDAE7 ; 9E/DAE7

        .al
        .xl
        .autsiz
        .databank ?

        lda #$9E00
        sta lR44+1
        lda #$DAF6
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/DAF6

    .endsection Unsorted9EDAE7Section


    .section Unsorted9EDF7FSection

      .al
      .xl

      rlUnknown9EDF7F ; 9E/DF7F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$9E00
        sta lR44+1
        lda #$DF8E
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9E/DF8E

    .endsection Unsorted9EDF7FSection


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


    .section Unsorted9EF79DSection

      .al
      .xl

      rlUnknown9EF79D ; 9E/F79D

        .al
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #~$0002
        and #~$0004
        sta aProcSystem.aHeaderBitfield,b,x

        lda aProcSystem.aBody5,x
        asl a
        tax
        lda aBelhallaAttackingMagePositions,x
        cmp #$FFFF
        beq _End

          pha
          and #$00FF
          sta wR0
          pla
          xba
          and #$00FF
          sta wR1
          jsl rlGetUnitByCoordinates
          bcs +

            lda #1,s
            tax
            lda aProcSystem.aBody5,x
            tax
            lda aBelhallaAttackingMageDirections,x
            and #$00FF
            sta aProcSystem.wInput0

            lda #(`procUnknown9EF837)<<8
            sta lR44+1
            lda #<>procUnknown9EF837
            sta lR44
            jsl rlProcEngineCreateProc

            tay
            lda #1,s
            tax
            tya
            sta aProcSystem.aBody4,b,x

          +
          lda #1,s
          tax
          lda aProcSystem.aBody5,x
          inc a
          sta aProcSystem.aBody5,x
          bra +

        _End
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        +
        plx
        rtl

        .databank 0

    .endsection Unsorted9EF79DSection


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
        PROC_CALL $9E89F1
        PROC_CALL $9EB3DE
        PROC_YIELD 1
        PROC_CALL rlUnknown9EFA4F
        PROC_YIELD 32
        PROC_CALL rlUnknown9EFA9A
        PROC_CALL $888197
        PROC_YIELD 4
        PROC_CALL $8881A7
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
        jsr rlUnknown9E832C
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
        sta $0302,b
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

        lda #(`$9EFAE3)<<8
        sta lR44+1
        lda #<>$9EFAE3
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
          jsl rlUnknown80900D ; sound
        
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
