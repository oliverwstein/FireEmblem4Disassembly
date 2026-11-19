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


    .section CheckIfTerrainWindowSettingOffSection

      .al
      .xl

      rlCheckIfTerrainWindowSettingOff ; 87/BE98

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda wOptionSettings,b
        bit #$0002

        _BEA2
        bne +

        lda #0
        bra ++

        +
        lda #1

        +
        plp
        plb
        rtl

        .databank 0

      rlSetTerrainWindowSetting ; 87/BEAF

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        ora #0
        bne +

        lda #$0002
        trb wOptionSettings,b
        bra ++

        +
        lda #$0002
        tsb wOptionSettings,b

        +
        plp
        plb
        rtl

        .databank 0

      rlCheckIfUnitWindowSettingOff ; 87/BEC9

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda wOptionSettings,b
        bit #$0004
        jml rlCheckIfTerrainWindowSettingOff._BEA2

        .databank 0

        ; 87/BED7

    .endsection CheckIfTerrainWindowSettingOffSection


    .section GetTextSpeedOptionSection

      .al
      .xl

      rlGetTextSpeedOption ; 87/BEF1

        .al
        .autsiz
        .databank ?

        phb 
        php
        phk
        plb

        lda wOptionSettings,b
        and #$0038
        lsr a
        lsr a
        lsr a

        plp
        plb
        rtl

        .databank 0

        ; 87/BF01

    .endsection GetTextSpeedOptionSection
