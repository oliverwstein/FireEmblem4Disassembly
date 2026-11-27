; Reading and changing the game options kept in wOptionSettings: battle
; animations, the unit and terrain windows, text and enemy speed, sound,
; auto-save, auto cursor and the enemy AI.

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


    .section SetUnitWindowSettingSection

      .al
      .xl

      rlSetUnitWindowSetting ; 87/BED7

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the options menu's value: nonzero sets bit 2 of wOptionSettings (read back by rlCheckIfUnitWindowSettingOff).

        phb
        php
        phk
        plb
        .databank $87
        ora #$0000
        bne _BEE8
        lda #$0004
        trb wOptionSettings,b
        bra _BEEE


        _BEE8
        lda #$0004
        tsb wOptionSettings,b

        _BEEE
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BEF1

    .endsection SetUnitWindowSettingSection


    .section SetTextSpeedOptionSection

      .al
      .xl

      rlSetTextSpeedOption ; 87/BF01

        .al
        .xl
        .autsiz
        .databank ?

        ; A = 0-4: bits 3-5 of wOptionSettings.

        phb
        php
        phk
        plb
        .databank $87
        and #$0007
        asl a
        asl a
        asl a
        sta wR0
        lda wOptionSettings,b
        and #$FFC7
        ora wR0
        sta wOptionSettings,b
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BF1B

    .endsection SetTextSpeedOptionSection


    .section GetEnemySpeedOptionSection

      .al
      .xl

      rlGetEnemySpeedOption ; 87/BF1B

        .al
        .xl
        .autsiz
        .databank ?

        ; Bit 6 of wOptionSettings: 0 real, 1 fast.

        phb
        php
        phk
        plb
        .databank $87
        lda wOptionSettings,b
        bit #$0040
        jml rlCheckIfTerrainWindowSettingOff._BEA2

        .databank 0

        ; 87/BF29

    .endsection GetEnemySpeedOptionSection


    .section SetEnemySpeedOptionSection

      .al
      .xl

      rlSetEnemySpeedOption ; 87/BF29

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        ora #$0000
        bne _BF3A
        lda #$0040
        trb wOptionSettings,b
        bra _BF40


        _BF3A
        lda #$0040
        tsb wOptionSettings,b

        _BF40
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BF43

    .endsection SetEnemySpeedOptionSection


    .section GetSoundOptionSection

      .al
      .xl

      rlGetSoundOption ; 87/BF43

        .al
        .xl
        .autsiz
        .databank ?

        ; Bits 7-8 of wOptionSettings: 0 stereo, 1 mono, 2 off.

        phb
        php
        phk
        plb
        .databank $87
        lda wOptionSettings,b
        and #$0180
        asl a
        xba
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BF52

    .endsection GetSoundOptionSection


    .section SetSoundOptionSection

      .al
      .xl

      rlSetSoundOption ; 87/BF52

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Also applies it (rlApplySoundOption).

        phb
        php
        phk
        plb
        .databank $87
        and #$0003
        xba
        lsr a
        sta wR0
        lda wOptionSettings,b
        and #$FE7F
        ora wR0
        sta wOptionSettings,b
        jsl rlApplySoundOption
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BF6F

    .endsection SetSoundOptionSection


    .section ApplySoundOptionSection

      .al
      .xl

      rlApplySoundOption ; 87/BF6F

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bSoundFlags from the sound option: off sets bit 4, mono sets bit 6, stereo clears both.

        phb
        php
        phk
        plb
        .databank $87
        jsl rlGetSoundOption
        cmp #$0002
        bne _BF8A
        sep #$20
        lda bSoundFlags,b
        ora #$10
        sta bSoundFlags,b
        rep #$20
        bra _BFAD


        _BF8A
        cmp #$0001
        bne _BF9F
        sep #$20
        lda bSoundFlags,b
        and #$EF
        ora #$40
        sta bSoundFlags,b
        rep #$20
        bra _BFAD


        _BF9F
        sep #$20
        lda bSoundFlags,b
        and #$AF
        sta bSoundFlags,b
        rep #$20
        bra _BFAD


        _BFAD
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BFB0

      rlGetAutoSaveOption ; 87/BFB0

        .al
        .xl
        .autsiz
        .databank ?

        ; Bit 9 of wOptionSettings: 1 if auto-save is on.

        phb
        php
        phk
        plb
        .databank $87
        lda wOptionSettings,b
        and #$0200
        xba
        lsr a
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BFBF

    .endsection ApplySoundOptionSection


    .section SetAutoSaveOptionSection

      .al
      .xl

      rlSetAutoSaveOption ; 87/BFBF

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        ora #$0000
        bne _BFD0
        lda #$0200
        trb wOptionSettings,b
        bra _BFD6


        _BFD0
        lda #$0200
        tsb wOptionSettings,b

        _BFD6
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BFD9

    .endsection SetAutoSaveOptionSection


    .section GetAutoSaveFileSection

      .al
      .xl

      rlGetAutoSaveFile ; 87/BFD9

        .al
        .xl
        .autsiz
        .databank ?

        ; Bits 10-11 of wOptionSettings: the file auto-save writes, 0-3.

        phb
        php
        phk
        plb
        .databank $87
        lda wOptionSettings,b
        and #$0C00
        xba
        lsr a
        lsr a
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/BFE9

    .endsection GetAutoSaveFileSection


    .section SetAutoSaveFileSection

      .al
      .xl

      rlSetAutoSaveFile ; 87/BFE9

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        and #$0003
        xba
        asl a
        asl a
        sta wR0
        lda wOptionSettings,b
        and #$F3FF
        ora wR0
        sta wOptionSettings,b
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/C003

    .endsection SetAutoSaveFileSection


    .section SetCleverModeFlagSection

      .al
      .xl

      rlSetCleverModeFlag ; 87/C015

        .al
        .xl
        .autsiz
        .databank ?

        ; A nonzero sets bit 12 of wOptionSettings (the enemy AI option; rlGetCleverModeFlag).

        phb
        php
        phk
        plb
        .databank $87
        ora #$0000
        bne _C026
        lda #$1000
        trb wOptionSettings,b
        bra _C02C


        _C026
        lda #$1000
        tsb wOptionSettings,b

        _C02C
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/C02F

    .endsection SetCleverModeFlagSection


    .section GetAutoCursorOptionSection

      .al
      .xl

      rlGetAutoCursorOption ; 87/C02F

        .al
        .xl
        .autsiz
        .databank ?

        ; Bit 0 of wOptionSettings.

        phb
        php
        phk
        plb
        .databank $87
        lda wOptionSettings,b
        and #$0001
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/C03C

    .endsection GetAutoCursorOptionSection


    .section SetAutoCursorOptionSection

      .al
      .xl

      rlSetAutoCursorOption ; 87/C03C

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        ora #$0000
        bne _C04D
        lda #$0001
        trb wOptionSettings,b
        bra _C053


        _C04D
        lda #$0001
        tsb wOptionSettings,b

        _C053
        plp
        plb
        .databank $87
        rtl

        .databank 0

        ; 87/C056

    .endsection SetAutoCursorOptionSection


