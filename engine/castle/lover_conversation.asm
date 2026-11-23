; The lovers' home castle conversation (bank $8C). When a unit reaches its home
; castle while its lover waits there, rlTryStartLoverHomeCastleConversation
; starts a short castle screen conversation, once per couple (the woman's
; PermanentFlag...LoverHomeCastle). Its text is two lines put together at
; $7F8183: the arriving unit's (aLoverHomeCastleArrivalLines) and the lover's
; reply (aLoverHomeCastleReplyLines), both by character ID. The lines are in
; text/dialogue/LoverHomeCastle; their two ASMCs add 様 to Seliph's and Leif's
; names.

    .section Unsorted8CED00Section

      .al
      .xl

      rlStartLoverHomeCastleConversation ; 8C/ED00

        .al
        .xl
        .autsiz
        .databank ?

        ; Opens the castle screen in conversation mode (CASTLE_SCREEN_CONVERSATION, wConversationFlags bits 0-3, background 0, back to the map afterwards) with wLoverHomeCastleConversationPending set, so the text is built first (rlBuildLoverHomeCastleConversation).

        lda #$0001
        tsb wConversationFlags,b
        lda #$0002
        tsb wConversationFlags,b
        lda #$0004
        tsb wConversationFlags,b
        lda #$0008
        tsb wConversationFlags,b
        lda #$0000
        sta wConversationBackground,b
        jsl rlSaveMapCameraAndLockCursor
        lda #CASTLE_SCREEN_CONVERSATION
        sta wCastleScreenHandler,b
        lda #CONVERSATION_EXIT_MAP
        sta wConversationExitMode,b
        lda #$0001
        sta wLoverHomeCastleConversationPending,b
        lda #$0002
        sta wScreenFadingProcInput,b
        lda #<>rsOpenCastleScreen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 8C/ED4F

    .endsection Unsorted8CED00Section


    .section Unsorted8CED4FSection

      .al
      .xl

      rlBuildLoverHomeCastleConversation ; 8C/ED4F

        .al
        .xl
        .autsiz
        .databank ?

        ; Builds the conversation at $7F8183 and points lConversationDialoguePointer at it: the arriving unit's line (aLoverHomeCastleArrivalLines, by wConversationLeftUnit) and then the lover's reply (aLoverHomeCastleReplyLines, by wConversationRightUnit), written over the first line's end code. Sets aDialogue.wUnit1 and wUnit2 to the two characters.

        phk
        plb
        .databank $8C
        lda wConversationLeftUnit,b
        sta aDialogue.wUnit1,b
        sec
        sbc #$0001
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda @l aLoverHomeCastleArrivalLines+1,x
        sta lR18+1
        lda @l aLoverHomeCastleArrivalLines,x
        sta lR18
        inc x
        inc x
        inc x
        lda @l aLoverHomeCastleArrivalLines,x
        sec
        sbc lR18
        sta wR0
        lda #$7F00
        sta lR19+1
        lda #$8183
        sta lR19
        jsl rlCopyLoverHomeCastleLine
        lda #$7F00
        sta lR18+1
        lda #$8183
        sta lR18
        lda wConversationRightUnit,b
        sta aDialogue.wUnit2,b
        sec
        sbc #$0001
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda @l aLoverHomeCastleReplyLines+1,x
        sta lR19+1
        lda @l aLoverHomeCastleReplyLines,x
        sta lR19
        inc x
        inc x
        inc x
        lda @l aLoverHomeCastleReplyLines,x
        sec
        sbc lR19
        sta wR0
        jsl rlAppendLoverHomeCastleLine
        lda #$7F00
        sta lConversationDialoguePointer+1,b
        lda #$8183
        sta lConversationDialoguePointer,b
        rtl

        .databank 0

        ; 8C/EDD0

    .endsection Unsorted8CED4FSection


    .section Unsorted8CEDD0Section

      .al
      .xl

      rlTryStartLoverHomeCastleConversation ; 8C/EDD0

        .al
        .autsiz
        .databank ?

        ; When the selected unit reaches its home castle (map step, rsEventCommandLoverHomeCastle): if its lover is fielded and waiting in that castle (rlCheckCharacterWaitingInHomeCastle) and the woman's flag in aLoverHomeCastleFlags is not set yet, sets the flag and starts the conversation (rlStartLoverHomeCastleConversation) with the arriving unit on the left. Carry set if it started.

        lda wSelectedUnitDataRAMPointer,b
        sta wTempVariable1,b
        jsl rlGetSelectedUnitLoverGenerationID
        ora #0
        beq _CLC

          jsl rlFindCharacterByGenerationID
          bcs _CLC

            jsl rlGetSelectedUnitCharacterID
            jsl rlCheckCharacterWaitingInHomeCastle
            bcc _CLC
            bra +

        _CLC
        lda wTempVariable1,b
        sta wSelectedUnitDataRAMPointer,b
        clc
        rtl

        +
        sta wConversationRightUnit,b
        lda wTempVariable1,b
        sta wSelectedUnitDataRAMPointer,b

        ; Get lover target CharacterID
        lda wSelectedUnitDataRAMPointer,b
        pha
        lda wConversationRightUnit,b
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta wConversationRightUnit,b

        ; Get own CharacterID
        pla
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitCharacterID
        sta wConversationLeftUnit,b

        lda wConversationLeftUnit,b
        sec
        sbc #1
        asl a
        tax
        lda aLoverHomeCastleFlags,x
        cmp #$FFFF
        beq +

          sta wTempVariable2,b
          jsl rlCheckPermanentEventFlagSet
          bcs _CLC

            lda wTempVariable2,b
            jsl rlSetPermanentEventFlag
            bra _EE64

        +
        lda wConversationRightUnit,b
        sec
        sbc #1
        asl a
        tax
        lda aLoverHomeCastleFlags,x
        cmp #$FFFF
        beq _EE64

          sta wTempVariable2,b
          jsl rlCheckPermanentEventFlagSet
          bcs _CLC

            lda wTempVariable2,b
            jsl rlSetPermanentEventFlag

        _EE64
        jsl rlStartLoverHomeCastleConversation
        sec
        rtl

        .databank 0

      aLoverHomeCastleFlags ; 8C/EE6A

        ; By character ID - 1: the permanent flag that marks the woman's
        ; conversation as seen, $FFFF for the men. A mother and the daughter who
        ; can replace her share one.

        .word $FFFF                                    ; Sigurd
        .word $FFFF                                    ; Naoise
        .word $FFFF                                    ; Alec
        .word $FFFF                                    ; Arden
        .word $FFFF                                    ; Finn
        .word $FFFF                                    ; Quan
        .word $FFFF                                    ; Midir
        .word $FFFF                                    ; Lewyn
        .word $FFFF                                    ; Chulainn
        .word $FFFF                                    ; Azelle
        .word $FFFF                                    ; Jamke
        .word $FFFF                                    ; Claud
        .word $FFFF                                    ; Beowulf
        .word $FFFF                                    ; Lex
        .word $FFFF                                    ; Dew
        .word PermanentFlagDeirdreLoverHomeCastle      ; Deirdre
        .word PermanentFlagEthlynLoverHomeCastle       ; Ethlyn
        .word PermanentFlagLachesisLoverHomeCastle     ; Lachesis
        .word PermanentFlagAyraLoverHomeCastle         ; Ayra
        .word PermanentFlagErinysLoverHomeCastle       ; Erinys
        .word PermanentFlagTailtiuLoverHomeCastle      ; Tailtiu
        .word PermanentFlagSilviaLoverHomeCastle       ; Silvia
        .word PermanentFlagEdainLoverHomeCastle        ; Edain
        .word PermanentFlagBrigidLoverHomeCastle       ; Brigid
        .word $FFFF                                    ; Seliph
        .word $FFFF                                    ; Shannan
        .word $FFFF                                    ; Dalvin
        .word $FFFF                                    ; Asaello
        .word $FFFF                                    ; Leif
        .word $FFFF                                    ; Iuchar
        .word $FFFF                                    ; Charlot
        .word $FFFF                                    ; Hawk
        .word $FFFF                                    ; Tristan
        .word $FFFF                                    ; AdultFinn
        .word $FFFF                                    ; Deimne
        .word $FFFF                                    ; Hannibal
        .word $FFFF                                    ; Ares
        .word $FFFF                                    ; Amid
        .word $FFFF                                    ; Oifey
        .word PermanentFlagDaisyPattyLoverHomeCastle   ; Daisy
        .word PermanentFlagCreidneLarceiLoverHomeCastle ; Creidne
        .word PermanentFlagMuirneLanaLoverHomeCastle   ; Muirne
        .word PermanentFlagJuliaLoverHomeCastle        ; Julia
        .word PermanentFlagAltenaLoverHomeCastle       ; Altena
        .word PermanentFlagHerminaFeeLoverHomeCastle   ; Hermina
        .word PermanentFlagLindaTineLoverHomeCastle    ; Linda
        .word PermanentFlagLayleaLeneLoverHomeCastle   ; Laylea
        .word PermanentFlagJeanneNannaLoverHomeCastle  ; Jeanne
        .word $FFFF                                    ; Iucharba
        .word $FFFF                                    ; Scathach
        .word $FFFF                                    ; Febail
        .word $FFFF                                    ; Coirpre
        .word $FFFF                                    ; Ced
        .word $FFFF                                    ; Diarmuid
        .word $FFFF                                    ; Lester
        .word $FFFF                                    ; Arthur
        .word PermanentFlagDaisyPattyLoverHomeCastle   ; Patty
        .word PermanentFlagCreidneLarceiLoverHomeCastle ; Larcei
        .word PermanentFlagMuirneLanaLoverHomeCastle   ; Lana
        .word PermanentFlagHerminaFeeLoverHomeCastle   ; Fee
        .word PermanentFlagLindaTineLoverHomeCastle    ; Tine
        .word PermanentFlagLayleaLeneLoverHomeCastle   ; Lene
        .word PermanentFlagJeanneNannaLoverHomeCastle  ; Nanna

    .endsection Unsorted8CEDD0Section


    .section Data8CEEE8Section

      .al
      .xl

      aLoverHomeCastleArrivalLines ; 8C/EEE8

        ; By character ID - 1: the line a unit says arriving home to its lover.
        ; Each line ends where the next begins; the last one where the replies do.

        .long dialogueLoverHomeCastleArrivalSigurd
        .long dialogueLoverHomeCastleArrivalNaoise
        .long dialogueLoverHomeCastleArrivalAlec
        .long dialogueLoverHomeCastleArrivalArden
        .long dialogueLoverHomeCastleArrivalFinn
        .long dialogueLoverHomeCastleArrivalQuan
        .long dialogueLoverHomeCastleArrivalMidir
        .long dialogueLoverHomeCastleArrivalLewyn
        .long dialogueLoverHomeCastleArrivalChulainn
        .long dialogueLoverHomeCastleArrivalAzelle
        .long dialogueLoverHomeCastleArrivalJamke
        .long dialogueLoverHomeCastleArrivalClaud
        .long dialogueLoverHomeCastleArrivalBeowulf
        .long dialogueLoverHomeCastleArrivalLex
        .long dialogueLoverHomeCastleArrivalDew
        .long dialogueLoverHomeCastleArrivalDeirdre
        .long dialogueLoverHomeCastleArrivalEthlyn
        .long dialogueLoverHomeCastleArrivalLachesis
        .long dialogueLoverHomeCastleArrivalAyra
        .long dialogueLoverHomeCastleArrivalErinys
        .long dialogueLoverHomeCastleArrivalTailtiu
        .long dialogueLoverHomeCastleArrivalSilvia
        .long dialogueLoverHomeCastleArrivalEdain
        .long dialogueLoverHomeCastleArrivalBrigid
        .long dialogueLoverHomeCastleArrivalSeliph
        .long dialogueLoverHomeCastleArrivalShannan
        .long dialogueLoverHomeCastleArrivalDalvin
        .long dialogueLoverHomeCastleArrivalAsaello
        .long dialogueLoverHomeCastleArrivalLeif
        .long dialogueLoverHomeCastleArrivalIuchar
        .long dialogueLoverHomeCastleArrivalCharlot
        .long dialogueLoverHomeCastleArrivalHawk
        .long dialogueLoverHomeCastleArrivalTristan
        .long dialogueLoverHomeCastleArrivalAdultFinn
        .long dialogueLoverHomeCastleArrivalDeimne
        .long dialogueLoverHomeCastleArrivalHannibal
        .long dialogueLoverHomeCastleArrivalAres
        .long dialogueLoverHomeCastleArrivalAmid
        .long dialogueLoverHomeCastleArrivalOifey
        .long dialogueLoverHomeCastleArrivalDaisy
        .long dialogueLoverHomeCastleArrivalCreidne
        .long dialogueLoverHomeCastleArrivalMuirne
        .long dialogueLoverHomeCastleArrivalJulia
        .long dialogueLoverHomeCastleArrivalAltena
        .long dialogueLoverHomeCastleArrivalHermina
        .long dialogueLoverHomeCastleArrivalLinda
        .long dialogueLoverHomeCastleArrivalLaylea
        .long dialogueLoverHomeCastleArrivalJeanne
        .long dialogueLoverHomeCastleArrivalIucharba
        .long dialogueLoverHomeCastleArrivalScathach
        .long dialogueLoverHomeCastleArrivalFebail
        .long dialogueLoverHomeCastleArrivalCoirpre
        .long dialogueLoverHomeCastleArrivalCed
        .long dialogueLoverHomeCastleArrivalDiarmuid
        .long dialogueLoverHomeCastleArrivalLester
        .long dialogueLoverHomeCastleArrivalArthur
        .long dialogueLoverHomeCastleArrivalPatty
        .long dialogueLoverHomeCastleArrivalLarcei
        .long dialogueLoverHomeCastleArrivalLana
        .long dialogueLoverHomeCastleArrivalFee
        .long dialogueLoverHomeCastleArrivalTine
        .long dialogueLoverHomeCastleArrivalLene
        .long dialogueLoverHomeCastleArrivalNanna
        .long dialogueLoverHomeCastleReplySigurd

      aLoverHomeCastleReplyLines ; 8C/EFA8

        ; By character ID - 1: the reply of the lover who was waiting. The last
        ; entry is where the last reply ends.

        .long dialogueLoverHomeCastleReplySigurd
        .long dialogueLoverHomeCastleReplyNaoise
        .long dialogueLoverHomeCastleReplyAlec
        .long dialogueLoverHomeCastleReplyArden
        .long dialogueLoverHomeCastleReplyFinn
        .long dialogueLoverHomeCastleReplyQuan
        .long dialogueLoverHomeCastleReplyMidir
        .long dialogueLoverHomeCastleReplyLewyn
        .long dialogueLoverHomeCastleReplyChulainn
        .long dialogueLoverHomeCastleReplyAzelle
        .long dialogueLoverHomeCastleReplyJamke
        .long dialogueLoverHomeCastleReplyClaud
        .long dialogueLoverHomeCastleReplyBeowulf
        .long dialogueLoverHomeCastleReplyLex
        .long dialogueLoverHomeCastleReplyDew
        .long dialogueLoverHomeCastleReplyDeirdre
        .long dialogueLoverHomeCastleReplyEthlyn
        .long dialogueLoverHomeCastleReplyLachesis
        .long dialogueLoverHomeCastleReplyAyra
        .long dialogueLoverHomeCastleReplyErinys
        .long dialogueLoverHomeCastleReplyTailtiu
        .long dialogueLoverHomeCastleReplySilvia
        .long dialogueLoverHomeCastleReplyEdain
        .long dialogueLoverHomeCastleReplyBrigid
        .long dialogueLoverHomeCastleReplySeliph
        .long dialogueLoverHomeCastleReplyShannan
        .long dialogueLoverHomeCastleReplyDalvin
        .long dialogueLoverHomeCastleReplyAsaello
        .long dialogueLoverHomeCastleReplyLeif
        .long dialogueLoverHomeCastleReplyIuchar
        .long dialogueLoverHomeCastleReplyCharlot
        .long dialogueLoverHomeCastleReplyHawk
        .long dialogueLoverHomeCastleReplyTristan
        .long dialogueLoverHomeCastleReplyAdultFinn
        .long dialogueLoverHomeCastleReplyDeimne
        .long dialogueLoverHomeCastleReplyHannibal
        .long dialogueLoverHomeCastleReplyAres
        .long dialogueLoverHomeCastleReplyAmid
        .long dialogueLoverHomeCastleReplyOifey
        .long dialogueLoverHomeCastleReplyDaisy
        .long dialogueLoverHomeCastleReplyCreidne
        .long dialogueLoverHomeCastleReplyMuirne
        .long dialogueLoverHomeCastleReplyJulia
        .long dialogueLoverHomeCastleReplyAltena
        .long dialogueLoverHomeCastleReplyHermina
        .long dialogueLoverHomeCastleReplyLinda
        .long dialogueLoverHomeCastleReplyLaylea
        .long dialogueLoverHomeCastleReplyJeanne
        .long dialogueLoverHomeCastleReplyIucharba
        .long dialogueLoverHomeCastleReplyScathach
        .long dialogueLoverHomeCastleReplyFebail
        .long dialogueLoverHomeCastleReplyCoirpre
        .long dialogueLoverHomeCastleReplyCed
        .long dialogueLoverHomeCastleReplyDiarmuid
        .long dialogueLoverHomeCastleReplyLester
        .long dialogueLoverHomeCastleReplyArthur
        .long dialogueLoverHomeCastleReplyPatty
        .long dialogueLoverHomeCastleReplyLarcei
        .long dialogueLoverHomeCastleReplyLana
        .long dialogueLoverHomeCastleReplyFee
        .long dialogueLoverHomeCastleReplyTine
        .long dialogueLoverHomeCastleReplyLene
        .long dialogueLoverHomeCastleReplyNanna
        .long dialogueLoverHomeCastleUnit1NameSama

        ; 8C/F068

        ; Not read: rep #$20, left before rlCopyLoverHomeCastleLine.
        .byte $C2, $20

        ; 8C/F06A

    .endsection Data8CEEE8Section


    .section Unsorted8CF06ASection

      .al
      .xl

      rlCopyLoverHomeCastleLine ; 8C/F06A

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies wR0 bytes from [lR18] to [lR19] and sets lR18 to lR19; leaves Y at the length.

        ldy #$0000

        _F06D
        lda [lR18],y
        sta [lR19],y
        inc y
        cpy wR0
        bne _F06D
        lda lR19+1
        sta lR18+1
        lda lR19
        sta lR18
        rtl

        .databank 0

        ; 8C/F07F

      rlAppendLoverHomeCastleLine ; 8C/F07F

        .al
        .xl
        .autsiz
        .databank ?

        ; Copies wR0 bytes from [lR19] to [lR18] + Y - 2: after the Y bytes already there, over their 2-byte end code.

        tya
        dec a
        dec a
        clc
        adc lR18
        sta lR20
        lda lR18+1
        adc #$0000
        sta lR20+1
        ldy #$0000

        _F091
        lda [lR19],y
        sta [lR20],y
        inc y
        cpy wR0
        bne _F091
        rtl

        .databank 0

        ; 8C/F09B

    .endsection Unsorted8CF06ASection


    .section LoverHomeCastleASMCSection

      .al
      .xl

      rlASMCLoverHomeCastleUnit2Name ; 8C/F09B

        .al
        .xl
        .autsiz
        .databank ?

        ; In an arrival line: pushes the waiting lover's name, with 様 (sama)
        ; when the lover is Seliph or Leif.

        lda aDialogue.wUnit2,b
        cmp #Seliph
        beq +

        cmp #Leif
        beq +

          lda #(`dialogueLoverHomeCastleUnit2Name)<<8
          sta lR18+1
          lda #<>dialogueLoverHomeCastleUnit2Name
          sta lR18
          jsl rlDialoguePushToActivePointerStack
          rtl

        +
        lda #(`dialogueLoverHomeCastleUnit2NameSama)<<8
        sta lR18+1
        lda #<>dialogueLoverHomeCastleUnit2NameSama
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rtl

        .databank 0

      rlASMCLoverHomeCastleUnit1Name ; 8C/F0C6

        .al
        .xl
        .autsiz
        .databank ?

        ; In a reply: pushes the arriving unit's name, with 様 (sama) when it
        ; is Seliph or Leif.

        lda aDialogue.wUnit1,b
        cmp #Seliph
        beq +

        cmp #Leif
        beq +

          lda #(`dialogueLoverHomeCastleUnit1Name)<<8
          sta lR18+1
          lda #<>dialogueLoverHomeCastleUnit1Name
          sta lR18
          jsl rlDialoguePushToActivePointerStack
          rtl

        +
        lda #(`dialogueLoverHomeCastleUnit1NameSama)<<8
        sta lR18+1
        lda #<>dialogueLoverHomeCastleUnit1NameSama
        sta lR18
        jsl rlDialoguePushToActivePointerStack
        rtl

        .databank 0

        ; 8C/F0F1

    .endsection LoverHomeCastleASMCSection
