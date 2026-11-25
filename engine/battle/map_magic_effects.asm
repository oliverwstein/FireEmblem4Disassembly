; The map battle's magic effects, one per tome or staff (bank $9F).
;
; procMapMagicEffect (map_battle_magic.asm) runs one starter from
; aMapMagicEffectStarters when the battler's sprite script reaches
; ACTIVE_SPRITE_START_MAP_MAGIC. The starters are named after their spell
; (rlStartMapMagicFire ...). Each creates procs (rsCreateMapMagicProc), HDMA
; entries (rsCreateMapMagicHDMA) and active sprites that draw the effect over
; the background that the map battle loaded, then sets wMapMagicDone when it
; has finished, usually after rsFadeBackMapMagicColors.
;
; All effect steps, shared HDMA/window builders, and cutscene sequence helpers
; are named; each still carries a note saying which effect uses it ("Part of
; the Thoron effect.", "Shared by ..."), worked out from the references
; between labels starting at the starters. Sprite scripts and data tables
; retain their `aUnknown...` names.


    .section Unsorted9F9217Section

      .al
      .xl

      rlStartMapMagicVillageFire ; 9F/9217

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?

        ; Starts the village raid fire effect (called by rlVillageRaidStartFireEffect). Returns proc slot in A.

        phb
        phk
        plb
        .databank $9F
        phy
        jsr rsSetMapMagicCasterFacing
        jsr rsSaveMapMagicScreenRegisters
        jsr rsSetMapMagicWindowLines
        lda #$0000
        sta wMapMagicProcListEnd
        sta wMapMagicHDMAListEnd
        lda #$FFFF
        sta aMapMagicProcList
        sta aMapMagicHDMAList
        lda #(`procMapMagicVillageFire)<<8
        sta lR44+1
        lda #<>procMapMagicVillageFire
        sta lR44
        jsl rlProcEngineCreateProc
        ply
        plb
        .databank ?
        rtl

        .databank 0

        ; 9F/924B

    .endsection Unsorted9F9217Section


    .section Unsorted9F924BSection

      .al
      .xl

      procMapMagicVillageFire ; 9F/924B

        .structProcInfo "ON", rlMapMagicFireProcInit, rlMapMagicVillageFireInit, aProcMapMagicHaltCode

    .endsection Unsorted9F924BSection


    .section Unsorted9F9253Section

      .al
      .xl

      rlMapMagicVillageFireInit ; 9F/9253

        .al
        .xl
        .autsiz
        .databank ?

        jsr rlMapMagicVillageFireSpawnEffects
        lda #$0020
        sta aProcSystem.aBody4,b,x
        lda #<>rlMapMagicVillageFireWait
        sta aProcSystem.aHeaderOnCycle,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $4C

        rtl

        .databank 0

        ; 9F/926E

    .endsection Unsorted9F9253Section


    .section Unsorted9F926ESection

      .al
      .xl

      rlMapMagicVillageFireWait ; 9F/926E

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody4,b,x
        dec a
        sta aProcSystem.aBody4,b,x
        bne _927D
        lda #<>rlMapMagicVillageFireFadeOut
        sta aProcSystem.aHeaderOnCycle,b,x

        _927D
        rtl

        .databank 0

        ; 9F/927E

      rlMapMagicVillageFireFadeOut ; 9F/927E

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlMapMagicFireStepPaletteAnim
        bcc rlMapMagicVillageFireDone
        lda #<>rlMapMagicVillageFireDone
        sta aProcSystem.aHeaderOnCycle,b,x
        stz aProcSystem.aHeaderTypeOffset,b,x
        jsl rlEndMapMagicEffect
        jsl rlRestoreMapMagicScreenRegisters._847A

        .databank 0

      rlMapMagicVillageFireDone ; 9F/9295

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9F/9296

      rlStartMapMagicFire ; 9F/9296

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aMapMagicFireSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicFireSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        plx
        jsr rsCreateMapMagicProc

          .word <>procMapMagicFire

        rtl

        .databank 0

        ; 9F/92AC


      rlStartMapMagicElfire ; 9F/92AC

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aMapMagicElfireSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicElfireSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        plx
        jsr rsCreateMapMagicProc

          .word <>procMapMagicElfire

        rtl

        .databank 0

      procMapMagicFire ; 9F/92C2

        ; Part of the Fire effect.
        .structProcInfo "ON", rlMapMagicFireProcInit, rlMapMagicFireWaitHit, aProcMapMagicHaltCode

      procMapMagicElfire ; 9F/92CA

        ; Part of the Elfire effect.
        .structProcInfo "ON", rlMapMagicFireProcInit, rlMapMagicElfireWaitHit, aProcMapMagicHaltCode

    .endsection Unsorted9F926ESection


    .section Unsorted9F92D2Section

      .al
      .xl

      rlMapMagicFireProcInit ; 9F/92D2

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elfire and Fire effects.

        jsr rsSetMapMagicLayerBlending
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        jsl rlMapMagicFireStepPaletteAnim
        rtl

        .databank 0

        ; 9F/92F3

    .endsection Unsorted9F92D2Section


    .section Unsorted9F92F3Section

      .al
      .xl

      rlMapMagicFireWaitHit ; 9F/92F3

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fire effect.

        lda $7ECC06
        bne _92FA
        rtl


        _92FA
        lda #<>rlMapMagicFireWaitDone
        sta aProcSystem.aHeaderOnCycle,b,x
        bra rlMapMagicFireWaitDone

        .databank 0

        ; 9F/9302

      rlMapMagicElfireWaitHit ; 9F/9302

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Elfire effect.

        lda $7ECC06
        bne _9309
        rtl


        _9309
        jsr rsMapMagicElfireSpawnEffects
        lda #<>rlMapMagicElfireWaitFade
        sta aProcSystem.aHeaderOnCycle,b,x

        _9312
        rtl

        .databank 0

        ; 9F/9313

      rlMapMagicElfireWaitFade ; 9F/9313

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Elfire effect.

        lda $7ECC08
        beq rlMapMagicElfireWaitHit._9312
        jsl rlMapMagicFireStepPaletteAnim
        bcc rlMapMagicElfireWaitHit._9312
        lda #$0001
        sta wMapMagicDone
        lda #<>rlMapMagicElfireDone
        sta aProcSystem.aHeaderOnCycle,b,x

        .databank 0

        ; 9F/932C

      rlMapMagicElfireDone ; 9F/932C

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Elfire effect.

        rtl

        .databank 0

        ; 9F/932D

      rlMapMagicFireWaitDone ; 9F/932D

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fire effect.

        lda $7ECC08
        beq rlMapMagicFireDone
        lda #$0001
        sta wMapMagicDone
        lda #<>rlMapMagicFireDone
        sta aProcSystem.aHeaderOnCycle,b,x

        .databank 0

      rlMapMagicFireDone ; 9F/9340

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fire effect.

        rtl

        .databank 0

        ; 9F/9341

    .endsection Unsorted9F92F3Section


    .section Unsorted9F9341Section

      .al
      .xl

      rlMapMagicVillageFireSpawnEffects ; 9F/9341

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicFireWindow

        jsr rsCreateMapMagicHDMA

          .word <>aMapMagicVillageFireSpawnParams

        bra rsMapMagicElfireSpawnEffects._9357

        .databank 0

        ; 9F/934D

      rsMapMagicElfireSpawnEffects ; 9F/934D

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Elfire effect.

        jsr rsCreateMapMagicProc

          .word <>procMapMagicElfireWindow

        jsr rsCreateMapMagicHDMA

          .word <>aMapMagicElfireSpawnParams


        _9357
        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBF1

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        rts

        .databank 0

        ; 9F/936C

    .endsection Unsorted9F9341Section


    .section Table9F936CSection

      .al
      .xl

      aMapMagicFireSpriteInfo ; 9F/936C
        .word <>rlMapMagicFireballSpriteInit, <>rlMapMagicFireSpriteDummyInit, <>aMapMagicFireSpriteScript

      aMapMagicElfireSpriteInfo ; 9F/9372
        .word <>rlMapMagicFireballSpriteInit, <>rlMapMagicFireSpriteDummyInit, <>aMapMagicElfireSpriteScript

    .endsection Table9F936CSection


    .section Unsorted9F9378Section

      .al
      .xl

      rlMapMagicFireSpriteDummyInit ; 9F/9378

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elfire and Fire effects.

        rtl

        .databank 0

        ; 9F/9379

      rsMapMagicCalcSpriteVelocityFromAngle ; 9F/9379

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 8 effects.

        lda aActiveSpriteSystem.aUnknown0012E0,b,x
        sta wR0
        lda aActiveSpriteSystem.aUnknown001300,b,x
        jsl rlMultiplyByNegSin._8B84
        ldx aActiveSpriteSystem.wOffset,b
        sta aActiveSpriteSystem.aUnknown0013C0,b,x
        lda aActiveSpriteSystem.aUnknown0012E0,b,x
        sta wR0
        lda aActiveSpriteSystem.aUnknown001300,b,x
        jsl rlMultiplyByNegSin
        ldx aActiveSpriteSystem.wOffset,b
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        rts

        .databank 0

        ; 9F/939E

      rlMapMagicFireballSpriteInit ; 9F/939E

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elfire and Fire effects.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicCasterPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicCasterPixel+1
        and #$00FF
        sec
        sbc #$000C
        and #$01FF
        sta aActiveSpriteSystem.aYPosition,b,x
        lda #$FF40
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown0013C0,b,x
        ldy #$0004
        lda wMapMagicEffect
        cmp #$0000
        beq _93DB
        ldy #$000C

        _93DB
        tya
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

        ; 9F/93E0

      rlMapMagicFireballSpriteRise ; 9F/93E0

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elfire and Fire effects.

        lda aActiveSpriteSystem.aUnknown0013E0,b,x
        sec
        sbc #$0050
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        jsl rlMoveActiveSpriteByVelocity
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _9405
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        lda #$000E
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlMapMagicFireballSpriteDecelAndAim
        sta aActiveSpriteSystem.aOnCycle,b,x

        _9405
        rtl

        .databank 0

        ; 9F/9406

      rlMapMagicFireballSpriteDecelAndAim ; 9F/9406

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elfire and Fire effects.

        lda aActiveSpriteSystem.aUnknown0013E0,b,x
        clc
        adc #$0080
        bmi _9412
        lda #$0000

        _9412
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        jsl rlMoveActiveSpriteByVelocity
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _944E
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aXPosition,b,x
        sta wR0
        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aYPosition,b,x
        sta wR1
        jsl rlGetVectorAngle
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda #$0100
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsMapMagicCalcSpriteVelocityFromAngle
        lda #<>rlMapMagicFireballSpriteFlyToTarget
        sta aActiveSpriteSystem.aOnCycle,b,x

        _944E
        rtl

        .databank 0

        ; 9F/944F

      rlMapMagicFireballSpriteFlyToTarget ; 9F/944F

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elfire and Fire effects.

        lda aActiveSpriteSystem.aUnknown001300,b,x
        clc
        adc #$0040
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsMapMagicCalcSpriteVelocityFromAngle
        jsl rlMoveActiveSpriteByVelocity
        lda wMapMagicTargetPixel
        and #$00FF
        sta wR0
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta wR1
        lda aActiveSpriteSystem.aYPosition,b,x
        cmp wR1
        bmi _94D4
        lda wMapMagicEffect
        cmp #$0000
        bne _94AA
        lda #$0001
        sta $7ECC06
        lda #$000D
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlMapMagicFireballSpriteSignalElfire
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        rtl


        _94AA
        lda #$002D
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlMapMagicFireballSpriteWaitImpact
        sta aActiveSpriteSystem.aOnCycle,b,x
        sta $7ECC06
        lda #$0002
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x

        _94D4
        rtl

        .databank 0

        ; 9F/94D5

      rlMapMagicFireballSpriteWaitImpact ; 9F/94D5

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elfire and Fire effects.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _94ED
        lda #$0008
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlMapMagicFireballSpriteEndFire
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal

        _94ED
        rtl

        .databank 0

        ; 9F/94EE

      rlMapMagicFireballSpriteEndFire ; 9F/94EE

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elfire and Fire effects.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _94FD
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta $7ECC08

        _94FD
        rtl

        .databank 0

        ; 9F/94FE

    .endsection Unsorted9F9378Section


    .section Unsorted9F94FESection

      .al
      .xl

      rlMapMagicFireballSpriteSignalElfire ; 9F/94FE

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elfire and Fire effects.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicFireballSpriteEndElfire._9526
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicFireballSpriteEndElfire
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0020
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

        ; 9F/9517

      rlMapMagicFireballSpriteEndElfire ; 9F/9517

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elfire and Fire effects.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _9526
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta $7ECC08

        _9526
        rtl

        .databank 0

      aMapMagicFireSpriteScript ; 9F/9527

        ; Part of the Fire effect.
        ACTIVE_SPRITE_FRAME 5, aMapMagicFireFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicFirePlayLaunchSound
        ACTIVE_SPRITE_FRAME 1, aMapMagicFireFrame01
        ACTIVE_SPRITE_FRAME 1, aMapMagicFireFrame02
        ACTIVE_SPRITE_FRAME 1, aMapMagicFireFrame03
        ACTIVE_SPRITE_SET_ONCYCLE rlMapMagicFireballSpriteRise

        _953D
        ACTIVE_SPRITE_FRAME 1, aMapMagicFireFrame01
        ACTIVE_SPRITE_FRAME 1, aMapMagicFireFrame02
        ACTIVE_SPRITE_FRAME 1, aMapMagicFireFrame03
        ACTIVE_SPRITE_CALL rlMapMagicFireWaitSpritePhase1
        .word <>_953D

        _954E
        ACTIVE_SPRITE_FRAME 1, aMapMagicFireFrame01
        ACTIVE_SPRITE_FRAME 1, aMapMagicFireFrame02
        ACTIVE_SPRITE_FRAME 1, aMapMagicFireFrame03
        ACTIVE_SPRITE_CALL rlMapMagicFireWaitSpritePhase2
        .word <>_954E
        ACTIVE_SPRITE_CALL rlMapMagicFirePlayImpactSound
        ACTIVE_SPRITE_FRAME 2, aMapMagicFireFrame04
        ACTIVE_SPRITE_FRAME 2, aMapMagicFireFrame05

        _956A
        ACTIVE_SPRITE_FRAME 48, aMapMagicFireFrameEmpty
        ACTIVE_SPRITE_JUMP_RELATIVE _956A

        ; 9F/9570
      rlMapMagicFirePlayLaunchSound ; 9F/9570

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fire effect.

        phy
        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $51

        ply
        rtl

        .databank 0

        ; 9F/957A
      rlMapMagicFirePlayImpactSound ; 9F/957A

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fire effect.

        phy
        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $4B

        ply
        rtl

        .databank 0

        ; 9F/9584
      aMapMagicElfireSpriteScript ; 9F/9584

        ; Part of the Elfire effect.
        ACTIVE_SPRITE_FRAME 5, aMapMagicFireFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicElfirePlayLaunchSound
        ACTIVE_SPRITE_FRAME 1, aMapMagicElfireFrame01
        ACTIVE_SPRITE_FRAME 1, aMapMagicElfireFrame02
        ACTIVE_SPRITE_FRAME 1, aMapMagicElfireFrame03
        ACTIVE_SPRITE_SET_ONCYCLE rlMapMagicFireballSpriteRise

        _959A
        ACTIVE_SPRITE_FRAME 1, aMapMagicElfireFrame04
        ACTIVE_SPRITE_FRAME 1, aMapMagicElfireFrame05
        ACTIVE_SPRITE_FRAME 1, aMapMagicElfireFrame06
        ACTIVE_SPRITE_CALL rlMapMagicFireWaitSpritePhase1
        .word <>_959A

        _95AB
        ACTIVE_SPRITE_FRAME 1, aMapMagicElfireFrame07
        ACTIVE_SPRITE_FRAME 1, aMapMagicElfireFrame08
        ACTIVE_SPRITE_FRAME 1, aMapMagicElfireFrame09
        ACTIVE_SPRITE_CALL rlMapMagicFireWaitSpritePhase2
        .word <>_95AB
        ACTIVE_SPRITE_CALL rlMapMagicElfirePlayImpactSound
        ACTIVE_SPRITE_FRAME 2, aMapMagicElfireFrame10
        ACTIVE_SPRITE_FRAME 2, aMapMagicElfireFrame11

        _95C7
        ACTIVE_SPRITE_FRAME 48, aMapMagicFireFrameEmpty
        ACTIVE_SPRITE_JUMP_RELATIVE _95C7

        ; 9F/95CD
      rlMapMagicElfirePlayLaunchSound ; 9F/95CD

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Elfire effect.

        phy
        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $52

        ply
        rtl

        .databank 0

        ; 9F/95D7
      rlMapMagicElfirePlayImpactSound ; 9F/95D7

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Elfire effect.

        phy
        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $4C

        ply
        rtl

        .databank 0

        ; 9F/95E1
      rlMapMagicFireWaitSpritePhase1 ; 9F/95E1

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elfire and Fire effects.

        lda aActiveSpriteSystem.aUnknown0013A0,b,x
        cmp #$0001
        bne _95EC
        inc y
        inc y
        rtl


        _95EC
        lda $0000,b,y
        tay
        rtl

        .databank 0

        ; 9F/95F1
      rlMapMagicFireWaitSpritePhase2 ; 9F/95F1

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elfire and Fire effects.

        lda aActiveSpriteSystem.aUnknown0013A0,b,x
        cmp #$0002
        bne _95FC
        inc y
        inc y
        rtl


        _95FC
        lda $0000,b,y
        tay
        rtl

        .databank 0

        ; 9F/9601

        ; 9F/9601


      aMapMagicFireFrameEmpty ; 9F/9601

        ; Shared by the Elfire and Fire effects.
        .word 0

      aMapMagicFireFrame01 ; 9F/9603

        ; Part of the Fire effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aMapMagicFireFrame01._Sprites

      aMapMagicFireFrame02 ; 9F/960A

        ; Part of the Fire effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aMapMagicFireFrame02._Sprites

      aMapMagicFireFrame03 ; 9F/9611

        ; Part of the Fire effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aMapMagicFireFrame03._Sprites

      aMapMagicFireFrame04 ; 9F/9618

        ; Part of the Fire effect.
        _Sprites := [[(  -8,  -10), $21, SpriteLarge, $006, 2, 6, false, false]]

        .structSpriteArray aMapMagicFireFrame04._Sprites

      aMapMagicFireFrame05 ; 9F/961F

        ; Part of the Fire effect.
        _Sprites := [[(  -8,   -9), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aMapMagicFireFrame05._Sprites

      aMapMagicElfireFrame01 ; 9F/9626

        ; Part of the Elfire effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aMapMagicElfireFrame01._Sprites

      aMapMagicElfireFrame02 ; 9F/962D

        ; Part of the Elfire effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aMapMagicElfireFrame02._Sprites

      aMapMagicElfireFrame03 ; 9F/9634

        ; Part of the Elfire effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aMapMagicElfireFrame03._Sprites

      aMapMagicElfireFrame04 ; 9F/963B

        ; Part of the Elfire effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $006, 2, 6, false, false]]

        .structSpriteArray aMapMagicElfireFrame04._Sprites

      aMapMagicElfireFrame05 ; 9F/9642

        ; Part of the Elfire effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aMapMagicElfireFrame05._Sprites

      aMapMagicElfireFrame06 ; 9F/9649

        ; Part of the Elfire effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aMapMagicElfireFrame06._Sprites

      aMapMagicElfireFrame07 ; 9F/9650

        ; Part of the Elfire effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $006, 2, 6, false, true]]

        .structSpriteArray aMapMagicElfireFrame07._Sprites

      aMapMagicElfireFrame08 ; 9F/9657

        ; Part of the Elfire effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $008, 2, 6, false, true]]

        .structSpriteArray aMapMagicElfireFrame08._Sprites

      aMapMagicElfireFrame09 ; 9F/965E

        ; Part of the Elfire effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, true]]

        .structSpriteArray aMapMagicElfireFrame09._Sprites

      aMapMagicElfireFrame10 ; 9F/9665

        ; Part of the Elfire effect.
        _Sprites := [[(   0,    3), $00, SpriteSmall, $01C, 2, 6, true, false]]
        _Sprites ..= [[(   0,   -5), $00, SpriteSmall, $00C, 2, 6, true, false]]
        _Sprites ..= [[(  -8,    3), $00, SpriteSmall, $01C, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -5), $00, SpriteSmall, $00C, 2, 6, false, false]]

        .structSpriteArray aMapMagicElfireFrame10._Sprites

      aMapMagicElfireFrame11 ; 9F/967B

        ; Part of the Elfire effect.
        _Sprites := [[(   0,    3), $00, SpriteSmall, $01D, 2, 6, false, false]]
        _Sprites ..= [[(   0,   -5), $00, SpriteSmall, $00D, 2, 6, false, false]]
        _Sprites ..= [[(  -8,    3), $00, SpriteSmall, $01D, 2, 6, true, false]]
        _Sprites ..= [[(  -8,   -5), $00, SpriteSmall, $00D, 2, 6, true, false]]

        .structSpriteArray aMapMagicElfireFrame11._Sprites

    .endsection Unsorted9F94FESection


    .section Unsorted9F9691Section

      .al
      .xl

      rlMapMagicFireStepPaletteAnim ; 9F/9691

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elfire and Fire effects.

        ldy aProcSystem.aBody3,b,x
        lda <>aMapMagicFirePaletteAnim,b,y
        cmp #$FFFF
        beq _96D3
        phx
        tya
        clc
        adc #$000E
        sta aProcSystem.aBody3,b,x
        tyx
        lda <>aMapMagicFirePaletteAnim,b,x
        sta $01D2,b
        lda <>(aMapMagicFirePaletteAnim+2),b,x
        sta $01D4,b
        lda <>(aMapMagicFirePaletteAnim+4),b,x
        sta $01D6,b
        lda <>(aMapMagicFirePaletteAnim+6),b,x
        sta $01D8,b
        lda <>(aMapMagicFirePaletteAnim+8),b,x
        sta $01DA,b
        lda <>(aMapMagicFirePaletteAnim+10),b,x
        sta $01DC,b
        lda <>(aMapMagicFirePaletteAnim+12),b,x
        sta $01DE,b
        plx
        clc
        rtl


        _96D3
        sec
        rtl

        .databank 0

        ; 9F/96D5


      aMapMagicFirePaletteAnim ; 9F/96D5

        ; Shared by the Elfire and Fire effects.
        .word $73FF, $2FFF, $03BF, $02DF, $023F, $017F, $007F
        .word $6BBD, $2BBD, $037D, $029D, $01FD, $015D, $005D
        .word $635A, $275A, $033A, $027A, $01DA, $013A, $005A
        .word $5B18, $2318, $02F8, $0238, $01B8, $0118, $0058
        .word $52D6, $22D6, $02B6, $0216, $0196, $0116, $0056
        .word $4A94, $1E94, $0274, $01D4, $0174, $00F4, $0054
        .word $4252, $1A52, $0232, $01B2, $0152, $00D2, $0032
        .word $3E10, $1610, $01F0, $0170, $0130, $00B0, $0030
        .word $35CE, $15CE, $01AE, $014E, $010E, $00AE, $002E
        .word $2D8C, $118C, $016C, $010C, $00CC, $008C, $002C
        .word $254A, $0D4A, $012A, $00EA, $00AA, $006A, $002A
        .word $1D08, $0D08, $00E8, $00A8, $0088, $0068, $0008
        .word $14C6, $08C6, $00A6, $0086, $0066, $0046, $0006
        .word $0C84, $0484, $0064, $0064, $0044, $0024, $0004
        .word $0442, $0042, $0042, $0022, $0022, $0002, $0002
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $FFFF

      rlStartMapMagicAura ; 9F/97B7

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicAura

        rtl

        .databank 0

      procMapMagicAura ; 9F/97BD

        ; Part of the Aura effect.
        .structProcInfo "ON", rlMapMagicAuraInit, rlMapMagicAuraTintGreen, aProcMapMagicHaltCode

      rlMapMagicAuraInit ; 9F/97C5

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        jsr rsSetMapMagicLayerBlending
        jsr rsSaveMapMagicColors
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        jsl rlMapMagicAuraDone._9860
        rtl

        .databank 0

      rlMapMagicAuraTintGreen ; 9F/97D6

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        jsr rsTintMapMagicColorsGreen
        bcc _97E1
        lda #<>rlMapMagicAuraSpawnEffects
        sta aProcSystem.aHeaderOnCycle,b,x

        _97E1
        rtl


      rlMapMagicAuraSpawnEffects ; 9F/97E2

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        jsr rsCreateMapMagicProc

          .word <>procMapMagicAuraWindow

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBF1

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aMapMagicAuraSpawnParams

        lda wMapMagicTargetPixel
        and #$00FF

        _9807
        jsr rsPlayMapMagicSound

          .byte $60

        lda #<>rlMapMagicAuraWaitStrike
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0028
        sta aProcSystem.aBody0,b,x
        rtl


      rlMapMagicAuraWaitStrike ; 9F/9818

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        dec aProcSystem.aBody0,b,x
        bne _9830
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicAuraWaitFade
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0008
        sta aProcSystem.aBody0,b,x

        _9830
        rtl


      rlMapMagicAuraWaitFade ; 9F/9831

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        dec aProcSystem.aBody0,b,x
        bne _983C
        lda #<>rlMapMagicAuraStepPaletteAnim
        sta aProcSystem.aHeaderOnCycle,b,x

        _983C
        rtl


      rlMapMagicAuraStepPaletteAnim ; 9F/983D

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        jsl rlMapMagicAuraDone._9860
        bcc _984C
        lda #<>rlMapMagicAuraFadeBack
        sta aProcSystem.aHeaderOnCycle,b,x
        jsr rsFreeMapMagicHDMA

        _984C
        rtl


      rlMapMagicAuraFadeBack ; 9F/984D

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        jsr rsFadeBackMapMagicColors
        bcc rlMapMagicAuraDone
        lda #<>rlMapMagicAuraDone
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta wMapMagicDone

      rlMapMagicAuraDone ; 9F/985F

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        rtl


        _9860
        lda #$0003
        sta aProcSystem.aBody2,b,x
        ldy aProcSystem.aBody3,b,x
        lda <>(aMapMagicAuraPalettes+2),b,y
        cmp #$FFFF
        beq aMapMagicAuraPalettes
        phx
        tya
        clc
        adc #$000E
        sta aProcSystem.aBody3,b,x
        tyx
        lda <>(aMapMagicAuraPalettes+2),b,x
        sta $01D2,b
        lda <>(aMapMagicAuraPalettes+4),b,x
        sta $01D4,b
        lda <>(aMapMagicAuraPalettes+6),b,x
        sta $01D6,b
        lda <>(aMapMagicAuraPalettes+8),b,x
        sta $01D8,b
        lda <>(aMapMagicAuraPalettes+10),b,x
        sta $01DA,b
        lda <>(aMapMagicAuraPalettes+12),b,x
        sta $01DC,b
        lda <>(aMapMagicAuraPalettes+14),b,x
        sta $01DE,b
        plx
        clc
        rtl

        .databank 0

      aMapMagicAuraPalettes ; 9F/98A8

        ; Part of the Aura effect.
        .word $6B38, $02D6, $12D6, $1ED6, $2ED6, $3AD6, $46D6
        .word $56D6, $0294, $1294, $1A94, $2A94, $3694, $4294
        .word $4E94, $0252, $0E52, $1A52, $2652, $3252, $3A52
        .word $4652, $0210, $0E10, $1610, $2210, $2A10, $3210
        .word $3E10, $01CE, $09CE, $11CE, $1DCE, $25CE, $2DCE
        .word $35CE, $018C, $098C, $118C, $198C, $218C, $258C
        .word $2D8C, $014A, $094A, $0D4A, $154A, $194A, $214A
        .word $254A, $0108, $0508, $0908, $1108, $1508, $1908
        .word $1D08, $00C6, $04C6, $08C6, $0CC6, $10C6, $10C6
        .word $14C6, $0084, $0084, $0484, $0884, $0884, $0C84
        .word $0C84, $0042, $0042, $0042, $0442, $0442, $0442
        .word $0842, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $FFFF

    .endsection Unsorted9F9691Section


    .section Unsorted9F9954Section

      .al
      .xl

      rlStartMapMagicHeal ; 9F/9954

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Also Naga, Loptous, the broken fire tomes, Charm and Valkyrie: sound $71 and procMapMagicHealingStaff. The other healing staves differ only in the sound.

        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $71

        jsr rsCreateMapMagicProc

          .word <>procMapMagicHealingStaff

        rtl

        .databank 0

        ; 9F/9965

    .endsection Unsorted9F9954Section


    .section Unsorted9F9965Section

      .al
      .xl

      rlStartMapMagicMend ; 9F/9965

        .al
        .xl
        .autsiz
        .databank ?

        ; Sound $72 and procMapMagicHealingStaff.

        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $72

        jsr rsCreateMapMagicProc

          .word <>procMapMagicHealingStaff

        rtl

        .databank 0

        ; 9F/9976

    .endsection Unsorted9F9965Section


    .section Unsorted9F9976Section

      .al
      .xl

      rlStartMapMagicRecover ; 9F/9976

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ; Sound $73 and procMapMagicHealingStaff.

        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $73

        jsr rsCreateMapMagicProc

          .word <>procMapMagicHealingStaff

        rtl

        .databank 0

        ; 9F/9987

    .endsection Unsorted9F9976Section


    .section Unsorted9F9987Section

      .al
      .xl

      rlStartMapMagicPhysic ; 9F/9987

        .al
        .xl
        .autsiz
        .databank ?

        ; Sound $74 and procMapMagicHealingStaff.

        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $74

        jsr rsCreateMapMagicProc

          .word <>procMapMagicHealingStaff

        rtl

        .databank 0

        ; 9F/9998

      rlStartMapMagicFortify ; 9F/9998

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicFortify

        rtl

        .databank 0

        ; 9F/999E

    .endsection Unsorted9F9987Section


    .section Unsorted9F999ESection

      .al
      .xl

      rsMapMagicHealingInitBlendingAndHDMA ; 9F/999E

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Fortify, Heal, Mend, Physic and Recover effects.

        jsr rsSetMapMagicLayerBlending
        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC34

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC77

        rts

        .databank 0

        ; 9F/99BB


      procMapMagicHealingStaff ; 9F/99BB

        .structProcInfo "ON", rlMapMagicHealingInit, rlMapMagicHealingWaitStrike, aProcMapMagicHealingStaffCode

      aProcMapMagicHealingStaffCode ; 9F/99C3

        ; Shared by the Heal, Mend, Physic and Recover effects.
        PROC_YIELD 1
        PROC_CALL rlMapMagicHealingStepPaletteAnim
        PROC_JUMP aProcMapMagicHealingStaffCode

    .endsection Unsorted9F999ESection


    .section Unsorted9F99CESection

      .al
      .xl

      rlMapMagicHealingInit ; 9F/99CE

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Heal, Mend, Physic and Recover effects.

        jsr rsCreateMapMagicProc

          .word <>procMapMagicCircleWindow

        sta aProcSystem.aBody7,b,x
        jsr rsMapMagicHealingInitBlendingAndHDMA
        lda #$0001
        sta aProcSystem.aBody0,b,x
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        rtl

        .databank 0

        ; 9F/99E6

      rlMapMagicHealingWaitStrike ; 9F/99E6

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Heal, Mend, Physic and Recover effects.

        dec aProcSystem.aBody0,b,x
        bne _99FE
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicHealingReverseFade
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0040
        sta aProcSystem.aBody0,b,x

        _99FE
        rtl

        .databank 0

        ; 9F/99FF

      rlMapMagicHealingReverseFade ; 9F/99FF

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Heal, Mend, Physic and Recover effects.

        dec aProcSystem.aBody0,b,x
        bne _9A1D
        ldy aProcSystem.aBody7,b,x
        lda aProcSystem.aBody4,b,y
        eor #$FFFF
        inc a
        sta aProcSystem.aBody4,b,y
        lda #<>rlMapMagicHealingWaitDone
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$000C
        sta aProcSystem.aBody0,b,x

        _9A1D
        rtl

        .databank 0

        ; 9F/9A1E

      rlMapMagicHealingWaitDone ; 9F/9A1E

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Heal, Mend, Physic and Recover effects.

        dec aProcSystem.aBody0,b,x
        bne _9A2A
        lda #$0001
        sta wMapMagicDone

        _9A2A
        rtl

        .databank 0

        ; 9F/9A2B

    .endsection Unsorted9F99CESection


    .section Unsorted9F9A2BSection

      .al
      .xl

      procMapMagicFortify ; 9F/9A2B

        .structProcInfo "ON", rlMapMagicFortifyInit, rlMapMagicFortifySignalStrike, aProcMapMagicHaltCode

      rlMapMagicFortifyInit ; 9F/9A33

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fortify effect.

        jsr rsSetMapMagicLayerBlending
        jsr rsSaveMapMagicColors
        jsr rsCreateMapMagicProc

          .word <>procMapMagicFortifyWindow

        sta aProcSystem.aBody7,b,x
        jsr rsMapMagicHealingInitBlendingAndHDMA
        lda #$0008
        sta aProcSystem.aBody0,b,x
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $75

        rtl

        .databank 0

        ; 9F/9A5C
      rlMapMagicFortifySignalStrike ; 9F/9A5C

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fortify effect.

        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        jsr rsMapMagicFortifyStepPaletteAnim
        lda #<>rlMapMagicFortifyWaitFlash
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0018
        sta aProcSystem.aBody0,b,x
        rtl

        .databank 0

        ; 9F/9A73
      rlMapMagicFortifyWaitFlash ; 9F/9A73

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fortify effect.

        jsr rsMapMagicFortifyStepPaletteAnim
        dec aProcSystem.aBody0,b,x
        bne _9A81
        lda #<>rlMapMagicFortifyFadeToWhite
        sta aProcSystem.aHeaderOnCycle,b,x

        _9A81
        rtl

        .databank 0

        ; 9F/9A82
      rlMapMagicFortifyFadeToWhite ; 9F/9A82

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fortify effect.

        jsr rsMapMagicFortifyStepPaletteAnim
        jsr rsFadeMapMagicColorsToWhite
        bcc _9A99
        jsr rsFreeMapMagicHDMA
        lda #<>rlMapMagicFortifyWaitHold
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0010
        sta aProcSystem.aBody0,b,x

        _9A99
        rtl

        ; Unreferenced; shaped like the palette fade arguments at aMapMagicMeteorFlashBlackData.
        .byte $D6, $00, $05, $00, $FF, $FF

        .databank 0

        ; 9F/9AA0
      rlMapMagicFortifyWaitHold ; 9F/9AA0

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fortify effect.

        dec aProcSystem.aBody0,b,x
        bne _9AAB
        lda #<>rlMapMagicFortifyFadeBack
        sta aProcSystem.aHeaderOnCycle,b,x

        _9AAB
        rtl

        .databank 0

        ; 9F/9AAC
      rlMapMagicFortifyFadeBack ; 9F/9AAC

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fortify effect.

        jsr rsFadeBackMapMagicColors
        bcc rlMapMagicFortifyDone
        lda #<>rlMapMagicFortifyDone
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta wMapMagicDone

        .databank 0

        ; 9F/9ABE
      rlMapMagicFortifyDone ; 9F/9ABE

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fortify effect.

        rtl

        .databank 0

        ; 9F/9ABF

    .endsection Unsorted9F9A2BSection


    .section Unsorted9F9ABFSection

      .al
      .xl

      rlMapMagicHealingStepPaletteAnim ; 9F/9ABF

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Heal, Mend, Physic and Recover effects.

        lda aProcSystem.aBody2,b,x
        beq _9AC9
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _9AC9
        lda #$0003
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc a
        and #$001F
        sta aProcSystem.aBody3,b,x
        asl a
        tax
        lda <>aMapMagicHealingPaletteAnim,b,x
        sta $01D2,b
        lda <>(aMapMagicHealingPaletteAnim+2),b,x
        sta $01D4,b
        lda <>(aMapMagicHealingPaletteAnim+4),b,x
        sta $01D6,b
        lda <>(aMapMagicHealingPaletteAnim+6),b,x
        sta $01D8,b
        lda <>(aMapMagicHealingPaletteAnim+8),b,x
        sta $01DA,b
        lda <>(aMapMagicHealingPaletteAnim+10),b,x
        sta $01DC,b
        lda <>(aMapMagicHealingPaletteAnim+12),b,x
        sta $01DE,b
        plx
        rtl

        .databank 0

        ; 9F/9B08


      aMapMagicHealingPaletteAnim ; 9F/9B08

        ; Shared by the Heal, Mend, Physic and Recover effects.
        .word $7FFF, $7FBD, $7F9C, $7F5A, $7F38, $7EF7, $7ED5, $7E93
        .word $7E72, $7E30, $7E0E, $7DCD, $7DAB, $7D69, $7D48, $7D06
        .word $7D06, $7D48, $7D69, $7DAB, $7DCD, $7E0E, $7E30, $7E72
        .word $7E93, $7ED5, $7EF7, $7F38, $7F5A, $7F9C, $7FBD, $7FFF
        .word $7FFF, $7FBD, $7F9C, $7F5A, $7F38, $7EF7, $7ED5

      rsMapMagicFortifyStepPaletteAnim ; 9F/9B56

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fortify effect.

        lda aProcSystem.aBody2,b,x
        beq _9B60
        dec a
        sta aProcSystem.aBody2,b,x
        rts


        _9B60
        lda #$0003
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc a
        and #$000F
        sta aProcSystem.aBody3,b,x
        asl a
        tax
        lda <>(aMapMagicFortifyPaletteAnim+8),b,x
        sta $01D6,b
        lda <>(aMapMagicFortifyPaletteAnim+6),b,x
        sta $01D8,b
        lda <>(aMapMagicFortifyPaletteAnim+4),b,x
        sta $01DA,b
        lda <>(aMapMagicFortifyPaletteAnim+2),b,x
        sta $01DC,b
        lda <>aMapMagicFortifyPaletteAnim,b,x
        sta $01DE,b
        plx
        rts

        .databank 0

      aMapMagicFortifyPaletteAnim ; 9F/9B93

        ; Part of the Fortify effect.
        .word $03FF, $02B9, $0278, $0216, $01D5, $0153, $00D0, $004E
        .word $004E, $00D0, $0153, $01D5, $01D5, $0216, $0278, $03FF
        .word $03FF, $02B9, $0278, $0216, $01D5, $0153, $00D0, $004E
        .word $004E, $00D0, $0153, $01D5, $01D5, $0216, $0278, $03FF
        .word $03FF, $0278, $0216, $01D5, $01D5, $0153, $00D0, $004E
        .word $004E, $00D0, $0153, $01D5, $0216, $0278, $02B9, $03FF
        .word $03FF, $0278, $0216, $01D5, $01D5

      rlStartMapMagicBerserk ; 9F/9BFD

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicBerserk

        rtl

        .databank 0

      procMapMagicBerserk ; 9F/9C03

        ; Part of the Berserk effect.
        .structProcInfo "ON", rlMapMagicBerserkInit, rlMapMagicBerserkWaitStrike, aProcMapMagicBerserkCode

      rlMapMagicBerserkInit ; 9F/9C0B

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Berserk effect.

        jsr rsSetMapMagicLayerBlending
        jsr rsCreateMapMagicProc

          .word <>procMapMagicBerserkWindow

        sta aProcSystem.aBody7,b,x
        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC34

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC77

        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $76

        lda #$0010
        sta aProcSystem.aBody0,b,x
        rtl


      rlMapMagicBerserkWaitStrike ; 9F/9C47

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Berserk effect.
        dec aProcSystem.aBody0,b,x
        bne rlMapMagicBerserkWaitDone._9C8B
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicBerserkReverseFade
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        rtl


      rlMapMagicBerserkReverseFade ; 9F/9C60

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Berserk effect.

        dec aProcSystem.aBody0,b,x
        bne rlMapMagicBerserkWaitDone._9C8B
        ldy aProcSystem.aBody7,b,x
        lda aProcSystem.aBody4,b,y
        eor #$FFFF
        inc a
        sta aProcSystem.aBody4,b,y
        lda #<>rlMapMagicBerserkWaitDone
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        rtl


      rlMapMagicBerserkWaitDone ; 9F/9C7F

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Berserk effect.

        dec aProcSystem.aBody0,b,x
        bne _9C8B
        lda #$0001
        sta wMapMagicDone

        _9C8B
        rtl

        .databank 0

      aProcMapMagicBerserkCode ; 9F/9C8C

        ; Part of the Berserk effect.
        PROC_YIELD 1
        PROC_CALL rlMapMagicBerserkStepPaletteAnim
        PROC_JUMP aProcMapMagicBerserkCode

      rlMapMagicBerserkStepPaletteAnim ; 9F/9C97

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Berserk effect.

        lda aProcSystem.aBody2,b,x
        beq _9CA1
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _9CA1
        lda #$0001
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc a
        and #$000F
        sta aProcSystem.aBody3,b,x
        asl a
        tax
        lda <>aMapMagicBerserkPaletteAnim,b,x
        sta $01D2,b
        lda <>(aMapMagicBerserkPaletteAnim+2),b,x
        sta $01D4,b
        lda <>(aMapMagicBerserkPaletteAnim+4),b,x
        sta $01D6,b
        lda <>(aMapMagicBerserkPaletteAnim+6),b,x
        sta $01D8,b
        lda <>(aMapMagicBerserkPaletteAnim+8),b,x
        sta $01DA,b
        lda <>(aMapMagicBerserkPaletteAnim+10),b,x
        sta $01DC,b
        lda <>(aMapMagicBerserkPaletteAnim+12),b,x
        sta $01DE,b
        plx
        rtl

        .databank 0

      aMapMagicBerserkPaletteAnim ; 9F/9CE0

        ; Part of the Berserk effect.
        .word $00FF, $53FF, $3FFF, $033F, $02BF, $01BF, $00FF, $00FF
        .word $0C12, $71BF, $701F, $401F, $2C1B, $1C16, $1414, $0C12
        .word $00FF, $53FF, $3FFF, $033F, $02BF, $01BF, $00FF, $00FF

      rlStartMapMagicFenrir ; 9F/9D10

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicFenrir

        rtl

        .databank 0

      procMapMagicFenrir ; 9F/9D16

        ; Part of the Fenrir effect.
        .structProcInfo "ON", rlMapMagicFenrirInit, rlMapMagicFenrirDarken, aProcMapMagicFenrirCode

      rlMapMagicFenrirInit ; 9F/9D1E

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        jsr rsSetMapMagicLayerBlending
        jsr rsSaveMapMagicColors
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C
        rtl


      rlMapMagicFenrirDarken ; 9F/9D38

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.
        jsr rsDarkenMapMagicColors
        bcc _9D49
        lda #<>rlMapMagicFenrirWaitAndSpawn
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0010
        sta aProcSystem.aBody0,b,x

        _9D49
        rtl


      rlMapMagicFenrirWaitAndSpawn ; 9F/9D4A

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        dec aProcSystem.aBody0,b,x
        bne rlMapMagicFenrirDarken._9D49
        jsr rsCreateMapMagicProc

          .word <>procMapMagicFenrirWindow

        sta aProcSystem.aBody7,b,x
        jsr rsCreateMapMagicProc

          .word <>procMapMagicFenrirVortex

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC34

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FA08E

        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $68

        lda #<>rlMapMagicFenrirWaitImpact
        sta aProcSystem.aHeaderOnCycle,b,x
        rtl


      rlMapMagicFenrirWaitImpact ; 9F/9D87

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        lda $7ECC06
        beq _9DA2
        ldy aProcSystem.aBody7,b,x
        lda #$FFFC
        sta aProcSystem.aBody4,b,y
        lda #<>rlMapMagicFenrirDone
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #<>aProcMapMagicFenrirPaletteStepsCode
        sta aProcSystem.aHeaderCodeOffset,b,x

        _9DA2
        rtl


      rlMapMagicFenrirDone ; 9F/9DA3

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        rtl

        .databank 0

      aProcMapMagicFenrirCode ; 9F/9DA4

        ; Part of the Fenrir effect.
        PROC_HALT

      aProcMapMagicFenrirPaletteStepsCode ; 9F/9DA6

        ; Part of the Fenrir effect.
        PROC_YIELD 1
        PROC_CALL_ARGS rlMapMagicFenrirLoadPaletteStep, 1
        .byte $2A
        PROC_YIELD 1
        PROC_CALL_ARGS rlMapMagicFenrirLoadPaletteStep, 1
        .byte $1C
        PROC_YIELD 1
        PROC_CALL_ARGS rlMapMagicFenrirLoadPaletteStep, 1
        .byte $0E
        PROC_YIELD 1
        PROC_CALL_ARGS rlMapMagicFenrirLoadPaletteStep, 1
        .byte $00
        PROC_HALT

      rlMapMagicFenrirLoadPaletteStep ; 9F/9DCC

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        lda $0000,b,y
        and #$00FF
        asl a
        tax
        lda <>aMapMagicFenrirPaletteSteps,b,x
        sta $01D2,b
        lda <>(aMapMagicFenrirPaletteSteps+2),b,x
        sta $01D4,b
        lda <>(aMapMagicFenrirPaletteSteps+4),b,x
        sta $01D6,b
        lda <>(aMapMagicFenrirPaletteSteps+6),b,x
        sta $01D8,b
        lda <>(aMapMagicFenrirPaletteSteps+8),b,x
        sta $01DA,b
        lda <>(aMapMagicFenrirPaletteSteps+10),b,x
        sta $01DC,b
        lda <>(aMapMagicFenrirPaletteSteps+12),b,x
        sta $01DE,b
        lda <>(aMapMagicFenrirPaletteSteps+112),b,x
        sta $01F2,b
        lda <>(aMapMagicFenrirPaletteSteps+114),b,x
        sta $01F4,b
        lda <>(aMapMagicFenrirPaletteSteps+116),b,x
        sta $01F6,b
        lda <>(aMapMagicFenrirPaletteSteps+118),b,x

        _9E13
        sta $01F8,b
        lda <>(aMapMagicFenrirPaletteSteps+120),b,x
        sta $01FA,b
        lda <>(aMapMagicFenrirPaletteSteps+122),b,x
        sta $01FC,b
        lda <>(aMapMagicFenrirPaletteSteps+124),b,x
        sta $01FE,b
        rtl

        .databank 0

      aMapMagicFenrirPaletteSteps ; 9F/9E29

        ; Part of the Fenrir effect.
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0444, $0443, $0022, $0021, $0001, $0000, $0000
        .word $08A8, $0886, $0465, $0443, $0002, $0001, $0000
        .word $110D, $0CCA, $0888, $0465, $0004, $0001, $0000
        .word $1571, $110D, $0CCB, $0886, $0025, $0002, $0000
        .word $1DD6, $1551, $10EE, $08A8, $0027, $0002, $0000
        .word $223A, $1994, $1531, $0CCA, $0028, $0003, $0000
        .word $2A9F, $1DD8, $1974, $10EC, $004A, $0024, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $1020, $1020, $0C20, $0800, $0800, $0400, $0000
        .word $2060, $2040, $1840, $1420, $1000, $0C00, $0000
        .word $3480, $3080, $2860, $2020, $1C00, $1000, $0000
        .word $44C0, $40A0, $3480, $2840, $2420, $1800, $0000
        .word $58E0, $50E0, $44A0, $3440, $3020, $1C00, $0000
        .word $6920, $6100, $50C0, $4060, $3820, $2400, $0000
        .word $7D60, $7140, $60E0, $4C80, $4440, $2C00, $0000

      aMapMagicFenrirSpriteInfo ; 9F/9F09

        ; Part of the Fenrir effect.
        .word <>rlMapMagicFenrirSpriteInit, <>rlMapMagicFenrirSpriteWaitCast, <>aMapMagicFenrirSpriteScript

      rlMapMagicFenrirSpriteInit ; 9F/9F0F

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicCasterPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicCasterPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        lda #$0040
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $69

        rtl

        .databank 0

      rlMapMagicFenrirSpriteWaitCast ; 9F/9F38

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicFenrirSpriteNoOp
        lda #<>rlMapMagicFenrirSpriteFlyToTarget
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aXPosition,b,x
        sta wR0
        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aYPosition,b,x
        sta wR1
        jsl rlGetVectorLength
        lsr a
        lsr a
        bne _9F68
        lda #$0002

        _9F68
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda wR0
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda #$0400
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsMapMagicCalcSpriteVelocityFromAngle

        .databank 0

      rlMapMagicFenrirSpriteNoOp ; 9F/9F79

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        rtl

      rlMapMagicFenrirSpriteFlyToTarget ; 9F/9F7A

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        jsl rlMoveActiveSpriteByVelocity
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _9F92
        lda #<>rlMapMagicFenrirSpriteWaitImpact
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0010
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta aActiveSpriteSystem.aUnknown001320,b,x

        _9F92
        rtl

        .databank 0

        ; 9F/9F93
      rlMapMagicFenrirSpriteWaitImpact ; 9F/9F93

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _9FAB
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicFenrirSpriteSignalHit
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0008
        sta aActiveSpriteSystem.aUnknown0012C0,b,x

        _9FAB
        rtl

        .databank 0

        ; 9F/9FAC
      rlMapMagicFenrirSpriteSignalHit ; 9F/9FAC

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _9FC1
        lda #<>rlMapMagicFenrirSpriteWaitFade
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0010
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        sta $7ECC06

        _9FC1
        rtl

        .databank 0

        ; 9F/9FC2
      rlMapMagicFenrirSpriteWaitFade ; 9F/9FC2

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _9FCD
        lda #<>rlMapMagicFenrirSpriteFadeBack
        sta aActiveSpriteSystem.aOnCycle,b,x

        _9FCD
        rtl

        .databank 0

        ; 9F/9FCE
      rlMapMagicFenrirSpriteFadeBack ; 9F/9FCE

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        jsr rsFadeBackMapMagicColors
        bcc _9FDD
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta wMapMagicDone

        _9FDD
        rtl

        .databank 0

      aMapMagicFenrirSpriteScript ; 9F/9FDE

        ; Part of the Fenrir effect.
        ACTIVE_SPRITE_FRAME 4, aMapMagicFenrirFrame01
        ACTIVE_SPRITE_FRAME 4, aMapMagicFenrirFrame02
        ACTIVE_SPRITE_FRAME 4, aMapMagicFenrirFrame03
        ACTIVE_SPRITE_FRAME 4, aMapMagicFenrirFrame04
        ACTIVE_SPRITE_FRAME 4, aMapMagicFenrirFrame05

        _9FF2
        ACTIVE_SPRITE_FRAME 3, aMapMagicFenrirFrame06
        ACTIVE_SPRITE_FRAME 3, aMapMagicFenrirFrame07
        ACTIVE_SPRITE_FRAME 3, aMapMagicFenrirFrame08
        ACTIVE_SPRITE_FRAME 3, aMapMagicFenrirFrame09
        ACTIVE_SPRITE_CALL rlMapMagicFenrirWaitSpritePhase
        .word <>_9FF2

        _A007
        ACTIVE_SPRITE_FRAME 1, aMapMagicFenrirFrameEmpty
        ACTIVE_SPRITE_JUMP _A007

        ; 9F/A00E
      rlMapMagicFenrirWaitSpritePhase ; 9F/A00E

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        lda aActiveSpriteSystem.aUnknown001320,b,x
        bne _A018
        lda $0000,b,y
        tay
        rtl


        _A018
        inc y
        inc y
        rtl

        .databank 0

        ; 9F/A01B

      aMapMagicFenrirFrameEmpty ; 9F/A01B

        ; Part of the Fenrir effect.
        .word 0

      aMapMagicFenrirFrame01 ; 9F/A01D

        ; Part of the Fenrir effect.
        _Sprites := [[(  -4,   14), $00, SpriteSmall, $001, 3, 6, false, false]]
        _Sprites ..= [[(  20,  -11), $00, SpriteSmall, $001, 3, 6, false, false]]
        _Sprites ..= [[( -28,  -11), $00, SpriteSmall, $001, 3, 6, false, false]]

        .structSpriteArray aMapMagicFenrirFrame01._Sprites

      aMapMagicFenrirFrame02 ; 9F/A02E

        ; Part of the Fenrir effect.
        _Sprites := [[( -14,   11), $00, SpriteSmall, $002, 3, 6, false, false]]
        _Sprites ..= [[(  15,   -5), $00, SpriteSmall, $002, 3, 6, false, false]]
        _Sprites ..= [[( -25,  -16), $00, SpriteSmall, $002, 3, 6, false, false]]

        .structSpriteArray aMapMagicFenrirFrame02._Sprites

      aMapMagicFenrirFrame03 ; 9F/A03F

        ; Part of the Fenrir effect.
        _Sprites := [[(   9,    2), $00, SpriteSmall, $010, 3, 6, false, false]]
        _Sprites ..= [[( -19,    3), $00, SpriteSmall, $010, 3, 6, false, false]]
        _Sprites ..= [[(  -5,  -16), $00, SpriteSmall, $010, 3, 6, false, false]]

        .structSpriteArray aMapMagicFenrirFrame03._Sprites

      aMapMagicFenrirFrame04 ; 9F/A050

        ; Part of the Fenrir effect.
        _Sprites := [[(  -3,   10), $00, SpriteSmall, $012, 3, 6, false, false]]
        _Sprites ..= [[( -20,   -2), $00, SpriteSmall, $012, 3, 6, false, false]]
        _Sprites ..= [[(   3,  -13), $00, SpriteSmall, $012, 3, 6, false, false]]

        .structSpriteArray aMapMagicFenrirFrame04._Sprites

      aMapMagicFenrirFrame05 ; 9F/A061

        ; Part of the Fenrir effect.
        _Sprites := [[( -11,    6), $00, SpriteSmall, $010, 3, 6, false, true]]
        _Sprites ..= [[(   3,   -3), $00, SpriteSmall, $010, 3, 6, false, true]]
        _Sprites ..= [[( -14,   -9), $00, SpriteSmall, $010, 3, 6, false, true]]

        .structSpriteArray aMapMagicFenrirFrame05._Sprites

      aMapMagicFenrirFrame06 ; 9F/A072

        ; Part of the Fenrir effect.
        _Sprites := [[(  -8,  -10), $21, SpriteLarge, $006, 3, 6, false, true]]

        .structSpriteArray aMapMagicFenrirFrame06._Sprites

      aMapMagicFenrirFrame07 ; 9F/A079

        ; Part of the Fenrir effect.
        _Sprites := [[( -10,   -8), $21, SpriteLarge, $004, 3, 6, true, false]]

        .structSpriteArray aMapMagicFenrirFrame07._Sprites

      aMapMagicFenrirFrame08 ; 9F/A080

        ; Part of the Fenrir effect.
        _Sprites := [[(  -8,   -6), $21, SpriteLarge, $006, 3, 6, false, false]]

        .structSpriteArray aMapMagicFenrirFrame08._Sprites

      aMapMagicFenrirFrame09 ; 9F/A087

        ; Part of the Fenrir effect.
        _Sprites := [[(  -6,   -8), $21, SpriteLarge, $004, 3, 6, false, false]]

        .structSpriteArray aMapMagicFenrirFrame09._Sprites

      aUnknown9FA08E .dstruct structHDMAIndirectEntryInfo, rlMapMagicFenrirHDMAInit, rlHDMAMapMagicNoOp2, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/A08E

        ; Part of the Fenrir effect.
      rlMapMagicFenrirHDMAInit ; 9F/A09A

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F57FF
        sta $7F50D1
        lda $7F5800
        clc
        adc #$FFFF
        sta $7F50D3
        lda wMapMagicFlags
        and #$0400
        beq _A0BD
        lda #<>aUnknown9FDF65
        sta aHDMASystem.aOffset,b,x

        _A0BD
        lda #$0078
        sta $7F50D9
        lda #$0000
        sta $7F50DB
        lda wMapMagicTargetPixel
        and #$00FF
        sta $7F50DF
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc #$007C
        eor #$FFFF
        inc a
        sta wR0
        sta $7F50CD
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta $7F50E1
        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc #$0070
        eor #$FFFF
        inc a
        sta wR1
        sta $7F50CF
        lda #$7F54
        and #$01FF
        sta $2182,b
        lda #$546A
        sta $2181,b
        ldy #$00E0
        sep #$20

        _A11F
        lda wR0
        sta $2180,b
        lda wR0+1
        sta $2180,b
        lda wR1
        sta $2180,b
        lda wR1+1
        sta $2180,b
        dec y
        bne _A11F
        rep #$20
        rtl

        .databank 0

      procMapMagicFenrirVortex ; 9F/A139

        ; Part of the Fenrir effect.
        .structProcInfo "ON", rlMapMagicFenrirVortexInit, rlMapMagicFenrirVortexCycle, aProcMapMagicHaltCode

      rlMapMagicFenrirVortexInit ; 9F/A141

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        lda #$0000
        sta aProcSystem.aBody0,b,x
        lda #$0200
        sta aProcSystem.aBody1,b,x
        lda #$2000
        sta aProcSystem.aBody2,b,x
        lda #$4000
        sta aProcSystem.aBody3,b,x
        rtl


      rlMapMagicFenrirVortexCycle ; 9F/A15A

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.

        jsl rlMapMagicFenrirVortexStepDMA
        lda $7F50CD
        and #$01FF
        sta wR4
        lda $7F50CF
        and #$01FF
        sta wR5
        lda #$7F54
        and #$01FF
        sta $2182,b
        lda #$546A
        sta $2181,b
        lda aProcSystem.aBody1,b,x
        clc
        adc #$0008
        sta aProcSystem.aBody1,b,x
        lda $1018,b,x
        and #$00FF
        sta wR2
        lda $0FD8,b,x
        and #$00FF
        sta wR0
        lda $1038,b,x
        and #$00FF
        sta wR3
        phx
        ldy #$00E0

        _A1A5
        lda wR3
        jsl rlMultiplyByNegSinMode7
        clc
        adc wR4
        sep #$20
        sta $2180,b
        stz $2180,b
        lda wR5
        sta $2180,b
        stz $2180,b
        lda wR0
        clc
        adc wR2
        sta wR0
        rep #$21
        txa
        adc #$0002
        tax
        dec y
        bne _A1A5
        plx
        bra _A1EE

        .byte $DA, $A0, $E0, $00, $E2, $20, $A5, $08, $8D, $80, $21, $9C, $80, $21, $A5, $0A
        .byte $8D, $80, $21, $9C, $80, $21, $88, $D0, $ED, $C2, $20, $FA


        _A1EE
        lda aProcSystem.aBody0,b,x
        clc
        adc aProcSystem.aBody1,b,x
        sta aProcSystem.aBody0,b,x
        lda aProcSystem.aBody3,b,x
        sec
        sbc #$0100
        bcs _A21D
        phx
        lda #(`aMapMagicFenrirSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicFenrirSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        plx
        lda #<>rlMapMagicFenrirVortexStepDMA
        sta aProcSystem.aHeaderOnCycle,b,x
        stz aProcSystem.aBody4,b,x
        lda #$0000

        _A21D
        sta aProcSystem.aBody3,b,x
        rtl


      rlMapMagicFenrirVortexStepDMA ; 9F/A221

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Fenrir effect.
        lda aProcSystem.aBody4,b,x
        and #$0003
        bne _A23B
        lda aProcSystem.aBody4,b,x
        and #$000C
        phx
        lsr a
        tax
        lda <>aMapMagicFenrirVortexDMAList,b,x
        tax
        jsl rlQueueMapMagicDMAList
        plx

        _A23B
        inc aProcSystem.aBody4,b,x
        rtl

        .databank 0

      aMapMagicFenrirVortexDMAList ; 9F/A23F

        ; Part of the Fenrir effect.
        .byte $47, $A2, $61, $A2, $7B, $A2, $95, $A2, $81, $AF, $A2, $9F, $04, $00, $EC, $5C
        .byte $81, $AF, $A2, $9F, $04, $00, $4F, $5D, $81, $AF, $A2, $9F, $04, $00, $F2, $5C
        .byte $FF, $FF, $81, $B3, $A2, $9F, $04, $00, $EC, $5C, $81, $B3, $A2, $9F, $04, $00
        .byte $4F, $5D, $81, $B3, $A2, $9F, $04, $00, $F2, $5C, $FF, $FF, $81, $B7, $A2, $9F
        .byte $04, $00, $EC, $5C, $81, $B7, $A2, $9F, $04, $00, $4F, $5D, $81, $B7, $A2, $9F
        .byte $04, $00, $F2, $5C, $FF, $FF, $81, $BB, $A2, $9F, $04, $00, $EC, $5C, $81, $BB
        .byte $A2, $9F, $04, $00, $4F, $5D, $81, $BB, $A2, $9F, $04, $00, $F2, $5C, $FF, $FF
        .byte $83, $3F, $93, $3F, $84, $3F, $94, $3F, $85, $3F, $95, $3F, $86, $3F, $96, $3F

      rlStartMapMagicBolganone ; 9F/A2BF

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aMapMagicBolganoneSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicBolganoneSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        jsr rsCreateMapMagicProc

          .word <>procMapMagicBolganone

        rtl

        .databank 0

      procMapMagicBolganone ; 9F/A2D3

        ; Part of the Bolganone effect.
        .structProcInfo "ON", rlMapMagicBolganoneInit, rlMapMagicBolganoneTintRed, aProcMapMagicHaltCode

      rlMapMagicBolganoneInit ; 9F/A2DB

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Bolganone effect.

        jsr rsSetMapMagicLayerBlending
        lda #$0020
        sta aProcSystem.aBody0,b,x
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        jsr rsSaveMapMagicColors
        jsl rlMapMagicBolganoneStepPaletteAnim
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C
        rtl


      rlMapMagicBolganoneTintRed ; 9F/A305

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Bolganone effect.
        jsr rsTintMapMagicColorsRed
        bcc _A310
        lda #<>rlMapMagicBolganoneWaitSpawn
        sta aProcSystem.aHeaderOnCycle,b,x

        _A310
        rtl


      rlMapMagicBolganoneWaitSpawn ; 9F/A311

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Bolganone effect.

        lda $7ECC06
        cmp #$0001
        bne rlMapMagicBolganoneTintRed._A310
        jsr rsCreateMapMagicProc

          .word <>procMapMagicBolganoneWindow

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBF1

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC77

        lda #<>rlMapMagicBolganoneShakeWait1
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$001E
        sta aProcSystem.aBody0,b,x
        rtl


      rlMapMagicBolganoneShakeWait1 ; 9F/A345

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Bolganone effect.

        jsr rsShakeMapMagicBackground
        jsl rlMapMagicBolganoneStepPaletteAnim
        dec aProcSystem.aBody0,b,x
        bne _A35D
        lda #$0010
        sta aProcSystem.aBody0,b,x
        lda #<>rlMapMagicBolganoneShakeWait2
        sta aProcSystem.aHeaderOnCycle,b,x

        _A35D
        rtl


      rlMapMagicBolganoneShakeWait2 ; 9F/A35E

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Bolganone effect.

        jsr rsShakeMapMagicBackground
        jsl rlMapMagicBolganoneStepPaletteAnim
        dec aProcSystem.aBody0,b,x
        bne _A377
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicBolganoneShakeLoop
        sta aProcSystem.aHeaderOnCycle,b,x

        _A377
        rtl


      rlMapMagicBolganoneShakeLoop ; 9F/A378

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Bolganone effect.

        jsr rsShakeMapMagicBackground
        jsl rlMapMagicBolganoneStepPaletteAnim
        rtl


      rlMapMagicBolganoneStepPaletteAnim ; 9F/A380

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Bolganone effect.
        lda aProcSystem.aBody2,b,x
        beq _A38A
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _A38A
        lda #$0003
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc a
        sta aProcSystem.aBody3,b,x
        dec a
        asl a
        asl a
        asl a
        asl a
        tax
        lda <>aMapMagicBolganonePaletteAnim,b,x
        cmp #$FFFF
        beq _A3CF
        sta $01D2,b
        lda <>(aMapMagicBolganonePaletteAnim+2),b,x
        sta $01D4,b
        lda <>(aMapMagicBolganonePaletteAnim+4),b,x
        sta $01D6,b
        lda <>(aMapMagicBolganonePaletteAnim+6),b,x
        sta $01D8,b
        lda <>(aMapMagicBolganonePaletteAnim+8),b,x
        sta $01DA,b
        lda <>(aMapMagicBolganonePaletteAnim+10),b,x
        sta $01DC,b
        lda <>(aMapMagicBolganonePaletteAnim+12),b,x
        sta $01DE,b
        plx
        rtl


        _A3CF
        plx
        stz aProcSystem.aHeaderTypeOffset,b,x
        lda #$0001
        sta $7ECC08
        rtl

        .databank 0

      aMapMagicBolganonePaletteAnim ; 9F/A3DB

        ; Part of the Bolganone effect.
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0005, $000A, $000E, $0012, $0015, $A4FB
        .word $0006, $000A, $000E, $0012, $0015, $0019, $001C, $A4FB
        .word $000C, $0010, $0017, $015D, $021F, $02BF, $02FF, $A4FB
        .word $0000, $0000, $0006, $000A, $000E, $0012, $0015, $A4FB
        .word $0000, $0000, $0005, $000A, $000E, $0012, $0015, $A4FB
        .word $0000, $0000, $0000, $0000, $0005, $000A, $000E, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $A4FB
        .word $FFFF

      aMapMagicBolganoneSpriteInfo ; 9F/A4FD

        ; Part of the Bolganone effect.
        .word <>rlMapMagicBolganoneSpriteInit, <>rlMapMagicBolganoneSpriteWaitEnd, <>aMapMagicBolganoneSpriteScript

      rlMapMagicBolganoneSpriteInit ; 9F/A503

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Bolganone effect.

        ; WARNING: a branch or jump leads into the middle of an instruction at $9FA536
        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $53

        lda wMapMagicTargetPixel+1
        clc
        adc #$0002
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        rtl


      rlMapMagicBolganoneSpriteWaitEnd ; 9F/A527

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Bolganone effect.
        lda $7ECC06
        cmp #$0002
        beq _A531
        rtl


        _A531
        lda #<>rlMapMagicBolganoneSpriteFadeBack
        sta aActiveSpriteSystem.aOnCycle,b,x

      rlMapMagicBolganoneSpriteFadeBack ; 9F/A537

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Bolganone effect.

        jsr rsFadeBackMapMagicColors
        bcc _A546
        lda #$0001
        sta wMapMagicDone
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _A546
        rtl

        .databank 0

      aMapMagicBolganoneFrameEmpty ; 9F/A547

        ; Part of the Bolganone effect.
        .word 0

      aMapMagicBolganoneFrame01 ; 9F/A549

        ; Part of the Bolganone effect.
        _Sprites := [[(  -4,    0), $00, SpriteSmall, $010, 2, 6, false, false]]

        .structSpriteArray aMapMagicBolganoneFrame01._Sprites

      aMapMagicBolganoneFrame02 ; 9F/A550

        ; Part of the Bolganone effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $001, 2, 6, false, false]]

        .structSpriteArray aMapMagicBolganoneFrame02._Sprites

      aMapMagicBolganoneFrame03 ; 9F/A557

        ; Part of the Bolganone effect.
        _Sprites := [[(   0,   -7), $21, SpriteLarge, $003, 2, 6, true, false]]
        _Sprites ..= [[( -16,   -7), $21, SpriteLarge, $003, 2, 6, false, false]]

        .structSpriteArray aMapMagicBolganoneFrame03._Sprites

      aMapMagicBolganoneSpriteScript ; 9F/A563

        ; Part of the Bolganone effect.
        ACTIVE_SPRITE_FRAME 8, aMapMagicBolganoneFrame01
        ACTIVE_SPRITE_FRAME 8, aMapMagicBolganoneFrame02
        ACTIVE_SPRITE_FRAME 2, aMapMagicBolganoneFrame03
        ACTIVE_SPRITE_CALL rlMapMagicBolganoneSignalStart

        _A572
        ACTIVE_SPRITE_FRAME 1, aMapMagicBolganoneFrame03
        ACTIVE_SPRITE_CALL rlMapMagicBolganoneWaitSpritePhase
        .word <>_A572
        ACTIVE_SPRITE_FRAME 8, aMapMagicBolganoneFrame02
        ACTIVE_SPRITE_FRAME 8, aMapMagicBolganoneFrame01
        ACTIVE_SPRITE_CALL rlMapMagicBolganoneSignalEnd

        _A586
        ACTIVE_SPRITE_FRAME 1, aMapMagicBolganoneFrameEmpty
        ACTIVE_SPRITE_JUMP _A586

        ; 9F/A58D
      rlMapMagicBolganoneWaitSpritePhase ; 9F/A58D

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Bolganone effect.

        lda $7ECC08
        beq _A596
        inc y
        inc y
        rtl


        _A596
        lda $0000,b,y
        tay
        rtl

        .databank 0

        ; 9F/A59B
      rlMapMagicBolganoneSignalStart ; 9F/A59B

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Bolganone effect.

        lda #$0001
        sta $7ECC06
        rtl

        .databank 0

        ; 9F/A5A3
      rlMapMagicBolganoneSignalEnd ; 9F/A5A3

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Bolganone effect.

        lda #$0002
        sta $7ECC06
        rtl

        .databank 0

        ; 9F/A5AB

      rlStartMapMagicHel ; 9F/A5AB

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicHel

        rtl

        .databank 0

      procMapMagicHel ; 9F/A5B1

        ; Part of the Hel effect.
        .structProcInfo "ON", rlMapMagicHelInit, rlMapMagicHelDarkenAndSpawn, aProcMapMagicHaltCode

      rlMapMagicHelInit ; 9F/A5B9

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Hel effect.

        jsr rsSetMapMagicLayerBlending
        jsr rsSaveMapMagicColors
        rtl


      rlMapMagicHelDarkenAndSpawn ; 9F/A5C0

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Hel effect.
        jsr rsDarkenMapMagicColors
        bcc _A602
        lda #<>rlMapMagicHelWaitCast
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        jsr rsCreateMapMagicProc

          .word <>procMapMagicBlizzardHelWindow

        sta aProcSystem.aBody7,b,x
        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC34

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FE378

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FE2D9

        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $58


        _A602
        rtl


      rlMapMagicHelWaitCast ; 9F/A603

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Hel effect.

        dec aProcSystem.aBody0,b,x
        bne _A614
        lda #<>rlMapMagicHelWaitStrike
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x

        _A614
        rtl


      rlMapMagicHelWaitStrike ; 9F/A615

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Hel effect.

        dec aProcSystem.aBody0,b,x
        bne rlMapMagicHelReverseFade._A64C
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicHelReverseFade
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$000E
        sta aProcSystem.aBody0,b,x
        rtl


      rlMapMagicHelReverseFade ; 9F/A62E

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Hel effect.

        dec aProcSystem.aBody0,b,x
        bne _A64C
        lda #<>rlMapMagicHelWaitFade
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0016
        sta aProcSystem.aBody0,b,x
        ldy aProcSystem.aBody7,b,x
        lda aProcSystem.aBody4,b,y
        eor #$FFFF
        inc a
        sta aProcSystem.aBody4,b,y

        _A64C
        rtl


      rlMapMagicHelWaitFade ; 9F/A64D

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Hel effect.

        dec aProcSystem.aBody0,b,x
        bne _A658
        lda #<>rlMapMagicHelFadeBack
        sta aProcSystem.aHeaderOnCycle,b,x

        _A658
        rtl


      rlMapMagicHelFadeBack ; 9F/A659

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Hel effect.

        jsr rsFadeBackMapMagicColors
        bcc rlMapMagicHelDone
        lda #<>rlMapMagicHelDone
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta wMapMagicDone

      rlMapMagicHelDone ; 9F/A66B

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Hel effect.

        rtl

        .databank 0

      rlStartMapMagicThunder ; 9F/A66C

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicThunder

        rtl

        .databank 0

      rlStartMapMagicElthunder ; 9F/A672

        .al
        .xl
        .autsiz
        .databank ?

        ; Also Bolting.

        jsr rsCreateMapMagicProc

          .word <>procMapMagicElthunder

        rtl

        .databank 0

      procMapMagicThunder ; 9F/A678

        ; Part of the Thunder effect.
        .structProcInfo "ON", rlMapMagicThunderInit, rlMapMagicThunderDarkenAndSpawn, aProcMapMagicHaltCode
        .word <>aMapMagicThunderSpriteInfo

      procMapMagicElthunder ; 9F/A682

        ; Part of the Elthunder effect.
        .structProcInfo "ON", rlMapMagicThunderInit, rlMapMagicThunderDarkenAndSpawn, aProcMapMagicHaltCode
        .word <>aMapMagicElthunderSpriteInfo

      rlMapMagicThunderInit ; 9F/A68C

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elthunder and Thunder effects.

        jsr rsSetMapMagicLayerBlending
        jsr rsSaveMapMagicColors
        rtl


      rlMapMagicThunderDarkenAndSpawn ; 9F/A693

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elthunder and Thunder effects.
        jsr rsDarkenMapMagicColors
        bcc rlMapMagicThunderProcDone
        lda $0EF6,b,x
        sta lR44+1
        ldy aProcSystem.aHeaderTypeOffset,b,x
        lda $0008,b,y
        sta lR44
        lda #<>rlMapMagicThunderProcDone
        sta aProcSystem.aHeaderOnCycle,b,x
        phx
        phy
        lda wMapMagicCasterPixel+1
        sec
        sbc #$0008
        and #$00FF
        tay
        lda wMapMagicCasterPixel
        and #$00FF
        tax
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply
        plx
        stz aProcSystem.aHeaderTypeOffset,b,x

      rlMapMagicThunderProcDone ; 9F/A6CA

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elthunder and Thunder effects.

        rtl

        .databank 0

      aMapMagicThunderSpriteInfo ; 9F/A6CB
        .word <>rlMapMagicThunderSpriteInit, <>rlMapMagicThunderFallToTarget, <>aMapMagicThunderSpriteScript

      aMapMagicElthunderSpriteInfo ; 9F/A6D1
        .word <>rlMapMagicElthunderSpriteInit, <>rlMapMagicElthunderCasterBoltCycle, <>aMapMagicElthunderSpriteScript

      aMapMagicElthunderCasterBoltSpriteInfo ; 9F/A6D7
        .word <>rlMapMagicThunderBoltInit, <>rlMapMagicElthunderCasterBoltCycle, <>aMapMagicElthunderCasterBoltSpriteScript

      aMapMagicElthunderMidBoltSpriteInfo ; 9F/A6DD
        .word <>rlMapMagicThunderBoltInit, <>rlMapMagicElthunderMidBoltCycle, <>aMapMagicElthunderCasterBoltSpriteScript

      aMapMagicElthunderLowBoltSpriteInfo ; 9F/A6E3
        .word <>rlMapMagicThunderBoltInit, <>rlMapMagicElthunderLowBoltCycle, <>aMapMagicElthunderLowBoltSpriteScript

      aMapMagicElthunderTargetSpriteInfo ; 9F/A6E9
        .word <>rlMapMagicElthunderTargetInit, <>rlMapMagicThunderWaitPaletteAnim, <>aMapMagicElthunderTargetSpriteScript


      rlMapMagicElthunderSpriteInit ; 9F/A6EF

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Elthunder effect.

        lda wMapMagicCasterPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $56

        bra rlMapMagicThunderSpriteInit._A70D

        .databank 0

        ; 9F/A6FF
      rlMapMagicThunderSpriteInit ; 9F/A6FF

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thunder effect.

        lda wMapMagicCasterPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $54

        _A70D
        lda wMapMagicCasterPixel+1
        and #$00FF
        sec
        sbc #$0010
        sta aActiveSpriteSystem.aYPosition,b,x

        .databank 0

        ; 9F/A71B
      rlMapMagicThunderBoltInit ; 9F/A71B

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda #$0004
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

        ; 9F/A729
      rlMapMagicElthunderTargetInit ; 9F/A729

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        stz aActiveSpriteSystem.aUnknown001320,b,x
        stz aActiveSpriteSystem.aUnknown001340,b,x
        rtl

        .databank 0

        ; 9F/A74B
      rlMapMagicThunderWaitPaletteAnim ; 9F/A74B

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlMapMagicThunderStepPaletteAnim
        bcc rlMapMagicThunderFadeBack._A779
        lda #$000C
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlMapMagicThunderWaitFade
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

        ; 9F/A75E
      rlMapMagicThunderWaitFade ; 9F/A75E

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicThunderFadeBack._A779
        lda #<>rlMapMagicThunderFadeBack
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

        ; 9F/A76A
      rlMapMagicThunderFadeBack ; 9F/A76A

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsFadeBackMapMagicColors
        bcc _A779
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta wMapMagicDone

        _A779
        rtl

        .databank 0

        ; 9F/A77A
      rlMapMagicElthunderCasterBoltCycle ; 9F/A77A

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Elthunder effect.

        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq rlMapMagicElthunderCasterBoltEnd._A79A
        stz aActiveSpriteSystem.aUnknown001320,b,x
        jsr rsMapMagicElthunderSpawnNextBolt
        lda #<>rlMapMagicElthunderCasterBoltEnd
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0040
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

        ; 9F/A792
      rlMapMagicElthunderCasterBoltEnd ; 9F/A792

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Elthunder effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _A79A
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _A79A
        rtl

        .databank 0

        ; 9F/A79B
      rlMapMagicElthunderMidBoltCycle ; 9F/A79B

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq rlMapMagicElthunderMidBoltEnd._A7BB
        stz aActiveSpriteSystem.aUnknown001320,b,x
        lda #<>rlMapMagicElthunderMidBoltEnd
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0040
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

        ; 9F/A7B0
      rlMapMagicElthunderMidBoltEnd ; 9F/A7B0

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _A7BB
        jsr rsMapMagicElthunderSpawnImpact1
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _A7BB
        rtl

        .databank 0

        ; 9F/A7BC
      rlMapMagicElthunderLowBoltCycle ; 9F/A7BC

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq rlMapMagicElthunderLowBoltEnd._A7F5
        stz aActiveSpriteSystem.aUnknown001320,b,x
        jsr rsMapMagicElthunderSpawnImpact2
        lda #<>rlMapMagicElthunderLowBoltSignal
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$003C
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

        ; 9F/A7D4
      rlMapMagicElthunderLowBoltSignal ; 9F/A7D4

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _A7EC
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicElthunderLowBoltEnd
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0004
        sta aActiveSpriteSystem.aUnknown0012C0,b,x

        _A7EC
        rtl

        .databank 0

        ; 9F/A7ED
      rlMapMagicElthunderLowBoltEnd ; 9F/A7ED

        .al
        .xl
        .autsiz
        .databank ?

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _A7F5
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _A7F5
        rtl

        .databank 0

        ; 9F/A7F6
      rsMapMagicElthunderSpawnNextBolt ; 9F/A7F6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda aActiveSpriteSystem.aYPosition,b,x
        sec
        sbc #$0030
        bpl _A809
        clc
        adc #$0018
        bpl _A826
        bra _A826


        _A809
        clc
        adc #$0018
        tay
        lda aActiveSpriteSystem.aXPosition,b,x
        and #$00FF
        tax
        lda #(`aMapMagicElthunderCasterBoltSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicElthunderCasterBoltSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply
        plx
        rts


        _A826
        clc
        adc #$0018
        tay
        lda aActiveSpriteSystem.aXPosition,b,x
        and #$00FF
        tax
        lda #(`aMapMagicElthunderMidBoltSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicElthunderMidBoltSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply
        plx
        rts

        .databank 0

        ; 9F/A843
      rsMapMagicElthunderSpawnImpact1 ; 9F/A843

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda wMapMagicTargetPixel+1
        and #$0008
        sec
        sbc #$0020
        tay
        lda wMapMagicTargetPixel
        and #$00FF
        tax
        lda #(`aMapMagicElthunderLowBoltSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicElthunderLowBoltSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply
        plx
        clc
        rts

        .databank 0

        ; 9F/A86B
      rsMapMagicElthunderSpawnImpact2 ; 9F/A86B

        .al
        .xl
        .autsiz
        .databank ?

        phx
        phy
        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc #$0018
        sta wR0
        lda aActiveSpriteSystem.aYPosition,b,x
        clc
        adc #$0018
        cmp wR0
        bpl _A8A0
        tay
        lda wMapMagicTargetPixel
        and #$00FF
        tax
        lda #(`aMapMagicElthunderLowBoltSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicElthunderLowBoltSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply
        plx
        clc
        rts


        _A8A0
        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $57

        jsr rlMapMagicThunderSpawnEffects
        lda #(`aMapMagicElthunderTargetSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicElthunderTargetSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply
        plx
        sec
        rts

        .databank 0

      aMapMagicElthunderSpriteScript ; 9F/A8BC

        ; Part of the Elthunder effect.
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame01
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame02
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame03

        ; 9F/A8C8
      aMapMagicElthunderCasterBoltSpriteScript ; 9F/A8C8

        ACTIVE_SPRITE_CALL rlMapMagicElthunderSetSpriteReady

        _A8CB
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame04
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame05
        ACTIVE_SPRITE_JUMP _A8CB

        ; 9F/A8D6
      aMapMagicElthunderLowBoltSpriteScript ; 9F/A8D6

        ACTIVE_SPRITE_CALL rlMapMagicElthunderSetSpriteReady

        _A8D9
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame07
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame08
        ACTIVE_SPRITE_JUMP _A8D9

        ; 9F/A8E4
      rlMapMagicElthunderSetSpriteReady ; 9F/A8E4

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta aActiveSpriteSystem.aUnknown001320,b,x
        rtl

        .databank 0

        ; 9F/A8EB
      rlMapMagicThunderFallToTarget ; 9F/A8EB

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thunder effect.

        lda aActiveSpriteSystem.aYPosition,b,x
        cmp #$000A
        bpl rlMapMagicThunderSpriteDummy
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicTargetPixel+1
        and #$001F
        sec
        sbc #$0020
        sta aActiveSpriteSystem.aYPosition,b,x
        lda #<>rlMapMagicThunderSpriteDummy
        sta aActiveSpriteSystem.aOnCycle,b,x

        .databank 0

        ; 9F/A917
      rlMapMagicThunderSpriteDummy ; 9F/A917

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thunder effect.

        rtl

        .databank 0

        ; 9F/A918
      rlMapMagicThunderImpactInit ; 9F/A918

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thunder effect.

        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $55

        lda #$0020
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$0002
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        stz aActiveSpriteSystem.aUnknown001320,b,x
        stz aActiveSpriteSystem.aUnknown001340,b,x
        lda #<>rlMapMagicThunderImpactWaitStrike
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

        ; 9F/A938
      rlMapMagicThunderImpactWaitStrike ; 9F/A938

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thunder effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicThunderImpactWaitAnim
        lda #<>rlMapMagicThunderImpactWaitAnim
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal

        .databank 0

        ; 9F/A94A
      rlMapMagicThunderImpactWaitAnim ; 9F/A94A

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thunder effect.

        jsl rlMapMagicThunderStepPaletteAnim
        bcc rlMapMagicThunderImpactFadeBack._A966
        lda #<>rlMapMagicThunderImpactFadeBack
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

        ; 9F/A957
      rlMapMagicThunderImpactFadeBack ; 9F/A957

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thunder effect.

        jsr rsFadeBackMapMagicColors
        bcc _A966
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta wMapMagicDone

        _A966
        rtl

        .databank 0

        ; 9F/A967
      aMapMagicElthunderTargetSpriteScript ; 9F/A967

        ACTIVE_SPRITE_FRAME 64, aMapMagicThunderFrame09

        _A96B
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrameEmpty
        ACTIVE_SPRITE_JUMP _A96B

        ; 9F/A972
      aMapMagicThunderSpriteScript ; 9F/A972

        ; Part of the Thunder effect.
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame01
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame02
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame03

        _A97E
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame04
        ACTIVE_SPRITE_MOVE 0, -10
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame05
        ACTIVE_SPRITE_MOVE 0, -10
        ACTIVE_SPRITE_CALL rlMapMagicThunderWaitPhase1
        .word <>_A97E
        ACTIVE_SPRITE_CALL rlMapMagicThunderClearPhase
        ACTIVE_SPRITE_FRAME 29, aMapMagicThunderFrameEmpty

        _A998
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame06
        ACTIVE_SPRITE_CALL rlMapMagicThunderBoltDescend
        .word <>aMapMagicThunderSpriteScript2
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame07
        ACTIVE_SPRITE_CALL rlMapMagicThunderBoltDescend
        .word <>aMapMagicThunderSpriteScript2
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrame08
        ACTIVE_SPRITE_CALL rlMapMagicThunderBoltDescend
        .word <>aMapMagicThunderSpriteScript2
        ACTIVE_SPRITE_JUMP _A998

        ; 9F/A9B6
      aMapMagicThunderSpriteScript2 ; 9F/A9B6

        ; Part of the Thunder effect.
        ACTIVE_SPRITE_FRAME 4, aMapMagicThunderFrame09

        _A9BA
        ACTIVE_SPRITE_FRAME 1, aMapMagicThunderFrameEmpty
        ACTIVE_SPRITE_JUMP _A9BA

        ; 9F/A9C1
      rlMapMagicThunderBoltDescend ; 9F/A9C1

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thunder effect.

        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc #$0018
        sta wR0
        lda #$0010
        clc
        adc aActiveSpriteSystem.aYPosition,b,x
        sta aActiveSpriteSystem.aYPosition,b,x
        cmp wR0
        bmi _A9F4
        jsr rlMapMagicThunderSpawnEffects
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        lda #<>rlMapMagicThunderImpactInit
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda $0000,b,y
        tay
        rtl


        _A9F4
        inc y
        inc y
        rtl

        .databank 0

        ; 9F/A9F7
      rlMapMagicThunderWaitPhase1 ; 9F/A9F7

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thunder effect.

        lda aActiveSpriteSystem.aUnknown0013A0,b,x
        cmp #$0001
        bne rlMapMagicThunderWaitPhase2._AA0D
        inc y
        inc y
        rtl

        .databank 0

        ; 9F/AA02
      rlMapMagicThunderWaitPhase2 ; 9F/AA02

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown0013A0,b,x
        cmp #$0002
        bne _AA0D
        inc y
        inc y
        rtl


        _AA0D
        lda $0000,b,y
        tay
        rtl

        .databank 0

        ; 9F/AA12
      rlMapMagicThunderClearPhase ; 9F/AA12

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thunder effect.

        stz aActiveSpriteSystem.aUnknown0013A0,b,x
        rtl

        .databank 0

        ; 9F/AA16
      rlMapMagicThunderSpawnEffects ; 9F/AA16

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thunder effect.

        phy
        jsr rsCreateMapMagicProc

          .word <>procMapMagicThunderWindow

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBF1

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC77

        ply
        rts

        .databank 0

        ; 9F/AA37

      aMapMagicThunderFrameEmpty ; 9F/AA37

        ; Part of the Thunder effect.
        .word 0

      aMapMagicThunderFrame01 ; 9F/AA39

        ; Shared by the Elthunder and Thunder effects.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aMapMagicThunderFrame01._Sprites

      aMapMagicThunderFrame02 ; 9F/AA40

        ; Shared by the Elthunder and Thunder effects.
        _Sprites := [[(  -8,  -24), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aMapMagicThunderFrame02._Sprites

      aMapMagicThunderFrame03 ; 9F/AA4C

        ; Shared by the Elthunder and Thunder effects.
        _Sprites := [[(  -8,  -40), $21, SpriteLarge, $002, 2, 6, false, false]]
        _Sprites ..= [[(  -8,  -24), $21, SpriteLarge, $004, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $006, 2, 6, false, false]]

        .structSpriteArray aMapMagicThunderFrame03._Sprites

      aMapMagicThunderFrame04 ; 9F/AA5D

        ; Part of the Thunder effect.
        _Sprites := [[(  -8,  -40), $21, SpriteLarge, $000, 2, 6, true, false]]
        _Sprites ..= [[(  -8,  -24), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aMapMagicThunderFrame04._Sprites

      aMapMagicThunderFrame05 ; 9F/AA6E

        ; Part of the Thunder effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]
        _Sprites ..= [[(  -8,  -24), $21, SpriteLarge, $002, 2, 6, false, false]]
        _Sprites ..= [[(  -8,  -40), $21, SpriteLarge, $006, 2, 6, true, false]]

        .structSpriteArray aMapMagicThunderFrame05._Sprites

      aMapMagicThunderFrameUnused1 ; 9F/AA7F

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, true]]

        .structSpriteArray aMapMagicThunderFrameUnused1._Sprites

      aMapMagicThunderFrameUnused2 ; 9F/AA86

        _Sprites := [[(  -8,    8), $21, SpriteLarge, $000, 2, 6, false, true]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $006, 2, 6, true, false]]

        .structSpriteArray aMapMagicThunderFrameUnused2._Sprites

      aMapMagicThunderFrame06 ; 9F/AA92

        ; Part of the Thunder effect.
        _Sprites := [[(  -8,   24), $21, SpriteLarge, $004, 2, 6, false, true]]
        _Sprites ..= [[(  -8,    8), $21, SpriteLarge, $002, 2, 6, false, true]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aMapMagicThunderFrame06._Sprites

      aMapMagicThunderFrame07 ; 9F/AAA3

        ; Part of the Thunder effect.
        _Sprites := [[(  -8,   24), $21, SpriteLarge, $006, 2, 6, false, true]]
        _Sprites ..= [[(  -8,    8), $21, SpriteLarge, $002, 2, 6, true, true]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, true]]

        .structSpriteArray aMapMagicThunderFrame07._Sprites

      aMapMagicThunderFrame08 ; 9F/AAB4

        ; Part of the Thunder effect.
        _Sprites := [[(  -8,   24), $21, SpriteLarge, $002, 2, 6, false, true]]
        _Sprites ..= [[(  -8,    8), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, true]]

        .structSpriteArray aMapMagicThunderFrame08._Sprites

      aMapMagicThunderFrame09 ; 9F/AAC5

        ; Part of the Thunder effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aMapMagicThunderFrame09._Sprites

      rlMapMagicThunderStepPaletteAnim ; 9F/AACC

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thunder effect.

        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq _AAD7
        dec a
        sta aActiveSpriteSystem.aUnknown001320,b,x

        _AAD5
        clc
        rtl


        _AAD7
        txy
        phx
        lda aActiveSpriteSystem.aUnknown001340,b,x
        inc a
        sta aActiveSpriteSystem.aUnknown001340,b,x
        dec a
        asl a
        asl a
        asl a
        asl a
        tax
        lda <>aMapMagicThunderPaletteAnim,b,x
        cmp #$FFFF
        beq _AB26
        sta aActiveSpriteSystem.aUnknown001320,b,y
        inc x
        inc x
        lda <>aMapMagicThunderPaletteAnim,b,x
        sta $01D2,b
        lda <>(aMapMagicThunderPaletteAnim+2),b,x
        sta $01D4,b
        lda <>(aMapMagicThunderPaletteAnim+4),b,x
        sta $01D6,b
        lda <>(aMapMagicThunderPaletteAnim+6),b,x
        sta $01D8,b
        lda <>(aMapMagicThunderPaletteAnim+8),b,x
        sta $01DA,b
        lda <>(aMapMagicThunderPaletteAnim+10),b,x
        sta $01DC,b
        lda <>(aMapMagicThunderPaletteAnim+12),b,x
        sta $01DE,b
        lda <>(aMapMagicThunderPaletteAnim+14),b,x
        sta aBGPaletteBuffer.aPalette7,b
        plx
        clc
        rtl


        _AB26
        plx
        sec
        rtl

        .databank 0

      aMapMagicThunderPaletteAnim ; 9F/AB29

        ; Part of the Thunder effect.
        .word $0002, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0002, $0000, $0000, $0000, $0000, $0000, $0000, $0400
        .word $0002, $0000, $0000, $0000, $0000, $0000, $0000, $0820
        .word $0002, $0000, $0000, $0000, $0000, $0000, $0000, $1060
        .word $0002, $0000, $0000, $0000, $0000, $0000, $18A0, $20C0
        .word $0002, $0000, $0000, $0000, $18A0, $20C0, $2D20, $3540
        .word $0003, $0000, $18A0, $20C0, $2D20, $3540, $3D80, $49A0
        .word $0002, $0000, $0000, $0000, $18A0, $20C0, $2D20, $3540
        .word $0002, $1800, $20C0, $2D20, $3540, $49A0, $5E20, $6E80
        .word $0002, $0000, $0000, $0000, $18A0, $20C0, $2D20, $3540
        .word $0003, $1800, $20C0, $2D20, $3540, $49A0, $5E20, $6E80
        .word $0002, $0000, $0000, $0000, $18A0, $20C0, $2D20, $3540
        .word $0003, $0000, $18A0, $20C0, $2D20, $3540, $3D80, $49A0
        .word $0003, $0820, $0000, $1060, $18A0, $20C0, $2D20, $3540
        .word $0003, $0000, $0000, $0000, $1060, $18A0, $20C0, $2D20
        .word $0003, $0000, $0000, $0000, $0000, $1060, $18A0, $20C0
        .word $0003, $0000, $0400, $0000, $0000, $0000, $1060, $1060
        .word $0003, $0000, $0000, $0000, $0800, $0800, $0000, $1060
        .word $0003, $0000, $0000, $0000, $0400, $0000, $0000, $0400
        .word $FFFF

      rlStartMapMagicLight ; 9F/AC5B

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicLight

        rtl

        .databank 0

      procMapMagicLight ; 9F/AC61

        ; Part of the Light effect.
        .structProcInfo "ON", rlMapMagicLightInit, rlMapMagicLightDarkenAndSpawn, aProcMapMagicLightCode

      aProcMapMagicLightCode ; 9F/AC69

        ; Part of the Light effect.
        PROC_YIELD 1
        PROC_CALL rlMapMagicLightStepBGPaletteAnim
        PROC_JUMP aProcMapMagicLightCode

      rlMapMagicLightInit ; 9F/AC74

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Light effect.

        jsr rsSetMapMagicLayerBlending
        jsr rsSaveMapMagicColors
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        rtl


      rlMapMagicLightDarkenAndSpawn ; 9F/AC81

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Light effect.
        jsr rsDarkenMapMagicColors
        bcc _ACC8
        jsr rsCreateMapMagicProc

          .word <>procMapMagicCircleWindow

        sta aProcSystem.aBody7,b,x
        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC34

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC77

        lda #<>rlMapMagicLightReverseFade
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0078
        sta aProcSystem.aBody0,b,x
        lda #$0080
        jsr rsPlayMapMagicSound

          .byte $59

        lda #(`aMapMagicLightSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicLightSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot

        _ACC8
        rtl


      rlMapMagicLightReverseFade ; 9F/ACC9

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Light effect.

        dec aProcSystem.aBody0,b,x
        bne _ACE1
        ldy aProcSystem.aBody7,b,x
        lda aProcSystem.aBody4,b,y
        eor #$FFFF
        inc a
        sta aProcSystem.aBody4,b,y
        lda #<>rlMapMagicLightDone
        sta aProcSystem.aHeaderOnCycle,b,x

        _ACE1
        rtl


      rlMapMagicLightDone ; 9F/ACE2

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Light effect.

        rtl


      rlMapMagicLightStepBGPaletteAnim ; 9F/ACE3

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Light effect.
        lda aProcSystem.aBody2,b,x
        beq _ACED
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _ACED
        lda #$0001
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc a
        and #$000F
        sta aProcSystem.aBody3,b,x
        asl a
        tax
        lda <>aMapMagicLightBGPaletteAnim,b,x
        sta $01D2,b
        lda <>(aMapMagicLightBGPaletteAnim+2),b,x
        sta $01D4,b
        lda <>(aMapMagicLightBGPaletteAnim+4),b,x
        sta $01D6,b
        lda <>(aMapMagicLightBGPaletteAnim+6),b,x
        sta $01D8,b
        lda <>(aMapMagicLightBGPaletteAnim+8),b,x
        sta $01DA,b
        lda <>(aMapMagicLightBGPaletteAnim+10),b,x
        sta $01DC,b
        lda <>(aMapMagicLightBGPaletteAnim+12),b,x
        sta $01DE,b
        lda <>(aMapMagicLightBGPaletteAnim+14),b,x
        sta aBGPaletteBuffer.aPalette7,b
        plx
        rtl

        .databank 0

      aMapMagicLightBGPaletteAnim ; 9F/AD32

        ; Part of the Light effect.
        .word $015F, $02FF, $03FF, $7FFF, $7FFF, $03FA, $03E0, $0260
        .word $015F, $02FF, $03FF, $7FFF, $7FFF, $03FA, $03E0, $0260
        .word $015F, $02FF, $03FF, $7FFF, $7FFF, $03FA, $03E0, $0260
        .word $015F, $02FF, $03FF, $7FFF, $7FFF, $03FA, $03E0, $0260

      aMapMagicLightSpriteInfo ; 9F/AD72

        ; Part of the Light effect.
        .word <>rlMapMagicLightSpriteInit, <>rlMapMagicLightSpriteWaitAppear, <>aMapMagicLightSpriteScript

      rlMapMagicLightSpriteInit ; 9F/AD78

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Light effect.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        stz aActiveSpriteSystem.aUnknown0013E0,b,x
        stz aActiveSpriteSystem.aUnknown0013C0,b,x
        lda #$0028
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        jml rlMapMagicLightStepSpritePaletteAnim

        .databank 0

        ; 9F/ADA3
      rlMapMagicLightSpriteWaitAppear ; 9F/ADA3

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Light effect.

        jsl rlMapMagicLightStepSpritePaletteAnim
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicLightSpriteFadeBack._AE18
        lda #<>rlMapMagicLightSpriteWaitStrike
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0020
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

        ; 9F/ADB9
      rlMapMagicLightSpriteWaitStrike ; 9F/ADB9

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Light effect.

        jsl rlMapMagicLightStepSpritePaletteAnim
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicLightSpriteFadeBack._AE18
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicLightSpriteWaitFlash
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0018
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

        ; 9F/ADD6
      rlMapMagicLightSpriteWaitFlash ; 9F/ADD6

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Light effect.

        jsl rlMapMagicLightStepSpritePaletteAnim
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicLightSpriteFadeBack._AE18
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        lda #<>rlMapMagicLightSpriteWaitFade
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0028
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

        ; 9F/ADF2
      rlMapMagicLightSpriteWaitFade ; 9F/ADF2

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Light effect.

        jsl rlMapMagicLightStepSpritePaletteAnim
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicLightSpriteFadeBack._AE18
        lda #<>rlMapMagicLightSpriteFadeBack
        sta aActiveSpriteSystem.aOnCycle,b,x
        jsr rsFreeMapMagicHDMA
        rtl

        .databank 0

        ; 9F/AE05
      rlMapMagicLightSpriteFadeBack ; 9F/AE05

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Light effect.

        jsl rlMapMagicLightStepSpritePaletteAnim
        jsr rsFadeBackMapMagicColors
        bcc _AE18
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta wMapMagicDone

        _AE18
        rtl

        .databank 0

        ; 9F/AE19
      rlMapMagicLightStepSpritePaletteAnim ; 9F/AE19

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Light effect.

        lda aActiveSpriteSystem.aUnknown001360,b,x
        beq _AE23
        dec a
        sta aActiveSpriteSystem.aUnknown001360,b,x
        rtl


        _AE23
        lda #$0002
        sta aActiveSpriteSystem.aUnknown001360,b,x
        phx
        lda aActiveSpriteSystem.aUnknown001380,b,x
        inc a
        and #$000F
        sta aActiveSpriteSystem.aUnknown001380,b,x
        asl a
        tax
        lda <>aMapMagicLightSpritePaletteAnim,b,x
        sta $02C4,b
        lda <>(aMapMagicLightSpritePaletteAnim+2),b,x
        sta $02C6,b
        lda <>(aMapMagicLightSpritePaletteAnim+4),b,x
        sta $02C8,b
        lda <>(aMapMagicLightSpritePaletteAnim+6),b,x
        sta $02CA,b
        lda <>(aMapMagicLightSpritePaletteAnim+8),b,x
        sta $02CC,b
        lda <>(aMapMagicLightSpritePaletteAnim+10),b,x
        sta $02CE,b
        plx
        rtl

        .databank 0

        ; 9F/AE5C

      aMapMagicLightSpritePaletteAnim ; 9F/AE5C

        ; Part of the Light effect.
        .word $65FC, $6A3C, $6E7D, $6EBD, $72FE, $773E, $7B7E, $7BBF
        .word $7FFF, $7BBF, $7B7E, $773E, $72FE, $6EBD, $6E7D, $6A3C
        .word $65FC, $6A3C, $6E7D, $6EBD, $72FE, $773E, $7B7E, $7BBF
        .word $7FFF, $7BBF, $7B7E, $773E, $72FE, $6EBD, $6E7D, $6A3C

      aMapMagicLightSpriteScript ; 9F/AE9C

        ; Part of the Light effect.
        ACTIVE_SPRITE_FRAME 8, aMapMagicLightFrame01
        ACTIVE_SPRITE_FRAME 8, aMapMagicLightFrame02
        ACTIVE_SPRITE_FRAME 8, aMapMagicLightFrame03
        ACTIVE_SPRITE_FRAME 8, aMapMagicLightFrame04

        _AEAC
        ACTIVE_SPRITE_FRAME 3, aMapMagicLightFrame05
        ACTIVE_SPRITE_FRAME 3, aMapMagicLightFrame06
        ACTIVE_SPRITE_FRAME 3, aMapMagicLightFrame07
        ACTIVE_SPRITE_FRAME 3, aMapMagicLightFrame08
        ACTIVE_SPRITE_CALL rlMapMagicLightWaitSpritePhase
        .word <>_AEAC
        ACTIVE_SPRITE_FRAME 3, aMapMagicLightFrame04
        ACTIVE_SPRITE_FRAME 3, aMapMagicLightFrame03
        ACTIVE_SPRITE_FRAME 3, aMapMagicLightFrame02
        ACTIVE_SPRITE_FRAME 3, aMapMagicLightFrame01

        _AED1
        ACTIVE_SPRITE_FRAME 1, aMapMagicLightFrameEmpty
        ACTIVE_SPRITE_JUMP _AED1

        ; 9F/AED8
      rlMapMagicLightWaitSpritePhase ; 9F/AED8

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Light effect.

        lda aActiveSpriteSystem.aUnknown0013A0,b,x
        bne _AEE2
        lda $0000,b,y
        tay
        rtl


        _AEE2
        stz aActiveSpriteSystem.aUnknown0013A0,b,x
        inc y
        inc y
        rtl

        .databank 0

        ; 9F/AEE8

      aMapMagicLightFrameEmpty ; 9F/AEE8

        ; Part of the Light effect.
        .word 0

      aMapMagicLightFrame01 ; 9F/AEEA

        ; Part of the Light effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 3, 6, false, false]]

        .structSpriteArray aMapMagicLightFrame01._Sprites

      aMapMagicLightFrame02 ; 9F/AEF1

        ; Part of the Light effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 3, 6, false, false]]

        .structSpriteArray aMapMagicLightFrame02._Sprites

      aMapMagicLightFrame03 ; 9F/AEF8

        ; Part of the Light effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 3, 6, false, false]]

        .structSpriteArray aMapMagicLightFrame03._Sprites

      aMapMagicLightFrame04 ; 9F/AEFF

        ; Part of the Light effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $006, 3, 6, false, false]]

        .structSpriteArray aMapMagicLightFrame04._Sprites

      aMapMagicLightFrame05 ; 9F/AF06

        ; Part of the Light effect.
        _Sprites := [[(  -8,   -6), $21, SpriteLarge, $00A, 3, 6, false, false]]

        .structSpriteArray aMapMagicLightFrame05._Sprites

      aMapMagicLightFrame06 ; 9F/AF0D

        ; Part of the Light effect.
        _Sprites := [[( -10,   -8), $21, SpriteLarge, $008, 3, 6, true, false]]

        .structSpriteArray aMapMagicLightFrame06._Sprites

      aMapMagicLightFrame07 ; 9F/AF14

        ; Part of the Light effect.
        _Sprites := [[(  -8,  -10), $21, SpriteLarge, $00A, 3, 6, false, true]]

        .structSpriteArray aMapMagicLightFrame07._Sprites

      aMapMagicLightFrame08 ; 9F/AF1B

        ; Part of the Light effect.
        _Sprites := [[(  -6,   -8), $21, SpriteLarge, $008, 3, 6, false, false]]

        .structSpriteArray aMapMagicLightFrame08._Sprites

      rlStartMapMagicThoron ; 9F/AF22

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicThoron

        rtl

        .databank 0

      procMapMagicThoron ; 9F/AF28

        ; Part of the Thoron effect.
        .structProcInfo "ON", rlMapMagicThoronInit, rlMapMagicThoronDarkenAndSpawn, aProcMapMagicHaltCode

      rlMapMagicThoronInit ; 9F/AF30

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thoron effect.

        jsr rsSetMapMagicLayerBlending
        jsr rsSaveMapMagicColors
        rtl


      rlMapMagicThoronDarkenAndSpawn ; 9F/AF37

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thoron effect.
        jsr rsDarkenMapMagicColors
        bcc _AF56
        lda #<>rlMapMagicThoronCycle
        sta aProcSystem.aHeaderOnCycle,b,x
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        lda #(`aMapMagicThoronSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicThoronSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot

        _AF56
        rtl


      rlMapMagicThoronCycle ; 9F/AF57

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thoron effect.

        jsl rlMapMagicThoronStepPaletteAnim
        rtl


      rlMapMagicThoronStepPaletteAnim ; 9F/AF5C

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thoron effect.
        lda aProcSystem.aBody2,b,x
        beq _AF66
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _AF66
        lda #$0002
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc aProcSystem.aBody3,b,x
        cmp #$000B
        bmi _AF7B
        stz aProcSystem.aBody3,b,x

        _AF7B
        asl a
        tax
        lda <>aMapMagicThoronPaletteAnim,b,x
        sta $01D2,b
        lda <>(aMapMagicThoronPaletteAnim+2),b,x
        sta $01D4,b
        lda <>(aMapMagicThoronPaletteAnim+4),b,x
        sta $01D6,b
        lda <>(aMapMagicThoronPaletteAnim+6),b,x
        sta $01D8,b
        lda <>(aMapMagicThoronPaletteAnim+8),b,x
        sta $01DA,b
        lda <>(aMapMagicThoronPaletteAnim+10),b,x
        sta $01DC,b
        lda <>(aMapMagicThoronPaletteAnim+12),b,x
        sta $01DE,b
        plx
        rtl

        .databank 0

      aMapMagicThoronPaletteAnim ; 9F/AFA9

        ; Part of the Thoron effect.
        .word $0000, $18A0, $30E0, $3160, $4E00, $66C0, $0000, $18A0
        .word $3160, $4E00, $66C0, $7F60, $0000, $18A0, $30E0, $3160
        .word $4E00, $66C0, $0000, $18A0, $3160, $4E00, $66C0, $7F60

      aMapMagicThoronSpriteInfo ; 9F/AFD9

        ; Part of the Thoron effect.
        .word <>rlMapMagicThoronSpriteInit, <>rlMapMagicThoronSpriteAim, <>aMapMagicThoronSpriteScript

      rlMapMagicThoronSpriteInit ; 9F/AFDF

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thoron effect.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicCasterPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicCasterPixel+1
        and #$00FF
        clc
        adc #$FFF8
        sta aActiveSpriteSystem.aYPosition,b,x
        lda #$0002
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda $7F50C9
        asl a
        tay
        lda <>aMapMagicThoronSpriteScripts,b,y
        sta aActiveSpriteSystem.aCodeOffset,b,x
        rtl

        .databank 0

        ; 9F/B011
      rlMapMagicThoronSpriteAim ; 9F/B011

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thoron effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _B052
        lda #<>rlMapMagicThoronSpriteFlyToTarget
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aXPosition,b,x
        sta wR0
        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aYPosition,b,x
        sta wR1
        jsl rlGetVectorLength
        lsr a
        lsr a
        bne _B041
        lda #$0002

        _B041
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda wR0
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda #$0400
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsMapMagicCalcSpriteVelocityFromAngle

        _B052
        rtl

        .databank 0

        ; 9F/B053
      rlMapMagicThoronSpriteFlyToTarget ; 9F/B053

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thoron effect.

        jsl rlMoveActiveSpriteByVelocity
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicThoronSpriteAim._B052
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        lda #<>rlMapMagicThoronSpriteWaitStrike
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0032
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $5C

        jsr rsCreateMapMagicProc

          .word <>procMapMagicThoronWindow

        sta aActiveSpriteSystem.aUnknown001380,b,x
        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBF1

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC77

        rtl

        .databank 0

        ; 9F/B0AB
      rlMapMagicThoronSpriteWaitStrike ; 9F/B0AB

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thoron effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicThoronSpriteReverseFade._B0E4
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicThoronSpriteReverseFade
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$000A
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

        ; 9F/B0C4
      rlMapMagicThoronSpriteReverseFade ; 9F/B0C4

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thoron effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _B0E4
        ldy aActiveSpriteSystem.aUnknown001380,b,x
        lda #$FFFD
        sta aProcSystem.aBody4,b,y
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        lda #<>rlMapMagicThoronSpriteWaitFade
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0010
        sta aActiveSpriteSystem.aUnknown0012C0,b,x

        _B0E4
        rtl

        .databank 0

        ; 9F/B0E5
      rlMapMagicThoronSpriteWaitFade ; 9F/B0E5

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thoron effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _B0F0
        lda #<>rlMapMagicThoronSpriteFadeBack
        sta aActiveSpriteSystem.aOnCycle,b,x

        _B0F0
        rtl

        .databank 0

        ; 9F/B0F1
      rlMapMagicThoronSpriteFadeBack ; 9F/B0F1

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thoron effect.

        jsr rsFadeBackMapMagicColors
        bcc _B100
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta wMapMagicDone

        _B100
        rtl

        .databank 0

        ; 9F/B101

      aMapMagicThoronSpriteScripts ; 9F/B101

        ; Part of the Thoron effect.
        .word <>aMapMagicThoronSpriteScript, <>aMapMagicThoronSpriteScript4, <>aMapMagicThoronSpriteScript2, <>aMapMagicThoronSpriteScript3
        .word <>aMapMagicThoronSpriteScript, <>aMapMagicThoronSpriteScript4, <>aMapMagicThoronSpriteScript2, <>aMapMagicThoronSpriteScript3

      aMapMagicThoronSpriteScript ; 9F/B111

        ; Part of the Thoron effect.
        ACTIVE_SPRITE_FRAME 3, aMapMagicThoronFrame01
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrameEmpty
        ACTIVE_SPRITE_FRAME 3, aMapMagicThoronFrame02
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicThoronWaitSpritePhase
        .word <>aMapMagicThoronSpriteScript5
        ACTIVE_SPRITE_JUMP aMapMagicThoronSpriteScript

        ; 9F/B129
      aMapMagicThoronSpriteScript2 ; 9F/B129

        ; Part of the Thoron effect.
        ACTIVE_SPRITE_FRAME 3, aMapMagicThoronFrame05
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrameEmpty
        ACTIVE_SPRITE_FRAME 3, aMapMagicThoronFrame06
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicThoronWaitSpritePhase
        .word <>aMapMagicThoronSpriteScript5
        ACTIVE_SPRITE_JUMP aMapMagicThoronSpriteScript2

        ; 9F/B141
      aMapMagicThoronSpriteScript3 ; 9F/B141

        ; Part of the Thoron effect.
        ACTIVE_SPRITE_FRAME 3, aMapMagicThoronFrame03
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrameEmpty
        ACTIVE_SPRITE_FRAME 3, aMapMagicThoronFrame04
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicThoronWaitSpritePhase
        .word <>aMapMagicThoronSpriteScript5
        ACTIVE_SPRITE_JUMP aMapMagicThoronSpriteScript3

        ; 9F/B159
      aMapMagicThoronSpriteScript4 ; 9F/B159

        ; Part of the Thoron effect.
        ACTIVE_SPRITE_FRAME 3, aMapMagicThoronFrame07
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrameEmpty
        ACTIVE_SPRITE_FRAME 3, aMapMagicThoronFrame08
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicThoronWaitSpritePhase
        .word <>aMapMagicThoronSpriteScript5
        ACTIVE_SPRITE_JUMP aMapMagicThoronSpriteScript4

        ; 9F/B171
      aMapMagicThoronSpriteScript5 ; 9F/B171

        ; Part of the Thoron effect.
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrame04
        ACTIVE_SPRITE_CALL rlMapMagicThoronWaitSpritePhase
        .word <>aMapMagicThoronSpriteScript6
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrame04
        ACTIVE_SPRITE_CALL rlMapMagicThoronWaitSpritePhase
        .word <>aMapMagicThoronSpriteScript6
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicThoronWaitSpritePhase
        .word <>aMapMagicThoronSpriteScript6
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrame09
        ACTIVE_SPRITE_CALL rlMapMagicThoronWaitSpritePhase
        .word <>aMapMagicThoronSpriteScript6
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrame09
        ACTIVE_SPRITE_CALL rlMapMagicThoronWaitSpritePhase
        .word <>aMapMagicThoronSpriteScript6
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicThoronWaitSpritePhase
        .word <>aMapMagicThoronSpriteScript6
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrame10
        ACTIVE_SPRITE_CALL rlMapMagicThoronWaitSpritePhase
        .word <>aMapMagicThoronSpriteScript6
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrame10
        ACTIVE_SPRITE_CALL rlMapMagicThoronWaitSpritePhase
        .word <>aMapMagicThoronSpriteScript6
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicThoronWaitSpritePhase
        .word <>aMapMagicThoronSpriteScript6
        ACTIVE_SPRITE_JUMP aMapMagicThoronSpriteScript5

        ; 9F/B1C5
      aMapMagicThoronSpriteScript6 ; 9F/B1C5

        ; Part of the Thoron effect.
        ACTIVE_SPRITE_FRAME 1, aMapMagicThoronFrameEmpty
        ACTIVE_SPRITE_JUMP aMapMagicThoronSpriteScript6

        ; 9F/B1CC
      rlMapMagicThoronWaitSpritePhase ; 9F/B1CC

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thoron effect.

        lda aActiveSpriteSystem.aUnknown0013A0,b,x
        beq _B1D9
        stz aActiveSpriteSystem.aUnknown0013A0,b,x
        lda $0000,b,y
        tay
        rtl


        _B1D9
        inc y
        inc y
        rtl

        .databank 0

        ; 9F/B1DC

      aMapMagicThoronFrameEmpty ; 9F/B1DC

        ; Part of the Thoron effect.
        .word 0

      aMapMagicThoronFrame01 ; 9F/B1DE

        ; Part of the Thoron effect.
        _Sprites := [[(   0,   -4), $00, SpriteSmall, $010, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -4), $00, SpriteSmall, $000, 2, 6, false, false]]

        .structSpriteArray aMapMagicThoronFrame01._Sprites

      aMapMagicThoronFrame02 ; 9F/B1EA

        ; Part of the Thoron effect.
        _Sprites := [[(   0,   -4), $00, SpriteSmall, $010, 2, 6, false, true]]
        _Sprites ..= [[(  -8,   -4), $00, SpriteSmall, $000, 2, 6, false, true]]

        .structSpriteArray aMapMagicThoronFrame02._Sprites

      aMapMagicThoronFrame03 ; 9F/B1F6

        ; Part of the Thoron effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, true, true]]

        .structSpriteArray aMapMagicThoronFrame03._Sprites

      aMapMagicThoronFrame04 ; 9F/B1FD

        ; Part of the Thoron effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00C, 2, 6, false, false]]

        .structSpriteArray aMapMagicThoronFrame04._Sprites

      aMapMagicThoronFrame05 ; 9F/B204

        ; Part of the Thoron effect.
        _Sprites := [[(  -4,    0), $00, SpriteSmall, $011, 2, 6, false, false]]
        _Sprites ..= [[(  -4,   -8), $00, SpriteSmall, $001, 2, 6, false, false]]

        .structSpriteArray aMapMagicThoronFrame05._Sprites

      aMapMagicThoronFrame06 ; 9F/B210

        ; Part of the Thoron effect.
        _Sprites := [[(  -4,   -8), $00, SpriteSmall, $011, 2, 6, false, true]]
        _Sprites ..= [[(  -4,    0), $00, SpriteSmall, $001, 2, 6, false, true]]

        .structSpriteArray aMapMagicThoronFrame06._Sprites

      aMapMagicThoronFrame07 ; 9F/B21C

        ; Part of the Thoron effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, true, false]]

        .structSpriteArray aMapMagicThoronFrame07._Sprites

      aMapMagicThoronFrame08 ; 9F/B223

        ; Part of the Thoron effect.
        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00C, 2, 6, true, false]]

        .structSpriteArray aMapMagicThoronFrame08._Sprites

      aMapMagicThoronFrameUnused ; 9F/B22A

        _Sprites := [[(   0,  -16), $21, SpriteLarge, $00A, 2, 6, false, true]]
        _Sprites ..= [[( -16,  -16), $21, SpriteLarge, $004, 2, 6, true, true]]
        _Sprites ..= [[( -16,    0), $21, SpriteLarge, $006, 2, 6, true, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aMapMagicThoronFrameUnused._Sprites

      aMapMagicThoronFrame09 ; 9F/B240

        ; Part of the Thoron effect.
        _Sprites := [[( -16,  -16), $21, SpriteLarge, $006, 2, 6, true, true]]
        _Sprites ..= [[(   0,  -16), $21, SpriteLarge, $004, 2, 6, false, true]]
        _Sprites ..= [[( -16,    0), $21, SpriteLarge, $008, 2, 6, true, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aMapMagicThoronFrame09._Sprites

      aMapMagicThoronFrame10 ; 9F/B256

        ; Part of the Thoron effect.
        _Sprites := [[(   0,    0), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[( -16,    0), $21, SpriteLarge, $00A, 2, 6, true, false]]
        _Sprites ..= [[(   0,  -16), $21, SpriteLarge, $006, 2, 6, false, true]]
        _Sprites ..= [[( -16,  -16), $21, SpriteLarge, $008, 2, 6, true, true]]

        .structSpriteArray aMapMagicThoronFrame10._Sprites

      rlStartMapMagicMeteor ; 9F/B26C

        .al
        .xl
        .autsiz
        .databank ?

        ; Also the Belhalla mages' meteors (rlInitBelhallaMeteorEffect sets effect 4).

        jsr rsCreateMapMagicProc

          .word <>procMapMagicMeteor

        lda #$0080
        jsr rsPlayMapMagicSound

          .byte $5E

        rtl

        .databank 0

      procMapMagicMeteor ; 9F/B279

        ; Part of the Meteor effect.
        .structProcInfo "ON", rlMapMagicMeteorInit, rlMapMagicMeteorDarken, aProcMapMagicMeteorCode

      aProcMapMagicMeteorCode ; 9F/B281

        ; Part of the Meteor effect.
        PROC_YIELD 1
        PROC_CALL rlMapMagicMeteorStepPaletteAnim
        PROC_JUMP aProcMapMagicMeteorCode

      rlMapMagicMeteorInit ; 9F/B28C

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.

        jsr rsSetMapMagicLayerBlending
        jsr rsSaveMapMagicColors
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C
        rtl


      rlMapMagicMeteorDarken ; 9F/B2AC

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.
        lda $7F50CB
        bne _B2B7
        jsr rsDarkenMapMagicColors
        bcc _B2C3

        _B2B7
        lda #<>rlMapMagicMeteorWaitAndSpawn
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0018
        sta aProcSystem.aBody0,b,x

        _B2C3
        rtl


      rlMapMagicMeteorWaitAndSpawn ; 9F/B2C4

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.

        dec aProcSystem.aBody0,b,x
        bpl _B2ED
        jsr rsCreateMapMagicProc

          .word <>procMapMagicMeteorWindow

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBF1

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDCF4

        lda #<>rlMapMagicMeteorCreateSprite
        sta aProcSystem.aHeaderOnCycle,b,x

        _B2ED
        rtl


      rlMapMagicMeteorCreateSprite ; 9F/B2EE

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.

        lda #<>rlMapMagicMeteorWaitImpact
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #(`aMapMagicMeteorSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicMeteorSpriteInfo
        sta lR44
        lda wMapMagicTargetPixel
        and #$00FF
        cmp #$00A0
        bmi _B314
        lda #(`aMapMagicMeteorSpriteInfo2)<<8
        sta lR44+1
        lda #<>aMapMagicMeteorSpriteInfo2
        sta lR44

        _B314
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        rtl


      rlMapMagicMeteorWaitImpact ; 9F/B319

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.

        lda $7ECC0C
        beq _B32B
        lda #<>rlMapMagicMeteorShakeLoop
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #<>aProcMapMagicHaltCode
        sta aProcSystem.aHeaderCodeOffset,b,x

        _B32B
        rtl


      rlMapMagicMeteorShakeLoop ; 9F/B32C

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.

        jsr rsShakeMapMagicBackground
        rtl


      rlMapMagicMeteorStepPaletteAnim ; 9F/B330

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.
        lda aProcSystem.aBody2,b,x
        beq _B33A
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _B33A
        lda #$0002
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc aProcSystem.aBody3,b,x
        cmp #$0027
        bmi _B34F
        stz aProcSystem.aBody3,b,x

        _B34F
        asl a
        tax
        lda <>aMapMagicMeteorPaletteAnim,b,x
        sta $01D2,b
        lda <>(aMapMagicMeteorPaletteAnim+2),b,x
        sta $01D4,b
        lda <>(aMapMagicMeteorPaletteAnim+4),b,x
        sta $01D6,b
        lda <>(aMapMagicMeteorPaletteAnim+6),b,x
        sta $01D8,b
        lda <>(aMapMagicMeteorPaletteAnim+8),b,x
        sta $01DA,b
        lda <>(aMapMagicMeteorPaletteAnim+10),b,x
        sta $01DC,b
        lda <>(aMapMagicMeteorPaletteAnim+12),b,x
        sta $01DE,b
        plx
        rtl

        .databank 0

      aMapMagicMeteorPaletteAnim ; 9F/B37D

        ; Part of the Meteor effect.
        .word $0012, $000D, $0012, $0017, $001F, $01FF
        .word $0012, $0008, $0012, $0017, $001F, $01FF
        .word $0012, $000D, $0012, $0017, $001F, $01FF
        .word $0012, $000D, $0012, $0017, $001F, $01FF
        .word $0012, $0008, $0012, $0017, $001F, $01FF
        .word $0012, $000D, $0012, $0017, $001F, $01FF
        .word $0012, $000D, $0012, $0017, $001F, $01FF
        .word $0008, $000D, $0012, $0017, $001F, $01FF

      aMapMagicMeteorSpriteInfo ; 9F/B3DD

        ; Part of the Meteor effect.
        .word <>rlMapMagicMeteorSpriteInit, <>rlMapMagicMeteorSpriteDescend, <>aMapMagicMeteorSpriteScript

      aMapMagicMeteorSpriteInfo2 ; 9F/B3E3

        ; Part of the Meteor effect.
        .word <>rlMapMagicMeteorSpriteInit, <>rlMapMagicMeteorSpriteDescend, <>aMapMagicMeteorSpriteScript2

      rlMapMagicMeteorSpriteInit ; 9F/B3E9

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda #$00F8
        sta aActiveSpriteSystem.aXPosition,b,x
        lda #$FFF0
        sta aActiveSpriteSystem.aYPosition,b,x
        stz aActiveSpriteSystem.aUnknown0013E0,b,x
        stz aActiveSpriteSystem.aUnknown0013C0,b,x
        lda $7ECC0A
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

        ; 9F/B40A
      rlMapMagicMeteorSpriteDescend ; 9F/B40A

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.

        jsl rlHDMAMapMagicStepScrollY
        lda $7F50CD
        eor #$FFFF
        inc a
        clc
        adc #$0080
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda $7F50CF
        eor #$FFFF
        inc a
        clc
        adc #$0070
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta wR0
        lda aActiveSpriteSystem.aYPosition,b,x
        cmp wR0
        bmi _B461
        lda wR0
        sta aActiveSpriteSystem.aYPosition,b,x
        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $5F

        lda #$000C
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlMapMagicMeteorSpriteWaitStrike
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0001
        sta $7ECC0C

        _B461
        rtl

        .databank 0

        ; 9F/B462
      rlMapMagicMeteorSpriteWaitStrike ; 9F/B462

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _B474
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicMeteorSpriteFlashBlack
        sta aActiveSpriteSystem.aOnCycle,b,x

        _B474
        rtl

        .databank 0

        ; 9F/B475
      rlMapMagicMeteorSpriteFlashBlack ; 9F/B475

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.

        lda #$0000
        sta aPaletteFading.wDesiredColor,b
        lda #$0006
        sta aPaletteFading,b
        jsl rlFadePaletteToBlack

          .word <>aMapMagicMeteorFlashBlackData

        bcc _B495
        lda #<>rlMapMagicMeteorSpriteWaitFade
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$000E
        sta aActiveSpriteSystem.aUnknown0012C0,b,x

        _B495
        rtl

        .databank 0

        ; 9F/B496

      aMapMagicMeteorFlashBlackData ; 9F/B496

        ; Part of the Meteor effect.
        .byte $D2, $00, $07, $00, $FF, $FF

      rlMapMagicMeteorSpriteWaitFade ; 9F/B49C

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _B4AE
        lda #$0002
        sta $7ECC0C
        lda #<>rlMapMagicMeteorSpriteFadeBack
        sta aActiveSpriteSystem.aOnCycle,b,x

        _B4AE
        rtl

        .databank 0

        ; 9F/B4AF
      rlMapMagicMeteorSpriteFadeBack ; 9F/B4AF

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.

        lda $7F50CB
        bne _B4BA
        jsr rsFadeBackMapMagicColors
        bcc _B4C7

        _B4BA
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta wMapMagicDone
        jsr rsFreeMapMagicProcs

        _B4C7
        rtl

        .databank 0

        ; 9F/B4C8
      aMapMagicMeteorSpriteScript ; 9F/B4C8

        ; Part of the Meteor effect.
        ACTIVE_SPRITE_FRAME 1, aMapMagicMeteorFrame01
        ACTIVE_SPRITE_CALL rlMapMagicMeteorWaitSpritePhase
        .word <>aMapMagicMeteorSpriteScript

        _B4D1
        ACTIVE_SPRITE_FRAME 1, aMapMagicMeteorFrameEmpty
        ACTIVE_SPRITE_JUMP _B4D1

        ; 9F/B4D8
      aMapMagicMeteorSpriteScript2 ; 9F/B4D8

        ; Part of the Meteor effect.
        ACTIVE_SPRITE_FRAME 1, aMapMagicMeteorFrame02
        ACTIVE_SPRITE_CALL rlMapMagicMeteorWaitSpritePhase
        .word <>aMapMagicMeteorSpriteScript2

        _B4E1
        ACTIVE_SPRITE_FRAME 1, aMapMagicMeteorFrameEmpty
        ACTIVE_SPRITE_JUMP _B4E1

        ; 9F/B4E8
      rlMapMagicMeteorWaitSpritePhase ; 9F/B4E8

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.

        lda $7ECC0C
        cmp #$0002
        beq _B4F6
        lda $0000,b,y
        tay
        rtl


        _B4F6
        inc y
        inc y
        rtl

        .databank 0

        ; 9F/B4F9

      aMapMagicMeteorFrameEmpty ; 9F/B4F9

        ; Part of the Meteor effect.
        .word 0

      aMapMagicMeteorFrame01 ; 9F/B4FB

        ; Part of the Meteor effect.
        _Sprites := [[(   0,    0), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[( -16,    0), $21, SpriteLarge, $004, 2, 6, false, false]]
        _Sprites ..= [[(   0,  -16), $21, SpriteLarge, $002, 2, 6, false, false]]
        _Sprites ..= [[( -16,  -16), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aMapMagicMeteorFrame01._Sprites

      aMapMagicMeteorFrame02 ; 9F/B511

        ; Part of the Meteor effect.
        _Sprites := [[( -16,    0), $21, SpriteLarge, $006, 2, 6, true, false]]
        _Sprites ..= [[(   0,    0), $21, SpriteLarge, $004, 2, 6, true, false]]
        _Sprites ..= [[( -16,  -16), $21, SpriteLarge, $002, 2, 6, true, false]]
        _Sprites ..= [[(   0,  -16), $21, SpriteLarge, $000, 2, 6, true, false]]

        .structSpriteArray aMapMagicMeteorFrame02._Sprites

      rlStartMapMagicBlizzard ; 9F/B527

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicBlizzard

        rtl

        .databank 0

      procMapMagicBlizzard ; 9F/B52D

        ; Part of the Blizzard effect.
        .structProcInfo "ON", rlMapMagicBlizzardInit, rlMapMagicBlizzardDarken, aProcMapMagicHaltCode

      rlMapMagicBlizzardInit ; 9F/B535

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Blizzard effect.

        jsr rsSetMapMagicLayerBlending
        jsr rsSaveMapMagicColors

        _B53B
        rtl


      rlMapMagicBlizzardDarken ; 9F/B53C

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Blizzard effect.
        jsr rsDarkenMapMagicColors
        bcc rlMapMagicBlizzardInit._B53B
        lda #<>rlMapMagicBlizzardWaitAndSpawn
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0004
        sta aProcSystem.aBody0,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $66

        rtl


      rlMapMagicBlizzardWaitAndSpawn ; 9F/B559

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Blizzard effect.

        dec aProcSystem.aBody0,b,x
        bpl _B56D
        jsr rlMapMagicBlizzardSpawnEffects
        lda #<>rlMapMagicBlizzardWaitCast
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0028
        sta aProcSystem.aBody0,b,x

        _B56D
        rtl


      rlMapMagicBlizzardWaitCast ; 9F/B56E

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Blizzard effect.

        dec aProcSystem.aBody0,b,x
        bne _B57F
        lda #<>rlMapMagicBlizzardWaitStrike
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0014
        sta aProcSystem.aBody0,b,x

        _B57F
        rtl


      rlMapMagicBlizzardWaitStrike ; 9F/B580

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Blizzard effect.

        dec aProcSystem.aBody0,b,x
        bne rlMapMagicBlizzardReverseFade._B5B7
        lda #<>rlMapMagicBlizzardReverseFade
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0014
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        rtl


      rlMapMagicBlizzardReverseFade ; 9F/B599

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Blizzard effect.

        dec aProcSystem.aBody0,b,x
        bne _B5B7
        lda #<>rlMapMagicBlizzardWaitFreeHDMA
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0014
        sta aProcSystem.aBody0,b,x
        ldy aProcSystem.aBody7,b,x
        lda aProcSystem.aBody4,b,y
        eor #$FFFF
        inc a
        sta aProcSystem.aBody4,b,y

        _B5B7
        rtl


      rlMapMagicBlizzardWaitFreeHDMA ; 9F/B5B8

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Blizzard effect.

        dec aProcSystem.aBody0,b,x
        bne _B5CC
        jsr rsFreeMapMagicHDMA
        lda #<>rlMapMagicBlizzardWaitFade
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta aProcSystem.aBody0,b,x

        _B5CC
        rtl


      rlMapMagicBlizzardWaitFade ; 9F/B5CD

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Blizzard effect.

        dec aProcSystem.aBody0,b,x
        bne _B5D8
        lda #<>rlMapMagicBlizzardFadeBack
        sta aProcSystem.aHeaderOnCycle,b,x

        _B5D8
        rtl


      rlMapMagicBlizzardFadeBack ; 9F/B5D9

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Blizzard effect.

        jsr rsFadeBackMapMagicColors
        bcc rlMapMagicBlizzardDone
        lda #<>rlMapMagicBlizzardDone
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta wMapMagicDone

      rlMapMagicBlizzardDone ; 9F/B5EB

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Blizzard effect.

        rtl


      rlMapMagicBlizzardSpawnEffects ; 9F/B5EC

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Blizzard effect.
        jsr rsCreateMapMagicProc

          .word <>procMapMagicBlizzardHelWindow

        sta aProcSystem.aBody7,b,x
        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC34

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aMapMagicBlizzardSpawnParams

        rts

        .databank 0

      rlStartMapMagicReturn ; 9F/B60E

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicReturn

        rtl

        .databank 0

      rlStartMapMagicRestore ; 9F/B614

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicRestore

        rtl

        .databank 0

      rlStartMapMagicSleep ; 9F/B61A

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicSleep

        rtl

        .databank 0

      procMapMagicSleep ; 9F/B620

        ; Part of the Sleep effect.
        .structProcInfo "ON", rlMapMagicStaffEffectInit, rlMapMagicSleepInit, aProcMapMagicSleepCode

      aProcMapMagicSleepCode ; 9F/B628

        ; Part of the Sleep effect.
        PROC_YIELD 1
        PROC_CALL rlMapMagicSleepStepPaletteAnim
        PROC_JUMP aProcMapMagicSleepCode

      rlMapMagicSleepInit ; 9F/B633

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Sleep effect.

        jsr rsCreateMapMagicProc

          .word <>procMapMagicStaffWindow

        sta aProcSystem.aBody7,b,x
        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBF1

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FE2E5

        lda #<>rlMapMagicSleepWaitStrike
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        phx
        lda #(`aMapMagicStaffSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicStaffSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        plx
        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $7C

        rtl


      rlMapMagicSleepWaitStrike ; 9F/B67C

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Sleep effect.

        dec aProcSystem.aBody0,b,x
        bne _B694
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicSleepWaitHold
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0080
        sta aProcSystem.aBody0,b,x

        _B694
        rtl


      rlMapMagicSleepWaitHold ; 9F/B695

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Sleep effect.

        dec aProcSystem.aBody0,b,x
        bne _B6B6
        ldy aProcSystem.aBody7,b,x
        lda #$FF00
        sta aProcSystem.aBody4,b,y
        lda #<>rlMapMagicSleepWaitEnd
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC08

        _B6B6
        rtl


      rlMapMagicSleepWaitEnd ; 9F/B6B7

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Sleep effect.

        dec aProcSystem.aBody0,b,x
        bne _B6C3
        lda #$0001
        sta $7ECC06

        _B6C3
        rtl

        .databank 0

      procMapMagicReturn ; 9F/B6C4

        ; Part of the Return effect.
        .structProcInfo "ON", rlMapMagicStaffEffectInit, rlMapMagicReturnInit, aProcMapMagicReturnCode

      rlMapMagicStaffEffectInit ; 9F/B6CC

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Restore, Return and Sleep effects.

        jsr rsSetMapMagicLayerBlending
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        lda aMapAction.wMapBattleDefenderSpriteSlot
        tay
        lda aActiveSpriteSystem.aYPosition,b,y
        sta aProcSystem.aBody5,b,x
        stz aProcSystem.aBody6,b,x
        rtl

        .databank 0

      aProcMapMagicReturnCode ; 9F/B6F7

        ; Part of the Return effect.
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $0F
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $0E
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $0D
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $0C
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $0B
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $0A
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $09
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $08
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $07
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $06
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $05
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $04
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $03
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $02
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $01
        PROC_YIELD 3
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $00
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $0F
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $0E
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $0D
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $0C
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $0B
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $0A
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $09
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $08
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $07
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $06
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $05
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $04
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $03
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $02
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $01
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicReturnLoadPaletteStep, 1
        .byte $00
        PROC_JUMP aProcMapMagicReturnCode

      rlMapMagicReturnInit ; 9F/B81B

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Return effect.

        jsr rsCreateMapMagicProc

          .word <>procMapMagicStaffWindow

        sta aProcSystem.aBody7,b,x
        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC34

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC77

        lda #<>rlMapMagicReturnWaitStrike
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        phx
        lda #(`aMapMagicStaffSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicStaffSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        plx
        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $7D

        rtl


      rlMapMagicReturnWaitStrike ; 9F/B864

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Return effect.

        dec aProcSystem.aBody0,b,x
        bne _B876
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicReturnLiftUnit
        sta aProcSystem.aHeaderOnCycle,b,x

        _B876
        rtl


      rlMapMagicReturnLiftUnit ; 9F/B877

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Return effect.

        jsr rlMapMagicReturnWaitEnd._B8B8
        bcc _B888
        lda #<>rlMapMagicReturnWaitHold
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0010
        sta aProcSystem.aBody0,b,x

        _B888
        rtl


      rlMapMagicReturnWaitHold ; 9F/B889

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Return effect.

        dec aProcSystem.aBody0,b,x
        bne _B8AA
        ldy aProcSystem.aBody7,b,x
        lda #$FF00
        sta aProcSystem.aBody4,b,y
        lda #<>rlMapMagicReturnWaitEnd
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC08

        _B8AA
        rtl


      rlMapMagicReturnWaitEnd ; 9F/B8AB

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Return effect.

        dec aProcSystem.aBody0,b,x
        bne _B8B7
        lda #$0001
        sta $7ECC06

        _B8B7
        rtl


        _B8B8
        lda aProcSystem.aBody6,b,x
        inc a
        cmp #$003F
        bmi _B8C4
        lda #$003F

        _B8C4
        sta aProcSystem.aBody6,b,x
        lda aMapAction.wMapBattleDefenderAuxSpriteSlot
        cmp #$FFFF
        beq _B8D3
        jsr _B8D7

        _B8D3
        lda aMapAction.wMapBattleDefenderSpriteSlot

        _B8D7
        tay
        lda aActiveSpriteSystem.aYPosition,b,y
        clc
        adc #$FFFE
        bmi _B91B
        phx
        lda $7ECC0A
        clc
        adc #$0010
        sta $7ECC0A
        and #$FF00
        xba
        eor #$FFFF
        inc a
        clc
        adc aProcSystem.aBody5,b,x
        sta aProcSystem.aBody5,b,x
        sta wR0
        lda aProcSystem.aBody6,b,x
        and #$001F
        lsr a
        tax
        lda <>aMapMagicReturnWaitEndValues,b,x
        asl a
        and #$00FF
        eor #$FFFF
        inc a
        clc
        adc wR0
        sta aActiveSpriteSystem.aYPosition,b,y
        plx
        clc
        rts


        _B91B
        lda aMapAction.wMapBattleDefenderAuxSpriteSlot
        cmp #$FFFF
        beq _B927
        jsr _B92B

        _B927
        lda aMapAction.wMapBattleDefenderSpriteSlot

        _B92B
        tay
        lda #$FFF8
        sta aActiveSpriteSystem.aYPosition,b,y
        sec
        rts

        .databank 0

      aMapMagicReturnWaitEndValues ; 9F/B934

        ; Part of the Return effect.
        .word $0100, $0200, $0300, $0400, $0500, $0600, $0700, $0800
        .word $0900, $0A00, $0B00, $0C00, $0D00, $0E00, $0F00, $1000
        .word $1100, $1200, $1300, $1400, $1500, $1600, $1700, $1800
        .word $1900, $1A00, $1B00, $1C00, $1D00, $1E00, $1F00, $2000

      procMapMagicRestore ; 9F/B974

        ; Part of the Restore effect.
        .structProcInfo "ON", rlMapMagicStaffEffectInit, rlMapMagicRestoreInit, aProcMapMagicRestoreCode

      aProcMapMagicRestoreCode ; 9F/B97C

        ; Part of the Restore effect.
        PROC_YIELD 1
        PROC_CALL rlMapMagicRestoreStepPaletteAnim
        PROC_JUMP aProcMapMagicRestoreCode

      rlMapMagicRestoreInit ; 9F/B987

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Restore effect.

        jsr rsCreateMapMagicProc

          .word <>procMapMagicStaffWindow

        sta aProcSystem.aBody7,b,x
        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBF1

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FE2D9

        lda #<>rlMapMagicRestoreWaitStrike
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        phx
        lda #(`aMapMagicStaffSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicStaffSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        plx
        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $78

        rtl


      rlMapMagicRestoreWaitStrike ; 9F/B9D0

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Restore effect.

        dec aProcSystem.aBody0,b,x
        bne _B9E8
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicRestoreWaitHold
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0080
        sta aProcSystem.aBody0,b,x

        _B9E8
        rtl


      rlMapMagicRestoreWaitHold ; 9F/B9E9

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Restore effect.

        dec aProcSystem.aBody0,b,x
        bne _BA0A
        ldy aProcSystem.aBody7,b,x
        lda #$FF00
        sta aProcSystem.aBody4,b,y
        lda #<>rlMapMagicRestoreWaitEnd
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC08

        _BA0A
        rtl


      rlMapMagicRestoreWaitEnd ; 9F/BA0B

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Restore effect.

        dec aProcSystem.aBody0,b,x
        bne _BA17
        lda #$0001
        sta $7ECC06

        _BA17
        rtl

        .databank 0

      aMapMagicStaffSpriteInfo ; 9F/BA18

        ; Shared by the Restore, Return and Sleep effects.
        .word <>rlMapMagicStaffSpriteInit, <>rlMapMagicStaffSpriteWaitEnd, <>aMapMagicStaffSpriteScript

      rlMapMagicStaffSpriteInit ; 9F/BA1E

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Restore, Return and Sleep effects.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicTargetPixel+1
        clc
        adc #$FFFC
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        rtl


      rlMapMagicStaffSpriteWaitEnd ; 9F/BA3E

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Restore, Return and Sleep effects.
        lda $7ECC06
        beq _BA4E
        lda #$0001
        sta wMapMagicDone
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _BA4E
        rtl

        .databank 0

      aMapMagicStaffSpriteScript ; 9F/BA4F

        ; Shared by the Restore, Return and Sleep effects.
        ACTIVE_SPRITE_FRAME 3, aMapMagicStaffFrame06
        ACTIVE_SPRITE_FRAME 3, aMapMagicStaffFrame02
        ACTIVE_SPRITE_FRAME 3, aMapMagicStaffFrame04
        ACTIVE_SPRITE_FRAME 3, aMapMagicStaffFrame03
        ACTIVE_SPRITE_FRAME 3, aMapMagicStaffFrame05

        _BA63
        ACTIVE_SPRITE_FRAME 1, aMapMagicStaffFrame01
        ACTIVE_SPRITE_CALL rlMapMagicStaffWaitSpritePhase
        .word <>_BA63
        ACTIVE_SPRITE_FRAME 2, aMapMagicStaffFrame05
        ACTIVE_SPRITE_FRAME 2, aMapMagicStaffFrame03
        ACTIVE_SPRITE_FRAME 2, aMapMagicStaffFrame04
        ACTIVE_SPRITE_FRAME 2, aMapMagicStaffFrame02
        ACTIVE_SPRITE_FRAME 2, aMapMagicStaffFrame06

        _BA80
        ACTIVE_SPRITE_FRAME 1, aMapMagicStaffFrameEmpty
        ACTIVE_SPRITE_JUMP _BA80

        ; 9F/BA87

      rlMapMagicStaffWaitSpritePhase ; 9F/BA87

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Restore, Return and Sleep effects.

        lda $7ECC08
        bne _BA92
        lda $0000,b,y
        tay
        rtl


        _BA92
        inc y
        inc y
        rtl

        .databank 0

      aMapMagicStaffFrameEmpty ; 9F/BA95

        ; Shared by the Restore, Return and Sleep effects.
        .word 0

      aMapMagicStaffFrame01 ; 9F/BA97

        ; Shared by the Restore, Return and Sleep effects.
        _Sprites := [[(   5,    8), $00, SpriteSmall, $012, 2, 6, false, false]]
        _Sprites ..= [[(   5,    0), $00, SpriteSmall, $002, 2, 6, false, false]]
        _Sprites ..= [[( -11,    0), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aMapMagicStaffFrame01._Sprites

      aMapMagicStaffFrame02 ; 9F/BAA8

        ; Shared by the Restore, Return and Sleep effects.
        _Sprites := [[(  -3,    3), $00, SpriteSmall, $003, 2, 6, false, false]]

        .structSpriteArray aMapMagicStaffFrame02._Sprites

      aMapMagicStaffFrame03 ; 9F/BAAF

        ; Shared by the Restore, Return and Sleep effects.
        _Sprites := [[(  -8,    0), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aMapMagicStaffFrame03._Sprites

      aMapMagicStaffFrame04 ; 9F/BAB6

        ; Shared by the Restore, Return and Sleep effects.
        _Sprites := [[(  -8,    0), $21, SpriteLarge, $006, 2, 6, false, false]]

        .structSpriteArray aMapMagicStaffFrame04._Sprites

      aMapMagicStaffFrame05 ; 9F/BABD

        ; Shared by the Restore, Return and Sleep effects.
        _Sprites := [[(   5,    8), $00, SpriteSmall, $01A, 2, 6, false, false]]
        _Sprites ..= [[(   5,    0), $00, SpriteSmall, $00A, 2, 6, false, false]]
        _Sprites ..= [[( -11,    0), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aMapMagicStaffFrame05._Sprites

      aMapMagicStaffFrame06 ; 9F/BACE

        ; Shared by the Restore, Return and Sleep effects.
        _Sprites := [[(  -3,    4), $00, SpriteSmall, $013, 2, 6, false, false]]

        .structSpriteArray aMapMagicStaffFrame06._Sprites

      rlMapMagicSleepStepPaletteAnim ; 9F/BAD5

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Sleep effect.

        lda aProcSystem.aBody2,b,x
        beq _BADF
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _BADF
        lda #$0002
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc aProcSystem.aBody3,b,x
        cmp #$0010
        bmi _BAF4
        stz aProcSystem.aBody3,b,x

        _BAF4
        asl a
        tax
        lda <>(aMapMagicSleepPaletteAnim+12),b,x
        sta $01D2,b
        sta $02C2,b
        lda <>(aMapMagicSleepPaletteAnim+10),b,x
        sta $01D4,b
        sta $02C4,b
        lda <>(aMapMagicSleepPaletteAnim+8),b,x
        sta $01D6,b
        sta $02C6,b
        lda <>(aMapMagicSleepPaletteAnim+6),b,x
        sta $01D8,b
        sta $02C8,b
        lda <>(aMapMagicSleepPaletteAnim+4),b,x
        sta $01DA,b
        sta $02CA,b
        lda <>(aMapMagicSleepPaletteAnim+2),b,x
        sta $01DC,b
        sta $02CC,b
        plx
        rtl

        .databank 0

      aMapMagicSleepPaletteAnim ; 9F/BB2E

        ; Part of the Sleep effect.
        .word $7E0B, $7E0E, $7E11, $7E14, $7E16, $7E19, $7E1C, $7E1F
        .word $7E1F, $7DDD, $7D7A, $7D38, $7CF6, $7CB4, $7C51, $7C0F
        .word $7C0F, $7C6D, $7CCC, $7D2A, $7DA9, $7E07, $7E66, $7EC4
        .word $7EC4, $7E66, $7E07, $7DA9, $7D2A, $7CCC, $7C6D, $7C0F
        .word $7E0B, $7E0E, $7E11, $7E14, $7E16, $7E19, $7E1C, $7E1F
        .word $7E1F, $7DDD, $7D7A, $7D38, $7CF6, $7CB4, $7C51, $7C0F

      rlMapMagicRestoreStepPaletteAnim ; 9F/BB8E

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Restore effect.

        lda aProcSystem.aBody2,b,x
        beq _BB98
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _BB98
        lda #$0002
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        dec a
        bpl _BBA8
        lda #$0020

        _BBA8
        sta aProcSystem.aBody3,b,x
        asl a
        tax
        lda <>aMapMagicRestorePaletteAnim,b,x
        sta $01D2,b
        sta $02C2,b
        lda <>(aMapMagicRestorePaletteAnim+2),b,x
        sta $01D4,b
        sta $02C4,b
        lda <>(aMapMagicRestorePaletteAnim+4),b,x
        sta $01D6,b
        sta $02C6,b
        lda <>(aMapMagicRestorePaletteAnim+6),b,x
        sta $01D8,b
        sta $02C8,b
        lda <>(aMapMagicRestorePaletteAnim+8),b,x
        sta $01DA,b
        sta $02CA,b
        lda <>(aMapMagicRestorePaletteAnim+10),b,x
        sta $01DC,b
        sta $02CC,b
        plx
        rtl

        .databank 0

      aMapMagicRestorePaletteAnim ; 9F/BBE5

        ; Part of the Restore effect.
        .word $7D40, $7520, $7120, $6900, $64E0, $5CE0, $58C0, $50A0
        .word $4CA0, $4480, $4060, $3860, $3440, $2C20, $2820, $2000
        .word $2000, $2820, $2C20, $3440, $3860, $4060, $4480, $4CA0
        .word $50A0, $58C0, $5CE0, $64E0, $6900, $7120, $7520, $7D40
        .word $7D40, $7520, $7120, $6900, $64E0, $5CE0, $58C0, $50A0
        .word $4CA0, $4480, $4060, $3860, $3440, $2C20, $2820, $2000

      rlMapMagicReturnLoadPaletteStep ; 9F/BC45

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Return effect.

        phx
        lda $0000,b,y
        and #$00FF
        asl a
        tax
        lda <>aMapMagicReturnPaletteSteps,b,x
        sta $01D2,b
        sta $02C2,b
        lda <>(aMapMagicReturnPaletteSteps+2),b,x
        sta $01D4,b
        sta $02C4,b
        lda <>(aMapMagicReturnPaletteSteps+4),b,x
        sta $01D6,b
        sta $02C6,b
        lda <>(aMapMagicReturnPaletteSteps+6),b,x
        sta $01D8,b
        sta $02C8,b
        lda <>(aMapMagicReturnPaletteSteps+8),b,x
        sta $01DA,b
        sta $02CA,b
        lda <>(aMapMagicReturnPaletteSteps+10),b,x
        sta $01DC,b
        sta $02CC,b
        lda <>(aMapMagicReturnPaletteSteps+12),b,x
        sta $01DE,b
        sta $02CE,b
        plx
        rtl

        .databank 0

      aMapMagicReturnPaletteSteps ; 9F/BC8F

        ; Part of the Return effect.
        .word $43FF, $039F, $033D, $025A, $01DA, $0159, $00F0, $006E
        .word $006E, $00F0, $0159, $01DA, $025A, $033D, $039F, $43FF
        .word $43FF, $039F, $033D, $025A, $01DA, $0159, $00F0, $006E
        .word $006E, $00F0, $0159, $01DA, $025A, $033D, $039F, $43FF

      rlStartMapMagicMjolnir ; 9F/BCCF

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicMjolnir

        rtl

        .databank 0

      procMapMagicMjolnir ; 9F/BCD5

        ; Part of the Mjolnir effect.
        .structProcInfo "ON", rlMapMagicMjolnirInit, rlMapMagicMjolnirDarkenAndSpawn, aProcMapMagicMjolnirCode

      rlMapMagicMjolnirInit ; 9F/BCDD

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        jsr rsSetMapMagicLayerBlending
        jsr rsSaveMapMagicColors
        stz aProcSystem.aBody0,b,x
        stz aProcSystem.aBody1,b,x
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C

        _BCFC
        rtl


      rlMapMagicMjolnirDarkenAndSpawn ; 9F/BCFD

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.
        jsr rsDarkenMapMagicColors
        bcc rlMapMagicMjolnirInit._BCFC
        jsr rsCreateMapMagicProc

          .word <>procMapMagicMjolnirWindow

        sta aProcSystem.aBody7,b,x
        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC34

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC77

        lda #<>rlMapMagicMjolnirWaitCast
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        jsl rlMapMagicMjolnirStepScroll
        lda #(`aMapMagicMjolnirSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicMjolnirSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        rtl


      rlMapMagicMjolnirWaitCast ; 9F/BD48

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        jsl rlMapMagicMjolnirStepScroll
        dec aProcSystem.aBody0,b,x
        bne _BD5D
        lda #<>rlMapMagicMjolnirWaitStrike
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0030
        sta aProcSystem.aBody0,b,x

        _BD5D
        rtl


      rlMapMagicMjolnirWaitStrike ; 9F/BD5E

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        jsl rlMapMagicMjolnirStepScroll
        dec aProcSystem.aBody0,b,x
        bne rlMapMagicMjolnirWaitImpact._BD9E
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicMjolnirWaitImpact
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0050
        sta aProcSystem.aBody0,b,x
        rtl


      rlMapMagicMjolnirWaitImpact ; 9F/BD7B

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        jsl rlMapMagicMjolnirStepScroll
        lda $7ECC06
        beq _BD9E
        ldy aProcSystem.aBody7,b,x
        lda aProcSystem.aBody4,b,y
        eor #$FFFF
        inc a
        sta aProcSystem.aBody4,b,y
        lda #<>rlMapMagicMjolnirWaitFade
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$000C
        sta aProcSystem.aBody0,b,x

        _BD9E
        rtl


      rlMapMagicMjolnirWaitFade ; 9F/BD9F

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        dec aProcSystem.aBody0,b,x
        bne _BDAD
        lda #<>rlMapMagicMjolnirFadeBack
        sta aProcSystem.aHeaderOnCycle,b,x
        jsr rsFreeMapMagicHDMA

        _BDAD
        rtl


      rlMapMagicMjolnirFadeBack ; 9F/BDAE

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        jsr rsFadeBackMapMagicColors
        bcc rlMapMagicMjolnirDone
        lda #<>rlMapMagicMjolnirDone
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta wMapMagicDone

      rlMapMagicMjolnirDone ; 9F/BDC0

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        rtl

        .databank 0

      aProcMapMagicMjolnirCode ; 9F/BDC1

        ; Part of the Mjolnir effect.
        PROC_YIELD 1
        PROC_CALL_ARGS rlMapMagicMjolnirLoadPaletteStep, 1
        .byte $00
        PROC_YIELD 1
        PROC_CALL_ARGS rlMapMagicMjolnirLoadPaletteStep, 1
        .byte $01
        PROC_YIELD 1
        PROC_CALL_ARGS rlMapMagicMjolnirLoadPaletteStep, 1
        .byte $02
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicMjolnirLoadPaletteStep, 1
        .byte $03
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicMjolnirLoadPaletteStep, 1
        .byte $04
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicMjolnirLoadPaletteStep, 1
        .byte $05
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicMjolnirLoadPaletteStep, 1
        .byte $06
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicMjolnirLoadPaletteStep, 1
        .byte $07
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicMjolnirLoadPaletteStep, 1
        .byte $08
        PROC_YIELD 1
        PROC_CALL_ARGS rlMapMagicMjolnirLoadPaletteStep, 1
        .byte $09
        PROC_YIELD 1
        PROC_CALL_ARGS rlMapMagicMjolnirLoadPaletteStep, 1
        .byte $0A
        PROC_YIELD 1
        PROC_CALL_ARGS rlMapMagicMjolnirLoadPaletteStep, 1
        .byte $0B
        PROC_JUMP aProcMapMagicMjolnirCode


      rlMapMagicMjolnirLoadPaletteStep ; 9F/BE31

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        lda $0000,b,y
        and #$00FF
        asl a
        tax
        lda <>aMapMagicMjolnirPaletteSteps,b,x
        sta $01D2,b
        lda <>(aMapMagicMjolnirPaletteSteps+2),b,x
        sta $01D4,b
        lda <>(aMapMagicMjolnirPaletteSteps+4),b,x
        sta $01D6,b
        lda <>(aMapMagicMjolnirPaletteSteps+6),b,x
        sta $01D8,b
        rtl

        .databank 0

      aMapMagicMjolnirPaletteSteps ; 9F/BE52

        ; Part of the Mjolnir effect.
        .word $7400, $7C20, $7D40, $7DC0, $7E40, $7FC0
        .word $2C02, $4007, $5C0B, $6810, $7C17, $7C9F
        .word $7400, $7C20, $7D40, $7DC0, $7E40, $7FC0
        .word $2C02, $4007, $5C0B, $6810, $7C17, $7C9F
        .word $7400, $7C20, $7D40, $7DC0, $7E40, $7FC0
        .word $2C02, $4007, $5C0B, $6810, $7C17, $7C9F
        .word $7400, $7C20, $7D40, $7DC0, $7E40, $7FC0
        .word $2C02, $4007, $5C0B, $6810, $7C17, $7C9F

      rlMapMagicMjolnirStepScroll ; 9F/BEB2

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        lda aProcSystem.aBody2,b,x
        inc a
        cmp #$0004
        bpl _BEBF
        sta aProcSystem.aBody2,b,x
        rtl


        _BEBF
        stz aProcSystem.aBody2,b,x
        lda aProcSystem.aBody3,b,x
        inc a
        cmp #$0008
        bmi _BECE
        lda #$0000

        _BECE
        sta aProcSystem.aBody3,b,x
        asl a
        phx
        tax
        lda <>aMapMagicMjolnirScrollSteps,b,x
        sta $01DA,b
        lda <>(aMapMagicMjolnirScrollSteps+2),b,x
        sta $01DC,b
        lda <>(aMapMagicMjolnirScrollSteps+4),b,x
        sta $01DE,b
        plx
        rtl

        .databank 0

      aMapMagicMjolnirScrollSteps ; 9F/BEE8

        ; Part of the Mjolnir effect.
        .word $0000, $1800, $6000, $7D60, $7000, $3400, $1800, $0000
        .word $0000, $1800, $6000, $7D60, $7000, $3400, $1800, $0000

      aMapMagicMjolnirSpriteInfo ; 9F/BF08

        ; Part of the Mjolnir effect.
        .word <>rlMapMagicMjolnirSpriteInit, <>rlMapMagicMjolnirSpriteWaitEnd, <>aMapMagicMjolnirSpriteScript


      rlMapMagicMjolnirSpriteInit ; 9F/BF0E

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        lda #$0060
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $5D

        rtl

        .databank 0

      rlMapMagicMjolnirSpriteWaitEnd ; 9F/BF37

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _BF46
        lda #$0001
        sta $7ECC06
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _BF46
        rtl

        .databank 0

      aMapMagicMjolnirSpriteScript ; 9F/BF47

        ; Part of the Mjolnir effect.
        ACTIVE_SPRITE_FRAME 1, aMapMagicMjolnirFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicMjolnirWaitSpritePhase
        .word <>aMapMagicMjolnirSpriteScript

        _BF50
        ACTIVE_SPRITE_FRAME 3, aMapMagicMjolnirFrame01
        ACTIVE_SPRITE_FRAME 1, aMapMagicMjolnirFrameEmpty
        ACTIVE_SPRITE_FRAME 3, aMapMagicMjolnirFrame02
        ACTIVE_SPRITE_FRAME 1, aMapMagicMjolnirFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicMjolnirFrame03
        ACTIVE_SPRITE_FRAME 1, aMapMagicMjolnirFrameEmpty
        ACTIVE_SPRITE_JUMP _BF50

        ; 9F/BF6B

      rlMapMagicMjolnirWaitSpritePhase ; 9F/BF6B

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        lda $7ECC08
        bne _BF76
        lda $0000,b,y
        tay
        rtl


        _BF76
        inc y
        inc y
        rtl

        .databank 0

      aMapMagicMjolnirFrameEmpty ; 9F/BF79

        .word 0

      aMapMagicMjolnirFrame01 ; 9F/BF7B

        _Sprites := [[( -40,   -9), $21, SpriteLarge, $006, 2, 6, false, true]]
        _Sprites ..= [[(  -6,  -38), $21, SpriteLarge, $00C, 2, 6, false, true]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $002, 2, 6, false, false]]
        _Sprites ..= [[(  14,  -32), $21, SpriteLarge, $002, 2, 6, false, true]]
        _Sprites ..= [[(  22,   -8), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[( -32,  -32), $21, SpriteLarge, $004, 2, 6, true, true]]
        _Sprites ..= [[( -32,   16), $21, SpriteLarge, $004, 2, 6, true, false]]
        _Sprites ..= [[( -13,   25), $21, SpriteLarge, $00C, 2, 6, false, false]]

        .structSpriteArray aMapMagicMjolnirFrame01._Sprites

      aMapMagicMjolnirFrame02 ; 9F/BFA5

        _Sprites := [[( -14,   25), $21, SpriteLarge, $002, 2, 6, false, true]]
        _Sprites ..= [[(  22,  -11), $21, SpriteLarge, $006, 2, 6, false, true]]
        _Sprites ..= [[( -40,   -6), $21, SpriteLarge, $008, 2, 6, false, false]]
        _Sprites ..= [[( -32,   16), $21, SpriteLarge, $002, 2, 6, true, false]]
        _Sprites ..= [[(  14,  -32), $21, SpriteLarge, $000, 2, 6, false, true]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $000, 2, 6, false, false]]
        _Sprites ..= [[( -31,  -32), $21, SpriteLarge, $004, 2, 6, false, false]]
        _Sprites ..= [[(  -7,  -38), $21, SpriteLarge, $00A, 2, 6, false, true]]

        .structSpriteArray aMapMagicMjolnirFrame02._Sprites

      aMapMagicMjolnirFrame03 ; 9F/BFCF

        _Sprites := [[(  14,  -32), $21, SpriteLarge, $004, 2, 6, true, false]]
        _Sprites ..= [[(  22,   -8), $21, SpriteLarge, $008, 2, 6, true, false]]
        _Sprites ..= [[(  16,   16), $21, SpriteLarge, $004, 2, 6, false, false]]
        _Sprites ..= [[( -13,   25), $21, SpriteLarge, $00A, 2, 6, false, false]]
        _Sprites ..= [[( -32,   16), $21, SpriteLarge, $000, 2, 6, true, false]]
        _Sprites ..= [[( -40,   -6), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[( -32,  -32), $21, SpriteLarge, $002, 2, 6, true, true]]
        _Sprites ..= [[(  -7,  -38), $21, SpriteLarge, $00C, 2, 6, false, false]]

        .structSpriteArray aMapMagicMjolnirFrame03._Sprites


      rlStartMapMagicForseti ; 9F/BFF9

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicForseti

        rtl

        .databank 0

      procMapMagicForseti ; 9F/BFFF

        ; Part of the Forseti effect.
        .structProcInfo "ON", rlMapMagicForsetiInit, rlMapMagicForsetiDarkenAndSpawn, aProcMapMagicHaltCode


      rlMapMagicForsetiInit ; 9F/C007

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Forseti effect.

        jsr rsSaveMapMagicColors
        jsl rlMapMagicForsetiAdvancePaletteStep
        rtl

        .databank 0

      rlMapMagicForsetiDarkenAndSpawn ; 9F/C00F

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Forseti effect.

        jsr rsDarkenMapMagicColors
        bcc _C04F
        jsr rsSetMapMagicLayerBlending
        jsr rsCreateMapMagicProc

          .word <>procMapMagicForsetiWindow

        sta aProcSystem.aBody7,b,x
        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBF1

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aMapMagicForsetiSpawnParams

        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $65

        lda #<>rlMapMagicForsetiWaitCast
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0014
        sta aProcSystem.aBody0,b,x

        _C04F
        rtl

        .databank 0

      rlMapMagicForsetiWaitCast ; 9F/C050

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Forseti effect.

        dec aProcSystem.aBody0,b,x
        bne _C061
        lda #<>rlMapMagicForsetiWaitStrike
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0014
        sta aProcSystem.aBody0,b,x

        _C061
        rtl

        .databank 0

      rlMapMagicForsetiWaitStrike ; 9F/C062

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Forseti effect.

        dec aProcSystem.aBody0,b,x
        bne rlMapMagicForsetiWaitHold._C092
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicForsetiWaitHold
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0014
        sta aProcSystem.aBody0,b,x
        rtl

        .databank 0

      rlMapMagicForsetiWaitHold ; 9F/C07B

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Forseti effect.

        dec aProcSystem.aBody0,b,x
        bne _C092
        lda #<>rlMapMagicForsetiStepPaletteAnim
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0010
        sta aProcSystem.aBody0,b,x
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x

        _C092
        rtl

        .databank 0

      rlMapMagicForsetiStepPaletteAnim ; 9F/C093

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Forseti effect.

        jsl rlMapMagicForsetiAdvancePaletteStep
        bcc _C09F
        lda #<>rlMapMagicForsetiFadeBack
        sta aProcSystem.aHeaderOnCycle,b,x

        _C09F
        rtl

        .databank 0

      rlMapMagicForsetiFadeBack ; 9F/C0A0

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Forseti effect.

        jsr rsFadeBackMapMagicColors
        bcc rlMapMagicForsetiDone
        lda #<>rlMapMagicForsetiDone
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta wMapMagicDone

      rlMapMagicForsetiDone ; 9F/C0B2

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Forseti effect.

        rtl

        .databank 0

      rlMapMagicForsetiAdvancePaletteStep ; 9F/C0B3

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Forseti effect.

        lda #$0003
        sta aProcSystem.aBody2,b,x
        ldy aProcSystem.aBody3,b,x
        lda <>aMapMagicForsetiPaletteSteps,b,y
        cmp #$FFFF
        beq _C0FB
        phx
        tya
        clc
        adc #$000E
        sta aProcSystem.aBody3,b,x
        tyx
        lda <>aMapMagicForsetiPaletteSteps,b,x
        sta $01D2,b
        lda <>(aMapMagicForsetiPaletteSteps+2),b,x
        sta $01D4,b
        lda <>(aMapMagicForsetiPaletteSteps+4),b,x
        sta $01D6,b
        lda <>(aMapMagicForsetiPaletteSteps+6),b,x
        sta $01D8,b
        lda <>(aMapMagicForsetiPaletteSteps+8),b,x
        sta $01DA,b
        lda <>(aMapMagicForsetiPaletteSteps+10),b,x
        sta $01DC,b
        lda <>(aMapMagicForsetiPaletteSteps+12),b,x
        sta $01DE,b
        plx
        clc
        rtl


        _C0FB
        sec
        rtl

        .databank 0

      aMapMagicForsetiPaletteSteps ; 9F/C0FD

        ; Part of the Forseti effect.
        .word $4251, $360D, $21C7, $1984, $0942, $00C0, $0020
        .word $3E0F, $2DCB, $1D86, $1544, $0922, $00A0, $0020
        .word $35CD, $298A, $1965, $1123, $0501, $0080, $0020
        .word $2D8B, $2148, $1524, $1103, $04C1, $0080, $0000
        .word $2549, $1D27, $1104, $0CC2, $04A1, $0060, $0000
        .word $1D07, $14E5, $0CC3, $08A2, $0481, $0040, $0000
        .word $14C5, $10A4, $0882, $0881, $0060, $0040, $0000
        .word $0C83, $0C63, $0461, $0441, $0040, $0020, $0000
        .word $0442, $0421, $0420, $0020, $0020, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $FFFF

      rlStartMapMagicNosferatu ; 9F/C18B

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicNosferatu

        rtl

        .databank 0

      procMapMagicNosferatu ; 9F/C191

        ; Part of the Nosferatu effect.
        .structProcInfo "ON", rlMapMagicNosferatuInit, rlMapMagicNosferatuSpawnEffects, aProcMapMagicNosferatuCode


      rlMapMagicNosferatuInit ; 9F/C199

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        jsr rsSetMapMagicLayerBlending
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C
        rtl

        .databank 0

      rlMapMagicNosferatuSpawnEffects ; 9F/C1B0

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        jsr rsCreateMapMagicProc

          .word <>procMapMagicNosferatuOrb

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC34

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC77

        lda #<>rlMapMagicNosferatuWaitStrike
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0060
        sta aProcSystem.aBody0,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $67

        lda #(`aMapMagicNosferatuSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicNosferatuSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        rtl

        .databank 0

      rlMapMagicNosferatuWaitStrike ; 9F/C1F4

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        dec aProcSystem.aBody0,b,x
        bne _C20C
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicNosferatuWaitEnd
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$00A0
        sta aProcSystem.aBody0,b,x

        _C20C
        rtl

        .databank 0

      rlMapMagicNosferatuWaitEnd ; 9F/C20D

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        dec aProcSystem.aBody0,b,x
        bne _C219
        lda #$0001
        sta $7ECC0C

        _C219
        rtl

        .databank 0

      rlMapMagicNosferatuOrbInit ; 9F/C21A

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        jsr rsClearMapMagicProcBody
        lda wMapMagicTargetPixel
        and #$00FF
        xba
        sta aProcSystem.aBody3,b,x
        lda wMapMagicTargetPixel
        and #$FF00
        sta aProcSystem.aBody4,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sta wR0
        lda wMapMagicCasterPixel
        and #$00FF
        sec
        sbc wR0
        sta wR0
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta wR1
        lda wMapMagicCasterPixel+1
        and #$00FF
        sec
        sbc wR1
        sta wR1
        jsl rlGetVectorLength
        sta aProcSystem.aBody1,b,x
        lda #$0100
        jsl rlMultiplyByNegSin._8B84
        ldx aProcSystem.wOffset,b
        sta aProcSystem.aBody5,b,x
        lda #$0100
        jsl rlMultiplyByNegSin
        ldx aProcSystem.wOffset,b
        sta aProcSystem.aBody6,b,x
        rtl

        .databank 0

      rlMapMagicNosferatuOrbGrow ; 9F/C27E

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        lda aProcSystem.aBody2,b,x
        clc
        adc #$0001
        cmp #$0012
        bcc _C2A0
        lda #<>rlMapMagicNosferatuOrbHoldTarget
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0040
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC0A
        lda #$0012

        _C2A0
        sta aProcSystem.aBody2,b,x
        jsr rsMapMagicNosferatuUpdateOrbHDMA
        rtl

        .databank 0

      rlMapMagicNosferatuOrbHoldTarget ; 9F/C2A7

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        dec aProcSystem.aBody0,b,x
        bne _C2BF
        lda #<>rlMapMagicNosferatuOrbPauseMove
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0004
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC0A

        _C2BF
        rtl

        .databank 0

      rlMapMagicNosferatuOrbPauseMove ; 9F/C2C0

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        dec aProcSystem.aBody0,b,x
        bne _C2D1
        lda #<>rlMapMagicNosferatuOrbMoveToCaster
        sta aProcSystem.aHeaderOnCycle,b,x
        lda aProcSystem.aBody1,b,x
        sta aProcSystem.aBody0,b,x

        _C2D1
        rtl

        .databank 0

      rlMapMagicNosferatuOrbMoveToCaster ; 9F/C2D2

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        jsr rsMapMagicNosferatuStepOrbCoords
        lda aProcSystem.aBody2,b,x
        jsr rsMapMagicNosferatuUpdateOrbHDMA
        dec aProcSystem.aBody0,b,x
        bne _C2F3
        lda #<>rlMapMagicNosferatuOrbPauseCaster
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0004
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC06

        _C2F3
        rtl

        .databank 0

      rlMapMagicNosferatuOrbPauseCaster ; 9F/C2F4

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        dec aProcSystem.aBody0,b,x
        bne _C30C
        lda #<>rlMapMagicNosferatuOrbHoldCaster
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0040
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC0A

        _C30C
        rtl

        .databank 0

      rlMapMagicNosferatuOrbHoldCaster ; 9F/C30D

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        dec aProcSystem.aBody0,b,x
        bne _C31F
        lda #<>rlMapMagicNosferatuOrbShrink
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta $7ECC0A

        _C31F
        rtl

        .databank 0

      rlMapMagicNosferatuOrbShrink ; 9F/C320

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        lda aProcSystem.aBody2,b,x
        sec
        sbc #$0001
        cmp #$0001
        bpl _C338
        jsr rsFreeMapMagicHDMA
        lda #<>rlMapMagicNosferatuOrbDone
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001

        _C338
        sta aProcSystem.aBody2,b,x
        jsr rsMapMagicNosferatuUpdateOrbHDMA

      rlMapMagicNosferatuOrbDone ; 9F/C33E

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        rtl

        .databank 0

      rsMapMagicNosferatuUpdateOrbHDMA ; 9F/C33F

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        sta $7F50E3
        asl a
        sta $7F50E5
        lda $1038,b,x
        and #$00FF
        sta $7F50DF
        sec
        sbc #$0080
        eor #$FFFF
        inc a
        sta $7F50CD
        lda $1058,b,x
        and #$00FF
        sta $7F50E1
        lda $1058,b,x
        and #$00FF
        sec
        sbc #$0070
        eor #$FFFF
        inc a
        sta $7F50CF
        phx
        phy
        lda #$7F00
        sta lR18+1
        lda #$50EA
        sta lR18
        ldx #$0000
        lda #$00E0
        jsl rlMapMagicBuildCircleWindowHDMA
        ply
        plx
        rts

        .databank 0

      rsMapMagicNosferatuStepOrbCoords ; 9F/C393

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        lda aProcSystem.aBody5,b,x
        clc
        adc aProcSystem.aBody3,b,x
        sta aProcSystem.aBody3,b,x
        lda aProcSystem.aBody6,b,x
        adc aProcSystem.aBody4,b,x
        sta aProcSystem.aBody4,b,x
        rts

        .databank 0

      aMapMagicNosferatuSpriteInfo ; 9F/C3A7

        ; Part of the Nosferatu effect.
        .word <>rlMapMagicNosferatuSpriteInit, <>rlMapMagicNosferatuSpriteAtTarget, <>aMapMagicNosferatuSpriteScript


      rlMapMagicNosferatuSpriteInit ; 9F/C3AD

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicCasterPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicCasterPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        rtl

        .databank 0

      rlMapMagicNosferatuSpriteAtTarget ; 9F/C3C9

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        jsr rsMapMagicNosferatuCycleSpritePal
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        lda $7ECC06
        beq _C3EC
        lda #<>rlMapMagicNosferatuSpriteAtCaster
        sta aActiveSpriteSystem.aOnCycle,b,x

        _C3EC
        rtl

        .databank 0

      rlMapMagicNosferatuSpriteAtCaster ; 9F/C3ED

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        jsr rsMapMagicNosferatuCycleSpritePal
        lda wMapMagicCasterPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicCasterPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        lda $7ECC0C
        beq _C414
        stz aActiveSpriteSystem.aTypeOffset,b,x
        lda #$0001
        sta wMapMagicDone

        _C414
        rtl

        .databank 0

      rsMapMagicNosferatuCycleSpritePal ; 9F/C415

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        phx
        inc aActiveSpriteSystem.aUnknown001300,b,x
        lda aActiveSpriteSystem.aUnknown001300,b,x
        and #$001F
        asl a
        tay
        lda #$000F
        sta wR0
        ldx #$0000

        _C429
        lda <>aMapMagicNosferatuSpritePalettes,b,y
        sta $02C2,b,x
        inc y
        inc y
        inc x
        inc x
        dec wR0
        bne _C429
        plx
        rts

        .databank 0

      aMapMagicNosferatuSpritePalettes ; 9F/C439

        ; Part of the Nosferatu effect.
        .word $2550, $39F3, $4E97, $5F3B, $73DF, $01D8, $0619, $063A
        .word $0A7B, $0EBC, $12FD, $131E, $175F, $00AC, $00EE, $052F
        .word $0571, $09B2, $0A35, $0E97, $131A, $17DF, $0C89, $190C
        .word $298F, $3612, $4276, $4EF9, $5F7C, $6BFF, $0008, $14AC
        .word $2550, $39F3, $4E97, $5F3B, $73DF, $01D8, $0619, $063A
        .word $0A7B, $0EBC, $12FD, $131E, $175F, $00AC, $00EE, $052F

      aMapMagicNosferatuSpriteScript ; 9F/C499

        ; Part of the Nosferatu effect.
        ACTIVE_SPRITE_FRAME 1, aMapMagicNosferatuFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicNosferatuWaitSpritePhase
        .word <>aMapMagicNosferatuSpriteScript

        _C4A2
        ACTIVE_SPRITE_FRAME 1, aMapMagicNosferatuFrame02
        ACTIVE_SPRITE_CALL rlMapMagicNosferatuWaitSpritePhase
        .word <>_C4A2

        _C4AB
        ACTIVE_SPRITE_FRAME 1, aMapMagicNosferatuFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicNosferatuWaitSpritePhase
        .word <>_C4AB

        _C4B4
        ACTIVE_SPRITE_FRAME 1, aMapMagicNosferatuFrame01
        ACTIVE_SPRITE_CALL rlMapMagicNosferatuWaitSpritePhase
        .word <>_C4B4

        _C4BD
        ACTIVE_SPRITE_FRAME 1, aMapMagicNosferatuFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicNosferatuWaitSpritePhase
        .word <>_C4BD
        ACTIVE_SPRITE_JUMP aMapMagicNosferatuSpriteScript

        ; 9F/C4C9

      rlMapMagicNosferatuWaitSpritePhase ; 9F/C4C9

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        lda $7ECC0A
        beq _C4D9
        lda #$0000
        sta $7ECC0A
        inc y
        inc y
        rtl


        _C4D9
        lda $0000,b,y
        tay
        rtl

        .databank 0

      aMapMagicNosferatuFrameEmpty ; 9F/C4DE

        .word 0

      aMapMagicNosferatuFrame01 ; 9F/C4E0

        _Sprites := [[(   0,    2), $21, SpriteLarge, $000, 3, 6, true, true]]
        _Sprites ..= [[(   0,  -14), $21, SpriteLarge, $000, 3, 6, true, false]]
        _Sprites ..= [[( -16,    2), $21, SpriteLarge, $000, 3, 6, false, true]]
        _Sprites ..= [[( -16,  -14), $21, SpriteLarge, $000, 3, 6, false, false]]

        .structSpriteArray aMapMagicNosferatuFrame01._Sprites

      aMapMagicNosferatuFrame02 ; 9F/C4F6

        _Sprites := [[(   0,    2), $21, SpriteLarge, $002, 3, 6, true, true]]
        _Sprites ..= [[( -16,    2), $21, SpriteLarge, $002, 3, 6, false, true]]
        _Sprites ..= [[(   0,  -14), $21, SpriteLarge, $002, 3, 6, true, false]]
        _Sprites ..= [[( -16,  -14), $21, SpriteLarge, $002, 3, 6, false, false]]

        .structSpriteArray aMapMagicNosferatuFrame02._Sprites


      aProcMapMagicNosferatuCode ; 9F/C50C

        ; Part of the Nosferatu effect.
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicNosferatuLoadPaletteStep, 1
        .byte $00
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicNosferatuLoadPaletteStep, 1
        .byte $01
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicNosferatuLoadPaletteStep, 1
        .byte $02
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicNosferatuLoadPaletteStep, 1
        .byte $03
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicNosferatuLoadPaletteStep, 1
        .byte $04
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicNosferatuLoadPaletteStep, 1
        .byte $05
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicNosferatuLoadPaletteStep, 1
        .byte $06
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicNosferatuLoadPaletteStep, 1
        .byte $07
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicNosferatuLoadPaletteStep, 1
        .byte $08
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicNosferatuLoadPaletteStep, 1
        .byte $09
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicNosferatuLoadPaletteStep, 1
        .byte $0A
        PROC_YIELD 2
        PROC_CALL_ARGS rlMapMagicNosferatuLoadPaletteStep, 1
        .byte $0B
        PROC_JUMP aProcMapMagicNosferatuCode


      rlMapMagicNosferatuLoadPaletteStep ; 9F/C57C

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Nosferatu effect.

        lda $0000,b,y
        and #$00FF
        asl a
        tax
        lda <>aMapMagicNosferatuPaletteSteps,b,x
        sta $01D2,b
        lda <>(aMapMagicNosferatuPaletteSteps+2),b,x
        sta $01D4,b
        lda <>(aMapMagicNosferatuPaletteSteps+4),b,x
        sta $01D6,b
        lda <>(aMapMagicNosferatuPaletteSteps+6),b,x
        sta $01D8,b
        lda <>(aMapMagicNosferatuPaletteSteps+8),b,x
        sta $01DA,b
        lda <>(aMapMagicNosferatuPaletteSteps+10),b,x
        sta $01DC,b
        lda <>(aMapMagicNosferatuPaletteSteps+12),b,x
        sta $01DE,b
        rtl

        .databank 0

      aMapMagicNosferatuPaletteSteps ; 9F/C5AF

        ; Part of the Nosferatu effect.
        .word $001D, $0016, $0013, $0012, $000D, $001D, $0016, $0013
        .word $0012, $000D, $001D, $0016, $0013, $0012, $000D, $001D
        .word $0016, $0013, $0012, $000D, $001D, $0016, $0013, $0012
        .word $000D, $001D, $0016, $0013, $0012, $000D, $001D, $0016
        .word $0013, $0012, $000D, $001D, $0016, $0013, $0012, $000D
        .word $001D, $0016, $0013, $0012, $000D, $001D, $0016, $0013

      rlStartMapMagicSilence ; 9F/C60F

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicSilence

        rtl

        .databank 0

      procMapMagicSilence ; 9F/C615

        ; Part of the Silence effect.
        .structProcInfo "ON", rlMapMagicSilenceInit, rlMapMagicSilenceDarken, aProcMapMagicSilenceCode


      aProcMapMagicSilenceCode ; 9F/C61D

        ; Part of the Silence effect.
        PROC_YIELD 1
        PROC_CALL rlMapMagicSilenceStepPaletteAnim
        PROC_JUMP aProcMapMagicSilenceCode


      rlMapMagicSilenceInit ; 9F/C628

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Silence effect.

        jsr rsSetMapMagicLayerBlending
        jsr rsSaveMapMagicColors
        rtl

        .databank 0

      rlMapMagicSilenceDarken ; 9F/C62F

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Silence effect.

        jsr rsDarkenMapMagicColors
        bcc _C64B
        lda #<>rlMapMagicSilenceWaitAndSpawn
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$000C
        sta aProcSystem.aBody0,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $79


        _C64B
        rtl

        .databank 0

      rlMapMagicSilenceWaitAndSpawn ; 9F/C64C

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Silence effect.

        dec aProcSystem.aBody0,b,x
        bne _C67E
        jsr rsCreateMapMagicProc

          .word <>procMapMagicSilenceWindow

        sta aProcSystem.aBody7,b,x
        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC34

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC77

        lda #<>rlMapMagicSilenceWaitStrike
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x

        _C67E
        rtl

        .databank 0

      rlMapMagicSilenceWaitStrike ; 9F/C67F

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Silence effect.

        dec aProcSystem.aBody0,b,x
        bne _C697
        lda #<>rlMapMagicSilenceWaitHold
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0030
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal

        _C697
        rtl

        .databank 0

      rlMapMagicSilenceWaitHold ; 9F/C698

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Silence effect.

        ; WARNING: a branch or jump leads into the middle of an instruction at $9FC69C
        dec aProcSystem.aBody0,b,x
        bne _C6B2
        ldy aProcSystem.aBody7,b,x
        lda #$FFFD
        sta aProcSystem.aBody4,b,y
        lda #<>rlMapMagicSilenceWaitFreeHDMA
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0010
        sta aProcSystem.aBody0,b,x

        _C6B2
        rtl

        .databank 0

      rlMapMagicSilenceWaitFreeHDMA ; 9F/C6B3

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Silence effect.

        dec aProcSystem.aBody0,b,x
        bne _C6C1
        lda #<>rlMapMagicSilenceFadeBack
        sta aProcSystem.aHeaderOnCycle,b,x
        jsr rsFreeMapMagicHDMA

        _C6C1
        rtl

        .databank 0

      rlMapMagicSilenceFadeBack ; 9F/C6C2

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Silence effect.

        jsr rsFadeBackMapMagicColors
        bcc rlMapMagicSilenceDone
        lda #<>rlMapMagicSilenceDone
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta wMapMagicDone

      rlMapMagicSilenceDone ; 9F/C6D4

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Silence effect.

        rtl

        .databank 0

      rlMapMagicSilenceStepBeamHDMA ; 9F/C6D5

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Silence effect.

        dec aProcSystem.aBody1,b,x
        beq _C6DE
        jml _C79F


        _C6DE
        lda aProcSystem.aHeaderTypeOffset,b,x
        tax
        lda $000B,b,x
        sta wR0
        lda $000D,b,x
        sta wR1
        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody0,b,x
        sta aProcSystem.aBody1,b,x
        lda aProcSystem.aBody2,b,x
        clc
        adc aProcSystem.aBody4,b,x
        sta aProcSystem.aBody2,b,x
        cmp #$0001
        bpl _C70A
        lda #$0001
        sta aProcSystem.aBody2,b,x

        _C70A
        cmp aProcSystem.aBody3,b,x
        bmi _C715
        lda aProcSystem.aBody3,b,x
        sta aProcSystem.aBody2,b,x

        _C715
        lda wMapMagicTargetPixel
        and #$00FF
        clc
        adc wR0
        sta $7F50DF
        lda aProcSystem.aBody7,b,x
        inc aProcSystem.aBody7,b,x
        and #$000C
        lsr a
        tay
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc <>aMapMagicSilenceBeamHDMASteps,b,y
        eor #$FFFF
        inc a
        sta $7F50CD
        lda wMapMagicTargetPixel+1
        and #$00FF
        clc
        adc #$0004
        clc
        adc wR1
        sta $7F50E1
        lda wMapMagicTargetPixel+1
        and #$00FF
        clc
        adc #$0004
        sec
        sbc #$0070
        eor #$FFFF
        inc a
        sta $7F50CF
        lda aProcSystem.aBody5,b,x
        bne _C77D
        lda aProcSystem.aBody2,b,x
        sta $7F50E3
        asl a
        sta $7F50E5
        bra _C789


        _C77D
        lda aProcSystem.aBody2,b,x
        sta $7F50E3
        inc a
        sta $7F50E5

        _C789
        phy
        lda #$7F00
        sta lR18+1
        lda #$50EA
        sta lR18
        ldx #$0000
        lda #$00E0
        jsl rlMapMagicBuildCircleWindowHDMA
        ply

        _C79F
        rtl

        .databank 0

      aMapMagicSilenceBeamHDMASteps ; 9F/C7A0

        ; Part of the Silence effect.
        .word $0080, $00B0, $00E0, $0050

      rlMapMagicSilenceStepPaletteAnim ; 9F/C7A8

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Silence effect.

        phx
        lda aProcSystem.aBody2,b
        inc aProcSystem.aBody2,b
        and #$001F
        asl a
        tax
        lda <>aMapMagicSilencePaletteAnim,b,x
        sta $01D2,b
        lda <>(aMapMagicSilencePaletteAnim+2),b,x
        sta $01D4,b
        lda <>(aMapMagicSilencePaletteAnim+4),b,x
        sta $01D6,b
        lda <>(aMapMagicSilencePaletteAnim+6),b,x
        sta $01D8,b
        lda <>(aMapMagicSilencePaletteAnim+8),b,x
        sta $01DA,b
        lda <>(aMapMagicSilencePaletteAnim+10),b,x
        sta $01DC,b
        lda <>(aMapMagicSilencePaletteAnim+12),b,x
        sta $01DE,b
        plx
        rtl

        .databank 0

      aMapMagicSilencePaletteAnim ; 9F/C7E0

        ; Part of the Silence effect.
        .word $7D40, $7520, $7120, $6900, $64E0, $5CE0, $58C0, $50A0
        .word $4CA0, $4480, $4060, $3860, $3440, $2C20, $2820, $2000
        .word $2000, $2820, $2C20, $3440, $3860, $4060, $4480, $4CA0
        .word $50A0, $58C0, $5CE0, $64E0, $6900, $7120, $7520, $7D40
        .word $7D40, $7520, $7120, $6900, $64E0, $5CE0, $58C0, $50A0
        .word $4CA0, $4480, $4060, $3860, $3440, $2C20, $2820, $2000

      rlStartMapMagicTornado ; 9F/C840

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicTornado

        rtl

        .databank 0

      procMapMagicTornado ; 9F/C846

        ; Part of the Tornado effect.
        .structProcInfo "ON", rlMapMagicTornadoInit, rlMapMagicTornadoFadeAndSpawn, aProcMapMagicHaltCode


      rlMapMagicTornadoInit ; 9F/C84E

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Tornado effect.

        jsr rsSaveMapMagicColors
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C
        rtl

        .databank 0

      rlMapMagicTornadoFadeAndSpawn ; 9F/C865

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Tornado effect.

        lda #$0007
        ldy #$0014
        sta aPaletteFading.wDesiredColor,b
        tya
        sta aPaletteFading,b
        sec
        jsr rsFadeMapMagicColorRangesRG
        bcc _C88E
        lda #<>rlMapMagicTornadoWaitImpact
        sta aProcSystem.aHeaderOnCycle,b,x
        phx
        lda #(`aMapMagicTornadoSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicTornadoSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        plx

        _C88E
        rtl

        .databank 0

      rlMapMagicTornadoWaitImpact ; 9F/C88F

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Tornado effect.

        lda $7ECC06
        beq _C8A1
        lda #<>rlMapMagicTornadoWaitFade
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0010
        sta aProcSystem.aBody0,b,x

        _C8A1
        rtl

        .databank 0

      rlMapMagicTornadoWaitFade ; 9F/C8A2

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Tornado effect.

        dec aProcSystem.aBody0,b,x
        bne _C8AD
        lda #<>rlMapMagicTornadoFadeBack
        sta aProcSystem.aHeaderOnCycle,b,x

        _C8AD
        rtl

        .databank 0

      rlMapMagicTornadoFadeBack ; 9F/C8AE

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Tornado effect.

        jsr rsFadeBackMapMagicColors
        bcc rlMapMagicTornadoDone
        lda #<>rlMapMagicTornadoDone
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta wMapMagicDone

      rlMapMagicTornadoDone ; 9F/C8C0

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Tornado effect.

        rtl

        .databank 0

      aMapMagicTornadoSpriteInfo ; 9F/C8C1

        ; Part of the Tornado effect.
        .word <>rlMapMagicTornadoSpriteInit, <>rlMapMagicTornadoSpriteAim, <>aMapMagicTornadoSpriteScript


      rlMapMagicTornadoSpriteInit ; 9F/C8C7

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Tornado effect.

        ; WARNING: a branch or jump leads into the middle of an instruction at $9FC8CC
        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicCasterPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $63

        lda wMapMagicCasterPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        lda #$0030
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        jml rlMapMagicTornadoStepSpritePal

        .databank 0

      rlMapMagicTornadoSpriteAim ; 9F/C8F0

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Tornado effect.

        jsl rlMapMagicTornadoStepSpritePal
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _C933
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aXPosition,b,x
        sta wR0
        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aYPosition,b,x
        sta wR1
        jsl rlGetVectorLength
        bne _C91C
        lda #$0008

        _C91C
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda wR0
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda #$0100
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsMapMagicCalcSpriteVelocityFromAngle
        lda #<>rlMapMagicTornadoSpriteFlyToTarget
        sta aActiveSpriteSystem.aOnCycle,b,x

        _C933
        rtl

        .databank 0

      rlMapMagicTornadoSpriteFlyToTarget ; 9F/C934

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Tornado effect.

        jsl rlMapMagicTornadoStepSpritePal
        jsl rlMoveActiveSpriteByVelocity
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _C954
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #$0020
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlMapMagicTornadoSpriteEnd
        sta aActiveSpriteSystem.aOnCycle,b,x

        _C954
        rtl

        .databank 0

      rlMapMagicTornadoSpriteEnd ; 9F/C955

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Tornado effect.

        jsl rlMapMagicTornadoStepSpritePal
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _C968
        lda #$0001
        sta $7ECC06
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _C968
        rtl

        .databank 0

      aMapMagicTornadoSpriteScript ; 9F/C969

        ; Part of the Tornado effect.

        ACTIVE_SPRITE_FRAME 3, aMapMagicTornadoFrame01
        ACTIVE_SPRITE_FRAME 3, aMapMagicTornadoFrame03
        ACTIVE_SPRITE_FRAME 3, aMapMagicTornadoFrame02
        ACTIVE_SPRITE_FRAME 3, aMapMagicTornadoFrame04
        ACTIVE_SPRITE_JUMP aMapMagicTornadoSpriteScript

      aMapMagicTornadoFrame01 ; 9F/C97C

        _Sprites := [[(  -1,  -72), $21, SpriteLarge, $00C, 2, 6, true, false]]
        _Sprites ..= [[(  -3,  -56), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[(  -4,  -40), $21, SpriteLarge, $004, 2, 6, false, false]]
        _Sprites ..= [[(  -6,  -24), $21, SpriteLarge, $002, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aMapMagicTornadoFrame01._Sprites

      aMapMagicTornadoFrame02 ; 9F/C997

        _Sprites := [[(   1,  -72), $21, SpriteLarge, $00C, 2, 6, false, false]]
        _Sprites ..= [[(  -3,  -56), $21, SpriteLarge, $004, 2, 6, false, false]]
        _Sprites ..= [[(  -5,  -40), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[(  -9,  -24), $21, SpriteLarge, $008, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aMapMagicTornadoFrame02._Sprites

      aMapMagicTornadoFrame03 ; 9F/C9B2

        _Sprites := [[(  -6,  -72), $21, SpriteLarge, $00C, 2, 6, true, false]]
        _Sprites ..= [[(  -8,  -56), $21, SpriteLarge, $006, 2, 6, false, false]]
        _Sprites ..= [[(  -7,  -40), $21, SpriteLarge, $004, 2, 6, true, false]]
        _Sprites ..= [[(  -8,  -24), $21, SpriteLarge, $002, 2, 6, true, false]]
        _Sprites ..= [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aMapMagicTornadoFrame03._Sprites

      aMapMagicTornadoFrame04 ; 9F/C9CD

        _Sprites := [[(  -7,  -72), $21, SpriteLarge, $00C, 2, 6, false, false]]
        _Sprites ..= [[( -10,  -56), $21, SpriteLarge, $004, 2, 6, false, true]]
        _Sprites ..= [[(  -7,  -40), $21, SpriteLarge, $006, 2, 6, true, false]]
        _Sprites ..= [[(  -9,  -24), $21, SpriteLarge, $008, 2, 6, false, false]]
        _Sprites ..= [[(  -7,   -8), $21, SpriteLarge, $00A, 2, 6, true, false]]

        .structSpriteArray aMapMagicTornadoFrame04._Sprites


      rlMapMagicTornadoStepSpritePal ; 9F/C9E8

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Tornado effect.

        lda aActiveSpriteSystem.aUnknown001360,b,x
        beq _C9F2

        _C9ED
        dec a
        sta aActiveSpriteSystem.aUnknown001360,b,x
        rtl


        _C9F2
        lda #$0002
        sta aActiveSpriteSystem.aUnknown001360,b,x
        phx
        lda aActiveSpriteSystem.aUnknown001380,b,x
        inc a
        and #$000F
        sta aActiveSpriteSystem.aUnknown001380,b,x
        asl a
        tax
        lda <>aMapMagicTornadoSpritePalettes,b,x
        sta $02CE,b
        lda <>(aMapMagicTornadoSpritePalettes+2),b,x
        sta $02D0,b
        lda <>(aMapMagicTornadoSpritePalettes+4),b,x
        sta $02D2,b
        lda <>(aMapMagicTornadoSpritePalettes+6),b,x
        sta $02D4,b
        plx
        rtl

        .databank 0

      aMapMagicTornadoSpritePalettes ; 9F/CA1F

        ; Part of the Tornado effect.
        .word $7F9F, $62B8, $45D1, $24E9, $1445, $24E9, $45D1, $62B8
        .word $7F9F, $62B8, $45D1, $45D1, $24E9, $1445, $24E9, $45D1
        .word $7F9F, $62B8, $45D1, $24E9, $1445, $24E9, $45D1, $62B8
        .word $7F9F, $62B8, $45D1, $45D1, $24E9, $1445, $24E9, $45D1

      rlStartMapMagicWind ; 9F/CA5F

        .al
        .xl
        .autsiz
        .databank ?

        ; Also Elwind.

        lda #(`aMapMagicWindSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicWindSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        rtl

        .databank 0

      rsMapMagicWindSpawnTrail ; 9F/CA6E

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Wind effect.

        phx
        phy
        lda aActiveSpriteSystem.aYPosition,b,x
        tay
        lda aActiveSpriteSystem.aXPosition,b,x
        tax
        lda #(`aMapMagicElwindSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicElwindSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        ply
        plx
        rts

        .databank 0

      aMapMagicWindSpriteInfo ; 9F/CA89

        ; Part of the Wind effect.
        .word <>rlMapMagicWindInit, <>rlMapMagicWindAim, <>aMapMagicWindSpriteScript


      aMapMagicElwindSpriteInfo ; 9F/CA8F

        ; Part of the Wind effect.
        .word <>rlMapMagicElwindInit, <>rlMapMagicElwindEnd, <>aMapMagicWindSpriteScript


      aMapMagicWindSpriteScript ; 9F/CA95

        ; Part of the Wind effect.
        .word $0000

      rlMapMagicWindInit ; 9F/CA97

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Wind effect.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicCasterPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicCasterPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda $7F50C9
        asl a
        tay
        lda <>aMapMagicWindSpriteScripts,b,y
        sta aActiveSpriteSystem.aCodeOffset,b,x
        lda wMapMagicEffect
        cmp #$000B
        beq _CAD5
        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $61

        rtl


        _CAD5
        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $62

        rtl

        .databank 0

      rlMapMagicElwindInit ; 9F/CADD

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Wind effect.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda $7F50C9
        asl a
        tay
        lda <>(aMapMagicWindSpriteScripts+16),b,y
        sta aActiveSpriteSystem.aCodeOffset,b,x
        rtl

        .databank 0

      rlMapMagicElwindEnd ; 9F/CAF7

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Wind effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _CAFF
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _CAFF
        rtl

        .databank 0

      rlMapMagicWindAim ; 9F/CB00

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Wind effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _CB41
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aXPosition,b,x
        sta wR0
        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aYPosition,b,x
        sta wR1
        jsl rlGetVectorLength
        lsr a
        lsr a
        bne _CB2A
        lda #$0002

        _CB2A
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda wR0
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda #$0400
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsMapMagicCalcSpriteVelocityFromAngle
        lda #<>rlMapMagicWindFlyToTarget
        sta aActiveSpriteSystem.aOnCycle,b,x

        _CB41
        rtl

        .databank 0

      rlMapMagicWindFlyToTarget ; 9F/CB42

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Wind effect.

        lda wMapMagicEffect
        cmp #$000B
        bne _CB4E
        jsr rsMapMagicWindSpawnTrail

        _CB4E
        jsl rlMoveActiveSpriteByVelocity
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicWindAim._CB41
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0020
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlMapMagicWindDissipate
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

      rlMapMagicWindDissipate ; 9F/CB6E

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Wind effect.

        lda aActiveSpriteSystem.aUnknown001300,b,x
        sec
        sbc #$00C0
        bcs _CB7A
        lda #$0000

        _CB7A
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsMapMagicCalcSpriteVelocityFromAngle
        jsl rlMoveActiveSpriteByVelocity
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicWindAim._CB41
        lda #$0010
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlMapMagicWindWaitEnd
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

      rlMapMagicWindWaitEnd ; 9F/CB96

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Wind effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicWindAim._CB41
        lda #$0001
        sta wMapMagicDone
        stz aActiveSpriteSystem.aTypeOffset,b,x
        rtl

        .databank 0

      aMapMagicWindSpriteScripts ; 9F/CBA6

        ; Part of the Wind effect.
        .word <>aMapMagicWindSpriteScript7, <>aMapMagicWindSpriteScript3, <>aMapMagicWindSpriteScript9, <>aMapMagicWindSpriteScript5, <>aMapMagicWindSpriteScript6, <>aMapMagicWindSpriteScript4, <>aMapMagicWindSpriteScript8, <>aMapMagicWindSpriteScript2
        .word <>aMapMagicWindSpriteScript7._CC19, <>aMapMagicWindSpriteScript3._CBDD, <>aMapMagicWindSpriteScript9._CC37, <>aMapMagicWindSpriteScript5._CBFB, <>aMapMagicWindSpriteScript6._CC0A, <>aMapMagicWindSpriteScript4._CBEC, <>aMapMagicWindSpriteScript8._CC28, <>aMapMagicWindSpriteScript2._CBCE

      aMapMagicWindSpriteScript2 ; 9F/CBC6

        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame01
        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame02

        _CBCE
        ACTIVE_SPRITE_FRAME 1, aMapMagicWindFrame03
        ACTIVE_SPRITE_JUMP _CBCE

      aMapMagicWindSpriteScript3 ; 9F/CBD5

        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame04
        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame05

        _CBDD
        ACTIVE_SPRITE_FRAME 1, aMapMagicWindFrame06
        ACTIVE_SPRITE_JUMP _CBDD

      aMapMagicWindSpriteScript4 ; 9F/CBE4

        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame07
        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame08

        _CBEC
        ACTIVE_SPRITE_FRAME 1, aMapMagicWindFrame09
        ACTIVE_SPRITE_JUMP _CBEC

      aMapMagicWindSpriteScript5 ; 9F/CBF3

        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame10
        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame11

        _CBFB
        ACTIVE_SPRITE_FRAME 1, aMapMagicWindFrame12
        ACTIVE_SPRITE_JUMP _CBFB

      aMapMagicWindSpriteScript6 ; 9F/CC02

        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame13
        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame14

        _CC0A
        ACTIVE_SPRITE_FRAME 1, aMapMagicWindFrame15
        ACTIVE_SPRITE_JUMP _CC0A

      aMapMagicWindSpriteScript7 ; 9F/CC11

        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame16
        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame17

        _CC19
        ACTIVE_SPRITE_FRAME 1, aMapMagicWindFrame18
        ACTIVE_SPRITE_JUMP _CC19

      aMapMagicWindSpriteScript8 ; 9F/CC20

        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame19
        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame20

        _CC28
        ACTIVE_SPRITE_FRAME 1, aMapMagicWindFrame21
        ACTIVE_SPRITE_JUMP _CC28

      aMapMagicWindSpriteScript9 ; 9F/CC2F

        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame22
        ACTIVE_SPRITE_FRAME 2, aMapMagicWindFrame23

        _CC37
        ACTIVE_SPRITE_FRAME 1, aMapMagicWindFrame24
        ACTIVE_SPRITE_JUMP _CC37

      aMapMagicWindFrameEmptyUnused ; 9F/CC3E

        .word 0

      aMapMagicWindFrame01 ; 9F/CC40

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aMapMagicWindFrame01._Sprites

      aMapMagicWindFrame02 ; 9F/CC47

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00C, 2, 6, false, false]]

        .structSpriteArray aMapMagicWindFrame02._Sprites

      aMapMagicWindFrame03 ; 9F/CC4E

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aMapMagicWindFrame03._Sprites

      aMapMagicWindFrame04 ; 9F/CC55

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, true]]

        .structSpriteArray aMapMagicWindFrame04._Sprites

      aMapMagicWindFrame05 ; 9F/CC5C

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00C, 2, 6, false, true]]

        .structSpriteArray aMapMagicWindFrame05._Sprites

      aMapMagicWindFrame06 ; 9F/CC63

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, true]]

        .structSpriteArray aMapMagicWindFrame06._Sprites

      aMapMagicWindFrame07 ; 9F/CC6A

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, true, false]]

        .structSpriteArray aMapMagicWindFrame07._Sprites

      aMapMagicWindFrame08 ; 9F/CC71

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00C, 2, 6, true, false]]

        .structSpriteArray aMapMagicWindFrame08._Sprites

      aMapMagicWindFrame09 ; 9F/CC78

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, true, false]]

        .structSpriteArray aMapMagicWindFrame09._Sprites

      aMapMagicWindFrame10 ; 9F/CC7F

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, true, true]]

        .structSpriteArray aMapMagicWindFrame10._Sprites

      aMapMagicWindFrame11 ; 9F/CC86

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00C, 2, 6, true, true]]

        .structSpriteArray aMapMagicWindFrame11._Sprites

      aMapMagicWindFrame12 ; 9F/CC8D

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, true, true]]

        .structSpriteArray aMapMagicWindFrame12._Sprites

      aMapMagicWindFrame13 ; 9F/CC94

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aMapMagicWindFrame13._Sprites

      aMapMagicWindFrame14 ; 9F/CC9B

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aMapMagicWindFrame14._Sprites

      aMapMagicWindFrame15 ; 9F/CCA2

        _Sprites := [[(  -8,    0), $00, SpriteSmall, $013, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $00, SpriteSmall, $012, 2, 6, false, false]]

        .structSpriteArray aMapMagicWindFrame15._Sprites

      aMapMagicWindFrame16 ; 9F/CCAE

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, true, false]]

        .structSpriteArray aMapMagicWindFrame16._Sprites

      aMapMagicWindFrame17 ; 9F/CCB5

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $008, 2, 6, true, false]]

        .structSpriteArray aMapMagicWindFrame17._Sprites

      aMapMagicWindFrame18 ; 9F/CCBC

        _Sprites := [[(   0,    0), $00, SpriteSmall, $013, 2, 6, true, false]]
        _Sprites ..= [[(   0,   -8), $00, SpriteSmall, $012, 2, 6, true, false]]

        .structSpriteArray aMapMagicWindFrame18._Sprites

      aMapMagicWindFrame19 ; 9F/CCC8

        _Sprites := [[(   0,    0), $00, SpriteSmall, $016, 2, 6, true, false]]
        _Sprites ..= [[(   0,   -8), $00, SpriteSmall, $006, 2, 6, true, false]]
        _Sprites ..= [[(  -8,    0), $00, SpriteSmall, $016, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -8), $00, SpriteSmall, $006, 2, 6, false, false]]

        .structSpriteArray aMapMagicWindFrame19._Sprites

      aMapMagicWindFrame20 ; 9F/CCDE

        _Sprites := [[(   0,    0), $00, SpriteSmall, $017, 2, 6, false, false]]
        _Sprites ..= [[(   0,   -8), $00, SpriteSmall, $007, 2, 6, false, false]]
        _Sprites ..= [[(  -8,    0), $00, SpriteSmall, $017, 2, 6, true, false]]
        _Sprites ..= [[(  -8,   -8), $00, SpriteSmall, $007, 2, 6, true, false]]

        .structSpriteArray aMapMagicWindFrame20._Sprites

      aMapMagicWindFrame21 ; 9F/CCF4

        _Sprites := [[(   0,   -7), $00, SpriteSmall, $003, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -7), $00, SpriteSmall, $002, 2, 6, false, false]]

        .structSpriteArray aMapMagicWindFrame21._Sprites

      aMapMagicWindFrame22 ; 9F/CD00

        _Sprites := [[(   0,   -8), $00, SpriteSmall, $016, 2, 6, true, true]]
        _Sprites ..= [[(   0,    0), $00, SpriteSmall, $006, 2, 6, true, true]]
        _Sprites ..= [[(  -8,   -8), $00, SpriteSmall, $016, 2, 6, false, true]]
        _Sprites ..= [[(  -8,    0), $00, SpriteSmall, $006, 2, 6, false, true]]

        .structSpriteArray aMapMagicWindFrame22._Sprites

      aMapMagicWindFrame23 ; 9F/CD16

        _Sprites := [[(  -8,    0), $00, SpriteSmall, $007, 2, 6, true, true]]
        _Sprites ..= [[(   0,   -8), $00, SpriteSmall, $017, 2, 6, false, true]]
        _Sprites ..= [[(   0,    0), $00, SpriteSmall, $007, 2, 6, false, true]]
        _Sprites ..= [[(  -8,   -8), $00, SpriteSmall, $017, 2, 6, true, true]]

        .structSpriteArray aMapMagicWindFrame23._Sprites

      aMapMagicWindFrame24 ; 9F/CD2C

        _Sprites := [[(   0,   -1), $00, SpriteSmall, $003, 2, 6, false, true]]
        _Sprites ..= [[(  -8,   -1), $00, SpriteSmall, $002, 2, 6, false, true]]

        .structSpriteArray aMapMagicWindFrame24._Sprites


      rlStartMapMagicWarp ; 9F/CD38

        .al
        .xl
        .autsiz
        .databank ?

        ; Also Rescue.

        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $77

        lda #(`aMapMagicWarpSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicWarpSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        rtl

        .databank 0

      rlStartMapMagicBrokenStaff ; 9F/CD52

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $77

        lda #(`aMapMagicBrokenStaffSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicBrokenStaffSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        rtl

        .databank 0

      aMapMagicWarpSpriteInfo ; 9F/CD6C

        ; Part of the Warp effect.
        .word <>rlMapMagicWarpSpriteInit, <>rlMapMagicWarpSpriteSignal, <>aMapMagicWarpSpriteScript


      aMapMagicBrokenStaffSpriteInfo ; 9F/CD72

        ; Part of the BrokenStaff effect.
        .word <>rlMapMagicBrokenStaffSpriteInit, <>rlMapMagicBrokenStaffStartFall, <>aMapMagicBrokenStaffSpriteScript


      rlMapMagicWarpSpriteInit ; 9F/CD78

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Warp effect.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

      rlMapMagicWarpSpriteSignal ; 9F/CD9A

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Warp effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicWarpSpriteNoOp
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        lda #<>rlMapMagicWarpSpriteNoOp
        sta aActiveSpriteSystem.aOnCycle,b,x

      rlMapMagicWarpSpriteNoOp ; 9F/CDAC

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Warp effect.

        rtl

        .databank 0

      rlMapMagicWarpSpriteAscend ; 9F/CDAD

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Warp effect.

        jsl rlMoveActiveSpriteByVelocity
        lda aActiveSpriteSystem.aUnknown0013A0,b,x
        beq _CDCC
        stz aActiveSpriteSystem.aUnknown0013A0,b,x
        lda wMapMagicEffect
        cmp #$0020
        bne _CDCD
        lda #$0001
        sta wMapMagicDone
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _CDCC
        rtl


        _CDCD
        lda #$0001
        sta aActiveSpriteSystem.aFrameTimer,b,x
        lda #<>aMapMagicWarpSpriteScript2
        sta aActiveSpriteSystem.aCodeOffset,b,x
        lda #<>rlMapMagicWarpSpriteWaitFall
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0018
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$0800
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        stz aActiveSpriteSystem.aUnknown0011E0,b,x
        stz aActiveSpriteSystem.aUnknown001220,b,x
        lda $7F509D
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda #$FFF8
        sta aActiveSpriteSystem.aYPosition,b,x
        rtl


      rlMapMagicWarpSpriteWaitFall ; 9F/CE02

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Warp effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _CE0D
        lda #<>rlMapMagicWarpSpriteDescend
        sta aActiveSpriteSystem.aOnCycle,b,x

        _CE0D
        rtl

        .databank 0

      rlMapMagicWarpSpriteDescend ; 9F/CE0E

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Warp effect.

        jsl rlMoveActiveSpriteByVelocity
        lda $7F509E
        and #$00FF
        cmp aActiveSpriteSystem.aYPosition,b,x
        beq _CE21
        bmi _CE21
        rtl


        _CE21
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        lda #<>rlMapMagicWarpSpriteEnd
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0030
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

      rlMapMagicWarpSpriteEnd ; 9F/CE34

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Warp effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _CE43
        lda #$0001
        sta wMapMagicDone
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _CE43
        rtl

        .databank 0

      rlMapMagicBrokenStaffSpriteInit ; 9F/CE44

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the BrokenStaff effect.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        and #$FFF8
        sta aActiveSpriteSystem.aYPosition,b,x
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

      rlMapMagicBrokenStaffStartFall ; 9F/CE62

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the BrokenStaff effect.

        lda #<>rlMapMagicBrokenStaffWaitFall
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0018
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #$0800
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        stz aActiveSpriteSystem.aUnknown0011E0,b,x
        stz aActiveSpriteSystem.aUnknown001220,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda #$FFF8
        sta aActiveSpriteSystem.aYPosition,b,x
        rtl

        .databank 0

      rlMapMagicBrokenStaffWaitFall ; 9F/CE8B

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the BrokenStaff effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _CE96
        lda #<>rlMapMagicBrokenStaffDescend
        sta aActiveSpriteSystem.aOnCycle,b,x

        _CE96
        rtl

        .databank 0

      rlMapMagicBrokenStaffDescend ; 9F/CE97

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the BrokenStaff effect.

        jsl rlMoveActiveSpriteByVelocity
        lda wMapMagicTargetPixel+1
        and #$00FF
        cmp aActiveSpriteSystem.aYPosition,b,x
        beq _CEAA
        bmi _CEAA
        rtl


        _CEAA
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        lda #<>rlMapMagicBrokenStaffEnd
        sta aActiveSpriteSystem.aOnCycle,b,x
        lda #$0030
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        jsl rlUnfreezeWarpAttackerSprites
        rtl

        .databank 0

      rlMapMagicBrokenStaffEnd ; 9F/CEC1

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the BrokenStaff effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _CED0
        lda #$0001
        sta wMapMagicDone
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _CED0
        rtl

        .databank 0

      aMapMagicWarpSpriteScript ; 9F/CED1

        ; Part of the Warp effect.
        ACTIVE_SPRITE_FRAME 1, aMapMagicWarpFrame01
        ACTIVE_SPRITE_FRAME 2, aMapMagicWarpFrame02
        ACTIVE_SPRITE_FRAME 8, aMapMagicWarpFrame03
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame04
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame05
        ACTIVE_SPRITE_FRAME 2, aMapMagicWarpFrame06
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame07
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame04
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame05
        ACTIVE_SPRITE_CALL rlMapMagicWarpHideDefender
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame06
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame07
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame04
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame05
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame06
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame07
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame05
        ACTIVE_SPRITE_MOVE 0, -10
        ACTIVE_SPRITE_FRAME 5, aMapMagicWarpFrame08
        ACTIVE_SPRITE_MOVE 0, -18
        ACTIVE_SPRITE_FRAME 1, aMapMagicWarpFrame09
        ACTIVE_SPRITE_CALL rlMapMagicWarpLaunchUp

        _CF25
        ACTIVE_SPRITE_FRAME 1, aMapMagicWarpFrame09
        ACTIVE_SPRITE_CALL rlMapMagicWarpCheckOffscreen
        .word <>_CF25

        _CF2E
        ACTIVE_SPRITE_FRAME 1, aMapMagicWarpFrameEmpty
        ACTIVE_SPRITE_JUMP _CF2E

        ; 9F/CF35

      rlMapMagicWarpLaunchUp ; 9F/CF35

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Warp effect.

        lda #$F800
        sta aActiveSpriteSystem.aUnknown0013E0,b,x
        stz aActiveSpriteSystem.aUnknown0013C0,b,x
        lda #<>rlMapMagicWarpSpriteAscend
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

      rlMapMagicWarpCheckOffscreen ; 9F/CF45

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Warp effect.

        lda aActiveSpriteSystem.aYPosition,b,x
        bmi _CF4F
        lda $0000,b,y
        tay
        rtl


        _CF4F
        inc y
        inc y
        lda #$0001
        sta aActiveSpriteSystem.aUnknown0013A0,b,x
        rtl

        .databank 0

      rlMapMagicWarpHideDefender ; 9F/CF58

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Warp effect.

        lda aMapAction.wMapBattleDefenderAuxSpriteSlot
        cmp #$FFFF
        beq _CF65
        jsl rlMapMagicWarpHideSpriteSlot

        _CF65
        lda aMapAction.wMapBattleDefenderSpriteSlot

        .databank 0

      rlMapMagicWarpHideSpriteSlot ; 9F/CF69

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Warp effect.

        phy
        tay
        lda #$FFFE
        sta aActiveSpriteSystem.aYPosition,b,y
        ply
        rtl

        .databank 0

      aMapMagicWarpSpriteScript2 ; 9F/CF73

        ; Part of the Warp effect.

        ACTIVE_SPRITE_FRAME 1, aMapMagicWarpFrame09
        ACTIVE_SPRITE_CALL rlMapMagicWarpWaitPhase
        .word <>aMapMagicWarpSpriteScript2
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame09
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame08
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame05
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame07
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame06
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame05
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame04
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame07
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame06
        ACTIVE_SPRITE_CALL rlMapMagicWarpPlaceDefender
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame05
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame04
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame07
        ACTIVE_SPRITE_FRAME 2, aMapMagicWarpFrame06
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame05
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame04
        ACTIVE_SPRITE_FRAME 8, aMapMagicWarpFrame03
        ACTIVE_SPRITE_FRAME 2, aMapMagicWarpFrame02
        ACTIVE_SPRITE_FRAME 1, aMapMagicWarpFrame01

        _CFC7
        ACTIVE_SPRITE_FRAME 1, aMapMagicWarpFrameEmpty
        ACTIVE_SPRITE_JUMP _CFC7

      rlMapMagicWarpPlaceDefender ; 9F/CFCE

        .al
        .xl
        .autsiz
        .databank ?

        lda aMapAction.wMapBattleDefenderAuxSpriteSlot
        cmp #$FFFF
        beq _CFDB
        jsl rlMapMagicWarpPlaceSpriteSlot

        _CFDB
        lda aMapAction.wMapBattleDefenderSpriteSlot

        .databank 0

      rlMapMagicWarpPlaceSpriteSlot ; 9F/CFDF

        .al
        .xl
        .autsiz
        .databank ?

        phy
        tay
        lda $7F509D
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,y
        lda $7F509E
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,y
        ply
        rtl

        .databank 0

      rlMapMagicWarpWaitPhase ; 9F/CFF7

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown0013A0,b,x
        beq _CFFF
        inc y
        inc y
        rtl


        _CFFF
        lda $0000,b,y
        tay
        rtl

        .databank 0

      aMapMagicBrokenStaffSpriteScript ; 9F/D004

        ; Part of the BrokenStaff effect.
        ACTIVE_SPRITE_FRAME 1, aMapMagicWarpFrame09
        ACTIVE_SPRITE_CALL rlMapMagicBrokenStaffWaitPhase
        .word <>aMapMagicBrokenStaffSpriteScript
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame09
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame08
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame05
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame07
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame06
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame05
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame04
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame07
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame06
        ACTIVE_SPRITE_CALL rlMapMagicBrokenStaffPlaceDefender
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame05
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame04
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame07
        ACTIVE_SPRITE_FRAME 2, aMapMagicWarpFrame06
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame05
        ACTIVE_SPRITE_FRAME 3, aMapMagicWarpFrame04
        ACTIVE_SPRITE_FRAME 8, aMapMagicWarpFrame03
        ACTIVE_SPRITE_FRAME 2, aMapMagicWarpFrame02
        ACTIVE_SPRITE_FRAME 1, aMapMagicWarpFrame01

        _D058
        ACTIVE_SPRITE_FRAME 1, aMapMagicWarpFrameEmpty
        ACTIVE_SPRITE_JUMP _D058

        ; 9F/D05F
      rlMapMagicBrokenStaffPlaceDefender ; 9F/D05F

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the BrokenStaff effect.

        lda aMapAction.wMapBattleDefenderAuxSpriteSlot
        cmp #$FFFF
        beq _D06C
        jsl rlMapMagicBrokenStaffPlaceSpriteSlot

        _D06C
        lda aMapAction.wMapBattleDefenderSpriteSlot

        .databank 0

        ; 9F/D070
      rlMapMagicBrokenStaffPlaceSpriteSlot ; 9F/D070

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the BrokenStaff effect.

        phy
        tay
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,y
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,y
        ply
        rtl

        .databank 0

        ; 9F/D088
      rlMapMagicBrokenStaffWaitPhase ; 9F/D088

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the BrokenStaff effect.

        lda aActiveSpriteSystem.aUnknown0013A0,b,x
        beq _D090
        inc y
        inc y
        rtl


        _D090
        lda $0000,b,y
        tay
        rtl

        .databank 0

        ; 9F/D095

      aMapMagicWarpFrameEmpty ; 9F/D095

        .word 0

      aMapMagicWarpFrame01 ; 9F/D097

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aMapMagicWarpFrame01._Sprites

      aMapMagicWarpFrame02 ; 9F/D09E

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aMapMagicWarpFrame02._Sprites

      aMapMagicWarpFrame03 ; 9F/D0A5

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aMapMagicWarpFrame03._Sprites

      aMapMagicWarpFrame04 ; 9F/D0AC

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aMapMagicWarpFrame04._Sprites

      aMapMagicWarpFrame05 ; 9F/D0B3

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aMapMagicWarpFrame05._Sprites

      aMapMagicWarpFrame06 ; 9F/D0BA

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aMapMagicWarpFrame06._Sprites

      aMapMagicWarpFrame07 ; 9F/D0C1

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $006, 2, 6, false, false]]

        .structSpriteArray aMapMagicWarpFrame07._Sprites

      aMapMagicWarpFrame08 ; 9F/D0C8

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aMapMagicWarpFrame08._Sprites

      aMapMagicWarpFrame09 ; 9F/D0CF

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aMapMagicWarpFrame09._Sprites


      rlStartMapMagicJormungandr ; 9F/D0D6

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicJormungandr

        rtl

        .databank 0

      procMapMagicJormungandr ; 9F/D0DC

        ; Part of the Jormungandr effect.
        .structProcInfo "ON", rlMapMagicJormungandrInit, rlMapMagicJormungandrDarkenAndSpawn, aProcMapMagicHaltCode


      rlMapMagicJormungandrInit ; 9F/D0E4

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Jormungandr effect.

        jsr rsSaveMapMagicColors
        rtl

        .databank 0

      rlMapMagicJormungandrDarkenAndSpawn ; 9F/D0E8

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Jormungandr effect.

        jsr rsDarkenMapMagicColors
        bcc rlMapMagicJormungandrDone
        lda #<>rlMapMagicJormungandrDone
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #(`aMapMagicJormungandrSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicJormungandrSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot

      rlMapMagicJormungandrDone ; 9F/D101

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Jormungandr effect.

        rtl

        .databank 0

      aMapMagicJormungandrSpriteInfo ; 9F/D102

        ; Part of the Jormungandr effect.
        .word <>rlMapMagicJormungandrSpriteInit, <>rlMapMagicJormungandrSpriteNoOp, <>aMapMagicJormungandrSpriteScript

      rlMapMagicJormungandrSpriteInit ; 9F/D108

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Jormungandr effect.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicCasterPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicCasterPixel+1
        sec
        sbc #$0008
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        rtl

        .databank 0

        ; 9F/D128
      rlMapMagicJormungandrSpriteNoOp ; 9F/D128

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Jormungandr effect.

        rtl

        .databank 0

        ; 9F/D129
      rlMapMagicJormungandrSpriteFadeBack ; 9F/D129

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Jormungandr effect.

        jsr rsFadeBackMapMagicColors
        bcc _D138
        lda #$0001
        sta wMapMagicDone
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _D138
        rtl

        .databank 0

        ; 9F/D139
      aMapMagicJormungandrSpriteScript ; 9F/D139

        ; Part of the Jormungandr effect.
        ACTIVE_SPRITE_CALL rlMapMagicJormungandrPlayCastSound
        ACTIVE_SPRITE_FRAME 5, aMapMagicJormungandrFrame06
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrame07
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrame08
        ACTIVE_SPRITE_FRAME 5, aMapMagicJormungandrFrame09
        ACTIVE_SPRITE_FRAME 6, aMapMagicJormungandrFrame10
        ACTIVE_SPRITE_CALL rlMapMagicJormungandrMoveToTarget
        ACTIVE_SPRITE_FRAME 4, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicJormungandrPlayHitSound
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame01
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame02
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame02
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame02
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame03
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame03
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame03
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicJormungandrSignalStrike
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame11
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame11
        ACTIVE_SPRITE_FRAME 2, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame12
        ACTIVE_SPRITE_FRAME 2, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame12
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame12
        ACTIVE_SPRITE_FRAME 2, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame13
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame13
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame04
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame04
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame05
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrame05
        ACTIVE_SPRITE_FRAME 3, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicJormungandrStartFadeBack

        _D1F0
        ACTIVE_SPRITE_FRAME 1, aMapMagicJormungandrFrameEmpty
        ACTIVE_SPRITE_JUMP _D1F0

        ; 9F/D1F7
      rlMapMagicJormungandrSignalStrike ; 9F/D1F7

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Jormungandr effect.

        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        rtl

        .databank 0

        ; 9F/D1FF
      rlMapMagicJormungandrStartFadeBack ; 9F/D1FF

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Jormungandr effect.

        lda #<>rlMapMagicJormungandrSpriteFadeBack
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

        ; 9F/D206
      rlMapMagicJormungandrMoveToTarget ; 9F/D206

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Jormungandr effect.

        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        rtl

        .databank 0

        ; 9F/D21B
      rlMapMagicJormungandrPlayCastSound ; 9F/D21B

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Jormungandr effect.

        phy
        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $5A

        ply
        rtl

        .databank 0

        ; 9F/D225
      rlMapMagicJormungandrPlayHitSound ; 9F/D225

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Jormungandr effect.

        phy
        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $5B

        ply
        rtl

        .databank 0

        ; 9F/D22F

      aMapMagicJormungandrFrameEmpty ; 9F/D22F

        .word 0

      aMapMagicJormungandrFrame01 ; 9F/D231

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aMapMagicJormungandrFrame01._Sprites

      aMapMagicJormungandrFrame02 ; 9F/D238

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aMapMagicJormungandrFrame02._Sprites

      aMapMagicJormungandrFrame03 ; 9F/D23F

        _Sprites := [[(  -8,   -9), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aMapMagicJormungandrFrame03._Sprites

      aMapMagicJormungandrFrame04 ; 9F/D246

        _Sprites := [[(  -8,  -26), $21, SpriteLarge, $006, 2, 6, false, false]]

        .structSpriteArray aMapMagicJormungandrFrame04._Sprites

      aMapMagicJormungandrFrame05 ; 9F/D24D

        _Sprites := [[(  -8,  -33), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aMapMagicJormungandrFrame05._Sprites

      aMapMagicJormungandrFrame06 ; 9F/D254

        _Sprites := [[(  -2,    0), $00, SpriteSmall, $00B, 2, 6, false, false]]
        _Sprites ..= [[( -10,    0), $00, SpriteSmall, $01B, 2, 6, false, false]]
        _Sprites ..= [[(  -7,   -7), $00, SpriteSmall, $00A, 2, 6, false, false]]

        .structSpriteArray aMapMagicJormungandrFrame06._Sprites

      aMapMagicJormungandrFrame07 ; 9F/D265

        _Sprites := [[(  -2,   -3), $00, SpriteSmall, $01B, 2, 6, false, false]]
        _Sprites ..= [[( -10,   -4), $00, SpriteSmall, $00B, 2, 6, false, false]]
        _Sprites ..= [[(  -7,  -13), $00, SpriteSmall, $01A, 2, 6, false, false]]

        .structSpriteArray aMapMagicJormungandrFrame07._Sprites

      aMapMagicJormungandrFrame08 ; 9F/D276

        _Sprites := [[(  -2,   -4), $00, SpriteSmall, $00B, 2, 6, false, false]]
        _Sprites ..= [[( -10,   -9), $00, SpriteSmall, $01B, 2, 6, false, false]]
        _Sprites ..= [[(  -7,  -22), $00, SpriteSmall, $00A, 2, 6, false, false]]

        .structSpriteArray aMapMagicJormungandrFrame08._Sprites

      aMapMagicJormungandrFrame09 ; 9F/D287

        _Sprites := [[(  -2,   -7), $00, SpriteSmall, $01B, 2, 6, false, false]]
        _Sprites ..= [[( -10,  -15), $00, SpriteSmall, $00B, 2, 6, false, false]]
        _Sprites ..= [[(  -7,  -29), $00, SpriteSmall, $01A, 2, 6, false, false]]

        .structSpriteArray aMapMagicJormungandrFrame09._Sprites

      aMapMagicJormungandrFrame10 ; 9F/D298

        _Sprites := [[(  -6,  -39), $00, SpriteSmall, $00B, 2, 6, false, false]]

        .structSpriteArray aMapMagicJormungandrFrame10._Sprites

      aMapMagicJormungandrFrame11 ; 9F/D29F

        _Sprites := [[(  -8,    0), $21, SpriteLarge, $00C, 2, 6, false, false]]
        _Sprites ..= [[(  -8,  -15), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aMapMagicJormungandrFrame11._Sprites

      aMapMagicJormungandrFrame12 ; 9F/D2AB

        _Sprites := [[(  -8,   -4), $21, SpriteLarge, $00C, 2, 6, false, false]]
        _Sprites ..= [[(  -8,  -19), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aMapMagicJormungandrFrame12._Sprites

      aMapMagicJormungandrFrame13 ; 9F/D2B7

        _Sprites := [[(   0,   -9), $00, SpriteSmall, $017, 2, 6, false, false]]
        _Sprites ..= [[(  -8,   -9), $00, SpriteSmall, $016, 2, 6, false, false]]
        _Sprites ..= [[(  -8,  -22), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aMapMagicJormungandrFrame13._Sprites


      rlStartMapMagicThief ; 9F/D2C8

        .al
        .xl
        .autsiz
        .databank ?

        lda #(`aMapMagicThiefSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicThiefSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        rtl

        .databank 0

      aMapMagicThiefSpriteInfo ; 9F/D2D7

        ; Part of the Thief effect.
        .word <>rlMapMagicThiefSpriteInit, <>rlMapMagicThiefSpriteAim, <>aMapMagicThiefSpriteScript


      rlMapMagicThiefSpriteInit ; 9F/D2DD

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thief effect.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicCasterPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicCasterPixel+1
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        lda #$000A
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        rtl

        .databank 0

      rlMapMagicThiefSpriteAim ; 9F/D2FF

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thief effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _D340
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aXPosition,b,x
        sta wR0
        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aYPosition,b,x
        sta wR1
        jsl rlGetVectorLength
        lsr a
        lsr a
        bne _D329
        lda #$0002

        _D329
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda wR0
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda #$0400
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsMapMagicCalcSpriteVelocityFromAngle
        lda #<>rlMapMagicThiefSpriteFlyToTarget
        sta aActiveSpriteSystem.aOnCycle,b,x

        _D340
        rtl

        .databank 0

      rlMapMagicThiefSpriteFlyToTarget ; 9F/D341

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thief effect.

        jsl rlMoveActiveSpriteByVelocity
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicThiefSpriteAim._D340
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0020
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlMapMagicThiefSpriteDissipate
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

      rlMapMagicThiefSpriteDissipate ; 9F/D361

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thief effect.

        lda aActiveSpriteSystem.aUnknown001300,b,x
        sec
        sbc #$00C0
        bcs _D36D
        lda #$0000

        _D36D
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsMapMagicCalcSpriteVelocityFromAngle
        jsl rlMoveActiveSpriteByVelocity
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicThiefSpriteAim._D340
        lda #$0010
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlMapMagicThiefSpriteWaitEnd
        sta aActiveSpriteSystem.aOnCycle,b,x
        rtl

        .databank 0

      rlMapMagicThiefSpriteWaitEnd ; 9F/D389

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thief effect.

        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne rlMapMagicThiefSpriteAim._D340
        lda #$0001
        sta wMapMagicDone
        stz aActiveSpriteSystem.aTypeOffset,b,x
        rtl

        .databank 0

      aMapMagicThiefSpriteScript ; 9F/D399

        ; Part of the Thief effect.
        ACTIVE_SPRITE_FRAME 4, aMapMagicThiefFrame01
        ACTIVE_SPRITE_FRAME 5, aMapMagicThiefFrame02
        ACTIVE_SPRITE_FRAME 6, aMapMagicThiefFrame03
        ACTIVE_SPRITE_FRAME 9, aMapMagicThiefFrame04

        _D3A9
        ACTIVE_SPRITE_FRAME 3, aMapMagicThiefFrame04
        ACTIVE_SPRITE_FRAME 3, aMapMagicThiefFrame05
        ACTIVE_SPRITE_CALL rlMapMagicThiefWaitSpritePhase
        .word <>_D3A9
        ACTIVE_SPRITE_FRAME 5, aMapMagicThiefFrame06
        ACTIVE_SPRITE_FRAME 32, aMapMagicThiefFrame07
        ACTIVE_SPRITE_FRAME 9, aMapMagicThiefFrame04
        ACTIVE_SPRITE_FRAME 6, aMapMagicThiefFrame03
        ACTIVE_SPRITE_FRAME 5, aMapMagicThiefFrame02
        ACTIVE_SPRITE_FRAME 4, aMapMagicThiefFrame01

        _D3CE
        ACTIVE_SPRITE_FRAME 9, aMapMagicThiefFrameEmpty
        ACTIVE_SPRITE_JUMP _D3CE

        ; 9F/D3D5

      rlMapMagicThiefWaitSpritePhase ; 9F/D3D5

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Thief effect.

        lda aActiveSpriteSystem.aUnknown001320,b,x
        bne _D3DF
        lda $0000,b,y
        tay
        rtl


        _D3DF
        inc y
        inc y
        rtl

        .databank 0

      aMapMagicThiefFrameEmpty ; 9F/D3E2

        .word 0

      aMapMagicThiefFrame01 ; 9F/D3E4

        _Sprites := [[(  -4,   -4), $00, SpriteSmall, $00C, 2, 6, false, false]]

        .structSpriteArray aMapMagicThiefFrame01._Sprites

      aMapMagicThiefFrame02 ; 9F/D3EB

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aMapMagicThiefFrame02._Sprites

      aMapMagicThiefFrame03 ; 9F/D3F2

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aMapMagicThiefFrame03._Sprites

      aMapMagicThiefFrame04 ; 9F/D3F9

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $004, 2, 6, false, false]]

        .structSpriteArray aMapMagicThiefFrame04._Sprites

      aMapMagicThiefFrame05 ; 9F/D400

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $006, 2, 6, false, false]]

        .structSpriteArray aMapMagicThiefFrame05._Sprites

      aMapMagicThiefFrame06 ; 9F/D407

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aMapMagicThiefFrame06._Sprites

      aMapMagicThiefFrame07 ; 9F/D40E

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aMapMagicThiefFrame07._Sprites

      aMapMagicThiefFrameUnused1 ; 9F/D415

        _Sprites := [[(  -4,   -4), $00, SpriteSmall, $01C, 2, 6, false, false]]

        .structSpriteArray aMapMagicThiefFrameUnused1._Sprites

      aMapMagicThiefFrameUnused2 ; 9F/D41C

        _Sprites := [[(  -4,   -4), $00, SpriteSmall, $00D, 2, 6, false, false]]

        .structSpriteArray aMapMagicThiefFrameUnused2._Sprites

      aMapMagicThiefFrameUnused3 ; 9F/D423

        _Sprites := [[(  -4,   -4), $00, SpriteSmall, $01D, 2, 6, false, false]]

        .structSpriteArray aMapMagicThiefFrameUnused3._Sprites


      rlStartMapMagicValflame ; 9F/D42A

        .al
        .xl
        .autsiz
        .databank ?

        jsr rsCreateMapMagicProc

          .word <>procMapMagicValflame

        rtl

        .databank 0

      procMapMagicValflame ; 9F/D430

        ; Part of the Valflame effect.
        .structProcInfo "ON", rlMapMagicValflameInit, rlMapMagicValflameTintRed, aProcMapMagicValflameCode


      aProcMapMagicValflameCode ; 9F/D438

        ; Part of the Valflame effect.
        PROC_YIELD 1
        PROC_CALL rlMapMagicValflameStepBGPaletteAnim
        PROC_JUMP aProcMapMagicValflameCode


      rlMapMagicValflameInit ; 9F/D443

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        jsr rsSetMapMagicLayerBlending
        lda #$0000
        sta $7ECC06
        sta $7ECC08
        sta $7ECC0A
        sta $7ECC0C
        stz aProcSystem.aBody2,b,x
        stz aProcSystem.aBody3,b,x
        jsr rsSaveMapMagicColors
        rtl

        .databank 0

      rlMapMagicValflameTintRed ; 9F/D463

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        jsr rsTintMapMagicColorsRed
        bcc _D474
        lda #<>rlMapMagicValflameWaitAndSpawn
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0020
        sta aProcSystem.aBody0,b,x

        _D474
        rtl

        .databank 0

      rlMapMagicValflameWaitAndSpawn ; 9F/D475

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        dec aProcSystem.aBody0,b,x
        bpl _D489
        jsr rsMapMagicValflameSpawnEffects
        lda #<>rlMapMagicValflameWaitHold
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0080
        sta aProcSystem.aBody0,b,x

        _D489
        rtl

        .databank 0

      rlMapMagicValflameWaitHold ; 9F/D48A

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        dec aProcSystem.aBody0,b,x
        bne _D495
        lda #<>rlMapMagicValflameDone
        sta aProcSystem.aHeaderOnCycle,b,x

        _D495
        rtl

        .databank 0

      rlMapMagicValflameDone ; 9F/D496

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        rtl

        .databank 0

      rsMapMagicValflameSpawnEffects ; 9F/D497

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        jsr rsCreateMapMagicProc

          .word <>procMapMagicValflameBeam

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDBB8

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDC34

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB6C

        jsr rsCreateMapMagicHDMA

          .word <>aUnknown9FDB7F

        jsr rsCreateMapMagicHDMA

          .word <>aMapMagicValflameSpawnParams

        phx
        lda #(`aMapMagicValflameSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicValflameSpriteInfo
        sta lR44
        jsl rlActiveSpriteEngineCreateSpriteLowestSlot
        plx
        rts

        .databank 0

      rlMapMagicValflameStepBGPaletteAnim ; 9F/D4C6

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        lda aProcSystem.aBody2,b,x
        beq _D4D0
        dec a
        sta aProcSystem.aBody2,b,x
        rtl


        _D4D0
        lda #$0002
        sta aProcSystem.aBody2,b,x
        phx
        lda aProcSystem.aBody3,b,x
        inc aProcSystem.aBody3,b,x
        cmp #$0010
        bmi _D4E5
        stz aProcSystem.aBody3,b,x

        _D4E5
        asl a
        tax
        lda <>aMapMagicValflameBGPaletteAnim,b,x
        sta $01D2,b
        lda <>(aMapMagicValflameBGPaletteAnim+2),b,x
        sta $01D4,b
        lda <>(aMapMagicValflameBGPaletteAnim+4),b,x
        sta $01D6,b
        lda <>(aMapMagicValflameBGPaletteAnim+6),b,x
        sta $01D8,b
        lda <>(aMapMagicValflameBGPaletteAnim+8),b,x
        sta $01DA,b
        lda <>(aMapMagicValflameBGPaletteAnim+10),b,x
        sta $01DC,b
        lda <>(aMapMagicValflameBGPaletteAnim+12),b,x
        sta $01DE,b
        plx
        rtl

        .databank 0

      aMapMagicValflameBGPaletteAnim ; 9F/D513

        ; Part of the Valflame effect.
        .word $03FF, $033F, $025F, $019F, $019F, $025F, $033F, $03FF
        .word $03FF, $033F, $025F, $019F, $019F, $025F, $033F, $03FF
        .word $03FF, $033F, $025F, $019F, $019F, $025F, $033F, $03FF
        .word $03FF

      rlMapMagicValflameStepSpritePal ; 9F/D545

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        lda aActiveSpriteSystem.aUnknown001320,b,x
        beq _D54F
        dec a
        sta aActiveSpriteSystem.aUnknown001320,b,x
        rtl


        _D54F
        lda #$0003
        sta aActiveSpriteSystem.aUnknown001320,b,x
        phx
        lda aActiveSpriteSystem.aUnknown001340,b,x
        inc aActiveSpriteSystem.aUnknown001340,b,x
        cmp #$0010
        bmi _D564
        stz aActiveSpriteSystem.aUnknown001340,b,x

        _D564
        asl a
        tax
        lda <>aMapMagicValflameSpritePalettes,b,x
        sta $02D2,b
        lda <>(aMapMagicValflameSpritePalettes+2),b,x
        sta $02D4,b
        lda <>(aMapMagicValflameSpritePalettes+4),b,x
        sta $02D6,b
        lda <>(aMapMagicValflameSpritePalettes+6),b,x
        sta $02D8,b
        lda <>(aMapMagicValflameSpritePalettes+8),b,x
        sta $02DA,b
        lda <>(aMapMagicValflameSpritePalettes+10),b,x
        sta $02DC,b
        lda <>(aMapMagicValflameSpritePalettes+12),b,x
        sta $02DE,b
        plx
        rtl

        .databank 0

      aMapMagicValflameSpritePalettes ; 9F/D592

        ; Part of the Valflame effect.
        .word $02FF, $025F, $01FC, $01B7, $00F5, $14B0, $00F5, $01B7
        .word $025F, $02FF, $025F, $01B7, $00F5, $14B0, $00F5, $01FC
        .word $02FF, $025F, $01FC, $01B7, $00F5, $14B0, $00F5, $01B7
        .word $025F, $02FF, $025F, $01B7, $00F5, $14B0, $00F5, $01FC

      aMapMagicValflameSpriteInfo ; 9F/D5D2

        ; Part of the Valflame effect.
        .word <>rlMapMagicValflameSpriteInit, <>rlMapMagicValflameSpriteWaitEnd, <>aMapMagicValflameSpriteScript


      rlMapMagicValflameSpriteInit ; 9F/D5D8

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sta aActiveSpriteSystem.aXPosition,b,x
        lda wMapMagicTargetPixel+1
        clc
        adc #$0002
        and #$00FF
        sta aActiveSpriteSystem.aYPosition,b,x
        rtl

        .databank 0

      rlMapMagicValflameSpriteWaitEnd ; 9F/D5F8

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        jsl rlMapMagicValflameStepSpritePal
        lda $7ECC06
        beq _D60C
        lda #$0001
        sta wMapMagicDone
        stz aActiveSpriteSystem.aTypeOffset,b,x

        _D60C
        rtl

        .databank 0

      aMapMagicValflameOrbLeftSpriteInfo ; 9F/D60D

        ; Part of the Valflame effect.
        .word <>rlMapMagicValflameOrbLeftInit, <>rlMapMagicValflameOrbConverge, <>aMapMagicValflameOrbLeftSpriteScript


      aMapMagicValflameOrbRightSpriteInfo ; 9F/D613

        ; Part of the Valflame effect.
        .word <>rlMapMagicValflameOrbRightInit, <>rlMapMagicValflameOrbConverge, <>aMapMagicValflameOrbRightSpriteScript


      rlMapMagicValflameOrbRightInit ; 9F/D619

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        lda #$8000
        sta wR2
        bra rlMapMagicValflameOrbLeftInit._D622

        .databank 0

      rlMapMagicValflameOrbLeftInit ; 9F/D620

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        stz wR2

        _D622
        lda $7F509F
        sta aActiveSpriteSystem.aTileBase,b,x
        ldy wR0
        lda <>aMapMagicValflameOrbData,b,y
        bit wR2
        bpl _D636
        eor #$FFFF
        inc a

        _D636
        sta wR3
        lda wMapMagicTargetPixel
        and #$00FF
        clc
        adc wR3
        sec
        sbc aActiveSpriteSystem.aXPosition,b,x
        sta wR0
        lda wMapMagicTargetPixel+1
        clc
        adc <>(aMapMagicValflameOrbData+2),b,y
        and #$00FF
        sec
        sbc aActiveSpriteSystem.aYPosition,b,x
        sta wR1
        jsl rlGetVectorLength
        lsr a
        lsr a
        bne _D664
        lda #$0002

        _D664
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda wR0
        sta aActiveSpriteSystem.aUnknown0012E0,b,x
        lda #$0400
        sta aActiveSpriteSystem.aUnknown001300,b,x
        jsr rsMapMagicCalcSpriteVelocityFromAngle
        lda aActiveSpriteSystem.aXPosition,b,x
        jsr rsPlayMapMagicSound

          .byte $4D

        rtl

        .databank 0

      aMapMagicValflameOrbData ; 9F/D67D

        ; Part of the Valflame effect.
        .byte $F0, $FF, $02, $00, $00, $00, $00, $00, $F8, $FF, $06, $00, $00, $00, $00, $00
        .byte $F0, $FF, $02, $00, $00, $00, $00, $00, $F8, $FF, $06, $00, $00, $00, $00, $00

      rlMapMagicValflameOrbConverge ; 9F/D69D

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        jsl rlMoveActiveSpriteByVelocity
        dec aActiveSpriteSystem.aUnknown0012C0,b,x
        bne _D6B8
        lda #$0001
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #$0020
        sta aActiveSpriteSystem.aUnknown0012C0,b,x
        lda #<>rlMapMagicValflameOrbDone
        sta aActiveSpriteSystem.aOnCycle,b,x

        _D6B8
        rtl


      rlMapMagicValflameOrbDone ; 9F/D6B9

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        rtl

        .databank 0

      aMapMagicValflameOrbLeftSpriteScript ; 9F/D6BA

        ; Part of the Valflame effect.

        ACTIVE_SPRITE_FRAME 1, aMapMagicValflameFrame01
        ACTIVE_SPRITE_CALL rlMapMagicValflameWaitLeftOrbPhase
        .word <>aMapMagicValflameOrbLeftSpriteScript
        ACTIVE_SPRITE_FRAME 4, aMapMagicValflameFrame03
        ACTIVE_SPRITE_FRAME 4, aMapMagicValflameFrame04
        ACTIVE_SPRITE_FRAME 4, aMapMagicValflameFrame05
        ACTIVE_SPRITE_FRAME 1, aMapMagicValflameFrameEmpty
        ACTIVE_SPRITE_END

      rlMapMagicValflameWaitLeftOrbPhase ; 9F/D6D4

        .al
        .xl
        .autsiz
        .databank ?

        lda aActiveSpriteSystem.aUnknown001320,b,x
        cmp #$0001
        beq _D6E1
        lda $0000,b,y
        tay
        rtl


        _D6E1
        inc y
        inc y
        rtl

        .databank 0

      aMapMagicValflameOrbRightSpriteScript ; 9F/D6E4

        ; Part of the Valflame effect.
        ACTIVE_SPRITE_FRAME 1, aMapMagicValflameFrame09
        ACTIVE_SPRITE_CALL rlMapMagicValflameWaitOrbPhase
        .word <>aMapMagicValflameOrbRightSpriteScript
        ACTIVE_SPRITE_FRAME 4, aMapMagicValflameFrame03
        ACTIVE_SPRITE_FRAME 4, aMapMagicValflameFrame04
        ACTIVE_SPRITE_FRAME 4, aMapMagicValflameFrame05
        ACTIVE_SPRITE_FRAME 1, aMapMagicValflameFrameEmpty
        ACTIVE_SPRITE_END

        ; 9F/D6FE

      rlMapMagicValflameWaitOrbPhase ; 9F/D6FE

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        lda aActiveSpriteSystem.aUnknown001320,b,x
        cmp #$0001
        beq _D70B
        lda $0000,b,y
        tay
        rtl


        _D70B
        inc y
        inc y
        rtl

        .databank 0

      aMapMagicValflameSpriteScript ; 9F/D70E

        ; Part of the Valflame effect.
        ACTIVE_SPRITE_FRAME 1, aMapMagicValflameFrameEmpty
        ACTIVE_SPRITE_CALL rlMapMagicValflameWaitColumnOrRing
        .word <>aMapMagicValflameSpriteScript
        ACTIVE_SPRITE_FRAME 6, aMapMagicValflameFrame06
        ACTIVE_SPRITE_FRAME 5, aMapMagicValflameFrame07
        ACTIVE_SPRITE_FRAME 3, aMapMagicValflameFrame08

        _D723
        ACTIVE_SPRITE_FRAME 1, aMapMagicValflameFrame02
        ACTIVE_SPRITE_CALL rlMapMagicValflameWaitRing
        .word <>_D723
        ACTIVE_SPRITE_FRAME 2, aMapMagicValflameFrame08
        ACTIVE_SPRITE_FRAME 2, aMapMagicValflameFrame07
        ACTIVE_SPRITE_FRAME 2, aMapMagicValflameFrame06

        _D738
        ACTIVE_SPRITE_FRAME 1, aMapMagicValflameFrameEmpty
        ACTIVE_SPRITE_JUMP _D738

      rlMapMagicValflameWaitColumnOrRing ; 9F/D73F

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        lda $7ECC08
        bne rlMapMagicValflameWaitRing._D752
        bra rlMapMagicValflameWaitRing._D74D
        .databank 0

        ; 9F/D747
      rlMapMagicValflameWaitRing ; 9F/D747

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        lda $7ECC0A
        bne _D752

        _D74D
        lda $0000,b,y
        tay
        rtl


        _D752
        inc y
        inc y
        rtl

        .databank 0

        ; 9F/D755

      aMapMagicValflameFrameEmpty ; 9F/D755

        .word 0

      aMapMagicValflameFrame01 ; 9F/D757

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, false, false]]

        .structSpriteArray aMapMagicValflameFrame01._Sprites

      aMapMagicValflameFrame02 ; 9F/D75E

        _Sprites := [[(   0,   -5), $21, SpriteLarge, $004, 2, 6, false, false]]
        _Sprites ..= [[( -16,   -5), $21, SpriteLarge, $002, 2, 6, false, false]]

        .structSpriteArray aMapMagicValflameFrame02._Sprites

      aMapMagicValflameFrame03 ; 9F/D76A

        _Sprites := [[(  -4,   -4), $00, SpriteSmall, $016, 2, 6, false, false]]

        .structSpriteArray aMapMagicValflameFrame03._Sprites

      aMapMagicValflameFrame04 ; 9F/D771

        _Sprites := [[(  -4,   -4), $00, SpriteSmall, $006, 2, 6, false, false]]

        .structSpriteArray aMapMagicValflameFrame04._Sprites

      aMapMagicValflameFrame05 ; 9F/D778

        _Sprites := [[(  -4,   -4), $00, SpriteSmall, $017, 2, 6, false, false]]

        .structSpriteArray aMapMagicValflameFrame05._Sprites

      aMapMagicValflameFrame06 ; 9F/D77F

        _Sprites := [[(  -4,   -1), $00, SpriteSmall, $007, 2, 6, false, false]]

        .structSpriteArray aMapMagicValflameFrame06._Sprites

      aMapMagicValflameFrame07 ; 9F/D786

        _Sprites := [[(  -8,   -5), $21, SpriteLarge, $008, 2, 6, false, false]]

        .structSpriteArray aMapMagicValflameFrame07._Sprites

      aMapMagicValflameFrame08 ; 9F/D78D

        _Sprites := [[(   5,   -5), $21, SpriteLarge, $00C, 2, 6, false, false]]
        _Sprites ..= [[( -11,   -5), $21, SpriteLarge, $00A, 2, 6, false, false]]

        .structSpriteArray aMapMagicValflameFrame08._Sprites

      aMapMagicValflameFrame09 ; 9F/D799

        _Sprites := [[(  -8,   -8), $21, SpriteLarge, $000, 2, 6, true, false]]

        .structSpriteArray aMapMagicValflameFrame09._Sprites


      procMapMagicValflameBeam ; 9F/D7A0

        ; Part of the Valflame effect.
        .structProcInfo "ON", rlMapMagicValflameBeamInit, rlMapMagicValflameBeamDescend, aProcMapMagicHaltCode


      rlMapMagicValflameBeamInit ; 9F/D7A8

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        lda #$0020
        sta aProcSystem.aBody0,b,x
        stz aProcSystem.aBody1,b,x
        stz aProcSystem.aBody2,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        cmp #$00C0
        bmi _D7F3
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta wR10
        lda #$0035
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc wR12+1
        and #$00FF
        xba
        sta aProcSystem.aBody5,b,x
        lda #$C800
        sta aProcSystem.aBody3,b,x
        sta aProcSystem.aBody4,b,x
        sta aProcSystem.aBody7,b,x
        jml rlMapMagicClearWindowBuffers


        _D7F3
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta wR10
        lda #$0035
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wR12+1
        clc
        adc wMapMagicTargetPixel
        and #$00FF
        xba
        sta aProcSystem.aBody5,b,x
        lda #$B800
        sta aProcSystem.aBody3,b,x
        sta aProcSystem.aBody4,b,x
        sta aProcSystem.aBody7,b,x
        jml rlMapMagicClearWindowBuffers

        .databank 0

      rlMapMagicValflameBeamDescend ; 9F/D823

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        lda wMapMagicTargetPixel+1
        and #$00FF
        sta wR0
        lda aProcSystem.aBody1,b,x
        clc
        adc #$0006
        sta aProcSystem.aBody1,b,x
        cmp wR0
        bmi _D852
        lda #$0001
        sta $7ECC08
        lda wR0
        sta aProcSystem.aBody1,b,x
        lda #$0006
        sta aProcSystem.aBody0,b,x
        lda #<>rlMapMagicValflameBeamImpact
        sta aProcSystem.aHeaderOnCycle,b,x

        _D852
        sta wR1
        lda aProcSystem.aBody5,b,x
        sta wR2
        lda aProcSystem.aBody3,b,x
        sta wR4
        lda aProcSystem.aBody4,b,x
        sta wR5
        lda aProcSystem.aBody2,b,x
        jsr rsMapMagicValflameDrawWindowSlice
        rtl

        .databank 0

      rlMapMagicValflameBeamImpact ; 9F/D86A

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        jsr rsMapMagicValflameLoadBeamRegs
        dec aProcSystem.aBody0,b,x
        bne _D898
        lda #<>rlMapMagicValflameBeamExpand
        sta aProcSystem.aHeaderOnCycle,b,x
        lda wMapMagicTargetPixel+1
        and #$00FF
        lsr a
        lsr a
        lsr a
        lsr a
        tay
        lda <>aMapMagicValflameBeamImpactSteps,b,y
        and #$00FF
        sta aProcSystem.aBody0,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        jsr rsPlayMapMagicSound

          .byte $64


        _D898
        rtl

        .databank 0

      aMapMagicValflameBeamImpactSteps ; 9F/D899

        ; Part of the Valflame effect.
        .byte $16, $12, $0E, $0C, $0A, $09, $08, $07, $07, $06, $05, $05, $05, $05, $05, $05

      rlMapMagicValflameBeamExpand ; 9F/D8A9

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        lda aProcSystem.aBody3,b,x
        clc
        adc #$FF80
        sta aProcSystem.aBody3,b,x
        lda aProcSystem.aBody4,b,x
        clc
        adc #$0080
        sta aProcSystem.aBody4,b,x
        lda aProcSystem.aBody1,b,x
        sta wR1
        lda aProcSystem.aBody3,b,x
        sta wR4
        lda aProcSystem.aBody4,b,x
        sta wR5
        lda aProcSystem.aBody5,b,x
        sta wR2
        lda aProcSystem.aBody2,b,x
        clc
        adc #$0100
        sta aProcSystem.aBody2,b,x
        dec aProcSystem.aBody0,b,x
        bne _D8EF
        lda #<>rlMapMagicValflameBeamWaitStrike
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0080
        sta aProcSystem.aBody0,b,x
        stz aProcSystem.aBody6,b,x

        _D8EF
        lda aProcSystem.aBody2,b,x
        jsr rsMapMagicValflameDrawWindowSlice
        rtl

        .databank 0

      rlMapMagicValflameBeamWaitStrike ; 9F/D8F6

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        lda aProcSystem.aBody0,b,x
        cmp #$0010
        bne _D905
        lda #$0001
        sta aMapAction.wMapBattleStrikeSignal

        _D905
        lda aProcSystem.aBody0,b,x
        and #$001F
        bne rlMapMagicValflameSpawnRingSprites._D948
        phx
        lda aProcSystem.aBody6,b,x
        asl a
        asl a
        sta wR0

        .databank 0

      rlMapMagicValflameSpawnRingSprites ; 9F/D915

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        inc aProcSystem.aBody6,b,x
        lda aProcSystem.aBody5,b,x
        and #$FF00
        xba
        tax
        ldy #$0000
        lda #(`aMapMagicValflameOrbLeftSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicValflameOrbLeftSpriteInfo
        sta lR44
        lda wMapMagicTargetPixel
        and #$00FF
        cmp #$00C0
        bmi _D943
        lda #(`aMapMagicValflameOrbRightSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapMagicValflameOrbRightSpriteInfo
        sta lR44

        _D943
        jsl rlActiveSpriteEngineCreateSpriteHighestSlot
        plx

        _D948
        dec aProcSystem.aBody0,b,x
        bne _D960
        lda #<>rlMapMagicValflameBeamContract
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0006
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta $7ECC0A

        _D960
        rtl

        .databank 0

      rlMapMagicValflameBeamContract ; 9F/D961

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        lda aProcSystem.aBody3,b,x
        clc
        adc #$0100
        cmp aProcSystem.aBody7,b,x
        bcc _D970
        lda aProcSystem.aBody7,b,x

        _D970
        sta aProcSystem.aBody3,b,x
        lda aProcSystem.aBody4,b,x
        clc
        adc #$FF00
        cmp aProcSystem.aBody7,b,x
        bcs _D982
        lda aProcSystem.aBody7,b,x

        _D982
        sta aProcSystem.aBody4,b,x
        lda aProcSystem.aBody2,b,x
        clc
        adc #$FE00
        bpl _D991
        lda #$0000

        _D991
        sta aProcSystem.aBody2,b,x
        lda aProcSystem.aBody1,b,x
        sta wR1
        lda aProcSystem.aBody3,b,x
        and #$FF00
        sta wR4
        lda aProcSystem.aBody4,b,x
        and #$FF00
        sta wR5
        lda aProcSystem.aBody5,b,x
        sta wR2
        dec aProcSystem.aBody0,b,x
        bne _D9C2
        lda #<>rlMapMagicValflameFadeBack
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0000
        sta aProcSystem.aBody2,b,x
        jsr rsFreeMapMagicHDMA

        _D9C2
        lda aProcSystem.aBody2,b,x
        jsr rsMapMagicValflameDrawWindowSlice
        rtl

        .databank 0

      rlMapMagicValflameFadeBack ; 9F/D9C9

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        jsr rsFadeBackMapMagicColors
        bcc rlMapMagicValflameBeamDone
        lda #<>rlMapMagicValflameBeamDone
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0001
        sta $7ECC06

      rlMapMagicValflameBeamDone ; 9F/D9DB

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        rtl

        .databank 0

      rsMapMagicValflameLoadBeamRegs ; 9F/D9DC

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        lda aProcSystem.aBody1,b,x
        sta wR1
        lda aProcSystem.aBody3,b,x
        sta wR4
        lda aProcSystem.aBody4,b,x
        sta wR5
        lda aProcSystem.aBody5,b,x
        sta wR2
        lda aProcSystem.aBody2,b,x

        .databank 0

      rsMapMagicValflameDrawWindowSlice ; 9F/D9F3

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Valflame effect.

        phx
        lsr a
        pha
        clc
        adc wR2
        bcc _D9FE
        lda #$FFFF

        _D9FE
        sta wR3
        lda wR2
        sec
        sbc #1,s
        bcs _DA0A
        lda #$0000

        _DA0A
        sta wR2
        pla
        lda wR4+1
        and #$00FF
        sta wR0
        lda #$0100
        jsl rlMultiplyByNegSin._8B84
        sta wR8
        bpl _DA23
        eor #$FFFF
        inc a

        _DA23
        xba
        sta $4204,b
        lda wR4+1
        and #$00FF
        sta wR0
        lda #$0100
        jsl rlMultiplyByNegSin
        sep #$20
        sta $4206,b
        nop
        nop
        nop
        nop
        nop
        nop
        rep #$20
        lda $4214,b
        bit wR8
        bpl _DA4D
        eor #$FFFF

        _DA4C
        inc a

        _DA4D
        sta wR6
        lda wR5+1
        and #$00FF
        sta wR0
        lda #$0100
        jsl rlMultiplyByNegSin._8B84
        sta wR8
        bpl _DA65
        eor #$FFFF
        inc a

        _DA65
        xba
        sta $4204,b
        lda wR5+1
        and #$00FF
        sta wR0
        lda #$0100
        jsl rlMultiplyByNegSin
        sep #$20
        sta $4206,b
        nop
        nop
        nop
        nop
        nop
        nop
        rep #$20
        lda $4214,b
        bit wR8
        bpl _DA8F
        eor #$FFFF
        inc a

        _DA8F
        sta wR7
        lda #$50EA
        sta $2181,b
        sep #$20
        lda #$01
        sta $2183,b
        rep #$20
        ldx #$0000
        ldy #$0000

        _DAA6
        lda wR2
        clc
        adc wR6
        sta wR2
        and #$FF00
        cmp #$0800
        bcs _DAB8
        lda #$0800

        _DAB8
        xba
        sep #$20
        sta $2180,b
        rep #$20
        lda wR3
        clc
        adc wR7
        sta wR3
        and #$FF00
        cmp #$F700
        bcc _DAD2
        lda #$F700

        _DAD2
        xba
        sep #$20
        sta $2180,b
        rep #$20
        inc x
        cpx wR1
        bmi _DAA6
        stx wR1
        lda wR3
        sec
        sbc wR2
        cmp #$0100
        bmi _DB4E
        clc
        adc #$0A00
        and #$FE00
        xba
        lsr a
        and #$FFFE
        bne _DAFC
        lda #$0002

        _DAFC
        tay
        inc a
        asl a
        tax
        phb
        pea #$9A00
        plb
        .databank ?
        plb
        .databank ?
        lda aBattleSceneWindowShapes,x
        clc
        adc #<>aBattleSceneWindowShapes
        tax
        dec x
        lda wR2+1
        clc
        adc wR3+1
        and #$01FF
        lsr a
        sta wR0

        _DB1B
        sep #$20
        lda wR0
        sec
        sbc $0000,b,x
        bcs _DB27
        lda #$00

        _DB27
        cmp wR2+1
        bcs _DB2D
        lda wR2+1

        _DB2D
        sta $2180,b
        lda $0000,b,x
        clc
        adc wR0
        bcc _DB3A
        lda #$F8

        _DB3A
        cmp wR3+1
        bcc _DB40
        lda wR3+1

        _DB40
        sta $2180,b
        rep #$20
        dec wR1
        dec x
        dec x
        dec y
        dec y
        bne _DB1B
        plb
        .databank ?

        _DB4E
        ldx wR1
        bra _DB61


        _DB52
        sep #$20
        lda #$FF
        sta $2180,b
        lda #$00
        sta $2180,b
        rep #$20
        inc x

        _DB61
        cpx #$00E0
        bmi _DB52
        plx
        rts

        .databank 0

    .endsection Unsorted9F9ABFSection

.section Unsorted9FDB68Section

      .al
      .xl

      rlHDMAMapMagicNoOp1 ; 9F/DB68

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9F/DB69

      rlHDMAMapMagicNoOp2 ; 9F/DB69

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9F/DB6A


      aHDMAUnknown9FDB6ACode ; 9F/DB6A

        HDMA_HALT

      aUnknown9FDB6C .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicNoOp1, rlHDMAMapMagicNoOp2, aHDMAUnknown9FDB6ACode, aUnknown9FDB78, PPU_REG_BASE + $28, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode1), $7F ; 9F/DB6C

        ; Shared by 24 effects.
      aUnknown9FDB78 ; 9F/DB78

        .byte $FF, $EA, $50, $E0, $E8, $51, $00

      aUnknown9FDB7F .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicSetOffsetType1, rlHDMAMapMagicNoOp2, aHDMAUnknown9FDB6ACode, aUnknown9FDBA1, PPU_REG_BASE + $08, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode0), $9F ; 9F/DB7F

        ; Shared by 24 effects.
    .endsection Unsorted9FDB68Section


    .section Unsorted9FDB8BSection

      .al
      .xl

      rlHDMAMapMagicSetOffsetType1 ; 9F/DB8B

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ldy #$DBB3
        lda wMapMagicFlags
        bmi _DB9C
        and #$0400
        beq _DBA0
        ldy #$DBAA

        _DB9C
        tya
        sta aHDMASystem.aOffset,b,x

        _DBA0
        rtl

        .databank 0

        ; 9F/DBA1


      aUnknown9FDBA1 ; 9F/DBA1

        .byte $08, $5C, $21, $54, $7F, $5C, $37, $5C, $00, $7F, $5C, $30, $5C, $22, $54, $0E
        .byte $5C, $00, $70, $5C, $70, $5C, $00

      aUnknown9FDBB8 .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicSetOffsetType2, rlHDMAMapMagicNoOp2, aHDMAUnknown9FDB6ACode, aUnknown9FDBDA, PPU_REG_BASE + $23, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode0), $9F ; 9F/DBB8

        ; Shared by 24 effects.
    .endsection Unsorted9FDB8BSection


    .section Unsorted9FDBC4Section

      .al
      .xl

      rlHDMAMapMagicSetOffsetType2 ; 9F/DBC4

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ldy #$DBEC
        lda wMapMagicFlags
        bmi _DBD5
        and #$0400
        beq _DBD9
        ldy #$DBE3

        _DBD5
        tya
        sta aHDMASystem.aOffset,b,x

        _DBD9
        rtl

        .databank 0

        ; 9F/DBDA


      aUnknown9FDBDA ; 9F/DBDA

        .byte $08, $C3, $21, $33, $7F, $C3, $37, $C3, $00, $7F, $C3, $30, $C3, $22, $33, $0E
        .byte $C3, $00, $70, $C3, $70, $C3, $00

      aUnknown9FDBF1 .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicSetOffsetType3, rlHDMAMapMagicNoOp2, aHDMAUnknown9FDB6ACode, aUnknown9FDC13, PPU_REG_BASE + $30, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode1), $9F ; 9F/DBF1

        ; Shared by 9 effects.
    .endsection Unsorted9FDBC4Section


    .section Unsorted9FDBFDSection

      .al
      .xl

      rlHDMAMapMagicSetOffsetType3 ; 9F/DBFD

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ldy #$DC2D
        lda wMapMagicFlags
        bmi _DC0E
        and #$0400
        beq _DC12
        ldy #$DC20

        _DC0E
        tya
        sta aHDMASystem.aOffset,b,x

        _DC12
        rtl

        .databank 0

        ; 9F/DC13


      aUnknown9FDC13 ; 9F/DC13

        .byte $08, $02, $02, $21, $00, $82, $7F, $02, $02, $37, $02, $02, $00, $7F, $02, $02
        .byte $30, $02, $02, $22, $00, $82, $0E, $02, $02, $00, $70, $02, $02, $70, $02, $02
        .byte $00

      aUnknown9FDC34 .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicSetOffsetType4, rlHDMAMapMagicNoOp2, aHDMAUnknown9FDB6ACode, aUnknown9FDC56, PPU_REG_BASE + $30, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode1), $9F ; 9F/DC34

        ; Shared by 15 effects.
    .endsection Unsorted9FDBFDSection


    .section Unsorted9FDC40Section

      .al
      .xl

      rlHDMAMapMagicSetOffsetType4 ; 9F/DC40

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ldy #$DC70
        lda wMapMagicFlags
        bmi _DC51
        and #$0400
        beq _DC55
        ldy #$DC63

        _DC51
        tya
        sta aHDMASystem.aOffset,b,x

        _DC55
        rtl

        .databank 0

        ; 9F/DC56


      aUnknown9FDC56 ; 9F/DC56

        .byte $08, $02, $42, $21, $00, $82, $7F, $02, $42, $37, $02, $42, $00, $7F, $02, $42
        .byte $30, $02, $42, $22, $00, $82, $0E, $02, $42, $00, $70, $02, $42, $70, $02, $42
        .byte $00

      aUnknown9FDC77 .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicCenterOnTargetInit, rlHDMAMapMagicNoOp2, aHDMAUnknown9FDB6ACode, aUnknown9FDCD3, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DC77

        ; Shared by 14 effects.
    .endsection Unsorted9FDC40Section


    .section Unsorted9FDC83Section

      .al
      .xl

      rlHDMAMapMagicCenterOnTargetInit ; 9F/DC83

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda $7F57FF
        sta $7F50D1
        lda $7F5800
        clc
        adc #$FFFF
        sta $7F50D3
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc #$0080
        eor #$FFFF
        inc a
        sta $7F50CD
        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc #$0070
        eor #$FFFF
        inc a
        sta $7F50CF
        ldy #$DCED
        lda wMapMagicFlags
        bmi _DCCE
        and #$0400
        beq _DCD2
        ldy #$DCE0

        _DCCE
        tya
        sta aHDMASystem.aOffset,b,x

        _DCD2
        rtl

        .databank 0

        ; 9F/DCD3


      aUnknown9FDCD3 ; 9F/DCD3

        .byte $08, $CD, $50, $21, $D1, $50, $7F, $CD, $50, $37, $CD, $50, $00, $7F, $CD, $50
        .byte $30, $CD, $50, $22, $D1, $50, $0E, $CD, $50, $00, $70, $CD, $50, $70, $CD, $50
        .byte $00

      aUnknown9FDCF4 .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicMeteorInit, rlHDMAMapMagicNoOp2, aHDMAUnknown9FDB6ACode, aUnknown9FDDEA, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DCF4

        ; Part of the Meteor effect.
      rlHDMAMapMagicMeteorInit ; 9F/DD00

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0000
        sta $7F50DD
        lda #$0200
        sta $7F50D5
        lda #$FC8A
        sta $7F50D7
        lda wMapMagicTargetPixel
        and #$00FF
        cmp #$00A0
        bmi _DD67
        lda #$FE00
        sta $7F50D5
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta wR10
        lda #$0093
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc wR12+1
        clc
        adc #$0008
        and #$00FF
        sta wR0
        sta $7F50CD
        sec
        sbc #$0080
        xba
        eor #$FFFF
        inc a
        sta $7F50D9
        lda #$6000
        sta $7F50DB
        bra _DDA1


        _DD67
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta wR10
        lda #$0093
        sta wR11
        jsl rlUnsignedMultiply16By16
        lda wMapMagicTargetPixel
        clc
        adc wR12+1
        clc
        adc #$FFF8
        and #$00FF
        sta wR0
        sta $7F50CD
        sec
        sbc #$0080
        xba
        eor #$FFFF
        inc a
        sta $7F50D9
        lda #$6000
        sta $7F50DB

        _DDA1
        lda wMapMagicTargetPixel
        and #$00FF
        sta wR1
        lda wR0
        sec
        sbc wR1
        sta wR0
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta wR1
        jsl rlGetVectorLength
        sta $7ECC0A
        lda $7F57FF
        sta $7F50D1
        lda $7F5800
        clc
        adc #$FFFF
        sta $7F50D3
        lda wMapMagicFlags
        and #$0400
        beq _DDE5
        lda #<>aUnknown9FDDF7
        sta aHDMASystem.aOffset,b,x

        _DDE5
        jsl rlHDMAMapMagicStepScrollY
        rtl

        .databank 0

      aUnknown9FDDEA ; 9F/DDEA

        ; Indirect HDMA tables: a line count, then a pointer into bank $7F; $00 ends.
        .byte $08
        .word $50CD
        .byte $21
        .word $50D1
        .byte $7F
        .word $50CD
        .byte $37
        .word $50CD
        .byte $00

      aUnknown9FDDF7 ; 9F/DDF7

        .byte $7F
        .word $50CD
        .byte $30
        .word $50CD
        .byte $22
        .word $50D1
        .byte $0E
        .word $50CD
        .byte $00

      rlHDMAMapMagicStepScrollY ; 9F/DE04

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.

        lda $7ECC0C
        beq _DE15
        lda #$0000
        sta $7F50D5
        sta $7F50D7

        _DE15
        lda $7F50D9
        clc
        adc $7F50D5
        sta $7F50D9
        xba
        bpl _DE2A
        ora #$FF00
        bra _DE2D


        _DE2A
        and #$00FF

        _DE2D
        sta $7F50CD
        lda $7F50DB
        clc
        adc $7F50D7
        sta $7F50DB
        xba
        bpl _DE46
        ora #$FF00
        bra _DE49


        _DE46
        and #$00FF

        _DE49
        sta $7F50CF
        rtl

        .databank 0

      aMapMagicVillageFireSpawnParams .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicWaveInit, rlHDMAMapMagicBuildWaveMed1, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DE4E
        .word $FDC0, $0130

      aMapMagicElfireSpawnParams .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicWaveInit, rlHDMAMapMagicBuildWaveMed2, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DE5E
        .word $FDC0, $01C0

      aMapMagicAuraSpawnParams .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicWaveInit, rlHDMAMapMagicBuildWaveSmall, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DE6E
        .word $FDF0, $02C0

      aMapMagicValflameSpawnParams .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicWaveInit, aUnknown9FDF58+26, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DE7E
        .word $0240, $FCC0

      aMapMagicForsetiSpawnParams .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicClearWaveBuffer, rlHDMAMapMagicBuildRippleWave, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DE8E
        .word $0000, $0000

      aMapMagicBlizzardSpawnParams .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicWaveInit, aUnknown9FDF58+26, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DE9E
        .word $0100, $FC80

      aUnknown9FDEAE .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicWaveInit, aUnknown9FDF58+26, aHDMAUnknown9FDB6ACode, aUnknown9FDF58, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/DEAE
        .word $0000, $0030

      rlHDMAMapMagicClearWaveBuffer ; 9F/DEBE

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7F4C
        and #$01FF
        sta $2182,b
        lda #$4C89
        sta $2181,b
        ldy #$00E0
        sep #$20

        _DED2
        stz $2180,b
        stz $2180,b
        stz $2180,b
        stz $2180,b
        dec y
        bne _DED2
        rep #$20

        .databank 0

    .endsection Unsorted9FDC83Section


    .section Unsorted9FDEE3Section

      .al
      .xl

      rlHDMAMapMagicWaveInit ; 9F/DEE3

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        ldy aHDMASystem.aTypeOffset,b,x
        lda $000C,b,y
        sta $7F50D5
        lda $000E,b,y
        sta $7F50D7
        lda #$0000
        sta $7F50DD
        lda #$0078
        sta $7F50D9
        lda #$0000
        sta $7F50DB
        lda $7F57FF
        sta $7F50D1
        lda $7F5800
        clc
        adc #$FFFF
        sta $7F50D3
        lda wMapMagicFlags
        and #$0400
        beq _DF2C
        lda #<>aUnknown9FDF65
        sta aHDMASystem.aOffset,b,x

        _DF2C
        lda $7F50CD
        sta wR0
        lda $7F50CF
        sta wR1
        phb
        pea #$7F7F
        plb
        .databank ?
        plb
        .databank ?
        ldx #$0000

        _DF41
        lda wR0
        sta $546A,b,x
        lda wR1
        sta $546C,b,x
        txa
        clc
        adc #$0004
        tax
        cpx #$0380
        bne _DF41
        plb
        .databank ?
        rtl

        .databank 0

        ; 9F/DF58


      aUnknown9FDF58 ; 9F/DF58

        ; Indirect HDMA tables: a line count, then a pointer into bank $7F; $00 ends.
        .byte $88
        .word $546A
        .byte $21
        .word $50D1
        .byte $FF
        .word $550E
        .byte $B7
        .word $570A
        .byte $00

      aUnknown9FDF65 ; 9F/DF65

        .byte $FF
        .word $546A
        .byte $B0
        .word $5666
        .byte $22
        .word $50D1
        .byte $8E
        .word $57AE
        .byte $00

        ; Unreferenced.
        .byte $9B

      rlHDMAMapMagicStepScrollYAltUnused ; 9F/DF73

        .al
        .xl
        .autsiz
        .databank ?

        phb
        pea #$7F7F
        plb
        .databank ?
        plb
        .databank ?
        lda $50D9,b
        clc
        adc $50D5,b
        sta $50D9,b
        xba
        bpl _DF8B
        ora #$FF00
        bra _DF8E


        _DF8B
        and #$00FF

        _DF8E
        sta wR0
        lda $50DB,b
        clc
        adc $50D7,b
        sta $50DB,b
        xba
        bpl _DFA2
        ora #$FF00
        bra _DFA5


        _DFA2
        and #$00FF

        _DFA5
        sta wR1
        lda $50DD,b
        clc
        adc #$0002
        cmp #$0020
        bmi _DFB6
        lda #$0000

        _DFB6
        sta $50DD,b
        tax
        lda $50CD,b
        sta wR2
        lda $50CF,b
        sta wR3
        ldy #$0000

        _DFC7
        lda aHDMAMapMagicScrollYAltStepsUnused,x
        clc
        adc wR0
        clc
        adc wR2
        and #$01FF
        sta $546A,b,y
        lda wR3
        clc
        adc wR1
        and #$01FF
        sta $546C,b,y
        txa
        clc
        adc #$0002
        tax
        tya
        clc
        adc #$0004
        tay
        cpy #$0380
        bne _DFC7
        plb
        .databank ?
        rtl

        .databank 0

      rlHDMAMapMagicBuildWaveSmall ; 9F/DFF5

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta wR6
        lda #$0006
        sta wR7
        lda #$0002
        sta wR8

        .databank 0
        bra rlHDMAMapMagicBuildSineWave

    .endsection Unsorted9FDEE3Section


    .section Unsorted9FE006Section

      .al
      .xl

      rlHDMAMapMagicBuildWaveMed1 ; 9F/E006

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta wR6
        lda #$000A
        sta wR7
        lda #$002C
        sta wR8
        bra rlHDMAMapMagicBuildSineWave

        .databank 0

      rlHDMAMapMagicBuildWaveMed2 ; 9F/E017

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0003
        sta wR6
        lda #$000A
        sta wR7
        lda #$0030
        sta wR8

        .databank 0

      rlHDMAMapMagicBuildSineWave ; 9F/E026

        .al
        .xl
        .autsiz
        .databank ?
        txy
        phb
        pea #$7F7F
        plb
        .databank ?
        plb
        .databank ?
        lda $50D9,b
        clc
        adc $50D5,b
        sta $50D9,b
        xba
        bpl _E03F
        ora #$FF00
        bra _E042


        _E03F
        and #$00FF

        _E042
        sta wR2
        lda $50DB,b
        clc
        adc $50D7,b
        sta $50DB,b
        xba
        bpl _E056
        ora #$FF00
        bra _E059


        _E056
        and #$00FF

        _E059
        sta wR3
        lda $50DD,b
        clc
        adc wR8
        and #$00FF
        sta $50DD,b
        sta wR0
        lda $50CD,b
        sta wR4
        lda $50CF,b
        sta wR5
        ldy #$0000

        _E076
        lda wR6
        jsl rlMultiplyByNegSinMode7
        clc
        adc wR2
        clc
        adc wR4
        and #$01FF
        sta $546A,b,y
        lda wR5
        clc
        adc wR3
        and #$01FF
        sta $546C,b,y
        lda wR0
        clc
        adc wR7
        and #$00FF
        sta wR0
        tya
        clc
        adc #$0004
        tay
        cpy #$0380
        bne _E076
        plb
        .databank ?
        rtl

        .databank 0

      rlHDMAMapMagicBuildRippleWave ; 9F/E0AA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        txy
        phb
        pea #$7F7F
        plb
        .databank ?
        plb
        .databank ?
        lda $50CD,b
        sta wR4
        lda $50CF,b
        sta wR5
        lda $7ECC40
        clc
        adc #$0008
        and #$00FF
        sta $7ECC40
        sta wR0
        ldy #$0000
        ldx #$0000

        _E0D3
        lda @l aHDMAMapMagicRippleWave,x
        asl a
        asl a
        asl a
        asl a
        asl a
        sta wR6
        lda $4C89,b,y
        clc
        adc @l aHDMAMapMagicRippleWave,x
        cmp wR6
        bmi _E0EC
        lda wR6

        _E0EC
        sta $4C89,b,y
        xba
        and #$00FF
        clc
        adc $546A,b,y
        and #$01FF
        sta $546A,b,y
        lda wR5
        and #$01FF
        sta $546C,b,y
        txa
        clc
        adc #$0002
        tax
        tya
        clc
        adc #$0004
        tay
        cpy #$0380
        bne _E0D3
        plb
        .databank ?
        plx
        rtl

        .databank 0

      aHDMAMapMagicRippleWave ; 9F/E119

        .word $00EE, $00EC, $00EA, $00E8, $00E6, $00E4, $00E2, $00E0
        .word $00DE, $00DC, $00DA, $00D8, $00D6, $00D4, $00D2, $00D0
        .word $00CE, $00CC, $00CA, $00C8, $00C6, $00C4, $00C2, $00C0
        .word $00BE, $00BC, $00BA, $00B8, $00B6, $00B4, $00B2, $00B0
        .word $00AE, $00AC, $00AA, $00A8, $00A6, $00A4, $00A2, $00A0
        .word $009E, $009C, $009A, $0098, $0096, $0094, $0092, $0090
        .word $008E, $008C, $008A, $0088, $0086, $0084, $0082, $0080
        .word $007E, $007C, $007A, $0078, $0076, $0074, $0072, $0070
        .word $006E, $006C, $006A, $0068, $0066, $0064, $0062, $0060
        .word $005E, $005C, $005A, $0058, $0056, $0054, $0052, $0050
        .word $004E, $004C, $004A, $0048, $0046, $0044, $0042, $0040
        .word $003E, $003C, $003A, $0038, $0036, $0034, $0032, $0030
        .word $002E, $002C, $002A, $0028, $0026, $0024, $0022, $0020
        .word $001E, $001C, $001A, $0018, $0016, $0014, $0012, $0010
        .word $0010, $0012, $0014, $0016, $0018, $001A, $001C, $001E
        .word $0020, $0022, $0024, $0026, $0028, $002A, $002C, $002E
        .word $0030, $0032, $0034, $0036, $0038, $003A, $003C, $003E
        .word $0040, $0042, $0044, $0046, $0048, $004A, $004C, $004E
        .word $0050, $0052, $0054, $0056, $0058, $005A, $005C, $005E
        .word $0060, $0062, $0064, $0066, $0068, $006A, $006C, $006E
        .word $0070, $0072, $0074, $0076, $0078, $007A, $007C, $007E
        .word $0080, $0082, $0084, $0086, $0088, $008A, $008C, $008E
        .word $0090, $0092, $0094, $0096, $0098, $009A, $009C, $009E
        .word $00A0, $00A2, $00A4, $00A6, $00A8, $00AA, $00AC, $00AE
        .word $00B0, $00B2, $00B4, $00B6, $00B8, $00BA, $00BC, $00BE
        .word $00C0, $00C2, $00C4, $00C6, $00C8, $00CA, $00CC, $00CE
        .word $00D0, $00D2, $00D4, $00D6, $00D8, $00DA, $00DC, $00DE
        .word $00E0, $00E2, $00E4, $00E6, $00E8, $00EA, $00EC, $00EE

      aUnknown9FE2D9 .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicScrollDownInit, rlHDMAMapMagicStepBG2VOFS, aHDMAUnknown9FDB6ACode, aUnknown9FE357, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/E2D9

        ; Shared by the Hel and Restore effects.
      aUnknown9FE2E5 .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicScrollUpInit, rlHDMAMapMagicStepBG2VOFS, aHDMAUnknown9FDB6ACode, aUnknown9FE357, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, true, DMAP_Mode3), $7F ; 9F/E2E5

        ; Part of the Sleep effect.
      rlHDMAMapMagicScrollUpInit ; 9F/E2F1

        .al
        .xl
        .autsiz
        .databank ?

        lda #$FFD0
        bra rlHDMAMapMagicScrollDownInit._E2F9

        .databank 0

      rlHDMAMapMagicScrollDownInit ; 9F/E2F6

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0100

        _E2F9
        sta $7F50DB
        lda #$0000
        sta $7F50D7
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc #$0080
        eor #$FFFF
        inc a
        sta $7F50CD
        lda $7F57FF
        sta $7F50D1
        lda $7F5800
        clc
        adc #$FFFF
        sta $7F50D3
        ldy #<>aUnknown9FE371
        lda wMapMagicFlags
        bmi _E33C
        and #$0400
        beq _E340
        ldy #<>aUnknown9FE364

        _E33C
        tya
        sta aHDMASystem.aOffset,b,x

        _E340
        rtl

        .databank 0

      rlHDMAMapMagicStepBG2VOFS ; 9F/E341

        .al
        .xl
        .autsiz
        .databank ?

        lda $7F50D7
        clc
        adc $7F50DB
        sta $7F50D7
        xba
        and #$00FF
        sta $7F50CF
        rtl

        .databank 0

      aUnknown9FE357 ; 9F/E357

        .byte $08, $CD, $50, $21, $D1, $50, $7F, $CD, $50, $37, $CD, $50, $00

      aUnknown9FE364 ; 9F/E364

        .byte $7F, $CD, $50, $30, $CD, $50, $22, $D1, $50, $0E, $CD, $50, $00

      aUnknown9FE371 ; 9F/E371

        .byte $70, $CD, $50, $70, $CD, $50, $00

      aUnknown9FE378 .dstruct structHDMAIndirectEntryInfo, rlHDMAMapMagicNoOp1, rlHDMAMapMagicNoOp2, aHDMAUnknown9FE384Code, aUnknown9FE393, PPU_REG_BASE + $0F, DMAP_HDMA_Setting(DMAP_CPUToIO, false, DMAP_Mode2), $9F ; 9F/E378

        ; Part of the Hel effect.
      aHDMAUnknown9FE384Code ; 9F/E384

        HDMA_SET_TABLE_BANK $9F
        HDMA_YIELD 1, aUnknown9FE393

        _E38B
        HDMA_YIELD 2, aUnknown9FE393
        HDMA_JUMP _E38B

      aUnknown9FE393 ; 9F/E393

        .byte $01, $00, $00, $01, $00, $00, $01, $01, $00, $01, $01, $00, $01, $02, $00, $01
        .byte $02, $00, $01, $03, $00, $01, $03, $00, $01, $00, $00, $01, $00, $00, $01, $00
        .byte $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00
        .byte $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01
        .byte $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00
        .byte $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00
        .byte $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01
        .byte $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $01
        .byte $00, $01, $01, $00, $01, $02, $00, $01, $02, $00, $01, $03, $00, $01, $03, $00
        .byte $01, $03, $00, $01, $03, $00, $01, $02, $00, $01, $02, $00, $01, $01, $00, $01
        .byte $01, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $01, $00, $01, $01, $FF
        .byte $01, $01, $FF, $01, $01, $FE, $01, $01, $FE, $01, $01, $FD, $01, $01, $FD, $01
        .byte $01, $FD, $01, $01, $FD, $01, $01, $FE, $01, $01, $FE, $01, $01, $FF, $01, $01
        .byte $FF, $01, $01, $00, $01, $01, $00, $01, $01, $00, $00, $01, $00, $00, $01, $01
        .byte $00, $01, $01, $00, $01, $02, $00, $01, $02, $00, $01, $03, $00, $01, $03, $00
        .byte $01, $03, $00, $01, $03, $00, $01, $02, $00, $01, $02, $00, $01, $01, $00, $01
        .byte $01, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $01, $00, $01, $01, $FF
        .byte $01, $01, $FF, $01, $01, $FE, $01, $01, $FE, $01, $01, $FD, $01, $01, $FD, $01
        .byte $01, $FD, $01, $01, $FD, $01, $01, $FE, $01, $01, $FE, $01, $01, $FF, $01, $01
        .byte $FF, $01, $01, $00, $01, $01, $00, $01, $01, $00, $00, $01, $00, $00, $01, $01
        .byte $00, $01, $01, $00, $01, $02, $00, $01, $02, $00, $01, $03, $00, $01, $03, $00
        .byte $01, $03, $00, $01, $03, $00, $01, $02, $00, $01, $02, $00, $01, $01, $00, $01
        .byte $01, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $01, $00, $01, $01, $FF
        .byte $01, $01, $FF, $01, $01, $FE, $01, $01, $FE, $01, $01, $FD, $01, $01, $FD, $01
        .byte $01, $FD, $01, $01, $FD, $01, $01, $FE, $01, $01, $FE, $01, $01, $FF, $01, $01
        .byte $FF, $01, $01, $00, $01, $01, $00, $01, $01, $00, $00, $01, $00, $00, $01, $01
        .byte $00, $01, $01, $00, $01, $02, $00, $01, $02, $00, $01, $03, $00, $01, $03, $00
        .byte $01, $03, $00, $01, $03, $00, $01, $02, $00, $01, $02, $00, $01, $01, $00, $01
        .byte $01, $00, $01, $00, $00, $01, $00, $00, $01, $00, $01, $01, $00, $01, $01, $FF
        .byte $01, $01, $FF, $01, $01, $FE, $01, $01, $FE, $01, $01, $FD, $01, $01, $FD, $01
        .byte $01, $FD, $01, $01, $FD, $01, $01, $FE, $01, $01, $FE, $01, $01, $FF, $01, $01
        .byte $FF, $01, $01, $00, $01, $01, $00, $01, $01, $00, $00, $01, $00, $00, $01, $01
        .byte $00, $01, $01, $00, $01, $02, $00, $01, $02, $00, $01, $03, $00, $01, $03, $00
        .byte $01, $03, $00, $01, $03, $00, $01, $02, $00, $01, $02, $00, $01, $01, $00, $01
        .byte $01, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00
        .byte $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00
        .byte $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01
        .byte $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00
        .byte $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00
        .byte $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01
        .byte $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00
        .byte $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00, $01, $00, $00
        .byte $00

      aHDMAMapMagicScrollYAltStepsUnused ; 9F/E634

        .word $0000, $0000, $0001, $0001, $0002, $0002, $0003, $0003
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0001, $0001, $0002, $0002, $0003, $0003
        .word $0003, $0003, $0002, $0002, $0001, $0001, $0000, $0000
        .word $0100, $0100, $01FF, $01FF, $01FE, $01FE, $01FD, $01FD
        .word $01FD, $01FD, $01FE, $01FE, $01FF, $01FF, $0100, $0100
        .word $0000, $0000, $0001, $0001, $0002, $0002, $0003, $0003
        .word $0003, $0003, $0002, $0002, $0001, $0001, $0000, $0000
        .word $0100, $0100, $01FF, $01FF, $01FE, $01FE, $01FD, $01FD
        .word $01FD, $01FD, $01FE, $01FE, $01FF, $01FF, $0100, $0100
        .word $0000, $0000, $0001, $0001, $0002, $0002, $0003, $0003
        .word $0003, $0003, $0002, $0002, $0001, $0001, $0000, $0000
        .word $0100, $0100, $01FF, $01FF, $01FE, $01FE, $01FD, $01FD
        .word $01FD, $01FD, $01FE, $01FE, $01FF, $01FF, $0100, $0100
        .word $0000, $0000, $0001, $0001, $0002, $0002, $0003, $0003
        .word $0003, $0003, $0002, $0002, $0001, $0001, $0000, $0000
        .word $0100, $0100, $01FF, $01FF, $01FE, $01FE, $01FD, $01FD
        .word $01FD, $01FD, $01FE, $01FE, $01FF, $01FF, $0100, $0100
        .word $0000, $0000, $0001, $0001, $0002, $0002, $0003, $0003
        .word $0003, $0003, $0002, $0002, $0001, $0001, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0001, $0001, $0002, $0002, $0003, $0003
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000
        .word $0000, $0000, $0000, $0000, $0000, $0000, $0000, $0000

        ; 9F/E824

    .endsection Unsorted9FE006Section


    .section Unsorted9FE824Section

      .al
      .xl

      rlMapMagicBuildForsetiWindowHDMA ; 9F/E824

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Forseti effect.

        phx
        lda #$00E0
        sta @l wR0
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda lR18
        sta $2181,b
        lda $7F50DF
        and #$00FF
        sta wR1
        lda $7F50E1
        sta wR2
        lda $7F50E3
        and #$00FF
        sta wR3
        lda $7F50E5
        sta wR4
        jsr rsMapMagicLookupCircleHalfWidth
        ldy #$0000
        lda wR3
        lsr a
        sta wR9
        lda wR2
        sec
        sbc wR9
        beq _E899
        bcc _E885
        tax
        sep #$20

        _E86E
        lda #$FF
        sta $2180,b
        lda #$00
        sta $2180,b
        dec wR0
        bne _E880
        jml _E8DA


        _E880
        dec x
        bne _E86E
        bra _E899


        _E885
        .al
        rep #$20
        eor #$FFFF
        inc a
        and #$00FF
        asl a
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        pla
        tay

        _E899
        sep #$20

        _E89B
        jsr rsMapMagicWriteWindowBoundsPair
        dec wR0
        beq _E8DA
        inc y
        inc y
        cpy wR3
        bcs _E8B2
        rep #$20
        dec wR4
        beq _E8B2
        sep #$20
        bra _E89B


        _E8B2
        dec y
        dec y
        cpy #$0000
        bmi _E8CA
        jsr rsMapMagicWriteWindowBoundsPair
        dec wR0
        beq _E8DA
        rep #$20
        dec wR4
        beq _E8CA
        sep #$20
        bra _E8B2


        _E8CA
        sep #$20

        _E8CC
        lda #$FF
        sta $2180,b
        lda #$00
        sta $2180,b
        dec wR0
        bne _E8CC

        _E8DA
        rep #$20
        plx
        rtl

        .databank 0

        ; 9F/E8DE

      rlMapMagicBuildStaffWindowHDMA ; 9F/E8DE

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Restore, Return and Sleep effects.

        phx
        sta wR0
        tya
        sta wR5
        lda $7F50DF,x
        and #$00FF
        sta wR1
        lda $7F50E1,x
        sta wR2
        lda $7F50E3,x
        sta wR3
        lda $7F50E5,x
        sta wR4
        phd
        pea #$0000
        pld
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda lR18
        sta $2181,b
        lda $7F50DF,x
        and #$00FF
        sta wR1
        lda $7F50E1,x
        sec
        sbc #$0010
        sta wR2
        lda $7F50E3,x
        and #$00FF
        sta wR3
        lda $7F50E5,x
        sta wR4
        lda wR3
        jsr rsMapMagicCalcStaffCircleRow
        pha
        sep #$20
        lda wR1
        clc
        adc #1,s
        bcs _E946
        cmp #$F7
        bcc _E948

        _E946
        lda #$F7

        _E948
        xba
        lda wR1
        sec
        sbc #1,s
        bcc _E954
        cmp #$08
        bcs _E956

        _E954
        lda #$08

        _E956
        rep #$20
        sta wR5
        pla
        jsr rsMapMagicLookupCircleHalfWidth
        ldy #$0000
        sep #$20
        lda wR2
        sec
        sbc wR3
        beq _E9A7
        bcc _E993
        cmp #$DF
        bcc _E974
        jml _E9F7


        _E974
        rep #$20
        and #$00FF
        tax
        sep #$20

        _E97C
        lda wR5
        sta $2180,b
        lda wR5+1
        sta $2180,b
        dec wR0
        bne _E98E
        jml _EA07


        _E98E
        dec x
        bne _E97C
        bra _E9A7


        _E993
        rep #$20
        eor #$FFFF
        inc a
        and #$00FF
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        ply
        sep #$20

        _E9A7
        lda wR5
        sta $2180,b
        lda wR5+1
        sta $2180,b
        dec wR0
        beq _EA07
        inc y
        cpy wR3
        bcs _E9C4
        rep #$20
        dec wR4
        beq _E9DB
        sep #$20
        bra _E9A7


        _E9C4
        dec y
        cpy #$0000
        bmi _E9F7
        jsr rsMapMagicWriteWindowBoundsPair
        dec wR0
        beq _EA07
        rep #$20
        dec wR4
        beq _E9DB
        sep #$20
        bra _E9C4


        _E9DB
        .al
        and #$00FF
        sta wR3
        tay
        jsr rsMapMagicLookupCircleHalfWidth
        sep #$20

        _E9E6
        dec y
        dec y
        dec y
        cpy #$0000
        bmi _E9F7
        jsr rsMapMagicWriteWindowBoundsPair
        dec wR0
        beq _EA07
        bra _E9E6


        _E9F7
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        beq _EA07
        bra _E9F7


        _EA07
        rep #$20
        pld
        plx
        rtl

        .databank 0

        ; 9F/EA0C

    .endsection Unsorted9FE824Section


    .section Unsorted9FEA0CSection

      .al
      .xl

      rsMapMagicCalcStaffCircleRow ; 9F/EA0C

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Restore, Return and Sleep effects.

        phx
        pha
        bit #$0080
        beq _EA1E
        and #$FF78
        lsr a
        lsr a
        clc
        adc #$0080
        bra _EA3C


        _EA1E
        bit #$0040
        beq _EA2D
        and #$FFBC
        lsr a
        clc
        adc #$0060
        bra _EA3C


        _EA2D
        bit #$0020
        beq _EA3B
        and #$FFDE
        clc
        adc #$0040
        bra _EA3C


        _EA3B
        asl a

        _EA3C
        tax
        lda aBattleSceneWindowShapes,x
        clc
        adc #1,s
        dec a
        tax
        lda aBattleSceneWindowShapes,x
        and #$00FF
        sta #1,s
        pla
        plx
        rts

        .databank 0

        ; 9F/EA52

    .endsection Unsorted9FEA0CSection


    .section Unsorted9FEA52Section

      .al
      .xl

      rlMapMagicBuildCircleWindowHDMA ; 9F/EA52

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 17 effects.

        phx
        sta wR0
        lda lR18+1
        and #$01FF
        sta $2182,b
        lda lR18
        sta $2181,b
        lda $7F50DF
        and #$00FF
        sta wR1
        lda $7F50E1
        sta wR2
        lda $7F50E3
        sta wR3
        lda $7F50E5
        sta wR4
        jsr rsMapMagicLookupCircleHalfWidth
        ldy #$0000
        sep #$20
        lda wR2
        sec
        sbc wR3
        beq _EAD1
        bcc _EABC
        cmp #$DF
        bcc _EA96
        jml _EB18


        _EA96
        rep #$20
        and #$00FF
        tax
        lda wR3
        bne _EAA3
        ldx #$00E0

        _EAA3
        sep #$20

        _EAA5
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        bne _EAB7
        jml _EB26


        _EAB7
        dec x
        bne _EAA5
        bra _EAD1


        _EABC
        rep #$20
        eor #$FFFF
        inc a
        and #$00FF
        pha
        lda wR4
        sec
        sbc #1,s
        sta wR4
        pla
        tay
        sep #$20

        _EAD1
        jsr rsMapMagicWriteWindowBoundsPair
        dec wR0
        beq _EB26
        inc y
        cpy wR3
        bcs _EAE7
        rep #$20
        dec wR4
        beq _EAFE
        sep #$20
        bra _EAD1


        _EAE7
        dec y
        cpy #$0000
        bmi _EB18
        jsr rsMapMagicWriteWindowBoundsPair
        dec wR0
        beq _EB26
        rep #$20
        dec wR4
        beq _EAFE
        sep #$20
        bra _EAE7


        _EAFE
        .al
        and #$85FF
        asl $A8
        jsr rsMapMagicLookupCircleHalfWidth
        sep #$20

        _EB08
        dec y
        dec y
        cpy #$0000
        bmi _EB18
        jsr rsMapMagicWriteWindowBoundsPair
        dec wR0
        bne _EB08
        bra _EB26


        _EB18
        lda #$80
        sta $2180,b
        lda #$7F
        sta $2180,b
        dec wR0
        bne _EB18

        _EB26
        rep #$20
        plx
        rtl

        .databank 0

        ; 9F/EB2A

      rsMapMagicWriteWindowBoundsPair ; 9F/EB2A

        .as
        .xl
        .autsiz
        .databank ?
        ; Shared by 21 effects.

        lda [lR19],y
        pha
        lda wR1
        sec
        sbc #1,s
        bcc _EB38
        cmp #$08
        bcs _EB3A

        _EB38
        lda #$08

        _EB3A
        sta $2180,b
        lda wR1
        clc
        adc #1,s
        bcs _EB48
        cmp #$F7
        bcc _EB4A

        _EB48
        lda #$F7

        _EB4A
        sta $2180,b
        pla
        rts

        .databank 0

        ; 9F/EB4F

      rsMapMagicLookupCircleHalfWidth ; 9F/EB4F

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 21 effects.

        phx
        lda #$9A00
        sta lR19+1
        lda wR3
        bit #$0080
        beq _EB6E
        pha
        and #$FFF8
        sta wR3
        pla
        and #$FF78
        lsr a
        lsr a
        clc
        adc #$0080
        bra _EB9A


        _EB6E
        bit #$0040
        beq _EB84
        pha
        and #$FFFC
        sta wR3
        pla
        and #$FFBC
        lsr a
        clc
        adc #$0060
        bra _EB9A


        _EB84
        bit #$0020
        beq _EB99
        pha
        and #$FFFE
        sta wR3
        pla
        and #$FFDE
        clc
        adc #$0040
        bra _EB9A


        _EB99
        asl a

        _EB9A
        tax
        lda aBattleSceneWindowShapes,x
        clc
        adc #$A30A
        sta lR19
        plx
        rts

        .databank 0

        ; 9F/EBA7

    .endsection Unsorted9FEA52Section


    .section Unsorted9FEBA7Section

      .al
      .xl

      rlProcMapMagicEffectInit ; 9F/EBA7

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9F/EBA8

    .endsection Unsorted9FEBA7Section


    .section Unsorted9FEBA8Section

      .al
      .xl

      rlMapMagicUnusedStub ; 9F/EBA8

        .al
        .xl
        .autsiz
        .databank ?

        ; Unreferenced.
        rtl

        .databank 0

    .endsection Unsorted9FEBA8Section


    .section ProcScript9FEBA9Section

      .al
      .xl

      aProcMapMagicHaltCode ; 9F/EBA9

        PROC_HALT


        ; 9F/EBAB


      procMapMagicFireWindow ; 9F/EBAB

        .structProcInfo "ON", rlMapMagicScrollWindowInit, rlMapMagicFireWindowCycle, aProcMapMagicHaltCode

        .byte $10, $00, $01, $00, $00, $00, $00

      procMapMagicElfireWindow ; 9F/EBBA

        ; Part of the Elfire effect.
        .structProcInfo "ON", rlMapMagicScrollWindowInit, rlMapMagicElfireWindowCycle, aProcMapMagicHaltCode

        .byte $10, $00, $01, $00, $00, $00, $00

      procMapMagicAuraWindow ; 9F/EBC9

        ; Part of the Aura effect.
        .structProcInfo "ON", rlMapMagicAuraWindowInit, rlMapMagicAuraWindowCycle, aProcMapMagicHaltCode

        .byte $18, $00, $12, $00, $00, $00, $00

      procMapMagicCircleWindow ; 9F/EBD8

        ; Shared by the Heal, Light, Mend, Physic and Recover effects.
        .structProcInfo "ON", rlMapMagicCircleWindowInit, rlMapMagicCircleWindowCycle, aProcMapMagicHaltCode

        .byte $12, $00, $01, $00, $00, $00, $00

      procMapMagicThunderWindow ; 9F/EBE7

        ; Part of the Thunder effect.
        .structProcInfo "ON", rlMapMagicCircleWindowInit, rlMapMagicCircleWindowCycle, aProcMapMagicHaltCode

        .byte $18, $01, $02, $00, $00, $00, $00

      procMapMagicNosferatuOrb ; 9F/EBF6

        ; Part of the Nosferatu effect.
        .structProcInfo "ON", rlMapMagicNosferatuOrbInit, rlMapMagicNosferatuOrbGrow, aProcMapMagicHaltCode

      procMapMagicMjolnirWindow ; 9F/EBFE

        ; Part of the Mjolnir effect.
        .structProcInfo "ON", rlMapMagicMjolnirWindowSetDelay, rlMapMagicMjolnirWindowCycle, aProcMapMagicHaltCode

        .byte $18, $00, $01, $00, $00, $00, $00

      procMapMagicFortifyWindow ; 9F/EC0D

        ; Part of the Fortify effect.
        .structProcInfo "ON", rlMapMagicCircleWindowInit, rlMapMagicCircleWindowCycle, aProcMapMagicHaltCode

        .byte $80, $00, $10, $00, $00, $00, $00

      procMapMagicFenrirWindow ; 9F/EC1C

        ; Part of the Fenrir effect.
        .structProcInfo "ON", rlMapMagicCircleWindowInit, rlMapMagicCircleWindowCycle, aProcMapMagicHaltCode

        .byte $60, $00, $02, $00, $00, $D4, $00

      procMapMagicBerserkWindow ; 9F/EC2B

        ; Part of the Berserk effect.
        .structProcInfo "ON", rlMapMagicCircleWindowInit, rlMapMagicCircleWindowCycle, aProcMapMagicHaltCode

        .byte $20, $00, $01, $00, $00, $00, $00

      procMapMagicBlizzardHelWindow ; 9F/EC3A

        ; Shared by the Blizzard and Hel effects.
        .structProcInfo "ON", rlMapMagicCircleWindowInit, rlMapMagicCircleWindowCycle, aProcMapMagicHaltCode

        .byte $18, $01, $01, $00, $00, $00, $00

      procMapMagicBolganoneWindow ; 9F/EC49

        ; Part of the Bolganone effect.
        .structProcInfo "ON", rlMapMagicCircleWindowInit, rlMapMagicCircleWindowCycle, aProcMapMagicHaltCode

        .byte $30, $01, $10, $00, $00, $F0, $FF

      procMapMagicThoronWindow ; 9F/EC58

        ; Part of the Thoron effect.
        .structProcInfo "ON", rlMapMagicCircleWindowInit, rlMapMagicCircleWindowCycle, aProcMapMagicHaltCode

        .byte $1E, $00, $01, $00, $00, $00, $00

      procMapMagicStaffWindow ; 9F/EC67

        ; Shared by the Restore, Return and Sleep effects.
        .structProcInfo "ON", rlMapMagicStaffWindowInit, rlMapMagicStaffWindowWaitGrow, aProcMapMagicHaltCode

        .byte $0C, $30, $00, $00, $00, $0E, $00

      procMapMagicForsetiWindow ; 9F/EC76

        ; Part of the Forseti effect.
        .structProcInfo "ON", rlMapMagicCircleWindowInit, rlMapMagicForsetiWindowCycle, aProcMapMagicHaltCode

        .byte $F0, $00, $02, $00, $00, $00, $00

      procMapMagicSilenceWindow ; 9F/EC85

        ; Part of the Silence effect.
        .structProcInfo "ON", rlMapMagicCircleWindowInit, rlMapMagicSilenceStepBeamHDMA, aProcMapMagicHaltCode

        .byte $22, $00, $01, $00, $00, $00, $00

      procMapMagicCircleWindowUnused ; 9F/EC94

        .structProcInfo "ON", rlMapMagicCircleWindowInit, rlMapMagicCircleWindowCycle, aProcMapMagicHaltCode

        .byte $18, $01, $01, $00, $00, $00, $00

      procMapMagicMeteorWindow ; 9F/ECA3

        ; Part of the Meteor effect.
        .structProcInfo "ON", rlMapMagicScrollWindowInit, rlMapMagicMeteorWindowInit, aProcMapMagicHaltCode

        .byte $10, $00, $01, $00, $00, $00, $00

    .endsection ProcScript9FEBA9Section


    .section Unsorted9FECB2Section

      .al
      .xl

      rlMapMagicClearWindowBuffers ; 9F/ECB2

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 22 effects.

        phb
        pea #$7F7F
        plb
        .databank ?
        plb
        .databank ?
        ldx #$0000

        _ECBB
        lda #$00FF
        sta $50EA,b,x
        sta $50EC,b,x
        sta $50EE,b,x
        sta $50F0,b,x
        sta $50F2,b,x
        sta $50F4,b,x
        sta $50F6,b,x
        sta $50F8,b,x
        stz $52AA,b,x
        stz $52AC,b,x
        stz $52AE,b,x
        stz $52B0,b,x
        stz $52B2,b,x
        stz $52B4,b,x
        stz $52B6,b,x
        stz $52B8,b,x
        txa
        clc
        adc #$0010
        tax
        cpx #$01C0
        bne _ECBB
        plb
        .databank ?
        ldx aProcSystem.wOffset,b
        rtl

        .databank 0

        ; 9F/ECFE

      rlMapMagicScrollWindowInit ; 9F/ECFE

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Elfire and Meteor effects.

        jsl rlMapMagicCircleWindowInit
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc #$00F8
        eor #$FFFF
        inc a
        sta $7F50CD
        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc #$0000
        eor #$FFFF
        inc a
        sta $7F50CF
        rtl

        .databank 0

        ; 9F/ED29

    .endsection Unsorted9FECB2Section


    .section Unsorted9FED29Section

      .al
      .xl

      rlMapMagicAuraWindowInit ; 9F/ED29

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        jsl rlMapMagicCircleWindowInit
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc #$00DC
        eor #$FFFF
        inc a
        sta $7F50CD
        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc #$FFF0
        eor #$FFFF
        inc a
        sta $7F50CF
        rtl

        .databank 0

        ; 9F/ED54
      rlMapMagicMjolnirWindowSetDelay ; 9F/ED54

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        lda #$0020
        sta aProcSystem.aBody6,b,x

        .databank 0

        ; 9F/ED5A

    .endsection Unsorted9FED29Section


    .section Unsorted9FED5ASection

      .al
      .xl

      rlMapMagicCircleWindowInit ; 9F/ED5A

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 18 effects.

        txy
        ldx aProcSystem.aHeaderTypeOffset,b,y
        lda $0008,b,x
        and #$00FF
        sta aProcSystem.aBody3,b,y
        lda $0009,b,x
        and #$00FF
        sta aProcSystem.aBody5,b,y
        lda $000A,b,x
        and #$00FF
        sta aProcSystem.aBody4,b,y
        tyx
        lda #$0001
        sta aProcSystem.aBody0,b,x
        sta aProcSystem.aBody1,b,x
        lda #$0001
        sta aProcSystem.aBody2,b,x
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc #$0080
        eor #$FFFF
        inc a
        sta $7F50CD
        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc #$0070
        eor #$FFFF
        inc a
        sta $7F50CF
        jml rlMapMagicClearWindowBuffers

        .databank 0

        ; 9F/EDB3

      rlMapMagicCircleWindowCycle ; 9F/EDB3

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by 13 effects.

        dec aProcSystem.aBody1,b,x
        beq _EDBC
        jml _EE44


        _EDBC
        lda aProcSystem.aHeaderTypeOffset,b,x
        tax
        lda $000B,b,x
        sta wR0
        lda $000D,b,x
        sta wR1
        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody0,b,x
        sta aProcSystem.aBody1,b,x
        lda aProcSystem.aBody2,b,x
        clc
        adc aProcSystem.aBody4,b,x
        sta aProcSystem.aBody2,b,x
        cmp #$0001
        bpl _EDE8
        lda #$0000
        sta aProcSystem.aBody2,b,x

        _EDE8
        cmp aProcSystem.aBody3,b,x
        bmi _EDF3
        lda aProcSystem.aBody3,b,x
        sta aProcSystem.aBody2,b,x

        _EDF3
        lda wMapMagicTargetPixel
        and #$00FF
        clc
        adc wR0
        sta $7F50DF
        lda wMapMagicTargetPixel+1
        and #$00FF
        clc
        adc wR1
        sta $7F50E1
        lda aProcSystem.aBody5,b,x
        bne _EE22
        lda aProcSystem.aBody2,b,x
        sta $7F50E3
        asl a
        sta $7F50E5
        bra _EE2E


        _EE22
        lda aProcSystem.aBody2,b,x
        sta $7F50E3
        inc a
        sta $7F50E5

        _EE2E
        phy
        lda #$7F00
        sta lR18+1
        lda #$50EA
        sta lR18
        ldx #$0000
        lda #$00E0
        jsl rlMapMagicBuildCircleWindowHDMA
        ply

        _EE44
        rtl

        .databank 0

        ; 9F/EE45

    .endsection Unsorted9FED5ASection


    .section Unsorted9FEE45Section

      .al
      .xl

      rlMapMagicMjolnirWindowCycle ; 9F/EE45

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        dec aProcSystem.aBody1,b,x
        beq _EE4E
        jml _EF1C


        _EE4E
        lda aProcSystem.aHeaderTypeOffset,b,x
        tax
        lda $000B,b,x
        sta wR0
        lda $000D,b,x
        sta wR1
        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody0,b,x
        sta aProcSystem.aBody1,b,x
        lda aProcSystem.aBody2,b,x
        clc
        adc aProcSystem.aBody4,b,x
        sta aProcSystem.aBody2,b,x
        cmp #$0001
        bpl _EE7A
        lda #$0000
        sta aProcSystem.aBody2,b,x

        _EE7A
        cmp aProcSystem.aBody3,b,x
        bmi _EE85
        lda aProcSystem.aBody3,b,x
        sta aProcSystem.aBody2,b,x

        _EE85
        lda wMapMagicTargetPixel
        and #$00FF
        clc
        adc wR0
        sta $7F50DF
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc #$0080
        eor #$FFFF
        inc a
        sta $7F50CD
        lda wMapMagicTargetPixel+1
        and #$00FF
        clc
        adc wR1
        sta $7F50E1
        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc #$0070
        eor #$FFFF
        inc a
        sta $7F50CF
        lda aProcSystem.aBody5,b,x
        bne _EEDA
        lda aProcSystem.aBody2,b,x
        sta $7F50E3
        asl a
        sta $7F50E5
        bra _EEE6


        _EEDA
        lda aProcSystem.aBody2,b,x
        sta $7F50E3
        inc a
        sta $7F50E5

        _EEE6
        phy
        lda #$7F00
        sta lR18+1
        lda #$50EA
        sta lR18
        ldx #$0000
        lda #$00E0
        jsl rlMapMagicBuildCircleWindowHDMA
        ply
        ldx aProcSystem.wOffset,b
        dec aProcSystem.aBody6,b,x
        bne _EF1C
        lda #$0004
        sta aProcSystem.aBody4,b,x
        lda #$0060
        sta aProcSystem.aBody3,b,x
        lda #$0008
        sta aProcSystem.aBody6,b,x
        lda #<>rlMapMagicMjolnirWindowWaitExpand
        sta aProcSystem.aHeaderOnCycle,b,x

        _EF1C
        rtl

        .databank 0

        ; 9F/EF1D
      rlMapMagicMjolnirWindowWaitExpand ; 9F/EF1D

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        dec aProcSystem.aBody6,b,x
        bne rlMapMagicMjolnirWindowShrink
        lda #$0001
        sta $7ECC08
        lda #<>rlMapMagicMjolnirWindowWaitHold
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$0030
        sta aProcSystem.aBody6,b,x
        bra rlMapMagicMjolnirWindowShrink
        .databank 0

        ; 9F/EF37
      rlMapMagicMjolnirWindowWaitHold ; 9F/EF37

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        dec aProcSystem.aBody6,b,x
        bne rlMapMagicMjolnirWindowShrink
        lda #$001A
        sta aProcSystem.aBody3,b,x
        lda #<>rlMapMagicMjolnirWindowShrink
        sta aProcSystem.aHeaderOnCycle,b,x

        .databank 0

        ; 9F/EF48
      rlMapMagicMjolnirWindowShrink ; 9F/EF48

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Mjolnir effect.

        dec aProcSystem.aBody1,b,x
        beq _EF51
        jml _EFFF


        _EF51
        lda aProcSystem.aHeaderTypeOffset,b,x
        tax
        lda $000B,b,x
        sta wR0
        lda $000D,b,x
        sta wR1
        ldx aProcSystem.wOffset,b
        lda aProcSystem.aBody0,b,x
        sta aProcSystem.aBody1,b,x
        lda aProcSystem.aBody2,b,x
        clc
        adc aProcSystem.aBody4,b,x
        sta aProcSystem.aBody2,b,x
        cmp #$0001
        bpl _EF7D
        lda #$0000
        sta aProcSystem.aBody2,b,x

        _EF7D
        cmp aProcSystem.aBody3,b,x
        bmi _EF88
        lda aProcSystem.aBody3,b,x
        sta aProcSystem.aBody2,b,x

        _EF88
        lda wMapMagicTargetPixel
        and #$00FF
        clc
        adc wR0
        sta $7F50DF
        lda wMapMagicTargetPixel
        and #$00FF
        sec
        sbc #$0080
        eor #$FFFF
        inc a
        sta $7F50CD
        lda wMapMagicTargetPixel+1
        and #$00FF
        clc
        adc wR1
        sta $7F50E1
        lda wMapMagicTargetPixel+1
        and #$00FF
        sec
        sbc #$0070
        eor #$FFFF
        inc a
        sta $7F50CF
        lda aProcSystem.aBody5,b,x
        bne _EFDD
        lda aProcSystem.aBody2,b,x
        sta $7F50E3
        asl a
        sta $7F50E5
        bra _EFE9


        _EFDD
        lda aProcSystem.aBody2,b,x
        sta $7F50E3
        inc a
        sta $7F50E5

        _EFE9
        phy
        lda #$7F00
        sta lR18+1
        lda #$50EA
        sta lR18
        ldx #$0000
        lda #$00E0
        jsl rlMapMagicBuildCircleWindowHDMA
        ply

        _EFFF
        rtl

        .databank 0

        ; 9F/F000
      rlMapMagicMeteorWindowInit ; 9F/F000

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Meteor effect.

        lda #$0040
        sta wR1
        sta $7F50E3
        asl a
        sta $7F50E5
        lda $7F50CD
        eor #$FFFF
        inc a
        clc
        adc #$0080
        sta $7F50DF
        lda $7F50CF
        cmp #$FF98
        bpl _F02C
        lda #$0000
        bra _F034


        _F02C
        eor #$FFFF
        inc a
        clc
        adc #$0060

        _F034
        sta $7F50E1
        phy
        lda #$7F00
        sta lR18+1
        lda #$50EA
        sta lR18
        ldx #$0000
        lda #$00E0
        jsl rlMapMagicBuildCircleWindowHDMA
        ply
        rtl

        .databank 0

        ; 9F/F04F
      rlMapMagicElfireWindowCycle ; 9F/F04F

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Elfire effect.

        lda #$0012
        sta wR0
        lda #$003C
        sta wR1
        lda #$FFFE
        sta wR3
        bra rlMapMagicAuraWindowCycle._F07D

        .databank 0

        ; 9F/F060

    .endsection Unsorted9FEE45Section


    .section Unsorted9FF060Section

      .al
      .xl

      rlMapMagicFireWindowCycle ; 9F/F060

        ; Found through fe4.cdl.
        .al
        .xl
        .autsiz
        .databank ?

        lda #$000C
        sta wR0
        lda #$001E
        sta wR1
        lda #$FFFE
        sta wR3
        bra rlMapMagicAuraWindowCycle._F07D

      rlMapMagicAuraWindowCycle ; 9F/F071

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        .byte $A9, $0C, $00, $85, $00, $A9, $58, $00, $85, $02, $64, $06


        _F07D
        dec aProcSystem.aBody1,b,x
        beq _F086
        jml _F0DB


        _F086
        lda aProcSystem.aBody0,b,x
        sta aProcSystem.aBody1,b,x
        lda aProcSystem.aBody2,b,x
        clc
        adc aProcSystem.aBody4,b,x
        sta aProcSystem.aBody2,b,x
        cmp #$0001
        bpl _F0A1
        lda #$0001
        sta aProcSystem.aBody2,b,x

        _F0A1
        cmp aProcSystem.aBody3,b,x
        bmi _F0AC
        lda aProcSystem.aBody3,b,x
        sta aProcSystem.aBody2,b,x

        _F0AC
        lda wMapMagicTargetPixel
        and #$00FF
        sta $7F50DF
        lda wMapMagicTargetPixel+1
        and #$00FF
        clc
        adc wR0
        and #$01FF
        sta $7F50E1
        lda aProcSystem.aBody3,b,x
        sta $7F50E3
        phy
        lda wR1
        tay
        lda $7F50E3
        jsr rsMapMagicAuraDrawMask
        ply

        _F0DB
        rtl

        .databank 0

        ; 9F/F0DC

    .endsection Unsorted9FF060Section


    .section Unsorted9FF0DCSection

      .al
      .xl

      rlMapMagicStaffWindowInit ; 9F/F0DC

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Restore, Return and Sleep effects.

        txy
        ldx aProcSystem.aHeaderTypeOffset,b,y
        lda $0008,b,x
        and #$00FF
        sta aProcSystem.aBody3,b,y
        tyx
        lda #$0001
        sta aProcSystem.aBody0,b,x
        lda #$0001
        sta aProcSystem.aBody2,b,x
        lda #$0100
        sta aProcSystem.aBody3,b,x
        jml rlMapMagicClearWindowBuffers

        .databank 0

        ; 9F/F100

    .endsection Unsorted9FF0DCSection


    .section Unsorted9FF100Section

      .al
      .xl

      rlMapMagicStaffWindowWaitGrow ; 9F/F100

        ; Found by tools/sweep.py.
        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Restore, Return and Sleep effects.

        dec aProcSystem.aBody0,b,x
        bne rlMapMagicStaffWindowGrow
        lda #<>rlMapMagicStaffWindowGrow
        sta aProcSystem.aHeaderOnCycle,b,x
        lda #$00C0
        sta aProcSystem.aBody4,b,x

        .databank 0

      rlMapMagicStaffWindowGrow ; 9F/F111

        .al
        .xl
        .autsiz
        .databank ?
        ; Shared by the Restore, Return and Sleep effects.

        lda aProcSystem.aBody4,b,x
        clc
        adc aProcSystem.aBody3,b,x
        sta aProcSystem.aBody3,b,x
        cmp #$0100
        bpl _F126
        lda #$0000
        sta aProcSystem.aBody3,b,x

        _F126
        cmp #$0C00
        bmi _F131
        lda #$0C00
        sta aProcSystem.aBody3,b,x

        _F131
        lda aProcSystem.aHeaderTypeOffset,b,x
        tax
        lda $000B,b,x
        sta wR0
        lda $000D,b,x
        sta wR1
        ldx aProcSystem.wOffset,b
        lda wMapMagicTargetPixel
        and #$00FF
        clc
        adc wR0
        sta $7F50DF
        lda wMapMagicTargetPixel+1
        and #$00FF
        clc
        adc wR1
        sta $7F50E1
        lda $1038,b,x
        and #$00FF
        beq _F193
        sta $7F50E3
        asl a
        sec
        sbc #$0000
        sta $7F50E5
        phy
        lda $7F50E3
        clc
        adc #$0000
        tay
        lda #$7F00
        sta lR18+1
        lda #$50EA
        sta lR18
        ldx #$0000
        lda #$00E0
        jsl rlMapMagicBuildStaffWindowHDMA
        ply
        rtl


        _F193
        lda #$50EA
        sta $2181,b
        sep #$20
        lda #$01
        sta $2183,b
        rep #$20
        ldx #$0000
        bra _F1B6


        _F1A7
        sep #$20
        lda #$FF
        sta $2180,b
        lda #$00
        sta $2180,b
        rep #$20
        inc x

        _F1B6
        cpx #$00E0
        bmi _F1A7
        rtl

        .databank 0

        ; 9F/F1BC

    .endsection Unsorted9FF100Section


    .section Unsorted9FF1BCSection

      .al
      .xl

      rlMapMagicForsetiWindowCycle ; 9F/F1BC

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Forseti effect.

        dec aProcSystem.aBody1,b,x
        beq _F1C5
        jml _F24F


        _F1C5
        lda aProcSystem.aBody0,b,x
        sta aProcSystem.aBody1,b,x
        lda aProcSystem.aBody2,b,x
        clc
        adc aProcSystem.aBody4,b,x
        sta aProcSystem.aBody2,b,x
        cmp #$0001
        bpl _F1E0
        lda #$0001
        sta aProcSystem.aBody2,b,x

        _F1E0
        cmp aProcSystem.aBody3,b,x
        bmi _F1EB
        lda aProcSystem.aBody3,b,x
        sta aProcSystem.aBody2,b,x

        _F1EB
        lda wMapMagicTargetPixel
        and #$00FF
        sta $7F50DF
        sec
        sbc #$0080
        eor #$FFFF
        inc a
        sta $7F50CD
        lda wMapMagicTargetPixel+1
        and #$00FF
        sta $7F50E1
        sec
        sbc #$0070
        eor #$FFFF
        inc a
        sta $7F50CF
        lda aProcSystem.aBody5,b,x
        bne _F230
        lda aProcSystem.aBody2,b,x
        sta $7F50E3
        asl a
        clc
        adc #$0000
        sta $7F50E5
        bra _F23C


        _F230
        lda aProcSystem.aBody2,b,x
        sta $7F50E3
        inc a
        sta $7F50E5

        _F23C
        phy
        lda #$7F00
        sta lR18+1
        lda #$50EA
        sta lR18
        ldx #$0000
        jsl rlMapMagicBuildForsetiWindowHDMA
        ply

        _F24F
        rtl

        .databank 0

        ; 9F/F250

    .endsection Unsorted9FF1BCSection


    .section Unsorted9FF250Section

      .al
      .xl

      rsMapMagicAuraDrawMask ; 9F/F250

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        pha
        sty wR1
        lda wMapMagicTargetPixel
        and #$00FF
        sta wR2
        lda wMapMagicTargetPixel+1
        and #$00FF
        clc
        adc wR3
        sta wR3
        pla
        phx
        jsr rsMapMagicAuraInitMaskParams
        jsr rsMapMagicAuraDrawMaskRows
        jsr rsMapMagicAuraFillMaskBottom
        plx
        rts

        .databank 0

        ; 9F/F275

      rsMapMagicAuraInitMaskParams ; 9F/F275

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        lsr a
        sta wR5
        pha
        clc
        adc wR2
        sta wR4
        lda wR2
        sec
        sbc #1,s
        sta wR2
        pla
        lda #$50EA
        sta $2181,b
        sep #$20
        lda #$01
        sta $2183,b
        rep #$20
        lda wR3
        sec
        sbc wR1
        bmi _F2B2
        beq _F2B2
        tax

        _F29F
        sep #$20
        lda #$FF
        sta $2180,b
        lda #$00
        sta $2180,b
        rep #$20
        dec x
        bne _F29F
        bra _F2B6


        _F2B2
        lda wR3
        sta wR1

        _F2B6
        ldx #$0000
        ldy #$0000

        _F2BC
        lda wR2
        cmp #$0008
        bpl _F2C6
        lda #$0008

        _F2C6
        sep #$20
        sta $2180,b
        rep #$20
        lda wR4
        cmp #$00F7
        bcc _F2D7
        lda #$00F7

        _F2D7
        sep #$20
        sta $2180,b
        rep #$20
        inc x
        cpx wR1
        bmi _F2BC
        rts

        .databank 0

        ; 9F/F2E4

      rsMapMagicAuraFillMaskBottom ; 9F/F2E4

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        ldx wR1
        bra _F2F7


        _F2E8
        sep #$20
        lda #$FF
        sta $2180,b
        lda #$00
        sta $2180,b
        rep #$20
        inc x

        _F2F7
        cpx #$00E0
        bmi _F2E8
        rts

        .databank 0

      rsMapMagicAuraDrawMaskHalfUnused ; 9F/F2FD

        .al
        .xl
        .autsiz
        .databank ?

        phb
        pea #(`aBattleSceneWindowShapes)<<8
        plb
        plb
        lda wR5
        clc
        adc #$0004
        asl a
        tax
        lda @l aBattleSceneWindowShapes,x
        clc
        adc #<>aBattleSceneWindowShapes
        tax
        dex
        lda wR5
        clc
        adc #$0003
        lsr a
        tay
        bne +
        ldy #$0001
        +
        lda wR2
        clc
        adc wR4
        and #$01FF
        lsr a
        sta wR0

        _F32D
        lda $0000,b,x
        and #$00FF
        sta wR6
        lda wR0
        sec
        sbc wR6
        cmp wR2
        bpl +
        lda wR2
        +
        cmp #$0008
        bpl +
        lda #$0008
        +
        sep #$20
        .as
        sta $2180,b
        rep #$20
        .al
        lda $0000,b,x
        and #$00FF
        clc
        adc wR0
        cmp wR4
        bcc +
        lda wR4
        +
        cmp #$00F7
        bcc +
        lda #$00F7
        +
        sep #$20
        .as
        sta $2180,b
        rep #$20
        .al
        dec wR1
        dex
        dex
        dey
        bne _F32D
        plb
        rts

        .databank 0

    .endsection Unsorted9FF250Section


    .section Unsorted9FF376Section

      .al
      .xl

      rsMapMagicAuraDrawMaskRows ; 9F/F376

        .al
        .xl
        .autsiz
        .databank ?
        ; Part of the Aura effect.

        phb
        pea #$9A00
        plb
        .databank ?
        plb
        .databank ?
        lda wR5
        clc
        adc #$0004
        asl a
        tax
        lda aBattleSceneWindowShapes,x
        clc
        adc #$A30A
        tax
        dec x
        lda wR5
        clc
        adc #$0003
        tay
        bne _F39A
        ldy #$0001

        _F39A
        lda wR2
        clc
        adc wR4
        and #$01FF
        lsr a
        sta wR0

        _F3A5
        lda $0000,b,x
        and #$00FF
        sta wR6
        lda wR0
        sec
        sbc wR6
        cmp wR2
        bpl _F3B8
        lda wR2

        _F3B8
        cmp #$0008
        bpl _F3C0
        lda #$0008

        _F3C0
        sep #$20
        sta $2180,b
        rep #$20
        lda $0000,b,x
        and #$00FF
        clc
        adc wR0
        cmp wR4
        bcc _F3D6
        lda wR4

        _F3D6
        cmp #$00F7
        bcc _F3DE
        lda #$00F7

        _F3DE
        sep #$20
        sta $2180,b
        rep #$20
        dec wR1
        dec x
        dec y
        bne _F3A5
        plb
        .databank ?
        rts

        .databank 0

        ; 9F/F3ED

    .endsection Unsorted9FF376Section


    .section Unsorted9FF3EDSection

      .al
      .xl

      rlMapMagicGetOctantAngle ; 9F/F3ED

        .al
        .xl
        .autsiz
        .databank ?

        phx
        ldx #$0000
        lda wR0
        bpl _F3FC
        ldx #$0004
        eor #$FFFF
        inc a

        _F3FC
        sta wR0
        lda wR1
        bpl _F408
        inc x
        inc x
        eor #$FFFF
        inc a

        _F408
        sta wR1
        cmp wR0
        bpl rlMapMagicDivideAngleOctant
        sep #$20
        stz $4204,b
        lda wR1
        sta $4205,b
        lda wR0
        sta $4206,b
        nop
        nop
        nop
        rep #$20
        jsr (aMapMagicGetOctantAngleJumpTable,x)
        plx
        rtl

        .databank 0

      aMapMagicGetOctantAngleJumpTable ; 9F/F427

        ; Jump table of rlMapMagicGetOctantAngle.
        .word <>rsMapMagicAngleOctant0
        .word <>rsMapMagicAngleOctant1
        .word <>rsMapMagicAngleOctant2
        .word <>rsMapMagicAngleOctant3

      rlMapMagicDivideAngleOctant ; 9F/F42F

        .al
        .xl
        .autsiz
        .databank ?

        sep #$20
        stz $4204,b
        lda wR0
        sta $4205,b
        lda wR1
        sta $4206,b
        nop
        nop
        nop
        rep #$20
        jsr (aMapMagicDivideAngleOctantJumpTable,x)
        plx
        rtl

        .databank 0

        ; 9F/F448

    .endsection Unsorted9FF3EDSection


    .section Table9FF448Section

      .al
      .xl

      aMapMagicDivideAngleOctantJumpTable ; 9F/F448

        ; Jump table of rlMapMagicGetOctantAngle.
        .word <>rsMapMagicAngleOctant4
        .word <>rsMapMagicAngleOctant5
        .word <>rsMapMagicAngleOctant6
        .word <>rsMapMagicAngleOctant7

    .endsection Table9FF448Section


    .section Unsorted9FF450Section

      .al
      .xl

      rsMapMagicAngleOctant0 ; 9F/F450

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        inc a
        and #$00FF
        rts

        .databank 0

        ; 9F/F45E

      rsMapMagicAngleOctant1 ; 9F/F45E

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        and #$00FF
        rts

        .databank 0

        ; 9F/F468

      rsMapMagicAngleOctant2 ; 9F/F468

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0080
        and #$00FF
        rts

        .databank 0

        ; 9F/F476

      rsMapMagicAngleOctant3 ; 9F/F476

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        sec
        adc #$0080
        and #$00FF
        rts

        .databank 0

        ; 9F/F487

    .endsection Unsorted9FF450Section


    .section Unsorted9FF487Section

      .al
      .xl

      rsMapMagicAngleOctant4 ; 9F/F487

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$00C0
        and #$00FF
        rts

        .databank 0

        ; 9F/F495

    .endsection Unsorted9FF487Section


    .section Unsorted9FF495Section

      .al
      .xl

      rsMapMagicAngleOctant5 ; 9F/F495

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        sec
        adc #$0040
        and #$00FF
        rts

        .databank 0

        ; 9F/F4A6

    .endsection Unsorted9FF495Section


    .section Unsorted9FF4A6Section

      .al
      .xl

      rsMapMagicAngleOctant6 ; 9F/F4A6

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        eor #$FFFF
        sec
        adc #$00C0
        and #$00FF
        rts

        .databank 0

        ; 9F/F4B7

    .endsection Unsorted9FF4A6Section


    .section Unsorted9FF4B7Section

      .al
      .xl

      rsMapMagicAngleOctant7 ; 9F/F4B7

        .al
        .xl
        .autsiz
        .databank ?

        lda $4214,b
        lsr a
        lsr a
        lsr a
        clc
        adc #$0040
        and #$00FF
        rts

        .databank 0

        ; 9F/F4C5

    .endsection Unsorted9FF4B7Section


    .section Unsorted9FF4C5Section

      .al
      .xl

      rlStartMapMagicCutsceneSeqUnused ; 9F/F4C5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`procMapMagicCutsceneSeq)<<8
        sta lR44+1
        lda #<>procMapMagicCutsceneSeq
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rtl

        .databank 0

        ; 9F/F4D6

    .endsection Unsorted9FF4C5Section


    .section Unsorted9FF4D6Section

      .al
      .xl

      procMapMagicCutsceneSeq ; 9F/F4D6

        .structProcInfo "ON", rlProcMapMagicCutsceneSeqInit, rlProcMapMagicCutsceneSeqIdle, aProcMapMagicCutsceneSeqCode

    .endsection Unsorted9FF4D6Section


    .section Unsorted9FF4DESection

      .al
      .xl

      rlProcMapMagicCutsceneSeqInit ; 9F/F4DE

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda wGameStateRoutine1,b
        sta aProcSystem.aBody7,b,x
        stz wGameStateRoutine1,b
        jsl rlPauseMapSpriteAnimation
        jsl rlPauseMapTileAnimation
        lda #$0000
        sta aProcSystem.aHeaderBitfield,b,x
        sta aProcSystem.aBody3,b,x
        sta wBallistaBoltSignal
        sta wMapAnimationSignals
        sta aMapAction.wMapBattleStrikeSignal
        sta aMapAction.wMapBattleStrikeDone
        sta aMapAction.wMapBattleRoundRunning
        jsl rlMapMagicCutsceneQueueGfx1
        jsl rlMapMagicCutsceneQueueGfx2
        lda #$0005
        jsl rlGetEventLocationEntryCoordinatesByID
        pha
        and #$00FF
        sta $7F57EA
        pla
        xba
        and #$00FF
        sta $7F57EC
        jsr rsMapMagicCutsceneSavePalettes
        lda #(`rlPushToOAMBufferDualTileBase)<<8
        sta lActiveSpriteRenderer+1,b
        lda #<>rlPushToOAMBufferDualTileBase
        sta lActiveSpriteRenderer,b
        lda aActiveSpriteSystem,b
        sta wMapBattleSavedSpriteEngineFlag
        lda aActiveSpriteSystem,b
        ora #$4000
        sta aActiveSpriteSystem,b
        plx
        rtl

        .databank 0

        ; 9F/F54E

      rlProcMapMagicCutsceneSeqIdle ; 9F/F54E

        .al
        .xl
        .autsiz
        .databank ?

        rtl

        .databank 0

        ; 9F/F54F

      rlProcMapMagicCutsceneSeqFadeWhite ; 9F/F54F

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aBody3,b,x
        bne _F563
        jsr rsMapMagicCutsceneStepFadeWhite
        bcc _F563
        lda #1,s
        tax
        lda #<>rlProcMapMagicCutsceneSeqIdle
        sta aProcSystem.aHeaderOnCycle,b,x

        _F563
        lda #1,s
        tax
        lda aProcSystem.aBody3,b,x
        dec a
        bpl _F56F
        lda #$0004

        _F56F
        sta aProcSystem.aBody3,b,x
        plx
        rtl

        .databank 0

        ; 9F/F574

      rlProcMapMagicCutsceneSeqFadeIn ; 9F/F574

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda @l $001037,x
        bne _F58A
        jsr rsMapMagicCutsceneStepFadeIn
        bcc _F58A
        lda #1,s
        tax
        lda #$F54E
        sta @l $000F57,x

        _F58A
        lda #1,s
        tax
        lda @l $001037,x
        dec a
        bpl _F597
        lda #$0020

        _F597
        sta @l $001037,x
        plx
        rtl

        .databank 0

        ; 9F/F59D

    .endsection Unsorted9FF4DESection


    .section Unsorted9FF59DSection

      .al
      .xl

      aProcMapMagicCutsceneSeqCode ; 9F/F59D

        PROC_YIELD 1
        _F59F
        PROC_YIELD 1
        PROC_CALL rlMapMagicCutsceneWaitDecomp
        PROC_JUMP_IF_BITS_UNSET _F59F, $0001
        PROC_YIELD 1
        PROC_CALL rlMapMagicCutsceneUploadGfx
        PROC_YIELD 2
        PROC_CALL rlMapMagicCutsceneStartDarken
        _F5BA
        PROC_YIELD 1
        PROC_CALL rlMapMagicCutsceneStepDarken
        PROC_JUMP_IF_BITS_UNSET _F5BA, $0004
        PROC_YIELD 1
        PROC_CALL rlMapMagicCutscenePlayCastSound
        _F5CE
        PROC_YIELD 1
        PROC_CALL rlMapMagicCutsceneWaitSound
        PROC_JUMP_IF_BITS_UNSET _F5CE, $0004
        PROC_CALL rlMapMagicCutsceneStartShake
        PROC_CALL rlMapMagicCutsceneStartBrighten
        _F5E5
        PROC_YIELD 1
        PROC_CALL rlMapMagicCutsceneStepBrighten
        PROC_JUMP_IF_BITS_UNSET _F5E5, $0004
        PROC_YIELD 1
        PROC_YIELD 120
        PROC_CALL rlMapMagicCutsceneSetSignal10
        PROC_YIELD 64
        PROC_CALL rlMapMagicCutsceneSetupSprites
        _F602
        PROC_YIELD 12
        PROC_CALL rlMapMagicCutsceneSlideSpriteUp
        PROC_JUMP_IF_BITS_UNSET _F602, $0004
        PROC_YIELD 240
        PROC_CALL rlMapMagicCutsceneTriggerStrike
        PROC_CALL rlMapMagicCutscenePlayImpactSound
        PROC_YIELD 18
        PROC_CALL rlMapMagicCutsceneStartRipple
        PROC_YIELD 6
        PROC_CALL rlMapMagicCutsceneTriggerStrike
        PROC_YIELD 32
        PROC_CALL rlMapMagicCutsceneStartFadeWhite
        PROC_SET_ONCYCLE rlProcMapMagicCutsceneSeqFadeWhite
        PROC_YIELD 80
        PROC_YIELD 120
        PROC_CALL rlMapMagicCutsceneStartFadeIn
        PROC_SET_ONCYCLE rlProcMapMagicCutsceneSeqFadeIn
        PROC_YIELD 64
        PROC_CALL rlMapMagicCutsceneStopShake
        PROC_YIELD 120
        PROC_CALL rlMapMagicCutsceneSetDoneSignal
        PROC_YIELD 96
        PROC_YIELD 180
        PROC_CALL rlMapMagicCutsceneEnd
        PROC_HALT


        ; 9F/F65A

    .endsection Unsorted9FF59DSection


    .section Unsorted9FF65ASection

      .al
      .xl

      rlMapMagicCutscenePlayCastSound ; 9F/F65A

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$0015
        sta @l $0004BA
        plx
        rtl

        .databank 0

      rlMapMagicCutsceneResumeMusicUnused ; 9F/F66D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        jsl rlResumePhaseMusic
        plx
        rtl

        .databank 0

    .endsection Unsorted9FF65ASection


    .section Unsorted9FF67DSection

      .al
      .xl

      rlMapMagicCutsceneWaitSound ; 9F/F67D

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda @l $0004BA
        bne _F68D
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _F68D
        plx
        rtl

        .databank 0

        ; 9F/F68F

      rlMapMagicCutscenePlayImpactSound ; 9F/F68F

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0016
        sta @l $0004BA
        rtl

        .databank 0

        ; 9F/F697

      rlMapMagicCutsceneQueueGfx1 ; 9F/F697

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`gcUnknownAFF670)<<8
        sta lR18+1
        lda #<>gcUnknownAFF670
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$0000
        sta lR19
        jsl rlAppendDecompList
        plx
        rtl

        .databank 0

        ; 9F/F6B6

      rlMapMagicCutsceneQueueGfx2 ; 9F/F6B6

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`gcUnknownD67D7D)<<8
        sta lR18+1
        lda #<>gcUnknownD67D7D
        sta lR18
        lda #(`aDecompressionBuffer)<<8
        sta lR19+1
        lda #<>aDecompressionBuffer
        clc
        adc #$1000
        sta lR19
        jsl rlAppendDecompList
        plx
        rtl

        .databank 0

        ; 9F/F6D5

      rlMapMagicCutsceneWaitDecomp ; 9F/F6D5

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFE
        sta aProcSystem.aHeaderBitfield,b,x
        lda bDecompressionArrayFlag,b
        and #$00FF
        bne _F6EF
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0001
        sta aProcSystem.aHeaderBitfield,b,x

        _F6EF
        rtl

        .databank 0

        ; 9F/F6F0

      rlMapMagicCutsceneUploadGfx ; 9F/F6F0

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        clc
        adc #$0000
        sta lR18
        lda #$0C00
        sta wR0
        lda bBufferOBSEL
        and #$0003
        asl a
        asl a
        asl a
        asl a
        asl a
        xba
        clc
        adc #$0200
        sta wR1
        jsl rlDMAByPointer
        ldx #$001E

        _F71C
        lda aMapMagicCutsceneGfxData,x
        sta aOAMPaletteBuffer.aPalette5,b,x
        dec x
        dec x
        bne _F71C
        plx
        rtl

        .databank 0

        ; 9F/F729

    .endsection Unsorted9FF67DSection


    .section Data9FF729Section

      .al
      .xl

      aMapMagicCutsceneGfxData ; 9F/F729

        ; Read by rlMapMagicCutsceneUploadGfx.

        .word $3800, $7FFF, $6739, $41F0, $292A, $1485, $0C43, $1919
        .word $10B2, $0C49, $375F, $0000, $0000, $0000, $0000, $0000

        ; 9F/F749

    .endsection Data9FF729Section


    .section Unsorted9FF749Section

      .al
      .xl

      rlMapMagicCutsceneSetupSprites ; 9F/F749

        .al
        .xl
        .autsiz
        .databank ?

        phy
        phx
        jsl rlInitMapBattleSpriteInfos
        lda #$7E00
        sta aMapAction.lAttackerSpriteData+1
        sta lR18+1
        lda #$8B88
        clc
        adc #$1000
        sta aMapAction.lAttackerSpriteData
        sta lR18
        lda #$7E00
        sta aMapAction.lMapBattleSideScript+1
        ldy #$0004
        lda [lR18],y
        clc
        adc lR18
        sta aMapAction.lMapBattleSideScript
        lda $7F57EC
        tay
        lda $7F57EA
        tax
        lda aActionStructUnit2.UnitRAMPointer
        jsl rlGetMapBattleUnitScreenPosition
        lda #(`aMapBattleAttackerSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapBattleAttackerSpriteInfo
        sta lR44
        lda aMapAction.lMapBattleSideScript
        sta aMapBattleAttackerSpriteInfo.Code
        ldx wR0
        lda wR1
        clc
        adc #$0005
        tay
        lda #<>aMapBattleAttackerSpriteInfo
        jsl rlActiveSpriteEngineCreateSpriteLowestSlotAbove0
        lda aActiveSpriteSystem.wOffset,b
        tax
        sta aMapAction.wMapBattleAttackerSpriteSlot
        lda #$0000
        sta aActiveSpriteSystem.aTileBase,b,x
        sta aActiveSpriteSystem.aTileBaseHigh,b,x
        lda #$0005
        sta aActiveSpriteSystem.aPalette,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001320,b,x
        lda #(`aDecompressionBuffer)<<8
        sta lR18+1
        lda #<>aDecompressionBuffer
        clc
        adc #$1000
        sta lR18
        lda #$7E00
        sta aMapAction.lMapBattleSideScript+1
        ldy #$0008
        lda [lR18],y
        clc
        adc lR18
        sta aMapAction.lMapBattleSideScript
        lda $7F57EC
        tay
        lda $7F57EA
        tax
        lda aActionStructUnit2.UnitRAMPointer
        jsl rlGetMapBattleUnitScreenPosition
        lda #(`aMapBattleAttackerAuxSpriteInfo)<<8
        sta lR44+1
        lda #<>aMapBattleAttackerAuxSpriteInfo
        sta lR44
        lda aMapAction.lMapBattleSideScript
        sta aMapBattleAttackerAuxSpriteInfo.Code
        lda #<>aMapBattleAttackerAuxSpriteInfo
        ldx wR0
        ldy wR1
        jsl rlActiveSpriteEngineCreateSpriteLowestSlotAbove0
        lda aActiveSpriteSystem.wOffset,b
        tax
        sta aMapAction.wMapBattleAttackerAuxSpriteSlot
        lda #$0000
        sta aActiveSpriteSystem.aTileBase,b,x
        sta aActiveSpriteSystem.aTileBaseHigh,b,x
        lda #$0005
        sta aActiveSpriteSystem.aPalette,b,x
        lda #$0000
        sta aActiveSpriteSystem.aUnknown001320,b,x
        plx
        ply
        rtl

        .databank 0

        ; 9F/F839

      rlMapMagicCutsceneSlideSpriteUp ; 9F/F839

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda aMapAction.wMapBattleAttackerSpriteSlot
        tax
        lda aActiveSpriteSystem.aYPosition,b,x
        cmp #$0060
        beq _F856
        dec a
        sta aActiveSpriteSystem.aYPosition,b,x
        bra _F862


        _F856
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _F862
        plx
        rtl

        .databank 0

        ; 9F/F864

      rlMapMagicCutsceneSetSignal10 ; 9F/F864

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapAnimationSignals
        ora #$0010
        sta wMapAnimationSignals
        rtl

        .databank 0

        ; 9F/F870

      rlMapMagicCutsceneTriggerStrike ; 9F/F870

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta wBallistaBoltSignal
        sta aMapAction.wMapBattleStrikeSignal
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        tax
        lda #$0000
        sta aActiveSpriteSystem.aTypeOffset,b,x
        rtl

        .databank 0

        ; 9F/F887

      rlMapMagicCutsceneStartDarken ; 9F/F887

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        lda #$0010
        sta aProcSystem.aBody3,b,x
        plx
        rtl

        .databank 0

        ; 9F/F899

      rlMapMagicCutsceneStepDarken ; 9F/F899

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        pea #$9F9F
        plb
        .databank ?
        plb
        .databank ?
        jsl rlDarkenMapMagicColors
        bcc _F8B2
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x

        _F8B2
        plx
        plb
        .databank ?
        rtl

        .databank 0

        ; 9F/F8B5

      rlMapMagicCutsceneStartBrighten ; 9F/F8B5

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0018
        sta aProcSystem.aBody3,b,x
        lda aProcSystem.aHeaderBitfield,b,x
        and #$FFFB
        sta aProcSystem.aHeaderBitfield,b,x
        plx
        rtl

        .databank 0

        ; 9F/F8C7

      rlMapMagicCutsceneStepBrighten ; 9F/F8C7

        .al
        .xl
        .autsiz
        .databank ?

        phb
        phx
        lda aProcSystem.aBody3,b,x
        bne _F8F3
        sep #$20
        lda bBufferINIDISP
        inc a
        sta bBufferINIDISP
        rep #$20
        and #$000F
        cmp #$000F
        bne _F8F3
        lda #1,s
        tax
        lda aProcSystem.aHeaderBitfield,b,x
        ora #$0004
        sta aProcSystem.aHeaderBitfield,b,x
        lda #<>rlProcMapMagicCutsceneSeqIdle
        sta aProcSystem.aHeaderOnCycle,b,x
        bra _F8FF


        _F8F3
        lda #1,s
        tax
        lda aProcSystem.aBody3,b,x
        dec a
        bpl _F8FF
        lda #$0018

        _F8FF
        sta aProcSystem.aBody3,b,x
        plx
        plb
        .databank ?
        rtl

        .databank 0

        ; 9F/F905

      rlMapMagicCutsceneStartFadeWhite ; 9F/F905

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0004
        sta aProcSystem.aBody3,b,x
        rtl

        .databank 0

        ; 9F/F90C

      rlMapMagicCutsceneStartFadeIn ; 9F/F90C

        .al
        .xl
        .autsiz
        .databank ?

        stz aPaletteFading.wCurrentStep,b
        lda #$0020
        sta aProcSystem.aBody3,b,x
        rtl

        .databank 0

        ; 9F/F916

      rlMapMagicCutsceneEnd ; 9F/F916

        .al
        .xl
        .autsiz
        .databank ?

        lda aProcSystem.aBody7,b,x
        sta wGameStateRoutine1,b
        lda wMapBattleSavedSpriteEngineFlag
        sta aActiveSpriteSystem,b
        lda #(`rlPushToOAMBuffer)<<8
        sta lActiveSpriteRenderer+1,b
        lda #<>rlPushToOAMBuffer
        sta lActiveSpriteRenderer,b
        lda wMapAnimationSignals
        ora #$0002
        sta wMapAnimationSignals
        jsl rlResumeMapSpriteAnimation
        jsl rlResumeMapTileAnimation
        jsl rlProcEngineFreeProc
        rtl

        .databank 0

        ; 9F/F947

      rlMapMagicCutsceneStartRipple ; 9F/F947

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0001
        sta aProcSystem.wInput0,b
        lda #(`procMapMagicRipple)<<8
        sta lR44+1
        lda #<>procMapMagicRipple
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 9F/F95C

      rsMapMagicCutsceneSavePalettes ; 9F/F95C

        .al
        .xl
        .autsiz
        .databank ?

        jsl rlSavePaletteBufferColorsToRAM

          .byte $00, $D0, $7E, $60, $00, $00, $00

        rts

        .databank 0

        ; 9F/F968

      rsMapMagicCutsceneStepFadeIn ; 9F/F968

        .al
        .xl
        .autsiz
        .databank ?

        lda #$0008
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToColors

          .byte $00, $D0, $60, $00, $00, $00

        rts

        .databank 0

        ; 9F/F97A

      rsMapMagicCutsceneStepFadeWhite ; 9F/F97A

        .al
        .xl
        .autsiz
        .databank ?

        lda #$7FFF
        sta aPaletteFading.wDesiredColor,b
        lda #$0010
        sta aPaletteFading,b
        clc
        jsl rlFadePaletteToBlack

          .byte $8E, $F9

        rts

        .databank 0

        ; 9F/F98E

    .endsection Unsorted9FF749Section


    .section Unsorted9FF98ESection

      .al
      .xl

      aMapMagicColorRangesUnused ; 9F/F98E

        ; Unreferenced: a colour range list ending in $FFFF, like the ones
        ; the palette fades read (aMapMagicBackgroundPaletteRanges).
        .word $0002, $000F, $0022, $000F, $0042, $000F, $0062, $000F
        .word $0082, $000F, $00A2, $000F, $FFFF

    .endsection Unsorted9FF98ESection


    .section Unsorted9FF9A8Section

      .al
      .xl

      rlMapMagicCutsceneStartShake ; 9F/F9A8

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #(`procMapMagicCutsceneShake)<<8
        sta lR44+1
        lda #<>procMapMagicCutsceneShake
        sta lR44
        jsl rlProcEngineCreateProc
        plx
        rtl

        .databank 0

        ; 9F/F9B9

    .endsection Unsorted9FF9A8Section


    .section Unsorted9FF9B9Section

      .al
      .xl

      procMapMagicCutsceneShake ; 9F/F9B9

        .structProcInfo "ON", rlProcMapMagicCutsceneShakeInit, rlProcMapMagicCutsceneShakeCycle, aProcMapMagicCutsceneShakeCode

    .endsection Unsorted9FF9B9Section


    .section Unsorted9FF9C1Section

      .al
      .xl

      rlProcMapMagicCutsceneShakeInit ; 9F/F9C1

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapScrollXPixels,b
        sta aProcSystem.aBody3,b,x
        lda wMapScrollYPixels,b
        sta aProcSystem.aBody4,b,x
        lda #$0002
        sta aProcSystem.aBody5,b,x
        lda #$0000
        sta aProcSystem.aBody6,b,x
        rtl

        .databank 0

        ; 9F/F9DA

      rlProcMapMagicCutsceneShakeCycle ; 9F/F9DA

        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda aProcSystem.aBody5,b,x
        beq _F9E4
        jml _FA6A


        _F9E4
        lda wMapAnimationSignals
        bit #$0004
        bne _FA1B
        lda aProcSystem.aBody6,b,x
        and #$0001
        asl a
        asl a
        tax
        lda wMapScrollXPixels,b
        eor aMapMagicCutsceneShakeOffsets2,x
        sta wMapScrollXPixels,b
        lda wMapScrollYPixels,b
        eor aMapMagicCutsceneShakeOffsets2+2,x
        sta wMapScrollYPixels,b
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        tax
        lda aActiveSpriteSystem.aXPosition,b,x
        eor aMapMagicCutsceneShakeOffsets2,x
        sta aActiveSpriteSystem.aXPosition,b,x
        bra _FA47


        _FA1B
        lda aProcSystem.aBody6,b,x
        and #$0003
        asl a
        asl a
        tax
        lda wMapScrollXPixels,b
        eor aMapMagicCutsceneShakeOffsets1,x
        sta wMapScrollXPixels,b
        lda wMapScrollYPixels,b
        eor aMapMagicCutsceneShakeOffsets1+2,x
        sta wMapScrollYPixels,b
        lda aMapAction.wMapBattleAttackerAuxSpriteSlot
        tax
        lda aActiveSpriteSystem.aXPosition,b,x
        eor aMapMagicCutsceneShakeOffsets1,x
        sta aActiveSpriteSystem.aXPosition,b,x

        _FA47
        lda #1,s
        tax
        lda aProcSystem.aBody6,b,x
        inc a
        sta aProcSystem.aBody6,b,x
        lda wMapAnimationSignals
        bit #$0001
        beq _FA6A
        lda aProcSystem.aBody3,b,x
        sta wMapScrollXPixels,b
        lda aProcSystem.aBody4,b,x
        sta wMapScrollYPixels,b
        jsl rlProcEngineFreeProc

        _FA6A
        lda aProcSystem.aBody5,b,x
        dec a
        bpl _FA73
        lda #$0002

        _FA73
        sta aProcSystem.aBody5,b,x
        plx
        rtl

        .databank 0

        ; 9F/FA78

    .endsection Unsorted9FF9C1Section


    .section Data9FFA78Section

      .al
      .xl

      aMapMagicCutsceneShakeOffsets1 ; 9F/FA78

        ; Read by rlProcMapMagicCutsceneShakeCycle.

        .word $0001, $0000, $0001, $0001, $0001, $0000, $0001, $0001

        ; 9F/FA88

      aMapMagicCutsceneShakeOffsets2 ; 9F/FA88

        ; Read by rlProcMapMagicCutsceneShakeCycle.

        .word $0002, $0000, $0002, $0002, $0002, $0000, $0002, $0002

        ; 9F/FA98

    .endsection Data9FFA78Section


    .section Unsorted9FFA98Section

      .al
      .xl

      aProcMapMagicCutsceneShakeCode ; 9F/FA98

        PROC_HALT


        ; 9F/FA9A

    .endsection Unsorted9FFA98Section


    .section Unsorted9FFA9ASection

      .al
      .xl

      rlMapMagicCutsceneSetScrollUnused ; 9F/FA9A

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phx
        lda #$0220
        sta @l wMapScrollXPixels
        lda #$00D0
        sta @l wMapScrollYPixels
        lda #$0080
        sta wCursorXOffset,b
        sta wCursorYOffset,b
        plx
        rtl

        .databank 0

        ; 9F/FAB4

    .endsection Unsorted9FFA9ASection


    .section Unsorted9FFAB4Section

      .al
      .xl

      rlMapMagicCutsceneStopShake ; 9F/FAB4

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapAnimationSignals
        ora #$0004
        sta wMapAnimationSignals
        rtl

        .databank 0

        ; 9F/FAC0

      rlMapMagicCutsceneSetDoneSignal ; 9F/FAC0

        .al
        .xl
        .autsiz
        .databank ?

        lda wMapAnimationSignals
        ora #$0001
        sta wMapAnimationSignals
        rtl

        .databank 0

        ; 9F/FACC

      aUnused9FFACC ; 9F/FACC

        ; Unused: 308 zero bytes.
        .fill 308, $00

    .endsection Unsorted9FFAB4Section
