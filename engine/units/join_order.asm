; The order in which units joined the army.

    .section JoinOrderSection

      .al
      .xl

      rlAddToUnitJoinOrder ; 8B/CDD8

        .al
        .autsiz
        .databank ?

        lda #FS_Player
        jsl rlGetFactionSlotUnitCount
        sta wR0

        jsl rlGetSelectedUnitGenerationID
        dec a
        tax

        lda wR0
        sep #$20
        sta aUnitJoinOrder[0],x
        rep #$20
        rtl

        .databank 0

      rlRemoveFromUnitJoinOrder ; 8B/CDF2

        .al
        .autsiz
        .databank ?

        jsl rlGetSelectedUnitGenerationID
        dec a
        tax
        lda aUnitJoinOrder[0],x
        and #$00FF
        sta wR2

        sep #$20
        lda #0
        sta aUnitJoinOrder[0],x
        rep #$20

        ldx #0

          -
          lda aUnitJoinOrder[0],x
          and #$00FF
          cmp wR2
          bcc +

            lda aUnitJoinOrder[0],x
            dec a
            sta aUnitJoinOrder[0],x

          +
          inc x
          cpx #len(aUnitJoinOrder)
          bne -

        rtl

        .databank 0

        ; 8B/CE29

    .endsection JoinOrderSection
