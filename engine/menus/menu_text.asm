; Menu text helpers.

    .section GetMenuTextStringLengthSection

      .al
      .xl

      rlGetMenuTextStringLength ; 85/A205

        .al
        .autsiz
        .databank ?

        ; Input:
        ; lR18 = string pointer

        ; Output:
        ; wR10 = length

        pha
        phx
        phb
        php
        phk
        plb

        stz wR10

        ldx lR18
        sep #$20
        lda lR18+2
        pha
        rep #$20
        plb
        
          _Loop
          lda $0000,b,x
          beq _End

            inc x
            inc x
            inc wR10
            bra _Loop

        _End
        plp
        plb
        plx
        pla
        rtl

        .databank 0

        ; 85/A227

    .endsection GetMenuTextStringLengthSection
