; Generic RAM structures: struct arrays, RAM areas and offset tables.

    .section RAMStructSection

      .al
      .xl

      rlBuildRAMStructHeader ; 82/E41B

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR0 = struct count
        ; wR1 = struct size

        ; lR18 = dest pointer

        phb
        php

        phk
        plb

        phx
        phy

        ldy lR18

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        sep #$20
        lda wR1
        beq _End

        sta structRAMStructHeader.StructSize,b,y

        cmp #4
        bcc +

          ; struct size is more than 4?
          dec wR0

        +
        lda wR0
        beq _End

        sta structRAMStructHeader.MaxStructCount,b,y

        lda #0
        sta structRAMStructHeader.CurrentStructCount,b,y

        lda wR1
        tax
        cpx #4
        bcs +

        lda aRAMStructSmallSizeFlags,x
        bra ++

        +
        lda #3

        +
        sta structRAMStructHeader.Unknown,b,y
        rep #$20
        
        _End
        ply
        plx

        plp
        plb
        rtl

        .databank 0

      aRAMStructSmallSizeFlags ; 82/E460

        .byte 0
        .byte 0
        .byte 1
        .byte 2

      rlRAMStructStub ; 82/E464

        .al
        .autsiz
        .databank ?

        ; Empty rtl stub in RAMStructSection

        rtl

        .databank 0

      rlAppendNewStructEntry ; 82/E465

        .al
        .autsiz
        .databank ?

        ; lStructPointer1 source
        ; lStructPointer2 dest

        ; Gets the struct size of the destination on its own

        ; Returns clc if success, else return sec

        jsl rlGetRAMStructCurrentStructCount
        inc a
        sta wStructIndex

        jsl rlAddStructEntry
        lda wStructIndex

        rtl

        .databank 0

      rlWriteToFirstStructEntry ; 82/E477

        .al
        .autsiz
        .databank ?

        lda #1
        sta wStructIndex
        jsl rlAddStructEntry
        rtl

        .databank 0

      rlRemoveRAMStructEntry ; 82/E483

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lStructPointer1 = RAM struct entry
        ; lStructPointer2 = RAM struct area to remove it from

        ; Output:
        ; CLC if successful, SEC if not

        phb
        phk
        plb
        jsl rlFindRAMStructEntry
        sta wStructIndex,b
        jsl rlRemoveRAMStructEntryByID
        plb
        rtl

        .databank 0

      rlRemoveRAMStructEntryByID ; 82/E493

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wStructIndex = the entry to remove (1 indexed)
        ; lStructPointer2 = the RAM struct to remove it from

        ; Output:
        ; CLC if successful, SEC if not

        phb
        php
        phk
        plb
        phx
        phy

        ldx lStructPointer2,b
        sep #$20
        lda lStructPointer2+2,b
        pha
        rep #$20
        plb

        lda structRAMStructHeader.Unknown,b,x
        bit #$0080
        bne _CLC

        lda structRAMStructHeader.StructSize,b,x
        and #$00FF
        sta wStructSize
        sep #$20

        lda wStructIndex
        beq _SEC

        cmp structRAMStructHeader.CurrentStructCount,b,x
        bcc +
        beq _LastEntry
        bra _SEC

        ; The entry we want to remove is somewhere in the middle,
        ; so get the offset of the entry and shift all the following
        ; data over it.
        +
        phx
        lda structRAMStructHeader.CurrentStructCount,b,x
        rep #$20
        and #$00FF
        sec
        sbc wStructIndex
        inc a
        jsr rsGetRAMStructOffset
        sta wStructIndexAlternate

        lda wStructIndex
        jsr rsGetRAMStructOffset
        clc
        adc lStructPointer2
        tax
        clc
        adc wStructSize
        tay

          -
          sep #$20
          lda $0000 + size(structRAMStructHeader),b,y
          sta $0000 + size(structRAMStructHeader),b,x
          rep #$20
          inc y
          inc x
          lda wStructIndexAlternate
          dec a
          sta wStructIndexAlternate
          bne -

        plx

        _LastEntry
        ; If the entry we want to remove is the last one, 
        ; simply reduce the count by one and call it a day.
        rep #$20
        lda structRAMStructHeader.CurrentStructCount,b,x
        dec a
        sta structRAMStructHeader.CurrentStructCount,b,x

        _CLC
        ply
        plx
        plp
        plb
        clc
        rtl

        _SEC
        ; The entry we want to remove either doesnt exist, 
        ; or its ID is above the max struct count.
        rep #$20
        ply
        plx
        plp
        plb
        sec
        rtl

        .databank 0

      rlInsertRAMStructEntryAfter ; 82/E520

        .al
        .autsiz
        .databank ?

        ; Insert $054D entry immediately after match of lStructPointer1

        phb
        phk
        plb
        jsl rlFindRAMStructEntry
        inc a
        sta wStructIndex,b

        pha
        lda $054D+1,b
        sta lStructPointer1+1,b
        lda lPendingStructEntryPointer,b
        sta lStructPointer1,b
        jsl rlAddStructEntry
        pla

        plb
        rtl

        .databank 0

      rlInsertRAMStructEntryAt ; 82/E53F

        .al
        .autsiz
        .databank ?

        ; Insert $054D entry at matched index of lStructPointer1, shifting entries up

        phb
        phk
        plb
        jsl rlFindRAMStructEntry
        sta wStructIndex,b

        pha
        lda $054D+1,b
        sta lStructPointer1+1,b
        lda lPendingStructEntryPointer,b
        sta lStructPointer1,b
        jsl rlAddStructEntry
        pla

        plb
        rtl

        .databank 0

      rlAddStructEntry ; 82/E55D

        .al
        .autsiz
        .databank ?

        ; wStructIndex = struct to write to

        phb
        php

        phk
        plb

        phx
        phy

        ldx lStructPointer2,b

        sep #$20
        lda lStructPointer2+2,b
        pha
        rep #$20
        plb

        lda structRAMStructHeader.Unknown,b,x
        bit #$0080
        bne _CLC

        lda structRAMStructHeader.StructSize,b,x
        and #$00FF
        sta wStructSize

        sep #$20
        lda structRAMStructHeader.CurrentStructCount,b,x
        sta $000552

        cmp structRAMStructHeader.MaxStructCount,b,x
        bcs _SEC

        cmp wStructIndex
        bcc _AppendNewEntry

        ; When adding an entry in the middle, shift all the data after the selected entry back
        ; so the new data can be written to the selected slot

        phx
        rep #$20
        and #$00FF
        sec
        sbc wStructIndex
        inc a
        inc a
        jsr rsGetRAMStructOffset
        sta wStructIndexAlternate

        lda $000552
        and #$00FF
        jsr rsGetRAMStructOffset
        clc
        adc lStructPointer2
        clc
        adc wStructSize
        tay

        clc
        adc wStructSize
        tax

        sep #$20
        
        -
        lda $0003,b,y
        sta $0003,b,x
        dec y
        dec x
        lda wStructIndexAlternate
        dec a
        sta wStructIndexAlternate
        bne -

        plx
        bra +
        
        _AppendNewEntry
        inc a
        sta wStructIndex
        
        +
        rep #$20
        lda wStructIndex
        jsr rsSaveDataToRAMStruct

        lda structRAMStructHeader.CurrentStructCount,b,x
        inc a
        sta structRAMStructHeader.CurrentStructCount,b,x
        
        _CLC
        ply
        plx
        plp
        plb
        clc
        rtl

        _SEC
        rep #$20
        ply
        plx
        plp
        plb
        sec
        rtl

        .databank 0

        ; 82/E5FF

    .endsection RAMStructSection


    .section RAMStructAccessSection

      .al
      .xl

      rlGetRAMStructCurrentStructCount ; 82/E747

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phy
        ldy lStructPointer2,b

        sep #$20
        lda lStructPointer2+2,b
        pha
        rep #$20
        plb

        lda structRAMStructHeader.CurrentStructCount,b,y
        and #$00FF

        ply
        plp
        plb
        rtl

        .databank 0

      rlGetRAMStructMaxStructCount ; 82/E762

        .al
        .autsiz
        .databank ?

        ; Return structRAMStructHeader.MaxStructCount of lStructPointer2

        phb
        php
        phk
        plb
        phy

        ldy lStructPointer2,b

        sep #$20
        lda lStructPointer2+2,b
        pha
        rep #$20
        plb

        lda $0001,b,y
        and #$00FF

        ply
        plp
        plb
        rtl

        .databank 0

      rlSetRAMStructMaxStructCount ; 82/E77D

        .al
        .autsiz
        .databank ?

        ; Set MaxStructCount to A if A >= CurrentStructCount, else return sec

        phb
        php
        phk
        plb
        phy
        pha

        ldy lStructPointer2,b

        sep #$20
        lda lStructPointer2+2,b
        pha
        rep #$20
        plb

        pla
        sep #$20
        cmp $0000,b,y
        bcc _SEC

        sta $0001,b,y
        rep #$20
        ply
        plp
        plb
        clc
        rtl

        _SEC
        ply
        plp
        plb
        sec
        rtl

        .databank 0

      rlLoadFirstRAMStructEntry ; 82/E7A6

        .al
        .autsiz
        .databank ?

        ; Load 1st entry of lStructPointer2 into lStructPointer1

        lda #1
        sta wStructIndex
        jsl rlLoadRAMStructDataByIndex
        rtl

        .databank 0

      rlLoadLatestRAMStructEntry ; 82/E7B2

        .al
        .autsiz
        .databank ?

        ; Load latest (CurrentStructCount) entry of lStructPointer2 into lStructPointer1

        jsl rlGetRAMStructCurrentStructCount
        sta wStructIndex
        jsl rlLoadRAMStructDataByIndex
        rtl

        .databank 0

      rlLoadRAMStructDataByIndex ; 82/E7BF

        .al
        .autsiz
        .databank ?

        ; In:
        ; wStructIndex
        ; lStructPointer2 = pointer to struct header

        phb
        php
        phk
        plb
        phy
        ldy lStructPointer2,b

        sep #$20
        lda lStructPointer2+2,b
        pha
        rep #$20
        plb

        lda structRAMStructHeader.CurrentStructCount,b,y
        and #$00FF
        cmp wStructIndex
        bcc +

          lda structRAMStructHeader.StructSize,b,y
          and #$00FF
          sta wStructSize

          lda wStructIndex
          jsr rsLoadDataFromRAMStruct

          ply
          plp
          plb
          clc
          rtl

        +
        ply
        plp
        plb
        sec
        rtl

        .databank 0

      rlGetFirstRAMStructEntryPointer ; 82/E7F7

        .al
        .autsiz
        .databank ?

        ; Return pointer to 1st entry of lStructPointer2 in lStructPointer1

        lda #1
        sta wStructIndex
        jsl rlGetRAMStructEntryPointerByStructIndex
        rtl

        .databank 0

      rlGetLatestStructEntryPointer ; 82/E803

        .al
        .autsiz
        .databank ?

        jsl rlGetRAMStructCurrentStructCount
        sta wStructIndex
        jsl rlGetRAMStructEntryPointerByStructIndex
        rtl

        .databank 0

      rlGetRAMStructEntryPointerByStructIndex ; 82/E810

        .al
        .autsiz
        .databank ?

        phb
        php

        phk
        plb

        phy

        ldy lStructPointer2,b

        sep #$20
        lda lStructPointer2+2,b
        pha
        rep #$20
        plb

        lda structRAMStructHeader.CurrentStructCount,b,y
        and #$00FF
        cmp wStructIndex
        bcc +

          lda structRAMStructHeader.StructSize,b,y
          and #$00FF
          sta wStructSize

          lda lStructPointer2+1
          sta lStructPointer1+1

          lda wStructIndex
          jsr rsGetRAMStructOffset
          clc
          adc #size(structRAMStructHeader)
          clc
          adc lStructPointer2
          sta lStructPointer1

          ply
          plp
          plb
          clc
          rtl

        +
        ply
        plp
        plb
        sec
        rtl

        .databank 0

      rlSaveRAMStructDataByIndex ; 82/E85D

        .al
        .autsiz
        .databank ?

        ; Write lStructPointer1 data to 1-based wStructIndex slot via rsSaveDataToRAMStruct

        phb
        php
        phk
        plb
        phy

        ldy lStructPointer2,b

        sep #$20
        lda lStructPointer2+2,b
        pha
        rep #$20
        plb

        lda $0000,b,y
        and #$00FF
        cmp wStructIndex
        bcc _SEC

          lda $0002,b,y
          and #$00FF
          sta wStructSize

          lda wStructIndex
          jsr rsSaveDataToRAMStruct
          ply
          plp
          plb
          clc
          rtl

        _SEC
        ply
        plp
        plb
        sec
        rtl

        .databank 0

      rlFindRAMStructEntry ; 82/E895

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lStructPointer1 = Data to search for
        ; lStructPointer2 = RAM struct to search in

        ; Output:
        ; A = entry ID (1 indexed)

        phb
        php
        phk
        plb
        phx
        phy

        ldy lStructPointer2,b

        sep #$20
        lda lStructPointer2+2,b
        pha
        rep #$20
        plb

        lda structRAMStructHeader.CurrentStructCount,b,y
        and #$00FF
        beq _End

          tax
          lda structRAMStructHeader.StructSize,b,y
          and #$00FF
          sta wStructSize

          lda #1
          sta wStructIndexAlternate

            _Loop
            jsr rsCompareRAMStructData
            beq _Found

              tya
              clc
              adc wStructSize
              tay

              lda wStructIndexAlternate
              inc a
              sta wStructIndexAlternate
              dec x
              bne _Loop

        _End
        ply
        plx
        plp
        plb
        lda #0
        rtl

        _Found
        lda wStructIndexAlternate
        ply
        plx
        plp
        plb
        rtl

        .databank 0

      rsGetRAMStructOffset ; 82/E8EA

        .al
        .autsiz
        .databank ?

        ; In:
        ; A = struct index
        ; wStructSize

        ; Out:
        ; A = offset

        phb
        php

        phk
        plb

        dec a
        bmi _End
        beq _End

        cmp #4
        bcs _Multiply

        cmp #3
        beq ++

        cmp #2
        beq +

        lda wStructSize,b
        bra _End

        +
        lda wStructSize,b
        asl a
        bra _End
        
        +
        lda wStructSize,b
        asl a
        clc
        adc wStructSize,b
        bra _End
        
        _Multiply
        phx
        xba
        sta wStructMultiplyTemp1,b

        lda wStructSize,b
        sta wStructMultiplyTemp2,b

        lda #0
        ldx #8

        -
        asl a
        asl wStructMultiplyTemp1,b
        bcc +

        clc
        adc wStructMultiplyTemp2,b
        
        +
        dec x
        bne -

        plx

        _End
        plp
        plb
        rts

        .databank 0

      rsSaveDataToRAMStruct ; 82/E939

        .al
        .autsiz
        .databank ?

        ; A = struct index
        ; wStructSize
        ; lStructPointer1 = data source, 1,2 or 3 bytes or pointer 
        ; lStructPointer2 = dest struct pointer

        php
        phy

        jsr rsGetRAMStructOffset

        clc
        adc lStructPointer2
        tay

        ; If the data to write is 4 bytes of more, do it indirect via a pointer
        lda wStructSize
        cmp #4
        bcs _Indirect

        ; Else the data is directly in the long regiser
        cmp #3
        beq ++

        cmp #2
        beq +

        sep #$20
        lda lStructPointer1
        sta $0004,b,y
        rep #$20
        bra _End
        
        +
        lda lStructPointer1
        sta $0004,b,y
        bra _End
        
        +
        lda lStructPointer1
        sta $0004,b,y
        lda lStructPointer1+1
        sta $0004+1,b,y
        bra _End

        _Indirect
        lda wStructSize
        pha
        lda lR38
        pha
        lda lR38+1
        pha

        phx
        lda lStructPointer1
        sta lR38
        lda lStructPointer1+1
        sta lR38+1

        sep #$20
        tyx
        ldy #0
        
        -
        lda [lR38],y
        sta $0004,b,x
        inc y
        inc x
        lda wStructSize
        dec a
        sta wStructSize
        bne -

        rep #$20
        plx

        pla
        sta lR38+1
        pla
        sta lR38
        pla
        sta wStructSize
        
        _End
        ply
        plp
        rts

        .databank 0

      rsLoadDataFromRAMStruct ; 82/E9BE

        .al
        .autsiz
        .databank ?

        ; A = struct index
        ; wStructSize
        ; lStructPointer1 = dest struct pointer
        ; lStructPointer2 = data source, 1,2 or 3 bytes or pointer 

        php
        phx
        phy

        jsr rsGetRAMStructOffset

        clc
        adc lStructPointer2
        tay

        lda wStructSize
        cmp #4
        bcs _Indirect

        cmp #3
        beq ++

        cmp #2
        beq +

        sep #$20
        lda $0004,b,y
        sta lStructPointer1
        rep #$20
        bra _End
        
        +
        lda $0004,b,y
        sta lStructPointer1
        bra _End
        
        +
        lda $0004,b,y
        sta lStructPointer1
        lda $0004+1,b,y
        sta lStructPointer1+1
        bra _End
        
        _Indirect
        lda wStructSize
        pha
        lda lR38
        pha
        lda lR38+1
        pha

        lda lStructPointer1
        sta lR38
        lda lStructPointer1+1
        sta lR38+1

        sep #$20
        tyx
        ldy #0
        
        -
        lda $0004,b,x
        sta [lR38],y
        inc x
        inc y
        lda wStructSize
        dec a
        sta wStructSize
        bne -

        rep #$20

        pla
        sta lR38+1
        pla
        sta lR38
        pla
        sta wStructSize
        
        _End
        ply
        plx
        plp
        rts

        .databank 0

      rsCompareRAMStructData ; 82/EA43

        .al
        .autsiz
        .databank ?

        ; Input:
        ; Y = pointer to some RAM struct entry
        ; wStructSize
        ; Filled lStructPointer1

        ; Output:
        ; A = 0 if data matches, else returns 1

        lda wStructSize
        cmp #4
        bcs _Dynamic

        cmp #3
        beq _Long

        cmp #2
        beq _Word

        ; Byte
        lda $0004,b,y
        and #$00FF
        cmp lStructPointer1
        beq _Equal
        bra _Unequal
        
        _Word
        lda $0004,b,y
        cmp lStructPointer1
        beq _Equal
        bra _Unequal

        _Long
        lda $0004,b,y
        cmp lStructPointer1
        bne _Unequal

        lda $0004+1,b,y
        cmp lStructPointer1+1
        beq _Equal
        bra _Unequal
        
        _Dynamic
        phx
        phy
        lda wStructSize
        pha
        lda lR38
        pha
        lda lR38+1
        pha

        lda lStructPointer1
        sta lR38
        lda lStructPointer1+1
        sta lR38+1
        sep #$20
        tyx
        ldy #0
        
          _Loop
          lda $0004,b,x
          cmp [lR38],y
          bne +

            inc x
            inc y
            lda wStructSize
            dec a
            sta wStructSize
            bne _Loop

        rep #$20
        pla
        sta lR38+1
        pla
        sta lR38
        pla
        sta wStructSize
        ply
        plx
        bra _Equal

        +
        rep #$20
        pla
        sta lR38+1
        pla
        sta lR38
        pla
        sta wStructSize
        ply
        plx

        _Unequal
        lda #1
        rts

        _Equal
        lda #0
        rts 

        .databank 0

        ; 82/EADE

    .endsection RAMStructAccessSection


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
    .section Unsorted82E400Section

      .al
      .xl

      rlResetRAMStructAndAreaVariables ; 82/E400

        .al
        .autsiz
        .databank ?

        ; Zero $054A..$056C struct/RAMArea vars and initialize wUnknown00056B to $0010

        phb
        php
        phk
        plb
        ldx #$0021
        lda #0
        
          -
          sta lStructPointer1,b,x
          dec x
          dec x
          bpl -

        lda #$0010
        sta wUnknown00056B,b
        plp
        plb
        rtl

        .databank 0

        ; 82/E41A

        ; Unreachable: it follows a return.
        rtl

    .endsection Unsorted82E400Section


    .section Unsorted82E5FFSection

      .al
      .xl

      rlMoveRAMStructEntryToFirst ; 82/E5FF

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unused: find lStructPointer1 entry and move it to index 1

        phb
        phk
        plb
        .databank $82
        jsl rlFindRAMStructEntry
        sta wStructIndex,b
        lda #$0001
        sta wStructCurrentCount,b
        jsl rlMoveRAMStructEntry
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E615

    .endsection Unsorted82E5FFSection


    .section Unsorted82E615Section

      .al
      .xl

      rlMoveRAMStructEntryToLast ; 82/E615

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unused: find lStructPointer1 entry and move it to CurrentStructCount

        phb
        phk
        plb
        .databank $82
        jsl rlFindRAMStructEntry
        sta wStructIndex,b
        jsl rlGetRAMStructCurrentStructCount
        sta wStructCurrentCount,b
        jsl rlMoveRAMStructEntry
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E62C

    .endsection Unsorted82E615Section


    .section Unsorted82E62CSection

      .al
      .xl

      rlMoveRAMStructEntryPrev ; 82/E62C

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unused: find lStructPointer1 entry and move it back 1 slot

        phb
        phk
        plb
        .databank $82
        jsl rlFindRAMStructEntry
        sta wStructIndex,b
        dec a
        sta wStructCurrentCount,b
        jsl rlMoveRAMStructEntry
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E640

      rlMoveRAMStructEntryNext ; 82/E640

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unused: find lStructPointer1 entry and move it forward 1 slot

        phb
        phk
        plb
        .databank $82
        jsl rlFindRAMStructEntry
        sta wStructIndex,b
        inc a
        sta wStructCurrentCount,b
        jsl rlMoveRAMStructEntry
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E654

      rlMoveRAMStructEntryToTargetIndex ; 82/E654

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unused: find lStructPointer1 entry and move it to preloaded $0552 index

        phb
        phk
        plb
        .databank $82
        jsl rlFindRAMStructEntry
        sta wStructIndex,b
        jsl rlMoveRAMStructEntry
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E664

    .endsection Unsorted82E62CSection


    .section Unsorted82E664Section

      .al
      .xl

      rlMoveRAMStructEntry ; 82/E664

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Move RAM struct entry from wStructIndex to $0552, shifting intervening entries

        phb
        php
        phk
        plb
        .databank $82
        phx
        phy
        lda wStructIndex,b
        ora wStructCurrentCount,b
        bne _E676
        jml _E741


        _E676
        lda wStructIndex,b
        beq _E6B8
        lda wStructCurrentCount,b
        beq _E6B8
        ldy lStructPointer2,b
        sep #$20
        lda lStructPointer2+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda $0000,b,y
        cmp @l wStructIndex
        bcc _E6B8
        cmp @l $000552
        bcc _E6B8
        lda $0002,b,y
        and #$00FF
        sta @l wStructSize
        lda @l wStructIndex
        jsr rsLoadRAMStructEntryToScratch
        lda @l wStructIndex
        cmp @l $000552
        bcc _E700
        bra _E6BE


        _E6B8
        ply
        plx
        plp
        plb
        .databank ?
        sec
        rtl


        _E6BE
        sec
        sbc @l $000552
        inc a
        jsr rsGetRAMStructOffset
        sta @l wStructIndexAlternate
        lda @l wStructIndex
        and #$00FF
        dec a
        jsr rsGetRAMStructOffset
        clc
        adc @l lStructPointer2
        clc
        adc @l wStructSize
        tay
        clc
        adc @l wStructSize
        tax
        sep #$20

        _E6E9
        lda $0003,b,y
        sta $0003,b,x
        dec y
        dec x
        lda @l wStructIndexAlternate
        dec a
        sta @l wStructIndexAlternate
        bne _E6E9
        rep #$20
        bra _E73A


        _E700
        lda @l $000552
        sec
        sbc @l wStructIndex
        inc a
        jsr rsGetRAMStructOffset
        sta wStructIndexAlternate,b
        lda @l wStructIndex
        jsr rsGetRAMStructOffset
        clc
        adc @l lStructPointer2
        tax
        clc
        adc @l wStructSize
        tay
        sep #$20

        _E725
        lda $0004,b,y
        sta $0004,b,x
        inc y
        inc x
        lda @l wStructIndexAlternate
        dec a
        sta @l wStructIndexAlternate
        bne _E725
        rep #$20

        _E73A
        lda @l $000552
        jsr rsSaveRAMStructEntryFromScratch

        _E741
        ply
        plx
        plp
        plb
        .databank ?
        clc
        rtl

        .databank 0

        ; 82/E747

    .endsection Unsorted82E664Section


    .section Unsorted82EADESection

      .al
      .xl

      rsLoadRAMStructEntryToScratch ; 82/EADE

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Load RAM struct entry A into lStructPointer1 (or trailing scratch slot if size >= 4)

        phy
        pha
        lda @l lStructPointer2
        tay
        lda $0002,b,y
        and #$00FF
        cmp #$0004
        bcc _EB0F
        lda $0001,b,y
        and #$00FF
        inc a
        jsr rsGetRAMStructOffset
        clc
        adc @l lStructPointer2
        sta @l lStructPointer1
        sep #$20
        lda @l lStructPointer2+1
        sta @l lStructPointer1+1
        rep #$20

        _EB0F
        pla
        jsr rsLoadDataFromRAMStruct
        ply
        rts

        .databank 0

        ; 82/EB15

      rsSaveRAMStructEntryFromScratch ; 82/EB15

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Save lStructPointer1 (or trailing scratch slot if size >= 4) to entry A

        phy
        pha
        lda @l lStructPointer2
        tay
        lda $0002,b,y
        and #$00FF
        cmp #$0004
        bcc _EB46
        lda $0001,b,y
        and #$00FF
        inc a
        jsr rsGetRAMStructOffset
        clc
        adc @l lStructPointer2
        sta @l lStructPointer1
        sep #$20
        lda @l lStructPointer2+1
        sta @l lStructPointer1+1
        rep #$20

        _EB46
        pla
        jsr rsSaveDataToRAMStruct
        ply
        rts

        .databank 0

        ; 82/EB4C

    .endsection Unsorted82EADESection


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
    .section Unsorted82F517Section

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

    .endsection Unsorted82F517Section


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
