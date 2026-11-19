; Code from bank $9E not yet assigned to a game system.

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

        jsl $9E811F

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
        jsr $9E832C
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
          jsl $9EB4BB
          ora wR0
          jsl $80900D ; sound
        
        _FC23
        lda #(`$7F45AC)<<8
        sta lR18+1
        lda #<>$7F45AC
        clc
        adc #2
        sta lR18
        ldy #$000F
        lda #$00F1
        jsl $959F43
        bcc _End

          lda #0
          sta @l $7F4580

        _End
        plx
        ply
        rtl

        .databank 0

    .endsection Unsorted9EFA17Section
