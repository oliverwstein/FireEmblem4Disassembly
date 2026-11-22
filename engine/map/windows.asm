; The terrain window and the unit window on the map ("Ba" procs): creating and
; removing them, placing them away from the cursor, drawing them into
; aMapWindowFrameBuffer/aMapWindowTextBuffer, and rlHideMapWindows/rlShowMapWindows.

    .section CreateUnitWindowAndTerrainWindowProcsSection

      .al
      .xl

      rlCreateUnitWindowAndTerrainWindowProcs ; 85/9B59

        .al
        .autsiz
        .databank ?

        jsl rlCheckIfUnitWindowSettingOff
        ora #0
        bne +

          lda #(`procUnitWindow)<<8
          sta lR44+1
          lda #<>procUnitWindow
          sta lR44
          jsl rlProcEngineFindProc
          bcs +

            jsl rlProcEngineCreateProc
        
        +
        jsl rlCheckIfTerrainWindowSettingOff
        ora #0
        bne +

          lda #(`procTerrainWindow)<<8
          sta lR44+1
          lda #<>procTerrainWindow
          sta lR44
          jsl rlProcEngineFindProc
          bcs +

            jsl rlProcEngineCreateProc

        +
        rtl

        .databank 0

      rlClearUnitWindowAndTerrainWindowProcs ; 85/9B94

        .al
        .autsiz
        .databank ?

        lda #(`procUnitWindow)<<8
        sta lR44+1
        lda #<>procUnitWindow
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          jsl rlProcEngineFreeProc

        +
        lda #(`procTerrainWindow)<<8
        sta lR44+1
        lda #<>procTerrainWindow
        sta lR44
        jsl rlProcEngineFindProc
        bcc +

          jsl rlProcEngineFreeProc

        +
        rtl

        .databank 0

        ; 85/9BBD

    .endsection CreateUnitWindowAndTerrainWindowProcsSection


    .section Unsorted85C0CESection

      .al
      .xl

      rlHideMapWindows ; 85/C0CE

        .al
        .autsiz
        .databank ?

        ; Sets bit 7 of wMapSystemFlags.

        lda #$0080
        tsb wMapSystemFlags,b
        rtl

        .databank 0

        ; 85/C0D5

    .endsection Unsorted85C0CESection


    .section Unsorted85C0D5Section

      .al
      .xl

      rlShowMapWindows ; 85/C0D5

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears bit 7 of wMapSystemFlags and sets bit 3.

        lda #$0080
        trb wMapSystemFlags,b
        lda #$0008
        tsb wMapSystemFlags,b
        rtl

        .databank 0

        ; 85/C0E2

    .endsection Unsorted85C0D5Section


    .section Unsorted85C0E2Section

      .al
      .xl

      rsGetMapWindowPosition ; 85/C0E2

        .al
        .xl
        .autsiz
        .databank ?

        ; wInput0, wInput1 = column and row (aBody0).

        lda aProcSystem.aBody0,b,x
        and #$00FF
        sta aProcSystem.wInput0,b
        lda $0FD8,b,x
        and #$00FF
        sta aProcSystem.wInput1,b
        rts

        .databank 0

        ; 85/C0F5

      rsSetMapWindowPosition ; 85/C0F5

        .al
        .xl
        .autsiz
        .databank ?

        ; aBody0 = wInput0 (column), wInput1 (row).

        lda aProcSystem.wInput1,b
        xba
        ora aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        rts

        .databank 0

        ; 85/C100

      rsSetMapWindowSize ; 85/C100

        .al
        .xl
        .autsiz
        .databank ?

        ; aBody1 = wInput0 (width), wInput1 (height).

        lda aProcSystem.wInput1,b
        xba
        ora aProcSystem.wInput0,b
        sta aProcSystem.aBody1,b,x
        rts

        .databank 0

        ; 85/C10B

      rsGetMapWindowBufferOffset ; 85/C10B

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the window's offset in its 32x32 buffers. Carry set if it is off screen.

        lda aProcSystem.aBody0,b,x
        and #$00FF
        cmp #$0020
        bcs _C12A
        asl a
        sta wR10
        lda aProcSystem.aBody0,b,x
        and #$FF00
        cmp #$2000
        bcs _C12A
        lsr a
        lsr a
        clc
        adc wR10
        clc

        _C12A
        rts

        .databank 0

        ; 85/C12B

      rsSetMapWindowDrawRoutine ; 85/C12B

        .al
        .xl
        .autsiz
        .databank ?

        ; A = the routine that draws the window's contents (aBody2).

        sta aProcSystem.aBody2,b,x
        rts

        .databank 0

        ; 85/C12F

      rsCheckMapWindowHidden ; 85/C12F

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if the window is off (aBody3 bit 5), anything holds the map windows (the low byte of wMapSystemFlags), or bit 6 of bUnknown000E7B is set.

        lda aProcSystem.aBody3,b,x
        bit #$0020
        bne _C149
        lda wMapSystemFlags,b
        bit #$00FF
        bne _C149
        lda bUnknown000E7B,b
        bit #$0040
        bne _C149
        clc
        rts


        _C149
        sec
        rts

        .databank 0

        ; 85/C14B

      rsCheckMapWindowNeedsDrawing ; 85/C14B

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set if the window was hidden (aBody3 bit 7), is new (bit 6), or rlCheckMapCursorResting says so.

        lda aProcSystem.aBody3,b,x
        bit #$0080
        bne _C15E
        bit #$0040
        bne _C15E
        jsl rlCheckMapCursorResting
        bcc _C160

        _C15E
        sec
        rts


        _C160
        clc
        rts

        .databank 0

        ; 85/C162

      rsDrawMapWindow ; 85/C162

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs the window's draw routine (aBody2) with aMapWindowTextTilemapData, turns BG2 and BG3 on and clears bits 6 and 7.

        lda aProcSystem.aBody2,b,x
        beq _C19A
        sta aProcSystem.wInput1,b
        lda aProcSystem.aBody3,b,x
        sta aProcSystem.wInput0,b
        and #$FF3F
        sta aProcSystem.aBody3,b,x
        lda #$0000
        sta wBufferBG2HOFS
        sta wBufferBG2VOFS
        sta wBufferBG3HOFS
        sta wBufferBG3VOFS
        lda bBufferTM
        ora #$0006
        sta bBufferTM
        lda #(`aMapWindowTextTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aMapWindowTextTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        pea #<>_C19A - 1
        jmp ($0ED1)


        _C19A
        rts

        .databank 0

        ; 85/C19B

    .endsection Unsorted85C0E2Section


    .section Table85C19BSection

      .al
      .xl

      aMapWindowTextTilemapData ; 85/C19B
        .byte $20, $20, $00, $00, $00, $00, $CA, $E3, $7F

    .endsection Table85C19BSection


    .section Unsorted85C1A4Section

      .al
      .xl

      rsClearMapWindow ; 85/C1A4

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the window's frame ($7FDD4A) and text ($7FE3CA). Carry set if it was already hidden.

        phb
        phx
        lda aProcSystem.aBody3,b,x
        bit #$0080
        bne _C1F7
        lda aProcSystem.aBody1,b,x
        and #$00FF
        sta wR0
        asl a
        sta wR1
        lda $0FF8,b,x
        and #$00FF
        sta wR2
        lda #$0040
        sec
        sbc wR1
        sta wR3
        jsr rsGetMapWindowBufferOffset
        bcs _C1F7
        tax
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        _C1D7
        lda wR0
        sta wR1

        _C1DB
        lda #$0000
        sta $DD4A,b,x
        sta $E3CA,b,x
        inc x
        inc x
        dec wR1
        bne _C1DB
        txa
        clc
        adc wR3
        tax
        dec wR2
        bne _C1D7
        clc

        _C1F4
        plx
        plb
        .databank $7F
        rts


        _C1F7
        sec
        bra _C1F4

        .databank 0

        ; 85/C1FA

      rsClearMapWindowText ; 85/C1FA

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        lda aProcSystem.aBody3,b,x
        bit #$0080
        bne _C24A
        lda aProcSystem.aBody1,b,x
        and #$00FF
        sta wR0
        asl a
        sta wR1
        lda $0FF8,b,x
        and #$00FF
        sta wR2
        lda #$0040
        sec
        sbc wR1
        sta wR3
        jsr rsGetMapWindowBufferOffset
        bcs _C24A
        tax
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        _C22D
        lda wR0
        sta wR1

        _C231
        lda #$0000
        sta $E3CA,b,x
        inc x
        inc x
        dec wR1
        bne _C231
        txa
        clc
        adc wR3
        tax
        dec wR2
        bne _C22D
        clc

        _C247
        plx
        plb
        .databank $7F
        rts


        _C24A
        sec
        bra _C247

        .databank 0

        ; 85/C24D

      rsDrawMapWindowFrame ; 85/C24D

        .al
        .xl
        .autsiz
        .databank ?

        ; A = 45 frame tiles (the corners, edges and fill of a window 9 wide): draws them into the frame buffer.

        phx
        phy
        tay
        lda aProcSystem.aBody1,b,x
        and #$00FF
        sta wR0
        asl a
        sta wR1
        lda $0FF8,b,x
        and #$00FF
        sta wR2
        lda #$0040
        sec
        sbc wR1
        sta wR3
        jsr rsGetMapWindowBufferOffset
        bcs _C28E
        tax

        _C271
        lda wR0
        sta wR1

        _C275
        lda $0000,b,y
        sta aMapWindowFrameBuffer,x
        inc y
        inc y
        inc x
        inc x
        dec wR1
        bne _C275
        txa
        clc
        adc wR3
        tax
        dec wR2
        bne _C271
        clc

        _C28E
        ply
        plx
        rts

        .databank 0

        ; 85/C291

      rsUploadMapWindow ; 85/C291

        .al
        .xl
        .autsiz
        .databank ?

        ; DMAs the window's rows of the frame buffer (VRAM $5400) and, unless bit 1 of wMapSystemFlags is set, the text buffer (VRAM $5800).

        phx
        lda aProcSystem.aBody0,b,x
        bmi _C2EF
        and #$FF00
        lsr a
        lsr a
        sta wR10
        lsr a
        sta wR11
        lda aProcSystem.aBody1,b,x
        bmi _C2EF
        and #$FF00
        lsr a
        lsr a
        sta wR12
        lda #aMapWindowFrameBuffer >> 8
        sta lR18+1
        lda #<>aMapWindowFrameBuffer
        clc
        adc wR10
        sta lR18
        lda wR12
        sta wR0
        lda #$5400
        clc
        adc wR11
        sta wR1
        jsl rlDMAByPointer
        lda wMapSystemFlags,b
        bit #$0002
        bne _C2EF
        lda #aMapWindowTextBuffer >> 8
        sta lR18+1
        lda #<>aMapWindowTextBuffer
        clc
        adc wR10
        sta lR18
        lda wR12
        sta wR0
        lda #$5800
        clc
        adc wR11
        sta wR1
        jsl rlDMAByPointer

        _C2EF
        plx
        rts

        .databank 0

        ; 85/C2F1

      rsTurnOffMapWindow ; 85/C2F1

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bit 5 of aBody3.

        lda aProcSystem.aBody3,b,x
        ora #$0020
        sta aProcSystem.aBody3,b,x
        rts

        .databank 0

        ; 85/C2FB

      rsTurnOnMapWindow ; 85/C2FB

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody3,b,x
        and #$FFDF
        sta aProcSystem.aBody3,b,x
        rts

        .databank 0

        ; 85/C305

      procMapWindow ; 85/C305

        ; A map window proc with no draw routine of its own. Nothing in the build creates it.
        .structProcInfo "Ba", rlInitMapWindowProc, rlUpdateMapWindow, aProcTerrainWindowCode

    .endsection Unsorted85C1A4Section


    .section Unsorted85C30DSection

      .al
      .xl

      rlInitMapWindowProc ; 85/C30D

        .al
        .xl
        .autsiz
        .databank ?

        ; aBody2 = 0, aBody3 = $40 (new).

        lda #$0000
        sta aProcSystem.aBody2,b,x
        lda #$0040
        sta aProcSystem.aBody3,b,x
        rtl

        .databank 0

        ; 85/C31A

      rlUpdateMapWindow ; 85/C31A

        .al
        .xl
        .autsiz
        .databank ?

        ; Hidden: clears it once (bit 7). Otherwise, if it needs drawing, draws it. Then uploads.

        jsr rsCheckMapWindowHidden
        bcs _C32B
        jsr rsCheckMapWindowNeedsDrawing
        bcc _C33C
        jsr rsDrawMapWindow
        bcs _C33C
        bra _C339


        _C32B
        jsr rsClearMapWindow
        bcs _C33C
        lda aProcSystem.aBody3,b,x
        ora #$0080
        sta aProcSystem.aBody3,b,x

        _C339
        jsr rsUploadMapWindow

        _C33C
        rtl

        .databank 0

        ; 85/C33D

    .endsection Unsorted85C30DSection


    .section ProcScript85C33DSection

      .al
      .xl

      aProcTerrainWindowCode ; 85/C33D
        PROC_HALT

      procTerrainWindow ; 85/C33F
        .structProcInfo "Ba", rlProcTerrainWindowInit, rlProcTerrainWindowCycle, aProcTerrainWindowCode

    .endsection ProcScript85C33DSection


    .section Unsorted85C347Section

      .al
      .xl

      rlProcTerrainWindowInit ; 85/C347

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Position (2, 1), size 9x5, drawn by rsDrawTerrainWindow.

        jsl rlInitMapWindowProc
        lda #<>rsDrawTerrainWindow
        jsr rsSetMapWindowDrawRoutine
        lda #$0002
        sta aProcSystem.wInput0,b
        lda #$0001
        sta aProcSystem.wInput1,b
        jsr rsSetMapWindowPosition
        lda #$0009
        sta aProcSystem.wInput0,b
        lda #$0005
        sta aProcSystem.wInput1,b
        jsr rsSetMapWindowSize
        jsr rsKeepTerrainWindowAwayFromCursor
        lda aProcSystem.aBody3,b,x
        ora #$0004
        sta aProcSystem.aBody3,b,x
        rtl

        .databank 0

        ; 85/C37C

      rlProcTerrainWindowCycle ; 85/C37C

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda wMapSystemFlags,b
        bit #$00FD
        beq _C393
        lda aProcSystem.aBody3,b,x
        bit #$0080
        bne _C393
        lda #$FFFF
        jsl rlSetWindowColoursByRelation

        _C393
        lda wMapSystemFlags,b
        bit #$00FF
        beq _C3A4
        lda aProcSystem.aBody3,b,x
        ora #$0004
        sta aProcSystem.aBody3,b,x

        _C3A4
        jsl rlUpdateMapWindow
        rtl

        .databank 0

        ; 85/C3A9

      rsDrawTerrainWindow ; 85/C3A9

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsKeepTerrainWindowAwayFromCursor
        jsr rsDrawTerrainWindowContents
        lda aProcSystem.aBody3,b,x
        bit #$0004
        beq _C3C3
        and #$FFFB
        sta aProcSystem.aBody3,b,x
        lda #<>aTerrainWindowFrameTiles
        jsr rsDrawMapWindowFrame

        _C3C3
        clc
        rts

        .databank 0

        ; 85/C3C5


      aTerrainWindowFrameTiles ; 85/C3C5

        .word $2368, $2369, $2369, $2369, $2369, $2369, $2369, $2369
        .word $236A, $236B, $236C, $236D, $236C, $236D, $236D, $236C
        .word $236D, $2376, $2377, $236C, $236C, $236D, $236C, $236C
        .word $236D, $236C, $2376, $2377, $236C, $236C, $236D, $236C
        .word $236D, $236D, $236D, $236E, $2378, $236F, $236F, $236F
        .word $236F, $236F, $236F, $2379, $237A

    .endsection Unsorted85C347Section


    .section Unsorted85C41FSection

      .al
      .xl

      rsKeepTerrainWindowAwayFromCursor ; 85/C41F

        .al
        .xl
        .autsiz
        .databank ?

        ; Column $15 while the cursor is on the left half, 2 on the right (aBody3 bit 3 remembers).

        lda wCursorXOffset,b
        cmp #$0080
        bcs _C43D
        lda aProcSystem.aBody3,b,x
        bit #$0008
        bne _C466
        ora #$0008
        sta aProcSystem.aBody3,b,x
        lda #$0015
        sta aProcSystem.wInput0,b
        bra _C451


        _C43D
        lda aProcSystem.aBody3,b,x
        bit #$0008
        beq _C466
        and #$FFF7
        sta aProcSystem.aBody3,b,x
        lda #$0002
        sta aProcSystem.wInput0,b

        _C451
        lda #$0001
        sta aProcSystem.wInput1,b
        jsr rsClearMapWindow
        jsr rsSetMapWindowPosition
        lda aProcSystem.aBody3,b,x
        ora #$0004
        sta aProcSystem.aBody3,b,x

        _C466
        rts

        .databank 0

        ; 85/C467

      rsDrawTerrainWindowContents ; 85/C467

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsr rsClearMapWindowText
        lda aProcSystem.aBody0,b,x
        sta aProcSystem.wInput0,b
        jsr rsGetMapWindowBufferOffset
        sta aProcSystem.wInput1,b
        jsr rsGetCursorTerrain
        lda #$0101
        jsr rsDrawTerrainName
        lda #$0101
        jsr rsDrawTerrainWindowCastle
        lda #$00C8
        jsr rsDrawTerrainAvoid
        lda #$00C4
        jsr rsDrawTerrainRecoveryMark
        plx
        rts

        .databank 0

        ; 85/C494

      rsGetCursorTerrain ; 85/C494

        .al
        .xl
        .autsiz
        .databank ?

        ; wInput2 = the terrain under the cursor, with bit 15 set at a castle.

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        lda wR1
        xba
        lsr a
        lsr a
        clc
        adc wR0
        asl a
        tax
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        sta aProcSystem.wInput2,b
        jsl rlFindLocationAtTile
        bcs _C4DF
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeCastle
        bne _C4DF
        lda #$8000
        tsb aProcSystem.wInput2,b

        _C4DF
        rts

        .databank 0

        ; 85/C4E0

    .endsection Unsorted85C41FSection


    .section Unsorted85C55BSection

      .al
      .xl

      rsDrawTerrainName ; 85/C55B

        .al
        .xl
        .autsiz
        .databank ?

        ; A = row and column; not at a castle.

        sta wR10
        lda aProcSystem.wInput2,b
        and #$FF00
        bne _C58E
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda aProcSystem.wInput2,b
        jsl rlUnknown848EFB
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        lda aProcSystem.wInput0,b
        clc
        adc wR10
        tax
        jsl rlDrawMenuTextLine
        lda #$FFFF
        jsl rlSetWindowColoursByRelation

        _C58E
        rts

        .databank 0

        ; 85/C58F

      rsDrawTerrainWindowCastle ; 85/C58F

        .al
        .xl
        .autsiz
        .databank ?

        ; A = row and column: the castle's name, in its owner's colours.

        sta wR10
        lda aProcSystem.wInput2,b
        and #$FF00
        beq _C5CA
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetEventLocationEntryCastleName
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        lda aProcSystem.wInput0,b
        clc
        adc wR10
        tax
        jsl rlDrawMenuTextLine
        jsl rlGetLocationFactionSlotOwner
        bmi _C5CA
        tax
        lda #$0000
        jsl rlGetFactionRelation
        jsl rlSetWindowColoursByRelation

        _C5CA
        rts

        .databank 0

        ; 85/C5CB

      rsDrawTerrainAvoid ; 85/C5CB

        .al
        .xl
        .autsiz
        .databank ?

        ; A = offset: "+n" or "-n" for the terrain's avoid; nothing for terrains 0, 2 and $D.

        sta wR10
        lda aProcSystem.wInput2,b
        and #$00FF
        cmp #$0000
        beq _C630
        cmp #$0002
        beq _C630
        cmp #$000D
        beq _C630
        jsl rlGetTileTerrainAvoid
        sta wR0
        lda aProcSystem.wInput1,b
        clc
        adc wR10
        tax
        lda #$21DB
        sta aMapWindowTextBuffer,x
        inc x
        inc x
        lda wR0
        beq _C60A
        bpl _C603
        lda #$21DC
        bra _C606


        _C603
        lda #$21DD

        _C606
        sta aMapWindowTextBuffer,x

        _C60A
        inc x
        inc x
        phx
        lda wR0
        bpl _C615
        eor #$FFFF
        inc a

        _C615
        asl a
        tax
        lda aTwoDigitDecimalTable+1,x
        and #$00FF
        clc
        adc #$21DF
        plx
        sta aMapWindowTextBuffer,x
        inc x
        inc x
        lda #$21DE
        sta aMapWindowTextBuffer,x

        _C630
        rts

        .databank 0

        ; 85/C631

      rsDrawTerrainRecoveryMark ; 85/C631

        .al
        .xl
        .autsiz
        .databank ?

        ; A = offset: tile $21EA on terrains 9 and $16.

        sta wR10
        lda aProcSystem.wInput2,b
        and #$00FF
        cmp #$0009
        beq _C643
        cmp #$0016
        bne _C651

        _C643
        lda aProcSystem.wInput1,b
        clc
        adc wR10
        tax
        lda #$21EA
        sta aMapWindowTextBuffer,x

        _C651
        rts

        .databank 0

        ; 85/C652

    .endsection Unsorted85C55BSection


    .section ProcScript85C652Section

      .al
      .xl

      procUnitWindow ; 85/C652
        .structProcInfo "Ba", rlProcUnitWindowInit, rlProcUnitWindowClear, aProcUnitWindowCode

    .endsection ProcScript85C652Section


    .section Unsorted85C65ASection

      .al
      .xl

      rlProcUnitWindowInit ; 85/C65A

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Size 9x5, drawn by rsDrawUnitWindow; starts off.

        jsl rlInitMapWindowProc
        lda #<>rsDrawUnitWindow
        jsr rsSetMapWindowDrawRoutine
        lda #$FFFF
        sta aProcSystem.wInput0,b
        lda #$FFFF
        sta aProcSystem.wInput1,b
        jsr rsSetMapWindowPosition
        lda #$0009
        sta aProcSystem.wInput0,b
        lda #$0005
        sta aProcSystem.wInput1,b
        jsr rsSetMapWindowSize
        jsr rsTurnOffMapWindow
        rtl

        .databank 0

        ; 85/C686

      rlProcUnitWindowClear ; 85/C686

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsClearMapWindow
        bcs _C697
        jsr rsUploadMapWindow
        lda aProcSystem.aBody3,b,x
        ora #$0080
        sta aProcSystem.aBody3,b,x

        _C697
        rtl

        .databank 0

        ; 85/C698

      rlProcUnitWindowFindUnit ; 85/C698

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        pha
        jsr rsUnitWindowFindUnit
        lda #$0000
        sta aProcSystem.aBody7,b,x
        lda #<>rlProcUnitWindowCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        pla
        sta wSelectedUnitDataRAMPointer,b
        rtl

        .databank 0

        ; 85/C6B0

      rlProcUnitWindowCycle ; 85/C6B0

        .al
        .xl
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        pha
        jsr rsUnitWindowCheckCursorMoved
        jsr rsUnitWindowRefreshWhenCursorStops
        jsr rsUnitWindowBlinkStatus
        jsl rlUpdateMapWindow
        pla
        sta wSelectedUnitDataRAMPointer,b
        rtl

        .databank 0

        ; 85/C6C6


      aProcUnitWindowRefreshCode ; 85/C6C6

        PROC_SET_ONCYCLE rlProcUnitWindowClear

      aProcUnitWindowCode ; 85/C6CA

        PROC_YIELD 3
        PROC_SET_ONCYCLE rlProcUnitWindowFindUnit
        PROC_HALT

    .endsection Unsorted85C65ASection


    .section Unsorted85C6D2Section

      .al
      .xl

      rsUnitWindowFindUnit ; 85/C6D2

        .al
        .xl
        .autsiz
        .databank ?

        ; The unit under the cursor (aBody6); turns the window off if there is none.

        lda bUnknown000E7B,b
        bit #$0040
        bne _C711
        lda aProcSystem.aBody3,b,x
        and #$FFF7
        sta aProcSystem.aBody3,b,x
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        jsl rlGetUnitByCoordinates
        bcs _C70E
        lda wSelectedUnitDataRAMPointer,b
        sta aProcSystem.aBody6,b,x
        jsr rsTurnOnMapWindow
        bra _C711


        _C70E
        jsr rsTurnOffMapWindow

        _C711
        rts

        .databank 0

        ; 85/C712

      rsUnitWindowCheckCursorMoved ; 85/C712

        .al
        .xl
        .autsiz
        .databank ?

        ; Turns the window off when the cursor or the map has moved (aBody4/aBody5), and sets aBody3 bit 3.

        lda aProcSystem.aBody3,b,x
        bit #$0008
        bne _C74C
        lda wMapScrollXPixels,b
        asl a
        asl a
        asl a
        asl a
        ora wCursorXOffset,b
        sta wR10
        lda wMapScrollYPixels,b
        asl a
        asl a
        asl a
        asl a
        ora wCursorYOffset,b
        sta wR11
        lda wR10
        cmp aProcSystem.aBody4,b,x
        bne _C740
        lda wR11
        cmp aProcSystem.aBody5,b,x
        beq _C74C

        _C740
        jsr rsTurnOffMapWindow
        lda aProcSystem.aBody3,b,x
        ora #$0008
        sta aProcSystem.aBody3,b,x

        _C74C
        lda wR10
        sta aProcSystem.aBody4,b,x
        lda wR11
        sta aProcSystem.aBody5,b,x
        rts

        .databank 0

        ; 85/C757

      rsUnitWindowRefreshWhenCursorStops ; 85/C757

        .al
        .xl
        .autsiz
        .databank ?

        ; Once the cursor rests on a tile again, restarts the script at aProcUnitWindowRefreshCode.

        lda wMapSystemFlags,b
        bit #$00FF
        bne _C783
        lda aProcSystem.aBody3,b,x
        bit #$0008
        beq _C783
        lda wCursorXOffset,b
        bit #$000F
        bne _C783
        lda wCursorYOffset,b
        bit #$000F
        bne _C783
        lda #<>aProcUnitWindowRefreshCode
        sta aProcSystem.aHeaderCodeOffset,b,x
        lda #$0001
        sta aProcSystem.aHeaderSleepTimer,b,x

        _C783
        rts

        .databank 0

        ; 85/C784

      rsUnitWindowBlinkStatus ; 85/C784

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCheckMapWindowHidden
        bcs _C7AD
        inc aProcSystem.aBody7,b,x
        lda aProcSystem.aBody6,b,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStatus
        sec
        sbc #$0004
        bcc _C7AD
        lda aProcSystem.aBody7,b,x
        bit #$001F
        bne _C7AD
        lda aProcSystem.aBody3,b,x
        ora #$0040
        sta aProcSystem.aBody3,b,x

        _C7AD
        rts

        .databank 0

        ; 85/C7AE

      rsDrawUnitWindow ; 85/C7AE

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsPlaceUnitWindow
        jsr rsDrawUnitWindowContents
        lda #<>aUnitWindowFrameTiles
        jsr rsDrawMapWindowFrame
        jsr rsDrawUnitWindowPointer
        clc
        rts

        .databank 0

        ; 85/C7BF


      aUnitWindowFrameTiles ; 85/C7BF

        .word $2364, $2365, $2363, $2363, $2363, $2363, $2363, $6365
        .word $6364, $2360, $2361, $2361, $2361, $2361, $2361, $2361
        .word $6361, $6360, $2366, $2361, $2361, $2361, $2361, $2361
        .word $2361, $2361, $6366, $A360, $A361, $2361, $2361, $2361
        .word $2361, $2361, $E361, $E360, $A364, $A365, $A363, $A363
        .word $A363, $A363, $A363, $E365, $E364

    .endsection Unsorted85C6D2Section


    .section Unsorted85C819Section

      .al
      .xl

      rsPlaceUnitWindow ; 85/C819

        .al
        .xl
        .autsiz
        .databank ?

        ; Beside the cursor, kept on screen.

        phx
        lda wCursorXOffset,b
        cmp #$00D0
        bpl _C82C
        cmp #$0030
        bpl _C82F
        lda #$0028
        bra _C82F


        _C82C
        lda #$00C0

        _C82F
        lsr a
        lsr a
        lsr a
        sec
        sbc #$0003
        sta aProcSystem.wInput0,b
        lda wCursorYOffset,b
        cmp #$0030
        bpl _C845
        clc
        adc #$0048

        _C845
        lsr a
        lsr a
        lsr a
        sec
        sbc #$0006
        sta aProcSystem.wInput1,b
        lda aProcSystem.aBody3,b,x
        bit #$0080
        bne _C85C
        bit #$0020
        beq _C862

        _C85C
        jsr rsClearMapWindow
        jsr rsUploadMapWindow

        _C862
        jsr rsSetMapWindowPosition
        plx
        rts

        .databank 0

        ; 85/C867

      rsDrawUnitWindowContents ; 85/C867

        .al
        .xl
        .autsiz
        .databank ?

        ; Name, status and HP over max HP.

        phx
        lda aProcSystem.aBody6,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda aProcSystem.aBody0,b,x
        sta aProcSystem.wInput0,b
        lda aProcSystem.aBody7,b,x
        sta aProcSystem.wInput2,b
        lda #$2400
        sta aCurrentTilemapInfo,b
        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        lda aProcSystem.wInput0,b
        clc
        adc #$0101
        tax
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitStatus
        sec
        sbc #$0004
        bcc _C8B0
        asl a
        sta aProcSystem.wInput1,b
        lda aProcSystem.wInput2,b
        bit #$0020
        beq _C90E

        _C8B0
        lda #$25C0
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown85C983)<<8
        sta lR18+1
        lda #<>aUnknown85C983
        sta lR18
        lda aProcSystem.wInput0,b
        clc
        adc #$0301
        tax
        jsl rlDrawTileStringToTilemapEntry
        lda #(`aUnknown85C986)<<8
        sta lR18+1
        lda #<>aUnknown85C986
        sta lR18
        lda aProcSystem.wInput0,b
        clc
        adc #$0305
        tax
        jsl rlDrawTileStringToTilemapEntry
        lda #$24E0
        sta aCurrentTilemapInfo,b
        jsl rlGetSelectedUnitCurrentHP
        pha
        lda aProcSystem.wInput0,b
        clc
        adc #$0303
        tax
        pla
        jsl rlDrawSmallNumberToTilemapEntry
        jsl rlGetSelectedUnitMaxHP
        pha
        lda aProcSystem.wInput0,b
        clc
        adc #$0306
        tax
        pla
        jsl rlDrawSmallNumberToTilemapEntry
        bra _C97E


        _C90E
        lda #$2500
        sta aCurrentTilemapInfo,b
        ldx aProcSystem.wInput1,b
        lda #$85C9
        sta lR18+1
        lda <>aUnknown85C999,b,x
        sta lR18
        lda aProcSystem.wInput0,b
        clc
        adc #$0301
        tax
        jsl rlDrawTileStringToTilemapEntry
        lda #(`aUnknown85C997)<<8
        sta lR18+1
        lda #<>aUnknown85C997
        sta lR18
        lda aProcSystem.wInput0,b
        clc
        adc #$0307
        tax
        jsl rlDrawTileStringToTilemapEntry
        lda #$24E0
        sta aCurrentTilemapInfo,b
        jsl rlGetSelectedUnitStatusDuration
        pha
        pha
        lda aProcSystem.wInput0,b
        clc
        adc #$0305
        tax
        pla
        jsl rlDrawSmallNumberToTilemapEntry
        pla
        cmp #$000A
        bcs _C97E
        lda #$2500
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown85C997)<<8
        sta lR18+1
        lda #<>aUnknown85C997
        sta lR18
        lda aProcSystem.wInput0,b
        clc
        adc #$0305
        tax
        jsl rlDrawTileStringToTilemapEntry

        _C97E
        jsr rsSetUnitWindowColour
        plx
        rts

        .databank 0

        ; 85/C983

    .endsection Unsorted85C819Section


    .section Table85C983Section

      .al
      .xl

      aUnknown85C983 ; 85/C983
        .byte $07, $0F, $00

      aUnknown85C986 ; 85/C986
        .byte $1A, $00

      aUnknown85C988 ; 85/C988
        .byte $EC, $EF, $F0, $F1, $00

      aUnknown85C98D ; 85/C98D
        .byte $F1, $F2, $ED, $F3, $00

      aUnknown85C992 ; 85/C992
        .byte $EB, $EC, $ED, $EE, $00

      aUnknown85C997 ; 85/C997
        .byte $FF, $00

      aUnknown85C999 ; 85/C999
        .word <>aUnknown85C988, <>aUnknown85C98D, <>aUnknown85C992

    .endsection Table85C983Section


    .section Unsorted85C99FSection

      .al
      .xl

      rsSetUnitWindowColour ; 85/C99F

        .al
        .xl
        .autsiz
        .databank ?

        ; BG colour 4 by the unit's relation to the player (aUnitWindowColours).

        phx
        jsl rlGetSelectedUnitFactionSlot
        tax
        lda #$0000
        jsl rlGetFactionRelation
        asl a
        tax
        lda aUnitWindowColours,x
        sta $0108,b
        plx
        rts

        .databank 0

        ; 85/C9B7

    .endsection Unsorted85C99FSection


    .section Data85C9B7Section

      .al
      .xl

      aUnitWindowColours ; 85/C9B7

        ; Read by rsSetUnitWindowColour.

        .word $62D5, $5AFA, $4F58, $5318

        ; 85/C9BF

    .endsection Data85C9B7Section


    .section Unsorted85C9BFSection

      .al
      .xl

      rsDrawUnitWindowPointer ; 85/C9BF

        .al
        .xl
        .autsiz
        .databank ?

        ; The tail on the frame pointing at the cursor (aUnitWindowPointerTiles).

        phx
        phy
        jsr rsGetMapWindowPosition
        jsr rsGetMapWindowBufferOffset
        sta aProcSystem.wInput2,b
        lda wCursorXOffset,b
        lsr a
        lsr a
        lsr a
        sec
        sbc aProcSystem.wInput0,b
        bpl _C9DA
        eor #$FFFF
        inc a

        _C9DA
        asl a
        asl a
        tay
        lda wCursorYOffset,b
        lsr a
        lsr a
        lsr a
        cmp aProcSystem.wInput1,b
        bcs _C9F9
        lda <>aUnitWindowPointerTiles,b,y
        clc
        adc aProcSystem.wInput2,b
        tax
        lda <>aUnitWindowPointerTiles+2,b,y
        sta aMapWindowFrameBuffer,x
        bra _CA08


        _C9F9
        lda <>aUnitWindowPointerTiles+$20,b,y
        clc
        adc aProcSystem.wInput2,b
        tax
        lda <>aUnitWindowPointerTiles+$22,b,y
        sta aMapWindowFrameBuffer,x

        _CA08
        ply
        plx
        rts

        .databank 0

        ; 85/CA0B


      aUnitWindowPointerTiles ; 85/CA0B

        .word $0004, $A362, $0000, $0000, $0008, $A362, $000A, $A362
        .word $0000, $0000, $0008, $E362, $0000, $0000, $000C, $E362
        .word $0104, $2362, $0000, $0000, $0108, $2362, $010A, $2362
        .word $0000, $0000, $0108, $6362, $0000, $0000, $010C, $6362

    .endsection Unsorted85C9BFSection


    .section Unsorted85CA4BSection

      .al
      .xl

      rlRefreshUnitWindow ; 85/CA4B

        .al
        .autsiz
        .databank ?

        ; Restarts procUnitWindow's script at aProcUnitWindowRefreshCode.

        phb
        php
        phk
        plb
        phx

        lda #(`procUnitWindow)<<8
        sta $62+1
        lda #<>procUnitWindow
        sta $62
        jsl rlProcEngineFindProc
        bcc +

          lda #<>aProcUnitWindowRefreshCode
          sta aProcSystem.aHeaderCodeOffset,b,x
          lda #1
          sta aProcSystem.aHeaderSleepTimer,b,x

        +
        plx
        plp
        plb
        rtl

        .databank 0

        ; 85/CA70


      aMapExperienceWindowTilemapData ; 85/CA70

        .structMapMenuTilemapData 12, 3, aBG3TilemapBuffer, 0, $7FC54A

      aMapExperienceWindowData ; 85/CA79

        .long 0, 0, aMapExperienceWindowTilemapData
        .byte 5, 10, 11

    .endsection Unsorted85CA4BSection


