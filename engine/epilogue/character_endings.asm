; The second generation's character endings (bank $8D): one scene per character
; 25-63 (wEpilogueCharacter), shown through the castle screen's conversation
; scene, then on to the credits. Holding B during them goes back to the title.


    .section Unsorted8DB4F1Section

      .al
      .xl

      rlNextEpilogueCharacterEnding ; 8D/B4F1

        .al
        .xl
        .autsiz
        .databank ?

        ; rlShowNextEpilogueCharacterEnding.

        jsl rlShowNextEpilogueCharacterEnding
        rtl

        .databank 0

        ; 8D/B4F6

    .endsection Unsorted8DB4F1Section


    .section Unsorted8DB4F6Section

      .al
      .xl

      rsCheckEpilogueQuitButton ; 8D/B4F6

        .al
        .xl
        .autsiz
        .databank ?

        ; While the character endings play, holding B goes back to the title (rsUnknown80B122, chapter 0, sound $21).

        lda wJoy1Input
        bit #$8000
        bne _B503
        bit #$2000
        bne _B52B
        rts


        _B503
        lda #$0000
        sta wCurrentChapter,b
        lda #$0021
        jsl rlPlaySoundEffect
        lda #$0002
        sta wMainGameMode,b
        lda #<>rsUnknown80B122
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        rts


        _B52B
        rts

        .databank 0

        ; 8D/B52C

      rlShowNextEpilogueCharacterEnding ; 8D/B52C

        .al
        .xl
        .autsiz
        .databank ?

        ; Starts the next character's ending scene (rsStartEpilogueCharacterScene), checks the B button and goes to the fade in (step 11).

        jsr rsStartEpilogueCharacterScene
        jsr rsCheckEpilogueQuitButton
        lda #EPILOGUE_STEP_FADE_IN
        sta wGameStateStep,b
        rtl

        .databank 0

        ; 8D/B539

    .endsection Unsorted8DB4F6Section


    .section Unsorted8DB53ASection

      .al
      .xl

      rsStartEpilogueCharacterScene ; 8D/B53A

        .al
        .xl
        .autsiz
        .databank ?

        ; Steps wEpilogueCharacter on (25-63) and starts its scene through the castle screen's conversation (dialogue from aEpilogueCharacterSceneDialogue, background by character); after the last, wEpiloguePart 1 and back to the epilogue screen for the credits.

        lda #$0002
        tsb wConversationFlags,b
        lda #$FFFF
        sta $7F7670
        lda #$0004
        trb wConversationFlags,b
        lda #$0008
        trb wConversationFlags,b
        lda #$0001
        trb wConversationFlags,b
        lda wEpilogueCharacter,b
        cmp #$003F
        bcc _B563
        bra _B5A9


        _B563
        inc wEpilogueCharacter,b
        lda wEpilogueCharacter,b
        sta aDialogue.wUnit1,b
        sta wConversationRightUnit,b
        lda wEpilogueCharacter,b
        sec
        sbc #$0019
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda aEpilogueCharacterSceneDialogue+1,x
        sta lConversationDialoguePointer+1,b
        lda aEpilogueCharacterSceneDialogue,x
        sta lConversationDialoguePointer,b
        lda wEpilogueCharacter,b
        and #$0003
        sta wConversationBackground,b
        lda #CONVERSATION_EXIT_CALLBACK
        sta wConversationExitMode,b
        lda #CASTLE_SCREEN_CONVERSATION
        sta wCastleScreenHandler,b
        lda #$0002
        sta wScreenFadingProcInput,b
        rts


        _B5A9
        lda #EPILOGUE_PART_CREDITS
        sta wEpiloguePart,b
        lda #<>rsOpenEpilogueScreen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        jsl rlSaveMapCameraAndLockCursor
        rts

        .databank 0

        ; 8D/B5C8

    .endsection Unsorted8DB53ASection


    .section Data8DB5C8Section

      .al
      .xl

      aEpilogueCharacterSceneDialogue ; 8D/B5C8

        ; Read by rsStartEpilogueCharacterScene.

        .byte $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B
        .byte $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC
        .byte $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $6B, $CC, $8D, $94, $CC, $8D
        .byte $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94
        .byte $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC
        .byte $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D
        .byte $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94, $CC, $8D, $94
        .byte $CC, $8D, $94, $CC, $8D

        ; 8D/B63D

    .endsection Data8DB5C8Section

