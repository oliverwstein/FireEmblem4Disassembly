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
        ; decrements the deployment count, unsets all unit states, flags all pointers in their structCharacterDataRAM
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

      rlBuild32x32MapUnitGrid ; 84/83F3

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

      rlRegisterCharacterMapSprite ; 84/8603

        .al
        .autsiz
        .databank ?

        ; Adds the map sprite of character A to the deployed map sprites.

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
        ; X = Equipment slot: 1 or 2

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


    .section FindCharacterByGenerationIDSection

      .al
      .xl

      rlFindCharacterByGenerationID ; 84/8726

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = GenerationID

        ; Output:
        ; CLC if successful
        ; Filled wSelectedUnitDataRAMPointer

        phb
        phx
        phy
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
        .databank `aUnitRAMPointers

        lda aUnitRAMPointers._Header.CurrentStructCount
        and #$00FF
        asl a
        sta wR35

        ldx #0

          -
          lda aUnitRAMPointers._Entry[0],x
          sta wSelectedUnitDataRAMPointer,b
          tay
          lda structCharacterDataRAM.Type,b,y
          and #$00FF
          cmp #UnitTypeHoly
          bcs +

            jsl rlGetSelectedUnitGenerationID
            cmp wR34
            beq _CLC

          +
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
        ply
        plx
        plb
        rtl

        _CLC
        clc
        bra -

        .databank 0

    .endsection FindCharacterByGenerationIDSection


    .section GetUnitByCoordinatesSection

      .al
      .xl

      rlGetUnitByCoordinates ; 84/8776

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR0 = X coordinate
        ; wR1 = Y coordinate

        ; Output:
        ; CLC if unit found, filled wSelectedUnitDataRAMPointer
        ; SEC if no unit at coordinates

        phb
        phk
        plb
        phx
        lda wR2
        pha

        stz wR2
        ldx #len(aDeploymentTable._State)-2

          _Loop
          lda aDeploymentTable._State,x
          bit #DeploymentStateAlive
          beq +

            inc wR2
            lda aDeploymentTable._XTilePosition,x
            cmp wR0
            bne +

              lda aDeploymentTable._YTilePosition,x
              cmp wR1
              beq _CLC

          +
          lda wR2
          cmp wDeployedUnitsCount,b
          bcs _SEC

          dec x
          dec x
          bpl _Loop

        _SEC
        sec
        bra +

        _CLC
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        txa
        clc

        +
        pla
        sta wR2
        plx
        plb
        rtl

        .databank 0

      rlLoadUnitGroup ; 84/87BA

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lR18 = UNITGroupPointer entry
        ; lR19 = Pointer to child replacement data

        phb
        php
        phk
        plb
        phx
        phy
        lda #1
        sta wR0

        ldy lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        _Loop
        lda structUNITEntry.CharacterID,b,y
        bne +

          jml _Next

        +
        cmp #$FFFF
        bne +

          jml _End

        +
        jsr rsLoadUnitGroupTryReplaceCharacterIDWithChild
        sta wRoutineVariable1,b

        lda structUNITEntry.FactionSlot,b,y
        and #$00FF
        tax

        lda wRoutineVariable1,b
        jsl rlGetUnitRAMDataPointerByID
        bcs +

          jsl rlGetSelectedUnitStates
          bit #UnitStateFielded
          beq ++

        +
        cpx #0
        beq _Next

        lda wRoutineVariable1,b
        jsl rlLoadUnit

        +
        txa
        jsl rlAssignUnitToFactionSlot
        jsr rsDeployUnitByPlaceholderID
        bcs +

        lda structUNITEntry.DestinationCoords,b,y
        sta wRoutineVariable1,b
        jsl rlDeploySelectedUnit

        +
        lda structUNITEntry.AI,b,y
        and #$00FF
        jsl rlSetSelectedUnitAI

        jsl rlGetSelectedUnitClassID
        cmp #Civilian
        beq +

          cmp #Child
          beq +

            lda structUNITEntry.GroupLeaderFlag,b,y
            bit #$0001
            beq +

              lda #UnitStateGroupLeader
              jsl rlSetSelectedUnitStates

        +
        lda wRoutineVariable1,b
        tax
        jsl rlGetTerrainTypeByDeploymentOffset
        cmp #TerrainCastle
        bne +

          jsl rlStartGuardingCastleAtUnit

        +
        lda structUNITEntry.FormationID,b,y
        and #$00FF
        jsl rlSetFormationIDByDeploymentOffset

        _Next
        inc wR0
        tya
        clc
        adc #size(structUNITEntry)
        tay
        jml _Loop

        _End
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rsLoadUnitGroupTryReplaceCharacterIDWithChild ; 84/8873

        .al
        .autsiz
        .databank ?

        lda lR19
        ora lR19+1
        beq _End

          lda structUNITEntry.CharacterID,b,y
          sta wR10
          phb
          phy

          ldy lR19
          sep #$20
          lda lR19+2
          pha
          rep #$20
          plb

          lda $0000,b,y
          and #$00FF
          jsl rlCheckPermanentEventFlagSet
          bcc +

          lda $0001,b,y
          cmp wR10
          bne +

          lda $0003,b,y
          bra ++

          +
          ply
          plb
          bra _End

          +
          ply
          plb
          bra +

        _End
        lda structUNITEntry.CharacterID,b,y

        +
        rts

        .databank 0

    .endsection GetUnitByCoordinatesSection


    .section DeployUnitByPlaceholderIDSection

      .al
      .xl

      rsDeployUnitByPlaceholderID ; 84/88AE

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR0 = ?

        ; Output:
        ; SEC if a new unit was deployed

        ldx #size(aDeploymentTable._UnitRAMPointer) - 2

        _Loop
        lda aDeploymentTable._UnitRAMPointer,x
        beq _Next

          cmp #$2000
          bge _Next

            cmp wR0
            bne _Next

              lda wSelectedUnitDataRAMPointer,b
              sta aDeploymentTable._UnitRAMPointer,x
              jsl rlDeployedUnitUnsetHiddenIfAlive
              bra +

        _Next
        dec x
        dec x
        bpl _Loop

        clc
        rts

        +
        txa
        jsl rlSetSelectedUnitDeploymentOffset
        lda #UnitStateFielded
        jsl rlSetSelectedUnitStates
        jsl rlGetSelectedUnitFactionSlot
        sta aDeploymentTable._FactionSlot,x
        stx wRoutineVariable1,b
        sec
        rts

        .databank 0

        ; 84/88EC


; Ishtore Death Quote $8EEA40


; 07 
; 00 3D OpenBox
; 00 3F LoadPortrait
; 52 02 
; 09 StartText

; 86 
; 61 
; 92 
; BF 
; BF 
; BF 

; 0A 
; AA 
; 09 
; 29 
; BF 
; BF 
; BF 

; 02 NewLine

; 00 1D C8  PauseText $C8

; 01 EndText 


; EA5A
; 07 
; 00 3D OpenBox
; 00 3F LoadPortrait
; 52 02 
; 09 

; 86 
; 61 
; 92 
; BF 
; BF 
; BF 

; 02 NewLine

; 10 23 29 
; 1F 28 3D 0A 18 09 48 47 BF BF BF 


; 02 NewLine
; 00 1D C8 PauseText $C8
; 01 EndText

    .endsection DeployUnitByPlaceholderIDSection


    .section LoadUNITGroupMapSpritesSection

      .al
      .xl

      rlLoadUNITGroupMapSprites ; 84/88EC

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        lda #1
        sta wR0
        ldy lR18

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

          _Loop
          lda structUNITEntry.CharacterID,b,y
          beq _Next

            cmp #$FFFF
            beq _End

              jsl rlGetCharacterMapSprite
              sta wR1

              jsl rlAddDeployedMapSprite

          _Next
          inc wR0
          tya
          clc
          adc #size(structUNITEntry)
          tay
          bra _Loop

        _End
        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/8924


      rlFindTargetsInRange ; 84/8924

        .al
        .autsiz
        .databank $84

        ; check if in range?

        ; wR10 = item min range
        ; wR11 = item max range

        php
        phx
        ldx wR0
        phx
        ldx wSelectedUnitDataRAMPointer,b
        phx

        phb
        phk
        plb

        asl a
        tax
        lda aTargetFilterRoutines,x
        sta wR0

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        stz $442A,b

        lda wR11
        cmp wR10
        bcs +

          ; Max range < Min range
          jml _End

        +
        lda wR10
        bne +

          ; Min range = 0?
          jml _End

        +
        sta $4420,b

        lda wR11
        bne +

          ; Max range = 0?
          jml _End

        +
        sta $4422,b

        lda wR12
        beq _Loop

          ldx #$03FE
          lda #$FFFF

          -
          sta $854A,b,x
          dec x
          dec x
          bpl -

        _Loop
        lda $4420,b
        clc
        adc #16
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc #16
        sta aAIAction.wAttackTileMapTileIndex

        lda #3
        sta $4428,b

          -
          lda $4420,b
          dec a
          sta aAIAction.wAttackDirection

          lda $4428,b
          asl a
          tax
          lda aRangeDiamondStepDeltas,x
          sta aAIAction.wAttackMapTileIndexModifier

            -
            ldx aAIAction.wAttackTileMapTileIndex
            lda aRangeMap,x
            and #$00FF
            cmp #$00FF
            beq +

              ; A = deployment offset
              jsr rsRunTargetFilter
              bcc +

                inc $442A,b
                lda wR12
                beq +

                  sep #$20
                  lda aRangeMap,x
                  sta $854A,b,x
                  rep #$20
            
            +
            lda aAIAction.wAttackTileMapTileIndex
            clc
            adc aAIAction.wAttackMapTileIndexModifier
            sta aAIAction.wAttackTileMapTileIndex

            dec aAIAction.wAttackDirection
            bpl -

          dec $4428,b
          bpl --

        inc $4420,b
        lda $4420,b
        cmp $4422,b
        bcc _Loop
        beq _Loop
        
        _End
        lda $442A,b

        plb
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        stx wR0

        plx
        plp
        rtl

        .databank 0

      rsRunTargetFilter ; 84/89F2

        .al
        .autsiz
        .databank ?

        jmp (wR0)

        .databank 0

      aRangeDiamondStepDeltas ; 84/89F5

        .word 31
        .word 33
        .word -31 & $FFFF
        .word -33 & $FFFF

        .word $FFFF
        .word $0001
        .word $0001
        .word $0001
        .word $0001
        .word $FFFF
        .word $FFFF
        .word $FFFF

      aTargetFilterRoutines ; 84/8A0D

        .word <>rsTargetFilterEnemy
        .word <>rsTargetFilterFriendly
        .word <>rsTargetFilterOwnFaction
        .word <>rsTargetFilterTalkEventOrPair
        .word <>rsTargetFilterEnemyAtCastle
        .word <>rsTargetFilterCivilianOrChild
        .word <>rsTargetFilterTalkEvent
        .word <>rsTargetFilterGrayedOwnFaction
        .word <>rsTargetFilterNotFullHP
        .word <>rsTargetFilterHasStatus
        .word <>rsTargetFilterOwnFactionUnderMoneyCap
        .word <>rsTargetFilterLoverUnderMoneyCap
        .word <>rsTargetFilterMagicUserWithLowerResistance
        .word <>rsTargetFilterEnemyWithLowerResistance

      rsTargetFilterEnemy ; 84/8A29

        .al
        .autsiz
        .databank ?

        jsl rlCheckIfDeployedUnitIsEnemy
        rts

        .databank 0

      rsTargetFilterFriendly ; 84/8A2E

        .al
        .autsiz
        .databank ?

        jsl rlCheckIfDeployedUnitIsFriendly
        rts

        .databank 0

      rsTargetFilterOwnFaction ; 84/8A33

        .al
        .autsiz
        .databank ?

        jsl rlCheckIfTargetBelongsToOwnFaction
        rts

        .databank 0

      rsTargetFilterTalkEventOrPair ; 84/8A38

        .al
        .autsiz
        .databank ?

        ; Accepts a target with a talk event; if there is none, rlCheckIsTalkTargetOf decides.

        phx
        tax
        lda aDeploymentTable._UnitRAMPointer,x
        sta wRoutineVariable1
        jsl rlCheckTalkEventEntryAvailable
        bcs +

          jsl rlCheckIsTalkTargetOf
        
        +
        plx
        rts

        .databank 0

      rsTargetFilterEnemyAtCastle ; 84/8A4E

        .al
        .autsiz
        .databank ?

        ; Accepts an enemy on a castle gate or guarding a castle.

        phx
        tax
        txa
        jsl rlCheckIfDeployedUnitIsEnemy
        bcc _CLC

        txa
        jsl rlGetTerrainTypeByDeploymentOffset
        cmp #TerrainCastleGate
        beq _SEC

        lda aDeploymentTable._State,x
        bit #DeploymentStateGuardingCastle
        beq _CLC
        
        _SEC
        plx
        sec
        rts
        
        _CLC
        plx
        clc
        rts

        .databank 0

      rsTargetFilterCivilianOrChild ; 84/8A70

        .al
        .autsiz
        .databank ?

        phx
        tax
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitClassID
        cmp #Civilian
        beq _SEC

        cmp #Child
        bne _CLC

        _SEC
        plx
        sec
        rts

        _CLC
        plx
        clc
        rts

        .databank 0

      rsTargetFilterTalkEvent ; 84/8A8E

        .al
        .autsiz
        .databank ?

        phx
        tax
        lda aDeploymentTable._UnitRAMPointer,x
        sta wRoutineVariable1
        jsl rlCheckTalkEventEntryAvailable
        plx
        rts

        .databank 0

      rsTargetFilterGrayedOwnFaction ; 84/8A9E

        .al
        .autsiz
        .databank ?

        ; Accepts a unit of its own faction that has moved (grayed) and is not asleep.

        phx
        tax
        lda aDeploymentTable._State,x
        bit #DeploymentStateAsleep
        bne _CLC

        bit #DeploymentStateGrayed
        bne +

        _CLC
        clc
        bra _End
        
        +
        txa
        jsl rlCheckIfTargetBelongsToOwnFaction
        
        _End
        plx
        rts

        .databank 0

      rsTargetFilterNotFullHP ; 84/8AB8

        .al
        .autsiz
        .databank ?

        ; Accepts a target with less than full HP, if rlCheckIfDeployedUnitIsFriendly
        ; accepts it.

        phx
        phy
        tax
        lda wSelectedUnitDataRAMPointer
        tay

        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitMaxHP
        sta $442C,b
        jsl rlGetSelectedUnitCurrentHP
        cmp $442C,b
        bne +

          tya
          sta wSelectedUnitDataRAMPointer
          clc
          bra _End

        +
        tya
        sta wSelectedUnitDataRAMPointer
        txa
        jsl rlCheckIfDeployedUnitIsFriendly
        
        _End
        ply
        plx
        rts

        .databank 0

        ; 84/8AED

    .endsection LoadUNITGroupMapSpritesSection


    .section TargetFilterRoutinesSection

      .al
      .xl

      rsTargetFilterHasStatus ; 84/8AED

        .al
        .xl
        .autsiz
        .databank ?

        ; Accepts a target whose status is not StatusHealthy, if
        ; rlCheckIfDeployedUnitIsFriendly accepts it.

        phx
        phy
        tax
        lda @l wSelectedUnitDataRAMPointer
        tay
        lda aDeploymentTable._UnitRAMPointer,x
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitStatus
        cmp #StatusHealthy
        bne _8B0E
        tya
        sta @l wSelectedUnitDataRAMPointer
        clc
        bra _8B18


        _8B0E
        tya
        sta @l wSelectedUnitDataRAMPointer
        txa
        jsl rlCheckIfDeployedUnitIsFriendly

        _8B18
        ply
        plx
        rts

        .databank 0

        ; 84/8B1B

      rsTargetFilterOwnFactionUnderMoneyCap ; 84/8B1B

        .al
        .xl
        .autsiz
        .databank ?

        ; Accepts a unit of its own faction with less than 50000.

        phx
        phy
        tax
        lda @l wSelectedUnitDataRAMPointer
        tay
        lda aDeploymentTable._UnitRAMPointer,x
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitMoney
        cmp #$C350
        bcc _8B3C
        tya
        sta @l wSelectedUnitDataRAMPointer
        clc
        bra _8B46


        _8B3C
        tya
        sta @l wSelectedUnitDataRAMPointer
        txa
        jsl rlCheckIfTargetBelongsToOwnFaction

        _8B46
        ply
        plx
        rts

        .databank 0

        ; 84/8B49

      rsTargetFilterLoverUnderMoneyCap ; 84/8B49

        .al
        .xl
        .autsiz
        .databank ?

        ; Accepts a player unit with less than 50000 whose generation ID is the selected
        ; unit's lover generation ID.

        phx
        phy
        tax
        jsl rlGetSelectedUnitLoverGenerationID
        sta $442C,b
        lda @l wSelectedUnitDataRAMPointer
        tay
        lda aDeploymentTable._FactionSlot,x
        bne _8B78
        lda aDeploymentTable._UnitRAMPointer,x
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitMoney
        cmp #$C350
        bcs _8B78
        jsl rlGetSelectedUnitGenerationID
        cmp $442C,b
        beq _8B80

        _8B78
        tya
        sta @l wSelectedUnitDataRAMPointer
        clc
        bra _8B85


        _8B80
        tya
        sta @l wSelectedUnitDataRAMPointer

        _8B85
        ply
        plx
        rts

        .databank 0

        ; 84/8B88

      rsTargetFilterMagicUserWithLowerResistance ; 84/8B88

        .al
        .xl
        .autsiz
        .databank ?

        ; Accepts a target with a usable rank (A-C) in any of the staff and magic
        ; weapon types, if rsTargetFilterEnemyWithLowerResistance accepts it.

        phx
        phy
        tax
        lda @l wSelectedUnitDataRAMPointer
        tay
        lda aDeploymentTable._UnitRAMPointer,x
        sta @l wSelectedUnitDataRAMPointer
        lda #$0004
        sta $442C,b

        _8B9E
        lda $442C,b
        jsl rlGetSelectedUnitWeaponRank
        cmp #$0003
        bcc _8BBD
        inc $442C,b
        lda $442C,b
        cmp #$000A
        bcc _8B9E
        tya
        sta @l wSelectedUnitDataRAMPointer
        clc
        bra _8BC6


        _8BBD
        tya
        sta @l wSelectedUnitDataRAMPointer
        txa
        jsr rsTargetFilterEnemyWithLowerResistance

        _8BC6
        ply
        plx
        rts

        .databank 0

        ; 84/8BC9

      rsTargetFilterEnemyWithLowerResistance ; 84/8BC9

        .al
        .xl
        .autsiz
        .databank ?

        ; Accepts an enemy whose resistance is lower than the selected unit's magic.

        phx
        phy
        tax
        lda @l wSelectedUnitDataRAMPointer
        tay
        jsl rlGetSelectedUnitTotalMagic
        sta $442C,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitTotalResistance
        cmp $442C,b
        bcc _8BF1
        tya
        sta @l wSelectedUnitDataRAMPointer
        clc
        bra _8BFB


        _8BF1
        tya
        sta @l wSelectedUnitDataRAMPointer
        txa
        jsl rlCheckIfDeployedUnitIsEnemy

        _8BFB
        ply
        plx
        rts

        .databank 0

        ; 84/8BFE

    .endsection TargetFilterRoutinesSection


    .section CheckUnitPassesTargetFilterSection

      .al
      .xl

      rlCheckUnitPassesTargetFilter ; 84/8BFE

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs target filter A (aTargetFilterRoutines) on the unit at deployment offset X, with no range check. Carry set if the unit passes; the selected unit itself never does. Builds the castle's target lists.

        phb
        phk
        plb
        .databank $84
        phx
        phy
        ldy wR0
        phy
        phx
        asl a
        tax
        lda aTargetFilterRoutines,x
        sta wR0
        plx
        lda aDeploymentTable._UnitRAMPointer,x
        cmp wSelectedUnitDataRAMPointer,b
        beq _8C2E
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F
        txa
        pea #<>_8C27 - 1
        jmp (wR0)


        _8C27
        plx
        stx wR0
        ply
        plx
        plb
        .databank $7F
        rtl


        _8C2E
        clc
        bra _8C27

        .databank 0

        ; 84/8C31

    .endsection CheckUnitPassesTargetFilterSection


