; TODO: describe this file.

    .section Unsorted869CE4Section

      .al
      .xl

      rlUnknown869CE4 ; 86/9CE4

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda wActiveFactionSlot,b
        beq +

          lda #$0040
          tsb bUnknown000E7B,b
          stz wAIEngineCycleType,b

        +
        plp
        plb
        rtl

        .databank 0

      rlUnknown869CF9 ; 86/9CF9

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb
        lda bUnknown000E7B,b
        bit #$0001
        beq +

          lda #$0001
          trb bUnknown000E7B,b

        +
        plp
        plb
        rtl

        .databank 0

      rlUnknown869D0E ; 86/9D0E

        .al
        .autsiz
        .databank ?

        phb
        php
        phk
        plb

        lda #$0040
        trb bUnknown000E7B,b

        plp
        plb
        rtl

        .databank 0

        ; 86/9D1B

    .endsection Unsorted869CE4Section


    .section Unsorted86B39DSection

      .al
      .xl

      rsUnknown86B39D ; 86/B39D

        .al
        .autsiz
        .databank ?

        ldx $0871,b
        jsl rlUnknown84CE21
        lda #1
        trb $0E7B,b
        rts

        .databank 0

        ; 86/B3AB

    .endsection Unsorted86B39DSection
