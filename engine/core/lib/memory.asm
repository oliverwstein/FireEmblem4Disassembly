; Block copies with MVN/MVP: the instructions take their banks as operands, so
; the copy runs from a four-byte stub in RAM (rsBlockCopyMVNRAM, rsBlockCopyMVPRAM)
; that each call rewrites. Also calling a routine through a table of long pointers
; (rlCallIndirectRoutineFromTable).

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

    .endsection BlockCopySection


    .section Unsorted80A836Section

      .al
      .xl

      rsInitBlockCopyRAMStubs ; 80/A836

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies the MVN and MVP stubs into RAM (rsBlockCopyMVNRAM, rsBlockCopyMVPRAM). It
        ; copies five bytes for MVP, the fifth from the code after the template; the block
        ; copies rewrite the stubs' opcode, banks and return each time anyway.

        phb
        php
        phk
        plb
        .databank $80
        sep #$20
        ldx #$0003

        _A83F
        lda @l aBlockCopyMVNStubTemplate,x
        sta rsBlockCopyMVNRAM,b,x
        dec x
        bpl _A83F
        ldx #$0004

        _A84C
        lda @l aBlockCopyMVPStubTemplate,x
        sta rsBlockCopyMVPRAM,b,x
        dec x
        bpl _A84C
        plp
        plb
        .databank $80
        rts

        .databank 0

        ; 80/A859

    .endsection Unsorted80A836Section


    .section Table80A859Section

      .al
      .xl

      aBlockCopyMVNStubTemplate ; 80/A859

        ; Read by rsInitBlockCopyRAMStubs.

        .byte $54, $00, $00, $60

        ; 80/A85D

    .endsection Table80A859Section


    .section Table80A85DSection

      .al
      .xl

      aBlockCopyMVPStubTemplate ; 80/A85D

        ; Read by rsInitBlockCopyRAMStubs.

        .byte $44, $00, $00, $60

        ; 80/A861

    .endsection Table80A85DSection


    .section Unsorted80A861Section

      .al
      .xl

      rlCallIndirectRoutineFromTable ; 80/A861

        .al
        .autsiz
        .databank ?

        ; Indexes 24-bit callback at [0,b,x + A] and dispatches via rlJumpIndirectRoutine if nonzero

        phb
        php
        phk
        plb
        phy

        clc
        adc $0000,b,x
        tay
        sep #$20
        lda $0002,b,x
        pha
        rep #$20
        plb

        lda $0000,b,y
        ora $0001,b,y
        beq +

          lda $0000,b,y
          sta lR23
          lda $0001,b,y
          sta lR23+1
          jsl rlJumpIndirectRoutine

        +
        ply
        plp
        plb
        rtl

        .databank 0

      rlJumpIndirectRoutine ; 80/A88E

        .al
        .autsiz
        .databank ?

        ; Loads DB from lR23+2 and executes jml [lR23]

        sep #$20
        lda lR23+2
        pha
        rep #$20
        plb
        jml [lR23]

        .databank 0

        ; 80/A899

    .endsection Unsorted80A861Section


    .section MainDataEntry12UnusedSection

      aMainDataEntry12Unused .word 0 ; 83/D8E6

    .endsection MainDataEntry12UnusedSection


    .section SwapToMainDataBankSection

      rlSwapToMainDataBank ; 83/F7C1

        .al
        .autsiz
        .databank ?

        phk
        plb
        rtl

        .databank 0

    .endsection SwapToMainDataBankSection


