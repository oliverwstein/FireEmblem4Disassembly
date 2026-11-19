; Epilogue ASMCs that choose each region's epilogue and each character's lover
; scene, and the per-character tables of epilogue dialogue.

    .section EpilogueDialogueCodeSection

      .al
      .xl

      rlASMCSetBelhallaEpilogue ; 91/BA9C

        .al
        .autsiz
        .databank ?

        lda #EpilogueRegionBelhalla
        bra +

      rlASMCSetIsaachEpilogue ; 91/BAA1

        .al
        .autsiz
        .databank ?

        lda #EpilogueRegionIsaach
        bra +

      rlASMCSetNewThraciaEpilogue ; 91/BAA6

        .al
        .autsiz
        .databank ?

        lda #EpilogueRegionNewThracia
        bra +

      rlASMCSetAgustriaEpilogue ; 91/BAAB

        .al
        .autsiz
        .databank ?

        lda #EpilogueRegionAgustria
        bra +

      rlASMCSetVerdaneEpilogue ; 91/BAB0

        .al
        .autsiz
        .databank ?

        lda #EpilogueRegionVerdane
        bra +

      rlASMCSetYngviEpilogue ; 91/BAB5

        .al
        .autsiz
        .databank ?

        lda #EpilogueRegionYngvi
        bra +

      rlASMCSetFriegeEpilogue ; 91/BABA

        .al
        .autsiz
        .databank ?

        lda #EpilogueRegionFriege
        bra +

      rlASMCSetDozelEpilogue ; 91/BABF

        .al
        .autsiz
        .databank ?

        lda #EpilogueRegionDozel
        bra +

      rlASMCSetEddaEpilogue ; 91/BAC4

        .al
        .autsiz
        .databank ?

        lda #EpilogueRegionEdda
        bra +

      rlASMCSetVelthomerEpilogue ; 91/BAC9

        .al
        .autsiz
        .databank ?

        lda #EpilogueRegionVelthomer
        bra +

      rlASMCSetChalphyEpilogue ; 91/BACE

        .al
        .autsiz
        .databank ?

        lda #EpilogueRegionChalphy
        bra +

      rlASMCSetSilesseEpilogue ; 91/BAD3

        .al
        .autsiz
        .databank ?

        lda #EpilogueRegionSilesse

        +
        sta aEpilogue.wRegionID,b
        asl a
        tax
        lda aEpilogueRegions,x
        and #$00FF

        sta aEpilogue.wCurrentEpilogueID,b

        lda aEpilogueRegions+1,x
        and #$00FF
        sta aEpilogue.wNextEpilogueID,b

        lda #3
        sta aDialogue.wTextSound,b
        lda #6
        sta aDialogue.wTextSpeed,b

        stz aEpilogue.wUnknown00174B,b

        lda #DialogueStatusPreventASpeedUp
        tsb aDialogue.wStatus,b
        rtl

        .databank 0

      aEpilogueRegions .include "../../data/system/EpilogueRegions.csv.asm" ; 91/BB05

      rlASMCLoadEpilogueDialogue ; 91/BB1D

        .al
        .autsiz
        .databank ?

        dec aDialogue.lActivePointer,b
        dec aDialogue.lActivePointer,b
        dec aDialogue.lActivePointer,b
        dec aDialogue.lActivePointer,b
        dec aDialogue.lActivePointer,b

        lda aEpilogue.wCurrentEpilogueID,b
        cmp aEpilogue.wNextEpilogueID,b
        bne +

          jml _BBFD

        +
        bcc +

          jml _EndDialogue

        +
        lda #$FFFE
        sta wEventUnit1Pointer,b

        ldx aEpilogue.wCurrentEpilogueID,b
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

          jml _SetNextDialogue

        +
        sta aDialogue.wUnit2,b
        sta aEpilogue.wUnknown00174D,b
        asl a
        tax
        lda aEpilogueUnitStates,x
        bit #$0100
        beq +

          lda #$0001
          tsb aEpilogue.wUnknown00174B,b

        +
        lda #(`dialogueEpiloge_PullDialogueStack)<<8
        sta lR18+1
        lda #<>dialogueEpiloge_PullDialogueStack
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        lda aEpilogue.wCurrentEpilogueID,b
        bne +

          lda wEpilogueOtherUnitsExistFlag
          beq +

            lda #(`dialogueEpilogue_BelhallaEnd)<<8
            sta lR18+1
            lda #<>dialogueEpilogue_BelhallaEnd
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        +
        lda #(`aEpiloguePointers)<<8
        sta lR19+1
        lda aEpilogue.wCurrentEpilogueID,b
        asl a
        tax
        lda aEpiloguePointers,x
        sta lR19

        ldx aEpilogue.wCurrentEpilogueID,b
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        sta aEpilogue.wUnknown00174F,b
        beq +

          pha
          lda aEpilogue.wRegionEpilogueCounter,b
          clc
          adc #$0100
          sta aEpilogue.wRegionEpilogueCounter,b
          pla
          bra ++

          +
          phx
          lda aDialogue.wUnit2,b
          asl a
          tax
          lda aEpilogueUnitStates,x
          and #$00FF
          plx

        +
        sta aDialogue.wUnit1,b

        lda aEpilogueChosenDialogueID,x
        and #$000F
        sta aEpilogue.wChosenDialogueID,b
        dec a
        sta wR0
        asl a
        clc
        adc wR0
        tay

        lda [lR19],y
        sta lR18
        inc y
        lda [lR19],y
        sta lR18+1

        _End
        jsl rlDialoguePushToActivePointerStack
        lda aEpilogue.wRegionEpilogueCounter,b
        clc
        adc #$0100
        sta aEpilogue.wRegionEpilogueCounter,b

        _SetNextDialogue
        inc aEpilogue.wCurrentEpilogueID,b
        rtl

        _BBFD
        lda aEpilogue.wUnknown00174B,b
        bit #$0001
        beq _EndDialogue

          lda aEpilogue.wRegionID,b
          and #$00FF
          sta wR0
          asl a
          clc
          adc wR0
          asl a
          tax

          lda aEpilogue.wRegionEpilogueCounter,b
          and #$FF00
          cmp #$0100
          beq +

            inc x
            inc x
            inc x

          +
          lda aEpilogueRegionEndDialoguePointers,x
          beq _EndDialogue

            sta lR18
            lda aEpilogueRegionEndDialoguePointers+1,x
            sta lR18+1
            bra _End

        _EndDialogue
        lda aDialogue.lActivePointer,b
        clc
        adc #5
        sta aDialogue.lActivePointer,b
        rtl

        .databank 0

      dialogueEpiloge_PullDialogueStack .include "../../text/dialogue/Epilogue/PullDialogueStack.dialogue.txt" ; 91/BC3C

      rlASMCEpilogueSeliphLoverCallJuliaDead ; 91/BC40

        .al
        .autsiz
        .databank ?

        lda #0
        brl +

      rlASMCEpilogueSeliphLoverCallJuliaAlive ; 91/BC46

        .al
        .autsiz
        .databank ?

        lda #1
        brl +

      rlASMCEpilogueShannanLoverCall ; 91/BC4C

        .al
        .autsiz
        .databank ?

        lda #2
        brl +

      rlASMCEpilogueScathachDalvinLoverCallShannanDead ; 91/BC52

        .al
        .autsiz
        .databank ?

        lda #3
        brl +

      rlASMCEpilogueScathachDalvinLoverCallShannanAlive ; 91/BC58

        .al
        .autsiz
        .databank ?

        lda #4
        brl +

      rlASMCEpilogueDeimneLoverCallMuirneDead ; 91/BC5E

        .al
        .autsiz
        .databank ?

        lda #5
        bra +

      rlASMCEpilogueDeimneLoverCallMuirneAlive ; 91/BC63

        .al
        .autsiz
        .databank ?

        lda #6
        bra +

      rlASMCEpilogueLeifLoverCallAltenaDead ; 91/BC68

        .al
        .autsiz
        .databank ?

        lda #7
        bra +

      rlASMCEpilogueLeifLoverCallAltenaAlive ; 91/BC6D

        .al
        .autsiz
        .databank ?

        lda #8
        bra +

      rlASMCEpilogueCharlotCoirpreLoverCallHannibalDead ; 91/BC72

        .al
        .autsiz
        .databank ?

        lda #9
        bra +

      rlASMCEpilogueCharlotCoirpreLoverCallHannibalAlive ; 91/BC77

        .al
        .autsiz
        .databank ?

        lda #10
        bra +

      rlASMCEpilogueAsaelloLoverCallDaisyDead ; 91/BC7C

        .al
        .autsiz
        .databank ?

        lda #11
        bra +

      rlASMCEpilogueAsaelloLoverCallDaisyAlive ; 91/BC81

        .al
        .autsiz
        .databank ?

        lda #12
        bra +

      rlASMCEpilogueAresLoverCall ; 91/BC86

        .al
        .autsiz
        .databank ?

        lda #13
        bra +

      rlASMCEpilogueDiarmuidLoverCallAresDead ; 91/BC8B

        .al
        .autsiz
        .databank ?

        lda #14
        bra +

      rlASMCEpilogueDiarmuidLoverCallAresAlive ; 91/BC90

        .al
        .autsiz
        .databank ?

        lda #15
        bra +

      rlASMCEpilogueTristanLoverCallAresDead ; 91/BC95

        .al
        .autsiz
        .databank ?

        lda #16
        bra +

      rlASMCEpilogueTristanLoverCallAresAlive ; 91/BC9A

        .al
        .autsiz
        .databank ?

        lda #17
        bra +

      rlASMCEpilogueJamkesSonLoverCall ; 91/BC9F

        .al
        .autsiz
        .databank ?

        lda #18
        bra +

      rlASMCEpilogueFebailLoverCall ; 91/BCA4

        .al
        .autsiz
        .databank ?

        lda #19
        bra +

      rlASMCEpilogueLesterLoverCallBrigidsChildrenDead ; 91/BCA9

        .al
        .autsiz
        .databank ?

        lda #20
        bra +

      rlASMCEpilogueLesterLoverCallBrigidsChildrenAlive ; 91/BCAE

        .al
        .autsiz
        .databank ?

        lda #21
        bra +

      rlASMCEpilogueAmidArthurLoverCall ; 91/BCB3

        .al
        .autsiz
        .databank ?

        lda #22
        bra +

      rlASMCEpilogueLexSonLoverCall ; 91/BCB8

        .al
        .autsiz
        .databank ?

        lda #23
        bra +

      rlASMCEpilogueIucharLoverCall ; 91/BCBD

        .al
        .autsiz
        .databank ?

        lda #24
        bra +

      rlASMCEpilogueIucharbaLoverCall ; 91/BCC2

        .al
        .autsiz
        .databank ?

        lda #25
        bra +

      rlASMCEpilogueClaudsSonLoverCall ; 91/BCC7

        .al
        .autsiz
        .databank ?

        lda #26
        bra +

      rlASMCEpilogueAzellesSonLoverCall ; 91/BCCC

        .al
        .autsiz
        .databank ?

        lda #27
        bra +

      rlASMCEpilogueOifeyLoverCall ; 91/BCD1

        .al
        .autsiz
        .databank ?

        lda #28
        bra +

      rlASMCEpilogueCedLoverCall ; 91/BCD6

        .al
        .autsiz
        .databank ?

        lda #29
        bra +

      rlASMCEpilogueLewynsSonLoverCall ; 91/BCDB

        .al
        .autsiz
        .databank ?

        lda #30

        +
        pha

        lda aEpilogue.wUnknown00174F,b
        sta wR0
        ldx #-2

        -
        inc x
        inc x
        lda aEpilogueLoverPartners,x
        beq +

        cmp wR0
        bne -

        txa
        lsr a
        lsr a
        bra ++

        +
        lda #0

        +
        sta wR0
        asl a
        clc
        adc wR0
        tax

        lda aEpilogueLoverGroups,x
        sta lR19
        lda aEpilogueLoverGroups+1,x
        sta lR19+1

        pla
        sta wR0
        asl a
        clc
        adc wR0
        tay

        lda [lR19],y
        sta lR18
        inc y
        lda [lR19],y
        sta lR18+1
        jsl rlDialoguePushToActivePointerStack
        rtl

        .databank 0

      aEpilogueLoverPartners ; 91/BD24

        .word Daisy, Patty
        .word Creidne, Larcei
        .word Muirne, Lana
        .word Hermina, Fee
        .word Linda, Tine
        .word Laylea, Lene
        .word Jeanne, Nanna
        .word 0

        ; 91bd42

    .endsection EpilogueDialogueCodeSection


    .section EpilogueDialoguePointersSection

      .al
      .xl

      aSeliphEpiloguePointers ; B2/D0C1

        .long dialogueEpilogue_Seliph_JuliaDead
        .long dialogueEpilogue_Seliph_JuliaDead_WithLover
        .long dialogueEpilogue_Seliph_JuliaAlive
        .long dialogueEpilogue_Seliph_JuliaAlive_WithLover

      aShannanEpiloguePointers ; B2/D0CD

        .long dialogueEpilogue_Shannan
        .long dialogueEpilogue_Shannan_WithLover

      aScathachEpiloguePointers ; B2/D0D3

        .long dialogueEpilogue_Scathach_ShannanDead  
        .long dialogueEpilogue_Scathach_ShannanDead_WithLover
        .long dialogueEpilogue_Scathach_ShannanAlive
        .long dialogueEpilogue_Scathach_ShannanAlive_WithLover

      aDalvinEpiloguePointers ; B2/D0DF

        .long dialogueEpilogue_Dalvin_ShannanDead
        .long dialogueEpilogue_Dalvin_ShannanDead_WithLover
        .long dialogueEpilogue_Dalvin_ShannanAlive
        .long dialogueEpilogue_Dalvin_ShannanAlive_WithLover

      aLarceiEpiloguePointers ; B2/D0EB

        .long dialogueEpilogue_Larcei_ShannanDead                       ; priority, lover dead
        .long dialogueEpilogue_Larcei_ShannanDead                       ; priority, no lover
        .long dialogueEpilogue_CreidneLarcei_LoverDead                  ; no priority
        .long dialogueEpilogue_Larcei_ShannanAlive_ScathachDead         ; no priority
        .long dialogueEpilogue_CreidneLarcei_ShannanAlive_BrotherAlive  ; no priority

      aCreidneEpiloguePointers ; B2/D0FA

        .long dialogueEpilogue_Creidne_LoverDead
        .long dialogueEpilogue_Creidne_ShannanAlive_DalvinDead
        .long dialogueEpilogue_Creidne_ShannanAlive_DalvinAlive

      aDeimneEpiloguePointers ; B2/D103

        .long dialogueEpilogue_Deimne_MuirneDead
        .long dialogueEpilogue_Deimne_MuirneDead_WithLover
        .long dialogueEpilogue_Deimne_MuirneAlive
        .long dialogueEpilogue_Deimne_MuirneAlive_WithLover

      aMuirneEpiloguePointers ; B2/D10F

        .long dialogueEpilogue_Muirne_LoverDead
        .long dialogueEpilogue_Muirne_DeimneDead
        .long dialogueEpilogue_Muirne_DeimneAlive

      aLeifEpiloguePointers ; B2/D118

        .long dialogueEpilogue_Leif_AltenaDead
        .long dialogueEpilogue_Leif_AltenaDead_WithLover
        .long dialogueEpilogue_Leif_AltenaAlive
        .long dialogueEpilogue_Leif_AltenaAlive_WithLover

      aAltenaEpiloguePointers ; B2/D124

        .long dialogueEpilogue_Altena_LeifDead_ArionDead
        .long dialogueEpilogue_Altena_LeifDead_ArionAlive
        .long dialogueEpilogue_Altena_LeifAlive_ArionDead
        .long dialogueEpilogue_Altena_LeifAlive_ArionAlive

      aFinnEpiloguePointers ; B2/D130

        .long dialogueEpilogue_Finn_LeifDead  ; no lover
        .long dialogueEpilogue_Finn_LeifDead  ; has lover
        .long dialogueEpilogue_Finn_LeifAlive ; no lover
        .long dialogueEpilogue_Finn_LeifAlive ; has lover

      aHannibalEpiloguePointers ; B2/D13C

        .long dialogueEpilogue_Hannibal_CharlotDead
        .long dialogueEpilogue_Hannibal_CharlotAlive
        .long dialogueEpilogue_Hannibal_CoirpreDead
        .long dialogueEpilogue_Hannibal_CoirpreAlive

      aCharlotEpiloguePointers ; B2/D148

        .long dialogueEpilogue_CharlotCoirpre_HannibalDead
        .long dialogueEpilogue_CharlotCoirpre_HannibalDead_WithLover
        .long dialogueEpilogue_CharlotCoirpre_HannibalAlive
        .long dialogueEpilogue_CharlotCoirpre_HannibalAlive_WithLover

      aCoirpreEpiloguePointers ; B2/D154

        .long dialogueEpilogue_CharlotCoirpre_HannibalDead
        .long dialogueEpilogue_CharlotCoirpre_HannibalDead_WithLover
        .long dialogueEpilogue_CharlotCoirpre_HannibalAlive
        .long dialogueEpilogue_CharlotCoirpre_HannibalAlive_WithLover

      aAsaelloEpiloguePointers ; B2/D160

        .long dialogueEpilogue_Asaello_DaisyDead
        .long dialogueEpilogue_Asaello_DaisyDead_WithLover
        .long dialogueEpilogue_Asaello_DaisyAlive
        .long dialogueEpilogue_Asaello_DaisyAlive_WithLover

      aDaisyEpiloguePointers ; B2/D16C

        .long dialogueEpilogue_Daisy_LoverDead
        .long dialogueEpilogue_Daisy_AsaelloDead
        .long dialogueEpilogue_Daisy_AsaelloAlive

      aAresEpiloguePointers ; B2/D175

        .long dialogueEpilogue_Ares
        .long dialogueEpilogue_Ares_WithLover

      aLeneEpiloguePointers ; B2/D17B

        .long dialogueEpilogue_LayleaLene_LoverDead
        .long dialogueEpilogue_LayleaLene_AresDead
        .long dialogueEpilogue_LayleaLene_AresAlive

      aLayleaEpiloguePointers ; B2/D184

        .long dialogueEpilogue_LayleaLene_LoverDead
        .long dialogueEpilogue_LayleaLene_AresDead
        .long dialogueEpilogue_LayleaLene_AresAlive

      aDiarmuidEpiloguePointers ; B2/D18D

        .long dialogueEpilogue_Diarmuid_AresDead
        .long dialogueEpilogue_Diarmuid_AresDead_WithLover
        .long dialogueEpilogue_Diarmuid_AresAlive
        .long dialogueEpilogue_Diarmuid_AresAlive_WithLover

      aTristanEpiloguePointers ; B2/D199

        .long dialogueEpilogue_Tristan_AresDead
        .long dialogueEpilogue_Tristan_AresDead_WithLover
        .long dialogueEpilogue_Tristan_AresAlive
        .long dialogueEpilogue_Tristan_AresAlive_WithLover

      aNannaEpiloguePointers ; B2/D1A5

        .long dialogueEpilogue_Nanna_AresDead                 ; priority, lover dead
        .long dialogueEpilogue_Nanna_AresDead                 ; priority, no lover
        .long dialogueEpilogue_Nanna_LoverDead                ; no priority
        .long dialogueEpilogue_Nanna_AresAlive_DiarmuidDead   ; no priority
        .long dialogueEpilogue_Nanna_AresAlive_DiarmuidAlive  ; no priority

      aJeanneEpiloguePointers ; B2/D1B4

        .long dialogueEpilogue_Jeanne_LoverDead
        .long dialogueEpilogue_Jeanne_TristanDead
        .long dialogueEpilogue_Jeanne_TristanAlive

      aJamkesSonEpiloguePointers ; B2/D1BD

        .long dialogueEpilogue_JamkesSon
        .long dialogueEpilogue_JamkesSon_WithLover

      aJamkesDaughterEpiloguePointers ; B2/D1C3

        .long dialogueEpilogue_JamkesDaughter_BrotherDead
        .long dialogueEpilogue_JamkesDaughter_BrotherDead ; lover dead
        .long dialogueEpilogue_JamkesDaughter_BrotherAlive
        .long dialogueEpilogue_JamkesDaughter_BrotherAlive_LoverDead

      aFebailEpiloguePointers ; B2/D1CF

        .long dialogueEpilogue_Febail
        .long dialogueEpilogue_Febail_WithLover

      aPattyEpiloguePointers ; B2/D1D5

        .long dialogueEpilogue_Patty_FebailDead
        .long dialogueEpilogue_Patty_FebailDead ; lover dead
        .long dialogueEpilogue_Patty_FebailAlive
        .long dialogueEpilogue_Patty_LoverDead ; febail alive

      aLesterEpiloguePointers ; B2/D1E1

        .long dialogueEpilogue_Lester_BrigidsChildrenDead
        .long dialogueEpilogue_Lester_BrigidsChildrenDead_WithLover
        .long dialogueEpilogue_Lester_BrigidsChildrenAlive
        .long dialogueEpilogue_Lester_BrigidsChildrenAlive_WithLover

      aLanaEpiloguePointers ; B2/D1ED

        .long dialogueEpilogue_Lana_YngviChildrenDead               ; priority, lover dead
        .long dialogueEpilogue_Lana_YngviChildrenDead               ; priority, no lover
        .long dialogueEpilogue_Lana_YngviChildrenAlive_LoverDead    ; no priority
        .long dialogueEpilogue_Lana_YngviChildrenAlive_LesterDead   ; no priority
        .long dialogueEpilogue_Lana_YngviChildrenAlive_LesterAlive  ; no priority

      aArthurEpiloguePointers ; B2/D1FC

        .long dialogueEpilogue_AmidArthur
        .long dialogueEpilogue_AmidArthur_WithLover

      aAmidEpiloguePointers ; B2/D202

        .long dialogueEpilogue_AmidArthur
        .long dialogueEpilogue_AmidArthur_WithLover

      aTineEpiloguePointers ; B2/D208

        .long dialogueEpilogue_LindaTine_BrotherDead
        .long dialogueEpilogue_LindaTine_BrotherDead ; lover dead
        .long dialogueEpilogue_LindaTine_BrotherAlive
        .long dialogueEpilogue_LindaTine_BrotherAlive_LoverDead

      aLindaEpiloguePointers ; B2/D214

        .long dialogueEpilogue_LindaTine_BrotherDead
        .long dialogueEpilogue_LindaTine_BrotherDead ; lover dead
        .long dialogueEpilogue_LindaTine_BrotherAlive
        .long dialogueEpilogue_LindaTine_BrotherAlive_LoverDead

      aLexSonEpiloguePointers ; B2/D220

        .long dialogueEpilogue_LexSon
        .long dialogueEpilogue_LexSon_WithLover

      aLexDaughterEpiloguePointers ; B2/D226

        .long dialogueEpilogue_LexDaughter_BrotherDead
        .long dialogueEpilogue_LexDaughter_BrotherDead ; lover dead
        .long dialogueEpilogue_LexDaughter_BrotherAlive
        .long dialogueEpilogue_LexDaughter_BrotherAlive_LoverDead

      aIucharEpiloguePointers ; B2/D232

        .long dialogueEpilogue_Iuchar           ; priority
        .long dialogueEpilogue_Iuchar_WithLover ; priority
        .long dialogueEpilogue_Iuchar           ; no priority
        .long dialogueEpilogue_Iuchar_WithLover ; no priority

      aIucharbaEpiloguePointers ; B2/D23E

        .long dialogueEpilogue_Iucharba           ; priority
        .long dialogueEpilogue_Iucharba_WithLover ; priority
        .long dialogueEpilogue_Iucharba           ; no priority
        .long dialogueEpilogue_Iucharba_WithLover ; no priority

      aClaudsSonEpiloguePointers ; B2/D24A

        .long dialogueEpilogue_ClaudsSon
        .long dialogueEpilogue_ClaudsSon_WithLover

      aClaudsDaughterEpiloguePointers ; B2/D250

        .long dialogueEpilogue_ClaudsDaughter_BrotherDead
        .long dialogueEpilogue_ClaudsDaughter_BrotherDead ; lover dead
        .long dialogueEpilogue_ClaudsDaughter_BrotherAlive
        .long dialogueEpilogue_ClaudsDaughter_BrotherAlive_LoverDead

      aAzellesSonEpiloguePointers ; B2/D25C

        .long dialogueEpilogue_AzellesSon
        .long dialogueEpilogue_AzellesSon_WithLover

      aAzellesDaughterEpiloguePointers ; B2/D262

        .long dialogueEpilogue_AzellesDaughter_BrotherDead
        .long dialogueEpilogue_AzellesDaughter_BrotherDead ; lover dead
        .long dialogueEpilogue_AzellesDaughter_BrotherAlive
        .long dialogueEpilogue_AzellesDaughter_BrotherAlive_LoverDead

      aOifeyEpiloguePointers ; B2/D26E

        .long dialogueEpilogue_Oifey
        .long dialogueEpilogue_Oifey_WithLover

      aCedEpiloguePointers ; B2/D274

        .long dialogueEpilogue_HawkCed
        .long dialogueEpilogue_HawkCed_WithLover

      aHawkEpiloguePointers ; B2/D27A

        ; The dialogue isnt modular so the dialogue engine has to fix hawks portrait

        .long dialogueEpilogue_HawkCed
        .long dialogueEpilogue_HawkCed_WithLover

      aFeeEpiloguePointers ; B2/D280

        .long dialogueEpilogue_HerminaFee_LoverDead
        .long dialogueEpilogue_HerminaFee ; Ced dead
        .long dialogueEpilogue_HerminaFee ; Ced alive

      aHerminaEpiloguePointers ; B2/D289

        ; The dialogue isnt modular so the dialogue engine has to herminas hawks portrait

        .long dialogueEpilogue_HerminaFee_LoverDead
        .long dialogueEpilogue_HerminaFee ; Hawk dead
        .long dialogueEpilogue_HerminaFee ; Hawk alive

      aLewynsSonEpiloguePointers ; B2/D292

        .long dialogueEpilogue_LewynsSon_SisterDead
        .long dialogueEpilogue_LewynsSon_SisterDead_WithLover
        .long dialogueEpilogue_LewynsSon_SisterAlive
        .long dialogueEpilogue_LewynsSon_SisterAlive_WithLover

      aLewynsDaughterEpiloguePointers ; B2/D29E

        .long dialogueEpilogue_LewynsDaughter_Priority   ; brother dead
        .long dialogueEpilogue_LewynsDaughter_Priority   ; brother alive
        .long dialogueEpilogue_LewynsDaughter_NoPriority ; brother dead
        .long dialogueEpilogue_LewynsDaughter_NoPriority ; brother alive

      ; B2D2AA

    .endsection EpilogueDialoguePointersSection
