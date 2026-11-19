; TODO: describe this file.

    .section CheckIfBattleAnimationOFFSection

      .al
      .xl

      rlCheckIfBattleAnimationOFF ; 84/BB65

        .al
        .autsiz
        .databank ?

        ; CLC = on
        ; SEC = off

        jsl rlGetSelectedUnitFactionSlot
        ora #0
        bne _SEC

        jsl rlGetSelectedUnitClassID
        cmp #Civilian
        beq _SEC

        cmp #Child
        beq _SEC

        jsl rlGetAnimationOptionSetting
        cmp #0
        beq _CLC

        cmp #1
        beq _SEC

        jsl rlGetSelectedUnitStates
        bit #UnitStateMapAnimation
        bne _SEC
        bra _CLC
        
        _CLC
        clc
        bra +
        
        _SEC
        sec
        
        +
        rtl

        .databank 0

        ; 84/BB9A

    .endsection CheckIfBattleAnimationOFFSection
