; Code from bank $85 not yet assigned to a game system.


    .section Unsorted8583C2Section

      .al
      .xl

      rlUnknown8583C2 ; 85/83C2

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlMapMenuSaveMapState
        lda $0F57,b,x
        sta $1017,b,x
        lda #$83D3
        sta $0F57,b,x
        rtl

        .databank 0

        ; 85/83D3

    .endsection Unsorted8583C2Section


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
        sta $1057,b,x
        lda $0548,b
        sta $1077,b,x
        lda #$0001
        sta $1097,b,x
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
        jsr rsUnknown85915A
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
        cmp $1057,b,x
        bmi _A074
        lda $1057,b,x
        sta wR3
        lda wR6
        asl a
        phx
        tax
        jsr ($85A079,x)
        plx
        inc $1057,b,x
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
        lda $0ED1,b
        sta $10B7,b,x
        lda $0ED5,b
        jsl rlSetMapMenuPosition
        lda $0ED3,b
        jsl rlSetMapMenuTilemapArea
        jsl rlUnknown85877E
        plx
        phx
        lda $0ECF,b
        sta $1097,b,x
        lda $10B7,b,x
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
        lda $1097,b,x
        sta aCurrentTilemapInfo,b
        lda $10B7,b,x
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
        lda #$A1AA
        sta $0F57,b,x
        rtl

        .databank 0

        ; 85/A1AA

    .endsection Unsorted85A117Section


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
        lda $0ECF,b
        sta $1097,b,x
        lda #$0000
        sta $10B7,b,x
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
        lda $10B7,b,x
        bit #$0001
        bne _A531
        ora #$0001
        sta $10B7,b,x
        bra _A54C


        _A531
        eor #$0001
        sta $10B7,b,x
        bra _A54C


        _A539
        jsr rsUnknown85A56D
        bcc _A54C
        jsl rlUnknown8586FA
        jsl rlProcEngineFreeProc
        jsl rlUnknown85C0D5
        bra _A56C


        _A54C
        lda $10B7,b,x
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

        lda $1097,b,x
        bne _A595
        lda wJoy1New
        bit #$0080
        beq _A591
        lda #$000A
        jsl rlUnknown808FAD
        lda $10B7,b,x
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
        lda $10B7,b,x
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
        lda #$AC89
        sta $0F57,b,x

        _AC88
        rtl

        .databank 0

        ; 85/AC89

    .endsection Unsorted85AC40Section


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
        lda $1097,b,x
        sec
        sbc #$0064
        sta $1097,b,x
        lda $0F37,b,x
        ora #$0001
        sta $0F37,b,x

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
        lda #$B207
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/B207

    .endsection Unsorted85B1B0Section


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
        sta $0ED1,b
        sta $0ED3,b
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
        lda $0ECF,b
        sta wCurrentItemDataROMPointer,b
        lda $0ED1,b
        bmi _B738
        jsl rlSetMapMenuPosition

        _B738
        lda $0ED3,b
        sta $10B7,b,x
        lda $0ED5,b
        sta wSelectedUnitDataRAMPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $0ED3,b
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
        lda $10B7,b,x
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
        lda $10B7,b,x
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
        sta $1077,b,x
        lda $0ED5,b
        and #$FF00
        sta $10B7,b,x
        lda $0ED3,b
        sta $1097,b,x
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
        ora $10B7,b,x
        jsl rlSetMapMenuPosition
        phx
        phy
        lda #$20F0
        sta aCurrentTilemapInfo,b
        lda $1097,b,x
        sta wR0

        _B968
        dec y
        lda wR0
        sta wR13
        lda #$000A
        sta wR14
        jsl rlUnknown80A1AB
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
        sta $1057,b,x
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
        lda #$BAD9
        sta $0F57,b,x

        _BAD8
        rtl

        .databank 0

        ; 85/BAD9

    .endsection Unsorted85BAC7Section


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
        lda $0ECF,b
        and #$00FF
        sta $10B7,b,x
        lda $0ED1,b
        sta $1077,b,x
        lda $0ED5,b
        sta $7FEB0A
        lda $0ED0,b
        and #$00FF
        clc
        adc $10B7,b,x
        cmp $1077,b,x
        bmi _CAC4
        lda $1077,b,x

        _CAC4
        sep #$20
        sta $1058,b,x
        rep #$20
        lda $0ED3,b
        sta $1097,b,x
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
        lda #$CAFB
        sta $0F57,b,x
        lda $0F37,b,x
        ora #$0001
        sta $0F37,b,x

        _CAFA
        rtl

        .databank 0

        ; 85/CAFB

    .endsection Unsorted85CA91Section


    .section Unsorted85CAFCSection

      .al
      .xl

      rlProcUnknown85CA85Cycle2 ; 85/CAFC

        .al
        .xl
        .autsiz
        .databank ?

        lda $0F37,b,x
        and #$FFFE
        sta $0F37,b,x
        lda #$CB36
        sta $0F57,b,x
        phx
        lda $1097,b,x
        tax
        lda $7E441B,x
        sta $0ECF,b
        lda $7E44AB,x
        sta $0ED1,b
        plx
        lda $7FEB0A
        sta $0ED5,b
        lda #(`procUnknown9ECEDD)<<8
        sta lR44+1
        lda #<>procUnknown9ECEDD
        sta lR44
        jsl rlProcEngineCreateProc
        bra _CB50

        .byte $86, $00, $A9, $00, $9E, $85, $63, $A9, $DD, $CE, $85, $62, $22, $11, $81, $82
        .byte $B0, $08, $A6, $00, $A9, $51, $CB, $9D, $57, $0F


        _CB50
        rtl

        .databank 0

        ; 85/CB51

    .endsection Unsorted85CAFCSection


    .section Unsorted85CBBDSection

      .al
      .xl

      rlProcUnknown85CA85Cycle3 ; 85/CBBD

        .al
        .xl
        .autsiz
        .databank ?

        lda $0F37,b,x
        and #$FFFE
        sta $0F37,b,x
        lda #$CBCC
        sta $0F57,b,x
        phx
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda $1058,b,x
        and #$00FF
        cmp $10B7,b,x
        bne _CBED
        lda #$CC3D
        sta $0F57,b,x
        lda $0F37,b,x
        ora #$0001
        sta $0F37,b,x
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
        inc $10B7,b,x

        _CC0E
        rep #$20
        plx
        phx
        lda $10B7,b,x
        ldx #$05A0
        stx aCurrentTilemapInfo,b
        ldx #$0101
        jsl rlUnknown878900
        plx
        phx
        lda $10B7,b,x
        ldy $1077,b,x
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
        lda #$CC4D
        sta $0F57,b,x
        rtl

        .databank 0

        ; 85/CC4D

    .endsection Unsorted85CC3ESection


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
        lda $1077,b,x
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

        lda $0ED5,b
        sta $10B7,b,x
        lda $0ED3,b
        sta $1077,b,x
        bit #$0080
        beq _CD9B
        lda $0F37,b,x
        ora #$0001
        sta $0F37,b,x

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
        ldy $10B7,b,x
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        ldy $10B7,b,x
        lda $0010,b,y
        sta $1077,b,x
        lda $0012,b,y
        sta $1097,b,x
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
        lda $1077,b,x
        ldy $1097,b,x
        ldx #$0980
        stx aCurrentTilemapInfo,b
        ldx #$0203
        jsl rlUnknown85D9FC
        plx
        phx
        ldy $10B7,b,x
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
        lda $1077,b,x
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

        lda $0F37,b,x
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

        lda $0F37,b,x
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
        lda #$CEE2
        sta $0F57,b,x
        rtl

        .databank 0

        ; 85/CEE2

    .endsection Unsorted85CEC3Section


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

        lda $7E4EBB
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
        lda $7E4F1B
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
        sta $0ECF,b
        lda aChildAverageLevelStats
        sta $0ED1,b
        lda #$4EB5
        sta $0ED5,b
        lda wR0
        sta $0ED3,b
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
        lda $7E4F27
        sta $0ECF,b
        lda $7E4F25
        sta $0ED1,b
        lda #$4F15
        sta $0ED5,b
        lda wR1
        sta $0ED3,b
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

        lda $7E4F17
        sta wR2
        sta wR10
        lda $7E4EB7
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
        lda $7E4F19
        sta wR11
        jsl rlUnknown88BF6C
        lda wR11
        sta wR2
        lda $7E4EB9
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

        lda $7E4F17
        sta wR2
        lda $7E4EB7
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
        sta $0ECF,b
        lda #$000D
        sta $0ED3,b
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
        lda $0006,b,y
        sta lR23
        lda $0007,b,y
        sta lR23+1
        stz wR0
        txa
        sep #$20
        sta wR0
        xba
        sta @l WRMPYA
        lda $0000,b,y
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
        lda $0ED3,b
        sta wR6
        lda $0ED1,b
        sta $10B7,b,x
        lda $0ED5,b
        sta $1097,b,x
        lda wR6
        xba
        ora #$0005
        jsl rlSetMapMenuPosition
        lda $0ECF,b
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
        lda $10B7,b,x
        ldx #$05A0
        stx aCurrentTilemapInfo,b
        ldx #$0105
        jsl rlUnknown878900
        plx
        phx
        lda $10B7,b,x
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
        sta $1077,b,x
        lda #$D971
        sta $0F57,b,x
        rtl

        .databank 0

        ; 85/D96D

    .endsection Unsorted85D8B6Section


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
        jsl rlUnknown80A1D8
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
        sta $0ED5,b

        _DB43
        plx
        jsl rlUnknown85A117
        lda $0ED5,b
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

        sta $0ED5,b
        stx $0ED3,b
        sty $0ED1,b
        lda aCurrentTilemapInfo,b
        sta $0ECF,b
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
        lda $0F37,b,x
        ora #$0002
        sta $0F37,b,x

        _DBAA
        rtl

        .databank 0

        ; 85/DBAB

    .endsection Unsorted85DAF6Section


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
        stz $0302,b
        lda #$F222
        sta $0ECF,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DCCA

    .endsection Unsorted85DCABSection


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
        lda $0ECF,b
        sta $10B7,b,x
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
        lda $0ED7,b,x
        tay
        jsl rlLoadMapMenuDataFromProc
        jsl rlUnknown8584AC
        lda #$0000
        sta aBGPaletteBuffer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$20FF
        sta wUnknown053C,b
        lda $10B7,b,x
        sta $0ECF,b
        lda #$0001
        sta $0543,b
        sta $0545,b
        phx
        ldx $0772,b
        lda $7E46EB,x
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
        lda $10B7,b,x
        cmp #$0002
        beq _E278
        cmp #$0001
        bne _E278
        jsr rsUnknown85E2DF
        bra _E278


        _E278
        lda #$E33D
        sta $0F57,b,x
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
        jsr rsUnknown858542
        bra -

        .databank 0

        ; 85/E38C

    .endsection Unsorted85E33DSection


    .section Unsorted85E44ESection

      .al
      .xl

      rsUnknown85E44E ; 85/E44E

        .al
        .xl
        .autsiz
        .databank ?

        lda $7E441B,x
        sta wR10
        lda $7E44AB,x
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

        lda $7E441B,x
        sta wR0
        lda $7E44AB,x
        sta wR1
        jsl rlCheckIfCoordsNotEventLocationTile
        lda wEventLocationEntry,b
        sta $0580,b
        rts

        .databank 0

        ; 85/E47F

    .endsection Unsorted85E44ESection


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
