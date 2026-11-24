; The arena menu: rlArenaMenuRunStep runs the step in $0592 from
; aArenaMenuStepHandlers (fight or quit, the wager, continuing or leaving between
; rounds, changing weapons), with the menu text and the decompression DMA entries
; used when the arena screen is set up (rlArenaScreenSetup), and the opponent
; window (rsDrawArenaOpponent); starting the fight (rlStartArenaBattle) and
; reading its result (rlGetArenaBattleResult). Banks $84, $87 and $8A. Its lines are in
; text/dialogue/Shops with the other keepers'.

    .section ArenaMenuSection

      .al
      .xl

      aArenaUnusedByte8AE4B9 ; 8A/E4B9

        .byte $00


      aArenaVRAMClearByte ; 8A/E4BA

        ; Read as a zero word (with the next byte) by a fixed-source DMA that clears VRAM.
        .byte $00


      aArenaDecompressionEntry4000 ; 8A/E4BB

        ; Entry for rlHandleMapMenuDecompressionDMA, as aDebugMenuC00A2BDecompressionEntry.
        .structDecompressionDMAEntry gcUnknownC00A2B, $1800, $4000


      aArenaDecompressionEntry0000 ; 8A/E4C3

        ; Entry for rlHandleMapMenuDecompressionDMA, as aDebugMenuC00A2BDecompressionEntry.
        .structDecompressionDMAEntry gcUnknownD306D6, $1000, $0000


      aArenaDecompressionEntry2800 ; 8A/E4CB

        ; Entry for rlHandleMapMenuDecompressionDMA, as aDebugMenuC00A2BDecompressionEntry.
        .structDecompressionDMAEntry gcUnknownD46691, $0800, $2800


      aArenaDecompressionEntry2C00 ; 8A/E4D3

        ; Entry for rlHandleMapMenuDecompressionDMA, as aDebugMenuC00A2BDecompressionEntry.
        .structDecompressionDMAEntry gcUnknownD467EF, $0800, $2C00


      rlArenaMenuRunStep ; 8A/E4DB

        ; Nothing in the build reaches this. Copies the BG3 tilemap to VRAM, runs
        ; the arena menu step in $0592 from aArenaMenuStepHandlers, then redraws.

        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $8A
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        lda wMenuState,b
        asl a
        tax
        jsr (aArenaMenuStepHandlers,x)
        lda #$0008
        sta wR0
        lda #$0008
        sta wR1
        ldx #$0000
        jsr rsPushKeeperPortraitSprites
        lda wCastleRedrawIcons
        beq _E50D
        jsr rsPushCastleListSprites

        _E50D
        plp
        plb
        .databank $8A
        rtl

        .databank 0

        ; 8A/E510

      aArenaMenuStepHandlers ; 8A/E510

        .word <>rsArenaMenuStepInit, <>rsArenaMenuStepWaitDialogue, <>rsArenaMenuStepAfterBattle, <>rsArenaMenuStepAfterYield, <>rsArenaMenuStepFightOrQuit, <>rsArenaMenuStepWaitGoldDialogue, <>rsArenaMenuStepCountUpGold, <>rsArenaMenuStepConfirmNextRound, <>rsArenaMenuStepLeaveContinueWeapon, <>rsArenaMenuStepShowOpponent, <>rsArenaMenuStepStartQuitChangeWeapon, <>rsArenaMenuStepFadeAndStartBattle, <>rsArenaMenuStepOpenWeaponList, <>rsArenaMenuStepSelectWeapon, <>rsArenaMenuStepExitArena, <>rsArenaMenuStepExitAfterLoss


      rsArenaMenuStepInit ; 8A/E530

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 0: checks arena level (<7) and starts welcome or cleared dialogue

        ; Arena menu step 0 (aArenaMenuStepHandlers).

        stz $0AD7,b
        jsl rlGetSelectedUnitArenaLevel
        cmp #$0007
        bcs _E56E
        lda #$000F
        tax
        lda aShopDialoguePointers+1,x
        sta lR18+1
        lda aShopDialoguePointers,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0004
        sta wNextMenuState,b

        _E565
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rts


        _E56E
        lda #(`dialogueShopArenaNoOpponentsLeft)<<8
        sta lR18+1
        lda #<>dialogueShopArenaNoOpponentsLeft
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$000E
        sta wNextMenuState,b
        bra _E565

        .databank 0

        ; 8A/E593

      rsArenaMenuStepAfterBattle ; 8A/E593

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 2: handles battle result (win, loss, yield) and starts reward/champion/loss dialogue

        ; Arena menu step 2 (aArenaMenuStepHandlers).

        jsl rlGetArenaBattleResult
        cmp #$0001
        beq _E5E7
        cmp #$0002
        beq _E5E3
        jsl rlHandleArenaExitEvent
        stz $0AD7,b
        sta aDialogue.wNumber1,b
        jsr _E63C
        jsl rlGetSelectedUnitArenaLevel
        cmp #$0007
        bcs _E617
        lda #(`dialogueShopArenaWon)<<8
        sta lR18+1
        lda #<>dialogueShopArenaWon
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0005
        sta wMenuState,b
        lda #$0007
        sta wNextMenuState,b

        _E5DA
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rts


        _E5E3
        jml rsArenaMenuStepAfterYield


        _E5E7
        jsl rlHandleArenaExitEvent
        jsl rlGetSelectedUnitCharacterID
        sta aDialogue.wUnit1,b
        lda #(`dialogueShopArenaLost)<<8
        sta lR18+1
        lda #<>dialogueShopArenaLost
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$000F
        sta wNextMenuState,b
        bra _E5DA


        _E617
        lda #(`dialogueShopArenaChampion)<<8
        sta lR18+1
        lda #<>dialogueShopArenaChampion
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0005
        sta wMenuState,b
        lda #$000E
        sta wNextMenuState,b
        bra _E5DA


        _E63C
        lda $0AD9,b
        ldx #$0646
        jsl rlDrawCastleNumber
        rts

        .databank 0

        ; 8A/E647

      rsArenaMenuStepAfterYield ; 8A/E647

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 3: starts yield/draw dialogue and advances to step 8

        ; Arena menu step 3 (aArenaMenuStepHandlers).

        lda #(`dialogueShopArenaAskYield)<<8
        sta lR18+1
        lda #<>dialogueShopArenaAskYield
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0008
        sta wNextMenuState,b
        sep #$20
        lda #$0F
        sta bBufferINIDISP
        rep #$20
        rts

        .databank 0

        ; 8A/E673

      rsArenaMenuStepWaitDialogue ; 8A/E673

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 1: waits for dialogue to finish, draws A-press arrows, then advances to wNextMenuState

        ; Arena menu step 1 (aArenaMenuStepHandlers).

        lda aDialogue.wStatus,b
        beq _E687
        lda #$00E8
        sta wR0
        lda #$0036
        sta wR1
        jsl rlDisplayDialogueAPressArrows
        rts


        _E687
        lda wNextMenuState,b
        sta wMenuState,b
        rts

        .databank 0

        ; 8A/E68E

      rsArenaMenuStepFightOrQuit ; 8A/E68E

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 4: Fight or Quit menu

        ; Arena menu step 4 (aArenaMenuStepHandlers).

        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aArenaFightQuitText)<<8
        sta lR18+1
        lda #<>aArenaFightQuitText
        sta lR18
        lda $18DD,b
        cmp #$0100
        beq _E6B8
        clc
        adc #$0120
        bra _E6BC


        _E6B8
        sec
        sbc #$0040

        _E6BC
        clc
        adc #$000B
        tax
        jsl rlDrawMenuTextLine
        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        lda #(`aUnknown8AD088)<<8
        sta lR19+1
        lda #<>aUnknown8AD088
        sta lR19
        lda #(`aUnknown8AD08A)<<8
        sta lR20+1
        lda #<>aUnknown8AD08A
        sta lR20
        lda #$0002
        jsr rsCastleOptionMenuInput
        lda #$0000
        jsl rlPushCastleHandCursor
        lda #$0000
        sta wCastleRedrawIcons
        lda wJoy1New
        cmp #$8000
        beq _E70D
        cmp #$0080
        bne _E70C
        lda wCastleMenuOptionIndex,b
        cmp #$0000
        beq _E73E
        cmp #$0001
        beq _E70D

        _E70C
        rts


        _E70D
        lda #$000F
        tax
        lda aShopDialoguePointers+55,x
        sta lR18+1
        lda aShopDialoguePointers+54,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$000E
        sta wNextMenuState,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _E73E
        lda wCastleListItemCount,b
        beq _E77B
        jsl rlGetSelectedUnitArenaLevel
        clc
        adc #$0001
        sta aDialogue.wNumber1,b
        lda #(`dialogueShopArenaEquipWeaponFirst)<<8
        sta lR18+1
        lda #<>dialogueShopArenaEquipWeaponFirst
        sta lR18
        lda #$000C
        bra _E75D


        _E75D
        sta wNextMenuState,b
        lda #$0001
        sta wMenuState,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$000A
        jsl rlPlaySoundEffect
        rts


        _E77B
        lda #(`dialogueShopArenaNoWeapon)<<8
        sta lR18+1
        lda #<>dialogueShopArenaNoWeapon
        sta lR18
        jml rsShopSayAndStay

        .databank 0

        ; 8A/E789

      aArenaFightQuitText ; 8A/E789

        ; たたかう (fight), やめる (quit). The two bytes after it are unknown.

        .enc "SJIS"
        .text "たたかう　　　やめる　　　　　　　　　　　\n"
        .byte $58, $88


      rsArenaMenuStepWaitGoldDialogue ; 8A/E7B7

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 5: waits for reward dialogue and triggers gold count-up

        ; Arena menu step 5 (aArenaMenuStepHandlers).

        lda aDialogue.wStatus,b
        beq _E7D5
        bit #$4000
        bne _E7C7
        bit #$8000
        bne _E7C7
        rts


        _E7C7
        lda #$0006
        sta wMenuState,b
        lda #$000B
        jsl rlPlaySoundEffect
        rts


        _E7D5
        jsr rsDrawCastleUnitMoney
        lda wNextMenuState,b
        sta wMenuState,b
        rts

        .databank 0

        ; 8A/E7DF

      rsArenaMenuStepCountUpGold ; 8A/E7DF

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 6: animates prize gold count-up by 100G per frame

        ; Arena menu step 6 (aArenaMenuStepHandlers).

        lda aDialogue.wStatus,b
        beq _E821
        lda #$00E8
        sta wR0
        lda #$0036
        sta wR1
        jsl rlDisplayDialogueAPressArrows
        lda $0AD9,b
        clc
        adc #$0064
        sta $0AD9,b
        jsl rlGetSelectedUnitMoney
        cmp $0AD9,b
        bcc _E810
        lda $0AD9,b
        ldx #$0646
        jsl rlDrawCastleNumber
        rts


        _E810
        jsr rsDrawCastleUnitMoney
        lda #$0001
        sta wMenuState,b
        lda #$000C
        jsl rlPlaySoundEffect
        rts


        _E821
        jsr rsDrawCastleUnitMoney
        lda wNextMenuState,b
        sta wMenuState,b
        lda #$000C
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/E832

      rsArenaMenuStepConfirmNextRound ; 8A/E832

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 7: Yes/No prompt to fight the next arena round

        ; Arena menu step 7 (aArenaMenuStepHandlers).

        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlDialogueFreeHDMA
        jsr rsDrawYesNo
        jsr rsCastleYesNoInput
        lda #$0000
        jsl rlPushCastleHandCursor
        lda wJoy1New
        cmp #$8000
        beq _E8B3
        cmp #$0080
        bne _E86E
        lda wCastleConfirmCursorIndex,b
        cmp #$0000
        beq _E86F
        cmp #$0001
        beq _E8B3

        _E86E
        rts


        _E86F
        jsl rlGetSelectedUnitArenaLevel
        clc
        adc #$0001
        sta aDialogue.wNumber1,b
        lda wCastleListItemCount,b
        beq _E8DE
        jsl rlGetSelectedUnitEquippedWeaponBitfield
        cmp #$0000
        beq _E8EC
        lda #(`dialogueShopArenaOpponentLevel)<<8
        sta lR18+1
        lda #<>dialogueShopArenaOpponentLevel
        sta lR18
        lda #$0009
        sta wNextMenuState,b
        lda #$0001
        sta wMenuState,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$000A
        jsl rlPlaySoundEffect
        rts


        _E8B3
        lda #(`dialogueShopArenaQuit)<<8
        sta lR18+1
        lda #<>dialogueShopArenaQuit
        sta lR18
        lda #$000E
        sta wNextMenuState,b
        lda #$0001
        sta wMenuState,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _E8DE
        lda #(`dialogueShopArenaNoWeapon)<<8
        sta lR18+1
        lda #<>dialogueShopArenaNoWeapon
        sta lR18
        jml rsShopSayAndStay


        _E8EC
        lda #(`dialogueShopArenaEquipWeaponFirst)<<8
        sta lR18+1
        lda #<>dialogueShopArenaEquipWeaponFirst
        sta lR18
        lda #$000C
        sta wNextMenuState,b
        lda #$0001
        sta wMenuState,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$000A
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/E917

      rsArenaMenuStepLeaveContinueWeapon ; 8A/E917

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 8: Leave, Continue, or Change Weapon menu after a draw/yield

        ; Arena menu step 8 (aArenaMenuStepHandlers).

        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsDrawArenaOpponent
        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aArenaLeaveContinueChangeWeaponText)<<8
        sta lR18+1
        lda #<>aArenaLeaveContinueChangeWeaponText
        sta lR18
        lda $18DD,b
        cmp #$0100
        beq _E956
        clc
        adc #$0120
        bra _E95A


        _E956
        sec
        sbc #$0040

        _E95A
        clc
        adc #$000B
        tax
        jsl rlDrawMenuTextLine
        lda #(`aUnknown8AD08C)<<8
        sta lR19+1
        lda #<>aUnknown8AD08C
        sta lR19
        lda #(`aUnknown8AD08F)<<8
        sta lR20+1
        lda #<>aUnknown8AD08F
        sta lR20
        lda #$0003
        jsr rsCastleOptionMenuInput
        lda #$0000
        jsl rlPushCastleHandCursor
        lda #$0000
        sta wCastleRedrawIcons
        lda wJoy1New
        cmp #$8000
        beq _E9DB
        cmp #$0080
        bne _E9A9
        lda wCastleMenuOptionIndex,b
        cmp #$0000
        beq _E9DB
        cmp #$0001
        beq _E9AA
        cmp #$0002
        beq _EA06

        _E9A9
        rts


        _E9AA
        lda wCastleListItemCount,b
        beq _E9CD
        jsl rlGetSelectedUnitEquippedWeaponBitfield
        cmp #$0000
        beq _EA06
        lda #$0000
        sta wCastleRedrawIcons
        lda #$0081
        jsl rlPlaySoundEffect
        lda #$000B
        sta wMenuState,b
        rts


        _E9CD
        lda #(`dialogueShopArenaNoWeapon)<<8
        sta lR18+1
        lda #<>dialogueShopArenaNoWeapon
        sta lR18
        jml rsShopSayAndStay


        _E9DB
        lda #(`dialogueShopArenaQuit)<<8
        sta lR18+1
        lda #<>dialogueShopArenaQuit
        sta lR18
        lda #$000E
        sta wNextMenuState,b
        lda #$0001
        sta wMenuState,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _EA06
        lda wCastleListItemCount,b
        beq _E9CD
        lda #$0002
        sta wCastleMenuOptionIndex,b
        lda #(`dialogueShopArenaEquipWeaponFirst)<<8
        sta lR18+1
        lda #<>dialogueShopArenaEquipWeaponFirst
        sta lR18
        lda #$000C
        sta wNextMenuState,b
        lda #$0001
        sta wMenuState,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$000A
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/EA3C

      aArenaLeaveContinueChangeWeaponText ; 8A/EA3C

        ; りだつ (leave), けいぞく (continue), ぶきもちかえ (change weapon).

        .enc "SJIS"
        .text "りだつ　　　けいぞく　　　ぶきもちかえ\n"


      rsArenaMenuStepShowOpponent ; 8A/EA64

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 9: draws opponent window and advances to step 10

        ; Arena menu step 9 (aArenaMenuStepHandlers).

        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsDrawArenaOpponent
        lda #$000A
        sta wMenuState,b

        .databank 0

        ; 8A/EA7F

      rsArenaMenuStepStartQuitChangeWeapon ; 8A/EA7F

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 10: Start, Quit, or Change Weapon menu

        ; Arena menu step 10 (aArenaMenuStepHandlers).

        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #(`aArenaStartQuitChangeWeaponText)<<8
        sta lR18+1
        lda #<>aArenaStartQuitChangeWeaponText
        sta lR18
        jsr rsDrawArenaChoice
        lda #(`aUnknown8AD08C)<<8
        sta lR19+1
        lda #<>aUnknown8AD08C
        sta lR19
        lda #(`aUnknown8AD08F)<<8
        sta lR20+1
        lda #<>aUnknown8AD08F
        sta lR20
        lda #$0003
        jsr rsCastleOptionMenuInput
        lda #$0000
        jsl rlPushCastleHandCursor
        lda #$0000
        sta wCastleRedrawIcons
        lda wJoy1New
        cmp #$8000
        beq _EAE5
        cmp #$0080
        bne _EAE4
        lda wCastleMenuOptionIndex,b
        cmp #$0000
        beq _EB16
        cmp #$0001
        beq _EAE5
        cmp #$0002
        beq _EB2B

        _EAE4
        rts


        _EAE5
        lda #$000F
        tax
        lda aShopDialoguePointers+55,x
        sta lR18+1
        lda aShopDialoguePointers+54,x
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$000E
        sta wNextMenuState,b
        lda #$0021
        jsl rlPlaySoundEffect
        rts


        _EB16
        lda #$0000
        sta wCastleRedrawIcons
        lda #$0081
        jsl rlPlaySoundEffect
        lda #$000B
        sta wMenuState,b
        rts


        _EB2B
        lda #(`dialogueShopArenaEquipWeaponFirst)<<8
        sta lR18+1
        lda #<>dialogueShopArenaEquipWeaponFirst
        sta lR18
        lda #$000C
        sta wNextMenuState,b
        lda #$0001
        sta wMenuState,b
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$000A
        jsl rlPlaySoundEffect
        rts

        .databank 0

        ; 8A/EB56

      aArenaStartQuitChangeWeaponText ; 8A/EB56

        ; かいし (start), やめる (quit), ぶきもちかえ (change weapon).

        .enc "SJIS"
        .text "かいし　　　やめる　　　　ぶきもちかえ\n"

      aArenaStartQuitText ; 8A/EB7E

        .text "かいし　　　やめる\n"


      rsArenaMenuStepFadeAndStartBattle ; 8A/EB92

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 11: fades out screen, saves money, and calls rlStartArenaBattle

        ; Arena menu step 11 (aArenaMenuStepHandlers).

        lda wVBlankEnabledFramecount
        and #$0003
        bne _EBA3
        sep #$20
        lda bBufferINIDISP
        and #$0F
        beq _EBA6
        dec bBufferINIDISP

        _EBA3
        rep #$20
        rts


        _EBA6
        .as
        rep #$20
        jsl rlGetSelectedUnitMoney
        sta $0AD9,b
        inc $0AD7,b
        jsl rlStartArenaBattle
        rts

        .databank 0

        ; 8A/EBB7

      rsArenaMenuStepOpenWeaponList ; 8A/EBB7

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 12: opens weapon selection list

        ; Arena menu step 12 (aArenaMenuStepHandlers).

        lda #$FFFF
        sta wCastleRedrawIcons
        jsr rsDrawStockItemDetails
        jsr rsPushStockItemTypeIcon
        jsr rsClearCastleList
        jsr rsDrawStockList
        lda #$000D
        sta wMenuState,b
        rts

        .databank 0

        ; 8A/EBD1

      rsArenaMenuStepSelectWeapon ; 8A/EBD1

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 13: handles weapon selection input and equips chosen weapon

        ; Arena menu step 13 (aArenaMenuStepHandlers).

        jsr rsPushStockItemTypeIcon
        lda wCastleListWindowRow,b
        tax
        lda #$004C
        sta wR0
        lda aCastleListRowY,x
        and #$00FF
        clc
        adc #$0004
        sta wR1
        lda #$0000
        jsl rlPushCastleHandCursor
        jsr rsCastleStockListInput
        lda wJoy1New
        cmp #$0080
        beq _EC01
        cmp #$8000
        beq _EC69
        rts


        _EC01
        lda wCastleListSelectedIndex,b
        asl a
        tax
        lda aCastleListInventorySlots,x
        sta wRoutineVariable1,b
        jsl rlGetItemROMDataByInventorySlot
        lda wCurrentItemDataROMPointer,b
        beq _EC68
        lda wRoutineVariable1,b
        sta wSelectedInventorySlot,b
        jsl rlApplySelectedInventorySlotBonus
        jsr rsClearItemDetailsWindow
        jsr rsClearCastleList
        lda #$0000
        sta wCastleRedrawIcons
        lda #$000A
        jsl rlPlaySoundEffect
        lda #(`dialogueShopArenaOpponentLevel)<<8
        sta lR18+1
        lda #<>dialogueShopArenaOpponentLevel
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        stz wCastleMenuOptionIndex,b
        lda #$0009
        sta wNextMenuState,b
        lda $0AD7,b
        beq _EC68
        jsl rlGetArenaBattleResult
        cmp #$0002
        beq _ECB2

        _EC68
        rts


        _EC69
        lda #$0021
        jsl rlPlaySoundEffect
        lda #(`dialogueShop06)<<8
        sta lR18+1
        lda #<>dialogueShop06
        sta lR18
        lda #$0003
        jsl rlDialogueStartTextAndHDMA
        ldx #$0000
        jsr rsSetupKeeperDialogueBox
        lda #$0001
        sta wMenuState,b
        lda #$0004
        sta wNextMenuState,b
        jsr rsClearItemDetailsWindow
        jsr rsClearCastleList
        lda #$0000
        sta wCastleRedrawIcons
        stz wCastleMenuOptionIndex,b
        lda $0AD7,b
        beq _EC68
        jsl rlGetArenaBattleResult
        cmp #$0002
        beq _ECB2
        rts


        _ECB2
        lda #$0001
        sta wCastleMenuOptionIndex,b
        lda #$0008
        sta wNextMenuState,b
        rts

        .databank 0

        ; 8A/ECBF

      rsArenaMenuStepExitArena ; 8A/ECBF

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 14: blanks screen, returns to CASTLE_STEP_REOPEN_TOWN, and fires exit event if needed

        ; Arena menu step 14 (aArenaMenuStepHandlers).

        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #CASTLE_STEP_REOPEN_TOWN
        sta wGameStateStep,b
        jsl rlGetArenaBattleResult
        cmp #$0002
        bne _ECDF
        lda $0AD7,b
        beq _ECDF
        jsl rlHandleArenaExitEvent

        _ECDF
        rts

        .databank 0

        ; 8A/ECE0

      rsArenaMenuStepExitAfterLoss ; 8A/ECE0

        .al
        .xl
        .autsiz
        .databank ?

        ; Arena menu step 15: blanks screen and returns to CASTLE_STEP_REOPEN_TOWN after a loss

        ; Arena menu step 15 (aArenaMenuStepHandlers).

        sep #$20
        lda #$80
        sta bBufferINIDISP
        rep #$20
        lda #CASTLE_STEP_REOPEN_TOWN
        sta wGameStateStep,b
        rts

        .databank 0

        ; 8A/ECEF

    .endsection ArenaMenuSection


    .section Unsorted87A082Section

      .al
      .xl

      rlGetArenaOpponentCharacterID ; 87/A082

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Returns arena opponent character ID in A for current chapter, arena level, and weapon range (carry set if >= 7)

        phb
        php
        phk
        plb
        .databank $87
        phx
        lda wSelectedUnitDataRAMPointer,b
        pha
        jsl rlGetSelectedUnitArenaLevel
        cmp #$0007
        bcs _A0D5
        asl a
        sta wRoutineVariable1,b
        jsl rlGetChapterArenaOpponentsPointer
        ldx lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?
        jsl rlGetSelectedItemRange
        lda wR10
        cmp #$0002
        bcs _A0B6
        lda $0000,b,x
        bra _A0B9


        _A0B6
        lda $0002,b,x

        _A0B9
        clc
        adc wRoutineVariable1,b
        tax
        lda $0000,b,x
        jsl rlGetUnitRAMDataPointerByID
        bcs _A0C9
        inc x
        inc x

        _A0C9
        lda $0000,b,x
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        .databank ?
        clc

        _A0D4
        rtl


        _A0D5
        plx
        stx wSelectedUnitDataRAMPointer,b
        plx
        plp
        plb
        .databank ?
        sec
        bra _A0D4

        .databank 0

        ; 87/A0DF

      rlGetArenaOpponentEquippedWeapons ; 87/A0DF

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Gets arena opponent's equipped weapon ROM pointers for display

        phb
        php
        phk
        plb
        .databank $87
        phx
        phy
        jsl rlGetArenaOpponentCharacterID
        bcs _A135
        tay
        stz wTempItemDataROMPointer,b
        ldx #$0002
        tya
        jsl rlGetCharacterEquipSlotItemROMPointer
        lda wCurrentItemDataROMPointer,b
        beq _A10B
        jsl rlGetItemEquipmentType
        cmp #$0002
        bne _A10B
        lda wCurrentItemDataROMPointer,b
        sta wTempItemDataROMPointer,b

        _A10B
        ldx #$0001

        _A10E
        tya
        jsl rlGetCharacterEquipSlotItemROMPointer
        lda wCurrentItemDataROMPointer,b
        beq _A129
        jsl rlGetItemMinimumRange
        dec a
        cmp wR10
        bcs _A129
        jsl rlGetItemMaximumRange
        cmp wR10
        bcs _A12F

        _A129
        inc x
        cpx #$0003
        bcc _A10E

        _A12F
        ply
        plx
        plp
        plb
        .databank ?
        clc

        _A134
        rtl


        _A135
        ply
        plx
        plp
        plb
        .databank ?
        sec
        bra _A134

        .databank 0

        ; 87/A13C

      rlGetUnitWinCount ; 87/A13C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        stz wRoutineVariable1,b
        lda wCurrentChapter,b
        cmp #$0006
        bcc _A152
        lda #$0018
        sta wRoutineVariable1,b

        _A152
        jsl rlGetSelectedUnitGenerationID
        dec a
        clc
        adc wRoutineVariable1,b
        asl a
        tax
        lda aUnitWinCounts,x
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/A165

      rlGetUnitLossCount ; 87/A165

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $87
        phx
        stz wRoutineVariable1,b
        lda wCurrentChapter,b
        cmp #$0006
        bcc _A17B
        lda #$0018
        sta wRoutineVariable1,b

        _A17B
        jsl rlGetSelectedUnitGenerationID
        dec a
        clc
        adc wRoutineVariable1,b
        jsl rlGetLossCountByIndex
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 87/A18C

    .endsection Unsorted87A082Section


    .section Unsorted8AADF4Section

      .al
      .xl

      rsDrawArenaOpponent ; 8A/ADF4

        .al
        .xl
        .autsiz
        .databank ?

        ; Draws the arena opponent: name, class, weapons, level and the B-to-quit line.

        lda #$2800
        sta aCurrentTilemapInfo,b
        lda #(`aArenaEnemyText)<<8
        sta lRoutineVariable+1,b
        lda #<>aArenaEnemyText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0A0D
        jsl rlDrawMenuTextLine
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsl rlGetArenaOpponentCharacterID
        sta wTempVariable1,b
        jsl rlGetCharacterNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0C0E
        jsl rlDrawMenuTextLine
        lda wTempVariable1,b
        jsl rlGetCharacterClass
        jsl rlGetClassNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0E0E
        jsl rlDrawMenuTextLine
        jsl rlGetArenaOpponentEquippedWeapons
        jsl rlGetItemNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$100E
        jsl rlDrawMenuTextLine
        lda wTempItemDataROMPointer,b
        beq _AE8B
        sta wCurrentItemDataROMPointer,b
        jsl rlGetItemNamePointer
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$120E
        jsl rlDrawMenuTextLine

        _AE8B
        lda #(`aArenaBToQuitText)<<8
        sta lRoutineVariable+1,b
        lda #<>aArenaBToQuitText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$160E
        jsl rlDrawMenuTextLine
        lda #(`aArenaLevelText)<<8
        sta lRoutineVariable+1,b
        lda #<>aArenaLevelText
        sta lRoutineVariable,b
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        ldx #$0E17
        jsl rlDrawMenuTextLine
        lda wTempVariable1,b
        jsl rlGetCharacterLevel
        ldx #$24F0
        stx aCurrentTilemapInfo,b
        ldx #$0E19
        jsl rlDrawTallTwoDigitNumberToTilemapEntry
        rts

        .databank 0

        ; 8A/AEDA

    .endsection Unsorted8AADF4Section


    .section Table8AAEDASection

      .al
      .xl

      aArenaEnemyText ; 8A/AEDA

        .enc "SJIS"
        .text "ＥＮＥＭＹ"
        .word $0000
        .enc "none"

      aArenaLevelText ; 8A/AEE6

        .enc "SJIS"
        .text "ＬＶ"
        .word $0000
        .enc "none"

      aArenaBToQuitText ; 8A/AEEC

        .enc "SJIS"
        .text "☆Ｂボタンでちゅうしできます"
        .word $0000
        .enc "none"


    .endsection Table8AAEDASection


    .section Unsorted8AE2F8Section

      .al
      .xl

      rlArenaScreenSetup ; 8A/E2F8

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Blanks the screen and loads the arena: graphics, keeper, the unit's weapon list, money; moves to step $04.

        phk
        plb
        .databank $8A
        sep #$20
        lda #$80
        sta $2100,b
        sta bBufferINIDISP
        rep #$20
        jsl rlDisableVBlank
        jsl rlResetHDMAEngine
        lda #$004B
        sta wMusicID,b
        jsl rlStepMusicScript
        phk
        plb
        .databank $8A
        rep #$30
        lda #$1809
        sta $4300,b
        lda #(`aArenaVRAMClearByte)<<8
        sta $4303,b
        lda #<>aArenaVRAMClearByte
        sta $4302,b
        lda #$2000
        sta $4305,b
        lda #$2000
        sta $2116,b
        sep #$20
        lda #$01
        sta $420B,b
        rep #$20
        jsl rlResetDialogueEngine
        jsr rsSetKeeperOptionList
        jsl rlLoadChapterMapLayout
        lda wEventLocationEntry,b
        pha
        jsl rlUpdateAllLocationEvents
        jsl rlApplyAllActiveMapChanges
        pla
        sta wEventLocationEntry,b
        lda #$0000
        sta wR1
        lda #$0000
        sta wR2
        lda #$4000
        sta wR3
        sta wR4
        lda #$6000
        sta wR5
        lda #$2800
        sta wR6
        lda #$2C00
        sta wR7
        lda #$3800
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        lda #(`aArenaDecompressionEntry0000)<<8
        sta lR19+1
        lda #<>aArenaDecompressionEntry0000
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM g4bppCursorSprites, $0400, $80, $C000

        jsl rlDMAByStruct

          .structDMAToVRAM g4bppWeaponTypeIcons, $0800, $80, $D600

        lda #(`aArenaDecompressionEntry2800)<<8
        sta lR19+1
        lda #<>aArenaDecompressionEntry2800
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        lda #(`aArenaDecompressionEntry2C00)<<8
        sta lR19+1
        lda #<>aArenaDecompressionEntry2C00
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlDMAByStruct

          .structDMAToVRAM g2bppItemStatLabels, $0800, $80, $9800

        lda #(`aArenaDecompressionEntry4000)<<8
        sta lR19+1
        lda #<>aArenaDecompressionEntry4000
        sta lR19
        jsl rlHandleMapMenuDecompressionDMA
        jsl rlGetDialogueBoxGraphicsAndPalette
        ldx #$0800
        lda #$00FF

        _E3EF
        sta aBG3TilemapBuffer,x
        dec x
        dec x
        bne _E3EF
        jsl rlDMAByStruct

          .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $7000

        ldx #$01FE

        _E407
        lda aCastleArenaBGPalettes,x
        sta aBGPaletteBuffer,b,x
        dec x
        dec x
        bpl _E407
        lda #$0001
        jsl rlUnitWindowCopySpritePalette1
        lda #$0002
        jsl rlUnitWindowCopySpritePalette2
        jsr rsLoadKeeperPortrait
        sep #$20
        lda #$17
        sta bBufferTM
        lda #$00
        sta bBufferTS
        lda #$00
        sta bBufferCGWSEL
        lda #$00
        sta bBufferCGADSUB
        lda #$04
        ora #$20
        sta bBufferCOLDATA_1
        lda #$04
        ora #$40
        sta bBufferCOLDATA_2
        lda #$04
        ora #$80
        sta bBufferCOLDATA_3
        rep #$20
        lda $0AD7,b
        beq _E457
        jsl rlGetArenaBattleResult
        cmp #$0002
        beq _E45D

        _E457
        jsl rlBuildEquippableWeaponList
        bra _E461


        _E45D
        jsl rlBuildEquippableWeaponListSameRange

        _E461
        stz wCastleMenuOptionIndex,b
        jsr rsCastleDrawListItemIcons
        stz wMenuState,b
        stz wCastleMenuOptionIndex,b
        stz wCastleConfirmCursorIndex,b
        stz wCastleListWindowRow,b
        stz wCastleListSelectedIndex,b
        lda #$0000
        sta wCastleRedrawIcons
        lda #(`aCastleMenuTilemapData)<<8
        sta lMapMenuTilemapRAMEntryPointer+1,b
        lda #<>aCastleMenuTilemapData
        sta lMapMenuTilemapRAMEntryPointer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        jsr rsClearItemDetailsWindow
        jsr rsDrawCastleUnitMoney
        jsr rsClearCastleList
        lda #(`aUnknown8AB230)<<8
        sta lR44+1
        lda #<>aUnknown8AB230
        sta lR44
        jsl rlHDMAEngineCreateEntry
        lda #CASTLE_STEP_ARENA
        sta wGameStateStep,b
        jsl rlEnableVBlank
        sep #$20
        lda #$00
        sta bBufferINIDISP
        rep #$20
        rtl

        .databank 0

        ; 8A/E4B9

    .endsection Unsorted8AE2F8Section


    .section Unsorted84B508Section

      .al
      .xl

      rlStartArenaBattle ; 84/B508

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Unless wChapterFlags bit $10 is set, creates the arena opponent as unit $2100 (rlGetArenaOpponentCharacterID, rlCreateUnit); returns if rlGetArenaOpponentCharacterID sets carry. Then builds the rounds and starts the battle scene with wBattleType 1 and battle song $3B.

        phb
        php
        phk
        plb
        .databank $84
        lda wSelectedUnitDataRAMPointer,b
        sta wR0
        lda #$2100
        sta wR1
        lda wChapterFlags,b
        bit #$0010
        bne _B530
        jsl rlGetArenaOpponentCharacterID
        bcs _B54D
        pha
        lda #$2100
        sta wSelectedUnitDataRAMPointer,b
        pla
        jsl rlCreateUnit

        _B530
        jsl rlSetupArenaBattleStats
        sep #$20
        lda #$01
        sta $7E4EA9
        rep #$20
        jsl rlActionStructBuildBattleRounds
        lda #$003B
        sta wBattleSong
        jsl rlStartBattleScene

        _B54D
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/B550

    .endsection Unsorted84B508Section


    .section Unsorted84B550Section

      .al
      .xl

      rlGetArenaBattleResult ; 84/B550

        .al
        .xl
        .autsiz
        .databank ?

        ; A = 1 if the unit lost (DeploymentStateDefeated in its state buffer), 0 if it won (aActionStructUnit1.ObtainedArenaMoney is not 0), 2 if neither side fell.

        phb
        php
        phk
        plb
        .databank $84
        phx
        jsl rlGetSelectedUnitDeploymentOffset
        tax
        lda aDeploymentTable._StateBuffer,x
        bit #$0020
        bne _B56E
        lda aActionStructUnit1.ObtainedArenaMoney
        beq _B573
        lda #$0000
        bra _B576


        _B56E
        lda #$0001
        bra _B576


        _B573
        lda #$0002

        _B576
        plx
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 84/B57A

    .endsection Unsorted84B550Section


