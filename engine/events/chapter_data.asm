; Pointers to per-chapter event, location and UNIT group data, and the fields of
; structChapterEventData: locations, map changes, arena opponents
; (rlGetChapterArenaOpponentsPointer), talk events and the event flags that let an
; army take its phase (rlGetChapterFactionPhaseFlagsPointer).

    .section ChapterDataPointerSection

      .al
      .xl

      rlSetChapterEventDataPointer ; 81/B483

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda lR18+1
        sta lChapterEventDataPointer+1,b
        lda lR18
        sta lChapterEventDataPointer,b

        plp
        plb
        rtl

        .databank 0

      rlGetChapterLocationDataPointer ; 81/B494

        .al
        .autsiz
        .databank ?

        phy
        ldy lChapterEventDataPointer,b

        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20

        plb
        lda structChapterEventData.LocationDataPointer,b,y

        ply
        rtl

        .databank 0

      rlGetChapterMapChangesPointer ; 81/B4A6

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        phy

        lda lChapterEventDataPointer+1,b
        sta lR18+1

        ldy lChapterEventDataPointer,b
        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb

        lda structChapterEventData.MapChangesPointer,b,y
        sta lR18

        ply
        plp
        plb
        rtl

        .databank 0

        ; 81/B4C5

    .endsection ChapterDataPointerSection


    .section UNITGroupPointerSection

      .al
      .xl

      rlGetUNITGroupPointer ; 82/F4DE

        .al
        .autsiz
        .databank ?

        ; Input:
        ; A = UNIT group ID
        ; lR18 = UNIT data pointer

        ; Output:
        ; A = UNIT group entry pointer

        php
        phy
        phb

        dec a
        asl a
        clc
        adc lR18
        tay

        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb

        lda $0000,b,y
        plb
        clc
        adc lR18

        ply
        plp
        rtl

        .databank 0

        ; 82/F4F9

    .endsection UNITGroupPointerSection


    .section Unreferenced82F4F9Section

      .al
      .xl

      rlUnknown82F4F9 ; 82/F4F9

        ; Found by tools/sweep.py: nothing in the build reaches this.
        .al
        .xl
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        .databank $82
        phy
        dec a
        asl a
        clc
        adc lR18
        tay
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        .databank ?
        lda $0002,b,y
        sec
        sbc $0000,b,y
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 82/F517

    .endsection Unreferenced82F4F9Section
    .section Unsorted81B4C5Section

      .al
      .xl

      rlGetChapterArenaOpponentsPointer ; 81/B4C5

        .al
        .xl
        .autsiz
        .databank ?

        ; lR18 = the chapter's arena opponents table (structChapterEventData.ArenaOpponentsPointer).

        phb
        php
        phk
        plb
        .databank $81
        phy
        lda lChapterEventDataPointer+1,b
        sta lR18+1
        ldy lChapterEventDataPointer,b
        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structChapterEventData.ArenaOpponentsPointer,b,y
        sta lR18
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 81/B4E4

    .endsection Unsorted81B4C5Section


    .section Unsorted81B503Section

      .al
      .xl

      rlGetChapterFactionPhaseFlagsPointer ; 81/B503

        .al
        .xl
        .autsiz
        .databank ?

        ; lR18 = the chapter's table of event flags that let an army take its phase (structChapterEventData.FactionPhaseFlagsPointer).

        phb
        php
        phk
        plb
        .databank $81
        phy
        lda lChapterEventDataPointer+1,b
        sta lR18+1
        ldy lChapterEventDataPointer,b
        sep #$20
        lda lChapterEventDataPointer+2,b
        pha
        rep #$20
        plb
        .databank ?
        lda structChapterEventData.FactionPhaseFlagsPointer,b,y
        sta lR18
        ply
        plp
        plb
        .databank ?
        rtl

        .databank 0

        ; 81/B522

    .endsection Unsorted81B503Section


