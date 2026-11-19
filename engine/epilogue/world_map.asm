; Assembly routines for the world map part of the epilogue.

    .section EpilogueDialogueWorldMapCodeSection

      .al
      .xl

      rlASMCEpilogueWorldMapSilesseCheckNoInheritors ; 8D/B63D

        .al
        .autsiz
        .databank ?

        ldx #LewnysSonEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _End

          ldx #LewnysDaughterEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _End

            lda #(`dialogueChapterEpilogueWorldMap_Silesse_NoInheritors)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Silesse_NoInheritors
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapSilesseCheckInherited ; 8D/B664

        .al
        .autsiz
        .databank ?

        ldx #LewnysSonEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne _Dialogue

          ldx #LewnysDaughterEpilogueID
          txa
          sta wEpilogueSavedUnitID2
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          bne _Dialogue
          bra _End

        _Dialogue
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Silesse_Inherited)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Silesse_Inherited
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapSilessePieceStart ; 8D/B6A4

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        tax
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        bne _Dialogue

        lda wEpilogueSavedUnitID2
        cmp #LewnysDaughterEpilogueID
        beq +

          ldx #LewnysDaughterEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _Dialogue

        +
        ldx #CedEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #HawkEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #FeeEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #HerminaEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue
        bra _End

        _Dialogue
        lda #(`dialogueChapterEpilogueWorldMap_Silesse_Piece_Start)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Silesse_Piece_Start
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapSilessePieceEnd ; 8D/B708

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        tax
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        bne _Dialogue

        lda wEpilogueSavedUnitID2
        cmp #LewnysDaughterEpilogueID
        beq +

          ldx #LewnysDaughterEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _Dialogue

        +
        ldx #CedEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #HawkEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #FeeEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #HerminaEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue
        bra _End

        _Dialogue
        lda #(`dialogueChapterEpilogueWorldMap_Silesse_Piece_End)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Silesse_Piece_End
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapSilessePieceRulerNoLover ; 8D/B76C

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        tax
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        bne _End

          lda #(`dialogueChapterEpilogueWorldMap_Silesse_Piece_RulerNoLover)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Silesse_Piece_RulerNoLover
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapSilessePieceRulersLover ; 8D/B789

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        beq _End

          tax
          lda aEpilogueSupportingCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            ldx #WM_PortraitSlot2
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Silesse_Piece_RulersLover)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Silesse_Piece_RulersLover
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapSilessePieceRulersSister ; 8D/B7B2

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #LewnysDaughterEpilogueID
        beq _End

          ldx #LewnysDaughterEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            ldx #WM_PortraitSlot1
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Silesse_Piece_RulersSister)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Silesse_Piece_RulersSister
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapSilessePieceCedHawk ; 8D/B7E0

        .al
        .autsiz
        .databank ?

        ldx #CedEpilogueID
        txa
        sta wEpilogueSavedUnitID3
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne _Dialogue

          ldx #HawkEpilogueID
          txa
          sta wEpilogueSavedUnitID3
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          bne _Dialogue

            lda #0
            sta wEpilogueSavedUnitID3
            bra _End

        _Dialogue
        lda aDialogue.wUnit1,b
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Silesse_Piece_CedHawk)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Silesse_Piece_CedHawk
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapSilessePieceCedHawksLover ; 8D/B82A

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID3
        beq _End

          tax
          lda aEpilogueSupportingCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            ldx #WM_PortraitSlot2
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Silesse_Piece_CedHawksLover)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Silesse_Piece_CedHawksLover
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapSilessePieceFeeHerimna ; 8D/B853

        .al
        .autsiz
        .databank ?

        ldx #FeeEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne _Dialogue

          ldx #HerminaEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

        _Dialogue
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Silesse_Piece_FeeHermina)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Silesse_Piece_FeeHermina
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaCheckNoInheritors ; 8D/B887

        .al
        .autsiz
        .databank ?

        ldx #LeifEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne _End

          ldx #AltenaEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          bne _End

            lda #(`dialogueChapterEpilogueWorldMap_NewThracia_NoInheritors)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_NewThracia_NoInheritors
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaCheckInherited ; 8D/B8B4

        .al
        .autsiz
        .databank ?

        stz $078C,b

        ldx #LeifEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne +

          ldx #AltenaEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          bne +
          bra _End

        +
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_NewThracia_Inherited)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_NewThracia_Inherited
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaPieceEndCheckLeifAndAltenaAlive ; 8D/B8ED

        .al
        .autsiz
        .databank ?

        ldx #LeifEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq _End

          ldx #AltenaEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            lda #(`dialogueChapterEpilogueWorldMap_Piece_NewThracia_EndLeifAndAltenaAlive)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Piece_NewThracia_EndLeifAndAltenaAlive
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaPieceLeifNoLover ; 8D/B91A

        .al
        .autsiz
        .databank ?

        ldx #LeifEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        bne _End

          lda #(`dialogueChapterEpilogueWorldMap_Piece_NewThracia_LeifNoLover)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Piece_NewThracia_LeifNoLover
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaPieceStart ; 8D/B935

        .al
        .autsiz
        .databank ?

        ldx #LeifEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        bne +

        ldx #FinnEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #HannibalEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #CharlotEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #CoirpreEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #AsaelloEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #DaisyEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +
        bra _End

        +
        lda #(`dialogueChapterEpilogueWorldMap_Piece_NewThracia_Start)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Piece_NewThracia_Start
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaPieceLeifsLover ; 8D/B99A

        .al
        .autsiz
        .databank ?

        ldx #LeifEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq +

          ldx #WM_PortraitSlot2
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Piece_NewThracia_LeifsLover)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Piece_NewThracia_LeifsLover
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        +
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaPieceFinn ; 8D/B9BF

        .al
        .autsiz
        .databank ?

        ldx #FinnEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq _End

          ldx #WM_PortraitSlot1
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Piece_NewThracia_Finn)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Piece_NewThracia_Finn
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaPieceHannibal ; 8D/B9E4

        .al
        .autsiz
        .databank ?

        ldx #HannibalEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq _End

          ldx #WM_PortraitSlot1
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Piece_NewThracia_Hannibal)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Piece_NewThracia_Hannibal
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaPieceCharlotCoirpre ; 8D/BA09

        .al
        .autsiz
        .databank ?

        ldx #CharlotEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne +

          ldx #CoirpreEpilogueID
          txa
          sta wEpilogueSavedUnitID2
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          bne +

            lda #0
            sta wEpilogueSavedUnitID2
            bra _End

        +
        lda aDialogue.wUnit1,b
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Piece_NewThracia_CharlotCoirpre)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Piece_NewThracia_CharlotCoirpre
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaPieceCharlotCoirpresLover ; 8D/BA53

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        beq _End

          tax
          lda aEpilogueSupportingCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            ldx #WM_PortraitSlot2
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Piece_NewThracia_CharlotCoirpresLover)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Piece_NewThracia_CharlotCoirpresLover
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaPieceAsaello ; 8D/BA7C

        .al
        .autsiz
        .databank ?

        ldx #AsaelloEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq _End

          ldx #WM_PortraitSlot1
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Piece_NewThracia_Asaello)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Piece_NewThracia_Asaello
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaPieceAsaellosLover ; 8D/BAA1

        .al
        .autsiz
        .databank ?

        ldx #AsaelloEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq _End

          ldx #WM_PortraitSlot2
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Piece_NewThracia_AsaellosLover)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Piece_NewThracia_AsaellosLover
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaPieceDaisy ; 8D/BAC6

        .al
        .autsiz
        .databank ?

        ldx #DaisyEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq _End

          ldx #WM_PortraitSlot1
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Piece_NewThracia_Daisy)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Piece_NewThracia_Daisy
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaPieceEndNoInheritors ; 8D/BAEB

        .al
        .autsiz
        .databank ?

        ldx #FinnEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #HannibalEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #CharlotEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #CoirpreEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #AsaelloEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #DaisyEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +
        bra _End

        +
        lda #(`dialogueChapterEpilogueWorldMap_Piece_NewThracia_EndNoInheritors)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Piece_NewThracia_EndNoInheritors
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapNewThraciaPieceEndInherited ; 8D/BB44

        .al
        .autsiz
        .databank ?

        ldx #LeifEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        bne +

        ldx #FinnEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #HannibalEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #CharlotEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #CoirpreEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #AsaelloEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

        ldx #DaisyEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +
        bra _End

        +
        lda #(`dialogueChapterEpilogueWorldMap_Piece_NewThracia_EndInherited)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Piece_NewThracia_EndInherited
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapIsaachCheckNoInheritors ; 8D/BBA9

        .al
        .autsiz
        .databank ?

        ldx #ShannanEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _End

          ldx #ScathachEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _End

            ldx #LarceiEpilogueID
            lda aEpilogueMainCharacters,x
            and #$00FF
            bne _End

              lda #(`dialogueChapterEpilogueWorldMap_Isaach_NoInheritors)<<8
              sta lR18+1
              lda #<>dialogueChapterEpilogueWorldMap_Isaach_NoInheritors
              sta lR18
              jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapIsaachCheckInherited ; 8D/BBDC

        .al
        .autsiz
        .databank ?

        ldx #ShannanEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

          ldx #ScathachEpilogueID
          txa
          sta wEpilogueSavedUnitID2
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne +

            ldx #LarceiEpilogueID
            txa
            sta wEpilogueSavedUnitID2
            lda aEpilogueMainCharacters,x
            and #$00FF
            bne +

              lda #0
              sta wEpilogueSavedUnitID2
              bra _End

        +
        sta aDialogue.wUnit1,b
        sta wEpilogueSavedUnitID1

        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Isaach_Inherited)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Isaach_Inherited
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapIsaachPieceNoInheritorsSubstitutes ; 8D/BC35

        .al
        .autsiz
        .databank ?

        ; Checks if Scathach was never recruited

        lda #Scathach
        asl a
        tax
        lda aEpilogueUnitStates,x
        bit #$4000
        beq _End

          lda #(`dialogueChapterEpilogueWorldMap_Isaach_Piece_NoInheritorsSubstitutes)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Isaach_Piece_NoInheritorsSubstitutes
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapIsaachPieceNoInheritorsChildren ; 8D/BC52

        .al
        .autsiz
        .databank ?

        ; Checks if Scathach was recruited

        lda #Scathach
        asl a
        tax
        lda aEpilogueUnitStates,x
        bit #$4000
        bne _End

          lda #(`dialogueChapterEpilogueWorldMap_Isaach_Piece_NoInheritorsChildren)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Isaach_Piece_NoInheritorsChildren
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapIsaachPieceRulerNoLover ; 8D/BC6F

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        tax
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        bne _End

          lda #(`dialogueChapterEpilogueWorldMap_Isaach_Piece_RulerNoLover)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Isaach_Piece_RulerNoLover
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapIsaachPieceRulersLover ; 8D/BC8C

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        beq _End

          tax
          lda aEpilogueSupportingCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            ldx #WM_PortraitSlot2
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Isaach_Piece_RulersLover)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Isaach_Piece_RulersLover
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapIsaachPieceScathachDalvin ; 8D/BCB5

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #ScathachEpilogueID
        beq +

          ldx #ScathachEpilogueID
          txa
          sta wEpilogueSavedUnitID3
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          bne ++

        +
        ldx #DalvinEpilogueID
        txa
        sta wEpilogueSavedUnitID3
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne +

          lda #0
          sta wEpilogueSavedUnitID3
          bra _End

        +
        lda aDialogue.wUnit1,b
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Isaach_Piece_ScathachDalvin)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Isaach_Piece_ScathachDalvin
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        
        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapIsaachPieceScathachDalvinsLover ; 8D/BD08

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID3
        beq _End

          tax
          lda aEpilogueSupportingCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            ldx #WM_PortraitSlot2
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Isaach_Piece_ScathachDalvinsLover)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Isaach_Piece_ScathachDalvinsLover
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapIsaachPieceLarceiCreidne ; 8D/BD31

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #LarceiEpilogueID
        beq +

          ldx #LarceiEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          bne ++

        +
        ldx #CreidneEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq _End

        +
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Isaach_Piece_LarceiCreidne)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Isaach_Piece_LarceiCreidne
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapIsaachPieceDeimne ; 8D/BD6E

        .al
        .autsiz
        .databank ?

        ldx #DeimneEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq _End

          ldx #WM_PortraitSlot1
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Isaach_Piece_Deimne)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Isaach_Piece_Deimne
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapIsaachPieceDeimnesLover ; 8D/BD93

        .al
        .autsiz
        .databank ?

        ldx #DeimneEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq _End

          ldx #WM_PortraitSlot2
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Isaach_Piece_DeimnesLover)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Isaach_Piece_DeimnesLover
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapIsaachPieceMuirne ; 8D/BDB8

        .al
        .autsiz
        .databank ?

        ldx #MuirneEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq _End

          ldx #WM_PortraitSlot1
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Isaach_Piece_Muirne)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Isaach_Piece_Muirne
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapIsaachPieceEndNoInheritors ; 8D/BDDD

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #ScathachEpilogueID
        beq +

          ldx #ScathachEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          bne _Dialogue

        +
        lda wEpilogueSavedUnitID2
        cmp #LarceiEpilogueID
        beq +

          ldx #LarceiEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          bne _Dialogue

        +
        ldx #DalvinEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne _Dialogue 

        ldx #CreidneEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne _Dialogue

        ldx #DeimneEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne _Dialogue

        ldx #MuirneEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne _Dialogue
        bra _End
        
        _Dialogue
        lda #(`dialogueChapterEpilogueWorldMap_Isaach_Piece_EndNoInheritors)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Isaach_Piece_EndNoInheritors
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        
        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapIsaachPieceEndInherited ; 8D/BE5A

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        tax
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        bne _Dialogue

        lda wEpilogueSavedUnitID2
        cmp #ScathachEpilogueID
        beq +

          ldx #ScathachEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _Dialogue

        +
        lda wEpilogueSavedUnitID2
        cmp #LarceiEpilogueID
        beq +

          ldx #LarceiEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _Dialogue

        +
        ldx #DalvinEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #CreidneEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #DeimneEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne _Dialogue

        ldx #MuirneEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne _Dialogue
        bra _End
        
        _Dialogue
        lda #(`dialogueChapterEpilogueWorldMap_Isaach_Piece_EndInherited)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Isaach_Piece_EndInherited
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        lda wEpilogueSavedUnitID1
        sta aDialogue.wUnit1,b
        rtl

        .databank 0

      rlASMCEpilogueWorldMapAgustriaCheckNoInheritors ; 8D/BEE0

        .al
        .autsiz
        .databank ?

        ldx #AresEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne _End

          ldx #DiarmuidEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          bne _End

            ldx #NannaEpilogueID
            lda aEpilogueMainCharacters,x
            and #$00FF
            sta aDialogue.wUnit1,b
            bne _End

              lda #(`dialogueChapterEpilogueWorldMap_Agustria_NoInheritors)<<8
              sta lR18+1
              lda #<>dialogueChapterEpilogueWorldMap_Agustria_NoInheritors
              sta lR18
              jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapAgustriaCheckInherited ; 8D/BF1C

        .al
        .autsiz
        .databank ?

        ldx #AresEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

          ldx #DiarmuidEpilogueID
          txa
          sta wEpilogueSavedUnitID2
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne +

            ldx #NannaEpilogueID
            txa
            sta wEpilogueSavedUnitID2
            lda aEpilogueMainCharacters,x
            and #$00FF
            bne +

              lda #0
              sta wEpilogueSavedUnitID2
              bra _End

        +
        sta aDialogue.wUnit1,b
        sta wEpilogueSavedUnitID1

        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Agustria_Inherited)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Agustria_Inherited
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapAgustriaPieceRulerNoLover ; 8D/BF75

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        tax
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        bne _End

          lda #(`dialogueChapterEpilogueWorldMap_Agustria_Piece_RulerNoLover)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Agustria_Piece_RulerNoLover
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapAgustriaPieceStart ; 8D/BF92

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        tax
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        bne _Dialogue

          lda wEpilogueSavedUnitID2
          cmp #DiarmuidEpilogueID
          beq +

            ldx #DiarmuidEpilogueID
            lda aEpilogueMainCharacters,x
            and #$00FF
            bne _Dialogue

          +
          lda wEpilogueSavedUnitID2
          cmp #NannaEpilogueID
          beq +

            ldx #NannaEpilogueID
            lda aEpilogueMainCharacters,x
            and #$00FF
            bne _Dialogue

          +
          ldx #LayleaEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _Dialogue

          ldx #LeneEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _Dialogue

          ldx #TristanEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _Dialogue

          ldx #JeanneEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _Dialogue
          bra _End

        _Dialogue
        lda aDialogue.wUnit1,b
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Agustria_Piece_Start)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Agustria_Piece_Start
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapAgustriaPieceRulersLover ; 8D/C015

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        beq _End

          tax
          lda aEpilogueSupportingCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            ldx #WM_PortraitSlot2
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Agustria_Piece_RulersLover)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Agustria_Piece_RulersLover
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapAgustriaPieceLayleaLene ; 8D/C03E

        .al
        .autsiz
        .databank ?

        ldx #LayleaEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne +

          ldx #LeneEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

        +
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Agustria_Piece_LayleaLene)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Agustria_Piece_LayleaLene
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapAgustriaPieceDiarmuidTristan ; 8D/C072

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #DiarmuidEpilogueID
        beq +

          ldx #DiarmuidEpilogueID
          txa
          sta wEpilogueSavedUnitID3
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          bne _Dialogue

        +
        ldx #TristanEpilogueID
        txa
        sta wEpilogueSavedUnitID3
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        bne _Dialogue

          lda #0
          sta wEpilogueSavedUnitID3
          bra _End

        _Dialogue
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Agustria_Piece_DiarmuidTristan)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Agustria_Piece_DiarmuidTristan
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapAgustriaPieceDiarmuidTristansLover ; 8D/C0C2

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID3
        beq _End

          tax
          lda aEpilogueSupportingCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            ldx #WM_PortraitSlot2
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Agustria_Piece_DiarmuidTristansLover)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Agustria_Piece_DiarmuidTristansLover
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapAgustriaPieceNannaJeanne ; 8D/C0EB

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #NannaEpilogueID
        beq _End

          ldx #NannaEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          bne +

            ldx #JeanneEpilogueID
            lda aEpilogueMainCharacters,x
            and #$00FF
            sta aDialogue.wUnit1,b
            beq _End

          +
          ldx #WM_PortraitSlot1
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Agustria_Piece_NannaJeanne)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Agustria_Piece_NannaJeanne
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapAgustriaPieceEnd ; 8D/C128

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        tax
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        bne _Dialogue

          lda wEpilogueSavedUnitID2
          cmp #DiarmuidEpilogueID
          beq +

            ldx #DiarmuidEpilogueID
            lda aEpilogueMainCharacters,x
            and #$00FF
            bne _Dialogue

          +
          lda wEpilogueSavedUnitID2
          cmp #NannaEpilogueID
          beq +

            ldx #NannaEpilogueID
            lda aEpilogueMainCharacters,x
            and #$00FF
            bne _Dialogue

          +
          ldx #LayleaEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _Dialogue

          ldx #LeneEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _Dialogue

          ldx #TristanEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _Dialogue

          ldx #JeanneEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _Dialogue
          bra _End

        _Dialogue
        lda #(`dialogueChapterEpilogueWorldMap_Agustria_Piece_End)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Agustria_Piece_End
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        
        _End
        lda wEpilogueSavedUnitID1
        sta aDialogue.wUnit1,b
        rtl

        .databank 0

      rlASMCEpilogueWorldMapVerdaneCheckNoInheritors ; 8D/C1A8

        .al
        .autsiz
        .databank ?

        ldx #JamkesSonEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _End

          ldx #JamkesDaughterEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _End

            lda #(`dialogueChapterEpilogueWorldMap_Verdane_NoInheritors)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Verdane_NoInheritors
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapVerdaneCheckInherited ; 8D/C1CF

        .al
        .autsiz
        .databank ?

        ldx #JamkesSonEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        sta wEpilogueSavedUnitID1
        beq +
        bra _Dialogue

          +
          ldx #JamkesDaughterEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          sta wEpilogueSavedUnitID1
          beq _End

        _Dialogue
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Verdane_Inherited)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Verdane_Inherited
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        
        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapVerdanePieceJamkesSonNoLover ; 8D/C20D

        .al
        .autsiz
        .databank ?

        ldx #JamkesSonEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        bne _End

          lda #(`dialogueChapterEpilogueWorldMap_Verdane_Piece_JamkesSonNoLover)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Verdane_Piece_JamkesSonNoLover
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapVerdanePieceJamkesSonLover ; 8D/C228

        .al
        .autsiz
        .databank ?

        ldx #JamkesSonEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq _End

          ldx #WM_PortraitSlot2
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Verdane_Piece_JamkesSonLover)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Verdane_Piece_JamkesSonLover
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapVerdaneLoadRuler ; 8D/C24D

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID1
        sta aDialogue.wUnit1,b
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceSoloQueen ; 8D/C255

        .al
        .autsiz
        .databank ?

        ; Seliphs wife is Julia OR Seliph has wife and Julia doesn't go to Grannvale.

        ldx #SeliphEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq _End

          cmp #Julia
          beq _Dialogue

            ldx #JuliaEpilogueID
            lda aEpilogueMainCharacters,x
            and #$00FF
            bne _End

          _Dialogue
          lda aDialogue.wUnit1,b
          ldx #WM_PortraitSlot2
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_SoloQueen)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_SoloQueen
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceQueenAndJulia ; 8D/C28E

        .al
        .autsiz
        .databank ?

        ; Seliph has wife thats not Julia and Julia goes to Grannvale.

        ldx #SeliphEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq _End

          cmp #Julia
          beq _End

            ldx #JuliaEpilogueID
            lda aEpilogueMainCharacters,x
            and #$00FF
            beq _End

              lda aDialogue.wUnit1,b
              ldx #WM_PortraitSlot2
              jsl rlLoadWorldMapPortraitIntoSlot

              lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_QueenAndJulia)<<8
              sta lR18+1
              lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_QueenAndJulia
              sta lR18
              jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceNoQueenAndJulia ; 8D/C2C7

        .al
        .autsiz
        .databank ?

        ; Seliph has no wife and Julia goes to Grannvale.

        ldx #SeliphEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        bne _End

          ldx #JuliaEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          beq _End

            lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_NoQueenAndJulia)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_NoQueenAndJulia
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePiecePrepareQueen ; 8D/C2EE

        .al
        .autsiz
        .databank ?

        ldx #SeliphEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        bne _Dialogue

          ldx #JuliaEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          bne _Dialogue
          bra _End

        _Dialogue
        lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_PrepareQueen)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_PrepareQueen
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceStart ; 8D/C317

        .al
        .autsiz
        .databank ?

        ldx #AzellesSonEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _DialogueJMP

        ldx #AzellesDaughterEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _DialogueJMP

        ldx #ArthurEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _DialogueJMP

        ldx #AmidEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _DialogueJMP

        ldx #TineEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _DialogueJMP

        ldx #LindaEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _DialogueJMP

        ldx #ClaudsSonEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _DialogueJMP

        ldx #ClaudsDaughterEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _DialogueJMP
        bra +

        _DialogueJMP
        jml _Dialogue

        +
        ldx #LexSonEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #LexDaughterEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #IucharEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #IucharbaEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #FebailEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #PattyEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #LesterEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #LanaEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #OifeyEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue
        bra _End

        _Dialogue
        lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Start)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Start
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceVelthomerRuler ; 8D/C403

        .al
        .autsiz
        .databank ?

        ldx #AzellesSonEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

          ldx #AzellesDaughterEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          beq _End

        _Dialogue
        sta aDialogue.wUnit1,b
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Velthomer_Ruler)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Velthomer_Ruler
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceVelthomerAzellesSonLover ; 8D/C434

        .al
        .autsiz
        .databank ?

        ldx #AzellesSonEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        beq _End

          sta aDialogue.wUnit1,b
          ldx #WM_PortraitSlot2
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Velthomer_AzellesSonLover)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Velthomer_AzellesSonLover
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceVelthomerAzellesChildren ; 8D/C459

        .al
        .autsiz
        .databank ?

        ldx #AzellesSonEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        beq _End

          ldx #AzellesDaughterEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          beq _End

            sta aDialogue.wUnit1,b
            ldx #WM_PortraitSlot1
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Velthomer_AzellesChildren)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Velthomer_AzellesChildren
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceFriegeRuler ; 8D/C48A

        .al
        .autsiz
        .databank ?

        ldx #ArthurEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #AmidEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #TineEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #LindaEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        lda #0
        sta wEpilogueSavedUnitID2
        bra _End

        _Dialogue
        sta aDialogue.wUnit1,b
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Friege_Ruler)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Friege_Ruler
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceFriegeRulersLover ; 8D/C4F0

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        beq _End

          tax
          lda aEpilogueSupportingCharacters,x
          and #$00FF
          beq _End

            sta aDialogue.wUnit1,b
            ldx #WM_PortraitSlot2
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Friege_RulersLover)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Friege_RulersLover
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceFriegeRulersSister ; 8D/C519

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        beq _End

        cmp #ArthurEpilogueID
        beq _Arthur

        cmp #AmidEpilogueID
        beq _Amid
        bra _End

        _Arthur
        ldx #TineEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue
        bra _End

        _Amid
        ldx #LindaEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue
        bra _End

        _Dialogue
        sta aDialogue.wUnit1,b
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Friege_RulersSister)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Friege_RulersSister
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceEddaRuler ; 8D/C560

        .al
        .autsiz
        .databank ?

        ldx #ClaudsSonEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne +

          ldx #ClaudsDaughterEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          beq _End

        +
        sta aDialogue.wUnit1,b
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Edda_Ruler)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Edda_Ruler
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceEddaRulersLover ; 8D/C591

        .al
        .autsiz
        .databank ?

        ldx #ClaudsSonEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        beq _End

          sta aDialogue.wUnit1,b
          ldx #WM_PortraitSlot2
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Edda_RulersLover)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Edda_RulersLover
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceEddaRulersSister ; 8D/C5B6

        .al
        .autsiz
        .databank ?

        ldx #ClaudsSonEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        beq _End

          ldx #ClaudsDaughterEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          beq _End

            sta aDialogue.wUnit1,b
            ldx #WM_PortraitSlot1
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Edda_RulersSister)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Edda_RulersSister
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceDozelRuler ; 8D/C5E7

        .al
        .autsiz
        .databank ?

        ldx #LexSonEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #LexDaughterEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #IucharEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #IucharbaEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        lda #0
        sta wEpilogueSavedUnitID2
        bra _End

        _Dialogue
        sta aDialogue.wUnit1,b
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_Ruler)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_Ruler
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceDozelRulersLover ; 8D/C64D

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        beq _End

          tax
          lda aEpilogueSupportingCharacters,x
          and #$00FF
          bne _Dialogue
          bra _End

          _Dialogue
          sta aDialogue.wUnit1,b
          ldx #WM_PortraitSlot2
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_RulersLover)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_RulersLover
          sta lR18
          jsl rlDialoguePushToActivePointerStack
        
        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceDozelRulersSister ; 8D/C678

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #LexSonEpilogueID
        bne _End

          ldx #LexDaughterEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          beq _End

            sta aDialogue.wUnit1,b
            ldx #WM_PortraitSlot1
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_RulersSister)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_RulersSister
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceDozelIuchar ; 8D/C6A6

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #IucharEpilogueID
        beq _End

          ldx #IucharEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            ldx #WM_PortraitSlot1
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_Iuchar)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_Iuchar
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceDozelIucharsLover ; 8D/C6D4

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #IucharEpilogueID
        beq _End

          ldx #IucharEpilogueID
          lda aEpilogueSupportingCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            ldx #WM_PortraitSlot2
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_IucharsLover)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_IucharsLover
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceDozelIucharba ; 8D/C702

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #IucharbaEpilogueID
        beq _End

          ldx #IucharbaEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            ldx #WM_PortraitSlot1
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_Iucharba)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_Iucharba
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceDozelIucharbasLover ; 8D/C730

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #IucharbaEpilogueID
        beq _End

          ldx #IucharbaEpilogueID
          lda aEpilogueSupportingCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            ldx #WM_PortraitSlot2
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_IucharbasLover)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Dozel_IucharbasLover
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceYngviRuler ; 8D/C75E

        .al
        .autsiz
        .databank ?

        ldx #FebailEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #PattyEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #LesterEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        ldx #LanaEpilogueID
        txa
        sta wEpilogueSavedUnitID2
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue

        lda #0
        sta wEpilogueSavedUnitID2
        bra _End

        _Dialogue
        sta aDialogue.wUnit1,b
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_Ruler)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_Ruler
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        
        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceYngviRulersLover ; 8D/C7C4

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        beq _End

          tax
          lda aEpilogueSupportingCharacters,x
          and #$00FF
          bne _Dialogue
          bra _End

            _Dialogue
            sta aDialogue.wUnit1,b
            ldx #WM_PortraitSlot2
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_RulersLover)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_RulersLover
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceYngviRulersSister ; 8D/C7EF

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #FebailEpilogueID
        beq _Febail

        cmp #LesterEpilogueID
        beq _Lester
        bra _End

        _Febail
        ldx #PattyEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue
        bra _End

        _Lester
        ldx #LanaEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        bne _Dialogue
        bra _End

        _Dialogue
        sta aDialogue.wUnit1,b
        ldx #WM_PortraitSlot1
        jsl rlLoadWorldMapPortraitIntoSlot

        lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_RulersSister)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_RulersSister
        sta lR18
        jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceYngviLester ; 8D/C834

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #LesterEpilogueID
        beq _End

          ldx #LesterEpilogueID
          lda aEpilogueMainCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            ldx #WM_PortraitSlot1
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_Lester)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_Lester
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceYngviLestersLover ; 8D/C862

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #LesterEpilogueID
        beq _End

          ldx #LesterEpilogueID
          lda aEpilogueSupportingCharacters,x
          and #$00FF
          sta aDialogue.wUnit1,b
          beq _End

            ldx #WM_PortraitSlot2
            jsl rlLoadWorldMapPortraitIntoSlot

            lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_LestersLover)<<8
            sta lR18+1
            lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_LestersLover
            sta lR18
            jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceYngviLana ; 8D/C890

        .al
        .autsiz
        .databank ?

        lda wEpilogueSavedUnitID2
        cmp #LesterEpilogueID
        beq _End

          lda wEpilogueSavedUnitID2
          cmp #LanaEpilogueID
          beq _End

            ldx #LanaEpilogueID
            lda aEpilogueMainCharacters,x
            and #$00FF
            sta aDialogue.wUnit1,b
            beq _End

              ldx #WM_PortraitSlot1
              jsl rlLoadWorldMapPortraitIntoSlot

              lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_Lana)<<8
              sta lR18+1
              lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Yngvi_Lana
              sta lR18
              jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceChalphyOifey ; 8D/C8C7

        .al
        .autsiz
        .databank ?

        ldx #OifeyEpilogueID
        lda aEpilogueMainCharacters,x
        and #$00FF
        beq _End

          ldx #WM_PortraitSlot1
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Chalphy_Oifey)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Chalphy_Oifey
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCEpilogueWorldMapGrannvalePieceChalphyOifeysLover ; 8D/C8E9

        .al
        .autsiz
        .databank ?

        ldx #OifeyEpilogueID
        lda aEpilogueSupportingCharacters,x
        and #$00FF
        sta aDialogue.wUnit1,b
        beq _End

          ldx #WM_PortraitSlot2
          jsl rlLoadWorldMapPortraitIntoSlot

          lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Chalphy_OifeysLover)<<8
          sta lR18+1
          lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Chalphy_OifeysLover
          sta lR18
          jsl rlDialoguePushToActivePointerStack

        _End
        rtl

        .databank 0

      rlASMCUnknown8DC90E ; 8D/C90E

        .al
        .autsiz
        .databank ?

        ; This and the next asmc call a proc to the Aed cutscene, this one doesn't
        ; fade out the song properly and fades in the graphics faster?

        lda aDialogue.lActivePointer,b
        sec
        sbc #5
        sta aDialogue.lActivePointer,b

        lda $0AD3,b
        cmp #$556E
        bcs _C938

        cmp #$0708
        bcc _Dialogue

        cmp #$4F1A
        bcc +
        bra _Dialogue

        +
        lda aDialogue.lActivePointer,b
        clc
        adc #5
        sta aDialogue.lActivePointer,b
        bra _Dialogue

        _C938
        jsl $8B80F3

        lda aDialogue.lActivePointer,b
        clc
        adc #5
        sta aDialogue.lActivePointer,b

        _Dialogue
        lda #(`dialogueChapterEpilogueWorldMap_Grannvale_Piece_Unknown8DF329)<<8
        sta lR18+1
        lda #<>dialogueChapterEpilogueWorldMap_Grannvale_Piece_Unknown8DF329
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rtl

        .databank 0

      rlASMCUnknown8DC955 ; 8D/C955

        .al
        .autsiz
        .databank ?

        ; This and the previous asmc call a proc to the Aed cutscene, this one is the
        ; proper one?

        lda $0AD3,b
        cmp #$556E
        bcs _End

          jsl $8B80CB
          bra _End

        _End
        rtl

        .databank 0

        ; 8D/C964

    .endsection EpilogueDialogueWorldMapCodeSection
