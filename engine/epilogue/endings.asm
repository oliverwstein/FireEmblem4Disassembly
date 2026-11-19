; Working out which epilogue each character gets.

    .section EpilogueEndingsSection

      .al
      .xl

      rlSetParentsPermanentFlags ; 82/F866

        .al
        .autsiz
        .databank ?

        ; Run at the start of ch6

        phb
        phx
        phy
        phk
        plb
        ldx #Sigurd
        
          _Loop
          txa

          jsl rlGetUnitRAMDataPointerByID
          bcs _NotFound

            txa
            clc
            adc #40
            jsl rlSetPermanentEventFlag

            jsl rlGetSelectedUnitStates
            and #UnitStateDead
            bne _Dead

            txa
            clc
            adc #64
            jsl rlSetPermanentEventFlag
            bra _Next

          _NotFound
          txa
          clc
          adc #40
          jsl rlUnsetPermanentEventFlag

          _Dead
          txa
          clc
          adc #64
          jsl rlUnsetPermanentEventFlag

          _Next
          inc x
          cpx #Seliph
          bne _Loop

        ply
        plx
        plb
        rtl

        .databank 0

      rlEvaluateEpilogueEndings ; 82/F8AE

        .al
        .autsiz
        .databank ?

        ; Evaluates what characters get what ending scenes

        phb
        phx
        phy
        phk
        plb
        ldx #0
        txa
        sep #$20

          -
          sta aEpilogueMainCharacters,x
          sta aEpilogueSupportingCharacters,x
          sta aEpilogueChosenDialogueID,x
          inc x
          cpx #50
          bne -

        rep #$20
        lda #$FFFF
        sta aEpilogueUnitProcessedFlags

        jsr rsEpilogueGetParentsEpilogueStates
        jsr rsEpilogueGetChildrenEpilogueStates
        jsr rsEvaluateEpiloguePriorities
        jsr rsEvaluateEpilogueDialogueIDs

        jsr rsUnknown82FDC1
        jsr rsUnknown82FE07
        jsr rsUnknown82FE41
        ply
        plx
        plb
        rtl

        .databank 0

      rsEpilogueGetParentsEpilogueStates ; 82/F8ED

        .al
        .autsiz
        .databank ?

        ldx #2
        
        _Loop
        lda #$FFFF
        sta aEpilogueUnitProcessedFlags,x
        txa
        lsr a
        adc #40
        jsl rlCheckPermanentEventFlagSet
        bcs _ParentRecruited

          lda #($8000 | $4000)
          sta aEpilogueUnitStates,x
          bra _Next

        _ParentRecruited
        txa
        lsr a
        adc #64
        jsl rlCheckPermanentEventFlagSet
        bcc _ParentDied

          lda #0
          sta aEpilogueUnitStates,x
          bra _Next

        _ParentDied
        lda #$8000
        sta aEpilogueUnitStates,x

        _Next
        inc x
        inc x
        cpx #50
        bne _Loop

        ldx #0

        ; For all parents, save their partners in each others states.
        _Loop2
        lda _F96C,x
        and #$00FF
        beq _End

        jsl rlGetUnitRAMDataPointerByID
        bcs +

          phx
          jsl rlGetSelectedUnitFatherID
          pha

          asl a
          tax
          jsl rlGetSelectedUnitMotherID
          ora aEpilogueUnitStates,x
          ora #$2000
          sta aEpilogueUnitStates,x
          and #$00FF
          asl a
          tax

          pla
          ora aEpilogueUnitStates,x
          ora #$2000
          sta aEpilogueUnitStates,x
          plx

        +
        inc x
        bra _Loop2

        _End
        rts

        .databank 0

        _F96C ; 82/F96C

        ; Seems kind of like Gen2 recruitment order but Lester doesnt fit.

        .byte Seliph
        .byte Leif
        .byte Diarmuid
        .byte Scathach
        .byte Fee
        .byte Arthur
        .byte Lene
        .byte Lester
        .byte Patty
        .byte 0

      rsEpilogueGetChildrenEpilogueStates ; 82/F976

        .al
        .autsiz
        .databank ?

        ldx #Seliph * 2
        
        _Loop
        lda #$FFFF
        sta aEpilogueUnitProcessedFlags,x
        txa
        lsr a
        jsl rlGetUnitRAMDataPointerByID
        bcc _UnitExists

          -
          lda #($8000 | $4000)
          sta aEpilogueUnitStates,x
          bra _Next

        _UnitExists
        jsl rlGetSelectedUnitFactionSlot
        cmp #FS_Player
        bne -

        jsl rlGetSelectedUnitStates
        and #UnitStateDead
        beq +

          lda #$8000

        +
        sta aEpilogueUnitStates,x
        bne _Next

          jsl rlGetSelectedUnitLoverGenerationID
          cmp #0
          beq _Next

            jsl rlFindCharacterByGenerationID
            bcc +

              brk

            +
            jsl rlGetSelectedUnitCharacterID
            ora aEpilogueUnitStates,x
            ora #$2000
            sta aEpilogueUnitStates,x

        _Next
        inc x
        inc x
        cpx #64 * 2
        bne _Loop

        rts

        .databank 0

      rsEvaluateEpiloguePriorities ; 82/F9D3

        .al
        .autsiz
        .databank ?

        ldx #0

          _Loop
          lda aEpiloguePriorityList+2,x
          and #$00FF
          sta wR1
          lda aEpiloguePriorityList+1,x
          and #$00FF
          sta wR0
          lda aEpiloguePriorityList,x
          and #$00FF
          cmp #$00FF
          beq _End

            phx
            asl a
            tax
            jsr (aEpiloguePriorityRoutines,x)

            plx
            inc x
            inc x
            inc x
            bra _Loop

        _End
        rts

        .databank 0

      aEpiloguePriorityRoutines .include "../../TABLES/SYSTEM/EpiloguePriorityRoutines.csv.asm" ; 82/FA01

      aEpiloguePriorityList ; 82/FA1B

        .byte EPrio_StartRegion,        Seliph,     SeliphEpilogueID
        .byte EPrio_Main,               Julia,      JuliaEpilogueID

        .byte EPrio_StartRegion_IfSon,  Jamke,      JamkesSonEpilogueID
        .byte EPrio_Main_IfDaughter,    Jamke,      JamkesDaughterEpilogueID

        .byte EPrio_StartRegion_IfSon,  Lex,        LexSonEpilogueID
        .byte EPrio_Main_IfDaughter,    Lex,        LexDaughterEpilogueID
        .byte EPrio_FollowUp2,          Iuchar,     IucharEpilogueID
        .byte EPrio_FollowUp2,          Iucharba,   IucharbaEpilogueID

        .byte EPrio_StartRegion_IfSon,  Claud,      ClaudsSonEpilogueID
        .byte EPrio_Main_IfDaughter,    Claud,      ClaudsDaughterEpilogueID

        .byte EPrio_StartRegion_IfSon,  Azelle,     AzellesSonEpilogueID
        .byte EPrio_Main_IfDaughter,    Azelle,     AzellesDaughterEpilogueID

        .byte EPrio_StartRegion_IfSon,  Lewyn,      LewnysSonEpilogueID
        .byte EPrio_Main_IfDaughter,    Lewyn,      LewnysDaughterEpilogueID

        .byte EPrio_StartRegion,        Shannan,    ShannanEpilogueID
        .byte EPrio_FollowUp1,          Scathach,   ScathachEpilogueID
        .byte EPrio_Main_NoPriority2,   Larcei,     LarceiEpilogueID

        .byte EPrio_StartRegion,        Leif,       LeifEpilogueID
        .byte EPrio_FollowUp1,          Altena,     AltenaEpilogueID

        .byte EPrio_StartRegion,        Ares,       AresEpilogueID
        .byte EPrio_FollowUp1,          Diarmuid,   DiarmuidEpilogueID
        .byte EPrio_Main_NoPriority2,   Nanna,      NannaEpilogueID

        .byte EPrio_StartRegion,        Oifey,      OifeyEpilogueID

        .byte EPrio_StartRegion,        Febail,     FebailEpilogueID
        .byte EPrio_Main_NoPriority1,   Patty,      PattyEpilogueID
        .byte EPrio_FollowUp2,          Lester,     LesterEpilogueID
        .byte EPrio_Main_NoPriority3,   Lana,       LanaEpilogueID

        .byte EPrio_StartRegion,        Arthur,     ArthurEpilogueID
        .byte EPrio_Sub_FollowUp,       Amid,       AmidEpilogueID
        .byte EPrio_Main_NoPriority1,   Tine,       TineEpilogueID
        .byte EPrio_Main_NoPriority1,   Linda,      LindaEpilogueID

        .byte EPrio_Main,               Dalvin,     DalvinEpilogueID
        .byte EPrio_Main,               Deimne,     DeimneEpilogueID
        .byte EPrio_Main,               AdultFinn,  FinnEpilogueID
        .byte EPrio_Main,               Hannibal,   HannibalEpilogueID
        .byte EPrio_Main,               Charlot,    CharlotEpilogueID
        .byte EPrio_Main,               Coirpre,    CoirpreEpilogueID
        .byte EPrio_Main,               Asaello,    AsaelloEpilogueID
        .byte EPrio_Main,               Tristan,    TristanEpilogueID
        .byte EPrio_Main,               Ced,        CedEpilogueID
        .byte EPrio_Main,               Hawk,       HawkEpilogueID

        .byte EPrio_Male_Lover,         Seliph,     SeliphEpilogueID
        .byte EPrio_Son_Lover,          Jamke,      JamkesSonEpilogueID
        .byte EPrio_Son_Lover,          Lex,        LexSonEpilogueID
        .byte EPrio_Son_Lover,          Claud,      ClaudsSonEpilogueID
        .byte EPrio_Son_Lover,          Azelle,     AzellesSonEpilogueID
        .byte EPrio_Son_Lover,          Lewyn,      LewnysSonEpilogueID
        .byte EPrio_Male_Lover,         Iuchar,     IucharEpilogueID
        .byte EPrio_Male_Lover,         Iucharba,   IucharbaEpilogueID
        .byte EPrio_Male_Lover,         Shannan,    ShannanEpilogueID
        .byte EPrio_Male_Lover,         Scathach,   ScathachEpilogueID
        .byte EPrio_Male_Lover,         Leif,       LeifEpilogueID
        .byte EPrio_Male_Lover,         Ares,       AresEpilogueID
        .byte EPrio_Male_Lover,         Diarmuid,   DiarmuidEpilogueID
        .byte EPrio_Male_Lover,         Oifey,      OifeyEpilogueID
        .byte EPrio_Male_Lover,         Febail,     FebailEpilogueID
        .byte EPrio_Male_Lover,         Lester,     LesterEpilogueID
        .byte EPrio_Male_Lover,         Arthur,     ArthurEpilogueID
        .byte EPrio_Male_Lover,         Amid,       AmidEpilogueID
        .byte EPrio_Male_Lover,         Dalvin,     DalvinEpilogueID
        .byte EPrio_Male_Lover,         Deimne,     DeimneEpilogueID
        .byte EPrio_Male_Lover,         Charlot,    CharlotEpilogueID
        .byte EPrio_Male_Lover,         Coirpre,    CoirpreEpilogueID
        .byte EPrio_Male_Lover,         Asaello,    AsaelloEpilogueID
        .byte EPrio_Male_Lover,         Tristan,    TristanEpilogueID
        .byte EPrio_Male_Lover,         Ced,        CedEpilogueID
        .byte EPrio_Male_Lover,         Hawk,       HawkEpilogueID
        .byte EPrio_Daughter_Main_NoPriority, Jamke,  JamkesDaughterEpilogueID
        .byte EPrio_Daughter_Main_NoPriority, Lex,    LexDaughterEpilogueID
        .byte EPrio_Daughter_Main_NoPriority, Claud,  ClaudsDaughterEpilogueID
        .byte EPrio_Daughter_Main_NoPriority, Azelle, AzellesDaughterEpilogueID
        .byte EPrio_Daughter_Main_NoPriority, Lewyn,  LewnysDaughterEpilogueID

        .byte EPrio_Main,               Larcei,     LarceiEpilogueID
        .byte EPrio_Main,               Nanna,      NannaEpilogueID
        .byte EPrio_Main,               Patty,      PattyEpilogueID
        .byte EPrio_Main,               Lana,       LanaEpilogueID
        .byte EPrio_Main,               Tine,       TineEpilogueID
        .byte EPrio_Main,               Linda,      LindaEpilogueID
        .byte EPrio_Main,               Creidne,    CreidneEpilogueID
        .byte EPrio_Main,               Muirne,     MuirneEpilogueID
        .byte EPrio_Main,               Daisy,      DaisyEpilogueID
        .byte EPrio_Main,               Lene,       LeneEpilogueID
        .byte EPrio_Main,               Laylea,     LayleaEpilogueID
        .byte EPrio_Main,               Jeanne,     JeanneEpilogueID
        .byte EPrio_Main,               Fee,        FeeEpilogueID
        .byte EPrio_Main,               Hermina,    HerminaEpilogueID

        .char -1

      rsEpilogueSetDaughterMainCharacterNoPriority ; 82/FB1E

        .al
        .autsiz
        .databank ?

        ; If daughter exists:
        ; Save unit in main character table

        lda wR0
        jsl rlGetFatherUnitsChildrenRAMPointers

        lda wDaughterCharacterROMPointer
        beq rsEpiloguePriorityHandleUnprocessedCharacters._End

          sta wSelectedUnitDataRAMPointer,b
          jsl rlGetSelectedUnitCharacterID
          sta wR0

      rsEpilogueSetMainCharacterNoPriority ; 82/FB33

        .al
        .autsiz
        .databank ?

        ; Save unit in main character table

        ldy #0

      rsEpiloguePriorityHandleUnprocessedCharacters ; 82/FB36

        .al
        .autsiz
        .databank ?

        lda wR0
        asl a
        tax
        lda aEpilogueUnitStates,x
        and #$8000
        bne _End

          lda aEpilogueUnitProcessedFlags,x
          bpl _End

            tya
            ora aEpilogueUnitStates,x
            sta aEpilogueUnitStates,x

            lda wR1
            sta aEpilogueUnitProcessedFlags,x
            tax
            sep #$20
            lda wR0
            cpy #$0200
            beq +

              sta aEpilogueMainCharacters,x
              bra ++

              +
              sta aEpilogueSupportingCharacters,x

            +
            rep #$20
            cpy #$0100
            bne _End

              lda #1
              sta wR3

        _End ; FB78
        rts

        .databank 0

      rsEpilogueSetMainCharacterFollowUpPriority ; 82/FB79

        .al
        .autsiz
        .databank ?

        ; Save unit in main character table and set priority
        ; if nobody had it yet.

        lda wR3
        beq rsEpilogueStartRegionPriority

        bra rsEpilogueSetMainCharacterNoPriority

      rsEpilogueStartRegionPriorityIfSonExists ; 82/FB7F

        .al
        .autsiz
        .databank ?

        ; Nulls wR3, the priority set flag
        ; If units son exists:
        ; If unit is alive, they set the flag and get saved in
        ; the main character table.

        lda #0
        sta wR3
        lda wR0
        jsl rlGetFatherUnitsChildrenRAMPointers
        lda wSonCharacterROMPointer
        beq rsEpiloguePriorityHandleUnprocessedCharacters._End

        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta wR0

      rsEpilogueStartRegionPriority ; 82/FB99

        .al
        .autsiz
        .databank ?

        ; Nulls wR3, the priority set flag
        ; If unit is alive, they set the flag and get saved in
        ; the main character table.

        lda #0
        sta wR3
        ldy #$0100
        bra rsEpiloguePriorityHandleUnprocessedCharacters

      rsEpilogueSetMainCharacerOnNoPriorityIfDaughterExists ; 82/FBA3

        .al
        .autsiz
        .databank ?

        ; If daughter exists check:

        ; If nobody has priority yet, unit gets saved in the main
        ; character table.
        ; If priority is set, unit doesnt get an epilogue.

        lda wR0
        jsl rlGetFatherUnitsChildrenRAMPointers

        lda wDaughterCharacterROMPointer
        beq rsEpiloguePriorityHandleUnprocessedCharacters._End

        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta wR0

      rsEpilogueSetMainCharacerOnNoPriority ; 82/FBB8

        .al
        .autsiz
        .databank ?

        ; If nobody has priority yet, unit gets saved in the main
        ; character table.
        ; If priority is set, unit doesnt get an epilogue.

        lda wR3
        beq rsEpilogueStartRegionPriority

        rts

        .databank 0

      rsEpiloguePrioritySetSonsLover ; 82/FBBD

        .al
        .autsiz
        .databank ?

        ; If son exists check:
        ; If unit is married:
        ; Process the lover and save her in the supporting
        ; character table.

        lda wR0
        jsl rlGetFatherUnitsChildrenRAMPointers
        lda wSonCharacterROMPointer
        beq rsEpiloguePriorityHandleUnprocessedCharacters._End

        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta wR0

      rsEpiloguePrioritySetMaleLover ; 82/FBD2

        .al
        .autsiz
        .databank ?

        ; If male unit is married:
        ; Process the lover and save her in the supporting
        ; character table.

        lda wR0
        asl a
        tax
        lda aEpilogueUnitStates,x
        bit #$2000
        beq rsEpiloguePriorityHandleUnprocessedCharacters._End

        and #$00FF
        sta wR0
        ldy #$0200
        jml rsEpiloguePriorityHandleUnprocessedCharacters

        .databank 0

      rsEvaluateEpilogueDialogueIDs ; 82/FBEB

        .al
        .autsiz
        .databank ?

        lda #SeliphEpilogueID
        sta wR1

          _Loop
          lda wR1
          asl a
          tax
          lda aEpilogueDialogueIDEvaluationTable+1,x
          and #$00FF
          sta wR2
          lda aEpilogueDialogueIDEvaluationTable,x
          and #$00FF
          asl a
          tax
          jsr (aEpilogueDialogueIDRoutines,x)
          ldx wR1
          sep #$20
          tya
          sta aEpilogueChosenDialogueID,x
          rep #$20
          inc x
          stx wR1
          cpx #50
          bne _Loop

        rts

        .databank 0

      aEpilogueDialogueIDRoutines .include "../../TABLES/SYSTEM/EpilogueDialogueIDRoutines.csv.asm" ; 82/FC1D
      aEpilogueDialogueIDEvaluationTable .binclude "../../TABLES/SYSTEM/EpilogueDialogueIDEvaluation.csv.asm" ; 82/FC37

      rsCheckIfCurrentEpilogueCharacterGetsOwnEpilogue ; 82/FC9B

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR1 = CharacterEpilogueID

        ; Output:
        ; Y = 0 if character doesnt get epilogue, else 1

        ldy #0
        ldx wR1
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta wR0
        beq +

          inc y

        +
        rts

        .databank 0

      rsGetEpilogueCharactersSupport ; 82/FCAD

        .al
        .autsiz
        .databank ?

        ; wR1 = EpilogueCharacterID

        ldx wR1
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        rts

        .databank 0

      rsGetEpilogueCharactersMarriedState ; 82/FCB7

        .al
        .autsiz
        .databank ?

        ; wR0 = CharacterID

        lda wR0
        asl a
        tax
        lda aEpilogueUnitStates,x
        bit #$2000
        rts

        .databank 0

      rsCheckIfTargetEpilogueCharacterHasPriority ; 82/FCC3

        .al
        .autsiz
        .databank ?

        lda wR0
        asl a
        tax
        lda aEpilogueUnitStates,x
        and #$0100
        rts

        .databank 0

      rsGetEpilogueTargetCharactersDeadState ; 82/FCCF

        .al
        .autsiz
        .databank ?

        lda wR2
        asl a
        tax
        lda aEpilogueUnitStates,x
        and #$8000
        rts

        .databank 0

      rsEpilogueDialogueIDMaleCheckIfWithLover ; 82/FCDB

        .al
        .autsiz
        .databank ?

        ; Output:
        ; Y = 0; no epilogue
        ; Y = 1; no support
        ; Y = 2; has support

        ; A = married CharacterID

        jsr rsCheckIfCurrentEpilogueCharacterGetsOwnEpilogue
        beq +

          jsr rsGetEpilogueCharactersSupport
          beq +

            inc y

        +
        rts

        .databank 0

      rsEpilogueDialogueIDMaleCheckIfWithLoverAndTargetAlive ; 82/FCE7

        .al
        .autsiz
        .databank ?

        ; Output:
        ; Y = 0; no epilogue
        ; Y = 1; no support, target died
        ; Y = 2; has support, target died
        ; Y = 3; no support, target alive
        ; Y = 4; has support, target alive

        jsr rsEpilogueDialogueIDMaleCheckIfWithLover
        cpy #0
        beq +

          jsr rsGetEpilogueTargetCharactersDeadState
          bne +

            inc y
            inc y

        +
        rts

        .databank 0

      rsEpilogueDialogueIDMaleCheckIfWithLoverAndPriotity ; 82/FCF7

        .al
        .autsiz
        .databank ?

        ; Output:
        ; Y = 0; no epilogue
        ; Y = 1; no support, priority
        ; Y = 2; has support, priority
        ; Y = 3; no support, no priority
        ; Y = 4; has support, no priority

        jsr rsEpilogueDialogueIDMaleCheckIfWithLover
        cpy #0
        beq _End

          jsr rsCheckIfTargetEpilogueCharacterHasPriority
          bne _End

            inc y
            inc y

        _End
        rts

        .databank 0

      rsEpilogueDialogueIDFemaleCheckIfMarriedAndTargetAlive ; 82/FD07

        .al
        .autsiz
        .databank ?

        ; Out:
        ; Y = 0; no epilogue
        ; Y = 1; has lover (died)
        ; Y = 2; no lover, target died
        ; Y = 3; no lover, target alive

        jsr rsCheckIfCurrentEpilogueCharacterGetsOwnEpilogue
        beq rsEpilogueDialogueIDMaleCheckIfWithLoverAndPriotity._End

        _CheckMarriedStateAndTarget
        jsr rsGetEpilogueCharactersMarriedState
        bne +

          ; Unmarried
          inc y
          jsr rsGetEpilogueTargetCharactersDeadState
          bne +

            inc y

        ; If married, getting here means they only got their own epilogue because
        ; their lover already died.

        +
        rts

        .databank 0

      rsEpilogueDialogueIDFemaleCheckIfMarriedAndPriority ; 82/FD19

        .al
        .autsiz
        .databank ?

        ; Out:
        ; Y = 0; no epilogue
        ; Y = 1; priority, no lover
        ; Y = 2; priority, has lover (died)
        ; Y = 3; no priority, no lover
        ; Y = 4; no priority, has lover (died)

        jsr rsCheckIfCurrentEpilogueCharacterGetsOwnEpilogue
        beq _End

          jsr rsCheckIfTargetEpilogueCharacterHasPriority
          bne +

            inc y
            inc y

          +
          jsr rsGetEpilogueCharactersMarriedState
          beq _End

            inc y

        _End
        rts

        .databank 0

      rsEpilogueDialogueIDFemaleCheckIfMarriedAndPriorityAndTargetAlive ; 82/FD2C

        .al
        .autsiz
        .databank ?

        ; Out:
        ; Y = 0; no epilogue
        ; Y = 1; priority, has lover (dead)
        ; Y = 2; priority, no lover

        ; Y = 3; no priority, has lover (died)
        ; Y = 4; no priority, no lover, target died
        ; Y = 5; no priority, no lover, target alive

        jsr rsCheckIfCurrentEpilogueCharacterGetsOwnEpilogue
        beq _End

          jsr rsCheckIfTargetEpilogueCharacterHasPriority
          bne +

            inc y
            inc y
            bra rsEpilogueDialogueIDFemaleCheckIfMarriedAndTargetAlive._CheckMarriedStateAndTarget

          +
          jsr rsGetEpilogueCharactersMarriedState
          beq _End

            inc y

        _End
        rts

        .databank 0

      rsGetSeliphEpilogueDialogueID ; 82/FD41

        .al
        .autsiz
        .databank ?

        ; Y = 0; no epilogue (what are you even doing at that point)
        ; Y = 1; no support, julia dead
        ; Y = 2; has support, julia dead
        ; Y = 1; no support/ has support but its julia, julia alive
        ; Y = 2; has support, julia alive

        jsr rsCheckIfCurrentEpilogueCharacterGetsOwnEpilogue
        beq _End

          jsr rsGetEpilogueCharactersSupport
          beq +

            cmp #Julia
            beq +

              inc y

          +
          jsr rsGetEpilogueTargetCharactersDeadState
          bne _End

            inc y
            inc y

        _End
        rts

        .databank 0

      rsGetJuliaEpilogueDialogueID ; 82/FD59

        .al
        .autsiz
        .databank ?

        ldy #0
        rts

        .databank 0

      rsGetAltenaEpilogueDialogueID ; 82/FD5D

        .al
        .autsiz
        .databank ?

        ; Y = 0; no epilogue
        ; Y = 1; arion dead, leif dead
        ; Y = 2; arion alive, leif dead
        ; Y = 1; arion dead, leif alive
        ; Y = 2; arion alive, leif alive

        jsr rsCheckIfCurrentEpilogueCharacterGetsOwnEpilogue
        beq _End

          lda #PermanentFlagChapterFinalArionDied
          jsl rlCheckPermanentEventFlagSet 
          bcs +

            inc y

          +
          jsr rsGetEpilogueTargetCharactersDeadState
          bne _End

            inc y
            inc y

        _End
        rts

        .databank 0

      rsGetHannibalEpilogueDialogueID ; 82/FD74

        .al
        .autsiz
        .databank ?

        ; Y = 0; no epilogue
        ; Y = 1; charlot exists and died
        ; Y = 2; charlot exists and is alive
        ; Y = 3; coirpre exists and died
        ; Y = 4; coirpre exists and is alive

        jsr rsCheckIfCurrentEpilogueCharacterGetsOwnEpilogue
        beq _End

          lda aEpilogueUnitStates + (Charlot * 2)
          bit #$4000
          beq +

            inc y
            inc y
            lda aEpilogueUnitStates + (Coirpre *2)

          +
          and #$8000
          bne _End

            inc y

        _End
        rts

        .databank 0

      rsGetLewynsSonEpilogueDialogueID ; 82/FD8F

        .al
        .autsiz
        .databank ?

        ; Y = 0; no epilogue
        ; Y = 1; sister dead, no support
        ; Y = 2; sister dead, has support
        ; Y = 3; sister alive, no support
        ; Y = 4; sister alive, has support

        jsr rsCheckIfCurrentEpilogueCharacterGetsOwnEpilogue
        beq _End

          jsr rsGetEpilogueCharactersSupport
          beq +

            inc y

          +
          lda aEpilogueMainCharacters + LewnysDaughterEpilogueID
          and #$00FF
          bne _End

            inc y
            inc y

        _End
        rts

        .databank 0

      rsGetLewynsDaughterEpilogueDialogueID ; 82/FDA6

        .al
        .autsiz
        .databank ?

        ; Y = 0; no epilogue
        ; Y = 1; priority, brother dead
        ; Y = 2; priority, brother alive
        ; Y = 3; no priority, brother dead
        ; Y = 4; no priority, brother alive

        jsr rsCheckIfCurrentEpilogueCharacterGetsOwnEpilogue
        beq _End

          jsr rsCheckIfTargetEpilogueCharacterHasPriority
          bne +

            inc y
            inc y

          +
          lda aEpilogueSupportingCharacters + LewnysSonEpilogueID
          and #$00FF
          beq _End

            inc y

        _End
        rts

        .databank 0

      rsEpilogueDialogueIDDefault ; 82/FDBD

        .al
        .autsiz
        .databank ?

        ldy #1
        rts

        .databank 0

      rsUnknown82FDC1 ; 82/FDC1

        .al
        .autsiz
        .databank ?

        ldx #0

          -
          phx
          txa
          clc
          adc #$0012
          asl a
          tax
          lda aEpilogueUnitStates,x
          plx
          sep #$20
          and #$0F
          sta aUnknown7FC71A,x
          rep #$20
          inc x
          cpx #7
          bne -

        ldx #0

          -
          txa
          clc
          adc #GEN_ID_Daisy_Patty
          jsl rlFindCharacterByGenerationID
          lda #0
          bcs +

            jsl rlGetSelectedUnitLoverGenerationID

          +
          sep #$20
          and #$0F
          sta aUnknown7FC721,x
          rep #$20
          inc x
          cpx #9
          bne -

        rts

        .databank 0

      rsUnknown82FE07 ; 82/FE07

        .al
        .autsiz
        .databank ?

        sep #$20
        ldx #0

          -
          lda aUnknown7FC721+1,x
          asl a
          asl a
          asl a
          asl a
          ora aUnknown7FC71A,x
          sta aUnknown7FC72A,x
          inc x
          cpx #8
          bne -

        ldx #0
        txa

          -
          clc
          adc aUnknown7FC72A,x
          inc x
          cpx #8
          bne -

        sta aUnknown7FC72A,x
        rep #$20
        rts

        .databank 0

      aUnknown82FE38 ; 82/FE38

        .byte $46
        .byte $69
        .byte $72
        .byte $65
        .byte $45
        .byte $6D
        .byte $62
        .byte $6C
        .byte $6D

      rsUnknown82FE41 ; 82/FE41

        .al
        .autsiz
        .databank ?

        sep #$20
        ldx #0
        
          -
          lda aUnknown7FC72A,x
          clc
          adc aUnknown82FE38,x
          sta aUnknown7FC72A,x
          inc x
          cpx #9
          bne -

        rep #$20
        ldx #0
        lda aUnknown7FC72A
        jsr rsUnknown82FE41._FEAF

        lda aUnknown7FC72A + 1
        lsr a
        jsr rsUnknown82FE41._FEAF

        lda aUnknown7FC72A + 2
        lsr a
        lsr a
        jsr rsUnknown82FE41._FEAF

        lda aUnknown7FC72A + 3
        lsr a
        lsr a
        lsr a
        jsr rsUnknown82FE41._FEAF

        lda aUnknown7FC72A + 4
        lsr a
        lsr a
        lsr a
        lsr a
        jsr rsUnknown82FE41._FEAF

        lda aUnknown7FC72A + 5
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        jsr rsUnknown82FE41._FEAF

        lda aUnknown7FC72A + 6
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        jsr rsUnknown82FE41._FEAF

        lda aUnknown7FC72A + 7
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a

        _FEAF
        and #$01FF
        sta wR13

        lda #26
        sta wR14
        jsl $80A1AB ; divide
        sep #$20
        lda wR13
        clc
        adc #$41
        sta aUnknown7FC70A,x
        inc x
        lda wR10
        clc
        adc #$41
        sta aUnknown7FC70A,x
        inc x
        rep #$20
        rts

        .databank 0

        ; 82/FED6

    .endsection EpilogueEndingsSection
