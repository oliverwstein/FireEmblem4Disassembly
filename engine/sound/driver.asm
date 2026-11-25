; APU sound command queue, script engine, indirect upload helpers, and map-sprite audio.

    .section SoundInitSection

      .al
      .xl

      rlInitSound ; 80/8EF6

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the sound variables, uploads the SPC driver (aSoundHeader.Driver) and
        ; runs the upload list aSoundStartUpload.

        php
        phb
        phk
        plb
        .databank $80
        rep #$30
        phx
        phy
        lda lR38
        pha
        lda lR38+1
        pha
        lda lR39
        pha
        lda lR39+1
        pha
        ldx #$005E
        lda #$0000

        _8F10
        sta wSoundHeaderAddress,b,x
        dec x
        dec x
        bpl _8F10
        lda #(`aSoundHeader) << 8
        sta wSoundDataBankHigh,b
        lda #<>aSoundHeader
        sta wSoundHeaderAddress,b
        lda aSoundHeader.Driver
        tay
        lda aSoundHeader.Driver+1
        clc
        adc wSoundDataBankHigh,b
        sta lR38+1
        stz lR38
        sep #$20
        lda #$FE
        sta bAPUUploading,b
        jsl rlUploadToAPU
        sep #$20
        stz bSoundUploadNoVBlank,b
        lda #$FD
        sta bAPUUploading,b
        rep #$20
        lda wSoundDataBankHigh,b
        sta lR39+1
        lda aSoundHeader.StartUpload
        sta lR39
        lda [lR39]
        sta lR39
        jsl rlRunSoundUploadList
        pla
        sta lR39+1
        pla
        sta lR39
        pla
        sta lR38+1
        pla
        sta lR38
        ply
        plx
        plb
        .databank ?
        plp
        rtl

        .databank 0

        ; 80/8F6F

      rlQueueSoundCommand ; 80/8F6F

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        ; A = command: queues it like rlSendSoundCommand, except that $C8-$DF are
        ; dropped while bit 4 of bSoundFlags is set; $CB-$CD are also kept in
        ; bSoundResendCommand. Values below $C8 and from $E0 up always go through ($C0,
        ; $E0, $E8, $F7 are common).

        php
        phb
        phk
        plb
        .databank $80
        rep #$30
        phx
        pha
        and #$00FF
        cmp #$00C8
        bcc rlPlaySoundEffect._8FC6
        cmp #$00E0
        bcs rlPlaySoundEffect._8FC6
        sep #$20
        stz bSoundResendCommand,b
        cmp #$CE
        bcs _8F94
        cmp #$CB
        bcc _8F94
        sta bSoundResendCommand,b

        _8F94
        rep #$20
        lda bSoundFlags,b
        and #$0010
        beq rlPlaySoundEffect._8FC6
        pla
        plx
        plb
        .databank ?
        plp
        rtl

        .databank 0

        ; 80/8FA3

    .endsection SoundInitSection


    .section Unsorted808FA3Section

      .al
      .xs

      rlSendSoundCommand ; 80/8FA3

        .al
        .autsiz
        .databank ?

        ; A = value: adds it to aSoundEffectQueue whatever bSoundFlags says. Used for
        ; commands from $C0 up, such as $E0 before the phase music changes.

        php
        phb
        phk
        plb
        rep #$30
        phx
        pha
        bra +

      rlPlaySoundEffect ; 80/8FAD

        .al
        .autsiz
        .databank ?

        ; A = sound effect ID: adds it to aSoundEffectQueue, which
        ; rlSendSoundQueuesToAPU sends to APU port 0. Does nothing while bAPUUploading
        ; is set or bit 0 of bSoundFlags is set (sound effects off). Menus use it: $06
        ; cursor, $08 confirm, $21 cancel.

        php
        phb
        phk
        plb
        rep #$30
        phx
        tax
        lda bAPUUploading,b
        and #$00FF
        bne _End

          lda bSoundFlags,b
          and #$0001
          bne _End

            phx

            +

            _8FC6
            ldx #0

              -
              lda aSoundEffectQueue,b,x
              beq +

                inc x
                inc x
                cpx #6
                bcc -

            +
            pla
            sta aSoundEffectQueue,b,x
        
        _End
        plx
        plb
        plp
        rtl

        .databank 0

    .endsection Unsorted808FA3Section


    .section Unsorted808FDDSection

      .al
      .xl

      rlPlaySoundEffect2Checked ; 80/8FDD

        .al
        .autsiz
        .databank ?

        ; Queues port-2 SFX; deduplicates $10/$20 while bAPUUploading is nonzero

        php
        phb
        phk
        plb
        rep #$30
        phx

        tax
        lda bAPUUploading,b
        and #$00FF
        beq rlPlaySoundEffect2._901D

        cpx #$0010
        beq +

        cpx #$0020
        bne rlPlaySoundEffect2._End
        
        +
        cpx aSoundEffect2Queue,b
        beq rlPlaySoundEffect2._End

        cpx aSoundEffect2Queue+2,b
        beq rlPlaySoundEffect2._End

        cpx aSoundEffect2Queue+4,b
        beq rlPlaySoundEffect2._End

        cpx aSoundEffect2Queue+6,b
        beq rlPlaySoundEffect2._End
        bra rlPlaySoundEffect2._901D

      rlPlaySoundEffect2 ; 80/900D

        .al
        .autsiz
        .databank ?

        ; A = sound effect ID: adds it to aSoundEffect2Queue, which
        ; rlSendSoundQueuesToAPU sends to APU port 2. Does nothing while bAPUUploading
        ; is set or bit 2 of bSoundFlags is set. Battle animations use it most.

        php
        phb
        phk
        plb
        rep #$30
        phx
        tax
        lda bAPUUploading,b
        and #$00FF
        bne _End

          _901D
          lda bSoundFlags,b
          and #$0004
          bne _End

          phx
          ldx #0

          -
          lda aSoundEffect2Queue,b,x
          beq +

            inc x
            inc x
            cpx #6
            bcc -

          +
          pla
          sta aSoundEffect2Queue,b,x

        _End
        plx
        plb
        plp
        rtl

        .databank 0

        ; 80/903D

    .endsection Unsorted808FDDSection


    .section Unsorted80903DSection

      .al
      .xl

      rlSoundOnFlag10Cleared ; 80/903D

        .as
        .xl
        .autsiz
        .databank ?

        ; rlUpdateSound calls this when bit 4 of bSoundFlags clears: queues
        ; bSoundResendCommand again unless bit 1 of bAPUStatus is set.

        php
        phb
        phk
        plb
        .databank $80
        rep #$20
        lda bAPUStatus,b
        and #$0002
        bne _9057
        lda bSoundResendCommand,b
        and #$00FF
        beq _9057
        jsl rlQueueSoundCommand

        _9057
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/905A

      rlSoundOnFlag10Set ; 80/905A

        .as
        .xl
        .autsiz
        .databank ?

        ; rlUpdateSound calls this when bit 4 of bSoundFlags sets: sends command $F8 if
        ; bit 1 of bAPUStatus is set.

        php
        phb
        phk
        plb
        .databank $80
        rep #$20
        lda bAPUStatus,b
        and #$0002
        beq _906F
        lda #$00F8
        jsl rlSendSoundCommand

        _906F
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/9072

      rlSoundOnFlag40Cleared ; 80/9072

        .as
        .xl
        .autsiz
        .databank ?

        ; rlUpdateSound calls this when bit 6 of bSoundFlags clears: sends command $F3
        ; if bit 7 of bAPUStatus is set.

        php
        phb
        phk
        plb
        .databank $80
        rep #$20
        lda bAPUStatus,b
        and #$0080
        beq _9087
        lda #$00F3
        jsl rlSendSoundCommand

        _9087
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/908A

      rlSoundOnFlag40Set ; 80/908A

        .as
        .xl
        .autsiz
        .databank ?

        ; rlUpdateSound calls this when bit 6 of bSoundFlags sets: sends command $F2
        ; unless bit 7 of bAPUStatus is set.

        php
        phb
        phk
        plb
        .databank $80
        rep #$20
        lda bAPUStatus,b
        and #$0080
        bne _909F
        lda #$00F2
        jsl rlSendSoundCommand

        _909F
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/90A2

    .endsection Unsorted80903DSection


    .section Unsorted8090A2Section

      .al
      .xl

      rlSendSoundQueuesToAPU ; 80/90A2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Once the APU echoes back the value on port 0 (or port 2), sends the next one
        ; from aSoundEffectQueue (aSoundEffect2Queue). Also keeps port 3 in bAPUStatus
        ; and port 1 in $0506. Skipped while bAPUUploading is set.

        php
        phb
        phk
        plb
        .databank $80
        sep #$10
        rep #$20
        ldy bAPUUploading,b
        bne _9121

        _90AF
        ldx $2141,b
        cpx $2141,b
        bne _90AF
        stx bAPUPort1,b

        _90BA
        ldx $2140,b
        cpx $2140,b
        bne _90BA
        cpx wSoundEffectCurrent,b
        bne _90E2
        lda aSoundEffectQueue,b
        sta wSoundEffectCurrent,b
        lda aSoundEffectQueue+2,b
        sta aSoundEffectQueue,b
        lda aSoundEffectQueue+4,b
        sta aSoundEffectQueue+2,b
        lda aSoundEffectQueue+6,b
        sta aSoundEffectQueue+4,b
        stz aSoundEffectQueue+6,b

        _90E2
        lda wSoundEffectCurrent,b
        sta $2140,b

        _90E8
        ldx $2143,b
        cpx $2143,b
        bne _90E8
        stx bAPUStatus,b

        _90F3
        ldx $2142,b
        cpx $2142,b
        bne _90F3
        cpx wSoundEffect2Current,b
        bne _911B
        lda aSoundEffect2Queue,b
        sta wSoundEffect2Current,b
        lda aSoundEffect2Queue+2,b
        sta aSoundEffect2Queue,b
        lda aSoundEffect2Queue+4,b
        sta aSoundEffect2Queue+2,b
        lda aSoundEffect2Queue+6,b
        sta aSoundEffect2Queue+4,b
        stz aSoundEffect2Queue+6,b

        _911B
        lda wSoundEffect2Current,b
        sta $2142,b

        _9121
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/9124

    .endsection Unsorted8090A2Section


    .section Unsorted809124Section

      .al
      .xl

      rlUploadToAPU ; 80/9124

        .as
        .xl
        .autsiz
        .databank ?

        ; Sends data at [lR38],y to the APU in the IPL format (blocks of size, SPC
        ; address, bytes, ended by size 0 and the address to run), with bAPUUploading as
        ; the value for port 0. Reads straight across bank boundaries.

        php
        phb
        phk
        plb
        .databank $80
        sep #$20
        rep #$10

        _912C
        lda #$CC
        ldx #$BBAA
        cpx $2140,b
        beq _916E
        lda bAPUUploading,b
        sta $2140,b
        bra _912C


        _913E
        lda [lR38],y
        inc y
        bne _9147
        inc lR38+2
        ldy lR38

        _9147
        rts


        _9148
        jsr _913E
        xba
        lda #$00
        bra _915B


        _9150
        xba
        jsr _913E
        xba

        _9155
        cmp $2140,b
        bne _9155
        inc a

        _915B
        rep #$20
        sta $2140,b
        sep #$20
        dec x
        bne _9150

        _9165
        cmp $2140,b
        bne _9165

        _916A
        adc #$03
        beq _916A

        _916E
        pha
        jsr _913E
        xba
        jsr _913E
        xba
        rep #$20
        tax
        sep #$20
        jsr _913E
        sta $2142,b
        jsr _913E
        sta $2143,b
        cpx #$0001
        lda #$00
        rol a
        sta $2141,b
        adc #$7F
        pla
        sta $2140,b

        _9197
        cmp $2140,b
        bne _9197
        bvs _9148
        stz bAPUUploading,b
        rep #$30

        _91A3
        lda $2140,b
        cmp $2140,b
        bne _91A3
        cmp #$0000
        bne _91A3
        plb
        .databank ?
        plp
        rtl

        .databank 0

        ; 80/91B3

      rlRunSoundUploadList ; 80/91B3

        .al
        .xl
        .autsiz
        .databank ?

        ; lR39 = upload list (format in tools/sound.py): uploads each chunk it names to
        ; the APU, running the commands of aSoundUploadCommands and the indirect IDs
        ; (rsGetIndirectSoundUpload); compressed chunks go through rlDecompressLinear
        ; into a WRAM buffer first.

        php
        phb
        phk
        plb
        .databank $80
        sep #$10
        rep #$20
        lda bAPUUploading,b
        and #$00FF
        sta $2140,b
        ldx #$00
        stx bSoundIndirectStep,b
        ldx bSoundUploadNoVBlank,b
        beq _91D2
        jsl rlDisableVBlank

        _91D2
        ldx bAPUUploading,b
        bra _91F9


        _91D7
        pea #<>_91E7 - 1
        inc y
        inc y

        _91DC
        lda [lR38]
        inc lR38
        inc lR38
        bne _91E6
        inc lR38+2

        _91E6
        rts


        _91E7
        cpx $2140,b
        bne _91E7
        sta $2142,b
        sty $2140,b
        inc x
        inc x

        _91F4
        dec wSoundTemp,b
        bne _91D7

        _91F9
        phx

        _91FA
        lda [lR39]
        beq _927C
        cmp #$0064
        bcs _920B
        jsr rsGetIndirectSoundUpload
        ldx bSoundIndirectStep,b
        bne _920F

        _920B
        inc lR39
        inc lR39

        _920F
        sta wSoundTemp,b
        xba
        sep #$20
        and #$F0
        beq _9220
        lsr a
        lsr a
        lsr a
        tax
        jsr (aSoundUploadCommands,x)

        _9220
        rep #$20
        lda wSoundTemp,b
        beq _91FA
        phb
        ldx bSoundDataBank,b
        phx
        plb
        .databank ?
        rep #$10
        and #$07FF
        sec
        sbc #$0064
        asl a
        asl a
        asl a
        clc
        adc aSoundHeader.Chunks
        tax
        lda $0007,b,x
        lsr a
        bcc _9249
        jml _92C9


        _9249
        lda $0002,b,x
        xba
        clc
        adc @l $0004B8
        sta lR38+1
        lda $0000,b,x
        sta lR38
        ldy $0005,b,x
        bne _9263
        lda @l $0004F2
        tay

        _9263
        lda $0003,b,x
        pha
        inc a
        lsr a
        sta @l $0004F0
        pla
        plb
        .databank ?
        sty wSoundUploadDestination,b
        clc
        adc wSoundUploadDestination,b
        sta wSoundUploadDestination,b
        tya
        sep #$10

        _927C
        plx
        txy
        inc y
        inc y
        inc y

        _9281
        inc y
        beq _9281

        _9284
        cpx $2140,b
        bne _9284
        sta $2142,b
        sty $2141,b
        sty $2140,b
        cmp #$0000
        beq _92B0
        jsr _91DC

        _929A
        cpy $2140,b
        bne _929A
        ldy #$02
        ldx #$00
        sta $2142,b
        sty $2140,b
        stx $2141,b
        jml _91F4


        _92B0
        ldx $2141,b
        cpx bAPUUploading,b
        beq _92B0
        ldx #$00
        stx bAPUUploading,b
        ldx bSoundUploadNoVBlank,b
        beq _92C6
        jsl rlEnableVBlank

        _92C6
        plb
        .databank ?
        plp
        .xl
        rtl


        _92C9
        ldy DecompressionVariables
        phy
        ldy $CA
        phy
        ldy $CC
        phy
        ldy $CE
        phy
        ldy $D0
        phy
        ldy $D1
        phy
        lsr a
        bcc _92F8
        lda #$7E00
        sta $CC
        sta lR38+1
        lda #$6358
        sta $CB
        sta lR38
        txa
        cmp @l $000504
        beq _9334
        pea #$0001
        bra _9310


        _92F8
        lda #$7E00
        sta $CC
        sta lR38+1
        lda #$5358
        sta $CB
        sta lR38
        txa
        cmp @l $000502
        beq _9334
        pea #$0000

        _9310
        lda $0002,b,x
        xba
        clc
        adc @l $0004B8
        sta $C9
        lda $0000,b,x
        sta DecompressionVariables
        phx
        jsl rlDecompressLinear
        plx
        txa
        ply
        beq _9330
        sta @l $000504
        bra _9334


        _9330
        sta @l $000502

        _9334
        sep #$20
        lda [lR38]
        sta @l $000507
        rep #$20
        ply
        sty $D1
        ply
        sty $D0
        ply
        sty $CE
        ply
        sty $CC
        ply
        sty $CA
        ply
        sty DecompressionVariables
        ldy $0005,b,x
        jml _9263

        .databank 0

        ; 80/9357

    .endsection Unsorted809124Section


    .section Table809357Section

      .al
      .xl

      aSoundUploadCommands ; 80/9357

        ; Jump table of rlRunSoundUploadList.
        .word $FFFF
        .word <>rsSoundUploadCommandJump
        .word <>rsSoundUploadCommandJump
        .word <>rsSoundUploadCommandJump
        .word <>rsSoundUploadCommandJump
        .word <>rsSoundUploadCommandJump
        .word <>rsSoundUploadCommandJump
        .word <>rsSoundUploadCommandJump
        .word <>rsSoundUploadCommandJump
        .word <>rsSoundUploadCommandClearResend
        .word <>rsSoundUploadCommandReadTerrain
        .word <>rsSoundUploadCommandResetBuffers
        .word <>rsSoundUploadCommandSetDestination
        .word <>rsSoundUploadCommandNone
        .word <>rsSoundUploadCommandJump
        .word $93B8

    .endsection Table809357Section


    .section Unsorted809377Section

      .al
      .xl

      rsSoundUploadCommandClearResend ; 80/9377

        .as
        .xs
        .autsiz
        .databank ?

        ; Upload list command $9xxx: clears bSoundResendCommand.

        sep #$20
        stz bSoundResendCommand,b
        rep #$20
        stz wSoundTemp,b
        rts

        .databank 0

        ; 80/9382

    .endsection Unsorted809377Section


    .section Unsorted809382Section

      .al
      .xl

      rsSoundUploadCommandSetDestination ; 80/9382

        .as
        .xs
        .autsiz
        .databank ?

        ; Upload list command $Cxxx: the next word is the SPC address for the chunks
        ; that follow.

        rep #$20
        lda [lR39]
        sta wSoundUploadDestination,b
        inc lR39
        inc lR39
        stz wSoundTemp,b
        rts

        .databank 0

        ; 80/9391

    .endsection Unsorted809382Section


    .section Unsorted809391Section

      .al
      .xs

      rsSoundUploadCommandNone ; 80/9391

        .as
        .xs
        .autsiz
        .databank ?

        ; Upload list command $Dxxx: nothing, so the chunk in the low bits is uploaded.

        rts

        .databank 0

        ; 80/9392

    .endsection Unsorted809391Section


    .section Unsorted809392Section

      .as
      .xs

      rsSoundUploadCommandJump ; 80/9392

        .as
        .xs
        .autsiz
        .databank ?

        ; Upload list commands $1xxx-$8xxx and $Exxx: jump by the signed offset in the
        ; low 12 bits times 2, from the command. No list in the ROM uses them.

        rep #$20
        lda wSoundTemp,b
        dec lR39
        dec lR39
        asl a
        and #$1FFF
        cmp #$1000
        bcc _93A7
        ora #$F000

        _93A7
        clc
        adc lR39
        sta lR39
        stz wSoundTemp,b
        rts

        .databank 0

        ; 80/93B0

    .endsection Unsorted809392Section


    .section Unsorted8093B0Section

      .al
      .xs

      rsSoundUploadCommandResetBuffers ; 80/93B0

        .as
        .xs
        .autsiz
        .databank ?

        ; Upload list command $Bxxx: forgets which chunks the WRAM buffers hold, then as
        ; $Fxxx (at _93B8), which forgets aSoundIndirectLast.

        rep #$20
        stz wSoundBuffer1Chunk,b
        stz wSoundBuffer2Chunk,b
        sep #$20
        stz aSoundIndirectLast,b
        stz $04FF,b
        rep #$20
        stz wSoundTemp,b
        rts

        .databank 0

        ; 80/93C6

    .endsection Unsorted8093B0Section


    .section Unsorted8093C6Section

      .al
      .xl

      rsGetIndirectSoundUpload ; 80/93C6

        .al
        .xs
        .autsiz
        .databank ?

        ; A = indirect upload ID (1-$63): returns the chunk ID to upload, the next entry
        ; of its list in aSoundUploadLists each call (bSoundIndirectStep); 1-4 pick the
        ; list from the battle (aSoundHeader.BattleUploads, aSoundTerrainUploads); 0 for
        ; nothing.

        cmp #$0005
        bcc _9412
        ldx bSoundIndirectStep,b
        bne _93E7
        sep #$20
        ldy #$00
        cmp #$3C
        bcs _93D9
        inc y

        _93D9
        cmp aSoundIndirectLast,b,y
        sta aSoundIndirectLast,b,y
        bne _93E7
        rep #$20
        lda #$0000
        rts


        _93E7
        inc x
        phx
        rep #$20
        asl a
        clc
        adc aSoundHeader.UploadLists
        sta lR38
        ldy bSoundDataBank,b
        sty lR38+2
        lda [lR38]

        _93FA
        dec x
        beq _9401
        inc a
        inc a
        bra _93FA


        _9401
        sta lR38
        plx
        ldy #$02
        lda [lR38],y
        bne _940C
        ldx #$00

        _940C
        lda [lR38]
        stx bSoundIndirectStep,b
        rts


        _9412
        cmp #$0003
        bcs _9477
        ldx bSoundDataBank,b
        stx lR38+2
        rep #$10
        dec a
        asl a
        tax
        lda <>aSoundBattleStructOffsets2,b,x
        tay
        lda <>aSoundBattleStructOffsets,b,x
        tax
        lda $7E4EA9,x
        cmp #$FFFF
        bne _9435
        inc a
        bra _9441


        _9435
        and #$00FF
        clc
        adc aSoundHeader.BattleUploads
        sta lR38
        lda [lR38],y

        _9441
        sep #$10
        and #$00FF
        bne _944C
        ldx #$00
        bra _9473


        _944C
        dec a
        asl a
        clc
        adc aSoundHeader.UploadLists
        sta lR38
        lda [lR38]
        sta lR38
        lda bSoundIndirectStep,b
        ldx bSoundIndirectStep,b
        inc x
        and #$000F
        asl a
        clc
        adc lR38
        sta lR38
        ldy #$02
        lda [lR38],y
        bne _9471
        ldx #$00

        _9471
        lda [lR38]

        _9473
        stx bSoundIndirectStep,b
        rts


        _9477
        ldx bSoundDataBank,b
        stx lR38+2
        pha
        rep #$10
        cmp #$0004
        bne _9489
        lda $050E,b
        bra _948C


        _9489
        lda aSoundTerrain,b

        _948C
        sta wSoundTemp,b
        pla
        dec a
        asl a
        tax
        lda <>aSoundBattleStructOffsets,b,x
        tax
        ldy #$0140
        lda $7E4EA9,x
        and #$007F
        clc
        adc aSoundHeader.BattleUploads
        sta lR38
        lda [lR38],y
        sep #$10
        and #$00FF
        bne _94B5
        ldx #$00
        bra _94DE


        _94B5
        dec a
        clc
        adc aSoundHeader.TerrainUploads
        adc wSoundTemp,b
        sta lR38
        lda [lR38]
        sta lR38
        lda bSoundIndirectStep,b
        ldx bSoundIndirectStep,b
        inc x
        and #$000F
        asl a
        clc
        adc lR38
        sta lR38
        ldy #$02
        lda [lR38],y
        bne _94DC
        ldx #$00

        _94DC
        lda [lR38]

        _94DE
        stx bSoundIndirectStep,b
        rts

        .databank 0

        ; 80/94E2

    .endsection Unsorted8093C6Section


    .section Unsorted8094E2Section

      .al
      .xs

      rsSoundUploadCommandReadTerrain ; 80/94E2

        .as
        .xs
        .autsiz
        .databank ?

        ; Upload list command $Axxx: sets aSoundTerrain from the terrain of the battle's
        ; units; for some weapons at distance 3 or more the attacker's terrain counts
        ; for both.

        rep #$30
        lda wBattleStatus
        and #$0001
        sta wSoundTemp,b
        beq _94F6
        lda aActionStructUnit1.TerrainType
        bra _94FA


        _94F6
        lda aActionStructUnit2.TerrainType

        _94FA
        and #$001F
        sta aSoundTerrain,b
        sta $050E,b
        lda wBattleDistance
        tax
        lda wSoundTemp,b
        bne _9513
        lda aActionStructUnit1.WeaponID
        bra _9517


        _9513
        lda aActionStructUnit2.WeaponID

        _9517
        cmp #$005C
        beq _954E
        cpx #$0003
        bcc _9569
        cmp #$005B
        beq _954E
        cmp #$0061
        beq _954E
        cmp #$0063
        beq _954E
        cmp #$0064
        beq _954E
        cmp #$0065
        beq _954E
        cmp #$0042
        beq _954E
        cmp #$0047
        beq _954E
        cmp #$004C
        beq _954E
        cmp #$0052
        bne _9569

        _954E
        lda wSoundTemp,b
        bne _955F
        lda aActionStructUnit1.TerrainType
        and #$001F
        sta $050E,b
        bra _9569


        _955F
        lda aActionStructUnit2.TerrainType
        and #$001F
        sta aSoundTerrain,b

        _9569
        ldx aSoundTerrain,b
        jsr rsGetSoundTerrainOffset
        stx aSoundTerrain,b
        ldx $050E,b
        jsr rsGetSoundTerrainOffset
        inc x
        inc x
        stx $050E,b
        stz wSoundTemp,b
        sep #$30
        rts

        .databank 0

        ; 80/9583

      rsGetSoundTerrainOffset ; 80/9583

        .al
        .xl
        .autsiz
        .databank ?

        ; X = terrain: returns its offset into aSoundTerrainUploads (from aSoundTerrainGroups);
        ; in chapter 4 every terrain but two counts as $10.

        lda <>aSoundTerrainGroups,b,x
        and #$001C
        tax
        lda @l wCurrentChapter
        cmp #$0004
        bne _95A0
        cpx #$000C
        beq _95A0
        cpx #$0014
        beq _95A0
        ldx #$0010

        _95A0
        rts

        .databank 0

        ; 80/95A1


      aSoundBattleStructOffsets ; 80/95A1

        ; Offsets into the battle struct at $7E4EA9 that the sound script's
        ; indirect commands read, by command argument 1-4.
        .word $0094, $0034, $0076, $0016

      aSoundBattleStructOffsets2 ; 80/95A9

        ; Read beside aSoundBattleStructOffsets for arguments 1 and 2.
        .word $0000, $00A0

      aSoundTerrainGroups ; 80/95AD

        ; One byte per terrain type ($00-$1F): its offset into the terrain
        ; sound uploads (masked with $1C by rsGetSoundTerrainOffset).
        .byte $00, $04, $00, $00, $04, $08, $00, $00
        .byte $08, $0C, $0C, $0C, $0C, $0C, $00, $14
        .byte $00, $00, $00, $00, $00, $00, $00, $0C
        .byte $00, $00, $00, $00, $00, $00, $00, $00

    .endsection Unsorted8094E2Section


    .section Unsorted8095CDSection

      .al
      .xl

      rlUpdateSound ; 80/95CD

        .al
        .xl
        .autsiz
        .databank ?

        ; Every frame: acts on changes of bits 4 and 6 of bSoundFlags, then steps both
        ; sound script channels.

        php
        phb
        phk
        plb
        .databank $80
        sep #$20
        lda bSoundUpdateSlot,b
        clc
        adc #$03
        cmp #$09
        bcc _95DF
        lda #$00

        _95DF
        sta bSoundUpdateSlot,b
        lda bSoundFlags,b
        cmp bSoundFlagsApplied,b
        beq _962F
        clc
        and #$40
        beq _95F0
        sec

        _95F0
        eor bSoundFlagsApplied,b
        and #$40
        beq _960B
        lda #$40
        bcc _9604
        tsb bSoundFlagsApplied,b
        jsl rlSoundOnFlag40Set
        bra _960B


        _9604
        trb bSoundFlagsApplied,b
        jsl rlSoundOnFlag40Cleared

        _960B
        clc
        lda bSoundFlags,b
        and #$10
        beq _9614
        sec

        _9614
        eor bSoundFlagsApplied,b
        and #$10
        beq _962F
        lda #$10
        bcc _9628
        tsb bSoundFlagsApplied,b
        jsl rlSoundOnFlag10Set
        bra _962F


        _9628
        trb bSoundFlagsApplied,b
        jsl rlSoundOnFlag10Cleared

        _962F
        rep #$30
        lda wMusicID,b
        bne _963B
        sta aSoundScriptRunning,b
        bra _9641


        _963B
        ldx #$0000
        jsr rsStepSoundScript

        _9641
        lda wSoundScript1ID,b
        bne _964B
        sta $04C8,b
        bra _9651


        _964B
        ldx #$0002
        jsr rsStepSoundScript

        _9651
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/9654

    .endsection Unsorted8095CDSection


    .section Unsorted809729Section

      .al
      .xs

      rsSoundScriptPlaySoundEffect ; 80/9729

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 80/972E

    .endsection Unsorted809729Section


    .section Unsorted80972ESection

      .al
      .xl

      rsSoundScriptPlaySoundEffect2 ; 80/972E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlPlaySoundEffect2
        rts

        .databank 0

        ; 80/9733

    .endsection Unsorted80972ESection


    .section Unsorted809733Section

      .al
      .xl

      rsSoundScriptQueueCommand ; 80/9733

        .al
        .xl
        .autsiz
        .databank ?

        ; Script command 6: queues the argument with rlQueueSoundCommand; if the script
        ; ID's bits 8-11 are 1-8, they replace those bits of the argument.

        pha
        ldx wSoundScriptChannel,b
        lda wMusicID,b,x
        cmp #$0100
        bcc _9753
        and #$0F00
        cmp #$0900
        bcs _9753
        sta wSoundTemp,b
        pla
        and #$80FF
        ora wSoundTemp,b
        bra _9754


        _9753
        pla

        _9754
        jsl rlQueueSoundCommand
        rts

        .databank 0

        ; 80/9759

    .endsection Unsorted809733Section


    .section Unsorted809759Section

      .al
      .xl

      rsSoundScriptSendCommand ; 80/9759

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlSendSoundCommand
        rts

        .databank 0

        ; 80/975E

    .endsection Unsorted809759Section


    .section Unsorted80975ESection

      .al
      .xl

      rsSoundScriptUploadFD ; 80/975E

        .al
        .xl
        .autsiz
        .databank ?

        ; Script commands 7-10: runs the upload list in the argument now, with $FD, $FC,
        ; $FB or $FA as bAPUUploading; while another upload is running, waits a frame
        ; and tries again.

        tax
        lda bAPUUploading,b
        and #$00FF
        bne rsSoundScriptUploadFA._97AE
        sep #$20
        lda #$FD
        sta bAPUUploading,b
        rep #$20
        bra rsSoundScriptUploadFA._97B9

        .databank 0

        ; 80/9772

      rsSoundScriptUploadFC ; 80/9772

        .al
        .xl
        .autsiz
        .databank ?

        tax
        lda bAPUUploading,b
        and #$00FF
        bne rsSoundScriptUploadFA._97AE
        sep #$20
        lda #$FC
        sta bAPUUploading,b
        rep #$20
        bra rsSoundScriptUploadFA._97B9

        .databank 0

        ; 80/9786

      rsSoundScriptUploadFB ; 80/9786

        .al
        .xl
        .autsiz
        .databank ?

        tax
        lda bAPUUploading,b
        and #$00FF
        bne rsSoundScriptUploadFA._97AE
        sep #$20
        lda #$FB
        sta bAPUUploading,b
        rep #$20
        bra rsSoundScriptUploadFA._97B9

        .databank 0

        ; 80/979A

      rsSoundScriptUploadFA ; 80/979A

        .al
        .xl
        .autsiz
        .databank ?

        tax
        lda bAPUUploading,b
        and #$00FF
        bne _97AE
        sep #$20
        lda #$FA
        sta bAPUUploading,b
        rep #$20
        bra _97B9


        _97AE
        lda #$0001
        sta wSoundScriptCommand,b
        dec y
        dec y
        dec y
        dec y
        rts


        _97B9
        txa
        phy
        ldy lR39
        phy
        ldy lR39+1
        phy
        ldy lR38
        phy
        ldy lR38+1
        phy
        ldy wSoundDataBankHigh,b
        sty lR39+1
        sta lR39
        jsl rlRunSoundUploadList
        ply
        sty lR38+1
        ply
        sty lR38
        ply
        sty lR39+1
        ply
        sty lR39
        ply
        rts

        .databank 0

        ; 80/97E0

    .endsection Unsorted80975ESection


    .section Unsorted8097E0Section

      .al
      .xl

      rsSoundScriptDeferUploadFD ; 80/97E0

        .al
        .xl
        .autsiz
        .databank ?

        ; Script commands 11-14: leaves the upload list in the argument in
        ; wSoundDeferredUpload for rlRunDeferredSoundUpload, with $FD, $FC, $FB or $FA
        ; as its mode; waits while one is already left.

        tax
        lda bAPUUploading,b
        and #$00FF
        bne _97F6
        sep #$20
        lda #$FD

        _97ED
        sta bSoundDeferredUploadMode,b
        stx wSoundDeferredUpload,b
        rep #$20
        rts


        _97F6
        lda #$0001
        sta wSoundScriptCommand,b
        dec y
        dec y
        dec y
        dec y
        rts

        .databank 0

        ; 80/9801

    .endsection Unsorted8097E0Section


    .section Unsorted809801Section

      .al
      .xl

      rlSoundScriptDeferUploadFC ; 80/9801

        .al
        .xl
        .autsiz
        .databank ?

        tax
        lda bAPUUploading,b
        and #$00FF
        bne rsSoundScriptDeferUploadFD._97F6
        sep #$20
        lda #$FC
        bra rsSoundScriptDeferUploadFD._97ED

        .databank 0

        ; 80/9810

    .endsection Unsorted809801Section


    .section Unsorted809810Section

      .as
      .xl

      rlSoundScriptDeferUploadFB ; 80/9810

        .al
        .xl
        .autsiz
        .databank ?

        tax
        lda bAPUUploading,b
        and #$00FF
        bne rsSoundScriptDeferUploadFD._97F6
        sep #$20
        lda #$FB
        bra rsSoundScriptDeferUploadFD._97ED

        .databank 0

        ; 80/981F

    .endsection Unsorted809810Section


    .section Unsorted80981FSection

      .as
      .xl

      rlSoundScriptDeferUploadFA ; 80/981F

        .al
        .xl
        .autsiz
        .databank ?

        tax
        lda bAPUUploading,b
        and #$00FF
        bne rsSoundScriptDeferUploadFD._97F6
        sep #$20
        lda #$FA
        bra rsSoundScriptDeferUploadFD._97ED

        .databank 0

        ; 80/982E

    .endsection Unsorted80981FSection


    .section Unsorted80982ESection

      .as
      .xl

      rsSoundScriptWaitForAPUStatus ; 80/982E

        .al
        .xl
        .autsiz
        .databank ?

        ; Script command 15: waits until a bit of the argument is set in bAPUStatus.

        php
        sep #$20
        and bAPUStatus,b
        bne _983A
        dec y
        dec y
        dec y
        dec y

        _983A
        plp
        rts

        .databank 0

        ; 80/983C

    .endsection Unsorted80982ESection


    .section Unsorted80983CSection

      .as
      .xl

      rsSoundScriptWaitForDeferredUpload ; 80/983C

        .al
        .xl
        .autsiz
        .databank ?

        ; Script command 16: waits until wSoundDeferredUpload has been sent.

        lda wSoundDeferredUpload,b
        beq _9845
        dec y
        dec y
        dec y
        dec y

        _9845
        rts

        .databank 0

        ; 80/9846

    .endsection Unsorted80983CSection


    .section Unsorted809846Section

      .al
      .xl

      rsSoundScriptQueueCommandChecked ; 80/9846

        .al
        .xl
        .autsiz
        .databank ?

        ; Script command 17: queues the argument with rlQueueSoundCommand once no upload
        ; is waiting; for $CB-$CD, when the chunk in the buffer (bSoundBufferFirstByte)
        ; is what the APU reports on port 1, sends $xxF1 with that byte instead.

        tax
        lda wSoundUploadBusyFlag,b
        bne _9851
        lda wSoundDeferredUpload,b
        beq _985C

        _9851
        lda #$0001
        sta wSoundScriptCommand,b
        dec y
        dec y
        dec y
        dec y
        rts


        _985C
        cpx #$00CB
        bcc _9866
        cpx #$00CE
        bcc _9871

        _9866
        txa
        ora wSoundQueueFlags,b
        stz wSoundQueueFlags,b
        jml rsSoundScriptQueueCommand


        _9871
        sep #$20
        lda bSoundBufferFirstByte,b
        beq _98A0
        cmp bAPUPort1,b
        bne _98A0
        rep #$20
        lda wSoundIndirectPending,b
        bne _989B
        txa
        sep #$20
        sta bSoundResendCommand,b
        rep #$20
        lda bSoundBufferFirstByte,b
        and #$00FF
        xba
        ora #$00F1
        jsl rlSendSoundCommand
        rts


        _989B
        sep #$20
        stz bSoundBufferFirstByte,b

        _98A0
        rep #$20
        stz wSoundIndirectPending,b
        txa
        jsl rlQueueSoundCommand
        rts

        .databank 0

        ; 80/98AB

      rsSoundScriptBattleTerrainCommand ; 80/98AB

        .al
        .xl
        .autsiz
        .databank ?

        ; Script command 18: queues $C2, or $80C3 for terrain 1 and 4 and $80C4 for
        ; terrain $17, from the terrain of one of the battle's units (argument 1 or not
        ; picks which).

        rep #$20
        ldx wSoundDeferredUpload,b
        bne rsSoundScriptQueueCommandChecked._9851
        dec a
        bne _98C0
        lda wBattleStatus
        and #$0001
        bne _98CF
        bra _98C9


        _98C0
        lda wBattleStatus
        and #$0001
        beq _98CF

        _98C9
        lda aActionStructUnit1.TerrainType
        bra _98D3


        _98CF
        lda aActionStructUnit2.TerrainType

        _98D3
        and #$001F
        cmp #$0001
        beq _98EA
        cmp #$0004
        beq _98EA
        cmp #$0017
        beq _98F5
        lda #$00C2
        bra _98FE


        _98EA
        lda #$8000
        sta wSoundQueueFlags,b
        lda #$80C3
        bra _98FE


        _98F5
        lda #$8000
        sta wSoundQueueFlags,b
        lda #$80C4

        _98FE
        jsl rlQueueSoundCommand
        rts

        .databank 0

        ; 80/9903

    .endsection Unsorted809846Section


    .section Unsorted809903Section

      .al
      .xl

      rlRunDeferredSoundUpload ; 80/9903

        .al
        .xl
        .autsiz
        .databank ?

        ; Runs the upload list in wSoundDeferredUpload, if there is one and no upload is
        ; running.

        php
        phb
        phk
        plb
        .databank $80
        sep #$10
        rep #$20
        lda wSoundDeferredUpload,b
        beq _9930
        ldx bAPUUploading,b
        bne _9930
        ldx #$00
        stx bSoundUploadNoVBlank,b
        ldx bSoundDeferredUploadMode,b
        stx bAPUUploading,b
        rep #$10
        ldx wSoundDataBankHigh,b
        stx lR39+1
        sta lR39
        jsl rlRunSoundUploadList
        stz wSoundDeferredUpload,b

        _9930
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/9933

    .endsection Unsorted809903Section


    .section Unsorted809933Section

      .al
      .xl

      rlUpdateMapSpriteSoundPanning ; 80/9933

        .al
        .autsiz
        .databank ?

        ; Updates moving map-sprite port-2 sound volume/panning ($04CA..$04CC) via rlPlaySoundEffect2Checked

        php
        phb
        phk
        plb
        sep #$20
        lda aSoundChannelFadeState.bMode,b,x
        beq _End

        cmp aSoundChannelFadeTarget,b,x
        beq _995D

        cmp #$10
        bne +

        stz aSoundChannelFadeState.bMode,b,x
        bra _9976

        +
        sta aSoundChannelFadeTarget,b,x
        xba
        lda aSoundChannelFadeState.bLevel,b,x
        lsr a
        lsr a
        lsr a
        cmp #$10
        bcs _9975

        inc a
        bra _9975
        
        _995D
        cpx bSoundUpdateSlot,b
        bne _End

        lda #1
        xba
        lda aSoundChannelFadeState.bLevel,b,x
        lsr a
        lsr a
        lsr a
        cmp #$10
        bcs +

        inc a
        
        +
        ora #$80
        ora aSoundChannelFadeState.bFlags,b,x

        _9975
        xba
        
        _9976
        rep #$20
        cpx #0
        beq +

          clc
          adc #$0010

        +
        jsl rlPlaySoundEffect2Checked
        
        _End
        plb
        plp
        rtl

        .databank 0

        ; 80/9988

        ; Unused: 376 zero bytes.
        .fill 376, $00

    .endsection Unsorted809933Section


    .section Unsorted809654Section

      .al
      .xs

      rlStepMusicScript ; 80/9654

        .al
        .xl
        .autsiz
        .databank ?

        ; Steps the music script (channel 0, wMusicID) now and runs a deferred upload,
        ; outside the frame's rlUpdateSound; called after setting wMusicID.

        php
        phb
        phk
        plb
        .databank $80
        rep #$30
        pha
        phx
        phy
        lda wMusicID,b
        bne _9667
        sta aSoundScriptRunning,b
        bra _9671


        _9667
        ldx #$0000
        jsr rsStepSoundScript
        jsl rlRunDeferredSoundUpload

        _9671
        ply
        plx
        pla
        plb
        .databank ?
        plp
        rtl

        .databank 0

        ; 80/9677

      rsStepSoundScript ; 80/9677

        .al
        .xl
        .autsiz
        .databank ?

        ; X = channel (0, 2), A = its script ID: starts the script if it is not the one
        ; running, else counts down its wait and runs commands up to the next wait. At
        ; the script's end the channel stops and aSoundScriptPrevious keeps the ID.

        ldy lR38
        phy
        ldy lR38+1
        phy
        ldy wSoundDataBankHigh,b
        sty lR38+1
        stx wSoundScriptChannel,b
        cmp aSoundScriptRunning,b,x
        beq _96A3
        sta aSoundScriptRunning,b,x
        and #$00FF
        dec a
        asl a
        tay
        lda #$0001
        sta aSoundScriptWaits,b,x
        lda aSoundHeader.Scripts
        sta lR38
        lda [lR38],y
        bra _96A6


        _96A3
        lda aSoundScriptPositions,b,x

        _96A6
        tay
        lda wMusicID,b,x
        and #$8000
        xba
        sep #$20
        sta bSoundUploadNoVBlank,b
        rep #$20
        dec aSoundScriptWaits,b,x
        bne _96E9
        stz lR38

        _96BC
        lda [lR38],y
        beq _96F0
        inc y
        inc y
        sta wSoundScriptCommand,b
        and #$FC00
        beq _96D7
        xba
        lsr a
        lsr a
        dec a
        asl a
        tax
        lda [lR38],y
        inc y
        inc y
        jsr (aSoundScriptCommands,x)

        _96D7
        lda wSoundScriptCommand,b
        and #$03FF
        beq _96BC
        ldx wSoundScriptChannel,b
        sta aSoundScriptWaits,b,x
        tya
        sta aSoundScriptPositions,b,x

        _96E9
        pla
        sta lR38+1
        pla
        sta lR38
        rts


        _96F0
        ldx wSoundScriptChannel,b
        pha
        lda wMusicID,b,x
        sta aSoundScriptPrevious,b,x
        pla
        sta wMusicID,b,x
        sta aSoundScriptRunning,b,x
        bra _96E9

        .databank 0

        ; 80/9703

    .endsection Unsorted809654Section


    .section Table809703Section

      .al
      .xl

      aSoundScriptCommands ; 80/9703

        ; Jump table of rsStepSoundScript.
        .word <>rsSoundScriptPlaySoundEffect
        .word <>rsSoundScriptPlaySoundEffect
        .word <>rsSoundScriptPlaySoundEffect2
        .word <>rsSoundScriptPlaySoundEffect2
        .word <>rsSoundScriptSendCommand
        .word <>rsSoundScriptQueueCommand
        .word <>rsSoundScriptUploadFD
        .word <>rsSoundScriptUploadFC
        .word <>rsSoundScriptUploadFB
        .word <>rsSoundScriptUploadFA
        .word <>rsSoundScriptDeferUploadFD
        .word <>rlSoundScriptDeferUploadFC
        .word <>rlSoundScriptDeferUploadFB
        .word <>rlSoundScriptDeferUploadFA
        .word <>rsSoundScriptWaitForAPUStatus
        .word <>rsSoundScriptWaitForDeferredUpload
        .word <>rsSoundScriptQueueCommandChecked
        .word <>rsSoundScriptBattleTerrainCommand

      rsSoundScriptNoOpUnused ; 80/9727

        ; Unreferenced: does nothing.

        nop
        rts

    .endsection Table809703Section


