; The unit command menu: which commands appear (aUnitMenuCommandChecks), what each
; does, the item submenu (use, discard), the castle staff menu and the animation setting.

    .section UnitAnimationMenuDataSection

      .al
      .xl

      aUnitAnimationMenuTilemapData ; 85/A5DA

        .structMapMenuTilemapData 9, 10, aBG3TilemapBuffer, 0, $7FC54A

      aUnitAnimationMenuData ; 85/A5E3

        .long 0, 0, aUnitAnimationMenuTilemapData
        .byte 0, 11, 9

    .endsection UnitAnimationMenuDataSection


    .section Unsorted85A5EFSection

      .al
      .xl

      procUnitAnimationMenu ; 85/A5EF

        .structProcInfo "PW", rlProcUnitAnimationMenuInit, rlProcUnitAnimationMenuWait, aProcUnitAnimationMenuCode


        .long aUnitAnimationMenuData
        .byte 1

    .endsection Unsorted85A5EFSection


    .section Unsorted85A5FBSection

      .al
      .xl

      rlProcUnitAnimationMenuInit ; 85/A5FB

        .al
        .xl
        .autsiz
        .databank ?

        ; The unit menu's アニメ: "アニメせってい" with リアル (real), マップ (map), ぜんいん (everyone); the cursor starts on the active unit's setting.

        jsl rlInitMapMenuProc
        lda #$2000
        sta aCurrentTilemapInfo,b
        phx
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        plx
        jsl rlGetSelectedUnitStates
        bit #UnitStateMapAnimation
        bne _A61F
        lda #$0000
        bra _A622


        _A61F
        lda #$0001

        _A622
        sta aProcSystem.aBody7,b,x
        phx
        lda #(`aUnitAnimationMenuTitle)<<8
        sta lR18+1
        lda #<>aUnitAnimationMenuTitle
        sta lR18
        ldx #$0101
        jsl rlDrawMapMenuTextLine
        lda #(`aUnitAnimationMenuRealText)<<8
        sta lR18+1
        lda #<>aUnitAnimationMenuRealText
        sta lR18
        ldx #$0302
        jsl rlDrawMapMenuTextLine
        lda #(`aUnitAnimationMenuMapText)<<8
        sta lR18+1
        lda #<>aUnitAnimationMenuMapText
        sta lR18
        ldx #$0502
        jsl rlDrawMapMenuTextLine
        lda #(`aUnitAnimationMenuEveryoneText)<<8
        sta lR18+1
        lda #<>aUnitAnimationMenuEveryoneText
        sta lR18
        ldx #$0702
        jsl rlDrawMapMenuTextLine
        plx
        jsl rlDrawMapMenu
        rtl

        .databank 0

        ; 85/A670

    .endsection Unsorted85A5FBSection


    .section Table85A670Section

      .al
      .xl

      aUnitAnimationMenuTitle ; 85/A670

        .enc "SJIS"
        .text "アニメせってい"
        .word $0000
        .enc "none"

      aUnitAnimationMenuRealText ; 85/A680

        .enc "SJIS"
        .text "リアル"
        .word $0000
        .enc "none"

      aUnitAnimationMenuMapText ; 85/A688

        .enc "SJIS"
        .text "マップ"
        .word $0000
        .enc "none"

      aUnitAnimationMenuEveryoneText ; 85/A690

        .enc "SJIS"
        .text "ぜんいん"
        .word $0000
        .enc "none"


    .endsection Table85A670Section


    .section Unsorted85A69ASection

      .al
      .xl

      rlProcUnitAnimationMenuWait ; 85/A69A

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 85/A69B

      rlProcUnitAnimationMenuCycle ; 85/A69B

        .al
        .xl
        .autsiz
        .databank ?

        ; A on real or map sets the active unit's animation (rlSetSelectedUnitMapAnimation); on everyone opens procAllUnitsAnimationMenu. B or done: back to the unit menu.

        lda aProcSystem.aHeaderBitfield,b,x
        bit #$0004
        beq _A6A7
        jml _A742


        _A6A7
        bit #$0001
        beq _A6B0
        jml _A750


        _A6B0
        bit #$0002
        beq _A6BF
        and #$FFFD
        sta aProcSystem.aHeaderBitfield,b,x
        jml _A750


        _A6BF
        lda wJoy1Repeated
        bit #$0800
        beq _A6D8
        lda #$0007
        jsl rlPlaySoundEffect
        lda aProcSystem.aBody7,b,x
        dec a
        bpl _A6F0
        lda #$0002
        bra _A6F0


        _A6D8
        bit #$0400
        beq _A6F5
        lda #$0007
        jsl rlPlaySoundEffect
        lda aProcSystem.aBody7,b,x
        inc a
        cmp #$0003
        bcc _A6F0
        lda #$0000

        _A6F0
        sta aProcSystem.aBody7,b,x
        bra _A750


        _A6F5
        lda wJoy1New
        bit #$0080
        beq _A736
        lda #$000A
        jsl rlPlaySoundEffect
        phx
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        plx
        lda aProcSystem.aBody7,b,x
        cmp #$0002
        beq _A71D
        jsl rlSetSelectedUnitMapAnimation
        bra _A742


        _A71D
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x
        lda #(`procAllUnitsAnimationMenu)<<8
        sta lR44+1
        lda #<>procAllUnitsAnimationMenu
        sta lR44
        jsl rlProcEngineCreateProc
        bra _A750


        _A736
        bit #$8000
        beq _A750
        lda #$0021
        jsl rlPlaySoundEffect

        _A742
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        jsl rlOpenUnitMenu
        bra _A764


        _A750
        lda #$0300
        sta wR0
        lda #$0000
        sta wR1
        phx
        lda aProcSystem.aBody7,b,x
        inc a
        jsl rlDrawListCursorAtIndex
        plx

        _A764
        rtl

        .databank 0

        ; 85/A765

    .endsection Unsorted85A69ASection


    .section Unsorted85A765Section

      .al
      .xl

      aProcUnitAnimationMenuCode ; 85/A765

        PROC_YIELD 1
        PROC_SET_ONCYCLE rlProcUnitAnimationMenuCycle
        PROC_HALT


        ; 85/A76D


      aAllUnitsAnimationMenuTilemapData ; 85/A76D

        .structMapMenuTilemapData 7, 6, aBG3TilemapBuffer, 0, $7FD54A

      aAllUnitsAnimationMenuData ; 85/A776

        .long 0, 0, aAllUnitsAnimationMenuTilemapData
        .byte 1, 18, 12

    .endsection Unsorted85A765Section


    .section Unsorted85A782Section

      .al
      .xl

      procAllUnitsAnimationMenu ; 85/A782

        .structProcInfo "PW", rlProcAllUnitsAnimationMenuInit, rlProcAllUnitsAnimationMenuSetUp, aProcDialogueBoxCode


        .long aAllUnitsAnimationMenuData
        .byte 1

    .endsection Unsorted85A782Section


    .section Unsorted85A78ESection

      .al
      .xl

      rlProcAllUnitsAnimationMenuInit ; 85/A78E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlInitMapMenuProc
        lda #$0000
        sta aProcSystem.aBody7,b,x
        rtl

        .databank 0

        ; 85/A799

      rlProcAllUnitsAnimationMenuSetUp ; 85/A799

        .al
        .xl
        .autsiz
        .databank ?

        lda #$2000
        sta aCurrentTilemapInfo,b
        phx
        lda #(`aAllUnitsAnimationMenuRealText)<<8
        sta lR18+1
        lda #<>aAllUnitsAnimationMenuRealText
        sta lR18
        ldx #$0102
        jsl rlDrawMapMenuTextLine
        lda #(`aAllUnitsAnimationMenuMapText)<<8
        sta lR18+1
        lda #<>aAllUnitsAnimationMenuMapText
        sta lR18
        ldx #$0302
        jsl rlDrawMapMenuTextLine
        plx
        jsl rlDrawMapMenu
        lda #<>rlProcAllUnitsAnimationMenuCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/A7CE

    .endsection Unsorted85A78ESection


    .section Table85A7CESection

      .al
      .xl

      aAllUnitsAnimationMenuRealText ; 85/A7CE

        .enc "SJIS"
        .text "リアル"
        .word $0000
        .enc "none"

      aAllUnitsAnimationMenuMapText ; 85/A7D6

        .enc "SJIS"
        .text "マップ"
        .word $0000
        .enc "none"


    .endsection Table85A7CESection


    .section Unsorted85A7DESection

      .al
      .xl

      rlProcAllUnitsAnimationMenuCycle ; 85/A7DE

        .al
        .xl
        .autsiz
        .databank ?

        ; A: sets every unit's animation to real or map (rlSetFactionSlotUnitsMapAnimation) and closes; B closes. Tells procUnitAnimationMenu through its bitfield.

        lda wJoy1Repeated
        bit #$0800
        beq _A7F7
        lda #$0007
        jsl rlPlaySoundEffect
        lda aProcSystem.aBody7,b,x
        dec a
        bpl _A80F
        lda #$0001
        bra _A80F


        _A7F7
        bit #$0400
        beq _A814
        lda #$0007
        jsl rlPlaySoundEffect
        lda aProcSystem.aBody7,b,x
        inc a
        cmp #$0002
        bcc _A80F
        lda #$0000

        _A80F
        sta aProcSystem.aBody7,b,x
        bra _A871


        _A814
        lda wJoy1New
        bit #$0080
        beq _A837
        lda #$000A
        jsl rlPlaySoundEffect
        lda aProcSystem.aBody7,b,x
        sta wRoutineVariable1,b
        lda #$0000
        jsl rlSetFactionSlotUnitsMapAnimation
        lda #$0004
        sta aProcSystem.wInput0,b
        bra _A846


        _A837
        bit #$8000
        beq _A871
        stz aProcSystem.wInput0,b
        lda #$0021
        jsl rlPlaySoundEffect

        _A846
        jsl rlCloseMapMenuFromProc
        jsl rlProcEngineFreeProc
        phx
        lda #(`procUnitAnimationMenu)<<8
        sta lR44+1
        lda #<>procUnitAnimationMenu
        sta lR44
        jsl rlProcEngineFindProc
        bcc _A885
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFE
        ora #$0002
        ora aProcSystem.wInput0,b
        sta aProcSystem.aHeaderBitfield,b,x
        plx
        bra _A885


        _A871
        lda #$0100
        sta wR0
        lda #$0000
        sta wR1
        phx
        lda aProcSystem.aBody7,b,x
        inc a
        jsl rlDrawListCursorAtIndex
        plx

        _A885
        rtl

        .databank 0

        ; 85/A886

      rlOpenUnitAnimationMenu ; 85/A886

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`procUnitAnimationMenu)<<8
        sta lR44+1
        lda #<>procUnitAnimationMenu
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/A895

    .endsection Unsorted85A7DESection


    .section Unsorted85DE7CSection

      .al
      .xl

      rlUnitMenuAssault ; 85/DE7C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Opens the item list on the weapons for an assault ($7E2010).

        ldx wActiveUnitDeploymentOffset,b
        lda #MAP_ACTION_BATTLE
        sta wMapActionTargetType,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlSetSelectedUnitState0400
        lda wSelectedUnitDataRAMPointer,b
        sta aProcSystem.wInput0,b
        lda #$2010
        sta aProcSystem.wInput1,b
        lda #(`procMapItemList)<<8
        sta lR44+1
        lda #<>procMapItemList
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 85/DEAB

      rlUnitMenuDance ; 85/DEAB

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Finds the adjacent units of the army (target filter 2) and starts choosing one (rlRunMapAction).

        stz wSelectedInventorySlot,b
        lda #MAP_ACTION_BATTLE
        sta wMapActionTargetType,b
        lda #$0001
        sta wR10
        sta wR12
        lda #$0001
        sta wR11
        lda #$0002
        jsl rlFindTargetsInRange
        lda wActiveUnitDeploymentOffset,b
        sta wR0
        lda #$FFFF
        sta wR1
        jsl rlRunMapAction
        rtl

        .databank 0

        ; 85/DED6

    .endsection Unsorted85DE7CSection


    .section Unsorted85DED6Section

      .al
      .xl

      rlUnitMenuStaff ; 85/DED6

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Opens the item list on the usable staves ($7E2008).

        ldx wActiveUnitDeploymentOffset,b
        lda #MAP_ACTION_BATTLE
        sta wMapActionTargetType,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta aProcSystem.wInput0,b
        lda #$2008
        sta aProcSystem.wInput1,b
        lda #(`procMapItemList)<<8
        sta lR44+1
        lda #<>procMapItemList
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlUnitMenuItems ; 85/DEFB

        .al
        .xl
        .autsiz
        .databank ?

        ; Opens the item list on the usable items ($7E2018).

        ldx wActiveUnitDeploymentOffset,b
        lda #MAP_ACTION_BATTLE
        sta wMapActionTargetType,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta aProcSystem.wInput0,b
        lda #$2018
        sta aProcSystem.wInput1,b
        lda #(`procMapItemList)<<8
        sta lR44+1
        lda #<>procMapItemList
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

    .endsection Unsorted85DED6Section


    .section Unsorted85DF20Section

      .al
      .xl

      rlUnitMenuEnter ; 85/DF20

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlEndUnitAction
        ldx wActiveUnitDeploymentOffset,b
        jsl rlEnterTargetLocation
        pha
        bcs _DF33
        jsl rlUnknown84CAA9

        _DF33
        pla
        cpy #$0001
        bne _DF3D
        jsl rlQueueUnitRelocationToCastle

        _DF3D
        plx
        rtl

        .databank 0

        ; 85/DF3F

    .endsection Unsorted85DF20Section


    .section Unsorted85DF3FSection

      .al
      .xl

      rlUnitMenuTown ; 85/DF3F

        .al
        .autsiz
        .databank ?

        ; Runs rlUnitVisitTown and fades to the castle screen.

        phx
        jsl rlEndUnitAction
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnitVisitTown

        lda #<>rsOpenCastleScreen
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rtl

        .databank 0

        ; 85/DF61


        ; 85/E070

; 57 DE 85 01 01 81 40 82 B1 82 A4 82 B0 82 AB 00 00 ; attack
; 7C DE 85 01 01 81 40 82 C6 82 C2 82 B0 82 AB 00 00 ; assault
; AB DE 85 01 01 81 40 82 A8 82 C7 82 E9 00 00 ; dance
; D6 DE 85 01 01 81 40 82 C2 82 A6 00 00 ; staff
; FB DE 85 01 01 81 40 82 E0 82 BF 82 E0 82 CC 00 00 ; belongings?
; C2 DF 85 01 01 81 40 82 CD 82 C8 82 B7 00 00 ; talk
; 30 E0 85 01 01 81 40 82 A0 82 B0 82 E9 00 00 ; give?
; 50 E0 85 01 01 81 40 82 A0 82 B0 82 E9 00 00 ; give2?
; 12 E0 85 01 01 81 40 82 BD 82 B7 82 AF 82 E9 00 00 ; help?
; 6F DF 85 01 01 81 40 82 B9 82 A2 82 A0 82 C2 00 00 ; seize
; 20 DF 85 01 01 81 40 82 CD 82 A2 82 E9 00 00 ; enter
; 3F DF 85 01 01 81 40 82 DC 82 BF 00 00 ; town?
; 61 DF 85 01 01 81 40 82 DE 82 E7 00 00 ; village
; 7D DF 85 01 01 81 40 82 B5 82 E3 82 D1 00 00 ; guard
; 8A DF 85 01 01 81 40 82 B5 82 E3 82 C2 82 B0 82 AB 00 00 ; depart
; 98 DF 85 01 01 81 40 8F E9 82 C9 82 E0 82 C7 82 E9 00 00 ; return
; 43 DE 85 01 01 81 40 82 BD 82 A2 82 AB 00 00 ; atmosphere?
; 04 E0 85 01 01 81 40 8F E9 82 C9 82 E0 82 C7 82 E9 00 00 ; return2
; B4 DF 85 01 01 81 40 82 CC 82 E9 00 00 ; mount
; A6 DF 85 01 01 81 40 82 A8 82 E8 82 E9 00 00 ; dismount
; DE DF 85 01 01 81 40 82 BB 82 A4 82 D1 00 00 ; equipment
; FD DF 85 01 01 81 40 83 41 83 6A 83 81 00 00 ; anime


; 00 00 18 00 50 57 DB E1 ED E1 AA 84 A3 83 85 01 C8 E1 85 22 C2 83 85 A9 00 00 85 89 85 87 AD CF 0E 9D B7 10 6B A9 09 00 22 AD 8F 80 BD D7 0E A8 22 80 82 85 22 AC 84 85 A9 00 00 8D 00 01 A9 00 20 8D 3A 05 A9 FF 20 8D 3C 05 BD B7 10 8D CF 0E A9 01 00 8D 43 05 8D 45 05 DA AE 72 07 BF EB 46 7E 8D 6F 05 20 4E E4 20 68 E4 A2 2E 00 DA FC 7F E2 FA 90 0F A9 E2 85 8D 41 05 BD AF E2 8D 40 05 20 32 E3 CA CA 10 E6 FA 22 BE F3 82 1A 0A EB 09 09 00 22 97 87 87 22 6E 85 85 22 DC 84 85 BD B7 10 C9 02 00 F0 0A C9 01 00 D0 05 20 DF E2 80 00 A9 3D E3 9D 57 0F 6B B6 E5 E8 E6 45 E5 39 E5 A5 E6 D7 E6 F6 E7 B3 E7 24

    .endsection Unsorted85DF3FSection


    .section Unsorted85DF61Section

      .al
      .xl

      rlUnitMenuVillage ; 85/DF61

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlEndUnitAction
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnitVisitVillage
        plx
        rtl

        .databank 0

        ; 85/DF6F

    .endsection Unsorted85DF61Section


    .section Unsorted85DF6FSection

      .al
      .xl

      rlUnitMenuSeize ; 85/DF6F

        .al
        .autsiz
        .databank ?

        phx
        jsl rlEndUnitAction
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnitSeizeCastle
        plx
        rtl

        .databank 0

        ; 85/DF7D

    .endsection Unsorted85DF6FSection


    .section Unsorted85DF7DSection

      .al
      .xl

      rlUnitMenuGuard ; 85/DF7D

        ; Nothing in the build reaches this. One of the small wrappers at $85/DF20-E070
        ; that run a bank $84 routine on the active unit (wActiveUnitDeploymentOffset).

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0000
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnitGuardCastle
        plx
        rtl

        .databank 0

        ; 85/DF8A

    .endsection Unsorted85DF7DSection


    .section Unsorted85DF8ASection

      .al
      .xl

      rlUnitMenuDepart ; 85/DF8A

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlEndUnitAction
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnitDepartCastle
        plx
        rtl

        .databank 0

        ; 85/DF98

      rlUnitMenuReturnToCastle ; 85/DF98

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlEndUnitAction
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnitReturnIntoCastle
        plx
        rtl

        .databank 0

        ; 85/DFA6

    .endsection Unsorted85DF8ASection


    .section Unsorted85DFA6Section

      .al
      .xl

      rlUnitMenuDismount ; 85/DFA6

        ; Nothing in the build reaches this. One of the small wrappers at $85/DF20-E070
        ; that run a bank $84 routine on the active unit (wActiveUnitDeploymentOffset).

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnitDismount
        jsl rlOpenUnitMenu
        plx
        rtl

        .databank 0

        ; 85/DFB4

      rlUnitMenuMount ; 85/DFB4

        ; Nothing in the build reaches this. One of the small wrappers at $85/DF20-E070
        ; that run a bank $84 routine on the active unit (wActiveUnitDeploymentOffset).

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnitMount
        jsl rlOpenUnitMenu
        plx
        rtl

        .databank 0

        ; 85/DFC2

    .endsection Unsorted85DFA6Section


    .section Unsorted85DFC2Section

      .al
      .xl

      rlUnitMenuTalk ; 85/DFC2

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #MAP_ACTION_TALK
        sta wMapActionTargetType,b
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        sec
        jsl rlFindTalkTargets
        jsl rlStartChoosingTarget
        plx
        rtl

        .databank 0

      rlUnitMenuEquip ; 85/DFDE

        .al
        .xl
        .autsiz
        .databank ?

        ; Opens the item list on the equippable weapons ($7E2020).

        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta aProcSystem.wInput0,b
        lda #$2020
        sta aProcSystem.wInput1,b
        lda #(`procMapItemList)<<8
        sta lR44+1
        lda #<>procMapItemList
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

    .endsection Unsorted85DFC2Section


    .section Unsorted85DFFDSection

      .al
      .xl

      rlUnitMenuAnimation ; 85/DFFD

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        jsl rlOpenUnitAnimationMenu
        plx
        rtl

        .databank 0

        ; 85/E004

    .endsection Unsorted85DFFDSection


    .section Unsorted85E004Section

      .al
      .xl

      rlUnitMenuReturnSkill ; 85/E004

        ; Nothing in the build reaches this. One of the small wrappers at $85/DF20-E070
        ; that run a bank $84 routine on the active unit (wActiveUnitDeploymentOffset).

        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this except its option (aUnitMenuOptionReturnSkill).

        phx
        jsl rlEndUnitAction
        ldx wActiveUnitDeploymentOffset,b
        jsl rlUnitReturnToHomeCastle
        plx
        rtl

        .databank 0

        ; 85/E012

    .endsection Unsorted85E004Section


    .section Unsorted85E012Section

      .al
      .xl

      rlUnitMenuHelp ; 85/E012

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Target filter 5, then starts choosing a target.

        stz wSelectedInventorySlot,b
        lda #MAP_ACTION_HELP
        sta wMapActionTargetType,b
        lda #$0001
        sta wR10
        sta wR11
        sta wR12
        lda #$0005
        jsl rlFindTargetsInRange
        jsl rlStartChoosingTarget
        rtl

        .databank 0

        ; 85/E030

      rlUnitMenuGiveGoldToArmy ; 85/E030

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Target filter $0A, then starts choosing a target.

        phx
        stz wSelectedInventorySlot,b
        lda #MAP_ACTION_GIVE_GOLD
        sta wMapActionTargetType,b
        lda #$0001
        sta wR10
        sta wR11
        sta wR12
        lda #$000A
        jsl rlFindTargetsInRange
        jsl rlStartChoosingTarget
        plx
        rtl

        .databank 0

        ; 85/E050

      rlUnitMenuGiveGoldToLover ; 85/E050

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Target filter $0B, then starts choosing a target.

        phx
        stz wSelectedInventorySlot,b
        lda #MAP_ACTION_GIVE_GOLD
        sta wMapActionTargetType,b
        lda #$0001
        sta wR10
        sta wR11
        sta wR12
        lda #$000B
        jsl rlFindTargetsInRange
        jsl rlStartChoosingTarget
        plx
        rtl

        .databank 0

        ; 85/E070


      aUnitMenuOptionAttack ; 85/E070

        .long rlUnitMenuAttack
        .word $0101
        .enc "SJIS"
        .text "　こうげき\n"
        .enc "none"

      aUnitMenuOptionAssault ; 85/E081

        .long rlUnitMenuAssault
        .word $0101
        .enc "SJIS"
        .text "　とつげき\n"
        .enc "none"

      aUnitMenuOptionDance ; 85/E092

        .long rlUnitMenuDance
        .word $0101
        .enc "SJIS"
        .text "　おどる\n"
        .enc "none"

      aUnitMenuOptionStaff ; 85/E0A1

        .long rlUnitMenuStaff
        .word $0101
        .enc "SJIS"
        .text "　つえ\n"
        .enc "none"

      aUnitMenuOptionItems ; 85/E0AE

        .long rlUnitMenuItems
        .word $0101
        .enc "SJIS"
        .text "　もちもの\n"
        .enc "none"

      aUnitMenuOptionTalk ; 85/E0BF

        .long rlUnitMenuTalk
        .word $0101
        .enc "SJIS"
        .text "　はなす\n"
        .enc "none"

      aUnitMenuOptionGiveGoldToArmy ; 85/E0CE

        .long rlUnitMenuGiveGoldToArmy
        .word $0101
        .enc "SJIS"
        .text "　あげる\n"
        .enc "none"

      aUnitMenuOptionGiveGoldToLover ; 85/E0DD

        .long rlUnitMenuGiveGoldToLover
        .word $0101
        .enc "SJIS"
        .text "　あげる\n"
        .enc "none"

      aUnitMenuOptionHelp ; 85/E0EC

        .long rlUnitMenuHelp
        .word $0101
        .enc "SJIS"
        .text "　たすける\n"
        .enc "none"

      aUnitMenuOptionSeize ; 85/E0FD

        .long rlUnitMenuSeize
        .word $0101
        .enc "SJIS"
        .text "　せいあつ\n"
        .enc "none"

      aUnitMenuOptionEnter ; 85/E10E

        .long rlUnitMenuEnter
        .word $0101
        .enc "SJIS"
        .text "　はいる\n"
        .enc "none"

      aUnitMenuOptionTown ; 85/E11D

        .long rlUnitMenuTown
        .word $0101
        .enc "SJIS"
        .text "　まち\n"
        .enc "none"

      aUnitMenuOptionVillage ; 85/E12A

        .long rlUnitMenuVillage
        .word $0101
        .enc "SJIS"
        .text "　むら\n"
        .enc "none"

      aUnitMenuOptionGuard ; 85/E137

        .long rlUnitMenuGuard
        .word $0101
        .enc "SJIS"
        .text "　しゅび\n"
        .enc "none"

      aUnitMenuOptionDepart ; 85/E146

        .long rlUnitMenuDepart
        .word $0101
        .enc "SJIS"
        .text "　しゅつげき\n"
        .enc "none"

      aUnitMenuOptionReturnToCastle ; 85/E159

        .long rlUnitMenuReturnToCastle
        .word $0101
        .enc "SJIS"
        .text "　城にもどる\n"
        .enc "none"

      aUnitMenuOptionWait ; 85/E16C

        .long rlUnitMenuWait
        .word $0101
        .enc "SJIS"
        .text "　たいき\n"
        .enc "none"

      aUnitMenuOptionReturnSkill ; 85/E17B

        .long rlUnitMenuReturnSkill
        .word $0101
        .enc "SJIS"
        .text "　城にもどる\n"
        .enc "none"

      aUnitMenuOptionMount ; 85/E18E

        .long rlUnitMenuMount
        .word $0101
        .enc "SJIS"
        .text "　のる\n"
        .enc "none"

      aUnitMenuOptionDismount ; 85/E19B

        .long rlUnitMenuDismount
        .word $0101
        .enc "SJIS"
        .text "　おりる\n"
        .enc "none"

      aUnitMenuOptionEquip ; 85/E1AA

        .long rlUnitMenuEquip
        .word $0101
        .enc "SJIS"
        .text "　そうび\n"
        .enc "none"

      aUnitMenuOptionAnimation ; 85/E1B9

        .long rlUnitMenuAnimation
        .word $0101
        .enc "SJIS"
        .text "　アニメ\n"
        .enc "none"

      aUnitMenuOptionListTemplate ; 85/E1C8

        .word 0, 24

    .endsection Unsorted85E012Section


    .section ProcScript85E1CCSection

      .al
      .xl

      procUnitMenu ; 85/E1CC

        .structProcInfo "PW", rlProcUnitMenuInit, rlProcUnitMenuSetUp, aProcListMenuCode


        .long aUnitMenuData
        .byte 1
        .long aUnitMenuOptionListTemplate

    .endsection ProcScript85E1CCSection


    .section Unsorted85E1DBSection

      .al
      .xl

      rlProcUnitMenuInit ; 85/E1DB

        .al
        .xl
        .autsiz
        .databank ?

        ; wInput0 = the mode (aBody7): 0 after moving, 1 and 2 when reopened (rlOpenUnitMenu).

        jsl rlListMenuProcInit
        lda #$0000
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody7,b,x
        rtl

        .databank 0

        ; 85/E1ED

      rlProcUnitMenuSetUp ; 85/E1ED

        .al
        .xl
        .autsiz
        .databank ?

        ; Builds the menu: for each of the 24 commands, from the last to the first, adds its option if its check (aUnitMenuCommandChecks) returns carry set; sizes the menu to fit.

        lda #$0009
        jsl rlPlaySoundEffect
        lda aProcSystem.aHeaderTypeOffset,b,x
        tay
        jsl rlLoadMapMenuDataFromProc
        jsl rlListMenuProcPushOptions
        lda #$0000
        sta aBGPaletteBuffer,b
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$20FF
        sta wMapMenuClearTile,b
        lda aProcSystem.aBody7,b,x
        sta aProcSystem.wInput0,b
        lda #$0001
        sta wMenuOptionX,b
        sta wMenuOptionY,b
        phx
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsr rsUnitMenuBuildItemLists
        jsr rsUnitMenuGetLocation
        ldx #$002E

        _E235
        phx
        jsr (aUnitMenuCommandChecks,x)
        plx
        bcc _E24B
        lda #aUnitMenuCommandOptions >> 8
        sta lMenuOptionPointer+1,b
        lda <>aUnitMenuCommandOptions,b,x
        sta lMenuOptionPointer,b
        jsr rsUnitMenuAddOption

        _E24B
        dec x
        dec x
        bpl _E235
        plx
        jsl rlGetCurrentMenuOptionCount
        inc a
        asl a
        xba
        ora #$0009
        jsl rlSetMapMenuTilemapArea
        jsl rlDrawMenuOptions
        jsl rlKeepUnitMenuAwayFromCursor
        lda aProcSystem.aBody7,b,x
        cmp #UNIT_MENU_MODE_2
        beq _E278
        cmp #$0001
        bne _E278
        jsr rsUnitMenuMoveOptionListDown
        bra _E278


        _E278
        lda #<>rlProcUnitMenuCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/E27F

    .endsection Unsorted85E1DBSection


    .section Table85E27FSection

      .al
      .xl

      aUnitMenuCommandChecks ; 85/E27F

        ; Jump table of rlProcUnitMenuSetUp.
        .word <>rsUnitMenuCheckReturnToCastle
        .word <>rsUnitMenuCheckReturnSkill
        .word <>rsUnitMenuCheckPass
        .word <>rsUnitMenuCheckEquip
        .word <>rsUnitMenuCheckDismount
        .word <>rsUnitMenuCheckMount
        .word <>rsUnitMenuCheckGiveGoldToLover
        .word <>rsUnitMenuCheckGiveGoldToArmy
        .word <>rsUnitMenuCheckItems
        .word <>rsUnitMenuCheckOffensiveStaff
        .word <>rsUnitMenuCheckWait
        .word <>rsUnitMenuCheckTalk
        .word <>rsUnitMenuCheckDepart
        .word <>rsUnitMenuCheckGuard
        .word <>rsUnitMenuCheckVillage
        .word <>rsUnitMenuCheckTown
        .word <>rsUnitMenuCheckSeize
        .word <>rsUnitMenuCheckEnter
        .word <>rsUnitMenuCheckDance
        .word <>rsUnitMenuCheckSupportStaff
        .word <>rsUnitMenuCheckAttack
        .word <>rsUnitMenuCheckAssault
        .word <>rsUnitMenuCheckHelp
        .word <>rsUnitMenuCheckTalkHere


      aUnitMenuCommandOptions ; 85/E2AF

        .word <>aUnitMenuOptionReturnToCastle
        .word <>aUnitMenuOptionReturnSkill
        .word <>aUnitMenuOptionAnimation
        .word <>aUnitMenuOptionEquip
        .word <>aUnitMenuOptionDismount
        .word <>aUnitMenuOptionMount
        .word <>aUnitMenuOptionGiveGoldToLover
        .word <>aUnitMenuOptionGiveGoldToArmy
        .word <>aUnitMenuOptionItems
        .word <>aUnitMenuOptionStaff
        .word <>aUnitMenuOptionWait
        .word <>aUnitMenuOptionTalk
        .word <>aUnitMenuOptionDepart
        .word <>aUnitMenuOptionGuard
        .word <>aUnitMenuOptionVillage
        .word <>aUnitMenuOptionTown
        .word <>aUnitMenuOptionSeize
        .word <>aUnitMenuOptionEnter
        .word <>aUnitMenuOptionDance
        .word <>aUnitMenuOptionStaff
        .word <>aUnitMenuOptionAttack
        .word <>aUnitMenuOptionAssault
        .word <>aUnitMenuOptionHelp
        .word <>aUnitMenuOptionTalk

    .endsection Table85E27FSection


    .section Unsorted85E2DFSection

      .al
      .xl

      rsUnitMenuMoveOptionListDown ; 85/E2DF

        .al
        .xl
        .autsiz
        .databank ?

        ; Swaps the top option list with the one below it, so the unit menu waits under the previous menu (mode 1).

        phb
        php
        phk
        plb
        .databank $85
        phx
        phy
        ldy lMenuOptionListTop,b
        sep #$20
        lda lMenuOptionListTop+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda $0002,b,y
        ora $0003,b,y
        beq _E32D
        phb
        lda $0002,b,y
        tax
        sep #$20
        lda $0004,b,y
        pha
        rep #$20
        plb
        .databank ?
        lda @l lMenuOptionListTop
        sta $0002,b,x
        lda @l lMenuOptionListTop+1
        sta $0003,b,x
        plb
        .databank ?
        lda $0002,b,y
        sta @l lMenuOptionListTop
        lda $0003,b,y
        sta @l lMenuOptionListTop+1
        lda #$0000
        sta $0002,b,y
        sta $0003,b,y

        _E32D
        ply
        plx
        plp
        plb
        .databank ?
        rts

        .databank 0

        ; 85/E332

      rsUnitMenuAddOption ; 85/E332

        .al
        .xl
        .autsiz
        .databank ?

        ; Adds the option at lMenuOptionPointer and moves two rows down.

        jsl rlAddMenuOption
        inc wMenuOptionY,b
        inc wMenuOptionY,b
        rts

        .databank 0

        ; 85/E33D

    .endsection Unsorted85E2DFSection


    .section Unsorted85E33DSection

      .al
      .xl

      rlProcUnitMenuCycle ; 85/E33D

        .al
        .autsiz
        .databank ?

        ; B: in mode 1 only puts the cursor back on the first option; otherwise closes the menu (mode 2 clears bit 4 of wMapStateFlags) and undoes the move (rlUndoUnitMove).

        jsl rlCheckListMenuIdle
        bne _End

          lda wJoy1New
          bit #JOY_A
          beq +
          bra _End

          +
          lda wJoy1New
          bit #JOY_B
          beq _End

            lda aProcSystem.aBody7,b,x
            cmp #UNIT_MENU_MODE_1
            beq _E37D

            cmp #2
            bne +

              lda wMapStateFlags,b
              and #$FFEF
              sta wMapStateFlags,b
              bit #$0008
              beq +

                jsl rlHideMapWindows

            +
            phx
            jsl rlUndoUnitMove
            plx

        _End
        jsl rlListMenuProcHandleInput
        
        -
        rtl

        _E37D
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda #1
        sta aProcSystem.aBody6,b,x
        jsr rsListMenuDrawCursor
        bra -

        .databank 0

        ; 85/E38C

    .endsection Unsorted85E33DSection


    .section Unsorted85E38CSection

      .al
      .xl

      rsUnitMenuCheckEnter ; 85/E38C

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        ; At a castle that is neither the enemy's (relation 2) nor relation 3.

        lda wEventLocationEntry,b
        bne _E395
        jml rsUnitMenuCheckFail


        _E395
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeCastle
        beq _E3A2
        jml rsUnitMenuCheckFail


        _E3A2
        jsl rlGetLocationFactionSlotOwner
        tax
        lda wActiveFactionSlot,b
        jsl rlGetFactionRelation
        cmp #AllegianceEnemy
        bne _E3B7
        jml rsUnitMenuCheckFail


        _E3B7
        cmp #$0003
        bne _E3C0
        jml rsUnitMenuCheckFail


        _E3C0
        jml rsUnitMenuCheckPass

      rsUnitMenuCheckTown ; 85/E3C4

        ldx wActiveUnitDeploymentOffset,b
        lda wEventLocationEntry,b
        bne _E3D0
        jml rsUnitMenuCheckFail


        _E3D0
        jsl rlGetEventLocationEntryType
        cmp #$0001
        beq _E3DD
        jml rsUnitMenuCheckFail


        _E3DD
        jml rsUnitMenuCheckPass

      rsUnitMenuCheckVillage ; 85/E3E1

        ldx wActiveUnitDeploymentOffset,b
        lda wEventLocationEntry,b
        bne _E3ED
        jml rsUnitMenuCheckFail


        _E3ED
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeVillage
        beq _E3FA
        jml rsUnitMenuCheckFail


        _E3FA
        jsl rlCheckLocationDestroyed
        bcc _E404
        jml rsUnitMenuCheckFail


        _E404
        jsl rlCheckIfVillageClosed
        bcc _E40E
        jml rsUnitMenuCheckFail


        _E40E
        jml rsUnitMenuCheckPass

      rsUnitMenuCheckSeize ; 85/E412

        lda wEventLocationEntry,b
        bne _E41B
        jml rsUnitMenuCheckFail


        _E41B
        jsl rlGetLocationFactionSlotOwner
        tax
        lda wActiveFactionSlot,b
        jsl rlGetFactionRelation
        cmp #AllegianceEnemy
        beq _E430
        jml rsUnitMenuCheckFail


        _E430
        jsl rlCheckLocationDestroyed
        bcs _E44C
        jsl rlCheckIfCastleGuarded
        bcs _E44C
        jsl rlGetSelectedUnitClassID
        cmp #$0006
        beq _E44A
        cmp #$002C
        bne _E44C

        _E44A
        sec
        rts


        _E44C
        clc
        rts

        .databank 0

        ; 85/E44E

    .endsection Unsorted85E38CSection


    .section Unsorted85E44ESection

      .al
      .xl

      rsUnitMenuBuildItemLists ; 85/E44E

        .al
        .xl
        .autsiz
        .databank ?

        ; X = deployment offset: builds the lists of usable inventory slots at the unit's tile ($7E2000-$7E2028, rlBuildUnitMenuSlotLists).

        lda aDeploymentTable._XTilePosition,x
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        sta wR11
        lda aDeploymentTable,x
        and #$0003
        sta wR12
        jsl rlBuildUnitMenuSlotLists
        rts

        .databank 0

        ; 85/E468

      rsUnitMenuGetLocation ; 85/E468

        .al
        .xl
        .autsiz
        .databank ?

        ; X = deployment offset: wEventLocationEntry and wTargetEventLocationEntry = the location at the unit's tile.

        lda aDeploymentTable._XTilePosition,x
        sta wR0
        lda aDeploymentTable._YTilePosition,x
        sta wR1
        jsl rlCheckIfCoordsNotEventLocationTile
        lda wEventLocationEntry,b
        sta wTargetEventLocationEntry,b
        rts

        .databank 0

        ; 85/E47F

    .endsection Unsorted85E44ESection


    .section Unsorted85E47FSection

      .al
      .xl

      rsUnitMenuCheckAttack ; 85/E47F

        ; Runs on into built code at the end.
        .al
        .xl
        .autsiz
        .databank ?

        ; Not mode 2 or $0008, and a weapon with a target in range ($7E2000).

        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody7,b,x
        cmp #UNIT_MENU_MODE_2
        bne _E48E
        jml rsUnitMenuCheckFail


        _E48E
        lda wMapStateFlags,b
        bit #$0008
        beq _E49A
        jml rsUnitMenuCheckFail


        _E49A
        lda aUnitMenuWeaponSlots
        and #$00FF
        bne _E4A7
        jml rsUnitMenuCheckFail


        _E4A7
        jml rsUnitMenuCheckPass


      rsUnitMenuHasSupportStaff ; 85/E4AB
        phx
        lda aUnitMenuStaffSlots
        and #$00FF
        dec a
        tax

        _E4B5
        lda aUnitMenuStaffSlots+1,x
        and #$00FF
        jsl rlGetItemROMDataByInventorySlot
        jsl rlGetItemStaffEffect
        cmp #$000C
        bcc _E4CF
        dec x
        bpl _E4B5
        plx
        clc
        rts


        _E4CF
        plx
        sec
        rts

      rsUnitMenuCheckSupportStaff ; 85/E4D2

        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody7,b,x
        cmp #UNIT_MENU_MODE_2
        bne _E4E1
        jml rsUnitMenuCheckFail


        _E4E1
        lda wMapStateFlags,b
        bit #$0008
        bne rsUnitMenuCheckFail
        lda aUnitMenuStaffSlots
        and #$00FF
        beq rsUnitMenuCheckFail
        jsr rsUnitMenuHasSupportStaff
        bcc rsUnitMenuCheckFail
        jml rsUnitMenuCheckPass

      rsUnitMenuCheckOffensiveStaff ; 85/E4FB

        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody7,b,x
        cmp #UNIT_MENU_MODE_2
        bne _E50A
        jml rsUnitMenuCheckFail


        _E50A
        lda wMapStateFlags,b
        bit #$0008
        bne rsUnitMenuCheckFail
        lda aUnitMenuStaffSlots
        and #$00FF
        beq rsUnitMenuCheckFail
        jsr rsUnitMenuHasSupportStaff
        bcs rsUnitMenuCheckFail
        jml rsUnitMenuCheckPass

      rsUnitMenuCheckItems ; 85/E524

        lda wMapStateFlags,b
        bit #$0008
        bne rsUnitMenuCheckFail
        lda aUnitMenuItemSlots
        and #$00FF
        beq rsUnitMenuCheckFail
        jml rsUnitMenuCheckPass

      rsUnitMenuCheckEquip ; 85/E539

        lda aUnitMenuEquipSlots
        and #$00FF
        cmp #$0002
        bcc rsUnitMenuCheckFail

        .databank 0

        ; 85/E545

    .endsection Unsorted85E47FSection


    .section Unsorted85E545Section

      .al
      .xl

      rsUnitMenuCheckPass ; 85/E545

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry set: show the command.

        sec
        rts

        .databank 0

        ; 85/E547

      rsUnitMenuCheckFail ; 85/E547

        .al
        .xl
        .autsiz
        .databank ?

        ; Carry clear: leave the command out.

        clc
        rts

        .databank 0

        ; 85/E549

    .endsection Unsorted85E545Section


    .section Unsorted85E549Section

      .al
      .xl

      rsUnitMenuCheckTalk ; 85/E549

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Not after acting ($0008) unless in canto; rlCheckCanTalk clear; someone to talk to in range 1 (target filter 3).

        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        bne _E55A
        lda wMapStateFlags,b
        bit #$0008
        bne rsUnitMenuCheckFail

        _E55A
        clc
        jsl rlCheckCanTalk
        bcs rsUnitMenuCheckFail
        lda #$0001
        sta wR10
        sta wR11
        stz wR12
        lda #$0003
        jsl rlFindTargetsInRange
        ora #$0000
        bne _E57A
        jml rsUnitMenuCheckFail


        _E57A
        jml rsUnitMenuCheckPass

        .databank 0

        ; 85/E57E

    .endsection Unsorted85E549Section


    .section Unsorted85E57ESection

      .al
      .xl

      rsUnitMenuCheckGuard ; 85/E57E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; At a castle owned by the unit's army or an ally that nobody guards, and wMapActionMode is not 2.

        lda wEventLocationEntry,b
        beq rsUnitMenuCheckFail
        lda wMapActionMode,b
        and #$00FF
        cmp #$0002
        beq rsUnitMenuCheckFail
        jsl rlCheckIfCastleGuarded
        bcs rsUnitMenuCheckFail
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeCastle
        bne rsUnitMenuCheckFail
        ldx wActiveFactionSlot,b
        jsl rlGetLocationFactionSlotOwner
        jsl rlGetFactionRelation
        cmp #AllegianceOwn
        beq rsUnitMenuCheckPass
        cmp #AllegianceAllied
        beq rsUnitMenuCheckPass
        jml rsUnitMenuCheckFail

        .databank 0

        ; 85/E5B6

      rsUnitMenuCheckReturnToCastle ; 85/E5B6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; The unit guards its home castle (its faction's location) and has no canto movement left.

        jsl rlGetSelectedUnitHomeCastle
        sta wR0
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionSlotLocationID
        cmp wR0
        beq _E5CC
        jml rsUnitMenuCheckFail


        _E5CC
        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        bne _E5D9
        jml rsUnitMenuCheckFail


        _E5D9
        bit #$0800
        beq _E5E2
        jml rsUnitMenuCheckFail


        _E5E2
        jml rsUnitMenuCheckPass

        .databank 0

        ; 85/E5E6

      rsUnitMenuCheckDepart ; 85/E5E6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; The unit guards a castle, has no canto movement left, and rlGetUnitByCoordinates returns carry set for the tile two below it.

        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        bne _E5F3
        jml rsUnitMenuCheckFail


        _E5F3
        bit #$0800
        beq _E5FC
        jml rsUnitMenuCheckFail


        _E5FC
        lda wSelectedUnitDataRAMPointer,b
        pha
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._XTilePosition,x
        sta wR0
        lda aDeploymentTable._YTilePosition,x
        inc a
        inc a
        sta wR1
        jsl rlGetUnitByCoordinates
        pla
        sta wSelectedUnitDataRAMPointer,b
        bcs _E61F
        jml rsUnitMenuCheckFail


        _E61F
        jml rsUnitMenuCheckPass

        .databank 0

        ; 85/E623

      rsUnitMenuCheckWait ; 85/E623

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Shown unless the unit stands on its own faction's castle location (terrain 9 always shows it).

        lda wActiveUnitDeploymentOffset,b
        jsl rlGetTerrainTypeByDeploymentOffset
        cmp #$0009
        bne _E633
        jml rsUnitMenuCheckPass


        _E633
        lda wEventLocationEntry,b
        bne _E63C
        jml rsUnitMenuCheckPass


        _E63C
        jsl rlGetEventLocationEntryID
        sta wR0
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionSlotLocationID
        cmp wR0
        beq _E652
        jml rsUnitMenuCheckPass


        _E652
        jml rsUnitMenuCheckFail

        .databank 0

        ; 85/E656

      rsUnitMenuCheckAssault ; 85/E656

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Guarding a castle, or at an enemy castle that is guarded; and a weapon with a target ($7E2010, target filter 4).

        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        bne _E694
        lda wEventLocationEntry,b
        bne _E668
        jml rsUnitMenuCheckFail


        _E668
        jsl rlCheckIfCastleGuarded
        bcs _E672
        jml rsUnitMenuCheckFail


        _E672
        jsl rlGetEventLocationEntryType
        cmp #LocationTypeCastle
        beq _E67F
        jml rsUnitMenuCheckFail


        _E67F
        jsl rlGetLocationFactionSlotOwner
        tax
        lda wActiveFactionSlot,b
        jsl rlGetFactionRelation
        cmp #AllegianceEnemy
        beq _E694
        jml rsUnitMenuCheckFail


        _E694
        lda aUnitMenuAssaultSlots
        and #$00FF
        bne _E6A1
        jml rsUnitMenuCheckFail


        _E6A1
        jml rsUnitMenuCheckPass

        .databank 0

        ; 85/E6A5

      rsUnitMenuCheckDismount ; 85/E6A5

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Personal skill bit 3 of byte 1, the class has ClassSkillDismount, and the unit is mounted.

        jsl rlGetSelectedUnitSkills
        lda lRoutineVariable,b
        bit #$0008
        bne _E6B5
        jml rsUnitMenuCheckFail


        _E6B5
        jsl rlGetSelectedUnitClassDataPointer
        jsl rlGetClassSkills
        bit #$0400
        bne _E6C6
        jml rsUnitMenuCheckFail


        _E6C6
        jsl rlGetSelectedUnitStates
        bit #UnitStateDismounted
        beq _E6D3
        jml rsUnitMenuCheckFail


        _E6D3
        jml rsUnitMenuCheckPass

        .databank 0

        ; 85/E6D7

    .endsection Unsorted85E57ESection


    .section Unsorted85E6D7Section

      .al
      .xl

      rsUnitMenuCheckMount ; 85/E6D7

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; The unit is dismounted (UnitStateDismounted).

        jsl rlGetSelectedUnitStates
        bit #UnitStateDismounted
        bne _E6E4
        jml rsUnitMenuCheckFail


        _E6E4
        jml rsUnitMenuCheckPass

        .databank 0

        ; 85/E6E8

    .endsection Unsorted85E6D7Section


    .section Unsorted85E6E8Section

      .al
      .xl

      rsUnitMenuCheckReturnSkill ; 85/E6E8

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Not mode 2 or $0008, not at its own castle, not guarding a castle, and the unit or an item has Return.

        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody7,b,x
        cmp #UNIT_MENU_MODE_2
        bne _E6F7
        jml rsUnitMenuCheckFail


        _E6F7
        jsl rlGetEventLocationEntryID
        sta wR0
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionSlotLocationID
        cmp wR0
        bne _E70D
        jml rsUnitMenuCheckFail


        _E70D
        lda wMapStateFlags,b
        bit #$0008
        beq _E719
        jml rsUnitMenuCheckFail


        _E719
        jsl rlGetSelectedUnitStates
        bit #UnitStateGuardingCastle
        beq _E726
        jml rsUnitMenuCheckFail


        _E726
        lda #SkillIDReturn
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcc _E733
        jml rsUnitMenuCheckPass


        _E733
        lda #SkillIDReturn
        jsl rlCheckIfInventoryItemsHaveSpecifiedSkill
        bcc _E740
        jml rsUnitMenuCheckPass


        _E740
        jml rsUnitMenuCheckFail

        .databank 0

        ; 85/E744

      rsUnitMenuCheckDance ; 85/E744

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Not after acting, not in canto, the unit has Dance, and a unit that has moved is adjacent (target filter 7).

        lda wMapStateFlags,b
        bit #$0008
        beq _E750
        jml rsUnitMenuCheckFail


        _E750
        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        beq _E75D
        jml rsUnitMenuCheckFail


        _E75D
        lda #SkillIDDance
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _E76A
        jml rsUnitMenuCheckFail


        _E76A
        lda #$0001
        sta wR10
        lda #$0001
        sta wR11
        stz wR12
        lda #$0007
        jsl rlFindTargetsInRange
        ora #$0000
        bne _E786
        jml rsUnitMenuCheckFail


        _E786
        jml rsUnitMenuCheckPass

        .databank 0

        ; 85/E78A

    .endsection Unsorted85E6E8Section


    .section Unsorted85E78ASection

      .al
      .xl

      rsUnitMenuCheckHelp ; 85/E78A

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Not after acting, and a civilian or child adjacent (target filter 5).

        lda wMapStateFlags,b
        bit #$0008
        beq _E796
        jml rsUnitMenuCheckFail


        _E796
        lda #$0001
        sta wR10
        sta wR11
        stz wR12
        lda #$0005
        jsl rlFindTargetsInRange
        ora #$0000
        bne _E7AF
        jml rsUnitMenuCheckFail


        _E7AF
        jml rsUnitMenuCheckPass

        .databank 0

        ; 85/E7B3

    .endsection Unsorted85E78ASection


    .section Unsorted85E7B3Section

      .al
      .xl

      rsUnitMenuCheckGiveGoldToArmy ; 85/E7B3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; A unit with Steal and gold, next to an army member under the gold cap (target filter $0A).

        lda wMapStateFlags,b
        bit #$0008
        beq _E7BF
        jml rsUnitMenuCheckFail


        _E7BF
        lda #SkillIDSteal
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcs _E7CC
        jml rsUnitMenuCheckFail


        _E7CC
        jsl rlGetSelectedUnitMoney
        ora #$0000
        bne _E7D9
        jml rsUnitMenuCheckFail


        _E7D9
        lda #$0001
        sta wR10
        sta wR11
        stz wR12
        lda #$000A
        jsl rlFindTargetsInRange
        ora #$0000
        bne _E7F2
        jml rsUnitMenuCheckFail


        _E7F2
        jml rsUnitMenuCheckPass

        .databank 0

        ; 85/E7F6

      rsUnitMenuCheckGiveGoldToLover ; 85/E7F6

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; A unit without Steal and with gold, next to its lover under the gold cap (target filter $0B).

        lda wMapStateFlags,b
        bit #$0008
        beq _E802
        jml rsUnitMenuCheckFail


        _E802
        lda #SkillIDSteal
        jsl rlCheckIfUnitHasSpecifiedPersonalOrClassSkill
        bcc _E80F
        jml rsUnitMenuCheckFail


        _E80F
        jsl rlGetSelectedUnitMoney
        ora #$0000
        bne _E81C
        jml rsUnitMenuCheckFail


        _E81C
        lda #$0001
        sta wR10
        sta wR11
        stz wR12
        lda #$000B
        jsl rlFindTargetsInRange
        ora #$0000
        bne _E835
        jml rsUnitMenuCheckFail


        _E835
        jml rsUnitMenuCheckPass

        .databank 0

        ; 85/E839

    .endsection Unsorted85E7B3Section


    .section Unsorted85E839Section

      .al
      .xl

      rsUnitMenuCheckTalkHere ; 85/E839

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Not after acting ($0008) unless in canto; rlCheckCanTalk set.

        jsl rlGetSelectedUnitStates
        bit #UnitStateCanto
        bne _E84E
        lda wMapStateFlags,b
        bit #$0008
        beq _E84E
        jml rsUnitMenuCheckFail


        _E84E
        clc
        jsl rlCheckCanTalk
        bcs _E859
        jml rsUnitMenuCheckFail


        _E859
        jml rsUnitMenuCheckPass

        .databank 0

        ; 85/E85D

    .endsection Unsorted85E839Section


    .section Unsorted85E85DSection

      .al
      .xl

      rlOpenUnitMenu ; 85/E85D

        .al
        .xl
        .autsiz
        .databank ?

        ; Opens procUnitMenu with the mode in wMapStateFlags: 0, 1 (bit 3 set) or 2 (bit 4 set). Not while bit 5 of wChapterFlags is set.

        phb
        php
        phk
        plb
        .databank $85
        lda wChapterFlags,b
        bit #$0020
        bne _E894
        lda wMapStateFlags,b
        bit #$0010
        bne _E87B
        bit #$0008
        bne _E880
        lda #$0000
        bra _E883


        _E87B
        lda #$0002
        bra _E883


        _E880
        lda #$0001

        _E883
        sta aProcSystem.wInput0,b
        lda #(`procUnitMenu)<<8
        sta lR44+1
        lda #<>procUnitMenu
        sta lR44
        jsl rlProcEngineCreateProc

        _E894
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/E897

    .endsection Unsorted85E85DSection


    .section Unsorted85E897Section

      .al
      .xl

      rlClearUnitMenuModeFlags ; 85/E897

        .al
        .autsiz
        .databank ?

        ; Clears bits 3 and 4 of wMapStateFlags and closes the map windows (rlShowMapWindows).

        phb
        php
        phk
        plb
        lda #$0018
        trb wMapStateFlags,b
        jsl rlShowMapWindows
        plp
        plb
        rtl

        .databank 0

        ; 85/E8A8

    .endsection Unsorted85E897Section


    .section Unsorted85E8A8Section

      .al
      .xl

      rlOpenUnitMenuMode1 ; 85/E8A8

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bit 3 of wMapStateFlags and opens procUnitMenu in mode 1; aQueuedUnitMenuOpeners runs it after rlRequestUnitMenuMode1 (a player unit ending its action at its home castle).

        phb
        php
        phk
        plb
        .databank $85
        lda #$0008
        tsb wMapStateFlags,b
        lda #$0001
        sta aProcSystem.wInput0,b
        lda #(`procUnitMenu)<<8
        sta lR44+1
        lda #<>procUnitMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/E8C9

      rlOpenUnitMenuMode2 ; 85/E8C9

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bit 4 of wMapStateFlags and opens procUnitMenu in mode 2; aQueuedUnitMenuOpeners runs it after rlRequestUnitMenuMode2 (from the guard command's handler).

        phb
        php
        phk
        plb
        .databank $85
        lda #$0010
        tsb wMapStateFlags,b
        lda #$0002
        sta aProcSystem.wInput0,b
        lda #(`procUnitMenu)<<8
        sta lR44+1
        lda #<>procUnitMenu
        sta lR44
        jsl rlProcEngineCreateProc
        plp
        plb
        .databank $85
        rtl

        .databank 0

        ; 85/E8EA

    .endsection Unsorted85E8A8Section


    .section Unsorted85E8EASection

      .al
      .xl

      rlUseItemFromMap ; 85/E8EA

        .al
        .xl
        .autsiz
        .databank ?

        ; The active unit uses the item in wSelectedInventorySlot (rlStartInventoryStaffTargetSelection).

        phx
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlStartInventoryStaffTargetSelection
        plx
        rtl

        .databank 0

        ; 85/E8FB

    .endsection Unsorted85E8EASection


    .section Unsorted85E8FBSection

      .al
      .xl

      rlDiscardItemFromMap ; 85/E8FB

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Nothing in the build reaches this. The active unit discards the item in wSelectedInventorySlot.

        phx
        ldx wActiveUnitDeploymentOffset,b
        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        jsl rlDiscardSelectedInventoryItem
        jsl rlEndUnitAction
        plx
        rtl

        .databank 0

        ; 85/E910

      aItemUseMenuOptionUse ; 85/E910

        .long rlUseItemFromMap
        .word $0101
        .enc "SJIS"
        .text "　つかう\n"
        .enc "none"

      aItemUseMenuOptionDiscard ; 85/E91F

        .long rlDiscardItemFromMap
        .word $0101
        .enc "SJIS"
        .text "　すてる\n"
        .enc "none"

      aItemUseMenuOptionList ; 85/E92E

        .word 0
        .byte 2, 2
        .byte 1, 1
        .long aItemUseMenuOptionUse
        .byte 1, 3
        .long aItemUseMenuOptionDiscard

      aItemUseMenuTilemapData ; 85/E93C

        .structMapMenuTilemapData 9, 6, aBG3TilemapBuffer, 0, $7FCD4A

      aItemUseMenuData ; 85/E945

        .long 0, 0, aItemUseMenuTilemapData
        .byte 2, 12, 10

    .endsection Unsorted85E8FBSection


    .section Unsorted85E951Section

      .al
      .xl

      procItemUseMenu ; 85/E951

        .structProcInfo "PW", rlProcUnitMenuInit, rlProcItemUseMenuSetUp, aProcListMenuCode
        .long aItemUseMenuData
        .byte 1
        .long aItemUseMenuOptionList

    .endsection Unsorted85E951Section


    .section Unsorted85E960Section

      .al
      .xl

      rlProcItemUseMenuSetUp ; 85/E960

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlListMenuProcSetUp
        lda #<>rlMainMapMenuProcCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/E96B

      rlCastleStaffMenuInside ; 85/E96B

        .al
        .xl
        .autsiz
        .databank ?

        ; Opens the item list on the staves for units in the castle ($7E2028).

        lda wSelectedUnitDataRAMPointer,b
        sta aProcSystem.wInput0,b
        lda #$2028
        sta aProcSystem.wInput1,b
        lda #(`procMapItemList)<<8
        sta lR44+1
        lda #<>procMapItemList
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      rlCastleStaffMenuOutside ; 85/E986

        .al
        .xl
        .autsiz
        .databank ?

        ; Opens the item list on the staves for units on the map ($7E2008).

        lda wSelectedUnitDataRAMPointer,b
        sta aProcSystem.wInput0,b
        lda #$2008
        sta aProcSystem.wInput1,b
        lda #(`procMapItemList)<<8
        sta lR44+1
        lda #<>procMapItemList
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

      aCastleStaffMenuOptionInside ; 85/E9A1

        .long rlCastleStaffMenuInside
        .word $0101
        .enc "SJIS"
        .text "　じょうない\n"
        .enc "none"

      aCastleStaffMenuOptionOutside ; 85/E9B4

        .long rlCastleStaffMenuOutside
        .word $0101
        .enc "SJIS"
        .text "　じょうがい\n"
        .enc "none"

        ; 85/E96B

    .endsection Unsorted85E960Section


    .section Unsorted85E9C7Section

      .al
      .xl

      procCastleStaffMenu ; 85/E9C7

        .structProcInfo "PW", rlProcUnitMenuInit, rlProcCastleStaffMenuSetUp, aProcListMenuCode
        .long aUnitMenuData
        .byte 1
        .long aUnitMenuOptionListTemplate

    .endsection Unsorted85E9C7Section


    .section Unsorted85E9D6Section

      .al
      .xl

      rlProcCastleStaffMenuSetUp ; 85/E9D6

        .al
        .xl
        .autsiz
        .databank ?

        ; Like rlProcUnitMenuSetUp with two commands (aCastleStaffMenuChecks): the staff lists at $7E2008 and $7E2028.

        lda #$0009
        jsl rlPlaySoundEffect
        lda aProcSystem.aHeaderTypeOffset,b,x
        tay
        jsl rlLoadMapMenuDataFromProc
        jsl rlListMenuProcPushOptions
        lda #$2000
        sta aCurrentTilemapInfo,b
        lda #$20FF
        sta wMapMenuClearTile,b
        lda #$0001
        sta wMenuOptionX,b
        sta wMenuOptionY,b
        phx
        jsl rlBuildCastleStaffSlotLists
        ldx #$0002

        _EA06
        phx
        jsr (aCastleStaffMenuChecks,x)
        plx
        bcc _EA1C
        lda #aCastleStaffMenuOptions >> 8
        sta lMenuOptionPointer+1,b
        lda <>aCastleStaffMenuOptions,b,x
        sta lMenuOptionPointer,b
        jsr rsUnitMenuAddOption

        _EA1C
        dec x
        dec x
        bpl _EA06
        plx
        jsl rlGetCurrentMenuOptionCount
        inc a
        asl a
        xba
        ora #$0009
        jsl rlSetMapMenuTilemapArea
        jsl rlDrawMenuOptions
        lda #<>rlListMenuProcHandleInput
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/EA3A

    .endsection Unsorted85E9D6Section


    .section Table85EA3ASection

      .al
      .xl

      aCastleStaffMenuChecks ; 85/EA3A

        ; Jump table of rlProcCastleStaffMenuSetUp.
        .word <>rsCastleStaffMenuCheckOutside
        .word <>rsCastleStaffMenuCheckInside

      aCastleStaffMenuOptions ; 85/EA3E

        .word <>aCastleStaffMenuOptionOutside
        .word <>aCastleStaffMenuOptionInside

    .endsection Table85EA3ASection


    .section Unsorted85EA42Section

      .al
      .xl

      rsCastleStaffMenuCheckOutside ; 85/EA42

        .al
        .xl
        .autsiz
        .databank ?

        ; Staves usable on the map ($7E2008).

        lda aUnitMenuStaffSlots
        and #$00FF
        bne _EA4F
        jml rsUnitMenuCheckFail


        _EA4F
        jml rsUnitMenuCheckPass

        .databank 0

        ; 85/EA53

    .endsection Unsorted85EA42Section


    .section Unsorted85EA53Section

      .al
      .xl

      rsCastleStaffMenuCheckInside ; 85/EA53

        .al
        .xl
        .autsiz
        .databank ?

        ; Staves usable in the castle ($7E2028).

        lda aUnitMenuCastleStaffSlots
        and #$00FF
        bne _EA60
        jml rsUnitMenuCheckFail


        _EA60
        jml rsUnitMenuCheckPass

        .databank 0

        ; 85/EA64

    .endsection Unsorted85EA53Section


