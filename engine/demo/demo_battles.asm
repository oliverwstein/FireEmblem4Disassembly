; The attract mode's scripted battles. $1B49 is the demo index (set from the kept
; ranking by rlSetDemoIndexFromRanking); rlRunDemoBattleSetup fills the action
; structs and battle rounds from aDemoBattleSetups. Bank $88; two of the setups are
; in bank $9E.


    .section Unsorted88EEB1Section

      .al
      .xl

      rlSetDemoIndexFromRanking ; 88/EEB1

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets the attract demo index ($1B49, and $1B4B where it restarts) from the kept ranking: 2 x (7 - ranking) - 1, with ranking 6 when none is kept.

        phx
        jsl rlGetKeptRanking
        beq _EEC2
        cmp #$0006
        bcs _EEC2
        sta wR0,b
        bra _EEC8


        _EEC2
        lda #$0006
        sta wR0,b

        _EEC8
        lda #$0007
        sec
        sbc wR0,b
        asl a
        dec a
        sta wDemoIndex,b
        sta wDemoRestartIndex,b
        plx
        rtl

        .databank 0

      rlRunDemoBattleSetup ; 88/EED9

        .al
        .xl
        .autsiz
        .databank ?

        ; Sets bit 0 of the demo index and runs its entry of aDemoBattleSetups, then steps the index down (back to wDemoRestartIndex below 0). The opening (engine/demo/opening.asm) runs this for the odd scene of a pair and rlRunDemoBattleSetupAtIndex for the even one.

        lda wDemoIndex,b
        ora #$0001
        sta wDemoIndex,b

      rlRunDemoBattleSetupAtIndex ; 88/EEE2

        .al
        .xl
        .autsiz
        .databank ?

        ; The same without setting bit 0: the attract mode's opening runs it for the even scene of each pair.

        phx
        lda wDemoIndex,b
        asl a
        clc
        adc wDemoIndex,b
        tax
        lda @l aDemoBattleSetups,x
        sta lR18
        lda @l aDemoBattleSetups+1,x
        sta lR18+1
        phk
        pea #<>(+)-1
        jml [lR18]
        +
        lda wDemoIndex,b
        dec a
        bpl +
        lda wDemoRestartIndex,b
        +
        sta wDemoIndex,b
        plx
        rtl

        .databank 0

    .endsection Unsorted88EEB1Section


    .section Unsorted88EF0DSection

      .al
      .xl

      aDemoBattleSetups ; 88/EF0D

        ; 12 long pointers to routines.

        .long rlSetUpDemoBattleB, rlSetUpDemoBattleA, rlSetupDemoBattle02
        .long rlSetupDemoBattle03, rlSetupDemoBattle04, rlSetupDemoBattle05
        .long rlSetupDemoBattle06, rlSetupDemoBattle07, rlSetupDemoBattle08
        .long rlSetupDemoBattle09, rlSetupDemoBattle10, rlSetupDemoBattle11

      rlSetupDemoBattle03 ; 88/EF31

        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 3 of aDemoBattleSetups: fills the action structs and battle rounds for a scripted attract demo battle.

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0002
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0021
        sta aActionStructUnit1.XPosition
        lda #$0017
        sta aActionStructUnit1.YPosition
        lda #$0031
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0029
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$0021
        sta aActionStructUnit2.XPosition
        lda #$0019
        sta aActionStructUnit2.YPosition
        lda #$002D
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0002
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0135
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

      rlSetupDemoBattle05 ; 88/F01D

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 5 of aDemoBattleSetups: fills the action structs and battle rounds for a scripted attract demo battle.

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0000
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0034
        sta aActionStructUnit1.XPosition
        lda #$0022
        sta aActionStructUnit1.YPosition
        lda #$0001
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0016
        sta aActionStructUnit2.ClassID
        lda #$0001
        sta aActionStructUnit2.Gender
        lda #$0034
        sta aActionStructUnit2.XPosition
        lda #$0023
        sta aActionStructUnit2.YPosition
        lda #$0003
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0008
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0105
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0009
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F13B

      rlSetupDemoBattle07 ; 88/F13B

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 7 of aDemoBattleSetups: fills the action structs and battle rounds for a scripted attract demo battle.

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0011
        sta aActionStructUnit1.ClassID
        lda #$0001
        sta aActionStructUnit1.Gender
        lda #$0023
        sta aActionStructUnit1.XPosition
        lda #$0032
        sta aActionStructUnit1.YPosition
        lda #$0002
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0003
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0011
        sta aActionStructUnit2.ClassID
        lda #$0001
        sta aActionStructUnit2.Gender
        lda #$0024
        sta aActionStructUnit2.XPosition
        lda #$0032
        sta aActionStructUnit2.YPosition
        lda #$001E
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0008
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0101
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0115
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F259

      rlSetupDemoBattle09 ; 88/F259

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 9 of aDemoBattleSetups: fills the action structs and battle rounds for a scripted attract demo battle.

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0007
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$001E
        sta aActionStructUnit1.XPosition
        lda #$0036
        sta aActionStructUnit1.YPosition
        lda #$0024
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0009
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$001D
        sta aActionStructUnit2.XPosition
        lda #$0036
        sta aActionStructUnit2.YPosition
        lda #$0014
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0009
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0008
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F35E

      rlSetupDemoBattle11 ; 88/F35E

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 11 of aDemoBattleSetups: fills the action structs and battle rounds for a scripted attract demo battle.

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0006
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0037
        sta aActionStructUnit1.XPosition
        lda #$0007
        sta aActionStructUnit1.YPosition
        lda #$0015
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$001C
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$0037
        sta aActionStructUnit2.XPosition
        lda #$0006
        sta aActionStructUnit2.YPosition
        lda #$002C
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0101
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0100
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0114
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F47C

      rlSetupDemoBattle02 ; 88/F47C

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 2 of aDemoBattleSetups: fills the action structs and battle rounds for a scripted attract demo battle.

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0003
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$002E
        sta aActionStructUnit1.XPosition
        lda #$001D
        sta aActionStructUnit1.YPosition
        lda #$0029
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0027
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$002D
        sta aActionStructUnit2.XPosition
        lda #$001D
        sta aActionStructUnit2.YPosition
        lda #$0029
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0100
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0101
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0100
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0101
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F5B3

      rlSetupDemoBattle04 ; 88/F5B3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 4 of aDemoBattleSetups: fills the action structs and battle rounds for a scripted attract demo battle.

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$003C
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$000D
        sta aActionStructUnit1.XPosition
        lda #$000A
        sta aActionStructUnit1.YPosition
        lda #$004E
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0035
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$000E
        sta aActionStructUnit2.XPosition
        lda #$000A
        sta aActionStructUnit2.YPosition
        lda #$003F
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0141
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0140
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0140
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F6D1

      rlSetupDemoBattle06 ; 88/F6D1

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 6 of aDemoBattleSetups: fills the action structs and battle rounds for a scripted attract demo battle.

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0013
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$002B
        sta aActionStructUnit1.XPosition
        lda #$002F
        sta aActionStructUnit1.YPosition
        lda #$0024
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0014
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$002C
        sta aActionStructUnit2.XPosition
        lda #$002F
        sta aActionStructUnit2.YPosition
        lda #$0023
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0109
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0104
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0114
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F7EF

      rlSetupDemoBattle08 ; 88/F7EF

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 8 of aDemoBattleSetups: fills the action structs and battle rounds for a scripted attract demo battle.

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$002D
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0023
        sta aActionStructUnit1.XPosition
        lda #$0013
        sta aActionStructUnit1.YPosition
        lda #$004B
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$003A
        sta aActionStructUnit2.ClassID
        lda #$0001
        sta aActionStructUnit2.Gender
        lda #$0024
        sta aActionStructUnit2.XPosition
        lda #$0013
        sta aActionStructUnit2.YPosition
        lda #$0046
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0144
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0154
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/F8F4

      rlSetupDemoBattle10 ; 88/F8F4

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Entry 10 of aDemoBattleSetups: fills the action structs and battle rounds for a scripted attract demo battle.

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0006
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$000F
        sta aActionStructUnit1.XPosition
        lda #$0005
        sta aActionStructUnit1.YPosition
        lda #$0015
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0019
        sta aActionStructUnit1.CharacterID
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$001B
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$000F
        sta aActionStructUnit2.XPosition
        lda #$0004
        sta aActionStructUnit2.YPosition
        lda #$0041
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0149
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0100
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0104
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 88/FA19

    .endsection Unsorted88EF0DSection


    .section Unsorted9EEDB5Section

      .al
      .xl

      rlSetUpDemoBattleA ; 9E/EDB5

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$0019
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0038
        sta aActionStructUnit1.XPosition
        lda #$0039
        sta aActionStructUnit1.YPosition
        lda #$000A
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$0012
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$0039
        sta aActionStructUnit2.XPosition
        lda #$0039
        sta aActionStructUnit2.YPosition
        lda #$001D
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0009
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$1B00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$1614
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 9E/EED3

      rlSetUpDemoBattleB ; 9E/EED3

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        phb
        jsl rlClearBattleData
        pea #$7F00
        plb
        .databank ?
        plb
        .databank ?
        lda #$003B
        sta aActionStructUnit1.ClassID
        lda #$0000
        sta aActionStructUnit1.Gender
        lda #$0039
        sta aActionStructUnit1.XPosition
        lda #$0037
        sta aActionStructUnit1.YPosition
        lda #$004B
        sta aActionStructUnit1.WeaponID
        lda #$0000
        sta aActionStructUnit1.Unknown
        lda #$0000
        sta aMapAction.wUnknown7F4562
        sta aActionStructUnit1
        lda #$000E
        sta aActionStructUnit2.ClassID
        lda #$0000
        sta aActionStructUnit2.Gender
        lda #$0039
        sta aActionStructUnit2.XPosition
        lda #$0038
        sta aActionStructUnit2.YPosition
        lda #$002A
        sta aActionStructUnit2.WeaponID
        lda #$0000
        sta aActionStructUnit2.Unknown
        lda #$0001
        sta aMapAction.wDefenderAllegiance
        sta aActionStructUnit2
        lda #$0001
        sta wBattleDistance
        sep #$20
        lda #$00
        sta $7E4EA9
        rep #$20
        lda #(`aBattleRoundsData)<<8
        sta lR18+1
        lda #<>aBattleRoundsData
        sta lR18
        lda #$0020
        sta wR0
        lda #$0002
        sta wR1
        jsl rlBuildRAMStructHeader
        lda #$0148
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0109
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$0140
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$7F00
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        lda #$FFFF
        sta @l lStructPointer1
        lda #$7E00
        sta @l lStructPointer2+1
        lda #$4F81
        sta @l lStructPointer2
        jsl rlAppendNewStructEntry
        plb
        .databank ?
        plx
        rtl

        .databank 0

        ; 9E/EFF1

    .endsection Unsorted9EEDB5Section


