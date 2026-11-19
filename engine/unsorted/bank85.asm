; Code from bank $85 not yet assigned to a game system.

    .section Unsorted858000Section

      .al
      .xl

      aDialogueBoxTilemap .text ROM[$058000:$058250] ; 85/8000

    .endsection Unsorted858000Section


    .section Unsorted8583F8Section

      .al
      .xl

      rlUnknown8583F8 ; 85/83F8

        .al
        .autsiz
        .databank ?

        php
        phb
        phy
        jsl rlLoadMapMenuEntryPointerFromProcBody
        jsl $858516
        beq +

          jml _849A

        +
        lda wJoy1New
        bit #JOY_A
        beq +

          lda #$000A
          jsl rlUnknown808FAD
          
          jsl rlUnknown8582BA
          lda #1
          sta $00
          lda aProcSystem.aBody6,b,x
          sta $02
          jsl rlUnknown82F3E5
          jsr $8584A1
          bra _End

        +
        lda wJoy1New
        bit #JOY_B
        beq +

          lda #$0021
          jsl rlUnknown808FAD

          jsl rlUnknown8582BA
          jsr $8584A1
          bra _End
        
        +
        jsl $82F3BE
        asl a
        sta $00

        lda wJoy1Repeated
        bit #JOY_Up
        beq _8472

          lda aProcSystem.aBody6,b,x
          sec
          sbc #2
          bpl +

            lda wJoy1New
            bit #JOY_Up
            beq _8472

              lda $00
              dec a

          +
          sta aProcSystem.aBody6,b,x
          lda #6
          jsl $808FAD
          bra _849A
        
        _8472
        lda wJoy1Repeated
        bit #JOY_Down
        beq _849A

          lda aProcSystem.aBody6,b,x
          clc
          adc #2
          cmp $00
          beq +
          bcc +

            lda wJoy1New
            bit #JOY_Down
            beq _849A

              lda #1

          +
          sta aProcSystem.aBody6,b,x
          lda #6
          jsl $808FAD
        
        _849A
        jsr $858542
        
        _End
        ply
        plb
        plp
        rtl

        .databank 0

        ; 85/84A1

    .endsection Unsorted8583F8Section


    .section Unsorted858728Section

      .al
      .xl

      rlUnknown858728 ; 85/8728

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda $0521,b
        bit #$0080
        beq _End

          bit #$0020
          bne _End

            lda $0D79,b
            bit #$0001
            beq +

              jsr $858D18
              lda #$0001
              trb $0D79,b

            +
            jsl $878256

        _End
        plp
        plb
        rtl

        .databank 0

        ; 85/8751

    .endsection Unsorted858728Section


    .section Unsorted858CD3Section

      .al
      .xl

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
          adc #C2I((10, 8), 32) * size(word)
          tax

          ; Load downwards facing tail
          ldy #TilemapEntry(C2I((10, 2)) + C2I((0, 48)), 0, true, false, false) 
          bra +

          _Bottom
          jsl rlGetMapMenuTileIndex
          clc
          adc #C2I((18, 0), 32) * size(word) ; $0024
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

    .endsection Unsorted858CD3Section


    .section Unsorted85A1E7Section

      .al
      .xl

      rlUnknown85A1E7 ; 85/A1E7

        .al
        .autsiz
        .databank ?

        phx
        jsl rlUnknown878921
        jsl rlGetMenuTextStringLength
        plx
        phx
        txa
        clc
        adc wR10
        tax
        lda lR19
        sta lR18
        lda lR19+1
        sta lR18+1
        jsl rlUnknown878921
        plx
        rtl

        .databank 0

    .endsection Unsorted85A1E7Section


    .section Unsorted85ABF6Section

      .al
      .xl

      procUnknown85ABF6 ; 85/ABF6

        .structProcInfo "PS", $85AC02, $85AC40, $85AEAC

    .endsection Unsorted85ABF6Section


    .section Unsorted85ABFESection

      .al
      .xl

      aUnknown85ABFE ; 85/ABFE

        .byte 0, 0, 0, 1

    .endsection Unsorted85ABFESection


    .section Unsorted85AC02Section

      .al
      .xl

      rlUnknown85AC02 ; 85/AC02

        .al
        .autsiz
        .databank ?

        phx
        lda #$0008
        tsb $0788,b

        lda $0302,b
        sta $1077,b,x
        stz $0302,b

        lda #$0078
        sta aProcSystem.aBody6,b,x

        lda #2
        sta $7FEAAC

        stz $89
        stz $87
        stz $85
        stz $83

        jsl $85A227
        jsr $85B009
        jsr $85B07C

        plx
        phx
        lda wActiveFactionSlot,b
        jsl rlGetFactionBattleBannerID
        jsl rlUnknown91AFC2

        plx
        rtl

        .databank 0

        ; 85/AC40

    .endsection Unsorted85AC02Section


    .section Unsorted85B18FSection

      .al
      .xl

      procUnknown85B18F .structProcInfo "PW", rlProcUnknown85B18FInit, rlProcUnknown85B18FCycle1, $85B2D8 ; 85/B18F

        ; 85/B197

    .endsection Unsorted85B18FSection


    .section Unsorted85B1B0Section

      .al
      .xl

      rlProcUnknown85B18FInit ; 85/B1B0

        .al
        .autsiz
        .databank ?

        phx
        lda aProcSystem.wInput0,b
        sta aProcSystem.aBody4,b,x
        lda aProcSystem.wInput1,b
        sta aProcSystem.aBody5,b,x
        lda #1
        sta aProcSystem.aBody6,b,x
        jsl rlUnknown85BC9E
        plx
        lda aProcSystem.aBody4,b,x
        sta wSelectedUnitDataRAMPointer,b
        lda aProcSystem.aBody5,b,x
        sta wCurrentItemDataROMPointer,b
        jsr $85B45C
        bcs +

          lda #$2000
          sta aCurrentTilemapInfo.wBaseTile,b
          jsr $85B489
          jsl $8587E1
          jsl $85A227
          jsl rlFreeHDMAEntry0

        +
        rtl

        .databank 0

      rlProcUnknown85B18FCycle1 ; 85/B1EF

        .al
        .autsiz
        .databank ?

        lda #<>rlProcUnknown85B18FCycle2
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

      rlProcUnknown85B18FCycle2 ; 85/B1F6

        .al
        .autsiz
        .databank ?

        jsr $85B2DA
        jsr $85B307
        jsl $85A234
        lda #$B207
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl

        .databank 0

        ; 85/B207

    .endsection Unsorted85B1B0Section


    .section Unsorted85B81DSection

      .al
      .xl

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
        adc #$027E
        sec
        sbc #32
        clc
        adc wR5
        clc
        adc wR3
        sta wR7

        ; Source offset
        lda #$027E
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

    .endsection Unsorted85B81DSection


    .section Unsorted85B8EESection

      .al
      .xl

      aUnknown85B8EE ; 85/B8EE

        .long 0
        .long 0
        .long $85B8E5

        ; 00 01 01 50 57 06

    .endsection Unsorted85B8EESection


    .section Unsorted85B9D4Section

      .al
      .xl

      rlProcUnknown85B9D4Cycle1 ; 85/B9D4

        .al
        .autsiz
        .databank ?

        lda $04BA,b
        bne +

          jsl $85A234
          lda #$00F7
          jsl $808FA3
          lda aProcSystem.aBody4,b,x
          jsl $808FAD
          lda #$B9F2
          sta aProcSystem.aHeaderOnCycle,b,x

        +
        rtl

        .databank 0

        ; 85/B9F2

    .endsection Unsorted85B9D4Section


    .section Unsorted85BA41Section

      .al
      .xl

      procUnknown85BA41 .structProcInfo "PW", rlProcUnknown85BA41Init, $85BAC7, $858398 ; 85/BA41

        .long $85BA35
        .byte 1

    .endsection Unsorted85BA41Section


    .section Unsorted85BA4DSection

      .al
      .xl

      rlProcUnknown85BA41Init ; 85/BA4D

        .al
        .autsiz
        .databank ?

        jsl rlUnknown85BC9E
        jsl rlUnknown85C0CE

        lda #$016E
        sta aProcSystem.aBody7,b,x
        lda aProcSystem.wInput2,b
        sta aProcSystem.aBody6,b,x
        lda aProcSystem.wInput3,b
        jsl rlGetLocationEventDataEntry
        jsl rlGetEventLocationEntryCastleName
        lda lRoutineVariable,b
        sta lR18
        lda lRoutineVariable+1,b
        sta lR18+1
        jsl rlGetMenuTextStringLength

        lda wR10
        clc
        adc #12
        sta wR0
        ora #$0400
        jsl rlSetMapMenuTilemapArea

        lda #$0020
        sec
        sbc wR0
        lsr a
        ora #$0C00
        jsl rlSetMapMenuPosition

        lda #(`$85BAB3)<<8
        sta lR19+1
        lda #<>$85BAB3
        sta lR19
        ldx #$0102
        lda #$2000
        sta aCurrentTilemapInfo.wBaseTile,b
        jsl rlUnknown85A1E7
        jsl $85877E
        rtl

        .databank 0

        ; 85/BAB3

    .endsection Unsorted85BA4DSection


    .section Unsorted85BC0FSection

      .al
      .xl

      procUnknown85BC0F .structProcInfo "PW", rlProcUnknown85BC0FInit, rlProcUnknown85B9D4Cycle1, $858398 ; 85/BC0F

        .long $85B8EE
        .byte 1

    .endsection Unsorted85BC0FSection


    .section Unsorted85BC1BSection

      .al
      .xl

      rlProcUnknown85BC0FInit ; 85/BC1B

        .al
        .autsiz
        .databank ?

        phx
        jsl rlUnknown85BC9E
        lda #$0093
        sta aProcSystem.aBody5,b,x
        lda aProcSystem.wInput2,b
        jsl rlGetItemNamePointerByItemID
        lda $0571,b
        sta lR18
        lda $0571+1,b
        sta lR18+1
        lda #(`aItemObtainedText)<<8
        sta lR19+1
        lda #<>aItemObtainedText
        sta lR19
        lda aProcSystem.wInput3,b
        ldx #$0400
        jsl $85B7D1
        pha
        dec a
        jsl rlSetMapMenuPosition
        txa
        inc a
        inc a
        jsl rlSetMapMenuTilemapArea
        pla
        and #$FF00
        lda #$2000
        sta aCurrentTilemapInfo.wBaseTile,b
        ldx #$0102
        jsl rlUnknown85A1E7
        jsl $8587E1
        plx
        lda aProcSystem.wInput2,b
        cmp #$0050
        bne +

        lda aProcSystem.aBody5,b,x
        clc
        adc #$003C
        sta aProcSystem.aBody5,b,x
        lda #$0096
        bra ++
        
        +
        lda #$0092
        
        +
        sta aProcSystem.aBody4,b,x
        rtl

        .databank 0

    .endsection Unsorted85BC1BSection


    .section ItemObtainedTextSection

      .al
      .xl

      aItemObtainedText ; 85/BC8C

        .enc "SJIS"
        .text "　をてにいれた！\n"

    .endsection ItemObtainedTextSection


    .section Unsorted85BC9ESection

      .al
      .xl

      rlUnknown85BC9E ; 85/BC9E

        .al
        .autsiz
        .databank ?

        jsl rlStallProcUntilMapMenuDataLoaded
        lda #0
        sta wBufferBG3VOFS
        sta wBufferBG3HOFS
        lda #$20FF
        sta $053C,b
        jsl rlUnknown8788E5
        jsl $85A234
        rtl

        .databank 0

        ; 85/BCB8

    .endsection Unsorted85BC9ESection


    .section Unsorted85C0CESection

      .al
      .xl

      rlUnknown85C0CE ; 85/C0CE

        .al
        .autsiz
        .databank ?

        lda #$0080
        tsb $0788,b
        rtl

        .databank 0

        ; 85/C0D5

    .endsection Unsorted85C0CESection


    .section Unsorted85CA4BSection

      .al
      .xl

      rlUnknown85CA4B ; 85/CA4B

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phx

        lda #(`$85C652)<<8
        sta $62+1
        lda #<>$85C652
        sta $62
        jsl rlProcEngineFindProc
        bcc +

          lda #$C6C6
          sta $0F77,b,x
          lda #1
          sta $0F97,b,x

        +
        plx
        plp
        plb
        rtl

        .databank 0

        ; 85/CA70

    .endsection Unsorted85CA4BSection


    .section Unsorted85DF3FSection

      .al
      .xl

      rlUnknown85DF3F ; 85/DF3F

        .al
        .autsiz
        .databank ?

        phx
        jsl rlUnknown88AF7B
        ldx $0772,b
        jsl rlUnknown84CDA4

        lda #<>$80B6B6
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


    .section Unsorted85DF6FSection

      .al
      .xl

      rlUnknown85DF6F ; 85/DF6F

        .al
        .autsiz
        .databank ?

        phx
        jsl rlUnknown88AF7B
        ldx $0772,b
        jsl rlUnknown84CE21
        plx
        rtl

        .databank 0

        ; 85/DF7D

    .endsection Unsorted85DF6FSection


    .section Unsorted85E33DSection

      .al
      .xl

      rlUnknown85E33D ; 85/E33D

        .al
        .autsiz
        .databank ?

        jsl $858516
        bne _End

          lda wJoy1New
          bit #JOY_A
          beq +
          bra _End

          +
          lda wJoy1New
          bit #JOY_B
          beq _End

            lda $10B7,b,x
            cmp #1
            beq _E37D

            cmp #2
            bne +

              lda $0D87,b
              and #$FFEF
              sta $0D87,b
              bit #$0008
              beq +

                jsl rlUnknown85C0CE

            +
            phx
            jsl $88ADE9
            plx

        _End
        jsl rlUnknown8583F8
        
        -
        rtl

        _E37D
        jsl rlLoadMapMenuEntryPointerFromProcBody
        lda #1
        sta aProcSystem.aBody6,b,x
        jsr $858542
        bra -

        .databank 0

        ; 85/E38C

    .endsection Unsorted85E33DSection


    .section Unsorted85E897Section

      .al
      .xl

      rlUnknown85E897 ; 85/E897

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda #$0018
        trb $0D87,b
        jsl $85C0D5
        plp
        plb
        rtl

        .databank 0

        ; 85/E8A8

    .endsection Unsorted85E897Section
