; Dialogue boxes: procDialogueBox, the HDMA effects that fold and unfold the
; boxes, and freeing them.

    .section DialogueBoxSection

      .al
      .xl

      procDialogueBox ; 85/9BE6

        .structProcInfo "PC", rlProcDialogueBoxInit, rlProcDialogueBoxCycle1, $858398

        .long aDialogueBoxMapMenuData
        .byte 0

        ; Handles writing the necessary BG tiles to the BG2, increasing in width over time 
        ; and creates a HDMA that handles the box folding and modifies the height.
        ; aProcSystem.wInput0 = position indicator
        ; aProcSystem.wInput1 = Y tile position << 8 | X 

      rlProcDialogueBoxInit ; 85/9BF2

        .al
        .autsiz
        .databank ?

        jsl rlStallProcUntilMapMenuDataLoaded

        lda #0
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS

        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody5,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody6,b,x
        jsl rlSetMapMenuPosition

        lda #0
        sta aProcSystem.aBody4,b,x

        lda aProcSystem.aBody5,b,x
        sta wR42

        lda aProcSystem.wInput1,b
        xba
        and #$00FF
        asl a
        asl a
        asl a
        sta aProcSystem.aBody6,b,x
        sta wR43
        lda #2
        sta wR40

        lda #(`aDialogueBoxUnfoldingHDMA)<<8
        sta lR44+1
        lda #<>aDialogueBoxUnfoldingHDMA
        sta lR44
        jsl rlHDMAEngineCreateEntryByIndex
        rtl

        .databank 0

      rlProcDialogueBoxCycle1 ; 85/9C3B

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody5,b,x
        sta aProcSystem.wInput0,b

        lda #<>rlProcDialogueBoxCycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcDialogueBoxCycle2 ; 85/9C48

        .al
        .autsiz
        .databank ?

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody5,b,x
        sta aProcSystem.wInput0,b

        jsl rlUnknown87829A
        jsl rlMapMenuBuildTilemap
        plx

        lda #<>rlProcDialogueBoxCycle3
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0002
        tsb wUnknown000D79,b
        rtl

        .databank 0

      rlProcDialogueBoxCycle3 ; 85/9C69

        .al
        .autsiz
        .databank ?

        lda #$0002
        tsb wUnknown000D79,b

        jsl rlCheckDialogueBoxHDMAFinished
        bcs +

          lda aProcSystem.aBody5,b,x
          sta aProcSystem.wInput0,b
          jsl rlLoadMapMenuEntryPointerFromProcBody
          jsl rlGetMapMenuTilemapArea
          clc
          adc #2
          jsl rlSetMapMenuTilemapArea
          jsl rlMapMenuBuildTilemap
          rtl

        +
        phx
        lda aProcSystem.aBody5,b,x
        sta aProcSystem.wInput0,b
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda #pack([32, 10])
        jsl rlSetMapMenuTilemapArea
        jsl rlUnknown87829A
        jsl rlMapMenuBuildTilemap
        plx
        lda #<>rlProcDialogueBoxCycle4
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcDialogueBoxCycle4 ; 85/9CB2

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody5,b,x
        sta aProcSystem.wInput0,b

        lda aProcSystem.aBody4,b,x
        bit #$0001
        bne +

          rtl

        +
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda #<>rlProcDialogueBoxCycle5
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aBody5,b,x
        sta wR42
        lda aProcSystem.aBody6,b,x
        sta wR43
        lda #2
        sta wR40
        lda #(`aDialogueBoxFoldingHDMA)<<8
        sta lR44+1
        lda #<>aDialogueBoxFoldingHDMA
        sta lR44
        jsl rlHDMAEngineCreateEntryByIndex

        lda aProcSystem.aBody5,b,x
        sta aProcSystem.wInput0,b
        jsl rlUnknown87829A
        jsl rlMapMenuBuildTilemap
        lda #$0002
        tsb wUnknown000D79,b
        rtl

        .databank 0

      rlProcDialogueBoxCycle5 ; 85/9CFD

        .al
        .autsiz
        .databank ?

        jsl rlCheckDialogueBoxHDMAFinished
        bcs +

          lda aProcSystem.aBody5,b,x
          sta aProcSystem.wInput0,b
          lda #$0002
          tsb wUnknown000D79,b
          jsl rlLoadMapMenuEntryPointerFromProcBody
          jsl rlGetMapMenuTilemapArea
          sec
          sbc #4
          jsl rlSetMapMenuTilemapArea
          jsl $85884A
          rtl

        +
        jsl $8586FA
        jsl $85AB2A
        lda #$0002
        tsb wUnknown000D79,b
        lda #<>rlProcDialogueBoxCycle6
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

      rlProcDialogueBoxCycle6 ; 85/9D39

        .al
        .autsiz
        .databank ?

        lda #$7FFF
        sta wDialogueBoxHDMAStatus
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

      rlCreateProcDialogueBox ; 85/9D45

        .al
        .autsiz
        .databank ?

        ; A = top or bottom indicator:  0 or 1
        ; X = tile y coordinate:        0 or (18 << 8)

        pha
        jsl rlFreeHDMAEntry0
        pla
        sta aProcSystem.wInput0,b
        stx aProcSystem.wInput1,b

        lda #(`procDialogueBox)<<8
        sta lR44+1
        lda #<>procDialogueBox
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/9D60

    .endsection DialogueBoxSection


    .section DialogueBoxHDMASection

      .al
      .xl

      aDialogueBoxUnfoldingHDMA ; 85/A895

        .structHDMAIndirectEntryInfo rlDialogueBoxUnfoldingHDMAInit, rlDialogueBoxUnfoldingHDMACycle1, aDialogueBoxUnfoldingHDMACode, aDialogueBoxHDMAIndirectTableEven, BG2VOFS, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode2), `aDialogueBoxHDMADataTableEven 

        ; This HDMA opens a specified dialogue box.
        ; Input:
        ; wR42 = 0 (top box) or 1 (bottom box)
        ; wR43 = Y pixel position

      rlDialogueBoxUnfoldingHDMAInit ; 85/A8A1

        .al
        .autsiz
        .databank ?

        lda wR42
        sta wDialogueBoxHDMAPositionIndicator
        lda wR43
        clc
        adc #8
        sta wDialogueBoxHDMAYPixelPosition
        sta wR0

        lda #0
        sta wDialogueBoxHDMACycleCounter
        sta wR1
        sta wDialogueBoxHDMAStatus
        jsr rsDialogueBoxHDMABuildTables
        rtl

        .databank 0

      rlDialogueBoxUnfoldingHDMACycle1 ; 85/A8C4

        .al
        .autsiz
        .databank ?

        phx
        lda wDialogueBoxHDMAYPixelPosition
        sta wR0
        lda wDialogueBoxHDMACycleCounter
        sta wR1
        jsr rsDialogueBoxHDMABuildTables
        plx

        lda wR1
        cmp #7
        bpl +

          inc a
          sta wDialogueBoxHDMACycleCounter
          bra _End

        +
        lda #<>rlDialogueBoxUnfoldingHDMACycle2
        sta aHDMASystem.aOnCycle,b,x

        _End
        rtl

        .databank 0

      rlDialogueBoxUnfoldingHDMACycle2 ; 85/A8EA

        .al
        .autsiz
        .databank ?

        lda #$FFFF
        sta wDialogueBoxHDMAStatus
        lda #pack([NTRL_Setting(0), NTRL_Setting(0)])
        sta aDialogueBoxHDMAIndirectTableEven
        rtl

        .databank 0

      aDialogueBoxUnfoldingHDMACode ; 85/A8F9

        HDMA_HALT

      aDialogueBoxFoldingHDMA ; 85/A8FB

        .structHDMAIndirectEntryInfo rlDialogueBoxFoldingHDMAInit, rlDialogueBoxFoldingHDMACycle1, aDialogueBoxFoldingHDMACode, aDialogueBoxHDMAIndirectTableEven, BG2VOFS, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode2), `aDialogueBoxHDMADataTableEven 

        ; This HDMA closes a specified dialogue box.
        ; Input:
        ; wR42 = 0 (top box) or 1 (bottom box)
        ; wR43 = Y pixel position

      rlDialogueBoxFoldingHDMAInit ; 85/A907

        .al
        .autsiz
        .databank ?

        lda wR42
        sta wDialogueBoxHDMAPositionIndicator
        lda wR43
        clc
        adc #8
        sta wDialogueBoxHDMAYPixelPosition

        lda #6
        sta wDialogueBoxHDMACycleCounter
        sta wDialogueBoxHDMAStatus
        rtl

        .databank 0

      rlDialogueBoxFoldingHDMACycle1 ; 85/A923

        .al
        .autsiz
        .databank ?

        phx
        lda wDialogueBoxHDMAYPixelPosition
        sta wR0
        lda wDialogueBoxHDMACycleCounter
        sta wR1
        jsr rsDialogueBoxHDMABuildTables

        plx
        lda wR1
        beq +

          dec a
          sta wDialogueBoxHDMACycleCounter
          bra _End

        +
        lda #<>rlDialogueBoxFoldingHDMACycle2
        sta aHDMASystem.aOnCycle,b,x

        _End
        rtl

        .databank 0

      rlDialogueBoxFoldingHDMACycle2 ; 85/A946

        .al
        .autsiz
        .databank ?

        lda #$FFFF
        sta wDialogueBoxHDMAStatus
        rtl

        .databank 0

      aDialogueBoxFoldingHDMACode ; 85/A94E

        HDMA_HALT

      rsDialogueBoxHDMABuildTables ; 85/A950

        .al
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        bit #$0001
        bne _Odd

        ; Even
        lda #0
        bra +

        _Odd
        lda #aDialogueBoxHDMAIndirectTableOdd - aDialogueBoxHDMAIndirectTableEven
            ; $0060

        +
        sta wR4
        jsr rsDialogueBoxHDMABuildTablesEffect

        lda #<>aDialogueBoxHDMAIndirectTableEven
        clc
        adc wR4
        sta aHDMASystem.aOffset,b,x
        rts

        .databank 0

      rsDialogueBoxHDMABuildTablesEffect ; 85/A96E

        .al
        .autsiz
        .databank ?

        ; wR0 = Y pixel position
        ; wR1 = cycle count
        ; wR4 = buffer offset

        phx
        jsr rsDialogueBoxHDMAGetCyclesYOffset
        jsr rsDialogueBoxHDMASetupDefaultTables
        jsr rsDialogueBoxHDMASetBeginningTableData

        lda wDialogueBoxHDMAPositionIndicator
        beq _Top

        ; Bottom
        jsr rsDialogueBoxHDMAWriteDisplayedAreaToTable
        jsr rsDialogueBoxHDMAWriteHiddenAreaToTable
        bra _End

        _Top
        jsr rsDialogueBoxHDMAWriteHiddenAreaToTable
        jsr rsDialogueBoxHDMAWriteDisplayedAreaToTable
        
        _End
        jsr rsDialogueBoxHDMAWriteTableTerminators
        plx
        rts

        .databank 0

      rsDialogueBoxHDMAGetCyclesYOffset ; 85/A991

        .al
        .autsiz
        .databank $85

        ; wR0 = Y pixel position
        ; wR1 = cycle count
        ; wR4 = buffer offset

        ; Based on the current cycle, grab the y offset, specifying how much
        ; of the box is still hidden.
        ; Also move the Y position 2 pixels down if the box is to be displayed
        ; at the top, or 2 up if its at the bottom.

        lda wR1
        asl a
        tay
        lda aDialogueBoxHDMACycleYOffsetTable,y
        asl a
        dec a
        dec a
        sta wR5

        lda wDialogueBoxHDMAPositionIndicator
        beq _Top

        ; Bottom
        inc wR0
        inc wR0
        bra _End

        _Top
        dec wR0
        dec wR0

        _End
        rts

        .databank 0

      aDialogueBoxHDMACycleYOffsetTable ; 85/A9AE

        .word $001E
        .word $001C
        .word $0019
        .word $0016
        .word $0012
        .word $000D
        .word $0007
        .word $0001

      rsDialogueBoxHDMASetupDefaultTables ; 85/A9BE

        .al
        .autsiz
        .databank ?

        ; wR0 = Y pixel position
        ; wR1 = cycle count
        ; wR4 = buffer offset
        ; wR5 = current cycles Y offset

        ; Builds the inderect HDMA table out of 15 zero line entries with word pointers

        phy
        phx
        lda #15 * (size(byte) + size(word))
        tay
        clc
        adc wR4
        tax
        lda #<>aDialogueBoxHDMADataTableEven + (15 * size(word))
        clc
        adc wR4
        sta wR2

          _Loop
          sep #$20
          lda #NTRL_Setting(0)
          sta aDialogueBoxHDMAIndirectTableEven,x
          rep #$20

          lda wR2
          sta aDialogueBoxHDMAIndirectTableEven+1,x
          dec wR2
          dec wR2
          dec x
          dec x
          dec x
          dec y
          dec y
          dec y
          bpl _Loop

        plx
        ply
        rts

        .databank 0

      rsDialogueBoxHDMASetBeginningTableData ; 85/A9EF

        .al
        .autsiz
        .databank ?

        ; wR0 = Y pixel position
        ; wR1 = cycle count
        ; wR4 = buffer offset
        ; wR5 = current cycles Y offset

        phx
        ldx wR4
        lda wR0
        lsr a
        sta wR2
        sep #$20
        sta aDialogueBoxHDMAIndirectTableEven,x
        rep #$20

        lda #3
        clc
        adc wR4
        tax

        lda wR0
        sec
        sbc wR2
        sep #$20
        sta aDialogueBoxHDMAIndirectTableEven,x
        rep #$20

        ldx wR4
        lda aDialogueBoxHDMATopDataValue
        sta aDialogueBoxHDMADataTableEven,x
        inc x
        inc x
        sta aDialogueBoxHDMADataTableEven,x

        lda #6
        sta wR7
        lda #4
        sta wR6
        plx
        rts

        .databank 0

      aDialogueBoxHDMATopDataValue ; 85/AA2F

        .word BGOFS_Setting(1023)

      rsDialogueBoxHDMAWriteHiddenAreaToTable ; 85/AA31

        .al
        .autsiz
        .databank ?

        ; wR0 = Y pixel position
        ; wR1 = cycle count
        ; wR4 = buffer offset
        ; wR5 = current cycles Y offset
        ; wR6 = HDMA data table offset
        ; wR7 = HDMA indirect table offset

        ; Writes all other line counts and modifies the data on those lines

        ; wR6 = HDMA data table offset
        ; wR7 = HDMA table offset

        lda wR5
        pha

        lda #8
        sta wR2
        
          _Loop
          lda wR5
          sec
          sbc #8
          sta wR5
          bpl +

            lda wR2
            clc
            adc wR5
            bmi _End
            beq _End

              sta wR2

          +
          lda wR7
          clc
          adc wR4
          tax

          lda wR2
          sep #$20
          sta aDialogueBoxHDMAIndirectTableEven,x
          rep #$20

          inc wR7
          inc wR7
          inc wR7

          lda wR6
          clc
          adc wR4
          tax

          lda wR0
          eor #$FFFF
          sta aDialogueBoxHDMADataTableEven,x
          inc wR6
          inc wR6

          lda wR0
          clc
          adc wR2
          sta wR0
          bra _Loop

        _End
        pla
        sta wR5
        rts

        .databank 0

      rsDialogueBoxHDMAWriteDisplayedAreaToTable ; 85/AA84

        .al
        .autsiz
        .databank ?

        ; wR0 = Y pixel position
        ; wR1 = cycle count
        ; wR4 = buffer offset
        ; wR5 = current cycles Y offset
        ; wR6 = HDMA data table offset
        ; wR7 = HDMA indirect table offset

        lda #$003E
        sec
        sbc wR5
        bmi _End
        beq _End

          pha
          lda wR7
          clc
          adc wR4
          tax

          pla
          sep #$20
          sta aDialogueBoxHDMAIndirectTableEven,x
          rep #$20

          inc wR7
          inc wR7
          inc wR7
          pha

          lda wDialogueBoxHDMAPositionIndicator
          beq _Top

          ; Bottom
          lda wR6
          clc
          adc wR4
          tax

          lda wR5
          sta aDialogueBoxHDMADataTableEven,x
          inc wR6
          inc wR6
          bra +

          _Top
          lda wR6
          clc
          adc wR4
          tax

          lda wR5
          eor #$FFFF
          sta aDialogueBoxHDMADataTableEven,x
          inc wR6
          inc wR6

          +
          pla
          clc
          adc wR0
          sta wR0
        
        _End
        rts

        .databank 0

      rsDialogueBoxHDMAWriteTableTerminators ; 85/AAD7

        .al
        .autsiz
        .databank ?

        ; Writes the HDMA table terminators

        lda wR7
        clc
        adc wR4
        tax

        lda #NTRL_Setting(1)
        sep #$20
        sta aDialogueBoxHDMAIndirectTableEven,x
        rep #$20
        inc wR7
        inc wR7
        inc wR7

        lda wR6
        clc
        adc wR4
        tax
        lda aDialogueBoxHDMABottomDataValue
        sta aDialogueBoxHDMADataTableEven,x

        lda wR7
        clc
        adc wR4
        tax

        lda #pack([NTRL_Setting(0), NTRL_Setting(0)])
        sta aDialogueBoxHDMAIndirectTableEven,x
        rts

        .databank 0

      aDialogueBoxHDMABottomDataValue ; 85/AB0A

        .word BGOFS_Setting(1023)

      rlCheckDialogueBoxHDMAFinished ; 85/AB0C

        .al
        .autsiz
        .databank ?

        ; Output:
        ; SEC if done, else CLC

        lda wDialogueBoxHDMAStatus
        cmp #$FFFF
        beq +

          clc
          rtl

        +
        sec
        rtl

        .databank 0

        ; 85/AB19

    .endsection DialogueBoxHDMASection


    .section FreeDialogueBoxHDMAIfFinishedSection

      .al
      .xl

      rlFreeDialogueBoxHDMAIfFinished ; 85/AB19

        .al
        .autsiz
        .databank ?

        lda wDialogueBoxHDMAStatus
        cmp #$FFFF
        beq +

          clc
          rtl

        +
        jsl rlFreeDialogueBoxHDMA
        sec
        rtl

        .databank 0

      rlFreeDialogueBoxHDMA ; 85/AB2A

        .al
        .autsiz
        .databank ?

        lda #2
        jsl rlHDMAEngineFreeEntryByIndex
        rtl

        .databank 0

        ; 85/AB32

    .endsection FreeDialogueBoxHDMAIfFinishedSection


    .section FreeDialogueBoxesSection

      .al
      .xl

      rlFreeDialogueBoxes ; 85/AB3F

        .al
        .xl
        .autsiz
        .databank ?

        ; Frees up to two procDialogueBox procs, calling $8586FA with each one's
        ; map menu entry first, then frees the dialogue box HDMA.

        ; Output:
        ; Carry set if there was a dialogue box, clear if not.

        phx
        lda #(`procDialogueBox)<<8
        sta lR44+1
        lda #<>procDialogueBox
        sta lR44
        jsl rlProcEngineFindProc
        bcc _AB7F
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl $8586FA
        jsl rlProcEngineFreeProc
        lda #(`procDialogueBox)<<8
        sta lR44+1
        lda #<>procDialogueBox
        sta lR44
        jsl rlProcEngineFindProc
        bcc _AB78
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl $8586FA
        jsl rlProcEngineFreeProc

        _AB78
        jsl rlFreeDialogueBoxHDMA
        plx
        sec
        rtl


        _AB7F
        plx
        clc
        rtl

        .databank 0

        ; 85/AB82

    .endsection FreeDialogueBoxesSection


    .section DisplayDialogueAPressArrowsSection

      .al
      .xl

      rlDisplayDialogueAPressArrows ; 8A/DB63

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR0 = X Pos
        ; wR1 = Y Pos

        phb
        phx
        phy
        lda aDialogue.wStatus,b
        bit #DialogueStatusCaretLight
        bne _Light

        bit #DialogueStatusCaretDark
        bne _Dark
        bra _End

        _Light
        sep #$20
        lda #`$8ADBAF
        pha
        plb
        rep #$20

        ldy #<>$8ADBAF
        bra _Push

        _Dark
        sep #$20
        lda #`$8ADBB6
        pha
        plb
        rep #$20
        ldy #<>$8ADBB6

        _Push
        lda #0
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer

        _End
        ply
        plx
        plb
        rtl

        .databank 0

        ; 8A/DB9F

    .endsection DisplayDialogueAPressArrowsSection
