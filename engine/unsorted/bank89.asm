; Code from bank $89 not yet assigned to a game system.


    .section Unsorted898000Section

      .al
      .xl

      rlUnknown898000 ; 89/8000

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown8994B8
        rtl

        .databank 0

        ; 89/8004

      rlUnknown898004 ; 89/8004

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown8980E0 ; 89/80E0

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $89
        lda wGameStateStep,b
        asl a
        tax
        jsr ($8980EF,x)
        plp
        plb
        .databank $89
        rtl

        .databank 0

        ; 89/80EF

    .endsection Unsorted898000Section


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
        jsl rlUnknown808FAD
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
        stz $0885,b
        lda #$000A
        jsl rlUnknown808FAD

        _826D
        jsr rsUnknown898B3B
        rts


        _8271
        lda #$000A
        jsl rlUnknown808FAD
        lda $7F818F
        bne _82AB
        sta $7F8191
        lda #$0001
        sta $7F818F
        lda #$0005
        sta wGameStateStep,b
        jsr rsUnknown898B3B
        lda #$DD00
        sta lR18+1
        lda #$0000
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
        lda $DE2C9E,x
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
        jsl rlUnknown808FAD
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
        jsl rlUnknown808FAD
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
        jsl rlUnknown808FAD
        lda $7F818F
        bne _84A2
        sta $7F8191
        lda #$0001
        sta $7F818F
        lda #$0005
        sta wGameStateStep,b
        lda #$DD00
        sta lR18+1
        lda #$0000
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
        lda $DE2C9E,x
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
        jsl rlUnknown808FAD
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
        jsl rlUnknown808FAD
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

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
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
        lda $DE2C9E,x
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
        lda $DE00BE,x
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
        jsl rlUnknown808FAD
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
        lda $0885,b
        sec
        sbc #$0010
        sta $0885,b
        lda $7F8185
        dec a
        sta $7F8185
        jsl rlUnknown89876D
        lda #$0006
        jsl rlUnknown808FAD

        _86D5
        jsr rsUnknown8989CE
        rts


        _86D9
        lda $7F8185
        cmp $0889,b
        beq _8700
        lda $0885,b
        clc
        adc #$0010
        sta $0885,b
        lda $7F8185
        inc a
        sta $7F8185
        jsl rlUnknown89876D
        lda #$0006
        jsl rlUnknown808FAD

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
        jsl rlUnknown808FAD
        rts

        .databank 0

        ; 89/8734

    .endsection Unsorted89861BSection


    .section Unsorted898755Section

      .al
      .xl

      rsUnknown898755 ; 89/8755

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta $0D77,b
        lda #$B122
        sta wMainLoopPointer
        lda #$00E8
        jsl rlUnknown808F6F
        rts

        .databank 0

        ; 89/8768

    .endsection Unsorted898755Section


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
        lda #$8900
        sta lR18+1
        lda #$8973
        sta lR18
        ldx #$0F03
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$897F
        sta lR18
        ldx #$1104
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$8989
        sta lR18
        ldx #$1304
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$8993
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
        lda #$8900
        sta lR18+1
        lda #$89A7
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
        jsl rlUnknown89BECC
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
        ldy #$A72E
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
        lda $0885,b
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

    .endsection Unsorted898A7ESection


    .section Unsorted898AF5Section

      .al
      .xl

      rsUnknown898AF5 ; 89/8AF5

        ; Found by tools/sweep.py: nothing in the build reaches this.
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
        lda $0889,b
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
        lda @l $898CBC,x
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
        lda @l $898D41,x
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
        lda @l $898CD7,x
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
        lda @l $898D01,x
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
        lda $89923F,x
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
        lda $899265,x
        sta $7FB0B6,x
        beq _923E
        inc x
        inc x
        bra _9222


        _9230
        lda $899289,x
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


    .section Unsorted89936ESection

      .al
      .xl

      rsUnknown89936E ; 89/936E

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8900
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$ACBC
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
        lda #$8900
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$ACB3
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

        lda #$8900
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$ACBC
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
        lda #$8900
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$ACB3
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
        lda #$8900
        sta lR18+1
        lda #$9703
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
        jsl rlUnknown89BECC
        bra _968B


        _9660
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda #$8900
        sta lR18+1
        lda #$9703
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
        lda #$8900
        sta lR18+1
        lda #$9709
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
        lda #$8900
        sta lR18+1
        lda #$9703
        sta lR18
        ldx #$0508
        jsl rlDrawMenuTextLine

        _9702
        rtl

        .databank 0

        ; 89/9703

    .endsection Unsorted899510Section


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
        sta $0889,b
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
        lda #$8900
        sta lR18+1
        lda #$98DD
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


    .section Unsorted8998E1Section

      .al
      .xl

      rlUnknown8998E1 ; 89/98E1

        ; Found by tools/sweep.py: nothing in the build reaches this.
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
        lda #$8900
        sta lR18+1
        lda #$9B93
        sta lR18
        ldx #$1E08
        jsl rlDrawMenuTextLine

        _991B
        lda $7F8193
        beq _994F
        jsl rlGetFactionSlotNameID
        cmp #$00FF
        bne _9938
        lda #$8900
        sta lRoutineVariable+1,b
        lda #$9B93
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
        lda #$8900
        sta lRoutineVariable+1,b
        lda #$9B93
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
        lda #$8900
        sta lRoutineVariable+1,b
        lda #$9B93
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
        lda #$8900
        sta lR18+1
        lda #$9B9D
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
        lda #$8900
        sta lR18+1
        lda #$9B93
        sta lR18
        ldx #$2208
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9B93
        sta lR18
        ldx #$2808
        jsl rlDrawMenuTextLine

        _9B8E
        rtl

        .databank 0

        ; 89/9B8F

    .endsection Unsorted8998E1Section


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
        jsl rlUnknown89BECC
        lda #$8900
        sta lR18+1
        lda #$9C44
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
        jsl rlUnknown89BECC
        lda #$8900
        sta lR18+1
        lda #$9C4E
        sta lR18
        ldx #$0707
        jsl rlDrawMenuTextLine
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #$8900
        sta lR18+1
        lda #$9C52
        sta lR18
        ldx #$0114
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9C5C
        sta lR18
        ldx #$0313
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9C68
        sta lR18
        ldx #$0514
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9C72
        sta lR18
        ldx #$0714
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

        ; 89/9C44

    .endsection Unsorted899BA5Section


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
        jsl rlUnknown89BECC
        lda #$2400
        sta wR1
        lda #$0240
        sta wR2
        lda #$000C
        sta wR0
        ldx #$02E2
        jsl rlUnknown89BECC
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #$8900
        sta lR18+1
        lda #$9D26
        sta lR18
        ldx #$0D06
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9D2E
        sta lR18
        ldx #$0F05
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9D38
        sta lR18
        ldx #$1107
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9D3E
        sta lR18
        ldx #$1305
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9D48
        sta lR18
        ldx #$1504
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9D54
        sta lR18
        ldx #$1703
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9D62
        sta lR18
        ldx #$1902
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

        ; 89/9D26

    .endsection Unsorted899C7CSection


    .section Unsorted899D72Section

      .al
      .xl

      rlUnknown899D72 ; 89/9D72

        ; Found by tools/sweep.py: nothing in the build reaches this.
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
        jsl rlUnknown89BECC
        lda #$2400
        sta wR1
        lda #$01E5
        sta wR2
        lda #$000B
        sta wR0
        ldx #$0724
        jsl rlUnknown89BECC
        lda #$2400
        sta wR1
        lda #$026F
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0A24
        jsl rlUnknown89BECC
        lda #$2400
        sta wR1
        lda #$0280
        sta wR2
        lda #$0009
        sta wR0
        ldx #$0A26
        jsl rlUnknown89BECC
        lda #$3400
        sta aCurrentTilemapInfo,b
        lda #$8900
        sta lR18+1
        lda #$9F15
        sta lR18
        ldx #$1E03
        jsl rlDrawMenuTextLine
        lda $7F8193
        beq _9DFA
        lda #$8900
        sta lR18+1
        lda #$9F0B
        sta lR18
        ldx #$2003
        jsl rlDrawMenuTextLine
        bra _9E0B


        _9DFA
        lda #$8900
        sta lR18+1
        lda #$9F47
        sta lR18
        ldx #$2003
        jsl rlDrawMenuTextLine

        _9E0B
        lda #$8900
        sta lR18+1
        lda #$9F1F
        sta lR18
        ldx #$2204
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F27
        sta lR18
        ldx #$2404
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F2F
        sta lR18
        ldx #$2602
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F51
        sta lR18
        ldx #$2802
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F3B
        sta lR18
        ldx #$2A02
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F5D
        sta lR18
        ldx #$1E12
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F63
        sta lR18
        ldx #$2012
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F69
        sta lR18
        ldx #$2212
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F6F
        sta lR18
        ldx #$2412
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F75
        sta lR18
        ldx #$2612
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F7B
        sta lR18
        ldx #$1E19
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F83
        sta lR18
        ldx #$2019
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F8D
        sta lR18
        ldx #$2219
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F93
        sta lR18
        ldx #$2419
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$9F9B
        sta lR18
        ldx #$2619
        jsl rlDrawMenuTextLine
        rtl

        .databank 0

        ; 89/9F0B

    .endsection Unsorted899D72Section


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

          .structDMAToVRAM $DD72B0, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aUnknownDE0000,x
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

          .structDMAToVRAM $DD72B0, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aUnknownDE0000,x
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

          .structDMAToVRAM $DD72B0, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aUnknownDE0000,x
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

          .structDMAToVRAM $DD72B0, $0600, $80, $6000

        ldx #size(Palette)-2
        
          _Loop
          lda aUnknownDE0000,x
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

          .structDMAToVRAM $DE2CC0, $0800, $80, $6000

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

        ; Found by tools/sweep.py: nothing in the build reaches this.
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

        ; Found by tools/sweep.py: nothing in the build reaches this.
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
        jsl rlUnknown808FAD
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
        jsl rlUnknown808FAD
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
        jsl rlUnknown808FAD
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

        ; Found by tools/sweep.py: nothing in the build reaches this.
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

        ; Found by tools/sweep.py: nothing in the build reaches this.
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
        lda $8992FE,x
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

        ; Found by tools/sweep.py: nothing in the build reaches this.
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
        lda #$8900
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$ACC5
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
        lda aUnknown89ABF9+1,x
        sta lR18+1
        lda aUnknown89ABF9,x
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
        lda #$8900
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$ACB3
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$3800
        sta aCurrentTilemapInfo,b
        lda $7F82BD
        jsl rlCheckIfUnitHasSpecifiedPersonalSkill
        bcs _A4A6
        lda #$8900
        sta lR18+1
        lda #$A4D3
        sta lR18
        bra _A4B0


        _A4A6
        lda #$8900
        sta lR18+1
        lda #$A4C5
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

        ; Found by tools/sweep.py: nothing in the build reaches this.
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
        jsl rlUnknown80900D
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

        ; Found by tools/sweep.py: nothing in the build reaches this.
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
        jsl rlUnknown80900D
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


    .section Table89ABF9Section

      .al
      .xl

      aUnknown89ABF9 ; 89/ABF9

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

      rlUnknown89ACCE ; 89/ACCE

        .al
        .xl
        .autsiz
        .databank ?

        inc wGameStateRoutine1,b
        lda #(`procFadeIn)<<8
        sta lR44+1
        lda #<>procFadeIn
        sta lR44
        jsl rlProcEngineCreateProc
        lda #$7FF7
        jsl rlUnknown808F6F
        rtl

        .databank 0

        ; 89/ACE7

      rlUnknown89ACE7 ; 89/ACE7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $89
        lda wGameStateStep,b
        asl a
        tax
        jsr ($89ACF6,x)
        plp
        plb
        .databank $89
        rtl

        .databank 0

        ; 89/ACF6

    .endsection Unsorted89ACCESection


    .section Unsorted89B0AASection

      .al
      .xl

      rlUnknown89B0AA ; 89/B0AA

        .al
        .xl
        .autsiz
        .databank ?

        lda wDebugMenuScreenIndex+1
        asl a
        tax
        jsr ($89B0B9,x)
        lda wVBlankEnabledFramecount
        lsr a
        sta wBufferBG2VOFS
        rtl

        .databank 0

        ; 89/B0B9

    .endsection Unsorted89B0AASection


    .section Unsorted89B3D7Section

      .al
      .xl

      rlUnknown89B3D7 ; 89/B3D7

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlEnableActiveSpriteEngine
        inc wGameStateRoutine1,b
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 89/B3E7

      rlUnknown89B3E7 ; 89/B3E7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $89
        lda wGameStateStep,b
        asl a
        tax
        jsr ($89B3F6,x)
        plp
        plb
        .databank $89
        rtl

        .databank 0

        ; 89/B3F6

    .endsection Unsorted89B3D7Section


    .section Unsorted89B400Section

      .al
      .xl

      rsUnknown89B400 ; 89/B400

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown89BEB8
        lda $7F8479
        bmi _B45E
        bne _B462
        lda wJoy1New
        bit #$8000
        bne _B476
        bit #$0020
        bne _B456
        bit #$0010
        bne _B45A
        bit #$0080
        bne _B472
        lda wJoy1Repeated
        bit #$0020
        bne _B456
        bit #$0010
        bne _B45A
        bit #$0800
        bne _B4A3
        bit #$0400
        bne _B452
        lda wJoy1New
        bit #$2000
        bne _B466
        bit #$1000
        bne _B46A
        lda wJoy1Input
        bit #$0C00
        bne _B451
        lda wJoy1New
        bit #$4100
        bne _B46E

        _B451
        rts


        _B452
        jml _B4FC


        _B456
        jml _B556


        _B45A
        jml _B5A9


        _B45E
        jml _B630


        _B462
        jml _B6AF


        _B466
        jml _B568


        _B46A
        jml _B5BE


        _B46E
        jml rsUnknown89B723


        _B472
        jml rsUnknown89B74E


        _B476
        lda #$0021
        jsl rlUnknown808FAD
        lda wUnknown000D79,b
        bit #$0020
        bne _B494
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0003
        sta wGameStateStep,b
        rts


        _B494
        sep #$20
        lda #$0E
        sta bBufferINIDISP
        rep #$20
        lda #$0004
        sta wGameStateStep,b
        rts


        _B4A3
        lda $7F8467
        cmp #$0001
        beq _B4BD
        lda $7F8471
        cmp #$0000
        beq _B4B9
        jml _B4C2


        _B4B9
        jml _B4DF


        _B4BD
        jsl rlUnknown89B91F
        rts


        _B4C2
        lda #$FFFF
        sta $7F8479
        lda #$0000
        sta $7F8475
        sta $7F8477
        lda #$0006
        jsl rlUnknown808FAD
        jml _B630


        _B4DF
        lda #$0001
        sta $7F8479
        lda #$0000
        sta $7F847B
        sta $7F8477
        lda #$0006
        jsl rlUnknown808FAD
        jml _B6AF


        _B4FC
        lda $7F8467
        cmp $7F846B
        beq _B517
        lda $7F8471
        cmp #$000B
        beq _B513
        jml _B51C


        _B513
        jml _B539


        _B517
        jsl rlUnknown89B91F
        rts


        _B51C
        lda #$FFFF
        sta $7F8479
        sta $7F8475
        lda #$0000
        sta $7F8477
        lda #$0006
        jsl rlUnknown808FAD
        jml _B630


        _B539
        lda #$0001
        sta $7F8479
        sta $7F847B
        lda #$0000
        sta $7F8477
        lda #$0006
        jsl rlUnknown808FAD
        jml _B6AF


        _B556
        lda $7F8467
        dec a
        beq _B567
        lda #$0006
        jsl rlUnknown808FAD
        jsr rsUnknown89BFA7

        _B567
        rts


        _B568
        lda $7F8467
        dec a
        beq _B5A8
        lda #$0006
        jsl rlUnknown808FAD
        lda $7F8467
        cmp #$000D
        bcc _B587
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS

        _B587
        lda #$0001
        sta $7F8467
        lda #$0000
        sta $7F846D
        sta $7F8471
        lda #$001C
        sta $7F8473
        jsl rlUnknown89B91F
        jsl rlUnknown89B8BD

        _B5A8
        rts


        _B5A9
        lda $7F8467
        cmp $7F846B
        beq _B5BD
        lda #$0006
        jsl rlUnknown808FAD
        jsr rsUnknown89BEEB

        _B5BD
        rts


        _B5BE
        lda $7F8467
        cmp $7F846B
        beq _B5F1
        lda $7F846B
        sta $7F8467
        lda $7F846B
        cmp #$000D
        bpl _B5F2
        dec a
        sta $7F8471
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$001C
        sta $7F8473
        lda #$0006
        jsl rlUnknown808FAD

        _B5F1
        rts


        _B5F2
        lda #$0006
        jsl rlUnknown808FAD
        lda $7F846D
        lsr a
        cmp $7F846F
        beq _B60C
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS

        _B60C
        lda #$000B
        sta $7F8471
        lda $7F846B
        sec
        sbc #$000C
        asl a
        sta $7F846D
        lda #$00CC
        sta $7F8473
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        rts


        _B630
        lda $7F8475
        bne _B674
        lda $7F8473
        sec
        sbc #$0008
        sta $7F8473
        lda $7F8477
        clc
        adc #$0001
        sta $7F8477
        cmp #$0002
        bne _B6AE
        lda #$0000
        sta $7F8479
        lda $7F8471
        dec a
        sta $7F8471
        lda $7F8467
        dec a
        sta $7F8467
        jsl rlUnknown89B91F
        jml _B6AE


        _B674
        lda $7F8473
        clc
        adc #$0008
        sta $7F8473
        lda $7F8477
        clc
        adc #$0001
        sta $7F8477
        cmp #$0002
        bne _B6AE
        lda #$0000
        sta $7F8479
        lda $7F8471
        inc a
        sta $7F8471
        lda $7F8467
        inc a
        sta $7F8467
        jsl rlUnknown89B91F

        _B6AE
        rts


        _B6AF
        lda $7F847B
        bne _B6EB
        lda wBufferBG2VOFS
        sec
        sbc #$0008
        sta wBufferBG2VOFS
        lda $7F846D
        dec a
        sta $7F846D
        lda $7F8477
        clc
        adc #$0001
        sta $7F8477
        cmp #$0002
        bne _B71A
        lda #$0000
        sta $7F8479
        lda $7F8467
        dec a
        sta $7F8467
        jml _B71A


        _B6EB
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        lda $7F846D
        inc a
        sta $7F846D
        lda $7F8477
        inc a
        sta $7F8477
        cmp #$0002
        bne _B71A
        lda #$0000
        sta $7F8479
        lda $7F8467
        inc a
        sta $7F8467

        _B71A
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        rts

        .databank 0

        ; 89/B723

      rsUnknown89B723 ; 89/B723

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        jsl rlUnknown808FAD
        lda #$0001
        sta wGameStateStep,b
        ldx #$01EA
        lda #$0004
        ldy #$0009
        jsl rlClearTilemapRect
        jsr rsUnknown89C488
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, $02C0, $80, $4000

        rts

        .databank 0

        ; 89/B74E

      rsUnknown89B74E ; 89/B74E

        .al
        .xl
        .autsiz
        .databank ?

        lda #$000A
        jsl rlUnknown808FAD
        jsl rlGetItemRAMStateAndOwner
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitStates
        bit #UnitStateFielded
        beq _B787
        jsl rlGetSelectedUnitDeploymentOffset
        cmp #$0000
        bmi _B778
        sta @l wActiveUnitDeploymentOffset
        jsl rlUnknown8881D7

        _B778
        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #$0003
        sta wGameStateStep,b
        rts


        _B787
        jsl rlGetSelectedUnitDeploymentOffset
        sta wActiveUnitDeploymentOffset,b
        sep #$20
        lda #$0E
        sta bBufferINIDISP
        rep #$20
        lda #$0004
        sta wGameStateStep,b
        rts

        .databank 0

        ; 89/B79D

    .endsection Unsorted89B400Section


    .section Unsorted89B856Section

      .al
      .xl

      rsUnknown89B856 ; 89/B856

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta $0D77,b
        lda #$B122
        sta wMainLoopPointer
        lda #$00E8
        jsl rlUnknown808F6F
        rts

        .databank 0

        ; 89/B869

    .endsection Unsorted89B856Section


    .section Unsorted89B883Section

      .al
      .xl

      rlUnknown89B883 ; 89/B883

        .al
        .xl
        .autsiz
        .databank ?

        lda wGameStateStep,b
        cmp #$0003
        beq _B8BC
        lda $7F846B
        beq _B89E
        jsr rsUnknown89BBB2
        jsr rsUnknown89BD00
        jsr rsUnknown89C144
        lda $7F8467

        _B89E
        ldx #$3920
        stx wR5
        ldx #$0003
        stx wR6
        ldx #$066A
        jsl rlDrawMenuTextNumber
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8448, $0600, $80, $30C0


        _B8BC
        rtl

        .databank 0

        ; 89/B8BD

    .endsection Unsorted89B883Section


    .section Unsorted89B8BDSection

      .al
      .xl

      rlUnknown89B8BD ; 89/B8BD

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F846D
        sta wR0
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR1
        lda #$00C4
        sta wR0
        stz wR4

        _B8D1
        lda #$000F
        sta wR15
        sta wR14
        ldx wR1
        ldy wR0
        lda #$007E
        sep #$20
        pha
        rep #$20
        plb
        .databank $7E

        _B8E5
        lda $7F89D0,x
        sta aBG3TilemapBuffer,y
        inc x
        inc x
        inc y
        inc y
        dec wR15
        bpl _B8E5
        ldx wR1
        ldy wR0

        _B8F8
        lda $7F89F0,x
        sta $83C8,b,y
        inc x
        inc x
        inc y
        inc y
        dec wR14
        bpl _B8F8
        txa
        clc
        adc #$0020
        sta wR1
        tya
        clc
        adc #$0060
        sta wR0
        inc wR4
        lda wR4
        cmp #$000C
        bne _B8D1
        rtl

        .databank 0

        ; 89/B91F

    .endsection Unsorted89B8BDSection


    .section Unsorted89B91FSection

      .al
      .xl

      rlUnknown89B91F ; 89/B91F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown89BAF3
        lda $7F8467
        dec a
        tax
        lda $7F8483,x
        and #$00FF
        asl a
        tax
        lda $7F851A,x
        sta wCurrentItemDataRAMPointer,b
        lda $7F8648,x
        sta wCurrentItemDataROMPointer,b
        lda $7F8776,x
        sta $7F847F
        jsl rlGetItemNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        ldx #$0715
        jsl rlDrawMenuTextLine
        jsl rlGetItemEquipmentType
        cmp #$0000
        bne _B969
        jml _B9A6


        _B969
        cmp #$0001
        beq _B975
        jsr rsUnknown89C1A1
        jml _BAC0


        _B975
        jsl rlGetItemCurrentDurability
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$01F8
        jsl rlDrawMenuTextNumber
        jsl rlGetItemWeaponRank
        cmp #$FFFF
        bne _B996
        lda #$0004

        _B996
        ldx #$0016
        ldy #$0009
        jsr rsUnknown89C5A2
        jsr rsUnknown89C1A1
        jml _BAC0


        _B9A6
        lda #$2400
        sta aCurrentTilemapInfo,b
        lda #$8900
        sta lR18+1
        lda #$BAC1
        sta lR18
        ldx #$0B14
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$BACD
        sta lR18
        ldx #$0D15
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$BAD7
        sta lR18
        ldx #$0F15
        jsl rlDrawMenuTextLine
        lda #$8900
        sta lR18+1
        lda #$BAE1
        sta lR18
        ldx #$1116
        jsl rlDrawMenuTextLine
        lda #$3800
        sta wR1
        lda #$02A0
        sta wR2
        lda #$0001
        sta wR0
        ldx #$03F6
        jsl rlUnknown89BECC
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetItemRAMStateAndOwner
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetItemCurrentDurability
        ldx #$3920
        stx wR5
        ldx #$0002
        stx wR6
        ldx #$01F8
        jsl rlDrawMenuTextNumber
        jsl rlGetItemWeaponRank
        cmp #$FFFF
        bne _BA36
        lda #$0004

        _BA36
        ldx #$0016
        ldy #$0009
        jsr rsUnknown89C5A2
        jsl rlGetItemAccuracy
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$02F4
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMight
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0374
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMinimumRange
        ldx #$3920
        stx wR5
        ldx #$0001
        stx wR6
        ldx #$03F4
        jsl rlDrawMenuTextNumber
        jsl rlGetItemMaximumRange
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$03F8
        jsl rlDrawMenuTextNumber
        jsl rlGetItemWeight
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0474
        jsl rlDrawMenuTextNumber
        jsl rlGetItemRAMKillCountAndCritAbility
        ldx #$3920
        stx wR5
        ldx #$0000
        stx wR6
        ldx #$0274
        jsl rlDrawMenuTextNumber
        jsr rsUnknown89C279

        _BAC0
        rtl

        .databank 0

        ; 89/BAC1

    .endsection Unsorted89B91FSection


    .section Unsorted89BAF3Section

      .al
      .xl

      rsUnknown89BAF3 ; 89/BAF3

        .al
        .xl
        .autsiz
        .databank ?

        lda #$00CE
        ldx #$0016

        _BAF9
        sta $7E856E,x
        dec x
        dec x
        bne _BAF9
        ldx #$0016

        _BB04
        sta $7E85AE,x
        dec x
        dec x
        bne _BB04
        ldx #$0016

        _BB0F
        sta $7E85EE,x
        dec x
        dec x
        bne _BB0F
        ldx #$0016

        _BB1A
        sta $7E862E,x
        dec x
        dec x
        bne _BB1A
        ldx #$0016

        _BB25
        sta $7E866E,x
        dec x
        dec x
        bne _BB25
        ldx #$0016

        _BB30
        sta $7E86AE,x
        dec x
        dec x
        bne _BB30
        ldx #$0016

        _BB3B
        sta $7E86EE,x
        dec x
        dec x
        bne _BB3B
        ldx #$0016

        _BB46
        sta $7E872E,x
        dec x
        dec x
        bne _BB46
        ldx #$0016

        _BB51
        sta $7E876E,x
        dec x
        dec x
        bne _BB51
        ldx #$0016

        _BB5C
        sta $7E87AE,x
        dec x
        dec x
        bne _BB5C
        ldx #$0016

        _BB67
        sta $7E87EE,x
        dec x
        dec x
        bne _BB67
        ldx #$0016

        _BB72
        sta $7E882E,x
        dec x
        dec x
        bne _BB72
        ldx #$0016

        _BB7D
        sta $7E886E,x
        dec x
        dec x
        bne _BB7D
        ldx #$0016

        _BB88
        sta $7E88AE,x
        dec x
        dec x
        bne _BB88
        ldx #$0016

        _BB93
        sta $7E88EE,x
        dec x
        dec x
        bne _BB93
        ldx #$0016

        _BB9E
        sta $7E892E,x
        dec x
        dec x
        bne _BB9E
        ldx #$0016

        _BBA9
        sta $7E896E,x
        dec x
        dec x
        bne _BBA9
        rts

        .databank 0

        ; 89/BBB2

    .endsection Unsorted89BAF3Section


    .section Unsorted89BBB2Section

      .al
      .xl

      rsUnknown89BBB2 ; 89/BBB2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7F846B
        cmp #$000D
        bpl _BC07
        lda #$0000
        sta $7FB010

        _BBC2
        lda $7FB010
        tax
        lda $7F8483,x
        and #$00FF
        beq _BC06
        asl a
        tax
        lda $7F8776,x
        sta wR4
        lda #$0000
        sta wR5
        lda #$000F
        sta wR0
        lda $7FB010
        asl a
        tax
        lda aUnknown89BCCE,x
        clc
        adc #$0002
        sta wR1
        phk
        plb
        .databank $89
        ldy #$C5DD
        jsl rlPushToOAMBuffer
        lda $7FB010
        inc a
        sta $7FB010
        bra _BBC2


        _BC06
        rts


        _BC07
        lda $7F846D
        and #$0001
        bne _BC6F
        lda $7F846D
        lsr a
        sta $7FB010
        lda #$0000
        sta $7FB012

        _BC20
        lda $7FB010
        tax
        lda $7F8483,x
        and #$00FF
        asl a
        tax
        lda $7F8776,x
        sta wR4
        lda #$0000
        sta wR5
        lda #$000F
        sta wR0
        lda $7FB012
        asl a
        tax
        lda @l aUnknown89BCCE,x
        clc
        adc #$0002
        sta wR1
        phk
        plb
        .databank $89
        ldy #$C5DD
        jsl rlPushToOAMBuffer
        lda $7FB010
        inc a
        sta $7FB010
        lda $7FB012
        inc a
        sta $7FB012
        cmp #$000C
        bne _BC20
        rts


        _BC6F
        lda $7F846D
        lsr a
        sta $7FB010
        lda #$0000
        sta $7FB012

        _BC7F
        lda $7FB010
        tax
        lda $7F8483,x
        and #$00FF
        asl a
        tax
        lda $7F8776,x
        sta wR4
        lda #$0000
        sta wR5
        lda #$000F
        sta wR0
        lda $7FB012
        asl a
        tax
        lda @l aUnknown89BCE6,x
        sec
        sbc #$0006
        sta wR1
        phk
        plb
        .databank $89
        ldy #$C5DD
        jsl rlPushToOAMBuffer
        lda $7FB010
        inc a
        sta $7FB010
        lda $7FB012
        inc a
        sta $7FB012
        cmp #$000D
        bne _BC7F
        rts

        .databank 0

        ; 89/BCCE

    .endsection Unsorted89BBB2Section


    .section Table89BCCESection

      .al
      .xl

      aUnknown89BCCE ; 89/BCCE

        ; Read by rsUnknown89BBB2.

        .word $0018, $0028, $0038, $0048, $0058, $0068, $0078, $0088
        .word $0098, $00A8, $00B8, $00C8

        ; 89/BCE6

    .endsection Table89BCCESection


    .section Unsorted89BD00Section

      .al
      .xl

      rsUnknown89BD00 ; 89/BD00

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $89
        lda wGameStateStep,b
        cmp #$0000
        beq _BD24
        cmp #$0004
        beq _BD24
        jsl rlGetItemWeaponType
        sta $7FB010
        jsl rlGetItemEquipmentType
        cmp #$0000
        beq _BD82
        jml _BE48


        _BD24
        lda $7F847F
        sta wR4
        lda #$0000
        sta wR5
        lda #$0098
        sta wR0
        lda #$003A
        sta wR1
        ldy #$BE49
        jsl rlPushToOAMBuffer
        jsl rlGetItemEquipmentType
        cmp #$0000
        beq _BD52
        cmp #$0001
        beq _BD61
        jml _BE48


        _BD52
        stz wR0
        stz wR1
        stz wR4
        stz wR5
        ldy #$BE50
        jsl rlPushToOAMBuffer

        _BD61
        jsl rlGetItemWeaponType
        sta $7FB010
        ldx #$0004
        jsl rlUnknown8BC030
        lda #$0004
        sta wR4
        stz wR5
        stz wR0
        stz wR1
        ldy #$BE6F
        jsl rlPushToOAMBuffer

        _BD82
        lda $7FB010
        cmp #$0005
        bpl _BDD2
        cmp #$0003
        bmi _BD94
        jml _BE48


        _BD94
        lda $7FB010
        asl a
        asl a
        sta $7FB010
        tax
        lda @l $89BE57,x
        ldx #$0006
        jsl rlUnknown8BC030
        lda $7FB010
        tax
        lda @l $89BE59,x
        ldx #$0008
        jsl rlUnknown8BC030
        lda #$009A
        sta wR1
        lda #$0000
        sta wR0
        sta wR4
        sta wR5
        phk
        plb
        .databank $89
        ldy #$BE76
        jsl rlPushToOAMBuffer
        rts


        _BDD2
        cmp #$0008
        bpl _BE14
        lda $7FB010
        sec
        sbc #$0005
        asl a
        asl a
        sta $7FB010
        tax
        lda @l $89BE63,x
        ldx #$0006
        jsl rlUnknown8BC030
        lda $7FB010
        tax
        lda @l $89BE65,x
        ldx #$0008
        jsl rlUnknown8BC030
        lda #$009A
        sta wR1
        stz wR0
        stz wR4
        stz wR5
        ldy #$BE8C
        jsl rlPushToOAMBuffer
        rts


        _BE14
        lda #$0005
        ldx #$0006
        jsl rlUnknown8BC030
        lda #$0006
        ldx #$0008
        jsl rlUnknown8BC030
        lda #$0007
        ldx #$000A
        jsl rlUnknown8BC030
        lda #$009A
        sta wR1
        lda #$0080
        sta wR0
        stz wR4
        stz wR5
        ldy #$BEA2
        jsl rlPushToOAMBuffer
        rts


        _BE48
        rts

        .databank 0

        ; 89/BE49

    .endsection Unsorted89BD00Section


    .section Unsorted89BEB8Section

      .al
      .xl

      rsUnknown89BEB8 ; 89/BEB8

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F8473
        dec a
        sta wR1
        lda #$0001
        sta wR0
        lda wGameStateStep,b
        jsl rlUnknown88A704
        rts

        .databank 0

        ; 89/BECC

    .endsection Unsorted89BEB8Section


    .section Unsorted89BECCSection

      .al
      .xl

      rlUnknown89BECC ; 89/BECC

        .al
        .xl
        .autsiz
        .databank ?

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


    .section Unsorted89BEEBSection

      .al
      .xl

      rsUnknown89BEEB ; 89/BEEB

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7F846D
        clc
        adc #$0018
        lsr a
        cmp $7F846F
        beq _BEFC
        bcs _BF25

        _BEFC
        lda $7F846D
        clc
        adc #$0018
        sta $7F846D
        lda $7F8467
        clc
        adc #$000C
        sta $7F8467
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        rts


        _BF25
        lda $7F846D
        lsr a
        cmp $7F846F
        beq _BF5C
        lda $7F846F
        asl a
        sta $7F846D
        lda $7F846D
        lsr a
        clc
        adc $7F8471
        clc
        adc #$0001
        sta $7F8467
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        rts


        _BF5C
        lda $7F846B
        sta $7F8467
        lda $7F846B
        cmp #$000D
        bcs _BF8B
        lda $7F846B
        dec a
        sta $7F8471
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$001C
        sta $7F8473
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        rts


        _BF8B
        lda #$000B
        sta $7F8471
        asl a
        asl a
        asl a
        asl a
        clc
        adc #$001C
        sta $7F8473
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        rts

        .databank 0

        ; 89/BFA7

      rsUnknown89BFA7 ; 89/BFA7

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7F846D
        sec
        sbc #$0018
        beq _BFF8
        bpl _BFF8
        lda $7F846D
        beq _BFDA
        lda #$0000
        sta $7F846D
        lda $7F8471
        inc a
        sta $7F8467
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        rts


        _BFDA
        lda #$0001
        sta $7F8467
        lda #$0000
        sta $7F8471
        lda #$001C
        sta $7F8473
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        rts


        _BFF8
        lda $7F846D
        sec
        sbc #$0018
        sta $7F846D
        lda $7F8467
        sec
        sbc #$000C
        sta $7F8467
        jsl rlUnknown89B8BD
        jsl rlUnknown89B91F
        lda wBufferBG2VOFS
        clc
        adc #$0008
        sta wBufferBG2VOFS
        rts

        .databank 0

        ; 89/C021

    .endsection Unsorted89BEEBSection


    .section Unsorted89C021Section

      .al
      .xl

      rlUnknown89C021 ; 89/C021

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        ldx #$2580

        _C027
        sta $7F89CE,x
        dec x
        dec x
        bne _C027
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$CD1C
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        sta $7FB010

        _C042
        lda $7FB010
        tax
        lda $7F8483,x
        and #$00FF
        asl a
        tax
        lda $7F851A,x
        sta wCurrentItemDataRAMPointer,b
        lda $7F8648,x
        sta wCurrentItemDataROMPointer,b
        jsl rlGetItemRAMStateAndOwner
        lda wR0
        cmp #$0001
        beq _C08E
        cmp #$0002
        beq _C072
        jml _C0F9


        _C072
        lda $7FB010
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        ora #$001E
        tax
        lda #$3DE3
        sta $7F89D0,x
        lda #$3DF3
        sta $7F89F0,x

        _C08E
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitNamePointer
        lda lRoutineVariable+1,b
        sta lR18+1
        lda lRoutineVariable,b
        sta lR18
        lda $7FB010
        asl a
        and #$00FF
        xba
        ora #$000A
        tax
        jsl rlDrawMenuTextLine
        jsl rlGetItemEquipmentType
        cmp #$0000
        beq _C0CE
        cmp #$0001
        bne _C0DA
        jsl rlCheckStaffEquippable
        bcs _C0DA
        bra _C0D4


        _C0CE
        jsl rlCheckWeaponEquippable
        bcs _C0DA

        _C0D4
        lda #$2400
        sta aCurrentTilemapInfo,b

        _C0DA
        jsl rlGetItemNamePointer
        lda $7FB010
        asl a
        and #$00FF
        xba
        ora #$0002
        tax
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlDrawMenuTextLine

        _C0F9
        lda $7FB010
        inc a
        sta $7FB010
        cmp $7F846B
        beq _C10C
        jml _C042


        _C10C
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$CD13
        sta lMapMenuTilemapRAMEntryPointer,b
        rtl

        .databank 0

        ; 89/C119

    .endsection Unsorted89C021Section


    .section Unsorted89C144Section

      .al
      .xl

      rsUnknown89C144 ; 89/C144

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F846B
        cmp #$000D
        bmi _C180
        lda wVBlankEnabledFramecount
        and #$0008
        beq _C180
        stz wR0
        stz wR4
        stz wR5
        lda #$0080
        sta wR1
        ldy #$0000
        lda $7F846D
        lsr a
        cmp $7F846F
        beq _C176
        inc y
        inc y
        cmp #$0000
        bne _C176
        inc y
        inc y

        _C176
        phk
        plb
        .databank $89
        lda $C181,b,y
        tay
        jsl rlPushToOAMBuffer

        _C180
        rts

        .databank 0

        ; 89/C181

    .endsection Unsorted89C144Section


    .section Unsorted89C1A1Section

      .al
      .xl

      rsUnknown89C1A1 ; 89/C1A1

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$CD25
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        ldx #$00C0

        _C1B3
        sta $7FAF4E,x
        dec x
        dec x
        bne _C1B3
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0000
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$CD13
        sta lMapMenuTilemapRAMEntryPointer,b
        ldx #$0000

        _C1DF
        lda $7FAF50,x
        sta $7E8672,x
        lda $7FAFB0,x
        sta $7E86B2,x
        inc x
        inc x
        cpx #$0010
        bne _C1DF
        ldx #$0000

        _C1F9
        lda $7FAF60,x
        sta $7E86F2,x
        lda $7FAFC0,x
        sta $7E8732,x
        inc x
        inc x
        cpx #$0010
        bne _C1F9
        ldx #$0000

        _C213
        lda $7FAF70,x
        sta $7E8772,x
        lda $7FAFD0,x
        sta $7E87B2,x
        inc x
        inc x
        cpx #$0010
        bne _C213
        ldx #$0000

        _C22D
        lda $7FAF80,x
        sta $7E87F2,x
        lda $7FAFE0,x
        sta $7E8832,x
        inc x
        inc x
        cpx #$0010
        bne _C22D
        ldx #$0000

        _C247
        lda $7FAF90,x
        sta $7E8872,x
        lda $7FAFF0,x
        sta $7E88B2,x
        inc x
        inc x
        cpx #$0010
        bne _C247
        ldx #$0000

        _C261
        lda $7FAFA0,x
        sta $7E88F2,x
        lda $7FB000,x
        sta $7E8932,x
        inc x
        inc x
        cpx #$0010
        bne _C261
        rts

        .databank 0

        ; 89/C279

      rsUnknown89C279 ; 89/C279

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$CD25
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$0000
        ldx #$00C0

        _C28B
        sta $7FAF4E,x
        dec x
        dec x
        bne _C28B
        jsl rlGetItemDescriptionPointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0000
        jsl rlDrawMenuTextLine
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$CD13
        sta lMapMenuTilemapRAMEntryPointer,b
        ldx #$0000

        _C2B7
        lda $7FAF50,x
        sta $7E88F2,x
        lda $7FAFB0,x
        sta $7E8932,x
        inc x
        inc x
        cpx #$0010
        bne _C2B7
        rts

        .databank 0

        ; 89/C2CF

    .endsection Unsorted89C1A1Section


    .section Unsorted89C2CFSection

      .al
      .xl

      rlUnknown89C2CF ; 89/C2CF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7E5333
        asl a
        asl a
        ora $7F847D
        tax
        lda aUnknown89C32C,x
        and #$00FF
        sta $7E5333
        lda $7E5333
        cmp #$0003
        bmi _C2F0

        _C2EE
        bra _C2EE


        _C2F0
        asl a
        tax
        jsr (aUnknown89C326,x)
        jsl rlUnknown89C3F3
        jsl rlUnknown80D143
        jsl rlUnknown89C021
        lda wGameStateStep,b
        beq _C325
        lda #$0000
        sta $7F847D
        jsl rlUnknown89B91F
        ldx #$01EA
        lda #$0004
        ldy #$0009
        jsl rlClearTilemapRect
        jsl rlUnknown89B8BD
        jsr rsUnknown89C488

        _C325
        rtl

        .databank 0

        ; 89/C326

      aUnknown89C326 ; 89/C326

        .word <>rsUnknown89C338
        .word <>rsUnknown89C38A
        .word <>rsUnknown89C3BD

        ; 89/C32C

      aUnknown89C32C ; 89/C32C

        ; Three rows of four, read by rlUnknown89C2CF at (A * 4) | $7F847D. The byte read
        ; picks the routine in aUnknown89C326; $FF (or anything from 3 up) makes it hang.

        .byte $00, $01, $02, $FF
        .byte $01, $02, $00, $FF
        .byte $02, $00, $01, $FF

        ; 89/C338

      rsUnknown89C338 ; 89/C338

        .al
        .xl
        .autsiz
        .databank ?

        ldy #$0000

        _C33B
        tyx
        lda $7F8483,x
        and #$00FF
        asl a
        tax
        lda $7F851A,x
        sta wCurrentItemDataRAMPointer,b
        jsl rlGetItemRAMStateAndOwner
        lda wR0
        cmp #$0001
        beq _C368
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        asl a
        ora #$0001
        sta wR0
        bra _C374


        _C368
        lda wR1
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        asl a
        sta wR0

        _C374
        tya
        asl a
        tax
        lda wR0
        eor #$FFFF
        inc a
        sta $7F88A4,x
        inc y
        tya
        cmp $7F846B
        bne _C33B
        rts

        .databank 0

        ; 89/C38A

      rsUnknown89C38A ; 89/C38A

        .al
        .xl
        .autsiz
        .databank ?

        ldy #$0000

        _C38D
        tyx
        lda $7F8483,x
        and #$00FF
        asl a
        tax
        lda $7F851A,x
        sta wCurrentItemDataRAMPointer,b
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        tax
        lda $89C66E,x
        and #$00FF
        pha
        tya
        asl a
        tax
        pla
        sta $7F88A4,x
        inc y
        tya
        cmp $7F846B
        bne _C38D
        rts

        rts

        .databank 0

        ; 89/C3BD

      rsUnknown89C3BD ; 89/C3BD

        .al
        .xl
        .autsiz
        .databank ?

        ldy #$0000

        _C3C0
        tyx
        lda $7F8483,x
        and #$00FF
        asl a
        tax
        lda $7F851A,x
        sta wCurrentItemDataRAMPointer,b
        jsl rlGetEffectiveItemIDByItemRAMStructEntry
        tax
        lda $89C5E4,x
        and #$00FF
        eor #$FFFF
        inc a
        pha
        tya
        asl a
        tax
        pla
        sta $7F88A4,x
        inc y
        tya
        cmp $7F846B
        bne _C3C0
        rts

        .databank 0

        ; 89/C3F3

    .endsection Unsorted89C2CFSection


    .section Unsorted89C3F3Section

      .al
      .xl

      rlUnknown89C3F3 ; 89/C3F3

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F846B
        cmp #$0001
        beq _C435
        asl a
        sta wR15
        sec
        sbc #$0002
        sta wR14
        lda #$007F
        sep #$20
        pha
        rep #$20
        plb
        .databank $7F
        ldx #$0000

        _C411
        txy
        inc y
        inc y

        _C414
        lda @l $7F88A4,x
        cmp $88A4,b,y
        bcs _C429
        phx
        phy
        txa
        lsr a
        tax
        tya
        lsr a
        jsr rsUnknown89C438
        ply
        plx

        _C429
        inc y
        inc y
        cpy wR15
        bne _C414
        inc x
        inc x
        cpx wR14
        bne _C411

        _C435
        phk
        plb
        .databank $89
        rtl

        .databank 0

        ; 89/C438

      rsUnknown89C438 ; 89/C438

        .al
        .xl
        .autsiz
        .databank ?

        sta wR0
        cpx wR0
        bpl _C441
        tay
        txa
        tyx

        _C441
        sta wR1
        asl a
        sta wR3
        txa
        sta wR2
        asl a
        sta wR4
        sep #$20
        ldx wR2
        lda $7F8483,x
        sta wR0

        _C456
        lda $7F8482,x
        sta $7F8483,x
        dec x
        cpx wR1
        bne _C456
        lda wR0
        sta $7F8483,x
        rep #$20
        ldx wR4
        lda $7F88A4,x
        sta wR0

        _C473
        lda $7F88A2,x
        sta $7F88A4,x
        dec x
        dec x
        cpx wR3
        bne _C473
        lda wR0
        sta $7F88A4,x
        rts

        .databank 0

        ; 89/C488

    .endsection Unsorted89C3F3Section


    .section Unsorted89C488Section

      .al
      .xl

      rsUnknown89C488 ; 89/C488

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7E5333
        beq _C493
        dec a
        beq _C4F0
        bra _C497


        _C493
        jml _C549


        _C497
        lda #$2000
        sta wR1
        lda #$01E0
        sta wR2
        lda #$0003
        sta wR0
        ldx #$012E
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01CF
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0134
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01C8
        sta wR2
        lda #$0004
        sta wR0
        ldx #$01AE
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01CC
        sta wR2
        lda #$0004
        sta wR0
        ldx #$022E
        jsl rlUnknown89BECC
        rts


        _C4F0
        lda #$2000
        sta wR1
        lda #$01CC
        sta wR2
        lda #$0004
        sta wR0
        ldx #$012E
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01E0
        sta wR2
        lda #$0003
        sta wR0
        ldx #$01AE
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01CF
        sta wR2
        lda #$0001
        sta wR0
        ldx #$01B4
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01C8
        sta wR2
        lda #$0004
        sta wR0
        ldx #$022E
        jsl rlUnknown89BECC
        rts


        _C549
        lda #$2000
        sta wR1
        lda #$01C8
        sta wR2
        lda #$0004
        sta wR0
        ldx #$012E
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01CC
        sta wR2
        lda #$0004
        sta wR0
        ldx #$01AE
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01E0
        sta wR2
        lda #$0003
        sta wR0
        ldx #$022E
        jsl rlUnknown89BECC
        lda #$2000
        sta wR1
        lda #$01CF
        sta wR2
        lda #$0001
        sta wR0
        ldx #$0234
        jsl rlUnknown89BECC
        rts

        .databank 0

        ; 89/C5A2

    .endsection Unsorted89C488Section


    .section Unsorted89C5A2Section

      .al
      .xl

      rsUnknown89C5A2 ; 89/C5A2

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
        lda aUnknown89C5C9,x
        phx
        tyx
        sta aBG3TilemapBuffer,x
        txy
        plx
        lda aUnknown89C5C9+2,x
        tyx
        sta $7E83C8,x
        rts

        .databank 0

        ; 89/C5C9

    .endsection Unsorted89C5A2Section


    .section Unsorted89EB26Section

      .al
      .xl

      rlUnknown89EB26 ; 89/EB26

        .al
        .xl
        .autsiz
        .databank ?

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

      rlUnknown89EB40 ; 89/EB40

        .al
        .xl
        .autsiz
        .databank ?

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
        jsr ($89EB56,x)
        plp
        plb
        .databank $89
        rtl

        .databank 0

        ; 89/EB56

    .endsection Unsorted89EB26Section


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
        jml _EC51


        _EB9D
        jml _EC72


        _EBA1
        lda $7F8400
        beq _EBB5
        lda #$0006
        jsl rlUnknown808FAD
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
        jsl rlUnknown808FAD
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
        lda $89EC48,x
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
        jsl rlUnknown808FAD
        jsl rlUnknown89ED12
        jsl rlUnknown89F065

        _EC47
        rts

        .byte $03, $02, $02, $05, $02, $03, $05, $02, $02


        _EC51
        lda $7F8400
        asl a
        tax
        lda wDebugMenuScreenIndex,x
        beq _EC71
        dec a
        sta wDebugMenuScreenIndex,x
        lda #$0007
        jsl rlUnknown808FAD
        jsl rlUnknown89ED12
        jsl rlUnknown89F065

        _EC71
        rts


        _EC72
        lda #$0021
        jsl rlUnknown808FAD
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
        sta $0D77,b
        lda #$B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _ECAF
        jsl rlUnknown80BB7C
        rts

        .databank 0

        ; 89/ECB4

    .endsection Unsorted89EB5ESection


    .section Unsorted89ECC6Section

      .al
      .xl

      rsUnknown89ECC6 ; 89/ECC6

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
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

      rlUnknown89ECC7 ; 89/ECC7

        .al
        .xl
        .autsiz
        .databank ?

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
        jsl rlUnknown808FAD
        jsl rlUnknown89F7E6
        lda #$0001
        sta wGameStateStep,b
        rtl


        _ED00
        lda #$000A
        jsl rlUnknown808FAD
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
        lda $89ED6B,x
        sta lR18+1
        lda $89ED6A,x
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
        jsr ($89ED58,x)
        rtl

        .databank 0

        ; 89/ED58

    .endsection Unsorted89ED12Section


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
        jsr ($89EE0E,x)
        rts

        .databank 0

        ; 89/EE0E

    .endsection Unsorted89EDFDSection


    .section Unsorted89EE32Section

      .al
      .xl

      rsUnknown89EE32 ; 89/EE32

        ; Found through fe4.cdl: it ran, but nothing in the build reaches it yet.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$8900
        sta lR18+1
        lda #$F897
        sta lR18
        ldx #$141C
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
        lda $89F1B4,x
        sta lR18+1
        lda $89F1B3,x
        sta lR18
        ldx #$040E
        jsl rlDrawMenuTextLine
        lda $7F8404
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89F181,x
        sta lR18+1
        lda $89F180,x
        sta lR18
        ldx #$060E
        jsl rlDrawMenuTextLine
        lda $7F8406
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89F181,x
        sta lR18+1
        lda $89F180,x
        sta lR18
        ldx #$080E
        jsl rlDrawMenuTextLine
        lda $7F8408
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89F187,x
        sta lR18+1
        lda $89F186,x
        sta lR18
        ldx #$0A0E
        jsl rlDrawMenuTextLine
        lda $7F840A
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89F196,x
        sta lR18+1
        lda $89F195,x
        sta lR18
        ldx #$0C0E
        jsl rlDrawMenuTextLine
        lda $7F840C
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89F19C,x
        sta lR18+1
        lda $89F19B,x
        sta lR18
        ldx #$0E0E
        jsl rlDrawMenuTextLine
        lda $7F840E
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89F1A5,x
        sta lR18+1
        lda $89F1A4,x
        sta lR18
        ldx #$100E
        jsl rlDrawMenuTextLine
        lda wDebugMenuTemp1
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89F1C3,x
        sta lR18+1
        lda $89F1C2,x
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
        lda $89F1BD,x
        sta lR18+1
        lda $89F1BC,x
        sta lR18
        ldx #$140E
        jsl rlDrawMenuTextLine

        _F17F
        rtl

        .databank 0

        ; 89/F180

    .endsection Unsorted89F065Section


    .section Unsorted89F246Section

      .al
      .xl

      rlUnknown89F246 ; 89/F246

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$E58F
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
        lda $89F339,x
        sta lR18+1
        lda $89F338,x
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
        lda #$8000
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$E586
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda $7F8400
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda $89F57A,x
        sta lR18+1
        lda $89F579,x
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
        lda $89F66E,x
        bra _F645


        _F641
        lda $89F677,x

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
        lda @l $89F6BC,x
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
        lda @l $89F7CD,x
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
