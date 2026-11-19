; Code from bank $88 not yet assigned to a game system.


    .section Unsorted88818ASection

      .al
      .xl

      rlUnknown88818A ; 88/818A

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$054A
        lda #$0000

        _8190
        sta $0592,b,x
        dec x
        bpl _8190
        rtl

        .databank 0

        ; 88/8197

    .endsection Unsorted88818ASection


    .section Unsorted888197Section

      .al
      .xl

      rlUnknown888197 ; 88/8197

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlDMAByStruct

          .structDMAToVRAM $DE40C0, $0400, $80, $C000

        plx
        rtl

        .databank 0

        ; 88/81A7

      rlUnknown8881A7 ; 88/81A7

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$001E

        _81AB
        lda aUnknown8C9D00,x
        sta aOAMPaletteBuffer,b,x
        dec x
        dec x
        bpl _81AB
        plx
        rtl

        .databank 0

        ; 88/81B8

    .endsection Unsorted888197Section


    .section Unsorted8881DESection

      .al
      .xl

      rlUnknown8881DE ; 88/81DE

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        tsb $0786,b
        rtl

        .databank 0

        ; 88/81E5

    .endsection Unsorted8881DESection


    .section Unsorted8881E5Section

      .al
      .xl

      rlUnknown8881E5 ; 88/81E5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        tsb $0786,b
        rtl

        .databank 0

        ; 88/81EC

    .endsection Unsorted8881E5Section


    .section Unsorted8881ECSection

      .al
      .xl

      rlUnknown8881EC ; 88/81EC

        .al
        .xl
        .autsiz
        .databank ?

        phk
        plb
        .databank $88
        rep #$30
        lda #$1809
        sta $4300,b
        lda #$8800
        sta $4303,b
        lda #$8219
        sta $4302,b
        lda #$4000
        sta $4305,b
        lda #$6000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        rtl

        .databank 0

        ; 88/8218

    .endsection Unsorted8881ECSection


    .section Unsorted888410Section

      .al
      .xl

      rlUnknown888410 ; 88/8410

        .al
        .autsiz
        .databank ?

        lda #1
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        lda wMapScrollXPixels,b
        sta wUnknown000734,b
        lda wMapScrollYPixels,b
        sta wUnknown000736,b
        clc
        adc #$0100
        sta wMapScrollYPixels,b
        lda #8
        sta wMapScrollSpeed,b

        stz wUnknown00072C,b
        stz wUnknown00072E,b

        lda wUnknown000736,b
        and #$00F8
        asl a
        asl a
        asl a
        clc
        adc #$07C0
        and #$07FF
        sta $0724,b
        
          -
          jsr rsMapScrollUpSetBGOFS
          jsl rlUnknown8887AD
          jsr rsUnknown88847D

          lda wUnknown000736,b
          cmp wMapScrollYPixels,b
          bcc -

        jsl rlDMAByStruct
          .structDMAToVRAM $7E7388, $0800, $80, $A000

        lda wUnknown000734,b
        sta wMapScrollXPixels,b
        lda wUnknown000736,b
        sta wMapScrollYPixels,b

        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        rtl

        .databank 0

        ; 88/847D

    .endsection Unsorted888410Section


    .section Unsorted88847DSection

      .al
      .xl

      rsUnknown88847D ; 88/847D

        .al
        .xl
        .autsiz
        .databank ?

        ldx $0724,b
        ldy #$0000

        _8483
        lda $05DC,b,y
        sta aBG2TilemapBuffer,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0040
        bcc _8483
        lda $0724,b
        sec
        sbc #$0040
        sta $0724,b
        bpl _84A5
        lda #$07C0
        sta $0724,b

        _84A5
        rts

        .databank 0

        ; 88/84A6

      rlUnknown8884A6 ; 88/84A6

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b
        lda wMapScrollXPixels,b
        sta wUnknown000734,b
        lda wMapScrollYPixels,b
        sta wUnknown000736,b
        clc
        adc #$0100
        sta wMapScrollYPixels,b
        lda #$0008
        sta wMapScrollSpeed,b
        lda wUnknown000736,b
        and #$00F8
        asl a
        asl a
        asl a
        clc
        adc #$07C0
        and #$07FF
        sta $0724,b

        _84DB
        jsr rsMapScrollUpSetBGOFS
        jsl rlUnknown888505
        lda wUnknown000736,b
        cmp wMapScrollYPixels,b
        bcc _84DB
        jsl rlUnknown878459
        lda wUnknown000734,b
        sta wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lda wUnknown000736,b
        sta wMapScrollYPixels,b
        sta wBufferBG3VOFS
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        rtl

        .databank 0

        ; 88/8505

      rlUnknown888505 ; 88/8505

        .al
        .xl
        .autsiz
        .databank ?

        stz wR2
        lda wMapScrollYPixels,b
        and #$0008
        beq _8514
        lda #$0002
        sta wR2

        _8514
        jsr rsUnknown888D57
        lda wR3
        sec
        sbc #$0000
        tax
        stz wUnknown00072A,b
        lda wMapScrollXPixels,b
        and #$0008
        bne _8531
        lda #$0000
        jsr rsUnknown888A14
        bra _8537


        _8531
        lda #$0000
        jsr rsUnknown888C5F

        _8537
        ldx $0724,b
        ldy #$0000

        _853D
        lda $06DC,b,y
        sta aBG3TilemapBuffer,x
        inc x
        inc x
        inc y
        inc y
        cpy #$0040
        bcc _853D
        lda $0724,b
        sec
        sbc #$0040
        sta $0724,b
        bpl _855F
        lda #$07C0
        sta $0724,b

        _855F
        rtl

        .databank 0

        ; 88/8560

    .endsection Unsorted88847DSection


    .section Unsorted888560Section

      .al
      .xl

      rlUnknown888560 ; 88/8560

        .al
        .autsiz
        .databank ?

        lda wUnknown00073A,b
        beq +

          jsl rlUnknown88864F

          lda $0788,b
          bit #$0020
          bne +

            lda wMapScrollXPixels,b
            sta wMapXOffset,b
            lda wMapScrollYPixels,b
            sta wMapYOffset,b

        +
        rtl

        .databank 0

        ; 88/857E

    .endsection Unsorted888560Section


    .section Unsorted8885D3Section

      .al
      .xl

      rlUnknown8885D3 ; 88/85D3

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wUnknown00073A,b
        sta wMapEnableYScrollFlag,b
        jsl rlUnknown8886B3
        rtl

        .databank 0

        ; 88/85E1

      rlUnknown8885E1 ; 88/85E1

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wUnknown00073A,b
        sta wMapEnableYScrollFlag,b
        jsl rlUnknown8886BB
        rtl

        .databank 0

        ; 88/85EF

    .endsection Unsorted8885D3Section


    .section Unsorted8885EFSection

      .al
      .xl

      rlUnknown8885EF ; 88/85EF

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b

        jsl rlUnknown8886A3
        rtl

        .databank 0

      rlUnknown8885FD ; 88/85FD
      
        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b

        jsl rlUnknown8886AB
        rtl

        .databank 0

    .endsection Unsorted8885EFSection


    .section Unsorted88860BSection

      .al
      .xl

      rlUnknown88860B ; 88/860B

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        jsl rlUnknown8886C3
        rtl

        .databank 0

    .endsection Unsorted88860BSection


    .section Unsorted88861CSection

      .al
      .xl

      rlUnknown88861C ; 88/861C

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        jsl rlUnknown8886E1
        rtl

        .databank 0

      rlUnknown88862D ; 88/862D

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        jsl rlUnknown8886D2
        rtl

        .databank 0

      rlUnknown88863E ; 88/863E

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        sta wMapEnableYScrollFlag,b

        jsl rlUnknown8886F0
        rtl

        .databank 0

      rlUnknown88864F ; 88/864F
      
        .al
        .autsiz
        .databank ?

        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _867B

        cmp #$0100
        beq _8680

        cmp #$0800
        beq _8685

        cmp #$0400
        beq _868A

        cmp #$0A00
        beq _868F

        cmp #$0600
        beq _8694

        cmp #$0900
        beq _8699

        cmp #$0500
        beq _869E

        rtl

        _867B
        jsl rlUnknown8886A3
        rtl
        
        _8680
        jsl rlUnknown8886AB
        rtl
        
        _8685
        jsl rlUnknown8886B3
        rtl
        
        _868A
        jsl rlUnknown8886BB
        rtl
        
        _868F
        jsl rlUnknown8886C3
        rtl
        
        _8694
        jsl rlUnknown8886E1
        rtl
        
        _8699
        jsl rlUnknown8886D2
        rtl
        
        _869E
        jsl rlUnknown8886F0
        rtl

        .databank 0

      rlUnknown8886A3 ; 88/86A3

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollLeftSetBGOFS
        jsl rlUnknown8887D6
        rtl

        .databank 0

      rlUnknown8886AB ; 88/86AB

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollRightSetBGOFS
        jsl rlUnknown8887BC
        rtl

        .databank 0

      rlUnknown8886B3 ; 88/86B3

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollUpSetBGOFS
        jsl rlUnknown888798
        rtl

        .databank 0

      rlUnknown8886BB ; 88/86BB

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollDownSetBGOFS
        jsl rlUnknown88877F
        rtl

        .databank 0

      rlUnknown8886C3 ; 88/86C3

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollLeftSetBGOFS
        jsr rsMapScrollUpSetBGOFS
        jsl rlUnknown8887D6
        jsl rlUnknown888798
        rtl

        .databank 0

      rlUnknown8886D2 ; 88/86D2

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollRightSetBGOFS
        jsr rsMapScrollUpSetBGOFS
        jsl rlUnknown8887BC
        jsl rlUnknown888798
        rtl

        .databank 0

      rlUnknown8886E1 ; 88/86E1

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollLeftSetBGOFS
        jsr rsMapScrollDownSetBGOFS
        jsl rlUnknown8887D6
        jsl rlUnknown88877F
        rtl

        .databank 0

      rlUnknown8886F0 ; 88/86F0
      
        .al
        .autsiz
        .databank ?

        jsr rsMapScrollRightSetBGOFS
        jsr rsMapScrollDownSetBGOFS
        jsl rlUnknown8887BC
        jsl rlUnknown88877F
        rtl

        .databank 0

    .endsection Unsorted88861CSection


    .section Unsorted888901Section

      .al
      .xl

      rsUnknown888901 ; 88/8901

        .al
        .autsiz
        .databank ?

        lda wUnknown00075C,b
        cmp #4
        beq ++

          cmp #8
          beq +

          +
          lda wR3
          clc
          adc #$0E00
          rts

        +
        lda wR3
        clc
        adc #$0700
        rts

        .databank 0

      rsUnknown88891C ; 88/891C

        .al
        .autsiz
        .databank ?

        stz wR2
        lda wMapScrollYPixels,b
        and #$0008
        beq +

          lda #2
          sta wR2

        +
        jsr rsUnknown888D57
        jsr rsUnknown888901
        tax
        stz wUnknown00072A,b
        
        lda wMapScrollXPixels,b
        and #$0008
        bne +

          jsr rsUnknown88899F

          lda wUnknown000770,b
          beq _End

            lda #$00E0
            jsr rsUnknown888A14
            bra _End

        +
        jsr rsUnknown888BB3

        lda wUnknown000770,b
        beq _End

          lda #$00E0
          jsr rsUnknown888C5F

        _End
        rts

        .databank 0

      rsUnknown88895C ; 88/895C

        .al
        .autsiz
        .databank ?

        stz $04
        lda wMapScrollYPixels,b
        and #$0008
        beq +

          lda #2
          sta $04

        +
        jsr rsUnknown888D57

        lda $06
        sec
        sbc #0
        tax

        stz wUnknown00072A,b

        lda wMapScrollXPixels,b
        and #$0008
        bne +

          jsr rsUnknown88899F

          lda wUnknown000770,b
          beq _End

            lda #0
            jsr rsUnknown888A14
            bra _End

        +
        jsr rsUnknown888BB3

        lda wUnknown000770,b
        beq _End

          lda #0
          jsr rsUnknown888C5F

        _End
        rts

        .databank 0

      rsUnknown88899F ; 88/899F

        .al
        .autsiz
        .databank ?

        _Loop
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        tax

        lda $7F0000,x
        and #$DFFF
        sta $05DC,b,y
        lda $7F0004,x
        and #$DFFF
        sta $05DE,b,y

        plx
        lda wUnknown00075A,b
        bit #$0002
        beq +

          lda $7F6400,x
          and #$03FF
          asl a
          asl a
          asl a
          clc
          adc wR2
          phx
          tax

          lda $7F0000,x
          and #$DFFF
          ora #$2000
          sta $065C,b,y
          lda $7F0004,x
          and #$DFFF
          ora #$2000
          sta $065E,b,y

          plx
        
        +
        inc y
        inc y
        inc y
        inc y
        inx
        inc x
        
        -
        lda wUnknown00072A,b
        beq +

          cpy wR8
          bcs _End
          bra _Loop

        +
        cpy #64
        bcc _Loop

          inc wUnknown00072A,b
          ldy #0
          bra -

        _End
        rts

        .databank 0

        ; 88/8A14

    .endsection Unsorted888901Section


    .section Unsorted888A14Section

      .al
      .xl

      rsUnknown888A14 ; 88/8A14

        .al
        .xl
        .autsiz
        .databank ?

        clc
        adc wMapScrollYPixels,b
        sta $0792,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        lda wMapScrollYPixels,b
        sta wBufferBG3VOFS
        lda wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        jsr rsUnknown888D23
        stz wUnknown00072A,b
        ldy wR8

        _8A3B
        lda $078E,b
        cmp $071E,b
        bcc _8A66
        cmp $0722,b
        bcs _8A66
        lda $078C,b
        cmp $071C,b
        bcc _8A66
        cmp $0720,b
        bcs _8A66
        jsr rsUnknown888D47
        lda aMovementMap,x
        and #$00FF
        beq _8A66
        jsr rsUnknown888A93
        bra _8A6F


        _8A66
        lda #$00FF
        sta $06DC,b,y
        sta $06DE,b,y

        _8A6F
        inc $078C,b
        inc y
        inc y
        inc y
        inc y

        _8A76
        lda wUnknown00072A,b
        beq _8A81
        cpy wR8
        bcs _8A92
        bra _8A3B


        _8A81
        cpy #$0040
        bcc _8A8E
        inc wUnknown00072A,b
        ldy #$0000
        bra _8A76


        _8A8E
        jml _8A3B


        _8A92
        rts

        .databank 0

        ; 88/8A93

      rsUnknown888A93 ; 88/8A93

        .al
        .xl
        .autsiz
        .databank ?

        bit #$0080
        beq _8A9C
        jml _8AFC


        _8A9C
        lda $0792,b
        and #$0008
        bne _8AB1
        lda #$284E
        sta $06DC,b,y
        lda #$284F
        sta $06DE,b,y
        rts


        _8AB1
        lda #$285E
        sta $06DC,b,y
        lda #$285F
        sta $06DE,b,y
        rts

        .byte $89, $80, $00, $F0, $04, $5C, $27, $8B, $88, $AD, $92, $07, $29, $08, $00, $D0
        .byte $07, $A9, $4F, $28, $99, $DC, $06, $60, $A9, $5F, $28, $99, $DC, $06, $60, $89
        .byte $80, $00, $F0, $04, $5C, $46, $8B, $88, $AD, $92, $07, $29, $08, $00, $D0, $07
        .byte $A9, $4E, $28, $99, $DC, $06, $60, $A9, $5E, $28, $99, $DC, $06, $60


        _8AFC
        cmp #$0080
        bne _8B05
        jml _8B65


        _8B05
        lda $0792,b
        and #$0008
        bne _8B1A
        lda #$244E
        sta $06DC,b,y
        lda #$244F
        sta $06DE,b,y
        rts


        _8B1A
        lda #$245E
        sta $06DC,b,y
        lda #$245F
        sta $06DE,b,y
        rts

        .byte $C9, $80, $00, $D0, $04, $5C, $87, $8B, $88, $AD, $92, $07, $29, $08, $00, $D0
        .byte $07, $A9, $4F, $24, $99, $DC, $06, $60, $A9, $5F, $24, $99, $DC, $06, $60, $C9
        .byte $80, $00, $D0, $04, $5C, $9D, $8B, $88, $AD, $92, $07, $29, $08, $00, $D0, $07
        .byte $A9, $4E, $24, $99, $DC, $06, $60, $A9, $5E, $24, $99, $DC, $06, $60


        _8B65
        lda $0792,b
        and #$0008
        bne _8B7A
        lda #$2C4E
        sta $06DC,b,y
        lda #$2C4F
        sta $06DE,b,y
        rts


        _8B7A
        lda #$2C5E
        sta $06DC,b,y
        lda #$2C5F
        sta $06DE,b,y
        rts

        .databank 0

        ; 88/8B87

      rsUnknown888B87 ; 88/8B87

        .al
        .xl
        .autsiz
        .databank ?

        lda $0792,b
        and #$0008
        bne _8B96
        lda #$2C4F
        sta $06DC,b,y
        rts


        _8B96
        lda #$2C5F
        sta $06DC,b,y
        rts

        .databank 0

        ; 88/8B9D

      rsUnknown888B9D ; 88/8B9D

        .al
        .xl
        .autsiz
        .databank ?

        lda $0792,b
        and #$0008
        bne _8BAC
        lda #$2C4E
        sta $06DC,b,y
        rts


        _8BAC
        lda #$2C5E
        sta $06DC,b,y
        rts

        .databank 0

        ; 88/8BB3

    .endsection Unsorted888A14Section


    .section Unsorted888BB3Section

      .al
      .xl

      rsUnknown888BB3 ; 88/8BB3

        .al
        .autsiz
        .databank ?

        ; Grabs the next row of map tiles when scrolling down?

        _Loop
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        tax
        lda $7F0004,x
        and #$DFFF
        sta $05DC,b,y
        plx

        lda wUnknown00075A,b
        bit #$0002
        beq +

          lda $7F6400,x
          and #$03FF
          asl a
          asl a
          asl a
          clc
          adc wR2
          phx
          tax
          lda $7F0004,x
          and #$DFFF
          ora #$2000
          sta $065C,b,y
          plx

        +
        inc x
        inc x
        inc y
        inc y
        cpy #64
        bcc +

          inc wUnknown00072A,b
          ldy #0

        +
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        tax
        lda $7F0000,x
        and #$DFFF
        sta $05DC,b,y
        plx

        lda wUnknown00075A,b
        bit #$0002
        beq +

          lda $7F6400,x
          and #$03FF
          asl a
          asl a
          asl a
          clc
          adc wR2
          phx
          tax
          lda $7F0000,x
          and #$DFFF
          ora #$2000
          sta $065C,b,y
          plx

        +
        inc y
        inc y
        
        -
        lda wUnknown00072A,b
        beq +

          cpy wR8
          bcs _End
          bra _8C5B

        +
        cpy #64
        bcc _8C5B

          inc wUnknown00072A,b
          ldy #0
          bra -

        _End
        rts
        
        _8C5B
        jml _Loop

        .databank 0

        ; 88/8C5F

    .endsection Unsorted888BB3Section


    .section Unsorted888C5FSection

      .al
      .xl

      rsUnknown888C5F ; 88/8C5F

        .al
        .xl
        .autsiz
        .databank ?

        clc
        adc wMapScrollYPixels,b
        sta $0792,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        lda wMapScrollYPixels,b
        sta wBufferBG3VOFS
        lda wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        jsr rsUnknown888D23
        stz wR9
        stz wUnknown00072A,b
        ldy wR8

        _8C88
        lda $078E,b
        cmp $071E,b
        bcc _8CD2
        cmp $0722,b
        bcs _8CD2
        lda $078C,b
        cmp $071C,b
        bcc _8CD2
        cmp $0720,b
        bcs _8CD2
        jsr rsUnknown888D47
        lda aMovementMap,x
        and #$00FF
        beq _8CED
        jsr $888ABE

        _8CB1
        inc $078C,b
        inc y
        inc y
        cpy #$0040
        bcc _8CC1
        inc wUnknown00072A,b
        ldy #$0000

        _8CC1
        jsr rsUnknown888D47
        lda aMovementMap,x
        and #$00FF
        beq _8CF5
        jsr $888ADD
        bra _8CFB


        _8CD2
        inc $078C,b
        lda #$00FF
        sta $06DC,b,y
        inc y
        inc y
        cpy #$0040
        bcc _8CE8
        inc wUnknown00072A,b
        ldy #$0000

        _8CE8
        sta $06DC,b,y
        bra _8CFB


        _8CED
        lda #$00FF
        sta $06DC,b,y
        bra _8CB1


        _8CF5
        lda #$00FF
        sta $06DC,b,y

        _8CFB
        inc y
        inc y

        _8CFD
        inc wR9
        lda wR9
        cmp #$0010
        bcs _8D22
        lda wUnknown00072A,b
        beq _8D11
        cpy wR8
        bcs _8D22
        bra _8D1E


        _8D11
        cpy #$0040
        bcc _8D1E
        inc wUnknown00072A,b
        ldy #$0000
        bra _8CFD


        _8D1E
        jml _8C88


        _8D22
        rts

        .databank 0

        ; 88/8D23

      rsUnknown888D23 ; 88/8D23

        .al
        .xl
        .autsiz
        .databank ?

        lda $078C,b
        sec
        sbc $0720,b
        and #$003F
        sta wR0
        lda $078E,b
        sec
        sbc $0722,b
        and #$003F
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        sta $0790,b
        clc
        adc wR0
        tax
        rts

        .databank 0

        ; 88/8D47

      rsUnknown888D47 ; 88/8D47

        .al
        .xl
        .autsiz
        .databank ?

        lda $078C,b
        sec
        sbc $0720,b
        and #$003F
        clc
        adc $0790,b
        tax
        rts

        .databank 0

        ; 88/8D57

    .endsection Unsorted888C5FSection


    .section Unsorted888D57Section

      .al
      .xl

      rsUnknown888D57 ; 88/8D57

        .al
        .autsiz
        .databank ?

        lda wUnknown00075C,b
        cmp #4
        beq ++

          cmp #8
          beq +
          
          +
          lda wMapScrollYPixels,b
          and #$FFF0
          asl a
          asl a
          asl a
          asl a
          sta wR3
          bra _8D7F

        +
        lda wMapScrollYPixels,b
        and #$FFF0
        asl a
        asl a
        asl a
        sta wR3
        bra _8D7F

        _8D7F
        lda wMapScrollXPixels,b
        and #$FFF0
        lsr a
        lsr a
        lsr a
        clc
        adc wR3
        sta wR3
        tax

        lda wMapScrollXPixels,b
        and #$00F8
        lsr a
        lsr a
        and #$003E
        sta wR8
        tay
        rts

        .databank 0

      rsUnknown888D9D ; 88/8D9D

        .al
        .autsiz
        .databank ?

        lda wUnknown00075C,b
        cmp #4
        beq ++

          cmp #8
          beq +

          +
          lda wR0
          clc
          adc #$1000
          rts

        +
        lda wR0
        clc
        adc #$0800
        rts

        .databank 0

      rsUnknown888DB8 ; 88/8DB8

        .al
        .autsiz
        .databank ?

        jsr rsUnknown888E73
        clc
        adc #32
        sta wR0

        jsr rsUnknown888D9D
        sta wR8
        stz wR2

        lda wMapScrollXPixels,b
        and #$0008
        bne +

        lda wR0
        sec
        sbc #2
        sta wR0

        lda wR8
        sec
        sbc #2
        sta wR8
        bra ++

        +
        lda #$FFFC
        sta wR2

        +
        lda wMapScrollYPixels,b
        and #$0008
        bne +

          lda #4
          jsr rsUnknown888EB5

          lda wUnknown000770,b
          beq _End

            lda #$00F8
            jsr rsUnknown888F32
            bra _End

        +
        lda #4
        jsr rsUnknown889108

        lda wUnknown000770,b
        beq _End

          lda #$00F8
          jsr rsUnknown8891BC

        _End
        rts

        .databank 0

      rsUnknown888E14 ; 88/8E14

        .al
        .autsiz
        .databank ?

        ; Gets map tile index from camera position?
        jsr rsUnknown888E73
        sta wR0

        jsr rsUnknown888D9D
        sta wR8

        stz wR2

        lda wMapScrollXPixels,b
        and #$0008
        beq +

          lda #4
          sta wR2

        +
        lda wMapScrollYPixels,b
        and #$0008
        bne +

          lda #0
          jsr rsUnknown888EB5

          lda wUnknown000770,b
          beq _End

            lda #0
            jsr rsUnknown888F32
            bra _End

        +
        lda #0
        jsr rsUnknown889108

        lda wUnknown000770,b
        beq _End

          lda #0
          jsr rsUnknown8891BC

        _End
        rts

        .databank 0

      rsUnknown888E5A ; 88/8E5A

        .al
        .autsiz
        .databank ?

        lda wUnknown00075C,b
        cmp #4
        beq ++

        cmp #8
        beq +
        
        +
        txa
        clc
        adc #$0100
        rts
        
        +
        txa
        clc
        adc #$0080
        rts

        .databank 0

      rsUnknown888E73 ; 88/8E73

        .al
        .autsiz
        .databank ?

        lda wMapScrollYPixels,b
        and #$00F8
        lsr a
        lsr a
        and #62
        sta wR3

        lda wUnknown00075C,b
        cmp #4
        beq ++

          cmp #8
          beq +

          +
          lda wMapScrollYPixels,b
          and #$FFF0
          asl a
          asl a
          asl a
          asl a
          sta wR0
          bra ++
        
        +
        lda wMapScrollYPixels,b
        and #$FFF0
        asl a
        asl a
        asl a
        sta wR0
        bra +
        
        +
        lda wMapScrollXPixels,b
        and #$FFF0
        lsr a
        lsr a
        lsr a
        clc
        adc wR0
        rts

        .databank 0

      rsUnknown888EB5 ; 88/8EB5

        .al
        .autsiz
        .databank ?

        sta wR1
        ldy wR3
        ldx wR0

          _Loop
          lda aMapData,x
          and wUnknown000596,b
          asl a
          asl a
          asl a
          clc
          adc wR2
          phx
          clc
          adc wR1
          tax
          lda $7F0000,x
          and #$DFFF
          sta $059C,b,y
          lda $7F0002,x
          and #$DFFF
          sta $059E,b,y
          plx

          lda wUnknown00075A,b
          bit #$0002
          beq +

            lda $7F6400,x
            and #$03FF
            asl a
            asl a
            asl a
            clc
            adc wR2
            phx
            clc
            adc wR1
            tax
            lda $7F0000,x
            and #$DFFF
            ora #$2000
            sta $061C,b,y
            lda $7F0002,x
            and #$DFFF
            ora #$2000
            sta $061E,b,y
            plx

          +
          inc y
          inc y
          inc y
          inc y
          cpy #64
          bcc +

            ldy #0

          +
          jsr rsUnknown888E5A
          cmp wR8
          bmi +
          bcs _End

          +
          tax
          jml _Loop
        
        _End
        rts

        .databank 0

        ; 88/8F32

    .endsection Unsorted888D57Section


    .section Unsorted888F32Section

      .al
      .xl

      rsUnknown888F32 ; 88/8F32

        .al
        .xl
        .autsiz
        .databank ?

        clc
        adc wMapScrollXPixels,b
        sta $0792,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        lda wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG3VOFS
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        jsr rsUnknown8890CF
        stz wR9
        stz wUnknown00072A,b
        lda wR3
        sta wR8
        tay

        _8F5E
        lda $078E,b
        cmp $071E,b
        bcc _8F89
        cmp $0722,b
        bcs _8F89
        lda $078C,b
        cmp $071C,b
        bcc _8F89
        cmp $0720,b
        bcs _8F89
        jsr rsUnknown8890F2
        lda aMovementMap,x
        and #$00FF
        beq _8F89
        jsr rsUnknown888FAF
        bra _8F92


        _8F89
        lda #$00FF
        sta $069C,b,y
        sta $069E,b,y

        _8F92
        inc $078E,b
        inc y
        inc y
        inc y
        inc y
        inc wR9
        lda wR9
        cmp #$0010
        bcs _8FAE
        cpy #$0040
        bcc _8FAA
        ldy #$0000

        _8FAA
        jml _8F5E


        _8FAE
        rts

        .databank 0

        ; 88/8FAF

      rsUnknown888FAF ; 88/8FAF

        .al
        .xl
        .autsiz
        .databank ?

        bit #$0080
        beq _8FB8
        jml _9018


        _8FB8
        lda $0792,b
        and #$0008
        bne _8FCD
        lda #$284E
        sta $069C,b,y
        lda #$285E
        sta $069E,b,y
        rts


        _8FCD
        lda #$284F
        sta $069C,b,y
        lda #$285F
        sta $069E,b,y
        rts

        .byte $89, $80, $00, $F0, $04, $5C, $43, $90, $88, $AD, $92, $07, $29, $08, $00, $D0
        .byte $07, $A9, $5E, $28, $99, $9C, $06, $60, $A9, $5F, $28, $99, $9C, $06, $60, $89
        .byte $80, $00, $F0, $04, $5C, $62, $90, $88, $AD, $92, $07, $29, $08, $00, $D0, $07
        .byte $A9, $4E, $28, $99, $9C, $06, $60, $A9, $4F, $28, $99, $9C, $06, $60


        _9018
        cmp #$0080
        bne _9021
        jml _9081


        _9021
        lda $0792,b
        and #$0008
        bne _9036
        lda #$244E
        sta $069C,b,y
        lda #$245E
        sta $069E,b,y
        rts


        _9036
        lda #$244F
        sta $069C,b,y
        lda #$245F
        sta $069E,b,y
        rts

        .byte $C9, $80, $00, $D0, $04, $5C, $A3, $90, $88, $AD, $92, $07, $29, $08, $00, $D0
        .byte $07, $A9, $5E, $24, $99, $9C, $06, $60, $A9, $5F, $24, $99, $9C, $06, $60, $C9
        .byte $80, $00, $D0, $04, $5C, $B9, $90, $88, $AD, $92, $07, $29, $08, $00, $D0, $07
        .byte $A9, $4E, $24, $99, $9C, $06, $60, $A9, $4F, $24, $99, $9C, $06, $60


        _9081
        lda $0792,b
        and #$0008
        bne _9096
        lda #$2C4E
        sta $069C,b,y
        lda #$2C5E
        sta $069E,b,y
        rts


        _9096
        lda #$2C4F
        sta $069C,b,y
        lda #$2C5F
        sta $069E,b,y
        rts

        .databank 0

        ; 88/90A3

      rsUnknown8890A3 ; 88/90A3

        .al
        .xl
        .autsiz
        .databank ?

        lda $0792,b
        and #$0008
        bne _90B2
        lda #$2C5E
        sta $069C,b,y
        rts


        _90B2
        lda #$2C5F
        sta $069C,b,y
        rts

        .databank 0

        ; 88/90B9

      rsUnknown8890B9 ; 88/90B9

        .al
        .xl
        .autsiz
        .databank ?

        lda $0792,b
        and #$0008
        bne _90C8
        lda #$2C4E
        sta $069C,b,y
        rts


        _90C8
        lda #$2C4F
        sta $069C,b,y
        rts

        .databank 0

        ; 88/90CF

      rsUnknown8890CF ; 88/90CF

        .al
        .xl
        .autsiz
        .databank ?

        lda $078C,b
        sec
        sbc $0720,b
        and #$003F
        sta $0790,b
        lda $078E,b
        sec
        sbc $0722,b
        and #$003F
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc $0790,b
        tax
        rts

        .databank 0

        ; 88/90F2

      rsUnknown8890F2 ; 88/90F2

        .al
        .xl
        .autsiz
        .databank ?

        lda $078E,b
        sec
        sbc $0722,b
        and #$003F
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc $0790,b
        tax
        rts

        .databank 0

        ; 88/9108

      rsUnknown889108 ; 88/9108

        .al
        .xl
        .autsiz
        .databank ?

        sta wR1
        ldy wR3
        ldx wR0

        _910E
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        clc
        adc wR1
        tax
        lda $7F0002,x
        and #$DFFF
        sta $059C,b,y
        plx
        lda wUnknown00075A,b
        bit #$0002
        beq _9153
        lda $7F6400,x
        and #$03FF
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        clc
        adc wR1
        tax
        lda $7F0002,x
        and #$DFFF
        ora #$2000
        sta $061C,b,y
        plx

        _9153
        inc y
        inc y
        cpy #$0040
        bcc _915D
        ldy #$0000

        _915D
        jsr rsUnknown888E5A
        tax
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        clc
        adc wR1
        tax
        lda $7F0000,x
        and #$DFFF
        sta $059C,b,y
        plx
        lda wUnknown00075A,b
        bit #$0002
        beq _91A6
        lda $7F6400,x
        and #$03FF
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        clc
        adc wR1
        tax
        lda $7F0000,x
        and #$DFFF
        ora #$2000
        sta $061C,b,y
        plx

        _91A6
        inc y
        inc y
        cpy #$0040
        bcc _91B0
        ldy #$0000

        _91B0
        txa
        cmp wR8
        bmi _91B7
        bcs _91BB

        _91B7
        jml _910E


        _91BB
        rts

        .databank 0

        ; 88/91BC

      rsUnknown8891BC ; 88/91BC

        .al
        .xl
        .autsiz
        .databank ?

        clc
        adc wMapScrollXPixels,b
        sta $0792,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        lda wMapScrollXPixels,b
        sta wBufferBG3HOFS
        lda wMapScrollYPixels,b
        sta wBufferBG3VOFS
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        jsr rsUnknown8890CF
        stz wR9
        stz wUnknown00072A,b
        lda wR3
        sta wR8
        tay

        _91E8
        lda $078E,b
        cmp $071E,b
        bcc _9232
        cmp $0722,b
        bcs _9232
        lda $078C,b
        cmp $071C,b
        bcc _9232
        cmp $0720,b
        bcs _9232
        jsr rsUnknown8890F2
        lda aMovementMap,x
        and #$00FF
        beq _9242
        jsr $888FDA

        _9211
        inc $078E,b
        inc y
        inc y
        cpy #$0040
        bcc _9221
        inc wUnknown00072A,b
        ldy #$0000

        _9221
        jsr rsUnknown8890F2
        lda aMovementMap,x
        and #$00FF
        beq _924A
        jsr $888FF9
        bra _9250


        _9232
        inc $078E,b
        lda #$00FF
        sta $069C,b,y
        inc y
        inc y
        sta $069C,b,y
        bra _9250


        _9242
        lda #$00FF
        sta $069C,b,y
        bra _9211


        _924A
        lda #$00FF
        sta $069C,b,y

        _9250
        inc y
        inc y
        inc wR9
        lda wR9
        cmp #$0010
        bcs _9267
        cpy #$0040
        bcc _9263
        ldy #$0000

        _9263
        jml _91E8


        _9267
        rts

        .databank 0

        ; 88/9268

      rlUnknown889268 ; 88/9268

        .al
        .xl
        .autsiz
        .databank ?

        lda wCurrentChapter,b
        asl a
        clc
        adc wCurrentChapter,b
        tax
        lda aUnknown889FC3+1,x
        sta lR19+1
        lda aUnknown889FC3,x
        sta lR19
        ldy #$0000
        lda [lR19],y
        sta lR45
        ldy #$0001
        lda [lR19],y
        sta lR45+1
        lda #(`aMapData)<<8
        sta lR47+1
        lda #<>aMapData
        sta lR47
        jsl rlDecompressSingle
        ldy #$0003
        lda [lR19],y
        sta lR45
        ldy #$0004
        lda [lR19],y
        sta lR45+1
        lda #$7F00
        sta lR47+1
        lda #$0000
        sta lR47
        jsl rlDecompressSingle
        ldy #$000C
        lda [lR19],y
        sta wUnknown00075C,b
        inc y
        inc y
        lda [lR19],y
        sta $075E,b
        inc y
        inc y
        lda [lR19],y
        sta wMapMinXScroll,b
        inc y
        inc y
        lda [lR19],y
        sta wMapMinYScroll,b
        inc y
        inc y
        lda [lR19],y
        sec
        sbc #$0100
        sta wMapMaxXScroll,b
        inc y
        inc y
        lda [lR19],y
        sec
        sbc #$00E0
        sta wMapMaxYScroll,b
        ldy #$0018
        lda [lR19],y
        sta lR45
        ldy #$0019
        lda [lR19],y
        sta lR45+1
        lda #(`aTerrainTileset)<<8
        sta lR47+1
        lda #<>aTerrainTileset
        sta lR47
        jsl rlDecompressSingle
        rtl

        .databank 0

        ; 88/9305

      rlUnknown889305 ; 88/9305

        .al
        .xl
        .autsiz
        .databank ?

        lda wCurrentChapter,b
        asl a
        clc
        adc wCurrentChapter,b
        tax
        lda aUnknown889FC3+1,x
        sta lR19+1
        lda aUnknown889FC3,x
        sta lR19
        ldy #$0006
        lda [lR19],y
        sta lR45
        ldy #$0007
        lda [lR19],y
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda #<>aDecompressionBuffer
        sta lR47
        jsl rlDecompressSingle
        lda #(`aDecompressionBuffer)<<8
        sta lR20+1
        lda #<>aDecompressionBuffer
        sta lR20
        sep #$20
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$20
        sta $4316,b
        lda #$18
        sta $4311,b
        lda lR20
        sta $4312,b
        lda lR20+1
        sta $4313,b
        lda lR20+2
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$28
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20
        ldy #$000A
        lda [lR19],y
        sta lR20+1
        ldy #$0009
        lda [lR19],y
        sta lR20
        ldy #$00DE

        _938C
        lda [lR20],y
        sta aBGPaletteBuffer.aPalette1,b,y
        dec y
        dec y
        bpl _938C
        rtl

        .databank 0

        ; 88/9396

    .endsection Unsorted888F32Section


    .section ProcScript889396Section

      .al
      .xl

      procUnknown889396 ; 88/9396

        .structProcInfo "MG", rlProcUnknown889396Init, rlProcUnknown889396Cycle, aProcUnknown889396Code

    .endsection ProcScript889396Section


    .section Unsorted88939ESection

      .al
      .xl

      rlProcUnknown889396Init ; 88/939E

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8B88
        sta aProcSystem.aBody0,b,x
        lda #$3000
        sta aProcSystem.aBody1,b,x
        lda #$0004
        sta aProcSystem.aBody2,b,x
        lda #$8800
        sta lR19+1
        lda #$93DB
        sta lR19
        jsl rlApplyMapMenuPaletteData
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferCGWSEL
        lda #$BD
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        rep #$20
        rtl

        .databank 0

        ; 88/93DB

    .endsection Unsorted88939ESection


    .section Unsorted889400Section

      .al
      .xl

      rlProcUnknown889396Cycle ; 88/9400

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown889B22
        lda #$9411
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$1FFE
        sta aProcSystem.aBody2,b,x
        rtl

        .databank 0

        ; 88/9411

    .endsection Unsorted889400Section


    .section ProcScript889504Section

      .al
      .xl

      aProcUnknown889396Code ; 88/9504

        PROC_HALT


        ; 88/9506

    .endsection ProcScript889504Section


    .section Unsorted88973FSection

      .al
      .xl

      rlUnknown88973F ; 88/973F

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnknown889396)<<8
        sta lR44+1
        lda #<>procUnknown889396
        sta lR44
        jsl rlProcEngineFindProc
        bcc _9753
        jml _9840


        _9753
        lda #(`procUnknown889C52)<<8
        sta lR44+1
        lda #<>procUnknown889C52
        sta lR44
        jsl rlProcEngineFindProc
        bcc _9767
        jml _9840


        _9767
        lda wUnknown000D79,b
        bit #$0800
        beq _9773
        jml _9841


        _9773
        lda wUnknown000766,b
        bne _97DA
        lda wJoy1New
        bit #$9000
        beq _978E
        lda #(`procUnknown889C52)<<8
        sta lR44+1
        lda #<>procUnknown889C52
        sta lR44
        jsl rlProcEngineCreateProc
        rtl


        _978E
        jsr rsUnknown889A41
        lda wJoy1Input
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        bne _97AC
        lda $0ADB,b
        beq _9801
        stz $0ADB,b
        lda #$001C
        jsl rlUnknown808FAD
        bra _9801


        _97AC
        lda $0ADB,b
        bne _97C2
        inc $0ADB,b
        lda #$001A
        jsl rlUnknown808FAD
        lda #$001B
        jsl rlUnknown808FAD

        _97C2
        stz wMapScrollCurrentPixelDistance,b
        lda #$0001
        sta wUnknown000766,b
        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        lda #$0004
        sta wMapScrollSpeed,b

        _97DA
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp #$0010
        bcc _97F5
        stz wUnknown000766,b
        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b

        _97F5
        jsl rlUnknown8899B8
        lda wMapScrollCurrentPixelDistance,b
        cmp wMapScrollSpeed,b
        bne _9801

        _9801
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #$EE94
        lda wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0040
        sta wR0
        lda wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0030
        sta wR1
        lda #$2000
        sta wR5
        lda #$0000
        sta wR4
        lda wVBlankEnabledFramecount
        and #$0018
        beq _9838
        ldy #$EE7E

        _9838
        jsl rlPushToOAMBuffer
        jsl rlUnknown889A85

        _9840
        rtl


        _9841
        jsr rsUnknown88986C
        lda $087D,b
        asl a
        clc
        adc #$0040
        sec
        sbc #$0010
        sta wR0
        lda $087F,b
        asl a
        clc
        adc #$0030
        sec
        sbc #$0006
        sta wR1
        lda #$0000
        jsl rlUnknown88A704
        jsl rlUnknown889A85
        rtl

        .databank 0

        ; 88/986C

      rsUnknown88986C ; 88/986C

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1New
        bit #$0500
        bne _9883
        bit #$0A00
        bne _988A
        bit #$0080
        bne _98B4
        bit #$8000
        bne _98A1
        rts


        _9883
        inc $087B,b
        jml _98D2


        _988A
        dec $087B,b
        lda $087B,b
        bpl _989D
        jsl rlUnknown87E979
        sec
        sbc #$0001
        sta $087B,b

        _989D
        jml _98D2


        _98A1
        lda #(`procUnknown889C52)<<8
        sta lR44+1
        lda #<>procUnknown889C52
        sta lR44
        jsl rlProcEngineCreateProc
        stz wUnknown0007D8,b
        rts

        .byte $60


        _98B4
        lda #$4000
        tsb $0788,b
        lda #(`procUnknown889C52)<<8
        sta lR44+1
        lda #<>procUnknown889C52
        sta lR44
        jsl rlProcEngineCreateProc
        rts

        .byte $20, $20, $00, $00, $00, $00, $88, $83, $7E


        _98D2
        lda $087B,b
        jsl rlGetLocationEventDataEntry
        bcs _992C
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeCastle
        bne _9931
        jsl rlGetLocationFactionSlotOwner
        cmp #$0000
        bne _9931
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        sta $078C,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        sta $078E,b
        jsl rlGetEventLocationEntryID
        sta $0790,b
        lda #$0000
        jsl rlGetFactionSlotLocationID
        cmp $0790,b
        beq _991E
        lda $078C,b
        sta wR0
        lda $078E,b
        sta wR1
        jsl rlGetUnitByCoordinates
        bcc _9931

        _991E
        lda $078C,b
        sta $087D,b
        lda $078E,b
        sta $087F,b
        bra _9952


        _992C
        stz $087B,b
        bra _98D2


        _9931
        lda wJoy1New
        bit #$0A00
        bne _993D
        inc $087B,b
        bra _98D2


        _993D
        dec $087B,b
        lda $087B,b
        bpl _98D2
        jsl rlUnknown87E979
        sec
        sbc #$0001
        sta $087B,b
        bra _98D2


        _9952
        lda #$8800
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$98C9
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8800
        sta lRoutineVariable+1,b
        lda #$99A4
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$040D
        jsl rlDrawMenuTextLine
        jsl rlGetEventLocationEntryCastleName
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$040D
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8488, $0080, $80, $B100

        rts

        .databank 0

        ; 88/99A4

    .endsection Unsorted88973FSection


    .section Unsorted8899B8Section

      .al
      .xl

      rlUnknown8899B8 ; 88/99B8

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        sta wUnknown000734,b
        lda wMapScrollYPixels,b
        sta wUnknown000736,b
        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _99F0
        cmp #$0100
        beq _99F6
        cmp #$0800
        beq _99FC
        cmp #$0400
        beq _9A02
        cmp #$0A00
        beq _9A08
        cmp #$0600
        beq _9A0E
        cmp #$0900
        beq _9A14
        cmp #$0500
        beq _9A1A

        _99EF
        rtl


        _99F0
        jsl rlUnknown8885EF
        bra _9A20


        _99F6
        jsl rlUnknown8885FD
        bra _9A20


        _99FC
        jsl rlUnknown8885D3
        bra _9A20


        _9A02
        jsl rlUnknown8885E1
        bra _9A20


        _9A08
        jsl rlUnknown88860B
        bra _9A20


        _9A0E
        jsl rlUnknown88861C
        bra _9A20


        _9A14
        jsl rlUnknown88862D
        bra _9A20


        _9A1A
        jsl rlUnknown88863E
        bra _9A20


        _9A20
        lda wMapScrollXPixels,b
        cmp wUnknown000734,b
        bne _99EF
        lda wMapScrollYPixels,b
        cmp wUnknown000736,b
        bne _99EF
        lda $0ADB,b
        beq _99EF
        stz $0ADB,b
        lda #$001C
        jsl rlUnknown808FAD
        bra _99EF

        .databank 0

        ; 88/9A41

      rsUnknown889A41 ; 88/9A41

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        bit #$0010
        bne _9A6F
        bit #$0040
        bne _9A6F
        bit #$0080
        bne _9A6F
        bit #$4000
        bne _9A6F
        lda wJoy1New
        bit #$0020
        bne _9A80

        _9A5E
        sep #$20
        lda #$00
        sta bBufferCGWSEL
        lda #$A9
        sta bBufferCGADSUB
        lda #$00
        sta bBufferTS
        rep #$20
        rts


        _9A6F
        sep #$20
        lda #$02
        sta bBufferCGWSEL
        lda #$52
        sta bBufferCGADSUB
        lda #$11
        sta bBufferTS
        rep #$20
        rts


        _9A80
        jsr rsUnknown88C1BF
        bra _9A5E

        .databank 0

        ; 88/9A85

      rlUnknown889A85 ; 88/9A85

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$001E
        tax
        lda aUnknown889AE2,x
        and #$03FF
        clc
        adc #$7C00
        sta $01D8,b
        lda aUnknown889AE2,x
        and #$7FE0
        clc
        adc #$001F
        sta $01DA,b
        lda aUnknown889AE2,x
        and #$7C1F
        clc
        adc #$03E0
        sta $01DC,b
        lda aUnknown889AE2,x
        and #$7C00
        clc
        adc #$033F
        sta $01DE,b
        rtl

        .databank 0

        ; 88/9AC4

    .endsection Unsorted8899B8Section


    .section Table889AE2Section

      .al
      .xl

      aUnknown889AE2 ; 88/9AE2

        ; Read by rlUnknown889A85.

        .word $0000, $0421, $0842, $1084, $18C6, $1CE7, $2529, $7DEF
        .word $7DEF, $2529, $1CE7, $18C6, $1084, $0842, $0421, $0000
        .word $0000, $0021, $0042, $0063, $0084, $00A5, $00C6, $00E7
        .word $00E7, $00C6, $00A5, $0084, $0063, $0042, $0021, $0000

        ; 88/9B22

    .endsection Table889AE2Section


    .section Unsorted889B22Section

      .al
      .xl

      rlUnknown889B22 ; 88/9B22

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E
        phx
        phy
        ldx #$01FE
        lda #$0000

        _9B34
        sta $8B88,b,x
        sta $8D88,b,x
        sta $8F88,b,x
        sta $9188,b,x
        sta $9388,b,x
        sta $9588,b,x
        sta $9788,b,x
        sta $9988,b,x
        sta $9B88,b,x
        sta $9D88,b,x
        sta $9F88,b,x
        sta $A188,b,x
        sta $A388,b,x
        sta $A588,b,x
        sta $A788,b,x
        sta $A988,b,x
        dec x
        dec x
        bpl _9B34
        ply
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/9B6D

    .endsection Unsorted889B22Section


    .section Unsorted889BB5Section

      .al
      .xl

      rsUnknown889BB5 ; 88/9BB5

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        asl wR0+1
        asl wR1
        ora #10,s
        asl a
        ora wR2
        phd
        php
        php
        php
        php
        ora wR5+1
        ora [wR4]
        php
        php
        php
        php
        php
        php
        php
        tsb $C9
        ora (wR0)
        beq _9BD9
        cmp #$0013
        bne _9BF5

        _9BD9
        jsl rlUnknown87EA09
        bcs _9BF5
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeVillage
        bne _9BF5
        jsl rlCheckIfVillageClosed
        bcc _9BF5
        lda #$0009
        sta wR2
        sec
        rts


        _9BF5
        clc
        rts

        .databank 0

        ; 88/9BF7

    .endsection Unsorted889BB5Section


    .section ProcScript889C52Section

      .al
      .xl

      procUnknown889C52 ; 88/9C52

        .structProcInfo "MC", rlProcUnknown889C52Init, rlProcUnknown889C52Cycle, aProcUnknown889C52Code

    .endsection ProcScript889C52Section


    .section Unsorted889C5ASection

      .al
      .xl

      rlProcUnknown889C52Init ; 88/9C5A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        lda #$15
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        lda #$20
        sta bBufferCOLDATA_1
        lda #$40
        sta bBufferCOLDATA_2
        lda #$80
        sta bBufferCOLDATA_3
        rep #$20
        ldx #$07FE
        lda #$00FF

        _9C81
        sta aBG2TilemapBuffer.Page1,x
        dec x
        dec x
        bpl _9C81
        jsl rlDMAByStruct

          .structDMAToVRAM $7E7C88, $0500, $80, $A900

        lda #$001D
        jsl rlUnknown808FAD
        lda wCursorXOffset,b
        clc
        adc wMapXOffset,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR10
        lda wCursorYOffset,b
        clc
        adc wMapYOffset,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR11
        lda wUnknown000D79,b
        bit #$0800
        bne _9CDF
        jsl rlUnknown88BFC3
        lda wR10
        cmp #$FFFF
        beq _9CD6
        lda wR10
        sta wCursorXOffset,b
        lda wR11
        sta wCursorYOffset,b
        bra _9CDF


        _9CD6
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b

        _9CDF
        plx
        rtl

        .databank 0

        ; 88/9CE1

      rlProcUnknown889C52Cycle ; 88/9CE1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown899FDC
        plx
        lda #$9CEE
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 88/9CEE

    .endsection Unsorted889C5ASection


    .section Unsorted889D20Section

      .al
      .xl

      rlUnknown889D20 ; 88/9D20

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        sep #$20
        rep #$10
        ldx #$2542
        stx DecompressionVariables
        lda #$C0
        sta $CA
        ldx #$8F88
        stx $CB
        lda #$7E
        sta $CD
        rep #$30
        jsl rlDecompressor
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8F88, $0400, $80, $6C00

        jsl rlUnknown80B0A3
        lda #$8800
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #$98C9
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$8800
        sta lRoutineVariable+1,b
        lda #$9D92
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$040D
        jsl rlDrawMenuTextLine
        jsl rlDMAByStruct

          .structDMAToVRAM $7E8488, $0080, $80, $B100

        plx
        lda #$9DA6
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 88/9D92

    .endsection Unsorted889D20Section


    .section ProcScript889E6CSection

      .al
      .xl

      aProcUnknown889C52Code ; 88/9E6C

        PROC_HALT


        ; 88/9E6E

    .endsection ProcScript889E6CSection


    .section Unsorted88A12BSection

      .al
      .xl

      rlUnknown88A12B ; 88/A12B

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        jsl rlUnknown88A136

        plp
        plb
        rtl

        .databank 0

      rlUnknown88A136 ; 88/A136

        .al
        .autsiz
        .databank ?

        stz wUnknown000758,b
        jsr rsUnknown88A32D

        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b

        sep #$20
        lda $70
        rep #$20
        and #$000F
        cmp #$000F
        beq +
        
          -
          jml _End

        +
        lda #(`procFadeIn)<<8
        sta $62+1
        lda #<>procFadeIn
        sta $62
        jsl rlProcEngineFindProc
        bcs -

        lda #(`procFadeInByScreenFadingTimer)<<8
        sta $62+1
        lda #<>procFadeInByScreenFadingTimer
        sta $62
        jsl rlProcEngineFindProc
        bcs -

        lda bUnknown000E7B,b
        and #$00FF
        bit #$0041
        beq ++

          lda $086F,b
          bpl +

            jsr rsUnknown88C71C
          
          +
          jml rlUnknown88C4D9

        +
        lda wUnknown00171A,b
        beq +

          jml _End
        
        +
        lda $0788,b
        bit #$0020
        beq +

          jml rlUnknown88973F

        +
        lda $07E0,b
        bpl +

          lda $0772,b
          jsl rlUnknown88B42C
          jml _End
        
        +
        lda $0786,b
        bit #$0002
        beq _A234

          ldx $0772,b
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b

          ldx $0772,b
          lda wCursorXOffset,b
          clc
          adc wMapScrollXPixels,b
          sta $0780,b

          lda aDeploymentTable._YTilePosition,x
          asl a
          asl a
          asl a
          asl a
          sta $0782,b

          lda wCursorXOffset,b
          clc
          adc wMapScrollXPixels,b
          lsr a
          lsr a
          lsr a
          lsr a
          sta $0778,b

          lda wCursorYOffset,b
          clc
          adc wMapScrollYPixels,b
          lsr a
          lsr a
          lsr a
          lsr a
          sta $077A,b

          lda #3
          sta $07DA,b

          stz $07DC,b
          stz $07DE,b
          jsl rlDeployedUnitSetHidden

          stz wUnknown0007E2,b

          jsl rlUnknown88C9A6

          lda $0786,b
          bit #$0008
          bne +

            jsl rlUnknown84B32B

            lda #$0002
            trb $0786,b

            lda #$0004
            tsb $0786,b
            bra _A234

          +
          lda #$0002
          trb $0786,b

          jsl rlUnknown88A2F5

        _A234
        lda wUnknown0007D8,b
        beq _A24F

          cmp #$FFFF
          beq ++

            cmp #$0003
            beq +

              jml rlUnknown88A754
            
            +
            jml rlUnknown88A81D
          
          +
          jml _A2BD

        _A24F
        lda wUnknown000766,b
        bne _A28D

          lda wJoy1New
          bit #~(JOY_Y | JOY_Directions | JOY_ID)
          beq +

            jsr rsMapInputHandler
            stz wMapScrollDirectionIdentifier,b
            bra _A2BD
          
          +
          jsr rsUnknown88A551
          bcc _A2BD

            stz wMapScrollCurrentPixelDistance,b
            lda #1
            sta wUnknown000766,b
            stz wUnknown00073A,b
            stz wMapEnableXScrollFlag,b
            stz wMapEnableYScrollFlag,b
            lda #4
            sta wMapScrollSpeed,b

            lda wJoy1Input
            bit #JOY_Y
            beq _A28D

              lda #8
              sta wMapScrollSpeed,b
        
        _A28D
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp #16
        bcc +

          stz wUnknown000766,b
          stz wUnknown00073A,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b
          lda #1
          sta wUnknown000758,b

        +
        jsl rlUnknown88BC05

        lda wMapScrollCurrentPixelDistance,b
        cmp wMapScrollSpeed,b
        bne _A2BD

          jsr rsUnknown88BEEF

        _A2BD
        sep #$20
        lda #$88
        pha
        plb
        rep #$20

        ldy #$EE52
        lda wCursorXOffset,b
        sta $00
        lda wCursorYOffset,b
        sta $02
        lda #$2000
        sta $0A
        lda #0
        sta $08

        lda wUnknown000770,b
        beq +

          lda #4
          sta $08
        
        +
        lda $DB
        and #$0018
        beq +

          ldy #$EE3C

        +
        jsl rlPushToOAMBuffer

        _End
        rtl

        .databank 0

        ; 88/A2F5

    .endsection Unsorted88A12BSection


    .section Unsorted88A2F5Section

      .al
      .xl

      rlUnknown88A2F5 ; 88/A2F5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta wUnknown0007D8,b
        lda $0772,b
        sta wR0
        lda $0774,b
        sta wR1
        lda #$0004
        trb $0786,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda #$0008
        trb $0786,b
        jsl rlUnknown85921D
        jsl rlUnknown84DC1C
        lda #$0008
        jsl rlUnknown808FAD
        rtl

        .databank 0

        ; 88/A32D

    .endsection Unsorted88A2F5Section


    .section Unsorted88A32DSection

      .al
      .xl

      rsUnknown88A32D ; 88/A32D

        .al
        .autsiz
        .databank ?

        lda $0788,b
        bit #$8000
        beq +

          lda #1
          sta wUnknown000758,b
          lda #$8000
          trb $0788,b
        
        +
        lda $0788,b
        and #$FFE0
        sta $0788,b

        lda wJoy1Input
        bit #$4000 ; JOY_Y
        beq +

          lda #$0001
          tsb $0788,b
        
        +
        lda wUnknown000770,b
        bne +

          lda $0786,b
          bne +

            lda $07E0,b
            beq ++
        
        +
        lda #$0002
        tsb $0788,b

        +
        lda wUnknown0007D8,b
        beq +

          lda #$0004
          tsb $0788,b
        
        +
        lda wUnknown00171A,b
        beq +

          lda #$0010
          tsb $0788,b

        +
        rts

        .databank 0

        ; 88/A383

    .endsection Unsorted88A32DSection


    .section Unsorted88A395Section

      .al
      .xl

      rlUnknown88A395 ; 88/A395

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        stz wUnknown000758,b
        lda wUnknown000766,b
        bne _A3E6
        lda wJoy1Input
        bit #$4000
        bne _A3B0
        lda wJoy1Repeated
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        beq _A40B
        bra _A3BA


        _A3B0
        lda wJoy1Input
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        beq _A40B

        _A3BA
        stz wMapScrollCurrentPixelDistance,b
        lda #$0001
        sta wUnknown000766,b
        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        lda #$0005
        jsl rlUnknown808FAD
        lda #$0004
        sta wMapScrollSpeed,b
        lda wJoy1Input
        bit #$4000
        beq _A3E6
        lda #$0008
        sta wMapScrollSpeed,b

        _A3E6
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp #$0010
        bcc _A407
        stz wUnknown000766,b
        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b
        lda #$0001
        sta wUnknown000758,b

        _A407
        jsl rlUnknown88BC05

        _A40B
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #$EE52
        lda wCursorXOffset,b
        sta wR0
        lda wCursorYOffset,b
        sta wR1
        lda #$2000
        sta wR5
        lda #$0000
        sta wR4
        lda wUnknown000770,b
        beq _A447
        cmp #$0001
        beq _A439
        cmp #$0002
        beq _A440

        _A439
        lda #$0004
        sta wR4
        bra _A447


        _A440
        lda #$0006
        sta wR4
        bra _A447


        _A447
        jsl rlPushToOAMBuffer
        rtl

        .databank 0

        ; 88/A44C

    .endsection Unsorted88A395Section


    .section Unsorted88A4FCSection

      .al
      .xl

      rlUnknown88A4FC ; 88/A4FC

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown80B0A3
        jsl rlUnknown859BBD
        rtl

        .databank 0

        ; 88/A505

    .endsection Unsorted88A4FCSection


    .section Unsorted88A551Section

      .al
      .xl

      rsUnknown88A551 ; 88/A551

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        bit #$4000
        bne _A564
        lda wJoy1Repeated
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        beq _A5C0
        bra _A570


        _A564
        lda wJoy1Input
        and #$0F00
        sta wMapScrollDirectionIdentifier,b
        beq _A5C0
        bra _A5C2


        _A570
        lda wUnknown000770,b
        beq _A5C2
        lda wJoy1New
        and #$0F00
        bne _A5C2
        lda wCursorXOffset,b
        sta wR0
        lda wCursorYOffset,b
        sta wR1
        jsr _A650
        bcc _A5C2
        lda wCursorXOffset,b
        sta wR0
        lda wCursorYOffset,b
        sta wR1
        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _A5C4
        cmp #$0100
        beq _A5D1
        cmp #$0800
        beq _A5DE
        cmp #$0400
        beq _A5EB
        cmp #$0A00
        beq _A5F8
        cmp #$0600
        beq _A60E
        cmp #$0900
        beq _A624
        cmp #$0500
        beq _A63A

        _A5C0
        clc
        rts


        _A5C2
        sec
        rts


        _A5C4
        lda wCursorXOffset,b
        sec
        sbc #$0010
        sta wR0
        jml _A650


        _A5D1
        lda wCursorXOffset,b
        clc
        adc #$0010
        sta wR0
        jml _A650


        _A5DE
        lda wCursorYOffset,b
        sec
        sbc #$0010
        sta wR1
        jml _A650


        _A5EB
        lda wCursorYOffset,b
        clc
        adc #$0010
        sta wR1
        jml _A650


        _A5F8
        lda wCursorXOffset,b
        sec
        sbc #$0010
        sta wR0
        lda wCursorYOffset,b
        sec
        sbc #$0010
        sta wR1
        jml _A650


        _A60E
        lda wCursorXOffset,b
        sec
        sbc #$0010
        sta wR0
        lda wCursorYOffset,b
        clc
        adc #$0010
        sta wR1
        jml _A650


        _A624
        lda wCursorXOffset,b
        clc
        adc #$0010
        sta wR0
        lda wCursorYOffset,b
        sec
        sbc #$0010
        sta wR1
        jml _A650


        _A63A
        lda wCursorXOffset,b
        clc
        adc #$0010
        sta wR0
        lda wCursorYOffset,b
        clc
        adc #$0010
        sta wR1
        jml _A650


        _A650
        lda wR0
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        sta wR0
        lda wR1
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        sta wR1
        lda $078E,b
        cmp $071E,b
        bcc _A696
        cmp $0722,b
        bcs _A696
        lda $078C,b
        cmp $071C,b
        bcc _A696
        cmp $0720,b
        bcs _A696
        jsr rsUnknown888D23
        lda aMovementMap,x
        and #$007F
        beq _A696
        sec
        rts


        _A696
        clc
        rts

        .databank 0

        ; 88/A698

    .endsection Unsorted88A551Section


    .section Unsorted88A698Section

      .al
      .xl

      rsUnknown88A698 ; 88/A698

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        bit #$4000
        bne _A6B3
        lda $0752,b
        beq _A6BB
        lda wJoy1New
        and #$0F00
        bne _A6BB
        lda #$0004
        sta wMapScrollSpeed,b
        bra _A6C3


        _A6B3
        lda #$0008
        sta wMapScrollSpeed,b
        bra _A6C3


        _A6BB
        lda #$0001
        sta wMapScrollSpeed,b
        bra _A6C3


        _A6C3
        lda #$0001
        sta $0752,b
        rts

        .databank 0

        ; 88/A6CA

    .endsection Unsorted88A698Section


    .section Unsorted88A704Section

      .al
      .xl

      rlUnknown88A704 ; 88/A704

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        phy
        cmp #$0000
        beq _A710
        lda wR0
        bra _A71E


        _A710
        lda wVBlankEnabledFramecount
        and #$001C
        lsr a
        tax
        lda aUnknown88A73D,x
        clc
        adc wR0

        _A71E
        sta wR0
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #$A74D
        lda #$0000
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        ply
        plx
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/A73D

    .endsection Unsorted88A704Section


    .section Table88A73DSection

      .al
      .xl

      aUnknown88A73D ; 88/A73D

        ; Read by rlUnknown88A704.

        .byte $00, $00, $00, $00, $01, $00, $01, $00, $00, $00, $00, $00, $FF, $FF, $FF, $FF
        .byte $01, $00, $00, $C2, $00, $02, $30

        ; 88/A754

    .endsection Table88A73DSection


    .section Unsorted88A754Section

      .al
      .xl

      rlUnknown88A754 ; 88/A754

        .al
        .autsiz
        .databank $00

        lda wUnknown000766,b
        bne _A7BA

          lda wUnknown0007D8,b
          cmp #2
          beq _A788

            cmp #4
            beq _A795

              cmp #5
              beq _A795

                cmp #6
                beq _A795

                  cmp #7
                  beq _A795

                    lda #16
                    sta wMapPixelScrollDistance,b
                    jsr rsUnknown88A9B4
                    beq _End

                      lda #8
                      sta wMapScrollSpeed,b
                      bra +
          
          _A788
          stz wMapPixelScrollDistance,b
          jsr rsUnknown88AA1E
          beq _End

            jsr rsUnknown88A7F5
            bra +

          _A795
          lda #16
          sta wMapPixelScrollDistance,b
          jsr rsUnknown88B64F
          beq _End

            lda #8
            sta wMapScrollSpeed
            bra +

          +
          stz wMapScrollCurrentPixelDistance,b
          lda #1
          sta wUnknown000766,b
          stz wUnknown00073A,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b

        _A7BA
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp wMapPixelScrollDistance,b
        bcc +

          sec
          sbc wMapPixelScrollDistance,b
          sta wR0
          lda wMapScrollSpeed,b
          sec
          sbc wR0
          sta wMapScrollSpeed,b

          stz wUnknown000766,b
          stz wUnknown00073A,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b
        
        +
        jsl rlUnknown88BC05

        lda wUnknown0007D8,b
        cmp #2
        bne _End

          jsl rlUnknown88C0B3

        _End
        rtl

        .databank 0

        ; 88/A7F5

    .endsection Unsorted88A754Section


    .section Unsorted88A7F5Section

      .al
      .xl

      rsUnknown88A7F5 ; 88/A7F5

        .al
        .xl
        .autsiz
        .databank ?

        ldx $0772,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitTotalSpeed
        cmp #$0005
        bcc _A80F
        lda #$0003
        sta wMapScrollSpeed,b
        rts


        _A80F
        lda #$0001
        sta wMapScrollSpeed,b
        rts

        .databank 0

        ; 88/A816

    .endsection Unsorted88A7F5Section


    .section Unsorted88A81DSection

      .al
      .xl

      rlUnknown88A81D ; 88/A81D

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta $07DA,b
        lda wJoy1New
        bit #$8000
        beq _A89A
        lda $077C,b
        sta $0778,b
        lda $077E,b
        sta $077A,b
        lda #$0005
        jsl rlUnknown808FAD
        stz wUnknown0007D8,b
        lda $0786,b
        bit #$0004
        bne _A85D
        lda #$0008
        tsb $0788,b
        jsl rlUnknown85921D
        jsl rlUnknown85E85D
        lda #$0800
        trb wUnknown000D79,b
        rtl


        _A85D
        lda #$0040
        trb wUnknown000D79,b
        lda $0772,b
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
        jsl rlUnknown85921D
        stz $07DA,b
        lda #$0004
        trb $0786,b
        ldx $0772,b
        jsl rlUnknown84CC5D
        rtl


        _A89A
        lda wJoy1Repeated
        bit #$0F00
        bne _A8A3
        bra _A8EB


        _A8A3
        lda #$0005
        jsl rlUnknown808FAD
        jsr rsUnknown88AB47
        lda $0772,b
        sta wR0
        lda $0774,b
        sta wR1
        jsl rlUnknown8591B2
        lda $0774,b
        tax
        lda aDeploymentTable._XTilePosition,x
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        sta wR11
        jsl rlUnknown88BFC3
        lda wR10
        bmi _A8DD
        sta wCursorXOffset,b
        lda wR11
        sta wCursorYOffset,b
        bra _A8EB


        _A8DD
        lda $0774,b
        jsl rlUnknown88B4DB
        lda #$0006
        sta wUnknown0007D8,b
        rtl


        _A8EB
        lda $0774,b
        tax
        lda aDeploymentTable._XTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wR0
        lda aDeploymentTable._YTilePosition,x
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wR1
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #$EE52
        lda #$0006
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        lda wJoy1New
        bit #$0080
        bne _A92C
        rtl


        _A92C
        lda #$0000
        sta wUnknown0007D8,b
        lda $0772,b
        sta wR0
        lda $0774,b
        sta wR1
        lda #$0004
        trb $0786,b
        lda $077C,b
        sta $0778,b
        lda $077E,b
        sta $077A,b
        lda $0772,b
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
        lda wUnknown000D79,b
        bit #$0800
        bne _A994
        jsl rlUnknown85921D
        jsl rlUnknown84DC1C
        lda #$000A
        jsl rlUnknown808FAD
        rtl


        _A994
        jsl rlUnknown85921D
        stz $087B,b
        lda #$0020
        tsb $0788,b
        jsl rlUnknown85EA64
        lda #(`procUnknown889396)<<8
        sta lR44+1
        lda #<>procUnknown889396
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 88/A9B4

      rsUnknown88A9B4 ; 88/A9B4

        .al
        .xl
        .autsiz
        .databank ?

        lda $0778,b
        beq _A9CB
        bpl _A9C3
        inc $0778,b
        lda #$0200
        bra _A9E2


        _A9C3
        dec $0778,b
        lda #$0100
        bra _A9E2


        _A9CB
        lda $077A,b
        beq _A9E6
        bpl _A9DA
        inc $077A,b
        lda #$0800
        bra _A9E2


        _A9DA
        dec $077A,b
        lda #$0400
        bra _A9E2


        _A9E2
        sta wMapScrollDirectionIdentifier,b
        rts


        _A9E6
        stz wUnknown00073A,b
        lda wMapScrollScriptOffset,b
        dec a
        dec a
        sta wMapScrollScriptOffset,b
        lda $077C,b
        sta $0778,b
        lda $077E,b
        sta $077A,b
        ldx $0772,b
        jsl rlDeployedUnitSetHidden
        lda #$0002
        sta wUnknown0007D8,b
        lda #$FFFF
        sta wMapScrollDirectionIdentifier,b
        jsl rlUnknown88C085
        lda #$0002
        sta $07DA,b
        lda #$0000
        rts

        .databank 0

        ; 88/AA1E

      rsUnknown88AA1E ; 88/AA1E

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollScriptOffset,b
        bmi _AA8A
        tax
        lda $0794,b,x
        sta wR0
        beq _AA8A
        cmp #$0001
        beq _AA3F
        cmp #$0002
        beq _AA4A
        cmp #$0003
        beq _AA55
        cmp #$0004
        beq _AA60

        _AA3F
        lda #$0018
        sta wUnknown0007E2,b
        lda #$0400
        bra _AA6B


        _AA4A
        lda #$0010
        sta wUnknown0007E2,b
        lda #$0800
        bra _AA6B


        _AA55
        lda #$0008
        sta wUnknown0007E2,b
        lda #$0100
        bra _AA6B


        _AA60
        lda #$0000
        sta wUnknown0007E2,b
        lda #$0200
        bra _AA6B


        _AA6B
        cmp wMapScrollDirectionIdentifier,b
        bne _AA7A
        sta wMapScrollDirectionIdentifier,b
        jsr rsUnknown88AB13
        lda #$0001
        rts


        _AA7A
        sta wMapScrollDirectionIdentifier,b
        stz $07DC,b
        stz $07DE,b
        jsr rsUnknown88AB13
        lda #$0001
        rts


        _AA8A
        lda #$0010
        sta wMapPixelScrollDistance,b
        jsl rlUnknown88C126
        lda #$0002
        sta $07DA,b
        stz wUnknown0007D8,b
        stz wMapScrollScriptOffset,b
        stz wUnknown00073A,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        sta $078C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        sta $078E,b
        ldx $0772,b
        jsl rlUnknown84C94C
        lda $07E0,b
        cmp #$0004
        beq _AAEF
        cmp #$0005
        beq _AAEF
        cmp #$0009
        beq _AAEF
        lda $086F,b
        bne _AAEB
        jsl rlUnknown85E85D
        lda #$0008
        tsb $0788,b

        _AAEB
        lda #$0000
        rts


        _AAEF
        jsl rlUnknown84D483
        bcc _AB00
        jsl rlUnknown84CAA9
        stz $07E0,b
        lda #$0000
        rts


        _AB00
        lda $07E0,b
        cmp #$0004
        beq _AB0C
        lda #$0000
        rts


        _AB0C
        stz $07E0,b
        lda #$0000
        rts

        .databank 0

        ; 88/AB13

      rsUnknown88AB13 ; 88/AB13

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapPixelScrollDistance,b
        clc
        adc #$0010
        sta wMapPixelScrollDistance,b
        dec x
        dec x
        stx wMapScrollScriptOffset,b
        bmi _AB2B
        lda $0794,b,x
        cmp wR0
        beq $88AB13

        _AB2B
        rts

        .databank 0

        ; 88/AB2C

    .endsection Unsorted88A81DSection


    .section Unsorted88AB2CSection

      .al
      .xl

      rsUnknown88AB2C ; 88/AB2C

        ; Found by tools/sweep.py: nothing in the build reaches this.
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
        sta wR10
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR11
        rts

        .databank 0

        ; 88/AB47

    .endsection Unsorted88AB2CSection


    .section Unsorted88AB47Section

      .al
      .xl

      rsUnknown88AB47 ; 88/AB47

        .al
        .xl
        .autsiz
        .databank ?

        ldx $0772,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown84F4F7
        cmp #$0000
        beq _AB61
        lda wR11
        cmp #$0003
        bcs _AB65

        _AB61
        jml _ABD4


        _AB65
        lda wJoy1Repeated
        bit #$0A00
        bne _AB82
        lda $0776,b
        clc
        adc #$0001
        cmp #$0400
        bcc _AB7B
        lda #$0000

        _AB7B
        sta $0776,b
        jml _AB95


        _AB82
        lda $0776,b
        sec
        sbc #$0001
        bpl _AB8E
        lda #$03FF

        _AB8E
        sta $0776,b
        jml _ABB6


        _AB95
        ldx $0776,b

        _AB98
        lda aTargetDistanceMap,x
        and #$00FF
        cmp #$00FF
        bne _ABAF
        inc x
        cpx #$0400
        bcc _AB98
        ldx #$0000
        bra _AB98


        _ABAF
        sta $0774,b
        stx $0776,b
        rts


        _ABB6
        ldx $0776,b

        _ABB9
        lda aTargetDistanceMap,x
        and #$00FF
        cmp #$00FF
        bne _ABCD
        dec x
        bpl _ABB9
        ldx #$03FF
        bra _ABB9


        _ABCD
        sta $0774,b
        stx $0776,b
        rts


        _ABD4
        lda wJoy1Repeated
        bit #$0A00
        bne _ABF1
        lda $0776,b
        clc
        adc #$0001
        cmp #$000C
        bcc _ABEA
        lda #$0000

        _ABEA
        sta $0776,b
        jml _AC2E


        _ABF1
        lda $0776,b
        sec
        sbc #$0001
        bpl _ABFD
        lda #$000B

        _ABFD
        sta $0776,b
        jml _AC04


        _AC04
        lda $0776,b
        asl a
        tax

        _AC09
        phx
        lda aUnknown88ACF1,x
        tax
        lda aTargetDistanceMap,x
        plx
        and #$00FF
        cmp #$00FF
        bne _AC25
        dec x
        dec x
        bpl _AC09
        ldx #$0016
        bra _AC09


        _AC25
        sta $0774,b
        txa
        lsr a
        sta $0776,b
        rts


        _AC2E
        lda $0776,b
        asl a
        tax

        _AC33
        phx
        lda aUnknown88ACF1,x
        tax
        lda aTargetDistanceMap,x
        plx
        and #$00FF
        cmp #$00FF
        bne _AC52
        inc x
        inc x
        cpx #$0018
        bcc _AC33
        ldx #$0000
        bra _AC33


        _AC52
        sta $0774,b
        txa
        lsr a
        sta $0776,b
        rts

        .databank 0

        ; 88/AC5B

    .endsection Unsorted88AB47Section


    .section Table88ACF1Section

      .al
      .xl

      aUnknown88ACF1 ; 88/ACF1

        ; Read by rsUnknown88AB47, which reads 12 words.

        .word $01D0, $01F0, $01F1, $0212, $0211, $0231, $0250, $0230
        .word $022F, $020E, $020F, $01EF

        ; 88/AD09

    .endsection Table88ACF1Section


    .section Unsorted88AD46Section

      .al
      .xl

      rlUnknown88AD46 ; 88/AD46

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta wUnknown0007D8,b
        lda #$0003
        sta $07DA,b
        stz $0776,b
        jsr rsUnknown88AB47
        lda $0778,b
        sta $077C,b
        lda $077A,b
        sta $077E,b
        lda $0772,b
        sta wR0
        lda $0774,b
        sta wR1
        jsl rlUnknown8591B2
        lda $0774,b
        tax
        lda aDeploymentTable._XTilePosition,x
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        sta wR11
        jsl rlUnknown88BFC3
        lda wR10
        bmi _AD94
        sta wCursorXOffset,b
        lda wR11
        sta wCursorYOffset,b
        bra _ADA1


        _AD94
        lda $0774,b
        jsl rlUnknown88B4DB
        lda #$0006
        sta wUnknown0007D8,b

        _ADA1
        rtl

        .databank 0

        ; 88/ADA2

    .endsection Unsorted88AD46Section


    .section Unsorted88ADA2Section

      .al
      .xl

      rlUnknown88ADA2 ; 88/ADA2

        .al
        .xl
        .autsiz
        .databank ?

        stz wUnknown0007D8,b
        rtl

        .databank 0

        ; 88/ADA6

    .endsection Unsorted88ADA2Section


    .section Unsorted88ADA6Section

      .al
      .xl

      rlUnknown88ADA6 ; 88/ADA6

        ; Found by tools/sweep.py: nothing in the build reaches this.
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
        sta $0778,b
        sta $077C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $077A,b
        sta $077E,b
        rtl

        .databank 0

        ; 88/ADC9

    .endsection Unsorted88ADA6Section


    .section Unsorted88ADC9Section

      .al
      .xl

      rlUnknown88ADC9 ; 88/ADC9

        .al
        .xl
        .autsiz
        .databank ?

        lda $0772,b
        jsl rlUnknown88B4DB
        lda #$0008
        sta wUnknown0007D8,b
        lda $07E0,b
        beq _ADE2
        lda #$0005
        sta $07E0,b
        rtl


        _ADE2
        lda #$0009
        sta $07E0,b
        rtl

        .databank 0

        ; 88/ADE9

    .endsection Unsorted88ADC9Section


    .section Unsorted88ADE9Section

      .al
      .xl

      rlUnknown88ADE9 ; 88/ADE9

        .al
        .xl
        .autsiz
        .databank ?

        lda $07E0,b
        bne _AE41

        _ADEE
        ldx $0772,b
        lda aDeploymentTable,x
        bit #$0010
        bne _AE1F
        lda $0778,b
        sta wR0
        lda $077A,b
        sta wR1
        ldx $0772,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz $07DA,b
        jsl rlUnknown84C94C
        lda $0772,b
        jsl rlUnknown88B4DB
        rtl


        _AE1A
        stz $07E0,b
        bra _ADEE


        _AE1F
        lda $0778,b
        sta wR0
        lda $077A,b
        sta wR1
        stz $07DA,b
        ldx $0772,b
        jsl rlUnknown84C94C
        lda $0772,b
        jsl rlUnknown88B4DB
        lda #$0007
        sta wUnknown0007D8,b
        rtl


        _AE41
        lda $07E0,b
        cmp #$0005
        beq _AE70
        lda $0D87,b
        bit #$0008
        bne _AE76
        jsl rlUnknown87BB27
        bcc _AE76
        lda $07E0,b
        cmp #$0002
        beq _AEB3
        cmp #$0003
        beq _AEC8
        cmp #$0004
        beq _AE1A
        cmp #$0009
        beq _AEB1
        bra _AE9C


        _AE70
        lda #$0001
        sta $07E0,b

        _AE76
        lda $0778,b
        sta wR0
        lda $077A,b
        sta wR1
        ldx $0772,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz $07DA,b
        jsl rlUnknown84C94C
        lda $0772,b
        jsl rlUnknown88B4DB
        lda #$0007
        sta wUnknown0007D8,b
        rtl


        _AE9C
        ldx $0772,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz $07DA,b
        ldx $0772,b
        jsl rlUnknown84CC5D
        stz $07E0,b
        rtl


        _AEB1
        bra _AEFE


        _AEB3
        ldx $0772,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz $07DA,b
        ldx $0772,b
        jsl rlUnknown84CFBF
        stz $07E0,b
        rtl


        _AEC8
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
        lda wEventLocationEntry,b
        sta $0580,b
        jsl rlDeployedUnitUnsetHiddenIfAlive
        stz $07DA,b
        ldx $0772,b
        jsl rlUnknown84CC5D
        stz $07E0,b
        rtl


        _AEFE
        ldx $0772,b
        stz $07DA,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        sta $0778,b
        sta $077C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        sta $077A,b
        sta $077E,b
        jsl rlUnknown84C94C
        stz $07E0,b
        lda $0772,b
        jsl rlUnknown88B4DB
        ldx $0772,b
        lda aDeploymentTable,x
        bit #$0010
        bne _AF45
        rtl


        _AF45
        lda #$0007
        sta wUnknown0007D8,b
        rtl

        .databank 0

        ; 88/AF4C

    .endsection Unsorted88ADE9Section


    .section Unsorted88AF4CSection

      .al
      .xl

      rsUnknown88AF4C ; 88/AF4C

        .al
        .autsiz
        .databank ?

        ; X = deployment offset

        stx $0772,b

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wUnknown00076C,b

        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wUnknown00076E,b

        lda #1
        sta $07DA,b
        stz $07DC,b
        stz $07DE,b

        jsl rlDeployedUnitSetHidden

        stz wUnknown0007E2,b
        jsl rlUnknown88C9A6
        rtl

        .databank 0

    .endsection Unsorted88AF4CSection


    .section Unsorted88AF7BSection

      .al
      .xl

      rlUnknown88AF7B ; 88/AF7B

        .al
        .autsiz
        .databank ?

        phx
        stz $07DA,b
        stz $07E0,b

        ldx $0772,b
        lda aDeploymentTable._UnitRAMPointer,x
        beq +

          sta $00089B
        
        +
        ldx $0772,b
        jsl rlDeployedUnitUnsetHiddenIfAlive

        ldx $0772,b
        lda aDeploymentTable._State,x
        bit #DeploymentStateCanto
        bne +

          lda bUnknown000E7B,b
          and #$00FF
          bit #$0041
          bne +

            lda $0772,b
            jsl rlUnknown88B4DB

        +
        plx
        rtl

        .databank 0

    .endsection Unsorted88AF7BSection


    .section Unsorted88B366Section

      .al
      .xl

      rlUnknown88B366 ; 88/B366

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        tsb $08AD,b
        lda #$0002
        tsb $08AD,b
        lda #$0004
        tsb $08AD,b
        lda #$0008
        tsb $08AD,b
        lda wSelectedUnitDataRAMPointer,b
        sta $08B2,b
        lda wSelectedUnitDataRAMPointer,b
        sta $08B4,b
        lda #$0003
        sta $08B8,b
        jsl rlUnknown88B3AF
        lda #$0002
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

        ; 88/B3AF

    .endsection Unsorted88B366Section


    .section Unsorted88B3AFSection

      .al
      .xl

      rlUnknown88B3AF ; 88/B3AF

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFFF
        sta wUnknown0007D8,b
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        rtl

        .databank 0

        ; 88/B3C2

    .endsection Unsorted88B3AFSection


    .section Unsorted88B3DFSection

      .al
      .xl

      rlUnknown88B3DF ; 88/B3DF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        lda wCursorXOffset,b
        sta wR10
        lda wCursorYOffset,b
        sta wR11
        jsl rlUnknown88C059
        lda wR10
        sta wR0
        lda wR11
        sta wR1
        jsl rlUnknown88BF37
        tax
        lda aMapData,x
        and #$03FF
        asl a
        asl a
        asl a
        tax
        lda $7F0000,x
        and #$DFFF
        sta wR0
        lda $7F0002,x
        and #$DFFF
        sta wR1
        lda $7F0004,x
        and #$DFFF
        sta wR2
        lda $7F0006,x
        and #$DFFF
        sta wR3
        plb
        .databank ?
        rtl

        .databank 0

        ; 88/B42C

    .endsection Unsorted88B3DFSection


    .section Unsorted88B42CSection

      .al
      .xl

      rlUnknown88B42C ; 88/B42C

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown88B4DB
        lda #$0005
        sta wUnknown0007D8,b
        lda $07E0,b
        cmp #$8002
        beq _B44F
        cmp #$8003
        beq _B456
        cmp #$8004
        beq _B45D
        lda #$0001
        sta $07E0,b
        rtl


        _B44F
        lda #$0002
        sta $07E0,b
        rtl


        _B456
        lda #$0003
        sta $07E0,b
        rtl


        _B45D
        lda #$0004
        sta $07E0,b
        lda #$0008
        sta wUnknown0007D8,b
        rtl

        .databank 0

        ; 88/B46A

    .endsection Unsorted88B42CSection


    .section Unsorted88B46ASection

      .al
      .xl

      rlUnknown88B46A ; 88/B46A

        .al
        .xl
        .autsiz
        .databank ?

        sta $0784,b
        lda bUnknown000E7B,b
        and #$00FF
        bit #$0041
        beq _B48D
        lda $0784,b
        sta $0871,b
        sta $0772,b
        lda #$0001
        sta $086F,b
        lda #$0002
        tsb bUnknown000E7B,b

        _B48D
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        ldx $0784,b
        lda aDeploymentTable._XTilePosition,x
        sec
        sbc $078C,b
        sta $0778,b
        lda aDeploymentTable._YTilePosition,x
        sec
        sbc $078E,b
        sta $077A,b
        lda #$0004
        sta wUnknown0007D8,b
        lda bUnknown000E7B,b
        and #$00FF
        bit #$0041
        bne _B4D4
        rtl


        _B4D4
        lda #$0001
        sta wUnknown0007D8,b
        rtl

        .databank 0

        ; 88/B4DB

    .endsection Unsorted88B46ASection


    .section Unsorted88B4DBSection

      .al
      .xl

      rlUnknown88B4DB ; 88/B4DB

        .al
        .autsiz
        .databank ?

        sta $0784,b

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b

        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b

        ldx $0784,b
        lda aDeploymentTable._XTilePosition,x
        sec
        sbc $078C,b
        sta $0778,b

        lda aDeploymentTable._YTilePosition,x
        sec
        sbc $078E,b
        sta $077A,b

        lda #$0004
        sta wUnknown0007D8,b
        rtl

        .databank 0

        ; 88/B51A

    .endsection Unsorted88B4DBSection


    .section Unsorted88B64FSection

      .al
      .xl

      rsUnknown88B64F ; 88/B64F

        .al
        .autsiz
        .databank ?

        lda $0778,b
        beq ++
        bpl +

          inc $0778,b
          lda #$0200
          bra _End
          
            +
            dec $0778,b
            lda #$0100
            bra _End

        +
        lda $077A,b
        beq _B681
        bpl +

          inc $077A,b
          lda #$0800
          bra _End

        +
        dec $077A,b
        lda #$0400
        bra _End
        
        _End
        sta wMapScrollDirectionIdentifier,b
        rts

        _B681
        lda wUnknown0007D8,b
        cmp #5
        beq _B6A6

          cmp #6
          beq _B6B6

            cmp #7
            beq _B6D4

              stz wUnknown00073A,b
              stz wMapScrollScriptOffset,b
              stz wUnknown0007D8,b
              lda #$0004
              trb $0788,b
              lda #0
              rts
        
        _B6A6
        stz wUnknown00073A,b
        stz wMapScrollScriptOffset,b
        stz wUnknown0007D8,b
        jsr rsUnknown88B701
        lda #0
        rts

        _B6B6
        stz wUnknown00073A,b
        stz wMapScrollScriptOffset,b
        lda #3
        sta wUnknown0007D8,b
        lda $0772,b
        sta $00
        lda $0774,b
        sta $02
        jsl rlUnknown8591B2
        lda #0
        rts

        _B6D4
        stz wUnknown00073A,b
        stz wMapScrollScriptOffset,b
        stz wUnknown0007D8,b
        lda $0D87,b
        bit #$0008
        bne +

          jsr rsUnknown88B701
          lda #0
          rts

        +
        ldx $0772,b
        jsl rlUnknown84D4A2
        lda #$0008
        tsb $0788,b
        lda #0
        rts

        .databank 0

        ; 88/B6FD

    .endsection Unsorted88B64FSection


    .section Unsorted88B6FDSection

      .al
      .xl

      rlUnknown88B6FD ; 88/B6FD

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown88B701
        rtl

        .databank 0

        ; 88/B701

      rsUnknown88B701 ; 88/B701

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wUnknown00076C,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        sta $0778,b
        sta $077C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wUnknown00076E,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        sta $077A,b
        sta $077E,b
        ldx #$0000

        _B730
        lda aDeploymentTable,x
        beq _B799
        inc $078A,b
        lda aDeploymentTable,x
        bit #$0008
        bne _B799
        bit #$2000
        bne _B799
        bit #$0080
        beq _B799
        lda aDeploymentTable._XTilePosition,x
        cmp wR0
        bne _B799
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        cmp wR1
        bne _B799
        sta wR11
        inc wUnknown000770,b
        lda #$0002
        tsb $0788,b
        jsl rlUnknown85EA64
        lda #$0001
        sta $07DA,b
        stz $07DC,b
        stz $07DE,b
        stx $0772,b
        jsl rlDeployedUnitSetHidden
        stz wUnknown0007E2,b
        jsl rlUnknown88C9A6
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown87B541
        bcs _B7A9

        _B794
        jsr rsUnknown88B873
        bra _B7A4


        _B799
        inc x
        inc x
        lda $078A,b
        cmp @l wDeployedUnitsCount
        bcc _B730

        _B7A4
        stz $078A,b
        clc
        rts


        _B7A9
        lda bUnknown000E7B,b
        and #$00FF
        bit #$0041
        bne _B794
        ldx $0772,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        cmp wActiveFactionSlot,b
        bne _B794
        lda $0778,b
        sta wR0
        lda $077A,b
        sta wR1
        ldx $0772,b
        jsl rlUnknown84C94C
        lda #$0002
        trb $0788,b
        stz wUnknown000770,b
        lda #$0002
        sta $07DA,b
        stz wUnknown0007D8,b
        stz wMapScrollScriptOffset,b
        stz wUnknown00073A,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta $0780,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta $0782,b
        jsl rlUnknown85E85D
        lda #$0008
        tsb $0788,b
        stz $078A,b
        sec
        rts

        .databank 0

        ; 88/B813

      rlUnknown88B813 ; 88/B813

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        bit #$000F
        bne _B869
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        bit #$000F
        bne _B869
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        ldx #$0000

        _B83A
        lda aDeploymentTable,x
        beq _B85E
        inc $078A,b
        lda aDeploymentTable,x
        bit #$0080
        beq _B85E
        lda aDeploymentTable._XTilePosition,x
        cmp wR0
        bne _B85E
        lda aDeploymentTable._YTilePosition,x
        cmp wR1
        bne _B85E
        bra _B86E


        _B85E
        inc x
        inc x
        lda $078A,b
        cmp @l wDeployedUnitsCount
        bcc _B83A

        _B869
        stz $078A,b
        clc
        rtl


        _B86E
        stz $078A,b
        sec
        rtl

        .databank 0

        ; 88/B873

      rsUnknown88B873 ; 88/B873

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$11
        sta bBufferTM
        lda #$04
        sta bBufferTS
        lda #$02
        sta bBufferCGWSEL
        lda #$41
        sta bBufferCGADSUB
        rep #$20
        jsr rsUnknown88B88B
        rts

        .databank 0

        ; 88/B88B

      rsUnknown88B88B ; 88/B88B

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
        sta $078C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        lda $078C,b
        sec
        sbc #$0020
        sta $071C,b
        clc
        adc #$0040
        sta $0720,b
        lda $078E,b
        sec
        sbc #$0020
        sta $071E,b
        clc
        adc #$0040
        sta $0722,b
        lda $071C,b
        bpl _B8D1
        stz $071C,b

        _B8D1
        lda $071E,b
        bpl _B8D9
        stz $071E,b

        _B8D9
        lda bUnknown000E7B,b
        and #$00FF
        bit #$0041
        bne _B8E8
        jsl rlUnknown8884A6

        _B8E8
        rts

        .databank 0

        ; 88/B8E9

      rsUnknown88B8E9 ; 88/B8E9

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta $0780,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078C,b
        sta wR0
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta $0782,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta $078E,b
        sta wR1
        jsl rlUnknown88BF37
        tax
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        lda $078E,b
        cmp $071E,b
        bcc _B95E
        cmp $0722,b
        bcs _B95E
        lda $078C,b
        cmp $071C,b
        bcc _B95E
        cmp $0720,b
        bcs _B95E
        jsr rsUnknown888D23
        lda aMovementMap,x
        bit #$0080
        bne _B95E
        and #$007F
        beq _B95E
        sta $0792,b
        jsr rsUnknown88B960
        bmi _B95E
        jsr rsUnknown88BBD3
        jsr rsUnknown88B992
        clc
        rts


        _B95E
        sec
        rts

        .databank 0

        ; 88/B960

      rsUnknown88B960 ; 88/B960

        .al
        .xl
        .autsiz
        .databank ?

        ldx #$008E

        _B963
        cpx $0772,b
        beq _B98A
        lda aDeploymentTable,x
        beq _B98A
        bit #$0080
        beq _B98A
        lda aDeploymentTable._XTilePosition,x
        cmp $078C,b
        bne _B98A
        lda aDeploymentTable._YTilePosition,x
        cmp $078E,b
        bne _B98A
        lda #$FFFF
        bra _B991


        _B98A
        dec x
        dec x
        bpl _B963
        lda #$0000

        _B991
        rts

        .databank 0

        ; 88/B992

      rsUnknown88B992 ; 88/B992

        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0001
        beq _B99D
        jml _BAB8


        _B99D
        ldx #$0040

        _B9A0
        stz $0794,b,x
        dec x
        dec x
        bpl _B9A0
        stz wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5
        ldy #$0000

        _B9B7
        lda wR4
        sta wR2
        lda wR5
        sta wR3
        lda wR2
        sta $078C,b
        lda wR3
        sec
        sbc #$0001
        sta $078E,b
        jsr rsUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _B9F4
        beq _B9F4
        sta $0792,b
        lda #$0001
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _B9F4
        lda wR2
        sta $078C,b
        lda wR3
        clc
        adc #$0001
        sta $078E,b
        jsr rsUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BA29
        beq _BA29
        sta $0792,b
        lda #$0002
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _BA29
        lda wR2
        sec
        sbc #$0001
        sta $078C,b
        lda wR3
        sta $078E,b
        jsr rsUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BA5E
        beq _BA5E
        sta $0792,b
        lda #$0003
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _BA5E
        lda wR2
        clc
        adc #$0001
        sta $078C,b
        lda wR3
        sta $078E,b
        jsr rsUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BA9C
        beq _BA9C
        sta $0792,b
        lda #$0004
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _BA93
        inc y
        inc y
        stz wMapScrollScriptOffset,b
        jml _B9B7


        _BA9C
        lda wMapScrollScriptOffset,b
        bne _BA93
        sty $07D6,b
        stz wMapScrollScriptOffset,b
        sty wMapScrollScriptOffset,b
        lda $0772,b
        jsl rlUnknown88B4DB
        lda #$0001
        sta wUnknown0007D8,b
        rts


        _BAB8
        ldx #$0040

        _BABB
        stz $0794,b,x
        dec x
        dec x
        bpl _BABB
        stz wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5
        ldy #$0000

        _BAD2
        lda wR4
        sta wR2
        lda wR5
        sta wR3
        lda wR2
        sec
        sbc #$0001
        sta $078C,b
        lda wR3
        sta $078E,b
        jsr rsUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BB0F
        beq _BB0F
        sta $0792,b
        lda #$0003
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _BB0F
        lda wR2
        clc
        adc #$0001
        sta $078C,b
        lda wR3
        sta $078E,b
        jsr rsUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BB44
        beq _BB44
        sta $0792,b
        lda #$0004
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _BB44
        lda wR2
        sta $078C,b
        lda wR3
        sec
        sbc #$0001
        sta $078E,b
        jsr rsUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BB79
        beq _BB79
        sta $0792,b
        lda #$0001
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _BB79
        lda wR2
        sta $078C,b
        lda wR3
        clc
        adc #$0001
        sta $078E,b
        jsr rsUnknown888D23
        lda aMovementMap,x
        and #$007F
        cmp $0792,b
        bcc _BBB7
        beq _BBB7
        sta $0792,b
        lda #$0002
        sta $0794,b,y
        inc wMapScrollScriptOffset,b
        lda $078C,b
        sta wR4
        lda $078E,b
        sta wR5

        _BBAE
        inc y
        inc y
        stz wMapScrollScriptOffset,b
        jml _BAD2


        _BBB7
        lda wMapScrollScriptOffset,b
        bne _BBAE
        sty $07D6,b
        stz wMapScrollScriptOffset,b
        sty wMapScrollScriptOffset,b
        lda $0772,b
        jsl rlUnknown88B4DB
        lda #$0001
        sta wUnknown0007D8,b
        rts

        .databank 0

        ; 88/BBD3

      rsUnknown88BBD3 ; 88/BBD3

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$15
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        rep #$20
        stz wBufferBG3HOFS
        stz wBufferBG3VOFS
        ldx #$07FE
        lda #$00FF

        _BBF1
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bpl _BBF1
        jsl rlUnknown878459
        jsl rlUnknown88A4FC
        stz wUnknown000770,b
        rts

        .databank 0

        ; 88/BC05

    .endsection Unsorted88B6FDSection


    .section Unsorted88BC05Section

      .al
      .xl

      rlUnknown88BC05 ; 88/BC05

        .al
        .autsiz
        .databank ?

        lda #$0001
        trb $0764,b

        lda wMapScrollDirectionIdentifier,b
        cmp #$0200
        beq _0200

        cmp #$0100
        beq _0100

        cmp #$0800
        beq _0800

        cmp #$0400
        beq _0400

        cmp #$0A00
        beq _0A00

        cmp #$0600
        beq _0600

        cmp #$0900
        beq _0900

        cmp #$0500
        beq _0500

        rtl

        _0200
        jsr rsUnknown88BC63
        rtl
        
        _0100
        jsr rsUnknown88BD09
        rtl
        
        _0800
        jsr rsUnknown88BDA1
        rtl
        
        _0400
        jsr rsUnknown88BE57
        rtl
        
        _0A00
        jsr rsUnknown88BC63
        jsr rsUnknown88BDA1
        rtl
        
        _0600
        jsr rsUnknown88BC63
        jsr rsUnknown88BE57
        rtl
        
        _0900
        jsr rsUnknown88BD09
        jsr rsUnknown88BDA1
        rtl
        
        _0500
        jsr rsUnknown88BD09
        jsr rsUnknown88BE57
        rtl

        .databank 0

      rsUnknown88BC63 ; 88/BC63

        .al
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        cmp wMapMinXScroll,b
        beq +

        lda wCursorXOffset,b
        sec
        sbc wMapScrollSpeed,b
        cmp #$0030
        bcc ++

        sta wCursorXOffset,b
        lda #$0001
        tsb $0764,b
        rts
        
        +
        lda wCursorXOffset,b
        sec
        sbc wMapScrollSpeed,b
        cmp #$0010
        bcc _BCF4

        sta wCursorXOffset,b
        lda #$0001
        tsb $0764,b
        rts
        
        +
        lda wMapScrollXPixels,b
        sec
        sbc wMapScrollSpeed,b
        sec
        sbc #1
        cmp wMapMinXScroll,b
        bmi +
        bcs ++
        
        +
        clc
        adc #1
        sta $00

        lda wMapMinXScroll,b
        sec
        sbc $00
        sta $00

        lda wCursorXOffset,b
        sec
        sbc #$0030
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b

        lda #$0030
        sec
        sbc $00
        sta wCursorXOffset,b
        bra ++
        
        +
        lda wCursorXOffset,b
        sec
        sbc #$0030
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b

        lda #$0030
        sta wCursorXOffset,b
        
        +
        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        lda #$0001
        tsb $0764,b
        rts

        _BCF4
        lda wCursorXOffset,b
        sec
        sbc #$0010
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$0010
        sta wCursorXOffset,b
        rts

        .databank 0

      rsUnknown88BD09 ; 88/BD09

        .al
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        cmp wMapMaxXScroll,b
        bcs +

          lda wCursorXOffset,b
          clc
          adc wMapScrollSpeed,b
          cmp #$00C1
          bcs ++

            sta wCursorXOffset,b
            lda #$0001
            tsb $0764,b
            rts

        +
        lda wCursorXOffset,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00E1
        bcs _BD8C

          sta wCursorXOffset,b
          lda #$0001
          tsb $0764,b
          rts

        +
        lda wMapScrollXPixels,b
        clc
        adc wMapScrollSpeed,b
        cmp wMapMaxXScroll,b
        bcc +

          sec
          sbc wMapMaxXScroll,b
          sta $00
          lda #$00C0
          sec
          sbc wCursorXOffset,b
          clc
          adc wMapScrollCurrentPixelDistance,b
          sta wMapScrollCurrentPixelDistance,b

          lda $00
          clc
          adc #$00C0
          sta wCursorXOffset,b
          bra ++
        
        +
        lda #$00C0
        sec
        sbc wCursorXOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$00C0
        sta wCursorXOffset,b
        
        +
        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        lda #$0001
        tsb $0764,b
        rts

        _BD8C
        lda #$00E0
        sec
        sbc wCursorXOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$00E0
        sta wCursorXOffset,b
        rts

        .databank 0

        ; 88/BDA1

    .endsection Unsorted88BC05Section


    .section Unsorted88BDA1Section

      .al
      .xl

      rsUnknown88BDA1 ; 88/BDA1

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollYPixels,b
        cmp wMapMinYScroll,b
        beq _BDBF
        lda wCursorYOffset,b
        sec
        sbc wMapScrollSpeed,b
        cmp #$0030
        bcc _BDE5
        sta wCursorYOffset,b
        lda #$0001
        tsb $0764,b
        rts


        _BDBF
        lda wCursorYOffset,b
        sec
        sbc wMapScrollSpeed,b
        cmp #$0010
        bcc _BE42
        sta wCursorYOffset,b
        lda #$0001
        tsb $0764,b
        rts

        .byte $A9, $01, $00, $8D, $3A, $07, $8D, $3E, $07, $A9, $01, $00, $0C, $64, $07, $60


        _BDE5
        lda wMapScrollYPixels,b
        sec
        sbc wMapScrollSpeed,b
        sec
        sbc #$0001
        cmp wMapMinYScroll,b
        bmi _BDF7
        bcs _BE1E

        _BDF7
        clc
        adc #$0001
        sta wR0
        lda wMapMinYScroll,b
        sec
        sbc wR0
        sta wR0
        lda wCursorYOffset,b
        sec
        sbc #$0030
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$0030
        sec
        sbc wR0
        sta wCursorYOffset,b
        bra _BE32


        _BE1E
        lda wCursorYOffset,b
        sec
        sbc #$0030
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$0030
        sta wCursorYOffset,b

        _BE32
        lda #$0001
        sta wUnknown00073A,b
        sta wMapEnableYScrollFlag,b
        lda #$0001
        tsb $0764,b
        rts


        _BE42
        lda wCursorYOffset,b
        sec
        sbc #$0010
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$0010
        sta wCursorYOffset,b
        rts

        .databank 0

        ; 88/BE57

      rsUnknown88BE57 ; 88/BE57

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollYPixels,b
        cmp wMapMaxYScroll,b
        bcs _BE75
        lda wCursorYOffset,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00A1
        bcs _BE8B
        sta wCursorYOffset,b
        lda #$0001
        tsb $0764,b
        rts


        _BE75
        lda wCursorYOffset,b
        clc
        adc wMapScrollSpeed,b
        cmp #$00C1
        bcs _BEDA
        sta wCursorYOffset,b
        lda #$0001
        tsb $0764,b
        rts


        _BE8B
        lda wMapScrollYPixels,b
        clc
        adc wMapScrollSpeed,b
        cmp wMapMaxYScroll,b
        bcc _BEB6
        sec
        sbc wMapMaxYScroll,b
        sta wR0
        lda #$00A0
        sec
        sbc wCursorYOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda wR0
        clc
        adc #$00A0
        sta wCursorYOffset,b
        bra _BECA


        _BEB6
        lda #$00A0
        sec
        sbc wCursorYOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$00A0
        sta wCursorYOffset,b

        _BECA
        lda #$0001
        sta wUnknown00073A,b
        sta wMapEnableYScrollFlag,b
        lda #$0001
        tsb $0764,b
        rts


        _BEDA
        lda #$00C0
        sec
        sbc wCursorYOffset,b
        clc
        adc wMapScrollCurrentPixelDistance,b
        sta wMapScrollCurrentPixelDistance,b
        lda #$00C0
        sta wCursorYOffset,b
        rts

        .databank 0

        ; 88/BEEF

      rsUnknown88BEEF ; 88/BEEF

        .al
        .xl
        .autsiz
        .databank ?

        lda $0764,b
        bit #$0001
        beq _BEFE
        lda #$0005
        jsl rlUnknown808FAD

        _BEFE
        rts

        .databank 0

        ; 88/BEFF

    .endsection Unsorted88BDA1Section


    .section Unsorted88BF37Section

      .al
      .xl

      rlUnknown88BF37 ; 88/BF37

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        lda wUnknown00075C,b
        cmp #$0004
        beq _BF56
        cmp #$0008
        beq _BF48

        _BF48
        lda wR1
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR3
        bra _BF63


        _BF56
        lda wR1
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR3
        bra _BF63


        _BF63
        lda wR0
        asl a
        clc
        adc wR3
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/BF6C

    .endsection Unsorted88BF37Section


    .section Unsorted88BF6CSection

      .al
      .xl

      rlUnknown88BF6C ; 88/BF6C

        .al
        .xl
        .autsiz
        .databank ?

        lda wR10
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        bmi _BF8F
        lsr a
        lsr a
        lsr a
        sta wR10
        lda wR11
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        bmi _BF8F
        lsr a
        lsr a
        lsr a
        sta wR11
        rtl


        _BF8F
        lda #$FFFF
        sta wR10
        sta wR11
        rtl

        .databank 0

        ; 88/BF97

    .endsection Unsorted88BF6CSection


    .section Unsorted88BF97Section

      .al
      .xl

      rlUnknown88BF97 ; 88/BF97

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        sec
        sbc wMapScrollXPixels,b
        sta wR10
        cmp #$00C8
        bcs _BFC1
        sec
        sbc #$0030
        bmi _BFC1
        lda wCursorYOffset,b
        sec
        sbc wMapScrollYPixels,b
        sta wR11
        cmp #$00A8
        bcs _BFC1
        sec
        sbc #$0028
        bmi _BFC1
        clc
        rtl


        _BFC1
        sec
        rtl

        .databank 0

        ; 88/BFC3

      rlUnknown88BFC3 ; 88/BFC3

        .al
        .xl
        .autsiz
        .databank ?

        lda wR10
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wR10
        cmp #$00C8
        bcs _BFF2
        sec
        sbc #$0030
        bmi _BFF2
        lda wR11
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wR11
        cmp #$00A8
        bcs _BFF2
        sec
        sbc #$0028
        bmi _BFF2
        rtl


        _BFF2
        lda #$FFFF
        sta wR10
        sta wR11
        rtl

        .databank 0

        ; 88/BFFA

    .endsection Unsorted88BF97Section


    .section Unsorted88BFFASection

      .al
      .xl

      rlUnknown88BFFA ; 88/BFFA

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wR10
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollXPixels,b
        sta wR10
        cmp #$00C8
        bcs _C03B
        sec
        sbc #$0030
        bmi _C031

        _C011
        lda wR11
        asl a
        asl a
        asl a
        asl a
        sec
        sbc wMapScrollYPixels,b
        sta wR11
        cmp #$00A8
        bcs _C04F
        sec
        sbc #$0028
        bmi _C045

        _C028
        rtl


        _C029
        lda #$FFFF
        sta wR10
        sta wR11
        rtl


        _C031
        lda wMapScrollXPixels,b
        cmp wMapMinXScroll,b
        beq _C011
        bra _C029


        _C03B
        lda wMapScrollXPixels,b
        cmp wMapMaxXScroll,b
        beq _C011
        bra _C029


        _C045
        lda wMapScrollYPixels,b
        cmp wMapMinYScroll,b
        beq _C028
        bra _C029


        _C04F
        lda wMapScrollYPixels,b
        cmp wMapMaxYScroll,b
        beq _C028
        bra _C029

        .databank 0

        ; 88/C059

    .endsection Unsorted88BFFASection


    .section Unsorted88C072Section

      .al
      .xl

      rlUnknown88C072 ; 88/C072

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wR10
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wR11
        rtl

        .databank 0

        ; 88/C085

    .endsection Unsorted88C072Section


    .section Unsorted88C085Section

      .al
      .xl

      rlUnknown88C085 ; 88/C085

        .al
        .xl
        .autsiz
        .databank ?

        ldx $0772,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        jsl rlGetMapSpriteMovementSound
        sep #$20
        sta $04CA,b
        stz $04D0,b
        lda wCursorXOffset,b
        sta $04CB,b
        rep #$20
        jsl rlUnknown88C0D5
        sep #$20
        lda wR0
        sta $04CC,b
        rep #$20
        rtl

        .databank 0

        ; 88/C0B3

      rlUnknown88C0B3 ; 88/C0B3

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlUnknown88C0D5
        sep #$20
        lda wCursorXOffset,b
        sta $04CB,b
        lda wR0
        sta $04CC,b
        rep #$20
        ldx #$0000
        jsl rlUnknown809933
        ldx #$0003
        jsl rlUnknown809933
        rtl

        .databank 0

        ; 88/C0D5

      rlUnknown88C0D5 ; 88/C0D5

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetClassWeakness
        bit #$0002
        bne _C11B
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
        jsl rlUnknown88BF37
        tax
        lda aMapData,x
        and #$03FF
        tax
        lda aTerrainTileset,x
        and #$00FF
        cmp #$0005
        beq _C120
        cmp #$0006
        beq _C120
        cmp #$0010
        beq _C120

        _C11B
        lda #$0000
        bra _C123


        _C120
        lda #$0020

        _C123
        sta wR0
        rtl

        .databank 0

        ; 88/C126

      rlUnknown88C126 ; 88/C126

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        lda #$10
        sta $04CA,b
        rep #$20
        ldx #$0000
        jsl rlUnknown809933
        ldx #$0003
        jsl rlUnknown809933
        rtl

        .databank 0

        ; 88/C13E

    .endsection Unsorted88C085Section


    .section Unsorted88C1BFSection

      .al
      .xl

      rsUnknown88C1BF ; 88/C1BF

        .al
        .xl
        .autsiz
        .databank ?

        lda wJoy1Input
        cmp #$0030
        bne _C1D0
        lda #$0000
        jsl rlGetFactionSlotLocationID
        sta $087B,b

        _C1D0
        lda $087B,b
        jsl rlGetLocationEventDataEntry
        bcs _C247
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeCastle
        bne _C24E
        jsl rlGetEventLocationEntryEffectiveXCoordinate
        asl a
        asl a
        asl a
        asl a
        sta $078C,b
        sec
        sbc #$0080
        bpl _C1F8
        lda #$0000
        bra _C200


        _C1F8
        cmp wMapMaxXScroll,b
        bcc _C200
        lda wMapMaxXScroll,b

        _C200
        sta wMapScrollXPixels,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        asl a
        asl a
        asl a
        asl a
        sta $078E,b
        sec
        sbc #$0080
        bpl _C219
        lda #$0000
        bra _C221


        _C219
        cmp wMapMaxYScroll,b
        bcc _C221
        lda wMapMaxYScroll,b

        _C221
        sta wMapScrollYPixels,b
        lda $078C,b
        sec
        sbc wMapScrollXPixels,b
        sta wCursorXOffset,b
        lda $078E,b
        sec
        sbc wMapScrollYPixels,b
        sta wCursorYOffset,b
        jsl rlUnknown888410
        inc $087B,b
        lda #$8000
        tsb $0788,b
        bra _C255


        _C247
        stz $087B,b
        jml _C1D0


        _C24E
        inc $087B,b
        jml _C1D0


        _C255
        lda #$0026
        jsl rlUnknown80900D
        rts

        .databank 0

        ; 88/C25D

    .endsection Unsorted88C1BFSection


    .section Unsorted88C25DSection

      .al
      .xl

      rlUnknown88C25D ; 88/C25D

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        jsl rlGetEventLocationEntryEffectiveXCoordinate
        asl a
        asl a
        asl a
        asl a
        sta $078C,b
        sec
        sbc #$0080
        bpl _C273
        lda #$0000
        bra _C27B


        _C273
        cmp wMapMaxXScroll,b
        bcc _C27B
        lda wMapMaxXScroll,b

        _C27B
        sta wMapScrollXPixels,b
        sta wMapXOffset,b
        jsl rlGetEventLocationEntryEffectiveYCoordinate
        asl a
        asl a
        asl a
        asl a
        sta $078E,b
        sec
        sbc #$0080
        bpl _C297
        lda #$0000
        bra _C29F


        _C297
        cmp wMapMaxYScroll,b
        bcc _C29F
        lda wMapMaxYScroll,b

        _C29F
        sta wMapScrollYPixels,b
        sta wMapYOffset,b
        lda $078C,b
        sec
        sbc wMapScrollXPixels,b
        sta wCursorXOffset,b
        lda $078E,b
        sec
        sbc wMapScrollYPixels,b
        sta wCursorYOffset,b
        rtl

        .databank 0

        ; 88/C2BA

    .endsection Unsorted88C25DSection


    .section Unsorted88C2BASection

      .al
      .xl

      rlUnknown88C2BA ; 88/C2BA

        .al
        .xl
        .autsiz
        .databank ?

        php
        phb
        lda #$0000
        sta wR2
        sta wR3
        lda #$0004
        sta wMapScrollSpeed,b
        lda $7F4BF5
        cmp wMapScrollXPixels,b
        beq _C2E2
        bcs _C2DB
        lda #$0001
        sta wR2
        bra _C2E2


        _C2DB
        lda #$FFFF
        sta wR2
        bra _C2E2


        _C2E2
        lda $7F4BF7
        cmp wMapScrollYPixels,b
        beq _C2FB
        bcs _C2F4
        lda #$0001
        sta wR3
        bra _C2FB


        _C2F4
        lda #$FFFF
        sta wR3
        bra _C2FB


        _C2FB
        lda wR2
        bne _C305
        lda wR3
        beq _C34D
        bra _C309


        _C305
        bpl _C30D
        bra _C327


        _C309
        bpl _C341
        bra _C347


        _C30D
        lda wR3
        beq _C315
        bpl _C31B
        bra _C321


        _C315
        jsl rlUnknown8885EF
        bra _C351


        _C31B
        jsl rlUnknown88860B
        bra _C351


        _C321
        jsl rlUnknown88861C
        bra _C351


        _C327
        lda wR3
        beq _C32F
        bpl _C335
        bra _C33B


        _C32F
        jsl rlUnknown8885FD
        bra _C351


        _C335
        jsl rlUnknown88862D
        bra _C351


        _C33B
        jsl rlUnknown88863E
        bra _C351


        _C341
        jsl rlUnknown8885D3
        bra _C351


        _C347
        jsl rlUnknown8885E1
        bra _C351


        _C34D
        plb
        .databank ?
        plp
        sec
        rtl


        _C351
        plb
        .databank ?
        plp
        clc
        rtl

        .databank 0

        ; 88/C355

    .endsection Unsorted88C2BASection


    .section Unsorted88C355Section

      .al
      .xl

      rlUnknown88C355 ; 88/C355

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        sta wR10
        lda wCursorYOffset,b
        sta wR11
        jsl rlUnknown88C059
        jsl rlUnknown88BFC3
        lda wR10
        cmp #$FFFF
        beq _C394
        lda $7F4BF9
        cmp wMapScrollXPixels,b
        bne _C382
        lda $7F4BFB
        cmp wMapScrollYPixels,b
        bne _C382
        clc
        rtl


        _C382
        lda $7F4BF9
        sta $7F4BF5
        lda $7F4BFB
        sta $7F4BF7
        sec
        rtl


        _C394
        lda wCursorXOffset,b
        clc
        adc $7F4BF9
        sta $078C,b
        sec
        sbc #$0080
        bpl _C3AA
        lda #$0000
        bra _C3B2


        _C3AA
        cmp wMapMaxXScroll,b
        bcc _C3B2
        lda wMapMaxXScroll,b

        _C3B2
        sta $7F4BF5
        lda wCursorYOffset,b
        clc
        adc $7F4BFB
        sta $078E,b
        sec
        sbc #$0080
        bpl _C3CC
        lda #$0000
        bra _C3D4


        _C3CC
        cmp wMapMaxYScroll,b
        bcc _C3D4
        lda wMapMaxYScroll,b

        _C3D4
        sta $7F4BF7
        lda $078C,b
        sec
        sbc $7F4BF5
        sta wCursorXOffset,b
        lda $078E,b
        sec
        sbc $7F4BF7
        sta wCursorYOffset,b
        sec
        rtl

        .databank 0

        ; 88/C3F0

    .endsection Unsorted88C355Section


    .section Unsorted88C4D9Section

      .al
      .xl

      rlUnknown88C4D9 ; 88/C4D9

        .al
        .xl
        .autsiz
        .databank ?

        ; Reached with jml from rlUnknown88A136. Steps through states 0-4 in
        ; wUnknown0007D8 and sets up the map scroll distance and speed, then
        ; draws a sprite at the cursor. What the states mean is not known yet.

        lda wUnknown000766,b
        beq _C4E2
        jml _C61E


        _C4E2
        lda wUnknown0007D8,b
        beq _C4FF
        cmp #$0001
        beq _C507
        cmp #$0002
        beq _C53B
        cmp #$0003
        beq _C503
        cmp #$0004
        bne _C4FF
        jml _C5D2


        _C4FF
        jml _C658


        _C503
        jml _C5AA


        _C507
        lda #$0010
        sta wMapPixelScrollDistance,b
        jsr rsUnknown88B64F
        beq _C51C
        lda #$0008
        sta wMapScrollSpeed,b
        jml _C60C


        _C51C
        lda bUnknown000E7B,b
        and #$00FF
        bit #$0002
        bne _C52E
        jsr rsUnknown88C67D
        jml _C658


        _C52E
        lda #$0000
        sta wUnknown0007D8,b
        sta $086F,b
        jml _C658


        _C53B
        jsl rlUnknown88C0B3
        stz wMapPixelScrollDistance,b
        jsr rsUnknown88AA1E
        beq _C564
        jsl rlUnknown87BF1B
        cmp #$0000
        bne _C55A
        lda #$0002
        sta wMapScrollSpeed,b
        jml _C60C


        _C55A
        lda #$0004
        sta wMapScrollSpeed,b
        jml _C60C


        _C564
        lda $0873,b
        cmp #$FFFF
        beq _C592
        jsl rlUnknown88B4DB
        lda #$0003
        sta wUnknown0007D8,b
        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wUnknown00076C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wUnknown00076E,b
        lda #$0001
        sta $07DA,b
        bra _C5AA


        _C592
        lda #$0000
        sta wUnknown0007D8,b
        sta $086F,b
        jsl rlUnknown88AF7B
        lda $0879,b
        jsl rlUnknown86B307
        jml _C658


        _C5AA
        lda #$0010
        sta wMapPixelScrollDistance,b
        jsr rsUnknown88B64F
        beq _C5C2
        lda #$0004
        lda #$0008
        sta wMapScrollSpeed,b
        jml _C60C


        _C5C2
        lda #$0018
        sta wMapScrollScriptOffset,b
        lda #$0004
        sta wUnknown0007D8,b
        jml _C658


        _C5D2
        lda wMapScrollScriptOffset,b
        sec
        sbc #$0001
        sta wMapScrollScriptOffset,b
        bmi _C5E0
        bra _C659


        _C5E0
        lda #$0000
        sta wUnknown0007D8,b
        sta $086F,b
        jsl rlUnknown88AF7B
        lda wMapScrollXPixels,b
        sta wMapXOffset,b
        lda wMapScrollYPixels,b
        sta wMapYOffset,b
        lda $0871,b
        sta wR0
        lda $0873,b
        sta wR1
        lda $0879,b
        jsl rlUnknown86B307
        bra _C659


        _C60C
        stz wMapScrollCurrentPixelDistance,b
        lda #$0001
        sta wUnknown000766,b
        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b

        _C61E
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp wMapPixelScrollDistance,b
        bcc _C648
        sec
        sbc wMapPixelScrollDistance,b
        sta wR0
        lda wMapScrollSpeed,b
        sec
        sbc wR0
        sta wMapScrollSpeed,b
        stz wUnknown000766,b
        stz wUnknown00073A,b
        stz wMapEnableXScrollFlag,b
        stz wMapEnableYScrollFlag,b

        _C648
        jsl rlUnknown88BC05
        lda wUnknown0007D8,b
        cmp #$0002
        bne _C658
        jsl rlUnknown88C0B3

        _C658
        rtl


        _C659
        sep #$20
        lda #$88
        pha
        plb
        .databank $88
        rep #$20
        ldy #$EE52
        lda wCursorXOffset,b
        sta wR0
        lda wCursorYOffset,b
        sta wR1
        lda #$0006
        sta wR4
        lda #$2000
        sta wR5
        jsl rlPushToOAMBuffer
        rtl

        .databank 0

        ; 88/C67D

    .endsection Unsorted88C4D9Section


    .section Unsorted88C67DSection

      .al
      .xl

      rsUnknown88C67D ; 88/C67D

        ; TRACE: odd-opcode
        .al
        .xl
        .autsiz
        .databank ?

        jsr rsUnknown88C733
        lda wMapScrollXPixels,b
        sta wUnknown000734,b
        lda wMapScrollYPixels,b
        sta wUnknown000736,b
        lda wCursorXOffset,b
        sta wUnknown00076C,b
        lda wCursorYOffset,b
        sta wUnknown00076E,b
        lda #$0000
        sta wCursorXOffset,b
        lda $0875,b
        sta wMapScrollXPixels,b
        lda #$0000
        sta wCursorYOffset,b
        lda $0877,b
        sta wMapScrollYPixels,b
        jsr rsUnknown88B8E9
        bcc _C6B6
        .byte $00 ; brk

        _C6B6
        lda wUnknown000734,b
        sta wMapScrollXPixels,b
        lda wUnknown000736,b
        sta wMapScrollYPixels,b
        lda wUnknown00076C,b
        sta wCursorXOffset,b
        lda wUnknown00076E,b
        sta wCursorYOffset,b
        lda #$0002
        sta wUnknown0007D8,b
        lda #$FFFF
        sta wMapScrollDirectionIdentifier,b
        jsl rlUnknown88C085
        lda $07D6,b
        dec a
        dec a
        sta wMapScrollScriptOffset,b
        lda #$0002
        sta $07DA,b
        rts

        .databank 0

        ; 88/C6ED

    .endsection Unsorted88C67DSection


    .section Unsorted88C71CSection

      .al
      .xl

      rsUnknown88C71C ; 88/C71C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta $086F,b
        lda $0871,b
        sta $0772,b
        jsl rlUnknown88B4DB
        lda #$0001
        sta wUnknown0007D8,b
        rts

        .databank 0

        ; 88/C733

      rsUnknown88C733 ; 88/C733

        .al
        .xl
        .autsiz
        .databank ?

        lda wCursorXOffset,b
        clc
        adc wMapScrollXPixels,b
        sta wUnknown00076C,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR0
        sta $0778,b
        sta $077C,b
        lda wCursorYOffset,b
        clc
        adc wMapScrollYPixels,b
        sta wUnknown00076E,b
        lsr a
        lsr a
        lsr a
        lsr a
        sta wR1
        sta $077A,b
        sta $077E,b
        ldx $0871,b

        _C762
        lda aDeploymentTable,x
        beq _C7BF
        inc $078A,b
        lda aDeploymentTable,x
        bit #$0080
        beq _C7BF
        lda aDeploymentTable._XTilePosition,x
        cmp wR0
        bne _C7BF
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        cmp wR1
        bne _C7BF
        sta wR11
        inc wUnknown000770,b
        lda #$0002
        tsb $0788,b
        jsl rlUnknown85EA64
        lda #$0001
        sta $07DA,b
        stz $07DC,b
        stz $07DE,b
        stx $0772,b
        jsl rlDeployedUnitSetHidden
        stz wUnknown0007E2,b
        jsl rlUnknown88C9A6
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlUnknown87B541
        jsr rsUnknown88B873
        bra _C7CA


        _C7BF
        inc x
        inc x
        lda $078A,b
        cmp @l wDeployedUnitsCount
        bcc _C762

        _C7CA
        stz $078A,b
        clc
        rts

        .databank 0

        ; 88/C7CF

    .endsection Unsorted88C71CSection


    .section Unsorted88C7D8Section

      .al
      .xl

      rsUnknown88C7D8 ; 88/C7D8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta aMovingMapSpritesMapSprites,b
        lda #$8000
        sta $0869,b
        lda #$0002
        sta $086B,b
        lda #$8002
        sta $086D,b
        lda wUnknown0007E2,b
        sta @l wUnknown000911
        sta @l $000913
        sta @l $000915
        sta @l $000917
        ldx #$0006

        _C806
        lda #$0400
        sta wR5
        jsl rlUnknown88D7FE
        lda wR0
        clc
        adc wCursorXOffset,b
        clc
        adc aUnknown88C834,x
        sta wR0
        lda wR1
        clc
        adc wCursorYOffset,b
        clc
        adc aUnknown88C83C,x
        sta wR1
        phx
        jsl rlPushToOAMBuffer
        plx
        dec x
        dec x
        bpl _C806
        rts

        .databank 0

        ; 88/C834

    .endsection Unsorted88C7D8Section


    .section Table88C834Section

      .al
      .xl

      aUnknown88C834 ; 88/C834

        ; Read by rsUnknown88C7D8.

        .word $0000, $0020, $0030, $0040

        ; 88/C83C

    .endsection Table88C834Section


    .section Unsorted88C9A6Section

      .al
      .xl

      rlUnknown88C9A6 ; 88/C9A6

        .al
        .autsiz
        .databank ?

        phx
        phk
        plb

        lda #$FFFF
        sta $0865,b

        ldx $0772,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        bne _Tall

          ldx $0772,b
          lda aDeploymentTable._DeploymentOffsets,x
          tax
          lda aDeploymentTable._MapSpriteID,x
          and #~$8000
          sta wR0
          clc
          adc wR0
          clc
          adc wR0
          tax
          lda aMapMovementShortSpritePointers,x
          sta lR45
          lda aMapMovementShortSpritePointers+1,x
          sta lR45+1
          lda #(`$7EAB88)<<8
          sta lR47+1
          lda #<>$7EAB88
          sta lR47
          jsl rlDecompressSingle

          plx
          rtl
        
        _Tall
        ldx $0772,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #~$8000
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda aMapMovementTallSpritePointers,x
        sta lR45
        lda aMapMovementTallSpritePointers+1,x
        sta lR45+1
        lda #(`$7EAB88)<<8
        sta lR47+1
        lda #<>$7EAB88
        sta lR47
        jsl rlDecompressSingle

        plx
        rtl

        .databank 0

        ; 88/CA28

    .endsection Unsorted88C9A6Section


    .section Unsorted88CA77Section

      .al
      .xl

      rsUnknown88CA77 ; 88/CA77

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $07DC,b
        cmp #$0000
        beq _CA8E
        cmp #$0001
        beq _CA93
        cmp #$0002
        beq _CA98
        cmp #$0003
        beq _CA9D

        _CA8E
        lda #$0000
        bra _CAA2


        _CA93
        lda #$0140
        bra _CAA2


        _CA98
        lda #$0280
        bra _CAA2


        _CA9D
        lda #$03C0
        bra _CAA2


        _CAA2
        sta $07E6,b
        lda wUnknown0007E2,b
        cmp #$0000
        beq _CABC
        cmp #$0008
        beq _CAC1
        cmp #$0010
        beq _CAC6
        cmp #$0018
        beq _CACB

        _CABC
        lda #$0000
        bra _CAD0


        _CAC1
        lda #$0500
        bra _CAD0


        _CAC6
        lda #$0A00
        bra _CAD0


        _CACB
        lda #$0F00
        bra _CAD0


        _CAD0
        clc
        adc $07E6,b
        sta $07E6,b
        lda #$7E00
        sta lR18+1
        lda #$AB88
        sta lR18
        lda #$7E00
        sta $07EB,b
        lda #$AB88
        sta $07EA,b
        lda #$7E00
        sta $084E,b
        lda #$AB88
        sta $084D,b
        lda $07EA,b
        clc
        adc $07E6,b
        sta lR18
        sta $084D,b
        lda #$00A0
        sta wR0
        lda #$6200
        sta wR1
        lda $0865,b
        beq _CB1A
        phx
        jsl rlDMAByPointer
        plx

        _CB1A
        lda $07EA,b
        clc
        adc #$00A0
        clc
        adc $07E6,b
        sta lR18
        sta $0850,b
        lda #$00A0
        sta wR0
        lda #$6300
        sta wR1
        lda $0865,b
        beq _CB42
        phx
        jsl rlDMAByPointer
        plx
        stz $0865,b

        _CB42
        rts

        .databank 0

        ; 88/CB43

      rsUnknown88CB43 ; 88/CB43

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda $07DC,b
        cmp #$0000
        beq _CB5A
        cmp #$0001
        beq _CB5F
        cmp #$0002
        beq _CB64
        cmp #$0003
        beq _CB69

        _CB5A
        lda #$0000
        bra _CB6E


        _CB5F
        lda #$0200
        bra _CB6E


        _CB64
        lda #$0400
        bra _CB6E


        _CB69
        lda #$0600
        bra _CB6E


        _CB6E
        sta $07E6,b
        lda wUnknown0007E2,b
        xba
        clc
        adc $07E6,b
        sta $07E6,b
        lda #$7E00
        sta lR18+1
        lda #$AB88
        sta lR18
        lda #$7E00
        sta $07EB,b
        lda #$AB88
        sta $07EA,b
        lda #$7E00
        sta $084E,b
        lda #$AB88
        sta $084D,b
        lda $07EA,b
        clc
        adc $07E6,b
        sta lR18
        sta $084D,b
        lda #$0100
        sta wR0
        lda #$6200
        sta wR1
        lda $0865,b
        beq _CBBF
        phx
        jsl rlDMAByPointer
        plx

        _CBBF
        lda $07EA,b
        clc
        adc #$0100
        clc
        adc $07E6,b
        sta lR18
        sta $0850,b
        lda #$0100
        sta wR0
        lda #$6300
        sta wR1
        lda $0865,b
        beq _CBE7
        phx
        jsl rlDMAByPointer
        plx
        stz $0865,b

        _CBE7
        rts

        .databank 0

        ; 88/CBE8

    .endsection Unsorted88CA77Section


    .section Unsorted88CBE8Section

      .al
      .xl

      aUnknown88CBE8 ; 88/CBE8

        ; Indexed by map sprite ID (without the tall flag $8000).
        ; 65 bytes of 9 and then 32 bytes of 14: the same counts as the
        ; short and tall map sprite tables.

        .fill 65, 9
        .fill 32, 14

        ; 88/CC49

    .endsection Unsorted88CBE8Section


    .section Unsorted88CC75Section

      .al
      .xl

      rlUnknown88CC75 ; 88/CC75

        .al
        .xl
        .autsiz
        .databank ?

        lda $07E4,b
        and #$000F
        cmp #$0002
        bcc _CC97
        cmp #$0008
        beq _CC97
        cmp #$0009
        beq _CC97
        cmp #$000A
        bcc _CC93
        jsr rsUnknown88CE81
        rtl


        _CC93
        jsr rsUnknown88CC98
        rtl


        _CC97
        rtl

        .databank 0

        ; 88/CC98

      rsUnknown88CC98 ; 88/CC98

        .al
        .xl
        .autsiz
        .databank ?

        lda $07E4,b
        clc
        adc #$0002
        and #$000F
        asl a
        xba
        sta $078E,b
        lda $07E4,b
        and #$000F
        sec
        sbc #$0002
        asl a
        asl a
        asl a
        asl a
        sta $078C,b
        lda $07E4,b
        and #$0030
        cmp #$0000
        beq _CCD2
        cmp #$0010
        beq _CCD7
        cmp #$0020
        beq _CCDC
        cmp #$0030
        beq _CCE1

        _CCD2
        lda #$0000
        bra _CCE6


        _CCD7
        lda #$0080
        bra _CCE6


        _CCDC
        lda #$0100
        bra _CCE6


        _CCE1
        lda #$0080
        bra _CCE6


        _CCE6
        sta $07E6,b
        sta $0790,b
        ldx $078C,b
        ldy #$0000

        _CCF2
        lda aDeploymentTable._MapSpriteID,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        phx
        tax
        lda aUnknown88D526+1,x
        sta $07EE,b,y
        sta $07F1,b,y
        lda aUnknown88D526,x
        plx
        sta $07EA,b
        clc
        adc $07E6,b
        sta $07ED,b,y
        clc
        adc #$0040
        sta $07F0,b,y
        lda #$6000
        clc
        adc $078E,b
        sta $081D,b,y
        clc
        adc #$0100
        sta $0820,b,y
        lda $078E,b
        clc
        adc #$0020
        sta $078E,b
        inc x
        inc x
        tya
        clc
        adc #$0006
        tay
        cpy #$0030
        bcc _CCF2
        rts

        .databank 0

        ; 88/CD4C

      rlUnknown88CD4C ; 88/CD4C

        .al
        .xl
        .autsiz
        .databank ?

        lda #$8000
        trb $07E8,b
        rtl

        .databank 0

        ; 88/CD53

    .endsection Unsorted88CC75Section


    .section Unsorted88CD53Section

      .al
      .xl

      rlUnknown88CD53 ; 88/CD53

        .al
        .autsiz
        .databank ?

        lda #$8000
        tsb $07E8,b
        rtl

        .databank 0

      rlUnknown88CD5A ; 88/CD5A

        .al
        .autsiz
        .databank ?

        lda #$0001
        trb $07E8,b
        rtl

        .databank 0

      rlUnknown88CD61 ; 88/CD61

        .al
        .autsiz
        .databank ?

        lda #$0001
        tsb $07E8,b
        rtl

        .databank 0

        ; 88/CD68

    .endsection Unsorted88CD53Section


    .section Unsorted88CD68Section

      .al
      .xl

      rlUnknown88CD68 ; 88/CD68

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        jsl rlUnknown88DB0C
        lda $07E4,b
        and #$0007
        beq _CD97
        cmp #$0001
        beq _CD9D
        lda $07E8,b
        bmi _CD94
        lda $07E4,b
        and #$000F
        cmp #$0008
        bcc _CDA3
        jml _CE11


        _CD91
        inc $07E4,b

        _CD94
        plp
        plb
        .databank $88
        rtl


        _CD97
        jsl rlUnknown88CF31
        bra _CD91


        _CD9D
        jsl rlUnknown88CFBA
        bra _CD91


        _CDA3
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$00
        sta $4316,b
        sta $4326,b
        lda #$18
        sta $4311,b
        sta $4321,b
        ldy #$0000

        _CDBF
        lda #$40
        sta $4315,b
        sta $4325,b
        ldx $07ED,b,y
        stx $4312,b
        lda $07EF,b,y
        sta $4314,b
        ldx $081D,b,y
        stx $2116,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$02
        sta $420B,b
        ldx $07F0,b,y
        stx $4322,b
        lda $07F2,b,y
        sta $4324,b
        ldx $0820,b,y
        stx $2116,b
        lda #$04
        sta $420B,b
        tya
        clc
        adc #$06
        tay
        cpy #$0030
        beq _CE0B
        jml _CDBF


        _CE0B
        rep #$20
        jml _CD91


        _CE11
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$18
        sta $4311,b
        sta $4321,b
        lda #$00
        sta $4316,b
        sta $4326,b
        ldy #$0000

        _CE2D
        lda #$40
        sta $4315,b
        ldx $07ED,b,y
        stx $4312,b
        lda $07EF,b,y
        sta $4314,b
        ldx $081D,b,y
        stx $2116,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$02
        sta $420B,b
        lda #$80
        sta $4325,b
        ldx $07F0,b,y
        stx $4322,b
        lda $07F2,b,y
        sta $4324,b
        ldx $0820,b,y
        stx $2116,b
        lda #$04
        sta $420B,b
        tya
        clc
        adc #$06
        tay
        cpy #$0018
        beq _CE7B
        jml _CE2D


        _CE7B
        rep #$20
        jml _CD91

        .databank 0

        ; 88/CE81

      rsUnknown88CE81 ; 88/CE81

        .al
        .xl
        .autsiz
        .databank ?

        lda $07E4,b
        and #$000F
        asl a
        xba
        sta $078E,b
        lda $07E4,b
        and #$000F
        sec
        sbc #$000A
        asl a
        asl a
        asl a
        clc
        adc #$0060
        sta $078C,b
        lda $07E4,b
        and #$0030
        cmp #$0000
        beq _CEBA
        cmp #$0010
        beq _CEBF
        cmp #$0020
        beq _CEC4
        cmp #$0030
        beq _CEC9

        _CEBA
        lda #$0000
        bra _CECE


        _CEBF
        lda #$00C0
        bra _CECE


        _CEC4
        lda #$0180
        bra _CECE


        _CEC9
        lda #$00C0
        bra _CECE


        _CECE
        sta $07E6,b
        sta $0790,b
        ldx $078C,b
        ldy #$0000

        _CEDA
        lda aDeploymentTable._MapSpriteID,x
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        phx
        tax
        lda aUnknown88D5E3+1,x
        sta $07EE,b,y
        sta $07F1,b,y
        lda aUnknown88D5E3,x
        clc
        adc $07E6,b
        sta $07ED,b,y
        clc
        adc #$0040
        sta $07F0,b,y
        plx
        lda #$6000
        clc
        adc $078E,b
        sta $081D,b,y
        clc
        adc #$0100
        sta $0820,b,y
        lda $078E,b
        clc
        adc #$0040
        sta $078E,b
        inc x
        inc x
        tya
        clc
        adc #$0006
        tay
        cpy #$0018
        bcc _CEDA
        rts

        .databank 0

        ; 88/CF31

      rlUnknown88CF31 ; 88/CF31

        .al
        .xl
        .autsiz
        .databank ?

        lda $07E8,b
        bit #$0001
        bne _CF89
        sep #$20
        lda $07E4,b
        and #$78
        lsr a
        lsr a
        lsr a
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$08
        sta $4316,b
        lda #$18
        sta $4311,b
        lda aUnknown88CF8A,x
        sta $4312,b
        lda aUnknown88CF8A+1,x
        sta $4313,b
        lda aUnknown88CF8A+2,x
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$0C
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20

        _CF89
        rtl

        .databank 0

        ; 88/CF8A

    .endsection Unsorted88CD68Section


    .section Table88CF8ASection

      .al
      .xl

      aUnknown88CF8A ; 88/CF8A

        ; Read by rlUnknown88CF31.

        .byte $00, $00, $DB, $00, $08, $DB, $00, $10, $DB, $00, $18, $DB, $00, $20, $DB, $00
        .byte $28, $DB, $00, $30, $DB, $00, $38, $DB, $00, $40, $DB, $00, $48, $DB, $00, $50
        .byte $DB, $00, $58, $DB, $00, $60, $DB, $00, $68, $DB, $00, $70, $DB, $00, $78, $DB

        ; 88/CFBA

    .endsection Table88CF8ASection


    .section Unsorted88CFBASection

      .al
      .xl

      rlUnknown88CFBA ; 88/CFBA

        .al
        .xl
        .autsiz
        .databank ?

        lda $07E8,b
        bit #$0001
        bne _D012
        sep #$20
        lda $07E4,b
        and #$F8
        lsr a
        lsr a
        lsr a
        sta wR0
        asl a
        clc
        adc wR0
        tax
        lda #$80
        sta $2115,b
        lda #$00
        sta $4315,b
        lda #$04
        sta $4316,b
        lda #$18
        sta $4311,b
        lda aUnknown88D013,x
        sta $4312,b
        lda aUnknown88D013+1,x
        sta $4313,b
        lda aUnknown88D013+2,x
        sta $4314,b
        lda #$00
        sta $2116,b
        lda #$0A
        sta $2117,b
        lda #$01
        sta $4310,b
        lda #$02
        sta $420B,b
        rep #$20

        _D012
        rtl

        .databank 0

        ; 88/D013

    .endsection Unsorted88CFBASection


    .section Table88D013Section

      .al
      .xl

      aUnknown88D013 ; 88/D013

        ; Read by rlUnknown88CFBA.

        .byte $00, $00, $DC, $00, $04, $DC, $00, $08, $DC, $00, $0C, $DC, $00, $10, $DC, $00
        .byte $14, $DC, $00, $18, $DC, $00, $1C, $DC, $00, $20, $DC, $00, $24, $DC, $00, $28
        .byte $DC, $00, $2C, $DC, $00, $30, $DC, $00, $34, $DC, $00, $38, $DC, $00, $3C, $DC
        .byte $00, $40, $DC, $00, $44, $DC, $00, $48, $DC, $00, $4C, $DC, $00, $50, $DC, $00
        .byte $54, $DC, $00, $58, $DC, $00, $5C, $DC, $00, $60, $DC, $00, $64, $DC, $00, $68
        .byte $DC, $00, $6C, $DC, $00, $70, $DC, $00, $74, $DC, $00, $78, $DC, $00, $7C, $DC

        ; 88/D073

    .endsection Table88D013Section


    .section Table88D488Section

      .al
      .xl

      aUnknown88D488 ; 88/D488

        ; Read by rsUnknown88D963.

        .word $0020, $0000, $0040, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0020, $0000, $0000, $0000
        .word $0020, $0040, $0040, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0020, $0020, $0020, $0000, $0000, $0000

        ; 88/D4C6

    .endsection Table88D488Section


    .section Table88D4C6Section

      .al
      .xl

      aUnknown88D4C6 ; 88/D4C6

        ; Read by rsUnknown88D963.

        .word $0800, $0800, $0800, $0800, $0800, $0800, $0800, $0800
        .word $0800, $0800, $0800, $0800, $0800, $0800, $0800, $0800
        .word $0100, $0000, $0C00, $0000, $0100, $0000, $0C00, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0300, $0A00, $0700, $0000, $0300, $0A00, $0700
        .word $0000, $0000, $0600, $0000, $0000, $0000, $0600, $0000

        ; 88/D526

    .endsection Table88D4C6Section


    .section Unsorted88D731Section

      .al
      .xl

      rlUnknown88D731 ; 88/D731

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda lR18
        pha
        lda lR18+1
        pha
        phx
        phk
        plb
        .databank $88
        lda aMovingMapSpritesMapSprites,b,x
        and #$8000
        bne _D786
        lda aMovingMapSpritesMapSprites,b,x
        phx
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda @l aMapMovementShortSpritePointers,x
        sta lR45
        lda @l $88D366,x
        sta lR45+1
        plx
        jsr ($88D7B2,x)
        jsl rlDecompressSingle
        lda #(`g4bppcMageFemaleMapMovementSprite)<<8
        sta lR18+1
        lda #<>g4bppcMageFemaleMapMovementSprite
        sta lR18
        lda #(`aMapAction)<<8
        sta lR19+1
        lda #<>aMapAction
        sta lR19
        jsl rlAppendDecompList
        plx
        pla
        sta lR18+1
        pla
        sta lR18
        rtl


        _D786
        lda aMovingMapSpritesMapSprites,b,x
        phx
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda @l aMapMovementTallSpritePointers,x
        sta lR45
        lda @l $88D429,x
        sta lR45+1
        plx
        jsr ($88D7B2,x)
        jsl rlDecompressSingle
        plx
        pla
        sta lR18+1
        pla
        sta lR18
        rtl

        .databank 0

        ; 88/D7B2

    .endsection Unsorted88D731Section


    .section Unsorted88D7FESection

      .al
      .xl

      rlUnknown88D7FE ; 88/D7FE

        .al
        .autsiz
        .databank ?

        ; X = active mover offset

        phk
        plb
        lda aUnknown88D837,x
        trb wUnknown000921,b
        lda aUnknown88D83F,x
        trb wUnknown000921,b

        lda aMovingMapSpritesMapSprites,b,x
        and #$8000
        bne +

        ; Short
        jsr rsUnknown88D847
        lda wUnknown000901,x
        sec
        sbc #1
        sta wUnknown000901,x
        bra ++

        ; Tall
        +
        jsr rsUnknown88D963
        lda wUnknown000901,x
        sec
        sbc #1
        sta wUnknown000901,x

        +
        rtl

        .databank 0

      aUnknown88D837 ; 88/D837

        .word $0001
        .word $0002
        .word $0004
        .word $0008

      aUnknown88D83F ; 88/D83F

        .word $8000
        .word $4000
        .word $2000
        .word $1000

    .endsection Unsorted88D7FESection


    .section Unsorted88D847Section

      .al
      .xl

      rsUnknown88D847 ; 88/D847

        .al
        .autsiz
        .databank $88

        ; X = active mover offset

        ; For short map sprites

        lda wUnknown000901,x
        beq +

          jml _End

        +
        lda wUnknown000921,b
        beq ++

          and #$FF00
          beq +

            inc wUnknown000901,b,x
            jml _End

          +
          lda @l aUnknown88D95B,x
          tsb wUnknown000921,b

        +
        lda @l aUnknown88D953,x
        tsb wUnknown000921,b

        lda aMovingMapSpritesMapSprites,b,x
        and #$7FFF
        tay
        lda aUnknown88CBE8,y
        and #$00FF
        sta wUnknown000901,x

        lda wUnknown0008F1,x
        clc
        adc #1
        and #$0003
        sta wUnknown0008F1,x

        lda wUnknown0008F1,x
        cmp #0
        beq _D8A8

        cmp #1
        beq _D8AD

        cmp #2
        beq _D8B2

        cmp #3
        beq _D8B7

        _D8A8
        lda #size(Tile4bpp) * 0
        bra +

        _D8AD
        lda #size(Tile4bpp) * 10
        bra +

        _D8B2
        lda #size(Tile4bpp) * 20
        bra +

        _D8B7
        lda #size(Tile4bpp) * 30
        bra +

        +
        sta $07E6,b

        ; Check for direction of movement
        lda wUnknown000911,x
        cmp #0
        beq _D8D7

        cmp #8
        beq _D8DC

        cmp #$0010
        beq _D8E1

        cmp #$0018
        beq _D8E6

        _D8D7
        lda #0
        bra +

        _D8DC
        lda #$0500
        bra +

        _D8E1
        lda #$0A00
        bra +

        _D8E6
        lda #$0F00
        bra +

        +
        clc
        adc $07E6,b
        sta $07E6,b

        jsr (aUnknown88D94B,x)

        lda $07EA,b
        clc
        adc $07E6,b
        sta lR18

        lda #$00A0
        sta wR0

        lda #$C400 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        lda $07EA,b
        clc
        adc #$00A0
        clc
        adc $07E6,b
        sta lR18

        lda #$00A0
        sta wR0

        lda #$C600 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        _End
        sep #$20
        lda #$88
        pha
        plb
        rep #$20

        stz wR0
        stz wR1
        lda @l aUnknown88DAFC,x
        sta wR4
        ldy #$CC5F
        rts

        .databank 0

    .endsection Unsorted88D847Section


    .section Unsorted88D94BSection

      .al
      .xl

      aUnknown88D94B ; 88/D94B

        .word <>rsUnknown88DA82
        .word <>rsUnknown88DA99
        .word <>rsUnknown88DABA
        .word <>rsUnknown88DADB

      aUnknown88D953 ; 88/D953

        .word $0001
        .word $0002
        .word $0004
        .word $0008

      aUnknown88D95B ; 88/D95B

        .word $8000
        .word $4000
        .word $2000
        .word $1000

    .endsection Unsorted88D94BSection


    .section Unsorted88D963Section

      .al
      .xl

      rsUnknown88D963 ; 88/D963

        .al
        .autsiz
        .databank $88

        lda wUnknown000901,x
        beq +

          jml _End

        +
        lda wUnknown000921,b
        beq ++

          and #$FF00
          beq +

            inc wUnknown000901,b,x
            jml _End

          +
          lda @l $88DA7A,x
          tsb wUnknown000921,b

        +
        lda @l aUnknown88DA72,x
        tsb wUnknown000921,b

        lda aMovingMapSpritesMapSprites,b,x
        and #$7FFF
        tay
        lda aUnknown88CBE8,y
        and #$00FF
        sta wUnknown000901,x

        lda wUnknown0008F1,x
        clc
        adc #1
        and #$0003
        sta wUnknown0008F1,x

        lda wUnknown0008F1,x
        cmp #0
        beq _D9C4

        cmp #1
        beq _D9C9

        cmp #2
        beq _D9CE

        cmp #3
        beq _D9D3
        
        _D9C4
        lda #0
        bra +

        _D9C9
        lda #$0200
        bra +

        _D9CE
        lda #$0400
        bra +

        _D9D3
        lda #$0600
        bra +

        +
        sta $07E6,b

        lda wUnknown000911,x
        xba
        clc
        adc $07E6,b
        sta $07E6,b

        jsr (aUnknown88DA6A,x)

        lda $07EA,b
        clc
        adc $07E6,b
        sta lR18

        lda #size(Tile4bpp) * 8
        sta wR0

        lda #$C400 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        lda $07EA,b
        clc
        adc #$0100
        clc
        adc $07E6,b
        sta lR18

        lda #size(Tile4bpp) * 8
        sta wR0

        lda #$C600 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        _End
        sep #$20
        lda #$88
        pha
        plb
        rep #$20

        phx
        lda aMovingMapSpritesMapSprites,b,x
        and #$7FFF
        asl a
        tax
        lda @l aUnknown88D488,x
        sta wR3
        plx

        lda wUnknown0008F1,x
        asl a
        clc
        adc wUnknown000911,x
        clc
        adc wR3
        tay
        lda $D4C6,b,y
        and #$00FF
        sta wR0
        lda $D4C7,b,y
        and #$00FF
        sta wR1
        lda @l aUnknown88DAFC,x
        sta wR4
        ldy #$CC49
        rts

        .databank 0

    .endsection Unsorted88D963Section


    .section Unsorted88DA6ASection

      .al
      .xl

      aUnknown88DA6A ; 88/DA6A

        .word <>rsUnknown88DA82
        .word <>rsUnknown88DA99
        .word <>rsUnknown88DABA
        .word <>rsUnknown88DADB

      aUnknown88DA72 ; 88/DA72

        .word $0001
        .word $0002
        .word $0004
        .word $0008

      aUnknown88DA7A ; 88/DA7A

        .word $8000
        .word $4000
        .word $2000
        .word $1000

    .endsection Unsorted88DA6ASection


    .section Unsorted88DA82Section

      .al
      .xl

      rsUnknown88DA82 ; 88/DA82

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta $07EA+1,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta $07EA,b
        rts

        .databank 0

      rsUnknown88DA99 ; 88/DA99

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta $07EA+1,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta $07EA,b

        lda $07EA,b
        clc
        adc #$2000
        sta $07EA,b
        rts

        .databank 0

      rsUnknown88DABA ; 88/DABA

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta $07EB,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta $07EA,b

        lda $07EA,b
        clc
        adc #$4000
        sta $07EA,b
        rts

        .databank 0

      rsUnknown88DADB ; 88/DADB

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers[0]
        sta lR18
        lda #(`aMovingMapSpriteBuffers[0])<<8
        sta $07EB,b
        lda #<>aMovingMapSpriteBuffers[0]
        sta $07EA,b

        lda $07EA,b
        clc
        adc #$6000
        sta $07EA,b
        rts

        .databank 0

    .endsection Unsorted88DA82Section


    .section Unsorted88DAFCSection

      .al
      .xl

      aUnknown88DAFC ; 88/DAFC

        .word $0000
        .word $0008
        .word $0020
        .word $0028

      aUnknown88DB04 ; 88/DB04

        .word $0000 >> 1
        .word $0100 >> 1
        .word $0400 >> 1
        .word $0500 >> 1

        ; 88/DB0C

    .endsection Unsorted88DAFCSection


    .section Unsorted88DB0CSection

      .al
      .xl

      rlUnknown88DB0C ; 88/DB0C

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        lda $07DA,b
        beq _DB2F
        lda $0865,b
        beq _DB2F
        ldx $0772,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        beq _DB32
        jml _DB90


        _DB2F
        plp
        plb
        .databank $88
        rtl


        _DB32
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$00
        sta $4316,b
        sta $4326,b
        lda #$18
        sta $4311,b
        sta $4321,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$A0
        sta $4315,b
        ldx $084D,b
        stx $4312,b
        lda $084F,b
        sta $4314,b
        ldx #$6200
        stx $2116,b
        lda #$02
        sta $420B,b
        lda #$A0
        sta $4325,b
        ldx $0850,b
        stx $4322,b
        lda $084F,b
        sta $4324,b
        ldx #$6300
        stx $2116,b
        lda #$04
        sta $420B,b
        rep #$20
        plp
        plb
        .databank $88
        rtl


        _DB90
        sep #$20
        rep #$10
        lda #$80
        sta $2115,b
        lda #$18
        sta $4311,b
        sta $4321,b
        lda #$00
        sta $4315,b
        sta $4325,b
        lda #$01
        sta $4310,b
        sta $4320,b
        lda #$01
        sta $4316,b
        ldx $084D,b
        stx $4312,b
        lda $084F,b
        sta $4314,b
        ldx #$6200
        stx $2116,b
        lda #$02
        sta $420B,b
        lda #$01
        sta $4326,b
        ldx $0850,b
        stx $4322,b
        lda $084F,b
        sta $4324,b
        ldx #$6300
        stx $2116,b
        lda #$04
        sta $420B,b
        sep #$20
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/DBEE

    .endsection Unsorted88DB0CSection


    .section Unsorted88DBEESection

      .al
      .xl

      rlUnknown88DBEE ; 88/DBEE

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $88
        jsl rlGetSelectedUnitMapSprite
        and #$8000
        bne _DC01
        jsr rsUnknown88DC07
        plp
        plb
        .databank $88
        rtl


        _DC01
        jsr rsUnknown88DC8B
        plp
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/DC07

    .endsection Unsorted88DBEESection


    .section Unsorted88DC07Section

      .al
      .xl

      rsUnknown88DC07 ; 88/DC07

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0030
        cmp #$0000
        beq _DC20
        cmp #$0010
        beq _DC25
        cmp #$0020
        beq _DC2A
        cmp #$0030
        beq _DC2F

        _DC20
        lda #$0000
        bra _DC34


        _DC25
        lda #$0080
        bra _DC34


        _DC2A
        lda #$0100
        bra _DC34


        _DC2F
        lda #$0080
        bra _DC34


        _DC34
        sta $07E6,b
        jsl rlGetSelectedUnitMapSprite
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda $88D527,x
        sta lR18+1
        lda aUnknown88D526,x
        sta $07EA,b
        lda $07EA,b
        clc
        adc $07E6,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$6E00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda $07EA,b
        clc
        adc #$0040
        clc
        adc $07E6,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$6F00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DC8B

      rsUnknown88DC8B ; 88/DC8B

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda wVBlankEnabledFramecount
        and #$0030
        cmp #$0000
        beq _DCA4
        cmp #$0010
        beq _DCA9
        cmp #$0020
        beq _DCAE
        cmp #$0030
        beq _DCB3

        _DCA4
        lda #$0000
        bra _DCB8


        _DCA9
        lda #$00C0
        bra _DCB8


        _DCAE
        lda #$0180
        bra _DCB8


        _DCB3
        lda #$00C0
        bra _DCB8


        _DCB8
        sta $07E6,b
        jsl rlGetSelectedUnitMapSprite
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda $88D5E4,x
        sta lR18+1
        lda aUnknown88D5E3,x
        sta $07EA,b
        lda $07EA,b
        clc
        adc $07E6,b
        sta lR18
        lda #$0040
        sta wR0
        lda #$6E00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        lda $07EA,b
        clc
        adc #$0040
        clc
        adc $07E6,b
        sta lR18
        lda #$0080
        sta wR0
        lda #$6F00
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DD0F

    .endsection Unsorted88DC07Section


    .section Unsorted88DD9CSection

      .as
      .xl

      rlUnknown88DD9C ; 88/DD9C

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $88
        lda wR0
        bne _DDA8
        jsr rsUnknown88DDAD
        bra _DDAB


        _DDA8
        jsr rsUnknown88DDD4

        _DDAB
        plb
        .databank $88
        rtl

        .databank 0

        ; 88/DDAD

      rsUnknown88DDAD ; 88/DDAD

        .al
        .xl
        .autsiz
        .databank ?

        lda #$00A0
        sta wR0
        phx
        jsl rlDMAByPointer
        plx
        lda lR18
        clc
        adc #$00A0
        sta lR18
        lda #$00A0
        sta wR0
        lda wR1
        clc
        adc #$0100
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DDD4

      rsUnknown88DDD4 ; 88/DDD4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0100
        sta wR0
        phx
        jsl rlDMAByPointer
        plx
        lda lR18
        clc
        adc #$0100
        sta lR18
        lda #$0100
        sta wR0
        lda wR1
        clc
        adc #$0100
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rts

        .databank 0

        ; 88/DDFB

    .endsection Unsorted88DD9CSection


    .section Unsorted88E401Section

      .al
      .xl

      rsUnknown88E401 ; 88/E401

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        sta wRoutineVariable1,b
        stz wR10
        lda #$0000
        jsl rlUnknown84BF25
        lda wSelectedUnitDataRAMPointer,b
        rts

        .databank 0

        ; 88/E411

      rlUnknown88E411 ; 88/E411

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002

        _E414
        sta wRoutineVariable1,b
        lda #$0000
        jsl rlFindGenerationIDInFactionSlotData
        lda wSelectedUnitDataRAMPointer,b
        beq _E42C
        jsl rlGetSelectedUnitStates
        bit #UnitStateDead
        beq _E436

        _E42C
        lda wRoutineVariable1,b
        inc a
        cmp #$0019
        bne _E414
        rtl


        _E436
        lda #$EBFD
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rtl

        .databank 0

        ; 88/E440

      rlUnknown88E440 ; 88/E440

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        jsr rsUnknown88E401
        beq _E465
        lda #$0014
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E465
        lda #$8800
        sta lR18+1
        lda #$EC34
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E465
        rtl

        .databank 0

        ; 88/E466

      rlUnknown88E466 ; 88/E466

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        jsr rsUnknown88E401
        beq _E48B
        lda #$0015
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E48B
        lda #$8800
        sta lR18+1
        lda #$EC51
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E48B
        rtl

        .databank 0

        ; 88/E48C

      rlUnknown88E48C ; 88/E48C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        jsr rsUnknown88E401
        beq _E4B1
        lda #$0016
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E4B1
        lda #$8800
        sta lR18+1
        lda #$EC6C
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E4B1
        rtl

        .databank 0

        ; 88/E4B2

      rlUnknown88E4B2 ; 88/E4B2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000E
        jsr rsUnknown88E401
        beq _E4D7
        lda #$001E
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E4D7
        lda #$8800
        sta lR18+1
        lda #$EC8A
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E4D7
        rtl

        .databank 0

        ; 88/E4D8

      rlUnknown88E4D8 ; 88/E4D8

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000A
        jsr rsUnknown88E401
        beq _E4FD
        lda #$001A
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E4FD
        lda #$8800
        sta lR18+1
        lda #$ECA4
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E4FD
        rtl

        .databank 0

        ; 88/E4FE

      rlUnknown88E4FE ; 88/E4FE

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0013
        jsr rsUnknown88E401
        beq _E523
        lda #$0021
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E523
        lda #$8800
        sta lR18+1
        lda #$ECC0
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E523
        rtl

        .databank 0

        ; 88/E524

      rlUnknown88E524 ; 88/E524

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0017
        jsr rsUnknown88E401
        beq _E549
        lda #$002A
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E549
        lda #$8800
        sta lR18+1
        lda #$ECDA
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E549
        rtl

        .databank 0

        ; 88/E54A

      rlUnknown88E54A ; 88/E54A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0007
        jsr rsUnknown88E401
        beq _E56F
        lda #$0017
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E56F
        lda #$8800
        sta lR18+1
        lda #$ECF7
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E56F
        rtl

        .databank 0

        ; 88/E570

      rlUnknown88E570 ; 88/E570

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000B
        jsr rsUnknown88E401
        beq _E595
        lda #$001B
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E595
        lda #$8800
        sta lR18+1
        lda #$ED16
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E595
        rtl

        .databank 0

        ; 88/E596

      rlUnknown88E596 ; 88/E596

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0012
        jsr rsUnknown88E401
        beq _E5BB
        lda #$0020
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E5BB
        lda #$8800
        sta lR18+1
        lda #$ED32
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E5BB
        rtl

        .databank 0

        ; 88/E5BC

      rlUnknown88E5BC ; 88/E5BC

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000D
        jsr rsUnknown88E401
        beq _E5E1
        lda #$001D
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E5E1
        lda #$8800
        sta lR18+1
        lda #$ED4E
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E5E1
        rtl

        .databank 0

        ; 88/E5E2

      rlUnknown88E5E2 ; 88/E5E2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0009
        jsr rsUnknown88E401
        beq _E607
        lda #$0019
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E607
        lda #$8800
        sta lR18+1
        lda #$ED68
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E607
        rtl

        .databank 0

        ; 88/E608

      rlUnknown88E608 ; 88/E608

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000F
        jsr rsUnknown88E401
        beq _E62D
        lda #$001F
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E62D
        lda #$8800
        sta lR18+1
        lda #$ED7D
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E62D
        rtl

        .databank 0

        ; 88/E62E

      rlUnknown88E62E ; 88/E62E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        jsr rsUnknown88E401
        beq _E653
        lda #$0018
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E653
        lda #$8800
        sta lR18+1
        lda #$ED92
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E653
        rtl

        .databank 0

        ; 88/E654

      rlUnknown88E654 ; 88/E654

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0014
        jsr rsUnknown88E401
        beq _E679
        lda #$0025
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E679
        lda #$8800
        sta lR18+1
        lda #$EDAD
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E679
        rtl

        .databank 0

        ; 88/E67A

      rlUnknown88E67A ; 88/E67A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0016
        jsr rsUnknown88E401
        beq _E69F
        lda #$0029
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E69F
        lda #$8800
        sta lR18+1
        lda #$EDCC
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E69F
        rtl

        .databank 0

        ; 88/E6A0

      rlUnknown88E6A0 ; 88/E6A0

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000C
        jsr rsUnknown88E401
        beq _E6C5
        lda #$001C
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E6C5
        lda #$8800
        sta lR18+1
        lda #$EDE9
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E6C5
        rtl

        .databank 0

        ; 88/E6C6

      rlUnknown88E6C6 ; 88/E6C6

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0015
        jsr rsUnknown88E401
        beq _E6EB
        lda #$002C
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E6EB
        lda #$8800
        sta lR18+1
        lda #$EE03
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E6EB
        rtl

        .databank 0

        ; 88/E6EC

      rlUnknown88E6EC ; 88/E6EC

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0018
        jsr rsUnknown88E401
        beq _E711
        lda #$002B
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcc _E711
        lda #$8800
        sta lR18+1
        lda #$EE1F
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E711
        rtl

        .databank 0

        ; 88/E712

      rlUnknown88E712 ; 88/E712

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0002
        jsr rsUnknown88E401
        beq _E737
        lda #$0014
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E737
        lda #$8800
        sta lR18+1
        lda #$EC34
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E737
        rtl

        .databank 0

        ; 88/E738

      rlUnknown88E738 ; 88/E738

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        jsr rsUnknown88E401
        beq _E75D
        lda #$0015
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E75D
        lda #$8800
        sta lR18+1
        lda #$EC51
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E75D
        rtl

        .databank 0

        ; 88/E75E

      rlUnknown88E75E ; 88/E75E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        jsr rsUnknown88E401
        beq _E783
        lda #$0016
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E783
        lda #$8800
        sta lR18+1
        lda #$EC6C
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E783
        rtl

        .databank 0

        ; 88/E784

      rlUnknown88E784 ; 88/E784

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000E
        jsr rsUnknown88E401
        beq _E7A9
        lda #$001E
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E7A9
        lda #$8800
        sta lR18+1
        lda #$EC8A
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E7A9
        rtl

        .databank 0

        ; 88/E7AA

      rlUnknown88E7AA ; 88/E7AA

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000A
        jsr rsUnknown88E401
        beq _E7CF
        lda #$001A
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E7CF
        lda #$8800
        sta lR18+1
        lda #$ECA4
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E7CF
        rtl

        .databank 0

        ; 88/E7D0

      rlUnknown88E7D0 ; 88/E7D0

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0013
        jsr rsUnknown88E401
        beq _E7F5
        lda #$0021
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E7F5
        lda #$8800
        sta lR18+1
        lda #$ECC0
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E7F5
        rtl

        .databank 0

        ; 88/E7F6

      rlUnknown88E7F6 ; 88/E7F6

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0017
        jsr rsUnknown88E401
        beq _E81B
        lda #$002A
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E81B
        lda #$8800
        sta lR18+1
        lda #$ECDA
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E81B
        rtl

        .databank 0

        ; 88/E81C

      rlUnknown88E81C ; 88/E81C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0007
        jsr rsUnknown88E401
        beq _E841
        lda #$0017
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E841
        lda #$8800
        sta lR18+1
        lda #$ECF7
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E841
        rtl

        .databank 0

        ; 88/E842

      rlUnknown88E842 ; 88/E842

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000B
        jsr rsUnknown88E401
        beq _E867
        lda #$001B
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E867
        lda #$8800
        sta lR18+1
        lda #$ED16
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E867
        rtl

        .databank 0

        ; 88/E868

      rlUnknown88E868 ; 88/E868

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0012
        jsr rsUnknown88E401
        beq _E88D
        lda #$0020
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E88D
        lda #$8800
        sta lR18+1
        lda #$ED32
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E88D
        rtl

        .databank 0

        ; 88/E88E

      rlUnknown88E88E ; 88/E88E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000D
        jsr rsUnknown88E401
        beq _E8B3
        lda #$001D
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E8B3
        lda #$8800
        sta lR18+1
        lda #$ED4E
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E8B3
        rtl

        .databank 0

        ; 88/E8B4

      rlUnknown88E8B4 ; 88/E8B4

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0009
        jsr rsUnknown88E401
        beq _E8D9
        lda #$0019
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E8D9
        lda #$8800
        sta lR18+1
        lda #$ED68
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E8D9
        rtl

        .databank 0

        ; 88/E8DA

      rlUnknown88E8DA ; 88/E8DA

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000F
        jsr rsUnknown88E401
        beq _E8FF
        lda #$001F
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E8FF
        lda #$8800
        sta lR18+1
        lda #$ED7D
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E8FF
        rtl

        .databank 0

        ; 88/E900

      rlUnknown88E900 ; 88/E900

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        jsr rsUnknown88E401
        beq _E925
        lda #$0018
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E925
        lda #$8800
        sta lR18+1
        lda #$ED92
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E925
        rtl

        .databank 0

        ; 88/E926

      rlUnknown88E926 ; 88/E926

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0014
        jsr rsUnknown88E401
        beq _E94B
        lda #$0025
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E94B
        lda #$8800
        sta lR18+1
        lda #$EDAD
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E94B
        rtl

        .databank 0

        ; 88/E94C

      rlUnknown88E94C ; 88/E94C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0016
        jsr rsUnknown88E401
        beq _E971
        lda #$0029
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E971
        lda #$8800
        sta lR18+1
        lda #$EDCC
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E971
        rtl

        .databank 0

        ; 88/E972

      rlUnknown88E972 ; 88/E972

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000C
        jsr rsUnknown88E401
        beq _E997
        lda #$001C
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E997
        lda #$8800
        sta lR18+1
        lda #$EDE9
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E997
        rtl

        .databank 0

        ; 88/E998

      rlUnknown88E998 ; 88/E998

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0015
        jsr rsUnknown88E401
        beq _E9BD
        lda #$002C
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E9BD
        lda #$8800
        sta lR18+1
        lda #$EE03
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E9BD
        rtl

        .databank 0

        ; 88/E9BE

      rlUnknown88E9BE ; 88/E9BE

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0018
        jsr rsUnknown88E401
        beq _E9E3
        lda #$002B
        sta wEventEngineParameter1,b
        lda #$0005
        jsl rlCheckIfEventFlagOfSpecifiedChapterSet
        bcs _E9E3
        lda #$8800
        sta lR18+1
        lda #$EE1F
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _E9E3
        rtl

        .databank 0

        ; 88/E9E4

    .endsection Unsorted88E401Section


    .section Unsorted88EEB1Section

      .al
      .xl

      rlUnknown88EEB1 ; 88/EEB1

        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlUnknown91ECA2
        beq _EEC2
        cmp #$0006
        bcs _EEC2
        sta wR0,b
        bra _EEC8


        _EEC2
        lda #$0006
        sta wR0,b

        _EEC8
        lda #$0007
        sec
        sbc wR0,b
        asl a
        dec a
        sta $1B49,b
        sta $1B4B,b
        plx
        rtl

        .databank 0

        ; 88/EED9

    .endsection Unsorted88EEB1Section


    .section Unsorted88EF0DSection

      .al
      .xl

      aUnknown88EF0D ; 88/EF0D

        ; 12 long pointers to routines.

        .long rlUnknown9EEED3, rlUnknown9EEDB5, rlUnknown88F47C
        .long rlUnknown88EF31, rlUnknown88F5B3, rlUnknown88F01D
        .long rlUnknown88F6D1, rlUnknown88F13B, rlUnknown88F7EF
        .long rlUnknown88F259, rlUnknown88F8F4, rlUnknown88F35E

      rlUnknown88EF31 ; 88/EF31

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0002
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0021
        sta aActionStructUnit1.XPosition
        lda #$0017
        sta aActionStructUnit1.YPosition
        lda #$0031
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0029
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$0021
        sta aActionStructUnit2.XPosition
        lda #$0019
        sta aActionStructUnit2.YPosition
        lda #$002D
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta $7F4564
        sta aActionStructUnit2
        lda #$0002
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0135
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

      rlUnknown88F01D ; 88/F01D

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0000
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0034
        sta aActionStructUnit1.XPosition
        lda #$0022
        sta aActionStructUnit1.YPosition
        lda #$0001
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0016
        sta aActionStructUnit2.ClassID
        lda #$0001
        sta aActionStructUnit2.Gender
        lda #$0034
        sta aActionStructUnit2.XPosition
        lda #$0023
        sta aActionStructUnit2.YPosition
        lda #$0003
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta $7F4564
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0008
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0105
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0009
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F13B

      rlUnknown88F13B ; 88/F13B

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0011
        sta aActionStructUnit1.ClassID
        lda #$0001
        sta aActionStructUnit1.Gender
        lda #$0023
        sta aActionStructUnit1.XPosition
        lda #$0032
        sta aActionStructUnit1.YPosition
        lda #$0002
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0003
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0011
        sta aActionStructUnit2.ClassID
        lda #$0001
        sta aActionStructUnit2.Gender
        lda #$0024
        sta aActionStructUnit2.XPosition
        lda #$0032
        sta aActionStructUnit2.YPosition
        lda #$001E
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta $7F4564
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0008
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0101
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0115
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F259

      rlUnknown88F259 ; 88/F259

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0007
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$001E
        sta aActionStructUnit1.XPosition
        lda #$0036
        sta aActionStructUnit1.YPosition
        lda #$0024
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0009
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$001D
        sta aActionStructUnit2.XPosition
        lda #$0036
        sta aActionStructUnit2.YPosition
        lda #$0014
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta $7F4564
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0009
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0008
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F35E

      rlUnknown88F35E ; 88/F35E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0006
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0037
        sta aActionStructUnit1.XPosition
        lda #$0007
        sta aActionStructUnit1.YPosition
        lda #$0015
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$001C
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$0037
        sta aActionStructUnit2.XPosition
        lda #$0006
        sta aActionStructUnit2.YPosition
        lda #$002C
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta $7F4564
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0101
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0100
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0114
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F47C

      rlUnknown88F47C ; 88/F47C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0003
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$002E
        sta aActionStructUnit1.XPosition
        lda #$001D
        sta aActionStructUnit1.YPosition
        lda #$0029
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0027
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$002D
        sta aActionStructUnit2.XPosition
        lda #$001D
        sta aActionStructUnit2.YPosition
        lda #$0029
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta $7F4564
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0100
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0101
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0100
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0101
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F5B3

      rlUnknown88F5B3 ; 88/F5B3

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$003C
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$000D
        sta aActionStructUnit1.XPosition
        lda #$000A
        sta aActionStructUnit1.YPosition
        lda #$004E
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0035
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$000E
        sta aActionStructUnit2.XPosition
        lda #$000A
        sta aActionStructUnit2.YPosition
        lda #$003F
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta $7F4564
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0141
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0140
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0140
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F6D1

      rlUnknown88F6D1 ; 88/F6D1

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0013
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$002B
        sta aActionStructUnit1.XPosition
        lda #$002F
        sta aActionStructUnit1.YPosition
        lda #$0024
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0014
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$002C
        sta aActionStructUnit2.XPosition
        lda #$002F
        sta aActionStructUnit2.YPosition
        lda #$0023
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta $7F4564
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0109
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0104
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0114
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F7EF

      rlUnknown88F7EF ; 88/F7EF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$002D
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0023
        sta aActionStructUnit1.XPosition
        lda #$0013
        sta aActionStructUnit1.YPosition
        lda #$004B
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$003A
        sta aActionStructUnit2.ClassID
        lda #$0001
        sta aActionStructUnit2.Gender
        lda #$0024
        sta aActionStructUnit2.XPosition
        lda #$0013
        sta aActionStructUnit2.YPosition
        lda #$0046
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta $7F4564
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0144
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0154
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F8F4

      rlUnknown88F8F4 ; 88/F8F4

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0006
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$000F
        sta aActionStructUnit1.XPosition
        lda #$0005
        sta aActionStructUnit1.YPosition
        lda #$0015
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0019
        sta aActionStructUnit1.CharacterID
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$001B
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$000F
        sta aActionStructUnit2.XPosition
        lda #$0004
        sta aActionStructUnit2.YPosition
        lda #$0041
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta $7F4564
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0149
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0100
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0104
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/FA19

    .endsection Unsorted88EF0DSection
