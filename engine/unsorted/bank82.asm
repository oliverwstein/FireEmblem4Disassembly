; Code from bank $82 not yet assigned to a game system.

    .section Unsorted828A30Section

      .al
      .xl

      procUnknown828A30 ; 82/8A30

        .structProcInfo "TT", rlProcUnknown828A30Init, rlProcUnknown828A30Cycle1, $828A86

        .word 0

      rlProcUnknown828A30Init ; 82/8A3A

        .al
        .autsiz
        .databank ?

        ldy wActiveEventOffset,b
        lda lActiveEventPointer,b
        sta @l lR22
        lda lActiveEventPointer+1,b
        sta @l lR22+1
        lda [lR22],y
        sta aProcSystem.aBody0,b,x
        rtl

        .databank 0

      rlProcUnknown828A30Cycle1 ; 82/8A51

        .al
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #INIDISP_Brightness
        cmp #INIDISP_Setting(false, 0)
        bne _End

          lda aProcSystem.aBody0,b,x
          bit #$0080
          bne +

            lda #<>rlProcUnknown828A30Cycle2
            sta aProcSystem.aHeaderOnCycle,b,x
            bra _End

          +
          lda bBufferINIDISP
          bit #INIDISP_ForcedBlank
          bne _End

            jsl rlEventEngineFreeProc

        _End
        rtl

        .databank 0

      rlProcUnknown828A30Cycle2 ; 82/8A77

        .al
        .autsiz
        .databank ?

        lda bBufferINIDISP
        and #INIDISP_Brightness
        cmp #INIDISP_Setting(false, 15)
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown828A30Code ; 82/8A86

        PROC_HALT

      procUnknown828A88 ; 82/8A88

        .structProcInfo "LL", rlProcUnknown828A88Init, $82899F, $828A1A

        .word 0

      rlProcUnknown828A88Init ; 82/8A92

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      procUnknown828A93 ; 82/8A93

        .structProcInfo "TT", rlProcUnknown828A93Init, rlProcUnknown828A93Cycle1, aProcUnknown828A93Code

        .word 0

      rlProcUnknown828A93Init ; 82/8A9D

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlProcUnknown828A93Cycle1 ; 82/8A9E

        .al
        .autsiz
        .databank ?

        lda bUnknown000E7B,b
        bit #$0001
        bne +

          lda #4
          sta aProcSystem.aBody0,b,x
          lda #<>rlProcUnknown828A93Cycle2
          sta aProcSystem.aHeaderOnCycle,b,x

        +
        rtl

        .databank 0

      rlProcUnknown828A93Cycle2 ; 82/8AB3

        .al
        .autsiz
        .databank ?

        lda aProcSystem.aBody0,b,x
        dec a
        sta aProcSystem.aBody0,b,x
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown828A93Code ; 82/8AC1

        PROC_HALT

      procUnknown828AC3 ; 82/8AC3

        .structProcInfo "ME", rlProcUnknown828AC3Init, rlProcUnknown828AC3Cycle, aProcUnknown828AC3Code

        .word 0

      rlProcUnknown828AC3Init ; 82/8ACD

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlUnknown828ACE ; 82/8ACE

        .al
        .autsiz
        .databank ?

        lda #1
        sta aDialogue.wTextSound,b

        lda aDialogue.wStatus,b
        bit #DialogueStatusEnabled
        beq +

          lda #<>rlProcUnknown828AC3Cycle
          sta aProcSystem.aHeaderOnCycle,b,x

        +
        rtl

        .databank 0

      rlProcUnknown828AC3Cycle ; 82/8AE3

        .al
        .autsiz
        .databank ?

        lda aDialogue.wStatus,b
        bit #DialogueStatusEnabled
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown828AC3Code ; 82/8AF0

        PROC_HALT

      procUnknown828AF2 ; 82/8AF2

        .structProcInfo "ME", rlProcUnknown828AF2Init, rlProcUnknown828AF2Cycle, aProcUnknown828AF2Code

        .word 0

      rlUnknown828AFC ; 82/8AFC

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlUnknown828AFD ; 82/8AFD

        .al
        .autsiz
        .databank ?

        lda $04BA,b
        bne +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcCodeUnknown828B07 ; 82/8B07

        PROC_HALT

      procUnknown828AD9 ; 82/8AD9

        .structProcInfo "ME", rlProcUnknown828AF2Init, rlProcUnknown828AF2Cycle, aProcUnknown828AF2Code

        .word 0

      rlProcUnknown828AF2Init ; 82/8B13

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlProcUnknown828AF2Cycle ; 82/8B14
      
        .al
        .autsiz
        .databank ?

        lda #(`procUnknown9EC70B)<<8
        sta lR44+1
        lda #<>procUnknown9EC70B
        sta lR44
        jsl rlProcEngineFindProc
        bcs +

          jsl rlEventEngineFreeProc

        +
        rtl

        .databank 0

      aProcUnknown828AF2Code ; 82/8B29

        PROC_HALT

      ; 82/8B2B

    .endsection Unsorted828A30Section
