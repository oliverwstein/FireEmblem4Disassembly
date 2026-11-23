; The end of a battle scene: the end steps that show the death quote, the
; experience bar, the level up, the item, gold and broken weapon messages; the
; skill banners (rlBattleSceneShowSkill) and Julius's ending.


    .section Unsorted95E7B3Section

      .al
      .xl

      rlUnknown95E7B3 ; 95/E7B3

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda #$01FF

        _E7BA
        sta $7E9F88,x
        inc x
        inc x
        cpx #$0280
        bcc _E7BA
        jsl rlUnknown95E9EF
        plx
        rtl

        .databank 0

        ; 95/E7CB

      rlUnknown95E7CB ; 95/E7CB

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown95E834
        lda lBattleSceneDialoguePointer+1
        sta lR18+1
        lda lBattleSceneDialoguePointer
        sta lR18
        jsl rlUnknown918102
        lda #$0000
        sta $7FE4D9
        lda #$0001
        sta aDialogue.wTextSound,b
        rtl

        .databank 0

        ; 95/E7EC

      rlUnknown95E7EC ; 95/E7EC

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown95E834
        lda lBattleSceneDialoguePointer+1
        sta lR18+1
        lda lBattleSceneDialoguePointer
        sta lR18
        jsl rlUnknown918102
        lda #$0000
        sta $7FE4D9
        lda #$0001
        sta aDialogue.wTextSound,b
        rtl

        .databank 0

        ; 95/E80D

    .endsection Unsorted95E7B3Section


    .section Unreferenced95E80DSection

      .al
      .xl

      rlUnknown95E80D ; 95/E80D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown95E834
        lda #$A00C
        sta $18D4,b
        lda #$061E
        sta $18DB,b
        sta $18F4,b
        lda #(`dialogueBattleSceneClear)<<8
        sta lR18+1
        lda #<>dialogueBattleSceneClear
        sta lR18
        jsl rlUnknown918102
        lda #$0000
        sta aDialogue.wTextSound,b
        rtl

        .databank 0

        ; 95/E834

    .endsection Unreferenced95E80DSection
    .section Unsorted95E834Section

      .al
      .xl

      rsUnknown95E834 ; 95/E834

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlResetDialogueEngine
        lda #$0003
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0006
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$7000
        sta $18D7,b
        sta $18F0,b
        lda #$7E00
        sta $18D5,b
        sta $18EE,b
        lda #$A01C
        sta $18D4,b
        sta $18ED,b
        lda #$0614
        sta $18DB,b
        sta $18F4,b
        lda #$01FF
        sta aDialogue.wClearTile,b
        lda #$2000
        sta aDialogue.wBaseTile,b
        rts

        .databank 0

        ; 95/E877

    .endsection Unsorted95E834Section


    .section Unreferenced95E877Section

      .al
      .xl

      rlUnknown95E877 ; 95/E877

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda lBattleSceneDialoguePointer+1
        sta lR18+1
        lda lBattleSceneDialoguePointer
        sta lR18
        jsl rlUnknown918102
        rtl

        .databank 0

        ; 95/E888

    .endsection Unreferenced95E877Section
    .section Unsorted95E888Section

      .al
      .xl

      rlUnknown95E888 ; 95/E888

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlRunDialogueCycle
        jsl rlUnknown95E8B4
        jsl rlUnknown95EA03
        jsl rlUnknown96A21F
        lda $7FE4D9
        beq _E8A5
        dec a
        sta $7FE4D9
        bra _E8B3


        _E8A5
        lda aDialogue.wStatus,b
        and #$00FF
        bne _E8B3
        jsl rlBattleSceneEndScriptRoutine
        bra _E8B3


        _E8B3
        rtl

        .databank 0

        ; 95/E8B4

      rlUnknown95E8B4 ; 95/E8B4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7E00
        sta lR18+1
        lda #$A008
        sta lR18
        ldy #$7640
        lda #$0180
        jsl rlBattleSceneStartLargeUpload
        rtl

        .databank 0

        ; 95/E8C9

      rlUnknown95E8C9 ; 95/E8C9

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDialogueFreeHDMA
        rtl

        .databank 0

        ; 95/E8CE

      rlBattleSceneOpenMessageWindow ; 95/E8CE

        .al
        .xl
        .autsiz
        .databank ?

        ; Before any of the messages below (a broken weapon, an item, gold stolen or got): starts script $2A, which opens the message window.

        lda aActionStructUnit1.WeaponInventorySlot
        bmi _E8E9
        lda aActionStructUnit1.ObtainedItem
        cmp #$FFFF
        bne _E8E9
        lda aActionStructUnit2.ObtainedStealMoney
        bne _E8E9
        lda aActionStructUnit1.ObtainedStealMoney
        beq _E8FC

        _E8E9
        lda #$002A
        jsl rlStartBattleSceneScript
        lda #$0000
        sta wBufferBG3VOFS
        lda #$0000
        sta $7FE4D9

        _E8FC
        rtl

        .databank 0

        ; 95/E8FD

      rlBattleSceneShowItemObtained ; 95/E8FD

        .al
        .xl
        .autsiz
        .databank ?

        ; When aActionStructUnit1 obtained an item: dialogueBattleSceneItemObtained, script $2C, sound $92.

        lda aActionStructUnit1.ObtainedItem
        cmp #$FFFF
        beq _E930
        lda #(`dialogueBattleSceneItemObtained)<<8
        sta lBattleSceneDialoguePointer+1
        lda #<>dialogueBattleSceneItemObtained
        sta lBattleSceneDialoguePointer
        lda aActionStructUnit1.ObtainedItem
        sta aDialogue.wItemID,b
        lda #$002C
        jsl rlStartBattleSceneScript
        lda #$0092
        jsl rlPlaySoundEffect
        lda #$0057
        sta $7FE4D9

        _E930
        rtl

        .databank 0

        ; 95/E931

      rlBattleSceneShowGoldObtained ; 95/E931

        .al
        .xl
        .autsiz
        .databank ?

        ; When aActionStructUnit1 stole gold: dialogueBattleSceneGoldObtained, script $2F, sound $92.

        lda aActionStructUnit1.ObtainedStealMoney
        beq _E961
        lda #(`dialogueBattleSceneGoldObtained)<<8
        sta lBattleSceneDialoguePointer+1
        lda #<>dialogueBattleSceneGoldObtained
        sta lBattleSceneDialoguePointer
        lda aActionStructUnit1.ObtainedStealMoney
        sta aDialogue.wNumber1,b
        lda #$002F
        jsl rlStartBattleSceneScript
        lda #$0092
        jsl rlPlaySoundEffect
        lda #$0057
        sta $7FE4D9

        _E961
        rtl

        .databank 0

        ; 95/E962

      rlBattleSceneShowGoldStolen ; 95/E962

        .al
        .xl
        .autsiz
        .databank ?

        ; When aActionStructUnit2 stole gold from the player's unit: dialogueBattleSceneGoldStolen, script $2F, sound $93.

        lda aActionStructUnit2.ObtainedStealMoney
        beq _E992
        lda #(`dialogueBattleSceneGoldStolen)<<8
        sta lBattleSceneDialoguePointer+1
        lda #<>dialogueBattleSceneGoldStolen
        sta lBattleSceneDialoguePointer
        lda aActionStructUnit2.ObtainedStealMoney
        sta aDialogue.wNumber1,b
        lda #$002F
        jsl rlStartBattleSceneScript
        lda #$0093
        jsl rlPlaySoundEffect
        lda #$0067
        sta $7FE4D9

        _E992
        rtl

        .databank 0

        ; 95/E993

      rlBattleSceneShowWeaponBroke ; 95/E993

        .al
        .xl
        .autsiz
        .databank ?

        ; When aActionStructUnit1's weapon broke (no inventory slot left): dialogueBattleSceneWeaponBroke, script $44, sound $93.

        lda aActionStructUnit1.WeaponInventorySlot
        bpl _E9C3
        lda #(`dialogueBattleSceneWeaponBroke)<<8
        sta lBattleSceneDialoguePointer+1
        lda #<>dialogueBattleSceneWeaponBroke
        sta lBattleSceneDialoguePointer
        lda aActionStructUnit1.WeaponID
        sta aDialogue.wItemID,b
        lda #$0044
        jsl rlStartBattleSceneScript
        lda #$0093
        jsl rlPlaySoundEffect
        lda #$0067
        sta $7FE4D9

        _E9C3
        rtl

        .databank 0

        ; 95/E9C4

      rlBattleSceneShowWaitForPress ; 95/E9C4

        .al
        .xl
        .autsiz
        .databank ?

        ; After a message: dialogueBattleSceneWaitPress, script $30.

        lda aActionStructUnit1.WeaponInventorySlot
        bmi _E9D9
        lda aActionStructUnit1.ObtainedItem
        cmp #$FFFF
        bne _E9D9
        lda aActionStructUnit1.ObtainedStealMoney
        beq _E9EE

        _E9D9
        lda #(`dialogueBattleSceneWaitPress)<<8
        sta lBattleSceneDialoguePointer+1
        lda #<>dialogueBattleSceneWaitPress
        sta lBattleSceneDialoguePointer
        lda #$0030
        jsl rlStartBattleSceneScript

        _E9EE
        rtl

        .databank 0

        ; 95/E9EF

      rlUnknown95E9EF ; 95/E9EF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _E9F3
        lda aUnknownE000C8+8,x
        sta $0274,b,x
        inc x
        inc x
        cpx #$000A
        bcc _E9F3
        plx
        rtl

        .databank 0

        ; 95/EA03

      rlUnknown95EA03 ; 95/EA03

        .al
        .xl
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        bit #$4000
        bne _EA18
        lda aDialogue.wStatus,b
        bit #$8000
        beq _EA46
        ldy #$88EE
        bra _EA1B


        _EA18
        ldy #$88E2

        _EA1B
        lda $7FFC78
        sta wNextFreeSpriteOffset,b
        clc
        adc #$0008
        sta $7FFC7A
        phb
        sep #$20
        lda #$99
        pha
        plb
        .databank $99
        rep #$20
        lda #$00D8
        sta wR0
        lda #$00C0
        sta wR1
        stz wR4
        stz wR5
        jsl rlPushToOAMBuffer
        plb
        .databank $99

        _EA46
        rtl

        .databank 0

        ; 95/EA47

    .endsection Unsorted95E888Section


    .section Unsorted96881FSection

      .al
      .xl

      rlUnknown96881F ; 96/881F

        .al
        .xl
        .autsiz
        .databank ?

        lda wBattleQuotePointer
        cmp #$0000
        beq _883F
        lda wBattleQuotePointer
        sta lBattleSceneDialoguePointer
        lda wBattleQuotePointer+1
        sta lBattleSceneDialoguePointer+1
        lda #$002D
        jsl rlStartBattleSceneScript

        _883F
        rtl

        .databank 0

        ; 96/8840

      rlBattleSceneShowDeathQuote ; 96/8840

        .al
        .xl
        .autsiz
        .databank ?

        ; Unless the battle ends on Julius: when the battle has a death quote, sets it as the scene's dialogue and starts its script.

        lda wBattleSceneFlags
        bit #BattleSceneFlagToMapMode3
        bne _888F
        lda wDeathQuotePointer
        cmp #$0000
        beq _888F
        lda wDeathQuotePointer
        sta lBattleSceneDialoguePointer
        lda wDeathQuotePointer+1
        sta lBattleSceneDialoguePointer+1
        lda aActionStructUnit1.GainedExperience
        bne _8888
        lda aActionStructUnit1.ObtainedItem
        cmp #$FFFF
        bne _8888
        lda aActionStructUnit1.ObtainedStealMoney
        bne _8888
        lda aActionStructUnit2.ObtainedStealMoney
        bne _8888
        lda aActionStructUnit1.WeaponInventorySlot
        bmi _8888
        lda #$004A
        bra _888B


        _8888
        lda #$002E

        _888B
        jsl rlStartBattleSceneScript

        _888F
        rtl

        .databank 0

        ; 96/8890

      rlBattleSceneShowJuliusQuote ; 96/8890

        .al
        .xl
        .autsiz
        .databank ?

        ; When the battle ends on Julius and has a death quote, starts script $4A with it.

        lda wBattleSceneFlags
        bit #BattleSceneFlagToMapMode3
        beq _88B9
        lda wDeathQuotePointer
        cmp #$0000
        beq _88B9
        lda wDeathQuotePointer
        sta lBattleSceneDialoguePointer
        lda wDeathQuotePointer+1
        sta lBattleSceneDialoguePointer+1
        lda #$004A
        jsl rlStartBattleSceneScript

        _88B9
        rtl

        .databank 0

        ; 96/88BA

      rlUnknown9688BA ; 96/88BA

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$03
        sta $7FE4C2
        rep #$20
        stz aBGPaletteBuffer,b
        ldx #$0000

        _88CA
        lda aUnknownE000DA,x
        sta $0102,b,x
        inc x
        inc x
        cpx #$001E
        bcc _88CA
        lda #$0004
        jsl rlHDMAEngineFreeEntryByIndex
        jsl rlUnknown9695E3
        rtl

        .databank 0

      rlUnknown9688E4 ; 96/88E4

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        .as
        lda #$04
        sta $7FE4C2
        rep #$20
        .al
        stz aBGPaletteBuffer,b
        ldx #$0000

        -
        lda @l aUnknownE000DA,x
        sta $0102,b,x
        inc x
        inc x
        cpx #$001E
        bcc -

        lda #$0004
        jsl rlHDMAEngineFreeEntryByIndex
        jsl rlUnknown9695E3
        rtl

        .databank 0

    .endsection Unsorted96881FSection


    .section Unsorted96A20ESection

      .al
      .xl

      rlBattleSceneEndStepJulius ; 96/A20E

        .al
        .xl
        .autsiz
        .databank ?

        ; When the battle ends on Julius, starts script $4C.

        lda wBattleSceneFlags
        bit #BattleSceneFlagToMapMode3
        beq _A21E
        lda #$004C
        jsl rlStartBattleSceneScript

        _A21E
        rtl

        .databank 0

        ; 96/A21F

      rlUnknown96A21F ; 96/A21F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FE4C2
        and #$00FF
        cmp #$0003
        bne _A26D
        lda @l $0018A5
        cmp #$0002
        bcc _A23A
        lda #$891A
        bra _A247


        _A23A
        cmp #$0001
        bne _A244
        lda #$890A
        bra _A247


        _A244
        lda #$88FA

        _A247
        sta lR18
        sep #$20
        lda #$99
        sta lR18+2
        rep #$20
        lda #$0008
        ldy #$6A83
        jsl rlBattleSceneQueueUpload
        lda lR18
        clc
        adc #$0008
        sta lR18
        lda #$0008
        ldy #$6AA3
        jsl rlBattleSceneQueueUpload

        _A26D
        plx
        rtl

        .databank 0

        ; 96/A26F

      rlResetBattleSceneScript ; 96/A26F

        .al
        .xl
        .autsiz
        .databank ?

        ; Stops the script and clears its wait count and timer.

        sep #$20
        lda $7FE4B7
        and #$7F
        sta $7FE4B7
        lda #$00
        sta bBattleSceneScriptWaitCount
        rep #$20
        lda #$0000
        sta $7FE4BE
        rtl

        .databank 0

        ; 96/A28B

    .endsection Unsorted96A20ESection


    .section Unsorted96F558Section

      .al
      .xl

      rlBattleSceneEndStepType2Script ; 96/F558

        .al
        .xl
        .autsiz
        .databank ?

        ; In battle type 2, starts script $33.

        lda wBattleType
        and #$00FF
        cmp #$0002
        bne _F56B
        lda #$0033
        jsl rlStartBattleSceneScript

        _F56B
        rtl

        .databank 0

        ; 96/F56C

      rlBattleSceneEndStepType2Script2 ; 96/F56C

        .al
        .xl
        .autsiz
        .databank ?

        ; In battle type 2, starts script $35.

        lda wBattleType
        and #$00FF
        cmp #$0002
        bne _F57F
        lda #$0035
        jsl rlStartBattleSceneScript

        _F57F
        rtl

        .databank 0

      rlUnknown96F580 ; 96/F580

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        .as
        lda #$22
        sta bBufferCGWSEL
        lda #$30
        sta bBufferWOBJSEL
        rep #$20
        .al
        lda #$0000
        sta $7FFDF8
        lda #(`rlUnknown96F5A4)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlUnknown96F5A4
        sta lBattleSceneScriptRoutine
        plx
        rtl

        .databank 0

      rlUnknown96F5A4 ; 96/F5A4

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FFDF8
        cmp #$0080
        bcc +
        jsl rlBattleSceneEndScriptRoutine
        bra _F5D5

        +
        lsr a
        lsr a
        cmp #$0020
        bcc +
        lda #$001F
        +
        sta $7FFDFE
        sep #$20
        .as
        ora #$E0
        sta $7FE3EE
        rep #$20
        .al
        lda $7FFDF8
        inc a
        sta $7FFDF8

        _F5D5
        plx
        rtl

        .databank 0

      rlUnknown96F5D7 ; 96/F5D7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$007F
        sta $7FFDF8
        lda #(`rlUnknown96F5EF)<<8
        sta lBattleSceneScriptRoutine+1
        lda #<>rlUnknown96F5EF
        sta lBattleSceneScriptRoutine
        plx
        rtl

        .databank 0

      rlUnknown96F5EF ; 96/F5EF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FFDF8
        bne +
        jsl rlBattleSceneEndScriptRoutine
        bra _F61D

        +
        lsr a
        lsr a
        cmp #$0020
        bcc +
        lda #$001F
        +
        sta $7FFDFE
        sep #$20
        .as
        ora #$E0
        sta $7FE3EE
        rep #$20
        .al
        lda $7FFDF8
        dec a
        sta $7FFDF8

        _F61D
        plx
        rtl

        .databank 0

      rlUnknown96F61F ; 96/F61F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$7FFF
        sta aBGPaletteBuffer,b
        sep #$20
        .as
        lda #$08
        sta bBattleAnimationAttributes,b
        rep #$20
        .al
        jsl rlBattleSceneEndScriptRoutine
        plx
        rtl

        .databank 0

      rlUnknown96F635 ; 96/F635

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        -
        lda $7ECC08,x
        sta $0102,b,x
        inc x
        inc x
        cpx #$001E
        bcc -

        ldx #$0000

        -
        lda $7ECC28,x
        sta $01C2,b,x
        inc x
        inc x
        cpx #$001E
        bcc -

        lda aUnknownE000B0+12
        sta $0108,b
        ldx #$0000

        -
        lda @l aUnknownE000B0,x
        sta $010A,b,x
        inc x
        inc x
        cpx #$0006
        bcc -

        jsl rlBattleSceneEndScriptRoutine
        plx
        rtl

        .databank 0

    .endsection Unsorted96F558Section


    .section Unsorted96F676Section

      .al
      .xl

      rlBattleSceneShowLevelUpBanner ; 96/F676

        .al
        .xl
        .autsiz
        .databank ?

        ; When aActionStructUnit1 gained a level, copies the banner's colors and starts script $3B.

        phx
        lda aActionStructUnit1.GainedLevels
        beq _F695
        ldx #$0000

        _F680
        lda aUnknownE000B0+14,x
        sta $0274,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F680
        lda #$003B
        jsl rlStartBattleSceneScript

        _F695
        plx
        rtl

        .databank 0

        ; 96/F697

    .endsection Unsorted96F676Section


    .section Unsorted96F697Section

      .al
      .xl

      rlBattleSceneShowSkill ; 96/F697

        .al
        .xl
        .autsiz
        .databank ?

        ; A round entry $FE: shows the skill in its high byte (Astra, Luna, Sol, Holy, Darkness or Pavise) by its colors and script.

        phy
        inc y
        lda [lR18],y
        and #$00FF
        cmp #SkillIDAstra
        bne _F6A9
        jsl rlBattleSceneShowAstra
        bra _F6DE


        _F6A9
        cmp #SkillIDLuna
        bne _F6B4
        jsl rlBattleSceneShowLuna
        bra _F6DE


        _F6B4
        cmp #SkillIDSol
        bne _F6BF
        jsl rlBattleSceneShowSol
        bra _F6DE


        _F6BF
        cmp #SkillIDHoly
        bne _F6CA
        jsl rlBattleSceneShowHoly
        bra _F6DE


        _F6CA
        cmp #SkillIDDarkness
        bne _F6D5
        jsl rlBattleSceneShowDarkness
        bra _F6DE


        _F6D5
        cmp #SkillIDPavise
        bne _F6DE
        jsl rlBattleSceneShowPavise

        _F6DE
        ply
        rtl

        .databank 0

        ; 96/F6E0

      rlBattleSceneShowAstra ; 96/F6E0

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the skill's colors (aUnknownE027C3) and starts battle scene script $36.

        phx
        ldx #$0000

        _F6E4
        lda aUnknownE027C3,x
        sta $0274,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F6E4
        lda #$0036
        jsl rlStartBattleSceneScript
        plx
        rtl

        .databank 0

        ; 96/F6FB

      rlBattleSceneShowLuna ; 96/F6FB

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the skill's colors (aUnknownE027CD) and starts battle scene script $37.

        phx
        ldx #$0000

        _F6FF
        lda aUnknownE027CD,x
        sta $0274,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F6FF
        lda #$0037
        jsl rlStartBattleSceneScript
        plx
        rtl

        .databank 0

        ; 96/F716

      rlBattleSceneShowSol ; 96/F716

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the skill's colors (aUnknownE027D7), starts battle scene script $38 and sets bit 2 of $7FFC5D.

        phx
        ldx #$0000

        _F71A
        lda aUnknownE027D7,x
        sta $0274,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F71A
        lda #$0038
        jsl rlStartBattleSceneScript
        sep #$20
        lda $7FFC5D
        ora #$04
        sta $7FFC5D
        rep #$20
        plx
        rtl

        .databank 0

        ; 96/F73F

      rlBattleSceneShowHoly ; 96/F73F

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the skill's colors (aUnknownE027E1) and starts battle scene script $39; A is kept in $7FFC5F.

        phx
        sep #$20
        sta $7FFC5F
        rep #$20
        ldx #$0000

        _F74B
        lda aUnknownE027E1,x
        sta $02F4,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F74B
        lda #$0039
        jsl rlStartBattleSceneScript
        plx
        rtl

        .databank 0

        ; 96/F762

      rlBattleSceneShowDarkness ; 96/F762

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the skill's colors (aUnknownE027EB) and starts battle scene script $3A; A is kept in $7FFC5F.

        phx
        sep #$20
        sta $7FFC5F
        rep #$20
        ldx #$0000

        _F76E
        lda aUnknownE027EB,x
        sta $02F4,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F76E
        lda #$003A
        jsl rlStartBattleSceneScript
        plx
        rtl

        .databank 0

        ; 96/F785

      rlBattleSceneShowPavise ; 96/F785

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the skill's colors (aUnknownE027F5) and starts battle scene script $3F; A is kept in $7FFC5F.

        phx
        sep #$20
        sta $7FFC5F
        rep #$20
        ldx #$0000

        _F791
        lda aUnknownE027F5,x
        sta $02F4,b,x
        inc x
        inc x
        cpx #$000A
        bcc _F791
        lda #$003F
        jsl rlStartBattleSceneScript
        plx
        rtl

        .databank 0

        ; 96/F7A8

    .endsection Unsorted96F697Section


    .section Unsorted96F7A8Section

      .al
      .xl

      rsUnknown96F7A8 ; 96/F7A8

        .al
        .xl
        .autsiz
        .databank ?

        lda wBattleType
        and #$00FF
        cmp #$00FF
        beq _F7BA
        jsl rlUnknown9198B3
        bra _F7BE


        _F7BA
        jsl rlUnknown9198D6

        _F7BE
        rts

        .databank 0

        ; 96/F7BF

      rlUnknown96F7BF ; 96/F7BF

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta $7FFC5D
        lda #$FF
        sta $7FFC5E
        sta $7FFC5F
        rep #$20
        rtl

        .databank 0

        ; 96/F7D4

    .endsection Unsorted96F7A8Section


