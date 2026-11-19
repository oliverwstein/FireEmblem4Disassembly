; The skill window: map menu option スキル (Skill). Lists 18 skills with each
; one's name, description and the player's units that have it (holding Select
; while it opens also counts skills that come from items). Opened by
; rsSkillWindowOpen, then run by game state routines $2C (rlSkillWindowRender),
; $2D (rlSkillWindowShow) and $2E (rlSkillWindowRunStep). Code in banks $80 and
; $8B; its variables are at $7F8185 (include/WRAM.h).


    .section Unsorted80D2C6Section

      .al
      .xl

      rsSkillWindowOpen ; 80/D2C6

        .al
        .xl
        .autsiz
        .databank ?

        ; Main loop routine that opens the skill window (map menu option スキル, through rlMapMenuOpenSkillWindow): resets the screen and the engines, builds the lists and draws them, then runs game state routines $2C-$2E.

        php
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #<>rsUnknown80BB9B
        sta wVBlankPointer
        jsl rlHaltUntilVBlank
        jsl rlDisableVBlank
        jsl rlHardwareResetScreenPosMathHDMA
        jsl rlHardwareResetScreenRegisters
        lda #$0000
        sta wR1
        lda #$0000
        sta wR2
        lda #$0000
        sta wR3
        lda #$4000
        sta wR5
        lda #$1800
        sta wR6
        lda #$2000
        sta wR7
        lda #$2800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        jsl rlClearUnitWindowAndTerrainWindowProcs
        jsl rlActiveSpriteEngineReset
        jsl rlResetHDMAEngine
        jsl rlResetIRQEngine
        jsr rsSkillWindowInitializeVariables
        jsr rsSkillWindowCopyGraphics
        jsr rsSkillWindowSetBGSettings
        jsr rsSkillWindowCreateHDMA
        jsr rsSkillWindowDrawSkillList
        jsr rsSkillWindowDrawHeader
        phk
        plb
        .databank $80
        lda #$002D
        sta wGameStateRoutine1,b
        lda #$002C
        sta wGameStateRoutine2,b
        lda #<>rsUnknown809D4F
        sta wMainLoopPointer
        jsl rlEnableVBlank
        plp
        rts

        .databank 0

        ; 80/D346

      rsSkillWindowInitializeVariables ; 80/D346

        .al
        .xl
        .autsiz
        .databank ?

        ; First skill selected, at the top, then the unit list and each skill's holders.

        lda #$0000
        sta wGameStateStep,b
        sta $7F8183
        sta wSkillWindowCurrentSkill
        sta wSkillWindowCursorRow
        sta wSkillWindowScrolledLines
        sta wSkillWindowCursorMoveDirection
        sta wSkillWindowScrollDirection
        sta wSkillWindowHolderScroll
        sta $7F873F
        sta wSkillWindowHolderScrollDirection
        lda #$001C
        sta wSkillWindowCursorYCoordinate
        lda #$0000
        jsl rlGetFactionSlotUnitCount
        sta wSkillWindowUnitCount
        jsr rsSkillWindowGetUnits
        jsr rsSkillWindowGetSkillHolders
        rts

        .databank 0

        ; 80/D389

      rsSkillWindowCopyGraphics ; 80/D389

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM $DE44C0, $0400, $80, $8000

        jsl rlDMAByStruct

          .structDMAToVRAM $DE34C0, $0C00, $80, $8400

        jsl rlDMAByStruct

          .structDMAToVRAM $DD72B0, $0C00, $80, $6000

        lda #$8000
        sta lR19+1
        lda #$D41D
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM $DE48C0, $1800, $80, $1800

        ldx #$0200

        _D3CE
        lda $DDFFFE,x
        sta wJoy2RepeatTimer,x
        dec x
        dec x
        bne _D3CE
        ldx #$0020

        _D3DB
        lda $DE00BE,x
        sta $025E,b,x
        dec x
        dec x
        bne _D3DB
        lda #$0000
        sta aBGPaletteBuffer,b
        lda #$030F
        jsl rlUnitWindowFillBG3Buffer
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $1000, $80, $5000

        lda #$8000
        sta lR19+1
        lda #$D425
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #$8000
        sta lR19+1
        lda #$D42D
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rts

        .databank 0

        ; 80/D41D

    .endsection Unsorted80D2C6Section


    .section Unsorted80D435Section

      .al
      .xl

      rsSkillWindowSetBGSettings ; 80/D435

        .al
        .xl
        .autsiz
        .databank ?

        ; Layers, windows and colour math; the same values as rsItemWindowSetBGSettings.

        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferTMW
        lda #$00
        sta bBufferTSW
        lda #$00
        sta bBufferW12SEL
        lda #$00
        sta bBufferW34SEL
        lda #$00
        sta bBufferWOBJSEL
        lda #$00
        sta bBufferWH0
        lda #$FF
        sta bBufferWH1
        lda #$00
        sta bBufferWH2
        sta bBufferWH3
        lda #$00
        sta bBufferWBGLOG
        sta bBufferWOBJLOG
        lda #$00
        sta bBufferCGWSEL
        lda #$83
        sta bBufferCGADSUB
        rep #$20
        stz wBufferBG1HOFS
        stz wBufferBG2HOFS
        stz wBufferBG3HOFS
        stz wBufferBG1VOFS
        stz wBufferBG2VOFS
        stz wBufferBG3VOFS
        rts

        .databank 0

        ; 80/D47E

      rsSkillWindowCreateHDMA ; 80/D47E

        .al
        .xl
        .autsiz
        .databank ?

        ; The same COLDATA HDMA entry as rsItemWindowCreateHDMA ($80/D07E).

        lda #$8000
        sta lR44+1
        lda #$D07E
        sta lR44
        jsl rlHDMAEngineCreateEntry
        rts

        .databank 0

        ; 80/D48D

      rsSkillWindowDrawHeader ; 80/D48D

        .al
        .xl
        .autsiz
        .databank ?

        ; The labels, the visible skill rows, and the selected skill's name, description and holders.

        lda #$3C00
        sta wR1
        lda #$02E6
        sta wR2
        lda #$0003
        sta wR0
        ldx #$0048
        jsl rlDrawBG3TileRun
        lda #$3C00
        sta wR1
        lda #$02E9
        sta wR2
        lda #$0003
        sta wR0
        ldx #$0056
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$026F
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0066
        jsl rlDrawBG3TileRun
        lda #$3000
        sta wR1
        lda #$0280
        sta wR2
        lda #$0009
        sta wR0
        ldx #$0068
        jsl rlDrawBG3TileRun
        jsl rlSkillWindowCopyVisibleRows
        jsl rlSkillWindowDrawSkillName
        jsl rlSkillWindowDrawSkillDescription
        jsl rlSkillWindowDrawHolderNames
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 80/D503

      rsSkillWindowDrawSkillList ; 80/D503

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the names of the 18 skills into aSkillWindowSkillListTilemap.

        lda #$0000
        ldx #$0800

        _D509
        sta aSkillWindowSkillListTilemap,x
        dec x
        dec x
        bne _D509
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$D8F1
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8000
        sta lR18+1
        lda #$D662
        sta lR18
        ldx #$0000
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D67A
        sta lR18
        ldx #$0200
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D692
        sta lR18
        ldx #$0400
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D6AA
        sta lR18
        ldx #$0600
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D6C2
        sta lR18
        ldx #$0800
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D6DA
        sta lR18
        ldx #$0A00
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D6F2
        sta lR18
        ldx #$0C00
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D70A
        sta lR18
        ldx #$0E00
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D722
        sta lR18
        ldx #$1000
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D73A
        sta lR18
        ldx #$1200
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D752
        sta lR18
        ldx #$1400
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D76A
        sta lR18
        ldx #$1600
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D782
        sta lR18
        ldx #$1800
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D79C
        sta lR18
        ldx #$1A00
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D7B6
        sta lR18
        ldx #$1C00
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D7D0
        sta lR18
        ldx #$1E00
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D7E8
        sta lR18
        ldx #$2000
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lR18+1
        lda #$D800
        sta lR18
        ldx #$2200
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$D8E8
        sta lMapMenuTilemapRAMEntryPointer,b
        rts

        .databank 0

        ; 80/D662

    .endsection Unsorted80D435Section


    .section Unsorted80D818Section

      .al
      .xl

      rsSkillWindowGetUnits ; 80/D818

        .al
        .xl
        .autsiz
        .databank ?

        ; The living, non-captive units of faction slot 0, in aSkillWindowUnits.

        lda #$0001
        sta wRoutineVariable1,b
        stz wR0

        _D820
        lda #$0000
        jsl rlGetUnitRAMDataPointerByFactionSlotEntryID
        lda wSelectedUnitDataRAMPointer,b
        beq _D84B
        jsl rlGetSelectedUnitStatus
        cmp #StatusCaptive
        beq _D84B
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        bne _D84B
        lda wR0
        asl a
        tax
        lda wSelectedUnitDataRAMPointer,b
        sta aSkillWindowUnits,x
        inc wR0

        _D84B
        inc wRoutineVariable1,b
        lda wRoutineVariable1,b
        cmp #$0019
        bne _D820
        lda wR0
        asl a
        tax
        lda #$0000
        sta aSkillWindowUnits,x
        rts

        .databank 0

        ; 80/D862

      rsSkillWindowGetSkillHolders ; 80/D862

        .al
        .xl
        .autsiz
        .databank ?

        ; For each of the 18 skills (the IDs at $8BDFBF), the units that have it as a personal or class skill, or, while Select is held, from an item: aSkillWindowSkillHolders, 32 words per skill, with the counts in aSkillWindowHolderCounts.

        lda #$0000
        tax

        _D866
        sta aSkillWindowSkillHolders,x
        inc x
        inc x
        cpx #$0540
        bne _D866
        ldx #$0000

        _D874
        sta aSkillWindowHolderCounts,x
        inc x
        inc x
        cpx #$002A
        bne _D874
        stz wR15

        _D881
        stz wR14
        stz wR13
        lda wR15
        asl a
        tax
        lda $8BDFBF,x
        sta wSkillWindowSkillID

        _D891
        lda wR14
        asl a
        tax
        lda aSkillWindowUnits,x
        beq _D8D4
        sta wSelectedUnitDataRAMPointer,b
        lda wSkillWindowSkillID
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _D8B9
        lda wJoy1Input
        bit #$2000
        beq _D8D0
        lda wSkillWindowSkillID
        jsl rlCheckIfInventoryItemsHaveSpecifiedSkill
        bcc _D8D0

        _D8B9
        lda wR15
        xba
        lsr a
        lsr a
        sta wR12
        lda wR13
        asl a
        clc
        adc wR12
        tax
        lda wSelectedUnitDataRAMPointer,b
        sta aSkillWindowSkillHolders,x
        inc wR13

        _D8D0
        inc wR14
        bra _D891


        _D8D4
        lda wR15
        asl a
        tax
        lda wR13
        sta aSkillWindowHolderCounts,x
        inc wR15
        lda wR15
        cmp #$0012
        bne _D881
        rts

        .databank 0

        ; 80/D8E8

    .endsection Unsorted80D818Section


    .section Unsorted8BD794Section

      .al
      .xl

      rlSkillWindowShow ; 8B/D794

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $2D, once: turns on the active sprite engine and fades in.

        jsl rlEnableActiveSpriteEngine
        inc wGameStateRoutine1,b
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 8B/D7AA

      rlSkillWindowRunStep ; 8B/D7AA

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $2E, every frame: runs the routine for wGameStateStep from aSkillWindowStepHandlers (0 input, 1 nothing while fading out).

        phb
        php
        phk
        plb
        .databank $8B
        lda wGameStateStep,b
        asl a
        tax
        jsr (aSkillWindowStepHandlers,x)
        plp
        plb
        .databank $8B
        rtl

        .databank 0

        ; 8B/D7B9

    .endsection Unsorted8BD794Section


    .section Table8BD7B9Section

      .al
      .xl

      aSkillWindowStepHandlers ; 8B/D7B9

        ; One per wGameStateStep.
        .word <>rsSkillWindowHandleInput
        .word <>rsSkillWindowWaitStep

    .endsection Table8BD7B9Section


    .section Unsorted8BD7BDSection

      .al
      .xl

      rsSkillWindowHandleInput ; 8B/D7BD

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 0. Finishes cursor moves and scrolling; B closes (fading into rsUnknown80B122, or through rlUnknown80BB7C when bit 5 of wUnknown000D79 is set), up and down move between skills, right and left show more of a skill's holders when it has over 12.

        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _D7FC
        lda wSkillWindowCursorMoveDirection
        bmi _D7FD
        bne _D801
        lda wSkillWindowScrollDirection
        bmi _D805
        bne _D809
        lda wSkillWindowHolderScrollDirection
        bmi _D811
        bne _D80D
        lda wJoy1New
        bit #$8000
        bne _D821
        bit #$0100
        bne _D856
        bit #$0200
        bne _D81D
        lda wJoy1Repeated
        bit #$0800
        bne _D819
        bit #$0400
        bne _D815

        _D7FC
        rts


        _D7FD
        jml rsSkillWindowFinishMoveUp


        _D801
        jml rsSkillWindowFinishMoveDown


        _D805
        jml rsSkillWindowFinishScrollUp


        _D809
        jml rsSkillWindowFinishScrollDown


        _D80D
        jml _D8A8


        _D811
        jml _D8DF


        _D815
        jml rsSkillWindowMoveDown


        _D819
        jml rsSkillWindowMoveUp


        _D81D
        jml _D887


        _D821
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0001
        sta wGameStateStep,b
        lda wUnknown000D79,b
        bit #$0020
        bne _D851
        lda #$0000
        sta $0D77,b
        lda #$B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _D851
        jsl rlUnknown80BB7C
        rts


        _D856
        lda wSkillWindowCurrentSkill
        asl a
        tax
        lda aSkillWindowHolderCounts,x
        cmp #$000D
        bcc _D886
        lda wSkillWindowHolderScroll
        bne _D886
        lda #$0007
        jsl rlPlaySoundEffect
        lda #$0001
        sta wSkillWindowHolderScroll
        lda #$0001
        sta wSkillWindowHolderScrollDirection
        jsr rsSkillWindowDrawAllHolderNames
        jsr rsSkillWindowCopyVisibleHolders

        _D886
        rts


        _D887
        lda wSkillWindowHolderScroll
        beq _D8A7
        lda #$0007
        jsl rlPlaySoundEffect
        lda #$FFFF
        sta wSkillWindowHolderScrollDirection
        lda wSkillWindowHolderScroll
        dec a
        sta wSkillWindowHolderScroll
        jsr rsSkillWindowCopyVisibleHolders

        _D8A7
        rts


        _D8A8
        lda wSkillWindowHolderScroll
        inc a
        sta wSkillWindowHolderScroll
        jsr rsSkillWindowCopyVisibleHolders
        lda wSkillWindowCurrentSkill
        asl a
        tax
        lda aSkillWindowHolderCounts,x
        cmp #$0013
        bcc _D8CE
        lda wSkillWindowHolderScroll
        cmp #$000C
        bne _D8DE
        bra _D8D7


        _D8CE
        lda wSkillWindowHolderScroll
        cmp #$0006
        bne _D8DE

        _D8D7
        lda #$0000
        sta wSkillWindowHolderScrollDirection

        _D8DE
        rts


        _D8DF
        lda wSkillWindowHolderScroll
        dec a
        sta wSkillWindowHolderScroll
        jsr rsSkillWindowCopyVisibleHolders
        lda wSkillWindowHolderScroll
        bne _D8FC
        lda #$0000
        sta wSkillWindowHolderScrollDirection
        sta wSkillWindowHolderScroll

        _D8FC
        rts

        .databank 0

        ; 8B/D8FD

      rsSkillWindowWaitStep ; 8B/D8FD

        .al
        .xl
        .autsiz
        .databank ?

        ; Step 1: nothing, while the window fades out.

        rts

        .databank 0

        ; 8B/D8FE

    .endsection Unsorted8BD7BDSection


    .section Unsorted8BD8FESection

      .al
      .xl

      rlSkillWindowRender ; 8B/D8FE

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $2C, every frame: the sprites, the selected skill's icon, the cursor and the arrows.

        jsr rsSkillWindowRenderBG2Sprites
        jsr rsSkillWindowRenderSkillIcon
        jsr rsSkillWindowRenderCursor
        jsr rsSkillWindowRenderArrows
        rtl

        .databank 0

        ; 8B/D90B

    .endsection Unsorted8BD8FESection


    .section Unsorted8BD90BSection

      .al
      .xl

      rlSkillWindowCopyVisibleRows ; 8B/D90B

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the 12 visible rows of the skill list, from wSkillWindowScrolledLines, into BG3.

        lda wSkillWindowScrolledLines
        xba
        lsr a
        lsr a
        lsr a
        sta wR1
        lda #$00C8
        sta wR0
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        lda #$000C
        sta wR4

        _D927
        lda #$000C
        sta wR15
        sta wR14
        ldx wR1
        ldy wR0

        _D932
        lda aSkillWindowSkillListTilemap,x
        sta aBG3TilemapBuffer,y
        inc x
        inc x
        inc y
        inc y
        dec wR15
        bpl _D932
        ldx wR1
        ldy wR0

        _D945
        lda $7F87AD,x
        sta $83C8,b,y
        inc x
        inc x
        inc y
        inc y
        dec wR14
        bpl _D945
        lda wR1
        clc
        adc #$0040
        sta wR1
        lda wR0
        adc #$0080
        sta wR0
        dec wR4
        bne _D927
        rtl

        .databank 0

        ; 8B/D968

      rlSkillWindowDrawSkillName ; 8B/D968

        .al
        .xl
        .autsiz
        .databank ?

        ; The selected skill's name, from the long pointers at $89AC56 by skill ID.

        ldx #$0126
        lda #$0017
        ldy #$000B
        jsl rlClearTilemapRect
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$D8E8
        sta lMapMenuTilemapRAMEntryPointer,b
        lda wSkillWindowCurrentSkill
        asl a
        tax
        lda $8BDFBF,x
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89AC57,x
        sta lR18+1
        lda $89AC56,x
        sta lR18
        ldx #$0415
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

        ; 8B/D9A6

      rlSkillWindowDrawSkillDescription ; 8B/D9A6

        .al
        .xl
        .autsiz
        .databank ?

        ; The selected skill's description, from aSkillDescriptionPointers by skill ID.

        lda #$0000
        ldx #$0100

        _D9AC
        sta aSkillWindowDescriptionTilemap,x
        dec x
        dec x
        bne _D9AC
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$D8FA
        sta lMapMenuTilemapRAMEntryPointer,b
        lda wSkillWindowCurrentSkill
        asl a
        tax
        lda $8BDFBF,x
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89ABFA,x
        sta lR18+1
        lda aSkillDescriptionPointers,x
        sta lR18
        ldx #$0000
        jsl rlDrawMenuTextLine
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        ldx #$0014

        _D9EF
        lda aSkillWindowDescriptionTilemap,x
        sta $856C,b,x
        lda $7F8FDB,x
        sta $85AC,b,x
        dec x
        dec x
        bne _D9EF
        ldx #$0014

        _DA04
        lda $7F8F9F,x
        sta $85EC,b,x
        lda $7F8FEF,x
        sta $862C,b,x
        dec x
        dec x
        bne _DA04
        ldx #$0014

        _DA19
        lda $7F8FB3,x
        sta $866C,b,x
        lda $7F9003,x
        sta $86AC,b,x
        dec x
        dec x
        bne _DA19
        rtl

        .databank 0

        ; 8B/DA2C

      rlSkillWindowDrawHolderNames ; 8B/DA2C

        .al
        .xl
        .autsiz
        .databank ?

        ; The first 12 holders of the selected skill, or the text at $8BDFA9 if there are none.

        lda #$0000
        sta wSkillWindowHolderScroll
        lda #$8000
        sta @l lMapMenuTilemapRAMEntryPointer+1
        lda #$D8E8
        sta @l lMapMenuTilemapRAMEntryPointer
        lda wSkillWindowCurrentSkill
        xba
        lsr a
        lsr a
        sta wR1
        stz wR0

        _DA4C
        ldx wR1
        lda aSkillWindowSkillHolders,x
        beq _DA82
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitNamePointer
        lda wR0
        asl a
        tax
        lda $8BDA9C,x
        tax
        lda @l lRoutineVariable
        sta lR18
        lda @l lRoutineVariable+1
        sta lR18+1
        jsl rlDrawMenuTextLine
        inc wR1
        inc wR1
        inc wR0
        lda wR0
        cmp #$000C
        bne _DA4C

        _DA82
        lda wR0
        bne _DA9B
        lda #$8B00
        sta @l lR18+1
        lda #$DFA9
        sta @l lR18
        ldx #$1313
        jsl rlDrawMenuTextLine

        _DA9B
        rtl

        .databank 0

        ; 8B/DA9C

    .endsection Unsorted8BD90BSection


    .section Unsorted8BDAB4Section

      .al
      .xl

      rsSkillWindowRenderBG2Sprites ; 8B/DAB4

        .al
        .xl
        .autsiz
        .databank ?

        ; Three sprite groups that scroll with BG2.

        lda #$0019
        sec
        sbc wBufferBG2VOFS
        sta wR1
        stz wR0
        stz wR4
        stz wR5
        ldy #$DAF4
        jsl rlPushToOAMBuffer
        lda #$0089
        sec
        sbc wBufferBG2VOFS
        sta wR1
        stz wR0
        stz wR4
        stz wR5
        ldy #$DB19
        jsl rlPushToOAMBuffer
        lda #$0109
        sec
        sbc wBufferBG2VOFS
        sta wR1
        stz wR0
        stz wR4
        stz wR5
        ldy #$DB43
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 8B/DAF4

    .endsection Unsorted8BDAB4Section


    .section Unsorted8BDB54Section

      .al
      .xl

      rsSkillWindowRenderSkillIcon ; 8B/DB54

        .al
        .xl
        .autsiz
        .databank ?

        ; The selected skill's icon (tile from the table at $8BDB7E).

        lda wSkillWindowCurrentSkill
        asl a
        tax
        lda $8BDB7E,x
        sta wR4
        stz wR0
        stz wR1
        stz wR5
        ldy #$DB77
        jsl rlPushToOAMBuffer
        sep #$20
        lda #$E0
        sta aBGPaletteBuffer,b
        rep #$20
        rts

        .databank 0

        ; 8B/DB77

    .endsection Unsorted8BDB54Section


    .section Unsorted8BDBA2Section

      .al
      .xl

      rsSkillWindowRenderCursor ; 8B/DBA2

        .al
        .xl
        .autsiz
        .databank ?

        stz wR0
        lda wSkillWindowCursorYCoordinate
        sta wR1
        lda #$0000
        jsl rlUnknown88A704
        rts

        .databank 0

        ; 8B/DBB2

      rsSkillWindowRenderArrows ; 8B/DBB2

        .al
        .xl
        .autsiz
        .databank ?

        ; The arrows for more holders (over 12) and for scrolling the skill list.

        lda wVBlankEnabledFramecount
        and #$0018
        beq _DBF0
        lda wSkillWindowCurrentSkill
        asl a
        tax
        lda aSkillWindowHolderCounts,x
        cmp #$000D
        bcc _DBF0
        lda wSkillWindowHolderScrollDirection
        bne _DBF0
        stz wR0
        stz wR4
        stz wR5
        lda #$0040
        sta wR1
        lda wSkillWindowHolderScroll
        bne _DBE9
        lda #$0066
        sta wR0
        lda #$4000
        sta wR5

        _DBE9
        ldy #$DC42
        jsl rlPushToOAMBuffer

        _DBF0
        lda wVBlankEnabledFramecount
        and #$0008
        beq _DC21
        stz wR0
        stz wR4
        stz wR5
        lda #$0080
        sta wR1
        ldy #$0000
        lda wSkillWindowScrolledLines
        cmp #$000C
        beq _DC17
        inc y
        inc y
        cmp #$0000
        bne _DC17
        inc y
        inc y

        _DC17
        phk
        plb
        .databank $8B
        lda $DC22,b,y
        tay
        jsl rlPushToOAMBuffer

        _DC21
        rts

        .databank 0

        ; 8B/DC22

    .endsection Unsorted8BDBA2Section


    .section Unsorted8BDC92Section

      .al
      .xl

      rsSkillWindowMoveUp ; 8B/DC92

        .al
        .xl
        .autsiz
        .databank ?

        ; Starts moving the cursor up, or scrolling the list up when the cursor is at the top.

        lda wSkillWindowCurrentSkill
        beq _DCB8
        lda wSkillWindowCursorRow
        beq _DCB9
        lda #$0006
        jsl rlPlaySoundEffect
        lda #$FFFF
        sta wSkillWindowCursorMoveDirection
        lda wSkillWindowCursorYCoordinate
        sec
        sbc #$0008
        sta wSkillWindowCursorYCoordinate

        _DCB8
        rts


        _DCB9
        lda #$0006
        jsl rlPlaySoundEffect
        lda #$FFFF
        sta wSkillWindowScrollDirection
        lda wSkillWindowScrolledLines
        dec a
        sta wSkillWindowScrolledLines
        lda wBufferBG2VOFS
        sec
        sbc #$0008
        sta wBufferBG2VOFS
        jsl rlSkillWindowCopyVisibleRows
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 8B/DCEA

      rsSkillWindowMoveDown ; 8B/DCEA

        .al
        .xl
        .autsiz
        .databank ?

        ; Starts moving the cursor down, or scrolling the list down when the cursor is at the bottom.

        lda wSkillWindowCurrentSkill
        cmp #$0011
        beq _DD16
        lda wSkillWindowCursorRow
        cmp #$000B
        beq _DD17
        lda #$0006
        jsl rlPlaySoundEffect
        lda #$0001
        sta wSkillWindowCursorMoveDirection
        lda wSkillWindowCursorYCoordinate
        clc
        adc #$0008
        sta wSkillWindowCursorYCoordinate

        _DD16
        rts


        _DD17
        lda #$0006
        jsl rlPlaySoundEffect
        lda #$0001
        sta wSkillWindowScrollDirection
        lda wSkillWindowScrolledLines
        inc a
        sta wSkillWindowScrolledLines
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        jsl rlSkillWindowCopyVisibleRows
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 8B/DD48

      rsSkillWindowFinishMoveUp ; 8B/DD48

        .al
        .xl
        .autsiz
        .databank ?

        lda wSkillWindowCursorYCoordinate
        sec
        sbc #$0008
        sta wSkillWindowCursorYCoordinate
        lda wSkillWindowCursorRow
        dec a
        sta wSkillWindowCursorRow
        lda wSkillWindowCurrentSkill
        dec a
        sta wSkillWindowCurrentSkill
        lda #$0000
        sta wSkillWindowCursorMoveDirection
        jsl rlSkillWindowDrawSkillName
        jsl rlSkillWindowDrawSkillDescription
        jsl rlSkillWindowDrawHolderNames
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 8B/DD87

      rsSkillWindowFinishMoveDown ; 8B/DD87

        .al
        .xl
        .autsiz
        .databank ?

        lda wSkillWindowCursorYCoordinate
        clc
        adc #$0008
        sta wSkillWindowCursorYCoordinate
        lda wSkillWindowCursorRow
        inc a
        sta wSkillWindowCursorRow
        lda wSkillWindowCurrentSkill
        inc a
        sta wSkillWindowCurrentSkill
        lda #$0000
        sta wSkillWindowCursorMoveDirection
        jsl rlSkillWindowDrawSkillName
        jsl rlSkillWindowDrawSkillDescription
        jsl rlSkillWindowDrawHolderNames
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 8B/DDC6

      rsSkillWindowFinishScrollUp ; 8B/DDC6

        .al
        .xl
        .autsiz
        .databank ?

        lda wSkillWindowScrolledLines
        dec a
        sta wSkillWindowScrolledLines
        lda wSkillWindowCurrentSkill
        dec a
        sta wSkillWindowCurrentSkill
        lda #$0000
        sta wSkillWindowScrollDirection
        lda wBufferBG2VOFS
        sec
        sbc #$0008
        sta wBufferBG2VOFS
        jsl rlSkillWindowCopyVisibleRows
        jsl rlSkillWindowDrawSkillName
        jsl rlSkillWindowDrawSkillDescription
        jsl rlSkillWindowDrawHolderNames
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 8B/DE05

      rsSkillWindowFinishScrollDown ; 8B/DE05

        .al
        .xl
        .autsiz
        .databank ?

        lda wSkillWindowScrolledLines
        inc a
        sta wSkillWindowScrolledLines
        lda wSkillWindowCurrentSkill
        inc a
        sta wSkillWindowCurrentSkill
        lda #$0000
        sta wSkillWindowScrollDirection
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        jsl rlSkillWindowCopyVisibleRows
        jsl rlSkillWindowDrawSkillName
        jsl rlSkillWindowDrawSkillDescription
        jsl rlSkillWindowDrawHolderNames
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 8B/DE44

      rsSkillWindowDrawAllHolderNames ; 8B/DE44

        .al
        .xl
        .autsiz
        .databank ?

        ; All of the selected skill's holders, into aSkillWindowHolderTilemap.

        lda #$0000
        ldx #$0228

        _DE4A
        sta aSkillWindowHolderTilemap,x
        dec x
        dec x
        bne _DE4A
        lda #$8000
        sta @l lMapMenuTilemapRAMEntryPointer+1
        lda #$D903
        sta @l lMapMenuTilemapRAMEntryPointer
        lda wSkillWindowCurrentSkill
        xba
        lsr a
        lsr a
        sta wR1
        stz wR15

        _DE6B
        ldx wR1
        lda aSkillWindowSkillHolders,x
        beq _DE9C
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitNamePointer
        lda wR15
        asl a
        tax
        lda $8BDE9D,x
        tax
        lda @l lRoutineVariable
        sta lR18
        lda @l lRoutineVariable+1
        sta lR18+1
        jsl rlDrawMenuTextLine
        inc wR1
        inc wR1
        inc wR15
        bra _DE6B


        _DE9C
        rts

        .databank 0

        ; 8B/DE9D

    .endsection Unsorted8BDC92Section


    .section Unsorted8BDECDSection

      .al
      .xl

      rsSkillWindowCopyVisibleHolders ; 8B/DECD

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the visible part of the holder names, from wSkillWindowHolderScroll.

        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        lda wSkillWindowHolderScroll
        clc
        adc #$000B
        asl a
        tax
        ldy #$0016

        _DEE2
        lda aSkillWindowHolderTilemap,x
        sta $876C,b,y
        lda $7F90B9,x
        sta $87AC,b,y
        dec x
        dec x
        dec y
        dec y
        bne _DEE2
        lda wSkillWindowHolderScroll
        clc
        adc #$000B
        asl a
        tax
        ldy #$0016

        _DF03
        lda $7F90E7,x
        sta $87EC,b,y
        lda $7F9115,x
        sta $882C,b,y
        dec x
        dec x
        dec y
        dec y
        bne _DF03
        lda wSkillWindowHolderScroll
        clc
        adc #$000B
        asl a
        tax
        ldy #$0016

        _DF24
        lda $7F9143,x
        sta $886C,b,y
        lda $7F9171,x
        sta $88AC,b,y
        dec x
        dec x
        dec y
        dec y
        bne _DF24
        lda wSkillWindowHolderScroll
        clc
        adc #$000B
        asl a
        tax
        ldy #$0016

        _DF45
        lda $7F919F,x
        sta $88EC,b,y
        lda $7F91CD,x
        sta $892C,b,y
        dec x
        dec x
        dec y
        dec y
        bne _DF45
        lda wSkillWindowHolderScroll
        clc
        adc #$000B
        asl a
        tax
        ldy #$0016

        _DF66
        lda $7F91FB,x
        sta $896C,b,y
        lda $7F9229,x
        sta $89AC,b,y
        dec x
        dec x
        dec y
        dec y
        bne _DF66
        lda wSkillWindowHolderScroll
        clc
        adc #$000B
        asl a
        tax
        ldy #$0016

        _DF87
        lda $7F9257,x
        sta $89EC,b,y
        lda $7F9285,x
        sta $8A2C,b,y
        dec x
        dec x
        dec y
        dec y
        bne _DF87
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        rts

        .databank 0

        ; 8B/DFA9

    .endsection Unsorted8BDECDSection


