; Pointers to per-chapter event, location and UNIT group data.

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
