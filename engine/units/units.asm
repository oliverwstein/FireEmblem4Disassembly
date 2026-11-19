; Creating, deleting and finding units, and reading a character's ROM data: name,
; class, level, map sprite, portrait and starting equipment.

    .section UnitsSection

      .al
      .xl

      rlCreateUnit ; 84/8397

        .al
        .autsiz
        .databank ?

        phb

        phk
        plb

        jsl rlSwapToMainDataBank

        jsl rlGetCharacterDataROMPointer

        tay
        lda structCharacterROMEntry.Type,b,y
        and #$00FF
        asl a
        tax
        jsr (aUnitCreationRoutinesByType,x)
        plb
        rtl

        .databank 0

      aUnitCreationRoutinesByType ; 84/83B0

        .addr rsCreateStaticUnitRAMData
        .addr rsCreateDynamicUnitRAMData
        .addr rsCreateHolyUnitRAMData
        .addr rsCreateEnemyUnitRAMData

      rlDeleteUnit ; 84/83B8

        .al
        .autsiz
        .databank ?

        ; This removes a unit from the Unit RAM pointer table, clears their aDeploymentTable data,
        ; decrements the deployment count, unstets all unit states, flags all pointers in their structCharacterDataRAM
        ; as free and decrements the loaded unit count

        phb
        phk
        plb
        phx

        lda #(`aUnitRAMPointers)<<8
        sta lStructPointer2+1,b
        lda #<>aUnitRAMPointers
        sta lStructPointer2,b
        lda wSelectedUnitDataRAMPointer,b
        sta lStructPointer1,b
        jsl rlRemoveRAMStructEntry
        bcs _SEC

        jsl rlGetSelectedUnitDeploymentOffset
        bcs +

          jsl rlClearUnitDeploymentData

        +
        lda #$FFFF
        jsl rlUnsetSelectedUnitStates
        jsl rlClearSelectedUnitRAMAreaData
        dec wLoadedUnitCount,b
        clc

        -
        plx
        plb
        rtl

        _SEC
        sec
        bra -

        .databank 0

      rlUnknown8483F3 ; 84/83F3

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda wR1
        pha
        lda wR2
        pha

        sep #$20
        lda lRoutineVariable+2,b
        pha
        rep #$20
        plb

        lda wR10
        sec
        sbc #16
        sta wR10

        lda wR11
        sec
        sbc #16
        sta wR11

        lda lRoutineVariable
        tay
        ldx #$0400
        lda #$FFFF

        -
        sta $0000,b,y
        inc y
        inc y
        dec x
        dec x
        bne -

        ldx #(len(aDeploymentTable._State) - 2)

        -
        lda aDeploymentTable._State,x
        bit #DeploymentStateAlive
        beq _Next

          bit #DeploymentStateHidden
          bne _Next

            bit #DeploymentStateDefeated
            bne _Next

              lda aDeploymentTable._XTilePosition,x
              sec
              sbc wR10
              sta wR1

              cmp #32
              bcs _Next

                lda aDeploymentTable._YTilePosition,x
                sec
                sbc wR11
                sta wR2

                cmp #32
                bcs _Next

                  lda wR2
                  asl a
                  asl a
                  asl a
                  asl a
                  asl a
                  clc
                  adc wR1
                  clc
                  adc lRoutineVariable
                  tay
                  txa
                  sep #$20
                  sta $0000,b,y
                  rep #$20

        _Next
        dec x
        dec x
        bpl -

        pla
        sta wR2
        pla
        sta wR1
        plp
        plb
        rtl

        .databank 0

      rlGetCharacterDataROMPointer ; 84/8481

        .al
        .autsiz
        .databank ?

        ; A = CharacterID

        phb
        php
        phk
        plb
        phx
        dec a
        bmi +

          pha
          lda aMainDataOffsets.CharacterDataOffsets
          tax

          pla
          asl a
          cmp aMainDataOffsets,x
          bcs +

            clc
            adc aMainDataOffsets.CharacterDataOffsets
            tax
            lda aMainDataOffsets,x
            clc
            adc aMainDataOffsets.CharacterDataOffsets
            adc #<>aMainDataOffsets
            plx
            plp
            plb
            clc

            -
            rtl

        +
        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rlGetUnitRAMDataPointerByID ; 84/84B4

        .al
        .autsiz
        .databank `aUnitRAMPointers

        ; Input:
        ; A = CharacterID

        ; Output:
        ; wSelectedUnitDataRAMPointer
        ; SEC if not found

        phb
        phx
        ldx wR34
        phx
        ldx wR35
        phx

        sta wR34

        sep #$20
        lda #`aUnitRAMPointers
        pha
        rep #$20
        plb

        lda aUnitRAMPointers._Header.CurrentStructCount
        and #$00FF
        asl a
        sta wR35

        ldx #0

          -
          lda aUnitRAMPointers._Entry[0],x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitCharacterID
          cmp wR34
          beq _CLC

            inc x
            inc x
            cpx wR35
            bcc -

        stz wSelectedUnitDataRAMPointer,b
        sec

        -
        pla
        sta wR35
        pla
        sta wR34
        plx
        plb
        rtl

        _CLC
        clc
        bra -

        .databank 0

      rlGetCharacterNamePointer ; 84/84F6

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phx
        dec a
        bmi +

        asl a
        clc
        adc aMainDataOffsets.CharacterNameOffsets
        tax
        lda #(`aMainDataOffsets)<<8
        sta lRoutineVariable+1,b
        lda aMainDataOffsets,x
        clc
        adc aMainDataOffsets.CharacterNameOffsets
        adc #<>aMainDataOffsets
        sta lRoutineVariable,b

        -
        plx

        plp
        plb
        rtl

        +
        lda #(`aCharacterNameNone)<<8
        sta lRoutineVariable+1,b
        lda #<>aCharacterNameNone
        sta lRoutineVariable,b
        bra -

        .databank 0

      aCharacterNameNone ; 84/852C

        .enc "SJIS"
        .text "\n"

      rlGetCharacterClass ; 84/852E

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = CharacterID

        phb
        php
        phk
        plb
        phy
        cmp #size(aCharacterDataOffsets)/size(word) + 1
        bcs _Invalid

          ; Is within the character ID bounds

          jsl rlSwapToMainDataBank

          jsl rlGetCharacterDataROMPointer
          tay
          lda structCharacterROMEntry.Type,b,y
          and #$00FF
          cmp #UnitTypeEnemy
          beq _Enemy

          cmp #UnitTypeDynamic
          beq _Dynamic

          ; static or holy
          lda structStaticCharacterROMEntry.Class,b,y
          bra _End

          _Dynamic
          lda structDynamicCharacterROMEntry.Class,b,y
          bra _End
          
          _Enemy
          lda structEnemyCharacterROMEntry.Class,b,y

          _End
          and #$00FF
          ply
          plp
          plb
          rtl

        _Invalid
        lda #0
        bra _End

        .databank 0

      rlGetCharacterLevel ; 84/856A

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy

        jsl rlSwapToMainDataBank
        jsl rlGetCharacterDataROMPointer

        tay
        lda structCharacterROMEntry.Type,b,y
        and #$00FF
        cmp #UnitTypeEnemy
        beq _Enemy

        cmp #UnitTypeDynamic
        beq _Dynamic

        ; Static/Holy
        lda structStaticCharacterROMEntry.Level,b,y
        bra +
        
        _Dynamic
        lda structDynamicCharacterROMEntry.Level,b,y
        bra +
        
        _Enemy
        lda structEnemyCharacterROMEntry.Level,b,y

        +
        and #$00FF
        ply
        plp
        plb
        rtl

        .databank 0

      rlGetCharacterMapSprite ; 84/859C

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = CharacterID

        ; Output:
        ; A = MapSpriteID

        phb
        php
        phk
        plb
        phx
        phy
        ldx wR0
        phx
        ldx wR1
        phx

        jsl rlSwapToMainDataBank

        sta wR1
        jsl rlGetCharacterDataROMPointer
        tay

        lda structCharacterROMEntry.Type,b,y
        and #$00FF
        cmp #UnitTypeDynamic
        beq _Dynamic

        cmp #UnitTypeEnemy
        beq _Enemy

        ; Static/Holy
        lda structStaticCharacterROMEntry.Gender,b,y
        and #$00FF
        sta wR0
        lda structStaticCharacterROMEntry.Class,b,y
        bra _85F2

        _Dynamic
        lda structDynamicCharacterROMEntry.Gender,b,y
        and #$00FF
        sta wR0
        lda structDynamicCharacterROMEntry.Class,b,y
        bra _85F2

        _Enemy
        lda structEnemyCharacterROMEntry.Gender,b,y
        bit #$0080
        bne +

        and #$007F
        bra ++

        +
        ora #$FF80

        +
        sta wR0
        lda structEnemyCharacterROMEntry.Class,b,y

        _85F2
        and #$00FF
        jsr rsGetClassMapSprite

        plx
        stx wR1
        plx
        stx wR0
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown848603 ; 84/8603

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        ldx wR1
        phx

        jsl rlGetCharacterMapSprite
        sta wR1
        jsl rlAddDeployedMapSprite

        pla
        sta wR1
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetCharacterPortraitDataID ; 84/861C

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = PortraitID

        ; Output:
        ; A = PortraitDataID

        phb
        php
        phk
        plb
        phx

        dec a
        asl a
        tax
        lda aPortraitDataIDs,x
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetCharacterEquipSlotItemROMPointer ; 84/862C

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = CharacterID
        ; wR0 = Equipment slot: 1 or 2

        ; Output:
        ; wCurrentItemDataROMPointer

        phb
        php
        phk
        plb
        phx
        phy
        ldy wR0
        phy
        ldy wR1
        phy

        stz wCurrentItemDataROMPointer,b
        cpx #3
        bcs _End

          dec x
          stx wR0
          jsl rlSwapToMainDataBank
          jsl rlGetCharacterDataROMPointer
          tay
          lda structCharacterROMEntry.Type,b,y
          and #$00FF
          sta wR1
          asl a
          tax

          tya
          clc
          adc wR0
          clc
          adc aEquipmentOffsetsByUnitType,x
          tay

          lda wR1
          cmp #UnitTypeHoly
          bcc +

            lda $0000,b,y
            and #$00FF
            cmp #$00FF
            beq _End

              jsl rlGetItemDataROMPointer
              bra _End

          +
          lda $0000,b,y
          and #$00FF
          cmp #$00FF
          beq _End

            jsl rlGetItemRAMStructEntryByPlayerItemIndex
            bcs _End

              jsl rlGetEffectiveItemROMPointerByItemRAMStructEntry

        _End
        pla
        sta wR1
        pla
        sta wR0
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      aEquipmentOffsetsByUnitType ; 84/8698

        .word structStaticCharacterROMEntry.Equipment1
        .word structDynamicCharacterROMEntry.Equipment1
        .word structStaticCharacterROMEntry.Equipment1
        .word structEnemyCharacterROMEntry.Equipment1

        ; 84/86A0

    .endsection UnitsSection
