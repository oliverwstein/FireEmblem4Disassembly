; Dialogue boxes: procDialogueBox, the HDMA effects that fold and unfold the
; boxes, freeing and closing them (rlCloseDialogueBox, rlCheckDialogueBoxesClosed).
; At the end, helpers from bank $85 the dialogue code calls whose purpose is not
; worked out yet (rlUnknown85BCD4, rlUnknown85BD12, rlUnknown85BD93) and an
; unreached proc (procUnknown85C01F). Last, from bank $81, rlRedrawDialogueBoxTilemaps:
; each frame on the map it copies the two boxes' tilemaps when bit 1 of
; wChapterFlags asks for it.

    .section DialogueBoxSection

      .al
      .xl

      procDialogueBox ; 85/9BE6

        .structProcInfo "PC", rlProcDialogueBoxInit, rlProcDialogueBoxCycle1, aProcDialogueBoxCode

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

        jsl rlGetMapMenuRows
        jsl rlMapMenuBuildTilemap
        plx

        lda #<>rlProcDialogueBoxCycle3
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0002
        tsb wChapterFlags,b
        rtl

        .databank 0

      rlProcDialogueBoxCycle3 ; 85/9C69

        .al
        .autsiz
        .databank ?

        lda #$0002
        tsb wChapterFlags,b

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
        jsl rlGetMapMenuRows
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
        jsl rlGetMapMenuRows
        jsl rlMapMenuBuildTilemap
        lda #$0002
        tsb wChapterFlags,b
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
          tsb wChapterFlags,b
          jsl rlLoadMapMenuEntryPointerFromProcBody
          jsl rlGetMapMenuTilemapArea
          sec
          sbc #4
          jsl rlSetMapMenuTilemapArea
          jsl rlResizeMapMenuFrame
          rtl

        +
        jsl rlCloseMapMenuFromProc
        jsl rlFreeDialogueBoxHDMA
        lda #$0002
        tsb wChapterFlags,b
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
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        lda #(`procDialogueBox)<<8
        sta lR44+1
        lda #<>procDialogueBox
        sta lR44
        jsl rlProcEngineFindProc
        bcc _AB78
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlCloseMapMenuFromProc
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
        lda #`aUnknown8ADBAF
        pha
        plb
        rep #$20

        ldy #<>aUnknown8ADBAF
        bra _Push

        _Dark
        sep #$20
        lda #`aUnknown8ADBB6
        pha
        plb
        rep #$20
        ldy #<>aUnknown8ADBB6

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


    .section Unsorted859D60Section

      .al
      .xl

      rlCloseDialogueBox ; 85/9D60

        .al
        .xl
        .autsiz
        .databank ?

        ; wR0 = the dialogue box's number: sets bit 0 of its procDialogueBox's aBody4 (close). With none open, sets wDialogueBoxHDMAStatus to $7FFF.

        phx
        ldx #$001E

        _9D64
        lda aProcSystem.aHeaderTypeOffset,b,x
        cmp #<>procDialogueBox
        bne _9D7B
        lda aProcSystem.aBody5,b,x
        cmp wR0
        bne _9D7B
        lda #$0001
        sta aProcSystem.aBody4,b,x
        bra _9D86


        _9D7B
        dec x
        dec x
        bpl _9D64
        lda #$7FFF
        sta wDialogueBoxHDMAStatus

        _9D86
        plx
        rtl

        .databank 0

        ; 85/9D88

    .endsection Unsorted859D60Section


    .section Unsorted85AB32Section

      .al
      .xl

      rlCheckDialogueBoxesClosed ; 85/AB32

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set when wDialogueBoxHDMAStatus is $7FFF (no dialogue box open).

        lda wDialogueBoxHDMAStatus
        cmp #$7FFF
        beq _AB3D
        clc
        rtl


        _AB3D
        sec
        rtl

        .databank 0

        ; 85/AB3F

    .endsection Unsorted85AB32Section


    .section Unsorted85BCD4Section

      .al
      .xl

      rlUnknown85BCD4 ; 85/BCD4

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        pha
        sep #$20
        clc
        ror a
        sta wDialogueBoxHDMAYPixelPosition
        bcc _BCE0
        inc a

        _BCE0
        sta wDialogueBoxHDMACycleCounter+1
        lda #$20
        sta wDialogueBoxHDMAPositionIndicator
        lda #$01
        sta $7FEA53
        lda #$00
        sta $7FEA56
        rep #$20
        lda #$BD10
        sta wDialogueBoxHDMAYPixelPosition+1
        sta wDialogueBoxHDMAStatus
        sta $7FEA54
        lda #$BD11
        sta wDialogueBoxHDMAPositionIndicator+1
        pla
        rtl

        .databank 0

        ; 85/BD10


      aUnknown85BD10 ; 85/BD10

        .byte $00

      aUnknown85BD11 ; 85/BD11

        .byte $01

    .endsection Unsorted85BCD4Section


    .section Unsorted85BD12Section

      .al
      .xl

      rlUnknown85BD12 ; 85/BD12

        .al
        .xl
        .autsiz
        .databank ?

        sty wR7
        sta wR6
        phx
        lda wR7
        bne _BD20
        lda #$7B80
        bra _BD23


        _BD20
        lda #$3FC0

        _BD23
        sta wR0
        lda wR6
        cmp #$FFFF
        bne _BD35
        lda #$0000
        sta wR1
        sta wR2
        bra _BD46


        _BD35
        asl a
        tax
        lda aUnknown85BD8D,x
        clc
        adc wR0
        sta wR1
        clc
        adc #$0010
        sta wR2

        _BD46
        phb
        php
        phk
        plb
        .databank $85
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        lda wR7
        bne _BD5B
        lda #$7F56
        bra _BD5E


        _BD5B
        lda #$7F78

        _BD5E
        tax
        clc
        adc #$0040
        tay
        lda #$0003
        sta wR0

        _BD69
        lda wR1
        sta $0000,b,x
        dec wR1
        lda wR2
        sta $0000,b,y
        dec wR2
        lda wR7
        bne _BD81
        inc x
        inc x
        inc y
        inc y
        bra _BD85


        _BD81
        dec x
        dec x
        dec y
        dec y

        _BD85
        dec wR0
        bpl _BD69
        plp
        plb
        .databank $7E
        plx
        rtl

        .databank 0

        ; 85/BD8D

    .endsection Unsorted85BD12Section


    .section Table85BD8DSection

      .al
      .xl

      aUnknown85BD8D ; 85/BD8D

        ; Read by rlUnknown85BD12.

        .word $0009, $000F, $002F

        ; 85/BD93

    .endsection Table85BD8DSection


    .section Unsorted85BD93Section

      .al
      .xl

      rlUnknown85BD93 ; 85/BD93

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM $7E7F48, $0080, $80, $ABC0

        rtl

        .databank 0

        ; 85/BDA1

    .endsection Unsorted85BD93Section


    .section Unsorted85BDA1Section

      .al
      .xl

      rlUnknown85BDA1 ; 85/BDA1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        pha
        txa
        and #$00FF
        asl a
        asl a
        asl a
        sta wR0
        txa
        and #$FF00
        xba
        asl a
        asl a
        asl a
        sta wR1
        sta wR6
        pla
        pha
        tya
        ora #$0000
        bne _BDD7
        lda aEpilogueUnitStates
        asl a
        asl a
        asl a
        sta wR4
        lda $7FC54C
        asl a
        asl a
        asl a
        sta wR5
        bra _BDE9


        _BDD7
        lda $7FC5AE
        asl a
        asl a
        asl a
        sta wR4
        lda $7FC5B0
        asl a
        asl a
        asl a
        sta wR5

        _BDE9
        pla
        sta wR7
        pha
        beq _BE35
        lda wR4
        sec
        sbc wR0
        sta wR13
        lda #$0010
        sta wR14
        jsl rlSignedDivide16By16R13
        lda wR13
        sta wR10
        lda wR7
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR0
        clc
        adc wR12
        sta wR0
        lda wR5
        sec
        sbc wR1
        sta wR13
        lda #$0010
        sta wR14
        jsl rlSignedDivide16By16R13
        lda wR13
        sta wR10
        lda wR7
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR1
        clc
        adc wR12
        sta wR1

        _BE35
        pla
        pha
        phx
        tax
        lda wR6
        cmp #$0070
        bmi _BE50
        lda @l aUnknown85BE76,x
        and #$00FF
        sta wR7
        lda wR1
        sec
        sbc wR7
        bra _BE5A


        _BE50
        lda @l aUnknown85BE76,x
        and #$00FF
        clc
        adc wR1

        _BE5A
        sta wR1
        plx
        pla
        asl a
        tax
        ldy <>aUnknown85BE87,b,x
        stz wR4
        stz wR5
        sep #$20
        lda #$85
        pha
        plb
        .databank $85
        rep #$20
        jsl rlPushToOAMBuffer
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/BE76

    .endsection Unsorted85BDA1Section


    .section Table85BE76Section

      .al
      .xl

      aUnknown85BE76 ; 85/BE76

        ; Read by rlUnknown85BDA1.

        .byte $00, $01, $02, $03, $04, $05, $06, $07, $08, $07, $06, $05, $04, $03, $02, $01
        .byte $00

        ; 85/BE87

    .endsection Table85BE76Section


    .section Table85BE87Section

      .al
      .xl

      aUnknown85BE87 ; 85/BE87

        ; Read by rlUnknown85BDA1.

        .word <>aUnknown85BEA9
        .word <>aUnknown85BF6F
        .word <>aUnknown85BEBF
        .word <>aUnknown85BF85
        .word <>aUnknown85BED5
        .word <>aUnknown85BF9B
        .word <>aUnknown85BEEB
        .word <>aUnknown85BFB1
        .word <>aUnknown85BF01
        .word <>aUnknown85BFC7
        .word <>aUnknown85BF17
        .word <>aUnknown85BFDD
        .word <>aUnknown85BF2D
        .word <>aUnknown85BFF3
        .word <>aUnknown85BF43
        .word <>aUnknown85C009
        .word <>aUnknown85BF59

      aUnknown85BEA9 ; 85/BEA9

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(   8,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,    8), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(   8,    8), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BEA9._Sprites

      aUnknown85BEBF ; 85/BEBF

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  12,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   20), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  12,   20), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BEBF._Sprites

      aUnknown85BED5 ; 85/BED5

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  16,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   26), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  16,   26), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BED5._Sprites

      aUnknown85BEEB ; 85/BEEB

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  20,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   32), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  20,   32), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BEEB._Sprites

      aUnknown85BF01 ; 85/BF01

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  24,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   38), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  24,   38), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BF01._Sprites

      aUnknown85BF17 ; 85/BF17

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  28,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   44), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  28,   44), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BF17._Sprites

      aUnknown85BF2D ; 85/BF2D

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  32,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   50), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  32,   50), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BF2D._Sprites

      aUnknown85BF43 ; 85/BF43

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  36,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   56), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  36,   56), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BF43._Sprites

      aUnknown85BF59 ; 85/BF59

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  40,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   62), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  40,   62), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BF59._Sprites

      aUnknown85BF6F ; 85/BF6F

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  10,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   11), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  10,   11), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BF6F._Sprites

      aUnknown85BF85 ; 85/BF85

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  14,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   23), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  14,   23), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BF85._Sprites

      aUnknown85BF9B ; 85/BF9B

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  18,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   29), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  18,   29), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BF9B._Sprites

      aUnknown85BFB1 ; 85/BFB1

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  22,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   35), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  22,   35), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BFB1._Sprites

      aUnknown85BFC7 ; 85/BFC7

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  26,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   41), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  26,   41), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BFC7._Sprites

      aUnknown85BFDD ; 85/BFDD

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  30,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   47), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  30,   47), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BFDD._Sprites

      aUnknown85BFF3 ; 85/BFF3

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  34,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   53), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  34,   53), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85BFF3._Sprites

      aUnknown85C009 ; 85/C009

        _Sprites := [[(   0,    0), $00, SpriteSmall, $0000, 3, 0, false, false]]
        _Sprites ..= [[(  38,    0), $00, SpriteSmall, $0001, 3, 0, false, false]]
        _Sprites ..= [[(   0,   59), $00, SpriteSmall, $0010, 3, 0, false, false]]
        _Sprites ..= [[(  38,   59), $00, SpriteSmall, $0011, 3, 0, false, false]]

        .structSpriteArray aUnknown85C009._Sprites

        ; 85/C01F

    .endsection Table85BE87Section


    .section ProcScript85C01FSection

      .al
      .xl

      procUnknown85C01F .structProcInfo "PW", rlUnknown85C028, rlUnknown85C051, aProcDialogueBoxCode ; 85/C01F

        .byte $01

        ; 85/C028

    .endsection ProcScript85C01FSection


    .section Unsorted85C028Section

      .al
      .xl

      rlUnknown85C028 ; 85/C028

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.wInput3,b
        sta aProcSystem.aBody6,b,x
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody5,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody4,b,x
        lda #$FFFF
        sta aProcSystem.aBody7,b,x
        phx
        ldx #$001E

        _C044
        lda aOAMPaletteBuffer,b,x
        sta $7FEB2A,x
        dec x
        dec x
        bpl _C044
        plx
        rtl

        .databank 0

        ; 85/C051


      rlUnknown85C051 ; 85/C051

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody7,b,x
        inc a
        cmp #$0011
        bpl _C07F
        sta aProcSystem.aBody7,b,x
        sta wR0
        lda aProcSystem.aBody4,b,x
        bne _C068
        lda wR0
        bra _C06E


        _C068
        lda #$0011
        sec
        sbc wR0

        _C06E
        sta wR0
        lda aProcSystem.aBody5,b,x
        tay
        lda aProcSystem.aBody6,b,x
        tax
        lda wR0
        jsl rlUnknown85BDA1
        rtl


        _C07F
        phx
        ldx #$001E

        _C083
        lda $7FEB2A,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _C083
        plx
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

        ; 85/C094


      rlUnknown85C094 ; 85/C094

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown85C01F)<<8
        sta lR44+1
        lda #<>procUnknown85C01F
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/C0A3


      rlUnknown85C0A3 ; 85/C0A3

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`procUnknown85C01F)<<8
        sta lR44+1
        lda #<>procUnknown85C01F
        sta lR44
        jsl rlProcEngineFindProc
        bcc _C0B7
        plx
        sec
        rtl


        _C0B7
        plx
        clc
        rtl

        .databank 0

        ; 85/C0BA


    .endsection Unsorted85C028Section


    .section Unsorted85C0BASection

      .al
      .xl

      rlUnknown85C0BA ; 85/C0BA

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlFreeHDMAEntry0
        jsl rlProcEngineFreeProc
        jsl rlShowMapWindows
        rtl

        .databank 0

        ; 85/C0C7

    .endsection Unsorted85C0BASection


    .section Unsorted81B3A6Section

      .al
      .xl

      rlRedrawDialogueBoxTilemaps ; 81/B3A6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame on the map: when bit 1 of wChapterFlags is set (a dialogue box moved), clears it, sets bit 0 and copies the two dialogue boxes' tilemaps ($7FC54E and $7FC5B2, at the tiles in $7FC54A/$7FC54C and $7FC5AE/$7FC5B0) to the map menu buffer, widening its dirty rows.

        phb
        php
        phk
        plb
        .databank $81
        phx
        lda wChapterFlags,b
        bit #$0002
        beq _B429
        lda #$0002
        trb wChapterFlags,b
        lda #$0001
        tsb wChapterFlags,b
        lda #(`aDialogueBox1TilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aDialogueBox1TilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        lda aEpilogueUnitStates
        sta wR0
        lda $7FC54C
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc wR0
        asl a
        tax
        jsl rlCopyTilemapEntryToBG
        lda #(`aDialogueBox2TilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aDialogueBox2TilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        lda $7FC5AE
        sta wR0
        lda $7FC5B0
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc wR0
        asl a
        tax
        jsl rlCopyTilemapEntryToBG
        lda $7FC5B0
        cmp #$0021
        bcs _B418
        cmp wMapMenuDirtyTop,b
        bcs _B418
        sta wMapMenuDirtyTop,b

        _B418
        clc
        adc #$0008
        cmp #$0021
        bcs _B429
        cmp wMapMenuDirtyBottom,b
        bcc _B429
        sta wMapMenuDirtyBottom,b

        _B429
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 81/B42D

    .endsection Unsorted81B3A6Section


    .section Table81B42DSection

      .al
      .xl

      aDialogueBox1TilemapEntry ; 81/B42D
        .byte $06, $08, $88, $7B, $7E, $00, $4E, $C5, $7F

      aDialogueBox2TilemapEntry ; 81/B436
        .byte $06, $08, $88, $7B, $7E, $00, $B2, $C5, $7F

    .endsection Table81B42DSection


