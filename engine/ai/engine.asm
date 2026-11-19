; The AI engine: the cycle it steps through each frame for the active faction, and
; the clever-mode flag.

    .section AIEngineCycleSection

      .al
      .xl

      rlUnknown869D1B ; 86/9D1B

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda #$0020
        tsb bUnknown000E7B,b

        lda $0302,b
        cmp #18
        bne +

          lda $0304,b
          cmp #5
          beq +

            cmp #3
            beq +

              lda wUnknown00171A,b
              bne +

                lda wUnknown000D79,b
                bit #$0080
                bne +

                  lda bUnknown000E7B,b
                  bit #$0080
                  bne +

                    bit #$0040
                    beq +

                      lda wAIEngineCycleType,b
                      asl a
                      tax
                      jsr (aAIEngineCycleRoutines,x)

        +
        lda #($0010 | $0020)
        trb bUnknown000E7B,b

        plp
        plb
        rtl

        .databank 0

      aAIEngineCycleRoutines ; 86/9D65

        .word <>rsAIEngineSetupCycle
        .word <>rsAIEngineTargetListCycle
        .word <>rsAIEngineCycle2 ; build ally list
        .word <>rsAIEngineCycle3 ; builds distance map to target tile
        .word <>rsAIEngineCycle4 ; sets destination tile of all allies with same AI?
        .word <>rsAIEngineCycle5 ; gets best move tile?
        .word <>rsAIEngineCycle6 ; waits for movement to finish
        .word <>rsAIEngineNextCycle

      rsAIEngineSetupCycle ; 86/9D75

        .al
        .autsiz
        .databank ?

        lda wActiveFactionSlot,b
        sta wAIActiveFaction,b
        lda #1
        sta wAICurrentAISetting,b

        inc wAIEngineCycleType,b
        rts

        .databank 0

      rsAIEngineTargetListCycle ; 86/9D85

        .al
        .autsiz
        .databank ?

        lda #$0010
        tsb bUnknown000E7B,b

        jsl rlBuildAITargetList

        inc wAIEngineCycleType,b
        rts

        .databank 0

      rsAIEngineCycle2 ; 86/9D93

        .al
        .autsiz
        .databank ?

        lda #$0010
        tsb bUnknown000E7B,b

        jsl rlFillAllyUnitMap
        jsl rlFillFoeUnitMap

        ; This loop builds unit lists out of matching group AIs and runs their
        ; AI scripts, set in the chapter event data.

        _Loop
        lda #0
        sta wAICurrentAIUnitCounter,b
        sta wAISelectedAIUnitOffset,b
        sta wAIUnknownBitfield7E2000
        sta wAIUnknown7E2002

        lda wAICurrentAISetting,b
        jsl rlBuildAIUnitList

        lda wAIUnitCounter
        beq +

          lda wAICurrentAISetting,b
          jsl rlGetFactionGroupDataGroupAIScript

          lda lAITemp000E90,b
          ora lAITemp000E90+1,b
          beq +

            jsl rlAICheckIfAnyFoeInAlliesThreatRange
            jsl rlRunAIScript

            lda wAIUnknown7E201A
            bne ++

        +
        inc wAICurrentAISetting,b

        lda wAICurrentAISetting,b
        cmp #9
        bcc _Loop
        bra ++

        +
        inc wAIEngineCycleType,b
        rts

        +
        lda #$0020
        tsb $0D87,b

        lda #7
        sta wAIEngineCycleType,b
        rts

        .databank 0

      rsAIEngineCycle3 ; 86/9DFA

        .al
        .autsiz
        .databank ?

        lda #$0010
        tsb bUnknown000E7B,b

        ; If any target is within threat range:
        ; Either update wAIUnknown7E2002 with 2 if its 1, or leave it be.

        jsl rlUnknown86AF39

        jsl rlUnknown86B018

        inc wAIEngineCycleType,b
        rts

        .databank 0

      rsAIEngineCycle4 ; 86/9E0C

        .al
        .autsiz
        .databank ?

        lda #$0010
        tsb bUnknown000E7B,b

        lda $086F,b
        bne _End

          lda #$0002
          trb bUnknown000E7B,b

          lda wAIUnknownBitfield7E2000
          bit #$0001
          bne +

            jsl rlUnknown87DB37
            bra _9E3F
          
          +
          lda wAIUnknown7E201A
          cmp #6
          bne +

            jsl rlUnknown87DBD2
            bcs _9E49
          
          +
          jsl rlSetTargetPositionForAIGroupMembers

          _9E3F
          lda #$0080
          tsb wUnknown000D79,b

          inc wAIEngineCycleType,b

        _End
        rts

        _9E49
        jsr rsUnknown869F2A
        bra _End

        .databank 0

      rsAIEngineCycle5 ; 86/9E4E

        .al
        .autsiz
        .databank ?

        php

        lda #$0010
        tsb bUnknown000E7B,b

        jsl rlCheckIfAIUnitCanAct
        bcs +

          jsl rlFillAllyUnitMap
          jsl rlFillFoeUnitMap
          jsl rlUnknown86B129

        +
        inc wAIEngineCycleType,b
        plp 
        rts

        .databank 0

      rsAIEngineCycle6 ; 86/9E6C

        .al
        .autsiz
        .databank ?

        lda $086F,b
        bne _End

          jsr rsUnknown869EC9
          bcs _End

            jsl rlCheckIfAIUnitCanAct
            bcs +

              jsl rlGetSelectedUnitStates
              bit #UnitStateCanto
              bne _9EBD

            +
            lda wAIUnknownBitfield7E2000
            bit #$0040
            beq +

              ; group leader is fielded
              and #~$40
              sta wAIUnknownBitfield7E2000
              lda #0
              sta wAICurrentAIUnitCounter,b
              sta wAISelectedAIUnitOffset,b
              bra ++

            +
            lda wAICurrentAIUnitCounter,b
            inc a
            cmp wAIUnitCounter
            bcs _9EC4

            lda wAISelectedAIUnitOffset,b
            clc
            adc #size(structAIUnitEntry)
            sta wAISelectedAIUnitOffset,b

            inc wAICurrentAIUnitCounter,b

            +
            lda #$0080
            tsb wUnknown000D79,b

            _9EBD
            lda #5
            sta wAIEngineCycleType,b
        
        _End
        rts
        
        _9EC4
        jsr rsUnknown869F2A
        bra _End

        .databank 0

      rsUnknown869EC9 ; 86/9EC9

        .al
        .autsiz
        .databank ?

        lda wAIUnknown000E8E,b
        cmp #2
        bne _CLC

          lda $0580,b
          beq _CLC

            sta $0590,b
            jsl rlCheckIfCastleGuarded
            bcs _CLC

              jsl rlGetEventLocationEntryEffectiveXCoordinate
              sta $0E88,b
              asl a
              asl a
              asl a
              asl a
              sta $0875,b

              jsl rlGetEventLocationEntryEffectiveYCoordinate
              sta $0E8A,b
              asl a
              asl a
              asl a
              asl a
              sta $0877,b

              ldx wAISelectedAIUnitOffset,b
              lda aAIUnitList[0].DeploymentOffset,x
              and #$00FF
              sta $0871,b
              lda #4
              sta $0E8E,b
              sta $0879,b
              lda #$FFFF
              sta $0E8C,b
              sta $0873,b
              lda #$FFFF
              sta $086F,b
              lda #$0001
              tsb bUnknown000E7B,b
              sec
              rts
        
        _CLC
        clc
        rts

        .databank 0

      rsUnknown869F2A ; 86/9F2A

        .al
        .autsiz
        .databank ?

        inc wAICurrentAISetting,b

        lda #2
        sta $0E7C,b
        rts

        .databank 0

      rsAIEngineNextCycle ; 86/9F34

        .al
        .autsiz
        .databank ?

        rts

        .databank 0

    .endsection AIEngineCycleSection


    .section AICleverModeSection

      .al
      .xl

      rlGetCleverModeFlag ; 87/C003

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda wOptionSettings,b
        and #$1000
        xba 
        lsr a
        lsr a
        lsr a
        lsr a
        plp
        plb
        rtl

        .databank 0

        ; 87/C015

    .endsection AICleverModeSection
