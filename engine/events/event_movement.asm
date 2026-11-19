; Moving units along paths during events: the target map and the movement
; scripts it produces.

    .section ClearEventMovementTargetMapSection

      .al
      .xl

      rlClearEventMovementTargetMap ; 87/B169

        .al
        .autsiz
        .databank ?

        phx
        phy
        ldy #$FFFF
        lda #`aEventMovement.aTargetMap
        ldx #<>aEventMovement.aTargetMap
        jsl rlFillMapBuffer
        ply
        plx
        rtl

        .databank 0

      rlSetEventMovementTargetTile ; 87/B17B

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = value to write to aEventMovement.aTargetMap to specified tile

        php
        phx
        pha
        lda aEventMovement.wTargetYCoordinate
        xba
        lsr a
        lsr a
        clc
        adc aEventMovement.wTargetXCoordinate
        tax

        pla
        sep #$20
        sta aEventMovement.aTargetMap,x
        rep #$20
        plx
        plp
        rtl

        .databank 0

    .endsection ClearEventMovementTargetMapSection


    .section EventMovementMovementScriptBufferAddressesSection

      .al
      .xl

      aEventMovementMovementScriptBufferAddresses ; 87/B4ED

        .word <>aEventMovement.aMovementScriptBuffer1
        .word <>aEventMovement.aMovementScriptBuffer2
        .word <>aEventMovement.aMovementScriptBuffer3
        .word <>aEventMovement.aMovementScriptBuffer4

      aEventMovementMapTileDirectionOffsets ; 87/B4F5

        .sint -64
        .sint 1
        .sint 64
        .sint -1

    .endsection EventMovementMovementScriptBufferAddressesSection


    .section EventMovementWriteToMovementScriptBufferSection

      .al
      .xl

      rsEventMovementWriteToMovementScriptBuffer ; 87/B505

        .al
        .autsiz
        .databank $7E

        phy
        ldy aEventMovement.wMovementScriptBufferAddress
        sta $0000,b,y
        inc y
        sty aEventMovement.wMovementScriptBufferAddress
        ply
        rts

        .databank 0

        ; 87/B512

    .endsection EventMovementWriteToMovementScriptBufferSection
