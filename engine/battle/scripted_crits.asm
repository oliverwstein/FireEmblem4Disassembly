; Special attacks that the game scripts for particular pairs and groups of units:
; sibling crits, lover crits and triangle attacks (types 1-3; type 2 loads heart
; sprites in map battles, aMapBattleScriptedCritSprites). Also reads the battle
; animation option.

    .section ScriptedCritsSection

      .al
      .xl

      rlActionStructGetScriptedCritPossibility ; 87/BB50

        .al
        .autsiz
        .databank ?

        ; Out:
        ; 1 = sibling crit
        ; 2 = lover crit
        ; 3 = triangle attack

        phb
        php
        phk
        plb
        phx
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wR10
        pha
        lda wR11
        pha

        ldx wR10
        lda aDeploymentTable._XTilePosition,x
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        sta wR11

        lda #(`$7F654A)<<8
        sta lRoutineVariable+1,b
        lda #<>$7F654A
        sta lRoutineVariable,b
        jsl rlBuild32x32MapUnitGrid

        pla
        sta wR11
        pla
        sta wR10

        lda wR10
        sta wR0
        lda wR11
        sta wR1

        jsl rlGetUnitsDistance
        sta $1A

        ldx wR10
        lda aDeploymentTable._XTilePosition,x
        sta wR0
        lda aDeploymentTable._YTilePosition,x
        sta wR1

        ldx wR11
        lda aDeploymentTable._XTilePosition,x
        sec
        sbc wR0
        clc
        adc #16
        sta wR0
        lda aDeploymentTable._YTilePosition,x
        sec
        sbc wR1
        clc
        adc #16
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc wR0
        tax

        lda $7F652A,x
        and #$00FF
        sta wR2
        lda $7F6549,x
        and #$00FF
        sta wR3
        lda $7F656A,x
        and #$00FF
        sta wR4
        lda $7F654B,x
        and #$00FF
        sta wR5
        lda $7F673A
        and #$00FF
        sta wR6
        lda $7F6759
        and #$00FF
        sta wR7
        lda $7F677A
        and #$00FF
        sta wR8
        lda $7F675B
        and #$00FF
        sta wR9

        ldx wR10
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b

        ldy #$000E
        
        -
        lda $0004,b,y
        cmp #$00FF
        beq ++

        cmp wR10
        beq +

        jsl rlCheckIfTargetBelongsToOwnFaction
        bcs ++
        
        +
        lda #$00FF
        sta $0004,b,y
        
        +
        dec y
        dec y
        bpl -

        lda wR13
        cmp #2
        bcs +

        jsr rsActionStructCheckForTriangleAttack
        lda #3
        bcs _End

        ; lover crit?
        +
        jsr rsActionStructCheckForLoverCrit
        lda #2
        bcs _End

        jsr rsActionStructCheckForSiblingCrit
        lda #1
        bcs _End

        lda #0

        _End
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        rtl

        .databank 0

      rsActionStructCheckForLoverCrit ; 87/BC5C

        .al
        .autsiz
        .databank ?

        ; Checks if the unit's lover is adjacent and populates aAIAction targets for a lover crit.

        phx
        phy
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wR0
        phx

        jsl rlGetSelectedUnitLoverGenerationID
        ora #0
        beq _CLC

          sta wR0
          lda #$00FF
          sta aAIAction.wMapPointer
          sta aAIAction.wTargetCount
          sta aAIAction.wUnitFaction

          lda #0
          sta wR12
          ldx #0
          ldy #6

          -
          lda $000C,b,y
          cmp #$00FF
          beq +

          phx
          tax
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b
          plx
          jsl rlGetSelectedUnitGenerationID
          bcs +

            cmp wR0
            bne +

              inc wR12
              lda $000C,b,y
              sta aAIAction.wMapPointer,x
              inc x
              inc x

          +
          dec y
          dec y
          bpl -

          lda wR12
          beq _CLC

            plx
            stx wR0
            plx 
            stx wSelectedUnitDataRAMPointer,b
            ply
            plx
            sec
            rts

        _CLC
        plx
        stx wR0
        plx
        stx wSelectedUnitDataRAMPointer,b
        ply
        plx
        clc
        rts

        .databank 0

      rsActionStructCheckForSiblingCrit ; 87/BCCF

        .al
        .autsiz
        .databank ?

        lda #(`aSiblingCritEntryPointers)<<8
        sta lR18+1
        lda #<>aSiblingCritEntryPointers
        sta lR18
        lda #1
        jsr rsCountUnitsInSpecialCombatEffectTable
        cmp #2
        bcc +

          sec
          rts

        +
        clc
        rts

        .databank 0

      aSiblingCritEntryPointers ; 87/BCE8

        .addr aSiblingCritEntry1
        .addr aSiblingCritEntry2
        .addr aSiblingCritEntry3
        .addr aSiblingCritEntry4
        .addr aSiblingCritEntry5
        .addr aSiblingCritEntry6
        .addr aSiblingCritEntry7
        .addr aSiblingCritEntry8
        .addr aSiblingCritEntry9
        .addr aSiblingCritEntry10
        .addr aSiblingCritEntry11
        .addr aSiblingCritEntry12
        .addr aSiblingCritEntry13
        .addr aSiblingCritEntry14
        .addr aSiblingCritEntry15
        .addr aSiblingCritEntry16
        .addr aSiblingCritEntry17
        .word 0

      aSiblingCritEntry1 ; 87/BD0C

        .word Sigurd
        .word Ethlyn
        .word 0

      aSiblingCritEntry2 ; 87/BD12

        .word Dalvin
        .word Creidne
        .word 0

      aSiblingCritEntry3 ; 87/BD18

        .word Scathach
        .word Larcei
        .word 0

      aSiblingCritEntry4 ; 87/BD1E

        .word Asaello
        .word Daisy
        .word 0

      aSiblingCritEntry5 ; 87/BD24

        .word Febail
        .word Patty
        .word 0

      aSiblingCritEntry6 ; 87/BD2A

        .word Leif
        .word Altena
        .word 0

      aSiblingCritEntry7 ; 87/BD30

        .word Charlot
        .word Laylea
        .word 0

      aSiblingCritEntry8 ; 87/BD36

        .word Coirpre
        .word Lene
        .word 0

      aSiblingCritEntry9 ; 87/BD3C

        .word Hawk
        .word Hermina
        .word 0

      aSiblingCritEntry10 ; 87/BD42

        .word Ced
        .word Fee
        .word 0

      aSiblingCritEntry11 ; 87/BD48

        .word Tristan
        .word Jeanne
        .word 0

      aSiblingCritEntry12 ; 87/BD4E

        .word Diarmuid
        .word Nanna
        .word 0

      aSiblingCritEntry13 ; 87/BD54

        .word Deimne
        .word Muirne
        .word 0

      aSiblingCritEntry14 ; 87/BD5A

        .word Lester
        .word Lana
        .word 0

      aSiblingCritEntry15 ; 87/BD60

        .word Amid
        .word Linda
        .word 0

      aSiblingCritEntry16 ; 87/BD66

        .word Arthur
        .word Tine
        .word 0

      aSiblingCritEntry17 ; 87/BD6C

        .word Brigid
        .word Edain
        .word 0

      rsActionStructCheckForTriangleAttack ; 87/BD72

        .al
        .autsiz
        .databank ?

        lda #(`aTriangleAttackEntryPointers)<<8
        sta lR18+1
        lda #<>aTriangleAttackEntryPointers
        sta lR18
        lda #0
        jsr rsCountUnitsInSpecialCombatEffectTable
        cmp #3
        bcc +

          sec
          rts

        +
        clc
        rts

        .databank 0

      aTriangleAttackEntryPointers ; 87/BD8B

        .word <>aTriangleAttackEntry1
        .word <>aTriangleAttackEntry2
        .word <>aTriangleAttackEntry3
        .word 0

      aTriangleAttackEntry1 ; 87/BD93

        .word BanbaCh07
        .word FotlaCh07
        .word EriuCh07
        .word 0

      aTriangleAttackEntry2 ; 87/BD9B

        .word BanbaCh08
        .word FotlaCh08
        .word EriuCh08
        .word 0

      aTriangleAttackEntry3 ; 87/BDA3

        .word Meng
        .word Mabel
        .word Bleg
        .word 0

      rsCountUnitsInSpecialCombatEffectTable ; 87/BDAB

        .al
        .autsiz
        .databank ?

        ; lR18 = long pointer to a pointer table

        phx
        phy
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wR1
        phx
        ldx wR10
        phx
        ldx wR11
        phx

        asl a
        asl a
        asl a
        sta wR10
        stz wR12

        jsl rlGetSelectedUnitCharacterID
        sta wR0

        jsr rsCheckIfUnitInSpecialCombatEffectTable
        bcs _End

          stx wR1
          inc wR12
          lda #$00FF
          sta aAIAction.wMapPointer
          sta aAIAction.wTargetCount
          sta aAIAction.wUnitFaction
          ldx #0
          ldy wR10
          lda #4
          sta wR11

          -
          lda $0004,b,y
          cmp #$00FF
          beq _Next

            phx
            tax
            lda aDeploymentTable._UnitRAMPointer,x
            sta wSelectedUnitDataRAMPointer,b
            plx

            jsl rlGetSelectedUnitCharacterID
            sta wR0

            phx
            ldx wR1
            jsr rsCheckIfUnitInSpecialCombatEffectEntry
            plx
            bcs _Next

              inc wR12
              lda $0004,b,y
              sta aAIAction.wMapPointer,x
              inc x
              inc x

          _Next
          inc y
          inc y
          dec wR11
          bne -

        _End
        lda wR12
        plx
        stx wR11
        plx
        stx wR10
        plx
        stx wR1
        plx
        stx wSelectedUnitDataRAMPointer,b
        ply
        plx
        rts

        .databank 0

      rsCheckIfUnitInSpecialCombatEffectTable ; 87/BE2D

        .al
        .autsiz
        .databank ?

        ; In:
        ; wR0  = unit ID
        ; lR18 = pointer table

        ; Out:
        ; x = entry pointer
        ; clc if found
        ; sec if not

        phb
        php
        phk
        plb
        phy

        ldy lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        ; branch if end of table reached
        -
        lda $0000,b,y
        beq _SEC

        tax
        phx
        jsr rsCheckIfUnitInSpecialCombatEffectEntry
        plx
        bcc _CLC

        inc y
        inc y
        bra -

        _SEC
        ply
        plp
        plb
        sec

        -
        rts

        _CLC
        ply
        plp
        plb
        clc
        bra -

        .databank 0

      rsCheckIfUnitInSpecialCombatEffectEntry ; 87/BE58

        .al
        .autsiz
        .databank ?

        ; wR0 = unit ID
        ; x = entry for triangle attack or sibling crit

        ; clc = is in table
        ; sec = is not

        -
        lda $0000,b,x
        beq _SEC

        cmp wR0
        beq _CLC

        inc x
        inc x
        bra -

        _SEC
        sec
        bra +

        _CLC
        clc
        
        +
        rts 

        .databank 0

      rlGetAnimationOptionSetting ; 87/BE6A

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda wOptionSettings,b
        and #$6000
        clc
        rol a
        rol a
        rol a
        rol a

        plp
        plb
        rtl

        .databank 0

      rlSetBattleAnimationOption ; 87/BE7C

        .al
        .autsiz
        .databank ?

        ; Writes the battle animation setting (A, 0-3) into wOptionSettings.

        phb
        php
        phk
        plb
        pha

        ; Reset animation settings

        lda #$6000
        trb wOptionSettings,b

        pla
        and #$0003
        xba
        lsr a
        lsr a
        lsr a
        ora wOptionSettings+1,b
        sta wOptionSettings+1,b
        plp
        plb
        rtl

        .databank 0

        ; 87/BE98

    .endsection ScriptedCritsSection
