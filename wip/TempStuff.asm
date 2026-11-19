



; ActionIdentifier:

; $03 = after action
; $04 = enter home castle?

; $09 = visit village
; $0A = talk

; $11 = ?

; $14 = attack

; $17 = someone got killed?
; $18 = ?

; $20 = start player phase?

; $21 = before enemy action?


      rlDMAPaletteAndOAMBuffer ; 80/807C

        .al
        .autsiz
        .databank ?

        php
        sep #$10
        rep #$20

        lda #pack([DMAP_DMA_Setting(DMAP_CPUToIO, DMAP_Increment, DMAP_Mode0), narrow(OAMDATA - PPU_REG_BASE, 1)])
        sta DMA_IO[0].DMAP,b

        lda #<>aSpriteBuffer
        sta DMA_IO[0].A1,b
        ldx #`aSpriteBuffer
        stx DMA_IO[0].A1+2,b

        lda #size(aSpriteBuffer)+size(aSpriteExtBuffer)
        sta DMA_IO[0].DAS,b

        stz OAMADD,b

        lda #pack([DMAP_DMA_Setting(DMAP_CPUToIO, DMAP_Increment, DMAP_Mode0), narrow(CGDATA - PPU_REG_BASE, 1)])
        sta DMA_IO[1].DMAP,b

        lda #<>aBGPaletteBuffer
        sta DMA_IO[1].A1,b
        ldx #`aBGPaletteBuffer
        stx DMA_IO[1].A1+2,b

        lda #size(aBGPaletteBuffer)+size(aOAMPaletteBuffer)
        sta DMA_IO[1].DAS,b

        ldx #0
        stx CGADD,b

        ldx #MDMAEN_Setting([0, 1])
        stx MDMAEN,b

        lda wBufferOAMADD
        sta OAMADD,b
        plp
        rtl

        .databank 0

        ; 80/80C3









      rlUnknown808FA3 ; 80/8FA3

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        rep #$30
        phx
        pha
        bra +

      rlUnknown808FAD ; 80/8FAD

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        rep #$30
        phy
        tax
        lda $04F4,b
        and #$00FF
        bne _End

          lda $04EA,b
          and #$0001
          bne _End

            phx

            +
            ldx #0

              -
              lda $04D8,b,x
              beq +

                inc x
                inc x
                cpx #6
                bcc -

            +
            pla
            sta $04D8,b,x
        
        _End
        plx
        plb
        plp
        rtl

        .databank 0

      rlUnknown80A773 ; 80/A773

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb

        stz wRNIndex,b
        sep #$30

        lda bFrameCounterByOnes,b
        and #$3F
        sta bRNGUnknown1
        sta aRNArray + size(aRNArray) - 1,b

        lda #1
        sta bRNGUnknown2
        ldy #20
        ldx #$36

          _Loop
          lda bRNGUnknown2
          sta aRNArray,b,y

          lda bRNGUnknown1
          sec
          sbc bRNGUnknown2
          bge +

            clc
            adc #100

          +
          sta bRNGUnknown2

          lda aRNArray,b,y
          sta bRNGUnknown1

          tya
          clc
          adc #21
          cmp #size(aRNArray)
          blt +

            sbc #size(aRNArray)

          +
          tay
          dec x
          bne _Loop

        jsr rsShuffleRNTable
        jsr rsShuffleRNTable
        jsr rsShuffleRNTable

        plb
        plp
        rtl

        .databank 0

      rsShuffleRNTable ; 80/A7C5

        .as
        .autsiz
        .databank $9E

        ldy #0

          _Loop
          tya
          sta bRNGUnknown1
          cmp #24
          bge +

          adc #$1F
          blt ++

          +
          sbc #24

          +
          tay
          lda aRNArray,b,y
          sta bRNGUnknown2

          ldy bRNGUnknown1
          lda aRNArray,b,y
          sec
          sbc bRNGUnknown2
          bge +

            adc #100

          +
          sta aRNArray,b,y
          inc y
          cpy #$37
          bne _Loop

        rts

        .databank 0

      rsUnknown80A7F3 ; 80/A7F3

        .as
        .autsiz
        .databank ?

        rep #$30
        jsl $91EBC9
        lsr a
        lsr a
        sta $04A4,b

        txa
        asl a
        asl a
        asl a
        asl a
        clc
        adc $04A4,b
        sec
        sbc #80
        bcc +

        cmp #100
        bcc ++

        lda #100
        bra ++

        +
        lda #0

        +
        sta $04A4,b
        sep #$30
        ldy #0
        tyx

          _Loop
          lda aRNArray,b,x
          cmp $04A4,b
          bcs +

            txa
            sta aRNArray,b,y

          +
          inc y
          cpy #$37
          bne _Loop

        rep #$30
        rts

        .databank 0

        ; 80/A836























      rlUnknown80C35D ; 80/C35D

        .al
        .autsiz
        .databank ?

        plp
        sep #$20
        lda #3
        sta BGMODE,b
        sta bBufferBGMODE
        lda #0
        sta BG1SC,b
        sta bBufferBG1SC
        sta BG2SC,b
        sta bBufferBG2SC
        rep #$20

        lda #$2000 >> 1
        sta wR1
        sta wR2
        lda #$0000 >> 1
        sta wR3
        sta wR4
        lda #$0000 >> 1
        sta wR5
        lda #$E000 >> 1
        sta wR6
        sta wR7
        lda #$0000 >> 1
        sta wR8
        jsl rlSetLayerPositionsAndSizes
        plp
        rtl

        .databank 0

        ; 80/C39A






      aASMapSpriteCode ; 81/89E0


; 0F rsActiveSpriteCommand0F

; 88 88 98 9D A0 11 A9 01 00 9D 80 11 22 F3 89 81 68 60 8B BD E0 12 89 00 40 F0 44 AE BE 17 BD C4 17 C9 FF FF F0 39 22 FE D7 88 BD D4 17 38 ED 98 05 C9 C0 FF B0 05 C9 40 01 B0 24 18 65 00 85 00 BD DC 17 38 ED 9A 05 C9 F0 FF B0 05 C9 00 01 B0 0E 18 65 02 85 02 BD 04 18 85 0A 22 C7 87 80 AB 6B 00 00 00 00 00 00 00 00 B9 00 13 C9 09 00 D0 05 A9 08 00 80 10 BD FC 17 C9 08 00 90 08 A9 04 00 80 03 A9 06 00 60 B9 E0 12 89 10 00 F0 0B 20 98 8C 90 06 22 76 8B 81 38 60 20 BF 8C B9 20 13 F0 02 18 60 84 27 BD E4 17 85 24 BD EC 17 85 25 BD F4 17 A8 B7 24 29 FF 00 C9 80 00 D0 06 22 76 8B 81 38 60 89 80 00 F0 2E 5A 29 7F 00 0A A8 B9 C6 8A 85 2A B9 C7 8A 85 2B 7A C8 22 C3 8A 81 90 D3 60 6C 2A 00 76 8B 5D 8B F0 8B F9 8B 13 8C 5D 8C 62 8C 67 8C 6C 8C A0 01 00 84 00 A4 27 C9 0A 00 90 17 E9 09 00 48 5A C8 BD F4 17 1A 9D F4 17 A8 B7 24 29 FF 00 85 00 7A 68 C9 09 00 F0 1D D9 00 13 F0 18 48 3A 0A 0A 0A 9F 11 09 00 A9 00 00 9F F1 08 00 A9 00 00 9F 01 09 00 68 99 00 13 BD F4 17 1A 9D F4 17 DA 20 4A 8A AA BF 54 8B 81 29 FF 00 EB 05 00 22 43 99 91 99 20 13 FA B9 00 13 C9 04 00 F0 06 A9 01 00 99 80 11 A9 00 00 99 40 13 18 60 80 80 40 20 10 08 04 02 01 5A 98 9D F4 17 BD C4 17 A8 B9 E0 12 29 FF 7F 99 E0 12 22 58 8D 81 7A 38 6B 5A BD C4 17 A8 20 91 8B A9 FF FF 9D C4 17 A9 00 00 99 00 11 22 58 8D 81 7A 38 6B B9 E0 12 89 0E 00 F0 56 DA 5A 89 08 00 D0 0A BD CC 17 AA 22 83 CB 84 80 43 BD 14 18 85 02 BD D4 17 85 04 BD DC 17 85 06 DA BD CC 17 AA A5 04 9F 3B 45 7E A5 06 9F CB 45 7E DA 22 6E C7 84 FA 9F 5B 46 7E FA BD 04 18 EB 4A 3A 09 80 00 29 BF FF 85 00 BD CC 17 AA A5 00 9F 8B 43 7E 7A FA 60 A9 00 00 9D F4 17 A8 18 6B B7 24 9D E4 17 48 C8 B7 24 9D EC 17 85 25 68 85 24 A9 00 00 9D F4 17 A8 18 6B DA B7 24 29 FF 00 9D FC 17 0A 85 00 C8 98 9D F4 17 BD C4 17 A8 A6 00 BF 45 8C 81 99 80 13 BF 51 8C 81 99 A0 13 A9 09 00 99 00 13 FA BD F4 17 A8 18 6B 00 00 00 20 00 40 00 80 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 00 A9 01 00 80 0D A9 02 00 80 08 A9 03 00 80 03 A9 04 00 85 00 98 9D F4 17 BD C4 17 A8 A5 00 48 3A 0A 0A 0A 9F 11 09 00 A9 00 00 9F F1 08 00 A9 00 00 9F 01





      rlUnknown818C5D ; 81/8C5D

        .al
        .autsiz
        .databank ?

        lda #1
        bra +

      rlUnknown818C62 ; 81/8C62

        .al
        .autsiz
        .databank ?

        lda #2
        bra +

      rlUnknown818C67 ; 81/8C67

        .al
        .autsiz
        .databank ?

        lda #3
        bra +

      rlUnknown818C6C ; 81/8C6C

        .al
        .autsiz
        .databank ?

        lda #4

        +
        sta wR0

        tya
        sta aMovingMapSprites.wPathScriptOffset,b,x

        lda aMovingMapSprites.wActiveSpriteOffset,b,x
        tay

        lda wR0
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
        sta aActiveSpriteSystem.aUnknown001300,b,x
        sec
        rtl

        .databank 0

      rlUnknown818FA1 ; 81/8FA1

        .al
        .autsiz
        .databank ?

        ; wR0 = CharacterID
        ; wR1 = movement speed
        ; wR2 = spawn X coord
        ; wR3 = spawn y coord
        ; wR4 = dest X coordinate
        ; wR5 = dest Y coordinate
        ; wR6 = sprite color
        ; wR7 = 0 or 1 ?

        phx
        phx
        jsr rsCapSpawnDestinationCoordinates100

        lda wR0
        pha
        lda wR1
        pha
        lda wR2
        pha
        lda wR3
        pha
        lda wR4
        pha
        lda wR5
        pha
        lda wR6
        pha

        lda wR7
        sta wR6

        lda wR0
        sta wRoutineVariable1,b
        txa
        lsr a
        sta aMovingMapSprites.wEntryIndex,b

        lda wR0
        sta aMovingMapSprites.wCharacterID,b
        lda wR2
        sta aMovingMapSprites.wSpawnXCoordinate,b
        lda wR3
        sta aMovingMapSprites.wSpawnYCoordinate,b
        lda wR4
        sta aMovingMapSprites.wDestinationXCoordinate,b
        lda wR5
        sta aMovingMapSprites.wDestinationYCoordinate,b
        lda wR6
        sta aMovingMapSprites.wUnknown001830,b
        lda #1
        sta aMovingMapSprites.wState,b

        pla
        sta wR6
        pla
        sta wR5
        pla
        sta wR4
        pla
        sta wR3
        pla
        sta wR2
        pla
        sta wR1
        pla
        sta wR0
        plx

        phx
        lda #(`aMovingMapSpriteData)<<8
        sta lR18+1

        txa
        lsr a
        ora #len(aMovingMapSpriteData[0]) << 8
        jsl rlUnsignedMultiply8By8
        clc
        adc #<>aMovingMapSpriteData
        sta lR18
        jsr rsFillMovingMapSpriteData
        plx

        phx
        lda #(`aEventMovement.aMovementScriptBuffer1)<<8
        sta lR19+1
        pla
        lsr a
        xba
        asl a
        clc
        adc #<>aEventMovement.aMovementScriptBuffer1
        sta lR19
        jsr rsFillMovingMapSpriteDataPathScriptPointer
        plx
        rtl

        .databank 0

      rsFillMovingMapSpriteDataPathScriptPointer ; 81/90BF

        .al
        .autsiz
        .databank ?

        ldy #6
        lda lR19
        sta [lR18],y
        inc y
        lda lR19+1
        lda [lR18],y
        rts

        .databank 0

        ; 81/90CC


























      rsGetActiveFactionSongID ; 81/AA00

        .al
        .autsiz
        .databank ?

        ; Returns CLC if faction name out of bounds or phase has no faction name assigned
        ; Returns SEC if phase song found

        lda wActiveFactionSlot,b
        bne +

          jsl rlGetVictoryThemeIfAllEnemiesDead
          bcs _SEC

            lda wCurrentChapter,b
            asl a
            tax
            lda aPlayerPhaseChapterSongIDs
            bra _SEC

        +
        ldx #0
        jsl rlGetFactionRelation
        cmp #AllegianceNeutral
        beq _NPC

          cmp #AllegianceOther
          beq _Yellow

            lda wActiveFactionSlot,b
            jsl rlGetFactionSlotNameID
            bit #$0080
            bne _CLC

              asl a
              cmp #53 * size(word)
              bcs _CLC

                tax
                lda aNonPlayerFactionPhaseSongIDs,x
                bra _SEC

          _NPC
          lda #$001D
          bra _SEC

        _Yellow
        lda #$002A

        _SEC
        sec

        -
        rts

        _CLC
        clc
        bra -

        .databank 0

      rsUnknown81AB90 ; 81/AB90

        .al
        .autsiz
        .databank ?

        ; Handle turn start healing animations?

        lda $7E2002
        beq _ABF1

          lda $7E2000
          tax
          clc
          adc #5
          lda $7E2000

          lda $7E2006,x
          and #$00FF
          sta $0ECF,b

          lda $7E2007,x
          and #$00FF
          xba
          ora $0ECF,b
          sta $0ECF,b

          lda $7E2008
          and #$00FF
          sta $0ED1,b

          lda $7E2005
          and #$00FF
          sta $0ED3,b

          lda $7E2004
          and #$00FF
          sta $0ED5,b

          lda #(`$85CA85)<<8
          sta $62+1
          lda #<>$85CA85
          sta $62
          jsl rlProcEngineCreateProc

          lda $7E2002
          dec a
          sta $7E2002
          rts

        _ABF1
        jsl $85C0D5

        lda #$0004
        tsb $0788,b

        jsr rsUnknown81AC02
        inc $0304,b
        rts

        .databank 0

      rsUnknown81AD28 ; 81/AD28

        .al
        .autsiz
        .databank ?

        jsl rlCreateUnitWindowAndTerrainWindowProcs

        lda $0D77,b
        cmp #3
        beq ++

          cmp #1
          beq +

            lda #(`procFadeIn)<<8
            sta lR44+1
            lda #<>procFadeIn
            sta lR44
            lda #0
            jsl rlProcEngineCreateProcByIndex
            bra ++

          +
          sep #$20
          lda bBufferINIDISP
          ora #15
          sta bBufferINIDISP
          rep #$20

        +
        jsl rlUnknown81B189
        bcc +

          ldx $0772,b
          jsl rlDeployedUnitUnsetHiddenIfAlive

        +
        lda $0D7B,b
        inc $0304,b
        rts

        .databank 0

      rlUnknown81ADD8 ; 81/ADD8

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb

        lda wUnknown00171A,b
        bmi _CLC

          lda wUnknownDeploymentOffset000D7F,b
          bmi _CLC

            tax
            lda aDeploymentTable._UnitRAMPointer,x
            sta wSelectedUnitDataRAMPointer,b

            lda $0D81,b
            bmi _CLC

              asl a
              tax
              jsr (aUnknown81AE02,x)

              lda #$FFFF
              sta wUnknownDeploymentOffset000D7F,b
              bra +

        _CLC
        clc
        
        +
        plb
        rtl

        .databank 0

      rsUnknown81AE96 ; 81/AE96

        .al
        .autsiz
        .databank ?

        lda $0580,b
        pha

        lda wUnknownDeploymentOffset000D7F,b
        sta $0D83,b
        jsl rlSetUnitResidingInCastle

        pla
        sta $0580,b

        sec
        rts

        .databank 0

      rsUnknown81AFB7 ; 81/AFB7

        .al
        .autsiz
        .databank ?

        lda wUnknown000D79,b
        bit #$0400
        bne +

          ldx wUnknownDeploymentOffset000D7F,b
          lda #1
          sta wEventEngineParameter3+1,b
          lda $0D83,b
          sta wEventEngineParameter4+1,b
          jsl $85BB2E

        +
        sec
        rts

        .databank 0

      rsUnknown81AFD4 ; 81/AFD4

        .al
        .autsiz
        .databank ?

        lda $0D8D,b
        bmi _CLC

          jsl rlUnknown888410

          lda $0D8D,b
          sta wEventEngineParameter3+1,b
          lda #$0D00
          sta wEventEngineParameter4+1,b
          jsl $85B8D6

          lda #$FFFF
          sta $0D8D,b
          sec
          bra +

        _CLC
        clc
        
        +
        rts

        .databank 0

        ; 81/AFF8





      rlASMCShowItemPopUpBox ; 81/B223

        .al
        .autsiz
        .databank ?

        lda wUnknownDeploymentOffset000D7F,b
        bmi _End

          lda $0D81,b
          cmp #8
          bne _End

            lda $0D83,b
            jsl rlGetItemRAMStructEntryByPlayerItemIndex
            jsl rlGetEffectiveItemIDByItemRAMStructEntry
            sta aProcSystem.wInput2,b

            lda #$0D00
            sta aProcSystem.wInput3,b
            lda #(`procUnknown85BC0F)<<8
            sta lR44+1
            lda #<>procUnknown85BC0F
            sta lR44
            jsl rlEventEngineCreateProc

            lda #$FFFF
            sta wUnknownDeploymentOffset000D7F,b

        _End
        rtl

        .databank 0

      rlGetChapterTalkEventsPointer ; 81/B4E4

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy

        lda $0DD6,b
        sta lR18+1

        ldy lChapterEventDataPointer,b
        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        lda structChapterEventData.TalkEventsPointer,b,y
        sta lR18

        ply
        plp
        plb
        rtl

        .databank 0

        ; 81/B503












      rlProcDialogueInit ; 82/8469

        .al
        .autsiz
        .databank ?

        lda #8
        sta aProcSystem.aBody0,b,x

        jsl rlResetDialogueEngine

        ldy wActiveEventOffset,b
        lda lActiveEventPointer,b
        sta lR22
        lda lActiveEventPointer+1,b
        sta lR22+1

        lda [lR22],y
        sta lR18
        inc y
        lda [lR22],y
        sta lR18+1
        jsl rlUnknown828653

        lda wEventUnit1Pointer,b
        jsl rlUnknown828A1C
        sta aDialogue.wUnit1,b

        lda wEventUnit2Pointer,b
        jsl rlUnknown828A1C
        sta aDialogue.wUnit2,b

        lda #5
        sta $7FC54A
        lda #11
        sta $7FC54C
        lda #21
        sta $7FC5AE
        lda #11
        sta $7FC5B0

        lda bBufferINIDISP
        and #$000F
        cmp #$000F
        bne _End

          lda #(`procFadeIn)<<8
          sta lR44+1
          lda #<>procFadeIn
          sta lR44
          jsl rlProcEngineFindProc
          bcs _End

            lda #(`procFadeIn)<<8
            sta lR44+1
            lda #<>procFadeIn
            sta lR44
            jsl rlProcEngineCreateProc

        _End
        rtl

        .databank 0

      rsUnknown82862E ; 82/862E

        .al
        .autsiz
        .databank ?

        ; Sets the position of the A press arrow based on the currently active slot

        ldx #$00E8
        ldy #$0038

        lda aDialogue.wSlotOffset,b
        beq +

          ldx #$00E0
          ldy #$00C8

        +
        stx wR0
        sty wR1
        jsl rlDisplayDialogueAPressArrows
        rts

        .databank 0

        ; 82/8648







      rlUnknown828653 ; 82/8653

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lR18 = dialogue pointer

        php
        jsl rlFreeHDMAEntry0

        lda #1
        jsl rlUnknown91811C

        lda #1
        sta aDialogue.wTextSound,b
        jsl rlUnknown91A928

        ldx #0
        jsl rlUnknown919420._944B

        lda #$0019
        jsl rlUnknown919420._944B

        lda #4
        sta wBufferBG3HOFS
        sep #$20
        lda #$06
        tsb bBufferTM
        lda #0
        sta bBufferCGWSEL
        lda #$91
        sta bBufferCGADSUB
        lda #0
        sta bBufferCOLDATA_0
        jsl rlApplyCOLDATA0Intensity
        plp
        rtl

        .databank 0

      rsUnknown828E61 ; 82/8E61

        .al
        .autsiz
        .databank ?

        php
        rep #$30
        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody1,b,x
        xba
        sta lR18+1
        lda aProcSystem.aBody0,b,x
        sta lR18
        ldy aProcSystem.aBody2,b,x

        lda [lR18],y
        cmp #$00FF
        beq _CLC

          lda [lR18],y
          sta aProcSystem.aBody7,b,x
          inc y
          inc y
          lda [lR18],y
          sta aProcSystem.aBody3,b,x
          sta wR13
          inc y
          inc y
          lda [lR18],y
          sta aProcSystem.aBody3,b,x
          sta wR14

          lda aProcSystem.aBody7,b,x
          cmp #8
          bne +

            stz aProcSystem.aBody4,b,x

          +
          inc y
          inc y
          tya
          sta aProcSystem.aBody2,b,x
          lda #0
          sta wR12
          sta wR15
          jsl $80A1D8

          lda wR12
          sta $175F,b
          lda wR13
          sta $1761,b
          ldx aProcSystem.wOffset,b
          lda #0
          sta aProcSystem.aBody5,b,x
          sta aProcSystem.aBody6,b,x
          plp
          sec
          rts

        _CLC
        plp
        clc
        rts

        .databank 0

      rsUnknown82932C ; 82/932C

        .al
        .autsiz
        .databank ?

        php
        lda aProcSystem.aBody2,b,x
        beq _SEC

          cmp #$00FF
          beq +

            dec a
            sta aProcSystem.aBody2,b,x

          +
          lda lActiveEventPointer,b
          sta aProcSystem.aBody3,b,x
          lda wActiveEventOffset,b
          sta aProcSystem.aBody4,b,x
          jsr rsUnknown829391

          ldy #0
          sty wActiveEventOffset,b
          lda lActiveEventPointer+1,b
          sta lR22+1
          lda aProcSystem.aBody0,b,x
          sta lActiveEventPointer,b
          sta lR22
          phx

          lda [lR22],y
          sta lR23
          inc y
          inc y
          sty wActiveEventOffset,b
          jsl rlUnknown91C6D8

          txa
          plx
          lda aProcSystem.aBody3,b,x
          sta lActiveEventPointer,b
          lda aProcSystem.aBody4,b,x
          sta wActiveEventOffset,b
          lda lActiveEventPointer+1,b
          sta lR22+1
          lda lActiveEventPointer,b
          sta lR22
          plp
          clc
          rts

        _SEC
        plp
        sec
        rts

        .databank 0

      rlFindCharacterByGenerationID ; 84/8726

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = GenerationID

        ; Output:
        ; CLC if successful
        ; Filled wSelectedUnitDataRAMPointer

        phb
        phx
        phy
        ldx wR34
        phx
        ldx wR35
        phx

        sta wR34

        sep #$20
        lda #`aUnitRAMPointers
        pha
        rep #$20
        plb
        .databank `aUnitRAMPointers

        lda aUnitRAMPointers._Entry[0],x
        and #$00FF
        asl a
        sta wR35

        ldx #0

          -
          lda aUnitRAMPointers._Entry[0],x
          sta wSelectedUnitDataRAMPointer,b
          tay
          lda structCharacterDataRAM.Type,b,y
          and #$00FF
          cmp #UnitTypeHoly
          bcs +

            jsl rlGetSelectedUnitGenerationID
            cmp wR34
            beq _CLC

          +
          inc x
          inc x
          cpx wR35
          bcc -

        stz wSelectedUnitDataRAMPointer,b
        sec

        -
        pla
        sta wR35
        pla
        sta wR34
        ply
        plx
        plb
        rtl

        _CLC
        clc
        bra -

        .databank 0

      rsUnknown8488AE ; 84/88AE

        .al
        .autsiz
        .databank ?

        ; Input:
        ; wR0 = ?

        ; Output:
        ; SEC if a new unit was deployed

        ldx #size(aDeploymentTable._UnitRAMPointer)

        _Loop
        lda aDeploymentTable._UnitRAMPointer,x
        beq _Next

          cmp #$2000
          bge _Next

            cmp wR0
            bne _Next

              lda wSelectedUnitDataRAMPointer,b
              sta aDeploymentTable._UnitRAMPointer,x
              jsl rlDeployedUnitUnsetHiddenIfAlive
              bra +

        _Next
        dec x
        dec x
        bpl _Loop

        clc
        rts

        +
        txa
        jsl rlSetSelectedUnitDeploymentOffset
        lda #UnitStateFielded
        jsl rlSetSelectedUnitStates
        jsl rlGetSelectedUnitFactionSlot
        sta aDeploymentTable._FactionSlot,x
        stx wRoutineVariable1,b
        sec
        rts

        .databank 0

        ; 84/88EC

























; Ishtore Death Quote $8EEA40


; 07 
; 00 3D OpenBox
; 00 3F LoadPortrait
; 52 02 
; 09 StartText

; 86 
; 61 
; 92 
; BF 
; BF 
; BF 

; 0A 
; AA 
; 09 
; 29 
; BF 
; BF 
; BF 

; 02 NewLine

; 00 1D C8  PauseText $C8

; 01 EndText 



; EA5A
; 07 
; 00 3D OpenBox
; 00 3F LoadPortrait
; 52 02 
; 09 

; 86 
; 61 
; 92 
; BF 
; BF 
; BF 

; 02 NewLine

; 10 23 29 
; 1F 28 3D 0A 18 09 48 47 BF BF BF 


; 02 NewLine
; 00 1D C8 PauseText $C8
; 01 EndText









































      rsGetChurchHealing ; 84/B094

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitDeploymentOffset
        jsl rlGetTerrainTypeByDeploymentOffset
        cmp #TerrainChurch
        beq +
        
          _CLC
          clc
          rts

        +
        jsl rlGetSelectedUnitCurrentHP
        sta wRoutineVariable1,b

        jsl rlGetSelectedUnitMaxHP
        sec
        sbc wRoutineVariable1,b
        sta wRoutineVariable1,b
        jsr $84B0F0
        bcs _CLC

        jsl rlSubtractSelectedCharacterMoney
        sta wRoutineVariable1,b

        ldy #2
        jsr rsUnknown84B148
        sec
        rts

        .databank 0

      rlLoadMapMenuDataFromProc ; 85/8280

        .al
        .autsiz
        .databank ?

        jsl rlUnknown8780DF

        lda $0000+size(structProcInfo),b,y
        sta lR18
        lda $0001+size(structProcInfo),b,y
        sta lR18+1
        jsl rlLoadMapMenuData

        lda lMapMenuRAMEntryPointer,b
        sta aProcSystem.aBody0,b,x
        lda lMapMenuRAMEntryPointer+2,b
        and #$00FF
        sta aProcSystem.aBody1,b,x
        rtl

        .databank 0

        ; 85/82A1








      rlProcCycleMapMenuWaitForPaletteGraphicFinish ; 85/8366

        .al
        .autsiz
        .databank ?

        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl rlHandleMapMenuPaletteGraphicsData
        bcc +

          rtl

        +
        lda aProcSystem.aBody2,b,x
        sta aProcSystem.aHeaderOnCycle,b,x
        sta wR40
        jmp (wR40)

        .databank 0

        ; 85/837C




      aDialogueBoxTilemap .text ROM[$058000:$058250] ; 85/8000

      rsMapMenuTypeDialogue ; 85/8CD3

        .al
        .autsiz
        .databank ?

        phy
        jsl rlBuildMapMenuDialogueBox

        lda aProcSystem.wInput0,b
        bmi _End
        bne _Bottom

          ; Copy the 2x2 dialogue box tail to the correct spot

          ; Top
          jsl rlGetMapMenuTileIndex
          clc
          adc #C2I((8, 10), 32) * size(word)
          tax

          ; Load downwards facing tail
          ldy #TilemapEntry(C2I((10, 2)) + C2I((0, 48)), 0, true, false, false) 
          bra +

          _Bottom
          jsl rlGetMapMenuTileIndex
          clc
          adc #C2I((0, 18), 32) * size(word) ; $0024
          tax

          ; Load upwards facing tail
          ldy #TilemapEntry(C2I((8, 2)) + C2I((0, 48)), 0, true, false, false) 

          +
          tya
          sta aBG2TilemapBuffer.Page1,x
          tya
          inc a
          sta aBG2TilemapBuffer.Page1+2,x
          tya
          clc
          adc #C2I((0, 1))
          sta aBG2TilemapBuffer.Page1+$40,x
          tya
          clc
          adc #C2I((1, 1))
          sta aBG2TilemapBuffer.Page1+$40+2,x
        
        _End
        ply
        rts

        .databank 0

        ; 85/8D18




      aDialogueBoxMapMenuData ; 85/9BDA

        .structMapMenu None, None, aDialogueBoxMapMenuTilemapData, 7, [1, 1]



; lands at 7ffcf0

; .long 0
; .long 0
; .long $859BD1
; .byte 7 ; index for aUnknown8589B5
; .byte 1
; .byte 1

; size 12

      aUnknown85ABFE ; 85/ABFE

        .word 0
        .word 1

      rlBuildMapMenuDialogueBox ; 85/B81D

        .al
        .autsiz
        .databank ?

        phy
        phx
        jsl rlGetMapMenuTilemapArea
        and #$00FF
        sta wR5
        cmp #32
        beq _FullWidth

        lda aProcSystem.wInput0,b
        bne _Bottom

        ; Top
        lda #32
        sec
        sbc wR5
        pha
        sta wR13
        lda #3
        sta wR14
        jsl rlUnsignedDivide16By8
        pla
        lsr a
        sta wR10

        lda wR13
        sec
        sbc wR10
        bra _B870

        _FullWidth
        lda #0
        bra _B870

        _Bottom
        lda #32
        sec
        sbc wR5
        pha
        sta wR13
        lda #3
        sta wR14
        jsl rlUnsignedDivide16By8
        pla
        lsr a
        sta wR10
        lda wR13
        asl a
        sec
        sbc wR10

        _B870
        ; Get the middle of the box as the destination tile
        asl a
        sta wR3
        jsl rlGetMapMenuTileIndex
        clc
        adc #size(aDialogueBoxTilemap)-2
        sec
        sbc #32
        clc
        adc wR5
        clc
        adc wR3
        sta wR7

        ; Source offset
        lda #size(aDialogueBoxTilemap)-2
        sta wR6

          _Loop
          ; Write the right part to the tilemap
          lda wR6
          tay

          lda wR5
          lsr a
          dec a
          sta wR4
          ldx wR7
          jsr rsDialogueBoxWriteToBG2

          ; Write the left part to the tilemap
          lda wR6
          sec
          sbc #32 * size(word)
          clc
          adc wR5
          tay

          lda wR5
          lsr a
          dec a
          sta wR4
          jsr rsDialogueBoxWriteToBG2

          lda wR7
          sec
          sbc #32 * size(word)
          sta wR7
          lda wR6
          sec
          sbc #32 * size(word)
          sta wR6
          bpl _Loop

        plx
        ply
        rtl

        .databank 0

      rsDialogueBoxWriteToBG2 ; 85/B8C2

        .al
        .autsiz
        .databank $85

        ; Y = source offset
        ; X = destination offset
        ; wR4 = count

          _Loop
          lda aDialogueBoxTilemap,y
          clc
          adc #$0300
          sta aBG2TilemapBuffer.Page1,x
          dec x
          dec x
          dec y
          dec y
          dec wR4
          bpl _Loop

        rts

        .databank 0

        ; 85/B8D6











      aUnknown85B8EE ; 85/B8EE

        .long 0
        .long 0
        .long $85B8E5

        ; 00 01 01 50 57 06




      procUnknown85BC0F .structProcInfo "PW", rlProcUnknown85BC0FInit, rlProcUnknown85B9D4Cycle1, $858398 ; 85/BC0F

        .long $85B8EE
        .byte 1

      rlUnknown8780AA ; 87/80AA

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        ldx #$0029
        sep #$20
        lda #0

          -
          sta $0516,b,x
          dec x
          bpl -

        rep #$20

        lda bBufferBG3SC
        and #BGSC_Address
        xba
        sta $0516,b
        lda #(`aBG3TilemapBuffer)<<8
        sta $0519,b
        lda #<>aBG3TilemapBuffer
        sta $0518,b
        lda #0
        sta $053E,b
        jsl $87828D
        plp
        plb
        rtl

        .databank 0

      rlUnknown87819A ; 87/819A

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx
        phy

        tax
        lda lUnknown000522,b
        ora lUnknown000522+1,b
        beq _SEC

        lda lUnknown000522,b
        sta $000000,x
        lda lUnknown000522+1,b
        sta $000000+1,x
        
          _Loop
          lda $000000,x
          tay
          sep #$20
          lda $000000+2,x
          pha
          rep #$20
          plb

          lda $000C,b,y
          ora $000C+1,b,y
          beq _CLC

          lda $000C,b,y
          sta $000000,x
          lda $000C+1,b,y
          sta $000000+1,x
          bra _Loop

        _CLC
        ply
        plx
        plp
        plb
        clc
        rtl
        
        _SEC
        ply
        plx
        plp
        plb
        sec
        rtl

        .databank 0

      rlLoadMapMenuTilemapData ; 87/8232

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lR18 = map menu tilemap data source

        ; Output:
        ; lR25 = RAM entry pointer

        phb
        php
        phk
        plb
        phx

        lda #size(structMapMenuTilemapData)
        jsl rlAllocateRAMArea

        lda #size(structMapMenuTilemapData)
        ldx #lR18
        jsl rlCopyDataToRAMArea

        lda lR25
        sta lMapMenuTilemapRAMEntryPointer,b
        lda lR25+1
        sta lMapMenuTilemapRAMEntryPointer+1,b
        plx
        plp
        plb
        rtl

        .databank 0

        ; 87/8256


















      procUnknown85B18F .structProcInfo "PW", rlProcUnknown85B18FInit, rlProcUnknown85B18FCycle1, $85B2D8 ; 85/B18F

        ; 85/B197


      rlGetMapMenuTilemapRAMEntryPointer ; 87/87B5

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy

        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda structMapMenu.TilemapDataPointer,b,y
        sta lMapMenuTilemapRAMEntryPointer
        lda structMapMenu.TilemapDataPointer,b,y
        sta lMapMenuTilemapRAMEntryPointer+1

        ply
        plp
        plb
        rtl

        .databank 0

      rlReplaceMapMenuTilemapROMWithRAMPointer ; 87/87D8

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda lMapMenuTilemapRAMEntryPointer,b
        pha
        lda lMapMenuTilemapRAMEntryPointer+1,b
        pha
        lda lR18
        pha
        lda lR18+1
        pha
        phy

        ldy lMapMenuRAMEntryPointer,b
        sep #$20
        lda lMapMenuRAMEntryPointer+2,b
        pha
        rep #$20
        plb

        lda structMapMenu.TilemapDataPointer,b,y
        sta lR18
        lda structMapMenu.TilemapDataPointer+1,b,y
        sta lR18+1

        lda lMapMenuTilemapRAMEntryPointer
        sta structMapMenu.TilemapDataPointer,b,y
        lda lMapMenuTilemapRAMEntryPointer+1
        sta structMapMenu.TilemapDataPointer,b,y

        lda lR18
        sta lMapMenuTilemapRAMEntryPointer
        lda lR18+1
        sta lMapMenuTilemapRAMEntryPointer+1
        jsl rlRemoveMapMenuTilemapRAMEntry

        ply
        pla
        sta lR18+1
        pla
        sta lR18
        pla
        sta lMapMenuTilemapRAMEntryPointer+1
        pla
        sta lMapMenuTilemapRAMEntryPointer
        plp
        plb
        rtl

        .databank 0

        ; 87/8833






      rlHandleMapMenuDecompressionDMA ; 87/8979

        .al
        .autsiz
        .databank $00

        phb
        php
        phk
        plb
        phx
        phy
        lda bUnknown0536,b
        and #$00FF
        beq _Free

          lda #7,s
          cmp lUnknown0537,b
          bne +

            lda #7+1,s
            cmp lUnknown0537+1
            bne +

              lda bUnknown0536,b
              bit #$0001
              bne _8A17

              bit #$0002
              beq +

                jml _8A98

          +
          ply
          plx
          plp
          plb
          sec
          rtl

        _Free ; 87/89AC
        lda #7,s
        sta lUnknown0537,b
        lda #7+1,s
        sta lUnknown0537+1,b
        lda bUnknown0536,b
        ora #$0080
        sta bUnknown0536,b

        ldy lR19
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb

        lda $0004,b,y
        and #$00FF
        beq _CheckDMA

          ldx wDecompressionArrayPosition,b
          lda $0005,b,y
          sta aDecompressionArray + structDecompressionEntry.Source,b,x
          lda $0005+1,b,y
          sta aDecompressionArray + structDecompressionEntry.Source+1,b,x
          lda #<>aDecompressionBuffer
          sta aDecompressionArray + structDecompressionEntry.Dest,b,x
          lda #`>aDecompressionBuffer
          sta aDecompressionArray + structDecompressionEntry.Dest+1,b,x
          lda #0
          sta aDecompressionArray + size(structDecompressionEntry),b,x
          sta aDecompressionArray + size(structDecompressionEntry)+1,b,x
          txa
          clc
          adc #size(structDecompressionEntry)
          sta wDecompressionArrayPosition,b
          sep #$20
          lda #1
          sta bDecompressionArrayFlag,b

          lda bBufferINIDISP
          bpl +

            jsl rlDecompressByList

          +
          rep #$20
          lda bUnknown0536,b
          ora #$0001
          sta bUnknown0536,b

          _8A17
          lda bDecompressionArrayFlag,b
          and #$00FF
          beq _CheckDMA

            ply
            plx
            plp
            plb
            sec
            rtl

        _CheckDMA ; 87/8A25
        sep #$20
        lda lR19+2
        pha
        rep #$20
        plb
        ldy lR19

        ldx wDMAArrayPosition,b
        sep #$20
        lda #DMAToVRAM
        sta aDMAArray + structDMAToVRAM.TransferType,b,x
        rep #$20

        lda $0004,b,y
        bne +

          lda $0005,b,y
          sta aDMAArray + structDMAToVRAM.Source,b,x
          lda $0005+1,b,y
          sta aDMAArray + structDMAToVRAM.Source+1,b,x
          bra ++

        +
        lda #<>aDecompressionBuffer
        sta aDMAArray + structDMAToVRAM.Source,b,x
        lda #`>aDecompressionBuffer
        sta aDMAArray + structDMAToVRAM.Source+1,b,x

        +
        lda $0000,b,y
        sta aDMAArray + structDMAToVRAM.Count,b,x

        sep #$20
        lda #$80
        sta aDMAArray + structDMAToVRAM.Mode,b,x
        rep #$20

        lda $0002,b,y
        sta aDMAArray + structDMAToVRAM.Destination,b,x
        lda #0
        sta aDMAArray + size(structDMAToVRAM),b,x
        txa
        clc
        adc #size(structDMAToVRAM)
        sta wDMAArrayPosition,b
        sep #$20
        lda #1
        sta bDMAArrayFlag,b

        lda bBufferINIDISP
        bpl +

          jsl rlProcessDMAStructArray

        +
        lda bUnknown0536,b
        and #~$01
        ora #$02
        sta bUnknown0536,b
        rep #$20

        _8A98
        lda bDMAArrayFlag,b
        and #$00FF
        beq _CLC

          ply
          plx
          plp
          plb
          sec
          rtl

        _CLC
        lda bUnknown0536,b
        and #$FF00
        sta bUnknown0536,b
        ply
        plx
        plp
        plb
        clc
        rtl

        .databank 0

        ; 87/8AB5
























      rlUnknown87A040 ; 87/A040

        .al
        .autsiz
        .databank ?

        ; Check if selected unit alive in home castle.

        phx
        ldx wSelectedUnitDataRAMPointer,b
        phx
        ldx wRoutineVariable1,b
        phx

        jsl rlGetUnitRAMDataPointerByID
        bcs _CLC

          jsl rlGetSelectedUnitStates
          bit #(UnitStateFielded | UnitStateDead)
          bne _CLC

            jsl rlGetSelectedUnitFactionSlot
            ora #FS_Player
            bne _CLC

              lda #0
              jsl rlGetFactionSlotLocationID
              sta wRoutineVariable1,b

              jsl rlGetSelectedUnitHomeCastle
              cmp wRoutineVariable1,b
              bne _CLC

                sec
                bra +

        _CLC
        clc

        +
        pla
        sta wRoutineVariable1,b
        pla
        sta wSelectedUnitDataRAMPointer,b
        plx
        rtl

        .databank 0

        ; 87/A082




      procUnknown828BEA 

        .structProcInfo "CC", rlProcUnknown828BEAInit, rlProcUnknown828BEACycle, $828CA1 ; 82/8BEA
        .word 0

      rsUnknown87B5DD ; 87/B5DD

        .al
        .autsiz
        .databank $7F

        ldx #64 - 2
        lda #$FFFF
        
          -
          sta $894A,b,x
          sta $899A,b,x + 64
          sta $899A,b,x + (64 * 2)
          sta $899A,b,x + (64 * 3)
          dec x
          dec x
          bpl -

        lda #32
        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        clc
        adc #32
        tay

        lda $18
        sep #$20
        sta aMovementMap,y
        rep #$20
        sta $04
        asl a
        tax
        lda #$0100
        sta $894A,b,x

        lda #$FFFF
        sta $894A,b + $100
        tya
        sta $894A,b + $102

        lda #$0104
        sta $06
        
          -
          lda $04
          cmp #7
          bcc _End

            asl 
            tax
            
              -
              lda $894A,b,x
              bmi +

                tax
                ldy $894A+2,b,x
                jsr $87B63F
                bra -

          +
          dec $04
          bra --
        
        _End
        rts

        .databank 0

        ; 87/B63F













      rsUnknown87B877 ; 87/B877

        .al
        .autsiz
        .databank ?

        ; write vertical boundaries?

        tay
        ldx #64
        
          -
          lda #$00FE
          sep #$20
          sta $65A4,b,y
          rep #$20
          tya
          clc
          adc #64
          tay
          dec x
          bne -

        rts

        .databank 0

      rsUnknown87B88F ; 87/B88F

        .al
        .autsiz
        .databank $7F

        ; write horizonal boundaries?

        asl a
        asl a
        asl a
        asl a
        asl a
        asl a
        tay

        sep #$20
        lda #64
        
          -
          lda #$FE
          sta aRangeMap,y
          inc y
          dec x
          bne -

        rep #$20
        rts

        .databank 0

        ; 87/B8A7











      rlUnknown87FB5E ; 87/FB5E

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        phx
        phy
        ldx #0
        
          _Loop
          lda aFactionArea,x
          tay
          clc
          adc #size(structFactionHeader)
          sta aSave.aFactionEntryOffsets,b,x
          sep #$20

          lda aFactionArea + structFactionHeader.LocationID,y
          cmp #$0F
          bne +

            lda #$FF
            sta aFactionArea + structFactionHeader.LocationID,y

          +
          rep #$20

          inc x
          inc x
          cpx #7 * size(word)
          bne _Loop

        ply
        plx
        plp
        plb
        rtl

        .databank 0

        ; 87/FB94





      procUnknown8292A9 

        .structProcInfo "NP", rlProcUnknown8292A9Init, rlProcUnknown8292A9Init, aProcUnknown8292A9Code ; 82/92A9
        .word 0

      rlFillItemDurabilityData ; 87/FC51

        .al
        .autsiz
        .databank ?

        phb
        php
        sep #$20
        lda #$7E
        pha
        rep #$20
        plb
        .databank $7E

        phx
        lda #PI_IronSword1
        sta lR18
        jsl rlGetItemRAMStructEntryByPlayerItemIndex

          _Loop
          ldx wCurrentItemDataRAMPointer,b
          jsr rsCapItemDurability
          sep #$20
          lda structItemRAMEntry.Durability,b,x
          cmp #63
          bne +

            lda #$FF
            sta structItemRAMEntry.Durability,b,x
            rep #$20

          +
          lda structItemRAMEntry.ItemState,b,x
          and #$00FF
          cmp #ItemStateInventory
          beq +

            cmp #ItemStateSupply
            bne _Next

          +
          lda structItemRAMEntry.OwnerRAMPointer,b,x
          bit #$FE00
          bne _Next

            and #$003F
            jsl rlGetUnitRAMDataPointerByID
            bcs +

              lda wSelectedUnitDataRAMPointer,b
              sta structItemRAMEntry.OwnerRAMPointer,b,x
              bra _Next

          +
          lda #ItemStateUnobtained
          sta structItemRAMEntry.ItemState,b,x
          brk

          _Next
          lda wCurrentItemDataRAMPointer,b
          clc
          adc #size(structItemRAMEntry)
          sta wCurrentItemDataRAMPointer,b
          lda lR18
          inc a
          sta lR18
          cmp #256 + 1
          bne _Loop

        plx
        plp
        plb
        rtl

        .databank 0

      rlUnknown88860B ; 88/860B

        .al
        .autsiz
        .databank ?

        lda #1
        sta wUnknown00073A,b
        sta wMapEnableXScrollFlag,b
        lda wMapEnableYScrollFlag,b

        jsl rlUnknown8886C3
        rtl

        .databank 0

      rsUnknown888BB3 ; 88/8BB3

        .al
        .autsiz
        .databank ?

        ; Grabs the next row of map tiles when scrolling down?

        _Loop
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        tax
        lda $7F0004,x
        and #$DFFF
        sta $05DC,b,y
        plx

        lda wUnknown00075A,b
        bit #$0002
        beq +

          lda $7F6400,x
          and #$03FF
          asl a
          asl a
          asl a
          clc
          adc wR2
          phx
          tax
          lda $7F0004,x
          and #$DFFF
          ora #$2000
          sta $065C,b,x
          plx

        +
        inc x
        inc x
        inc y
        inc y
        cpy #64
        bcc +

          inc wUnknown00072A,b
          ldy #0

        +
        lda aMapData,x
        and wUnknown000596,b
        asl a
        asl a
        asl a
        clc
        adc wR2
        phx
        tax
        lda $7F0000,x
        and #$DFFF
        sta $05DC,b,y
        plx

        lda $075A,b
        bit #$0002
        beq +

          lda $7F6400,x
          and #$03FF
          asl a
          asl a
          asl a
          clc
          adc wR2
          phx
          tax
          lda $7F0000,x
          and #$DFFF
          ora #$2000
          sta $065C,b,y
          plx

        +
        inc y
        inc y
        
        -
        lda wUnknown00072A,b
        beq +

          cpy wR8
          bcs _End
          bra _8C5B

        +
        cpy #64
        bcc _8C5B

          inc wUnknown00072A,b
          ldy #0
          bra -

        _End
        rts
        
        _8C5B
        jml _Loop

        .databank 0

        ; 88/8C5F





























      rlUnknown88A754 ; 88/A754

        .al
        .autsiz
        .databank $00

        lda wUnknown000766,b
        bne _A7BA

          lda wUnknown0007D8,b
          cmp #2
          beq _A788

            cmp #4
            beq _A795

              cmp #5
              beq _A795

                cmp #6
                beq _A795

                  cmp #7
                  beq _A795

                    lda #16
                    sta wMapPixelScrollDistance,b
                    jsr $88A9B4
                    beq _End

                      lda #8
                      sta wMapScrollSpeed,b
                      bra +
          
          _A788
          stz wMapPixelScrollDistance,b
          jsr $88AA1E
          beq _End

            jsr $88A7F5
            bra +

          _A795
          lda #16
          sta wMapPixelScrollDistance,b
          jsr rsUnknown88B64F
          beq _End

            lda #8
            sta wMapScrollSpeed
            bra +

          +
          stz wMapScrollCurrentPixelDistance,b
          lda #1
          sta wUnknown000766,b
          stz wUnknown00073A,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b

        _A7BA
        stz wMapScrollCurrentPixelDistance,b
        clc
        adc wMapScrollSpeed,b
        sta wMapScrollCurrentPixelDistance,b
        cmp wMapPixelScrollDistance,b
        bcc +

          sec
          sbc wMapPixelScrollDistance,b
          sta wR0
          sta wMapScrollSpeed,b
          sec
          sbc wR0
          sta wMapScrollSpeed,b

          stz wUnknown000766,b
          stz wUnknown00073A,b
          stz wMapEnableXScrollFlag,b
          stz wMapEnableYScrollFlag,b
        
        +
        jsl rlUnknown88BC05

        lda wUnknown0007D8,b
        cmp #2
        bne _End

          jsl $88C0B3

        _End
        rtl

        .databank 0

        ; 88/A7F5








      rlUnknown88AF7B ; 88/AF7B

        .al
        .autsiz
        .databank ?

        phx
        stz $07DA,b
        stz $07E0,b

        ldx $0772,b
        lda aDeploymentTable._UnitRAMPointer,x
        beq +

          sta $00089B
        
        +
        ldx $0772,b
        jsl rlDeployedUnitUnsetHiddenIfAlive

        ldx $0772,b
        lda aDeploymentTable._State,x
        bit #DeploymentStateCanto
        bne +

          lda bUnknown000E7B,b
          and #$00FF
          bit #$0041
          bne +

            ldx $0772,b
            jsl rlUnknown88B4DB

        +
        plx
        rtl

        .databank 0

      rsUnknown88B64F ; 88/B64F

        .al
        .autsiz
        .databank ?

        lda $0778,b
        beq ++
        bpl +

          inc $0778,b
          lda #$0200
          bra _End
          
            +
            dec $0778,b
            lda #$0100
            bra _End

        +
        lda $077A,b
        beq _B681
        beq +

          inc $077A,b
          lda #$0800
          bra _End

        +
        dec $077A,b
        lda #$0400
        bra _End
        
        _End
        sta wMapScrollDirectionIdentifier,b
        rts

        _B681
        lda wUnknown0007D8,b
        cmp #5
        beq _B6A6

          cmp #6
          beq _B6B6

            cmp #7
            beq _B6D4

              stz wUnknown00073A,b
              stz wMapScrollScriptOffset,b
              stz wUnknown0007D8,b
              lda #$0004
              trb $0788,b
              lda #0
              rts
        
        _B6A6
        stz wUnknown00073A,b
        stz wMapScrollScriptOffset,b
        stz wUnknown0007D8,b
        jsr $88B701
        lda #0
        rts

        _B6B6
        stz wUnknown00073A,b
        stz wMapScrollScriptOffset,b
        lda #3
        sta wUnknown0007D8,b
        lda $0772,b
        sta $00
        lda $0774,b
        sta $02
        jsl $8591B2
        lda #0
        rts

        _B6D4
        stz wUnknown00073A,b
        stz wMapScrollScriptOffset,b
        stz wUnknown0007D8,b
        lda $0D87,b
        bit #$0008
        bne +

          jsr $88B701
          lda #0
          rts

        +
        ldx $0772,b
        jsl rlUnknown84D4A2
        lda #$0008
        tsb $0788,b
        lda #0
        rts

        .databank 0

        ; 88/B6FD








      rlUnknown88C4D9 ; 88/C4D9

        .al
        .autsiz
        .databank ?

; AD 66 07      lda $0766,b
; F0 04         beq +

; 5C 1E C6 88   jml _C61E
    
              +
; AD D8 07      lda $07D8,b
; F0 18         beq +

; C9 01 00      cmp #1
; F0 1B         beq _C507

; C9 02 00      cmp #2
; F0 4A         beq _C53B

; C9 03 00      cmp #3
; F0 0D         beq ++

; C9 04 00      cmp #4
; D0 04         bne +

; 5C D2 C5 88   jml _C5D2
    
              +
; 5C 58 C6 88   jml _End
      
              +
; 5C AA C5 88 
    
              _C507
; A9 10 00 
; 8D 28 07 
; 20 4F B6 
; F0 0A 

; A9 08 00 
; 8D 26 07 
; 5C 0C C6 88 

; AD 7B 0E 
; 29 FF 00 
; 89 02 00 
; D0 07 

; 20 7D C6 
; 5C 58 C6 88 

; A9 00 00 
; 8D D8 07 
; 8D 6F 08 
; 5C 58 C6 88 
    
                _C53B
; 22 B3 C0 88 
; 9C 28 07 
; 20 1E AA 
; F0 1D 

; 22 1B BF 87 
; C9 00 00 
; D0 0A 

; A9 02 00 
; 8D 26 07 
; 5C 0C C6 88 

; A9 04 00 
; 8D 26 07 
; 5C 0C C6 88 

; AD 73 08 
; C9 FF FF 
; F0 26 

; 22 DB B4 88 
; A9 03 00 
; 8D D8 07 
; AD 68 07 
; 18 
; 6D 98 05 
; 8D 6C 07 
; AD 6A 07 
; 18 
; 6D 9A 05 
; 8D 6E 07 
; A9 01 00 
; 8D DA 07 
; 80 18 

; A9 00 00 
; 8D D8 07 
; 8D 6F 08 
; 22 7B AF 88 
; AD 79 08 
; 22 07 B3 86 
; 5C 58 C6 88 

; A9 10 00 
; 8D 28 07 
; 20 4F B6 
; F0 0D 

; A9 04 00 
; A9 08 00 
; 8D 26 07 
; 5C 0C C6 88 

; A9 18 00 
; 8D D4 07 
; A9 04 00 
; 8D D8 07 
; 5C 58 C6 88 
    
                _C5D2
; AD D4 07 
; 38 
; E9 01 00 
; 8D D4 07 
; 30 02 
; 80 79 

; A9 00 00 
; 8D D8 07 
; 8D 6F 08 
; 22 7B AF 88 
; AD 98 05 
; 8D 60 07 
; AD 9A 05 
; 8D 62 07 
; AD 71 08 
; 85 00 
; AD 73 08 
; 85 02 
; AD 79 08 
; 22 07 B3 86 
; 80 4D 

; 9C 38 07 
; A9 01 00 
; 8D 66 07 
; 9C 3A 07 
; 9C 3C 07 
; 9C 3E 07 
      
              _C61E
; AD 38 07 
; 18 
; 6D 26 07 
; 8D 38 07 
; CD 28 07 
; 90 1B 

; 38 
; ED 28 07 
; 85 00 
; AD 26 07 
; 38 
; E5 00 
; 8D 26 07 
; 9C 66 07 
; 9C 3A 07 
; 9C 3C 07 
; 9C 3E 07 
; 22 05 BC 88 
; AD D8 07 
; C9 02 00 
; D0 04         bne _End

; 22 B3 C0 88 
    
              _End
; 6B 










      rlUnknown88C9A6 ; 88/C9A6

        .al
        .autsiz
        .databank ?

        phx
        phk
        plb

        lda #$FFFF
        sta $0865,b

        ldx $0772,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #$8000
        bne _Tall

          ldx $0772,b
          lda aDeploymentTable._DeploymentOffsets,x
          tax
          lda aDeploymentTable._MapSpriteID,x
          and #~$8000
          sta wR0
          clc
          adc wR0
          clc
          adc wR0
          tax
          lda aMapMovementShortSpritePointers,x
          sta lR45
          lda aMapMovementShortSpritePointers+1,x
          sta lR45+1
          lda #(`$7EAB88)<<8
          sta lR47+1
          lda #<>$7EAB88
          sta lR47
          jsl rlDecompressSingle

          plx
          rtl
        
        _Tall
        ldy $0772,b
        lda aDeploymentTable._DeploymentOffsets,x
        tax
        lda aDeploymentTable._MapSpriteID,x
        and #~$8000
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax
        lda aMapMovementTallSpritePointers,x
        sta lR45
        lda aMapMovementTallSpritePointers+1,x
        sta lR45+1
        lda #(`$7EAB88)<<8
        sta lR47+1
        lda #<>$7EAB88
        sta lR47
        jsl rlDecompressSingle

        plx
        rtl

        .databank 0

        ; 88/CA28












      aUnknown88CBE8 ; 88/CBE8

        ; Indexed with map sprite ID

; 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 09 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E 0E











      rsMovingMapSpriteAppendDecomp ; 88/D67C

        .al
        .autsiz
        .databank ?

        lda lR18
        pha
        lda lR18+1
        pha
        phx
        phk
        plb

        lda aMovingMapSpritesMapSprites,b,x
        and #$8000
        bne +

          ; Short map sprites
          lda aMovingMapSpritesMapSprites,b,x
          phx
          and #$7FFF
          sta wR0
          clc
          adc wR0
          clc
          adc wR0
          tax

          lda aMapMovementShortSpritePointers,x
          sta lR18
          lda aMapMovementShortSpritePointers+1,x
          sta lR18+1
          plx

          jsr (aSetMovingMapSpriteBufferPointers,x)
          jsl rlAppendDecompList

          plx
          pla
          sta lR18+1
          pla
          sta lR18
          rtl

        ; Tall map sprite
        +
        lda aMovingMapSpritesMapSprites,b,x
        phx
        and #$7FFF
        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax

        lda aMapMovementTallSpritePointers,x
        sta lR18
        lda aMapMovementTallSpritePointers+1,x
        sta lR18+1
        plx

        jsr (aSetMovingMapSpriteBufferPointers,x)
        jsl rlAppendDecompList

        plx
        pla
        sta lR18+1
        pla
        sta lR18
        rtl

        .databank 0

      rsUnknown88D847 ; 88/D847

        .al
        .autsiz
        .databank $88

        ; X = active mover offset

        ; For short map sprites

        lda wUnknown000901,x
        beq +

          jml _End

        +
        lda wUnknown000921,b
        beq ++

          and #$FF00
          beq +

            inc wUnknown000901,b,x
            jml _End

          +
          lda @l aUnknown88D95B,x
          tsb wUnknown000921,b

        +
        lda @l aUnknown88D953,x
        tsb wUnknown000921,b

        lda aMovingMapSpritesMapSprites,b,x
        and #$7FFF
        tay
        lda aUnknown88CBE8,y
        and #$00FF
        sta wUnknown000901,x

        lda wUnknown0008F1,x
        clc
        adc #1
        and #$0003
        sta wUnknown0008F1,x

        lda wUnknown0008F1,x
        cmp #0
        beq _D8A8

        cmp #1
        beq _D8AD

        cmp #2
        beq _D8B2

        cmp #3
        beq _D8B7

        _D8A8
        lda #size(Tile4bpp) * 0
        bra +

        _D8AD
        lda #size(Tile4bpp) * 5
        bra +

        _D8B2
        lda #size(Tile4bpp) * 10
        bra +

        _D8B7
        lda #size(Tile4bpp) * 15
        bra +

        +
        sta $07E6,b

        ; Check for direction of movement
        lda wUnknown000911,x
        cmp #0
        beq _D8D7

        cmp #8
        beq _D8DC

        cmp #$0010
        beq _D8E1

        cmp #$0018
        beq _D8E6

        _D8D7
        lda #0
        bra +

        _D8DC
        lda #$0500
        bra +

        _D8E1
        lda #$0A00
        bra +

        _D8E6
        lda #$0F00
        bra +

        +
        clc
        adc $07E6,b
        sta $07E6,b

        jsr (aUnknown88D94B,x)

        lda $07EA,b
        clc
        adc $07E6,b
        sta lR18

        lda #$00A0
        sta wR0

        lda #$C400 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        lda $07EA,b
        clc
        adc #$00A0
        clc
        adc $07E6,b
        sta lR18

        lda #$00A0
        sta wR0

        lda #$C600 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        _End
        sep #$20
        lda #$88
        pha
        plb
        rep #$20

        stz wR0
        stz wR1
        lda @l aUnknown88DAFC,x
        sta wR4
        ldy #$CC5F
        rts

        .databank 0

      rsUnknown88D963 ; 88/D963

        .al
        .autsiz
        .databank $88

        lda wUnknown000901,x
        beq +

          jml _End

        +
        lda wUnknown000921,b
        beq ++

          and #$FF00
          beq +

            inc wUnknown000901,b,x
            jml _End

          +
          lda @l $88DA7A,x
          tsb wUnknown000921,b

        +
        lda @l aUnknown88DA72,x
        tsb wUnknown000921,b

        lda $0867,b,x
        and #$7FFF
        tay
        lda aUnknown88CBE8,y
        and #$00FF
        sta wUnknown000901,x

        lda wUnknown0008F1,x
        clc
        adc #1
        and #$0003
        sta wUnknown0008F1,x

        lda wUnknown0008F1,x
        cmp #0
        beq _D9C4

        cmp #1
        beq _D9C9

        cmp #2
        beq _D9CE

        cmp #3
        beq _D9D3
        
        _D9C4
        lda #0
        bra +

        _D9C9
        lda #$0200
        bra +

        _D9CE
        lda #$0400
        bra +

        _D9D3
        lda #$0600
        bra +

        +
        sta $07E6,b

        lda wUnknown000911,x
        xba
        clc
        adc $07E6,b
        sta $07E6,b

        jsr (aUnknown88DA6A,x)

        lda $07EA,b
        clc
        adc $07E6,b
        sta lR18

        lda #size(Tile4bpp) * 4
        sta wR0

        lda #$C400 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        lda $07EA,b
        clc
        adc #$0100
        clc
        adc $07E6,b
        sta lR18

        lda #size(Tile4bpp) * 4
        sta wR0

        lda #$C600 >> 1
        clc
        adc @l aUnknown88DB04,x
        sta wR1
        phx
        jsl rlDMAByPointer
        plx

        _End
        sep #$20
        lda #$88
        pha
        plb
        rep #$20

        phx
        lda $0867,b,x
        and #$7FFF
        asl a
        tax
        lda @l $88D488,x
        sta wR3
        plx

        lda wUnknown0008F1,x
        asl a
        clc
        adc wUnknown000911,x
        clc
        adc wR3
        tay
        lda $D4C6,b,y
        and #$00FF
        sta wR0
        lda $D4C7,b,y
        and #$00FF
        sta wR1
        lda @l aUnknown88DAFC,x
        sta wR4
        ldy #$CC49
        rts

        .databank 0

      rsUnknown88DA82 ; 88/DA82

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers)<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers
        sta lR18
        lda #(`aMovingMapSpriteBuffers)<<8
        sta $07EA+1,b
        lda #<>aMovingMapSpriteBuffers
        sta $07EA,b
        rts

        .databank 0

      rsUnknown88DA99 ; 88/DA99

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers)<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers
        sta lR18
        lda #(`aMovingMapSpriteBuffers)<<8
        sta $07EA,b
        lda #<>aMovingMapSpriteBuffers
        sta $07EA,b

        lda $07EA,b
        clc
        adc #$2000
        sta $07EA,b
        rts

        .databank 0

      rsUnknown88DABA ; 88/DABA

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers)<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers
        sta lR18
        lda #(`aMovingMapSpriteBuffers)<<8
        sta $07EB,b
        lda #<>aMovingMapSpriteBuffers
        sta $07EA,b

        lda $07EA,b
        clc
        adc #$4000
        sta $07EA,b
        rts

        .databank 0

      rsUnknown88DADB ; 88/DADB

        .al
        .autsiz
        .databank ?

        lda #(`aMovingMapSpriteBuffers)<<8
        sta lR18+1
        lda #<>aMovingMapSpriteBuffers
        sta lR18
        lda #(`aMovingMapSpriteBuffers)<<8
        sta $07EB,b
        lda #<>aMovingMapSpriteBuffers
        sta $07EA,b

        lda $07EA,b
        clc
        adc #$6000
        sta $07EA,b
        rts

        .databank 0

      rlUnknown8A9750 ; 8A/9750

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = PortraitID

        jsl rlGetDecompressedPortraitDataPointers

        ldx #size(Palette)-2
        ldy #size(Palette)-2

          -
          lda [lR19],y
          sta aBGPaletteBuffer.aPalette5,b,y
          dec x
          dec x
          dec y
          dec y
          bpl -

        lda #16 * 4 * size(Tile4bpp)
        sta wR0
        lda #$CE00 >> 1
        sta wR1
        phx
        jsl rlDMAByPointer
        plx
        rtl

        .databank 0

        ; 8A/9776



















      rlDecompressWorldMapPortraitToSlot ; 8A/B49A

        .al
        .autsiz
        .databank $8A

        ; Input:
        ; A = CharacterID / also PortraitDialogue
        ; X = portrait slot offset

        ; Output:
        ; lR18 = Decompression buffer pointer
        ; lR19 = Portrait palette

        phk
        plb

        phy
        sta $078C,b

        jsl rlGetCharacterPortraitDataID
        jsr rlTryGetClassPortraitDataID
        pla

        sta wR0
        clc
        adc wR0
        clc
        adc wR0
        tax

        lda aPortraitGraphicPointers,x
        sta lR45
        lda aPortraitGraphicPointers+1,x
        sta lR45+1
        lda #(`aDecompressionBuffer)<<8
        sta lR47+1
        lda aPortraitSlotDecompressionPointers,y
        sta lR47

        phx
        phy
        jsl rlDecompressSingle
        ply
        plx

        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        sta lR18

        lda aPortraitSlotDecompressionPointers,y
        sta lR18
        lda aPortraitPalettePointers+1,x
        sta lR19+1
        lda aPortraitPalettePointers,x
        sta lR19
        rtl

        .databank 0

      rlUnknown8AD975 ; 8A/D975

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        jsr rsUnknown8AE05E

        lda $7F7670
        bne +

          jsl rlDMAByStruct
            .structDMAToVRAM aBG3TilemapBuffer, $0700, $80, $F000

          bra ++

        +
        lda #0
        sta $7F7670
        jsr rsUnknown8ADA83
        jsr $8ADA24

        sep #$20
        lda bBufferINIDISP
        rep #$20
        and #$000F
        bne +

          lda #(`procFadeInByScreenFadingTimer)<<8
          sta lR44+1
          lda #<>procFadeInByScreenFadingTimer
          sta lR44
          jsl rlProcEngineFindProc
          bcs +

            jsl rlProcEngineCreateProc

        +
        lda $0592,b
        asl a
        tax
        jsr (aUnknown8AD9FE,x)

        lda $08AD,b
        bit #$0001
        beq +

          lda #$0020
          sta wR0
          lda #$0060
          sta wR1
          ldx #0
          jsr $8A950E
          jsr $8ADB04

        +
        lda $08AD,b
        bit #$0002
        beq +

          lda #$00A0
          sta wR0
          lda #$0060
          sta wR1
          ldx #2
          jsr $8A9539
          jsr $8ADB37

        +
        plp
        plb
        rtl

        .databank 0

      rsUnknown8ADBBD ; 8A/DBBD

        .al
        .autsiz
        .databank ?

        jsl rlResetDialogueEngine

        lda $08AF+1,b
        sta $24+1
        lda $08AF,b
        sta $24
        lda #2
        jsl rlUnknown91811C

        lda #0
        sta aBGPaletteBuffer,b
        lda #2
        sta aDialogue.wUnknown0018D0,b
        ldx #0
        jsr rsUnknown8ADCF9

        lda $08B8,b
        cmp #4
        bne +

          lda #$081E
          sta aDialogue._Slot[0].wDisplayArea,b

        +
        lda #1
        sta $0592,b
        lda #2
        sta $0594,b
        rts

        .databank 0

      procUnknown8AE1EB ; 8A/E1EB

        .structProcInfo rlProcUnknown8AE1EBInit, rlProcUnknown8AE1EBCycle, $8AE243

      rlProcFadeInWorldMapPortraitSlotCycle ; 8B/8C98

        .al
        .autsiz
        .databank ?

        .for i in range(15)

          lda #(i+1) * $200
          sta lR18
          lda #aOAMPaletteBuffer.aPalette0 + ((i+1) * size(word))
          lda #(i+1) * $200 + $7F
          sta lR19+1
          lda #<>(aPortraitSlotsPaletteBuffer + ((i+1) * size(word)))
          sta lR19
          jsl rlIncreaseColorBightnessOfPortraitSlot

        .endfor

        lda wVBlankEnabledFramecount
        and #$0003
        bne _End

          lda aProcSystem.aBody0,b,x
          dec a
          dec a
          sta aProcSystem.aBody0,b,x
          bmi +

        _End
        rtl

        +
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

      rlUnknown8B91F6 ; 8B/91F6

        .al
        .autsiz
        .databank ?

        lda #DialogueStatusPreventASpeedUp
        tsb aDialogue.wStatus,b

        lda #3
        sta aDialogue.wTextSpeed,b
        lda #2
        sta aDialogue.wTextSound,b

        lda wCurrentChapter,b
        cmp #-1
        bne +

          lda #4
          sta aDialogue.wUnknown00188C,b
          lda #6
          sta aDialogue.wTextSpeed,b
          lda #0
          sta aDialogue.wTextSound,b

        +
        lda #2
        sta aDialogue.wUnknown0018D0,b
        lda #(4 << 8 | 30)
        sta aDialogue._Slot[0].wDisplayArea,b,x
        lda #$9000 >> 1
        sta aDialogue._Slot[0].wVRAMAddress,b,x
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[0].lBGBufferPosition+1,b,x
        lda #<>aBG3TilemapBuffer
        sta aDialogue._Slot[0].lBGBufferPosition,b,x

        ; Is this supposed to be X indexed?
        lda #TilemapEntry($100, 0, true, false, false)
        sta aDialogue.wBaseTile,b,x
        lda #$1604
        sta wR1

        sep #$20
        lda #0
        sta wR0+1
        xba
        sta wR1
        lda wR0
        lda wR1+1
        xba
        rep #$20

        lsr a
        lsr a
        clc
        adc wR0
        sta wR0

        ldx aDialogue.wSlotOffset,b
        lda #(`aBG3TilemapBuffer)<<8
        sta aDialogue._Slot[0].lBGBufferPosition+1,b,x
        lda #<>aBG3TilemapBuffer
        clc
        adc wR0
        sta aDialogue._Slot[0].lBGBufferPosition,b,x
        rtl

        .databank 0

      rlUnknown8B9275 ; 8B/9275

        .al
        .autsiz
        .databank ?

        php
        lda #$7E00
        sta $24+1
        ldy #$FF00

        lda $18A1,b
        and #$0001
        bne +

        ldy #$FF80
        
        +
        sty $24

        ldy #0
        lda $18D4,b
        sec
        sbc #$8388
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        pha

        asl a
        asl a
        asl a
        cmp #$007F
        bcc +
        beq +

        pha
        lda $87
        sta $00
        lda $89
        sta $02
        lda #$007F
        jsl $919677
        pla
        sec
        sbc #$007F
        
        +
        pha
        lda $87
        sta $00
        lda $89
        sta $02
        pla
        jsl $919677
        jsl $919688
        sta $27
        sec
        sbc #$0010
        cmp $18E1,b
        bcs _9352

        sta $2D
        lda #$0100
        clc
        adc #0
        sta $00

        lda $27
        tax
        lda $18E1,b
        sec
        sbc $2D
        jsl $91969C
        txa
        beq _9352

        sta $2A
        clc
        adc #0
        sta $02
        lda $27
        sec
        sbc $2A
        jsl $919677
        lda $2A
        cmp #$0010
        bcc +

        lda #$0100
        clc
        adc #0
        sta $00
        lda $2A
        sec
        sbc $27
        clc
        adc #0
        sta $02
        
        +
        lda $2A
        and #$FFF0
        jsl $919677

        lda $2A
        and #$000F
        sta $2A
        beq _9366
        
        -
        lda #$0100
        clc
        adc #0
        sta $00
        lda $2A
        sec
        sbc $27
        clc
        adc #0
        sta $02
        lda #1
        jsl $919677
        dec $2A
        bne -
        bra _9366
        
        _9352
        lda #$0100
        clc
        adc #0
        sta $00
        lda #0
        sta $02
        lda $27
        jsl $919677
        
        _9366
        pla
        clc
        adc $18DC,b
        sta $00

        lda $1882,b
        bit #$1000
        bne +

        jml $8B942F
        
        +
        lda $18ED,b
        sec
        sbc #$8388
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sec
        sbc $00
        asl a
        asl a
        asl a
        pha
        lda $87
        sta $00
        lda $89
        sta $02
        pla
        jsl $919677
        jsl $919692
        sta $27
        sec
        sbc #$0010
        cmp $18FA,b
        bcs _941D

        sta $2D
        lda $87
        clc
        adc #0
        sta $00
        lda $27
        tax
        lda $18FA,b
        sec
        sbc $2D
        jsl $91969C
        txa
        beq _941D

        sta $2A
        clc
        adc $89
        sta $02
        lda $27
        sec
        sbc $2A
        jsl $919677

        lda $2A
        cmp #$0010
        bcs +

        lda $87
        clc
        adc #0
        sta $00
        lda $2A
        sec
        sbc $27
        clc
        adc $89
        sta $02
        lda $2A
        and #$FFF0
        jsl $919677
        
        +
        lda $2A
        and #$000F
        sta $2A
        beq _942F
        
        -
        lda $87
        clc
        adc #0
        sta $00
        lda $2A
        sec
        sbc $27
        clc
        adc $89
        sta $02
        lda #1
        jsl $919677
        dec $2A
        bne -
        bra _942F
        
        _941D
        lda $87
        clc
        adc #0
        sta $00
        lda $89
        sta $02
        lda $27
        jsl $919677
        
        _942F
        lda #1
        pha
        lda #$0100
        sta $00
        lda #0
        sta $02
        pla
        jsl $919677
        lda #0
        sta [$24],y
        plp
        rtl

        .databank 0

        ; 8B/9449



























      rsUnknown91D69B ; 91/D69B

        .al
        .autsiz
        .databank ?

        lda #(`aWorldMapEvents)<<8
        sta lR18+1

        lda wCurrentChapter,b
        cmp #$0012
        bcc +

          lda #0

        +
        asl a
        tax
        lda aWorldMapEvents,x
        sta lR18
        jsl $80C1FC
        inc $0304,b
        rts

        .databank 0

        ; 91/D6BB






      procUnknown85BA41 .structProcInfo "PW", rlProcUnknown85BA41Init, $85BAC7, $858398 ; 85/BA41

        .long $85BA35
        .byte 1

      rlUnknown9599E7 ; 95/99E7

        .al
        .autsiz
        .databank ?

        ldx #$2940
        jsr $9594F8

        lda #$2940
        jsr $959537

        ldx #2
        
          -
          lda $E00060,x
          sta $0100,b,x
          inc x
          inc x
          cpx #32
          bcc -

        lda wBattleType
        and #$00FF
        cmp #$00FF
        bne +

        lda aActionStructUnit1.UnitRAMPointer
        bra ++
        
        +
        lda aActionStructUnit1.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleHUDColorID

        +
        jsr $959B84

        lda wBattleType
        and #$00FF
        cmp #$00FF
        bne +

        lda aActionStructUnit2.UnitRAMPointer
        bra ++
        
        +
        lda aActionStructUnit2.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleHUDColorID
        
        +
        jsr $959BC1
        rtl

        .databank 0

      rsUnknown959A4D ; 95/9A4D

        .al
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #$EAEE
        stx DecompressionVariables.lSource
        lda #$9C
        sta DecompressionVariables.lSource+2
        ldx #<>aDecompressionBuffer
        sta $CB
        lda #`aDecompressionBuffer
        sta $CD
        jsl rlDecompressor
        rep #$30

        lda wBattleType
        and #$00FF
        cmp #$00FF
        bne +

        lda aActionStructUnit1.XPosition
        bra ++
        
        +
        lda aActionStructUnit1.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleBannerID
        
        +
        asl a
        pha
        asl a
        clc
        adc #1,s
        tax
        pla

        lda $998D84+1,x
        sta lR45+1
        lda $998D84,x
        sta lR45
        lda #(`$7FC200)<<8
        sta lR47+1
        lda #<>$7FC200
        sta lR47
        phx
        jsl rlDecompressSingle
        plx

        lda $998D84+3+1,x
        sta lR18+1
        lda $998D84+3,x
        sta lR18
        ldx #0
        ldy #0
        
        -
        lda [lR18],y
        sta $01D2,b,x
        sta $7FC1F0,x
        inc y
        inc y
        inc x
        inc x
        cpx #14
        bcc -

        lda wBattleType
        and #$00FF
        cmp #$00FF
        bne +

        lda aActionStructUnit2.XPosition
        bra ++
        
        +
        lda aActionStructUnit2.UnitRAMPointer
        sta wSelectedUnitDataRAMPointer,b
        jsl rlGetSelectedUnitFactionSlot
        jsl rlGetFactionBattleBannerID
        
        +
        asl a
        pha
        asl a
        clc
        adc #1,s
        tax
        pla

        lda $998D84+1,x
        sta lR45+1
        lda $998D84,x
        sta lR45
        lda #(`$7FC000)<<8
        sta lR47+1
        lda #<>$7FC000
        sta lR47
        phx
        jsl rlDecompressSingle
        plx

        lda $998D84+3+1,x
        sta lR18+1
        lda $998D84+3,x
        sta lR18

        ldx #0
        ldy #0
        
        -
        lda [lR18],y
        sta $01F2,b,x
        sta $7FC3F0,x
        inc y
        inc y
        inc x
        inc x
        cpx #14
        bcc -

        jsl rlDMAByStruct

          .structDMAToVRAM $7FC000, $0400, $80, $F000

        rts

        .databank 0

        ; 95/9B49





      rlUnknown9E85A4 ; 9E/85A4

        .al
        .autsiz
        .databank ?

        ; Get gendered battle sprite?

        ; wR0 = ClassID
        ; wR1 = Gender
        ; wR2 = CharacterID

        phx
        phy
        lda wR0
        cmp #KnightLord
        bne +

          lda wR2
          cmp #Seliph
          bne +

            lda #$005D
            bra _End

        +
        asl a
        tax
        lda aUnknown9E85DF,x
        cmp #$FFFF
        bne +

          lda wR0
          bra _End

        +
        lda wR1
        dec a
        beq +

          lda wR0
          bra _End

        +
        lda wR0
        asl a
        tax
        lda aUnknown9E85DF+1,x
        and #$00FF

        _End
        ply
        plx
        rtl

        .databank 0

      rlUnknown9E88CE ; 9E/88CE

        .al
        .autsiz
        .databank ?

        phx
        ldx #2

          -
          lda aUnknown9E88F4,x
          sta $7EFC88
          sta $7EFC8E
          sta $7EFC94
          sta $7EFC9A
          dec x
          dec x
          bpl -

        lda aUnknown9E88F4 + 4
        sta $7EFCA0
        plx
        rtl

        .databank 0

      aProcUnknown9EAC69Code ; 9E/ACAF

        PROC_YIELD 1
        PROC_SET_ONCYCLE $9ECA45

        PROC_YIELD 48
        PROC_CALL $9EC91A

        PROC_JUMP_IF_BITS_UNSET _ACD1, $0002

            _ACC2
            PROC_YIELD 1
            PROC_CALL $9EC944

            PROC_JUMP_IF_BITS_UNSET _ACC2, $0004

          YIELD 1

        _ACD1
        PROC_CALL $9E9342
        PROC_JUMP_IF_BITS_UNSET _ACFC, $0002

          PROC_CALL $9EB3F3
          PROC_JUMP_IF_BITS_UNSET _ACEE, $0004

            PROC_YIELD 16
            PROC_CALL $9EB4A9

        _ACEE
        PROC_YIELD 1
        PROC_SET_ONCYCLE $9E936B
        PROC_JUMP_IF_BITS_UNSET _ACEE, $0004

        PROC_YIELD 107

        _ACFC
        PROC_CALL $9E952D

        PROC_JUMP_IF_BITS_UNSET _AD22, $0002
        PROC_CALL $9EB3F3

        PROC_JUMP_IF_BITS_UNSET _AD14, $0004

          PROC_YIELD 16

        _AD14
        PROC_SET_ONCYCLE $9E95AB

        _AD18
        PROC_YIELD 1
        PROC_JUMP_IF_BITS_UNSET _AD18, $0004

        PROC_YIELD 8

        _AD22
        PROC_CALL $9E9928

        PROC_JUMP_IF_BITS_UNSET _AD48, $0002

        PROC_CALL $9EB3F3
        PROC_JUMP_IF_BITS_UNSET _AD3A, $0004

          PROC_YIELD 16

        _AD3A
        PROC_CALL $9EB491
        PROC_YIELD 117
        PROC_CALL $85DB91
        PROC_YIELD 8

        _AD48
        PROC_CALL $9E985E

        PROC_JUMP_IF_BITS_UNSET _AD6E, $0002

        PROC_CALL $9EB3F3

        PROC_JUMP_IF_BITS_UNSET _AD60, $0004

          PROC_YIELD 16

        _AD60
        PROC_CALL $9EB49D
        PROC_YIELD 117
        PROC_CALL $85DB91
        PROC_YIELD 8

        _AD6E
        PROC_CALL $9EB41C
        PROC_YIELD 16
        PROC_SET_ONCYCLE $9EAD7B
        PROC_HALT

        ; AD7B







      aBattleMapSpriteData ; 9E/B50D

; CB F4 AD F6 A0 AA D1 ED AD 6C 96 AA 4E EA AD C3 92 AA C6 E6 AD 26 8F AA 0B F1 AD 26 8F AA 90 F8 AD 00 9A AA D9 FB AD 2F 9D AA 00 00 D5 F6 A0 AA 01 ; Cavalier
; B1 10 D5 F6 A0 AA 01 0A D5 6C 96 AA AD 06 D5 C3 92 AA 33 03 D5 26 8F AA 0F 0D D5 26 8F AA DD 14 D5 00 9A AA 25 18 D5 2F 9D AA 75 1B D5 F6 A0 AA 01 ; LanceKnight
; CB F4 AD F6 A0 AA D1 ED AD 6C 96 AA 4E EA AD C3 92 AA C6 E6 AD 26 8F AA 0B F1 AD 26 8F AA 90 F8 AD 00 9A AA D9 FB AD 2F 9D AA 00 00 D5 F6 A0 AA 01 ; BowKnight
; B1 10 D5 F6 A0 AA 01 0A D5 6C 96 AA AD 06 D5 C3 92 AA 33 03 D5 26 8F AA 0F 0D D5 26 8F AA DD 14 D5 00 9A AA 25 18 D5 2F 9D AA 75 1B D5 F6 A0 AA 01 ; AxeKnight
; B1 10 D5 F6 A0 AA 01 0A D5 6C 96 AA AD 06 D5 C3 92 AA 33 03 D5 26 8F AA 0F 0D D5 26 8F AA DD 14 D5 00 9A AA 25 18 D5 2F 9D AA 75 1B D5 F6 A0 AA 01 ; FreeKnight
; B1 10 D5 FB 8C AC 01 0A D5 18 FF AB AD 06 D5 3D FA AB 33 03 D5 9A F5 AB 0F 0D D5 9A F5 AB DD 14 D5 BF 83 AC 25 18 D5 42 88 AC 75 1B D5 FB 8C AC 01 ; Troubadour
; CB F4 AD D6 87 A5 D1 ED AD 5A FF A4 4E EA AD 4A FC A4 C6 E6 AD 26 F9 A4 0B F1 AD 26 F9 A4 90 F8 AD 2D 82 A5 D9 FB AD DD 84 A5 00 00 D5 D6 87 A5 01 ; KnightLord
; CB F4 AD 6D F9 A2 D1 ED AD BF F0 A2 4E EA AD 85 ED A2 C6 E6 AD 71 EA A2 0B F1 AD 71 EA A2 90 F8 AD 8E F3 A2 D9 FB AD 6B F6 A2 00 00 D5 6D F9 A2 01 ; DukeKnight
; CB F4 AD 40 CE A5 D1 ED AD B8 BB A5 4E EA AD 53 B5 A5 C6 E6 AD 39 AF A5 0B F1 AD 39 AF A5 90 F8 AD D7 C1 A5 D9 FB AD E4 C7 A5 00 00 D5 40 CE A5 01 ; MasterKnight
; CB F4 AD DB B1 A7 D1 ED AD 1A A1 A7 4E EA AD 12 9B A7 C6 E6 AD 36 95 A7 0B F1 AD 36 95 A7 90 F8 AD A4 A6 A7 D9 FB AD 2D AC A7 00 00 D5 DB B1 A7 01 ; Paladin
; CB F4 AD 7B 8F A7 D1 ED AD 22 FF A6 4E EA AD 4B F9 A6 C6 E6 AD 92 F3 A6 0B F1 AD 92 F3 A6 90 F8 AD C2 84 A7 D9 FB AD F9 89 A7 00 00 D5 7B 8F A7 01 ; PaladinF
; CB F4 AD 07 D6 A0 D1 ED AD 50 CE A0 4E EA AD EA CB A0 C6 E6 AD 92 C9 A0 0B F1 AD 92 C9 A0 90 F8 AD F2 D0 A0 D9 FB AD 5A D3 A0 00 00 D5 07 D6 A0 01 ; ArchKnight
; CB F4 AD 0B B0 A4 D1 ED AD DB A7 A4 4E EA AD EB A4 A4 C6 E6 AD E9 A1 A4 0B F1 AD E9 A1 A4 90 F8 AD A5 AA A4 D9 FB AD 3B AD A4 00 00 D5 0B B0 A4 01 ; Ranger
; CB F4 AD DD EF AB D1 ED AD 15 E0 AB 4E EA AD 4A DA AB C6 E6 AD B1 D4 AB 0B F1 AD B1 D4 AB 90 F8 AD 25 E5 AB D9 FB AD 44 EA AB 00 00 D5 DD EF AB 01 ; MageKnight
; CB F4 AD 8E 8A A3 D1 ED AD 5F 82 A3 4E EA AD 6D FF A2 C6 E6 AD 7C FC A2 0B F1 AD 7C FC A2 90 F8 AD 30 85 A3 D9 FB AD C2 87 A3 00 00 D5 8E 8A A3 01 ; GreatKnight
; B8 28 D5 F4 E6 A7 F3 23 D5 E8 D9 A7 34 21 D5 BB D5 A7 E2 1E D5 86 D1 A7 30 26 D5 86 D1 A7 4C 2B D5 05 DE A7 65 2D D5 82 E2 A7 DC 2F D5 F4 E6 A7 01 ; PegasusRider
; B8 28 D5 09 CD A7 F3 23 D5 F9 BF A7 34 21 D5 BF BB A7 E2 1E D5 88 B7 A7 30 26 D5 88 B7 A7 4C 2B D5 09 C4 A7 65 2D D5 79 C8 A7 DC 2F D5 09 CD A7 01 ; PegasusKnight
; B8 28 D5 0C F5 A3 F3 23 D5 AB DE A3 34 21 D5 86 D7 A3 E2 1E D5 D9 CF A3 30 26 D5 D9 CF A3 4C 2B D5 4B E6 A3 65 2D D5 AA ED A3 DC 2F D5 0C F5 A3 01 ; FalconKnight
; B5 A7 AD 1A E5 A2 7A A3 AD 26 D7 A2 50 A1 AD 34 D3 A2 97 9F AD C0 CE A2 78 A5 AD C0 CE A2 C5 A9 AD D4 DB A2 7F AB AD FB DF A2 79 AD AD 1A E5 A2 01 ; Dragonrider
; B5 A7 AD 89 F4 A1 7A A3 AD 3B E6 A1 50 A1 AD 5B E2 A1 97 9F AD F1 DD A1 78 A5 AD F1 DD A1 C5 A9 AD 31 EB A1 7F AB AD 62 EF A1 79 AD AD 89 F4 A1 01 ; Dragonknight
; B5 A7 AD D8 AD A2 7A A3 AD 0C 9F A2 50 A1 AD 16 9B A2 97 9F AD 97 96 A2 78 A5 AD 97 96 A2 C5 A9 AD 1B A4 A2 7F AB AD 6E A8 A2 79 AD AD D8 AD A2 01 ; Dragonmaster
; 90 9A AD 09 C8 A0 11 98 AD 72 C4 A0 F4 96 AD 52 C3 A0 BD 95 AD 52 C2 A0 5A 99 AD 52 C2 A0 D2 9B AD 9B C5 A0 12 9D AD CA C6 A0 4B 9E AD 09 C8 A0 00 ; Archer
; 79 CC AD 54 ED AA CA C8 AD E1 E6 AA E8 C6 AD BC E3 AA 6D C5 AD 8C E0 AA 27 CA AD 8C E0 AA D6 CE AD 3C E8 AA 39 D0 AD 0D EA AA 33 D2 AD 54 ED AA 00 ; Myrmidon
; 79 CC AD 7B 8B AA CA C8 AD 67 84 AA E8 C6 AD 2E 81 AA 6D C5 AD 02 FE A9 27 CA AD 02 FE A9 D6 CE AD DA 85 AA 39 D0 AD D2 87 AA 33 D2 AD 7B 8B AA 00 ; Swordmaster
; 90 9A AD CC B1 AA 11 98 AD 30 AE AA F4 96 AD F9 AC AA BD 95 AD 0F AC AA 5A 99 AD 0F AC AA D2 9B AD 56 AF AA 12 9D AD 8A B0 AA 4B 9E AD CC B1 AA 00 ; Sniper
; 79 CC AD E7 9D A4 CA C8 AD F2 95 A4 E8 C6 AD 5E 92 A4 6D C5 AD D0 8E A4 27 CA AD D0 8E A4 D6 CE AD 8F 97 A4 39 D0 AD C1 99 A4 33 D2 AD E7 9D A4 00 ; Hero
; AC FB AC B9 D0 A4 05 F4 AC 2D C7 A4 29 F0 AC 97 C4 A4 8F EC AC 98 C1 A4 A3 F7 AC 98 C1 A4 EE FF AC 6F CA A4 5A 83 AD 75 CD A4 45 87 AD B9 D0 A4 00 ; General
; AC FB AC A3 AB A3 05 F4 AC 78 99 A3 29 F0 AC A2 93 A3 8F EC AC 58 8D A3 A3 F7 AC 58 8D A3 EE FF AC A1 9F A3 5A 83 AD 42 A5 A3 45 87 AD A3 AB A3 00 ; Emperor
; AC FB AC 59 F8 A0 05 F4 AC 6D E5 A0 29 F0 AC 8B DF A0 8F EC AC AB D8 A0 A3 F7 AC AB D8 A0 EE FF AC A0 EB A0 5A 83 AD 63 F1 A0 45 87 AD 59 F8 A0 00 ; Baron
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; Soldier
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; SpearSoldier
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; AxeSoldier
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; BowSoldier
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; SwordSoldier
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; LanceArmor
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; AxeArmor
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; BowArmor
; 93 DF AC F4 8C A0 2B D9 AC 01 85 A0 06 D6 AC A2 82 A0 1C D3 AC 00 80 A0 16 DC AC 00 80 A0 2A E3 AC 84 87 A0 15 E6 AC 50 8A A0 77 E9 AC F4 8C A0 00 ; SwordArmor
; 4F 90 AD AC AB A0 B0 8D AD 3A A4 A0 5B 8C AD 0F A2 A0 10 8B AD 53 9F A0 00 8F AD 53 9F A0 C6 91 AD F2 A6 A0 0D 93 AD 3A A9 A0 7A 94 AD AC AB A0 00 ; Barbarian
; 4F 90 AD 49 9C A0 B0 8D AD 98 94 A0 5B 8C AD 67 92 A0 10 8B AD C2 8F A0 00 8F AD C2 8F A0 C6 91 AD 61 97 A0 0D 93 AD B1 99 A0 7A 94 AD 49 9C A0 00 ; Fighter
; 4F 90 AD B9 E1 A6 B0 8D AD E9 D9 A6 5B 8C AD A8 D7 A6 10 8B AD FD D4 A6 00 8F AD FD D4 A6 C6 91 AD CB DC A6 0D 93 AD 0D DF A6 7A 94 AD B9 E1 A6 00 ; Brigand
; ED DC AD D3 A6 AC 0A D8 AD 19 9A AC EA D5 AD 48 96 AC 9B D3 AD BF 91 AC 75 DA AD BF 91 AC 86 DF AD 5E 9E AC DC E1 AD 4F A2 AC 63 E4 AD D3 A6 AC 00 ; Warrior
; ED DC AD 6B BE A4 0A D8 AD 7E B7 A4 EA D5 AD 8A B5 A4 9B D3 AD E0 B2 A4 75 DA AD E0 B2 A4 86 DF AD CD B9 A4 DC E1 AD E8 BB A4 63 E4 AD 6B BE A4 00 ; Hunter
; 4F 90 AD B0 F0 A6 B0 8D AD 36 E9 A6 5B 8C AD 17 E7 A6 10 8B AD 70 E4 A6 00 8F AD 70 E4 A6 C6 91 AD F4 EB A6 0D 93 AD 33 EE A6 7A 94 AD B0 F0 A6 00 ; Pirate
; 0C 6B D6 0D E3 A4 3A 69 D6 00 DB A4 0A 68 D6 AD D7 A4 61 67 D6 11 D4 A4 DE 69 D6 11 D4 A4 35 6C D6 21 DD A4 E1 6C D6 51 DF A4 2A 6E D6 0D E3 A4 00 ; JuniorLord
; 13 C0 AD FD B0 A6 4A BD AD BA A3 A6 C7 BB AD A0 9F A6 86 BA AD EB 9B A6 85 BE AD EB 9B A6 99 C1 AD 84 A7 A6 D4 C2 AD E5 AB A6 36 C4 AD FD B0 A6 00 ; WarMage
; 0C 6B D6 C4 9C A8 3A 69 D6 92 94 A8 0A 68 D6 1B 91 A8 61 67 D6 85 8D A8 DE 69 D6 85 8D A8 35 6C D6 CC 96 A8 E1 6C D6 F2 98 A8 2A 6E D6 C4 9C A8 00 ; Prince
; 13 C0 AD 4F B7 A8 4A BD AD AC A9 A8 C7 BB AD 52 A5 A8 86 BA AD E3 A0 A8 85 BE AD E3 A0 A8 99 C1 AD E3 AD A8 D4 C2 AD 73 B2 A8 36 C4 AD 4F B7 A8 00 ; Princess
; 13 C0 AD 12 97 A6 4A BD AD 97 8A A6 C7 BB AD 86 86 A6 86 BA AD C9 82 A6 85 BE AD C9 82 A6 99 C1 AD 87 8E A6 D4 C2 AD 93 92 A6 36 C4 AD 12 97 A6 00 ; WarMageF
; 13 C0 AD 36 CA A8 4A BD AD 6A C1 A8 C7 BB AD CA BE A8 86 BA AD 3F BC A8 85 BE AD 3F BC A8 99 C1 AD F0 C3 A8 D4 C2 AD 08 C7 A8 36 C4 AD 36 CA A8 00 ; Queen
; CB B4 AD 6A 9E A1 F1 B1 AD A1 96 A1 68 B0 AD 76 93 A1 0F AF AD 90 90 A1 35 B3 AD 90 90 A1 66 B6 AD CB 98 A1 AA B7 AD 43 9B A1 3C B9 AD 6A 9E A1 00 ; Dancer
; 13 C0 AD 76 8A A8 4A BD AD 7A 82 A8 C7 BB AD 9A FF A7 86 BA AD D3 FC A7 85 BE AD D3 FC A7 99 C1 AD F6 84 A8 D4 C2 AD 64 87 A8 36 C4 AD 76 8A A8 00 ; Priest
; 13 C0 AD ED D1 A6 4A BD AD 64 C9 A6 C7 BB AD A5 C6 A6 86 BA AD 02 C4 A6 85 BE AD 02 C4 A6 99 C1 AD 07 CC A6 D4 C2 AD D2 CE A6 36 C4 AD ED D1 A6 00 ; Mage
; 13 C0 AD 28 CD A3 4A BD AD 79 C5 A3 C7 BB AD 08 C3 A3 86 BA AD E9 C0 A3 85 BE AD E9 C0 A3 99 C1 AD D4 C7 A3 D4 C2 AD 82 CA A3 36 C4 AD 28 CD A3 00 ; FireMage
; 13 C0 AD 22 9E AB 4A BD AD 68 96 AB C7 BB AD 23 94 AB 86 BA AD 08 92 AB 85 BE AD 08 92 AB 99 C1 AD D0 98 AB D4 C2 AD 8E 9B AB 36 C4 AD 22 9E AB 00 ; ThunderMage
; 13 C0 AD 35 C6 AC 4A BD AD C3 BE AC C7 BB AD 94 BC AC 86 BA AD 7A BA AC 85 BE AD 7A BA AC 99 C1 AD 2B C1 AC D4 C2 AD A0 C3 AC 36 C4 AD 35 C6 AC 00 ; WindMage
; 13 C0 AD 1D F0 A5 4A BD AD EF E7 A5 C7 BB AD 7B E5 A5 86 BA AD 5F E3 A5 85 BE AD 5F E3 A5 99 C1 AD 5B EA A5 D4 C2 AD 72 ED A5 36 C4 AD 1D F0 A5 00 ; HighPriest
; 13 C0 AD 71 8D A1 4A BD AD 38 84 A1 C7 BB AD 93 81 A1 86 BA AD DF FE A0 85 BE AD DF FE A0 99 C1 AD 04 87 A1 D4 C2 AD 23 8A A1 36 C4 AD 71 8D A1 00 ; Bishop
; 13 C0 AD 83 EA A8 4A BD AD 25 E2 A8 C7 BB AD BE DF A8 86 BA AD 73 DD A8 85 BE AD 73 DD A8 99 C1 AD BF E4 A8 D4 C2 AD A1 E7 A8 36 C4 AD 83 EA A8 00 ; Sage
; 13 C0 AD DF B8 A0 4A BD AD 79 B2 A0 C7 BB AD 70 B0 A0 86 BA AD 8B AE A0 85 BE AD 8B AE A0 99 C1 AD 6B B4 A0 D4 C2 AD 9D B6 A0 36 C4 AD DF B8 A0 00 ; Bard
; 13 C0 AD 7B EB A9 4A BD AD 52 E4 A9 C7 BB AD 5E E2 A9 86 BA AD FE DF A9 85 BE AD FE DF A9 99 C1 AD AD E6 A9 D4 C2 AD 03 E9 A9 36 C4 AD 7B EB A9 00 ; Priestess
; 13 C0 AD 5C BF A1 4A BD AD 5A B7 A1 C7 BB AD AD B4 A1 86 BA AD 49 B2 A1 85 BE AD 49 B2 A1 99 C1 AD CF B9 A1 D4 C2 AD AB BC A1 36 C4 AD 5C BF A1 00 ; DarkMage
; 13 C0 AD 51 AF A1 4A BD AD A2 A6 A1 C7 BB AD 09 A4 A1 86 BA AD A7 A1 A1 85 BE AD A7 A1 A1 99 C1 AD F4 A8 A1 D4 C2 AD EF AB A1 36 C4 AD 51 AF A1 00 ; DarkBishop
; E2 72 D6 EF 81 AB EE 70 D6 13 FD AA C6 6F D6 AF FB AA D6 6E D6 0F FA AA DC 71 D6 0F FA AA 08 74 D6 B0 FE AA F4 74 D6 5B 80 AB 07 76 D6 EF 81 AB 00 ; Thief
; E2 72 D6 28 B2 AB EE 70 D6 5A AD AB C6 6F D6 FA AB AB D6 6E D6 5B AA AB DC 71 D6 5B AA AB 08 74 D6 EB AE AB F4 74 D6 A1 B0 AB 07 76 D6 28 B2 AB 00 ; Rogue
; CB B4 AD 63 CF AA F1 B1 AD 9F CB AA 68 B0 AD 3C CA AA 0F AF AD 0D C9 AA 35 B3 AD 0D C9 AA 66 B6 AD C7 CC AA AA B7 AD 0C CE AA 3C B9 AD 63 CF AA 00 ; Civilian
; CB B4 AD 6A BF AA F1 B1 AD 2A BC AA 68 B0 AD 27 BB AA 0F AF AD 0A BA AA 35 B3 AD 0A BA AA 66 B6 AD 3B BD AA AA B7 AD 5A BE AA 3C B9 AD 6A BF AA 00 ; Child
; 43 63 D6 AD FB A8 18 61 D6 6F F4 A8 1E 60 D6 12 F1 A8 0D 5F D6 7E ED A8 27 62 D6 25 F8 A8 44 64 D6 68 FF A8 56 65 D6 5D 83 A9 52 66 D6 80 86 A9 01 ; Ballistician
; 43 63 D6 57 98 A9 18 61 D6 58 91 A9 1E 60 D6 FB 8D A9 0D 5F D6 62 8A A9 27 62 D6 D4 94 A9 44 64 D6 0A 9C A9 56 65 D6 F7 9F A9 52 66 D6 09 A3 A9 01 ; IronBallistician
; 43 63 D6 D6 B4 A9 18 61 D6 B1 AD A9 1E 60 D6 61 AA A9 0D 5F D6 C8 A6 A9 27 62 D6 47 B1 A9 44 64 D6 69 B8 A9 56 65 D6 3E BC A9 52 66 D6 43 BF A9 01 ; KillerBallistician
; 43 63 D6 EF D0 A9 18 61 D6 7D C9 A9 1E 60 D6 50 C6 A9 0D 5F D6 D8 C2 A9 27 62 D6 2F CD A9 44 64 D6 C6 D4 A9 56 65 D6 F4 D8 A9 52 66 D6 22 DC A9 01 ; GreatBallistician
; 13 C0 AD 03 80 A6 4A BD AD 23 F8 A5 C7 BB AD 54 F5 A5 86 BA AD 28 F3 A5 85 BE AD 28 F3 A5 99 C1 AD 54 FA A5 D4 C2 AD 17 FD A5 36 C4 AD 03 80 A6 00 ; DarkPrince
; CB F4 AD 04 A9 A5 D1 ED AD 44 97 A5 4E EA AD 12 91 A5 C6 E6 AD CE 8A A5 0B F1 AD CE 8A A5 90 F8 AD 62 9D A5 D9 FB AD C9 A2 A5 00 00 D5 04 A9 A5 01 ; MasterKnightFemale
; CB F4 AD 52 CF AB D1 ED AD 33 BF AB 4E EA AD 9C B9 AB C6 E6 AD E8 B3 AB 0B F1 AD E8 B3 AB 90 F8 AD 3D C4 AB D9 FB AD B0 C9 AB 00 00 D5 52 CF AB 01 ; MageKnightFemale
; B5 A7 AD 89 C9 A2 7A A3 AD 7F BB A2 50 A1 AD B2 B7 A2 97 9F AD 60 B3 A2 78 A5 AD 60 B3 A2 C5 A9 AD 4E C0 A2 7F AB AD 69 C4 A2 79 AD AD 89 C9 A2 01 ; DragonRiderFemale
; B5 A7 AD C1 D8 A1 7A A3 AD 4B CA A1 50 A1 AD 7B C6 A1 97 9F AD 3C C2 A1 78 A5 AD 3C C2 A1 C5 A9 AD 61 CF A1 7F AB AD 9D D3 A1 79 AD AD C1 D8 A1 01 ; DragonknightFemale
; B5 A7 AD 07 91 A2 7A A3 AD 28 82 A2 50 A1 AD 4A FE A1 97 9F AD D6 F9 A1 78 A5 AD D6 F9 A1 C5 A9 AD 3F 87 A2 7F AB AD A1 8B A2 79 AD AD 07 91 A2 01 ; DragonmasterFemale
; 90 9A AD E9 C0 A0 11 98 AD 74 BD A0 F4 96 AD 63 BC A0 BD 95 AD 5A BB A0 5A 99 AD 5A BB A0 D2 9B AD AE BE A0 12 9D AD C8 BF A0 4B 9E AD E9 C0 A0 00 ; ArcherFemale
; 79 CC AD CC DC AA CA C8 AD 84 D6 AA E8 C6 AD DC D3 AA 6D C5 AD AC D0 AA 27 CA AD AC D0 AA D6 CE AD 0B D8 AA 39 D0 AD A2 D9 AA 33 D2 AD CC DC AA 00 ; MyrmidonFemale
; 79 CC AD 2A FA A9 CA C8 AD B6 F3 A9 E8 C6 AD 0C F1 A9 6D C5 AD CD ED A9 27 CA AD CD ED A9 D6 CE AD 3D F5 A9 39 D0 AD DD F6 A9 33 D2 AD 2A FA A9 00 ; SwordmasterFemale
; 90 9A AD 74 AA AA 11 98 AD BB A6 AA F4 96 AD A4 A5 AA BD 95 AD 86 A4 AA 5A 99 AD 86 A4 AA D2 9B AD F6 A7 AA 12 9D AD 2C A9 AA 4B 9E AD 74 AA AA 00 ; SniperFemale
; 79 CC AD 78 8A A4 CA C8 AD 44 83 A4 E8 C6 AD 19 80 A4 6D C5 AD 94 FC A3 27 CA AD 94 FC A3 D6 CE AD FC 84 A4 39 D0 AD EA 86 A4 33 D2 AD 78 8A A4 00 ; HeroFemale
; 13 C0 AD D7 F9 A7 4A BD AD 46 F1 A7 C7 BB AD 34 EE A7 86 BA AD 5C EB A7 85 BE AD 5C EB A7 99 C1 AD 12 F4 A7 D4 C2 AD C6 F6 A7 36 C4 AD D7 F9 A7 00 ; PriestFemale
; 13 C0 AD 84 C1 A6 4A BD AD 52 BA A6 C7 BB AD 22 B8 A6 86 BA AD D4 B5 A6 85 BE AD D4 B5 A6 99 C1 AD A0 BC A6 D4 C2 AD 0D BF A6 36 C4 AD 84 C1 A6 00 ; MageFemale
; 13 C0 AD 34 BE A3 4A BD AD A0 B6 A3 C7 BB AD 91 B4 A3 86 BA AD 6E B2 A3 85 BE AD 6E B2 A3 99 C1 AD E8 B8 A3 D4 C2 AD 9E BB A3 36 C4 AD 34 BE A3 00 ; FireMageFemale
; 13 C0 AD 6F 8F AB 4A BD AD 16 88 AB C7 BB AD F7 85 AB 86 BA AD A2 83 AB 85 BE AD A2 83 AB 99 C1 AD 5A 8A AB D4 C2 AD DD 8C AB 36 C4 AD 6F 8F AB 00 ; ThunderMageFemale
; 13 C0 AD E2 B7 AC 4A BD AD 05 B0 AC C7 BB AD 97 AD AC 86 BA AD 39 AB AC 85 BE AD 39 AB AC 99 C1 AD 6E B2 AC D4 C2 AD 0D B5 AC 36 C4 AD E2 B7 AC 00 ; WindMageFemale
; 13 C0 AD A2 E0 A5 4A BD AD FA D8 A5 C7 BB AD B3 D6 A5 86 BA AD 58 D4 A5 85 BE AD 58 D4 A5 99 C1 AD 55 DB A5 D4 C2 AD 20 DE A5 36 C4 AD A2 E0 A5 00 ; HighPriestFemale
; 13 C0 AD 64 DA A8 4A BD AD 23 D2 A8 C7 BB AD A3 CF A8 86 BA AD 61 CD A8 85 BE AD 61 CD A8 99 C1 AD 71 D4 A8 D4 C2 AD 8F D7 A8 36 C4 AD 64 DA A8 00 ; SageFemale
; E2 72 D6 46 F8 AA EE 70 D6 A2 F3 AA C6 6F D6 61 F2 AA D6 6E D6 D4 F0 AA DC 71 D6 D4 F0 AA 08 74 D6 34 F5 AA F4 74 D6 C1 F6 AA 07 76 D6 46 F8 AA 00 ; ThiefFemale
; E2 72 D6 88 A8 AB EE 70 D6 C8 A3 AB C6 6F D6 71 A2 AB D6 6E D6 DF A0 AB DC 71 D6 DF A0 AB 08 74 D6 5D A5 AB F4 74 D6 0D A7 AB 07 76 D6 88 A8 AB 00 ; RogueFemale
; CB B4 AD 97 C7 AA F1 B1 AD 46 C3 AA 68 B0 AD E1 C1 AA 0F AF AD 8F C0 AA 35 B3 AD 8F C0 AA 66 B6 AD 99 C4 AA AA B7 AD 13 C6 AA 3C B9 AD 97 C7 AA 00 ; CivilianFemale
; CB B4 AD EA B8 AA F1 B1 AD 7F B5 AA 68 B0 AD 89 B4 AA 0F AF AD 5C B3 AA 35 B3 AD 5C B3 AA 66 B6 AD 93 B6 AA AA B7 AD BF B7 AA 3C B9 AD EA B8 AA 00 ; ChildFemale
; CB F4 AD 10 F6 A4 D1 ED AD 49 ED A4 4E EA AD 2A EA A4 C6 E6 AD 05 E7 A4 0B F1 AD 05 E7 A4 90 F8 AD 3A F0 A4 D9 FB AD 13 F3 A4 00 00 D5 10 F6 A4 01 ; 

; 9E/C6FB













; E9 C0 A3 - fire mage 
; $A3C0E9


      rlUnknown9ED337 ; 9E/D337

        .al
        .autsiz
        .databank ?

        phy
        phx
        lda #0
        sta $7F4580
        sta $7F4582
        sta $7F4584
        sta $7F5091
        sta aProcSystem.aHeaderBitfield,b,x

        lda #$FFFF
        sta $7F45A4
        sta $7F45A6
        jsl $9E88CE
        jsl $9E87A4
        lda #0
        jsl $9E8867
        plx
        lda #$D1F3
        sta aProcSystem.aHeaderOnCycle,b,x
        ply
        rtl

        .databank 0

        ; 9E/D372

















      bRNGUnknown1 .byte ? ; $0004A4
      bRNGUnknown2 .byte ? ; $0004A5




      rlProcUnknown9ED441Init ; 9E/D449

        .al
        .autsiz
        .databank ?

        phy
        phx
        phb
        pea $7F00
        plb
        plb

        lda #0
        sta $7F4580
        sta $7F4582
        sta $7F4584
        sta $7F455A
        sta $7F4572
        sta $7F4C87
        sta $7F4BE9
        sta $7F4C07
        sta $4C11,b
        sta $4C13,b

        lda #$FFFF
        sta $7F45A4
        sta $7F45A6
        sta $7F45A8
        sta $7F45AA

        lda $7E4EBF
        sta @l wR0
        lda $7E4EC1
        sta @l wR1
        lda $7E4EBD
        sta @l wR2
        jsl rlUnknown9E85A4
        sta $454E,b
        lda $7E4EB7
        sta $4552,b
        lda $7E4EB9
        sta $4554,b

        lda #$FFFF
        jsl rlUnknown9E866F
        sta $45A4,b

        lda #$FFFF
        sta $7E4EDD

        lda #0
        sta $4550,b
        sta $4556,b
        sta $4558,b
        sta $454C,b

        lda #$FFFF
        sta $7E4F15

        lda #6
        sta $455E,b
        sta $4560,b

        lda #0
        sta $508F,b
        sta $459E,b
        sta $7E4F85

        lda #5
        sta $4BF3,b

        plb
        lda #(`rlUnknown81841B)<<8
        sta $0015E4+1
        lda #<>rlUnknown81841B
        sta $0015E4
        plx

        lda $000302
        sta aProcSystem.aBody7,x
        stz $0302,b

        lda #0
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlUnknown88CD53
        jsl rlUnknown88CD61
        ply
        rtl

        .databank 0

        ; 9E/D528











      rlProcUnknown9ED441Cycle1 ; 9E/D609

        .al
        .autsiz
        .databank ?

        phx
        phy
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda @l $7F455E
        asl a
        clc
        adc @l $7F455E
        asl a
        sta wR0

        lda @l $7F454E
        sta wR10
        lda #$0031
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12
        clc
        adc wR0
        and #$0003
        tax
        lda aBattleMapSpriteData+1,x
        sta lR18+1
        lda aBattleMapSpriteData,x
        sta lR18

        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #0
        sta lR19
        plp
        plb
        jsl rlAppendDecompList
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda #(`$ACCC17)<<8
        sta lR18+1
        lda #<>$ACCC17
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$4000
        sta lR19
        plp
        plb
        jsl rlAppendDecompList
        ply
        plx
        lda #<>rlProcUnknown9ED441Cycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlUnknown9EF791 ; 9E/F791

        .al
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #~$0002
        sta aProcSystem.aHeaderBitfield,b,x
        plx
        rtl

        .databank 0

      rlProcUnknown9EF837Init ; 9E/F83F

        .al
        .autsiz
        .databank $7F

        phy
        phx
        phb

        jsl rlUnknown9EFA17

        pea #$7F00
        plb
        plb

        lda #0
        sta $4580,b
        sta $4582,b
        sta $4584,b
        sta @l $7F545A
        sta @l $7F5472
        sta @l $7F5091
        sta @l $7F5093
        sta @l $7F4C07

        lda #2
        sta @l $7F4C87

        lda aScriptedUnitMapAction + structScriptedMapAttack.wDeploymentOffset
        sta aActionStructUnit1.DeploymentNumber
        sta aActionStructUnit2.DeploymentNumber

        lda aScriptedUnitMapAction + structScriptedMapAttack.wClass
        sta @l wR0
        lda aScriptedUnitMapAction + structScriptedMapAttack.wGender
        sta @l wR1
        lda aScriptedUnitMapAction + structScriptedMapAttack.wCharacterID
        sta @l wR2
        jsl $9E85A4
        sta aMapAction.wBattleClassID

        lda aScriptedUnitMapAction + structScriptedMapAttack.wXTilePosition
        sta $4552,b
        lda aScriptedUnitMapAction + structScriptedMapAttack.wYTilePosition
        sta $4554,b
        lda #$FFFF
        jsl $9E866F
        sta aMapAction.wWeaponType

        lda #$FFFF
        sta $7E4EDD

        lda #0
        sta aMapAction.wUnknown7F4450
        sta aMapAction.wUnknown7F4556
        sta aMapAction.wUnknown7F4558
        sta aMapAction.wUnknown7F454C

        lda aProcSystem.wInput0
        sta aMapAction.wUnknown7F455E
        sta aMapAction.wUnknown7F4560

        lda #1
        sta @l aMapAction.wUnknown7F4562

        lda #4
        sta $508B,b
        sta $5089,b
        plb

        ; Set MapScrollPixels
        lda @l aMapAction.wYTilePosition
        tay
        lda @l aMapAction.wXTilePosition
        tax
        jsl $9E8D25

        lda #$8000
        sta @l $7F508F
        lda wR0
        and #$00FF
        sta wR0
        lda wR1
        and #$00FF
        sta wR1

        lda wR1
        xba
        ora wR0
        sta @l $7F5099
        sta @l $7F509B

        lda #(`$81841B)<<8
        sta $0015E4+1
        lda #<>$81841B
        sta $0015E4

        lda aActiveSpriteSystem.wFlag
        sta @l $7F4BD9

        lda aActiveSpriteSystem.wFlag
        ora #$4000
        sta aActiveSpriteSystem.wFlag

        plx
        lda $000302
        sta aProcSystem.aBody7,x
        stz $0302,b

        lda @l $7F4EAF
        sta $7E4EBF
        ply
        rtl

        .databank 0

      rlProcUnknown9EF837Cycle1 ; 9E/F94D

        .al
        .autsiz
        .databank ?

        phx
        phy
        phb
        php

        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        lda @l aMapAction.wUnknown7F455E
        asl a
        clc
        adc @l aMapAction.wUnknown7F455E
        asl a
        sta wR0
        lda @l aMapAction.wBattleClassID
        sta wR10
        lda #49
        sta wR11
        jsl rlUnsignedMultiply16By16

        lda wR12
        clc
        adc wR0
        adc #3
        tax
        lda aBattleMapSpriteData+1,x
        sta lR18+1
        lda aBattleMapSpriteData,x
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #0
        sta lR19
        plp
        plb
        jsl rlAppendDecompList
        phb
        php
        sep #$20
        lda #$7F
        pha
        rep #$20
        plb
        .databank $7F

        ; Load map weapon slashing graphics
        lda #(`$ACCC17)<<8
        sta lR18+1
        lda #<>$ACCC17
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$4000
        sta lR19
        plp
        plb
        jsl rlAppendDecompList
        ply
        plx
        lda #<>rlProcUnknown9EF837Cycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      aProcUnknown9EF837Code ; 9E/F9E0

        PROC_YIELD 42
        PROC_SET_ONCYCLE rlUnknown9ED337
        PROC_YIELD 32
        PROC_CALL rlUnknown9E99F7
        PROC_YIELD 2
        PROC_CALL $9E89F1
        PROC_CALL $9EB3DE
        PROC_YIELD 1
        PROC_CALL rlUnknown9EFA4F
        PROC_YIELD 32
        PROC_CALL rlUnknown9EFA9A
        PROC_CALL $888197
        PROC_YIELD 4
        PROC_CALL $8881A7
        PROC_YIELD 1
        PROC_END

      rlUnknown9EFC47 ; 9E/FC47

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb
        phx
        phy
        lda $7F57F0
        asl a
        clc
        adc $7F57F0
        tax
        lda aUnknown9EFAF8,x
        sta lR18
        lda aUnknown9EFAF8+1,x
        sta lR18+1
        ldy #0

        _Loop
        lda [lR18],y
        cmp #$FFFF
        beq _End

          and #$00FF
          sta wR0
          inc y
          lda [$24],y
          and #$00FF
          sta wR1
          phy
          jsl rlGetUnitByCoordinates
          bcs _Next

            jsl rlGetSelectedUnitDeploymentOffset
            tax
            lda aDeploymentTable._State,x
            ora #DeploymentStateGrayed
            sta aDeploymentTable._State,x

          _Next
          ply
          inc y
          bra _Loop

        _End
        ply
        plx
        plb
        rtl

        .databank 0

      rlUnknown9EFC9B ; 9E/FC9B

        .al
        .autsiz
        .databank ?

        phb
        phk
        plb
        phx
        phy
        lda #0
        sta aProcSystem.aHeaderBitfield,b,x
        sta $7F45CC

        lda $7F57F0
        asl a
        clc
        adc $7F57F0
        tax
        lda aUnknown9EFAF8,x
        sta lR18
        lda aUnknown9EFAF8+1,x
        sta lR18+1
        ldy #0
        
        _Loop
        lda [lR18],y
        cmp #$FFFF
        beq _End

          and #$00FF
          sta wR0
          inc y
          lda [lR18],y
          and #$00FF
          sta wR1
          phy
          jsl rlGetUnitByCoordinates
          bcs _Next

            jsl rlGetSelectedUnitDeploymentOffset
            tax
            lda aDeploymentTable._State,x
            and #~DeploymentStateGrayed
            sta aDeploymentTable._State,x

          _Next
          ply
          inc y
          bra _Loop

        _End
        lda $7F57F0
        inc a
        sta $7F57F0

        ply
        plx
        plb
        rtl

        .databank 0

        ; 9E/FD02

        ; fill 0









      rlUnknown9F86B0 ; 9F/86B0

        .al
        .autsiz
        .databank ?

        lda bDecompressionArrayFlag,b
        bne +

          lda aProcSystem.aHeaderBitfield,b,x
          ora #1
          sta aProcSystem.aHeaderBitfield,b,x

        +
        rtl

        .databank 0

        ; 9F/86BF



      procUnknown828B2B .structProcInfo "ME", rlProcUnknown828B2BInit, rlProcUnknown828B2BCycle, aProcUnknown828B2BCode ; 82/8B2B

        .word 0

      rlFadePaletteToColors ; 9F/8EE1

        .al
        .autsiz
        .databank ?

        ; Call followed by:
        ; .addr palette source in bank $7E
        ; .word color count
        ; .word palette destination offset

        lda aPaletteFading.wMaxSteps,b
        bcc +

          lsr a

        +
        inc a
        cmp aPaletteFading.wCurrentStep,b
        bcs +

          lda #1,s
          adc #6
          sta #1,s
          stz aPaletteFading.wCurrentStep,b
          sec
          rtl

        +
        phx
        phy
        lda #5,s
        tay
        lda $0001,b,y
        sta wR3
        lda $0003,b,y
        sta wR5
        lda $0005,b,y
        tax
        tya
        clc
        adc #6
        sta #5,s

        phb
        pea #$7E7E
        plb
        plb

        ldy #0

          -
          stx aPaletteFading.wCurrentPaletteBufferOffset,b
          sty wR4
          lda (wR3),y
          cmp aBGPaletteBuffer,b,x
          beq +

            tay
            lda aBGPaletteBuffer,b,x
            tax
            lda aPaletteFading.wCurrentStep,b
            jsl rlFadeFromToColorByStep
            ldy wR4
            ldx aPaletteFading.wCurrentPaletteBufferOffset,b
            sta aBGPaletteBuffer,b,x

          +
          inc y
          inc y
          inc x
          inc x
          dec wR5
          bne -

        inc aPaletteFading.wCurrentStep,b
        plb
        ply
        plx
        clc
        rtl

        .databank 0
