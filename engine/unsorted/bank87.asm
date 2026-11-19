; Code from bank $87 not yet assigned to a game system.

    .section Unsorted87F515Section

      .al
      .xl

      rlUnknown87F515 ; 87/F515

        .al
        .autsiz
        .databank ?

        phb
        phx
        phy
        tay

        lda #(`aUnitRAMArea)<<8
        sta lR18+1
        lda #<>aUnitRAMArea
        sta lR18
        jsl rlBufferAndLoadNewRAMAreaPointer

        lda #size(structCharacterDataRAM)
        jsl rlAllocateRAMArea

        lda lR25
        sta wSelectedUnitDataRAMPointer,b

        lda #(`aUnitRAMPointers)<<8
        sta lStructPointer2+1,b
        lda #<>aUnitRAMPointers
        sta lStructPointer2,b

        lda lR25
        sta lStructPointer1,b

        jsl rlAppendNewStructEntry

        tya
        jsr $87F55A
        jsr $87FABC
        jsr $87FB94
        jsl rlLoadBufferedRAMAreaPointer

        ply
        plx
        plb
        rtl

        .databank 0

        ; 87/F559

    .endsection Unsorted87F515Section
