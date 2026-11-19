; Block memory copies with MVN/MVP.

    .section BlockCopySection

      .al
      .xs

      rlBlockCopyMVNByRAM ; 80/A970

        .al
        .autsiz
        .databank ?

        ; lBlockCopySource = source data
        ; lBlockCopyDestination = destination

        phb
        php
        phk
        plb

        .databank `*

        phx
        phy

        sep #$20
        lda lBlockCopyDestination+2,b
        sta rsBlockCopyMVNRAM+1,b
        lda lBlockCopySource+2,b
        sta rsBlockCopyMVNRAM+2,b
        lda #$54    ; mvn
        sta rsBlockCopyMVNRAM,b
        lda #$60    ; rts
        sta rsBlockCopyMVNRAM+3,b
        rep #$20

        ldx lBlockCopySource,b
        ldy lBlockCopyDestination,b
        lda wBlockCopySize,b
        dec a
        jsr <>rsBlockCopyMVNRAM,k

        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlBlockCopyMVPByRAM ; 80/A9A2

        .al
        .autsiz
        .databank ?

        ; lBlockCopySource = source data
        ; lBlockCopyDestination = destination

        phb
        php
        phk
        plb
        phx
        phy

        sep #$20
        lda lBlockCopyDestination+2,b
        sta rsBlockCopyMVPRAM+1,b
        lda lBlockCopySource+2,b
        sta rsBlockCopyMVPRAM+2,b
        lda #$44    ; mvp
        sta rsBlockCopyMVPRAM,b
        lda #$60    ; rts
        sta rsBlockCopyMVPRAM+3,b
        rep #$20

        ldx lBlockCopySource,b
        ldy lBlockCopyDestination,b
        lda wBlockCopySize,b
        dec a
        jsr <>rsBlockCopyMVPRAM,k

        ply
        plx
        plp
        plb
        rtl
 
        .databank 0

      rlUnknown80A9D4 ; 80/A9D4

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        pha

        lda wUnknown00171A,b
        bit #$0010
        bne +

        pla
        sta wMainLoopPointer
        bra ++

        +
        pla
        sta wR26
        lda #$0010
        trb wUnknown00171A,b

        +
        plp
        plb
        rtl

        .databank 0

        ; 80/A9F2

    .endsection BlockCopySection
