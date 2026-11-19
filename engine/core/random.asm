; Random number generation and percentage-chance rolls.

    .section RandomNumberSection

      .as
      .xl

      rlGetRandomNumber100 ; 80/A70E

        .al
        .autsiz
        .databank ?

        ; Returns random value between 0 and input exclusive

        phb
        php
        phk
        plb
        and #$00FF
        beq +

          sta wR10

          jsl rlGetRandomNumber
          and #$00FF
          beq +

            sta wR11
            jsl rlUnsignedMultiply16By16
            lda wR12
            sta wR13

            lda #100
            sta wR14
            jsl rlUnsignedDivide16By8
            lda wR13

        +
        plp
        plb
        rtl

        .databank 0

      rlGetRandomNumber ; 80/A73A

        .al
        .autsiz
        .databank ?

        phx
        phy
        phb
        php
        phk
        plb

        lda #0
        sep #$30

        inc wRNIndex,b

        lda wRNIndex,b
        cmp #size(aRNArray)
        blt ++

          jsr $80A7C5 ; rsShuffleRNTable
          rep #$30

          jsl $8F8006
          blt +

            jsr $80A7F3

        +
        lda #0
        sep #$30
        sta wRNIndex,b

        +
        tay
        lda aRNArray,b,y
        dec a
        bpl +

          lda #99

        +
        plp
        plb
        ply
        plx
        rtl

        .databank 0

        ; 80/A773

    .endsection RandomNumberSection


    .section Unknown80A773Section

      .al
      .xl

      rlUnknown80A773 ; 80/A773

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb

        stz wRNIndex,b
        sep #$30

        lda bFrameCounterByOnes,b
        and #$3F
        sta bRNGUnknown1,b
        sta aRNArray + size(aRNArray) - 1,b

        lda #1
        sta bRNGUnknown2,b
        ldy #20
        ldx #$36

          _Loop
          lda bRNGUnknown2,b
          sta aRNArray,b,y

          lda bRNGUnknown1,b
          sec
          sbc bRNGUnknown2,b
          bge +

            clc
            adc #100

          +
          sta bRNGUnknown2,b

          lda aRNArray,b,y
          sta bRNGUnknown1,b

          tya
          clc
          adc #21
          cmp #size(aRNArray)
          blt +

            sbc #size(aRNArray)

          +
          tay
          dec x
          bne _Loop

        jsr rsShuffleRNTable
        jsr rsShuffleRNTable
        jsr rsShuffleRNTable

        plb
        plp
        rtl

        .databank 0

      rsShuffleRNTable ; 80/A7C5

        .as
        .autsiz
        .databank ?

        ldy #0

          _Loop
          tya
          sta bRNGUnknown1,b
          cmp #24
          bge +

          adc #$1F
          blt ++

          +
          sbc #24

          +
          tay
          lda aRNArray,b,y
          sta bRNGUnknown2,b

          ldy bRNGUnknown1,b
          lda aRNArray,b,y
          sec
          sbc bRNGUnknown2,b
          bge +

            adc #100

          +
          sta aRNArray,b,y
          inc y
          cpy #$37
          bne _Loop

        rts

        .databank 0

      rsUnknown80A7F3 ; 80/A7F3

        .as
        .autsiz
        .databank ?

        rep #$30
        jsl $91EBC9
        lsr a
        lsr a
        sta $04A4,b

        txa
        asl a
        asl a
        asl a
        asl a
        clc
        adc $04A4,b
        sec
        sbc #80
        bcc +

        cmp #100
        bcc ++

        lda #100
        bra ++

        +
        lda #0

        +
        sta $04A4,b
        sep #$30
        ldy #0
        tyx

          _Loop
          lda aRNArray,b,y
          cmp $04A4,b
          bcs +

            txa
            sta aRNArray,b,y

          +
          inc y
          cpy #$37
          bne _Loop

        rep #$30
        rts

        .databank 0

        ; 80/A836

    .endsection Unknown80A773Section


    .section RandomChanceSection

      .as
      .xs

      rlConvertChanceToFullByte ; 80/A899

        .al
        .autsiz
        .databank ?

        ; Enters with a percent chance from 0 to 100
        ; and exits with a chance scaled up to 0 to 256

        ora #0
        beq +

          phx
          dec a
          asl a
          tax
          lda aChanceToByteLookupTable,x
          plx

        +
        rtl

        .databank 0

      aChanceToByteLookupTable ; 80/A8A8

        .word   2,   5,   7,  10,  12,  15,  17,  20,  23,  25
        .word  28,  30,  33,  35,  38,  40,  43,  46,  48,  51
        .word  53,  56,  58,  61,  64,  66,  69,  71,  74,  76
        .word  79,  81,  84,  87,  89,  92,  94,  97,  99, 102
        .word 104, 107, 110, 112, 115, 117, 120, 122, 125, 128
        .word 130, 133, 135, 138, 140, 143, 145, 148, 151, 153
        .word 156, 158, 161, 163, 166, 168, 171, 174, 176, 179
        .word 181, 184, 186, 189, 192, 194, 197, 199, 202, 204
        .word 207, 209, 212, 215, 217, 220, 222, 225, 227, 230
        .word 232, 235, 238, 240, 243, 245, 248, 250, 253, 256

    .endsection RandomChanceSection
