; The end of the first generation, after Arvis attacks Sigurd at the end of
; chapter 5 ("MS" proc, procFirstGenerationEnding): a text scrolls over the map
; ("かくして、ひとつの時代は終わった"), with portraits faded in and out by the world
; map portrait routines (which use rlLoadFirstGenerationEndingPortrait while
; wGameStateRoutine1 is 0). Its dialogue ASMCs list the first-generation characters
; who fell in battle (chapter 5 flag clear) and those whose fate is unknown (flag
; set). Bank $88.


    .section Unsorted88E02BSection

      .al
      .xl

      procFirstGenerationEnding ; 88/E02B

        .structProcInfo "MS", rlProcFirstGenerationEndingInit, rlProcFirstGenerationEndingUpload1, aProcFirstGenerationEndingCode

    .endsection Unsorted88E02BSection


    .section Unsorted88E033Section

      .al
      .xl

      rlProcFirstGenerationEndingInit ; 88/E033

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets up the text screen over the map, pauses the map animations, sets wGameStateRoutine1 to 0 (so world map portraits use rlLoadFirstGenerationEndingPortrait) and starts the HDMA.

        ldx #$01DE

        _E036
        lda aUnknown8CA620,x
        sta $7E9B88,x
        dec x
        dec x
        bpl _E036
        lda #$0000
        sta $7F8089
        ldx #$001C

        _E04C
        lda aWindowPalette+2,x
        sta $0102,b,x
        dec x
        dec x
        bpl _E04C
        jsl rlLoadDefaultWindowBorderPalette
        ldx #$07FE
        lda #$01FF

        _E061
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _E061
        ldx #$05FE
        lda #$030F

        _E06F
        sta $7E7D88,x
        dec x
        dec x
        bpl _E06F
        ldx #$01FE

        _E07A
        lda aUnknownD97C00,x
        sta aBG2TilemapBuffer.Page1,x
        dec x
        dec x
        bpl _E07A
        ldx #$07FE
        lda #$0000

        _E08C
        sta $7E8B88,x
        dec x
        dec x
        bpl _E08C
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        lda #$3800
        sta wR1
        lda #$0800
        sta wR0
        jsl rlDMAByPointer
        sep #$20
        lda #$17
        sta bBufferTM
        rep #$20
        stz wGameStateRoutine1,b
        stz wBufferBG3VOFS
        stz wBufferBG3HOFS
        lda #$FFD0
        sta wBufferBG2VOFS
        lda #$FFE0
        sta wBufferBG2HOFS
        jsl rlPauseMapSpriteAnimation
        jsl rlPauseMapTileAnimation
        stz wEpilogueRecordCharacter,b
        lda #(`aFirstGenerationEndingHDMAInfo)<<8
        sta lR44+1
        lda #<>aFirstGenerationEndingHDMAInfo
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rtl

        .databank 0

        ; 88/E0DF

      rlProcFirstGenerationEndingUpload1 ; 88/E0DF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0500, $80, $A800

        plx
        lda #<>rlProcFirstGenerationEndingUpload2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 88/E0F5

      rlProcFirstGenerationEndingUpload2 ; 88/E0F5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        plx
        lda #<>rlProcFirstGenerationEndingFadeIn
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 88/E10B

    .endsection Unsorted88E033Section


    .section Unsorted88E10BSection

      .al
      .xl

      rlProcFirstGenerationEndingFadeIn ; 88/E10B

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Fades the palette in, then starts the text dialogueEpilogueMemorial88E9E5.

        lda wEpilogueRecordCharacter,b
        cmp #$0040
        bcs _E116
        inc wEpilogueRecordCharacter,b

        _E116
        lda wVBlankEnabledFramecount
        and #$0007
        bne _E130
        lda #$0008
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .byte $88, $9B, $F0, $00, $20, $00

        bcs _E131

        _E130
        rtl


        _E131
        lda #<>rlProcFirstGenerationEndingText
        sta aProcSystem.aHeaderOnCycle,b,x
        jsl rlResetDialogueEngine
        lda #(`dialogueEpilogueMemorial88E9E5)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88E9E5
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsl rlSetFirstGenerationEndingTextPosition
        rtl

        .databank 0

        ; 88/E154

      rlProcFirstGenerationEndingText ; 88/E154

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs the text until it ends.

        lda aDialogue.wStatus,b
        beq _E172
        jsl rlDMAByStruct

          .structDMAToVRAM $7E87C8, $0300, $80, $B440

        lda wVBlankEnabledFramecount
        and #$0001
        bne _E171
        jsl rlUnknown9181F6

        _E171
        rtl


        _E172
        lda #<>rlProcFirstGenerationEndingFinish
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 88/E179

    .endsection Unsorted88E10BSection


    .section Unsorted88E179Section

      .al
      .xl

      rlProcFirstGenerationEndingFinish ; 88/E179

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Fades out, ends the proc, restores the map palettes and tilemaps and goes back to the map step.

        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _E186
        dec bBufferINIDISP
        rep #$20
        rtl


        _E186
        .as
        rep #$20
        jsl rlProcEngineFreeProc
        ldx #$01DE
        lda #$0000

        _E192
        sta aBGPaletteBuffer.aPalette1,b,x
        dec x
        dec x
        bpl _E192
        ldx #$001E

        _E19C
        lda aMapAndCastleSpriteOAMPalettes,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _E19C
        ldx #$07FE
        lda #$033F

        _E1AD
        sta aBG2TilemapBuffer.Page1,x
        dec x
        dec x
        bpl _E1AD
        ldx #$07FE
        lda #$01FF

        _E1BB
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _E1BB
        stz wBufferBG2VOFS
        stz wBufferBG2HOFS
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0800, $80, $B000

        jsl rlLoadMenuFontGraphics
        jsl rlEnableVBlank
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        lda #GAMESTATE_MAP_STEP
        sta wGameStateRoutine1,b
        rtl

        .databank 0

        ; 88/E1FE

    .endsection Unsorted88E179Section


    .section Unsorted88E1FESection

      .al
      .xl

      aProcFirstGenerationEndingCode ; 88/E1FE

        PROC_HALT


        ; 88/E200

    .endsection Unsorted88E1FESection


    .section ProcScript88E200Section

      .al
      .xl

      procFirstGenerationEndingPortraitFadeIn ; 88/E200

        .structProcInfo "MN", rlProcFirstGenerationEndingPortraitFadeInInit, rlProcFirstGenerationEndingPortraitFadeInCycle, aProcFirstGenerationEndingPortraitFadeInCode

    .endsection ProcScript88E200Section


    .section Unsorted88E208Section

      .al
      .xl

      rlProcFirstGenerationEndingPortraitFadeInInit ; 88/E208

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlSavePaletteBufferColorsToRAM

          .byte $88, $9B, $7E, $10, $00, $C0, $00

        ldx #$001E
        lda #$2DAD

        _E219
        sta aBGPaletteBuffer.aPalette6,b,x
        dec x
        dec x
        bpl _E219
        sep #$20
        lda #$51
        sta bBufferCGADSUB
        lda #$02
        sta bBufferCGWSEL
        lda #$15
        sta bBufferTM
        lda #$02
        sta bBufferTS
        rep #$20
        lda #$0000
        sta aPaletteFading.wCurrentStep,b
        rtl

        .databank 0

        ; 88/E23B

      rlProcFirstGenerationEndingPortraitFadeInCycle ; 88/E23B

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0001
        bne _E255
        lda #$0008
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .byte $88, $9B, $10, $00, $C0, $00

        bcs _E256

        _E255
        rtl


        _E256
        jsl rlProcEngineFreeProc
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        rep #$20
        bra _E255

        .databank 0

        ; 88/E268

    .endsection Unsorted88E208Section


    .section ProcScript88E268Section

      .al
      .xl

      aProcFirstGenerationEndingPortraitFadeInCode ; 88/E268

        PROC_HALT


        ; 88/E26A

      procFirstGenerationEndingPortraitFadeOut ; 88/E26A

        .structProcInfo "FF", rlProcFirstGenerationEndingPortraitFadeOutInit, rlProcFirstGenerationEndingPortraitFadeOutCycle, aProcFirstGenerationEndingPortraitFadeOutCode

    .endsection ProcScript88E268Section


    .section Unsorted88E272Section

      .al
      .xl

      rlProcFirstGenerationEndingPortraitFadeOutInit ; 88/E272

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aPaletteFading.wCurrentStep,b
        sep #$20
        lda #$51
        sta bBufferCGADSUB
        lda #$02
        sta bBufferCGWSEL
        lda #$15
        sta bBufferTM
        lda #$02
        sta bBufferTS
        rep #$20
        rtl

        .databank 0

        ; 88/E28D

      rlProcFirstGenerationEndingPortraitFadeOutCycle ; 88/E28D

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0001
        bne _E2A9
        lda #$2DAD
        sta aPaletteFading.wDesiredColor,b
        lda #$0008
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToBlack

          .byte $D6, $E2

        bcs _E2AA

        _E2A9
        rtl


        _E2AA
        jsl rlProcEngineFreeProc
        ldx #$07FE
        lda #$0000

        _E2B4
        sta $7E8B88,x
        dec x
        dec x
        bpl _E2B4
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18
        lda #$3800
        sta wR1
        lda #$0800
        sta wR0
        jsl rlDMAByPointer
        bra _E2A9

        .databank 0

        ; 88/E2D6

    .endsection Unsorted88E272Section


    .section ProcScript88E2DCSection

      .al
      .xl

      aProcFirstGenerationEndingPortraitFadeOutCode ; 88/E2DC

        PROC_HALT


        ; 88/E2DE

    .endsection ProcScript88E2DCSection


    .section Unsorted88E2E9Section

      .al
      .xl

      rlFirstGenerationEndingHDMA ; 88/E2E9

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$01
        sta @l $0008BC
        lda #$00
        sta @l $0008BD
        lda #$7F
        sta @l $0008BE
        lda bBufferTM
        sta @l $0008BF
        lda #$48
        sec
        sbc wEpilogueRecordCharacter,b
        sta @l $0008C0
        lda bBufferTM
        sta @l $0008C1
        lda wEpilogueRecordCharacter,b
        sta @l $0008C2
        lda #$04
        sta @l $0008C3
        lda #$10
        sta @l $0008C4
        lda #$00
        sta @l $0008C5
        lda #$00
        sta @l $0008C6
        lda #$00
        sta @l $0008C7
        rep #$20
        rtl

        .databank 0

        ; 88/E33B

    .endsection Unsorted88E2E9Section


    .section Unsorted88E33DSection

      .al
      .xl

      rlLoadFirstGenerationEndingPortrait ; 88/E33D

        .al
        .xl
        .autsiz
        .databank ?

        ; rlLoadWorldMapPortraitIntoSlot while wGameStateRoutine1 is 0: decompresses the portrait, copies its palette and graphics and fades it in.

        php
        phx
        jsl rlDecompressWorldMapPortraitToSlot
        lda #$0000
        sta lR20+1
        lda #$01C0
        sta lR20
        ldy #$001E

        _E350
        lda [lR19],y
        sta [lR20],y
        dec y
        dec y
        bpl _E350
        lda #$3800
        sta wR1
        lda #$0800
        sta wR0
        jsl rlDMAByPointer
        lda #(`procFirstGenerationEndingPortraitFadeIn)<<8
        sta lR44+1
        lda #<>procFirstGenerationEndingPortraitFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        plp
        rtl

        .databank 0

        ; 88/E377

      rlFadeOutFirstGenerationEndingPortrait ; 88/E377

        .al
        .xl
        .autsiz
        .databank ?

        ; rlFadeOutWorldMapPortraitSlot while wGameStateRoutine1 is 0.

        php
        phx
        lda #(`procFirstGenerationEndingPortraitFadeOut)<<8
        sta lR44+1
        lda #<>procFirstGenerationEndingPortraitFadeOut
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        plp
        rtl

        .databank 0

        ; 88/E38A

    .endsection Unsorted88E33DSection


    .section Unsorted88E38ASection

      .al
      .xl

      rlSetFirstGenerationEndingTextPosition ; 88/E38A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta aDialogue.wUnknown0018D0,b
        lda #$0480
        tsb aDialogue.wStatus,b
        lda #$0001
        sta aDialogue.wTextSpeed,b
        lda #$0004
        sta aDialogue.wUnknown00188C,b
        lda #$0040
        sta $18E1,b,x
        lda #$0200
        sta $18DD,b
        lda #$0A1E
        sta $18DB,b,x
        lda #$4000
        sta $18D7,b,x
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        sta $18D4,b,x
        lda #$2000
        sta aDialogue.wBaseTile,b,x
        lda #$01FF
        sta aDialogue.wClearTile,b
        lda #$1208
        sta wR1
        sep #$20
        lda #$00
        sta wR0+1
        xba
        lda wR1
        sta wR0
        lda wR1+1
        xba
        rep #$20
        lsr a
        lsr a
        clc
        adc wR0
        sta wR0
        ldx aDialogue,b
        lda #$7E00
        sta $18D5,b,x
        lda #$8388
        clc
        adc wR0
        sta $18D4,b,x
        rtl

        .databank 0

        ; 88/E401

    .endsection Unsorted88E38ASection


    .section Unsorted88E401Section

      .al
      .xl

      rsFirstGenerationEndingFindCharacter ; 88/E401

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; A = character: wSelectedUnitDataRAMPointer (also in A) = the player army's unit for it, or 0.

        sta wRoutineVariable1,b
        stz wR10
        lda #$0000
        jsl rlFindFactionUnitByCharacterID
        lda wSelectedUnitDataRAMPointer,b
        rts

        .databank 0

        ; 88/E411

      rlASMCFirstGenerationEndingMissingHeader ; 88/E411

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows dialogueEpilogueMemorial88EBFD ("those who were with Sigurd to the end ... fate unknown") if any of characters 2-24 is in the player army and not dead.

        lda #$0002

        _E414
        sta wRoutineVariable1,b
        lda #$0000
        jsl rlFindGenerationIDInFactionSlotData
        lda wSelectedUnitDataRAMPointer,b
        beq _E42C
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        beq _E436

        _E42C
        lda wRoutineVariable1,b
        inc a
        cmp #$0019
        bne _E414
        rtl


        _E436
        lda #$EBFD
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rtl

        .databank 0

        ; 88/E440

      rlASMCFirstGenerationEndingMissingNaoise ; 88/E440

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Naoise's line in the "fate unknown" list if Naoise is in the player army and chapter 5 event flag $14 is set.

        lda #$0002
        jsr rsFirstGenerationEndingFindCharacter
        beq _E465
        lda #$0014
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E465
        lda #(`dialogueEpilogueMemorial88EC34)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC34
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E465
        rtl

        .databank 0

        ; 88/E466

      rlASMCFirstGenerationEndingMissingAlec ; 88/E466

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Alec's line in the "fate unknown" list if Alec is in the player army and chapter 5 event flag $15 is set.

        lda #$0003
        jsr rsFirstGenerationEndingFindCharacter
        beq _E48B
        lda #$0015
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E48B
        lda #(`dialogueEpilogueMemorial88EC51)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC51
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E48B
        rtl

        .databank 0

        ; 88/E48C

      rlASMCFirstGenerationEndingMissingArden ; 88/E48C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Arden's line in the "fate unknown" list if Arden is in the player army and chapter 5 event flag $16 is set.

        lda #$0004
        jsr rsFirstGenerationEndingFindCharacter
        beq _E4B1
        lda #$0016
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E4B1
        lda #(`dialogueEpilogueMemorial88EC6C)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC6C
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E4B1
        rtl

        .databank 0

        ; 88/E4B2

      rlASMCFirstGenerationEndingMissingLex ; 88/E4B2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Lex's line in the "fate unknown" list if Lex is in the player army and chapter 5 event flag $1E is set.

        lda #$000E
        jsr rsFirstGenerationEndingFindCharacter
        beq _E4D7
        lda #$001E
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E4D7
        lda #(`dialogueEpilogueMemorial88EC8A)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC8A
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E4D7
        rtl

        .databank 0

        ; 88/E4D8

      rlASMCFirstGenerationEndingMissingAzelle ; 88/E4D8

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Azelle's line in the "fate unknown" list if Azelle is in the player army and chapter 5 event flag $1A is set.

        lda #$000A
        jsr rsFirstGenerationEndingFindCharacter
        beq _E4FD
        lda #$001A
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E4FD
        lda #(`dialogueEpilogueMemorial88ECA4)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECA4
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E4FD
        rtl

        .databank 0

        ; 88/E4FE

      rlASMCFirstGenerationEndingMissingAyra ; 88/E4FE

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Ayra's line in the "fate unknown" list if Ayra is in the player army and chapter 5 event flag $21 is set.

        lda #$0013
        jsr rsFirstGenerationEndingFindCharacter
        beq _E523
        lda #$0021
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E523
        lda #(`dialogueEpilogueMemorial88ECC0)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECC0
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E523
        rtl

        .databank 0

        ; 88/E524

      rlASMCFirstGenerationEndingMissingEdain ; 88/E524

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Edain's line in the "fate unknown" list if Edain is in the player army and chapter 5 event flag $2A is set.

        lda #$0017
        jsr rsFirstGenerationEndingFindCharacter
        beq _E549
        lda #$002A
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E549
        lda #(`dialogueEpilogueMemorial88ECDA)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECDA
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E549
        rtl

        .databank 0

        ; 88/E54A

      rlASMCFirstGenerationEndingMissingMidir ; 88/E54A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Midir's line in the "fate unknown" list if Midir is in the player army and chapter 5 event flag $17 is set.

        lda #$0007
        jsr rsFirstGenerationEndingFindCharacter
        beq _E56F
        lda #$0017
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E56F
        lda #(`dialogueEpilogueMemorial88ECF7)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECF7
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E56F
        rtl

        .databank 0

        ; 88/E570

      rlASMCFirstGenerationEndingMissingJamke ; 88/E570

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Jamke's line in the "fate unknown" list if Jamke is in the player army and chapter 5 event flag $1B is set.

        lda #$000B
        jsr rsFirstGenerationEndingFindCharacter
        beq _E595
        lda #$001B
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E595
        lda #(`dialogueEpilogueMemorial88ED16)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED16
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E595
        rtl

        .databank 0

        ; 88/E596

      rlASMCFirstGenerationEndingMissingLachesis ; 88/E596

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Lachesis's line in the "fate unknown" list if Lachesis is in the player army and chapter 5 event flag $20 is set.

        lda #$0012
        jsr rsFirstGenerationEndingFindCharacter
        beq _E5BB
        lda #$0020
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E5BB
        lda #(`dialogueEpilogueMemorial88ED32)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED32
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E5BB
        rtl

        .databank 0

        ; 88/E5BC

      rlASMCFirstGenerationEndingMissingBeowulf ; 88/E5BC

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Beowulf's line in the "fate unknown" list if Beowulf is in the player army and chapter 5 event flag $1D is set.

        lda #$000D
        jsr rsFirstGenerationEndingFindCharacter
        beq _E5E1
        lda #$001D
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E5E1
        lda #(`dialogueEpilogueMemorial88ED4E)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED4E
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E5E1
        rtl

        .databank 0

        ; 88/E5E2

      rlASMCFirstGenerationEndingMissingChulainn ; 88/E5E2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Chulainn's line in the "fate unknown" list if Chulainn is in the player army and chapter 5 event flag $19 is set.

        lda #$0009
        jsr rsFirstGenerationEndingFindCharacter
        beq _E607
        lda #$0019
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E607
        lda #(`dialogueEpilogueMemorial88ED68)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED68
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E607
        rtl

        .databank 0

        ; 88/E608

      rlASMCFirstGenerationEndingMissingDew ; 88/E608

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Dew's line in the "fate unknown" list if Dew is in the player army and chapter 5 event flag $1F is set.

        lda #$000F
        jsr rsFirstGenerationEndingFindCharacter
        beq _E62D
        lda #$001F
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E62D
        lda #(`dialogueEpilogueMemorial88ED7D)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED7D
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E62D
        rtl

        .databank 0

        ; 88/E62E

      rlASMCFirstGenerationEndingMissingLewyn ; 88/E62E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Lewyn's line in the "fate unknown" list if Lewyn is in the player army and chapter 5 event flag $18 is set.

        lda #$0008
        jsr rsFirstGenerationEndingFindCharacter
        beq _E653
        lda #$0018
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E653
        lda #(`dialogueEpilogueMemorial88ED92)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED92
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E653
        rtl

        .databank 0

        ; 88/E654

      rlASMCFirstGenerationEndingMissingErinys ; 88/E654

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Erinys's line in the "fate unknown" list if Erinys is in the player army and chapter 5 event flag $25 is set.

        lda #$0014
        jsr rsFirstGenerationEndingFindCharacter
        beq _E679
        lda #$0025
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E679
        lda #(`dialogueEpilogueMemorial88EDAD)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EDAD
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E679
        rtl

        .databank 0

        ; 88/E67A

      rlASMCFirstGenerationEndingMissingSilvia ; 88/E67A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Silvia's line in the "fate unknown" list if Silvia is in the player army and chapter 5 event flag $29 is set.

        lda #$0016
        jsr rsFirstGenerationEndingFindCharacter
        beq _E69F
        lda #$0029
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E69F
        lda #(`dialogueEpilogueMemorial88EDCC)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EDCC
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E69F
        rtl

        .databank 0

        ; 88/E6A0

      rlASMCFirstGenerationEndingMissingClaud ; 88/E6A0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Claud's line in the "fate unknown" list if Claud is in the player army and chapter 5 event flag $1C is set.

        lda #$000C
        jsr rsFirstGenerationEndingFindCharacter
        beq _E6C5
        lda #$001C
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E6C5
        lda #(`dialogueEpilogueMemorial88EDE9)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EDE9
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E6C5
        rtl

        .databank 0

        ; 88/E6C6

      rlASMCFirstGenerationEndingMissingTailtiu ; 88/E6C6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Tailtiu's line in the "fate unknown" list if Tailtiu is in the player army and chapter 5 event flag $2C is set.

        lda #$0015
        jsr rsFirstGenerationEndingFindCharacter
        beq _E6EB
        lda #$002C
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E6EB
        lda #(`dialogueEpilogueMemorial88EE03)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EE03
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E6EB
        rtl

        .databank 0

        ; 88/E6EC

      rlASMCFirstGenerationEndingMissingBrigid ; 88/E6EC

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Brigid's line in the "fate unknown" list if Brigid is in the player army and chapter 5 event flag $2B is set.

        lda #$0018
        jsr rsFirstGenerationEndingFindCharacter
        beq _E711
        lda #$002B
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E711
        lda #(`dialogueEpilogueMemorial88EE1F)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EE1F
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E711
        rtl

        .databank 0

        ; 88/E712

      rlASMCFirstGenerationEndingFallenNaoise ; 88/E712

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Naoise's line in the "fell in battle" list if Naoise is in the player army and chapter 5 event flag $14 is clear.

        lda #$0002
        jsr rsFirstGenerationEndingFindCharacter
        beq _E737
        lda #$0014
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E737
        lda #(`dialogueEpilogueMemorial88EC34)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC34
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E737
        rtl

        .databank 0

        ; 88/E738

      rlASMCFirstGenerationEndingFallenAlec ; 88/E738

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Alec's line in the "fell in battle" list if Alec is in the player army and chapter 5 event flag $15 is clear.

        lda #$0003
        jsr rsFirstGenerationEndingFindCharacter
        beq _E75D
        lda #$0015
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E75D
        lda #(`dialogueEpilogueMemorial88EC51)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC51
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E75D
        rtl

        .databank 0

        ; 88/E75E

      rlASMCFirstGenerationEndingFallenArden ; 88/E75E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Arden's line in the "fell in battle" list if Arden is in the player army and chapter 5 event flag $16 is clear.

        lda #$0004
        jsr rsFirstGenerationEndingFindCharacter
        beq _E783
        lda #$0016
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E783
        lda #(`dialogueEpilogueMemorial88EC6C)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC6C
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E783
        rtl

        .databank 0

        ; 88/E784

      rlASMCFirstGenerationEndingFallenLex ; 88/E784

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Lex's line in the "fell in battle" list if Lex is in the player army and chapter 5 event flag $1E is clear.

        lda #$000E
        jsr rsFirstGenerationEndingFindCharacter
        beq _E7A9
        lda #$001E
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E7A9
        lda #(`dialogueEpilogueMemorial88EC8A)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EC8A
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E7A9
        rtl

        .databank 0

        ; 88/E7AA

      rlASMCFirstGenerationEndingFallenAzelle ; 88/E7AA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Azelle's line in the "fell in battle" list if Azelle is in the player army and chapter 5 event flag $1A is clear.

        lda #$000A
        jsr rsFirstGenerationEndingFindCharacter
        beq _E7CF
        lda #$001A
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E7CF
        lda #(`dialogueEpilogueMemorial88ECA4)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECA4
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E7CF
        rtl

        .databank 0

        ; 88/E7D0

      rlASMCFirstGenerationEndingFallenAyra ; 88/E7D0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Ayra's line in the "fell in battle" list if Ayra is in the player army and chapter 5 event flag $21 is clear.

        lda #$0013
        jsr rsFirstGenerationEndingFindCharacter
        beq _E7F5
        lda #$0021
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E7F5
        lda #(`dialogueEpilogueMemorial88ECC0)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECC0
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E7F5
        rtl

        .databank 0

        ; 88/E7F6

      rlASMCFirstGenerationEndingFallenEdain ; 88/E7F6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Edain's line in the "fell in battle" list if Edain is in the player army and chapter 5 event flag $2A is clear.

        lda #$0017
        jsr rsFirstGenerationEndingFindCharacter
        beq _E81B
        lda #$002A
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E81B
        lda #(`dialogueEpilogueMemorial88ECDA)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECDA
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E81B
        rtl

        .databank 0

        ; 88/E81C

      rlASMCFirstGenerationEndingFallenMidir ; 88/E81C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Midir's line in the "fell in battle" list if Midir is in the player army and chapter 5 event flag $17 is clear.

        lda #$0007
        jsr rsFirstGenerationEndingFindCharacter
        beq _E841
        lda #$0017
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E841
        lda #(`dialogueEpilogueMemorial88ECF7)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ECF7
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E841
        rtl

        .databank 0

        ; 88/E842

      rlASMCFirstGenerationEndingFallenJamke ; 88/E842

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Jamke's line in the "fell in battle" list if Jamke is in the player army and chapter 5 event flag $1B is clear.

        lda #$000B
        jsr rsFirstGenerationEndingFindCharacter
        beq _E867
        lda #$001B
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E867
        lda #(`dialogueEpilogueMemorial88ED16)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED16
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E867
        rtl

        .databank 0

        ; 88/E868

      rlASMCFirstGenerationEndingFallenLachesis ; 88/E868

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Lachesis's line in the "fell in battle" list if Lachesis is in the player army and chapter 5 event flag $20 is clear.

        lda #$0012
        jsr rsFirstGenerationEndingFindCharacter
        beq _E88D
        lda #$0020
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E88D
        lda #(`dialogueEpilogueMemorial88ED32)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED32
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E88D
        rtl

        .databank 0

        ; 88/E88E

      rlASMCFirstGenerationEndingFallenBeowulf ; 88/E88E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Beowulf's line in the "fell in battle" list if Beowulf is in the player army and chapter 5 event flag $1D is clear.

        lda #$000D
        jsr rsFirstGenerationEndingFindCharacter
        beq _E8B3
        lda #$001D
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E8B3
        lda #(`dialogueEpilogueMemorial88ED4E)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED4E
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E8B3
        rtl

        .databank 0

        ; 88/E8B4

      rlASMCFirstGenerationEndingFallenChulainn ; 88/E8B4

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Chulainn's line in the "fell in battle" list if Chulainn is in the player army and chapter 5 event flag $19 is clear.

        lda #$0009
        jsr rsFirstGenerationEndingFindCharacter
        beq _E8D9
        lda #$0019
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E8D9
        lda #(`dialogueEpilogueMemorial88ED68)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED68
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E8D9
        rtl

        .databank 0

        ; 88/E8DA

      rlASMCFirstGenerationEndingFallenDew ; 88/E8DA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Dew's line in the "fell in battle" list if Dew is in the player army and chapter 5 event flag $1F is clear.

        lda #$000F
        jsr rsFirstGenerationEndingFindCharacter
        beq _E8FF
        lda #$001F
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E8FF
        lda #(`dialogueEpilogueMemorial88ED7D)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED7D
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E8FF
        rtl

        .databank 0

        ; 88/E900

      rlASMCFirstGenerationEndingFallenLewyn ; 88/E900

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Lewyn's line in the "fell in battle" list if Lewyn is in the player army and chapter 5 event flag $18 is clear.

        lda #$0008
        jsr rsFirstGenerationEndingFindCharacter
        beq _E925
        lda #$0018
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E925
        lda #(`dialogueEpilogueMemorial88ED92)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88ED92
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E925
        rtl

        .databank 0

        ; 88/E926

      rlASMCFirstGenerationEndingFallenErinys ; 88/E926

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Erinys's line in the "fell in battle" list if Erinys is in the player army and chapter 5 event flag $25 is clear.

        lda #$0014
        jsr rsFirstGenerationEndingFindCharacter
        beq _E94B
        lda #$0025
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E94B
        lda #(`dialogueEpilogueMemorial88EDAD)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EDAD
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E94B
        rtl

        .databank 0

        ; 88/E94C

      rlASMCFirstGenerationEndingFallenSilvia ; 88/E94C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Silvia's line in the "fell in battle" list if Silvia is in the player army and chapter 5 event flag $29 is clear.

        lda #$0016
        jsr rsFirstGenerationEndingFindCharacter
        beq _E971
        lda #$0029
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E971
        lda #(`dialogueEpilogueMemorial88EDCC)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EDCC
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E971
        rtl

        .databank 0

        ; 88/E972

      rlASMCFirstGenerationEndingFallenClaud ; 88/E972

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Claud's line in the "fell in battle" list if Claud is in the player army and chapter 5 event flag $1C is clear.

        lda #$000C
        jsr rsFirstGenerationEndingFindCharacter
        beq _E997
        lda #$001C
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E997
        lda #(`dialogueEpilogueMemorial88EDE9)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EDE9
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E997
        rtl

        .databank 0

        ; 88/E998

      rlASMCFirstGenerationEndingFallenTailtiu ; 88/E998

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Tailtiu's line in the "fell in battle" list if Tailtiu is in the player army and chapter 5 event flag $2C is clear.

        lda #$0015
        jsr rsFirstGenerationEndingFindCharacter
        beq _E9BD
        lda #$002C
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E9BD
        lda #(`dialogueEpilogueMemorial88EE03)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EE03
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E9BD
        rtl

        .databank 0

        ; 88/E9BE

      rlASMCFirstGenerationEndingFallenBrigid ; 88/E9BE

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shows Brigid's line in the "fell in battle" list if Brigid is in the player army and chapter 5 event flag $2B is clear.

        lda #$0018
        jsr rsFirstGenerationEndingFindCharacter
        beq _E9E3
        lda #$002B
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E9E3
        lda #(`dialogueEpilogueMemorial88EE1F)<<8
        sta lR18+1
        lda #<>dialogueEpilogueMemorial88EE1F
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E9E3
        rtl

        .databank 0

        ; 88/E9E4

    .endsection Unsorted88E401Section


    .section Table88E9E4Section

      .al
      .xl

        .byte $01 ; 88/E9E4

      dialogueEpilogueMemorial88E9E5 .include "../../text/dialogue/Epilogue/Memorial88E9E5.dialogue.txt" ; 88/E9E5
      dialogueEpilogueMemorial88EBFD .include "../../text/dialogue/Epilogue/Memorial88EBFD.dialogue.txt" ; 88/EBFD
      dialogueEpilogueMemorial88EC34 .include "../../text/dialogue/Epilogue/Memorial88EC34.dialogue.txt" ; 88/EC34
      dialogueEpilogueMemorial88EC51 .include "../../text/dialogue/Epilogue/Memorial88EC51.dialogue.txt" ; 88/EC51
      dialogueEpilogueMemorial88EC6C .include "../../text/dialogue/Epilogue/Memorial88EC6C.dialogue.txt" ; 88/EC6C
      dialogueEpilogueMemorial88EC8A .include "../../text/dialogue/Epilogue/Memorial88EC8A.dialogue.txt" ; 88/EC8A
      dialogueEpilogueMemorial88ECA4 .include "../../text/dialogue/Epilogue/Memorial88ECA4.dialogue.txt" ; 88/ECA4
      dialogueEpilogueMemorial88ECC0 .include "../../text/dialogue/Epilogue/Memorial88ECC0.dialogue.txt" ; 88/ECC0
      dialogueEpilogueMemorial88ECDA .include "../../text/dialogue/Epilogue/Memorial88ECDA.dialogue.txt" ; 88/ECDA
      dialogueEpilogueMemorial88ECF7 .include "../../text/dialogue/Epilogue/Memorial88ECF7.dialogue.txt" ; 88/ECF7
      dialogueEpilogueMemorial88ED16 .include "../../text/dialogue/Epilogue/Memorial88ED16.dialogue.txt" ; 88/ED16
      dialogueEpilogueMemorial88ED32 .include "../../text/dialogue/Epilogue/Memorial88ED32.dialogue.txt" ; 88/ED32
      dialogueEpilogueMemorial88ED4E .include "../../text/dialogue/Epilogue/Memorial88ED4E.dialogue.txt" ; 88/ED4E
      dialogueEpilogueMemorial88ED68 .include "../../text/dialogue/Epilogue/Memorial88ED68.dialogue.txt" ; 88/ED68
      dialogueEpilogueMemorial88ED7D .include "../../text/dialogue/Epilogue/Memorial88ED7D.dialogue.txt" ; 88/ED7D
      dialogueEpilogueMemorial88ED92 .include "../../text/dialogue/Epilogue/Memorial88ED92.dialogue.txt" ; 88/ED92
      dialogueEpilogueMemorial88EDAD .include "../../text/dialogue/Epilogue/Memorial88EDAD.dialogue.txt" ; 88/EDAD
      dialogueEpilogueMemorial88EDCC .include "../../text/dialogue/Epilogue/Memorial88EDCC.dialogue.txt" ; 88/EDCC
      dialogueEpilogueMemorial88EDE9 .include "../../text/dialogue/Epilogue/Memorial88EDE9.dialogue.txt" ; 88/EDE9
      dialogueEpilogueMemorial88EE03 .include "../../text/dialogue/Epilogue/Memorial88EE03.dialogue.txt" ; 88/EE03
      dialogueEpilogueMemorial88EE1F .include "../../text/dialogue/Epilogue/Memorial88EE1F.dialogue.txt" ; 88/EE1F

    .endsection Table88E9E4Section


    .section Table88E2DESection

      .al
      .xl

      aFirstGenerationEndingHDMAInfo .dstruct structHDMADirectEntryInfo, rlFirstGenerationEndingHDMA, rlFirstGenerationEndingHDMA, $E33B, $0008BC, PPU_REG_BASE + $2C, $00 ; 88/E2DE

    .endsection Table88E2DESection



