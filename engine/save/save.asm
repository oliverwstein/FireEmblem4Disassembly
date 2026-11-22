; Saving to and loading from the four SRAM save slots (include/SRAM.h, the slot
; layout in include/Save.h). rlHandleSaveFile runs the save menu's choice:
; rlSaveToSaveSlot packs the game into a slot as bitfields (rsWriteBitpackedSaveData
; and the per-part save routines); rlLoadFromSaveSlot unpacks it and rebuilds each
; unit from the buffers (rlCreateUnitFromBuffers and the rsRestore... routines
; for the fields the save does not keep). A slot is valid when its checksum and
; magic number match (rsFillSaveSlotDataBuffers). Also kept in SRAM, outside the
; game state: unit losses and the game timer, written into the slots as they
; happen (rlRecordUnitLoss, rlTickGameTimer); the last used options; the best
; final ranking; the last saved slot; and the anti-tamper mark. Banks $87 and $91;
; the save menu's screen setup is in bank $80.

    .section CreateUnitFromBuffersByTypeSection

      .al
      .xl

      aCreateUnitFromBuffersByTypeHandlers .word <>rsCreateStaticUnitFromBuffers, <>rsCreateDynamicUnitFromBuffers, <>rsCreateHolyUnitFromBuffers, <>rsCreateEnemyUnitFromBuffers ; 87/F574

      rsCreateStaticUnitFromBuffers ; 87/F57C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aStaticUnitRAMArea)<<8
        sta lR18+1
        lda #<>aStaticUnitRAMArea
        sta lR18
        jsl rlLoadRAMAreaPointer
        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda #$00
        sta $7E0000,x
        rep #$20
        lda #$001E
        jsl rlAllocateRAMArea
        lda lR25+1
        sta $7E0002,x
        lda lR25
        clc
        adc #$0000
        sta $7E0001,x
        lda lR25+1
        sta $7E0005,x
        lda lR25
        clc
        adc #$000F
        sta $7E0004,x
        lda #$83AD
        sta $7E0008,x
        tya
        clc
        adc #$000D
        sta $7E0007,x
        lda #$0000
        sta $7E000B,x
        sta $7E000A,x
        lda #$7F00
        sta lRAMBufferPointer+1,b
        lda #$EB66
        sta lRAMBufferPointer,b
        jsl rlLoadExtendedCharacterDataFromBuffer
        jsr rsRestoreLeadershipStars
        lda #(`aUnit1DataBuffer)<<8
        sta lRAMBufferPointer+1,b
        lda #<>aUnit1DataBuffer
        sta lRAMBufferPointer,b
        jsl rlLoadPersonalCharacterDataFromBuffer
        jsr rsRestorePersonalData
        jsr rsGatherUnitItems
        jsr rsCreateUnitInventory
        jsr rsCreateUnitLoverData
        plx
        rts

        .databank 0

        ; 87/F60B

      rsCreateDynamicUnitFromBuffers ; 87/F60B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aDynamicUnitRAMArea)<<8
        sta lR18+1
        lda #<>aDynamicUnitRAMArea
        sta lR18
        jsl rlLoadRAMAreaPointer
        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda #$01
        sta $7E0000,x
        rep #$20
        lda #$0034
        jsl rlAllocateRAMArea
        lda lR25+1
        sta $7E0002,x
        lda lR25
        clc
        adc #$0000
        sta $7E0001,x
        lda lR25+1
        sta $7E0005,x
        lda lR25
        clc
        adc #$000F
        sta $7E0004,x
        lda lR25+1
        sta $7E0008,x
        lda lR25
        clc
        adc #$001E
        sta $7E0007,x
        lda #$0000
        sta $7E000B,x
        sta $7E000A,x
        lda #$7F00
        sta lRAMBufferPointer+1,b
        lda #$EB84
        sta lRAMBufferPointer,b
        jsl rlLoadCharacterROMDataFromBuffer
        jsr rsRestoreDynamicConstantData
        lda #$7F00
        sta lRAMBufferPointer+1,b
        lda #$EB66
        sta lRAMBufferPointer,b
        jsl rlLoadExtendedCharacterDataFromBuffer
        jsr rsRestoreLeadershipStars
        lda #(`aUnit1DataBuffer)<<8
        sta lRAMBufferPointer+1,b
        lda #<>aUnit1DataBuffer
        sta lRAMBufferPointer,b
        jsl rlLoadPersonalCharacterDataFromBuffer
        jsr rsRestorePersonalData
        jsr rsGatherUnitItems
        jsr rsCreateUnitInventory
        jsr rsCreateUnitLoverData
        plx
        rts

        .databank 0

        ; 87/F6AD

      rsCreateHolyUnitFromBuffers ; 87/F6AD

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aHolyAndEnemyRAMArea)<<8
        sta lR18+1
        lda #<>aHolyAndEnemyRAMArea
        sta lR18
        jsl rlLoadRAMAreaPointer
        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda #$02
        sta $7E0000,x
        rep #$20
        lda #$000F
        jsl rlAllocateRAMArea
        lda lR25+1
        sta $7E0002,x
        lda lR25
        clc
        adc #$0000
        sta $7E0001,x
        lda #$83AD
        sta $7E0005,x
        tya
        clc
        adc #$0001
        sta $7E0004,x
        lda #$83AD
        sta $7E0008,x
        tya
        clc
        adc #$000D
        sta $7E0007,x
        lda #$0000
        sta $7E000B,x
        sta $7E000A,x
        lda #$0000
        sta $7E0011,x
        sta $7E0010,x
        lda #(`aUnit1DataBuffer)<<8
        sta lRAMBufferPointer+1,b
        lda #<>aUnit1DataBuffer
        sta lRAMBufferPointer,b
        jsl rlLoadPersonalCharacterDataFromBuffer
        jsr rsRestorePersonalData
        jsr rsCreateUnitInventory
        plx
        rts

        .databank 0

        ; 87/F72E

      rsCreateEnemyUnitFromBuffers ; 87/F72E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wRoutineVariable1,b
        pha
        lda #(`aHolyAndEnemyRAMArea)<<8
        sta lR18+1
        lda #<>aHolyAndEnemyRAMArea
        sta lR18
        jsl rlLoadRAMAreaPointer
        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda #$03
        sta $7E0000,x
        rep #$20
        lda #$000F
        jsl rlAllocateRAMArea
        lda lR25+1
        sta $7E0002,x
        lda lR25
        clc
        adc #$0000
        sta $7E0001,x
        lda #$0000
        sta $7E0005,x
        sta $7E0004,x
        lda #$0000
        sta $7E0008,x
        sta $7E0007,x
        lda #$83AD
        sta $7E000B,x
        tya
        clc
        adc #$0001
        sta $7E000A,x
        lda #$0000
        sta $7E0011,x
        sta $7E0010,x
        lda #(`aUnit1DataBuffer)<<8
        sta lRAMBufferPointer+1,b
        lda #<>aUnit1DataBuffer
        sta lRAMBufferPointer,b
        jsl rlLoadPersonalCharacterDataFromBuffer
        jsr rsRestorePersonalData
        jsr rsCreateUnitInventory
        pla
        sta wRoutineVariable1,b
        plx
        rts

        .databank 0

        ; 87/F7B2

      rsRestorePersonalData ; 87/F7B2

        .al
        .xl
        .autsiz
        .databank ?

        ; After the personal data comes back from the save: sets the fields the save does not keep: the love data ID (from the character ID), canto movement and the ring and weapon bonuses cleared, the lover cleared for holy and enemy units, and class money (the class's for player units; holy and enemy units keep the saved value unless it is 0).

        phb
        phx
        phy
        phy
        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda $7E0003,x
        pha
        rep #$20
        plb
        .databank ?
        lda $7E0001,x
        tay
        plx
        jsl rlGetSelectedUnitLoveDataIDByCharacterID
        sep #$20
        sta $0002,b,y
        lda #$00
        sta $000A,b,y
        sta $000B,b,y
        sta $0009,b,y
        rep #$20
        lda aSave.wCreatedUnitType,b
        cmp #$0000
        beq _F7FC
        cmp #$0001
        beq _F7FC
        lda #$0000
        sep #$20
        sta $0003,b,y
        rep #$20
        lda aUnit1DataBuffer._Personal.ClassMoney
        beq _F804

        _F7FC
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassMoney

        _F804
        sep #$20
        sta $000E,b,y
        rep #$20
        ply
        plx
        plb
        .databank ?
        rts

        .databank 0

        ; 87/F80F

      rsRestoreLeadershipStars ; 87/F80F

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets leadership stars, which the save does not keep: Sigurd and Quan 2, Seliph and Altena 3, Hannibal 5, everyone else 0.

        phb
        phx
        phy
        phy
        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda $7E0006,x
        pha
        rep #$20
        plb
        .databank ?
        lda $7E0004,x
        tay
        plx
        jsl rlGetSelectedUnitCharacterID
        cmp #Sigurd
        beq _F852
        cmp #Quan
        beq _F852
        cmp #Seliph
        beq _F84D
        cmp #Altena
        beq _F84D
        cmp #Hannibal
        beq _F848
        lda #$0000
        bra _F855


        _F848
        lda #$0005
        bra _F855


        _F84D
        lda #$0003
        bra _F855


        _F852
        lda #$0002

        _F855
        sep #$20
        sta $000A,b,y
        rep #$20
        ply
        plx
        plb
        .databank ?
        rts

        .databank 0

        ; 87/F860

      rsRestoreDynamicConstantData ; 87/F860

        .al
        .xl
        .autsiz
        .databank ?

        ; For a dynamic unit (a child), whose constant data lives in RAM: copies the six bytes the save does not keep from the character's ROM entry (Y, bank $83).

        phb
        phx
        phy
        phy
        ldx wSelectedUnitDataRAMPointer,b
        sep #$20
        lda $7E0009,x
        pha
        rep #$20
        plb
        .databank ?
        lda $7E0007,x
        tay
        plx
        lda #$0006
        sep #$20

        _F87C
        pha
        lda $830003,x
        sta $0000,b,y
        inc x
        inc y
        pla
        dec a
        bne _F87C
        rep #$20
        ply
        plx
        plb
        .databank $06
        rts

        .databank 0

        ; 87/F890

      rsCreateUnitInventory ; 87/F890

        .al
        .xl
        .autsiz
        .databank ?

        ; Allocates the unit's inventory and fills it: player units from the save buffer (rlLoadInventoryFromBuffer), holy and enemy units from their ROM equipment (with the status set to healthy meanwhile). Then sets the equipped weapon's stat bonus.

        ldx wSelectedUnitDataRAMPointer,b
        lda #(`aInventoryRAMArea)<<8
        sta lR18+1
        lda #<>aInventoryRAMArea
        sta lR18
        jsl rlLoadRAMAreaPointer
        lda #$000D
        jsl rlAllocateRAMArea
        lda lR25+1
        sta $7E000E,x
        lda lR25
        sta $7E000D,x
        lda aSave.wCreatedUnitType,b
        cmp #$0003
        beq _F8CE
        cmp #$0002
        beq _F8C7
        jsl rlLoadInventoryFromBuffer
        bra _F8EA


        _F8C7
        tya
        clc
        adc #$0023
        bra _F8D3


        _F8CE
        tya
        clc
        adc #$000A

        _F8D3
        tax
        jsl rlGetSelectedUnitStatus
        pha
        lda #StatusHealthy
        jsl rlSetSelectedUnitStatus
        txa
        jsl rlLoadEquipmentDataIntoSpecifiedInventory
        pla
        jsl rlSetSelectedUnitStatus

        _F8EA
        jsl rlSaveEquippedWeaponStatBonus
        rts

        .databank 0

        ; 87/F8EF

      rlLoadInventoryFromBuffer ; 87/F8EF

        .al
        .xl
        .autsiz
        .databank ?

        ; Builds the inventory's struct header and appends each item the buffer lists (aUnit1DataBuffer._Inventory), then restores the equipped weapon bits.

        phb
        phx
        phy
        tay
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E000E,x
        sta lStructPointer2+1,b
        sta lR18+1
        lda $7E000D,x
        clc
        adc #$0001
        sta lStructPointer2,b
        sta lR18
        lda #$0008
        sta wR0
        lda #$0001
        sta wR1
        jsl rlBuildRAMStructHeader
        lda aUnit1DataBuffer._Inventory.ItemCount
        beq _F958
        tay
        ldx #$0000

        _F924
        lda aUnit1DataBuffer._Inventory.Items,x
        and #$00FF
        phx
        pha
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        pla
        sta lStructPointer1,b
        ldx wSelectedUnitDataRAMPointer,b
        lda $7E000E,x
        sta lStructPointer2+1,b
        lda $7E000D,x
        clc
        adc #$0001
        sta lStructPointer2,b
        jsl rlAppendNewStructEntry
        jsl rlUnknown84F9EE
        plx
        inc x
        inc x
        dec y
        bne _F924

        _F958
        lda aUnit1DataBuffer._Inventory.EquippedWeaponBitfield
        sta wRoutineVariable1,b
        jsl rlSetSelectedUnitEquippedWeaponBitfield
        ply
        plx
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/F967

      rsCreateUnitLoverData ; 87/F967

        .al
        .xl
        .autsiz
        .databank ?

        ; Female units (generation ID 16 and up) keep love points: allocates their lover data and copies it from the buffer, turning a saved $01FF into $FFFF. Others get no lover data.

        phy
        jsl rlGetSelectedUnitGenerationID
        cmp #$0010
        bcs _F97E
        lda #$0000
        sta $7E0011,x
        sta $7E0010,x
        bra _F9CC


        _F97E
        ldx #$0000

        _F981
        lda aUnit1DataBuffer._Lover.LoveValue,x
        cmp #$01FF
        bne _F991
        lda #$FFFF
        sta aUnit1DataBuffer._Lover.LoveValue,x

        _F991
        inc x
        inc x
        cpx #$001E
        bne _F981
        ldx wSelectedUnitDataRAMPointer,b
        lda #(`aLoverRAMArea)<<8
        sta lR18+1
        lda #<>aLoverRAMArea
        sta lR18
        jsl rlLoadRAMAreaPointer
        lda #$001E
        jsl rlAllocateRAMArea
        lda lR25+1
        sta $7E0011,x
        lda lR25
        sta $7E0010,x
        lda #$7F00
        sta lRAMBufferPointer+1,b
        lda #$EBBA
        sta lRAMBufferPointer,b
        jsl rlCopySelectedUnitLoverData

        _F9CC
        ply
        rts

        .databank 0

        ; 87/F9CE

    .endsection CreateUnitFromBuffersByTypeSection


    .section CompactStaticDynamicUnitBuffer1UnitStatesSection

      .al
      .xl

      rlCompactStaticDynamicUnitBuffer1UnitStates ; 87/F9CE

        .al
        .autsiz
        .databank ?

        lda aUnit1DataBuffer._Personal.UnitStates
        sta wR0
        and #UnitStateArenaLevelMask
        sta wR1

        lda wR0
        and #(UnitStateMapAnimation | UnitStateMiracleActive | UnitStateGroupLeader | UnitStateDead)
        lsr a
        lsr a
        lsr a
        ora wR1
        sta wR1

        lda wR0
        and #(UnitStateDismounted | UnitStateGuardingCastle | UnitStateMoved | UnitStateFielded)
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        ora wR1
        sta aUnit1DataBuffer._Personal.UnitStates
        rtl

        .databank 0

        ; 87/F9F6

    .endsection CompactStaticDynamicUnitBuffer1UnitStatesSection


    .section CompactHolyEnemyUnitBuffer1UnitStatesSection

      .al
      .xl

      rlCompactHolyEnemyUnitBuffer1UnitStates ; 87/FA1E

        .al
        .autsiz
        .databank ?

        lda aUnit1DataBuffer._Personal.UnitStates
        sta wR0
        and #UnitStateArenaLevelMask
        sta wR1

        lda wR0
        and #(UnitStateGroupLeader | UnitStateDead)
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        ora wR1
        sta wR1

        lda wR0
        and #(UnitStateDismounted | UnitStateGuardingCastle | UnitStateMoved | UnitStateFielded)
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        ora wR1
        sta aUnit1DataBuffer._Personal.UnitStates

        lda aUnit1DataBuffer._Personal.ClassMoney
        beq +

          lda #1
          sta aUnit1DataBuffer._Personal.ClassMoney

        +
        rtl

        .databank 0

        ; 87FA57

    .endsection CompactHolyEnemyUnitBuffer1UnitStatesSection


    .section FillUnitsDeploymentSaveDataSection

      .al
      .xl

      rlFillUnitsDeploymentSaveData ; 87/FA83

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        phx
        jsl rlGetSelectedUnitDeploymentOffset
        bcs +

          tax
          lda aDeploymentTable._State,x
          xba
          sta aSave.wCharacterDeploymentState,b
          lda @l aDeploymentTable._XTilePosition,x
          sta aSave.wCharacterXPosition,b
          lda @l aDeploymentTable._YTilePosition,x
          sta aSave.wCharacterYPosition,b
          bra _End

        +
        lda #$00FF
        sta aSave.wCharacterDeploymentState,b
        sta aSave.wCharacterXPosition,b
        sta aSave.wCharacterYPosition,b
        
        _End
        plx
        plp
        plb
        rtl

        .databank 0

        ; 87/FABC

    .endsection FillUnitsDeploymentSaveDataSection


    .section FillItemsOwnerAndSlotDataSection

      .as
      .xl

      rlFillItemsOwnerAndSlotData ; 87/FBC5

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        phx
        lda #PI_IronSword1
        sta lR18

        jsl rlGetItemRAMStructEntryByPlayerItemIndex

          _Loop
          ldx wCurrentItemDataRAMPointer,b
          lda structItemRAMEntry.ItemState,b,x
          and #$00FF
          cmp #ItemStateInventory
          beq +

            cmp #ItemStateSupply
            bne _Next

          +
          pha
          lda structItemRAMEntry.OwnerRAMPointer,b,x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitCharacterID
          cmp #Gerrard
          bcc +

            brk

          +
          and #$003F
          sta lR19

          plx
          cpx #ItemStateSupply
          beq _FC33

            lda #(`aUnit1DataBuffer._Inventory)<<8
            sta lRAMBufferPointer+1,b
            lda #<>aUnit1DataBuffer._Inventory
            sta lRAMBufferPointer,b
            jsl rlSaveCharacterInventoryToBuffer
            ldx #0

            -
            lda aUnit1DataBuffer._Inventory.Items,x
            cmp lR18
            beq +

              inc x
              inc x
              cpx #7 * 2
              bne -

                brk

            +
            txa
            asl a
            asl a
            asl a
            asl a
            asl a
            ora lR19

          _FC33
          ldx wCurrentItemDataRAMPointer,b
          sta structItemRAMEntry.OwnerID_InventorySlot,b,x

          _Next
          lda wCurrentItemDataRAMPointer,b
          clc
          adc #size(structItemRAMEntry)
          sta wCurrentItemDataRAMPointer,b

          lda lR18
          inc a
          sta lR18
          cmp #len(aItemRAMData._Entry) + 1
          bne _Loop

        plx
        plp
        plb
        rtl

        .databank 0

    .endsection FillItemsOwnerAndSlotDataSection


    .section FillItemDurabilityDataSection

      .al
      .xl

      rlFillItemDurabilityData ; 87/FC51

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        phx
        lda #PI_IronSword1
        sta lR18
        jsl rlGetItemRAMStructEntryByPlayerItemIndex

          _Loop
          ldx wCurrentItemDataRAMPointer,b
          jsr rsCapItemDurability
          sep #$20
          lda structItemRAMEntry.Durability,b,x
          cmp #63
          bne +

            lda #$FF
            sta structItemRAMEntry.Durability,b,x

          +
          rep #$20
          lda structItemRAMEntry.ItemState,b,x
          and #$00FF
          cmp #ItemStateInventory
          beq +

            cmp #ItemStateSupply
            bne _Next

          +
          lda structItemRAMEntry.OwnerRAMPointer,b,x
          bit #$FE00
          bne _Next

            and #$003F
            jsl rlGetUnitRAMDataPointerByID
            bcs +

              lda wSelectedUnitDataRAMPointer,b
              sta structItemRAMEntry.OwnerRAMPointer,b,x
              bra _Next

          +
          lda #ItemStateUnobtained
          sta structItemRAMEntry.ItemState,b,x
          brk

          _Next
          lda wCurrentItemDataRAMPointer,b
          clc
          adc #size(structItemRAMEntry)
          sta wCurrentItemDataRAMPointer,b
          lda lR18
          inc a
          sta lR18
          cmp #256 + 1
          bne _Loop

        plx
        plp
        plb
        rtl

        .databank 0

    .endsection FillItemDurabilityDataSection


    .section Unsorted87FD09Section

      .al
      .xl

      rsGatherUnitItems ; 87/FD09

        .al
        .xl
        .autsiz
        .databank ?

        ; After loading, items carry their owner's character ID and inventory slot (structItemRAMEntry.OwnerID_InventorySlot). Finds this unit's items in inventory or supply, writes the unit pointer over that field, and puts the inventory items in the buffer's list in slot order, without gaps.

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        phx
        phy
        jsl rlGetSelectedUnitCharacterID
        sta lR19
        lda #$0000
        sta lR20
        sta aUnit1DataBuffer._Inventory.Items
        sta aUnit1DataBuffer._Inventory.Items+2
        sta aUnit1DataBuffer._Inventory.Items+4
        sta aUnit1DataBuffer._Inventory.Items+6
        sta aUnit1DataBuffer._Inventory.Items+8
        sta aUnit1DataBuffer._Inventory.Items+10
        sta aUnit1DataBuffer._Inventory.Items+12
        lda #$0001
        sta lR18
        jsl rlGetItemRAMStructEntryByPlayerItemIndex

        _FD45
        ldx wCurrentItemDataRAMPointer,b
        lda $0003,b,x
        bit #$FE00
        bne _FD9A
        and #$003F
        cmp lR19
        bne _FD9A
        lda structItemRAMEntry.ItemState,b,x
        and #$00FF
        cmp #ItemStateInventory
        beq _FD67
        cmp #ItemStateSupply
        bne _FD9A

        _FD67
        pha
        ldy $0003,b,x
        lda wSelectedUnitDataRAMPointer,b
        sta $0003,b,x
        pla
        cmp #$0002
        beq _FD9A
        tya
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        and #$000E
        tax
        beq _FD92
        cpx #$000E
        beq _FD8E

        _FD88
        lda aUnit1DataBuffer._Inventory.Items,x
        beq _FD92

        _FD8E
        dec x
        dec x
        bne _FD88

        _FD92
        lda lR18
        sta aUnit1DataBuffer._Inventory.Items,x
        inc lR20

        _FD9A
        lda wCurrentItemDataRAMPointer,b
        clc
        adc #$0006
        sta wCurrentItemDataRAMPointer,b
        lda lR18
        inc a
        sta lR18
        cmp #$0101
        bne _FD45
        lda lR20
        sta aUnit1DataBuffer._Inventory.ItemCount
        beq _FDD4
        lda #$7F00
        pha
        plb
        .databank $00
        plb
        .databank $00
        ldx #$0000
        ldy #$0000

        _FDC2
        lda aUnit1DataBuffer._Inventory.Items,x
        beq _FDCD
        sta <>aUnit1DataBuffer._Inventory.Items,b,y
        inc y
        inc y

        _FDCD
        inc x
        inc x
        cpx #$000E
        bne _FDC2

        _FDD4
        ply
        plx
        plp
        plb
        .databank $00
        rts

        .databank 0

        ; 87/FDD9

    .endsection Unsorted87FD09Section


    .section SaveFileSection

      .al
      .xl

      rlHandleSaveFile ; 91/D9C5

        .al
        .autsiz
        .databank ?

        lda aSave.wMenuOperation,b
        beq _End

          bit #$8000
          bne _LoadFile

            ; SaveFile
            lda aSave.wMenuOperation,b
            dec a
            jsl rlSaveToSaveSlot

            lda aSave.wMenuOperation,b
            dec a
            jsl rlSetLastSavedSlot
            bra +

          _LoadFile
          lda aSave.wMenuOperation,b
          and #$7FFF
          dec a
          jsl rlLoadFromSaveSlot

          +
          lda aSave.wMenuOperation,b
          and #$7FFF
          dec a
          sta aSave.wUnknown001B09,b
          stz aSave.wMenuOperation,b

        _End
        rtl

        .databank 0

        ; 91/D9FA

    .endsection SaveFileSection


    .section SaveSlotSection

      .al
      .xl

      rlSaveToSaveSlot ; 91/E95F

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = save slot ID, 0 indexed

        phx
        phy
        pha
        sta aSave.wActiveSlot,b
        jsr rsClearSaveSlot
        jsr rsSaveGameTimerAndUnitLosses
        jsr rsSaveSaveFileBody
        jsr rsSaveLastUsedOptions
        jsr rsFillSaveSlotDataBuffers
        pla
        ply
        plx
        rtl

        .databank 0

      rlLoadFromSaveSlot ; 91/E978

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = save slot ID, 0 indexed

        phx
        phy
        pha
        sta aSave.wActiveSlot,b
        jsl rlClearMapRAM
        jsl rlUnknown81A85C
        jsr rsLoadGameTimerAndUnitLosses
        jsr rsLoadSaveFileBody
        jsr rsFillSaveSlotDataBuffers
        jsl rlApplySoundOption
        jsl rlUnitWindowClearSavedListOrder
        pla
        ply
        plx
        rtl

        .databank 0

      rlStartNewGameSave ; 91/E99B

        .al
        .autsiz
        .databank ?

        ; New game: resets the game's RAM and units, rereads the slots' save data words, takes a save ID no slot uses (rsGetNewUniqueSaveID) as wActiveSaveData, and clears the unit losses and the game timer.

        jsl rlClearMapRAM
        jsl rlUnknown81A85C
        jsl rlInitializeUnitRAM
        jsr rsFillSaveSlotDataBuffers
        jsr rsGetNewUniqueSaveID
        sta aSave.wActiveSaveData,b
        jsr rsClearUnitLosses
        jsr rsClearGameTimer
        jsl rlApplySoundOption
        rtl

        .databank 0

      rlEraseSaveSlot ; 91/E9BB

        .al
        .autsiz
        .databank ?

        ; Erases slot A by storing a checksum one off the real one, so the slot no longer validates. When no slot is left, also clears the last used options and the kept ranking.

        phb
        pha
        jsr rsCalculateSaveSlotChecksum
        inc a
        tay
        pla
        jsr rsSetSaveSlotChecksum
        jsr rsFillSaveSlotDataBuffers

        lda aSave.aSlotDataBuffer[0],b
        bne _End

          lda aSave.aSlotDataBuffer[1],b
          bne _End

            lda aSave.aSlotDataBuffer[2],b
            bne _End

              lda aSave.aSlotDataBuffer[3],b
              bne _End

                lda #0
                sta aSRAM.wLastUsedOptions
                sta aSRAM.wRankingScore

        _End
        plb
        rtl

        .databank 0

      rsFillSaveSlotDataBuffers ; 91/E9EA

        .al
        .autsiz
        .databank ?

        ldy #0
        sty aSave.wActiveSlot,b
        
          _Loop
          phy
          lda aSave.wActiveSlot,b
          jsr rsCalculateSaveSlotChecksum
          pha
          lda aSave.wActiveSlot,b
          jsr rsGetSaveSlotChecksum
          sta wR0
          pla
          cmp wR0
          bne _AE21

            lda aSave.wActiveSlot,b
            jsr rsGetSaveSlotMagicNumber
            cmp #SAVE_MAGIC_NUMBER
            beq +

              cmp #SAVE_MAGIC_NUMBER_OLDER
              bne _AE21

            +
            lda aSave.wActiveSlot,b
            jsr rsGetSaveSlotOffset
            lda aSRAM.aSaveSlot1.SaveData,x
            bra +

          _AE21
          lda #0

          +
          ply
          sta aSave.aSlotDataBuffer[0],b,y
          inc aSave.wActiveSlot,b
          inc y
          inc y
          cpy #len(aSave.aSlotDataBuffer) * size(word)
          bne _Loop

        rts

        .databank 0

      rsGetNewUniqueSaveID ; 91/EA33

        .al
        .autsiz
        .databank ?

        ; Output:
        ; A = SaveID that isnt used yet + highest completion count

        lda #0
        sep #$20
        lda aSave.aSlotDataBuffer[0],b
        cmp aSave.aSlotDataBuffer[1],b
        bcs +

          lda aSave.aSlotDataBuffer[1],b

        +
        cmp aSave.aSlotDataBuffer[2],b
        bcs +

          lda aSave.aSlotDataBuffer[2],b

        +
        cmp aSave.aSlotDataBuffer[3],b
        bcs +

          lda aSave.aSlotDataBuffer[3],b

        +
        and #$F8
        bpl +

          cmp #$F8
          beq +

            ; Add to the completion count
            clc
            adc #1 << 3

        +
        and #$7F
        inc a

        _Loop
        cmp aSave.aSlotDataBuffer[0],b
        beq _Next

          cmp aSave.aSlotDataBuffer[1],b
          beq _Next

            cmp aSave.aSlotDataBuffer[2],b
            beq _Next

              cmp aSave.aSlotDataBuffer[3],b
              bne +

        _Next
        inc a
        bra _Loop

        +
        rep #$20
        rts

        .databank 0

      rlGetSaveSlotChapter ; 91/EA7B

        .al
        .autsiz
        .databank ?

        ; A = slot: returns the chapter saved in it.

        jsr rsGetSaveSlotOffset
        lda aSRAM + structSaveDataEntry.CurrentChapter,x
        and #$00FF
        rtl

        .databank 0

      rlGetSaveSlotTurn ; 91/EA86

        .al
        .autsiz
        .databank ?

        ; A = slot: returns its turn number, or $FFFF for a slot in the older format (magic number $1206, which this ROM reads but never writes) whose turn is $FF. The file menu shows such a slot as turn 0 of the next chapter.

        jsr rsGetSaveSlotOffset
        lda aSRAM + structSaveDataEntry.CurrentTurnHigh,x
        xba
        sep #$20
        ora aSRAM + structSaveDataEntry.CurrentTurnLow,x
        rep #$20
        pha

        lda aSRAM + structSaveDataEntry.MagicNumber,x
        cmp #SAVE_MAGIC_NUMBER
        beq _End

        pla
        pha
        cmp #$00FF
        bne _End

        pla
        lda #$FFFF
        pha
        
        _End
        pla
        rtl

        .databank 0

      rlGetHighestCompletionCount ; 91/EAAE

        .al
        .autsiz
        .databank ?

        phx
        phy
        jsr rsFillSaveSlotDataBuffers
        jsr rsGetNewUniqueSaveID
        lsr a
        lsr a
        lsr a
        and #$000F
        ply
        plx
        rtl

        .databank 0

      rlGetCurrentSaveCompletionCount ; 91/EABF

        .al
        .autsiz
        .databank ?

        lda aSave.wActiveSaveData,b
        lsr a
        lsr a
        lsr a
        and #$000F
        rtl

        .databank 0

      rlSetSaveSlotCompletionFlag ; 91/EAC9

        .al
        .autsiz
        .databank ?

        phx
        phy
        ldy #0
        
          _Loop
          lda aSave.aSlotDataBuffer[0],b,y
          beq _Next

            and #$007F
            cmp aSave.wActiveSaveData,b
            bne _Next

              tya
              lsr a
              jsr rsGetSaveSlotOffset
              lda aSRAM + structSaveDataEntry.SaveData,x
              bit #$0080
              bne _Next

                clc
                adc #$0080
                sta aSRAM + structSaveDataEntry.SaveData,x
                phy
                tya
                lsr a
                pha
                jsr rsGetSaveSlotChecksum
                clc
                adc #$0080
                tay
                pla
                jsr rsSetSaveSlotChecksum
                ply

          _Next
          inc y
          inc y
          cpy #4 * 2
          bne _Loop

        jsr rsKeepFinalRanking

        ply
        plx
        rtl

        .databank 0

      rlRecordUnitLoss ; 91/EB0F

        .al
        .autsiz
        .databank ?

        ; A = loss index (0-47: generation ID - 1, plus 24 from chapter 6; 48 and up hit a brk): adds one (up to $FF) to its count in aUnitLossesCount and, straight away, in every slot holding this save at this chapter. Resetting cannot undo a loss.

        phx
        phy
        cmp #48
        bcc +

          brk

        +
        tax
        sta aSave.wStructCount,b
        lda aUnitLossesCount[0],x
        and #$00FF
        cmp #$00FF
        beq +

          lda aUnitLossesCount[0],x
          inc a
          sta aUnitLossesCount[0],x

        +
        ldy #0
        
          _Loop
          lda wCurrentChapter-1,b
          and #$FF00
          ora aSave.wActiveSaveData,b
          and #$FF7F
          sta aSave.wSlotDataToMatch,b

          lda aSave.aSlotDataBuffer[0],b,y
          and #$FF7F
          cmp aSave.wSlotDataToMatch,b
          bne _Next

            tya
            lsr a
            jsr rsAddSlotUnitLoss

          _Next
          inc y
          inc y
          cpy #8
          bne _Loop

        ply
        plx
        rtl

        .databank 0

      rsAddSlotUnitLoss ; 91/EB5C

        .al
        .autsiz
        .databank ?

        ; Adds one (up to $FF) to loss count aSave.wStructCount in slot A's SRAM.

        jsr rsGetSaveSlotOffset
        clc
        adc aSave.wStructCount,b
        tax
        sep #$20
        lda aSRAM + structSaveDataEntry.UnitLossesCount[0],x
        cmp #$FF
        beq +

          inc a
          sta aSRAM + structSaveDataEntry.UnitLossesCount[0],x

        +
        rep #$20
        rts

        .databank 0

      rlTickGameTimer ; 91/EB76

        .al
        .autsiz
        .databank ?

        ; Once a frame, from the interrupt handlers, while a game is going: adds one to the game timer, and every $800 frames writes it into every slot holding this save.

        php
        phb
        phx
        phy
        phk
        plb
        lda aSave.wActiveSaveData,b
        beq _End

          inc aSave.wGameTimerLow,b
          bne +

            inc aSave.wGameTimerHigh,b

          +
          lda aSave.wGameTimerLow,b
          and #$07FF
          bne _End

          ldy #0
          
            _Loop
            lda aSave.aSlotDataBuffer[0],b,y
            and #$007F
            cmp aSave.wActiveSaveData,b
            bne _Next

              tya
              lsr a
              jsr rsGetSaveSlotOffset
              lda aSave.wGameTimerLow,b
              sta aSRAM + structSaveDataEntry.GameTimerLow,x
              lda aSave.wGameTimerHigh,b
              sta aSRAM + structSaveDataEntry.GameTimerHigh,x

            _Next
            inc y
            inc y
            cpy #4 * 2
            bne _Loop

        _End
        ply
        plx
        plb
        plp
        rtl

        .databank 0

      rlGetLossCountByIndex ; 91/EBBE

        .al
        .autsiz
        .databank ?

        ; A = loss index: returns its count. rlGetUnitLossCount gives a unit's index.

        phx
        tax
        lda aUnitLossesCount[0],x
        and #$00FF
        plx
        rtl

        .databank 0

      rlGetGameTimeHoursMinutes ; 91/EBC9

        .al
        .autsiz
        .databank ?

        ; Returns the game time from the frame timer: X hours (at most 9999), A minutes.

        lda aSave.wGameTimerLow,b
        sta wR12
        lda aSave.wGameTimerHigh,b
        sta wR13
        lda #3600
        sta wR14
        lda #0
        sta wR15
        jsl rlUnsignedDivide32By32

        lda #60
        sta wR14
        lda #0
        sta wR15
        jsl rlUnsignedDivide32By32

        lda wR13
        bne +

          lda wR12
          cmp #9999
          bcc ++

        +
        lda #9999

        +
        tax
        lda wR10
        rtl

        .databank 0

      rsClearUnitLosses ; 91/EC01

        .al
        .autsiz
        .databank ?

        ldy #len(aUnitLossesCount) / size(byte)
        lda #0
        tax
        sep #$20

          -
          sta aUnitLossesCount[0],x
          inc x
          dec y
          bne -

        rep #$20
        rts

        .databank 0

      rsClearGameTimer ; 91/EC15

        .al
        .autsiz
        .databank ?

        lda #0
        sta aSave.wGameTimerLow,b
        sta aSave.wGameTimerHigh,b
        rts

        .databank 0

      rsSaveGameTimerAndUnitLosses ; 91/EC1F

        .al
        .autsiz
        .databank ?

        lda aSave.wActiveSlot,b
        jsr rsGetSaveSlotOffset

        lda aSave.wGameTimerLow,b
        sta aSRAM + structSaveDataEntry.GameTimerLow,x
        lda aSave.wGameTimerHigh,b
        sta aSRAM + structSaveDataEntry.GameTimerHigh,x

        lda #(`aUnitLossesCount[0])<<8
        sta lR18+1
        lda #<>aUnitLossesCount[0]
        sta lR18
        ldy #0
        sep #$20

          -
          lda [lR18],y
          sta aSRAM.aSaveSlot1.UnitLossesCount[0],x
          inc x
          inc y
          cpy #len(aUnitLossesCount) / size(byte)
          bne -

        rep #$20
        rts

        .databank 0

      rsLoadGameTimerAndUnitLosses ; 91/EC52

        .al
        .autsiz
        .databank ?

        lda aSave.wActiveSlot,b
        jsr rsGetSaveSlotOffset

        lda aSRAM + structSaveDataEntry.GameTimerLow,x
        sta aSave.wGameTimerLow,b
        lda aSRAM + structSaveDataEntry.GameTimerHigh,x
        sta aSave.wGameTimerHigh,b

        lda #(`aUnitLossesCount[0])<<8
        sta lR18+1
        lda #<>aUnitLossesCount[0]
        sta lR18
        ldy #0
        sep #$20

          -
          lda aSRAM + structSaveDataEntry.UnitLossesCount[0],x
          sta [lR18],y
          inc x
          inc y
          cpy #len(aUnitLossesCount) / size(byte)
          bne -

        rep #$20
        rts

        .databank 0

      rsGetSaveSlotOffset ; 91/EC85

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = save slot ID

        ; Output:
        ; X = offset

        and #$0003
        xba
        asl a
        asl a
        asl a
        tax
        rts

        .databank 0

      rlLoadLastUsedOptions ; 91/EC8E

        .al
        .autsiz
        .databank ?

        ; At boot: puts the options kept with the last save (aSRAM.wLastUsedOptions) into wOptionSettings.

        jsr rsLoadLastUsedOptions
        rtl

        .databank 0

      rsSaveLastUsedOptions ; 91/EC92

        .al
        .autsiz
        .databank ?

        lda wOptionSettings,b
        sta aSRAM.wLastUsedOptions
        rts

        .databank 0

      rsLoadLastUsedOptions ; 91/EC9A

        .al
        .autsiz
        .databank ?

        lda aSRAM.wLastUsedOptions
        sta wOptionSettings,b
        rts

        .databank 0

      rlGetKeptRanking ; 91/ECA2

        .al
        .autsiz
        .databank ?

        ; Returns the final ranking kept in SRAM (rsGetKeptRanking).

        jsr rsGetKeptRanking
        rtl

        .databank 0

      rsKeepFinalRanking ; 91/ECA6

        .al
        .autsiz
        .databank ?

        ; When a save is marked finished (rlSetSaveSlotCompletionFlag): keeps the game's final ranking plus 1 (rlCalculateFinalRankingScore, 1-7) in aSRAM.wRankingScore, tagged $F290, unless the kept one is lower.

        jsl rlCalculateFinalRankingScore
        inc a
        and #$0007
        sta wR0

        jsr rsGetKeptRanking
        beq +

          cmp wR0
          bcc _End

        +
        lda wR0
        ora #SRAM_RANKING_TAG
        sta aSRAM.wRankingScore

        _End
        rts

        .databank 0

      rsGetKeptRanking ; 91/ECC3

        .al
        .autsiz
        .databank ?

        ; Returns the ranking kept in aSRAM.wRankingScore (1-7), or 0 without the $F290 tag.

        lda aSRAM.wRankingScore
        pha

        and #$FFF8
        cmp #SRAM_RANKING_TAG
        beq +

          pla
          lda #0
          pha

        +
        pla
        and #$0007
        rts

        .databank 0

      rlSetAntiTamperMark ; 91/ECDA

        .al
        .autsiz
        .databank ?

        ; Stores A in aSRAM.wAntiTamperMark: the integrity check writes $6A19 the first time it fails, and rlCheckCodeChecksumsAtReset clears it when the code checksum is right.

        sta aSRAM.wAntiTamperMark
        rtl

        .databank 0

      rlGetAntiTamperMark ; 91/ECDF

        .al
        .autsiz
        .databank ?

        lda aSRAM.wAntiTamperMark
        rtl

        .databank 0

      rlSetLastSavedSlot ; 91/ECE4

        .al
        .autsiz
        .databank ?

        ; Keeps slot A (0-3) in aSRAM.wLastSavedSlot, tagged $D8C0, for the file menu to start on.

        and #$0003
        ora #SRAM_LAST_SAVED_SLOT_TAG
        sta aSRAM.wLastSavedSlot
        rtl

        .databank 0

      rlGetLastSavedSlot ; 91/ECEF

        .al
        .autsiz
        .databank ?

        ; Returns the slot kept by rlSetLastSavedSlot, or 0 without the tag.

        lda aSRAM.wLastSavedSlot
        pha
        and #$FFFC
        cmp #SRAM_LAST_SAVED_SLOT_TAG
        beq +

          pla
          lda #0
          pha

        +
        pla
        and #$0003
        rtl

        .databank 0

      rsSetSaveDataOffsets ; 91/ED06

        .al
        .autsiz
        .databank ?

        xba
        asl a
        asl a
        asl a
        sta aSave.wAvtiveSaveSlotOffset,b
        stz aSave.wCurrentBitOffset,b
        rts

        .databank 0

      rsWriteBitpackedSaveData ; 91/ED11

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR0 = value to write

        phx
        stz wR1

        lda aSave.wDataBitLength,b
        beq _End

          dec a
          asl a
          tax
          lda aSaveDataBitmasks,x
          and wR0
          sta wR0

          lda aSave.wCurrentBitOffset,b
          and #$0007
          beq +

            tax

              -
              asl wR0
              rol wR1
              dec x
              bne -

          +
          lda aSave.wCurrentBitOffset,b
          lsr a
          lsr a
          lsr a
          clc
          adc aSave.wAvtiveSaveSlotOffset,b
          tax

          lda wR0
          beq +

            ora aSRAM,x
            sta aSRAM,x

          +
          lda wR1
          beq +

            ora aSRAM + size(word),x
            sta aSRAM + size(word),x

          +
          lda aSave.wCurrentBitOffset,b
          clc
          adc aSave.wDataBitLength,b
          sta aSave.wCurrentBitOffset,b

        _End
        plx
        rts

        .databank 0

      rsReadBitpackedSaveData ; 91/ED63

        .al
        .autsiz
        .databank ?

        phx
        lda aSave.wDataBitLength,b
        beq _End

          lda aSave.wCurrentBitOffset,b
          lsr a
          lsr a
          lsr a
          clc
          adc aSave.wAvtiveSaveSlotOffset,b
          tax

          lda aSRAM,x 
          sta wR0
          lda aSRAM + 2,x
          sta wR1

          lda aSave.wCurrentBitOffset,b
          and #$0007
          beq +

            tax

              -
              lsr wR1
              ror wR0
              dec x
              bne -

          +
          lda aSave.wDataBitLength,b
          dec a
          asl a
          tax
          lda aSaveDataBitmasks,x
          and wR0
          pha

          lda aSave.wCurrentBitOffset,b
          clc
          adc aSave.wDataBitLength,b
          sta aSave.wCurrentBitOffset,b
          pla

        _End
        plx
        rts

        .databank 0

      aSaveDataBitmasks ; 91/EDAA

        .word $0001 ; 1
        .word $0003 ; 2
        .word $0007 ; 3
        .word $000F ; 4
        .word $001F ; 5
        .word $003F ; 6
        .word $007F ; 7
        .word $00FF ; 8
        .word $01FF ; 9
        .word $03FF ; 10
        .word $07FF ; 11
        .word $0FFF ; 12
        .word $1FFF ; 13
        .word $3FFF ; 14
        .word $7FFF ; 15
        .word $FFFF ; 16

      rsSaveBitpackedDataOffsets ; 91/EDCA

        .al
        .autsiz
        .databank ?

        _Loop
        tay
        inc x
        lda $0000,b,x
        and #$007F
        sta aSave.wDataBitLength,b

        _EDD5
        lda [lR18],y
        sta wR0
        inc x

        phx
        jsr rsWriteBitpackedSaveData
        plx

        _Entry ; 91/EDDF
        lda $0000,b,x
        and #$00FF
        cmp #$00FF
        bne _Loop

        rts

        .databank 0

      rsLoadBitpackedDataOffsets ; 91/EDEB

        .al
        .autsiz
        .databank ?

        _Loop
        tay
        inc x
        lda $0000,b,x
        pha
        and #$007F
        sta aSave.wDataBitLength,b
        inc x
        phx
        jsr rsReadBitpackedSaveData
        sta wR0
        plx
        pla
        bit #$0080
        beq +

          sep #$20
          lda wR0
          sta [lR18],y
          rep #$20
          bra +_Entry

        +
        lda wR0
        sta [lR18],y

        _Entry ; 91/EE13
        lda $0000,b,x
        and #$00FF
        cmp #$00FF
        bne _Loop
        
        rts

        .databank 0

      rsSaveBitpackedDataList ; 91/EE1F

        .al
        .autsiz
        .databank ?

        _Loop
        and #$007F
        sta aSave.wDataBitLength,b
        inc x
        lda $0000,b,x
        sta lR18
        inc x
        lda $0000,b,x
        sta lR18+1
        inc x
        inc x
        ldy #0
        lda [lR18],y
        sta wR0

        phx
        jsr rsWriteBitpackedSaveData
        plx

        _Entry ; 91/EE3F
        lda $0000,b,x
        and #$00FF
        cmp #$00FF
        bne _Loop

        rts

        .databank 0

      rsLoadBitpackedDataList ; 91/EE4B

        .al
        .autsiz
        .databank ?

        _Loop
        pha
        and #$007F
        sta aSave.wDataBitLength,b
        inc x
        lda $0000,b,x
        sta lR18
        inc x
        lda $0000,b,x
        sta lR18+1
        inc x
        inc x
        phx
        jsr rsReadBitpackedSaveData
        sta wR0
        plx
        ldy #0
        pla
        bit #$0080
        beq _Word

          sep #$20
          lda wR0
          sta [lR18],y
          rep #$20
          bra _Entry

        _Word
        lda wR0
        sta [lR18],y

        _Entry ; 91/EE7E
        lda $0000,b,x
        and #$00FF
        cmp #$00FF
        bne _Loop

        rts

        .databank 0

      rsCalculateSaveSlotChecksum ; 91/EE8A

        .al
        .autsiz
        .databank ?

        phb
        pea #(`aSRAM)<<8
        plb
        plb
        xba
        asl a
        asl a
        asl a
        clc
        adc #<>aSRAM
        tax
        ldy #$07BE
        lda #0
        sta wR0
        clc

          _Loop
          lda $0000,b,x
          and #$00FF
          adc wR0
          sta wR0
          inc x
          dec y
          bne _Loop

        inc a
        plb
        rts

        .databank 0

      rsGetSaveSlotChecksum ; 91/EEB3

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = save slot ID

        jsr rsGetSaveSlotOffset
        lda aSRAM + structSaveDataEntry.Checksum,x
        rts

        .databank 0

      rsSetSaveSlotChecksum ; 91/EEBB

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = save slot ID
        ; Y = checksum

        jsr rsGetSaveSlotOffset
        tya
        sta aSRAM + structSaveDataEntry.Checksum,x
        rts

        .databank 0

      rsGetSaveSlotMagicNumber ; 91/EEC4

        .al
        .autsiz
        .databank ?

        jsr rsGetSaveSlotOffset
        lda aSRAM + structSaveDataEntry.MagicNumber,x
        rts

        .databank 0

      rsSetSaveSlotMagicNumber ; 91/EECC

        .al
        .autsiz
        .databank ?

        jsr rsGetSaveSlotOffset
        lda #SAVE_MAGIC_NUMBER
        sta aSRAM + structSaveDataEntry.MagicNumber,x
        rts

        .databank 0

      rsClearSaveSlot ; 91/EED7

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = save slot

        jsr rsGetSaveSlotOffset
        ldy #size(structSaveDataEntry)
        lda #0

          -
          sta aSRAM.aSaveSlot1,x
          inc x
          inc x
          dec y
          dec y
          bne -

        rts

        .databank 0

      rsSaveSaveFileBody ; 91/EEEB

        .al
        .autsiz
        .databank ?

        ; Saves to file from $00 until the checksum.

        phb
        phk
        plb
        lda aSave.wActiveSlot,b
        jsr rsSetSaveDataOffsets

        jsl rlFillItemsOwnerAndSlotData
        jsr rsSaveGeneralSaveData
        jsr rsSaveFactionHeaderRAMData
        jsr rsSaveItemRAMData
        jsr rsSaveChapterLocationData
        jsr rsSaveChapterEventData
        jsr rsSaveUnitData
        jsl rlFillItemDurabilityData

        lda aSave.wActiveSlot,b
        jsr rsSetSaveSlotMagicNumber

        lda aSave.wActiveSlot,b
        jsr rsCalculateSaveSlotChecksum
        tay

        lda aSave.wActiveSlot,b
        jsr rsSetSaveSlotChecksum

        lda aSave.wCurrentBitOffset,b
        cmp #structSaveDataEntry.Checksum * 8
        bcc +

          brk

        +
        plb
        rts

        .databank 0

      rsLoadSaveFileBody ; 91/EF2C

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb
        lda aSave.wActiveSlot,b
        jsr rsSetSaveDataOffsets
        jsl rlInitializeUnitRAM
        jsr rsLoadGeneralSaveData
        jsr rsLoadFactionHeaderRAMData
        jsl rlPrepareFactionUnitLists
        jsr rsLoadItemRAMData
        jsr rsLoadChapterLocationData
        jsr rsLoadChapterEventData
        jsr rsLoadUnitData
        jsl rlFillItemDurabilityData
        plb
        rts

        .databank 0

      rsSaveUnitData ; 91/EF55

        .al
        .autsiz
        .databank ?

        lda #(`aUnitRAMPointers)<<8
        sta lStructPointer2+1,b
        lda #<>aUnitRAMPointers
        sta lStructPointer2,b
        jsl rlGetRAMStructCurrentStructCount

        pha
        sta wR0
        lda #7
        sta aSave.wDataBitLength,b
        jsr rsWriteBitpackedSaveData

        pla
        ora #0
        beq _End
        
          sta aSave.wStructIndex,b
          lda #0

            -
            pha
            inc a
            sta wStructIndex,b
            jsl rlLoadRAMStructDataByIndex
            lda lStructPointer1,b
            sta wSelectedUnitDataRAMPointer,b
            jsr rsSaveSpecifiedUnitsData
            pla
            inc a
            cmp aSave.wStructIndex,b
            bne -

        _End
        rts

        .databank 0

      rsLoadUnitData ; 91/EF97

        .al
        .autsiz
        .databank ?

        lda #(`aUnitRAMPointers)<<8
        sta lStructPointer2+1,b
        lda #<>aUnitRAMPointers
        sta lStructPointer2,b
        lda #7
        sta aSave.wDataBitLength,b
        jsr rsReadBitpackedSaveData
        ora #0
        beq _End

          sta aSave.wStructIndex,b
          lda #0

            -
            pha
            inc a
            jsr rsLoadSpecifiedUnitsData
            pla
            inc a
            cmp aSave.wStructIndex,b
            bne -

        _End
        rts

        .databank 0

      aSaveCharacterDeploymentData ; 91/EFC4

        .byte 9
        .long aSave.wCharacterID

        .byte 5
        .long aSave.wCharacterDeploymentState

        .byte 6
        .long aSave.wCharacterXPosition

        .byte 6
        .long aSave.wCharacterYPosition

        .byte $FF

      rsSaveSpecifiedUnitsData ; 91/EFD5

        .al
        .autsiz
        .databank ?

        lda #(`aUnit1DataBuffer._Personal)<<8
        sta lRAMBufferPointer+1,b
        lda #<>aUnit1DataBuffer._Personal
        sta lRAMBufferPointer,b
        jsl rlSavePersonalCharacterDataToBuffer

        lda #(`aUnit1DataBuffer._Extended)<<8
        sta lRAMBufferPointer+1,b
        lda #<>aUnit1DataBuffer._Extended
        sta lRAMBufferPointer,b
        jsl rlSaveExtendedCharacterDataToBuffer

        lda #(`aUnit1DataBuffer._ROM)<<8
        sta lRAMBufferPointer+1,b
        lda #<>aUnit1DataBuffer._ROM
        sta lRAMBufferPointer,b
        jsl rlSaveCharacterROMDataToBuffer

        lda #(`aUnit1DataBuffer._Inventory)<<8
        sta lRAMBufferPointer+1,b
        lda #<>aUnit1DataBuffer._Inventory
        sta lRAMBufferPointer,b
        jsl rlSaveCharacterInventoryToBuffer

        lda #(`aUnit1DataBuffer._Lover)<<8
        sta lRAMBufferPointer+1,b
        lda #<>aUnit1DataBuffer._Lover
        sta lRAMBufferPointer,b
        jsl rlSaveLoverDataToBuffer

        jsl rlFillUnitsDeploymentSaveData
        jsl rlGetSelectedUnitCharacterID
        sta aSave.wCharacterID

        ldx #<>aSaveCharacterDeploymentData
        jsr rsSaveBitpackedDataList._Entry

        jsl rlGetUnitType
        jsr rsSaveSpecifiedUnitsDataByType
        rts

        .databank 0

      rsLoadSpecifiedUnitsData ; 91/F03F

        .al
        .autsiz
        .databank ?

        ldx #<>aSaveCharacterDeploymentData
        jsr rsLoadBitpackedDataList._Entry

        lda aSave.wCharacterID
        sta aUnit1DataBuffer._ROM.CharacterID

        jsl rlGetCharacterUnitType
        jsr rsLoadSpecifiedUnitsDataByType

        lda aSave.wCharacterID
        jsl rlCreateUnitFromBuffers
        rts

        .databank 0

      rsSaveSpecifiedUnitsDataByType ; 91/F05D

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = unit type

        cmp #UnitTypeStatic
        beq _Static

          cmp #UnitTypeDynamic
          beq _Dynamic

            ; Holy/Enemy
            jml rsSaveHolyEnemyPersonalCharacterData

        _Static
        jsr rsSaveStaticDynamicPersonalCharacterData
        jsr rsSaveStaticDynamicExtendedCharacterData
        bra +

        _Dynamic
        jsr rsSaveStaticDynamicPersonalCharacterData
        jsr rsSaveStaticDynamicExtendedCharacterData
        jsr rsSaveDynamicCharacterROMData

        +
        jsr rsSaveStaticDynamicCharacterInventoryData
        jml rsSaveFemaleCharacterLoverData

        .databank 0

      rsLoadSpecifiedUnitsDataByType ; 91/F083

        .al
        .autsiz
        .databank ?

        cmp #UnitTypeStatic
        beq _Static

          cmp #UnitTypeDynamic
          beq _Dynamic

            jml rsLoadHolyEnemyPersonalCharacterData

        _Static
        jsr rsLoadStaticDynamicPersonalCharacterData
        jsr rsLoadStaticDynamicExtendedCharacterData
        bra +

        _Dynamic
        jsr rsLoadStaticDynamicPersonalCharacterData
        jsr rsLoadStaticDynamicExtendedCharacterData
        jsr rsLoadDynamicCharacterROMData

        +
        jsr rsLoadStaticDynamicCharacterInventoryData
        jml rsLoadFemaleCharacterLoverData

        .databank 0

      aSaveStaticDynamicPersonalCharacterData ; 91/F0A9

        .byte structPersonalCharacterDataBuffer.UnitStates,         11
        .byte structPersonalCharacterDataBuffer.LoverGenerationID,   5
        .byte structPersonalCharacterDataBuffer.ResidingCastle,      4
        .byte structPersonalCharacterDataBuffer.FactionSlot,         3
        .byte structPersonalCharacterDataBuffer.AI,                  4
        .byte structPersonalCharacterDataBuffer.Status,              3
        .byte structPersonalCharacterDataBuffer.StatusDuration,      4
        .byte structPersonalCharacterDataBuffer.CurrentHP,           7
        .byte $FF

      aSaveHolyEnemyPersonalCharacterData ; 91/F0BA

        .byte structPersonalCharacterDataBuffer.UnitStates,         9
        .byte structPersonalCharacterDataBuffer.ResidingCastle,     4
        .byte structPersonalCharacterDataBuffer.FactionSlot,        3
        .byte structPersonalCharacterDataBuffer.AI,                 4
        .byte structPersonalCharacterDataBuffer.Status,             3
        .byte structPersonalCharacterDataBuffer.StatusDuration,     4
        .byte structPersonalCharacterDataBuffer.CurrentHP,          7
        .byte structPersonalCharacterDataBuffer.ClassMoney,         1
        .byte $FF

      rsSaveStaticDynamicPersonalCharacterData ; 91/F0CB

        .al
        .autsiz
        .databank ?

        ; Static or dynamic

        jsl rlCompactStaticDynamicUnitBuffer1UnitStates

        lda #(`aUnit1DataBuffer._Personal)<<8
        sta lR18+1
        lda #<>aUnit1DataBuffer._Personal
        sta lR18
        ldx #<>aSaveStaticDynamicPersonalCharacterData
        jsr rsSaveBitpackedDataOffsets._Entry
        rts

        .databank 0

      rsLoadStaticDynamicPersonalCharacterData ; 91/F0E0

        .al
        .autsiz
        .databank ?

        lda #(`aUnit1DataBuffer._Personal)<<8
        sta lR18+1
        lda #<>aUnit1DataBuffer._Personal
        sta lR18
        ldx #<>aSaveStaticDynamicPersonalCharacterData
        jsr rsLoadBitpackedDataOffsets._Entry

        jsl rlExpandStaticDynamicUnitBuffer1UnitStates
        rts

        .databank 0

      rsSaveHolyEnemyPersonalCharacterData ; 91/F0F5

        .al
        .autsiz
        .databank ?

        jsl rlCompactHolyEnemyUnitBuffer1UnitStates

        lda #(`aUnit1DataBuffer._Personal)<<8
        sta lR18+1
        lda #<>aUnit1DataBuffer._Personal
        sta lR18
        ldx #<>aSaveHolyEnemyPersonalCharacterData
        jsr rsSaveBitpackedDataOffsets._Entry
        rts

        .databank 0

      rsLoadHolyEnemyPersonalCharacterData ; 91/F10A

        .al
        .autsiz
        .databank ?

        lda #(`aUnit1DataBuffer._Personal)<<8
        sta lR18+1
        lda #<>aUnit1DataBuffer._Personal
        sta lR18
        ldx #<>aSaveHolyEnemyPersonalCharacterData
        jsr rsLoadBitpackedDataOffsets._Entry

        jsl rlExpandHolyEnemyUnitBuffer1UnitStates
        rts

        .databank 0

      aSaveStaticDynamicExtendedCharacterData ; 91/F11F

        .byte structExtendedCharacterDataBuffer.HP,          7
        .byte structExtendedCharacterDataBuffer.Strength,    4
        .byte structExtendedCharacterDataBuffer.Magic,       4
        .byte structExtendedCharacterDataBuffer.Skill,       4
        .byte structExtendedCharacterDataBuffer.Speed,       4
        .byte structExtendedCharacterDataBuffer.Defense,     4
        .byte structExtendedCharacterDataBuffer.Resistance,  4
        .byte structExtendedCharacterDataBuffer.Luck,        5
        .byte structExtendedCharacterDataBuffer.Class,       7
        .byte structExtendedCharacterDataBuffer.Level,       5
        .byte structExtendedCharacterDataBuffer.Money,      16
        .byte structExtendedCharacterDataBuffer.Experience,  7
        .byte structExtendedCharacterDataBuffer.TalkTarget,  6
        .byte $FF

      rsSaveStaticDynamicExtendedCharacterData ; 91/F13A

        .al
        .autsiz
        .databank ?

        lda #(`aUnit1DataBuffer._Extended)<<8
        sta lR18+1
        lda #<>aUnit1DataBuffer._Extended
        sta lR18
        ldx #<>aSaveStaticDynamicExtendedCharacterData
        jsr rsSaveBitpackedDataOffsets._Entry
        rts

        .databank 0

      rsLoadStaticDynamicExtendedCharacterData ; 91/F14B

        .al
        .autsiz
        .databank ?

        lda #(`aUnit1DataBuffer._Extended)<<8
        sta lR18+1
        lda #<>aUnit1DataBuffer._Extended
        sta lR18
        ldx #<>aSaveStaticDynamicExtendedCharacterData
        jsr rsLoadBitpackedDataOffsets._Entry
        rts

        .databank 0

      aSaveDynamicCharacterROMData ; 91/F15C

        .byte structCharacterROMDataBuffer.FatherID,          4
        .byte structCharacterROMDataBuffer.HPGrowth,          7
        .byte structCharacterROMDataBuffer.StrengthGrowth,    7
        .byte structCharacterROMDataBuffer.MagicGrowth,       7
        .byte structCharacterROMDataBuffer.SkillGrowth,       7
        .byte structCharacterROMDataBuffer.SpeedGrowth,       7
        .byte structCharacterROMDataBuffer.DefenseGrowth,     7
        .byte structCharacterROMDataBuffer.ResistanceGrowth,  7
        .byte structCharacterROMDataBuffer.LuckGrowth,        7
        .byte structCharacterROMDataBuffer.Skills1,           16
        .byte structCharacterROMDataBuffer.Skills3,           7
        .byte structCharacterROMDataBuffer.HolyBlood1,        16
        .byte structCharacterROMDataBuffer.HolyBlood2,        10
        .byte $FF

      rsSaveDynamicCharacterROMData ; 91/F177

        .al
        .autsiz
        .databank ?

        lda #(`aUnit1DataBuffer._ROM)<<8
        sta lR18+1
        lda #<>aUnit1DataBuffer._ROM
        sta lR18
        ldx #<>aSaveDynamicCharacterROMData
        jsr rsSaveBitpackedDataOffsets._Entry
        rts

        .databank 0

      rsLoadDynamicCharacterROMData ; 91/F188

        .al
        .autsiz
        .databank ?

        lda #(`aUnit1DataBuffer._ROM)<<8
        sta lR18+1
        lda #<>aUnit1DataBuffer._ROM
        sta lR18
        ldx #<>aSaveDynamicCharacterROMData
        jsr rsLoadBitpackedDataOffsets._Entry
        rts

        .databank 0

      aSaveCharacterInventoryData ; 91/F199

        .byte structInventoryDataBuffer.EquippedWeaponBitfield, 7
        .byte $FF

      rsSaveStaticDynamicCharacterInventoryData ; 91/F19C

        .al
        .autsiz
        .databank ?

        lda aUnit1DataBuffer._Inventory.EquippedWeaponBitfield
        lsr a
        sta aUnit1DataBuffer._Inventory.EquippedWeaponBitfield

        lda #(`aUnit1DataBuffer._Inventory)<<8
        sta lR18+1
        lda #<>aUnit1DataBuffer._Inventory
        sta lR18
        ldx #<>aSaveCharacterInventoryData
        jsr rsSaveBitpackedDataOffsets._Entry
        rts

        .databank 0

      rsLoadStaticDynamicCharacterInventoryData ; 91/F1B6

        .al
        .autsiz
        .databank ?

        lda #(`aUnit1DataBuffer._Inventory)<<8
        sta lR18+1
        lda #<>aUnit1DataBuffer._Inventory
        sta lR18
        ldx #<>aSaveCharacterInventoryData
        jsr rsLoadBitpackedDataOffsets._Entry

        lda aUnit1DataBuffer._Inventory.EquippedWeaponBitfield
        asl a
        sta aUnit1DataBuffer._Inventory.EquippedWeaponBitfield
        rts

        .databank 0

      aSaveFemaleCharacterLoverData ; 91/F1D0

        .byte  0, 9
        .byte  2, 9
        .byte  4, 9
        .byte  6, 9
        .byte  8, 9
        .byte 10, 9
        .byte 12, 9
        .byte 14, 9
        .byte 16, 9
        .byte 18, 9
        .byte 20, 9
        .byte 22, 9
        .byte 24, 9
        .byte 26, 9
        .byte 28, 9
        .byte $FF

      rsSaveFemaleCharacterLoverData ; 91/F1EF

        .al
        .autsiz
        .databank ?

        lda aSave.wCharacterID
        jsl rlCheckIfCharacterHasFemaleGenerationID
        bcc +

          lda #(`aUnit1DataBuffer._Lover)<<8
          sta lR18+1
          lda #<>aUnit1DataBuffer._Lover
          sta lR18
          ldx #<>aSaveFemaleCharacterLoverData
          jsr rsSaveBitpackedDataOffsets._Entry

        +
        rts

        .databank 0

      rsLoadFemaleCharacterLoverData ; 91/F20A

        .al
        .autsiz
        .databank ?

        lda aSave.wCharacterID
        jsl rlCheckIfCharacterHasFemaleGenerationID
        bcc +

          lda #(`aUnit1DataBuffer._Lover)<<8
          sta lR18+1
          lda #<>aUnit1DataBuffer._Lover
          sta lR18
          ldx #<>aSaveFemaleCharacterLoverData
          jsr rsLoadBitpackedDataOffsets._Entry

        +
        rts

        .databank 0

      sSaveFactionHeaderData ; 91/F225

        .byte structFactionHeader.GroupID,          8 + LoadAsByteFlag
        .byte structFactionHeader.LocationID,       4 + LoadAsByteFlag
        .byte structFactionHeader.HostileFactions,  7 + LoadAsByteFlag
        .byte structFactionHeader.AlliedFactions,   7 + LoadAsByteFlag
        .byte structFactionHeader.UnitCount,        6 + LoadAsByteFlag
        .byte $FF

      rsSaveFactionHeaderRAMData ; 91/F230

        .al
        .autsiz
        .databank ?

        lda #0
        sta aSave.wStructIndex,b

          -
          jsr rsSaveGetFactionSlotOffset

          ldx #<>sSaveFactionHeaderData
          jsr rsSaveBitpackedDataOffsets._Entry
          inc aSave.wStructIndex,b
          lda aSave.wStructIndex,b
          cmp #7
          bne -

        rts

        .databank 0

      rsLoadFactionHeaderRAMData ; 91/F24B

        .al
        .autsiz
        .databank ?

        lda #0
        sta aSave.wStructCount,b
        tay
        jsr rsSaveWriteToFactionSlotOffset

        lda #0
        sta aSave.wStructIndex,b

          _Loop
          lda aSave.wStructIndex,b
          jsr rsSaveGetFactionSlotOffset

          ldx #<>sSaveFactionHeaderData
          jsr rsLoadBitpackedDataOffsets._Entry

          ldy #structFactionHeader.UnitCount
          lda [lR18],y
          and #$00FF
          asl a
          clc
          adc #size(structFactionHeader)
          adc aSave.wStructCount,b
          sta aSave.wStructCount,b

          lda aSave.wStructIndex,b
          inc a
          ldy aSave.wStructCount,b
          jsr rsSaveWriteToFactionSlotOffset

          inc aSave.wStructIndex,b
          lda aSave.wStructIndex,b
          cmp #7
          bne _Loop

        rts

        .databank 0

      rsSaveGetFactionSlotOffset ; 91/F290

        .al
        .autsiz
        .databank ?

        asl a
        tax
        lda #(`aFactionArea)<<8
        sta lR18+1
        lda aFactionArea,x
        clc
        adc #<>aFactionArea
        sta lR18
        rts

        .databank 0

      rsSaveWriteToFactionSlotOffset ; 91/F2A2

        .al
        .autsiz
        .databank ?

        asl a
        tax
        tya
        clc
        adc #8 * size(word)
        sta aFactionArea,x
        rts

        .databank 0

      aSaveItemRAMData ; 91/F2AE

        .byte structItemRAMEntry.Durability,      6 + LoadAsByteFlag
        .byte structItemRAMEntry.ItemState,       3 + LoadAsByteFlag
        .byte structItemRAMEntry.OwnerRAMPointer, 9
        .byte structItemRAMEntry.KillCount,       7 + LoadAsByteFlag
        .byte $FF

      rsSaveItemRAMData ; 91/F2B7

        .al
        .autsiz
        .databank ?

        lda #PI_IronSword1
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        lda #PI_IronSword1

          -
          pha
          lda #(`aItemRAMData)<<8
          sta lR18+1
          lda wCurrentItemDataRAMPointer,b
          sta lR18
          clc
          adc #size(structItemRAMEntry)
          sta wCurrentItemDataRAMPointer,b

          ldx #<>aSaveItemRAMData
          jsr rsSaveBitpackedDataOffsets._Entry
          pla
          inc a
          cmp #144 + 1
          bne -

        rts

        .databank 0

      rsLoadItemRAMData ; 91/F2E1

        .al
        .autsiz
        .databank ?

        lda aSave.wActiveSlot,b
        jsr rsGetSaveSlotMagicNumber
        cmp #SAVE_MAGIC_NUMBER
        beq _F321

          lda #PI_IronSword1
          jsl rlGetItemRAMStructEntryByPlayerItemIndex
          lda #PI_IronSword1

            _Loop1
            pha
            lda #(`aItemRAMData)<<8
            sta lR18+1
            lda wCurrentItemDataRAMPointer,b
            sta lR18
            clc
            adc #size(structItemRAMEntry)
            sta wCurrentItemDataRAMPointer,b
            pla

            pha
            jsr rsSeekOlderFormatItem
            lda aSave.wActiveSlot,b
            jsr rsGetSaveSlotMagicNumber
            ldx #<>aSaveItemRAMData
            jsr rsLoadBitpackedDataOffsets._Entry
            pla

            inc a
            cmp #144 + 1
            bne _Loop1

          rts

        _F321
        lda #PI_IronSword1
        jsl rlGetItemRAMStructEntryByPlayerItemIndex
        lda #PI_IronSword1

          _Loop2
          pha
          lda #(`aItemRAMData)<<8
          sta lR18+1
          lda wCurrentItemDataRAMPointer,b
          sta lR18
          clc
          adc #size(structItemRAMEntry)
          sta wCurrentItemDataRAMPointer,b
          ldx #<>aSaveItemRAMData
          jsr rsLoadBitpackedDataOffsets._Entry
          pla

          inc a
          cmp #144 + 1
          bne _Loop2

        rts

        .databank 0

      rsSeekOlderFormatItem ; 91/F34B

        .al
        .autsiz
        .databank ?

        ; For a slot in the older format (magic number $1206): moves lR18 from item A's place to the place aSaveOlderItemOrder gives it in that format.

        sta aSave.wStructCount,b
        tax

        lda aSaveOlderItemOrder,x
        and #$00FF
        sec
        sbc aSave.wStructCount,b
        asl a
        sta aSave.wStructCount,b
        asl a
        clc
        adc aSave.wStructCount,b
        clc
        adc lR18
        sta lR18
        rts

        .databank 0

      aSaveOlderItemOrder ; 91/F369

        .byte $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F, $10, $11
        .byte $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F, $20, $21, $22, $23
        .byte $24, $25, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F, $30, $31, $32, $33, $34, $35, $36
        .byte $37, $38, $39, $3B, $3E, $3C, $3D, $3F, $40, $41, $42, $44, $43, $45, $46, $47, $48, $49
        .byte $4A, $4B, $4C, $4D, $4F, $50, $51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C
        .byte $5D, $5E, $5F, $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $6E
        .byte $6F, $74, $70, $71, $72, $73, $7B, $77, $75, $7D, $7F, $81, $79, $82, $83, $84, $85, $86
        .byte $7C, $78, $76, $7E, $80, $7A, $87, $8A, $8B, $88, $26, $4E, $3A, $89, $8C, $8D, $8E, $8F
        .byte $90

      rsSaveChapterLocationData ; 91/F3FA

        .al
        .autsiz
        .databank ?

        ldx #0

          -
          lda aChapterLocationRAMData,x
          sta wR0
          lda #8
          sta aSave.wDataBitLength,b
          jsr rsWriteBitpackedSaveData
          inc x
          cpx #len(aChapterLocationRAMData)
          bcc -

        ldx #0

          -
          lda aChapterLocationMoneyRewards,x
          sta wR0
          lda #14
          sta aSave.wDataBitLength,b
          jsr rsWriteBitpackedSaveData
          inc x
          inc x
          cpx #len(aChapterLocationMoneyRewards)
          bcc -

        rts

        .databank 0

      rsLoadChapterLocationData ; 91/F42C

        .al
        .autsiz
        .databank ?

        ldx #0

          -
          lda #8
          sta aSave.wDataBitLength,b
          jsr rsReadBitpackedSaveData
          sta aChapterLocationRAMData,x
          inc x
          cpx #len(aChapterLocationRAMData)
          bcc -

        ldx #0

          -
          lda #14
          sta aSave.wDataBitLength,b
          jsr rsReadBitpackedSaveData
          sta aChapterLocationMoneyRewards,x
          inc x
          inc x
          cpx #len(aChapterLocationMoneyRewards)
          bcc -

        rts

        .databank 0

      aSaveChapterEventData ; 91/F45A

        .byte structChapterEventRAMEntry.Chapter,                5
        .byte structChapterEventRAMEntry.Counter1,               8 + LoadAsByteFlag
        .byte structChapterEventRAMEntry.Counter2,               8 + LoadAsByteFlag
        .byte structChapterEventRAMEntry.TemporaryEventFlags,   16
        .byte structChapterEventRAMEntry.TemporaryEventFlags+2, 16
        .byte structChapterEventRAMEntry.TemporaryEventFlags+4, 16
        .byte structChapterEventRAMEntry.TemporaryEventFlags+6, 16
        .byte structChapterEventRAMEntry.TemporaryEventFlags+8, 16
        .byte $FF

      rsSaveChapterEventData ; 91/F46B

        .al
        .autsiz
        .databank ?

        ldx #0

          -
          lda aPermanentEventFlags,x
          sta wR0
          lda #8
          sta aSave.wDataBitLength,b
          jsr rsWriteBitpackedSaveData
          inc x
          cpx #len(aPermanentEventFlags)
          bcc -

        lda #(`aChapterEventRAMData)<<8
        sta lStructPointer2+1,b
        lda #<>aChapterEventRAMData
        sta lStructPointer2,b
        jsl rlGetRAMStructCurrentStructCount
        sta wR0
        lda #2
        sta aSave.wDataBitLength,b
        jsr rsWriteBitpackedSaveData

        lda #2
        sta aSave.wStructIndex,b
        lda #0

          -
          pha
          inc a
          sta wStructIndex,b
          jsl rlGetRAMStructEntryPointerByStructIndex
          lda lStructPointer1+1,b
          sta lR18+1
          lda lStructPointer1,b
          sta lR18
          ldx #<>aSaveChapterEventData
          jsr rsSaveBitpackedDataOffsets._Entry
          pla
          inc a
          cmp aSave.wStructIndex,b
          bne -

        rts

        .databank 0

      rsLoadChapterEventData ; 91/F4C8

        .al
        .autsiz
        .databank ?

        jsl rlInitiateChapterEventRAMData

        ldx #0
        
          -
          lda #8
          sta aSave.wDataBitLength,b
          jsr rsReadBitpackedSaveData
          sta aPermanentEventFlags,x
          inc x
          cpx #len(aPermanentEventFlags)
          bcc -

        lda #(`aChapterEventRAMData)<<8
        sta lStructPointer2+1,b
        lda #<>aChapterEventRAMData
        sta lStructPointer2,b
        lda #2
        sta aSave.wDataBitLength,b
        jsr rsReadBitpackedSaveData

        sta aSave.wStructCount,b
        lda #2
        sta aSave.wStructIndex,b
        lda #0

          -
          pha
          lda #(`aDecompressionBuffer)<<8
          sta lR18+1
          lda #<>aDecompressionBuffer
          sta lR18
          ldx #<>aSaveChapterEventData
          jsr rsLoadBitpackedDataOffsets._Entry

          lda aSave.wStructCount,b
          beq +

            lda #(`aDecompressionBuffer)<<8
            sta lStructPointer1+1,b
            lda #<>aDecompressionBuffer
            sta lStructPointer1,b
            jsl rlAppendNewStructEntry
            dec aSave.wStructCount,b

          +
          pla
          inc a
          cmp aSave.wStructIndex,b
          bne -

        jsl rlUnknown86C4EB
        rts

        .databank 0

      aSaveGeneralData ; 91/F538

        .byte 8
        .long aSave.wActiveSaveData

        .byte 8
        .long wCurrentChapter

        .byte 8 + LoadAsByteFlag
        .long wCurrentTurn

        .byte 7
        .long wLoadedUnitCount

        .byte 4
        .long wLoadedFactionCount

        .byte 16
        .long wOptionSettings

        .byte 8
        .long wAreaRestrictionBitfield

        .byte 15
        .long wMapXOffset

        .byte 15
        .long wMapYOffset

        .byte 8
        .long wCursorXOffset

        .byte 8
        .long wCursorYOffset

        .byte 16
        .long aChapterActiveMapChanges

        .byte 16
        .long aChapterActiveMapChanges +2

        .byte 11
        .long wTotalLevelUpCount

        .byte 6
        .long wTotalAlivePlayerUnitCount

        .byte 8
        .long $000897

        .byte 6
        .long wDestroyedLocationsCount

        .byte 8 + LoadAsByteFlag
        .long wCurrentTurn + 1

        .byte 8
        .long aSave.wStructCount

        .byte 10
        .long aSave.wStructCount

        .byte 8
        .long aSave.wStructCount

        .byte 16
        .long aSave.wStructCount

        .byte 16
        .long aSave.wStructCount

        .byte 4
        .long aSave.wStructCount

        .byte 4
        .long aSave.wStructCount

        .byte 15
        .long aSave.wStructCount

        .byte $FF

      rsSaveGeneralSaveData ; 91/F5A1

        .al
        .autsiz
        .databank ?

        lda #0
        sta aSave.wStructCount,b

        ldx #<>aSaveGeneralData
        jsr rsSaveBitpackedDataList._Entry

        jsr rsSaveChapterTurncountsHigh

        ; ViewingHomeCastleFlag
        lda wUnknown000D79,b
        and #$0020
        beq +

          lda #1

        +
        sta wR0

        lda #1
        sta aSave.wDataBitLength,b
        jsr rsWriteBitpackedSaveData

        jsr rsSaveUnitWinCounts
        jsr rsSaveChapterTurncountsLow
        jsr rsSaveRNArray
        jsr rsSaveUnitJoinOrderData
        rts

        .databank 0

      rsLoadGeneralSaveData ; 91/F5D3

        .al
        .autsiz
        .databank ?

        ldx #<>aSaveGeneralData
        jsr rsLoadBitpackedDataList._Entry

        lda wMapYOffset
        and #$FFF0
        sta wMapYOffset
        lda wMapXOffset
        and #$FFF0
        sta wMapXOffset

        jsr rsLoadChapterTurncountsHigh

        lda #1
        sta aSave.wDataBitLength,b
        jsr rsReadBitpackedSaveData
        lsr a
        bcc +

          ; ViewingHomeCastleFlag
          lda #$0020
          ora wUnknown000D79,b
          sta wUnknown000D79,b

        +
        jsr rsLoadUnitWinCounts
        jsr rsLoadChapterTurncountsLow
        jsr rsLoadRNArray
        jsr rsLoadUnitJoinOrderData

        lda aSave.wActiveSlot,b
        jsr rsGetSaveSlotMagicNumber
        cmp #SAVE_MAGIC_NUMBER
        beq _End

          lda wCurrentTurn,b
          cmp #$00FF
          bne _End

            lda #$FFFF
            sta wCurrentTurn,b

        _End
        rts

        .databank 0

      rsSaveUnitWinCounts ; 91/F62D

        .al
        .autsiz
        .databank ?

        ldx #0

          -
          lda aUnitWinCounts,x
          sta wR0
          lda #12
          sta aSave.wDataBitLength,b
          jsr rsWriteBitpackedSaveData
          inc x
          inc x
          cpx #len(aUnitWinCounts)
          bne -

        rts

        .databank 0

      rsLoadUnitWinCounts ; 91/F647

        .al
        .autsiz
        .databank ?

        ldx #0

          -
          lda #12
          sta aSave.wDataBitLength,b
          jsr rsReadBitpackedSaveData
          sta aUnitWinCounts,x
          inc x
          inc x
          cpx #len(aUnitWinCounts)
          bne -

        rts

        .databank 0

      rsSaveChapterTurncountsLow ; 91/F65F

        .al
        .autsiz
        .databank ?

        ; Since turn counts only get capped at 999, the number needs
        ; to be saved as a 10 bit value, this handles the lower 8 bit.

        ldx #0
        
          -
          lda aChapterTurncounts,x
          sta wR0
          lda #8
          sta aSave.wDataBitLength,b
          jsr rsWriteBitpackedSaveData
          inc x
          inc x
          cpx #len(aChapterTurncounts)
          bne -

        rts

        .databank 0

      rsSaveChapterTurncountsHigh ; 91/F679

        .al
        .autsiz
        .databank ?

        ; See previous routine. This handles the higher 2 bit.

        ldx #0
        
          -
          lda aChapterTurncounts + 1,x
          sta wR0
          lda #2
          sta aSave.wDataBitLength,b
          jsr rsWriteBitpackedSaveData
          inc x
          inc x
          cpx #len(aChapterTurncounts)
          bne -

        rts

        .databank 0

      rsLoadChapterTurncountsLow ; 91/F693

        .al
        .autsiz
        .databank ?

        ldx #0

          -
          lda #8
          sta aSave.wDataBitLength,b
          jsr rsReadBitpackedSaveData
          sep #$20
          sta aChapterTurncounts,x
          rep #$20
          inc x
          inc x
          cpx #len(aChapterTurncounts)
          bne -

        rts

        .databank 0

      rsLoadChapterTurncountsHigh ; 91/F6AF

        .al
        .autsiz
        .databank ?

        ldx #0

          -
          lda #2
          sta aSave.wDataBitLength,b
          jsr rsReadBitpackedSaveData
          sep #$20
          sta aChapterTurncounts+1,x
          rep #$20
          inc x
          inc x
          cpx #len(aChapterTurncounts)
          bne -

        rts

        .databank 0

      rsSaveRNArray ; 91/F6CB

        .al
        .autsiz
        .databank ?

        ldx #0

          -
          lda aRNArray,x
          sta wR0
          lda #7
          sta aSave.wDataBitLength,b
          jsr rsWriteBitpackedSaveData
          inc x
          cpx #len(aRNArray) + 1
          bne -

        rts

        .databank 0

      rsLoadRNArray ; 91/F6E4

        .al
        .autsiz
        .databank ?

        ldx #0

          -
          lda #7
          sta aSave.wDataBitLength,b
          jsr rsReadBitpackedSaveData
          sta aRNArray,x
          inc x
          cpx #len(aRNArray) + 1
          bne -

        rts

        .databank 0

      aSaveUnitJoinOrderData ; 91/F6FB

        .byte 3 
        .long wUnitWindowPage
        
        .byte 6 
        .long wUnitWindowSortType
        
        .byte 1 
        .long wUnitWindowSortDirection
        
        .byte 2 
        .long aUnitJoinOrder[12]

        .byte $FF

      rsSaveUnitJoinOrderData ; 91/F70C

        .al
        .autsiz
        .databank ?

        ldx #0

          -
          lda aUnitJoinOrder[0],x
          sta wR0
          lda #5
          sta aSave.wDataBitLength,b
          jsr rsWriteBitpackedSaveData
          inc x
          cpx #len(aUnitJoinOrder)
          bne -

        ldx #<>aSaveUnitJoinOrderData
        jsr rsSaveBitpackedDataList._Entry
        rts

        .databank 0

      rsLoadUnitJoinOrderData ; 91/F72B

        .al
        .autsiz
        .databank ?

        ldx #0

          -
          lda #5
          sta aSave.wDataBitLength,b
          jsr rsReadBitpackedSaveData
          sta aUnitJoinOrder[0],x
          inc x
          cpx #len(aUnitJoinOrder)
          bne -

        ldx #<>aSaveUnitJoinOrderData
        jsr rsLoadBitpackedDataList._Entry
        rts

        .databank 0

        ; 91/F748

    .endsection SaveSlotSection


    .section Unsorted87F501Section

      .al
      .xl

      rlGetCharacterUnitType ; 87/F501

        .al
        .xl
        .autsiz
        .databank ?

        ; A = character ID; returns its unit type (UnitTypeStatic, ...) from its ROM entry.

        phb
        phy
        jsl rlSwapToMainDataBank
        jsl rlGetCharacterDataROMPointer
        tay
        lda $0000,b,y
        and #$00FF
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/F515

    .endsection Unsorted87F501Section


    .section Unsorted87F515Section

      .al
      .xl

      rlCreateUnitFromBuffers ; 87/F515

        .al
        .autsiz
        .databank ?

        ; Allocates a unit RAM struct for character A and fills it from the save buffers (aUnit1DataBuffer and others), by unit type.

        phb
        phx
        phy
        tay

        lda #(`aUnitRAMArea)<<8
        sta lR18+1
        lda #<>aUnitRAMArea
        sta lR18
        jsl rlBufferAndLoadNewRAMAreaPointer

        lda #size(structCharacterDataRAM)
        jsl rlAllocateRAMArea

        lda lR25
        sta wSelectedUnitDataRAMPointer,b

        lda #(`aUnitRAMPointers)<<8
        sta lStructPointer2+1,b
        lda #<>aUnitRAMPointers
        sta lStructPointer2,b

        lda lR25
        sta lStructPointer1,b

        jsl rlAppendNewStructEntry

        tya
        jsr rsCreateUnitFromBuffersByType
        jsr rsRestoreUnitDeployment
        jsr rsAddUnitToFaction
        jsl rlLoadBufferedRAMAreaPointer

        ply
        plx
        plb
        rtl

        .databank 0

        ; 87/F559

    .endsection Unsorted87F515Section


    .section Unsorted87F55ASection

      .al
      .xl

      rsCreateUnitFromBuffersByType ; 87/F55A

        .al
        .xl
        .autsiz
        .databank ?

        phb
        jsl rlSwapToMainDataBank
        jsl rlGetCharacterDataROMPointer
        tay
        lda $0000,b,y
        and #$00FF
        sta aSave.wCreatedUnitType,b
        asl a
        tax
        jsr (aCreateUnitFromBuffersByTypeHandlers,x)
        plb
        .databank ?
        rts

        .databank 0

        ; 87/F574

    .endsection Unsorted87F55ASection


    .section Unsorted87F9F6Section

      .al
      .xl

      rlExpandStaticDynamicUnitBuffer1UnitStates ; 87/F9F6

        .al
        .xl
        .autsiz
        .databank ?

        ; Undoes rlCompactStaticDynamicUnitBuffer1UnitStates after loading.

        lda aUnit1DataBuffer
        sta wR0
        and #$0007
        sta wR1
        lda wR0
        asl a
        asl a
        asl a
        and #$03C0
        ora wR1
        sta wR1
        lda wR0
        asl a
        asl a
        asl a
        asl a
        asl a
        and #$F000
        ora wR1
        sta aUnit1DataBuffer
        rtl

        .databank 0

        ; 87/FA1E

    .endsection Unsorted87F9F6Section


    .section Unsorted87FA57Section

      .al
      .xl

      rlExpandHolyEnemyUnitBuffer1UnitStates ; 87/FA57

        .al
        .xl
        .autsiz
        .databank ?

        ; Undoes rlCompactHolyEnemyUnitBuffer1UnitStates after loading.

        lda aUnit1DataBuffer
        sta wR0
        and #$0007
        sta wR1
        lda wR0
        asl a
        asl a
        asl a
        asl a
        asl a
        and #$0300
        ora wR1
        sta wR1
        lda wR0
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        and #$F000
        ora wR1
        sta aUnit1DataBuffer
        rtl

        .databank 0

        ; 87/FA83

    .endsection Unsorted87FA57Section


    .section Unsorted87FABCSection

      .al
      .xl

      rsRestoreUnitDeployment ; 87/FABC

        .al
        .xl
        .autsiz
        .databank ?

        ; Puts a loaded unit back on the map at its saved position, with deployment state bits from the saved state and its unit states (guarding, moved, asleep, defeated, alive or hidden). A saved state $1F at X and Y $3F means not deployed.

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        phx
        phy
        lda aSave.wCharacterDeploymentState,b
        cmp #$001F
        bne _FADB
        lda aSave.wCharacterXPosition,b
        and aSave.wCharacterYPosition,b
        cmp #$003F
        beq _FB52

        _FADB
        lda aSave.wCharacterYPosition,b
        xba
        ora aSave.wCharacterXPosition,b
        sta wRoutineVariable1,b
        jsl rlDeployUnitCheckIfAsleep
        tax
        jsl rlSetSelectedUnitDeploymentOffset
        lda aDeploymentTable,x
        and #$000B
        sta wR0
        lda aSave.wCharacterDeploymentState,b
        xba
        ora wR0
        sta wR0
        jsl rlGetSelectedUnitStates
        sta wR1
        and #UnitStateGuardingCastle
        beq _FB0E
        lda #DeploymentStateGuardingCastle
        tsb wR0

        _FB0E
        lda wR1
        and #UnitStateMoved
        beq _FB1A
        lda #DeploymentStateGrayed
        tsb wR0

        _FB1A
        jsl rlGetSelectedUnitStatus
        cmp #StatusSleep
        bne _FB28
        lda #DeploymentStateAsleep
        tsb wR0

        _FB28
        lda wR1
        and #UnitStateDead
        beq _FB36
        lda #DeploymentStateDefeated
        tsb wR0
        beq _FB42

        _FB36
        lda wR1
        and #UnitStateFielded
        beq _FB42
        lda #DeploymentStateAlive
        bra _FB45


        _FB42
        lda #DeploymentStateHidden

        _FB45
        tsb wR0
        lda wR0
        sta aDeploymentTable,x
        sta @l aDeploymentTable._StateBuffer,x
        bra _FB59


        _FB52
        lda #$FFFF
        jsl rlSetSelectedUnitDeploymentOffset

        _FB59
        ply
        plx
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 87/FB5E

    .endsection Unsorted87FABCSection


    .section Unsorted87FB5ESection

      .al
      .xl

      rlPrepareFactionUnitLists ; 87/FB5E

        .al
        .autsiz
        .databank ?

        ; After the faction headers load: points each faction's list end (aSave.aFactionEntryOffsets) just past its header, and turns a saved location $0F into $FF (none).

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        phx
        phy
        ldx #0
        
          _Loop
          lda aFactionArea,x
          tay
          clc
          adc #size(structFactionHeader)
          sta aSave.aFactionEntryOffsets[0],b,x
          sep #$20

          lda aFactionArea + structFactionHeader.LocationID,y
          cmp #$0F
          bne +

            lda #$FF
            sta aFactionArea + structFactionHeader.LocationID,y

          +
          rep #$20

          inc x
          inc x
          cpx #7 * size(word)
          bne _Loop

        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 87/FB94

    .endsection Unsorted87FB5ESection


    .section Unsorted87FB94Section

      .al
      .xl

      rsAddUnitToFaction ; 87/FB94

        ; TRACE: odd-opcode
        .al
        .xl
        .autsiz
        .databank ?

        ; Appends the loaded unit to its faction's unit list (brk if the list would run into the next faction's). Faction slot 7 has no list.

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        phx
        phy
        jsl rlGetSelectedUnitFactionSlot
        cmp #$0007
        beq _FBC0
        asl a
        tax
        lda aSave.aFactionEntryOffsets[0],b,x
        cmp <>(aFactionArea+2),b,x
        bne _FBB4
        .byte $00 ; brk

        _FBB4
        tay
        inc a
        inc a
        sta aSave.aFactionEntryOffsets[0],b,x
        lda wSelectedUnitDataRAMPointer,b
        sta aFactionArea,y

        _FBC0
        ply
        plx
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 87/FBC5

    .endsection Unsorted87FB94Section


    .section Unsorted80F1D5Section

      .al
      .xl

      rsSetupSaveSelectMenu ; 80/F1D5

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Sets up title/file-select save menu (step 0, 91E565/E52B/D6EC, 80B0D3, DMAs $7E9D88->$D000, procFadeIn)

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        jsl rlUnknown91E565
        jsl rlUnknown91E52B
        jsl rlUnknown91D6EC
        jsl rlQueueMenuFontDecompression
        jsl rlDMAByStruct

          .structDMAToVRAM $7E9D88, $0600, $80, $D000

        stz wGameStateStep,b
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        plp
        cli
        rts

        .databank 0

        ; 80/F222

    .endsection Unsorted80F1D5Section


    .section Unsorted80F222Section

      .al
      .xl

      rsOpenMapSaveMenu ; 80/F222

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Opens map Save menu (state 5/4, step 2, $1864=1, installs rsRunSaveMenuVBlank and rsRunSaveMenuMainLoop)

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        sta $2100,b
        rep #$20
        jsl rlDisableVBlank
        stz aSave.wMenuOperation,b
        jsl rlUnknown91E52B
        jsl rlUnknown91D6EC
        lda #GAMESTATE_SAVE_MENU_UPKEEP
        sta wGameStateRoutine2,b
        lda #GAMESTATE_SAVE_MENU_SETUP
        sta wGameStateRoutine1,b
        lda #$0002
        sta wGameStateStep,b
        lda #$0001
        sta $1864,b
        lda #<>rsRunSaveMenuVBlank
        sta wVBlankPointer
        lda #<>rsRunSaveMenuMainLoop
        sta wMainLoopPointer
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        plp
        cli
        rts

        .databank 0

        ; 80/F27C

      rsOpenChapterSaveTransition ; 80/F27C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        ; Opens chapter-end save/transition (wMapMenuTransparentTile=$FF, state 6/4, step $23, installs rsRunSaveMenuVBlank)

        php
        jsl rlProcEngineResetProcEngine
        jsl rlActiveSpriteEngineReset
        jsl rlEnableActiveSpriteEngine
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsl rlInitMapMenus
        jsl rlResetMenuOptionStack
        lda #$00FF
        sta wMapMenuTransparentTile,b
        lda #GAMESTATE_SAVE_MENU_UPKEEP
        sta wGameStateRoutine2,b
        lda #GAMESTATE_SAVE_MENU_STEP
        sta wGameStateRoutine1,b
        lda #$0023
        sta wGameStateStep,b
        lda #<>rsRunSaveMenuVBlank
        sta wVBlankPointer
        lda #<>rsRunFrameTasks
        sta wMainLoopPointer
        plp
        cli
        rts

        .databank 0

        ; 80/F2BE

    .endsection Unsorted80F222Section


    .section Unsorted80F542Section

      .al
      .xl

      rsRunSaveMenuMainLoop ; 80/F542

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Save menu main loop: reset check, decompression list, deferred sound upload, rlHandleSaveFile

        jsl rlButtonCombinationResetCheck
        jsl rlDecompressByList
        jsl rlRunDeferredSoundUpload
        jsl rlHandleSaveFile
        rts

        .databank 0

        ; 80/F553

      rsRunAntiTamperMainLoop ; 80/F553

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Anti-tamper error main loop (omits reset check): decompression list, deferred sound upload, rlHandleSaveFile

        jsl rlDecompressByList
        jsl rlRunDeferredSoundUpload
        jsl rlHandleSaveFile
        rts

        .databank 0

        ; 80/F560

      rsRunSaveMenuVBlank ; 80/F560

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Save menu VBlank preserving wR0..wR5 and lR18..lR19+1 around DMA/OAM/HDMA/PPU/APU/joypad/sprites/game state

        lda wR0
        pha
        lda wR1
        pha
        lda wR2
        pha
        lda wR3
        pha
        lda wR4
        pha
        lda wR5
        pha
        lda lR18
        pha
        lda lR18+2
        pha
        lda lR19+1
        pha
        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlSendSoundQueuesToAPU
        jsl rlGetJoypadInput
        jsl rlIncreaseFrameCounters
        jsl rlClearSpriteExtBuffer
        jsl rlRunGameStateRoutines
        jsl rlRunVBlankHooks
        jsl rlHideSprites
        jsl rlUpdateSound
        pla
        sta lR19+1
        pla
        sta lR18+2
        pla
        sta lR18
        pla
        sta wR5
        pla
        sta wR4
        pla
        sta wR3
        pla
        sta wR2
        pla
        sta wR1
        pla
        sta wR0
        rts

        .databank 0

        ; 80/F5D0

      rsRunAntiTamperVBlank ; 80/F5D0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Anti-tamper minimal VBlank preserving wR0..wR5 and lR18..lR19+1 around OAM/HDMA/PPU/APU/joypad/sprites/state

        lda wR0
        pha
        lda wR1
        pha
        lda wR2
        pha
        lda wR3
        pha
        lda wR4
        pha
        lda wR5
        pha
        lda lR18
        pha
        lda lR18+2
        pha
        lda lR19+1
        pha
        sep #$20
        lda #$80
        sta $2100,b
        rep #$20
        jsl rlProcessDMAStructArray
        jsl rlDMAPaletteAndOAMBuffer
        jsl rlHandlePossibleHDMA
        jsl rlCopyPPURegisterBuffer
        jsl rlSendSoundQueuesToAPU
        jsl rlGetJoypadInput
        pla
        sta lR19+1
        pla
        sta lR18+2
        pla
        sta lR18
        pla
        sta wR5
        pla
        sta wR4
        pla
        sta wR3
        pla
        sta wR2
        pla
        sta wR1
        pla
        sta wR0
        rts

        .databank 0

        ; 80/F628

    .endsection Unsorted80F542Section


