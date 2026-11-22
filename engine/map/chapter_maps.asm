; Chapter maps: for each chapter, the map and the graphics and data it is
; drawn with. rlLoadChapterMapLayout and rlLoadChapterMapGraphics load the entry for
; wCurrentChapter.

    .section ChapterMapsSection

      .al
      .xl

      aChapterMapPointers ; 88/9FC3

        ; One per chapter, prologue to final. Each entry has:
        ; - the layout: 64x64 words of tile IDs (compressed, to aMapData);
        ; - TileEntries: 1,024 tilemap words (compressed, to $7F0000); how the
        ;   map is drawn from them is not read yet;
        ; - the tile graphics (compressed 4bpp, to VRAM $2800);
        ; - the palettes (BG palettes 1-7, uncompressed);
        ; - six words: wUnknown00075C, $075E, wMapMinXScroll, wMapMinYScroll,
        ;   then the largest X and Y scroll plus $100 and $E0;
        ; - the terrain of each tile ID (compressed, to aTerrainTileset).

        .long aChapterMapPrologue
        .long aChapterMapChapter01
        .long aChapterMapChapter02
        .long aChapterMapChapter03
        .long aChapterMapChapter04
        .long aChapterMapChapter05
        .long aChapterMapChapter06
        .long aChapterMapChapter07
        .long aChapterMapChapter08
        .long aChapterMapChapter09
        .long aChapterMapChapter10
        .long aChapterMapFinal

      aChapterMapPrologue ; 88/9FE7

        .long acChapterMapPrologueLayout, acChapterMapPrologueTileEntries, g4bppcChapterMapPrologue, aChapterMapProloguePalette
        .word $0004, $0004, $0000, $0000, $0400, $0200
        .long acChapterMapPrologueTerrain

      aChapterMapChapter01 ; 88/A002

        .long acChapterMapChapter01Layout, acChapterMapChapter01TileEntries, g4bppcChapterMapChapter01, aChapterMapChapter01Palette
        .word $0004, $0004, $0000, $0000, $0400, $0400
        .long acChapterMapChapter01Terrain

      aChapterMapChapter02 ; 88/A01D

        .long acChapterMapChapter02Layout, acChapterMapPrologueTileEntries, g4bppcChapterMapPrologue, aChapterMapChapter02Palette
        .word $0004, $0004, $0000, $0000, $0400, $0400
        .long acChapterMapPrologueTerrain

      aChapterMapChapter03 ; 88/A038

        .long acChapterMapChapter03Layout, acChapterMapChapter03TileEntries, g4bppcChapterMapChapter03, aChapterMapChapter03Palette
        .word $0004, $0004, $0000, $0000, $0400, $0400
        .long acChapterMapChapter03Terrain

      aChapterMapChapter04 ; 88/A053

        .long acChapterMapChapter04Layout, acChapterMapChapter04TileEntries, g4bppcChapterMapChapter04, aChapterMapChapter04Palette
        .word $0004, $0004, $0000, $0000, $0400, $0400
        .long acChapterMapChapter04Terrain

      aChapterMapChapter05 ; 88/A06E

        .long acChapterMapChapter05Layout, acChapterMapChapter05TileEntries, g4bppcChapterMapChapter05, aChapterMapChapter05Palette
        .word $0004, $0004, $0000, $0000, $0400, $0400
        .long acChapterMapChapter05Terrain

      aChapterMapChapter06 ; 88/A089

        .long acChapterMapChapter06Layout, acChapterMapChapter06TileEntries, g4bppcChapterMapChapter06, aChapterMapChapter06Palette
        .word $0004, $0004, $0000, $0000, $0400, $0400
        .long acChapterMapChapter06Terrain

      aChapterMapChapter07 ; 88/A0A4

        .long acChapterMapChapter07Layout, acChapterMapChapter07TileEntries, g4bppcChapterMapChapter07, aChapterMapChapter07Palette
        .word $0004, $0004, $0000, $0000, $0400, $0400
        .long acChapterMapChapter07Terrain

      aChapterMapChapter08 ; 88/A0BF

        .long acChapterMapChapter08Layout, acChapterMapChapter08TileEntries, g4bppcChapterMapChapter08, aChapterMapChapter08Palette
        .word $0004, $0004, $0000, $0000, $0400, $0400
        .long acChapterMapChapter08Terrain

      aChapterMapChapter09 ; 88/A0DA

        .long acChapterMapChapter09Layout, acChapterMapChapter09TileEntries, g4bppcChapterMapChapter09, aChapterMapChapter09Palette
        .word $0004, $0004, $0000, $0000, $0400, $0400
        .long acChapterMapChapter09Terrain

      aChapterMapChapter10 ; 88/A0F5

        .long acChapterMapChapter10Layout, acChapterMapChapter10TileEntries, g4bppcChapterMapChapter10, aChapterMapChapter10Palette
        .word $0004, $0004, $0000, $0000, $0400, $0400
        .long acChapterMapChapter10Terrain

      aChapterMapFinal ; 88/A110

        .long acChapterMapFinalLayout, acChapterMapChapter05TileEntries, g4bppcChapterMapChapter05, aChapterMapFinalPalette
        .word $0004, $0004, $0000, $0000, $0400, $0400
        .long acChapterMapChapter05Terrain

    .endsection ChapterMapsSection
