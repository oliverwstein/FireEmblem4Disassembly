; Game state dispatch table (aGameStateRoutines) and per-VBlank hook registry.


    .section Unsorted809B00Section

      .al
      .xl

      rlGameStateNone ; 80/9B00

        .al
        .xl
        .autsiz
        .databank ?

        ; Empty RTL routine for GAMESTATE_NONE (index 0)

        rtl

        .databank 0

        ; 80/9B01

    .endsection Unsorted809B00Section


    .section Unsorted809B01Section

      .al
      .xl

      aGameStateRoutines ; 80/9B01

        .long rlGameStateNone
        .long rlOpeningLogoUpkeep
        .long rlOpeningLogoSetup
        .long rlOpeningLogoStep
        .long rlSaveMenuUpkeep
        .long rlSaveMenuSetup
        .long rlSaveMenuStep
        .long rlStatusScreenUpkeep
        .long rlStatusScreenSetup
        .long rlStatusScreenStep
        .long rlCastleScreenUpkeep
        .long rlCastleScreenSetup
        .long rlCastleScreenStep
        .long rlWorldMapUpkeep
        .long rlWorldMapSetup
        .long rlWorldMapStep
        .long rlMapUpkeep
        .long rlMapSetup
        .long rlMapStep
        .long rlUnusedGameState13
        .long rlUnusedGameState14
        .long rlUnusedGameState15
        .long rlUnusedScreenSetup
        .long rlUnusedScreenStep
        .long rlBattleSceneSetup
        .long rlBattleSceneStep
        .long rlTitleScreenSetup
        .long rlTitleScreenStep
        .long aUnused9FFACC ; unused: points into zero padding
        .long aUnused9FFACC ; unused: points into zero padding
        .long aUnused9FFACC ; unused: points into zero padding
        .long aUnused9FFACC ; unused: points into zero padding
        .long rlUnitWindowHandleInput
        .long rlUnitWindowShow
        .long rlUnitWindowRunPageTurnInput
        .long rlItemWindowRender
        .long rlItemWindowShow
        .long rlItemWindowRunStep
        .long rlDebugMenuTabInputHandler
        .long rlDebugMenuSetup
        .long rlDebugMenuPageInputHandler
        .long rlOptionsMenuUpkeep
        .long rlOptionsMenuSetup
        .long rlOptionsMenuStep
        .long rlSkillWindowRender
        .long rlSkillWindowShow
        .long rlSkillWindowRunStep
        .long rlDataWindowRender
        .long rlDataWindowShow
        .long rlDataWindowRunStep
        .long rlReviveScreenUpkeep
        .long rlReviveScreenSetup
        .long rlReviveScreenStep
        .long rlEpilogueUpkeep
        .long rlEpilogueSetup
        .long rlEpilogueStep

      rlRunGameStateRoutines ; 80/9BA9

        .al
        .autsiz
        .databank ?

        phb

        lda wGameStateRoutine1,b
        asl a
        adc wGameStateRoutine1,b
        jsr rsDispatchGameStateRoutine

        lda wGameStateRoutine2,b
        asl a
        adc wGameStateRoutine2,b
        jsr rsDispatchGameStateRoutine

        plb
        rtl

        .databank 0

      rsDispatchGameStateRoutine ; 80/9BC0

        .al
        .autsiz
        .databank ?

        ; Indexes aGameStateRoutines; bank $7D redirects wGameStateRoutine1, else sets DB and calls rlJumpToGameStateRoutine

        tax
        sep #$20
        lda aGameStateRoutines+2,x
        cmp #$7D
        beq +

          sta $24+2

          pha
          plb

          rep #$20
          lda aGameStateRoutines,x
          sta $24
          jsl rlJumpToGameStateRoutine

          _9BDB
          rep #$30
          rts

        +
        rep #$20
        lda aGameStateRoutines,x
        sta wGameStateRoutine1,b
        jml rsDispatchGameStateRoutine._9BDB

        .databank 0

      rlJumpToGameStateRoutine ; 80/9BEB

        .al
        .autsiz
        .databank ?

        ; Long jump trampoline jml [$24] for rsDispatchGameStateRoutine

        jml [$24]

        .databank 0

        ; 80/9BEE

    .endsection Unsorted809B01Section


    .section Unsorted809BEESection

      .as
      .xl

      rlResetVBlankHookTable ; 80/9BEE

        .al
        .xl
        .autsiz
        .databank ?

        ; Clears the 16-slot (48-byte) per-VBlank engine hook array at $0309..$0338

        php
        phb
        phk
        plb
        .databank $80
        sep #$20
        ldx #$002F
        lda #$00

        _9BF9
        sta aTaskTable.lEntry0,b,x
        dec x
        bpl _9BF9
        rep #$20
        plb
        .databank $80
        plp
        rtl

        .databank 0

        ; 80/9C04

      rlRegisterVBlankHook ; 80/9C04

        .al
        .xl
        .autsiz
        .databank ?

        ; Registers a 3-byte VBlank cycle callback from [lR44]+2 into $0309..$0338 and runs init at [lR44]+0

        phb
        phk
        plb
        .databank $80
        phx
        phy
        ldx #$002D

        _9C0C
        lda aTaskTable.lEntry0,b,x
        beq _9C1B
        dec x
        dec x
        dec x
        bpl _9C0C
        ply
        plx
        plb
        .databank ?
        sec
        rtl


        _9C1B
        ldy #$0000
        lda lR44+1
        sta aTaskTable.lEntry0+1,b,x
        sta lTaskJumpPointer+1,b
        lda [lR44],y
        sta lTaskJumpPointer,b
        inc y
        inc y
        lda [lR44],y
        sta aTaskTable.lEntry0,b,x
        jsl rlRunVBlankHookInit
        ply
        plx
        plb
        .databank ?
        clc
        rtl

        .databank 0

        ; 80/9C3B

      rlRunVBlankHookInit ; 80/9C3B

        .al
        .xl
        .autsiz
        .databank ?

        ; Long jump trampoline jml [$0306] for rlRegisterVBlankHook

        jml [$0306]

        .databank 0

        ; 80/9C3E

    .endsection Unsorted809BEESection


    .section Unreferenced809C3ESection

      .as
      .xl

      rlUnknown809C3E ; 80/9C3E

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        phk
        plb
        .databank $80
        ldy #$0002
        lda lR44+1
        sta lTaskJumpPointer+1,b
        lda [lR44],y
        sta lTaskJumpPointer,b
        ldx #$002D

        _9C51
        lda aTaskTable.lEntry0+1,b,x
        cmp lTaskJumpPointer+1,b
        bne _9C61
        lda aTaskTable,b,x
        cmp lTaskJumpPointer,b
        beq _9C69

        _9C61
        dec x
        dec x
        dec x
        bpl _9C51
        plb
        .databank $80
        sec
        rtl


        _9C69
        ldy #$0004
        lda [lR44],y
        sta lTaskJumpPointer,b
        jsl rlUnknown809C77
        clc
        rtl

        .databank 0

        ; 80/9C77

      rlUnknown809C77 ; 80/9C77

        ; Called only by the unreferenced rlUnknown809C3E: jumps through the
        ; long pointer at $0306.

        jml [$0306]

    .endsection Unreferenced809C3ESection
    .section Unsorted809C7ASection

      .al
      .xl

      rlRunVBlankHooks ; 80/9C7A

        .al
        .xl
        .autsiz
        .databank ?

        ; Executes all active 24-bit callbacks in $0309..$0338 each VBlank

        php
        phb
        phk
        plb
        .databank $80
        ldx #$002D

        _9C81
        phx
        lda aTaskTable.lEntry0,b,x
        beq _9C94
        sta lTaskJumpPointer,b
        lda aTaskTable.lEntry0+1,b,x
        sta lTaskJumpPointer+1,b
        jsl rlRunVBlankHookCycle

        _9C94
        plx
        dec x
        dec x
        dec x
        bpl _9C81
        plb
        .databank ?
        plp
        rtl

        .databank 0

        ; 80/9C9D

      rlRunVBlankHookCycle ; 80/9C9D

        .al
        .xl
        .autsiz
        .databank ?

        ; Long jump trampoline jml [$0306] for rlRunVBlankHooks

        jml [$0306]

        .databank 0

        ; 80/9CA0

    .endsection Unsorted809C7ASection


    .section Unsorted8BA7CBSection

      .al
      .xl

      rlUnusedGameState13 ; 8B/A7CB

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $13: does nothing; nothing selects it.

        rtl

        .databank 0

        ; 8B/A7CC

      rlUnusedGameState14 ; 8B/A7CC

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $14: does nothing; nothing selects it.

        rtl

        .databank 0

        ; 8B/A7CD

      rlUnusedGameState15 ; 8B/A7CD

        .al
        .xl
        .autsiz
        .databank ?

        ; Game state routine $15: does nothing; nothing selects it.

        rtl

        .databank 0

        ; 8B/A7CE

        ; Unreachable: it follows a return.
        rts

      aProgrammerCredit ; 8B/A7CF

        ; Unreferenced: a signature left in the ROM.
        .text "  -- Programed by Takahiro Ohgi -- "

    .endsection Unsorted8BA7CBSection


