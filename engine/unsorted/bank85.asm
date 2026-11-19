; Code from bank $85 not yet assigned to a game system.

    .section Unsorted858000Section

      .al
      .xl

      aDialogueBoxTilemap .text ROM[$058000:$058250] ; 85/8000

    .endsection Unsorted858000Section


    .section Unsorted8583F8Section

      .al
      .xl

      rlUnknown8583F8 ; 85/83F8

        .al
        .autsiz
        .databank ?

        php
        phb
        phy
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown858516
        beq +

          jml _849A

        +
        lda wJoy1New
        bit #JOY_A
        beq +

          lda #$000A
          jsl rlUnknown808FAD
          
          jsl rlUnknown8582BA
          lda #1
          sta $00
          lda aProcSystem.aBody6,b,x
          sta $02
          jsl rlUnknown82F3E5
          jsr rlUnknown8584A1
          bra _End

        +
        lda wJoy1New
        bit #JOY_B
        beq +

          lda #$0021
          jsl rlUnknown808FAD

          jsl rlUnknown8582BA
          jsr rlUnknown8584A1
          bra _End
        
        +
        jsl rlUnknown82F3BE
        asl a
        sta $00

        lda wJoy1Repeated
        bit #JOY_Up
        beq _8472

          lda aProcSystem.aBody6,b,x
          sec
          sbc #2
          bpl +

            lda wJoy1New
            bit #JOY_Up
            beq _8472

              lda $00
              dec a

          +
          sta aProcSystem.aBody6,b,x
          lda #6
          jsl rlUnknown808FAD
          bra _849A
        
        _8472
        lda wJoy1Repeated
        bit #JOY_Down
        beq _849A

          lda aProcSystem.aBody6,b,x
          clc
          adc #2
          cmp $00
          beq +
          bcc +

            lda wJoy1New
            bit #JOY_Down
            beq _849A

              lda #1

          +
          sta aProcSystem.aBody6,b,x
          lda #6
          jsl rlUnknown808FAD
        
        _849A
        jsr rlUnknown858542
        
        _End
        ply
        plb
        plp
        rtl

        .databank 0

        ; 85/84A1

    .endsection Unsorted8583F8Section


    .section Unsorted8584A1Section

      .al
      .xl

      rlUnknown8584A1 ; 85/84A1

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85853D
        jsl rlProcEngineFreeProc
        rts

        .databank 0

        ; 85/84AA

    .endsection Unsorted8584A1Section


    .section Unsorted858516Section

      .al
      .xl

      rlUnknown858516 ; 85/8516

        .al
        .xl
        .autsiz
        .databank ?

        lda bBufferINIDISP
        bit #$0080
        bne _8539
        eor #$FFFF
        bit #$000F
        bne _8539
        lda $1077,b,x
        cmp $0548,b
        bne _8539
        lda $1057,b,x
        cmp $0547,b
        bne _8539
        lda #$0000
        rtl


        _8539
        lda #$0001
        rtl

        .databank 0

        ; 85/853D

      rlUnknown85853D ; 85/853D

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown82F2E3
        rtl

        .databank 0

        ; 85/8542

      rlUnknown858542 ; 85/8542

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlGetMapMenuPosition
        sep #$20
        asl a
        asl a
        asl a
        sta wR0
        xba
        clc
        adc $1097,b,x
        asl a
        asl a
        asl a
        clc
        adc #$02
        sta wR1
        rep #$20
        lda #$FF00
        trb wR0
        trb wR1
        jsl rlUnknown858516
        jsl rlUnknown88A704
        plx
        rts

        .databank 0

        ; 85/856E

    .endsection Unsorted858516Section


    .section Unsorted85860ESection

      .al
      .xl

      rlUnknown85860E ; 85/860E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aCurrentTilemapInfo,b
        pha
        lda #$2500
        sta aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$8647
        sta lR18
        jsl rlUnknown8788F7
        txa
        clc
        adc #$0100
        tax
        lda #$2510
        sta aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$8647
        sta lR18
        jsl rlUnknown8788F7
        pla
        sta aCurrentTilemapInfo,b
        plx
        rts

        .databank 0

        ; 85/8647

    .endsection Unsorted85860ESection


    .section Unsorted85864BSection

      .al
      .xl

      rlUnknown85864B ; 85/864B

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        jsl rlUnknown878921
        rtl

        .databank 0

        ; 85/865E

      rlUnknown85865E ; 85/865E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitClassNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        jsl rlUnknown878921
        rtl

        .databank 0

        ; 85/8671

    .endsection Unsorted85864BSection


    .section Unsorted858684Section

      .al
      .xl

      rlUnknown858684 ; 85/8684

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetItemNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        jsl rlUnknown878921
        rtl

        .databank 0

        ; 85/8697

    .endsection Unsorted858684Section


    .section Unsorted8586FASection

      .al
      .xl

      rlUnknown8586FA ; 85/86FA

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8582BA
        rtl

        .databank 0

        ; 85/86FF

    .endsection Unsorted8586FASection


    .section Unsorted858728Section

      .al
      .xl

      rlUnknown858728 ; 85/8728

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda $0521,b
        bit #$0080
        beq _End

          bit #$0020
          bne _End

            lda $0D79,b
            bit #$0001
            beq +

              jsr rlUnknown858D18
              lda #$0001
              trb $0D79,b

            +
            jsl rlUnknown878256

        _End
        plp
        plb
        rtl

        .databank 0

        ; 85/8751

    .endsection Unsorted858728Section


    .section Unsorted858751Section

      .al
      .xl

      rlUnknown858751 ; 85/8751

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown87829A
        lda wR12
        pha
        lda wR13
        pha
        jsl rlUnknown878472
        pla
        sta wR13
        pla
        sta wR12
        jsl rlUnknown8588F3
        lda wR10
        cmp @l wR12
        bcc _8779
        lda @l wR13
        cmp wR11
        bcs _877D

        _8779
        jsl rlUnknown8587E1

        _877D
        rtl

        .databank 0

        ; 85/877E

      rlUnknown85877E ; 85/877E

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        jsl rlGetMapMenuPosition
        ora #$8000
        sta $0534,b
        jsl rlUnknown858751
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/8793

    .endsection Unsorted858751Section


    .section Unsorted8587E1Section

      .al
      .xl

      rlUnknown8587E1 ; 85/87E1

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        phy
        jsl rlUnknown8785E3
        jsl rlMapMenuBuildTilemap
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/87F2

    .endsection Unsorted8587E1Section


    .section Unsorted85884ASection

      .al
      .xl

      rlUnknown85884A ; 85/884A

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        phy
        pha
        jsl rlUnknown87829A
        pla
        jsl rlSetMapMenuTilemapArea
        jsl rlUnknown8588F3
        jsl rlGetMapMenuYPositions
        lda wR10
        cmp @l wR12
        bcc _8871
        lda @l wR13
        cmp wR11
        bcs _8875

        _8871
        jsl rlUnknown858879

        _8875
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/8879

      rlUnknown858879 ; 85/8879

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown87829A
        jsl rlMapMenuBuildTilemap
        rtl

        .databank 0

        ; 85/8882

      rlUnknown858882 ; 85/8882

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta $0534,b
        jsl rlUnknown858751
        jsl rlUnknown8785A4
        rtl

        .databank 0

        ; 85/8891

      rlUnknown858891 ; 85/8891

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        phx
        phy
        lda wR13
        sec
        sbc wR12
        bcc _88EE
        asl a
        tay
        lda wR12
        xba
        lsr a
        lsr a
        clc
        adc #$7B88
        tax
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        _88B2
        lda #$030F
        sta $0000,b,x
        sta $0002,b,x
        sta $0004,b,x
        sta $0006,b,x
        sta $0008,b,x
        sta $000A,b,x
        sta $000C,b,x
        sta $000E,b,x
        sta $0010,b,x
        sta $0012,b,x
        sta $0014,b,x
        sta $0016,b,x
        sta $0018,b,x
        sta $001A,b,x
        sta $001C,b,x
        sta $001E,b,x
        txa
        clc
        adc #$0020
        tax
        dec y
        bne _88B2

        _88EE
        ply
        plx
        plp
        plb
        .databank $7E
        rtl

        .databank 0

        ; 85/88F3

      rlUnknown8588F3 ; 85/88F3

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        phx
        phy
        lda lUnknown000522,b
        ora lUnknown000522+1,b
        beq _8957
        lda wR12
        cmp #$0020
        bcs _8957
        lda wR13
        cmp #$0020
        bcs _8957
        jsl rlUnknown858891
        lda lMapMenuRAMEntryPointer,b
        pha
        lda lMapMenuRAMEntryPointer+1,b
        pha
        phb
        lda lUnknown000522,b
        sta lMapMenuRAMEntryPointer,b
        lda lUnknown000522+1,b
        sta lMapMenuRAMEntryPointer+1,b

        _8928
        jsl rlMapMenuBuildTilemap
        sep #$20
        lda @l lMapMenuRAMEntryPointer+2
        pha
        rep #$20
        plb
        .databank ?
        lda $000C,b,y
        ora $000D,b,y
        beq _894E
        lda $000C,b,y
        sta @l lMapMenuRAMEntryPointer
        lda $000D,b,y
        sta @l lMapMenuRAMEntryPointer+1
        bra _8928


        _894E
        plb
        .databank ?
        pla
        sta lMapMenuRAMEntryPointer+1,b
        pla
        sta lMapMenuRAMEntryPointer,b

        _8957
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/895C

    .endsection Unsorted85884ASection


    .section Unsorted858CD3Section

      .al
      .xl

      rsMapMenuTypeDialogue ; 85/8CD3

        .al
        .autsiz
        .databank ?

        phy
        jsl rlBuildMapMenuDialogueBox

        lda aProcSystem.wInput0,b
        bmi _End
        bne _Bottom

          ; Copy the 2x2 dialogue box tail to the correct spot

          ; Top
          jsl rlGetMapMenuTileIndex
          clc
          adc #C2I((10, 8), 32) * size(word)
          tax

          ; Load downwards facing tail
          ldy #TilemapEntry(C2I((10, 2)) + C2I((0, 48)), 0, true, false, false) 
          bra +

          _Bottom
          jsl rlGetMapMenuTileIndex
          clc
          adc #C2I((18, 0), 32) * size(word) ; $0024
          tax

          ; Load upwards facing tail
          ldy #TilemapEntry(C2I((8, 2)) + C2I((0, 48)), 0, true, false, false) 

          +
          tya
          sta aBG2TilemapBuffer.Page1,x
          tya
          inc a
          sta aBG2TilemapBuffer.Page1+2,x
          tya
          clc
          adc #C2I((0, 1))
          sta aBG2TilemapBuffer.Page1+$40,x
          tya
          clc
          adc #C2I((1, 1))
          sta aBG2TilemapBuffer.Page1+$40+2,x
        
        _End
        ply
        rts

        .databank 0

        ; 85/8D18

    .endsection Unsorted858CD3Section


    .section Unsorted858D18Section

      .al
      .xl

      rlUnknown858D18 ; 85/8D18

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        lda wUnknown00052A,b
        cmp wUnknown00052C,b
        bcs _8D5F
        lda wUnknown00052A,b
        cmp #$0020
        bcs _8D5F
        lda wUnknown00052C,b
        cmp #$0020
        bcs _8D5F
        lda #$7E7B
        sta lR18+1
        lda wUnknown00052A,b
        xba
        lsr a
        lsr a
        pha
        clc
        adc #$7B88
        sta lR18
        lda wUnknown00052C,b
        sec
        sbc wUnknown00052A,b
        inc a
        xba
        lsr a
        lsr a
        sta wR0
        pla
        lsr a
        clc
        adc #$5400
        sta wR1
        jsl rlDMAByPointer

        _8D5F
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 85/8D62

    .endsection Unsorted858D18Section


    .section Unsorted858EC5Section

      .al
      .xl

      rlUnknown858EC5 ; 85/8EC5

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown0007D8,b
        cmp #$0006
        beq _8ED3
        jsl rlUnknown85A234
        bra _8ED7


        _8ED3
        jsl rlUnknown85A227

        _8ED7
        lda $0F37,b,x
        bit #$0002
        bne _8F03
        bit #$0001
        beq _8F0F
        and #$FFFE
        sta $0F37,b,x
        jsl rlUnknown858F61
        jsl rlUnknown858F28
        bcc _8EFD
        sta $0534,b
        jsl rlUnknown858751
        bra _8F0F


        _8EFD
        jsl rlUnknown8785E3
        bra _8F0F


        _8F03
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        jsl rlUnknown859B48

        _8F0F
        rtl

        .databank 0

        ; 85/8F10

    .endsection Unsorted858EC5Section


    .section Unsorted858F28Section

      .al
      .xl

      rlUnknown858F28 ; 85/8F28

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        cmp #$0080
        bcc _8F47
        lda $1077,b,x
        beq _8F5F
        lda #$0000
        sta $1077,b,x
        jsl rlGetMapMenuPosition
        and #$FF00
        ora #$0002
        bra _8F5C


        _8F47
        lda $1077,b,x
        bne _8F5F
        lda #$0001
        sta $1077,b,x
        jsl rlGetMapMenuPosition
        and #$FF00
        ora #$0012

        _8F5C
        sec
        bra _8F60


        _8F5F
        clc

        _8F60
        rtl

        .databank 0

        ; 85/8F61

      rlUnknown858F61 ; 85/8F61

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        phx
        phy
        jsl rlLoadMapMenuEntryPointerFromProcBody
        ldy $1057,b,x
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        lda $0006,b,y
        sta wSelectedUnitDataRAMPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$9080
        sta lR18
        ldx #$0101
        jsl rlUnknown878921
        lda #$8500
        sta lR18+1
        lda #$9080
        sta lR18
        ldx #$0301
        jsl rlUnknown878921
        lda #$8500
        sta lR18+1
        lda #$9080
        sta lR18
        ldx #$0501
        jsl rlUnknown878921
        ldx #$0101
        jsl rlUnknown85864B
        ldx #$0301
        jsl rlUnknown85865E
        lda $0028,b,y
        jsl rlGetItemDataROMPointer
        ldx #$0501
        jsl rlUnknown858684
        lda #$24F0
        sta aCurrentTilemapInfo,b
        jsl rlGetSelectedUnitLevel
        ldx #$0706
        jsl rlUnknown878916
        lda $057C,b
        cmp #$0001
        bne _9017
        lda $0010,b,y
        ldx #$0904
        jsl rlUnknown878916
        lda $0012,b,y
        ldx #$0907
        jsl rlUnknown878916
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$9078
        sta lR18
        ldx #$0906
        jsl rlUnknown878921
        bra _9073


        _9017
        lda $0010,b,y
        ldx #$0906
        jsl rlUnknown878916
        lda $003A,b,y
        cmp #$00FF
        bcs _9032
        ldx #$0B06
        jsl rlUnknown878916
        bra _904F


        _9032
        lda #$2400
        sta aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$9092
        sta lR18
        ldx #$0B06
        jsl rlUnknown878921
        lda #$24F0
        sta aCurrentTilemapInfo,b

        _904F
        lda $003C,b,y
        ldx #$0D06
        jsl rlUnknown878916
        lda $0032,b,y
        cmp #$0064
        beq _906D
        lda $0032,b,y
        ldx #$0F06
        jsl rlUnknown878916
        bra _9073


        _906D
        ldx #$0F05
        jsr rlUnknown85860E

        _9073
        ply
        plx
        plp
        plb
        .databank $7E
        rtl

        .databank 0

        ; 85/9078

    .endsection Unsorted858F28Section


    .section Unsorted859108Section

      .al
      .xl

      rlUnknown859108 ; 85/9108

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda $0F37,b,x
        bit #$0002
        bne _914F
        lda $0F37,b,x
        bit #$0001
        bne _9121
        bit #$0008
        bne _9157

        _9121
        and #$FFFB
        ora #$0008
        sta $0F37,b,x
        jsr rlUnknown85915A
        lda $0F37,b,x
        and #$FFFE
        sta $0F37,b,x
        jsl rlUnknown858F28
        bcc _9149
        clc
        adc #$0008
        sta $0534,b
        jsl rlUnknown858751
        bra _9157


        _9149
        jsl rlUnknown8587E1
        bra _9157


        _914F
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc

        _9157
        rtl

        .databank 0

        ; 85/9158

    .endsection Unsorted859108Section


    .section Unsorted85915ASection

      .al
      .xl

      rlUnknown85915A ; 85/915A

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        phy
        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        ldy #$4EB5
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        lda #$24F0
        sta aCurrentTilemapInfo,b
        lda $0010,b,y
        ldx #$0101
        jsl rlUnknown878916
        lda $003A,b,y
        ldx #$0301
        jsl rlUnknown878916
        lda $003C,b,y
        ldx #$0501
        jsl rlUnknown878916
        lda $0032,b,y
        cmp #$0064
        beq _91A7
        lda $0032,b,y
        ldx #$0701
        jsl rlUnknown878916
        bra _91AD


        _91A7
        ldx #$0700
        jsr rlUnknown85860E

        _91AD
        plx
        ply
        plp
        plb
        .databank $7E
        rts

        .databank 0

        ; 85/91B2

      rlUnknown8591B2 ; 85/91B2

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        phx
        lda $057C,b
        cmp #$0002
        beq _9219
        cmp #$0003
        beq _9219
        cmp #$0004
        beq _9219
        jsl rlActionStructGetBattleStats
        lda #$8500
        sta lR44+1
        lda #$8D77
        sta lR44
        jsl rlProcEngineFindProc
        bcs _91E6
        lda #$0005
        jsl rlProcEngineCreateProcByIndex
        bra _91EF


        _91E6
        lda $0F37,b,x
        ora #$0001
        sta $0F37,b,x

        _91EF
        lda $057C,b
        cmp #$0001
        beq _9219
        lda #$8500
        sta lR44+1
        lda #$90AD
        sta lR44
        jsl rlProcEngineFindProc
        bcs _9210
        lda #$0004
        jsl rlProcEngineCreateProcByIndex
        bra _9219


        _9210
        lda $0F37,b,x
        ora #$0001
        sta $0F37,b,x

        _9219
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/921D

      rlUnknown85921D ; 85/921D

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        phx
        lda wR0
        pha
        lda wR1
        pha
        lda #$8500
        sta lR44+1
        lda #$8D77
        sta lR44
        jsl rlProcEngineFindProc
        bcc _9262
        lda $0F37,b,x
        ora #$0002
        sta $0F37,b,x
        jsl rlUnknown858EC5
        lda #$8500
        sta lR44+1
        lda #$90AD
        sta lR44
        jsl rlProcEngineFindProc
        bcc _9262
        lda $0F37,b,x
        ora #$0002
        sta $0F37,b,x
        jsl rlUnknown859108

        _9262
        pla
        sta wR1
        pla
        sta wR0
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/926C

    .endsection Unsorted85915ASection


    .section Unsorted859B48Section

      .al
      .xl

      rlUnknown859B48 ; 85/9B48

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0004

        _9B4C
        lda $7FEB0A,x
        sta $010A,b,x
        dec x
        dec x
        bpl _9B4C
        plx
        rtl

        .databank 0

        ; 85/9B59

    .endsection Unsorted859B48Section


    .section Unsorted859BBDSection

      .al
      .xl

      rlUnknown859BBD ; 85/9BBD

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0010

        _9BC1
        lda $DE0000,x
        sta aBGPaletteBuffer,b,x
        inc x
        inc x
        cpx #$0020
        bmi _9BC1
        plx
        rtl

        .databank 0

        ; 85/9BD1

    .endsection Unsorted859BBDSection


    .section Unsorted859D60Section

      .al
      .xl

      rlUnknown859D60 ; 85/9D60

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$001E

        _9D64
        lda $0ED7,b,x
        cmp #$9BE6
        bne _9D7B
        lda $1077,b,x
        cmp wR0
        bne _9D7B
        lda #$0001
        sta $1057,b,x
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


    .section Unsorted859FCDSection

      .al
      .xl

      rlUnknown859FCD ; 85/9FCD

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlFreeHDMAEntry0
        lda #$0000
        sta wR40
        lda #$8500
        sta lR44+1
        lda #$9D88
        sta lR44
        jsl rlHDMAEngineCreateEntryByIndex
        rtl

        .databank 0

        ; 85/9FE5

    .endsection Unsorted859FCDSection


    .section Unsorted85A1E7Section

      .al
      .xl

      rlUnknown85A1E7 ; 85/A1E7

        .al
        .autsiz
        .databank ?

        phx
        jsl rlUnknown878921
        jsl rlGetMenuTextStringLength
        plx
        phx
        txa
        clc
        adc wR10
        tax
        lda lR19
        sta lR18
        lda lR19+1
        sta lR18+1
        jsl rlUnknown878921
        plx
        rtl

        .databank 0

    .endsection Unsorted85A1E7Section


    .section Unsorted85A227Section

      .al
      .xl

      rlUnknown85A227 ; 85/A227

        .al
        .xl
        .autsiz
        .databank ?

        pha
        sep #$20
        lda bBufferTM
        and #$F9
        sta bBufferTM
        rep #$20
        pla
        rtl

        .databank 0

        ; 85/A234

      rlUnknown85A234 ; 85/A234

        .al
        .xl
        .autsiz
        .databank ?

        pha
        sep #$20
        lda bBufferTM
        ora #$06
        sta bBufferTM
        rep #$20
        pla
        rtl

        .databank 0

        ; 85/A241

    .endsection Unsorted85A227Section


    .section Unsorted85AB32Section

      .al
      .xl

      rlUnknown85AB32 ; 85/AB32

        .al
        .xl
        .autsiz
        .databank ?

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


    .section Unsorted85ABF6Section

      .al
      .xl

      procUnknown85ABF6 ; 85/ABF6

        .structProcInfo "PS", $85AC02, $85AC40, $85AEAC

    .endsection Unsorted85ABF6Section


    .section Unsorted85ABFESection

      .al
      .xl

      aUnknown85ABFE ; 85/ABFE

        .byte 0, 0, 0, 1

    .endsection Unsorted85ABFESection


    .section Unsorted85AC02Section

      .al
      .xl

      rlUnknown85AC02 ; 85/AC02

        .al
        .autsiz
        .databank ?

        phx
        lda #$0008
        tsb $0788,b

        lda $0302,b
        sta $1077,b,x
        stz $0302,b

        lda #$0078
        sta aProcSystem.aBody6,b,x

        lda #2
        sta $7FEAAC

        stz $89
        stz $87
        stz $85
        stz $83

        jsl rlUnknown85A227
        jsr rlUnknown85B009
        jsr rlUnknown85B07C

        plx
        phx
        lda wActiveFactionSlot,b
        jsl rlGetFactionBattleBannerID
        jsl rlUnknown91AFC2

        plx
        rtl

        .databank 0

        ; 85/AC40

    .endsection Unsorted85AC02Section


    .section Unsorted85B009Section

      .al
      .xl

      rlUnknown85B009 ; 85/B009

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _B00D
        lda $0108,b,x
        sta $7FEACE,x
        lda $01D0,b,x
        sta $7FEAD6,x
        lda $01D8,b,x
        sta $7FEADE,x
        lda $01F0,b,x
        sta $7FEAEE,x
        lda $01F8,b,x
        sta $7FEB0E,x
        inc x
        inc x
        cpx #$0008
        bmi _B00D
        plx
        rts

        .databank 0

        ; 85/B039

    .endsection Unsorted85B009Section


    .section Unsorted85B07CSection

      .al
      .xl

      rlUnknown85B07C ; 85/B07C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        ldx wActiveFactionSlot,b
        jsl rlGetFactionRelation
        sta wR0
        jsr rlUnknown85B091
        jsr rlUnknown85B107
        plx
        rts

        .databank 0

        ; 85/B091

      rlUnknown85B091 ; 85/B091

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda #$85
        sta $7FEACC
        rep #$20
        lda wR0
        asl a
        tax
        lda $85B0BF,x
        sta $7FEACA
        sta wR1
        ldx #$0000

        _B0AD
        lda (wR1)
        sta $01D0,b,x
        inc x
        inc x
        inc wR1
        inc wR1
        cpx #$0010
        bmi _B0AD
        plx
        rts

        .databank 0

        ; 85/B0BF

    .endsection Unsorted85B07CSection


    .section Unsorted85B107Section

      .al
      .xl

      rlUnknown85B107 ; 85/B107

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wR0
        asl a
        tax
        lda $85B127,x
        sta wR1
        ldx #$0000

        _B115
        lda (wR1)
        sta $0108,b,x
        inc x
        inc x
        inc wR1
        inc wR1
        cpx #$0008
        bmi _B115
        plx
        rts

        .databank 0

        ; 85/B127

    .endsection Unsorted85B107Section


    .section Unsorted85B14FSection

      .al
      .xl

      rlUnknown85B14F ; 85/B14F

        .al
        .xl
        .autsiz
        .databank ?

        lda $0ECF,b
        sta wSelectedUnitDataRAMPointer,b
        lda #$0008
        jsl rlGetItemIDByInventorySlot
        jsl rlGetItemDataROMPointer
        lda wCurrentItemDataROMPointer,b
        sta $0ECF,b
        lda wSelectedUnitDataRAMPointer,b
        sta $0ED5,b
        jsl rlUnknown85B52F
        jsl rlUnknown85B520
        lda wSelectedUnitDataRAMPointer,b
        sta $0ECF,b
        lda wCurrentItemDataROMPointer,b
        sta $0ED1,b
        lda #(`procUnknown85B18F)<<8
        sta lR44+1
        lda #<>procUnknown85B18F
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/B18F

    .endsection Unsorted85B14FSection


    .section Unsorted85B18FSection

      .al
      .xl

      procUnknown85B18F .structProcInfo "PW", rlProcUnknown85B18FInit, rlProcUnknown85B18FCycle1, $85B2D8 ; 85/B18F

        ; 85/B197

    .endsection Unsorted85B18FSection


    .section Unsorted85B1B0Section

      .al
      .xl

      rlProcUnknown85B18FInit ; 85/B1B0

        .al
        .autsiz
        .databank ?

        phx
        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody4,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody5,b,x
        lda #1
        sta aProcSystem.aBody6,b,x
        jsl rlUnknown85BC9E
        plx
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda aProcSystem.aBody5,b,x
        sta wCurrentItemDataROMPointer,b
        jsr rlUnknown85B45C
        bcs +

          lda #$2000
          sta aCurrentTilemapInfo.wBaseTile,b
          jsr rlUnknown85B489
          jsl rlUnknown8587E1
          jsl rlUnknown85A227
          jsl rlFreeHDMAEntry0

        +
        rtl

        .databank 0

      rlProcUnknown85B18FCycle1 ; 85/B1EF

        .al
        .autsiz
        .databank ?

        lda #<>rlProcUnknown85B18FCycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcUnknown85B18FCycle2 ; 85/B1F6

        .al
        .autsiz
        .databank ?

        jsr rlUnknown85B2DA
        jsr rlUnknown85B307
        jsl rlUnknown85A234
        lda #$B207
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/B207

    .endsection Unsorted85B1B0Section


    .section Unsorted85B2DASection

      .al
      .xl

      rlUnknown85B2DA ; 85/B2DA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda $1057,b,x
        sta wSelectedUnitDataRAMPointer,b
        ldy #$0007

        _B2E5
        phy
        tya
        asl a
        and #$000F
        ora #$0040
        tax
        tya
        inc a
        jsl rlGetItemIDByInventorySlot
        jsl rlUnknown8BBE68
        lda #$0006
        jsl rlUnknown8BC43A
        ply
        dec y
        bpl _B2E5
        ply
        plx
        rts

        .databank 0

        ; 85/B307

      rlUnknown85B307 ; 85/B307

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        lda wR0
        pha
        lda wR1
        pha
        lda wR2
        pha
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlGetMapMenuPosition
        pha
        and #$FF00
        xba
        asl a
        asl a
        asl a
        clc
        adc #$0008
        sta wR1
        pla
        and #$00FF
        asl a
        asl a
        asl a
        clc
        adc #$0010
        sta wR0
        ldx #$000C
        stz wR4
        stz wR5

        _B33C
        phx
        ldy $9831,b,x
        jsl rlPushToOAMBuffer
        plx
        dec x
        dec x
        bpl _B33C
        lda wR1
        sec
        sbc #$0020
        sta wR1
        ldx #$000E
        ldy $9831,b,x
        jsl rlPushToOAMBuffer
        pla
        sta wR2
        pla
        sta wR1
        pla
        sta wR0
        plx
        ply
        rts

        .databank 0

        ; 85/B367

    .endsection Unsorted85B2DASection


    .section Unsorted85B45CSection

      .al
      .xl

      rlUnknown85B45C ; 85/B45C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wCurrentItemDataROMPointer,b
        pha
        lda wCurrentItemDataROMPointer,b
        sta $7FEABA
        ldx #$000C

        _B46B
        txa
        lsr a
        inc a
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _B486
        sta $7FEABC,x
        dec x
        dec x
        bpl _B46B
        clc

        _B480
        pla
        sta wCurrentItemDataROMPointer,b
        plx
        rts


        _B486
        sec
        bra _B480

        .databank 0

        ; 85/B489

      rlUnknown85B489 ; 85/B489

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        jsl rlGetFirstEquippableWeaponInInventory
        sta wR1
        ldy #$000C
        lda #$0D04
        sta wR0

        _B499
        lda #$2000
        sta aCurrentTilemapInfo,b
        tya
        lsr a
        inc a
        cmp wR1
        bne _B4BB
        lda #$8500
        sta lR18+1
        lda #$B4E9
        sta lR18
        lda wR0
        clc
        adc #$0008
        tax
        jsl rlUnknown878921

        _B4BB
        tyx
        lda $7FEABC,x
        sta wCurrentItemDataROMPointer,b
        jsr rlUnknown85B4ED
        jsl rlGetItemNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        ldx wR0
        jsl rlUnknown878921
        lda wR0
        sec
        sbc #$0200
        sta wR0
        dec y
        dec y
        bpl _B499
        ply
        plx
        rts

        .databank 0

        ; 85/B4E9

    .endsection Unsorted85B45CSection


    .section Unsorted85B4EDSection

      .al
      .xl

      rlUnknown85B4ED ; 85/B4ED

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlCheckItemObtainable
        bcs _B4F9
        lda #$2400
        sta aCurrentTilemapInfo,b

        _B4F9
        rts

        .databank 0

        ; 85/B4FA

    .endsection Unsorted85B4EDSection


    .section Unsorted85B520Section

      .al
      .xl

      rlUnknown85B520 ; 85/B520

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8500
        sta lR44+1
        lda #$B63B
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/B52F

      rlUnknown85B52F ; 85/B52F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta $0ED1,b
        sta $0ED3,b
        lda #$8500
        sta lR44+1
        lda #$B6E3
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/B547

    .endsection Unsorted85B520Section


    .section Unsorted85B7D1Section

      .al
      .xl

      rlUnknown85B7D1 ; 85/B7D1

        .al
        .xl
        .autsiz
        .databank ?

        and #$FF00
        sta wR7
        txa
        and #$FF00
        sta wR6
        lda lR18
        pha
        lda lR18+1
        pha
        jsl rlGetMenuTextStringLength
        lda wR10
        pha
        lda lR19
        sta lR18
        lda lR19+1
        sta lR18+1
        jsl rlGetMenuTextStringLength
        pla
        clc
        adc #$0002
        clc
        adc wR10
        pha
        and #$00FF
        tsb wR6
        pla
        sta wR0
        lda #$0020
        sec
        sbc wR0
        lsr a
        and #$00FF
        tsb wR7
        pla
        sta lR18+1
        pla
        sta lR18
        lda wR7
        ldx wR6
        rtl

        .databank 0

        ; 85/B81D

    .endsection Unsorted85B7D1Section


    .section Unsorted85B81DSection

      .al
      .xl

      rlBuildMapMenuDialogueBox ; 85/B81D

        .al
        .autsiz
        .databank ?

        phy
        phx
        jsl rlGetMapMenuTilemapArea
        and #$00FF
        sta wR5
        cmp #32
        beq _FullWidth

        lda aProcSystem.wInput0,b
        bne _Bottom

        ; Top
        lda #32
        sec
        sbc wR5
        pha
        sta wR13
        lda #3
        sta wR14
        jsl rlUnsignedDivide16By8
        pla
        lsr a
        sta wR10

        lda wR13
        sec
        sbc wR10
        bra _B870

        _FullWidth
        lda #0
        bra _B870

        _Bottom
        lda #32
        sec
        sbc wR5
        pha
        sta wR13
        lda #3
        sta wR14
        jsl rlUnsignedDivide16By8
        pla
        lsr a
        sta wR10
        lda wR13
        asl a
        sec
        sbc wR10

        _B870
        ; Get the middle of the box as the destination tile
        asl a
        sta wR3
        jsl rlGetMapMenuTileIndex
        clc
        adc #$027E
        sec
        sbc #32
        clc
        adc wR5
        clc
        adc wR3
        sta wR7

        ; Source offset
        lda #$027E
        sta wR6

          _Loop
          ; Write the right part to the tilemap
          lda wR6
          tay

          lda wR5
          lsr a
          dec a
          sta wR4
          ldx wR7
          jsr rsDialogueBoxWriteToBG2

          ; Write the left part to the tilemap
          lda wR6
          sec
          sbc #32 * size(word)
          clc
          adc wR5
          tay

          lda wR5
          lsr a
          dec a
          sta wR4
          jsr rsDialogueBoxWriteToBG2

          lda wR7
          sec
          sbc #32 * size(word)
          sta wR7
          lda wR6
          sec
          sbc #32 * size(word)
          sta wR6
          bpl _Loop

        plx
        ply
        rtl

        .databank 0

      rsDialogueBoxWriteToBG2 ; 85/B8C2

        .al
        .autsiz
        .databank $85

        ; Y = source offset
        ; X = destination offset
        ; wR4 = count

          _Loop
          lda aDialogueBoxTilemap,y
          clc
          adc #$0300
          sta aBG2TilemapBuffer.Page1,x
          dec x
          dec x
          dec y
          dec y
          dec wR4
          bpl _Loop

        rts

        .databank 0

        ; 85/B8D6

    .endsection Unsorted85B81DSection


    .section Unsorted85B8D6Section

      .al
      .xl

      rlUnknown85B8D6 ; 85/B8D6

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8500
        sta lR44+1
        lda #$B8FA
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/B8E5

    .endsection Unsorted85B8D6Section


    .section Unsorted85B8EESection

      .al
      .xl

      aUnknown85B8EE ; 85/B8EE

        .long 0
        .long 0
        .long $85B8E5

        ; 00 01 01 50 57 06

    .endsection Unsorted85B8EESection


    .section Unsorted85B9D4Section

      .al
      .xl

      rlProcUnknown85B9D4Cycle1 ; 85/B9D4

        .al
        .autsiz
        .databank ?

        lda $04BA,b
        bne +

          jsl rlUnknown85A234
          lda #$00F7
          jsl rlUnknown808FA3
          lda aProcSystem.aBody4,b,x
          jsl rlUnknown808FAD
          lda #$B9F2
          sta aProcSystem.aHeaderOnCycle,b,x

        +
        rtl

        .databank 0

        ; 85/B9F2

    .endsection Unsorted85B9D4Section


    .section Unsorted85BA41Section

      .al
      .xl

      procUnknown85BA41 .structProcInfo "PW", rlProcUnknown85BA41Init, $85BAC7, $858398 ; 85/BA41

        .long $85BA35
        .byte 1

    .endsection Unsorted85BA41Section


    .section Unsorted85BA4DSection

      .al
      .xl

      rlProcUnknown85BA41Init ; 85/BA4D

        .al
        .autsiz
        .databank ?

        jsl rlUnknown85BC9E
        jsl rlUnknown85C0CE

        lda #$016E
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody6,b,x
        lda aProcSystem.wInput3,b
        jsl rlGetLocationEventDataEntry
        jsl rlGetEventLocationEntryCastleName
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlGetMenuTextStringLength

        lda wR10
        clc
        adc #12
        sta wR0
        ora #$0400
        jsl rlSetMapMenuTilemapArea

        lda #$0020
        sec
        sbc wR0
        lsr a
        ora #$0C00
        jsl rlSetMapMenuPosition

        lda #(`$85BAB3)<<8
        sta lR19+1
        lda #<>$85BAB3
        sta lR19
        ldx #$0102
        lda #$2000
        sta aCurrentTilemapInfo.wBaseTile,b
        jsl rlUnknown85A1E7
        jsl rlUnknown85877E
        rtl

        .databank 0

        ; 85/BAB3

    .endsection Unsorted85BA4DSection


    .section Unsorted85BB2ESection

      .al
      .xl

      rlUnknown85BB2E ; 85/BB2E

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown85BA41)<<8
        sta lR44+1
        lda #<>procUnknown85BA41
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/BB3D

    .endsection Unsorted85BB2ESection


    .section Unsorted85BBA5Section

      .al
      .xl

      rlUnknown85BBA5 ; 85/BBA5

        .al
        .xl
        .autsiz
        .databank ?

        pha
        phy
        phx
        and #$FF00
        asl a
        asl a
        asl a
        sta wR0
        txa
        and #$FF00
        asl a
        asl a
        asl a
        xba
        ora wR0
        sta wR43
        lda #$000F
        sta wR42
        jsl rlUnknown859FCD
        plx
        ply
        pla
        sty $0ED1,b
        sta $0ED3,b
        stx $0ED5,b
        lda #$8500
        sta lR44+1
        lda #$BB52
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/BBE0

      rlUnknown85BBE0 ; 85/BBE0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$8500
        sta lR44+1
        lda #$BB52
        sta lR44
        jsl rlProcEngineFindProc
        bcc _BBFD
        lda $0F37,b,x
        ora #$0001
        sta $0F37,b,x
        plx
        sec
        rtl


        _BBFD
        plx
        clc
        rtl

        .databank 0

        ; 85/BC00

    .endsection Unsorted85BBA5Section


    .section Unsorted85BC0FSection

      .al
      .xl

      procUnknown85BC0F .structProcInfo "PW", rlProcUnknown85BC0FInit, rlProcUnknown85B9D4Cycle1, $858398 ; 85/BC0F

        .long $85B8EE
        .byte 1

    .endsection Unsorted85BC0FSection


    .section Unsorted85BC1BSection

      .al
      .xl

      rlProcUnknown85BC0FInit ; 85/BC1B

        .al
        .autsiz
        .databank ?

        phx
        jsl rlUnknown85BC9E
        lda #$0093
        sta aProcSystem.aBody5,b,x
        lda aProcSystem.wInput2,b
        jsl rlGetItemNamePointerByItemID
        lda $0571,b
        sta lR18
        lda $0571+1,b
        sta lR18+1
        lda #(`aItemObtainedText)<<8
        sta lR19+1
        lda #<>aItemObtainedText
        sta lR19
        lda aProcSystem.wInput3,b
        ldx #$0400
        jsl rlUnknown85B7D1
        pha
        dec a
        jsl rlSetMapMenuPosition
        txa
        inc a
        inc a
        jsl rlSetMapMenuTilemapArea
        pla
        and #$FF00
        lda #$2000
        sta aCurrentTilemapInfo.wBaseTile,b
        ldx #$0102
        jsl rlUnknown85A1E7
        jsl rlUnknown8587E1
        plx
        lda aProcSystem.wInput2,b
        cmp #$0050
        bne +

        lda aProcSystem.aBody5,b,x
        clc
        adc #$003C
        sta aProcSystem.aBody5,b,x
        lda #$0096
        bra ++
        
        +
        lda #$0092
        
        +
        sta aProcSystem.aBody4,b,x
        rtl

        .databank 0

    .endsection Unsorted85BC1BSection


    .section ItemObtainedTextSection

      .al
      .xl

      aItemObtainedText ; 85/BC8C

        .enc "SJIS"
        .text "　をてにいれた！\n"

    .endsection ItemObtainedTextSection


    .section Unsorted85BC9ESection

      .al
      .xl

      rlUnknown85BC9E ; 85/BC9E

        .al
        .autsiz
        .databank ?

        jsl rlStallProcUntilMapMenuDataLoaded
        lda #0
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        lda #$20FF
        sta $053C,b
        jsl rlUnknown8788E5
        jsl rlUnknown85A234
        rtl

        .databank 0

        ; 85/BCB8

    .endsection Unsorted85BC9ESection


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
        lda $85BD8D,x
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


    .section Unsorted85C0CESection

      .al
      .xl

      rlUnknown85C0CE ; 85/C0CE

        .al
        .autsiz
        .databank ?

        lda #$0080
        tsb $0788,b
        rtl

        .databank 0

        ; 85/C0D5

    .endsection Unsorted85C0CESection


    .section Unsorted85C0D5Section

      .al
      .xl

      rlUnknown85C0D5 ; 85/C0D5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0080
        trb $0788,b
        lda #$0008
        tsb $0788,b
        rtl

        .databank 0

        ; 85/C0E2

    .endsection Unsorted85C0D5Section


    .section Unsorted85CA4BSection

      .al
      .xl

      rlUnknown85CA4B ; 85/CA4B

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        lda #(`$85C652)<<8
        sta $62+1
        lda #<>$85C652
        sta $62
        jsl rlProcEngineFindProc
        bcc +

          lda #$C6C6
          sta $0F77,b,x
          lda #1
          sta $0F97,b,x

        +
        plx
        plp
        plb
        rtl

        .databank 0

        ; 85/CA70

    .endsection Unsorted85CA4BSection


    .section Unsorted85DF3FSection

      .al
      .xl

      rlUnknown85DF3F ; 85/DF3F

        .al
        .autsiz
        .databank ?

        phx
        jsl rlUnknown88AF7B
        ldx $0772,b
        jsl rlUnknown84CDA4

        lda #<>$80B6B6
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rtl

        .databank 0

        ; 85/DF61



        ; 85/E070

; 57 DE 85 01 01 81 40 82 B1 82 A4 82 B0 82 AB 00 00 ; attack
; 7C DE 85 01 01 81 40 82 C6 82 C2 82 B0 82 AB 00 00 ; assault
; AB DE 85 01 01 81 40 82 A8 82 C7 82 E9 00 00 ; dance
; D6 DE 85 01 01 81 40 82 C2 82 A6 00 00 ; staff
; FB DE 85 01 01 81 40 82 E0 82 BF 82 E0 82 CC 00 00 ; belongings?
; C2 DF 85 01 01 81 40 82 CD 82 C8 82 B7 00 00 ; talk
; 30 E0 85 01 01 81 40 82 A0 82 B0 82 E9 00 00 ; give?
; 50 E0 85 01 01 81 40 82 A0 82 B0 82 E9 00 00 ; give2?
; 12 E0 85 01 01 81 40 82 BD 82 B7 82 AF 82 E9 00 00 ; help?
; 6F DF 85 01 01 81 40 82 B9 82 A2 82 A0 82 C2 00 00 ; seize
; 20 DF 85 01 01 81 40 82 CD 82 A2 82 E9 00 00 ; enter
; 3F DF 85 01 01 81 40 82 DC 82 BF 00 00 ; town?
; 61 DF 85 01 01 81 40 82 DE 82 E7 00 00 ; village
; 7D DF 85 01 01 81 40 82 B5 82 E3 82 D1 00 00 ; guard
; 8A DF 85 01 01 81 40 82 B5 82 E3 82 C2 82 B0 82 AB 00 00 ; depart
; 98 DF 85 01 01 81 40 8F E9 82 C9 82 E0 82 C7 82 E9 00 00 ; return
; 43 DE 85 01 01 81 40 82 BD 82 A2 82 AB 00 00 ; atmosphere?
; 04 E0 85 01 01 81 40 8F E9 82 C9 82 E0 82 C7 82 E9 00 00 ; return2
; B4 DF 85 01 01 81 40 82 CC 82 E9 00 00 ; mount
; A6 DF 85 01 01 81 40 82 A8 82 E8 82 E9 00 00 ; dismount
; DE DF 85 01 01 81 40 82 BB 82 A4 82 D1 00 00 ; equipment
; FD DF 85 01 01 81 40 83 41 83 6A 83 81 00 00 ; anime


; 00 00 18 00 50 57 DB E1 ED E1 AA 84 A3 83 85 01 C8 E1 85 22 C2 83 85 A9 00 00 85 89 85 87 AD CF 0E 9D B7 10 6B A9 09 00 22 AD 8F 80 BD D7 0E A8 22 80 82 85 22 AC 84 85 A9 00 00 8D 00 01 A9 00 20 8D 3A 05 A9 FF 20 8D 3C 05 BD B7 10 8D CF 0E A9 01 00 8D 43 05 8D 45 05 DA AE 72 07 BF EB 46 7E 8D 6F 05 20 4E E4 20 68 E4 A2 2E 00 DA FC 7F E2 FA 90 0F A9 E2 85 8D 41 05 BD AF E2 8D 40 05 20 32 E3 CA CA 10 E6 FA 22 BE F3 82 1A 0A EB 09 09 00 22 97 87 87 22 6E 85 85 22 DC 84 85 BD B7 10 C9 02 00 F0 0A C9 01 00 D0 05 20 DF E2 80 00 A9 3D E3 9D 57 0F 6B B6 E5 E8 E6 45 E5 39 E5 A5 E6 D7 E6 F6 E7 B3 E7 24

    .endsection Unsorted85DF3FSection


    .section Unsorted85DF6FSection

      .al
      .xl

      rlUnknown85DF6F ; 85/DF6F

        .al
        .autsiz
        .databank ?

        phx
        jsl rlUnknown88AF7B
        ldx $0772,b
        jsl rlUnknown84CE21
        plx
        rtl

        .databank 0

        ; 85/DF7D

    .endsection Unsorted85DF6FSection


    .section Unsorted85E33DSection

      .al
      .xl

      rlUnknown85E33D ; 85/E33D

        .al
        .autsiz
        .databank ?

        jsl rlUnknown858516
        bne _End

          lda wJoy1New
          bit #JOY_A
          beq +
          bra _End

          +
          lda wJoy1New
          bit #JOY_B
          beq _End

            lda $10B7,b,x
            cmp #1
            beq _E37D

            cmp #2
            bne +

              lda $0D87,b
              and #$FFEF
              sta $0D87,b
              bit #$0008
              beq +

                jsl rlUnknown85C0CE

            +
            phx
            jsl rlUnknown88ADE9
            plx

        _End
        jsl rlUnknown8583F8
        
        -
        rtl

        _E37D
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda #1
        sta aProcSystem.aBody6,b,x
        jsr rlUnknown858542
        bra -

        .databank 0

        ; 85/E38C

    .endsection Unsorted85E33DSection


    .section Unsorted85E85DSection

      .al
      .xl

      rlUnknown85E85D ; 85/E85D

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        lda wUnknown000D79,b
        bit #$0020
        bne _E894
        lda $0D87,b
        bit #$0010
        bne _E87B
        bit #$0008
        bne _E880
        lda #$0000
        bra _E883


        _E87B
        lda #$0002
        bra _E883


        _E880
        lda #$0001

        _E883
        sta $0ECF,b
        lda #$8500
        sta lR44+1
        lda #$E1CC
        sta lR44
        jsl rlProcEngineCreateProc

        _E894
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/E897

    .endsection Unsorted85E85DSection


    .section Unsorted85E897Section

      .al
      .xl

      rlUnknown85E897 ; 85/E897

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda #$0018
        trb $0D87,b
        jsl rlUnknown85C0D5
        plp
        plb
        rtl

        .databank 0

        ; 85/E8A8

    .endsection Unsorted85E897Section


    .section Unsorted85EA64Section

      .al
      .xl

      rlUnknown85EA64 ; 85/EA64

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/EA65

    .endsection Unsorted85EA64Section
