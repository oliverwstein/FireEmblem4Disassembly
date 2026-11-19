; Highlighting regions of the world map.

    .section WorldMapHighlightCodeSection

      .al
      .xl

      rlHighlightWorldMapPart ; 8B/88CE

        .al
        .autsiz
        .databank ?

        asl a
        tax
        phx
        jsr (aWorldMapHighlights,x)
        plx

        sep #$20
        lda #T_Setting(false, true, true, false, true)
        sta bBufferTS
        rep #$20

        lda #0
        sta wBufferBG2HOFS
        lda #0
        sta wBufferBG2VOFS

        lda #(`procUnknown8B901D)<<8
        sta lR44+1
        lda #<>procUnknown8B901D
        sta lR44
        jsl rlProcEngineCreateProc

        jsl rlDMAByStruct

          .structDMAToVRAM $7E7B88, 32 * 21 * size(word), $80, $A800

        rtl

        .databank 0

      aWorldMapHighlights .include "../../data/system/WorldMapHighlights.csv.asm" ; 8B/8903

      rsDecompressVerdaneMapHighlight ; 8B/8919

        .al
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>aVerdaneMapHighlightTilemap
        stx DecompressionVariables.lSource
        lda #`aVerdaneMapHighlightTilemap
        sta DecompressionVariables.lSource+2
        ldx #<>$7E7B88
        stx DecompressionVariables.lDest
        lda #`$7E7B88
        sta DecompressionVariables.lDest+2
        rep #$30
        jsl rlDecompressor
        rts

        .databank 0

      rsDecompressAgustriaMapHighlight ; 8B/8936

        .al
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>aAgustriaMapHighlightTilemap
        stx DecompressionVariables.lSource
        lda #`aAgustriaMapHighlightTilemap
        sta DecompressionVariables.lSource+2
        ldx #<>$7E7B88
        stx DecompressionVariables.lDest
        lda #`$7E7B88
        sta DecompressionVariables.lDest+2
        rep #$30
        jsl rlDecompressor
        rts

        .databank 0

      rsDecompressSilesseMapHighlight ; 8B/8953

        .al
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>aSilesseMapHighlightTilemap
        stx DecompressionVariables.lSource
        lda #`aSilesseMapHighlightTilemap
        sta DecompressionVariables.lSource+2
        ldx #<>$7E7B88
        stx DecompressionVariables.lDest
        lda #`$7E7B88
        sta DecompressionVariables.lDest+2
        rep #$30
        jsl rlDecompressor
        rts

        .databank 0

      rsDecompressAedMapHighlight ; 8B/8970

        .al
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>aAedMapHighlightTilemap
        stx DecompressionVariables.lSource
        lda #`aAedMapHighlightTilemap
        sta DecompressionVariables.lSource+2
        ldx #<>$7E7B88
        stx DecompressionVariables.lDest
        lda #`$7E7B88
        sta DecompressionVariables.lDest+2
        rep #$30
        jsl rlDecompressor
        rts

        .databank 0

      rsDecompressIsaachMapHighlight ; 8B/898D

        .al
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>aIsaachMapHighlightTilemap
        stx DecompressionVariables.lSource
        lda #`aIsaachMapHighlightTilemap
        sta DecompressionVariables.lSource+2
        ldx #<>$7E7B88
        stx DecompressionVariables.lDest
        lda #`$7E7B88
        sta DecompressionVariables.lDest+2
        rep #$30
        jsl rlDecompressor
        rts

        .databank 0

      rsDecompressMunsterMapHighlight ; 8B/89AA

        .al
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>aMunsterMapHighlightTilemap
        stx DecompressionVariables.lSource
        lda #`aMunsterMapHighlightTilemap
        sta DecompressionVariables.lSource+2
        ldx #<>$7E7B88
        stx DecompressionVariables.lDest
        lda #`$7E7B88
        sta DecompressionVariables.lDest+2
        rep #$30
        jsl rlDecompressor
        rts

        .databank 0

      rsDecompressThraciaMapHighlight ; 8B/89C7

        .al
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>aThraciaMapHighlightTilemap
        stx DecompressionVariables.lSource
        lda #`aThraciaMapHighlightTilemap
        sta DecompressionVariables.lSource+2
        ldx #<>$7E7B88
        stx DecompressionVariables.lDest
        lda #`$7E7B88
        sta DecompressionVariables.lDest+2
        rep #$30
        jsl rlDecompressor
        rts

        .databank 0

      rsDecompressMiletosMapHighlight ; 8B/89E4

        .al
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>aMiletosMapHighlightTilemap
        stx DecompressionVariables.lSource
        lda #`aMiletosMapHighlightTilemap
        sta DecompressionVariables.lSource+2
        ldx #<>$7E7B88
        stx DecompressionVariables.lDest
        lda #`$7E7B88
        sta DecompressionVariables.lDest+2
        rep #$30
        jsl rlDecompressor
        rts

        .databank 0

      rsDecompressGrannvaleMapHighlight ; 8B/8A01

        .al
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>aGrannvaleMapHighlightTilemap
        stx DecompressionVariables.lSource
        lda #`aGrannvaleMapHighlightTilemap
        sta DecompressionVariables.lSource+2
        ldx #<>$7E7B88
        stx DecompressionVariables.lDest
        lda #`$7E7B88
        sta DecompressionVariables.lDest+2
        rep #$30
        jsl rlDecompressor
        rts

        .databank 0

      rsDecompressUnitedGrannvaleMapHighlight ; 8B/8A1E

        .al
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>aUnitedGrannvaleMapHighlightTilemap
        stx DecompressionVariables.lSource
        lda #`aUnitedGrannvaleMapHighlightTilemap
        sta DecompressionVariables.lSource+2
        ldx #<>$7E7B88
        stx DecompressionVariables.lDest
        lda #`$7E7B88
        sta DecompressionVariables.lDest+2
        rep #$30
        jsl rlDecompressor
        rts

        .databank 0

      rsDecompressUnifiedThraciaMapHighlight ; 8B/8A3B

        .al
        .autsiz
        .databank ?

        sep #$20
        rep #$10
        ldx #<>aUnifiedThraciaMapHighlightTilemap
        stx DecompressionVariables.lSource
        lda #`aUnifiedThraciaMapHighlightTilemap
        sta DecompressionVariables.lSource+2
        ldx #<>$7E7B88
        stx DecompressionVariables.lDest
        lda #`$7E7B88
        sta DecompressionVariables.lDest+2
        rep #$30
        jsl rlDecompressor
        rts

        .databank 0

        ; 8B/8A58

    .endsection WorldMapHighlightCodeSection


    .section ClearHighlightWorldMapPartSection

      .al
      .xl

      rlClearHighlightWorldMapPart ; 8B/8A84

        .al
        .autsiz
        .databank ?

        ldx #$07FE
        lda #$00FF

          -
          sta $7E7B88,x
          dec x
          dec x
          bpl -

        lda #0
        sta wBufferBG2HOFS
        lda #0
        sta wBufferBG2VOFS

        lda #(`procUnknown8B90D9)<<8
        sta lR44+1
        lda #<>procUnknown8B90D9
        sta lR44
        jsl rlProcEngineCreateProc
        rtl

        .databank 0

        ; 8B/8AAB

    .endsection ClearHighlightWorldMapPartSection
