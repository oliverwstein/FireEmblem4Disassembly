; The RAM-area heap: blocks of RAM split into entries that are allocated, freed,
; merged and compacted, some reached through handles so they can move.

    .section RAMAreaHeaderSection

      .al
      .xl

      rlBuildRAMAreaHeaderAndGuidingEntry ; 82/ECB9

        .al
        .autsiz
        .databank ?

        ; A   = area size
        ; lR18 = ram area pointer
        ; wStructIndex = ?

        phb
        php

        phk
        plb

        tay
        phy

        lda wR0
        pha

        sty wR0
        jsl rlLoadRAMAreaPointer

        ldy lR18

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        sep #$20
        lda wStructIndex,b
        beq +

          lda #$80

        +
        sta structRAMAreaHeader.Flags,b,y
        bne +

        lda wUnknown00056B
        bra ++

        +
        lda #0

        +
        sta structRAMAreaHeader.Unknown2,b,y
        rep #$20

        lda wR0
        clc
        adc lRAMAreaPointer
        sta structRAMAreaHeader.AreaEnd,b,y

        lda wR0
        sec
        sbc #size(structRAMAreaHeader)
        sta wR0
        sta structRAMAreaHeader.AreaSize,b,y

        phy

        tya
        clc
        adc #size(structRAMAreaHeader)
        tay

        jsr rsFreeRAMAreaEntryHeader
        jsr rsSaveOffsetToRAMAreaEntry

        ply

        jsr rsAllocateRAMAreaHandleBlock
        sta structRAMAreaHeader.Unknown3,b,y

        pla
        sta wR0

        ply
        plp
        plb
        rtl

        .databank 0

      rlRAMAreaStub ; 82/ED1D

        .al
        .autsiz
        .databank ?

        ; Empty rtl stub in RAMAreaHeaderSection

        phb
        php
        phk
        plb

        plp
        plb
        rtl

        .databank 0

      rlAllocateRAMAreaWithHandle ; 82/ED24

        .al
        .autsiz
        .databank ?

        ; Allocate A bytes in lRAMAreaPointer backed by a relocatable handle slot

        phb
        php
        phk
        plb
        phy
        tay

        lda $00
        pha
        lda $02
        pha
        lda $04
        pha

        sty $00
        lda lRAMAreaPointer,b
        ora lRAMAreaPointer+1,b
        beq _EDB1

        lda $00
        clc
        adc #6
        sta $00

        ldy lRAMAreaPointer,b

        sep #$20
        lda $0565+2,b
        pha
        rep #$20
        plb

        jsr rsFindOrAllocateRAMAreaHandle
        bcs _EDB6

        sta $02
        sep #$20
        lda $0000,b,y
        ora #$20
        sta $0000,b,y
        rep #$20

        jsr rsFindFreeRAMAreaEntry
        tay
        jsr rsUpdateRAMAreaHandle

        lda $0001,b,y
        sec
        sbc $00
        pha
        jsr rsInitManagedRAMAreaEntry
        jsr rsSaveOffsetToRAMAreaEntry
        pla
        pha
        cmp #7
        bcs +

        pla
        clc
        adc $0001,b,y
        sta $0001,b,y
        bra ++
        
        +
        jsr rsGetRAMAreaEntryOffset
        tay
        jsr rsFreeRAMAreaEntryHeader
        pla
        sta $0001,b,y
        
        +
        phk
        plb
        lda $000566
        sta $3A

        lda $02
        sta $39
        ldy #0
        
        -
        pla
        sta $04
        pla
        sta $02
        pla
        sta $00

        tya
        ply
        plp
        plb
        rtl

        _EDB1
        ldy #$FFFF
        bra -

        _EDB6
        ldy #$FFFE
        bra -

        .databank 0

        ; 82/EDBB

    .endsection RAMAreaHeaderSection

    .section Unreferenced82EDBBSection

      .al
      .xl

      rlFreeRAMAreaByHandleUnused ; 82/EDBB

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: dereferences 3-byte handle at [lR25], marks entry $80, frees header and coalesces

        phb
        php
        phk
        plb
        .databank $82
        phy
        ldy lR25
        sep #$20
        lda lR25+2
        pha
        rep #$20
        plb
        .databank ?
        tya
        sec
        sbc #$0000
        tay
        lda $0001,b,y
        sta lR25+1
        lda $0000,b,y
        sta lR25
        jsr rsMarkRAMAreaEntryFreeFlagUnused
        jsr rsFreeSpecifiedRAMAreaEntryHeader
        jsr rsCombineAdjacentFreeRAMAreaEntries
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 82/EDE7

    .endsection Unreferenced82EDBBSection

    .section RAMAreaSection

      .al
      .xl

      rlAllocateRAMArea ; 82/EDE7

        .al
        .autsiz
        .databank ?

        ; This reserves space in a RAM area with the size of a specified RAM struct entry + the RAM area entry header

        ; Input:
        ; wR0 = size
        ; lRAMAreaPointer = RAM pointer

        ; Output:
        ; lR25 = RAM entry

        phb
        php

        phk
        plb

        phy
        tay

        lda wR0
        pha
        lda wR2
        pha

        sty wR0

        ; Checks if pointer exists
        lda lRAMAreaPointer,b
        ora lRAMAreaPointer+1,b
        beq _End

        lda wR0
        clc
        adc #size(structRAMAreaEntryHeader)
        sta wR0

        ldy lRAMAreaPointer,b

        sep #$20
        lda lRAMAreaPointer+2,b
        pha
        rep #$20
        plb

        sep #$20
        lda structRAMAreaHeader.Flags,b,y
        ora #$20
        sta structRAMAreaHeader.Flags,b,y
        rep #$20

        ; Check for free entry
        jsr rsFindFreeRAMAreaEntry

        ; Load max size, subtract requested size
        tay
        lda structRAMAreaEntryHeader.Offset,b,y
        sec
        sbc wR0
        sta structRAMAreaEntryHeader.Offset,b,y

        cmp #7
        bcs +

          clc
          adc wR0
          sta wR0
          bra ++

        +
        jsr rsGetRAMAreaEntryOffset
        tay

        +
        jsr rsAddNewRAMAreaEntry
        jsr rsSaveOffsetToRAMAreaEntry

        phk
        plb

        lda lRAMAreaPointer+1,b
        sta lR25+1
        tya
        clc
        adc #size(structRAMAreaEntryHeader)
        sta lR25
        
        _End
        ldy #0

        pla
        sta wR2
        pla
        sta wR0

        tya
        ply

        plp
        plb
        rtl

        .databank 0

      rlRemoveRAMAreaEntry ; 82/EE5C

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lR25 = pointer to a RAM area entry
        ; filled lRAMAreaPointer 

        phb
        php
        phk
        plb

        sep #$20
        lda lRAMAreaPointer+2,b
        pha
        rep #$20
        plb

        jsr rsFreeSpecifiedRAMAreaEntryHeader
        jsr rsCombineAdjacentFreeRAMAreaEntries

        plp
        plb
        rtl

        .databank 0

      rlCopyDataToRAMArea ; 82/EE72

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = size
        ; X = source
        ; lR25 = destination

        phb
        php
        phk
        plb
        phx
        phy

        dec a
        pha
        clc
        adc $0000,b,x
        pha

        sep #$20
        lda $0000+2,b,x
        pha
        rep #$20
        plb

        plx
        ply

        sep #$20
        
          -
          lda $0000,b,x
          sta [lR25],y
          dec x
          dec y
          bpl -

        rep #$20
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlCopyDataToRAMAreaHandle ; 82/EE9C

        .al
        .autsiz
        .databank ?

        ; Copy A bytes from [X] into dereferenced RAMArea handle [lR25]

        phb
        php
        phk
        plb
        phx
        phy

        dec a
        pha
        clc
        adc $0000,b,x
        pha

        sep #$20
        lda $0000+2,b,x
        pha
        rep #$20
        plb

        lda [lR25]
        sta lR24
        inc lR25
        lda [lR25]
        sta lR24+1
        dec lR25
        plx
        ply

        sep #$20

          -
          lda $0000,b,x
          sta [lR24],y
          dec x
          dec y
          bpl -

        rep #$20
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlCompactRAMArea ; 82/EED2

        .al
        .autsiz
        .databank ?

        ; Defragment lRAMAreaPointer by sliding handle-managed blocks over free gaps

        phb
        php

        phk
        plb

        phx
        phy

        lda wR1
        pha
        lda wR2
        pha
        lda wR3
        pha
        lda wR4
        pha

        ldy lRAMAreaPointer,b

        sep #$20
        lda lRAMAreaPointer+2,b
        pha
        rep #$20
        plb

        sep #$20
        lda structRAMAreaHeader.Flags,b,y
        ora #$40
        sta structRAMAreaHeader.Flags,b,y
        rep #$20

        lda structRAMAreaHeader.AreaEnd,b,y
        sta $04

        tya
        clc
        adc #size(structRAMAreaHeader)
        tay

        _Loop
        lda structRAMAreaEntryHeader.Flags,b,y
        bit #$0080
        beq _EF48

          jsr rsGetRAMAreaEntryOffset
          tax
          lda $0000,b,x
          bit #$0040
          bne _EF48

          lda $0003,b,x
          sta wR1
          jsr rsUpdateRAMAreaHandle

          lda $0001,b,y
          sta wR4
          lda $0001,b,x
          sta wR3
          
          -
          sep #$20
          lda $0000,b,x
          sta $0000,b,y
          rep #$20

          inc x
          inc y
          dec wR3
          bne -

          jsr rsFreeRAMAreaEntryHeader

          lda wR4
          sta $0001,b,y
          jsr rsCombineAdjacentFreeRAMAreaEntries

        _EF48
        jsr rsGetRAMAreaEntryOffset
        tay
        cpy wR2
        bcc _Loop

        pla
        sta wR4
        pla
        sta wR3
        pla
        sta wR2
        pla
        sta wR1

        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rlSaveRAMAreaPointer ; 82/EF61

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        lda lRAMAreaPointer+1,b
        sta lR18+1
        lda lRAMAreaPointer,b
        sta lR18

        plp
        plb
        rtl

        .databank 0

      rlLoadRAMAreaPointer ; 82/EF72

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        lda lR18+1
        sta lRAMAreaPointer+1,b
        lda lR18
        sta lRAMAreaPointer,b

        plp
        plb
        rtl

        .databank 0

      rlBufferAndLoadNewRAMAreaPointer ; 82/EF83

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        lda lRAMAreaPointer+1,b
        sta lRAMAreaPointerBuffer+1,b
        lda lRAMAreaPointer,b
        sta lRAMAreaPointerBuffer,b

        lda lR18+1
        sta lRAMAreaPointer+1,b
        lda lR18
        sta lRAMAreaPointer,b

        plp
        plb
        rtl

        .databank 0

      rlLoadBufferedRAMAreaPointer ; 82/EFA0

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda lRAMAreaPointerBuffer,b
        ora lRAMAreaPointerBuffer+1,b
        beq +

          lda lRAMAreaPointerBuffer+1,b
          sta lRAMAreaPointer+1,b
          lda lRAMAreaPointerBuffer,b
          sta lRAMAreaPointer,b

        +
        plp
        plb
        rtl

        .databank 0

      rlClearRAMAreaEmptyFlag ; 82/EFBB

        .al
        .autsiz
        .databank ?

        ; Clear bit $80 of structRAMAreaHeader.Flags and return previous flags in A

        phb
        php
        phk
        plb
        phy

        ldy lRAMAreaPointer,b

        sep #$20
        lda lRAMAreaPointer+2,b
        pha
        rep #$20
        plb

        lda structRAMAreaHeader.Flags,b,y
        and #$00FF
        pha
        sep #$20
        and #$7F
        sta structRAMAreaHeader.Flags,b,y
        rep #$20

        pla
        ply
        plp
        plb
        rtl

        .databank 0

      rsFreeRAMAreaEntryHeader ; 82/EFE1

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #$80
        sta structRAMAreaEntryHeader.Flags,b,y
        rep #$20
        lda #0
        sta structRAMAreaEntryHeader.BaseTable+1,b,y
        sta structRAMAreaEntryHeader.BaseTable,b,y
        rts

        .databank 0

      rsAddNewRAMAreaEntry ; 82/EFF4

        .al
        .autsiz
        .databank ?

        sep #$20
        lda #$40
        sta structRAMAreaEntryHeader.Flags,b,y
        rep #$20

        lda lRAMAreaPointer+1
        sta structRAMAreaEntryHeader.BaseTable+1,b,y
        lda lRAMAreaPointer
        sta structRAMAreaEntryHeader.BaseTable,b,y
        rts

        .databank 0

      rsInitManagedRAMAreaEntry ; 82/F00C

        .al
        .autsiz
        .databank ?

        ; Initialize handle-managed structRAMAreaEntryHeader (Flags=0, BaseTable=handle)

        sep #$20
        lda #0
        sta $0000,b,y
        rep #$20

        lda $000566
        sta $0003+1,b,y
        lda wR1
        sta $0003,b,y
        rts

        .databank 0

      rsSaveOffsetToRAMAreaEntry ; 82/F022

        .al
        .autsiz
        .databank ?

        lda wR0
        sta structRAMAreaEntryHeader.Offset,b,y
        rts

        .databank 0

      rsSaveDataSizePlusHeaderToRAMAreaEntry ; 82/F028

        .al
        .autsiz
        .databank ?

        ; Write wR0 + 6 (data + entry header size) to structRAMAreaEntryHeader.Offset

        lda wR0
        clc
        adc #6
        sta $0001,b,y
        rts

        .databank 0

      rsFindFreeRAMAreaEntry ; 82/F032

        .al
        .autsiz
        .databank ?

        ; Find free RAMArea block >= wR0, compacting on retry or crashing on OOM

        jsr rsCheckIfEntryFitsInRAMArea
        bcs +
        
        -
        rts
        
        ; All slots are filled
        +
        jsl rlCompactRAMArea
        jsr rsCheckIfEntryFitsInRAMArea
        bcs +
        bra -

        +
        sep #$20
        lda #$3F
        sta CGADSUB
        lda #$32
        sta COLDATA
        lda #$C0
        sta COLDATA
        rep #$20
        .byte 0

        .databank 0

      rsCheckIfEntryFitsInRAMArea ; 82/F05A

        .al
        .autsiz
        .databank ?

        ; wR0 = size

        phy
        lda structRAMAreaHeader.AreaEnd,b,y
        sta wR2

        tya
        clc
        adc #size(structRAMAreaHeader)
        tay

        -
        lda structRAMAreaEntryHeader.Flags,b,y
        bit #$0080
        beq +

        ; Is a guiding entry
        lda structRAMAreaEntryHeader.Offset,b,y
        cmp wR0
        bcs ++

        ; Entry isnt a guiding one, or space isnt enough for entry
        +
        tya
        clc
        adc structRAMAreaEntryHeader.Offset,b,y
        tay
        cpy wR2
        bcc -

        ; Entry doesnt fit
        ply
        sec
        rts

        ; Entry fits
        +
        tya
        ply
        clc
        rts

        .databank 0

      rsGetRAMAreaEntryOffset ; 82/F086

        .al
        .autsiz
        .databank ?

        ; Input:
        ; Y = RAM are entry

        tya
        clc
        adc structRAMAreaEntryHeader.Offset,b,y
        rts

        .databank 0

      rsFreeSpecifiedRAMAreaEntryHeader ; 82/F08C

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lR25 = pointer to a RAM area entry
        ; filled lRAMAreaPointer 

        phb
        php
        phk
        plb
        phy
        lda wR2
        pha

        lda lR25
        sec
        sbc #size(structRAMAreaEntryHeader)
        sta wR2

        lda lRAMAreaPointer,b
        ora lRAMAreaPointer+1,b
        beq _End

          sep #$20
          lda lRAMAreaPointer+2,b
          cmp lR25+2
          bne _End

            rep #$20
            lda wR2
            cmp lRAMAreaPointer,b
            bcc _End

              ldy lRAMAreaPointer,b

              sep #$20
              lda lRAMAreaPointer+2,b
              pha
              rep #$20
              plb

              lda structRAMAreaHeader.AreaEnd,b,y
              dec a
              cmp wR2
              bcc _End

                ldy wR2
                jsr rsFreeRAMAreaEntryHeader

                lda lRAMAreaPointer
                tay
                sep #$20
                lda structRAMAreaHeader.Flags,b,y
                ora #$10
                sta structRAMAreaHeader.Flags,b,y

        _End
        rep #$20
        ldy #0

        pla
        sta wR2
        tya
        ply
        plp
        plb
        rts

        .databank 0

      rsCombineAdjacentFreeRAMAreaEntries ; 82/F0EB

        .al
        .autsiz
        .databank ?

        phx
        phy
        lda wR2
        pha

        lda lRAMAreaPointer
        tay
        lda structRAMAreaHeader.AreaEnd,b,y
        sta wR2

        tya
        clc
        adc #size(structRAMAreaHeader)
        tay

        ; First check for any entry that is marked as free
        _OuterLoop
        lda structRAMAreaEntryHeader.Flags,b,y
        bit #$0080
        beq +

          ; Now check if that entry points within the RAM area
          _InnerLoop
          jsr rsGetRAMAreaEntryOffset
          tax
          cpx wR2
          bcs _End

            ; It is, check if the entry afterwards also is marked as free
            lda structRAMAreaHeader.Flags,b,x
            bit #$0080
            beq +

              ; Add the offset of the following entry to the current one
              lda structRAMAreaEntryHeader.Offset,b,y
              clc
              adc structRAMAreaEntryHeader.Offset,b,x
              sta structRAMAreaEntryHeader.Offset,b,y

              ; And remove the following entry
              lda #0
              sta structRAMAreaEntryHeader.Flags,b,x
              sta structRAMAreaEntryHeader.Offset,b,x
              sta structRAMAreaEntryHeader.BaseTable+1,b,x
              sta structRAMAreaEntryHeader.BaseTable,b,x
              bra _InnerLoop

            +
            tya
            clc
            adc structRAMAreaEntryHeader.Offset,b,y
            tay
            cpy wR2
            bcc _OuterLoop

        _End
        pla
        sta wR2

        ply
        plx
        rts

        .databank 0

      rsAllocateRAMAreaHandleBlock ; 82/F143

        .al
        .autsiz
        .databank ?

        ; Allocate and initialize a linked block of Unknown2 4-byte handle slots

        phy
        lda wR0
        pha
        lda wR3
        pha

        lda structRAMAreaHeader.Unknown2,b,y
        and #$00FF
        beq _End

          sta wR3
          asl a
          asl a
          clc
          adc #3
          sta wR0
          jsl rlAllocateRAMArea

          ldy lR25
          lda #0
          sta $0000,b,y

          sep #$20
          lda wR3
          sta $0002,b,y
          rep #$20

          ldx wR3

          -
          sep #$20
          lda #$80
          sta $0006,b,y
          rep #$20

          tya
          clc
          adc #4
          tay
          dec x
          bne -

          pla
          sta wR3
          pla
          sta wR0

          lda lR25
          ply
          rts

        _End
        pla
        sta wR3
        pla
        sta wR0

        lda #0
        ply
        rts

        .databank 0

      rsFindOrAllocateRAMAreaHandle ; 82/F19A

        .al
        .autsiz
        .databank ?

        ; Return free 4-byte handle slot in handle block list, allocating a block if full

        phx
        phy
        lda $0006,b,y
        beq _SEC

          tay

            _OuterLoop
            phy
            lda $0002,b,y
            and #$00FF
            beq _Next

              tax
              tya
              clc
              adc #3
              tay
              
                _InnerLoop
                lda $0003,b,y
                bit #$0080
                bne _CLC

                  tya
                  clc
                  adc #4
                  tay
                  dec x
                  bne _InnerLoop

            _Next
            ply
            lda $0000,b,y
            beq +

              tay
              bra _OuterLoop

          +
          tyx
          lda lRAMAreaPointer
          tay
          jsr rsAllocateRAMAreaHandleBlock
          sta $0000,b,x
          clc
          adc #3
          ply
          plx
          clc
          rts

          _CLC
          tya
          ply
          ply
          plx
          clc
          rts

        _SEC
        ply
        plx
        sec
        rts

        .databank 0

      rsUpdateRAMAreaHandle ; 82/F1EA

        .al
        .autsiz
        .databank ?

        ; Write data address (Y+6), bank ($0567), and active status 0 into handle [wR1]

        phx
        ldx wR1
        sep #$20
        lda #0
        sta $0003,b,x
        rep #$20

        lda $00566
        sta $0001,b,x
        tya
        clc
        adc #6
        sta $0000,b,x
        plx
        rts

        .databank 0

        ; 82/F207

    .endsection RAMAreaSection

    .section Unreferenced82F207Section

      .al
      .xl

      rsMarkRAMAreaEntryFreeFlagUnused ; 82/F207

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bit 7 ($80) on byte $03 of RAM area entry header at Y

        sep #$20
        lda #$80
        sta $0003,b,y
        rep #$20
        rts

        .databank 0

        ; 82/F211

    .endsection Unreferenced82F207Section
