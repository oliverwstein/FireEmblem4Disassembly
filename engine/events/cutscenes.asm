; TODO: describe this file.

    .section BelhallaMagesAttackSection

      .al
      .xl

      procBelhallaMagesAttack ; 9E/F61E

        .structProcInfo "ON", rlProcBelhallaMagesAttackInit, rlProcBelhallaMagesAttackCycle, aProcBelhallaMagesAttackCode

        ; Belhalla attack

      rlProcBelhallaMagesAttackInit ; 9E/F626

        .al
        .autsiz
        .databank ?

        lda #0
        sta aProcSystem.aHeaderBitfield,b,x
        sta aProcSystem.aBody5,x
        sta aProcSystem.aBody6,x
        sta $7F57F0
        sta $7F4C07

        lda #1
        sta $7F50CB

        jsl rlUnknown88CD53
        jsl rlUnknown88CD61
        rtl

        .databank 0

      rlProcBelhallaMagesAttackCycle ; 9E/F64C

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      aProcBelhallaMagesAttackCode ; 9E/F64D

        PROC_CALL rlUnknown9EF79D
        PROC_JUMP_IF_BITS_SET _MagesAttacked, $0002

        -
        PROC_YIELD 1
        PROC_CALL rlUnknown9EF822
        PROC_JUMP_IF_BITS_UNSET -, $0004

        PROC_YIELD 1
        PROC_JUMP aProcBelhallaMagesAttackCode

        ; Check targets to hit
        _MagesAttacked
        PROC_CALL rlUnknown9EF703
        PROC_SET_ONCYCLE $C9FD
        PROC_YIELD 16
        PROC_CALL $9F85A3
        PROC_YIELD 2
        PROC_CALL $9F85CC
        PROC_YIELD 2
        PROC_CALL $9F85F5
        PROC_YIELD 2
        PROC_CALL $9F861F
        PROC_YIELD 2
        PROC_CALL $9F86BF

        PROC_JUMP_IF_BITS_UNSET _F6FA, $0002

        -
        PROC_YIELD 1
        PROC_CALL $9F86B0
        PROC_JUMP_IF_BITS_UNSET -, $0001

        PROC_CALL $9F8677
        PROC_YIELD 2
        PROC_CALL $9EE228

        -
        PROC_CALL $9EE23D
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET -, $0004

        PROC_SET_UNK_TIMER 5

        ; Meteors fall
        -
        PROC_CALL rlUnknown9EF724
        PROC_CALL $9EFAD4
        PROC_CALL $9F8020
        PROC_YIELD 128
        PROC_CALL $9F8349
        PROC_CALL $9F8473
        PROC_YIELD 1
        PROC_JUMP_WHILE_UNK_TIMER -

        PROC_CALL rlUnknown9EF791

        -
        PROC_CALL $9EE279
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET -, $0004

        _F6FA
        PROC_YIELD 16
        PROC_CALL rlUnknown9EF76F
        PROC_END

      rlUnknown9EF703 ; 9E/F703

        .al
        .autsiz
        .databank ?

        lda #4
        sta $7F508B
        sta $7F5089
        lda #$8401
        sta $7F508F
        lda #$00FF
        sta $7F5099
        lda #0
        sta $7F509F
        rtl

        .databank 0

      rlUnknown9EF724 ; 9E/F724

        .al
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aBody6,x
        asl a
        tax
        lda aUnknown9EF765+1,x
        and #$00FF
        tay
        lda aUnknown9EF765,x
        and #$00FF
        tax
        lda $7E4EBB
        jsl $9E8D25

        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1

        lda wR1
        xba
        ora wR0
        sta $7F509B

        plx
        lda aProcSystem.aBody6,x
        inc a
        sta aProcSystem.aBody6,x
        rtl

        .databank 0

      aUnknown9EF765 ; 9E/F765

        .word $3106
        .word $3007
        .word $2F05
        .word $2E07
        .word $2D06

      rlUnknown9EF76F ; 9E/F76F

        .al
        .autsiz
        .databank ?

        lda $7F4C07
        ora #$0002
        sta $7F4C07

        jsl $88CD4C
        jsl rlUnknown88CD5A

        ldx #$00DE

          -
          lda $8C9520,x
          sta aOAMPaletteBuffer.aPalette1,b,x
          dec x
          dec x
          bpl -

        rtl

        .databank 0

    .endsection BelhallaMagesAttackSection


    .section BelhallaAttackingMageDirectionsSection

      .al
      .xl

      aBelhallaAttackingMageDirections ; 9E/F81D

        .byte 4
        .byte 0
        .byte 4
        .byte 0
        .byte 4

      rlUnknown9EF822 ; 9E/F822

        .al
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aBody4,b,x
        jsl $8280F8
        bcc +

          lda aProcSystem.aHeaderBitfield,b,x
          ora #$0004
          sta aProcSystem.aHeaderBitfield,b,x

        +
        plx
        rtl

        .databank 0

      procUnknown9EF837 ; 9E/F837

        .structProcInfo "ON", rlProcUnknown9EF837Init, rlProcUnknown9EF837Cycle1, aProcUnknown9EF837Code

    .endsection BelhallaAttackingMageDirectionsSection
