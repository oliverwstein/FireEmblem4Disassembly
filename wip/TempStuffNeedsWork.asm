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

; NEEDS WORK (aASMapSpriteCode): its content is still raw bytes or half-converted code in comments.
      aASMapSpriteCode ; 81/89E0


; 0F rsActiveSpriteCommand0F

; 88 88 98 9D A0 11 A9 01 00 9D 80 11 22 F3 89 81 68 60 8B BD E0 12 89 00 40 F0 44 AE BE 17 BD C4 17 C9 FF FF F0 39 22 FE D7 88 BD D4 17 38 ED 98 05 C9 C0 FF B0 05 C9 40 01 B0 24 18 65 00 85 00 BD DC 17 38 ED 9A 05 C9 F0 FF B0 05 C9 00 01 B0 0E 18 65 02 85 02 BD 04 18 85 0A 22 C7 87 80 AB 6B 00 00 00 00 00 00 00 00 B9 00 13 C9 09 00 D0 05 A9 08 00 80 10 BD FC 17 C9 08 00 90 08 A9 04 00 80 03 A9 06 00 60 B9 E0 12 89 10 00 F0 0B 20 98 8C 90 06 22 76 8B 81 38 60 20 BF 8C B9 20 13 F0 02 18 60 84 27 BD E4 17 85 24 BD EC 17 85 25 BD F4 17 A8 B7 24 29 FF 00 C9 80 00 D0 06 22 76 8B 81 38 60 89 80 00 F0 2E 5A 29 7F 00 0A A8 B9 C6 8A 85 2A B9 C7 8A 85 2B 7A C8 22 C3 8A 81 90 D3 60 6C 2A 00 76 8B 5D 8B F0 8B F9 8B 13 8C 5D 8C 62 8C 67 8C 6C 8C A0 01 00 84 00 A4 27 C9 0A 00 90 17 E9 09 00 48 5A C8 BD F4 17 1A 9D F4 17 A8 B7 24 29 FF 00 85 00 7A 68 C9 09 00 F0 1D D9 00 13 F0 18 48 3A 0A 0A 0A 9F 11 09 00 A9 00 00 9F F1 08 00 A9 00 00 9F 01 09 00 68 99 00 13 BD F4 17 1A 9D F4 17 DA 20 4A 8A AA BF 54 8B 81 29 FF 00 EB 05 00 22 43 99 91 99 20 13 FA B9 00 13 C9 04 00 F0 06 A9 01 00 99 80 11 A9 00 00 99 40 13 18 60 80 80 40 20 10 08 04 02 01 5A 98 9D F4 17 BD C4 17 A8 B9 E0 12 29 FF 7F 99 E0 12 22 58 8D 81 7A 38 6B 5A BD C4 17 A8 20 91 8B A9 FF FF 9D C4 17 A9 00 00 99 00 11 22 58 8D 81 7A 38 6B B9 E0 12 89 0E 00 F0 56 DA 5A 89 08 00 D0 0A BD CC 17 AA 22 83 CB 84 80 43 BD 14 18 85 02 BD D4 17 85 04 BD DC 17 85 06 DA BD CC 17 AA A5 04 9F 3B 45 7E A5 06 9F CB 45 7E DA 22 6E C7 84 FA 9F 5B 46 7E FA BD 04 18 EB 4A 3A 09 80 00 29 BF FF 85 00 BD CC 17 AA A5 00 9F 8B 43 7E 7A FA 60 A9 00 00 9D F4 17 A8 18 6B B7 24 9D E4 17 48 C8 B7 24 9D EC 17 85 25 68 85 24 A9 00 00 9D F4 17 A8 18 6B DA B7 24 29 FF 00 9D FC 17 0A 85 00 C8 98 9D F4 17 BD C4 17 A8 A6 00 BF 45 8C 81 99 80 13 BF 51 8C 81 99 A0 13 A9 09 00 99 00 13 FA BD F4 17 A8 18 6B 00 00 00 20 00 40 00 80 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 00 A9 01 00 80 0D A9 02 00 80 08 A9 03 00 80 03 A9 04 00 85 00 98 9D F4 17 BD C4 17 A8 A5 00 48 3A 0A 0A 0A 9F 11 09 00 A9 00 00 9F F1 08 00 A9 00 00 9F 01

; NEEDS WORK (rlUnknown88C4D9): its content is still raw bytes or half-converted code in comments.
      rlUnknown88C4D9 ; 88/C4D9

        .al
        .autsiz
        .databank ?

; AD 66 07      lda $0766,b
; F0 04         beq +

; 5C 1E C6 88   jml _C61E
    
              +
; AD D8 07      lda $07D8,b
; F0 18         beq +

; C9 01 00      cmp #1
; F0 1B         beq _C507

; C9 02 00      cmp #2
; F0 4A         beq _C53B

; C9 03 00      cmp #3
; F0 0D         beq ++

; C9 04 00      cmp #4
; D0 04         bne +

; 5C D2 C5 88   jml _C5D2
    
              +
; 5C 58 C6 88   jml _End
      
              +
; 5C AA C5 88 
    
              _C507
; A9 10 00 
; 8D 28 07 
; 20 4F B6 
; F0 0A 

; A9 08 00 
; 8D 26 07 
; 5C 0C C6 88 

; AD 7B 0E 
; 29 FF 00 
; 89 02 00 
; D0 07 

; 20 7D C6 
; 5C 58 C6 88 

; A9 00 00 
; 8D D8 07 
; 8D 6F 08 
; 5C 58 C6 88 
    
                _C53B
; 22 B3 C0 88 
; 9C 28 07 
; 20 1E AA 
; F0 1D 

; 22 1B BF 87 
; C9 00 00 
; D0 0A 

; A9 02 00 
; 8D 26 07 
; 5C 0C C6 88 

; A9 04 00 
; 8D 26 07 
; 5C 0C C6 88 

; AD 73 08 
; C9 FF FF 
; F0 26 

; 22 DB B4 88 
; A9 03 00 
; 8D D8 07 
; AD 68 07 
; 18 
; 6D 98 05 
; 8D 6C 07 
; AD 6A 07 
; 18 
; 6D 9A 05 
; 8D 6E 07 
; A9 01 00 
; 8D DA 07 
; 80 18 

; A9 00 00 
; 8D D8 07 
; 8D 6F 08 
; 22 7B AF 88 
; AD 79 08 
; 22 07 B3 86 
; 5C 58 C6 88 

; A9 10 00 
; 8D 28 07 
; 20 4F B6 
; F0 0D 

; A9 04 00 
; A9 08 00 
; 8D 26 07 
; 5C 0C C6 88 

; A9 18 00 
; 8D D4 07 
; A9 04 00 
; 8D D8 07 
; 5C 58 C6 88 
    
                _C5D2
; AD D4 07 
; 38 
; E9 01 00 
; 8D D4 07 
; 30 02 
; 80 79 

; A9 00 00 
; 8D D8 07 
; 8D 6F 08 
; 22 7B AF 88 
; AD 98 05 
; 8D 60 07 
; AD 9A 05 
; 8D 62 07 
; AD 71 08 
; 85 00 
; AD 73 08 
; 85 02 
; AD 79 08 
; 22 07 B3 86 
; 80 4D 

; 9C 38 07 
; A9 01 00 
; 8D 66 07 
; 9C 3A 07 
; 9C 3C 07 
; 9C 3E 07 
      
              _C61E
; AD 38 07 
; 18 
; 6D 26 07 
; 8D 38 07 
; CD 28 07 
; 90 1B 

; 38 
; ED 28 07 
; 85 00 
; AD 26 07 
; 38 
; E5 00 
; 8D 26 07 
; 9C 66 07 
; 9C 3A 07 
; 9C 3C 07 
; 9C 3E 07 
; 22 05 BC 88 
; AD D8 07 
; C9 02 00 
; D0 04         bne _End

; 22 B3 C0 88 
    
              _End
; 6B 

; NEEDS WORK (aUnknown88CBE8): its content is still raw bytes or half-converted code in comments.
      aUnknown88CBE8 ; 88/CBE8

        ; Indexed with map sprite ID

; 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E

; NEEDS WORK (aBattleMapSpriteData): its content is still raw bytes or half-converted code in comments.
      aBattleMapSpriteData ; 9E/B50D

; CB F4 AD F6 A0 AA D1 ED AD 6C 96 AA 4E EA AD C3 92 AA C6 E6 AD 26 8F AA 0B F1 AD 26 8F AA 90 F8 AD 00 9A AA D9 FB AD 2F 9D AA 00 00 D5 F6 A0 AA 01 ; Cavalier
; B1 10 D5 F6 A0 AA 01 0A D5 6C 96 AA AD 06 D5 C3 92 AA 33 03 D5 26 8F AA 0F 0D D5 26 8F AA DD 14 D5 00 9A AA 25 18 D5 2F 9D AA 75 1B D5 F6 A0 AA 01 ; LanceKnight
; CB F4 AD F6 A0 AA D1 ED AD 6C 96 AA 4E EA AD C3 92 AA C6 E6 AD 26 8F AA 0B F1 AD 26 8F AA 90 F8 AD 00 9A AA D9 FB AD 2F 9D AA 00 00 D5 F6 A0 AA 01 ; BowKnight
; B1 10 D5 F6 A0 AA 01 0A D5 6C 96 AA AD 06 D5 C3 92 AA 33 03 D5 26 8F AA 0F 0D D5 26 8F AA DD 14 D5 00 9A AA 25 18 D5 2F 9D AA 75 1B D5 F6 A0 AA 01 ; AxeKnight
; B1 10 D5 F6 A0 AA 01 0A D5 6C 96 AA AD 06 D5 C3 92 AA 33 03 D5 26 8F AA 0F 0D D5 26 8F AA DD 14 D5 00 9A AA 25 18 D5 2F 9D AA 75 1B D5 F6 A0 AA 01 ; FreeKnight
; B1 10 D5 FB 8C AC 01 0A D5 18 FF AB AD 06 D5 3D FA AB 33 03 D5 9A F5 AB 0F 0D D5 9A F5 AB DD 14 D5 BF 83 AC 25 18 D5 42 88 AC 75 1B D5 FB 8C AC 01 ; Troubadour
; CB F4 AD D6 87 A5 D1 ED AD 5A FF A4 4E EA AD 4A FC A4 C6 E6 AD 26 F9 A4 0B F1 AD 26 F9 A4 90 F8 AD 2D 82 A5 D9 FB AD DD 84 A5 00 00 D5 D6 87 A5 01 ; KnightLord
; CB F4 AD 6D F9 A2 D1 ED AD BF F0 A2 4E EA AD 85 ED A2 C6 E6 AD 71 EA A2 0B F1 AD 71 EA A2 90 F8 AD 8E F3 A2 D9 FB AD 6B F6 A2 00 00 D5 6D F9 A2 01 ; DukeKnight
; CB F4 AD 40 CE A5 D1 ED AD B8 BB A5 4E EA AD 53 B5 A5 C6 E6 AD 39 AF A5 0B F1 AD 39 AF A5 90 F8 AD D7 C1 A5 D9 FB AD E4 C7 A5 00 00 D5 40 CE A5 01 ; MasterKnight
; CB F4 AD DB B1 A7 D1 ED AD 1A A1 A7 4E EA AD 12 9B A7 C6 E6 AD 36 95 A7 0B F1 AD 36 95 A7 90 F8 AD A4 A6 A7 D9 FB AD 2D AC A7 00 00 D5 DB B1 A7 01 ; Paladin
; CB F4 AD 7B 8F A7 D1 ED AD 22 FF A6 4E EA AD 4B F9 A6 C6 E6 AD 92 F3 A6 0B F1 AD 92 F3 A6 90 F8 AD C2 84 A7 D9 FB AD F9 89 A7 00 00 D5 7B 8F A7 01 ; PaladinF
; CB F4 AD 07 D6 A0 D1 ED AD 50 CE A0 4E EA AD EA CB A0 C6 E6 AD 92 C9 A0 0B F1 AD 92 C9 A0 90 F8 AD F2 D0 A0 D9 FB AD 5A D3 A0 00 00 D5 07 D6 A0 01 ; ArchKnight
; CB F4 AD 0B B0 A4 D1 ED AD DB A7 A4 4E EA AD EB A4 A4 C6 E6 AD E9 A1 A4 0B F1 AD E9 A1 A4 90 F8 AD A5 AA A4 D9 FB AD 3B AD A4 00 00 D5 0B B0 A4 01 ; Ranger
; CB F4 AD DD EF AB D1 ED AD 15 E0 AB 4E EA AD 4A DA AB C6 E6 AD B1 D4 AB 0B F1 AD B1 D4 AB 90 F8 AD 25 E5 AB D9 FB AD 44 EA AB 00 00 D5 DD EF AB 01 ; MageKnight
; CB F4 AD 8E 8A A3 D1 ED AD 5F 82 A3 4E EA AD 6D FF A2 C6 E6 AD 7C FC A2 0B F1 AD 7C FC A2 90 F8 AD 30 85 A3 D9 FB AD C2 87 A3 00 00 D5 8E 8A A3 01 ; GreatKnight
; B8 28 D5 F4 E6 A7 F3 23 D5 E8 D9 A7 34 21 D5 BB D5 A7 E2 1E D5 86 D1 A7 30 26 D5 86 D1 A7 4C 2B D5 05 DE A7 65 2D D5 82 E2 A7 DC 2F D5 F4 E6 A7 01 ; PegasusRider
; B8 28 D5 09 CD A7 F3 23 D5 F9 BF A7 34 21 D5 BF BB A7 E2 1E D5 88 B7 A7 30 26 D5 88 B7 A7 4C 2B D5 09 C4 A7 65 2D D5 79 C8 A7 DC 2F D5 09 CD A7 01 ; PegasusKnight
; B8 28 D5 0C F5 A3 F3 23 D5 AB DE A3 34 21 D5 86 D7 A3 E2 1E D5 D9 CF A3 30 26 D5 D9 CF A3 4C 2B D5 4B E6 A3 65 2D D5 AA ED A3 DC 2F D5 0C F5 A3 01 ; FalconKnight
; B5 A7 AD 1A E5 A2 7A A3 AD 26 D7 A2 50 A1 AD 34 D3 A2 97 9F AD C0 CE A2 78 A5 AD C0 CE A2 C5 A9 AD D4 DB A2 7F AB AD FB DF A2 79 AD AD 1A E5 A2 01 ; Dragonrider
; B5 A7 AD 89 F4 A1 7A A3 AD 3B E6 A1 50 A1 AD 5B E2 A1 97 9F AD F1 DD A1 78 A5 AD F1 DD A1 C5 A9 AD 31 EB A1 7F AB AD 62 EF A1 79 AD AD 89 F4 A1 01 ; Dragonknight
; B5 A7 AD D8 AD A2 7A A3 AD 0C 9F A2 50 A1 AD 16 9B A2 97 9F AD 97 96 A2 78 A5 AD 97 96 A2 C5 A9 AD 1B A4 A2 7F AB AD 6E A8 A2 79 AD AD D8 AD A2 01 ; Dragonmaster
; 90 9A AD 09 C8 A0 11 98 AD 72 C4 A0 F4 96 AD 52 C3 A0 BD 95 AD 52 C2 A0 5A 99 AD 52 C2 A0 D2 9B AD 9B C5 A0 12 9D AD CA C6 A0 4B 9E AD 09 C8 A0 00 ; Archer
; 79 CC AD 54 ED AA CA C8 AD E1 E6 AA E8 C6 AD BC E3 AA 6D C5 AD 8C E0 AA 27 CA AD 8C E0 AA D6 CE AD 3C E8 AA 39 D0 AD 0D EA AA 33 D2 AD 54 ED AA 00 ; Myrmidon
; 79 CC AD 7B 8B AA CA C8 AD 67 84 AA E8 C6 AD 2E 81 AA 6D C5 AD 02 FE A9 27 CA AD 02 FE A9 D6 CE AD DA 85 AA 39 D0 AD D2 87 AA 33 D2 AD 7B 8B AA 00 ; Swordmaster
; 90 9A AD CC B1 AA 11 98 AD 30 AE AA F4 96 AD F9 AC AA BD 95 AD 0F AC AA 5A 99 AD 0F AC AA D2 9B AD 56 AF AA 12 9D AD 8A B0 AA 4B 9E AD CC B1 AA 00 ; Sniper
; 79 CC AD E7 9D A4 CA C8 AD F2 95 A4 E8 C6 AD 5E 92 A4 6D C5 AD D0 8E A4 27 CA AD D0 8E A4 D6 CE AD 8F 97 A4 39 D0 AD C1 99 A4 33 D2 AD E7 9D A4 00 ; Hero
; AC FB AC B9 D0 A4 05 F4 AC 2D C7 A4 29 F0 AC 97 C4 A4 8F EC AC 98 C1 A4 A3 F7 AC 98 C1 A4 EE FF AC 6F CA A4 5A 83 AD 75 CD A4 45 87 AD B9 D0 A4 00 ; General
; AC FB AC A3 AB A3 05 F4 AC 78 99 A3 29 F0 AC A2 93 A3 8F EC AC 58 8D A3 A3 F7 AC 58 8D A3 EE FF AC A1 9F A3 5A 83 AD 42 A5 A3 45 87 AD A3 AB A3 00 ; Emperor
; AC FB AC 59 F8 A0 05 F4 AC 6D E5 A0 29 F0 AC 8B DF A0 8F EC AC AB D8 A0 A3 F7 AC AB D8 A0 EE FF AC A0 EB A0 5A 83 AD 63 F1 A0 45 87 AD 59 F8 A0 00 ; Baron
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; Soldier
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; SpearSoldier
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; AxeSoldier
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; BowSoldier
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; SwordSoldier
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; LanceArmor
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; AxeArmor
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; BowArmor
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; SwordArmor
; 4F 90 AD AC AB A0 B0 8D AD 3A A4 A0 5B 8C AD 0F A2 A0 10 8B AD 53 9F A0 00 8F AD 53 9F A0 C6 91 AD F2 A6 A0 0D 93 AD 3A A9 A0 7A 94 AD AC AB A0 00 ; Barbarian
; 4F 90 AD 49 9C A0 B0 8D AD 98 94 A0 5B 8C AD 67 92 A0 10 8B AD C2 8F A0 00 8F AD C2 8F A0 C6 91 AD 61 97 A0 0D 93 AD B1 99 A0 7A 94 AD 49 9C A0 00 ; Fighter
; 4F 90 AD B9 E1 A6 B0 8D AD E9 D9 A6 5B 8C AD A8 D7 A6 10 8B AD FD D4 A6 00 8F AD FD D4 A6 C6 91 AD CB DC A6 0D 93 AD 0D DF A6 7A 94 AD B9 E1 A6 00 ; Brigand
; ED DC AD D3 A6 AC 0A D8 AD 19 9A AC EA D5 AD 48 96 AC 9B D3 AD BF 91 AC 75 DA AD BF 91 AC 86 DF AD 5E 9E AC DC E1 AD 4F A2 AC 63 E4 AD D3 A6 AC 00 ; Warrior
; ED DC AD 6B BE A4 0A D8 AD 7E B7 A4 EA D5 AD 8A B5 A4 9B D3 AD E0 B2 A4 75 DA AD E0 B2 A4 86 DF AD CD B9 A4 DC E1 AD E8 BB A4 63 E4 AD 6B BE A4 00 ; Hunter
; 4F 90 AD B0 F0 A6 B0 8D AD 36 E9 A6 5B 8C AD 17 E7 A6 10 8B AD 70 E4 A6 00 8F AD 70 E4 A6 C6 91 AD F4 EB A6 0D 93 AD 33 EE A6 7A 94 AD B0 F0 A6 00 ; Pirate
; 0C 6B D6 0D E3 A4 3A 69 D6 00 DB A4 0A 68 D6 AD D7 A4 61 67 D6 11 D4 A4 DE 69 D6 11 D4 A4 35 6C D6 21 DD A4 E1 6C D6 51 DF A4 2A 6E D6 0D E3 A4 00 ; JuniorLord
; 13 C0 AD FD B0 A6 4A BD AD BA A3 A6 C7 BB AD A0 9F A6 86 BA AD EB 9B A6 85 BE AD EB 9B A6 99 C1 AD 84 A7 A6 D4 C2 AD E5 AB A6 36 C4 AD FD B0 A6 00 ; WarMage
; 0C 6B D6 C4 9C A8 3A 69 D6 92 94 A8 0A 68 D6 1B 91 A8 61 67 D6 85 8D A8 DE 69 D6 85 8D A8 35 6C D6 CC 96 A8 E1 6C D6 F2 98 A8 2A 6E D6 C4 9C A8 00 ; Prince
; 13 C0 AD 4F B7 A8 4A BD AD AC A9 A8 C7 BB AD 52 A5 A8 86 BA AD E3 A0 A8 85 BE AD E3 A0 A8 99 C1 AD E3 AD A8 D4 C2 AD 73 B2 A8 36 C4 AD 4F B7 A8 00 ; Princess
; 13 C0 AD 12 97 A6 4A BD AD 97 8A A6 C7 BB AD 86 86 A6 86 BA AD C9 82 A6 85 BE AD C9 82 A6 99 C1 AD 87 8E A6 D4 C2 AD 93 92 A6 36 C4 AD 12 97 A6 00 ; WarMageF
; 13 C0 AD 36 CA A8 4A BD AD 6A C1 A8 C7 BB AD CA BE A8 86 BA AD 3F BC A8 85 BE AD 3F BC A8 99 C1 AD F0 C3 A8 D4 C2 AD 08 C7 A8 36 C4 AD 36 CA A8 00 ; Queen
; CB B4 AD 6A 9E A1 F1 B1 AD A1 96 A1 68 B0 AD 76 93 A1 0F AF AD 90 90 A1 35 B3 AD 90 90 A1 66 B6 AD CB 98 A1 AA B7 AD 43 9B A1 3C B9 AD 6A 9E A1 00 ; Dancer
; 13 C0 AD 76 8A A8 4A BD AD 7A 82 A8 C7 BB AD 9A FF A7 86 BA AD D3 FC A7 85 BE AD D3 FC A7 99 C1 AD F6 84 A8 D4 C2 AD 64 87 A8 36 C4 AD 76 8A A8 00 ; Priest
; 13 C0 AD ED D1 A6 4A BD AD 64 C9 A6 C7 BB AD A5 C6 A6 86 BA AD 02 C4 A6 85 BE AD 02 C4 A6 99 C1 AD 07 CC A6 D4 C2 AD D2 CE A6 36 C4 AD ED D1 A6 00 ; Mage
; 13 C0 AD 28 CD A3 4A BD AD 79 C5 A3 C7 BB AD 08 C3 A3 86 BA AD E9 C0 A3 85 BE AD E9 C0 A3 99 C1 AD D4 C7 A3 D4 C2 AD 82 CA A3 36 C4 AD 28 CD A3 00 ; FireMage
; 13 C0 AD 22 9E AB 4A BD AD 68 96 AB C7 BB AD 23 94 AB 86 BA AD 08 92 AB 85 BE AD 08 92 AB 99 C1 AD D0 98 AB D4 C2 AD 8E 9B AB 36 C4 AD 22 9E AB 00 ; ThunderMage
; 13 C0 AD 35 C6 AC 4A BD AD C3 BE AC C7 BB AD 94 BC AC 86 BA AD 7A BA AC 85 BE AD 7A BA AC 99 C1 AD 2B C1 AC D4 C2 AD A0 C3 AC 36 C4 AD 35 C6 AC 00 ; WindMage
; 13 C0 AD 1D F0 A5 4A BD AD EF E7 A5 C7 BB AD 7B E5 A5 86 BA AD 5F E3 A5 85 BE AD 5F E3 A5 99 C1 AD 5B EA A5 D4 C2 AD 72 ED A5 36 C4 AD 1D F0 A5 00 ; HighPriest
; 13 C0 AD 71 8D A1 4A BD AD 38 84 A1 C7 BB AD 93 81 A1 86 BA AD DF FE A0 85 BE AD DF FE A0 99 C1 AD 04 87 A1 D4 C2 AD 23 8A A1 36 C4 AD 71 8D A1 00 ; Bishop
; 13 C0 AD 83 EA A8 4A BD AD 25 E2 A8 C7 BB AD BE DF A8 86 BA AD 73 DD A8 85 BE AD 73 DD A8 99 C1 AD BF E4 A8 D4 C2 AD A1 E7 A8 36 C4 AD 83 EA A8 00 ; Sage
; 13 C0 AD DF B8 A0 4A BD AD 79 B2 A0 C7 BB AD 70 B0 A0 86 BA AD 8B AE A0 85 BE AD 8B AE A0 99 C1 AD 6B B4 A0 D4 C2 AD 9D B6 A0 36 C4 AD DF B8 A0 00 ; Bard
; 13 C0 AD 7B EB A9 4A BD AD 52 E4 A9 C7 BB AD 5E E2 A9 86 BA AD FE DF A9 85 BE AD FE DF A9 99 C1 AD AD E6 A9 D4 C2 AD 03 E9 A9 36 C4 AD 7B EB A9 00 ; Priestess
; 13 C0 AD 5C BF A1 4A BD AD 5A B7 A1 C7 BB AD AD B4 A1 86 BA AD 49 B2 A1 85 BE AD 49 B2 A1 99 C1 AD CF B9 A1 D4 C2 AD AB BC A1 36 C4 AD 5C BF A1 00 ; DarkMage
; 13 C0 AD 51 AF A1 4A BD AD A2 A6 A1 C7 BB AD 09 A4 A1 86 BA AD A7 A1 A1 85 BE AD A7 A1 A1 99 C1 AD F4 A8 A1 D4 C2 AD EF AB A1 36 C4 AD 51 AF A1 00 ; DarkBishop
; E2 72 D6 EF 81 AB EE 70 D6 13 FD AA C6 6F D6 AF FB AA D6 6E D6 0F FA AA DC 71 D6 0F FA AA 08 74 D6 B0 FE AA F4 74 D6 5B 80 AB 07 76 D6 EF 81 AB 00 ; Thief
; E2 72 D6 28 B2 AB EE 70 D6 5A AD AB C6 6F D6 FA AB AB D6 6E D6 5B AA AB DC 71 D6 5B AA AB 08 74 D6 EB AE AB F4 74 D6 A1 B0 AB 07 76 D6 28 B2 AB 00 ; Rogue
; CB B4 AD 63 CF AA F1 B1 AD 9F CB AA 68 B0 AD 3C CA AA 0F AF AD 0D C9 AA 35 B3 AD 0D C9 AA 66 B6 AD C7 CC AA AA B7 AD 0C CE AA 3C B9 AD 63 CF AA 00 ; Civilian
; CB B4 AD 6A BF AA F1 B1 AD 2A BC AA 68 B0 AD 27 BB AA 0F AF AD 0A BA AA 35 B3 AD 0A BA AA 66 B6 AD 3B BD AA AA B7 AD 5A BE AA 3C B9 AD 6A BF AA 00 ; Child
; 43 63 D6 AD FB A8 18 61 D6 6F F4 A8 1E 60 D6 12 F1 A8 0D 5F D6 7E ED A8 27 62 D6 25 F8 A8 44 64 D6 68 FF A8 56 65 D6 5D 83 A9 52 66 D6 80 86 A9 01 ; Ballistician
; 43 63 D6 57 98 A9 18 61 D6 58 91 A9 1E 60 D6 FB 8D A9 0D 5F D6 62 8A A9 27 62 D6 D4 94 A9 44 64 D6 0A 9C A9 56 65 D6 F7 9F A9 52 66 D6 09 A3 A9 01 ; IronBallistician
; 43 63 D6 D6 B4 A9 18 61 D6 B1 AD A9 1E 60 D6 61 AA A9 0D 5F D6 C8 A6 A9 27 62 D6 47 B1 A9 44 64 D6 69 B8 A9 56 65 D6 3E BC A9 52 66 D6 43 BF A9 01 ; KillerBallistician
; 43 63 D6 EF D0 A9 18 61 D6 7D C9 A9 1E 60 D6 50 C6 A9 0D 5F D6 D8 C2 A9 27 62 D6 2F CD A9 44 64 D6 C6 D4 A9 56 65 D6 F4 D8 A9 52 66 D6 22 DC A9 01 ; GreatBallistician
; 13 C0 AD 03 80 A6 4A BD AD 23 F8 A5 C7 BB AD 54 F5 A5 86 BA AD 28 F3 A5 85 BE AD 28 F3 A5 99 C1 AD 54 FA A5 D4 C2 AD 17 FD A5 36 C4 AD 03 80 A6 00 ; DarkPrince
; CB F4 AD 04 A9 A5 D1 ED AD 44 97 A5 4E EA AD 12 91 A5 C6 E6 AD CE 8A A5 0B F1 AD CE 8A A5 90 F8 AD 62 9D A5 D9 FB AD C9 A2 A5 00 00 D5 04 A9 A5 01 ; MasterKnightFemale
; CB F4 AD 52 CF AB D1 ED AD 33 BF AB 4E EA AD 9C B9 AB C6 E6 AD E8 B3 AB 0B F1 AD E8 B3 AB 90 F8 AD 3D C4 AB D9 FB AD B0 C9 AB 00 00 D5 52 CF AB 01 ; MageKnightFemale
; B5 A7 AD 89 C9 A2 7A A3 AD 7F BB A2 50 A1 AD B2 B7 A2 97 9F AD 60 B3 A2 78 A5 AD 60 B3 A2 C5 A9 AD 4E C0 A2 7F AB AD 69 C4 A2 79 AD AD 89 C9 A2 01 ; DragonRiderFemale
; B5 A7 AD C1 D8 A1 7A A3 AD 4B CA A1 50 A1 AD 7B C6 A1 97 9F AD 3C C2 A1 78 A5 AD 3C C2 A1 C5 A9 AD 61 CF A1 7F AB AD 9D D3 A1 79 AD AD C1 D8 A1 01 ; DragonknightFemale
; B5 A7 AD 07 91 A2 7A A3 AD 28 82 A2 50 A1 AD 4A FE A1 97 9F AD D6 F9 A1 78 A5 AD D6 F9 A1 C5 A9 AD 3F 87 A2 7F AB AD A1 8B A2 79 AD AD 07 91 A2 01 ; DragonmasterFemale
; 90 9A AD E9 C0 A0 11 98 AD 74 BD A0 F4 96 AD 63 BC A0 BD 95 AD 5A BB A0 5A 99 AD 5A BB A0 D2 9B AD AE BE A0 12 9D AD C8 BF A0 4B 9E AD E9 C0 A0 00 ; ArcherFemale
; 79 CC AD CC DC AA CA C8 AD 84 D6 AA E8 C6 AD DC D3 AA 6D C5 AD AC D0 AA 27 CA AD AC D0 AA D6 CE AD 0B D8 AA 39 D0 AD A2 D9 AA 33 D2 AD CC DC AA 00 ; MyrmidonFemale
; 79 CC AD 2A FA A9 CA C8 AD B6 F3 A9 E8 C6 AD 0C F1 A9 6D C5 AD CD ED A9 27 CA AD CD ED A9 D6 CE AD 3D F5 A9 39 D0 AD DD F6 A9 33 D2 AD 2A FA A9 00 ; SwordmasterFemale
; 90 9A AD 74 AA AA 11 98 AD BB A6 AA F4 96 AD A4 A5 AA BD 95 AD 86 A4 AA 5A 99 AD 86 A4 AA D2 9B AD F6 A7 AA 12 9D AD 2C A9 AA 4B 9E AD 74 AA AA 00 ; SniperFemale
; 79 CC AD 78 8A A4 CA C8 AD 44 83 A4 E8 C6 AD 19 80 A4 6D C5 AD 94 FC A3 27 CA AD 94 FC A3 D6 CE AD FC 84 A4 39 D0 AD EA 86 A4 33 D2 AD 78 8A A4 00 ; HeroFemale
; 13 C0 AD D7 F9 A7 4A BD AD 46 F1 A7 C7 BB AD 34 EE A7 86 BA AD 5C EB A7 85 BE AD 5C EB A7 99 C1 AD 12 F4 A7 D4 C2 AD C6 F6 A7 36 C4 AD D7 F9 A7 00 ; PriestFemale
; 13 C0 AD 84 C1 A6 4A BD AD 52 BA A6 C7 BB AD 22 B8 A6 86 BA AD D4 B5 A6 85 BE AD D4 B5 A6 99 C1 AD A0 BC A6 D4 C2 AD 0D BF A6 36 C4 AD 84 C1 A6 00 ; MageFemale
; 13 C0 AD 34 BE A3 4A BD AD A0 B6 A3 C7 BB AD 91 B4 A3 86 BA AD 6E B2 A3 85 BE AD 6E B2 A3 99 C1 AD E8 B8 A3 D4 C2 AD 9E BB A3 36 C4 AD 34 BE A3 00 ; FireMageFemale
; 13 C0 AD 6F 8F AB 4A BD AD 16 88 AB C7 BB AD F7 85 AB 86 BA AD A2 83 AB 85 BE AD A2 83 AB 99 C1 AD 5A 8A AB D4 C2 AD DD 8C AB 36 C4 AD 6F 8F AB 00 ; ThunderMageFemale
; 13 C0 AD E2 B7 AC 4A BD AD 05 B0 AC C7 BB AD 97 AD AC 86 BA AD 39 AB AC 85 BE AD 39 AB AC 99 C1 AD 6E B2 AC D4 C2 AD 0D B5 AC 36 C4 AD E2 B7 AC 00 ; WindMageFemale
; 13 C0 AD A2 E0 A5 4A BD AD FA D8 A5 C7 BB AD B3 D6 A5 86 BA AD 58 D4 A5 85 BE AD 58 D4 A5 99 C1 AD 55 DB A5 D4 C2 AD 20 DE A5 36 C4 AD A2 E0 A5 00 ; HighPriestFemale
; 13 C0 AD 64 DA A8 4A BD AD 23 D2 A8 C7 BB AD A3 CF A8 86 BA AD 61 CD A8 85 BE AD 61 CD A8 99 C1 AD 71 D4 A8 D4 C2 AD 8F D7 A8 36 C4 AD 64 DA A8 00 ; SageFemale
; E2 72 D6 46 F8 AA EE 70 D6 A2 F3 AA C6 6F D6 61 F2 AA D6 6E D6 D4 F0 AA DC 71 D6 D4 F0 AA 08 74 D6 34 F5 AA F4 74 D6 C1 F6 AA 07 76 D6 46 F8 AA 00 ; ThiefFemale
; E2 72 D6 88 A8 AB EE 70 D6 C8 A3 AB C6 6F D6 71 A2 AB D6 6E D6 DF A0 AB DC 71 D6 DF A0 AB 08 74 D6 5D A5 AB F4 74 D6 0D A7 AB 07 76 D6 88 A8 AB 00 ; RogueFemale
; CB B4 AD 97 C7 AA F1 B1 AD 46 C3 AA 68 B0 AD E1 C1 AA 0F AF AD 8F C0 AA 35 B3 AD 8F C0 AA 66 B6 AD 99 C4 AA AA B7 AD 13 C6 AA 3C B9 AD 97 C7 AA 00 ; CivilianFemale
; CB B4 AD EA B8 AA F1 B1 AD 7F B5 AA 68 B0 AD 89 B4 AA 0F AF AD 5C B3 AA 35 B3 AD 5C B3 AA 66 B6 AD 93 B6 AA AA B7 AD BF B7 AA 3C B9 AD EA B8 AA 00 ; ChildFemale
; CB F4 AD 10 F6 A4 D1 ED AD 49 ED A4 4E EA AD 2A EA A4 C6 E6 AD 05 E7 A4 0B F1 AD 05 E7 A4 90 F8 AD 3A F0 A4 D9 FB AD 13 F3 A4 00 00 D5 10 F6 A4 01 ; 

; 9E/C6FB













; E9 C0 A3 - fire mage 
; $A3C0E9
