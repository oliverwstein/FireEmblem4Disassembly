; The IRQ engine: a sorted list of mid-frame interrupts, each with a script.

    .section IRQEngineCycleSection

      .al
      .xl

      rsIRQEngineCycle ; 80/AE63

        .al
        .xl
        .autsiz
        .databank ?

        ; The IRQ routine while the engine is on (wIRQPointer, set by rlEnableIRQEngine):
        ; rlRunIRQEngine.

        jsl rlRunIRQEngine
        rts

        .databank 0

        ; 80/AE68

    .endsection IRQEngineCycleSection

    .section IRQEngineMainActionTableSection

      .al
      .xl

      aIRQEngineMainActionTable ; 82/E000
        .word <>rlResetIRQEngine, <>rlIRQEngineStub, <>rlIRQEngineRestoreDefaultIRQ

      rsIRQCodeSleep ; 82/E006

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script command: sleeps the number of IRQs in the next word, keeping the
        ; entry's VTIME.

        lda $0000,b,y
        sta aIRQSystem.aSleepTimer,b,x
        inc y
        inc y
        tya
        sta aIRQSystem.aCodeOffset,b,x
        pla
        rts

        .databank 0

        ; 82/E014

      rsIRQCodeEnd ; 82/E014

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script command: frees the entry. Its V time becomes 0, so the sort moves it
        ; to the highest index, which the decremented wCount then drops.

        stz aIRQSystem.aTypeOffset,b,x
        stz aIRQSystem.aVTime,b,x
        jsr rsIRQEngineSortEntries
        dec aIRQSystem.wCount,b
        pla
        rts

        .databank 0

        ; 82/E022

      rsIRQCodeHaltSleep ; 82/E022

        .al
        .xl

        ; IRQ script command: as rsIRQCodeHalt, with the sleep timer set to 1.

        lda #$0001
        sta aIRQSystem.aSleepTimer,b,x
        ; falls into rsIRQCodeHalt

    .endsection IRQEngineMainActionTableSection

    .section IRQCodeHaltSection

      .al
      .xl

      rsIRQCodeHalt ; 82/E028

        .al
        .xl
        .autsiz
        .databank ?

        ; Found through fe4.cdl.
        ; IRQ script command: leaves the script on this command; the entry's routine keeps
        ; running at its IRQ.

        dec y
        dec y
        tya
        sta aIRQSystem.aCodeOffset,b,x
        pla
        rts

        .databank 0

        ; 82/E030

    .endsection IRQCodeHaltSection

    .section Unreferenced82E030Section

      .al
      .xl

      rsIRQCodeCall ; 82/E030

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script command: calls the long routine in the next three bytes. No script
        ; uses this command or the four after it.

        lda $0000,b,y
        sta aIRQSystem.lRoutine,b
        lda $0001,b,y
        sta aIRQSystem.lRoutine+1,b
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
        jml [aIRQSystem.lRoutine]

        .databank 0

      rsIRQCodeSetRoutine ; 82/E04B

        .al
        .xl
        .autsiz
        .databank ?

        ; IRQ script command: sets the entry's routine (aIRQSystem.aRoutine) to the next
        ; word.

        lda $0000,b,y
        sta aIRQSystem.aRoutine,b,x
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

        ; IRQ script command: jumps to the first word if none of the bits in the second
        ; are set in aIRQSystem.aBitfield. Nothing sets that field.

        lda $0002,b,y
        bit aIRQSystem.aBitfield,b,x
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
        bit aIRQSystem.aBitfield,b,x
        bne rsIRQCodeJump
        inc y
        inc y
        inc y
        inc y
        rts

        .databank 0

        ; 82/E073

    .endsection Unreferenced82E030Section

    .section ResetIRQEngineSection

      .al
      .xl

      rlResetIRQEngine ; 82/E073

        .al
        .autsiz
        .databank ?

        ; The IRQ engine's init routine: clears aIRQSystem and turns the engine off
        ; (rlDisableIRQEngine).

        php
        phb
        phk
        plb
        ldx #$008A
        sep #$20
        lda #0
        
          -
          sta aIRQSystem.wFlag,b,x
          dec x
          bpl -

        rep #$20
        jsl rlDisableIRQEngine
        plb
        plp
        rtl

        .databank 0

        ; 82/E08D

    .endsection ResetIRQEngineSection

    .section EnableIRQEngineSection

      .al
      .xl

      rlEnableIRQEngine ; 82/E08D

        .al
        .xl
        .autsiz
        .databank ?

        ; Turns the engine on: enables the H and V timer IRQs in bBufferNMITIMEN, clears
        ; the off bit, sorts the entries and programs the first (rlIRQEngineSyncAndSort),
        ; and installs rsIRQEngineCycle in wIRQPointer.

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
        trb aIRQSystem.wFlag,b
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

    .endsection EnableIRQEngineSection

    .section DisableIRQEngineSection

      .al
      .xl

      rlDisableIRQEngine ; 82/E0AF

        .al
        .autsiz
        .databank ?

        ; Turns the engine off: disables the H and V IRQs in bBufferNMITIMEN, sets
        ; aIRQSystem.wFlag $8000 and puts rsDefaultIRQRoutine back in wIRQPointer.

        sei
        sep #$20
        lda bBufferNMITIMEN
        and #$CF
        sta bBufferNMITIMEN
        rep #$20

        lda #$8000
        tsb aIRQSystem.wFlag,b
        lda #<>rsDefaultIRQRoutine
        sta wIRQPointer
        rtl

        .databank 0

        ; 82/E0C6

    .endsection DisableIRQEngineSection

    .section IRQEngineCreateEntrySection

      .al
      .xl

      rlIRQEngineCreateEntry ; 82/E0C6

        .al
        .xl
        .autsiz
        .databank ?

        ; Adds an entry from the definition at lR44: H time, V time, routine, script, all
        ; words in the definition's bank. The entry goes at index wCount; it is sorted in
        ; at the next rlIRQEngineSyncAndSort. Carry set if seven entries are already in
        ; use.

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
        lda aIRQSystem.wCount,b
        cmp #$0007
        bcc _E0E2
        plx
        plp
        plb
        .databank ?
        sec
        rtl


        _E0E2
        lda aIRQSystem.wCount,b
        asl a
        tax
        tya
        sta aIRQSystem.aTypeOffset,b,x
        lda lR44+1
        and #$FF00
        xba
        sta aIRQSystem.aTypeBank,b,x
        lda #$0000
        sta aIRQSystem.aBitfield,b,x
        lda $0000,b,y
        sta aIRQSystem.aHTime,b,x
        lda $0002,b,y
        sta aIRQSystem.aVTime,b,x
        lda $0004,b,y
        sta aIRQSystem.aRoutine,b,x
        lda $0006,b,y
        sta aIRQSystem.aCodeOffset,b,x
        lda #$0001
        sta aIRQSystem.aSleepTimer,b,x
        inc aIRQSystem.wCount,b
        plx
        plp
        plb
        .databank ?
        clc
        rtl

        .databank 0

        ; 82/E120

    .endsection IRQEngineCreateEntrySection

    .section Unreferenced82E120Section

      .al
      .xl

      rlIRQEngineFreeCurrentEntry ; 82/E120

        .al
        .xl
        .autsiz
        .databank ?

        ; Found by tools/sweep.py: nothing in the build reaches this.
        ; Nothing calls this. Frees the entry at aIRQSystem.wOffset.

        phb
        php
        phk
        plb
        .databank $82
        ldx aIRQSystem.wOffset,b
        stz aIRQSystem.aTypeOffset,b,x
        stz aIRQSystem.aVTime,b,x
        dec aIRQSystem.wCount,b
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E133

    .endsection Unreferenced82E120Section

    .section IRQEngineStubSection

      .al
      .xl

      rlIRQEngineStub ; 82/E133

        .al
        .xl
        .autsiz
        .databank ?

        ; Found through fe4.cdl.
        ; The IRQ engine's per-frame routine in aIRQEngineMainActionTable: does nothing.
        ; The engine's work runs from the IRQ itself (rsIRQEngineCycle).

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

        ; The third routine in aIRQEngineMainActionTable: puts rsDefaultIRQRoutine back in
        ; wIRQPointer and disables interrupts. Only rlFindAndJumpTaskTableUnused would
        ; call it, and nothing calls that.

        lda #<>rsDefaultIRQRoutine
        sta wIRQPointer
        sei
        rtl

        .databank 0

        ; 82/E147

    .endsection IRQEngineStubSection

    .section IRQEngineSyncAndSortSection

      .al
      .xl

      rlIRQEngineSyncAndSort ; 82/E147

        .al
        .xl
        .autsiz
        .databank ?

        ; When wCount has changed since the last sort: sorts the entries and programs the
        ; IRQ of the topmost (the highest index). rsMapVBlank, rsRunBattleSceneVBlank and
        ; rsRunTitleScreenVBlank call it every frame.

        sei
        phb
        php
        phk
        plb
        .databank $82
        lda aIRQSystem.wCount,b
        cmp aIRQSystem.wSortedCount,b
        beq _E173
        sta aIRQSystem.wSortedCount,b
        jsr rsIRQEngineSortEntries
        lda aIRQSystem.wSortedCount,b
        beq _E16A
        dec a
        asl a
        sta aIRQSystem.wOffset,b
        tax
        jsr rsIRQEngineProgramNextEntry
        bra _E173


        _E16A
        lda #$0000
        sta aIRQSystem.lRoutine,b
        sta aIRQSystem.lRoutine+1,b

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

        ; Orders the entries by V time, highest first, so the IRQs run from the highest
        ; index down to 0, top of the screen to bottom. It makes one compare-and-swap pass
        ; at each gap from wSortedCount / 2 down to 1, which does not order every
        ; arrangement (two of the six orders of three entries stay unsorted); every set of
        ; entries the game creates comes out in order.

        phb
        php
        phk
        plb
        .databank $82
        phx
        phy
        lda aIRQSystem.wSortedCount,b
        cmp #$0001
        beq _E1BA
        bcc _E1BA
        and #$FFFE
        sta wR30

        _E18C
        lda aIRQSystem.wSortedCount,b
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
        lda aIRQSystem.aVTime,b,x
        cmp aIRQSystem.aVTime,b,y
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

        ; Swaps entries X / 2 and Y / 2 in every array, through the eighth word of each.

        lda aIRQSystem.aTypeOffset,b,x
        sta $16A8,b
        lda aIRQSystem.aTypeBank,b,x
        sta $16B8,b
        lda aIRQSystem.aBitfield,b,x
        sta $16C8,b
        lda aIRQSystem.aHTime,b,x
        sta $16D8,b
        lda aIRQSystem.aVTime,b,x
        sta $16E8,b
        lda aIRQSystem.aRoutine,b,x
        sta $16F8,b
        lda aIRQSystem.aCodeOffset,b,x
        sta $1708,b
        lda aIRQSystem.aSleepTimer,b,x
        sta $1718,b
        lda aIRQSystem.aTypeOffset,b,y
        sta aIRQSystem.aTypeOffset,b,x
        lda aIRQSystem.aTypeBank,b,y
        sta aIRQSystem.aTypeBank,b,x
        lda aIRQSystem.aBitfield,b,y
        sta aIRQSystem.aBitfield,b,x
        lda aIRQSystem.aHTime,b,y
        sta aIRQSystem.aHTime,b,x
        lda aIRQSystem.aVTime,b,y
        sta aIRQSystem.aVTime,b,x
        lda aIRQSystem.aRoutine,b,y
        sta aIRQSystem.aRoutine,b,x
        lda aIRQSystem.aCodeOffset,b,y
        sta aIRQSystem.aCodeOffset,b,x
        lda aIRQSystem.aSleepTimer,b,y
        sta aIRQSystem.aSleepTimer,b,x
        lda $16A8,b
        sta aIRQSystem.aTypeOffset,b,y
        lda $16B8,b
        sta aIRQSystem.aTypeBank,b,y
        lda $16C8,b
        sta aIRQSystem.aBitfield,b,y
        lda $16D8,b
        sta aIRQSystem.aHTime,b,y
        lda $16E8,b
        sta aIRQSystem.aVTime,b,y
        lda $16F8,b
        sta aIRQSystem.aRoutine,b,y
        lda $1708,b
        sta aIRQSystem.aCodeOffset,b,y
        lda $1718,b
        sta aIRQSystem.aSleepTimer,b,y
        rts

        .databank 0

        ; 82/E250

    .endsection IRQEngineSyncAndSortSection

    .section RunIRQEngineSection

      .al
      .xl

      rlRunIRQEngine ; 82/E250

        .al
        .xl
        .autsiz
        .databank ?

        ; At each IRQ, unless the engine is off: calls the current entry's routine
        ; (aIRQSystem.lRoutine, DB = its bank), steps its script
        ; (rsIRQEngineStepSlotCode), moves to the next entry down (from 0 back to the
        ; topmost) and programs its H and V times.

        phb
        php
        phk
        plb
        .databank $82
        lda aIRQSystem.wFlag,b
        bit #$8000
        bne _E280
        lda aIRQSystem.lRoutine,b
        ora aIRQSystem.lRoutine+1,b
        beq _E280
        ldx aIRQSystem.wOffset,b
        jsl rlIRQEngineRunSlotCallback
        jsr rsIRQEngineStepSlotCode
        ldx aIRQSystem.wOffset,b
        bne _E278
        lda aIRQSystem.wSortedCount,b
        asl a
        tax

        _E278
        dec x
        dec x
        stx aIRQSystem.wOffset,b
        jsr rsIRQEngineProgramNextEntry

        _E280
        plp
        plb
        .databank $82
        rtl

        .databank 0

        ; 82/E283

    .endsection RunIRQEngineSection

    .section IRQEngineProgramNextEntrySection

      .al
      .xl

      rsIRQEngineProgramNextEntry ; 82/E283

        .al
        .xl
        .autsiz
        .databank ?

        ; Writes entry X / 2's H and V times to HTIME and VTIME, and its routine and bank
        ; to aIRQSystem.lRoutine.

        sep #$20
        lda $16CB,b,x
        sta $4208,b
        lda aIRQSystem.aHTime,b,x
        sta $4207,b
        lda $16DB,b,x
        sta $420A,b
        lda aIRQSystem.aVTime,b,x
        sta $4209,b
        rep #$20
        lda aIRQSystem.aTypeBank,b,x
        xba
        sta aIRQSystem.lRoutine+1,b
        lda aIRQSystem.aRoutine,b,x
        sta aIRQSystem.lRoutine,b
        rts

        .databank 0

        ; 82/E2AD

    .endsection IRQEngineProgramNextEntrySection

    .section IRQEngineStepSlotCodeSection

      .al
      .xl

      rsIRQEngineStepSlotCode ; 82/E2AD

        .al
        .xl
        .autsiz
        .databank ?

        ; Counts the current entry's sleep timer down; at 0 runs its script. A word with
        ; bit 15 set is a command (rsIRQCode*, bank $82); any other word is a sleep count
        ; followed by a new V time for the entry.

        ldx aIRQSystem.wOffset,b
        dec aIRQSystem.aSleepTimer,b,x
        bne _E2D9
        ldy aIRQSystem.aCodeOffset,b,x

        _E2B8
        lda $0000,b,y
        bpl _E2C8
        sta aIRQSystem.lRoutine,b
        inc y
        inc y
        pea #<>_E2B8 - 1
        jmp (aIRQSystem.lRoutine)


        _E2C8
        sta aIRQSystem.aSleepTimer,b,x
        lda $0002,b,y
        sta aIRQSystem.aVTime,b,x
        tya
        clc
        adc #$0004
        sta aIRQSystem.aCodeOffset,b,x

        _E2D9
        rts

        .databank 0

        ; 82/E2DA

      rlIRQEngineRunSlotCallback ; 82/E2DA

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets DB to the bank in aIRQSystem.lRoutine and jumps there.

        sep #$20
        lda aIRQSystem.lRoutine+2,b
        pha
        rep #$20
        plb
        .databank ?
        jml [aIRQSystem.lRoutine]

        .databank 0

        ; 82/E2E6

        ; Unused: 282 zero bytes.
        .fill 282, $00

    .endsection IRQEngineStepSlotCodeSection
