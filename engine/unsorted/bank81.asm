; Code from bank $81 not yet assigned to a game system.

    .section Unsorted8189F3Section

      .al
      .xl

      rlUnknown8189F3 ; 81/89F3

        .al
        .autsiz
        .databank ?

        phb
        lda aActiveSpriteSystem.aUnknown0012E0,b,x
        bit #$4000
        beq _End

          ldx aMovingMapSprites.wOffset,b
          lda aMovingMapSprites.wActiveSpriteOffset,b,x
          cmp #$FFFF
          beq _End

            jsl rlUnknown88D7FE

            lda aMovingMapSprites.wXPixelPosition,b,x
            sec
            sbc wMapScrollXPixels,b
            cmp #$FFC0
            bcs +

              cmp #$0140
              bcs _End

            +
            clc
            adc wR0
            sta wR0

            lda aMovingMapSprites.wYPixelPosition,b,x
            sec
            sbc wMapScrollYPixels,b
            cmp #$FFF0
            bcs +

              cmp #$0100
              bcs _End

            +
            clc
            adc wR1
            sta wR1
            lda aMovingMapSprites.wUnknown001804,b,x
            sta wR5
            jsl rlPushToOAMBuffer

        _End
        plb
        rtl

        .databank 0

        ; 81/8A42

    .endsection Unsorted8189F3Section


    .section Unsorted818A4ASection

      .al
      .xl

      rsUnknown818A4A ; 81/8A4A

        .al
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001300,b,y
        cmp #9
        bne +

          lda #8
          bra _End

        +
        lda aMovingMapSprites.wSpeed,b,x
        cmp #8
        bcc _End

          lda #4
          bra _End

            lda #6

        _End
        rts

        .databank 0

      rsUnknown818A68 ; 81/8A68

        .al
        .autsiz
        .databank $81

        ; Reads scripted movement paths

        lda aActiveSpriteSystem.aUnknown0012E0,b,y
        bit #$0010
        beq +

          ; If set, unload unit as soon as they are offscreen
          jsr rsUnknown818C98
          bcc +

            ; Character is not visible
            jsl rlUnknown818B76
            sec
            rts

        +
        jsr rsUnknown818CBF

        lda aActiveSpriteSystem.aUnknown001320,b,y
        beq +

          clc
          rts

        +
        sty lR19

        lda aMovingMapSprites.wPathScriptAddress,b,x
        sta lR18
        lda aMovingMapSprites.wPathScriptBank,b,x
        sta lR18+1
        lda aMovingMapSprites.wPathScriptOffset,b,x
        tay
        
          _Loop
          lda [lR18],y
          and #$00FF
          cmp #$0080
          bne +

            jsl rlUnknown818B76
            sec
            rts

          +
          bit #$0080
          beq rsUnknown818AD8

          phy
          and #$007F
          asl a
          tay
          lda aScriptedMovementPointers,y
          sta lR20
          lda aScriptedMovementPointers+1,y
          sta lR20+1
          ply
          inc y
          jsl +
          bcc _Loop

        rts

        +
        jmp (lR20)

        .databank 0

      aScriptedMovementPointers ; 81/8AC6

        .word <>rlUnknown818B76
        .word <>rlUnknown818B5D
        .word <>rlUnknown818BF0
        .word <>rlUnknown818BF9
        .word <>rlUnknown818C13
        .word <>rlUnknown818C5D
        .word <>rlUnknown818C62
        .word <>rlUnknown818C67
        .word <>rlUnknown818C6C

      rsUnknown818AD8 ; 81/8AD8

        .al
        .autsiz
        .databank ?

        ldy #1
        sty wR0

        ldy lR19
        cmp #10
        bcc +

          sbc #9
          pha
          phy
          inc y
          lda aMovingMapSprites.wPathScriptOffset,b,x
          inc a
          sta aMovingMapSprites.wPathScriptOffset,b,x
          tay
          lda [lR18],y
          and #$00FF
          sta wR0
          ply
          pla

        +
        cmp #9
        beq +

          cmp aActiveSpriteSystem.aUnknown001300,b,y
          beq +

            pha
            dec a
            asl a
            asl a
            asl a
            sta wUnknown000911,x
            lda #0
            sta wUnknown0008F1,x
            lda #0
            sta wUnknown000901,x
            pla

        +
        sta aActiveSpriteSystem.aUnknown001300,b,y

        lda aMovingMapSprites.wPathScriptOffset,b,x
        inc a
        sta aMovingMapSprites.wPathScriptOffset,b,x

        phx
        jsr rsUnknown818A4A
        tax
        lda aUnknown818B54,x
        and #$00FF
        xba
        ora wR0
        jsl rlUnsignedMultiply8By8
        sta aActiveSpriteSystem.aUnknown001320,b,y
        plx

        lda aActiveSpriteSystem.aUnknown001300,b,y
        cmp #4
        beq +

          lda #1
          sta aActiveSpriteSystem.aFrameTimer,b,y

        +
        lda #0
        sta aActiveSpriteSystem.aUnknown001340,b,y
        clc
        rts

        .databank 0

      aUnknown818B54 ; 81/8B54

        .byte $80
        .byte $80
        .byte $40
        .byte $20
        .byte $10
        .byte $08
        .byte $04
        .byte $02
        .byte $01

      rlUnknown818B5D ; 81/8B5D

        .al
        .autsiz
        .databank ?

        phy
        tya
        sta aMovingMapSprites.wPathScriptOffset,b,x

        lda aMovingMapSprites.wActiveSpriteOffset,b,x
        tay

        lda aActiveSpriteSystem.aUnknown0012E0,b,y
        and #~$8000
        sta aActiveSpriteSystem.aUnknown0012E0,b,y

        jsl rlUnknown818D58
        ply
        sec
        rtl

        .databank 0

      rlUnknown818B76 ; 81/8B76

        .al
        .autsiz
        .databank ?

        phy
        lda aMovingMapSprites.wActiveSpriteOffset,b,x
        tay

        jsr rsUnknown818B91

        lda #$FFFF
        sta aMovingMapSprites.wActiveSpriteOffset,b,x
        lda #0
        sta aActiveSpriteSystem.aTypeOffset,b,y

        jsl rlUnknown818D58
        ply
        sec
        rtl

        .databank 0

      rsUnknown818B91 ; 81/8B91

        .al
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown0012E0,b,y
        bit #$000E
        beq _8BEF

          phx
          phy
          bit #$0008
          bne +

            lda aMovingMapSprites.wUnknown0017CC,b,x
            tax
            jsl rlDeployedUnitUnsetHiddenIfAlive
            bra _End

          +
          lda aMovingMapSprites.wUnknown001814,b,x
          sta wR1
          lda aMovingMapSprites.wXPixelPosition,b,x
          sta wR2
          lda aMovingMapSprites.wYPixelPosition,b,x
          sta wR3
          phx
          lda aMovingMapSprites.wUnknown0017CC,b,x
          tax
          lda wR2
          sta aDeploymentTable._XPixelPosition,x
          lda wR3
          sta aDeploymentTable._YPixelPosition,x
          phx
          jsl rlAddDeployedMapSprite
          plx
          sta aDeploymentTable._DeploymentOffsets,x
          plx
          lda aMovingMapSprites.wUnknown001804,b,x
          xba
          lsr a
          dec a
          ora #$0080
          and #$FFBF
          sta wR0
          lda aMovingMapSprites.wUnknown0017CC,b,x
          tax
          lda wR0
          sta aDeploymentTable._State,x

          _End
          ply
          plx

        _8BEF
        rts

        .databank 0

      rlUnknown818BF0 ; 81/8BF0

        .al
        .autsiz
        .databank ?

        lda #0
        sta aMovingMapSprites.wPathScriptOffset,b,x
        tay
        clc
        rtl

        .databank 0

      rlUnknown818BF9 ; 81/8BF9

        .al
        .autsiz
        .databank ?

        lda [lR18],y
        sta aMovingMapSprites.wPathScriptAddress,b,x
        pha
        inc y
        lda [lR18],y
        sta aMovingMapSprites.wPathScriptBank,b,x
        sta lR18+1
        pla
        sta lR18
        lda #0
        sta aMovingMapSprites.wPathScriptOffset,b,x
        tay
        clc
        rtl

        .databank 0

      rlUnknown818C13 ; 81/8C13

        .al
        .autsiz
        .databank ?

        phx
        lda [lR18],y
        and #$00FF
        sta aMovingMapSprites.wSpeed,b,x
        asl a
        sta wR0
        inc y
        tya
        sta aMovingMapSprites.wPathScriptOffset,b,x

        lda aMovingMapSprites.wActiveSpriteOffset,b,x
        tay
        ldx wR0
        lda aUnknown818C45,x
        sta aActiveSpriteSystem.aUnknown001380,b,y
        lda aUnknown818C51,x
        sta aActiveSpriteSystem.aUnknown0013A0,b,y
        lda #9
        sta aActiveSpriteSystem.aUnknown001300,b,y
        plx
        lda aMovingMapSprites.wPathScriptOffset,b,x
        tay
        clc
        rtl

        .databank 0

      aUnknown818C45 ; 81/8C45

        .word $0000
        .word $2000
        .word $4000
        .word $8000
        .word $0000
        .word $0000

      aUnknown818C51 ; 81/8C51

        .word $0000
        .word $0000
        .word $0000
        .word $0000
        .word $0001
        .word $0002

    .endsection Unsorted818A4ASection


    .section Unsorted818C98Section

      .al
      .xl

      rsUnknown818C98 ; 81/8C98

        .al
        .autsiz
        .databank ?

        ; Check if moving character is not visible
        ; SEC if yes, CLC if no

        lda aMovingMapSprites.wXPixelPosition,b,x
        sec
        sbc wMapScrollXPixels,b
        cmp #$FFF0
        bcs +

        cmp #$0100
        bcs _SEC

        +
        lda aMovingMapSprites.wYPixelPosition,b,x
        sec
        sbc wMapScrollYPixels,b
        cmp #$FFF0
        bcs +

        cmp #$0100
        bcs _SEC

        +
        clc
        bra +

        _SEC
        sec
        
        +
        rts

        .databank 0

      rsUnknown818CBF ; 81/8CBF

        .al
        .autsiz
        .databank ?

        ; Guess: X panned moving sound effects

        php
        phx
        phy
        lda aMovingMapSprites.wXPixelPosition,b,x
        sec
        sbc wMapScrollXPixels,b
        bmi +

        cmp #16 * 16
        bcc _Continue

        lda #$00FF
        bra _Continue

        +
        lda #0
        bra _Continue

        _Continue
        jsl rlUnknown818CE2
        ply
        plx
        plp
        rts

        .databank 0

      rlUnknown818CE2 ; 81/8CE2

        .al
        .autsiz
        .databank ?

        php
        phx
        phy

        tay
        lda aMovingMapSprites.wMovingSound,b,x
        and #$FF00
        bne +

          jsr $818D23
          bra _End

        +
        xba
        dec a
        bne +

        sep #$20
        sty $04CB,b
        lda #0
        sta $04CC,b
        rep #$20
        ldx #0
        jsl rlUnknown809933
        bra _End

        +
        sep #$20
        sty $04CE,b
        lda #0
        sta $04CF,b
        rep #$20
        ldx #3
        jsl rlUnknown809933

        _End
        ply
        plx
        plp
        rtl

        .databank 0

        ; 81/8D23

    .endsection Unsorted818C98Section


    .section Unsorted818D58Section

      .al
      .xl

      rlUnknown818D58 ; 81/8D58

        .al
        .autsiz
        .databank ?

        ; Sound stuff

        php
        phx
        phy
        lda aMovingMapSprites.wMovingSound,b,x
        pha
        and #$00FF
        sta aMovingMapSprites.wMovingSound,b,x
        pla
        and #$FF00
        beq _End

          xba
          dec a
          bne +

          jsr rsUnknown818D82
          bra _End

          +
          jsr rsUnknown818D95

        _End
        ply
        plx
        plp
        rtl

        .databank 0

      rlUnknown818D7B ; 81/8D7B

        .al
        .autsiz
        .databank ?

        jsr rsUnknown818D82
        jsr rsUnknown818D95
        rtl

        .databank 0

      rsUnknown818D82 ; 81/8D82

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$10
        sta $04CA,b
        rep #$20
        ldx #0
        jsl rlUnknown809933
        plp
        rts

        .databank 0

      rsUnknown818D95 ; 81/8D95

        .al
        .autsiz
        .databank ?

        php
        sep #$20
        lda #$10
        sta $04CD,b
        rep #$20
        ldx #3
        jsl rlUnknown809933
        plp
        rts

        .databank 0

      rsUnknown818DA8 ; 81/8DA8

        .al
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001320,b,y
        dec a
        sta aActiveSpriteSystem.aUnknown001320,b,y

        lda aActiveSpriteSystem.aUnknown001380,b,y
        ora aActiveSpriteSystem.aUnknown0013A0,b,y
        beq _End2

          phx
          lda aActiveSpriteSystem.aUnknown001340,b,y
          clc
          adc aActiveSpriteSystem.aUnknown001380,b,y
          sta aActiveSpriteSystem.aUnknown001340,b,y
          rol a
          and #$0001
          sta wR5
          ror a
          clc
          lda aActiveSpriteSystem.aUnknown0013A0,b,y
          adc wR5
          sta wR5

          lda aActiveSpriteSystem.aUnknown001300,b,y
          bit #$0080
          bne _End

            dec a
            sta wR4

            lda wR4
            cmp #10
            bmi +

              -
              bra -

            +
            asl a
            tax
            jsr (aMovingMapSpritePositionRoutines,x)

            lda aActiveSpriteSystem.aUnknown0012E0,b,y
            bit #$0001
            beq _End

              jsr rsUnknown818E40

          _End
          plx

        _End2
        rts

        .databank 0

    .endsection Unsorted818D58Section


    .section Unsorted819166Section

      .al
      .xl

      rlUnknown819166 ; 81/9166

        .al
        .autsiz
        .databank ?

        lda wMapCurrentlyScrollingFlag,b
        bne +

          stz wMapPixelScrollDistance,b
          jsr rsGetMapPixelScrollDistance
          bcs _End

            lda wEventMapScrollSpeed,b
            sta wMapScrollSpeed,b
            stz wMapScrollCurrentPixelDistance,b

            lda #1
            sta wMapCurrentlyScrollingFlag,b

            stz wUnknown00073A,b
            stz wMapEnableXScrollFlag,b
            stz wMapEnableYScrollFlag,b

        +
        lda wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp wMapPixelScrollDistance,b
        bcc +

          ; Scrolled up to the wanted pixel distance, clear scrolling flags.
          sec
          sbc wMapPixelScrollDistance,b
          sta wR0

          lda wMapScrollSpeed,b
          sec
          sbc wR0
          sta wMapScrollSpeed,b

          stz wMapCurrentlyScrollingFlag,b
          stz wUnknown00073A,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b

        +
        lda wMapScrollDirectionIdentifier,b
        jsl rlUnknown819305
        clc

        _End
        rtl

        .databank 0

    .endsection Unsorted819166Section


    .section Unsorted81A89DSection

      .al
      .xl

      rlUnknown81A89D ; 81/A89D

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        jsl rlUnknown81B15A
        jsl rlUnknown81B088
        bcc +

          jsl rlUnknown81AB3F
          bra _End

        +
        lda wUnknown00171A,b
        bne +

          jsl rlUnknown81ADD8
          bcs _End

            jsr rsUnknown81AF38
            bcs _End

              jsr rsUnknown81AFD4
              bcs _End

                jsr rsUnknown81AF16
                bcs _End

                  jsr rsUnknown81B0E5
                  bcs _End

                    jsr rsUnknown81B116

        +
        lda $0304,b
        cmp #$000D
        bmi +

          -
          bra -

        +
        asl a
        tax
        jsr (aUnknown81A8F8,x)

        lda $0304,b
        sta $0D7B,b

        lda wUnknown00171A,b
        beq _End

          jsl rlUnknown88A12B
          jsl rlUnknown888560

        _End
        plp
        plb
        rtl

        .databank 0

      aUnknown81A8F8 ; 81/A8F8

        .word <>rsUnknown81A912 ; 0
        .word <>rsUnknown81A93B ; 1
        .word <>rsUnknown81A968 ; 2
        .word <>rsUnknown81A9A6 ; 3
        .word <>rlUnknown81AB6B ; 4
        .word <>rsUnknown81AB90 ; 5
        .word <>rsUnknown81AC4E ; 6
        .word <>rsUnknown81AC9C ; 7

        .word <>rsUnknown81ACD4 ; 8
        .word <>rsUnknown81ACFE ; 9
        .word <>rsUnknown81AD1C ; 10
        .word <>rsUnknown81AD28 ; 11
        .word <>rsUnknown81AD6A ; 12

      rsUnknown81A912 ; 81/A912

        .al
        .autsiz
        .databank ?

        ; Update status and miracle for all units in all factions

        lda wUnknown00171A,b
        bne _End

        lda wCurrentTurn,b
        inc a
        cmp #1000
        bcc +

          lda #999

        +
        sta wCurrentTurn,b

        lda #0
        sta wActiveFactionSlot,b

        ldy #6
        
          -
          tya
          jsl rlUnknown84C104
          dec y
          bpl -

        inc $0304,b
        
        _End
        rts

        .databank 0

      rsUnknown81A93B ; 81/A93B

        .al
        .autsiz
        .databank ?

        lda $0DAD,b
        beq _INC
        bpl _DEC

          lda wActiveFactionSlot,b
          jsl rlUnknown84C5D7
          bcc _INC

            jsr rsGetActiveFactionSongID
            bcc _INC

              lda #$00E0
              jsl rlUnknown808FA3
              lda #$0020
              sta $0DAD,b
              bra +

                _DEC
                dec $0DAD,b
                bra + 

        _INC
        inc $0304,b

        +
        rts

        .databank 0

      rsUnknown81A968 ; 81/A968

        .al
        .autsiz
        .databank ?

        ; does phase transition banner?

        lda wUnknown00171A,b
        bne _End

          lda #$1000
          trb wUnknown000D79,b

          lda wActiveFactionSlot,b
          jsl rlUnknown84C5D7
          bcc +

            lda #1
            sta $0508,b
            lda #1
            sta $0500,b
            jsl rlUnknown81A9D4

            lda #(`$85ABF6)<<8
            sta $62+1
            lda #<>$85ABF6
            sta $62
            jsl rlProcEngineCreateProc

            lda #$0040
            trb $0788,b
            bra +

          +
          inc $0304,b
        
        _End
        rts

        .databank 0

      rsUnknown81A9A6 ; 81/A9A6

        .al
        .autsiz
        .databank ?

        ; sets up turn events

        lda #0
        sta $0508,b
        lda #$0021
        sta bEventActionIdentifier,b

        lda wCurrentTurn,b
        sta wEventEngineArgument1,b

        lda wActiveFactionSlot,b
        sta wEventEngineArgument2,b
        lda #0
        sta wEventEngineArgument3,b
        lda #0
        sta wEventEngineArgument4,b
        jsl rlGetAndRunChapterMapEventConditions
        bcc +

        +
        inc $0304,b

        rts

        .databank 0

      rlUnknown81A9D4 ; 81/A9D4

        .al
        .autsiz
        .databank ?

        lda wUnknown000D79,b
        bit #$4000
        beq +

          jsr rsGetActiveFactionSongID
          bcc _End

            sta $0DAB,b
            jsl rlUnknown81AB26
            bra _End

        +
        ora #$4000
        sta wUnknown000D79,b

        jsr rsUnknown81AAFB
        jsr rsGetActiveFactionSongID
        sta $0DAB,b
        
        _End
        lda #$FFFF
        sta $0DAD,b
        rtl

        .databank 0

    .endsection Unsorted81A89DSection


    .section Unsorted81AC02Section

      .al
      .xl

      rsUnknown81AC02 ; 81/AC02

        .al
        .autsiz
        .databank ?

        lda wActiveFactionSlot,b
        bne _End

          lda wCurrentTurn,b
          cmp #1
          beq +

            jsl $87C02F
            cmp #0
            beq +

              lda $0D75,b
              and #$00FF
              sta $14
              lda $0D76,b
              and #$00FF
              sta $16
              jsl $848E5D
              bra _End
          
          +
          lda #1
          sta wRoutineVariable1,b
          lda #0
          jsl rlFindGenerationIDInFactionSlotData

          lda wSelectedUnitDataRAMPointer,b
          beq _End

            jsl rlGetSelectedUnitDeploymentOffset
            ora #0
            bmi _End

              jsl rlUnknown88B4DB
        
        _End
        rts

        .databank 0

      rsUnknown81AC4E ; 81/AC4E

        .al
        .autsiz
        .databank ?

        lda wCurrentTurn,b
        cmp #1
        beq _INC

          lda wActiveFactionSlot,b
          bne _INC

            jsl $87BFB0
            ora #0
            beq _INC

              lda #(`$85CA85)<<8
              sta $62+1
              lda #<>$85CA85
              sta $62
              jsl rlProcEngineFindProc
              bcs _End

                jsl rlUnknown88A12B
                jsl rlUnknown888560

                lda wUnknown0007D8,b
                bne _End

                  lda #1
                  sta $0ECF,b
                  lda #(`$85A47F)<<8
                  sta $62+1
                  lda #<>$85A47F
                  sta $62
                  jsl rlProcEngineCreateProc
                  bra _INC
              
              _End
              rts
        
        _INC
        inc $0304,b
        rts

        .databank 0

      rsUnknown81AC9C ; 81/AC9C

        .al
        .autsiz
        .databank ?

        ; Routine waits for some kind of input?

        lda wUnknown00171A,b
        bne +

          jsr rsUnknown81AD8E
          lda wUnknown0007D8,b
          bne +
        
        +
        lda $0D87,b
        bit #$0020
        bne +

          lda wUnknown000D79,b
          bit #$0200
          bne +

            jsl rlUnknown88A12B
            jsl rlUnknown888560
        
        +
        lda $0D87,b
        bit #$0020
        bne +

          rts
        
        +
        lda #$0020
        trb $0D87,b
        inc $0304,b
        rts

        .databank 0

      rsUnknown81ACD4 ; 81/ACD4

        .al
        .autsiz
        .databank ?

        lda wActiveFactionSlot,b
        jsl rlUnknown84C12E

          -
          lda wActiveFactionSlot,b
          inc a
          cmp wLoadedFactionCount,b
          bcs +

            sta wActiveFactionSlot,b
            jsl rlGetFactionSlotNameID
            cmp #$0080
            beq -

        lda #1
        sta $0304,b
        rts
        
        +
        stz wActiveFactionSlot,b
        inc $0304,b
        rts

        .databank 0

      rsUnknown81ACFE ; 81/ACFE

        .al
        .autsiz
        .databank ?

        jsl rlUnknown869D0E

        lda #$0040
        tsb $0788,b

        lda #$0020
        sta bEventActionIdentifier,b
        lda wCurrentTurn,b
        sta wEventEngineArgument1,b
        jsl rlGetAndRunChapterMapEventConditions
        stz $0304,b
        rts

        .databank 0

      rsUnknown81AD1C ; 81/AD1C

        .al
        .autsiz
        .databank ?

        lda #$BBD9
        sta wMainLoopPointer
        lda #7
        sta $0304,b
        rts

        .databank 0

    .endsection Unsorted81AC02Section


    .section Unsorted81AD6ASection

      .al
      .xl

      rsUnknown81AD6A ; 81/AD6A

        .al
        .autsiz
        .databank ?

        lda wUnknown00171A,b
        bne +

          lda #$00E0
          jsl rlUnknown808FA3

          stz $0302,b

          lda #<>$80B1E1
          sta aProcSystem.wInput0,b

          lda #(`procMainLoopChangeFade)<<8
          sta lR44+1
          lda #<>procMainLoopChangeFade
          sta lR44
          jsl rlProcEngineCreateProc

        +
        rts

        .databank 0

    .endsection Unsorted81AD6ASection


    .section Unsorted81AE02Section

      .al
      .xl

      aUnknown81AE02 ; 81/AE02

        .word <>rsUnknown81AE46
        .word <>rsUnknown81AE68
        .word <>rsUnknown81AE96
        .word <>rsUnknown81AEAA
        .word <>rsUnknown81AF03
        .word <>rsUnknown81AFB7
        .word <>$AFF8
        .word <>$AFFE
        .word <>$B016
        .word <>$B030

      rlUnknown81AE16 ; 81/AE16

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb

        lda wUnknown00171A,b
        bne _CLC

          lda wUnknownDeploymentOffset000D7F,b
          bmi _CLC

            lda $0D81,b
            cmp #0
            beq +

              cmp #9
              beq _SEC

                cmp #3
                bne _CLC

                  lda wUnknown000D79,b
                  bit #$0040
                  beq _SEC

        _CLC
        clc
        
        -
        plb
        rtl
        
        +
        jsr rsUnknown81AE46
        
        _SEC
        sec
        bra -

        .databank 0

      rsUnknown81AE46 ; 81/AE46

        .al
        .autsiz
        .databank ?

        ldx wUnknownDeploymentOffset000D7F,b

        ; packed coords?
        lda $0D83,b
        sta wRoutineVariable1,b
        jsl rlUnknown84C996

        stz $0580,b

        jsl rlDeployedUnitUnsetHiddenIfAlive

        lda wUnknown000D79,b
        bit #$0020
        beq +

          jsl $8A9342
        
        +
        sec
        rts

        .databank 0

      rsUnknown81AE68 ; 81/AE68

        .al
        .autsiz
        .databank ?

        lda #7
        jsl rlSetSelectedUnitFaction
        jsl rlGetSelectedUnitDeploymentOffset
        cmp #$00FF
        beq _SEC

          jsl rlClearUnitDeploymentData

          lda #$00FF
          jsl rlSetSelectedUnitDeploymentOffset

          lda #$0017
          sta bEventActionIdentifier,b

          jsl rlGetSelectedUnitCharacterID
          sta wEventEngineArgument1,b
          jsl rlGetAndRunChapterMapEventConditions

        _SEC
        sec
        rts

        .databank 0

    .endsection Unsorted81AE02Section


    .section Unsorted81AEAASection

      .al
      .xl

      rsUnknown81AEAA ; 81/AEAA

        .al
        .autsiz
        .databank ?

        ; entering castle?

        ldx wUnknownDeploymentOffset000D7F,b
        lda $0D83,b
        jsl rlSetUnitResidingInCastle

        stz $0580,b

        jsl rlUnknown85CA4B

        lda wUnknown000D79,b
        bit #$0040
        beq +

          and #~($40)
          sta wUnknown000D79,b

          stz $0302,b

          lda #0
          jsl $88B30D
          bra _End
        
        +
        lda wUnknown000D79,b
        bit #$0020
        beq +

          jsl $8A9342
          bra _End
        
        +
        lda #4
        sta bEventActionIdentifier,b
        jsl rlGetSelectedUnitCharacterID
        sta wEventEngineArgument1,b

        jsl rlGetSelectedUnitHomeCastle
        sta wEventEngineArgument2,b

        jsl rlGetAndRunChapterMapEventConditions
        bcs _End

          jsl $8CEDD0

        _End
        sec
        rts

        .databank 0

      rsUnknown81AF03 ; 81/AF03

        .al
        .autsiz
        .databank ?

        lda $0D83,b
        sta wSelectedUnitDataRAMPointer,b
        jsl $84AF17
        lda #$001A
        jsl $80900D
        sec
        rts

        .databank 0

      rsUnknown81AF16 ; 81/AF16

        .al
        .autsiz
        .databank ?

        lda $70
        and #$00FF
        beq _CLC

          lda $0D89,b
          bmi _CLC

            tax
            lda aDeploymentTable._UnitRAMPointer,x
            sta $0ECF,b

            jsl $85B14F

            lda #$FFFF
            sta $0D89,b
            sec
            rts
        
        _CLC
        clc
        rts

        .databank 0

      rsUnknown81AF38 ; 81/AF38

        .al
        .autsiz
        .databank ?

        lda $0D87,b
        bpl _CLC

          lda wUnknown00171A,b
          bne _CLC

            lda wUnknown0007D8,b
            cmp #4
            beq _CLC

              ldx $0772,b
              jsl rsUnknown88AF4C

              ldx $0772,b
              lda aDeploymentTable._UnitRAMPointer,x
              sta wSelectedUnitDataRAMPointer,b

              jsl rlGetSelectedUnitStates
              bit #UnitStateFielded
              bne +

                lda #UnitStateFielded
                jsl rlSetSelectedUnitStates
              
              +
              lda #$0008
              tsb $0788,b

              lda $0D87,b
              and #$0003
              sta $00

              phb
              jsl _AF81
              plb
              bra +
              
                _AF81
                lda $00
                asl a
                adc $00
                tax
                lda aUnknown81AFAE,x
                sta $33
                sep #$20
                lda aUnknown81AFAE+2,x
                sta $33+2
                pha
                plb
                rep #$20
                jml [$0033]

              +
              lda #$8000
              trb $0D87,b

              lda $0304,b
              cmp #11
              beq _CLC

                sec
                rts

        _CLC
        clc
        rts

        .databank 0

      aUnknown81AFAE ; 81/AFAE

        .long $85E85D
        .long $85E8A8
        .long $85E8C9

    .endsection Unsorted81AEAASection


    .section Unsorted81B088Section

      .al
      .xl

      rlUnknown81B088 ; 81/B088

        .al
        .autsiz
        .databank ?

        lda wUnknown00171A,b
        bne _CLC

          lda wDefeatedUnitDeploymentOffset,b
          bmi _CLC

            tax
            lda aDeploymentTable._UnitRAMPointer,x
            sta wSelectedUnitDataRAMPointer,b

            lda aDeploymentTable._FactionSlot,x
            bne +

              jsl rlGetSelectedUnitGenerationID
              cmp #1
              bne +

                lda #0
                jsl rlUnknown81B32C

            +
            lda $7E4ED9
            ora $7E4F39
            bit #$0001
            bne +

              txa
              jsl rlDeployedUnitSetHiddenUnsetAlive

            +
            lda #$0017
            sta bEventActionIdentifier,b
            jsl rlGetSelectedUnitCharacterID
            sta wEventEngineArgument1,b

            jsl rlGetSelectedUnitFactionSlot
            sta wEventEngineArgument2,b

            jsl rlGetAndRunChapterMapEventConditions

            lda #$FFFF
            sta wDefeatedUnitDeploymentOffset,b
            sec
            bra +
        
        _CLC
        clc
        
        +
        rtl

        .databank 0

      rsUnknown81B0E5 ; 81/B0E5

        .al
        .autsiz
        .databank ?

        lda wUnknown000D79,b
        bit #$2000
        beq _CLC

          jsl $88B6FD

          ldx $0772,b
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b

          jsl rlGetSelectedUnitStates
          bit #UnitStateFielded
          bne +

            lda #UnitStateFielded
            jsl rlSetSelectedUnitStates
          
          +
          lda #$2000
          trb wUnknown000D79,b
          sec
          bra +
        
        _CLC
        clc
        
        +
        rts

        .databank 0

      rsUnknown81B116 ; 81/B116

        .al
        .autsiz
        .databank ?

        ; Prepares after action location based events

        lda $0D8B,b
        bmi _CLC

          tax
          lda aDeploymentTable._UnitRAMPointer,x
          sta wSelectedUnitDataRAMPointer,b

          lda #3
          sta bEventActionIdentifier,b
          jsl rlGetSelectedUnitCharacterID
          sta wEventEngineArgument1,b

          lda aDeploymentTable._XTilePosition,x
          sta wEventEngineArgument2,b
          lda aDeploymentTable._YTilePosition,x
          sta wEventEngineArgument3,b
          lda aDeploymentTable._FactionSlot,x
          sta wEventEngineArgument4,b
          jsl rlGetAndRunChapterMapEventConditions

          lda #$FFFF
          sta $0D8B,b

          lda #$8000
          trb wUnknown000D79,b
          sec
          bra +

        _CLC
        clc
        
        +
        rts

        .databank 0

      rlUnknown81B15A ; 81/B15A

        .al
        .autsiz
        .databank ?

        ; Updates the Deployment state with buffered values

        lda wUnknown00171A,b
        bne _CLC

          lda $0304,b
          cmp #11
          beq _CLC

            lda wUnknown000D79,b
            bit #$0004
            beq _CLC

              ldx #(72-1) * size(word)

                -
                lda aDeploymentTable._StateBuffer,x
                sta aDeploymentTable._State,x
                dec x
                dec x
                bpl -

              lda #4
              trb wUnknown000D79,b
              sec
              bra +

        _CLC
        clc
        
        +
        rtl

        .databank 0

      rlUnknown81B189 ; 81/B189

        .al
        .autsiz
        .databank ?

        phx
        lda $0E7B,b
        bit #$0040
        bne _CLC

        ldx $0772,b
        lda wUnknown000D79,b
        bit #$0004
        beq +

          lda aDeploymentTable._StateBuffer,x
          and #~DeploymentStateGrayed
          sta aDeploymentTable._State,x

        +
        lda aDeploymentTable._State,x
        bit #DeploymentStateAlive
        beq _CLC

        bit #DeploymentStateDefeated
        bne _CLC

        bit #DeploymentStateCanto
        beq _CLC

        lda aDeploymentTable._UnitRAMPointer,x
        sta wSelectedUnitDataRAMPointer,b
        lda aDeploymentTable._XTilePosition,x
        sta wR10
        lda aDeploymentTable._YTilePosition,x
        sta wR11
        jsl rlUnknown87B541
        bcc +

          jsl rlUnknown84D4A2
          bcc _SEC

        +
        lda #$2000
        tsb wUnknown000D79,b
        lda #$8000
        tsb wUnknown000D79,b
        
        _SEC
        plx
        sec
        bra +
        
        _CLC
        plx
        clc
        
        +
        rtl

        .databank 0

      rlUnknown81B1ED ; 81/B1ED

        .al
        .autsiz
        .databank ?

        lda wUnknownDeploymentOffset000D7F,b
        bmi _End

          lda $0D81,b
          cmp #5
          bne _End

            lda wUnknown000D79,b
            bit #$0400
            bne _End

              lda #1
              sta aProcSystem.wInput2,b
              lda $0D83,b
              sta aProcSystem.wInput3,b

              lda #(`$85BA41)<<8
              sta lR44+1
              lda #<>$85BA41
              sta lR44
              jsl rlEventEngineCreateProc
              lda #$FFFF
              sta wUnknownDeploymentOffset000D7F,b

        _End
        rtl

        .databank 0

    .endsection Unsorted81B088Section


    .section Unsorted81B2AASection

      .al
      .xl

      rlSaveChapterTurncount ; 81/B2AA

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        lda wCurrentChapter,b
        cmp #5
        beq +

        cmp #11
        bne ++

        +
        lda #FS_Player
        jsl rlCountUnitsInFactionSlotAlive
        clc
        adc wTotalAlivePlayerUnitCount
        sta wTotalAlivePlayerUnitCount

        +
        lda wCurrentChapter,b
        asl a
        tax
        lda wCurrentTurn,b
        sta aChapterTurncounts,b,x
        lda #$FFFF
        sta wCurrentTurn,b
        lda #$0400
        tsb wUnknown000D79,b
        jsl rlClearUnitWindowAndTerrainWindowProcs

        lda wCurrentChapter,b
        cmp #11
        beq +

          lda $0772,b
          sta wUnknownDeploymentOffset000D7F,b
          lda #6
          sta $0D81,b
          bra +

        +
        plx
        plp
        plb
        rtl

        .databank 0

        ; 81/B301

    .endsection Unsorted81B2AASection


    .section Unsorted81B32CSection

      .al
      .xl

      rlUnknown81B32C ; 81/B32C

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        asl a
        tax

        lda wCurrentChapter,b
        cmp #6
        bcc +

          txa
          clc
          adc #4
          tax

        +
        lda aUnknown81B353,x
        jsl rlUnknown80C1CB
        lda #12
        sta $0304,b

        plx
        plp
        plb
        rtl

        .databank 0

      aUnknown81B353 ; 81/B353

        ; some event IDs

        .word $022E
        .word $022F
        .word $0230
        .word $0231

      rlUnknown81B35B ; 81/B35B

        .al
        .autsiz
        .databank ?

        jsl rlUnknown869CF9
        jsl rlUnknown88AF7B
        jsl $9E800C
        rtl

        .databank 0

      rlUnknown81B368 ; 81/B368

        .al
        .autsiz
        .databank ?

        lda #$00E0
        jsl rlUnknown808FA3

        stz $07E0,b
        stz $0302,b

        lda wBattleType
        and #$00FF
        cmp #0
        beq +

        lda #<>$80BFFB
        sta aProcSystem.wInput0,b
        lda #(`procMainLoopChangeFade)<<8
        sta lR44+1
        lda #<>procMainLoopChangeFade
        sta lR44
        jsl rlProcEngineCreateProc
        bra ++

        +
        lda #(`$87C38C)<<8
        sta lR44+1
        lda #<>$87C38C
        sta lR44
        jsl rlHDMAEngineCreateEntry
        
        +
        rtl

        .databank 0

        ; 81/B3A6

    .endsection Unsorted81B32CSection


    .section Unsorted81B43FSection

      .al
      .xl

      rlUnknown81B43F ; 81/B43F

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        dec a
        cmp #6
        bcs +

          tax
          sep #$20
          lda wAreaRestrictionBitfield,b
          ora $81B45B,x
          sta wAreaRestrictionBitfield,b
          rep #$20

        +
        plp
        plb
        rtl

        .databank 0

        ; 81/B45B

    .endsection Unsorted81B43FSection


    .section Unsorted81B461Section

      .al
      .xl

      rlUnknown81B461 ; 81/B461

        .al
        .autsiz
        .databank ?


        phb
        php
        phk
        plb
        dec a
        cmp #6
        bcs +

          tax
          sep #$20
          lda wAreaRestrictionBitfield,b
          and $81B47D,x
          sta wAreaRestrictionBitfield,b
          rep #$20

        +
        plp
        plb
        rtl

        .databank 0

        ; 81/B47D

    .endsection Unsorted81B461Section
