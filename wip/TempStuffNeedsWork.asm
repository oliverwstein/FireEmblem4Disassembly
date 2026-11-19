; Routines from TempStuff.asm with assembly errors that need investigation.
; Each one starts with the errors it produced (line numbers are relative to its label).

; NEEDS WORK (rsUnknown81AD8E):
;   line 12: branch too far by +25 bytes
;   line 16: branch too far by +17 bytes
;   line 9: branch too far by +30 bytes
      rsUnknown81AD8E ; 81/AD8E

        .al
        .autsiz
        .databank ?

        lda $0E7B,b
        bit #$0040
        beq _End

          bit #$0020
          bne _End

            lda wUnknown000D79,b
            bit #$0080
            beq _End

              lda #$0080
              trb wUnknown000D79,b

              ldx $0E82,b
              lda aAIUnitList.UnitRAMPointer,x
              sta wSelectedUnitDataRAMPointer,b

              lda #$0021
              sta bEventActionIdentifier,b
              lda wCurrentTurn,b
              sta wEventEngineArgument1,b
              lda wActiveFactionSlot,b
              sta wEventEngineArgument2,b
              jsl rlGetSelectedUnitAI
              sta wEventEngineArgument3,b
              jsl rlGetSelectedUnitCharacterID
              sta wEventEngineArgument4,b
              jsl rlGetAndRunChapterMapEventConditions

        _End
        rts

        .databank 0


; NEEDS WORK (rsUnknown81B270):
;   line 12: not defined symbol 'wSelectedUnitDataRAMPointer'
      rsUnknown81B270 ; 81/B270

        .al
        .autsiz
        .databank ?

        lda #8
        jsl rlGetItemIDByInventorySlot
        jsl rlGetItemDataROMPointer
        lda wCurrentItemDataROMPointer,b
        sta aProcSystem.wInput0,b
        lda aProcSystem.wSelectedUnitDataRAMPointer,b
        sta aProcSystem.wInput3,b
        jsl $85B52F
        jsl $85B520
        lda aProcSystem.wSelectedUnitDataRAMPointer,b
        sta aProcSystem.wInput0,b
        lda wCurrentItemDataROMPointer,b
        sta aProcSystem.wInput1,b
        lda #(`procUnknown85B18F)<<8
        sta lR44+1
        lda #<>procUnknown85B18F
        sta lR44
        jsl rlEventEngineCreateProc
        rts

        .databank 0


; NEEDS WORK (rlGetFatherUnitsChildrenRAMPointers):
;   line 69: branch too far by -128 bytes
      rlGetFatherUnitsChildrenRAMPointers ; 84/8DF4

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = father CharacterID

        ; Output:
        ; wSonCharacterROMPointer
        ; wDaughterCharacterROMPointer

        phb
        php
        phk
        plb
        phx

        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        phx
        ldx wR1
        phx

        sta wR0

        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        lda aUnitRAMPointers._Entry
        and #$00FF
        asl a
        sta wR1

        stz wSonCharacterROMPointer
        stz wDaughterCharacterROMPointer

        ldx #0

          _Loop
          lda aUnitRAMPointers._Entry,x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitFatherID
          cmp wR0
          bne _Next

            jsl rlGetSelectedUnitGender
            cmp #GenderMale
            bne _Female

              lda wSelectedUnitDataRAMPointer,b
              sta wSonCharacterROMPointer
              bra _Next

            _Female
            lda wSelectedUnitDataRAMPointer,b
            sta wDaughterCharacterROMPointer

          _Next
          inc x
          inc x
          cpx wR1
          bcc _Loop

        stz wSelectedUnitDataRAMPointer,b

        pla
        sta wR1
        pla
        sta wR0
        pla
        sta wSelectedUnitDataRAMPointer,b

        plx
        plp
        plb
        rtl

        .databank 0

        ; 84/8E5D

















































































; NEEDS WORK (aItemObtainedText):
;   line 3: can't encode character '<U+3000>' (U+3000)
      aItemObtainedText ; 85/BC8C

        .text "　をてにいれた！  "


; NEEDS WORK (rlUnknown8780F9):
;   line 48: not defined symbol 'Unknown4'
      rlUnknown8780F9 ; 87/80F9

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy
        lda #$0027
        jsl rlUnknown87819A
        bcs +

          ldy lR19
          sep #$20
          lda lR19+2
          pha
          rep #$20
          plb

          lda lMapMenuRAMEntryPointer
          sta structMapMenu.Unknown3,b,y
          lda lMapMenuRAMEntryPointer+1
          sta structMapMenu.Unknown3+1,b,y
          bra ++

        +
        lda lMapMenuRAMEntryPointer,b
        sta lUnknown000522,b
        lda lMapMenuRAMEntryPointer+1,b
        sta lUnknown000522+1,b

        +
        phk
        plb

        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda #0
        sta structMapMenu.Unknown3,b,y
        sta structMapMenu.Unknown4,b,y
        ply
        plp
        plb
        rtl

        .databank 0

        ; 87/8148










; NEEDS WORK (rlEventMovementBuildTargetDistanceMap):
;   line 321: not defined symbol 'wUnknown7EC4A4'
      rlEventMovementBuildTargetDistanceMap ; 87/B197

        .al
        .autsiz
        .databank ?

        ; Similar to rlGetNearestPossibleTarget of the AI routine but
        ; builds the map traversal list in the decomp buffer.

        phb
        php
        phk
        plb
        phx
        phy
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        lda #`aEventMovement.aTargetDistanceMap
        ldx #<>aEventMovement.aTargetDistanceMap
        jsl rlClearMapBufferAddBorders

        ; Clear the row of map tile above and below the map buffers

        ldx #(64 >> 1) - 2
        lda #$FFFF

          -
          sta aEventMovement.aTargetDistanceMap - 64,x
          sta aEventMovement.aTargetDistanceMap - 32,x
          sta aEventMovement.aTargetDistanceMap + size(aTargetDistanceMap),x
          sta aEventMovement.aTargetDistanceMap + size(aTargetDistanceMap) + 32,x

          sta aEventMovement.aTargetMap - 64,x
          sta aEventMovement.aTargetMap - 32,x
          sta aEventMovement.aTargetMap + size(aTargetMap),x
          sta aEventMovement.aTargetMap + size(aTargetMap) + 32,x

          dec x
          dec x
          bpl -

        ; Get map tile index
        lda aEventMovement.wStartingYCoordinate
        xba
        lsr a
        lsr a
        clc
        adc aEventMovement.wStartingXCoordinate
        tay

        lda aEventMovement.aTargetMap,y
        bit #$0080
        bne +

          jml _UnitOnTarget

        +
        sep #$20
        lda #1
        sta aEventMovement.aTargetDistanceMap,y
        rep #$20

        sty aEventMovement.aMapTraversalList

        stz aEventMovement.wAnalyzeTraversalOffset

        lda #2
        sta aEventMovement.wMapTraversalListOffset
        lda #1
        sta aEventMovement.wRunningMovementCost

        _Loop
        ldx aEventMovement.wAnalyzeTraversalOffset

        stz aEventMovement.wFilledMapTraversalListFlag
        sep #$20

          -
          ldy aEventMovement.aMapTraversalList,x
          lda aEventMovement.aTargetDistanceMap,y
          cmp aEventMovement.wRunningMovementCost
          bne +
          bra _CheckDirections

            _MarkFinishedMapTileIndex
            lda #$FF
            sta aEventMovement.aMapTraversalList + 1,x
            sta aEventMovement.wFilledMapTraversalListFlag

          +
          dec x
          dec x
          bpl -

        ; Done handling all previous entries.

        rep #$20
        lda aEventMovement.wFilledMapTraversalListFlag
        beq _EmptyList

          ; Overwrite marked entries and shift all following ones forward.

          ldx #0
          ldy #0
          
            -
            lda aEventMovement.aMapTraversalList,x
            bmi +

              sta aEventMovement.aMapTraversalList,y
              inc y
              inc y

            +
            inc x
            inc x
            cpx aEventMovement.wMapTraversalListOffset
            bne -

          sty aEventMovement.wMapTraversalListOffset

        _EmptyList
        lda aEventMovement.wMapTraversalListOffset
        beq _CLC

          dec a
          dec a
          sta aEventMovement.wAnalyzeTraversalOffset
          inc aEventMovement.wRunningMovementCost
          lda aEventMovement.wRunningMovementCost
          cmp #$00FC
          bne _Loop

        _CLC
        ply
        plx
        plp
        plb
        clc
        rtl

        _CheckDirections
        phx
        ldx aEventMovement.wMapTraversalListOffset

        ; Check up
        lda aEventMovement.aMovementCostMap - 64,y
        bmi _UpUntraversable

          xba
          lda aEventMovement.aTargetDistanceMap - 64,y
          bne +

            xba
            clc
            adc aEventMovement.wRunningMovementCost
            sta aEventMovement.aTargetDistanceMap - 64,y
            rep #$20
            tya
            clc
            adc #-64
            sta aEventMovement.aMapTraversalList,x
            inc x
            inc x
            sep #$20
            bra +

        _UpUntraversable
        lda #$FF
        sta aEventMovement.aTargetDistanceMap - 64,y
        lda aEventMovement.wTargetXCoordinate
        beq _CheckLeft

        +
        lda aEventMovement.aTargetMap - 64,y
        bmi _CheckLeft

          jml _TargetIsUpwards

        _CheckLeft
        lda aEventMovement.aMovementCostMap - 1,y
        bmi _LeftUntraversable

          xba
          lda aEventMovement.aTargetDistanceMap - 1,y
          bne +

            xba
            clc
            adc aEventMovement.wRunningMovementCost
            sta aEventMovement.aTargetDistanceMap - 1,y
            rep #$20
            tya
            clc
            adc #$FFFF
            sta aEventMovement.aMapTraversalList,x
            inc x
            inc x
            sep #$20
            bra +
        
        _LeftUntraversable
        lda #$FF
        sta aEventMovement.aTargetDistanceMap - 1,y
        lda aEventMovement.wTargetXCoordinate
        beq _CheckDown
        
        +
        lda aEventMovement.aTargetMap - 1,y
        bmi _CheckDown

          jml _TargetIsLeftwards

        _CheckDown
        lda aEventMovement.aMovementCostMap + 64,y
        bmi _DownUntraversable

          xba
          lda aEventMovement.aTargetDistanceMap + 64,y
          bne +

            xba
            clc
            adc aEventMovement.wRunningMovementCost
            sta aEventMovement.aTargetDistanceMap + 64,y
            rep #$20
            tya
            clc
            adc #64
            sta aEventMovement.aMapTraversalList,x
            inc x
            inc x
            sep #$20
            bra +
        
        _DownUntraversable
        lda #$FF
        sta aEventMovement.aTargetDistanceMap + 64,y
        lda aEventMovement.wTargetXCoordinate
        beq _CheckRight
        
        +
        lda aEventMovement.aTargetMap + 64,y
        bmi _CheckRight

          jml _TargetIsDownwards

        _CheckRight
        lda aEventMovement.aMovementCostMap + 1,y
        bmi _RightUntraversable

          xba
          lda aEventMovement.aTargetDistanceMap + 1,y
          bne +

            xba
            clc
            adc aEventMovement.wRunningMovementCost
            sta aEventMovement.aTargetDistanceMap + 1,y
            rep #$20
            tya
            clc
            adc #1
            sta aEventMovement.aMapTraversalList,x
            inc x
            inc x
            sep #$20
            bra +

        _RightUntraversable
        lda #$FF
        sta aEventMovement.aTargetDistanceMap + 1,y
        lda aEventMovement.wTargetXCoordinate
        beq _DoneChecking

        +
        lda aEventMovement.aTargetMap + 1,y
        bmi _DoneChecking

          jml _TargetIsRightwards

        _DoneChecking
        stx aEventMovement.wMapTraversalListOffset
        plx
        jml _MarkFinishedMapTileIndex

        _TargetIsUpwards
        plx
        ldx #-64
        bra +
        
        _TargetIsLeftwards
        plx
        ldx #-1
        bra +
        
        _TargetIsRightwards
        plx
        ldx #1
        bra +

        _TargetIsDownwards
        plx
        ldx #64
        bra +

        _UnitOnTarget
        ldx #0

        +
        rep #$20
        and #$00FF
        pha

        txa
        sta wUnknown7EC4A4,b
        tya
        clc
        adc wUnknown7EC4A4,b
        tay
        and #$003F
        sta aEventMovement.wTargetXCoordinate
        tya
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta aEventMovement.wTargetYCoordinate

        pla
        ply
        plx
        plp
        plb
        sec
        rtl

        .databank 0


; NEEDS WORK (rlFillEventMovementMoveCostMap):
;   line 37: not a data bank address code '$7e9388'
;   line 63: not a data bank address code '$7e9388'
;   line 64: not a data bank address code '$7e9388'
      rlFillEventMovementMoveCostMap ; 87/B386

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #`aMapData
        pha
        rep #$20
        plb
        .databank `aMapData

        phx
        phy
        sep #$20
        ldy #(size(aMapData)-2) >> 1

          -
          rep #$20
          tya
          asl a
          tax
          lda aMapData,x
          and #$03FF
          tax
          lda aTerrainTileset,x
          and #$00FF
          clc
          adc aEventMovement.wMovementCostPointer
          tax
          sep #$20
          lda aMainDataOffsets,x
          inc a
          sta aEventMovement.aMovementCostMap,y
          dec y
          bpl -

        rep #$20
        ldx #(len(aDeploymentTable._State) - 2)

          -
          lda aDeploymentTable._State,x
          bit #DeploymentStateAlive
          beq _Next

            bit #DeploymentStateHidden
            bne _Next

              lda aDeploymentTable._YTilePosition,x
              and #$00FF
              xba
              lsr a
              lsr a
              clc
              adc aDeploymentTable._XTilePosition,x
              tay
              sep #$20
              lda #8
              clc
              adc aEventMovement.aMovementCostMap,y
              sta aEventMovement.aMovementCostMap,y
              rep #$20

          _Next
          dec x
          dec x
          bpl -

        ply
        plx
        plp
        plb
        rtl

        .databank 0


; NEEDS WORK (rlEventMovementCreateMovementScriptFromTargetDistanceMap):
;   line 158: can't get integer value of segment
      rlEventMovementCreateMovementScriptFromTargetDistanceMap ; 87/B3F3

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy
        asl a
        tax
        lda aEventMovementMovementScriptBufferAddresses,x
        sta aEventMovement.wMovementScriptBufferAddress

        sep #$20
        lda #`aEventMovement
        pha
        rep #$20
        plb
        .databank `aEventMovement

        ; Get map tile index of the targeted unit thats about to move
        lda aEventMovement.wTargetYCoordinate
        xba
        lsr a
        lsr a
        clc
        adc aEventMovement.wTargetXCoordinate
        tay

        sty aEventMovement.wMapTileIndex
        lda #$01FE
        sta aEventMovement.wMaxScriptCommandsCount
        
        _Loop
        sep #$20
        lda aEventMovement.aTargetDistanceMap,y
        cmp #1
        bcs +

          jml _End

        +
        sta aEventMovement.wLowestMovementDistance
        lda #$FE
        sta aEventMovement.aTargetDistanceMap,y
        ldx #8

        lda aEventMovement.wMapTileIndex
        lsr a
        bcs _CounterClockwise

        lda aEventMovement.aTargetDistanceMap - 64,y
        beq +

          cmp aEventMovement.wLowestMovementDistance
          bcs +

            sta aEventMovement.wLowestMovementDistance
            ldx #0

        +
        lda aEventMovement.aTargetDistanceMap + 1,y
        beq +

          cmp aEventMovement.wLowestMovementDistance
          bcs +

            sta aEventMovement.wLowestMovementDistance
            ldx #2

        +
        lda aEventMovement.aTargetDistanceMap + 64,y 
        beq +

          cmp aEventMovement.wLowestMovementDistance
          bcs +

            sta aEventMovement.wLowestMovementDistance
            ldx #4

        +
        lda aEventMovement.aTargetDistanceMap - 1,y
        beq +

          cmp aEventMovement.wLowestMovementDistance
          bcs +

            ldx #6

        +
        bra _Continue
        
        _CounterClockwise
        lda aEventMovement.aTargetDistanceMap - 1,y
        beq +

          cmp aEventMovement.wLowestMovementDistance
          bcs +

            sta aEventMovement.wLowestMovementDistance
            ldx #6

        +
        lda aEventMovement.aTargetDistanceMap + 64,y
        beq +

          cmp aEventMovement.wLowestMovementDistance
          bcs +

            sta aEventMovement.wLowestMovementDistance
            ldx #4

        +
        lda aEventMovement.aTargetDistanceMap + 1,y
        beq +

          cmp aEventMovement.wLowestMovementDistance
          bcs +

            sta aEventMovement.wLowestMovementDistance
            ldx #2

        +
        lda aEventMovement.aTargetDistanceMap - 64,y
        beq _Continue

          cmp aEventMovement.wLowestMovementDistance
          bcs _Continue

            sta aEventMovement.wLowestMovementDistance
            ldx #0

        _Continue
        cpx #8
        beq _End

          rep #$20
          tya
          clc
          adc aEventMovementMapTileDirectionOffsets,x
          tay
          rep #$20
          lda aEventMovementDirectionLookupTable,x
          jsr rsEventMovementWriteToMovementScriptBuffer
          inc aEventMovement.wMapTileIndex
          rep #$20
          dec aEventMovement.wMaxScriptCommandsCount
          beq _End

            jml _Loop

        _End
        sep #$20
        lda #MAP_END
        jsr rsEventMovementWriteToMovementScriptBuffer
        ply
        plx
        plp
        plb
        rtl

        .databank 0


; NEEDS WORK (aEventMovementDirectionLookupTable):
;   line 3: can't get integer value of segment
;   line 4: can't get integer value of segment
;   line 5: can't get integer value of segment
;   line 6: can't get integer value of segment
      aEventMovementDirectionLookupTable ; 87/B4FD

        .word MAP_UP
        .word MAP_RIGHT
        .word MAP_DOWN
        .word MAP_LEFT


; NEEDS WORK (rlFillItemsOwnerAndSlotData):
;   line 58: not defined symbol 'aItems'
;   line 92: branch too far by -752 bytes
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
            lda aUnit1DataBuffer._Inventory.aItems[0],x
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
          cmp #size(aItemRAMData._Entry) + 1
          bne _Loop

        plx
        plp
        plb
        rtl

        .databank 0


; NEEDS WORK (rlProcUnknown8AE199Init):
;   line 10: can't get length of struct
      rlProcUnknown8AE199Init ; 8A/E1A1

        .al
        .autsiz
        .databank ?

        jsl rlSavePaletteBufferColorsToRAM

          .long $7E9BA8
          .word len(Palette)
          .word aOAMPaletteBuffer.aPalette4 - aBGPaletteBuffer

        ldx #size(Palette)-2
        lda #0

          -
          sta aOAMPaletteBuffer.aPalette4,b,x
          dec x
          dec x
          bpl -

        lda #0
        sta $7F808B
        rtl

        .databank 0


; NEEDS WORK (aBelhallaAttackingMagePositions):
;   line 3: too large for a 8 bit unsigned integer int '12804'
;   line 4: too large for a 8 bit unsigned integer int '12552'
;   line 5: too large for a 8 bit unsigned integer int '12292'
;   line 6: too large for a 8 bit unsigned integer int '12040'
;   line 7: too large for a 8 bit unsigned integer int '11780'
      aBelhallaAttackingMagePositions ; 9E/F811

        .byte pack([4, 50])
        .byte pack([8, 49])
        .byte pack([4, 48])
        .byte pack([8, 47])
        .byte pack([4, 46])
        .word $FFFF

; NEEDS WORK (no label): battle banner graphics from bank $9C and a pointer table that
; were written after rsUnknown959A4D without an address label of their own.
; 998D84

      g4bppcBattleBannerLeonster .text ROM[$1CD95E:$1CDA67]
      g4bppcBattleBannerDozel .text ROM[$1CDA67:$1CDBB8]
      g4bppcBattleBannerYngvi .text ROM[$1CDBB8:$1CDCEF]
      g4bppcBattleBannerChalphy .text ROM[$1CDCEF:$1CDE2B]
      g4bppcBattleBannerNordion .text ROM[$1CDE2B:$1CDF6F]
      g4bppcBattleBannerIsaach .text ROM[$1CDF6F:$1CE0C0]
      g4bppcBattleBannerThracia .text ROM[$1CE0C0:$1CE20F]
      g4bppcBattleBannerVelthomer .text ROM[$1CE20F:$1CE367]
      g4bppcBattleBannerFreege .text ROM[$1CE367:$1CE494]
      g4bppcBattleBannerSilesse .text ROM[$1CE494:$1CE5D0]
      g4bppcBattleBannerEdda .text ROM[$1CE5D0:$1CE706]
      g4bppcBattleBannerBelhalla .text ROM[$1CE706:$1CE845]
      g4bppcBattleBannerLoptr .text ROM[$1CE845:$1CE98C]
      g4bppcBattleBannerDefault .text ROM[$1CE98C:$1CEAEE]

      ; tilemaps
      .text ROM[$1CEAEE:$1CEBED]
      .text ROM[$1CEBED:$1CECA6]

      .fill $DC8000 + $8000 - *, 0

;bank end








        .long $9CD95E, $7E8B9A
        .long $9CDA67, $7E8BBA
        .long $9CDBB8, $7E8BDA
        .long $9CDCEF, $7E8BFA
        .long $9CDE2B, $7E8C1A
        .long $9CDF6F, $7E8C3A
        .long $9CE0C0, $7E8C5A
        .long $9CE20F, $7E8C7A
        .long $9CE367, $7E8C9A
        .long $9CE494, $7E8CBA
        .long $9CE5D0, $7E8CDA
        .long $9CE706, $7E8CFA
        .long $9CE845, $7E8D1A
        .long $9CE98C, $7E8D3A

; 998DD8





