; Code from bank $89 not yet assigned to a game system.


    .section Unsorted898000Section

      .al
      .xl

      rlUnitScreenRender ; 89/8000

        .al
        .xl
        .autsiz
        .databank ?

        ; GameState $07: render Unit Status screen OAM arrows

        jsr rsUnknown8994B8
        rtl

        .databank 0

        ; 89/8004

      rlUnitScreenShow ; 89/8004

        .al
        .xl
        .autsiz
        .databank ?

        ; GameState $08: initialize and show Unit Status screen

        jsl rlUnknown88DBEE
        lda $7F819D
        cmp #$1234
        beq _803A
        cmp #$4321
        beq _8046
        cmp #$1111
        beq _8064
        lda $7F8183
        cmp #$C3E6
        beq _8092
        cmp #$DFDC
        beq _809E
        cmp #$B6B6
        beq _8086
        lda #$000F
        sta $7F819F
        lda #$0000
        bra _80A8


        _803A
        lda #$0003
        sta $7F819F
        lda #$0009
        bra _80A8


        _8046
        lda #$0003
        sta $7F819F
        lda #$0087
        sta $7F8187
        sta wBufferBG3VOFS
        sta wBufferBG2VOFS
        lda #$0001
        sta $7F81A1
        lda #$0009
        bra _80A8


        _8064
        lda #$0003
        sta $7F819F
        lda #$0110
        sta wBufferBG3VOFS
        lda #$00AC
        sta wBufferBG1VOFS
        lda #$0110
        sta wBufferBG2VOFS
        lda #$0002
        sta $7F81A1
        lda #$0009
        bra _80A8


        _8086
        lda #$0001
        sta $7F819F
        lda #$0009
        bra _80A8


        _8092
        lda #$0005
        sta $7F819F
        lda #$0009
        bra _80A8


        _809E
        lda #$0001
        sta $7F819F
        lda #$0009

        _80A8
        sta wGameStateStep,b
        lda $7F819F
        sep #$20
        sta bBufferINIDISP
        rep #$20
        lda #$0000
        sta $7F819D
        inc wGameStateRoutine1,b
        jsl rlUnknown899200
        lda $7F81A1
        cmp #$0002
        beq _80DC
        jsr rsUnknown8989AD
        jsr rsUnknown898AF5
        jsr rsUnknown898B3B
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rtl


        _80DC
        jsr rsUnknown898D55
        rtl

        .databank 0

        ; 89/80E0

      rlUnitScreenRunStep ; 89/80E0

        .al
        .xl
        .autsiz
        .databank ?

        ; GameState $09: run Unit Status screen step handler

        phb
        php
        phk
        plb
        .databank $89
        lda wGameStateStep,b
        asl a
        tax
        jsr (aUnknown8980EF,x)
        plp
        plb
        .databank $89
        rtl

        .databank 0

        ; 89/80EF

    .endsection Unsorted898000Section


    .section Table8980EFSection

      .al
      .xl

      aUnknown8980EF ; 89/80EF

        ; Jump table of rlUnitScreenRunStep.
        .word <>rsUnknown898105
        .word <>rsUnknown89831F
        .word <>rsUnknown89861B
        .word <>rsUnknown898690
        .word <>rsUnknown898734
        .word <>rsUnknown898536
        .word <>rsUnknown898755
        .word <>rsUnknown898768
        .word <>rsUnknown89A25A
        .word <>rsUnknown89A2ED
        .word <>rsUnknown89A32E

    .endsection Table8980EFSection


    .section Unsorted898105Section

      .al
      .xl

      rsUnknown898105 ; 89/8105

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8989AD
        jsr rsUnknown898AF5
        lda $7F8187
        bne _813A
        lda wJoy1New
        bmi _8132
        bit #$0040
        bne _8136
        bit #$0400
        bne _813A
        bit #$0080
        bne _8146
        bit #$0010
        bne _813E
        bit #$0020
        bne _8142
        jsr rsUnknown898B3B
        rts


        _8132
        jml _814A


        _8136
        jml _8246


        _813A
        jml _82DC


        _813E
        jml _830C


        _8142
        jml _8311


        _8146
        jml _8271


        _814A
        lda #$0021
        jsl rlPlaySoundEffect
        jsr rsUnknown898B3B
        lda $7F8183
        cmp #$C3E6
        beq _81A5
        cmp #$DFDC
        beq _81DC
        lda $7F81AD
        beq _816C
        jml _8217


        _816C
        lda wUnknown000D79,b
        bit #$0020
        bne _8183

        _8174
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0006
        sta wGameStateStep,b
        rts


        _8183
        lda #$0001
        sta $7F819F
        sep #$20
        lda #$0F
        sec
        sbc $7F819F
        sta bBufferINIDISP
        rep #$20
        lda #$000A
        sta wGameStateStep,b
        lda #$0007
        sta $7F81A1
        rts


        _81A5
        lda #$BBD9
        sta $7F82C5
        lda #$0000
        sta $7F8183
        lda #$C3E6
        sta $7F81A3
        lda #$0005
        sta $7F819F
        sep #$20
        lda #$0F
        sec
        sbc $7F819F
        sta bBufferINIDISP
        rep #$20
        lda #$000A
        sta wGameStateStep,b
        lda #$0004
        sta $7F81A1
        rts


        _81DC
        sep #$20
        lda bBufferNMITIMEN
        and #$FE
        sta bBufferNMITIMEN
        rep #$20
        lda $7F8471
        sta $7F82C9
        lda #$DFDC
        sta $7F81A3
        lda #$0001
        sta $7F819F
        sep #$20
        lda #$0F
        sec
        sbc $7F819F
        sta bBufferINIDISP
        rep #$20
        lda #$000A
        sta wGameStateStep,b
        lda #$0004
        sta $7F81A1
        rts


        _8217
        lda $7F81D1
        beq _8221
        jml _816C


        _8221
        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        beq _823A
        jsl rlGetSelectedUnitDeploymentOffset
        sta @l wActiveUnitDeploymentOffset
        jsl rlUnknown8881D7
        jml _8174


        _823A
        jsl rlGetSelectedUnitDeploymentOffset
        sta @l wActiveUnitDeploymentOffset
        jml _8183


        _8246
        lda #$0001
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _826D
        lda #$0003
        sta wGameStateStep,b
        lda #$0001
        sta $7F8185
        jsl rlUnknown89876D
        stz wUnknown000885,b
        lda #$000A
        jsl rlPlaySoundEffect

        _826D
        jsr rsUnknown898B3B
        rts


        _8271
        lda #$000A
        jsl rlPlaySoundEffect
        lda $7F818F
        bne _82AB
        sta $7F8191
        lda #$0001
        sta $7F818F
        lda #$0005
        sta wGameStateStep,b
        jsr rsUnknown898B3B
        lda #(`gcUnknownDD0000)<<8
        sta lR18+1
        lda #<>gcUnknownDD0000
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$9B88
        sta lR19
        jsl rlAppendDecompList
        rts


        _82AB
        lda #$0002
        sta wGameStateStep,b
        jsl rlUnknown899200
        lda #$0110
        sta wBufferBG3VOFS
        lda #$00AC
        sta wBufferBG1VOFS
        lda wBufferBG2VOFS
        sta $7F8189
        lda #$0110
        sta wBufferBG2VOFS
        ldx #$0020

        _82CD
        lda aUnknownDE2CA0-2,x
        sta $02DE,b,x
        dec x
        dec x
        bne _82CD
        jsr rsUnknown898D55
        rts


        _82DC
        lda $7F8187
        clc
        adc #$0007
        cmp #$0088
        bmi _82F3
        lda #$0001
        sta @l wGameStateStep
        lda #$0087

        _82F3
        sta $7F8187
        sta wBufferBG3VOFS
        sta wBufferBG2VOFS
        lda #$0011
        jsl rlPlaySoundEffect
        jsr rsUnknown898B3B
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rts


        _830C
        jsr rlUnknown89A5E5
        bra _8314


        _8311
        jsr rsUnknown89A68C

        _8314
        jsr rsUnknown898B3B
        lda #$1234
        sta $7F819D
        rts

        .databank 0

        ; 89/831F

      rsUnknown89831F ; 89/831F

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8989AD
        jsr rsUnknown898AF5
        lda $7F8187
        cmp #$0087
        bne _8356
        lda wJoy1New
        bmi _8366
        bit #$0080
        bne _8352
        bit #$0800
        bne _8356
        bit #$0040
        bne _835A
        bit #$0010
        bne _835E
        bit #$0020
        bne _8362
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rts


        _8352
        jml _8465


        _8356
        jml _84D3


        _835A
        jml _84FC


        _835E
        jml _8520


        _8362
        jml _8525


        _8366
        lda #$0021
        jsl rlPlaySoundEffect
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        lda $7F8183
        cmp #$C3E6
        beq _83C4
        cmp #$DFDC
        beq _83FB
        lda $7F81AD
        beq _838B
        jml _8436


        _838B
        lda wUnknown000D79,b
        bit #$0020
        bne _83A2

        _8393
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0006
        sta wGameStateStep,b
        rts


        _83A2
        lda #$0001
        sta $7F819F
        sep #$20
        lda #$0F
        sec
        sbc $7F819F
        sta bBufferINIDISP
        rep #$20
        lda #$000A
        sta wGameStateStep,b
        lda #$0007
        sta $7F81A1
        rts


        _83C4
        lda #$BBD9
        sta $7F82C5
        lda #$0000
        sta $7F8183
        lda #$C3E6
        sta $7F81A3
        lda #$0005
        sta $7F819F
        sep #$20
        lda #$0F
        sec
        sbc $7F819F
        sta bBufferINIDISP
        rep #$20
        lda #$000A
        sta wGameStateStep,b
        lda #$0004
        sta $7F81A1
        rts


        _83FB
        sep #$20
        lda bBufferNMITIMEN
        and #$FE
        sta bBufferNMITIMEN
        rep #$20
        lda $7F8471
        sta $7F82C9
        lda #$DFDC
        sta $7F81A3
        lda #$0001
        sta $7F819F
        sep #$20
        lda #$0F
        sec
        sbc $7F819F
        sta bBufferINIDISP
        rep #$20
        lda #$000A
        sta wGameStateStep,b
        lda #$0004
        sta $7F81A1
        rts


        _8436
        lda $7F81D1
        beq _8440
        jml _838B


        _8440
        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        beq _8459
        jsl rlGetSelectedUnitDeploymentOffset
        sta @l wActiveUnitDeploymentOffset
        jsl rlUnknown8881D7
        jml _8393


        _8459
        jsl rlGetSelectedUnitDeploymentOffset
        sta @l wActiveUnitDeploymentOffset
        jml _83A2


        _8465
        lda #$000A
        jsl rlPlaySoundEffect
        lda $7F818F
        bne _84A2
        sta $7F8191
        lda #$0001
        sta $7F818F
        lda #$0005
        sta wGameStateStep,b
        lda #(`gcUnknownDD0000)<<8
        sta lR18+1
        lda #<>gcUnknownDD0000
        sta lR18
        lda #$7E00
        sta lR19+1
        lda #$9B88
        sta lR19
        jsl rlAppendDecompList
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rts


        _84A2
        lda #$0002
        sta wGameStateStep,b
        jsl rlUnknown899200
        lda #$0110
        sta wBufferBG3VOFS
        lda #$00AC
        sta wBufferBG1VOFS
        lda wBufferBG2VOFS
        sta $7F8189
        lda #$0110
        sta wBufferBG2VOFS
        ldx #$0020

        _84C4
        lda aUnknownDE2CA0-2,x
        sta $02DE,b,x
        dec x
        dec x
        bne _84C4
        jsr rsUnknown898D55
        rts


        _84D3
        lda $7F8187
        sec
        sbc #$0007
        bpl _84E3
        dec wGameStateStep,b
        lda #$0000

        _84E3
        sta $7F8187
        sta wBufferBG3VOFS
        sta wBufferBG2VOFS
        lda #$0012
        jsl rlPlaySoundEffect
        jsr rsUnknown898B3B
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rts


        _84FC
        lda $7F81B1
        beq _8519
        lda #$0000
        sta $7F81CF
        lda #$000A
        jsl rlPlaySoundEffect
        jsr rsUnknown89A3C0
        lda #$0008
        sta wGameStateStep,b

        _8519
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rts


        _8520
        jsr rlUnknown89A5E5
        bra _8528


        _8525
        jsr rsUnknown89A68C

        _8528
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        lda #$4321
        sta $7F819D
        rts

        .databank 0

        ; 89/8536

    .endsection Unsorted898105Section


    .section Unsorted898536Section

      .al
      .xl

      rsUnknown898536 ; 89/8536

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8989AD
        jsr rsUnknown898AF5
        lda bDecompressionArrayFlag,b
        beq _854B
        jsr rsUnknown898B3B
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rts


        _854B
        lda $7F8191
        cmp #$0005
        beq _856A
        cmp #$0004
        beq _85C6
        cmp #$0003
        beq _85B0
        cmp #$0002
        beq _859A
        cmp #$0001
        beq _8584
        bra _856E


        _856A
        jml _85E4


        _856E
        jsl rlDMAByStruct

          .structDMAToVRAM $7E9B88, $0800, $80, $0000

        lda #$0001
        sta $7F8191
        bra _85DA


        _8584
        jsl rlDMAByStruct

          .structDMAToVRAM $7EA388, $0800, $80, $0800

        lda #$0002
        sta $7F8191
        bra _85DA


        _859A
        jsl rlDMAByStruct

          .structDMAToVRAM $7EAB88, $0800, $80, $1000

        lda #$0003
        sta $7F8191
        bra _85DA


        _85B0
        jsl rlDMAByStruct

          .structDMAToVRAM $7EB388, $0800, $80, $1800

        lda #$0004
        sta $7F8191
        bra _85DA


        _85C6
        jsl rlDMAByStruct

          .structDMAToVRAM $7EBB88, $0600, $80, $2000

        lda #$0005
        sta $7F8191

        _85DA
        jsr rsUnknown898B3B
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rts


        _85E4
        ldx #$0020

        _85E7
        lda aUnknownDE2CA0-2,x
        sta $02DE,b,x
        dec x
        dec x
        bne _85E7
        jsr rsUnknown898D55
        jsr rsUnknown8989AD
        jsr rsUnknown898AF5
        lda #$0002
        sta wGameStateStep,b
        jsl rlUnknown899200
        lda #$0110
        sta wBufferBG3VOFS
        lda #$00AC
        sta wBufferBG1VOFS
        lda wBufferBG2VOFS
        sta $7F8189
        lda #$0110
        sta wBufferBG2VOFS
        rts

        .databank 0

        ; 89/861B

    .endsection Unsorted898536Section


    .section Unsorted89861BSection

      .al
      .xl

      rsUnknown89861B ; 89/861B

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8989AD
        jsr rsUnknown898AF5
        lda wJoy1New
        bit #$8000
        bne _863E
        bit #$0010
        bne _8636
        bit #$0020
        bne _863A
        jsr rsUnknown898D55
        rts


        _8636
        jml _867D


        _863A
        jml _8682


        _863E
        ldx #$0020

        _8641
        lda aWindowPalette+190,x
        sta $02DE,b,x
        dec x
        dec x
        bne _8641
        ldx #$0000
        lda $7F8187
        beq _8656
        inc x

        _8656
        txa
        sta wGameStateStep,b
        stz wBufferBG1VOFS
        jsl rlUnknown899200
        lda $7F8189
        sta wBufferBG2VOFS
        lda $7F8187
        sta wBufferBG3VOFS
        jsr rsUnknown898B3B
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _867D
        jsr rlUnknown89A5E5
        bra _8685


        _8682
        jsr rsUnknown89A68C

        _8685
        jsr rsUnknown898D55
        lda #$1111
        sta $7F819D
        rts

        .databank 0

        ; 89/8690

      rsUnknown898690 ; 89/8690

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8989AD
        jsr rsUnknown898AF5
        jsr rsUnknown898B3B
        jsr rsUnknown898B97
        lda wJoy1Repeated
        bmi _8704
        bit #$0800
        bne _86AE
        bit #$0400
        bne _86D9
        jsr rsUnknown8989CE
        rts


        _86AE
        lda $7F8185
        cmp #$0001
        beq _86D5
        lda wUnknown000885,b
        sec
        sbc #$0010
        sta wUnknown000885,b
        lda $7F8185
        dec a
        sta $7F8185
        jsl rlUnknown89876D
        lda #$0006
        jsl rlPlaySoundEffect

        _86D5
        jsr rsUnknown8989CE
        rts


        _86D9
        lda $7F8185
        cmp wCastleListSubCount,b
        beq _8700
        lda wUnknown000885,b
        clc
        adc #$0010
        sta wUnknown000885,b
        lda $7F8185
        inc a
        sta $7F8185
        jsl rlUnknown89876D
        lda #$0006
        jsl rlPlaySoundEffect

        _8700
        jsr rsUnknown8989CE
        rts


        _8704
        ldx #$02C0
        lda #$0010
        ldy #$0011
        jsl rlClearTilemapRect
        jsl rlUnknown899C7C
        jsl rlUnknown89970D
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8648, $0400, $80, $B2C0

        lda #$0000
        sta wGameStateStep,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 89/8734

    .endsection Unsorted89861BSection


    .section Unsorted898734Section

      .al
      .xl

      rsUnknown898734 ; 89/8734

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F81A3
        sta wMainLoopPointer
        jsr rsUnknown8989AD
        jsr rsUnknown898AF5
        lda wBufferBG2VOFS
        cmp #$0110
        beq _8751
        jsr rsUnknown898B3B
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rts


        _8751
        jsr rsUnknown898D55
        rts

        .databank 0

        ; 89/8755

    .endsection Unsorted898734Section


    .section Unsorted898755Section

      .al
      .xl

      rsUnknown898755 ; 89/8755

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wMainGameMode,b
        lda #<>rsUnknown80B122
        sta wMainLoopPointer
        lda #$00E8
        jsl rlQueueSoundCommand
        rts

        .databank 0

        ; 89/8768

    .endsection Unsorted898755Section


    .section Unsorted898768Section

      .al
      .xl

      rsUnknown898768 ; 89/8768

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlReturnToCastleScreen
        rts

        .databank 0

        ; 89/876D

    .endsection Unsorted898768Section


    .section Unsorted89876DSection

      .al
      .xl

      rlUnknown89876D ; 89/876D

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$02C0
        lda #$0010
        ldy #$0010
        jsl rlClearTilemapRect
        lda $7F8185
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _87B5
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetItemNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        ldx #$0B04
        jsl rlDrawMenuTextLine
        lda #$3400
        sta aCurrentTilemapInfo,b
        jsl rlGetItemEquipmentType
        cmp #$0000
        bne _87B6
        jml _8811


        _87B5
        rtl


        _87B6
        cmp #$0001
        beq _87CC
        jsr rsUnknown89936E
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8648, $0400, $80, $B2C0

        rtl


        _87CC
        lda $7F8193
        bne _87EB
        lda $7F8185
        jsl rlGetItemDurabilityOfInventorySlot
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$02D8
        jsl rlDrawMenuTextNumber

        _87EB
        jsl rlGetItemWeaponRank
        cmp #$FFFF
        bne _87F7
        lda #$0004

        _87F7
        ldx #$0005
        ldy #$000D
        jsr rsUnknown89A5AA
        jsr rsUnknown89936E
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8648, $0400, $80, $B2C0

        rtl


        _8811
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown898973)<<8
        sta lR18+1
        lda #<>aUnknown898973
        sta lR18
        ldx #$0F03
        jsl rlDrawMenuTextLine
        lda #(`aUnknown89897F)<<8
        sta lR18+1
        lda #<>aUnknown89897F
        sta lR18
        ldx #$1104
        jsl rlDrawMenuTextLine
        lda #(`aUnknown898989)<<8
        sta lR18+1
        lda #<>aUnknown898989
        sta lR18
        ldx #$1304
        jsl rlDrawMenuTextLine
        lda #(`aUnknown898993)<<8
        sta lR18+1
        lda #<>aUnknown898993
        sta lR18
        ldx #$1505
        jsl rlDrawMenuTextLine
        jsl rlGetItemWeaponRank
        cmp #$FFFF
        bne _8867
        lda #$0004

        _8867
        ldx #$0005
        ldy #$000D
        jsr rsUnknown89A5AA
        lda $7F8193
        bne _888F
        lda $7F8185
        jsl rlGetItemDurabilityOfInventorySlot
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$02D8
        jsl rlDrawMenuTextNumber

        _888F
        jsl rlGetItemAccuracy
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$03D2
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMight
        cmp #$00FF
        beq _88C0
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0452
        jsl rlDrawMenuTextNumber
        bra _88DD


        _88C0
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown8989A7)<<8
        sta lR18+1
        lda #<>aUnknown8989A7
        sta lR18
        ldx #$1109
        jsl rlDrawMenuTextLine
        lda #$3400
        sta aCurrentTilemapInfo,b

        _88DD
        lda wSelectedInventorySlot,b
        sta $7F81AF
        lda $7F8185
        sta wSelectedInventorySlot,b
        jsl rlGetSelectedItemRange
        lda wR11
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$04D6
        jsl rlDrawMenuTextNumber
        lda $7F81AF
        sta wSelectedInventorySlot,b
        lda wR10
        ldx #$3920
        stx wR5
        ldx #$0001
        stx wR6
        ldx #$04D2
        jsl rlDrawMenuTextNumber
        lda #$3800
        sta wR1
        lda #$02A0
        sta wR2
        lda #$0001
        sta wR0
        ldx #$04D4
        jsl rlDrawBG3TileRun
        jsl rlGetItemWeight
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0552
        jsl rlDrawMenuTextNumber
        lda $7F8193
        bne _8962
        jsl rlGetItemRAMKillCountAndCritAbility
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0352
        jsl rlDrawMenuTextNumber

        _8962
        jsr rsUnknown899454
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8648, $0400, $80, $B2C0

        rtl

        .databank 0

        ; 89/8973

    .endsection Unsorted89876DSection


    .section Table898973Section

      .al
      .xl

      aUnknown898973 ; 89/8973

        .enc "SJIS"
        .text "めいちゅう"
        .word $0000
        .enc "none"

      aUnknown89897F ; 89/897F

        .enc "SJIS"
        .text "いりょく"
        .word $0000
        .enc "none"

      aUnknown898989 ; 89/8989

        .enc "SJIS"
        .text "しゃてい"
        .word $0000
        .enc "none"

      aUnknown898993 ; 89/8993

        .enc "SJIS"
        .text "おもさ"
        .word $0000
        .enc "none"

      aUnknown89899B ; 89/899B

        .enc "SJIS"
        .text "のこり"
        .word $0000
        .enc "none"

      aUnknown8989A3 ; 89/89A3

        .enc "SJIS"
        .text "Ｇ"
        .word $0000
        .enc "none"

      aUnknown8989A7 ; 89/89A7

        .enc "SJIS"
        .text "ーー"
        .word $0000
        .enc "none"


    .endsection Table898973Section






    .section Unsorted8989ADSection

      .al
      .xl

      rsUnknown8989AD ; 89/89AD

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        lda #$0062
        sta wR0
        lda #$000C
        sta wR1
        stz wR4
        stz wR5
        ldy #<>aUnknown89A72E
        jsl rlPushToOAMBuffer
        jsr rsUnknown8989EA
        rts

        .databank 0

        ; 89/89CE

    .endsection Unsorted8989ADSection


    .section Unsorted8989CESection

      .al
      .xl

      rsUnknown8989CE ; 89/89CE

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $89
        lda #$0076
        sta wR0
        lda wUnknown000885,b
        clc
        adc #$006A
        sta wR1
        lda #$0000
        jsl rlUnknown88A704
        plp
        plb
        .databank $89
        rts

        .databank 0

        ; 89/89EA

    .endsection Unsorted8989CESection


    .section Unsorted8989EASection

      .al
      .xl

      rsUnknown8989EA ; 89/89EA

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $89
        jsr rsUnknown898A41
        lda $7F81D1
        cmp #$0008
        beq _89FE
        jsl rlUnknown88DBEE

        _89FE
        phk
        plb
        .databank $89
        lda #$000B
        sta wR0
        lda #$0016
        sta wR1
        stz wR4
        stz wR5
        ldx wActiveUnitDeploymentOffset,b
        jsl rlGetSelectedUnitMapSprite
        and #$8000
        bne _8A1F
        ldy #$8A29
        bra _8A22


        _8A1F
        ldy #$8A30

        _8A22
        jsl rlPushToOAMBuffer
        plp
        plb
        .databank $89
        rts

        .databank 0

        ; 89/8A29


      aUnknown898A29 ; 89/8A29

        _Sprites := [[(   4,    4), $21, SpriteLarge, $0E0, 3, 1, false, false]]

        .structSpriteArray aUnknown898A29._Sprites

      aUnknown898A30 ; 89/8A30

        _Sprites := [[(   4,    6), $21, SpriteLarge, $0E0, 3, 1, false, false]]
        _Sprites ..= [[(   4,   -2), $00, SpriteSmall, $0F2, 3, 1, false, false]]
        _Sprites ..= [[(  12,   -2), $00, SpriteSmall, $0F3, 3, 1, false, false]]

        .structSpriteArray aUnknown898A30._Sprites

    .endsection Unsorted8989EASection


    .section Unsorted898A41Section

      .al
      .xl

      rsUnknown898A41 ; 89/8A41

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F819B
        cmp #$0001
        bne _8A60
        lda wVBlankEnabledFramecount
        and #$0018
        beq _8A60
        stz wR0
        stz wR1
        stz wR4
        stz wR5
        ldy #$8A6D
        jsl rlPushToOAMBuffer

        _8A60
        rts

        .databank 0

        ; 89/8A61

    .endsection Unsorted898A41Section


    .section Unsorted898A7ESection

      .al
      .xl

      rsUnknown898A7E ; 89/8A7E

        .al
        .xl
        .autsiz
        .databank ?

        lda wGameStateStep,b
        cmp #$0008
        beq _8A9A
        lda $7F8199
        bne _8A9A
        lda $7F8197
        ldx #$003F
        ldy #$00F3
        jsl rlUnknown899FA1

        _8A9A
        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        ldy #$8AC1
        lda #$007E
        sta wR0
        lda #$00F1
        sec
        sbc wBufferBG3VOFS
        sta wR1
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/8AC1


      aUnknown898AC1 ; 89/8AC1

        _Sprites := [[(   1,    0), $21, SpriteLarge, $100, 2, 6, false, false]]
        _Sprites ..= [[(   1,   16), $21, SpriteLarge, $102, 2, 6, false, false]]
        _Sprites ..= [[(   1,   32), $21, SpriteLarge, $104, 2, 6, false, false]]
        _Sprites ..= [[(   1,   48), $21, SpriteLarge, $106, 2, 6, false, false]]
        _Sprites ..= [[(   1,   64), $21, SpriteLarge, $108, 2, 6, false, false]]
        _Sprites ..= [[(  57,    0), $21, SpriteLarge, $10A, 2, 6, false, false]]
        _Sprites ..= [[(  57,   16), $21, SpriteLarge, $10C, 2, 6, false, false]]
        _Sprites ..= [[(  57,   32), $21, SpriteLarge, $10E, 2, 6, false, false]]
        _Sprites ..= [[(  57,   48), $21, SpriteLarge, $120, 2, 6, false, false]]
        _Sprites ..= [[(  57,   64), $21, SpriteLarge, $122, 2, 6, false, false]]

        .structSpriteArray aUnknown898AC1._Sprites

    .endsection Unsorted898A7ESection


    .section Unsorted898AF5Section

      .al
      .xl

      rsUnknown898AF5 ; 89/8AF5

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetFirstEquippableWeaponInInventory
        lda wCurrentItemDataROMPointer,b
        beq _8B29
        jsl rlGetItemWeaponType
        tax
        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        lda #$00C8
        sta wR0
        lda #$0049
        sta wR1
        lda @l aUnknown898B2A,x
        and #$00FF
        sta wR4
        stz wR5
        phk
        plb
        .databank $89
        ldy #$8B34
        jsl rlPushToOAMBuffer

        _8B29
        rts

        .databank 0

        ; 89/8B2A

    .endsection Unsorted898AF5Section


    .section Table898B2ASection

      .al
      .xl

      aUnknown898B2A ; 89/8B2A

        ; Read by rsUnknown898AF5.

        .byte $00, $02, $04, $06, $08, $0A, $0C, $0E, $20, $22, $01, $00, $00, $C2, $C0, $00
        .byte $3D

        ; 89/8B3B

    .endsection Table898B2ASection


    .section Unsorted898B3BSection

      .al
      .xl

      rsUnknown898B3B ; 89/8B3B

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown89933C
        lda wCastleListSubCount,b
        sec
        sbc #$0001
        bmi _8B7F
        tax

        _8B48
        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        ldy #$8B90
        lda #$0086
        sta wR0
        lda @l aUnknown898B80,x
        and #$00FF
        clc
        adc #$00A9
        sec
        sbc wBufferBG3VOFS
        sta wR1
        lda @l aUnknown898B88,x
        and #$00FF
        sta wR4
        lda #$0000
        sta wR5
        phx
        jsl rlPushToOAMBuffer
        plx
        dec x
        bpl _8B48

        _8B7F
        rts

        .databank 0

        ; 89/8B80

    .endsection Unsorted898B3BSection


    .section Table898B80Section

      .al
      .xl

      aUnknown898B80 ; 89/8B80

        ; Read by rsUnknown898B3B.

        .word $1000, $3020, $5040, $7060

        ; 89/8B88

    .endsection Table898B80Section


    .section Data898B88Section

      .al
      .xl

      aUnknown898B88 ; 89/8B88

        ; Read by rsUnknown898B3B.

        .byte $00, $02, $04, $06, $08, $0A, $0C, $0E, $01, $00, $00, $C2, $C0, $60, $26

        ; 89/8B97

    .endsection Data898B88Section


    .section Unsorted898B97Section

      .al
      .xl

      rsUnknown898B97 ; 89/8B97

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $89
        ldy #$8CC4
        lda $7F8185
        tax
        dec x
        lda #$0010
        sta wR0
        lda #$0009
        sta wR1
        lda @l aUnknown898CBC,x
        and #$00FF
        sta wR4
        lda #$2600
        sta wR5
        jsl rlPushToOAMBuffer
        lda $7F8185
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemEquipmentType
        cmp #$0000
        beq _8BD8
        cmp #$0001
        beq _8BF9
        jml _8CBB


        _8BD8
        lda $7F8193
        bne _8BF9
        ldy #$8CC4
        lda #$003B
        sta wR0
        lda #$001B
        sta wR1
        lda #$000E
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer

        _8BF9
        jsl rlGetItemWeaponType
        sta $7F82BD
        asl a
        tax
        lda @l aUnknown898D41,x
        sta wR4
        lda #$0017
        sta wR0
        lda #$0019
        sta wR1
        lda #$3C00
        sta wR5
        ldy #$8CC4
        jsl rlPushToOAMBuffer
        lda $7F82BD
        cmp #$0005
        bpl _8C65
        cmp #$0003
        bmi _8C31
        jml _8CBB


        _8C31
        lda #$0000
        sta wR0
        sta wR4
        sta wR5
        lda #$004A
        sta wR1
        ldy #$8CCB
        jsl rlPushToOAMBuffer
        lda #$0000
        sta wR0
        sta wR4
        sta wR5
        lda #$004A
        sta wR1
        lda $7F82BD
        asl a
        tax
        lda @l aUnknown898CD7,x
        tay
        jsl rlPushToOAMBuffer
        bra _8CBB


        _8C65
        lda $7F82BD
        cmp #$0008
        bpl _8CA6
        lda #$0000
        sta wR0
        sta wR4
        sta wR5
        lda #$004A
        sta wR1
        ldy #$8CCB
        jsl rlPushToOAMBuffer
        lda #$0000
        sta wR0
        sta wR4
        sta wR5
        lda #$004A
        sta wR1
        lda $7F82BD
        sec
        sbc #$0005
        asl a
        tax
        lda @l aUnknown898D01,x
        tay
        jsl rlPushToOAMBuffer
        bra _8CBB


        _8CA6
        lda #$0000
        sta wR0
        sta wR4
        sta wR5
        lda #$004A
        sta wR1
        ldy #$8D2B
        jsl rlPushToOAMBuffer

        _8CBB
        rts

        .databank 0

        ; 89/8CBC

    .endsection Unsorted898B97Section


    .section Data898CBCSection

      .al
      .xl

      aUnknown898CBC ; 89/8CBC

        ; Read by rsUnknown898B97.

        .byte $60, $62, $64, $66, $68, $6A, $6C, $6E, $01, $00, $00, $C2, $50, $00, $00, $02
        .byte $00, $18, $C2, $70, $00, $30, $48, $C2, $70, $00, $B0

        ; 89/8CD7

      aUnknown898CD7 ; 89/8CD7

        ; Read by rsUnknown898B97.

        .word $8CDD, $8CE9, $8CF5, $0002, $C228, $0470, $583D, $70C2
        .word $3D02, $0002, $C228, $0070, $583D, $70C2, $3D04, $0002
        .word $C228, $0270, $583D, $70C2, $3D00

        ; 89/8D01

      aUnknown898D01 ; 89/8D01

        ; Read by rsUnknown898B97.

        .word $8D07, $8D13, $8D1F, $0002, $C228, $0E70, $583D, $70C2
        .word $3D0C, $0002, $C228, $0A70, $583D, $70C2, $3D0E, $0002
        .word $C228, $0C70, $583D, $70C2, $3D0A, $0004, $C21C, $0070
        .word $2E30, $70C2, $3D0A, $C240, $0C70, $523D, $70C2, $3D0E

        ; 89/8D41

      aUnknown898D41 ; 89/8D41

        ; Read by rsUnknown898B97.

        .word $0100, $0102, $0104, $0106, $0108, $010A, $010C, $010E
        .word $0120, $0122

        ; 89/8D55

    .endsection Data898CBCSection


    .section Unsorted898D55Section

      .al
      .xl

      rsUnknown898D55 ; 89/8D55

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown898EB4
        jsr rsUnknown898F16
        jsr rsUnknown898D5F
        rts

        .databank 0

        ; 89/8D5F

      rsUnknown898D5F ; 89/8D5F

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F818D
        cmp #$0002
        beq _8D6C
        jml _8E14


        _8D6C
        lda #$0078
        sta wR0
        lda #$00B0
        sta wR1
        stz wR4
        stz wR5
        phk
        plb
        .databank $89
        ldy #$8E65
        jsl rlPushToOAMBuffer
        lda $7F82B9
        bne _8DA8
        lda #$0006
        sta $7F82B9
        lda $7F8251
        inc a
        cmp #$0004
        bcc _8DA4
        lda #$000F
        sta $7F82B9
        lda #$0000

        _8DA4
        sta $7F8251

        _8DA8
        lda $7F82B9
        dec a
        sta $7F82B9
        lda #$007C
        sta wR0
        lda #$00A0
        sta wR1
        stz wR4
        stz wR5
        lda $7F8251
        asl a
        tax
        lda @l aUnknown898E6C,x
        tay
        jsl rlPushToOAMBuffer
        lda $7F82BB
        bne _8DEC
        lda #$0003
        sta $7F82BB
        lda $7F8253
        inc a
        cmp #$0004
        bcc _8DE8
        lda #$0000

        _8DE8
        sta $7F8253

        _8DEC
        lda $7F82BB
        dec a
        sta $7F82BB
        lda #$0078
        sta wR0
        lda #$009C
        sta wR1
        stz wR4
        stz wR5
        lda $7F8253
        asl a
        tax
        lda @l aUnknown898E90,x
        tay
        jsl rlPushToOAMBuffer
        bra _8E64


        _8E14
        cmp #$0000
        beq _8E64
        lda $7F82B9
        bne _8E3E
        lda #$000B
        sta $7F82B9
        lda $7F8251
        inc a
        cmp #$0004
        bcc _8E3A
        lda #$0019
        sta $7F82B9
        lda #$0000

        _8E3A
        sta $7F8251

        _8E3E
        lda $7F82B9
        dec a
        sta $7F82B9
        lda #$007C
        sta wR0
        lda #$00A0
        sta wR1
        stz wR4
        stz wR5
        lda $7F8251
        asl a
        tax
        lda @l aUnknown898E6C,x
        tay
        jsl rlPushToOAMBuffer

        _8E64
        rts

        .databank 0

        ; 89/8E65

    .endsection Unsorted898D55Section


    .section Table898E6CSection

      .al
      .xl

      aUnknown898E6C ; 89/8E6C

        ; Read by rsUnknown898D5F.

        .word $8E74, $8E7B, $8E82, $8E89, $0001, $0000, $9900, $013B
        .word $0000, $0000, $3B88, $0001, $0000, $8900, $013B, $0000
        .word $0000, $3B98

        ; 89/8E90

    .endsection Table898E6CSection


    .section Table898E90Section

      .al
      .xl

      aUnknown898E90 ; 89/8E90

        ; Read by rsUnknown898D5F.

        .word $8E98, $8E9F, $8EA6, $8EAD, $0001, $C200, $8A00, $013B
        .word $0000, $00C2, $3B8C, $0001, $C200, $8E00, $013B, $0000
        .word $00C2, $3B8C

        ; 89/8EB4

    .endsection Table898E90Section


    .section Unsorted898EB4Section

      .al
      .xl

      rsUnknown898EB4 ; 89/8EB4

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$89
        pha
        plb
        .databank $89
        rep #$20
        ldy #$8ED8
        lda #$007E
        sta wR0
        lda #$00AC
        sta wR1
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/8ED8


      aUnknown898ED8 ; 89/8ED8

        _Sprites := [[(  32,   32), $21, SpriteLarge, $14E, 3, 7, false, false]]
        _Sprites ..= [[(  48,   16), $21, SpriteLarge, $160, 3, 7, false, false]]
        _Sprites ..= [[(  56,    0), $21, SpriteLarge, $164, 3, 7, false, false]]
        _Sprites ..= [[(  56,  -24), $21, SpriteLarge, $144, 3, 7, false, false]]
        _Sprites ..= [[(  48,  -48), $21, SpriteLarge, $14C, 3, 7, false, false]]
        _Sprites ..= [[(  32,  -64), $21, SpriteLarge, $14A, 3, 7, false, false]]
        _Sprites ..= [[( -40,   32), $21, SpriteLarge, $148, 3, 7, false, false]]
        _Sprites ..= [[( -56,   16), $21, SpriteLarge, $140, 3, 7, false, false]]
        _Sprites ..= [[( -64,    0), $21, SpriteLarge, $142, 3, 7, false, false]]
        _Sprites ..= [[( -64,  -24), $21, SpriteLarge, $166, 3, 7, false, false]]
        _Sprites ..= [[( -56,  -48), $21, SpriteLarge, $162, 3, 7, false, false]]
        _Sprites ..= [[( -40,  -64), $21, SpriteLarge, $146, 3, 7, false, false]]

        .structSpriteArray aUnknown898ED8._Sprites

    .endsection Unsorted898EB4Section


    .section Unsorted898F16Section

      .al
      .xl

      rsUnknown898F16 ; 89/8F16

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000

        _8F19
        sta $7F82BD
        asl a
        tax
        lda $7F81D3,x
        beq _8F38
        jsr rsUnknown898F73
        lda $7F82BD
        asl a
        tax
        lda $7F81D3,x
        dec a
        beq _8F38
        jsr rsUnknown899028

        _8F38
        lda $7F82BD
        inc a
        cmp #$000C
        bne _8F19
        rts

        .databank 0

        ; 89/8F43

    .endsection Unsorted898F16Section


    .section Table898F43Section

      .al
      .xl

      aUnknown898F43 ; 89/8F43

        ; Read by rsUnknown898F73, rsUnknown899028.

        .word $0071, $0054, $009B, $0060, $0088, $00A5, $0054, $0089
        .word $009A, $0060, $00A6, $0071

        ; 89/8F5B

    .endsection Table898F43Section


    .section Table898F5BSection

      .al
      .xl

      aUnknown898F5B ; 89/8F5B

        ; Read by rsUnknown898F73, rsUnknown899028.

        .word $0081, $00A1, $008E, $00CB, $0081, $00A0, $00B8, $00D6
        .word $00CB, $008D, $00B8, $00D6

        ; 89/8F73

    .endsection Table898F5BSection


    .section Unsorted898F73Section

      .al
      .xl

      rsUnknown898F73 ; 89/8F73

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F82BD
        asl a
        tax
        lda $7F8255,x
        bne _8FA0
        lda aUnknown898FD4,x
        sta $7F8255,x
        lda $7F81ED,x
        inc a
        cmp #$0004
        bne _8F9C
        lda aUnknown898FEC,x
        sta $7F8255,x
        lda #$0000

        _8F9C
        sta $7F81ED,x

        _8FA0
        lda $7F8255,x
        dec a
        sta $7F8255,x
        lda aUnknown898F43,x
        sec
        sbc #$0001
        sta wR0
        lda aUnknown898F5B,x
        sec
        sbc #$0004
        sta wR1
        lda #$0000
        sta wR4
        sta wR5
        lda $7F81ED,x
        asl a
        tax
        lda aUnknown899004,x
        tay
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/8FD4

    .endsection Unsorted898F73Section


    .section Table898FD4Section

      .al
      .xl

      aUnknown898FD4 ; 89/8FD4

        ; Read by rsUnknown898F73.

        .word $000B, $0008, $000D, $0009, $000E, $000A, $0008, $000A
        .word $000C, $0009, $0008, $000B

        ; 89/8FEC

    .endsection Table898FD4Section


    .section Table898FECSection

      .al
      .xl

      aUnknown898FEC ; 89/8FEC

        ; Read by rsUnknown898F73.

        .word $0019, $0013, $001A, $0020, $0018, $0015, $001B, $0012
        .word $0025, $0019, $000F, $001B

        ; 89/9004

    .endsection Table898FECSection


    .section Table899004Section

      .al
      .xl

      aUnknown899004 ; 89/9004

        ; Read by rsUnknown898F73.

        .word $900C, $9013, $901A, $9021, $0001, $0000, $91F8, $013B
        .word $0000, $F800, $3B80, $0001, $0000, $81F8, $013B, $0000
        .word $F800, $3B90

        ; 89/9028

    .endsection Table899004Section


    .section Unsorted899028Section

      .al
      .xl

      rsUnknown899028 ; 89/9028

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F82BD
        asl a
        tax
        lda $7F826D,x
        bne _904D
        lda aUnknown899081,x
        sta $7F826D,x
        lda $7F8205,x
        inc a
        cmp #$0004
        bne _9049
        lda #$0000

        _9049
        sta $7F8205,x

        _904D
        lda $7F826D,x
        dec a
        sta $7F826D,x
        lda aUnknown898F43,x
        sec
        sbc #$0001
        sta wR0
        lda aUnknown898F5B,x
        sec
        sbc #$0004
        sta wR1
        lda #$0000
        sta wR4
        sta wR5
        lda $7F8205,x
        asl a
        tax
        lda aUnknown899099,x
        tay
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/9081

    .endsection Unsorted899028Section


    .section Table899081Section

      .al
      .xl

      aUnknown899081 ; 89/9081

        ; Read by rsUnknown899028.

        .word $0007, $0008, $0007, $0009, $0007, $0009, $0008, $0007
        .word $0008, $0009, $0008, $0007

        ; 89/9099

    .endsection Table899081Section


    .section Data899099Section

      .al
      .xl

      aUnknown899099 ; 89/9099

        ; Read by rsUnknown899028.

        .word $90A1, $90A8, $90AF, $90B6, $0001, $C3FC, $82F4, $013B
        .word $FC00, $F4C3, $3B84, $0001, $C3FC, $86F4, $013B, $FC00
        .word $F4C3, $3B84

        ; 89/90BD

    .endsection Data899099Section


    .section Unsorted8990BDSection

      .al
      .xl

      rlUnknown8990BD ; 89/90BD

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000

        _90C0
        sta wR0
        jsl rlCheckForSpecifiedHolyBlood
        tay
        lda wR0
        asl a
        tax
        tya
        sta $7F81D3,x
        lda wR0
        inc a
        cmp #$000D
        bne _90C0
        rtl

        .databank 0

        ; 89/90D9

    .endsection Unsorted8990BDSection

    .section Table899140Section

      .al
      .xl

      aUnknown899140 .dstruct structHDMADirectEntryInfo, rlUnknown89914B, rlUnknown89914B, aUnknown899178, $0008C8, PPU_REG_BASE + $12, $02 ; 89/9140

    .endsection Table899140Section











    .section Unsorted89914BSection

      .al
      .xl

      rlUnknown89914B ; 89/914B

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$57
        sta $08C8,b
        rep #$20
        lda #$FFFF
        sta $08C9,b
        sep #$20
        lda #$01
        sta $08CB,b
        rep #$20
        lda wBufferBG3VOFS
        sta $08CC,b
        sep #$20
        lda #$00
        sta $08CE,b
        rep #$20
        lda #$0000
        sta $08CF,b
        rtl

        .databank 0

        ; 89/9178

    .endsection Unsorted89914BSection


    .section Table899178Section

      .al
      .xl

      aUnknown899178 ; 89/9178
        HDMA_HALT

      aUnknown89917A .dstruct structHDMADirectEntryInfo, rlUnknown899185, rlUnknown899185, aUnknown899178, $7FB160, PPU_REG_BASE + $0E, $02 ; 89/917A

    .endsection Table899178Section






    .section Unsorted899185Section

      .al
      .xl

      rlUnknown899185 ; 89/9185

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$57
        sta $7FB160
        rep #$20
        lda #$FFFF
        sta $7FB161
        sep #$20
        lda #$01
        sta $7FB163
        rep #$20
        lda wBufferBG1VOFS
        dec a
        sta $7FB164
        sep #$20
        lda #$00
        sta $7FB166
        rep #$20
        lda #$0000
        sta $7FB167
        rtl

        .databank 0

        ; 89/91B9

    .endsection Unsorted899185Section


    .section Table8991B9Section

      .al
      .xl

      aUnknown8991B9 .dstruct structHDMADirectEntryInfo, rlUnknown8991C4, rlUnknown8991D2, aUnknown899178, $7FB0B6, PPU_REG_BASE + $32, $00 ; 89/91B9

    .endsection Table8991B9Section






    .section Unsorted8991C4Section

      .al
      .xl

      rlUnknown8991C4 ; 89/91C4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wGameStateStep,b
        jsl rlUnknown899200
        stz wGameStateStep,b
        rtl

        .databank 0

        ; 89/91D2

      rlUnknown8991D2 ; 89/91D2

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 89/91D3

    .endsection Unsorted8991C4Section


    .section Unsorted899200Section

      .al
      .xl

      rlUnknown899200 ; 89/9200

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0000
        lda wGameStateStep,b
        cmp #$0002
        beq _9219

        _920B
        lda aUnknown89923F,x
        sta $7FB0B6,x
        beq _923E
        inc x
        inc x
        bra _920B


        _9219
        lda $7F818D
        cmp #$0002
        beq _9230

        _9222
        lda aUnknown899265,x
        sta $7FB0B6,x
        beq _923E
        inc x
        inc x
        bra _9222


        _9230
        lda aUnknown899289,x
        sta $7FB0B6,x
        beq _923E
        inc x
        inc x
        bra _9230


        _923E
        rtl

        .databank 0

        ; 89/923F

    .endsection Unsorted899200Section


    .section Data89923FSection

      .al
      .xl

      aUnknown89923F ; 89/923F

        ; Read by rlUnknown899200.

        .word $E016, $E110, $E20D, $E30B, $E40A, $E508, $E508, $E801
        .word $E601, $E401, $E214, $E312, $E412, <>rsDebugMenuTab3Page6, $E610, $E70E
        .word $E80D, $E910, $0000

        ; 89/9265

      aUnknown899265 ; 89/9265

        ; Read by rlUnknown899200.

        .word $E016, $E110, $E20D, $E30B, $E40A, $E508, $E508, $E801
        .word $E601, $E401, $E118, $E214, $E414, <>rsDebugMenuTab3Page6, $E612, $E711
        .word $E810, $0000

        ; 89/9289

      aUnknown899289 ; 89/9289

        ; Read by rlUnknown899200.

        .word $E016, $E110, $E20D, $E30B, $E40A, $E508, $E508, $E801
        .word $E601, $E401, $E415, $E514, $E614, $E714, $E812, $E912
        .word $EA10, $0000

        ; 89/92AD

    .endsection Data89923FSection


    .section Unsorted8992ADSection

      .al
      .xl

      rsUnknown8992AD ; 89/92AD

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F81B1
        beq _92E6
        phk
        plb
        .databank $89
        lda #$0000

        _92B8
        sta wR15
        asl a
        tax
        lda $7F81C1,x
        sta wR4
        lda wR15
        asl a
        tax
        lda @l aUnknown8992E7,x
        sta wR0
        lda #$0150
        sec
        sbc wBufferBG3VOFS
        sta wR1
        stz wR5
        ldy #$92F7
        jsl rlPushToOAMBuffer
        lda wR15
        inc a
        cmp $7F81B1
        bne _92B8

        _92E6
        rts

        .databank 0

        ; 89/92E7

    .endsection Unsorted8992ADSection


    .section Table8992E7Section

      .al
      .xl

      aUnknown8992E7 ; 89/92E7

        ; Read by rsUnknown8992AD.

        .byte $80, $00, $94, $00, $A8, $00, $BC, $00, $D0, $00, $E4, $00, $F8, $00, $0C, $01
        .byte $01, $00, $00, $C2, $00, $80, $3E, $FF, $FF, $FF, $FF, $06, $00, $00, $00, $02
        .byte $00, $04, $00, $44, $00, $FF, $FF, $46, $00, $FF, $FF, $FF, $FF, $FF, $FF, $08
        .byte $00, $FF, $FF, $0C, $00, $0E, $00, $20, $00, $22, $00, $24, $00, $26, $00, $28
        .byte $00, $2A, $00, $2C, $00, $2E, $00, $40, $00, $42, $00, $FF, $FF, $FF, $FF, $48
        .byte $00, $FF, $FF, $FF, $FF

        ; 89/933C

    .endsection Table8992E7Section


    .section Unsorted89933CSection

      .al
      .xl

      rsUnknown89933C ; 89/933C

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $89
        lda $7F81A7
        beq _935E
        tax
        lda @l aUnknown89935F,x
        and #$00FF
        sec
        sbc wBufferBG3VOFS
        sta wR1
        stz wR0
        stz wR4
        stz wR5
        ldy #$9367
        jsl rlPushToOAMBuffer

        _935E
        rts

        .databank 0

        ; 89/935F

    .endsection Unsorted89933CSection


    .section Data89935FSection

      .al
      .xl

      aUnknown89935F ; 89/935F

        ; Read by rsUnknown89933C.

        .byte $00, $00, $10, $20, $30, $40, $50, $60, $01, $00, $D6, $C2, $69, $07, $26

        ; 89/936E

    .endsection Data89935FSection


    .section Unsorted89936ESection

      .al
      .xl

      rsUnknown89936E ; 89/936E

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown89ACBC)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown89ACBC
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        ldx #$00C0

        _9380
        sta $7FAF4E,x
        dec x
        dec x
        bne _9380
        lda aCurrentTilemapInfo,b
        pha
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0000
        jsl rlDrawMenuTextLine
        pla
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown89ACB3)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown89ACB3
        sta lMapMenuTilemapRAMEntryPointer,b
        ldx #$0000

        _93BA
        lda $7FAF50,x
        sta $7E8750,x
        lda $7FAFB0,x
        sta $7E8790,x
        inc x
        inc x
        cpx #$0010
        bne _93BA
        ldx #$0000

        _93D4
        lda $7FAF60,x
        sta $7E87D0,x
        lda $7FAFC0,x
        sta $7E8810,x
        inc x
        inc x
        cpx #$0010
        bne _93D4
        ldx #$0000

        _93EE
        lda $7FAF70,x
        sta $7E8850,x
        lda $7FAFD0,x
        sta $7E8890,x
        inc x
        inc x
        cpx #$0010
        bne _93EE
        ldx #$0000

        _9408
        lda $7FAF80,x
        sta $7E88D0,x
        lda $7FAFE0,x
        sta $7E8910,x
        inc x
        inc x
        cpx #$0010
        bne _9408
        ldx #$0000

        _9422
        lda $7FAF90,x
        sta $7E8950,x
        lda $7FAFF0,x
        sta $7E8990,x
        inc x
        inc x
        cpx #$0010
        bne _9422
        ldx #$0000

        _943C
        lda $7FAFA0,x
        sta $7E89D0,x
        lda $7FB000,x
        sta $7E8A10,x
        inc x
        inc x
        cpx #$0010
        bne _943C
        rts

        .databank 0

        ; 89/9454

      rsUnknown899454 ; 89/9454

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown89ACBC)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown89ACBC
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        ldx #$00C0

        _9466
        sta $7FAF4E,x
        dec x
        dec x
        bne _9466
        lda aCurrentTilemapInfo,b
        pha
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0000
        jsl rlDrawMenuTextLine
        pla
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown89ACB3)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown89ACB3
        sta lMapMenuTilemapRAMEntryPointer,b
        ldx #$0000

        _94A0
        lda $7FAF50,x
        sta $7E89D0,x
        lda $7FAFB0,x
        sta $7E8A10,x
        inc x
        inc x
        cpx #$0010
        bne _94A0
        rts

        .databank 0

        ; 89/94B8

    .endsection Unsorted89936ESection


    .section Unsorted8994B8Section

      .al
      .xl

      rsUnknown8994B8 ; 89/94B8

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $89
        lda wVBlankEnabledFramecount
        and #$0018
        beq _9508
        lda $7F8187
        beq _94EE
        cmp #$0087
        bne _9508
        lda wGameStateStep,b
        cmp #$0001
        bne _9508
        lda #$0075
        sta wR0
        lda #$0055
        sta wR1
        stz wR4
        lda #$8000
        sta wR5
        ldy #$9509
        jsl rlPushToOAMBuffer
        bra _9508


        _94EE
        lda wGameStateStep,b
        bne _9508
        lda #$0075
        sta wR0
        lda #$00D3
        sta wR1
        stz wR4
        stz wR5
        ldy #$9509
        jsl rlPushToOAMBuffer

        _9508
        rts

        .databank 0

        ; 89/9509


      aUnknown899509 ; 89/9509

        _Sprites := [[(   0,    0), $21, SpriteLarge, $00C, 2, 0, false, false]]

        .structSpriteArray aUnknown899509._Sprites

    .endsection Unsorted8994B8Section


    .section Unsorted899510Section

      .al
      .xl

      rlUnknown899510 ; 89/9510

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0102
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitClassNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0304
        jsl rlDrawMenuTextLine
        jsl rlGetSelectedUnitLevel
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$014A
        jsl rlDrawMenuTextNumber
        lda $7F8193
        bne _9570
        jsl rlGetSelectedUnitExperience
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$0150
        jsl rlDrawMenuTextNumber

        _9570
        jsl rlGetSelectedUnitCurrentHP
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$01CA
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitMaxHP
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$01D0
        jsl rlDrawMenuTextNumber
        jsl rlGetFirstEquippableWeaponInInventory
        lda wCurrentItemDataROMPointer,b
        bne _95A7
        jml _9660


        _95A7
        lda #$0000
        sta wRoutineVariable1,b
        jsl rlGetFirstWeaponBattleMight
        cmp #$00FF
        bcs _95C9
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$0076
        jsl rlDrawMenuTextNumber
        bra _95E0


        _95C9
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown899703)<<8
        sta lR18+1
        lda #<>aUnknown899703
        sta lR18
        ldx #$011B
        jsl rlDrawMenuTextLine

        _95E0
        jsl rlUnknown84FE98
        ldx #$3920
        stx wR5
        ldx #$0003
        stx wR6
        ldx #$00F4
        jsl rlDrawMenuTextNumber
        lda wSelectedInventorySlot,b
        sta $7F81AF
        jsl rlGetFirstEquippableWeaponInInventory
        sta wSelectedInventorySlot,b
        jsl rlGetSelectedItemRange
        lda wR11
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$0176
        jsl rlDrawMenuTextNumber
        sta wR11
        lda $7F81AF
        sta wSelectedInventorySlot,b
        lda #$001B
        sec
        sbc wR11
        asl a
        clc
        adc #$0140
        tax
        lda #$3920
        sta wR5
        lda #$0001
        sta wR6
        lda wR10
        jsl rlDrawMenuTextNumber
        lda #$001C
        sec
        sbc wR11
        asl a
        clc
        adc #$0140
        tax
        lda #$3800
        sta wR1
        lda #$02A0
        sta wR2
        lda #$0001
        sta wR0
        jsl rlDrawBG3TileRun
        bra _968B


        _9660
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown899703)<<8
        sta lR18+1
        lda #<>aUnknown899703
        sta lR18
        ldx #$011B
        jsl rlDrawMenuTextLine
        ldx #$031B
        jsl rlDrawMenuTextLine
        ldx #$051B
        jsl rlDrawMenuTextLine
        lda #$2000
        sta aCurrentTilemapInfo,b

        _968B
        lda #$FFFF
        jsl rlUnknown84FEA1
        cmp #$0000
        bpl _96DA
        eor #$FFFF
        inc a
        ldx #$3920
        stx wR5
        ldx #$0003
        stx wR6
        ldx #$01F4
        jsl rlDrawMenuTextNumber
        sta $7F83F5
        lda #$001C
        sec
        sbc $7F83F5
        sta $7F83F5
        lda #(`aUnknown899709)<<8
        sta lR18+1
        lda #<>aUnknown899709
        sta lR18
        lda #$0700
        ora $7F83F5
        tax
        lda #$3800
        sta aCurrentTilemapInfo,b
        jsl rlDrawMenuTextLine
        bra _96EB


        _96DA
        ldx #$3920
        stx wR5
        ldx #$0003
        stx wR6
        ldx #$01F4
        jsl rlDrawMenuTextNumber

        _96EB
        lda $7F8193
        beq _9702
        lda #(`aUnknown899703)<<8
        sta lR18+1
        lda #<>aUnknown899703
        sta lR18
        ldx #$0508
        jsl rlDrawMenuTextLine

        _9702
        rtl

        .databank 0

        ; 89/9703

    .endsection Unsorted899510Section


    .section Table899703Section

      .al
      .xl

      aUnknown899703 ; 89/9703

        .enc "SJIS"
        .text "ーー"
        .word $0000
        .enc "none"

      aUnknown899709 ; 89/9709

        .enc "SJIS"
        .text "ー"
        .word $0000
        .enc "none"


    .endsection Table899703Section






    .section Unsorted89970DSection

      .al
      .xl

      rlUnknown89970D ; 89/970D

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitTotalStrengthEffect
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$0354
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$000C
        ldy #$000E
        jsl rlUnknown89A085
        jsl rlGetSelectedUnitTotalMagicEffect
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$03D4
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$000C
        ldy #$0010
        jsl rlUnknown89A085
        jsl rlGetSelectedUnitTotalSkillEffect
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$0454
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$000C
        ldy #$0012
        jsl rlUnknown89A085
        jsl rlGetSelectedUnitTotalSpeedEffect
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$04D4
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$000C
        ldy #$0014
        jsl rlUnknown89A085
        lda $7F818B
        cmp #$0003
        bne _979F
        lda #$0000
        bra _97A3


        _979F
        jsl rlGetSelectedUnitLuck

        _97A3
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$0554
        jsl rlDrawMenuTextNumber
        jsl rlGetSelectedUnitTotalDefenseEffect
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$05D4
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$000C
        ldy #$0018
        jsl rlUnknown89A085
        jsl rlGetSelectedUnitTotalResistanceEffect
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$0654
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$000C
        ldy #$001A
        jsl rlUnknown89A085
        phk
        plb
        .databank $89
        lda #$0000
        sta wCastleListSubCount,b
        jsl rlGetFirstEquippableWeaponInInventory
        sta wR15
        ldy #$0001

        _9807
        tya
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        bne _9815
        jml _98D3


        _9815
        tya
        sta @l $000889
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetItemEquipmentType
        cmp #$0000
        beq _9837
        cmp #$0001
        bne _9844
        tya
        jsl rlUnknown84F75C
        bcs _9844
        bra _983E


        _9837
        tya
        jsl rlCheckWeaponInInventorySlotEquippable
        bcs _9844

        _983E
        lda #$3000
        sta aCurrentTilemapInfo,b

        _9844
        jsl rlGetItemNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        lda $98D4,b,y
        and #$00FF
        xba
        clc
        adc #$0013
        tax
        jsl rlDrawMenuTextLine
        phy
        lda $7F8193
        bne _98A4
        jsl rlGetItemEquipmentType
        cmp #$0000
        beq _9877
        cmp #$0001
        bne _98A4

        _9877
        tya
        jsl rlGetItemRAMStructEntryByInventorySlot
        jsl rlGetItemCurrentDurability
        sta $7F83F5
        lda $98D4,b,y
        and #$00FF
        xba
        lsr a
        lsr a
        clc
        adc #$0036
        tax
        lda #$3920
        sta wR5
        lda #$0002
        sta wR6
        lda $7F83F5
        jsl rlDrawMenuTextNumber

        _98A4
        ply
        cpy wR15
        bne _98C9
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown8998DD)<<8
        sta lR18+1
        lda #<>aUnknown8998DD
        sta lR18
        lda $98D4,b,y
        and #$00FF
        xba
        clc
        adc #$001D
        tax
        jsl rlDrawMenuTextLine

        _98C9
        inc y
        cpy #$0008
        bcs _98D3
        jml _9807


        _98D3
        rtl

        .databank 0

        ; 89/98D4

    .endsection Unsorted89970DSection


    .section Data8998D4Section

      .al
      .xl

      aUnknown8998D4 ; 89/98D4

        ; Read by rlUnknown89970D.

        .byte $00, $0D, $0F, $11, $13, $15, $17, $19, $1B

      aUnknown8998DD ; 89/98DD
        .byte $82, $64, $00, $00

        ; 89/98E1

    .endsection Data8998D4Section


    .section Unsorted8998E1Section

      .al
      .xl

      rlUnknown8998E1 ; 89/98E1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $7F8199
        beq _9904
        jsl rlGetCharacterNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$1E08
        jsl rlDrawMenuTextLine
        bra _991B


        _9904
        lda $7F8197
        bne _991B
        lda #(`aUnknown899B93)<<8
        sta lR18+1
        lda #<>aUnknown899B93
        sta lR18
        ldx #$1E08
        jsl rlDrawMenuTextLine

        _991B
        lda $7F8193
        beq _994F
        jsl rlGetFactionSlotNameID
        cmp #$00FF
        bne _9938
        lda #(`aUnknown899B93)<<8
        sta lRoutineVariable+1,b
        lda #<>aUnknown899B93
        sta lRoutineVariable,b
        bra _993C


        _9938
        jsl rlGetSelectedUnitFactionNamePointer

        _993C
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$2008
        jsl rlDrawMenuTextLine
        bra _9989


        _994F
        lda @l wSelectedUnitDataRAMPointer
        pha
        lda #(`aUnknown899B93)<<8
        sta lRoutineVariable+1,b
        lda #<>aUnknown899B93
        sta lRoutineVariable,b
        jsl rlGetSelectedUnitLoverGenerationID
        cmp #$0000
        beq _9973
        jsl rlFindCharacterByGenerationID
        bcs _9973
        jsl rlGetSelectedUnitNamePointer

        _9973
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$2008
        jsl rlDrawMenuTextLine
        pla
        sta @l wSelectedUnitDataRAMPointer

        _9989
        jsl rlGetSelectedUnitTotalMovementEffect
        ldx #$2120
        stx wR5
        ldx #$0001
        stx wR6
        ldx #$0910
        jsl rlDrawMenuTextNumber
        lda wR34
        ldx #$0009
        ldy #$0025
        jsl rlUnknown89A085
        lda $7F8193
        bne _9A27
        lda @l wSelectedUnitDataRAMPointer
        pha
        jsl rlGetSelectedUnitLivingTalkTarget
        cmp #$0000
        beq _99DA
        jsl rlGetUnitRAMDataPointerByID
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        bne _99DA
        jsl rlGetSelectedUnitStatus
        cmp #StatusCaptive
        beq _99DA
        jsl rlGetSelectedUnitNamePointer
        bra _99E6


        _99DA
        lda #(`aUnknown899B93)<<8
        sta lRoutineVariable+1,b
        lda #<>aUnknown899B93
        sta lRoutineVariable,b

        _99E6
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$2208
        jsl rlDrawMenuTextLine
        pla
        sta @l wSelectedUnitDataRAMPointer
        jsl rlGetSelectedUnitArenaLevel
        cmp #$0007
        beq _9A19
        inc a
        ldx #$2120
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0A10
        jsl rlDrawMenuTextNumber
        bra _9A27


        _9A19
        lda #$39E4
        sta $7E8D98
        lda #$39F4
        sta $7E8DD8

        _9A27
        jsl rlGetSelectedUnitMoney
        ldx #$2120
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0990
        jsl rlDrawMenuTextNumber
        lda $7F81A9
        bit #$0200
        beq _9A58
        lda #(`aUnknown899B9D)<<8
        sta lR18+1
        lda #<>aUnknown899B9D
        sta lR18
        ldx #$2A08
        jsl rlDrawMenuTextLine
        bra _9A94


        _9A58
        lda $7F81AB
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89A76C+1,x
        sta lR18+1
        lda aUnknown89A76C,x
        sta lR18
        ldx #$2A08
        jsl rlDrawMenuTextLine
        lda wR0
        beq _9A94
        cmp #$0003
        beq _9A94
        jsl rlGetSelectedUnitStatusDuration
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0A98
        jsl rlDrawMenuTextNumber

        _9A94
        lda #$0000
        jsl rlGetSelectedUnitWeaponRank
        bcc _9AA0
        lda #$0004

        _9AA0
        ldx #$0015
        ldy #$001E
        jsr rsUnknown89A5AA
        lda #$0001
        jsl rlGetSelectedUnitWeaponRank
        bcc _9AB5
        lda #$0004

        _9AB5
        ldx #$0015
        ldy #$0020
        jsr rsUnknown89A5AA
        lda #$0002
        jsl rlGetSelectedUnitWeaponRank
        bcc _9ACA
        lda #$0004

        _9ACA
        ldx #$0015
        ldy #$0022
        jsr rsUnknown89A5AA
        lda #$0003
        jsl rlGetSelectedUnitWeaponRank
        bcc _9ADF
        lda #$0004

        _9ADF
        ldx #$0015
        ldy #$0024
        jsr rsUnknown89A5AA
        lda #$0004
        jsl rlGetSelectedUnitWeaponRank
        bcc _9AF4
        lda #$0004

        _9AF4
        ldx #$0015
        ldy #$0026
        jsr rsUnknown89A5AA
        lda #$0005
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B09
        lda #$0004

        _9B09
        ldx #$001D
        ldy #$001E
        jsr rsUnknown89A5AA
        lda #$0006
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B1E
        lda #$0004

        _9B1E
        ldx #$001D
        ldy #$0020
        jsr rsUnknown89A5AA
        lda #$0007
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B33
        lda #$0004

        _9B33
        ldx #$001D
        ldy #$0022
        jsr rsUnknown89A5AA
        lda #$0008
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B48
        lda #$0004

        _9B48
        ldx #$001D
        ldy #$0024
        jsr rsUnknown89A5AA
        lda #$0009
        jsl rlGetSelectedUnitWeaponRank
        bcc _9B5D
        lda #$0004

        _9B5D
        ldx #$001D
        ldy #$0026
        jsr rsUnknown89A5AA
        lda $7F8193
        beq _9B8E
        lda #(`aUnknown899B93)<<8
        sta lR18+1
        lda #<>aUnknown899B93
        sta lR18
        ldx #$2208
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899B93)<<8
        sta lR18+1
        lda #<>aUnknown899B93
        sta lR18
        ldx #$2808
        jsl rlDrawMenuTextLine

        _9B8E
        rtl

        .databank 0

        ; 89/9B8F

    .endsection Unsorted8998E1Section


    .section Table899B8FSection

      .al
      .xl

      aUnknown899B8F ; 89/9B8F

        .enc "SJIS"
        .text "ー"
        .word $0000
        .enc "none"

      aUnknown899B93 ; 89/9B93

        .enc "SJIS"
        .text "ーーーー"
        .word $0000
        .enc "none"

      aUnknown899B9D ; 89/9B9D

        .enc "SJIS"
        .text "しぼう"
        .word $0000
        .enc "none"


    .endsection Table899B8FSection






    .section Unsorted899BA5Section

      .al
      .xl

      rlUnknown899BA5 ; 89/9BA5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2400
        sta aCurrentTilemapInfo,b
        lda #$2400
        sta wR1
        lda #$020C
        sta wR2
        lda #$0002
        sta wR0
        ldx #$0144
        jsl rlDrawBG3TileRun
        lda #(`aUnknown899C44)<<8
        sta lR18+1
        lda #<>aUnknown899C44
        sta lR18
        ldx #$0507
        jsl rlDrawMenuTextLine
        lda #$2400
        sta wR1
        lda #$0220
        sta wR2
        lda #$0002
        sta wR0
        ldx #$01C4
        jsl rlDrawBG3TileRun
        lda #(`aUnknown899C4E)<<8
        sta lR18+1
        lda #<>aUnknown899C4E
        sta lR18
        ldx #$0707
        jsl rlDrawMenuTextLine
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown899C52)<<8
        sta lR18+1
        lda #<>aUnknown899C52
        sta lR18
        ldx #$0114
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899C5C)<<8
        sta lR18+1
        lda #<>aUnknown899C5C
        sta lR18
        ldx #$0313
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899C68)<<8
        sta lR18+1
        lda #<>aUnknown899C68
        sta lR18
        ldx #$0514
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899C72)<<8
        sta lR18+1
        lda #<>aUnknown899C72
        sta lR18
        ldx #$0714
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

        ; 89/9C44

    .endsection Unsorted899BA5Section


    .section Table899C44Section

      .al
      .xl

      aUnknown899C44 ; 89/9C44

        .enc "SJIS"
        .text "（　　）"
        .word $0000
        .enc "none"

      aUnknown899C4E ; 89/9C4E

        .enc "SJIS"
        .text "／"
        .word $0000
        .enc "none"

      aUnknown899C52 ; 89/9C52

        .enc "SJIS"
        .text "こうげき"
        .word $0000
        .enc "none"

      aUnknown899C5C ; 89/9C5C

        .enc "SJIS"
        .text "めいちゅう"
        .word $0000
        .enc "none"

      aUnknown899C68 ; 89/9C68

        .enc "SJIS"
        .text "しゃてい"
        .word $0000
        .enc "none"

      aUnknown899C72 ; 89/9C72

        .enc "SJIS"
        .text "かいひち"
        .word $0000
        .enc "none"


    .endsection Table899C44Section






    .section Unsorted899C7CSection

      .al
      .xl

      rlUnknown899C7C ; 89/9C7C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2400
        sta wR1
        lda #$0226
        sta wR2
        lda #$000A
        sta wR0
        ldx #$02C6
        jsl rlDrawBG3TileRun
        lda #$2400
        sta wR1
        lda #$0240
        sta wR2
        lda #$000C
        sta wR0
        ldx #$02E2
        jsl rlDrawBG3TileRun
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown899D26)<<8
        sta lR18+1
        lda #<>aUnknown899D26
        sta lR18
        ldx #$0D06
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899D2E)<<8
        sta lR18+1
        lda #<>aUnknown899D2E
        sta lR18
        ldx #$0F05
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899D38)<<8
        sta lR18+1
        lda #<>aUnknown899D38
        sta lR18
        ldx #$1107
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899D3E)<<8
        sta lR18+1
        lda #<>aUnknown899D3E
        sta lR18
        ldx #$1305
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899D48)<<8
        sta lR18+1
        lda #<>aUnknown899D48
        sta lR18
        ldx #$1504
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899D54)<<8
        sta lR18+1
        lda #<>aUnknown899D54
        sta lR18
        ldx #$1703
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899D62)<<8
        sta lR18+1
        lda #<>aUnknown899D62
        sta lR18
        ldx #$1902
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

        ; 89/9D26

    .endsection Unsorted899C7CSection


    .section Table899D26Section

      .al
      .xl

      aUnknown899D26 ; 89/9D26

        .enc "SJIS"
        .text "ちから"
        .word $0000
        .enc "none"

      aUnknown899D2E ; 89/9D2E

        .enc "SJIS"
        .text "まりょく"
        .word $0000
        .enc "none"

      aUnknown899D38 ; 89/9D38

        .enc "SJIS"
        .text "わざ"
        .word $0000
        .enc "none"

      aUnknown899D3E ; 89/9D3E

        .enc "SJIS"
        .text "すばやさ"
        .word $0000
        .enc "none"

      aUnknown899D48 ; 89/9D48

        .enc "SJIS"
        .text "うんのよさ"
        .word $0000
        .enc "none"

      aUnknown899D54 ; 89/9D54

        .enc "SJIS"
        .text "しゅびりょく"
        .word $0000
        .enc "none"

      aUnknown899D62 ; 89/9D62

        .enc "SJIS"
        .text "まほうぼうぎょ"
        .word $0000
        .enc "none"


    .endsection Table899D26Section






    .section Unsorted899D72Section

      .al
      .xl

      rlUnknown899D72 ; 89/9D72

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$2400
        sta wR1
        lda #$0265
        sta wR2
        lda #$000A
        sta wR0
        ldx #$0706
        jsl rlDrawBG3TileRun
        lda #$2400
        sta wR1
        lda #$01E5
        sta wR2
        lda #$000B
        sta wR0
        ldx #$0724
        jsl rlDrawBG3TileRun
        lda #$2400
        sta wR1
        lda #$026F
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0A24
        jsl rlDrawBG3TileRun
        lda #$2400
        sta wR1
        lda #$0280
        sta wR2
        lda #$0009
        sta wR0
        ldx #$0A26
        jsl rlDrawBG3TileRun
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #(`aUnknown899F15)<<8
        sta lR18+1
        lda #<>aUnknown899F15
        sta lR18
        ldx #$1E03
        jsl rlDrawMenuTextLine
        lda $7F8193
        beq _9DFA
        lda #(`aUnknown899F0B)<<8
        sta lR18+1
        lda #<>aUnknown899F0B
        sta lR18
        ldx #$2003
        jsl rlDrawMenuTextLine
        bra _9E0B


        _9DFA
        lda #(`aUnknown899F47)<<8
        sta lR18+1
        lda #<>aUnknown899F47
        sta lR18
        ldx #$2003
        jsl rlDrawMenuTextLine

        _9E0B
        lda #(`aUnknown899F1F)<<8
        sta lR18+1
        lda #<>aUnknown899F1F
        sta lR18
        ldx #$2204
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899F27)<<8
        sta lR18+1
        lda #<>aUnknown899F27
        sta lR18
        ldx #$2404
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899F2F)<<8
        sta lR18+1
        lda #<>aUnknown899F2F
        sta lR18
        ldx #$2602
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899F51)<<8
        sta lR18+1
        lda #<>aUnknown899F51
        sta lR18
        ldx #$2802
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899F3B)<<8
        sta lR18+1
        lda #<>aUnknown899F3B
        sta lR18
        ldx #$2A02
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899F5D)<<8
        sta lR18+1
        lda #<>aUnknown899F5D
        sta lR18
        ldx #$1E12
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899F63)<<8
        sta lR18+1
        lda #<>aUnknown899F63
        sta lR18
        ldx #$2012
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899F69)<<8
        sta lR18+1
        lda #<>aUnknown899F69
        sta lR18
        ldx #$2212
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899F6F)<<8
        sta lR18+1
        lda #<>aUnknown899F6F
        sta lR18
        ldx #$2412
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899F75)<<8
        sta lR18+1
        lda #<>aUnknown899F75
        sta lR18
        ldx #$2612
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899F7B)<<8
        sta lR18+1
        lda #<>aUnknown899F7B
        sta lR18
        ldx #$1E19
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899F83)<<8
        sta lR18+1
        lda #<>aUnknown899F83
        sta lR18
        ldx #$2019
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899F8D)<<8
        sta lR18+1
        lda #<>aUnknown899F8D
        sta lR18
        ldx #$2219
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899F93)<<8
        sta lR18+1
        lda #<>aUnknown899F93
        sta lR18
        ldx #$2419
        jsl rlDrawMenuTextLine
        lda #(`aUnknown899F9B)<<8
        sta lR18+1
        lda #<>aUnknown899F9B
        sta lR18
        ldx #$2619
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

        ; 89/9F0B

    .endsection Unsorted899D72Section


    .section Table899F0BSection

      .al
      .xl

      aUnknown899F0B ; 89/9F0B

        .enc "SJIS"
        .text "しょぞく"
        .word $0000
        .enc "none"

      aUnknown899F15 ; 89/9F15

        .enc "SJIS"
        .text "しきかん"
        .word $0000
        .enc "none"

      aUnknown899F1F ; 89/9F1F

        .enc "SJIS"
        .text "かいわ"
        .word $0000
        .enc "none"

      aUnknown899F27 ; 89/9F27

        .enc "SJIS"
        .text "いどう"
        .word $0000
        .enc "none"

      aUnknown899F2F ; 89/9F2F

        .enc "SJIS"
        .text "しょじきん"
        .word $0000
        .enc "none"

      aUnknown899F3B ; 89/9F3B

        .enc "SJIS"
        .text "じょうたい"
        .word $0000
        .enc "none"

      aUnknown899F47 ; 89/9F47

        .enc "SJIS"
        .text "こいびと"
        .word $0000
        .enc "none"

      aUnknown899F51 ; 89/9F51

        .enc "SJIS"
        .text "とうぎＬＶ"
        .word $0000
        .enc "none"

      aUnknown899F5D ; 89/9F5D

        .enc "SJIS"
        .text "けん"
        .word $0000
        .enc "none"

      aUnknown899F63 ; 89/9F63

        .enc "SJIS"
        .text "やり"
        .word $0000
        .enc "none"

      aUnknown899F69 ; 89/9F69

        .enc "SJIS"
        .text "おの"
        .word $0000
        .enc "none"

      aUnknown899F6F ; 89/9F6F

        .enc "SJIS"
        .text "ゆみ"
        .word $0000
        .enc "none"

      aUnknown899F75 ; 89/9F75

        .enc "SJIS"
        .text "つえ"
        .word $0000
        .enc "none"

      aUnknown899F7B ; 89/9F7B

        .enc "SJIS"
        .text "ほのお"
        .word $0000
        .enc "none"

      aUnknown899F83 ; 89/9F83

        .enc "SJIS"
        .text "いかずち"
        .word $0000
        .enc "none"

      aUnknown899F8D ; 89/9F8D

        .enc "SJIS"
        .text "かぜ"
        .word $0000
        .enc "none"

      aUnknown899F93 ; 89/9F93

        .enc "SJIS"
        .text "ひかり"
        .word $0000
        .enc "none"

      aUnknown899F9B ; 89/9F9B

        .enc "SJIS"
        .text "やみ"
        .word $0000
        .enc "none"


    .endsection Table899F0BSection






    .section Unsorted899FA1Section

      .al
      .xl

      rlUnknown899FA1 ; 89/9FA1

        .al
        .xl
        .autsiz
        .databank ?

        cmp #$0000
        beq _9FD4
        phk
        plb
        .databank $89
        sty wR12
        stx wR13
        sta wR14
        stz wR15
        stz wR4
        stz wR5

        _9FB4
        lda wR12
        sec
        sbc wBufferBG3VOFS
        sta wR1
        lda wR13
        sta wR0
        clc
        adc #$000B
        sta wR13
        ldy #$9FD5
        jsl rlPushToOAMBuffer
        inc wR15
        lda wR15
        cmp wR14
        bne _9FB4

        _9FD4
        rtl

        .databank 0

        ; 89/9FD5


      aUnknown899FD5 ; 89/9FD5

        _Sprites := [[(   0,    0), $21, SpriteLarge, $00E, 3, 0, false, false]]

        .structSpriteArray aUnknown899FD5._Sprites

    .endsection Unsorted899FA1Section


    .section Unsorted899FDCSection

      .al
      .xl

      rlUnknown899FDC ; 89/9FDC

        .al
        .autsiz
        .databank ?

        ; DMA background and border tiles based on index $0756
        ; Also gets palette
        ; Different backgrounds were probably planned at some point
        ; but regardless of the index, the code is always the same 

        lda $0756,b
        asl a
        tax
        jsr (aUnknown899FEB,x)
        lda #0
        sta aBGPaletteBuffer,b
        rtl

        .databank 0

      aUnknown899FEB ; 89/9FEB

        .word <>rsUnknown899FF3
        .word <>rsUnknown89A00F
        .word <>rsUnknown89A02B
        .word <>rsUnknown89A047

      rsUnknown899FF3 ; 89/9FF3

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWindowFrames, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aWindowPalette,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        rts

        .databank 0

      rsUnknown89A00F ; 89/A00F

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWindowFrames, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aWindowPalette,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        rts

        .databank 0

      rsUnknown89A02B ; 89/A02B

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWindowFrames, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aWindowPalette,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        rts

        .databank 0

      rsUnknown89A047 ; 89/A047

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWindowFrames, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aWindowPalette,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        rts

        .databank 0

      rlGetDialogueBoxGraphicsAndPalette ; 89/A063

        .al
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppDialogueBoxFrames, $0800, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aUnknownDE6200,x
          sta aBGPaletteBuffer,b,x
          dec x
          dec x
          bpl _Loop

        lda #0
        sta aBGPaletteBuffer,b
        rtl

        .databank 0

        ; 89/A085

    .endsection Unsorted899FDCSection


    .section Unsorted89A085Section

      .al
      .xl

      rlUnknown89A085 ; 89/A085

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $89
        cmp #$0000
        beq _A106
        sta $7F82BD
        tya
        and #$00FF
        xba
        lsr a
        lsr a
        sta wR10
        txa
        and #$001F
        asl a
        ora wR10
        sta $7F82BF
        ldx #$0000
        lda $7F82BD
        bpl _A0B2
        dec a
        eor #$FFFF
        inc x

        _A0B2
        sta $7F82C3
        txa
        sta $7F82C1
        ldx #$0000

        _A0BE
        lda $7F82C3
        cmp #$000A
        bmi _A0D2
        sec
        sbc #$000A
        sta $7F82C3
        inc x
        bra _A0BE


        _A0D2
        sta wR10
        stx wR11
        lda $7F82BF
        tax
        ldy #$391B
        lda $7F82C1
        bne _A0E7
        ldy #$391A

        _A0E7
        tya
        sta aBG3TilemapBuffer,x
        inc x
        inc x
        lda wR11
        beq _A0FC
        clc
        adc #$3910
        sta aBG3TilemapBuffer,x
        inc x
        inc x

        _A0FC
        lda wR10
        clc
        adc #$3910
        sta aBG3TilemapBuffer,x

        _A106
        rtl

        .databank 0

        ; 89/A107

    .endsection Unsorted89A085Section


    .section Unsorted89A138Section

      .al
      .xl

      rlUnknown89A138 ; 89/A138

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8195
        cmp #$002B
        bne _A14C
        lda $7F8193
        beq _A14C
        lda #$02B4
        bra rlUnknown89A150


        _A14C
        lda $7F8195

        .databank 0

        ; 89/A150

    .endsection Unsorted89A138Section


    .section Unsorted89A150Section

      .al
      .xl

      rlUnknown89A150 ; 89/A150

        .al
        .autsiz
        .databank ?

        ; portrait stuff for research

        ; A = portrait ID

        jsl rlDecompressDialoguePortrait

        lda #$0800
        sta wR0

        txa
        asl a
        tay
        lda #$6200
        sta wR1
        phx
        jsl rlDMAByPointer

        plx
        ldx #$001E
        ldy #$001E
        
          -
          lda [$27],y
          sta aOAMPaletteBuffer.aPalette4,b,y
          dec x
          dec x
          dec y
          dec y
          bpl -

        lda $7F8195
        jsl rlGetCharacterPortraitDataID
        cmp #$00F3
        beq +

          lda #$35AD
          sta $029C,b
        
        +
        rtl

        .databank 0

        ; 89/A18C

    .endsection Unsorted89A150Section


    .section Unsorted89A25ASection

      .al
      .xl

      rsUnknown89A25A ; 89/A25A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8989AD
        jsr rsUnknown898AF5
        jsr rsUnknown898A7E
        lda wJoy1Repeated
        bit #$8000
        bne _A27B
        bit #$0100
        bne _A2AE
        bit #$0200
        bne _A2D1
        jsr rsUnknown89A4E3
        jsr rsUnknown8992AD
        rts


        _A27B
        lda #$0021
        jsl rlPlaySoundEffect
        ldx #$0700
        lda #$0010
        ldy #$0010
        jsl rlClearTilemapRect
        jsl rlUnknown899D72
        jsl rlUnknown8998E1
        lda #$0001
        sta wGameStateStep,b
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8A88, $0400, $80, $B700

        jsr rsUnknown8992AD
        rts


        _A2AE
        lda $7F81CF
        inc a
        cmp $7F81B1
        beq _A2CA
        sta $7F81CF
        lda #$0007
        jsl rlPlaySoundEffect
        jsr rsUnknown89A3C0
        jsr rsUnknown8992AD

        _A2CA
        jsr rsUnknown89A4E3
        jsr rsUnknown8992AD
        rts


        _A2D1
        lda $7F81CF
        dec a
        bmi _A2E6
        sta $7F81CF
        lda #$0007
        jsl rlPlaySoundEffect
        jsr rsUnknown89A3C0

        _A2E6
        jsr rsUnknown89A4E3
        jsr rsUnknown8992AD
        rts

        .databank 0

        ; 89/A2ED

    .endsection Unsorted89A25ASection


    .section Unsorted89A2EDSection

      .al
      .xl

      rsUnknown89A2ED ; 89/A2ED

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferINIDISP
        clc
        adc $7F819F
        sta bBufferINIDISP
        rep #$20
        and #$00FF
        cmp #$000F
        bcc _A311
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        lda $7F81A1
        sta wGameStateStep,b

        _A311
        jsr rsUnknown8989AD
        jsr rsUnknown898AF5
        lda $7F81A1
        cmp #$0002
        beq _A32A
        jsr rsUnknown898B3B
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rts


        _A32A
        jsr rsUnknown898D55
        rts

        .databank 0

        ; 89/A32E

      rsUnknown89A32E ; 89/A32E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferINIDISP
        sec
        sbc $7F819F
        sta bBufferINIDISP
        rep #$20
        bpl _A35B
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda $7F81A1
        sta wGameStateStep,b
        lda $7F819D
        beq _A35B
        lda $7F81A5
        sta @l wSelectedUnitDataRAMPointer
        rts


        _A35B
        jsr rsUnknown8989AD
        jsr rsUnknown898AF5
        lda wBufferBG2VOFS
        cmp #$0110
        beq _A372
        jsr rsUnknown898B3B
        jsr rsUnknown898A7E
        jsr rsUnknown8992AD
        rts


        _A372
        jsr rsUnknown898D55
        rts

        .databank 0

        ; 89/A376

    .endsection Unsorted89A2EDSection


    .section Unsorted89A376Section

      .al
      .xl

      rlUnknown89A376 ; 89/A376

        .al
        .xl
        .autsiz
        .databank ?

        stz wR13
        jsl rlUnknown87A415
        lda $7E2000
        beq _A3B9
        lda #$0000

        _A385
        sta wR15
        tax
        lda $7E2002,x
        and #$00FF
        sta wR14
        beq _A3B1
        lda wR15
        asl a
        tax
        lda aUnknown8992E7+23,x
        bmi _A3B1
        sta wR14
        lda wR13
        asl a
        tax
        lda wR15
        sta $7F81B3,x
        lda wR14
        sta $7F81C1,x
        inc wR13

        _A3B1
        lda wR15
        inc a
        cmp #$001F
        bne _A385

        _A3B9
        lda wR13
        sta $7F81B1
        rtl

        .databank 0

        ; 89/A3C0

    .endsection Unsorted89A376Section


    .section Unsorted89A3C0Section

      .al
      .xl

      rsUnknown89A3C0 ; 89/A3C0

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ldx #$0700
        lda #$0010
        ldy #$0010
        jsl rlClearTilemapRect
        lda #$0000
        ldx #$00C0

        _A3D3
        sta $7FAF4E,x
        dec x
        dec x
        bne _A3D3
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $7F81CF
        asl a
        tax
        lda $7F81B3,x
        sta $7F82BD
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89AC56+1,x
        sta lR18+1
        lda aUnknown89AC56,x
        sta lR18
        ldx #$1D05
        jsl rlDrawMenuTextLine
        lda #(`aUnknown89ACC5)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown89ACC5
        sta lMapMenuTilemapRAMEntryPointer,b
        lda $7F81CF
        asl a
        tax
        lda $7F81B3,x
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aSkillDescriptionPointers+1,x
        sta lR18+1
        lda aSkillDescriptionPointers,x
        sta lR18
        ldx #$0000
        jsl rlDrawMenuTextLine
        ldx #$0014

        _A43C
        lda $7FAF4E,x
        sta $7E8B8C,x
        lda $7FAFC6,x
        sta $7E8BCC,x
        dec x
        dec x
        bne _A43C
        ldx #$0014

        _A453
        lda $7FAF62,x
        sta $7E8C0C,x
        lda $7FAFDA,x
        sta $7E8C4C,x
        dec x
        dec x
        bne _A453
        ldx #$0014

        _A46A
        lda $7FAF76,x
        sta $7E8C8C,x
        lda $7FAFEE,x
        sta $7E8CCC,x
        dec x
        dec x
        bne _A46A
        lda #(`aUnknown89ACB3)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aUnknown89ACB3
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda $7F82BD
        jsl rlCheckIfUnitHasSpecifiedPersonalSkill
        bcs _A4A6
        lda #(`aUnknown89A4D3)<<8
        sta lR18+1
        lda #<>aUnknown89A4D3
        sta lR18
        bra _A4B0


        _A4A6
        lda #(`aUnknown89A4C5)<<8
        sta lR18+1
        lda #<>aUnknown89A4C5
        sta lR18

        _A4B0
        ldx #$2704
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8A88, $0400, $80, $B700

        rts

        .databank 0

        ; 89/A4C5

    .endsection Unsorted89A3C0Section


    .section Table89A4C5Section

      .al
      .xl

      aUnknown89A4C5 ; 89/A4C5

        .enc "SJIS"
        .text "こじんスキル"
        .word $0000
        .enc "none"

      aUnknown89A4D3 ; 89/A4D3

        .enc "SJIS"
        .text "へいしゅスキル"
        .word $0000
        .enc "none"


    .endsection Table89A4C5Section






    .section Unsorted89A4E3Section

      .al
      .xl

      rsUnknown89A4E3 ; 89/A4E3

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F81CF
        asl a
        tax
        lda aUnknown89A59E,x
        sta wR0
        lda #$00C9
        sta wR1
        stz wR4
        stz wR5
        lda wVBlankEnabledFramecount
        lsr a
        lsr a
        lsr a
        and #$0003
        asl a
        tax
        lda aUnknown89A572,x
        tay
        phk
        plb
        .databank $89
        jsl rlPushToOAMBuffer
        lda $7F81CF
        asl a
        tax
        lda $7F81B3,x
        asl a
        tax
        lda @l aUnknown89A52D,x
        sta wR4
        stz wR0
        stz wR1
        stz wR5
        ldy #$A56B
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/A52D

    .endsection Unsorted89A4E3Section


    .section Table89A52DSection

      .al
      .xl

      aUnknown89A52D ; 89/A52D

        ; Read by rsUnknown89A4E3.

        .byte $00, $00, $00, $00, $06, $00, $00, $00, $02, $00, $04, $00, $44, $00, $00, $00
        .byte $46, $00, $00, $00, $00, $00, $00, $00, $08, $00, $0A, $00, $0C, $00, $0E, $00
        .byte $20, $00, $22, $00, $24, $00, $26, $00, $28, $00, $2A, $00, $2C, $00, $2E, $00
        .byte $40, $00, $42, $00, $0E, $01, $00, $00, $48, $00, $4A, $00, $00, $00, $01, $00
        .byte $14, $C2, $62, $80, $3E

        ; 89/A572

    .endsection Table89A52DSection


    .section Table89A572Section

      .al
      .xl

      aUnknown89A572 ; 89/A572

        ; Read by rsUnknown89A4E3.

        .word $A57A, $A586, $A592, $A586, $0002, $C203, $0A00, $1D70
        .word $00C2, $300A, $0002, $C202, $0A00, $1E70, $00C2, $300A
        .word $0002, $C201, $0A00, $1F70, $00C2, $300A

        ; 89/A59E

    .endsection Table89A572Section


    .section Table89A59ESection

      .al
      .xl

      aUnknown89A59E ; 89/A59E

        ; Read by rsUnknown89A4E3.

        .word $0070, $0084, $0098, $00AC, $00C0, $00D4

        ; 89/A5AA

    .endsection Table89A59ESection


    .section Unsorted89A5AASection

      .al
      .xl

      rsUnknown89A5AA ; 89/A5AA

        .al
        .xl
        .autsiz
        .databank ?

        pha
        tya
        xba
        lsr a
        lsr a
        sta wR0
        txa
        asl a
        clc
        adc wR0
        tay
        pla
        asl a
        asl a
        tax
        lda aUnknown89A5D1,x
        phx
        tyx
        sta aBG3TilemapBuffer,x
        txy
        plx
        lda aUnknown89A5D1+2,x
        tyx
        sta $7E83C8,x
        rts

        .databank 0

        ; 89/A5D1

    .endsection Unsorted89A5AASection


    .section Unsorted89A5D1Section

      .al
      .xl

      aUnknown89A5D1 ; 89/A5D1

        ; Five entries of two BG3 tilemap words: rsUnknown89A5AA writes entry A's first word
        ; at the tile it is given and the second word one row below it.

        .word $392A, $393A, $392B, $393B, $392C, $393C, $38FF, $3909
        .word $39E4, $39F4

        ; 89/A5E5

      rlUnknown89A5E5 ; 89/A5E5

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        sta $7F82C1
        lda $7F8183
        cmp #$DFDC
        beq _A5FB
        lda $7F8193
        beq _A604

        _A5FB
        lda $7F82C1
        sta wSelectedUnitDataRAMPointer,b
        sec
        rts


        _A604
        jsl rlGetSelectedUnitGenerationID
        sta $7F82BD
        sta $7F82BF

        _A610
        lda $7F82BD
        inc a
        cmp #$0019
        bne _A61D
        lda #$0001

        _A61D
        cmp $7F82BF
        beq _A5FB
        sta $7F82BD
        sta @l wRoutineVariable1
        lda #$0000
        jsl rlFindGenerationIDInFactionSlotData
        lda @l wSelectedUnitDataRAMPointer
        beq _A610
        lda wJoy1Input
        bit #$2000
        bne _A651
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        bne _A610
        jsl rlGetSelectedUnitStatus
        cmp #StatusCaptive
        beq _A610

        _A651
        lda #$0027
        jsl rlPlaySoundEffect2
        lda @l wSelectedUnitDataRAMPointer
        sta $7F81A5
        lda #$0003
        sta $7F819F
        sep #$20
        lda #$0C
        sta bBufferINIDISP
        rep #$20
        lda #$000A
        sta wGameStateStep,b
        lda #$BBD9
        sta $7F81A3
        lda #$0004
        sta $7F81A1
        lda $7F82C1
        sta wSelectedUnitDataRAMPointer,b
        clc
        rts

        .databank 0

        ; 89/A68C

      rsUnknown89A68C ; 89/A68C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        lda wSelectedUnitDataRAMPointer,b
        sta $7F82C1
        lda $7F8183
        cmp #$DFDC
        beq _A6A2
        lda $7F8193
        beq _A6AB

        _A6A2
        lda $7F82C1
        sta wSelectedUnitDataRAMPointer,b
        sec
        rts


        _A6AB
        jsl rlGetSelectedUnitGenerationID
        sta $7F82BD
        sta $7F82BF

        _A6B7
        lda $7F82BD
        dec a
        bne _A6C1
        lda #$0018

        _A6C1
        cmp $7F82BF
        beq _A6A2
        sta $7F82BD
        sta @l wRoutineVariable1
        lda #$0000
        jsl rlFindGenerationIDInFactionSlotData
        lda wSelectedUnitDataRAMPointer,b
        beq _A6B7
        lda wJoy1Input
        bit #$2000
        bne _A6F4
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        bne _A6B7
        jsl rlGetSelectedUnitStatus
        cmp #StatusCaptive
        beq _A6B7

        _A6F4
        lda #$0026
        jsl rlPlaySoundEffect2
        lda #$0003
        sta $7F819F
        sep #$20
        lda #$0C
        sta bBufferINIDISP
        rep #$20
        lda #$000A
        sta wGameStateStep,b
        lda #$0004
        sta $7F81A1
        lda #$BBD9
        sta $7F81A3
        lda wSelectedUnitDataRAMPointer,b
        sta $7F81A5
        lda $7F82C1
        sta wSelectedUnitDataRAMPointer,b
        clc
        rts

        .databank 0

        ; 89/A72E

    .endsection Unsorted89A5D1Section


    .section SpriteArray89A72ESection

      .al
      .xl

      aUnknown89A72E ; 89/A72E

        _Sprites := [[(  32,   48), $21, SpriteLarge, $004A, 3, 4, false, false]]
        _Sprites ..= [[(  16,   48), $21, SpriteLarge, $0048, 3, 4, false, false]]
        _Sprites ..= [[(   0,   48), $21, SpriteLarge, $0046, 3, 4, false, false]]
        _Sprites ..= [[(  32,   32), $21, SpriteLarge, $002A, 3, 4, false, false]]
        _Sprites ..= [[(  16,   32), $21, SpriteLarge, $0028, 3, 4, false, false]]
        _Sprites ..= [[(   0,   32), $21, SpriteLarge, $0026, 3, 4, false, false]]
        _Sprites ..= [[(  32,   16), $21, SpriteLarge, $0044, 3, 4, false, false]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $0042, 3, 4, false, false]]
        _Sprites ..= [[(   0,   16), $21, SpriteLarge, $0040, 3, 4, false, false]]
        _Sprites ..= [[(  32,    0), $21, SpriteLarge, $0024, 3, 4, false, false]]
        _Sprites ..= [[(  16,    0), $21, SpriteLarge, $0022, 3, 4, false, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $0020, 3, 4, false, false]]

        .structSpriteArray aUnknown89A72E._Sprites

        ; 89/A76C

    .endsection SpriteArray89A72ESection


    .section Table89A76CSection

      .al
      .xl

      aUnknown89A76C ; 89/A76C

        ; Read by rlUnknown8A8496 (status names) followed by skill descriptions & names.

        .long aUnknown89A781
        .long aUnknown89A78D
        .long aUnknown89A797
        .long aUnknown89A7A3
        .long aUnknown89A7AB
        .long aUnknown89A7B5
        .long aUnknown89A7BF

      aUnknown89A781 ; 89/A781
        .enc "SJIS"
          .text "せいじょう\n"

      aUnknown89A78D ; 89/A78D
        .enc "SJIS"
          .text "ちりょう\n"

      aUnknown89A797 ; 89/A797
        .enc "SJIS"
          .text "アルバイト\n"

      aUnknown89A7A3 ; 89/A7A3
        .enc "SJIS"
          .text "ほりょ\n"

      aUnknown89A7AB ; 89/A7AB
        .enc "SJIS"
          .text "サイレス\n"

      aUnknown89A7B5 ; 89/A7B5
        .enc "SJIS"
          .text "スリープ\n"

      aUnknown89A7BF ; 89/A7BF
        .enc "SJIS"
          .text "バサーク\n"

      aUnknown89A7C9 ; 89/A7C9
        .enc "SJIS"
          .text "あいてのこうげきを　うけとめダメージを　むこうにする\n"

      aUnknown89A7FF ; 89/A7FF
        .enc "SJIS"
          .text "ピンチになったとき　いかりのこうげき\n"

      aUnknown89A825 ; 89/A825
        .enc "SJIS"
          .text "あいてよりも　　　　みがるならば　　　　さいこうげき\n"

      aUnknown89A85B ; 89/A85B
        .enc "SJIS"
          .text "すばやさのかくりつでれんぞくこうげき\n"

      aUnknown89A881 ; 89/A881
        .enc "SJIS"
          .text "こうげきがあたると　あいてのゴールドを　うばう\n"

      aUnknown89A8B1 ; 89/A8B1
        .enc "SJIS"
          .text "りんせつした　　　　ユニットを　　　　　いどうかのうにする\n"

      aUnknown89A8ED ; 89/A8ED
        .enc "SJIS"
          .text "ちかくにいるみかたに１０％のしえんこうか\n"

      aUnknown89A917 ; 89/A917
        .enc "SJIS"
          .text "ひっさつこうげきなどをふうじる\n"

      aUnknown89A937 ; 89/A937
        .enc "SJIS"
          .text "ピンチになると　　　かいひりつがあがる\n"

      aUnknown89A95F ; 89/A95F
        .enc "SJIS"
          .text "ひっさつのいちげき　こうげきりょくが　　２ばいになる\n"

      aUnknown89A995 ; 89/A995
        .enc "SJIS"
          .text "ピンチになったとき　せんせいこうげき　　をする\n"

      aUnknown89A9C5 ; 89/A9C5
        .enc "SJIS"
          .text "みがるであれば　　　ときおり　せんとうがけいぞくする\n"

      aUnknown89A9FB ; 89/A9FB
        .enc "SJIS"
          .text "５かいれんぞくで　　こうげきする\n"

      aUnknown89AA1D ; 89/AA1D
        .enc "SJIS"
          .text "あいてのしゅびりょくをむこうにする\n"

      aUnknown89AA41 ; 89/AA41
        .enc "SJIS"
          .text "あたえたダメージだけＨＰがかいふくする\n"

      aUnknown89AA69 ; 89/AA69
        .enc "SJIS"
          .text "まいターン　　　　　ＨＰが５から１０　　かいふくする\n"

      aUnknown89AA9F ; 89/AA9F
        .enc "SJIS"
          .text "けいけんちを　　　　２ばいもらえる\n"

      aUnknown89AAC3 ; 89/AAC3
        .enc "SJIS"
          .text "かいものや　　　　　しゅうりが　　　　　はんがくでできる\n"

      aUnknown89AAFD ; 89/AAFD
        .enc "SJIS"
          .text "おおたて　　\n"

      aUnknown89AB0B ; 89/AB0B
        .enc "SJIS"
          .text "いかり　　　\n"

      aUnknown89AB19 ; 89/AB19
        .enc "SJIS"
          .text "ついげき　　\n"

      aUnknown89AB27 ; 89/AB27
        .enc "SJIS"
          .text "れんぞく　　\n"

      aUnknown89AB35 ; 89/AB35
        .enc "SJIS"
          .text "ぬすむ　　　\n"

      aUnknown89AB43 ; 89/AB43
        .enc "SJIS"
          .text "おどる　　　\n"

      aUnknown89AB51 ; 89/AB51
        .enc "SJIS"
          .text "カリスマ　　\n"

      aUnknown89AB5F ; 89/AB5F
        .enc "SJIS"
          .text "みきり　　　\n"

      aUnknown89AB6D ; 89/AB6D
        .enc "SJIS"
          .text "いのり　　　\n"

      aUnknown89AB7B ; 89/AB7B
        .enc "SJIS"
          .text "ひっさつ　　\n"

      aUnknown89AB89 ; 89/AB89
        .enc "SJIS"
          .text "まちぶせ　　\n"

      aUnknown89AB97 ; 89/AB97
        .enc "SJIS"
          .text "とつげき　　\n"

      aUnknown89ABA5 ; 89/ABA5
        .enc "SJIS"
          .text "りゅうせい剣\n"

      aUnknown89ABB3 ; 89/ABB3
        .enc "SJIS"
          .text "げっこう剣　\n"

      aUnknown89ABC1 ; 89/ABC1
        .enc "SJIS"
          .text "たいよう剣　\n"

      aUnknown89ABCF ; 89/ABCF
        .enc "SJIS"
          .text "ライブ　　　\n"

      aUnknown89ABDD ; 89/ABDD
        .enc "SJIS"
          .text "エリート　　\n"

      aUnknown89ABEB ; 89/ABEB
        .enc "SJIS"
          .text "ねぎり　　　\n"

        ; 89/ABF9

    .endsection Table89A76CSection


    .section Table89ABF9Section

      .al
      .xl

      aSkillDescriptionPointers ; 89/ABF9

        ; Read by rsUnknown89A3C0.

        .byte $00, $00, $00, $00, $00, $00, $C9, $A7, $89, $FF, $A7, $89, $25, $A8, $89, $5B
        .byte $A8, $89, $81, $A8, $89, $00, $00, $00, $B1, $A8, $89, $00, $00, $00, $00, $00
        .byte $00, $00, $00, $00, $ED, $A8, $89, $00, $00, $00, $17, $A9, $89, $37, $A9, $89
        .byte $5F, $A9, $89, $95, $A9, $89, $C5, $A9, $89, $FB, $A9, $89, $1D, $AA, $89, $41
        .byte $AA, $89, $00, $00, $00, $00, $00, $00, $69, $AA, $89, $9F, $AA, $89, $00, $00
        .byte $00, $00, $00, $00, $C3, $AA, $89, $00, $00, $00, $00, $00, $00

        ; 89/AC56

    .endsection Table89ABF9Section


    .section Unsorted89ACCESection

      .al
      .xl

      rlReviveScreenShow ; 89/ACCE

        .al
        .xl
        .autsiz
        .databank ?

        ; GameState $33: fade-in Revive screen and queue song

        inc wGameStateRoutine1,b
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        lda #$7FF7
        jsl rlQueueSoundCommand
        rtl

        .databank 0

        ; 89/ACE7

      rlReviveScreenRunStep ; 89/ACE7

        .al
        .xl
        .autsiz
        .databank ?

        ; GameState $34: dispatch Revive screen step handler

        phb
        php
        phk
        plb
        .databank $89
        lda wGameStateStep,b
        asl a
        tax
        jsr (aUnknown89ACF6,x)
        plp
        plb
        .databank $89
        rtl

        .databank 0

        ; 89/ACF6

    .endsection Unsorted89ACCESection


    .section Table89ACF6Section

      .al
      .xl

      aUnknown89ACF6 ; 89/ACF6

        ; Jump table of rlReviveScreenRunStep.
        .word <>rsUnknown89AD00
        .word <>rsUnknown89AF58
        .word <>rsUnknown89B058
        .word <>rsUnknown89B0A9
        .word <>rsUnknown89B0A9

    .endsection Table89ACF6Section


    .section ReviveMenuSection

      .al
      .xl

      rsUnknown89AD00 ; 89/AD00

        ; Entry 0 of aUnknown89ACF6. The revive staff's menu (the text asks whom to
        ; revive and confirms); the routines through $89/B058 belong to it.

        .al
        .xl
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _AD31
        lda wJoy1New
        bit #$8000
        bne _AD4A
        bit #$0080
        bne _AD32
        bit #$0040
        bne _AD36
        lda wJoy1Repeated
        bit #$0100
        bne _AD3A
        bit #$0200
        bne _AD3E
        bit #$0800
        bne _AD42
        bit #$0400
        bne _AD46

        _AD31
        rts


        _AD32
        jml _AD9A


        _AD36
        jml rsUnknown89AEB3


        _AD3A
        jml rsUnknown89AEFE


        _AD3E
        jml rsUnknown89AF15


        _AD42
        jml rsUnknown89AF28


        _AD46
        jml rsUnknown89AF3E


        _AD4A
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$00E8
        jsl rlQueueSoundCommand
        sep #$20
        lda bBufferNMITIMEN
        and #$FE
        sta bBufferNMITIMEN
        rep #$20
        lda #$FFFF
        sta wDataWindowCurrentArmy
        sep #$20
        lda bBufferNMITIMEN
        and #$FE
        sta bBufferNMITIMEN
        rep #$20
        lda #$0000
        sta wCastleCursorState,b
        lda #$0000
        sta wCastleScreenHandler,b
        lda #$B6B6
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        lda #$0003
        sta wGameStateStep,b
        rts


        _AD9A
        lda #$000A
        jsl rlPlaySoundEffect
        lda #(`aReviveMenuBlankLine)<<8
        sta lR18+1
        lda #<>aReviveMenuBlankLine
        sta lR18
        ldx #$0203
        jsl rlDrawMenuTextLine
        lda wUnitWindowMaxRows
        dec a
        beq _AE01
        lda wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda aUnitWindowDeploymentSlots,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0203
        jsl rlDrawMenuTextLine
        jsl rlGetMenuTextStringLength
        lda wR10
        clc
        adc #$0003
        sta wR10
        lda #(`aReviveMenuReviveThemText)<<8
        sta lR18+1
        lda #<>aReviveMenuReviveThemText
        sta lR18
        lda #$0002
        and #$00FF
        xba
        ora wR10
        tax
        jsl rlDrawMenuTextLine
        bra _AE12


        _AE01
        lda #(`aReviveMenuConfirmText)<<8
        sta lR18+1
        lda #<>aReviveMenuConfirmText
        sta lR18
        ldx #$0203
        jsl rlDrawMenuTextLine

        _AE12
        lda #(`aReviveMenuYesNoText)<<8
        sta lR18+1
        lda #<>aReviveMenuYesNoText
        sta lR18
        ldx #$0215
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0200, $80, $5000

        lda #$0000
        sta $7FB018
        lda #$0001
        sta wGameStateStep,b
        lda #$0001
        sta wDebugMenuScreenIndex+1
        rts

        .databank 0

        ; 89/AE45

      aReviveMenuReviveThemText ; 89/AE45

        ; をいきかえらせますか (revive them?)
        .enc "SJIS"
        .text "をいきかえらせますか\n"


      aReviveMenuYesNoText ; 89/AE5B

        ; はい (yes), いいえ (no).
        .text "はい　　　いいえ\n"


      aReviveMenuConfirmText ; 89/AE6D

        ; よろしいですか (is that OK?)
        .text "よろしいですか\n"


      aReviveMenuBlankLine ; 89/AE7D

        ; A blank line.
        .text "　　　　　　　　　　　　　　　　　　　　　　　　　　\n"


      rsUnknown89AEB3 ; 89/AEB3

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        jsl rlPlaySoundEffect
        lda wUnitWindowCurrentHighlightLine
        sta wItemWindowCursorRow
        asl a
        tax
        lda aUnitWindowDeploymentSlots,x
        sta wSelectedUnitDataRAMPointer,b
        lda #$DFDC
        sta wDataWindowCurrentArmy
        lda #$BBD9
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        sep #$20
        lda bBufferNMITIMEN
        and #$FE
        sta bBufferNMITIMEN
        rep #$20
        lda #$0003
        sta wGameStateStep,b
        lda #$0000
        sta $7F819D
        rts

        .databank 0

        ; 89/AEFE

      rsUnknown89AEFE ; 89/AEFE

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitWindowCurrentHighlightLine
        inc a
        cmp wUnitWindowMaxRows
        beq _AF14
        sta wUnitWindowCurrentHighlightLine
        lda #$0007
        jsl rlPlaySoundEffect

        _AF14
        rts

        .databank 0

        ; 89/AF15

      rsUnknown89AF15 ; 89/AF15

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitWindowCurrentHighlightLine
        beq _AF27
        dec a
        sta wUnitWindowCurrentHighlightLine
        lda #$0007
        jsl rlPlaySoundEffect

        _AF27
        rts

        .databank 0

        ; 89/AF28

      rsUnknown89AF28 ; 89/AF28

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitWindowCurrentHighlightLine
        sec
        sbc #$0003
        bmi _AF3D
        sta wUnitWindowCurrentHighlightLine
        lda #$0006
        jsl rlPlaySoundEffect

        _AF3D
        rts

        .databank 0

        ; 89/AF3E

      rsUnknown89AF3E ; 89/AF3E

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitWindowCurrentHighlightLine
        clc
        adc #$0003
        cmp wUnitWindowMaxRows
        bpl _AF57
        sta wUnitWindowCurrentHighlightLine
        lda #$0006
        jsl rlPlaySoundEffect

        _AF57
        rts

        .databank 0

        ; 89/AF58

      rsUnknown89AF58 ; 89/AF58

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$0080
        bne _AF77
        bit #$8000
        bne _AF9D
        bit #$0100
        bne _AF6F
        bit #$0200
        bne _AF73
        rts


        _AF6F
        jml rsUnknown89B02E


        _AF73
        jml rsUnknown89B043


        _AF77
        lda $7FB018
        bne _AF9D
        lda #$000A
        jsl rlPlaySoundEffect
        lda $7FB016
        sta wSelectedUnitDataRAMPointer,b
        lda wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda aUnitWindowDeploymentSlots,x
        sta wRoutineVariable1,b
        jsl rlUnknown84B6A6
        rts


        _AF9D
        lda #$0021
        jsl rlPlaySoundEffect
        lda #(`aReviveMenuBlankLine2)<<8
        sta lR18+1
        lda #<>aReviveMenuBlankLine2
        sta lR18
        ldx #$0203
        jsl rlDrawMenuTextLine
        lda #(`aReviveMenuWhomText)<<8
        sta lR18+1
        lda #<>aReviveMenuWhomText
        sta lR18
        ldx #$0203
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0200, $80, $5000

        lda #$0000
        sta wGameStateStep,b
        sta wDebugMenuScreenIndex+1
        rts

        .databank 0

        ; 89/AFDE

      aReviveMenuWhomText ; 89/AFDE

        ; だれをいきかえらせますか (whom will you revive?)
        .enc "SJIS"
        .text "だれをいきかえらせますか\n"


      aReviveMenuBlankLine2 ; 89/AFF8

        ; A blank line.
        .text "　　　　　　　　　　　　　　　　　　　　　　　　　　\n"


      rsUnknown89B02E ; 89/B02E

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FB018
        bne _B042
        lda #$0001
        sta $7FB018
        lda #$0007
        jsl rlPlaySoundEffect

        _B042
        rts

        .databank 0

        ; 89/B043

      rsUnknown89B043 ; 89/B043

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FB018
        beq _B057
        lda #$0000
        sta $7FB018
        lda #$0007
        jsl rlPlaySoundEffect

        _B057
        rts

        .databank 0

        ; 89/B058

    .endsection ReviveMenuSection


    .section Unsorted89B058Section

      .al
      .xl

      rsUnknown89B058 ; 89/B058

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$8000
        bne _B060
        rts


        _B060
        lda #$0021
        jsl rlPlaySoundEffect
        sep #$20
        lda bBufferNMITIMEN
        and #$FE
        sta bBufferNMITIMEN
        rep #$20
        lda #$FFFF
        sta wDataWindowCurrentArmy
        sep #$20
        lda bBufferNMITIMEN
        and #$FE
        sta bBufferNMITIMEN
        rep #$20
        lda #$0000
        sta wCastleCursorState,b
        lda #$0000
        sta wCastleScreenHandler,b
        lda #$B6B6
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        lda #$0004
        sta wGameStateStep,b
        rts

        .databank 0

        ; 89/B0A9

    .endsection Unsorted89B058Section


    .section Unsorted89B0A9Section

      .al
      .xl

      rsUnknown89B0A9 ; 89/B0A9

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 89/B0AA

    .endsection Unsorted89B0A9Section


    .section Unsorted89B0AASection

      .al
      .xl

      rlReviveScreenRender ; 89/B0AA

        .al
        .xl
        .autsiz
        .databank ?

        ; GameState $32: render Revive/Valkyrie screen sprites and BG2VOFS

        lda wDebugMenuScreenIndex+1
        asl a
        tax
        jsr (aUnknown89B0B9,x)
        lda wVBlankEnabledFramecount
        lsr a
        sta wBufferBG2VOFS
        rtl

        .databank 0

        ; 89/B0B9

    .endsection Unsorted89B0AASection


    .section Table89B0B9Section

      .al
      .xl

      aUnknown89B0B9 ; 89/B0B9

        ; Jump table of rlReviveScreenRender.
        .word <>rsUnknown89B0BF
        .word <>rsUnknown89B0C6
        .word <>rsUnknown89B0D0

    .endsection Table89B0B9Section


    .section Unsorted89B0BFSection

      .al
      .xl

      rsUnknown89B0BF ; 89/B0BF

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown89B0D1
        jsr rsUnknown89B20B
        rts

        .databank 0

        ; 89/B0C6

    .endsection Unsorted89B0BFSection


    .section Unsorted89B0C6Section

      .al
      .xl

      rsUnknown89B0C6 ; 89/B0C6

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown89B0D1
        jsr rsUnknown89B20B
        jsr rsUnknown89B285
        rts

        .databank 0

        ; 89/B0D0

    .endsection Unsorted89B0C6Section


    .section Unsorted89B0D0Section

      .al
      .xl

      rsUnknown89B0D0 ; 89/B0D0

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 89/B0D1

    .endsection Unsorted89B0D0Section


    .section Unsorted89B0D1Section

      .al
      .xl

      rsUnknown89B0D1 ; 89/B0D1

        .al
        .xl
        .autsiz
        .databank ?

        lda wGameStateStep,b
        bne _B0D9
        jsr rsUnknown89B2A2

        _B0D9
        phk
        plb
        .databank $89
        lda wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda #$0200
        sta wR5
        jsr rsUnknown89B10C
        lda #$0000

        _B0EC
        sta wUnitWindowCurrentNameLine
        cmp wUnitWindowCurrentHighlightLine
        beq _B100
        asl a
        tax
        lda #$0800
        sta wR5
        jsr rsUnknown89B10C

        _B100
        lda wUnitWindowCurrentNameLine
        inc a
        cmp wUnitWindowMaxRows
        bne _B0EC
        rts

        .databank 0

        ; 89/B10C

    .endsection Unsorted89B0D1Section


    .section Unsorted89B10CSection

      .al
      .xl

      rsUnknown89B10C ; 89/B10C

        .al
        .xl
        .autsiz
        .databank ?

        lda aUnitWindowEquippedWeaponPointers,x
        bmi _B11C
        lda $B133,b,x
        sta wR4
        ldy #$B1F3
        bra _B124


        _B11C
        lda $B163,b,x
        sta wR4
        ldy #$B1FA

        _B124
        lda $B193,b,x
        sta wR0
        lda $B1C3,b,x
        sta wR1
        jsl rlPushToOAMBuffer
        rts

        .databank 0

        ; 89/B133

    .endsection Unsorted89B10CSection


    .section Unsorted89B20BSection

      .al
      .xl

      rsUnknown89B20B ; 89/B20B

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda aUnknown89B225,x
        sta wR0
        lda aUnknown89B255,x
        sta wR1
        lda wGameStateStep,b
        jsl rlUnknown88A704
        rts

        .databank 0

        ; 89/B225

    .endsection Unsorted89B20BSection


    .section Data89B225Section

      .al
      .xl

      aUnknown89B225 ; 89/B225

        ; Read by rsUnknown89B20B.

        .word $0000, $0050, $00A0, $0000, $0050, $00A0, $0000, $0050
        .word $00A0, $0000, $0050, $00A0, $0000, $0050, $00A0, $0000
        .word $0050, $00A0, $0000, $0050, $00A0, $0000, $0050, $00A0

        ; 89/B255

      aUnknown89B255 ; 89/B255

        ; Read by rsUnknown89B20B.

        .word $004B, $004B, $004B, $005B, $005B, $005B, $006B, $006B
        .word $006B, $007B, $007B, $007B, $008B, $008B, $008B, $009B
        .word $009B, $009B, $00AB, $00AB, $00AB, $00BB, $00BB, $00BB

        ; 89/B285

    .endsection Data89B225Section


    .section Unsorted89B285Section

      .al
      .xl

      rsUnknown89B285 ; 89/B285

        .al
        .xl
        .autsiz
        .databank ?

        lda $7FB018
        asl a
        tax
        lda aUnknown89B29E,x
        sta wR0
        lda #$0013
        sta wR1
        lda #$0000
        jsl rlUnknown88A704
        rts

        .databank 0

        ; 89/B29E

    .endsection Unsorted89B285Section


    .section Data89B29ESection

      .al
      .xl

      aUnknown89B29E ; 89/B29E

        ; Read by rsUnknown89B285.

        .word $0095, $00BD

        ; 89/B2A2

    .endsection Data89B29ESection


    .section Unsorted89B2A2Section

      .al
      .xl

      rsUnknown89B2A2 ; 89/B2A2

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda aUnitWindowEquippedWeaponPointers,x
        bmi _B2B2
        jsr rsUnknown89B2B6
        rts


        _B2B2
        jsr rsUnknown89B344
        rts

        .databank 0

        ; 89/B2B6

    .endsection Unsorted89B2A2Section


    .section Unsorted89B2B6Section

      .al
      .xl

      rsUnknown89B2B6 ; 89/B2B6

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda wVBlankEnabledFramecount
        lsr a
        lsr a
        lsr a
        and #$0006
        tax
        lda aUnknown89B30C,x
        sta wR15
        pla
        and #$7FFF
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown88D526+1,x
        sta lR18+1
        lda aUnknown88D526,x
        clc
        adc wR15
        sta lR18
        sta wR14
        lda #$0040
        sta wR0
        lda wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda aUnknown89B314,x
        sta wR1
        jsl rlDMAByPointer
        lda wR14
        clc
        adc #$0040
        sta lR18
        lda wR1
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        rts

        .databank 0

        ; 89/B30C

    .endsection Unsorted89B2B6Section


    .section Data89B30CSection

      .al
      .xl

      aUnknown89B30C ; 89/B30C

        ; Read by rsUnknown89B2B6.

        .word $0000, $0080, $0100, $0080

        ; 89/B314

      aUnknown89B314 ; 89/B314

        ; Read by rsUnknown89B2B6.

        .word $6200, $6220, $6240, $6260, $6280, $62A0, $62C0, $62E0
        .word $6400, $6420, $6440, $6460, $6480, $64A0, $64C0, $64E0
        .word $6600, $6620, $6640, $6660, $6680, $66A0, $66C0, $66E0

        ; 89/B344

    .endsection Data89B30CSection


    .section Unsorted89B344Section

      .al
      .xl

      rsUnknown89B344 ; 89/B344

        .al
        .xl
        .autsiz
        .databank ?

        pha
        lda wVBlankEnabledFramecount
        lsr a
        lsr a
        lsr a
        and #$0006
        tax
        lda aUnknown89B39F,x
        sta wR15
        pla
        and #$7FFF
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown88D5E3+1,x
        sta lR18+1
        lda aUnknown88D5E3,x
        clc
        adc wR15
        sta lR18
        sta wR14
        lda #$0040
        sta wR0
        lda wUnitWindowCurrentHighlightLine
        asl a
        tax
        lda aUnknown89B3A7,x
        sta wR1
        jsl rlDMAByPointer
        lda wR14
        clc
        adc #$0040
        sta lR18
        lda #$0080
        sta wR0
        lda wR1
        clc
        adc #$0100
        sta wR1
        jsl rlDMAByPointer
        rts

        .databank 0

        ; 89/B39F

    .endsection Unsorted89B344Section


    .section Data89B39FSection

      .al
      .xl

      aUnknown89B39F ; 89/B39F

        ; Read by rsUnknown89B344.

        .word $0000, $00C0, $0180, $00C0

        ; 89/B3A7

      aUnknown89B3A7 ; 89/B3A7

        ; Read by rsUnknown89B344.

        .word $6800, $6840, $6880, $68C0, $6A00, $6A40, $6A80, $6AC0
        .word $6C00, $6C40, $6C80, $6CC0, $6E00, $6E40, $6E80, $6EC0
        .word $7000, $7040, $7080, $70C0, $7200, $7240, $7280, $72C0

        ; 89/B3D7

    .endsection Data89B39FSection


    .section Unsorted89B79DSection

      .al
      .xl

      rsUnknown89B79D ; 89/B79D

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsItemWindowRenderCursor
        lda wJoy1New
        bit #$C200
        bne _B7BC
        bit #$0080
        bne _B7EC
        lda wJoy1Repeated
        bit #$0800
        bne _B7FB
        bit #$0400
        bne _B818
        jsr rsUnknown89C119
        rts


        _B7BC
        lda #$0000
        sta wGameStateStep,b
        sta $7F847D
        ldx #$01AA
        lda #$0004
        ldy #$0009
        jsl rlClearTilemapRect
        jsl rlItemWindowDrawItemInfo
        jsl rlDMAByStruct

          .structDMAToVRAM aBG2TilemapBuffer, $02C0, $80, $4000

        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _B7EC
        lda #$000A
        jsl rlPlaySoundEffect
        jsl rlItemWindowSort
        jsr rsUnknown89C119
        rts


        _B7FB
        lda $7F847D
        beq _B814
        dec a
        sta $7F847D
        lda #$0002
        sta wUnitWindowScrollingFlag
        lda #$0006
        jsl rlPlaySoundEffect

        _B814
        jsr rsUnknown89C119
        rts


        _B818
        lda $7F847D
        cmp #$0002
        beq _B834
        inc a
        sta $7F847D
        lda #$0004
        sta wUnitWindowScrollingFlag
        lda #$0006
        jsl rlPlaySoundEffect

        _B834
        jsr rsUnknown89C119
        rts

        .databank 0

        ; 89/B838

    .endsection Unsorted89B79DSection


    .section Unsorted89B838Section

      .al
      .xl

      rsUnknown89B838 ; 89/B838

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$8000
        bne _B840
        rts


        _B840
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0003
        sta wGameStateStep,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 89/B856

    .endsection Unsorted89B838Section


    .section Unsorted89B869Section

      .al
      .xl

      rsUnknown89B869 ; 89/B869

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda bBufferINIDISP
        sec
        sbc #$01
        sta bBufferINIDISP
        rep #$20
        bne _B882
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        jsl rlReturnToCastleScreen

        _B882
        rts

        .databank 0

        ; 89/B883

    .endsection Unsorted89B869Section


    .section Unsorted89BECCSection

      .al
      .xl

      rlDrawBG3TileRun ; 89/BECC

        .al
        .xl
        .autsiz
        .databank ?

        ; wR0 tiles, starting at tile wR2 with attributes wR1, at X in the BG3 tilemap buffer; each tile has the tile $10 after it on the row below. Used by many menus.

        lda wR2
        ora wR1
        sta wR2

        _BED2
        lda wR2
        sta aBG3TilemapBuffer,x
        lda wR2
        clc
        adc #$0010
        sta $7E83C8,x
        inc x
        inc x
        inc wR2
        dec wR0
        bne _BED2
        rtl

        .databank 0

        ; 89/BEEB

    .endsection Unsorted89BECCSection


    .section Unsorted89C119Section

      .al
      .xl

      rsUnknown89C119 ; 89/C119

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitWindowScrollingFlag
        tax
        lda $7F847D
        asl a
        asl a
        asl a
        asl a
        clc
        adc aUnknown89C13E,x
        sta wR1
        lda #$00A5
        sta wR0
        lda #$0000
        sta wUnitWindowScrollingFlag
        jsl rlUnknown88A704
        rts

        .databank 0

        ; 89/C13E

    .endsection Unsorted89C119Section


    .section Data89C13ESection

      .al
      .xl

      aUnknown89C13E ; 89/C13E

        ; Read by rsUnknown89C119.

        .word $0022, $002A, $001A

        ; 89/C144

    .endsection Data89C13ESection


    .section Unsorted89EB26Section

      .al
      .xl

      rlOptionsMenuShow ; 89/EB26

        .al
        .xl
        .autsiz
        .databank ?

        ; GameState $2A: fade-in and initialize Options menu

        inc wGameStateRoutine1,b
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        jsl rlUnknown89F713
        jsl rlUnknown89F7A6
        rtl

        .databank 0

        ; 89/EB40

      rlOptionsMenuRunStep ; 89/EB40

        .al
        .xl
        .autsiz
        .databank ?

        ; GameState $2B: dispatch Options menu step handler

        phb
        php
        phk
        plb
        .databank $89
        lda wGameStateStep,b
        cmp #$0004
        bmi _EB4E

        _EB4C
        bra _EB4C


        _EB4E
        asl a
        tax
        jsr (aUnknown89EB56,x)
        plp
        plb
        .databank $89
        rtl

        .databank 0

        ; 89/EB56

    .endsection Unsorted89EB26Section


    .section Table89EB56Section

      .al
      .xl

      aUnknown89EB56 ; 89/EB56

        ; Jump table of rlOptionsMenuRunStep.
        .word <>rsUnknown89EB5E
        .word <>rsUnknown89EC86
        .word <>rsUnknown89ECB4
        .word <>rsUnknown89ECC6

    .endsection Table89EB56Section


    .section Unsorted89EB5ESection

      .al
      .xl

      rsUnknown89EB5E ; 89/EB5E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $5000

        lda $7F8428
        bmi _EBD7
        bne _EB91
        lda wJoy1Repeated
        bit #$0800
        bne _EBA1
        bit #$0400
        bne _EBB6
        bit #$0110
        bne _EB95
        bit #$0220
        bne _EB99
        lda wJoy1New
        bit #$4000
        bne _EB9D
        rts


        _EB91
        jml _EC01


        _EB95
        jml _EC1A


        _EB99
        jml rsUnknown89EC51


        _EB9D
        jml rsUnknown89EC72


        _EBA1
        lda $7F8400
        beq _EBB5
        lda #$0006
        jsl rlPlaySoundEffect
        lda #$F000
        sta $7F8428

        _EBB5
        rts


        _EBB6
        lda #$0007
        clc
        adc $7F842C
        sta wR0
        lda $7F8400
        cmp wR0
        beq _EBD6
        lda #$0006
        jsl rlPlaySoundEffect
        lda #$1000
        sta $7F8428

        _EBD6
        rts


        _EBD7
        lda $7F8428
        inc a
        sta $7F8428
        and #$000F
        cmp #$0001
        bne _EC00
        lda #$0000
        sta $7F8428
        lda $7F8400
        dec a
        sta $7F8400
        jsl rlUnknown89ED12
        jsl rlUnknown89F246

        _EC00
        rts


        _EC01
        lda #$0000
        sta $7F8428
        lda $7F8400
        inc a
        sta $7F8400
        jsl rlUnknown89ED12
        jsl rlUnknown89F246
        rts


        _EC1A
        lda $7F8400
        tax
        lda aUnknown89EC48,x
        and #$00FF
        sta wR0
        txa
        asl a
        tax
        lda wDebugMenuScreenIndex,x
        inc a
        cmp wR0
        beq _EC47
        sta wDebugMenuScreenIndex,x
        lda #$0007
        jsl rlPlaySoundEffect
        jsl rlUnknown89ED12
        jsl rlUnknown89F065

        _EC47
        rts

        .databank 0

      aUnknown89EC48 ; 89/EC48
        .byte $03, $02, $02, $05, $02, $03, $05, $02, $02

      rsUnknown89EC51 ; 89/EC51

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8400
        asl a
        tax
        lda wDebugMenuScreenIndex,x
        beq _EC71
        dec a
        sta wDebugMenuScreenIndex,x
        lda #$0007
        jsl rlPlaySoundEffect
        jsl rlUnknown89ED12
        jsl rlUnknown89F065

        _EC71
        rts

        .databank 0

      rsUnknown89EC72 ; 89/EC72

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0021
        jsl rlPlaySoundEffect
        jsl rlUnknown89F842
        jsl rlUnknown89ED12
        jsl rlUnknown89F065
        rts

        .databank 0

        ; 89/EC86

      rsUnknown89EC86 ; 89/EC86

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta wGameStateStep,b
        lda wUnknown000D79,b
        bit #$0020
        bne _ECAF
        lda #$0000
        sta wMainGameMode,b
        lda #$B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _ECAF
        jsl rlFadeToCastleScreen
        rts

        .databank 0

        ; 89/ECB4

    .endsection Unsorted89EB5ESection


    .section Unsorted89ECB4Section

      .al
      .xl

      rsUnknown89ECB4 ; 89/ECB4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta wGameStateStep,b
        lda #$0001
        sta wMainGameMode,b
        lda #<>rsUnknown80B122
        sta wMainLoopPointer
        rts

        .databank 0

        ; 89/ECC6

    .endsection Unsorted89ECB4Section


    .section Unsorted89ECC6Section

      .al
      .xl

      rsUnknown89ECC6 ; 89/ECC6

        .al
        .xl
        .autsiz
        .databank ?

        rts

        .databank 0

        ; 89/ECC7

    .endsection Unsorted89ECC6Section


    .section Unsorted89ECC7Section

      .al
      .xl

      rlOptionsMenuRender ; 89/ECC7

        .al
        .xl
        .autsiz
        .databank ?

        ; GameState $29: render Options menu cursor/sprites and check close

        jsl rlUnknown89F630
        jsl rlUnknown89F67F
        jsl rlUnknown89F713
        jsl rlUnknown89F7A6
        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _ECED
        lda wJoy1New
        bit #$8000
        bne _ECEE
        bit #$0080
        bne _ED00

        _ECED
        rtl


        _ECEE
        lda #$0021
        jsl rlPlaySoundEffect
        jsl rlUnknown89F7E6
        lda #$0001
        sta wGameStateStep,b
        rtl


        _ED00
        lda #$000A
        jsl rlPlaySoundEffect
        jsl rlUnknown89F7E6
        lda #$0001
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 89/ED12

    .endsection Unsorted89ECC7Section


    .section Unsorted89ED12Section

      .al
      .xl

      rlUnknown89ED12 ; 89/ED12

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2400
        sta aCurrentTilemapInfo,b
        lda $7F8400
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89ED6A+1,x
        sta lR18+1
        lda aUnknown89ED6A,x
        sta lR18
        lda $7F842C
        beq _ED3A
        ldx #$1415
        bra _ED3D


        _ED3A
        ldx #$1215

        _ED3D
        jsl rlDrawMenuTextLine
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda $7F8400
        cmp #$0009
        bmi _ED52

        _ED50
        bra _ED50


        _ED52
        asl a
        tax
        jsr (aUnknown89ED58,x)
        rtl

        .databank 0

        ; 89/ED58

    .endsection Unsorted89ED12Section


    .section Table89ED58Section

      .al
      .xl

      aUnknown89ED58 ; 89/ED58

        ; Jump table of rlUnknown89ED12.
        .word <>rsUnknown89EDFD
        .word <>rsUnknown89EE50
        .word <>rsUnknown89EE50
        .word <>rsUnknown89EE89
        .word <>rsUnknown89EEFE
        .word <>rsUnknown89EF50
        .word <>rsUnknown89EFA3
        .word <>rsUnknown89EE50
        .word <>rsUnknown89F018

    .endsection Table89ED58Section


    .section Data89ED6ASection

      .al
      .xl

      aUnknown89ED6A ; 89/ED6A

        ; Read by rlUnknown89ED12.

        .byte $85, $ED, $89, $99, $ED, $89, $99, $ED, $89, $AD, $ED, $89, $C1, $ED, $89, $85
        .byte $ED, $89, $D5, $ED, $89, $99, $ED, $89, $E9, $ED, $89, $81, $40, $82, $50, $81
        .byte $40, $81, $40, $82, $51, $81, $40, $81, $40, $82, $52, $81, $40, $00, $00, $82
        .byte $6E, $82, $6D, $81, $40, $81, $40, $81, $40, $81, $40, $82, $6E, $82, $65, $82
        .byte $65, $00, $00, $82, $50, $81, $40, $82, $51, $81, $40, $82, $52, $81, $40, $82
        .byte $53, $81, $40, $82, $54, $00, $00, $83, $8A, $83, $41, $83, $8B, $81, $40, $81
        .byte $40, $81, $40, $82, $CD, $82, $E2, $82, $A2, $00, $00, $82, $4F, $81, $40, $82
        .byte $50, $81, $40, $82, $51, $81, $40, $82, $52, $81, $40, $82, $53, $00, $00, $82
        .byte $D3, $82, $C2, $82, $A4, $81, $40, $81, $40, $82, $A9, $82, $B5, $82, $B1, $82
        .byte $A2, $00, $00

        ; 89/EDFD

    .endsection Data89ED6ASection


    .section Unsorted89EDFDSection

      .al
      .xl

      rsUnknown89EDFD ; 89/EDFD

        .al
        .xl
        .autsiz
        .databank ?

        lda wDebugMenuScreenIndex
        cmp #$0003
        bmi _EE08

        _EE06
        bra _EE06


        _EE08
        asl a
        tax
        jsr (aUnknown89EE0E,x)
        rts

        .databank 0

        ; 89/EE0E

    .endsection Unsorted89EDFDSection


    .section Table89EE0ESection

      .al
      .xl

      aUnknown89EE0E ; 89/EE0E

        ; Jump table of rsUnknown89EDFD.
        .word <>rsUnknown89EE14
        .word <>rsUnknown89EE23
        .word <>rsUnknown89EE32

    .endsection Table89EE0ESection


    .section Unsorted89EE14Section

      .al
      .xl

      rsUnknown89EE14 ; 89/EE14

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown89F88F)<<8
        sta lR18+1
        lda #<>aUnknown89F88F
        sta lR18
        ldx #$1416
        bra rsUnknown89EE32._EE3F

        .databank 0

        ; 89/EE23

      rsUnknown89EE23 ; 89/EE23

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown89F893)<<8
        sta lR18+1
        lda #<>aUnknown89F893
        sta lR18
        ldx #$1419
        bra rsUnknown89EE32._EE3F

        .databank 0

        ; 89/EE32

    .endsection Unsorted89EE14Section


    .section Unsorted89EE32Section

      .al
      .xl

      rsUnknown89EE32 ; 89/EE32

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown89F897)<<8
        sta lR18+1
        lda #<>aUnknown89F897
        sta lR18
        ldx #$141C

        _EE3F
        lda $7F842C
        bne _EE4B
        txa
        sec
        sbc #$0200
        tax

        _EE4B
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/EE50

    .endsection Unsorted89EE32Section


    .section Unsorted89EE50Section

      .al
      .xl

      rsUnknown89EE50 ; 89/EE50

        .al
        .xl
        .autsiz
        .databank ?

        lda wUnitWindowCurrentLineSlotOffset+1
        asl a
        tax
        lda wDebugMenuScreenIndex,x
        beq _EE6B
        lda #(`aUnknown89F8AD)<<8
        sta lR18+1
        lda #<>aUnknown89F8AD
        sta lR18
        ldx #$141B
        bra _EE78


        _EE6B
        lda #(`aUnknown89F8A3)<<8
        sta lR18+1
        lda #<>aUnknown89F8A3
        sta lR18
        ldx #$1415

        _EE78
        lda $7F842C
        bne _EE84
        txa
        sec
        sbc #$0200
        tax

        _EE84
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/EE89

    .endsection Unsorted89EE50Section


    .section Unsorted89EE89Section

      .al
      .xl

      rsUnknown89EE89 ; 89/EE89

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8408
        cmp #$0005
        bmi _EE94

        _EE92
        bra _EE92


        _EE94
        asl a
        tax
        jsr (aUnknown89EE9A,x)
        rts

        .databank 0

        ; 89/EE9A

    .endsection Unsorted89EE89Section


    .section Table89EE9ASection

      .al
      .xl

      aUnknown89EE9A ; 89/EE9A

        ; Jump table of rsUnknown89EE89.
        .word <>rsUnknown89EEA4
        .word <>rsUnknown89EEA4._EEB3
        .word <>rsUnknown89EEA4._EEC2
        .word <>rsUnknown89EEA4._EED1
        .word <>rsUnknown89EEA4._EEE0

    .endsection Table89EE9ASection


    .section Unsorted89EEA4Section

      .al
      .xl

      rsUnknown89EEA4 ; 89/EEA4

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown89F88F)<<8
        sta lR18+1
        lda #<>aUnknown89F88F
        sta lR18
        ldx #$1415
        bra _EEED


        _EEB3
        lda #(`aUnknown89F893)<<8
        sta lR18+1
        lda #<>aUnknown89F893
        sta lR18
        ldx #$1417
        bra _EEED


        _EEC2
        lda #(`aUnknown89F897)<<8
        sta lR18+1
        lda #<>aUnknown89F897
        sta lR18
        ldx #$1419
        bra _EEED


        _EED1
        lda #(`aUnknown89F89B)<<8
        sta lR18+1
        lda #<>aUnknown89F89B
        sta lR18
        ldx #$141B
        bra _EEED


        _EEE0
        lda #(`aUnknown89F89F)<<8
        sta lR18+1
        lda #<>aUnknown89F89F
        sta lR18
        ldx #$141D

        _EEED
        lda $7F842C
        bne _EEF9
        txa
        sec
        sbc #$0200
        tax

        _EEF9
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/EEFE

    .endsection Unsorted89EEA4Section


    .section Unsorted89EEFESection

      .al
      .xl

      rsUnknown89EEFE ; 89/EEFE

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F840A
        cmp #$0002
        bmi _EF09

        _EF07
        bra _EF07


        _EF09
        asl a
        tax
        jsr (aUnknown89EF0F,x)
        rts

        .databank 0

        ; 89/EF0F

    .endsection Unsorted89EEFESection


    .section Table89EF0FSection

      .al
      .xl

      aUnknown89EF0F ; 89/EF0F

        ; Jump table of rsUnknown89EEFE.
        .word <>rsUnknown89EF13
        .word <>rsUnknown89EF13._EF22

    .endsection Table89EF0FSection


    .section Unsorted89EF13Section

      .al
      .xl

      rsUnknown89EF13 ; 89/EF13

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown89EF40)<<8
        sta lR18+1
        lda #<>aUnknown89EF40
        sta lR18
        ldx #$1415
        bra _EF2F


        _EF22
        lda #(`aUnknown89EF48)<<8
        sta lR18+1
        lda #<>aUnknown89EF48
        sta lR18
        ldx #$141B

        _EF2F
        lda $7F842C
        bne _EF3B
        txa
        sec
        sbc #$0200
        tax

        _EF3B
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/EF40

    .endsection Unsorted89EF13Section


    .section Table89EF40Section

      .al
      .xl

      aUnknown89EF40 ; 89/EF40

        .enc "SJIS"
        .text "リアル"
        .word $0000
        .enc "none"

      aUnknown89EF48 ; 89/EF48

        .enc "SJIS"
        .text "はやい"
        .word $0000
        .enc "none"


    .endsection Table89EF40Section






    .section Unsorted89EF50Section

      .al
      .xl

      rsUnknown89EF50 ; 89/EF50

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F840C
        cmp #$0003
        bmi _EF5B

        _EF59
        bra _EF59


        _EF5B
        asl a
        tax
        jsr (aUnknown89EF61,x)
        rts

        .databank 0

        ; 89/EF61

    .endsection Unsorted89EF50Section


    .section Table89EF61Section

      .al
      .xl

      aUnknown89EF61 ; 89/EF61

        ; Jump table of rsUnknown89EF50.
        .word <>rsUnknown89EF67
        .word <>rsUnknown89EF67._EF76
        .word <>rsUnknown89EF67._EF85

    .endsection Table89EF61Section


    .section Unsorted89EF67Section

      .al
      .xl

      rsUnknown89EF67 ; 89/EF67

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown89F88F)<<8
        sta lR18+1
        lda #<>aUnknown89F88F
        sta lR18
        ldx #$1416
        bra _EF92


        _EF76
        lda #(`aUnknown89F893)<<8
        sta lR18+1
        lda #<>aUnknown89F893
        sta lR18
        ldx #$1419
        bra _EF92


        _EF85
        lda #(`aUnknown89F897)<<8
        sta lR18+1
        lda #<>aUnknown89F897
        sta lR18
        ldx #$141C

        _EF92
        lda $7F842C
        bne _EF9E
        txa
        sec
        sbc #$0200
        tax

        _EF9E
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/EFA3

    .endsection Unsorted89EF67Section


    .section Unsorted89EFA3Section

      .al
      .xl

      rsUnknown89EFA3 ; 89/EFA3

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F840E
        cmp #$0005
        bmi _EFAE

        _EFAC
        bra _EFAC


        _EFAE
        asl a
        tax
        jsr (aUnknown89EFB4,x)
        rts

        .databank 0

        ; 89/EFB4

    .endsection Unsorted89EFA3Section


    .section Table89EFB4Section

      .al
      .xl

      aUnknown89EFB4 ; 89/EFB4

        ; Jump table of rsUnknown89EFA3.
        .word <>rsUnknown89EFBE
        .word <>rsUnknown89EFBE._EFCD
        .word <>rsUnknown89EFBE._EFDC
        .word <>rsUnknown89EFBE._EFEB
        .word <>rsUnknown89EFBE._EFFA

    .endsection Table89EFB4Section


    .section Unsorted89EFBESection

      .al
      .xl

      rsUnknown89EFBE ; 89/EFBE

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown89F88B)<<8
        sta lR18+1
        lda #<>aUnknown89F88B
        sta lR18
        ldx #$1415
        bra _F007


        _EFCD
        lda #(`aUnknown89F88F)<<8
        sta lR18+1
        lda #<>aUnknown89F88F
        sta lR18
        ldx #$1417
        bra _F007


        _EFDC
        lda #(`aUnknown89F893)<<8
        sta lR18+1
        lda #<>aUnknown89F893
        sta lR18
        ldx #$1419
        bra _F007


        _EFEB
        lda #(`aUnknown89F897)<<8
        sta lR18+1
        lda #<>aUnknown89F897
        sta lR18
        ldx #$141B
        bra _F007


        _EFFA
        lda #(`aUnknown89F89B)<<8
        sta lR18+1
        lda #<>aUnknown89F89B
        sta lR18
        ldx #$141D

        _F007
        lda $7F842C
        bne _F013
        txa
        sec
        sbc #$0200
        tax

        _F013
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/F018

    .endsection Unsorted89EFBESection


    .section Unsorted89F018Section

      .al
      .xl

      rsUnknown89F018 ; 89/F018

        .al
        .xl
        .autsiz
        .databank ?

        lda wDebugMenuTemp2
        cmp #$0002
        bmi _F023

        _F021
        bra _F021


        _F023
        asl a
        tax
        jsr (aUnknown89F029,x)
        rts

        .databank 0

        ; 89/F029

    .endsection Unsorted89F018Section


    .section Table89F029Section

      .al
      .xl

      aUnknown89F029 ; 89/F029

        ; Jump table of rsUnknown89F018.
        .word <>rsUnknown89F02D
        .word <>rsUnknown89F03F

    .endsection Table89F029Section


    .section Unsorted89F02DSection

      .al
      .xl

      rsUnknown89F02D ; 89/F02D

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown89F05B)<<8
        sta lR18+1
        lda #<>aUnknown89F05B
        sta lR18
        ldx #$1415
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/F03F

      rsUnknown89F03F ; 89/F03F

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aUnknown89F051)<<8
        sta lR18+1
        lda #<>aUnknown89F051
        sta lR18
        ldx #$141A
        jsl rlDrawMenuTextLine
        rts

        .databank 0

        ; 89/F051

    .endsection Unsorted89F02DSection


    .section Table89F051Section

      .al
      .xl

      aUnknown89F051 ; 89/F051

        .enc "SJIS"
        .text "かしこい"
        .word $0000
        .enc "none"

      aUnknown89F05B ; 89/F05B

        .enc "SJIS"
        .text "ふつう　"
        .word $0000
        .enc "none"


    .endsection Table89F051Section






    .section Unsorted89F065Section

      .al
      .xl

      rlUnknown89F065 ; 89/F065

        .al
        .xl
        .autsiz
        .databank ?

        lda #$3800
        sta aCurrentTilemapInfo,b
        lda wDebugMenuScreenIndex
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89F1B3+1,x
        sta lR18+1
        lda aUnknown89F1B3,x
        sta lR18
        ldx #$040E
        jsl rlDrawMenuTextLine
        lda $7F8404
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89F180+1,x
        sta lR18+1
        lda aUnknown89F180,x
        sta lR18
        ldx #$060E
        jsl rlDrawMenuTextLine
        lda $7F8406
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89F180+1,x
        sta lR18+1
        lda aUnknown89F180,x
        sta lR18
        ldx #$080E
        jsl rlDrawMenuTextLine
        lda $7F8408
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89F186+1,x
        sta lR18+1
        lda aUnknown89F186,x
        sta lR18
        ldx #$0A0E
        jsl rlDrawMenuTextLine
        lda $7F840A
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89F195+1,x
        sta lR18+1
        lda aUnknown89F195,x
        sta lR18
        ldx #$0C0E
        jsl rlDrawMenuTextLine
        lda $7F840C
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89F19B+1,x
        sta lR18+1
        lda aUnknown89F19B,x
        sta lR18
        ldx #$0E0E
        jsl rlDrawMenuTextLine
        lda $7F840E
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89F1A4+1,x
        sta lR18+1
        lda aUnknown89F1A4,x
        sta lR18
        ldx #$100E
        jsl rlDrawMenuTextLine
        lda wDebugMenuTemp1
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89F1C2+1,x
        sta lR18+1
        lda aUnknown89F1C2,x
        sta lR18
        ldx #$120E
        jsl rlDrawMenuTextLine
        lda $7F842C
        beq _F17F
        lda wDebugMenuTemp2
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89F1BC+1,x
        sta lR18+1
        lda aUnknown89F1BC,x
        sta lR18
        ldx #$140E
        jsl rlDrawMenuTextLine

        _F17F
        rtl

        .databank 0

        ; 89/F180

    .endsection Unsorted89F065Section


    .section Data89F180Section

      .al
      .xl

      aUnknown89F180 ; 89/F180

        ; Read by rlUnknown89F065.

        .word $F8A3, $AD89, $89F8

        ; 89/F186

      aUnknown89F186 ; 89/F186

        ; Read by rlUnknown89F065.

        .byte $8F, $F8, $89, $93, $F8, $89, $97, $F8, $89, $9B, $F8, $89, $9F, $F8, $89

        ; 89/F195

      aUnknown89F195 ; 89/F195

        ; Read by rlUnknown89F065.

        .word $F1D0, $C889, $89F1

        ; 89/F19B

      aUnknown89F19B ; 89/F19B

        ; Read by rlUnknown89F065.

        .byte $D8, $F1, $89, $E2, $F1, $89, $AD, $F8, $89

        ; 89/F1A4

      aUnknown89F1A4 ; 89/F1A4

        ; Read by rlUnknown89F065.

        .byte $AD, $F8, $89, $0A, $F2, $89, $14, $F2, $89, $1E, $F2, $89, $28, $F2, $89

        ; 89/F1B3

      aUnknown89F1B3 ; 89/F1B3

        ; Read by rlUnknown89F065.

        .byte $EC, $F1, $89, $F6, $F1, $89, $00, $F2, $89

        ; 89/F1BC

      aUnknown89F1BC ; 89/F1BC

        ; Read by rlUnknown89F065.

        .word $F23C, $3289, $89F2

        ; 89/F1C2

      aUnknown89F1C2 ; 89/F1C2

        ; Read by rlUnknown89F065.

        .word $F8A3, $AD89, $89F8, $CD82, $E282, $A282, $0000, $8A83
        .word $4183, $8B83, $0000, $5883, $6583, $8C83, $4983, $0000
        .word $8283, $6D83, $8983, $8B83, $0000, $8A83, $4183, $8B83
        .word $4081, $0000, $7D83, $6283, $7683, $4081, $0000, $B182
        .word $9495, $C282, $4081, $0000, $5A83, $5B81, $7583, $5082
        .word $0000, $5A83, $5B81, $7583, $5182, $0000, $5A83, $5B81
        .word $7583, $5282, $0000, $5A83, $5B81, $7583, $5382, $0000
        .word $A982, $B582, $B182, $A282, $0000, $D382, $C282, $A482
        .word $4081, $0000

        ; 89/F246

    .endsection Data89F180Section


    .section Unsorted89F246Section

      .al
      .xl

      rlUnknown89F246 ; 89/F246

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aOptionsMenuDescriptionTilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aOptionsMenuDescriptionTilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        jsr rsUnknown89F620
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $7F8400
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89F338+1,x
        sta lR18+1
        lda aUnknown89F338,x
        sta lR18
        ldx #$0000
        jsl rlDrawMenuTextLine
        ldx #$0000

        _F27C
        lda $7F842E,x
        sta $7E84B4,x
        lda $7F84A6,x
        sta $7E84F4,x
        inc x
        inc x
        cpx #$0012
        bne _F27C
        ldx #$0000

        _F296
        lda $7F8440,x
        sta $7E8532,x
        lda $7F84B8,x
        sta $7E8572,x
        inc x
        inc x
        cpx #$0012
        bne _F296
        ldx #$0000

        _F2B0
        lda $7F8452,x
        sta $7E85B2,x
        lda $7F84CA,x
        sta $7E85F2,x
        inc x
        inc x
        cpx #$0012
        bne _F2B0
        ldx #$0000

        _F2CA
        lda $7F8464,x
        sta $7E8632,x
        lda $7F84DC,x
        sta $7E8672,x
        inc x
        inc x
        cpx #$0012
        bne _F2CA
        ldx #$0000

        _F2E4
        lda $7F8476,x
        sta $7E86B2,x
        lda $7F84EE,x
        sta $7E86F2,x
        inc x
        inc x
        cpx #$0012
        bne _F2E4
        lda #(`aOptionsMenuTilemapEntry)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aOptionsMenuTilemapEntry
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $7F8400
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda aUnknown89F579+1,x
        sta lR18+1
        lda aUnknown89F579,x
        sta lR18
        ldx #$1215
        lda $7F842C
        bne _F333
        txa
        sec
        sbc #$0200
        tax

        _F333
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

        ; 89/F338

    .endsection Unsorted89F246Section


    .section Table89F338Section

      .al
      .xl

      aUnknown89F338 ; 89/F338

        ; Read by rlUnknown89F246.

        .long aUnknown89F353
        .long aUnknown89F397
        .long aUnknown89F3C5
        .long aUnknown89F3F5
        .long aUnknown89F42D
        .long aUnknown89F45B
        .long aUnknown89F4AF
        .long aUnknown89F52F
        .long aUnknown89F4FD

      aUnknown89F353 ; 89/F353
        .enc "SJIS"
          .text "アニメせってい　　　１ーリアル　　　　２ーマップ　　　　３ーこ部つ\n"

      aUnknown89F397 ; 89/F397
        .enc "SJIS"
          .text "ちけいウィンドウ　ちけいウィンドウのひょうじ\n"

      aUnknown89F3C5 ; 89/F3C5
        .enc "SJIS"
          .text "ユニットウィンドウユニットウィンドウのひょうじ\n"

      aUnknown89F3F5 ; 89/F3F5
        .enc "SJIS"
          .text "メッセージスピードメッセージを　　　ひょうじするはやさ\n"

      aUnknown89F42D ; 89/F42D
        .enc "SJIS"
          .text "てきいどうスピードてきのいどうする　スピード\n"

      aUnknown89F45B ; 89/F45B
        .enc "SJIS"
          .text "サウンドせってい　ＢＧＭのせってい　　１ーステレオ　　　２ーモノラル　　　３ーオフ\n"

      aUnknown89F4AF ; 89/F4AF
        .enc "SJIS"
          .text "オートセーブ　　　ターンのはじめに　えらんだファイルへじどうてきにセーブする\n"

      aUnknown89F4FD ; 89/F4FD
        .enc "SJIS"
          .text "てきのあたまのよさてきユニットの　　あたまのよさ\n"

      aUnknown89F52F ; 89/F52F
        .enc "SJIS"
          .text "オートカーソル　　ターンのはじめに　しゅじんこうに　　カーソルをあわせる\n"

        ; 89/F579

    .endsection Table89F338Section


    .section Data89F579Section

      .al
      .xl

      aUnknown89F579 ; 89/F579

        ; Read by rlUnknown89F246.

        .byte $BC, $F5, $89, $A8, $F5, $89, $A8, $F5, $89, $D0, $F5, $89, $94, $F5, $89, $E4
        .byte $F5, $89, $F8, $F5, $89, $A8, $F5, $89, $0C, $F6, $89, $81, $40, $82, $A2, $82
        .byte $C7, $82, $A4, $83, $58, $83, $73, $81, $5B, $83, $68, $81, $40, $00, $00, $82
        .byte $B7, $82, $E9, $81, $40, $81, $40, $81, $40, $81, $40, $82, $B5, $82, $C8, $82
        .byte $A2, $00, $00, $83, $8A, $83, $41, $83, $8B, $81, $40, $81, $40, $81, $40, $82
        .byte $B1, $95, $94, $82, $C2, $00, $00, $82, $A8, $82, $BB, $82, $A2, $81, $40, $81
        .byte $40, $81, $40, $82, $CD, $82, $E2, $82, $A2, $00, $00, $83, $58, $83, $65, $83
        .byte $8C, $83, $49, $81, $40, $81, $40, $81, $40, $83, $49, $83, $74, $00, $00, $83
        .byte $49, $83, $74, $81, $40, $81, $40, $83, $74, $83, $40, $83, $43, $83, $8B, $81
        .byte $40, $00, $00, $81, $40, $82, $A0, $82, $BD, $82, $DC, $82, $CC, $82, $E6, $82
        .byte $B3, $81, $40, $81, $40, $00, $00

        ; 89/F620

    .endsection Data89F579Section


    .section Unsorted89F620Section

      .al
      .xl

      rsUnknown89F620 ; 89/F620

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        tax

        _F624
        sta $7F842E,x
        inc x
        inc x
        cpx #$011A
        bne _F624
        rts

        .databank 0

        ; 89/F630

    .endsection Unsorted89F620Section


    .section Unsorted89F630Section

      .al
      .xl

      rlUnknown89F630 ; 89/F630

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8400
        tax
        lda $7F842C
        beq _F641
        lda aUnknown89F66E,x
        bra _F645


        _F641
        lda aUnknown89F677,x

        _F645
        and #$00FF
        sta wR1
        lda $7F8428
        bmi _F65C
        beq _F664
        lda wR1
        clc
        adc #$000A
        sta wR1
        bra _F664


        _F65C
        lda wR1
        sec
        sbc #$000A
        sta wR1

        _F664
        stz wR0
        lda #$0000
        jsl rlUnknown88A704
        rtl

        .databank 0

        ; 89/F66E

    .endsection Unsorted89F630Section


    .section Data89F66ESection

      .al
      .xl

      aUnknown89F66E ; 89/F66E

        ; Read by rlUnknown89F630.

        .byte $23, $38, $4D, $62, $76, $8B, $A1, $B5, $CA

        ; 89/F677

      aUnknown89F677 ; 89/F677

        ; Read by rlUnknown89F630.

        .word $3B24, $6952, $9780, $C5AE

        ; 89/F67F

    .endsection Data89F66ESection


    .section Unsorted89F67FSection

      .al
      .xl

      rlUnknown89F67F ; 89/F67F

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $89
        lda $7F8400
        asl a
        tax
        asl a
        asl a
        sta wR0
        lda wDebugMenuScreenIndex,x
        clc
        adc wR0
        tax
        lda @l aUnknown89F6BC,x
        and #$00FF
        sta wR0
        sta $7F8548
        lda #$00BD
        sta wR1
        lda $7F842C
        bne _F6B0
        lda #$00B8
        sta wR1

        _F6B0
        stz wR4
        stz wR5
        ldy #$F70C
        jsl rlPushToOAMBuffer
        rtl

        .databank 0

        ; 89/F6BC

    .endsection Unsorted89F67FSection


    .section Data89F6BCSection

      .al
      .xl

      aUnknown89F6BC ; 89/F6BC

        ; Read by rlUnknown89F67F.

        .byte $AC, $C4, $DC, $00, $00, $00, $00, $00, $A8, $DC, $00, $00, $00, $00, $00, $00
        .byte $A8, $DC, $00, $00, $00, $00, $00, $00, $A4, $B4, $C4, $D4, $E4, $00, $00, $00
        .byte $AC, $DC, $00, $00, $00, $00, $00, $00, $AC, $C4, $DC, $00, $00, $00, $00, $00
        .byte $A4, $B4, $C4, $D4, $E4, $00, $00, $00, $A8, $DC, $00, $00, $00, $00, $00, $00
        .byte $AC, $D8, $00, $00, $00, $00, $00, $00, $B1, $B2, $B1, $B0, $C7, $C6, $C7, $C8
        .byte $01, $00, $00, $C2, $00, $0C, $32

        ; 89/F713

    .endsection Data89F6BCSection


    .section Unsorted89F713Section

      .al
      .xl

      rlUnknown89F713 ; 89/F713

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $89
        stz wR0
        lda #$0062
        sta wR1
        stz wR4
        stz wR5
        lda $7F842C
        beq _F72B
        ldy #$F74B
        bra _F72E


        _F72B
        ldy #$F775

        _F72E
        jsl rlPushToOAMBuffer
        lda $7F842C
        beq _F74A
        stz wR0
        lda #$0052
        sta wR1
        stz wR4
        stz wR5
        ldy #$F79F
        jsl rlPushToOAMBuffer

        _F74A
        rtl

        .databank 0

        ; 89/F74B


      aUnknown89F74B ; 89/F74B

        _Sprites := [[(  14,  -65), $21, SpriteLarge, $020, 3, 2, false, false]]
        _Sprites ..= [[(  14,  -44), $21, SpriteLarge, $022, 3, 2, false, false]]
        _Sprites ..= [[(  14,  -23), $21, SpriteLarge, $024, 3, 2, false, false]]
        _Sprites ..= [[(  14,   -2), $21, SpriteLarge, $026, 3, 2, false, false]]
        _Sprites ..= [[(  14,   18), $21, SpriteLarge, $02C, 3, 2, false, false]]
        _Sprites ..= [[(  14,   39), $21, SpriteLarge, $02A, 3, 2, false, false]]
        _Sprites ..= [[(  14,   61), $21, SpriteLarge, $02E, 3, 2, false, false]]
        _Sprites ..= [[(  14,   81), $21, SpriteLarge, $042, 3, 2, false, false]]

        .structSpriteArray aUnknown89F74B._Sprites

      aUnknown89F775 ; 89/F775

        _Sprites := [[(  14,  -63), $21, SpriteLarge, $020, 3, 2, false, false]]
        _Sprites ..= [[(  14,  -40), $21, SpriteLarge, $022, 3, 2, false, false]]
        _Sprites ..= [[(  14,  -16), $21, SpriteLarge, $024, 3, 2, false, false]]
        _Sprites ..= [[(  14,    7), $21, SpriteLarge, $026, 3, 2, false, false]]
        _Sprites ..= [[(  14,   29), $21, SpriteLarge, $02C, 3, 2, false, false]]
        _Sprites ..= [[(  14,   52), $21, SpriteLarge, $02A, 3, 2, false, false]]
        _Sprites ..= [[(  14,   75), $21, SpriteLarge, $02E, 3, 2, false, false]]
        _Sprites ..= [[(  14,   98), $21, SpriteLarge, $042, 3, 2, false, false]]

        .structSpriteArray aUnknown89F775._Sprites

      aUnknown89F79F ; 89/F79F

        _Sprites := [[(  14,  118), $21, SpriteLarge, $040, 3, 2, false, false]]

        .structSpriteArray aUnknown89F79F._Sprites

    .endsection Unsorted89F713Section


    .section Unsorted89F7A6Section

      .al
      .xl

      rlUnknown89F7A6 ; 89/F7A6

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $89
        lda $7F8400
        asl a
        tax
        lda @l aUnknown89F7CD,x
        sta wR4
        stz wR0
        stz wR1
        stz wR5
        lda $7F842C
        bne _F7C5
        lda #$0002
        sta wR1

        _F7C5
        ldy #$F7DF
        jsl rlPushToOAMBuffer
        rtl

        .databank 0

        ; 89/F7CD

    .endsection Unsorted89F7A6Section


    .section Data89F7CDSection

      .al
      .xl

      aUnknown89F7CD ; 89/F7CD

        ; Read by rlUnknown89F7A6.

        .byte $20, $00, $22, $00, $24, $00, $26, $00, $2C, $00, $2A, $00, $2E, $00, $42, $00
        .byte $40, $00, $01, $00, $9F, $C2, $21, $00, $34

        ; 89/F7E6

    .endsection Data89F7CDSection


    .section Unsorted89F7E6Section

      .al
      .xl

      rlUnknown89F7E6 ; 89/F7E6

        .al
        .xl
        .autsiz
        .databank ?

        lda wDebugMenuScreenIndex
        jsl rlSetBattleAnimationOption
        lda $7F8404
        jsl rlSetTerrainWindowSetting
        lda $7F8406
        jsl rlUnknown87BED7
        lda $7F8408
        jsl rlUnknown87BF01
        lda $7F840A
        jsl rlUnknown87BF29
        lda $7F840C
        jsl rlUnknown87BF52
        lda $7F840E
        cmp #$0000
        beq _F822
        lda #$0001

        _F822
        jsl rlUnknown87BFBF
        lda $7F840E
        beq _F831
        dec a
        jsl rlUnknown87BFE9

        _F831
        lda wDebugMenuTemp1
        jsl rlUnknown87C03C
        lda wDebugMenuTemp2
        jsl rlUnknown87C015
        rtl

        .databank 0

        ; 89/F842

    .endsection Unsorted89F7E6Section


    .section Unsorted89F842Section

      .al
      .xl

      rlUnknown89F842 ; 89/F842

        .al
        .xl
        .autsiz
        .databank ?

        lda wDebugMenuTemp3
        sta wDebugMenuScreenIndex
        lda $7F8416
        sta $7F8404
        lda $7F8418
        sta $7F8406
        lda $7F841A
        sta $7F8408
        lda $7F841C
        sta $7F840A
        lda $7F841E
        sta $7F840C
        lda $7F8420
        sta $7F840E
        lda $7F8422
        sta wDebugMenuTemp1
        lda $7F8424
        sta wDebugMenuTemp2
        rtl

        .databank 0

        ; 89/F88B

    .endsection Unsorted89F842Section


    .section Table89F88BSection

      .al
      .xl

      aUnknown89F88B ; 89/F88B

        .enc "SJIS"
        .text "０"
        .word $0000
        .enc "none"

      aUnknown89F88F ; 89/F88F

        .enc "SJIS"
        .text "１"
        .word $0000
        .enc "none"

      aUnknown89F893 ; 89/F893

        .enc "SJIS"
        .text "２"
        .word $0000
        .enc "none"

      aUnknown89F897 ; 89/F897

        .enc "SJIS"
        .text "３"
        .word $0000
        .enc "none"

      aUnknown89F89B ; 89/F89B

        .enc "SJIS"
        .text "４"
        .word $0000
        .enc "none"

      aUnknown89F89F ; 89/F89F

        .enc "SJIS"
        .text "５"
        .word $0000
        .enc "none"

      aUnknown89F8A3 ; 89/F8A3

        .enc "SJIS"
        .text "ＯＮ　　"
        .word $0000
        .enc "none"

      aUnknown89F8AD ; 89/F8AD

        .enc "SJIS"
        .text "ＯＦＦ　"
        .word $0000
        .enc "none"


    .endsection Table89F88BSection






    .section DataDE6200Section

      .al
      .xl

      aUnknownDE6200 ; DE/6200

        ; Read by rlGetDialogueBoxGraphicsAndPalette.

        .word $2253, $2D8C, $7FFF, $0C41, $7FFF, $4651, $7FFF, $2129
        .word $4E69, $28C4, $1042, $10E4, $14E6, $2504, $1CE4, $14C4
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

        ; DE/6230

    .endsection DataDE6200Section
