; AI groups: group leaders, leadership power, and moving members into formation
; around their target.

    .section AIGroupSection

      .al
      .xl

      rlTryGetAIFactionGroupLeader ; 87/D953

        .al
        .autsiz
        .databank ?

        ; If there is no group leader, get the first AIUnit instead

        phb
        php
        phk
        plb
        phx

        lda wAIGroupLeaderDeploymentOffset
        bmi +

        and #$00FF
        tax
        lda aDeploymentTable._UnitRAMPointer,x
        bra ++

        +
        lda aAIUnitList[0].UnitRAMPointer

        +
        sta wSelectedUnitDataRAMPointer,b

        plx
        plp
        plb
        rtl

        .databank 0

      rlTryGetGroupLeaderCoordinates ; 87/D973

        .al
        .autsiz
        .databank ?

        ; Output:
        ; X in wAITemp000E96
        ; Y in wAITemp000E98

        phb
        php
        phk
        plb
        phx

        lda wAIUnitCounter
        beq _End

          lda wAIGroupLeaderDeploymentOffset
          tax
          bpl +

            lda aAIUnitList[0].DeploymentOffset
            and #$00FF
            tax

          +
          lda aDeploymentTable._XTilePosition,x
          sta wAITemp000E96,b
          lda aDeploymentTable._YTilePosition,x
          sta wAITemp000E98,b

          lda aDeploymentTable._State,x
          bit #DeploymentStateGuardingCastle
          beq _End

            ; Is guarding
            inc wAITemp000E98,b
            inc wAITemp000E98,b

            lda wAIUnknownBitfield7E2000
            ora #$0010
            sta wAIUnknownBitfield7E2000

        _End
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetFactionGroupDataGroupAIScript ; 87/D9B9

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = AI setting

        ; Output:
        ; lAITemp000E90 = selected groups AI script pointer

        phb
        php
        phk
        plb
        phx
        phy

        dec a
        bmi +

          sta wAITemp000E96,b
          asl a
          clc
          adc wAITemp000E96,b
          sta wAITemp000E96,b

          lda wAIActiveFaction,b
          jsl rlGetFactionSlotOffsetWrapper
          bcs +

            lda $7E0000 + structFactionHeader.GroupID,x
            and #$00FF
            jsl rlGetFactionGroupPointerByID

            lda structFactionGroupData.GroupAIPointers,b,y
            beq +

              clc
              adc wAITemp000E96,b
              tay
              lda $0000,b,y
              sta lAITemp000E90,b
              lda $0001,b,y
              sta lAITemp000E90+1,b

              -
              ply
              plx
              plp
              plb
              rtl

        +
        lda #0
        sta lAITemp000E90+1,b
        lda #0
        sta lAITemp000E90,b
        bra -

        .databank 0

      rlUnknown87DA0A ; 87/DA0A

        .al
        .autsiz
        .databank ?

        lda wAIUnknownBitfield7E2000
        ora #$0001
        sta wAIUnknownBitfield7E2000
        rtl

        .databank 0

      rlGetAIGroupsLeadershipPower ; 87/DA16

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        ldx wSelectedUnitDataRAMPointer,b
        phx

        lda wAIUnitCounter
        beq _End

          lda wAIGroupLeaderDeploymentOffset
          bpl +

            lda #0
            bra ++

          +
          tax
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitLeadershipStars

          +
          tax
          lda aLeadershipPowerLookupTable,x
          and #$00FF

        _End
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        rtl

        .databank 0

      aLeadershipPowerLookupTable ; 87/DA4C

        .byte 50
        .byte 60
        .byte 70
        .byte 80
        .byte 90
        .byte 100

      rlSetTargetPositionForAIGroupMembers ; 87/DA52

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
        phy

        lda @l wAIUnitCounter
        beq _End

          sta wAITemp000E9A,b

          lda @l wAIFormationDirection
          asl a
          tax
          lda aFormationDirectionRoutines,x
          sta lAITemp000E90,b

          lda @l wAIFormationType
          asl a
          tax
          lda aFormationPatternOffsets,x
          sta wAITemp000E9C,b

          ldy #<>aAIUnitList[0]

          _Loop
          lda structAIUnitEntry.DeploymentOffset,b,y
          and #$00FF
          tax
          jsr rsSetTargetPositionIfGuarding
          bcs _Next

            ; Unit is not guarding a castle

            jsl rlGetFormationIDByDeploymentOffset
            asl a
            clc
            adc wAITemp000E9C,b
            tax
            jsr rsRunFormationDirectionRoutine

          _Next
          tya
          clc
          adc #size(structAIUnitEntry)
          tay
          dec wAITemp000E9A,b
          bne _Loop
        
        _End
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rsRunFormationDirectionRoutine ; 87/DAAD

        .al
        .autsiz
        .databank ?

        jmp (lAITemp000E90)

        .databank 0

      aFormationDirectionRoutines ; 87/DAB0

        .word <>rsSetCoordinateFormationUp
        .word <>rsSetCoordinateFormationRight
        .word <>rsSetCoordinateFormationDown
        .word <>rsSetCoordinateFormationLeft

      rsSetCoordinateFormationUp ; 87/DAB8

        .al
        .autsiz
        .databank $7E

        sep #$20
        lda wAIUnknown7E2010
        clc
        adc aFormationPatternOffsets,x
        sta structAIUnitEntry.XTargetPosition,b,y

        lda wAIUnknown7E2012
        clc
        adc aFormationPatternOffsets+1,x
        sta structAIUnitEntry.YTargetPosition,b,y
        rep #$20
        rts

        .databank 0

      rsSetCoordinateFormationRight ; 87/DAD3

        .al
        .autsiz
        .databank $7E

        sep #$20
        lda wAIUnknown7E2010
        sec
        sbc aFormationPatternOffsets+1,x
        sta structAIUnitEntry.XTargetPosition,b,y

        lda wAIUnknown7E2012
        clc
        adc aFormationPatternOffsets,x
        sta structAIUnitEntry.YTargetPosition,b,y
        rep #$20
        rts

        .databank 0

      rsSetCoordinateFormationDown ; 87/DAEE

        .al
        .autsiz
        .databank $7E

        sep #$20
        lda wAIUnknown7E2010
        sec
        sbc aFormationPatternOffsets,x
        sta structAIUnitEntry.XTargetPosition,b,y

        lda wAIUnknown7E2012
        sec
        sbc aFormationPatternOffsets+1,x
        sta structAIUnitEntry.YTargetPosition,b,y
        rep #$20
        rts

        .databank 0

      rsSetCoordinateFormationLeft ; 87/DB09

        .al
        .autsiz
        .databank $7E

        sep #$20
        lda wAIUnknown7E2010
        clc
        adc aFormationPatternOffsets+1,x
        sta structAIUnitEntry.XTargetPosition,b,y

        lda wAIUnknown7E2012
        sec
        sbc aFormationPatternOffsets,x
        sta structAIUnitEntry.YTargetPosition,b,y
        rep #$20
        rts

        .databank 0

      rsSetTargetPositionIfGuarding ; 87/DB24

        .al
        .autsiz
        .databank ?

        ; X = deployment offset

        lda aDeploymentTable._State,x
        bit #DeploymentStateGuardingCastle
        beq +

          lda structAIUnitEntry.XPosition,b,y
          sta structAIUnitEntry.XTargetPosition,b,y
          sec
          rts

        +
        clc
        rts

        .databank 0

      rlUnknown87DB37 ; 87/DB37

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
        phy

        lda @l wAIUnitCounter
        sta wAITemp000E96,b

        lda wAICurrentAISetting,b
        ldx #<>aAIUnitList[0]

          -
          sep #$20
          lda structAIUnitEntry.XPosition,b,x
          sta structAIUnitEntry.XTargetPosition,b,x
          lda structAIUnitEntry.YPosition,b,x
          sta structAIUnitEntry.YTargetPosition,b,x
          rep #$20
          txa
          clc
          adc #size(structAIUnitEntry)
          tax
          dec wAITemp000E96,b
          bne -

        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown87DB70 ; 87/DB70

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

        lda wAIFormationType
        beq _End

          cmp #13
          beq _End

            lda wAIUnknown7E2010
            sec
            sbc wAIGroupLeaderXPosition
            bpl +

              eor #$FFFF
              inc a
              ldx #3
              bra ++
              
              +
              ldx #1

            +
            sta wAITemp000E9A,b
            stx wAITemp000E9E,b

            lda wAIUnknown7E2012
            sec
            sbc wAIGroupLeaderYPosition
            bpl +

              eor #$FFFF
              inc a
              ldx #0
              bra ++
              
              +
              ldx #2
            
            +
            sta wAITemp000E9C,b
            stx wAITemp000EA0,b

            lda wAITemp000E9A,b
            cmp wAITemp000E9C,b
            beq _End
            bcc +

              lda wAITemp000E9E,b
              bra ++

            +
            lda wAITemp000EA0,b

            +
            sta wAIFormationDirection
        
        _End
        plp
        plb
        rtl

        .databank 0

      rlUnknown87DBD2 ; 87/DBD2

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
        phy

        lda wAIFormationDirection
        asl a
        tax
        lda $87DC74,x
        sta lAITemp000E90,b

        lda wAIFormationType
        beq _SEC

        asl a
        tax
        lda aFormationPatternOffsets,x
        sta $0EA2,b

        lda wAIUnitCounter
        sta $0E9A,b
        stz $0E9C,b
        cmp #1
        beq _CLC

        ldy #<>aAIUnitList[0]
        
        _Loop
        lda structAIUnitEntry.DeploymentOffset,b,y
        and #$00FF
        tax
        jsl rlGetFormationIDByDeploymentOffset
        asl a
        clc
        adc $0EA2,b
        tax
        sep #$20
        jsr $87DC71

        lda $0E9E,b
        cmp structAIUnitEntry.XPosition,b,y
        bne +

          lda $0EA0,b
          cmp structAIUnitEntry.YPosition,b,y
          bne +

            inc $0E9C,b

        +
        rep #$20
        tya
        clc
        adc #size(structAIUnitEntry)
        tay
        dec $0E9A,b
        bne _Loop

        lda $0E9C,b
        cmp wAIUnitCounter
        beq _SEC

        lda #$0002
        tsb wAIUnknownBitfield7E2000

        lda $0E9C,b
        and #$00FF
        xba
        sta $50
        lda wAIUnitCounter
        sta $52
        jsl rlUnsignedDivide16By16
        lda $50
        
        _CLC
        ply
        plx
        plp
        plb
        clc
        
        -
        rtl
        
        _SEC
        lda #$0100
        ply
        plx
        plp
        plb
        sec
        bra -

        .databank 0

        ; 87/DC71

    .endsection AIGroupSection
