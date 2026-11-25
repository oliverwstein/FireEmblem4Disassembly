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

        ; The active sprite engine's init routine: frees every slot, clears its tile bases
        ; and palette and wFlag (the engine is off), empties the render queue and puts
        ; rlPushToOAMBuffer in lActiveSpriteRenderer.

        rep #$20
        ldx #size(aActiveSpriteSystem.aTypeOffset) -2
        lda #0

          -
          sta aActiveSpriteSystem.aTypeOffset,b,x
          sta aActiveSpriteSystem.aTileBase,b,x
          sta aActiveSpriteSystem.aTileBaseHigh,b,x
          sta aActiveSpriteSystem.aPalette,b,x
          dec x
          dec x
          bpl -

        sta aActiveSpriteSystem.wFlag,b
        sta wActiveSpriteOAMQueuePosition,b
        sta wActiveSpriteOAMQueueCount,b

        lda #(`rlPushToOAMBuffer)<<8
        sta $15E4+1,b
        lda #<>rlPushToOAMBuffer
        sta lActiveSpriteRenderer,b
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

        ; Creates the active sprite whose definition (structActiveSpriteInfo) is at lR44,
        ; in the highest free slot, at X = the X register and Y = the Y register. Carry
        ; set if all 16 slots are taken.

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

      rlActiveSpriteEngineCreateSpriteLowestSlotAbove0 ; 81/80A1

        .al
        .autsiz
        .databank ?

        ; As rlActiveSpriteEngineCreateSpriteHighestSlot, in the lowest free slot from 1
        ; up; slot 0 is never taken.

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

      rlActiveSpriteEngineCreateSpriteLowestSlot ; 81/80BE

        .al
        .autsiz
        .databank ?

        ; As rlActiveSpriteEngineCreateSpriteHighestSlot, in the lowest free slot from 0
        ; up.

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

        ; As rlActiveSpriteEngineCreateSpriteHighestSlot, but the definition's routine and
        ; script offsets count from lR44 (a definition inside a block of data).

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

        ; Fills slot X / 2: the definition, its bank, the position the caller pushed, the
        ; on-cycle routine and script, frame timer 1, aFrameOffset $8006 (in bank $81 that
        ; is an empty sprite array; the first script step replaces it before the sprite is
        ; drawn) and the other fields 0; then runs the init routine.

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
        sta aActiveSpriteSystem.aXPosition,x
        pla
        sta aActiveSpriteSystem.aYPosition,x

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
        sta aActiveSpriteSystem.aXSubpixel,x
        sta aActiveSpriteSystem.aYSubpixel,x
        sta aActiveSpriteSystem.aLoopCounter,x
        sta aActiveSpriteSystem.aTileBase,x
        sta aActiveSpriteSystem.aTileBaseHigh,x
        sta aActiveSpriteSystem.aPalette,x
        sta aActiveSpriteSystem.aMoverIndex,x
        sta aActiveSpriteSystem.aFlags,x
        sta aActiveSpriteSystem.aDirection,x
        sta aActiveSpriteSystem.aStepCounter,x
        sta aActiveSpriteSystem.aSubpixelAccum,x
        sta aActiveSpriteSystem.aUserVar,x
        sta aActiveSpriteSystem.aSubpixelStep,x
        sta aActiveSpriteSystem.aPixelStep,x
        sta aActiveSpriteSystem.aXVelocity,x
        sta aActiveSpriteSystem.aYVelocity,x

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

        ; The active sprite engine's per-frame routine. With wFlag bit 15 clear it only
        ; empties the render queue. Otherwise it steps every live sprite, slot 15 down to
        ; 0 (unless bit 0, which nothing sets), draws them all, or with bit $4000 only
        ; those whose X and Y are 0-255, and flushes the render queue. Bit $2000 picks
        ; rlFlushActiveSpriteOAMQueue2000, which is the same flush.

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
        stz wActiveSpriteOAMQueuePosition,b
        stz wActiveSpriteOAMQueueCount,b
        plb
        plp
        rtl

        .databank 0

      rsActiveSpriteRunOnCycleAndCode ; 81/81FE

        .al
        .autsiz
        .databank ?

        ; One step of sprite X / 2, with DB = its bank: runs the on-cycle routine, counts
        ; the frame timer down, and at 0 runs the script. Each command is a byte, an index
        ; into aActiveSpriteCommandPointers, and its operands (ActiveSpriteEngine.h).
        ; Commands that show a frame, wait or end the sprite end the step; the others read
        ; on.

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

        .word <>rsActiveSpriteCommandFrame
        .word <>rsActiveSpriteCommandEnd
        .word <>rsActiveSpriteCommandJumpWhileCounter
        .word <>rsActiveSpriteCommandMapBattleFrame
        .word <>rsActiveSpriteCommandMapBattleStrike
        .word <>rsActiveSpriteCommandWaitStrikeTaken
        .word <>rsActiveSpriteCommandWaitStrike
        .word <>rsActiveSpriteCommandWaitStrikeDone
        .word <>rsActiveSpriteCommandWaitRound
        .word <>rsActiveSpriteCommandRoundScript
        .word <>rsActiveSpriteCommandAuxRoundScript
        .word <>rsActiveSpriteCommandSideScript
        .word <>rsActiveSpriteCommandSideAuxScript
        .word <>rsActiveSpriteCommandEndRound
        .word <>rsActiveSpriteCommand0E
        .word <>rsActiveSpriteCommandDrawMovingMapSprite
        .word <>rsActiveSpriteCommandStartMapMagic
        .word <>rsActiveSpriteCommandWaitMapMagic
        .word <>rsActiveSpriteCommandWaitFrames
        .word <>rsActiveSpriteCommandWaitWord
        .word <>rsActiveSpriteCommandSetOnCycle
        .word <>rsActiveSpriteCommandJump
        .word <>rsActiveSpriteCommandJumpRelative
        .word <>rsActiveSpriteCommandCall
        .word <>rsActiveSpriteCommandFrameRelative
        .word <>rsActiveSpriteCommandMove
        .word <>rsActiveSpriteCommandWaitBoltSignal
        .word <>rsActiveSpriteCommandFireBolt
        .word <>rsActiveSpriteCommandWaitBoltDone
        .word <>rsActiveSpriteCommandSound
        .word <>rsActiveSpriteCommandSetMusic

      rsRenderAllActiveSprites ; 81/8279

        .al
        .autsiz
        .databank ?

        ; Render every active sprite slot via jml [lActiveSpriteRenderer] without bounds checks

        php
        phb
        ldx #$001E
        
          _Loop
          lda aActiveSpriteSystem.aTypeOffset,b,x
          beq _Next

            ldy aActiveSpriteSystem.aFrameOffset,b,x
            lda aActiveSpriteSystem.aXPosition,b,x
            and #$00FF
            sta wR0
            lda aActiveSpriteSystem.aYPosition,b,x
            and #$00FF
            sta wR1
            lda aActiveSpriteSystem.aTileBase,b,x
            sta wR4
            lda aActiveSpriteSystem.aTileBaseHigh,b,x
            sta wR6
            lda aActiveSpriteSystem.aPalette,b,x
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
            jml [lActiveSpriteRenderer]

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

        ; Render active sprites with 0 <= X,Y < $0100 via jml [lActiveSpriteRenderer]

        php
        phb
        ldx #$001E

        _Loop
        lda aActiveSpriteSystem.aTypeOffset,b,x
        beq _Next

          ldy aActiveSpriteSystem.aFrameOffset,b,x
          lda aActiveSpriteSystem.aXPosition,b,x
          bmi _Next

          cmp #$0100
          bcs _Next

          and #$00FF
          sta wR0
          lda aActiveSpriteSystem.aYPosition,b,x
          bmi _Next

          cmp #$0100
          bcs _Next

          and #$00FF
          sta wR1
          lda aActiveSpriteSystem.aTileBase,b,x
          sta wR4
          lda aActiveSpriteSystem.aTileBaseHigh,b,x
          sta wR6
          lda aActiveSpriteSystem.aPalette,b,x
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
          jml [lActiveSpriteRenderer]

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

        ; Nothing calls this. Adds a 12-byte entry (sprite array, X, Y, tile base,
        ; attributes, bank) to aActiveSpriteOAMQueue for the flush after the sprites are
        ; drawn.

        php
        sep #$20
        phb
        pla
        rep #$20
        ldx wActiveSpriteOAMQueuePosition,b
        and #$00FF
        sta $140A,b,x
        tya
        sta aActiveSpriteOAMQueue,b,x
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
        sta wActiveSpriteOAMQueuePosition,b
        inc wActiveSpriteOAMQueueCount,b
        plp
        rtl

        .databank 0

      rlFlushActiveSpriteOAMQueue ; 81/834A

        .al
        .autsiz
        .databank ?

        ; Draws the entries of aActiveSpriteOAMQueue in order through rlPushToOAMBuffer
        ; and empties it. Only rlQueueActiveSpriteOAM fills the queue, so it is always
        ; empty.

        phb
        lda wActiveSpriteOAMQueueCount,b
        beq _End

          lda #0

            _Loop
            tax
            phx
            ldy aActiveSpriteOAMQueue,b,x
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
            dec wActiveSpriteOAMQueueCount,b
            beq +

              clc
              adc #12
              cmp wActiveSpriteOAMQueuePosition,b
              bcc _Loop

          +
          stz wActiveSpriteOAMQueuePosition,b
          stz wActiveSpriteOAMQueueCount,b

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

        ; Nothing calls this. Draws the queue's entries by their Y position in 16-line
        ; bands, bottom band first.

        phb
        phk
        plb
        lda wActiveSpriteOAMQueueCount,b
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
                ldy aActiveSpriteOAMQueue,b,x
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
                dec wActiveSpriteOAMQueueCount,b
                beq +

              _Next
              txa
              clc
              adc #12
              cmp wActiveSpriteOAMQueuePosition,b
              bcc _InnerLoop

            dec y
            dec y
            bpl _OuterLoop

          +
          stz wActiveSpriteOAMQueuePosition,b
          stz wActiveSpriteOAMQueueCount,b
        
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

        ; A renderer for lActiveSpriteRenderer (the map battle, map actions and cutscenes
        ; install it), with the inputs of rlPushToOAMBuffer plus wR6. Each entry's tile
        ; below $20 is used as it is; $20-$3F gets wR4 added, $40 and up wR6. The Y offset
        ; counts one line higher than rlPushToOAMBuffer's.

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

      rsActiveSpriteCommandFrame ; 81/84C4

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

      rsActiveSpriteCommandFrameRelative ; 81/84DD

        .al
        .autsiz
        .databank ?

        ; Command $18: like $00, but the frame's offset counts from the sprite's definition (aTypeOffset).

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

      rsActiveSpriteCommandEnd ; 81/84FA

        .al
        .autsiz
        .databank ?

        stz aActiveSpriteSystem.aTypeOffset,b,x
        pla
        rts

        .databank 0

      rsActiveSpriteCommandWaitFrames ; 81/84FF

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

        ; Not in the command table. Would leave the script on the command before this one.

        dec y
        dec y
        tya
        sta aActiveSpriteSystem.aCodeOffset,b,x
        pla
        rts

        .databank 0

      rsActiveSpriteCommandWaitWord ; 81/8513

        .al
        .autsiz
        .databank ?

        ; Command $13: like $12, but reads the frame count as a word although it skips only one byte, so the next command's byte is its high byte.

        lda $0000,b,y
        sta aActiveSpriteSystem.aFrameTimer,b,x
        inc y
        tya
        sta aActiveSpriteSystem.aCodeOffset,b,x
        pla
        rts

        .databank 0

      rsActiveSpriteCommandSetOnCycle ; 81/8520

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

        ; Not in the command table. Sets the on-cycle routine to rsActiveSpriteStub.

        lda #<>rsActiveSpriteStub
        sta aActiveSpriteSystem.aOnCycle,b,x
        rts

        .databank 0

      rsActiveSpriteCommandCall ; 81/8530

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

        ; Not in the command table. Calls the long routine in the next three bytes.

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

      rsActiveSpriteCommandJump ; 81/8561

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        tay
        rts

        .databank 0

      rsActiveSpriteCommandJumpRelative ; 81/8566

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

        ; Not in the command table: set the aLoopCounter loop counter from inline word

        lda $0000,b,y
        sta aActiveSpriteSystem.aLoopCounter,b,x
        inc y
        inc y
        rts

        .databank 0

      rsActiveSpriteCommandJumpWhileCounter ; 81/8585

        .al
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aLoopCounter,b,x
        bne rsActiveSpriteCommandJump

        inc y
        inc y
        rts

        .databank 0

      rsActiveSpriteCommandLoopRel ; 81/858D

        .al
        .autsiz
        .databank ?

        ; Not in the command table: decrement aLoopCounter and relative-branch via cmd $16 while non-zero

        dec aActiveSpriteSystem.aLoopCounter,b,x
        bne rsActiveSpriteCommandJumpRelative

        inc y
        rts

        .databank 0

      rsActiveSpriteCommandJumpIfByteNonZeroYield ; 81/8594

        .al
        .autsiz
        .databank ?

        ; Not in the command table. If the byte at the long address in the operand is not
        ; 0, jumps to the next word and ends the step.

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

        ; Not in the command table. If the word at the long address in the operand is 0,
        ; jumps to the next word and ends the step.

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

        ; Not in the command table. Writes the word after the long address in the operand
        ; to that address.

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

        ; Not in the command table. Continues at the word stored at one of two long
        ; addresses, by the sprite's aStepCounter.

        phb
        phx
        lda aActiveSpriteSystem.aStepCounter,b,x
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

      rsActiveSpriteCommandRoundScript ; 81/8629

        .al
        .autsiz
        .databank ?

        ; Command $09: jumps to the side's round script (aMapAction.lAttackerRoundScript, lDefenderRoundScript for aStepCounter 1).

        phb
        phx
        lda aMapAction.lAttackerRoundScript
        tay
        lda aActiveSpriteSystem.aStepCounter,b,x
        beq +

          lda aMapAction.lDefenderRoundScript
          tay

        +
        plx
        plb
        rts

        .databank 0

      rsActiveSpriteCommandAuxRoundScript ; 81/863D

        .al
        .autsiz
        .databank ?

        ; Command $0A: jumps to the side's aux round script.

        phb
        phx
        lda aMapAction.lAttackerAuxRoundScript
        tay
        lda aActiveSpriteSystem.aStepCounter,b,x
        beq +

          lda aMapAction.lDefenderAuxRoundScript
          tay

        +
        plx
        plb 
        rts

        .databank 0

      rsActiveSpriteCommandDrawMovingMapSprite ; 81/8651

        .al
        .autsiz
        .databank ?

        ; Command $0F: draws the moving map sprite (rlDrawMovingMapSprite) every frame, staying on this command.

        dec y
        tya
        sta aActiveSpriteSystem.aCodeOffset,b,x
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        jsl rlDrawMovingMapSprite
        pla
        rts

        .databank 0

      rsActiveSpriteCommandMove ; 81/8662

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
        adc aActiveSpriteSystem.aXPosition,b,x
        sta aActiveSpriteSystem.aXPosition,b,x

        lda $0000,b,y
        and #$FF00
        bpl +

          ora #$00FF

        +
        xba
        clc
        adc aActiveSpriteSystem.aYPosition,b,x
        sta aActiveSpriteSystem.aYPosition,b,x
        inc y
        inc y
        rts

        .databank 0

      rsActiveSpriteCommandSound ; 81/868C

        .al
        .autsiz
        .databank ?

        phx
        lda aActiveSpriteSystem.aXPosition,b,x
        tax
        jsl rlGetSoundPanFromXPixel
        sta $00

        lda $0000,b,y
        and #$00FF
        ora $00
        jsl rlPlaySoundEffect2
        inc y
        plx
        rts

        .databank 0

      rsActiveSpriteCommandSetMusic ; 81/86A6

        .al
        .autsiz
        .databank ?

        lda $0000,b,y
        and #$00FF
        sta wMusicID,b
        inc y
        rts

        .databank 0

      rsActiveSpriteCommandMapBattleFrame ; 81/86B1

        .al
        .autsiz
        .databank ?

        ; Command $03 (ACTIVE_SPRITE_MAP_BATTLE_FRAME): uploads frame N of the map battle side's frame tiles (aMapBattleSpriteDMATable by the sprite's aFlags, the tall flag; the side in aMoverIndex) to its frame VRAM.

        phy
        phx
        lda aActiveSpriteSystem.aFlags,b,x
        asl a
        clc
        adc aActiveSpriteSystem.aFlags,b,x
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
        lda aActiveSpriteSystem.aMoverIndex,b,x
        asl a
        tax
        lda aMapBattleSideGraphicsOffsets,x
        sta $06
        lda #(`aDecompressionBuffer)<<8
        sta $24+1
        lda #<>aDecompressionBuffer
        clc
        adc #$1000
        adc $04
        adc $06
        sta $24

        ldx aActiveSpriteSystem.wOffset,b
        lda aActiveSpriteSystem.aFlags,b,x
        sta $00

        ldx aActiveSpriteSystem.wOffset,b
        lda aActiveSpriteSystem.aMoverIndex,b,x
        asl a
        tax

        lda aMapBattleSideFrameVRAM,x
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
        jsl rlUploadMapSpriteFrame
        plx
        ply
        inc y
        rts

        .databank 0

      rsActiveSpriteCommandMapBattleStrike ; 81/8722

        .al
        .autsiz
        .databank ?

        ; Command $04: the strike lands: sets wMapBattleStrikeSignal and plays the hit sound.

        lda #1
        sta aMapAction.wMapBattleStrikeSignal
        jsl rlPlayMapBattleHitSFX
        rts

        .databank 0

      rsActiveSpriteCommandWaitStrikeTaken ; 81/872E

        .al
        .autsiz
        .databank ?

        ; Command $05: waits until wMapBattleStrikeSignal is clear, then sets wMapBattleStrikeDone.

        lda aMapAction.wMapBattleStrikeSignal
        beq +

        dec y
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        pla
        bra ++

        +
        lda #1
        sta aMapAction.wMapBattleStrikeDone

        +
        rts

        .databank 0

      rsActiveSpriteCommandWaitStrike ; 81/8746

        .al
        .autsiz
        .databank ?

        ; Command $06: waits until wMapBattleStrikeSignal is set; a main (not aux) battle sprite then clears it.

        lda aMapAction.wMapBattleStrikeSignal
        beq +

        stx $00
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        cmp $00
        beq _End

        lda aMapAction.wMapBattleDefenderAuxSpriteSlot
        cmp $00
        beq _End

        lda #0
        sta aMapAction.wMapBattleStrikeSignal
        bra _End
        
        +
        dec y
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        pla
        
        _End
        rts

        .databank 0

      rsActiveSpriteCommandWaitStrikeDone ; 81/8770

        .al
        .autsiz
        .databank ?

        ; Command $07: waits until wMapBattleStrikeDone is set.

        lda aMapAction.wMapBattleStrikeDone
        bne +

          dec y
          lda #1
          sta aActiveSpriteSystem.aFrameTimer,b,x
          pla

        +
        rts

        .databank 0

      rsActiveSpriteCommandWaitRound ; 81/877F

        .al
        .autsiz
        .databank ?

        ; Command $08: waits until wMapBattleRoundRunning is set.

        lda aMapAction.wMapBattleRoundRunning
        bne +

          dec y
          lda #1
          sta aActiveSpriteSystem.aFrameTimer,b,x
          pla

        +
        rts

        .databank 0

      rsActiveSpriteCommandSideScript ; 81/878E

        .al
        .autsiz
        .databank ?

        ; Command $0B: jumps to the side's first script (offset +6 of its sprite data).

        lda aMapAction.lAttackerSpriteData
        sta $24
        lda $7F4598+1
        sta $24+1

        lda aActiveSpriteSystem.aStepCounter,b,x
        beq +

        lda aMapAction.lDefenderSpriteData
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

      rsActiveSpriteCommandSideAuxScript ; 81/87B5

        .al
        .autsiz
        .databank ?

        ; Command $0C: jumps to the side's first aux script (offset +8).

        lda aMapAction.lAttackerSpriteData
        sta $24
        lda $7F4598+1
        sta $24+1

        lda aActiveSpriteSystem.aStepCounter,b,x
        beq +

        lda aMapAction.lDefenderSpriteData
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

      rsActiveSpriteCommandEndRound ; 81/87DC

        .al
        .autsiz
        .databank ?

        ; Command $0D: rlMapBattleEndRoundScripts.

        phy
        phx
        jsl rlMapBattleEndRoundScripts
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
        lda aMapAction.lAttackerSpriteData
        sta $24
        lda $7F4598+1
        sta $24+1
        sta $28
        lda aActiveSpriteSystem.aStepCounter,b,x
        beq +

          lda aMapAction.lDefenderSpriteData
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

      rsActiveSpriteCommandStartMapMagic ; 81/883C

        .al
        .autsiz
        .databank ?

        lda #1
        sta wMapMagicStart
        lda #0
        sta wMapMagicDone
        rts

        .databank 0

      rsActiveSpriteCommandWaitMapMagic ; 81/884B

        .al
        .autsiz
        .databank ?

        lda wMapMagicDone
        beq +

        lda #0
        sta wMapMagicStart
        lda #1
        sta aMapAction.wMapBattleStrikeDone
        bra ++
        
        +
        dec y
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        pla
        
        +
        rts

        .databank 0

      rsActiveSpriteCommandWaitBoltSignal ; 81/886A

        .al
        .autsiz
        .databank ?

        ; Command $1A: waits until wBallistaBoltSignal is set, then clears it.

        lda wBallistaBoltSignal
        beq +

        lda #0
        sta wBallistaBoltSignal
        bra ++
        
        +
        dec y
        lda #1
        sta aActiveSpriteSystem.aFrameTimer,b,x
        pla
        
        +
        rts

        .databank 0

      rsActiveSpriteCommandFireBolt ; 81/8882

        .al
        .autsiz
        .databank ?

        ; Command $1B: sets wBallistaBoltFire (procMapBattleBallistaBolt fires) and clears wBallistaBoltDone.

        lda #1
        sta wBallistaBoltFire
        lda #0
        sta wBallistaBoltDone
        rts

        .databank 0

      rsActiveSpriteCommandWaitBoltDone ; 81/8891

        .al
        .autsiz
        .databank ?

        ; Command $1C: waits until wBallistaBoltDone, then clears wBallistaBoltFire and sets wMapBattleStrikeDone.

        lda wBallistaBoltDone
        beq +

        lda #0
        sta wBallistaBoltFire
        lda #1
        sta aMapAction.wMapBattleStrikeDone
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
        lda wMapBattleRoundEntry
        and #$0001
        asl a
        tax
        lda wMapBattleAttackerBallista,x
        beq _B2D4
        lda wMapBattleRoundEntry
        and #$0001
        bne _B342

        _B2D4
        lda wMapBattleRoundEntry
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
        lda wMapBattleRoundEntry
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
        lda aActiveSpriteSystem.aXPosition,b,x
        tay
        lda $7F57EA
        bne _B337

        _B329
        lda aMapAction.wMapBattleAttackerSpriteSlot
        cmp #$FFFF
        beq _B342
        tax
        lda aActiveSpriteSystem.aXPosition,b,x
        tay

        _B337
        tya
        jsl rlGetSoundPanFromXPixel
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

        ; Read by rsActiveSpriteCommandMapBattleFrame, by wSideTallSprite: the offsets of
        ; a side's eight frames in its decompressed frame tiles.

        .long _Short
        .long _Tall

        _Tall
        .word $0000, $0200, $0400, $0600, $0800, $0A00, $0C00, $0E00

        _Short
        .word $0000, $0140, $0280, $03C0, $0500, $0640, $0780, $08C0

        ; Unreferenced: offsets of four frames of $100 bytes.
        .word $0000, $0100, $0200, $0300

        ; 9E/B50D

    .endsection Table9EB4DFSection
