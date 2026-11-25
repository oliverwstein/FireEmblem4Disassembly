; The proc engine: cooperative per-frame tasks ("procs") and their script commands.

    .section ProcEngineSection

      .al
      .xl

      aProcEngineMainProcActionTable ; 82/8000

        .addr rlProcEngineResetProcEngine
        .addr rlProcEngineMainProcLoop
        .addr rlProcEngineStub

      rlProcEngineResetProcEngine ; 82/8006

        .al
        .autsiz
        .databank ?

        ; The proc engine's init routine (aProcEngineMainProcActionTable +0): zeroes all
        ; of aProcSystem, freeing every proc.

        php
        phb
        phk
        plb

        ldx #size(aProcSystem) - 1
        sep #$20

        lda #0

          -
          sta aProcSystem.wFlag,b,x
          dec x
          bpl -

        rep #$20
        plb
        plp
        rtl

        .databank 0

      rlProcEngineCreateProc ; 82/801C

        .al
        .autsiz
        .databank ?

        ; Creates a proc from the definition (structProcInfo) at lR44.
        ;
        ; Takes the highest free slot (15 down to 0). While the engine is stepping procs
        ; (aProcSystem.wFlag bit 15), the slot being stepped is skipped even if its proc
        ; has just ended, so a proc that ends and creates another in the same step does
        ; not hand over its own slot. Fills the slot (sleep timer 1, bitfield, loop
        ; counter and body cleared), runs the init routine with X = the slot * 2 and DB =
        ; the definition's bank, then gives the proc one step at once and sets bitfield
        ; $4000 so rlProcEngineMainProcLoop skips it for the rest of this frame.
        ;
        ; Output: carry clear and A = the slot * 2; carry set if all 16 slots are taken.

        php
        phb
        phx
        phy

        sep #$20
        lda lR44+2
        pha
        rep #$20
        plb

        ldy lR44
        ldx #(16 - 1) * 2
        
          _Loop
          lda aProcSystem.wFlag,b
          bpl +

            cpx aProcSystem.wOffset,b
            beq _Next

          +
          lda aProcSystem.aHeaderTypeOffset,b,x
          beq _InitProc

          _Next
          dec x
          dec x
          bpl _Loop

        ply
        plx
        plb
        plp

        sec
        rtl

        _InitProc
        tya
        sta aProcSystem.aHeaderTypeOffset,b,x
        lda lR44+1
        and #$FF00
        sta aProcSystem.lPointer+1,b
        xba
        sta aProcSystem.aHeaderTypeBank,b,x

        lda #1
        sta aProcSystem.aHeaderSleepTimer,b,x

        lda #0
        sta aProcSystem.aHeaderBitfield,b,x
        sta aProcSystem.aHeaderLoopCounter,b,x
        sta aProcSystem.aBody0,b,x
        sta aProcSystem.aBody1,b,x
        sta aProcSystem.aBody2,b,x
        sta aProcSystem.aBody3,b,x
        sta aProcSystem.aBody4,b,x
        sta aProcSystem.aBody5,b,x
        sta aProcSystem.aBody6,b,x
        sta aProcSystem.aBody7,b,x

        lda $0000,b,y
        sta aProcSystem.aHeaderName,b,x
        lda $0002,b,y
        sta aProcSystem.lPointer,b
        lda $0004,b,y
        sta aProcSystem.aHeaderOnCycle,b,x
        lda $0006,b,y
        sta aProcSystem.aHeaderCodeOffset,b,x

        phx
        lda aProcSystem.wOffset,b
        pha
        stx aProcSystem.wOffset,b
        jsl rlProcEngineRunProcInit

        ldx aProcSystem.wOffset,b
        jsr rsProcEngineRunProcOnCycleAndCode

        lda aProcSystem.aHeaderBitfield,b,x
        ora #$4000
        sta aProcSystem.aHeaderBitfield,b,x

        pla
        sta aProcSystem.wOffset,b
        pla
        ply
        plx
        plb
        plp
        clc
        rtl

        .databank 0

      rlProcEngineRunProcInit ; 82/80BB

        .al
        .autsiz
        .databank ?

        ; Jumps to the init routine in aProcSystem.lPointer.

        jml [aProcSystem.lPointer]

        .databank 0

      rlProcEngineCreateProcByIndex ; 82/80BE

        .al
        .autsiz
        .databank ?

        ; Creates the proc at lR44 in slot A. Carry set if that slot is taken.

        php
        phb
        phx
        phy

        asl a
        tax
        ldy lR44

        sep #$20
        lda lR44+2
        pha
        rep #$20
        plb

        lda aProcSystem.aHeaderTypeOffset,b,x
        beq +

        ply
        plx
        plb
        plp
        sec
        rtl

        +
        jml rlProcEngineCreateProc._InitProc

        .databank 0

      rlProcEngineFreeProcByIndex ; 82/80DD

        .al
        .autsiz
        .databank ?

        ; Frees the proc in slot A. Carry set if the slot was already free.

        phb
        php
        phk
        plb
        phx

        asl a
        tax
        lda aProcSystem.aHeaderTypeOffset,b,x
        bne +

          plx
          plp
          plb
          sec

          -
          rtl

        +
        jsl rlProcEngineFreeProc
        plx 
        plp
        plb
        clc
        bra -

        .databank 0

      rlProcEngineCheckProcEnded ; 82/80F8

        .al
        .autsiz
        .databank ?

        ; A = a slot * 2. Carry set if bit $2000 (ended) is set in aLastFrameBitfield, the
        ; copy of the slot's bitfield taken at the end of the last frame. The bit stays
        ; there until another proc takes the slot.

        phb
        php
        phk
        plb
        phx

        tax
        lda aProcSystem.aLastFrameBitfield,b,x
        bit #$2000
        beq +

          plx
          plp
          plb
          sec

          -
          rtl

        +
        plx
        plp
        plb
        clc
        bra -

        .databank 0

      rlProcEngineFindProc ; 82/8111

        .al
        .autsiz
        .databank ?

        ; Finds the proc made from the definition at lR44. Carry set and X = its slot * 2
        ; if one is running (the highest slot first).

        phb
        php
        phk
        plb

        ldx #(16 - 1) * 2
        
          _Loop
          rep #$20
          lda aProcSystem.aHeaderTypeOffset,b,x
          cmp lR44
          bne _Next

            sep #$20
            lda aProcSystem.aHeaderTypeBank,b,x
            cmp lR44+2
            beq _SEC

          _Next
          dec x
          dec x
          bpl _Loop

        plp
        plb
        clc
        rtl
        
        _SEC
        plp
        plb
        sec
        rtl

        .databank 0

      rlProcEngineFreeProc ; 82/8136

        .al
        .autsiz
        .databank ?

        ; Frees the proc in slot X / 2: clears its definition and sets bitfield $2000
        ; (ended).

        stz aProcSystem.aHeaderTypeOffset,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$2000
        sta aProcSystem.aHeaderBitfield,b,x
        rtl

        .databank 0

      rlProcEngineMainProcLoop ; 82/8143

        .al
        .autsiz
        .databank ?

        ; The proc engine's per-frame routine (aTaskTable): steps every live proc, slot 15
        ; down to 0, with wFlag bit 15 set, then rsProcEngineUnblockAllProcs.

        php
        phb
        phk
        plb

        lda #$8000
        tsb aProcSystem.wFlag,b

        ldx #(16 - 1) * 2
        
          _loop
          stx aProcSystem.wOffset,b
          lda aProcSystem.aHeaderTypeOffset,b,x
          beq +

            jsr rsProcEngineRunProcOnCycleAndCode

          +
          ldx aProcSystem.wOffset,b
          dec x
          dec x
          bpl _loop

        jsr rsProcEngineUnblockAllProcs

        lda #$8000
        trb aProcSystem.wFlag,b

        plb
        plp
        rtl

        .databank 0

      rsProcEngineRunProcOnCycleAndCode ; 82/816E

        .al
        .autsiz
        .databank ?

        ; One step of the proc in slot X / 2, with DB = its bank.
        ;
        ; Bitfield $1000 skips the step entirely (only rsPauseMapProcsAndHDMAUnused sets
        ; it, and nothing calls that); $4000 skips it (created this frame). Otherwise runs
        ; the on-cycle routine and counts the sleep timer down. At 0 the script runs from
        ; aHeaderCodeOffset: a word with bit 15 set is the address of a command routine in
        ; bank $82 (Procs.h), which returns here to read on; a word below $8000 becomes
        ; the sleep timer and ends the step. PROC_YIELD 0 therefore sleeps 65,536 frames
        ; (the timer wraps).

        sep #$20
        lda aProcSystem.aHeaderTypeBank,b,x
        pha
        rep #$20
        plb

        lda aProcSystem.aHeaderBitfield,b,x
        bit #$1000
        bne _End

          bit #$4000
          beq +

            rts

          +
          jsl rlProcEngineRunProcOnCycle

          ldx aProcSystem.wOffset,b
          dec aProcSystem.aHeaderSleepTimer,b,x
          bne _End

            ldy aProcSystem.aHeaderCodeOffset,b,x

            _Loop
            lda $0000,b,y
            bpl +

              sta aProcSystem.lPointer,b
              inc y
              inc y
              pea #<>_Loop - 1
              jmp (aProcSystem.lPointer)

            +
            sta aProcSystem.aHeaderSleepTimer,b,x
            tya
            clc
            adc #2
            sta aProcSystem.aHeaderCodeOffset,b,x

        _End
        rts

        .databank 0

      rlProcEngineRunProcOnCycle ; 82/81B0

        .al
        .autsiz
        .databank ?

        ; Jumps to the on-cycle routine of the proc in slot X / 2.

        lda aProcSystem.aHeaderTypeBank,b,x
        xba
        sta aProcSystem.lPointer+1,b
        lda aProcSystem.aHeaderOnCycle,b,x
        sta aProcSystem.lPointer,b
        jml [aProcSystem.lPointer]

        .databank 0

      rsProcEngineUnblockAllProcs ; 82/81C0

        .al
        .autsiz
        .databank ?

        ; At the end of the frame: clears bit $4000 (created this frame) of every slot's
        ; bitfield and copies the bitfield to aLastFrameBitfield, which
        ; rlProcEngineCheckProcEnded reads.

        ldx #(16 - 1) * 2
        
          _Loop
          lda aProcSystem.aHeaderBitfield,b,x
          and #~$4000
          sta aProcSystem.aHeaderBitfield,b,x
          sta aProcSystem.aLastFrameBitfield,b,x
          dec x
          dec x
          bpl _Loop

        rts

        .databank 0

      rlProcEngineStub ; 82/81D4

        .al
        .autsiz
        .databank ?

        ; The third routine of aProcEngineMainProcActionTable. Nothing reads that entry
        ; (see rlRegisterVBlankHook).

        rtl

    .endsection ProcEngineSection


    .section ProcCodeSection

      .al
      .xl

      rsProcCodeEnd ; 82/81D5

        .al
        .autsiz
        .databank ?

        ; PROC_END: frees the proc and ends the step.

        stz aProcSystem.aHeaderTypeOffset,b,x

        lda aProcSystem.aHeaderBitfield,b,x
        ora #$2000
        sta aProcSystem.aHeaderBitfield,b,x

        pla
        rts

        .databank 0

      rsProcCodeHaltSleep ; 82/81E3

        .al
        .autsiz
        .databank ?

        ; PROC_HALT_SLEEP: as PROC_HALT, with the sleep timer set to 1 so the halt is read
        ; again every frame. No script uses it.

        lda #1
        sta aProcSystem.aHeaderSleepTimer,b,x

      rsProcCodeHalt ; 82/81E9

        .al
        .autsiz
        .databank ?

        ; PROC_HALT: leaves the script on this command and ends the step. The sleep timer
        ; stays at 0, so it wraps and the script is not read again for 65,536 frames; only
        ; the on-cycle routine runs. A proc halts until its on-cycle routine frees it or
        ; changes aHeaderCodeOffset.

        dec y
        dec y
        tya
        sta aProcSystem.aHeaderCodeOffset,b,x

        pla
        rts

        .databank 0

      rsProcCodeCall ; 82/81F1

        .al
        .autsiz
        .databank ?

        ; PROC_CALL: calls the long routine in the next three bytes, with X = the slot *
        ; 2.

        lda $0000,b,y
        sta aProcSystem.lPointer,b
        lda $0001,b,y
        sta aProcSystem.lPointer+1,b

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
        jml [aProcSystem.lPointer]

        .databank 0

      rsProcCodeCallWithArgs ; 82/820C

        .al
        .autsiz
        .databank ?

        ; PROC_CALL_ARGS: calls the long routine in the next three bytes with Y pointing
        ; at the arguments after the count byte, then skips that many bytes.

        lda $0000,b,y
        sta aProcSystem.lPointer,b
        lda $0001,b,y
        sta aProcSystem.lPointer+1,b

        lda $0003,b,y
        and #$00FF
        pha

        inc y
        inc y
        inc y
        inc y

        phy
        phx
        jsl +
        plx
        ply

        pla
        sta wR0
        tya
        clc
        adc wR0
        tay
        rts
        
        +
        jml [aProcSystem.lPointer]

        .databank 0

      rsProcCodeSetOnCycle ; 82/8237

        .al
        .autsiz
        .databank ?

        ; PROC_SET_ONCYCLE: sets the on-cycle routine (same bank) and bitfield $0800.

        lda $0000,b,y
        sta aProcSystem.aHeaderOnCycle,b,x

        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0800
        sta aProcSystem.aHeaderBitfield,b,x

        inc y
        inc y
        rts

        .databank 0

      rsProcCodeJump ; 82/8249

        .al
        .autsiz
        .databank ?

        ; PROC_JUMP: continues at the next word.

        lda $0000,b,y
        tay
        rts

        .databank 0

      rsProcCodeSetLoopCounter ; 82/824E

        .al
        .autsiz
        .databank ?

        ; PROC_SET_LOOP_COUNTER: sets aHeaderLoopCounter to the next word.

        lda $0000,b,y
        sta aProcSystem.aHeaderLoopCounter,b,x

        inc y
        inc y
        rts

        .databank 0

      rsProcCodeJumpWhileLoopCounter ; 82/8257

        .al
        .autsiz
        .databank ?

        ; PROC_JUMP_WHILE_LOOP_COUNTER: counts aHeaderLoopCounter down and jumps while it
        ; is not 0.

        dec aProcSystem.aHeaderLoopCounter,b,x
        bne rsProcCodeJump

        inc y
        inc y
        rts

        .databank 0

      rsProcCodeJumpIfBitsUnset ; 82/825F

        .al
        .autsiz
        .databank ?

        ; PROC_JUMP_IF_BITS_UNSET: jumps to the first word if none of the bits in the
        ; second are set in the proc's bitfield. With a PROC_YIELD before it and its own
        ; position as the target, it waits until a routine sets the bit; scripts use bits
        ; $0001, $0002 and $0004 this way.

        lda $0002,b,y
        bit aProcSystem.aHeaderBitfield,b,x
        beq rsProcCodeJump

        inc y
        inc y
        inc y
        inc y
        rts

        .databank 0

      rsProcCodeJumpIfBitsSet ; 82/826C

        .al
        .autsiz
        .databank ?

        ; PROC_JUMP_IF_BITS_SET: jumps if any of the bits are set.

        lda $0002,b,y
        bit aProcSystem.aHeaderBitfield,b,x
        bne rsProcCodeJump

        inc y
        inc y
        inc y
        inc y
        rts

        .databank 0

      rsProcCodeCreateActiveSprite ; 82/8279

        .al
        .autsiz
        .databank ?

        ; PROC_CREATE_ACTIVE_SPRITE: creates the active sprite whose definition is in the
        ; next three bytes, at the X and Y in the two words after
        ; (rlActiveSpriteEngineCreateSpriteHighestSlot). No script uses it.

        phy
        lda $0000,b,y
        sta lR44
        lda $0001,b,y
        sta lR44+1

        lda $0003,b,y
        pha
        lda $0005,b,y
        pha

        ply
        plx
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot

        pla
        clc
        adc #7
        tay
        rts

        .databank 0

        ; 82/8299

    .endsection ProcCodeSection
