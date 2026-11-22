; The active sprite engine: scripted, animated OAM sprites.

    .section ActiveSpriteEngineSection

      .al
      .xl

      aActiveSpriteEngineMainActionTable ; 81/8000
        .word <>rlActiveSpriteEngineReset
        .word <>rlActiveSpriteEngineMainLoop
        .word <>rlActiveSpriteEngineStub

        .word 0

      rsActiveSpriteStub ; 81/8008

        .al
        .autsiz
        .databank ?

        ; Empty rts on-cycle stub for active sprites (used to clear aOnCycle)

        rts

      rlActiveSpriteEngineStub ; 81/8009

        .al
        .autsiz
        .databank ?

        rtl

        .databank 0

      rlActiveSpriteEngineReset ; 81/800A

        .al
        .autsiz
        .databank ?

        rep #$20
        ldx #size(aActiveSpriteSystem.aTypeOffset) -2
        lda #0

          -
          sta aActiveSpriteSystem.aTypeOffset,b,x
          sta aActiveSpriteSystem.aUnknown001260,b,x
          sta aActiveSpriteSystem.aUnknown001280,b,x
          sta aActiveSpriteSystem.aUnknown0012A0,b,x
          dec x
          dec x
          bpl -

        sta aActiveSpriteSystem.wFlag,b
        sta $15E0,b
        sta $15E2,b

        lda #(`rlPushToOAMBuffer)<<8
        sta $15E4+1,b
        lda #<>rlPushToOAMBuffer
        sta $15E4,b
        rtl

        .databank 0

      rlEnableActiveSpriteEngine ; 81/8038

        .al
        .autsiz
        .databank ?

        php
        rep #$20
        lda #ActiveSpriteEngineEnabled
        tsb aActiveSpriteSystem.wFlag,b
        plp
        rtl

        .databank 0

      rlDisableActiveSpriteEngine ; 81/8043

        .al
        .autsiz
        .databank ?

        php
        rep #$20
        lda #ActiveSpriteEngineEnabled
        trb aActiveSpriteSystem.wFlag,b
        plp
        rtl

        .databank 0

      rlActiveSpriteEngineRenderOnScreenOnly ; 81/804E

        .al
        .autsiz
        .databank ?

        php
        rep #$20
        lda #ActiveSpriteEngineRenderOnScreenOnly
        tsb aActiveSpriteSystem.wFlag,b
        plp
        rtl

        .databank 0

      rlActiveSpriteEngineRenderAll ; 81/8059

        .al
        .autsiz
        .databank ?

        php
        rep #$20
        lda #ActiveSpriteEngineRenderOnScreenOnly
        trb aActiveSpriteSystem.wFlag,b
        plp
        rtl

        .databank 0

      rlActiveSpriteEngineSetFlag2000 ; 81/8064

        .al
        .autsiz
        .databank ?

        ; Set ActiveSpriteEngine2000 bit ($2000) in aActiveSpriteSystem.wFlag

        php
        rep #$20
        lda #ActiveSpriteEngine2000
        tsb aActiveSpriteSystem.wFlag,b
        plp
        rtl

        .databank 0

      rlActiveSpriteEngineClearFlag2000 ; 81/806F

        .al
        .autsiz
        .databank ?

        ; Clear ActiveSpriteEngine2000 bit ($2000) in aActiveSpriteSystem.wFlag

        php
        rep #$20
        lda #ActiveSpriteEngine2000
        trb aActiveSpriteSystem.wFlag,b
        plp
        rtl

        .databank 0

      rlActiveSpriteEngineClearAllSprites ; 81/807A

        .al
        .autsiz
        .databank ?

        phx
        ldx #size(aActiveSpriteSystem.aTypeOffset)-2
        
          -
          stz aActiveSpriteSystem.aTypeOffset,b,x
          dec x
          dec x
          bpl -

        plx
        rtl

        .databank 0

      rlActiveSpriteEngineCreateSpriteHighestSlot ; 81/8087

        .al
        .autsiz
        .databank ?

        phb
        phy
        phx

        lda lR44+1
        pha
        plb
        plb

        ldx #size(aActiveSpriteSystem.aTypeOffset)-2

          -
          lda aActiveSpriteSystem.aTypeOffset,x
          beq rlCreateActiveSpriteAbsolute

          dec x
          dec x
          bpl -

        plx
        ply
        plb
        sec
        rtl

        .databank 0

      rlActiveSpriteEngineCreateSpriteLowestSlot ; 81/80A1

        .al
        .autsiz
        .databank ?

        phb
        phy
        phx

        lda lR44+1
        pha
        plb
        plb

        ldx #2
        
          -
          lda aActiveSpriteSystem.aTypeOffset,x
          beq rlCreateActiveSpriteAbsolute

          inc x
          inc x
          cpx #size(aActiveSpriteSystem.aTypeOffset)
          bmi -

        plx
        ply
        plb
        sec
        rtl

        .databank 0

      rlActiveSpriteEngineCreateSpriteLastSlot ; 81/80BE

        .al
        .autsiz
        .databank ?

        phb
        phy
        phx

        lda lR44+1
        pha
        plb
        plb

        ldx #0
        
          -
          lda aActiveSpriteSystem.aTypeOffset,x
          beq rlCreateActiveSpriteAbsolute

          inc x
          inc x
          cpx #size(aActiveSpriteSystem.aTypeOffset)
          bmi -

        plx
        ply
        plb
        sec
        rtl

        .databank 0

      rlCreateActiveSpriteHighestSlotRelative ; 81/80DB

        .al
        .autsiz
        .databank ?

        ; Allocate highest free active sprite slot keeping lR44 as relative struct base

        phb
        phy
        phx

        lda lR44+1
        pha
        plb
        plb

        ldx #size(aActiveSpriteSystem.aTypeOffset)-2

          -
          lda aActiveSpriteSystem.aTypeOffset,x
          beq rlCreateActiveSpriteRelative

          dec x
          dec x
          bpl -

        plx
        ply
        plb
        sec
        rtl

        .databank 0

      rlCreateActiveSpriteAbsolute ; 81/80F5

        .al
        .autsiz
        .databank ?

        ; Clear lR44 for absolute bank offsets then run rlCreateActiveSpriteMain

        lda lR44
        stz lR44
        bra rlCreateActiveSpriteMain

      rlCreateActiveSpriteRelative ; 81/80FB

        .al
        .autsiz
        .databank ?

        ; Load lR44 (preserving struct base) then run rlCreateActiveSpriteMain

        lda lR44

      rlCreateActiveSpriteMain ; 81/80FC

        .al
        .autsiz
        .databank ?

        sta aActiveSpriteSystem.aTypeOffset,x
        tay

        txa
        sta aActiveSpriteSystem.wOffset

        lda @l lR44+1
        and #$FF00
        sta aActiveSpriteSystem.lPointer+1
        xba
        sta aActiveSpriteSystem.aBanks,x

        pla
        sta aActiveSpriteSystem.aUnknown001200,x
        pla
        sta aActiveSpriteSystem.aUnknown001240,x

        lda $0002,b,y
        clc
        adc lR44
        sta aActiveSpriteSystem.aOnCycle,x

        lda #1
        sta aActiveSpriteSystem.aFrameTimer,x

        lda $0004,b,y
        clc
        adc lR44
        sta aActiveSpriteSystem.aCodeOffset,x

        lda #$8006
        sta aActiveSpriteSystem.aFrameOffset,x

        lda #0
        sta aActiveSpriteSystem.aUnknown0011E0,x
        sta aActiveSpriteSystem.aUnknown001220,x
        sta aActiveSpriteSystem.aUpdater,x
        sta aActiveSpriteSystem.aUnknown001260,x
        sta aActiveSpriteSystem.aUnknown001280,x
        sta aActiveSpriteSystem.aUnknown0012A0,x
        sta aActiveSpriteSystem.aUnknown0012C0,x
        sta aActiveSpriteSystem.aUnknown0012E0,x
        sta aActiveSpriteSystem.aUnknown001300,x
        sta aActiveSpriteSystem.aUnknown001320,x
        sta aActiveSpriteSystem.aUnknown001340,x
        sta aActiveSpriteSystem.aUnknown001360,x
        sta aActiveSpriteSystem.aUnknown001380,x
        sta aActiveSpriteSystem.aUnknown0013A0,x
        sta aActiveSpriteSystem.aUnknown0013C0,x
        sta aActiveSpriteSystem.aUnknown0013E0,x

        lda $0000,b,y
        clc
        adc lR44
        sta aActiveSpriteSystem.lPointer
        phk
        pea #<>(+)-1
        jml [aActiveSpriteSystem.lPointer]

        +
        plb
        clc
        rtl

        .databank 0

      rlActiveSpriteEngineMainLoop ; 81/819A

        .al
        .autsiz
        .databank ?

        php
        phb
        phk
        plb
        rep #$30
        bit aActiveSpriteSystem.wFlag,b
        bpl _Disabled

          lda aActiveSpriteSystem.wFlag,b
          bit #ActiveSpriteEngineInactive
          bne ++

          ldx #$001E

            _Loop
            stx aActiveSpriteSystem.wOffset,b
            lda aActiveSpriteSystem.aTypeOffset,b,x
            beq +

              jsr rsActiveSpriteRunOnCycleAndCode
              ldx aActiveSpriteSystem.wOffset,b

            +
            dec x
            dec x
            bpl _Loop

          +
          lda aActiveSpriteSystem.wFlag,b
          bit #ActiveSpriteEngineRenderOnScreenOnly
          beq +

            jsr rsRenderOnScreenActiveSprites

            lda aActiveSpriteSystem.wFlag,b
            bit #ActiveSpriteEngine2000
            beq ++

              jsl rlFlushActiveSpriteOAMQueue2000
              plb
              plp
              rtl

          +
          jsr rsRenderAllActiveSprites

          lda aActiveSpriteSystem.wFlag,b
          bit #ActiveSpriteEngine2000
          beq +

            jsl rlFlushActiveSpriteOAMQueue2000
            plb
            plp
            rtl

          +
          jsl rlFlushActiveSpriteOAMQueue
          plb
          plp
          rtl

        _Disabled
        stz $15E0,b
        stz $15E2,b
        plb
        plp
        rtl

        .databank 0

      rsActiveSpriteRunOnCycleAndCode ; 81/81FE

        .al
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aBanks-1,b,x
        pha
        plb
        plb

        jsl rlActiveSpriteRunOnCycle

        ldx aActiveSpriteSystem.wOffset,b
        dec aActiveSpriteSystem.aFrameTimer,b,x
        bne _End

          ldy aActiveSpriteSystem.aCodeOffset,b,x

            _Loop
            lda $0000,b,y
            and #$00FF
            asl a
            phx
            tax
            lda aActiveSpriteCommandPointers,x
            sta aActiveSpriteSystem.lPointer,b
            plx
            inc y
            pea #<>(_Loop)-1
            jmp (aActiveSpriteSystem.lPointer)

        _End
        rts

        .databank 0

      rlActiveSpriteRunOnCycle ; 81/822C

        .al
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aBanks-1,b,x
        sta aActiveSpriteSystem.lPointer+1,b
        lda aActiveSpriteSystem.aOnCycle,b,x
        sta aActiveSpriteSystem.lPointer,b
        jml [aActiveSpriteSystem.lPointer]

        .databank 0

      aActiveSpriteCommandPointers ; 81/823B

        .word <>rsActiveSpriteCommand00
        .word <>rsActiveSpriteCommand01
        .word <>rsActiveSpriteCommand02
        .word <>rsActiveSpriteCommand03
        .word <>rsActiveSpriteCommand04
        .word <>rsActiveSpriteCommand05
        .word <>rsActiveSpriteCommand06
        .word <>rsActiveSpriteCommand07
        .word <>rsActiveSpriteCommand08
        .word <>rsActiveSpriteCommand09
        .word <>rsActiveSpriteCommand0A
        .word <>rsActiveSpriteCommand0B
        .word <>rsActiveSpriteCommand0C
        .word <>rsActiveSpriteCommand0D
        .word <>rsActiveSpriteCommand0E
        .word <>rsActiveSpriteCommand0F
        .word <>rsActiveSpriteCommand10
        .word <>rsActiveSpriteCommand11
        .word <>rsActiveSpriteCommand12
        .word <>rsActiveSpriteCommand13
        .word <>rsActiveSpriteCommand14
        .word <>rsActiveSpriteCommand15
        .word <>rsActiveSpriteCommand16
        .word <>rsActiveSpriteCommand17
        .word <>rsActiveSpriteCommand18
        .word <>rsActiveSpriteCommand19
        .word <>rsActiveSpriteCommand1A
        .word <>rsActiveSpriteCommand1B
        .word <>rsActiveSpriteCommand1C
        .word <>rsActiveSpriteCommand1D
        .word <>rsActiveSpriteCommand1E

      rsRenderAllActiveSprites ; 81/8279

        .al
        .autsiz
        .databank ?

        ; Render every active sprite slot via jml [$15E4] without bounds checks

        php
        phb
        ldx #$001E
        
          _Loop
          lda aActiveSpriteSystem.aTypeOffset,b,x
          beq _Next

            ldy aActiveSpriteSystem.aFrameOffset,b,x
            lda aActiveSpriteSystem.aUnknown001200,b,x
            and #$00FF
            sta wR0
            lda aActiveSpriteSystem.aUnknown001240,b,x
            and #$00FF
            sta wR1
            lda aActiveSpriteSystem.aUnknown001260,b,x
            sta wR4
            lda aActiveSpriteSystem.aUnknown001280,b,x
            sta wR6
            lda aActiveSpriteSystem.aUnknown0012A0,b,x
            xba
            asl a
            sta wR5
            lda aActiveSpriteSystem.aBanks,b,x
            sep #$20
            phb
            pha
            plb
            rep #$20
            phk
            pea #<>(+)-1
            jml [$15E4]

            +
            plb

          _Next
          dec x
          dec x
          bpl _Loop

        plb
        plp
        rts

        .databank 0

      rsRenderOnScreenActiveSprites ; 81/82C0

        .al
        .autsiz
        .databank ?

        ; Render active sprites with 0 <= X,Y < $0100 via jml [$15E4]

        php
        phb
        ldx #$001E

        _Loop
        lda aActiveSpriteSystem.aTypeOffset,b,x
        beq _Next

          ldy aActiveSpriteSystem.aFrameOffset,b,x
          lda aActiveSpriteSystem.aUnknown001200,b,x
          bmi _Next

          cmp #$0100
          bcs _Next

          and #$00FF
          sta wR0
          lda aActiveSpriteSystem.aUnknown001240,b,x
          bmi _Next

          cmp #$0100
          bcs _Next

          and #$00FF
          sta wR1
          lda aActiveSpriteSystem.aUnknown001260,b,x
          sta wR4
          lda aActiveSpriteSystem.aUnknown001280,b,x
          sta wR6
          lda aActiveSpriteSystem.aUnknown0012A0,b,x
          xba
          asl a
          sta wR5
          lda aActiveSpriteSystem.aBanks,b,x
          sep #$20
          phb
          pha
          plb
          rep #$20
          phk
          pea #<>(+)-1
          jml [$15E4]

          +
          plb

        _Next
        dec x
        dec x
        bpl _Loop

        plb
        plp
        rts

        .databank 0

      rlQueueActiveSpriteOAM ; 81/8315

        .al
        .autsiz
        .databank ?

        ; Unused: append 12-byte sprite draw request into deferred $1400 OAM queue

        php
        sep #$20
        phb
        pla
        rep #$20
        ldx $15E0,b
        and #$00FF
        sta $140A,b,x
        tya
        sta $1400,b,x
        lda wR0
        sta $1402,b,x
        lda wR1
        sta $1404,b,x
        lda wR4
        sta $1406,b,x
        lda wR5
        sta $1408,b,x
        txa
        clc
        adc #12
        sta $15E0,b
        inc $15E2,b
        plp
        rtl

        .databank 0

      rlFlushActiveSpriteOAMQueue ; 81/834A

        .al
        .autsiz
        .databank ?

        ; Flush $1400 deferred sprite queue to rlPushToOAMBuffer in order

        phb
        lda $15E2,b
        beq _End

          lda #0

            _Loop
            tax
            phx
            ldy $1400,b,x
            lda $1402,b,x
            sta $00
            lda $1404,b,x
            sta $02
            lda $1406,b,x
            sta $08
            lda $1408,b,x
            sta $0A
            lda $140A,b,x
            sep #$20
            phb
            pha
            plb
            rep #$20
            jsl rlPushToOAMBuffer
            plb
            pla
            dec $15E2,b
            beq +

              clc
              adc #12
              cmp $15E0,b
              bcc _Loop

          +
          stz $15E0,b
          stz $15E2,b

        _End
        plb
        rtl

        .databank 0

      rlFlushActiveSpriteOAMQueue2000 ; 81/8392

        .al
        .autsiz
        .databank ?

        ; Flag-$2000 queue flush entrypoint (currently jml rlFlushActiveSpriteOAMQueue)

        jml rlFlushActiveSpriteOAMQueue

      rlFlushActiveSpriteOAMQueueSortedByY ; 81/8396

        .al
        .autsiz
        .databank `aActiveSpriteYBucketThresholds

        phb
        phk
        plb
        lda $15E2,b
        beq _End

          ldy #$0020

            _OuterLoop
            lda aActiveSpriteYBucketThresholds,y
            sta wR6
            lda #0

              _InnerLoop
              tax
              lda $1404,b,x
              and #$00F0
              cmp wR6
              bne _Next

                phx
                phy
                ldy $1400,b,x
                lda $1402,b,x
                sta wR0
                lda $1404,b,x
                sta wR1
                lda $1406,b,x
                sta wR4
                lda $1408,b,x
                sta wR5
                lda $140A,b,x
                sep #$20
                phb
                pha
                plb
                rep #$20
                jsl rlPushToOAMBuffer
                plb
                ply
                plx
                dec $15E2,b
                beq +

              _Next
              txa
              clc
              adc #12
              cmp $15E0,b
              bcc _InnerLoop

            dec y
            dec y
            bpl _OuterLoop

          +
          stz $15E0,b
          stz $15E2,b
        
        _End
        plb
        rtl

        .databank 0

      aActiveSpriteYBucketThresholds ; 81/83F9

        .word $0000
        .word $0010
        .word $0020
        .word $0030
        .word $0040
        .word $0050
        .word $0060
        .word $0070
        .word $0080
        .word $0090
        .word $00A0
        .word $00B0
        .word $00C0
        .word $00D0
        .word $00E0
        .word $00F0
        .word $0100

      rlPushToOAMBufferDualTileBase ; 81/841B

        .al
        .autsiz
        .databank ?

        ; OAM sprite pusher for battles/cutscenes: dec Y, apply wR4/wR6 tile base by tile range

        phy
        phx
        dec $02
        lda $0000,b,y
        bne +

          plx
          ply
          rtl

        +
        sta $04
        inc y
        inc y
        ldx wNextFreeSpriteOffset,b
        clc

        _Loop
        lda $0000,b,y
        clc
        adc wR0
        sta $1C00,b,x
        bit #$0100
        beq +

          lda aOAMSizeBitTable,x
          sta wR3
          lda (wR3)
          ora aOAMUpperXBitTable,x
          sta (wR3)

        +
        clc
        lda $0002,b,y
        bit #$0080
        bne +

          and #$007F
          bra ++

          +
          ora #$FF80

        +
        clc
        adc wR1
        sta $1C01,b,x
        clc
        adc #$0010
        cmp #$0100
        bcc +

          lda #$00F0
          sta $1C01,b,x

        +
        clc
        lda $0000,b,y
        bpl +

          lda aOAMSizeBitTable,x
          sta wR3
          lda (wR3)
          ora aOAMUpperXBitTable+2,x
          sta (wR3)

        +
        lda $0003,b,y
        pha
        and #$01FF
        cmp #$0020
        pla
        bcc ++

          pha
          and #$00FF
          cmp #$0040
          pla
          bcs +

          clc
          adc wR4
          bra ++

          +
          clc
          adc wR6

        +
        ora wR5
        sta $1C02,b,x
        txa
        adc #4
        and #$01FF
        tax
        tya
        adc #5
        tay
        dec wR2
        beq +

          jml _Loop

        +
        stx wNextFreeSpriteOffset,b
        plx
        ply
        rtl

        .databank 0

      rsActiveSpriteCommand00 ; 81/84C4

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        and #$00FF
        sta aActiveSpriteSystem.aFrameTimer,b,x
        lda $0001,b,y
        sta aActiveSpriteSystem.aFrameOffset,b,x

        tya
        clc
        adc #3
        sta aActiveSpriteSystem.aCodeOffset,b,x
        pla
        rts

        .databank 0

      rsActiveSpriteCommand18 ; 81/84DD

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        and #$00FF
        sta aActiveSpriteSystem.aFrameTimer,b,x
        lda $0001,b,y
        clc
        adc aActiveSpriteSystem.aTypeOffset,b,x
        sta aActiveSpriteSystem.aFrameOffset,b,x

        tya
        clc
        adc #3
        sta aActiveSpriteSystem.aCodeOffset,b,x
        pla
        rts

        .databank 0

      rsActiveSpriteCommand01 ; 81/84FA

        .al
        .autsiz
        .databank ?

        stz aActiveSpriteSystem.aTypeOffset,b,x
        pla
        rts

        .databank 0

      rsActiveSpriteCommand12 ; 81/84FF

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        and #$00FF
        sta aActiveSpriteSystem.aFrameTimer,b,x
        inc y
        pla
        rts

        .databank 0

      rsActiveSpriteCommandWait ; 81/850B

        .al
        .autsiz
        .databank ?

        ; Unused cmd: back up Y by 2 and re-run current opcode after aFrameTimer expires

        dec y
        dec y
        tya
        sta aActiveSpriteSystem.aCodeOffset,b,x
        pla
        rts

        .databank 0

      rsActiveSpriteCommand13 ; 81/8513

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        sta aActiveSpriteSystem.aFrameTimer,b,x
        inc y
        tya
        sta aActiveSpriteSystem.aCodeOffset,b,x
        pla
        rts

        .databank 0

      rsActiveSpriteCommand14 ; 81/8520

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        sta aActiveSpriteSystem.aOnCycle,b,x
        inc y
        inc y
        rts

        .databank 0

      rsActiveSpriteCommandClearOnCycle ; 81/8529

        .al
        .autsiz
        .databank ?

        ; Unused cmd: set aOnCycle to rsActiveSpriteStub

        lda #<>rsActiveSpriteStub
        sta aActiveSpriteSystem.aOnCycle,b,x
        rts

        .databank 0

      rsActiveSpriteCommand17 ; 81/8530

        .al
        .autsiz
        .databank ?

        lda $111F,b,x
        sta aActiveSpriteSystem.lPointer+1,b
        lda $0000,b,y
        sta aActiveSpriteSystem.lPointer,b
        inc y
        inc y
        phx
        phk
        pea #<>(+)-1
        jml [$10FD]

        +
        plx
        rts

        .databank 0

      rsActiveSpriteCommandCallLong ; 81/8548

        .al
        .autsiz
        .databank ?

        ; Unused cmd: call inline 24-bit subroutine via aActiveSpriteSystem.lPointer

        lda $0000,b,y
        sta aActiveSpriteSystem.lPointer,b
        lda $0001,b,y
        sta aActiveSpriteSystem.lPointer+1,b
        inc y
        inc y
        inc y
        phx
        phk
        pea #<>(+)-1
        jml [$0010FD]

        +
        plx
        rts

        .databank 0

      rsActiveSpriteCommand15 ; 81/8561

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        tay
        rts

        .databank 0

      rsActiveSpriteCommand16 ; 81/8566

        .al
        .autsiz
        .databank ?

        dec y
        lda $0000,b,y
        and #$FF00
        xba
        bpl +

          ora #$FF00

        +
        pha
        tya
        sec
        adc #1,s
        sta #1,s
        ply
        rts

        .databank 0

      rsActiveSpriteCommandSetLoopCounter ; 81/857C

        .al
        .autsiz
        .databank ?

        ; Unused cmd: set aUpdater loop counter from inline word

        lda $0000,b,y
        sta aActiveSpriteSystem.aUpdater,b,x
        inc y
        inc y
        rts

        .databank 0

      rsActiveSpriteCommand02 ; 81/8585

        .al
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUpdater,b,x
        bne rsActiveSpriteCommand15

        inc y
        inc y
        rts

        .databank 0

      rsActiveSpriteCommandLoopRel ; 81/858D

        .al
        .autsiz
        .databank ?

        ; Unused cmd: decrement aUpdater and relative-branch via cmd $16 while non-zero

        dec aActiveSpriteSystem.aUpdater,b,x
        bne rsActiveSpriteCommand16

        inc y
        rts

        .databank 0

      rsActiveSpriteCommandJumpIfByteNonZeroYield ; 81/8594

        .al
        .autsiz
        .databank ?

        ; Unused cmd: jump to inline offset and yield 1 frame if byte at 24-bit addr != 0

        phb
        phx
        lda $0000,b,y
        tax

        sep #$20
        lda $0002,b,y
        pha
        rep #$20
        plb

        lda $0000,b,x
        and #$00FF
        bne +

        inc y
        inc y
        inc y
        inc y
        bra ++

        +
        plb
        lda $0003,b,y
        tay
        plx
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        pla
        rts

        +
        plx
        plb
        rts

        .databank 0

      rsActiveSpriteCommandJumpIfWordZeroYield ; 81/85C2

        .al
        .autsiz
        .databank ?

        ; Unused cmd: jump to inline offset and yield 1 frame if word at 24-bit addr == 0

        phx
        phb
        lda $0000,b,y
        tax

        sep #$20
        lda $0002,b,y
        pha
        rep #$20
        plb

        lda $0000,b,x
        beq +

        inc y
        inc y
        inc y
        inc y
        inc y
        bra ++

        +
        plb
        lda $0003,b,y
        tay
        plx
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        pla
        rts

        +
        plb
        plx
        rts

        .databank 0

      rsActiveSpriteCommandWriteWord ; 81/85EE

        .al
        .autsiz
        .databank ?

        ; Unused cmd: write inline word to inline 24-bit RAM address

        phb
        phx
        lda $0000,b,y
        tax

        sep #$20
        lda $0002,b,y
        pha
        rep #$20

        lda $0003,b,y
        plb
        sta $0000,b,x
        inc y
        inc y
        inc y
        inc y
        inc y
        plx
        plb
        rts

        .databank 0

      rsActiveSpriteCommandJumpIndirectBySide ; 81/860B

        .al
        .autsiz
        .databank ?

        ; Unused cmd: load script Y indirectly from 1 of 2 RAM pointers by aUnknown001320

        phb
        phx
        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq +

        inc y
        inc y
        inc y
        
        +
        lda $0000,b,y
        tax

        sep #$20
        lda $0002,b,y
        pha
        rep #$20
        plb

        lda $0000,b,x
        tay
        plx
        plb
        rts

        .databank 0

      rsActiveSpriteCommand09 ; 81/8629

        .al
        .autsiz
        .databank ?

        phb
        phx
        lda aMapAction.lUnknown7F4589
        tay
        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq +

          lda aMapAction.lUnknown7F458F
          tay

        +
        plx
        plb
        rts

        .databank 0

      rsActiveSpriteCommand0A ; 81/863D

        .al
        .autsiz
        .databank ?

        phb
        phx
        lda aMapAction.lUnknown7F4586
        tay
        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq +

          lda aMapAction.lUnknown7F458C
          tay

        +
        plx
        plb 
        rts

        .databank 0

      rsActiveSpriteCommand0F ; 81/8651

        .al
        .autsiz
        .databank ?

        dec y
        tya
        sta aActiveSpriteSystem.aCodeOffset,b,x
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        jsl rlUnknown8189F3
        pla
        rts

        .databank 0

      rsActiveSpriteCommand19 ; 81/8662

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        xba
        and #$FF00
        bpl +

          ora #$00FF

        +
        xba
        clc
        adc aActiveSpriteSystem.aUnknown001200,b,x
        sta aActiveSpriteSystem.aUnknown001200,b,x

        lda $0000,b,y
        and #$FF00
        bpl +

          ora #$00FF

        +
        xba
        clc
        adc aActiveSpriteSystem.aUnknown001240,b,x
        sta aActiveSpriteSystem.aUnknown001240,b,x
        inc y
        inc y
        rts

        .databank 0

      rsActiveSpriteCommand1D ; 81/868C

        .al
        .autsiz
        .databank ?

        phx
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tax
        jsl rlUnknown9EB4BB
        sta $00

        lda $0000,b,y
        and #$00FF
        ora $00
        jsl rlPlaySoundEffect2
        inc y
        plx
        rts

        .databank 0

      rsActiveSpriteCommand1E ; 81/86A6

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        and #$00FF
        sta wMusicID,b
        inc y
        rts

        .databank 0

      rsActiveSpriteCommand03 ; 81/86B1

        .al
        .autsiz
        .databank ?

        phy
        phx
        lda aActiveSpriteSystem.aUnknown0012E0,b,x
        asl a
        clc
        adc aActiveSpriteSystem.aUnknown0012E0,b,x
        tax

        lda aMapBattleSpriteDMATable,x
        sta $24
        lda aMapBattleSpriteDMATable+1,x
        sta $24+1

        lda $0000,b,y
        and #$00FF
        asl a
        tay

        lda [$24],y
        sta $04
        ldx aActiveSpriteSystem.wOffset,b
        lda aActiveSpriteSystem.aUnknown0012C0,b,x
        asl a
        tax
        lda aUnknown9EB4C9,x
        sta $06
        lda #$7E00
        sta $24+1
        lda #$8B88
        clc
        adc #$1000
        adc $04
        adc $06
        sta $24

        ldx aActiveSpriteSystem.wOffset,b
        lda aActiveSpriteSystem.aUnknown0012E0,b,x
        sta $00

        ldx aActiveSpriteSystem.wOffset,b
        lda aActiveSpriteSystem.aUnknown0012C0,b,x
        asl a
        tax

        lda aUnknown9EB4D7,x
        sta $04
        lda $71
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc $04
        sta $02
        jsl rlUnknown88DD9C
        plx
        ply
        inc y
        rts

        .databank 0

      rsActiveSpriteCommand04 ; 81/8722

        .al
        .autsiz
        .databank ?

        lda #1
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        jsl rlPlayMapBattleHitSFX
        rts

        .databank 0

      rsActiveSpriteCommand05 ; 81/872E

        .al
        .autsiz
        .databank ?

        lda aMapAction.wMapBattleActiveSpriteSyncFlag
        beq +

        dec y
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        pla
        bra ++

        +
        lda #1
        sta aMapAction.wMapBattleActiveSpriteAckFlag

        +
        rts

        .databank 0

      rsActiveSpriteCommand06 ; 81/8746

        .al
        .autsiz
        .databank ?

        lda aMapAction.wMapBattleActiveSpriteSyncFlag
        beq +

        stx $00
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        cmp $00
        beq _End

        lda aMapAction.wMapBattleDefenderAuxSpriteSlot
        cmp $00
        beq _End

        lda #0
        sta aMapAction.wMapBattleActiveSpriteSyncFlag
        bra _End
        
        +
        dec y
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        pla
        
        _End
        rts

        .databank 0

      rsActiveSpriteCommand07 ; 81/8770

        .al
        .autsiz
        .databank ?

        lda aMapAction.wMapBattleActiveSpriteAckFlag
        bne +

          dec y
          lda #1
          sta aActiveSpriteSystem.aFrameTimer,b,x
          pla

        +
        rts

        .databank 0

      rsActiveSpriteCommand08 ; 81/877F

        .al
        .autsiz
        .databank ?

        lda aMapAction.wMapBattlePhaseFlag
        bne +

          dec y
          lda #1
          sta aActiveSpriteSystem.aFrameTimer,b,x
          pla

        +
        rts

        .databank 0

      rsActiveSpriteCommand0B ; 81/878E

        .al
        .autsiz
        .databank ?

        lda aMapAction.lUnknown7F4598
        sta $24
        lda $7F4598+1
        sta $24+1

        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq +

        lda aMapAction.lUnknown7F459B
        sta $24
        lda $7F459B+1
        sta $24+1
        
        +
        ldy #6
        lda [$24],y
        clc
        adc $24
        tay
        rts

        .databank 0

      rsActiveSpriteCommand0C ; 81/87B5

        .al
        .autsiz
        .databank ?

        lda aMapAction.lUnknown7F4598
        sta $24
        lda $7F4598+1
        sta $24+1

        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq +

        lda aMapAction.lUnknown7F459B
        sta $24
        lda $7F459B+1
        sta $24+1
        
        +
        ldy #8
        lda [$24],y
        clc
        adc $24
        tay
        rts

        .databank 0

      rsActiveSpriteCommand0D ; 81/87DC

        .al
        .autsiz
        .databank ?

        phy
        phx
        jsl rlUnknown9E8F6A
        plx
        ply
        rts

        .databank 0

      rsActiveSpriteCommand0E ; 81/87E5

        .al
        .autsiz
        .databank ?

        phx
        phy
        sty $00
        lda aMapAction.lUnknown7F4598
        sta $24
        lda $7F4598+1
        sta $24+1
        sta $28
        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq +

          lda aMapAction.lUnknown7F459B
          sta $24
          lda $7F459B+1
          sta $24+1
          sta $28

        +
        ldy #0
        lda [$24],y
        clc
        adc $24
        sta $27

        ldy $00
        lda $0001,b,y
        and #$00FF
        asl a
        tay
        lda [$27],y
        clc
        adc $24
        sta aActiveSpriteSystem.aFrameOffset,b,x
        ldy $00
        lda $0000,b,y
        and #$00FF
        sta aActiveSpriteSystem.aFrameTimer,b,x
        pla
        clc
        adc #2
        sta aActiveSpriteSystem.aCodeOffset,b,x
        plx
        pla
        rts

        .databank 0

      rsActiveSpriteCommand10 ; 81/883C

        .al
        .autsiz
        .databank ?

        lda #1
        sta $7F5091
        lda #0
        sta $7F5093
        rts

        .databank 0

      rsActiveSpriteCommand11 ; 81/884B

        .al
        .autsiz
        .databank ?

        lda $7F5093
        beq +

        lda #0
        sta $7F5091
        lda #1
        sta aMapAction.wMapBattleActiveSpriteAckFlag
        bra ++
        
        +
        dec y
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        pla
        
        +
        rts

        .databank 0

      rsActiveSpriteCommand1A ; 81/886A

        .al
        .autsiz
        .databank ?

        lda $7F4C17
        beq +

        lda #0
        sta $7F4C17
        bra ++
        
        +
        dec y
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        pla
        
        +
        rts

        .databank 0

      rsActiveSpriteCommand1B ; 81/8882

        .al
        .autsiz
        .databank ?

        lda #1
        sta $7F4C1B
        lda #0
        sta $7F4C1D
        rts

        .databank 0

      rsActiveSpriteCommand1C ; 81/8891

        .al
        .autsiz
        .databank ?

        lda $7F4C1D
        beq +

        lda #0
        sta $7F4C1B
        lda #1
        sta aMapAction.wMapBattleActiveSpriteAckFlag
        bra ++
        
        +
        dec y
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        pla
        
        +
        rts

        .databank 0

        ; 81/88B0

    .endsection ActiveSpriteEngineSection


    .section Unsorted9EB2BASection

      .al
      .xl

      rlPlayMapBattleHitSFX ; 9E/B2BA

        .al
        .xl
        .autsiz
        .databank ?

        ; Play battle hit/miss/crit SFX ($41/$43/$44/$45) with X-coordinate panning

        phy
        phx
        lda $7F4BEB
        and #$0001
        asl a
        tax
        lda $7F4C11,x
        beq _B2D4
        lda $7F4BEB
        and #$0001
        bne _B342

        _B2D4
        lda $7F4BEB
        and #$0001
        asl a
        tax
        lda $7F454A,x
        bne _B2EA
        lda #$0041
        sta wR0
        bra _B315


        _B2EA
        dec a
        bne _B2F4
        lda #$0044
        sta wR0
        bra _B315


        _B2F4
        dec a
        bne _B30E
        lda $7F4BEB
        and #$0020
        beq _B307
        lda #$0045
        sta wR0
        bra _B315


        _B307
        lda #$0041
        sta wR0
        bra _B315


        _B30E
        lda #$0043
        sta wR0
        bra _B315


        _B315
        lda aMapAction.wMapBattleDefenderSpriteSlot
        cmp #$FFFF
        beq _B329
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay
        lda $7F57EA
        bne _B337

        _B329
        lda aMapAction.wMapBattleAttackerSpriteSlot
        cmp #$FFFF
        beq _B342
        tax
        lda aActiveSpriteSystem.aUnknown001200,b,x
        tay

        _B337
        tya
        jsl rlUnknown9EB4BB
        ora wR0
        jsl rlPlaySoundEffect2

        _B342
        plx
        ply
        rtl

        .databank 0

        ; 9E/B345

    .endsection Unsorted9EB2BASection


    .section Table9EB4DFSection

      .al
      .xl

      aMapBattleSpriteDMATable ; 9E/B4DF

        ; Read by rsActiveSpriteCommand03.

        .word $B4F5, $E59E, $9EB4, $0000, $0200, $0400, $0600, $0800
        .word $0A00, $0C00, $0E00, $0000, $0140, $0280, $03C0, $0500
        .word $0640, $0780, $08C0, $0000, $0100, $0200, $0300

        ; 9E/B50D

    .endsection Table9EB4DFSection
