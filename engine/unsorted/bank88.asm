; Code from bank $88 not yet assigned to a game system.

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
          jsr $88875E
          jsl $8887AD
          jsr $88847D

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


    .section Unsorted888560Section

      .al
      .xl

      rlUnknown888560 ; 88/8560

        .al
        .autsiz
        .databank ?

        lda wUnknown00073A,b
        beq +

          jsl $88864F

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
        jsl $8886F0
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
        jsl $8887BC
        rtl

        .databank 0

      rlUnknown8886B3 ; 88/86B3

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollUpSetBGOFS
        jsl $888798
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
        jsl $888798
        rtl

        .databank 0

      rlUnknown8886D2 ; 88/86D2

        .al
        .autsiz
        .databank ?

        jsr rsMapScrollRightSetBGOFS
        jsr rsMapScrollUpSetBGOFS
        jsl $8887BC
        jsl $888798
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
            jsr $888A14
            bra _End

        +
        jsr rsUnknown888BB3

        lda wUnknown000770,b
        beq _End

          lda #$00E0
          jsr $888C5F

        _End
        rts

        .databank 0

      rsUnknown88895C ; 88/895C

        .al
        .autsiz
        .databank ?

        stz $04
        lda $059A,b
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

        lda $0598,b
        and #$0008
        bne +

          jsr rsUnknown88899F

          lda wUnknown000770,b
          beq _End

            lda #0
            jsr $888A14
            bra _End

        +
        jsr rsUnknown888BB3

        lda wUnknown000770,b
        beq _End

          lda #0
          jsr $888C5F

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

        lda $075A,b
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
            jsr $888F32
            bra _End

        +
        lda #4
        jsr $889108

        lda wUnknown000770,b
        beq _End

          lda #$00F8
          jsr $8891BC

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
            jsr $888F32
            bra _End

        +
        lda #0
        jsr $889108

        lda wUnknown000770,b
        beq _End

          lda #0
          jsr $8891BC

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

        lda $0E7B,b
        and #$00FF
        bit #$0041
        beq ++

          lda $086F,b
          bpl +

            jsr $88C71C
          
          +
          jml $88C4D9

        +
        lda wUnknown00171A,b
        beq +

          jml _End
        
        +
        lda $0788,b
        bit #$0020
        beq +

          jml $88973F

        +
        lda $07E0,b
        bpl +

          lda $0772,b
          jsl $88B42C
          jml _End
        
        +
        lda $0786,b
        bit #$0002
        beq _A234

          ldx $0772,b
          lda $7E46EB,x
          sta $056F,b

          ldx $0772,b
          lda wCursorXOffset,b
          clc
          adc wMapScrollXPixels,b
          sta $0780,b

          lda $7E44AB,x
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

          jsl $88C9A6

          lda $0786,b
          bit #$0008
          bne +

            jsl $84B32B

            lda #$0002
            trb $0786,b

            lda #$0004
            tsb $0786,b
            bra _A234

          +
          lda #$0002
          trb $0786,b

          jsl $88A2F5

        _A234
        lda wUnknown0007D8,b
        beq _A24F

          cmp #$FFFF
          beq ++

            cmp #$0003
            beq +

              jml $88A754
            
            +
            jml $88A81D
          
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
          jsr $88A551
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

          jsr $88BEEF

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
                    jsr $88A9B4
                    beq _End

                      lda #8
                      sta wMapScrollSpeed,b
                      bra +
          
          _A788
          stz wMapPixelScrollDistance,b
          jsr $88AA1E
          beq _End

            jsr $88A7F5
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

          jsl $88C0B3

        _End
        rtl

        .databank 0

        ; 88/A7F5

    .endsection Unsorted88A754Section


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
        jsr $88B701
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
        jsl $8591B2
        lda #0
        rts

        _B6D4
        stz wUnknown00073A,b
        stz wMapScrollScriptOffset,b
        stz wUnknown0007D8,b
        lda $0D87,b
        bit #$0008
        bne +

          jsr $88B701
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
        jsr $88BDA1
        rtl
        
        _0400
        jsr $88BE57
        rtl
        
        _0A00
        jsr rsUnknown88BC63
        jsr $88BDA1
        rtl
        
        _0600
        jsr rsUnknown88BC63
        jsr $88BE57
        rtl
        
        _0900
        jsr rsUnknown88BD09
        jsr $88BDA1
        rtl
        
        _0500
        jsr rsUnknown88BD09
        jsr $88BE57
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

        lda $0867,b,x
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
        lda $0867,b,x
        and #$7FFF
        asl a
        tax
        lda @l $88D488,x
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
