; Threat ranges: whether any foe can reach a unit's allies, and how far a unit
; can attack.

    .section AIThreatSection

      .al
      .xl

      rlUnknown86AF39 ; 86/AF39

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`wAIUnknownBitfield7E2000
        pha
        rep #$20
        plb
        .databank `wAIUnknownBitfield7E2000

        lda @l wAIUnknownBitfield7E2000
        bit #$0004
        beq +

          lda wAIUnknown7E2002
          asl a
          tax
          jsr (aUnknown86AF57,x)

        +
        plp
        plb
        rtl

        .databank 0

      aUnknown86AF57 ; 86/AF57

        .word <>rsUnknown86AF69
        .word <>rsUnknown86AF6A
        .word <>rsUnknown86AF69
        .word <>rsUnknown86AF69
        .word <>rsUnknown86AF69
        .word <>rsUnknown86AF69
        .word <>rsUnknown86AF69
        .word <>rsUnknown86AF69
        .word <>rsUnknown86AF69

      rsUnknown86AF69 ; 86/AF69

        .al
        .autsiz
        .databank ?

        rts

        .databank 0

      rsUnknown86AF6A ; 86/AF6A

        .al
        .autsiz
        .databank $7E

        lda #2
        sta wAIUnknown7E2002
        rts

        .databank 0

      rlAICheckIfAnyFoeInAlliesThreatRange ; 86/AF71

        .al
        .autsiz
        .databank ?

        phb
        php

        sep #$20
        lda #`wAIUnknownBitfield7E2000
        pha
        rep #$20
        plb
        .databank `wAIUnknownBitfield7E2000

        phx
        phy

        lda wAITargetCounter
        bne +

          jml _End

        +
        sta wAITemp000E9A,b

        ldx #<>aAITargetList[0]

          ; Outer loop goes over all targets, inner loop over all allies

          _OuterLoop
          phx
          lda structAITargetEntry.DeploymentOffset,b,x
          and #$00FF
          tax
          lda aDeploymentTable._State,x
          plx

          bit #(DeploymentStateDefeated | DeploymentStateHidden)
          bne _Next

            lda structAITargetEntry.XPosition,b,x
            and #$00FF
            sta wAITemp000E96,b
            lda structAITargetEntry.YPosition,b,x
            and #$00FF
            sta wAITemp000E98,b

            lda wAIUnitCounter
            bne +

              jml _End
            
            +
            sta wAITemp000E9C,b

            ldy #<>aAIUnitList[0]

              _InnerLoop
              lda structAIUnitEntry.XPosition,b,y
              and #$00FF
              sec
              sbc wAITemp000E96,b
              bpl +

                eor #$FFFF
                inc a

              +
              sta wR35

              lda structAIUnitEntry.YPosition,b,y
              and #$00FF
              sec
              sbc wAITemp000E98,b
              bpl +

                eor #$FFFF
                inc a

              +
              clc
              adc wR35
              sta wR35

              ; wR35 holds distance to target

              lda structAIUnitEntry.ThreatRange,b,y
              and #$00FF
              cmp wR35
              bcs _SEC

              tya
              clc
              adc #size(structAIUnitEntry)
              tay
              dec wAITemp000E9C,b
              bne _InnerLoop

          _Next
          txa
          clc
          adc #size(structAITargetEntry)
          tax
          dec wAITemp000E9A,b
          bne _OuterLoop
        
        _End
        ply
        plx
        plp
        plb
        clc

        -
        rtl

        _SEC
        lda #$0004
        tsb wAIUnknownBitfield7E2000

        ply
        plx
        plp
        plb
        sec
        bra -

        .databank 0

      rlUnknown86B018 ; 86/B018

        .al
        .autsiz
        .databank ?

        ; Builds target distance map around group leader

        phb
        php

        sep #$20
        lda #`wAIUnknownBitfield7E2000
        pha
        rep #$20
        plb
        .databank `wAIUnknownBitfield7E2000

        phx
        lda wAIUnknownBitfield7E2000
        bit #$0020
        bne +

          jml _End

        +
        lda wAIUnknown7E201A
        bne +

          jml _End

        +
        jsl rlTryGetAIFactionGroupLeader

        lda wAIGroupLeaderXPosition
        sta wAIUnknown7E2010
        sta wAITemp000E96,b

        lda wAIGroupLeaderYPosition
        sta wAIUnknown7E2012
        sta wAITemp000E98,b

        jsl rlFillMovementCostMapSpecial

        jsl rlGetNearestPossibleTarget
        bcs +

          jml _End

        +
        sta wAIUnknown7E2018

        ; Get the targets coords
        lda wAITemp000E9A,b
        sta wAIUnknown7E2014
        lda wAITemp000E9C,b
        sta wAIUnknown7E2016

        lda wAIUnknown7E201A
        cmp #6
        bne +

          lda wAIUnknown7E2002
          cmp #4
          beq _B0A6

            jml _End

        +
        lda wAIUnknownBitfield7E2000
        bit #$0008
        bne _B0B6

        ; Group leader isnt dead
        bit #$0110
        bne _B0A6

        lda wAIGroupLeaderDeploymentOffset
        bpl _B0B6

        lda wAIUnknown7E2002
        cmp #4
        bne +

          jml _End

        +
        cmp #5
        bne _B0A6

          jml _End

        ; Write target coords to other ram values
        _B0A6
        lda wAIUnknown7E2014
        sta wAIUnknown7E2010
        lda wAIUnknown7E2016
        sta wAIUnknown7E2012
        jml +

          _B0B6
          lda @l wAIGroupLeaderFieldMovement
          sta wAITemp000EA2,b
          jsl rlTryGetAIFactionGroupLeader
          jsl rlFillMovementMap
          jsl rlUnknown86AD5E

          lda wAITemp000E96,b
          sta wAIUnknown7E2010
          lda wAITemp000E98,b
          sta wAIUnknown7E2012

        +
        jsl rlUnknown87DB70

        lda wAICurrentAISetting,b
        jsl rlUnknown87DA0A

        _End
        plx
        plp
        plb
        rtl

        .databank 0

      rlGetSelectedUnitAttackThreatRange ; 86/B0E4

        .al
        .autsiz
        .databank ?

        phx
        jsl rlGetHighestRangeItemInInventory

        lda wCurrentItemDataROMPointer,b
        beq +

          jsl rlGetItemMaximumRange
          bra ++

          +
          lda #0

        +
        sta wAITemp000EA4,b

        lda $7E2002
        cmp #5
        bne +

          lda wAITemp000EA4,b
          bra _END

        +
        jsl rlGetSelectedUnitTotalMovement
        inc a
        tax
        lda _MovementThreatRangeLookupTable,x
        and #$00FF
        clc
        adc wAITemp000EA4,b
        
        _END
        plx
        rtl

        .databank 0

        _MovementThreatRangeLookupTable ; 86/B11B

        ; Approximation of (Move * 10 [-1]) * 256/179)/10
        ; Leaving out the -1 part

        .byte ceil(( 0 * 10) * 256.0/179.0/10) ; =  0
        .byte ceil(( 1 * 10) * 256.0/179.0/10) ; =  2
        .byte ceil(( 2 * 10) * 256.0/179.0/10) ; =  3
        .byte ceil(( 3 * 10) * 256.0/179.0/10) ; =  5
        .byte ceil(( 4 * 10) * 256.0/179.0/10) ; =  6
        .byte ceil(( 5 * 10) * 256.0/179.0/10) ; =  8
        .byte ceil(( 6 * 10) * 256.0/179.0/10) ; =  9
        .byte ceil(( 7 * 10) * 256.0/179.0/10) ; = 11
        .byte ceil(( 8 * 10) * 256.0/179.0/10) ; = 12
        .byte ceil(( 9 * 10) * 256.0/179.0/10) ; = 13
        .byte ceil((10 * 10) * 256.0/179.0/10) ; = 15
        .byte ceil((11 * 10) * 256.0/179.0/10) ; = 16
        .byte ceil((12 * 10) * 256.0/179.0/10) ; = 18
        .byte ceil((13 * 10) * 256.0/179.0/10) ; = 19

      rlUnknown86B129 ; 86/B129

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        jsr rsUnknown86B200

        ldx wAISelectedAIUnitOffset,b
        lda aAIUnitList[0].UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b

        lda aAIUnitList[0].XPosition,x
        and #$00FF
        sta wAITemp000E96,b

        lda aAIUnitList[0].YPosition,x
        and #$00FF
        sta wAITemp000E98,b

        jsl rlGetSelectedUnitAI
        cmp wAICurrentAISetting,b
        beq +

          jml _End

        +
        lda aAIUnitList[0].XTargetPosition,x
        and #$00FF
        sta wAITargetXPosition,b

        lda aAIUnitList[0].YTargetPosition,x
        and #$00FF
        sta wAITargetYPosition,b

        lda #0
        sta wAIUnknown000E8E,b
        lda #$FFFF
        sta wAIUnknown000E8C,b

        ; Fill movement map
        jsl rlUnknown86C1F5

        lda aAIUnitList[0].DeploymentOffset,x
        and #$00FF
        tax
        sta aAIAction.wUntDeploymentOffset
        lda #$FFFF
        sta aAIAction.wUnknown7F4440

        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        bne +

          jsr rsUnknown86BD9D
          bcc +

            jml _End

        +
        jsl rlGetSelectedUnitStatus
        cmp #StatusBerserk
        beq _Berserked

          jsr rsCheckIfCastlesCapturable
          bcs _B1E0

            lda aDeploymentTable._State,x
            bit #DeploymentStateGuardingCastle
            beq +

              jsr rsUnknown86BA86
              bra ++

            +
            lda wAIUnknown7E201A
            asl a
            tax
            jsr (aUnknown86B1E6,x)
            bcs _B1E0

            +
            lda aAIAction.wUnknown7F4440
            cmp #$FFFF
            bne _B1E0

        _Berserked
        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        bne _B1E0

          jsr rsUnknown86B480

        _B1E0
        jsr rsUnknown86B221
        
        _End
        plp
        plb
        rtl

        .databank 0

      aUnknown86B1E6 ; 86/B1E6

        .word <>rsUnknown86B7D1
        .word <>rsUnknown86B7D1
        .word <>rsUnknown86B9E8
        .word <>rsCheckAnyFoeInGroupRangeFlagUnset
        .word <>rsCheckAnyFoeInGroupRangeFlagUnset
        .word <>rsCheckAnyFoeInGroupRangeFlagUnset
        .word <>rsUnknown86BA86
        .word <>rsUnknown86B7D1
        .word <>rsUnknown86BB38
        .word <>rsUnknown86BCE3
        .word <>rsUnknown86BD37
        .word <>rsUnknown86BD5A
        .word <>rsUnknown86BD8B

      rsUnknown86B200 ; 86/B200

        .al
        .autsiz
        .databank ?

        lda wAIUnknown7E2002
        cmp #4
        beq +

          cmp #5
          beq +

            ldx wAISelectedAIUnitOffset,b
            lda aAIUnitList[0].DeploymentOffset,x
            and #$00FF
            sta aAIAction.wDestinationYPosition
            jsl rlFillRangeMapOfAITargetsNearLeader

        +
        rts

        .databank 0

      rsUnknown86B221 ; 86/B221

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        ldx wAISelectedAIUnitOffset,b
        lda #0
        sta $0879,b
        lda #$FFFF
        sta $0873,b
        lda aAIUnitList[0].XPosition,x
        and #$00FF
        cmp wAITargetXPosition,b
        bne _B270

          lda aAIUnitList[0].YPosition,x
          and #$00FF
          cmp wAITargetYPosition,b
          bne _B270

            lda wAIUnknown000E8E,b
            bne _B270
            
              -
              jsl rlGetSelectedUnitStates
              bit #UnitStateCanto
              bne +

                jml _End

              +
              phx
              lda aAIUnitList[0].DeploymentOffset,x
              and #$00FF
              tax
              jsl rlUnknown84CAA9
              plx
              jml _End

        _B270
        lda aAIUnitList[0].XPosition,x
        and #$00FF
        sta wAITemp000E96,b
        lda aAIUnitList[0].YPosition,x
        and #$00FF
        sta wAITemp000E98,b

        lda wAITargetXPosition,b
        sta wAITemp000E9A,b
        lda wAITargetYPosition,b
        sta wAITemp000E9C,b
        jsl rlUnknown86BDE8
        bcc +

          lda wAIUnknown7E2014
          sta wAITemp000E9A,b
          lda wAIUnknown7E2016
          sta wAITemp000E9C,b
          jsl rlUnknown86BDE8
          bcs -

        +
        lda wAITemp000E9E,b
        cmp wAITemp000E9A,b
        bne +

          lda wAITemp000EA0,b
          cmp wAITemp000E9C,b
          bne +

            lda wAIUnknown000E8E,b
            sta $0879,b
            lda wAIUnknown000E8C,b
            bmi +

              sta $0873,b

        ; Update units position with the post movement positions
        +
        sep #$20
        lda wAITemp000E9E,b
        sta aAIUnitList[0].XPosition,x
        lda wAITemp000EA0,b
        sta aAIUnitList[0].YPosition,x
        rep #$20

        lda wAITemp000E9E,b
        asl a
        asl a
        asl a
        asl a
        sta $0875,b
        lda wAITemp000EA0,b
        asl a
        asl a
        asl a
        asl a
        sta $0877,b

        lda aAIUnitList[0].DeploymentOffset,x
        and #$00FF
        sta $0871,b
        lda #$FFFF
        sta $086F,b

        lda #$0001
        tsb bUnknown000E7B,b

        _End
        plp
        plb
        rts

        .databank 0

      rlUnknown86B307 ; 86/B307

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        asl a
        tax
        jsr (_B315,x)

        plx
        plp
        plb
        rtl

        .databank 0

        _B315
        .word $B335
        .word $B343
        .word $B358
        .word $B371
        .word $B39D
        .word $B38F
        .word $B3AB
        .word $B3B9
        .word $B343
        .word $B36A
        .word $B3C7
        .word $B3CE
        .word $B3DD
        .word $B410
        .word $B343
        .word $B343

        ; 86/B335

    .endsection AIThreatSection
