; Code from bank $85 not yet assigned to a game system.


    .section Unsorted8582D4Section

      .al
      .xl

      rlUnknown8582D4 ; 85/82D4

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda lR18
        pha
        lda lR18+1
        pha
        lda wR40
        pha
        lda wR41
        pha
        lda wR42
        pha
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlGetMapMenuTilemapArea
        sta wR42
        sep #$20
        lda #$1E
        sec
        sbc wR42
        sta wR40
        lda #$1C
        sec
        sbc wR42+1
        sta wR41
        lda @l wCursorXOffset
        lsr a
        lsr a
        lsr a
        cmp wR40
        bcc _830A
        lda wR40

        _830A
        sta @l $000534
        lda @l wCursorYOffset
        lsr a
        lsr a
        lsr a
        cmp wR41
        bcc _831B
        lda wR41

        _831B
        sta @l $000535
        rep #$20
        jsl rlUnknown878472
        pla
        sta wR42
        pla
        sta wR41
        pla
        sta wR40
        pla
        sta lR18+1
        pla
        sta lR18
        rtl

        .databank 0

        ; 85/8335

    .endsection Unsorted8582D4Section


    .section Unsorted8583C2Section

      .al
      .xl

      rlUnknown8583C2 ; 85/83C2

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlMapMenuSaveMapState
        lda aProcSystem.aHeaderOnCycle,b,x
        sta aProcSystem.aBody2,b,x
        lda #<>rlUnknown8583D3
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/83D3

    .endsection Unsorted8583C2Section


    .section Unsorted8583D3Section

      .al
      .xl

      rlUnknown8583D3 ; 85/83D3

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody2,b,x
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/83DA

    .endsection Unsorted8583D3Section


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
          jsr rsUnknown8584A1
          bra _End

        +
        lda wJoy1New
        bit #JOY_B
        beq +

          lda #$0021
          jsl rlUnknown808FAD

          jsl rlUnknown8582BA
          jsr rsUnknown8584A1
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
        jsr rsUnknown858542
        
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

      rsUnknown8584A1 ; 85/84A1

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


    .section ProcScript8584AASection

      .al
      .xl

      aProcUnknown85DDDBCode ; 85/84AA

        PROC_HALT


        ; 85/84AC

    .endsection ProcScript8584AASection


    .section Unsorted8584ACSection

      .al
      .xl

      rlUnknown8584AC ; 85/84AC

        .al
        .xl
        .autsiz
        .databank ?

        lda $000C,b,y
        sta lUnknown0540,b
        lda $000D,b,y
        sta lUnknown0540+1,b
        jsl rlUnknown82F227
        lda $0547,b
        sta aProcSystem.aBody4,b,x
        lda $0548,b
        sta aProcSystem.aBody5,b,x
        lda #$0001
        sta aProcSystem.aBody6,b,x
        rtl

        .databank 0

        ; 85/84CF

    .endsection Unsorted8584ACSection


    .section Unsorted8584DCSection

      .al
      .xl

      rlUnknown8584DC ; 85/84DC

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        cmp #$0070
        bcc _84F1
        cmp #$0090
        bcs _8503
        lda $0D87,b
        bit #$0004
        beq _8503

        _84F1
        lda #$0004
        tsb $0D87,b
        jsl rlGetMapMenuPosition
        and #$FF00
        ora #$0013
        bra _850B


        _8503
        lda #$0004
        trb $0D87,b
        bra _8515


        _850B
        sta $0534,b
        jsl rlUnknown858751
        jsr rsUnknown858542

        _8515
        rtl

        .databank 0

        ; 85/8516

    .endsection Unsorted8584DCSection


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
        lda aProcSystem.aBody5,b,x
        cmp $0548,b
        bne _8539
        lda aProcSystem.aBody4,b,x
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

      rsUnknown858542 ; 85/8542

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
        adc aProcSystem.aBody6,b,x
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


    .section Unsorted85856ESection

      .al
      .xl

      rlUnknown85856E ; 85/856E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        jsl rlUnknown8788E5
        jsl rlUnknown82F3BE
        ora #$0000
        beq _859B
        tay

        _857E
        tya
        jsl rlUnknown82F3C7
        jsl rlUnknown82F488
        lda lR18
        clc
        adc #$0005
        sta lR18
        jsl rlUnknown82F4A7
        tax
        jsl rlUnknown878921
        dec y
        bne _857E

        _859B
        ply
        plx
        jsl rlUnknown8587E1
        lda wUnknown000D79,b
        bit #$0020
        bne _85AD
        jsl rlFreeHDMAEntry0

        _85AD
        lda #$0006
        tsb bBufferTM
        rtl

        .databank 0

        ; 85/85B3

    .endsection Unsorted85856ESection


    .section Unsorted85860ESection

      .al
      .xl

      rsUnknown85860E ; 85/860E

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


    .section Unsorted858671Section

      .al
      .xl

      rlUnknown858671 ; 85/8671

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitFactionNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        jsl rlUnknown878921
        rtl

        .databank 0

        ; 85/8684

    .endsection Unsorted858671Section


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


    .section Unsorted858697Section

      .al
      .xl

      rlUnknown858697 ; 85/8697

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetEventLocationEntryCastleName
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        jsl rlUnknown878921
        rtl

        .databank 0

        ; 85/86AA

    .endsection Unsorted858697Section


    .section Unsorted8586AASection

      .al
      .xl

      rlUnknown8586AA ; 85/86AA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR13
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda wR1
        sta wR14
        jsl rlUnsignedDivide16By8
        lda wR10
        bne _86BF
        lda wR1

        _86BF
        dec a
        asl a
        xba
        clc
        adc wR0
        sta wR0
        jsl rlGetMapMenuPosition
        clc
        adc wR0
        sep #$20
        asl a
        asl a
        asl a
        sta wR0
        xba
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
        lda #$0027
        jsl rlUnknown87819A
        lda lR19
        sec
        sbc lMapMenuRAMEntryPointer,b
        jsl rlUnknown88A704
        plx
        rtl

        .databank 0

        ; 85/86FA

    .endsection Unsorted8586AASection


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


    .section Unsorted8586FFSection

      .al
      .xl

      rlUnknown8586FF ; 85/86FF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlStallProcUntilMapMenuDataLoaded
        lda #$20F0
        sta aCurrentTilemapInfo,b
        lda #$20FF
        sta wUnknown053C,b
        jsl rlUnknown8788E5
        lda #$0000
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        rtl

        .databank 0

        ; 85/871B

    .endsection Unsorted8586FFSection


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


    .section Unsorted858793Section

      .al
      .xl

      rlUnknown858793 ; 85/8793

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
        and #$7FFF
        sta $0534,b
        jsl rlUnknown858751
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/87A8

    .endsection Unsorted858793Section


    .section Unsorted8587A8Section

      .al
      .xl

      rlUnknown8587A8 ; 85/87A8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        sta $0534,b
        jsl rlUnknown87829A
        lda wR12
        pha
        lda wR13
        pha
        lda $0534,b
        jsl rlUnknown8784E1
        pla
        sta wR13
        pla
        sta wR12
        jsl rlUnknown8588F3
        lda wR10
        cmp @l wR12
        bcc _87DA
        lda @l wR13
        cmp wR11
        bcs _87DE

        _87DA
        jsl rlUnknown8587E1

        _87DE
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/87E1

    .endsection Unsorted8587A8Section


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


    .section Unsorted8587F2Section

      .al
      .xl

      rlUnknown8587F2 ; 85/87F2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        jsl rlUnknown87829A
        lda $0534,b
        jsl rlSetMapMenuPosition
        jsl rlUnknown8588F3
        jsl rlGetMapMenuYPositions
        lda wR10
        cmp @l wR12
        bcc _8819
        lda @l wR13
        cmp wR11
        bcs _881D

        _8819
        jsl rlUnknown858879

        _881D
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/8820

    .endsection Unsorted8587F2Section


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


    .section Unsorted8589C5Section

      .al
      .xl

      rsUnknown8589C5 ; 85/89C5

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetMapMenuTilemapArea
        pha
        lda #$8500
        sta lR18+1
        lda #$89DE
        sta lR18
        jsl rlLoadMapMenuTilemapData
        pla
        jsl rlUnknown878B69
        rts

        .databank 0

        ; 85/89DE

    .endsection Unsorted8589C5Section


    .section Unsorted8589E7Section

      .al
      .xl

      rsUnknown8589E7 ; 85/89E7

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetMapMenuTileIndex
        tax
        jsl rlUnknown878AB5
        jsl rlRemoveMapMenuTilemapRAMEntry
        rts

        .databank 0

        ; 85/89F5

      rsUnknown8589F5 ; 85/89F5

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8589C5
        stz aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$8A1B
        sta lR18
        jsl rlUnknown878BF0
        lda #$8500
        sta lR18+1
        lda #$8A47
        sta lR18
        jsl rlUnknown878D61
        jsr rsUnknown8589E7
        rts

        .databank 0

        ; 85/8A1B

    .endsection Unsorted8589E7Section


    .section Unsorted858A6FSection

      .al
      .xl

      rsUnknown858A6F ; 85/8A6F

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8589C5
        stz aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$8A95
        sta lR18
        jsl rlUnknown878BF0
        lda #$8500
        sta lR18+1
        lda #$8AAF
        sta lR18
        jsl rlUnknown878D61
        jsr rsUnknown8589E7
        rts

        .databank 0

        ; 85/8A95

    .endsection Unsorted858A6FSection


    .section Unsorted858AD7Section

      .al
      .xl

      rsUnknown858AD7 ; 85/8AD7

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8589C5
        stz aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$8AFD
        sta lR18
        jsl rlUnknown878BF0
        lda #$8500
        sta lR18+1
        lda #$8B29
        sta lR18
        jsl rlUnknown878D61
        jsr rsUnknown8589E7
        rts

        .databank 0

        ; 85/8AFD

    .endsection Unsorted858AD7Section


    .section Unsorted858B51Section

      .al
      .xl

      rsUnknown858B51 ; 85/8B51

        .al
        .xl
        .autsiz
        .databank ?

        lda #$1800
        sta aCurrentTilemapInfo,b
        bra $858B5F

        .databank 0

        ; 85/8B59

      rsUnknown858B59 ; 85/8B59

        .al
        .xl
        .autsiz
        .databank ?

        lda #$1C00
        sta aCurrentTilemapInfo,b
        jsr rsUnknown8589C5
        lda #$8500
        sta lR18+1
        lda #$8BD3
        sta lR18
        jsl rlUnknown878BF0
        lda #$2340
        tsb aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$8C0D
        sta lR18
        ldx #$0101
        jsl rlUnknown878F6E
        lda #$23FF
        trb aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$8C26
        sta lR18
        jsl rlUnknown878D61
        jsl rlUnknown878B4E
        and #$00FF
        cmp #$000C
        bcc _8BCF
        lda #$2340
        tsb aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$8BF9
        sta lR18
        ldx #$0001
        jsl rlUnknown878F6E
        lda #$8500
        sta lR18+1
        lda #$8C03
        sta lR18
        ldx #$0101
        jsl rlUnknown878F6E

        _8BCF
        jsr rsUnknown8589E7
        rts

        .databank 0

        ; 85/8BD3

    .endsection Unsorted858B51Section


    .section Unsorted858C4ESection

      .al
      .xl

      rsUnknown858C4E ; 85/8C4E

        .al
        .xl
        .autsiz
        .databank ?

        lda #$1800
        sta aCurrentTilemapInfo,b
        bra _8C5C

        .byte $A9, $00, $1C, $8D, $3A, $05


        _8C5C
        jsr rsUnknown8589C5
        lda #$8500
        sta lR18+1
        lda #$8C85
        sta lR18
        jsl rlUnknown878BF0
        lda #$23FF
        trb aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$8CAB
        sta lR18
        jsl rlUnknown878D61
        jsr rsUnknown8589E7
        rts

        .databank 0

        ; 85/8C85

    .endsection Unsorted858C4ESection


    .section Unsorted858D83Section

      .al
      .xl

      rlUnknown858D83 ; 85/8D83

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85BC9E
        lda #$4F15
        sta aProcSystem.aBody4,b,x
        lda #$0000
        sta aProcSystem.aBody5,b,x
        lda $057C,b
        cmp #$0001
        bne _8DA2
        lda #$0D0A
        jsl rlSetMapMenuTilemapArea

        _8DA2
        jsl rlUnknown859B2A
        jsl rlUnknown85A227
        rtl

        .databank 0

        ; 85/8DAB

      rlUnknown858DAB ; 85/8DAB

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown858F10
        lda #<>rlUnknown858DB5
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/8DB5

      rlUnknown858DB5 ; 85/8DB5

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown0007D8,b
        cmp #$0006
        bne _8DC1
        jml _8EA0


        _8DC1
        jsr rsUnknown858F10
        bcc _8DCA
        jml _8EA0


        _8DCA
        jsl rlLoadMapMenuEntryPointerFromProcBody
        phx
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$8EA1
        sta lR18
        ldx #$0702
        jsl rlUnknown878921
        lda $057C,b
        cmp #$0001
        bne _8E01
        lda #$8500
        sta lR18+1
        lda #$8EA7
        sta lR18
        ldx #$0901
        jsl rlUnknown878921
        bra _8E7E


        _8E01
        lda #$8500
        sta lR18+1
        lda #$8EA7
        sta lR18
        ldx #$0902
        jsl rlUnknown878921
        lda #$2140
        sta aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$8EAD
        sta lR18
        ldx #$0B02
        jsl rlUnknown8788F7
        lda #$8500
        sta lR18+1
        lda #$8EB1
        sta lR18
        ldx #$0C02
        jsl rlUnknown8788F7
        lda #$8500
        sta lR18+1
        lda #$8EB5
        sta lR18
        ldx #$0D02
        jsl rlUnknown8788F7
        lda #$8500
        sta lR18+1
        lda #$8EB9
        sta lR18
        ldx #$0E02
        jsl rlUnknown8788F7
        lda #$8500
        sta lR18+1
        lda #$8EBD
        sta lR18
        ldx #$0F02
        jsl rlUnknown8788F7
        lda #$8500
        sta lR18+1
        lda #$8EC1
        sta lR18
        ldx #$1002
        jsl rlUnknown8788F7

        _8E7E
        plx
        jsl rlUnknown858F61
        jsl rlUnknown858F28
        bcc _8E92
        sta $0534,b
        jsl rlUnknown858751
        bra _8E96


        _8E92
        jsl rlUnknown8587E1

        _8E96
        jsl rlUnknown85A234
        lda #<>rlUnknown858EC5
        sta aProcSystem.aHeaderOnCycle,b,x

        _8EA0
        rtl

        .databank 0

        ; 85/8EA1

    .endsection Unsorted858D83Section


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
        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0002
        bne _8F03
        bit #$0001
        beq _8F0F
        and #$FFFE
        sta aProcSystem.aHeaderBitfield,b,x
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


    .section Unsorted858F10Section

      .al
      .xl

      rsUnknown858F10 ; 85/8F10

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0002
        beq _8F26
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        jsl rlUnknown859B48
        sec
        rts


        _8F26
        clc
        rts

        .databank 0

        ; 85/8F28

    .endsection Unsorted858F10Section


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
        lda aProcSystem.aBody5,b,x
        beq _8F5F
        lda #$0000
        sta aProcSystem.aBody5,b,x
        jsl rlGetMapMenuPosition
        and #$FF00
        ora #$0002
        bra _8F5C


        _8F47
        lda aProcSystem.aBody5,b,x
        bne _8F5F
        lda #$0001
        sta aProcSystem.aBody5,b,x
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
        ldy aProcSystem.aBody4,b,x
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
        jsr rsUnknown85860E

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


    .section Unsorted8590B9Section

      .al
      .xl

      rlUnknown8590B9 ; 85/90B9

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85BC9E
        lda #$0000
        sta aProcSystem.aBody5,b,x
        jsl rlUnknown85A227
        rtl

        .databank 0

        ; 85/90C8

      rlUnknown8590C8 ; 85/90C8

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown858F10
        lda #<>rlUnknown8590D2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/90D2

      rlUnknown8590D2 ; 85/90D2

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown0007D8,b
        cmp #$0006
        beq _9107
        jsr rsUnknown858F10
        bcs _9107
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsr rsUnknown85915A
        jsl rlUnknown858F28
        bcc _90F9
        clc
        adc #$0008
        sta $0534,b
        jsl rlUnknown858751
        bra _90FD


        _90F9
        jsl rlUnknown8587E1

        _90FD
        jsl rlUnknown85A234
        lda #<>rlUnknown859108
        sta aProcSystem.aHeaderOnCycle,b,x

        _9107
        rtl

        .databank 0

        ; 85/9108

    .endsection Unsorted8590B9Section


    .section Unsorted859108Section

      .al
      .xl

      rlUnknown859108 ; 85/9108

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0002
        bne _914F
        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0001
        bne _9121
        bit #$0008
        bne _9157

        _9121
        and #$FFFB
        ora #$0008
        sta aProcSystem.aHeaderBitfield,b,x
        jsr rsUnknown85915A
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFE
        sta aProcSystem.aHeaderBitfield,b,x
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

      rsUnknown85915A ; 85/915A

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
        jsr rsUnknown85860E

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
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

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
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

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
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlUnknown858EC5
        lda #$8500
        sta lR44+1
        lda #$90AD
        sta lR44
        jsl rlProcEngineFindProc
        bcc _9262
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x
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


    .section Unsorted85928DSection

      .al
      .xl

      rlUnknown85928D ; 85/928D

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8586FF
        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody4,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody5,b,x
        lda #$0001
        sta aProcSystem.aBody6,b,x
        lda #$0000
        sta $7E8BEE
        sta $7E8BEC
        jsl rlUnknown859B2A
        lda wUnknown000D79,b
        bit #$0020
        bne _92BC
        bra _92C3


        _92BC
        lda #$0102
        jsl rlSetMapMenuPosition

        _92C3
        rtl

        .databank 0

        ; 85/92C4

      rlUnknown8592C4 ; 85/92C4

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        phx
        lda aProcSystem.aBody5,b,x
        tax
        lda $7E0000,x
        and #$00FF
        sta wR0
        plx
        jsl rlGetMapMenuTilemapArea
        and #$00FF
        xba
        ora wR0
        sep #$20
        asl a
        rep #$20
        clc
        adc #$0002
        xba
        jsl rlSetMapMenuTilemapArea
        jsl rlUnknown85A227
        lda #<>rlUnknown8592FA
        sta aProcSystem.aHeaderOnCycle,b,x
        ply
        plx
        rtl

        .databank 0

        ; 85/92FA

    .endsection Unsorted85928DSection


    .section Unsorted8592FASection

      .al
      .xl

      rlUnknown8592FA ; 85/92FA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda aProcSystem.aBody5,b,x
        sta wR2
        tax
        lda $7E0000,x
        and #$00FF
        sta wR0
        ldy #$0000

        _9318
        lda #$20F0
        sta aCurrentTilemapInfo,b
        tya
        clc
        adc wR2
        tax
        lda $7E0001,x
        and #$00FF
        sta wR1
        tya
        asl a
        xba
        clc
        adc #$0104
        tax
        lda wR1
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        bne _9343
        jml _936C


        _9343
        lda aCurrentTilemapInfo,b
        and #$FC00
        sta aCurrentTilemapInfo,b
        jsl rlUnknown858684
        lda aCurrentTilemapInfo,b
        and #$FFC0
        ora #$24F0
        sta aCurrentTilemapInfo,b
        txa
        clc
        adc #$0008
        tax
        lda wR1
        jsl rlGetItemDurabilityOfInventorySlot
        jsl rlUnknown878916

        _936C
        inc y
        cpy wR0
        bcs _9375
        jml _9318


        _9375
        ply
        plx
        lda #<>rlUnknown859386
        sta aProcSystem.aHeaderOnCycle,b,x
        jsl rlUnknown8587E1
        jsl rlUnknown85A227
        rtl

        .databank 0

        ; 85/9386

    .endsection Unsorted8592FASection


    .section Unsorted859386Section

      .al
      .xl

      rlUnknown859386 ; 85/9386

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown85969E
        lda #<>rlUnknown859390
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/9390

    .endsection Unsorted859386Section


    .section Unsorted859390Section

      .al
      .xl

      rlUnknown859390 ; 85/9390

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody5,b,x
        sta wR2
        lda aProcSystem.aBody6,b,x
        phx
        dec a
        clc
        adc wR2
        tax
        lda $7E0001,x
        and #$00FF
        sta aProcSystem.wInput1,b
        plx
        lda wR2
        cmp #$2000
        beq _93F7
        cmp #$2010
        beq _93F7
        cmp #$2020
        beq _93F7
        lda wR1
        pha
        lda wR2
        pha
        lda aProcSystem.wInput1,b
        phx
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        lda wUnknown000D79,b
        bit #$0020
        bne _93E7
        lda #$0213
        bra _93EA


        _93E7
        lda #$0113

        _93EA
        jsl rlUnknown85A394
        plx
        pla
        sta wR2
        pla
        sta wR1
        bra _9414


        _93F7
        lda aProcSystem.aBody4,b,x
        sta aProcSystem.wInput0,b
        phx
        lda #$8500
        sta lR44+1
        lda #$988E
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        lda #$0000
        sta $7E8BEE

        _9414
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown878531
        jsl rlUnknown85A227
        lda #<>rlUnknown859427
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/9427

    .endsection Unsorted859390Section


    .section Unsorted859427Section

      .al
      .xl

      rlUnknown859427 ; 85/9427

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown859766
        lda #<>rlUnknown859431
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/9431

    .endsection Unsorted859427Section


    .section Unsorted859431Section

      .al
      .xl

      rlUnknown859431 ; 85/9431

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85A234
        lda #$943B
        sta aProcSystem.aHeaderOnCycle,b,x
        phx
        lda aProcSystem.aBody5,b,x
        tax
        lda $7E0000,x
        and #$00FF
        sta wR1
        plx
        lda aProcSystem.aBody5,b,x
        sta wR2
        lda wJoy1Repeated
        bit #$0800
        beq _9473
        lda aProcSystem.aBody6,b,x
        dec a
        bne _9465
        lda wJoy1New
        bit #$0800
        beq _9473
        lda wR1

        _9465
        sta aProcSystem.aBody6,b,x
        lda #$0006
        jsl rlUnknown808FAD
        jml _94EC


        _9473
        bit #$0400
        beq _949A
        lda aProcSystem.aBody6,b,x
        inc a
        cmp wR1
        beq _948C
        bcc _948C
        lda wJoy1New
        bit #$0400
        beq _949A
        lda #$0001

        _948C
        sta aProcSystem.aBody6,b,x
        lda #$0006
        jsl rlUnknown808FAD
        jml _94EC


        _949A
        lda wJoy1New
        bit #$0080
        beq _94AF
        lda #$000A
        jsl rlUnknown808FAD
        jsr rsUnknown8595C0
        jml _957A


        _94AF
        lda wJoy1New
        bit #$8000
        beq _94E8
        lda #$0021
        jsl rlUnknown808FAD
        jsr rsUnknown8596FA
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        jsl rlUnknown859B48
        jsl rlUnknown85A3A6
        lda #$8000
        sta $7E8BEE
        jsr rsUnknown859737
        phx
        jsl rlUnknown88ADA2
        jsl rlUnknown85E85D
        plx
        jml _957A


        _94E8
        jml _9551


        _94EC
        phx
        lda aProcSystem.aBody6,b,x
        dec a
        clc
        adc wR2
        tax
        lda $7E0001,x
        and #$00FF
        sta $7E8BEC
        plx
        lda wR2
        cmp #$2000
        beq _9542
        cmp #$2010
        beq _9542
        cmp #$2020
        beq _9542
        lda wR1
        pha
        lda wR2
        pha
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda $7E8BEC
        phx
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlUnknown85A3D5
        plx
        pla
        sta wR2
        pla
        sta wR1
        bra _9551


        _9542
        lda #$4000
        sta $7E8BEE
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown878531

        _9551
        lda #$0100
        sta wR0
        lda wR1
        inc a
        sta wR1
        lda aProcSystem.aBody6,b,x
        jsl rlUnknown8586AA
        jsr rsUnknown8597CD
        lda aProcSystem.aBody5,b,x
        cmp #$2008
        beq _957A
        cmp #$2018
        beq _957A
        cmp #$2028
        beq _957A
        jsr rsUnknown859AFD

        _957A
        rtl

        .databank 0

        ; 85/957B

      rlUnknown85957B ; 85/957B

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8597CD
        lda wJoy1New
        bit #$0080
        beq _959A
        lda #$000A
        jsl rlUnknown808FAD
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        jsl rlUnknown859B48
        bra _95AE


        _959A
        lda wJoy1New
        bit #$8000
        beq _95AE
        lda #$0021
        jsl rlUnknown808FAD
        lda #$943B
        sta aProcSystem.aHeaderOnCycle,b,x

        _95AE
        lda #$0100
        sta wR0
        lda wR1
        inc a
        sta wR1
        lda aProcSystem.aBody6,b,x
        jsl rlUnknown8586AA
        rtl

        .databank 0

        ; 85/95C0

      rsUnknown8595C0 ; 85/95C0

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsr rsUnknown8596FA
        phx
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda aProcSystem.aBody6,b,x
        dec a
        clc
        adc wR2
        tax
        lda wR2
        cmp #$2000
        beq _95F2
        cmp #$2008
        beq _9642
        cmp #$2010
        beq _95F2
        cmp #$2018
        beq _960F
        cmp #$2028
        beq _9636
        jml _9668


        _95F2
        lda $7E0001,x
        and #$00FF
        sta wSelectedInventorySlot,b
        jsr _9682
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown87B512
        jsl rlUnknown88AD46
        plx
        jml _969C


        _960F
        lda $7E0001,x
        and #$00FF
        sta wSelectedInventorySlot,b
        lda #$8500
        sta lR44+1
        lda #$E951
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        lda #$957B
        sta aProcSystem.aHeaderOnCycle,b,x
        jsl rlUnknown85A3A6
        jml _969C


        _9636
        lda $7E0001,x
        and #$00FF
        ora #$8000
        bra _9649


        _9642
        lda $7E0001,x
        and #$00FF

        _9649
        sta wSelectedInventorySlot,b
        ldx aProcSystem.wOffset,b
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        jsl rlUnknown859B48
        jsl rlUnknown85A3A6
        jsl rlUnknown85E8EA
        plx
        jml _969C


        _9668
        lda $7E0001,x
        and #$00FF
        sta wSelectedInventorySlot,b
        jsl rlFlagEquippedInventorySlotAndGetStatBonus
        jsr _9682
        jsl rlUnknown85E85D
        plx
        jml _969C


        _9682
        ldx aProcSystem.wOffset,b
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        jsl rlUnknown859B48
        lda #$8000
        sta $7E8BEE
        jsr rsUnknown859737
        rts


        _969C
        plx
        rts

        .databank 0

        ; 85/969E

      rsUnknown85969E ; 85/969E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown000D79,b
        bit #$0020
        bne _96F9
        phx
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        ldx #$0000
        jsl rlUnknown9196EE
        plx
        phx
        ldx #$005E
        lda #$0000

        _96C0
        sta $7FC5B2,x
        dec x
        dec x
        bpl _96C0
        plx
        lda #$0005
        sta aEpilogueUnitStates
        lda #$0001
        sta $7FC54C
        lda #$000B
        sta $7FC5AE
        lda #$0001
        sta $7FC5B0
        lda wUnknown00052C,b
        cmp #$0009
        bpl _96F3
        lda #$0009
        sta wUnknown00052C,b

        _96F3
        lda #$0001
        sta wUnknown00052A,b

        _96F9
        rts

        .databank 0

        ; 85/96FA

      rsUnknown8596FA ; 85/96FA

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown000D79,b
        bit #$0020
        bne _9736
        phy
        phx
        phx
        ldx #$000C
        lda #$0000

        _970B
        sta $7E7BD2,x
        sta $7E7C12,x
        sta $7E7C52,x
        dec x
        dec x
        bpl _970B
        plx
        lda wUnknown00052C,b
        cmp #$0009
        bpl _972A
        lda #$0009
        sta wUnknown00052C,b

        _972A
        lda #$0001
        sta wUnknown00052A,b
        jsl rlUnknown87829A
        plx
        ply

        _9736
        rts

        .databank 0

        ; 85/9737

      rsUnknown859737 ; 85/9737

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda lMapMenuRAMEntryPointer,b
        pha
        lda lMapMenuRAMEntryPointer+1,b
        pha
        lda #$8500
        sta lR44+1
        lda #$988E
        sta lR44
        jsl rlProcEngineFindProc
        bcc _975C
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc

        _975C
        pla
        sta lMapMenuRAMEntryPointer+1,b
        pla
        sta lMapMenuRAMEntryPointer,b
        plx
        rts

        .databank 0

        ; 85/9766

      rsUnknown859766 ; 85/9766

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda aProcSystem.aBody5,b,x
        sta wR2
        tax
        lda $7E0000,x
        and #$00FF
        sta wR0
        ldy #$0000

        _9780
        tya
        clc
        adc wR2
        tax
        lda $7E0001,x
        and #$00FF
        sta wR1
        lda wR1
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        bne _979D
        jml _97C1


        _979D
        phx
        phy
        lda wR0
        pha
        tya
        asl a
        and #$000F
        ora #$0040
        tax
        lda wR1
        jsl rlGetItemIDByInventorySlot
        jsl rlCopyItemIcon
        lda #$0006
        jsl rlUnitWindowCopySpritePalette1
        pla
        sta wR0
        ply
        plx

        _97C1
        inc y
        cpy wR0
        bcs _97CA
        jml _9780


        _97CA
        ply
        plx
        rts

        .databank 0

        ; 85/97CD

      rsUnknown8597CD ; 85/97CD

        ; Found by tools/sweep.py: nothing in the build reaches this.
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
        lda aProcSystem.aBody5,b,x
        sta wR2
        tax
        lda $7E0000,x
        and #$00FF
        asl a
        sta wR7
        ldx #$0000
        stz wR4
        stz wR5

        _9812
        phx
        ldy $9831,b,x
        jsl rlPushToOAMBuffer
        plx
        inc x
        inc x
        cpx wR7
        bcs _9825
        jml _9812


        _9825
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

        ; 85/9831

    .endsection Unsorted859431Section


    .section Unsorted85989ASection

      .al
      .xl

      rlUnknown85989A ; 85/989A

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8586FF
        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda aProcSystem.wInput1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        sta aProcSystem.aBody5,b,x
        jsl rlUnknown8587E1
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown85A227
        phx
        lda #$2140
        sta aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$996B
        sta lR18
        ldx #$0102
        jsl rlUnknown8788F7
        lda #$8500
        sta lR18+1
        lda #$996F
        sta lR18
        ldx #$0202
        jsl rlUnknown8788F7
        lda #$8500
        sta lR18+1
        lda #$9953
        sta lR18
        ldx #$0302
        jsl rlUnknown8788F7
        lda #$8500
        sta lR18+1
        lda #$9957
        sta lR18
        ldx #$0402
        jsl rlUnknown8788F7
        lda #$8500
        sta lR18+1
        lda #$995B
        sta lR18
        ldx #$0502
        jsl rlUnknown8788F7
        lda #$8500
        sta lR18+1
        lda #$995F
        sta lR18
        ldx #$0602
        jsl rlUnknown8788F7
        lda #$8500
        sta lR18+1
        lda #$9963
        sta lR18
        ldx #$0702
        jsl rlUnknown8788F7
        lda #$8500
        sta lR18+1
        lda #$9967
        sta lR18
        ldx #$0802
        jsl rlUnknown8788F7
        plx
        rtl

        .databank 0

        ; 85/9953

    .endsection Unsorted85989ASection


    .section Unsorted859973Section

      .al
      .xl

      rlUnknown859973 ; 85/9973

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda #$0000
        sta wRoutineVariable1,b
        plx
        phx
        lda aProcSystem.aBody5,b,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetItemWeaponType
        ldx #$004E
        jsl rlUnitWindowCopyWeaponRankIcon
        lda #$0005
        jsl rlUnitWindowCopySpritePalette2
        plx
        phx
        lda aProcSystem.aBody5,b,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetSelectedUnitBattleMight
        sta wR0
        jsl rlGetFirstWeaponBattleMight
        sec
        sbc wR0
        phx
        pha
        lda #$0003
        and #$00FF
        xba
        ora #$0008
        tax
        pla
        jsr rsUnknown859A66
        plx
        lda wR0
        ldx #$24F0
        stx aCurrentTilemapInfo,b
        ldx #$0306
        jsl rlUnknown878916
        plx
        phx
        lda aProcSystem.aBody5,b,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetSelectedUnitBattleHit
        sta wR0
        jsl rlUnknown84FE98
        sec
        sbc wR0
        phx
        pha
        lda #$0005
        and #$00FF
        xba
        ora #$0008
        tax
        pla
        jsr rsUnknown859A66
        plx
        lda wR0
        ldx #$24F0
        stx aCurrentTilemapInfo,b
        ldx #$0506
        jsl rlUnknown878916
        plx
        phx
        lda aProcSystem.aBody5,b,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetSelectedUnitDeploymentOffset
        jsl rlGetTerrainTypeByDeploymentOffset
        jsl rlGetSelectedUnitBattleAvoid
        sta wR0
        jsl rlGetSelectedUnitDeploymentOffset
        jsl rlGetTerrainTypeByDeploymentOffset
        jsl rlUnknown84FEA1
        sec
        sbc wR0
        phx
        pha
        lda #$0007
        and #$00FF
        xba
        ora #$0008
        tax
        pla
        jsr rsUnknown859A66
        plx
        lda wR0
        ldx #$24F0
        stx aCurrentTilemapInfo,b
        ldx #$0706
        jsl rlUnknown878916
        plx
        lda bBufferTM
        bit #$0002
        beq _9A5B
        jsr rsUnknown859AFD

        _9A5B
        jsl rlUnknown8785E3
        lda #<>rlUnknown859AB4
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/9A66

      rsUnknown859A66 ; 85/9A66

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #$2400
        sta aCurrentTilemapInfo,b
        pla
        ora #$0000
        beq _9A97
        bpl _9A77
        bmi _9A87

        _9A77
        lda #$8500
        sta lR18+1
        lda #$9AAC
        sta lR18
        jsl rlUnknown878921
        bra _9AA5


        _9A87
        lda #$8500
        sta lR18+1
        lda #$9AA8
        sta lR18
        jsl rlUnknown878921
        bra _9AA5


        _9A97
        lda #$8500
        sta lR18+1
        lda #$9AB0
        sta lR18
        jsl rlUnknown878921

        _9AA5
        lda wR0
        rts

        .databank 0

        ; 85/9AA8

    .endsection Unsorted859973Section


    .section Unsorted859AB4Section

      .al
      .xl

      rlUnknown859AB4 ; 85/9AB4

        .al
        .xl
        .autsiz
        .databank ?

        lda $7E8BEE
        bit #$8000
        bne _9AC7
        lda $7E8BEE
        bit #$4000
        bne _9ADB
        rtl


        _9AC7
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        lda #$0000
        sta $7E8BEE
        sta $7E8BEC
        rtl


        _9ADB
        phx
        lda $7E8BEC
        jsl rlGetItemROMDataByInventorySlot
        plx
        lda wCurrentItemDataROMPointer,b
        sta aProcSystem.aBody5,b,x
        lda #$0000
        sta $7E8BEE
        sta $7E8BEC
        lda #<>rlUnknown859973
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/9AFD

    .endsection Unsorted859AB4Section


    .section Unsorted859AFDSection

      .al
      .xl

      rsUnknown859AFD ; 85/9AFD

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wR0
        pha
        lda wR1
        pha
        ldy #$9B21
        lda #$00C8
        sta wR0
        lda #$0028
        sta wR1
        stz wR4
        stz wR5
        jsl rlPushToOAMBuffer
        pla
        sta wR1
        pla
        sta wR0
        plx
        rts

        .databank 0

        ; 85/9B21

    .endsection Unsorted859AFDSection


    .section Unsorted859B2ASection

      .al
      .xl

      rlUnknown859B2A ; 85/9B2A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0004

        _9B2E
        lda $010A,b,x
        sta $7FEB0A,x
        lda aUnknown859B42,x
        sta $010A,b,x
        dec x
        dec x
        bpl _9B2E
        plx
        rtl

        .databank 0

        ; 85/9B42

    .endsection Unsorted859B2ASection


    .section Table859B42Section

      .al
      .xl

      aUnknown859B42 ; 85/9B42

        ; Read by rlUnknown859B2A.

        .word $39AA, $7BDA, $0C21

        ; 85/9B48

    .endsection Table859B42Section


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
        lda aUnknownDE0000,x
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
        lda aProcSystem.aHeaderTypeOffset,b,x
        cmp #$9BE6
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


    .section Unsorted859D94Section

      .al
      .xl

      rlUnknown859D94 ; 85/9D94

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$00
        sta bBufferCGWSEL
        lda #$82
        sta bBufferCGADSUB
        rep #$20
        lda wR43
        xba
        and #$00FF
        sta wR7
        lda wR43
        and #$00FF
        sta wR5
        lda wR42
        xba
        and #$00FF
        sta wR6
        lda wR42
        and #$00FF
        sta wR4
        phx
        ldx #$0000
        jsr rsUnknown859DCD
        jsr rsUnknown859E08
        plx
        rtl

        .databank 0

        ; 85/9DCA

      rlUnknown859DCA ; 85/9DCA

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/9DCB

    .endsection Unsorted859D94Section


    .section Unsorted859DCDSection

      .al
      .xl

      rsUnknown859DCD ; 85/9DCD

        .al
        .xl
        .autsiz
        .databank ?

        lda wR7
        beq _9E06
        cmp #$0080
        bmi _9DF2
        lda wR7
        sec
        sbc #$007F
        sta wR7
        sep #$20
        lda #$7F
        sta wDialogueBoxHDMAYPixelPosition,x
        rep #$20
        inc x
        lda #$9E07
        sta wDialogueBoxHDMAYPixelPosition,x
        inc x
        inc x

        _9DF2
        sep #$20
        lda wR7
        sta wDialogueBoxHDMAYPixelPosition,x
        rep #$20
        inc x
        lda #$9E07
        sta wDialogueBoxHDMAYPixelPosition,x
        inc x
        inc x

        _9E06
        rts

        .databank 0

        ; 85/9E07

    .endsection Unsorted859DCDSection


    .section Unsorted859E08Section

      .al
      .xl

      rsUnknown859E08 ; 85/9E08

        .al
        .xl
        .autsiz
        .databank ?

        lda wR5
        sta wR13
        lda wR4
        and #$00FF
        sta wR14
        jsl rlUnsignedDivide16By8
        lda wR13
        sta wR3
        jsr rsUnknown859E1F
        rts

        .databank 0

        ; 85/9E1F

      rsUnknown859E1F ; 85/9E1F

        .al
        .xl
        .autsiz
        .databank ?

        ldy #$0000
        lda wR6
        cmp #$0003
        beq _9E58
        cmp #$0002
        beq _9E41
        cmp #$0001
        beq _9E3A
        jsr rsUnknown859E5F
        jsr rsUnknown859ECB
        rts


        _9E3A
        jsr rsUnknown859E7E
        jsr rsUnknown859ECB
        rts


        _9E41
        lda wR3
        lsr a
        sta wR3
        lda wR4
        sta wR0
        jsr rsUnknown859E7E
        lda wR0
        sta wR4
        jsr rsUnknown859E5F
        jsr rsUnknown859ECB
        rts


        _9E58
        jsr rsUnknown859EA2
        jsr rsUnknown859ECB
        rts

        .databank 0

        ; 85/9E5F

      rsUnknown859E5F ; 85/9E5F

        .al
        .xl
        .autsiz
        .databank ?

        ldy #$0000
        stz wR2
        stz wR1

        _9E66
        jsr rsUnknown859FA3
        jsr rsUnknown859F97
        lda $9EE7,b,y
        sta wDialogueBoxHDMAYPixelPosition,x
        inc x
        inc x
        dec wR4
        beq _9E7D
        inc y
        inc y
        bra _9E66


        _9E7D
        rts

        .databank 0

        ; 85/9E7E

      rsUnknown859E7E ; 85/9E7E

        .al
        .xl
        .autsiz
        .databank ?

        stz wR2
        stz wR1
        lda #$0014
        sec
        sbc wR4
        asl a
        tay

        _9E8A
        jsr rsUnknown859FA3
        jsr rsUnknown859F97
        lda $9F27,b,y
        sta wDialogueBoxHDMAYPixelPosition,x
        inc x
        inc x
        dec wR4
        beq _9EA1
        inc y
        inc y
        bra _9E8A


        _9EA1
        rts

        .databank 0

        ; 85/9EA2

      rsUnknown859EA2 ; 85/9EA2

        .al
        .xl
        .autsiz
        .databank ?

        stz wR2
        stz wR1
        lda wR4
        lsr a
        sta wR0
        lda #$000A
        sec
        sbc wR0
        asl a
        tay

        _9EB3
        jsr rsUnknown859FA3
        jsr rsUnknown859F97
        lda $9F4F,b,y
        sta wDialogueBoxHDMAYPixelPosition,x
        inc x
        inc x
        dec wR4
        beq _9ECA
        inc y
        inc y
        bra _9EB3


        _9ECA
        rts

        .databank 0

        ; 85/9ECB

      rsUnknown859ECB ; 85/9ECB

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$01
        sta wDialogueBoxHDMAYPixelPosition,x
        rep #$20
        inc x
        lda #$9F77
        sta wDialogueBoxHDMAYPixelPosition,x
        inc x
        inc x
        lda #$0000
        sta wDialogueBoxHDMAYPixelPosition,x
        rts

        .databank 0

        ; 85/9EE7

    .endsection Unsorted859E08Section


    .section Unsorted859F97Section

      .al
      .xl

      rsUnknown859F97 ; 85/9F97

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda wR3
        sta wDialogueBoxHDMAYPixelPosition,x
        rep #$20
        inc x
        rts

        .databank 0

        ; 85/9FA3

      rsUnknown859FA3 ; 85/9FA3

        .al
        .xl
        .autsiz
        .databank ?

        lda wR1
        beq _9FAB
        dec wR3
        stz wR1

        _9FAB
        lda wR2
        clc
        adc wR10
        sta wR2
        cmp #$000A
        bmi _9FC4
        sec
        sbc #$000A
        sta wR2
        inc wR3
        lda #$FFFF
        sta wR1

        _9FC4
        rts

        .databank 0

        ; 85/9FC5

    .endsection Unsorted859F97Section


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


    .section Unsorted859FEASection

      .al
      .xl

      rlUnknown859FEA ; 85/9FEA

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #$0000
        sta @l $001057,x
        pla
        asl a
        phx
        tax
        jsr ($859FFB,x)
        plx
        rtl

        .databank 0

        ; 85/9FFB

    .endsection Unsorted859FEASection


    .section Unsorted85A004Section

      .al
      .xl

      rsUnknown85A004 ; 85/A004

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldy #$A040
        jsl rlGetMapMenuTilemapArea
        sta wR0
        and #$FF00
        ora #$0004
        jsl rlSetMapMenuTilemapArea
        lda wR0
        and #$00FF
        sec
        sbc #$0004
        sta wR0
        jsl rlGetMapMenuPosition
        clc
        adc wR0
        jsl rlSetMapMenuPosition
        rts

        .databank 0

        ; 85/A02E

    .endsection Unsorted85A004Section


    .section Unsorted85A02ESection

      .al
      .xl

      rsUnknown85A02E ; 85/A02E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetMapMenuTilemapArea
        and #$FF00
        ora #$0004
        jsl rlSetMapMenuTilemapArea
        rts

        .databank 0

        ; 85/A03D

    .endsection Unsorted85A02ESection


    .section Unsorted85A040Section

      .al
      .xl

      rsUnknown85A040 ; 85/A040

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 85/A041

    .endsection Unsorted85A040Section


    .section Unsorted85A041Section

      .al
      .xl

      rlUnknown85A041 ; 85/A041

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR7
        tya
        and #$00FF
        sta wR5
        tya
        xba
        and #$00FF
        sta wR6
        lda wR5
        cmp aProcSystem.aBody4,b,x
        bmi _A074
        lda aProcSystem.aBody4,b,x
        sta wR3
        lda wR6
        asl a
        phx
        tax
        jsr ($85A079,x)
        plx
        inc aProcSystem.aBody4,b,x
        lda wR4
        pha
        jsl rlSetMapMenuTilemapArea
        pla
        plx
        clc
        rtl


        _A074
        plx
        lda wR7
        sec
        rtl

        .databank 0

        ; 85/A079

    .endsection Unsorted85A041Section


    .section Unsorted85A079Section

      .al
      .xl

      aUnknown85A079 ; 85/A079

        .word <>rsUnknown85A085, <>rsUnknown85A0A1, <>$85A0CE
        .word <>$85A0D0, <>$85A0D9, <>$85A0F5

      rsUnknown85A085 ; 85/A085

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetMapMenuTilemapArea
        sta wR0
        jsr rsUnknown85A0A1
        lda wR4
        sec
        sbc wR0
        sta wR0
        jsl rlGetMapMenuPosition
        sec
        sbc wR0
        jsl rlSetMapMenuPosition
        rts

        .databank 0

    .endsection Unsorted85A079Section


    .section Unsorted85A0A1Section

      .al
      .xl

      rsUnknown85A0A1 ; 85/A0A1

        .al
        .xl
        .autsiz
        .databank ?

        lda wR7
        and #$00FF
        sec
        sbc #$0004
        sta wR10
        lda wR3
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        sta wR13
        lda wR5
        sta wR14
        jsl rlUnsignedDivide16By8
        lda wR7
        and #$FF00
        ora wR13
        clc
        adc #$0004
        sta wR4
        rts

        .databank 0

        ; 85/A0CE

    .endsection Unsorted85A0A1Section


    .section Unsorted85A0D0Section

      .al
      .xl

      rlUnknown85A0D0 ; 85/A0D0

        .al
        .xl
        .autsiz
        .databank ?

        lda wR5
        sec
        sbc wR3
        sta wR3
        bra rsUnknown85A0A1

        .databank 0

        ; 85/A0D9

      rsUnknown85A0D9 ; 85/A0D9

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetMapMenuTilemapArea
        sta wR0
        jsr rlUnknown85A0D0
        lda wR0
        sec
        sbc wR4
        sta wR0
        jsl rlGetMapMenuPosition
        clc
        adc wR0
        jsl rlSetMapMenuPosition
        rts

        .databank 0

        ; 85/A0F5

    .endsection Unsorted85A0D0Section


    .section Unsorted85A117Section

      .al
      .xl

      rlUnknown85A117 ; 85/A117

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda lR18
        sta $7FEAAA
        lda lR18+1
        sta $7FEAAB
        lda lR19
        sta $7FEAAE
        lda lR19+1
        sta $7FEAAF
        jsl rlStallProcUntilMapMenuDataLoaded
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput3,b
        jsl rlSetMapMenuPosition
        lda aProcSystem.wInput2,b
        jsl rlSetMapMenuTilemapArea
        jsl rlUnknown85877E
        plx
        phx
        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody6,b,x
        lda aProcSystem.aBody7,b,x
        bit #$8000
        bne _A166
        lda #$20FF
        sta wUnknown053C,b
        jsl rlUnknown8788E5

        _A166
        plx
        rtl

        .databank 0

        ; 85/A168

      rlProcUnknown85DAEACycle ; 85/A168

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody6,b,x
        sta aCurrentTilemapInfo,b
        lda aProcSystem.aBody7,b,x
        bit #$8000
        bne _A19A
        lda $7FEAAA
        sta lR18
        lda $7FEAAB
        sta lR18+1
        lda $7FEAAE
        sta lR19
        lda $7FEAAF
        sta lR19+1
        ldx #$0101
        jsl rlUnknown85A1E7

        _A19A
        jsl rlUnknown858793
        jsl rlUnknown85A234
        plx
        lda #<>rlUnknown85A1AA
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/A1AA

    .endsection Unsorted85A117Section


    .section Unsorted85A1AASection

      .al
      .xl

      rlUnknown85A1AA ; 85/A1AA

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0002
        bne _A1B8
        bit #$0004
        bne _A1C5
        rtl


        _A1B8
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        jsl rlFreeHDMAEntry0
        rtl


        _A1C5
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlProcUnknown85DAEACycle
        sta aProcSystem.aHeaderOnCycle,b,x
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda #$20FF
        sta wUnknown053C,b
        jsl rlUnknown8788E5
        jsl rlUnknown8785E3
        rtl

        .databank 0

        ; 85/A1E7

    .endsection Unsorted85A1AASection


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


    .section Unsorted85A320Section

      .al
      .xl

      rlUnknown85A320 ; 85/A320

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda lR18
        sta aProcSystem.aBody5,b,x
        lda lR18+1
        sta aProcSystem.aBody6,b,x
        jsl rlStallProcUntilMapMenuDataLoaded
        lda aProcSystem.wInput3,b
        jsl rlSetMapMenuPosition
        plx
        phx
        lda #$4000
        sta aProcSystem.aBody7,b,x
        lda #$0000
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        plx
        rtl

        .databank 0

        ; 85/A347

      rlUnknown85A347 ; 85/A347

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody7,b,x
        bit #$8000
        bne _A35B
        bit #$4000
        bne _A365

        _A359
        plx
        rtl


        _A35B
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        bra _A359


        _A365
        eor #$4000
        sta aProcSystem.aBody7,b,x
        phx
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$20FF
        sta wUnknown053C,b
        jsl rlUnknown8788E5
        plx
        lda aProcSystem.aBody5,b,x
        sta lR18
        lda aProcSystem.aBody6,b,x
        sta lR18+1
        ldx #$0101
        jsl rlUnknown85A3F8
        jsl rlUnknown8587E1
        bra _A359

        .databank 0

        ; 85/A394

      rlUnknown85A394 ; 85/A394

        .al
        .xl
        .autsiz
        .databank ?

        sta aProcSystem.wInput3,b
        lda #$8500
        sta lR44+1
        lda #$A314
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/A3A6

    .endsection Unsorted85A320Section


    .section Unsorted85A3A6Section

      .al
      .xl

      rlUnknown85A3A6 ; 85/A3A6

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$8500
        sta lR44+1
        lda #$A314
        sta lR44
        jsl rlProcEngineFindProc
        bcc _A3D3
        lda lMapMenuRAMEntryPointer,b
        pha
        lda lMapMenuRAMEntryPointer+1,b
        pha
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        pla
        sta lMapMenuRAMEntryPointer+1,b
        pla
        sta lMapMenuRAMEntryPointer,b

        _A3D3
        plx
        rtl

        .databank 0

        ; 85/A3D5

    .endsection Unsorted85A3A6Section


    .section Unsorted85A3D5Section

      .al
      .xl

      rlUnknown85A3D5 ; 85/A3D5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$8500
        sta lR44+1
        lda #$A314
        sta lR44
        jsl rlProcEngineFindProc
        bcc _A3F6
        lda #$4000
        sta aProcSystem.aBody7,b,x
        lda lR18
        sta aProcSystem.aBody5,b,x
        lda lR18+1
        sta aProcSystem.aBody6,b,x

        _A3F6
        plx
        rtl

        .databank 0

        ; 85/A3F8

      rlUnknown85A3F8 ; 85/A3F8

        .al
        .xl
        .autsiz
        .databank ?

        stx wR7
        stz wR6
        phb
        php
        phk
        plb
        .databank $85
        phx
        ldx lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?

        _A40B
        ldy #$0000

        _A40E
        lda $0000,b,x
        sta wR5
        phb
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        lda wR5
        sta $8BF6,b,y
        plb
        .databank $7E
        cmp #$0000
        bne _A42C
        lda #$FFFF
        sta wR6

        _A42C
        inc x
        inc x
        inc y
        inc y
        cpy #$0010
        bmi _A40E
        phx
        phb
        sep #$20
        lda #$7E
        pha
        plb
        .databank $7E
        rep #$20
        lda #$0000
        sta $8BF6,b,y
        plb
        .databank $7E
        lda #$7E00
        sta lR18+1
        lda #$8BF6
        sta lR18
        ldx wR7
        jsl rlUnknown878921
        lda wR7
        clc
        adc #$0200
        sta wR7
        plx
        lda wR6
        cmp #$0000
        beq _A40B
        plx
        plp
        plb
        .databank $7E
        rtl

        .databank 0

        ; 85/A46A

    .endsection Unsorted85A3D5Section


    .section ProcScript85A47FSection

      .al
      .xl

      procUnknown85A47F ; 85/A47F

        .structProcInfo "PW", rlProcUnknown85A47FInit, rlProcUnknown85A47FCycle1, aProcUnknown85A47FCode

    .endsection ProcScript85A47FSection


    .section Unsorted85A48BSection

      .al
      .xl

      rlProcUnknown85A47FInit ; 85/A48B

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85BC9E
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody6,b,x
        lda #$0000
        sta aProcSystem.aBody7,b,x
        phx
        lda #$8500
        sta lR18+1
        lda #$A4E6
        sta lR18
        ldx #$0102
        jsl rlUnknown878921
        lda #$8500
        sta lR18+1
        lda #$A4FA
        sta lR18
        ldx #$0303
        jsl rlUnknown878921
        lda #$8500
        sta lR18+1
        lda #$A500
        sta lR18
        ldx #$0308
        jsl rlUnknown878921
        plx
        jsl rlUnknown8587E1
        jsl rlUnknown85C0CE
        lda #$0009
        jsl rlUnknown808FAD
        rtl

        .databank 0

        ; 85/A4E6

    .endsection Unsorted85A48BSection


    .section Unsorted85A508Section

      .al
      .xl

      rlProcUnknown85A47FCycle1 ; 85/A508

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/A509

    .endsection Unsorted85A508Section


    .section Unsorted85A509Section

      .al
      .xl

      rlProcUnknown85A47FCycle2 ; 85/A509

        .al
        .xl
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #$00FF
        cmp #$000F
        bne _A56C
        lda wJoy1New
        bit #$0300
        beq _A539
        lda #$0007
        jsl rlUnknown808FAD
        lda aProcSystem.aBody7,b,x
        bit #$0001
        bne _A531
        ora #$0001
        sta aProcSystem.aBody7,b,x
        bra _A54C


        _A531
        eor #$0001
        sta aProcSystem.aBody7,b,x
        bra _A54C


        _A539
        jsr rsUnknown85A56D
        bcc _A54C
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        jsl rlUnknown85C0D5
        bra _A56C


        _A54C
        lda aProcSystem.aBody7,b,x
        bit #$0001
        bne _A559
        lda #$0002
        bra _A55C


        _A559
        lda #$0007

        _A55C
        ora #$0400
        sta wR0
        lda #$0000
        sta wR1
        phx
        jsl rlUnknown8586AA
        plx

        _A56C
        rtl

        .databank 0

        ; 85/A56D

      rsUnknown85A56D ; 85/A56D

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody6,b,x
        bne _A595
        lda wJoy1New
        bit #$0080
        beq _A591
        lda #$000A
        jsl rlUnknown808FAD
        lda aProcSystem.aBody7,b,x
        bne _A58B
        jsl rlUnknown85DCAB
        bra _A593


        _A58B
        jsl rlUnknown81B301
        bra _A593


        _A591
        clc
        rts


        _A593
        sec
        rts


        _A595
        lda wJoy1New
        bit #$0080
        beq _A5B9
        lda #$000A
        jsl rlUnknown808FAD
        lda aProcSystem.aBody7,b,x
        bne _A5BB
        lda #$000E
        jsl rlUnknown808FAD
        jsl rlUnknown87BFD9
        jsl rlSaveToSaveSlot
        bra _A5BB


        _A5B9
        clc
        rts


        _A5BB
        sec
        rts

        .databank 0

        ; 85/A5BD

    .endsection Unsorted85A509Section


    .section ProcScript85A5BDSection

      .al
      .xl

      aProcUnknown85A47FCode ; 85/A5BD

        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnknown85A47FCycle2
        PROC_HALT


        ; 85/A5C5

    .endsection ProcScript85A5BDSection


    .section Unsorted85A5C5Section

      .al
      .xl

      rlUnknown85A5C5 ; 85/A5C5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aProcSystem.wInput0,b
        lda #(`procUnknown85A47F)<<8
        sta lR44+1
        lda #<>procUnknown85A47F
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/A5DA

    .endsection Unsorted85A5C5Section


    .section Unsorted85A5FBSection

      .al
      .xl

      rlUnknown85A5FB ; 85/A5FB

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85BC9E
        lda #$2000
        sta aCurrentTilemapInfo,b
        phx
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        plx
        jsl rlGetSelectedUnitStates
        bit #UnitStateMapAnimation
        bne _A61F
        lda #$0000
        bra _A622


        _A61F
        lda #$0001

        _A622
        sta aProcSystem.aBody7,b,x
        phx
        lda #$8500
        sta lR18+1
        lda #$A670
        sta lR18
        ldx #$0101
        jsl rlUnknown878921
        lda #$8500
        sta lR18+1
        lda #$A680
        sta lR18
        ldx #$0302
        jsl rlUnknown878921
        lda #$8500
        sta lR18+1
        lda #$A688
        sta lR18
        ldx #$0502
        jsl rlUnknown878921
        lda #$8500
        sta lR18+1
        lda #$A690
        sta lR18
        ldx #$0702
        jsl rlUnknown878921
        plx
        jsl rlUnknown8587E1
        rtl

        .databank 0

        ; 85/A670

    .endsection Unsorted85A5FBSection


    .section Unsorted85A69ASection

      .al
      .xl

      rlUnknown85A69A ; 85/A69A

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/A69B

      rlUnknown85A69B ; 85/A69B

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0004
        beq _A6A7
        jml _A742


        _A6A7
        bit #$0001
        beq _A6B0
        jml _A750


        _A6B0
        bit #$0002
        beq _A6BF
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        jml _A750


        _A6BF
        lda wJoy1Repeated
        bit #$0800
        beq _A6D8
        lda #$0007
        jsl rlUnknown808FAD
        lda aProcSystem.aBody7,b,x
        dec a
        bpl _A6F0
        lda #$0002
        bra _A6F0


        _A6D8
        bit #$0400
        beq _A6F5
        lda #$0007
        jsl rlUnknown808FAD
        lda aProcSystem.aBody7,b,x
        inc a
        cmp #$0003
        bcc _A6F0
        lda #$0000

        _A6F0
        sta aProcSystem.aBody7,b,x
        bra _A750


        _A6F5
        lda wJoy1New
        bit #$0080
        beq _A736
        lda #$000A
        jsl rlUnknown808FAD
        phx
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        plx
        lda aProcSystem.aBody7,b,x
        cmp #$0002
        beq _A71D
        jsl rlSetSelectedUnitMapAnimation
        bra _A742


        _A71D
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$8500
        sta lR44+1
        lda #$A782
        sta lR44
        jsl rlProcEngineCreateProc
        bra _A750


        _A736
        bit #$8000
        beq _A750
        lda #$0021
        jsl rlUnknown808FAD

        _A742
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        jsl rlUnknown85E85D
        bra _A764


        _A750
        lda #$0300
        sta wR0
        lda #$0000
        sta wR1
        phx
        lda aProcSystem.aBody7,b,x
        inc a
        jsl rlUnknown8586AA
        plx

        _A764
        rtl

        .databank 0

        ; 85/A765

    .endsection Unsorted85A69ASection


    .section Unsorted85A78ESection

      .al
      .xl

      rlUnknown85A78E ; 85/A78E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85BC9E
        lda #$0000
        sta aProcSystem.aBody7,b,x
        rtl

        .databank 0

        ; 85/A799

      rlUnknown85A799 ; 85/A799

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        phx
        lda #$8500
        sta lR18+1
        lda #$A7CE
        sta lR18
        ldx #$0102
        jsl rlUnknown878921
        lda #$8500
        sta lR18+1
        lda #$A7D6
        sta lR18
        ldx #$0302
        jsl rlUnknown878921
        plx
        jsl rlUnknown8587E1
        lda #<>rlUnknown85A7DE
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/A7CE

    .endsection Unsorted85A78ESection


    .section Unsorted85A7DESection

      .al
      .xl

      rlUnknown85A7DE ; 85/A7DE

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Repeated
        bit #$0800
        beq _A7F7
        lda #$0007
        jsl rlUnknown808FAD
        lda aProcSystem.aBody7,b,x
        dec a
        bpl _A80F
        lda #$0001
        bra _A80F


        _A7F7
        bit #$0400
        beq _A814
        lda #$0007
        jsl rlUnknown808FAD
        lda aProcSystem.aBody7,b,x
        inc a
        cmp #$0002
        bcc _A80F
        lda #$0000

        _A80F
        sta aProcSystem.aBody7,b,x
        bra _A871


        _A814
        lda wJoy1New
        bit #$0080
        beq _A837
        lda #$000A
        jsl rlUnknown808FAD
        lda aProcSystem.aBody7,b,x
        sta wRoutineVariable1,b
        lda #$0000
        jsl rlUnknown84C62E
        lda #$0004
        sta aProcSystem.wInput0,b
        bra _A846


        _A837
        bit #$8000
        beq _A871
        stz aProcSystem.wInput0,b
        lda #$0021
        jsl rlUnknown808FAD

        _A846
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        phx
        lda #$8500
        sta lR44+1
        lda #$A5EF
        sta lR44
        jsl rlProcEngineFindProc
        bcc _A885
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFE
        ora #$0002
        ora aProcSystem.wInput0,b
        sta aProcSystem.aHeaderBitfield,b,x
        plx
        bra _A885


        _A871
        lda #$0100
        sta wR0
        lda #$0000
        sta wR1
        phx
        lda aProcSystem.aBody7,b,x
        inc a
        jsl rlUnknown8586AA
        plx

        _A885
        rtl

        .databank 0

        ; 85/A886

      rlUnknown85A886 ; 85/A886

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8500
        sta lR44+1
        lda #$A5EF
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/A895

    .endsection Unsorted85A7DESection


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


    .section Unsorted85AB8ESection

      .al
      .xl

      rlUnknown85AB8E ; 85/AB8E

        .al
        .xl
        .autsiz
        .databank ?

        lda wR43
        jsr rsUnknown85AB96
        rtl

        .databank 0

        ; 85/AB94

    .endsection Unsorted85AB8ESection


    .section Unsorted85AB96Section

      .al
      .xl

      rsUnknown85AB96 ; 85/AB96

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        ora #$0000
        beq _ABD2
        cmp #$007F
        bcc _ABC0
        sec
        sbc #$0078
        sta wR0
        sep #$20
        lda #$78
        sta $7FEA9A,x
        rep #$20
        inc x
        lda #$ABED
        sta $7FEA9A,x
        inc x
        inc x
        lda wR0

        _ABC0
        sep #$20
        sta $7FEA9A,x
        rep #$20
        inc x
        lda #$ABED
        sta $7FEA9A,x
        inc x
        inc x

        _ABD2
        lda #$0018
        sep #$20
        sta $7FEA9A,x
        rep #$20
        lda #$ABEF
        sta $7FEA9B,x
        lda #$0000
        sta $7FEA9D,x
        plx
        rts

        .databank 0

        ; 85/ABED

    .endsection Unsorted85AB96Section


    .section Unsorted85ABF1Section

      .al
      .xl

      rlUnknown85ABF1 ; 85/ABF1

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlHDMAEngineFreeEntryByIndex
        rtl

        .databank 0

        ; 85/ABF6

    .endsection Unsorted85ABF1Section


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

      rlProcUnknown85ABF6Init ; 85/AC02

        .al
        .autsiz
        .databank ?

        phx
        lda #$0008
        tsb $0788,b

        lda wGameStateRoutine1,b
        sta aProcSystem.aBody5,b,x
        stz wGameStateRoutine1,b

        lda #$0078
        sta aProcSystem.aBody6,b,x

        lda #2
        sta $7FEAAC

        stz $89
        stz $87
        stz $85
        stz $83

        jsl rlUnknown85A227
        jsr rsUnknown85B009
        jsr rsUnknown85B07C

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


    .section Unsorted85AC40Section

      .al
      .xl

      rlProcUnknown85ABF6Cycle ; 85/AC40

        .al
        .xl
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne _AC88
        phx
        phy
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8E88, $0180, $80, $7000

        lda #$7E00
        sta lR18+1
        lda #$8C88
        sta lR18
        lda #$7E00
        sta lR18+1
        lda wActiveFactionSlot,b
        jsl rlGetFactionBattleBannerID
        xba
        lsr a
        lsr a
        lsr a
        clc
        adc #$8C98
        sta lR18
        ldy #$000E

        _AC77
        lda [lR18],y
        sta $01F0,b,y
        dec y
        dec y
        bpl _AC77
        ply
        plx
        lda #<>rlUnknown85AC89
        sta aProcSystem.aHeaderOnCycle,b,x

        _AC88
        rtl

        .databank 0

        ; 85/AC89

    .endsection Unsorted85AC40Section


    .section Unsorted85AC89Section

      .al
      .xl

      rlUnknown85AC89 ; 85/AC89

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$1800
        sta aCurrentTilemapInfo,b
        lda #$8500
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$AD55
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #(`aUnknown85ACC2)<<8
        sta lR18+1
        lda #<>aUnknown85ACC2
        sta lR18
        jsl rlUnknown878BF0
        jsr rsUnknown85AFC5
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        plx
        lda #<>rlUnknown85ACEE
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/ACC2

      aUnknown85ACC2 ; 85/ACC2

        .word $0307, $2308, $2309, $230A, $230B, $230C, $230D, $230E
        .word $2318, $2319, $231A, $231B, $231C, $231D, $231E, $2328
        .word $2329, $232A, $232B, $232C, $232D, $232E

      rlUnknown85ACEE ; 85/ACEE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$2400
        sta aCurrentTilemapInfo,b
        lda wActiveFactionSlot,b
        jsl rlGetFactionSlotNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        jsl rlGetMenuTextStringLength
        lda #$001A
        sec
        sbc wR10
        lsr a
        and #$00FF
        ora #$0D00
        tax
        clc
        adc wR10
        pha
        lda #$8500
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$AD5E
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlDrawMenuTextLine
        lda #$8500
        sta lR18+1
        lda #$AD47
        sta lR18
        plx
        jsl rlDrawMenuTextLine
        jsl rlUnknown878459
        plx
        lda #<>rlUnknown85AD67
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

    .endsection Unsorted85AC89Section


    .section Unsorted85AD67Section

      .al
      .xl

      rlUnknown85AD67 ; 85/AD67

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown85A234
        lda #$0002
        sta wR40
        lda #$8500
        sta lR44+1
        lda #$AEBB
        sta lR44
        jsl rlHDMAEngineCreateEntryByIndex
        sep #$20
        lda #$02
        sta bBufferCGWSEL
        lda #$42
        sta bBufferCGADSUB
        lda #$11
        sta bBufferTS
        rep #$20
        plx
        lda #<>rlUnknown85AD97
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/AD97

      rlUnknown85AD97 ; 85/AD97

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FEAAA
        cmp #$7FFF
        bne _ADA6
        lda #<>rlUnknown85ADA7
        sta aProcSystem.aHeaderOnCycle,b,x

        _ADA6
        rtl

        .databank 0

        ; 85/ADA7

      rlUnknown85ADA7 ; 85/ADA7

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody6,b,x
        bpl _ADB2
        lda #<>rlUnknown85ADB3
        sta aProcSystem.aHeaderOnCycle,b,x

        _ADB2
        rtl

        .databank 0

        ; 85/ADB3

      rlUnknown85ADB3 ; 85/ADB3

        .al
        .xl
        .autsiz
        .databank ?

        stz wBufferBG2VOFS
        stz wBufferBG2HOFS
        stz wBufferBG3VOFS
        stz wBufferBG3HOFS
        sep #$20
        lda #$02
        sta bBufferCGWSEL
        lda #$42
        sta bBufferCGADSUB
        lda #$11
        sta bBufferTS
        rep #$20
        jsr rsUnknown85B07C
        lda #<>rlUnknown85ADD5
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/ADD5

      rlUnknown85ADD5 ; 85/ADD5

        .al
        .xl
        .autsiz
        .databank ?

        lda #<>rlUnknown85ADF6
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0002
        jsl rlHDMAEngineFreeEntryByIndex
        lda #$0002
        sta wR40
        lda #$8500
        sta lR44+1
        lda #$AF0F
        sta lR44
        jsl rlHDMAEngineCreateEntryByIndex
        rtl

        .databank 0

        ; 85/ADF6

      rlUnknown85ADF6 ; 85/ADF6

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FEAAA
        cmp #$FFFF
        beq _AE00
        rtl


        _AE00
        phx
        lda #$030F
        sta wUnknown053C,b
        lda #$8500
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$AD55
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlUnknown878B98
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $0800, $80, $A800

        plx
        lda #<>rlUnknown85AE2C
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/AE2C

      rlUnknown85AE2C ; 85/AE2C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$20FF
        sta wUnknown053C,b
        lda #$8500
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$AD5E
        sta lMapMenuTilemapRAMEntryPointer,b
        jsl rlUnknown878B98
        jsl rlUnknown878459
        lda #$0002
        jsl rlHDMAEngineFreeEntryByIndex
        plx
        lda #<>rlUnknown85AE56
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/AE56

      rlUnknown85AE56 ; 85/AE56

        .al
        .xl
        .autsiz
        .databank ?

        stz wBufferBG2VOFS
        stz wBufferBG2HOFS
        stz wBufferBG3VOFS
        stz wBufferBG3HOFS
        jsr rsUnknown85B039
        sep #$20
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        lda #$00
        sta bBufferTS
        lda #$E0
        sta bBufferCOLDATA_0
        sta bBufferCOLDATA_1
        sta bBufferCOLDATA_2
        sta bBufferCOLDATA_3
        rep #$20
        lda aProcSystem.aBody5,b,x
        sta wGameStateRoutine1,b
        jsl rlProcEngineFreeProc
        jsl rlUnknown85C0D5
        rtl

        .databank 0

        ; 85/AE8A

    .endsection Unsorted85AD67Section


    .section Unsorted85AE8ASection

      .al
      .xl

      rlUnknown85AE8A ; 85/AE8A

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$D0C0
        beq _AEAB
        lda #$0004
        sta $7FEAAC
        lda aProcSystem.aBody6,b,x
        sec
        sbc #$0064
        sta aProcSystem.aBody6,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _AEAB
        rtl

        .databank 0

        ; 85/AEAC

    .endsection Unsorted85AE8ASection


    .section ProcScript85AEACSection

      .al
      .xl

      aProcUnknown85ABF6Code ; 85/AEAC

        PROC_YIELD 1
        PROC_CALL rlUnknown85AE8A
        PROC_JUMP_IF_BITS_UNSET aProcUnknown85ABF6Code, $0001
        PROC_HALT


        ; 85/AEBB

    .endsection ProcScript85AEACSection


    .section Unsorted85AEC7Section

      .al
      .xl

      rlUnknown85AEC7 ; 85/AEC7

        .al
        .xl
        .autsiz
        .databank ?

        lda #$006E
        sta $7FEAAA
        jsr rsUnknown85AF5A
        rtl

        .databank 0

        ; 85/AED2

      rlUnknown85AED2 ; 85/AED2

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FEAAA
        sec
        sbc $7FEAAC
        sta $7FEAAA
        cmp #$0058
        bmi _AEE8

        _AEE4
        jsr rsUnknown85AF5A
        rtl


        _AEE8
        sec
        sbc #$0058
        clc
        adc $7FEAAC
        bmi _AEFE
        beq _AEFE
        lda #$0058
        sta $7FEAAA
        bra _AEE4


        _AEFE
        lda #<>rlUnknown85AF0C
        sta aHDMASystem.aOnCycle,b,x
        lda #$7FFF
        sta $7FEAAA
        rtl

        .databank 0

        ; 85/AF0C

      rlUnknown85AF0C ; 85/AF0C

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/AF0D

    .endsection Unsorted85AEC7Section


    .section Unsorted85AF1BSection

      .al
      .xl

      rlUnknown85AF1B ; 85/AF1B

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0058
        sta $7FEAAA
        rtl

        .databank 0

        ; 85/AF23

      rlUnknown85AF23 ; 85/AF23

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FEAAA
        clc
        adc $7FEAAC
        sta $7FEAAA
        cmp #$0071
        bpl _AF39

        _AF35
        jsr rsUnknown85AF5A
        rtl


        _AF39
        sec
        sbc #$0070
        cmp $7FEAAC
        bpl _AF4C
        lda #$0070
        sta $7FEAAA
        bra _AF35


        _AF4C
        lda #<>rlUnknown85AF0C
        sta aHDMASystem.aOnCycle,b,x
        lda #$FFFF
        sta $7FEAAA
        rtl

        .databank 0

        ; 85/AF5A

      rsUnknown85AF5A ; 85/AF5A

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        bit #$0001
        bne _AF66
        lda #$0000
        bra _AF69


        _AF66
        lda #$0010

        _AF69
        sta wR4
        jsr rsUnknown85AF78
        lda #$EAAE
        clc
        adc wR4
        sta aHDMASystem.aOffset,b,x
        rts

        .databank 0

        ; 85/AF78

      rsUnknown85AF78 ; 85/AF78

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda $7FEAAA
        ldx wR4
        sep #$20
        sta $7FEAAE,x
        rep #$20
        asl a
        sta wR0
        lda #$AFC3
        sta $7FEAAF,x
        lda #$00E0
        sec
        sbc wR0
        sep #$20
        sta $7FEAB1,x
        rep #$20
        lda #$AFC4
        sta aDialogueBoxHDMAIndirectTableOdd,x
        lda $7FEAAA
        dec a
        sep #$20
        sta $7FEAB4,x
        rep #$20
        lda #$AFC3
        sta $7FEAB5,x
        lda #$0000
        sta $7FEAB7,x
        plx
        rts

        .databank 0

        ; 85/AFC3

    .endsection Unsorted85AF1BSection


    .section Unsorted85AFC5Section

      .al
      .xl

      rsUnknown85AFC5 ; 85/AFC5

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
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        ldy #$7EA6
        lda #$3F80
        sta wR0
        stz wR1

        _AFDD
        ldx #$0000

        _AFE0
        lda wR0
        sta $0000,b,y
        cpx #$0002
        beq _AFF1
        inc x
        inc y
        inc y
        inc wR0
        bra _AFE0


        _AFF1
        lda wR1
        cmp #$0003
        beq _B004
        inc wR0
        inc wR1
        tya
        clc
        adc #$003C
        tay
        bra _AFDD


        _B004
        plx
        ply
        plp
        plb
        .databank $7E
        rts

        .databank 0

        ; 85/B009

    .endsection Unsorted85AFC5Section


    .section Unsorted85B009Section

      .al
      .xl

      rsUnknown85B009 ; 85/B009

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


    .section Unsorted85B039Section

      .al
      .xl

      rsUnknown85B039 ; 85/B039

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000

        _B03D
        lda $7FEACE,x
        sta $0108,b,x
        lda $7FEAD6,x
        sta $01D0,b,x
        lda $7FEADE,x
        sta $01D8,b,x
        lda $7FEAEE,x
        sta $01F0,b,x
        lda $7FEB0E,x
        sta $01F8,b,x
        inc x
        inc x
        cpx #$0008
        bmi _B03D
        plx
        rts

        .databank 0

        ; 85/B069

    .endsection Unsorted85B039Section


    .section Unsorted85B07CSection

      .al
      .xl

      rsUnknown85B07C ; 85/B07C

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        ldx wActiveFactionSlot,b
        jsl rlGetFactionRelation
        sta wR0
        jsr rsUnknown85B091
        jsr rsUnknown85B107
        plx
        rts

        .databank 0

        ; 85/B091

      rsUnknown85B091 ; 85/B091

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
        lda aUnknown85B0BF,x
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


    .section Table85B0BFSection

      .al
      .xl

      aUnknown85B0BF ; 85/B0BF

        ; Read by rsUnknown85B091.

        .word $B0C7, $B0D7, $B0E7, $B0F7, $4D96, $039C, $7292, $6A70
        .word $6A2F, $660E, $61ED, $04A7, $3000, $039C, $24F9, $0CB7
        .word $1896, $1475, $1054, $04A7, $3000, $039C, $5370, $4B2E
        .word $470D, $42EC, $3AAA, $04A7, $3000, $03FF, $5F9C, $537B
        .word $4B18, $3EF8, $2E96, $08C8

        ; 85/B107

    .endsection Table85B0BFSection


    .section Unsorted85B107Section

      .al
      .xl

      rsUnknown85B107 ; 85/B107

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wR0
        asl a
        tax
        lda aUnknown85B127,x
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


    .section Table85B127Section

      .al
      .xl

      aUnknown85B127 ; 85/B127

        ; Read by rsUnknown85B107.

        .word $B12F, $B137, $B13F, $B147, $4D96, $152B, $67DE, $0864
        .word $4D96, $1529, $67FC, $0443, $4D96, $1509, $6FBE, $0423
        .word $4D96, $212A, $737D, $0C44

        ; 85/B14F

    .endsection Table85B127Section


    .section Unsorted85B14FSection

      .al
      .xl

      rlUnknown85B14F ; 85/B14F

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.wInput0,b
        sta wSelectedUnitDataRAMPointer,b
        lda #$0008
        jsl rlGetItemIDByInventorySlot
        jsl rlGetItemDataROMPointer
        lda wCurrentItemDataROMPointer,b
        sta aProcSystem.wInput0,b
        lda wSelectedUnitDataRAMPointer,b
        sta aProcSystem.wInput3,b
        jsl rlUnknown85B52F
        jsl rlUnknown85B520
        lda wSelectedUnitDataRAMPointer,b
        sta aProcSystem.wInput0,b
        lda wCurrentItemDataROMPointer,b
        sta aProcSystem.wInput1,b
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
        jsr rsUnknown85B45C
        bcs +

          lda #$2000
          sta aCurrentTilemapInfo.wBaseTile,b
          jsr rsUnknown85B489
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

        jsr rsUnknown85B2DA
        jsr rsUnknown85B307
        jsl rlUnknown85A234
        lda #<>rlUnknown85B207
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/B207

    .endsection Unsorted85B1B0Section


    .section Unsorted85B207Section

      .al
      .xl

      rlUnknown85B207 ; 85/B207

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown85B307
        lda wJoy1New
        bit #$0080
        beq _B220
        lda #$000A
        jsl rlUnknown808FAD
        lda #$B26B
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _B254


        _B220
        lda wJoy1Repeated
        bit #$0800
        beq _B239
        lda #$0006
        jsl rlUnknown808FAD
        lda aProcSystem.aBody6,b,x
        dec a
        bpl _B251
        lda #$0007
        bra _B251


        _B239
        bit #$0400
        beq _B254
        lda #$0006
        jsl rlUnknown808FAD
        lda aProcSystem.aBody6,b,x
        inc a
        cmp #$0008
        bcc _B251
        lda #$0000

        _B251
        sta aProcSystem.aBody6,b,x

        _B254
        lda #$0100
        sta wR0
        lda #$0010
        sta wR1
        lda aProcSystem.aBody6,b,x
        bne _B264
        dec a

        _B264
        phx
        jsl rlUnknown8586AA
        plx
        rtl

        .databank 0

        ; 85/B26B

    .endsection Unsorted85B207Section


    .section Unsorted85B282Section

      .al
      .xl

      rlUnknown85B282 ; 85/B282

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$0080
        beq _B29F
        lda #$000A
        jsl rlUnknown808FAD
        jsr rsUnknown85B43E
        pha
        jsr rsUnknown85B40E
        pla
        ora #$0000
        beq _B2BB
        bra _B2B2


        _B29F
        bit #$8000
        beq _B2B0
        lda #$0021
        jsl rlUnknown808FAD
        jsr rsUnknown85B40E
        bra _B2B2


        _B2B0
        bra _B2C9


        _B2B2
        jsr rsUnknown85B3DA
        jsl rlUnknown85A227
        bra _B2C3


        _B2BB
        jsr rsUnknown85B367
        jsr rsUnknown85B3B1
        bra _B2C9


        _B2C3
        lda #$B2CA
        sta aProcSystem.aHeaderOnCycle,b,x

        _B2C9
        rtl

        .databank 0

        ; 85/B2CA

    .endsection Unsorted85B282Section


    .section ProcScript85B2D8Section

      .al
      .xl

      aProcUnknown85B18FCode ; 85/B2D8

        PROC_HALT


        ; 85/B2DA

    .endsection ProcScript85B2D8Section


    .section Unsorted85B2DASection

      .al
      .xl

      rsUnknown85B2DA ; 85/B2DA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda aProcSystem.aBody4,b,x
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
        jsl rlCopyItemIcon
        lda #$0006
        jsl rlUnitWindowCopySpritePalette1
        ply
        dec y
        bpl _B2E5
        ply
        plx
        rts

        .databank 0

        ; 85/B307

      rsUnknown85B307 ; 85/B307

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


    .section Unsorted85B367Section

      .al
      .xl

      rsUnknown85B367 ; 85/B367

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody6,b,x
        bne _B36F
        lda #$0008

        _B36F
        sta wSelectedInventorySlot,b
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlDumpInventorySlotIntoSupplyIfFilled
        rts

        .databank 0

        ; 85/B37D

    .endsection Unsorted85B367Section


    .section Unsorted85B37DSection

      .al
      .xl

      rsUnknown85B37D ; 85/B37D

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown85877E
        lda #(`procUnknown85B63B)<<8
        sta lR44+1
        lda #<>procUnknown85B63B
        sta lR44
        jsr rsUnknown85B3A2
        lda #(`procUnknown85B6E3)<<8
        sta lR44+1
        lda #<>procUnknown85B6E3
        sta lR44
        jsr rsUnknown85B3A2
        plx
        rts

        .databank 0

        ; 85/B3A2

    .endsection Unsorted85B37DSection


    .section Unsorted85B3A2Section

      .al
      .xl

      rsUnknown85B3A2 ; 85/B3A2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlProcEngineFindProc
        bcc _B3B0
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown85877E

        _B3B0
        rts

        .databank 0

        ; 85/B3B1

      rsUnknown85B3B1 ; 85/B3B1

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        lda #(`procUnknown85B63B)<<8
        sta lR44+1
        lda #<>procUnknown85B63B
        sta lR44
        jsr rsUnknown85B42B
        lda #(`procUnknown85B6E3)<<8
        sta lR44+1
        lda #<>procUnknown85B6E3
        sta lR44
        jsr rsUnknown85B42B
        plx
        rts

        .databank 0

        ; 85/B3DA

    .endsection Unsorted85B3A2Section


    .section Unsorted85B3DASection

      .al
      .xl

      rsUnknown85B3DA ; 85/B3DA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown858793
        lda #(`procUnknown85B63B)<<8
        sta lR44+1
        lda #<>procUnknown85B63B
        sta lR44
        jsr rsUnknown85B3FF
        lda #(`procUnknown85B6E3)<<8
        sta lR44+1
        lda #<>procUnknown85B6E3
        sta lR44
        jsr rsUnknown85B3FF
        plx
        rts

        .databank 0

        ; 85/B3FF

    .endsection Unsorted85B3DASection


    .section Unsorted85B3FFSection

      .al
      .xl

      rsUnknown85B3FF ; 85/B3FF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlProcEngineFindProc
        bcc _B40D
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown858793

        _B40D
        rts

        .databank 0

        ; 85/B40E

    .endsection Unsorted85B3FFSection


    .section Unsorted85B40ESection

      .al
      .xl

      rsUnknown85B40E ; 85/B40E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$8500
        sta lR44+1
        lda #$B704
        sta lR44
        jsr rsUnknown85B42B
        lda #$8500
        sta lR44+1
        lda #$B547
        sta lR44
        jsr rsUnknown85B42B
        plx
        rts

        .databank 0

        ; 85/B42B

    .endsection Unsorted85B40ESection


    .section Unsorted85B42BSection

      .al
      .xl

      rsUnknown85B42B ; 85/B42B

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlProcEngineFindProc
        bcc _B43D
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc

        _B43D
        rts

        .databank 0

        ; 85/B43E

    .endsection Unsorted85B42BSection


    .section Unsorted85B43ESection

      .al
      .xl

      rsUnknown85B43E ; 85/B43E

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$8500
        sta lR44+1
        lda #$B547
        sta lR44
        jsl rlProcEngineFindProc
        bcc _B457
        lda aProcSystem.aBody7,b,x
        and #$0001
        bra _B45A


        _B457
        lda #$0000

        _B45A
        plx
        rts

        .databank 0

        ; 85/B45C

    .endsection Unsorted85B43ESection


    .section Unsorted85B45CSection

      .al
      .xl

      rsUnknown85B45C ; 85/B45C

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

      rsUnknown85B489 ; 85/B489

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
        jsr rsUnknown85B4ED
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

      rsUnknown85B4ED ; 85/B4ED

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

        lda #(`procUnknown85B63B)<<8
        sta lR44+1
        lda #<>procUnknown85B63B
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
        sta aProcSystem.wInput1,b
        sta aProcSystem.wInput2,b
        lda #(`procUnknown85B6E3)<<8
        sta lR44+1
        lda #<>procUnknown85B6E3
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/B547

    .endsection Unsorted85B520Section


    .section ProcScript85B63BSection

      .al
      .xl

      procUnknown85B63B ; 85/B63B

        .structProcInfo "PW", rlProcUnknown85B63BInit, rlProcUnknown85B63BCycle, aProcUnknown85B63BCode

    .endsection ProcScript85B63BSection


    .section Unsorted85B65CSection

      .al
      .xl

      rlProcUnknown85B63BInit ; 85/B65C

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85BC9E
        lda #$2000
        sta aCurrentTilemapInfo,b
        phx
        lda #$8500
        sta lR18+1
        lda #$B6A0
        sta lR18
        ldx #$0101
        jsl rlUnknown878921
        lda #$8500
        sta lR18+1
        lda #$B6BA
        sta lR18
        ldx #$0301
        jsl rlUnknown878921
        lda #$8500
        sta lR18+1
        lda #$B6D4
        sta lR18
        ldx #$0501
        jsl rlUnknown878921
        plx
        jsl rlUnknown8587E1
        rtl

        .databank 0

        ; 85/B6A0

    .endsection Unsorted85B65CSection


    .section Unsorted85B6E0Section

      .al
      .xl

      rlProcUnknown85B63BCycle ; 85/B6E0

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/B6E1

    .endsection Unsorted85B6E0Section


    .section ProcScript85B6E1Section

      .al
      .xl

      aProcUnknown85B63BCode ; 85/B6E1

        PROC_HALT


        ; 85/B6E3

      procUnknown85B6E3 ; 85/B6E3

        .structProcInfo "PW", rlProcUnknown85B6E3Init, rlProcUnknown85B6E3Cycle, aProcUnknown85B6E3Code

    .endsection ProcScript85B6E1Section


    .section Unsorted85B725Section

      .al
      .xl

      rlProcUnknown85B6E3Init ; 85/B725

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85BC9E
        lda aProcSystem.wInput0,b
        sta wCurrentItemDataROMPointer,b
        lda aProcSystem.wInput1,b
        bmi _B738
        jsl rlSetMapMenuPosition

        _B738
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput3,b
        sta wSelectedUnitDataRAMPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda aProcSystem.wInput2,b
        bpl _B769
        lda #$0008
        jsl rlCheckIfWeaponEquipped
        bcc _B769
        lda #$8500
        sta lR18+1
        lda #$B786
        sta lR18
        ldx #$010C
        jsl rlUnknown878921

        _B769
        jsr rsUnknown85B4ED
        jsl rlGetItemNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        ldx #$0104
        jsl rlUnknown878921
        jsl rlUnknown8587E1
        rtl

        .databank 0

        ; 85/B786

    .endsection Unsorted85B725Section


    .section Unsorted85B78ASection

      .al
      .xl

      rlProcUnknown85B6E3Cycle ; 85/B78A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aBody7,b,x
        bmi _B7CD
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlGetMapMenuPosition
        cmp #$0000
        bmi _B7CD
        pha
        and #$00FF
        clc
        adc #$0002
        asl a
        asl a
        asl a
        sta wR0
        pla
        xba
        and #$00FF
        clc
        adc #$0001
        asl a
        asl a
        asl a
        sta wR1
        lda aProcSystem.aBody7,b,x
        beq _B7C2
        sec
        sbc #$0008
        asl a

        _B7C2
        sta wR4
        stz wR5
        ldy $983F,b
        jsl rlPushToOAMBuffer

        _B7CD
        plx
        rtl

        .databank 0

        ; 85/B7CF

    .endsection Unsorted85B78ASection


    .section ProcScript85B7CFSection

      .al
      .xl

      aProcUnknown85B6E3Code ; 85/B7CF

        PROC_HALT


        ; 85/B7D1

    .endsection ProcScript85B7CFSection


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


    .section Unsorted85B8D6Section

      .al
      .xl

      rlUnknown85B8D6 ; 85/B8D6

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown85B8FA)<<8
        sta lR44+1
        lda #<>procUnknown85B8FA
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


    .section ProcScript85B8FASection

      .al
      .xl

      procUnknown85B8FA ; 85/B8FA

        .structProcInfo "PW", rlProcUnknown85B8FAInit, rlProcUnknown85B9D4Cycle1, aProcDialogueBoxCode

    .endsection ProcScript85B8FASection


    .section Unsorted85B906Section

      .al
      .xl

      rlProcUnknown85B8FAInit ; 85/B906

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85BC9E
        jsl rlUnknown85C0CE
        lda #$00B4
        sta aProcSystem.aBody5,b,x
        lda aProcSystem.wInput3,b
        and #$FF00
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody6,b,x
        ldy #$0000
        cmp #$000A
        bmi _B93E
        cmp #$0064
        bmi _B93D
        cmp #$03E8
        bmi _B93C
        cmp #$2710
        bmi _B93B
        inc y

        _B93B
        inc y

        _B93C
        inc y

        _B93D
        inc y

        _B93E
        inc y
        tya
        clc
        adc #$000E
        sta wR0
        ora #$0400
        jsl rlSetMapMenuTilemapArea
        lda #$0020
        sec
        sbc wR0
        lsr a
        ora aProcSystem.aBody7,b,x
        jsl rlSetMapMenuPosition
        phx
        phy
        lda #$20F0
        sta aCurrentTilemapInfo,b
        lda aProcSystem.aBody6,b,x
        sta wR0

        _B968
        dec y
        lda wR0
        sta wR13
        lda #$000A
        sta wR14
        jsl rlUnsignedDivide16By16R13
        lda wR13
        sta wR0
        lda wR10
        beq _B980
        bra _B983


        _B980
        tya
        bmi _B991

        _B983
        tya
        clc
        adc #$0101
        tax
        lda wR10
        jsl rlUnknown878916
        bra _B968


        _B991
        ply
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$B9BC
        sta lR18
        tya
        clc
        adc #$0102
        tax
        jsl rlUnknown878921
        jsl rlUnknown8587E1
        jsl rlUnknown85A227
        plx
        lda #$0094
        sta aProcSystem.aBody4,b,x
        rtl

        .databank 0

        ; 85/B9BC

    .endsection Unsorted85B906Section


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
          lda #<>rlUnknown85B9F2
          sta aProcSystem.aHeaderOnCycle,b,x

        +
        rtl

        .databank 0

        ; 85/B9F2

    .endsection Unsorted85B9D4Section


    .section Unsorted85B9F2Section

      .al
      .xl

      rlUnknown85B9F2 ; 85/B9F2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$D0C0
        beq _BA09
        lda #$BA09
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aBody5,b,x
        sec
        sbc #$003C
        sta aProcSystem.aBody5,b,x

        _BA09
        lda aProcSystem.aBody5,b,x
        dec a
        bmi _BA13
        sta aProcSystem.aBody5,b,x

        _BA12
        rtl


        _BA13
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown8586FA
        jsl rlUnknown85C0C7
        jsl rlUnknown85C0D5
        lda #$00E8
        jsl rlUnknown808FA3
        bra _BA12

        .databank 0

        ; 85/BA2C

    .endsection Unsorted85B9F2Section


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


    .section Unsorted85BAC7Section

      .al
      .xl

      rlProcUnknown85BA41Cycle ; 85/BAC7

        .al
        .xl
        .autsiz
        .databank ?

        lda $04BA,b
        bne _BAD8
        lda #$0001
        sta $0508,b
        lda #<>rlUnknown85BAD9
        sta aProcSystem.aHeaderOnCycle,b,x

        _BAD8
        rtl

        .databank 0

        ; 85/BAD9

    .endsection Unsorted85BAC7Section


    .section Unsorted85BAD9Section

      .al
      .xl

      rlUnknown85BAD9 ; 85/BAD9

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody6,b,x
        dec a
        bmi _BAE3
        sta aProcSystem.aBody6,b,x
        rtl


        _BAE3
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown858793
        lda #$0095
        jsl rlUnknown808FAD
        lda #<>rlUnknown85BAF9
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/BAF9

      rlUnknown85BAF9 ; 85/BAF9

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$D0C0
        beq _BB10
        lda #$BB10
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aBody7,b,x
        sec
        sbc #$003C
        sta aProcSystem.aBody7,b,x

        _BB10
        lda aProcSystem.aBody7,b,x
        dec a
        bmi _BB1A
        sta aProcSystem.aBody7,b,x

        _BB19
        rtl


        _BB1A
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown8586FA
        jsl rlUnknown85C0C7
        lda #$0000
        sta $0508,b
        bra _BB19

        .databank 0

        ; 85/BB2E

    .endsection Unsorted85BAD9Section


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


    .section Unsorted85BC00Section

      .al
      .xl

      rlUnknown85BC00 ; 85/BC00

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown85BC0F)<<8
        sta lR44+1
        lda #<>procUnknown85BC0F
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/BC0F

    .endsection Unsorted85BC00Section


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
        lda lRoutineVariable,b
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
        sta wUnknown053C,b
        jsl rlUnknown8788E5
        jsl rlUnknown85A234
        rtl

        .databank 0

        ; 85/BCB8

    .endsection Unsorted85BC9ESection


    .section Unsorted85BCB8Section

      .al
      .xl

      rlUnknown85BCB8 ; 85/BCB8

        .al
        .xl
        .autsiz
        .databank ?

        lda wR13
        bmi _BCC1
        jsl rlUnsignedDivide16By16R13
        rtl


        _BCC1
        eor #$FFFF
        inc a
        sta wR13
        jsl rlUnsignedDivide16By16R13
        lda wR13
        eor #$FFFF
        inc a
        sta wR13
        rtl

        .databank 0

        ; 85/BCD4

    .endsection Unsorted85BCB8Section


    .section Unsorted85BCD4Section

      .al
      .xl

      rlUnknown85BCD4 ; 85/BCD4

        ; Found by tools/sweep.py: nothing in the build reaches this.
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

        ; Found by tools/sweep.py: nothing in the build reaches this.
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
        jsl rlUnknown85BCB8
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
        jsl rlUnknown85BCB8
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
        ldy $BE87,b,x
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
        jsl rlUnknown85C0D5
        rtl

        .databank 0

        ; 85/C0C7

    .endsection Unsorted85C0BASection


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


    .section Unsorted85C0E2Section

      .al
      .xl

      rsUnknown85C0E2 ; 85/C0E2

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        and #$00FF
        sta aProcSystem.wInput0,b
        lda $0FD8,b,x
        and #$00FF
        sta aProcSystem.wInput1,b
        rts

        .databank 0

        ; 85/C0F5

      rsUnknown85C0F5 ; 85/C0F5

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.wInput1,b
        xba
        ora aProcSystem.wInput0,b
        sta aProcSystem.aBody0,b,x
        rts

        .databank 0

        ; 85/C100

      rsUnknown85C100 ; 85/C100

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.wInput1,b
        xba
        ora aProcSystem.wInput0,b
        sta aProcSystem.aBody1,b,x
        rts

        .databank 0

        ; 85/C10B

      rsUnknown85C10B ; 85/C10B

        .al
        .xl
        .autsiz
        .databank ?

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

      rsUnknown85C12B ; 85/C12B

        .al
        .xl
        .autsiz
        .databank ?

        sta aProcSystem.aBody2,b,x
        rts

        .databank 0

        ; 85/C12F

      rsUnknown85C12F ; 85/C12F

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody3,b,x
        bit #$0020
        bne _C149
        lda $0788,b
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

      rsUnknown85C14B ; 85/C14B

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody3,b,x
        bit #$0080
        bne _C15E
        bit #$0040
        bne _C15E
        jsl rlUnknown88A38C
        bcc _C160

        _C15E
        sec
        rts


        _C160
        clc
        rts

        .databank 0

        ; 85/C162

      rsUnknown85C162 ; 85/C162

        .al
        .xl
        .autsiz
        .databank ?

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
        lda #$8500
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$C19B
        sta lMapMenuTilemapRAMEntryPointer,b
        pea #<>_C19A - 1
        jmp ($0ED1)


        _C19A
        rts

        .databank 0

        ; 85/C19B

    .endsection Unsorted85C0E2Section


    .section Unsorted85C1A4Section

      .al
      .xl

      rsUnknown85C1A4 ; 85/C1A4

        .al
        .xl
        .autsiz
        .databank ?

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
        jsr rsUnknown85C10B
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

      rsUnknown85C1FA ; 85/C1FA

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
        jsr rsUnknown85C10B
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

      rsUnknown85C24D ; 85/C24D

        .al
        .xl
        .autsiz
        .databank ?

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
        jsr rsUnknown85C10B
        bcs _C28E
        tax

        _C271
        lda wR0
        sta wR1

        _C275
        lda $0000,b,y
        sta $7FDD4A,x
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

      rsUnknown85C291 ; 85/C291

        .al
        .xl
        .autsiz
        .databank ?

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
        lda #$7FDD
        sta lR18+1
        lda #$DD4A
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
        lda $0788,b
        bit #$0002
        bne _C2EF
        lda #$7FE3
        sta lR18+1
        lda #$E3CA
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

      rsUnknown85C2F1 ; 85/C2F1

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody3,b,x
        ora #$0020
        sta aProcSystem.aBody3,b,x
        rts

        .databank 0

        ; 85/C2FB

      rsUnknown85C2FB ; 85/C2FB

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

    .endsection Unsorted85C1A4Section


    .section Unsorted85C30DSection

      .al
      .xl

      rlUnknown85C30D ; 85/C30D

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aProcSystem.aBody2,b,x
        lda #$0040
        sta aProcSystem.aBody3,b,x
        rtl

        .databank 0

        ; 85/C31A

      rlUnknown85C31A ; 85/C31A

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown85C12F
        bcs _C32B
        jsr rsUnknown85C14B
        bcc _C33C
        jsr rsUnknown85C162
        bcs _C33C
        bra _C339


        _C32B
        jsr rsUnknown85C1A4
        bcs _C33C
        lda aProcSystem.aBody3,b,x
        ora #$0080
        sta aProcSystem.aBody3,b,x

        _C339
        jsr rsUnknown85C291

        _C33C
        rtl

        .databank 0

        ; 85/C33D

    .endsection Unsorted85C30DSection


    .section Unsorted85C347Section

      .al
      .xl

      rlUnknown85C347 ; 85/C347

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85C30D
        lda #$C3A9
        jsr rsUnknown85C12B
        lda #$0002
        sta aProcSystem.wInput0,b
        lda #$0001
        sta aProcSystem.wInput1,b
        jsr rsUnknown85C0F5
        lda #$0009
        sta aProcSystem.wInput0,b
        lda #$0005
        sta aProcSystem.wInput1,b
        jsr rsUnknown85C100
        jsr rsUnknown85C41F
        lda aProcSystem.aBody3,b,x
        ora #$0004
        sta aProcSystem.aBody3,b,x
        rtl

        .databank 0

        ; 85/C37C

      rlUnknown85C37C ; 85/C37C

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda $0788,b
        bit #$00FD
        beq _C393
        lda aProcSystem.aBody3,b,x
        bit #$0080
        bne _C393
        lda #$FFFF
        jsl rlUnknown85C4E0

        _C393
        lda $0788,b
        bit #$00FF
        beq _C3A4
        lda aProcSystem.aBody3,b,x
        ora #$0004
        sta aProcSystem.aBody3,b,x

        _C3A4
        jsl rlUnknown85C31A
        rtl

        .databank 0

        ; 85/C3A9

      rsUnknown85C3A9 ; 85/C3A9

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown85C41F
        jsr rsUnknown85C467
        lda aProcSystem.aBody3,b,x
        bit #$0004
        beq _C3C3
        and #$FFFB
        sta aProcSystem.aBody3,b,x
        lda #$C3C5
        jsr rsUnknown85C24D

        _C3C3
        clc
        rts

        .databank 0

        ; 85/C3C5

    .endsection Unsorted85C347Section


    .section Unsorted85C41FSection

      .al
      .xl

      rsUnknown85C41F ; 85/C41F

        .al
        .xl
        .autsiz
        .databank ?

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
        jsr rsUnknown85C1A4
        jsr rsUnknown85C0F5
        lda aProcSystem.aBody3,b,x
        ora #$0004
        sta aProcSystem.aBody3,b,x

        _C466
        rts

        .databank 0

        ; 85/C467

      rsUnknown85C467 ; 85/C467

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsr rsUnknown85C1FA
        lda aProcSystem.aBody0,b,x
        sta aProcSystem.wInput0,b
        jsr rsUnknown85C10B
        sta aProcSystem.wInput1,b
        jsr rsUnknown85C494
        lda #$0101
        jsr rsUnknown85C55B
        lda #$0101
        jsr rsUnknown85C58F
        lda #$00C8
        jsr rsUnknown85C5CB
        lda #$00C4
        jsr rsUnknown85C631
        plx
        rts

        .databank 0

        ; 85/C494

      rsUnknown85C494 ; 85/C494

        .al
        .xl
        .autsiz
        .databank ?

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
        jsl rlUnknown87EA09
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

      rsUnknown85C55B ; 85/C55B

        .al
        .xl
        .autsiz
        .databank ?

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
        jsl rlUnknown85C4E0

        _C58E
        rts

        .databank 0

        ; 85/C58F

      rsUnknown85C58F ; 85/C58F

        .al
        .xl
        .autsiz
        .databank ?

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
        jsl rlUnknown85C4E0

        _C5CA
        rts

        .databank 0

        ; 85/C5CB

      rsUnknown85C5CB ; 85/C5CB

        .al
        .xl
        .autsiz
        .databank ?

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
        sta $7FE3CA,x
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
        sta $7FE3CA,x

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
        lda $879077,x
        and #$00FF
        clc
        adc #$21DF
        plx
        sta $7FE3CA,x
        inc x
        inc x
        lda #$21DE
        sta $7FE3CA,x

        _C630
        rts

        .databank 0

        ; 85/C631

      rsUnknown85C631 ; 85/C631

        .al
        .xl
        .autsiz
        .databank ?

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
        sta $7FE3CA,x

        _C651
        rts

        .databank 0

        ; 85/C652

    .endsection Unsorted85C55BSection


    .section Unsorted85C65ASection

      .al
      .xl

      rlUnknown85C65A ; 85/C65A

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85C30D
        lda #$C7AE
        jsr rsUnknown85C12B
        lda #$FFFF
        sta aProcSystem.wInput0,b
        lda #$FFFF
        sta aProcSystem.wInput1,b
        jsr rsUnknown85C0F5
        lda #$0009
        sta aProcSystem.wInput0,b
        lda #$0005
        sta aProcSystem.wInput1,b
        jsr rsUnknown85C100
        jsr rsUnknown85C2F1
        rtl

        .databank 0

        ; 85/C686

      rlUnknown85C686 ; 85/C686

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown85C1A4
        bcs _C697
        jsr rsUnknown85C291
        lda aProcSystem.aBody3,b,x
        ora #$0080
        sta aProcSystem.aBody3,b,x

        _C697
        rtl

        .databank 0

        ; 85/C698

      rlUnknown85C698 ; 85/C698

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        pha
        jsr rsUnknown85C6D2
        lda #$0000
        sta aProcSystem.aBody7,b,x
        lda #<>rlUnknown85C6B0
        sta aProcSystem.aHeaderOnCycle,b,x
        pla
        sta wSelectedUnitDataRAMPointer,b
        rtl

        .databank 0

        ; 85/C6B0

      rlUnknown85C6B0 ; 85/C6B0

        .al
        .xl
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        pha
        jsr rsUnknown85C712
        jsr rsUnknown85C757
        jsr rsUnknown85C784
        jsl rlUnknown85C31A
        pla
        sta wSelectedUnitDataRAMPointer,b
        rtl

        .databank 0

        ; 85/C6C6

    .endsection Unsorted85C65ASection


    .section Unsorted85C6D2Section

      .al
      .xl

      rsUnknown85C6D2 ; 85/C6D2

        .al
        .xl
        .autsiz
        .databank ?

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
        jsr rsUnknown85C2FB
        bra _C711


        _C70E
        jsr rsUnknown85C2F1

        _C711
        rts

        .databank 0

        ; 85/C712

      rsUnknown85C712 ; 85/C712

        .al
        .xl
        .autsiz
        .databank ?

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
        jsr rsUnknown85C2F1
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

      rsUnknown85C757 ; 85/C757

        .al
        .xl
        .autsiz
        .databank ?

        lda $0788,b
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
        lda #$C6C6
        sta aProcSystem.aHeaderCodeOffset,b,x
        lda #$0001
        sta aProcSystem.aHeaderSleepTimer,b,x

        _C783
        rts

        .databank 0

        ; 85/C784

      rsUnknown85C784 ; 85/C784

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown85C12F
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

      rsUnknown85C7AE ; 85/C7AE

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown85C819
        jsr rsUnknown85C867
        lda #$C7BF
        jsr rsUnknown85C24D
        jsr rsUnknown85C9BF
        clc
        rts

        .databank 0

        ; 85/C7BF

    .endsection Unsorted85C6D2Section


    .section Unsorted85C819Section

      .al
      .xl

      rsUnknown85C819 ; 85/C819

        .al
        .xl
        .autsiz
        .databank ?

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
        jsr rsUnknown85C1A4
        jsr rsUnknown85C291

        _C862
        jsr rsUnknown85C0F5
        plx
        rts

        .databank 0

        ; 85/C867

      rsUnknown85C867 ; 85/C867

        .al
        .xl
        .autsiz
        .databank ?

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
        lda #$8500
        sta lR18+1
        lda #$C983
        sta lR18
        lda aProcSystem.wInput0,b
        clc
        adc #$0301
        tax
        jsl rlUnknown878F6E
        lda #$8500
        sta lR18+1
        lda #$C986
        sta lR18
        lda aProcSystem.wInput0,b
        clc
        adc #$0305
        tax
        jsl rlUnknown878F6E
        lda #$24E0
        sta aCurrentTilemapInfo,b
        jsl rlGetSelectedUnitCurrentHP
        pha
        lda aProcSystem.wInput0,b
        clc
        adc #$0303
        tax
        pla
        jsl rlUnknown878FE7
        jsl rlGetSelectedUnitMaxHP
        pha
        lda aProcSystem.wInput0,b
        clc
        adc #$0306
        tax
        pla
        jsl rlUnknown878FE7
        bra _C97E


        _C90E
        lda #$2500
        sta aCurrentTilemapInfo,b
        ldx aProcSystem.wInput1,b
        lda #$85C9
        sta lR18+1
        lda $C999,b,x
        sta lR18
        lda aProcSystem.wInput0,b
        clc
        adc #$0301
        tax
        jsl rlUnknown878F6E
        lda #$8500
        sta lR18+1
        lda #$C997
        sta lR18
        lda aProcSystem.wInput0,b
        clc
        adc #$0307
        tax
        jsl rlUnknown878F6E
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
        jsl rlUnknown878FE7
        pla
        cmp #$000A
        bcs _C97E
        lda #$2500
        sta aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$C997
        sta lR18
        lda aProcSystem.wInput0,b
        clc
        adc #$0305
        tax
        jsl rlUnknown878F6E

        _C97E
        jsr rsUnknown85C99F
        plx
        rts

        .databank 0

        ; 85/C983

    .endsection Unsorted85C819Section


    .section Unsorted85C99FSection

      .al
      .xl

      rsUnknown85C99F ; 85/C99F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlGetSelectedUnitFactionSlot
        tax
        lda #$0000
        jsl rlGetFactionRelation
        asl a
        tax
        lda $85C9B7,x
        sta $0108,b
        plx
        rts

        .databank 0

        ; 85/C9B7

    .endsection Unsorted85C99FSection


    .section Unsorted85C9BFSection

      .al
      .xl

      rsUnknown85C9BF ; 85/C9BF

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        jsr rsUnknown85C0E2
        jsr rsUnknown85C10B
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
        lda $CA0B,b,y
        clc
        adc aProcSystem.wInput2,b
        tax
        lda $CA0D,b,y
        sta $7FDD4A,x
        bra _CA08


        _C9F9
        lda $CA2B,b,y
        clc
        adc aProcSystem.wInput2,b
        tax
        lda $CA2D,b,y
        sta $7FDD4A,x

        _CA08
        ply
        plx
        rts

        .databank 0

        ; 85/CA0B

    .endsection Unsorted85C9BFSection


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

    .endsection Unsorted85CA4BSection


    .section ProcScript85CA85Section

      .al
      .xl

      procUnknown85CA85 ; 85/CA85

        .structProcInfo "OW", rlProcUnknown85CA85Init, rlProcUnknown85CA85Cycle1, aProcUnknown85CA85Code

    .endsection ProcScript85CA85Section


    .section Unsorted85CA91Section

      .al
      .xl

      rlProcUnknown85CA85Init ; 85/CA91

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85BC9E
        jsl rlUnknown85C0CE
        stz $0DB1,b
        lda aProcSystem.wInput0,b
        and #$00FF
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody5,b,x
        lda aProcSystem.wInput3,b
        sta $7FEB0A
        lda aProcSystem.wInput0+1,b
        and #$00FF
        clc
        adc aProcSystem.aBody7,b,x
        cmp aProcSystem.aBody5,b,x
        bmi _CAC4
        lda aProcSystem.aBody5,b,x

        _CAC4
        sep #$20
        sta $1058,b,x
        rep #$20
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody6,b,x
        jsl rlUnknown88B46A
        jsl rlUnknown85877E
        rtl

        .databank 0

        ; 85/CADA

      rlProcUnknown85CA85Cycle1 ; 85/CADA

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        jsl rlUnknown88A12B
        jsl rlUnknown888560
        plx
        plb
        .databank ?
        lda wUnknown0007D8,b
        bne _CAFA
        lda #<>rlUnknown85CAFB
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _CAFA
        rtl

        .databank 0

        ; 85/CAFB

    .endsection Unsorted85CA91Section


    .section Unsorted85CAFBSection

      .al
      .xl

      rlUnknown85CAFB ; 85/CAFB

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/CAFC

    .endsection Unsorted85CAFBSection


    .section Unsorted85CAFCSection

      .al
      .xl

      rlProcUnknown85CA85Cycle2 ; 85/CAFC

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFE
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$CB36
        sta aProcSystem.aHeaderOnCycle,b,x
        phx
        lda aProcSystem.aBody6,b,x
        tax
        lda aDeploymentTable._XTilePosition,x
        sta aProcSystem.wInput0,b
        lda aDeploymentTable._YTilePosition,x
        sta aProcSystem.wInput1,b
        plx
        lda $7FEB0A
        sta aProcSystem.wInput3,b
        lda #(`procUnknown9ECEDD)<<8
        sta lR44+1
        lda #<>procUnknown9ECEDD
        sta lR44
        jsl rlProcEngineCreateProc
        bra _CB50

        stx wR0
        lda #(`procUnknown9ECEDD)<<8
        sta lR44+1
        lda #<>procUnknown9ECEDD
        sta lR44
        jsl rlProcEngineFindProc
        bcs _CB50
        ldx wR0
        lda #<>rlUnknown85CB51
        sta aProcSystem.aHeaderOnCycle,b,x

        _CB50
        rtl

        .databank 0

        ; 85/CB51

    .endsection Unsorted85CAFCSection


    .section Unsorted85CB51Section

      .al
      .xl

      rlUnknown85CB51 ; 85/CB51

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown85D65A
        bcc _CB58
        rtl


        _CB58
        jsl rlUnknown85D5CC
        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsr rsUnknown85CCA8
        jsr rsUnknown85CCC9
        lda $0534,b
        and #$FF00
        asl a
        asl a
        asl a
        and #$FF00
        ora #$0018
        sta wR43
        lda #$000A
        sta wR42
        jsl rlUnknown859FCD
        plx
        phx
        lda aProcSystem.aBody7,b,x
        ldx #$05A0
        stx aCurrentTilemapInfo,b
        ldx #$0101
        jsl rlUnknown878900
        plx
        phx
        lda aProcSystem.aBody7,b,x
        ldy aProcSystem.aBody5,b,x
        ldx #$0980
        stx aCurrentTilemapInfo,b
        ldx #$0103
        jsl rlUnknown85D9FC
        plx
        lda #$CBBC
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlUnknown858751
        rtl

        .databank 0

        ; 85/CBBD

    .endsection Unsorted85CB51Section


    .section Unsorted85CBBDSection

      .al
      .xl

      rlProcUnknown85CA85Cycle3 ; 85/CBBD

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFE
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$CBCC
        sta aProcSystem.aHeaderOnCycle,b,x
        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda $1058,b,x
        and #$00FF
        cmp aProcSystem.aBody7,b,x
        bne _CBED
        lda #<>rlUnknown85CC3D
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        bra _CC3B


        _CBED
        sep #$20
        dec $0DB2,b
        bpl _CBFF
        lda #$0D
        jsl rlUnknown808FAD
        lda #$06
        sta $0DB2,b

        _CBFF
        dec $0DB1,b
        bpl _CC0E
        lda #$02
        sta $0DB1,b
        rep #$20
        inc aProcSystem.aBody7,b,x

        _CC0E
        rep #$20
        plx
        phx
        lda aProcSystem.aBody7,b,x
        ldx #$05A0
        stx aCurrentTilemapInfo,b
        ldx #$0101
        jsl rlUnknown878900
        plx
        phx
        lda aProcSystem.aBody7,b,x
        ldy aProcSystem.aBody5,b,x
        ldx #$0980
        stx aCurrentTilemapInfo,b
        ldx #$0103
        jsl rlUnknown85D9FC
        jsl rlUnknown8785E3

        _CC3B
        plx
        rtl

        .databank 0

        ; 85/CC3D

    .endsection Unsorted85CBBDSection


    .section Unsorted85CC3DSection

      .al
      .xl

      rlUnknown85CC3D ; 85/CC3D

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/CC3E

    .endsection Unsorted85CC3DSection


    .section Unsorted85CC3ESection

      .al
      .xl

      rlProcUnknown85CA85Cycle4 ; 85/CC3E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8586FA
        jsl rlUnknown85D648
        lda #<>rlUnknown85CC4D
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/CC4D

    .endsection Unsorted85CC3ESection


    .section Unsorted85CC4DSection

      .al
      .xl

      rlUnknown85CC4D ; 85/CC4D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown80B0EE
        bcs _CC61
        jsl rlFreeHDMAEntry0
        jsl rlProcEngineFreeProc
        lda #$FFFF
        sta $0DB1,b

        _CC61
        rtl

        .databank 0

        ; 85/CC62

    .endsection Unsorted85CC4DSection


    .section ProcScript85CC62Section

      .al
      .xl

      aProcUnknown85CA85Code ; 85/CC62

        PROC_YIELD 1
        _CC64
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CC64, $0001
        PROC_SET_UNK_TIMER 30
        _CC70
        PROC_YIELD 1
        PROC_JUMP_WHILE_UNK_TIMER _CC70
        PROC_SET_ONCYCLE rlProcUnknown85CA85Cycle2
        _CC7A
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CC7A, $0001
        PROC_SET_UNK_TIMER 40
        _CC86
        PROC_YIELD 1
        PROC_JUMP_WHILE_UNK_TIMER _CC86
        PROC_SET_ONCYCLE rlProcUnknown85CA85Cycle3
        _CC90
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _CC90, $0001
        PROC_SET_UNK_TIMER 60
        _CC9C
        PROC_YIELD 1
        PROC_JUMP_WHILE_UNK_TIMER _CC9C
        PROC_SET_ONCYCLE rlProcUnknown85CA85Cycle4
        PROC_HALT


        ; 85/CCA8

    .endsection ProcScript85CC62Section


    .section Unsorted85CCA8Section

      .al
      .xl

      rsUnknown85CCA8 ; 85/CCA8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aBody6,b,x
        tax
        lda aDeploymentTable._XTilePosition,x
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        sta wR11
        jsl rlUnknown88BF6C
        lda wR11
        xba
        and #$FF00
        ora wR10
        sta wR0
        plx
        rts

        .databank 0

        ; 85/CCC9

      rsUnknown85CCC9 ; 85/CCC9

        .al
        .xl
        .autsiz
        .databank ?

        lda wR0
        xba
        and #$00FF
        cmp #$0004
        bmi _CCDA
        sec
        sbc #$0003
        bra _CCDC


        _CCDA
        inc a
        inc a

        _CCDC
        xba
        sta wR4
        lda wR0
        and #$00FF
        cmp #$000F
        bmi _CCEF
        sec
        sbc #$000C
        bra _CCF1


        _CCEF
        inc a
        inc a

        _CCF1
        ora wR4
        sta $0534,b
        rts

        .databank 0

        ; 85/CCF7

    .endsection Unsorted85CCA8Section


    .section ProcScript85CD0CSection

      .al
      .xl

      procUnknown85CD0C ; 85/CD0C

        .structProcInfo "OB", rlUnknown85CD39, rlUnknown85CEC3, aProcUnknown85CD0CCode

    .endsection ProcScript85CD0CSection


    .section ProcScript85CD2DSection

      .al
      .xl

      procUnknown85CD2D ; 85/CD2D

        .structProcInfo "OB", rlUnknown85CD39, rlUnknown85CEC3, aProcUnknown85CD0CCode

    .endsection ProcScript85CD2DSection


    .section Unsorted85CD39Section

      .al
      .xl

      rlUnknown85CD39 ; 85/CD39

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb
        phy
        phx
        jsr rsUnknown85CD81
        jsl rlStallProcUntilMapMenuDataLoaded
        lda #$20FF
        sta wUnknown053C,b
        jsl rlUnknown8788E5
        lda #$0002
        sta wBufferBG3VOFS
        lda #$0000
        sta wBufferBG3HOFS
        lda aProcSystem.aBody5,b,x
        and #$FF1F
        jsl rlSetMapMenuPosition
        plx
        jsr rsUnknown85CE1E
        jsl rlUnknown8587E1
        jsl rlUnknown85A234
        ply
        plb
        .databank ?
        plp
        rtl

        .databank 0

        ; 85/CD72

    .endsection Unsorted85CD39Section


    .section Unsorted85CD81Section

      .al
      .xl

      rsUnknown85CD81 ; 85/CD81

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.wInput3,b
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody5,b,x
        bit #$0080
        beq _CD9B
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _CD9B
        rts

        .databank 0

        ; 85/CD9C

      rsUnknown85CD9C ; 85/CD9C

        .al
        .xl
        .autsiz
        .databank ?

        phb
        ldy aProcSystem.aBody7,b,x
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        ldy aProcSystem.aBody7,b,x
        lda $0010,b,y
        sta aProcSystem.aBody5,b,x
        lda $0012,b,y
        sta aProcSystem.aBody6,b,x
        plb
        .databank $7E
        rts

        .databank 0

        ; 85/CDB9

      rsUnknown85CDB9 ; 85/CDB9

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aBody5,b,x
        ldy aProcSystem.aBody6,b,x
        ldx #$0980
        stx aCurrentTilemapInfo,b
        ldx #$0203
        jsl rlUnknown85D9FC
        plx
        phx
        ldy aProcSystem.aBody7,b,x
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $0006,b,y
        sta wSelectedUnitDataRAMPointer,b
        ldx #$0002
        jsl rlUnknown85864B
        plx
        lda #$01A0
        jsr rsUnknown85CE08
        sta aCurrentTilemapInfo,b
        phx
        lda aProcSystem.aBody5,b,x
        ldx #$0201
        jsl rlUnknown878900
        plx
        jsl rlUnknown85A234
        rts

        .databank 0

        ; 85/CE08

      rsUnknown85CE08 ; 85/CE08

        .al
        .xl
        .autsiz
        .databank ?

        sta wR0
        jsl rlGetMapMenuType
        cmp #$0004
        beq _CE18
        lda #$0400
        bra _CE1B


        _CE18
        lda #$0C00

        _CE1B
        ora wR0
        rts

        .databank 0

        ; 85/CE1E

      rsUnknown85CE1E ; 85/CE1E

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0001
        bne _CE2B
        ldy #$0000
        bra _CE2E


        _CE2B
        ldy #$0001

        _CE2E
        tya
        jsl rlUnknown859FEA
        rts

        .databank 0

        ; 85/CE34

      rsUnknown85CE34 ; 85/CE34

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0001
        bne _CE41
        ldy #$0000
        bra _CE44


        _CE41
        ldy #$0001

        _CE44
        lda #$040C
        pha
        tya
        xba
        ora #$0008
        tay
        pla
        jsl rlUnknown85A041
        rts

        .databank 0

        ; 85/CE54

    .endsection Unsorted85CD81Section


    .section Unsorted85CE54Section

      .al
      .xl

      rsUnknown85CE54 ; 85/CE54

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0001
        bne _CE65
        ldy #$0004
        bra _CE68


        _CE65
        ldy #$0003

        _CE68
        tya
        jsl rlUnknown859FEA
        lda #$20FF
        sta wUnknown053C,b
        jsl rlUnknown8788E5
        jsl rlUnknown8785E3
        rts

        .databank 0

        ; 85/CE7C

    .endsection Unsorted85CE54Section


    .section Unsorted85CE7CSection

      .al
      .xl

      rsUnknown85CE7C ; 85/CE7C

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0001
        bne _CE89
        ldy #$0004
        bra _CE8C


        _CE89
        ldy #$0003

        _CE8C
        lda #$040C
        pha
        tya
        xba
        ora #$0005
        tay
        pla
        jsl rlUnknown85A041
        rts

        .databank 0

        ; 85/CE9C

      rsUnknown85CE9C ; 85/CE9C

        .al
        .xl
        .autsiz
        .databank ?

        pha
        jsl rlGetMapMenuType
        cmp #$0004
        beq _CEAC
        pla
        sta $0DB1,b
        bra _CEB0


        _CEAC
        pla
        sta $0DAF,b

        _CEB0
        rts

        .databank 0

        ; 85/CEB1

      rsUnknown85CEB1 ; 85/CEB1

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetMapMenuType
        cmp #$0004
        beq _CEBF
        lda $0DB1,b
        bra _CEC2


        _CEBF
        lda $0DAF,b

        _CEC2
        rts

        .databank 0

        ; 85/CEC3

    .endsection Unsorted85CE7CSection


    .section Unsorted85CEC3Section

      .al
      .xl

      rlUnknown85CEC3 ; 85/CEC3

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlUnknown8587E1
        jsr rsUnknown85CE34
        bcs _CED1
        rtl


        _CED1
        jsr rsUnknown85CD9C
        jsr rsUnknown85CDB9
        jsl rlUnknown8785E3
        lda #<>rlUnknown85CEE2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/CEE2

    .endsection Unsorted85CEC3Section


    .section Unsorted85CEE2Section

      .al
      .xl

      rlUnknown85CEE2 ; 85/CEE2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsr rsUnknown85CEB1
        bit #$4000
        bne _CF11
        bit #$0800
        bne _CF00
        bit #$1000
        bne _CF37
        bit #$0100
        bne _CF44

        _CEFE
        plx
        rtl


        _CF00
        and #$00FF
        clc
        adc aProcSystem.aBody5,b,x
        cmp aProcSystem.aBody6,b,x
        bmi _CF24
        lda aProcSystem.aBody6,b,x
        bra _CF24


        _CF11
        and #$00FF
        sta wR0
        lda aProcSystem.aBody5,b,x
        sec
        sbc wR0
        ora #$0000
        bpl _CF24
        lda #$0000

        _CF24
        sta aProcSystem.aBody4,b,x
        lda #$2000
        jsr rsUnknown85CE9C
        lda #<>rlUnknown85CFC0
        sta aProcSystem.aHeaderOnCycle,b,x
        jml _CEFE


        _CF37
        lda #<>rlUnknown85D047
        sta aProcSystem.aHeaderOnCycle,b,x
        jsr rsUnknown85CE54
        jml _CEFE


        _CF44
        lda aProcSystem.aBody6,b,x
        bit #$0080
        bne _CFA3
        phb
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        lda aProcSystem.aBody7,b,x
        tay
        lda $0018,b,y
        sta aProcSystem.wInput1,b
        lda $001A,b,y
        sta aProcSystem.wInput3,b
        plb
        .databank $7E
        lda aProcSystem.wInput3,b
        beq _CFB3
        lda #$0080
        sta aProcSystem.aBody6,b,x
        jsl rlGetMapMenuPosition
        xba
        and #$00FF
        cmp #$0002
        bmi _CF81
        dec a
        bra _CF85


        _CF81
        clc
        adc #$0002

        _CF85
        sta aProcSystem.wInput2,b
        lda #$0001
        sta aProcSystem.wInput0,b
        lda #(`procUnknown85D8AA)<<8
        sta lR44+1
        lda #<>procUnknown85D8AA
        sta lR44
        lda #$0001
        jsl rlProcEngineCreateProcByIndex
        jml _CEFE


        _CFA3
        lda #(`procUnknown85D8AA)<<8
        sta lR44+1
        lda #<>procUnknown85D8AA
        sta lR44
        jsl rlProcEngineFindProc
        bcs _CFBC

        _CFB3
        lda #$0000
        sta aProcSystem.aBody6,b,x
        jsr rsUnknown85CE9C

        _CFBC
        jml _CEFE

        .databank 0

        ; 85/CFC0

      rlUnknown85CFC0 ; 85/CFC0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody4,b,x
        cmp aProcSystem.aBody5,b,x
        beq _D033
        bpl _CFDA
        lda #$1D80
        sta aCurrentTilemapInfo,b
        dec aProcSystem.aBody5,b,x
        bra _D009


        _CFDA
        lda #$0980
        sta aCurrentTilemapInfo,b
        inc aProcSystem.aBody5,b,x
        jsr rsUnknown85CEB1
        pha
        and #$FF00
        sta wR0
        pla
        and #$00FF
        dec a
        bmi _CFFA
        ora wR0
        jsr rsUnknown85CE9C
        bra _D009


        _CFFA
        lda #$0006
        ora wR0
        jsr rsUnknown85CE9C
        lda #$000D
        jsl rlUnknown808FAD

        _D009
        phx
        lda aProcSystem.aBody5,b,x
        ldy aProcSystem.aBody6,b,x
        ldx #$0203
        jsl rlUnknown85D9FC
        plx
        phx
        lda #$01A0
        jsr rsUnknown85CE08
        sta aCurrentTilemapInfo,b
        lda aProcSystem.aBody5,b,x
        ldx #$0201
        jsl rlUnknown878900
        plx
        jsl rlUnknown8785E3
        plx
        rtl


        _D033
        lda #$8000
        jsr rsUnknown85CE9C
        lda #<>rlUnknown85CEE2
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0980
        sta aCurrentTilemapInfo,b
        bra _D009

        .databank 0

        ; 85/D047

      rlUnknown85D047 ; 85/D047

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsr rsUnknown85CE7C
        bcs _D055
        jsl rlUnknown85884A
        rtl


        _D055
        lda #$0000
        jsr rsUnknown85CE9C
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

        ; 85/D064

    .endsection Unsorted85CEE2Section


    .section ProcScript85D064Section

      .al
      .xl

      aProcUnknown85CD0CCode ; 85/D064

        PROC_HALT


        ; 85/D066

    .endsection ProcScript85D064Section


    .section Unsorted85D066Section

      .al
      .xl

      rlUnknown85D066 ; 85/D066

        .al
        .xl
        .autsiz
        .databank ?

        stz $0DB1,b
        stz $0DAF,b
        phb
        phy
        phx
        jsl rlUnknown85D0B9
        lda $7F508F
        bit #$0001
        bne _D081
        jsr rsUnknown85D1E6
        bra _D084


        _D081
        jsr rsUnknown85D29F

        _D084
        jsr rsUnknown85D17E
        jsr rsUnknown85D1B2
        lda wR1
        and #$FF00
        asl a
        asl a
        asl a
        sec
        sbc #$0010
        tay
        xba
        and #$00FF
        cmp #$0000
        bpl _D0A3
        ldy #$0000

        _D0A3
        tya
        and #$FF00
        ora #$0030
        sta wR43
        lda #$0014
        sta wR42
        jsl rlUnknown859FCD
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/D0B9

      rlUnknown85D0B9 ; 85/D0B9

        .al
        .xl
        .autsiz
        .databank ?

        lda aActionStructUnit1.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleHUDColorID
        sta wR0
        lda #$0000
        ldy wR0
        jsl rlUnknown85D676
        lda #$0000
        ldy wR0
        jsl rlUnknown85D766
        lda aActionStructUnit2.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleHUDColorID
        sta wR0
        lda #$0001
        ldy wR0
        jsl rlUnknown85D676
        lda #$0001
        ldy wR0
        jsl rlUnknown85D766
        rtl

        .databank 0

        ; 85/D100

    .endsection Unsorted85D066Section


    .section Unsorted85D100Section

      .al
      .xl

      rlUnknown85D100 ; 85/D100

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        stz $0DB1,b
        phb
        phy
        phx
        jsl rlUnknown85D0B9
        jsr rsUnknown85D1E6
        jsr rsUnknown85D17E
        lda wR0
        and #$FF00
        asl a
        asl a
        asl a
        sec
        sbc #$0010
        tay
        xba
        and #$00FF
        cmp #$0000
        bpl _D129
        ldy #$0000

        _D129
        tya
        and #$FF00
        ora #$0030
        sta wR43
        lda #$0014
        sta wR42
        jsl rlUnknown859FCD
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/D13F

      rlUnknown85D13F ; 85/D13F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        stz $0DAF,b
        phb
        phy
        phx
        jsl rlUnknown85D0B9
        jsr rsUnknown85D1E6
        jsr rsUnknown85D17E
        lda wR1
        and #$FF00
        asl a
        asl a
        asl a
        sec
        sbc #$0010
        tay
        xba
        and #$00FF
        cmp #$0000
        bpl _D168
        ldy #$0000

        _D168
        tya
        and #$FF00
        ora #$0030
        sta wR43
        lda #$0014
        sta wR42
        jsl rlUnknown859FCD
        plx
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/D17E

    .endsection Unsorted85D100Section


    .section Unsorted85D17ESection

      .al
      .xl

      rsUnknown85D17E ; 85/D17E

        .al
        .xl
        .autsiz
        .databank ?

        lda wR1
        pha
        lda wR0
        pha
        lda #(`procUnknown85CD0C)<<8
        sta lR44+1
        lda #<>procUnknown85CD0C
        sta lR44
        lda $7E4EC7
        sta aProcSystem.wInput0,b
        lda aChildAverageLevelStats
        sta aProcSystem.wInput1,b
        lda #$4EB5
        sta aProcSystem.wInput3,b
        lda wR0
        sta aProcSystem.wInput2,b
        jsl rlProcEngineCreateProc
        pla
        sta wR0
        pla
        sta wR1
        rts

        .databank 0

        ; 85/D1B2

      rsUnknown85D1B2 ; 85/D1B2

        .al
        .xl
        .autsiz
        .databank ?

        lda wR0
        pha
        lda wR1
        pha
        lda #(`procUnknown85CD2D)<<8
        sta lR44+1
        lda #<>procUnknown85CD2D
        sta lR44
        lda aActionStructUnit2.MaxHP
        sta aProcSystem.wInput0,b
        lda aActionStructUnit2.CurrentHP
        sta aProcSystem.wInput1,b
        lda #$4F15
        sta aProcSystem.wInput3,b
        lda wR1
        sta aProcSystem.wInput2,b
        jsl rlProcEngineCreateProc
        pla
        sta wR1
        pla
        sta wR0
        rts

        .databank 0

        ; 85/D1E6

      rsUnknown85D1E6 ; 85/D1E6

        .al
        .xl
        .autsiz
        .databank ?

        lda aActionStructUnit2.XPosition
        sta wR2
        sta wR10
        lda aActionStructUnit1.XPosition
        sta wR12
        cmp wR2
        bpl _D204
        lda #$0004
        sta wR0
        lda #$0090
        sta wR1
        bra _D20E


        _D204
        lda #$0090
        sta wR0
        lda #$0004
        sta wR1

        _D20E
        lda aActionStructUnit2.YPosition
        sta wR11
        jsl rlUnknown88BF6C
        lda wR11
        sta wR2
        lda aActionStructUnit1.YPosition
        sta wR11
        lda wR12
        sta wR10
        jsl rlUnknown88BF6C
        lda wR11
        sta wR5
        cmp wR2
        bmi _D23C
        lda wR5
        sta wR4
        lda wR2
        sta wR3
        bra _D244


        _D23C
        lda wR2
        sta wR4
        lda wR5
        sta wR3

        _D244
        inc wR4
        stz wR6
        lda wR3
        sta wR2
        cmp #$0007
        bmi _D256
        lda #$0001
        tsb wR6

        _D256
        lda #$001B
        sec
        sbc wR4
        sta wR5
        cmp #$0006
        bmi _D268
        lda #$0002
        tsb wR6

        _D268
        lda wR6
        cmp #$0003
        beq _D27E
        bit #$0001
        bne _D286
        bit #$0002
        bne _D290
        lda #$0010
        bra _D296


        _D27E
        lda wR2
        cmp wR5
        bpl _D286
        bra _D290


        _D286
        lda wR3
        sec
        sbc #$0004
        dec a
        dec a
        bra _D296


        _D290
        lda wR4
        inc a
        inc a
        bra _D296


        _D296
        xba
        and #$FF00
        tsb wR0
        tsb wR1
        rts

        .databank 0

        ; 85/D29F

      rsUnknown85D29F ; 85/D29F

        .al
        .xl
        .autsiz
        .databank ?

        lda aActionStructUnit2.XPosition
        sta wR2
        lda aActionStructUnit1.XPosition
        cmp wR2
        bpl _D2B9
        lda #$0004
        sta wR0
        lda #$0090
        sta wR1
        bra _D2C3


        _D2B9
        lda #$0090
        sta wR0
        lda #$0004
        sta wR1

        _D2C3
        lda $7F5090
        and #$0003
        beq _D2F5
        cmp #$0001
        beq _D2E3
        lda wR0
        clc
        adc #$0002
        sta wR0
        lda wR1
        clc
        adc #$0002
        sta wR1
        bra _D2F5


        _D2E3
        lda wR0
        sec
        sbc #$0003
        sta wR0
        lda wR1
        sec
        sbc #$0003
        sta wR1
        bra _D2F5


        _D2F5
        lda $7F5090
        bit #$0004
        bne _D307
        lda #$0100
        tsb wR0
        tsb wR1
        bra _D30E


        _D307
        lda #$1600
        tsb wR0
        tsb wR1

        _D30E
        rts

        .databank 0

        ; 85/D30F

      rlUnknown85D30F ; 85/D30F

        .al
        .xl
        .autsiz
        .databank ?

        and #$00FF
        ora #$4000
        sta $0DB1,b
        rtl

        .databank 0

        ; 85/D319

      rlUnknown85D319 ; 85/D319

        .al
        .xl
        .autsiz
        .databank ?

        and #$00FF
        ora #$4000
        sta $0DAF,b
        rtl

        .databank 0

        ; 85/D323

      rlUnknown85D323 ; 85/D323

        .al
        .xl
        .autsiz
        .databank ?

        and #$00FF
        ora #$0800
        sta $0DB1,b
        rtl

        .databank 0

        ; 85/D32D

      rlUnknown85D32D ; 85/D32D

        .al
        .xl
        .autsiz
        .databank ?

        and #$00FF
        ora #$0800
        sta $0DAF,b
        rtl

        .databank 0

        ; 85/D337

    .endsection Unsorted85D17ESection


    .section Unsorted85D385Section

      .al
      .xl

      rlUnknown85D385 ; 85/D385

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta aProcSystem.wInput0,b
        lda #$000D
        sta aProcSystem.wInput2,b
        pha
        lda #(`procUnknown85D8AA)<<8
        sta lR44+1
        lda #<>procUnknown85D8AA
        sta lR44
        lda #$0001
        jsl rlProcEngineCreateProcByIndex
        pla
        xba
        and #$FF00
        asl a
        asl a
        asl a
        and #$FF00
        ora #$0020
        sta wR43
        lda #$000E
        sta wR42
        jsl rlUnknown859FCD
        rtl

        .databank 0

        ; 85/D3BD

    .endsection Unsorted85D385Section


    .section Unsorted85D3F5Section

      .al
      .xl

      rlUnknown85D3F5 ; 85/D3F5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`procUnknown85D8AA)<<8
        sta lR44+1
        lda #<>procUnknown85D8AA
        sta lR44
        jsl rlProcEngineFindProc
        bcc _D40B
        plx
        lda #$FFFF
        rtl


        _D40B
        plx
        jsl rlFreeHDMAEntry0
        lda #$0000
        rtl

        .databank 0

        ; 85/D414

      rlUnknown85D414 ; 85/D414

        .al
        .xl
        .autsiz
        .databank ?

        lda #$1000
        sta $0DB1,b
        sta $0DAF,b
        rtl

        .databank 0

        ; 85/D41E

      rlUnknown85D41E ; 85/D41E

        .al
        .xl
        .autsiz
        .databank ?

        lda $0DB1,b
        beq _D425
        bra _D434


        _D425
        lda $0DAF,b
        beq _D42C
        bra _D434


        _D42C
        jsl rlFreeHDMAEntry0
        lda #$0000
        rtl


        _D434
        lda #$FFFF
        rtl

        .databank 0

        ; 85/D438

    .endsection Unsorted85D3F5Section


    .section Unsorted85D442Section

      .al
      .xl

      rlUnknown85D442 ; 85/D442

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        stx wR7
        sta wR2
        sty wR3
        lda wR3
        cmp #$0026
        bpl _D45D
        lda wR2
        sta wR4
        sta wR6
        lda wR3
        sta wR5
        jsr rsUnknown85D4B2
        rtl


        _D45D
        lda wR2
        cmp #$0026
        bpl _D489
        lda wR2
        sta wR4
        sta wR6
        lda #$0026
        sta wR5
        jsr rsUnknown85D4B2
        lda wR7
        sec
        sbc #$0100
        tax
        stz wR4
        stz wR6
        lda wR3
        sec
        sbc #$0026
        sta wR5
        jsr rsUnknown85D4B2
        rtl


        _D489
        lda #$0026
        sta wR4
        sta wR6
        sta wR5
        jsr rsUnknown85D4B2
        lda wR7
        sec
        sbc #$0100
        tax
        lda wR2
        sec
        sbc #$0026
        sta wR4
        sta wR6
        lda wR3
        sec
        sbc #$0026
        sta wR5
        jsr rsUnknown85D4B2
        rtl

        .databank 0

        ; 85/D4B2

    .endsection Unsorted85D442Section


    .section Unsorted85D4B2Section

      .al
      .xl

      rsUnknown85D4B2 ; 85/D4B2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wR4
        sec
        sbc #$0004
        sta wR0
        bpl _D4C0
        jml _D4DF


        _D4C0
        phy
        pha
        phx
        ldy #$0004
        lda #$0004
        jsr rsUnknown85D5AA
        plx
        jsr rsUnknown85D5C3
        jsl rlUnknown85D81F
        pla
        ply
        lda wR0
        sta wR4
        inc x
        jml rsUnknown85D4B2


        _D4DF
        lda wR5
        sec
        sbc wR6
        sta wR1
        clc
        adc wR4
        cmp #$0005
        bpl _D505
        tay
        phy
        pha
        phx
        lda wR4
        jsr rsUnknown85D5AA
        plx
        jsr rsUnknown85D5C3
        jsl rlUnknown85D81F
        pla
        ply
        jml _D572


        _D505
        phy
        pha
        phx
        ldy #$0004
        lda wR4
        jsr rsUnknown85D5AA
        plx
        jsr rsUnknown85D5C3
        jsl rlUnknown85D81F
        pla
        ply
        inc x
        lda #$0004
        sec
        sbc wR4
        sta wR0
        lda wR5
        sec
        sbc wR6
        sec
        sbc wR0
        sta wR5
        jml _D531


        _D531
        lda wR5
        sec
        sbc #$0004
        bmi _D556
        phy
        pha
        phx
        ldy #$0004
        lda #$0000
        jsr rsUnknown85D5AA
        plx
        jsr rsUnknown85D5C3
        jsl rlUnknown85D81F
        pla
        ply
        sta wR5
        inc x
        jml _D531


        _D556
        nop
        nop
        nop
        phy
        pha
        phx
        ldy wR5
        lda #$0000
        jsr rsUnknown85D5AA
        plx
        jsr rsUnknown85D5C3
        jsl rlUnknown85D81F
        pla
        ply
        nop
        nop
        nop
        rts


        _D572
        tya
        cmp #$0004
        beq _D579
        rts


        _D579
        inc x
        phy
        pha
        phx
        ldy #$0000
        lda #$0000
        jsr rsUnknown85D5AA
        plx
        jsr rsUnknown85D5C3
        jsl rlUnknown85D81F
        pla
        ply
        rts

        .databank 0

        ; 85/D591

    .endsection Unsorted85D4B2Section


    .section Table85D591Section

      .al
      .xl

      aUnknown85D591 ; 85/D591

        ; Read by rsUnknown85D5AA.

        .byte $1E, $1E, $1E, $1E, $1E, $1C, $1D, $1D, $1D, $1D, $19, $1A, $1B, $1B, $1B, $15
        .byte $16, $17, $18, $18, $10, $11, $12, $13, $14

        ; 85/D5AA

    .endsection Table85D591Section


    .section Unsorted85D5AASection

      .al
      .xl

      rsUnknown85D5AA ; 85/D5AA

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #$0005
        sta wR10
        sty wR11
        jsl rlUnsignedMultiply16By16
        pla
        clc
        adc wR12
        tax
        lda aUnknown85D591,x
        and #$00FF
        rts

        .databank 0

        ; 85/D5C3

      rsUnknown85D5C3 ; 85/D5C3

        .al
        .xl
        .autsiz
        .databank ?

        cpx wR7
        bpl _D5CB
        sec
        sbc #$0010

        _D5CB
        rts

        .databank 0

        ; 85/D5CC

    .endsection Unsorted85D5AASection


    .section Unsorted85D5CCSection

      .al
      .xl

      rlUnknown85D5CC ; 85/D5CC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$001C

        _D5D0
        lda @l $000102,x
        sta $7FD14C,x
        dec x
        dec x
        bpl _D5D0
        ldx #$001C

        _D5DF
        lda aUnknown85D606,x
        sta @l $000102,x
        dec x
        dec x
        bpl _D5DF
        ldx #$000E

        _D5EE
        lda aUnknown85D626,x
        sta @l $0001C2,x
        lda aUnknown85D638,x
        sta @l $0001E2,x
        dec x
        dec x
        bpl _D5EE
        plx
        rtl

        .databank 0

        ; 85/D604

    .endsection Unsorted85D5CCSection


    .section Table85D606Section

      .al
      .xl

      aUnknown85D606 ; 85/D606

        ; Read by rlUnknown85D5CC.

        .word $318B, $7FFF, $1484, $7FFF, $318B, $10E7, $5F7B, $7FFF
        .word $4F00, $1CA2, $77FF, $7FFF, $1D64, $0CA0, $4ACE, $0001

        ; 85/D626

    .endsection Table85D606Section


    .section Table85D626Section

      .al
      .xl

      aUnknown85D626 ; 85/D626

        ; Read by rlUnknown85D5CC.

        .word $03FF, $6B7B, $635A, $5AF7, $4ED7, $3E75, $08C8, $0000
        .word $4001

        ; 85/D638

    .endsection Table85D626Section


    .section Table85D638Section

      .al
      .xl

      aUnknown85D638 ; 85/D638

        ; Read by rlUnknown85D5CC.

        .word $039C, $5310, $4ACE, $46AD, $428C, $3A4A, $04A7, $0000

        ; 85/D648

    .endsection Table85D638Section


    .section Unsorted85D648Section

      .al
      .xl

      rlUnknown85D648 ; 85/D648

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$001C

        _D64C
        lda $7FD14C,x
        sta @l $000102,x
        dec x
        dec x
        bpl _D64C
        plx
        rtl

        .databank 0

        ; 85/D65A

      rlUnknown85D65A ; 85/D65A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8500
        sta lR19+1
        lda #$D669
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        rtl

        .databank 0

        ; 85/D669

    .endsection Unsorted85D648Section


    .section Unsorted85D671Section

      .al
      .xl

      rlUnknown85D671 ; 85/D671

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown80B0EE
        rtl

        .databank 0

        ; 85/D676

    .endsection Unsorted85D671Section


    .section Unsorted85D676Section

      .al
      .xl

      rlUnknown85D676 ; 85/D676

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
        pha
        tya
        asl a
        tax
        lda @l aUnknown85D6B2,x
        clc
        adc #$0010
        tay
        pla
        cmp #$0001
        beq _D694
        ldx #$00CE
        bra _D697


        _D694
        ldx #$00EE

        _D697
        lda #$0007
        sta wR1

        _D69C
        lda $0000,b,y
        sta @l $000102,x
        dec x
        dec x
        dec y
        dec y
        dec wR1
        lda wR1
        bpl _D69C
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/D6B2

    .endsection Unsorted85D676Section


    .section Table85D6B2Section

      .al
      .xl

      aUnknown85D6B2 ; 85/D6B2

        ; Read by rlUnknown85D676.

        .word $D6C4, $D6D6, $D6E8, $D6FA, $D70C, $D71E, $D730, $D742
        .word $D754, $5ED5, $039C, $39D2, $3190, $2D6F, $294E, $252D
        .word $1CC9, $0000, $3000, $039C, $420F, $3DEE, $39CD, $35AC
        .word $318B, $0C42, $0000, $3000, $039C, $5310, $4ACE, $46AD
        .word $428C, $3A4A, $04A7, $0000, $3000, $039C, $4DAF, $498E
        .word $456D, $414C, $3D2B, $0866, $0000, $3000, $03FF, $6B7B
        .word $635A, $5AF7, $4ED7, $3E75, $08C8, $0000, $4001, $03FF
        .word $21AF, $1D8E, $196D, $154C, $152B, $04A7, $0000, $0001
        .word $039C, $76D3, $72B2, $6E91, $6A70, $664F, $04A7, $0000
        .word $4001, $03FF, $19D4, $15B3, $1192, $0D71, $0950, $04A7
        .word $0000, $3800, $039C, $658C, $616B, $5D4A, $5929, $5909
        .word $0445, $0000

        ; 85/D766

    .endsection Table85D6B2Section


    .section Unsorted85D766Section

      .al
      .xl

      rlUnknown85D766 ; 85/D766

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
        pha
        tya
        asl a
        tax
        lda @l aUnknown85D7A0,x
        clc
        adc #$0006
        tay
        pla
        cmp #$0001
        beq _D783
        ldx #$000C
        bra _D786


        _D783
        ldx #$001C

        _D786
        lda #$0002
        sta wR1

        _D78B
        lda $0000,b,y
        sta @l $000102,x
        dec x
        dec x
        dec y
        dec y
        dec wR1
        lda wR1
        bpl _D78B
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/D7A0

    .endsection Unsorted85D766Section


    .section Table85D7A0Section

      .al
      .xl

      aUnknown85D7A0 ; 85/D7A0

        ; Read by rlUnknown85D766.

        .word $D7B2, $D7BA, $D7C2, $D7CA, $D7D2, $D7DA, $D7E2, $D7EA
        .word $D7F2, $0000, $18A8, $0003, $39D2, $0000, $1CE6, $0000
        .word $420F, $0000, $1D64, $0880, $4ACE, $0000, $2CA7, $0401
        .word $498E, $10A6, $318B, $10E7, $5F7B, $0000, $04A7, $0021
        .word $21AF, $0000, $2106, $0C42, $5A71, $0000, $0068, $0021
        .word $1DF5, $65AB, $3863, $0400, $61AD

        ; 85/D7FA

    .endsection Table85D7A0Section


    .section Unsorted85D7FASection

      .al
      .xl

      rlUnknown85D7FA ; 85/D7FA

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        txy
        ldx lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?

        _D809
        lda $0000,b,x
        and #$00FF
        beq _D81C
        phx
        tyx
        jsl rlUnknown85D81F
        plx
        inc x
        inc y
        bra _D809


        _D81C
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 85/D81F

      rlUnknown85D81F ; 85/D81F

        .al
        .xl
        .autsiz
        .databank ?

        pha
        jsl rlGetMapMenuTilemapRAMEntryPointer
        pla
        jsl rlUnknown85D82A
        rtl

        .databank 0

        ; 85/D82A

      rlUnknown85D82A ; 85/D82A

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
        ldy wR0
        phy
        and #$00FF
        cmp #$0080
        bcs _D88B
        pha
        ldy lMapMenuTilemapRAMEntryPointer,b
        sep #$20
        lda lMapMenuTilemapRAMEntryPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structMapMenuTilemapData.TilesPointer,b,y
        sta lR23
        lda structMapMenuTilemapData.TilesPointer+1,b,y
        sta lR23+1
        stz wR0
        txa
        sep #$20
        sta wR0
        xba
        sta @l WRMPYA
        lda structMapMenuTilemapData.Width,b,y
        sta @l WRMPYB
        nop
        nop
        nop
        rep #$20
        lda @l RDMPY
        clc
        adc wR0
        asl a
        clc
        adc lR23
        sta lR23
        pla
        clc
        adc @l aCurrentTilemapInfo
        ora #$2000
        sta [lR23]
        pla
        sta wR0
        ply
        plx
        plp
        plb
        .databank ?
        clc

        _D88A
        rtl


        _D88B
        plx
        stx wR0
        ply
        plx
        plp
        plb
        .databank ?
        sec
        bra _D88A

        .databank 0

        ; 85/D895

    .endsection Unsorted85D7FASection


    .section ProcScript85D8AASection

      .al
      .xl

      procUnknown85D8AA ; 85/D8AA

        .structProcInfo "OW", rlProcUnknown85D8AAInit, rlProcUnknown85D8AACycle, aProcUnknown85D8AACode

    .endsection ProcScript85D8AASection


    .section Unsorted85D8B6Section

      .al
      .xl

      rlProcUnknown85D8AAInit ; 85/D8B6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlStallProcUntilMapMenuDataLoaded
        lda #$20FF
        sta wUnknown053C,b
        jsl rlUnknown8788E5
        lda #$0000
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        lda aProcSystem.wInput2,b
        sta wR6
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput3,b
        sta aProcSystem.aBody6,b,x
        lda wR6
        xba
        ora #$0005
        jsl rlSetMapMenuPosition
        lda aProcSystem.wInput0,b
        bne _D8F3
        lda #$0006
        jsl rlUnknown87872B

        _D8F3
        lda wR6
        asl a
        asl a
        asl a
        sta wR43
        lda #$0001
        sta wR40
        lda #$8500
        sta lR44+1
        lda #$AB82
        sta lR44
        jsl rlHDMAEngineCreateEntryByIndex
        plx
        rtl

        .databank 0

        ; 85/D90F

      rlProcUnknown85D8AACycle ; 85/D90F

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
        jsl rlLoadMapMenuEntryPointerFromProcBody
        plx
        phx
        ldx #$0580
        stx aCurrentTilemapInfo,b
        lda #$8500
        sta lR18+1
        lda #$D96D
        sta lR18
        ldx #$0101
        jsl rlUnknown85D7FA
        plx
        phx
        lda aProcSystem.aBody7,b,x
        ldx #$05A0
        stx aCurrentTilemapInfo,b
        ldx #$0105
        jsl rlUnknown878900
        plx
        phx
        lda aProcSystem.aBody7,b,x
        ldx #$0980
        stx aCurrentTilemapInfo,b
        ldx #$0107
        jsl rlUnknown85DA2A
        plx
        jsl rlUnknown85A234
        jsl rlUnknown8587E1
        plp
        plb
        .databank ?
        lda #$001E
        sta aProcSystem.aBody5,b,x
        lda #<>rlUnknown85D971
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/D96D

    .endsection Unsorted85D8B6Section


    .section Unsorted85D971Section

      .al
      .xl

      rlUnknown85D971 ; 85/D971

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody5,b,x
        bmi _D977
        rtl


        _D977
        lda #$000B
        jsl rlUnknown808FAD
        lda #<>rlUnknown85D985
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/D985

      rlUnknown85D985 ; 85/D985

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda aProcSystem.aBody6,b,x
        beq _D9C9
        dec aProcSystem.aBody6,b,x
        inc aProcSystem.aBody7,b,x
        lda aProcSystem.aBody7,b,x
        cmp #$0064
        bpl _D99E
        bra _D9A1


        _D99E
        stz aProcSystem.aBody7,b,x

        _D9A1
        phx
        lda aProcSystem.aBody7,b,x
        ldx #$05A0
        stx aCurrentTilemapInfo,b
        ldx #$0105
        jsl rlUnknown878900
        plx
        lda aProcSystem.aBody7,b,x
        ldx #$0980
        stx aCurrentTilemapInfo,b
        ldx #$0107
        jsl rlUnknown85DA2A
        jsl rlUnknown8785E3
        bra _D9DE


        _D9C9
        lda #$000C
        jsl rlUnknown808FAD
        lda #$0032
        sta aProcSystem.aBody5,b,x
        lda #<>rlUnknown85D9DF
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _D9DE


        _D9DE
        rtl

        .databank 0

        ; 85/D9DF

      rlUnknown85D9DF ; 85/D9DF

        .al
        .xl
        .autsiz
        .databank ?

        dec aProcSystem.aBody5,b,x
        bmi _D9EE
        beq _D9E8
        bra _D9F9


        _D9E8
        jsl rlUnknown8586FA
        bra _D9F9


        _D9EE
        lda #$0001
        jsl rlUnknown85ABF1
        jsl rlProcEngineFreeProc

        _D9F9
        rtl

        .databank 0

        ; 85/D9FA

    .endsection Unsorted85D971Section


    .section ProcScript85D9FASection

      .al
      .xl

      aProcUnknown85D8AACode ; 85/D9FA

        PROC_HALT


        ; 85/D9FC

    .endsection ProcScript85D9FASection


    .section Unsorted85D9FCSection

      .al
      .xl

      rlUnknown85D9FC ; 85/D9FC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR10
        lda #$003C
        sta wR11
        jsl rlUnsignedMultiply16By16
        stz wR15
        sty wR14
        jsl rlUnsignedDivide32By32
        lda wR12
        sta wR0
        stx wR1
        lda #$0005
        sta wR2
        jsr rsUnknown85DA43

        _DA1E
        jsr rsUnknown85DA7E
        dec wR2
        bpl _DA1E
        jsr rsUnknown85DABB
        plx
        rtl

        .databank 0

        ; 85/DA2A

      rlUnknown85DA2A ; 85/DA2A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sta wR0
        stx wR1
        lda #$000A
        sta wR2
        jsr rsUnknown85DA43

        _DA37
        jsr rsUnknown85DA7E
        dec wR2
        bpl _DA37
        jsr rsUnknown85DABB
        plx
        rtl

        .databank 0

        ; 85/DA43

      rsUnknown85DA43 ; 85/DA43

        .al
        .xl
        .autsiz
        .databank ?

        lda wR0
        cmp #$0006
        bpl _DA5C
        tax
        lda aUnknown85DA77,x
        and #$00FF
        ldx wR1
        jsl rlUnknown85D81F
        stz wR0
        bra _DA74


        _DA5C
        ldx #$0006
        lda aUnknown85DA77,x
        and #$00FF
        ldx wR1
        jsl rlUnknown85D81F
        lda wR0
        sec
        sbc #$0006
        sta wR0

        _DA74
        inc wR1
        rts

        .databank 0

        ; 85/DA77

    .endsection Unsorted85D9FCSection


    .section Table85DA77Section

      .al
      .xl

      aUnknown85DA77 ; 85/DA77

        ; Read by rsUnknown85DA43.

        .byte $00, $01, $02, $03, $04, $05, $06

        ; 85/DA7E

    .endsection Table85DA77Section


    .section Unsorted85DA7ESection

      .al
      .xl

      rsUnknown85DA7E ; 85/DA7E

        .al
        .xl
        .autsiz
        .databank ?

        lda wR0
        cmp #$0008
        bpl _DA97
        tax
        lda aUnknown85DAB2,x
        and #$00FF
        ldx wR1
        jsl rlUnknown85D81F
        stz wR0
        bra _DAAF


        _DA97
        ldx #$0008
        lda aUnknown85DAB2,x
        and #$00FF
        ldx wR1
        jsl rlUnknown85D81F
        lda wR0
        sec
        sbc #$0008
        sta wR0

        _DAAF
        inc wR1
        rts

        .databank 0

        ; 85/DAB2

    .endsection Unsorted85DA7ESection


    .section Table85DAB2Section

      .al
      .xl

      aUnknown85DAB2 ; 85/DAB2

        ; Read by rsUnknown85DA7E.

        .byte $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F

        ; 85/DABB

    .endsection Table85DAB2Section


    .section Unsorted85DABBSection

      .al
      .xl

      rsUnknown85DABB ; 85/DABB

        .al
        .xl
        .autsiz
        .databank ?

        ldx wR0
        lda aUnknown85DACB,x
        and #$00FF
        ldx wR1
        jsl rlUnknown85D81F
        rts

        .databank 0

        ; 85/DACB

    .endsection Unsorted85DABBSection


    .section Table85DACBSection

      .al
      .xl

      aUnknown85DACB ; 85/DACB

        ; Read by rsUnknown85DABB.

        .byte $18, $19, $1A, $1B, $1C, $1D, $1E, $AD, $B1, $0D, $C9, $FF, $FF, $F0, $02, $18
        .byte $6B, $38, $6B, $00, $00, $00, $00, $00, $00, $F6, $A0, $85, $05, $01, $01

        ; 85/DAEA

    .endsection Table85DACBSection


    .section ProcScript85DAEASection

      .al
      .xl

      procUnknown85DAEA ; 85/DAEA

        .structProcInfo "OW", rlProcUnknown85DAEAInit, rlProcUnknown85DAEACycle, aProcDialogueBoxCode

    .endsection ProcScript85DAEASection


    .section Unsorted85DAF6Section

      .al
      .xl

      rlProcUnknown85DAEAInit ; 85/DAF6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`procUnknown85CD0C)<<8
        sta lR44+1
        lda #<>procUnknown85CD0C
        sta lR44
        jsl rlProcEngineFindProc
        bcs _DB19
        lda #(`procUnknown85CD2D)<<8
        sta lR44+1
        lda #<>procUnknown85CD2D
        sta lR44
        jsl rlProcEngineFindProc
        bcs _DB19
        bra _DB43


        _DB19
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlGetMapMenuPosition
        and #$FF00
        ora #$0005
        sta wR0
        xba
        and #$00FF
        cmp #$0003
        bpl _DB3A
        lda wR0
        clc
        adc #$0300
        bra _DB40


        _DB3A
        lda wR0
        sec
        sbc #$0200

        _DB40
        sta aProcSystem.wInput3,b

        _DB43
        plx
        jsl rlUnknown85A117
        lda aProcSystem.wInput3,b
        and #$FF00
        asl a
        asl a
        asl a
        and #$FF00
        ora #$0020
        sta wR43
        lda #$0010
        sta wR42
        jsl rlUnknown859FCD
        rtl

        .databank 0

        ; 85/DB63

      rlUnknown85DB63 ; 85/DB63

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda #$2000
        sta aCurrentTilemapInfo,b
        pla
        jsl rlUnknown85DB70
        rtl

        .databank 0

        ; 85/DB70

      rlUnknown85DB70 ; 85/DB70

        .al
        .xl
        .autsiz
        .databank ?

        sta aProcSystem.wInput3,b
        stx aProcSystem.wInput2,b
        sty aProcSystem.wInput1,b
        lda aCurrentTilemapInfo,b
        sta aProcSystem.wInput0,b
        lda #(`procUnknown85DAEA)<<8
        sta lR44+1
        lda #<>procUnknown85DAEA
        sta lR44
        lda #$0000
        jsl rlProcEngineCreateProcByIndex
        rtl

        .databank 0

        ; 85/DB91

      rlUnknown85DB91 ; 85/DB91

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown85DAEA)<<8
        sta lR44+1
        lda #<>procUnknown85DAEA
        sta lR44
        jsl rlProcEngineFindProc
        bcc _DBAA
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0002
        sta aProcSystem.aHeaderBitfield,b,x

        _DBAA
        rtl

        .databank 0

        ; 85/DBAB

    .endsection Unsorted85DAF6Section


    .section Unsorted85DBDDSection

      .al
      .xl

      rlMapMenuOpenUnitWindow ; 85/DBDD

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        ; Map menu option ユニット (Unit): installs rsUnitWindowOpen as the main loop routine, with $7F82C5 set to return through rsUnknown80B122.

        stz wGameStateRoutine1,b
        lda #$B122
        sta $7F82C5
        lda #<>rsUnitWindowOpen
        sta wMainLoopPointer
        rtl

        .databank 0

        ; 85/DBED

      rlMapMenuOpenItemWindow ; 85/DBED

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        ; Map menu option アイテム (Item): installs rsItemWindowOpen as the main loop routine.

        stz wGameStateRoutine1,b
        lda #<>rsItemWindowOpen
        sta wMainLoopPointer
        rtl

        .databank 0

        ; 85/DBF6

      rlMapMenuOpenDataWindow ; 85/DBF6

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        ; Map menu option データ (Data): fades into rsDataWindowOpen (procMainLoopChangeFade, the routine in aProcSystem.wInput0).

        stz wGameStateRoutine1,b
        lda #<>rsDataWindowOpen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DC0E

      rlMapMenuOpenSkillWindow ; 85/DC0E

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        ; Map menu option スキル (Skill): fades into rsSkillWindowOpen (procMainLoopChangeFade, the routine in aProcSystem.wInput0).

        stz wGameStateRoutine1,b
        lda #<>rsSkillWindowOpen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DC26

    .endsection Unsorted85DBDDSection


    .section Unsorted85DC26Section

      .al
      .xl

      rlUnknown85DC26 ; 85/DC26

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0020
        tsb $0D87,b
        jsl rlUnknown85C0CE
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sep #$20
        sta $0D75,b
        rep #$20
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sep #$20
        sta $0D76,b
        rep #$20
        lda wUnknown000D79,b
        bit #$0020
        beq _DC79
        lda #$0000
        sta $0D77,b
        stz wGameStateRoutine1,b
        lda #$B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc

        _DC79
        rtl

        .databank 0

        ; 85/DC7A

      rlUnknown85DC7A ; 85/DC7A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda #$0001
        jsl rlUnknown87CBC5
        lda #$0100
        tsb wUnknown000D79,b
        stz wGameStateRoutine1,b
        lda #$AEEA
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DCAB

    .endsection Unsorted85DC26Section


    .section Unsorted85DCABSection

      .al
      .xl

      rlUnknown85DCAB ; 85/DCAB

        .al
        .xl
        .autsiz
        .databank ?

        lda #$00E0
        jsl rlUnknown808FA3
        stz wGameStateRoutine1,b
        lda #$F222
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DCCA

    .endsection Unsorted85DCABSection


    .section Unsorted85DCCASection

      .al
      .xl

      rlUnknown85DCCA ; 85/DCCA

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        stz wGameStateRoutine1,b
        lda #$E598
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DCE2

    .endsection Unsorted85DCCASection


    .section Unsorted85DE34Section

      .al
      .xl

      rlUnknown85DE34 ; 85/DE34

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown858516
        beq _DE3E
        jml _DE42


        _DE3E
        jsl rlUnknown8583F8

        _DE42
        rtl

        .databank 0

        ; 85/DE43

      rlUnknown85DE43 ; 85/DE43

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        sta $057C,b
        jsl rlUnknown88AF7B
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown84CAA9
        plx
        rtl

        .databank 0

        ; 85/DE57

      rlUnknown85DE57 ; 85/DE57

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        ldx wActiveUnitDeploymentOffset,b
        lda #$0000
        sta $057C,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta aProcSystem.wInput0,b
        lda #$2000
        sta aProcSystem.wInput1,b
        lda #$8500
        sta lR44+1
        lda #$9281
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DE7C

    .endsection Unsorted85DE34Section


    .section Unsorted85DE7CSection

      .al
      .xl

      rlUnknown85DE7C ; 85/DE7C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx wActiveUnitDeploymentOffset,b
        lda #$0000
        sta $057C,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown84B474
        lda wSelectedUnitDataRAMPointer,b
        sta aProcSystem.wInput0,b
        lda #$2010
        sta aProcSystem.wInput1,b
        lda #$8500
        sta lR44+1
        lda #$9281
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DEAB

      rlUnknown85DEAB ; 85/DEAB

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        stz wSelectedInventorySlot,b
        lda #$0000
        sta $057C,b
        lda #$0001
        sta wR10
        sta wR12
        lda #$0001
        sta wR11
        lda #$0002
        jsl rlFindTargetsInRange
        lda wActiveUnitDeploymentOffset,b
        sta wR0
        lda #$FFFF
        sta wR1
        jsl rlUnknown84DC1C
        rtl

        .databank 0

        ; 85/DED6

    .endsection Unsorted85DE7CSection


    .section Unsorted85DED6Section

      .al
      .xl

      rlUnknown85DED6 ; 85/DED6

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        ldx wActiveUnitDeploymentOffset,b
        lda #$0000
        sta $057C,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta aProcSystem.wInput0,b
        lda #$2008
        sta aProcSystem.wInput1,b
        lda #$8500
        sta lR44+1
        lda #$9281
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DEFB

    .endsection Unsorted85DED6Section


    .section Unsorted85DF20Section

      .al
      .xl

      rlUnknown85DF20 ; 85/DF20

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown88AF7B
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown84CC5D
        pha
        bcs _DF33
        jsl rlUnknown84CAA9

        _DF33
        pla
        cpy #$0001
        bne _DF3D
        jsl rlUnknown84CD8A

        _DF3D
        plx
        rtl

        .databank 0

        ; 85/DF3F

    .endsection Unsorted85DF20Section


    .section Unsorted85DF3FSection

      .al
      .xl

      rlUnknown85DF3F ; 85/DF3F

        .al
        .autsiz
        .databank ?

        phx
        jsl rlUnknown88AF7B
        ldx wActiveUnitDeploymentOffset,b
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


    .section Unsorted85DF61Section

      .al
      .xl

      rlUnknown85DF61 ; 85/DF61

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown88AF7B
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown84CDD6
        plx
        rtl

        .databank 0

        ; 85/DF6F

    .endsection Unsorted85DF61Section


    .section Unsorted85DF6FSection

      .al
      .xl

      rlUnknown85DF6F ; 85/DF6F

        .al
        .autsiz
        .databank ?

        phx
        jsl rlUnknown88AF7B
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown84CE21
        plx
        rtl

        .databank 0

        ; 85/DF7D

    .endsection Unsorted85DF6FSection


    .section Unsorted85DF8ASection

      .al
      .xl

      rlUnknown85DF8A ; 85/DF8A

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown88AF7B
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown84D10F
        plx
        rtl

        .databank 0

        ; 85/DF98

      rlUnknown85DF98 ; 85/DF98

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown88AF7B
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown84D0B9
        plx
        rtl

        .databank 0

        ; 85/DFA6

    .endsection Unsorted85DF8ASection


    .section Unsorted85DFC2Section

      .al
      .xl

      rlUnknown85DFC2 ; 85/DFC2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0004
        sta $057C,b
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        sec
        jsl rlUnknown84BA3E
        jsl rlUnknown88AD46
        plx
        rtl

        .databank 0

        ; 85/DFDE

    .endsection Unsorted85DFC2Section


    .section Unsorted85DFFDSection

      .al
      .xl

      rlUnknown85DFFD ; 85/DFFD

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown85A886
        plx
        rtl

        .databank 0

        ; 85/E004

    .endsection Unsorted85DFFDSection


    .section Unsorted85E012Section

      .al
      .xl

      rlUnknown85E012 ; 85/E012

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        stz wSelectedInventorySlot,b
        lda #$0002
        sta $057C,b
        lda #$0001
        sta wR10
        sta wR11
        sta wR12
        lda #$0005
        jsl rlFindTargetsInRange
        jsl rlUnknown88AD46
        rtl

        .databank 0

        ; 85/E030

      rlUnknown85E030 ; 85/E030

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        stz wSelectedInventorySlot,b
        lda #$0003
        sta $057C,b
        lda #$0001
        sta wR10
        sta wR11
        sta wR12
        lda #$000A
        jsl rlFindTargetsInRange
        jsl rlUnknown88AD46
        plx
        rtl

        .databank 0

        ; 85/E050

      rlUnknown85E050 ; 85/E050

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        stz wSelectedInventorySlot,b
        lda #$0003
        sta $057C,b
        lda #$0001
        sta wR10
        sta wR11
        sta wR12
        lda #$000B
        jsl rlFindTargetsInRange
        jsl rlUnknown88AD46
        plx
        rtl

        .databank 0

        ; 85/E070

    .endsection Unsorted85E012Section


    .section ProcScript85E1CCSection

      .al
      .xl

      procUnknown85E1CC ; 85/E1CC

        .structProcInfo "PW", rlProcUnknown85E1CCInit, rlProcUnknown85E1CCCycle, aProcUnknown85DDDBCode

    .endsection ProcScript85E1CCSection


    .section Unsorted85E1DBSection

      .al
      .xl

      rlProcUnknown85E1CCInit ; 85/E1DB

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8583C2
        lda #$0000
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody7,b,x
        rtl

        .databank 0

        ; 85/E1ED

      rlProcUnknown85E1CCCycle ; 85/E1ED

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0009
        jsl rlUnknown808FAD
        lda aProcSystem.aHeaderTypeOffset,b,x
        tay
        jsl rlLoadMapMenuDataFromProc
        jsl rlUnknown8584AC
        lda #$0000
        sta aBGPaletteBuffer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$20FF
        sta wUnknown053C,b
        lda aProcSystem.aBody7,b,x
        sta aProcSystem.wInput0,b
        lda #$0001
        sta $0543,b
        sta $0545,b
        phx
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsr rsUnknown85E44E
        jsr rsUnknown85E468
        ldx #$002E

        _E235
        phx
        jsr ($85E27F,x)
        plx
        bcc _E24B
        lda #$85E2
        sta lUnknown0540+1,b
        lda $E2AF,b,x
        sta lUnknown0540,b
        jsr rsUnknown85E332

        _E24B
        dec x
        dec x
        bpl _E235
        plx
        jsl rlUnknown82F3BE
        inc a
        asl a
        xba
        ora #$0009
        jsl rlSetMapMenuTilemapArea
        jsl rlUnknown85856E
        jsl rlUnknown8584DC
        lda aProcSystem.aBody7,b,x
        cmp #$0002
        beq _E278
        cmp #$0001
        bne _E278
        jsr rsUnknown85E2DF
        bra _E278


        _E278
        lda #<>rlUnknown85E33D
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/E27F

    .endsection Unsorted85E1DBSection


    .section Unsorted85E2DFSection

      .al
      .xl

      rsUnknown85E2DF ; 85/E2DF

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
        ldy $0547,b
        sep #$20
        lda $0549,b
        pha
        rep #$20
        plb
        .databank ?
        lda $0002,b,y
        ora $0003,b,y
        beq _E32D
        phb
        lda $0002,b,y
        tax
        sep #$20
        lda $0004,b,y
        pha
        rep #$20
        plb
        .databank ?
        lda @l $000547
        sta $0002,b,x
        lda @l $000548
        sta $0003,b,x
        plb
        .databank ?
        lda $0002,b,y
        sta @l $000547
        lda $0003,b,y
        sta @l $000548
        lda #$0000
        sta $0002,b,y
        sta $0003,b,y

        _E32D
        ply
        plx
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 85/E332

      rsUnknown85E332 ; 85/E332

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown82F343
        inc $0545,b
        inc $0545,b
        rts

        .databank 0

        ; 85/E33D

    .endsection Unsorted85E2DFSection


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

            lda aProcSystem.aBody7,b,x
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
        jsr rsUnknown858542
        bra -

        .databank 0

        ; 85/E38C

    .endsection Unsorted85E33DSection


    .section Unsorted85E38CSection

      .al
      .xl

      rsUnknown85E38C ; 85/E38C

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        lda wEventLocationEntry,b
        bne _E395
        jml rsUnknown85E547


        _E395
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeCastle
        beq _E3A2
        jml rsUnknown85E547


        _E3A2
        jsl rlGetLocationFactionSlotOwner
        tax
        lda wActiveFactionSlot,b
        jsl rlGetFactionRelation
        cmp #AllegianceEnemy
        bne _E3B7
        jml rsUnknown85E547


        _E3B7
        cmp #$0003
        bne _E3C0
        jml rsUnknown85E547


        _E3C0
        jml rsUnknown85E545

        ldx wActiveUnitDeploymentOffset,b
        lda wEventLocationEntry,b
        bne _E3D0
        jml rsUnknown85E547


        _E3D0
        jsl rlGetEventLocationEntryType
        cmp #$0001
        beq _E3DD
        jml rsUnknown85E547


        _E3DD
        jml rsUnknown85E545

        ldx wActiveUnitDeploymentOffset,b
        lda wEventLocationEntry,b
        bne _E3ED
        jml rsUnknown85E547


        _E3ED
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeVillage
        beq _E3FA
        jml rsUnknown85E547


        _E3FA
        jsl rlCheckLocationDestroyed
        bcc _E404
        jml rsUnknown85E547


        _E404
        jsl rlCheckIfVillageClosed
        bcc _E40E
        jml rsUnknown85E547


        _E40E
        jml rsUnknown85E545

        lda wEventLocationEntry,b
        bne _E41B
        jml rsUnknown85E547


        _E41B
        jsl rlGetLocationFactionSlotOwner
        tax
        lda wActiveFactionSlot,b
        jsl rlGetFactionRelation
        cmp #AllegianceEnemy
        beq _E430
        jml rsUnknown85E547


        _E430
        jsl rlCheckLocationDestroyed
        bcs _E44C
        jsl rlCheckIfCastleGuarded
        bcs _E44C
        jsl rlGetSelectedUnitClassID
        cmp #$0006
        beq _E44A
        cmp #$002C
        bne _E44C

        _E44A
        sec
        rts


        _E44C
        clc
        rts

        .databank 0

        ; 85/E44E

    .endsection Unsorted85E38CSection


    .section Unsorted85E44ESection

      .al
      .xl

      rsUnknown85E44E ; 85/E44E

        .al
        .xl
        .autsiz
        .databank ?

        lda aDeploymentTable._XTilePosition,x
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        sta wR11
        lda aDeploymentTable,x
        and #$0003
        sta wR12
        jsl rlUnknown84F786
        rts

        .databank 0

        ; 85/E468

      rsUnknown85E468 ; 85/E468

        .al
        .xl
        .autsiz
        .databank ?

        lda aDeploymentTable._XTilePosition,x
        sta wR0
        lda aDeploymentTable._YTilePosition,x
        sta wR1
        jsl rlCheckIfCoordsNotEventLocationTile
        lda wEventLocationEntry,b
        sta $0580,b
        rts

        .databank 0

        ; 85/E47F

    .endsection Unsorted85E44ESection


    .section Unsorted85E47FSection

      .al
      .xl

      rsUnknown85E47F ; 85/E47F

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody7,b,x
        cmp #$0002
        bne _E48E
        jml rsUnknown85E547


        _E48E
        lda $0D87,b
        bit #$0008
        beq _E49A
        jml rsUnknown85E547


        _E49A
        lda $7E2000
        and #$00FF
        bne _E4A7
        jml rsUnknown85E547


        _E4A7
        jml rsUnknown85E545


        _E4AB
        phx
        lda wAIGroupLeaderFieldMovement
        and #$00FF
        dec a
        tax

        _E4B5
        lda wAIGroupLeaderFieldMovement+1,x
        and #$00FF
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemStaffEffect
        cmp #$000C
        bcc _E4CF
        dec x
        bpl _E4B5
        plx
        clc
        rts


        _E4CF
        plx
        sec
        rts

        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody7,b,x
        cmp #$0002
        bne _E4E1
        jml rsUnknown85E547


        _E4E1
        lda $0D87,b
        bit #$0008
        bne rsUnknown85E547
        lda wAIGroupLeaderFieldMovement
        and #$00FF
        beq rsUnknown85E547
        jsr _E4AB
        bcc rsUnknown85E547
        jml rsUnknown85E545

        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody7,b,x
        cmp #$0002
        bne _E50A
        jml rsUnknown85E547


        _E50A
        lda $0D87,b
        bit #$0008
        bne rsUnknown85E547
        lda wAIGroupLeaderFieldMovement
        and #$00FF
        beq rsUnknown85E547
        jsr _E4AB
        bcs rsUnknown85E547
        jml rsUnknown85E545

        lda $0D87,b
        bit #$0008
        bne rsUnknown85E547
        lda wAIUnknown7E2018
        and #$00FF
        beq rsUnknown85E547
        jml rsUnknown85E545

        lda wAIGroupLeaderDeploymentOffset
        and #$00FF
        cmp #$0002
        bcc rsUnknown85E547

        .databank 0

        ; 85/E545

    .endsection Unsorted85E47FSection


    .section Unsorted85E545Section

      .al
      .xl

      rsUnknown85E545 ; 85/E545

        .al
        .xl
        .autsiz
        .databank ?

        sec
        rts

        .databank 0

        ; 85/E547

      rsUnknown85E547 ; 85/E547

        .al
        .xl
        .autsiz
        .databank ?

        clc
        rts

        .databank 0

        ; 85/E549

    .endsection Unsorted85E545Section


    .section Unsorted85E549Section

      .al
      .xl

      rlUnknown85E549 ; 85/E549

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        bne _E55A
        lda $0D87,b
        bit #$0008
        bne rsUnknown85E547

        _E55A
        clc
        jsl rlUnknown84B9A3
        bcs rsUnknown85E547
        lda #$0001
        sta wR10
        sta wR11
        stz wR12
        lda #$0003
        jsl rlFindTargetsInRange
        ora #$0000
        bne _E57A
        jml rsUnknown85E547


        _E57A
        jml rsUnknown85E545

        .databank 0

        ; 85/E57E

    .endsection Unsorted85E549Section


    .section Unsorted85E57ESection

      .al
      .xl

      rlUnknown85E57E ; 85/E57E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wEventLocationEntry,b
        beq rsUnknown85E547
        lda $07E0,b
        and #$00FF
        cmp #$0002
        beq rsUnknown85E547
        jsl rlCheckIfCastleGuarded
        bcs rsUnknown85E547
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeCastle
        bne rsUnknown85E547
        ldx wActiveFactionSlot,b
        jsl rlGetLocationFactionSlotOwner
        jsl rlGetFactionRelation
        cmp #AllegianceOwn
        beq rsUnknown85E545
        cmp #AllegianceNeutral
        beq rsUnknown85E545
        jml rsUnknown85E547

        .databank 0

        ; 85/E5B6

      rlUnknown85E5B6 ; 85/E5B6

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitHomeCastle
        sta wR0
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionSlotLocationID
        cmp wR0
        beq _E5CC
        jml rsUnknown85E547


        _E5CC
        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        bne _E5D9
        jml rsUnknown85E547


        _E5D9
        bit #$0800
        beq _E5E2
        jml rsUnknown85E547


        _E5E2
        jml rsUnknown85E545

        .databank 0

        ; 85/E5E6

      rlUnknown85E5E6 ; 85/E5E6

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        bne _E5F3
        jml rsUnknown85E547


        _E5F3
        bit #$0800
        beq _E5FC
        jml rsUnknown85E547


        _E5FC
        lda wSelectedUnitDataRAMPointer,b
        pha
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._XTilePosition,x
        sta wR0
        lda aDeploymentTable._YTilePosition,x
        inc a
        inc a
        sta wR1
        jsl rlGetUnitByCoordinates
        pla
        sta wSelectedUnitDataRAMPointer,b
        bcs _E61F
        jml rsUnknown85E547


        _E61F
        jml rsUnknown85E545

        .databank 0

        ; 85/E623

      rlUnknown85E623 ; 85/E623

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wActiveUnitDeploymentOffset,b
        jsl rlGetTerrainTypeByDeploymentOffset
        cmp #$0009
        bne _E633
        jml rsUnknown85E545


        _E633
        lda wEventLocationEntry,b
        bne _E63C
        jml rsUnknown85E545


        _E63C
        jsl rlGetEventLocationEntryID
        sta wR0
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionSlotLocationID
        cmp wR0
        beq _E652
        jml rsUnknown85E545


        _E652
        jml rsUnknown85E547

        .databank 0

        ; 85/E656

      rlUnknown85E656 ; 85/E656

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        bne _E694
        lda wEventLocationEntry,b
        bne _E668
        jml rsUnknown85E547


        _E668
        jsl rlCheckIfCastleGuarded
        bcs _E672
        jml rsUnknown85E547


        _E672
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeCastle
        beq _E67F
        jml rsUnknown85E547


        _E67F
        jsl rlGetLocationFactionSlotOwner
        tax
        lda wActiveFactionSlot,b
        jsl rlGetFactionRelation
        cmp #AllegianceEnemy
        beq _E694
        jml rsUnknown85E547


        _E694
        lda wAIUnknown7E2010
        and #$00FF
        bne _E6A1
        jml rsUnknown85E547


        _E6A1
        jml rsUnknown85E545

        .databank 0

        ; 85/E6A5

      rlUnknown85E6A5 ; 85/E6A5

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitSkills
        lda lRoutineVariable,b
        bit #$0008
        bne _E6B5
        jml rsUnknown85E547


        _E6B5
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassSkills
        bit #$0400
        bne _E6C6
        jml rsUnknown85E547


        _E6C6
        jsl rlGetSelectedUnitStates
        bit #UnitState1000
        beq _E6D3
        jml rsUnknown85E547


        _E6D3
        jml rsUnknown85E545

        .databank 0

        ; 85/E6D7

    .endsection Unsorted85E57ESection


    .section Unsorted85E6D7Section

      .al
      .xl

      rlUnknown85E6D7 ; 85/E6D7

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitStates
        bit #UnitState1000
        bne _E6E4
        jml rsUnknown85E547


        _E6E4
        jml rsUnknown85E545

        .databank 0

        ; 85/E6E8

    .endsection Unsorted85E6D7Section


    .section Unsorted85E6E8Section

      .al
      .xl

      rlUnknown85E6E8 ; 85/E6E8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody7,b,x
        cmp #$0002
        bne _E6F7
        jml rsUnknown85E547


        _E6F7
        jsl rlGetEventLocationEntryID
        sta wR0
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionSlotLocationID
        cmp wR0
        bne _E70D
        jml rsUnknown85E547


        _E70D
        lda $0D87,b
        bit #$0008
        beq _E719
        jml rsUnknown85E547


        _E719
        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        beq _E726
        jml rsUnknown85E547


        _E726
        lda #SkillIDReturn
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcc _E733
        jml rsUnknown85E545


        _E733
        lda #SkillIDReturn
        jsl rlCheckIfInventoryItemsHaveSpecifiedSkill
        bcc _E740
        jml rsUnknown85E545


        _E740
        jml rsUnknown85E547

        .databank 0

        ; 85/E744

      rlUnknown85E744 ; 85/E744

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $0D87,b
        bit #$0008
        beq _E750
        jml rsUnknown85E547


        _E750
        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        beq _E75D
        jml rsUnknown85E547


        _E75D
        lda #SkillIDDance
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _E76A
        jml rsUnknown85E547


        _E76A
        lda #$0001
        sta wR10
        lda #$0001
        sta wR11
        stz wR12
        lda #$0007
        jsl rlFindTargetsInRange
        ora #$0000
        bne _E786
        jml rsUnknown85E547


        _E786
        jml rsUnknown85E545

        .databank 0

        ; 85/E78A

    .endsection Unsorted85E6E8Section


    .section Unsorted85E78ASection

      .al
      .xl

      rlUnknown85E78A ; 85/E78A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $0D87,b
        bit #$0008
        beq _E796
        jml rsUnknown85E547


        _E796
        lda #$0001
        sta wR10
        sta wR11
        stz wR12
        lda #$0005
        jsl rlFindTargetsInRange
        ora #$0000
        bne _E7AF
        jml rsUnknown85E547


        _E7AF
        jml rsUnknown85E545

        .databank 0

        ; 85/E7B3

    .endsection Unsorted85E78ASection


    .section Unsorted85E7B3Section

      .al
      .xl

      rlUnknown85E7B3 ; 85/E7B3

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $0D87,b
        bit #$0008
        beq _E7BF
        jml rsUnknown85E547


        _E7BF
        lda #SkillIDSteal
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _E7CC
        jml rsUnknown85E547


        _E7CC
        jsl rlGetSelectedUnitMoney
        ora #$0000
        bne _E7D9
        jml rsUnknown85E547


        _E7D9
        lda #$0001
        sta wR10
        sta wR11
        stz wR12
        lda #$000A
        jsl rlFindTargetsInRange
        ora #$0000
        bne _E7F2
        jml rsUnknown85E547


        _E7F2
        jml rsUnknown85E545

        .databank 0

        ; 85/E7F6

      rlUnknown85E7F6 ; 85/E7F6

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $0D87,b
        bit #$0008
        beq _E802
        jml rsUnknown85E547


        _E802
        lda #SkillIDSteal
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcc _E80F
        jml rsUnknown85E547


        _E80F
        jsl rlGetSelectedUnitMoney
        ora #$0000
        bne _E81C
        jml rsUnknown85E547


        _E81C
        lda #$0001
        sta wR10
        sta wR11
        stz wR12
        lda #$000B
        jsl rlFindTargetsInRange
        ora #$0000
        bne _E835
        jml rsUnknown85E547


        _E835
        jml rsUnknown85E545

        .databank 0

        ; 85/E839

    .endsection Unsorted85E7B3Section


    .section Unsorted85E839Section

      .al
      .xl

      rlUnknown85E839 ; 85/E839

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        bne _E84E
        lda $0D87,b
        bit #$0008
        beq _E84E
        jml rsUnknown85E547


        _E84E
        clc
        jsl rlUnknown84B9A3
        bcs _E859
        jml rsUnknown85E547


        _E859
        jml rsUnknown85E545

        .databank 0

        ; 85/E85D

    .endsection Unsorted85E839Section


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
        sta aProcSystem.wInput0,b
        lda #(`procUnknown85E1CC)<<8
        sta lR44+1
        lda #<>procUnknown85E1CC
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


    .section Unsorted85E8A8Section

      .al
      .xl

      rlUnknown85E8A8 ; 85/E8A8

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        lda #$0008
        tsb $0D87,b
        lda #$0001
        sta aProcSystem.wInput0,b
        lda #(`procUnknown85E1CC)<<8
        sta lR44+1
        lda #<>procUnknown85E1CC
        sta lR44
        jsl rlProcEngineCreateProc
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/E8C9

      rlUnknown85E8C9 ; 85/E8C9

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $85
        lda #$0010
        tsb $0D87,b
        lda #$0002
        sta aProcSystem.wInput0,b
        lda #(`procUnknown85E1CC)<<8
        sta lR44+1
        lda #<>procUnknown85E1CC
        sta lR44
        jsl rlProcEngineCreateProc
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/E8EA

    .endsection Unsorted85E8A8Section


    .section Unsorted85E8EASection

      .al
      .xl

      rlUnknown85E8EA ; 85/E8EA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown84B32B
        plx
        rtl

        .databank 0

        ; 85/E8FB

    .endsection Unsorted85E8EASection


    .section Unsorted85E8FBSection

      .al
      .xl

      rlUnknown85E8FB ; 85/E8FB

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlDiscardSelectedInventoryItem
        jsl rlUnknown88AF7B
        plx
        rtl

        .databank 0

        ; 85/E910

    .endsection Unsorted85E8FBSection


    .section Unsorted85E960Section

      .al
      .xl

      rlUnknown85E960 ; 85/E960

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown8583DA
        lda #<>rlUnknown85DE34
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/E96B

    .endsection Unsorted85E960Section


    .section Unsorted85E9D6Section

      .al
      .xl

      rlUnknown85E9D6 ; 85/E9D6

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0009
        jsl rlUnknown808FAD
        lda aProcSystem.aHeaderTypeOffset,b,x
        tay
        jsl rlLoadMapMenuDataFromProc
        jsl rlUnknown8584AC
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$20FF
        sta wUnknown053C,b
        lda #$0001
        sta $0543,b
        sta $0545,b
        phx
        jsl rlUnknown84F8D9
        ldx #$0002

        _EA06
        phx
        jsr ($85EA3A,x)
        plx
        bcc _EA1C
        lda #$85EA
        sta lUnknown0540+1,b
        lda $EA3E,b,x
        sta lUnknown0540,b
        jsr rsUnknown85E332

        _EA1C
        dec x
        dec x
        bpl _EA06
        plx
        jsl rlUnknown82F3BE
        inc a
        asl a
        xba
        ora #$0009
        jsl rlSetMapMenuTilemapArea
        jsl rlUnknown85856E
        lda #<>rlUnknown8583F8
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/EA3A

    .endsection Unsorted85E9D6Section


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
