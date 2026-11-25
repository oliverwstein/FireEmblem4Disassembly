; Struct arrays: blocks of fixed-size entries with a count and a maximum.

    .section Unsorted82E400Section

      .al
      .xl

      rlResetRAMStructAndAreaVariables ; 82/E400

        .al
        .autsiz
        .databank ?

        ; Zero $054A..$056C struct/RAMArea vars and initialize wRAMAreaHandlesPerBlock to $0010

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
        sta wRAMAreaHandlesPerBlock,b
        plp
        plb
        rtl

        .databank 0

        ; 82/E41A

        ; Unreachable: it follows a return.
        rtl

    .endsection Unsorted82E400Section

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
        sta structRAMStructHeader.Flags,b,y
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

        lda structRAMStructHeader.Flags,b,x
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

        lda structRAMStructHeader.Flags,b,x
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
