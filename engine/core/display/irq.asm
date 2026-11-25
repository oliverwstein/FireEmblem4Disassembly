; The IRQ engine: a sorted list of mid-frame interrupts, each with a script.

    .section IRQEngineCycleSection

      .al
      .xl

      rsIRQEngineCycle ; 80/AE63

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ callback wrapper invoking jsl rlRunIRQEngine

        jsl rlRunIRQEngine
        rts

        .databank 0

        ; 80/AE68

    .endsection IRQEngineCycleSection

    .section Unsorted82E000Section

      .al
      .xl

      aIRQEngineMainActionTable ; 82/E000
        .word <>rlResetIRQEngine, <>rlIRQEngineStub, <>rlIRQEngineRestoreDefaultIRQ

      rsIRQCodeSleep ; 82/E006

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script cmd: read inline word sleep timer into $170A,x and yield

        lda $0000,b,y
        sta $170A,b,x
        inc y
        inc y
        tya
        sta $16FA,b,x
        pla
        rts

        .databank 0

        ; 82/E014

      rsIRQCodeEnd ; 82/E014

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script cmd: clear slot $169A/$16DA, resort slots, decrement $1695, exit

        stz $169A,b,x
        stz $16DA,b,x
        jsr rsIRQEngineSortEntries
        dec $1695,b
        pla
        rts

        .databank 0

        ; 82/E022

      rsIRQCodeHaltSleep ; 82/E022
        .al
        .xl
        lda #$0001
        sta $170A,b,x
        ; falls into rsIRQCodeHalt

    .endsection Unsorted82E000Section

    .section Unsorted82E028Section

      .al
      .xl

      rsIRQCodeHalt ; 82/E028

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script cmd: rewind Y by 2, store script PC to $16FA,x, and yield

        dec y
        dec y
        tya
        sta $16FA,b,x
        pla
        rts

        .databank 0

        ; 82/E030

    .endsection Unsorted82E028Section

    .section Unreferenced82E030Section

      .al
      .xl

      rsIRQCodeCall ; 82/E030

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script command: calls the long routine in the next three bytes
        ; (as rsHDMACodeCall). Nothing found uses this command or the four
        ; after it.

        lda $0000,b,y
        sta $1697,b
        lda $0001,b,y
        sta $1698,b
        phy
        phx
        jsl +
        plx
        ply
        inc y
        inc y
        inc y
        rts

        +
        jml [$1697]

        .databank 0

      rsIRQCodeSetRoutine ; 82/E04B

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script command: sets the entry's routine ($16EA) to the next word.

        lda $0000,b,y
        sta $16EA,b,x
        inc y
        inc y
        rts

        .databank 0

      rsIRQCodeJump ; 82/E054

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script command: continues at the next word.

        lda $0000,b,y
        tay
        rts

        .databank 0

      rsIRQCodeJumpIfBitsUnset ; 82/E059

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script command: jumps to the first word if none of the bits in the
        ; second are set in the entry's $16BA.

        lda $0002,b,y
        bit $16BA,b,x
        beq rsIRQCodeJump
        inc y
        inc y
        inc y
        inc y
        rts

        .databank 0

      rsIRQCodeJumpIfBitsSet ; 82/E066

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script command: jumps to the first word if any of them are set.

        lda $0002,b,y
        bit $16BA,b,x
        bne rsIRQCodeJump
        inc y
        inc y
        inc y
        inc y
        rts

        .databank 0

        ; 82/E073

    .endsection Unreferenced82E030Section

    .section Unsorted82E073Section

      .al
      .xl

      rlResetIRQEngine ; 82/E073

        .al
        .autsiz
        .databank ?

        ; Clears $168F-$1719 and calls rlDisableIRQEngine. FE5: rlIRQEngineReset (identical, same size cleared).

        php
        phb
        phk
        plb
        ldx #$008A
        sep #$20
        lda #0
        
          -
          sta $168F,b,x
          dec x
          bpl -

        rep #$20
        jsl rlDisableIRQEngine
        plb
        plp
        rtl

        .databank 0

        ; 82/E08D

    .endsection Unsorted82E073Section

    .section Unsorted82E08DSection

      .al
      .xl

      rlEnableIRQEngine ; 82/E08D

        .al
        .xl
        .autsiz
        .databank ?

        ; Enables HV IRQ in NMITIMEN, syncs/sorts IRQ entries, and installs rsIRQEngineCycle

        sei
        phb
        php
        phk
        plb
        .databank $82
        sep #$20
        lda bBufferNMITIMEN
        ora #$30
        sta bBufferNMITIMEN
        rep #$20
        lda #$8000
        trb $168F,b
        jsl rlIRQEngineSyncAndSort
        lda #<>rsIRQEngineCycle
        sta wIRQPointer
        plp
        plb
        .databank $82
        cli
        rtl

        .databank 0

        ; 82/E0AF

    .endsection Unsorted82E08DSection

    .section Unsorted82E0AFSection

      .al
      .xl

      rlDisableIRQEngine ; 82/E0AF

        .al
        .autsiz
        .databank ?

        ; Clear NMITIMEN H/V IRQ bits, set $8000 in $168F, reset wIRQPointer

        sei
        sep #$20
        lda bBufferNMITIMEN
        and #$CF
        sta bBufferNMITIMEN
        rep #$20

        lda #$8000
        tsb $168F,b
        lda #<>rsDefaultIRQRoutine
        sta wIRQPointer
        rtl

        .databank 0

        ; 82/E0C6

    .endsection Unsorted82E0AFSection

    .section Unsorted82E0C6Section

      .al
      .xl

      rlIRQEngineCreateEntry ; 82/E0C6

        .al
        .xl
        .autsiz
        .databank ?

        ; Adds an IRQ entry from lR44 (max 7 entries; carry set if full)

        phb
        php
        phk
        plb
        .databank $82
        phx
        ldy lR44
        sep #$20
        lda lR44+2
        pha
        rep #$20
        plb
        .databank ?
        lda $1695,b
        cmp #$0007
        bcc _E0E2
        plx
        plp
        plb
        .databank ?
        sec
        rtl


        _E0E2
        lda $1695,b
        asl a
        tax
        tya
        sta $169A,b,x
        lda lR44+1
        and #$FF00
        xba
        sta $16AA,b,x
        lda #$0000
        sta $16BA,b,x
        lda $0000,b,y
        sta $16CA,b,x
        lda $0002,b,y
        sta $16DA,b,x
        lda $0004,b,y
        sta $16EA,b,x
        lda $0006,b,y
        sta $16FA,b,x
        lda #$0001
        sta $170A,b,x
        inc $1695,b
        plx
        plp
        plb
        .databank ?
        clc
        rtl

        .databank 0

        ; 82/E120

    .endsection Unsorted82E0C6Section

    .section Unreferenced82E120Section

      .al
      .xl

      rlIRQEngineFreeCurrentEntry ; 82/E120

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced; clears active IRQ entry $1691 and decrements count $1695

        phb
        php
        phk
        plb
        .databank $82
        ldx $1691,b
        stz $169A,b,x
        stz $16DA,b,x
        dec $1695,b
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E133

    .endsection Unreferenced82E120Section

    .section Unsorted82E133Section

      .al
      .xl

      rlIRQEngineStub ; 82/E133

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; The IRQ engine's per-frame routine in aIRQEngineMainActionTable: does
        ; nothing. The engine's work runs from the IRQ itself (rsIRQEngineCycle).

        rtl

        .databank 0

      rlWriteINIDISPForcedBlankOnlyUnused ; 82/E134

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing refers to it. Writes INIDISP with only the forced-blank bit of
        ; bBufferINIDISP (brightness 0).

        sep #$20
        lda bBufferINIDISP
        and #$80
        sta $2100,b
        rep #$20
        rtl

        .databank 0

      rlIRQEngineRestoreDefaultIRQ ; 82/E140

        .al
        .xl
        .autsiz
        .databank ?

        ; The third routine in aIRQEngineMainActionTable: puts rsDefaultIRQRoutine
        ; back in wIRQPointer and disables interrupts. rlRegisterVBlankHook reads
        ; only the first two words of an engine's table, and nothing else is
        ; known to read the third.

        lda #<>rsDefaultIRQRoutine
        sta wIRQPointer
        sei
        rtl

        .databank 0

        ; 82/E147

    .endsection Unsorted82E133Section

    .section Unsorted82E147Section

      .al
      .xl

      rlIRQEngineSyncAndSort ; 82/E147

        .al
        .xl
        .autsiz
        .databank ?

        ; Sorts IRQ entries by scanline and programs hardware HV timer for next entry

        sei
        phb
        php
        phk
        plb
        .databank $82
        lda $1695,b
        cmp $1693,b
        beq _E173
        sta $1693,b
        jsr rsIRQEngineSortEntries
        lda $1693,b
        beq _E16A
        dec a
        asl a
        sta $1691,b
        tax
        jsr rsIRQEngineProgramNextEntry
        bra _E173


        _E16A
        lda #$0000
        sta $1697,b
        sta $1698,b

        _E173
        plp
        plb
        .databank $82
        cli
        rtl

        .databank 0

        ; 82/E177

      rsIRQEngineSortEntries ; 82/E177

        .al
        .xl
        .autsiz
        .databank ?

        ; Shell-sorts active IRQ entries by V-count ($16DA)

        phb
        php
        phk
        plb
        .databank $82
        phx
        phy
        lda $1693,b
        cmp #$0001
        beq _E1BA
        bcc _E1BA
        and #$FFFE
        sta wR30

        _E18C
        lda $1693,b
        asl a
        sec
        sbc wR30
        sta wR32
        stz wR31

        _E197
        lda wR30
        clc
        adc wR31
        tay
        ldx wR31
        lda $16DA,b,x
        cmp $16DA,b,y
        bcs _E1AA
        jsr rsIRQEngineSwapEntries

        _E1AA
        inc wR31
        inc wR31
        lda wR31
        cmp wR32
        bcc _E197
        dec wR30
        dec wR30
        bne _E18C

        _E1BA
        ply
        plx
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 82/E1BF

      rsIRQEngineSwapEntries ; 82/E1BF

        .al
        .xl
        .autsiz
        .databank ?

        ; Swaps two IRQ entries X and Y across all IRQ engine arrays

        lda $169A,b,x
        sta $16A8,b
        lda $16AA,b,x
        sta $16B8,b
        lda $16BA,b,x
        sta $16C8,b
        lda $16CA,b,x
        sta $16D8,b
        lda $16DA,b,x
        sta $16E8,b
        lda $16EA,b,x
        sta $16F8,b
        lda $16FA,b,x
        sta $1708,b
        lda $170A,b,x
        sta $1718,b
        lda $169A,b,y
        sta $169A,b,x
        lda $16AA,b,y
        sta $16AA,b,x
        lda $16BA,b,y
        sta $16BA,b,x
        lda $16CA,b,y
        sta $16CA,b,x
        lda $16DA,b,y
        sta $16DA,b,x
        lda $16EA,b,y
        sta $16EA,b,x
        lda $16FA,b,y
        sta $16FA,b,x
        lda $170A,b,y
        sta $170A,b,x
        lda $16A8,b
        sta $169A,b,y
        lda $16B8,b
        sta $16AA,b,y
        lda $16C8,b
        sta $16BA,b,y
        lda $16D8,b
        sta $16CA,b,y
        lda $16E8,b
        sta $16DA,b,y
        lda $16F8,b
        sta $16EA,b,y
        lda $1708,b
        sta $16FA,b,y
        lda $1718,b
        sta $170A,b,y
        rts

        .databank 0

        ; 82/E250

    .endsection Unsorted82E147Section

    .section Unsorted82E250Section

      .al
      .xl

      rlRunIRQEngine ; 82/E250

        .al
        .xl
        .autsiz
        .databank ?

        ; Run active IRQ slot callback, step slot script, advance/wrap to next IRQ slot

        phb
        php
        phk
        plb
        .databank $82
        lda $168F,b
        bit #$8000
        bne _E280
        lda $1697,b
        ora $1698,b
        beq _E280
        ldx $1691,b
        jsl rlIRQEngineRunSlotCallback
        jsr rsIRQEngineStepSlotCode
        ldx $1691,b
        bne _E278
        lda $1693,b
        asl a
        tax

        _E278
        dec x
        dec x
        stx $1691,b
        jsr rsIRQEngineProgramNextEntry

        _E280
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E283

    .endsection Unsorted82E250Section

    .section Unsorted82E283Section

      .al
      .xl

      rsIRQEngineProgramNextEntry ; 82/E283

        .al
        .xl
        .autsiz
        .databank ?

        ; Writes HTIME/VTIME ($4207-$420A) and active IRQ routine ($1697/$1698) for entry X

        sep #$20
        lda $16CB,b,x
        sta $4208,b
        lda $16CA,b,x
        sta $4207,b
        lda $16DB,b,x
        sta $420A,b
        lda $16DA,b,x
        sta $4209,b
        rep #$20
        lda $16AA,b,x
        xba
        sta $1698,b
        lda $16EA,b,x
        sta $1697,b
        rts

        .databank 0

        ; 82/E2AD

    .endsection Unsorted82E283Section

    .section Unsorted82E2ADSection

      .al
      .xl

      rsIRQEngineStepSlotCode ; 82/E2AD

        .al
        .xl
        .autsiz
        .databank ?

        ; Decrement IRQ slot sleep timer; step script commands or load (timer, VTIME)

        ldx $1691,b
        dec $170A,b,x
        bne _E2D9
        ldy $16FA,b,x

        _E2B8
        lda $0000,b,y
        bpl _E2C8
        sta $1697,b
        inc y
        inc y
        pea #<>_E2B8 - 1
        jmp ($1697)


        _E2C8
        sta $170A,b,x
        lda $0002,b,y
        sta $16DA,b,x
        tya
        clc
        adc #$0004
        sta $16FA,b,x

        _E2D9
        rts

        .databank 0

        ; 82/E2DA

      rlIRQEngineRunSlotCallback ; 82/E2DA

        .al
        .xl
        .autsiz
        .databank ?

        ; Set DB from $1699 and jml [$1697] for active IRQ slot handler

        sep #$20
        lda $1699,b
        pha
        rep #$20
        plb
        .databank ?
        jml [$1697]

        .databank 0

        ; 82/E2E6

        ; Unused: 282 zero bytes.
        .fill 282, $00

    .endsection Unsorted82E2ADSection
