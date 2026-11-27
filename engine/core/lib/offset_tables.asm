; Offset tables, and an unused byte stack.

    .section CopyOffsetTableEntrySection

      .al
      .xl

      rlCopyOffsetTableEntry ; 82/F517

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unused: block-copy 1-based entry A from offset table lR18 to lR19 via MVN

        phy
        phb
        dec a
        asl a
        clc
        adc lR18
        tay
        sep #$20
        lda lR18+2
        pha
        sta lBlockCopySource+2,b
        rep #$20
        plb
        .databank ?
        lda $0002,b,y
        sec
        sbc $0000,b,y
        sta @l wBlockCopySize
        lda $0000,b,y
        plb
        .databank ?
        clc
        adc lR18
        sta lBlockCopySource,b
        lda lR19+1
        sta lBlockCopyDestination+1,b
        lda lR19
        sta lBlockCopyDestination,b
        jsl rlBlockCopyMVNByRAM
        ply
        rtl

        .databank 0

        ; 82/F54F

    .endsection CopyOffsetTableEntrySection

    .section Unreferenced82F54FSection

      .al
      .xl

      rlGetOffsetTableCountUnused ; 82/F54F

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: returns number of entries in offset table lR18

        phb
        php
        phk
        plb
        .databank $82
        phy
        ldy lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?
        lda $0000,b,y
        lsr a
        dec a
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 82/F567

    .endsection Unreferenced82F54FSection

    .section OffsetTableSection

      .al
      .xl

      rlAddOffsetTableEntry ; 82/F567

        .al
        .autsiz
        .databank ?

        ; At the given desination, builds a structure of a word offset to some data, and writes the source data there.
        ; New entries put their offset behind the last current offset, recalcs all the other offsets to match the new data, 
        ; and then adds its own data at the end.

        ; wR0  = size of data to write
        ; lR18 = destination (eg aFactionArea)
        ; lR19 = data source pointer

        phb
        php
        phk
        plb
        phy

        lda wR0
        pha

        ldy lR18

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        ; Check for existing offset
        lda $0000,b,y
        bne +

          ; If there is no offset, set it to minimal possible offset
          lda #2
          sta $0000,b,y
          lda #0
          bra ++

        +
        lsr a
        dec a
        pha
        sta $02
        lda #2
        sta wR0
        
        -
        lda $02
        jsl rlShiftOffsetTableEntry
        dec $02
        bne -

        pla
        asl a
        
        +
        clc
        adc lR18
        tay
        lda $0000,b,y
        clc
        adc #2
        sta $0000,b,y
        clc
        adc lR18
        sta lBlockCopyDestination,b

        sep #$20
        lda lR18+2
        sta lBlockCopyDestination+2,b
        rep #$20

        lda lR19+1
        sta lBlockCopySource+1,b
        lda lR19
        sta lBlockCopySource,b

        pla
        sta wR0
        sta wBlockCopySize,b

        jsl rlBlockCopyMVNByRAM

        lda $0000,b,y
        clc
        adc wR0
        sta $0002,b,y

        ply
        plp
        plb
        rtl

        .databank 0

      rlShiftOffsetTableEntry ; 82/F5DD

        .al
        .autsiz
        .databank ?

        ; This shifts data in a table back and adjusts all offsets to match the new locations

        ; A    = index of the offset to shift
        ; wR0  = value to shift the entries by
        ; lR18 = pointer to offset table

        phb
        php

        phk
        plb

        phy

        ldy wR1
        phy

        dec a
        asl a
        clc
        adc lR18
        tay

        sep #$20
        lda lR18+2
        sta lBlockCopySource+2,b
        sta lBlockCopyDestination+2,b
        pha
        rep #$20
        plb

        ; get last entries size

        lda $0002,b,y
        sec
        sbc $0000,b,y
        sta wR1

        lda wR0
        bpl +

          ; shift the entries backwards
          lda $0000,b,y
          clc
          adc lR18
          sta lBlockCopySource,b
          clc
          adc wR0
          sta lBlockCopyDestination,b
          lda wR1
          sta wBlockCopySize,b
          jsl rlBlockCopyMVNByRAM
          bra ++

          ; shift the entries forwards
          +
          lda $0002,b,y
          dec a
          clc
          adc lR18
          sta lBlockCopySource,b
          clc
          adc wR0
          sta lBlockCopyDestination,b
          lda wR1
          sta wBlockCopySize,b
          jsl rlBlockCopyMVPByRAM

        +
        lda $0000,b,y
        clc
        adc wR0
        sta $0000,b,y

        ply
        sty wR1

        ply
        plp
        plb
        rtl

        .databank 0

      rlInsertOffsetTableEntry ; 82/F649

        .al
        .autsiz
        .databank ?

        ; Insert wR0 bytes from lR19 at 1-based slot A of offset table lR18

        phb
        php
        phk
        plb
        phy

        sta wR3

        lda wR0
        sta wR4

        ldy lR18

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        lda $0000,b,y
        lsr a
        dec a
        sta wR1
        sta wR2

        lda #2
        sta wR0
        
          -
          lda wR2
          jsl rlShiftOffsetTableEntry
          dec wR2
          bne -

        lda wR1
        asl a
        clc
        adc lR18
        tay
        lda $0000,b,y
        clc
        adc #2
        sta $0000,b,y

        lda wR1
        inc a
        sec
        sbc wR3
        sta wR2
        
          -
          lda $0000,b,y
          sta $0002,b,y
          dec y
          dec y
          dec wR2
          bpl -

        lda wR1
        inc a
        sta wR2
        lda wR4
        sta wR0
        
          -
          lda wR2
          jsl rlShiftOffsetTableEntry
          dec wR2
          lda wR2
          cmp wR3
          bne -

        lda wR1
        asl a
        clc
        adc lR18
        tay
        lda $0002,b,y
        clc
        adc wR4
        sta $0002,b,y

        lda wR3
        dec a
        asl a
        clc
        adc lR18
        tay
        lda $0000,b,y
        clc
        adc lR18
        sta lBlockCopyDestination,b

        sep #$20
        lda lR18+2
        sta lBlockCopyDestination+2,b
        rep #$20

        lda lR19+1
        sta lBlockCopySource+1,b
        lda lR19
        sta lBlockCopySource,b
        lda wR4
        sta wBlockCopySize,b
        jsl rlBlockCopyMVNByRAM

        ply
        plp
        plb
        rtl

        .databank 0

      rlUpdateOffsetTable ; 82/F6F3

        .al
        .autsiz
        .databank ?

        ; If the size of an entry in an offset table changed, this shifts the entries after
        ; a specified offset ID around to account for it.

        ; A    = offset ID to start shifting
        ; wR0  = new size of last entry that doesn't get shifted
        ; lR18 = offset table pointer
        ; lR19 = last entry data replacement

        phb
        php
        phk
        plb
        phy

        sta wR3
        dec a
        asl a
        clc
        adc lR18
        tay

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        ; first offset in Y

        lda $0002,b,y
        sec
        sbc $0000,b,y
        sta wR4

        ; wR4 now holds the current length of the last, non shifting entry

        lda wR0
        pha
        sec
        sbc wR4
        sta wR4
        beq _FillWithReplacement

        ; wR4 now holds the shift amount
        ; branch if the offset ID to shift, is the free space offset

        ldy lR18
        lda $0000,b,y
        lsr a
        dec a
        pha
        cmp wR3
        beq _DoneShifting

        sta wR1 ; index of the free space offset

        lda wR4
        bmi +

          ; shift all entries forward
          lda wR4
          sta wR0

          -
          lda wR1
          jsl rlShiftOffsetTableEntry
          dec wR1

          lda wR1
          cmp wR3
          bne -
          bra _DoneShifting

        ; shift all entries backwards
        +
        lda wR3
        inc a
        sta wR2
        lda wR4
        sta wR0
        
          -
          lda wR2
          jsl rlShiftOffsetTableEntry
          inc wR2

          lda wR2
          cmp wR1
          bcc -
          beq -

        _DoneShifting
        ; Update the free space offset 

        pla
        asl a
        clc
        adc lR18
        tay
        lda $0000,b,y
        clc
        adc wR4
        sta $0000,b,y

        lda lR19
        ora lR19+1
        bne _FillWithReplacement

          pla
          bra _End

        _FillWithReplacement
        lda wR3 ; free space ID
        dec a
        asl a
        clc
        adc lR18
        tay
        lda $0000,b,y
        clc
        adc lR18
        sta lBlockCopyDestination,b
        sep #$20
        lda lR18+2
        sta lBlockCopyDestination+2,b
        rep #$20

        lda lR19+1
        sta lBlockCopySource+1,b
        lda lR19
        sta lBlockCopySource,b

        pla
        sta wBlockCopySize,b
        jsl rlBlockCopyMVNByRAM
        
        _End
        ply
        plp
        plb
        rtl

        .databank 0

        ; 82/F7A2

    .endsection OffsetTableSection

    .section Unreferenced82F7A2Section

      .al
      .xl

      rlRemoveOffsetTableEntryUnused ; 82/F7A2

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: removes 1-based entry A from offset table at lR18

        phb
        php
        phk
        plb
        .databank $82
        phy
        sta wR3
        dec a
        asl a
        clc
        adc lR18
        tay
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?
        lda $0002,b,y
        sec
        sbc $0000,b,y
        sta wR4
        ldy lR18
        lda $0000,b,y
        lsr a
        dec a
        sta wR1
        lda wR3
        inc a
        cmp wR1
        bcs _F7EA
        sta wR2
        lda wR4
        eor #$FFFF
        inc a
        sta wR0

        _F7DA
        lda wR2
        jsl rlShiftOffsetTableEntry
        inc wR2
        lda wR2
        cmp wR1
        bcc _F7DA
        beq _F7DA

        _F7EA
        lda wR1
        asl a
        clc
        adc lR18
        tay
        lda $0000,b,y
        sec
        sbc wR4
        sta $0000,b,y
        lda wR3
        asl a
        clc
        adc lR18
        tay
        lda wR1
        sec
        sbc wR3
        beq _F816
        sta wR2

        _F80A
        lda $0002,b,y
        sta $0000,b,y
        inc y
        inc y
        dec wR2
        bne _F80A

        _F816
        dec wR1
        lda #$0001
        sta wR2
        lda #$FFFE
        sta wR0

        _F822
        lda wR2
        jsl rlShiftOffsetTableEntry
        inc wR2
        lda wR2
        cmp wR1
        bcc _F822
        beq _F822
        lda wR1
        asl a
        clc
        adc lR18
        tay
        lda $0000,b,y
        sec
        sbc #$0002
        sta $0000,b,y
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 82/F847

      rlCopyAllOffsetTableEntriesUnused ; 82/F847

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: copies wR1 entries from offset table lR18 to lR19

        phb
        php
        phk
        plb
        .databank $82
        lda #$0001
        sta wR2

        _F850
        lda wR2
        jsl rlCopyOffsetTableEntry
        lda lR19
        clc
        adc wR0
        sta lR19
        inc wR2
        dec wR1
        bne _F850
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/F866

    .endsection Unreferenced82F7A2Section

    .section Unreferenced82EB4CSection

      .al
      .xl

      rlInitByteStackAreaUnused ; 82/EB4C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: initializes byte stack area at lR18 and sets $055F pointer

        phb
        php
        phk
        plb
        .databank $82
        jsl rlSetByteStackAreaPointerUnused
        ldy lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?
        lda wR1
        beq _EB6B
        and #$1FFF
        ora #$8000
        sta $0002,b,y

        _EB6B
        lda wR0
        sta $0000,b,y
        inc a
        sta $0004,b,y
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 82/EB77

        ; Unreachable: it follows a return.
        rtl

      rlPushByteStackAreaUnused ; 82/EB78

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: works on the RAM area whose pointer is at $055F (see
        ; rlPushByteStackAreaPointerUnused): takes wR1 bytes from it, filled from [lR18] or with 0.
        ; Carry set if there is not enough.

        phb
        php
        phk
        plb
        .databank $82
        phx
        phy
        lda wR1
        pha
        ldy $055F,b
        sep #$20
        lda $0561,b
        pha
        rep #$20
        plb
        .databank ?
        lda $0002,b,y
        bit #$8000
        beq _EB9A
        and #$1FFF
        sta wR1

        _EB9A
        lda $0000,b,y
        cmp wR1
        bcc _EBF7
        tax
        sec
        sbc wR1
        sta $0000,b,y
        txa
        clc
        adc @l $00055F
        tax
        dec x
        ldy wR1
        dec y
        lda lR18
        ora lR18+1
        beq _EBC8
        sep #$20

        _EBBB
        lda [lR18],y
        sta $0006,b,x
        dec x
        dec y
        bpl _EBBB
        rep #$20
        bra _EBD5


        _EBC8
        sep #$20
        lda #$00

        _EBCC
        sta $0006,b,x
        dec x
        dec y
        bpl _EBCC
        rep #$20

        _EBD5
        lda @l $00055F
        tay
        lda @l $000560
        sta lR18+1
        lda @l $00055F
        clc
        adc $0000,b,y
        clc
        adc #$0006
        sta lR18
        pla
        sta wR1
        ply
        plx
        plp
        plb
        .databank ?
        clc
        rtl


        _EBF7
        pla
        sta wR1
        ply
        plx
        plp
        plb
        .databank ?
        sec
        rtl

        .databank 0

        ; 82/EC00

      rlPopByteStackAreaUnused ; 82/EC00

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: works on the same RAM area; carry set if wR1 more bytes
        ; do not fit.

        phb
        php
        phk
        plb
        .databank $82
        phx
        phy
        lda wR1
        pha
        ldy $055F,b
        sep #$20
        lda $0561,b
        pha
        rep #$20
        plb
        .databank ?
        lda $0002,b,y
        bit #$8000
        beq _EC22
        and #$1FFF
        sta wR1

        _EC22
        lda $0000,b,y
        clc
        adc wR1
        cmp $0004,b,y
        bcs _EC56
        sta $0000,b,y
        clc
        adc @l $00055F
        tax
        dec x
        ldy wR1
        dec y
        lda lR18
        ora lR18+1
        beq _EC4D
        sep #$20

        _EC42
        lda $0006,b,x
        sta [lR18],y
        dec x
        dec y
        bpl _EC42
        rep #$20

        _EC4D
        pla
        sta wR1
        ply
        plx
        plp
        plb
        .databank ?
        clc
        rtl


        _EC56
        pla
        sta wR1
        ply
        plx
        plp
        plb
        .databank ?
        sec
        rtl

        .databank 0

        ; 82/EC5F

      rlGetByteStackAreaPointerUnused ; 82/EC5F

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: sets lR18 to the pointer at $055F.

        phb
        php
        phk
        plb
        .databank $82
        lda $0560,b
        sta lR18+1
        lda $055F,b
        sta lR18
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/EC70

    .endsection Unreferenced82EB4CSection

    .section Unreferenced82EC70Section

      .al
      .xl

      rlSetByteStackAreaPointerUnused ; 82/EC70

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Sets $055F byte stack area pointer to lR18

        phb
        php
        phk
        plb
        .databank $82
        lda lR18+1
        sta $0560,b
        lda lR18
        sta $055F,b
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/EC81

      rlPushByteStackAreaPointerUnused ; 82/EC81

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: copies the pointer at $055F to $0562 and sets $055F
        ; to lR18.

        phb
        php
        phk
        plb
        .databank $82
        lda $0560,b
        sta $0563,b
        lda $055F,b
        sta $0562,b
        lda lR18+1
        sta $0560,b
        lda lR18
        sta $055F,b
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/EC9E

      rlPopByteStackAreaPointerUnused ; 82/EC9E

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced: if $0562 is not 0, copies it back to $055F.

        phb
        php
        phk
        plb
        .databank $82
        lda $0562,b
        ora $0563,b
        beq _ECB6
        lda $0563,b
        sta $0560,b
        lda $0562,b
        sta $055F,b

        _ECB6
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/ECB9

    .endsection Unreferenced82EC70Section
