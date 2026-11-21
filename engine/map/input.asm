; Handling controller input on the map.

    .section MapInputHandlerSection

      .al
      .xl

      rsMapInputHandler ; 88/AFB6

        .al
        .autsiz
        .databank ?

        lda wMusicID,b
        bne _End

        lda wJoy1New
        bit #JOY_A
        bne _APressed

        bit #JOY_B
        bne _BPressed

        bit #JOY_Select
        bne _SelectPressed

        bit #JOY_X
        bne _XPressed

        bit #JOY_Start
        bne _StartPressed

        bit #JOY_R
        bne _RPressed

        bit #JOY_L
        bne _LPressed
        
        _End
        rts
        
        _APressed
        jsr rsUnknown88B028
        rts
        
        _SelectPressed
        lda wUnknown000770,b
        beq +

          rts

        +
        jsr rsUnknown88B10B
        rts
        
        _BPressed
        lda wUnknown000770,b
        beq +

          jsr rsUnknown88B133

        +
        rts
        
        _XPressed
        jsr rsUnknown88B1C2
        rts
        
        _StartPressed
        jsr rsUnknown88B20C
        rts
        
        _RPressed
        lda wUnknown000770,b
        beq +

          rts

        +
        lda wJoy1Input
        cmp #(JOY_L | JOY_R)
        beq +

        lda #5
        jsl rlPlaySoundEffect

        lda #0
        sta $0790,b
        jsr rsUnknown88B51A
        rts
        
        _LPressed
        lda wUnknown000770,b
        beq +

          rts

        +
        jsr rsUnknown88C1BF
        rts

        .databank 0

        ; 88/B028

    .endsection MapInputHandlerSection


    .section Unsorted8583DASection

      .al
      .xl

      rlUnknown8583DA ; 85/83DA

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0009
        jsl rlPlaySoundEffect
        lda aProcSystem.aHeaderTypeOffset,b,x
        tay
        jsl rlLoadMapMenuDataFromProc
        jsl rlUnknown8584AC
        jsl rlUnknown85856E
        lda #<>rlUnknown8583F8
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/83F8

    .endsection Unsorted8583DASection


    .section ProcScript85DDDBSection

      .al
      .xl

      procUnknown85DDDB ; 85/DDDB

        .structProcInfo "PM", rlProcUnknown85DDDBInit, rlProcUnknown85DDDBCycle, aProcUnknown85DDDBCode


        .long aUnknown85DCEB
        .byte 1
        .long aUnknown85DD92

      procUnknown85DDEA ; 85/DDEA

        .structProcInfo "PM", rlProcUnknown85DDDBInit, rlProcUnknown85DDDBCycle, aProcUnknown85DDDBCode
        .long aUnknown85DD00
        .byte 1
        .long aUnknown85DDB9

    .endsection ProcScript85DDDBSection


    .section Unsorted85DDF9Section

      .al
      .xl

      rlProcUnknown85DDDBInit ; 85/DDF9

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown000D79,b
        bit #$1000
        beq _DE07
        lda #$DDEA
        sta aProcSystem.aHeaderTypeOffset,b,x

        _DE07
        jsl rlUnknown8583C2
        lda #$0000
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        rtl

        .databank 0

        ; 85/DE13

      rlProcUnknown85DDDBCycle ; 85/DE13

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aBGPaletteBuffer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$20FF
        sta wUnknown053C,b
        jsl rlUnknown8583DA
        jsl rlUnknown8584DC
        lda #<>rlUnknown85DE34
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/DE34

    .endsection Unsorted85DDF9Section


    .section Unsorted88B028Section

      .al
      .xl

      rsUnknown88B028 ; 88/B028

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown000770,b
        bne _B03F
        jsr rsUnknown88B701
        bcs _B037
        lda wUnknown000770,b
        beq _B06F

        _B037
        lda #$0008
        jsl rlPlaySoundEffect
        rts


        _B03F
        lda wUnknown000D79,b
        bit #$0800
        bne _B079
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        cmp wActiveFactionSlot,b
        bne _B081
        jsr rsUnknown88B8E9
        bcs _B067
        lda #$000A
        jsl rlPlaySoundEffect
        rts


        _B067
        lda #$0022
        jsl rlPlaySoundEffect
        rts


        _B06F
        jsl rlUnknown88B249
        bcc _B080
        jsr rsUnknown88B10B
        rts


        _B079
        jsr rsUnknown88B096
        rts

        .byte $20, $33, $B1


        _B080
        rts


        _B081
        lda #$0021
        jsl rlPlaySoundEffect
        stz $07DA,b
        ldx wActiveUnitDeploymentOffset,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        jsr rsUnknown88BBD3
        rts

        .databank 0

        ; 88/B096

      rsUnknown88B096 ; 88/B096

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta wUnknown0007D8,b
        stz $07DA,b
        jsr rsUnknown88BBD3
        lda wActiveUnitDeploymentOffset,b
        sta wR0
        lda $0774,b
        sta wR1
        lda $077C,b
        sta $0778,b
        lda $077E,b
        sta $077A,b
        lda wActiveUnitDeploymentOffset,b
        tax
        lda aDeploymentTable._XTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wCursorXOffset,b
        lda aDeploymentTable._YTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wCursorYOffset,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR2
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR3
        jsl rlUnknown84DC1C
        lda #$0800
        trb wUnknown000D79,b
        rts

        .databank 0

        ; 88/B10B

      rsUnknown88B10B ; 88/B10B

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda #$0009
        jsl rlPlaySoundEffect
        lda #(`procUnknown85DDDB)<<8
        sta lR44+1
        lda #<>procUnknown85DDDB
        sta lR44
        jsl rlProcEngineCreateProc
        lda #$0008
        tsb $0788,b
        rts

        .databank 0

        ; 88/B133

      rsUnknown88B133 ; 88/B133

        .al
        .xl
        .autsiz
        .databank ?

        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable,x
        bit #$0010
        bne _B183
        lda wUnknown000D79,b
        bit #$0800
        bne _B198
        lda #$0021
        jsl rlPlaySoundEffect
        stz $07DA,b
        lda wActiveUnitDeploymentOffset,b
        jsl rlUnknown88B4DB
        jsl rlDeployedUnitUnsetHiddenIfAlive
        jsr rsUnknown88BBD3
        lda $07E0,b
        cmp #$0001
        beq _B16D
        cmp #$0002
        beq _B178
        rts


        _B16D
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown84CC5D
        stz $07E0,b
        rts


        _B178
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnknown84CFBF
        stz $07E0,b
        rts


        _B183
        stz $07DA,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        lda wActiveUnitDeploymentOffset,b
        jsl rlUnknown88B4DB
        lda #$0007
        sta wUnknown0007D8,b
        rts


        _B198
        lda $077C,b
        sta $0778,b
        lda $077E,b
        sta $077A,b
        lda #$0005
        jsl rlPlaySoundEffect
        jsr rsUnknown88BBD3
        stz wUnknown0007D8,b
        jsl rlUnknown85E85D
        lda #$0008
        tsb $0788,b
        lda #$0800
        trb wUnknown000D79,b
        rts

        .databank 0

        ; 88/B1C2

      rsUnknown88B1C2 ; 88/B1C2

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnknown000770,b
        bne _B1D0
        lda wUnknown000766,b
        beq _B1D1

        _B1CC
        jsl rlUnknown88B249

        _B1D0
        rts


        _B1D1
        jsl rlUnknown88B813
        bcc _B1CC
        stx wActiveUnitDeploymentOffset,b
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        lda #$0008
        jsl rlPlaySoundEffect
        jsl rlUnknown88B3AF
        lda #$B122
        sta $7F8183
        lda #$0000
        sta $7F819D
        lda #$000A
        sta wGameStateStep,b
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

        ; 88/B20C

      rsUnknown88B20C ; 88/B20C

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        cmp #$1000
        bne _B248
        lda wUnknown000770,b
        bne _B248
        lda $0788,b
        bit #$0020
        bne _B241
        lda #$0020
        tsb $0788,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda #(`procUnknown889396)<<8
        sta lR44+1
        lda #<>procUnknown889396
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _B241
        lda #$0020
        trb $0788,b
        rts


        _B248
        rts

        .databank 0

        ; 88/B249

      rlUnknown88B249 ; 88/B249

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
        jsl rlUnknown87EA09
        bcs _B2A3
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeCastle
        bne _B2A3
        jsl rlGetLocationFactionSlotOwner
        bmi _B2A3
        cmp #$0000
        bne _B2A3
        jsl rlGetEventLocationEntryID
        sta $089F,b
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp $089F,b
        bne _B2A3
        lda #$FFFF
        sta $089B,b
        lda #$0009
        jsl rlPlaySoundEffect
        jml rlUnknown88B2A5._B316

        .byte $18, $6B


        _B2A3
        sec
        rtl

        .databank 0

        ; 88/B2A5

      rlUnknown88B2A5 ; 88/B2A5

        .al
        .xl
        .autsiz
        .databank ?

        lda aDeploymentTable._XTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wCursorXOffset,b
        lda aDeploymentTable._YTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wCursorYOffset,b
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
        jsl rlCheckIfCoordsNotEventLocationTile
        bcs _B30B
        jsl rlGetEventLocationEntryType
        cmp #$0001
        beq _B305
        jsl rlGetEventLocationEntryID
        sta $089F,b
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp $089F,b
        bne _B305
        jml _B316

        .byte $18, $6B


        _B305
        jml rlUnknown88B339

        .byte $18, $6B


        _B30B
        sec
        rtl

        .byte $22, $8D, $E9, $87, $5C, $16, $B3, $88, $6B


        _B316
        jsl rlUnknown88B3AF
        lda #$0000
        sta $088B,b
        jsl rlBuildDeadPlayerCharacterList
        lda #$B6B6
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 88/B339

      rlUnknown88B339 ; 88/B339

        .al
        .xl
        .autsiz
        .databank ?

        lda #$00F0
        jsl rlSendSoundCommand
        lda #$00E0
        jsl rlQueueSoundCommand
        jsl rlUnknown88B3AF
        lda #$0001
        sta $088B,b
        lda #$B6B6
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 88/B366

    .endsection Unsorted88B028Section


    .section Unsorted88B51ASection

      .al
      .xl

      rsUnknown88B51A ; 88/B51A

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
        sta wTempVariable1,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wTempVariable2,b
        ldy #$0090
        jsr rsUnknown88B5CA
        bcs _B561
        lda $0790,b
        bne _B54F
        ldx $0784,b
        dec x
        dec x
        bpl _B55C
        ldx #$008E
        bra _B55C


        _B54F
        ldx $0784,b
        inc x
        inc x
        cpx #$0090
        bcc _B55C
        ldx #$0000

        _B55C
        jsr rsUnknown88B5DD
        bcs _B5C9

        _B561
        lda aDeploymentTable,x
        beq _B5A7
        bit #$0008
        bne _B5A7
        bit #$2000
        bne _B5A7
        bit #$0080
        beq _B5A7
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        cmp wActiveFactionSlot,b
        bne _B5A7
        lda aDeploymentTable._XTilePosition,x
        sec
        sbc wTempVariable1,b
        sta $0778,b
        lda aDeploymentTable._YTilePosition,x
        sec
        sbc wTempVariable2,b
        sta $077A,b
        lda #$0004
        sta wUnknown0007D8,b
        stx $0784,b
        bra _B5C9


        _B5A7
        lda $0790,b
        bne _B5B5
        dec x
        dec x
        bpl _B5BF
        ldx #$008E
        bra _B5BF


        _B5B5
        inc x
        inc x
        cpx #$0090
        bcc _B5BF
        ldx #$0000

        _B5BF
        dec y
        dec y
        bpl _B55C
        stz $0778,b
        stz $077A,b

        _B5C9
        rts

        .databank 0

        ; 88/B5CA

      rsUnknown88B5CA ; 88/B5CA

        .al
        .xl
        .autsiz
        .databank ?

        lda $0784,b
        cmp #$FFFF
        beq _B5D4
        clc
        rts


        _B5D4
        lda #$0000
        sta $0784,b
        tax
        sec
        rts

        .databank 0

        ; 88/B5DD

      rsUnknown88B5DD ; 88/B5DD

        .al
        .xl
        .autsiz
        .databank ?

        lda $0784,b
        cmp #$FFFF
        bne _B5E7
        clc
        rts


        _B5E7
        txa
        cmp #$0000
        bne _B625
        lda #$0000
        jsl rlGetFactionSlotLocationID
        jsl rlGetLocationEventDataEntry
        jsl rlBuildDeadPlayerCharacterList
        jsr rsUnknown88B627
        bcc _B625
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        sec
        sbc wTempVariable1,b
        sta $0778,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        sec
        sbc wTempVariable2,b
        sta $077A,b
        lda #$0004
        sta wUnknown0007D8,b
        lda #$FFFF
        sta $0784,b
        sec
        rts


        _B625
        clc
        rts

        .databank 0

        ; 88/B627

      rsUnknown88B627 ; 88/B627

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$002E

        _B62B
        lda aDeadPlayerCharacterList,x
        cmp #$FFFF
        beq _B648
        phx
        tax
        lda aDeploymentTable,x
        plx
        bit #$0008
        bne _B648
        bit #$2000
        bne _B648
        plx
        sec
        rts


        _B648
        dec x
        dec x
        bpl _B62B
        plx
        clc
        rts

        .databank 0

        ; 88/B64F

    .endsection Unsorted88B51ASection


